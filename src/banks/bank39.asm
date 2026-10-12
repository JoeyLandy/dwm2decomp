SECTION "Bank 39", ROMX[$4000], BANK[$39]
    db $39

; wBattleActionId = wBattleActionChoice[2 * actor]; with mode = wDA53[actor], the entry at Data_039_41AC + 4 * mode holds two per-action routine tables, the second used for actors in slots 4-7 when wC58A is 0 or 2, the first otherwise; calls the routine for the action (JumpToWordAtHL), which writes a slot number to wBattleTargetChoice[2 * actor] (E-0061)
; 8 call sites from 7 routines (e.g. ChooseTargetForActor, PickRandomActionWhenUncontrolled, RunBattleActions_StatusChecks_Case01_ReadByteAtHLPlusA_Case02, RunBattleStep4_ResolveSkill_WriteFollowUpActionAndDefeatFlagsBAEtc, ...)
; reads: wBattleActor, wLinkMode
; writes: wBattleActionId
; points at: wBattleActionChoice, wSlotAIMode
ChooseActionTarget::
Func_039_4001:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleActionChoice
    add a, a
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
    add a, a
    add a, a
    add_a_to_hl
    ld a, [wLinkMode]
    or a, a
    jr z, .check_battle_actor
    cp a, $02
    jr z, .check_battle_actor
    xor a, a
    jr .skip

.check_battle_actor:
    ld a, [wBattleActor]
    and a, $04
    rrca

.skip:
    add_a_to_hl
    deref_hl
    add hl, bc
    add hl, bc
    call JumpToWordAtHL
    ret

; target = a present slot of the opposite three (slots 4-6 for actors 0-3, 0-2 for 4-7): the first present one, then each later present one replaces it when wC5E7 bit 7 is set after AdvanceRandom, so the last is favoured; $FF when none is present (E-0061)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wRandomLo
; points at: wBattleTargetChoice
TargetRandomFoe:: ; code pointer of the table ActionTargetRoutines0; C0
Func_039_404B:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    jp TargetRandomOtherSlot_Skip

; target = the slot in wDA2D[2 * actor] when that slot is present, else TargetRandomFoe (E-0061)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wRandomLo
; points at: wBattleTargetChoice
TargetSavedSlotOrRandomFoe:: ; code pointer of the table ActionTargetRoutines0; C0
Func_039_4055:: ; address name
    ld a, [wBattleActor]
    add a, a
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
    add a, a
    add_a_to_hl
    ld [hl], c
    ret

; target = the first present slot of the opposite three; base + 3 when none is present (E-0061)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wBattleTargetChoice
TargetFirstFoe:: ; code pointer of the table ActionTargetRoutines0; C0
Func_039_4078:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
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
    add a, a
    add_a_to_hl
    ld [hl], c
    ret

; per-action target routine: A = the actor's side (slot 0 or 4), then the shared choice at $417C over that side's living slots (E-0219)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wRandomLo
; points at: wBattleTargetChoice
TargetRandomAlly:: ; code pointer of the table ActionTargetRoutines0; C0
Func_039_409A:: ; address name
    ld a, [wBattleActor]
    and a, $04
    jp TargetRandomOtherSlot_Skip

; target = the first present slot of the actor's own three (the actor included); base + 3 when none is present (E-0061)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wBattleTargetChoice
TargetFirstAlly:: ; code pointer of the table ActionTargetRoutines0; C0
Func_039_40A2:: ; address name
    ld a, [wBattleActor]
    and a, $04
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
    add a, a
    add_a_to_hl
    ld [hl], c
    ret

; target = one of the actor's own three slots by coin flips (wC5E7 bit 7), the later ones favoured; presence is not checked (E-0061)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wRandomLo
; points at: wBattleTargetChoice
TargetRandomAllySlot:: ; code pointer of the table ActionTargetRoutines0; C0
Func_039_40C2:: ; address name
    ld a, [wBattleActor]
    and a, $04
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
    add a, a
    add_a_to_hl
    ld [hl], d
    ret

; per-action target routine (ActionTargetRoutines tables): a random living slot on the actor's side other than the actor (the first such slot when no coin flip picks one), else the side's first slot (E-0219)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wRandomLo
; points at: wBattleTargetChoice
TargetRandomOtherAlly:: ; code pointer of the table ActionTargetRoutines0; C0
Func_039_40E8:: ; address name
    ld a, [wBattleActor]
    ld e, a
    and a, $04
    ld c, a
    ld b, $03
    ld d, $FF

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    cp a, e
    jr z, .next
    ld a, d
    cp a, $FF
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
    cp a, $FF
    jr nz, .read_battle_actor
    ld a, e
    and a, $04
    ld d, a

.read_battle_actor:
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld [hl], d
    ret

; target = wBattleActor; the per-action entry used most often (334 table entries) (E-0061)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wBattleTargetChoice
TargetSelf:: ; code pointer of the table ActionTargetRoutines0; C0
Func_039_412B:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld a, [wBattleActor]
    ld [hl], a
    ret

; target = wBattleActor & 4, slot 0 or 4 of the actor's side; presence is not checked (E-0061)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wBattleTargetChoice
TargetOwnSideFirstSlot:: ; code pointer of the table ActionTargetRoutines0; C0
Func_039_413C:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld a, [wBattleActor]
    and a, $04
    ld [hl], a
    ret

; target = a random slot (wC5E7 & 7 after AdvanceRandom) that is not the actor, is present and is not slot 3 or 7; retries until one is found (E-0061)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wRandomLo
; points at: wBattleTargetChoice
TargetRandomOtherSlot:: ; code pointer of the table ActionTargetRoutines0; C0
Func_039_414F:: ; address name
    ld a, [wBattleActor]
    ld e, a

.loop:
    call AdvanceRandom
    ld a, [wRandomLo]
    and a, $07
    cp a, e
    jr z, .loop
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .loop
    and a, $03
    cp a, $03
    jr z, .loop
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld a, [wRandomLo]
    and a, $07
    ld [hl], a
    ret

TargetRandomOtherSlot_Skip::
Jump_039_417C:: ; address name
    ld c, a
    ld b, $03
    ld d, $FF

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, d
    cp a, $FF
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
    add a, a
    add_a_to_hl
    ld [hl], d
    ret

; E-0219 (C1: ChooseActionTarget reads the record at $41AC + 4 * wSlotAIMode[actor] and takes the second word for battlers 4-7 when wLinkMode is 0 or 2, else the first; it then calls entry wBattleActionId of that table through JumpToWordAtHL).
; record: two tables of per-action target routines
ActionTargetModeTable::
Data_039_41AC:: ; address name
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

; E-0219 (C1: table 0 of ActionTargetModeTable (mode 0, near side); 228 code words, one per action id, as SkillTable (E-0204)).
; record: target routine for this action id
ActionTargetRoutines0::
Data_039_41C0:: ; address name
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

; E-0219 (C1: table 1 of ActionTargetModeTable (mode 0, far side); 228 code words, one per action id, as SkillTable (E-0204)).
; record: target routine for this action id
ActionTargetRoutines1::
Data_039_4388:: ; address name
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

; E-0219 (C1: table 2 of ActionTargetModeTable (mode 1, near side); 228 code words, one per action id, as SkillTable (E-0204)).
; record: target routine for this action id
ActionTargetRoutines2::
Data_039_4550:: ; address name
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

; E-0219 (C1: table 3 of ActionTargetModeTable (mode 1, far side); 228 code words, one per action id, as SkillTable (E-0204)).
; record: target routine for this action id
ActionTargetRoutines3::
Data_039_4718:: ; address name
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

; E-0219 (C1: table 4 of ActionTargetModeTable (mode 2, near side); 228 code words, one per action id, as SkillTable (E-0204)).
; record: target routine for this action id
ActionTargetRoutines4::
Data_039_48E0:: ; address name
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

; E-0219 (C1: table 5 of ActionTargetModeTable (mode 2, far side); 228 code words, one per action id, as SkillTable (E-0204)).
; record: target routine for this action id
ActionTargetRoutines5::
Data_039_4AA8:: ; address name
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

; E-0219 (C1: table 6 of ActionTargetModeTable (mode 3, near side); 228 code words, one per action id, as SkillTable (E-0204)).
; record: target routine for this action id
ActionTargetRoutines6::
Data_039_4C70:: ; address name
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

; E-0219 (C1: table 7 of ActionTargetModeTable (mode 3, far side); 228 code words, one per action id, as SkillTable (E-0204)).
; record: target routine for this action id
ActionTargetRoutines7::
Data_039_4E38:: ; address name
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

; E-0219 (C1: table 8 of ActionTargetModeTable (mode 4, near side); 228 code words, one per action id, as SkillTable (E-0204)).
; record: target routine for this action id
ActionTargetRoutines8::
Data_039_5000:: ; address name
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

; E-0219 (C1: table 9 of ActionTargetModeTable (mode 4, far side); 228 code words, one per action id, as SkillTable (E-0204)).
; record: target routine for this action id
ActionTargetRoutines9::
Data_039_51C8:: ; address name
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

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 0 (no name), 98 SquallHit, 99 BiAttack, 105 PsycheUp, 106 HighJump, 107 EvilSlash, 109 TwinSlash, 110 Berserker, $D2, $D3 ...; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wBattleTarget, wBattleDamageLo, wBattleDamageHi
; writes: wBattleTarget, wBattleDamageLo, wBattleDamageHi
; points at: wBattleDamageLo, wBattleTargetChoice
ChooseTarget_SquallHit:: ; code pointer of the table ActionTargetRoutines4; C0
Func_039_5390:: ; address name
    ld hl, wBattleDamageLo
    ld bc, $0008
    xor a, a
    call FillBytes
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
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
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
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
    ld a, $FF
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
    add a, a
    add_a_to_hl
    ld a, [wBattleTarget]
    ld [hl], a
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 0 (no name), 98 SquallHit, 99 BiAttack, 105 PsycheUp, 106 HighJump, 107 EvilSlash, 109 TwinSlash, 110 Berserker, $D2, $D3 ...; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wBattleTarget, wBattleDamageLo, wBattleDamageHi
; writes: wBattleTarget, wBattleDamageLo, wBattleDamageHi
; points at: wBattleDamageLo, wBattleTargetChoice
ChooseTarget_SquallHit_543C:: ; code pointer of the table ActionTargetRoutines8; C0
Func_039_543C:: ; address name
    ld hl, wBattleDamageLo
    ld bc, $0008
    xor a, a
    call FillBytes
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
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
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
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
    ld a, $FF
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
    add a, a
    add_a_to_hl
    ld a, [wBattleTarget]
    ld [hl], a
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 22 Heal, 23 HealMore, 24 HealAll; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wBattleArg3, wNameSlot
; writes: wBattleArg3, wNameSlot
; points at: wBattleTemp7D, wTargetEstimates, wBattleHP
ChooseTarget_Heal:: ; code pointer of the table ActionTargetRoutines4; C0
Func_039_5514:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld e, a
    ld d, $03

