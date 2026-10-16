; ROM bank $87: map interactions and steps
; The annotated listing of this bank is build/listing/bank87.asm.

SECTION "Bank 87", ROMX
    db $87

; Step triggers on maps, called each frame by FieldState_WalkATalks: returns while a text window is
; open (wTextWindowState & 3), a field action is pending (wFieldActionRequest bit 7), the player is
; frozen (hPlayerStateFlags bit 0) or wStepTriggerFlag is already set; otherwise sets
; wStepTriggerFlag and walks the map's list from MapStepTriggerTable (word hMapId; $0000 = none) in
; 10-byte entries until $FF. The first entry with byte 0 = 0 for this map (hMapId) and screen
; (hMapScreenX/Y), at the player's position (hPlayerX/Y; X $FF means anywhere) and whose story flag
; word is $FFFF or clear starts talk event wTalkEventGroup / wTalkEventIndex (DispatchTalkEvent),
; then clears wJoypadHeld and wJoypadPressed when wModeState is 1. (C1, E-0371)
FieldState_WalkATalks_RunStepTriggers::
    ld a, [wTextWindowState]
    and $03
    ret nz
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    ldh a, [hPlayerStateFlags]
    bit 0, a
    ret nz
    ld a, [wStepTriggerFlag]
    or a
    ret nz
    inc a
    ld [wStepTriggerFlag], a
    ldh a, [hMapId]
    ld l, a
    ld h, $00
    add hl, hl
    ld a, l
    add LOW(MapStepTriggerTable)
    ld l, a
    ld a, h
    adc HIGH(MapStepTriggerTable)
    ld h, a
    ld a, [hli]
    ld e, a
    ld a, [hl]
    or e
    ret z
    ld a, [hl]
    ld h, a
    ld l, e

.skip:
    ld a, [hl]
    cp $ff
    ret z
    push hl
    or a
    jr nz, .restore
    inc hl
    ld a, [hli]
    ld c, a
    ldh a, [hMapId]
    cp c
    jr nz, .restore
    ld a, [hli]
    ld c, a
    ldh a, [hMapScreenX]
    cp c
    jr nz, .restore
    ld a, [hli]
    ld c, a
    ldh a, [hMapScreenY]
    cp c
    jr nz, .restore
    ld a, [hli]
    cp $ff
    jr nz, .check_player_x
    inc hl
    jr .skip2

.check_player_x:
    ld c, a
    ldh a, [hPlayerX]
    cp c
    jr nz, .restore
    ld a, [hli]
    ld c, a
    ldh a, [hPlayerY]
    cp c
    jr nz, .restore

.skip2:
    ld a, [hli]
    ld e, a
    ld a, [hl]
    cp e
    jr nz, .call_test_flag_bit
    cp $ff
    jr nz, .call_test_flag_bit
    inc hl
    jr .set_talk_event_group

.call_test_flag_bit:
    ld a, [hli]
    ld d, a
    call TestFlagBit
    jr c, .restore

.set_talk_event_group:
    ld a, [hli]
    ld [wTalkEventGroup], a
    ld a, [hl]
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    ld a, [wModeState]
    cp $01
    jr nz, .done
    xor a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a

.done:
    pop hl
    ret

.restore:
    pop hl
    ld a, $0a
    add_a_to_hl
    jr .skip

SECTION "Bank 87 MapStepTriggerTable", ROMX

; FieldState_StepChecks (CheckStepTriggerAndDispatchTalk), once per step (wStepTriggerFlag), reads
; the word at $40A0 + 2 * hMapId and walks 10-byte entries until $FF: an entry with byte 0 = 0 whose
; map, screen and position (unless player X is $FF) match and whose flag is $FFFF or clear sets
; wTalkEventGroup/Index and far-calls DispatchTalkEvent; 256 words end at the code at $42A0 (E-0198,
; C1)
; record: list of step triggers for this map ($0000 = none)
MapStepTriggerTable::
    dw MapStepTriggers00 ; id 0
    dw MapStepTriggers01 ; id 1
    dw MapStepTriggers02 ; id 2
    dw $0000 ; id 3
    dw MapStepTriggers04 ; id 4
    dw MapStepTriggers05 ; id 5
    dw $0000 ; id 6
    dw $0000 ; id 7
    dw $0000 ; id 8
    dw $0000 ; id 9
    dw $0000 ; id 10
    dw $0000 ; id 11
    dw MapStepTriggers0C ; id 12
    dw $0000 ; id 13
    dw $0000 ; id 14
    dw $0000 ; id 15
    dw $0000 ; id 16
    dw $0000 ; id 17
    dw $0000 ; id 18
    dw $0000 ; id 19
    dw $0000 ; id 20
    dw $0000 ; id 21
    dw $0000 ; id 22
    dw $0000 ; id 23
    dw $0000 ; id 24
    dw MapStepTriggers19 ; id 25
    dw MapStepTriggers1A ; id 26
    dw $0000 ; id 27
    dw $0000 ; id 28
    dw $0000 ; id 29
    dw $0000 ; id 30
    dw $0000 ; id 31
    dw MapStepTriggers20 ; id 32
    dw $0000 ; id 33
    dw $0000 ; id 34
    dw $0000 ; id 35
    dw $0000 ; id 36
    dw $0000 ; id 37
    dw $0000 ; id 38
    dw $0000 ; id 39
    dw $0000 ; id 40
    dw $0000 ; id 41
    dw MapStepTriggers2A ; id 42
    dw $0000 ; id 43
    dw $0000 ; id 44
    dw $0000 ; id 45
    dw $0000 ; id 46
    dw MapStepTriggers2F ; id 47
    dw $0000 ; id 48
    dw $0000 ; id 49
    dw $0000 ; id 50
    dw MapStepTriggers33 ; id 51
    dw $0000 ; id 52
    dw $0000 ; id 53
    dw $0000 ; id 54
    dw $0000 ; id 55
    dw MapStepTriggers38 ; id 56
    dw MapStepTriggers39 ; id 57
    dw MapStepTriggers3A ; id 58
    dw MapStepTriggers3B ; id 59
    dw $0000 ; id 60
    dw $0000 ; id 61
    dw $0000 ; id 62
    dw $0000 ; id 63
    dw $0000 ; id 64
    dw $0000 ; id 65
    dw $0000 ; id 66
    dw $0000 ; id 67
    dw $0000 ; id 68
    dw $0000 ; id 69
    dw $0000 ; id 70
    dw $0000 ; id 71
    dw $0000 ; id 72
    dw $0000 ; id 73
    dw $0000 ; id 74
    dw $0000 ; id 75
    dw MapStepTriggers4C ; id 76
    dw $0000 ; id 77
    dw $0000 ; id 78
    dw $0000 ; id 79
    dw $0000 ; id 80
    dw $0000 ; id 81
    dw $0000 ; id 82
    dw $0000 ; id 83
    dw $0000 ; id 84
    dw $0000 ; id 85
    dw $0000 ; id 86
    dw $0000 ; id 87
    dw $0000 ; id 88
    dw $0000 ; id 89
    dw $0000 ; id 90
    dw MapStepTriggers5B ; id 91
    dw $0000 ; id 92
    dw MapStepTriggers5D ; id 93
    dw $0000 ; id 94
    dw $0000 ; id 95
    dw $0000 ; id 96
    dw $0000 ; id 97
    dw $0000 ; id 98
    dw $0000 ; id 99
    dw $0000 ; id 100
    dw $0000 ; id 101
    dw $0000 ; id 102
    dw MapStepTriggers67 ; id 103
    dw $0000 ; id 104
    dw $0000 ; id 105
    dw $0000 ; id 106
    dw $0000 ; id 107
    dw $0000 ; id 108
    dw $0000 ; id 109
    dw $0000 ; id 110
    dw $0000 ; id 111
    dw $0000 ; id 112
    dw $0000 ; id 113
    dw $0000 ; id 114
    dw $0000 ; id 115
    dw $0000 ; id 116
    dw $0000 ; id 117
    dw MapStepTriggers76 ; id 118
    dw $0000 ; id 119
    dw $0000 ; id 120
    dw $0000 ; id 121
    dw MapStepTriggers7A ; id 122
    dw $0000 ; id 123
    dw $0000 ; id 124
    dw $0000 ; id 125
    dw $0000 ; id 126
    dw MapStepTriggers7F ; id 127
    dw $0000 ; id 128
    dw $0000 ; id 129
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
    dw MapStepTriggers8D ; id 141
    dw $0000 ; id 142
    dw $0000 ; id 143
    dw $0000 ; id 144
    dw $0000 ; id 145
    dw MapStepTriggers92 ; id 146
    dw $0000 ; id 147
    dw $0000 ; id 148
    dw $0000 ; id 149
    dw $0000 ; id 150
    dw $0000 ; id 151
    dw $0000 ; id 152
    dw $0000 ; id 153
    dw $0000 ; id 154
    dw MapStepTriggers9B ; id 155
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
    dw MapStepTriggersAA ; id 170
    dw $0000 ; id 171
    dw MapStepTriggersAC ; id 172
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

; Field routine run when A is pressed (FieldState_WalkATalks and FieldState_WalkAMenu far-call it).
; It returns at once when (wTextWindowState AND 3) is not 0, wFieldActionRequest bit 7 or
; hPlayerStateFlags bit 0 is set, or A is not newly pressed (wJoypadPressed bit 0 clear). First,
; when wSpriteSlotCount is not 0, it moves the player point (hPlayerX, hPlayerY) one step in the
; direction of hPlayerFacing (down and right by $11, up and left by 1) and asks
; CheckMapInteractionOnA_SpriteSlots which object stands on that 16-pixel tile. That object is not
; talked to when its type (byte 0) is 2 and bit 7 of its byte $0A is set (a wandering object in the
; middle of a move), or when its type is not 0 and its OBJ_X or OBJ_Y has a nonzero low nibble (off
; the tile grid); the scan of map spots below then runs instead. Otherwise its OBJ_ANIM_COUNTER is
; cleared, it turns to face the player (OBJ_STATE = (hPlayerFacing + 2) AND 3), and its byte $0F
; picks the talk event: $FF gives wTalkEventIndex 8 and leaves the group alone; $FE, $FC, $FB and
; $FA give index 9 with group 0, 2, 3 and 8; any other value is the group, with the index chosen by
; hMapId (below $20 1, $30 2, $48 3, $70 4, $A0 5, $A8 6, otherwise 7). DispatchTalkEvent runs it.
; With no object, the routine reads a list of 10-byte map spots: the list from
; CheckMapInteractionOnA_KeyWorldFloor when wMapType bit 7 is set (no list, no talk, when it returns
; 0), otherwise the pointer for hMapId in MapInteractionTable ($0000 = none). A spot with kind byte
; 0 is skipped; kinds 1-4 need hPlayerFacing = kind - 1 and the same screen (hMapScreenX,
; hMapScreenY, and hMapId when wMapType bit 7 is clear) and player position; kind 5 matches the tile
; in front of the player whatever the facing; the list ends with $FF. A spot is skipped when its
; story flag word is not $FFFF and the flag is set; otherwise its group and index go to
; wTalkEventGroup and wTalkEventIndex and DispatchTalkEvent runs. After a talk, if wModeState is 1
; the routine clears wJoypadHeld and wJoypadPressed and calls
; RedrawScreenBufferIfPartyWindowFlagsBit7 when wPartyWindowFlags bit 7 is set; when a map spot
; leaves wModeState at another value the scan goes on with the next spot. (C1, E-0385)
; A in the field when nothing blocks input: walks this map's list in MapInteractionTable and runs
; the talk event of the first spot that matches (E-0157, E-0339; was CheckMapInteractionOnA)
CheckMapInteractionOnA::
    ld a, [wTextWindowState]
    and $03
    ret nz
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    ldh a, [hPlayerStateFlags]
    bit 0, a
    ret nz
    ld a, [wJoypadPressed]
    bit 0, a
    ret z
    ld a, [wSpriteSlotCount]
    or a
    jp z, .check_map_type
    ldh a, [hPlayerX]
    ld b, a
    ldh a, [hPlayerY]
    ld c, a
    ldh a, [hPlayerFacing]
    or a
    jr z, .skip
    dec a
    jr z, .skip2
    dec a
    jr z, .call_check_map_interaction_on_a_sprite_slots
    dec b
    jr .call_check_map_interaction_on_a_sprite_slots2

.skip:
    ld a, c
    add $11
    ld c, a
    jr .call_check_map_interaction_on_a_sprite_slots2

.skip2:
    ld a, b
    add $11
    ld b, a
    jr .call_check_map_interaction_on_a_sprite_slots2

.call_check_map_interaction_on_a_sprite_slots:
    dec c

.call_check_map_interaction_on_a_sprite_slots2:
    call CheckMapInteractionOnA_SpriteSlots
    or a
    jp z, .check_map_type
    dec a
    ld c, $10
    call Multiply8
    ld a, l
    add $7f
    ld l, a
    ld a, h
    adc $cb
    ld h, a
    ld a, [hl]
    or a
    jr z, .skip3
    push hl
    ld a, [hl]
    cp $02
    jr nz, .restore
    ld a, $0a
    add_a_to_hl
    ld a, [hl]
    bit 7, a
    jr z, .restore
    pop hl
    jp .check_map_type

.restore:
    pop hl
    push hl
    ld a, $0b
    add_a_to_hl
    ld a, [hl]
    and $0f
    jr z, .next
    pop hl
    jp .check_map_type

.next:
    inc hl
    ld a, [hl]
    and $0f
    jr z, .restore2
    pop hl
    jp .check_map_type

.restore2:
    pop hl

.skip3:
    ld a, $09
    add_a_to_hl
    xor a
    ld [hl], a
    dec hl
    dec hl
    ldh a, [hPlayerFacing]
    add $02
    and $03
    ld [hl], a
    ld a, $08
    add_a_to_hl
    ld a, [hl]
    cp $ff
    jr nz, .cp_FE
    ld a, $08
    ld [wTalkEventIndex], a
    jp .call_dispatch_talk_event

.cp_FE:
    cp $fe
    jr nz, .cp_FC
    ld a, $09
    ld [wTalkEventIndex], a
    xor a
    ld [wTalkEventGroup], a
    jr .call_dispatch_talk_event

.cp_FC:
    cp $fc
    jr nz, .cp_FB
    ld a, $09
    ld [wTalkEventIndex], a
    ld a, $02
    ld [wTalkEventGroup], a
    jr .call_dispatch_talk_event

.cp_FB:
    cp $fb
    jr nz, .cp_FA
    ld a, $09
    ld [wTalkEventIndex], a
    ld a, $03
    ld [wTalkEventGroup], a
    jr .call_dispatch_talk_event

.cp_FA:
    cp $fa
    jr nz, .set_talk_event_group
    ld a, $09
    ld [wTalkEventIndex], a
    ld a, $08
    ld [wTalkEventGroup], a
    jr .call_dispatch_talk_event

