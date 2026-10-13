; ROM bank $39: battle target choice
; The annotated listing of this bank is build/listing/bank39.asm.

SECTION "Bank 39", ROMX[$4000], BANK[$39]
    db $39

; wBattleActionId = wBattleActionChoice[2 * actor]; with mode = wSlotAIMode[actor], the entry at
; ActionTargetModeTable + 4 * mode holds two per-action routine tables, the second used for actors
; in slots 4-7 when wLinkMode is 0 or 2, the first otherwise; calls the routine for the action
; (JumpToWordAtHL), which writes a slot number to wBattleTargetChoice[2 * actor] (E-0061)
ChooseActionTarget::
    ld a, [wBattleActor]
    ld hl, wBattleActionChoice
    add a
    add_a_to_hl
    ld a, [hl]
    ld [wBattleActionId], a
    ld c, a
    ld b, $00
    ld a, [wBattleActor]
    ld hl, wSlotAIMode
    add_a_to_hl
    ld a, [hl]
    ld hl, ActionTargetModeTable
    add a
    add a
    add_a_to_hl
    ld a, [wLinkMode]
    or a
    jr z, .check_battle_actor
    cp $02
    jr z, .check_battle_actor
    xor a
    jr .skip

.check_battle_actor:
    ld a, [wBattleActor]
    and $04
    rrca

.skip:
    add_a_to_hl
    deref_hl
    add hl, bc
    add hl, bc
    call JumpToWordAtHL
    ret

; target = a present slot of the opposite three (slots 4-6 for actors 0-3, 0-2 for 4-7): the first
; present one, then each later present one replaces it when wRandomLo bit 7 is set after
; AdvanceRandom, so the last is favoured; $FF when none is present (E-0061)
TargetRandomFoe::
    ld a, [wBattleActor]
    and $04
    xor $04
    jp TargetRandomOtherSlot_Skip

; target = the slot in wSavedActionChoices + $1[2 * actor] when that slot is present, else
; TargetRandomFoe (E-0061)
TargetSavedSlotOrRandomFoe::
    ld a, [wBattleActor]
    add a
    ld hl, wSavedActionChoices + $1
    add_a_to_hl
    ld a, [hl]
    ld c, a
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, .read_battle_actor
    jr TargetRandomFoe

.read_battle_actor:
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    ld [hl], c
    ret

; target = the first present slot of the opposite three; base + 3 when none is present (E-0061)
TargetFirstFoe::
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, .read_battle_actor
    inc c
    dec b
    jr nz, .loop

.read_battle_actor:
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    ld [hl], c
    ret

; per-action target routine: A = the actor's side (slot 0 or 4), then the shared choice at $417C
; over that side's living slots (E-0219)
TargetRandomAlly::
    ld a, [wBattleActor]
    and $04
    jp TargetRandomOtherSlot_Skip

; target = the first present slot of the actor's own three (the actor included); base + 3 when none
; is present (E-0061)
TargetFirstAlly::
    ld a, [wBattleActor]
    and $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, .read_battle_actor
    inc c
    dec b
    jr nz, .loop

.read_battle_actor:
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    ld [hl], c
    ret

; target = one of the actor's own three slots by coin flips (wRandomLo bit 7), the later ones
; favoured; presence is not checked (E-0061)
TargetRandomAllySlot::
    ld a, [wBattleActor]
    and $04
    ld c, a
    ld b, $03
    ld d, c

.loop:
    call AdvanceRandom
    ld a, [wRandomLo]
    bit 7, a
    jr z, .next
    ld d, c

.next:
    inc c
    dec b
    jr nz, .loop
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    ld [hl], d
    ret

; per-action target routine (ActionTargetRoutines tables): a random living slot on the actor's side
; other than the actor (the first such slot when no coin flip picks one), else the side's first slot
; (E-0219)
TargetRandomOtherAlly::
    ld a, [wBattleActor]
    ld e, a
    and $04
    ld c, a
    ld b, $03
    ld d, $ff

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    cp e
    jr z, .next
    ld a, d
    cp $ff
    jr nz, .call_advance_random
    ld d, c
    jr .next

.call_advance_random:
    call AdvanceRandom
    ld a, [wRandomLo]
    bit 7, a
    jr z, .next
    ld d, c

.next:
    inc c
    dec b
    jr nz, .loop
    ld a, d
    cp $ff
    jr nz, .read_battle_actor
    ld a, e
    and $04
    ld d, a

.read_battle_actor:
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    ld [hl], d
    ret

; target = wBattleActor; the per-action entry used most often (334 table entries) (E-0061)
TargetSelf::
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    ld a, [wBattleActor]
    ld [hl], a
    ret

; target = wBattleActor & 4, slot 0 or 4 of the actor's side; presence is not checked (E-0061)
TargetOwnSideFirstSlot::
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    ld a, [wBattleActor]
    and $04
    ld [hl], a
    ret

; target = a random slot (wRandomLo & 7 after AdvanceRandom) that is not the actor, is present and
; is not slot 3 or 7; retries until one is found (E-0061)
TargetRandomOtherSlot::
    ld a, [wBattleActor]
    ld e, a

.loop:
    call AdvanceRandom
    ld a, [wRandomLo]
    and $07
    cp e
    jr z, .loop
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .loop
    and $03
    cp $03
    jr z, .loop
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    ld a, [wRandomLo]
    and $07
    ld [hl], a
    ret

TargetRandomOtherSlot_Skip::
    ld c, a
    ld b, $03
    ld d, $ff

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, d
    cp $ff
    jr nz, .call_advance_random
    ld d, c
    jr .next

.call_advance_random:
    call AdvanceRandom
    ld a, [wRandomLo]
    bit 7, a
    jr z, .next
    ld d, c

.next:
    inc c
    dec b
    jr nz, .loop
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    ld [hl], d
    ret

; ChooseActionTarget reads the record at $41AC + 4 * wSlotAIMode[actor] and takes the second word
; for battlers 4-7 when wLinkMode is 0 or 2, else the first; it then calls entry wBattleActionId of
; that table through JumpToWordAtHL (E-0219, C1)
; record: two tables of per-action target routines
ActionTargetModeTable::
    dw ActionTargetRoutines0 ; id 0
    dw ActionTargetRoutines1
    dw ActionTargetRoutines2 ; id 1
    dw ActionTargetRoutines3
    dw ActionTargetRoutines4 ; id 2
    dw ActionTargetRoutines5
    dw ActionTargetRoutines6 ; id 3
    dw ActionTargetRoutines7
    dw ActionTargetRoutines8 ; id 4
    dw ActionTargetRoutines9

; table 0 of ActionTargetModeTable (mode 0, near side); 228 code words, one per action id, as
; SkillTable (E-0204) (E-0219, C1)
; record: target routine for this action id
ActionTargetRoutines0::
    dw TargetRandomFoe ; id 0
    dw TargetRandomFoe ; id 1
    dw TargetRandomFoe ; id 2
    dw TargetRandomFoe ; id 3
    dw TargetFirstFoe ; id 4
    dw TargetFirstFoe ; id 5
    dw TargetFirstFoe ; id 6
    dw TargetFirstFoe ; id 7
    dw TargetFirstFoe ; id 8
    dw TargetFirstFoe ; id 9
    dw TargetFirstFoe ; id 10
    dw TargetFirstFoe ; id 11
    dw TargetFirstFoe ; id 12
    dw TargetFirstFoe ; id 13
    dw TargetFirstFoe ; id 14
    dw TargetFirstFoe ; id 15
    dw TargetFirstFoe ; id 16
    dw TargetFirstFoe ; id 17
    dw TargetFirstFoe ; id 18
    dw TargetRandomFoe ; id 19
    dw TargetFirstFoe ; id 20
    dw TargetFirstFoe ; id 21
    dw TargetRandomAlly ; id 22
    dw TargetRandomAlly ; id 23
    dw TargetRandomAlly ; id 24
    dw TargetFirstAlly ; id 25
    dw TargetFirstAlly ; id 26
    dw TargetRandomOtherAlly ; id 27
    dw TargetRandomOtherAlly ; id 28
    dw TargetRandomOtherAlly ; id 29
    dw TargetRandomAllySlot ; id 30
    dw TargetRandomAllySlot ; id 31
    dw TargetOwnSideFirstSlot ; id 32
    dw TargetRandomAlly ; id 33
    dw TargetRandomAlly ; id 34
    dw TargetRandomAlly ; id 35
    dw TargetRandomAlly ; id 36
    dw TargetRandomAlly ; id 37
    dw TargetFirstAlly ; id 38
    dw TargetRandomFoe ; id 39
    dw TargetFirstFoe ; id 40
    dw TargetRandomAlly ; id 41
    dw TargetFirstAlly ; id 42
    dw TargetRandomFoe ; id 43
    dw TargetFirstFoe ; id 44
    dw TargetRandomAlly ; id 45
    dw TargetFirstFoe ; id 46
    dw TargetRandomFoe ; id 47
    dw TargetFirstFoe ; id 48
    dw TargetSelf ; id 49
    dw TargetRandomFoe ; id 50
    dw TargetFirstFoe ; id 51
    dw TargetFirstFoe ; id 52
    dw TargetFirstAlly ; id 53
    dw TargetSelf ; id 54
    dw TargetSelf ; id 55
    dw TargetFirstAlly ; id 56
    dw TargetFirstAlly ; id 57
    dw TargetRandomFoe ; id 58
    dw TargetSelf ; id 59
    dw TargetSelf ; id 60
    dw TargetRandomFoe ; id 61
    dw TargetFirstFoe ; id 62
    dw TargetFirstFoe ; id 63
    dw TargetFirstFoe ; id 64
    dw TargetFirstFoe ; id 65
    dw TargetFirstFoe ; id 66
    dw TargetFirstFoe ; id 67
    dw TargetFirstFoe ; id 68
    dw TargetFirstFoe ; id 69
    dw TargetFirstFoe ; id 70
    dw TargetFirstFoe ; id 71
    dw TargetRandomFoe ; id 72
    dw TargetFirstFoe ; id 73
    dw TargetFirstFoe ; id 74
    dw TargetFirstFoe ; id 75
    dw TargetRandomFoe ; id 76
    dw TargetFirstFoe ; id 77
    dw TargetRandomFoe ; id 78
    dw TargetRandomFoe ; id 79
    dw TargetRandomFoe ; id 80
    dw TargetRandomFoe ; id 81
    dw TargetRandomFoe ; id 82
    dw TargetRandomFoe ; id 83
    dw TargetRandomFoe ; id 84
    dw TargetRandomFoe ; id 85
    dw TargetRandomFoe ; id 86
    dw TargetRandomFoe ; id 87
    dw TargetRandomFoe ; id 88
    dw TargetRandomFoe ; id 89
    dw TargetRandomFoe ; id 90
    dw TargetRandomFoe ; id 91
    dw TargetRandomFoe ; id 92
    dw TargetRandomFoe ; id 93
    dw TargetRandomFoe ; id 94
    dw TargetRandomFoe ; id 95
    dw TargetRandomFoe ; id 96
    dw TargetRandomFoe ; id 97
    dw TargetRandomFoe ; id 98
    dw TargetRandomFoe ; id 99
    dw TargetRandomFoe ; id 100
    dw TargetFirstFoe ; id 101
    dw TargetFirstFoe ; id 102
    dw TargetRandomFoe ; id 103
    dw TargetSelf ; id 104
    dw TargetRandomFoe ; id 105
    dw TargetRandomFoe ; id 106
    dw TargetRandomFoe ; id 107
    dw TargetRandomOtherSlot ; id 108
    dw TargetRandomFoe ; id 109
    dw TargetRandomFoe ; id 110
    dw TargetRandomFoe ; id 111
    dw TargetRandomFoe ; id 112
    dw TargetFirstFoe ; id 113
    dw TargetFirstFoe ; id 114
    dw TargetFirstFoe ; id 115
    dw TargetFirstFoe ; id 116
    dw TargetFirstFoe ; id 117
    dw TargetRandomFoe ; id 118
    dw TargetRandomFoe ; id 119
    dw TargetFirstFoe ; id 120
    dw TargetFirstFoe ; id 121
    dw TargetFirstFoe ; id 122
    dw TargetOwnSideFirstSlot ; id 123
    dw TargetFirstAlly ; id 124
    dw TargetSelf ; id 125
    dw TargetFirstFoe ; id 126
    dw TargetFirstFoe ; id 127
    dw TargetFirstFoe ; id 128
    dw TargetFirstAlly ; id 129
    dw TargetRandomFoe ; id 130
    dw TargetFirstFoe ; id 131
    dw TargetFirstFoe ; id 132
    dw TargetSelf ; id 133
    dw TargetSelf ; id 134
    dw TargetSelf ; id 135
    dw TargetSelf ; id 136
    dw TargetSelf ; id 137
    dw TargetSelf ; id 138
    dw TargetRandomFoe ; id 139
    dw TargetRandomFoe ; id 140
    dw TargetRandomFoe ; id 141
    dw TargetFirstFoe ; id 142
    dw TargetRandomFoe ; id 143
    dw TargetFirstFoe ; id 144
    dw TargetRandomFoe ; id 145
    dw TargetFirstFoe ; id 146
    dw TargetRandomFoe ; id 147
    dw TargetSelf ; id 148
    dw TargetSelf ; id 149
    dw TargetSelf ; id 150
    dw TargetRandomOtherAlly ; id 151
    dw TargetFirstAlly ; id 152
    dw TargetSelf ; id 153
    dw TargetFirstAlly ; id 154
    dw TargetSelf ; id 155
    dw TargetSelf ; id 156
    dw TargetSelf ; id 157
    dw TargetSelf ; id 158
    dw TargetSelf ; id 159
    dw TargetSelf ; id 160
    dw TargetSelf ; id 161
    dw $0000 ; id 162
    dw $0000 ; id 163
    dw $0000 ; id 164
    dw $0000 ; id 165
    dw $0000 ; id 166
    dw $0000 ; id 167
    dw $0000 ; id 168
    dw $0000 ; id 169
    dw TargetRandomFoe ; id 170
    dw TargetSelf ; id 171
    dw TargetSelf ; id 172
    dw $0000 ; id 173
    dw $0000 ; id 174
    dw $0000 ; id 175
    dw TargetFirstFoe ; id 176
    dw TargetFirstAlly ; id 177
    dw TargetFirstFoe ; id 178
    dw TargetFirstFoe ; id 179
    dw TargetFirstAlly ; id 180
    dw TargetFirstFoe ; id 181
    dw TargetFirstFoe ; id 182
    dw TargetSelf ; id 183
    dw TargetSelf ; id 184
    dw TargetFirstFoe ; id 185
    dw TargetFirstFoe ; id 186
    dw TargetOwnSideFirstSlot ; id 187
    dw TargetFirstAlly ; id 188
    dw TargetFirstFoe ; id 189
    dw $0000 ; id 190
    dw TargetSelf ; id 191
    dw TargetRandomOtherAlly ; id 192
    dw TargetRandomFoe ; id 193
    dw TargetSelf ; id 194
    dw TargetSelf ; id 195
    dw TargetSelf ; id 196
    dw TargetSelf ; id 197
    dw TargetSelf ; id 198
    dw TargetSelf ; id 199
    dw TargetSelf ; id 200
    dw TargetSelf ; id 201
    dw TargetSelf ; id 202
    dw TargetSelf ; id 203
    dw TargetSavedSlotOrRandomFoe ; id 204
    dw TargetSelf ; id 205
    dw TargetOwnSideFirstSlot ; id 206
    dw TargetFirstAlly ; id 207
    dw TargetFirstFoe ; id 208
    dw TargetRandomFoe ; id 209
    dw TargetRandomFoe ; id 210
    dw TargetRandomFoe ; id 211
    dw TargetRandomFoe ; id 212
    dw TargetFirstFoe ; id 213
    dw TargetFirstFoe ; id 214
    dw TargetRandomFoe ; id 215
    dw TargetRandomFoe ; id 216
    dw TargetFirstFoe ; id 217
    dw TargetFirstAlly ; id 218
    dw TargetFirstFoe ; id 219
    dw TargetSelf ; id 220
    dw TargetFirstAlly ; id 221
    dw TargetFirstFoe ; id 222
    dw TargetRandomFoe ; id 223
    dw TargetSelf ; id 224
    dw TargetFirstFoe ; id 225
    dw TargetSelf ; id 226
    dw TargetSelf ; id 227

; table 1 of ActionTargetModeTable (mode 0, far side); 228 code words, one per action id, as
; SkillTable (E-0204) (E-0219, C1)
ActionTargetRoutines1::
    dw TargetRandomFoe ; id 0
    dw TargetRandomFoe ; id 1
    dw TargetRandomFoe ; id 2
    dw TargetRandomFoe ; id 3
    dw TargetFirstFoe ; id 4
    dw TargetFirstFoe ; id 5
    dw TargetFirstFoe ; id 6
    dw TargetFirstFoe ; id 7
    dw TargetFirstFoe ; id 8
    dw TargetFirstFoe ; id 9
    dw TargetFirstFoe ; id 10
    dw TargetFirstFoe ; id 11
    dw TargetFirstFoe ; id 12
    dw TargetFirstFoe ; id 13
    dw TargetFirstFoe ; id 14
    dw TargetFirstFoe ; id 15
    dw TargetFirstFoe ; id 16
    dw TargetFirstFoe ; id 17
    dw TargetFirstFoe ; id 18
    dw TargetRandomFoe ; id 19
    dw TargetFirstFoe ; id 20
    dw TargetFirstFoe ; id 21
    dw TargetRandomAlly ; id 22
    dw TargetRandomAlly ; id 23
    dw TargetRandomAlly ; id 24
    dw TargetFirstAlly ; id 25
    dw TargetFirstAlly ; id 26
    dw TargetRandomOtherAlly ; id 27
    dw TargetRandomOtherAlly ; id 28
    dw TargetRandomOtherAlly ; id 29
    dw TargetRandomAllySlot ; id 30
    dw TargetRandomAllySlot ; id 31
    dw TargetOwnSideFirstSlot ; id 32
    dw TargetRandomAlly ; id 33
    dw TargetRandomAlly ; id 34
    dw TargetRandomAlly ; id 35
    dw TargetRandomAlly ; id 36
    dw TargetRandomAlly ; id 37
    dw TargetFirstAlly ; id 38
    dw TargetRandomFoe ; id 39
    dw TargetFirstFoe ; id 40
    dw TargetRandomAlly ; id 41
    dw TargetFirstAlly ; id 42
    dw TargetRandomFoe ; id 43
    dw TargetFirstFoe ; id 44
    dw TargetRandomAlly ; id 45
    dw TargetFirstFoe ; id 46
    dw TargetRandomFoe ; id 47
    dw TargetFirstFoe ; id 48
    dw TargetSelf ; id 49
    dw TargetRandomFoe ; id 50
    dw TargetFirstFoe ; id 51
    dw $0000 ; id 52
    dw $0000 ; id 53
    dw TargetSelf ; id 54
    dw TargetSelf ; id 55
    dw TargetFirstAlly ; id 56
    dw TargetFirstAlly ; id 57
    dw TargetRandomFoe ; id 58
    dw TargetSelf ; id 59
    dw TargetSelf ; id 60
    dw TargetRandomFoe ; id 61
    dw TargetFirstFoe ; id 62
    dw TargetFirstFoe ; id 63
    dw TargetFirstFoe ; id 64
    dw TargetFirstFoe ; id 65
    dw TargetFirstFoe ; id 66
    dw TargetFirstFoe ; id 67
    dw TargetFirstFoe ; id 68
    dw TargetFirstFoe ; id 69
    dw TargetFirstFoe ; id 70
    dw TargetFirstFoe ; id 71
    dw TargetRandomFoe ; id 72
    dw TargetFirstFoe ; id 73
    dw TargetFirstFoe ; id 74
    dw TargetFirstFoe ; id 75
    dw TargetRandomFoe ; id 76
    dw TargetFirstFoe ; id 77
    dw TargetRandomFoe ; id 78
    dw TargetRandomFoe ; id 79
    dw TargetRandomFoe ; id 80
    dw TargetRandomFoe ; id 81
    dw TargetRandomFoe ; id 82
    dw TargetRandomFoe ; id 83
    dw TargetRandomFoe ; id 84
    dw TargetRandomFoe ; id 85
    dw TargetRandomFoe ; id 86
    dw TargetRandomFoe ; id 87
    dw TargetRandomFoe ; id 88
    dw TargetRandomFoe ; id 89
    dw TargetRandomFoe ; id 90
    dw TargetRandomFoe ; id 91
    dw TargetRandomFoe ; id 92
    dw TargetRandomFoe ; id 93
    dw TargetRandomFoe ; id 94
    dw TargetRandomFoe ; id 95
    dw TargetRandomFoe ; id 96
    dw TargetRandomFoe ; id 97
    dw TargetRandomFoe ; id 98
    dw TargetRandomFoe ; id 99
    dw TargetRandomFoe ; id 100
    dw TargetFirstFoe ; id 101
    dw TargetFirstFoe ; id 102
    dw TargetRandomFoe ; id 103
    dw TargetSelf ; id 104
    dw TargetRandomFoe ; id 105
    dw TargetRandomFoe ; id 106
    dw TargetRandomFoe ; id 107
    dw TargetRandomOtherSlot ; id 108
    dw TargetRandomFoe ; id 109
    dw TargetRandomFoe ; id 110
    dw TargetRandomFoe ; id 111
    dw TargetRandomFoe ; id 112
    dw TargetFirstFoe ; id 113
    dw TargetFirstFoe ; id 114
    dw TargetFirstFoe ; id 115
    dw TargetFirstFoe ; id 116
    dw TargetFirstFoe ; id 117
    dw TargetRandomFoe ; id 118
    dw TargetRandomFoe ; id 119
    dw TargetFirstFoe ; id 120
    dw TargetFirstFoe ; id 121
    dw TargetFirstFoe ; id 122
    dw TargetOwnSideFirstSlot ; id 123
    dw TargetFirstAlly ; id 124
    dw TargetSelf ; id 125
    dw TargetFirstFoe ; id 126
    dw TargetFirstFoe ; id 127
    dw TargetFirstFoe ; id 128
    dw TargetFirstAlly ; id 129
    dw TargetRandomFoe ; id 130
    dw TargetFirstFoe ; id 131
    dw TargetFirstFoe ; id 132
    dw TargetSelf ; id 133
    dw TargetSelf ; id 134
    dw TargetSelf ; id 135
    dw TargetSelf ; id 136
    dw TargetSelf ; id 137
    dw TargetSelf ; id 138
    dw TargetRandomFoe ; id 139
    dw TargetRandomFoe ; id 140
    dw TargetRandomFoe ; id 141
    dw TargetFirstFoe ; id 142
    dw TargetRandomFoe ; id 143
    dw TargetFirstFoe ; id 144
    dw TargetRandomFoe ; id 145
    dw TargetFirstFoe ; id 146
    dw TargetRandomFoe ; id 147
    dw TargetSelf ; id 148
    dw TargetSelf ; id 149
    dw TargetSelf ; id 150
    dw TargetRandomOtherAlly ; id 151
    dw TargetFirstAlly ; id 152
    dw TargetSelf ; id 153
    dw TargetFirstAlly ; id 154
    dw TargetSelf ; id 155
    dw TargetSelf ; id 156
    dw TargetSelf ; id 157
    dw TargetSelf ; id 158
    dw TargetSelf ; id 159
    dw TargetSelf ; id 160
    dw TargetSelf ; id 161
    dw $0000 ; id 162
    dw $0000 ; id 163
    dw $0000 ; id 164
    dw $0000 ; id 165
    dw $0000 ; id 166
    dw $0000 ; id 167
    dw $0000 ; id 168
    dw $0000 ; id 169
    dw TargetRandomFoe ; id 170
    dw TargetSelf ; id 171
    dw TargetSelf ; id 172
    dw TargetRandomFoe ; id 173
    dw TargetSelf ; id 174
    dw $0000 ; id 175
    dw TargetFirstFoe ; id 176
    dw TargetFirstAlly ; id 177
    dw TargetFirstFoe ; id 178
    dw TargetFirstFoe ; id 179
    dw TargetFirstAlly ; id 180
    dw TargetFirstFoe ; id 181
    dw TargetFirstFoe ; id 182
    dw TargetSelf ; id 183
    dw TargetSelf ; id 184
    dw TargetFirstFoe ; id 185
    dw TargetFirstFoe ; id 186
    dw TargetOwnSideFirstSlot ; id 187
    dw TargetFirstAlly ; id 188
    dw TargetFirstFoe ; id 189
    dw $0000 ; id 190
    dw TargetSelf ; id 191
    dw TargetRandomOtherAlly ; id 192
    dw TargetRandomFoe ; id 193
    dw TargetSelf ; id 194
    dw TargetSelf ; id 195
    dw TargetSelf ; id 196
    dw TargetSelf ; id 197
    dw TargetSelf ; id 198
    dw TargetSelf ; id 199
    dw TargetSelf ; id 200
    dw TargetSelf ; id 201
    dw TargetSelf ; id 202
    dw TargetSelf ; id 203
    dw TargetRandomFoe ; id 204
    dw TargetSelf ; id 205
    dw TargetOwnSideFirstSlot ; id 206
    dw TargetFirstAlly ; id 207
    dw TargetFirstFoe ; id 208
    dw TargetRandomFoe ; id 209
    dw TargetRandomFoe ; id 210
    dw TargetRandomFoe ; id 211
    dw TargetRandomFoe ; id 212
    dw TargetFirstFoe ; id 213
    dw TargetFirstFoe ; id 214
    dw TargetRandomFoe ; id 215
    dw TargetRandomFoe ; id 216
    dw TargetFirstFoe ; id 217
    dw TargetFirstAlly ; id 218
    dw TargetFirstFoe ; id 219
    dw TargetSelf ; id 220
    dw TargetFirstAlly ; id 221
    dw TargetFirstFoe ; id 222
    dw TargetRandomFoe ; id 223
    dw TargetSelf ; id 224
    dw TargetFirstFoe ; id 225
    dw TargetSelf ; id 226
    dw TargetSelf ; id 227