ChooseTarget_Heal_Loop::
Jump_039_551C:: ; address name
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
    add a, a
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
    sub a, d
    ld hl, wBattleTemp7D
    add a, a
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
    sub a, d
    ld hl, wTargetEstimates
    add a, a
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

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 22 Heal, 23 HealMore, 24 HealAll; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp0, hTemp1, hTemp2, wBattleArg3, wNameSlot, wBattleArg0, wBattleTemp7D, ...
; writes: wBattleArg0, wBattleArg3, wNameSlot, hTemp0, hTemp1, hTemp2, wBattleTemp7D, wBattleTemp7E, ...
; points at: hTemp0, wBattleArg0, wSlotDamageFlags, wBattleMaxHP, wBattleTargetChoice, wBattleTemp7D, wTargetEstimates, wBattleHP
ChooseTarget_Heal_5593:: ; code pointer of the table ActionTargetRoutines8; C0
Func_039_5593:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld e, a
    ld d, $03
    xor a, a
    ld [wBattleArg0], a
    ld b, d
    ld c, e
    xor a, a
    ld hl, hTemp0
    ld [hl+], a
    ld [hl+], a
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
    ld de, wSlotDamageFlags
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    bit 0, a
    jr z, .read_temp0
    ld a, $1E
    call Multiply8By16
    jr .read_temp02

.read_temp0:
    ld e, $00

.read_temp02:
    ldh a, [hTemp0]
    add a, l
    ldh [hTemp0], a
    ldh a, [hTemp1]
    adc a, h
    ldh [hTemp1], a
    ldh a, [hTemp2]
    adc a, e
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
    ld [wBattleTemp7D], a
    ld a, h
    ld [wBattleTemp7E], a
    ld a, [wBattleActor]
    and a, $04
    ld e, a
    ld d, $03
    ld a, $FF
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
    add a, a
    add_a_to_hl
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, e
    call GetBattleHP_Bank39
    call CompareHLToBC
    jr z, .read_battle_arg0
    ld a, [wBattleTemp7D]
    ld c, a
    ld a, [wBattleTemp7E]
    ld b, a
    call CompareHLToBC
    jr z, .call_advance_random
    jr nc, .read_battle_arg0
    ld a, l
    ld [wBattleTemp7D], a
    ld a, h
    ld [wBattleTemp7E], a
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
    cp a, $FF
    jr z, .check_battle_actor
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld a, [wBattleArg2]
    ld [hl], a
    ret

.check_battle_actor:
    ld a, [wBattleActor]
    and a, $04
    ld e, a
    ld d, $03
    jp ChooseTarget_Heal_Loop

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 30 Vivify, 31 Revive; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp0, wRandomLo
; writes: hTemp0, hTemp1, hTemp2, hTemp3
; points at: wBattleSlotOut, hTemp1, hTemp0, wBattleTargetChoice
ChooseTarget_Vivify:: ; code pointer of the table ActionTargetRoutines4; C0
Func_039_569C:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03
    xor a, a
    ldh [hTemp0], a
    ld a, $FF
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a

.loop:
    ld a, c
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld a, [hl]
    cp a, $01
    jr nz, .next
    ld a, c
    and a, $03
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
    or a, a
    jr nz, .skip
    ld a, [wBattleActor]
    ld c, a
    jr .read_battle_actor

.skip:
    ld hl, hTemp1
    ld b, $02
    ld a, [hl+]
    cp a, $FF
    jr nz, .loop2
    ld b, $01
    ld a, [hl+]
    cp a, $FF
    jr nz, .loop2
    ld c, [hl]
    jr .read_battle_actor

.loop2:
    ld c, a
    ld a, [hl+]
    cp a, $FF
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
    add a, a
    add_a_to_hl
    ld [hl], c
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 33 Antidote; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wRandomLo, hTemp0
; writes: hTemp1, hTemp2, hTemp3, hTemp0
; points at: hTemp1, wBattleStatus, wBattleTargetChoice
ChooseTarget_Antidote:: ; code pointer of the table ActionTargetRoutines4; C0
Func_039_5716:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03
    xor a, a
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
    and a, $03
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
    or a, a
    jr z, .skip
    cp a, $01
    jr z, .read_battle_actor
    cp a, $03
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
    or a, a
    jr nz, .cp_01
    ld a, [wBattleActor]
    and a, $03
    ldh [hTemp0], a
    jr .read_battle_actor

.cp_01:
    cp a, $01
    jr z, .read_battle_actor
    cp a, $03
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
    ld a, [hl+]
    and a, d
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
    add a, a
    add_a_to_hl
    ldh a, [hTemp0]
    ld c, a
    ld a, [wBattleActor]
    and a, $04
    or a, c
    ld [hl], a
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 45 TwinHits; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1, hTemp2, hTemp0, wRandomLo
; writes: hTemp0, hTemp1, hTemp2
; points at: wBattleStatus, wBattleTargetChoice
ChooseTarget_TwinHits:: ; code pointer of the table ActionTargetRoutines4; C0
Func_039_57D8:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [hTemp0], a
    xor a, a
    ldh [hTemp1], a
    ldh [hTemp2], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl+]
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
    cp a, $FF
    jr nz, .read_battle_actor
    ld a, [wBattleActor]
    ldh [hTemp0], a

.read_battle_actor:
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ldh a, [hTemp0]
    ld c, a
    ld a, [wBattleActor]
    and a, $04
    or a, c
    ld [hl], a
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 37 Upper; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1, hTemp2, hTemp0
; writes: hTemp0, hTemp1, hTemp2
; points at: wBattleTargetChoice
ChooseTarget_Upper:: ; code pointer of the table ActionTargetRoutines4; C0
Func_039_5857:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03
    ld a, $FF
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
    cp a, $FF
    jr nz, .check_battle_actor
    ld a, [wBattleActor]
    and a, $03

.check_battle_actor:
    ld c, a
    ld a, [wBattleActor]
    and a, $04
    or a, c
    ld c, a
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld [hl], c
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 39 Sap; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3
; points at: wBattleStatus2
ChooseTarget_Sap:: ; code pointer of the table ActionTargetRoutines4; C0
Func_039_58B7:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $FF
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
    or a, a
    jr nz, .call_read_byte_at_hl_plus4_a_plus3_c_bank39
    ld a, l
    cp a, $02
    jr c, .next

.call_read_byte_at_hl_plus4_a_plus3_c_bank39:
    ld a, c
    ld hl, wSlotResistances + $3
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $30
    swap a
    cp a, $03
    jr z, .next
    ld e, a
    ldh a, [hTemp1]
    cp a, e
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

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 43 Slow; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3
; points at: wBattleStatus2
ChooseTarget_Slow:: ; code pointer of the table ActionTargetRoutines4; C0
Func_039_5911:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $FF
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
    or a, a
    jr nz, .call_read_byte_at_hl_plus4_a_plus3_c_bank39
    ld a, l
    cp a, $02
    jr c, .next

.call_read_byte_at_hl_plus4_a_plus3_c_bank39:
    ld a, c
    ld hl, wSlotResistances + $3
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $30
    swap a
    cp a, $03
    jr z, .next
    ld e, a
    ldh a, [hTemp1]
    cp a, e
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

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 41 Speed; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1, hTemp2, hTemp0
; writes: hTemp0, hTemp1, hTemp2
; points at: wBattleTargetChoice
ChooseTarget_Speed:: ; code pointer of the table ActionTargetRoutines4; C0
Func_039_596B:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03
    ld a, $FF
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
    cp a, $FF
    jr nz, .check_battle_actor
    ld a, [wBattleActor]
    and a, $03

.check_battle_actor:
    ld c, a
    ld a, [wBattleActor]
    and a, $04
    or a, c
    ld c, a
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld [hl], c
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 130 UltraDown; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3
ChooseTarget_UltraDown:: ; code pointer of the table ActionTargetRoutines4; C0
Func_039_59CB:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $FF
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
    or a, a
    jr nz, .set_temp3
    ld a, l
    cp a, $02
    jr nc, .set_temp3
    ld a, c
    call GetBattleAGL_Bank39
    ld a, h
    or a, a
    jr nz, .set_temp3
    ld a, l
    cp a, $02
    jr c, .next

.set_temp3:
    ld a, c
    ldh [hTemp3], a
    ld hl, wSlotResistances + $2
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $30
    swap a
    cp a, $03
    jr z, .next
    ld e, a
    ldh a, [hTemp1]
    cp a, e
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

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 151 Cover; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp4, hTemp1, hTemp2
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3, hTemp4, hTemp5
ChooseTarget_Cover:: ; code pointer of the table ActionTargetRoutines4; C0
Func_039_5A27:: ; address name
    ld a, [wBattleActor]
    ld e, a
    and a, $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $FF
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
    cp a, e
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

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 147 MouthShut; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3, hTemp4
; points at: wBattleStatus1
ChooseTarget_MouthShut:: ; code pointer of the table ActionTargetRoutines4; C0
Func_039_5A84:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $FF
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
    call ChooseTarget_MouthShut_Sub01
    jr z, .next
    ld a, c
    ldh [hTemp3], a
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit 7, [hl]
    jr nz, .next
    ld a, c
    ldh [hTemp4], a
    ld hl, wSlotResistances + $6
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $C0
    rlca
    rlca
    cp a, $03
    jr z, .next
    ld e, a
    ldh a, [hTemp1]
    cp a, e
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

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 140 SickLick; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3, hTemp4
; points at: wBattleStatus
ChooseTarget_SickLick:: ; code pointer of the table ActionTargetRoutines4; C0
Func_039_5ADB:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $FF
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
    or a, a
    jr nz, .set_temp3
    ld a, l
    cp a, $02
    jr c, .next

.set_temp3:
    ld a, c
    ldh [hTemp3], a
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl+]
    and a, $CC
    jr nz, .next
    inc hl
    inc hl
    ld a, [hl]
    or a, a
    jr nz, .next
    ld a, c
    ldh [hTemp4], a
    ld hl, wSlotResistances + $5
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $0C
    rrca
    rrca
    cp a, $03
    jr z, .next
    ld e, a
    ldh a, [hTemp1]
    cp a, e
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

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 141 LegSweep; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3, hTemp4
; points at: wSlotDamageFlags, wBattleStatus
ChooseTarget_LegSweep:: ; code pointer of the table ActionTargetRoutines4; C0
Func_039_5B40:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $FF
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
    ld hl, wSlotDamageFlags
    add_a_to_hl
    bit 4, [hl]
    jr nz, .next
    ld a, c
    ldh [hTemp3], a
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl+]
    and a, $DC
    jr nz, .next
    inc hl
    inc hl
    ld a, [hl]
    or a, a
    jr nz, .next
    ld a, c
    ldh [hTemp4], a
    ld hl, wSlotResistances + $5
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $0C
    rrca
    rrca
    cp a, $03
    jr z, .next
    ld e, a
    ldh a, [hTemp1]
    cp a, e
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

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 97 NapAttack; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3
; points at: wBattleStatus
ChooseTarget_NapAttack:: ; code pointer of the table ActionTargetRoutines4; C0
Func_039_5BA5:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $FF
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
    ld a, [hl+]
    and a, $CC
    jr nz, .next
    inc hl
    inc hl
    ld a, [hl]
    or a, a
    jr nz, .next
    ld a, c
    ldh [hTemp3], a
    ld hl, wSlotResistances + $2
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $C0
    rlca
    rlca
    cp a, $03
    jr z, .next
    ld e, a
    ldh a, [hTemp1]
    cp a, e
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

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 118 OddDance, 119 RobDance; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3
ChooseTarget_OddDance:: ; code pointer of the table ActionTargetRoutines4; C0
Func_039_5BF9:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $FF
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
    or a, l
    jr z, .next
    ld a, c
    ldh [hTemp3], a
    ld hl, wSlotResistances + $2
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $0C
    rrca
    rrca
    cp a, $03
    jr z, .next
    ld e, a
    ldh a, [hTemp1]
    cp a, e
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

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 94 MetalCut; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1, hTemp2, hTemp3
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3
; points at: wSlotDamageFlags
ChooseTarget_MetalCut:: ; code pointer of the table ActionTargetRoutines4; C0
Func_039_5C43:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $FF
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
    ld hl, wSlotDamageFlags
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

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 85 DrakSlash; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
ChooseTarget_DrakSlash:: ; code pointer of the table ActionTargetRoutines4; C0
Func_039_5C97:: ; address name
    ld d, $01
    call TargetWeakestFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 86 BeastCut; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
