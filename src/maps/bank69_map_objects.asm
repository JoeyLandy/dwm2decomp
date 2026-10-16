; ROM bank $69: map object lists and selectors
; The annotated listing of this bank is build/listing/bank69.asm.

SECTION "Bank 69", ROMX[$4000], BANK[$69]
    db $69

; Fills wSpriteSlots with the objects of the current screen. It first sets wSpriteSlotCount to 0. On
; a key world or other special map (bit 7 of wMapType) it far-calls SetupKeyWorldObjectsForMapType
; instead. Otherwise hMapId picks a word of MapObjectTable, the address of the screen table of that
; map (wMapWidthScreens words per row; the word at hMapScreenX, hMapScreenY is 0 for no objects,
; else the address of a selector). A selector is a list of entries tried in order, each starting
; with a word: a flag number gives the object list that follows when the story flag is clear
; (objsel_unless_flag; a set flag goes on to the next entry); $FFFF = no objects; $FFFE = the list
; that follows; $FFFD = the list after two flag words, taken when neither flag is set; $FFFC and
; $FFFB = a flag, then two bytes of which the first is a distance to skip forward in the selector
; when the flag is clear ($FFFC) or set ($FFFB); any other value of $FF00 or more = no objects. The
; object list is a count byte and then 11 bytes per object (VRAM page, graphics table, graphics
; number, slot bytes, X, Y, palette slot, facing, talk event group); each is copied into
; wSpriteSlots (with the number of objects left, & 3, stored in one slot byte), and its graphics are
; decompressed by DecompressGraphicsTemp0ToTemp4. One exception first: map $2F at screen (0, 1) uses
; LoadMapObjectsForScreen_MapObjects when EVENT_SCENE_TREASURE_THEFT is set,
; EVENT_SCENE_MONSTERS_IN_TOW is clear and bit 3 of wStoryFlags + $61 is set. It always ends with
; RestoreSpriteSnapshot and wOBJPaletteUploadRequest = $7F. (C1, E-0384)
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
    ld de, EVENT_SCENE_MONSTERS_IN_TOW
    call TestFlagBit
    jr c, .read_map_id
    ld a, [wStoryFlags + $61]
    bit 3, a
    jr z, .read_map_id
    ld hl, LoadMapObjectsForScreen_MapObjects
    jp .set_sprite_slot_count

.read_map_id:
    ldh a, [hMapId]
    ld l, a
    ld h, $00
    add hl, hl
    ld a, l
    add LOW(MapObjectTable)
    ld l, a
    ld a, h
    adc HIGH(MapObjectTable)
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
    dw MapObjectScreens_Map00 ; id 0
    dw MapObjectScreens_Map01 ; id 1
    dw MapObjectScreens_Map02 ; id 2
    dw MapObjectScreens_Map03 ; id 3
    dw MapObjectScreens_Map04 ; id 4
    dw MapObjectScreens_Map05 ; id 5
    dw MapObjectScreens_Map06 ; id 6
    dw MapObjectScreens_Map07 ; id 7
    dw MapObjectScreens_Map08 ; id 8
    dw MapObjectScreens_Map09 ; id 9
    dw MapObjectScreens_Map0A ; id 10
    dw MapObjectScreens_Map0B ; id 11
    dw MapObjectScreens_Map0C ; id 12
    dw MapObjectScreens_Map0D ; id 13
    dw MapObjectScreens_Map0E ; id 14
    dw MapObjectScreens_Map0F ; id 15
    dw MapObjectScreens_Map10 ; id 16
    dw MapObjectScreens_Map11 ; id 17
    dw MapObjectScreens_Map12 ; id 18
    dw MapObjectScreens_Map13 ; id 19
    dw MapObjectScreens_Map14 ; id 20
    dw MapObjectScreens_Map15 ; id 21
    dw MapObjectScreens_Map16 ; id 22
    dw MapObjectScreens_Map17 ; id 23
    dw MapObjectScreens_Map18 ; id 24
    dw MapObjectScreens_Map19 ; id 25
    dw MapObjectScreens_Map1A ; id 26
    dw MapObjectScreens_Map03 ; id 27
    dw MapObjectScreens_Map1C ; id 28
    dw MapObjectScreens_Map1D ; id 29
    dw MapObjectScreens_Map03 ; id 30
    dw MapObjectScreens_Map03 ; id 31
    dw MapObjectScreens_Map03 ; id 32
    dw MapObjectScreens_Map21 ; id 33
    dw MapObjectScreens_Map22 ; id 34
    dw MapObjectScreens_Map23 ; id 35
    dw MapObjectScreens_Map24 ; id 36
    dw MapObjectScreens_Map25 ; id 37
    dw MapObjectScreens_Map26 ; id 38
    dw MapObjectScreens_Map03 ; id 39
    dw MapObjectScreens_Map28 ; id 40
    dw MapObjectScreens_Map03 ; id 41
    dw MapObjectScreens_Map2A ; id 42
    dw MapObjectScreens_Map2B ; id 43
    dw MapObjectScreens_Map03 ; id 44
    dw MapObjectScreens_Map2D ; id 45
    dw MapObjectScreens_Map2E ; id 46
    dw MapObjectScreens_Map2F ; id 47
    dw MapObjectScreens_Map30 ; id 48
    dw MapObjectScreens_Map31 ; id 49
    dw MapObjectScreens_Map32 ; id 50
    dw MapObjectScreens_Map33 ; id 51
    dw MapObjectScreens_Map34 ; id 52
    dw MapObjectScreens_Map35 ; id 53
    dw MapObjectScreens_Map03 ; id 54
    dw MapObjectScreens_Map37 ; id 55
    dw MapObjectScreens_Map38 ; id 56
    dw MapObjectScreens_Map39 ; id 57
    dw MapObjectScreens_Map3A ; id 58
    dw MapObjectScreens_Map3B ; id 59
    dw MapObjectScreens_Map3C ; id 60
    dw MapObjectScreens_Map3D ; id 61
    dw MapObjectScreens_Map03 ; id 62
    dw MapObjectScreens_Map03 ; id 63
    dw MapObjectScreens_Map40 ; id 64
    dw MapObjectScreens_Map41 ; id 65
    dw MapObjectScreens_Map42 ; id 66
    dw MapObjectScreens_Map43 ; id 67
    dw MapObjectScreens_Map44 ; id 68
    dw MapObjectScreens_Map03 ; id 69
    dw MapObjectScreens_Map03 ; id 70
    dw MapObjectScreens_Map03 ; id 71
    dw MapObjectScreens_Map03 ; id 72
    dw MapObjectScreens_Map49 ; id 73
    dw MapObjectScreens_Map4A ; id 74
    dw MapObjectScreens_Map4B ; id 75
    dw MapObjectScreens_Map4C ; id 76
    dw MapObjectScreens_Map4D ; id 77
    dw MapObjectScreens_Map4E ; id 78
    dw MapObjectScreens_Map4F ; id 79
    dw MapObjectScreens_Map50 ; id 80
    dw MapObjectScreens_Map51 ; id 81
    dw MapObjectScreens_Map52 ; id 82
    dw MapObjectScreens_Map53 ; id 83
    dw MapObjectScreens_Map54 ; id 84
    dw MapObjectScreens_Map55 ; id 85
    dw MapObjectScreens_Map03 ; id 86
    dw MapObjectScreens_Map57 ; id 87
    dw MapObjectScreens_Map58 ; id 88
    dw MapObjectScreens_Map59 ; id 89
    dw MapObjectScreens_Map5A ; id 90
    dw MapObjectScreens_Map5B ; id 91
    dw MapObjectScreens_Map5C ; id 92
    dw MapObjectScreens_Map5D ; id 93
    dw MapObjectScreens_Map5E ; id 94
    dw MapObjectScreens_Map5F ; id 95
    dw MapObjectScreens_Map60 ; id 96
    dw MapObjectScreens_Map61 ; id 97
    dw MapObjectScreens_Map03 ; id 98
    dw MapObjectScreens_Map03 ; id 99
    dw MapObjectScreens_Map03 ; id 100
    dw MapObjectScreens_Map03 ; id 101
    dw MapObjectScreens_Map03 ; id 102
    dw MapObjectScreens_Map03 ; id 103
    dw MapObjectScreens_Map03 ; id 104
    dw MapObjectScreens_Map03 ; id 105
    dw MapObjectScreens_Map03 ; id 106
    dw MapObjectScreens_Map03 ; id 107
    dw MapObjectScreens_Map03 ; id 108
    dw MapObjectScreens_Map03 ; id 109
    dw MapObjectScreens_Map03 ; id 110
    dw MapObjectScreens_Map03 ; id 111
    dw MapObjectScreens_Map03 ; id 112
    dw MapObjectScreens_Map71 ; id 113
    dw MapObjectScreens_Map72 ; id 114
    dw MapObjectScreens_Map03 ; id 115
    dw MapObjectScreens_Map03 ; id 116
    dw MapObjectScreens_Map03 ; id 117
    dw MapObjectScreens_Map76 ; id 118
    dw MapObjectScreens_Map77 ; id 119
    dw MapObjectScreens_Map78 ; id 120
    dw MapObjectScreens_Map79 ; id 121
    dw MapObjectScreens_Map7A ; id 122
    dw MapObjectScreens_Map03 ; id 123
    dw MapObjectScreens_Map7C ; id 124
    dw MapObjectScreens_Map7D ; id 125
    dw MapObjectScreens_Map7E ; id 126
    dw MapObjectScreens_Map7F ; id 127
    dw MapObjectScreens_Map03 ; id 128
    dw MapObjectScreens_Map03 ; id 129
    dw MapObjectScreens_Map03 ; id 130
    dw MapObjectScreens_Map03 ; id 131
    dw MapObjectScreens_Map84 ; id 132
    dw MapObjectScreens_Map03 ; id 133
    dw MapObjectScreens_Map03 ; id 134
    dw MapObjectScreens_Map03 ; id 135
    dw MapObjectScreens_Map03 ; id 136
    dw MapObjectScreens_Map89 ; id 137
    dw MapObjectScreens_Map03 ; id 138
    dw MapObjectScreens_Map03 ; id 139
    dw MapObjectScreens_Map8C ; id 140
    dw MapObjectScreens_Map03 ; id 141
    dw MapObjectScreens_Map8E ; id 142
    dw MapObjectScreens_Map8F ; id 143
    dw MapObjectScreens_Map90 ; id 144
    dw MapObjectScreens_Map91 ; id 145
    dw MapObjectScreens_Map03 ; id 146
    dw MapObjectScreens_Map03 ; id 147
    dw MapObjectScreens_Map94 ; id 148
    dw MapObjectScreens_Map95 ; id 149
    dw MapObjectScreens_Map96 ; id 150
    dw MapObjectScreens_Map03 ; id 151
    dw MapObjectScreens_Map03 ; id 152
    dw MapObjectScreens_Map03 ; id 153
    dw MapObjectScreens_Map03 ; id 154
    dw MapObjectScreens_Map9B ; id 155
    dw MapObjectScreens_Map03 ; id 156
    dw MapObjectScreens_Map03 ; id 157
    dw MapObjectScreens_Map03 ; id 158
    dw MapObjectScreens_Map03 ; id 159
    dw MapObjectScreens_Map03 ; id 160
    dw MapObjectScreens_MapA1 ; id 161
    dw MapObjectScreens_Map03 ; id 162
    dw MapObjectScreens_MapA3 ; id 163
    dw MapObjectScreens_Map03 ; id 164
    dw MapObjectScreens_Map03 ; id 165
    dw MapObjectScreens_Map03 ; id 166
    dw MapObjectScreens_Map03 ; id 167
    dw MapObjectScreens_Map03 ; id 168
    dw MapObjectScreens_MapA9 ; id 169
    dw MapObjectScreens_MapAA ; id 170
    dw MapObjectScreens_MapAB ; id 171
    dw MapObjectScreens_MapAC ; id 172
    dw MapObjectScreens_Map03 ; id 173
    dw MapObjectScreens_Map03 ; id 174
    dw MapObjectScreens_Map03 ; id 175
    dw MapObjectScreens_Map03 ; id 176
    dw MapObjectScreens_MapB1 ; id 177
    dw MapObjectScreens_Map03 ; id 178
    dw MapObjectScreens_Map03 ; id 179
    dw MapObjectScreens_Map03 ; id 180
    dw MapObjectScreens_Map03 ; id 181
    dw MapObjectScreens_MapB6 ; id 182
    dw MapObjectScreens_Map03 ; id 183
    dw MapObjectScreens_Map03 ; id 184
    dw MapObjectScreens_MapB9 ; id 185
    dw MapObjectScreens_MapBA ; id 186
    dw MapObjectScreens_MapBB ; id 187
    dw MapObjectScreens_MapBC ; id 188
    dw MapObjectScreens_MapBD ; id 189
    dw MapObjectScreens_Map03 ; id 190
    dw MapObjectScreens_Map03 ; id 191
    dw MapObjectScreens_Map03 ; id 192
    dw MapObjectScreens_Map03 ; id 193
    dw MapObjectScreens_Map03 ; id 194
    dw MapObjectScreens_Map03 ; id 195
    dw MapObjectScreens_Map03 ; id 196
    dw MapObjectScreens_Map03 ; id 197
    dw MapObjectScreens_Map03 ; id 198
    dw MapObjectScreens_Map03 ; id 199
    dw MapObjectScreens_Map03 ; id 200
    dw MapObjectScreens_MapC9 ; id 201
    dw MapObjectScreens_MapCA ; id 202
    dw MapObjectScreens_MapCB ; id 203
    dw MapObjectScreens_MapCC ; id 204
    dw MapObjectScreens_MapCD ; id 205
    dw MapObjectScreens_MapCE ; id 206
    dw MapObjectScreens_Map03 ; id 207
    dw MapObjectScreens_Map03 ; id 208
    dw MapObjectScreens_Map03 ; id 209
    dw MapObjectScreens_MapD2 ; id 210
    dw MapObjectScreens_MapD3 ; id 211
    dw MapObjectScreens_MapD4 ; id 212
    dw MapObjectScreens_MapD5 ; id 213
    dw MapObjectScreens_MapD6 ; id 214
    dw MapObjectScreens_MapD7 ; id 215
    dw MapObjectScreens_Map03 ; id 216
    dw MapObjectScreens_Map03 ; id 217
    dw MapObjectScreens_Map03 ; id 218
    dw MapObjectScreens_MapDB ; id 219
    dw MapObjectScreens_MapDC ; id 220
    dw MapObjectScreens_MapDD ; id 221
    dw MapObjectScreens_MapDE ; id 222
    dw MapObjectScreens_MapDF ; id 223
    dw MapObjectScreens_MapE0 ; id 224
    dw MapObjectScreens_Map03 ; id 225
    dw MapObjectScreens_Map03 ; id 226
    dw MapObjectScreens_Map03 ; id 227

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_MapE0::
    dw $0000 ; id 0
    dw ObjSelector_MapE0_1 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_MapE0_1::
    objsel_unless_flag EVENT_MAP_E0_OBJECT_REMOVED, MapObjects_MapE0_1_0
    objsel_list MapObjects_MapE0_1_1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_MapE0_1_0::
    db $01 ; entry 0
    db $85, $01, $41, $00, $00, $40, $20, $05, $00, $50, $a7

MapObjects_MapE0_1_1::
    db $01 ; entry 0
    db $85, $01, $41, $00, $00, $30, $20, $05, $00, $50, $a7

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_MapDF::
    dw $0000 ; id 0
    dw ObjSelector_MapDF_1 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_MapDF_1::
    objsel_unless_flag EVENT_MAP_DF_OBJECT_REMOVED, MapObjects_MapDF_1_0
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_MapDF_1_0::
    db $01 ; entry 0
    db $85, $00, $0d, $00, $00, $40, $30, $05, $00, $50, $a6

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_MapDE::
    dw $0000 ; id 0
    dw ObjSelector_MapDE_1 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_MapDE_1::
    objsel_unless_flag EVENT_MAP_DE_OBJECT_REMOVED, MapObjects_MapDE_1_0
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_MapDE_1_0::
    db $01 ; entry 0
    db $85, $00, $5c, $00, $00, $40, $30, $05, $00, $50, $a5

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_MapDD::
    dw $0000 ; id 0
    dw ObjSelector_MapDD_1 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_MapDD_1::
    objsel_unless_flag EVENT_MAP_DD_OBJECT_REMOVED, MapObjects_MapDD_1_0
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_MapDD_1_0::
    db $01 ; entry 0
    db $85, $00, $55, $00, $00, $40, $30, $05, $00, $50, $a4

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_MapDC::
    dw $0000 ; id 0
    dw ObjSelector_MapDC_1 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_MapDC_1::
    objsel_unless_flag EVENT_MAP_DC_OBJECT_REMOVED, MapObjects_MapDC_1_0
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_MapDC_1_0::
    db $01 ; entry 0
    db $85, $00, $10, $00, $00, $40, $30, $05, $00, $50, $a3

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_MapDB::
    dw ObjSelector_MapDB_0 ; id 0
    dw ObjSelector_MapDB_1 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_MapDB_0::
    objsel_list MapObjects_MapDB_0_0

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_MapDB_0_0::
    db $02 ; entry 0: object count
    db $85, $00, $63, $00, $00, $20, $40, $05, $00, $50, $a0 ; object 0
    db $86, $01, $52, $00, $00, $60, $30, $06, $02, $60, $a1 ; object 1

ObjSelector_MapDB_1::
    objsel_list MapObjects_MapDB_1_0

; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_MapDB_1_0::
    db $01 ; entry 0
    db $85, $00, $59, $00, $00, $40, $30, $05, $00, $50, $a2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_MapD7::
    dw $0000 ; id 0
    dw ObjSelector_MapD7_1 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_MapD7_1::
    objsel_unless_flag EVENT_MAP_D7_OBJECT_REMOVED, MapObjects_MapD7_1_0
    objsel_list MapObjects_MapD7_1_1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_MapD7_1_0::
    db $01 ; entry 0
    db $85, $00, $9a, $00, $00, $40, $20, $05, $00, $50, $87

MapObjects_MapD7_1_1::
    db $01 ; entry 0
    db $85, $00, $9a, $00, $00, $30, $20, $05, $00, $50, $87

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_MapD6::
    dw $0000 ; id 0
    dw ObjSelector_MapD6_1 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_MapD6_1::
    objsel_unless_flag EVENT_MAP_D6_OBJECT_REMOVED, MapObjects_MapD6_1_0
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_MapD6_1_0::
    db $01 ; entry 0
    db $85, $00, $8d, $00, $00, $40, $30, $05, $00, $50, $86

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_MapD5::
    dw $0000 ; id 0
    dw ObjSelector_MapD5_1 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_MapD5_1::
    objsel_unless_flag EVENT_MAP_D5_OBJECT_REMOVED, MapObjects_MapD5_1_0
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_MapD5_1_0::
    db $01 ; entry 0
    db $85, $00, $80, $00, $00, $40, $30, $05, $00, $50, $85

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_MapD4::
    dw $0000 ; id 0
    dw ObjSelector_MapD4_1 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_MapD4_1::
    objsel_unless_flag EVENT_MAP_D4_OBJECT_REMOVED, MapObjects_MapD4_1_0
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_MapD4_1_0::
    db $01 ; entry 0
    db $85, $00, $92, $00, $00, $40, $30, $05, $00, $50, $84

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_MapD3::
    dw $0000 ; id 0
    dw ObjSelector_MapD3_1 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_MapD3_1::
    objsel_unless_flag EVENT_MAP_D3_OBJECT_REMOVED, MapObjects_MapD3_1_0
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_MapD3_1_0::
    db $01 ; entry 0
    db $85, $00, $39, $00, $00, $40, $30, $05, $00, $50, $83

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_MapD2::
    dw ObjSelector_MapD2_0 ; id 0
    dw ObjSelector_MapD2_1 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_MapD2_0::
    objsel_list MapObjects_MapD2_0_0

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_MapD2_0_0::
    db $02 ; entry 0: object count
    db $85, $00, $15, $00, $00, $70, $40, $05, $00, $50, $80 ; object 0
    db $86, $01, $11, $00, $00, $10, $70, $06, $03, $60, $81 ; object 1

ObjSelector_MapD2_1::
    objsel_list MapObjects_MapD2_1_0

; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_MapD2_1_0::
    db $01 ; entry 0
    db $85, $00, $51, $00, $00, $40, $30, $05, $00, $50, $82

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_MapCE::
    dw $0000 ; id 0
    dw ObjSelector_MapCE_1 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_MapCE_1::
    objsel_unless_flag EVENT_MAP_CE_OBJECT_REMOVED, MapObjects_MapCE_1_0
    objsel_list MapObjects_MapCE_1_1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_MapCE_1_0::
    db $01 ; entry 0
    db $85, $00, $ed, $00, $00, $40, $20, $05, $00, $50, $67

MapObjects_MapCE_1_1::
    db $01 ; entry 0
    db $85, $00, $ed, $00, $00, $30, $20, $05, $00, $50, $67

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_MapCD::
    dw $0000 ; id 0
    dw ObjSelector_MapCD_1 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_MapCD_1::
    objsel_unless_flag EVENT_MAP_CD_OBJECT_REMOVED, MapObjects_MapCD_1_0
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_MapCD_1_0::
    db $01 ; entry 0
    db $85, $00, $25, $01, $00, $40, $30, $05, $00, $50, $66

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_MapCC::
    dw $0000 ; id 0
    dw ObjSelector_MapCC_1 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_MapCC_1::
    objsel_unless_flag EVENT_MAP_CC_OBJECT_REMOVED, MapObjects_MapCC_1_0
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_MapCC_1_0::
    db $01 ; entry 0
    db $85, $00, $2e, $01, $00, $40, $30, $05, $00, $50, $65

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_MapCB::
    dw $0000 ; id 0
    dw ObjSelector_MapCB_1 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_MapCB_1::
    objsel_unless_flag EVENT_MAP_CB_OBJECT_REMOVED, MapObjects_MapCB_1_0
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_MapCB_1_0::
    db $01 ; entry 0
    db $85, $00, $55, $01, $00, $40, $30, $05, $00, $50, $64

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_MapCA::
    dw $0000 ; id 0
    dw ObjSelector_MapCA_1 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_MapCA_1::
    objsel_unless_flag EVENT_MAP_CA_OBJECT_REMOVED, MapObjects_MapCA_1_0
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_MapCA_1_0::
    db $01 ; entry 0
    db $85, $00, $4e, $00, $00, $40, $30, $05, $00, $50, $63

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_MapC9::
    dw ObjSelector_MapC9_0 ; id 0
    dw ObjSelector_MapC9_1 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_MapC9_0::
    objsel_list MapObjects_MapC9_0_0

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_MapC9_0_0::
    db $02 ; entry 0: object count
    db $85, $00, $47, $00, $00, $30, $30, $05, $00, $50, $60 ; object 0
    db $86, $01, $3e, $00, $00, $70, $50, $06, $03, $60, $61 ; object 1

ObjSelector_MapC9_1::
    objsel_list MapObjects_MapC9_1_0

; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_MapC9_1_0::
    db $01 ; entry 0
    db $85, $00, $06, $00, $00, $40, $30, $05, $00, $50, $62

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_MapB9::
    dw ObjSelector_MapB9_0 ; id 0
    dw ObjSelector_MapB9_1 ; id 1
    dw ObjSelector_MapB9_2 ; id 2
    dw ObjSelector_MapB9_3 ; id 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_MapB9_0::
    objsel_list MapObjects_MapB9_0_0

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_MapB9_0_0::
    db $03 ; entry 0: object count
    db $85, $01, $0c, $00, $02, $40, $50, $05, $01, $50, $36 ; object 0
    db $86, $01, $0d, $00, $00, $20, $30, $06, $00, $60, $37 ; object 1
    db $87, $01, $08, $00, $00, $70, $20, $07, $03, $70, $38 ; object 2

ObjSelector_MapB9_1::
    objsel_list MapObjects_MapB9_1_0

; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_MapB9_1_0::
    db $04 ; entry 0: object count
    db $85, $01, $09, $00, $00, $60, $50, $05, $03, $50, $39 ; object 0
    db $86, $01, $0a, $00, $00, $20, $60, $06, $00, $60, $3a ; object 1
    db $85, $01, $09, $00, $02, $20, $40, $05, $01, $50, $3b ; object 2
    db $87, $01, $15, $00, $00, $40, $20, $07, $00, $70, $3c ; object 3

ObjSelector_MapB9_2::
    objsel_list MapObjects_MapB9_2_0

MapObjects_MapB9_2_0::
    db $03 ; entry 0: object count
    db $85, $01, $08, $00, $00, $30, $60, $05, $00, $50, $30 ; object 0
    db $86, $01, $09, $00, $00, $30, $40, $06, $01, $60, $31 ; object 1
    db $87, $01, $06, $00, $02, $60, $20, $07, $01, $70, $32 ; object 2

ObjSelector_MapB9_3::
    objsel_list MapObjects_MapB9_3_0

MapObjects_MapB9_3_0::
    db $03 ; entry 0: object count
    db $85, $01, $07, $00, $02, $20, $60, $05, $01, $50, $33 ; object 0
    db $86, $01, $0a, $00, $00, $60, $40, $06, $00, $60, $34 ; object 1
    db $87, $01, $0b, $00, $00, $20, $20, $07, $00, $70, $35 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_MapBA::
    dw ObjSelector_MapBA_0 ; id 0
    dw ObjSelector_MapBA_1 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_MapBA_0::
    objsel_unless_flag EVENT_SCENE_PENDANT_SELLER_1C0, MapObjects_MapBA_0_0
    objsel_list MapObjects_MapBA_0_1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_MapBA_0_0::
    db $02 ; entry 0: object count
    db $85, $01, $2a, $00, $00, $70, $60, $05, $03, $50, $43 ; object 0
    db $86, $01, $51, $00, $00, $30, $40, $06, $00, $60, $44 ; object 1

; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_MapBA_0_1::
    db $01 ; entry 0
    db $85, $01, $2a, $00, $00, $70, $60, $05, $03, $50, $43

ObjSelector_MapBA_1::
    objsel_list MapObjects_MapBA_1_0

; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_MapBA_1_0::
    db $03 ; entry 0: object count
    db $85, $01, $16, $00, $00, $50, $60, $05, $00, $50, $40 ; object 0
    db $86, $01, $22, $00, $02, $50, $20, $06, $01, $60, $41 ; object 1
    db $87, $01, $13, $00, $00, $30, $40, $07, $00, $70, $42 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_MapBB::
    dw ObjSelector_MapBB_0 ; id 0
    dw ObjSelector_MapBB_1 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_MapBB_0::
    objsel_skip_if_set EVENT_SCENE_PENDANT_SELLER_1C0, $02, $00
    objsel_none

ObjSelector_MapBB_0_Unlisted::
    objsel_unless_flag EVENT_SCENE_MILAYOU_FOREST, MapObjects_MapBB_0_Unlisted_0
    objsel_unless_flag EVENT_KEY_BOSS_BEATEN_2, MapObjects_MapBB_0_Unlisted_1
    objsel_none

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_MapBB_0_Unlisted_0::
    db $01 ; entry 0
    db $85, $01, $43, $00, $00, $40, $20, $05, $02, $50, $3f

MapObjects_MapBB_0_Unlisted_1::
    db $01 ; entry 0
    db $85, $01, $43, $00, $00, $30, $20, $05, $00, $50, $3f

ObjSelector_MapBB_1::
    objsel_skip_if_set EVENT_SCENE_PENDANT_SELLER, $02, $00
    objsel_none

ObjSelector_MapBB_1_Unlisted::
    objsel_unless_flag EVENT_SCENE_MERCY, MapObjects_MapBB_1_Unlisted_0
    objsel_unless_flag EVENT_HERO_OPENED_THE_TREASURE_CHEST, MapObjects_MapBB_1_Unlisted_1
    objsel_none

; record: count, then 3 object(s), the layout of the other object lists
MapObjects_MapBB_1_Unlisted_0::
    db $03 ; entry 0: object count
    db $85, $00, $d3, $00, $00, $40, $10, $05, $01, $50, $45 ; object 0
    db $86, $00, $d3, $00, $00, $50, $10, $06, $03, $60, $46 ; object 1
    db $87, $01, $5a, $00, $00, $50, $e0, $07, $00, $70, $47 ; object 2

