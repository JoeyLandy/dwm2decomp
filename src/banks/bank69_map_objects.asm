; ROM bank $69: map object lists and selectors
; The annotated listing of this bank is build/listing/bank69.asm.

SECTION "Bank 69", ROMX[$4000], BANK[$69]
    db $69

; clears the sprite slots; key-world maps set up their objects, other maps load the object list for
; hMapId (with a story-flag case on map $2F) (E-0131)
LoadMapObjectsForScreen::
    xor a
    ld [wSpriteSlotCount], a
    ld a, [wMapType]
    bit 7, a
    jr z, .check_map_id
    farcall SetupKeyWorldObjectsForMapType
    farcall RestoreSpriteSnapshot
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    ret

.check_map_id:
    ldh a, [hMapId]
    cp $2f
    jr nz, .read_map_id
    ldh a, [hMapScreenX]
    or a
    jr nz, .read_map_id
    ldh a, [hMapScreenY]
    cp $01
    jr nz, .read_map_id
    ld de, EVENT_SCENE_TREASURE_THEFT
    call TestFlagBit
    jr nc, .read_map_id
    ld de, $0058
    call TestFlagBit
    jr c, .read_map_id
    ld a, [wStoryFlags + $61]
    bit 3, a
    jr z, .read_map_id
    ld hl, MapObjects_7E1E
    jp .set_sprite_slot_count

.read_map_id:
    ldh a, [hMapId]
    ld l, a
    ld h, $00
    add hl, hl
    ld a, l
    add $74
    ld l, a
    ld a, h
    adc $41
    ld h, a
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a
    ld a, [wMapWidthScreens]
    sla a
    ld c, a
    ldh a, [hMapScreenY]
    call Multiply8
    ldh a, [hMapScreenX]
    sla a
    add_a_to_hl
    add hl, de
    ld a, [hli]
    ld e, a
    ld a, [hl]
    or e
    jr nz, .skip
    jp .call_restore_sprite_snapshot

.skip:
    ld a, [hl]
    ld d, a
    ld l, e
    ld h, d

.skip2:
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    cp $ff
    jr nz, .call_test_flag_bit
    ld a, e
    cp $ff
    jr nz, .cp_FE

.clear_sprite_slot_count:
    xor a
    ld [wSpriteSlotCount], a
    jp .call_restore_sprite_snapshot

.cp_FE:
    cp $fe
    jr z, .skip8
    cp $fd
    jr z, .skip6
    cp $fc
    jr z, .skip4
    cp $fb
    jr z, .skip3
    jr .clear_sprite_slot_count

.skip3:
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    call TestFlagBit
    jr nc, .next
    ld a, [hli]
    inc hl
    add_a_to_hl
    jr .skip2

.next:
    inc hl
    inc hl
    jr .skip2

.skip4:
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    call TestFlagBit
    jr nc, .skip5
    inc hl
    inc hl
    jr .skip2

.skip5:
    ld a, [hli]
    inc hl
    add_a_to_hl
    jr .skip2

.skip6:
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    call TestFlagBit
    jr nc, .skip7
    inc hl
    inc hl
    inc hl
    inc hl
    jr .skip2

.skip7:
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a

.call_test_flag_bit:
    call TestFlagBit
    jr nc, .skip8
    inc hl
    inc hl
    jr .skip2

.skip8:
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a
    ld l, e
    ld h, d

.set_sprite_slot_count:
    ld a, [hli]
    ld [wSpriteSlotCount], a
    ld b, a
    ld de, wSpriteSlots

.loop:
    push bc
    ld a, b
    ldh [hTempA], a
    xor a
    ldh [hTemp4], a
    ld a, [hli]
    ldh [hTemp5], a
    ld a, [hli]
    ldh [hTemp2], a
    inc de
    ld [de], a
    inc de
    ld a, [hli]
    ldh [hTemp0], a
    ld [de], a
    inc de
    ld a, [hli]
    ldh [hTemp1], a
    ld [de], a
    inc de
    push de
    ld a, e
    sub $04
    ld e, a
    ld a, d
    sbc $00
    ld d, a
    ld a, [hli]
    ld [de], a
    pop de
    ld a, [hl]
    ld [de], a
    push de
    ld a, $07
    add e
    ld e, a
    jr nc, .skip9
    inc d

.skip9:
    ld a, [hli]
    ld [de], a
    pop de
    inc de
    ld a, [hl]
    ld [de], a
    push de
    ld a, $07
    add e
    ld e, a
    jr nc, .skip10
    inc d

.skip10:
    ld a, [hli]
    ld [de], a
    pop de
    inc de
    ld a, [hli]
    ldh [hTemp3], a
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ldh a, [hTempA]
    and $03
    ld [de], a
    xor a
    inc de
    ld [de], a
    inc de
    inc de
    inc de
    ld [de], a
    inc de
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    push hl
    push de
    farcall DecompressGraphicsTemp0ToTemp4
    pop de
    pop hl
    pop bc
    dec b
    jr nz, .loop

.call_restore_sprite_snapshot:
    farcall RestoreSpriteSnapshot
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    ret

; LoadMapObjectsForScreen reads the word $4174 + 2 * hMapId (`add $74` / `adc $41`); 228 words up to
; the first array at $433C (E-0163, C1)
; record: per-screen selector array of this map ($0000 = none)
MapObjectTable::
    dw MapObjectScreens_63B2 ; id 0
    dw MapObjectScreens_6722 ; id 1
    dw MapObjectScreens_6945 ; id 2
    dw MapObjectScreens_7E4B ; id 3
    dw MapObjectScreens_6AFB ; id 4
    dw MapObjectScreens_6C32 ; id 5
    dw MapObjectScreens_6D2D ; id 6
    dw MapObjectScreens_6E3B ; id 7
    dw MapObjectScreens_6E8B ; id 8
    dw MapObjectScreens_6EB8 ; id 9
    dw MapObjectScreens_6EEB ; id 10
    dw MapObjectScreens_6F13 ; id 11
    dw MapObjectScreens_6F46 ; id 12
    dw MapObjectScreens_6FB1 ; id 13
    dw MapObjectScreens_701F ; id 14
    dw MapObjectScreens_7052 ; id 15
    dw MapObjectScreens_7087 ; id 16
    dw MapObjectScreens_70B4 ; id 17
    dw MapObjectScreens_7104 ; id 18
    dw MapObjectScreens_715C ; id 19
    dw MapObjectScreens_716E ; id 20
    dw MapObjectScreens_7196 ; id 21
    dw MapObjectScreens_71EA ; id 22
    dw MapObjectScreens_7212 ; id 23
    dw MapObjectScreens_730F ; id 24
    dw MapObjectScreens_7420 ; id 25
    dw MapObjectScreens_756A ; id 26
    dw MapObjectScreens_7E4B ; id 27
    dw MapObjectScreens_76E4 ; id 28
    dw MapObjectScreens_7708 ; id 29
    dw MapObjectScreens_7E4B ; id 30
    dw MapObjectScreens_7E4B ; id 31
    dw MapObjectScreens_7E4B ; id 32
    dw MapObjectScreens_7822 ; id 33
    dw MapObjectScreens_787D ; id 34
    dw MapObjectScreens_78A5 ; id 35
    dw MapObjectScreens_78C2 ; id 36
    dw MapObjectScreens_79B9 ; id 37
    dw MapObjectScreens_7A91 ; id 38
    dw MapObjectScreens_7E4B ; id 39
    dw MapObjectScreens_7B5E ; id 40
    dw MapObjectScreens_7E4B ; id 41
    dw MapObjectScreens_7BAB ; id 42
    dw MapObjectScreens_7BF9 ; id 43
    dw MapObjectScreens_7E4B ; id 44
    dw MapObjectScreens_7C4C ; id 45
    dw MapObjectScreens_7CDC ; id 46
    dw MapObjectScreens_7D31 ; id 47
    dw MapObjectScreens_5D9D ; id 48
    dw MapObjectScreens_5E57 ; id 49
    dw MapObjectScreens_5EBD ; id 50
    dw MapObjectScreens_5F73 ; id 51
    dw MapObjectScreens_6026 ; id 52
    dw MapObjectScreens_604E ; id 53
    dw MapObjectScreens_7E4B ; id 54
    dw MapObjectScreens_6080 ; id 55
    dw MapObjectScreens_60A8 ; id 56
    dw MapObjectScreens_60F0 ; id 57
    dw MapObjectScreens_615C ; id 58
    dw MapObjectScreens_6196 ; id 59
    dw MapObjectScreens_61EC ; id 60
    dw MapObjectScreens_627F ; id 61
    dw MapObjectScreens_7E4B ; id 62
    dw MapObjectScreens_7E4B ; id 63
    dw MapObjectScreens_629C ; id 64
    dw MapObjectScreens_62C0 ; id 65
    dw MapObjectScreens_636E ; id 66
    dw MapObjectScreens_6386 ; id 67
    dw MapObjectScreens_639E ; id 68
    dw MapObjectScreens_7E4B ; id 69
    dw MapObjectScreens_7E4B ; id 70
    dw MapObjectScreens_7E4B ; id 71
    dw MapObjectScreens_7E4B ; id 72
    dw MapObjectScreens_50F0 ; id 73
    dw MapObjectScreens_51D4 ; id 74
    dw MapObjectScreens_52C6 ; id 75
    dw MapObjectScreens_52F3 ; id 76
    dw MapObjectScreens_53FF ; id 77
    dw MapObjectScreens_5420 ; id 78
    dw MapObjectScreens_5436 ; id 79
    dw MapObjectScreens_5528 ; id 80
    dw MapObjectScreens_5576 ; id 81
    dw MapObjectScreens_69_5593 ; id 82
    dw MapObjectScreens_5616 ; id 83
    dw MapObjectScreens_567C ; id 84
    dw MapObjectScreens_568E ; id 85
    dw MapObjectScreens_7E4B ; id 86
    dw MapObjectScreens_56A2 ; id 87
    dw MapObjectScreens_572B ; id 88
    dw MapObjectScreens_57E1 ; id 89
    dw MapObjectScreens_5810 ; id 90
    dw MapObjectScreens_58CA ; id 91
    dw MapObjectScreens_59AB ; id 92
    dw MapObjectScreens_5A06 ; id 93
    dw MapObjectScreens_5A85 ; id 94
    dw MapObjectScreens_5BA8 ; id 95
    dw MapObjectScreens_5C01 ; id 96
    dw MapObjectScreens_5CD8 ; id 97
    dw MapObjectScreens_7E4B ; id 98
    dw MapObjectScreens_7E4B ; id 99
    dw MapObjectScreens_7E4B ; id 100
    dw MapObjectScreens_7E4B ; id 101
    dw MapObjectScreens_7E4B ; id 102
    dw MapObjectScreens_7E4B ; id 103
    dw MapObjectScreens_7E4B ; id 104
    dw MapObjectScreens_7E4B ; id 105
    dw MapObjectScreens_7E4B ; id 106
    dw MapObjectScreens_7E4B ; id 107
    dw MapObjectScreens_7E4B ; id 108
    dw MapObjectScreens_7E4B ; id 109
    dw MapObjectScreens_7E4B ; id 110
    dw MapObjectScreens_7E4B ; id 111
    dw MapObjectScreens_7E4B ; id 112
    dw MapObjectScreens_49F3 ; id 113
    dw MapObjectScreens_4AA8 ; id 114
    dw MapObjectScreens_7E4B ; id 115
    dw MapObjectScreens_7E4B ; id 116
    dw MapObjectScreens_7E4B ; id 117
    dw MapObjectScreens_4ABA ; id 118
    dw MapObjectScreens_4ADF ; id 119
    dw MapObjectScreens_4B05 ; id 120
    dw MapObjectScreens_4BBB ; id 121
    dw MapObjectScreens_4BF5 ; id 122
    dw MapObjectScreens_7E4B ; id 123
    dw MapObjectScreens_4C60 ; id 124
    dw MapObjectScreens_4D83 ; id 125
    dw MapObjectScreens_4DA5 ; id 126
    dw MapObjectScreens_4DE8 ; id 127
    dw MapObjectScreens_7E4B ; id 128
    dw MapObjectScreens_7E4B ; id 129
    dw MapObjectScreens_7E4B ; id 130
    dw MapObjectScreens_7E4B ; id 131
    dw MapObjectScreens_4E42 ; id 132
    dw MapObjectScreens_7E4B ; id 133
    dw MapObjectScreens_7E4B ; id 134
    dw MapObjectScreens_7E4B ; id 135
    dw MapObjectScreens_7E4B ; id 136
    dw MapObjectScreens_4E56 ; id 137
    dw MapObjectScreens_7E4B ; id 138
    dw MapObjectScreens_7E4B ; id 139
    dw MapObjectScreens_4E99 ; id 140
    dw MapObjectScreens_7E4B ; id 141
    dw MapObjectScreens_4EBD ; id 142
    dw MapObjectScreens_4F89 ; id 143
    dw MapObjectScreens_4F9D ; id 144
    dw MapObjectScreens_4FCD ; id 145
    dw MapObjectScreens_7E4B ; id 146
    dw MapObjectScreens_7E4B ; id 147
    dw MapObjectScreens_4FE1 ; id 148
    dw MapObjectScreens_5065 ; id 149
    dw MapObjectScreens_5083 ; id 150
    dw MapObjectScreens_7E4B ; id 151
    dw MapObjectScreens_7E4B ; id 152
    dw MapObjectScreens_7E4B ; id 153
    dw MapObjectScreens_7E4B ; id 154
    dw MapObjectScreens_50A5 ; id 155
    dw MapObjectScreens_7E4B ; id 156
    dw MapObjectScreens_7E4B ; id 157
    dw MapObjectScreens_7E4B ; id 158
    dw MapObjectScreens_7E4B ; id 159
    dw MapObjectScreens_7E4B ; id 160
    dw MapObjectScreens_49AF ; id 161
    dw MapObjectScreens_7E4B ; id 162
    dw MapObjectScreens_49D2 ; id 163
    dw MapObjectScreens_7E4B ; id 164
    dw MapObjectScreens_7E4B ; id 165
    dw MapObjectScreens_7E4B ; id 166
    dw MapObjectScreens_7E4B ; id 167
    dw MapObjectScreens_7E4B ; id 168
    dw MapObjectScreens_47AA ; id 169
    dw MapObjectScreens_48B6 ; id 170
    dw MapObjectScreens_493A ; id 171
    dw MapObjectScreens_4957 ; id 172
    dw MapObjectScreens_7E4B ; id 173
    dw MapObjectScreens_7E4B ; id 174
    dw MapObjectScreens_7E4B ; id 175
    dw MapObjectScreens_7E4B ; id 176
    dw MapObjectScreens_471D ; id 177
    dw MapObjectScreens_7E4B ; id 178
    dw MapObjectScreens_7E4B ; id 179
    dw MapObjectScreens_7E4B ; id 180
    dw MapObjectScreens_7E4B ; id 181
    dw MapObjectScreens_477B ; id 182
    dw MapObjectScreens_7E4B ; id 183
    dw MapObjectScreens_7E4B ; id 184
    dw MapObjectScreens_453D ; id 185
    dw MapObjectScreens_45E8 ; id 186
    dw MapObjectScreens_463D ; id 187
    dw MapObjectScreens_46AB ; id 188
    dw MapObjectScreens_46FE ; id 189
    dw MapObjectScreens_7E4B ; id 190
    dw MapObjectScreens_7E4B ; id 191
    dw MapObjectScreens_7E4B ; id 192
    dw MapObjectScreens_7E4B ; id 193
    dw MapObjectScreens_7E4B ; id 194
    dw MapObjectScreens_7E4B ; id 195
    dw MapObjectScreens_7E4B ; id 196
    dw MapObjectScreens_7E4B ; id 197
    dw MapObjectScreens_7E4B ; id 198
    dw MapObjectScreens_7E4B ; id 199
    dw MapObjectScreens_7E4B ; id 200
    dw MapObjectScreens_450E ; id 201
    dw MapObjectScreens_44F8 ; id 202
    dw MapObjectScreens_44E2 ; id 203
    dw MapObjectScreens_44CC ; id 204
    dw MapObjectScreens_44B6 ; id 205
    dw MapObjectScreens_4492 ; id 206
    dw MapObjectScreens_7E4B ; id 207
    dw MapObjectScreens_7E4B ; id 208
    dw MapObjectScreens_7E4B ; id 209
    dw MapObjectScreens_4463 ; id 210
    dw MapObjectScreens_444D ; id 211
    dw MapObjectScreens_4437 ; id 212
    dw MapObjectScreens_4421 ; id 213
    dw MapObjectScreens_440B ; id 214
    dw MapObjectScreens_43E7 ; id 215
    dw MapObjectScreens_7E4B ; id 216
    dw MapObjectScreens_7E4B ; id 217
    dw MapObjectScreens_7E4B ; id 218
    dw MapObjectScreens_43B8 ; id 219
    dw MapObjectScreens_43A2 ; id 220
    dw MapObjectScreens_438C ; id 221
    dw MapObjectScreens_4376 ; id 222
    dw MapObjectScreens_4360 ; id 223
    dw MapObjectScreens_433C ; id 224
    dw MapObjectScreens_7E4B ; id 225
    dw MapObjectScreens_7E4B ; id 226
    dw MapObjectScreens_7E4B ; id 227

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_433C::
    dw $0000 ; id 0
    dw ObjSelector_4340 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4340::
    objsel_unless_flag $01f6, MapObjects_4348
    objsel_list MapObjects_4354

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_4348::
    db $01 ; entry 0
    db $85, $01, $41, $00, $00, $40, $20, $05, $00, $50, $a7

MapObjects_4354::
    db $01 ; entry 0
    db $85, $01, $41, $00, $00, $30, $20, $05, $00, $50, $a7

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_4360::
    dw $0000 ; id 0
    dw ObjSelector_4364 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4364::
    objsel_unless_flag $01f2, MapObjects_436A
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_436A::
    db $01 ; entry 0
    db $85, $00, $0d, $00, $00, $40, $30, $05, $00, $50, $a6

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_4376::
    dw $0000 ; id 0
    dw ObjSelector_437A ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_437A::
    objsel_unless_flag $00fc, MapObjects_4380
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_4380::
    db $01 ; entry 0
    db $85, $00, $5c, $00, $00, $40, $30, $05, $00, $50, $a5

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_438C::
    dw $0000 ; id 0
    dw ObjSelector_4390 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4390::
    objsel_unless_flag $00f8, MapObjects_4396
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_4396::
    db $01 ; entry 0
    db $85, $00, $55, $00, $00, $40, $30, $05, $00, $50, $a4

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_43A2::
    dw $0000 ; id 0
    dw ObjSelector_43A6 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_43A6::
    objsel_unless_flag $00df, MapObjects_43AC
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_43AC::
    db $01 ; entry 0
    db $85, $00, $10, $00, $00, $40, $30, $05, $00, $50, $a3

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_43B8::
    dw ObjSelector_43BC ; id 0
    dw ObjSelector_43D7 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_43BC::
    objsel_list MapObjects_43C0

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_43C0::
    db $02 ; entry 0: object count
    db $85, $00, $63, $00, $00, $20, $40, $05, $00, $50, $a0 ; object 0
    db $86, $01, $52, $00, $00, $60, $30, $06, $02, $60, $a1 ; object 1

ObjSelector_43D7::
    objsel_list MapObjects_43DB

; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_43DB::
    db $01 ; entry 0
    db $85, $00, $59, $00, $00, $40, $30, $05, $00, $50, $a2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_43E7::
    dw $0000 ; id 0
    dw ObjSelector_43EB ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_43EB::
    objsel_unless_flag $00d9, MapObjects_43F3
    objsel_list MapObjects_43FF

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_43F3::
    db $01 ; entry 0
    db $85, $00, $9a, $00, $00, $40, $20, $05, $00, $50, $87

MapObjects_43FF::
    db $01 ; entry 0
    db $85, $00, $9a, $00, $00, $30, $20, $05, $00, $50, $87

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_440B::
    dw $0000 ; id 0
    dw ObjSelector_440F ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_440F::
    objsel_unless_flag $00d5, MapObjects_4415
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_4415::
    db $01 ; entry 0
    db $85, $00, $8d, $00, $00, $40, $30, $05, $00, $50, $86

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_4421::
    dw $0000 ; id 0
    dw ObjSelector_4425 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4425::
    objsel_unless_flag $017c, MapObjects_442B
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_442B::
    db $01 ; entry 0
    db $85, $00, $80, $00, $00, $40, $30, $05, $00, $50, $85

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_4437::
    dw $0000 ; id 0
    dw ObjSelector_443B ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_443B::
    objsel_unless_flag $0178, MapObjects_4441
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_4441::
    db $01 ; entry 0
    db $85, $00, $92, $00, $00, $40, $30, $05, $00, $50, $84

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_444D::
    dw $0000 ; id 0
    dw ObjSelector_4451 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4451::
    objsel_unless_flag $0174, MapObjects_4457
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_4457::
    db $01 ; entry 0
    db $85, $00, $39, $00, $00, $40, $30, $05, $00, $50, $83

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_4463::
    dw ObjSelector_4467 ; id 0
    dw ObjSelector_4482 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4467::
    objsel_list MapObjects_446B

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_446B::
    db $02 ; entry 0: object count
    db $85, $00, $15, $00, $00, $70, $40, $05, $00, $50, $80 ; object 0
    db $86, $01, $11, $00, $00, $10, $70, $06, $03, $60, $81 ; object 1

ObjSelector_4482::
    objsel_list MapObjects_4486

; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_4486::
    db $01 ; entry 0
    db $85, $00, $51, $00, $00, $40, $30, $05, $00, $50, $82

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_4492::
    dw $0000 ; id 0
    dw ObjSelector_4496 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4496::
    objsel_unless_flag $016e, MapObjects_449E
    objsel_list MapObjects_44AA

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_449E::
    db $01 ; entry 0
    db $85, $00, $ed, $00, $00, $40, $20, $05, $00, $50, $67

MapObjects_44AA::
    db $01 ; entry 0
    db $85, $00, $ed, $00, $00, $30, $20, $05, $00, $50, $67

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_44B6::
    dw $0000 ; id 0
    dw ObjSelector_44BA ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_44BA::
    objsel_unless_flag $016a, MapObjects_44C0
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_44C0::
    db $01 ; entry 0
    db $85, $00, $25, $01, $00, $40, $30, $05, $00, $50, $66

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_44CC::
    dw $0000 ; id 0
    dw ObjSelector_44D0 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_44D0::
    objsel_unless_flag $01dd, MapObjects_44D6
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_44D6::
    db $01 ; entry 0
    db $85, $00, $2e, $01, $00, $40, $30, $05, $00, $50, $65

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_44E2::
    dw $0000 ; id 0
    dw ObjSelector_44E6 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_44E6::
    objsel_unless_flag $01d9, MapObjects_44EC
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_44EC::
    db $01 ; entry 0
    db $85, $00, $55, $01, $00, $40, $30, $05, $00, $50, $64

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_44F8::
    dw $0000 ; id 0
    dw ObjSelector_44FC ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_44FC::
    objsel_unless_flag $01d4, MapObjects_4502
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_4502::
    db $01 ; entry 0
    db $85, $00, $4e, $00, $00, $40, $30, $05, $00, $50, $63

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_450E::
    dw ObjSelector_4512 ; id 0
    dw ObjSelector_452D ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4512::
    objsel_list MapObjects_4516

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_4516::
    db $02 ; entry 0: object count
    db $85, $00, $47, $00, $00, $30, $30, $05, $00, $50, $60 ; object 0
    db $86, $01, $3e, $00, $00, $70, $50, $06, $03, $60, $61 ; object 1

ObjSelector_452D::
    objsel_list MapObjects_4531

; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_4531::
    db $01 ; entry 0
    db $85, $00, $06, $00, $00, $40, $30, $05, $00, $50, $62

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_453D::
    dw ObjSelector_4545 ; id 0
    dw ObjSelector_456B ; id 1
    dw ObjSelector_459C ; id 2
    dw ObjSelector_45C2 ; id 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4545::
    objsel_list MapObjects_4549

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_4549::
    db $03 ; entry 0: object count
    db $85, $01, $0c, $00, $02, $40, $50, $05, $01, $50, $36 ; object 0
    db $86, $01, $0d, $00, $00, $20, $30, $06, $00, $60, $37 ; object 1
    db $87, $01, $08, $00, $00, $70, $20, $07, $03, $70, $38 ; object 2

ObjSelector_456B::
    objsel_list MapObjects_456F

; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_456F::
    db $04 ; entry 0: object count
    db $85, $01, $09, $00, $00, $60, $50, $05, $03, $50, $39 ; object 0
    db $86, $01, $0a, $00, $00, $20, $60, $06, $00, $60, $3a ; object 1
    db $85, $01, $09, $00, $02, $20, $40, $05, $01, $50, $3b ; object 2
    db $87, $01, $15, $00, $00, $40, $20, $07, $00, $70, $3c ; object 3

ObjSelector_459C::
    objsel_list MapObjects_45A0

MapObjects_45A0::
    db $03 ; entry 0: object count
    db $85, $01, $08, $00, $00, $30, $60, $05, $00, $50, $30 ; object 0
    db $86, $01, $09, $00, $00, $30, $40, $06, $01, $60, $31 ; object 1
    db $87, $01, $06, $00, $02, $60, $20, $07, $01, $70, $32 ; object 2

ObjSelector_45C2::
    objsel_list MapObjects_45C6

MapObjects_45C6::
    db $03 ; entry 0: object count
    db $85, $01, $07, $00, $02, $20, $60, $05, $01, $50, $33 ; object 0
    db $86, $01, $0a, $00, $00, $60, $40, $06, $00, $60, $34 ; object 1
    db $87, $01, $0b, $00, $00, $20, $20, $07, $00, $70, $35 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_45E8::
    dw ObjSelector_45EC ; id 0
    dw ObjSelector_4617 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_45EC::
    objsel_unless_flag EVENT_SCENE_PENDANT_SELLER_1C0, MapObjects_45F4
    objsel_list MapObjects_460B

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_45F4::
    db $02 ; entry 0: object count
    db $85, $01, $2a, $00, $00, $70, $60, $05, $03, $50, $43 ; object 0
    db $86, $01, $51, $00, $00, $30, $40, $06, $00, $60, $44 ; object 1

; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_460B::
    db $01 ; entry 0
    db $85, $01, $2a, $00, $00, $70, $60, $05, $03, $50, $43