; table 2 of ActionTargetModeTable (mode 1, near side); 228 code words, one per action id, as
; SkillTable (E-0204) (E-0219, C1)
ActionTargetRoutines2::
    dw TargetFoeWeightedBySlotOrder ; id 0
    dw TargetFoeWeightedBySlotOrder ; id 1
    dw TargetFoeWeightedBySlotOrder ; id 2
    dw TargetFoeWeightedBySlotOrder ; id 3
    dw TargetFirstFoe ; id 4
    dw TargetFirstFoe ; id 5
    dw TargetFirstFoe ; id 6
    dw TargetFirstFoe ; id 7
    dw TargetFirstFoe ; id 8
    dw TargetFirstFoe ; id 9
    dw TargetFirstFoe ; id 10
    dw TargetFirstFoe ; id 11
    dw TargetFirstFoe ; id 12
    dw TargetFirstFoe ; id 13
    dw TargetFirstFoe ; id 14
    dw TargetFirstFoe ; id 15
    dw TargetFirstFoe ; id 16
    dw TargetFirstFoe ; id 17
    dw TargetFirstFoe ; id 18
    dw TargetFoeWeightedBySlotOrder ; id 19
    dw TargetFirstFoe ; id 20
    dw TargetFirstFoe ; id 21
    dw ChooseTarget_Heal_6C75 ; id 22
    dw ChooseTarget_Heal_6C75 ; id 23
    dw ChooseTarget_Heal_6C75 ; id 24
    dw TargetFirstAlly ; id 25
    dw TargetFirstAlly ; id 26
    dw ChooseTarget_MPass ; id 27
    dw ChooseTarget_MPass ; id 28
    dw ChooseTarget_MPass ; id 29
    dw TargetRandomAllySlot ; id 30
    dw TargetRandomAllySlot ; id 31
    dw TargetOwnSideFirstSlot ; id 32
    dw ChooseTarget_Antidote_6AFD ; id 33
    dw TargetFirstAlly ; id 34
    dw TargetFirstAlly ; id 35
    dw TargetFirstAlly ; id 36
    dw ChooseTarget_Upper_6B0A ; id 37
    dw TargetFirstAlly ; id 38
    dw ChooseTarget_Sap_6BB0 ; id 39
    dw TargetFirstFoe ; id 40
    dw ChooseTarget_Speed_6B5D ; id 41
    dw TargetFirstAlly ; id 42
    dw TargetByAllyAGL ; id 43
    dw TargetFirstFoe ; id 44
    dw TargetRandomAlly ; id 45
    dw TargetFirstFoe ; id 46
    dw TargetFoeWeightedBySlotOrder ; id 47
    dw TargetFirstFoe ; id 48
    dw TargetSelf ; id 49
    dw TargetRandomFoe ; id 50
    dw TargetFirstFoe ; id 51
    dw TargetFirstFoe ; id 52
    dw TargetFirstAlly ; id 53
    dw TargetSelf ; id 54
    dw TargetSelf ; id 55
    dw TargetFirstAlly ; id 56
    dw TargetFirstAlly ; id 57
    dw TargetRandomFoe ; id 58
    dw TargetSelf ; id 59
    dw TargetSelf ; id 60
    dw TargetFoeWeightedBySlotOrder ; id 61
    dw TargetFirstFoe ; id 62
    dw TargetFirstFoe ; id 63
    dw TargetFirstFoe ; id 64
    dw TargetFirstFoe ; id 65
    dw TargetFirstFoe ; id 66
    dw TargetFirstFoe ; id 67
    dw TargetFirstFoe ; id 68
    dw TargetFirstFoe ; id 69
    dw TargetFirstFoe ; id 70
    dw TargetFirstFoe ; id 71
    dw TargetFoeWeightedBySlotOrder ; id 72
    dw TargetFirstFoe ; id 73
    dw TargetFirstFoe ; id 74
    dw TargetFirstFoe ; id 75
    dw TargetFoeWeightedBySlotOrder ; id 76
    dw TargetFirstFoe ; id 77
    dw TargetRandomFoe ; id 78
    dw TargetRandomFoe ; id 79
    dw TargetFoeWeightedBySlotOrder ; id 80
    dw TargetFoeWeightedBySlotOrder ; id 81
    dw TargetFoeWeightedBySlotOrder ; id 82
    dw TargetFoeWeightedBySlotOrder ; id 83
    dw TargetFoeWeightedBySlotOrder ; id 84
    dw TargetFoeWeightedBySlotOrder ; id 85
    dw TargetFoeWeightedBySlotOrder ; id 86
    dw TargetFoeWeightedBySlotOrder ; id 87
    dw TargetFoeWeightedBySlotOrder ; id 88
    dw TargetFoeWeightedBySlotOrder ; id 89
    dw TargetFoeWeightedBySlotOrder ; id 90
    dw TargetFoeWeightedBySlotOrder ; id 91
    dw TargetFoeWeightedBySlotOrder ; id 92
    dw TargetFoeWeightedBySlotOrder ; id 93
    dw TargetFoeWeightedBySlotOrder ; id 94
    dw TargetFoeWeightedBySlotOrder ; id 95
    dw TargetFoeWeightedBySlotOrder ; id 96
    dw TargetFoeWeightedBySlotOrder ; id 97
    dw TargetFoeWeightedBySlotOrder ; id 98
    dw TargetFoeWeightedBySlotOrder ; id 99
    dw TargetRandomFoe ; id 100
    dw TargetFirstFoe ; id 101
    dw TargetFirstFoe ; id 102
    dw TargetFoeWeightedBySlotOrder ; id 103
    dw TargetSelf ; id 104
    dw TargetFoeWeightedBySlotOrder ; id 105
    dw TargetFoeWeightedBySlotOrder ; id 106
    dw TargetFoeWeightedBySlotOrder ; id 107
    dw TargetRandomOtherSlot ; id 108
    dw TargetFoeWeightedBySlotOrder ; id 109
    dw TargetFoeWeightedBySlotOrder ; id 110
    dw TargetFoeWeightedBySlotOrder ; id 111
    dw TargetFoeWeightedBySlotOrder ; id 112
    dw TargetFirstFoe ; id 113
    dw TargetFirstFoe ; id 114
    dw TargetFirstFoe ; id 115
    dw TargetFirstFoe ; id 116
    dw TargetFirstFoe ; id 117
    dw TargetRandomFoe ; id 118
    dw TargetRandomFoe ; id 119
    dw TargetFirstFoe ; id 120
    dw TargetFirstFoe ; id 121
    dw TargetFirstFoe ; id 122
    dw TargetOwnSideFirstSlot ; id 123
    dw TargetFirstAlly ; id 124
    dw TargetSelf ; id 125
    dw TargetFirstFoe ; id 126
    dw TargetFirstFoe ; id 127
    dw TargetFirstFoe ; id 128
    dw TargetFirstAlly ; id 129
    dw TargetRandomFoe ; id 130
    dw TargetFirstFoe ; id 131
    dw TargetFirstFoe ; id 132
    dw TargetSelf ; id 133
    dw TargetSelf ; id 134
    dw TargetSelf ; id 135
    dw TargetSelf ; id 136
    dw TargetSelf ; id 137
    dw TargetSelf ; id 138
    dw TargetFoeWeightedBySlotOrder ; id 139
    dw TargetFoeWeightedBySlotOrder ; id 140
    dw TargetFoeWeightedBySlotOrder ; id 141
    dw TargetFirstFoe ; id 142
    dw TargetFoeWeightedBySlotOrder ; id 143
    dw TargetFirstFoe ; id 144
    dw TargetRandomFoe ; id 145
    dw TargetFirstFoe ; id 146
    dw TargetFoeWeightedBySlotOrder ; id 147
    dw TargetSelf ; id 148
    dw TargetSelf ; id 149
    dw TargetSelf ; id 150
    dw TargetRandomOtherAlly ; id 151
    dw TargetFirstAlly ; id 152
    dw TargetSelf ; id 153
    dw TargetFirstAlly ; id 154
    dw TargetSelf ; id 155
    dw TargetSelf ; id 156
    dw TargetSelf ; id 157
    dw TargetSelf ; id 158
    dw TargetSelf ; id 159
    dw TargetSelf ; id 160
    dw TargetSelf ; id 161
    dw $0000 ; id 162
    dw $0000 ; id 163
    dw $0000 ; id 164
    dw $0000 ; id 165
    dw $0000 ; id 166
    dw $0000 ; id 167
    dw $0000 ; id 168
    dw $0000 ; id 169
    dw TargetRandomFoe ; id 170
    dw TargetSelf ; id 171
    dw TargetSelf ; id 172
    dw $0000 ; id 173
    dw $0000 ; id 174
    dw $0000 ; id 175
    dw TargetFirstFoe ; id 176
    dw TargetFirstAlly ; id 177
    dw TargetFirstFoe ; id 178
    dw TargetFirstFoe ; id 179
    dw TargetFirstAlly ; id 180
    dw TargetFirstFoe ; id 181
    dw TargetFirstFoe ; id 182
    dw TargetSelf ; id 183
    dw TargetSelf ; id 184
    dw TargetFirstFoe ; id 185
    dw TargetFirstFoe ; id 186
    dw TargetOwnSideFirstSlot ; id 187
    dw TargetFirstAlly ; id 188
    dw TargetFirstFoe ; id 189
    dw $0000 ; id 190
    dw TargetSelf ; id 191
    dw TargetRandomOtherAlly ; id 192
    dw TargetRandomFoe ; id 193
    dw TargetSelf ; id 194
    dw TargetSelf ; id 195
    dw TargetSelf ; id 196
    dw TargetSelf ; id 197
    dw TargetSelf ; id 198
    dw TargetSelf ; id 199
    dw TargetSelf ; id 200
    dw TargetSelf ; id 201
    dw TargetSelf ; id 202
    dw TargetSelf ; id 203
    dw TargetSavedSlotOrRandomFoe ; id 204
    dw TargetSelf ; id 205
    dw TargetOwnSideFirstSlot ; id 206
    dw TargetFirstAlly ; id 207
    dw TargetFirstFoe ; id 208
    dw TargetFoeWeightedBySlotOrder ; id 209
    dw TargetFoeWeightedBySlotOrder ; id 210
    dw TargetFoeWeightedBySlotOrder ; id 211
    dw TargetFoeWeightedBySlotOrder ; id 212
    dw TargetFirstFoe ; id 213
    dw TargetFirstFoe ; id 214
    dw TargetFoeWeightedBySlotOrder ; id 215
    dw TargetFoeWeightedBySlotOrder ; id 216
    dw TargetFirstFoe ; id 217
    dw TargetFirstAlly ; id 218
    dw TargetFirstFoe ; id 219
    dw TargetSelf ; id 220
    dw TargetFirstAlly ; id 221
    dw TargetFirstFoe ; id 222
    dw TargetFoeWeightedBySlotOrder ; id 223
    dw TargetSelf ; id 224
    dw TargetFirstFoe ; id 225
    dw TargetSelf ; id 226
    dw TargetSelf ; id 227

; table 3 of ActionTargetModeTable (mode 1, far side); 228 code words, one per action id, as
; SkillTable (E-0204) (E-0219, C1)
ActionTargetRoutines3::
    dw TargetFoeWeightedBySlotOrder ; id 0
    dw TargetFoeWeightedBySlotOrder ; id 1
    dw TargetFoeWeightedBySlotOrder ; id 2
    dw TargetFoeWeightedBySlotOrder ; id 3
    dw TargetFirstFoe ; id 4
    dw TargetFirstFoe ; id 5
    dw TargetFirstFoe ; id 6
    dw TargetFirstFoe ; id 7
    dw TargetFirstFoe ; id 8
    dw TargetFirstFoe ; id 9
    dw TargetFirstFoe ; id 10
    dw TargetFirstFoe ; id 11
    dw TargetFirstFoe ; id 12
    dw TargetFirstFoe ; id 13
    dw TargetFirstFoe ; id 14
    dw TargetFirstFoe ; id 15
    dw TargetFirstFoe ; id 16
    dw TargetFirstFoe ; id 17
    dw TargetFirstFoe ; id 18
    dw TargetFoeWeightedBySlotOrder ; id 19
    dw TargetFirstFoe ; id 20
    dw TargetFirstFoe ; id 21
    dw ChooseTarget_Heal_6C75 ; id 22
    dw ChooseTarget_Heal_6C75 ; id 23
    dw ChooseTarget_Heal_6C75 ; id 24
    dw TargetFirstAlly ; id 25
    dw TargetFirstAlly ; id 26
    dw ChooseTarget_MPass ; id 27
    dw ChooseTarget_MPass ; id 28
    dw ChooseTarget_MPass ; id 29
    dw TargetRandomAllySlot ; id 30
    dw TargetRandomAllySlot ; id 31
    dw TargetOwnSideFirstSlot ; id 32
    dw ChooseTarget_Antidote_6AFD ; id 33
    dw TargetFirstAlly ; id 34
    dw TargetFirstAlly ; id 35
    dw TargetFirstAlly ; id 36
    dw ChooseTarget_Upper_6B0A ; id 37
    dw TargetFirstAlly ; id 38
    dw ChooseTarget_Sap_6BB0 ; id 39
    dw TargetFirstFoe ; id 40
    dw ChooseTarget_Speed_6B5D ; id 41
    dw TargetFirstAlly ; id 42
    dw TargetByAllyAGL ; id 43
    dw TargetFirstFoe ; id 44
    dw TargetRandomAlly ; id 45
    dw TargetFirstFoe ; id 46
    dw TargetFoeWeightedBySlotOrder ; id 47
    dw TargetFirstFoe ; id 48
    dw TargetSelf ; id 49
    dw TargetRandomFoe ; id 50
    dw TargetFirstFoe ; id 51
    dw $0000 ; id 52
    dw $0000 ; id 53
    dw TargetSelf ; id 54
    dw TargetSelf ; id 55
    dw TargetFirstAlly ; id 56
    dw TargetFirstAlly ; id 57
    dw TargetRandomFoe ; id 58
    dw TargetSelf ; id 59
    dw TargetSelf ; id 60
    dw TargetFoeWeightedBySlotOrder ; id 61
    dw TargetFirstFoe ; id 62
    dw TargetFirstFoe ; id 63
    dw TargetFirstFoe ; id 64
    dw TargetFirstFoe ; id 65
    dw TargetFirstFoe ; id 66
    dw TargetFirstFoe ; id 67
    dw TargetFirstFoe ; id 68
    dw TargetFirstFoe ; id 69
    dw TargetFirstFoe ; id 70
    dw TargetFirstFoe ; id 71
    dw TargetFoeWeightedBySlotOrder ; id 72
    dw TargetFirstFoe ; id 73
    dw TargetFirstFoe ; id 74
    dw TargetFirstFoe ; id 75
    dw TargetFoeWeightedBySlotOrder ; id 76
    dw TargetFirstFoe ; id 77
    dw TargetRandomFoe ; id 78
    dw TargetRandomFoe ; id 79
    dw TargetFoeWeightedBySlotOrder ; id 80
    dw TargetFoeWeightedBySlotOrder ; id 81
    dw TargetFoeWeightedBySlotOrder ; id 82
    dw TargetFoeWeightedBySlotOrder ; id 83
    dw TargetFoeWeightedBySlotOrder ; id 84
    dw TargetFoeWeightedBySlotOrder ; id 85
    dw TargetFoeWeightedBySlotOrder ; id 86
    dw TargetFoeWeightedBySlotOrder ; id 87
    dw TargetFoeWeightedBySlotOrder ; id 88
    dw TargetFoeWeightedBySlotOrder ; id 89
    dw TargetFoeWeightedBySlotOrder ; id 90
    dw TargetFoeWeightedBySlotOrder ; id 91
    dw TargetFoeWeightedBySlotOrder ; id 92
    dw TargetFoeWeightedBySlotOrder ; id 93
    dw TargetFoeWeightedBySlotOrder ; id 94
    dw TargetFoeWeightedBySlotOrder ; id 95
    dw TargetFoeWeightedBySlotOrder ; id 96
    dw TargetFoeWeightedBySlotOrder ; id 97
    dw TargetFoeWeightedBySlotOrder ; id 98
    dw TargetFoeWeightedBySlotOrder ; id 99
    dw TargetRandomFoe ; id 100
    dw TargetFirstFoe ; id 101
    dw TargetFirstFoe ; id 102
    dw TargetFoeWeightedBySlotOrder ; id 103
    dw TargetSelf ; id 104
    dw TargetFoeWeightedBySlotOrder ; id 105
    dw TargetFoeWeightedBySlotOrder ; id 106
    dw TargetFoeWeightedBySlotOrder ; id 107
    dw TargetRandomOtherSlot ; id 108
    dw TargetFoeWeightedBySlotOrder ; id 109
    dw TargetFoeWeightedBySlotOrder ; id 110
    dw TargetFoeWeightedBySlotOrder ; id 111
    dw TargetFoeWeightedBySlotOrder ; id 112
    dw TargetFirstFoe ; id 113
    dw TargetFirstFoe ; id 114
    dw TargetFirstFoe ; id 115
    dw TargetFirstFoe ; id 116
    dw TargetFirstFoe ; id 117
    dw TargetRandomFoe ; id 118
    dw TargetRandomFoe ; id 119
    dw TargetFirstFoe ; id 120
    dw TargetFirstFoe ; id 121
    dw TargetFirstFoe ; id 122
    dw TargetOwnSideFirstSlot ; id 123
    dw TargetFirstAlly ; id 124
    dw TargetSelf ; id 125
    dw TargetFirstFoe ; id 126
    dw TargetFirstFoe ; id 127
    dw TargetFirstFoe ; id 128
    dw TargetFirstAlly ; id 129
    dw TargetRandomFoe ; id 130
    dw TargetFirstFoe ; id 131
    dw TargetFirstFoe ; id 132
    dw TargetSelf ; id 133
    dw TargetSelf ; id 134
    dw TargetSelf ; id 135
    dw TargetSelf ; id 136
    dw TargetSelf ; id 137
    dw TargetSelf ; id 138
    dw TargetFoeWeightedBySlotOrder ; id 139
    dw TargetFoeWeightedBySlotOrder ; id 140
    dw TargetFoeWeightedBySlotOrder ; id 141
    dw TargetFirstFoe ; id 142
    dw TargetFoeWeightedBySlotOrder ; id 143
    dw TargetFirstFoe ; id 144
    dw TargetRandomFoe ; id 145
    dw TargetFirstFoe ; id 146
    dw TargetFoeWeightedBySlotOrder ; id 147
    dw TargetSelf ; id 148
    dw TargetSelf ; id 149
    dw TargetSelf ; id 150
    dw TargetRandomOtherAlly ; id 151
    dw TargetFirstAlly ; id 152
    dw TargetSelf ; id 153
    dw TargetFirstAlly ; id 154
    dw TargetSelf ; id 155
    dw TargetSelf ; id 156
    dw TargetSelf ; id 157
    dw TargetSelf ; id 158
    dw TargetSelf ; id 159
    dw TargetSelf ; id 160
    dw TargetSelf ; id 161
    dw $0000 ; id 162
    dw $0000 ; id 163
    dw $0000 ; id 164
    dw $0000 ; id 165
    dw $0000 ; id 166
    dw $0000 ; id 167
    dw $0000 ; id 168
    dw $0000 ; id 169
    dw TargetRandomFoe ; id 170
    dw TargetSelf ; id 171
    dw TargetSelf ; id 172
    dw TargetRandomFoe ; id 173
    dw TargetSelf ; id 174
    dw $0000 ; id 175
    dw TargetFirstFoe ; id 176
    dw TargetFirstAlly ; id 177
    dw TargetFirstFoe ; id 178
    dw TargetFirstFoe ; id 179
    dw TargetFirstAlly ; id 180
    dw TargetFirstFoe ; id 181
    dw TargetFirstFoe ; id 182
    dw TargetSelf ; id 183
    dw TargetSelf ; id 184
    dw TargetFirstFoe ; id 185
    dw TargetFirstFoe ; id 186
    dw TargetOwnSideFirstSlot ; id 187
    dw TargetFirstAlly ; id 188
    dw TargetFirstFoe ; id 189
    dw $0000 ; id 190
    dw TargetSelf ; id 191
    dw TargetRandomOtherAlly ; id 192
    dw TargetRandomFoe ; id 193
    dw TargetSelf ; id 194
    dw TargetSelf ; id 195
    dw TargetSelf ; id 196
    dw TargetSelf ; id 197
    dw TargetSelf ; id 198
    dw TargetSelf ; id 199
    dw TargetSelf ; id 200
    dw TargetSelf ; id 201
    dw TargetSelf ; id 202
    dw TargetSelf ; id 203
    dw TargetFoeWeightedBySlotOrder ; id 204
    dw TargetSelf ; id 205
    dw TargetOwnSideFirstSlot ; id 206
    dw TargetFirstAlly ; id 207
    dw TargetFirstFoe ; id 208
    dw TargetFoeWeightedBySlotOrder ; id 209
    dw TargetFoeWeightedBySlotOrder ; id 210
    dw TargetFoeWeightedBySlotOrder ; id 211
    dw TargetFoeWeightedBySlotOrder ; id 212
    dw TargetFirstFoe ; id 213
    dw TargetFirstFoe ; id 214
    dw TargetFoeWeightedBySlotOrder ; id 215
    dw TargetFoeWeightedBySlotOrder ; id 216
    dw TargetFirstFoe ; id 217
    dw TargetFirstAlly ; id 218
    dw TargetFirstFoe ; id 219
    dw TargetSelf ; id 220
    dw TargetFirstAlly ; id 221
    dw TargetFirstFoe ; id 222
    dw TargetFoeWeightedBySlotOrder ; id 223
    dw TargetSelf ; id 224
    dw TargetFirstFoe ; id 225
    dw TargetSelf ; id 226
    dw TargetSelf ; id 227

; table 4 of ActionTargetModeTable (mode 2, near side); 228 code words, one per action id, as
; SkillTable (E-0204) (E-0219, C1)
; record: target routine for this action id
ActionTargetRoutines4::
    dw ChooseTarget_SquallHit ; id 0
    dw ChooseTarget_Blaze ; id 1
    dw ChooseTarget_Blaze ; id 2
    dw ChooseTarget_Blaze ; id 3
    dw TargetFirstFoe ; id 4
    dw TargetFirstFoe ; id 5
    dw TargetFirstFoe ; id 6
    dw TargetFirstFoe ; id 7
    dw TargetFirstFoe ; id 8
    dw TargetFirstFoe ; id 9
    dw TargetFirstFoe ; id 10
    dw TargetFirstFoe ; id 11
    dw TargetFirstFoe ; id 12
    dw TargetFirstFoe ; id 13
    dw TargetFirstFoe ; id 14
    dw TargetFirstFoe ; id 15
    dw TargetFirstFoe ; id 16
    dw TargetFirstFoe ; id 17
    dw TargetFirstFoe ; id 18
    dw ChooseTarget_Beat ; id 19
    dw TargetFirstFoe ; id 20
    dw TargetFirstFoe ; id 21
    dw ChooseTarget_Heal ; id 22
    dw ChooseTarget_Heal ; id 23
    dw ChooseTarget_Heal ; id 24
    dw TargetFirstAlly ; id 25
    dw TargetFirstAlly ; id 26
    dw TargetRandomOtherAlly ; id 27
    dw TargetRandomOtherAlly ; id 28
    dw TargetRandomOtherAlly ; id 29
    dw ChooseTarget_Vivify ; id 30
    dw ChooseTarget_Vivify ; id 31
    dw TargetOwnSideFirstSlot ; id 32
    dw ChooseTarget_Antidote ; id 33
    dw TargetFirstAlly ; id 34
    dw TargetFirstAlly ; id 35
    dw TargetFirstAlly ; id 36
    dw ChooseTarget_Upper ; id 37
    dw TargetFirstAlly ; id 38
    dw ChooseTarget_Sap ; id 39
    dw TargetFirstFoe ; id 40
    dw ChooseTarget_Speed ; id 41
    dw TargetFirstAlly ; id 42
    dw ChooseTarget_Slow ; id 43
    dw TargetFirstFoe ; id 44
    dw ChooseTarget_TwinHits ; id 45
    dw TargetFirstFoe ; id 46
    dw ChooseTarget_Sleep ; id 47
    dw TargetFirstFoe ; id 48
    dw TargetSelf ; id 49
    dw ChooseTarget_RobMagic ; id 50
    dw TargetFirstFoe ; id 51
    dw TargetFirstFoe ; id 52
    dw TargetFirstAlly ; id 53
    dw TargetSelf ; id 54
    dw TargetSelf ; id 55
    dw TargetFirstAlly ; id 56
    dw TargetFirstAlly ; id 57
    dw ChooseTarget_Transform ; id 58
    dw TargetSelf ; id 59
    dw TargetSelf ; id 60
    dw ChooseTarget_MegaMagic ; id 61
    dw TargetFirstFoe ; id 62
    dw TargetFirstFoe ; id 63
    dw TargetFirstFoe ; id 64
    dw TargetFirstFoe ; id 65
    dw TargetFirstFoe ; id 66
    dw TargetFirstFoe ; id 67
    dw TargetFirstFoe ; id 68
    dw TargetFirstFoe ; id 69
    dw TargetFirstFoe ; id 70
    dw TargetFirstFoe ; id 71
    dw ChooseTarget_WindBeast ; id 72
    dw TargetFirstFoe ; id 73
    dw TargetFirstFoe ; id 74
    dw TargetFirstFoe ; id 75
    dw ChooseTarget_Watershot ; id 76
    dw TargetFirstFoe ; id 77
    dw TargetRandomFoe ; id 78
    dw TargetRandomFoe ; id 79
    dw ChooseTarget_FireSlash ; id 80
    dw ChooseTarget_VacuSlash ; id 81
    dw ChooseTarget_BoltSlash ; id 82
    dw ChooseTarget_IceSlash ; id 83
    dw ChooseTarget_SlimeBlow ; id 84
    dw ChooseTarget_DrakSlash ; id 85
    dw ChooseTarget_BeastCut ; id 86
    dw ChooseTarget_BirdBlow ; id 87
    dw ChooseTarget_BugBlow ; id 88
    dw ChooseTarget_Shears ; id 89
    dw ChooseTarget_DevilCut ; id 90
    dw ChooseTarget_ZombieCut ; id 91
    dw ChooseTarget_CleanCut ; id 92
    dw ChooseTarget_AquaCut ; id 93
    dw ChooseTarget_MetalCut ; id 94
    dw ChooseTarget_PoisonHit ; id 95
    dw ChooseTarget_Paralyze ; id 96
    dw ChooseTarget_NapAttack ; id 97
    dw ChooseTarget_SquallHit ; id 98
    dw ChooseTarget_SquallHit ; id 99
    dw TargetRandomFoe ; id 100
    dw TargetFirstFoe ; id 101
    dw TargetFirstFoe ; id 102
    dw ChooseTarget_GigaSlash ; id 103
    dw TargetSelf ; id 104
    dw ChooseTarget_SquallHit ; id 105
    dw ChooseTarget_SquallHit ; id 106
    dw ChooseTarget_SquallHit ; id 107
    dw TargetRandomOtherSlot ; id 108
    dw ChooseTarget_SquallHit ; id 109
    dw ChooseTarget_SquallHit ; id 110
    dw ChooseTarget_Ramming ; id 111
    dw ChooseTarget_Ramming ; id 112
    dw TargetFirstFoe ; id 113
    dw TargetFirstFoe ; id 114
    dw TargetFirstFoe ; id 115
    dw TargetFirstFoe ; id 116
    dw TargetFirstFoe ; id 117
    dw ChooseTarget_OddDance ; id 118
    dw ChooseTarget_OddDance ; id 119
    dw TargetFirstFoe ; id 120
    dw TargetFirstFoe ; id 121
    dw TargetFirstFoe ; id 122
    dw TargetOwnSideFirstSlot ; id 123
    dw TargetFirstAlly ; id 124
    dw TargetSelf ; id 125
    dw TargetFirstFoe ; id 126
    dw TargetFirstFoe ; id 127
    dw TargetFirstFoe ; id 128
    dw TargetFirstAlly ; id 129
    dw ChooseTarget_UltraDown ; id 130
    dw TargetFirstFoe ; id 131
    dw TargetFirstFoe ; id 132
    dw TargetSelf ; id 133
    dw TargetSelf ; id 134
    dw TargetSelf ; id 135
    dw TargetSelf ; id 136
    dw TargetSelf ; id 137
    dw TargetSelf ; id 138
    dw ChooseTarget_LushLicks ; id 139
    dw ChooseTarget_SickLick ; id 140
    dw ChooseTarget_LegSweep ; id 141
    dw TargetFirstFoe ; id 142
    dw ChooseTarget_LushLicks ; id 143
    dw TargetFirstFoe ; id 144
    dw TargetRandomFoe ; id 145
    dw TargetFirstFoe ; id 146
    dw ChooseTarget_MouthShut ; id 147
    dw TargetSelf ; id 148
    dw TargetSelf ; id 149
    dw TargetSelf ; id 150
    dw ChooseTarget_Cover ; id 151
    dw TargetFirstAlly ; id 152
    dw TargetSelf ; id 153
    dw TargetFirstAlly ; id 154
    dw TargetSelf ; id 155
    dw TargetSelf ; id 156
    dw TargetSelf ; id 157
    dw TargetSelf ; id 158
    dw TargetSelf ; id 159
    dw TargetSelf ; id 160
    dw TargetSelf ; id 161
    dw $0000 ; id 162
    dw $0000 ; id 163
    dw $0000 ; id 164
    dw $0000 ; id 165
    dw $0000 ; id 166
    dw $0000 ; id 167
    dw $0000 ; id 168
    dw $0000 ; id 169
    dw TargetRandomFoe ; id 170
    dw TargetSelf ; id 171
    dw TargetSelf ; id 172
    dw $0000 ; id 173
    dw $0000 ; id 174
    dw $0000 ; id 175
    dw TargetFirstFoe ; id 176
    dw TargetFirstAlly ; id 177
    dw TargetFirstFoe ; id 178
    dw TargetFirstFoe ; id 179
    dw TargetFirstAlly ; id 180
    dw TargetFirstFoe ; id 181
    dw TargetFirstFoe ; id 182
    dw TargetSelf ; id 183
    dw TargetSelf ; id 184
    dw TargetFirstFoe ; id 185
    dw TargetFirstFoe ; id 186
    dw TargetOwnSideFirstSlot ; id 187
    dw TargetFirstAlly ; id 188
    dw TargetFirstFoe ; id 189
    dw $0000 ; id 190
    dw TargetSelf ; id 191
    dw TargetRandomOtherAlly ; id 192
    dw TargetRandomFoe ; id 193
    dw TargetSelf ; id 194
    dw TargetSelf ; id 195
    dw TargetSelf ; id 196
    dw TargetSelf ; id 197
    dw TargetSelf ; id 198
    dw TargetSelf ; id 199
    dw TargetSelf ; id 200
    dw TargetSelf ; id 201
    dw TargetSelf ; id 202
    dw TargetSelf ; id 203
    dw TargetSavedSlotOrRandomFoe ; id 204
    dw TargetSelf ; id 205
    dw TargetOwnSideFirstSlot ; id 206
    dw TargetFirstAlly ; id 207
    dw TargetFirstFoe ; id 208
    dw ChooseTarget_Blaze ; id 209
    dw ChooseTarget_SquallHit ; id 210
    dw ChooseTarget_SquallHit ; id 211
    dw ChooseTarget_SquallHit ; id 212
    dw TargetFirstFoe ; id 213
    dw TargetFirstFoe ; id 214
    dw ChooseTarget_SquallHit ; id 215
    dw ChooseTarget_SquallHit ; id 216
    dw TargetFirstFoe ; id 217
    dw TargetFirstAlly ; id 218
    dw TargetFirstFoe ; id 219
    dw TargetSelf ; id 220
    dw TargetFirstAlly ; id 221
    dw TargetFirstFoe ; id 222
    dw ChooseTarget_Blaze ; id 223
    dw TargetSelf ; id 224
    dw TargetFirstFoe ; id 225
    dw TargetSelf ; id 226
    dw TargetSelf ; id 227