MapObjects_MapBB_1_Unlisted_1::
    db $01 ; entry 0
    db $85, $01, $5a, $00, $00, $50, $10, $05, $00, $50, $47

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_MapBC::
    dw ObjSelector_MapBC_0 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_MapBC_0::
    objsel_unless_flag EVENT_THANK_YOU_I_KNEW_YOU, MapObjects_MapBC_0_0
    objsel_unless_flag EVENT_THANK_YOU_FOR_GETTING_THE, MapObjects_MapBC_0_1
    objsel_unless_flag EVENT_SCENE_PENDANT_SELLER_1C0, MapObjects_MapBC_0_0
    objsel_unless_flag EVENT_KEY_BOSS_BEATEN_2, MapObjects_MapBC_0_1
    objsel_unless_flag EVENT_MILAYOU_I_LOST_BUT_GOOD, MapObjects_MapBC_0_0
    objsel_list MapObjects_MapBC_0_1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_MapBC_0_0::
    db $03 ; entry 0: object count
    db $85, $01, $15, $00, $00, $30, $20, $05, $00, $50, $3d ; object 0
    db $86, $01, $43, $00, $00, $70, $40, $06, $00, $60, $3f ; object 1
    db $87, $01, $13, $00, $00, $70, $70, $07, $00, $70, $3e ; object 2

; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_MapBC_0_1::
    db $02 ; entry 0: object count
    db $85, $01, $15, $00, $00, $30, $20, $05, $00, $50, $3d ; object 0
    db $86, $01, $13, $00, $00, $70, $70, $06, $00, $60, $3e ; object 1

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_MapBD::
    dw ObjSelector_MapBD_0 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_MapBD_0::
    objsel_unless_flag EVENT_KEY_BOSS_BEATEN_2, MapObjects_MapBD_0_0
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_MapBD_0_0::
    db $02 ; entry 0: object count
    db $85, $01, $51, $00, $00, $50, $20, $05, $00, $50, $48 ; object 0
    db $86, $01, $43, $00, $00, $e0, $e0, $06, $00, $60, $3f ; object 1

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_MapB1::
    dw ObjSelector_MapB1_0 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_MapB1_0::
    objsel_unless_flag EVENT_KIRAL_OH_FOOLISH_OF_ME, MapObjects_MapB1_0_0
    objsel_unless_flag EVENT_KIRAL_FETCH_ME_MY_167, MapObjects_MapB1_0_1
    objsel_list MapObjects_MapB1_0_2

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_MapB1_0_0::
    db $02 ; entry 0: object count
    db $85, $01, $20, $00, $00, $30, $40, $05, $02, $50, $20 ; object 0
    db $86, $00, $2a, $01, $00, $40, $30, $06, $00, $60, $21 ; object 1

MapObjects_MapB1_0_1::
    db $02 ; entry 0: object count
    db $85, $01, $20, $00, $00, $10, $40, $05, $02, $50, $20 ; object 0
    db $86, $00, $2a, $01, $00, $40, $30, $06, $00, $60, $21 ; object 1

; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_MapB1_0_2::
    db $03 ; entry 0: object count
    db $85, $01, $20, $00, $00, $60, $50, $05, $02, $50, $20 ; object 0
    db $86, $00, $2a, $01, $00, $40, $30, $06, $00, $60, $21 ; object 1
    db $87, $00, $29, $01, $00, $50, $10, $07, $00, $70, $2d ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_MapB6::
    dw ObjSelector_MapB6_0 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_MapB6_0::
    objsel_unless_flag EVENT_SCENE_BARREL, MapObjects_MapB6_0_0
    objsel_unless_flag EVENT_KIRAL_FETCH_ME_MY_167, MapObjects_MapB6_0_1
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_MapB6_0_0::
    db $02 ; entry 0: object count
    db $85, $00, $29, $01, $00, $40, $20, $05, $00, $50, $2d ; object 0
    db $86, $01, $61, $00, $00, $40, $e0, $06, $00, $60, $2d ; object 1

; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_MapB6_0_1::
    db $01 ; entry 0
    db $85, $01, $61, $00, $00, $40, $20, $05, $00, $50, $2d

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_MapA9::
    dw ObjSelector_MapA9_0 ; id 0
    dw ObjSelector_MapA9_1 ; id 1
    dw ObjSelector_MapA9_2 ; id 2
    dw ObjSelector_MapA9_3 ; id 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_MapA9_0::
    objsel_list MapObjects_MapA9_0_0

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_MapA9_0_0::
    db $02 ; entry 0: object count
    db $85, $01, $42, $00, $00, $50, $20, $05, $02, $50, $06 ; object 0
    db $86, $01, $32, $00, $00, $50, $40, $06, $00, $60, $07 ; object 1

ObjSelector_MapA9_1::
    objsel_unless_flag EVENT_SCENE_ROLT_ELDER, MapObjects_MapA9_1_0
    objsel_unless_flag EVENT_CYAL_LISTEN_HERO_WE_SHOULD, MapObjects_MapA9_1_1
    objsel_unless_flag EVENT_ROLT_WAIT_GONE_ALREADY, MapObjects_MapA9_1_2
    objsel_unless_flag EVENT_KEY_BOSS_BEATEN, MapObjects_MapA9_1_3
    objsel_list MapObjects_MapA9_1_4

; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_MapA9_1_0::
    db $03 ; entry 0: object count
    db $85, $01, $35, $00, $00, $70, $10, $05, $00, $50, $0b ; object 0
    db $86, $01, $31, $00, $00, $40, $a0, $06, $02, $60, $01 ; object 1
    db $87, $01, $32, $00, $00, $40, $b0, $07, $02, $70, $02 ; object 2

MapObjects_MapA9_1_1::
    db $03 ; entry 0: object count
    db $85, $01, $35, $00, $00, $70, $10, $05, $00, $50, $0b ; object 0
    db $86, $01, $31, $00, $00, $60, $40, $06, $02, $60, $01 ; object 1
    db $87, $01, $32, $00, $00, $20, $70, $07, $00, $70, $02 ; object 2

MapObjects_MapA9_1_2::
    db $02 ; entry 0: object count
    db $85, $01, $35, $00, $00, $70, $10, $05, $00, $50, $0b ; object 0
    db $86, $01, $31, $00, $00, $60, $40, $06, $02, $60, $01 ; object 1

; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_MapA9_1_3::
    db $01 ; entry 0
    db $85, $01, $35, $00, $00, $70, $10, $05, $00, $50, $0b

MapObjects_MapA9_1_4::
    db $03 ; entry 0: object count
    db $85, $01, $35, $00, $00, $70, $10, $05, $00, $50, $0b ; object 0
    db $86, $01, $31, $00, $00, $30, $50, $06, $02, $60, $01 ; object 1
    db $87, $01, $32, $00, $00, $40, $60, $07, $02, $70, $02 ; object 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_MapA9_2::
    objsel_list MapObjects_MapA9_2_0

; an object list of LoadMapObjectsForScreen (E-0163)
MapObjects_MapA9_2_0::
    db $03 ; entry 0: object count
    db $85, $01, $33, $00, $00, $60, $60, $05, $01, $50, $08 ; object 0
    db $86, $01, $34, $00, $02, $20, $50, $06, $01, $60, $09 ; object 1
    db $87, $01, $37, $00, $00, $20, $30, $07, $00, $70, $0a ; object 2

ObjSelector_MapA9_3::
    objsel_list MapObjects_MapA9_3_0

MapObjects_MapA9_3_0::
    db $03 ; entry 0: object count
    db $85, $01, $37, $00, $00, $80, $40, $05, $00, $50, $03 ; object 0
    db $86, $01, $34, $00, $00, $20, $30, $06, $01, $60, $04 ; object 1
    db $87, $01, $31, $00, $02, $40, $60, $07, $00, $70, $05 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_MapAA::
    dw ObjSelector_MapAA_0 ; id 0
    dw ObjSelector_MapAA_1 ; id 1

ObjSelector_MapAA_0::
    objsel_skip_if_clear EVENT_SCENE_TOO_STRONG, $02, $00
    objsel_none

ObjSelector_MapAA_0_Unlisted::
    objsel_skip_if_clear EVENT_CYAL_LISTEN_HERO_WE_SHOULD, $04, $00
    objsel_list MapObjects_MapAA_0_Unlisted_1

ObjSelector_MapAA_0_Unlisted_2::
    objsel_unless_flag EVENT_SCENE_ROLT_ELDER, MapObjects_MapAA_0_Unlisted_2_0
    objsel_none

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_MapAA_0_Unlisted_2_0::
    db $02 ; entry 0: object count
    db $85, $01, $31, $00, $00, $40, $30, $05, $00, $50, $01 ; object 0
    db $86, $01, $32, $00, $00, $50, $20, $06, $00, $60, $02 ; object 1

; record: count, then 4 object(s), the layout of the other object lists
MapObjects_MapAA_0_Unlisted_1::
    db $04 ; entry 0: object count
    db $85, $01, $32, $00, $00, $60, $10, $05, $00, $50, $02 ; object 0
    db $86, $00, $d5, $00, $00, $50, $20, $06, $00, $60, $00 ; object 1
    db $87, $00, $57, $00, $00, $50, $40, $07, $00, $70, $0d ; object 2
    db $87, $00, $57, $00, $00, $40, $30, $07, $00, $70, $0e ; object 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_MapAA_1::
    objsel_skip_if_clear EVENT_CYAL_EEEK_HERO_HELP_ME, $02, $00
    objsel_none

ObjSelector_MapAA_1_Unlisted::
    objsel_skip_if_clear EVENT_CYAL_LISTEN_HERO_WE_SHOULD, $04, $00
    objsel_list MapObjects_MapAA_1_Unlisted_1

ObjSelector_MapAA_1_Unlisted_2::
    objsel_unless_flag EVENT_SCENE_CYAL_SHINE, MapObjects_MapAA_1_Unlisted_1
    objsel_none

; record: count, then 1 object(s), the layout of the other object lists
MapObjects_MapAA_1_Unlisted_1::
    db $01 ; entry 0
    db $85, $01, $32, $00, $00, $40, $30, $05, $02, $50, $02

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_MapAB::
    dw ObjSelector_MapAB_0 ; id 0

ObjSelector_MapAB_0::
    objsel_list MapObjects_MapAB_0_0

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_MapAB_0_0::
    db $02 ; entry 0: object count
    db $85, $01, $37, $00, $00, $50, $40, $05, $00, $50, $0f ; object 0
    db $86, $01, $38, $00, $00, $30, $20, $06, $03, $60, $10 ; object 1

MapObjectScreens_MapAC::
    dw ObjSelector_MapAC_0 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_MapAC_0::
    objsel_skip_if_set EVENT_ROLT_WAIT_GONE_ALREADY, $02, $00
    objsel_none

ObjSelector_MapAC_0_Unlisted::
    objsel_unless_flag EVENT_SCENE_GIVE_BACK_CYAL, MapObjects_MapAC_0_Unlisted_0
    objsel_unless_flag EVENT_KEY_BOSS_BEATEN, MapObjects_MapAC_0_Unlisted_1
    objsel_none

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_MapAC_0_Unlisted_0::
    db $03 ; entry 0: object count
    db $85, $00, $d5, $00, $00, $40, $30, $05, $00, $50, $11 ; object 0
    db $86, $01, $32, $00, $00, $40, $20, $06, $00, $60, $02 ; object 1
    db $87, $01, $31, $00, $00, $40, $60, $07, $02, $70, $01 ; object 2

MapObjects_MapAC_0_Unlisted_1::
    db $03 ; entry 0: object count
    db $85, $00, $d5, $00, $00, $40, $30, $05, $00, $50, $11 ; object 0
    db $86, $01, $32, $00, $00, $40, $20, $06, $00, $60, $02 ; object 1
    db $87, $01, $31, $00, $00, $60, $40, $07, $03, $70, $01 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_MapA1::
    dw ObjSelector_MapA1_0 ; id 0
    dw $0000 ; id 1
    dw $0000 ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_MapA1_0::
    objsel_unless_flag EVENT_SCENE_DARCK_TAUNT, MapObjects_MapA1_0_0
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_MapA1_0_0::
    db $02 ; entry 0: object count
    db $85, $01, $5c, $00, $00, $40, $30, $05, $00, $50, $00 ; object 0
    db $86, $00, $df, $00, $00, $40, $e0, $06, $00, $60, $00 ; object 1

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_MapA3::
    dw ObjSelector_MapA3_0 ; id 0
    dw $0000 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_MapA3_0::
    objsel_unless_flag EVENT_SCENE_DARCK_DEFEATED, MapObjects_MapA3_0_0
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_MapA3_0_0::
    db $02 ; entry 0: object count
    db $85, $01, $4a, $00, $00, $40, $e0, $05, $00, $50, $00 ; object 0
    db $86, $01, $48, $00, $05, $48, $30, $06, $00, $60, $01 ; object 1

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map71::
    dw ObjSelector_Map71_0 ; id 0
    dw ObjSelector_Map71_1 ; id 1
    dw ObjSelector_Map71_2 ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map71_0::
    objsel_skip_if_set EVENT_THANKS_FOR_COMING_BY_025, $0a, $00
    objsel_skip_if_clear EVENT_SCENE_DARCK_DEFEATED, $04, $00
    objsel_list MapObjects_Map71_0_2

ObjSelector_Map71_0_Unlisted::
    objsel_list MapObjects_Map71_0_Unlisted_0

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_Map71_0_Unlisted_0::
    db $02 ; entry 0: object count
    db $85, $00, $6d, $00, $00, $70, $20, $05, $00, $50, $0b ; object 0
    db $86, $00, $55, $01, $00, $20, $e0, $06, $00, $60, $00 ; object 1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map71_0_2::
    db $04 ; entry 0: object count
    db $85, $00, $6d, $00, $00, $70, $20, $05, $00, $50, $0b ; object 0
    db $86, $00, $55, $01, $00, $20, $e0, $06, $00, $60, $00 ; object 1
    db $87, $00, $63, $00, $00, $b0, $40, $07, $01, $70, $01 ; object 2
    db $83, $00, $75, $00, $00, $c0, $40, $03, $00, $30, $02 ; object 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map71_1::
    objsel_list MapObjects_Map71_1_0

MapObjects_Map71_1_0::
    db $04 ; entry 0: object count
    db $85, $00, $47, $00, $00, $50, $70, $05, $00, $50, $00 ; object 0
    db $86, $00, $63, $00, $00, $10, $60, $06, $01, $60, $01 ; object 1
    db $87, $00, $75, $00, $00, $70, $20, $07, $00, $70, $02 ; object 2
    db $86, $00, $63, $00, $00, $30, $30, $06, $00, $60, $03 ; object 3

ObjSelector_Map71_2::
    objsel_list MapObjects_Map71_2_0

; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map71_2_0::
    db $03 ; entry 0: object count
    db $85, $00, $6a, $00, $02, $30, $40, $05, $01, $50, $05 ; object 0
    db $86, $00, $51, $00, $00, $20, $60, $06, $02, $60, $04 ; object 1
    db $87, $00, $6a, $00, $00, $50, $30, $07, $00, $70, $06 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map72::
    dw ObjSelector_Map72_0 ; id 0

ObjSelector_Map72_0::
    objsel_list MapObjects_Map72_0_0

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map72_0_0::
    db $01 ; entry 0
    db $85, $00, $77, $00, $00, $30, $10, $05, $00, $50, $00

MapObjectScreens_Map76::
    dw ObjSelector_Map76_0 ; id 0
    dw $0000 ; id 1
    dw $0000 ; id 2
    dw $0000 ; id 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map76_0::
    objsel_unless_flag EVENT_SCENE_MADCONDOR, MapObjects_Map76_0_0
    objsel_none

; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map76_0_0::
    db $02 ; entry 0: object count
    db $85, $00, $79, $00, $00, $6e, $ec, $05, $00, $50, $00 ; object 0
    db $86, $01, $5a, $00, $00, $40, $50, $06, $00, $60, $00 ; object 1

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map77::
    dw $0000 ; id 0
    dw $0000 ; id 1
    dw ObjSelector_Map77_2 ; id 2

ObjSelector_Map77_2::
    objsel_unless_flag EVENT_HM_YOURE_FROM_THE_VILLAGE, MapObjects_Map77_2_0
    objsel_list MapObjects_Map77_2_1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map77_2_0::
    db $01 ; entry 0
    db $85, $00, $61, $00, $00, $40, $20, $05, $00, $50, $16

MapObjects_Map77_2_1::
    db $01 ; entry 0
    db $85, $00, $61, $00, $00, $50, $20, $05, $03, $50, $16

MapObjectScreens_Map78::
    dw ObjSelector_Map78_0 ; id 0
    dw ObjSelector_Map78_1 ; id 1
    dw ObjSelector_Map78_2 ; id 2
    dw ObjSelector_Map78_3 ; id 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map78_0::
    objsel_list MapObjects_Map78_0_0

; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map78_0_0::
    db $03 ; entry 0: object count
    db $85, $00, $53, $00, $00, $10, $70, $05, $01, $50, $1c ; object 0
    db $86, $00, $19, $01, $00, $10, $30, $06, $00, $60, $1b ; object 1
    db $87, $00, $06, $00, $00, $40, $40, $07, $00, $70, $1d ; object 2

ObjSelector_Map78_1::
    objsel_list MapObjects_Map78_1_0

MapObjects_Map78_1_0::
    db $03 ; entry 0: object count
    db $85, $00, $5c, $00, $00, $50, $60, $05, $03, $50, $1e ; object 0
    db $86, $00, $2b, $00, $00, $30, $40, $06, $00, $60, $1f ; object 1
    db $87, $00, $6c, $00, $00, $20, $70, $07, $03, $70, $20 ; object 2

ObjSelector_Map78_2::
    objsel_list MapObjects_Map78_2_0

; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map78_2_0::
    db $04 ; entry 0: object count
    db $85, $00, $48, $00, $00, $50, $40, $05, $00, $50, $17 ; object 0
    db $85, $00, $48, $00, $00, $80, $70, $05, $03, $50, $1a ; object 1
    db $86, $00, $56, $00, $00, $70, $20, $06, $00, $60, $23 ; object 2
    db $87, $00, $6d, $00, $00, $10, $30, $07, $01, $70, $24 ; object 3

ObjSelector_Map78_3::
    objsel_list MapObjects_Map78_3_0

; an object list of LoadMapObjectsForScreen (E-0163)
MapObjects_Map78_3_0::
    db $04 ; entry 0: object count
    db $85, $00, $5f, $00, $00, $10, $20, $05, $00, $50, $21 ; object 0
    db $86, $00, $80, $00, $02, $10, $60, $06, $03, $60, $22 ; object 1
    db $87, $00, $47, $00, $00, $40, $70, $07, $02, $70, $19 ; object 2
    db $84, $00, $49, $00, $00, $70, $30, $04, $00, $40, $18 ; object 3

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map79::
    dw ObjSelector_Map79_0 ; id 0
    dw ObjSelector_Map79_1 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map79_0::
    objsel_list MapObjects_Map79_0_0

; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map79_0_0::
    db $01 ; entry 0
    db $85, $00, $0c, $00, $00, $50, $60, $05, $00, $50, $6b

ObjSelector_Map79_1::
    objsel_list MapObjects_Map79_1_0

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map79_1_0::
    db $03 ; entry 0: object count
    db $85, $00, $53, $00, $00, $70, $10, $05, $00, $50, $00 ; object 0
    db $86, $00, $5d, $00, $00, $30, $20, $06, $03, $60, $6c ; object 1
    db $87, $00, $4e, $00, $00, $20, $30, $07, $02, $70, $6d ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map7A::
    dw ObjSelector_Map7A_0 ; id 0
    dw ObjSelector_Map7A_1 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map7A_0::
    objsel_skip_if_clear EVENT_MAP_7A_OBJECT_ADDED, $04, $00
    objsel_list MapObjects_Map7A_0_1

ObjSelector_Map7A_0_Unlisted::
    objsel_unless_flag EVENT_SCENE_MADCONDOR_CRY, MapObjects_Map7A_0_Unlisted_0
    objsel_list MapObjects_Map7A_0_Unlisted_1

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_Map7A_0_Unlisted_0::
    db $03 ; entry 0: object count
    db $85, $00, $1f, $01, $00, $50, $40, $05, $00, $50, $2a ; object 0
    db $86, $01, $5e, $00, $00, $40, $60, $06, $02, $60, $6a ; object 1
    db $87, $00, $79, $00, $00, $40, $20, $07, $00, $70, $5d ; object 2

; record: count, then 2 object(s), the layout of the other object lists
MapObjects_Map7A_0_Unlisted_1::
    db $02 ; entry 0: object count
    db $85, $00, $1f, $01, $00, $50, $40, $05, $00, $50, $2a ; object 0
    db $86, $01, $5e, $00, $00, $40, $60, $06, $02, $60, $6a ; object 1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map7A_0_1::
    db $01 ; entry 0
    db $85, $00, $1f, $01, $00, $50, $40, $05, $00, $50, $2a

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map7A_1::
    objsel_list MapObjects_Map7A_1_0

MapObjects_Map7A_1_0::
    db $01 ; entry 0
    db $85, $00, $79, $00, $00, $00, $e0, $05, $00, $50, $00

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map7C::
    dw ObjSelector_Map7C_0 ; id 0
    dw ObjSelector_Map7C_1 ; id 1
    dw ObjSelector_Map7C_2 ; id 2
    dw ObjSelector_Map7C_3 ; id 3

ObjSelector_Map7C_0::
    objsel_skip_if_clear EVENT_WHAT_YOU_HAVE_THE_THREE, $04, $00
    objsel_list MapObjects_Map7C_0_1

ObjSelector_Map7C_0_Unlisted::
    objsel_unless_flag EVENT_SCENE_MADCONDOR_CRY, MapObjects_Map7C_0_Unlisted_0
    objsel_list MapObjects_Map7C_0_Unlisted_1

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_Map7C_0_Unlisted_0::
    db $02 ; entry 0: object count
    db $85, $00, $59, $00, $00, $40, $50, $05, $00, $50, $34 ; object 0
    db $86, $00, $59, $00, $00, $50, $50, $06, $00, $60, $35 ; object 1

; record: count, then 3 object(s), the layout of the other object lists
MapObjects_Map7C_0_Unlisted_1::
    db $03 ; entry 0: object count
    db $85, $00, $59, $00, $00, $40, $50, $05, $00, $50, $34 ; object 0
    db $86, $00, $59, $00, $00, $50, $50, $06, $00, $60, $35 ; object 1
    db $87, $00, $58, $00, $00, $20, $70, $07, $02, $70, $36 ; object 2

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map7C_0_1::
    db $02 ; entry 0: object count
    db $85, $00, $59, $00, $00, $60, $60, $05, $00, $50, $35 ; object 0
    db $86, $00, $58, $00, $00, $20, $70, $06, $01, $60, $36 ; object 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map7C_1::
    objsel_list MapObjects_Map7C_1_0

; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map7C_1_0::
    db $04 ; entry 0: object count
    db $85, $00, $54, $00, $00, $10, $30, $05, $00, $50, $38 ; object 0
    db $86, $00, $03, $00, $02, $40, $60, $06, $01, $60, $39 ; object 1
    db $85, $00, $54, $00, $00, $80, $40, $05, $03, $50, $3a ; object 2
    db $87, $00, $58, $00, $00, $50, $10, $07, $00, $70, $3b ; object 3

ObjSelector_Map7C_2::
    objsel_list MapObjects_Map7C_2_0

MapObjects_Map7C_2_0::
    db $04 ; entry 0: object count
    db $85, $00, $63, $00, $02, $50, $60, $05, $01, $50, $30 ; object 0
    db $86, $00, $55, $00, $00, $20, $40, $06, $01, $60, $31 ; object 1
    db $87, $00, $62, $00, $00, $70, $10, $07, $00, $70, $32 ; object 2
    db $87, $00, $62, $00, $00, $70, $20, $07, $02, $70, $33 ; object 3

ObjSelector_Map7C_3::
    objsel_unless_flag EVENT_SCENE_MADCONDOR_CRY, MapObjects_Map7C_3_0
    objsel_list MapObjects_Map7C_3_1

; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map7C_3_0::
    db $03 ; entry 0: object count
    db $85, $00, $4e, $00, $00, $30, $70, $05, $00, $50, $2d ; object 0
    db $86, $00, $4d, $00, $02, $70, $10, $06, $03, $60, $2e ; object 1
    db $87, $00, $9b, $00, $00, $80, $40, $07, $02, $70, $2f ; object 2

; an object list of LoadMapObjectsForScreen (E-0163)
MapObjects_Map7C_3_1::
    db $04 ; entry 0: object count
    db $85, $00, $4e, $00, $00, $30, $70, $05, $00, $50, $2d ; object 0
    db $86, $00, $4d, $00, $02, $70, $10, $06, $03, $60, $2e ; object 1
    db $87, $00, $9b, $00, $00, $80, $40, $07, $02, $70, $2f ; object 2
    db $84, $00, $57, $00, $00, $30, $50, $04, $00, $40, $37 ; object 3

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map7D::
    dw ObjSelector_Map7D_0 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map7D_0::
    objsel_unless_flag EVENT_SCENE_MADCONDOR_CRY, MapObjects_Map7D_0_0
    objsel_list MapObjects_Map7D_0_1

; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map7D_0_0::
    db $01 ; entry 0
    db $85, $00, $56, $00, $00, $10, $10, $05, $01, $50, $3d

; an object list of LoadMapObjectsForScreen (E-0163)
MapObjects_Map7D_0_1::
    db $01 ; entry 0
    db $85, $00, $56, $00, $00, $10, $10, $05, $01, $50, $3f

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map7E::
    dw ObjSelector_Map7E_0 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map7E_0::
    objsel_unless_flag EVENT_SCENE_MADCONDOR_CRY, MapObjects_Map7E_0_0
    objsel_list MapObjects_Map7E_0_1

; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map7E_0_0::
    db $01 ; entry 0
    db $85, $00, $80, $00, $00, $30, $10, $05, $00, $50, $43

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map7E_0_1::
    db $04 ; entry 0: object count
    db $85, $00, $80, $00, $00, $30, $10, $05, $00, $50, $43 ; object 0
    db $86, $00, $5a, $00, $00, $40, $40, $06, $02, $60, $44 ; object 1
    db $87, $00, $76, $00, $00, $50, $50, $07, $00, $70, $45 ; object 2
    db $87, $00, $76, $00, $00, $50, $70, $07, $02, $70, $46 ; object 3

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map7F::
    dw ObjSelector_Map7F_0 ; id 0
    dw ObjSelector_Map7F_1 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map7F_0::
    objsel_unless_flag EVENT_SCENE_FOUND_ME, MapObjects_Map7F_0_0
    objsel_list MapObjects_Map7F_0_1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map7F_0_0::
    db $01 ; entry 0
    db $85, $00, $61, $00, $00, $50, $40, $05, $00, $50, $5a

MapObjects_Map7F_0_1::
    db $01 ; entry 0
    db $85, $00, $61, $00, $00, $40, $40, $05, $00, $50, $5a

ObjSelector_Map7F_1::
    objsel_unless_flag EVENT_SCENE_THREE_ITEMS_0C2, MapObjects_Map7F_1_0
    objsel_list MapObjects_Map7F_1_1

; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map7F_1_0::
    db $03 ; entry 0: object count
    db $85, $00, $5a, $00, $00, $30, $30, $05, $01, $50, $57 ; object 0
    db $86, $00, $59, $00, $00, $70, $50, $06, $00, $60, $58 ; object 1
    db $87, $00, $57, $00, $00, $70, $70, $07, $02, $70, $59 ; object 2

MapObjects_Map7F_1_1::
    db $01 ; entry 0
    db $85, $00, $5a, $00, $00, $30, $30, $05, $01, $50, $57

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map84::
    dw ObjSelector_Map84_0 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map84_0::
    objsel_unless_flag EVENT_HEH_YOU, MapObjects_Map84_0_0
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map84_0_0::
    db $01 ; entry 0
    db $85, $00, $12, $00, $00, $40, $30, $05, $00, $50, $4a

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map89::
    dw ObjSelector_Map89_0 ; id 0
    dw $0000 ; id 1
    dw ObjSelector_Map89_2 ; id 2
    dw ObjSelector_Map89_3 ; id 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map89_0::
    objsel_list MapObjects_Map89_0_0

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map89_0_0::
    db $01 ; entry 0
    db $85, $00, $5e, $00, $00, $80, $60, $05, $02, $50, $0a