ObjSelector_4617::
    objsel_list MapObjects_461B

; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_461B::
    db $03 ; entry 0: object count
    db $85, $01, $16, $00, $00, $50, $60, $05, $00, $50, $40 ; object 0
    db $86, $01, $22, $00, $02, $50, $20, $06, $01, $60, $41 ; object 1
    db $87, $01, $13, $00, $00, $30, $40, $07, $00, $70, $42 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_463D::
    dw ObjSelector_4641 ; id 0
    dw ObjSelector_466B ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4641::
    objsel_skip_if_set EVENT_SCENE_PENDANT_SELLER_1C0, $02, $00
    objsel_none

ObjSelector_4649::
    objsel_unless_flag EVENT_SCENE_MILAYOU_FOREST, MapObjects_4653
    objsel_unless_flag EVENT_KEY_BOSS_BEATEN_2, MapObjects_465F
    objsel_none

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_4653::
    db $01 ; entry 0
    db $85, $01, $43, $00, $00, $40, $20, $05, $02, $50, $3f

MapObjects_465F::
    db $01 ; entry 0
    db $85, $01, $43, $00, $00, $30, $20, $05, $00, $50, $3f

ObjSelector_466B::
    objsel_skip_if_set EVENT_SCENE_PENDANT_SELLER, $02, $00
    objsel_none

ObjSelector_4673::
    objsel_unless_flag EVENT_SCENE_MERCY, MapObjects_467D
    objsel_unless_flag EVENT_HERO_OPENED_THE_TREASURE_CHEST, MapObjects_469F
    objsel_none

; record: count, then 3 object(s), the layout of the other object lists
MapObjects_467D::
    db $03 ; entry 0: object count
    db $85, $00, $d3, $00, $00, $40, $10, $05, $01, $50, $45 ; object 0
    db $86, $00, $d3, $00, $00, $50, $10, $06, $03, $60, $46 ; object 1
    db $87, $01, $5a, $00, $00, $50, $e0, $07, $00, $70, $47 ; object 2

MapObjects_469F::
    db $01 ; entry 0
    db $85, $01, $5a, $00, $00, $50, $10, $05, $00, $50, $47

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_46AB::
    dw ObjSelector_46AD ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_46AD::
    objsel_unless_flag EVENT_THANK_YOU_I_KNEW_YOU, MapObjects_46C5
    objsel_unless_flag EVENT_THANK_YOU_FOR_GETTING_THE, MapObjects_46E7
    objsel_unless_flag EVENT_SCENE_PENDANT_SELLER_1C0, MapObjects_46C5
    objsel_unless_flag EVENT_KEY_BOSS_BEATEN_2, MapObjects_46E7
    objsel_unless_flag EVENT_MILAYOU_I_LOST_BUT_GOOD, MapObjects_46C5
    objsel_list MapObjects_46E7

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_46C5::
    db $03 ; entry 0: object count
    db $85, $01, $15, $00, $00, $30, $20, $05, $00, $50, $3d ; object 0
    db $86, $01, $43, $00, $00, $70, $40, $06, $00, $60, $3f ; object 1
    db $87, $01, $13, $00, $00, $70, $70, $07, $00, $70, $3e ; object 2

; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_46E7::
    db $02 ; entry 0: object count
    db $85, $01, $15, $00, $00, $30, $20, $05, $00, $50, $3d ; object 0
    db $86, $01, $13, $00, $00, $70, $70, $06, $00, $60, $3e ; object 1

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_46FE::
    dw ObjSelector_4700 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4700::
    objsel_unless_flag EVENT_KEY_BOSS_BEATEN_2, MapObjects_4706
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_4706::
    db $02 ; entry 0: object count
    db $85, $01, $51, $00, $00, $50, $20, $05, $00, $50, $48 ; object 0
    db $86, $01, $43, $00, $00, $e0, $e0, $06, $00, $60, $3f ; object 1

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_471D::
    dw ObjSelector_471F ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_471F::
    objsel_unless_flag EVENT_KIRAL_OH_FOOLISH_OF_ME, MapObjects_472B
    objsel_unless_flag $0167, MapObjects_4742
    objsel_list MapObjects_4759

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_472B::
    db $02 ; entry 0: object count
    db $85, $01, $20, $00, $00, $30, $40, $05, $02, $50, $20 ; object 0
    db $86, $00, $2a, $01, $00, $40, $30, $06, $00, $60, $21 ; object 1

MapObjects_4742::
    db $02 ; entry 0: object count
    db $85, $01, $20, $00, $00, $10, $40, $05, $02, $50, $20 ; object 0
    db $86, $00, $2a, $01, $00, $40, $30, $06, $00, $60, $21 ; object 1

; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_4759::
    db $03 ; entry 0: object count
    db $85, $01, $20, $00, $00, $60, $50, $05, $02, $50, $20 ; object 0
    db $86, $00, $2a, $01, $00, $40, $30, $06, $00, $60, $21 ; object 1
    db $87, $00, $29, $01, $00, $50, $10, $07, $00, $70, $2d ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_477B::
    dw ObjSelector_477D ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_477D::
    objsel_unless_flag EVENT_SCENE_BARREL, MapObjects_4787
    objsel_unless_flag $0167, MapObjects_479E
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_4787::
    db $02 ; entry 0: object count
    db $85, $00, $29, $01, $00, $40, $20, $05, $00, $50, $2d ; object 0
    db $86, $01, $61, $00, $00, $40, $e0, $06, $00, $60, $2d ; object 1

; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_479E::
    db $01 ; entry 0
    db $85, $01, $61, $00, $00, $40, $20, $05, $00, $50, $2d

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_47AA::
    dw ObjSelector_47B2 ; id 0
    dw ObjSelector_47CD ; id 1
    dw ObjSelector_486A ; id 2
    dw ObjSelector_4890 ; id 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_47B2::
    objsel_list MapObjects_47B6

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_47B6::
    db $02 ; entry 0: object count
    db $85, $01, $42, $00, $00, $50, $20, $05, $02, $50, $06 ; object 0
    db $86, $01, $32, $00, $00, $50, $40, $06, $00, $60, $07 ; object 1

ObjSelector_47CD::
    objsel_unless_flag EVENT_SCENE_ROLT_ELDER, MapObjects_47E1
    objsel_unless_flag EVENT_CYAL_LISTEN_HERO_WE_SHOULD, MapObjects_4803
    objsel_unless_flag EVENT_ROLT_WAIT_GONE_ALREADY, MapObjects_4825
    objsel_unless_flag EVENT_KEY_BOSS_BEATEN, MapObjects_483C
    objsel_list MapObjects_4848

; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_47E1::
    db $03 ; entry 0: object count
    db $85, $01, $35, $00, $00, $70, $10, $05, $00, $50, $0b ; object 0
    db $86, $01, $31, $00, $00, $40, $a0, $06, $02, $60, $01 ; object 1
    db $87, $01, $32, $00, $00, $40, $b0, $07, $02, $70, $02 ; object 2

MapObjects_4803::
    db $03 ; entry 0: object count
    db $85, $01, $35, $00, $00, $70, $10, $05, $00, $50, $0b ; object 0
    db $86, $01, $31, $00, $00, $60, $40, $06, $02, $60, $01 ; object 1
    db $87, $01, $32, $00, $00, $20, $70, $07, $00, $70, $02 ; object 2

MapObjects_4825::
    db $02 ; entry 0: object count
    db $85, $01, $35, $00, $00, $70, $10, $05, $00, $50, $0b ; object 0
    db $86, $01, $31, $00, $00, $60, $40, $06, $02, $60, $01 ; object 1

; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_483C::
    db $01 ; entry 0
    db $85, $01, $35, $00, $00, $70, $10, $05, $00, $50, $0b

MapObjects_4848::
    db $03 ; entry 0: object count
    db $85, $01, $35, $00, $00, $70, $10, $05, $00, $50, $0b ; object 0
    db $86, $01, $31, $00, $00, $30, $50, $06, $02, $60, $01 ; object 1
    db $87, $01, $32, $00, $00, $40, $60, $07, $02, $70, $02 ; object 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_486A::
    objsel_list MapObjects_486E

; an object list of LoadMapObjectsForScreen (E-0163)
MapObjects_486E::
    db $03 ; entry 0: object count
    db $85, $01, $33, $00, $00, $60, $60, $05, $01, $50, $08 ; object 0
    db $86, $01, $34, $00, $02, $20, $50, $06, $01, $60, $09 ; object 1
    db $87, $01, $37, $00, $00, $20, $30, $07, $00, $70, $0a ; object 2

ObjSelector_4890::
    objsel_list MapObjects_4894

MapObjects_4894::
    db $03 ; entry 0: object count
    db $85, $01, $37, $00, $00, $80, $40, $05, $00, $50, $03 ; object 0
    db $86, $01, $34, $00, $00, $20, $30, $06, $01, $60, $04 ; object 1
    db $87, $01, $31, $00, $02, $40, $60, $07, $00, $70, $05 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_48B6::
    dw ObjSelector_48BA ; id 0
    dw ObjSelector_4916 ; id 1

ObjSelector_48BA::
    objsel_skip_if_clear EVENT_SCENE_TOO_STRONG, $02, $00
    objsel_none

ObjSelector_48C2::
    objsel_skip_if_clear EVENT_CYAL_LISTEN_HERO_WE_SHOULD, $04, $00
    objsel_list MapObjects_48E9

ObjSelector_48CC::
    objsel_unless_flag EVENT_SCENE_ROLT_ELDER, MapObjects_48D2
    objsel_none

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_48D2::
    db $02 ; entry 0: object count
    db $85, $01, $31, $00, $00, $40, $30, $05, $00, $50, $01 ; object 0
    db $86, $01, $32, $00, $00, $50, $20, $06, $00, $60, $02 ; object 1

; record: count, then 4 object(s), the layout of the other object lists
MapObjects_48E9::
    db $04 ; entry 0: object count
    db $85, $01, $32, $00, $00, $60, $10, $05, $00, $50, $02 ; object 0
    db $86, $00, $d5, $00, $00, $50, $20, $06, $00, $60, $00 ; object 1
    db $87, $00, $57, $00, $00, $50, $40, $07, $00, $70, $0d ; object 2
    db $87, $00, $57, $00, $00, $40, $30, $07, $00, $70, $0e ; object 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4916::
    objsel_skip_if_clear EVENT_CYAL_EEEK_HERO_HELP_ME, $02, $00
    objsel_none

ObjSelector_491E::
    objsel_skip_if_clear EVENT_CYAL_LISTEN_HERO_WE_SHOULD, $04, $00
    objsel_list MapObjects_492E

ObjSelector_4928::
    objsel_unless_flag EVENT_SCENE_CYAL_SHINE, MapObjects_492E
    objsel_none

; record: count, then 1 object(s), the layout of the other object lists
MapObjects_492E::
    db $01 ; entry 0
    db $85, $01, $32, $00, $00, $40, $30, $05, $02, $50, $02

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_493A::
    dw ObjSelector_493C ; id 0

ObjSelector_493C::
    objsel_list MapObjects_4940

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_4940::
    db $02 ; entry 0: object count
    db $85, $01, $37, $00, $00, $50, $40, $05, $00, $50, $0f ; object 0
    db $86, $01, $38, $00, $00, $30, $20, $06, $03, $60, $10 ; object 1

MapObjectScreens_4957::
    dw ObjSelector_4959 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4959::
    objsel_skip_if_set EVENT_ROLT_WAIT_GONE_ALREADY, $02, $00
    objsel_none

ObjSelector_4961::
    objsel_unless_flag EVENT_SCENE_GIVE_BACK_CYAL, MapObjects_496B
    objsel_unless_flag EVENT_KEY_BOSS_BEATEN, MapObjects_498D
    objsel_none

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_496B::
    db $03 ; entry 0: object count
    db $85, $00, $d5, $00, $00, $40, $30, $05, $00, $50, $11 ; object 0
    db $86, $01, $32, $00, $00, $40, $20, $06, $00, $60, $02 ; object 1
    db $87, $01, $31, $00, $00, $40, $60, $07, $02, $70, $01 ; object 2

MapObjects_498D::
    db $03 ; entry 0: object count
    db $85, $00, $d5, $00, $00, $40, $30, $05, $00, $50, $11 ; object 0
    db $86, $01, $32, $00, $00, $40, $20, $06, $00, $60, $02 ; object 1
    db $87, $01, $31, $00, $00, $60, $40, $07, $03, $70, $01 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_49AF::
    dw ObjSelector_49B5 ; id 0
    dw $0000 ; id 1
    dw $0000 ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_49B5::
    objsel_unless_flag EVENT_SCENE_DARCK_TAUNT, MapObjects_49BB
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_49BB::
    db $02 ; entry 0: object count
    db $85, $01, $5c, $00, $00, $40, $30, $05, $00, $50, $00 ; object 0
    db $86, $00, $df, $00, $00, $40, $e0, $06, $00, $60, $00 ; object 1

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_49D2::
    dw ObjSelector_49D6 ; id 0
    dw $0000 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_49D6::
    objsel_unless_flag EVENT_SCENE_DARCK_DEFEATED, MapObjects_49DC
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_49DC::
    db $02 ; entry 0: object count
    db $85, $01, $4a, $00, $00, $40, $e0, $05, $00, $50, $00 ; object 0
    db $86, $01, $48, $00, $05, $48, $30, $06, $00, $60, $01 ; object 1

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_49F3::
    dw ObjSelector_49F9 ; id 0
    dw ObjSelector_4A51 ; id 1
    dw ObjSelector_4A82 ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_49F9::
    objsel_skip_if_set $0025, $0a, $00
    objsel_skip_if_clear EVENT_SCENE_DARCK_DEFEATED, $04, $00
    objsel_list MapObjects_4A24

ObjSelector_4A09::
    objsel_list MapObjects_4A0D

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_4A0D::
    db $02 ; entry 0: object count
    db $85, $00, $6d, $00, $00, $70, $20, $05, $00, $50, $0b ; object 0
    db $86, $00, $55, $01, $00, $20, $e0, $06, $00, $60, $00 ; object 1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_4A24::
    db $04 ; entry 0: object count
    db $85, $00, $6d, $00, $00, $70, $20, $05, $00, $50, $0b ; object 0
    db $86, $00, $55, $01, $00, $20, $e0, $06, $00, $60, $00 ; object 1
    db $87, $00, $63, $00, $00, $b0, $40, $07, $01, $70, $01 ; object 2
    db $83, $00, $75, $00, $00, $c0, $40, $03, $00, $30, $02 ; object 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4A51::
    objsel_list MapObjects_4A55

MapObjects_4A55::
    db $04 ; entry 0: object count
    db $85, $00, $47, $00, $00, $50, $70, $05, $00, $50, $00 ; object 0
    db $86, $00, $63, $00, $00, $10, $60, $06, $01, $60, $01 ; object 1
    db $87, $00, $75, $00, $00, $70, $20, $07, $00, $70, $02 ; object 2
    db $86, $00, $63, $00, $00, $30, $30, $06, $00, $60, $03 ; object 3

ObjSelector_4A82::
    objsel_list MapObjects_4A86

; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_4A86::
    db $03 ; entry 0: object count
    db $85, $00, $6a, $00, $02, $30, $40, $05, $01, $50, $05 ; object 0
    db $86, $00, $51, $00, $00, $20, $60, $06, $02, $60, $04 ; object 1
    db $87, $00, $6a, $00, $00, $50, $30, $07, $00, $70, $06 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_4AA8::
    dw ObjSelector_4AAA ; id 0

ObjSelector_4AAA::
    objsel_list MapObjects_4AAE

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_4AAE::
    db $01 ; entry 0
    db $85, $00, $77, $00, $00, $30, $10, $05, $00, $50, $00

MapObjectScreens_4ABA::
    dw ObjSelector_4AC2 ; id 0
    dw $0000 ; id 1
    dw $0000 ; id 2
    dw $0000 ; id 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4AC2::
    objsel_unless_flag EVENT_SCENE_MADCONDOR, MapObjects_4AC8
    objsel_none

; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_4AC8::
    db $02 ; entry 0: object count
    db $85, $00, $79, $00, $00, $6e, $ec, $05, $00, $50, $00 ; object 0
    db $86, $01, $5a, $00, $00, $40, $50, $06, $00, $60, $00 ; object 1

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_4ADF::
    dw $0000 ; id 0
    dw $0000 ; id 1
    dw ObjSelector_4AE5 ; id 2

ObjSelector_4AE5::
    objsel_unless_flag $0209, MapObjects_4AED
    objsel_list MapObjects_4AF9

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_4AED::
    db $01 ; entry 0
    db $85, $00, $61, $00, $00, $40, $20, $05, $00, $50, $16

MapObjects_4AF9::
    db $01 ; entry 0
    db $85, $00, $61, $00, $00, $50, $20, $05, $03, $50, $16

MapObjectScreens_4B05::
    dw ObjSelector_4B0D ; id 0
    dw ObjSelector_4B33 ; id 1
    dw ObjSelector_4B59 ; id 2
    dw ObjSelector_4B8A ; id 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4B0D::
    objsel_list MapObjects_4B11

; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_4B11::
    db $03 ; entry 0: object count
    db $85, $00, $53, $00, $00, $10, $70, $05, $01, $50, $1c ; object 0
    db $86, $00, $19, $01, $00, $10, $30, $06, $00, $60, $1b ; object 1
    db $87, $00, $06, $00, $00, $40, $40, $07, $00, $70, $1d ; object 2

ObjSelector_4B33::
    objsel_list MapObjects_4B37

MapObjects_4B37::
    db $03 ; entry 0: object count
    db $85, $00, $5c, $00, $00, $50, $60, $05, $03, $50, $1e ; object 0
    db $86, $00, $2b, $00, $00, $30, $40, $06, $00, $60, $1f ; object 1
    db $87, $00, $6c, $00, $00, $20, $70, $07, $03, $70, $20 ; object 2

ObjSelector_4B59::
    objsel_list MapObjects_4B5D

; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_4B5D::
    db $04 ; entry 0: object count
    db $85, $00, $48, $00, $00, $50, $40, $05, $00, $50, $17 ; object 0
    db $85, $00, $48, $00, $00, $80, $70, $05, $03, $50, $1a ; object 1
    db $86, $00, $56, $00, $00, $70, $20, $06, $00, $60, $23 ; object 2
    db $87, $00, $6d, $00, $00, $10, $30, $07, $01, $70, $24 ; object 3

ObjSelector_4B8A::
    objsel_list MapObjects_4B8E

; an object list of LoadMapObjectsForScreen (E-0163)
MapObjects_4B8E::
    db $04 ; entry 0: object count
    db $85, $00, $5f, $00, $00, $10, $20, $05, $00, $50, $21 ; object 0
    db $86, $00, $80, $00, $02, $10, $60, $06, $03, $60, $22 ; object 1
    db $87, $00, $47, $00, $00, $40, $70, $07, $02, $70, $19 ; object 2
    db $84, $00, $49, $00, $00, $70, $30, $04, $00, $40, $18 ; object 3

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_4BBB::
    dw ObjSelector_4BBF ; id 0
    dw ObjSelector_4BCF ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4BBF::
    objsel_list MapObjects_4BC3

; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_4BC3::
    db $01 ; entry 0
    db $85, $00, $0c, $00, $00, $50, $60, $05, $00, $50, $6b

ObjSelector_4BCF::
    objsel_list MapObjects_4BD3

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_4BD3::
    db $03 ; entry 0: object count
    db $85, $00, $53, $00, $00, $70, $10, $05, $00, $50, $00 ; object 0
    db $86, $00, $5d, $00, $00, $30, $20, $06, $03, $60, $6c ; object 1
    db $87, $00, $4e, $00, $00, $20, $30, $07, $02, $70, $6d ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_4BF5::
    dw ObjSelector_4BF9 ; id 0
    dw ObjSelector_4C50 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4BF9::
    objsel_skip_if_clear $00c4, $04, $00
    objsel_list MapObjects_4C44

ObjSelector_4C03::
    objsel_unless_flag EVENT_SCENE_MADCONDOR_CRY, MapObjects_4C0B
    objsel_list MapObjects_4C2D

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_4C0B::
    db $03 ; entry 0: object count
    db $85, $00, $1f, $01, $00, $50, $40, $05, $00, $50, $2a ; object 0
    db $86, $01, $5e, $00, $00, $40, $60, $06, $02, $60, $6a ; object 1
    db $87, $00, $79, $00, $00, $40, $20, $07, $00, $70, $5d ; object 2

; record: count, then 2 object(s), the layout of the other object lists
MapObjects_4C2D::
    db $02 ; entry 0: object count
    db $85, $00, $1f, $01, $00, $50, $40, $05, $00, $50, $2a ; object 0
    db $86, $01, $5e, $00, $00, $40, $60, $06, $02, $60, $6a ; object 1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_4C44::
    db $01 ; entry 0
    db $85, $00, $1f, $01, $00, $50, $40, $05, $00, $50, $2a

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4C50::
    objsel_list MapObjects_4C54

MapObjects_4C54::
    db $01 ; entry 0
    db $85, $00, $79, $00, $00, $00, $e0, $05, $00, $50, $00

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_4C60::
    dw ObjSelector_4C68 ; id 0
    dw ObjSelector_4CCA ; id 1
    dw ObjSelector_4CFB ; id 2
    dw ObjSelector_4D2C ; id 3

ObjSelector_4C68::
    objsel_skip_if_clear EVENT_WHAT_YOU_HAVE_THE_THREE, $04, $00
    objsel_list MapObjects_4CB3

ObjSelector_4C72::
    objsel_unless_flag EVENT_SCENE_MADCONDOR_CRY, MapObjects_4C7A
    objsel_list MapObjects_4C91

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_4C7A::
    db $02 ; entry 0: object count
    db $85, $00, $59, $00, $00, $40, $50, $05, $00, $50, $34 ; object 0
    db $86, $00, $59, $00, $00, $50, $50, $06, $00, $60, $35 ; object 1

; record: count, then 3 object(s), the layout of the other object lists
MapObjects_4C91::
    db $03 ; entry 0: object count
    db $85, $00, $59, $00, $00, $40, $50, $05, $00, $50, $34 ; object 0
    db $86, $00, $59, $00, $00, $50, $50, $06, $00, $60, $35 ; object 1
    db $87, $00, $58, $00, $00, $20, $70, $07, $02, $70, $36 ; object 2

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_4CB3::
    db $02 ; entry 0: object count
    db $85, $00, $59, $00, $00, $60, $60, $05, $00, $50, $35 ; object 0
    db $86, $00, $58, $00, $00, $20, $70, $06, $01, $60, $36 ; object 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4CCA::
    objsel_list MapObjects_4CCE

; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_4CCE::
    db $04 ; entry 0: object count
    db $85, $00, $54, $00, $00, $10, $30, $05, $00, $50, $38 ; object 0
    db $86, $00, $03, $00, $02, $40, $60, $06, $01, $60, $39 ; object 1
    db $85, $00, $54, $00, $00, $80, $40, $05, $03, $50, $3a ; object 2
    db $87, $00, $58, $00, $00, $50, $10, $07, $00, $70, $3b ; object 3

ObjSelector_4CFB::
    objsel_list MapObjects_4CFF

MapObjects_4CFF::
    db $04 ; entry 0: object count
    db $85, $00, $63, $00, $02, $50, $60, $05, $01, $50, $30 ; object 0
    db $86, $00, $55, $00, $00, $20, $40, $06, $01, $60, $31 ; object 1
    db $87, $00, $62, $00, $00, $70, $10, $07, $00, $70, $32 ; object 2
    db $87, $00, $62, $00, $00, $70, $20, $07, $02, $70, $33 ; object 3

ObjSelector_4D2C::
    objsel_unless_flag EVENT_SCENE_MADCONDOR_CRY, MapObjects_4D34
    objsel_list MapObjects_4D56

; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_4D34::
    db $03 ; entry 0: object count
    db $85, $00, $4e, $00, $00, $30, $70, $05, $00, $50, $2d ; object 0
    db $86, $00, $4d, $00, $02, $70, $10, $06, $03, $60, $2e ; object 1
    db $87, $00, $9b, $00, $00, $80, $40, $07, $02, $70, $2f ; object 2

; an object list of LoadMapObjectsForScreen (E-0163)
MapObjects_4D56::
    db $04 ; entry 0: object count
    db $85, $00, $4e, $00, $00, $30, $70, $05, $00, $50, $2d ; object 0
    db $86, $00, $4d, $00, $02, $70, $10, $06, $03, $60, $2e ; object 1
    db $87, $00, $9b, $00, $00, $80, $40, $07, $02, $70, $2f ; object 2
    db $84, $00, $57, $00, $00, $30, $50, $04, $00, $40, $37 ; object 3

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_4D83::
    dw ObjSelector_4D85 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4D85::
    objsel_unless_flag EVENT_SCENE_MADCONDOR_CRY, MapObjects_4D8D
    objsel_list MapObjects_4D99

; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_4D8D::
    db $01 ; entry 0
    db $85, $00, $56, $00, $00, $10, $10, $05, $01, $50, $3d

; an object list of LoadMapObjectsForScreen (E-0163)
MapObjects_4D99::
    db $01 ; entry 0
    db $85, $00, $56, $00, $00, $10, $10, $05, $01, $50, $3f

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_4DA5::
    dw ObjSelector_4DA7 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4DA7::
    objsel_unless_flag EVENT_SCENE_MADCONDOR_CRY, MapObjects_4DAF
    objsel_list MapObjects_4DBB

; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_4DAF::
    db $01 ; entry 0
    db $85, $00, $80, $00, $00, $30, $10, $05, $00, $50, $43

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_4DBB::
    db $04 ; entry 0: object count
    db $85, $00, $80, $00, $00, $30, $10, $05, $00, $50, $43 ; object 0
    db $86, $00, $5a, $00, $00, $40, $40, $06, $02, $60, $44 ; object 1
    db $87, $00, $76, $00, $00, $50, $50, $07, $00, $70, $45 ; object 2
    db $87, $00, $76, $00, $00, $50, $70, $07, $02, $70, $46 ; object 3

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_4DE8::
    dw ObjSelector_4DEC ; id 0
    dw ObjSelector_4E0C ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4DEC::
    objsel_unless_flag EVENT_SCENE_FOUND_ME, MapObjects_4DF4
    objsel_list MapObjects_4E00

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_4DF4::
    db $01 ; entry 0
    db $85, $00, $61, $00, $00, $50, $40, $05, $00, $50, $5a