ChooseTarget_BeastCut:: ; code pointer of the table ActionTargetRoutines4; C0
Func_039_5C9D:: ; address name
    ld d, $02
    call TargetWeakestFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 87 BirdBlow; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
ChooseTarget_BirdBlow:: ; code pointer of the table ActionTargetRoutines4; C0
Func_039_5CA3:: ; address name
    ld d, $03
    call TargetWeakestFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 90 DevilCut; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
ChooseTarget_DevilCut:: ; code pointer of the table ActionTargetRoutines4; C0
Func_039_5CA9:: ; address name
    ld d, $06
    call TargetWeakestFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 91 ZombieCut; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
ChooseTarget_ZombieCut:: ; code pointer of the table ActionTargetRoutines4; C0
Func_039_5CAF:: ; address name
    ld d, $07
    call TargetWeakestFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 92 CleanCut; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
ChooseTarget_CleanCut:: ; code pointer of the table ActionTargetRoutines4; C0
Func_039_5CB5:: ; address name
    ld d, $08
    call TargetWeakestFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 84 SlimeBlow; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
ChooseTarget_SlimeBlow:: ; code pointer of the table ActionTargetRoutines4; C0
Func_039_5CBB:: ; address name
    ld d, $00
    call TargetWeakestFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 88 BugBlow; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
ChooseTarget_BugBlow:: ; code pointer of the table ActionTargetRoutines4; C0
Func_039_5CC1:: ; address name
    ld d, $05
    call TargetWeakestFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 89 Shears; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
ChooseTarget_Shears:: ; code pointer of the table ActionTargetRoutines4; C0
Func_039_5CC7:: ; address name
    ld d, $04
    call TargetWeakestFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 95 PoisonHit; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3
; points at: wBattleStatus
ChooseTarget_PoisonHit:: ; code pointer of the table ActionTargetRoutines4; C0
Func_039_5CCD:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $FF
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
    and a, $03
    jr nz, .next
    ld a, c
    ldh [hTemp3], a
    ld hl, wSlotResistances + $4
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $03
    cp a, $03
    jr z, .next
    ld e, a
    ldh a, [hTemp1]
    cp a, e
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

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 96 Paralyze; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3
; points at: wBattleStatus
ChooseTarget_Paralyze:: ; code pointer of the table ActionTargetRoutines4; C0
Func_039_5D19:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $FF
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
    and a, $CC
    jr nz, .next
    ld a, c
    ldh [hTemp3], a
    ld hl, wSlotResistances + $5
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $C0
    rlca
    rlca
    cp a, $03
    jr z, .next
    ld e, a
    ldh a, [hTemp1]
    cp a, e
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

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 139 LushLicks, 143 Ahhh; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3
; points at: wBattleStatus
ChooseTarget_LushLicks:: ; code pointer of the table ActionTargetRoutines4; C0
Func_039_5D67:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $FF
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
    ld a, [hl+]
    and a, $DC
    jr nz, .next
    inc hl
    inc hl
    ld a, [hl]
    or a, a
    jr nz, .next
    ld a, c
    ldh [hTemp3], a
    ld hl, wSlotResistances + $5
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $0C
    rrca
    rrca
    cp a, $03
    jr z, .next
    ld e, a
    ldh a, [hTemp1]
    cp a, e
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

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 58 Transform; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1, hTemp2, hTemp3
; writes: hTempA, hTemp0, hTemp3, hTemp1, hTemp2
ChooseTarget_Transform:: ; code pointer of the table ActionTargetRoutines4; C0
Func_039_5DBB:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [hTemp0], a
    ldh [hTemp3], a
    xor a, a
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

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 19 Beat; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1, hTemp2, hTempA, hTemp3, hTemp4, hTemp0
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3, hTemp4, hTemp5
; points at: wBattleStatus2, hTemp2, wBattleTargetChoice
ChooseTarget_Beat:: ; code pointer of the table ActionTargetRoutines4; C0
Func_039_5E03:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [hTemp0], a
    ldh [hTemp1], a
    ldh [hTemp2], a
    xor a, a
    ldh [hTemp3], a
    ldh [hTemp4], a
    ld a, $FF
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
    and a, $30
    swap a
    cp a, $03
    jr z, .next
    ld e, a
    ldh a, [hTemp1]
    cp a, e
    jr z, .skip
    jr c, .next
    ld a, e
    ldh [hTemp1], a
    xor a, a
    ldh [hTemp2], a

.skip:
    ld hl, hTemp2
    inc [hl]

.next:
    inc c
    dec b
    jr nz, .loop
    ldh a, [hTemp2]
    or a, a
    jr z, .read_temp_a
    cp a, $01
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
    and a, $30
    swap a
    cp a, $03
    jr z, .restore
    ld e, a
    ldh a, [hTemp1]
    cp a, e
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
    and a, $30
    swap a
    cp a, e
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
    add a, a
    add_a_to_hl
    ldh a, [hTempA]
    ld e, a
    ldh a, [hTemp0]
    or a, e
    ld [hl], a
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 1 Blaze, 2 Blazemore, 3 Blazemost, $D1, $DF; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActionId, wLinkMode, wBattleActor, hTemp6, hTemp1, hTemp3, hTemp2, hTemp5, ...
; writes: wRecordBuffer, wBattleArg1, wBattleArg2, wBattleArg3, wBattleArg0, hTempA, hTemp0, hTemp1, ...
; points at: hTemp8, wBattleStatus2, wSlotResistances, wBattleTargetChoice
ChooseTarget_Blaze:: ; code pointer of the table ActionTargetRoutines4; C0
Func_039_5F0E:: ; address name
    ld a, [wBattleActionId]
    ld [wRecordBuffer], a
    xor a, a
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
    cp a, $01
    jr z, .set_battle_arg0
    ld a, [wBattleActor]
    and a, $04
    jr z, .set_battle_arg0
    ld e, $0D

.set_battle_arg0:
    ld a, e
    ld [wBattleArg0], a
    farcall LoadSkillRecordPart
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [hTemp0], a
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a
    ldh [hTemp4], a
    ldh [hTemp5], a
    ld [wTargetEstimates], a
    ld [wTargetEstimates + $1], a
    xor a, a
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
    and a, $22
    jr nz, .restore
    ld a, c
    ldh [hTemp4], a
    ld hl, wSlotResistances
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $30
    swap a
    cp a, $03
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
    cp a, e
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
    add a, a
    add_a_to_hl
    ldh a, [hTemp2]
    cp a, $FF
    jr nz, .done
    ldh a, [hTemp5]
    cp a, $FF
    jr nz, .done
    ldh a, [hTemp3]