; table 5 of ActionTargetModeTable (mode 2, far side); 228 code words, one per action id, as
; SkillTable (E-0204) (E-0219, C1)
ActionTargetRoutines5::
    dw TargetFoeWeightedBySlotOrder ; id 0
    dw TargetFoeWeightedBySlotOrder ; id 1
    dw TargetFoeWeightedBySlotOrder ; id 2
    dw TargetFoeWeightedBySlotOrder ; id 3
    dw TargetFirstFoe ; id 4
    dw TargetFirstFoe ; id 5
    dw TargetFirstFoe ; id 6
    dw TargetFirstFoe ; id 7
    dw TargetFirstFoe ; id 8
    dw TargetFirstFoe ; id 9
    dw TargetFirstFoe ; id 10
    dw TargetFirstFoe ; id 11
    dw TargetFirstFoe ; id 12
    dw TargetFirstFoe ; id 13
    dw TargetFirstFoe ; id 14
    dw TargetFirstFoe ; id 15
    dw TargetFirstFoe ; id 16
    dw TargetFirstFoe ; id 17
    dw TargetFirstFoe ; id 18
    dw TargetFoeWeightedBySlotOrder ; id 19
    dw TargetFirstFoe ; id 20
    dw TargetFirstFoe ; id 21
    dw ChooseTarget_Heal_67AD ; id 22
    dw ChooseTarget_Heal_67AD ; id 23
    dw ChooseTarget_Heal_67AD ; id 24
    dw TargetFirstAlly ; id 25
    dw TargetFirstAlly ; id 26
    dw TargetRandomOtherAlly ; id 27
    dw TargetRandomOtherAlly ; id 28
    dw TargetRandomOtherAlly ; id 29
    dw ChooseTarget_Vivify_6998 ; id 30
    dw ChooseTarget_Vivify_6998 ; id 31
    dw TargetOwnSideFirstSlot ; id 32
    dw ChooseTarget_Antidote_699B ; id 33
    dw TargetFirstAlly ; id 34
    dw TargetFirstAlly ; id 35
    dw TargetFirstAlly ; id 36
    dw ChooseTarget_Upper_69A1 ; id 37
    dw TargetFirstAlly ; id 38
    dw ChooseTarget_Sap_69A4 ; id 39
    dw TargetFirstFoe ; id 40
    dw ChooseTarget_Speed_69AA ; id 41
    dw TargetFirstAlly ; id 42
    dw ChooseTarget_Slow_69A7 ; id 43
    dw TargetFirstFoe ; id 44
    dw ChooseTarget_TwinHits_699E ; id 45
    dw TargetFirstFoe ; id 46
    dw TargetFoeWeightedBySlotOrder ; id 47
    dw TargetFirstFoe ; id 48
    dw TargetSelf ; id 49
    dw ChooseTarget_RobMagic_6A13 ; id 50
    dw TargetFirstFoe ; id 51
    dw $0000 ; id 52
    dw $0000 ; id 53
    dw TargetSelf ; id 54
    dw TargetSelf ; id 55
    dw TargetFirstAlly ; id 56
    dw TargetFirstAlly ; id 57
    dw ChooseTarget_Transform_6A04 ; id 58
    dw TargetSelf ; id 59
    dw TargetSelf ; id 60
    dw TargetFoeWeightedBySlotOrder ; id 61
    dw TargetFirstFoe ; id 62
    dw TargetFirstFoe ; id 63
    dw TargetFirstFoe ; id 64
    dw TargetFirstFoe ; id 65
    dw TargetFirstFoe ; id 66
    dw TargetFirstFoe ; id 67
    dw TargetFirstFoe ; id 68
    dw TargetFirstFoe ; id 69
    dw TargetFirstFoe ; id 70
    dw TargetFirstFoe ; id 71
    dw TargetFoeWeightedBySlotOrder ; id 72
    dw TargetFirstFoe ; id 73
    dw TargetFirstFoe ; id 74
    dw TargetFirstFoe ; id 75
    dw TargetFoeWeightedBySlotOrder ; id 76
    dw TargetFirstFoe ; id 77
    dw TargetRandomFoe ; id 78
    dw TargetRandomFoe ; id 79
    dw TargetFoeWeightedBySlotOrder ; id 80
    dw TargetFoeWeightedBySlotOrder ; id 81
    dw TargetFoeWeightedBySlotOrder ; id 82
    dw TargetFoeWeightedBySlotOrder ; id 83
    dw ChooseTarget_SlimeBlow_69E9 ; id 84
    dw ChooseTarget_DrakSlash_69C5 ; id 85
    dw ChooseTarget_BeastCut_69CB ; id 86
    dw ChooseTarget_BirdBlow_69D1 ; id 87
    dw ChooseTarget_BugBlow_69EF ; id 88
    dw ChooseTarget_Shears_69F5 ; id 89
    dw ChooseTarget_DevilCut_69D7 ; id 90
    dw ChooseTarget_ZombieCut_69DD ; id 91
    dw ChooseTarget_CleanCut_69E3 ; id 92
    dw TargetFoeWeightedBySlotOrder ; id 93
    dw ChooseTarget_MetalCut_69C2 ; id 94
    dw TargetFoeWeightedBySlotOrder ; id 95
    dw TargetFoeWeightedBySlotOrder ; id 96
    dw TargetFoeWeightedBySlotOrder ; id 97
    dw TargetFoeWeightedBySlotOrder ; id 98
    dw TargetFoeWeightedBySlotOrder ; id 99
    dw TargetRandomFoe ; id 100
    dw TargetFirstFoe ; id 101
    dw TargetFirstFoe ; id 102
    dw TargetFoeWeightedBySlotOrder ; id 103
    dw TargetSelf ; id 104
    dw TargetFoeWeightedBySlotOrder ; id 105
    dw TargetFoeWeightedBySlotOrder ; id 106
    dw TargetFoeWeightedBySlotOrder ; id 107
    dw TargetRandomOtherSlot ; id 108
    dw TargetFoeWeightedBySlotOrder ; id 109
    dw TargetFoeWeightedBySlotOrder ; id 110
    dw TargetFoeWeightedBySlotOrder ; id 111
    dw TargetFoeWeightedBySlotOrder ; id 112
    dw TargetFirstFoe ; id 113
    dw TargetFirstFoe ; id 114
    dw TargetFirstFoe ; id 115
    dw TargetFirstFoe ; id 116
    dw TargetFirstFoe ; id 117
    dw ChooseTarget_OddDance_69BF ; id 118
    dw ChooseTarget_OddDance_69BF ; id 119
    dw TargetFirstFoe ; id 120
    dw TargetFirstFoe ; id 121
    dw TargetFirstFoe ; id 122
    dw TargetOwnSideFirstSlot ; id 123
    dw TargetFirstAlly ; id 124
    dw TargetSelf ; id 125
    dw TargetFirstFoe ; id 126
    dw TargetFirstFoe ; id 127
    dw TargetFirstFoe ; id 128
    dw TargetFirstAlly ; id 129
    dw ChooseTarget_UltraDown_69AD ; id 130
    dw TargetFirstFoe ; id 131
    dw TargetFirstFoe ; id 132
    dw TargetSelf ; id 133
    dw TargetSelf ; id 134
    dw TargetSelf ; id 135
    dw TargetSelf ; id 136
    dw TargetSelf ; id 137
    dw TargetSelf ; id 138
    dw TargetFoeWeightedBySlotOrder ; id 139
    dw ChooseTarget_SickLick_69B6 ; id 140
    dw ChooseTarget_LegSweep_69B9 ; id 141
    dw TargetFirstFoe ; id 142
    dw TargetFoeWeightedBySlotOrder ; id 143
    dw TargetFirstFoe ; id 144
    dw TargetRandomFoe ; id 145
    dw TargetFirstFoe ; id 146
    dw ChooseTarget_MouthShut_69B3 ; id 147
    dw TargetSelf ; id 148
    dw TargetSelf ; id 149
    dw TargetSelf ; id 150
    dw ChooseTarget_Cover_69B0 ; id 151
    dw TargetFirstAlly ; id 152
    dw TargetSelf ; id 153
    dw TargetFirstAlly ; id 154
    dw TargetSelf ; id 155
    dw TargetSelf ; id 156
    dw TargetSelf ; id 157
    dw TargetSelf ; id 158
    dw TargetSelf ; id 159
    dw TargetSelf ; id 160
    dw TargetSelf ; id 161
    dw $0000 ; id 162
    dw $0000 ; id 163
    dw $0000 ; id 164
    dw $0000 ; id 165
    dw $0000 ; id 166
    dw $0000 ; id 167
    dw $0000 ; id 168
    dw $0000 ; id 169
    dw TargetRandomFoe ; id 170
    dw TargetSelf ; id 171
    dw TargetSelf ; id 172
    dw TargetFoeWeightedBySlotOrder ; id 173
    dw TargetSelf ; id 174
    dw $0000 ; id 175
    dw TargetFirstFoe ; id 176
    dw TargetFirstAlly ; id 177
    dw TargetFirstFoe ; id 178
    dw TargetFirstFoe ; id 179
    dw TargetFirstAlly ; id 180
    dw TargetFirstFoe ; id 181
    dw TargetFirstFoe ; id 182
    dw TargetSelf ; id 183
    dw TargetSelf ; id 184
    dw TargetFirstFoe ; id 185
    dw TargetFirstFoe ; id 186
    dw TargetOwnSideFirstSlot ; id 187
    dw TargetFirstAlly ; id 188
    dw TargetFirstFoe ; id 189
    dw $0000 ; id 190
    dw TargetSelf ; id 191
    dw TargetRandomOtherAlly ; id 192
    dw TargetRandomFoe ; id 193
    dw TargetSelf ; id 194
    dw TargetSelf ; id 195
    dw TargetSelf ; id 196
    dw TargetSelf ; id 197
    dw TargetSelf ; id 198
    dw TargetSelf ; id 199
    dw TargetSelf ; id 200
    dw TargetSelf ; id 201
    dw TargetSelf ; id 202
    dw TargetSelf ; id 203
    dw TargetFoeWeightedBySlotOrder ; id 204
    dw TargetSelf ; id 205
    dw TargetOwnSideFirstSlot ; id 206
    dw TargetFirstAlly ; id 207
    dw TargetFirstFoe ; id 208
    dw TargetFoeWeightedBySlotOrder ; id 209
    dw TargetFoeWeightedBySlotOrder ; id 210
    dw TargetFoeWeightedBySlotOrder ; id 211
    dw TargetFoeWeightedBySlotOrder ; id 212
    dw TargetFirstFoe ; id 213
    dw TargetFirstFoe ; id 214
    dw TargetFoeWeightedBySlotOrder ; id 215
    dw TargetFoeWeightedBySlotOrder ; id 216
    dw TargetFirstFoe ; id 217
    dw TargetFirstAlly ; id 218
    dw TargetFirstFoe ; id 219
    dw TargetSelf ; id 220
    dw TargetFirstAlly ; id 221
    dw TargetFirstFoe ; id 222
    dw TargetFoeWeightedBySlotOrder ; id 223
    dw TargetSelf ; id 224
    dw TargetFirstFoe ; id 225
    dw TargetSelf ; id 226
    dw TargetSelf ; id 227

; table 6 of ActionTargetModeTable (mode 3, near side); 228 code words, one per action id, as
; SkillTable (E-0204) (E-0219, C1)
ActionTargetRoutines6::
    dw ChooseTarget_SquallHit ; id 0
    dw ChooseTarget_Blaze ; id 1
    dw ChooseTarget_Blaze ; id 2
    dw ChooseTarget_Blaze ; id 3
    dw TargetFirstFoe ; id 4
    dw TargetFirstFoe ; id 5
    dw TargetFirstFoe ; id 6
    dw TargetFirstFoe ; id 7
    dw TargetFirstFoe ; id 8
    dw TargetFirstFoe ; id 9
    dw TargetFirstFoe ; id 10
    dw TargetFirstFoe ; id 11
    dw TargetFirstFoe ; id 12
    dw TargetFirstFoe ; id 13
    dw TargetFirstFoe ; id 14
    dw TargetFirstFoe ; id 15
    dw TargetFirstFoe ; id 16
    dw TargetFirstFoe ; id 17
    dw TargetFirstFoe ; id 18
    dw ChooseTarget_Beat ; id 19
    dw TargetFirstFoe ; id 20
    dw TargetFirstFoe ; id 21
    dw ChooseTarget_Heal ; id 22
    dw ChooseTarget_Heal ; id 23
    dw ChooseTarget_Heal ; id 24
    dw TargetFirstAlly ; id 25
    dw TargetFirstAlly ; id 26
    dw TargetRandomOtherAlly ; id 27
    dw TargetRandomOtherAlly ; id 28
    dw TargetRandomOtherAlly ; id 29
    dw ChooseTarget_Vivify ; id 30
    dw ChooseTarget_Vivify ; id 31
    dw TargetOwnSideFirstSlot ; id 32
    dw ChooseTarget_Antidote ; id 33
    dw TargetFirstAlly ; id 34
    dw TargetFirstAlly ; id 35
    dw TargetFirstAlly ; id 36
    dw ChooseTarget_Upper ; id 37
    dw TargetFirstAlly ; id 38
    dw ChooseTarget_Sap ; id 39
    dw TargetFirstFoe ; id 40
    dw ChooseTarget_Speed ; id 41
    dw TargetFirstAlly ; id 42
    dw ChooseTarget_Slow ; id 43
    dw TargetFirstFoe ; id 44
    dw ChooseTarget_TwinHits ; id 45
    dw TargetFirstFoe ; id 46
    dw ChooseTarget_Sleep ; id 47
    dw TargetFirstFoe ; id 48
    dw TargetSelf ; id 49
    dw ChooseTarget_RobMagic ; id 50
    dw TargetFirstFoe ; id 51
    dw TargetFirstFoe ; id 52
    dw TargetFirstAlly ; id 53
    dw TargetSelf ; id 54
    dw TargetSelf ; id 55
    dw TargetFirstAlly ; id 56
    dw TargetFirstAlly ; id 57
    dw ChooseTarget_Transform ; id 58
    dw TargetSelf ; id 59
    dw TargetSelf ; id 60
    dw ChooseTarget_MegaMagic ; id 61
    dw TargetFirstFoe ; id 62
    dw TargetFirstFoe ; id 63
    dw TargetFirstFoe ; id 64
    dw TargetFirstFoe ; id 65
    dw TargetFirstFoe ; id 66
    dw TargetFirstFoe ; id 67
    dw TargetFirstFoe ; id 68
    dw TargetFirstFoe ; id 69
    dw TargetFirstFoe ; id 70
    dw TargetFirstFoe ; id 71
    dw ChooseTarget_WindBeast ; id 72
    dw TargetFirstFoe ; id 73
    dw TargetFirstFoe ; id 74
    dw TargetFirstFoe ; id 75
    dw ChooseTarget_Watershot ; id 76
    dw TargetFirstFoe ; id 77
    dw TargetRandomFoe ; id 78
    dw TargetRandomFoe ; id 79
    dw ChooseTarget_FireSlash ; id 80
    dw ChooseTarget_VacuSlash ; id 81
    dw ChooseTarget_BoltSlash ; id 82
    dw ChooseTarget_IceSlash ; id 83
    dw ChooseTarget_SlimeBlow ; id 84
    dw ChooseTarget_DrakSlash ; id 85
    dw ChooseTarget_BeastCut ; id 86
    dw ChooseTarget_BirdBlow ; id 87
    dw ChooseTarget_BugBlow ; id 88
    dw ChooseTarget_Shears ; id 89
    dw ChooseTarget_DevilCut ; id 90
    dw ChooseTarget_ZombieCut ; id 91
    dw ChooseTarget_CleanCut ; id 92
    dw ChooseTarget_AquaCut ; id 93
    dw ChooseTarget_MetalCut ; id 94
    dw ChooseTarget_PoisonHit ; id 95
    dw ChooseTarget_Paralyze ; id 96
    dw ChooseTarget_NapAttack ; id 97
    dw ChooseTarget_SquallHit ; id 98
    dw ChooseTarget_SquallHit ; id 99
    dw TargetRandomFoe ; id 100
    dw TargetFirstFoe ; id 101
    dw TargetFirstFoe ; id 102
    dw ChooseTarget_GigaSlash ; id 103
    dw TargetSelf ; id 104
    dw ChooseTarget_SquallHit ; id 105
    dw ChooseTarget_SquallHit ; id 106
    dw ChooseTarget_SquallHit ; id 107
    dw TargetRandomOtherSlot ; id 108
    dw ChooseTarget_SquallHit ; id 109
    dw ChooseTarget_SquallHit ; id 110
    dw ChooseTarget_Ramming ; id 111
    dw ChooseTarget_Ramming ; id 112
    dw TargetFirstFoe ; id 113
    dw TargetFirstFoe ; id 114
    dw TargetFirstFoe ; id 115
    dw TargetFirstFoe ; id 116
    dw TargetFirstFoe ; id 117
    dw ChooseTarget_OddDance ; id 118
    dw ChooseTarget_OddDance ; id 119
    dw TargetFirstFoe ; id 120
    dw TargetFirstFoe ; id 121
    dw TargetFirstFoe ; id 122
    dw TargetOwnSideFirstSlot ; id 123
    dw TargetFirstAlly ; id 124
    dw TargetSelf ; id 125
    dw TargetFirstFoe ; id 126
    dw TargetFirstFoe ; id 127
    dw TargetFirstFoe ; id 128
    dw TargetFirstAlly ; id 129
    dw ChooseTarget_UltraDown ; id 130
    dw TargetFirstFoe ; id 131
    dw TargetFirstFoe ; id 132
    dw TargetSelf ; id 133
    dw TargetSelf ; id 134
    dw TargetSelf ; id 135
    dw TargetSelf ; id 136
    dw TargetSelf ; id 137
    dw TargetSelf ; id 138
    dw ChooseTarget_LushLicks ; id 139
    dw ChooseTarget_SickLick ; id 140
    dw ChooseTarget_LegSweep ; id 141
    dw TargetFirstFoe ; id 142
    dw ChooseTarget_LushLicks ; id 143
    dw TargetFirstFoe ; id 144
    dw TargetRandomFoe ; id 145
    dw TargetFirstFoe ; id 146
    dw ChooseTarget_MouthShut ; id 147
    dw TargetSelf ; id 148
    dw TargetSelf ; id 149
    dw TargetSelf ; id 150
    dw ChooseTarget_Cover ; id 151
    dw TargetFirstAlly ; id 152
    dw TargetSelf ; id 153
    dw TargetFirstAlly ; id 154
    dw TargetSelf ; id 155
    dw TargetSelf ; id 156
    dw TargetSelf ; id 157
    dw TargetSelf ; id 158
    dw TargetSelf ; id 159
    dw TargetSelf ; id 160
    dw TargetSelf ; id 161
    dw $0000 ; id 162
    dw $0000 ; id 163
    dw $0000 ; id 164
    dw $0000 ; id 165
    dw $0000 ; id 166
    dw $0000 ; id 167
    dw $0000 ; id 168
    dw $0000 ; id 169
    dw TargetRandomFoe ; id 170
    dw TargetSelf ; id 171
    dw TargetSelf ; id 172
    dw $0000 ; id 173
    dw $0000 ; id 174
    dw $0000 ; id 175
    dw TargetFirstFoe ; id 176
    dw TargetFirstAlly ; id 177
    dw TargetFirstFoe ; id 178
    dw TargetFirstFoe ; id 179
    dw TargetFirstAlly ; id 180
    dw TargetFirstFoe ; id 181
    dw TargetFirstFoe ; id 182
    dw TargetSelf ; id 183
    dw TargetSelf ; id 184
    dw TargetFirstFoe ; id 185
    dw TargetFirstFoe ; id 186
    dw TargetOwnSideFirstSlot ; id 187
    dw TargetFirstAlly ; id 188
    dw TargetFirstFoe ; id 189
    dw $0000 ; id 190
    dw TargetSelf ; id 191
    dw TargetRandomOtherAlly ; id 192
    dw TargetRandomFoe ; id 193
    dw TargetSelf ; id 194
    dw TargetSelf ; id 195
    dw TargetSelf ; id 196
    dw TargetSelf ; id 197
    dw TargetSelf ; id 198
    dw TargetSelf ; id 199
    dw TargetSelf ; id 200
    dw TargetSelf ; id 201
    dw TargetSelf ; id 202
    dw TargetSelf ; id 203
    dw TargetSavedSlotOrRandomFoe ; id 204
    dw TargetSelf ; id 205
    dw TargetOwnSideFirstSlot ; id 206
    dw TargetFirstAlly ; id 207
    dw TargetFirstFoe ; id 208
    dw ChooseTarget_Blaze ; id 209
    dw ChooseTarget_SquallHit ; id 210
    dw ChooseTarget_SquallHit ; id 211
    dw ChooseTarget_SquallHit ; id 212
    dw TargetFirstFoe ; id 213
    dw TargetFirstFoe ; id 214
    dw ChooseTarget_SquallHit ; id 215
    dw ChooseTarget_SquallHit ; id 216
    dw TargetFirstFoe ; id 217
    dw TargetFirstAlly ; id 218
    dw TargetFirstFoe ; id 219
    dw TargetSelf ; id 220
    dw TargetFirstAlly ; id 221
    dw TargetFirstFoe ; id 222
    dw ChooseTarget_SquallHit ; id 223
    dw TargetSelf ; id 224
    dw TargetFirstFoe ; id 225
    dw TargetSelf ; id 226
    dw TargetSelf ; id 227