MapObjects_4E00::
    db $01 ; entry 0
    db $85, $00, $61, $00, $00, $40, $40, $05, $00, $50, $5a

ObjSelector_4E0C::
    objsel_unless_flag EVENT_SCENE_THREE_ITEMS_0C2, MapObjects_4E14
    objsel_list MapObjects_4E36

; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_4E14::
    db $03 ; entry 0: object count
    db $85, $00, $5a, $00, $00, $30, $30, $05, $01, $50, $57 ; object 0
    db $86, $00, $59, $00, $00, $70, $50, $06, $00, $60, $58 ; object 1
    db $87, $00, $57, $00, $00, $70, $70, $07, $02, $70, $59 ; object 2

MapObjects_4E36::
    db $01 ; entry 0
    db $85, $00, $5a, $00, $00, $30, $30, $05, $01, $50, $57

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_4E42::
    dw ObjSelector_4E44 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4E44::
    objsel_unless_flag EVENT_HEH_YOU, MapObjects_4E4A
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_4E4A::
    db $01 ; entry 0
    db $85, $00, $12, $00, $00, $40, $30, $05, $00, $50, $4a

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_4E56::
    dw ObjSelector_4E5E ; id 0
    dw $0000 ; id 1
    dw ObjSelector_4E6E ; id 2
    dw ObjSelector_4E89 ; id 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4E5E::
    objsel_list MapObjects_4E62

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_4E62::
    db $01 ; entry 0
    db $85, $00, $5e, $00, $00, $80, $60, $05, $02, $50, $0a

ObjSelector_4E6E::
    objsel_list MapObjects_4E72

; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_4E72::
    db $02 ; entry 0: object count
    db $85, $00, $5d, $00, $00, $60, $60, $05, $00, $50, $09 ; object 0
    db $86, $00, $55, $00, $00, $10, $50, $06, $00, $60, $07 ; object 1

ObjSelector_4E89::
    objsel_list MapObjects_4E8D

MapObjects_4E8D::
    db $01 ; entry 0
    db $85, $00, $50, $00, $00, $40, $60, $05, $02, $50, $08

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_4E99::
    dw ObjSelector_4EAB ; id 0
    dw $0000 ; id 1
    dw $0000 ; id 2
    dw $0000 ; id 3
    dw $0000 ; id 4
    dw $0000 ; id 5
    dw $0000 ; id 6
    dw $0000 ; id 7
    dw $0000 ; id 8

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4EAB::
    objsel_unless_flag EVENT_SCENE_BEATEN_FAIRLY_0C5, MapObjects_4EB1
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_4EB1::
    db $01 ; entry 0
    db $85, $00, $0a, $01, $00, $20, $20, $05, $00, $50, $4c

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_4EBD::
    dw ObjSelector_4ECF ; id 0
    dw ObjSelector_4EF7 ; id 1
    dw ObjSelector_4F07 ; id 2
    dw ObjSelector_4F2D ; id 3
    dw ObjSelector_4F53 ; id 4
    dw ObjSelector_4F63 ; id 5
    dw $0000 ; id 6
    dw $0000 ; id 7
    dw $0000 ; id 8

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4ECF::
    objsel_list MapObjects_4ED5

ObjSelector_4ED3::
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_4ED5::
    db $03 ; entry 0: object count
    db $85, $01, $44, $00, $00, $30, $30, $05, $00, $50, $69 ; object 0
    db $86, $01, $44, $00, $00, $60, $40, $06, $00, $60, $69 ; object 1
    db $87, $01, $44, $00, $00, $80, $20, $07, $01, $70, $69 ; object 2

ObjSelector_4EF7::
    objsel_list MapObjects_4EFB

; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_4EFB::
    db $01 ; entry 0
    db $85, $01, $44, $00, $00, $30, $50, $05, $00, $50, $69

ObjSelector_4F07::
    objsel_list MapObjects_4F0B

MapObjects_4F0B::
    db $03 ; entry 0: object count
    db $85, $01, $44, $00, $00, $10, $30, $05, $03, $50, $69 ; object 0
    db $86, $01, $44, $00, $00, $20, $50, $06, $01, $60, $69 ; object 1
    db $87, $01, $44, $00, $00, $30, $60, $07, $00, $70, $69 ; object 2

ObjSelector_4F2D::
    objsel_list MapObjects_4F31

MapObjects_4F31::
    db $03 ; entry 0: object count
    db $85, $01, $44, $00, $00, $30, $70, $05, $01, $50, $69 ; object 0
    db $86, $01, $44, $00, $00, $50, $30, $06, $03, $60, $69 ; object 1
    db $87, $01, $44, $00, $00, $80, $40, $07, $02, $70, $69 ; object 2

ObjSelector_4F53::
    objsel_list MapObjects_4F57

MapObjects_4F57::
    db $01 ; entry 0
    db $85, $01, $44, $00, $00, $30, $30, $05, $01, $50, $69

ObjSelector_4F63::
    objsel_list MapObjects_4F67

MapObjects_4F67::
    db $03 ; entry 0: object count
    db $85, $01, $44, $00, $00, $10, $30, $05, $02, $50, $69 ; object 0
    db $86, $01, $44, $00, $00, $20, $70, $06, $02, $60, $69 ; object 1
    db $87, $01, $44, $00, $00, $30, $40, $07, $01, $70, $69 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_4F89::
    dw ObjSelector_4F8B ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4F8B::
    objsel_unless_flag EVENT_SCENE_GRAVESTONE, MapObjects_4F91
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_4F91::
    db $01 ; entry 0
    db $85, $00, $f6, $00, $00, $40, $40, $05, $00, $50, $4f

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_4F9D::
    dw ObjSelector_4FA9 ; id 0
    dw ObjSelector_4FBB ; id 1
    dw $0000 ; id 2
    dw $0000 ; id 3
    dw $0000 ; id 4
    dw $0000 ; id 5

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4FA9::
    objsel_unless_flag EVENT_SCENE_BEATEN_FAIRLY_0C6, MapObjects_4FAF
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_4FAF::
    db $01 ; entry 0
    db $85, $00, $0a, $01, $00, $50, $20, $05, $00, $50, $6e

ObjSelector_4FBB::
    objsel_unless_flag EVENT_SCENE_BEATEN_FAIRLY_0C7, MapObjects_4FC1
    objsel_none

MapObjects_4FC1::
    db $01 ; entry 0
    db $85, $00, $0a, $01, $00, $80, $50, $05, $03, $50, $6f

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_4FCD::
    dw ObjSelector_4FCF ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4FCF::
    objsel_unless_flag EVENT_SCENE_BEATEN_FAIRLY, MapObjects_4FD5
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_4FD5::
    db $01 ; entry 0
    db $85, $00, $10, $01, $00, $40, $30, $05, $00, $50, $55

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_4FE1::
    dw $0000 ; id 0
    dw $0000 ; id 1
    dw $0000 ; id 2
    dw ObjSelector_4FF3 ; id 3
    dw ObjSelector_500D ; id 4
    dw ObjSelector_5027 ; id 5
    dw $0000 ; id 6
    dw ObjSelector_5041 ; id 7
    dw ObjSelector_5053 ; id 8

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4FF3::
    objsel_skip_if_clear EVENT_SCENE_THREE_ITEMS, $02, $00
    objsel_none

ObjSelector_4FFB::
    objsel_unless_flag $00b9, MapObjects_5001
    objsel_none

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_5001::
    db $01 ; entry 0
    db $85, $00, $ec, $00, $00, $40, $20, $05, $00, $50, $5c

ObjSelector_500D::
    objsel_skip_if_clear EVENT_SCENE_THREE_ITEMS, $02, $00
    objsel_none

ObjSelector_5015::
    objsel_unless_flag $00ba, MapObjects_501B
    objsel_none

MapObjects_501B::
    db $01 ; entry 0
    db $85, $00, $ec, $00, $00, $40, $20, $05, $00, $50, $5c

ObjSelector_5027::
    objsel_skip_if_clear EVENT_SCENE_THREE_ITEMS, $02, $00
    objsel_none

ObjSelector_502F::
    objsel_unless_flag $00bb, MapObjects_5035
    objsel_none

MapObjects_5035::
    db $01 ; entry 0
    db $85, $00, $ec, $00, $00, $40, $20, $05, $00, $50, $5c

ObjSelector_5041::
    objsel_unless_flag EVENT_SCENE_THREE_ITEMS, MapObjects_5047
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_5047::
    db $01 ; entry 0
    db $85, $00, $d6, $00, $00, $40, $20, $05, $00, $50, $5f

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5053::
    objsel_unless_flag EVENT_SCENE_THREE_ITEMS, MapObjects_5059
    objsel_none

MapObjects_5059::
    db $01 ; entry 0
    db $85, $00, $d6, $00, $00, $30, $40, $05, $03, $50, $60

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_5065::
    dw $0000 ; id 0
    dw $0000 ; id 1
    dw $0000 ; id 2
    dw $0000 ; id 3
    dw $0000 ; id 4
    dw ObjSelector_5071 ; id 5

ObjSelector_5071::
    objsel_unless_flag EVENT_SCENE_THREE_ITEMS, MapObjects_5077
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_5077::
    db $01 ; entry 0
    db $85, $00, $d6, $00, $00, $80, $40, $05, $00, $50, $61

MapObjectScreens_5083::
    dw $0000 ; id 0
    dw ObjSelector_508B ; id 1
    dw $0000 ; id 2
    dw $0000 ; id 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_508B::
    objsel_skip_if_clear EVENT_SCENE_THREE_ITEMS, $02, $00
    objsel_none

ObjSelector_5093::
    objsel_unless_flag $0201, MapObjects_5099
    objsel_none

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_5099::
    db $01 ; entry 0
    db $85, $00, $ec, $00, $00, $10, $40, $05, $01, $50, $5c

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_50A5::
    dw ObjSelector_50AB ; id 0
    dw ObjSelector_50DE ; id 1
    dw $0000 ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_50AB::
    objsel_skip_if_clear EVENT_SCENE_THREE_ITEMS_0C3, $02, $00
    objsel_none

ObjSelector_50B3::
    objsel_unless_flag EVENT_SCENE_THREE_ITEMS_0C2, MapObjects_50BB
    objsel_list MapObjects_50D2

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_50BB::
    db $02 ; entry 0: object count
    db $85, $01, $03, $00, $00, $40, $20, $05, $00, $50, $5c ; object 0
    db $86, $01, $48, $00, $05, $48, $c0, $06, $00, $60, $00 ; object 1

; record: count, then 1 object(s), the layout of the other object lists
MapObjects_50D2::
    db $01 ; entry 0
    db $85, $01, $03, $00, $00, $50, $30, $05, $02, $50, $5c

ObjSelector_50DE::
    objsel_unless_flag EVENT_SCENE_THREE_ITEMS_BATTLE, MapObjects_50E4
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_50E4::
    db $01 ; entry 0
    db $85, $01, $54, $00, $04, $48, $20, $05, $00, $50, $67

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_50F0::
    dw ObjSelector_50F2 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_50F2::
    objsel_skip_if_set $0025, $0a, $00
    objsel_skip_if_clear EVENT_SCENE_DARCK_DEFEATED, $04, $00
    objsel_list MapObjects_519C

ObjSelector_5102::
    objsel_skip_if_clear EVENT_SCENE_SHIELD2_1E5, $02, $00
    objsel_none

ObjSelector_510A::
    objsel_skip_if_clear EVENT_SCENE_SHIELD_1E4, $04, $00
    objsel_list MapObjects_5158

ObjSelector_5114::
    objsel_skip_if_clear EVENT_HERO_CHECKED_THE_TREASURE_CHEST, $08, $00
    objsel_unless_flag EVENT_SCENE_SHIELD, MapObjects_5158
    objsel_list MapObjects_517A

ObjSelector_5122::
    objsel_unless_flag EVENT_BLINK_SPRITES, MapObjects_512A
    objsel_list MapObjects_5141

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_512A::
    db $02 ; entry 0: object count
    db $85, $01, $5b, $00, $00, $40, $30, $05, $00, $50, $14 ; object 0
    db $86, $01, $5a, $00, $00, $60, $e0, $06, $00, $60, $a0 ; object 1

MapObjects_5141::
    db $02 ; entry 0: object count
    db $85, $01, $5b, $00, $00, $40, $30, $05, $00, $50, $14 ; object 0
    db $86, $01, $5a, $00, $00, $60, $70, $06, $00, $60, $a0 ; object 1

; record: count, then 3 object(s), the layout of the other object lists
MapObjects_5158::
    db $03 ; entry 0: object count
    db $85, $01, $5b, $00, $00, $40, $30, $05, $00, $50, $14 ; object 0
    db $86, $01, $5c, $00, $00, $40, $e0, $06, $00, $60, $9f ; object 1
    db $87, $01, $53, $00, $00, $40, $e0, $07, $00, $70, $00 ; object 2

MapObjects_517A::
    db $03 ; entry 0: object count
    db $85, $01, $5b, $00, $00, $40, $30, $05, $00, $50, $14 ; object 0
    db $86, $01, $5c, $00, $00, $40, $40, $06, $00, $60, $9f ; object 1
    db $87, $01, $53, $00, $00, $40, $e0, $07, $00, $70, $00 ; object 2

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 5 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_519C::
    db $05 ; entry 0: object count
    db $85, $01, $53, $00, $00, $40, $e0, $05, $00, $50, $00 ; object 0
    db $86, $01, $3a, $00, $00, $40, $50, $06, $02, $60, $72 ; object 1
    db $87, $01, $42, $00, $00, $50, $70, $07, $03, $70, $2e ; object 2
    db $83, $01, $52, $00, $00, $30, $b0, $03, $02, $30, $61 ; object 3
    db $83, $01, $52, $00, $00, $50, $b0, $03, $02, $30, $61 ; object 4

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_51D4::
    dw ObjSelector_51DC ; id 0
    dw ObjSelector_523E ; id 1
    dw ObjSelector_5264 ; id 2
    dw ObjSelector_5295 ; id 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_51DC::
    objsel_unless_flag EVENT_WHAT_IS_THAT_DIRTY_MEDAL, MapObjects_51E4
    objsel_list MapObjects_5211

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_51E4::
    db $04 ; entry 0: object count
    db $85, $01, $10, $00, $00, $40, $10, $05, $00, $50, $0b ; object 0
    db $85, $01, $10, $00, $00, $50, $10, $05, $00, $50, $0c ; object 1
    db $86, $01, $2f, $00, $00, $10, $40, $06, $01, $60, $09 ; object 2
    db $87, $01, $30, $00, $00, $70, $70, $07, $02, $70, $0a ; object 3

MapObjects_5211::
    db $04 ; entry 0: object count
    db $85, $01, $10, $00, $00, $30, $20, $05, $00, $50, $0b ; object 0
    db $85, $01, $10, $00, $02, $60, $30, $05, $00, $50, $0c ; object 1
    db $86, $01, $2f, $00, $00, $10, $40, $06, $01, $60, $09 ; object 2
    db $87, $01, $30, $00, $00, $70, $70, $07, $02, $70, $0a ; object 3

ObjSelector_523E::
    objsel_list MapObjects_5242

; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_5242::
    db $03 ; entry 0: object count
    db $85, $01, $2e, $00, $00, $60, $70, $05, $03, $50, $05 ; object 0
    db $86, $01, $2d, $00, $02, $40, $50, $06, $01, $60, $06 ; object 1
    db $87, $01, $12, $00, $00, $20, $30, $07, $00, $70, $82 ; object 2

ObjSelector_5264::
    objsel_list MapObjects_5268

MapObjects_5268::
    db $04 ; entry 0: object count
    db $85, $01, $10, $00, $00, $60, $60, $05, $00, $50, $00 ; object 0
    db $86, $01, $2e, $00, $00, $80, $50, $06, $02, $60, $01 ; object 1
    db $87, $01, $30, $00, $00, $10, $40, $07, $01, $70, $02 ; object 2
    db $86, $01, $2e, $00, $00, $20, $10, $06, $00, $60, $03 ; object 3

ObjSelector_5295::
    objsel_list MapObjects_5299

MapObjects_5299::
    db $04 ; entry 0: object count
    db $85, $01, $2f, $00, $02, $50, $50, $05, $01, $50, $04 ; object 0
    db $85, $01, $2f, $00, $00, $30, $40, $05, $03, $50, $07 ; object 1
    db $86, $01, $12, $00, $00, $80, $60, $06, $03, $60, $08 ; object 2
    db $87, $01, $15, $00, $00, $70, $20, $07, $00, $70, $0d ; object 3

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_52C6::
    dw ObjSelector_52C8 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_52C8::
    objsel_unless_flag EVENT_SCENE_PLAN_RUINED_094, MapObjects_52D0
    objsel_list MapObjects_52E7

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_52D0::
    db $02 ; entry 0: object count
    db $85, $01, $2e, $00, $00, $60, $20, $05, $01, $50, $12 ; object 0
    db $86, $01, $15, $00, $00, $20, $50, $06, $01, $60, $13 ; object 1

; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_52E7::
    db $01 ; entry 0
    db $85, $01, $2e, $00, $00, $60, $20, $05, $01, $50, $12

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_52F3::
    dw ObjSelector_52FB ; id 0
    dw ObjSelector_537E ; id 1
    dw ObjSelector_538E ; id 2
    dw ObjSelector_53EF ; id 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_52FB::
    objsel_skip_if_clear EVENT_SCENE_PLAN_RUINED_094, $04, $00
    objsel_list MapObjects_5367

ObjSelector_5305::
    objsel_skip_if_clear EVENT_SCENE_PLAN_RUINED, $04, $00
    objsel_list MapObjects_5350

ObjSelector_530F::
    objsel_unless_flag EVENT_SCENE_WALL_EXIT, MapObjects_5317
    objsel_list MapObjects_532E

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_5317::
    db $02 ; entry 0: object count
    db $85, $01, $0e, $00, $00, $40, $30, $05, $00, $50, $00 ; object 0
    db $86, $01, $10, $00, $00, $40, $70, $06, $02, $60, $18 ; object 1

; record: count, then 3 object(s), the layout of the other object lists
MapObjects_532E::
    db $03 ; entry 0: object count
    db $85, $00, $d5, $00, $00, $40, $e0, $05, $02, $50, $4d ; object 0
    db $86, $01, $0e, $00, $00, $40, $50, $06, $02, $60, $48 ; object 1
    db $87, $01, $0e, $00, $00, $40, $40, $07, $00, $70, $4d ; object 2

MapObjects_5350::
    db $02 ; entry 0: object count
    db $85, $00, $d5, $00, $00, $40, $40, $05, $00, $50, $4d ; object 0
    db $86, $01, $0e, $00, $00, $40, $50, $06, $02, $60, $48 ; object 1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_5367::
    db $02 ; entry 0: object count
    db $85, $01, $0e, $00, $00, $40, $30, $05, $00, $50, $48 ; object 0
    db $86, $01, $0e, $00, $00, $e0, $e0, $06, $00, $60, $00 ; object 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_537E::
    objsel_list MapObjects_5382

; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_5382::
    db $01 ; entry 0
    db $85, $01, $12, $00, $00, $20, $20, $05, $02, $50, $17

ObjSelector_538E::
    objsel_skip_if_clear EVENT_SCENE_REPORT_TO_KING, $04, $00
    objsel_list MapObjects_53D8

ObjSelector_5398::
    objsel_skip_if_clear EVENT_SCENE_SPIRIT_ENVOY, $04, $00
    objsel_list MapObjects_53AA

ObjSelector_53A2::
    objsel_unless_flag EVENT_AH_YOU_ARE_THE_SPIRIT, MapObjects_53AA
    objsel_list MapObjects_53C1

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_53AA::
    db $02 ; entry 0: object count
    db $85, $01, $10, $00, $00, $50, $00, $05, $00, $50, $15 ; object 0
    db $86, $01, $10, $00, $00, $40, $00, $06, $00, $60, $18 ; object 1

MapObjects_53C1::
    db $02 ; entry 0: object count
    db $85, $01, $10, $00, $00, $50, $00, $05, $00, $50, $15 ; object 0
    db $86, $01, $10, $00, $00, $40, $e0, $06, $00, $60, $18 ; object 1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_53D8::
    db $02 ; entry 0: object count
    db $85, $01, $10, $00, $00, $60, $20, $05, $00, $50, $15 ; object 0
    db $86, $01, $10, $00, $00, $30, $30, $06, $00, $60, $18 ; object 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_53EF::
    objsel_list MapObjects_53F3

; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_53F3::
    db $01 ; entry 0
    db $85, $01, $10, $00, $00, $80, $30, $05, $00, $50, $16

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_53FF::
    dw $0000 ; id 0
    dw ObjSelector_5403 ; id 1

ObjSelector_5403::
    objsel_unless_flag EVENT_SCENE_WALL_EXIT, MapObjects_5409
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_5409::
    db $02 ; entry 0: object count
    db $85, $01, $0e, $00, $00, $70, $30, $05, $00, $50, $48 ; object 0
    db $86, $01, $03, $00, $00, $30, $50, $06, $03, $60, $49 ; object 1

MapObjectScreens_5420::
    dw ObjSelector_5426 ; id 0
    dw $0000 ; id 1
    dw $0000 ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5426::
    objsel_list MapObjects_542A

; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_542A::
    db $01 ; entry 0
    db $85, $01, $2e, $00, $00, $50, $30, $05, $00, $50, $1c

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_5436::
    dw ObjSelector_543E ; id 0
    dw ObjSelector_546F ; id 1
    dw ObjSelector_54C6 ; id 2
    dw ObjSelector_54F7 ; id 3

ObjSelector_543E::
    objsel_list MapObjects_5442

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_5442::
    db $04 ; entry 0: object count
    db $85, $01, $30, $00, $00, $30, $50, $05, $00, $50, $1d ; object 0
    db $85, $01, $30, $00, $00, $50, $40, $05, $00, $50, $1f ; object 1
    db $86, $01, $2f, $00, $02, $70, $60, $06, $01, $60, $20 ; object 2
    db $87, $01, $12, $00, $00, $70, $20, $07, $00, $70, $2c ; object 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_546F::
    objsel_unless_flag EVENT_SCENE_SHIELD2_1E5, MapObjects_5477
    objsel_list MapObjects_54A4

MapObjects_5477::
    db $04 ; entry 0: object count
    db $85, $01, $16, $00, $00, $10, $30, $05, $01, $50, $29 ; object 0
    db $86, $01, $15, $00, $00, $70, $20, $06, $00, $60, $2a ; object 1
    db $86, $01, $15, $00, $00, $80, $40, $06, $03, $60, $2b ; object 2
    db $87, $01, $29, $00, $00, $70, $50, $07, $01, $70, $28 ; object 3

; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_54A4::
    db $03 ; entry 0: object count
    db $85, $01, $16, $00, $00, $10, $30, $05, $01, $50, $29 ; object 0
    db $86, $01, $15, $00, $00, $70, $20, $06, $00, $60, $2a ; object 1
    db $86, $01, $15, $00, $00, $80, $40, $06, $03, $60, $2b ; object 2

ObjSelector_54C6::
    objsel_list MapObjects_54CA

MapObjects_54CA::
    db $04 ; entry 0: object count
    db $85, $01, $2e, $00, $00, $10, $20, $05, $00, $50, $21 ; object 0
    db $86, $01, $2d, $00, $02, $40, $50, $06, $01, $60, $22 ; object 1
    db $85, $01, $2e, $00, $00, $60, $60, $05, $00, $50, $23 ; object 2
    db $87, $01, $2f, $00, $00, $70, $10, $07, $03, $70, $24 ; object 3

ObjSelector_54F7::
    objsel_list MapObjects_54FB

MapObjects_54FB::
    db $04 ; entry 0: object count
    db $85, $01, $2e, $00, $00, $40, $50, $05, $00, $50, $1e ; object 0
    db $86, $01, $30, $00, $00, $80, $20, $06, $03, $60, $25 ; object 1
    db $85, $01, $2e, $00, $00, $20, $30, $05, $00, $50, $26 ; object 2
    db $87, $01, $10, $00, $00, $20, $10, $07, $01, $70, $27 ; object 3

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_5528::
    dw ObjSelector_552A ; id 0

ObjSelector_552A::
    objsel_unless_flag EVENT_SCENE_SHIELD2_1E5, MapObjects_5532
    objsel_list MapObjects_555F

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_5532::
    db $04 ; entry 0: object count
    db $85, $01, $16, $00, $00, $20, $20, $05, $01, $50, $31 ; object 0
    db $85, $01, $16, $00, $00, $40, $30, $05, $02, $50, $32 ; object 1
    db $86, $01, $17, $00, $00, $40, $50, $06, $00, $60, $33 ; object 2
    db $87, $01, $21, $00, $00, $10, $60, $07, $00, $70, $34 ; object 3

; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_555F::
    db $02 ; entry 0: object count
    db $85, $01, $16, $00, $00, $20, $20, $05, $01, $50, $31 ; object 0
    db $86, $01, $17, $00, $00, $40, $50, $06, $00, $60, $33 ; object 1

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_5576::
    dw ObjSelector_5578 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5578::
    objsel_list MapObjects_557C

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_557C::
    db $02 ; entry 0: object count
    db $85, $01, $2e, $00, $00, $10, $10, $05, $01, $50, $36 ; object 0
    db $86, $01, $29, $00, $00, $20, $70, $06, $02, $60, $37 ; object 1

MapObjectScreens_69_5593::
    db $99, $55, $00, $00, $b4, $55

ObjSelector_5599::
    objsel_list MapObjects_559D

MapObjects_559D::
    db $02 ; entry 0: object count
    db $85, $01, $52, $00, $00, $40, $30, $05, $00, $50, $3c ; object 0
    db $86, $01, $52, $00, $00, $70, $40, $06, $03, $60, $3d ; object 1

ObjSelector_55B4::
    objsel_unless_flag EVENT_SCENE_PLAN_RUINED_094, MapObjects_55BC
    objsel_list MapObjects_55E9

; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_55BC::
    db $04 ; entry 0: object count
    db $85, $01, $10, $00, $00, $30, $30, $05, $00, $50, $38 ; object 0
    db $85, $01, $10, $00, $00, $00, $40, $05, $01, $50, $39 ; object 1
    db $85, $01, $10, $00, $00, $00, $50, $05, $01, $50, $3a ; object 2
    db $86, $01, $16, $00, $00, $70, $60, $06, $00, $60, $3b ; object 3