.set_talk_event_group:
    ld [wTalkEventGroup], a
    ldh a, [hMapId]
    cp $20
    jr nc, .cp_30
    ld a, $01
    ld [wTalkEventIndex], a
    jr .call_dispatch_talk_event

.cp_30:
    cp $30
    jr nc, .cp_48
    ld a, $02
    ld [wTalkEventIndex], a
    jr .call_dispatch_talk_event

.cp_48:
    cp $48
    jr nc, .cp_70
    ld a, $03
    ld [wTalkEventIndex], a
    jr .call_dispatch_talk_event

.cp_70:
    cp $70
    jr nc, .cp_A0
    ld a, $04
    ld [wTalkEventIndex], a
    jr .call_dispatch_talk_event

.cp_A0:
    cp $a0
    jr nc, .cp_A8
    ld a, $05
    ld [wTalkEventIndex], a
    jr .call_dispatch_talk_event

.cp_A8:
    cp $a8
    jr nc, .set_talk_event_index_to_07
    ld a, $06
    ld [wTalkEventIndex], a
    jr .call_dispatch_talk_event

.set_talk_event_index_to_07:
    ld a, $07
    ld [wTalkEventIndex], a

.call_dispatch_talk_event:
    farcall DispatchTalkEvent
    ld a, [wModeState]
    cp $01
    ret nz
    xor a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ld a, [wPartyWindowFlags]
    bit 7, a
    ret z
    farcall RedrawScreenBufferIfPartyWindowFlagsBit7
    ret

.check_map_type:
    ld a, [wMapType]
    bit 7, a
    jr z, .read_map_id
    call CheckMapInteractionOnA_KeyWorldFloor
    or a
    jr nz, .skip4
    ret

.read_map_id:
    ldh a, [hMapId]
    ld l, a
    ld h, $00
    add hl, hl
    ld a, l
    add LOW(MapInteractionTable)
    ld l, a
    ld a, h
    adc HIGH(MapInteractionTable)
    ld h, a
    ld a, [hli]
    ld e, a
    ld a, [hl]
    or e
    ret z
    ld a, [hl]
    ld h, a
    ld l, e

.skip4:
    ld a, [hl]
    cp $ff
    ret z
    push hl
    or a
    jp z, .restore3
    cp $05
    jr nz, .check_player_facing
    inc hl
    ld a, [wMapType]
    bit 7, a
    jr nz, .next2
    ld a, [hl]
    ld c, a
    ldh a, [hMapId]
    cp c
    jp nz, .restore3

.next2:
    inc hl
    ld a, [hli]
    ld c, a
    ldh a, [hMapScreenX]
    cp c
    jp nz, .restore3
    ld a, [hli]
    ld c, a
    ldh a, [hMapScreenY]
    cp c
    jp nz, .restore3
    ld a, [hli]
    ld c, a
    ldh a, [hPlayerFacing]
    dec a
    jp nz, .skip5
    ld a, c
    sub $10
    ld c, a
    jp .check_player_x

.skip5:
    dec a
    dec a
    jp nz, .check_player_x
    ld a, c
    add $10
    ld c, a

.check_player_x:
    ldh a, [hPlayerX]
    cp c
    jp nz, .restore3
    ld a, [hli]
    ld c, a
    ldh a, [hPlayerFacing]
    or a
    jr nz, .skip6
    ld a, c
    sub $10
    ld c, a
    jr .check_player_y

.skip6:
    dec a
    dec a
    jr nz, .check_player_y
    ld a, c
    add $10
    ld c, a

.check_player_y:
    ldh a, [hPlayerY]
    cp c
    jp nz, .restore3
    jr .skip7

.check_player_facing:
    dec a
    ld c, a
    ldh a, [hPlayerFacing]
    cp c
    jr nz, .restore3
    inc hl
    ld a, [wMapType]
    bit 7, a
    jr nz, .next3
    ld a, [hl]
    ld c, a
    ldh a, [hMapId]
    cp c
    jr nz, .restore3

.next3:
    inc hl
    ld a, [hli]
    ld c, a
    ldh a, [hMapScreenX]
    cp c
    jp nz, .restore3
    ld a, [hli]
    ld c, a
    ldh a, [hMapScreenY]
    cp c
    jr nz, .restore3
    ld a, [hli]
    ld c, a
    ldh a, [hPlayerX]
    cp c
    jr nz, .restore3
    ld a, [hli]
    ld c, a
    ldh a, [hPlayerY]
    cp c
    jr nz, .restore3

.skip7:
    ld a, [hli]
    ld e, a
    ld a, [hl]
    cp e
    jr nz, .call_test_flag_bit
    cp $ff
    jr nz, .call_test_flag_bit
    inc hl
    jr .set_talk_event_group2

.call_test_flag_bit:
    ld a, [hli]
    ld d, a
    call TestFlagBit
    jr c, .restore3

.set_talk_event_group2:
    ld a, [hli]
    ld [wTalkEventGroup], a
    ld a, [hl]
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    ld a, [wModeState]
    cp $01
    jr nz, .restore3
    xor a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ld a, [wPartyWindowFlags]
    bit 7, a
    jr z, .done
    farcall RedrawScreenBufferIfPartyWindowFlagsBit7

.done:
    pop hl
    ret

.restore3:
    pop hl
    ld a, $0a
    add_a_to_hl
    jp .skip4

; A = wMapType: for $84 returns HL = MapType84Interactions and A = 1; for $83 it reads the kind byte
; of the current floor (wKeyWorldFloorInfo + 4 * wKeyWorldFloor + 1) and returns HL =
; KeyWorldFloorKind2Interactions for kind 2 or KeyWorldFloorKind3Interactions for kind 3, with A =
; 1. For any other wMapType, or another kind byte, it returns A = 0. Its only caller is
; CheckMapInteractionOnA. (C2, E-0385)
; part of CheckMapInteractionOnA that reads the key-world floor (E-0339; was
; CheckMapInteractionOnA_KeyWorldFloor)
CheckMapInteractionOnA_KeyWorldFloor::
    cp $84
    jr nz, .cp_83
    ld hl, MapType84Interactions
    ld a, $01
    ret

.cp_83:
    cp $83
    jr nz, .return_0
    ld a, [wKeyWorldFloor]
    add a
    add a
    ld hl, wKeyWorldFloorInfo + $1
    add_a_to_hl
    ld a, [hl]
    cp $02
    jr nz, .cp_03
    ld hl, KeyWorldFloorKind2Interactions
    ld a, $01
    ret

.cp_03:
    cp $03
    jr nz, .return_0
    ld hl, KeyWorldFloorKind3Interactions
    ld a, $01
    ret

.return_0:
    xor a
    ret

SECTION "Bank 87 MapInteractionTable", ROMX

; CheckMapInteractionOnA reads the word $4539 + 2 * hMapId when A is pressed (232 words, up to
; CheckMapInteractionOnA_SpriteSlots at $4709); its list of 10-byte entries ends with $FF; an entry
; matches on kind (0 skips; 1-4 need hPlayerFacing = kind - 1; 5 matches the tile in front), map,
; screen and player position; unless its story flag is set it runs DispatchTalkEvent with the group
; and index (E-0157, C1)
; record: list of interaction spots for this map ($0000 = none)
MapInteractionTable::
    dw MapInteractions00 ; id 0
    dw MapInteractions01 ; id 1
    dw MapInteractions02 ; id 2
    dw $0000 ; id 3
    dw MapInteractions04 ; id 4
    dw MapInteractions05 ; id 5
    dw MapInteractions06 ; id 6
    dw MapInteractions07 ; id 7
    dw MapInteractions08 ; id 8
    dw MapInteractions09 ; id 9
    dw $0000 ; id 10
    dw $0000 ; id 11
    dw MapInteractions0C ; id 12
    dw MapInteractions0D ; id 13
    dw MapInteractions0E ; id 14
    dw MapInteractions0F ; id 15
    dw MapInteractions10 ; id 16
    dw MapInteractions11 ; id 17
    dw MapInteractions12 ; id 18
    dw MapInteractions13 ; id 19
    dw $0000 ; id 20
    dw MapInteractions15 ; id 21
    dw MapInteractions16 ; id 22
    dw MapInteractions17 ; id 23
    dw MapInteractions18 ; id 24
    dw MapInteractions19 ; id 25
    dw MapInteractions1A ; id 26
    dw MapInteractions1B ; id 27
    dw $0000 ; id 28
    dw MapInteractions1D ; id 29
    dw $0000 ; id 30
    dw $0000 ; id 31
    dw $0000 ; id 32
    dw MapInteractions21 ; id 33
    dw MapInteractions22 ; id 34
    dw MapInteractions23 ; id 35
    dw MapInteractions24 ; id 36
    dw MapInteractions25 ; id 37
    dw $0000 ; id 38
    dw $0000 ; id 39
    dw MapInteractions28 ; id 40
    dw $0000 ; id 41
    dw MapInteractions2A ; id 42
    dw MapInteractions2B ; id 43
    dw $0000 ; id 44
    dw MapInteractions2D ; id 45
    dw MapInteractions2E ; id 46
    dw $0000 ; id 47
    dw $0000 ; id 48
    dw MapInteractions31 ; id 49
    dw MapInteractions32 ; id 50
    dw MapInteractions33 ; id 51
    dw MapInteractions34 ; id 52
    dw MapInteractions35 ; id 53
    dw $0000 ; id 54
    dw MapInteractions37 ; id 55
    dw $0000 ; id 56
    dw MapInteractions39 ; id 57
    dw MapInteractions3A ; id 58
    dw MapInteractions3B ; id 59
    dw MapInteractions3C ; id 60
    dw MapInteractions3D ; id 61
    dw MapInteractions3E ; id 62
    dw $0000 ; id 63
    dw MapInteractions40 ; id 64
    dw $0000 ; id 65
    dw MapInteractions42 ; id 66
    dw MapInteractions43 ; id 67
    dw MapInteractions44 ; id 68
    dw $0000 ; id 69
    dw $0000 ; id 70
    dw $0000 ; id 71
    dw $0000 ; id 72
    dw $0000 ; id 73
    dw MapInteractions4A ; id 74
    dw MapInteractions4B ; id 75
    dw MapInteractions4C ; id 76
    dw MapInteractions4D ; id 77
    dw $0000 ; id 78
    dw MapInteractions4F ; id 79
    dw MapInteractions50 ; id 80
    dw MapInteractions51 ; id 81
    dw $0000 ; id 82
    dw $0000 ; id 83
    dw $0000 ; id 84
    dw MapInteractions55 ; id 85
    dw $0000 ; id 86
    dw MapInteractions57 ; id 87
    dw MapInteractions58 ; id 88
    dw MapInteractions59 ; id 89
    dw MapInteractions5A ; id 90
    dw MapInteractions5B ; id 91
    dw $0000 ; id 92
    dw $0000 ; id 93
    dw MapInteractions5E ; id 94
    dw MapInteractions5F ; id 95
    dw MapInteractions60 ; id 96
    dw $0000 ; id 97
    dw MapInteractions62 ; id 98
    dw MapInteractions63 ; id 99
    dw MapInteractions64 ; id 100
    dw $0000 ; id 101
    dw MapInteractions66 ; id 102
    dw MapInteractions67 ; id 103
    dw $0000 ; id 104
    dw $0000 ; id 105
    dw $0000 ; id 106
    dw $0000 ; id 107
    dw $0000 ; id 108
    dw $0000 ; id 109
    dw $0000 ; id 110
    dw $0000 ; id 111
    dw $0000 ; id 112
    dw MapInteractions71 ; id 113
    dw MapInteractions72 ; id 114
    dw MapInteractions73 ; id 115
    dw $0000 ; id 116
    dw $0000 ; id 117
    dw MapInteractions76 ; id 118
    dw $0000 ; id 119
    dw MapInteractions78 ; id 120
    dw MapInteractions79 ; id 121
    dw MapInteractions7A ; id 122
    dw $0000 ; id 123
    dw MapInteractions7C ; id 124
    dw MapInteractions7D ; id 125
    dw MapInteractions7E ; id 126
    dw MapInteractions7F ; id 127
    dw $0000 ; id 128
    dw MapInteractions81 ; id 129
    dw MapInteractions82 ; id 130
    dw $0000 ; id 131
    dw MapInteractions84 ; id 132
    dw MapInteractions85 ; id 133
    dw $0000 ; id 134
    dw $0000 ; id 135
    dw $0000 ; id 136
    dw MapInteractions89 ; id 137
    dw $0000 ; id 138
    dw $0000 ; id 139
    dw $0000 ; id 140
    dw MapInteractions8D ; id 141
    dw MapInteractions8E ; id 142
    dw MapInteractions8F ; id 143
    dw $0000 ; id 144
    dw MapInteractions91 ; id 145
    dw $0000 ; id 146
    dw $0000 ; id 147
    dw MapInteractions94 ; id 148
    dw $0000 ; id 149
    dw MapInteractions96 ; id 150
    dw $0000 ; id 151
    dw MapInteractions98 ; id 152
    dw $0000 ; id 153
    dw MapInteractions9A ; id 154
    dw MapInteractions9B ; id 155
    dw $0000 ; id 156
    dw $0000 ; id 157
    dw $0000 ; id 158
    dw $0000 ; id 159
    dw $0000 ; id 160
    dw $0000 ; id 161
    dw $0000 ; id 162
    dw MapInteractionsA3 ; id 163
    dw $0000 ; id 164
    dw $0000 ; id 165
    dw $0000 ; id 166
    dw $0000 ; id 167
    dw $0000 ; id 168
    dw MapInteractionsA9 ; id 169
    dw $0000 ; id 170
    dw MapInteractionsAB ; id 171
    dw $0000 ; id 172
    dw MapInteractionsAD ; id 173
    dw MapInteractionsAE ; id 174
    dw $0000 ; id 175
    dw $0000 ; id 176
    dw MapInteractionsB1 ; id 177
    dw $0000 ; id 178
    dw $0000 ; id 179
    dw $0000 ; id 180
    dw $0000 ; id 181
    dw MapInteractionsB6 ; id 182
    dw $0000 ; id 183
    dw $0000 ; id 184
    dw MapInteractionsB9 ; id 185
    dw MapInteractionsBA ; id 186
    dw MapInteractionsBB ; id 187
    dw MapInteractionsBC ; id 188
    dw $0000 ; id 189
    dw MapInteractionsBE ; id 190
    dw MapInteractionsBF ; id 191
    dw MapInteractionsC0 ; id 192
    dw $0000 ; id 193
    dw MapInteractionsC2 ; id 194
    dw $0000 ; id 195
    dw MapInteractionsC4 ; id 196
    dw $0000 ; id 197
    dw $0000 ; id 198
    dw $0000 ; id 199
    dw $0000 ; id 200
    dw $0000 ; id 201
    dw MapInteractionsCA ; id 202
    dw MapInteractionsCB ; id 203
    dw MapInteractionsCC ; id 204
    dw MapInteractionsCD ; id 205
    dw MapInteractionsCE ; id 206
    dw $0000 ; id 207
    dw $0000 ; id 208
    dw $0000 ; id 209
    dw $0000 ; id 210
    dw MapInteractionsD3 ; id 211
    dw MapInteractionsD4 ; id 212
    dw MapInteractionsD5 ; id 213
    dw MapInteractionsD6 ; id 214
    dw MapInteractionsD7 ; id 215
    dw $0000 ; id 216
    dw $0000 ; id 217
    dw $0000 ; id 218
    dw $0000 ; id 219
    dw MapInteractionsDC ; id 220
    dw MapInteractionsDD ; id 221
    dw MapInteractionsDE ; id 222
    dw MapInteractionsDF ; id 223
    dw MapInteractionsE0 ; id 224
    dw $0000 ; id 225
    dw $0000 ; id 226
    dw $0000 ; id 227
    dw $0000 ; id 228
    dw $0000 ; id 229
    dw $0000 ; id 230
    dw $0000 ; id 231