; table 7 of ActionTargetModeTable (mode 3, far side); 228 code words, one per action id, as
; SkillTable (E-0204) (E-0219, C1)
ActionTargetRoutines7::
    dw TargetFoeWeightedBySlotOrder ; id 0
    dw TargetFoeWeightedBySlotOrder ; id 1
    dw TargetFoeWeightedBySlotOrder ; id 2
    dw TargetFoeWeightedBySlotOrder ; id 3
    dw TargetFirstFoe ; id 4
    dw TargetFirstFoe ; id 5
    dw TargetFirstFoe ; id 6
    dw TargetFirstFoe ; id 7
    dw TargetFirstFoe ; id 8
    dw TargetFirstFoe ; id 9
    dw TargetFirstFoe ; id 10
    dw TargetFirstFoe ; id 11
    dw TargetFirstFoe ; id 12
    dw TargetFirstFoe ; id 13
    dw TargetFirstFoe ; id 14
    dw TargetFirstFoe ; id 15
    dw TargetFirstFoe ; id 16
    dw TargetFirstFoe ; id 17
    dw TargetFirstFoe ; id 18
    dw TargetFoeWeightedBySlotOrder ; id 19
    dw TargetFirstFoe ; id 20
    dw TargetFirstFoe ; id 21
    dw ChooseTarget_Heal_67AD ; id 22
    dw ChooseTarget_Heal_67AD ; id 23
    dw ChooseTarget_Heal_67AD ; id 24
    dw TargetFirstAlly ; id 25
    dw TargetFirstAlly ; id 26
    dw TargetRandomOtherAlly ; id 27
    dw TargetRandomOtherAlly ; id 28
    dw TargetRandomOtherAlly ; id 29
    dw ChooseTarget_Vivify_6998 ; id 30
    dw ChooseTarget_Vivify_6998 ; id 31
    dw TargetOwnSideFirstSlot ; id 32
    dw ChooseTarget_Antidote_699B ; id 33
    dw TargetFirstAlly ; id 34
    dw TargetFirstAlly ; id 35
    dw TargetFirstAlly ; id 36
    dw ChooseTarget_Upper_69A1 ; id 37
    dw TargetFirstAlly ; id 38
    dw ChooseTarget_Sap_69A4 ; id 39
    dw TargetFirstFoe ; id 40
    dw ChooseTarget_Speed_69AA ; id 41
    dw TargetFirstAlly ; id 42
    dw ChooseTarget_Slow_69A7 ; id 43
    dw TargetFirstFoe ; id 44
    dw ChooseTarget_TwinHits_699E ; id 45
    dw TargetFirstFoe ; id 46
    dw TargetFoeWeightedBySlotOrder ; id 47
    dw TargetFirstFoe ; id 48
    dw TargetSelf ; id 49
    dw ChooseTarget_RobMagic_6A13 ; id 50
    dw TargetFirstFoe ; id 51
    dw $0000 ; id 52
    dw $0000 ; id 53
    dw TargetSelf ; id 54
    dw TargetSelf ; id 55
    dw TargetFirstAlly ; id 56
    dw TargetFirstAlly ; id 57
    dw ChooseTarget_Transform_6A04 ; id 58
    dw TargetSelf ; id 59
    dw TargetSelf ; id 60
    dw TargetFoeWeightedBySlotOrder ; id 61
    dw TargetFirstFoe ; id 62
    dw TargetFirstFoe ; id 63
    dw TargetFirstFoe ; id 64
    dw TargetFirstFoe ; id 65
    dw TargetFirstFoe ; id 66
    dw TargetFirstFoe ; id 67
    dw TargetFirstFoe ; id 68
    dw TargetFirstFoe ; id 69
    dw TargetFirstFoe ; id 70
    dw TargetFirstFoe ; id 71
    dw TargetFoeWeightedBySlotOrder ; id 72
    dw TargetFirstFoe ; id 73
    dw TargetFirstFoe ; id 74
    dw TargetFirstFoe ; id 75
    dw TargetFoeWeightedBySlotOrder ; id 76
    dw TargetFirstFoe ; id 77
    dw TargetRandomFoe ; id 78
    dw TargetRandomFoe ; id 79
    dw TargetFoeWeightedBySlotOrder ; id 80
    dw TargetFoeWeightedBySlotOrder ; id 81
    dw TargetFoeWeightedBySlotOrder ; id 82
    dw TargetFoeWeightedBySlotOrder ; id 83
    dw ChooseTarget_SlimeBlow_69E9 ; id 84
    dw ChooseTarget_DrakSlash_69C5 ; id 85
    dw ChooseTarget_BeastCut_69CB ; id 86
    dw ChooseTarget_BirdBlow_69D1 ; id 87
    dw ChooseTarget_BugBlow_69EF ; id 88
    dw ChooseTarget_Shears_69F5 ; id 89
    dw ChooseTarget_DevilCut_69D7 ; id 90
    dw ChooseTarget_ZombieCut_69DD ; id 91
    dw ChooseTarget_CleanCut_69E3 ; id 92
    dw TargetFoeWeightedBySlotOrder ; id 93
    dw ChooseTarget_MetalCut_69C2 ; id 94
    dw TargetFoeWeightedBySlotOrder ; id 95
    dw TargetFoeWeightedBySlotOrder ; id 96
    dw TargetFoeWeightedBySlotOrder ; id 97
    dw TargetFoeWeightedBySlotOrder ; id 98
    dw TargetFoeWeightedBySlotOrder ; id 99
    dw TargetRandomFoe ; id 100
    dw TargetFirstFoe ; id 101
    dw TargetFirstFoe ; id 102
    dw TargetFoeWeightedBySlotOrder ; id 103
    dw TargetSelf ; id 104
    dw TargetFoeWeightedBySlotOrder ; id 105
    dw TargetFoeWeightedBySlotOrder ; id 106
    dw TargetFoeWeightedBySlotOrder ; id 107
    dw TargetRandomOtherSlot ; id 108
    dw TargetFoeWeightedBySlotOrder ; id 109
    dw TargetFoeWeightedBySlotOrder ; id 110
    dw TargetFoeWeightedBySlotOrder ; id 111
    dw TargetFoeWeightedBySlotOrder ; id 112
    dw TargetFirstFoe ; id 113
    dw TargetFirstFoe ; id 114
    dw TargetFirstFoe ; id 115
    dw TargetFirstFoe ; id 116
    dw TargetFirstFoe ; id 117
    dw ChooseTarget_OddDance_69BF ; id 118
    dw ChooseTarget_OddDance_69BF ; id 119
    dw TargetFirstFoe ; id 120
    dw TargetFirstFoe ; id 121
    dw TargetFirstFoe ; id 122
    dw TargetOwnSideFirstSlot ; id 123
    dw TargetFirstAlly ; id 124
    dw TargetSelf ; id 125
    dw TargetFirstFoe ; id 126
    dw TargetFirstFoe ; id 127
    dw TargetFirstFoe ; id 128
    dw TargetFirstAlly ; id 129
    dw ChooseTarget_UltraDown_69AD ; id 130
    dw TargetFirstFoe ; id 131
    dw TargetFirstFoe ; id 132
    dw TargetSelf ; id 133
    dw TargetSelf ; id 134
    dw TargetSelf ; id 135
    dw TargetSelf ; id 136
    dw TargetSelf ; id 137
    dw TargetSelf ; id 138
    dw TargetFoeWeightedBySlotOrder ; id 139
    dw ChooseTarget_SickLick_69B6 ; id 140
    dw ChooseTarget_LegSweep_69B9 ; id 141
    dw TargetFirstFoe ; id 142
    dw TargetFoeWeightedBySlotOrder ; id 143
    dw TargetFirstFoe ; id 144
    dw TargetRandomFoe ; id 145
    dw TargetFirstFoe ; id 146
    dw ChooseTarget_MouthShut_69B3 ; id 147
    dw TargetSelf ; id 148
    dw TargetSelf ; id 149
    dw TargetSelf ; id 150
    dw ChooseTarget_Cover_69B0 ; id 151
    dw TargetFirstAlly ; id 152
    dw TargetSelf ; id 153
    dw TargetFirstAlly ; id 154
    dw TargetSelf ; id 155
    dw TargetSelf ; id 156
    dw TargetSelf ; id 157
    dw TargetSelf ; id 158
    dw TargetSelf ; id 159
    dw TargetSelf ; id 160
    dw TargetSelf ; id 161
    dw $0000 ; id 162
    dw $0000 ; id 163
    dw $0000 ; id 164
    dw $0000 ; id 165
    dw $0000 ; id 166
    dw $0000 ; id 167
    dw $0000 ; id 168
    dw $0000 ; id 169
    dw TargetRandomFoe ; id 170
    dw TargetSelf ; id 171
    dw TargetSelf ; id 172
    dw TargetFoeWeightedBySlotOrder ; id 173
    dw TargetSelf ; id 174
    dw $0000 ; id 175
    dw TargetFirstFoe ; id 176
    dw TargetFirstAlly ; id 177
    dw TargetFirstFoe ; id 178
    dw TargetFirstFoe ; id 179
    dw TargetFirstAlly ; id 180
    dw TargetFirstFoe ; id 181
    dw TargetFirstFoe ; id 182
    dw TargetSelf ; id 183
    dw TargetSelf ; id 184
    dw TargetFirstFoe ; id 185
    dw TargetFirstFoe ; id 186
    dw TargetOwnSideFirstSlot ; id 187
    dw TargetFirstAlly ; id 188
    dw TargetFirstFoe ; id 189
    dw $0000 ; id 190
    dw TargetSelf ; id 191
    dw TargetRandomOtherAlly ; id 192
    dw TargetRandomFoe ; id 193
    dw TargetSelf ; id 194
    dw TargetSelf ; id 195
    dw TargetSelf ; id 196
    dw TargetSelf ; id 197
    dw TargetSelf ; id 198
    dw TargetSelf ; id 199
    dw TargetSelf ; id 200
    dw TargetSelf ; id 201
    dw TargetSelf ; id 202
    dw TargetSelf ; id 203
    dw TargetFoeWeightedBySlotOrder ; id 204
    dw TargetSelf ; id 205
    dw TargetOwnSideFirstSlot ; id 206
    dw TargetFirstAlly ; id 207
    dw TargetFirstFoe ; id 208
    dw TargetFoeWeightedBySlotOrder ; id 209
    dw TargetFoeWeightedBySlotOrder ; id 210
    dw TargetFoeWeightedBySlotOrder ; id 211
    dw TargetFoeWeightedBySlotOrder ; id 212
    dw TargetFirstFoe ; id 213
    dw TargetFirstFoe ; id 214
    dw TargetFoeWeightedBySlotOrder ; id 215
    dw TargetFoeWeightedBySlotOrder ; id 216
    dw TargetFirstFoe ; id 217
    dw TargetFirstAlly ; id 218
    dw TargetFirstFoe ; id 219
    dw TargetSelf ; id 220
    dw TargetFirstAlly ; id 221
    dw TargetFirstFoe ; id 222
    dw TargetFoeWeightedBySlotOrder ; id 223
    dw TargetSelf ; id 224
    dw TargetFirstFoe ; id 225
    dw TargetSelf ; id 226
    dw TargetSelf ; id 227

; table 8 of ActionTargetModeTable (mode 4, near side); 228 code words, one per action id, as
; SkillTable (E-0204) (E-0219, C1)
; record: target routine for this action id
ActionTargetRoutines8::
    dw ChooseTarget_SquallHit_543C ; id 0
    dw ChooseTarget_Blaze ; id 1
    dw ChooseTarget_Blaze ; id 2
    dw ChooseTarget_Blaze ; id 3
    dw TargetFirstFoe ; id 4
    dw TargetFirstFoe ; id 5
    dw TargetFirstFoe ; id 6
    dw TargetFirstFoe ; id 7
    dw TargetFirstFoe ; id 8
    dw TargetFirstFoe ; id 9
    dw TargetFirstFoe ; id 10
    dw TargetFirstFoe ; id 11
    dw TargetFirstFoe ; id 12
    dw TargetFirstFoe ; id 13
    dw TargetFirstFoe ; id 14
    dw TargetFirstFoe ; id 15
    dw TargetFirstFoe ; id 16
    dw TargetFirstFoe ; id 17
    dw TargetFirstFoe ; id 18
    dw ChooseTarget_Beat ; id 19
    dw TargetFirstFoe ; id 20
    dw TargetFirstFoe ; id 21
    dw ChooseTarget_Heal_5593 ; id 22
    dw ChooseTarget_Heal_5593 ; id 23
    dw ChooseTarget_Heal_5593 ; id 24
    dw TargetFirstAlly ; id 25
    dw TargetFirstAlly ; id 26
    dw TargetRandomOtherAlly ; id 27
    dw TargetRandomOtherAlly ; id 28
    dw TargetRandomOtherAlly ; id 29
    dw ChooseTarget_Vivify ; id 30
    dw ChooseTarget_Vivify ; id 31
    dw TargetOwnSideFirstSlot ; id 32
    dw ChooseTarget_Antidote ; id 33
    dw TargetFirstAlly ; id 34
    dw TargetFirstAlly ; id 35
    dw TargetFirstAlly ; id 36
    dw ChooseTarget_Upper ; id 37
    dw TargetFirstAlly ; id 38
    dw ChooseTarget_Sap ; id 39
    dw TargetFirstFoe ; id 40
    dw ChooseTarget_Speed ; id 41
    dw TargetFirstAlly ; id 42
    dw ChooseTarget_Slow ; id 43
    dw TargetFirstFoe ; id 44
    dw ChooseTarget_TwinHits ; id 45
    dw TargetFirstFoe ; id 46
    dw ChooseTarget_Sleep ; id 47
    dw TargetFirstFoe ; id 48
    dw TargetSelf ; id 49
    dw ChooseTarget_RobMagic ; id 50
    dw TargetFirstFoe ; id 51
    dw TargetFirstFoe ; id 52
    dw TargetFirstAlly ; id 53
    dw TargetSelf ; id 54
    dw TargetSelf ; id 55
    dw TargetFirstAlly ; id 56
    dw TargetFirstAlly ; id 57
    dw ChooseTarget_Transform ; id 58
    dw TargetSelf ; id 59
    dw TargetSelf ; id 60
    dw ChooseTarget_MegaMagic ; id 61
    dw TargetFirstFoe ; id 62
    dw TargetFirstFoe ; id 63
    dw TargetFirstFoe ; id 64
    dw TargetFirstFoe ; id 65
    dw TargetFirstFoe ; id 66
    dw TargetFirstFoe ; id 67
    dw TargetFirstFoe ; id 68
    dw TargetFirstFoe ; id 69
    dw TargetFirstFoe ; id 70
    dw TargetFirstFoe ; id 71
    dw ChooseTarget_WindBeast ; id 72
    dw TargetFirstFoe ; id 73
    dw TargetFirstFoe ; id 74
    dw TargetFirstFoe ; id 75
    dw ChooseTarget_Watershot ; id 76
    dw TargetFirstFoe ; id 77
    dw TargetRandomFoe ; id 78
    dw TargetRandomFoe ; id 79
    dw ChooseTarget_FireSlash ; id 80
    dw ChooseTarget_VacuSlash ; id 81
    dw ChooseTarget_BoltSlash ; id 82
    dw ChooseTarget_IceSlash ; id 83
    dw ChooseTarget_SlimeBlow ; id 84
    dw ChooseTarget_DrakSlash ; id 85
    dw ChooseTarget_BeastCut ; id 86
    dw ChooseTarget_BirdBlow ; id 87
    dw ChooseTarget_BugBlow ; id 88
    dw ChooseTarget_Shears ; id 89
    dw ChooseTarget_DevilCut ; id 90
    dw ChooseTarget_ZombieCut ; id 91
    dw ChooseTarget_CleanCut ; id 92
    dw ChooseTarget_AquaCut ; id 93
    dw ChooseTarget_MetalCut ; id 94
    dw ChooseTarget_PoisonHit ; id 95
    dw ChooseTarget_Paralyze ; id 96
    dw ChooseTarget_NapAttack ; id 97
    dw ChooseTarget_SquallHit_543C ; id 98
    dw ChooseTarget_SquallHit_543C ; id 99
    dw TargetRandomFoe ; id 100
    dw TargetFirstFoe ; id 101
    dw TargetFirstFoe ; id 102
    dw ChooseTarget_GigaSlash ; id 103
    dw TargetSelf ; id 104
    dw ChooseTarget_SquallHit_543C ; id 105
    dw ChooseTarget_SquallHit_543C ; id 106
    dw ChooseTarget_SquallHit_543C ; id 107
    dw TargetRandomOtherSlot ; id 108
    dw ChooseTarget_SquallHit_543C ; id 109
    dw ChooseTarget_SquallHit_543C ; id 110
    dw ChooseTarget_Ramming ; id 111
    dw ChooseTarget_Ramming ; id 112
    dw TargetFirstFoe ; id 113
    dw TargetFirstFoe ; id 114
    dw TargetFirstFoe ; id 115
    dw TargetFirstFoe ; id 116
    dw TargetFirstFoe ; id 117
    dw ChooseTarget_OddDance ; id 118
    dw ChooseTarget_OddDance ; id 119
    dw TargetFirstFoe ; id 120
    dw TargetFirstFoe ; id 121
    dw TargetFirstFoe ; id 122
    dw TargetOwnSideFirstSlot ; id 123
    dw TargetFirstAlly ; id 124
    dw TargetSelf ; id 125
    dw TargetFirstFoe ; id 126
    dw TargetFirstFoe ; id 127
    dw TargetFirstFoe ; id 128
    dw TargetFirstAlly ; id 129
    dw ChooseTarget_UltraDown ; id 130
    dw TargetFirstFoe ; id 131
    dw TargetFirstFoe ; id 132
    dw TargetSelf ; id 133
    dw TargetSelf ; id 134
    dw TargetSelf ; id 135
    dw TargetSelf ; id 136
    dw TargetSelf ; id 137
    dw TargetSelf ; id 138
    dw ChooseTarget_LushLicks ; id 139
    dw ChooseTarget_SickLick ; id 140
    dw ChooseTarget_LegSweep ; id 141
    dw TargetFirstFoe ; id 142
    dw ChooseTarget_LushLicks ; id 143
    dw TargetFirstFoe ; id 144
    dw TargetRandomFoe ; id 145
    dw TargetFirstFoe ; id 146
    dw ChooseTarget_MouthShut ; id 147
    dw TargetSelf ; id 148
    dw TargetSelf ; id 149
    dw TargetSelf ; id 150
    dw ChooseTarget_Cover ; id 151
    dw TargetFirstAlly ; id 152
    dw TargetSelf ; id 153
    dw TargetFirstAlly ; id 154
    dw TargetSelf ; id 155
    dw TargetSelf ; id 156
    dw TargetSelf ; id 157
    dw TargetSelf ; id 158
    dw TargetSelf ; id 159
    dw TargetSelf ; id 160
    dw TargetSelf ; id 161
    dw $0000 ; id 162
    dw $0000 ; id 163
    dw $0000 ; id 164
    dw $0000 ; id 165
    dw $0000 ; id 166
    dw $0000 ; id 167
    dw $0000 ; id 168
    dw $0000 ; id 169
    dw TargetRandomFoe ; id 170
    dw TargetSelf ; id 171
    dw TargetSelf ; id 172
    dw $0000 ; id 173
    dw $0000 ; id 174
    dw $0000 ; id 175
    dw TargetFirstFoe ; id 176
    dw TargetFirstAlly ; id 177
    dw TargetFirstFoe ; id 178
    dw TargetFirstFoe ; id 179
    dw TargetFirstAlly ; id 180
    dw TargetFirstFoe ; id 181
    dw TargetFirstFoe ; id 182
    dw TargetSelf ; id 183
    dw TargetSelf ; id 184
    dw TargetFirstFoe ; id 185
    dw TargetFirstFoe ; id 186
    dw TargetOwnSideFirstSlot ; id 187
    dw TargetFirstAlly ; id 188
    dw TargetFirstFoe ; id 189
    dw $0000 ; id 190
    dw TargetSelf ; id 191
    dw TargetRandomOtherAlly ; id 192
    dw TargetRandomFoe ; id 193
    dw TargetSelf ; id 194
    dw TargetSelf ; id 195
    dw TargetSelf ; id 196
    dw TargetSelf ; id 197
    dw TargetSelf ; id 198
    dw TargetSelf ; id 199
    dw TargetSelf ; id 200
    dw TargetSelf ; id 201
    dw TargetSelf ; id 202
    dw TargetSelf ; id 203
    dw TargetSavedSlotOrRandomFoe ; id 204
    dw TargetSelf ; id 205
    dw TargetOwnSideFirstSlot ; id 206
    dw TargetFirstAlly ; id 207
    dw TargetFirstFoe ; id 208
    dw ChooseTarget_Blaze ; id 209
    dw ChooseTarget_SquallHit_543C ; id 210
    dw ChooseTarget_SquallHit_543C ; id 211
    dw ChooseTarget_SquallHit_543C ; id 212
    dw TargetFirstFoe ; id 213
    dw TargetFirstFoe ; id 214
    dw ChooseTarget_SquallHit_543C ; id 215
    dw ChooseTarget_SquallHit_543C ; id 216
    dw TargetFirstFoe ; id 217
    dw TargetFirstAlly ; id 218
    dw TargetFirstFoe ; id 219
    dw TargetSelf ; id 220
    dw TargetFirstAlly ; id 221
    dw TargetFirstFoe ; id 222
    dw ChooseTarget_Blaze ; id 223
    dw TargetSelf ; id 224
    dw TargetFirstFoe ; id 225
    dw TargetSelf ; id 226
    dw TargetSelf ; id 227