ObjSelector_Map89_2::
    objsel_list MapObjects_Map89_2_0

; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map89_2_0::
    db $02 ; entry 0: object count
    db $85, $00, $5d, $00, $00, $60, $60, $05, $00, $50, $09 ; object 0
    db $86, $00, $55, $00, $00, $10, $50, $06, $00, $60, $07 ; object 1

ObjSelector_Map89_3::
    objsel_list MapObjects_Map89_3_0

MapObjects_Map89_3_0::
    db $01 ; entry 0
    db $85, $00, $50, $00, $00, $40, $60, $05, $02, $50, $08

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map8C::
    dw ObjSelector_Map8C_0 ; id 0
    dw $0000 ; id 1
    dw $0000 ; id 2
    dw $0000 ; id 3
    dw $0000 ; id 4
    dw $0000 ; id 5
    dw $0000 ; id 6
    dw $0000 ; id 7
    dw $0000 ; id 8

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map8C_0::
    objsel_unless_flag EVENT_SCENE_BEATEN_FAIRLY_0C5, MapObjects_Map8C_0_0
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map8C_0_0::
    db $01 ; entry 0
    db $85, $00, $0a, $01, $00, $20, $20, $05, $00, $50, $4c

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map8E::
    dw ObjSelector_Map8E_0 ; id 0
    dw ObjSelector_Map8E_1 ; id 1
    dw ObjSelector_Map8E_2 ; id 2
    dw ObjSelector_Map8E_3 ; id 3
    dw ObjSelector_Map8E_4 ; id 4
    dw ObjSelector_Map8E_5 ; id 5
    dw $0000 ; id 6
    dw $0000 ; id 7
    dw $0000 ; id 8

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map8E_0::
    objsel_list MapObjects_Map8E_0_0

ObjSelector_Map8E_0_Unlisted::
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map8E_0_0::
    db $03 ; entry 0: object count
    db $85, $01, $44, $00, $00, $30, $30, $05, $00, $50, $69 ; object 0
    db $86, $01, $44, $00, $00, $60, $40, $06, $00, $60, $69 ; object 1
    db $87, $01, $44, $00, $00, $80, $20, $07, $01, $70, $69 ; object 2

ObjSelector_Map8E_1::
    objsel_list MapObjects_Map8E_1_0

; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map8E_1_0::
    db $01 ; entry 0
    db $85, $01, $44, $00, $00, $30, $50, $05, $00, $50, $69

ObjSelector_Map8E_2::
    objsel_list MapObjects_Map8E_2_0

MapObjects_Map8E_2_0::
    db $03 ; entry 0: object count
    db $85, $01, $44, $00, $00, $10, $30, $05, $03, $50, $69 ; object 0
    db $86, $01, $44, $00, $00, $20, $50, $06, $01, $60, $69 ; object 1
    db $87, $01, $44, $00, $00, $30, $60, $07, $00, $70, $69 ; object 2

ObjSelector_Map8E_3::
    objsel_list MapObjects_Map8E_3_0

MapObjects_Map8E_3_0::
    db $03 ; entry 0: object count
    db $85, $01, $44, $00, $00, $30, $70, $05, $01, $50, $69 ; object 0
    db $86, $01, $44, $00, $00, $50, $30, $06, $03, $60, $69 ; object 1
    db $87, $01, $44, $00, $00, $80, $40, $07, $02, $70, $69 ; object 2

ObjSelector_Map8E_4::
    objsel_list MapObjects_Map8E_4_0

MapObjects_Map8E_4_0::
    db $01 ; entry 0
    db $85, $01, $44, $00, $00, $30, $30, $05, $01, $50, $69

ObjSelector_Map8E_5::
    objsel_list MapObjects_Map8E_5_0

MapObjects_Map8E_5_0::
    db $03 ; entry 0: object count
    db $85, $01, $44, $00, $00, $10, $30, $05, $02, $50, $69 ; object 0
    db $86, $01, $44, $00, $00, $20, $70, $06, $02, $60, $69 ; object 1
    db $87, $01, $44, $00, $00, $30, $40, $07, $01, $70, $69 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map8F::
    dw ObjSelector_Map8F_0 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map8F_0::
    objsel_unless_flag EVENT_SCENE_GRAVESTONE, MapObjects_Map8F_0_0
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map8F_0_0::
    db $01 ; entry 0
    db $85, $00, $f6, $00, $00, $40, $40, $05, $00, $50, $4f

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map90::
    dw ObjSelector_Map90_0 ; id 0
    dw ObjSelector_Map90_1 ; id 1
    dw $0000 ; id 2
    dw $0000 ; id 3
    dw $0000 ; id 4
    dw $0000 ; id 5

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map90_0::
    objsel_unless_flag EVENT_SCENE_BEATEN_FAIRLY_0C6, MapObjects_Map90_0_0
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map90_0_0::
    db $01 ; entry 0
    db $85, $00, $0a, $01, $00, $50, $20, $05, $00, $50, $6e

ObjSelector_Map90_1::
    objsel_unless_flag EVENT_SCENE_BEATEN_FAIRLY_0C7, MapObjects_Map90_1_0
    objsel_none

MapObjects_Map90_1_0::
    db $01 ; entry 0
    db $85, $00, $0a, $01, $00, $80, $50, $05, $03, $50, $6f

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map91::
    dw ObjSelector_Map91_0 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map91_0::
    objsel_unless_flag EVENT_SCENE_BEATEN_FAIRLY, MapObjects_Map91_0_0
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map91_0_0::
    db $01 ; entry 0
    db $85, $00, $10, $01, $00, $40, $30, $05, $00, $50, $55

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map94::
    dw $0000 ; id 0
    dw $0000 ; id 1
    dw $0000 ; id 2
    dw ObjSelector_Map94_3 ; id 3
    dw ObjSelector_Map94_4 ; id 4
    dw ObjSelector_Map94_5 ; id 5
    dw $0000 ; id 6
    dw ObjSelector_Map94_7 ; id 7
    dw ObjSelector_Map94_8 ; id 8

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map94_3::
    objsel_skip_if_clear EVENT_SCENE_THREE_ITEMS, $02, $00
    objsel_none

ObjSelector_Map94_3_Unlisted::
    objsel_unless_flag EVENT_FOUND_ME_FOE_SCREEN0, MapObjects_Map94_3_Unlisted_0
    objsel_none

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_Map94_3_Unlisted_0::
    db $01 ; entry 0
    db $85, $00, $ec, $00, $00, $40, $20, $05, $00, $50, $5c

ObjSelector_Map94_4::
    objsel_skip_if_clear EVENT_SCENE_THREE_ITEMS, $02, $00
    objsel_none

ObjSelector_Map94_4_Unlisted::
    objsel_unless_flag EVENT_FOUND_ME_FOE_SCREEN1, MapObjects_Map94_4_Unlisted_0
    objsel_none

MapObjects_Map94_4_Unlisted_0::
    db $01 ; entry 0
    db $85, $00, $ec, $00, $00, $40, $20, $05, $00, $50, $5c

ObjSelector_Map94_5::
    objsel_skip_if_clear EVENT_SCENE_THREE_ITEMS, $02, $00
    objsel_none

ObjSelector_Map94_5_Unlisted::
    objsel_unless_flag EVENT_FOUND_ME_FOE_SCREEN2, MapObjects_Map94_5_Unlisted_0
    objsel_none

MapObjects_Map94_5_Unlisted_0::
    db $01 ; entry 0
    db $85, $00, $ec, $00, $00, $40, $20, $05, $00, $50, $5c

ObjSelector_Map94_7::
    objsel_unless_flag EVENT_SCENE_THREE_ITEMS, MapObjects_Map94_7_0
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map94_7_0::
    db $01 ; entry 0
    db $85, $00, $d6, $00, $00, $40, $20, $05, $00, $50, $5f

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map94_8::
    objsel_unless_flag EVENT_SCENE_THREE_ITEMS, MapObjects_Map94_8_0
    objsel_none

MapObjects_Map94_8_0::
    db $01 ; entry 0
    db $85, $00, $d6, $00, $00, $30, $40, $05, $03, $50, $60

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map95::
    dw $0000 ; id 0
    dw $0000 ; id 1
    dw $0000 ; id 2
    dw $0000 ; id 3
    dw $0000 ; id 4
    dw ObjSelector_Map95_5 ; id 5

ObjSelector_Map95_5::
    objsel_unless_flag EVENT_SCENE_THREE_ITEMS, MapObjects_Map95_5_0
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map95_5_0::
    db $01 ; entry 0
    db $85, $00, $d6, $00, $00, $80, $40, $05, $00, $50, $61

MapObjectScreens_Map96::
    dw $0000 ; id 0
    dw ObjSelector_Map96_1 ; id 1
    dw $0000 ; id 2
    dw $0000 ; id 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map96_1::
    objsel_skip_if_clear EVENT_SCENE_THREE_ITEMS, $02, $00
    objsel_none

ObjSelector_Map96_1_Unlisted::
    objsel_unless_flag EVENT_FOUND_ME_FOE_MAP96, MapObjects_Map96_1_Unlisted_0
    objsel_none

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_Map96_1_Unlisted_0::
    db $01 ; entry 0
    db $85, $00, $ec, $00, $00, $10, $40, $05, $01, $50, $5c

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map9B::
    dw ObjSelector_Map9B_0 ; id 0
    dw ObjSelector_Map9B_1 ; id 1
    dw $0000 ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map9B_0::
    objsel_skip_if_clear EVENT_SCENE_THREE_ITEMS_0C3, $02, $00
    objsel_none

ObjSelector_Map9B_0_Unlisted::
    objsel_unless_flag EVENT_SCENE_THREE_ITEMS_0C2, MapObjects_Map9B_0_Unlisted_0
    objsel_list MapObjects_Map9B_0_Unlisted_1

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_Map9B_0_Unlisted_0::
    db $02 ; entry 0: object count
    db $85, $01, $03, $00, $00, $40, $20, $05, $00, $50, $5c ; object 0
    db $86, $01, $48, $00, $05, $48, $c0, $06, $00, $60, $00 ; object 1

; record: count, then 1 object(s), the layout of the other object lists
MapObjects_Map9B_0_Unlisted_1::
    db $01 ; entry 0
    db $85, $01, $03, $00, $00, $50, $30, $05, $02, $50, $5c

ObjSelector_Map9B_1::
    objsel_unless_flag EVENT_SCENE_THREE_ITEMS_BATTLE, MapObjects_Map9B_1_0
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map9B_1_0::
    db $01 ; entry 0
    db $85, $01, $54, $00, $04, $48, $20, $05, $00, $50, $67

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map49::
    dw ObjSelector_Map49_0 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map49_0::
    objsel_skip_if_set EVENT_THANKS_FOR_COMING_BY_025, $0a, $00
    objsel_skip_if_clear EVENT_SCENE_DARCK_DEFEATED, $04, $00
    objsel_list MapObjects_Map49_0_2

ObjSelector_Map49_0_Unlisted::
    objsel_skip_if_clear EVENT_SCENE_SHIELD2_1E5, $02, $00
    objsel_none

ObjSelector_Map49_0_Unlisted_2::
    objsel_skip_if_clear EVENT_SCENE_SHIELD_1E4, $04, $00
    objsel_list MapObjects_Map49_0_Unlisted_2_1

ObjSelector_Map49_0_Unlisted_3::
    objsel_skip_if_clear EVENT_HERO_CHECKED_THE_TREASURE_CHEST, $08, $00
    objsel_unless_flag EVENT_SCENE_SHIELD, MapObjects_Map49_0_Unlisted_2_1
    objsel_list MapObjects_Map49_0_Unlisted_3_2

ObjSelector_Map49_0_Unlisted_4::
    objsel_unless_flag EVENT_BLINK_SPRITES, MapObjects_Map49_0_Unlisted_4_0
    objsel_list MapObjects_Map49_0_Unlisted_4_1

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_Map49_0_Unlisted_4_0::
    db $02 ; entry 0: object count
    db $85, $01, $5b, $00, $00, $40, $30, $05, $00, $50, $14 ; object 0
    db $86, $01, $5a, $00, $00, $60, $e0, $06, $00, $60, $a0 ; object 1

MapObjects_Map49_0_Unlisted_4_1::
    db $02 ; entry 0: object count
    db $85, $01, $5b, $00, $00, $40, $30, $05, $00, $50, $14 ; object 0
    db $86, $01, $5a, $00, $00, $60, $70, $06, $00, $60, $a0 ; object 1

; record: count, then 3 object(s), the layout of the other object lists
MapObjects_Map49_0_Unlisted_2_1::
    db $03 ; entry 0: object count
    db $85, $01, $5b, $00, $00, $40, $30, $05, $00, $50, $14 ; object 0
    db $86, $01, $5c, $00, $00, $40, $e0, $06, $00, $60, $9f ; object 1
    db $87, $01, $53, $00, $00, $40, $e0, $07, $00, $70, $00 ; object 2

MapObjects_Map49_0_Unlisted_3_2::
    db $03 ; entry 0: object count
    db $85, $01, $5b, $00, $00, $40, $30, $05, $00, $50, $14 ; object 0
    db $86, $01, $5c, $00, $00, $40, $40, $06, $00, $60, $9f ; object 1
    db $87, $01, $53, $00, $00, $40, $e0, $07, $00, $70, $00 ; object 2

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 5 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map49_0_2::
    db $05 ; entry 0: object count
    db $85, $01, $53, $00, $00, $40, $e0, $05, $00, $50, $00 ; object 0
    db $86, $01, $3a, $00, $00, $40, $50, $06, $02, $60, $72 ; object 1
    db $87, $01, $42, $00, $00, $50, $70, $07, $03, $70, $2e ; object 2
    db $83, $01, $52, $00, $00, $30, $b0, $03, $02, $30, $61 ; object 3
    db $83, $01, $52, $00, $00, $50, $b0, $03, $02, $30, $61 ; object 4

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map4A::
    dw ObjSelector_Map4A_0 ; id 0
    dw ObjSelector_Map4A_1 ; id 1
    dw ObjSelector_Map4A_2 ; id 2
    dw ObjSelector_Map4A_3 ; id 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map4A_0::
    objsel_unless_flag EVENT_WHAT_IS_THAT_DIRTY_MEDAL, MapObjects_Map4A_0_0
    objsel_list MapObjects_Map4A_0_1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map4A_0_0::
    db $04 ; entry 0: object count
    db $85, $01, $10, $00, $00, $40, $10, $05, $00, $50, $0b ; object 0
    db $85, $01, $10, $00, $00, $50, $10, $05, $00, $50, $0c ; object 1
    db $86, $01, $2f, $00, $00, $10, $40, $06, $01, $60, $09 ; object 2
    db $87, $01, $30, $00, $00, $70, $70, $07, $02, $70, $0a ; object 3

MapObjects_Map4A_0_1::
    db $04 ; entry 0: object count
    db $85, $01, $10, $00, $00, $30, $20, $05, $00, $50, $0b ; object 0
    db $85, $01, $10, $00, $02, $60, $30, $05, $00, $50, $0c ; object 1
    db $86, $01, $2f, $00, $00, $10, $40, $06, $01, $60, $09 ; object 2
    db $87, $01, $30, $00, $00, $70, $70, $07, $02, $70, $0a ; object 3

ObjSelector_Map4A_1::
    objsel_list MapObjects_Map4A_1_0

; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map4A_1_0::
    db $03 ; entry 0: object count
    db $85, $01, $2e, $00, $00, $60, $70, $05, $03, $50, $05 ; object 0
    db $86, $01, $2d, $00, $02, $40, $50, $06, $01, $60, $06 ; object 1
    db $87, $01, $12, $00, $00, $20, $30, $07, $00, $70, $82 ; object 2

ObjSelector_Map4A_2::
    objsel_list MapObjects_Map4A_2_0

MapObjects_Map4A_2_0::
    db $04 ; entry 0: object count
    db $85, $01, $10, $00, $00, $60, $60, $05, $00, $50, $00 ; object 0
    db $86, $01, $2e, $00, $00, $80, $50, $06, $02, $60, $01 ; object 1
    db $87, $01, $30, $00, $00, $10, $40, $07, $01, $70, $02 ; object 2
    db $86, $01, $2e, $00, $00, $20, $10, $06, $00, $60, $03 ; object 3

ObjSelector_Map4A_3::
    objsel_list MapObjects_Map4A_3_0

MapObjects_Map4A_3_0::
    db $04 ; entry 0: object count
    db $85, $01, $2f, $00, $02, $50, $50, $05, $01, $50, $04 ; object 0
    db $85, $01, $2f, $00, $00, $30, $40, $05, $03, $50, $07 ; object 1
    db $86, $01, $12, $00, $00, $80, $60, $06, $03, $60, $08 ; object 2
    db $87, $01, $15, $00, $00, $70, $20, $07, $00, $70, $0d ; object 3

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map4B::
    dw ObjSelector_Map4B_0 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map4B_0::
    objsel_unless_flag EVENT_SCENE_PLAN_RUINED_094, MapObjects_Map4B_0_0
    objsel_list MapObjects_Map4B_0_1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map4B_0_0::
    db $02 ; entry 0: object count
    db $85, $01, $2e, $00, $00, $60, $20, $05, $01, $50, $12 ; object 0
    db $86, $01, $15, $00, $00, $20, $50, $06, $01, $60, $13 ; object 1

; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map4B_0_1::
    db $01 ; entry 0
    db $85, $01, $2e, $00, $00, $60, $20, $05, $01, $50, $12

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map4C::
    dw ObjSelector_Map4C_0 ; id 0
    dw ObjSelector_Map4C_1 ; id 1
    dw ObjSelector_Map4C_2 ; id 2
    dw ObjSelector_Map4C_3 ; id 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map4C_0::
    objsel_skip_if_clear EVENT_SCENE_PLAN_RUINED_094, $04, $00
    objsel_list MapObjects_Map4C_0_1

ObjSelector_Map4C_0_Unlisted::
    objsel_skip_if_clear EVENT_SCENE_PLAN_RUINED, $04, $00
    objsel_list MapObjects_Map4C_0_Unlisted_1

ObjSelector_Map4C_0_Unlisted_2::
    objsel_unless_flag EVENT_SCENE_WALL_EXIT, MapObjects_Map4C_0_Unlisted_2_0
    objsel_list MapObjects_Map4C_0_Unlisted_2_1

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_Map4C_0_Unlisted_2_0::
    db $02 ; entry 0: object count
    db $85, $01, $0e, $00, $00, $40, $30, $05, $00, $50, $00 ; object 0
    db $86, $01, $10, $00, $00, $40, $70, $06, $02, $60, $18 ; object 1

; record: count, then 3 object(s), the layout of the other object lists
MapObjects_Map4C_0_Unlisted_2_1::
    db $03 ; entry 0: object count
    db $85, $00, $d5, $00, $00, $40, $e0, $05, $02, $50, $4d ; object 0
    db $86, $01, $0e, $00, $00, $40, $50, $06, $02, $60, $48 ; object 1
    db $87, $01, $0e, $00, $00, $40, $40, $07, $00, $70, $4d ; object 2

MapObjects_Map4C_0_Unlisted_1::
    db $02 ; entry 0: object count
    db $85, $00, $d5, $00, $00, $40, $40, $05, $00, $50, $4d ; object 0
    db $86, $01, $0e, $00, $00, $40, $50, $06, $02, $60, $48 ; object 1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map4C_0_1::
    db $02 ; entry 0: object count
    db $85, $01, $0e, $00, $00, $40, $30, $05, $00, $50, $48 ; object 0
    db $86, $01, $0e, $00, $00, $e0, $e0, $06, $00, $60, $00 ; object 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map4C_1::
    objsel_list MapObjects_Map4C_1_0

; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map4C_1_0::
    db $01 ; entry 0
    db $85, $01, $12, $00, $00, $20, $20, $05, $02, $50, $17

ObjSelector_Map4C_2::
    objsel_skip_if_clear EVENT_SCENE_REPORT_TO_KING, $04, $00
    objsel_list MapObjects_Map4C_2_1

ObjSelector_Map4C_2_Unlisted::
    objsel_skip_if_clear EVENT_SCENE_SPIRIT_ENVOY, $04, $00
    objsel_list MapObjects_Map4C_2_Unlisted_1

ObjSelector_Map4C_2_Unlisted_2::
    objsel_unless_flag EVENT_AH_YOU_ARE_THE_SPIRIT, MapObjects_Map4C_2_Unlisted_1
    objsel_list MapObjects_Map4C_2_Unlisted_2_1

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_Map4C_2_Unlisted_1::
    db $02 ; entry 0: object count
    db $85, $01, $10, $00, $00, $50, $00, $05, $00, $50, $15 ; object 0
    db $86, $01, $10, $00, $00, $40, $00, $06, $00, $60, $18 ; object 1

MapObjects_Map4C_2_Unlisted_2_1::
    db $02 ; entry 0: object count
    db $85, $01, $10, $00, $00, $50, $00, $05, $00, $50, $15 ; object 0
    db $86, $01, $10, $00, $00, $40, $e0, $06, $00, $60, $18 ; object 1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map4C_2_1::
    db $02 ; entry 0: object count
    db $85, $01, $10, $00, $00, $60, $20, $05, $00, $50, $15 ; object 0
    db $86, $01, $10, $00, $00, $30, $30, $06, $00, $60, $18 ; object 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map4C_3::
    objsel_list MapObjects_Map4C_3_0

; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map4C_3_0::
    db $01 ; entry 0
    db $85, $01, $10, $00, $00, $80, $30, $05, $00, $50, $16

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map4D::
    dw $0000 ; id 0
    dw ObjSelector_Map4D_1 ; id 1

ObjSelector_Map4D_1::
    objsel_unless_flag EVENT_SCENE_WALL_EXIT, MapObjects_Map4D_1_0
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map4D_1_0::
    db $02 ; entry 0: object count
    db $85, $01, $0e, $00, $00, $70, $30, $05, $00, $50, $48 ; object 0
    db $86, $01, $03, $00, $00, $30, $50, $06, $03, $60, $49 ; object 1

MapObjectScreens_Map4E::
    dw ObjSelector_Map4E_0 ; id 0
    dw $0000 ; id 1
    dw $0000 ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map4E_0::
    objsel_list MapObjects_Map4E_0_0

; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map4E_0_0::
    db $01 ; entry 0
    db $85, $01, $2e, $00, $00, $50, $30, $05, $00, $50, $1c

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map4F::
    dw ObjSelector_Map4F_0 ; id 0
    dw ObjSelector_Map4F_1 ; id 1
    dw ObjSelector_Map4F_2 ; id 2
    dw ObjSelector_Map4F_3 ; id 3

ObjSelector_Map4F_0::
    objsel_list MapObjects_Map4F_0_0

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map4F_0_0::
    db $04 ; entry 0: object count
    db $85, $01, $30, $00, $00, $30, $50, $05, $00, $50, $1d ; object 0
    db $85, $01, $30, $00, $00, $50, $40, $05, $00, $50, $1f ; object 1
    db $86, $01, $2f, $00, $02, $70, $60, $06, $01, $60, $20 ; object 2
    db $87, $01, $12, $00, $00, $70, $20, $07, $00, $70, $2c ; object 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map4F_1::
    objsel_unless_flag EVENT_SCENE_SHIELD2_1E5, MapObjects_Map4F_1_0
    objsel_list MapObjects_Map4F_1_1

MapObjects_Map4F_1_0::
    db $04 ; entry 0: object count
    db $85, $01, $16, $00, $00, $10, $30, $05, $01, $50, $29 ; object 0
    db $86, $01, $15, $00, $00, $70, $20, $06, $00, $60, $2a ; object 1
    db $86, $01, $15, $00, $00, $80, $40, $06, $03, $60, $2b ; object 2
    db $87, $01, $29, $00, $00, $70, $50, $07, $01, $70, $28 ; object 3

; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map4F_1_1::
    db $03 ; entry 0: object count
    db $85, $01, $16, $00, $00, $10, $30, $05, $01, $50, $29 ; object 0
    db $86, $01, $15, $00, $00, $70, $20, $06, $00, $60, $2a ; object 1
    db $86, $01, $15, $00, $00, $80, $40, $06, $03, $60, $2b ; object 2

ObjSelector_Map4F_2::
    objsel_list MapObjects_Map4F_2_0

MapObjects_Map4F_2_0::
    db $04 ; entry 0: object count
    db $85, $01, $2e, $00, $00, $10, $20, $05, $00, $50, $21 ; object 0
    db $86, $01, $2d, $00, $02, $40, $50, $06, $01, $60, $22 ; object 1
    db $85, $01, $2e, $00, $00, $60, $60, $05, $00, $50, $23 ; object 2
    db $87, $01, $2f, $00, $00, $70, $10, $07, $03, $70, $24 ; object 3

ObjSelector_Map4F_3::
    objsel_list MapObjects_Map4F_3_0

MapObjects_Map4F_3_0::
    db $04 ; entry 0: object count
    db $85, $01, $2e, $00, $00, $40, $50, $05, $00, $50, $1e ; object 0
    db $86, $01, $30, $00, $00, $80, $20, $06, $03, $60, $25 ; object 1
    db $85, $01, $2e, $00, $00, $20, $30, $05, $00, $50, $26 ; object 2
    db $87, $01, $10, $00, $00, $20, $10, $07, $01, $70, $27 ; object 3

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map50::
    dw ObjSelector_Map50_0 ; id 0

ObjSelector_Map50_0::
    objsel_unless_flag EVENT_SCENE_SHIELD2_1E5, MapObjects_Map50_0_0
    objsel_list MapObjects_Map50_0_1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map50_0_0::
    db $04 ; entry 0: object count
    db $85, $01, $16, $00, $00, $20, $20, $05, $01, $50, $31 ; object 0
    db $85, $01, $16, $00, $00, $40, $30, $05, $02, $50, $32 ; object 1
    db $86, $01, $17, $00, $00, $40, $50, $06, $00, $60, $33 ; object 2
    db $87, $01, $21, $00, $00, $10, $60, $07, $00, $70, $34 ; object 3

; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map50_0_1::
    db $02 ; entry 0: object count
    db $85, $01, $16, $00, $00, $20, $20, $05, $01, $50, $31 ; object 0
    db $86, $01, $17, $00, $00, $40, $50, $06, $00, $60, $33 ; object 1

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map51::
    dw ObjSelector_Map51_0 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map51_0::
    objsel_list MapObjects_Map51_0_0

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map51_0_0::
    db $02 ; entry 0: object count
    db $85, $01, $2e, $00, $00, $10, $10, $05, $01, $50, $36 ; object 0
    db $86, $01, $29, $00, $00, $20, $70, $06, $02, $60, $37 ; object 1

MapObjectScreens_Map52::
    db $99, $55, $00, $00, $b4, $55

ObjSelector_Map51_0_Unlisted::
    objsel_list MapObjects_Map51_0_Unlisted_0

MapObjects_Map51_0_Unlisted_0::
    db $02 ; entry 0: object count
    db $85, $01, $52, $00, $00, $40, $30, $05, $00, $50, $3c ; object 0
    db $86, $01, $52, $00, $00, $70, $40, $06, $03, $60, $3d ; object 1

ObjSelector_Map51_0_Unlisted_2::
    objsel_unless_flag EVENT_SCENE_PLAN_RUINED_094, MapObjects_Map51_0_Unlisted_2_0
    objsel_list MapObjects_Map51_0_Unlisted_2_1

; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map51_0_Unlisted_2_0::
    db $04 ; entry 0: object count
    db $85, $01, $10, $00, $00, $30, $30, $05, $00, $50, $38 ; object 0
    db $85, $01, $10, $00, $00, $00, $40, $05, $01, $50, $39 ; object 1
    db $85, $01, $10, $00, $00, $00, $50, $05, $01, $50, $3a ; object 2
    db $86, $01, $16, $00, $00, $70, $60, $06, $00, $60, $3b ; object 3