MapObjects_55E9::
    db $04 ; entry 0: object count
    db $85, $01, $10, $00, $00, $30, $30, $05, $00, $50, $38 ; object 0
    db $85, $01, $10, $00, $00, $60, $40, $05, $00, $50, $39 ; object 1
    db $85, $01, $10, $00, $00, $60, $50, $05, $02, $50, $3a ; object 2
    db $86, $01, $16, $00, $00, $70, $60, $06, $00, $60, $3b ; object 3

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_5616::
    dw $0000 ; id 0
    dw $0000 ; id 1
    dw ObjSelector_5636 ; id 2
    dw $0000 ; id 3
    dw $0000 ; id 4
    dw $0000 ; id 5
    dw $0000 ; id 6
    dw $0000 ; id 7
    dw $0000 ; id 8
    dw $0000 ; id 9
    dw $0000 ; id 10
    dw $0000 ; id 11
    dw ObjSelector_5646 ; id 12
    dw $0000 ; id 13
    dw $0000 ; id 14
    dw $0000 ; id 15

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5636::
    objsel_list MapObjects_563A

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_563A::
    db $01 ; entry 0
    db $85, $01, $16, $00, $00, $70, $30, $05, $00, $50, $3f

ObjSelector_5646::
    objsel_unless_flag EVENT_SCENE_PLAN_RUINED_094, MapObjects_564E
    objsel_list MapObjects_5670

; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_564E::
    db $03 ; entry 0: object count
    db $85, $01, $52, $00, $00, $40, $60, $05, $02, $50, $3c ; object 0
    db $86, $01, $52, $00, $00, $50, $60, $06, $02, $60, $3d ; object 1
    db $87, $01, $16, $00, $02, $50, $20, $07, $01, $70, $3e ; object 2

MapObjects_5670::
    db $01 ; entry 0
    db $85, $01, $16, $00, $02, $50, $20, $05, $01, $50, $3e

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_567C::
    dw ObjSelector_567E ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_567E::
    objsel_list MapObjects_5682

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_5682::
    db $01 ; entry 0
    db $85, $01, $52, $00, $00, $60, $30, $05, $00, $50, $40

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_568E::
    dw $0000 ; id 0
    dw ObjSelector_5692 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5692::
    objsel_list MapObjects_5696

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_5696::
    db $01 ; entry 0
    db $85, $01, $16, $00, $00, $50, $50, $05, $03, $50, $41

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_56A2::
    dw ObjSelector_56A8 ; id 0
    dw ObjSelector_56BA ; id 1
    dw ObjSelector_570E ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_56A8::
    objsel_unless_flag EVENT_SCENE_GOT_TO, MapObjects_56AE
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_56AE::
    db $01 ; entry 0
    db $85, $01, $16, $00, $02, $60, $10, $05, $01, $50, $44

ObjSelector_56BA::
    objsel_skip_if_clear EVENT_SCENE_GOT_TO, $02, $00
    objsel_none

ObjSelector_56C2::
    objsel_unless_flag EVENT_SCENE_EXPLOSION, MapObjects_56CA
    objsel_list MapObjects_56EC

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_56CA::
    db $03 ; entry 0: object count
    db $85, $00, $34, $01, $00, $40, $e0, $05, $00, $50, $46 ; object 0
    db $86, $01, $10, $00, $00, $b0, $10, $06, $02, $60, $00 ; object 1
    db $87, $01, $52, $00, $00, $e0, $10, $07, $00, $70, $00 ; object 2

MapObjects_56EC::
    db $03 ; entry 0: object count
    db $85, $00, $34, $01, $00, $40, $20, $05, $00, $50, $46 ; object 0
    db $86, $01, $10, $00, $00, $b0, $10, $06, $02, $60, $00 ; object 1
    db $87, $01, $52, $00, $00, $e0, $10, $07, $00, $70, $00 ; object 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_570E::
    objsel_unless_flag EVENT_SCENE_GOT_TO, MapObjects_5714
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_5714::
    db $02 ; entry 0: object count
    db $85, $01, $16, $00, $02, $30, $10, $05, $01, $50, $42 ; object 0
    db $86, $01, $10, $00, $00, $70, $30, $06, $02, $60, $43 ; object 1

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_572B::
    dw ObjSelector_5733 ; id 0
    dw ObjSelector_5764 ; id 1
    dw ObjSelector_5795 ; id 2
    dw ObjSelector_57C6 ; id 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5733::
    objsel_list MapObjects_5737

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_5737::
    db $04 ; entry 0: object count
    db $85, $01, $52, $00, $00, $60, $40, $05, $00, $50, $56 ; object 0
    db $86, $01, $2e, $00, $00, $30, $70, $06, $03, $60, $57 ; object 1
    db $87, $01, $2f, $00, $00, $30, $10, $07, $00, $70, $58 ; object 2
    db $84, $01, $12, $00, $00, $70, $20, $04, $00, $40, $83 ; object 3

ObjSelector_5764::
    objsel_list MapObjects_5768

MapObjects_5768::
    db $04 ; entry 0: object count
    db $85, $01, $30, $00, $00, $10, $20, $05, $00, $50, $52 ; object 0
    db $86, $01, $2d, $00, $00, $80, $30, $06, $01, $60, $53 ; object 1
    db $87, $01, $2e, $00, $00, $70, $60, $07, $02, $70, $54 ; object 2
    db $87, $01, $2e, $00, $02, $40, $50, $07, $01, $70, $55 ; object 3

ObjSelector_5795::
    objsel_list MapObjects_5799

MapObjects_5799::
    db $04 ; entry 0: object count
    db $85, $01, $2f, $00, $00, $40, $40, $05, $00, $50, $4e ; object 0
    db $86, $01, $2e, $00, $00, $10, $60, $06, $01, $60, $4f ; object 1
    db $87, $01, $15, $00, $00, $70, $50, $07, $00, $70, $50 ; object 2
    db $85, $01, $2f, $00, $02, $30, $10, $05, $00, $50, $51 ; object 3

ObjSelector_57C6::
    objsel_list MapObjects_57CA

; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_57CA::
    db $02 ; entry 0: object count
    db $85, $01, $2d, $00, $00, $30, $50, $05, $00, $50, $59 ; object 0
    db $86, $01, $30, $00, $02, $60, $40, $06, $01, $60, $5a ; object 1

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_57E1::
    dw ObjSelector_57E5 ; id 0
    dw ObjSelector_5800 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_57E5::
    objsel_list MapObjects_57E9

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_57E9::
    db $02 ; entry 0: object count
    db $85, $01, $2e, $00, $00, $80, $10, $05, $00, $50, $5e ; object 0
    db $86, $01, $15, $00, $00, $60, $10, $06, $00, $60, $5f ; object 1

ObjSelector_5800::
    objsel_list MapObjects_5804

; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_5804::
    db $01 ; entry 0
    db $85, $01, $29, $00, $00, $20, $20, $05, $00, $50, $60

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_5810::
    dw ObjSelector_5814 ; id 0
    dw ObjSelector_585D ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5814::
    objsel_skip_if_clear EVENT_SCENE_SHIELD2_1E5, $04, $00
    objsel_list MapObjects_5851

ObjSelector_581E::
    objsel_unless_flag EVENT_SCENE_CHEER_YUNA, MapObjects_5824
    objsel_none

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 4 object(s), the layout of the other object lists
MapObjects_5824::
    db $04 ; entry 0: object count
    db $85, $01, $52, $00, $00, $80, $60, $05, $00, $50, $61 ; object 0
    db $85, $01, $52, $00, $00, $40, $50, $05, $00, $50, $67 ; object 1
    db $86, $01, $15, $00, $02, $20, $70, $06, $01, $60, $63 ; object 2
    db $87, $01, $4c, $00, $00, $60, $80, $07, $02, $70, $65 ; object 3

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_5851::
    db $01 ; entry 0
    db $87, $01, $42, $00, $00, $30, $50, $07, $00, $70, $2e

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_585D::
    objsel_skip_if_clear EVENT_SCENE_CHEER_YUNA, $04, $00
    objsel_list MapObjects_58A8

ObjSelector_5867::
    objsel_unless_flag EVENT_GATHER_FOLLOWERS, MapObjects_586F
    objsel_list MapObjects_589C

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 4 object(s), the layout of the other object lists
MapObjects_586F::
    db $04 ; entry 0: object count
    db $85, $01, $52, $00, $00, $30, $40, $05, $01, $50, $66 ; object 0
    db $86, $01, $4c, $00, $00, $40, $40, $06, $02, $60, $62 ; object 1
    db $86, $01, $4c, $00, $00, $40, $50, $06, $02, $60, $64 ; object 2
    db $87, $01, $03, $00, $00, $40, $a0, $07, $02, $70, $00 ; object 3

; record: count, then 1 object(s), the layout of the other object lists
MapObjects_589C::
    db $01 ; entry 0
    db $85, $01, $52, $00, $00, $30, $50, $05, $00, $50, $66

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_58A8::
    db $03 ; entry 0: object count
    db $85, $01, $52, $00, $00, $20, $50, $05, $00, $50, $66 ; object 0
    db $86, $01, $52, $00, $00, $70, $60, $06, $03, $60, $61 ; object 1
    db $87, $01, $52, $00, $00, $10, $70, $07, $00, $70, $67 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_58CA::
    dw ObjSelector_58D2 ; id 0
    dw ObjSelector_58ED ; id 1
    dw ObjSelector_5944 ; id 2
    dw ObjSelector_595F ; id 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_58D2::
    objsel_list MapObjects_58D6

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_58D6::
    db $02 ; entry 0: object count
    db $85, $01, $52, $00, $00, $70, $40, $05, $00, $50, $6e ; object 0
    db $86, $01, $14, $00, $00, $20, $10, $06, $02, $60, $6b ; object 1

ObjSelector_58ED::
    objsel_skip_if_clear EVENT_YOU_WILL_THANK_YOU_LET, $04, $00
    objsel_list MapObjects_5938

ObjSelector_58F7::
    objsel_unless_flag EVENT_SCENE_CHEER_YUNA, MapObjects_58FF
    objsel_list MapObjects_5921

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_58FF::
    db $03 ; entry 0: object count
    db $85, $01, $0e, $00, $00, $40, $20, $05, $00, $50, $71 ; object 0
    db $86, $01, $3a, $00, $00, $50, $20, $06, $00, $60, $72 ; object 1
    db $87, $01, $03, $00, $00, $40, $40, $07, $02, $70, $00 ; object 2

; record: count, then 2 object(s), the layout of the other object lists
MapObjects_5921::
    db $02 ; entry 0: object count
    db $85, $01, $0e, $00, $00, $40, $20, $05, $00, $50, $71 ; object 0
    db $86, $01, $3a, $00, $00, $50, $20, $06, $00, $60, $72 ; object 1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_5938::
    db $01 ; entry 0
    db $85, $01, $0e, $00, $00, $40, $20, $05, $00, $50, $71

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5944::
    objsel_list MapObjects_5948

; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_5948::
    db $02 ; entry 0: object count
    db $86, $01, $12, $00, $00, $30, $60, $06, $03, $60, $6c ; object 0
    db $87, $01, $52, $00, $00, $10, $20, $07, $02, $70, $6a ; object 1

ObjSelector_595F::
    objsel_unless_flag EVENT_SCENE_CHEER_YUNA, MapObjects_5967
    objsel_list MapObjects_5989

; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_5967::
    db $03 ; entry 0: object count
    db $85, $01, $12, $00, $00, $40, $10, $05, $00, $50, $6f ; object 0
    db $86, $01, $52, $00, $00, $50, $10, $06, $00, $60, $69 ; object 1
    db $87, $01, $52, $00, $02, $60, $40, $07, $01, $70, $6d ; object 2

; an object list of LoadMapObjectsForScreen (E-0163)
MapObjects_5989::
    db $03 ; entry 0: object count
    db $85, $01, $12, $00, $00, $30, $30, $05, $00, $50, $6f ; object 0
    db $86, $01, $52, $00, $00, $60, $20, $06, $00, $60, $69 ; object 1
    db $87, $01, $52, $00, $02, $60, $40, $07, $01, $70, $6d ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_59AB::
    dw $0000 ; id 0
    dw ObjSelector_59AF ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_59AF::
    objsel_skip_if_clear EVENT_SCENE_PRINCESS_MEDICINE_09D, $04, $00
    objsel_list MapObjects_59FA

ObjSelector_59B9::
    objsel_unless_flag EVENT_YOU_WILL_THANK_YOU_LET, MapObjects_59C1
    objsel_list MapObjects_59D8

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_59C1::
    db $02 ; entry 0: object count
    db $85, $01, $3a, $00, $00, $e0, $e0, $05, $03, $50, $72 ; object 0
    db $86, $01, $59, $00, $00, $80, $10, $06, $00, $60, $9a ; object 1

; record: count, then 3 object(s), the layout of the other object lists
MapObjects_59D8::
    db $03 ; entry 0: object count
    db $85, $01, $3a, $00, $00, $60, $30, $05, $03, $50, $72 ; object 0
    db $86, $01, $59, $00, $00, $80, $10, $06, $00, $60, $9a ; object 1
    db $87, $00, $21, $01, $00, $80, $e0, $07, $00, $70, $9a ; object 2

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_59FA::
    db $01 ; entry 0
    db $85, $01, $3a, $00, $00, $60, $30, $05, $03, $50, $72

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_5A06::
    dw $0000 ; id 0
    dw $0000 ; id 1
    dw ObjSelector_5A26 ; id 2
    dw $0000 ; id 3
    dw $0000 ; id 4
    dw $0000 ; id 5
    dw ObjSelector_5A67 ; id 6
    dw $0000 ; id 7
    dw $0000 ; id 8
    dw $0000 ; id 9
    dw ObjSelector_5A6D ; id 10
    dw $0000 ; id 11
    dw $0000 ; id 12
    dw $0000 ; id 13
    dw ObjSelector_5A73 ; id 14
    dw $0000 ; id 15

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5A26::
    objsel_unless_flag EVENT_SCENE_SHIELD2_1E5, MapObjects_5A2E
    objsel_list MapObjects_5A50

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_5A2E::
    db $03 ; entry 0: object count
    db $85, $01, $2e, $00, $00, $30, $50, $05, $01, $50, $92 ; object 0
    db $86, $01, $2f, $00, $02, $60, $30, $06, $01, $60, $93 ; object 1
    db $87, $01, $42, $00, $02, $50, $60, $07, $01, $70, $2e ; object 2

; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_5A50::
    db $02 ; entry 0: object count
    db $85, $01, $2e, $00, $00, $30, $50, $05, $01, $50, $92 ; object 0
    db $86, $01, $2f, $00, $02, $60, $30, $06, $01, $60, $93 ; object 1

ObjSelector_5A67::
    objsel_unless_flag EVENT_SCENE_SPIRIT_ENVOY2, MapObjects_5A79
    objsel_none

ObjSelector_5A6D::
    objsel_unless_flag EVENT_SCENE_SPIRIT_ENVOY2_099, MapObjects_5A79
    objsel_none

ObjSelector_5A73::
    objsel_unless_flag EVENT_YOU_WILL_THANK_YOU_LET, MapObjects_5A79
    objsel_none

; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_5A79::
    db $01 ; entry 0
    db $85, $01, $3a, $00, $00, $50, $40, $05, $02, $50, $99

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_5A85::
    dw ObjSelector_5A8D ; id 0
    dw ObjSelector_5AE4 ; id 1
    dw ObjSelector_5B46 ; id 2
    dw ObjSelector_5B77 ; id 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5A8D::
    objsel_unless_flag EVENT_SCENE_SHIELD2_1E5, MapObjects_5A95
    objsel_list MapObjects_5AB7

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_5A95::
    db $03 ; entry 0: object count
    db $85, $01, $2f, $00, $00, $60, $50, $05, $00, $50, $78 ; object 0
    db $86, $01, $2f, $00, $00, $40, $20, $06, $00, $60, $7e ; object 1
    db $87, $01, $14, $00, $00, $80, $30, $07, $03, $70, $7f ; object 2

; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_5AB7::
    db $04 ; entry 0: object count
    db $85, $01, $2f, $00, $00, $60, $50, $05, $00, $50, $78 ; object 0
    db $85, $01, $2f, $00, $00, $40, $10, $05, $02, $50, $7e ; object 1
    db $86, $01, $14, $00, $00, $80, $30, $06, $03, $60, $7f ; object 2
    db $87, $01, $21, $00, $00, $50, $20, $07, $00, $70, $9b ; object 3

ObjSelector_5AE4::
    objsel_unless_flag EVENT_OH_AN_ENVOY_FROM_THE, MapObjects_5AEC
    objsel_list MapObjects_5B19

MapObjects_5AEC::
    db $04 ; entry 0: object count
    db $85, $01, $10, $00, $00, $40, $10, $05, $00, $50, $7c ; object 0
    db $85, $01, $10, $00, $00, $50, $10, $05, $00, $50, $7c ; object 1
    db $86, $01, $2e, $00, $00, $70, $70, $06, $03, $60, $79 ; object 2
    db $87, $01, $2d, $00, $02, $60, $40, $07, $01, $70, $77 ; object 3

MapObjects_5B19::
    db $04 ; entry 0: object count
    db $85, $01, $10, $00, $00, $30, $30, $05, $00, $50, $7c ; object 0
    db $85, $01, $10, $00, $00, $60, $20, $05, $00, $50, $7c ; object 1
    db $86, $01, $2e, $00, $00, $70, $70, $06, $03, $60, $79 ; object 2
    db $87, $01, $2d, $00, $02, $60, $40, $07, $01, $70, $77 ; object 3

ObjSelector_5B46::
    objsel_list MapObjects_5B4A

MapObjects_5B4A::
    db $04 ; entry 0: object count
    db $85, $01, $2e, $00, $00, $70, $40, $05, $01, $50, $74 ; object 0
    db $86, $01, $2f, $00, $00, $60, $70, $06, $01, $60, $75 ; object 1
    db $85, $01, $2e, $00, $00, $40, $50, $05, $02, $50, $76 ; object 2
    db $87, $01, $12, $00, $00, $50, $10, $07, $00, $70, $80 ; object 3

ObjSelector_5B77::
    objsel_list MapObjects_5B7B

MapObjects_5B7B::
    db $04 ; entry 0: object count
    db $85, $01, $30, $00, $00, $60, $60, $05, $00, $50, $73 ; object 0
    db $86, $01, $2f, $00, $00, $20, $50, $06, $03, $60, $7a ; object 1
    db $86, $01, $2f, $00, $00, $50, $30, $06, $00, $60, $7b ; object 2
    db $87, $01, $15, $00, $00, $80, $20, $07, $03, $70, $7d ; object 3

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_5BA8::
    dw ObjSelector_5BAA ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5BAA::
    objsel_unless_flag EVENT_SCENE_SHIELD2_1E5, MapObjects_5BB2
    objsel_list MapObjects_5BDF

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_5BB2::
    db $04 ; entry 0: object count
    db $85, $01, $2e, $00, $00, $40, $60, $05, $02, $50, $86 ; object 0
    db $86, $01, $15, $00, $00, $20, $20, $06, $00, $60, $87 ; object 1
    db $85, $01, $2e, $00, $00, $50, $40, $05, $03, $50, $88 ; object 2
    db $87, $01, $29, $00, $00, $10, $70, $07, $01, $70, $89 ; object 3

; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_5BDF::
    db $03 ; entry 0: object count
    db $85, $01, $2e, $00, $00, $40, $60, $05, $02, $50, $86 ; object 0
    db $86, $01, $2e, $00, $00, $50, $40, $06, $03, $60, $88 ; object 1
    db $87, $01, $29, $00, $00, $10, $70, $07, $01, $70, $89 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_5C01::
    dw ObjSelector_5C07 ; id 0
    dw ObjSelector_5C71 ; id 1
    dw ObjSelector_5CB2 ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5C07::
    objsel_skip_if_set $0025, $0a, $00
    objsel_skip_if_clear EVENT_SCENE_DARCK_DEFEATED, $04, $00
    objsel_list MapObjects_5C39

ObjSelector_5C17::
    objsel_skip_if_clear EVENT_SCENE_SHIELD2_1E5, $04, $00
    objsel_list MapObjects_5C2D

ObjSelector_5C21::
    objsel_skip_if_clear EVENT_SCENE_PRINCESS_MEDICINE_09D, $02, $00
    objsel_none

ObjSelector_5C29::
    objsel_list MapObjects_5C2D

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_5C2D::
    db $01 ; entry 0
    db $85, $01, $0f, $00, $00, $40, $10, $05, $00, $50, $90

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 5 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_5C39::
    db $05 ; entry 0: object count
    db $85, $01, $0f, $00, $00, $40, $10, $05, $00, $50, $90 ; object 0
    db $86, $01, $10, $00, $00, $30, $60, $06, $00, $60, $8e ; object 1
    db $86, $01, $10, $00, $00, $60, $60, $06, $00, $60, $8e ; object 2
    db $87, $01, $2a, $00, $00, $30, $20, $07, $00, $70, $8d ; object 3
    db $83, $01, $30, $00, $00, $40, $b0, $03, $02, $30, $73 ; object 4

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5C71::
    objsel_unless_flag EVENT_SCENE_MEDICINE_GIVEN, MapObjects_5C79
    objsel_list MapObjects_5C9B

; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_5C79::
    db $03 ; entry 0: object count
    db $85, $01, $10, $00, $00, $30, $10, $05, $01, $50, $8e ; object 0
    db $86, $01, $12, $00, $00, $20, $50, $06, $02, $60, $8f ; object 1
    db $87, $01, $2a, $00, $00, $60, $60, $07, $03, $70, $8d ; object 2

; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_5C9B::
    db $02 ; entry 0: object count
    db $85, $01, $10, $00, $00, $30, $10, $05, $01, $50, $8e ; object 0
    db $86, $01, $12, $00, $00, $20, $50, $06, $02, $60, $8f ; object 1

ObjSelector_5CB2::
    objsel_list MapObjects_5CB6

; an object list of LoadMapObjectsForScreen (E-0163)
MapObjects_5CB6::
    db $03 ; entry 0: object count
    db $85, $01, $10, $00, $00, $30, $10, $05, $00, $50, $8a ; object 0
    db $86, $01, $10, $00, $02, $50, $40, $06, $01, $60, $8b ; object 1
    db $87, $01, $12, $00, $00, $20, $50, $07, $00, $70, $8c ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_5CD8::
    dw ObjSelector_5CDC ; id 0
    dw ObjSelector_5D8B ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5CDC::
    objsel_skip_if_clear EVENT_SCENE_SHIELD2_1E5, $04, $00
    objsel_list MapObjects_5D7F

ObjSelector_5CE6::
    objsel_skip_if_clear EVENT_SCENE_SHIELD_GUARDIAN_1E2, $04, $00
    objsel_list MapObjects_5D68

ObjSelector_5CF0::
    objsel_skip_if_clear EVENT_SCENE_SHIELD_GUARDIAN, $04, $00
    objsel_list MapObjects_5D46

ObjSelector_5CFA::
    objsel_unless_flag EVENT_SCENE_MEDICINE_GIVEN, MapObjects_5D02
    objsel_list MapObjects_5D24

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_5D02::
    db $03 ; entry 0: object count
    db $85, $01, $46, $00, $00, $40, $30, $05, $00, $50, $90 ; object 0
    db $86, $01, $2a, $00, $00, $50, $70, $06, $02, $60, $8d ; object 1
    db $87, $00, $e0, $00, $00, $40, $e0, $07, $00, $70, $9e ; object 2

MapObjects_5D24::
    db $03 ; entry 0: object count
    db $85, $01, $46, $00, $00, $40, $30, $05, $00, $50, $90 ; object 0
    db $86, $01, $2a, $00, $00, $50, $40, $06, $02, $60, $8d ; object 1
    db $87, $00, $e0, $00, $00, $40, $e0, $07, $00, $70, $9e ; object 2

MapObjects_5D46::
    db $03 ; entry 0: object count
    db $85, $01, $46, $00, $00, $40, $30, $05, $00, $50, $90 ; object 0
    db $86, $01, $2a, $00, $00, $50, $40, $06, $02, $60, $8d ; object 1
    db $87, $00, $e0, $00, $00, $40, $20, $07, $00, $70, $9e ; object 2

; record: count, then 2 object(s), the layout of the other object lists
MapObjects_5D68::
    db $02 ; entry 0: object count
    db $85, $01, $0f, $00, $00, $60, $40, $05, $00, $50, $90 ; object 0
    db $86, $01, $2a, $00, $02, $30, $50, $06, $00, $60, $8d ; object 1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_5D7F::
    db $01 ; entry 0
    db $85, $01, $2a, $00, $02, $30, $50, $05, $01, $50, $8d

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5D8B::
    objsel_unless_flag EVENT_SCENE_MEDICINE_GIVEN, MapObjects_5D91
    objsel_none

MapObjects_5D91::
    db $01 ; entry 0
    db $85, $01, $2a, $00, $00, $70, $60, $05, $03, $50, $8d

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_5D9D::
    dw $0000 ; id 0
    dw $0000 ; id 1
    dw $0000 ; id 2
    dw $0000 ; id 3
    dw $0000 ; id 4
    dw $0000 ; id 5
    dw $0000 ; id 6
    dw $0000 ; id 7
    dw $0000 ; id 8
    dw $0000 ; id 9
    dw $0000 ; id 10
    dw $0000 ; id 11
    dw $0000 ; id 12
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
    dw ObjSelector_5E1D ; id 23
    dw $0000 ; id 24
    dw $0000 ; id 25
    dw $0000 ; id 26
    dw $0000 ; id 27
    dw $0000 ; id 28
    dw $0000 ; id 29
    dw $0000 ; id 30
    dw $0000 ; id 31
    dw $0000 ; id 32
    dw $0000 ; id 33
    dw $0000 ; id 34
    dw $0000 ; id 35
    dw $0000 ; id 36
    dw $0000 ; id 37
    dw $0000 ; id 38
    dw $0000 ; id 39
    dw $0000 ; id 40
    dw $0000 ; id 41
    dw $0000 ; id 42
    dw $0000 ; id 43
    dw $0000 ; id 44
    dw ObjSelector_5E37 ; id 45
    dw $0000 ; id 46
    dw $0000 ; id 47
    dw $0000 ; id 48
    dw $0000 ; id 49
    dw $0000 ; id 50
    dw $0000 ; id 51
    dw $0000 ; id 52
    dw $0000 ; id 53
    dw $0000 ; id 54
    dw $0000 ; id 55
    dw $0000 ; id 56
    dw $0000 ; id 57
    dw $0000 ; id 58
    dw $0000 ; id 59
    dw $0000 ; id 60
    dw $0000 ; id 61
    dw $0000 ; id 62
    dw $0000 ; id 63