.done:
    ld [hl], a
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 111 Ramming, 112 Kamikaze; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp4, hTemp3, hTemp0, hTempA, hTemp1, hTemp2
; writes: hTempA, hTemp0, hTemp3, hTemp4, hTemp1, hTemp2
; points at: wBattleStatus6, wBattleStatus7
ChooseTarget_Ramming:: ; code pointer of the table ActionTargetRoutines4; C0
Func_039_6014:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [hTemp0], a
    ldh [hTemp3], a
    ldh [hTemp4], a
    xor a, a
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
    ld a, [hl+]
    and a, $20
    jr nz, .restore
    and a, $05
    jr nz, .restore
    ld a, c
    ld hl, wSlotResistances + $3
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $03
    cp a, $03
    jr z, .restore
    ld e, a
    ldh a, [hTemp4]
    cp a, e
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
    cp a, $FF
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
    bit 0, [hl]
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
    cp a, $FF
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

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 47 Sleep; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3, hTemp4
; points at: wBattleStatus
ChooseTarget_Sleep:: ; code pointer of the table ActionTargetRoutines4; C0
Func_039_60ED:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $FF
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
    ld a, [hl+]
    and a, $CC
    jr nz, .next
    inc hl
    inc hl
    ld a, [hl-]
    or a, a
    jr nz, .next
    ld a, c
    ldh [hTemp3], a
    ld a, [hl]
    and a, $22
    jr nz, .next
    ld a, c
    ldh [hTemp4], a
    ld hl, wSlotResistances + $2
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $C0
    rlca
    rlca
    cp a, $03
    jr z, .next
    ld e, a
    ldh a, [hTemp1]
    cp a, e
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

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 50 RobMagic; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3
; points at: wBattleStatus2
ChooseTarget_RobMagic:: ; code pointer of the table ActionTargetRoutines4; C0
Func_039_614B:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $FF
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
    or a, l
    jr z, .next
    ld a, c
    ldh [hTemp3], a
    ld hl, wBattleStatus2
    call AddAx9ToHL
    ld a, [hl]
    and a, $22
    jr nz, .next
    ld a, c
    ld hl, wSlotResistances + $2
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $0C
    rrca
    rrca
    cp a, $03
    jr z, .next
    ld e, a
    ldh a, [hTemp1]
    cp a, e
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

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 80 FireSlash; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1, wBattleDamageLo, wBattleDamageHi
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3, wBattleDamageLo, wBattleDamageHi
; points at: wBattleStatus3, wSlotResistances
ChooseTarget_FireSlash:: ; code pointer of the table ActionTargetRoutines4; C0
Func_039_61A1:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $FF
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
    ld a, [hl+]
    and a, $C0
    jr nz, .next
    ld a, [hl]
    and a, $0C
    jr nz, .next
    ld a, c
    ldh [hTemp3], a
    ld hl, wSlotResistances
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $30
    swap a
    ld e, a
    ldh a, [hTemp1]
    cp a, e
    jr z, .call_get_battle_hp_bank39
    jr c, .next
    ld a, $FF
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

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 82 BoltSlash; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1, wBattleDamageLo, wBattleDamageHi
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3, wBattleDamageLo, wBattleDamageHi
; points at: wBattleStatus3
ChooseTarget_BoltSlash:: ; code pointer of the table ActionTargetRoutines4; C0
Func_039_6222:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $FF
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
    ld a, [hl+]
    and a, $C0
    jr nz, .next
    ld a, [hl]
    and a, $0C
    jr nz, .next
    ld a, c
    ldh [hTemp3], a
    ld hl, wSlotResistances + $1
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $30
    swap a
    ld e, a
    ldh a, [hTemp1]
    cp a, e
    jr z, .call_get_battle_hp_bank39
    jr c, .next
    ld a, $FF
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

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 81 VacuSlash; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1, wBattleDamageLo, wBattleDamageHi
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3, wBattleDamageLo, wBattleDamageHi
; points at: wBattleStatus3
ChooseTarget_VacuSlash:: ; code pointer of the table ActionTargetRoutines4; C0
Func_039_62A3:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $FF
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
    ld a, [hl+]
    and a, $C0
    jr nz, .next
    ld a, [hl]
    and a, $0C
    jr nz, .next
    ld a, c
    ldh [hTemp3], a
    ld hl, wSlotResistances + $1
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $C0
    rlca
    rlca
    ld e, a
    ldh a, [hTemp1]
    cp a, e
    jr z, .call_get_battle_hp_bank39
    jr c, .next
    ld a, $FF
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

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 83 IceSlash; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1, wBattleDamageLo, wBattleDamageHi
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3, wBattleDamageLo, wBattleDamageHi
; points at: wBattleStatus3
ChooseTarget_IceSlash:: ; code pointer of the table ActionTargetRoutines4; C0
Func_039_6324:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $FF
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
    ld a, [hl+]
    and a, $C0
    jr nz, .next
    ld a, [hl]
    and a, $0C
    jr nz, .next
    ld a, c
    ldh [hTemp3], a
    ld hl, wSlotResistances + $1
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $0C
    rrca
    rrca
    ld e, a
    ldh a, [hTemp1]
    cp a, e
    jr z, .call_get_battle_hp_bank39
    jr c, .next
    ld a, $FF
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

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 72 WindBeast; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1, wBattleDamageLo, wBattleDamageHi
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3, wBattleDamageLo, wBattleDamageHi
ChooseTarget_WindBeast:: ; code pointer of the table ActionTargetRoutines4; C0
Func_039_63A5:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $FF
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
    and a, $C0
    rlca
    rlca
    ld e, a
    ldh a, [hTemp1]
    cp a, e
    jr z, .call_get_battle_hp_bank39
    jr c, .next
    ld a, $FF
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

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 103 GigaSlash; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wBattleTarget, hTemp1, wBattleDamageLo, wBattleDamageHi
; writes: wBattleTarget, hTempA, hTemp0, hTemp1, hTemp2, hTemp3, wBattleDamageLo, wBattleDamageHi
; points at: wBattleTargetChoice
ChooseTarget_GigaSlash:: ; code pointer of the table ActionTargetRoutines4; C0
Func_039_6416:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld [wBattleTarget], a
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $FF
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
    and a, $0C
    rrca
    rrca
    ld e, a
    ldh a, [hTemp1]
    cp a, e
    jr z, .call_get_battle_hp_bank39
    jr c, .next3
    ld a, $FF
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
    add a, a
    add_a_to_hl
    ld a, [wBattleTarget]
    ld [hl], a
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 93 AquaCut; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1, wBattleDamageLo, wBattleDamageHi
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3, wBattleDamageLo, wBattleDamageHi
; points at: wBattleStatus3, wSlotResistances
ChooseTarget_AquaCut:: ; code pointer of the table ActionTargetRoutines4; C0
Func_039_64DB:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $FF
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
    ld a, [hl+]
    and a, $C0
    jr nz, .next
    ld a, [hl]
    and a, $0C
    jr nz, .next
    ld a, c
    ldh [hTemp3], a
    ld hl, wSlotResistances
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $C0
    rlca
    rlca
    ld e, a
    ldh a, [hTemp1]
    cp a, e
    jr z, .call_get_battle_hp_bank39
    jr c, .next
    ld a, $FF
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

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 76 Watershot; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1, wBattleDamageLo, wBattleDamageHi
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3, wBattleDamageLo, wBattleDamageHi
; points at: wSlotResistances
ChooseTarget_Watershot:: ; code pointer of the table ActionTargetRoutines4; C0
Func_039_655C:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $FF
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
    and a, $C0
    rlca
    rlca
    ld e, a
    ldh a, [hTemp1]
    cp a, e
    jr z, .call_get_battle_hp_bank39
    jr c, .next
    ld a, $FF
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

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 61 MegaMagic; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp6, hTemp1, hTemp3, hTemp2, hTemp5, wTargetEstimates, wBattleDamageLo, ...
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3, hTemp4, hTemp5, wTargetEstimates, ...
; points at: wBattleTargetChoice
ChooseTarget_MegaMagic:: ; code pointer of the table ActionTargetRoutines4; C0
Func_039_65CD:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [hTemp0], a
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a
    ldh [hTemp4], a
    ldh [hTemp5], a
    ld [wTargetEstimates], a
    ld [wTargetEstimates + $1], a
    xor a, a
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
    and a, $C0
    rrca
    rrca
    swap a
    cp a, $03
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
    cp a, e
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
    add a, a
    add_a_to_hl
    ldh a, [hTemp2]
    cp a, $FF
    jr nz, .done
    ldh a, [hTemp5]
    cp a, $FF
    jr nz, .done
    ldh a, [hTemp3]

.done:
    ld [hl], a
    ret

; after AdvanceRandom, lists the present opposite slots in slot order (count in hFFC6, slots in hFFC7-hFFC9, unused entries $FF) and lets PickWeightedTargetCandidate choose (E-0061)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; writes: hTemp0, hTemp1, hTemp2, hTemp3
; points at: hTemp0, hTemp1
TargetFoeWeightedBySlotOrder:: ; code pointer of the table ActionTargetRoutines2; C0
Func_039_6691:: ; address name
    call AdvanceRandom
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    xor a, a
    ldh [hTemp0], a
    ld a, $FF
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

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 0 (no name), 98 SquallHit, 99 BiAttack, 105 PsycheUp, 106 HighJump, 107 EvilSlash, 109 TwinSlash, 112 Kamikaze, $CC, $D2 ...; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wBattleDamageLo, wBattleDamageHi, wTargetEstimates, hTemp1, hTemp2, wEffectTemp0, wEffectTemp1, ...
; writes: hTemp0, hTemp1, hTemp2, hTemp3, wBattleDamageLo, wBattleDamageHi, wTargetEstimates, wEffectTemp0, ...
; points at: hTemp0, hTemp1, wBattleDamageLo
ChooseTarget_SquallHit_66C5:: ; code pointer of the table ActionTargetRoutines9; C0
Func_039_66C5:: ; address name
    call AdvanceRandom
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    xor a, a
    ldh [hTemp0], a
    ld a, $FF
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
    add a, a
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
    ld [hl+], a
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

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 22 Heal, 23 HealMore, 24 HealAll; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp5, hTemp6, hTemp1, hTemp2, hTemp0, hTemp3, hTemp4
; writes: wWorkBuf, hTemp0, hTemp1, hTemp2, hTemp3, hTemp4, hTemp5, hTemp6
; points at: wWorkBuf, hTemp1, wBattleTargetChoice
ChooseTarget_Heal_67AD:: ; code pointer of the table ActionTargetRoutines5; C0
Func_039_67AD:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld e, a
    ld d, $03
    push de
    xor a, a
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
    ld [wWorkBuf + $A], a
    ld [wWorkBuf + $B], a

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
    and a, $03
    ld de, wWorkBuf
    add a, a
    add a, a
    add a, e
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
    ld a, $FF
    ldh [hTemp0], a
    xor a, a
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a
    ldh [hTemp4], a

.loop2:
    ld a, e
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next2
    ld hl, hTemp1
    ld a, [hl+]
    or a, [hl]
    inc hl
    or a, [hl]
    inc hl
    or a, [hl]
    jr z, .set_temp0
    ld a, e
    and a, $03
    ld hl, wWorkBuf
    add a, a
    add a, a
    add_a_to_hl
    ld a, l
    ldh [hTemp5], a
    ld a, h
    ldh [hTemp6], a
    ld a, [hl+]
    or a, [hl]
    inc hl
    or a, [hl]
    inc hl
    or a, [hl]
    jr z, .next2
    ldh a, [hTemp5]
    ld l, a
    ldh a, [hTemp6]
    ld h, a
    ld a, [hl+]
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
    ld a, [hl+]
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
    and a, $03
    ld hl, wWorkBuf
    add a, a
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ldh [hTemp1], a
    ld a, [hl+]
    ldh [hTemp2], a
    ld a, [hl+]
    ldh [hTemp3], a
    ld a, [hl]
    ldh [hTemp4], a

.next2:
    inc e
    dec d
    jr nz, .loop2
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ldh a, [hTemp0]
    cp a, $FF
    jr nz, .done
    ld a, [wBattleActor]

.done:
    ld [hl], a
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 22 Heal, 23 HealMore, 24 HealAll; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp4, hTemp5, hTemp0, wEffectTemp0, wEffectTemp1, wTargetEstimates, hTemp3, ...
; writes: hTemp0, hTemp4, hTemp5, hTemp1, hTemp2, hTemp3, wBattleDamageLo, wBattleDamageHi, ...
; points at: hTemp0, wBattleDamageLo, hTemp1, wBattleTargetChoice, wWorkBuf
ChooseTarget_Heal_68B0:: ; code pointer of the table ActionTargetRoutines9; C0
Func_039_68B0:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld e, a
    ld d, $03
    push de
    xor a, a
    ldh [hTemp0], a
    ldh [hTemp4], a
    ldh [hTemp5], a
    ld a, $FF
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
    add a, l
    ldh [hTemp4], a
    ldh a, [hTemp5]
    adc a, h
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
    xor a, a
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
    add a, a
    add a, c
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
    or a, a
    jp z, ChooseTarget_Heal_67AD
    cp a, $01
    jr z, .read_battle_actor
    cp a, $02
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
    add a, a
    add_a_to_hl
    ldh a, [hTemp1]
    ld [hl], a
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 30 Vivify, 31 Revive; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp0, wRandomLo
; writes: hTemp0, hTemp1, hTemp2, hTemp3
; points at: wBattleSlotOut, hTemp1, hTemp0, wBattleTargetChoice
ChooseTarget_Vivify_6998:: ; code pointer of the table ActionTargetRoutines5; C0
Func_039_6998:: ; address name
    jp ChooseTarget_Vivify

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 33 Antidote; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wRandomLo, hTemp0
; writes: hTemp1, hTemp2, hTemp3, hTemp0
; points at: hTemp1, wBattleStatus, wBattleTargetChoice
ChooseTarget_Antidote_699B:: ; code pointer of the table ActionTargetRoutines5; C0
Func_039_699B:: ; address name
    jp ChooseTarget_Antidote

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 45 TwinHits; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1, hTemp2, hTemp0, wRandomLo
; writes: hTemp0, hTemp1, hTemp2
; points at: wBattleStatus, wBattleTargetChoice
ChooseTarget_TwinHits_699E:: ; code pointer of the table ActionTargetRoutines5; C0
Func_039_699E:: ; address name
    jp ChooseTarget_TwinHits

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 37 Upper; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1, hTemp2, hTemp0
; writes: hTemp0, hTemp1, hTemp2
; points at: wBattleTargetChoice
ChooseTarget_Upper_69A1:: ; code pointer of the table ActionTargetRoutines5; C0
Func_039_69A1:: ; address name
    jp ChooseTarget_Upper

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 39 Sap; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3
; points at: wBattleStatus2
ChooseTarget_Sap_69A4:: ; code pointer of the table ActionTargetRoutines5; C0
Func_039_69A4:: ; address name
    jp ChooseTarget_Sap

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 43 Slow; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3
; points at: wBattleStatus2
ChooseTarget_Slow_69A7:: ; code pointer of the table ActionTargetRoutines5; C0
Func_039_69A7:: ; address name
    jp ChooseTarget_Slow

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 41 Speed; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1, hTemp2, hTemp0
; writes: hTemp0, hTemp1, hTemp2
; points at: wBattleTargetChoice
ChooseTarget_Speed_69AA:: ; code pointer of the table ActionTargetRoutines5; C0
Func_039_69AA:: ; address name
    jp ChooseTarget_Speed

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 130 UltraDown; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3
ChooseTarget_UltraDown_69AD:: ; code pointer of the table ActionTargetRoutines5; C0
Func_039_69AD:: ; address name
    jp ChooseTarget_UltraDown

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 151 Cover; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp4, hTemp1, hTemp2
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3, hTemp4, hTemp5
ChooseTarget_Cover_69B0:: ; code pointer of the table ActionTargetRoutines5; C0
Func_039_69B0:: ; address name
    jp ChooseTarget_Cover

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 147 MouthShut; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3, hTemp4
; points at: wBattleStatus1
ChooseTarget_MouthShut_69B3:: ; code pointer of the table ActionTargetRoutines5; C0
Func_039_69B3:: ; address name
    jp ChooseTarget_MouthShut

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 140 SickLick; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3, hTemp4
; points at: wBattleStatus
ChooseTarget_SickLick_69B6:: ; code pointer of the table ActionTargetRoutines5; C0
Func_039_69B6:: ; address name
    jp ChooseTarget_SickLick

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 141 LegSweep; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3, hTemp4
; points at: wSlotDamageFlags, wBattleStatus
ChooseTarget_LegSweep_69B9:: ; code pointer of the table ActionTargetRoutines5; C0
Func_039_69B9:: ; address name
    jp ChooseTarget_LegSweep

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 97 NapAttack; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3
; points at: wBattleStatus
ChooseTarget_NapAttack_69BC:: ; code pointer of the table ActionTargetRoutines9; C0
Func_039_69BC:: ; address name
    jp ChooseTarget_NapAttack

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 118 OddDance, 119 RobDance; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3
ChooseTarget_OddDance_69BF:: ; code pointer of the table ActionTargetRoutines5; C0
Func_039_69BF:: ; address name
    jp ChooseTarget_OddDance

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 94 MetalCut; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1, hTemp2, hTemp3
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3
; points at: wSlotDamageFlags
ChooseTarget_MetalCut_69C2:: ; code pointer of the table ActionTargetRoutines5; C0
Func_039_69C2:: ; address name
    jp ChooseTarget_MetalCut

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 85 DrakSlash; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
ChooseTarget_DrakSlash_69C5:: ; code pointer of the table ActionTargetRoutines5; C0
Func_039_69C5:: ; address name
    ld d, $01
    call TargetRandomFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 86 BeastCut; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