MapObjects_Map51_0_Unlisted_2_1::
    db $04 ; entry 0: object count
    db $85, $01, $10, $00, $00, $30, $30, $05, $00, $50, $38 ; object 0
    db $85, $01, $10, $00, $00, $60, $40, $05, $00, $50, $39 ; object 1
    db $85, $01, $10, $00, $00, $60, $50, $05, $02, $50, $3a ; object 2
    db $86, $01, $16, $00, $00, $70, $60, $06, $00, $60, $3b ; object 3

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map53::
    dw $0000 ; id 0
    dw $0000 ; id 1
    dw ObjSelector_Map53_2 ; id 2
    dw $0000 ; id 3
    dw $0000 ; id 4
    dw $0000 ; id 5
    dw $0000 ; id 6
    dw $0000 ; id 7
    dw $0000 ; id 8
    dw $0000 ; id 9
    dw $0000 ; id 10
    dw $0000 ; id 11
    dw ObjSelector_Map53_12 ; id 12
    dw $0000 ; id 13
    dw $0000 ; id 14
    dw $0000 ; id 15

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map53_2::
    objsel_list MapObjects_Map53_2_0

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map53_2_0::
    db $01 ; entry 0
    db $85, $01, $16, $00, $00, $70, $30, $05, $00, $50, $3f

ObjSelector_Map53_12::
    objsel_unless_flag EVENT_SCENE_PLAN_RUINED_094, MapObjects_Map53_12_0
    objsel_list MapObjects_Map53_12_1

; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map53_12_0::
    db $03 ; entry 0: object count
    db $85, $01, $52, $00, $00, $40, $60, $05, $02, $50, $3c ; object 0
    db $86, $01, $52, $00, $00, $50, $60, $06, $02, $60, $3d ; object 1
    db $87, $01, $16, $00, $02, $50, $20, $07, $01, $70, $3e ; object 2

MapObjects_Map53_12_1::
    db $01 ; entry 0
    db $85, $01, $16, $00, $02, $50, $20, $05, $01, $50, $3e

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map54::
    dw ObjSelector_Map54_0 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map54_0::
    objsel_list MapObjects_Map54_0_0

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map54_0_0::
    db $01 ; entry 0
    db $85, $01, $52, $00, $00, $60, $30, $05, $00, $50, $40

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map55::
    dw $0000 ; id 0
    dw ObjSelector_Map55_1 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map55_1::
    objsel_list MapObjects_Map55_1_0

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map55_1_0::
    db $01 ; entry 0
    db $85, $01, $16, $00, $00, $50, $50, $05, $03, $50, $41

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map57::
    dw ObjSelector_Map57_0 ; id 0
    dw ObjSelector_Map57_1 ; id 1
    dw ObjSelector_Map57_2 ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map57_0::
    objsel_unless_flag EVENT_SCENE_GOT_TO, MapObjects_Map57_0_0
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map57_0_0::
    db $01 ; entry 0
    db $85, $01, $16, $00, $02, $60, $10, $05, $01, $50, $44

ObjSelector_Map57_1::
    objsel_skip_if_clear EVENT_SCENE_GOT_TO, $02, $00
    objsel_none

ObjSelector_Map57_1_Unlisted::
    objsel_unless_flag EVENT_SCENE_EXPLOSION, MapObjects_Map57_1_Unlisted_0
    objsel_list MapObjects_Map57_1_Unlisted_1

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_Map57_1_Unlisted_0::
    db $03 ; entry 0: object count
    db $85, $00, $34, $01, $00, $40, $e0, $05, $00, $50, $46 ; object 0
    db $86, $01, $10, $00, $00, $b0, $10, $06, $02, $60, $00 ; object 1
    db $87, $01, $52, $00, $00, $e0, $10, $07, $00, $70, $00 ; object 2

MapObjects_Map57_1_Unlisted_1::
    db $03 ; entry 0: object count
    db $85, $00, $34, $01, $00, $40, $20, $05, $00, $50, $46 ; object 0
    db $86, $01, $10, $00, $00, $b0, $10, $06, $02, $60, $00 ; object 1
    db $87, $01, $52, $00, $00, $e0, $10, $07, $00, $70, $00 ; object 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map57_2::
    objsel_unless_flag EVENT_SCENE_GOT_TO, MapObjects_Map57_2_0
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map57_2_0::
    db $02 ; entry 0: object count
    db $85, $01, $16, $00, $02, $30, $10, $05, $01, $50, $42 ; object 0
    db $86, $01, $10, $00, $00, $70, $30, $06, $02, $60, $43 ; object 1

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map58::
    dw ObjSelector_Map58_0 ; id 0
    dw ObjSelector_Map58_1 ; id 1
    dw ObjSelector_Map58_2 ; id 2
    dw ObjSelector_Map58_3 ; id 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map58_0::
    objsel_list MapObjects_Map58_0_0

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map58_0_0::
    db $04 ; entry 0: object count
    db $85, $01, $52, $00, $00, $60, $40, $05, $00, $50, $56 ; object 0
    db $86, $01, $2e, $00, $00, $30, $70, $06, $03, $60, $57 ; object 1
    db $87, $01, $2f, $00, $00, $30, $10, $07, $00, $70, $58 ; object 2
    db $84, $01, $12, $00, $00, $70, $20, $04, $00, $40, $83 ; object 3

ObjSelector_Map58_1::
    objsel_list MapObjects_Map58_1_0

MapObjects_Map58_1_0::
    db $04 ; entry 0: object count
    db $85, $01, $30, $00, $00, $10, $20, $05, $00, $50, $52 ; object 0
    db $86, $01, $2d, $00, $00, $80, $30, $06, $01, $60, $53 ; object 1
    db $87, $01, $2e, $00, $00, $70, $60, $07, $02, $70, $54 ; object 2
    db $87, $01, $2e, $00, $02, $40, $50, $07, $01, $70, $55 ; object 3

ObjSelector_Map58_2::
    objsel_list MapObjects_Map58_2_0

MapObjects_Map58_2_0::
    db $04 ; entry 0: object count
    db $85, $01, $2f, $00, $00, $40, $40, $05, $00, $50, $4e ; object 0
    db $86, $01, $2e, $00, $00, $10, $60, $06, $01, $60, $4f ; object 1
    db $87, $01, $15, $00, $00, $70, $50, $07, $00, $70, $50 ; object 2
    db $85, $01, $2f, $00, $02, $30, $10, $05, $00, $50, $51 ; object 3

ObjSelector_Map58_3::
    objsel_list MapObjects_Map58_3_0

; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map58_3_0::
    db $02 ; entry 0: object count
    db $85, $01, $2d, $00, $00, $30, $50, $05, $00, $50, $59 ; object 0
    db $86, $01, $30, $00, $02, $60, $40, $06, $01, $60, $5a ; object 1

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map59::
    dw ObjSelector_Map59_0 ; id 0
    dw ObjSelector_Map59_1 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map59_0::
    objsel_list MapObjects_Map59_0_0

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map59_0_0::
    db $02 ; entry 0: object count
    db $85, $01, $2e, $00, $00, $80, $10, $05, $00, $50, $5e ; object 0
    db $86, $01, $15, $00, $00, $60, $10, $06, $00, $60, $5f ; object 1

ObjSelector_Map59_1::
    objsel_list MapObjects_Map59_1_0

; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map59_1_0::
    db $01 ; entry 0
    db $85, $01, $29, $00, $00, $20, $20, $05, $00, $50, $60

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map5A::
    dw ObjSelector_Map5A_0 ; id 0
    dw ObjSelector_Map5A_1 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map5A_0::
    objsel_skip_if_clear EVENT_SCENE_SHIELD2_1E5, $04, $00
    objsel_list MapObjects_Map5A_0_1

ObjSelector_Map5A_0_Unlisted::
    objsel_unless_flag EVENT_SCENE_CHEER_YUNA, MapObjects_Map5A_0_Unlisted_0
    objsel_none

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 4 object(s), the layout of the other object lists
MapObjects_Map5A_0_Unlisted_0::
    db $04 ; entry 0: object count
    db $85, $01, $52, $00, $00, $80, $60, $05, $00, $50, $61 ; object 0
    db $85, $01, $52, $00, $00, $40, $50, $05, $00, $50, $67 ; object 1
    db $86, $01, $15, $00, $02, $20, $70, $06, $01, $60, $63 ; object 2
    db $87, $01, $4c, $00, $00, $60, $80, $07, $02, $70, $65 ; object 3

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map5A_0_1::
    db $01 ; entry 0
    db $87, $01, $42, $00, $00, $30, $50, $07, $00, $70, $2e

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map5A_1::
    objsel_skip_if_clear EVENT_SCENE_CHEER_YUNA, $04, $00
    objsel_list MapObjects_Map5A_1_1

ObjSelector_Map5A_1_Unlisted::
    objsel_unless_flag EVENT_GATHER_FOLLOWERS, MapObjects_Map5A_1_Unlisted_0
    objsel_list MapObjects_Map5A_1_Unlisted_1

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 4 object(s), the layout of the other object lists
MapObjects_Map5A_1_Unlisted_0::
    db $04 ; entry 0: object count
    db $85, $01, $52, $00, $00, $30, $40, $05, $01, $50, $66 ; object 0
    db $86, $01, $4c, $00, $00, $40, $40, $06, $02, $60, $62 ; object 1
    db $86, $01, $4c, $00, $00, $40, $50, $06, $02, $60, $64 ; object 2
    db $87, $01, $03, $00, $00, $40, $a0, $07, $02, $70, $00 ; object 3

; record: count, then 1 object(s), the layout of the other object lists
MapObjects_Map5A_1_Unlisted_1::
    db $01 ; entry 0
    db $85, $01, $52, $00, $00, $30, $50, $05, $00, $50, $66

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map5A_1_1::
    db $03 ; entry 0: object count
    db $85, $01, $52, $00, $00, $20, $50, $05, $00, $50, $66 ; object 0
    db $86, $01, $52, $00, $00, $70, $60, $06, $03, $60, $61 ; object 1
    db $87, $01, $52, $00, $00, $10, $70, $07, $00, $70, $67 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map5B::
    dw ObjSelector_Map5B_0 ; id 0
    dw ObjSelector_Map5B_1 ; id 1
    dw ObjSelector_Map5B_2 ; id 2
    dw ObjSelector_Map5B_3 ; id 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map5B_0::
    objsel_list MapObjects_Map5B_0_0

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map5B_0_0::
    db $02 ; entry 0: object count
    db $85, $01, $52, $00, $00, $70, $40, $05, $00, $50, $6e ; object 0
    db $86, $01, $14, $00, $00, $20, $10, $06, $02, $60, $6b ; object 1

ObjSelector_Map5B_1::
    objsel_skip_if_clear EVENT_YOU_WILL_THANK_YOU_LET, $04, $00
    objsel_list MapObjects_Map5B_1_1

ObjSelector_Map5B_1_Unlisted::
    objsel_unless_flag EVENT_SCENE_CHEER_YUNA, MapObjects_Map5B_1_Unlisted_0
    objsel_list MapObjects_Map5B_1_Unlisted_1

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_Map5B_1_Unlisted_0::
    db $03 ; entry 0: object count
    db $85, $01, $0e, $00, $00, $40, $20, $05, $00, $50, $71 ; object 0
    db $86, $01, $3a, $00, $00, $50, $20, $06, $00, $60, $72 ; object 1
    db $87, $01, $03, $00, $00, $40, $40, $07, $02, $70, $00 ; object 2

; record: count, then 2 object(s), the layout of the other object lists
MapObjects_Map5B_1_Unlisted_1::
    db $02 ; entry 0: object count
    db $85, $01, $0e, $00, $00, $40, $20, $05, $00, $50, $71 ; object 0
    db $86, $01, $3a, $00, $00, $50, $20, $06, $00, $60, $72 ; object 1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map5B_1_1::
    db $01 ; entry 0
    db $85, $01, $0e, $00, $00, $40, $20, $05, $00, $50, $71

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map5B_2::
    objsel_list MapObjects_Map5B_2_0

; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map5B_2_0::
    db $02 ; entry 0: object count
    db $86, $01, $12, $00, $00, $30, $60, $06, $03, $60, $6c ; object 0
    db $87, $01, $52, $00, $00, $10, $20, $07, $02, $70, $6a ; object 1

ObjSelector_Map5B_3::
    objsel_unless_flag EVENT_SCENE_CHEER_YUNA, MapObjects_Map5B_3_0
    objsel_list MapObjects_Map5B_3_1

; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map5B_3_0::
    db $03 ; entry 0: object count
    db $85, $01, $12, $00, $00, $40, $10, $05, $00, $50, $6f ; object 0
    db $86, $01, $52, $00, $00, $50, $10, $06, $00, $60, $69 ; object 1
    db $87, $01, $52, $00, $02, $60, $40, $07, $01, $70, $6d ; object 2

; an object list of LoadMapObjectsForScreen (E-0163)
MapObjects_Map5B_3_1::
    db $03 ; entry 0: object count
    db $85, $01, $12, $00, $00, $30, $30, $05, $00, $50, $6f ; object 0
    db $86, $01, $52, $00, $00, $60, $20, $06, $00, $60, $69 ; object 1
    db $87, $01, $52, $00, $02, $60, $40, $07, $01, $70, $6d ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map5C::
    dw $0000 ; id 0
    dw ObjSelector_Map5C_1 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map5C_1::
    objsel_skip_if_clear EVENT_SCENE_PRINCESS_MEDICINE_09D, $04, $00
    objsel_list MapObjects_Map5C_1_1

ObjSelector_Map5C_1_Unlisted::
    objsel_unless_flag EVENT_YOU_WILL_THANK_YOU_LET, MapObjects_Map5C_1_Unlisted_0
    objsel_list MapObjects_Map5C_1_Unlisted_1

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_Map5C_1_Unlisted_0::
    db $02 ; entry 0: object count
    db $85, $01, $3a, $00, $00, $e0, $e0, $05, $03, $50, $72 ; object 0
    db $86, $01, $59, $00, $00, $80, $10, $06, $00, $60, $9a ; object 1

; record: count, then 3 object(s), the layout of the other object lists
MapObjects_Map5C_1_Unlisted_1::
    db $03 ; entry 0: object count
    db $85, $01, $3a, $00, $00, $60, $30, $05, $03, $50, $72 ; object 0
    db $86, $01, $59, $00, $00, $80, $10, $06, $00, $60, $9a ; object 1
    db $87, $00, $21, $01, $00, $80, $e0, $07, $00, $70, $9a ; object 2

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map5C_1_1::
    db $01 ; entry 0
    db $85, $01, $3a, $00, $00, $60, $30, $05, $03, $50, $72

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map5D::
    dw $0000 ; id 0
    dw $0000 ; id 1
    dw ObjSelector_Map5D_2 ; id 2
    dw $0000 ; id 3
    dw $0000 ; id 4
    dw $0000 ; id 5
    dw ObjSelector_Map5D_6 ; id 6
    dw $0000 ; id 7
    dw $0000 ; id 8
    dw $0000 ; id 9
    dw ObjSelector_Map5D_10 ; id 10
    dw $0000 ; id 11
    dw $0000 ; id 12
    dw $0000 ; id 13
    dw ObjSelector_Map5D_14 ; id 14
    dw $0000 ; id 15

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map5D_2::
    objsel_unless_flag EVENT_SCENE_SHIELD2_1E5, MapObjects_Map5D_2_0
    objsel_list MapObjects_Map5D_2_1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map5D_2_0::
    db $03 ; entry 0: object count
    db $85, $01, $2e, $00, $00, $30, $50, $05, $01, $50, $92 ; object 0
    db $86, $01, $2f, $00, $02, $60, $30, $06, $01, $60, $93 ; object 1
    db $87, $01, $42, $00, $02, $50, $60, $07, $01, $70, $2e ; object 2

; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map5D_2_1::
    db $02 ; entry 0: object count
    db $85, $01, $2e, $00, $00, $30, $50, $05, $01, $50, $92 ; object 0
    db $86, $01, $2f, $00, $02, $60, $30, $06, $01, $60, $93 ; object 1

ObjSelector_Map5D_6::
    objsel_unless_flag EVENT_SCENE_SPIRIT_ENVOY2, MapObjects_Map5D_6_0
    objsel_none

ObjSelector_Map5D_10::
    objsel_unless_flag EVENT_SCENE_SPIRIT_ENVOY2_099, MapObjects_Map5D_6_0
    objsel_none

ObjSelector_Map5D_14::
    objsel_unless_flag EVENT_YOU_WILL_THANK_YOU_LET, MapObjects_Map5D_6_0
    objsel_none

; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map5D_6_0::
    db $01 ; entry 0
    db $85, $01, $3a, $00, $00, $50, $40, $05, $02, $50, $99

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map5E::
    dw ObjSelector_Map5E_0 ; id 0
    dw ObjSelector_Map5E_1 ; id 1
    dw ObjSelector_Map5E_2 ; id 2
    dw ObjSelector_Map5E_3 ; id 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map5E_0::
    objsel_unless_flag EVENT_SCENE_SHIELD2_1E5, MapObjects_Map5E_0_0
    objsel_list MapObjects_Map5E_0_1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map5E_0_0::
    db $03 ; entry 0: object count
    db $85, $01, $2f, $00, $00, $60, $50, $05, $00, $50, $78 ; object 0
    db $86, $01, $2f, $00, $00, $40, $20, $06, $00, $60, $7e ; object 1
    db $87, $01, $14, $00, $00, $80, $30, $07, $03, $70, $7f ; object 2

; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map5E_0_1::
    db $04 ; entry 0: object count
    db $85, $01, $2f, $00, $00, $60, $50, $05, $00, $50, $78 ; object 0
    db $85, $01, $2f, $00, $00, $40, $10, $05, $02, $50, $7e ; object 1
    db $86, $01, $14, $00, $00, $80, $30, $06, $03, $60, $7f ; object 2
    db $87, $01, $21, $00, $00, $50, $20, $07, $00, $70, $9b ; object 3

ObjSelector_Map5E_1::
    objsel_unless_flag EVENT_OH_AN_ENVOY_FROM_THE, MapObjects_Map5E_1_0
    objsel_list MapObjects_Map5E_1_1

MapObjects_Map5E_1_0::
    db $04 ; entry 0: object count
    db $85, $01, $10, $00, $00, $40, $10, $05, $00, $50, $7c ; object 0
    db $85, $01, $10, $00, $00, $50, $10, $05, $00, $50, $7c ; object 1
    db $86, $01, $2e, $00, $00, $70, $70, $06, $03, $60, $79 ; object 2
    db $87, $01, $2d, $00, $02, $60, $40, $07, $01, $70, $77 ; object 3

MapObjects_Map5E_1_1::
    db $04 ; entry 0: object count
    db $85, $01, $10, $00, $00, $30, $30, $05, $00, $50, $7c ; object 0
    db $85, $01, $10, $00, $00, $60, $20, $05, $00, $50, $7c ; object 1
    db $86, $01, $2e, $00, $00, $70, $70, $06, $03, $60, $79 ; object 2
    db $87, $01, $2d, $00, $02, $60, $40, $07, $01, $70, $77 ; object 3

ObjSelector_Map5E_2::
    objsel_list MapObjects_Map5E_2_0

MapObjects_Map5E_2_0::
    db $04 ; entry 0: object count
    db $85, $01, $2e, $00, $00, $70, $40, $05, $01, $50, $74 ; object 0
    db $86, $01, $2f, $00, $00, $60, $70, $06, $01, $60, $75 ; object 1
    db $85, $01, $2e, $00, $00, $40, $50, $05, $02, $50, $76 ; object 2
    db $87, $01, $12, $00, $00, $50, $10, $07, $00, $70, $80 ; object 3

ObjSelector_Map5E_3::
    objsel_list MapObjects_Map5E_3_0

MapObjects_Map5E_3_0::
    db $04 ; entry 0: object count
    db $85, $01, $30, $00, $00, $60, $60, $05, $00, $50, $73 ; object 0
    db $86, $01, $2f, $00, $00, $20, $50, $06, $03, $60, $7a ; object 1
    db $86, $01, $2f, $00, $00, $50, $30, $06, $00, $60, $7b ; object 2
    db $87, $01, $15, $00, $00, $80, $20, $07, $03, $70, $7d ; object 3

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map5F::
    dw ObjSelector_Map5F_0 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map5F_0::
    objsel_unless_flag EVENT_SCENE_SHIELD2_1E5, MapObjects_Map5F_0_0
    objsel_list MapObjects_Map5F_0_1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map5F_0_0::
    db $04 ; entry 0: object count
    db $85, $01, $2e, $00, $00, $40, $60, $05, $02, $50, $86 ; object 0
    db $86, $01, $15, $00, $00, $20, $20, $06, $00, $60, $87 ; object 1
    db $85, $01, $2e, $00, $00, $50, $40, $05, $03, $50, $88 ; object 2
    db $87, $01, $29, $00, $00, $10, $70, $07, $01, $70, $89 ; object 3

; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map5F_0_1::
    db $03 ; entry 0: object count
    db $85, $01, $2e, $00, $00, $40, $60, $05, $02, $50, $86 ; object 0
    db $86, $01, $2e, $00, $00, $50, $40, $06, $03, $60, $88 ; object 1
    db $87, $01, $29, $00, $00, $10, $70, $07, $01, $70, $89 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map60::
    dw ObjSelector_Map60_0 ; id 0
    dw ObjSelector_Map60_1 ; id 1
    dw ObjSelector_Map60_2 ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map60_0::
    objsel_skip_if_set EVENT_THANKS_FOR_COMING_BY_025, $0a, $00
    objsel_skip_if_clear EVENT_SCENE_DARCK_DEFEATED, $04, $00
    objsel_list MapObjects_Map60_0_2

ObjSelector_Map60_0_Unlisted::
    objsel_skip_if_clear EVENT_SCENE_SHIELD2_1E5, $04, $00
    objsel_list MapObjects_Map60_0_Unlisted_1

ObjSelector_Map60_0_Unlisted_2::
    objsel_skip_if_clear EVENT_SCENE_PRINCESS_MEDICINE_09D, $02, $00
    objsel_none

ObjSelector_Map60_0_Unlisted_3::
    objsel_list MapObjects_Map60_0_Unlisted_1

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_Map60_0_Unlisted_1::
    db $01 ; entry 0
    db $85, $01, $0f, $00, $00, $40, $10, $05, $00, $50, $90

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 5 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map60_0_2::
    db $05 ; entry 0: object count
    db $85, $01, $0f, $00, $00, $40, $10, $05, $00, $50, $90 ; object 0
    db $86, $01, $10, $00, $00, $30, $60, $06, $00, $60, $8e ; object 1
    db $86, $01, $10, $00, $00, $60, $60, $06, $00, $60, $8e ; object 2
    db $87, $01, $2a, $00, $00, $30, $20, $07, $00, $70, $8d ; object 3
    db $83, $01, $30, $00, $00, $40, $b0, $03, $02, $30, $73 ; object 4

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map60_1::
    objsel_unless_flag EVENT_SCENE_MEDICINE_GIVEN, MapObjects_Map60_1_0
    objsel_list MapObjects_Map60_1_1

; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map60_1_0::
    db $03 ; entry 0: object count
    db $85, $01, $10, $00, $00, $30, $10, $05, $01, $50, $8e ; object 0
    db $86, $01, $12, $00, $00, $20, $50, $06, $02, $60, $8f ; object 1
    db $87, $01, $2a, $00, $00, $60, $60, $07, $03, $70, $8d ; object 2

; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map60_1_1::
    db $02 ; entry 0: object count
    db $85, $01, $10, $00, $00, $30, $10, $05, $01, $50, $8e ; object 0
    db $86, $01, $12, $00, $00, $20, $50, $06, $02, $60, $8f ; object 1

ObjSelector_Map60_2::
    objsel_list MapObjects_Map60_2_0

; an object list of LoadMapObjectsForScreen (E-0163)
MapObjects_Map60_2_0::
    db $03 ; entry 0: object count
    db $85, $01, $10, $00, $00, $30, $10, $05, $00, $50, $8a ; object 0
    db $86, $01, $10, $00, $02, $50, $40, $06, $01, $60, $8b ; object 1
    db $87, $01, $12, $00, $00, $20, $50, $07, $00, $70, $8c ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map61::
    dw ObjSelector_Map61_0 ; id 0
    dw ObjSelector_Map61_1 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map61_0::
    objsel_skip_if_clear EVENT_SCENE_SHIELD2_1E5, $04, $00
    objsel_list MapObjects_Map61_0_1

ObjSelector_Map61_0_Unlisted::
    objsel_skip_if_clear EVENT_SCENE_SHIELD_GUARDIAN_1E2, $04, $00
    objsel_list MapObjects_Map61_0_Unlisted_1

ObjSelector_Map61_0_Unlisted_2::
    objsel_skip_if_clear EVENT_SCENE_SHIELD_GUARDIAN, $04, $00
    objsel_list MapObjects_Map61_0_Unlisted_2_1

ObjSelector_Map61_0_Unlisted_3::
    objsel_unless_flag EVENT_SCENE_MEDICINE_GIVEN, MapObjects_Map61_0_Unlisted_3_0
    objsel_list MapObjects_Map61_0_Unlisted_3_1

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_Map61_0_Unlisted_3_0::
    db $03 ; entry 0: object count
    db $85, $01, $46, $00, $00, $40, $30, $05, $00, $50, $90 ; object 0
    db $86, $01, $2a, $00, $00, $50, $70, $06, $02, $60, $8d ; object 1
    db $87, $00, $e0, $00, $00, $40, $e0, $07, $00, $70, $9e ; object 2

MapObjects_Map61_0_Unlisted_3_1::
    db $03 ; entry 0: object count
    db $85, $01, $46, $00, $00, $40, $30, $05, $00, $50, $90 ; object 0
    db $86, $01, $2a, $00, $00, $50, $40, $06, $02, $60, $8d ; object 1
    db $87, $00, $e0, $00, $00, $40, $e0, $07, $00, $70, $9e ; object 2

MapObjects_Map61_0_Unlisted_2_1::
    db $03 ; entry 0: object count
    db $85, $01, $46, $00, $00, $40, $30, $05, $00, $50, $90 ; object 0
    db $86, $01, $2a, $00, $00, $50, $40, $06, $02, $60, $8d ; object 1
    db $87, $00, $e0, $00, $00, $40, $20, $07, $00, $70, $9e ; object 2

; record: count, then 2 object(s), the layout of the other object lists
MapObjects_Map61_0_Unlisted_1::
    db $02 ; entry 0: object count
    db $85, $01, $0f, $00, $00, $60, $40, $05, $00, $50, $90 ; object 0
    db $86, $01, $2a, $00, $02, $30, $50, $06, $00, $60, $8d ; object 1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map61_0_1::
    db $01 ; entry 0
    db $85, $01, $2a, $00, $02, $30, $50, $05, $01, $50, $8d

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map61_1::
    objsel_unless_flag EVENT_SCENE_MEDICINE_GIVEN, MapObjects_Map61_1_0
    objsel_none

MapObjects_Map61_1_0::
    db $01 ; entry 0
    db $85, $01, $2a, $00, $00, $70, $60, $05, $03, $50, $8d

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map30::
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
    dw ObjSelector_Map30_23 ; id 23
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
    dw ObjSelector_Map30_45 ; id 45
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

ObjSelector_Map30_23::
    objsel_skip_if_set EVENT_SCENE_MERMAID_KINGDOM_022, $02, $00
    objsel_none

ObjSelector_Map30_23_Unlisted::
    objsel_unless_flag EVENT_THICK_SUCTION_CUPPED_TENTACLES_SNAKED, MapObjects_Map30_23_Unlisted_0
    objsel_none

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_Map30_23_Unlisted_0::
    db $01 ; entry 0
    db $85, $00, $53, $01, $00, $50, $50, $05, $00, $50, $6c

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map30_45::
    objsel_skip_if_clear EVENT_SCENE_CRATE, $02, $00
    objsel_none

ObjSelector_Map30_45_Unlisted::
    objsel_skip_if_set EVENT_WELCOME_YOUNG_HUMAN_I_HEARD, $02, $00
    objsel_none

ObjSelector_Map30_45_Unlisted_2::
    objsel_list MapObjects_Map30_45_Unlisted_2_0

MapObjects_Map30_45_Unlisted_2_0::
    db $01 ; entry 0
    db $85, $01, $55, $00, $02, $40, $40, $05, $00, $50, $46

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map31::
    dw ObjSelector_Map31_0 ; id 0
    dw ObjSelector_Map31_1 ; id 1