ObjSelector_5E1D::
    objsel_skip_if_set EVENT_SCENE_MERMAID_KINGDOM_022, $02, $00
    objsel_none

ObjSelector_5E25::
    objsel_unless_flag EVENT_THICK_SUCTION_CUPPED_TENTACLES_SNAKED, MapObjects_5E2B
    objsel_none

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_5E2B::
    db $01 ; entry 0
    db $85, $00, $53, $01, $00, $50, $50, $05, $00, $50, $6c

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5E37::
    objsel_skip_if_clear EVENT_SCENE_CRATE, $02, $00
    objsel_none

ObjSelector_5E3F::
    objsel_skip_if_set EVENT_WELCOME_YOUNG_HUMAN_I_HEARD, $02, $00
    objsel_none

ObjSelector_5E47::
    objsel_list MapObjects_5E4B

MapObjects_5E4B::
    db $01 ; entry 0
    db $85, $01, $55, $00, $02, $40, $40, $05, $00, $50, $46

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_5E57::
    dw ObjSelector_5E5B ; id 0
    dw ObjSelector_5E8C ; id 1

ObjSelector_5E5B::
    objsel_list MapObjects_5E5F

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_5E5F::
    db $04 ; entry 0: object count
    db $85, $01, $0c, $00, $00, $20, $30, $05, $01, $50, $04 ; object 0
    db $86, $01, $0b, $00, $00, $50, $40, $06, $00, $60, $05 ; object 1
    db $85, $01, $0c, $00, $00, $30, $60, $05, $00, $50, $06 ; object 2
    db $87, $01, $06, $00, $00, $70, $50, $07, $00, $70, $03 ; object 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5E8C::
    objsel_list MapObjects_5E90

MapObjects_5E90::
    db $04 ; entry 0: object count
    db $85, $01, $08, $00, $00, $60, $60, $05, $00, $50, $00 ; object 0
    db $86, $01, $09, $00, $00, $80, $40, $06, $03, $60, $01 ; object 1
    db $85, $01, $08, $00, $02, $30, $50, $05, $01, $50, $02 ; object 2
    db $87, $01, $15, $00, $00, $10, $30, $07, $01, $70, $07 ; object 3

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_5EBD::
    dw ObjSelector_5EC5 ; id 0
    dw ObjSelector_5EF6 ; id 1
    dw ObjSelector_5F1C ; id 2
    dw ObjSelector_5F4D ; id 3

ObjSelector_5EC5::
    objsel_list MapObjects_5EC9

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_5EC9::
    db $04 ; entry 0: object count
    db $85, $01, $0b, $00, $00, $20, $20, $05, $01, $50, $1a ; object 0
    db $86, $01, $08, $00, $02, $60, $40, $06, $01, $60, $1b ; object 1
    db $87, $01, $06, $00, $00, $20, $50, $07, $01, $70, $23 ; object 2
    db $86, $01, $08, $00, $00, $30, $70, $06, $02, $60, $1c ; object 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5EF6::
    objsel_list MapObjects_5EFA

; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_5EFA::
    db $03 ; entry 0: object count
    db $85, $01, $08, $00, $00, $50, $60, $05, $03, $50, $1e ; object 0
    db $86, $01, $09, $00, $02, $30, $40, $06, $01, $60, $1f ; object 1
    db $87, $01, $15, $00, $00, $70, $20, $07, $00, $70, $20 ; object 2

ObjSelector_5F1C::
    objsel_list MapObjects_5F20

MapObjects_5F20::
    db $04 ; entry 0: object count
    db $85, $01, $0a, $00, $00, $80, $40, $05, $03, $50, $21 ; object 0
    db $86, $01, $15, $00, $00, $40, $50, $06, $03, $60, $22 ; object 1
    db $85, $01, $0a, $00, $00, $60, $20, $05, $00, $50, $24 ; object 2
    db $87, $01, $12, $00, $00, $30, $10, $07, $00, $70, $1d ; object 3

ObjSelector_5F4D::
    objsel_list MapObjects_5F51

MapObjects_5F51::
    db $03 ; entry 0: object count
    db $85, $01, $0c, $00, $00, $70, $60, $05, $00, $50, $25 ; object 0
    db $86, $01, $09, $00, $00, $60, $30, $06, $00, $60, $26 ; object 1
    db $87, $01, $16, $00, $02, $20, $40, $07, $01, $70, $27 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_5F73::
    dw ObjSelector_5F77 ; id 0
    dw ObjSelector_5FE5 ; id 1

ObjSelector_5F77::
    objsel_skip_if_set $0025, $0a, $00
    objsel_skip_if_clear EVENT_SCENE_DARCK_DEFEATED, $04, $00
    objsel_list MapObjects_5FB8

ObjSelector_5F87::
    objsel_list MapObjects_5F8B

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 4 object(s), the layout of the other object lists
MapObjects_5F8B::
    db $04 ; entry 0: object count
    db $85, $01, $16, $00, $00, $50, $30, $05, $00, $50, $30 ; object 0
    db $86, $01, $29, $00, $00, $70, $50, $06, $00, $60, $31 ; object 1
    db $86, $01, $29, $00, $00, $70, $60, $06, $02, $60, $32 ; object 2
    db $87, $01, $0c, $00, $00, $20, $40, $07, $01, $70, $33 ; object 3

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_5FB8::
    db $04 ; entry 0: object count
    db $85, $01, $16, $00, $00, $50, $30, $05, $00, $50, $30 ; object 0
    db $86, $01, $06, $00, $00, $40, $b0, $06, $02, $60, $23 ; object 1
    db $87, $00, $48, $01, $00, $40, $c0, $07, $02, $70, $23 ; object 2
    db $83, $01, $0c, $00, $00, $20, $40, $03, $01, $30, $33 ; object 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5FE5::
    objsel_unless_flag EVENT_THE_PIRATES, MapObjects_5FED
    objsel_list MapObjects_600F

; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_5FED::
    db $03 ; entry 0: object count
    db $85, $01, $03, $00, $00, $40, $e0, $05, $00, $50, $00 ; object 0
    db $86, $01, $28, $00, $00, $30, $d0, $06, $00, $60, $00 ; object 1
    db $87, $01, $29, $00, $00, $50, $d0, $07, $00, $70, $00 ; object 2

; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_600F::
    db $02 ; entry 0: object count
    db $85, $01, $0a, $00, $00, $60, $10, $05, $00, $50, $3b ; object 0
    db $86, $01, $29, $00, $00, $60, $30, $06, $02, $60, $3c ; object 1

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_6026::
    dw ObjSelector_6028 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6028::
    objsel_list MapObjects_602C

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_602C::
    db $03 ; entry 0: object count
    db $85, $01, $0a, $00, $00, $30, $10, $05, $00, $50, $2c ; object 0
    db $86, $01, $16, $00, $00, $20, $50, $06, $00, $60, $2d ; object 1
    db $87, $01, $29, $00, $00, $20, $70, $07, $02, $70, $2e ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_604E::
    dw $0000 ; id 0
    dw $0000 ; id 1
    dw $0000 ; id 2
    dw $0000 ; id 3
    dw $0000 ; id 4
    dw $0000 ; id 5
    dw $0000 ; id 6
    dw $0000 ; id 7
    dw $0000 ; id 8
    dw $0000 ; id 9
    dw $0000 ; id 10
    dw $0000 ; id 11
    dw $0000 ; id 12
    dw $0000 ; id 13
    dw $0000 ; id 14
    dw ObjSelector_606E ; id 15

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_606E::
    objsel_unless_flag EVENT_SCENE_WATCH_OUT_078, MapObjects_6074
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_6074::
    db $01 ; entry 0
    db $85, $00, $4f, $01, $00, $40, $30, $05, $03, $50, $34

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_6080::
    dw ObjSelector_6086 ; id 0
    dw $0000 ; id 1
    dw ObjSelector_6098 ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6086::
    objsel_unless_flag EVENT_HOW_COULD_WE_DIE_BEFORE, MapObjects_608C
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_608C::
    db $01 ; entry 0
    db $85, $01, $44, $00, $00, $70, $10, $05, $00, $50, $47

ObjSelector_6098::
    objsel_list MapObjects_609C

MapObjects_609C::
    db $01 ; entry 0
    db $85, $01, $56, $00, $00, $70, $60, $05, $00, $50, $4d

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_60A8::
    dw $0000 ; id 0
    dw $0000 ; id 1
    dw $0000 ; id 2
    dw $0000 ; id 3
    dw $0000 ; id 4
    dw $0000 ; id 5
    dw $0000 ; id 6
    dw $0000 ; id 7
    dw $0000 ; id 8
    dw $0000 ; id 9
    dw $0000 ; id 10
    dw $0000 ; id 11
    dw $0000 ; id 12
    dw $0000 ; id 13
    dw ObjSelector_60C8 ; id 14
    dw $0000 ; id 15

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_60C8::
    objsel_unless_flag $007b, MapObjects_60CE
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_60CE::
    db $03 ; entry 0: object count
    db $85, $01, $03, $00, $00, $50, $a0, $05, $02, $50, $00 ; object 0
    db $86, $01, $28, $00, $00, $50, $b0, $06, $02, $60, $00 ; object 1
    db $87, $01, $29, $00, $00, $50, $c0, $07, $02, $70, $00 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_60F0::
    dw $0000 ; id 0
    dw $0000 ; id 1
    dw $0000 ; id 2
    dw $0000 ; id 3
    dw $0000 ; id 4
    dw ObjSelector_6108 ; id 5
    dw $0000 ; id 6
    dw $0000 ; id 7
    dw $0000 ; id 8
    dw $0000 ; id 9
    dw $0000 ; id 10
    dw $0000 ; id 11

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6108::
    objsel_skip_if_clear EVENT_SCENE_CREW_FOLLOWS, $02, $00
    objsel_none

ObjSelector_6110::
    objsel_unless_flag EVENT_SCENE_CREW_FOLLOWS_07D, MapObjects_6118
    objsel_list MapObjects_613A

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_6118::
    db $03 ; entry 0: object count
    db $85, $01, $03, $00, $00, $40, $50, $05, $03, $50, $00 ; object 0
    db $86, $01, $28, $00, $00, $60, $60, $06, $00, $60, $00 ; object 1
    db $87, $01, $29, $00, $00, $50, $20, $07, $01, $70, $00 ; object 2

MapObjects_613A::
    db $03 ; entry 0: object count
    db $85, $01, $03, $00, $00, $60, $50, $05, $01, $50, $00 ; object 0
    db $86, $01, $28, $00, $00, $50, $50, $06, $01, $60, $00 ; object 1
    db $87, $01, $29, $00, $00, $40, $50, $07, $01, $70, $00 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_615C::
    dw $0000 ; id 0
    dw ObjSelector_616E ; id 1
    dw $0000 ; id 2
    dw $0000 ; id 3
    dw $0000 ; id 4
    dw $0000 ; id 5
    dw $0000 ; id 6
    dw $0000 ; id 7
    dw $0000 ; id 8

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_616E::
    objsel_unless_flag EVENT_SCENE_KAMEHA_FLEES, MapObjects_6174
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_6174::
    db $03 ; entry 0: object count
    db $85, $01, $03, $00, $00, $60, $a0, $05, $02, $50, $00 ; object 0
    db $86, $01, $28, $00, $00, $60, $b0, $06, $02, $60, $00 ; object 1
    db $87, $01, $29, $00, $00, $60, $c0, $07, $02, $70, $00 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_6196::
    dw ObjSelector_6198 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6198::
    objsel_skip_if_clear EVENT_SCENE_MERMAID_KINGDOM_05F, $02, $00
    objsel_none

ObjSelector_61A0::
    objsel_unless_flag EVENT_SCENE_MERMAID_KINGDOM_07F, MapObjects_61A8
    objsel_list MapObjects_61CA

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_61A8::
    db $03 ; entry 0: object count
    db $85, $01, $28, $00, $00, $50, $e0, $05, $00, $50, $00 ; object 0
    db $86, $01, $29, $00, $00, $50, $d0, $06, $00, $60, $00 ; object 1
    db $87, $01, $03, $00, $00, $50, $f0, $07, $00, $70, $00 ; object 2

MapObjects_61CA::
    db $03 ; entry 0: object count
    db $85, $01, $45, $00, $00, $80, $40, $05, $00, $50, $00 ; object 0
    db $86, $00, $e3, $00, $00, $50, $40, $06, $00, $60, $00 ; object 1
    db $87, $00, $d6, $00, $00, $40, $50, $07, $00, $70, $00 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_61EC::
    dw ObjSelector_61F2 ; id 0
    dw ObjSelector_6228 ; id 1
    dw ObjSelector_6259 ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_61F2::
    objsel_unless_flag $006f, MapObjects_61FA
    objsel_list MapObjects_6211

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_61FA::
    db $02 ; entry 0: object count
    db $85, $01, $13, $00, $00, $60, $20, $05, $00, $50, $13 ; object 0
    db $86, $01, $4e, $00, $00, $e0, $40, $06, $00, $60, $3d ; object 1

MapObjects_6211::
    db $02 ; entry 0: object count
    db $85, $01, $13, $00, $00, $60, $20, $05, $00, $50, $13 ; object 0
    db $86, $01, $4e, $00, $00, $30, $40, $06, $01, $60, $3d ; object 1

ObjSelector_6228::
    objsel_list MapObjects_622C

; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_622C::
    db $04 ; entry 0: object count
    db $85, $01, $09, $00, $00, $60, $60, $05, $00, $50, $0f ; object 0
    db $86, $01, $0d, $00, $00, $20, $20, $06, $00, $60, $16 ; object 1
    db $87, $01, $0c, $00, $02, $70, $50, $07, $01, $70, $11 ; object 2
    db $87, $01, $0c, $00, $00, $30, $40, $07, $01, $70, $17 ; object 3

ObjSelector_6259::
    objsel_list MapObjects_625D

; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_625D::
    db $03 ; entry 0: object count
    db $85, $01, $13, $00, $00, $70, $20, $05, $00, $50, $15 ; object 0
    db $86, $01, $07, $00, $00, $20, $10, $06, $00, $60, $12 ; object 1
    db $87, $01, $0c, $00, $00, $80, $60, $07, $03, $70, $10 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_627F::
    dw ObjSelector_6281 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6281::
    objsel_list MapObjects_6285

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_6285::
    db $02 ; entry 0: object count
    db $85, $01, $0a, $00, $00, $70, $10, $05, $00, $50, $14 ; object 0
    db $86, $01, $12, $00, $00, $40, $10, $06, $00, $60, $6d ; object 1

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_629C::
    dw ObjSelector_62A0 ; id 0
    dw $0000 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_62A0::
    objsel_unless_flag $007a, MapObjects_62A8
    objsel_list MapObjects_62B4

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_62A8::
    db $01 ; entry 0
    db $85, $01, $58, $00, $00, $e0, $18, $05, $00, $50, $00

MapObjects_62B4::
    db $01 ; entry 0
    db $85, $01, $58, $00, $00, $48, $18, $05, $00, $50, $00

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_62C0::
    dw ObjSelector_62C4 ; id 0
    dw ObjSelector_633D ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_62C4::
    objsel_skip_if_set $0025, $0a, $00
    objsel_skip_if_clear EVENT_SCENE_DARCK_DEFEATED, $04, $00
    objsel_list MapObjects_6305

ObjSelector_62D4::
    objsel_list MapObjects_62D8

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 4 object(s), the layout of the other object lists
MapObjects_62D8::
    db $04 ; entry 0: object count
    db $85, $01, $4f, $00, $00, $40, $20, $05, $00, $50, $45 ; object 0
    db $86, $01, $2c, $00, $02, $50, $40, $06, $01, $60, $43 ; object 1
    db $86, $01, $2c, $00, $00, $30, $60, $06, $00, $60, $44 ; object 2
    db $86, $01, $2c, $00, $00, $70, $70, $06, $00, $60, $42 ; object 3

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 5 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_6305::
    db $05 ; entry 0: object count
    db $85, $01, $4f, $00, $00, $40, $20, $05, $00, $50, $45 ; object 0
    db $86, $01, $2c, $00, $00, $40, $50, $06, $02, $60, $43 ; object 1
    db $86, $01, $2c, $00, $00, $50, $50, $06, $02, $60, $44 ; object 2
    db $86, $01, $2c, $00, $00, $60, $50, $06, $02, $60, $42 ; object 3
    db $87, $01, $13, $00, $00, $50, $30, $07, $00, $70, $15 ; object 4

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_633D::
    objsel_list MapObjects_6341

; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_6341::
    db $04 ; entry 0: object count
    db $85, $01, $2c, $00, $00, $60, $30, $05, $01, $50, $3e ; object 0
    db $86, $01, $2c, $00, $00, $40, $70, $06, $01, $60, $3f ; object 1
    db $85, $01, $2c, $00, $00, $50, $70, $05, $03, $50, $40 ; object 2
    db $85, $01, $2c, $00, $00, $20, $40, $05, $00, $50, $41 ; object 3

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_636E::
    dw ObjSelector_6374 ; id 0
    dw $0000 ; id 1
    dw $0000 ; id 2

ObjSelector_6374::
    objsel_unless_flag EVENT_THE_TREASURES_ARE_OURS_NO, MapObjects_637A
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_637A::
    db $01 ; entry 0
    db $85, $01, $44, $00, $00, $80, $60, $05, $00, $50, $48

MapObjectScreens_6386::
    dw ObjSelector_638C ; id 0
    dw $0000 ; id 1
    dw $0000 ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_638C::
    objsel_unless_flag EVENT_IT_NAGS_AND_NAGS_THAT, MapObjects_6392
    objsel_none

MapObjects_6392::
    db $01 ; entry 0
    db $85, $01, $44, $00, $00, $60, $30, $05, $00, $50, $49

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_639E::
    dw ObjSelector_63A0 ; id 0

ObjSelector_63A0::
    objsel_unless_flag EVENT_GIVE_ITEM_BLINK, MapObjects_63A6
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_63A6::
    db $01 ; entry 0
    db $85, $00, $06, $01, $00, $60, $20, $05, $00, $50, $4a

MapObjectScreens_63B2::
    dw $0000 ; id 0
    dw $0000 ; id 1
    dw $0000 ; id 2
    dw $0000 ; id 3
    dw ObjSelector_63CA ; id 4
    dw ObjSelector_641B ; id 5
    dw ObjSelector_647D ; id 6
    dw ObjSelector_64AB ; id 7
    dw ObjSelector_65AF ; id 8
    dw ObjSelector_662F ; id 9
    dw ObjSelector_663F ; id 10
    dw ObjSelector_66BD ; id 11

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_63CA::
    objsel_unless_flag EVENT_SCENE_WARUBOU_LEAVES, MapObjects_63D6
    objsel_unless_flag $0006, MapObjects_63F8
    objsel_list MapObjects_6404

; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_63D6::
    db $03 ; entry 0: object count
    db $85, $01, $1a, $00, $00, $40, $00, $05, $00, $50, $0a ; object 0
    db $86, $01, $03, $00, $00, $40, $60, $06, $00, $60, $18 ; object 1
    db $87, $01, $02, $00, $00, $50, $60, $07, $00, $70, $17 ; object 2

MapObjects_63F8::
    db $01 ; entry 0
    db $85, $01, $1a, $00, $00, $40, $00, $05, $00, $50, $0a

; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_6404::
    db $02 ; entry 0: object count
    db $85, $01, $1a, $00, $00, $20, $10, $05, $00, $50, $0a ; object 0
    db $86, $01, $10, $00, $00, $40, $e0, $06, $00, $60, $00 ; object 1

ObjSelector_641B::
    objsel_skip_if_clear EVENT_SCENE_SHIELD2_023, $04, $00
    objsel_list MapObjects_645B

ObjSelector_6425::
    objsel_unless_flag EVENT_REWARD_ITEM_OR_KEY, MapObjects_642D
    objsel_list MapObjects_6444

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_642D::
    db $02 ; entry 0: object count
    db $85, $01, $04, $00, $00, $60, $30, $05, $01, $50, $07 ; object 0
    db $86, $00, $5a, $00, $00, $60, $e0, $06, $00, $60, $4b ; object 1

MapObjects_6444::
    db $02 ; entry 0: object count
    db $85, $01, $04, $00, $00, $60, $30, $05, $01, $50, $07 ; object 0
    db $86, $00, $5a, $00, $00, $60, $20, $06, $00, $60, $4b ; object 1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_645B::
    db $03 ; entry 0: object count
    db $85, $01, $04, $00, $00, $50, $30, $05, $01, $50, $07 ; object 0
    db $86, $00, $5a, $00, $00, $60, $20, $06, $00, $60, $4b ; object 1
    db $87, $00, $01, $01, $00, $30, $60, $07, $00, $70, $7c ; object 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_647D::
    objsel_skip_if_clear EVENT_SCENE_THREE_ITEMS, $04, $00
    objsel_list MapObjects_649F

ObjSelector_6487::
    objsel_skip_if_clear EVENT_SCENE_VAULT_SETTLED, $04, $00
    objsel_unless_flag EVENT_SCENE_LONG_FACES, MapObjects_6493
    objsel_none

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_6493::
    db $01 ; entry 0
    db $85, $00, $0a, $00, $00, $80, $40, $05, $00, $50, $08

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_649F::
    db $01 ; entry 0
    db $85, $00, $f0, $00, $00, $80, $30, $05, $00, $50, $98

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_64AB::
    objsel_skip_if_clear $0025, $08, $00
    objsel_unless_flag $0000, MapObjects_655F
    objsel_list MapObjects_653D

ObjSelector_64B9::
    objsel_skip_if_set $0020, $12, $00
    objsel_skip_if_set EVENT_SCENE_LONG_FACES, $08, $00
    objsel_unless_flag EVENT_SCENE_VAULT_SETTLED, MapObjects_64ED
    objsel_list MapObjects_6504

ObjSelector_64CD::
    objsel_list MapObjects_651B

ObjSelector_64D1::
    objsel_skip_if_clear EVENT_SCENE_RIVAL_DEFEATED_021, $0e, $00
    objsel_skip_if_set $0181, $08, $00
    objsel_unless_flag $0000, MapObjects_6598
    objsel_list MapObjects_6581

ObjSelector_64E5::
    objsel_unless_flag $0000, MapObjects_655F
    objsel_list MapObjects_653D

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_64ED::
    db $02 ; entry 0: object count
    db $85, $01, $04, $00, $00, $40, $00, $05, $00, $50, $07 ; object 0
    db $86, $00, $0a, $00, $00, $50, $00, $06, $00, $60, $08 ; object 1

MapObjects_6504::
    db $02 ; entry 0: object count
    db $85, $01, $04, $00, $00, $30, $20, $05, $00, $50, $07 ; object 0
    db $86, $00, $01, $00, $02, $50, $50, $06, $01, $60, $1a ; object 1

; record: count, then 3 object(s), the layout of the other object lists
MapObjects_651B::
    db $03 ; entry 0: object count
    db $85, $01, $04, $00, $00, $30, $20, $05, $00, $50, $07 ; object 0
    db $86, $00, $01, $00, $02, $50, $50, $06, $01, $60, $1a ; object 1
    db $84, $00, $24, $00, $00, $70, $60, $04, $03, $40, $b2 ; object 2

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_653D::
    db $03 ; entry 0: object count
    db $85, $01, $00, $00, $00, $60, $30, $05, $00, $50, $1b ; object 0
    db $86, $00, $01, $00, $02, $50, $50, $06, $01, $60, $1a ; object 1
    db $84, $00, $24, $00, $00, $70, $60, $04, $03, $40, $b2 ; object 2

MapObjects_655F::
    db $03 ; entry 0: object count
    db $85, $01, $01, $00, $00, $60, $30, $05, $00, $50, $1c ; object 0
    db $86, $00, $01, $00, $02, $50, $50, $06, $03, $60, $1a ; object 1
    db $84, $00, $24, $00, $00, $70, $60, $04, $03, $40, $b2 ; object 2

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_6581::
    db $02 ; entry 0: object count
    db $85, $01, $00, $00, $00, $60, $30, $05, $00, $50, $1b ; object 0
    db $86, $00, $24, $00, $00, $70, $60, $06, $03, $60, $b2 ; object 1

MapObjects_6598::
    db $02 ; entry 0: object count
    db $85, $01, $01, $00, $00, $60, $30, $05, $00, $50, $1c ; object 0
    db $86, $00, $24, $00, $00, $70, $60, $06, $03, $60, $b2 ; object 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_65AF::
    objsel_skip_if_clear EVENT_SCENE_SHIELD2_023, $04, $00
    objsel_list MapObjects_660D

ObjSelector_65B9::
    objsel_skip_if_clear EVENT_SCENE_MERMAID_KINGDOM_022, $04, $00
    objsel_list MapObjects_65F6

ObjSelector_65C3::
    objsel_skip_if_clear EVENT_SCENE_RIVAL_DEFEATED_021, $04, $00
    objsel_list MapObjects_65DF

ObjSelector_65CD::
    objsel_unless_flag EVENT_SCENE_VAULT_SETTLED, MapObjects_65D3
    objsel_none

; record: count, then 1 object(s), the layout of the other object lists
MapObjects_65D3::
    db $01 ; entry 0
    db $85, $00, $01, $00, $02, $20, $50, $05, $01, $50, $1a

MapObjects_65DF::
    db $02 ; entry 0: object count
    db $85, $00, $4f, $00, $00, $30, $20, $05, $00, $50, $b3 ; object 0
    db $86, $01, $04, $00, $00, $20, $30, $06, $01, $60, $07 ; object 1

MapObjects_65F6::
    db $02 ; entry 0: object count
    db $85, $00, $4f, $00, $00, $30, $20, $05, $00, $50, $b3 ; object 0
    db $86, $00, $d8, $00, $00, $50, $10, $06, $00, $60, $4a ; object 1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_660D::
    db $03 ; entry 0: object count
    db $85, $00, $4f, $00, $00, $30, $20, $05, $00, $50, $b3 ; object 0
    db $86, $00, $d8, $00, $00, $50, $10, $06, $00, $60, $4a ; object 1
    db $87, $00, $2a, $00, $00, $40, $60, $07, $00, $70, $7b ; object 2