ChooseTarget_BeastCut_69CB:: ; code pointer of the table ActionTargetRoutines5; C0
Func_039_69CB:: ; address name
    ld d, $02
    call TargetRandomFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 87 BirdBlow; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
ChooseTarget_BirdBlow_69D1:: ; code pointer of the table ActionTargetRoutines5; C0
Func_039_69D1:: ; address name
    ld d, $03
    call TargetRandomFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 90 DevilCut; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
ChooseTarget_DevilCut_69D7:: ; code pointer of the table ActionTargetRoutines5; C0
Func_039_69D7:: ; address name
    ld d, $06
    call TargetRandomFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 91 ZombieCut; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
ChooseTarget_ZombieCut_69DD:: ; code pointer of the table ActionTargetRoutines5; C0
Func_039_69DD:: ; address name
    ld d, $07
    call TargetRandomFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 92 CleanCut; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
ChooseTarget_CleanCut_69E3:: ; code pointer of the table ActionTargetRoutines5; C0
Func_039_69E3:: ; address name
    ld d, $08
    call TargetRandomFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 84 SlimeBlow; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
ChooseTarget_SlimeBlow_69E9:: ; code pointer of the table ActionTargetRoutines5; C0
Func_039_69E9:: ; address name
    ld d, $00
    call TargetRandomFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 88 BugBlow; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
ChooseTarget_BugBlow_69EF:: ; code pointer of the table ActionTargetRoutines5; C0
Func_039_69EF:: ; address name
    ld d, $05
    call TargetRandomFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 89 Shears; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
ChooseTarget_Shears_69F5:: ; code pointer of the table ActionTargetRoutines5; C0
Func_039_69F5:: ; address name
    ld d, $04
    call TargetRandomFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 95 PoisonHit; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3
; points at: wBattleStatus
ChooseTarget_PoisonHit_69FB:: ; code pointer of the table ActionTargetRoutines9; C0
Func_039_69FB:: ; address name
    jp ChooseTarget_PoisonHit

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 96 Paralyze; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3
; points at: wBattleStatus
ChooseTarget_Paralyze_69FE:: ; code pointer of the table ActionTargetRoutines9; C0
Func_039_69FE:: ; address name
    jp ChooseTarget_Paralyze

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 139 LushLicks, 143 Ahhh; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3
; points at: wBattleStatus
ChooseTarget_LushLicks_6A01:: ; code pointer of the table ActionTargetRoutines9; C0
Func_039_6A01:: ; address name
    jp ChooseTarget_LushLicks

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 58 Transform; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1, hTemp2, hTemp3
; writes: hTempA, hTemp0, hTemp3, hTemp1, hTemp2
ChooseTarget_Transform_6A04:: ; code pointer of the table ActionTargetRoutines5; C0
Func_039_6A04:: ; address name
    jp ChooseTarget_Transform

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 19 Beat; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1, hTemp2, hTempA, hTemp3, hTemp4, hTemp0
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3, hTemp4, hTemp5
; points at: wBattleStatus2, hTemp2, wBattleTargetChoice
ChooseTarget_Beat_6A07:: ; code pointer of the table ActionTargetRoutines9; C0
Func_039_6A07:: ; address name
    jp ChooseTarget_Beat

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 1 Blaze, 2 Blazemore, 3 Blazemost, $D1, $DF; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActionId, wLinkMode, wBattleActor, hTemp6, hTemp1, hTemp3, hTemp2, hTemp5, ...
; writes: wRecordBuffer, wBattleArg1, wBattleArg2, wBattleArg3, wBattleArg0, hTempA, hTemp0, hTemp1, ...
; points at: hTemp8, wBattleStatus2, wSlotResistances, wBattleTargetChoice
ChooseTarget_Blaze_6A0A:: ; code pointer of the table ActionTargetRoutines9; C0
Func_039_6A0A:: ; address name
    jp ChooseTarget_Blaze

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 110 Berserker, 111 Ramming; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp4, hTemp3, hTemp0, hTempA, hTemp1, hTemp2
; writes: hTempA, hTemp0, hTemp3, hTemp4, hTemp1, hTemp2
; points at: wBattleStatus6, wBattleStatus7
ChooseTarget_Berserker:: ; code pointer of the table ActionTargetRoutines9; C0
Func_039_6A0D:: ; address name
    jp ChooseTarget_Ramming

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 47 Sleep; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3, hTemp4
; points at: wBattleStatus
ChooseTarget_Sleep_6A10:: ; code pointer of the table ActionTargetRoutines9; C0
Func_039_6A10:: ; address name
    jp ChooseTarget_Sleep

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 50 RobMagic; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3
; points at: wBattleStatus2
ChooseTarget_RobMagic_6A13:: ; code pointer of the table ActionTargetRoutines5; C0
Func_039_6A13:: ; address name
    jp ChooseTarget_RobMagic

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 80 FireSlash; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1, wBattleDamageLo, wBattleDamageHi
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3, wBattleDamageLo, wBattleDamageHi
; points at: wBattleStatus3, wSlotResistances
ChooseTarget_FireSlash_6A16:: ; code pointer of the table ActionTargetRoutines9; C0
Func_039_6A16:: ; address name
    jp ChooseTarget_FireSlash

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 82 BoltSlash; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1, wBattleDamageLo, wBattleDamageHi
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3, wBattleDamageLo, wBattleDamageHi
; points at: wBattleStatus3
ChooseTarget_BoltSlash_6A19:: ; code pointer of the table ActionTargetRoutines9; C0
Func_039_6A19:: ; address name
    jp ChooseTarget_BoltSlash

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 81 VacuSlash; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1, wBattleDamageLo, wBattleDamageHi
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3, wBattleDamageLo, wBattleDamageHi
; points at: wBattleStatus3
ChooseTarget_VacuSlash_6A1C:: ; code pointer of the table ActionTargetRoutines9; C0
Func_039_6A1C:: ; address name
    jp ChooseTarget_VacuSlash

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 83 IceSlash; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1, wBattleDamageLo, wBattleDamageHi
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3, wBattleDamageLo, wBattleDamageHi
; points at: wBattleStatus3
ChooseTarget_IceSlash_6A1F:: ; code pointer of the table ActionTargetRoutines9; C0
Func_039_6A1F:: ; address name
    jp ChooseTarget_IceSlash

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 72 WindBeast; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1, wBattleDamageLo, wBattleDamageHi
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3, wBattleDamageLo, wBattleDamageHi
ChooseTarget_WindBeast_6A22:: ; code pointer of the table ActionTargetRoutines9; C0
Func_039_6A22:: ; address name
    jp ChooseTarget_WindBeast

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 103 GigaSlash; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1, wBattleDamageLo, wBattleDamageHi
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3, wBattleDamageLo, wBattleDamageHi
ChooseTarget_GigaSlash_6A25:: ; code pointer of the table ActionTargetRoutines9; C0
Func_039_6A25:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $FF
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
    and a, $0C
    rrca
    rrca
    ld e, a
    ldh a, [hTemp1]
    cp a, e
    jr z, .call_get_battle_hp_bank39
    jr c, .next
    ld a, $FF
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

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 93 AquaCut; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1, wBattleDamageLo, wBattleDamageHi
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3, wBattleDamageLo, wBattleDamageHi
; points at: wBattleStatus3, wSlotResistances
ChooseTarget_AquaCut_6A96:: ; code pointer of the table ActionTargetRoutines9; C0
Func_039_6A96:: ; address name
    jp ChooseTarget_AquaCut

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 76 Watershot; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1, wBattleDamageLo, wBattleDamageHi
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3, wBattleDamageLo, wBattleDamageHi
; points at: wSlotResistances
ChooseTarget_Watershot_6A99:: ; code pointer of the table ActionTargetRoutines9; C0
Func_039_6A99:: ; address name
    jp ChooseTarget_Watershot

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 173 PanicAll; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3, hTemp4
; points at: wBattleStatus
ChooseTarget_PanicAll:: ; code pointer of the table ActionTargetRoutines9; C0
Func_039_6A9C:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $FF
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
    ld a, [hl+]
    and a, $CC
    jr nz, .next
    inc hl
    inc hl
    ld a, [hl-]
    or a, a
    jr nz, .next
    ld a, c
    ldh [hTemp3], a
    ld a, [hl]
    and a, $22
    jr nz, .next
    ld a, c
    ldh [hTemp4], a
    ld hl, wSlotResistances + $3
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $C0
    rlca
    rlca
    cp a, $03
    jr z, .next
    ld e, a
    ldh a, [hTemp1]
    cp a, e
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

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 61 MegaMagic; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp6, hTemp1, hTemp3, hTemp2, hTemp5, wTargetEstimates, wBattleDamageLo, ...
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3, hTemp4, hTemp5, wTargetEstimates, ...
; points at: wBattleTargetChoice
ChooseTarget_MegaMagic_6AFA:: ; code pointer of the table ActionTargetRoutines9; C0
Func_039_6AFA:: ; address name
    jp ChooseTarget_MegaMagic

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 33 Antidote; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp0, hTemp1, wRandomLo, hTemp2
; writes: hTemp0, hTemp1, hTemp2, hTemp3
; points at: wBattleStatus, hTemp0, hTemp1, wBattleTargetChoice
ChooseTarget_Antidote_6AFD:: ; code pointer of the table ActionTargetRoutines2; C0
Func_039_6AFD:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld hl, wBattleStatus
    ld d, $03
    jp TargetAllyWithStatusBit20_CallAddAx9ToHL

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 37 Upper; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp0, hTemp1, wRandomLo, hTemp2
; writes: hTemp0, hTemp1, hTemp2, hTemp3
; points at: hTemp0, hTemp1, wBattleTargetChoice
ChooseTarget_Upper_6B0A:: ; code pointer of the table ActionTargetRoutines2; C0
Func_039_6B0A:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03
    xor a, a
    ldh [hTemp0], a
    ld a, $FF
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
    or a, a
    jp nz, PickWeightedTargetCandidate
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld a, [wBattleActor]
    ld [hl], a
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 41 Speed; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp0, hTemp1, wRandomLo, hTemp2
; writes: hTemp0, hTemp1, hTemp2, hTemp3
; points at: hTemp0, hTemp1, wBattleTargetChoice
ChooseTarget_Speed_6B5D:: ; code pointer of the table ActionTargetRoutines2; C0
Func_039_6B5D:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03
    xor a, a
    ldh [hTemp0], a
    ld a, $FF
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
    or a, a
    jp nz, PickWeightedTargetCandidate
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld a, [wBattleActor]
    ld [hl], a
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 39 Sap; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp0
; writes: hTemp0, hTemp1, hTemp2, hTemp3
; points at: hTemp0, hTemp1
ChooseTarget_Sap_6BB0:: ; code pointer of the table ActionTargetRoutines2; C0
Func_039_6BB0:: ; address name
    ld de, GetBattleDEF_Bank39
    jp TargetAllyWithStatusBit20_CheckBattleActor