ObjSelector_Map31_0::
    objsel_list MapObjects_Map31_0_0

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map31_0_0::
    db $04 ; entry 0: object count
    db $85, $01, $0c, $00, $00, $20, $30, $05, $01, $50, $04 ; object 0
    db $86, $01, $0b, $00, $00, $50, $40, $06, $00, $60, $05 ; object 1
    db $85, $01, $0c, $00, $00, $30, $60, $05, $00, $50, $06 ; object 2
    db $87, $01, $06, $00, $00, $70, $50, $07, $00, $70, $03 ; object 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map31_1::
    objsel_list MapObjects_Map31_1_0

MapObjects_Map31_1_0::
    db $04 ; entry 0: object count
    db $85, $01, $08, $00, $00, $60, $60, $05, $00, $50, $00 ; object 0
    db $86, $01, $09, $00, $00, $80, $40, $06, $03, $60, $01 ; object 1
    db $85, $01, $08, $00, $02, $30, $50, $05, $01, $50, $02 ; object 2
    db $87, $01, $15, $00, $00, $10, $30, $07, $01, $70, $07 ; object 3

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map32::
    dw ObjSelector_Map32_0 ; id 0
    dw ObjSelector_Map32_1 ; id 1
    dw ObjSelector_Map32_2 ; id 2
    dw ObjSelector_Map32_3 ; id 3

ObjSelector_Map32_0::
    objsel_list MapObjects_Map32_0_0

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map32_0_0::
    db $04 ; entry 0: object count
    db $85, $01, $0b, $00, $00, $20, $20, $05, $01, $50, $1a ; object 0
    db $86, $01, $08, $00, $02, $60, $40, $06, $01, $60, $1b ; object 1
    db $87, $01, $06, $00, $00, $20, $50, $07, $01, $70, $23 ; object 2
    db $86, $01, $08, $00, $00, $30, $70, $06, $02, $60, $1c ; object 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map32_1::
    objsel_list MapObjects_Map32_1_0

; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map32_1_0::
    db $03 ; entry 0: object count
    db $85, $01, $08, $00, $00, $50, $60, $05, $03, $50, $1e ; object 0
    db $86, $01, $09, $00, $02, $30, $40, $06, $01, $60, $1f ; object 1
    db $87, $01, $15, $00, $00, $70, $20, $07, $00, $70, $20 ; object 2

ObjSelector_Map32_2::
    objsel_list MapObjects_Map32_2_0

MapObjects_Map32_2_0::
    db $04 ; entry 0: object count
    db $85, $01, $0a, $00, $00, $80, $40, $05, $03, $50, $21 ; object 0
    db $86, $01, $15, $00, $00, $40, $50, $06, $03, $60, $22 ; object 1
    db $85, $01, $0a, $00, $00, $60, $20, $05, $00, $50, $24 ; object 2
    db $87, $01, $12, $00, $00, $30, $10, $07, $00, $70, $1d ; object 3

ObjSelector_Map32_3::
    objsel_list MapObjects_Map32_3_0

MapObjects_Map32_3_0::
    db $03 ; entry 0: object count
    db $85, $01, $0c, $00, $00, $70, $60, $05, $00, $50, $25 ; object 0
    db $86, $01, $09, $00, $00, $60, $30, $06, $00, $60, $26 ; object 1
    db $87, $01, $16, $00, $02, $20, $40, $07, $01, $70, $27 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map33::
    dw ObjSelector_Map33_0 ; id 0
    dw ObjSelector_Map33_1 ; id 1

ObjSelector_Map33_0::
    objsel_skip_if_set EVENT_THANKS_FOR_COMING_BY_025, $0a, $00
    objsel_skip_if_clear EVENT_SCENE_DARCK_DEFEATED, $04, $00
    objsel_list MapObjects_Map33_0_2

ObjSelector_Map33_0_Unlisted::
    objsel_list MapObjects_Map33_0_Unlisted_0

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 4 object(s), the layout of the other object lists
MapObjects_Map33_0_Unlisted_0::
    db $04 ; entry 0: object count
    db $85, $01, $16, $00, $00, $50, $30, $05, $00, $50, $30 ; object 0
    db $86, $01, $29, $00, $00, $70, $50, $06, $00, $60, $31 ; object 1
    db $86, $01, $29, $00, $00, $70, $60, $06, $02, $60, $32 ; object 2
    db $87, $01, $0c, $00, $00, $20, $40, $07, $01, $70, $33 ; object 3

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map33_0_2::
    db $04 ; entry 0: object count
    db $85, $01, $16, $00, $00, $50, $30, $05, $00, $50, $30 ; object 0
    db $86, $01, $06, $00, $00, $40, $b0, $06, $02, $60, $23 ; object 1
    db $87, $00, $48, $01, $00, $40, $c0, $07, $02, $70, $23 ; object 2
    db $83, $01, $0c, $00, $00, $20, $40, $03, $01, $30, $33 ; object 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map33_1::
    objsel_unless_flag EVENT_THE_PIRATES, MapObjects_Map33_1_0
    objsel_list MapObjects_Map33_1_1

; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map33_1_0::
    db $03 ; entry 0: object count
    db $85, $01, $03, $00, $00, $40, $e0, $05, $00, $50, $00 ; object 0
    db $86, $01, $28, $00, $00, $30, $d0, $06, $00, $60, $00 ; object 1
    db $87, $01, $29, $00, $00, $50, $d0, $07, $00, $70, $00 ; object 2

; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map33_1_1::
    db $02 ; entry 0: object count
    db $85, $01, $0a, $00, $00, $60, $10, $05, $00, $50, $3b ; object 0
    db $86, $01, $29, $00, $00, $60, $30, $06, $02, $60, $3c ; object 1

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map34::
    dw ObjSelector_Map34_0 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map34_0::
    objsel_list MapObjects_Map34_0_0

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map34_0_0::
    db $03 ; entry 0: object count
    db $85, $01, $0a, $00, $00, $30, $10, $05, $00, $50, $2c ; object 0
    db $86, $01, $16, $00, $00, $20, $50, $06, $00, $60, $2d ; object 1
    db $87, $01, $29, $00, $00, $20, $70, $07, $02, $70, $2e ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map35::
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
    dw ObjSelector_Map35_15 ; id 15

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map35_15::
    objsel_unless_flag EVENT_SCENE_WATCH_OUT_078, MapObjects_Map35_15_0
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map35_15_0::
    db $01 ; entry 0
    db $85, $00, $4f, $01, $00, $40, $30, $05, $03, $50, $34

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map37::
    dw ObjSelector_Map37_0 ; id 0
    dw $0000 ; id 1
    dw ObjSelector_Map37_2 ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map37_0::
    objsel_unless_flag EVENT_HOW_COULD_WE_DIE_BEFORE, MapObjects_Map37_0_0
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map37_0_0::
    db $01 ; entry 0
    db $85, $01, $44, $00, $00, $70, $10, $05, $00, $50, $47

ObjSelector_Map37_2::
    objsel_list MapObjects_Map37_2_0

MapObjects_Map37_2_0::
    db $01 ; entry 0
    db $85, $01, $56, $00, $00, $70, $60, $05, $00, $50, $4d

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map38::
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
    dw ObjSelector_Map38_14 ; id 14
    dw $0000 ; id 15

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map38_14::
    objsel_unless_flag EVENT_KAMEHA_WAHAHAHAH_THANKS_FOR_GUIDING, MapObjects_Map38_14_0
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map38_14_0::
    db $03 ; entry 0: object count
    db $85, $01, $03, $00, $00, $50, $a0, $05, $02, $50, $00 ; object 0
    db $86, $01, $28, $00, $00, $50, $b0, $06, $02, $60, $00 ; object 1
    db $87, $01, $29, $00, $00, $50, $c0, $07, $02, $70, $00 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map39::
    dw $0000 ; id 0
    dw $0000 ; id 1
    dw $0000 ; id 2
    dw $0000 ; id 3
    dw $0000 ; id 4
    dw ObjSelector_Map39_5 ; id 5
    dw $0000 ; id 6
    dw $0000 ; id 7
    dw $0000 ; id 8
    dw $0000 ; id 9
    dw $0000 ; id 10
    dw $0000 ; id 11

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map39_5::
    objsel_skip_if_clear EVENT_SCENE_CREW_FOLLOWS, $02, $00
    objsel_none

ObjSelector_Map39_5_Unlisted::
    objsel_unless_flag EVENT_SCENE_CREW_FOLLOWS_07D, MapObjects_Map39_5_Unlisted_0
    objsel_list MapObjects_Map39_5_Unlisted_1

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_Map39_5_Unlisted_0::
    db $03 ; entry 0: object count
    db $85, $01, $03, $00, $00, $40, $50, $05, $03, $50, $00 ; object 0
    db $86, $01, $28, $00, $00, $60, $60, $06, $00, $60, $00 ; object 1
    db $87, $01, $29, $00, $00, $50, $20, $07, $01, $70, $00 ; object 2

MapObjects_Map39_5_Unlisted_1::
    db $03 ; entry 0: object count
    db $85, $01, $03, $00, $00, $60, $50, $05, $01, $50, $00 ; object 0
    db $86, $01, $28, $00, $00, $50, $50, $06, $01, $60, $00 ; object 1
    db $87, $01, $29, $00, $00, $40, $50, $07, $01, $70, $00 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map3A::
    dw $0000 ; id 0
    dw ObjSelector_Map3A_1 ; id 1
    dw $0000 ; id 2
    dw $0000 ; id 3
    dw $0000 ; id 4
    dw $0000 ; id 5
    dw $0000 ; id 6
    dw $0000 ; id 7
    dw $0000 ; id 8

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map3A_1::
    objsel_unless_flag EVENT_SCENE_KAMEHA_FLEES, MapObjects_Map3A_1_0
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map3A_1_0::
    db $03 ; entry 0: object count
    db $85, $01, $03, $00, $00, $60, $a0, $05, $02, $50, $00 ; object 0
    db $86, $01, $28, $00, $00, $60, $b0, $06, $02, $60, $00 ; object 1
    db $87, $01, $29, $00, $00, $60, $c0, $07, $02, $70, $00 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map3B::
    dw ObjSelector_Map3B_0 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map3B_0::
    objsel_skip_if_clear EVENT_SCENE_MERMAID_KINGDOM_05F, $02, $00
    objsel_none

ObjSelector_Map3B_0_Unlisted::
    objsel_unless_flag EVENT_SCENE_MERMAID_KINGDOM_07F, MapObjects_Map3B_0_Unlisted_0
    objsel_list MapObjects_Map3B_0_Unlisted_1

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_Map3B_0_Unlisted_0::
    db $03 ; entry 0: object count
    db $85, $01, $28, $00, $00, $50, $e0, $05, $00, $50, $00 ; object 0
    db $86, $01, $29, $00, $00, $50, $d0, $06, $00, $60, $00 ; object 1
    db $87, $01, $03, $00, $00, $50, $f0, $07, $00, $70, $00 ; object 2

MapObjects_Map3B_0_Unlisted_1::
    db $03 ; entry 0: object count
    db $85, $01, $45, $00, $00, $80, $40, $05, $00, $50, $00 ; object 0
    db $86, $00, $e3, $00, $00, $50, $40, $06, $00, $60, $00 ; object 1
    db $87, $00, $d6, $00, $00, $40, $50, $07, $00, $70, $00 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map3C::
    dw ObjSelector_Map3C_0 ; id 0
    dw ObjSelector_Map3C_1 ; id 1
    dw ObjSelector_Map3C_2 ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map3C_0::
    objsel_unless_flag EVENT_IN_THE_PAST_MERMAIDS_ARE, MapObjects_Map3C_0_0
    objsel_list MapObjects_Map3C_0_1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map3C_0_0::
    db $02 ; entry 0: object count
    db $85, $01, $13, $00, $00, $60, $20, $05, $00, $50, $13 ; object 0
    db $86, $01, $4e, $00, $00, $e0, $40, $06, $00, $60, $3d ; object 1

MapObjects_Map3C_0_1::
    db $02 ; entry 0: object count
    db $85, $01, $13, $00, $00, $60, $20, $05, $00, $50, $13 ; object 0
    db $86, $01, $4e, $00, $00, $30, $40, $06, $01, $60, $3d ; object 1

ObjSelector_Map3C_1::
    objsel_list MapObjects_Map3C_1_0

; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map3C_1_0::
    db $04 ; entry 0: object count
    db $85, $01, $09, $00, $00, $60, $60, $05, $00, $50, $0f ; object 0
    db $86, $01, $0d, $00, $00, $20, $20, $06, $00, $60, $16 ; object 1
    db $87, $01, $0c, $00, $02, $70, $50, $07, $01, $70, $11 ; object 2
    db $87, $01, $0c, $00, $00, $30, $40, $07, $01, $70, $17 ; object 3

ObjSelector_Map3C_2::
    objsel_list MapObjects_Map3C_2_0

; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map3C_2_0::
    db $03 ; entry 0: object count
    db $85, $01, $13, $00, $00, $70, $20, $05, $00, $50, $15 ; object 0
    db $86, $01, $07, $00, $00, $20, $10, $06, $00, $60, $12 ; object 1
    db $87, $01, $0c, $00, $00, $80, $60, $07, $03, $70, $10 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map3D::
    dw ObjSelector_Map3D_0 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map3D_0::
    objsel_list MapObjects_Map3D_0_0

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map3D_0_0::
    db $02 ; entry 0: object count
    db $85, $01, $0a, $00, $00, $70, $10, $05, $00, $50, $14 ; object 0
    db $86, $01, $12, $00, $00, $40, $10, $06, $00, $60, $6d ; object 1

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map40::
    dw ObjSelector_Map40_0 ; id 0
    dw $0000 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map40_0::
    objsel_unless_flag EVENT_THE_PIRATES_WERE_SWALLOWED_BY, MapObjects_Map40_0_0
    objsel_list MapObjects_Map40_0_1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map40_0_0::
    db $01 ; entry 0
    db $85, $01, $58, $00, $00, $e0, $18, $05, $00, $50, $00

MapObjects_Map40_0_1::
    db $01 ; entry 0
    db $85, $01, $58, $00, $00, $48, $18, $05, $00, $50, $00

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map41::
    dw ObjSelector_Map41_0 ; id 0
    dw ObjSelector_Map41_1 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map41_0::
    objsel_skip_if_set EVENT_THANKS_FOR_COMING_BY_025, $0a, $00
    objsel_skip_if_clear EVENT_SCENE_DARCK_DEFEATED, $04, $00
    objsel_list MapObjects_Map41_0_2

ObjSelector_Map41_0_Unlisted::
    objsel_list MapObjects_Map41_0_Unlisted_0

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 4 object(s), the layout of the other object lists
MapObjects_Map41_0_Unlisted_0::
    db $04 ; entry 0: object count
    db $85, $01, $4f, $00, $00, $40, $20, $05, $00, $50, $45 ; object 0
    db $86, $01, $2c, $00, $02, $50, $40, $06, $01, $60, $43 ; object 1
    db $86, $01, $2c, $00, $00, $30, $60, $06, $00, $60, $44 ; object 2
    db $86, $01, $2c, $00, $00, $70, $70, $06, $00, $60, $42 ; object 3

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 5 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map41_0_2::
    db $05 ; entry 0: object count
    db $85, $01, $4f, $00, $00, $40, $20, $05, $00, $50, $45 ; object 0
    db $86, $01, $2c, $00, $00, $40, $50, $06, $02, $60, $43 ; object 1
    db $86, $01, $2c, $00, $00, $50, $50, $06, $02, $60, $44 ; object 2
    db $86, $01, $2c, $00, $00, $60, $50, $06, $02, $60, $42 ; object 3
    db $87, $01, $13, $00, $00, $50, $30, $07, $00, $70, $15 ; object 4

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map41_1::
    objsel_list MapObjects_Map41_1_0

; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map41_1_0::
    db $04 ; entry 0: object count
    db $85, $01, $2c, $00, $00, $60, $30, $05, $01, $50, $3e ; object 0
    db $86, $01, $2c, $00, $00, $40, $70, $06, $01, $60, $3f ; object 1
    db $85, $01, $2c, $00, $00, $50, $70, $05, $03, $50, $40 ; object 2
    db $85, $01, $2c, $00, $00, $20, $40, $05, $00, $50, $41 ; object 3

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map42::
    dw ObjSelector_Map42_0 ; id 0
    dw $0000 ; id 1
    dw $0000 ; id 2

ObjSelector_Map42_0::
    objsel_unless_flag EVENT_THE_TREASURES_ARE_OURS_NO, MapObjects_Map42_0_0
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map42_0_0::
    db $01 ; entry 0
    db $85, $01, $44, $00, $00, $80, $60, $05, $00, $50, $48

MapObjectScreens_Map43::
    dw ObjSelector_Map43_0 ; id 0
    dw $0000 ; id 1
    dw $0000 ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map43_0::
    objsel_unless_flag EVENT_IT_NAGS_AND_NAGS_THAT, MapObjects_Map43_0_0
    objsel_none

MapObjects_Map43_0_0::
    db $01 ; entry 0
    db $85, $01, $44, $00, $00, $60, $30, $05, $00, $50, $49

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map44::
    dw ObjSelector_Map44_0 ; id 0

ObjSelector_Map44_0::
    objsel_unless_flag EVENT_GIVE_ITEM_BLINK, MapObjects_Map44_0_0
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map44_0_0::
    db $01 ; entry 0
    db $85, $00, $06, $01, $00, $60, $20, $05, $00, $50, $4a

MapObjectScreens_Map00::
    dw $0000 ; id 0
    dw $0000 ; id 1
    dw $0000 ; id 2
    dw $0000 ; id 3
    dw ObjSelector_Map00_4 ; id 4
    dw ObjSelector_Map00_5 ; id 5
    dw ObjSelector_Map00_6 ; id 6
    dw ObjSelector_Map00_7 ; id 7
    dw ObjSelector_Map00_8 ; id 8
    dw ObjSelector_Map00_9 ; id 9
    dw ObjSelector_Map00_10 ; id 10
    dw ObjSelector_Map00_11 ; id 11

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map00_4::
    objsel_unless_flag EVENT_SCENE_WARUBOU_LEAVES, MapObjects_Map00_4_0
    objsel_unless_flag EVENT_SCENE_SPINNING, MapObjects_Map00_4_1
    objsel_list MapObjects_Map00_4_2

; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map00_4_0::
    db $03 ; entry 0: object count
    db $85, $01, $1a, $00, $00, $40, $00, $05, $00, $50, $0a ; object 0
    db $86, $01, $03, $00, $00, $40, $60, $06, $00, $60, $18 ; object 1
    db $87, $01, $02, $00, $00, $50, $60, $07, $00, $70, $17 ; object 2

MapObjects_Map00_4_1::
    db $01 ; entry 0
    db $85, $01, $1a, $00, $00, $40, $00, $05, $00, $50, $0a

; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map00_4_2::
    db $02 ; entry 0: object count
    db $85, $01, $1a, $00, $00, $20, $10, $05, $00, $50, $0a ; object 0
    db $86, $01, $10, $00, $00, $40, $e0, $06, $00, $60, $00 ; object 1

ObjSelector_Map00_5::
    objsel_skip_if_clear EVENT_SCENE_SHIELD2_023, $04, $00
    objsel_list MapObjects_Map00_5_1

ObjSelector_Map00_5_Unlisted::
    objsel_unless_flag EVENT_REWARD_ITEM_OR_KEY, MapObjects_Map00_5_Unlisted_0
    objsel_list MapObjects_Map00_5_Unlisted_1

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_Map00_5_Unlisted_0::
    db $02 ; entry 0: object count
    db $85, $01, $04, $00, $00, $60, $30, $05, $01, $50, $07 ; object 0
    db $86, $00, $5a, $00, $00, $60, $e0, $06, $00, $60, $4b ; object 1

MapObjects_Map00_5_Unlisted_1::
    db $02 ; entry 0: object count
    db $85, $01, $04, $00, $00, $60, $30, $05, $01, $50, $07 ; object 0
    db $86, $00, $5a, $00, $00, $60, $20, $06, $00, $60, $4b ; object 1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map00_5_1::
    db $03 ; entry 0: object count
    db $85, $01, $04, $00, $00, $50, $30, $05, $01, $50, $07 ; object 0
    db $86, $00, $5a, $00, $00, $60, $20, $06, $00, $60, $4b ; object 1
    db $87, $00, $01, $01, $00, $30, $60, $07, $00, $70, $7c ; object 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map00_6::
    objsel_skip_if_clear EVENT_SCENE_THREE_ITEMS, $04, $00
    objsel_list MapObjects_Map00_6_1

ObjSelector_Map00_6_Unlisted::
    objsel_skip_if_clear EVENT_SCENE_VAULT_SETTLED, $04, $00
    objsel_unless_flag EVENT_SCENE_LONG_FACES_002, MapObjects_Map00_6_Unlisted_1
    objsel_none

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_Map00_6_Unlisted_1::
    db $01 ; entry 0
    db $85, $00, $0a, $00, $00, $80, $40, $05, $00, $50, $08

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map00_6_1::
    db $01 ; entry 0
    db $85, $00, $f0, $00, $00, $80, $30, $05, $00, $50, $98

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map00_7::
    objsel_skip_if_clear EVENT_THANKS_FOR_COMING_BY_025, $08, $00
    objsel_unless_flag EVENT_NEVER_SET, MapObjects_Map00_7_1
    objsel_list MapObjects_Map00_7_2

ObjSelector_Map00_7_Unlisted::
    objsel_skip_if_set EVENT_COBI_HERO_WHILE_YOURE, $12, $00
    objsel_skip_if_set EVENT_SCENE_LONG_FACES_002, $08, $00
    objsel_unless_flag EVENT_SCENE_VAULT_SETTLED, MapObjects_Map00_7_Unlisted_2
    objsel_list MapObjects_Map00_7_Unlisted_3

ObjSelector_Map00_7_Unlisted_2::
    objsel_list MapObjects_Map00_7_Unlisted_2_0

ObjSelector_Map00_7_Unlisted_3::
    objsel_skip_if_clear EVENT_SCENE_RIVAL_DEFEATED_021, $0e, $00
    objsel_skip_if_set EVENT_OH_YOU_BOUGHT_THE_LOVE, $08, $00
    objsel_unless_flag EVENT_NEVER_SET, MapObjects_Map00_7_Unlisted_3_2
    objsel_list MapObjects_Map00_7_Unlisted_3_3

ObjSelector_Map00_7_Unlisted_4::
    objsel_unless_flag EVENT_NEVER_SET, MapObjects_Map00_7_1
    objsel_list MapObjects_Map00_7_2

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_Map00_7_Unlisted_2::
    db $02 ; entry 0: object count
    db $85, $01, $04, $00, $00, $40, $00, $05, $00, $50, $07 ; object 0
    db $86, $00, $0a, $00, $00, $50, $00, $06, $00, $60, $08 ; object 1

MapObjects_Map00_7_Unlisted_3::
    db $02 ; entry 0: object count
    db $85, $01, $04, $00, $00, $30, $20, $05, $00, $50, $07 ; object 0
    db $86, $00, $01, $00, $02, $50, $50, $06, $01, $60, $1a ; object 1

; record: count, then 3 object(s), the layout of the other object lists
MapObjects_Map00_7_Unlisted_2_0::
    db $03 ; entry 0: object count
    db $85, $01, $04, $00, $00, $30, $20, $05, $00, $50, $07 ; object 0
    db $86, $00, $01, $00, $02, $50, $50, $06, $01, $60, $1a ; object 1
    db $84, $00, $24, $00, $00, $70, $60, $04, $03, $40, $b2 ; object 2

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map00_7_2::
    db $03 ; entry 0: object count
    db $85, $01, $00, $00, $00, $60, $30, $05, $00, $50, $1b ; object 0
    db $86, $00, $01, $00, $02, $50, $50, $06, $01, $60, $1a ; object 1
    db $84, $00, $24, $00, $00, $70, $60, $04, $03, $40, $b2 ; object 2

MapObjects_Map00_7_1::
    db $03 ; entry 0: object count
    db $85, $01, $01, $00, $00, $60, $30, $05, $00, $50, $1c ; object 0
    db $86, $00, $01, $00, $02, $50, $50, $06, $03, $60, $1a ; object 1
    db $84, $00, $24, $00, $00, $70, $60, $04, $03, $40, $b2 ; object 2

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_Map00_7_Unlisted_3_3::
    db $02 ; entry 0: object count
    db $85, $01, $00, $00, $00, $60, $30, $05, $00, $50, $1b ; object 0
    db $86, $00, $24, $00, $00, $70, $60, $06, $03, $60, $b2 ; object 1

MapObjects_Map00_7_Unlisted_3_2::
    db $02 ; entry 0: object count
    db $85, $01, $01, $00, $00, $60, $30, $05, $00, $50, $1c ; object 0
    db $86, $00, $24, $00, $00, $70, $60, $06, $03, $60, $b2 ; object 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map00_8::
    objsel_skip_if_clear EVENT_SCENE_SHIELD2_023, $04, $00
    objsel_list MapObjects_Map00_8_1

ObjSelector_Map00_8_Unlisted::
    objsel_skip_if_clear EVENT_SCENE_MERMAID_KINGDOM_022, $04, $00
    objsel_list MapObjects_Map00_8_Unlisted_1

ObjSelector_Map00_8_Unlisted_2::
    objsel_skip_if_clear EVENT_SCENE_RIVAL_DEFEATED_021, $04, $00
    objsel_list MapObjects_Map00_8_Unlisted_2_1

ObjSelector_Map00_8_Unlisted_3::
    objsel_unless_flag EVENT_SCENE_VAULT_SETTLED, MapObjects_Map00_8_Unlisted_3_0
    objsel_none

; record: count, then 1 object(s), the layout of the other object lists
MapObjects_Map00_8_Unlisted_3_0::
    db $01 ; entry 0
    db $85, $00, $01, $00, $02, $20, $50, $05, $01, $50, $1a

MapObjects_Map00_8_Unlisted_2_1::
    db $02 ; entry 0: object count
    db $85, $00, $4f, $00, $00, $30, $20, $05, $00, $50, $b3 ; object 0
    db $86, $01, $04, $00, $00, $20, $30, $06, $01, $60, $07 ; object 1

MapObjects_Map00_8_Unlisted_1::
    db $02 ; entry 0: object count
    db $85, $00, $4f, $00, $00, $30, $20, $05, $00, $50, $b3 ; object 0
    db $86, $00, $d8, $00, $00, $50, $10, $06, $00, $60, $4a ; object 1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map00_8_1::
    db $03 ; entry 0: object count
    db $85, $00, $4f, $00, $00, $30, $20, $05, $00, $50, $b3 ; object 0
    db $86, $00, $d8, $00, $00, $50, $10, $06, $00, $60, $4a ; object 1
    db $87, $00, $2a, $00, $00, $40, $60, $07, $00, $70, $7b ; object 2

ObjSelector_Map00_9::
    objsel_list MapObjects_Map00_9_0

; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map00_9_0::
    db $01 ; entry 0
    db $86, $00, $91, $00, $00, $30, $30, $06, $01, $60, $04

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map00_10::
    objsel_skip_if_clear EVENT_SCENE_SHIELD2_023, $04, $00
    objsel_list MapObjects_Map00_10_1

ObjSelector_Map00_10_Unlisted::
    objsel_skip_if_clear EVENT_SCENE_RIVAL_DEFEATED_021, $04, $00
    objsel_list MapObjects_Map00_10_Unlisted_1

ObjSelector_Map00_10_Unlisted_2::
    objsel_skip_if_clear EVENT_COBI_HERO_WHILE_YOURE, $04, $00
    objsel_list MapObjects_Map00_10_Unlisted_2_1

ObjSelector_Map00_10_Unlisted_3::
    objsel_list MapObjects_Map00_10_Unlisted_3_0

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_Map00_10_Unlisted_3_0::
    db $01 ; entry 0
    db $85, $00, $b9, $00, $02, $40, $20, $05, $01, $50, $09

; record: count, then 2 object(s), the layout of the other object lists
MapObjects_Map00_10_Unlisted_2_1::
    db $02 ; entry 0: object count
    db $85, $00, $b9, $00, $02, $40, $20, $05, $01, $50, $09 ; object 0
    db $86, $01, $04, $00, $00, $50, $40, $06, $03, $60, $07 ; object 1