ObjSelector_662F::
    objsel_list MapObjects_6633

; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_6633::
    db $01 ; entry 0
    db $86, $00, $91, $00, $00, $30, $30, $06, $01, $60, $04

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_663F::
    objsel_skip_if_clear EVENT_SCENE_SHIELD2_023, $04, $00
    objsel_list MapObjects_669B

ObjSelector_6649::
    objsel_skip_if_clear EVENT_SCENE_RIVAL_DEFEATED_021, $04, $00
    objsel_list MapObjects_6684

ObjSelector_6653::
    objsel_skip_if_clear $0020, $04, $00
    objsel_list MapObjects_666D

ObjSelector_665D::
    objsel_list MapObjects_6661

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_6661::
    db $01 ; entry 0
    db $85, $00, $b9, $00, $02, $40, $20, $05, $01, $50, $09

; record: count, then 2 object(s), the layout of the other object lists
MapObjects_666D::
    db $02 ; entry 0: object count
    db $85, $00, $b9, $00, $02, $40, $20, $05, $01, $50, $09 ; object 0
    db $86, $01, $04, $00, $00, $50, $40, $06, $03, $60, $07 ; object 1

MapObjects_6684::
    db $02 ; entry 0: object count
    db $85, $00, $b9, $00, $02, $40, $20, $05, $01, $50, $09 ; object 0
    db $86, $00, $f6, $00, $00, $60, $40, $06, $00, $60, $b4 ; object 1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_669B::
    db $03 ; entry 0: object count
    db $85, $00, $b9, $00, $02, $40, $20, $05, $01, $50, $09 ; object 0
    db $86, $00, $f6, $00, $00, $60, $40, $06, $00, $60, $b4 ; object 1
    db $87, $00, $b1, $00, $00, $70, $30, $07, $00, $70, $d4 ; object 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_66BD::
    objsel_skip_if_clear EVENT_SCENE_SHIELD2_023, $04, $00
    objsel_list MapObjects_6700

ObjSelector_66C7::
    objsel_skip_if_clear EVENT_SCENE_MERMAID_KINGDOM_022, $04, $00
    objsel_list MapObjects_66E9

ObjSelector_66D1::
    objsel_skip_if_clear EVENT_SCENE_RIVAL_DEFEATED_021, $04, $00
    objsel_list MapObjects_66DD

ObjSelector_66DB::
    objsel_none

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_66DD::
    db $01 ; entry 0
    db $85, $00, $3d, $00, $00, $40, $10, $05, $01, $50, $7d

; record: count, then 2 object(s), the layout of the other object lists
MapObjects_66E9::
    db $02 ; entry 0: object count
    db $85, $00, $3d, $00, $00, $40, $10, $05, $01, $50, $7d ; object 0
    db $86, $00, $2e, $00, $00, $20, $30, $06, $00, $60, $7e ; object 1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_6700::
    db $03 ; entry 0: object count
    db $85, $00, $3d, $00, $00, $40, $10, $05, $01, $50, $7d ; object 0
    db $86, $00, $2e, $00, $00, $20, $30, $06, $00, $60, $7e ; object 1
    db $87, $00, $f8, $00, $00, $10, $40, $07, $00, $70, $d5 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_6722::
    dw ObjSelector_673A ; id 0
    dw ObjSelector_674A ; id 1
    dw $0000 ; id 2
    dw $0000 ; id 3
    dw ObjSelector_675A ; id 4
    dw ObjSelector_676A ; id 5
    dw ObjSelector_679D ; id 6
    dw ObjSelector_67BA ; id 7
    dw ObjSelector_67D2 ; id 8
    dw ObjSelector_6822 ; id 9
    dw ObjSelector_6867 ; id 10
    dw ObjSelector_6908 ; id 11

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_673A::
    objsel_list MapObjects_673E

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_673E::
    db $01 ; entry 0
    db $85, $01, $11, $00, $00, $20, $60, $05, $01, $50, $80

ObjSelector_674A::
    objsel_list MapObjects_674E

MapObjects_674E::
    db $01 ; entry 0
    db $85, $01, $1a, $00, $00, $80, $40, $05, $01, $50, $da

ObjSelector_675A::
    objsel_list MapObjects_675E

MapObjects_675E::
    db $01 ; entry 0
    db $85, $01, $19, $00, $00, $20, $60, $05, $01, $50, $22

ObjSelector_676A::
    objsel_skip_if_clear EVENT_WHAT, $02, $00
    objsel_none

ObjSelector_6772::
    objsel_unless_flag $0107, MapObjects_677A
    objsel_list MapObjects_6791

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_677A::
    db $02 ; entry 0: object count
    db $85, $01, $10, $00, $00, $50, $20, $05, $00, $50, $20 ; object 0
    db $86, $01, $18, $00, $00, $70, $70, $06, $03, $60, $21 ; object 1

; record: count, then 1 object(s), the layout of the other object lists
MapObjects_6791::
    db $01 ; entry 0
    db $85, $01, $10, $00, $00, $50, $20, $05, $00, $50, $20

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_679D::
    objsel_unless_flag EVENT_SCENE_MERMAID_KINGDOM_022, MapObjects_67A3
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_67A3::
    db $02 ; entry 0: object count
    db $85, $01, $15, $00, $00, $50, $60, $05, $02, $50, $b7 ; object 0
    db $86, $01, $12, $00, $00, $50, $70, $06, $02, $60, $b8 ; object 1

ObjSelector_67BA::
    objsel_skip_if_set EVENT_SCENE_LONG_FACES, $02, $00
    objsel_none

ObjSelector_67C2::
    objsel_list MapObjects_67C6

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_67C6::
    db $01 ; entry 0
    db $85, $01, $1a, $00, $00, $40, $60, $05, $00, $50, $ea

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_67D2::
    objsel_unless_flag EVENT_THANKS_FOR_COMING_BY, MapObjects_67DE
    objsel_unless_flag EVENT_SCENE_WARUBOU_SMELLS, MapObjects_67F5
    objsel_list MapObjects_67DE

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_67DE::
    db $02 ; entry 0: object count
    db $85, $01, $1b, $00, $00, $60, $70, $05, $03, $50, $12 ; object 0
    db $86, $01, $10, $00, $00, $20, $50, $06, $00, $60, $0b ; object 1

; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_67F5::
    db $04 ; entry 0: object count
    db $85, $01, $1b, $00, $00, $60, $70, $05, $03, $50, $12 ; object 0
    db $86, $01, $10, $00, $00, $20, $50, $06, $00, $60, $0b ; object 1
    db $87, $01, $03, $00, $00, $30, $80, $07, $02, $70, $18 ; object 2
    db $84, $01, $02, $00, $00, $40, $80, $04, $02, $40, $17 ; object 3

ObjSelector_6822::
    objsel_skip_if_clear $0025, $04, $00
    objsel_list MapObjects_685B

ObjSelector_682C::
    objsel_skip_if_clear EVENT_SCENE_THREE_ITEMS, $02, $00
    objsel_none

ObjSelector_6834::
    objsel_unless_flag EVENT_SCENE_RIVAL_DEFEATED_021, MapObjects_6844
    objsel_skip_if_set $0107, $02, $00
    objsel_none

ObjSelector_6840::
    objsel_list MapObjects_685B

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_6844::
    db $02 ; entry 0: object count
    db $85, $01, $1d, $00, $00, $20, $40, $05, $00, $50, $15 ; object 0
    db $86, $01, $10, $00, $00, $50, $40, $06, $00, $60, $20 ; object 1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_685B::
    db $01 ; entry 0
    db $85, $01, $18, $00, $00, $70, $60, $05, $00, $50, $21

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6867::
    objsel_unless_flag EVENT_THANKS_FOR_COMING_BY, MapObjects_687F
    objsel_unless_flag EVENT_SCENE_WARUBOU_SMELLS, MapObjects_6896
    objsel_unless_flag EVENT_SCENE_RIVAL_DEFEATED_021, MapObjects_687F
    objsel_unless_flag EVENT_SCENE_THREE_ITEMS, MapObjects_68C3
    objsel_unless_flag $0025, MapObjects_68E5
    objsel_list MapObjects_68F1

; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_687F::
    db $02 ; entry 0: object count
    db $85, $01, $1c, $00, $00, $50, $00, $05, $00, $50, $0c ; object 0
    db $86, $01, $1d, $00, $00, $50, $60, $06, $00, $60, $16 ; object 1

; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_6896::
    db $04 ; entry 0: object count
    db $85, $01, $1c, $00, $00, $50, $00, $05, $00, $50, $0c ; object 0
    db $86, $01, $03, $00, $00, $30, $60, $06, $03, $60, $18 ; object 1
    db $87, $01, $02, $00, $00, $30, $50, $07, $03, $70, $17 ; object 2
    db $83, $01, $1d, $00, $00, $50, $60, $03, $00, $30, $16 ; object 3

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_68C3::
    db $03 ; entry 0: object count
    db $85, $01, $1c, $00, $00, $40, $30, $05, $00, $50, $0c ; object 0
    db $86, $01, $08, $00, $02, $e0, $e0, $06, $01, $60, $b9 ; object 1
    db $84, $01, $10, $00, $00, $e0, $50, $04, $03, $40, $00 ; object 2

; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_68E5::
    db $01 ; entry 0
    db $85, $01, $1c, $00, $00, $50, $60, $05, $00, $50, $0c

; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_68F1::
    db $02 ; entry 0: object count
    db $85, $01, $1c, $00, $00, $40, $30, $05, $00, $50, $0c ; object 0
    db $86, $01, $08, $00, $02, $30, $40, $06, $01, $60, $b9 ; object 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6908::
    objsel_skip_if_clear $0025, $04, $00
    objsel_list MapObjects_692E

ObjSelector_6912::
    objsel_skip_if_clear EVENT_SCENE_THREE_ITEMS, $02, $00
    objsel_none

ObjSelector_691A::
    objsel_unless_flag EVENT_SCENE_RIVAL_DEFEATED_021, MapObjects_6922
    objsel_list MapObjects_692E

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_6922::
    db $01 ; entry 0
    db $85, $01, $1b, $00, $02, $40, $40, $05, $01, $50, $14

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_692E::
    db $02 ; entry 0: object count
    db $85, $01, $1a, $00, $00, $30, $60, $05, $00, $50, $1e ; object 0
    db $86, $01, $10, $00, $00, $20, $40, $06, $01, $60, $eb ; object 1

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_6945::
    dw ObjSelector_694B ; id 0
    dw ObjSelector_6A33 ; id 1
    dw ObjSelector_6A74 ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_694B::
    objsel_skip_if_clear EVENT_REWARD_ITEM_OR_KEY_2, $08, $00
    objsel_unless_flag EVENT_SCENE_SHIELD2_023, MapObjects_69D9
    objsel_list MapObjects_6A06

ObjSelector_6959::
    objsel_skip_if_clear EVENT_SCENE_MERMAID_KINGDOM_022, $04, $00
    objsel_list MapObjects_69AC

ObjSelector_6963::
    objsel_skip_if_clear EVENT_SCENE_RIVAL_DEFEATED_021, $04, $00
    objsel_list MapObjects_6995

ObjSelector_696D::
    objsel_unless_flag EVENT_THAT_WEIRD_APE_THING_IS, MapObjects_6973
    objsel_none

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_6973::
    db $03 ; entry 0: object count
    db $85, $01, $15, $00, $00, $60, $50, $05, $02, $50, $10 ; object 0
    db $86, $01, $03, $00, $00, $e0, $40, $06, $01, $60, $00 ; object 1
    db $87, $01, $02, $00, $00, $e0, $10, $07, $00, $70, $00 ; object 2

; record: count, then 2 object(s), the layout of the other object lists
MapObjects_6995::
    db $02 ; entry 0: object count
    db $85, $01, $1d, $00, $00, $40, $30, $05, $00, $50, $15 ; object 0
    db $86, $01, $1d, $00, $00, $40, $40, $06, $02, $60, $16 ; object 1

; record: count, then 4 object(s), the layout of the other object lists
MapObjects_69AC::
    db $04 ; entry 0: object count
    db $85, $01, $15, $00, $00, $60, $50, $05, $02, $50, $10 ; object 0
    db $85, $01, $15, $00, $00, $20, $40, $05, $03, $50, $7f ; object 1
    db $86, $01, $57, $00, $00, $80, $60, $06, $02, $60, $00 ; object 2
    db $87, $00, $b9, $00, $00, $20, $e0, $07, $01, $70, $cd ; object 3

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_69D9::
    db $04 ; entry 0: object count
    db $85, $01, $15, $00, $00, $60, $50, $05, $02, $50, $10 ; object 0
    db $85, $01, $15, $00, $00, $20, $50, $05, $03, $50, $7f ; object 1
    db $86, $01, $57, $00, $00, $80, $60, $06, $02, $60, $00 ; object 2
    db $87, $00, $b9, $00, $02, $40, $40, $07, $01, $70, $cd ; object 3

MapObjects_6A06::
    db $04 ; entry 0: object count
    db $85, $01, $15, $00, $00, $60, $50, $05, $02, $50, $10 ; object 0
    db $85, $01, $15, $00, $00, $10, $40, $05, $01, $50, $7f ; object 1
    db $86, $01, $57, $00, $00, $80, $60, $06, $02, $60, $00 ; object 2
    db $87, $00, $b9, $00, $00, $20, $50, $07, $01, $70, $cd ; object 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6A33::
    objsel_unless_flag EVENT_SCENE_RIVAL_DEFEATED_021, MapObjects_6A3B
    objsel_list MapObjects_6A52

; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_6A3B::
    db $02 ; entry 0: object count
    db $85, $01, $15, $00, $00, $40, $10, $05, $00, $50, $11 ; object 0
    db $86, $01, $1c, $00, $00, $10, $50, $06, $00, $60, $aa ; object 1

; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_6A52::
    db $03 ; entry 0: object count
    db $85, $01, $15, $00, $00, $40, $10, $05, $00, $50, $11 ; object 0
    db $86, $01, $1d, $00, $02, $50, $30, $06, $03, $60, $0f ; object 1
    db $87, $01, $1c, $00, $00, $10, $50, $07, $00, $70, $aa ; object 2

ObjSelector_6A74::
    objsel_skip_if_clear $0025, $04, $00
    objsel_list MapObjects_6AC2

ObjSelector_6A7E::
    objsel_skip_if_clear EVENT_SCENE_THREE_ITEMS, $04, $00
    objsel_list MapObjects_6AE4

ObjSelector_6A88::
    objsel_unless_flag $0005, MapObjects_6A94
    objsel_unless_flag EVENT_SCENE_MERMAID_KINGDOM_022, MapObjects_6AB6
    objsel_list MapObjects_6AC2

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_6A94::
    db $03 ; entry 0: object count
    db $85, $01, $1d, $00, $00, $40, $40, $05, $02, $50, $0e ; object 0
    db $86, $01, $02, $00, $00, $50, $30, $06, $01, $60, $00 ; object 1
    db $87, $01, $03, $00, $00, $40, $30, $07, $01, $70, $00 ; object 2

; record: count, then 1 object(s), the layout of the other object lists
MapObjects_6AB6::
    db $01 ; entry 0
    db $85, $01, $1d, $00, $00, $40, $40, $05, $00, $50, $0e

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_6AC2::
    db $03 ; entry 0: object count
    db $85, $01, $1d, $00, $00, $40, $40, $05, $00, $50, $0e ; object 0
    db $86, $01, $1d, $00, $00, $20, $50, $06, $00, $60, $15 ; object 1
    db $84, $01, $1d, $00, $00, $20, $60, $04, $02, $40, $16 ; object 2

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_6AE4::
    db $02 ; entry 0: object count
    db $85, $01, $1d, $00, $00, $40, $30, $05, $00, $50, $15 ; object 0
    db $86, $01, $1d, $00, $00, $40, $40, $06, $02, $60, $16 ; object 1

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_6AFB::
    dw ObjSelector_6B01 ; id 0
    dw ObjSelector_6B27 ; id 1
    dw ObjSelector_6B42 ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6B01::
    objsel_list MapObjects_6B05

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_6B05::
    db $03 ; entry 0: object count
    db $85, $01, $16, $00, $00, $40, $10, $05, $01, $50, $64 ; object 0
    db $86, $01, $11, $00, $00, $50, $20, $06, $02, $60, $c3 ; object 1
    db $87, $01, $10, $00, $00, $60, $10, $07, $03, $70, $c4 ; object 2

ObjSelector_6B27::
    objsel_list MapObjects_6B2B

; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_6B2B::
    db $02 ; entry 0: object count
    db $85, $01, $17, $00, $00, $40, $10, $05, $00, $50, $00 ; object 0
    db $86, $01, $17, $00, $00, $50, $10, $06, $00, $60, $00 ; object 1

ObjSelector_6B42::
    objsel_skip_if_clear $0025, $0c, $00
    objsel_unless_flag $00cb, MapObjects_6BCC
    objsel_unless_flag $00cc, MapObjects_6BEE
    objsel_list MapObjects_6C10

ObjSelector_6B54::
    objsel_skip_if_set EVENT_SCENE_MERMAID_KINGDOM_022, $04, $00
    objsel_list MapObjects_6B66

ObjSelector_6B5E::
    objsel_unless_flag EVENT_SCENE_SHIELD2_023, MapObjects_6B88
    objsel_list MapObjects_6BAA

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_6B66::
    db $03 ; entry 0: object count
    db $85, $01, $11, $00, $00, $50, $20, $05, $00, $50, $66 ; object 0
    db $86, $00, $fa, $00, $00, $60, $40, $06, $00, $60, $67 ; object 1
    db $87, $00, $f8, $00, $00, $60, $50, $07, $02, $70, $68 ; object 2

MapObjects_6B88::
    db $03 ; entry 0: object count
    db $85, $01, $22, $00, $00, $50, $20, $05, $00, $50, $8e ; object 0
    db $86, $00, $58, $00, $00, $60, $40, $06, $00, $60, $67 ; object 1
    db $87, $00, $e5, $00, $00, $60, $50, $07, $02, $70, $68 ; object 2

MapObjects_6BAA::
    db $03 ; entry 0: object count
    db $85, $01, $28, $00, $00, $50, $20, $05, $00, $50, $9c ; object 0
    db $86, $00, $06, $01, $00, $60, $40, $06, $00, $60, $67 ; object 1
    db $87, $00, $52, $01, $00, $60, $50, $07, $02, $70, $68 ; object 2

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_6BCC::
    db $03 ; entry 0: object count
    db $85, $01, $2e, $00, $00, $50, $20, $05, $00, $50, $f1 ; object 0
    db $86, $00, $7b, $00, $00, $60, $40, $06, $00, $60, $67 ; object 1
    db $87, $00, $2e, $01, $00, $60, $50, $07, $02, $70, $68 ; object 2

MapObjects_6BEE::
    db $03 ; entry 0: object count
    db $85, $01, $14, $00, $00, $50, $20, $05, $00, $50, $f1 ; object 0
    db $86, $00, $32, $01, $00, $60, $40, $06, $00, $60, $36 ; object 1
    db $87, $00, $31, $01, $00, $60, $50, $07, $02, $70, $37 ; object 2

MapObjects_6C10::
    db $03 ; entry 0: object count
    db $85, $01, $5f, $00, $00, $50, $20, $05, $00, $50, $f2 ; object 0
    db $86, $00, $a5, $00, $00, $60, $40, $06, $00, $60, $28 ; object 1
    db $87, $00, $ee, $00, $00, $60, $50, $07, $02, $70, $29 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_6C32::
    dw $0000 ; id 0
    dw ObjSelector_6C38 ; id 1
    dw $0000 ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6C38::
    objsel_skip_if_clear $0025, $04, $00
    objsel_list MapObjects_6D0B

ObjSelector_6C42::
    objsel_skip_if_clear $019f, $04, $00
    objsel_list MapObjects_6C8C

ObjSelector_6C4C::
    objsel_skip_if_clear EVENT_SCENE_DARCK_DEFEATED, $04, $00
    objsel_list MapObjects_6CE8

ObjSelector_6C56::
    objsel_skip_if_clear EVENT_SCENE_THREE_ITEMS, $04, $00
    objsel_unless_flag EVENT_SCENE_THREE_ITEMS_0C3, MapObjects_6CD1
    objsel_skip_if_clear EVENT_SCENE_WARUBOU_FOOD2_00C, $0e, $00
    objsel_skip_if_clear $0018, $04, $00
    objsel_unless_flag $0019, MapObjects_6CFF
    objsel_list MapObjects_6CC5

ObjSelector_6C74::
    objsel_unless_flag EVENT_SCENE_WARUBOU_SMELLS, MapObjects_6C80
    objsel_unless_flag EVENT_SCENE_WARUBOU_FOOD2, MapObjects_6C8C
    objsel_list MapObjects_6CAE

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_6C80::
    db $01 ; entry 0
    db $85, $01, $4a, $00, $00, $40, $30, $05, $00, $50, $a9

; record: count, then 3 object(s), the layout of the other object lists
MapObjects_6C8C::
    db $03 ; entry 0: object count
    db $85, $01, $4a, $00, $00, $40, $30, $05, $00, $50, $a9 ; object 0
    db $86, $01, $02, $00, $00, $78, $30, $06, $03, $60, $19 ; object 1
    db $87, $01, $03, $00, $00, $58, $30, $07, $01, $70, $00 ; object 2

; record: count, then 2 object(s), the layout of the other object lists
MapObjects_6CAE::
    db $02 ; entry 0: object count
    db $85, $01, $02, $00, $00, $80, $30, $05, $00, $50, $19 ; object 0
    db $86, $01, $03, $00, $00, $40, $40, $06, $02, $60, $00 ; object 1

MapObjects_6CC5::
    db $01 ; entry 0
    db $85, $01, $49, $00, $00, $40, $30, $05, $00, $50, $19

MapObjects_6CD1::
    db $02 ; entry 0: object count
    db $85, $01, $49, $00, $00, $40, $30, $05, $01, $50, $19 ; object 0
    db $86, $01, $03, $00, $00, $50, $40, $06, $03, $60, $00 ; object 1

MapObjects_6CE8::
    db $02 ; entry 0: object count
    db $85, $01, $49, $00, $00, $40, $30, $05, $00, $50, $19 ; object 0
    db $86, $01, $4a, $00, $00, $40, $e0, $06, $00, $60, $00 ; object 1

MapObjects_6CFF::
    db $01 ; entry 0
    db $85, $01, $49, $00, $00, $e0, $30, $05, $00, $50, $19

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_6D0B::
    db $03 ; entry 0: object count
    db $85, $01, $4a, $00, $00, $e0, $e0, $05, $00, $50, $a9 ; object 0
    db $86, $01, $02, $00, $00, $50, $20, $06, $00, $60, $19 ; object 1
    db $87, $01, $02, $00, $00, $e0, $e0, $07, $00, $70, $19 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_6D2D::
    dw ObjSelector_6D2F ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6D2F::
    objsel_skip_if_clear $0025, $04, $00
    objsel_list MapObjects_6D61

ObjSelector_6D39::
    objsel_skip_if_set EVENT_SCENE_LONG_FACES, $08, $00
    objsel_unless_flag $0017, MapObjects_6D61
    objsel_list MapObjects_6D9B

ObjSelector_6D47::
    objsel_skip_if_clear $0020, $0c, $00
    objsel_unless_flag EVENT_SCENE_RIVAL_DEFEATED_021, MapObjects_6D61
    objsel_unless_flag $0181, MapObjects_6DA7
    objsel_list MapObjects_6D61

ObjSelector_6D59::
    objsel_unless_flag $0001, MapObjects_6D6D
    objsel_list MapObjects_6D84

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_6D61::
    db $01 ; entry 0
    db $85, $01, $05, $00, $00, $40, $30, $05, $00, $50, $02

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_6D6D::
    db $02 ; entry 0: object count
    db $85, $01, $05, $00, $00, $40, $30, $05, $00, $50, $02 ; object 0
    db $86, $01, $00, $00, $00, $70, $70, $06, $03, $60, $1b ; object 1

MapObjects_6D84::
    db $02 ; entry 0: object count
    db $85, $01, $05, $00, $00, $40, $30, $05, $00, $50, $02 ; object 0
    db $86, $01, $01, $00, $00, $70, $70, $06, $03, $60, $1c ; object 1

; record: count, then 1 object(s), the layout of the other object lists
MapObjects_6D9B::
    db $01 ; entry 0
    db $85, $00, $0a, $00, $00, $50, $a0, $05, $00, $50, $08

MapObjects_6DA7::
    db $02 ; entry 0: object count
    db $85, $01, $05, $00, $00, $40, $30, $05, $00, $50, $02 ; object 0
    db $86, $00, $01, $00, $00, $20, $10, $06, $02, $60, $1a ; object 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6DBE::
    objsel_list MapObjects_6DC2

; record: count, then 4 object(s), the layout of the other object lists
MapObjects_6DC2::
    db $04 ; entry 0: object count
    db $85, $01, $4a, $00, $00, $40, $30, $05, $00, $50, $9f ; object 0
    db $85, $01, $4a, $00, $00, $60, $40, $05, $00, $50, $cf ; object 1
    db $85, $01, $4a, $00, $00, $70, $50, $05, $03, $50, $0d ; object 2
    db $86, $01, $5f, $00, $00, $70, $70, $06, $03, $60, $a7 ; object 3

ObjSelector_6DEF::
    objsel_list MapObjects_6DF3

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_6DF3::
    db $03 ; entry 0: object count
    db $85, $01, $40, $00, $00, $40, $30, $05, $00, $50, $a4 ; object 0
    db $86, $01, $15, $00, $00, $60, $20, $06, $00, $60, $a6 ; object 1
    db $87, $01, $10, $00, $00, $70, $10, $07, $00, $70, $ac ; object 2

ObjSelector_6E15::
    objsel_list MapObjects_6E19

MapObjects_6E19::
    db $03 ; entry 0: object count
    db $85, $00, $7e, $01, $00, $40, $30, $05, $00, $50, $35 ; object 0
    db $86, $00, $7d, $01, $00, $20, $40, $06, $00, $60, $34 ; object 1
    db $87, $00, $7c, $01, $00, $60, $50, $07, $00, $70, $33 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_6E3B::
    dw ObjSelector_6E3F ; id 0
    dw ObjSelector_6E65 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6E3F::
    objsel_list MapObjects_6E43

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_6E43::
    db $03 ; entry 0: object count
    db $85, $00, $93, $00, $00, $40, $30, $05, $01, $50, $4c ; object 0
    db $86, $00, $5e, $00, $00, $30, $70, $06, $00, $60, $4d ; object 1
    db $87, $00, $76, $00, $00, $80, $50, $07, $00, $70, $b5 ; object 2