; table 9 of ActionTargetModeTable (mode 4, far side); 228 code words, one per action id, as
; SkillTable (E-0204) (E-0219, C1)
ActionTargetRoutines9::
    dw ChooseTarget_SquallHit_66C5 ; id 0
    dw ChooseTarget_Blaze_6A0A ; id 1
    dw ChooseTarget_Blaze_6A0A ; id 2
    dw ChooseTarget_Blaze_6A0A ; id 3
    dw TargetFirstFoe ; id 4
    dw TargetFirstFoe ; id 5
    dw TargetFirstFoe ; id 6
    dw TargetFirstFoe ; id 7
    dw TargetFirstFoe ; id 8
    dw TargetFirstFoe ; id 9
    dw TargetFirstFoe ; id 10
    dw TargetFirstFoe ; id 11
    dw TargetFirstFoe ; id 12
    dw TargetFirstFoe ; id 13
    dw TargetFirstFoe ; id 14
    dw TargetFirstFoe ; id 15
    dw TargetFirstFoe ; id 16
    dw TargetFirstFoe ; id 17
    dw TargetFirstFoe ; id 18
    dw ChooseTarget_Beat_6A07 ; id 19
    dw TargetFirstFoe ; id 20
    dw TargetFirstFoe ; id 21
    dw ChooseTarget_Heal_68B0 ; id 22
    dw ChooseTarget_Heal_68B0 ; id 23
    dw ChooseTarget_Heal_68B0 ; id 24
    dw TargetFirstAlly ; id 25
    dw TargetFirstAlly ; id 26
    dw TargetRandomOtherAlly ; id 27
    dw TargetRandomOtherAlly ; id 28
    dw TargetRandomOtherAlly ; id 29
    dw ChooseTarget_Vivify_6998 ; id 30
    dw ChooseTarget_Vivify_6998 ; id 31
    dw TargetOwnSideFirstSlot ; id 32
    dw ChooseTarget_Antidote_699B ; id 33
    dw TargetFirstAlly ; id 34
    dw TargetFirstAlly ; id 35
    dw TargetFirstAlly ; id 36
    dw ChooseTarget_Upper_69A1 ; id 37
    dw TargetFirstAlly ; id 38
    dw ChooseTarget_Sap_69A4 ; id 39
    dw TargetFirstFoe ; id 40
    dw ChooseTarget_Speed_69AA ; id 41
    dw TargetFirstAlly ; id 42
    dw ChooseTarget_Slow_69A7 ; id 43
    dw TargetFirstFoe ; id 44
    dw ChooseTarget_TwinHits_699E ; id 45
    dw TargetFirstFoe ; id 46
    dw ChooseTarget_Sleep_6A10 ; id 47
    dw TargetFirstFoe ; id 48
    dw TargetSelf ; id 49
    dw ChooseTarget_RobMagic_6A13 ; id 50
    dw TargetFirstFoe ; id 51
    dw $0000 ; id 52
    dw TargetSelf ; id 53
    dw TargetSelf ; id 54
    dw TargetSelf ; id 55
    dw TargetFirstAlly ; id 56
    dw TargetFirstAlly ; id 57
    dw ChooseTarget_Transform_6A04 ; id 58
    dw TargetSelf ; id 59
    dw TargetSelf ; id 60
    dw ChooseTarget_MegaMagic_6AFA ; id 61
    dw TargetFirstFoe ; id 62
    dw TargetFirstFoe ; id 63
    dw TargetFirstFoe ; id 64
    dw TargetFirstFoe ; id 65
    dw TargetFirstFoe ; id 66
    dw TargetFirstFoe ; id 67
    dw TargetFirstFoe ; id 68
    dw TargetFirstFoe ; id 69
    dw TargetFirstFoe ; id 70
    dw TargetFirstFoe ; id 71
    dw ChooseTarget_WindBeast_6A22 ; id 72
    dw TargetFirstFoe ; id 73
    dw TargetFirstFoe ; id 74
    dw TargetFirstFoe ; id 75
    dw ChooseTarget_Watershot_6A99 ; id 76
    dw TargetFirstFoe ; id 77
    dw TargetRandomFoe ; id 78
    dw TargetRandomFoe ; id 79
    dw ChooseTarget_FireSlash_6A16 ; id 80
    dw ChooseTarget_VacuSlash_6A1C ; id 81
    dw ChooseTarget_BoltSlash_6A19 ; id 82
    dw ChooseTarget_IceSlash_6A1F ; id 83
    dw ChooseTarget_SlimeBlow_69E9 ; id 84
    dw ChooseTarget_DrakSlash_69C5 ; id 85
    dw ChooseTarget_BeastCut_69CB ; id 86
    dw ChooseTarget_BirdBlow_69D1 ; id 87
    dw ChooseTarget_BugBlow_69EF ; id 88
    dw ChooseTarget_Shears_69F5 ; id 89
    dw ChooseTarget_DevilCut_69D7 ; id 90
    dw ChooseTarget_ZombieCut_69DD ; id 91
    dw ChooseTarget_CleanCut_69E3 ; id 92
    dw ChooseTarget_AquaCut_6A96 ; id 93
    dw ChooseTarget_MetalCut_69C2 ; id 94
    dw ChooseTarget_PoisonHit_69FB ; id 95
    dw ChooseTarget_Paralyze_69FE ; id 96
    dw ChooseTarget_NapAttack_69BC ; id 97
    dw ChooseTarget_SquallHit_66C5 ; id 98
    dw ChooseTarget_SquallHit_66C5 ; id 99
    dw TargetRandomFoe ; id 100
    dw TargetFirstFoe ; id 101
    dw TargetFirstFoe ; id 102
    dw ChooseTarget_GigaSlash_6A25 ; id 103
    dw TargetSelf ; id 104
    dw ChooseTarget_SquallHit_66C5 ; id 105
    dw ChooseTarget_SquallHit_66C5 ; id 106
    dw ChooseTarget_SquallHit_66C5 ; id 107
    dw TargetRandomOtherSlot ; id 108
    dw ChooseTarget_SquallHit_66C5 ; id 109
    dw ChooseTarget_Berserker ; id 110
    dw ChooseTarget_Berserker ; id 111
    dw ChooseTarget_SquallHit_66C5 ; id 112
    dw TargetFirstFoe ; id 113
    dw TargetFirstFoe ; id 114
    dw TargetFirstFoe ; id 115
    dw TargetFirstFoe ; id 116
    dw TargetFirstFoe ; id 117
    dw ChooseTarget_OddDance_69BF ; id 118
    dw ChooseTarget_OddDance_69BF ; id 119
    dw TargetFirstFoe ; id 120
    dw TargetFirstFoe ; id 121
    dw TargetFirstFoe ; id 122
    dw TargetOwnSideFirstSlot ; id 123
    dw TargetFirstAlly ; id 124
    dw TargetSelf ; id 125
    dw TargetFirstFoe ; id 126
    dw TargetFirstFoe ; id 127
    dw TargetFirstFoe ; id 128
    dw TargetFirstAlly ; id 129
    dw ChooseTarget_UltraDown_69AD ; id 130
    dw TargetFirstFoe ; id 131
    dw TargetFirstFoe ; id 132
    dw TargetSelf ; id 133
    dw TargetSelf ; id 134
    dw TargetSelf ; id 135
    dw TargetSelf ; id 136
    dw TargetSelf ; id 137
    dw TargetSelf ; id 138
    dw ChooseTarget_LushLicks_6A01 ; id 139
    dw ChooseTarget_SickLick_69B6 ; id 140
    dw ChooseTarget_LegSweep_69B9 ; id 141
    dw TargetFirstFoe ; id 142
    dw ChooseTarget_LushLicks_6A01 ; id 143
    dw TargetFirstFoe ; id 144
    dw TargetRandomFoe ; id 145
    dw TargetFirstFoe ; id 146
    dw ChooseTarget_MouthShut_69B3 ; id 147
    dw TargetSelf ; id 148
    dw TargetSelf ; id 149
    dw TargetSelf ; id 150
    dw ChooseTarget_Cover_69B0 ; id 151
    dw TargetFirstAlly ; id 152
    dw TargetSelf ; id 153
    dw TargetFirstAlly ; id 154
    dw TargetSelf ; id 155
    dw TargetSelf ; id 156
    dw TargetSelf ; id 157
    dw TargetSelf ; id 158
    dw TargetSelf ; id 159
    dw TargetSelf ; id 160
    dw TargetSelf ; id 161
    dw $0000 ; id 162
    dw $0000 ; id 163
    dw $0000 ; id 164
    dw $0000 ; id 165
    dw $0000 ; id 166
    dw $0000 ; id 167
    dw $0000 ; id 168
    dw $0000 ; id 169
    dw TargetRandomFoe ; id 170
    dw TargetSelf ; id 171
    dw TargetSelf ; id 172
    dw ChooseTarget_PanicAll ; id 173
    dw TargetSelf ; id 174
    dw $0000 ; id 175
    dw TargetFirstFoe ; id 176
    dw TargetFirstAlly ; id 177
    dw TargetFirstFoe ; id 178
    dw TargetFirstFoe ; id 179
    dw TargetFirstAlly ; id 180
    dw TargetFirstFoe ; id 181
    dw TargetFirstFoe ; id 182
    dw TargetSelf ; id 183
    dw TargetSelf ; id 184
    dw TargetFirstFoe ; id 185
    dw TargetFirstFoe ; id 186
    dw TargetOwnSideFirstSlot ; id 187
    dw TargetFirstAlly ; id 188
    dw TargetFirstFoe ; id 189
    dw $0000 ; id 190
    dw TargetSelf ; id 191
    dw TargetRandomOtherAlly ; id 192
    dw TargetRandomFoe ; id 193
    dw TargetSelf ; id 194
    dw TargetSelf ; id 195
    dw TargetSelf ; id 196
    dw TargetSelf ; id 197
    dw TargetSelf ; id 198
    dw TargetSelf ; id 199
    dw TargetSelf ; id 200
    dw TargetSelf ; id 201
    dw TargetSelf ; id 202
    dw TargetSelf ; id 203
    dw ChooseTarget_SquallHit_66C5 ; id 204
    dw TargetSelf ; id 205
    dw TargetOwnSideFirstSlot ; id 206
    dw TargetFirstAlly ; id 207
    dw TargetFirstFoe ; id 208
    dw ChooseTarget_Blaze_6A0A ; id 209
    dw ChooseTarget_SquallHit_66C5 ; id 210
    dw ChooseTarget_SquallHit_66C5 ; id 211
    dw ChooseTarget_SquallHit_66C5 ; id 212
    dw TargetFirstFoe ; id 213
    dw TargetFirstFoe ; id 214
    dw ChooseTarget_SquallHit_66C5 ; id 215
    dw ChooseTarget_SquallHit_66C5 ; id 216
    dw TargetFirstFoe ; id 217
    dw TargetFirstAlly ; id 218
    dw TargetFirstFoe ; id 219
    dw TargetSelf ; id 220
    dw TargetFirstAlly ; id 221
    dw TargetFirstFoe ; id 222
    dw ChooseTarget_Blaze_6A0A ; id 223
    dw TargetSelf ; id 224
    dw TargetFirstFoe ; id 225
    dw TargetSelf ; id 226
    dw TargetSelf ; id 227

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 0 (no name), 98 SquallHit, 99 BiAttack, 105
; PsycheUp, 106 HighJump, 107 EvilSlash, 109 TwinSlash, 110 Berserker, $D2, $D3 ...; writes the
; target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_SquallHit::
    ld hl, wBattleDamageLo
    ld bc, $0008
    xor a
    call FillBytes
    ld a, [wBattleActor]
    and $04
    xor $04
    ld [wBattleTarget], a
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    call SlotStatus4Bits23
    jr z, .read_battle_target

.next:
    inc c
    dec b
    jr nz, .loop
    call EstimateAndPickWeakestTarget
    jp .read_battle_actor

.read_battle_target:
    ld b, $03
    ld a, [wBattleTarget]
    ld c, a

.loop2:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next2
    call AnySlotStatusMaskSet
    jr z, .read_battle_target2

.next2:
    inc c
    dec b
    jr nz, .loop2
    call EstimateThreeTargets
    jp .read_battle_actor

.read_battle_target2:
    ld b, $03
    ld a, [wBattleTarget]
    ld c, a

.loop3:
    push bc
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .set_battle_damage_lo_to_FF
    call AnySlotStatusMaskSet
    jr nz, .set_battle_damage_lo_to_FF
    call ComputeDamageEstimateForAction
    ld a, c
    call GetBattleHP_Bank39
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wBattleDamageHi]
    ld b, a
    ld a, l
    sub c
    ld l, a
    ld a, h
    sbc b
    ld h, a
    jr nc, .set_battle_damage_lo
    ld hl, $0000

.set_battle_damage_lo:
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    jr .call_multiply_damage_by50_if_slot_damage

.set_battle_damage_lo_to_FF:
    ld a, $ff
    ld [wBattleDamageLo], a
    ld [wBattleDamageHi], a

.call_multiply_damage_by50_if_slot_damage:
    pop bc
    call MultiplyDamageBy50IfSlotDamageFlagsBit0
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    call StoreHLToTargetEstimatesSlotC
    inc c
    dec b
    jr nz, .loop3
    call PickWeakestEstimatedTarget

.read_battle_actor:
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    ld a, [wBattleTarget]
    ld [hl], a
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 0 (no name), 98 SquallHit, 99 BiAttack, 105
; PsycheUp, 106 HighJump, 107 EvilSlash, 109 TwinSlash, 110 Berserker, $D2, $D3 ...; writes the
; target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_SquallHit_543C::
    ld hl, wBattleDamageLo
    ld bc, $0008
    xor a
    call FillBytes
    ld a, [wBattleActor]
    and $04
    xor $04
    ld [wBattleTarget], a
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    call SlotStatus4Bits23
    jr z, .read_battle_target

.next:
    inc c
    dec b
    jr nz, .loop
    call EstimateAndPickWeakestTarget
    jp .read_battle_actor

.read_battle_target:
    ld b, $03
    ld a, [wBattleTarget]
    ld c, a

.loop2:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next2
    call AnySlotStatusMaskSet
    jr z, .read_battle_target2
    call TestSlotStatus2Bit3OrStatus5Bits67
    jr z, .read_battle_target2

.next2:
    inc c
    dec b
    jr nz, .loop2
    call EstimateThreeTargets
    jp .read_battle_actor

.read_battle_target2:
    ld b, $03
    ld a, [wBattleTarget]
    ld c, a

.loop3:
    ld a, c
    call AnySlotStatusMaskSet
    jr nz, .next3
    call TestSlotStatus2Bit3OrStatus5Bits67
    jr nz, .next3
    ld a, c
    call CheckSlotStatusBlock
    jr nc, .read_battle_target3

.next3:
    inc c
    dec b
    jr nz, .loop3
    call EstimateThreeTargets
    jp .read_battle_actor

.read_battle_target3:
    ld b, $03
    ld a, [wBattleTarget]
    ld c, a

.loop4:
    push bc
    ld a, c
    call CheckSlotStatusBlock
    jr c, .set_battle_damage_lo_to_FF
    call AnySlotStatusMaskSet
    jr nz, .set_battle_damage_lo_to_FF
    call TestSlotStatus2Bit3OrStatus5Bits67
    jr nz, .set_battle_damage_lo_to_FF
    ld a, c
    call ComputeDamageEstimateForAction
    ld a, c
    call GetBattleHP_Bank39
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wBattleDamageHi]
    ld b, a
    ld a, l
    sub c
    ld l, a
    ld a, h
    sbc b
    ld h, a
    jr nc, .set_battle_damage_lo
    ld hl, $0000

.set_battle_damage_lo:
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    jr .call_multiply_damage_by50_if_slot_damage

.set_battle_damage_lo_to_FF:
    ld a, $ff
    ld [wBattleDamageLo], a
    ld [wBattleDamageHi], a

.call_multiply_damage_by50_if_slot_damage:
    pop bc
    call MultiplyDamageBy50IfSlotDamageFlagsBit0
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    call StoreHLToTargetEstimatesSlotC
    inc c
    dec b
    jr nz, .loop4
    call PickWeakestEstimatedTarget

.read_battle_actor:
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    ld a, [wBattleTarget]
    ld [hl], a
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 22 Heal, 23 HealMore, 24 HealAll; writes the
; target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_Heal::
    ld a, [wBattleActor]
    and $04
    ld e, a
    ld d, $03

ChooseTarget_Heal_Loop::
    ld a, e
    ld [wBattleArg3], a
    ld a, d
    ld [wNameSlot], a
    ld a, e
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, .skip
    ld bc, $0000
    ld hl, $0000
    jr .read_battle_arg3

.skip:
    ld a, e
    ld hl, wBattleHP
    add a
    add_a_to_hl
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, e
    call GetBattleMaxHP_Bank39
    call CompareHLToBC
    jr nz, .call_divide_hl_by_bc
    ld bc, $0001
    ld hl, $0000
    jr .read_battle_arg3

.call_divide_hl_by_bc:
    call DivideHLByBC

.read_battle_arg3:
    push hl
    ld a, [wBattleArg3]
    ld e, a
    ld a, [wNameSlot]
    ld d, a
    ld a, $03
    sub d
    ld hl, wBattleTempBuf
    add a
    add_a_to_hl
    ld [hl], c
    inc hl
    ld [hl], b
    pop bc
    ld a, [wBattleArg3]
    ld e, a
    ld a, [wNameSlot]
    ld d, a
    ld a, $03
    sub d
    ld hl, wTargetEstimates
    add a
    add_a_to_hl
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [wBattleArg3]
    ld e, a
    ld a, [wNameSlot]
    ld d, a
    inc e
    dec d
    jr nz, ChooseTarget_Heal_Loop
    call ChooseTarget_Heal_WriteTemp0AndTemp1Etc
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 22 Heal, 23 HealMore, 24 HealAll; writes the
; target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_Heal_5593::
    ld a, [wBattleActor]
    and $04
    ld e, a
    ld d, $03
    xor a
    ld [wBattleArg0], a
    ld b, d
    ld c, e
    xor a
    ld hl, hTemp0
    ld [hli], a
    ld [hli], a
    ld [hl], a

.loop:
    ld a, c
    ld [wBattleArg3], a
    ld a, b
    ld [wNameSlot], a
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .read_battle_arg3
    ld hl, wBattleArg0
    inc [hl]
    ld a, c
    call GetBattleMaxHP_Bank39
    ld a, c
    ld de, wSlotBodyFlags
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    bit 0, a
    jr z, .read_temp0
    ld a, $1e
    call Multiply8By16
    jr .read_temp02

.read_temp0:
    ld e, $00

.read_temp02:
    ldh a, [hTemp0]
    add l
    ldh [hTemp0], a
    ldh a, [hTemp1]
    adc h
    ldh [hTemp1], a
    ldh a, [hTemp2]
    adc e
    ldh [hTemp2], a

.read_battle_arg3:
    ld a, [wBattleArg3]
    ld c, a
    ld a, [wNameSlot]
    ld b, a
    inc c
    dec b
    jr nz, .loop
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    ldh a, [hTemp2]
    ld e, a
    ld a, [wBattleArg0]
    call Divide24ByA
    ld a, [wBattleArg0]
    call Divide24ByA
    ld a, l
    ld [wBattleTempBuf], a
    ld a, h
    ld [wBattleTempBuf + $1], a
    ld a, [wBattleActor]
    and $04
    ld e, a
    ld d, $03
    ld a, $ff
    ld [wBattleArg2], a

.loop2:
    ld a, e
    ld [wBattleArg0], a
    ld a, d
    ld [wBattleArg1], a
    ld a, e
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .read_battle_arg0
    ld a, e
    ld hl, wBattleMaxHP
    add a
    add_a_to_hl
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, e
    call GetBattleHP_Bank39
    call CompareHLToBC
    jr z, .read_battle_arg0
    ld a, [wBattleTempBuf]
    ld c, a
    ld a, [wBattleTempBuf + $1]
    ld b, a
    call CompareHLToBC
    jr z, .call_advance_random
    jr nc, .read_battle_arg0
    ld a, l
    ld [wBattleTempBuf], a
    ld a, h
    ld [wBattleTempBuf + $1], a
    ld a, [wBattleArg0]
    ld [wBattleArg2], a
    jr .read_battle_arg0

.call_advance_random:
    call AdvanceRandom
    ld a, [wRandomLo]
    bit 7, a
    jr z, .read_battle_arg0
    ld a, [wBattleArg0]
    ld [wBattleArg2], a

.read_battle_arg0:
    ld a, [wBattleArg0]
    ld e, a
    ld a, [wBattleArg1]
    ld d, a
    inc e
    dec d
    jr nz, .loop2
    ld a, [wBattleArg2]
    cp $ff
    jr z, .check_battle_actor
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    ld a, [wBattleArg2]
    ld [hl], a
    ret

.check_battle_actor:
    ld a, [wBattleActor]
    and $04
    ld e, a
    ld d, $03
    jp ChooseTarget_Heal_Loop

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 30 Vivify, 31 Revive; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_Vivify::
    ld a, [wBattleActor]
    and $04
    ld c, a
    ld b, $03
    xor a
    ldh [hTemp0], a
    ld a, $ff
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a

.loop:
    ld a, c
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld a, [hl]
    cp $01
    jr nz, .next
    ld a, c
    and $03
    ld hl, hTemp1
    add_a_to_hl
    ld [hl], c
    ld hl, hTemp0
    inc [hl]

.next:
    inc c
    dec b
    jr nz, .loop
    ldh a, [hTemp0]
    or a
    jr nz, .skip
    ld a, [wBattleActor]
    ld c, a
    jr .read_battle_actor

.skip:
    ld hl, hTemp1
    ld b, $02
    ld a, [hli]
    cp $ff
    jr nz, .loop2
    ld b, $01
    ld a, [hli]
    cp $ff
    jr nz, .loop2
    ld c, [hl]
    jr .read_battle_actor

.loop2:
    ld c, a
    ld a, [hli]
    cp $ff
    jr z, .skip2
    push af
    call AdvanceRandom
    ld a, [wRandomLo]
    ld e, a
    pop af
    bit 0, e
    jr z, .skip2
    ld c, a

.skip2:
    ld a, c
    dec b
    jr nz, .loop2

.read_battle_actor:
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    ld [hl], c
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 33 Antidote; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_Antidote::
    ld a, [wBattleActor]
    and $04
    ld c, a
    ld b, $03
    xor a
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a
    ld de, hTemp1

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    and $03
    ld [de], a

.next:
    inc de
    inc c
    dec b
    jr nz, .loop
    ld hl, hTemp1
    ld bc, $0300
    ld d, $00

.loop2:
    bit 1, [hl]
    jr z, .next2
    ld a, c
    ldh [hTemp0], a
    inc d

.next2:
    inc c
    inc hl
    dec b
    jr nz, .loop2
    ld a, d
    or a
    jr z, .skip
    cp $01
    jr z, .read_battle_actor
    cp $03
    jr z, .call_advance_random
    call AdvanceRandom
    ld a, [wRandomLo]
    bit 7, a
    jr z, .read_battle_actor
    ld d, $02
    jr .skip2

.skip:
    ld hl, hTemp1
    ld bc, $0300
    ld d, $00

.loop3:
    bit 0, [hl]
    jr z, .next3
    ld a, c
    ldh [hTemp0], a
    inc d

.next3:
    inc hl
    inc c
    dec b
    jr nz, .loop3
    ld a, d
    or a
    jr nz, .cp_01
    ld a, [wBattleActor]
    and $03
    ldh [hTemp0], a
    jr .read_battle_actor

.cp_01:
    cp $01
    jr z, .read_battle_actor
    cp $03
    jr z, .call_advance_random
    call AdvanceRandom
    ld a, [wRandomLo]
    bit 7, a
    jr z, .read_battle_actor
    ld d, $01

.skip2:
    ld hl, hTemp1
    ld c, $00

.skip3:
    ld a, [hli]
    and d
    jr nz, .set_temp0
    inc c
    jr .skip3

.set_temp0:
    ld a, c
    ldh [hTemp0], a
    jr .read_battle_actor

.call_advance_random:
    call AdvanceRandom
    ld a, [wRandomLo]
    ld b, a
    ld a, $03
    call DivideBByA
    ldh [hTemp0], a

.read_battle_actor:
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    ldh a, [hTemp0]
    ld c, a
    ld a, [wBattleActor]
    and $04
    or c
    ld [hl], a
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 45 TwinHits; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_TwinHits::
    ld a, [wBattleActor]
    and $04
    ld c, a
    ld b, $03
    ld a, $ff
    ldh [hTemp0], a
    xor a
    ldh [hTemp1], a
    ldh [hTemp2], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hli]
    bit 6, a
    jr nz, .next
    bit 2, [hl]
    jr nz, .next
    ld a, c
    call GetBattleATK_Bank39
    push bc
    ldh a, [hTemp1]
    ld c, a
    ldh a, [hTemp2]
    ld b, a
    call CompareHLToBC
    pop bc
    jr z, .call_advance_random
    jr c, .next
    ld a, c
    ldh [hTemp0], a
    ld a, l
    ldh [hTemp1], a
    ld a, h
    ldh [hTemp2], a
    jr .next

.call_advance_random:
    push hl
    call AdvanceRandom
    pop hl
    ld a, [wRandomLo]
    bit 7, a
    jr z, .next
    ld a, c
    ldh [hTemp0], a
    ld a, l
    ldh [hTemp1], a
    ld a, h
    ldh [hTemp2], a

.next:
    inc c
    dec b
    jr nz, .loop
    ldh a, [hTemp0]
    cp $ff
    jr nz, .read_battle_actor
    ld a, [wBattleActor]
    ldh [hTemp0], a

.read_battle_actor:
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    ldh a, [hTemp0]
    ld c, a
    ld a, [wBattleActor]
    and $04
    or c
    ld [hl], a
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 37 Upper; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_Upper::
    ld a, [wBattleActor]
    and $04
    ld c, a
    ld b, $03
    ld a, $ff
    ldh [hTemp0], a
    ldh [hTemp1], a
    ldh [hTemp2], a

.loop:
    push bc
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .restore
    call GetBattleDEF_Bank39
    push hl
    call BuffCapOfBaseDEF
    pop bc
    call CompareHLToBC
    jr nc, .restore
    ldh a, [hTemp1]
    ld l, a
    ldh a, [hTemp2]
    ld h, a
    call CompareHLToBC
    jr c, .restore
    ld a, c
    ldh [hTemp1], a
    ld a, b
    ldh [hTemp2], a
    pop bc
    push bc
    ld a, c
    ldh [hTemp0], a

.restore:
    pop bc
    inc c
    dec b
    jr nz, .loop
    ldh a, [hTemp0]
    cp $ff
    jr nz, .check_battle_actor
    ld a, [wBattleActor]
    and $03

.check_battle_actor:
    ld c, a
    ld a, [wBattleActor]
    and $04
    or c
    ld c, a
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    ld [hl], c
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 39 Sap; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_Sap::
    ld a, [wBattleActor]
    and $04
    xor $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $ff
    ldh [hTemp0], a
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ldh [hTemp2], a
    ld hl, wBattleStatus2
    call AddAx9ToHL
    bit 1, [hl]
    jr nz, .next
    ld a, c
    ldh [hTemp3], a
    call GetBattleDEF_Bank39
    ld a, h
    or a
    jr nz, .call_read_byte_at_hl_plus4_a_plus3_c_bank39
    ld a, l
    cp $02
    jr c, .next

.call_read_byte_at_hl_plus4_a_plus3_c_bank39:
    ld a, c
    ld hl, wSlotResistances + $3
    call ReadByteAtHLPlus4APlus3C_Bank39
    and $30
    swap a
    cp $03
    jr z, .next
    ld e, a
    ldh a, [hTemp1]
    cp e
    jr c, .next
    ld a, e
    ldh [hTemp1], a
    ld a, c
    ldh [hTemp0], a

.next:
    inc c
    dec b
    jr nz, .loop
    call SetActorTargetFromHRAMChoice
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 43 Slow; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_Slow::
    ld a, [wBattleActor]
    and $04
    xor $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $ff
    ldh [hTemp0], a
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ldh [hTemp2], a
    ld hl, wBattleStatus2
    call AddAx9ToHL
    bit 1, [hl]
    jr nz, .next
    ld a, c
    ldh [hTemp3], a
    call GetBattleAGL_Bank39
    ld a, h
    or a
    jr nz, .call_read_byte_at_hl_plus4_a_plus3_c_bank39
    ld a, l
    cp $02
    jr c, .next

.call_read_byte_at_hl_plus4_a_plus3_c_bank39:
    ld a, c
    ld hl, wSlotResistances + $3
    call ReadByteAtHLPlus4APlus3C_Bank39
    and $30
    swap a
    cp $03
    jr z, .next
    ld e, a
    ldh a, [hTemp1]
    cp e
    jr c, .next
    ld a, e
    ldh [hTemp1], a
    ld a, c
    ldh [hTemp0], a

.next:
    inc c
    dec b
    jr nz, .loop
    call SetActorTargetFromHRAMChoice
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 41 Speed; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_Speed::
    ld a, [wBattleActor]
    and $04
    ld c, a
    ld b, $03
    ld a, $ff
    ldh [hTemp0], a
    ldh [hTemp1], a
    ldh [hTemp2], a

.loop:
    push bc
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .restore
    call GetBattleAGL_Bank39
    push hl
    call BuffCapOfBaseAGL
    pop bc
    call CompareHLToBC
    jr nc, .restore
    ldh a, [hTemp1]
    ld l, a
    ldh a, [hTemp2]
    ld h, a
    call CompareHLToBC
    jr c, .restore
    ld a, c
    ldh [hTemp1], a
    ld a, b
    ldh [hTemp2], a
    pop bc
    push bc
    ld a, c
    ldh [hTemp0], a

.restore:
    pop bc
    inc c
    dec b
    jr nz, .loop
    ldh a, [hTemp0]
    cp $ff
    jr nz, .check_battle_actor
    ld a, [wBattleActor]
    and $03

.check_battle_actor:
    ld c, a
    ld a, [wBattleActor]
    and $04
    or c
    ld c, a
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    ld [hl], c
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 130 UltraDown; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_UltraDown::
    ld a, [wBattleActor]
    and $04
    xor $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $ff
    ldh [hTemp0], a
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ldh [hTemp2], a
    call GetBattleDEF_Bank39
    ld a, h
    or a
    jr nz, .set_temp3
    ld a, l
    cp $02
    jr nc, .set_temp3
    ld a, c
    call GetBattleAGL_Bank39
    ld a, h
    or a
    jr nz, .set_temp3
    ld a, l
    cp $02
    jr c, .next

.set_temp3:
    ld a, c
    ldh [hTemp3], a
    ld hl, wSlotResistances + $2
    call ReadByteAtHLPlus4APlus3C_Bank39
    and $30
    swap a
    cp $03
    jr z, .next
    ld e, a
    ldh a, [hTemp1]
    cp e
    jr c, .next
    ld a, e
    ldh [hTemp1], a
    ld a, c
    ldh [hTemp0], a

.next:
    inc c
    dec b
    jr nz, .loop
    call SetActorTargetFromHRAMChoice
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 151 Cover; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_Cover::
    ld a, [wBattleActor]
    ld e, a
    and $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $ff
    ldh [hTemp0], a
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a
    ldh [hTemp4], a
    ldh [hTemp5], a