; B = X and C = Y in pixels: returns A = 1 + the number of the first of the wSpriteSlotCount slots
; (16 bytes each from wSpriteSlots, X at +$0B and Y at +$0C) whose X and Y lie in the same 16-pixel
; tile as the point, or A = 0 when none does. With wSpriteSlotCount 0 it returns A = 0 at once;
; otherwise hTemp0 = C / 16 and hTemp1 = B / 16 are set. Its only caller is CheckMapInteractionOnA.
; (C2, E-0385)
; part of CheckMapInteractionOnA that reads the sprite slots (E-0339; was
; CheckMapInteractionOnA_SpriteSlots)
CheckMapInteractionOnA_SpriteSlots::
    ld a, [wSpriteSlotCount]
    or a
    ret z
    ld a, c
    swap a
    and $0f
    ldh [hTemp0], a
    ld a, b
    swap a
    and $0f
    ldh [hTemp1], a
    ld a, [wSpriteSlotCount]
    ld b, a
    ld c, $01
    ld hl, wSpriteSlots + $b

.loop:
    push hl
    push bc
    ld a, [hl]
    swap a
    and $0f
    ld c, a
    ldh a, [hTemp1]
    cp c
    jr nz, .restore
    inc hl
    ld a, [hl]
    swap a
    and $0f
    ld c, a
    ldh a, [hTemp0]
    cp c
    jr z, .restore2

.restore:
    pop bc
    inc c
    pop hl
    ld a, $10
    add_a_to_hl
    dec b
    jr nz, .loop
    xor a
    ret

.restore2:
    pop bc
    pop hl
    ld a, c
    ret

SECTION "Bank 87 MapInteractions00", ROMX

; list for entry $00 of MapInteractionTable; 4 record(s), then $FF (E-0157)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X,
; player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions00::
    db $05, $00, $01, $02, $70, $70 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $a3, $01 ; talk event group, index
    db $04, $00, $00, $02, $30, $50 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $a2, $01 ; talk event group, index
    db $03, $00, $00, $02, $70, $30 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $1b, $00 ; talk event group, index
    db $01, $00, $00, $03, $40, $30 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $e5, $01 ; talk event group, index
    db $ff ; end

; list for entry $01 of MapInteractionTable; 1 record(s), then $FF (E-0157)
MapInteractions01::
    db $03, $01, $02, $02, $60, $70 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $17, $0a ; talk event group, index
    db $ff ; end

; list for entry $02 of MapInteractionTable; 6 record(s), then $FF (E-0157)
MapInteractions02::
    db $03, $02, $01, $00, $30, $20 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $13, $01 ; talk event group, index
    db $05, $02, $01, $00, $20, $40 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $13, $01 ; talk event group, index
    db $03, $02, $01, $00, $50, $20 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $a5, $01 ; talk event group, index
    db $03, $02, $00, $00, $10, $40 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $45, $01 ; talk event group, index
    db $01, $02, $00, $00, $50, $40 ; id 4: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $ab, $01 ; talk event group, index
    db $01, $02, $00, $00, $70, $40 ; id 5: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $ab, $01 ; talk event group, index
    db $ff ; end
    db $03, $03, $00, $00, $50, $40, $02, $00, $03, $0a, $ff

; list for entry $04 of MapInteractionTable; 5 record(s), then $FF (E-0157)
MapInteractions04::
    db $03, $04, $01, $00, $40, $30 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $65, $01 ; talk event group, index
    db $03, $04, $01, $00, $50, $30 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $9d, $01 ; talk event group, index
    db $05, $04, $00, $00, $40, $40 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $22, $00 ; talk event group, index
    db $05, $04, $00, $00, $30, $50 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $23, $00 ; talk event group, index
    db $05, $04, $00, $00, $40, $60 ; id 4: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $24, $00 ; talk event group, index
    db $ff ; end

; list for entry $05 of MapInteractionTable; 1 record(s), then $FF (E-0157)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X,
; player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions05::
    db $05, $05, $01, $00, $40, $30 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $a9, $01 ; talk event group, index
    db $ff ; end

; list for entry $06 of MapInteractionTable; 10 record(s), then $FF (E-0157)
MapInteractions06::
    db $03, $06, $00, $00, $40, $10 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $03, $01 ; talk event group, index
    db $03, $06, $00, $00, $30, $10 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $a0, $01 ; talk event group, index
    db $03, $06, $00, $00, $60, $10 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $a1, $01 ; talk event group, index
    db $05, $06, $00, $00, $20, $50 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $05, $01 ; talk event group, index
    db $01, $06, $00, $00, $10, $40 ; id 4: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $06, $01 ; talk event group, index
    db $04, $06, $00, $00, $20, $60 ; id 5: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $06, $01 ; talk event group, index
    db $05, $06, $00, $00, $20, $70 ; id 6: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $06, $01 ; talk event group, index
    db $03, $06, $01, $00, $40, $10 ; id 7: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $e6, $01 ; talk event group, index
    db $03, $06, $01, $00, $30, $10 ; id 8: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $e6, $01 ; talk event group, index
    db $03, $06, $01, $00, $60, $10 ; id 9: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $e6, $01 ; talk event group, index
    db $ff ; end

; list for entry $07 of MapInteractionTable; 7 record(s), then $FF (E-0157)
MapInteractions07::
    db $03, $07, $00, $00, $60, $60 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $50, $01 ; talk event group, index
    db $05, $07, $00, $00, $70, $10 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $d2, $01 ; talk event group, index
    db $03, $07, $00, $00, $80, $20 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $d3, $01 ; talk event group, index
    db $03, $07, $00, $01, $10, $30 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $51, $01 ; talk event group, index
    db $05, $07, $00, $01, $20, $20 ; id 4: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $52, $01 ; talk event group, index
    db $03, $07, $00, $01, $70, $20 ; id 5: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $53, $01 ; talk event group, index
    db $03, $07, $00, $01, $80, $20 ; id 6: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $54, $01 ; talk event group, index
    db $ff ; end

; list for entry $08 of MapInteractionTable; 2 record(s), then $FF (E-0157)
MapInteractions08::
    db $03, $08, $00, $00, $40, $40 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $07, $0a ; talk event group, index
    db $03, $08, $00, $00, $60, $40 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $08, $0a ; talk event group, index
    db $ff ; end

; list for entry $09 of MapInteractionTable; 3 record(s), then $FF (E-0157)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X,
; player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions09::
    db $03, $09, $00, $00, $20, $30 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $c5, $01 ; talk event group, index
    db $05, $09, $00, $00, $60, $20 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $c6, $01 ; talk event group, index
    db $03, $09, $00, $00, $70, $30 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $c7, $01 ; talk event group, index
    db $ff ; end

; list for entry $0C of MapInteractionTable; 3 record(s), then $FF (E-0157)
MapInteractions0C::
    db $04, $0c, $00, $00, $20, $50 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $c9, $01 ; talk event group, index
    db $04, $0c, $00, $00, $20, $60 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $ca, $01 ; talk event group, index
    db $03, $0c, $01, $00, $30, $70 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $1f, $01 ; talk event group, index
    db $ff ; end

; list for entry $0D of MapInteractionTable; 4 record(s), then $FF (E-0157)
MapInteractions0D::
    db $03, $0d, $01, $01, $10, $10 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $6c, $01 ; talk event group, index
    db $03, $0d, $01, $01, $80, $10 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $6d, $01 ; talk event group, index
    db $03, $0d, $01, $00, $50, $10 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $6e, $01 ; talk event group, index
    db $01, $0d, $00, $01, $50, $70 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $012b ; story flag that disables the entry ($FFFF = none)
    db $cc, $01 ; talk event group, index
    db $ff ; end

; list for entry $0E of MapInteractionTable; 5 record(s), then $FF (E-0157)
MapInteractions0E::
    db $03, $0e, $00, $00, $10, $10 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $3b, $01 ; talk event group, index
    db $03, $0e, $00, $00, $20, $10 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $3c, $01 ; talk event group, index
    db $03, $0e, $00, $00, $50, $20 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $3d, $01 ; talk event group, index
    db $03, $0e, $00, $00, $60, $20 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $3d, $01 ; talk event group, index
    db $03, $0e, $00, $00, $70, $20 ; id 4: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $b1, $01 ; talk event group, index
    db $ff ; end

; list for entry $0F of MapInteractionTable; 6 record(s), then $FF (E-0157)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X,
; player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions0F::
    db $03, $0f, $00, $00, $10, $10 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $40, $01 ; talk event group, index
    db $03, $0f, $00, $00, $20, $10 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $3f, $01 ; talk event group, index
    db $05, $0f, $00, $00, $10, $60 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $41, $01 ; talk event group, index
    db $03, $0f, $00, $00, $60, $10 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $43, $01 ; talk event group, index
    db $03, $0f, $00, $00, $70, $10 ; id 4: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $44, $01 ; talk event group, index
    db $05, $0f, $00, $00, $80, $30 ; id 5: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $cb, $01 ; talk event group, index
    db $ff ; end

; list for entry $10 of MapInteractionTable; 3 record(s), then $FF (E-0157)
MapInteractions10::
    db $03, $10, $00, $00, $60, $10 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $43, $01 ; talk event group, index
    db $03, $10, $00, $00, $70, $10 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $44, $01 ; talk event group, index
    db $05, $10, $00, $00, $80, $30 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $cb, $01 ; talk event group, index
    db $ff ; end

; list for entry $11 of MapInteractionTable; 16 record(s), then $FF (E-0157)
MapInteractions11::
    db $05, $11, $00, $01, $70, $50 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $09, $0a ; talk event group, index
    db $02, $11, $00, $01, $20, $20 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $0a, $0a ; talk event group, index
    db $03, $11, $00, $01, $40, $40 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $0a, $0a ; talk event group, index
    db $03, $11, $00, $00, $10, $30 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $0b, $0a ; talk event group, index
    db $03, $11, $00, $00, $20, $30 ; id 4: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $0c, $0a ; talk event group, index
    db $03, $11, $00, $00, $30, $30 ; id 5: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $0d, $0a ; talk event group, index
    db $03, $11, $00, $00, $70, $30 ; id 6: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $0e, $0a ; talk event group, index
    db $03, $11, $00, $00, $80, $30 ; id 7: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $0f, $0a ; talk event group, index
    db $03, $11, $00, $00, $10, $70 ; id 8: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $10, $0a ; talk event group, index
    db $03, $11, $00, $00, $20, $70 ; id 9: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $11, $0a ; talk event group, index
    db $03, $11, $00, $00, $40, $70 ; id 10: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $12, $0a ; talk event group, index
    db $03, $11, $00, $00, $50, $70 ; id 11: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $13, $0a ; talk event group, index
    db $03, $11, $00, $00, $70, $70 ; id 12: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $14, $0a ; talk event group, index
    db $03, $11, $00, $00, $80, $70 ; id 13: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $15, $0a ; talk event group, index
    db $03, $11, $00, $00, $40, $30 ; id 14: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $16, $0a ; talk event group, index
    db $03, $11, $00, $00, $60, $30 ; id 15: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $16, $0a ; talk event group, index
    db $ff ; end

; list for entry $12 of MapInteractionTable; 4 record(s), then $FF (E-0157)
MapInteractions12::
    db $03, $12, $00, $00, $80, $20 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $c8, $01 ; talk event group, index
    db $03, $12, $00, $00, $30, $10 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $78, $01 ; talk event group, index
    db $05, $12, $00, $00, $70, $10 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $79, $01 ; talk event group, index
    db $05, $12, $00, $00, $50, $40 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $7a, $01 ; talk event group, index
    db $ff ; end

; list for entry $13 of MapInteractionTable; 3 record(s), then $FF (E-0157)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X,
; player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions13::
    db $03, $13, $00, $00, $10, $30 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $47, $01 ; talk event group, index
    db $03, $13, $00, $00, $20, $30 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $48, $01 ; talk event group, index
    db $03, $13, $00, $00, $70, $30 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $49, $01 ; talk event group, index
    db $ff ; end

; list for entry $15 of MapInteractionTable; 10 record(s), then $FF (E-0157)
MapInteractions15::
    db $03, $15, $00, $00, $10, $10 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $90, $01 ; talk event group, index
    db $03, $15, $00, $00, $20, $10 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $90, $01 ; talk event group, index
    db $03, $15, $00, $00, $30, $10 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $90, $01 ; talk event group, index
    db $03, $15, $00, $00, $60, $50 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $90, $01 ; talk event group, index
    db $03, $15, $00, $00, $70, $50 ; id 4: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $90, $01 ; talk event group, index
    db $03, $15, $00, $00, $80, $50 ; id 5: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $90, $01 ; talk event group, index
    db $02, $15, $00, $00, $30, $10 ; id 6: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $91, $01 ; talk event group, index
    db $05, $15, $00, $00, $40, $20 ; id 7: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $91, $01 ; talk event group, index
    db $05, $15, $00, $00, $10, $60 ; id 8: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $91, $01 ; talk event group, index
    db $03, $15, $00, $00, $60, $20 ; id 9: kind, map, screen X, screen Y, player X, player Y
    dw $0030 ; story flag that disables the entry ($FFFF = none)
    db $db, $01 ; talk event group, index
    db $ff ; end

; list for entry $16 of MapInteractionTable; 5 record(s), then $FF (E-0157)
MapInteractions16::
    db $03, $16, $00, $00, $20, $20 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $74, $01 ; talk event group, index
    db $03, $16, $00, $00, $30, $20 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $75, $01 ; talk event group, index
    db $03, $16, $00, $00, $70, $30 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $76, $01 ; talk event group, index
    db $05, $16, $00, $00, $50, $20 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $ce, $01 ; talk event group, index
    db $03, $16, $00, $00, $60, $30 ; id 4: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $ce, $01 ; talk event group, index
    db $ff ; end

; list for entry $17 of MapInteractionTable; 1 record(s), then $FF (E-0157)
MapInteractions17::
    db $02, $17, $00, $00, $50, $40 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $86, $01 ; talk event group, index
    db $ff ; end