ObjSelector_6E65::
    objsel_list MapObjects_6E69

MapObjects_6E69::
    db $03 ; entry 0: object count
    db $85, $00, $4e, $01, $00, $50, $40, $05, $03, $50, $4e ; object 0
    db $86, $00, $8e, $00, $00, $20, $50, $06, $01, $60, $4f ; object 1
    db $87, $00, $77, $00, $00, $50, $70, $07, $02, $70, $b6 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_6E8B::
    dw ObjSelector_6E8D ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6E8D::
    objsel_unless_flag EVENT_SCENE_LONG_FACES, MapObjects_6E95
    objsel_list MapObjects_6EA1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_6E95::
    db $01 ; entry 0
    db $85, $01, $15, $00, $00, $40, $20, $05, $00, $50, $14

; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_6EA1::
    db $02 ; entry 0: object count
    db $85, $01, $15, $00, $00, $40, $20, $05, $00, $50, $14 ; object 0
    db $86, $01, $10, $00, $00, $60, $60, $06, $00, $60, $1d ; object 1

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_6EB8::
    dw ObjSelector_6EBA ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6EBA::
    objsel_list MapObjects_6EBE

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_6EBE::
    db $04 ; entry 0: object count
    db $85, $01, $1c, $00, $00, $30, $20, $05, $00, $50, $92 ; object 0
    db $86, $01, $1a, $00, $00, $20, $60, $06, $03, $60, $93 ; object 1
    db $86, $01, $1a, $00, $00, $60, $50, $06, $00, $60, $94 ; object 2
    db $87, $01, $10, $00, $00, $50, $70, $07, $02, $70, $e9 ; object 3

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_6EEB::
    dw ObjSelector_6EED ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6EED::
    objsel_list MapObjects_6EF1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_6EF1::
    db $03 ; entry 0: object count
    db $85, $01, $2a, $00, $00, $50, $30, $05, $00, $50, $69 ; object 0
    db $86, $01, $15, $00, $00, $10, $60, $06, $01, $60, $b7 ; object 1
    db $87, $01, $12, $00, $00, $70, $50, $07, $00, $70, $b8 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_6F13::
    dw ObjSelector_6F15 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6F15::
    objsel_list MapObjects_6F19

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_6F19::
    db $04 ; entry 0: object count
    db $84, $01, $00, $00, $00, $70, $30, $04, $03, $40, $00 ; object 0
    db $85, $00, $01, $00, $00, $60, $40, $05, $03, $50, $00 ; object 1
    db $86, $00, $01, $00, $00, $60, $30, $06, $03, $60, $00 ; object 2
    db $87, $00, $01, $00, $00, $60, $20, $07, $03, $70, $00 ; object 3

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_6F46::
    dw ObjSelector_6F4A ; id 0
    dw ObjSelector_6F71 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6F4A::
    objsel_skip_if_clear $0025, $04, $00
    objsel_list MapObjects_6F5A

ObjSelector_6F54::
    objsel_unless_flag EVENT_SCENE_THREE_ITEMS, MapObjects_6F5A
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_6F5A::
    db $02 ; entry 0: object count
    db $85, $01, $1e, $00, $00, $40, $70, $05, $02, $50, $25 ; object 0
    db $86, $01, $1f, $00, $00, $40, $60, $06, $00, $60, $26 ; object 1

ObjSelector_6F71::
    objsel_skip_if_clear $0025, $04, $00
    objsel_list MapObjects_6F83

ObjSelector_6F7B::
    objsel_unless_flag EVENT_SCENE_THREE_ITEMS, MapObjects_6F83
    objsel_list MapObjects_6F9A

MapObjects_6F83::
    db $02 ; entry 0: object count
    db $85, $01, $10, $00, $00, $50, $30, $05, $00, $50, $23 ; object 0
    db $86, $01, $10, $00, $00, $60, $70, $06, $03, $60, $24 ; object 1

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_6F9A::
    db $02 ; entry 0: object count
    db $85, $01, $10, $00, $00, $40, $50, $05, $00, $50, $23 ; object 0
    db $86, $01, $10, $00, $00, $50, $50, $06, $00, $60, $24 ; object 1

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_6FB1::
    dw $0000 ; id 0
    dw ObjSelector_6FC1 ; id 1
    dw $0000 ; id 2
    dw $0000 ; id 3
    dw $0000 ; id 4
    dw ObjSelector_6FDC ; id 5
    dw ObjSelector_700D ; id 6
    dw $0000 ; id 7

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6FC1::
    objsel_list MapObjects_6FC5

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_6FC5::
    db $02 ; entry 0: object count
    db $85, $01, $0c, $00, $00, $40, $30, $05, $00, $50, $6a ; object 0
    db $86, $01, $18, $00, $00, $60, $60, $06, $03, $60, $6b ; object 1

ObjSelector_6FDC::
    objsel_list MapObjects_6FE0

; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_6FE0::
    db $04 ; entry 0: object count
    db $85, $01, $12, $00, $00, $30, $40, $05, $03, $50, $70 ; object 0
    db $86, $01, $10, $00, $00, $20, $30, $06, $00, $60, $6f ; object 1
    db $86, $01, $10, $00, $02, $20, $50, $06, $02, $60, $71 ; object 2
    db $84, $01, $11, $00, $02, $70, $20, $04, $01, $40, $e3 ; object 3

ObjSelector_700D::
    objsel_unless_flag $0025, MapObjects_7013
    objsel_none

; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_7013::
    db $01 ; entry 0
    db $85, $01, $16, $00, $00, $40, $60, $05, $01, $50, $a8

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_701F::
    dw ObjSelector_7021 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7021::
    objsel_list MapObjects_7025

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_7025::
    db $04 ; entry 0: object count
    db $85, $01, $1c, $00, $00, $70, $40, $05, $03, $50, $38 ; object 0
    db $86, $01, $1d, $00, $00, $60, $50, $06, $02, $60, $39 ; object 1
    db $87, $01, $18, $00, $00, $20, $20, $07, $00, $70, $3a ; object 2
    db $87, $01, $18, $00, $00, $40, $10, $07, $00, $70, $b0 ; object 3

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_7052::
    dw ObjSelector_7054 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7054::
    objsel_skip_if_clear $0025, $04, $00
    objsel_list MapObjects_7070

ObjSelector_705E::
    objsel_unless_flag EVENT_SCENE_THREE_ITEMS, MapObjects_7064
    objsel_none

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_7064::
    db $01 ; entry 0
    db $85, $01, $1a, $00, $00, $10, $20, $05, $00, $50, $3e

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_7070::
    db $02 ; entry 0: object count
    db $85, $01, $1b, $00, $00, $20, $40, $05, $02, $50, $42 ; object 0
    db $86, $01, $1a, $00, $00, $30, $30, $06, $03, $60, $3e ; object 1

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_7087::
    dw ObjSelector_7089 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7089::
    objsel_unless_flag EVENT_SCENE_THREE_ITEMS, MapObjects_7091
    objsel_list MapObjects_709D

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_7091::
    db $01 ; entry 0
    db $85, $01, $1b, $00, $00, $60, $50, $05, $01, $50, $42

; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_709D::
    db $02 ; entry 0: object count
    db $85, $01, $1b, $00, $00, $60, $40, $05, $00, $50, $42 ; object 0
    db $86, $01, $1a, $00, $00, $60, $50, $06, $02, $60, $3e ; object 1

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_70B4::
    dw ObjSelector_70B8 ; id 0
    dw ObjSelector_70D3 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_70B8::
    objsel_list MapObjects_70BC

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_70BC::
    db $02 ; entry 0: object count
    db $85, $01, $1b, $00, $00, $50, $30, $05, $00, $50, $2b ; object 0
    db $86, $01, $18, $00, $00, $10, $40, $06, $01, $60, $af ; object 1

ObjSelector_70D3::
    objsel_list MapObjects_70D7

; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_70D7::
    db $04 ; entry 0: object count
    db $85, $01, $1b, $00, $00, $40, $20, $05, $00, $50, $29 ; object 0
    db $86, $01, $1a, $00, $00, $30, $40, $06, $03, $60, $2c ; object 1
    db $87, $01, $11, $00, $02, $60, $60, $07, $01, $70, $2a ; object 2
    db $85, $01, $1b, $00, $00, $80, $70, $05, $03, $50, $ae ; object 3

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_7104::
    dw ObjSelector_7106 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7106::
    objsel_skip_if_clear $0025, $04, $00
    objsel_list MapObjects_713A

ObjSelector_7110::
    objsel_unless_flag EVENT_SCENE_MASTER_THANKS, MapObjects_7118
    objsel_list MapObjects_713A

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_7118::
    db $03 ; entry 0: object count
    db $85, $00, $02, $00, $00, $e0, $30, $05, $00, $50, $ad ; object 0
    db $86, $01, $1e, $00, $00, $60, $60, $06, $00, $60, $77 ; object 1
    db $87, $01, $19, $00, $00, $40, $40, $07, $01, $70, $27 ; object 2

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_713A::
    db $03 ; entry 0: object count
    db $85, $01, $1e, $00, $00, $60, $60, $05, $00, $50, $77 ; object 0
    db $86, $01, $19, $00, $00, $40, $40, $06, $02, $60, $27 ; object 1
    db $87, $00, $02, $00, $00, $40, $30, $07, $00, $70, $ad ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_715C::
    dw ObjSelector_715E ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_715E::
    objsel_list MapObjects_7162

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_7162::
    db $01 ; entry 0
    db $85, $01, $21, $00, $00, $40, $30, $05, $00, $50, $46

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_716E::
    dw ObjSelector_7170 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7170::
    objsel_list MapObjects_7174

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_7174::
    db $03 ; entry 0: object count
    db $85, $01, $0c, $00, $00, $50, $90, $05, $02, $50, $00 ; object 0
    db $86, $00, $01, $00, $00, $50, $a0, $06, $00, $60, $00 ; object 1
    db $87, $00, $01, $00, $00, $50, $a0, $07, $00, $70, $00 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_7196::
    dw ObjSelector_7198 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7198::
    objsel_unless_flag EVENT_DESK_KEY, MapObjects_71B0
    objsel_unless_flag EVENT_SCENE_CHEST_BATTLE, MapObjects_71DE
    objsel_unless_flag EVENT_SCENE_CHEST_BATTLE_207, MapObjects_71DE
    objsel_unless_flag EVENT_THAT_KEY_IUSED_03E, MapObjects_71B0
    objsel_unless_flag EVENT_DESK_KEY_0C8, MapObjects_71C7
    objsel_list MapObjects_71DE

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_71B0::
    db $02 ; entry 0: object count
    db $85, $01, $1e, $00, $00, $50, $30, $05, $00, $50, $8f ; object 0
    db $86, $01, $5d, $00, $00, $60, $08, $06, $00, $60, $db ; object 1

MapObjects_71C7::
    db $02 ; entry 0: object count
    db $85, $01, $1e, $00, $00, $40, $30, $05, $00, $50, $8f ; object 0
    db $86, $01, $5d, $00, $00, $60, $08, $06, $00, $60, $db ; object 1

; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_71DE::
    db $01 ; entry 0
    db $85, $01, $1e, $00, $00, $50, $30, $05, $00, $50, $8f

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_71EA::
    dw ObjSelector_71EC ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_71EC::
    objsel_list MapObjects_71F0

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_71F0::
    db $03 ; entry 0: object count
    db $85, $01, $1e, $00, $00, $60, $30, $05, $00, $50, $72 ; object 0
    db $86, $01, $1f, $00, $00, $30, $60, $06, $00, $60, $73 ; object 1
    db $87, $00, $11, $00, $00, $40, $20, $07, $01, $70, $d0 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_7212::
    dw ObjSelector_7214 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7214::
    objsel_skip_if_clear $0025, $0c, $00
    objsel_unless_flag $00c9, MapObjects_7288
    objsel_unless_flag $00ca, MapObjects_72B5
    objsel_list MapObjects_72E2

ObjSelector_7226::
    objsel_unless_flag EVENT_SCENE_THREE_ITEMS, MapObjects_722E
    objsel_list MapObjects_725B

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 4 object(s), the layout of the other object lists
MapObjects_722E::
    db $04 ; entry 0: object count
    db $87, $01, $15, $00, $00, $40, $30, $07, $03, $70, $89 ; object 0
    db $85, $01, $16, $00, $00, $70, $40, $05, $03, $50, $86 ; object 1
    db $85, $01, $16, $00, $00, $10, $60, $05, $02, $50, $87 ; object 2
    db $86, $01, $12, $00, $00, $50, $50, $06, $01, $60, $88 ; object 3

MapObjects_725B::
    db $04 ; entry 0: object count
    db $87, $01, $21, $00, $00, $40, $30, $07, $03, $70, $89 ; object 0
    db $85, $01, $16, $00, $00, $70, $40, $05, $03, $50, $86 ; object 1
    db $85, $01, $16, $00, $00, $10, $60, $05, $02, $50, $87 ; object 2
    db $86, $01, $12, $00, $00, $50, $50, $06, $01, $60, $88 ; object 3

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_7288::
    db $04 ; entry 0: object count
    db $87, $01, $2a, $00, $00, $40, $30, $07, $03, $70, $f0 ; object 0
    db $85, $01, $16, $00, $00, $70, $40, $05, $03, $50, $86 ; object 1
    db $85, $01, $16, $00, $00, $10, $60, $05, $02, $50, $87 ; object 2
    db $86, $01, $12, $00, $00, $50, $50, $06, $01, $60, $88 ; object 3

MapObjects_72B5::
    db $04 ; entry 0: object count
    db $87, $01, $13, $00, $00, $40, $30, $07, $03, $70, $f0 ; object 0
    db $85, $01, $16, $00, $00, $70, $40, $05, $03, $50, $86 ; object 1
    db $85, $01, $16, $00, $00, $10, $60, $05, $02, $50, $87 ; object 2
    db $86, $01, $12, $00, $00, $50, $50, $06, $01, $60, $88 ; object 3

MapObjects_72E2::
    db $04 ; entry 0: object count
    db $87, $01, $17, $00, $00, $40, $30, $07, $03, $70, $f0 ; object 0
    db $85, $01, $16, $00, $00, $70, $40, $05, $03, $50, $86 ; object 1
    db $85, $01, $16, $00, $00, $10, $60, $05, $02, $50, $87 ; object 2
    db $86, $01, $12, $00, $00, $50, $50, $06, $01, $60, $88 ; object 3

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_730F::
    dw ObjSelector_731B ; id 0
    dw ObjSelector_734C ; id 1
    dw ObjSelector_7372 ; id 2
    dw ObjSelector_73A3 ; id 3
    dw ObjSelector_73C9 ; id 4
    dw ObjSelector_73EF ; id 5

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_731B::
    objsel_list MapObjects_731F

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_731F::
    db $04 ; entry 0: object count
    db $85, $01, $19, $00, $00, $40, $40, $05, $00, $50, $56 ; object 0
    db $86, $00, $55, $00, $00, $40, $50, $06, $02, $60, $57 ; object 1
    db $87, $01, $1d, $00, $00, $70, $60, $07, $00, $70, $bb ; object 2
    db $85, $01, $07, $00, $02, $60, $70, $05, $01, $50, $bc ; object 3

ObjSelector_734C::
    objsel_list MapObjects_7350

; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_7350::
    db $03 ; entry 0: object count
    db $85, $01, $1b, $00, $00, $70, $60, $05, $00, $50, $61 ; object 0
    db $86, $01, $1e, $00, $00, $50, $50, $06, $02, $60, $bd ; object 1
    db $87, $01, $06, $00, $02, $20, $70, $07, $01, $70, $be ; object 2

ObjSelector_7372::
    objsel_list MapObjects_7376

MapObjects_7376::
    db $04 ; entry 0: object count
    db $85, $01, $1e, $00, $00, $10, $40, $05, $00, $50, $5b ; object 0
    db $86, $01, $1f, $00, $00, $20, $50, $06, $03, $60, $bf ; object 1
    db $87, $01, $10, $00, $02, $30, $60, $07, $01, $70, $5c ; object 2
    db $85, $01, $1e, $00, $00, $70, $70, $05, $03, $50, $c0 ; object 3

ObjSelector_73A3::
    objsel_list MapObjects_73A7

MapObjects_73A7::
    db $03 ; entry 0: object count
    db $85, $01, $12, $00, $00, $60, $20, $05, $00, $50, $58 ; object 0
    db $86, $00, $91, $00, $00, $50, $30, $06, $01, $60, $59 ; object 1
    db $87, $00, $33, $00, $00, $60, $40, $07, $02, $70, $5a ; object 2

ObjSelector_73C9::
    objsel_list MapObjects_73CD

MapObjects_73CD::
    db $03 ; entry 0: object count
    db $85, $01, $15, $00, $00, $50, $20, $05, $00, $50, $5d ; object 0
    db $86, $00, $5f, $00, $00, $60, $40, $06, $03, $60, $5f ; object 1
    db $87, $00, $26, $01, $02, $20, $50, $07, $01, $70, $60 ; object 2

ObjSelector_73EF::
    objsel_list MapObjects_73F3

MapObjects_73F3::
    db $04 ; entry 0: object count
    db $85, $01, $1c, $00, $00, $50, $50, $05, $03, $50, $55 ; object 0
    db $86, $01, $1d, $00, $00, $20, $30, $06, $00, $60, $5e ; object 1
    db $85, $01, $1c, $00, $00, $20, $40, $05, $02, $50, $c1 ; object 2
    db $87, $01, $1b, $00, $02, $40, $20, $07, $01, $70, $c2 ; object 3

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_7420::
    dw ObjSelector_742C ; id 0
    dw $0000 ; id 1
    dw ObjSelector_74A3 ; id 2
    dw ObjSelector_74F9 ; id 3
    dw ObjSelector_754A ; id 4
    dw $0000 ; id 5

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_742C::
    objsel_skip_if_clear $0025, $04, $00
    objsel_list MapObjects_745F

ObjSelector_7436::
    objsel_skip_if_clear EVENT_SCENE_DARCK_DEFEATED, $04, $00
    objsel_list MapObjects_7481

ObjSelector_7440::
    objsel_unless_flag EVENT_WHAT, MapObjects_7448
    objsel_list MapObjects_745F

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_7448::
    db $02 ; entry 0: object count
    db $85, $01, $3b, $00, $00, $40, $20, $05, $00, $50, $81 ; object 0
    db $86, $01, $12, $00, $00, $60, $30, $06, $03, $60, $82 ; object 1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_745F::
    db $03 ; entry 0: object count
    db $85, $01, $3b, $00, $00, $40, $20, $05, $00, $50, $81 ; object 0
    db $86, $01, $12, $00, $00, $60, $30, $06, $03, $60, $82 ; object 1
    db $87, $01, $10, $00, $00, $20, $40, $07, $02, $70, $20 ; object 2

; record: count, then 3 object(s), the layout of the other object lists
MapObjects_7481::
    db $03 ; entry 0: object count
    db $85, $01, $3b, $00, $00, $40, $20, $05, $00, $50, $81 ; object 0
    db $86, $01, $03, $00, $00, $30, $40, $06, $01, $60, $99 ; object 1
    db $87, $01, $1a, $00, $00, $60, $60, $07, $02, $70, $0a ; object 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_74A3::
    objsel_skip_if_clear $0025, $04, $00
    objsel_list MapObjects_74CB

ObjSelector_74AD::
    objsel_skip_if_clear EVENT_SCENE_DARCK_DEFEATED, $04, $00
    objsel_list MapObjects_74D7

ObjSelector_74B7::
    objsel_unless_flag EVENT_SCENE_KAMEHA_BACK, MapObjects_74BF
    objsel_list MapObjects_74CB

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_74BF::
    db $01 ; entry 0
    db $85, $01, $10, $00, $00, $40, $70, $05, $02, $50, $83

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_74CB::
    db $01 ; entry 0
    db $85, $01, $10, $00, $00, $30, $60, $05, $02, $50, $83

; record: count, then 3 object(s), the layout of the other object lists
MapObjects_74D7::
    db $03 ; entry 0: object count
    db $85, $01, $10, $00, $00, $40, $70, $05, $02, $50, $83 ; object 0
    db $86, $01, $1b, $00, $00, $30, $40, $06, $00, $60, $12 ; object 1
    db $87, $01, $1d, $00, $00, $60, $50, $07, $03, $70, $15 ; object 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_74F9::
    objsel_skip_if_clear $0025, $04, $00
    objsel_list MapObjects_7511

ObjSelector_7503::
    objsel_skip_if_clear EVENT_SCENE_DARCK_DEFEATED, $04, $00
    objsel_list MapObjects_7528

ObjSelector_750D::
    objsel_list MapObjects_7511

; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_7511::
    db $02 ; entry 0: object count
    db $85, $01, $10, $00, $00, $20, $30, $05, $01, $50, $84 ; object 0
    db $86, $01, $10, $00, $00, $20, $60, $06, $01, $60, $85 ; object 1

; an object list found by tiling a gap between map object layouts (E-0218)
MapObjects_7528::
    db $03 ; entry 0: object count
    db $85, $01, $10, $00, $00, $50, $70, $05, $00, $50, $84 ; object 0
    db $86, $01, $1c, $00, $02, $30, $30, $06, $01, $60, $0c ; object 1
    db $87, $01, $1e, $00, $00, $70, $40, $07, $00, $70, $25 ; object 2

ObjSelector_754A::
    objsel_unless_flag $0025, MapObjects_7552
    objsel_list MapObjects_755E

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_7552::
    db $01 ; entry 0
    db $85, $01, $03, $00, $00, $30, $30, $05, $00, $50, $99

MapObjects_755E::
    db $01 ; entry 0
    db $85, $01, $03, $00, $00, $d0, $30, $05, $00, $50, $99

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_756A::
    dw ObjSelector_7570 ; id 0
    dw ObjSelector_75C6 ; id 1
    dw ObjSelector_7679 ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7570::
    objsel_skip_if_clear $0025, $04, $00
    objsel_list MapObjects_7582

ObjSelector_757A::
    objsel_unless_flag EVENT_SCENE_THREE_ITEMS, MapObjects_7582
    objsel_list MapObjects_7599

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_7582::
    db $02 ; entry 0: object count
    db $85, $01, $1e, $00, $00, $40, $60, $05, $00, $50, $8a ; object 0
    db $86, $01, $1f, $00, $00, $50, $20, $06, $02, $60, $d9 ; object 1

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 4 object(s), the layout of the other object lists
MapObjects_7599::
    db $04 ; entry 0: object count
    db $85, $01, $1e, $00, $00, $40, $60, $05, $00, $50, $8a ; object 0
    db $86, $01, $1f, $00, $00, $50, $20, $06, $02, $60, $d9 ; object 1
    db $87, $01, $1b, $00, $00, $70, $30, $07, $00, $70, $dc ; object 2
    db $87, $01, $1b, $00, $00, $70, $40, $07, $02, $70, $dd ; object 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_75C6::
    objsel_skip_if_clear $0025, $04, $00
    objsel_list MapObjects_75E6

ObjSelector_75D0::
    objsel_skip_if_clear EVENT_SCENE_DARCK_DEFEATED, $08, $00
    objsel_unless_flag $0001, MapObjects_761F
    objsel_list MapObjects_764C

ObjSelector_75DE::
    objsel_unless_flag EVENT_SCENE_THREE_ITEMS, MapObjects_75E6
    objsel_list MapObjects_75F2

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_75E6::
    db $01 ; entry 0
    db $85, $01, $12, $00, $00, $30, $50, $05, $00, $50, $8d

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 4 object(s), the layout of the other object lists
MapObjects_75F2::
    db $04 ; entry 0: object count
    db $85, $01, $1a, $00, $00, $30, $50, $05, $00, $50, $de ; object 0
    db $85, $01, $1a, $00, $00, $20, $10, $05, $02, $50, $df ; object 1
    db $86, $01, $10, $00, $00, $50, $20, $06, $02, $60, $e0 ; object 2
    db $87, $01, $11, $00, $02, $70, $30, $07, $01, $70, $e1 ; object 3

MapObjects_761F::
    db $04 ; entry 0: object count
    db $85, $01, $04, $00, $00, $80, $20, $05, $03, $50, $00 ; object 0
    db $86, $01, $05, $00, $00, $80, $30, $06, $03, $60, $00 ; object 1
    db $87, $01, $00, $00, $00, $80, $40, $07, $03, $70, $00 ; object 2
    db $84, $01, $02, $00, $00, $e0, $30, $04, $01, $40, $00 ; object 3

MapObjects_764C::
    db $04 ; entry 0: object count
    db $85, $01, $04, $00, $00, $80, $20, $05, $03, $50, $00 ; object 0
    db $86, $01, $05, $00, $00, $80, $30, $06, $03, $60, $00 ; object 1
    db $87, $01, $01, $00, $00, $80, $40, $07, $03, $70, $00 ; object 2
    db $84, $01, $02, $00, $00, $e0, $30, $04, $01, $40, $00 ; object 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7679::
    objsel_unless_flag EVENT_SCENE_THREE_ITEMS, MapObjects_7689
    objsel_unless_flag EVENT_SCENE_DARCK_DEFEATED, MapObjects_76AB
    objsel_unless_flag $0025, MapObjects_7689
    objsel_list MapObjects_76C2

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_7689::
    db $03 ; entry 0: object count
    db $85, $01, $10, $00, $00, $20, $20, $05, $00, $50, $8c ; object 0
    db $86, $00, $7a, $00, $00, $40, $40, $06, $02, $60, $d7 ; object 1
    db $87, $01, $11, $00, $00, $40, $30, $07, $00, $70, $d6 ; object 2

; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_76AB::
    db $02 ; entry 0: object count
    db $85, $01, $10, $00, $00, $30, $20, $05, $00, $50, $8c ; object 0
    db $86, $01, $12, $00, $00, $60, $30, $06, $01, $60, $8d ; object 1