MapObjects_Map00_10_Unlisted_1::
    db $02 ; entry 0: object count
    db $85, $00, $b9, $00, $02, $40, $20, $05, $01, $50, $09 ; object 0
    db $86, $00, $f6, $00, $00, $60, $40, $06, $00, $60, $b4 ; object 1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map00_10_1::
    db $03 ; entry 0: object count
    db $85, $00, $b9, $00, $02, $40, $20, $05, $01, $50, $09 ; object 0
    db $86, $00, $f6, $00, $00, $60, $40, $06, $00, $60, $b4 ; object 1
    db $87, $00, $b1, $00, $00, $70, $30, $07, $00, $70, $d4 ; object 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map00_11::
    objsel_skip_if_clear EVENT_SCENE_SHIELD2_023, $04, $00
    objsel_list MapObjects_Map00_11_1

ObjSelector_Map00_11_Unlisted::
    objsel_skip_if_clear EVENT_SCENE_MERMAID_KINGDOM_022, $04, $00
    objsel_list MapObjects_Map00_11_Unlisted_1

ObjSelector_Map00_11_Unlisted_2::
    objsel_skip_if_clear EVENT_SCENE_RIVAL_DEFEATED_021, $04, $00
    objsel_list MapObjects_Map00_11_Unlisted_2_1

ObjSelector_Map00_11_Unlisted_3::
    objsel_none

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_Map00_11_Unlisted_2_1::
    db $01 ; entry 0
    db $85, $00, $3d, $00, $00, $40, $10, $05, $01, $50, $7d

; record: count, then 2 object(s), the layout of the other object lists
MapObjects_Map00_11_Unlisted_1::
    db $02 ; entry 0: object count
    db $85, $00, $3d, $00, $00, $40, $10, $05, $01, $50, $7d ; object 0
    db $86, $00, $2e, $00, $00, $20, $30, $06, $00, $60, $7e ; object 1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map00_11_1::
    db $03 ; entry 0: object count
    db $85, $00, $3d, $00, $00, $40, $10, $05, $01, $50, $7d ; object 0
    db $86, $00, $2e, $00, $00, $20, $30, $06, $00, $60, $7e ; object 1
    db $87, $00, $f8, $00, $00, $10, $40, $07, $00, $70, $d5 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map01::
    dw ObjSelector_Map01_0 ; id 0
    dw ObjSelector_Map01_1 ; id 1
    dw $0000 ; id 2
    dw $0000 ; id 3
    dw ObjSelector_Map01_4 ; id 4
    dw ObjSelector_Map01_5 ; id 5
    dw ObjSelector_Map01_6 ; id 6
    dw ObjSelector_Map01_7 ; id 7
    dw ObjSelector_Map01_8 ; id 8
    dw ObjSelector_Map01_9 ; id 9
    dw ObjSelector_Map01_10 ; id 10
    dw ObjSelector_Map01_11 ; id 11

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map01_0::
    objsel_list MapObjects_Map01_0_0

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map01_0_0::
    db $01 ; entry 0
    db $85, $01, $11, $00, $00, $20, $60, $05, $01, $50, $80

ObjSelector_Map01_1::
    objsel_list MapObjects_Map01_1_0

MapObjects_Map01_1_0::
    db $01 ; entry 0
    db $85, $01, $1a, $00, $00, $80, $40, $05, $01, $50, $da

ObjSelector_Map01_4::
    objsel_list MapObjects_Map01_4_0

MapObjects_Map01_4_0::
    db $01 ; entry 0
    db $85, $01, $19, $00, $00, $20, $60, $05, $01, $50, $22

ObjSelector_Map01_5::
    objsel_skip_if_clear EVENT_WHAT, $02, $00
    objsel_none

ObjSelector_Map01_5_Unlisted::
    objsel_unless_flag EVENT_TAKE_THIS_SLIDE_AS_A, MapObjects_Map01_5_Unlisted_0
    objsel_list MapObjects_Map01_5_Unlisted_1

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_Map01_5_Unlisted_0::
    db $02 ; entry 0: object count
    db $85, $01, $10, $00, $00, $50, $20, $05, $00, $50, $20 ; object 0
    db $86, $01, $18, $00, $00, $70, $70, $06, $03, $60, $21 ; object 1

; record: count, then 1 object(s), the layout of the other object lists
MapObjects_Map01_5_Unlisted_1::
    db $01 ; entry 0
    db $85, $01, $10, $00, $00, $50, $20, $05, $00, $50, $20

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map01_6::
    objsel_unless_flag EVENT_SCENE_MERMAID_KINGDOM_022, MapObjects_Map01_6_0
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map01_6_0::
    db $02 ; entry 0: object count
    db $85, $01, $15, $00, $00, $50, $60, $05, $02, $50, $b7 ; object 0
    db $86, $01, $12, $00, $00, $50, $70, $06, $02, $60, $b8 ; object 1

ObjSelector_Map01_7::
    objsel_skip_if_set EVENT_SCENE_LONG_FACES_002, $02, $00
    objsel_none

ObjSelector_Map01_7_Unlisted::
    objsel_list MapObjects_Map01_7_Unlisted_0

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_Map01_7_Unlisted_0::
    db $01 ; entry 0
    db $85, $01, $1a, $00, $00, $40, $60, $05, $00, $50, $ea

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map01_8::
    objsel_unless_flag EVENT_THANKS_FOR_COMING_BY, MapObjects_Map01_8_0
    objsel_unless_flag EVENT_SCENE_WARUBOU_SMELLS, MapObjects_Map01_8_1
    objsel_list MapObjects_Map01_8_0

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map01_8_0::
    db $02 ; entry 0: object count
    db $85, $01, $1b, $00, $00, $60, $70, $05, $03, $50, $12 ; object 0
    db $86, $01, $10, $00, $00, $20, $50, $06, $00, $60, $0b ; object 1

; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map01_8_1::
    db $04 ; entry 0: object count
    db $85, $01, $1b, $00, $00, $60, $70, $05, $03, $50, $12 ; object 0
    db $86, $01, $10, $00, $00, $20, $50, $06, $00, $60, $0b ; object 1
    db $87, $01, $03, $00, $00, $30, $80, $07, $02, $70, $18 ; object 2
    db $84, $01, $02, $00, $00, $40, $80, $04, $02, $40, $17 ; object 3

ObjSelector_Map01_9::
    objsel_skip_if_clear EVENT_THANKS_FOR_COMING_BY_025, $04, $00
    objsel_list MapObjects_Map01_9_1

ObjSelector_Map01_9_Unlisted::
    objsel_skip_if_clear EVENT_SCENE_THREE_ITEMS, $02, $00
    objsel_none

ObjSelector_Map01_9_Unlisted_2::
    objsel_unless_flag EVENT_SCENE_RIVAL_DEFEATED_021, MapObjects_Map01_9_Unlisted_2_0
    objsel_skip_if_set EVENT_TAKE_THIS_SLIDE_AS_A, $02, $00
    objsel_none

ObjSelector_Map01_9_Unlisted_3::
    objsel_list MapObjects_Map01_9_1

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_Map01_9_Unlisted_2_0::
    db $02 ; entry 0: object count
    db $85, $01, $1d, $00, $00, $20, $40, $05, $00, $50, $15 ; object 0
    db $86, $01, $10, $00, $00, $50, $40, $06, $00, $60, $20 ; object 1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map01_9_1::
    db $01 ; entry 0
    db $85, $01, $18, $00, $00, $70, $60, $05, $00, $50, $21

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map01_10::
    objsel_unless_flag EVENT_THANKS_FOR_COMING_BY, MapObjects_Map01_10_0
    objsel_unless_flag EVENT_SCENE_WARUBOU_SMELLS, MapObjects_Map01_10_1
    objsel_unless_flag EVENT_SCENE_RIVAL_DEFEATED_021, MapObjects_Map01_10_0
    objsel_unless_flag EVENT_SCENE_THREE_ITEMS, MapObjects_Map01_10_3
    objsel_unless_flag EVENT_THANKS_FOR_COMING_BY_025, MapObjects_Map01_10_4
    objsel_list MapObjects_Map01_10_5

; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map01_10_0::
    db $02 ; entry 0: object count
    db $85, $01, $1c, $00, $00, $50, $00, $05, $00, $50, $0c ; object 0
    db $86, $01, $1d, $00, $00, $50, $60, $06, $00, $60, $16 ; object 1

; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map01_10_1::
    db $04 ; entry 0: object count
    db $85, $01, $1c, $00, $00, $50, $00, $05, $00, $50, $0c ; object 0
    db $86, $01, $03, $00, $00, $30, $60, $06, $03, $60, $18 ; object 1
    db $87, $01, $02, $00, $00, $30, $50, $07, $03, $70, $17 ; object 2
    db $83, $01, $1d, $00, $00, $50, $60, $03, $00, $30, $16 ; object 3

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map01_10_3::
    db $03 ; entry 0: object count
    db $85, $01, $1c, $00, $00, $40, $30, $05, $00, $50, $0c ; object 0
    db $86, $01, $08, $00, $02, $e0, $e0, $06, $01, $60, $b9 ; object 1
    db $84, $01, $10, $00, $00, $e0, $50, $04, $03, $40, $00 ; object 2

; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map01_10_4::
    db $01 ; entry 0
    db $85, $01, $1c, $00, $00, $50, $60, $05, $00, $50, $0c

; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map01_10_5::
    db $02 ; entry 0: object count
    db $85, $01, $1c, $00, $00, $40, $30, $05, $00, $50, $0c ; object 0
    db $86, $01, $08, $00, $02, $30, $40, $06, $01, $60, $b9 ; object 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map01_11::
    objsel_skip_if_clear EVENT_THANKS_FOR_COMING_BY_025, $04, $00
    objsel_list MapObjects_Map01_11_1

ObjSelector_Map01_11_Unlisted::
    objsel_skip_if_clear EVENT_SCENE_THREE_ITEMS, $02, $00
    objsel_none

ObjSelector_Map01_11_Unlisted_2::
    objsel_unless_flag EVENT_SCENE_RIVAL_DEFEATED_021, MapObjects_Map01_11_Unlisted_2_0
    objsel_list MapObjects_Map01_11_1

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_Map01_11_Unlisted_2_0::
    db $01 ; entry 0
    db $85, $01, $1b, $00, $02, $40, $40, $05, $01, $50, $14

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map01_11_1::
    db $02 ; entry 0: object count
    db $85, $01, $1a, $00, $00, $30, $60, $05, $00, $50, $1e ; object 0
    db $86, $01, $10, $00, $00, $20, $40, $06, $01, $60, $eb ; object 1

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map02::
    dw ObjSelector_Map02_0 ; id 0
    dw ObjSelector_Map02_1 ; id 1
    dw ObjSelector_Map02_2 ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map02_0::
    objsel_skip_if_clear EVENT_REWARD_ITEM_OR_KEY_2, $08, $00
    objsel_unless_flag EVENT_SCENE_SHIELD2_023, MapObjects_Map02_0_1
    objsel_list MapObjects_Map02_0_2

ObjSelector_Map02_0_Unlisted::
    objsel_skip_if_clear EVENT_SCENE_MERMAID_KINGDOM_022, $04, $00
    objsel_list MapObjects_Map02_0_Unlisted_1

ObjSelector_Map02_0_Unlisted_2::
    objsel_skip_if_clear EVENT_SCENE_RIVAL_DEFEATED_021, $04, $00
    objsel_list MapObjects_Map02_0_Unlisted_2_1

ObjSelector_Map02_0_Unlisted_3::
    objsel_unless_flag EVENT_HERO_RECEIVED_THE_GREAT_LOG, MapObjects_Map02_0_Unlisted_3_0
    objsel_none

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_Map02_0_Unlisted_3_0::
    db $03 ; entry 0: object count
    db $85, $01, $15, $00, $00, $60, $50, $05, $02, $50, $10 ; object 0
    db $86, $01, $03, $00, $00, $e0, $40, $06, $01, $60, $00 ; object 1
    db $87, $01, $02, $00, $00, $e0, $10, $07, $00, $70, $00 ; object 2

; record: count, then 2 object(s), the layout of the other object lists
MapObjects_Map02_0_Unlisted_2_1::
    db $02 ; entry 0: object count
    db $85, $01, $1d, $00, $00, $40, $30, $05, $00, $50, $15 ; object 0
    db $86, $01, $1d, $00, $00, $40, $40, $06, $02, $60, $16 ; object 1

; record: count, then 4 object(s), the layout of the other object lists
MapObjects_Map02_0_Unlisted_1::
    db $04 ; entry 0: object count
    db $85, $01, $15, $00, $00, $60, $50, $05, $02, $50, $10 ; object 0
    db $85, $01, $15, $00, $00, $20, $40, $05, $03, $50, $7f ; object 1
    db $86, $01, $57, $00, $00, $80, $60, $06, $02, $60, $00 ; object 2
    db $87, $00, $b9, $00, $00, $20, $e0, $07, $01, $70, $cd ; object 3

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map02_0_1::
    db $04 ; entry 0: object count
    db $85, $01, $15, $00, $00, $60, $50, $05, $02, $50, $10 ; object 0
    db $85, $01, $15, $00, $00, $20, $50, $05, $03, $50, $7f ; object 1
    db $86, $01, $57, $00, $00, $80, $60, $06, $02, $60, $00 ; object 2
    db $87, $00, $b9, $00, $02, $40, $40, $07, $01, $70, $cd ; object 3

MapObjects_Map02_0_2::
    db $04 ; entry 0: object count
    db $85, $01, $15, $00, $00, $60, $50, $05, $02, $50, $10 ; object 0
    db $85, $01, $15, $00, $00, $10, $40, $05, $01, $50, $7f ; object 1
    db $86, $01, $57, $00, $00, $80, $60, $06, $02, $60, $00 ; object 2
    db $87, $00, $b9, $00, $00, $20, $50, $07, $01, $70, $cd ; object 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map02_1::
    objsel_unless_flag EVENT_SCENE_RIVAL_DEFEATED_021, MapObjects_Map02_1_0
    objsel_list MapObjects_Map02_1_1

; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map02_1_0::
    db $02 ; entry 0: object count
    db $85, $01, $15, $00, $00, $40, $10, $05, $00, $50, $11 ; object 0
    db $86, $01, $1c, $00, $00, $10, $50, $06, $00, $60, $aa ; object 1

; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map02_1_1::
    db $03 ; entry 0: object count
    db $85, $01, $15, $00, $00, $40, $10, $05, $00, $50, $11 ; object 0
    db $86, $01, $1d, $00, $02, $50, $30, $06, $03, $60, $0f ; object 1
    db $87, $01, $1c, $00, $00, $10, $50, $07, $00, $70, $aa ; object 2

ObjSelector_Map02_2::
    objsel_skip_if_clear EVENT_THANKS_FOR_COMING_BY_025, $04, $00
    objsel_list MapObjects_Map02_2_1

ObjSelector_Map02_2_Unlisted::
    objsel_skip_if_clear EVENT_SCENE_THREE_ITEMS, $04, $00
    objsel_list MapObjects_Map02_2_Unlisted_1

ObjSelector_Map02_2_Unlisted_2::
    objsel_unless_flag EVENT_OH_ITS_ALL_SPINNING_AROUND, MapObjects_Map02_2_Unlisted_2_0
    objsel_unless_flag EVENT_SCENE_MERMAID_KINGDOM_022, MapObjects_Map02_2_Unlisted_2_1
    objsel_list MapObjects_Map02_2_1

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_Map02_2_Unlisted_2_0::
    db $03 ; entry 0: object count
    db $85, $01, $1d, $00, $00, $40, $40, $05, $02, $50, $0e ; object 0
    db $86, $01, $02, $00, $00, $50, $30, $06, $01, $60, $00 ; object 1
    db $87, $01, $03, $00, $00, $40, $30, $07, $01, $70, $00 ; object 2

; record: count, then 1 object(s), the layout of the other object lists
MapObjects_Map02_2_Unlisted_2_1::
    db $01 ; entry 0
    db $85, $01, $1d, $00, $00, $40, $40, $05, $00, $50, $0e

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map02_2_1::
    db $03 ; entry 0: object count
    db $85, $01, $1d, $00, $00, $40, $40, $05, $00, $50, $0e ; object 0
    db $86, $01, $1d, $00, $00, $20, $50, $06, $00, $60, $15 ; object 1
    db $84, $01, $1d, $00, $00, $20, $60, $04, $02, $40, $16 ; object 2

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_Map02_2_Unlisted_1::
    db $02 ; entry 0: object count
    db $85, $01, $1d, $00, $00, $40, $30, $05, $00, $50, $15 ; object 0
    db $86, $01, $1d, $00, $00, $40, $40, $06, $02, $60, $16 ; object 1

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map04::
    dw ObjSelector_Map04_0 ; id 0
    dw ObjSelector_Map04_1 ; id 1
    dw ObjSelector_Map04_2 ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map04_0::
    objsel_list MapObjects_Map04_0_0

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map04_0_0::
    db $03 ; entry 0: object count
    db $85, $01, $16, $00, $00, $40, $10, $05, $01, $50, $64 ; object 0
    db $86, $01, $11, $00, $00, $50, $20, $06, $02, $60, $c3 ; object 1
    db $87, $01, $10, $00, $00, $60, $10, $07, $03, $70, $c4 ; object 2

ObjSelector_Map04_1::
    objsel_list MapObjects_Map04_1_0

; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map04_1_0::
    db $02 ; entry 0: object count
    db $85, $01, $17, $00, $00, $40, $10, $05, $00, $50, $00 ; object 0
    db $86, $01, $17, $00, $00, $50, $10, $06, $00, $60, $00 ; object 1

ObjSelector_Map04_2::
    objsel_skip_if_clear EVENT_THANKS_FOR_COMING_BY_025, $0c, $00
    objsel_unless_flag EVENT_MAP_04_OBJECT_REMOVED, MapObjects_Map04_2_1
    objsel_unless_flag EVENT_MAP_04_OBJECT_REMOVED_0CC, MapObjects_Map04_2_2
    objsel_list MapObjects_Map04_2_3

ObjSelector_Map04_2_Unlisted::
    objsel_skip_if_set EVENT_SCENE_MERMAID_KINGDOM_022, $04, $00
    objsel_list MapObjects_Map04_2_Unlisted_1

ObjSelector_Map04_2_Unlisted_2::
    objsel_unless_flag EVENT_SCENE_SHIELD2_023, MapObjects_Map04_2_Unlisted_2_0
    objsel_list MapObjects_Map04_2_Unlisted_2_1

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_Map04_2_Unlisted_1::
    db $03 ; entry 0: object count
    db $85, $01, $11, $00, $00, $50, $20, $05, $00, $50, $66 ; object 0
    db $86, $00, $fa, $00, $00, $60, $40, $06, $00, $60, $67 ; object 1
    db $87, $00, $f8, $00, $00, $60, $50, $07, $02, $70, $68 ; object 2

MapObjects_Map04_2_Unlisted_2_0::
    db $03 ; entry 0: object count
    db $85, $01, $22, $00, $00, $50, $20, $05, $00, $50, $8e ; object 0
    db $86, $00, $58, $00, $00, $60, $40, $06, $00, $60, $67 ; object 1
    db $87, $00, $e5, $00, $00, $60, $50, $07, $02, $70, $68 ; object 2

MapObjects_Map04_2_Unlisted_2_1::
    db $03 ; entry 0: object count
    db $85, $01, $28, $00, $00, $50, $20, $05, $00, $50, $9c ; object 0
    db $86, $00, $06, $01, $00, $60, $40, $06, $00, $60, $67 ; object 1
    db $87, $00, $52, $01, $00, $60, $50, $07, $02, $70, $68 ; object 2

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map04_2_1::
    db $03 ; entry 0: object count
    db $85, $01, $2e, $00, $00, $50, $20, $05, $00, $50, $f1 ; object 0
    db $86, $00, $7b, $00, $00, $60, $40, $06, $00, $60, $67 ; object 1
    db $87, $00, $2e, $01, $00, $60, $50, $07, $02, $70, $68 ; object 2

MapObjects_Map04_2_2::
    db $03 ; entry 0: object count
    db $85, $01, $14, $00, $00, $50, $20, $05, $00, $50, $f1 ; object 0
    db $86, $00, $32, $01, $00, $60, $40, $06, $00, $60, $36 ; object 1
    db $87, $00, $31, $01, $00, $60, $50, $07, $02, $70, $37 ; object 2

MapObjects_Map04_2_3::
    db $03 ; entry 0: object count
    db $85, $01, $5f, $00, $00, $50, $20, $05, $00, $50, $f2 ; object 0
    db $86, $00, $a5, $00, $00, $60, $40, $06, $00, $60, $28 ; object 1
    db $87, $00, $ee, $00, $00, $60, $50, $07, $02, $70, $29 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map05::
    dw $0000 ; id 0
    dw ObjSelector_Map05_1 ; id 1
    dw $0000 ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map05_1::
    objsel_skip_if_clear EVENT_THANKS_FOR_COMING_BY_025, $04, $00
    objsel_list MapObjects_Map05_1_1

ObjSelector_Map05_1_Unlisted::
    objsel_skip_if_clear EVENT_STAFF_ROLL_PARTY_SAVED, $04, $00
    objsel_list MapObjects_Map05_1_Unlisted_1

ObjSelector_Map05_1_Unlisted_2::
    objsel_skip_if_clear EVENT_SCENE_DARCK_DEFEATED, $04, $00
    objsel_list MapObjects_Map05_1_Unlisted_2_1

ObjSelector_Map05_1_Unlisted_3::
    objsel_skip_if_clear EVENT_SCENE_THREE_ITEMS, $04, $00
    objsel_unless_flag EVENT_SCENE_THREE_ITEMS_0C3, MapObjects_Map05_1_Unlisted_3_1
    objsel_skip_if_clear EVENT_SCENE_WARUBOU_FOOD2_00C, $0e, $00
    objsel_skip_if_clear EVENT_WARUBOU_OBJECTS_GATE, $04, $00
    objsel_unless_flag EVENT_SCRIPT_COMMAND20_TURNED, MapObjects_Map05_1_Unlisted_3_4
    objsel_list MapObjects_Map05_1_Unlisted_3_5

ObjSelector_Map05_1_Unlisted_4::
    objsel_unless_flag EVENT_SCENE_WARUBOU_SMELLS, MapObjects_Map05_1_Unlisted_4_0
    objsel_unless_flag EVENT_SCENE_WARUBOU_FOOD2, MapObjects_Map05_1_Unlisted_1
    objsel_list MapObjects_Map05_1_Unlisted_4_2

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_Map05_1_Unlisted_4_0::
    db $01 ; entry 0
    db $85, $01, $4a, $00, $00, $40, $30, $05, $00, $50, $a9

; record: count, then 3 object(s), the layout of the other object lists
MapObjects_Map05_1_Unlisted_1::
    db $03 ; entry 0: object count
    db $85, $01, $4a, $00, $00, $40, $30, $05, $00, $50, $a9 ; object 0
    db $86, $01, $02, $00, $00, $78, $30, $06, $03, $60, $19 ; object 1
    db $87, $01, $03, $00, $00, $58, $30, $07, $01, $70, $00 ; object 2

; record: count, then 2 object(s), the layout of the other object lists
MapObjects_Map05_1_Unlisted_4_2::
    db $02 ; entry 0: object count
    db $85, $01, $02, $00, $00, $80, $30, $05, $00, $50, $19 ; object 0
    db $86, $01, $03, $00, $00, $40, $40, $06, $02, $60, $00 ; object 1

MapObjects_Map05_1_Unlisted_3_5::
    db $01 ; entry 0
    db $85, $01, $49, $00, $00, $40, $30, $05, $00, $50, $19

MapObjects_Map05_1_Unlisted_3_1::
    db $02 ; entry 0: object count
    db $85, $01, $49, $00, $00, $40, $30, $05, $01, $50, $19 ; object 0
    db $86, $01, $03, $00, $00, $50, $40, $06, $03, $60, $00 ; object 1

MapObjects_Map05_1_Unlisted_2_1::
    db $02 ; entry 0: object count
    db $85, $01, $49, $00, $00, $40, $30, $05, $00, $50, $19 ; object 0
    db $86, $01, $4a, $00, $00, $40, $e0, $06, $00, $60, $00 ; object 1

MapObjects_Map05_1_Unlisted_3_4::
    db $01 ; entry 0
    db $85, $01, $49, $00, $00, $e0, $30, $05, $00, $50, $19

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map05_1_1::
    db $03 ; entry 0: object count
    db $85, $01, $4a, $00, $00, $e0, $e0, $05, $00, $50, $a9 ; object 0
    db $86, $01, $02, $00, $00, $50, $20, $06, $00, $60, $19 ; object 1
    db $87, $01, $02, $00, $00, $e0, $e0, $07, $00, $70, $19 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map06::
    dw ObjSelector_Map06_0 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map06_0::
    objsel_skip_if_clear EVENT_THANKS_FOR_COMING_BY_025, $04, $00
    objsel_list MapObjects_Map06_0_1

ObjSelector_Map06_0_Unlisted::
    objsel_skip_if_set EVENT_SCENE_LONG_FACES_002, $08, $00
    objsel_unless_flag EVENT_HERO_RECEIVED_THE_GREAT_LOG_017, MapObjects_Map06_0_1
    objsel_list MapObjects_Map06_0_Unlisted_2

ObjSelector_Map06_0_Unlisted_2::
    objsel_skip_if_clear EVENT_COBI_HERO_WHILE_YOURE, $0c, $00
    objsel_unless_flag EVENT_SCENE_RIVAL_DEFEATED_021, MapObjects_Map06_0_1
    objsel_unless_flag EVENT_OH_YOU_BOUGHT_THE_LOVE, MapObjects_Map06_0_Unlisted_2_2
    objsel_list MapObjects_Map06_0_1

ObjSelector_Map06_0_Unlisted_3::
    objsel_unless_flag EVENT_IN_THE_MIDDLE_OF_THE, MapObjects_Map06_0_Unlisted_3_0
    objsel_list MapObjects_Map06_0_Unlisted_3_1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map06_0_1::
    db $01 ; entry 0
    db $85, $01, $05, $00, $00, $40, $30, $05, $00, $50, $02

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_Map06_0_Unlisted_3_0::
    db $02 ; entry 0: object count
    db $85, $01, $05, $00, $00, $40, $30, $05, $00, $50, $02 ; object 0
    db $86, $01, $00, $00, $00, $70, $70, $06, $03, $60, $1b ; object 1

MapObjects_Map06_0_Unlisted_3_1::
    db $02 ; entry 0: object count
    db $85, $01, $05, $00, $00, $40, $30, $05, $00, $50, $02 ; object 0
    db $86, $01, $01, $00, $00, $70, $70, $06, $03, $60, $1c ; object 1

; record: count, then 1 object(s), the layout of the other object lists
MapObjects_Map06_0_Unlisted_2::
    db $01 ; entry 0
    db $85, $00, $0a, $00, $00, $50, $a0, $05, $00, $50, $08

MapObjects_Map06_0_Unlisted_2_2::
    db $02 ; entry 0: object count
    db $85, $01, $05, $00, $00, $40, $30, $05, $00, $50, $02 ; object 0
    db $86, $00, $01, $00, $00, $20, $10, $06, $02, $60, $1a ; object 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map06_0_Unlisted_4::
    objsel_list MapObjects_Map06_0_Unlisted_4_0

; record: count, then 4 object(s), the layout of the other object lists
MapObjects_Map06_0_Unlisted_4_0::
    db $04 ; entry 0: object count
    db $85, $01, $4a, $00, $00, $40, $30, $05, $00, $50, $9f ; object 0
    db $85, $01, $4a, $00, $00, $60, $40, $05, $00, $50, $cf ; object 1
    db $85, $01, $4a, $00, $00, $70, $50, $05, $03, $50, $0d ; object 2
    db $86, $01, $5f, $00, $00, $70, $70, $06, $03, $60, $a7 ; object 3

ObjSelector_Map06_0_Unlisted_5::
    objsel_list MapObjects_Map06_0_Unlisted_5_0

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_Map06_0_Unlisted_5_0::
    db $03 ; entry 0: object count
    db $85, $01, $40, $00, $00, $40, $30, $05, $00, $50, $a4 ; object 0
    db $86, $01, $15, $00, $00, $60, $20, $06, $00, $60, $a6 ; object 1
    db $87, $01, $10, $00, $00, $70, $10, $07, $00, $70, $ac ; object 2