; list for entry $18 of MapInteractionTable; 6 record(s), then $FF (E-0157)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X,
; player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions18::
    db $04, $18, $00, $01, $30, $30 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $62, $01 ; talk event group, index
    db $05, $18, $00, $01, $30, $40 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $62, $01 ; talk event group, index
    db $01, $18, $00, $00, $50, $40 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $62, $01 ; talk event group, index
    db $05, $18, $00, $00, $20, $60 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $63, $01 ; talk event group, index
    db $05, $18, $02, $01, $70, $40 ; id 4: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $62, $01 ; talk event group, index
    db $01, $18, $02, $01, $60, $40 ; id 5: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $62, $01 ; talk event group, index
    db $ff ; end

; list for entry $19 of MapInteractionTable; 14 record(s), then $FF (E-0157)
MapInteractions19::
    db $04, $19, $00, $01, $40, $20 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $d8, $01 ; talk event group, index
    db $02, $19, $00, $01, $50, $20 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $d8, $01 ; talk event group, index
    db $03, $19, $00, $02, $60, $20 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $e2, $01 ; talk event group, index
    db $03, $19, $00, $02, $70, $20 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $ee, $01 ; talk event group, index
    db $05, $19, $00, $02, $80, $30 ; id 4: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $9a, $01 ; talk event group, index
    db $05, $19, $00, $02, $80, $60 ; id 5: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $9b, $01 ; talk event group, index
    db $04, $19, $00, $00, $30, $30 ; id 6: kind, map, screen X, screen Y, player X, player Y
    dw $0025 ; story flag that disables the entry ($FFFF = none)
    db $1b, $0a ; talk event group, index
    db $04, $19, $00, $00, $30, $50 ; id 7: kind, map, screen X, screen Y, player X, player Y
    dw $0025 ; story flag that disables the entry ($FFFF = none)
    db $1c, $0a ; talk event group, index
    db $04, $19, $00, $00, $30, $60 ; id 8: kind, map, screen X, screen Y, player X, player Y
    dw $0025 ; story flag that disables the entry ($FFFF = none)
    db $1d, $0a ; talk event group, index
    db $04, $19, $00, $00, $30, $70 ; id 9: kind, map, screen X, screen Y, player X, player Y
    dw $0025 ; story flag that disables the entry ($FFFF = none)
    db $1e, $0a ; talk event group, index
    db $02, $19, $00, $00, $60, $30 ; id 10: kind, map, screen X, screen Y, player X, player Y
    dw $0025 ; story flag that disables the entry ($FFFF = none)
    db $1f, $0a ; talk event group, index
    db $02, $19, $00, $00, $60, $40 ; id 11: kind, map, screen X, screen Y, player X, player Y
    dw $0025 ; story flag that disables the entry ($FFFF = none)
    db $20, $0a ; talk event group, index
    db $02, $19, $00, $00, $60, $50 ; id 12: kind, map, screen X, screen Y, player X, player Y
    dw $0025 ; story flag that disables the entry ($FFFF = none)
    db $21, $0a ; talk event group, index
    db $02, $19, $00, $00, $60, $70 ; id 13: kind, map, screen X, screen Y, player X, player Y
    dw $0025 ; story flag that disables the entry ($FFFF = none)
    db $22, $0a ; talk event group, index
    db $ff ; end

; list for entry $1A of MapInteractionTable; 2 record(s), then $FF (E-0157)
MapInteractions1A::
    db $05, $1a, $00, $00, $30, $40 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $8b, $01 ; talk event group, index
    db $02, $1a, $02, $00, $50, $50 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $1c, $00 ; talk event group, index
    db $ff ; end

; list for entry $1B of MapInteractionTable; 2 record(s), then $FF (E-0157)
MapInteractions1B::
    db $05, $1b, $00, $02, $30, $40 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $ec, $01 ; talk event group, index
    db $05, $1b, $00, $02, $60, $40 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $ed, $01 ; talk event group, index
    db $ff ; end

; list for entry $1D of MapInteractionTable; 8 record(s), then $FF (E-0157)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X,
; player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions1D::
    db $04, $1d, $00, $00, $90, $30 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $18, $0a ; talk event group, index
    db $05, $1d, $00, $00, $80, $60 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $19, $0a ; talk event group, index
    db $01, $1d, $00, $00, $90, $50 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $19, $0a ; talk event group, index
    db $05, $1d, $01, $00, $10, $30 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $19, $0a ; talk event group, index
    db $03, $1d, $01, $00, $40, $30 ; id 4: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $19, $0a ; talk event group, index
    db $01, $1d, $01, $00, $00, $50 ; id 5: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $19, $0a ; talk event group, index
    db $01, $1d, $01, $00, $20, $50 ; id 6: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $18, $0a ; talk event group, index
    db $01, $1d, $01, $00, $30, $50 ; id 7: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $18, $0a ; talk event group, index
    db $ff ; end

; list for entry $21 of MapInteractionTable; 2 record(s), then $FF (E-0157)
MapInteractions21::
    db $05, $21, $00, $00, $10, $40 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $07, $02 ; talk event group, index
    db $05, $21, $01, $00, $30, $30 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $08, $02 ; talk event group, index
    db $ff ; end

; list for entry $22 of MapInteractionTable; 2 record(s), then $FF (E-0157)
MapInteractions22::
    db $04, $22, $00, $00, $50, $40 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $0a, $02 ; talk event group, index
    db $01, $22, $00, $00, $30, $20 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $0a, $02 ; talk event group, index
    db $ff ; end

; list for entry $23 of MapInteractionTable; 1 record(s), then $FF (E-0157)
MapInteractions23::
    db $01, $23, $00, $00, $10, $40 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $1f, $02 ; talk event group, index
    db $ff ; end

; list for entry $24 of MapInteractionTable; 5 record(s), then $FF (E-0157)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X,
; player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions24::
    db $05, $24, $00, $00, $20, $70 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $19, $02 ; talk event group, index
    db $03, $24, $00, $00, $80, $60 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $1d, $02 ; talk event group, index
    db $03, $24, $00, $01, $70, $30 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $1e, $02 ; talk event group, index
    db $02, $24, $01, $01, $60, $60 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $1a, $02 ; talk event group, index
    db $04, $24, $01, $01, $60, $60 ; id 4: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $1b, $02 ; talk event group, index
    db $ff ; end

; list for entry $25 of MapInteractionTable; 1 record(s), then $FF (E-0157)
MapInteractions25::
    db $03, $25, $01, $00, $50, $10 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $2a, $02 ; talk event group, index
    db $ff ; end

; list for entry $28 of MapInteractionTable; 3 record(s), then $FF (E-0157)
MapInteractions28::
    db $05, $28, $00, $00, $30, $10 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $40, $02 ; talk event group, index
    db $05, $28, $00, $00, $20, $30 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $40, $02 ; talk event group, index
    db $05, $28, $00, $00, $60, $40 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $40, $02 ; talk event group, index
    db $ff ; end

; list for entry $2A of MapInteractionTable; 2 record(s), then $FF (E-0157)
MapInteractions2A::
    db $02, $2a, $00, $00, $70, $60 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $42, $02 ; talk event group, index
    db $02, $2a, $00, $00, $70, $70 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $3f, $02 ; talk event group, index
    db $ff ; end

; list for entry $2B of MapInteractionTable; 8 record(s), then $FF (E-0157)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X,
; player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions2B::
    db $05, $2b, $00, $01, $10, $60 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $2f, $02 ; talk event group, index
    db $05, $2b, $00, $01, $20, $70 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $30, $02 ; talk event group, index
    db $05, $2b, $01, $00, $80, $30 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $31, $02 ; talk event group, index
    db $05, $2b, $02, $01, $60, $30 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $32, $02 ; talk event group, index
    db $05, $2b, $01, $02, $20, $20 ; id 4: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $33, $02 ; talk event group, index
    db $05, $2b, $02, $02, $60, $30 ; id 5: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $34, $02 ; talk event group, index
    db $05, $2b, $00, $03, $30, $70 ; id 6: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $35, $02 ; talk event group, index
    db $05, $2b, $00, $03, $50, $70 ; id 7: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $36, $02 ; talk event group, index
    db $ff ; end

; list for entry $2D of MapInteractionTable; 3 record(s), then $FF (E-0157)
MapInteractions2D::
    db $03, $2d, $00, $00, $20, $40 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $005a ; story flag that disables the entry ($FFFF = none)
    db $38, $02 ; talk event group, index
    db $01, $2d, $00, $00, $20, $40 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $005a ; story flag that disables the entry ($FFFF = none)
    db $1c, $02 ; talk event group, index
    db $03, $2d, $00, $00, $60, $30 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $41, $02 ; talk event group, index
    db $ff ; end

; list for entry $2E of MapInteractionTable; 4 record(s), then $FF (E-0157)
MapInteractions2E::
    db $04, $2e, $00, $00, $40, $20 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $3e, $02 ; talk event group, index
    db $03, $2e, $00, $00, $40, $20 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $3e, $02 ; talk event group, index
    db $02, $2e, $00, $00, $50, $20 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $3e, $02 ; talk event group, index
    db $03, $2e, $00, $00, $50, $20 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $3e, $02 ; talk event group, index
    db $ff ; end

; list for entry $31 of MapInteractionTable; 8 record(s), then $FF (E-0157)
MapInteractions31::
    db $03, $31, $00, $00, $20, $70 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $08, $03 ; talk event group, index
    db $04, $31, $00, $00, $20, $70 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $09, $03 ; talk event group, index
    db $05, $31, $00, $00, $80, $60 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $08, $03 ; talk event group, index
    db $02, $31, $00, $00, $70, $50 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $0a, $03 ; talk event group, index
    db $02, $31, $00, $01, $70, $10 ; id 4: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $0b, $03 ; talk event group, index
    db $05, $31, $00, $01, $10, $20 ; id 5: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $0c, $03 ; talk event group, index
    db $03, $31, $00, $01, $70, $40 ; id 6: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $0d, $03 ; talk event group, index
    db $05, $31, $00, $01, $10, $40 ; id 7: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $0e, $03 ; talk event group, index
    db $ff ; end

; list for entry $32 of MapInteractionTable; 6 record(s), then $FF (E-0157)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X,
; player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions32::
    db $05, $32, $01, $00, $10, $20 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $2a, $03 ; talk event group, index
    db $05, $32, $01, $01, $20, $10 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $2a, $03 ; talk event group, index
    db $05, $32, $01, $00, $20, $70 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $2b, $03 ; talk event group, index
    db $03, $32, $00, $00, $10, $30 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $28, $03 ; talk event group, index
    db $05, $32, $01, $00, $60, $20 ; id 4: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $29, $03 ; talk event group, index
    db $05, $32, $01, $00, $80, $20 ; id 5: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $29, $03 ; talk event group, index
    db $ff ; end

; list for entry $33 of MapInteractionTable; 1 record(s), then $FF (E-0157)
MapInteractions33::
    db $03, $33, $00, $00, $50, $50 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $30, $03 ; talk event group, index
    db $ff ; end

; list for entry $34 of MapInteractionTable; 1 record(s), then $FF (E-0157)
MapInteractions34::
    db $03, $34, $00, $00, $30, $30 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $2c, $03 ; talk event group, index
    db $ff ; end

; list for entry $35 of MapInteractionTable; 6 record(s), then $FF (E-0157)
MapInteractions35::
    db $05, $35, $00, $00, $50, $50 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $35, $03 ; talk event group, index
    db $05, $35, $01, $00, $40, $40 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $36, $03 ; talk event group, index
    db $05, $35, $03, $00, $70, $30 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $37, $03 ; talk event group, index
    db $05, $35, $03, $00, $70, $50 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $38, $03 ; talk event group, index
    db $05, $35, $03, $00, $70, $70 ; id 4: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $39, $03 ; talk event group, index
    db $05, $35, $02, $03, $30, $20 ; id 5: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $3a, $03 ; talk event group, index
    db $ff ; end

; list for entry $37 of MapInteractionTable; 8 record(s), then $FF (E-0157)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X,
; player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions37::
    db $03, $37, $00, $00, $60, $50 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $5c, $03 ; talk event group, index
    db $03, $37, $00, $00, $70, $50 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $5d, $03 ; talk event group, index
    db $01, $37, $01, $00, $20, $60 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $5e, $03 ; talk event group, index
    db $05, $37, $01, $00, $50, $40 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $60, $03 ; talk event group, index
    db $05, $37, $01, $00, $60, $40 ; id 4: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $5f, $03 ; talk event group, index
    db $05, $37, $01, $00, $80, $40 ; id 5: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $5f, $03 ; talk event group, index
    db $03, $37, $02, $00, $70, $20 ; id 6: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $5f, $03 ; talk event group, index
    db $03, $37, $02, $00, $80, $20 ; id 7: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $61, $03 ; talk event group, index
    db $ff ; end

; list for entry $39 of MapInteractionTable; 5 record(s), then $FF (E-0157)
MapInteractions39::
    db $05, $39, $03, $00, $20, $40 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $54, $03 ; talk event group, index
    db $05, $39, $03, $00, $70, $40 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $55, $03 ; talk event group, index
    db $05, $39, $03, $02, $30, $60 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $56, $03 ; talk event group, index
    db $05, $39, $03, $02, $50, $60 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $57, $03 ; talk event group, index
    db $05, $39, $03, $02, $70, $60 ; id 4: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $58, $03 ; talk event group, index
    db $ff ; end

; list for entry $3A of MapInteractionTable; 2 record(s), then $FF (E-0157)
MapInteractions3A::
    db $05, $3a, $00, $00, $40, $50 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $5a, $03 ; talk event group, index
    db $05, $3a, $00, $00, $50, $50 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $5b, $03 ; talk event group, index
    db $ff ; end

; list for entry $3B of MapInteractionTable; 1 record(s), then $FF (E-0157)
MapInteractions3B::
    db $05, $3b, $00, $00, $70, $70 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $6b, $03 ; talk event group, index
    db $ff ; end

; list for entry $3C of MapInteractionTable; 3 record(s), then $FF (E-0157)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X,
; player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions3C::
    db $04, $3c, $00, $00, $50, $40 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $3d, $03 ; talk event group, index
    db $03, $3c, $01, $00, $40, $50 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $18, $03 ; talk event group, index
    db $03, $3c, $02, $00, $70, $60 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $19, $03 ; talk event group, index
    db $ff ; end

; list for entry $3D of MapInteractionTable; 4 record(s), then $FF (E-0157)
MapInteractions3D::
    db $03, $3d, $00, $00, $70, $30 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $14, $03 ; talk event group, index
    db $01, $3d, $00, $00, $30, $60 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $59, $03 ; talk event group, index
    db $01, $3d, $00, $00, $40, $60 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $59, $03 ; talk event group, index
    db $01, $3d, $00, $00, $50, $60 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $59, $03 ; talk event group, index
    db $ff ; end