; per-action target routine: DE = GetBattleAGL_Bank39, then the shared stat comparison at $6C30 (E-0219)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp0
; writes: hTemp0, hTemp1, hTemp2, hTemp3
; points at: hTemp0, hTemp1
TargetByAllyAGL:: ; code pointer of the table ActionTargetRoutines2; C0
Func_039_6BB6:: ; address name
    ld de, GetBattleAGL_Bank39
    jp TargetAllyWithStatusBit20_CheckBattleActor

; per-action target routine: scans the actor's side for wBattleStatus (+9 * slot) bit mask $10 (shared code at $6BE3) (E-0219)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp0, hTemp1, wRandomLo, hTemp2
; writes: hTemp0, hTemp1, hTemp2, hTemp3
; points at: wBattleStatus, hTemp0, hTemp1, wBattleTargetChoice
TargetAllyWithStatusBit10:: ; heuristic: follows a terminator; C0
Func_039_6BBC:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld hl, wBattleStatus
    ld d, $10
    jp TargetAllyWithStatusBit20_CallAddAx9ToHL

; as TargetAllyWithStatusBit10 with mask $40 (E-0219)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp0, hTemp1, wRandomLo, hTemp2
; writes: hTemp0, hTemp1, hTemp2, hTemp3
; points at: wBattleStatus, hTemp0, hTemp1, wBattleTargetChoice
TargetAllyWithStatusBit40:: ; heuristic: follows a terminator; C0
Func_039_6BC9:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld hl, wBattleStatus
    ld d, $40
    jp TargetAllyWithStatusBit20_CallAddAx9ToHL

; as TargetAllyWithStatusBit10 with mask $20 (E-0219)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp0, hTemp1, wRandomLo, hTemp2
; writes: hTemp0, hTemp1, hTemp2, hTemp3
; points at: wBattleStatus, hTemp0, hTemp1, wBattleTargetChoice
TargetAllyWithStatusBit20:: ; heuristic: follows a terminator; C0
Func_039_6BD6:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld hl, wBattleStatus
    ld d, $20
    jp TargetAllyWithStatusBit20_CallAddAx9ToHL

TargetAllyWithStatusBit20_CallAddAx9ToHL::
Jump_039_6BE3:: ; address name
    ld c, a
    ld b, $03
    call AddAx9ToHL
    xor a, a
    ldh [hTemp0], a
    ld a, $FF
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .skip
    ld a, [hl]
    and a, d
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
    or a, a
    jp nz, PickWeightedTargetCandidate
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld a, [wBattleActor]
    ld [hl], a
    ret

TargetAllyWithStatusBit20_CheckBattleActor::
Jump_039_6C30:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    xor a, a
    ldh [hTemp0], a
    ld a, $FF
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
    or a, a
    jr nz, .skip
    ld a, l
    cp a, $02
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
    or a, a
    jp z, TargetFoeWeightedBySlotOrder
    call PickWeightedTargetCandidate
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 22 Heal, 23 HealMore, 24 HealAll; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1, hTemp2, hTemp3, hTemp4, wRandomLo, hTemp0
; writes: hTemp0, hTemp1, hTemp2, hTemp3, hTemp4
; points at: wBattleTargetChoice
ChooseTarget_Heal_6C75:: ; code pointer of the table ActionTargetRoutines2; C0
Func_039_6C75:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [hTemp0], a
    xor a, a
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
    sub a, l
    ld e, a
    ldh a, [hTemp2]
    sbc a, h
    ld d, a
    jr c, .set_temp1
    ld a, d
    or a, e
    jr nz, .restore
    ldh a, [hTemp3]
    sub a, c
    ld e, a
    ldh a, [hTemp4]
    sbc a, b
    ld d, a
    jr c, .set_temp1
    ld a, d
    or a, e
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
    add a, a
    add_a_to_hl
    ldh a, [hTemp0]
    ld [hl], a
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 27 MPass, 28 MPassmore, 29 MPassmost; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp1, hTemp2, hTemp3, hTemp4, wRandomLo, hTemp0
; writes: hTemp0, hTemp1, hTemp2, hTemp3, hTemp4
; points at: wBattleTargetChoice
ChooseTarget_MPass:: ; code pointer of the table ActionTargetRoutines2; C0
Func_039_6CE9:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [hTemp0], a
    xor a, a
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a
    ldh [hTemp4], a

.loop:
    push bc
    ld a, [wBattleActor]
    cp a, c
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
    sub a, l
    ld e, a
    ldh a, [hTemp2]
    sbc a, h
    ld d, a
    jr c, .set_temp1
    ld a, d
    or a, e
    jr nz, .restore
    ldh a, [hTemp3]
    sub a, c
    ld e, a
    ldh a, [hTemp4]
    sbc a, b
    ld d, a
    jr c, .set_temp1
    ld a, d
    or a, e
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
    add a, a
    add_a_to_hl
    ldh a, [hTemp0]
    cp a, $FF
    jr nz, .done
    ld a, [wBattleActor]

.done:
    ld [hl], a
    ret

; A = slot: A = its status byte 4 (wD810) & $0C; Z set when both bits are clear (E-0116)
; 3 call sites from 3 routines (e.g. ChooseTarget_SquallHit_543C, ChooseTarget_GigaSlash, ChooseTarget_SquallHit)
; points at: wBattleStatus4
SlotStatus4Bits23::
Func_039_6D6A:: ; address name
    ld hl, wBattleStatus4
    call AddAx9ToHL
    ld a, [hl]
    and a, $0C
    ret

; wD87F = 0, hFFC7 = 0, stores HP + DEF of three slots from the target in wD874 and falls into PickWeakestEstimatedTarget (E-0126)
; 3 call sites from 3 routines (e.g. ChooseTarget_SquallHit_543C, ChooseTarget_GigaSlash, ChooseTarget_SquallHit)
; reads: wBattleTarget, wTargetEstimates, hTemp0, wRandomLo
; writes: wBattleTemp7F, hTemp1, hTemp0
; points at: wTargetEstimates, wBattleTarget
EstimateAndPickWeakestTarget::
Func_039_6D74:: ; address name
    ld a, $00
    ld [wBattleTemp7F], a
    xor a, a
    ldh [hTemp1], a
    ld b, $03
    ld a, [wBattleTarget]
    ld c, a

.loop:
    call StoreSlotHPPlusDEFToTargetEstimates
    inc c
    dec b
    jr nz, .loop

; picks the smallest of the three wD874 estimates (ties broken randomly) and adds its index to wBattleTarget (E-0125)
; 3 call sites from 3 routines (e.g. EstimateThreeTargets, ChooseTarget_SquallHit_543C, ChooseTarget_SquallHit)
; reads: wTargetEstimates, hTemp0, wRandomLo
; writes: hTemp0
; points at: wTargetEstimates, wBattleTarget
PickWeakestEstimatedTarget::
Func_039_6D89:: ; address name
    xor a, a
    ldh [hTemp0], a
    ld a, [wTargetEstimates]
    ld c, a
    ld a, [wTargetEstimates + $1]
    ld b, a
    ld de, $0201

.loop:
    ld a, e
    ld hl, wTargetEstimates
    add a, a
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
    add a, [hl]
    ld [hl], a
    ret

; slot C: stores HP + DEF (DEF halved when hFFC7 is set and bit 2 of its wD812 byte is set) in wD874[C & 3], or $FFFF when empty (E-0124)
; 2 call sites from 2 routines (e.g. EstimateAndPickWeakestTarget, EstimateThreeTargets)
; reads: hTemp1
; points at: wBattleStatus6, wTargetEstimates
StoreSlotHPPlusDEFToTargetEstimates::
Func_039_6DC8:: ; address name
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, StoreFFFFToTargetEstimatesSlotC
    call GetBattleHP_Bank39
    push hl
    ld a, c
    call GetBattleDEF_Bank39
    ldh a, [hTemp1]
    or a, a
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
; 1 call site from 1 routine (e.g. EstimateThreeTargets)
; points at: wTargetEstimates
StoreFFFFToTargetEstimatesSlotC::
Func_039_6DF1:: ; address name
    ld hl, $FFFF

; stores HL in the word wD874[C & 3] (E-0122)
; 2 call sites from 2 routines (e.g. ChooseTarget_SquallHit_543C, ChooseTarget_SquallHit)
; points at: wTargetEstimates
StoreHLToTargetEstimatesSlotC::
Func_039_6DF4:: ; address name
    ld a, c
    and a, $03
    add a, a
    ld de, wTargetEstimates
    add a, e
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

; A = slot: NZ when its status byte 0 & $40, byte 3 & $C0, byte 4 & $0C, byte 6 & $20 or byte 7 & $07 is set (A = that masked value), Z when none is (E-0096)
; 7 call sites from 3 routines (e.g. ChooseTarget_SquallHit_543C, ChooseTarget_GigaSlash, ChooseTarget_SquallHit)
; points at: wBattleStatus
AnySlotStatusMaskSet::
Func_039_6E06:: ; address name
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl+]
    and a, $40
    jr nz, .return
    inc hl
    inc hl
    ld a, [hl+]
    and a, $C0
    jr nz, .return
    ld a, [hl+]
    and a, $0C
    jr nz, .return
    inc hl
    ld a, [hl+]
    and a, $20
    jr nz, .return
    ld a, [hl]
    and a, $07

.return:
    ret