.loop:
    push bc
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .restore
    ldh [hTemp3], a
    cp e
    jr z, .restore
    ldh [hTemp4], a
    call GetBattleMaxHP_Bank39
    push hl
    ld a, c
    call GetBattleHP_Bank39
    add hl, hl
    ld c, l
    ld b, h
    add hl, hl
    add hl, hl
    add hl, bc
    pop bc
    call CompareHLToBC
    jr nc, .restore
    ldh a, [hTemp4]
    ldh [hTemp5], a
    ldh a, [hTemp1]
    ld c, a
    ldh a, [hTemp2]
    ld b, a
    call CompareHLToBC
    jr nc, .restore
    ld a, l
    ldh [hTemp1], a
    ld a, h
    ldh [hTemp2], a
    ldh a, [hTemp4]
    ldh [hTemp0], a

.restore:
    pop bc
    inc c
    dec b
    jr nz, .loop
    call ChooseTarget_Cover_ReadBattleActorAndTemp0Etc
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 147 MouthShut; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_MouthShut::
    ld a, [wBattleActor]
    and $04
    xor $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $ff
    ldh [hTemp0], a
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a
    ldh [hTemp4], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ldh [hTemp2], a
    call ChooseTarget_MouthShut_CountMouthSkills
    jr z, .next
    ld a, c
    ldh [hTemp3], a
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit BSTAT1_BREATH_SEALED, [hl]
    jr nz, .next
    ld a, c
    ldh [hTemp4], a
    ld hl, wSlotResistances + $6
    call ReadByteAtHLPlus4APlus3C_Bank39
    and $c0
    rlca
    rlca
    cp $03
    jr z, .next
    ld e, a
    ldh a, [hTemp1]
    cp e
    jr c, .next
    ld a, e
    ldh [hTemp1], a
    ld a, c
    ldh [hTemp0], a

.next:
    inc c
    dec b
    jr nz, .loop
    call SetActorTargetFromHRAMChoice4
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 140 SickLick; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_SickLick::
    ld a, [wBattleActor]
    and $04
    xor $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $ff
    ldh [hTemp0], a
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a
    ldh [hTemp4], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ldh [hTemp2], a
    call GetBattleDEF_Bank39
    ld a, h
    or a
    jr nz, .set_temp3
    ld a, l
    cp $02
    jr c, .next

.set_temp3:
    ld a, c
    ldh [hTemp3], a
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hli]
    and $cc
    jr nz, .next
    inc hl
    inc hl
    ld a, [hl]
    or a
    jr nz, .next
    ld a, c
    ldh [hTemp4], a
    ld hl, wSlotResistances + $5
    call ReadByteAtHLPlus4APlus3C_Bank39
    and $0c
    rrca
    rrca
    cp $03
    jr z, .next
    ld e, a
    ldh a, [hTemp1]
    cp e
    jr c, .next
    ld a, e
    ldh [hTemp1], a
    ld a, c
    ldh [hTemp0], a

.next:
    inc c
    dec b
    jr nz, .loop
    call SetActorTargetFromHRAMChoice4
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 141 LegSweep; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_LegSweep::
    ld a, [wBattleActor]
    and $04
    xor $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $ff
    ldh [hTemp0], a
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a
    ldh [hTemp4], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ldh [hTemp2], a
    ld hl, wSlotBodyFlags
    add_a_to_hl
    bit 4, [hl]
    jr nz, .next
    ld a, c
    ldh [hTemp3], a
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hli]
    and $dc
    jr nz, .next
    inc hl
    inc hl
    ld a, [hl]
    or a
    jr nz, .next
    ld a, c
    ldh [hTemp4], a
    ld hl, wSlotResistances + $5
    call ReadByteAtHLPlus4APlus3C_Bank39
    and $0c
    rrca
    rrca
    cp $03
    jr z, .next
    ld e, a
    ldh a, [hTemp1]
    cp e
    jr c, .next
    ld a, e
    ldh [hTemp1], a
    ld a, c
    ldh [hTemp0], a

.next:
    inc c
    dec b
    jr nz, .loop
    call SetActorTargetFromHRAMChoice4
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 97 NapAttack; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_NapAttack::
    ld a, [wBattleActor]
    and $04
    xor $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $ff
    ldh [hTemp0], a
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ldh [hTemp2], a
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hli]
    and $cc
    jr nz, .next
    inc hl
    inc hl
    ld a, [hl]
    or a
    jr nz, .next
    ld a, c
    ldh [hTemp3], a
    ld hl, wSlotResistances + $2
    call ReadByteAtHLPlus4APlus3C_Bank39
    and $c0
    rlca
    rlca
    cp $03
    jr z, .next
    ld e, a
    ldh a, [hTemp1]
    cp e
    jr c, .next
    ld a, e
    ldh [hTemp1], a
    ld a, c
    ldh [hTemp0], a

.next:
    inc c
    dec b
    jr nz, .loop
    call SetActorTargetFromHRAMChoice
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 118 OddDance, 119 RobDance; writes the
; target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_OddDance::
    ld a, [wBattleActor]
    and $04
    xor $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $ff
    ldh [hTemp0], a
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ldh [hTemp2], a
    call GetBattleMP_Bank39
    ld a, h
    or l
    jr z, .next
    ld a, c
    ldh [hTemp3], a
    ld hl, wSlotResistances + $2
    call ReadByteAtHLPlus4APlus3C_Bank39
    and $0c
    rrca
    rrca
    cp $03
    jr z, .next
    ld e, a
    ldh a, [hTemp1]
    cp e
    jr c, .next
    ld a, e
    ldh [hTemp1], a
    ld a, c
    ldh [hTemp0], a

.next:
    inc c
    dec b
    jr nz, .loop
    call SetActorTargetFromHRAMChoice
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 94 MetalCut; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_MetalCut::
    ld a, [wBattleActor]
    and $04
    xor $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $ff
    ldh [hTemp0], a
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a

.loop:
    push bc
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .restore
    ldh [hTemp3], a
    ld hl, wSlotBodyFlags
    add_a_to_hl
    bit 0, [hl]
    jr z, .restore
    ld a, c
    call GetBattleHP_Bank39
    push hl
    ld a, c
    call GetBattleDEF_Bank39
    pop bc
    add hl, bc
    ldh a, [hTemp1]
    ld c, a
    ldh a, [hTemp2]
    ld b, a
    call CompareHLToBC
    jr c, .restore
    ld a, l
    ldh [hTemp1], a
    ld a, h
    ldh [hTemp2], a
    ldh a, [hTemp3]
    ldh [hTemp0], a

.restore:
    pop bc
    inc c
    dec b
    jr nz, .loop
    call SetActorTargetFromTemp0OrTemp3
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 85 DrakSlash; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_DrakSlash::
    ld d, $01
    call TargetWeakestFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 86 BeastCut; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_BeastCut::
    ld d, $02
    call TargetWeakestFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 87 BirdBlow; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_BirdBlow::
    ld d, $03
    call TargetWeakestFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 90 DevilCut; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_DevilCut::
    ld d, $06
    call TargetWeakestFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 91 ZombieCut; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_ZombieCut::
    ld d, $07
    call TargetWeakestFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 92 CleanCut; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_CleanCut::
    ld d, $08
    call TargetWeakestFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 84 SlimeBlow; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_SlimeBlow::
    ld d, $00
    call TargetWeakestFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 88 BugBlow; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_BugBlow::
    ld d, $05
    call TargetWeakestFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 89 Shears; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_Shears::
    ld d, $04
    call TargetWeakestFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 95 PoisonHit; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_PoisonHit::
    ld a, [wBattleActor]
    and $04
    xor $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $ff
    ldh [hTemp0], a
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ldh [hTemp2], a
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    and $03
    jr nz, .next
    ld a, c
    ldh [hTemp3], a
    ld hl, wSlotResistances + $4
    call ReadByteAtHLPlus4APlus3C_Bank39
    and $03
    cp $03
    jr z, .next
    ld e, a
    ldh a, [hTemp1]
    cp e
    jr c, .next
    ld a, e
    ldh [hTemp1], a
    ld a, c
    ldh [hTemp0], a

.next:
    inc c
    dec b
    jr nz, .loop
    call SetActorTargetFromHRAMChoice
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 96 Paralyze; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_Paralyze::
    ld a, [wBattleActor]
    and $04
    xor $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $ff
    ldh [hTemp0], a
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ldh [hTemp2], a
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    and $cc
    jr nz, .next
    ld a, c
    ldh [hTemp3], a
    ld hl, wSlotResistances + $5
    call ReadByteAtHLPlus4APlus3C_Bank39
    and $c0
    rlca
    rlca
    cp $03
    jr z, .next
    ld e, a
    ldh a, [hTemp1]
    cp e
    jr c, .next
    ld a, e
    ldh [hTemp1], a
    ld a, c
    ldh [hTemp0], a

.next:
    inc c
    dec b
    jr nz, .loop
    call SetActorTargetFromHRAMChoice
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 139 LushLicks, 143 Ahhh; writes the target
; to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_LushLicks::
    ld a, [wBattleActor]
    and $04
    xor $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $ff
    ldh [hTemp0], a
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ldh [hTemp2], a
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hli]
    and $dc
    jr nz, .next
    inc hl
    inc hl
    ld a, [hl]
    or a
    jr nz, .next
    ld a, c
    ldh [hTemp3], a
    ld hl, wSlotResistances + $5
    call ReadByteAtHLPlus4APlus3C_Bank39
    and $0c
    rrca
    rrca
    cp $03
    jr z, .next
    ld e, a
    ldh a, [hTemp1]
    cp e
    jr c, .next
    ld a, e
    ldh [hTemp1], a
    ld a, c
    ldh [hTemp0], a

.next:
    inc c
    dec b
    jr nz, .loop
    call SetActorTargetFromHRAMChoice
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 58 Transform; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_Transform::
    ld a, [wBattleActor]
    and $04
    xor $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $ff
    ldh [hTemp0], a
    ldh [hTemp3], a
    xor a
    ldh [hTemp1], a
    ldh [hTemp2], a

.loop:
    push bc
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .restore
    ldh [hTemp3], a
    call GetBattleMaxHP_Bank39
    push hl
    ld a, c
    call GetBattleMaxMP_Bank39
    pop bc
    add hl, bc
    ldh a, [hTemp1]
    ld c, a
    ldh a, [hTemp2]
    ld b, a
    call CompareHLToBC
    jr c, .restore
    ld a, l
    ldh [hTemp1], a
    ld a, h
    ldh [hTemp2], a
    ldh a, [hTemp3]
    ldh [hTemp0], a

.restore:
    pop bc
    inc c
    dec b
    jr nz, .loop
    call SetActorTargetFromTemp0OrTemp3
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 19 Beat; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_Beat::
    ld a, [wBattleActor]
    and $04
    xor $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $ff
    ldh [hTemp0], a
    ldh [hTemp1], a
    ldh [hTemp2], a
    xor a
    ldh [hTemp3], a
    ldh [hTemp4], a
    ld a, $ff
    ldh [hTemp5], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld hl, wBattleStatus2
    ldh [hTemp5], a
    call AddAx9ToHL
    bit 1, [hl]
    jr nz, .next
    ld a, c
    ld hl, wSlotResistances + $2
    call ReadByteAtHLPlus4APlus3C_Bank39
    and $30
    swap a
    cp $03
    jr z, .next
    ld e, a
    ldh a, [hTemp1]
    cp e
    jr z, .skip
    jr c, .next
    ld a, e
    ldh [hTemp1], a
    xor a
    ldh [hTemp2], a

.skip:
    ld hl, hTemp2
    inc [hl]

.next:
    inc c
    dec b
    jr nz, .loop
    ldh a, [hTemp2]
    or a
    jr z, .read_temp_a
    cp $01
    jr z, .read_temp_a2
    ldh a, [hTempA]
    ld c, a
    ld b, $03

.loop2:
    push bc
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .restore
    ld hl, wBattleStatus2
    call AddAx9ToHL
    bit 1, [hl]
    jr nz, .restore
    ld a, c
    ld hl, wSlotResistances + $2
    call ReadByteAtHLPlus4APlus3C_Bank39
    and $30
    swap a
    cp $03
    jr z, .restore
    ld e, a
    ldh a, [hTemp1]
    cp e
    jr nz, .restore
    ld a, c
    call GetBattleHP_Bank39
    ldh a, [hTemp3]
    ld c, a
    ldh a, [hTemp4]
    ld b, a
    call CompareHLToBCFastZero
    jr c, .restore
    ld a, l
    ldh [hTemp3], a
    ld a, h
    ldh [hTemp4], a
    pop bc
    push bc
    ld a, c
    ldh [hTemp0], a

.restore:
    pop bc
    inc c
    dec b
    jr nz, .loop2
    jr .read_battle_actor

.read_temp_a:
    ldh a, [hTempA]
    ld c, a
    ld b, $03

.loop3:
    push bc
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .restore2
    ldh [hTemp5], a
    call GetBattleHP_Bank39
    ldh a, [hTemp3]
    ld c, a
    ldh a, [hTemp4]
    ld b, a
    call CompareHLToBCFastZero
    jr c, .restore2
    ld a, l
    ldh [hTemp3], a
    ld a, h
    ldh [hTemp4], a
    ld a, c
    ldh [hTemp0], a

.restore2:
    pop bc
    inc c
    dec b
    jr nz, .loop3
    jr .read_battle_actor

.read_temp_a2:
    ldh a, [hTempA]
    ld c, a
    ld b, $03
    ldh a, [hTemp1]
    ld e, a

.loop4:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next2
    ld hl, wSlotResistances + $2
    call ReadByteAtHLPlus4APlus3C_Bank39
    and $30
    swap a
    cp e
    jr z, .set_temp0

.next2:
    inc c
    dec b
    jr nz, .loop4

.set_temp0:
    ld a, c
    ldh [hTemp0], a

.read_battle_actor:
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    ldh a, [hTempA]
    ld e, a
    ldh a, [hTemp0]
    or e
    ld [hl], a
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 1 Blaze, 2 Blazemore, 3 Blazemost, $D1, $DF;
; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_Blaze::
    ld a, [wBattleActionId]
    ld [wRecordBuffer], a
    xor a
    ld [wRecordBuffer + $1], a
    ld a, $02
    ld [wBattleArg1], a
    ld hl, hTemp8
    ld a, l
    ld [wBattleArg2], a
    ld a, h
    ld [wBattleArg3], a
    ld e, $09
    ld a, [wLinkMode]
    cp $01
    jr z, .set_battle_arg0
    ld a, [wBattleActor]
    and $04
    jr z, .set_battle_arg0
    ld e, $0d

.set_battle_arg0:
    ld a, e
    ld [wBattleArg0], a
    farcall LoadSkillRecordPart
    ld a, [wBattleActor]
    and $04
    xor $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $ff
    ldh [hTemp0], a
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a
    ldh [hTemp4], a
    ldh [hTemp5], a
    ld [wTargetEstimates], a
    ld [wTargetEstimates + $1], a
    xor a
    ld [wBattleDamageLo], a
    ld [wBattleDamageHi], a

.loop:
    push bc
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jp c, .restore
    ldh [hTemp3], a
    ld hl, wBattleStatus2
    call AddAx9ToHL
    ld a, [hl]
    and $22
    jr nz, .restore
    ld a, c
    ldh [hTemp4], a
    ld hl, wSlotResistances
    call ReadByteAtHLPlus4APlus3C_Bank39
    and $30
    swap a
    cp $03
    jr z, .restore
    ldh [hTemp6], a
    push bc
    call ChooseTarget_Blaze_Multiply8By16
    pop bc
    push hl
    ld a, c
    call GetBattleHP_Bank39
    pop bc
    call CompareHLToBC
    jr c, .read_battle_damage_lo
    ldh a, [hTemp6]
    ld e, a
    ldh a, [hTemp1]
    cp e
    jr z, .read_target_estimates
    jr c, .restore
    ld a, e
    ldh [hTemp1], a
    ldh a, [hTemp3]
    ldh [hTemp5], a
    ld a, l
    ld [wTargetEstimates], a
    ld a, h
    ld [wTargetEstimates + $1], a
    jr .restore

.read_target_estimates:
    ld a, [wTargetEstimates]
    ld c, a
    ld a, [wTargetEstimates + $1]
    ld b, a
    call CompareHLToBC
    jr nc, .restore
    ld a, l
    ld [wTargetEstimates], a
    ld a, h
    ld [wTargetEstimates + $1], a
    ldh a, [hTemp3]
    ldh [hTemp5], a
    jr .restore

.read_battle_damage_lo:
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wBattleDamageHi]
    ld b, a
    call CompareHLToBCFastZero
    jr c, .restore
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    ldh a, [hTemp3]
    ldh [hTemp2], a

.restore:
    pop bc
    inc c
    dec b
    jp nz, .loop
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    ldh a, [hTemp2]
    cp $ff
    jr nz, .done
    ldh a, [hTemp5]
    cp $ff
    jr nz, .done
    ldh a, [hTemp3]

.done:
    ld [hl], a
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 111 Ramming, 112 Kamikaze; writes the target
; to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_Ramming::
    ld a, [wBattleActor]
    and $04
    xor $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $ff
    ldh [hTemp0], a
    ldh [hTemp3], a
    ldh [hTemp4], a
    xor a
    ldh [hTemp1], a
    ldh [hTemp2], a

.loop:
    push bc
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .restore
    ldh [hTemp3], a
    ld hl, wBattleStatus6
    call AddAx9ToHL
    ld a, [hli]
    and $20
    jr nz, .restore
    and $05
    jr nz, .restore
    ld a, c
    ld hl, wSlotResistances + $3
    call ReadByteAtHLPlus4APlus3C_Bank39
    and $03
    cp $03
    jr z, .restore
    ld e, a
    ldh a, [hTemp4]
    cp e
    jr z, .call_get_battle_hp_bank39
    jr nc, .restore
    ld a, c
    call GetBattleHP_Bank39
    jr .set_temp1

.call_get_battle_hp_bank39:
    ld a, c
    call GetBattleHP_Bank39
    ldh a, [hTemp1]
    ld c, a
    ldh a, [hTemp2]
    ld b, a
    call CompareHLToBC
    jr c, .restore

.set_temp1:
    ld a, l
    ldh [hTemp1], a
    ld a, h
    ldh [hTemp2], a
    ldh a, [hTemp3]
    ldh [hTemp0], a

.restore:
    pop bc
    inc c
    dec b
    jr nz, .loop
    ldh a, [hTemp0]
    cp $ff
    jp nz, .call_set_actor_target_from_temp0_or_temp3
    ldh a, [hTempA]
    ld c, a
    ld b, $03

.loop2:
    push bc
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .restore2
    ldh [hTemp3], a
    ld hl, wBattleStatus7
    call AddAx9ToHL
    bit BSTAT7_GUARD, [hl]
    jr nz, .restore2
    ld a, c
    call GetBattleHP_Bank39
    ldh a, [hTemp1]
    ld c, a
    ldh a, [hTemp2]
    ld b, a
    call CompareHLToBC
    jr c, .restore2
    ld a, l
    ldh [hTemp1], a
    ld a, h
    ldh [hTemp2], a
    ldh a, [hTemp3]
    ldh [hTemp0], a

.restore2:
    pop bc
    inc c
    dec b
    jr nz, .loop2
    ldh a, [hTemp0]
    cp $ff
    jr nz, .call_set_actor_target_from_temp0_or_temp3
    ldh a, [hTempA]
    ld c, a
    ld b, $03

.loop3:
    push bc
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .restore3
    ldh [hTemp3], a
    call GetBattleHP_Bank39
    ldh a, [hTemp1]
    ld c, a
    ldh a, [hTemp2]
    ld b, a
    jr c, .restore3
    ld a, l
    ldh [hTemp1], a
    ld a, h
    ldh [hTemp2], a
    ldh a, [hTemp3]
    ldh [hTemp0], a

.restore3:
    pop bc
    inc c
    dec b
    jr nz, .loop3

.call_set_actor_target_from_temp0_or_temp3:
    call SetActorTargetFromTemp0OrTemp3
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 47 Sleep; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_Sleep::
    ld a, [wBattleActor]
    and $04
    xor $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $ff
    ldh [hTemp0], a
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a
    ldh [hTemp4], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ldh [hTemp2], a
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hli]
    and $cc
    jr nz, .next
    inc hl
    inc hl
    ld a, [hld]
    or a
    jr nz, .next
    ld a, c
    ldh [hTemp3], a
    ld a, [hl]
    and $22
    jr nz, .next
    ld a, c
    ldh [hTemp4], a
    ld hl, wSlotResistances + $2
    call ReadByteAtHLPlus4APlus3C_Bank39
    and $c0
    rlca
    rlca
    cp $03
    jr z, .next
    ld e, a
    ldh a, [hTemp1]
    cp e
    jr c, .next
    ld a, e
    ldh [hTemp1], a
    ld a, c
    ldh [hTemp0], a

.next:
    inc c
    dec b
    jr nz, .loop
    call SetActorTargetFromHRAMChoice4
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 50 RobMagic; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_RobMagic::
    ld a, [wBattleActor]
    and $04
    xor $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $ff
    ldh [hTemp0], a
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ldh [hTemp2], a
    call GetBattleMP_Bank39
    ld a, h
    or l
    jr z, .next
    ld a, c
    ldh [hTemp3], a
    ld hl, wBattleStatus2
    call AddAx9ToHL
    ld a, [hl]
    and $22
    jr nz, .next
    ld a, c
    ld hl, wSlotResistances + $2
    call ReadByteAtHLPlus4APlus3C_Bank39
    and $0c
    rrca
    rrca
    cp $03
    jr z, .next
    ld e, a
    ldh a, [hTemp1]
    cp e
    jr c, .next
    ld a, e
    ldh [hTemp1], a
    ld a, c
    ldh [hTemp0], a

.next:
    inc c
    dec b
    jr nz, .loop
    call SetActorTargetFromHRAMChoice
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 80 FireSlash; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_FireSlash::
    ld a, [wBattleActor]
    and $04
    xor $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $ff
    ldh [hTemp0], a
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a
    ld [wBattleDamageLo], a
    ld [wBattleDamageHi], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ldh [hTemp2], a
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hli]
    and $c0
    jr nz, .next
    ld a, [hl]
    and $0c
    jr nz, .next
    ld a, c
    ldh [hTemp3], a
    ld hl, wSlotResistances
    call ReadByteAtHLPlus4APlus3C_Bank39
    and $30
    swap a
    ld e, a
    ldh a, [hTemp1]
    cp e
    jr z, .call_get_battle_hp_bank39
    jr c, .next
    ld a, $ff
    ld [wBattleDamageLo], a
    ld [wBattleDamageHi], a
    ld a, e
    ldh [hTemp1], a

.call_get_battle_hp_bank39:
    push bc
    ld a, c
    call GetBattleHP_Bank39
    push hl
    ld a, c
    call GetBattleDEF_Bank39
    pop bc
    add hl, bc
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wBattleDamageHi]
    ld b, a
    call CompareHLToBC
    pop bc
    jr nc, .next
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    ld a, c
    ldh [hTemp0], a

.next:
    inc c
    dec b
    jr nz, .loop
    call SetActorTargetFromHRAMChoice
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 82 BoltSlash; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_BoltSlash::
    ld a, [wBattleActor]
    and $04
    xor $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $ff
    ldh [hTemp0], a
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a
    ld [wBattleDamageLo], a
    ld [wBattleDamageHi], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ldh [hTemp2], a
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hli]
    and $c0
    jr nz, .next
    ld a, [hl]
    and $0c
    jr nz, .next
    ld a, c
    ldh [hTemp3], a
    ld hl, wSlotResistances + $1
    call ReadByteAtHLPlus4APlus3C_Bank39
    and $30
    swap a
    ld e, a
    ldh a, [hTemp1]
    cp e
    jr z, .call_get_battle_hp_bank39
    jr c, .next
    ld a, $ff
    ld [wBattleDamageLo], a
    ld [wBattleDamageHi], a
    ld a, e
    ldh [hTemp1], a

.call_get_battle_hp_bank39:
    push bc
    ld a, c
    call GetBattleHP_Bank39
    push hl
    ld a, c
    call GetBattleDEF_Bank39
    pop bc
    add hl, bc
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wBattleDamageHi]
    ld b, a
    call CompareHLToBC
    pop bc
    jr nc, .next
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    ld a, c
    ldh [hTemp0], a

.next:
    inc c
    dec b
    jr nz, .loop
    call SetActorTargetFromHRAMChoice
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 81 VacuSlash; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_VacuSlash::
    ld a, [wBattleActor]
    and $04
    xor $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $ff
    ldh [hTemp0], a
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a
    ld [wBattleDamageLo], a
    ld [wBattleDamageHi], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ldh [hTemp2], a
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hli]
    and $c0
    jr nz, .next
    ld a, [hl]
    and $0c
    jr nz, .next
    ld a, c
    ldh [hTemp3], a
    ld hl, wSlotResistances + $1
    call ReadByteAtHLPlus4APlus3C_Bank39
    and $c0
    rlca
    rlca
    ld e, a
    ldh a, [hTemp1]
    cp e
    jr z, .call_get_battle_hp_bank39
    jr c, .next
    ld a, $ff
    ld [wBattleDamageLo], a
    ld [wBattleDamageHi], a
    ld a, e
    ldh [hTemp1], a

.call_get_battle_hp_bank39:
    push bc
    ld a, c
    call GetBattleHP_Bank39
    push hl
    ld a, c
    call GetBattleDEF_Bank39
    pop bc
    add hl, bc
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wBattleDamageHi]
    ld b, a
    call CompareHLToBC
    pop bc
    jr nc, .next
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    ld a, c
    ldh [hTemp0], a

.next:
    inc c
    dec b
    jr nz, .loop
    call SetActorTargetFromHRAMChoice
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 83 IceSlash; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_IceSlash::
    ld a, [wBattleActor]
    and $04
    xor $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $ff
    ldh [hTemp0], a
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a
    ld [wBattleDamageLo], a
    ld [wBattleDamageHi], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ldh [hTemp2], a
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hli]
    and $c0
    jr nz, .next
    ld a, [hl]
    and $0c
    jr nz, .next
    ld a, c
    ldh [hTemp3], a
    ld hl, wSlotResistances + $1
    call ReadByteAtHLPlus4APlus3C_Bank39
    and $0c
    rrca
    rrca
    ld e, a
    ldh a, [hTemp1]
    cp e
    jr z, .call_get_battle_hp_bank39
    jr c, .next
    ld a, $ff
    ld [wBattleDamageLo], a
    ld [wBattleDamageHi], a
    ld a, e
    ldh [hTemp1], a

.call_get_battle_hp_bank39:
    push bc
    ld a, c
    call GetBattleHP_Bank39
    push hl
    ld a, c
    call GetBattleDEF_Bank39
    pop bc
    add hl, bc
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wBattleDamageHi]
    ld b, a
    call CompareHLToBC
    pop bc
    jr nc, .next
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    ld a, c
    ldh [hTemp0], a