; list for entry $3E of MapInteractionTable; 1 record(s), then $FF (E-0157)
MapInteractions3E::
    db $05, $3e, $01, $01, $60, $30 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $4e, $03 ; talk event group, index
    db $ff ; end

; list for entry $40 of MapInteractionTable; 2 record(s), then $FF (E-0157)
MapInteractions40::
    db $03, $40, $00, $00, $40, $40 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $4f, $03 ; talk event group, index
    db $03, $40, $00, $00, $50, $40 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $4f, $03 ; talk event group, index
    db $ff ; end

; list for entry $42 of MapInteractionTable; 5 record(s), then $FF (E-0157)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X,
; player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions42::
    db $03, $42, $00, $00, $40, $20 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $62, $03 ; talk event group, index
    db $03, $42, $00, $00, $50, $20 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $63, $03 ; talk event group, index
    db $03, $42, $00, $00, $60, $20 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $64, $03 ; talk event group, index
    db $05, $42, $01, $00, $50, $40 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $65, $03 ; talk event group, index
    db $05, $42, $02, $00, $80, $20 ; id 4: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $5f, $03 ; talk event group, index
    db $ff ; end

; list for entry $43 of MapInteractionTable; 10 record(s), then $FF (E-0157)
MapInteractions43::
    db $05, $43, $00, $00, $50, $40 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $0077 ; story flag that disables the entry ($FFFF = none)
    db $4c, $03 ; talk event group, index
    db $04, $43, $00, $00, $30, $40 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $5f, $03 ; talk event group, index
    db $05, $43, $00, $00, $60, $20 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $5f, $03 ; talk event group, index
    db $05, $43, $00, $00, $90, $30 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $5f, $03 ; talk event group, index
    db $02, $43, $01, $00, $10, $20 ; id 4: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $66, $03 ; talk event group, index
    db $01, $43, $01, $00, $10, $20 ; id 5: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $5f, $03 ; talk event group, index
    db $03, $43, $01, $00, $00, $50 ; id 6: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $5f, $03 ; talk event group, index
    db $02, $43, $01, $00, $20, $40 ; id 7: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $5f, $03 ; talk event group, index
    db $04, $43, $01, $00, $70, $30 ; id 8: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $5f, $03 ; talk event group, index
    db $02, $43, $01, $00, $80, $20 ; id 9: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $67, $03 ; talk event group, index
    db $ff ; end

; list for entry $44 of MapInteractionTable; 8 record(s), then $FF (E-0157)
MapInteractions44::
    db $03, $44, $00, $00, $60, $20 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $0076 ; story flag that disables the entry ($FFFF = none)
    db $4b, $03 ; talk event group, index
    db $01, $44, $00, $00, $10, $60 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $68, $03 ; talk event group, index
    db $05, $44, $00, $00, $20, $70 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $68, $03 ; talk event group, index
    db $05, $44, $00, $00, $60, $70 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $68, $03 ; talk event group, index
    db $01, $44, $00, $00, $70, $60 ; id 4: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $68, $03 ; talk event group, index
    db $03, $44, $00, $00, $10, $10 ; id 5: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $69, $03 ; talk event group, index
    db $03, $44, $00, $00, $70, $10 ; id 6: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $69, $03 ; talk event group, index
    db $03, $44, $00, $00, $80, $10 ; id 7: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $69, $03 ; talk event group, index
    db $ff ; end

; list for entry $4A of MapInteractionTable; 6 record(s), then $FF (E-0157)
MapInteractions4A::
    db $04, $4a, $00, $00, $40, $80 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $0e, $04 ; talk event group, index
    db $04, $4a, $00, $01, $30, $70 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $0f, $04 ; talk event group, index
    db $02, $4a, $00, $00, $70, $60 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $10, $04 ; talk event group, index
    db $03, $4a, $00, $01, $10, $20 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $10, $04 ; talk event group, index
    db $03, $4a, $01, $01, $60, $30 ; id 4: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $11, $04 ; talk event group, index
    db $03, $4a, $01, $01, $80, $30 ; id 5: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $11, $04 ; talk event group, index
    db $ff ; end

; list for entry $4B of MapInteractionTable; 1 record(s), then $FF (E-0157)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X,
; player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions4B::
    db $04, $4b, $00, $00, $80, $20 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $12, $04 ; talk event group, index
    db $ff ; end

; list for entry $4C of MapInteractionTable; 4 record(s), then $FF (E-0157)
MapInteractions4C::
    db $03, $4c, $01, $00, $20, $10 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $19, $04 ; talk event group, index
    db $03, $4c, $01, $00, $70, $10 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $1a, $04 ; talk event group, index
    db $03, $4c, $01, $01, $60, $20 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $1b, $04 ; talk event group, index
    db $03, $4c, $01, $01, $70, $20 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $1b, $04 ; talk event group, index
    db $ff ; end

; list for entry $4D of MapInteractionTable; 4 record(s), then $FF (E-0157)
MapInteractions4D::
    db $03, $4d, $00, $01, $60, $10 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $008a ; story flag that disables the entry ($FFFF = none)
    db $4a, $04 ; talk event group, index
    db $03, $4d, $00, $01, $50, $10 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $008a ; story flag that disables the entry ($FFFF = none)
    db $4a, $04 ; talk event group, index
    db $03, $4d, $00, $01, $40, $10 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $008a ; story flag that disables the entry ($FFFF = none)
    db $4a, $04 ; talk event group, index
    db $03, $4d, $00, $01, $30, $10 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $008a ; story flag that disables the entry ($FFFF = none)
    db $4b, $04 ; talk event group, index
    db $ff ; end

; list for entry $4F of MapInteractionTable; 5 record(s), then $FF (E-0157)
MapInteractions4F::
    db $05, $4f, $00, $00, $10, $50 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $2d, $04 ; talk event group, index
    db $04, $4f, $01, $01, $20, $10 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $2d, $04 ; talk event group, index
    db $04, $4f, $01, $00, $20, $20 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $2f, $04 ; talk event group, index
    db $02, $4f, $01, $00, $70, $50 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $2f, $04 ; talk event group, index
    db $02, $4f, $01, $01, $70, $10 ; id 4: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $30, $04 ; talk event group, index
    db $ff ; end

; list for entry $50 of MapInteractionTable; 3 record(s), then $FF (E-0157)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X,
; player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions50::
    db $04, $50, $00, $00, $40, $20 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $31, $04 ; talk event group, index
    db $05, $50, $00, $00, $40, $70 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $35, $04 ; talk event group, index
    db $01, $50, $00, $00, $50, $60 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $35, $04 ; talk event group, index
    db $ff ; end

; list for entry $51 of MapInteractionTable; 1 record(s), then $FF (E-0157)
MapInteractions51::
    db $04, $51, $00, $00, $30, $10 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $36, $04 ; talk event group, index
    db $ff ; end

; list for entry $55 of MapInteractionTable; 1 record(s), then $FF (E-0157)
MapInteractions55::
    db $05, $55, $00, $00, $30, $40 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $47, $04 ; talk event group, index
    db $ff ; end

; list for entry $57 of MapInteractionTable; 1 record(s), then $FF (E-0157)
MapInteractions57::
    db $03, $57, $01, $00, $40, $20 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $0085 ; story flag that disables the entry ($FFFF = none)
    db $45, $04 ; talk event group, index
    db $ff ; end

; list for entry $58 of MapInteractionTable; 7 record(s), then $FF (E-0157)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X,
; player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions58::
    db $01, $58, $01, $00, $10, $60 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $5b, $04 ; talk event group, index
    db $05, $58, $01, $00, $20, $70 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $5b, $04 ; talk event group, index
    db $05, $58, $00, $01, $90, $50 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $5c, $04 ; talk event group, index
    db $05, $58, $00, $00, $20, $10 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $5d, $04 ; talk event group, index
    db $03, $58, $01, $00, $30, $30 ; id 4: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $5d, $04 ; talk event group, index
    db $02, $58, $01, $00, $20, $20 ; id 5: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $5d, $04 ; talk event group, index
    db $03, $58, $00, $01, $20, $20 ; id 6: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $5d, $04 ; talk event group, index
    db $ff ; end

; list for entry $59 of MapInteractionTable; 2 record(s), then $FF (E-0157)
MapInteractions59::
    db $03, $59, $00, $00, $80, $30 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $5e, $04 ; talk event group, index
    db $03, $59, $00, $00, $60, $30 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $5f, $04 ; talk event group, index
    db $ff ; end

; list for entry $5A of MapInteractionTable; 1 record(s), then $FF (E-0157)
MapInteractions5A::
    db $03, $5a, $01, $00, $60, $60 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $68, $04 ; talk event group, index
    db $ff ; end

; list for entry $5B of MapInteractionTable; 5 record(s), then $FF (E-0157)
MapInteractions5B::
    db $03, $5b, $00, $00, $20, $10 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $94, $04 ; talk event group, index
    db $03, $5b, $00, $00, $30, $10 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $95, $04 ; talk event group, index
    db $03, $5b, $00, $00, $40, $10 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $96, $04 ; talk event group, index
    db $03, $5b, $00, $01, $10, $20 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $97, $04 ; talk event group, index
    db $03, $5b, $00, $01, $20, $20 ; id 4: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $97, $04 ; talk event group, index
    db $ff ; end

; list for entry $5E of MapInteractionTable; 2 record(s), then $FF (E-0157)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X,
; player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions5E::
    db $02, $5e, $00, $01, $80, $00 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $85, $04 ; talk event group, index
    db $02, $5e, $00, $01, $70, $60 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $84, $04 ; talk event group, index
    db $ff ; end

; list for entry $5F of MapInteractionTable; 1 record(s), then $FF (E-0157)
MapInteractions5F::
    db $01, $5f, $00, $00, $40, $40 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $86, $04 ; talk event group, index
    db $ff ; end

; list for entry $60 of MapInteractionTable; 1 record(s), then $FF (E-0157)
MapInteractions60::
    db $03, $60, $00, $01, $20, $50 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $91, $04 ; talk event group, index
    db $ff ; end

; list for entry $62 of MapInteractionTable; 4 record(s), then $FF (E-0157)
MapInteractions62::
    db $02, $62, $01, $00, $10, $20 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $9c, $04 ; talk event group, index
    db $03, $62, $01, $00, $20, $30 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $9c, $04 ; talk event group, index
    db $02, $62, $01, $00, $20, $30 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $9c, $04 ; talk event group, index
    db $02, $62, $01, $01, $60, $20 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $9d, $04 ; talk event group, index
    db $ff ; end

; list for entry $63 of MapInteractionTable; 2 record(s), then $FF (E-0157)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X,
; player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions63::
    db $05, $63, $01, $00, $10, $70 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $a2, $04 ; talk event group, index
    db $05, $63, $00, $01, $80, $10 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $a3, $04 ; talk event group, index
    db $ff ; end

; list for entry $64 of MapInteractionTable; 2 record(s), then $FF (E-0157)
MapInteractions64::
    db $05, $64, $00, $00, $10, $40 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $a4, $04 ; talk event group, index
    db $05, $64, $00, $00, $40, $50 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $a5, $04 ; talk event group, index
    db $ff ; end

; list for entry $66 of MapInteractionTable; 2 record(s), then $FF (E-0157)
MapInteractions66::
    db $05, $66, $00, $00, $10, $40 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $a6, $04 ; talk event group, index
    db $05, $66, $00, $00, $30, $40 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $a7, $04 ; talk event group, index
    db $ff ; end

; list for entry $67 of MapInteractionTable; 2 record(s), then $FF (E-0157)
MapInteractions67::
    db $05, $67, $00, $00, $30, $70 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $a8, $04 ; talk event group, index
    db $05, $67, $00, $00, $60, $70 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $a9, $04 ; talk event group, index
    db $ff ; end

; list for entry $71 of MapInteractionTable; 8 record(s), then $FF (E-0157)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X,
; player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions71::
    db $03, $71, $00, $00, $10, $30 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $0c, $05 ; talk event group, index
    db $03, $71, $00, $00, $30, $30 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $0c, $05 ; talk event group, index
    db $03, $71, $00, $00, $10, $50 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $0c, $05 ; talk event group, index
    db $03, $71, $00, $00, $20, $30 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $0c, $05 ; talk event group, index
    db $03, $71, $00, $00, $10, $70 ; id 4: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $0c, $05 ; talk event group, index
    db $03, $71, $00, $00, $20, $70 ; id 5: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $0c, $05 ; talk event group, index
    db $03, $71, $00, $00, $20, $50 ; id 6: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $0d, $05 ; talk event group, index
    db $01, $71, $00, $00, $20, $30 ; id 7: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $15, $05 ; talk event group, index
    db $ff ; end

; list for entry $72 of MapInteractionTable; 1 record(s), then $FF (E-0157)
MapInteractions72::
    db $03, $72, $00, $00, $30, $30 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $0e, $05 ; talk event group, index
    db $ff ; end

; list for entry $89 of MapInteractionTable; 1 record(s), then $FF (E-0157)
MapInteractions89::
    db $03, $89, $00, $01, $50, $60 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $0f, $05 ; talk event group, index
    db $ff ; end

; list for entry $73 of MapInteractionTable; 1 record(s), then $FF (E-0157)
MapInteractions73::
    db $02, $73, $00, $01, $70, $20 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $10, $05 ; talk event group, index
    db $ff ; end

; list for entry $76 of MapInteractionTable; 4 record(s), then $FF (E-0157)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X,
; player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions76::
    db $03, $76, $00, $00, $40, $40 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $11, $05 ; talk event group, index
    db $05, $76, $00, $00, $60, $50 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $11, $05 ; talk event group, index
    db $05, $76, $00, $00, $30, $50 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $12, $05 ; talk event group, index
    db $05, $76, $00, $00, $80, $60 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $13, $05 ; talk event group, index
    db $ff ; end

; list for entry $78 of MapInteractionTable; 6 record(s), then $FF (E-0157)
MapInteractions78::
    db $04, $78, $00, $00, $20, $60 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $25, $05 ; talk event group, index
    db $03, $78, $01, $00, $50, $40 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $26, $05 ; talk event group, index
    db $05, $78, $00, $01, $10, $20 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $25, $05 ; talk event group, index
    db $05, $78, $00, $01, $10, $40 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $25, $05 ; talk event group, index
    db $01, $78, $01, $01, $50, $60 ; id 4: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $25, $05 ; talk event group, index
    db $03, $78, $01, $01, $60, $30 ; id 5: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $27, $05 ; talk event group, index
    db $ff ; end

; list for entry $79 of MapInteractionTable; 1 record(s), then $FF (E-0157)
MapInteractions79::
    db $03, $79, $00, $01, $70, $30 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $28, $05 ; talk event group, index
    db $ff ; end

; list for entry $7A of MapInteractionTable; 3 record(s), then $FF (E-0157)
MapInteractions7A::
    db $04, $7a, $00, $00, $30, $30 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $2b, $05 ; talk event group, index
    db $02, $7a, $00, $00, $60, $40 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $2b, $05 ; talk event group, index
    db $03, $7a, $00, $00, $40, $20 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $2c, $05 ; talk event group, index
    db $ff ; end