; fills the damage for wBattleActionId: the effect handler for 0 or ids from $48 (except $66), Func_01A_408F for low ids and $66, or the actor's ATK for $6B and $6C (E-0124)
; 2 call sites from 2 routines (e.g. ChooseTarget_SquallHit_543C, ChooseTarget_SquallHit)
; reads: wBattleActionId, wBattleActor
; writes: wBattleDamageLo, wBattleDamageHi
ComputeDamageEstimateForAction::
Func_039_6E27:: ; address name
    push bc
    ld a, [wBattleActionId]
    cp a, $00
    jr z, .call_run_effect_handler_for_action_id
    cp a, $48
    jr c, .call_compute_damage_estimate_for_action
    cp a, $66
    jr z, .call_compute_damage_estimate_for_action
    cp a, $6B
    jr z, .read_battle_actor
    cp a, $6C
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

; if bit 0 of wD8A7[C] is set, the damage word (wBattleDamageLo, wD873) = damage * 50 (Multiply8By16); registers preserved (E-0121)
; 2 call sites from 2 routines (e.g. ChooseTarget_SquallHit_543C, ChooseTarget_SquallHit)
; reads: wBattleDamageLo, wBattleDamageHi
; writes: wBattleDamageLo, wBattleDamageHi
; points at: wSlotDamageFlags
MultiplyDamageBy50IfSlotDamageFlagsBit0::
Func_039_6E61:: ; address name
    ld a, c
    ld hl, wSlotDamageFlags
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

; hFFC7 = 1; for three slots from the target stores HP + DEF in wD874, or $FFFF for slots with wD80F status bits $C0 or $0C; then Func_039_6D89 (E-0124)
; 4 call sites from 3 routines (e.g. ChooseTarget_SquallHit_543C, ChooseTarget_GigaSlash, ChooseTarget_SquallHit)
; reads: wBattleTarget
; writes: hTemp1
; points at: wBattleStatus3
EstimateThreeTargets::
Func_039_6E8B:: ; address name
    ld a, $01
    ldh [hTemp1], a
    ld b, $03
    ld a, [wBattleTarget]
    ld c, a

.loop:
    ld a, c
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hl+]
    and a, $C0
    jr nz, .call_store_ffff_to_target_estimates_slot_c
    ld a, [hl]
    and a, $0C
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

; only called from ChooseTarget_Heal (E-0047)
; 1 call site from 1 routine (e.g. ChooseTarget_Heal)
; reads: hTemp1, hTemp0, hTemp2, wBattleActor, wBattleTarget
; writes: hTemp0, hTemp1, hTemp2, wBattleTarget
; points at: wTargetEstimates, wBattleTemp7D, hTemp1, wBattleTargetChoice
ChooseTarget_Heal_WriteTemp0AndTemp1Etc::
Func_039_6EB6:: ; address name
    ld a, $00
    ldh [hTemp0], a
    ld a, $01
    ldh [hTemp1], a
    ld a, $02
    ldh [hTemp2], a

.loop:
    ldh a, [hTemp1]
    ld hl, wTargetEstimates
    add a, a
    add_a_to_hl
    ld c, [hl]
    inc hl
    ld b, [hl]
    ldh a, [hTemp0]
    ld hl, wTargetEstimates
    add a, a
    add_a_to_hl
    deref_hl
    call CompareHLToBC
    jr c, .read_temp1
    jr nz, .check_temp2
    ldh a, [hTemp1]
    ld hl, wBattleTemp7D
    add a, a
    add_a_to_hl
    ld c, [hl]
    inc hl
    ld b, [hl]
    ldh a, [hTemp0]
    ld hl, wBattleTemp7D
    add a, a
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
    and a, $04
    or a, c
    ld [wBattleTarget], a
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld a, [wBattleTarget]
    ld [hl], a
    ret

; HL = 999 when the base DEF doubled (quadrupled for allies or link battles) reaches 999, otherwise the base DEF times that factor (E-0124)
; 2 call sites from 2 routines (e.g. ChooseTarget_Upper, ChooseTarget_Upper_6B0A)
; reads: wBattleStatResultLo, wBattleStatResultHi, wLinkMode, wBattleActor
BuffCapOfBaseDEF::
Func_039_6F32:: ; address name
    farcall GetBaseDEF
    ld a, [wBattleStatResultLo]
    ld l, a
    ld a, [wBattleStatResultHi]
    ld h, a
    ld bc, $03E7
    call CompareHLToBC
    jr nc, .return
    add hl, hl
    call CompareHLToBC
    jr nc, .done
    ld a, [wLinkMode]
    cp a, $01
    jr z, .call_compare_hl_to_bc
    ld a, [wBattleActor]
    and a, $04
    jr nz, .return

.call_compare_hl_to_bc:
    add hl, hl
    call CompareHLToBC
    jr c, .return

.done:
    ld hl, $03E7

.return:
    ret

; HL = 999 when the base AGL doubled (quadrupled for allies or link battles) reaches 999, otherwise the base AGL times that factor (E-0124)
; 2 call sites from 2 routines (e.g. ChooseTarget_Speed, ChooseTarget_Speed_6B5D)
; reads: wBattleStatResultLo, wBattleStatResultHi, wLinkMode, wBattleActor
BuffCapOfBaseAGL::
Func_039_6F66:: ; address name
    farcall GetBaseAGL
    ld a, [wBattleStatResultLo]
    ld l, a
    ld a, [wBattleStatResultHi]
    ld h, a
    ld bc, $03E7
    call CompareHLToBC
    jr nc, .return
    add hl, hl
    call CompareHLToBC
    jr nc, .done
    ld a, [wLinkMode]
    cp a, $01
    jr z, .call_compare_hl_to_bc
    ld a, [wBattleActor]
    and a, $04
    jr nz, .return

.call_compare_hl_to_bc:
    add hl, hl
    call CompareHLToBC
    jr c, .return

.done:
    ld hl, $03E7

.return:
    ret

; only called from ChooseTarget_MouthShut (E-0047)
; 1 call site from 1 routine (e.g. ChooseTarget_MouthShut)
; points at: wBattleSkills
ChooseTarget_MouthShut_Sub01::
Func_039_6F9A:: ; address name
    push bc
    ld hl, wBattleSkills
    swap a
    add_a_to_hl
    ld bc, $0800

.loop:
    ld a, [hl+]
    cp a, $40
    jr c, .next2
    cp a, $48
    jr c, .next
    cp a, $70
    jr c, .next2
    cp a, $76
    jr c, .next
    cp a, $89
    jr z, .next
    jr .next2

.next:
    inc c

.next2:
    inc hl
    dec b
    jr nz, .loop
    ld a, c
    or a, a
    pop bc
    ret

; wBattleTargetChoice[2 * actor] = (hFFC6, or hFFC9 when hFFC6 is $FF) | hFFD0 (the two-choice form of SetActorTargetFromHRAMChoice) (E-0078)
; 5 call sites from 5 routines (e.g. TargetRandomFoeOfFamilyD, ChooseTarget_Ramming, ChooseTarget_MetalCut, TargetWeakestFoeOfFamilyD, ...)
; reads: wBattleActor, hTemp0, hTemp3, hTempA
; points at: wBattleTargetChoice
SetActorTargetFromTemp0OrTemp3::
Func_039_6FC8:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ldh a, [hTemp0]
    cp a, $FF
    jr nz, .check_temp_a
    ldh a, [hTemp3]

.check_temp_a:
    ld e, a
    ldh a, [hTempA]
    or a, e
    ld [hl], a
    ret

; HL = wBattleTargetChoice + 2 * wBattleActor; A = hFFC6, or hFFC9 when hFFC6 is $FF, or hFFC8 when both are $FF; stores A | hFFD0 at HL. What the bytes mean is not known (E-0060)
; 18 call sites from 18 routines (e.g. ChooseTarget_GigaSlash_6A25, ChooseTarget_LushLicks, ChooseTarget_UltraDown, ChooseTarget_OddDance, ...)
; reads: wBattleActor, hTemp0, hTemp3, hTemp2, hTempA
; points at: wBattleTargetChoice
SetActorTargetFromHRAMChoice::
Func_039_6FE2:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ldh a, [hTemp0]
    cp a, $FF
    jr nz, .check_temp_a
    ldh a, [hTemp3]
    cp a, $FF
    jr nz, .check_temp_a
    ldh a, [hTemp2]

.check_temp_a:
    ld e, a
    ldh a, [hTempA]
    or a, e
    ld [hl], a
    ret

; wBattleTargetChoice[2 * actor] = (the first of hFFC6, hFFCA, hFFC9 that is not $FF, else hFFC8) | hFFD0 (the four-choice form of SetActorTargetFromHRAMChoice) (E-0096)
; 5 call sites from 5 routines (e.g. ChooseTarget_PanicAll, ChooseTarget_MouthShut, ChooseTarget_LegSweep, ChooseTarget_SickLick, ...)
; reads: wBattleActor, hTemp0, hTemp4, hTemp3, hTemp2, hTempA
; points at: wBattleTargetChoice
SetActorTargetFromHRAMChoice4::
Func_039_7002:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ldh a, [hTemp0]
    cp a, $FF
    jr nz, .check_temp_a
    ldh a, [hTemp4]
    cp a, $FF
    jr nz, .check_temp_a
    ldh a, [hTemp3]
    cp a, $FF
    jr nz, .check_temp_a
    ldh a, [hTemp2]

.check_temp_a:
    ld e, a
    ldh a, [hTempA]
    or a, e
    ld [hl], a
    ret

; only called from ChooseTarget_Cover (E-0047)
; 1 call site from 1 routine (e.g. ChooseTarget_Cover)
; reads: wBattleActor, hTemp0, hTemp5, hTemp4, hTemp3, hTempA
; points at: wBattleTargetChoice
ChooseTarget_Cover_ReadBattleActorAndTemp0Etc::
Func_039_7028:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ldh a, [hTemp0]
    cp a, $FF
    jr nz, .check_temp_a
    ldh a, [hTemp5]
    cp a, $FF
    jr nz, .check_temp_a
    ldh a, [hTemp4]
    cp a, $FF
    jr nz, .check_temp_a
    ldh a, [hTemp3]

.check_temp_a:
    ld e, a
    ldh a, [hTempA]
    or a, e
    ld [hl], a
    ret

; hFFC6 = candidate count, hFFC7-hFFC9 = candidates in priority order: target = the first for one; with two the first when wC5E7 < $AB (171/256), else the second; with three the first when wC5E7 < $80, the second when < $D5, else the third (128, 85 and 43 of 256). Writes wBattleTargetChoice[2 * actor]; with no candidates it stores hFFC7 ($FF) (E-0061)
; 3 call sites from 3 routines (e.g. ChooseTarget_SquallHit_66C5, TargetAllyWithStatusBit20, TargetFoeWeightedBySlotOrder)
; reads: hTemp0, hTemp1, wBattleActor, wRandomLo, hTemp2
; points at: wBattleTargetChoice, hTemp1
PickWeightedTargetCandidate::
Func_039_704E:: ; address name
    ldh a, [hTemp0]
    cp a, $03
    jr z, .check_random_lo2
    cp a, $02
    jr z, .check_random_lo
    ldh a, [hTemp1]
    jr .read_battle_actor

.check_random_lo:
    ld a, [wRandomLo]
    cp a, $AB
    ldh a, [hTemp1]
    jr c, .read_battle_actor
    ldh a, [hTemp2]
    jr .read_battle_actor

.check_random_lo2:
    ld a, [wRandomLo]
    cp a, $80
    ld b, $00
    jr c, .skip
    cp a, $D5
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
    add a, a
    add_a_to_hl
    ld [hl], b
    ret