.next:
    inc c
    dec b
    jr nz, .loop
    call SetActorTargetFromHRAMChoice
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 72 WindBeast; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_WindBeast::
    ld a, [wBattleActor]
    and $04
    xor $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $ff
    ldh [hTemp0], a
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a
    ld [wBattleDamageLo], a
    ld [wBattleDamageHi], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ldh [hTemp2], a
    ld a, c
    ldh [hTemp3], a
    ld hl, wSlotResistances + $1
    call ReadByteAtHLPlus4APlus3C_Bank39
    and $c0
    rlca
    rlca
    ld e, a
    ldh a, [hTemp1]
    cp e
    jr z, .call_get_battle_hp_bank39
    jr c, .next
    ld a, $ff
    ld [wBattleDamageLo], a
    ld [wBattleDamageHi], a
    ld a, e
    ldh [hTemp1], a

.call_get_battle_hp_bank39:
    push bc
    ld a, c
    call GetBattleHP_Bank39
    push hl
    ld a, c
    call GetBattleDEF_Bank39
    pop bc
    add hl, bc
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wBattleDamageHi]
    ld b, a
    call CompareHLToBC
    pop bc
    jr nc, .next
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    ld a, c
    ldh [hTemp0], a

.next:
    inc c
    dec b
    jr nz, .loop
    call SetActorTargetFromHRAMChoice
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 103 GigaSlash; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_GigaSlash::
    ld a, [wBattleActor]
    and $04
    xor $04
    ld [wBattleTarget], a
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $ff
    ldh [hTemp0], a
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a
    ld [wBattleDamageLo], a
    ld [wBattleDamageHi], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    call SlotStatus4Bits23
    jr z, .read_battle_target

.next:
    inc c
    dec b
    jr nz, .loop
    call EstimateAndPickWeakestTarget
    jp .read_battle_actor

.read_battle_target:
    ld b, $03
    ld a, [wBattleTarget]
    ld c, a

.loop2:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next2
    call AnySlotStatusMaskSet
    jr z, .loop3
    call TestSlotStatus2Bit3OrStatus5Bits67
    jr z, .loop3

.next2:
    inc c
    dec b
    jr nz, .loop2
    call EstimateThreeTargets
    jp .read_battle_actor

.loop3:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next3
    call TestSlotStatus2Bit3OrStatus5Bits67
    jr nz, .next3
    ld a, c
    call AnySlotStatusMaskSet
    jr nz, .next3
    ldh [hTemp2], a
    ld a, c
    ldh [hTemp3], a
    ld hl, wSlotResistances + $6
    call ReadByteAtHLPlus4APlus3C_Bank39
    and $0c
    rrca
    rrca
    ld e, a
    ldh a, [hTemp1]
    cp e
    jr z, .call_get_battle_hp_bank39
    jr c, .next3
    ld a, $ff
    ld [wBattleDamageLo], a
    ld [wBattleDamageHi], a
    ld a, e
    ldh [hTemp1], a

.call_get_battle_hp_bank39:
    push bc
    ld a, c
    call GetBattleHP_Bank39
    push hl
    ld a, c
    call GetBattleDEF_Bank39
    pop bc
    add hl, bc
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wBattleDamageHi]
    ld b, a
    call CompareHLToBC
    pop bc
    jr nc, .next3
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    ld a, c
    ldh [hTemp0], a

.next3:
    inc c
    dec b
    jr nz, .loop3
    call SetActorTargetFromHRAMChoice
    ret

.read_battle_actor:
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    ld a, [wBattleTarget]
    ld [hl], a
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 93 AquaCut; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_AquaCut::
    ld a, [wBattleActor]
    and $04
    xor $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $ff
    ldh [hTemp0], a
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a
    ld [wBattleDamageLo], a
    ld [wBattleDamageHi], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ldh [hTemp2], a
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hli]
    and $c0
    jr nz, .next
    ld a, [hl]
    and $0c
    jr nz, .next
    ld a, c
    ldh [hTemp3], a
    ld hl, wSlotResistances
    call ReadByteAtHLPlus4APlus3C_Bank39
    and $c0
    rlca
    rlca
    ld e, a
    ldh a, [hTemp1]
    cp e
    jr z, .call_get_battle_hp_bank39
    jr c, .next
    ld a, $ff
    ld [wBattleDamageLo], a
    ld [wBattleDamageHi], a
    ld a, e
    ldh [hTemp1], a

.call_get_battle_hp_bank39:
    push bc
    ld a, c
    call GetBattleHP_Bank39
    push hl
    ld a, c
    call GetBattleDEF_Bank39
    pop bc
    add hl, bc
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wBattleDamageHi]
    ld b, a
    call CompareHLToBC
    pop bc
    jr nc, .next
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    ld a, c
    ldh [hTemp0], a

.next:
    inc c
    dec b
    jr nz, .loop
    call SetActorTargetFromHRAMChoice
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 76 Watershot; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_Watershot::
    ld a, [wBattleActor]
    and $04
    xor $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $ff
    ldh [hTemp0], a
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a
    ld [wBattleDamageLo], a
    ld [wBattleDamageHi], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ldh [hTemp2], a
    ld a, c
    ldh [hTemp3], a
    ld hl, wSlotResistances
    call ReadByteAtHLPlus4APlus3C_Bank39
    and $c0
    rlca
    rlca
    ld e, a
    ldh a, [hTemp1]
    cp e
    jr z, .call_get_battle_hp_bank39
    jr c, .next
    ld a, $ff
    ld [wBattleDamageLo], a
    ld [wBattleDamageHi], a
    ld a, e
    ldh [hTemp1], a

.call_get_battle_hp_bank39:
    push bc
    ld a, c
    call GetBattleHP_Bank39
    push hl
    ld a, c
    call GetBattleDEF_Bank39
    pop bc
    add hl, bc
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wBattleDamageHi]
    ld b, a
    call CompareHLToBC
    pop bc
    jr nc, .next
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    ld a, c
    ldh [hTemp0], a

.next:
    inc c
    dec b
    jr nz, .loop
    call SetActorTargetFromHRAMChoice
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 61 MegaMagic; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_MegaMagic::
    ld a, [wBattleActor]
    and $04
    xor $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $ff
    ldh [hTemp0], a
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a
    ldh [hTemp4], a
    ldh [hTemp5], a
    ld [wTargetEstimates], a
    ld [wTargetEstimates + $1], a
    xor a
    ld [wBattleDamageLo], a
    ld [wBattleDamageHi], a

.loop:
    push bc
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jp c, .restore
    ldh [hTemp3], a
    ld hl, wSlotResistances + $4
    call ReadByteAtHLPlus4APlus3C_Bank39
    and $c0
    rrca
    rrca
    swap a
    cp $03
    jr z, .restore
    ldh [hTemp6], a
    push bc
    call ChooseTarget_MegaMagic_GetBattleMP_Bank39
    pop bc
    push hl
    ld a, c
    call GetBattleHP_Bank39
    pop bc
    call CompareHLToBC
    jr c, .read_battle_damage_lo
    ldh a, [hTemp6]
    ld e, a
    ldh a, [hTemp1]
    cp e
    jr z, .read_target_estimates
    jr c, .restore
    ld a, e
    ldh [hTemp1], a
    ldh a, [hTemp3]
    ldh [hTemp5], a
    ld a, l
    ld [wTargetEstimates], a
    ld a, h
    ld [wTargetEstimates + $1], a
    jr .restore

.read_target_estimates:
    ld a, [wTargetEstimates]
    ld c, a
    ld a, [wTargetEstimates + $1]
    ld b, a
    call CompareHLToBC
    jr nc, .restore
    ld a, l
    ld [wTargetEstimates], a
    ld a, h
    ld [wTargetEstimates + $1], a
    ldh a, [hTemp3]
    ldh [hTemp5], a
    jr .restore

.read_battle_damage_lo:
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wBattleDamageHi]
    ld b, a
    call CompareHLToBCFastZero
    jr c, .restore
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    ldh a, [hTemp3]
    ldh [hTemp2], a

.restore:
    pop bc
    inc c
    dec b
    jp nz, .loop
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    ldh a, [hTemp2]
    cp $ff
    jr nz, .done
    ldh a, [hTemp5]
    cp $ff
    jr nz, .done
    ldh a, [hTemp3]

.done:
    ld [hl], a
    ret

; after AdvanceRandom, lists the present opposite slots in slot order (count in hTemp0, slots in
; hTemp1-hTemp3, unused entries $FF) and lets PickWeightedTargetCandidate choose (E-0061)
TargetFoeWeightedBySlotOrder::
    call AdvanceRandom
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03
    xor a
    ldh [hTemp0], a
    ld a, $ff
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld hl, hTemp0
    ld a, [hl]
    inc [hl]
    ld hl, hTemp1
    add_a_to_hl
    ld [hl], c

.next:
    inc c
    dec b
    jr nz, .loop
    call PickWeightedTargetCandidate
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 0 (no name), 98 SquallHit, 99 BiAttack, 105
; PsycheUp, 106 HighJump, 107 EvilSlash, 109 TwinSlash, 112 Kamikaze, $CC, $D2 ...; writes the
; target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_SquallHit_66C5::
    call AdvanceRandom
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03
    xor a
    ldh [hTemp0], a
    ld a, $ff
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a
    ld [wBattleDamageLo], a
    ld [wBattleDamageHi], a
    ld [wTargetEstimates], a
    ld [wTargetEstimates + $1], a
    ld [wEffectTemp0], a
    ld [wEffectTemp1], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld hl, hTemp0
    ld e, [hl]
    ld a, e
    ld hl, hTemp1
    add_a_to_hl
    ld [hl], c
    ld a, e
    ld hl, wBattleDamageLo
    add a
    add_a_to_hl
    push hl
    ld a, e
    call GetBattleHP_Bank39
    push hl
    ld a, e
    call GetBattleDEF_Bank39
    pop de
    add hl, de
    sra h
    rr l
    ld d, h
    ld a, l
    pop hl
    ld [hli], a
    ld [hl], d

.next:
    inc c
    dec b
    jr nz, .loop
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    ld a, [wTargetEstimates]
    ld c, a
    ld a, [wTargetEstimates + $1]
    ld b, a
    call CompareHLToBC
    jr z, .read_target_estimates
    jr c, .read_target_estimates
    ld a, l
    ld [wTargetEstimates], a
    ld a, h
    ld [wTargetEstimates + $1], a
    ld a, c
    ld [wBattleDamageLo], a
    ld a, b
    ld [wBattleDamageHi], a
    ldh a, [hTemp1]
    push af
    ldh a, [hTemp2]
    ldh [hTemp1], a
    pop af
    ldh [hTemp2], a

.read_target_estimates:
    ld a, [wTargetEstimates]
    ld l, a
    ld a, [wTargetEstimates + $1]
    ld h, a
    ld a, [wEffectTemp0]
    ld c, a
    ld a, [wEffectTemp1]
    ld b, a
    call CompareHLToBC
    jr z, .read_battle_damage_lo
    jr c, .read_battle_damage_lo
    ld a, l
    ld [wEffectTemp0], a
    ld a, h
    ld [wEffectTemp1], a
    ld a, c
    ld [wTargetEstimates], a
    ld a, b
    ld [wTargetEstimates + $1], a
    ldh a, [hTemp2]
    push af
    ldh a, [hTemp3]
    ldh [hTemp2], a
    pop af
    ldh [hTemp3], a

.read_battle_damage_lo:
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    ld a, [wTargetEstimates]
    ld c, a
    ld a, [wTargetEstimates + $1]
    ld b, a
    call CompareHLToBC
    jr z, .call_pick_weighted_target_candidate
    jr c, .call_pick_weighted_target_candidate
    ldh a, [hTemp1]
    push af
    ldh a, [hTemp2]
    ldh [hTemp1], a
    pop af
    ldh [hTemp2], a

.call_pick_weighted_target_candidate:
    call PickWeightedTargetCandidate
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 22 Heal, 23 HealMore, 24 HealAll; writes the
; target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_Heal_67AD::
    ld a, [wBattleActor]
    and $04
    ld e, a
    ld d, $03
    push de
    xor a
    ld [wWorkBuf], a
    ld [wWorkBuf + $1], a
    ld [wWorkBuf + $2], a
    ld [wWorkBuf + $3], a
    ld [wWorkBuf + $4], a
    ld [wWorkBuf + $5], a
    ld [wWorkBuf + $6], a
    ld [wWorkBuf + $7], a
    ld [wWorkBuf + $8], a
    ld [wWorkBuf + $9], a
    ld [wWorkBuf + $a], a
    ld [wWorkBuf + $b], a

.loop:
    ld a, e
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    call GetBattleHP_Bank39
    push hl
    ld a, e
    call GetBattleMaxHP_Bank39
    pop bc
    call CompareHLToBC
    jr z, .next
    push de
    call DivideHLByBC
    pop de
    push de
    ld a, e
    and $03
    ld de, wWorkBuf
    add a
    add a
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, l
    ld [de], a
    inc de
    ld a, h
    ld [de], a
    inc de
    ld a, c
    ld [de], a
    inc de
    ld a, b
    ld [de], a
    pop de

.next:
    inc e
    dec d
    jr nz, .loop
    pop de
    ld a, $ff
    ldh [hTemp0], a
    xor a
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a
    ldh [hTemp4], a

.loop2:
    ld a, e
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next2
    ld hl, hTemp1
    ld a, [hli]
    or [hl]
    inc hl
    or [hl]
    inc hl
    or [hl]
    jr z, .set_temp0
    ld a, e
    and $03
    ld hl, wWorkBuf
    add a
    add a
    add_a_to_hl
    ld a, l
    ldh [hTemp5], a
    ld a, h
    ldh [hTemp6], a
    ld a, [hli]
    or [hl]
    inc hl
    or [hl]
    inc hl
    or [hl]
    jr z, .next2
    ldh a, [hTemp5]
    ld l, a
    ldh a, [hTemp6]
    ld h, a
    ld a, [hli]
    ld b, [hl]
    ld c, a
    ldh a, [hTemp1]
    ld l, a
    ldh a, [hTemp2]
    ld h, a
    call CompareHLToBC
    jr z, .read_temp5
    jr nc, .next2
    jr .set_temp0

.read_temp5:
    ldh a, [hTemp5]
    ld l, a
    ldh a, [hTemp6]
    ld h, a
    inc hl
    inc hl
    ld a, [hli]
    ld b, [hl]
    ld c, a
    ldh a, [hTemp3]
    ld l, a
    ldh a, [hTemp4]
    ld h, a
    call CompareHLToBC
    jr nc, .next2

.set_temp0:
    ld a, e
    ldh [hTemp0], a
    and $03
    ld hl, wWorkBuf
    add a
    add a
    add_a_to_hl
    ld a, [hli]
    ldh [hTemp1], a
    ld a, [hli]
    ldh [hTemp2], a
    ld a, [hli]
    ldh [hTemp3], a
    ld a, [hl]
    ldh [hTemp4], a

.next2:
    inc e
    dec d
    jr nz, .loop2
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    ldh a, [hTemp0]
    cp $ff
    jr nz, .done
    ld a, [wBattleActor]

.done:
    ld [hl], a
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 22 Heal, 23 HealMore, 24 HealAll; writes the
; target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_Heal_68B0::
    ld a, [wBattleActor]
    and $04
    ld e, a
    ld d, $03
    push de
    xor a
    ldh [hTemp0], a
    ldh [hTemp4], a
    ldh [hTemp5], a
    ld a, $ff
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a
    ld [wBattleDamageLo], a
    ld [wBattleDamageHi], a
    ld [wTargetEstimates], a
    ld [wTargetEstimates + $1], a
    ld [wEffectTemp0], a
    ld [wEffectTemp1], a

.loop:
    ld a, e
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    call GetBattleMaxHP_Bank39
    ldh a, [hTemp4]
    add l
    ldh [hTemp4], a
    ldh a, [hTemp5]
    adc h
    ldh [hTemp5], a
    ld hl, hTemp0
    inc [hl]

.next:
    inc e
    dec d
    jr nz, .loop
    ldh a, [hTemp4]
    ld l, a
    ldh a, [hTemp5]
    ld h, a
    ldh a, [hTemp0]
    call DivideHLByA
    ld a, l
    ldh [hTemp4], a
    ld a, h
    ldh [hTemp5], a
    xor a
    ldh [hTemp0], a
    pop de

.loop2:
    ld a, e
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next2
    call GetBattleHP_Bank39
    ldh a, [hTemp4]
    ld c, a
    ldh a, [hTemp5]
    ld b, a
    call CompareHLToBC
    jr nc, .next2
    ldh a, [hTemp0]
    ld bc, wBattleDamageLo
    add a
    add c
    ld c, a
    jr nc, .skip
    inc b

.skip:
    ld a, l
    ld [bc], a
    inc bc
    ld a, h
    ld [bc], a
    ld hl, hTemp0
    ld a, [hl]
    inc [hl]
    ld hl, hTemp1
    add_a_to_hl
    ld [hl], e

.next2:
    inc e
    dec d
    jr nz, .loop2
    ldh a, [hTemp0]
    or a
    jp z, ChooseTarget_Heal_67AD
    cp $01
    jr z, .read_battle_actor
    cp $02
    jr z, .read_target_estimates
    ld a, [wEffectTemp0]
    ld l, a
    ld a, [wEffectTemp1]
    ld h, a
    ld a, [wTargetEstimates]
    ld c, a
    ld a, [wTargetEstimates + $1]
    ld b, a
    call CompareHLToBC
    jr nc, .read_target_estimates
    ld a, l
    ld [wTargetEstimates], a
    ld a, h
    ld [wTargetEstimates + $1], a
    ldh a, [hTemp3]
    ldh [hTemp2], a

.read_target_estimates:
    ld a, [wTargetEstimates]
    ld l, a
    ld a, [wTargetEstimates + $1]
    ld h, a
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wBattleDamageHi]
    ld b, a
    call CompareHLToBC
    jr nc, .read_battle_actor
    ldh a, [hTemp2]
    ldh [hTemp1], a

.read_battle_actor:
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    ldh a, [hTemp1]
    ld [hl], a
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 30 Vivify, 31 Revive; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_Vivify_6998::
    jp ChooseTarget_Vivify

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 33 Antidote; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_Antidote_699B::
    jp ChooseTarget_Antidote

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 45 TwinHits; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_TwinHits_699E::
    jp ChooseTarget_TwinHits

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 37 Upper; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_Upper_69A1::
    jp ChooseTarget_Upper

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 39 Sap; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_Sap_69A4::
    jp ChooseTarget_Sap

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 43 Slow; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_Slow_69A7::
    jp ChooseTarget_Slow

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 41 Speed; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_Speed_69AA::
    jp ChooseTarget_Speed

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 130 UltraDown; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_UltraDown_69AD::
    jp ChooseTarget_UltraDown

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 151 Cover; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_Cover_69B0::
    jp ChooseTarget_Cover

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 147 MouthShut; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_MouthShut_69B3::
    jp ChooseTarget_MouthShut

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 140 SickLick; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_SickLick_69B6::
    jp ChooseTarget_SickLick

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 141 LegSweep; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_LegSweep_69B9::
    jp ChooseTarget_LegSweep

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 97 NapAttack; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_NapAttack_69BC::
    jp ChooseTarget_NapAttack

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 118 OddDance, 119 RobDance; writes the
; target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_OddDance_69BF::
    jp ChooseTarget_OddDance

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 94 MetalCut; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_MetalCut_69C2::
    jp ChooseTarget_MetalCut

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 85 DrakSlash; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_DrakSlash_69C5::
    ld d, $01
    call TargetRandomFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 86 BeastCut; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_BeastCut_69CB::
    ld d, $02
    call TargetRandomFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 87 BirdBlow; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_BirdBlow_69D1::
    ld d, $03
    call TargetRandomFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 90 DevilCut; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_DevilCut_69D7::
    ld d, $06
    call TargetRandomFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 91 ZombieCut; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_ZombieCut_69DD::
    ld d, $07
    call TargetRandomFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 92 CleanCut; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_CleanCut_69E3::
    ld d, $08
    call TargetRandomFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 84 SlimeBlow; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_SlimeBlow_69E9::
    ld d, $00
    call TargetRandomFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 88 BugBlow; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_BugBlow_69EF::
    ld d, $05
    call TargetRandomFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 89 Shears; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_Shears_69F5::
    ld d, $04
    call TargetRandomFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 95 PoisonHit; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_PoisonHit_69FB::
    jp ChooseTarget_PoisonHit

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 96 Paralyze; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_Paralyze_69FE::
    jp ChooseTarget_Paralyze

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 139 LushLicks, 143 Ahhh; writes the target
; to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_LushLicks_6A01::
    jp ChooseTarget_LushLicks

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 58 Transform; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_Transform_6A04::
    jp ChooseTarget_Transform

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 19 Beat; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_Beat_6A07::
    jp ChooseTarget_Beat

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 1 Blaze, 2 Blazemore, 3 Blazemost, $D1, $DF;
; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_Blaze_6A0A::
    jp ChooseTarget_Blaze

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 110 Berserker, 111 Ramming; writes the
; target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_Berserker::
    jp ChooseTarget_Ramming

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 47 Sleep; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_Sleep_6A10::
    jp ChooseTarget_Sleep

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 50 RobMagic; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_RobMagic_6A13::
    jp ChooseTarget_RobMagic

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 80 FireSlash; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_FireSlash_6A16::
    jp ChooseTarget_FireSlash

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 82 BoltSlash; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_BoltSlash_6A19::
    jp ChooseTarget_BoltSlash

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 81 VacuSlash; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_VacuSlash_6A1C::
    jp ChooseTarget_VacuSlash

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 83 IceSlash; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_IceSlash_6A1F::
    jp ChooseTarget_IceSlash

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 72 WindBeast; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_WindBeast_6A22::
    jp ChooseTarget_WindBeast

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 103 GigaSlash; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_GigaSlash_6A25::
    ld a, [wBattleActor]
    and $04
    xor $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $ff
    ldh [hTemp0], a
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a
    ld [wBattleDamageLo], a
    ld [wBattleDamageHi], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ldh [hTemp2], a
    ld a, c
    ldh [hTemp3], a
    ld hl, wSlotResistances + $6
    call ReadByteAtHLPlus4APlus3C_Bank39
    and $0c
    rrca
    rrca
    ld e, a
    ldh a, [hTemp1]
    cp e
    jr z, .call_get_battle_hp_bank39
    jr c, .next
    ld a, $ff
    ld [wBattleDamageLo], a
    ld [wBattleDamageHi], a
    ld a, e
    ldh [hTemp1], a

.call_get_battle_hp_bank39:
    push bc
    ld a, c
    call GetBattleHP_Bank39
    push hl
    ld a, c
    call GetBattleDEF_Bank39
    pop bc
    add hl, bc
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wBattleDamageHi]
    ld b, a
    call CompareHLToBC
    pop bc
    jr nc, .next
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    ld a, c
    ldh [hTemp0], a

.next:
    inc c
    dec b
    jr nz, .loop
    call SetActorTargetFromHRAMChoice
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 93 AquaCut; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_AquaCut_6A96::
    jp ChooseTarget_AquaCut

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 76 Watershot; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_Watershot_6A99::
    jp ChooseTarget_Watershot

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 173 PanicAll; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_PanicAll::
    ld a, [wBattleActor]
    and $04
    xor $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $ff
    ldh [hTemp0], a
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a
    ldh [hTemp4], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ldh [hTemp2], a
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hli]
    and $cc
    jr nz, .next
    inc hl
    inc hl
    ld a, [hld]
    or a
    jr nz, .next
    ld a, c
    ldh [hTemp3], a
    ld a, [hl]
    and $22
    jr nz, .next
    ld a, c
    ldh [hTemp4], a
    ld hl, wSlotResistances + $3
    call ReadByteAtHLPlus4APlus3C_Bank39
    and $c0
    rlca
    rlca
    cp $03
    jr z, .next
    ld e, a
    ldh a, [hTemp1]
    cp e
    jr c, .next
    ld a, e
    ldh [hTemp1], a
    ld a, c
    ldh [hTemp0], a

.next:
    inc c
    dec b
    jr nz, .loop
    call SetActorTargetFromHRAMChoice4
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 61 MegaMagic; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_MegaMagic_6AFA::
    jp ChooseTarget_MegaMagic

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 33 Antidote; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_Antidote_6AFD::
    ld a, [wBattleActor]
    and $04
    ld hl, wBattleStatus
    ld d, $03
    jp TargetAllyWithStatusBit20_CallAddAx9ToHL

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 37 Upper; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_Upper_6B0A::
    ld a, [wBattleActor]
    and $04
    ld c, a
    ld b, $03
    xor a
    ldh [hTemp0], a
    ld a, $ff
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a

.loop:
    push bc
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .restore
    call GetBattleDEF_Bank39
    push hl
    call BuffCapOfBaseDEF
    pop bc
    call CompareHLToBC
    jr z, .restore
    ld hl, hTemp0
    ld a, [hl]
    inc [hl]
    ld hl, hTemp1
    add_a_to_hl
    pop bc
    ld [hl], c
    push bc

.restore:
    pop bc
    inc c
    dec b
    jr nz, .loop
    ldh a, [hTemp0]
    or a
    jp nz, PickWeightedTargetCandidate
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    ld a, [wBattleActor]
    ld [hl], a
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 41 Speed; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_Speed_6B5D::
    ld a, [wBattleActor]
    and $04
    ld c, a
    ld b, $03
    xor a
    ldh [hTemp0], a
    ld a, $ff
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a

.loop:
    push bc
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .restore
    call GetBattleAGL_Bank39
    push hl
    call BuffCapOfBaseAGL
    pop bc
    call CompareHLToBC
    jr z, .restore
    ld hl, hTemp0
    ld a, [hl]
    inc [hl]
    ld hl, hTemp1
    add_a_to_hl
    pop bc
    ld [hl], c
    push bc

.restore:
    pop bc
    inc c
    dec b
    jr nz, .loop
    ldh a, [hTemp0]
    or a
    jp nz, PickWeightedTargetCandidate
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    ld a, [wBattleActor]
    ld [hl], a
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 39 Sap; writes the target to
; wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_Sap_6BB0::
    ld de, GetBattleDEF_Bank39
    jp TargetAllyWithStatusBit20_CheckBattleActor

; per-action target routine: DE = GetBattleAGL_Bank39, then the shared stat comparison at $6C30
; (E-0219)
TargetByAllyAGL::
    ld de, GetBattleAGL_Bank39
    jp TargetAllyWithStatusBit20_CheckBattleActor