; list for entry $7C of MapInteractionTable; 6 record(s), then $FF (E-0157)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X,
; player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions7C::
    db $03, $7c, $00, $00, $30, $70 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $3c, $05 ; talk event group, index
    db $02, $7c, $01, $00, $70, $30 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $3e, $05 ; talk event group, index
    db $05, $7c, $01, $00, $80, $50 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $3e, $05 ; talk event group, index
    db $05, $7c, $00, $01, $90, $40 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $3d, $05 ; talk event group, index
    db $05, $7c, $01, $01, $00, $40 ; id 4: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $3d, $05 ; talk event group, index
    db $02, $7c, $01, $01, $70, $50 ; id 5: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $3d, $05 ; talk event group, index
    db $ff ; end

; list for entry $7D of MapInteractionTable; 1 record(s), then $FF (E-0157)
MapInteractions7D::
    db $04, $7d, $00, $00, $30, $10 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $3f, $05 ; talk event group, index
    db $ff ; end

; list for entry $7E of MapInteractionTable; 1 record(s), then $FF (E-0157)
MapInteractions7E::
    db $03, $7e, $00, $00, $30, $30 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $43, $05 ; talk event group, index
    db $ff ; end

; list for entry $7F of MapInteractionTable; 1 record(s), then $FF (E-0157)
MapInteractions7F::
    db $05, $7f, $00, $01, $70, $30 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $5b, $05 ; talk event group, index
    db $ff ; end

; list for entry $81 of MapInteractionTable; 1 record(s), then $FF (E-0157)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X,
; player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions81::
    db $03, $81, $00, $00, $40, $30 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $47, $05 ; talk event group, index
    db $ff ; end

; list for entry $82 of MapInteractionTable; 1 record(s), then $FF (E-0157)
MapInteractions82::
    db $05, $82, $02, $02, $50, $40 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $48, $05 ; talk event group, index
    db $ff ; end

; list for entry $84 of MapInteractionTable; 1 record(s), then $FF (E-0157)
MapInteractions84::
    db $02, $84, $00, $00, $50, $10 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $49, $05 ; talk event group, index
    db $ff ; end

; list for entry $85 of MapInteractionTable; 1 record(s), then $FF (E-0157)
MapInteractions85::
    db $05, $85, $01, $00, $50, $20 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $4b, $05 ; talk event group, index
    db $ff ; end

; list for entry $8D of MapInteractionTable; 2 record(s), then $FF (E-0157)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X,
; player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions8D::
    db $03, $8d, $00, $00, $40, $20 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $00b0 ; story flag that disables the entry ($FFFF = none)
    db $4d, $05 ; talk event group, index
    db $03, $8d, $00, $00, $50, $20 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $00b0 ; story flag that disables the entry ($FFFF = none)
    db $4d, $05 ; talk event group, index
    db $ff ; end

; list for entry $8E of MapInteractionTable; 75 record(s), then $FF (E-0157)
MapInteractions8E::
    db $03, $8e, $01, $00, $40, $20 ; id 0
    dw $00b2
    db $52, $05
    db $03, $8e, $01, $00, $50, $20 ; id 1
    dw $00b2
    db $52, $05
    db $03, $8e, $00, $00, $70, $30 ; id 2
    dw $ffff
    db $53, $05
    db $03, $8e, $00, $00, $10, $50 ; id 3
    dw $ffff
    db $53, $05
    db $03, $8e, $00, $00, $50, $50 ; id 4
    dw $ffff
    db $53, $05
    db $03, $8e, $00, $00, $70, $50 ; id 5
    dw $ffff
    db $53, $05
    db $03, $8e, $00, $00, $50, $70 ; id 6
    dw $ffff
    db $53, $05
    db $03, $8e, $00, $00, $10, $80 ; id 7
    dw $ffff
    db $53, $05
    db $03, $8e, $01, $00, $20, $30 ; id 8
    dw $ffff
    db $53, $05
    db $03, $8e, $01, $00, $20, $50 ; id 9
    dw $ffff
    db $53, $05
    db $03, $8e, $01, $00, $70, $50 ; id 10
    dw $ffff
    db $53, $05
    db $03, $8e, $01, $00, $20, $70 ; id 11
    dw $ffff
    db $53, $05
    db $03, $8e, $01, $00, $70, $70 ; id 12
    dw $ffff
    db $53, $05
    db $03, $8e, $02, $00, $20, $30 ; id 13
    dw $ffff
    db $53, $05
    db $03, $8e, $02, $00, $40, $30 ; id 14
    dw $ffff
    db $53, $05
    db $03, $8e, $02, $00, $40, $50 ; id 15
    dw $ffff
    db $53, $05
    db $03, $8e, $02, $00, $20, $70 ; id 16
    dw $ffff
    db $53, $05
    db $03, $8e, $02, $00, $40, $70 ; id 17
    dw $ffff
    db $53, $05
    db $03, $8e, $00, $01, $50, $30 ; id 18
    dw $ffff
    db $53, $05
    db $03, $8e, $00, $01, $70, $30 ; id 19
    dw $ffff
    db $53, $05
    db $03, $8e, $00, $01, $10, $50 ; id 20
    dw $ffff
    db $53, $05
    db $03, $8e, $00, $01, $70, $50 ; id 21
    dw $ffff
    db $53, $05
    db $03, $8e, $00, $01, $70, $70 ; id 22
    dw $ffff
    db $53, $05
    db $03, $8e, $00, $01, $10, $80 ; id 23
    dw $ffff
    db $53, $05
    db $03, $8e, $01, $01, $20, $30 ; id 24
    dw $ffff
    db $53, $05
    db $03, $8e, $01, $01, $70, $30 ; id 25
    dw $ffff
    db $53, $05
    db $03, $8e, $01, $01, $70, $50 ; id 26
    dw $ffff
    db $53, $05
    db $03, $8e, $01, $01, $20, $70 ; id 27
    dw $ffff
    db $53, $05
    db $03, $8e, $02, $01, $20, $30 ; id 28
    dw $ffff
    db $53, $05
    db $03, $8e, $02, $01, $20, $50 ; id 29
    dw $ffff
    db $53, $05
    db $03, $8e, $02, $01, $40, $30 ; id 30
    dw $ffff
    db $53, $05
    db $03, $8e, $02, $01, $40, $50 ; id 31
    dw $ffff
    db $53, $05
    db $03, $8e, $02, $01, $20, $70 ; id 32
    dw $ffff
    db $53, $05
    db $03, $8e, $02, $01, $80, $80 ; id 33
    dw $ffff
    db $53, $05
    db $03, $8e, $00, $02, $10, $20 ; id 34
    dw $ffff
    db $53, $05
    db $03, $8e, $00, $02, $30, $50 ; id 35
    dw $ffff
    db $53, $05
    db $03, $8e, $02, $02, $80, $20 ; id 36
    dw $ffff
    db $53, $05
    db $03, $8e, $02, $02, $80, $50 ; id 37
    dw $ffff
    db $53, $05
    db $01, $8e, $02, $01, $20, $50 ; id 38
    dw $ffff
    db $54, $05
    db $01, $8e, $00, $00, $10, $30 ; id 39
    dw $ffff
    db $5e, $05
    db $01, $8e, $00, $00, $50, $30 ; id 40
    dw $ffff
    db $5e, $05
    db $01, $8e, $00, $00, $70, $30 ; id 41
    dw $ffff
    db $5e, $05
    db $01, $8e, $00, $00, $50, $50 ; id 42
    dw $ffff
    db $5e, $05
    db $01, $8e, $00, $00, $10, $60 ; id 43
    dw $ffff
    db $5e, $05
    db $01, $8e, $01, $00, $20, $30 ; id 44
    dw $ffff
    db $5e, $05
    db $01, $8e, $01, $00, $70, $30 ; id 45
    dw $ffff
    db $5e, $05
    db $01, $8e, $01, $00, $20, $50 ; id 46
    dw $ffff
    db $5e, $05
    db $01, $8e, $01, $00, $70, $50 ; id 47
    dw $ffff
    db $5e, $05
    db $01, $8e, $00, $01, $50, $10 ; id 48
    dw $ffff
    db $5e, $05
    db $01, $8e, $00, $01, $70, $10 ; id 49
    dw $ffff
    db $5e, $05
    db $01, $8e, $00, $01, $10, $30 ; id 50
    dw $ffff
    db $5e, $05
    db $01, $8e, $00, $01, $70, $30 ; id 51
    dw $ffff
    db $5e, $05
    db $01, $8e, $00, $01, $70, $50 ; id 52
    dw $ffff
    db $5e, $05
    db $01, $8e, $00, $01, $10, $60 ; id 53
    dw $ffff
    db $5e, $05
    db $01, $8e, $01, $01, $20, $10 ; id 54
    dw $ffff
    db $5e, $05
    db $01, $8e, $01, $01, $70, $10 ; id 55
    dw $ffff
    db $5e, $05
    db $01, $8e, $01, $01, $70, $30 ; id 56
    dw $ffff
    db $5e, $05
    db $01, $8e, $01, $01, $20, $50 ; id 57
    dw $ffff
    db $5e, $05
    db $01, $8e, $02, $01, $20, $10 ; id 58
    dw $ffff
    db $5e, $05
    db $01, $8e, $02, $01, $40, $10 ; id 59
    dw $ffff
    db $5e, $05
    db $01, $8e, $02, $01, $20, $30 ; id 60
    dw $ffff
    db $5e, $05
    db $01, $8e, $02, $01, $40, $30 ; id 61
    dw $ffff
    db $5e, $05
    db $01, $8e, $02, $01, $80, $60 ; id 62
    dw $ffff
    db $5e, $05
    db $01, $8e, $00, $02, $10, $00 ; id 63
    dw $ffff
    db $5e, $05
    db $01, $8e, $00, $02, $20, $30 ; id 64
    dw $ffff
    db $5e, $05
    db $01, $8e, $00, $02, $30, $30 ; id 65
    dw $ffff
    db $5e, $05
    db $01, $8e, $00, $02, $30, $60 ; id 66
    dw $ffff
    db $5e, $05
    db $01, $8e, $00, $02, $60, $60 ; id 67
    dw $ffff
    db $5e, $05
    db $01, $8e, $00, $02, $80, $60 ; id 68
    dw $ffff
    db $5e, $05
    db $01, $8e, $01, $02, $10, $60 ; id 69
    dw $ffff
    db $5e, $05
    db $01, $8e, $01, $02, $30, $60 ; id 70
    dw $ffff
    db $5e, $05
    db $01, $8e, $01, $02, $80, $60 ; id 71
    dw $ffff
    db $5e, $05
    db $01, $8e, $02, $02, $80, $00 ; id 72
    dw $ffff
    db $5e, $05
    db $01, $8e, $02, $02, $80, $30 ; id 73
    dw $ffff
    db $5e, $05
    db $01, $8e, $02, $02, $10, $60 ; id 74
    dw $ffff
    db $5e, $05
    db $ff ; end

; list for entry $8F of MapInteractionTable; 6 record(s), then $FF (E-0157)
MapInteractions8F::
    db $03, $8f, $00, $00, $10, $10 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $00b1 ; story flag that disables the entry ($FFFF = none)
    db $50, $05 ; talk event group, index
    db $03, $8f, $00, $00, $20, $10 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $00b1 ; story flag that disables the entry ($FFFF = none)
    db $50, $05 ; talk event group, index
    db $03, $8f, $00, $00, $50, $70 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $00b1 ; story flag that disables the entry ($FFFF = none)
    db $51, $05 ; talk event group, index
    db $03, $8f, $00, $00, $60, $70 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $00b1 ; story flag that disables the entry ($FFFF = none)
    db $51, $05 ; talk event group, index
    db $03, $8f, $00, $00, $70, $70 ; id 4: kind, map, screen X, screen Y, player X, player Y
    dw $00b1 ; story flag that disables the entry ($FFFF = none)
    db $51, $05 ; talk event group, index
    db $03, $8f, $00, $00, $80, $70 ; id 5: kind, map, screen X, screen Y, player X, player Y
    dw $00b1 ; story flag that disables the entry ($FFFF = none)
    db $51, $05 ; talk event group, index
    db $ff ; end

; list for entry $91 of MapInteractionTable; 1 record(s), then $FF (E-0157)
MapInteractions91::
    db $03, $91, $00, $00, $40, $30 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $56, $05 ; talk event group, index
    db $ff ; end

; list for entry $94 of MapInteractionTable; 3 record(s), then $FF (E-0157)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X,
; player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions94::
    db $05, $94, $02, $00, $40, $40 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $62, $05 ; talk event group, index
    db $05, $94, $01, $02, $20, $30 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $63, $05 ; talk event group, index
    db $05, $94, $02, $02, $70, $30 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $63, $05 ; talk event group, index
    db $ff ; end

; list for entry $96 of MapInteractionTable; 1 record(s), then $FF (E-0157)
MapInteractions96::
    db $05, $96, $00, $00, $40, $40 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $64, $05 ; talk event group, index
    db $ff ; end

; list for entry $98 of MapInteractionTable; 1 record(s), then $FF (E-0157)
MapInteractions98::
    db $05, $98, $00, $00, $10, $60 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $65, $05 ; talk event group, index
    db $ff ; end

; list for entry $9A of MapInteractionTable; 1 record(s), then $FF (E-0157)
MapInteractions9A::
    db $05, $9a, $00, $00, $80, $70 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $66, $05 ; talk event group, index
    db $ff ; end

; list for entry $9B of MapInteractionTable; 8 record(s), then $FF (E-0157)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X,
; player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions9B::
    db $03, $9b, $00, $01, $40, $30 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $00c1 ; story flag that disables the entry ($FFFF = none)
    db $67, $05 ; talk event group, index
    db $03, $9b, $00, $01, $50, $30 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $00c1 ; story flag that disables the entry ($FFFF = none)
    db $67, $05 ; talk event group, index
    db $05, $9b, $00, $00, $20, $20 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $70, $05 ; talk event group, index
    db $03, $9b, $00, $00, $30, $20 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $70, $05 ; talk event group, index
    db $03, $9b, $00, $00, $40, $20 ; id 4: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $70, $05 ; talk event group, index
    db $03, $9b, $00, $00, $50, $20 ; id 5: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $70, $05 ; talk event group, index
    db $03, $9b, $00, $00, $60, $20 ; id 6: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $70, $05 ; talk event group, index
    db $05, $9b, $00, $00, $70, $20 ; id 7: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $70, $05 ; talk event group, index
    db $ff ; end

; list for entry $A3 of MapInteractionTable; 2 record(s), then $FF (E-0157)
MapInteractionsA3::
    db $03, $a3, $00, $00, $40, $40 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $00d1 ; story flag that disables the entry ($FFFF = none)
    db $01, $06 ; talk event group, index
    db $03, $a3, $00, $00, $50, $40 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $00d1 ; story flag that disables the entry ($FFFF = none)
    db $01, $06 ; talk event group, index
    db $ff ; end