ObjSelector_Map06_0_Unlisted_6::
    objsel_list MapObjects_Map06_0_Unlisted_6_0

MapObjects_Map06_0_Unlisted_6_0::
    db $03 ; entry 0: object count
    db $85, $00, $7e, $01, $00, $40, $30, $05, $00, $50, $35 ; object 0
    db $86, $00, $7d, $01, $00, $20, $40, $06, $00, $60, $34 ; object 1
    db $87, $00, $7c, $01, $00, $60, $50, $07, $00, $70, $33 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map07::
    dw ObjSelector_Map07_0 ; id 0
    dw ObjSelector_Map07_1 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map07_0::
    objsel_list MapObjects_Map07_0_0

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map07_0_0::
    db $03 ; entry 0: object count
    db $85, $00, $93, $00, $00, $40, $30, $05, $01, $50, $4c ; object 0
    db $86, $00, $5e, $00, $00, $30, $70, $06, $00, $60, $4d ; object 1
    db $87, $00, $76, $00, $00, $80, $50, $07, $00, $70, $b5 ; object 2

ObjSelector_Map07_1::
    objsel_list MapObjects_Map07_1_0

MapObjects_Map07_1_0::
    db $03 ; entry 0: object count
    db $85, $00, $4e, $01, $00, $50, $40, $05, $03, $50, $4e ; object 0
    db $86, $00, $8e, $00, $00, $20, $50, $06, $01, $60, $4f ; object 1
    db $87, $00, $77, $00, $00, $50, $70, $07, $02, $70, $b6 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map08::
    dw ObjSelector_Map08_0 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map08_0::
    objsel_unless_flag EVENT_SCENE_LONG_FACES_002, MapObjects_Map08_0_0
    objsel_list MapObjects_Map08_0_1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map08_0_0::
    db $01 ; entry 0
    db $85, $01, $15, $00, $00, $40, $20, $05, $00, $50, $14

; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map08_0_1::
    db $02 ; entry 0: object count
    db $85, $01, $15, $00, $00, $40, $20, $05, $00, $50, $14 ; object 0
    db $86, $01, $10, $00, $00, $60, $60, $06, $00, $60, $1d ; object 1

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map09::
    dw ObjSelector_Map09_0 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map09_0::
    objsel_list MapObjects_Map09_0_0

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map09_0_0::
    db $04 ; entry 0: object count
    db $85, $01, $1c, $00, $00, $30, $20, $05, $00, $50, $92 ; object 0
    db $86, $01, $1a, $00, $00, $20, $60, $06, $03, $60, $93 ; object 1
    db $86, $01, $1a, $00, $00, $60, $50, $06, $00, $60, $94 ; object 2
    db $87, $01, $10, $00, $00, $50, $70, $07, $02, $70, $e9 ; object 3

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map0A::
    dw ObjSelector_Map0A_0 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map0A_0::
    objsel_list MapObjects_Map0A_0_0

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map0A_0_0::
    db $03 ; entry 0: object count
    db $85, $01, $2a, $00, $00, $50, $30, $05, $00, $50, $69 ; object 0
    db $86, $01, $15, $00, $00, $10, $60, $06, $01, $60, $b7 ; object 1
    db $87, $01, $12, $00, $00, $70, $50, $07, $00, $70, $b8 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map0B::
    dw ObjSelector_Map0B_0 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map0B_0::
    objsel_list MapObjects_Map0B_0_0

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map0B_0_0::
    db $04 ; entry 0: object count
    db $84, $01, $00, $00, $00, $70, $30, $04, $03, $40, $00 ; object 0
    db $85, $00, $01, $00, $00, $60, $40, $05, $03, $50, $00 ; object 1
    db $86, $00, $01, $00, $00, $60, $30, $06, $03, $60, $00 ; object 2
    db $87, $00, $01, $00, $00, $60, $20, $07, $03, $70, $00 ; object 3

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map0C::
    dw ObjSelector_Map0C_0 ; id 0
    dw ObjSelector_Map0C_1 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map0C_0::
    objsel_skip_if_clear EVENT_THANKS_FOR_COMING_BY_025, $04, $00
    objsel_list MapObjects_Map0C_0_1

ObjSelector_Map0C_0_Unlisted::
    objsel_unless_flag EVENT_SCENE_THREE_ITEMS, MapObjects_Map0C_0_1
    objsel_none

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map0C_0_1::
    db $02 ; entry 0: object count
    db $85, $01, $1e, $00, $00, $40, $70, $05, $02, $50, $25 ; object 0
    db $86, $01, $1f, $00, $00, $40, $60, $06, $00, $60, $26 ; object 1

ObjSelector_Map0C_1::
    objsel_skip_if_clear EVENT_THANKS_FOR_COMING_BY_025, $04, $00
    objsel_list MapObjects_Map0C_1_1

ObjSelector_Map0C_1_Unlisted::
    objsel_unless_flag EVENT_SCENE_THREE_ITEMS, MapObjects_Map0C_1_1
    objsel_list MapObjects_Map0C_1_Unlisted_1

MapObjects_Map0C_1_1::
    db $02 ; entry 0: object count
    db $85, $01, $10, $00, $00, $50, $30, $05, $00, $50, $23 ; object 0
    db $86, $01, $10, $00, $00, $60, $70, $06, $03, $60, $24 ; object 1

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_Map0C_1_Unlisted_1::
    db $02 ; entry 0: object count
    db $85, $01, $10, $00, $00, $40, $50, $05, $00, $50, $23 ; object 0
    db $86, $01, $10, $00, $00, $50, $50, $06, $00, $60, $24 ; object 1

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map0D::
    dw $0000 ; id 0
    dw ObjSelector_Map0D_1 ; id 1
    dw $0000 ; id 2
    dw $0000 ; id 3
    dw $0000 ; id 4
    dw ObjSelector_Map0D_5 ; id 5
    dw ObjSelector_Map0D_6 ; id 6
    dw $0000 ; id 7

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map0D_1::
    objsel_list MapObjects_Map0D_1_0

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map0D_1_0::
    db $02 ; entry 0: object count
    db $85, $01, $0c, $00, $00, $40, $30, $05, $00, $50, $6a ; object 0
    db $86, $01, $18, $00, $00, $60, $60, $06, $03, $60, $6b ; object 1

ObjSelector_Map0D_5::
    objsel_list MapObjects_Map0D_5_0

; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map0D_5_0::
    db $04 ; entry 0: object count
    db $85, $01, $12, $00, $00, $30, $40, $05, $03, $50, $70 ; object 0
    db $86, $01, $10, $00, $00, $20, $30, $06, $00, $60, $6f ; object 1
    db $86, $01, $10, $00, $02, $20, $50, $06, $02, $60, $71 ; object 2
    db $84, $01, $11, $00, $02, $70, $20, $04, $01, $40, $e3 ; object 3

ObjSelector_Map0D_6::
    objsel_unless_flag EVENT_THANKS_FOR_COMING_BY_025, MapObjects_Map0D_6_0
    objsel_none

; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map0D_6_0::
    db $01 ; entry 0
    db $85, $01, $16, $00, $00, $40, $60, $05, $01, $50, $a8

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map0E::
    dw ObjSelector_Map0E_0 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map0E_0::
    objsel_list MapObjects_Map0E_0_0

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map0E_0_0::
    db $04 ; entry 0: object count
    db $85, $01, $1c, $00, $00, $70, $40, $05, $03, $50, $38 ; object 0
    db $86, $01, $1d, $00, $00, $60, $50, $06, $02, $60, $39 ; object 1
    db $87, $01, $18, $00, $00, $20, $20, $07, $00, $70, $3a ; object 2
    db $87, $01, $18, $00, $00, $40, $10, $07, $00, $70, $b0 ; object 3

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map0F::
    dw ObjSelector_Map0F_0 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map0F_0::
    objsel_skip_if_clear EVENT_THANKS_FOR_COMING_BY_025, $04, $00
    objsel_list MapObjects_Map0F_0_1

ObjSelector_Map0F_0_Unlisted::
    objsel_unless_flag EVENT_SCENE_THREE_ITEMS, MapObjects_Map0F_0_Unlisted_0
    objsel_none

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_Map0F_0_Unlisted_0::
    db $01 ; entry 0
    db $85, $01, $1a, $00, $00, $10, $20, $05, $00, $50, $3e

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map0F_0_1::
    db $02 ; entry 0: object count
    db $85, $01, $1b, $00, $00, $20, $40, $05, $02, $50, $42 ; object 0
    db $86, $01, $1a, $00, $00, $30, $30, $06, $03, $60, $3e ; object 1

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map10::
    dw ObjSelector_Map10_0 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map10_0::
    objsel_unless_flag EVENT_SCENE_THREE_ITEMS, MapObjects_Map10_0_0
    objsel_list MapObjects_Map10_0_1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map10_0_0::
    db $01 ; entry 0
    db $85, $01, $1b, $00, $00, $60, $50, $05, $01, $50, $42

; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map10_0_1::
    db $02 ; entry 0: object count
    db $85, $01, $1b, $00, $00, $60, $40, $05, $00, $50, $42 ; object 0
    db $86, $01, $1a, $00, $00, $60, $50, $06, $02, $60, $3e ; object 1

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map11::
    dw ObjSelector_Map11_0 ; id 0
    dw ObjSelector_Map11_1 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map11_0::
    objsel_list MapObjects_Map11_0_0

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map11_0_0::
    db $02 ; entry 0: object count
    db $85, $01, $1b, $00, $00, $50, $30, $05, $00, $50, $2b ; object 0
    db $86, $01, $18, $00, $00, $10, $40, $06, $01, $60, $af ; object 1

ObjSelector_Map11_1::
    objsel_list MapObjects_Map11_1_0

; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map11_1_0::
    db $04 ; entry 0: object count
    db $85, $01, $1b, $00, $00, $40, $20, $05, $00, $50, $29 ; object 0
    db $86, $01, $1a, $00, $00, $30, $40, $06, $03, $60, $2c ; object 1
    db $87, $01, $11, $00, $02, $60, $60, $07, $01, $70, $2a ; object 2
    db $85, $01, $1b, $00, $00, $80, $70, $05, $03, $50, $ae ; object 3

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map12::
    dw ObjSelector_Map12_0 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map12_0::
    objsel_skip_if_clear EVENT_THANKS_FOR_COMING_BY_025, $04, $00
    objsel_list MapObjects_Map12_0_1

ObjSelector_Map12_0_Unlisted::
    objsel_unless_flag EVENT_SCENE_MASTER_THANKS, MapObjects_Map12_0_Unlisted_0
    objsel_list MapObjects_Map12_0_1

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_Map12_0_Unlisted_0::
    db $03 ; entry 0: object count
    db $85, $00, $02, $00, $00, $e0, $30, $05, $00, $50, $ad ; object 0
    db $86, $01, $1e, $00, $00, $60, $60, $06, $00, $60, $77 ; object 1
    db $87, $01, $19, $00, $00, $40, $40, $07, $01, $70, $27 ; object 2

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map12_0_1::
    db $03 ; entry 0: object count
    db $85, $01, $1e, $00, $00, $60, $60, $05, $00, $50, $77 ; object 0
    db $86, $01, $19, $00, $00, $40, $40, $06, $02, $60, $27 ; object 1
    db $87, $00, $02, $00, $00, $40, $30, $07, $00, $70, $ad ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map13::
    dw ObjSelector_Map13_0 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map13_0::
    objsel_list MapObjects_Map13_0_0

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map13_0_0::
    db $01 ; entry 0
    db $85, $01, $21, $00, $00, $40, $30, $05, $00, $50, $46

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map14::
    dw ObjSelector_Map14_0 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map14_0::
    objsel_list MapObjects_Map14_0_0

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map14_0_0::
    db $03 ; entry 0: object count
    db $85, $01, $0c, $00, $00, $50, $90, $05, $02, $50, $00 ; object 0
    db $86, $00, $01, $00, $00, $50, $a0, $06, $00, $60, $00 ; object 1
    db $87, $00, $01, $00, $00, $50, $a0, $07, $00, $70, $00 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map15::
    dw ObjSelector_Map15_0 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map15_0::
    objsel_unless_flag EVENT_DESK_KEY, MapObjects_Map15_0_0
    objsel_unless_flag EVENT_SCENE_CHEST_BATTLE, MapObjects_Map15_0_1
    objsel_unless_flag EVENT_SCENE_CHEST_BATTLE_207, MapObjects_Map15_0_1
    objsel_unless_flag EVENT_THAT_KEY_IUSED_03E, MapObjects_Map15_0_0
    objsel_unless_flag EVENT_DESK_KEY_0C8, MapObjects_Map15_0_4
    objsel_list MapObjects_Map15_0_1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map15_0_0::
    db $02 ; entry 0: object count
    db $85, $01, $1e, $00, $00, $50, $30, $05, $00, $50, $8f ; object 0
    db $86, $01, $5d, $00, $00, $60, $08, $06, $00, $60, $db ; object 1

MapObjects_Map15_0_4::
    db $02 ; entry 0: object count
    db $85, $01, $1e, $00, $00, $40, $30, $05, $00, $50, $8f ; object 0
    db $86, $01, $5d, $00, $00, $60, $08, $06, $00, $60, $db ; object 1

; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map15_0_1::
    db $01 ; entry 0
    db $85, $01, $1e, $00, $00, $50, $30, $05, $00, $50, $8f

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map16::
    dw ObjSelector_Map16_0 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map16_0::
    objsel_list MapObjects_Map16_0_0

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map16_0_0::
    db $03 ; entry 0: object count
    db $85, $01, $1e, $00, $00, $60, $30, $05, $00, $50, $72 ; object 0
    db $86, $01, $1f, $00, $00, $30, $60, $06, $00, $60, $73 ; object 1
    db $87, $00, $11, $00, $00, $40, $20, $07, $01, $70, $d0 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map17::
    dw ObjSelector_Map17_0 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map17_0::
    objsel_skip_if_clear EVENT_THANKS_FOR_COMING_BY_025, $0c, $00
    objsel_unless_flag EVENT_MAP_17_OBJECT_REMOVED, MapObjects_Map17_0_1
    objsel_unless_flag EVENT_MAP_17_OBJECT_REMOVED_0CA, MapObjects_Map17_0_2
    objsel_list MapObjects_Map17_0_3

ObjSelector_Map17_0_Unlisted::
    objsel_unless_flag EVENT_SCENE_THREE_ITEMS, MapObjects_Map17_0_Unlisted_0
    objsel_list MapObjects_Map17_0_Unlisted_1

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 4 object(s), the layout of the other object lists
MapObjects_Map17_0_Unlisted_0::
    db $04 ; entry 0: object count
    db $87, $01, $15, $00, $00, $40, $30, $07, $03, $70, $89 ; object 0
    db $85, $01, $16, $00, $00, $70, $40, $05, $03, $50, $86 ; object 1
    db $85, $01, $16, $00, $00, $10, $60, $05, $02, $50, $87 ; object 2
    db $86, $01, $12, $00, $00, $50, $50, $06, $01, $60, $88 ; object 3

MapObjects_Map17_0_Unlisted_1::
    db $04 ; entry 0: object count
    db $87, $01, $21, $00, $00, $40, $30, $07, $03, $70, $89 ; object 0
    db $85, $01, $16, $00, $00, $70, $40, $05, $03, $50, $86 ; object 1
    db $85, $01, $16, $00, $00, $10, $60, $05, $02, $50, $87 ; object 2
    db $86, $01, $12, $00, $00, $50, $50, $06, $01, $60, $88 ; object 3

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map17_0_1::
    db $04 ; entry 0: object count
    db $87, $01, $2a, $00, $00, $40, $30, $07, $03, $70, $f0 ; object 0
    db $85, $01, $16, $00, $00, $70, $40, $05, $03, $50, $86 ; object 1
    db $85, $01, $16, $00, $00, $10, $60, $05, $02, $50, $87 ; object 2
    db $86, $01, $12, $00, $00, $50, $50, $06, $01, $60, $88 ; object 3

MapObjects_Map17_0_2::
    db $04 ; entry 0: object count
    db $87, $01, $13, $00, $00, $40, $30, $07, $03, $70, $f0 ; object 0
    db $85, $01, $16, $00, $00, $70, $40, $05, $03, $50, $86 ; object 1
    db $85, $01, $16, $00, $00, $10, $60, $05, $02, $50, $87 ; object 2
    db $86, $01, $12, $00, $00, $50, $50, $06, $01, $60, $88 ; object 3

MapObjects_Map17_0_3::
    db $04 ; entry 0: object count
    db $87, $01, $17, $00, $00, $40, $30, $07, $03, $70, $f0 ; object 0
    db $85, $01, $16, $00, $00, $70, $40, $05, $03, $50, $86 ; object 1
    db $85, $01, $16, $00, $00, $10, $60, $05, $02, $50, $87 ; object 2
    db $86, $01, $12, $00, $00, $50, $50, $06, $01, $60, $88 ; object 3

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map18::
    dw ObjSelector_Map18_0 ; id 0
    dw ObjSelector_Map18_1 ; id 1
    dw ObjSelector_Map18_2 ; id 2
    dw ObjSelector_Map18_3 ; id 3
    dw ObjSelector_Map18_4 ; id 4
    dw ObjSelector_Map18_5 ; id 5

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map18_0::
    objsel_list MapObjects_Map18_0_0

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map18_0_0::
    db $04 ; entry 0: object count
    db $85, $01, $19, $00, $00, $40, $40, $05, $00, $50, $56 ; object 0
    db $86, $00, $55, $00, $00, $40, $50, $06, $02, $60, $57 ; object 1
    db $87, $01, $1d, $00, $00, $70, $60, $07, $00, $70, $bb ; object 2
    db $85, $01, $07, $00, $02, $60, $70, $05, $01, $50, $bc ; object 3

ObjSelector_Map18_1::
    objsel_list MapObjects_Map18_1_0

; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map18_1_0::
    db $03 ; entry 0: object count
    db $85, $01, $1b, $00, $00, $70, $60, $05, $00, $50, $61 ; object 0
    db $86, $01, $1e, $00, $00, $50, $50, $06, $02, $60, $bd ; object 1
    db $87, $01, $06, $00, $02, $20, $70, $07, $01, $70, $be ; object 2

ObjSelector_Map18_2::
    objsel_list MapObjects_Map18_2_0

MapObjects_Map18_2_0::
    db $04 ; entry 0: object count
    db $85, $01, $1e, $00, $00, $10, $40, $05, $00, $50, $5b ; object 0
    db $86, $01, $1f, $00, $00, $20, $50, $06, $03, $60, $bf ; object 1
    db $87, $01, $10, $00, $02, $30, $60, $07, $01, $70, $5c ; object 2
    db $85, $01, $1e, $00, $00, $70, $70, $05, $03, $50, $c0 ; object 3

ObjSelector_Map18_3::
    objsel_list MapObjects_Map18_3_0

MapObjects_Map18_3_0::
    db $03 ; entry 0: object count
    db $85, $01, $12, $00, $00, $60, $20, $05, $00, $50, $58 ; object 0
    db $86, $00, $91, $00, $00, $50, $30, $06, $01, $60, $59 ; object 1
    db $87, $00, $33, $00, $00, $60, $40, $07, $02, $70, $5a ; object 2

ObjSelector_Map18_4::
    objsel_list MapObjects_Map18_4_0

MapObjects_Map18_4_0::
    db $03 ; entry 0: object count
    db $85, $01, $15, $00, $00, $50, $20, $05, $00, $50, $5d ; object 0
    db $86, $00, $5f, $00, $00, $60, $40, $06, $03, $60, $5f ; object 1
    db $87, $00, $26, $01, $02, $20, $50, $07, $01, $70, $60 ; object 2

ObjSelector_Map18_5::
    objsel_list MapObjects_Map18_5_0

MapObjects_Map18_5_0::
    db $04 ; entry 0: object count
    db $85, $01, $1c, $00, $00, $50, $50, $05, $03, $50, $55 ; object 0
    db $86, $01, $1d, $00, $00, $20, $30, $06, $00, $60, $5e ; object 1
    db $85, $01, $1c, $00, $00, $20, $40, $05, $02, $50, $c1 ; object 2
    db $87, $01, $1b, $00, $02, $40, $20, $07, $01, $70, $c2 ; object 3

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map19::
    dw ObjSelector_Map19_0 ; id 0
    dw $0000 ; id 1
    dw ObjSelector_Map19_2 ; id 2
    dw ObjSelector_Map19_3 ; id 3
    dw ObjSelector_Map19_4 ; id 4
    dw $0000 ; id 5

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map19_0::
    objsel_skip_if_clear EVENT_THANKS_FOR_COMING_BY_025, $04, $00
    objsel_list MapObjects_Map19_0_1

ObjSelector_Map19_0_Unlisted::
    objsel_skip_if_clear EVENT_SCENE_DARCK_DEFEATED, $04, $00
    objsel_list MapObjects_Map19_0_Unlisted_1

ObjSelector_Map19_0_Unlisted_2::
    objsel_unless_flag EVENT_WHAT, MapObjects_Map19_0_Unlisted_2_0
    objsel_list MapObjects_Map19_0_1

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_Map19_0_Unlisted_2_0::
    db $02 ; entry 0: object count
    db $85, $01, $3b, $00, $00, $40, $20, $05, $00, $50, $81 ; object 0
    db $86, $01, $12, $00, $00, $60, $30, $06, $03, $60, $82 ; object 1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map19_0_1::
    db $03 ; entry 0: object count
    db $85, $01, $3b, $00, $00, $40, $20, $05, $00, $50, $81 ; object 0
    db $86, $01, $12, $00, $00, $60, $30, $06, $03, $60, $82 ; object 1
    db $87, $01, $10, $00, $00, $20, $40, $07, $02, $70, $20 ; object 2

; record: count, then 3 object(s), the layout of the other object lists
MapObjects_Map19_0_Unlisted_1::
    db $03 ; entry 0: object count
    db $85, $01, $3b, $00, $00, $40, $20, $05, $00, $50, $81 ; object 0
    db $86, $01, $03, $00, $00, $30, $40, $06, $01, $60, $99 ; object 1
    db $87, $01, $1a, $00, $00, $60, $60, $07, $02, $70, $0a ; object 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map19_2::
    objsel_skip_if_clear EVENT_THANKS_FOR_COMING_BY_025, $04, $00
    objsel_list MapObjects_Map19_2_1

ObjSelector_Map19_2_Unlisted::
    objsel_skip_if_clear EVENT_SCENE_DARCK_DEFEATED, $04, $00
    objsel_list MapObjects_Map19_2_Unlisted_1

ObjSelector_Map19_2_Unlisted_2::
    objsel_unless_flag EVENT_SCENE_KAMEHA_BACK, MapObjects_Map19_2_Unlisted_2_0
    objsel_list MapObjects_Map19_2_1

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_Map19_2_Unlisted_2_0::
    db $01 ; entry 0
    db $85, $01, $10, $00, $00, $40, $70, $05, $02, $50, $83

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map19_2_1::
    db $01 ; entry 0
    db $85, $01, $10, $00, $00, $30, $60, $05, $02, $50, $83

; record: count, then 3 object(s), the layout of the other object lists
MapObjects_Map19_2_Unlisted_1::
    db $03 ; entry 0: object count
    db $85, $01, $10, $00, $00, $40, $70, $05, $02, $50, $83 ; object 0
    db $86, $01, $1b, $00, $00, $30, $40, $06, $00, $60, $12 ; object 1
    db $87, $01, $1d, $00, $00, $60, $50, $07, $03, $70, $15 ; object 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map19_3::
    objsel_skip_if_clear EVENT_THANKS_FOR_COMING_BY_025, $04, $00
    objsel_list MapObjects_Map19_3_1

ObjSelector_Map19_3_Unlisted::
    objsel_skip_if_clear EVENT_SCENE_DARCK_DEFEATED, $04, $00
    objsel_list MapObjects_Map19_3_Unlisted_1

ObjSelector_Map19_3_Unlisted_2::
    objsel_list MapObjects_Map19_3_1

; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map19_3_1::
    db $02 ; entry 0: object count
    db $85, $01, $10, $00, $00, $20, $30, $05, $01, $50, $84 ; object 0
    db $86, $01, $10, $00, $00, $20, $60, $06, $01, $60, $85 ; object 1

; an object list found by tiling a gap between map object layouts (E-0218)
MapObjects_Map19_3_Unlisted_1::
    db $03 ; entry 0: object count
    db $85, $01, $10, $00, $00, $50, $70, $05, $00, $50, $84 ; object 0
    db $86, $01, $1c, $00, $02, $30, $30, $06, $01, $60, $0c ; object 1
    db $87, $01, $1e, $00, $00, $70, $40, $07, $00, $70, $25 ; object 2

ObjSelector_Map19_4::
    objsel_unless_flag EVENT_THANKS_FOR_COMING_BY_025, MapObjects_Map19_4_0
    objsel_list MapObjects_Map19_4_1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map19_4_0::
    db $01 ; entry 0
    db $85, $01, $03, $00, $00, $30, $30, $05, $00, $50, $99

MapObjects_Map19_4_1::
    db $01 ; entry 0
    db $85, $01, $03, $00, $00, $d0, $30, $05, $00, $50, $99

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map1A::
    dw ObjSelector_Map1A_0 ; id 0
    dw ObjSelector_Map1A_1 ; id 1
    dw ObjSelector_Map1A_2 ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map1A_0::
    objsel_skip_if_clear EVENT_THANKS_FOR_COMING_BY_025, $04, $00
    objsel_list MapObjects_Map1A_0_1

ObjSelector_Map1A_0_Unlisted::
    objsel_unless_flag EVENT_SCENE_THREE_ITEMS, MapObjects_Map1A_0_1
    objsel_list MapObjects_Map1A_0_Unlisted_1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map1A_0_1::
    db $02 ; entry 0: object count
    db $85, $01, $1e, $00, $00, $40, $60, $05, $00, $50, $8a ; object 0
    db $86, $01, $1f, $00, $00, $50, $20, $06, $02, $60, $d9 ; object 1

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 4 object(s), the layout of the other object lists
MapObjects_Map1A_0_Unlisted_1::
    db $04 ; entry 0: object count
    db $85, $01, $1e, $00, $00, $40, $60, $05, $00, $50, $8a ; object 0
    db $86, $01, $1f, $00, $00, $50, $20, $06, $02, $60, $d9 ; object 1
    db $87, $01, $1b, $00, $00, $70, $30, $07, $00, $70, $dc ; object 2
    db $87, $01, $1b, $00, $00, $70, $40, $07, $02, $70, $dd ; object 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map1A_1::
    objsel_skip_if_clear EVENT_THANKS_FOR_COMING_BY_025, $04, $00
    objsel_list MapObjects_Map1A_1_1

ObjSelector_Map1A_1_Unlisted::
    objsel_skip_if_clear EVENT_SCENE_DARCK_DEFEATED, $08, $00
    objsel_unless_flag EVENT_IN_THE_MIDDLE_OF_THE, MapObjects_Map1A_1_Unlisted_1
    objsel_list MapObjects_Map1A_1_Unlisted_2

ObjSelector_Map1A_1_Unlisted_2::
    objsel_unless_flag EVENT_SCENE_THREE_ITEMS, MapObjects_Map1A_1_1
    objsel_list MapObjects_Map1A_1_Unlisted_2_1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map1A_1_1::
    db $01 ; entry 0
    db $85, $01, $12, $00, $00, $30, $50, $05, $00, $50, $8d

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 4 object(s), the layout of the other object lists
MapObjects_Map1A_1_Unlisted_2_1::
    db $04 ; entry 0: object count
    db $85, $01, $1a, $00, $00, $30, $50, $05, $00, $50, $de ; object 0
    db $85, $01, $1a, $00, $00, $20, $10, $05, $02, $50, $df ; object 1
    db $86, $01, $10, $00, $00, $50, $20, $06, $02, $60, $e0 ; object 2
    db $87, $01, $11, $00, $02, $70, $30, $07, $01, $70, $e1 ; object 3

MapObjects_Map1A_1_Unlisted_1::
    db $04 ; entry 0: object count
    db $85, $01, $04, $00, $00, $80, $20, $05, $03, $50, $00 ; object 0
    db $86, $01, $05, $00, $00, $80, $30, $06, $03, $60, $00 ; object 1
    db $87, $01, $00, $00, $00, $80, $40, $07, $03, $70, $00 ; object 2
    db $84, $01, $02, $00, $00, $e0, $30, $04, $01, $40, $00 ; object 3