; per-action target routine: scans the actor's side for wBattleStatus (+9 * slot) bit mask $10
; (shared code at $6BE3) (E-0219)
TargetAllyWithStatusBit10::
    ld a, [wBattleActor]
    and $04
    ld hl, wBattleStatus
    ld d, $10
    jp TargetAllyWithStatusBit20_CallAddAx9ToHL

; as TargetAllyWithStatusBit10 with mask $40 (E-0219)
TargetAllyWithStatusBit40::
    ld a, [wBattleActor]
    and $04
    ld hl, wBattleStatus
    ld d, $40
    jp TargetAllyWithStatusBit20_CallAddAx9ToHL

; as TargetAllyWithStatusBit10 with mask $20 (E-0219)
TargetAllyWithStatusBit20::
    ld a, [wBattleActor]
    and $04
    ld hl, wBattleStatus
    ld d, $20
    jp TargetAllyWithStatusBit20_CallAddAx9ToHL

TargetAllyWithStatusBit20_CallAddAx9ToHL::
    ld c, a
    ld b, $03
    call AddAx9ToHL
    xor a
    ldh [hTemp0], a
    ld a, $ff
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .skip
    ld a, [hl]
    and d
    jr z, .skip
    push hl
    ld hl, hTemp0
    ld a, [hl]
    inc [hl]
    ld hl, hTemp1
    add_a_to_hl
    ld [hl], c
    pop hl

.skip:
    ld a, $09
    add_a_to_hl
    inc c
    dec b
    jr nz, .loop
    ldh a, [hTemp0]
    or a
    jp nz, PickWeightedTargetCandidate
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    ld a, [wBattleActor]
    ld [hl], a
    ret

TargetAllyWithStatusBit20_CheckBattleActor::
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03
    xor a
    ldh [hTemp0], a
    ld a, $ff
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld h, d
    ld l, e
    call JumpToHL
    ld a, h
    or a
    jr nz, .skip
    ld a, l
    cp $02
    jr c, .next

.skip:
    ld hl, hTemp0
    ld a, [hl]
    inc [hl]
    ld hl, hTemp1
    add_a_to_hl
    ld [hl], c

.next:
    inc c
    dec b
    jr nz, .loop
    ldh a, [hTemp0]
    or a
    jp z, TargetFoeWeightedBySlotOrder
    call PickWeightedTargetCandidate
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 22 Heal, 23 HealMore, 24 HealAll; writes the
; target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_Heal_6C75::
    ld a, [wBattleActor]
    and $04
    ld c, a
    ld b, $03
    ld a, $ff
    ldh [hTemp0], a
    xor a
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a
    ldh [hTemp4], a

.loop:
    push bc
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .restore
    call GetBattleHP_Bank39
    push hl
    ld a, c
    call GetBattleMaxHP_Bank39
    pop bc
    call DivideHLByBC
    ldh a, [hTemp1]
    sub l
    ld e, a
    ldh a, [hTemp2]
    sbc h
    ld d, a
    jr c, .set_temp1
    ld a, d
    or e
    jr nz, .restore
    ldh a, [hTemp3]
    sub c
    ld e, a
    ldh a, [hTemp4]
    sbc b
    ld d, a
    jr c, .set_temp1
    ld a, d
    or e
    jr nz, .restore
    call AdvanceRandom
    ld a, [wRandomLo]
    bit 7, a
    jr z, .restore

.set_temp1:
    ld a, l
    ldh [hTemp1], a
    ld a, h
    ldh [hTemp2], a
    ld a, c
    ldh [hTemp3], a
    ld a, b
    ldh [hTemp4], a
    pop bc
    ld a, c
    ldh [hTemp0], a
    push bc

.restore:
    pop bc
    inc c
    dec b
    jr nz, .loop
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    ldh a, [hTemp0]
    ld [hl], a
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of ActionTargetModeTable,
; 228 entries each, indexed by action id) for action(s) 27 MPass, 28 MPassmore, 29 MPassmost; writes
; the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
ChooseTarget_MPass::
    ld a, [wBattleActor]
    and $04
    ld c, a
    ld b, $03
    ld a, $ff
    ldh [hTemp0], a
    xor a
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a
    ldh [hTemp4], a

.loop:
    push bc
    ld a, [wBattleActor]
    cp c
    jr z, .restore
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .restore
    call GetBattleMP_Bank39
    push hl
    ld a, c
    call GetBattleMaxMP_Bank39
    pop bc
    call DivideHLByBC
    ldh a, [hTemp1]
    sub l
    ld e, a
    ldh a, [hTemp2]
    sbc h
    ld d, a
    jr c, .set_temp1
    ld a, d
    or e
    jr nz, .restore
    ldh a, [hTemp3]
    sub c
    ld e, a
    ldh a, [hTemp4]
    sbc b
    ld d, a
    jr c, .set_temp1
    ld a, d
    or e
    jr nz, .restore
    call AdvanceRandom
    ld a, [wRandomLo]
    bit 7, a
    jr z, .restore

.set_temp1:
    ld a, l
    ldh [hTemp1], a
    ld a, h
    ldh [hTemp2], a
    ld a, c
    ldh [hTemp3], a
    ld a, b
    ldh [hTemp4], a
    pop bc
    ld a, c
    ldh [hTemp0], a
    push bc

.restore:
    pop bc
    inc c
    dec b
    jr nz, .loop
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    ldh a, [hTemp0]
    cp $ff
    jr nz, .done
    ld a, [wBattleActor]

.done:
    ld [hl], a
    ret

; A = slot: A = its status byte 4 (wBattleStatus4) & $0C; Z set when both bits are clear (E-0116)
SlotStatus4Bits23::
    ld hl, wBattleStatus4
    call AddAx9ToHL
    ld a, [hl]
    and $0c
    ret

; wBattleTempBuf + $2 = 0, hTemp1 = 0, stores HP + DEF of three slots from the target in
; wTargetEstimates and falls into PickWeakestEstimatedTarget (E-0126)
EstimateAndPickWeakestTarget::
    ld a, $00
    ld [wBattleTempBuf + $2], a
    xor a
    ldh [hTemp1], a
    ld b, $03
    ld a, [wBattleTarget]
    ld c, a

.loop:
    call StoreSlotHPPlusDEFToTargetEstimates
    inc c
    dec b
    jr nz, .loop

; picks the smallest of the three wTargetEstimates estimates (ties broken randomly) and adds its
; index to wBattleTarget (E-0125)
PickWeakestEstimatedTarget::
    xor a
    ldh [hTemp0], a
    ld a, [wTargetEstimates]
    ld c, a
    ld a, [wTargetEstimates + $1]
    ld b, a
    ld de, $0201

.loop:
    ld a, e
    ld hl, wTargetEstimates
    add a
    add_a_to_hl
    deref_hl
    call CompareHLToBC
    jr z, .call_advance_random
    jr nc, .next

.loop2:
    ld b, h
    ld c, l
    ld a, e
    ldh [hTemp0], a
    jr .next

.call_advance_random:
    call AdvanceRandom
    ld a, [wRandomLo]
    bit 1, a
    jr z, .loop2

.next:
    inc e
    dec d
    jr nz, .loop
    ld hl, wBattleTarget
    ldh a, [hTemp0]
    add [hl]
    ld [hl], a
    ret

; slot C: stores HP + DEF (DEF halved when hTemp1 is set and bit 2 of its wBattleStatus6 byte is
; set) in wTargetEstimates[C & 3], or $FFFF when empty (E-0124)
StoreSlotHPPlusDEFToTargetEstimates::
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, StoreFFFFToTargetEstimatesSlotC
    call GetBattleHP_Bank39
    push hl
    ld a, c
    call GetBattleDEF_Bank39
    ldh a, [hTemp1]
    or a
    jr z, .restore
    push hl
    ld a, c
    ld hl, wBattleStatus6
    call AddAx9ToHL
    ld a, [hl]
    pop hl
    bit 2, a
    jr z, .restore
    srl h
    rr l

.restore:
    pop de
    add hl, de
    jr StoreHLToTargetEstimatesSlotC

; HL = $FFFF, then falls into StoreHLToTargetEstimatesSlotC (E-0122)
StoreFFFFToTargetEstimatesSlotC::
    ld hl, $ffff

; stores HL in the word wTargetEstimates[C & 3] (E-0122)
StoreHLToTargetEstimatesSlotC::
    ld a, c
    and $03
    add a
    ld de, wTargetEstimates
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, l
    ld [de], a
    inc de
    ld a, h
    ld [de], a
    ret

; A = slot: NZ when its status byte 0 & $40, byte 3 & $C0, byte 4 & $0C, byte 6 & $20 or byte 7 &
; $07 is set (A = that masked value), Z when none is (E-0096)
AnySlotStatusMaskSet::
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hli]
    and $40
    jr nz, .return
    inc hl
    inc hl
    ld a, [hli]
    and $c0
    jr nz, .return
    ld a, [hli]
    and $0c
    jr nz, .return
    inc hl
    ld a, [hli]
    and $20
    jr nz, .return
    ld a, [hl]
    and $07

.return:
    ret

; fills the damage for wBattleActionId: the effect handler for 0 or ids from $48 (except $66),
; ComputeDamageEstimateForAction_Multiply8By16 for low ids and $66, or the actor's ATK for $6B and
; $6C (E-0124)
ComputeDamageEstimateForAction::
    push bc
    ld a, [wBattleActionId]
    cp ACTION_FIGHT
    jr z, .call_run_effect_handler_for_action_id
    cp SKILL_WINDBEAST
    jr c, .call_compute_damage_estimate_for_action
    cp SKILL_MULTICUT
    jr z, .call_compute_damage_estimate_for_action
    cp SKILL_EVILSLASH
    jr z, .read_battle_actor
    cp SKILL_MASSACRE
    jr z, .read_battle_actor

.call_run_effect_handler_for_action_id:
    farcall RunEffectHandlerForActionId
    jr .done

.call_compute_damage_estimate_for_action:
    farcall ComputeDamageEstimateForAction_Multiply8By16
    jr .done

.read_battle_actor:
    ld a, [wBattleActor]
    call GetBattleATK_Bank39
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    jr .done

.done:
    pop bc
    ret

; if bit 0 of wSlotBodyFlags[C] is set, the damage word (wBattleDamageLo, wBattleDamageHi) = damage
; * 50 (Multiply8By16); registers preserved (E-0121)
MultiplyDamageBy50IfSlotDamageFlagsBit0::
    ld a, c
    ld hl, wSlotBodyFlags
    add_a_to_hl
    bit 0, [hl]
    ret z
    push af
    push bc
    push de
    push hl
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wBattleDamageHi]
    ld b, a
    ld a, $32
    call Multiply8By16
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    pop hl
    pop de
    pop bc
    pop af
    ret

; hTemp1 = 1; for three slots from the target stores HP + DEF in wTargetEstimates, or $FFFF for
; slots with wBattleStatus3 status bits $C0 or $0C; then PickWeakestEstimatedTarget (E-0124)
EstimateThreeTargets::
    ld a, $01
    ldh [hTemp1], a
    ld b, $03
    ld a, [wBattleTarget]
    ld c, a

.loop:
    ld a, c
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hli]
    and $c0
    jr nz, .call_store_ffff_to_target_estimates_slot_c
    ld a, [hl]
    and $0c
    jr nz, .call_store_ffff_to_target_estimates_slot_c
    call StoreSlotHPPlusDEFToTargetEstimates
    jr .next

.call_store_ffff_to_target_estimates_slot_c:
    call StoreFFFFToTargetEstimatesSlotC

.next:
    inc c
    dec b
    jr nz, .loop
    call PickWeakestEstimatedTarget
    ret

ChooseTarget_Heal_WriteTemp0AndTemp1Etc::
    ld a, $00
    ldh [hTemp0], a
    ld a, $01
    ldh [hTemp1], a
    ld a, $02
    ldh [hTemp2], a

.loop:
    ldh a, [hTemp1]
    ld hl, wTargetEstimates
    add a
    add_a_to_hl
    ld c, [hl]
    inc hl
    ld b, [hl]
    ldh a, [hTemp0]
    ld hl, wTargetEstimates
    add a
    add_a_to_hl
    deref_hl
    call CompareHLToBC
    jr c, .read_temp1
    jr nz, .check_temp2
    ldh a, [hTemp1]
    ld hl, wBattleTempBuf
    add a
    add_a_to_hl
    ld c, [hl]
    inc hl
    ld b, [hl]
    ldh a, [hTemp0]
    ld hl, wBattleTempBuf
    add a
    add_a_to_hl
    deref_hl
    call CompareHLToBC
    jr nc, .check_temp2

.read_temp1:
    ldh a, [hTemp1]
    ldh [hTemp0], a

.check_temp2:
    ld hl, hTemp1
    inc [hl]
    ldh a, [hTemp2]
    dec a
    ldh [hTemp2], a
    jr nz, .loop
    ldh a, [hTemp0]
    ld c, a
    ld a, [wBattleActor]
    and $04
    or c
    ld [wBattleTarget], a
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    ld a, [wBattleTarget]
    ld [hl], a
    ret

; HL = 999 when the base DEF doubled (quadrupled for allies or link battles) reaches 999, otherwise
; the base DEF times that factor (E-0124)
BuffCapOfBaseDEF::
    farcall GetBaseDEF
    ld a, [wBattleStatResultLo]
    ld l, a
    ld a, [wBattleStatResultHi]
    ld h, a
    ld bc, $03e7
    call CompareHLToBC
    jr nc, .return
    add hl, hl
    call CompareHLToBC
    jr nc, .done
    ld a, [wLinkMode]
    cp $01
    jr z, .call_compare_hl_to_bc
    ld a, [wBattleActor]
    and $04
    jr nz, .return

.call_compare_hl_to_bc:
    add hl, hl
    call CompareHLToBC
    jr c, .return

.done:
    ld hl, $03e7

.return:
    ret

; HL = 999 when the base AGL doubled (quadrupled for allies or link battles) reaches 999, otherwise
; the base AGL times that factor (E-0124)
BuffCapOfBaseAGL::
    farcall GetBaseAGL
    ld a, [wBattleStatResultLo]
    ld l, a
    ld a, [wBattleStatResultHi]
    ld h, a
    ld bc, $03e7
    call CompareHLToBC
    jr nc, .return
    add hl, hl
    call CompareHLToBC
    jr nc, .done
    ld a, [wLinkMode]
    cp $01
    jr z, .call_compare_hl_to_bc
    ld a, [wBattleActor]
    and $04
    jr nz, .return

.call_compare_hl_to_bc:
    add hl, hl
    call CompareHLToBC
    jr c, .return

.done:
    ld hl, $03e7

.return:
    ret

; counts the slot's skills in $40-$47, $70-$75 or $89 (C1: the skills MouthShut blocks)
ChooseTarget_MouthShut_CountMouthSkills::
    push bc
    ld hl, wBattleSkills
    swap a
    add_a_to_hl
    ld bc, $0800

.loop:
    ld a, [hli]
    cp $40
    jr c, .next2
    cp $48
    jr c, .next
    cp $70
    jr c, .next2
    cp $76
    jr c, .next
    cp $89
    jr z, .next
    jr .next2

.next:
    inc c

.next2:
    inc hl
    dec b
    jr nz, .loop
    ld a, c
    or a
    pop bc
    ret

; wBattleTargetChoice[2 * actor] = (hTemp0, or hTemp3 when hTemp0 is $FF) | hTempA (the two-choice
; form of SetActorTargetFromHRAMChoice) (E-0078)
SetActorTargetFromTemp0OrTemp3::
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    ldh a, [hTemp0]
    cp $ff
    jr nz, .check_temp_a
    ldh a, [hTemp3]

.check_temp_a:
    ld e, a
    ldh a, [hTempA]
    or e
    ld [hl], a
    ret

; HL = wBattleTargetChoice + 2 * wBattleActor; A = hTemp0, or hTemp3 when hTemp0 is $FF, or hTemp2
; when both are $FF; stores A | hTempA at HL. What the bytes mean is not known (E-0060)
SetActorTargetFromHRAMChoice::
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    ldh a, [hTemp0]
    cp $ff
    jr nz, .check_temp_a
    ldh a, [hTemp3]
    cp $ff
    jr nz, .check_temp_a
    ldh a, [hTemp2]

.check_temp_a:
    ld e, a
    ldh a, [hTempA]
    or e
    ld [hl], a
    ret

; wBattleTargetChoice[2 * actor] = (the first of hTemp0, hTemp4, hTemp3 that is not $FF, else
; hTemp2) | hTempA (the four-choice form of SetActorTargetFromHRAMChoice) (E-0096)
SetActorTargetFromHRAMChoice4::
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    ldh a, [hTemp0]
    cp $ff
    jr nz, .check_temp_a
    ldh a, [hTemp4]
    cp $ff
    jr nz, .check_temp_a
    ldh a, [hTemp3]
    cp $ff
    jr nz, .check_temp_a
    ldh a, [hTemp2]

.check_temp_a:
    ld e, a
    ldh a, [hTempA]
    or e
    ld [hl], a
    ret

ChooseTarget_Cover_ReadBattleActorAndTemp0Etc::
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    ldh a, [hTemp0]
    cp $ff
    jr nz, .check_temp_a
    ldh a, [hTemp5]
    cp $ff
    jr nz, .check_temp_a
    ldh a, [hTemp4]
    cp $ff
    jr nz, .check_temp_a
    ldh a, [hTemp3]

.check_temp_a:
    ld e, a
    ldh a, [hTempA]
    or e
    ld [hl], a
    ret

; hTemp0 = candidate count, hTemp1-hTemp3 = candidates in priority order: target = the first for
; one; with two the first when wRandomLo < $AB (171/256), else the second; with three the first when
; wRandomLo < $80, the second when < $D5, else the third (128, 85 and 43 of 256). Writes
; wBattleTargetChoice[2 * actor]; with no candidates it stores hTemp1 ($FF) (E-0061)
PickWeightedTargetCandidate::
    ldh a, [hTemp0]
    cp $03
    jr z, .check_random_lo2
    cp $02
    jr z, .check_random_lo
    ldh a, [hTemp1]
    jr .read_battle_actor

.check_random_lo:
    ld a, [wRandomLo]
    cp $ab
    ldh a, [hTemp1]
    jr c, .read_battle_actor
    ldh a, [hTemp2]
    jr .read_battle_actor

.check_random_lo2:
    ld a, [wRandomLo]
    cp $80
    ld b, $00
    jr c, .skip
    cp $d5
    ld b, $01
    jr c, .skip
    ld b, $02

.skip:
    ld a, b
    ld hl, hTemp1
    add_a_to_hl
    ld a, [hl]

.read_battle_actor:
    ld b, a
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    ld [hl], b
    ret

; D = family: among the actor's present opposite slots whose species family (LoadSpeciesFamily) is
; D, targets the one with the smallest HP + DEF; when none matches, the last present foe (hTemp3) is
; used (SetActorTargetFromTemp0OrTemp3). Used by the family-slaying moves' target routines (E-0096)
TargetWeakestFoeOfFamilyD::
    ld a, [wBattleActor]
    and $04
    xor $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $ff
    ldh [hTemp0], a
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a

.loop:
    ld a, c
    push bc
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .restore
    ldh [hTemp3], a
    ld hl, wBattleMonsterId
    add a
    add_a_to_hl
    ld a, [hli]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    push de
    push bc
    farcall LoadSpeciesFamily
    pop bc
    pop de
    ld a, [wSpeciesRecord]
    cp d
    jr nz, .restore
    ld a, c
    call GetBattleHP_Bank39
    push hl
    ld a, c
    call GetBattleDEF_Bank39
    pop bc
    add hl, bc
    ldh a, [hTemp1]
    ld c, a
    ldh a, [hTemp2]
    ld b, a
    call CompareHLToBC
    jr nc, .restore
    ld a, l
    ldh [hTemp1], a
    ld a, h
    ldh [hTemp2], a
    ldh a, [hTemp3]
    ldh [hTemp0], a

.restore:
    pop bc
    inc c
    dec b
    jr nz, .loop
    call SetActorTargetFromTemp0OrTemp3
    ret

; D = family: picks among the actor's present opposite slots whose species family is D, using
; AdvanceRandom when more than one matches (the choice rule is not read to the end); falls back to
; the last present foe; used by ChooseTarget routines of family-slaying moves (CleanCut, ZombieCut,
; DevilCut, Shears, ...) (E-0096)
TargetRandomFoeOfFamilyD::
    ld a, [wBattleActor]
    and $04
    xor $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $ff
    ldh [hTemp0], a
    ldh [hTemp3], a

.loop:
    ld a, c
    push bc
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .restore
    ldh [hTemp3], a
    ld hl, wBattleMonsterId
    add a
    add_a_to_hl
    ld a, [hli]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    push de
    farcall LoadSpeciesFamily
    pop de
    ld a, [wSpeciesRecord]
    cp d
    jr nz, .restore
    ldh a, [hTemp0]
    cp $ff
    jr z, .read_temp3
    call AdvanceRandom
    ld a, [wRandomLo]
    and $01
    jr z, .restore

.read_temp3:
    ldh a, [hTemp3]
    ldh [hTemp0], a

.restore:
    pop bc
    inc c
    dec b
    jr nz, .loop
    call SetActorTargetFromTemp0OrTemp3
    ret

ChooseTarget_Blaze_Multiply8By16::
    push af
    ldh a, [hTemp8]
    ld l, a
    ldh a, [hTemp9]
    ld h, a
    pop af
    or a
    jr z, .skip
    cp $01
    jr z, .call_multiply8_by16
    cp $02
    jr z, .done
    ld hl, $0000
    jr .return

.skip:
    jr .return

.call_multiply8_by16:
    ld a, $55
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    jr .return

.done:
    sra h
    rr l

.return:
    ret

ChooseTarget_MegaMagic_GetBattleMP_Bank39::
    push af
    ld a, [wBattleActor]
    call GetBattleMP_Bank39
    push hl
    ld a, [wBattleActor]
    ld hl, wBattleLevel
    add_a_to_hl
    ld a, [hl]
    pop hl
    add a
    add_a_to_hl
    ld a, $5a
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    pop af
    or a
    jr z, .skip
    cp $01
    jr z, .call_multiply8_by16
    cp $02
    jr z, .done
    ld hl, $0000
    jr .return

.skip:
    jr .return

.call_multiply8_by16:
    ld a, $55
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    jr .return

.done:
    sra h
    rr l

.return:
    ret

; A = [HL + 4 * A + 3 * C], the offset computed in 8 bits; clobbers HL (the same 11 bytes appear in
; 2 banks)
ReadByteAtHLPlus4APlus3C_Bank39::
    add a
    add c
    add a
    add c
    add_a_to_hl
    ld a, [hl]
    ret

; C = slot: NZ when its status byte 2 bit 3 is set; otherwise A = status byte 5 & $C0 (Z when clear)
; (E-0118)
TestSlotStatus2Bit3OrStatus5Bits67::
    ld a, c
    ld hl, wBattleStatus2
    call AddAx9ToHL
    bit BSTAT2_AQUA_WALL, [hl]
    ret nz
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    and $c0
    ret

; A = battle slot: HL = the word for that slot at wBattleATK; A = its low byte (the bank-$39 copy of
; GetBattleATK) (E-0060)
GetBattleATK_Bank39::
    ld hl, wBattleATK
    jr ReadSlotAIModeIndexed_Bank39_Skip

; A = battle slot: HL = the word for that slot at wBattleDEF; A = its low byte (E-0060)
GetBattleDEF_Bank39::
    ld hl, wBattleDEF
    jr ReadSlotAIModeIndexed_Bank39_Skip

; A = battle slot: HL = the word for that slot at wBattleMaxHP; A = its low byte (E-0060)
GetBattleMaxHP_Bank39::
    ld hl, wBattleMaxHP
    jr ReadSlotAIModeIndexed_Bank39_Skip

; A = battle slot: HL = the word for that slot at wBattleMaxMP; A = its low byte (E-0060)
GetBattleMaxMP_Bank39::
    ld hl, wBattleMaxMP
    jr ReadSlotAIModeIndexed_Bank39_Skip

; A = battle slot: HL = the word for that slot at wBattleHP; A = its low byte (E-0060)
GetBattleHP_Bank39::
    ld hl, wBattleHP
    jr ReadSlotAIModeIndexed_Bank39_Skip

; A = battle slot: HL = the word for that slot at wBattleMP; A = its low byte (E-0060)
GetBattleMP_Bank39::
    ld hl, wBattleMP
    jr ReadSlotAIModeIndexed_Bank39_Skip

; A = battle slot: HL = the word for that slot at wBattleAGL; A = its low byte (E-0060)
GetBattleAGL_Bank39::
    ld hl, wBattleAGL
    jr ReadSlotAIModeIndexed_Bank39_Skip

; A = the byte at wSlotAIMode + A; clobbers HL (the same 10 bytes appear in 5 banks)
ReadSlotAIModeIndexed_Bank39::
    ld hl, wSlotAIMode
    add_a_to_hl
    ld a, [hl]
    ret

ReadSlotAIModeIndexed_Bank39_Skip::
    add a
    add_a_to_hl
    deref_hl
    ret

; HL += 2 * A (A is doubled in 8 bits first, so it wraps above $7F); clobbers A (the same 7 bytes
; appear in 12 banks)
AddDoubleAToHL_Bank39::
    add a
    add_a_to_hl
    ret

; carry set when wBattleActor < 4 (slots 0-3); when wLinkMode = 1 and wLinkRole bit 1 is set the
; test is reversed (carry set when wBattleActor >= 4). Which side is local is inferred from the
; reversal, not checked (E-0064) (the same 27 bytes appear in 12 banks)
ActorOnLocalSide_Bank39::
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
TargetOnLocalSide_Bank39::
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

ClearBattleStatusBitsWithMaskD_Bank39::
    ld a, d
    ld hl, ClearBattleStatusBitsWithMaskD_Bank39_Data
    add_a_to_hl
    ld d, [hl]
    ld a, e
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, d
    and [hl]
    ld [hl], a
    ret

ClearBattleStatusBitsWithMaskD_Bank39_Data::
    db $df, $fe, $00, $fd, $73, $ef, $bf

; Sets bit 0 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks)
SetBit0OfLevelUpGainsIndexed_Bank39::
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 0, [hl]
    pop hl
    ret

; Sets bit 1 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks)
SetBit1OfLevelUpGainsIndexed_Bank39::
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 1, [hl]
    pop hl
    ret

; Sets bit 2 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks)
SetBit2OfLevelUpGainsIndexed_Bank39::
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
PersonalityIndexOfSlot_Bank39::
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
CheckSlotStatusBlockWide_Bank39::
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
SlotHasStatus3Or4Bits_Bank39::
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
    ds $cdd, $00