; list for entry $A9 of MapInteractionTable; 7 record(s), then $FF (E-0157)
MapInteractionsA9::
    db $03, $a9, $00, $00, $20, $70 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $13, $07 ; talk event group, index
    db $05, $a9, $00, $00, $30, $60 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $14, $07 ; talk event group, index
    db $03, $a9, $01, $00, $10, $20 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $15, $07 ; talk event group, index
    db $04, $a9, $00, $01, $40, $20 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $16, $07 ; talk event group, index
    db $05, $a9, $00, $01, $30, $30 ; id 4: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $16, $07 ; talk event group, index
    db $03, $a9, $00, $01, $10, $40 ; id 5: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $16, $07 ; talk event group, index
    db $05, $a9, $01, $01, $80, $30 ; id 6: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $1b, $07 ; talk event group, index
    db $ff ; end

; list for entry $AB of MapInteractionTable; 1 record(s), then $FF (E-0157)
MapInteractionsAB::
    db $05, $ab, $00, $00, $70, $20 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $17, $07 ; talk event group, index
    db $ff ; end

; list for entry $AD of MapInteractionTable; 1 record(s), then $FF (E-0157)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X,
; player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractionsAD::
    db $05, $ad, $00, $00, $60, $40 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $18, $07 ; talk event group, index
    db $ff ; end

; list for entry $AE of MapInteractionTable; 2 record(s), then $FF (E-0157)
MapInteractionsAE::
    db $05, $ae, $00, $02, $60, $40 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $19, $07 ; talk event group, index
    db $05, $ae, $02, $03, $80, $20 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $1a, $07 ; talk event group, index
    db $ff ; end

; list for entry $B1 of MapInteractionTable; 4 record(s), then $FF (E-0157)
MapInteractionsB1::
    db $03, $b1, $00, $00, $60, $10 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $22, $07 ; talk event group, index
    db $03, $b1, $00, $00, $70, $10 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $23, $07 ; talk event group, index
    db $05, $b1, $00, $00, $10, $50 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $24, $07 ; talk event group, index
    db $05, $b1, $00, $00, $20, $50 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $25, $07 ; talk event group, index
    db $ff ; end

; list for entry $B6 of MapInteractionTable; 8 record(s), then $FF (E-0157)
MapInteractionsB6::
    db $05, $b6, $00, $00, $50, $20 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $2e, $07 ; talk event group, index
    db $05, $b6, $00, $00, $20, $30 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $29, $07 ; talk event group, index
    db $05, $b6, $00, $00, $60, $30 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $2a, $07 ; talk event group, index
    db $05, $b6, $00, $00, $30, $40 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $28, $07 ; talk event group, index
    db $05, $b6, $00, $00, $70, $40 ; id 4: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $2c, $07 ; talk event group, index
    db $05, $b6, $00, $00, $10, $50 ; id 5: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $27, $07 ; talk event group, index
    db $05, $b6, $00, $00, $60, $60 ; id 6: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $26, $07 ; talk event group, index
    db $05, $b6, $00, $00, $20, $70 ; id 7: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $2b, $07 ; talk event group, index
    db $ff ; end

; list for entry $B9 of MapInteractionTable; 5 record(s), then $FF (E-0157)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X,
; player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractionsB9::
    db $04, $b9, $00, $00, $40, $10 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $49, $07 ; talk event group, index
    db $05, $b9, $01, $01, $80, $70 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $4a, $07 ; talk event group, index
    db $03, $b9, $01, $00, $30, $30 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $4b, $07 ; talk event group, index
    db $03, $b9, $01, $00, $50, $30 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $4b, $07 ; talk event group, index
    db $04, $b9, $00, $01, $30, $30 ; id 4: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $4c, $07 ; talk event group, index
    db $ff ; end

; list for entry $BA of MapInteractionTable; 4 record(s), then $FF (E-0157)
MapInteractionsBA::
    db $03, $ba, $00, $00, $70, $50 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $4d, $07 ; talk event group, index
    db $05, $ba, $00, $01, $70, $50 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $4d, $07 ; talk event group, index
    db $02, $ba, $00, $01, $60, $60 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $4e, $07 ; talk event group, index
    db $05, $ba, $00, $01, $70, $10 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $4f, $07 ; talk event group, index
    db $ff ; end

; list for entry $BB of MapInteractionTable; 1 record(s), then $FF (E-0157)
MapInteractionsBB::
    db $03, $bb, $00, $00, $40, $10 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $01c0 ; story flag that disables the entry ($FFFF = none)
    db $2f, $07 ; talk event group, index
    db $ff ; end

; list for entry $BC of MapInteractionTable; 2 record(s), then $FF (E-0157)
MapInteractionsBC::
    db $03, $bc, $00, $00, $30, $40 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $3d, $07 ; talk event group, index
    db $04, $bc, $00, $00, $50, $20 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $3d, $07 ; talk event group, index
    db $ff ; end

; list for entry $BE of MapInteractionTable; 1 record(s), then $FF (E-0157)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X,
; player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractionsBE::
    db $05, $be, $00, $00, $50, $30 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $50, $07 ; talk event group, index
    db $ff ; end

; list for entry $BF of MapInteractionTable; 1 record(s), then $FF (E-0157)
MapInteractionsBF::
    db $05, $bf, $01, $00, $70, $20 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $51, $07 ; talk event group, index
    db $ff ; end

; list for entry $C0 of MapInteractionTable; 1 record(s), then $FF (E-0157)
MapInteractionsC0::
    db $05, $c0, $00, $01, $10, $70 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $52, $07 ; talk event group, index
    db $ff ; end

; list for entry $C2 of MapInteractionTable; 1 record(s), then $FF (E-0157)
MapInteractionsC2::
    db $05, $c2, $01, $01, $40, $30 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $53, $07 ; talk event group, index
    db $ff ; end

; list for entry $C4 of MapInteractionTable; 5 record(s), then $FF (E-0157)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X,
; player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractionsC4::
    db $05, $c4, $00, $00, $30, $60 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $54, $07 ; talk event group, index
    db $05, $c4, $00, $00, $20, $30 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $01cf ; story flag that disables the entry ($FFFF = none)
    db $55, $07 ; talk event group, index
    db $05, $c4, $00, $00, $40, $40 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $01d0 ; story flag that disables the entry ($FFFF = none)
    db $55, $07 ; talk event group, index
    db $05, $c4, $00, $00, $50, $20 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $01d1 ; story flag that disables the entry ($FFFF = none)
    db $55, $07 ; talk event group, index
    db $05, $c4, $00, $00, $80, $50 ; id 4: kind, map, screen X, screen Y, player X, player Y
    dw $01d2 ; story flag that disables the entry ($FFFF = none)
    db $55, $07 ; talk event group, index
    db $ff ; end

; list for entry $CA of MapInteractionTable; 4 record(s), then $FF (E-0157)
MapInteractionsCA::
    db $05, $ca, $00, $00, $10, $20 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $68, $07 ; talk event group, index
    db $05, $ca, $00, $00, $30, $10 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $69, $07 ; talk event group, index
    db $05, $ca, $00, $00, $60, $10 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $78, $07 ; talk event group, index
    db $05, $ca, $00, $00, $80, $20 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $6a, $07 ; talk event group, index
    db $ff ; end

; list for entry $CB of MapInteractionTable; 4 record(s), then $FF (E-0157)
MapInteractionsCB::
    db $05, $cb, $00, $00, $10, $20 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $6b, $07 ; talk event group, index
    db $05, $cb, $00, $00, $30, $10 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $6c, $07 ; talk event group, index
    db $05, $cb, $00, $00, $60, $10 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $6d, $07 ; talk event group, index
    db $05, $cb, $00, $00, $80, $20 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $78, $07 ; talk event group, index
    db $ff ; end

; list for entry $CC of MapInteractionTable; 4 record(s), then $FF (E-0157)
MapInteractionsCC::
    db $05, $cc, $00, $00, $10, $20 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $78, $07 ; talk event group, index
    db $05, $cc, $00, $00, $30, $10 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $6e, $07 ; talk event group, index
    db $05, $cc, $00, $00, $60, $10 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $6f, $07 ; talk event group, index
    db $05, $cc, $00, $00, $80, $20 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $70, $07 ; talk event group, index
    db $ff ; end

; list for entry $CD of MapInteractionTable; 4 record(s), then $FF (E-0157)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X,
; player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractionsCD::
    db $05, $cd, $00, $00, $10, $20 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $71, $07 ; talk event group, index
    db $05, $cd, $00, $00, $30, $10 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $72, $07 ; talk event group, index
    db $05, $cd, $00, $00, $60, $10 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $73, $07 ; talk event group, index
    db $05, $cd, $00, $00, $80, $20 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $78, $07 ; talk event group, index
    db $ff ; end

; list for entry $CE of MapInteractionTable; 4 record(s), then $FF (E-0157)
MapInteractionsCE::
    db $05, $ce, $00, $00, $20, $40 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $74, $07 ; talk event group, index
    db $05, $ce, $00, $00, $30, $30 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $75, $07 ; talk event group, index
    db $05, $ce, $00, $00, $60, $30 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $76, $07 ; talk event group, index
    db $05, $ce, $00, $00, $70, $40 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $77, $07 ; talk event group, index
    db $ff ; end

; list for entry $D3 of MapInteractionTable; 4 record(s), then $FF (E-0157)
MapInteractionsD3::
    db $05, $d3, $00, $00, $10, $20 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $88, $07 ; talk event group, index
    db $05, $d3, $00, $00, $30, $10 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $89, $07 ; talk event group, index
    db $05, $d3, $00, $00, $60, $10 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $8a, $07 ; talk event group, index
    db $05, $d3, $00, $00, $80, $20 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $78, $07 ; talk event group, index
    db $ff ; end

; list for entry $D4 of MapInteractionTable; 4 record(s), then $FF (E-0157)
MapInteractionsD4::
    db $05, $d4, $00, $00, $10, $20 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $78, $07 ; talk event group, index
    db $05, $d4, $00, $00, $30, $10 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $8b, $07 ; talk event group, index
    db $05, $d4, $00, $00, $60, $10 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $8c, $07 ; talk event group, index
    db $05, $d4, $00, $00, $80, $20 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $8d, $07 ; talk event group, index
    db $ff ; end

; list for entry $D5 of MapInteractionTable; 4 record(s), then $FF (E-0157)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X,
; player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractionsD5::
    db $05, $d5, $00, $00, $10, $20 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $78, $07 ; talk event group, index
    db $05, $d5, $00, $00, $30, $10 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $8e, $07 ; talk event group, index
    db $05, $d5, $00, $00, $60, $10 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $8f, $07 ; talk event group, index
    db $05, $d5, $00, $00, $80, $20 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $90, $07 ; talk event group, index
    db $ff ; end

; list for entry $D6 of MapInteractionTable; 4 record(s), then $FF (E-0157)
MapInteractionsD6::
    db $05, $d6, $00, $00, $10, $20 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $78, $07 ; talk event group, index
    db $05, $d6, $00, $00, $30, $10 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $91, $07 ; talk event group, index
    db $05, $d6, $00, $00, $60, $10 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $92, $07 ; talk event group, index
    db $05, $d6, $00, $00, $80, $20 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $93, $07 ; talk event group, index
    db $ff ; end

; list for entry $D7 of MapInteractionTable; 4 record(s), then $FF (E-0157)
MapInteractionsD7::
    db $05, $d7, $00, $00, $20, $40 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $94, $07 ; talk event group, index
    db $05, $d7, $00, $00, $30, $30 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $95, $07 ; talk event group, index
    db $05, $d7, $00, $00, $60, $30 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $96, $07 ; talk event group, index
    db $05, $d7, $00, $00, $70, $40 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $97, $07 ; talk event group, index
    db $ff ; end

; list for entry $DC of MapInteractionTable; 4 record(s), then $FF (E-0157)
MapInteractionsDC::
    db $05, $dc, $00, $00, $10, $20 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $78, $07 ; talk event group, index
    db $05, $dc, $00, $00, $30, $10 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $a8, $07 ; talk event group, index
    db $05, $dc, $00, $00, $60, $10 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $a9, $07 ; talk event group, index
    db $05, $dc, $00, $00, $80, $20 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $aa, $07 ; talk event group, index
    db $ff ; end

; list for entry $DD of MapInteractionTable; 4 record(s), then $FF (E-0157)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X,
; player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractionsDD::
    db $05, $dd, $00, $00, $10, $20 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $ab, $07 ; talk event group, index
    db $05, $dd, $00, $00, $30, $10 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $ac, $07 ; talk event group, index
    db $05, $dd, $00, $00, $60, $10 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $ad, $07 ; talk event group, index
    db $05, $dd, $00, $00, $80, $20 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $78, $07 ; talk event group, index
    db $ff ; end

; list for entry $DE of MapInteractionTable; 4 record(s), then $FF (E-0157)
MapInteractionsDE::
    db $05, $de, $00, $00, $10, $20 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $78, $07 ; talk event group, index
    db $05, $de, $00, $00, $30, $10 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $ae, $07 ; talk event group, index
    db $05, $de, $00, $00, $60, $10 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $af, $07 ; talk event group, index
    db $05, $de, $00, $00, $80, $20 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $b0, $07 ; talk event group, index
    db $ff ; end

; list for entry $DF of MapInteractionTable; 4 record(s), then $FF (E-0157)
MapInteractionsDF::
    db $05, $df, $00, $00, $10, $20 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $78, $07 ; talk event group, index
    db $05, $df, $00, $00, $30, $10 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $b1, $07 ; talk event group, index
    db $05, $df, $00, $00, $60, $10 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $b2, $07 ; talk event group, index
    db $05, $df, $00, $00, $80, $20 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $b3, $07 ; talk event group, index
    db $ff ; end

; list for entry $E0 of MapInteractionTable; 4 record(s), then $FF (E-0157)
MapInteractionsE0::
    db $05, $e0, $00, $00, $20, $40 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $b4, $07 ; talk event group, index
    db $05, $e0, $00, $00, $30, $30 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $b5, $07 ; talk event group, index
    db $05, $e0, $00, $00, $60, $30 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $b6, $07 ; talk event group, index
    db $05, $e0, $00, $00, $70, $40 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $b7, $07 ; talk event group, index
    db $ff ; end