MapObjects_76C2::
    db $03 ; entry 0: object count
    db $85, $01, $10, $00, $00, $20, $20, $05, $00, $50, $8c ; object 0
    db $86, $00, $7a, $00, $00, $50, $40, $06, $02, $60, $d7 ; object 1
    db $87, $01, $11, $00, $00, $50, $30, $07, $00, $70, $d6 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_76E4::
    dw ObjSelector_76E8 ; id 0
    dw ObjSelector_69_76F8 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_76E8::
    objsel_list MapObjects_76EC

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_76EC::
    db $02 ; entry 0: object count
    db $85, $01, $57, $00, $00, $45, $80, $05, $02, $50, $00 ; object 0
ObjSelector_69_76F8::
    db $fe, $ff, $fc, $76, $01, $85, $01, $57, $00, $00, $45 ; object 1
    db $a0, $05, $02, $50, $00

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_7708::
    dw ObjSelector_770C ; id 0
    dw ObjSelector_776E ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_770C::
    objsel_unless_flag $0001, MapObjects_7714
    objsel_list MapObjects_7741

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_7714::
    db $04 ; entry 0: object count
    db $85, $01, $04, $00, $00, $50, $10, $05, $00, $50, $32 ; object 0
    db $86, $01, $05, $00, $00, $40, $10, $06, $00, $60, $31 ; object 1
    db $87, $01, $28, $00, $00, $80, $40, $07, $01, $70, $30 ; object 2
    db $84, $01, $00, $00, $00, $b0, $50, $04, $03, $40, $00 ; object 3

MapObjects_7741::
    db $04 ; entry 0: object count
    db $85, $01, $04, $00, $00, $50, $10, $05, $00, $50, $32 ; object 0
    db $86, $01, $05, $00, $00, $40, $10, $06, $00, $60, $31 ; object 1
    db $87, $01, $28, $00, $00, $80, $40, $07, $01, $70, $30 ; object 2
    db $84, $01, $01, $00, $00, $b0, $50, $04, $03, $40, $00 ; object 3

ObjSelector_776E::
    objsel_skip_if_set EVENT_SCENE_AT_SEA, $08, $00
    objsel_unless_flag $0001, MapObjects_7784
    objsel_list MapObjects_77B1

ObjSelector_777C::
    objsel_unless_flag $0001, MapObjects_77DE
    objsel_list MapObjects_7800

MapObjects_7784::
    db $04 ; entry 0: object count
    db $85, $01, $29, $00, $02, $50, $30, $05, $01, $50, $2d ; object 0
    db $86, $01, $29, $00, $00, $10, $60, $06, $00, $60, $2e ; object 1
    db $87, $01, $00, $00, $00, $e0, $50, $07, $01, $70, $2f ; object 2
    db $86, $01, $29, $00, $00, $20, $e0, $06, $02, $60, $00 ; object 3

MapObjects_77B1::
    db $04 ; entry 0: object count
    db $85, $01, $29, $00, $02, $50, $30, $05, $01, $50, $2d ; object 0
    db $86, $01, $29, $00, $00, $10, $60, $06, $00, $60, $2e ; object 1
    db $87, $01, $01, $00, $00, $e0, $50, $07, $01, $70, $2f ; object 2
    db $86, $01, $29, $00, $00, $20, $e0, $06, $02, $60, $00 ; object 3

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_77DE::
    db $03 ; entry 0: object count
    db $85, $01, $29, $00, $02, $50, $30, $05, $01, $50, $2d ; object 0
    db $86, $01, $29, $00, $00, $10, $60, $06, $00, $60, $2e ; object 1
    db $87, $01, $00, $00, $00, $30, $40, $07, $01, $70, $2f ; object 2

MapObjects_7800::
    db $03 ; entry 0: object count
    db $85, $01, $29, $00, $02, $50, $30, $05, $01, $50, $2d ; object 0
    db $86, $01, $29, $00, $00, $10, $60, $06, $00, $60, $2e ; object 1
    db $87, $01, $01, $00, $00, $30, $40, $07, $01, $70, $2f ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_7822::
    dw ObjSelector_7826 ; id 0
    dw ObjSelector_7857 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7826::
    objsel_list MapObjects_782A

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_782A::
    db $04 ; entry 0: object count
    db $85, $01, $23, $00, $00, $40, $70, $05, $01, $50, $00 ; object 0
    db $86, $01, $24, $00, $00, $10, $60, $06, $02, $60, $01 ; object 1
    db $87, $01, $25, $00, $00, $10, $50, $07, $00, $70, $02 ; object 2
    db $87, $01, $25, $00, $00, $70, $30, $07, $00, $70, $03 ; object 3

ObjSelector_7857::
    objsel_list MapObjects_785B

; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_785B::
    db $03 ; entry 0: object count
    db $85, $01, $26, $00, $00, $60, $50, $05, $00, $50, $04 ; object 0
    db $86, $01, $25, $00, $02, $30, $60, $06, $01, $60, $05 ; object 1
    db $87, $01, $24, $00, $00, $10, $30, $07, $00, $70, $06 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_787D::
    dw ObjSelector_787F ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_787F::
    objsel_list MapObjects_7883

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_7883::
    db $03 ; entry 0: object count
    db $85, $01, $24, $00, $00, $30, $40, $05, $01, $50, $0a ; object 0
    db $86, $01, $25, $00, $00, $80, $70, $06, $03, $60, $0b ; object 1
    db $87, $01, $12, $00, $00, $50, $10, $07, $00, $70, $45 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_78A5::
    dw ObjSelector_78A7 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_78A7::
    objsel_list MapObjects_78AB

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_78AB::
    db $02 ; entry 0: object count
    db $85, $01, $24, $00, $00, $10, $60, $05, $02, $50, $1f ; object 0
    db $86, $01, $24, $00, $00, $50, $10, $06, $00, $60, $20 ; object 1

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_78C2::
    dw ObjSelector_78CA ; id 0
    dw ObjSelector_792C ; id 1
    dw ObjSelector_7947 ; id 2
    dw ObjSelector_7978 ; id 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_78CA::
    objsel_unless_flag EVENT_SCENE_MONSTER_INSPECTION, MapObjects_78D2
    objsel_list MapObjects_78FF

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_78D2::
    db $04 ; entry 0: object count
    db $85, $01, $4d, $00, $00, $40, $10, $05, $00, $50, $13 ; object 0
    db $85, $01, $4d, $00, $00, $50, $10, $05, $00, $50, $14 ; object 1
    db $86, $01, $24, $00, $00, $70, $60, $06, $03, $60, $0d ; object 2
    db $87, $01, $25, $00, $00, $30, $70, $07, $00, $70, $15 ; object 3

MapObjects_78FF::
    db $04 ; entry 0: object count
    db $85, $01, $4d, $00, $00, $30, $20, $05, $00, $50, $13 ; object 0
    db $85, $01, $4d, $00, $02, $60, $30, $05, $00, $50, $14 ; object 1
    db $86, $01, $24, $00, $00, $70, $60, $06, $03, $60, $0d ; object 2
    db $87, $01, $25, $00, $00, $30, $70, $07, $00, $70, $15 ; object 3

ObjSelector_792C::
    objsel_list MapObjects_7930

; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_7930::
    db $02 ; entry 0: object count
    db $85, $01, $12, $00, $00, $60, $30, $05, $00, $50, $17 ; object 0
    db $86, $01, $4d, $00, $00, $20, $60, $06, $01, $60, $0e ; object 1

ObjSelector_7947::
    objsel_list MapObjects_794B

MapObjects_794B::
    db $04 ; entry 0: object count
    db $85, $01, $26, $00, $00, $70, $70, $05, $03, $50, $0c ; object 0
    db $86, $01, $24, $00, $00, $20, $40, $06, $00, $60, $10 ; object 1
    db $87, $01, $15, $00, $00, $80, $20, $07, $00, $70, $12 ; object 2
    db $85, $01, $26, $00, $02, $60, $50, $05, $01, $50, $11 ; object 3

ObjSelector_7978::
    objsel_unless_flag EVENT_SCENE_MONSTER_INSPECTION, MapObjects_7980
    objsel_list MapObjects_79A2

; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_7980::
    db $03 ; entry 0: object count
    db $85, $01, $25, $00, $00, $20, $60, $05, $03, $50, $0f ; object 0
    db $86, $01, $24, $00, $00, $50, $50, $06, $00, $60, $16 ; object 1
    db $87, $01, $4b, $00, $00, $40, $30, $07, $00, $70, $18 ; object 2

MapObjects_79A2::
    db $02 ; entry 0: object count
    db $85, $01, $25, $00, $00, $20, $60, $05, $03, $50, $0f ; object 0
    db $86, $01, $24, $00, $00, $50, $50, $06, $00, $60, $16 ; object 1

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_79B9::
    dw ObjSelector_79BD ; id 0
    dw ObjSelector_7A32 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_79BD::
    objsel_skip_if_clear EVENT_SCENE_RIVAL_DEFEATED_05A, $04, $00
    objsel_list MapObjects_79ED

ObjSelector_79C7::
    objsel_skip_if_set EVENT_SCENE_MONSTER_INSPECTION, $02, $00
    objsel_none

ObjSelector_79CF::
    objsel_skip_if_clear EVENT_KING_THE_TOWN, $06, $00
    objsel_unless_flag EVENT_SCENE_TREASURE_THEFT, MapObjects_7A10
    objsel_none

ObjSelector_79DB::
    objsel_skip_if_clear EVENT_YOU_WILL_SO_WE_CAN, $04, $00
    objsel_list MapObjects_79ED

ObjSelector_79E5::
    objsel_unless_flag EVENT_KING_WHAT_NEVER_MIND_THEN, MapObjects_79ED
    objsel_list MapObjects_7A04

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_79ED::
    db $02 ; entry 0: object count
    db $85, $01, $4d, $00, $00, $30, $50, $05, $00, $50, $27 ; object 0
    db $86, $01, $24, $00, $02, $60, $40, $06, $00, $60, $28 ; object 1

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_7A04::
    db $01 ; entry 0
    db $85, $01, $4d, $00, $00, $30, $50, $05, $00, $50, $27

; record: count, then 3 object(s), the layout of the other object lists
MapObjects_7A10::
    db $03 ; entry 0: object count
    db $85, $01, $22, $00, $00, $40, $18, $05, $00, $50, $2b ; object 0
    db $86, $01, $4d, $00, $00, $30, $50, $06, $00, $60, $27 ; object 1
    db $87, $01, $24, $00, $00, $60, $40, $07, $00, $70, $28 ; object 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7A32::
    objsel_skip_if_clear EVENT_SCENE_RIVAL_DEFEATED_05A, $04, $00
    objsel_list MapObjects_7A6F

ObjSelector_7A3C::
    objsel_unless_flag EVENT_SCENE_TREASURE_THEFT, MapObjects_7A42
    objsel_none

; record: count, then 4 object(s), the layout of the other object lists
MapObjects_7A42::
    db $04 ; entry 0: object count
    db $85, $01, $4c, $00, $00, $20, $10, $05, $03, $50, $22 ; object 0
    db $85, $01, $4c, $00, $00, $20, $20, $05, $03, $50, $23 ; object 1
    db $85, $01, $4c, $00, $00, $10, $30, $05, $02, $50, $24 ; object 2
    db $86, $01, $4b, $00, $00, $30, $50, $06, $00, $60, $21 ; object 3

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_7A6F::
    db $03 ; entry 0: object count
    db $85, $01, $4c, $00, $00, $20, $10, $05, $03, $50, $22 ; object 0
    db $85, $01, $4c, $00, $00, $20, $20, $05, $03, $50, $23 ; object 1
    db $86, $01, $4b, $00, $00, $30, $50, $06, $00, $60, $21 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_7A91::
    dw ObjSelector_7A93 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7A93::
    objsel_skip_if_set $0025, $0a, $00
    objsel_skip_if_clear EVENT_SCENE_DARCK_DEFEATED, $04, $00
    objsel_list MapObjects_7B26

ObjSelector_7AA3::
    objsel_skip_if_clear EVENT_SCENE_RIVAL_DEFEATED_05A, $04, $00
    objsel_list MapObjects_7ACB

ObjSelector_7AAD::
    objsel_skip_if_clear EVENT_KING_THE_TOWN, $06, $00
    objsel_unless_flag EVENT_SCENE_TREASURE_THEFT, MapObjects_7AEE
    objsel_none

ObjSelector_7AB9::
    objsel_skip_if_clear EVENT_YOU_WILL_SO_WE_CAN, $04, $00
    objsel_list MapObjects_7ACB

ObjSelector_7AC3::
    objsel_unless_flag EVENT_KING_WHAT_NEVER_MIND_THEN, MapObjects_7ACB
    objsel_list MapObjects_7AE2

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_7ACB::
    db $02 ; entry 0: object count
    db $85, $01, $24, $00, $00, $50, $a0, $05, $02, $50, $28 ; object 0
    db $86, $01, $22, $00, $00, $40, $10, $06, $00, $60, $2b ; object 1

; record: count, then 1 object(s), the layout of the other object lists
MapObjects_7AE2::
    db $01 ; entry 0
    db $85, $01, $24, $00, $00, $50, $40, $05, $00, $50, $28

; record: count, then 5 object(s), the layout of the other object lists
MapObjects_7AEE::
    db $05 ; entry 0: object count
    db $85, $01, $22, $00, $00, $40, $10, $05, $00, $50, $2b ; object 0
    db $87, $01, $4d, $00, $00, $50, $50, $07, $02, $70, $00 ; object 1
    db $86, $01, $24, $00, $00, $40, $50, $06, $02, $60, $28 ; object 2
    db $87, $01, $4d, $00, $00, $30, $50, $06, $02, $70, $00 ; object 3
    db $87, $01, $4d, $00, $00, $60, $50, $06, $02, $70, $00 ; object 4

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 5 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_7B26::
    db $05 ; entry 0: object count
    db $85, $01, $22, $00, $00, $40, $10, $05, $00, $50, $2b ; object 0
    db $86, $01, $24, $00, $00, $60, $20, $06, $00, $60, $28 ; object 1
    db $87, $01, $4b, $00, $00, $40, $50, $07, $02, $70, $21 ; object 2
    db $83, $01, $4c, $00, $00, $30, $60, $03, $02, $30, $23 ; object 3
    db $83, $01, $4c, $00, $00, $60, $60, $03, $02, $30, $23 ; object 4

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_7B5E::
    dw ObjSelector_7B62 ; id 0
    dw ObjSelector_7B72 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7B62::
    objsel_list MapObjects_7B66

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_7B66::
    db $01 ; entry 0
    db $85, $00, $4f, $00, $00, $50, $20, $05, $00, $50, $3b

ObjSelector_7B72::
    objsel_skip_if_clear EVENT_SCENE_RIVAL_DEFEATED_05A, $02, $00
    objsel_none

ObjSelector_7B7A::
    objsel_list MapObjects_7B7E

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 4 object(s), the layout of the other object lists
MapObjects_7B7E::
    db $04 ; entry 0: object count
    db $85, $01, $5c, $00, $00, $40, $10, $05, $00, $50, $3c ; object 0
    db $86, $01, $22, $00, $00, $40, $a0, $06, $02, $60, $2b ; object 1
    db $87, $01, $4d, $00, $00, $40, $b0, $07, $02, $70, $00 ; object 2
    db $87, $01, $4d, $00, $00, $40, $c0, $07, $02, $70, $00 ; object 3

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_7BAB::
    dw ObjSelector_7BAD ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7BAD::
    objsel_skip_if_set $004a, $08, $00
    objsel_unless_flag EVENT_KING_WHAT_NEVER_MIND_THEN, MapObjects_7BBF
    objsel_list MapObjects_7BCB

ObjSelector_7BBB::
    objsel_list MapObjects_7BE2

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_7BBF::
    db $01 ; entry 0
    db $85, $01, $26, $00, $00, $20, $40, $05, $00, $50, $09

; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_7BCB::
    db $02 ; entry 0: object count
    db $85, $01, $22, $00, $00, $20, $50, $05, $02, $50, $2b ; object 0
    db $86, $01, $26, $00, $00, $20, $40, $06, $00, $60, $09 ; object 1

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_7BE2::
    db $02 ; entry 0: object count
    db $85, $01, $22, $00, $00, $e0, $e0, $05, $02, $50, $2b ; object 0
    db $86, $01, $26, $00, $00, $20, $10, $06, $00, $60, $09 ; object 1

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_7BF9::
    dw $0000 ; id 0
    dw $0000 ; id 1
    dw $0000 ; id 2
    dw $0000 ; id 3
    dw $0000 ; id 4
    dw $0000 ; id 5
    dw $0000 ; id 6
    dw $0000 ; id 7
    dw $0000 ; id 8
    dw ObjSelector_7C19 ; id 9
    dw $0000 ; id 10
    dw $0000 ; id 11
    dw $0000 ; id 12
    dw $0000 ; id 13
    dw $0000 ; id 14
    dw $0000 ; id 15

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7C19::
    objsel_skip_if_clear EVENT_SCENE_WATER_SOLVED, $02, $00
    objsel_none

ObjSelector_7C21::
    objsel_unless_flag EVENT_YOU_WILL_SO_WE_CAN, MapObjects_7C29
    objsel_list MapObjects_7C40

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_7C29::
    db $02 ; entry 0: object count
    db $85, $01, $22, $00, $00, $30, $70, $05, $02, $50, $2b ; object 0
    db $86, $00, $4f, $00, $00, $30, $60, $06, $00, $60, $37 ; object 1

; record: count, then 1 object(s), the layout of the other object lists
MapObjects_7C40::
    db $01 ; entry 0
    db $85, $01, $22, $00, $00, $30, $70, $05, $02, $50, $2b

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_7C4C::
    dw ObjSelector_7C4E ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7C4E::
    objsel_skip_if_clear EVENT_SCENE_RIVAL_DEFEATED_05A, $04, $00
    objsel_list MapObjects_7CAF

ObjSelector_7C58::
    objsel_unless_flag EVENT_SCENE_TREASURE_THEFT, MapObjects_7C60
    objsel_list MapObjects_7C82

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_7C60::
    db $03 ; entry 0: object count
    db $85, $01, $4d, $00, $00, $50, $30, $05, $00, $50, $2c ; object 0
    db $86, $01, $4d, $00, $00, $20, $40, $06, $02, $60, $2d ; object 1
    db $87, $01, $24, $00, $00, $20, $20, $07, $00, $70, $00 ; object 2

; record: count, then 4 object(s), the layout of the other object lists
MapObjects_7C82::
    db $04 ; entry 0: object count
    db $85, $01, $24, $00, $00, $20, $20, $05, $00, $50, $00 ; object 0
    db $86, $01, $4b, $00, $00, $20, $60, $06, $02, $60, $00 ; object 1
    db $87, $01, $4c, $00, $00, $20, $70, $07, $01, $70, $00 ; object 2
    db $87, $01, $4c, $00, $00, $30, $70, $07, $03, $70, $00 ; object 3

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_7CAF::
    db $04 ; entry 0: object count
    db $85, $01, $4d, $00, $00, $50, $30, $05, $00, $50, $2c ; object 0
    db $86, $01, $27, $00, $00, $30, $70, $06, $00, $60, $00 ; object 1
    db $86, $01, $27, $00, $00, $10, $70, $06, $01, $60, $00 ; object 2
    db $86, $01, $27, $00, $00, $20, $70, $06, $03, $60, $00 ; object 3

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_7CDC::
    dw ObjSelector_7CDE ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7CDE::
    objsel_skip_if_clear EVENT_SCENE_RIVAL_DEFEATED_05A, $04, $00
    objsel_list MapObjects_7CF8

ObjSelector_7CE8::
    objsel_skip_if_clear EVENT_KING_THE_TOWN, $06, $00
    objsel_unless_flag EVENT_SCENE_TREASURE_THEFT, MapObjects_7D0F
    objsel_none

ObjSelector_7CF4::
    objsel_list MapObjects_7CF8

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_7CF8::
    db $02 ; entry 0: object count
    db $85, $01, $4d, $00, $00, $40, $40, $05, $00, $50, $25 ; object 0
    db $85, $01, $4d, $00, $00, $50, $40, $05, $00, $50, $26 ; object 1

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_7D0F::
    db $03 ; entry 0: object count
    db $85, $01, $22, $00, $00, $30, $60, $05, $01, $50, $2b ; object 0
    db $86, $01, $4d, $00, $00, $60, $50, $06, $02, $60, $25 ; object 1
    db $86, $01, $4d, $00, $00, $70, $70, $06, $03, $60, $26 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_7D31::
    dw ObjSelector_7D39 ; id 0
    dw ObjSelector_7D51 ; id 1
    dw ObjSelector_7DDD ; id 2
    dw $0000 ; id 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7D39::
    objsel_skip_if_set EVENT_SCENE_RIVAL_DEFEATED_05A, $02, $00
    objsel_none

ObjSelector_7D41::
    objsel_list MapObjects_7D45

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_7D45::
    db $01 ; entry 0
    db $85, $00, $4f, $00, $00, $30, $60, $05, $01, $50, $3d

ObjSelector_7D51::
    objsel_skip_if_set $0025, $0a, $00
    objsel_skip_if_clear EVENT_SCENE_DARCK_DEFEATED, $04, $00
    objsel_list MapObjects_7DBB

ObjSelector_7D61::
    objsel_skip_if_clear EVENT_SCENE_WATER_REWARD, $04, $00
    objsel_list MapObjects_7DAF

ObjSelector_7D6B::
    objsel_skip_if_clear EVENT_SCENE_RIVAL_DEFEATED_05A, $04, $00
    objsel_list MapObjects_7D98

ObjSelector_7D75::
    objsel_skip_if_set $0058, $02, $00
    objsel_none

ObjSelector_7D7D::
    objsel_list MapObjects_7D81

; record: count, then 2 object(s), the layout of the other object lists
MapObjects_7D81::
    db $02 ; entry 0: object count
    db $85, $00, $4f, $00, $00, $30, $60, $05, $00, $50, $3a ; object 0
    db $85, $00, $4f, $00, $00, $60, $40, $05, $03, $50, $3b ; object 1

MapObjects_7D98::
    db $02 ; entry 0: object count
    db $85, $00, $4f, $00, $00, $30, $60, $05, $00, $50, $3a ; object 0
    db $85, $00, $4f, $00, $00, $60, $40, $05, $00, $50, $37 ; object 1

MapObjects_7DAF::
    db $01 ; entry 0
    db $85, $00, $4f, $00, $00, $30, $60, $05, $00, $50, $3a

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_7DBB::
    db $03 ; entry 0: object count
    db $85, $00, $4f, $00, $00, $40, $e0, $05, $00, $50, $37 ; object 0
    db $85, $00, $4f, $00, $00, $50, $e0, $05, $00, $50, $37 ; object 1
    db $85, $00, $4f, $00, $00, $40, $e0, $05, $00, $50, $3a ; object 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7DDD::
    objsel_skip_if_clear $0058, $02, $00
    objsel_none

ObjSelector_7DE5::
    objsel_skip_if_set EVENT_SCENE_TREASURE_THEFT, $02, $00
    objsel_none

ObjSelector_7DED::
    objsel_list MapObjects_7DF1

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 4 object(s), the layout of the other object lists
MapObjects_7DF1::
    db $04 ; entry 0: object count
    db $85, $01, $22, $00, $00, $60, $60, $05, $02, $50, $2b ; object 0
    db $86, $01, $4d, $00, $00, $10, $40, $06, $02, $60, $25 ; object 1
    db $86, $01, $4d, $00, $02, $20, $70, $06, $02, $60, $26 ; object 2
    db $86, $01, $4d, $00, $00, $80, $50, $06, $02, $60, $2d ; object 3

MapObjects_7E1E::
    db $04 ; entry 0: object count
    db $85, $01, $22, $00, $00, $60, $30, $05, $03, $50, $2b ; object 0
    db $86, $01, $4d, $00, $00, $10, $10, $06, $02, $60, $25 ; object 1
    db $86, $01, $4d, $00, $02, $20, $40, $06, $01, $60, $26 ; object 2
    db $86, $01, $4d, $00, $00, $80, $20, $06, $03, $60, $2d ; object 3

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_7E4B::
    dw $0000 ; id 0
    dw $0000 ; id 1
    dw $0000 ; id 2
    dw $0000 ; id 3
    dw $0000 ; id 4
    dw $0000 ; id 5
    dw $0000 ; id 6
    dw $0000 ; id 7
    dw $0000 ; id 8
    dw $0000 ; id 9
    dw $0000 ; id 10
    dw $0000 ; id 11
    dw $0000 ; id 12
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
    dw $0000 ; id 25
    dw $0000 ; id 26
    dw $0000 ; id 27
    dw $0000 ; id 28
    dw $0000 ; id 29
    dw $0000 ; id 30
    dw $0000 ; id 31
    dw $0000 ; id 32
    dw $0000 ; id 33
    dw $0000 ; id 34
    dw $0000 ; id 35
    dw $0000 ; id 36
    dw $0000 ; id 37
    dw $0000 ; id 38
    dw $0000 ; id 39
    dw $0000 ; id 40
    dw $0000 ; id 41
    dw $0000 ; id 42
    dw $0000 ; id 43
    dw $0000 ; id 44
    dw $0000 ; id 45
    dw $0000 ; id 46
    dw $0000 ; id 47
    dw $0000 ; id 48
    dw $0000 ; id 49
    dw $0000 ; id 50
    dw $0000 ; id 51
    dw $0000 ; id 52
    dw $0000 ; id 53
    dw $0000 ; id 54
    dw $0000 ; id 55
    dw $0000 ; id 56
    dw $0000 ; id 57
    dw $0000 ; id 58
    dw $0000 ; id 59
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
    dw $0000 ; id 76
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
    dw $0000 ; id 91
    dw $0000 ; id 92
    dw $0000 ; id 93
    dw $0000 ; id 94
    dw $0000 ; id 95
    dw $0000 ; id 96
    dw $0000 ; id 97
    dw $0000 ; id 98
    dw $0000 ; id 99
    dw $0000 ; id 100
    dw $0000 ; id 101
    dw $0000 ; id 102
    dw $0000 ; id 103
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
    dw $0000 ; id 118
    dw $0000 ; id 119
    dw $0000 ; id 120
    dw $0000 ; id 121
    dw $0000 ; id 122
    dw $0000 ; id 123
    dw $0000 ; id 124
    dw $0000 ; id 125
    dw $0000 ; id 126
    dw $0000 ; id 127
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
    dw $0000 ; id 141
    dw $0000 ; id 142
    dw $0000 ; id 143
    ds $95, $00