; D = family: among the actor's present opposite slots whose species family (LoadSpeciesFamily) is D, targets the one with the smallest HP + DEF; when none matches, the last present foe (hFFC9) is used (SetActorTargetFromTemp0OrTemp3). Used by the family-slaying moves' target routines (E-0096)
; 9 call sites from 9 routines (e.g. ChooseTarget_CleanCut, ChooseTarget_ZombieCut, ChooseTarget_DevilCut, ChooseTarget_Shears, ...)
; reads: wBattleActor, wSpeciesRecord, hTemp1, hTemp2, hTemp3
; writes: hTempA, hTemp0, hTemp1, hTemp2, hTemp3, wSpeciesIdLo, wSpeciesIdHi
; points at: wBattleMonsterId
TargetWeakestFoeOfFamilyD::
Func_039_7093:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $FF
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
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    push de
    push bc
    farcall LoadSpeciesFamily
    pop bc
    pop de
    ld a, [wSpeciesRecord]
    cp a, d
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

; D = family: picks among the actor's present opposite slots whose species family is D, using AdvanceRandom when more than one matches (the choice rule is not read to the end); falls back to the last present foe; used by ChooseTarget routines of family-slaying moves (CleanCut, ZombieCut, DevilCut, Shears, ...) (E-0096)
; 9 call sites from 9 routines (e.g. ChooseTarget_CleanCut_69E3, ChooseTarget_ZombieCut_69DD, ChooseTarget_DevilCut_69D7, ChooseTarget_Shears_69F5, ...)
; reads: wBattleActor, wSpeciesRecord, hTemp0, wRandomLo, hTemp3
; writes: hTempA, hTemp0, hTemp3, wSpeciesIdLo, wSpeciesIdHi
; points at: wBattleMonsterId
TargetRandomFoeOfFamilyD::
Func_039_70FD:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hTempA], a
    ld c, a
    ld b, $03
    ld a, $FF
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
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    push de
    farcall LoadSpeciesFamily
    pop de
    ld a, [wSpeciesRecord]
    cp a, d
    jr nz, .restore
    ldh a, [hTemp0]
    cp a, $FF
    jr z, .read_temp3
    call AdvanceRandom
    ld a, [wRandomLo]
    and a, $01
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

; only called from ChooseTarget_Blaze (E-0047)
; 1 call site from 1 routine (e.g. ChooseTarget_Blaze)
; reads: hTemp8, hTemp9
ChooseTarget_Blaze_Multiply8By16::
Func_039_7155:: ; address name
    push af
    ldh a, [hTemp8]
    ld l, a
    ldh a, [hTemp9]
    ld h, a
    pop af
    or a, a
    jr z, .skip
    cp a, $01
    jr z, .call_multiply8_by16
    cp a, $02
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

; only called from ChooseTarget_MegaMagic (E-0047)
; 1 call site from 1 routine (e.g. ChooseTarget_MegaMagic)
; reads: wBattleActor
; points at: wBattleLevel
ChooseTarget_MegaMagic_GetBattleMP_Bank39::
Func_039_7180:: ; address name
    push af
    ld a, [wBattleActor]
    call GetBattleMP_Bank39
    push hl
    ld a, [wBattleActor]
    ld hl, wBattleLevel
    add_a_to_hl
    ld a, [hl]
    pop hl
    add a, a
    add_a_to_hl
    ld a, $5A
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    pop af
    or a, a
    jr z, .skip
    cp a, $01
    jr z, .call_multiply8_by16
    cp a, $02
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

; A = [HL + 4 * A + 3 * C], the offset computed in 8 bits; clobbers HL (the same 11 bytes appear in 2 banks)
; 29 call sites from 27 routines (e.g. ChooseTarget_PanicAll, ChooseTarget_GigaSlash_6A25, ChooseTarget_MouthShut, ChooseTarget_LegSweep, ...)
ReadByteAtHLPlus4APlus3C_Bank39::
Func_039_71C9:: ; address name
    add a, a
    add a, c
    add a, a
    add a, c
    add_a_to_hl
    ld a, [hl]
    ret

; C = slot: NZ when its status byte 2 bit 3 is set; otherwise A = status byte 5 & $C0 (Z when clear) (E-0118)
; 5 call sites from 2 routines (e.g. ChooseTarget_SquallHit_543C, ChooseTarget_GigaSlash)
; points at: wBattleStatus2
TestSlotStatus2Bit3OrStatus5Bits67::
Func_039_71D4:: ; address name
    ld a, c
    ld hl, wBattleStatus2
    call AddAx9ToHL
    bit 3, [hl]
    ret nz
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    and a, $C0
    ret

; A = battle slot: HL = the word for that slot at wBattleATK; A = its low byte (the bank-$39 copy of GetBattleATK) (E-0060)
; 2 call sites from 2 routines (e.g. ComputeDamageEstimateForAction, ChooseTarget_TwinHits)
; points at: wBattleATK
GetBattleATK_Bank39::
Func_039_71E5:: ; address name
    ld hl, wBattleATK
    jr ReadSlotAIModeIndexed_Bank39_Skip

; A = battle slot: HL = the word for that slot at wBattleDEF; A = its low byte (E-0060)
; 18 call sites from 18 routines (e.g. ChooseTarget_GigaSlash_6A25, ChooseTarget_SquallHit_66C5, StoreSlotHPPlusDEFToTargetEstimates, ChooseTarget_SickLick, ...)
; points at: wBattleDEF
GetBattleDEF_Bank39::
Func_039_71EA:: ; address name
    ld hl, wBattleDEF
    jr ReadSlotAIModeIndexed_Bank39_Skip

; A = battle slot: HL = the word for that slot at wBattleMaxHP; A = its low byte (E-0060)
; 7 call sites from 7 routines (e.g. ChooseTarget_Heal_68B0, ChooseTarget_Heal_5593, ChooseTarget_Heal, ChooseTarget_Heal_67AD, ...)
; points at: wBattleMaxHP
GetBattleMaxHP_Bank39::
Func_039_71EF:: ; address name
    ld hl, wBattleMaxHP
    jr ReadSlotAIModeIndexed_Bank39_Skip

; A = battle slot: HL = the word for that slot at wBattleMaxMP; A = its low byte (E-0060)
; 2 call sites from 2 routines (e.g. ChooseTarget_Transform, ChooseTarget_MPass)
; points at: wBattleMaxMP
GetBattleMaxMP_Bank39::
Func_039_71F4:: ; address name
    ld hl, wBattleMaxMP
    jr ReadSlotAIModeIndexed_Bank39_Skip

; A = battle slot: HL = the word for that slot at wBattleHP; A = its low byte (E-0060)
; 28 call sites from 24 routines (e.g. ChooseTarget_GigaSlash_6A25, ChooseTarget_Heal_68B0, ChooseTarget_SquallHit_66C5, ChooseTarget_Heal_5593, ...)
; points at: wBattleHP
GetBattleHP_Bank39::
Func_039_71F9:: ; address name
    ld hl, wBattleHP
    jr ReadSlotAIModeIndexed_Bank39_Skip

; A = battle slot: HL = the word for that slot at wBattleMP; A = its low byte (E-0060)
; 4 call sites from 4 routines (e.g. ChooseTarget_OddDance, ChooseTarget_MegaMagic_GetBattleMP_Bank39, ChooseTarget_RobMagic, ChooseTarget_MPass)
; points at: wBattleMP
GetBattleMP_Bank39::
Func_039_71FE:: ; address name
    ld hl, wBattleMP
    jr ReadSlotAIModeIndexed_Bank39_Skip

; A = battle slot: HL = the word for that slot at wBattleAGL; A = its low byte (E-0060)
; 4 call sites from 4 routines (e.g. ChooseTarget_UltraDown, ChooseTarget_Slow, ChooseTarget_Speed, ChooseTarget_Speed_6B5D)
; points at: wBattleAGL
GetBattleAGL_Bank39::
Func_039_7203:: ; address name
    ld hl, wBattleAGL
    jr ReadSlotAIModeIndexed_Bank39_Skip

; A = the byte at wDA53 + A; clobbers HL (the same 10 bytes appear in 5 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wSlotAIMode
ReadSlotAIModeIndexed_Bank39:: ; heuristic: follows a terminator; C0
Func_039_7208:: ; address name
    ld hl, wSlotAIMode
    add_a_to_hl
    ld a, [hl]
    ret

ReadSlotAIModeIndexed_Bank39_Skip::
Jump_039_7212:: ; address name
    add a, a
    add_a_to_hl
    deref_hl
    ret

; HL += 2 * A (A is doubled in 8 bits first, so it wraps above $7F); clobbers A (the same 7 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
AddDoubleAToHL_Bank39:: ; heuristic: follows a terminator; C0
Func_039_721C:: ; address name
    add a, a
    add_a_to_hl
    ret

; carry set when wBattleActor < 4 (slots 0-3); when wC58A = 1 and wC57F bit 1 is set the test is reversed (carry set when wBattleActor >= 4). Which side is local is inferred from the reversal, not checked (E-0064) (the same 27 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkRole, wBattleActor
ActorOnLocalSide_Bank39:: ; heuristic: follows a terminator; C0
Func_039_7223:: ; address name
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
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkRole, wBattleTarget
TargetOnLocalSide_Bank39:: ; heuristic: follows a terminator; C0
Func_039_723E:: ; address name
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
ClearBattleStatusBitsWithMaskD_Bank39:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:4075; C0
Func_039_7259:: ; address name
    ld a, d
    ld hl, ClearBattleStatusBitsWithMaskD_Bank39_Data
    add_a_to_hl
    ld d, [hl]
    ld a, e
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, d
    and a, [hl]
    ld [hl], a
    ret

; address loaded by ClearBattleStatusBitsWithMaskD_Bank39
ClearBattleStatusBitsWithMaskD_Bank39_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_039_726E:: ; address name
    db $DF, $FE, $00, $FD, $73, $EF, $BF

; Sets bit 0 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wLevelUpGains
SetBit0OfLevelUpGainsIndexed_Bank39:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:4091; C0
Func_039_7275:: ; address name
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 0, [hl]
    pop hl
    ret

; Sets bit 1 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wLevelUpGains
SetBit1OfLevelUpGainsIndexed_Bank39:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:409E; C0
Func_039_7282:: ; address name
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 1, [hl]
    pop hl
    ret

; Sets bit 2 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wLevelUpGains
SetBit2OfLevelUpGainsIndexed_Bank39:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:40AB; C0
Func_039_728F:: ; address name
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 2, [hl]
    pop hl
    ret

; A = slot 0-7: returns A = 9 * g(wD968[A]) + 3 * g(wD970[A]) + g(wD978[A]) with g(v) = 0 for v >= $C0, 1 for v >= $40, else 2 (the same index PersonalityIndexOfRecord builds from a save record; E-0031); HL and BC are kept (the same 87 bytes appear in 13 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wSlotPersonalityHi, wSlotPersonalityMid, wSlotPersonalityLo
PersonalityIndexOfSlot_Bank39:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:40B8; C0
Func_039_729C:: ; address name
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
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleStatus3
CheckSlotStatusBlockWide_Bank39:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:410F; C0
Func_039_72F3:: ; address name
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
SlotHasStatus3Or4Bits_Bank39:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:412E; C0
Func_039_7312:: ; address name
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
    ds $CDD, $00