MapObjects_Map1A_1_Unlisted_2::
    db $04 ; entry 0: object count
    db $85, $01, $04, $00, $00, $80, $20, $05, $03, $50, $00 ; object 0
    db $86, $01, $05, $00, $00, $80, $30, $06, $03, $60, $00 ; object 1
    db $87, $01, $01, $00, $00, $80, $40, $07, $03, $70, $00 ; object 2
    db $84, $01, $02, $00, $00, $e0, $30, $04, $01, $40, $00 ; object 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map1A_2::
    objsel_unless_flag EVENT_SCENE_THREE_ITEMS, MapObjects_Map1A_2_0
    objsel_unless_flag EVENT_SCENE_DARCK_DEFEATED, MapObjects_Map1A_2_1
    objsel_unless_flag EVENT_THANKS_FOR_COMING_BY_025, MapObjects_Map1A_2_0
    objsel_list MapObjects_Map1A_2_3

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map1A_2_0::
    db $03 ; entry 0: object count
    db $85, $01, $10, $00, $00, $20, $20, $05, $00, $50, $8c ; object 0
    db $86, $00, $7a, $00, $00, $40, $40, $06, $02, $60, $d7 ; object 1
    db $87, $01, $11, $00, $00, $40, $30, $07, $00, $70, $d6 ; object 2

; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map1A_2_1::
    db $02 ; entry 0: object count
    db $85, $01, $10, $00, $00, $30, $20, $05, $00, $50, $8c ; object 0
    db $86, $01, $12, $00, $00, $60, $30, $06, $01, $60, $8d ; object 1

MapObjects_Map1A_2_3::
    db $03 ; entry 0: object count
    db $85, $01, $10, $00, $00, $20, $20, $05, $00, $50, $8c ; object 0
    db $86, $00, $7a, $00, $00, $50, $40, $06, $02, $60, $d7 ; object 1
    db $87, $01, $11, $00, $00, $50, $30, $07, $00, $70, $d6 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map1C::
    dw ObjSelector_Map1C_0 ; id 0
    dw ObjSelector_Map1C_1 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map1C_0::
    objsel_list MapObjects_Map1C_0_0

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map1C_0_0::
    db $02 ; entry 0: object count
    db $85, $01, $57, $00, $00, $45, $80, $05, $02, $50, $00 ; object 0
ObjSelector_Map1C_1::
    db $fe, $ff, $fc, $76, $01, $85, $01, $57, $00, $00, $45 ; object 1
    db $a0, $05, $02, $50, $00

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map1D::
    dw ObjSelector_Map1D_0 ; id 0
    dw ObjSelector_Map1D_1 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map1D_0::
    objsel_unless_flag EVENT_IN_THE_MIDDLE_OF_THE, MapObjects_Map1D_0_0
    objsel_list MapObjects_Map1D_0_1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map1D_0_0::
    db $04 ; entry 0: object count
    db $85, $01, $04, $00, $00, $50, $10, $05, $00, $50, $32 ; object 0
    db $86, $01, $05, $00, $00, $40, $10, $06, $00, $60, $31 ; object 1
    db $87, $01, $28, $00, $00, $80, $40, $07, $01, $70, $30 ; object 2
    db $84, $01, $00, $00, $00, $b0, $50, $04, $03, $40, $00 ; object 3

MapObjects_Map1D_0_1::
    db $04 ; entry 0: object count
    db $85, $01, $04, $00, $00, $50, $10, $05, $00, $50, $32 ; object 0
    db $86, $01, $05, $00, $00, $40, $10, $06, $00, $60, $31 ; object 1
    db $87, $01, $28, $00, $00, $80, $40, $07, $01, $70, $30 ; object 2
    db $84, $01, $01, $00, $00, $b0, $50, $04, $03, $40, $00 ; object 3

ObjSelector_Map1D_1::
    objsel_skip_if_set EVENT_SCENE_AT_SEA, $08, $00
    objsel_unless_flag EVENT_IN_THE_MIDDLE_OF_THE, MapObjects_Map1D_1_1
    objsel_list MapObjects_Map1D_1_2

ObjSelector_Map1D_1_Unlisted::
    objsel_unless_flag EVENT_IN_THE_MIDDLE_OF_THE, MapObjects_Map1D_1_Unlisted_0
    objsel_list MapObjects_Map1D_1_Unlisted_1

MapObjects_Map1D_1_1::
    db $04 ; entry 0: object count
    db $85, $01, $29, $00, $02, $50, $30, $05, $01, $50, $2d ; object 0
    db $86, $01, $29, $00, $00, $10, $60, $06, $00, $60, $2e ; object 1
    db $87, $01, $00, $00, $00, $e0, $50, $07, $01, $70, $2f ; object 2
    db $86, $01, $29, $00, $00, $20, $e0, $06, $02, $60, $00 ; object 3

MapObjects_Map1D_1_2::
    db $04 ; entry 0: object count
    db $85, $01, $29, $00, $02, $50, $30, $05, $01, $50, $2d ; object 0
    db $86, $01, $29, $00, $00, $10, $60, $06, $00, $60, $2e ; object 1
    db $87, $01, $01, $00, $00, $e0, $50, $07, $01, $70, $2f ; object 2
    db $86, $01, $29, $00, $00, $20, $e0, $06, $02, $60, $00 ; object 3

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_Map1D_1_Unlisted_0::
    db $03 ; entry 0: object count
    db $85, $01, $29, $00, $02, $50, $30, $05, $01, $50, $2d ; object 0
    db $86, $01, $29, $00, $00, $10, $60, $06, $00, $60, $2e ; object 1
    db $87, $01, $00, $00, $00, $30, $40, $07, $01, $70, $2f ; object 2

MapObjects_Map1D_1_Unlisted_1::
    db $03 ; entry 0: object count
    db $85, $01, $29, $00, $02, $50, $30, $05, $01, $50, $2d ; object 0
    db $86, $01, $29, $00, $00, $10, $60, $06, $00, $60, $2e ; object 1
    db $87, $01, $01, $00, $00, $30, $40, $07, $01, $70, $2f ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map21::
    dw ObjSelector_Map21_0 ; id 0
    dw ObjSelector_Map21_1 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map21_0::
    objsel_list MapObjects_Map21_0_0

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map21_0_0::
    db $04 ; entry 0: object count
    db $85, $01, $23, $00, $00, $40, $70, $05, $01, $50, $00 ; object 0
    db $86, $01, $24, $00, $00, $10, $60, $06, $02, $60, $01 ; object 1
    db $87, $01, $25, $00, $00, $10, $50, $07, $00, $70, $02 ; object 2
    db $87, $01, $25, $00, $00, $70, $30, $07, $00, $70, $03 ; object 3

ObjSelector_Map21_1::
    objsel_list MapObjects_Map21_1_0

; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map21_1_0::
    db $03 ; entry 0: object count
    db $85, $01, $26, $00, $00, $60, $50, $05, $00, $50, $04 ; object 0
    db $86, $01, $25, $00, $02, $30, $60, $06, $01, $60, $05 ; object 1
    db $87, $01, $24, $00, $00, $10, $30, $07, $00, $70, $06 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map22::
    dw ObjSelector_Map22_0 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map22_0::
    objsel_list MapObjects_Map22_0_0

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map22_0_0::
    db $03 ; entry 0: object count
    db $85, $01, $24, $00, $00, $30, $40, $05, $01, $50, $0a ; object 0
    db $86, $01, $25, $00, $00, $80, $70, $06, $03, $60, $0b ; object 1
    db $87, $01, $12, $00, $00, $50, $10, $07, $00, $70, $45 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map23::
    dw ObjSelector_Map23_0 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map23_0::
    objsel_list MapObjects_Map23_0_0

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map23_0_0::
    db $02 ; entry 0: object count
    db $85, $01, $24, $00, $00, $10, $60, $05, $02, $50, $1f ; object 0
    db $86, $01, $24, $00, $00, $50, $10, $06, $00, $60, $20 ; object 1

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map24::
    dw ObjSelector_Map24_0 ; id 0
    dw ObjSelector_Map24_1 ; id 1
    dw ObjSelector_Map24_2 ; id 2
    dw ObjSelector_Map24_3 ; id 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map24_0::
    objsel_unless_flag EVENT_SCENE_MONSTER_INSPECTION, MapObjects_Map24_0_0
    objsel_list MapObjects_Map24_0_1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map24_0_0::
    db $04 ; entry 0: object count
    db $85, $01, $4d, $00, $00, $40, $10, $05, $00, $50, $13 ; object 0
    db $85, $01, $4d, $00, $00, $50, $10, $05, $00, $50, $14 ; object 1
    db $86, $01, $24, $00, $00, $70, $60, $06, $03, $60, $0d ; object 2
    db $87, $01, $25, $00, $00, $30, $70, $07, $00, $70, $15 ; object 3

MapObjects_Map24_0_1::
    db $04 ; entry 0: object count
    db $85, $01, $4d, $00, $00, $30, $20, $05, $00, $50, $13 ; object 0
    db $85, $01, $4d, $00, $02, $60, $30, $05, $00, $50, $14 ; object 1
    db $86, $01, $24, $00, $00, $70, $60, $06, $03, $60, $0d ; object 2
    db $87, $01, $25, $00, $00, $30, $70, $07, $00, $70, $15 ; object 3

ObjSelector_Map24_1::
    objsel_list MapObjects_Map24_1_0

; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map24_1_0::
    db $02 ; entry 0: object count
    db $85, $01, $12, $00, $00, $60, $30, $05, $00, $50, $17 ; object 0
    db $86, $01, $4d, $00, $00, $20, $60, $06, $01, $60, $0e ; object 1

ObjSelector_Map24_2::
    objsel_list MapObjects_Map24_2_0

MapObjects_Map24_2_0::
    db $04 ; entry 0: object count
    db $85, $01, $26, $00, $00, $70, $70, $05, $03, $50, $0c ; object 0
    db $86, $01, $24, $00, $00, $20, $40, $06, $00, $60, $10 ; object 1
    db $87, $01, $15, $00, $00, $80, $20, $07, $00, $70, $12 ; object 2
    db $85, $01, $26, $00, $02, $60, $50, $05, $01, $50, $11 ; object 3

ObjSelector_Map24_3::
    objsel_unless_flag EVENT_SCENE_MONSTER_INSPECTION, MapObjects_Map24_3_0
    objsel_list MapObjects_Map24_3_1

; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map24_3_0::
    db $03 ; entry 0: object count
    db $85, $01, $25, $00, $00, $20, $60, $05, $03, $50, $0f ; object 0
    db $86, $01, $24, $00, $00, $50, $50, $06, $00, $60, $16 ; object 1
    db $87, $01, $4b, $00, $00, $40, $30, $07, $00, $70, $18 ; object 2

MapObjects_Map24_3_1::
    db $02 ; entry 0: object count
    db $85, $01, $25, $00, $00, $20, $60, $05, $03, $50, $0f ; object 0
    db $86, $01, $24, $00, $00, $50, $50, $06, $00, $60, $16 ; object 1

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map25::
    dw ObjSelector_Map25_0 ; id 0
    dw ObjSelector_Map25_1 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map25_0::
    objsel_skip_if_clear EVENT_SCENE_RIVAL_DEFEATED_05A, $04, $00
    objsel_list MapObjects_Map25_0_1

ObjSelector_Map25_0_Unlisted::
    objsel_skip_if_set EVENT_SCENE_MONSTER_INSPECTION, $02, $00
    objsel_none

ObjSelector_Map25_0_Unlisted_2::
    objsel_skip_if_clear EVENT_KING_THE_TOWN, $06, $00
    objsel_unless_flag EVENT_SCENE_TREASURE_THEFT, MapObjects_Map25_0_Unlisted_2_1
    objsel_none

ObjSelector_Map25_0_Unlisted_3::
    objsel_skip_if_clear EVENT_YOU_WILL_SO_WE_CAN, $04, $00
    objsel_list MapObjects_Map25_0_1

ObjSelector_Map25_0_Unlisted_4::
    objsel_unless_flag EVENT_KING_WHAT_NEVER_MIND_THEN, MapObjects_Map25_0_1
    objsel_list MapObjects_Map25_0_Unlisted_4_1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map25_0_1::
    db $02 ; entry 0: object count
    db $85, $01, $4d, $00, $00, $30, $50, $05, $00, $50, $27 ; object 0
    db $86, $01, $24, $00, $02, $60, $40, $06, $00, $60, $28 ; object 1

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_Map25_0_Unlisted_4_1::
    db $01 ; entry 0
    db $85, $01, $4d, $00, $00, $30, $50, $05, $00, $50, $27

; record: count, then 3 object(s), the layout of the other object lists
MapObjects_Map25_0_Unlisted_2_1::
    db $03 ; entry 0: object count
    db $85, $01, $22, $00, $00, $40, $18, $05, $00, $50, $2b ; object 0
    db $86, $01, $4d, $00, $00, $30, $50, $06, $00, $60, $27 ; object 1
    db $87, $01, $24, $00, $00, $60, $40, $07, $00, $70, $28 ; object 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map25_1::
    objsel_skip_if_clear EVENT_SCENE_RIVAL_DEFEATED_05A, $04, $00
    objsel_list MapObjects_Map25_1_1

ObjSelector_Map25_1_Unlisted::
    objsel_unless_flag EVENT_SCENE_TREASURE_THEFT, MapObjects_Map25_1_Unlisted_0
    objsel_none

; record: count, then 4 object(s), the layout of the other object lists
MapObjects_Map25_1_Unlisted_0::
    db $04 ; entry 0: object count
    db $85, $01, $4c, $00, $00, $20, $10, $05, $03, $50, $22 ; object 0
    db $85, $01, $4c, $00, $00, $20, $20, $05, $03, $50, $23 ; object 1
    db $85, $01, $4c, $00, $00, $10, $30, $05, $02, $50, $24 ; object 2
    db $86, $01, $4b, $00, $00, $30, $50, $06, $00, $60, $21 ; object 3

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map25_1_1::
    db $03 ; entry 0: object count
    db $85, $01, $4c, $00, $00, $20, $10, $05, $03, $50, $22 ; object 0
    db $85, $01, $4c, $00, $00, $20, $20, $05, $03, $50, $23 ; object 1
    db $86, $01, $4b, $00, $00, $30, $50, $06, $00, $60, $21 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map26::
    dw ObjSelector_Map26_0 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map26_0::
    objsel_skip_if_set EVENT_THANKS_FOR_COMING_BY_025, $0a, $00
    objsel_skip_if_clear EVENT_SCENE_DARCK_DEFEATED, $04, $00
    objsel_list MapObjects_Map26_0_2

ObjSelector_Map26_0_Unlisted::
    objsel_skip_if_clear EVENT_SCENE_RIVAL_DEFEATED_05A, $04, $00
    objsel_list MapObjects_Map26_0_Unlisted_1

ObjSelector_Map26_0_Unlisted_2::
    objsel_skip_if_clear EVENT_KING_THE_TOWN, $06, $00
    objsel_unless_flag EVENT_SCENE_TREASURE_THEFT, MapObjects_Map26_0_Unlisted_2_1
    objsel_none

ObjSelector_Map26_0_Unlisted_3::
    objsel_skip_if_clear EVENT_YOU_WILL_SO_WE_CAN, $04, $00
    objsel_list MapObjects_Map26_0_Unlisted_1

ObjSelector_Map26_0_Unlisted_4::
    objsel_unless_flag EVENT_KING_WHAT_NEVER_MIND_THEN, MapObjects_Map26_0_Unlisted_1
    objsel_list MapObjects_Map26_0_Unlisted_4_1

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_Map26_0_Unlisted_1::
    db $02 ; entry 0: object count
    db $85, $01, $24, $00, $00, $50, $a0, $05, $02, $50, $28 ; object 0
    db $86, $01, $22, $00, $00, $40, $10, $06, $00, $60, $2b ; object 1

; record: count, then 1 object(s), the layout of the other object lists
MapObjects_Map26_0_Unlisted_4_1::
    db $01 ; entry 0
    db $85, $01, $24, $00, $00, $50, $40, $05, $00, $50, $28

; record: count, then 5 object(s), the layout of the other object lists
MapObjects_Map26_0_Unlisted_2_1::
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
MapObjects_Map26_0_2::
    db $05 ; entry 0: object count
    db $85, $01, $22, $00, $00, $40, $10, $05, $00, $50, $2b ; object 0
    db $86, $01, $24, $00, $00, $60, $20, $06, $00, $60, $28 ; object 1
    db $87, $01, $4b, $00, $00, $40, $50, $07, $02, $70, $21 ; object 2
    db $83, $01, $4c, $00, $00, $30, $60, $03, $02, $30, $23 ; object 3
    db $83, $01, $4c, $00, $00, $60, $60, $03, $02, $30, $23 ; object 4

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map28::
    dw ObjSelector_Map28_0 ; id 0
    dw ObjSelector_Map28_1 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map28_0::
    objsel_list MapObjects_Map28_0_0

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map28_0_0::
    db $01 ; entry 0
    db $85, $00, $4f, $00, $00, $50, $20, $05, $00, $50, $3b

ObjSelector_Map28_1::
    objsel_skip_if_clear EVENT_SCENE_RIVAL_DEFEATED_05A, $02, $00
    objsel_none

ObjSelector_Map28_1_Unlisted::
    objsel_list MapObjects_Map28_1_Unlisted_0

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 4 object(s), the layout of the other object lists
MapObjects_Map28_1_Unlisted_0::
    db $04 ; entry 0: object count
    db $85, $01, $5c, $00, $00, $40, $10, $05, $00, $50, $3c ; object 0
    db $86, $01, $22, $00, $00, $40, $a0, $06, $02, $60, $2b ; object 1
    db $87, $01, $4d, $00, $00, $40, $b0, $07, $02, $70, $00 ; object 2
    db $87, $01, $4d, $00, $00, $40, $c0, $07, $02, $70, $00 ; object 3

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map2A::
    dw ObjSelector_Map2A_0 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map2A_0::
    objsel_skip_if_set EVENT_WHAT_OPEN_THE_CANAL_GATE, $08, $00
    objsel_unless_flag EVENT_KING_WHAT_NEVER_MIND_THEN, MapObjects_Map2A_0_1
    objsel_list MapObjects_Map2A_0_2

ObjSelector_Map2A_0_Unlisted::
    objsel_list MapObjects_Map2A_0_Unlisted_0

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map2A_0_1::
    db $01 ; entry 0
    db $85, $01, $26, $00, $00, $20, $40, $05, $00, $50, $09

; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map2A_0_2::
    db $02 ; entry 0: object count
    db $85, $01, $22, $00, $00, $20, $50, $05, $02, $50, $2b ; object 0
    db $86, $01, $26, $00, $00, $20, $40, $06, $00, $60, $09 ; object 1

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_Map2A_0_Unlisted_0::
    db $02 ; entry 0: object count
    db $85, $01, $22, $00, $00, $e0, $e0, $05, $02, $50, $2b ; object 0
    db $86, $01, $26, $00, $00, $20, $10, $06, $00, $60, $09 ; object 1

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map2B::
    dw $0000 ; id 0
    dw $0000 ; id 1
    dw $0000 ; id 2
    dw $0000 ; id 3
    dw $0000 ; id 4
    dw $0000 ; id 5
    dw $0000 ; id 6
    dw $0000 ; id 7
    dw $0000 ; id 8
    dw ObjSelector_Map2B_9 ; id 9
    dw $0000 ; id 10
    dw $0000 ; id 11
    dw $0000 ; id 12
    dw $0000 ; id 13
    dw $0000 ; id 14
    dw $0000 ; id 15

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map2B_9::
    objsel_skip_if_clear EVENT_SCENE_WATER_SOLVED, $02, $00
    objsel_none

ObjSelector_Map2B_9_Unlisted::
    objsel_unless_flag EVENT_YOU_WILL_SO_WE_CAN, MapObjects_Map2B_9_Unlisted_0
    objsel_list MapObjects_Map2B_9_Unlisted_1

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_Map2B_9_Unlisted_0::
    db $02 ; entry 0: object count
    db $85, $01, $22, $00, $00, $30, $70, $05, $02, $50, $2b ; object 0
    db $86, $00, $4f, $00, $00, $30, $60, $06, $00, $60, $37 ; object 1

; record: count, then 1 object(s), the layout of the other object lists
MapObjects_Map2B_9_Unlisted_1::
    db $01 ; entry 0
    db $85, $01, $22, $00, $00, $30, $70, $05, $02, $50, $2b

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map2D::
    dw ObjSelector_Map2D_0 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map2D_0::
    objsel_skip_if_clear EVENT_SCENE_RIVAL_DEFEATED_05A, $04, $00
    objsel_list MapObjects_Map2D_0_1

ObjSelector_Map2D_0_Unlisted::
    objsel_unless_flag EVENT_SCENE_TREASURE_THEFT, MapObjects_Map2D_0_Unlisted_0
    objsel_list MapObjects_Map2D_0_Unlisted_1

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_Map2D_0_Unlisted_0::
    db $03 ; entry 0: object count
    db $85, $01, $4d, $00, $00, $50, $30, $05, $00, $50, $2c ; object 0
    db $86, $01, $4d, $00, $00, $20, $40, $06, $02, $60, $2d ; object 1
    db $87, $01, $24, $00, $00, $20, $20, $07, $00, $70, $00 ; object 2

; record: count, then 4 object(s), the layout of the other object lists
MapObjects_Map2D_0_Unlisted_1::
    db $04 ; entry 0: object count
    db $85, $01, $24, $00, $00, $20, $20, $05, $00, $50, $00 ; object 0
    db $86, $01, $4b, $00, $00, $20, $60, $06, $02, $60, $00 ; object 1
    db $87, $01, $4c, $00, $00, $20, $70, $07, $01, $70, $00 ; object 2
    db $87, $01, $4c, $00, $00, $30, $70, $07, $03, $70, $00 ; object 3

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map2D_0_1::
    db $04 ; entry 0: object count
    db $85, $01, $4d, $00, $00, $50, $30, $05, $00, $50, $2c ; object 0
    db $86, $01, $27, $00, $00, $30, $70, $06, $00, $60, $00 ; object 1
    db $86, $01, $27, $00, $00, $10, $70, $06, $01, $60, $00 ; object 2
    db $86, $01, $27, $00, $00, $20, $70, $06, $03, $60, $00 ; object 3

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map2E::
    dw ObjSelector_Map2E_0 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map2E_0::
    objsel_skip_if_clear EVENT_SCENE_RIVAL_DEFEATED_05A, $04, $00
    objsel_list MapObjects_Map2E_0_1

ObjSelector_Map2E_0_Unlisted::
    objsel_skip_if_clear EVENT_KING_THE_TOWN, $06, $00
    objsel_unless_flag EVENT_SCENE_TREASURE_THEFT, MapObjects_Map2E_0_Unlisted_1
    objsel_none

ObjSelector_Map2E_0_Unlisted_2::
    objsel_list MapObjects_Map2E_0_1

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map2E_0_1::
    db $02 ; entry 0: object count
    db $85, $01, $4d, $00, $00, $40, $40, $05, $00, $50, $25 ; object 0
    db $85, $01, $4d, $00, $00, $50, $40, $05, $00, $50, $26 ; object 1

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_Map2E_0_Unlisted_1::
    db $03 ; entry 0: object count
    db $85, $01, $22, $00, $00, $30, $60, $05, $01, $50, $2b ; object 0
    db $86, $01, $4d, $00, $00, $60, $50, $06, $02, $60, $25 ; object 1
    db $86, $01, $4d, $00, $00, $70, $70, $06, $03, $60, $26 ; object 2

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map2F::
    dw ObjSelector_Map2F_0 ; id 0
    dw ObjSelector_Map2F_1 ; id 1
    dw ObjSelector_Map2F_2 ; id 2
    dw $0000 ; id 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map2F_0::
    objsel_skip_if_set EVENT_SCENE_RIVAL_DEFEATED_05A, $02, $00
    objsel_none

ObjSelector_Map2F_0_Unlisted::
    objsel_list MapObjects_Map2F_0_Unlisted_0

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_Map2F_0_Unlisted_0::
    db $01 ; entry 0
    db $85, $00, $4f, $00, $00, $30, $60, $05, $01, $50, $3d

ObjSelector_Map2F_1::
    objsel_skip_if_set EVENT_THANKS_FOR_COMING_BY_025, $0a, $00
    objsel_skip_if_clear EVENT_SCENE_DARCK_DEFEATED, $04, $00
    objsel_list MapObjects_Map2F_1_2

ObjSelector_Map2F_1_Unlisted::
    objsel_skip_if_clear EVENT_SCENE_WATER_REWARD, $04, $00
    objsel_list MapObjects_Map2F_1_Unlisted_1

ObjSelector_Map2F_1_Unlisted_2::
    objsel_skip_if_clear EVENT_SCENE_RIVAL_DEFEATED_05A, $04, $00
    objsel_list MapObjects_Map2F_1_Unlisted_2_1

ObjSelector_Map2F_1_Unlisted_3::
    objsel_skip_if_set EVENT_SCENE_MONSTERS_IN_TOW, $02, $00
    objsel_none

ObjSelector_Map2F_1_Unlisted_4::
    objsel_list MapObjects_Map2F_1_Unlisted_4_0

; record: count, then 2 object(s), the layout of the other object lists
MapObjects_Map2F_1_Unlisted_4_0::
    db $02 ; entry 0: object count
    db $85, $00, $4f, $00, $00, $30, $60, $05, $00, $50, $3a ; object 0
    db $85, $00, $4f, $00, $00, $60, $40, $05, $03, $50, $3b ; object 1

MapObjects_Map2F_1_Unlisted_2_1::
    db $02 ; entry 0: object count
    db $85, $00, $4f, $00, $00, $30, $60, $05, $00, $50, $3a ; object 0
    db $85, $00, $4f, $00, $00, $60, $40, $05, $00, $50, $37 ; object 1

MapObjects_Map2F_1_Unlisted_1::
    db $01 ; entry 0
    db $85, $00, $4f, $00, $00, $30, $60, $05, $00, $50, $3a

; an object list of LoadMapObjectsForScreen (E-0163)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number
; (2 bytes), slot byte 0, X, Y, palette slot, facing (slot byte 7, E-0247), talk event group, slot
; byte 15
MapObjects_Map2F_1_2::
    db $03 ; entry 0: object count
    db $85, $00, $4f, $00, $00, $40, $e0, $05, $00, $50, $37 ; object 0
    db $85, $00, $4f, $00, $00, $50, $e0, $05, $00, $50, $37 ; object 1
    db $85, $00, $4f, $00, $00, $40, $e0, $05, $00, $50, $3a ; object 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_Map2F_2::
    objsel_skip_if_clear EVENT_SCENE_MONSTERS_IN_TOW, $02, $00
    objsel_none

ObjSelector_Map2F_2_Unlisted::
    objsel_skip_if_set EVENT_SCENE_TREASURE_THEFT, $02, $00
    objsel_none

ObjSelector_Map2F_2_Unlisted_2::
    objsel_list MapObjects_Map2F_2_Unlisted_2_0

; an object list found by tiling a gap between map object layouts (E-0218)
; record: count, then 4 object(s), the layout of the other object lists
MapObjects_Map2F_2_Unlisted_2_0::
    db $04 ; entry 0: object count
    db $85, $01, $22, $00, $00, $60, $60, $05, $02, $50, $2b ; object 0
    db $86, $01, $4d, $00, $00, $10, $40, $06, $02, $60, $25 ; object 1
    db $86, $01, $4d, $00, $02, $20, $70, $06, $02, $60, $26 ; object 2
    db $86, $01, $4d, $00, $00, $80, $50, $06, $02, $60, $2d ; object 3

LoadMapObjectsForScreen_MapObjects::
    db $04 ; entry 0: object count
    db $85, $01, $22, $00, $00, $60, $30, $05, $03, $50, $2b ; object 0
    db $86, $01, $4d, $00, $00, $10, $10, $06, $02, $60, $25 ; object 1
    db $86, $01, $4d, $00, $02, $20, $40, $06, $01, $60, $26 ; object 2
    db $86, $01, $4d, $00, $00, $80, $20, $06, $03, $60, $2d ; object 3

; one selector per screen, row by row (E-0163)
; record: selector for this screen
MapObjectScreens_Map03::
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