; The interaction list CheckMapInteractionOnA_KeyWorldFloor returns for map type $83 when the
; floor's wKeyWorldFloorInfo + $1 byte is 2: nine 10-byte entries (kind, map, screen X, screen Y,
; player X, player Y; story flag $FFFF; talk event group, index) ending with $FF, all on map 0, with
; talk event index 9 (DispatchTalkEvent_KeyWorld) and groups 2, 4 and 6. (C1, E-0372); E-0170 (C1:
; CheckMapInteractionOnA_KeyWorldFloor returns this list for map type $83 when the floor info byte
; is 2; the same 10-byte entries as MapInteractionTable's lists, ending with $FF). (named from its
; reading, E-0372; was CheckMapInteractionOnA_KeyWorldFloor_SpecialMapInteractions)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X,
; player Y; story flag ($FFFF = none; set = skip); talk event group, index
KeyWorldFloorKind2Interactions::
    db $05, $00, $00, $00, $50, $40 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $06, $09 ; talk event group, index
    db $05, $00, $00, $00, $30, $70 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $04, $09 ; talk event group, index
    db $05, $00, $01, $00, $70, $40 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $06, $09 ; talk event group, index
    db $05, $00, $01, $01, $80, $50 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $04, $09 ; talk event group, index
    db $04, $00, $00, $00, $40, $20 ; id 4: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $02, $09 ; talk event group, index
    db $03, $00, $00, $00, $20, $40 ; id 5: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $02, $09 ; talk event group, index
    db $02, $00, $00, $00, $10, $20 ; id 6: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $02, $09 ; talk event group, index
    db $03, $00, $00, $00, $30, $40 ; id 7: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $02, $09 ; talk event group, index
    db $02, $00, $01, $00, $50, $10 ; id 8: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $02, $09 ; talk event group, index
    db $ff ; end

; The list for map type $83 when the floor's wKeyWorldFloorInfo + $1 byte is 3: four 10-byte entries
; in the MapInteractionTable layout, ending with $FF, all kind 5 on map 0, with talk event index 9
; and groups 4 and 5. (C1, E-0372); E-0170 (C1: CheckMapInteractionOnA_KeyWorldFloor returns this
; list for map type $83 when that byte is 3; the same 10-byte entries as MapInteractionTable's
; lists, ending with $FF). (named from its reading, E-0372; was
; CheckMapInteractionOnA_KeyWorldFloor_SpecialMapInteractions_2)
KeyWorldFloorKind3Interactions::
    db $05, $00, $00, $00, $40, $30 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $04, $09 ; talk event group, index
    db $05, $00, $00, $00, $60, $30 ; id 1: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $05, $09 ; talk event group, index
    db $05, $00, $00, $00, $80, $30 ; id 2: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $04, $09 ; talk event group, index
    db $05, $00, $01, $00, $10, $20 ; id 3: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $04, $09 ; talk event group, index
    db $ff ; end

; The list CheckMapInteractionOnA_KeyWorldFloor returns for map type $84: one 10-byte entry (kind 3,
; map 0, screen (0, 0), player ($30, $40); talk event group 7, index 9) and the $FF end. (C1,
; E-0372); E-0170 (C1: CheckMapInteractionOnA_KeyWorldFloor returns this list for map type $84; the
; same 10-byte entries as MapInteractionTable's lists, ending with $FF). (named from its reading,
; E-0372; was CheckMapInteractionOnA_KeyWorldFloor_SpecialMapInteractions_3)
MapType84Interactions::
    db $03, $00, $00, $00, $30, $40 ; id 0: kind, map, screen X, screen Y, player X, player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $07, $09 ; talk event group, index
    db $ff ; end

; list for entry $00 of MapStepTriggerTable; 2 record(s), then $FF (E-0157)
; record: 0 (other values: skipped), map number, screen X, screen Y, player X ($FF = anywhere on the
; screen), player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapStepTriggers00::
    db $00, $00, $01, $01, $ff, $ff ; id 0: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $0015 ; story flag that disables the entry ($FFFF = none)
    db $01, $0a ; talk event group, index
    db $00, $00, $00, $03, $ff, $ff ; id 1: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $e4, $01 ; talk event group, index
    db $ff ; end

; list for entry $01 of MapStepTriggerTable; 4 record(s), then $FF (E-0157)
MapStepTriggers01::
    db $00, $01, $01, $01, $30, $48 ; id 0: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $e7, $01 ; talk event group, index
    db $00, $01, $01, $01, $ff, $ff ; id 1: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $0138 ; story flag that disables the entry ($FFFF = none)
    db $d1, $01 ; talk event group, index
    db $00, $01, $01, $00, $ff, $ff ; id 2: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $f4, $01 ; talk event group, index
    db $00, $01, $02, $02, $ff, $ff ; id 3: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $0187 ; story flag that disables the entry ($FFFF = none)
    db $f6, $01 ; talk event group, index
    db $ff ; end

; list for entry $02 of MapStepTriggerTable; 2 record(s), then $FF (E-0157)
MapStepTriggers02::
    db $00, $02, $02, $00, $ff, $ff ; id 0: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $0005 ; story flag that disables the entry ($FFFF = none)
    db $04, $0a ; talk event group, index
    db $00, $02, $00, $00, $ff, $ff ; id 1: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $0006 ; story flag that disables the entry ($FFFF = none)
    db $05, $0a ; talk event group, index
    db $ff ; end

; list for entry $04 of MapStepTriggerTable; 2 record(s), then $FF (E-0157)
MapStepTriggers04::
    db $00, $04, $00, $00, $50, $50 ; id 0: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $25, $00 ; talk event group, index
    db $00, $04, $01, $00, $ff, $ff ; id 1: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $26, $00 ; talk event group, index
    db $ff ; end

; list for entry $05 of MapStepTriggerTable; 3 record(s), then $FF (E-0157)
; record: 0 (other values: skipped), map number, screen X, screen Y, player X ($FF = anywhere on the
; screen), player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapStepTriggers05::
    db $00, $05, $01, $00, $ff, $ff ; id 0: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $000b ; story flag that disables the entry ($FFFF = none)
    db $06, $0a ; talk event group, index
    db $00, $05, $01, $00, $00, $40 ; id 1: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $0002 ; story flag that disables the entry ($FFFF = none)
    db $1a, $0a ; talk event group, index
    db $00, $05, $01, $00, $90, $40 ; id 2: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $0002 ; story flag that disables the entry ($FFFF = none)
    db $1a, $0a ; talk event group, index
    db $ff ; end

; list for entry $0C of MapStepTriggerTable; 3 record(s), then $FF (E-0157)
MapStepTriggers0C::
    db $00, $0c, $00, $00, $20, $10 ; id 0: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $01, $01 ; talk event group, index
    db $00, $0c, $00, $00, $70, $10 ; id 1: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $01, $01 ; talk event group, index
    db $00, $0c, $01, $00, $ff, $ff ; id 2: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $f5, $01 ; talk event group, index
    db $ff ; end

; list for entry $19 of MapStepTriggerTable; 1 record(s), then $FF (E-0157)
MapStepTriggers19::
    db $00, $19, $00, $02, $40, $00 ; id 0: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $f3, $01 ; talk event group, index
    db $ff ; end

; list for entry $1A of MapStepTriggerTable; 1 record(s), then $FF (E-0157)
MapStepTriggers1A::
    db $00, $1a, $01, $00, $ff, $ff ; id 0: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $0025 ; story flag that disables the entry ($FFFF = none)
    db $9e, $01 ; talk event group, index
    db $ff ; end

; list for entry $20 of MapStepTriggerTable; 1 record(s), then $FF (E-0157)
; record: 0 (other values: skipped), map number, screen X, screen Y, player X ($FF = anywhere on the
; screen), player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapStepTriggers20::
    db $00, $20, $05, $05, $ff, $ff ; id 0: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $44, $02 ; talk event group, index
    db $ff ; end

; list for entry $2A of MapStepTriggerTable; 1 record(s), then $FF (E-0157)
MapStepTriggers2A::
    db $00, $2a, $00, $00, $ff, $ff ; id 0: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $004a ; story flag that disables the entry ($FFFF = none)
    db $2e, $02 ; talk event group, index
    db $ff ; end

; list for entry $2F of MapStepTriggerTable; 3 record(s), then $FF (E-0157)
MapStepTriggers2F::
    db $00, $2f, $00, $01, $ff, $ff ; id 0: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $0058 ; story flag that disables the entry ($FFFF = none)
    db $29, $02 ; talk event group, index
    db $00, $2f, $01, $00, $40, $30 ; id 1: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $43, $02 ; talk event group, index
    db $00, $2f, $01, $00, $50, $30 ; id 2: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $43, $02 ; talk event group, index
    db $ff ; end

; list for entry $33 of MapStepTriggerTable; 1 record(s), then $FF (E-0157)
MapStepTriggers33::
    db $00, $33, $00, $01, $40, $70 ; id 0: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $0064 ; story flag that disables the entry ($FFFF = none)
    db $2f, $03 ; talk event group, index
    db $ff ; end

; list for entry $38 of MapStepTriggerTable; 2 record(s), then $FF (E-0157)
; record: 0 (other values: skipped), map number, screen X, screen Y, player X ($FF = anywhere on the
; screen), player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapStepTriggers38::
    db $00, $38, $00, $00, $e0, $00 ; id 0: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $00, $0a ; talk event group, index
    db $00, $38, $02, $03, $ff, $ff ; id 1: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $007b ; story flag that disables the entry ($FFFF = none)
    db $50, $03 ; talk event group, index
    db $ff ; end

; list for entry $39 of MapStepTriggerTable; 1 record(s), then $FF (E-0157)
MapStepTriggers39::
    db $00, $39, $01, $01, $ff, $ff ; id 0: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $007c ; story flag that disables the entry ($FFFF = none)
    db $51, $03 ; talk event group, index
    db $ff ; end

; list for entry $3A of MapStepTriggerTable; 1 record(s), then $FF (E-0157)
MapStepTriggers3A::
    db $00, $3a, $01, $00, $60, $60 ; id 0: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $007e ; story flag that disables the entry ($FFFF = none)
    db $52, $03 ; talk event group, index
    db $ff ; end

; list for entry $3B of MapStepTriggerTable; 1 record(s), then $FF (E-0157)
MapStepTriggers3B::
    db $00, $3b, $00, $00, $ff, $ff ; id 0: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $005f ; story flag that disables the entry ($FFFF = none)
    db $53, $03 ; talk event group, index
    db $ff ; end

; list for entry $4C of MapStepTriggerTable; 1 record(s), then $FF (E-0157)
; record: 0 (other values: skipped), map number, screen X, screen Y, player X ($FF = anywhere on the
; screen), player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapStepTriggers4C::
    db $00, $4c, $00, $00, $ff, $ff ; id 0: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $008b ; story flag that disables the entry ($FFFF = none)
    db $4c, $04 ; talk event group, index
    db $ff ; end

; list for entry $5B of MapStepTriggerTable; 1 record(s), then $FF (E-0157)
MapStepTriggers5B::
    db $00, $5b, $01, $00, $ff, $ff ; id 0: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $0096 ; story flag that disables the entry ($FFFF = none)
    db $70, $04 ; talk event group, index
    db $ff ; end

; list for entry $5D of MapStepTriggerTable; 2 record(s), then $FF (E-0157)
MapStepTriggers5D::
    db $00, $5d, $02, $01, $ff, $ff ; id 0: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $0098 ; story flag that disables the entry ($FFFF = none)
    db $98, $04 ; talk event group, index
    db $00, $5d, $02, $02, $ff, $ff ; id 1: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $0099 ; story flag that disables the entry ($FFFF = none)
    db $98, $04 ; talk event group, index
    db $ff ; end

; list for entry $67 of MapStepTriggerTable; 2 record(s), then $FF (E-0157)
MapStepTriggers67::
    db $00, $67, $00, $00, $40, $20 ; id 0: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $81, $04 ; talk event group, index
    db $00, $67, $00, $00, $50, $20 ; id 1: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $81, $04 ; talk event group, index
    db $ff ; end

; list for entry $76 of MapStepTriggerTable; 1 record(s), then $FF (E-0157)
; record: 0 (other values: skipped), map number, screen X, screen Y, player X ($FF = anywhere on the
; screen), player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapStepTriggers76::
    db $00, $76, $00, $00, $ff, $ff ; id 0: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $00a4 ; story flag that disables the entry ($FFFF = none)
    db $14, $05 ; talk event group, index
    db $ff ; end

; list for entry $7A of MapStepTriggerTable; 1 record(s), then $FF (E-0157)
MapStepTriggers7A::
    db $00, $7a, $00, $01, $40, $80 ; id 0: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $00a8 ; story flag that disables the entry ($FFFF = none)
    db $29, $05 ; talk event group, index
    db $ff ; end

; list for entry $7F of MapStepTriggerTable; 1 record(s), then $FF (E-0157)
MapStepTriggers7F::
    db $00, $7f, $00, $00, $40, $10 ; id 0: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $72, $05 ; talk event group, index
    db $ff ; end

; list for entry $8D of MapStepTriggerTable; 4 record(s), then $FF (E-0157)
MapStepTriggers8D::
    db $00, $8d, $00, $00, $30, $30 ; id 0: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $00b0 ; story flag that disables the entry ($FFFF = none)
    db $4e, $05 ; talk event group, index
    db $00, $8d, $00, $00, $60, $30 ; id 1: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $00b0 ; story flag that disables the entry ($FFFF = none)
    db $4e, $05 ; talk event group, index
    db $00, $8d, $00, $00, $30, $60 ; id 2: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $00b0 ; story flag that disables the entry ($FFFF = none)
    db $4e, $05 ; talk event group, index
    db $00, $8d, $00, $00, $60, $60 ; id 3: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $00b0 ; story flag that disables the entry ($FFFF = none)
    db $4e, $05 ; talk event group, index
    db $ff ; end

; list for entry $92 of MapStepTriggerTable; 1 record(s), then $FF (E-0157)
; record: 0 (other values: skipped), map number, screen X, screen Y, player X ($FF = anywhere on the
; screen), player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapStepTriggers92::
    db $00, $92, $00, $00, $40, $40 ; id 0: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $72, $05 ; talk event group, index
    db $ff ; end

; list for entry $9B of MapStepTriggerTable; 1 record(s), then $FF (E-0157)
MapStepTriggers9B::
    db $00, $9b, $00, $00, $ff, $ff ; id 0: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $00c2 ; story flag that disables the entry ($FFFF = none)
    db $68, $05 ; talk event group, index
    db $ff ; end

; list for entry $AA of MapStepTriggerTable; 2 record(s), then $FF (E-0157)
MapStepTriggersAA::
    db $00, $aa, $00, $00, $ff, $ff ; id 0: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $0149 ; story flag that disables the entry ($FFFF = none)
    db $0c, $07 ; talk event group, index
    db $00, $aa, $00, $01, $ff, $ff ; id 1: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $ffff ; story flag that disables the entry ($FFFF = none)
    db $00, $07 ; talk event group, index
    db $ff ; end

; list for entry $AC of MapStepTriggerTable; 1 record(s), then $FF (E-0157)
MapStepTriggersAC::
    db $00, $ac, $00, $00, $ff, $ff ; id 0: 0, map, screen X, screen Y, player X ($FF = any), player Y
    dw $014f ; story flag that disables the entry ($FFFF = none)
    db $12, $07 ; talk event group, index
    db $ff ; end
    ds $20db, $00
