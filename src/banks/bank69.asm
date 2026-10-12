SECTION "Bank 69", ROMX[$4000], BANK[$69]
    db $69

; clears the sprite slots; key-world maps set up their objects, other maps load the object list for hMapId (with a story-flag case on map $2F) (E-0131)
; 4 call sites from 4 routines (e.g. InitFieldScreen, RunFieldActionRequestActionIfBit7_Case02, LibraryMenu_Case06, BreedMenu_Case07_Case02)
; reads: wMapType, hMapId, hMapScreenX, hMapScreenY, wStoryFlags, hTempA, wMapWidthScreens
; writes: wSpriteSlotCount, wOBJPaletteUploadRequest, hTempA, hTemp4, hTemp5, hTemp2, hTemp0, hTemp1, ...
; points at: wSpriteSlots
LoadMapObjectsForScreen::
Func_069_4001:: ; address name
    xor a, a
    ld [wSpriteSlotCount], a
    ld a, [wMapType]
    bit 7, a
    jr z, Jump_069_401E
    farcall SetupKeyWorldObjectsForMapType
    farcall RestoreSpriteSnapshot
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ret

Jump_069_401E::
    ldh a, [hMapId]
    cp a, $2F
    jr nz, Jump_069_404C
    ldh a, [hMapScreenX]
    or a, a
    jr nz, Jump_069_404C
    ldh a, [hMapScreenY]
    cp a, $01
    jr nz, Jump_069_404C
    ld de, $0056
    call TestFlagBit
    jr nc, Jump_069_404C
    ld de, $0058
    call TestFlagBit
    jr c, Jump_069_404C
    ld a, [wStoryFlags + $61]
    bit 3, a
    jr z, Jump_069_404C
    ld hl, MapObjects_7E1E
    jp Jump_069_40F4

Jump_069_404C::
    ldh a, [hMapId]
    ld l, a
    ld h, $00
    add hl, hl
    ld a, l
    add a, $74
    ld l, a
    ld a, h
    adc a, $41
    ld h, a
    ld a, [hl+]
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
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    or a, e
    jr nz, Jump_069_407C
    jp Jump_069_4168

Jump_069_407C::
    ld a, [hl]
    ld d, a
    ld l, e
    ld h, d

Jump_069_4080::
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    cp a, $FF
    jr nz, Jump_069_40E5
    ld a, e
    cp a, $FF
    jr nz, Jump_069_4094

Jump_069_408D::
    xor a, a
    ld [wSpriteSlotCount], a
    jp Jump_069_4168

Jump_069_4094::
    cp a, $FE
    jr z, Jump_069_40EE
    cp a, $FD
    jr z, Jump_069_40D2
    cp a, $FC
    jr z, Jump_069_40BC
    cp a, $FB
    jr z, Jump_069_40A6
    jr Jump_069_408D

Jump_069_40A6::
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    call TestFlagBit
    jr nc, Jump_069_40B8
    ld a, [hl+]
    inc hl
    add_a_to_hl
    jr Jump_069_4080

Jump_069_40B8::
    inc hl
    inc hl
    jr Jump_069_4080

Jump_069_40BC::
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    call TestFlagBit
    jr nc, Jump_069_40C9
    inc hl
    inc hl
    jr Jump_069_4080

Jump_069_40C9::
    ld a, [hl+]
    inc hl
    add_a_to_hl
    jr Jump_069_4080

Jump_069_40D2::
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    call TestFlagBit
    jr nc, Jump_069_40E1
    inc hl
    inc hl
    inc hl
    inc hl
    jr Jump_069_4080

Jump_069_40E1::
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a

Jump_069_40E5::
    call TestFlagBit
    jr nc, Jump_069_40EE
    inc hl
    inc hl
    jr Jump_069_4080

Jump_069_40EE::
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld l, e
    ld h, d

Jump_069_40F4::
    ld a, [hl+]
    ld [wSpriteSlotCount], a
    ld b, a
    ld de, wSpriteSlots

Jump_069_40FC::
    push bc
    ld a, b
    ldh [hTempA], a
    xor a, a
    ldh [hTemp4], a
    ld a, [hl+]
    ldh [hTemp5], a
    ld a, [hl+]
    ldh [hTemp2], a
    inc de
    ld [de], a
    inc de
    ld a, [hl+]
    ldh [hTemp0], a
    ld [de], a
    inc de
    ld a, [hl+]
    ldh [hTemp1], a
    ld [de], a
    inc de
    push de
    ld a, e
    sub a, $04
    ld e, a
    ld a, d
    sbc a, $00
    ld d, a
    ld a, [hl+]
    ld [de], a
    pop de
    ld a, [hl]
    ld [de], a
    push de
    ld a, $07
    add a, e
    ld e, a
    jr nc, Jump_069_412C
    inc d

Jump_069_412C::
    ld a, [hl+]
    ld [de], a
    pop de
    inc de
    ld a, [hl]
    ld [de], a
    push de
    ld a, $07
    add a, e
    ld e, a
    jr nc, Jump_069_413A
    inc d

Jump_069_413A::
    ld a, [hl+]
    ld [de], a
    pop de
    inc de
    ld a, [hl+]
    ldh [hTemp3], a
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ldh a, [hTempA]
    and a, $03
    ld [de], a
    xor a, a
    inc de
    ld [de], a
    inc de
    inc de
    inc de
    ld [de], a
    inc de
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    push hl
    push de
    farcall DecompressGraphicsTemp0ToTemp4
    pop de
    pop hl
    pop bc
    dec b
    jr nz, Jump_069_40FC

Jump_069_4168::
    farcall RestoreSpriteSnapshot
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ret

; E-0163 (C1: LoadMapObjectsForScreen reads the word $4174 + 2 * hMapId (`add $74` / `adc $41`); 228 words up to the first array at $433C).
; record: per-screen selector array of this map ($0000 = none)
MapObjectTable::
Data_069_4174:: ; address name
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
    dw Data_069_5593 ; id 82
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

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_433C::
Data_069_433C:: ; address name
    dw $0000 ; id 0
    dw ObjSelector_4340 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4340:: ; heuristic: map object selector; C0
Data_069_4340:: ; address name
    objsel_unless_flag $01F6, MapObjects_4348
    objsel_list MapObjects_4354

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4348::
Data_069_4348:: ; address name
    db $01 ; entry 0
    db $85, $01, $41, $00, $00, $40, $20, $05, $00, $50, $A7

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4354::
Data_069_4354:: ; address name
    db $01 ; entry 0
    db $85, $01, $41, $00, $00, $30, $20, $05, $00, $50, $A7

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4360::
Data_069_4360:: ; address name
    dw $0000 ; id 0
    dw ObjSelector_4364 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4364:: ; heuristic: map object selector; C0
Data_069_4364:: ; address name
    objsel_unless_flag $01F2, MapObjects_436A
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_436A::
Data_069_436A:: ; address name
    db $01 ; entry 0
    db $85, $00, $0D, $00, $00, $40, $30, $05, $00, $50, $A6

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4376::
Data_069_4376:: ; address name
    dw $0000 ; id 0
    dw ObjSelector_437A ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_437A:: ; heuristic: map object selector; C0
Data_069_437A:: ; address name
    objsel_unless_flag $00FC, MapObjects_4380
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4380::
Data_069_4380:: ; address name
    db $01 ; entry 0
    db $85, $00, $5C, $00, $00, $40, $30, $05, $00, $50, $A5

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_438C::
Data_069_438C:: ; address name
    dw $0000 ; id 0
    dw ObjSelector_4390 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4390:: ; heuristic: map object selector; C0
Data_069_4390:: ; address name
    objsel_unless_flag $00F8, MapObjects_4396
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4396::
Data_069_4396:: ; address name
    db $01 ; entry 0
    db $85, $00, $55, $00, $00, $40, $30, $05, $00, $50, $A4

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_43A2::
Data_069_43A2:: ; address name
    dw $0000 ; id 0
    dw ObjSelector_43A6 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_43A6:: ; heuristic: map object selector; C0
Data_069_43A6:: ; address name
    objsel_unless_flag $00DF, MapObjects_43AC
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_43AC::
Data_069_43AC:: ; address name
    db $01 ; entry 0
    db $85, $00, $10, $00, $00, $40, $30, $05, $00, $50, $A3

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_43B8::
Data_069_43B8:: ; address name
    dw ObjSelector_43BC ; id 0
    dw ObjSelector_43D7 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_43BC:: ; heuristic: map object selector; C0
Data_069_43BC:: ; address name
    objsel_list MapObjects_43C0

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_43C0::
Data_069_43C0:: ; address name
    db $02 ; entry 0
    db $85, $00, $63, $00, $00, $20, $40, $05, $00, $50, $A0
    db $86, $01, $52, $00, $00, $60, $30, $06, $02, $60, $A1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_43D7:: ; heuristic: map object selector; C0
Data_069_43D7:: ; address name
    objsel_list MapObjects_43DB

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_43DB::
Data_069_43DB:: ; address name
    db $01 ; entry 0
    db $85, $00, $59, $00, $00, $40, $30, $05, $00, $50, $A2

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_43E7::
Data_069_43E7:: ; address name
    dw $0000 ; id 0
    dw ObjSelector_43EB ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_43EB:: ; heuristic: map object selector; C0
Data_069_43EB:: ; address name
    objsel_unless_flag $00D9, MapObjects_43F3
    objsel_list MapObjects_43FF

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_43F3::
Data_069_43F3:: ; address name
    db $01 ; entry 0
    db $85, $00, $9A, $00, $00, $40, $20, $05, $00, $50, $87

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_43FF::
Data_069_43FF:: ; address name
    db $01 ; entry 0
    db $85, $00, $9A, $00, $00, $30, $20, $05, $00, $50, $87

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_440B::
Data_069_440B:: ; address name
    dw $0000 ; id 0
    dw ObjSelector_440F ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_440F:: ; heuristic: map object selector; C0
Data_069_440F:: ; address name
    objsel_unless_flag $00D5, MapObjects_4415
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4415::
Data_069_4415:: ; address name
    db $01 ; entry 0
    db $85, $00, $8D, $00, $00, $40, $30, $05, $00, $50, $86

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4421::
Data_069_4421:: ; address name
    dw $0000 ; id 0
    dw ObjSelector_4425 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4425:: ; heuristic: map object selector; C0
Data_069_4425:: ; address name
    objsel_unless_flag $017C, MapObjects_442B
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_442B::
Data_069_442B:: ; address name
    db $01 ; entry 0
    db $85, $00, $80, $00, $00, $40, $30, $05, $00, $50, $85

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4437::
Data_069_4437:: ; address name
    dw $0000 ; id 0
    dw ObjSelector_443B ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_443B:: ; heuristic: map object selector; C0
Data_069_443B:: ; address name
    objsel_unless_flag $0178, MapObjects_4441
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4441::
Data_069_4441:: ; address name
    db $01 ; entry 0
    db $85, $00, $92, $00, $00, $40, $30, $05, $00, $50, $84

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_444D::
Data_069_444D:: ; address name
    dw $0000 ; id 0
    dw ObjSelector_4451 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4451:: ; heuristic: map object selector; C0
Data_069_4451:: ; address name
    objsel_unless_flag $0174, MapObjects_4457
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4457::
Data_069_4457:: ; address name
    db $01 ; entry 0
    db $85, $00, $39, $00, $00, $40, $30, $05, $00, $50, $83

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4463::
Data_069_4463:: ; address name
    dw ObjSelector_4467 ; id 0
    dw ObjSelector_4482 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4467:: ; heuristic: map object selector; C0
Data_069_4467:: ; address name
    objsel_list MapObjects_446B

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_446B::
Data_069_446B:: ; address name
    db $02 ; entry 0
    db $85, $00, $15, $00, $00, $70, $40, $05, $00, $50, $80
    db $86, $01, $11, $00, $00, $10, $70, $06, $03, $60, $81

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4482:: ; heuristic: map object selector; C0
Data_069_4482:: ; address name
    objsel_list MapObjects_4486

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4486::
Data_069_4486:: ; address name
    db $01 ; entry 0
    db $85, $00, $51, $00, $00, $40, $30, $05, $00, $50, $82

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4492::
Data_069_4492:: ; address name
    dw $0000 ; id 0
    dw ObjSelector_4496 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4496:: ; heuristic: map object selector; C0
Data_069_4496:: ; address name
    objsel_unless_flag $016E, MapObjects_449E
    objsel_list MapObjects_44AA

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_449E::
Data_069_449E:: ; address name
    db $01 ; entry 0
    db $85, $00, $ED, $00, $00, $40, $20, $05, $00, $50, $67

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_44AA::
Data_069_44AA:: ; address name
    db $01 ; entry 0
    db $85, $00, $ED, $00, $00, $30, $20, $05, $00, $50, $67

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_44B6::
Data_069_44B6:: ; address name
    dw $0000 ; id 0
    dw ObjSelector_44BA ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_44BA:: ; heuristic: map object selector; C0
Data_069_44BA:: ; address name
    objsel_unless_flag $016A, MapObjects_44C0
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_44C0::
Data_069_44C0:: ; address name
    db $01 ; entry 0
    db $85, $00, $25, $01, $00, $40, $30, $05, $00, $50, $66

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_44CC::
Data_069_44CC:: ; address name
    dw $0000 ; id 0
    dw ObjSelector_44D0 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_44D0:: ; heuristic: map object selector; C0
Data_069_44D0:: ; address name
    objsel_unless_flag $01DD, MapObjects_44D6
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_44D6::
Data_069_44D6:: ; address name
    db $01 ; entry 0
    db $85, $00, $2E, $01, $00, $40, $30, $05, $00, $50, $65

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_44E2::
Data_069_44E2:: ; address name
    dw $0000 ; id 0
    dw ObjSelector_44E6 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_44E6:: ; heuristic: map object selector; C0
Data_069_44E6:: ; address name
    objsel_unless_flag $01D9, MapObjects_44EC
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_44EC::
Data_069_44EC:: ; address name
    db $01 ; entry 0
    db $85, $00, $55, $01, $00, $40, $30, $05, $00, $50, $64

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_44F8::
Data_069_44F8:: ; address name
    dw $0000 ; id 0
    dw ObjSelector_44FC ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_44FC:: ; heuristic: map object selector; C0
Data_069_44FC:: ; address name
    objsel_unless_flag $01D4, MapObjects_4502
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4502::
Data_069_4502:: ; address name
    db $01 ; entry 0
    db $85, $00, $4E, $00, $00, $40, $30, $05, $00, $50, $63

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_450E::
Data_069_450E:: ; address name
    dw ObjSelector_4512 ; id 0
    dw ObjSelector_452D ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4512:: ; heuristic: map object selector; C0
Data_069_4512:: ; address name
    objsel_list MapObjects_4516

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4516::
Data_069_4516:: ; address name
    db $02 ; entry 0
    db $85, $00, $47, $00, $00, $30, $30, $05, $00, $50, $60
    db $86, $01, $3E, $00, $00, $70, $50, $06, $03, $60, $61

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_452D:: ; heuristic: map object selector; C0
Data_069_452D:: ; address name
    objsel_list MapObjects_4531

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4531::
Data_069_4531:: ; address name
    db $01 ; entry 0
    db $85, $00, $06, $00, $00, $40, $30, $05, $00, $50, $62

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_453D::
Data_069_453D:: ; address name
    dw ObjSelector_4545 ; id 0
    dw ObjSelector_456B ; id 1
    dw ObjSelector_459C ; id 2
    dw ObjSelector_45C2 ; id 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4545:: ; heuristic: map object selector; C0
Data_069_4545:: ; address name
    objsel_list MapObjects_4549

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4549::
Data_069_4549:: ; address name
    db $03 ; entry 0
    db $85, $01, $0C, $00, $02, $40, $50, $05, $01, $50, $36
    db $86, $01, $0D, $00, $00, $20, $30, $06, $00, $60, $37
    db $87, $01, $08, $00, $00, $70, $20, $07, $03, $70, $38

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_456B:: ; heuristic: map object selector; C0
Data_069_456B:: ; address name
    objsel_list MapObjects_456F

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_456F::
Data_069_456F:: ; address name
    db $04 ; entry 0
    db $85, $01, $09, $00, $00, $60, $50, $05, $03, $50, $39
    db $86, $01, $0A, $00, $00, $20, $60, $06, $00, $60, $3A
    db $85, $01, $09, $00, $02, $20, $40, $05, $01, $50, $3B
    db $87, $01, $15, $00, $00, $40, $20, $07, $00, $70, $3C

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_459C:: ; heuristic: map object selector; C0
Data_069_459C:: ; address name
    objsel_list MapObjects_45A0

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_45A0::
Data_069_45A0:: ; address name
    db $03 ; entry 0
    db $85, $01, $08, $00, $00, $30, $60, $05, $00, $50, $30
    db $86, $01, $09, $00, $00, $30, $40, $06, $01, $60, $31
    db $87, $01, $06, $00, $02, $60, $20, $07, $01, $70, $32

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_45C2:: ; heuristic: map object selector; C0
Data_069_45C2:: ; address name
    objsel_list MapObjects_45C6

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_45C6::
Data_069_45C6:: ; address name
    db $03 ; entry 0
    db $85, $01, $07, $00, $02, $20, $60, $05, $01, $50, $33
    db $86, $01, $0A, $00, $00, $60, $40, $06, $00, $60, $34
    db $87, $01, $0B, $00, $00, $20, $20, $07, $00, $70, $35

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_45E8::
Data_069_45E8:: ; address name
    dw ObjSelector_45EC ; id 0
    dw ObjSelector_4617 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_45EC:: ; heuristic: map object selector; C0
Data_069_45EC:: ; address name
    objsel_unless_flag $01C0, MapObjects_45F4
    objsel_list MapObjects_460B

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_45F4::
Data_069_45F4:: ; address name
    db $02 ; entry 0
    db $85, $01, $2A, $00, $00, $70, $60, $05, $03, $50, $43
    db $86, $01, $51, $00, $00, $30, $40, $06, $00, $60, $44

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_460B::
Data_069_460B:: ; address name
    db $01 ; entry 0
    db $85, $01, $2A, $00, $00, $70, $60, $05, $03, $50, $43

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4617:: ; heuristic: map object selector; C0
Data_069_4617:: ; address name
    objsel_list MapObjects_461B

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_461B::
Data_069_461B:: ; address name
    db $03 ; entry 0
    db $85, $01, $16, $00, $00, $50, $60, $05, $00, $50, $40
    db $86, $01, $22, $00, $02, $50, $20, $06, $01, $60, $41
    db $87, $01, $13, $00, $00, $30, $40, $07, $00, $70, $42

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_463D::
Data_069_463D:: ; address name
    dw ObjSelector_4641 ; id 0
    dw ObjSelector_466B ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4641:: ; heuristic: map object selector; C0
Data_069_4641:: ; address name
    objsel_skip_if_set $01C0, $02, $00
    objsel_none

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4649:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_4649:: ; address name
    objsel_unless_flag $01C1, MapObjects_4653
    objsel_unless_flag $01C3, MapObjects_465F
    objsel_none

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_4653::
Data_069_4653:: ; address name
    db $01 ; entry 0
    db $85, $01, $43, $00, $00, $40, $20, $05, $02, $50, $3F

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_465F::
Data_069_465F:: ; address name
    db $01 ; entry 0
    db $85, $01, $43, $00, $00, $30, $20, $05, $00, $50, $3F

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_466B:: ; heuristic: map object selector; C0
Data_069_466B:: ; address name
    objsel_skip_if_set $01B9, $02, $00
    objsel_none

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4673:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_4673:: ; address name
    objsel_unless_flag $01BB, MapObjects_467D
    objsel_unless_flag $01BC, MapObjects_469F
    objsel_none

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_467D::
Data_069_467D:: ; address name
    db $03 ; entry 0
    db $85, $00, $D3, $00, $00, $40, $10, $05, $01, $50, $45
    db $86, $00, $D3, $00, $00, $50, $10, $06, $03, $60, $46
    db $87, $01, $5A, $00, $00, $50, $E0, $07, $00, $70, $47

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_469F::
Data_069_469F:: ; address name
    db $01 ; entry 0
    db $85, $01, $5A, $00, $00, $50, $10, $05, $00, $50, $47

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_46AB::
Data_069_46AB:: ; address name
    dw ObjSelector_46AD ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_46AD:: ; heuristic: map object selector; C0
Data_069_46AD:: ; address name
    objsel_unless_flag $01B1, MapObjects_46C5
    objsel_unless_flag $01BE, MapObjects_46E7
    objsel_unless_flag $01C0, MapObjects_46C5
    objsel_unless_flag $01C3, MapObjects_46E7
    objsel_unless_flag $01C7, MapObjects_46C5
    objsel_list MapObjects_46E7

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_46C5::
Data_069_46C5:: ; address name
    db $03 ; entry 0
    db $85, $01, $15, $00, $00, $30, $20, $05, $00, $50, $3D
    db $86, $01, $43, $00, $00, $70, $40, $06, $00, $60, $3F
    db $87, $01, $13, $00, $00, $70, $70, $07, $00, $70, $3E

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_46E7::
Data_069_46E7:: ; address name
    db $02 ; entry 0
    db $85, $01, $15, $00, $00, $30, $20, $05, $00, $50, $3D
    db $86, $01, $13, $00, $00, $70, $70, $06, $00, $60, $3E

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_46FE::
Data_069_46FE:: ; address name
    dw ObjSelector_4700 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4700:: ; heuristic: map object selector; C0
Data_069_4700:: ; address name
    objsel_unless_flag $01C3, MapObjects_4706
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4706::
Data_069_4706:: ; address name
    db $02 ; entry 0
    db $85, $01, $51, $00, $00, $50, $20, $05, $00, $50, $48
    db $86, $01, $43, $00, $00, $E0, $E0, $06, $00, $60, $3F

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_471D::
Data_069_471D:: ; address name
    dw ObjSelector_471F ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_471F:: ; heuristic: map object selector; C0
Data_069_471F:: ; address name
    objsel_unless_flag $015A, MapObjects_472B
    objsel_unless_flag $0167, MapObjects_4742
    objsel_list MapObjects_4759

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_472B::
Data_069_472B:: ; address name
    db $02 ; entry 0
    db $85, $01, $20, $00, $00, $30, $40, $05, $02, $50, $20
    db $86, $00, $2A, $01, $00, $40, $30, $06, $00, $60, $21

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4742::
Data_069_4742:: ; address name
    db $02 ; entry 0
    db $85, $01, $20, $00, $00, $10, $40, $05, $02, $50, $20
    db $86, $00, $2A, $01, $00, $40, $30, $06, $00, $60, $21

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4759::
Data_069_4759:: ; address name
    db $03 ; entry 0
    db $85, $01, $20, $00, $00, $60, $50, $05, $02, $50, $20
    db $86, $00, $2A, $01, $00, $40, $30, $06, $00, $60, $21
    db $87, $00, $29, $01, $00, $50, $10, $07, $00, $70, $2D

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_477B::
Data_069_477B:: ; address name
    dw ObjSelector_477D ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_477D:: ; heuristic: map object selector; C0
Data_069_477D:: ; address name
    objsel_unless_flag $0163, MapObjects_4787
    objsel_unless_flag $0167, MapObjects_479E
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4787::
Data_069_4787:: ; address name
    db $02 ; entry 0
    db $85, $00, $29, $01, $00, $40, $20, $05, $00, $50, $2D
    db $86, $01, $61, $00, $00, $40, $E0, $06, $00, $60, $2D

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_479E::
Data_069_479E:: ; address name
    db $01 ; entry 0
    db $85, $01, $61, $00, $00, $40, $20, $05, $00, $50, $2D

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_47AA::
Data_069_47AA:: ; address name
    dw ObjSelector_47B2 ; id 0
    dw ObjSelector_47CD ; id 1
    dw ObjSelector_486A ; id 2
    dw ObjSelector_4890 ; id 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_47B2:: ; heuristic: map object selector; C0
Data_069_47B2:: ; address name
    objsel_list MapObjects_47B6

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_47B6::
Data_069_47B6:: ; address name
    db $02 ; entry 0
    db $85, $01, $42, $00, $00, $50, $20, $05, $02, $50, $06
    db $86, $01, $32, $00, $00, $50, $40, $06, $00, $60, $07

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_47CD:: ; heuristic: map object selector; C0
Data_069_47CD:: ; address name
    objsel_unless_flag $0146, MapObjects_47E1
    objsel_unless_flag $0147, MapObjects_4803
    objsel_unless_flag $014C, MapObjects_4825
    objsel_unless_flag $0151, MapObjects_483C
    objsel_list MapObjects_4848

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_47E1::
Data_069_47E1:: ; address name
    db $03 ; entry 0
    db $85, $01, $35, $00, $00, $70, $10, $05, $00, $50, $0B
    db $86, $01, $31, $00, $00, $40, $A0, $06, $02, $60, $01
    db $87, $01, $32, $00, $00, $40, $B0, $07, $02, $70, $02

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4803::
Data_069_4803:: ; address name
    db $03 ; entry 0
    db $85, $01, $35, $00, $00, $70, $10, $05, $00, $50, $0B
    db $86, $01, $31, $00, $00, $60, $40, $06, $02, $60, $01
    db $87, $01, $32, $00, $00, $20, $70, $07, $00, $70, $02

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4825::
Data_069_4825:: ; address name
    db $02 ; entry 0
    db $85, $01, $35, $00, $00, $70, $10, $05, $00, $50, $0B
    db $86, $01, $31, $00, $00, $60, $40, $06, $02, $60, $01

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_483C::
Data_069_483C:: ; address name
    db $01 ; entry 0
    db $85, $01, $35, $00, $00, $70, $10, $05, $00, $50, $0B

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4848::
Data_069_4848:: ; address name
    db $03 ; entry 0
    db $85, $01, $35, $00, $00, $70, $10, $05, $00, $50, $0B
    db $86, $01, $31, $00, $00, $30, $50, $06, $02, $60, $01
    db $87, $01, $32, $00, $00, $40, $60, $07, $02, $70, $02

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_486A:: ; heuristic: map object selector; C0
Data_069_486A:: ; address name
    objsel_list MapObjects_486E

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_486E::
Data_069_486E:: ; address name
    db $03 ; entry 0
    db $85, $01, $33, $00, $00, $60, $60, $05, $01, $50, $08
    db $86, $01, $34, $00, $02, $20, $50, $06, $01, $60, $09
    db $87, $01, $37, $00, $00, $20, $30, $07, $00, $70, $0A

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4890:: ; heuristic: map object selector; C0
Data_069_4890:: ; address name
    objsel_list MapObjects_4894

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4894::
Data_069_4894:: ; address name
    db $03 ; entry 0
    db $85, $01, $37, $00, $00, $80, $40, $05, $00, $50, $03
    db $86, $01, $34, $00, $00, $20, $30, $06, $01, $60, $04
    db $87, $01, $31, $00, $02, $40, $60, $07, $00, $70, $05

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_48B6::
Data_069_48B6:: ; address name
    dw ObjSelector_48BA ; id 0
    dw ObjSelector_4916 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_48BA:: ; heuristic: map object selector; C0
Data_069_48BA:: ; address name
    objsel_skip_if_clear $014B, $02, $00
    objsel_none

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_48C2:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_48C2:: ; address name
    objsel_skip_if_clear $0147, $04, $00
    objsel_list MapObjects_48E9

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_48CC:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_48CC:: ; address name
    objsel_unless_flag $0146, MapObjects_48D2
    objsel_none

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_48D2::
Data_069_48D2:: ; address name
    db $02 ; entry 0
    db $85, $01, $31, $00, $00, $40, $30, $05, $00, $50, $01
    db $86, $01, $32, $00, $00, $50, $20, $06, $00, $60, $02

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 4 object(s), the layout of the other object lists
MapObjects_48E9::
Data_069_48E9:: ; address name
    db $04 ; entry 0
    db $85, $01, $32, $00, $00, $60, $10, $05, $00, $50, $02
    db $86, $00, $D5, $00, $00, $50, $20, $06, $00, $60, $00
    db $87, $00, $57, $00, $00, $50, $40, $07, $00, $70, $0D
    db $87, $00, $57, $00, $00, $40, $30, $07, $00, $70, $0E

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4916:: ; heuristic: map object selector; C0
Data_069_4916:: ; address name
    objsel_skip_if_clear $0148, $02, $00
    objsel_none

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_491E:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_491E:: ; address name
    objsel_skip_if_clear $0147, $04, $00
    objsel_list MapObjects_492E

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4928:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_4928:: ; address name
    objsel_unless_flag $0140, MapObjects_492E
    objsel_none

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_492E::
Data_069_492E:: ; address name
    db $01 ; entry 0
    db $85, $01, $32, $00, $00, $40, $30, $05, $02, $50, $02

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_493A::
Data_069_493A:: ; address name
    dw ObjSelector_493C ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_493C:: ; heuristic: map object selector; C0
Data_069_493C:: ; address name
    objsel_list MapObjects_4940

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4940::
Data_069_4940:: ; address name
    db $02 ; entry 0
    db $85, $01, $37, $00, $00, $50, $40, $05, $00, $50, $0F
    db $86, $01, $38, $00, $00, $30, $20, $06, $03, $60, $10

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4957::
Data_069_4957:: ; address name
    dw ObjSelector_4959 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4959:: ; heuristic: map object selector; C0
Data_069_4959:: ; address name
    objsel_skip_if_set $014C, $02, $00
    objsel_none

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4961:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_4961:: ; address name
    objsel_unless_flag $014F, MapObjects_496B
    objsel_unless_flag $0151, MapObjects_498D
    objsel_none

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_496B::
Data_069_496B:: ; address name
    db $03 ; entry 0
    db $85, $00, $D5, $00, $00, $40, $30, $05, $00, $50, $11
    db $86, $01, $32, $00, $00, $40, $20, $06, $00, $60, $02
    db $87, $01, $31, $00, $00, $40, $60, $07, $02, $70, $01

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_498D::
Data_069_498D:: ; address name
    db $03 ; entry 0
    db $85, $00, $D5, $00, $00, $40, $30, $05, $00, $50, $11
    db $86, $01, $32, $00, $00, $40, $20, $06, $00, $60, $02
    db $87, $01, $31, $00, $00, $60, $40, $07, $03, $70, $01

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_49AF::
Data_069_49AF:: ; address name
    dw ObjSelector_49B5 ; id 0
    dw $0000 ; id 1
    dw $0000 ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_49B5:: ; heuristic: map object selector; C0
Data_069_49B5:: ; address name
    objsel_unless_flag $00D3, MapObjects_49BB
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_49BB::
Data_069_49BB:: ; address name
    db $02 ; entry 0
    db $85, $01, $5C, $00, $00, $40, $30, $05, $00, $50, $00
    db $86, $00, $DF, $00, $00, $40, $E0, $06, $00, $60, $00

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_49D2::
Data_069_49D2:: ; address name
    dw ObjSelector_49D6 ; id 0
    dw $0000 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_49D6:: ; heuristic: map object selector; C0
Data_069_49D6:: ; address name
    objsel_unless_flag $00D1, MapObjects_49DC
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_49DC::
Data_069_49DC:: ; address name
    db $02 ; entry 0
    db $85, $01, $4A, $00, $00, $40, $E0, $05, $00, $50, $00
    db $86, $01, $48, $00, $05, $48, $30, $06, $00, $60, $01

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_49F3::
Data_069_49F3:: ; address name
    dw ObjSelector_49F9 ; id 0
    dw ObjSelector_4A51 ; id 1
    dw ObjSelector_4A82 ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_49F9:: ; heuristic: map object selector; C0
Data_069_49F9:: ; address name
    objsel_skip_if_set $0025, $0A, $00
    objsel_skip_if_clear $00D1, $04, $00
    objsel_list MapObjects_4A24

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4A09:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_4A09:: ; address name
    objsel_list MapObjects_4A0D

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_4A0D::
Data_069_4A0D:: ; address name
    db $02 ; entry 0
    db $85, $00, $6D, $00, $00, $70, $20, $05, $00, $50, $0B
    db $86, $00, $55, $01, $00, $20, $E0, $06, $00, $60, $00

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4A24::
Data_069_4A24:: ; address name
    db $04 ; entry 0
    db $85, $00, $6D, $00, $00, $70, $20, $05, $00, $50, $0B
    db $86, $00, $55, $01, $00, $20, $E0, $06, $00, $60, $00
    db $87, $00, $63, $00, $00, $B0, $40, $07, $01, $70, $01
    db $83, $00, $75, $00, $00, $C0, $40, $03, $00, $30, $02

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4A51:: ; heuristic: map object selector; C0
Data_069_4A51:: ; address name
    objsel_list MapObjects_4A55

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4A55::
Data_069_4A55:: ; address name
    db $04 ; entry 0
    db $85, $00, $47, $00, $00, $50, $70, $05, $00, $50, $00
    db $86, $00, $63, $00, $00, $10, $60, $06, $01, $60, $01
    db $87, $00, $75, $00, $00, $70, $20, $07, $00, $70, $02
    db $86, $00, $63, $00, $00, $30, $30, $06, $00, $60, $03

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4A82:: ; heuristic: map object selector; C0
Data_069_4A82:: ; address name
    objsel_list MapObjects_4A86

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4A86::
Data_069_4A86:: ; address name
    db $03 ; entry 0
    db $85, $00, $6A, $00, $02, $30, $40, $05, $01, $50, $05
    db $86, $00, $51, $00, $00, $20, $60, $06, $02, $60, $04
    db $87, $00, $6A, $00, $00, $50, $30, $07, $00, $70, $06

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4AA8::
Data_069_4AA8:: ; address name
    dw ObjSelector_4AAA ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4AAA:: ; heuristic: map object selector; C0
Data_069_4AAA:: ; address name
    objsel_list MapObjects_4AAE

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4AAE::
Data_069_4AAE:: ; address name
    db $01 ; entry 0
    db $85, $00, $77, $00, $00, $30, $10, $05, $00, $50, $00

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4ABA::
Data_069_4ABA:: ; address name
    dw ObjSelector_4AC2 ; id 0
    dw $0000 ; id 1
    dw $0000 ; id 2
    dw $0000 ; id 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4AC2:: ; heuristic: map object selector; C0
Data_069_4AC2:: ; address name
    objsel_unless_flag $00A4, MapObjects_4AC8
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4AC8::
Data_069_4AC8:: ; address name
    db $02 ; entry 0
    db $85, $00, $79, $00, $00, $6E, $EC, $05, $00, $50, $00
    db $86, $01, $5A, $00, $00, $40, $50, $06, $00, $60, $00

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4ADF::
Data_069_4ADF:: ; address name
    dw $0000 ; id 0
    dw $0000 ; id 1
    dw ObjSelector_4AE5 ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4AE5:: ; heuristic: map object selector; C0
Data_069_4AE5:: ; address name
    objsel_unless_flag $0209, MapObjects_4AED
    objsel_list MapObjects_4AF9

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4AED::
Data_069_4AED:: ; address name
    db $01 ; entry 0
    db $85, $00, $61, $00, $00, $40, $20, $05, $00, $50, $16

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4AF9::
Data_069_4AF9:: ; address name
    db $01 ; entry 0
    db $85, $00, $61, $00, $00, $50, $20, $05, $03, $50, $16

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4B05::
Data_069_4B05:: ; address name
    dw ObjSelector_4B0D ; id 0
    dw ObjSelector_4B33 ; id 1
    dw ObjSelector_4B59 ; id 2
    dw ObjSelector_4B8A ; id 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4B0D:: ; heuristic: map object selector; C0
Data_069_4B0D:: ; address name
    objsel_list MapObjects_4B11

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4B11::
Data_069_4B11:: ; address name
    db $03 ; entry 0
    db $85, $00, $53, $00, $00, $10, $70, $05, $01, $50, $1C
    db $86, $00, $19, $01, $00, $10, $30, $06, $00, $60, $1B
    db $87, $00, $06, $00, $00, $40, $40, $07, $00, $70, $1D

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4B33:: ; heuristic: map object selector; C0
Data_069_4B33:: ; address name
    objsel_list MapObjects_4B37

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4B37::
Data_069_4B37:: ; address name
    db $03 ; entry 0
    db $85, $00, $5C, $00, $00, $50, $60, $05, $03, $50, $1E
    db $86, $00, $2B, $00, $00, $30, $40, $06, $00, $60, $1F
    db $87, $00, $6C, $00, $00, $20, $70, $07, $03, $70, $20

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4B59:: ; heuristic: map object selector; C0
Data_069_4B59:: ; address name
    objsel_list MapObjects_4B5D

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4B5D::
Data_069_4B5D:: ; address name
    db $04 ; entry 0
    db $85, $00, $48, $00, $00, $50, $40, $05, $00, $50, $17
    db $85, $00, $48, $00, $00, $80, $70, $05, $03, $50, $1A
    db $86, $00, $56, $00, $00, $70, $20, $06, $00, $60, $23
    db $87, $00, $6D, $00, $00, $10, $30, $07, $01, $70, $24

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4B8A:: ; heuristic: map object selector; C0
Data_069_4B8A:: ; address name
    objsel_list MapObjects_4B8E

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4B8E::
Data_069_4B8E:: ; address name
    db $04 ; entry 0
    db $85, $00, $5F, $00, $00, $10, $20, $05, $00, $50, $21
    db $86, $00, $80, $00, $02, $10, $60, $06, $03, $60, $22
    db $87, $00, $47, $00, $00, $40, $70, $07, $02, $70, $19
    db $84, $00, $49, $00, $00, $70, $30, $04, $00, $40, $18

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4BBB::
Data_069_4BBB:: ; address name
    dw ObjSelector_4BBF ; id 0
    dw ObjSelector_4BCF ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4BBF:: ; heuristic: map object selector; C0
Data_069_4BBF:: ; address name
    objsel_list MapObjects_4BC3

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4BC3::
Data_069_4BC3:: ; address name
    db $01 ; entry 0
    db $85, $00, $0C, $00, $00, $50, $60, $05, $00, $50, $6B

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4BCF:: ; heuristic: map object selector; C0
Data_069_4BCF:: ; address name
    objsel_list MapObjects_4BD3

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4BD3::
Data_069_4BD3:: ; address name
    db $03 ; entry 0
    db $85, $00, $53, $00, $00, $70, $10, $05, $00, $50, $00
    db $86, $00, $5D, $00, $00, $30, $20, $06, $03, $60, $6C
    db $87, $00, $4E, $00, $00, $20, $30, $07, $02, $70, $6D

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4BF5::
Data_069_4BF5:: ; address name
    dw ObjSelector_4BF9 ; id 0
    dw ObjSelector_4C50 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4BF9:: ; heuristic: map object selector; C0
Data_069_4BF9:: ; address name
    objsel_skip_if_clear $00C4, $04, $00
    objsel_list MapObjects_4C44

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4C03:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_4C03:: ; address name
    objsel_unless_flag $00A8, MapObjects_4C0B
    objsel_list MapObjects_4C2D

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_4C0B::
Data_069_4C0B:: ; address name
    db $03 ; entry 0
    db $85, $00, $1F, $01, $00, $50, $40, $05, $00, $50, $2A
    db $86, $01, $5E, $00, $00, $40, $60, $06, $02, $60, $6A
    db $87, $00, $79, $00, $00, $40, $20, $07, $00, $70, $5D

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_4C2D::
Data_069_4C2D:: ; address name
    db $02 ; entry 0
    db $85, $00, $1F, $01, $00, $50, $40, $05, $00, $50, $2A
    db $86, $01, $5E, $00, $00, $40, $60, $06, $02, $60, $6A

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4C44::
Data_069_4C44:: ; address name
    db $01 ; entry 0
    db $85, $00, $1F, $01, $00, $50, $40, $05, $00, $50, $2A

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4C50:: ; heuristic: map object selector; C0
Data_069_4C50:: ; address name
    objsel_list MapObjects_4C54

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4C54::
Data_069_4C54:: ; address name
    db $01 ; entry 0
    db $85, $00, $79, $00, $00, $00, $E0, $05, $00, $50, $00

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4C60::
Data_069_4C60:: ; address name
    dw ObjSelector_4C68 ; id 0
    dw ObjSelector_4CCA ; id 1
    dw ObjSelector_4CFB ; id 2
    dw ObjSelector_4D2C ; id 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4C68:: ; heuristic: map object selector; C0
Data_069_4C68:: ; address name
    objsel_skip_if_clear $00B6, $04, $00
    objsel_list MapObjects_4CB3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4C72:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_4C72:: ; address name
    objsel_unless_flag $00A8, MapObjects_4C7A
    objsel_list MapObjects_4C91

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_4C7A::
Data_069_4C7A:: ; address name
    db $02 ; entry 0
    db $85, $00, $59, $00, $00, $40, $50, $05, $00, $50, $34
    db $86, $00, $59, $00, $00, $50, $50, $06, $00, $60, $35

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_4C91::
Data_069_4C91:: ; address name
    db $03 ; entry 0
    db $85, $00, $59, $00, $00, $40, $50, $05, $00, $50, $34
    db $86, $00, $59, $00, $00, $50, $50, $06, $00, $60, $35
    db $87, $00, $58, $00, $00, $20, $70, $07, $02, $70, $36

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4CB3::
Data_069_4CB3:: ; address name
    db $02 ; entry 0
    db $85, $00, $59, $00, $00, $60, $60, $05, $00, $50, $35
    db $86, $00, $58, $00, $00, $20, $70, $06, $01, $60, $36

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4CCA:: ; heuristic: map object selector; C0
Data_069_4CCA:: ; address name
    objsel_list MapObjects_4CCE

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4CCE::
Data_069_4CCE:: ; address name
    db $04 ; entry 0
    db $85, $00, $54, $00, $00, $10, $30, $05, $00, $50, $38
    db $86, $00, $03, $00, $02, $40, $60, $06, $01, $60, $39
    db $85, $00, $54, $00, $00, $80, $40, $05, $03, $50, $3A
    db $87, $00, $58, $00, $00, $50, $10, $07, $00, $70, $3B

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4CFB:: ; heuristic: map object selector; C0
Data_069_4CFB:: ; address name
    objsel_list MapObjects_4CFF

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4CFF::
Data_069_4CFF:: ; address name
    db $04 ; entry 0
    db $85, $00, $63, $00, $02, $50, $60, $05, $01, $50, $30
    db $86, $00, $55, $00, $00, $20, $40, $06, $01, $60, $31
    db $87, $00, $62, $00, $00, $70, $10, $07, $00, $70, $32
    db $87, $00, $62, $00, $00, $70, $20, $07, $02, $70, $33

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4D2C:: ; heuristic: map object selector; C0
Data_069_4D2C:: ; address name
    objsel_unless_flag $00A8, MapObjects_4D34
    objsel_list MapObjects_4D56

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4D34::
Data_069_4D34:: ; address name
    db $03 ; entry 0
    db $85, $00, $4E, $00, $00, $30, $70, $05, $00, $50, $2D
    db $86, $00, $4D, $00, $02, $70, $10, $06, $03, $60, $2E
    db $87, $00, $9B, $00, $00, $80, $40, $07, $02, $70, $2F

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4D56::
Data_069_4D56:: ; address name
    db $04 ; entry 0
    db $85, $00, $4E, $00, $00, $30, $70, $05, $00, $50, $2D
    db $86, $00, $4D, $00, $02, $70, $10, $06, $03, $60, $2E
    db $87, $00, $9B, $00, $00, $80, $40, $07, $02, $70, $2F
    db $84, $00, $57, $00, $00, $30, $50, $04, $00, $40, $37

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4D83::
Data_069_4D83:: ; address name
    dw ObjSelector_4D85 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4D85:: ; heuristic: map object selector; C0
Data_069_4D85:: ; address name
    objsel_unless_flag $00A8, MapObjects_4D8D
    objsel_list MapObjects_4D99

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4D8D::
Data_069_4D8D:: ; address name
    db $01 ; entry 0
    db $85, $00, $56, $00, $00, $10, $10, $05, $01, $50, $3D

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4D99::
Data_069_4D99:: ; address name
    db $01 ; entry 0
    db $85, $00, $56, $00, $00, $10, $10, $05, $01, $50, $3F

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4DA5::
Data_069_4DA5:: ; address name
    dw ObjSelector_4DA7 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4DA7:: ; heuristic: map object selector; C0
Data_069_4DA7:: ; address name
    objsel_unless_flag $00A8, MapObjects_4DAF
    objsel_list MapObjects_4DBB

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4DAF::
Data_069_4DAF:: ; address name
    db $01 ; entry 0
    db $85, $00, $80, $00, $00, $30, $10, $05, $00, $50, $43

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4DBB::
Data_069_4DBB:: ; address name
    db $04 ; entry 0
    db $85, $00, $80, $00, $00, $30, $10, $05, $00, $50, $43
    db $86, $00, $5A, $00, $00, $40, $40, $06, $02, $60, $44
    db $87, $00, $76, $00, $00, $50, $50, $07, $00, $70, $45
    db $87, $00, $76, $00, $00, $50, $70, $07, $02, $70, $46

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4DE8::
Data_069_4DE8:: ; address name
    dw ObjSelector_4DEC ; id 0
    dw ObjSelector_4E0C ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4DEC:: ; heuristic: map object selector; C0
Data_069_4DEC:: ; address name
    objsel_unless_flag $00B8, MapObjects_4DF4
    objsel_list MapObjects_4E00

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4DF4::
Data_069_4DF4:: ; address name
    db $01 ; entry 0
    db $85, $00, $61, $00, $00, $50, $40, $05, $00, $50, $5A

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4E00::
Data_069_4E00:: ; address name
    db $01 ; entry 0
    db $85, $00, $61, $00, $00, $40, $40, $05, $00, $50, $5A

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4E0C:: ; heuristic: map object selector; C0
Data_069_4E0C:: ; address name
    objsel_unless_flag $00C2, MapObjects_4E14
    objsel_list MapObjects_4E36

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4E14::
Data_069_4E14:: ; address name
    db $03 ; entry 0
    db $85, $00, $5A, $00, $00, $30, $30, $05, $01, $50, $57
    db $86, $00, $59, $00, $00, $70, $50, $06, $00, $60, $58
    db $87, $00, $57, $00, $00, $70, $70, $07, $02, $70, $59

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4E36::
Data_069_4E36:: ; address name
    db $01 ; entry 0
    db $85, $00, $5A, $00, $00, $30, $30, $05, $01, $50, $57

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4E42::
Data_069_4E42:: ; address name
    dw ObjSelector_4E44 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4E44:: ; heuristic: map object selector; C0
Data_069_4E44:: ; address name
    objsel_unless_flag $00AE, MapObjects_4E4A
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4E4A::
Data_069_4E4A:: ; address name
    db $01 ; entry 0
    db $85, $00, $12, $00, $00, $40, $30, $05, $00, $50, $4A

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4E56::
Data_069_4E56:: ; address name
    dw ObjSelector_4E5E ; id 0
    dw $0000 ; id 1
    dw ObjSelector_4E6E ; id 2
    dw ObjSelector_4E89 ; id 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4E5E:: ; heuristic: map object selector; C0
Data_069_4E5E:: ; address name
    objsel_list MapObjects_4E62

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4E62::
Data_069_4E62:: ; address name
    db $01 ; entry 0
    db $85, $00, $5E, $00, $00, $80, $60, $05, $02, $50, $0A

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4E6E:: ; heuristic: map object selector; C0
Data_069_4E6E:: ; address name
    objsel_list MapObjects_4E72

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4E72::
Data_069_4E72:: ; address name
    db $02 ; entry 0
    db $85, $00, $5D, $00, $00, $60, $60, $05, $00, $50, $09
    db $86, $00, $55, $00, $00, $10, $50, $06, $00, $60, $07

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4E89:: ; heuristic: map object selector; C0
Data_069_4E89:: ; address name
    objsel_list MapObjects_4E8D

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4E8D::
Data_069_4E8D:: ; address name
    db $01 ; entry 0
    db $85, $00, $50, $00, $00, $40, $60, $05, $02, $50, $08

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4E99::
Data_069_4E99:: ; address name
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
ObjSelector_4EAB:: ; heuristic: map object selector; C0
Data_069_4EAB:: ; address name
    objsel_unless_flag $00C5, MapObjects_4EB1
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4EB1::
Data_069_4EB1:: ; address name
    db $01 ; entry 0
    db $85, $00, $0A, $01, $00, $20, $20, $05, $00, $50, $4C

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4EBD::
Data_069_4EBD:: ; address name
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
ObjSelector_4ECF:: ; heuristic: map object selector; C0
Data_069_4ECF:: ; address name
    objsel_list MapObjects_4ED5

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4ED3:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_4ED3:: ; address name
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4ED5::
Data_069_4ED5:: ; address name
    db $03 ; entry 0
    db $85, $01, $44, $00, $00, $30, $30, $05, $00, $50, $69
    db $86, $01, $44, $00, $00, $60, $40, $06, $00, $60, $69
    db $87, $01, $44, $00, $00, $80, $20, $07, $01, $70, $69

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4EF7:: ; heuristic: map object selector; C0
Data_069_4EF7:: ; address name
    objsel_list MapObjects_4EFB

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4EFB::
Data_069_4EFB:: ; address name
    db $01 ; entry 0
    db $85, $01, $44, $00, $00, $30, $50, $05, $00, $50, $69

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4F07:: ; heuristic: map object selector; C0
Data_069_4F07:: ; address name
    objsel_list MapObjects_4F0B

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4F0B::
Data_069_4F0B:: ; address name
    db $03 ; entry 0
    db $85, $01, $44, $00, $00, $10, $30, $05, $03, $50, $69
    db $86, $01, $44, $00, $00, $20, $50, $06, $01, $60, $69
    db $87, $01, $44, $00, $00, $30, $60, $07, $00, $70, $69

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4F2D:: ; heuristic: map object selector; C0
Data_069_4F2D:: ; address name
    objsel_list MapObjects_4F31

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4F31::
Data_069_4F31:: ; address name
    db $03 ; entry 0
    db $85, $01, $44, $00, $00, $30, $70, $05, $01, $50, $69
    db $86, $01, $44, $00, $00, $50, $30, $06, $03, $60, $69
    db $87, $01, $44, $00, $00, $80, $40, $07, $02, $70, $69

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4F53:: ; heuristic: map object selector; C0
Data_069_4F53:: ; address name
    objsel_list MapObjects_4F57

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4F57::
Data_069_4F57:: ; address name
    db $01 ; entry 0
    db $85, $01, $44, $00, $00, $30, $30, $05, $01, $50, $69

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4F63:: ; heuristic: map object selector; C0
Data_069_4F63:: ; address name
    objsel_list MapObjects_4F67

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4F67::
Data_069_4F67:: ; address name
    db $03 ; entry 0
    db $85, $01, $44, $00, $00, $10, $30, $05, $02, $50, $69
    db $86, $01, $44, $00, $00, $20, $70, $06, $02, $60, $69
    db $87, $01, $44, $00, $00, $30, $40, $07, $01, $70, $69

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4F89::
Data_069_4F89:: ; address name
    dw ObjSelector_4F8B ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4F8B:: ; heuristic: map object selector; C0
Data_069_4F8B:: ; address name
    objsel_unless_flag $00B1, MapObjects_4F91
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4F91::
Data_069_4F91:: ; address name
    db $01 ; entry 0
    db $85, $00, $F6, $00, $00, $40, $40, $05, $00, $50, $4F

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4F9D::
Data_069_4F9D:: ; address name
    dw ObjSelector_4FA9 ; id 0
    dw ObjSelector_4FBB ; id 1
    dw $0000 ; id 2
    dw $0000 ; id 3
    dw $0000 ; id 4
    dw $0000 ; id 5

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4FA9:: ; heuristic: map object selector; C0
Data_069_4FA9:: ; address name
    objsel_unless_flag $00C6, MapObjects_4FAF
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4FAF::
Data_069_4FAF:: ; address name
    db $01 ; entry 0
    db $85, $00, $0A, $01, $00, $50, $20, $05, $00, $50, $6E

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4FBB:: ; heuristic: map object selector; C0
Data_069_4FBB:: ; address name
    objsel_unless_flag $00C7, MapObjects_4FC1
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4FC1::
Data_069_4FC1:: ; address name
    db $01 ; entry 0
    db $85, $00, $0A, $01, $00, $80, $50, $05, $03, $50, $6F

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4FCD::
Data_069_4FCD:: ; address name
    dw ObjSelector_4FCF ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4FCF:: ; heuristic: map object selector; C0
Data_069_4FCF:: ; address name
    objsel_unless_flag $00B4, MapObjects_4FD5
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4FD5::
Data_069_4FD5:: ; address name
    db $01 ; entry 0
    db $85, $00, $10, $01, $00, $40, $30, $05, $00, $50, $55

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4FE1::
Data_069_4FE1:: ; address name
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
ObjSelector_4FF3:: ; heuristic: map object selector; C0
Data_069_4FF3:: ; address name
    objsel_skip_if_clear $0024, $02, $00
    objsel_none

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4FFB:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_4FFB:: ; address name
    objsel_unless_flag $00B9, MapObjects_5001
    objsel_none

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_5001::
Data_069_5001:: ; address name
    db $01 ; entry 0
    db $85, $00, $EC, $00, $00, $40, $20, $05, $00, $50, $5C

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_500D:: ; heuristic: map object selector; C0
Data_069_500D:: ; address name
    objsel_skip_if_clear $0024, $02, $00
    objsel_none

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5015:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_5015:: ; address name
    objsel_unless_flag $00BA, MapObjects_501B
    objsel_none

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_501B::
Data_069_501B:: ; address name
    db $01 ; entry 0
    db $85, $00, $EC, $00, $00, $40, $20, $05, $00, $50, $5C

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5027:: ; heuristic: map object selector; C0
Data_069_5027:: ; address name
    objsel_skip_if_clear $0024, $02, $00
    objsel_none

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_502F:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_502F:: ; address name
    objsel_unless_flag $00BB, MapObjects_5035
    objsel_none

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_5035::
Data_069_5035:: ; address name
    db $01 ; entry 0
    db $85, $00, $EC, $00, $00, $40, $20, $05, $00, $50, $5C

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5041:: ; heuristic: map object selector; C0
Data_069_5041:: ; address name
    objsel_unless_flag $0024, MapObjects_5047
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5047::
Data_069_5047:: ; address name
    db $01 ; entry 0
    db $85, $00, $D6, $00, $00, $40, $20, $05, $00, $50, $5F

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5053:: ; heuristic: map object selector; C0
Data_069_5053:: ; address name
    objsel_unless_flag $0024, MapObjects_5059
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5059::
Data_069_5059:: ; address name
    db $01 ; entry 0
    db $85, $00, $D6, $00, $00, $30, $40, $05, $03, $50, $60

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_5065::
Data_069_5065:: ; address name
    dw $0000 ; id 0
    dw $0000 ; id 1
    dw $0000 ; id 2
    dw $0000 ; id 3
    dw $0000 ; id 4
    dw ObjSelector_5071 ; id 5

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5071:: ; heuristic: map object selector; C0
Data_069_5071:: ; address name
    objsel_unless_flag $0024, MapObjects_5077
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5077::
Data_069_5077:: ; address name
    db $01 ; entry 0
    db $85, $00, $D6, $00, $00, $80, $40, $05, $00, $50, $61

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_5083::
Data_069_5083:: ; address name
    dw $0000 ; id 0
    dw ObjSelector_508B ; id 1
    dw $0000 ; id 2
    dw $0000 ; id 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_508B:: ; heuristic: map object selector; C0
Data_069_508B:: ; address name
    objsel_skip_if_clear $0024, $02, $00
    objsel_none

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5093:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_5093:: ; address name
    objsel_unless_flag $0201, MapObjects_5099
    objsel_none

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_5099::
Data_069_5099:: ; address name
    db $01 ; entry 0
    db $85, $00, $EC, $00, $00, $10, $40, $05, $01, $50, $5C

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_50A5::
Data_069_50A5:: ; address name
    dw ObjSelector_50AB ; id 0
    dw ObjSelector_50DE ; id 1
    dw $0000 ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_50AB:: ; heuristic: map object selector; C0
Data_069_50AB:: ; address name
    objsel_skip_if_clear $00C3, $02, $00
    objsel_none

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_50B3:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_50B3:: ; address name
    objsel_unless_flag $00C2, MapObjects_50BB
    objsel_list MapObjects_50D2

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_50BB::
Data_069_50BB:: ; address name
    db $02 ; entry 0
    db $85, $01, $03, $00, $00, $40, $20, $05, $00, $50, $5C
    db $86, $01, $48, $00, $05, $48, $C0, $06, $00, $60, $00

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_50D2::
Data_069_50D2:: ; address name
    db $01 ; entry 0
    db $85, $01, $03, $00, $00, $50, $30, $05, $02, $50, $5C

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_50DE:: ; heuristic: map object selector; C0
Data_069_50DE:: ; address name
    objsel_unless_flag $00C1, MapObjects_50E4
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_50E4::
Data_069_50E4:: ; address name
    db $01 ; entry 0
    db $85, $01, $54, $00, $04, $48, $20, $05, $00, $50, $67

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_50F0::
Data_069_50F0:: ; address name
    dw ObjSelector_50F2 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_50F2:: ; heuristic: map object selector; C0
Data_069_50F2:: ; address name
    objsel_skip_if_set $0025, $0A, $00
    objsel_skip_if_clear $00D1, $04, $00
    objsel_list MapObjects_519C

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5102:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_5102:: ; address name
    objsel_skip_if_clear $01E5, $02, $00
    objsel_none

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_510A:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_510A:: ; address name
    objsel_skip_if_clear $01E4, $04, $00
    objsel_list MapObjects_5158

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5114:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_5114:: ; address name
    objsel_skip_if_clear $0080, $08, $00
    objsel_unless_flag $01E3, MapObjects_5158
    objsel_list MapObjects_517A

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5122:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_5122:: ; address name
    objsel_unless_flag $01E8, MapObjects_512A
    objsel_list MapObjects_5141

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_512A::
Data_069_512A:: ; address name
    db $02 ; entry 0
    db $85, $01, $5B, $00, $00, $40, $30, $05, $00, $50, $14
    db $86, $01, $5A, $00, $00, $60, $E0, $06, $00, $60, $A0

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_5141::
Data_069_5141:: ; address name
    db $02 ; entry 0
    db $85, $01, $5B, $00, $00, $40, $30, $05, $00, $50, $14
    db $86, $01, $5A, $00, $00, $60, $70, $06, $00, $60, $A0

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_5158::
Data_069_5158:: ; address name
    db $03 ; entry 0
    db $85, $01, $5B, $00, $00, $40, $30, $05, $00, $50, $14
    db $86, $01, $5C, $00, $00, $40, $E0, $06, $00, $60, $9F
    db $87, $01, $53, $00, $00, $40, $E0, $07, $00, $70, $00

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_517A::
Data_069_517A:: ; address name
    db $03 ; entry 0
    db $85, $01, $5B, $00, $00, $40, $30, $05, $00, $50, $14
    db $86, $01, $5C, $00, $00, $40, $40, $06, $00, $60, $9F
    db $87, $01, $53, $00, $00, $40, $E0, $07, $00, $70, $00

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 5 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_519C::
Data_069_519C:: ; address name
    db $05 ; entry 0
    db $85, $01, $53, $00, $00, $40, $E0, $05, $00, $50, $00
    db $86, $01, $3A, $00, $00, $40, $50, $06, $02, $60, $72
    db $87, $01, $42, $00, $00, $50, $70, $07, $03, $70, $2E
    db $83, $01, $52, $00, $00, $30, $B0, $03, $02, $30, $61
    db $83, $01, $52, $00, $00, $50, $B0, $03, $02, $30, $61

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_51D4::
Data_069_51D4:: ; address name
    dw ObjSelector_51DC ; id 0
    dw ObjSelector_523E ; id 1
    dw ObjSelector_5264 ; id 2
    dw ObjSelector_5295 ; id 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_51DC:: ; heuristic: map object selector; C0
Data_069_51DC:: ; address name
    objsel_unless_flag $0081, MapObjects_51E4
    objsel_list MapObjects_5211

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_51E4::
Data_069_51E4:: ; address name
    db $04 ; entry 0
    db $85, $01, $10, $00, $00, $40, $10, $05, $00, $50, $0B
    db $85, $01, $10, $00, $00, $50, $10, $05, $00, $50, $0C
    db $86, $01, $2F, $00, $00, $10, $40, $06, $01, $60, $09
    db $87, $01, $30, $00, $00, $70, $70, $07, $02, $70, $0A

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5211::
Data_069_5211:: ; address name
    db $04 ; entry 0
    db $85, $01, $10, $00, $00, $30, $20, $05, $00, $50, $0B
    db $85, $01, $10, $00, $02, $60, $30, $05, $00, $50, $0C
    db $86, $01, $2F, $00, $00, $10, $40, $06, $01, $60, $09
    db $87, $01, $30, $00, $00, $70, $70, $07, $02, $70, $0A

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_523E:: ; heuristic: map object selector; C0
Data_069_523E:: ; address name
    objsel_list MapObjects_5242

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5242::
Data_069_5242:: ; address name
    db $03 ; entry 0
    db $85, $01, $2E, $00, $00, $60, $70, $05, $03, $50, $05
    db $86, $01, $2D, $00, $02, $40, $50, $06, $01, $60, $06
    db $87, $01, $12, $00, $00, $20, $30, $07, $00, $70, $82

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5264:: ; heuristic: map object selector; C0
Data_069_5264:: ; address name
    objsel_list MapObjects_5268

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5268::
Data_069_5268:: ; address name
    db $04 ; entry 0
    db $85, $01, $10, $00, $00, $60, $60, $05, $00, $50, $00
    db $86, $01, $2E, $00, $00, $80, $50, $06, $02, $60, $01
    db $87, $01, $30, $00, $00, $10, $40, $07, $01, $70, $02
    db $86, $01, $2E, $00, $00, $20, $10, $06, $00, $60, $03

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5295:: ; heuristic: map object selector; C0
Data_069_5295:: ; address name
    objsel_list MapObjects_5299

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5299::
Data_069_5299:: ; address name
    db $04 ; entry 0
    db $85, $01, $2F, $00, $02, $50, $50, $05, $01, $50, $04
    db $85, $01, $2F, $00, $00, $30, $40, $05, $03, $50, $07
    db $86, $01, $12, $00, $00, $80, $60, $06, $03, $60, $08
    db $87, $01, $15, $00, $00, $70, $20, $07, $00, $70, $0D

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_52C6::
Data_069_52C6:: ; address name
    dw ObjSelector_52C8 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_52C8:: ; heuristic: map object selector; C0
Data_069_52C8:: ; address name
    objsel_unless_flag $0094, MapObjects_52D0
    objsel_list MapObjects_52E7

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_52D0::
Data_069_52D0:: ; address name
    db $02 ; entry 0
    db $85, $01, $2E, $00, $00, $60, $20, $05, $01, $50, $12
    db $86, $01, $15, $00, $00, $20, $50, $06, $01, $60, $13

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_52E7::
Data_069_52E7:: ; address name
    db $01 ; entry 0
    db $85, $01, $2E, $00, $00, $60, $20, $05, $01, $50, $12

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_52F3::
Data_069_52F3:: ; address name
    dw ObjSelector_52FB ; id 0
    dw ObjSelector_537E ; id 1
    dw ObjSelector_538E ; id 2
    dw ObjSelector_53EF ; id 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_52FB:: ; heuristic: map object selector; C0
Data_069_52FB:: ; address name
    objsel_skip_if_clear $0094, $04, $00
    objsel_list MapObjects_5367

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5305:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_5305:: ; address name
    objsel_skip_if_clear $0093, $04, $00
    objsel_list MapObjects_5350

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_530F:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_530F:: ; address name
    objsel_unless_flag $008A, MapObjects_5317
    objsel_list MapObjects_532E

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_5317::
Data_069_5317:: ; address name
    db $02 ; entry 0
    db $85, $01, $0E, $00, $00, $40, $30, $05, $00, $50, $00
    db $86, $01, $10, $00, $00, $40, $70, $06, $02, $60, $18

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_532E::
Data_069_532E:: ; address name
    db $03 ; entry 0
    db $85, $00, $D5, $00, $00, $40, $E0, $05, $02, $50, $4D
    db $86, $01, $0E, $00, $00, $40, $50, $06, $02, $60, $48
    db $87, $01, $0E, $00, $00, $40, $40, $07, $00, $70, $4D

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_5350::
Data_069_5350:: ; address name
    db $02 ; entry 0
    db $85, $00, $D5, $00, $00, $40, $40, $05, $00, $50, $4D
    db $86, $01, $0E, $00, $00, $40, $50, $06, $02, $60, $48

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5367::
Data_069_5367:: ; address name
    db $02 ; entry 0
    db $85, $01, $0E, $00, $00, $40, $30, $05, $00, $50, $48
    db $86, $01, $0E, $00, $00, $E0, $E0, $06, $00, $60, $00

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_537E:: ; heuristic: map object selector; C0
Data_069_537E:: ; address name
    objsel_list MapObjects_5382

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5382::
Data_069_5382:: ; address name
    db $01 ; entry 0
    db $85, $01, $12, $00, $00, $20, $20, $05, $02, $50, $17

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_538E:: ; heuristic: map object selector; C0
Data_069_538E:: ; address name
    objsel_skip_if_clear $0087, $04, $00
    objsel_list MapObjects_53D8

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5398:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_5398:: ; address name
    objsel_skip_if_clear $0082, $04, $00
    objsel_list MapObjects_53AA

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_53A2:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_53A2:: ; address name
    objsel_unless_flag $0083, MapObjects_53AA
    objsel_list MapObjects_53C1

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_53AA::
Data_069_53AA:: ; address name
    db $02 ; entry 0
    db $85, $01, $10, $00, $00, $50, $00, $05, $00, $50, $15
    db $86, $01, $10, $00, $00, $40, $00, $06, $00, $60, $18

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_53C1::
Data_069_53C1:: ; address name
    db $02 ; entry 0
    db $85, $01, $10, $00, $00, $50, $00, $05, $00, $50, $15
    db $86, $01, $10, $00, $00, $40, $E0, $06, $00, $60, $18

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_53D8::
Data_069_53D8:: ; address name
    db $02 ; entry 0
    db $85, $01, $10, $00, $00, $60, $20, $05, $00, $50, $15
    db $86, $01, $10, $00, $00, $30, $30, $06, $00, $60, $18

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_53EF:: ; heuristic: map object selector; C0
Data_069_53EF:: ; address name
    objsel_list MapObjects_53F3

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_53F3::
Data_069_53F3:: ; address name
    db $01 ; entry 0
    db $85, $01, $10, $00, $00, $80, $30, $05, $00, $50, $16

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_53FF::
Data_069_53FF:: ; address name
    dw $0000 ; id 0
    dw ObjSelector_5403 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5403:: ; heuristic: map object selector; C0
Data_069_5403:: ; address name
    objsel_unless_flag $008A, MapObjects_5409
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5409::
Data_069_5409:: ; address name
    db $02 ; entry 0
    db $85, $01, $0E, $00, $00, $70, $30, $05, $00, $50, $48
    db $86, $01, $03, $00, $00, $30, $50, $06, $03, $60, $49

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_5420::
Data_069_5420:: ; address name
    dw ObjSelector_5426 ; id 0
    dw $0000 ; id 1
    dw $0000 ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5426:: ; heuristic: map object selector; C0
Data_069_5426:: ; address name
    objsel_list MapObjects_542A

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_542A::
Data_069_542A:: ; address name
    db $01 ; entry 0
    db $85, $01, $2E, $00, $00, $50, $30, $05, $00, $50, $1C

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_5436::
Data_069_5436:: ; address name
    dw ObjSelector_543E ; id 0
    dw ObjSelector_546F ; id 1
    dw ObjSelector_54C6 ; id 2
    dw ObjSelector_54F7 ; id 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_543E:: ; heuristic: map object selector; C0
Data_069_543E:: ; address name
    objsel_list MapObjects_5442

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5442::
Data_069_5442:: ; address name
    db $04 ; entry 0
    db $85, $01, $30, $00, $00, $30, $50, $05, $00, $50, $1D
    db $85, $01, $30, $00, $00, $50, $40, $05, $00, $50, $1F
    db $86, $01, $2F, $00, $02, $70, $60, $06, $01, $60, $20
    db $87, $01, $12, $00, $00, $70, $20, $07, $00, $70, $2C

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_546F:: ; heuristic: map object selector; C0
Data_069_546F:: ; address name
    objsel_unless_flag $01E5, MapObjects_5477
    objsel_list MapObjects_54A4

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5477::
Data_069_5477:: ; address name
    db $04 ; entry 0
    db $85, $01, $16, $00, $00, $10, $30, $05, $01, $50, $29
    db $86, $01, $15, $00, $00, $70, $20, $06, $00, $60, $2A
    db $86, $01, $15, $00, $00, $80, $40, $06, $03, $60, $2B
    db $87, $01, $29, $00, $00, $70, $50, $07, $01, $70, $28

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_54A4::
Data_069_54A4:: ; address name
    db $03 ; entry 0
    db $85, $01, $16, $00, $00, $10, $30, $05, $01, $50, $29
    db $86, $01, $15, $00, $00, $70, $20, $06, $00, $60, $2A
    db $86, $01, $15, $00, $00, $80, $40, $06, $03, $60, $2B

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_54C6:: ; heuristic: map object selector; C0
Data_069_54C6:: ; address name
    objsel_list MapObjects_54CA

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_54CA::
Data_069_54CA:: ; address name
    db $04 ; entry 0
    db $85, $01, $2E, $00, $00, $10, $20, $05, $00, $50, $21
    db $86, $01, $2D, $00, $02, $40, $50, $06, $01, $60, $22
    db $85, $01, $2E, $00, $00, $60, $60, $05, $00, $50, $23
    db $87, $01, $2F, $00, $00, $70, $10, $07, $03, $70, $24

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_54F7:: ; heuristic: map object selector; C0
Data_069_54F7:: ; address name
    objsel_list MapObjects_54FB

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_54FB::
Data_069_54FB:: ; address name
    db $04 ; entry 0
    db $85, $01, $2E, $00, $00, $40, $50, $05, $00, $50, $1E
    db $86, $01, $30, $00, $00, $80, $20, $06, $03, $60, $25
    db $85, $01, $2E, $00, $00, $20, $30, $05, $00, $50, $26
    db $87, $01, $10, $00, $00, $20, $10, $07, $01, $70, $27

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_5528::
Data_069_5528:: ; address name
    dw ObjSelector_552A ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_552A:: ; heuristic: map object selector; C0
Data_069_552A:: ; address name
    objsel_unless_flag $01E5, MapObjects_5532
    objsel_list MapObjects_555F

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5532::
Data_069_5532:: ; address name
    db $04 ; entry 0
    db $85, $01, $16, $00, $00, $20, $20, $05, $01, $50, $31
    db $85, $01, $16, $00, $00, $40, $30, $05, $02, $50, $32
    db $86, $01, $17, $00, $00, $40, $50, $06, $00, $60, $33
    db $87, $01, $21, $00, $00, $10, $60, $07, $00, $70, $34

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_555F::
Data_069_555F:: ; address name
    db $02 ; entry 0
    db $85, $01, $16, $00, $00, $20, $20, $05, $01, $50, $31
    db $86, $01, $17, $00, $00, $40, $50, $06, $00, $60, $33

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_5576::
Data_069_5576:: ; address name
    dw ObjSelector_5578 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5578:: ; heuristic: map object selector; C0
Data_069_5578:: ; address name
    objsel_list MapObjects_557C

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_557C::
Data_069_557C:: ; address name
    db $02 ; entry 0
    db $85, $01, $2E, $00, $00, $10, $10, $05, $01, $50, $36
    db $86, $01, $29, $00, $00, $20, $70, $06, $02, $60, $37

Data_069_5593:: ; heuristic: map object screen array; C0
    db $99, $55, $00, $00, $B4, $55

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5599:: ; heuristic: map object selector; C0
Data_069_5599:: ; address name
    objsel_list MapObjects_559D

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_559D::
Data_069_559D:: ; address name
    db $02 ; entry 0
    db $85, $01, $52, $00, $00, $40, $30, $05, $00, $50, $3C
    db $86, $01, $52, $00, $00, $70, $40, $06, $03, $60, $3D

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_55B4:: ; heuristic: map object selector; C0
Data_069_55B4:: ; address name
    objsel_unless_flag $0094, MapObjects_55BC
    objsel_list MapObjects_55E9

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_55BC::
Data_069_55BC:: ; address name
    db $04 ; entry 0
    db $85, $01, $10, $00, $00, $30, $30, $05, $00, $50, $38
    db $85, $01, $10, $00, $00, $00, $40, $05, $01, $50, $39
    db $85, $01, $10, $00, $00, $00, $50, $05, $01, $50, $3A
    db $86, $01, $16, $00, $00, $70, $60, $06, $00, $60, $3B

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_55E9::
Data_069_55E9:: ; address name
    db $04 ; entry 0
    db $85, $01, $10, $00, $00, $30, $30, $05, $00, $50, $38
    db $85, $01, $10, $00, $00, $60, $40, $05, $00, $50, $39
    db $85, $01, $10, $00, $00, $60, $50, $05, $02, $50, $3A
    db $86, $01, $16, $00, $00, $70, $60, $06, $00, $60, $3B

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_5616::
Data_069_5616:: ; address name
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
ObjSelector_5636:: ; heuristic: map object selector; C0
Data_069_5636:: ; address name
    objsel_list MapObjects_563A

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_563A::
Data_069_563A:: ; address name
    db $01 ; entry 0
    db $85, $01, $16, $00, $00, $70, $30, $05, $00, $50, $3F

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5646:: ; heuristic: map object selector; C0
Data_069_5646:: ; address name
    objsel_unless_flag $0094, MapObjects_564E
    objsel_list MapObjects_5670

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_564E::
Data_069_564E:: ; address name
    db $03 ; entry 0
    db $85, $01, $52, $00, $00, $40, $60, $05, $02, $50, $3C
    db $86, $01, $52, $00, $00, $50, $60, $06, $02, $60, $3D
    db $87, $01, $16, $00, $02, $50, $20, $07, $01, $70, $3E

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5670::
Data_069_5670:: ; address name
    db $01 ; entry 0
    db $85, $01, $16, $00, $02, $50, $20, $05, $01, $50, $3E

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_567C::
Data_069_567C:: ; address name
    dw ObjSelector_567E ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_567E:: ; heuristic: map object selector; C0
Data_069_567E:: ; address name
    objsel_list MapObjects_5682

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5682::
Data_069_5682:: ; address name
    db $01 ; entry 0
    db $85, $01, $52, $00, $00, $60, $30, $05, $00, $50, $40

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_568E::
Data_069_568E:: ; address name
    dw $0000 ; id 0
    dw ObjSelector_5692 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5692:: ; heuristic: map object selector; C0
Data_069_5692:: ; address name
    objsel_list MapObjects_5696

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5696::
Data_069_5696:: ; address name
    db $01 ; entry 0
    db $85, $01, $16, $00, $00, $50, $50, $05, $03, $50, $41

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_56A2::
Data_069_56A2:: ; address name
    dw ObjSelector_56A8 ; id 0
    dw ObjSelector_56BA ; id 1
    dw ObjSelector_570E ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_56A8:: ; heuristic: map object selector; C0
Data_069_56A8:: ; address name
    objsel_unless_flag $0086, MapObjects_56AE
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_56AE::
Data_069_56AE:: ; address name
    db $01 ; entry 0
    db $85, $01, $16, $00, $02, $60, $10, $05, $01, $50, $44

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_56BA:: ; heuristic: map object selector; C0
Data_069_56BA:: ; address name
    objsel_skip_if_clear $0086, $02, $00
    objsel_none

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_56C2:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_56C2:: ; address name
    objsel_unless_flag $0085, MapObjects_56CA
    objsel_list MapObjects_56EC

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_56CA::
Data_069_56CA:: ; address name
    db $03 ; entry 0
    db $85, $00, $34, $01, $00, $40, $E0, $05, $00, $50, $46
    db $86, $01, $10, $00, $00, $B0, $10, $06, $02, $60, $00
    db $87, $01, $52, $00, $00, $E0, $10, $07, $00, $70, $00

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_56EC::
Data_069_56EC:: ; address name
    db $03 ; entry 0
    db $85, $00, $34, $01, $00, $40, $20, $05, $00, $50, $46
    db $86, $01, $10, $00, $00, $B0, $10, $06, $02, $60, $00
    db $87, $01, $52, $00, $00, $E0, $10, $07, $00, $70, $00

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_570E:: ; heuristic: map object selector; C0
Data_069_570E:: ; address name
    objsel_unless_flag $0086, MapObjects_5714
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5714::
Data_069_5714:: ; address name
    db $02 ; entry 0
    db $85, $01, $16, $00, $02, $30, $10, $05, $01, $50, $42
    db $86, $01, $10, $00, $00, $70, $30, $06, $02, $60, $43

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_572B::
Data_069_572B:: ; address name
    dw ObjSelector_5733 ; id 0
    dw ObjSelector_5764 ; id 1
    dw ObjSelector_5795 ; id 2
    dw ObjSelector_57C6 ; id 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5733:: ; heuristic: map object selector; C0
Data_069_5733:: ; address name
    objsel_list MapObjects_5737

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5737::
Data_069_5737:: ; address name
    db $04 ; entry 0
    db $85, $01, $52, $00, $00, $60, $40, $05, $00, $50, $56
    db $86, $01, $2E, $00, $00, $30, $70, $06, $03, $60, $57
    db $87, $01, $2F, $00, $00, $30, $10, $07, $00, $70, $58
    db $84, $01, $12, $00, $00, $70, $20, $04, $00, $40, $83

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5764:: ; heuristic: map object selector; C0
Data_069_5764:: ; address name
    objsel_list MapObjects_5768

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5768::
Data_069_5768:: ; address name
    db $04 ; entry 0
    db $85, $01, $30, $00, $00, $10, $20, $05, $00, $50, $52
    db $86, $01, $2D, $00, $00, $80, $30, $06, $01, $60, $53
    db $87, $01, $2E, $00, $00, $70, $60, $07, $02, $70, $54
    db $87, $01, $2E, $00, $02, $40, $50, $07, $01, $70, $55

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5795:: ; heuristic: map object selector; C0
Data_069_5795:: ; address name
    objsel_list MapObjects_5799

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5799::
Data_069_5799:: ; address name
    db $04 ; entry 0
    db $85, $01, $2F, $00, $00, $40, $40, $05, $00, $50, $4E
    db $86, $01, $2E, $00, $00, $10, $60, $06, $01, $60, $4F
    db $87, $01, $15, $00, $00, $70, $50, $07, $00, $70, $50
    db $85, $01, $2F, $00, $02, $30, $10, $05, $00, $50, $51

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_57C6:: ; heuristic: map object selector; C0
Data_069_57C6:: ; address name
    objsel_list MapObjects_57CA

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_57CA::
Data_069_57CA:: ; address name
    db $02 ; entry 0
    db $85, $01, $2D, $00, $00, $30, $50, $05, $00, $50, $59
    db $86, $01, $30, $00, $02, $60, $40, $06, $01, $60, $5A

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_57E1::
Data_069_57E1:: ; address name
    dw ObjSelector_57E5 ; id 0
    dw ObjSelector_5800 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_57E5:: ; heuristic: map object selector; C0
Data_069_57E5:: ; address name
    objsel_list MapObjects_57E9

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_57E9::
Data_069_57E9:: ; address name
    db $02 ; entry 0
    db $85, $01, $2E, $00, $00, $80, $10, $05, $00, $50, $5E
    db $86, $01, $15, $00, $00, $60, $10, $06, $00, $60, $5F

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5800:: ; heuristic: map object selector; C0
Data_069_5800:: ; address name
    objsel_list MapObjects_5804

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5804::
Data_069_5804:: ; address name
    db $01 ; entry 0
    db $85, $01, $29, $00, $00, $20, $20, $05, $00, $50, $60

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_5810::
Data_069_5810:: ; address name
    dw ObjSelector_5814 ; id 0
    dw ObjSelector_585D ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5814:: ; heuristic: map object selector; C0
Data_069_5814:: ; address name
    objsel_skip_if_clear $01E5, $04, $00
    objsel_list MapObjects_5851

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_581E:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_581E:: ; address name
    objsel_unless_flag $0096, MapObjects_5824
    objsel_none

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 4 object(s), the layout of the other object lists
MapObjects_5824::
Data_069_5824:: ; address name
    db $04 ; entry 0
    db $85, $01, $52, $00, $00, $80, $60, $05, $00, $50, $61
    db $85, $01, $52, $00, $00, $40, $50, $05, $00, $50, $67
    db $86, $01, $15, $00, $02, $20, $70, $06, $01, $60, $63
    db $87, $01, $4C, $00, $00, $60, $80, $07, $02, $70, $65

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5851::
Data_069_5851:: ; address name
    db $01 ; entry 0
    db $87, $01, $42, $00, $00, $30, $50, $07, $00, $70, $2E

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_585D:: ; heuristic: map object selector; C0
Data_069_585D:: ; address name
    objsel_skip_if_clear $0096, $04, $00
    objsel_list MapObjects_58A8

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5867:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_5867:: ; address name
    objsel_unless_flag $0095, MapObjects_586F
    objsel_list MapObjects_589C

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 4 object(s), the layout of the other object lists
MapObjects_586F::
Data_069_586F:: ; address name
    db $04 ; entry 0
    db $85, $01, $52, $00, $00, $30, $40, $05, $01, $50, $66
    db $86, $01, $4C, $00, $00, $40, $40, $06, $02, $60, $62
    db $86, $01, $4C, $00, $00, $40, $50, $06, $02, $60, $64
    db $87, $01, $03, $00, $00, $40, $A0, $07, $02, $70, $00

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_589C::
Data_069_589C:: ; address name
    db $01 ; entry 0
    db $85, $01, $52, $00, $00, $30, $50, $05, $00, $50, $66

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_58A8::
Data_069_58A8:: ; address name
    db $03 ; entry 0
    db $85, $01, $52, $00, $00, $20, $50, $05, $00, $50, $66
    db $86, $01, $52, $00, $00, $70, $60, $06, $03, $60, $61
    db $87, $01, $52, $00, $00, $10, $70, $07, $00, $70, $67

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_58CA::
Data_069_58CA:: ; address name
    dw ObjSelector_58D2 ; id 0
    dw ObjSelector_58ED ; id 1
    dw ObjSelector_5944 ; id 2
    dw ObjSelector_595F ; id 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_58D2:: ; heuristic: map object selector; C0
Data_069_58D2:: ; address name
    objsel_list MapObjects_58D6

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_58D6::
Data_069_58D6:: ; address name
    db $02 ; entry 0
    db $85, $01, $52, $00, $00, $70, $40, $05, $00, $50, $6E
    db $86, $01, $14, $00, $00, $20, $10, $06, $02, $60, $6B

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_58ED:: ; heuristic: map object selector; C0
Data_069_58ED:: ; address name
    objsel_skip_if_clear $009B, $04, $00
    objsel_list MapObjects_5938

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_58F7:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_58F7:: ; address name
    objsel_unless_flag $0096, MapObjects_58FF
    objsel_list MapObjects_5921

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_58FF::
Data_069_58FF:: ; address name
    db $03 ; entry 0
    db $85, $01, $0E, $00, $00, $40, $20, $05, $00, $50, $71
    db $86, $01, $3A, $00, $00, $50, $20, $06, $00, $60, $72
    db $87, $01, $03, $00, $00, $40, $40, $07, $02, $70, $00

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_5921::
Data_069_5921:: ; address name
    db $02 ; entry 0
    db $85, $01, $0E, $00, $00, $40, $20, $05, $00, $50, $71
    db $86, $01, $3A, $00, $00, $50, $20, $06, $00, $60, $72

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5938::
Data_069_5938:: ; address name
    db $01 ; entry 0
    db $85, $01, $0E, $00, $00, $40, $20, $05, $00, $50, $71

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5944:: ; heuristic: map object selector; C0
Data_069_5944:: ; address name
    objsel_list MapObjects_5948

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5948::
Data_069_5948:: ; address name
    db $02 ; entry 0
    db $86, $01, $12, $00, $00, $30, $60, $06, $03, $60, $6C
    db $87, $01, $52, $00, $00, $10, $20, $07, $02, $70, $6A

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_595F:: ; heuristic: map object selector; C0
Data_069_595F:: ; address name
    objsel_unless_flag $0096, MapObjects_5967
    objsel_list MapObjects_5989

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5967::
Data_069_5967:: ; address name
    db $03 ; entry 0
    db $85, $01, $12, $00, $00, $40, $10, $05, $00, $50, $6F
    db $86, $01, $52, $00, $00, $50, $10, $06, $00, $60, $69
    db $87, $01, $52, $00, $02, $60, $40, $07, $01, $70, $6D

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5989::
Data_069_5989:: ; address name
    db $03 ; entry 0
    db $85, $01, $12, $00, $00, $30, $30, $05, $00, $50, $6F
    db $86, $01, $52, $00, $00, $60, $20, $06, $00, $60, $69
    db $87, $01, $52, $00, $02, $60, $40, $07, $01, $70, $6D

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_59AB::
Data_069_59AB:: ; address name
    dw $0000 ; id 0
    dw ObjSelector_59AF ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_59AF:: ; heuristic: map object selector; C0
Data_069_59AF:: ; address name
    objsel_skip_if_clear $009D, $04, $00
    objsel_list MapObjects_59FA

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_59B9:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_59B9:: ; address name
    objsel_unless_flag $009B, MapObjects_59C1
    objsel_list MapObjects_59D8

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_59C1::
Data_069_59C1:: ; address name
    db $02 ; entry 0
    db $85, $01, $3A, $00, $00, $E0, $E0, $05, $03, $50, $72
    db $86, $01, $59, $00, $00, $80, $10, $06, $00, $60, $9A

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_59D8::
Data_069_59D8:: ; address name
    db $03 ; entry 0
    db $85, $01, $3A, $00, $00, $60, $30, $05, $03, $50, $72
    db $86, $01, $59, $00, $00, $80, $10, $06, $00, $60, $9A
    db $87, $00, $21, $01, $00, $80, $E0, $07, $00, $70, $9A

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_59FA::
Data_069_59FA:: ; address name
    db $01 ; entry 0
    db $85, $01, $3A, $00, $00, $60, $30, $05, $03, $50, $72

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_5A06::
Data_069_5A06:: ; address name
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
ObjSelector_5A26:: ; heuristic: map object selector; C0
Data_069_5A26:: ; address name
    objsel_unless_flag $01E5, MapObjects_5A2E
    objsel_list MapObjects_5A50

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5A2E::
Data_069_5A2E:: ; address name
    db $03 ; entry 0
    db $85, $01, $2E, $00, $00, $30, $50, $05, $01, $50, $92
    db $86, $01, $2F, $00, $02, $60, $30, $06, $01, $60, $93
    db $87, $01, $42, $00, $02, $50, $60, $07, $01, $70, $2E

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5A50::
Data_069_5A50:: ; address name
    db $02 ; entry 0
    db $85, $01, $2E, $00, $00, $30, $50, $05, $01, $50, $92
    db $86, $01, $2F, $00, $02, $60, $30, $06, $01, $60, $93

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5A67:: ; heuristic: map object selector; C0
Data_069_5A67:: ; address name
    objsel_unless_flag $0098, MapObjects_5A79
    objsel_none

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5A6D:: ; heuristic: map object selector; C0
Data_069_5A6D:: ; address name
    objsel_unless_flag $0099, MapObjects_5A79
    objsel_none

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5A73:: ; heuristic: map object selector; C0
Data_069_5A73:: ; address name
    objsel_unless_flag $009B, MapObjects_5A79
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5A79::
Data_069_5A79:: ; address name
    db $01 ; entry 0
    db $85, $01, $3A, $00, $00, $50, $40, $05, $02, $50, $99

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_5A85::
Data_069_5A85:: ; address name
    dw ObjSelector_5A8D ; id 0
    dw ObjSelector_5AE4 ; id 1
    dw ObjSelector_5B46 ; id 2
    dw ObjSelector_5B77 ; id 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5A8D:: ; heuristic: map object selector; C0
Data_069_5A8D:: ; address name
    objsel_unless_flag $01E5, MapObjects_5A95
    objsel_list MapObjects_5AB7

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5A95::
Data_069_5A95:: ; address name
    db $03 ; entry 0
    db $85, $01, $2F, $00, $00, $60, $50, $05, $00, $50, $78
    db $86, $01, $2F, $00, $00, $40, $20, $06, $00, $60, $7E
    db $87, $01, $14, $00, $00, $80, $30, $07, $03, $70, $7F

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5AB7::
Data_069_5AB7:: ; address name
    db $04 ; entry 0
    db $85, $01, $2F, $00, $00, $60, $50, $05, $00, $50, $78
    db $85, $01, $2F, $00, $00, $40, $10, $05, $02, $50, $7E
    db $86, $01, $14, $00, $00, $80, $30, $06, $03, $60, $7F
    db $87, $01, $21, $00, $00, $50, $20, $07, $00, $70, $9B

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5AE4:: ; heuristic: map object selector; C0
Data_069_5AE4:: ; address name
    objsel_unless_flag $0097, MapObjects_5AEC
    objsel_list MapObjects_5B19

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5AEC::
Data_069_5AEC:: ; address name
    db $04 ; entry 0
    db $85, $01, $10, $00, $00, $40, $10, $05, $00, $50, $7C
    db $85, $01, $10, $00, $00, $50, $10, $05, $00, $50, $7C
    db $86, $01, $2E, $00, $00, $70, $70, $06, $03, $60, $79
    db $87, $01, $2D, $00, $02, $60, $40, $07, $01, $70, $77

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5B19::
Data_069_5B19:: ; address name
    db $04 ; entry 0
    db $85, $01, $10, $00, $00, $30, $30, $05, $00, $50, $7C
    db $85, $01, $10, $00, $00, $60, $20, $05, $00, $50, $7C
    db $86, $01, $2E, $00, $00, $70, $70, $06, $03, $60, $79
    db $87, $01, $2D, $00, $02, $60, $40, $07, $01, $70, $77

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5B46:: ; heuristic: map object selector; C0
Data_069_5B46:: ; address name
    objsel_list MapObjects_5B4A

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5B4A::
Data_069_5B4A:: ; address name
    db $04 ; entry 0
    db $85, $01, $2E, $00, $00, $70, $40, $05, $01, $50, $74
    db $86, $01, $2F, $00, $00, $60, $70, $06, $01, $60, $75
    db $85, $01, $2E, $00, $00, $40, $50, $05, $02, $50, $76
    db $87, $01, $12, $00, $00, $50, $10, $07, $00, $70, $80

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5B77:: ; heuristic: map object selector; C0
Data_069_5B77:: ; address name
    objsel_list MapObjects_5B7B

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5B7B::
Data_069_5B7B:: ; address name
    db $04 ; entry 0
    db $85, $01, $30, $00, $00, $60, $60, $05, $00, $50, $73
    db $86, $01, $2F, $00, $00, $20, $50, $06, $03, $60, $7A
    db $86, $01, $2F, $00, $00, $50, $30, $06, $00, $60, $7B
    db $87, $01, $15, $00, $00, $80, $20, $07, $03, $70, $7D

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_5BA8::
Data_069_5BA8:: ; address name
    dw ObjSelector_5BAA ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5BAA:: ; heuristic: map object selector; C0
Data_069_5BAA:: ; address name
    objsel_unless_flag $01E5, MapObjects_5BB2
    objsel_list MapObjects_5BDF

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5BB2::
Data_069_5BB2:: ; address name
    db $04 ; entry 0
    db $85, $01, $2E, $00, $00, $40, $60, $05, $02, $50, $86
    db $86, $01, $15, $00, $00, $20, $20, $06, $00, $60, $87
    db $85, $01, $2E, $00, $00, $50, $40, $05, $03, $50, $88
    db $87, $01, $29, $00, $00, $10, $70, $07, $01, $70, $89

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5BDF::
Data_069_5BDF:: ; address name
    db $03 ; entry 0
    db $85, $01, $2E, $00, $00, $40, $60, $05, $02, $50, $86
    db $86, $01, $2E, $00, $00, $50, $40, $06, $03, $60, $88
    db $87, $01, $29, $00, $00, $10, $70, $07, $01, $70, $89

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_5C01::
Data_069_5C01:: ; address name
    dw ObjSelector_5C07 ; id 0
    dw ObjSelector_5C71 ; id 1
    dw ObjSelector_5CB2 ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5C07:: ; heuristic: map object selector; C0
Data_069_5C07:: ; address name
    objsel_skip_if_set $0025, $0A, $00
    objsel_skip_if_clear $00D1, $04, $00
    objsel_list MapObjects_5C39

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5C17:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_5C17:: ; address name
    objsel_skip_if_clear $01E5, $04, $00
    objsel_list MapObjects_5C2D

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5C21:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_5C21:: ; address name
    objsel_skip_if_clear $009D, $02, $00
    objsel_none

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5C29:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_5C29:: ; address name
    objsel_list MapObjects_5C2D

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_5C2D::
Data_069_5C2D:: ; address name
    db $01 ; entry 0
    db $85, $01, $0F, $00, $00, $40, $10, $05, $00, $50, $90

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 5 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5C39::
Data_069_5C39:: ; address name
    db $05 ; entry 0
    db $85, $01, $0F, $00, $00, $40, $10, $05, $00, $50, $90
    db $86, $01, $10, $00, $00, $30, $60, $06, $00, $60, $8E
    db $86, $01, $10, $00, $00, $60, $60, $06, $00, $60, $8E
    db $87, $01, $2A, $00, $00, $30, $20, $07, $00, $70, $8D
    db $83, $01, $30, $00, $00, $40, $B0, $03, $02, $30, $73

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5C71:: ; heuristic: map object selector; C0
Data_069_5C71:: ; address name
    objsel_unless_flag $01F1, MapObjects_5C79
    objsel_list MapObjects_5C9B

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5C79::
Data_069_5C79:: ; address name
    db $03 ; entry 0
    db $85, $01, $10, $00, $00, $30, $10, $05, $01, $50, $8E
    db $86, $01, $12, $00, $00, $20, $50, $06, $02, $60, $8F
    db $87, $01, $2A, $00, $00, $60, $60, $07, $03, $70, $8D

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5C9B::
Data_069_5C9B:: ; address name
    db $02 ; entry 0
    db $85, $01, $10, $00, $00, $30, $10, $05, $01, $50, $8E
    db $86, $01, $12, $00, $00, $20, $50, $06, $02, $60, $8F

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5CB2:: ; heuristic: map object selector; C0
Data_069_5CB2:: ; address name
    objsel_list MapObjects_5CB6

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5CB6::
Data_069_5CB6:: ; address name
    db $03 ; entry 0
    db $85, $01, $10, $00, $00, $30, $10, $05, $00, $50, $8A
    db $86, $01, $10, $00, $02, $50, $40, $06, $01, $60, $8B
    db $87, $01, $12, $00, $00, $20, $50, $07, $00, $70, $8C

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_5CD8::
Data_069_5CD8:: ; address name
    dw ObjSelector_5CDC ; id 0
    dw ObjSelector_5D8B ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5CDC:: ; heuristic: map object selector; C0
Data_069_5CDC:: ; address name
    objsel_skip_if_clear $01E5, $04, $00
    objsel_list MapObjects_5D7F

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5CE6:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_5CE6:: ; address name
    objsel_skip_if_clear $01E2, $04, $00
    objsel_list MapObjects_5D68

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5CF0:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_5CF0:: ; address name
    objsel_skip_if_clear $01E1, $04, $00
    objsel_list MapObjects_5D46

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5CFA:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_5CFA:: ; address name
    objsel_unless_flag $01F1, MapObjects_5D02
    objsel_list MapObjects_5D24

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_5D02::
Data_069_5D02:: ; address name
    db $03 ; entry 0
    db $85, $01, $46, $00, $00, $40, $30, $05, $00, $50, $90
    db $86, $01, $2A, $00, $00, $50, $70, $06, $02, $60, $8D
    db $87, $00, $E0, $00, $00, $40, $E0, $07, $00, $70, $9E

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_5D24::
Data_069_5D24:: ; address name
    db $03 ; entry 0
    db $85, $01, $46, $00, $00, $40, $30, $05, $00, $50, $90
    db $86, $01, $2A, $00, $00, $50, $40, $06, $02, $60, $8D
    db $87, $00, $E0, $00, $00, $40, $E0, $07, $00, $70, $9E

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_5D46::
Data_069_5D46:: ; address name
    db $03 ; entry 0
    db $85, $01, $46, $00, $00, $40, $30, $05, $00, $50, $90
    db $86, $01, $2A, $00, $00, $50, $40, $06, $02, $60, $8D
    db $87, $00, $E0, $00, $00, $40, $20, $07, $00, $70, $9E

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_5D68::
Data_069_5D68:: ; address name
    db $02 ; entry 0
    db $85, $01, $0F, $00, $00, $60, $40, $05, $00, $50, $90
    db $86, $01, $2A, $00, $02, $30, $50, $06, $00, $60, $8D

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5D7F::
Data_069_5D7F:: ; address name
    db $01 ; entry 0
    db $85, $01, $2A, $00, $02, $30, $50, $05, $01, $50, $8D

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5D8B:: ; heuristic: map object selector; C0
Data_069_5D8B:: ; address name
    objsel_unless_flag $01F1, MapObjects_5D91
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5D91::
Data_069_5D91:: ; address name
    db $01 ; entry 0
    db $85, $01, $2A, $00, $00, $70, $60, $05, $03, $50, $8D

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_5D9D::
Data_069_5D9D:: ; address name
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

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5E1D:: ; heuristic: map object selector; C0
Data_069_5E1D:: ; address name
    objsel_skip_if_set $0022, $02, $00
    objsel_none

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5E25:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_5E25:: ; address name
    objsel_unless_flag $00F4, MapObjects_5E2B
    objsel_none

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_5E2B::
Data_069_5E2B:: ; address name
    db $01 ; entry 0
    db $85, $00, $53, $01, $00, $50, $50, $05, $00, $50, $6C

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5E37:: ; heuristic: map object selector; C0
Data_069_5E37:: ; address name
    objsel_skip_if_clear $0076, $02, $00
    objsel_none

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5E3F:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_5E3F:: ; address name
    objsel_skip_if_set $0070, $02, $00
    objsel_none

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5E47:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_5E47:: ; address name
    objsel_list MapObjects_5E4B

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_5E4B::
Data_069_5E4B:: ; address name
    db $01 ; entry 0
    db $85, $01, $55, $00, $02, $40, $40, $05, $00, $50, $46

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_5E57::
Data_069_5E57:: ; address name
    dw ObjSelector_5E5B ; id 0
    dw ObjSelector_5E8C ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5E5B:: ; heuristic: map object selector; C0
Data_069_5E5B:: ; address name
    objsel_list MapObjects_5E5F

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5E5F::
Data_069_5E5F:: ; address name
    db $04 ; entry 0
    db $85, $01, $0C, $00, $00, $20, $30, $05, $01, $50, $04
    db $86, $01, $0B, $00, $00, $50, $40, $06, $00, $60, $05
    db $85, $01, $0C, $00, $00, $30, $60, $05, $00, $50, $06
    db $87, $01, $06, $00, $00, $70, $50, $07, $00, $70, $03

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5E8C:: ; heuristic: map object selector; C0
Data_069_5E8C:: ; address name
    objsel_list MapObjects_5E90

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5E90::
Data_069_5E90:: ; address name
    db $04 ; entry 0
    db $85, $01, $08, $00, $00, $60, $60, $05, $00, $50, $00
    db $86, $01, $09, $00, $00, $80, $40, $06, $03, $60, $01
    db $85, $01, $08, $00, $02, $30, $50, $05, $01, $50, $02
    db $87, $01, $15, $00, $00, $10, $30, $07, $01, $70, $07

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_5EBD::
Data_069_5EBD:: ; address name
    dw ObjSelector_5EC5 ; id 0
    dw ObjSelector_5EF6 ; id 1
    dw ObjSelector_5F1C ; id 2
    dw ObjSelector_5F4D ; id 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5EC5:: ; heuristic: map object selector; C0
Data_069_5EC5:: ; address name
    objsel_list MapObjects_5EC9

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5EC9::
Data_069_5EC9:: ; address name
    db $04 ; entry 0
    db $85, $01, $0B, $00, $00, $20, $20, $05, $01, $50, $1A
    db $86, $01, $08, $00, $02, $60, $40, $06, $01, $60, $1B
    db $87, $01, $06, $00, $00, $20, $50, $07, $01, $70, $23
    db $86, $01, $08, $00, $00, $30, $70, $06, $02, $60, $1C

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5EF6:: ; heuristic: map object selector; C0
Data_069_5EF6:: ; address name
    objsel_list MapObjects_5EFA

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5EFA::
Data_069_5EFA:: ; address name
    db $03 ; entry 0
    db $85, $01, $08, $00, $00, $50, $60, $05, $03, $50, $1E
    db $86, $01, $09, $00, $02, $30, $40, $06, $01, $60, $1F
    db $87, $01, $15, $00, $00, $70, $20, $07, $00, $70, $20

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5F1C:: ; heuristic: map object selector; C0
Data_069_5F1C:: ; address name
    objsel_list MapObjects_5F20

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5F20::
Data_069_5F20:: ; address name
    db $04 ; entry 0
    db $85, $01, $0A, $00, $00, $80, $40, $05, $03, $50, $21
    db $86, $01, $15, $00, $00, $40, $50, $06, $03, $60, $22
    db $85, $01, $0A, $00, $00, $60, $20, $05, $00, $50, $24
    db $87, $01, $12, $00, $00, $30, $10, $07, $00, $70, $1D

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5F4D:: ; heuristic: map object selector; C0
Data_069_5F4D:: ; address name
    objsel_list MapObjects_5F51

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5F51::
Data_069_5F51:: ; address name
    db $03 ; entry 0
    db $85, $01, $0C, $00, $00, $70, $60, $05, $00, $50, $25
    db $86, $01, $09, $00, $00, $60, $30, $06, $00, $60, $26
    db $87, $01, $16, $00, $02, $20, $40, $07, $01, $70, $27

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_5F73::
Data_069_5F73:: ; address name
    dw ObjSelector_5F77 ; id 0
    dw ObjSelector_5FE5 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5F77:: ; heuristic: map object selector; C0
Data_069_5F77:: ; address name
    objsel_skip_if_set $0025, $0A, $00
    objsel_skip_if_clear $00D1, $04, $00
    objsel_list MapObjects_5FB8

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5F87:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_5F87:: ; address name
    objsel_list MapObjects_5F8B

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 4 object(s), the layout of the other object lists
MapObjects_5F8B::
Data_069_5F8B:: ; address name
    db $04 ; entry 0
    db $85, $01, $16, $00, $00, $50, $30, $05, $00, $50, $30
    db $86, $01, $29, $00, $00, $70, $50, $06, $00, $60, $31
    db $86, $01, $29, $00, $00, $70, $60, $06, $02, $60, $32
    db $87, $01, $0C, $00, $00, $20, $40, $07, $01, $70, $33

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5FB8::
Data_069_5FB8:: ; address name
    db $04 ; entry 0
    db $85, $01, $16, $00, $00, $50, $30, $05, $00, $50, $30
    db $86, $01, $06, $00, $00, $40, $B0, $06, $02, $60, $23
    db $87, $00, $48, $01, $00, $40, $C0, $07, $02, $70, $23
    db $83, $01, $0C, $00, $00, $20, $40, $03, $01, $30, $33

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5FE5:: ; heuristic: map object selector; C0
Data_069_5FE5:: ; address name
    objsel_unless_flag $006D, MapObjects_5FED
    objsel_list MapObjects_600F

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5FED::
Data_069_5FED:: ; address name
    db $03 ; entry 0
    db $85, $01, $03, $00, $00, $40, $E0, $05, $00, $50, $00
    db $86, $01, $28, $00, $00, $30, $D0, $06, $00, $60, $00
    db $87, $01, $29, $00, $00, $50, $D0, $07, $00, $70, $00

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_600F::
Data_069_600F:: ; address name
    db $02 ; entry 0
    db $85, $01, $0A, $00, $00, $60, $10, $05, $00, $50, $3B
    db $86, $01, $29, $00, $00, $60, $30, $06, $02, $60, $3C

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_6026::
Data_069_6026:: ; address name
    dw ObjSelector_6028 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6028:: ; heuristic: map object selector; C0
Data_069_6028:: ; address name
    objsel_list MapObjects_602C

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_602C::
Data_069_602C:: ; address name
    db $03 ; entry 0
    db $85, $01, $0A, $00, $00, $30, $10, $05, $00, $50, $2C
    db $86, $01, $16, $00, $00, $20, $50, $06, $00, $60, $2D
    db $87, $01, $29, $00, $00, $20, $70, $07, $02, $70, $2E

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_604E::
Data_069_604E:: ; address name
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
ObjSelector_606E:: ; heuristic: map object selector; C0
Data_069_606E:: ; address name
    objsel_unless_flag $0078, MapObjects_6074
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6074::
Data_069_6074:: ; address name
    db $01 ; entry 0
    db $85, $00, $4F, $01, $00, $40, $30, $05, $03, $50, $34

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_6080::
Data_069_6080:: ; address name
    dw ObjSelector_6086 ; id 0
    dw $0000 ; id 1
    dw ObjSelector_6098 ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6086:: ; heuristic: map object selector; C0
Data_069_6086:: ; address name
    objsel_unless_flag $0071, MapObjects_608C
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_608C::
Data_069_608C:: ; address name
    db $01 ; entry 0
    db $85, $01, $44, $00, $00, $70, $10, $05, $00, $50, $47

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6098:: ; heuristic: map object selector; C0
Data_069_6098:: ; address name
    objsel_list MapObjects_609C

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_609C::
Data_069_609C:: ; address name
    db $01 ; entry 0
    db $85, $01, $56, $00, $00, $70, $60, $05, $00, $50, $4D

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_60A8::
Data_069_60A8:: ; address name
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
ObjSelector_60C8:: ; heuristic: map object selector; C0
Data_069_60C8:: ; address name
    objsel_unless_flag $007B, MapObjects_60CE
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_60CE::
Data_069_60CE:: ; address name
    db $03 ; entry 0
    db $85, $01, $03, $00, $00, $50, $A0, $05, $02, $50, $00
    db $86, $01, $28, $00, $00, $50, $B0, $06, $02, $60, $00
    db $87, $01, $29, $00, $00, $50, $C0, $07, $02, $70, $00

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_60F0::
Data_069_60F0:: ; address name
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
ObjSelector_6108:: ; heuristic: map object selector; C0
Data_069_6108:: ; address name
    objsel_skip_if_clear $007C, $02, $00
    objsel_none

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6110:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_6110:: ; address name
    objsel_unless_flag $007D, MapObjects_6118
    objsel_list MapObjects_613A

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_6118::
Data_069_6118:: ; address name
    db $03 ; entry 0
    db $85, $01, $03, $00, $00, $40, $50, $05, $03, $50, $00
    db $86, $01, $28, $00, $00, $60, $60, $06, $00, $60, $00
    db $87, $01, $29, $00, $00, $50, $20, $07, $01, $70, $00

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_613A::
Data_069_613A:: ; address name
    db $03 ; entry 0
    db $85, $01, $03, $00, $00, $60, $50, $05, $01, $50, $00
    db $86, $01, $28, $00, $00, $50, $50, $06, $01, $60, $00
    db $87, $01, $29, $00, $00, $40, $50, $07, $01, $70, $00

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_615C::
Data_069_615C:: ; address name
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
ObjSelector_616E:: ; heuristic: map object selector; C0
Data_069_616E:: ; address name
    objsel_unless_flag $007E, MapObjects_6174
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6174::
Data_069_6174:: ; address name
    db $03 ; entry 0
    db $85, $01, $03, $00, $00, $60, $A0, $05, $02, $50, $00
    db $86, $01, $28, $00, $00, $60, $B0, $06, $02, $60, $00
    db $87, $01, $29, $00, $00, $60, $C0, $07, $02, $70, $00

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_6196::
Data_069_6196:: ; address name
    dw ObjSelector_6198 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6198:: ; heuristic: map object selector; C0
Data_069_6198:: ; address name
    objsel_skip_if_clear $005F, $02, $00
    objsel_none

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_61A0:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_61A0:: ; address name
    objsel_unless_flag $007F, MapObjects_61A8
    objsel_list MapObjects_61CA

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_61A8::
Data_069_61A8:: ; address name
    db $03 ; entry 0
    db $85, $01, $28, $00, $00, $50, $E0, $05, $00, $50, $00
    db $86, $01, $29, $00, $00, $50, $D0, $06, $00, $60, $00
    db $87, $01, $03, $00, $00, $50, $F0, $07, $00, $70, $00

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_61CA::
Data_069_61CA:: ; address name
    db $03 ; entry 0
    db $85, $01, $45, $00, $00, $80, $40, $05, $00, $50, $00
    db $86, $00, $E3, $00, $00, $50, $40, $06, $00, $60, $00
    db $87, $00, $D6, $00, $00, $40, $50, $07, $00, $70, $00

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_61EC::
Data_069_61EC:: ; address name
    dw ObjSelector_61F2 ; id 0
    dw ObjSelector_6228 ; id 1
    dw ObjSelector_6259 ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_61F2:: ; heuristic: map object selector; C0
Data_069_61F2:: ; address name
    objsel_unless_flag $006F, MapObjects_61FA
    objsel_list MapObjects_6211

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_61FA::
Data_069_61FA:: ; address name
    db $02 ; entry 0
    db $85, $01, $13, $00, $00, $60, $20, $05, $00, $50, $13
    db $86, $01, $4E, $00, $00, $E0, $40, $06, $00, $60, $3D

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6211::
Data_069_6211:: ; address name
    db $02 ; entry 0
    db $85, $01, $13, $00, $00, $60, $20, $05, $00, $50, $13
    db $86, $01, $4E, $00, $00, $30, $40, $06, $01, $60, $3D

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6228:: ; heuristic: map object selector; C0
Data_069_6228:: ; address name
    objsel_list MapObjects_622C

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_622C::
Data_069_622C:: ; address name
    db $04 ; entry 0
    db $85, $01, $09, $00, $00, $60, $60, $05, $00, $50, $0F
    db $86, $01, $0D, $00, $00, $20, $20, $06, $00, $60, $16
    db $87, $01, $0C, $00, $02, $70, $50, $07, $01, $70, $11
    db $87, $01, $0C, $00, $00, $30, $40, $07, $01, $70, $17

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6259:: ; heuristic: map object selector; C0
Data_069_6259:: ; address name
    objsel_list MapObjects_625D

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_625D::
Data_069_625D:: ; address name
    db $03 ; entry 0
    db $85, $01, $13, $00, $00, $70, $20, $05, $00, $50, $15
    db $86, $01, $07, $00, $00, $20, $10, $06, $00, $60, $12
    db $87, $01, $0C, $00, $00, $80, $60, $07, $03, $70, $10

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_627F::
Data_069_627F:: ; address name
    dw ObjSelector_6281 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6281:: ; heuristic: map object selector; C0
Data_069_6281:: ; address name
    objsel_list MapObjects_6285

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6285::
Data_069_6285:: ; address name
    db $02 ; entry 0
    db $85, $01, $0A, $00, $00, $70, $10, $05, $00, $50, $14
    db $86, $01, $12, $00, $00, $40, $10, $06, $00, $60, $6D

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_629C::
Data_069_629C:: ; address name
    dw ObjSelector_62A0 ; id 0
    dw $0000 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_62A0:: ; heuristic: map object selector; C0
Data_069_62A0:: ; address name
    objsel_unless_flag $007A, MapObjects_62A8
    objsel_list MapObjects_62B4

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_62A8::
Data_069_62A8:: ; address name
    db $01 ; entry 0
    db $85, $01, $58, $00, $00, $E0, $18, $05, $00, $50, $00

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_62B4::
Data_069_62B4:: ; address name
    db $01 ; entry 0
    db $85, $01, $58, $00, $00, $48, $18, $05, $00, $50, $00

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_62C0::
Data_069_62C0:: ; address name
    dw ObjSelector_62C4 ; id 0
    dw ObjSelector_633D ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_62C4:: ; heuristic: map object selector; C0
Data_069_62C4:: ; address name
    objsel_skip_if_set $0025, $0A, $00
    objsel_skip_if_clear $00D1, $04, $00
    objsel_list MapObjects_6305

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_62D4:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_62D4:: ; address name
    objsel_list MapObjects_62D8

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 4 object(s), the layout of the other object lists
MapObjects_62D8::
Data_069_62D8:: ; address name
    db $04 ; entry 0
    db $85, $01, $4F, $00, $00, $40, $20, $05, $00, $50, $45
    db $86, $01, $2C, $00, $02, $50, $40, $06, $01, $60, $43
    db $86, $01, $2C, $00, $00, $30, $60, $06, $00, $60, $44
    db $86, $01, $2C, $00, $00, $70, $70, $06, $00, $60, $42

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 5 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6305::
Data_069_6305:: ; address name
    db $05 ; entry 0
    db $85, $01, $4F, $00, $00, $40, $20, $05, $00, $50, $45
    db $86, $01, $2C, $00, $00, $40, $50, $06, $02, $60, $43
    db $86, $01, $2C, $00, $00, $50, $50, $06, $02, $60, $44
    db $86, $01, $2C, $00, $00, $60, $50, $06, $02, $60, $42
    db $87, $01, $13, $00, $00, $50, $30, $07, $00, $70, $15

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_633D:: ; heuristic: map object selector; C0
Data_069_633D:: ; address name
    objsel_list MapObjects_6341

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6341::
Data_069_6341:: ; address name
    db $04 ; entry 0
    db $85, $01, $2C, $00, $00, $60, $30, $05, $01, $50, $3E
    db $86, $01, $2C, $00, $00, $40, $70, $06, $01, $60, $3F
    db $85, $01, $2C, $00, $00, $50, $70, $05, $03, $50, $40
    db $85, $01, $2C, $00, $00, $20, $40, $05, $00, $50, $41

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_636E::
Data_069_636E:: ; address name
    dw ObjSelector_6374 ; id 0
    dw $0000 ; id 1
    dw $0000 ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6374:: ; heuristic: map object selector; C0
Data_069_6374:: ; address name
    objsel_unless_flag $0072, MapObjects_637A
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_637A::
Data_069_637A:: ; address name
    db $01 ; entry 0
    db $85, $01, $44, $00, $00, $80, $60, $05, $00, $50, $48

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_6386::
Data_069_6386:: ; address name
    dw ObjSelector_638C ; id 0
    dw $0000 ; id 1
    dw $0000 ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_638C:: ; heuristic: map object selector; C0
Data_069_638C:: ; address name
    objsel_unless_flag $0073, MapObjects_6392
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6392::
Data_069_6392:: ; address name
    db $01 ; entry 0
    db $85, $01, $44, $00, $00, $60, $30, $05, $00, $50, $49

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_639E::
Data_069_639E:: ; address name
    dw ObjSelector_63A0 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_63A0:: ; heuristic: map object selector; C0
Data_069_63A0:: ; address name
    objsel_unless_flag $0075, MapObjects_63A6
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_63A6::
Data_069_63A6:: ; address name
    db $01 ; entry 0
    db $85, $00, $06, $01, $00, $60, $20, $05, $00, $50, $4A

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_63B2::
Data_069_63B2:: ; address name
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
ObjSelector_63CA:: ; heuristic: map object selector; C0
Data_069_63CA:: ; address name
    objsel_unless_flag $0015, MapObjects_63D6
    objsel_unless_flag $0006, MapObjects_63F8
    objsel_list MapObjects_6404

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_63D6::
Data_069_63D6:: ; address name
    db $03 ; entry 0
    db $85, $01, $1A, $00, $00, $40, $00, $05, $00, $50, $0A
    db $86, $01, $03, $00, $00, $40, $60, $06, $00, $60, $18
    db $87, $01, $02, $00, $00, $50, $60, $07, $00, $70, $17

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_63F8::
Data_069_63F8:: ; address name
    db $01 ; entry 0
    db $85, $01, $1A, $00, $00, $40, $00, $05, $00, $50, $0A

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6404::
Data_069_6404:: ; address name
    db $02 ; entry 0
    db $85, $01, $1A, $00, $00, $20, $10, $05, $00, $50, $0A
    db $86, $01, $10, $00, $00, $40, $E0, $06, $00, $60, $00

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_641B:: ; heuristic: map object selector; C0
Data_069_641B:: ; address name
    objsel_skip_if_clear $0023, $04, $00
    objsel_list MapObjects_645B

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6425:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_6425:: ; address name
    objsel_unless_flag $0191, MapObjects_642D
    objsel_list MapObjects_6444

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_642D::
Data_069_642D:: ; address name
    db $02 ; entry 0
    db $85, $01, $04, $00, $00, $60, $30, $05, $01, $50, $07
    db $86, $00, $5A, $00, $00, $60, $E0, $06, $00, $60, $4B

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_6444::
Data_069_6444:: ; address name
    db $02 ; entry 0
    db $85, $01, $04, $00, $00, $60, $30, $05, $01, $50, $07
    db $86, $00, $5A, $00, $00, $60, $20, $06, $00, $60, $4B

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_645B::
Data_069_645B:: ; address name
    db $03 ; entry 0
    db $85, $01, $04, $00, $00, $50, $30, $05, $01, $50, $07
    db $86, $00, $5A, $00, $00, $60, $20, $06, $00, $60, $4B
    db $87, $00, $01, $01, $00, $30, $60, $07, $00, $70, $7C

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_647D:: ; heuristic: map object selector; C0
Data_069_647D:: ; address name
    objsel_skip_if_clear $0024, $04, $00
    objsel_list MapObjects_649F

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6487:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_6487:: ; address name
    objsel_skip_if_clear $0003, $04, $00
    objsel_unless_flag $0002, MapObjects_6493
    objsel_none

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_6493::
Data_069_6493:: ; address name
    db $01 ; entry 0
    db $85, $00, $0A, $00, $00, $80, $40, $05, $00, $50, $08

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_649F::
Data_069_649F:: ; address name
    db $01 ; entry 0
    db $85, $00, $F0, $00, $00, $80, $30, $05, $00, $50, $98

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_64AB:: ; heuristic: map object selector; C0
Data_069_64AB:: ; address name
    objsel_skip_if_clear $0025, $08, $00
    objsel_unless_flag $0000, MapObjects_655F
    objsel_list MapObjects_653D

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_64B9:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_64B9:: ; address name
    objsel_skip_if_set $0020, $12, $00
    objsel_skip_if_set $0002, $08, $00
    objsel_unless_flag $0003, MapObjects_64ED
    objsel_list MapObjects_6504

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_64CD:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_64CD:: ; address name
    objsel_list MapObjects_651B

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_64D1:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_64D1:: ; address name
    objsel_skip_if_clear $0021, $0E, $00
    objsel_skip_if_set $0181, $08, $00
    objsel_unless_flag $0000, MapObjects_6598
    objsel_list MapObjects_6581

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_64E5:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_64E5:: ; address name
    objsel_unless_flag $0000, MapObjects_655F
    objsel_list MapObjects_653D

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_64ED::
Data_069_64ED:: ; address name
    db $02 ; entry 0
    db $85, $01, $04, $00, $00, $40, $00, $05, $00, $50, $07
    db $86, $00, $0A, $00, $00, $50, $00, $06, $00, $60, $08

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_6504::
Data_069_6504:: ; address name
    db $02 ; entry 0
    db $85, $01, $04, $00, $00, $30, $20, $05, $00, $50, $07
    db $86, $00, $01, $00, $02, $50, $50, $06, $01, $60, $1A

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_651B::
Data_069_651B:: ; address name
    db $03 ; entry 0
    db $85, $01, $04, $00, $00, $30, $20, $05, $00, $50, $07
    db $86, $00, $01, $00, $02, $50, $50, $06, $01, $60, $1A
    db $84, $00, $24, $00, $00, $70, $60, $04, $03, $40, $B2

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_653D::
Data_069_653D:: ; address name
    db $03 ; entry 0
    db $85, $01, $00, $00, $00, $60, $30, $05, $00, $50, $1B
    db $86, $00, $01, $00, $02, $50, $50, $06, $01, $60, $1A
    db $84, $00, $24, $00, $00, $70, $60, $04, $03, $40, $B2

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_655F::
Data_069_655F:: ; address name
    db $03 ; entry 0
    db $85, $01, $01, $00, $00, $60, $30, $05, $00, $50, $1C
    db $86, $00, $01, $00, $02, $50, $50, $06, $03, $60, $1A
    db $84, $00, $24, $00, $00, $70, $60, $04, $03, $40, $B2

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_6581::
Data_069_6581:: ; address name
    db $02 ; entry 0
    db $85, $01, $00, $00, $00, $60, $30, $05, $00, $50, $1B
    db $86, $00, $24, $00, $00, $70, $60, $06, $03, $60, $B2

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_6598::
Data_069_6598:: ; address name
    db $02 ; entry 0
    db $85, $01, $01, $00, $00, $60, $30, $05, $00, $50, $1C
    db $86, $00, $24, $00, $00, $70, $60, $06, $03, $60, $B2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_65AF:: ; heuristic: map object selector; C0
Data_069_65AF:: ; address name
    objsel_skip_if_clear $0023, $04, $00
    objsel_list MapObjects_660D

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_65B9:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_65B9:: ; address name
    objsel_skip_if_clear $0022, $04, $00
    objsel_list MapObjects_65F6

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_65C3:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_65C3:: ; address name
    objsel_skip_if_clear $0021, $04, $00
    objsel_list MapObjects_65DF

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_65CD:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_65CD:: ; address name
    objsel_unless_flag $0003, MapObjects_65D3
    objsel_none

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_65D3::
Data_069_65D3:: ; address name
    db $01 ; entry 0
    db $85, $00, $01, $00, $02, $20, $50, $05, $01, $50, $1A

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_65DF::
Data_069_65DF:: ; address name
    db $02 ; entry 0
    db $85, $00, $4F, $00, $00, $30, $20, $05, $00, $50, $B3
    db $86, $01, $04, $00, $00, $20, $30, $06, $01, $60, $07

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_65F6::
Data_069_65F6:: ; address name
    db $02 ; entry 0
    db $85, $00, $4F, $00, $00, $30, $20, $05, $00, $50, $B3
    db $86, $00, $D8, $00, $00, $50, $10, $06, $00, $60, $4A

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_660D::
Data_069_660D:: ; address name
    db $03 ; entry 0
    db $85, $00, $4F, $00, $00, $30, $20, $05, $00, $50, $B3
    db $86, $00, $D8, $00, $00, $50, $10, $06, $00, $60, $4A
    db $87, $00, $2A, $00, $00, $40, $60, $07, $00, $70, $7B

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_662F:: ; heuristic: map object selector; C0
Data_069_662F:: ; address name
    objsel_list MapObjects_6633

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6633::
Data_069_6633:: ; address name
    db $01 ; entry 0
    db $86, $00, $91, $00, $00, $30, $30, $06, $01, $60, $04

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_663F:: ; heuristic: map object selector; C0
Data_069_663F:: ; address name
    objsel_skip_if_clear $0023, $04, $00
    objsel_list MapObjects_669B

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6649:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_6649:: ; address name
    objsel_skip_if_clear $0021, $04, $00
    objsel_list MapObjects_6684

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6653:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_6653:: ; address name
    objsel_skip_if_clear $0020, $04, $00
    objsel_list MapObjects_666D

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_665D:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_665D:: ; address name
    objsel_list MapObjects_6661

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_6661::
Data_069_6661:: ; address name
    db $01 ; entry 0
    db $85, $00, $B9, $00, $02, $40, $20, $05, $01, $50, $09

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_666D::
Data_069_666D:: ; address name
    db $02 ; entry 0
    db $85, $00, $B9, $00, $02, $40, $20, $05, $01, $50, $09
    db $86, $01, $04, $00, $00, $50, $40, $06, $03, $60, $07

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_6684::
Data_069_6684:: ; address name
    db $02 ; entry 0
    db $85, $00, $B9, $00, $02, $40, $20, $05, $01, $50, $09
    db $86, $00, $F6, $00, $00, $60, $40, $06, $00, $60, $B4

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_669B::
Data_069_669B:: ; address name
    db $03 ; entry 0
    db $85, $00, $B9, $00, $02, $40, $20, $05, $01, $50, $09
    db $86, $00, $F6, $00, $00, $60, $40, $06, $00, $60, $B4
    db $87, $00, $B1, $00, $00, $70, $30, $07, $00, $70, $D4

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_66BD:: ; heuristic: map object selector; C0
Data_069_66BD:: ; address name
    objsel_skip_if_clear $0023, $04, $00
    objsel_list MapObjects_6700

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_66C7:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_66C7:: ; address name
    objsel_skip_if_clear $0022, $04, $00
    objsel_list MapObjects_66E9

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_66D1:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_66D1:: ; address name
    objsel_skip_if_clear $0021, $04, $00
    objsel_list MapObjects_66DD

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_66DB:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_66DB:: ; address name
    objsel_none

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_66DD::
Data_069_66DD:: ; address name
    db $01 ; entry 0
    db $85, $00, $3D, $00, $00, $40, $10, $05, $01, $50, $7D

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_66E9::
Data_069_66E9:: ; address name
    db $02 ; entry 0
    db $85, $00, $3D, $00, $00, $40, $10, $05, $01, $50, $7D
    db $86, $00, $2E, $00, $00, $20, $30, $06, $00, $60, $7E

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6700::
Data_069_6700:: ; address name
    db $03 ; entry 0
    db $85, $00, $3D, $00, $00, $40, $10, $05, $01, $50, $7D
    db $86, $00, $2E, $00, $00, $20, $30, $06, $00, $60, $7E
    db $87, $00, $F8, $00, $00, $10, $40, $07, $00, $70, $D5

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_6722::
Data_069_6722:: ; address name
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
ObjSelector_673A:: ; heuristic: map object selector; C0
Data_069_673A:: ; address name
    objsel_list MapObjects_673E

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_673E::
Data_069_673E:: ; address name
    db $01 ; entry 0
    db $85, $01, $11, $00, $00, $20, $60, $05, $01, $50, $80

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_674A:: ; heuristic: map object selector; C0
Data_069_674A:: ; address name
    objsel_list MapObjects_674E

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_674E::
Data_069_674E:: ; address name
    db $01 ; entry 0
    db $85, $01, $1A, $00, $00, $80, $40, $05, $01, $50, $DA

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_675A:: ; heuristic: map object selector; C0
Data_069_675A:: ; address name
    objsel_list MapObjects_675E

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_675E::
Data_069_675E:: ; address name
    db $01 ; entry 0
    db $85, $01, $19, $00, $00, $20, $60, $05, $01, $50, $22

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_676A:: ; heuristic: map object selector; C0
Data_069_676A:: ; address name
    objsel_skip_if_clear $0117, $02, $00
    objsel_none

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6772:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_6772:: ; address name
    objsel_unless_flag $0107, MapObjects_677A
    objsel_list MapObjects_6791

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_677A::
Data_069_677A:: ; address name
    db $02 ; entry 0
    db $85, $01, $10, $00, $00, $50, $20, $05, $00, $50, $20
    db $86, $01, $18, $00, $00, $70, $70, $06, $03, $60, $21

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_6791::
Data_069_6791:: ; address name
    db $01 ; entry 0
    db $85, $01, $10, $00, $00, $50, $20, $05, $00, $50, $20

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_679D:: ; heuristic: map object selector; C0
Data_069_679D:: ; address name
    objsel_unless_flag $0022, MapObjects_67A3
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_67A3::
Data_069_67A3:: ; address name
    db $02 ; entry 0
    db $85, $01, $15, $00, $00, $50, $60, $05, $02, $50, $B7
    db $86, $01, $12, $00, $00, $50, $70, $06, $02, $60, $B8

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_67BA:: ; heuristic: map object selector; C0
Data_069_67BA:: ; address name
    objsel_skip_if_set $0002, $02, $00
    objsel_none

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_67C2:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_67C2:: ; address name
    objsel_list MapObjects_67C6

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_67C6::
Data_069_67C6:: ; address name
    db $01 ; entry 0
    db $85, $01, $1A, $00, $00, $40, $60, $05, $00, $50, $EA

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_67D2:: ; heuristic: map object selector; C0
Data_069_67D2:: ; address name
    objsel_unless_flag $0007, MapObjects_67DE
    objsel_unless_flag $000A, MapObjects_67F5
    objsel_list MapObjects_67DE

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_67DE::
Data_069_67DE:: ; address name
    db $02 ; entry 0
    db $85, $01, $1B, $00, $00, $60, $70, $05, $03, $50, $12
    db $86, $01, $10, $00, $00, $20, $50, $06, $00, $60, $0B

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_67F5::
Data_069_67F5:: ; address name
    db $04 ; entry 0
    db $85, $01, $1B, $00, $00, $60, $70, $05, $03, $50, $12
    db $86, $01, $10, $00, $00, $20, $50, $06, $00, $60, $0B
    db $87, $01, $03, $00, $00, $30, $80, $07, $02, $70, $18
    db $84, $01, $02, $00, $00, $40, $80, $04, $02, $40, $17

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6822:: ; heuristic: map object selector; C0
Data_069_6822:: ; address name
    objsel_skip_if_clear $0025, $04, $00
    objsel_list MapObjects_685B

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_682C:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_682C:: ; address name
    objsel_skip_if_clear $0024, $02, $00
    objsel_none

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6834:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_6834:: ; address name
    objsel_unless_flag $0021, MapObjects_6844
    objsel_skip_if_set $0107, $02, $00
    objsel_none

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6840:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_6840:: ; address name
    objsel_list MapObjects_685B

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_6844::
Data_069_6844:: ; address name
    db $02 ; entry 0
    db $85, $01, $1D, $00, $00, $20, $40, $05, $00, $50, $15
    db $86, $01, $10, $00, $00, $50, $40, $06, $00, $60, $20

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_685B::
Data_069_685B:: ; address name
    db $01 ; entry 0
    db $85, $01, $18, $00, $00, $70, $60, $05, $00, $50, $21

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6867:: ; heuristic: map object selector; C0
Data_069_6867:: ; address name
    objsel_unless_flag $0007, MapObjects_687F
    objsel_unless_flag $000A, MapObjects_6896
    objsel_unless_flag $0021, MapObjects_687F
    objsel_unless_flag $0024, MapObjects_68C3
    objsel_unless_flag $0025, MapObjects_68E5
    objsel_list MapObjects_68F1

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_687F::
Data_069_687F:: ; address name
    db $02 ; entry 0
    db $85, $01, $1C, $00, $00, $50, $00, $05, $00, $50, $0C
    db $86, $01, $1D, $00, $00, $50, $60, $06, $00, $60, $16

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6896::
Data_069_6896:: ; address name
    db $04 ; entry 0
    db $85, $01, $1C, $00, $00, $50, $00, $05, $00, $50, $0C
    db $86, $01, $03, $00, $00, $30, $60, $06, $03, $60, $18
    db $87, $01, $02, $00, $00, $30, $50, $07, $03, $70, $17
    db $83, $01, $1D, $00, $00, $50, $60, $03, $00, $30, $16

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_68C3::
Data_069_68C3:: ; address name
    db $03 ; entry 0
    db $85, $01, $1C, $00, $00, $40, $30, $05, $00, $50, $0C
    db $86, $01, $08, $00, $02, $E0, $E0, $06, $01, $60, $B9
    db $84, $01, $10, $00, $00, $E0, $50, $04, $03, $40, $00

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_68E5::
Data_069_68E5:: ; address name
    db $01 ; entry 0
    db $85, $01, $1C, $00, $00, $50, $60, $05, $00, $50, $0C

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_68F1::
Data_069_68F1:: ; address name
    db $02 ; entry 0
    db $85, $01, $1C, $00, $00, $40, $30, $05, $00, $50, $0C
    db $86, $01, $08, $00, $02, $30, $40, $06, $01, $60, $B9

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6908:: ; heuristic: map object selector; C0
Data_069_6908:: ; address name
    objsel_skip_if_clear $0025, $04, $00
    objsel_list MapObjects_692E

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6912:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_6912:: ; address name
    objsel_skip_if_clear $0024, $02, $00
    objsel_none

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_691A:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_691A:: ; address name
    objsel_unless_flag $0021, MapObjects_6922
    objsel_list MapObjects_692E

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_6922::
Data_069_6922:: ; address name
    db $01 ; entry 0
    db $85, $01, $1B, $00, $02, $40, $40, $05, $01, $50, $14

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_692E::
Data_069_692E:: ; address name
    db $02 ; entry 0
    db $85, $01, $1A, $00, $00, $30, $60, $05, $00, $50, $1E
    db $86, $01, $10, $00, $00, $20, $40, $06, $01, $60, $EB

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_6945::
Data_069_6945:: ; address name
    dw ObjSelector_694B ; id 0
    dw ObjSelector_6A33 ; id 1
    dw ObjSelector_6A74 ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_694B:: ; heuristic: map object selector; C0
Data_069_694B:: ; address name
    objsel_skip_if_clear $0134, $08, $00
    objsel_unless_flag $0023, MapObjects_69D9
    objsel_list MapObjects_6A06

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6959:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_6959:: ; address name
    objsel_skip_if_clear $0022, $04, $00
    objsel_list MapObjects_69AC

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6963:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_6963:: ; address name
    objsel_skip_if_clear $0021, $04, $00
    objsel_list MapObjects_6995

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_696D:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_696D:: ; address name
    objsel_unless_flag $0011, MapObjects_6973
    objsel_none

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_6973::
Data_069_6973:: ; address name
    db $03 ; entry 0
    db $85, $01, $15, $00, $00, $60, $50, $05, $02, $50, $10
    db $86, $01, $03, $00, $00, $E0, $40, $06, $01, $60, $00
    db $87, $01, $02, $00, $00, $E0, $10, $07, $00, $70, $00

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_6995::
Data_069_6995:: ; address name
    db $02 ; entry 0
    db $85, $01, $1D, $00, $00, $40, $30, $05, $00, $50, $15
    db $86, $01, $1D, $00, $00, $40, $40, $06, $02, $60, $16

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 4 object(s), the layout of the other object lists
MapObjects_69AC::
Data_069_69AC:: ; address name
    db $04 ; entry 0
    db $85, $01, $15, $00, $00, $60, $50, $05, $02, $50, $10
    db $85, $01, $15, $00, $00, $20, $40, $05, $03, $50, $7F
    db $86, $01, $57, $00, $00, $80, $60, $06, $02, $60, $00
    db $87, $00, $B9, $00, $00, $20, $E0, $07, $01, $70, $CD

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_69D9::
Data_069_69D9:: ; address name
    db $04 ; entry 0
    db $85, $01, $15, $00, $00, $60, $50, $05, $02, $50, $10
    db $85, $01, $15, $00, $00, $20, $50, $05, $03, $50, $7F
    db $86, $01, $57, $00, $00, $80, $60, $06, $02, $60, $00
    db $87, $00, $B9, $00, $02, $40, $40, $07, $01, $70, $CD

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6A06::
Data_069_6A06:: ; address name
    db $04 ; entry 0
    db $85, $01, $15, $00, $00, $60, $50, $05, $02, $50, $10
    db $85, $01, $15, $00, $00, $10, $40, $05, $01, $50, $7F
    db $86, $01, $57, $00, $00, $80, $60, $06, $02, $60, $00
    db $87, $00, $B9, $00, $00, $20, $50, $07, $01, $70, $CD

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6A33:: ; heuristic: map object selector; C0
Data_069_6A33:: ; address name
    objsel_unless_flag $0021, MapObjects_6A3B
    objsel_list MapObjects_6A52

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6A3B::
Data_069_6A3B:: ; address name
    db $02 ; entry 0
    db $85, $01, $15, $00, $00, $40, $10, $05, $00, $50, $11
    db $86, $01, $1C, $00, $00, $10, $50, $06, $00, $60, $AA

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6A52::
Data_069_6A52:: ; address name
    db $03 ; entry 0
    db $85, $01, $15, $00, $00, $40, $10, $05, $00, $50, $11
    db $86, $01, $1D, $00, $02, $50, $30, $06, $03, $60, $0F
    db $87, $01, $1C, $00, $00, $10, $50, $07, $00, $70, $AA

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6A74:: ; heuristic: map object selector; C0
Data_069_6A74:: ; address name
    objsel_skip_if_clear $0025, $04, $00
    objsel_list MapObjects_6AC2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6A7E:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_6A7E:: ; address name
    objsel_skip_if_clear $0024, $04, $00
    objsel_list MapObjects_6AE4

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6A88:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_6A88:: ; address name
    objsel_unless_flag $0005, MapObjects_6A94
    objsel_unless_flag $0022, MapObjects_6AB6
    objsel_list MapObjects_6AC2

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_6A94::
Data_069_6A94:: ; address name
    db $03 ; entry 0
    db $85, $01, $1D, $00, $00, $40, $40, $05, $02, $50, $0E
    db $86, $01, $02, $00, $00, $50, $30, $06, $01, $60, $00
    db $87, $01, $03, $00, $00, $40, $30, $07, $01, $70, $00

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_6AB6::
Data_069_6AB6:: ; address name
    db $01 ; entry 0
    db $85, $01, $1D, $00, $00, $40, $40, $05, $00, $50, $0E

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6AC2::
Data_069_6AC2:: ; address name
    db $03 ; entry 0
    db $85, $01, $1D, $00, $00, $40, $40, $05, $00, $50, $0E
    db $86, $01, $1D, $00, $00, $20, $50, $06, $00, $60, $15
    db $84, $01, $1D, $00, $00, $20, $60, $04, $02, $40, $16

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_6AE4::
Data_069_6AE4:: ; address name
    db $02 ; entry 0
    db $85, $01, $1D, $00, $00, $40, $30, $05, $00, $50, $15
    db $86, $01, $1D, $00, $00, $40, $40, $06, $02, $60, $16

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_6AFB::
Data_069_6AFB:: ; address name
    dw ObjSelector_6B01 ; id 0
    dw ObjSelector_6B27 ; id 1
    dw ObjSelector_6B42 ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6B01:: ; heuristic: map object selector; C0
Data_069_6B01:: ; address name
    objsel_list MapObjects_6B05

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6B05::
Data_069_6B05:: ; address name
    db $03 ; entry 0
    db $85, $01, $16, $00, $00, $40, $10, $05, $01, $50, $64
    db $86, $01, $11, $00, $00, $50, $20, $06, $02, $60, $C3
    db $87, $01, $10, $00, $00, $60, $10, $07, $03, $70, $C4

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6B27:: ; heuristic: map object selector; C0
Data_069_6B27:: ; address name
    objsel_list MapObjects_6B2B

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6B2B::
Data_069_6B2B:: ; address name
    db $02 ; entry 0
    db $85, $01, $17, $00, $00, $40, $10, $05, $00, $50, $00
    db $86, $01, $17, $00, $00, $50, $10, $06, $00, $60, $00

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6B42:: ; heuristic: map object selector; C0
Data_069_6B42:: ; address name
    objsel_skip_if_clear $0025, $0C, $00
    objsel_unless_flag $00CB, MapObjects_6BCC
    objsel_unless_flag $00CC, MapObjects_6BEE
    objsel_list MapObjects_6C10

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6B54:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_6B54:: ; address name
    objsel_skip_if_set $0022, $04, $00
    objsel_list MapObjects_6B66

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6B5E:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_6B5E:: ; address name
    objsel_unless_flag $0023, MapObjects_6B88
    objsel_list MapObjects_6BAA

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_6B66::
Data_069_6B66:: ; address name
    db $03 ; entry 0
    db $85, $01, $11, $00, $00, $50, $20, $05, $00, $50, $66
    db $86, $00, $FA, $00, $00, $60, $40, $06, $00, $60, $67
    db $87, $00, $F8, $00, $00, $60, $50, $07, $02, $70, $68

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_6B88::
Data_069_6B88:: ; address name
    db $03 ; entry 0
    db $85, $01, $22, $00, $00, $50, $20, $05, $00, $50, $8E
    db $86, $00, $58, $00, $00, $60, $40, $06, $00, $60, $67
    db $87, $00, $E5, $00, $00, $60, $50, $07, $02, $70, $68

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_6BAA::
Data_069_6BAA:: ; address name
    db $03 ; entry 0
    db $85, $01, $28, $00, $00, $50, $20, $05, $00, $50, $9C
    db $86, $00, $06, $01, $00, $60, $40, $06, $00, $60, $67
    db $87, $00, $52, $01, $00, $60, $50, $07, $02, $70, $68

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6BCC::
Data_069_6BCC:: ; address name
    db $03 ; entry 0
    db $85, $01, $2E, $00, $00, $50, $20, $05, $00, $50, $F1
    db $86, $00, $7B, $00, $00, $60, $40, $06, $00, $60, $67
    db $87, $00, $2E, $01, $00, $60, $50, $07, $02, $70, $68

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6BEE::
Data_069_6BEE:: ; address name
    db $03 ; entry 0
    db $85, $01, $14, $00, $00, $50, $20, $05, $00, $50, $F1
    db $86, $00, $32, $01, $00, $60, $40, $06, $00, $60, $36
    db $87, $00, $31, $01, $00, $60, $50, $07, $02, $70, $37

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6C10::
Data_069_6C10:: ; address name
    db $03 ; entry 0
    db $85, $01, $5F, $00, $00, $50, $20, $05, $00, $50, $F2
    db $86, $00, $A5, $00, $00, $60, $40, $06, $00, $60, $28
    db $87, $00, $EE, $00, $00, $60, $50, $07, $02, $70, $29

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_6C32::
Data_069_6C32:: ; address name
    dw $0000 ; id 0
    dw ObjSelector_6C38 ; id 1
    dw $0000 ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6C38:: ; heuristic: map object selector; C0
Data_069_6C38:: ; address name
    objsel_skip_if_clear $0025, $04, $00
    objsel_list MapObjects_6D0B

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6C42:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_6C42:: ; address name
    objsel_skip_if_clear $019F, $04, $00
    objsel_list MapObjects_6C8C

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6C4C:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_6C4C:: ; address name
    objsel_skip_if_clear $00D1, $04, $00
    objsel_list MapObjects_6CE8

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6C56:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_6C56:: ; address name
    objsel_skip_if_clear $0024, $04, $00
    objsel_unless_flag $00C3, MapObjects_6CD1
    objsel_skip_if_clear $000C, $0E, $00
    objsel_skip_if_clear $0018, $04, $00
    objsel_unless_flag $0019, MapObjects_6CFF
    objsel_list MapObjects_6CC5

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6C74:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_6C74:: ; address name
    objsel_unless_flag $000A, MapObjects_6C80
    objsel_unless_flag $000B, MapObjects_6C8C
    objsel_list MapObjects_6CAE

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_6C80::
Data_069_6C80:: ; address name
    db $01 ; entry 0
    db $85, $01, $4A, $00, $00, $40, $30, $05, $00, $50, $A9

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_6C8C::
Data_069_6C8C:: ; address name
    db $03 ; entry 0
    db $85, $01, $4A, $00, $00, $40, $30, $05, $00, $50, $A9
    db $86, $01, $02, $00, $00, $78, $30, $06, $03, $60, $19
    db $87, $01, $03, $00, $00, $58, $30, $07, $01, $70, $00

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_6CAE::
Data_069_6CAE:: ; address name
    db $02 ; entry 0
    db $85, $01, $02, $00, $00, $80, $30, $05, $00, $50, $19
    db $86, $01, $03, $00, $00, $40, $40, $06, $02, $60, $00

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_6CC5::
Data_069_6CC5:: ; address name
    db $01 ; entry 0
    db $85, $01, $49, $00, $00, $40, $30, $05, $00, $50, $19

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_6CD1::
Data_069_6CD1:: ; address name
    db $02 ; entry 0
    db $85, $01, $49, $00, $00, $40, $30, $05, $01, $50, $19
    db $86, $01, $03, $00, $00, $50, $40, $06, $03, $60, $00

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_6CE8::
Data_069_6CE8:: ; address name
    db $02 ; entry 0
    db $85, $01, $49, $00, $00, $40, $30, $05, $00, $50, $19
    db $86, $01, $4A, $00, $00, $40, $E0, $06, $00, $60, $00

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_6CFF::
Data_069_6CFF:: ; address name
    db $01 ; entry 0
    db $85, $01, $49, $00, $00, $E0, $30, $05, $00, $50, $19

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6D0B::
Data_069_6D0B:: ; address name
    db $03 ; entry 0
    db $85, $01, $4A, $00, $00, $E0, $E0, $05, $00, $50, $A9
    db $86, $01, $02, $00, $00, $50, $20, $06, $00, $60, $19
    db $87, $01, $02, $00, $00, $E0, $E0, $07, $00, $70, $19

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_6D2D::
Data_069_6D2D:: ; address name
    dw ObjSelector_6D2F ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6D2F:: ; heuristic: map object selector; C0
Data_069_6D2F:: ; address name
    objsel_skip_if_clear $0025, $04, $00
    objsel_list MapObjects_6D61

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6D39:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_6D39:: ; address name
    objsel_skip_if_set $0002, $08, $00
    objsel_unless_flag $0017, MapObjects_6D61
    objsel_list MapObjects_6D9B

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6D47:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_6D47:: ; address name
    objsel_skip_if_clear $0020, $0C, $00
    objsel_unless_flag $0021, MapObjects_6D61
    objsel_unless_flag $0181, MapObjects_6DA7
    objsel_list MapObjects_6D61

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6D59:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_6D59:: ; address name
    objsel_unless_flag $0001, MapObjects_6D6D
    objsel_list MapObjects_6D84

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6D61::
Data_069_6D61:: ; address name
    db $01 ; entry 0
    db $85, $01, $05, $00, $00, $40, $30, $05, $00, $50, $02

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_6D6D::
Data_069_6D6D:: ; address name
    db $02 ; entry 0
    db $85, $01, $05, $00, $00, $40, $30, $05, $00, $50, $02
    db $86, $01, $00, $00, $00, $70, $70, $06, $03, $60, $1B

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_6D84::
Data_069_6D84:: ; address name
    db $02 ; entry 0
    db $85, $01, $05, $00, $00, $40, $30, $05, $00, $50, $02
    db $86, $01, $01, $00, $00, $70, $70, $06, $03, $60, $1C

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_6D9B::
Data_069_6D9B:: ; address name
    db $01 ; entry 0
    db $85, $00, $0A, $00, $00, $50, $A0, $05, $00, $50, $08

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_6DA7::
Data_069_6DA7:: ; address name
    db $02 ; entry 0
    db $85, $01, $05, $00, $00, $40, $30, $05, $00, $50, $02
    db $86, $00, $01, $00, $00, $20, $10, $06, $02, $60, $1A

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6DBE:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_6DBE:: ; address name
    objsel_list MapObjects_6DC2

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 4 object(s), the layout of the other object lists
MapObjects_6DC2::
Data_069_6DC2:: ; address name
    db $04 ; entry 0
    db $85, $01, $4A, $00, $00, $40, $30, $05, $00, $50, $9F
    db $85, $01, $4A, $00, $00, $60, $40, $05, $00, $50, $CF
    db $85, $01, $4A, $00, $00, $70, $50, $05, $03, $50, $0D
    db $86, $01, $5F, $00, $00, $70, $70, $06, $03, $60, $A7

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6DEF:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_6DEF:: ; address name
    objsel_list MapObjects_6DF3

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_6DF3::
Data_069_6DF3:: ; address name
    db $03 ; entry 0
    db $85, $01, $40, $00, $00, $40, $30, $05, $00, $50, $A4
    db $86, $01, $15, $00, $00, $60, $20, $06, $00, $60, $A6
    db $87, $01, $10, $00, $00, $70, $10, $07, $00, $70, $AC

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6E15:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_6E15:: ; address name
    objsel_list MapObjects_6E19

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_6E19::
Data_069_6E19:: ; address name
    db $03 ; entry 0
    db $85, $00, $7E, $01, $00, $40, $30, $05, $00, $50, $35
    db $86, $00, $7D, $01, $00, $20, $40, $06, $00, $60, $34
    db $87, $00, $7C, $01, $00, $60, $50, $07, $00, $70, $33

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_6E3B::
Data_069_6E3B:: ; address name
    dw ObjSelector_6E3F ; id 0
    dw ObjSelector_6E65 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6E3F:: ; heuristic: map object selector; C0
Data_069_6E3F:: ; address name
    objsel_list MapObjects_6E43

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6E43::
Data_069_6E43:: ; address name
    db $03 ; entry 0
    db $85, $00, $93, $00, $00, $40, $30, $05, $01, $50, $4C
    db $86, $00, $5E, $00, $00, $30, $70, $06, $00, $60, $4D
    db $87, $00, $76, $00, $00, $80, $50, $07, $00, $70, $B5

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6E65:: ; heuristic: map object selector; C0
Data_069_6E65:: ; address name
    objsel_list MapObjects_6E69

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6E69::
Data_069_6E69:: ; address name
    db $03 ; entry 0
    db $85, $00, $4E, $01, $00, $50, $40, $05, $03, $50, $4E
    db $86, $00, $8E, $00, $00, $20, $50, $06, $01, $60, $4F
    db $87, $00, $77, $00, $00, $50, $70, $07, $02, $70, $B6

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_6E8B::
Data_069_6E8B:: ; address name
    dw ObjSelector_6E8D ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6E8D:: ; heuristic: map object selector; C0
Data_069_6E8D:: ; address name
    objsel_unless_flag $0002, MapObjects_6E95
    objsel_list MapObjects_6EA1

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6E95::
Data_069_6E95:: ; address name
    db $01 ; entry 0
    db $85, $01, $15, $00, $00, $40, $20, $05, $00, $50, $14

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6EA1::
Data_069_6EA1:: ; address name
    db $02 ; entry 0
    db $85, $01, $15, $00, $00, $40, $20, $05, $00, $50, $14
    db $86, $01, $10, $00, $00, $60, $60, $06, $00, $60, $1D

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_6EB8::
Data_069_6EB8:: ; address name
    dw ObjSelector_6EBA ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6EBA:: ; heuristic: map object selector; C0
Data_069_6EBA:: ; address name
    objsel_list MapObjects_6EBE

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6EBE::
Data_069_6EBE:: ; address name
    db $04 ; entry 0
    db $85, $01, $1C, $00, $00, $30, $20, $05, $00, $50, $92
    db $86, $01, $1A, $00, $00, $20, $60, $06, $03, $60, $93
    db $86, $01, $1A, $00, $00, $60, $50, $06, $00, $60, $94
    db $87, $01, $10, $00, $00, $50, $70, $07, $02, $70, $E9

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_6EEB::
Data_069_6EEB:: ; address name
    dw ObjSelector_6EED ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6EED:: ; heuristic: map object selector; C0
Data_069_6EED:: ; address name
    objsel_list MapObjects_6EF1

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6EF1::
Data_069_6EF1:: ; address name
    db $03 ; entry 0
    db $85, $01, $2A, $00, $00, $50, $30, $05, $00, $50, $69
    db $86, $01, $15, $00, $00, $10, $60, $06, $01, $60, $B7
    db $87, $01, $12, $00, $00, $70, $50, $07, $00, $70, $B8

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_6F13::
Data_069_6F13:: ; address name
    dw ObjSelector_6F15 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6F15:: ; heuristic: map object selector; C0
Data_069_6F15:: ; address name
    objsel_list MapObjects_6F19

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6F19::
Data_069_6F19:: ; address name
    db $04 ; entry 0
    db $84, $01, $00, $00, $00, $70, $30, $04, $03, $40, $00
    db $85, $00, $01, $00, $00, $60, $40, $05, $03, $50, $00
    db $86, $00, $01, $00, $00, $60, $30, $06, $03, $60, $00
    db $87, $00, $01, $00, $00, $60, $20, $07, $03, $70, $00

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_6F46::
Data_069_6F46:: ; address name
    dw ObjSelector_6F4A ; id 0
    dw ObjSelector_6F71 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6F4A:: ; heuristic: map object selector; C0
Data_069_6F4A:: ; address name
    objsel_skip_if_clear $0025, $04, $00
    objsel_list MapObjects_6F5A

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6F54:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_6F54:: ; address name
    objsel_unless_flag $0024, MapObjects_6F5A
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6F5A::
Data_069_6F5A:: ; address name
    db $02 ; entry 0
    db $85, $01, $1E, $00, $00, $40, $70, $05, $02, $50, $25
    db $86, $01, $1F, $00, $00, $40, $60, $06, $00, $60, $26

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6F71:: ; heuristic: map object selector; C0
Data_069_6F71:: ; address name
    objsel_skip_if_clear $0025, $04, $00
    objsel_list MapObjects_6F83

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6F7B:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_6F7B:: ; address name
    objsel_unless_flag $0024, MapObjects_6F83
    objsel_list MapObjects_6F9A

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6F83::
Data_069_6F83:: ; address name
    db $02 ; entry 0
    db $85, $01, $10, $00, $00, $50, $30, $05, $00, $50, $23
    db $86, $01, $10, $00, $00, $60, $70, $06, $03, $60, $24

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_6F9A::
Data_069_6F9A:: ; address name
    db $02 ; entry 0
    db $85, $01, $10, $00, $00, $40, $50, $05, $00, $50, $23
    db $86, $01, $10, $00, $00, $50, $50, $06, $00, $60, $24

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_6FB1::
Data_069_6FB1:: ; address name
    dw $0000 ; id 0
    dw ObjSelector_6FC1 ; id 1
    dw $0000 ; id 2
    dw $0000 ; id 3
    dw $0000 ; id 4
    dw ObjSelector_6FDC ; id 5
    dw ObjSelector_700D ; id 6
    dw $0000 ; id 7

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6FC1:: ; heuristic: map object selector; C0
Data_069_6FC1:: ; address name
    objsel_list MapObjects_6FC5

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6FC5::
Data_069_6FC5:: ; address name
    db $02 ; entry 0
    db $85, $01, $0C, $00, $00, $40, $30, $05, $00, $50, $6A
    db $86, $01, $18, $00, $00, $60, $60, $06, $03, $60, $6B

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6FDC:: ; heuristic: map object selector; C0
Data_069_6FDC:: ; address name
    objsel_list MapObjects_6FE0

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6FE0::
Data_069_6FE0:: ; address name
    db $04 ; entry 0
    db $85, $01, $12, $00, $00, $30, $40, $05, $03, $50, $70
    db $86, $01, $10, $00, $00, $20, $30, $06, $00, $60, $6F
    db $86, $01, $10, $00, $02, $20, $50, $06, $02, $60, $71
    db $84, $01, $11, $00, $02, $70, $20, $04, $01, $40, $E3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_700D:: ; heuristic: map object selector; C0
Data_069_700D:: ; address name
    objsel_unless_flag $0025, MapObjects_7013
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7013::
Data_069_7013:: ; address name
    db $01 ; entry 0
    db $85, $01, $16, $00, $00, $40, $60, $05, $01, $50, $A8

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_701F::
Data_069_701F:: ; address name
    dw ObjSelector_7021 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7021:: ; heuristic: map object selector; C0
Data_069_7021:: ; address name
    objsel_list MapObjects_7025

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7025::
Data_069_7025:: ; address name
    db $04 ; entry 0
    db $85, $01, $1C, $00, $00, $70, $40, $05, $03, $50, $38
    db $86, $01, $1D, $00, $00, $60, $50, $06, $02, $60, $39
    db $87, $01, $18, $00, $00, $20, $20, $07, $00, $70, $3A
    db $87, $01, $18, $00, $00, $40, $10, $07, $00, $70, $B0

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_7052::
Data_069_7052:: ; address name
    dw ObjSelector_7054 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7054:: ; heuristic: map object selector; C0
Data_069_7054:: ; address name
    objsel_skip_if_clear $0025, $04, $00
    objsel_list MapObjects_7070

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_705E:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_705E:: ; address name
    objsel_unless_flag $0024, MapObjects_7064
    objsel_none

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_7064::
Data_069_7064:: ; address name
    db $01 ; entry 0
    db $85, $01, $1A, $00, $00, $10, $20, $05, $00, $50, $3E

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7070::
Data_069_7070:: ; address name
    db $02 ; entry 0
    db $85, $01, $1B, $00, $00, $20, $40, $05, $02, $50, $42
    db $86, $01, $1A, $00, $00, $30, $30, $06, $03, $60, $3E

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_7087::
Data_069_7087:: ; address name
    dw ObjSelector_7089 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7089:: ; heuristic: map object selector; C0
Data_069_7089:: ; address name
    objsel_unless_flag $0024, MapObjects_7091
    objsel_list MapObjects_709D

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7091::
Data_069_7091:: ; address name
    db $01 ; entry 0
    db $85, $01, $1B, $00, $00, $60, $50, $05, $01, $50, $42

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_709D::
Data_069_709D:: ; address name
    db $02 ; entry 0
    db $85, $01, $1B, $00, $00, $60, $40, $05, $00, $50, $42
    db $86, $01, $1A, $00, $00, $60, $50, $06, $02, $60, $3E

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_70B4::
Data_069_70B4:: ; address name
    dw ObjSelector_70B8 ; id 0
    dw ObjSelector_70D3 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_70B8:: ; heuristic: map object selector; C0
Data_069_70B8:: ; address name
    objsel_list MapObjects_70BC

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_70BC::
Data_069_70BC:: ; address name
    db $02 ; entry 0
    db $85, $01, $1B, $00, $00, $50, $30, $05, $00, $50, $2B
    db $86, $01, $18, $00, $00, $10, $40, $06, $01, $60, $AF

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_70D3:: ; heuristic: map object selector; C0
Data_069_70D3:: ; address name
    objsel_list MapObjects_70D7

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_70D7::
Data_069_70D7:: ; address name
    db $04 ; entry 0
    db $85, $01, $1B, $00, $00, $40, $20, $05, $00, $50, $29
    db $86, $01, $1A, $00, $00, $30, $40, $06, $03, $60, $2C
    db $87, $01, $11, $00, $02, $60, $60, $07, $01, $70, $2A
    db $85, $01, $1B, $00, $00, $80, $70, $05, $03, $50, $AE

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_7104::
Data_069_7104:: ; address name
    dw ObjSelector_7106 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7106:: ; heuristic: map object selector; C0
Data_069_7106:: ; address name
    objsel_skip_if_clear $0025, $04, $00
    objsel_list MapObjects_713A

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7110:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_7110:: ; address name
    objsel_unless_flag $012D, MapObjects_7118
    objsel_list MapObjects_713A

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_7118::
Data_069_7118:: ; address name
    db $03 ; entry 0
    db $85, $00, $02, $00, $00, $E0, $30, $05, $00, $50, $AD
    db $86, $01, $1E, $00, $00, $60, $60, $06, $00, $60, $77
    db $87, $01, $19, $00, $00, $40, $40, $07, $01, $70, $27

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_713A::
Data_069_713A:: ; address name
    db $03 ; entry 0
    db $85, $01, $1E, $00, $00, $60, $60, $05, $00, $50, $77
    db $86, $01, $19, $00, $00, $40, $40, $06, $02, $60, $27
    db $87, $00, $02, $00, $00, $40, $30, $07, $00, $70, $AD

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_715C::
Data_069_715C:: ; address name
    dw ObjSelector_715E ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_715E:: ; heuristic: map object selector; C0
Data_069_715E:: ; address name
    objsel_list MapObjects_7162

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7162::
Data_069_7162:: ; address name
    db $01 ; entry 0
    db $85, $01, $21, $00, $00, $40, $30, $05, $00, $50, $46

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_716E::
Data_069_716E:: ; address name
    dw ObjSelector_7170 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7170:: ; heuristic: map object selector; C0
Data_069_7170:: ; address name
    objsel_list MapObjects_7174

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7174::
Data_069_7174:: ; address name
    db $03 ; entry 0
    db $85, $01, $0C, $00, $00, $50, $90, $05, $02, $50, $00
    db $86, $00, $01, $00, $00, $50, $A0, $06, $00, $60, $00
    db $87, $00, $01, $00, $00, $50, $A0, $07, $00, $70, $00

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_7196::
Data_069_7196:: ; address name
    dw ObjSelector_7198 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7198:: ; heuristic: map object selector; C0
Data_069_7198:: ; address name
    objsel_unless_flag $003D, MapObjects_71B0
    objsel_unless_flag $0206, MapObjects_71DE
    objsel_unless_flag $0207, MapObjects_71DE
    objsel_unless_flag $003E, MapObjects_71B0
    objsel_unless_flag $00C8, MapObjects_71C7
    objsel_list MapObjects_71DE

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_71B0::
Data_069_71B0:: ; address name
    db $02 ; entry 0
    db $85, $01, $1E, $00, $00, $50, $30, $05, $00, $50, $8F
    db $86, $01, $5D, $00, $00, $60, $08, $06, $00, $60, $DB

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_71C7::
Data_069_71C7:: ; address name
    db $02 ; entry 0
    db $85, $01, $1E, $00, $00, $40, $30, $05, $00, $50, $8F
    db $86, $01, $5D, $00, $00, $60, $08, $06, $00, $60, $DB

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_71DE::
Data_069_71DE:: ; address name
    db $01 ; entry 0
    db $85, $01, $1E, $00, $00, $50, $30, $05, $00, $50, $8F

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_71EA::
Data_069_71EA:: ; address name
    dw ObjSelector_71EC ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_71EC:: ; heuristic: map object selector; C0
Data_069_71EC:: ; address name
    objsel_list MapObjects_71F0

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_71F0::
Data_069_71F0:: ; address name
    db $03 ; entry 0
    db $85, $01, $1E, $00, $00, $60, $30, $05, $00, $50, $72
    db $86, $01, $1F, $00, $00, $30, $60, $06, $00, $60, $73
    db $87, $00, $11, $00, $00, $40, $20, $07, $01, $70, $D0

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_7212::
Data_069_7212:: ; address name
    dw ObjSelector_7214 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7214:: ; heuristic: map object selector; C0
Data_069_7214:: ; address name
    objsel_skip_if_clear $0025, $0C, $00
    objsel_unless_flag $00C9, MapObjects_7288
    objsel_unless_flag $00CA, MapObjects_72B5
    objsel_list MapObjects_72E2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7226:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_7226:: ; address name
    objsel_unless_flag $0024, MapObjects_722E
    objsel_list MapObjects_725B

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 4 object(s), the layout of the other object lists
MapObjects_722E::
Data_069_722E:: ; address name
    db $04 ; entry 0
    db $87, $01, $15, $00, $00, $40, $30, $07, $03, $70, $89
    db $85, $01, $16, $00, $00, $70, $40, $05, $03, $50, $86
    db $85, $01, $16, $00, $00, $10, $60, $05, $02, $50, $87
    db $86, $01, $12, $00, $00, $50, $50, $06, $01, $60, $88

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 4 object(s), the layout of the other object lists
MapObjects_725B::
Data_069_725B:: ; address name
    db $04 ; entry 0
    db $87, $01, $21, $00, $00, $40, $30, $07, $03, $70, $89
    db $85, $01, $16, $00, $00, $70, $40, $05, $03, $50, $86
    db $85, $01, $16, $00, $00, $10, $60, $05, $02, $50, $87
    db $86, $01, $12, $00, $00, $50, $50, $06, $01, $60, $88

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7288::
Data_069_7288:: ; address name
    db $04 ; entry 0
    db $87, $01, $2A, $00, $00, $40, $30, $07, $03, $70, $F0
    db $85, $01, $16, $00, $00, $70, $40, $05, $03, $50, $86
    db $85, $01, $16, $00, $00, $10, $60, $05, $02, $50, $87
    db $86, $01, $12, $00, $00, $50, $50, $06, $01, $60, $88

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_72B5::
Data_069_72B5:: ; address name
    db $04 ; entry 0
    db $87, $01, $13, $00, $00, $40, $30, $07, $03, $70, $F0
    db $85, $01, $16, $00, $00, $70, $40, $05, $03, $50, $86
    db $85, $01, $16, $00, $00, $10, $60, $05, $02, $50, $87
    db $86, $01, $12, $00, $00, $50, $50, $06, $01, $60, $88

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_72E2::
Data_069_72E2:: ; address name
    db $04 ; entry 0
    db $87, $01, $17, $00, $00, $40, $30, $07, $03, $70, $F0
    db $85, $01, $16, $00, $00, $70, $40, $05, $03, $50, $86
    db $85, $01, $16, $00, $00, $10, $60, $05, $02, $50, $87
    db $86, $01, $12, $00, $00, $50, $50, $06, $01, $60, $88

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_730F::
Data_069_730F:: ; address name
    dw ObjSelector_731B ; id 0
    dw ObjSelector_734C ; id 1
    dw ObjSelector_7372 ; id 2
    dw ObjSelector_73A3 ; id 3
    dw ObjSelector_73C9 ; id 4
    dw ObjSelector_73EF ; id 5

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_731B:: ; heuristic: map object selector; C0
Data_069_731B:: ; address name
    objsel_list MapObjects_731F

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_731F::
Data_069_731F:: ; address name
    db $04 ; entry 0
    db $85, $01, $19, $00, $00, $40, $40, $05, $00, $50, $56
    db $86, $00, $55, $00, $00, $40, $50, $06, $02, $60, $57
    db $87, $01, $1D, $00, $00, $70, $60, $07, $00, $70, $BB
    db $85, $01, $07, $00, $02, $60, $70, $05, $01, $50, $BC

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_734C:: ; heuristic: map object selector; C0
Data_069_734C:: ; address name
    objsel_list MapObjects_7350

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7350::
Data_069_7350:: ; address name
    db $03 ; entry 0
    db $85, $01, $1B, $00, $00, $70, $60, $05, $00, $50, $61
    db $86, $01, $1E, $00, $00, $50, $50, $06, $02, $60, $BD
    db $87, $01, $06, $00, $02, $20, $70, $07, $01, $70, $BE

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7372:: ; heuristic: map object selector; C0
Data_069_7372:: ; address name
    objsel_list MapObjects_7376

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7376::
Data_069_7376:: ; address name
    db $04 ; entry 0
    db $85, $01, $1E, $00, $00, $10, $40, $05, $00, $50, $5B
    db $86, $01, $1F, $00, $00, $20, $50, $06, $03, $60, $BF
    db $87, $01, $10, $00, $02, $30, $60, $07, $01, $70, $5C
    db $85, $01, $1E, $00, $00, $70, $70, $05, $03, $50, $C0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_73A3:: ; heuristic: map object selector; C0
Data_069_73A3:: ; address name
    objsel_list MapObjects_73A7

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_73A7::
Data_069_73A7:: ; address name
    db $03 ; entry 0
    db $85, $01, $12, $00, $00, $60, $20, $05, $00, $50, $58
    db $86, $00, $91, $00, $00, $50, $30, $06, $01, $60, $59
    db $87, $00, $33, $00, $00, $60, $40, $07, $02, $70, $5A

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_73C9:: ; heuristic: map object selector; C0
Data_069_73C9:: ; address name
    objsel_list MapObjects_73CD

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_73CD::
Data_069_73CD:: ; address name
    db $03 ; entry 0
    db $85, $01, $15, $00, $00, $50, $20, $05, $00, $50, $5D
    db $86, $00, $5F, $00, $00, $60, $40, $06, $03, $60, $5F
    db $87, $00, $26, $01, $02, $20, $50, $07, $01, $70, $60

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_73EF:: ; heuristic: map object selector; C0
Data_069_73EF:: ; address name
    objsel_list MapObjects_73F3

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_73F3::
Data_069_73F3:: ; address name
    db $04 ; entry 0
    db $85, $01, $1C, $00, $00, $50, $50, $05, $03, $50, $55
    db $86, $01, $1D, $00, $00, $20, $30, $06, $00, $60, $5E
    db $85, $01, $1C, $00, $00, $20, $40, $05, $02, $50, $C1
    db $87, $01, $1B, $00, $02, $40, $20, $07, $01, $70, $C2

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_7420::
Data_069_7420:: ; address name
    dw ObjSelector_742C ; id 0
    dw $0000 ; id 1
    dw ObjSelector_74A3 ; id 2
    dw ObjSelector_74F9 ; id 3
    dw ObjSelector_754A ; id 4
    dw $0000 ; id 5

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_742C:: ; heuristic: map object selector; C0
Data_069_742C:: ; address name
    objsel_skip_if_clear $0025, $04, $00
    objsel_list MapObjects_745F

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7436:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_7436:: ; address name
    objsel_skip_if_clear $00D1, $04, $00
    objsel_list MapObjects_7481

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7440:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_7440:: ; address name
    objsel_unless_flag $0117, MapObjects_7448
    objsel_list MapObjects_745F

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_7448::
Data_069_7448:: ; address name
    db $02 ; entry 0
    db $85, $01, $3B, $00, $00, $40, $20, $05, $00, $50, $81
    db $86, $01, $12, $00, $00, $60, $30, $06, $03, $60, $82

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_745F::
Data_069_745F:: ; address name
    db $03 ; entry 0
    db $85, $01, $3B, $00, $00, $40, $20, $05, $00, $50, $81
    db $86, $01, $12, $00, $00, $60, $30, $06, $03, $60, $82
    db $87, $01, $10, $00, $00, $20, $40, $07, $02, $70, $20

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_7481::
Data_069_7481:: ; address name
    db $03 ; entry 0
    db $85, $01, $3B, $00, $00, $40, $20, $05, $00, $50, $81
    db $86, $01, $03, $00, $00, $30, $40, $06, $01, $60, $99
    db $87, $01, $1A, $00, $00, $60, $60, $07, $02, $70, $0A

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_74A3:: ; heuristic: map object selector; C0
Data_069_74A3:: ; address name
    objsel_skip_if_clear $0025, $04, $00
    objsel_list MapObjects_74CB

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_74AD:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_74AD:: ; address name
    objsel_skip_if_clear $00D1, $04, $00
    objsel_list MapObjects_74D7

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_74B7:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_74B7:: ; address name
    objsel_unless_flag $0122, MapObjects_74BF
    objsel_list MapObjects_74CB

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_74BF::
Data_069_74BF:: ; address name
    db $01 ; entry 0
    db $85, $01, $10, $00, $00, $40, $70, $05, $02, $50, $83

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_74CB::
Data_069_74CB:: ; address name
    db $01 ; entry 0
    db $85, $01, $10, $00, $00, $30, $60, $05, $02, $50, $83

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_74D7::
Data_069_74D7:: ; address name
    db $03 ; entry 0
    db $85, $01, $10, $00, $00, $40, $70, $05, $02, $50, $83
    db $86, $01, $1B, $00, $00, $30, $40, $06, $00, $60, $12
    db $87, $01, $1D, $00, $00, $60, $50, $07, $03, $70, $15

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_74F9:: ; heuristic: map object selector; C0
Data_069_74F9:: ; address name
    objsel_skip_if_clear $0025, $04, $00
    objsel_list MapObjects_7511

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7503:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_7503:: ; address name
    objsel_skip_if_clear $00D1, $04, $00
    objsel_list MapObjects_7528

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_750D:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_750D:: ; address name
    objsel_list MapObjects_7511

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7511::
Data_069_7511:: ; address name
    db $02 ; entry 0
    db $85, $01, $10, $00, $00, $20, $30, $05, $01, $50, $84
    db $86, $01, $10, $00, $00, $20, $60, $06, $01, $60, $85

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_7528::
Data_069_7528:: ; address name
    db $03 ; entry 0
    db $85, $01, $10, $00, $00, $50, $70, $05, $00, $50, $84
    db $86, $01, $1C, $00, $02, $30, $30, $06, $01, $60, $0C
    db $87, $01, $1E, $00, $00, $70, $40, $07, $00, $70, $25

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_754A:: ; heuristic: map object selector; C0
Data_069_754A:: ; address name
    objsel_unless_flag $0025, MapObjects_7552
    objsel_list MapObjects_755E

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7552::
Data_069_7552:: ; address name
    db $01 ; entry 0
    db $85, $01, $03, $00, $00, $30, $30, $05, $00, $50, $99

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_755E::
Data_069_755E:: ; address name
    db $01 ; entry 0
    db $85, $01, $03, $00, $00, $D0, $30, $05, $00, $50, $99

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_756A::
Data_069_756A:: ; address name
    dw ObjSelector_7570 ; id 0
    dw ObjSelector_75C6 ; id 1
    dw ObjSelector_7679 ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7570:: ; heuristic: map object selector; C0
Data_069_7570:: ; address name
    objsel_skip_if_clear $0025, $04, $00
    objsel_list MapObjects_7582

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_757A:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_757A:: ; address name
    objsel_unless_flag $0024, MapObjects_7582
    objsel_list MapObjects_7599

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7582::
Data_069_7582:: ; address name
    db $02 ; entry 0
    db $85, $01, $1E, $00, $00, $40, $60, $05, $00, $50, $8A
    db $86, $01, $1F, $00, $00, $50, $20, $06, $02, $60, $D9

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 4 object(s), the layout of the other object lists
MapObjects_7599::
Data_069_7599:: ; address name
    db $04 ; entry 0
    db $85, $01, $1E, $00, $00, $40, $60, $05, $00, $50, $8A
    db $86, $01, $1F, $00, $00, $50, $20, $06, $02, $60, $D9
    db $87, $01, $1B, $00, $00, $70, $30, $07, $00, $70, $DC
    db $87, $01, $1B, $00, $00, $70, $40, $07, $02, $70, $DD

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_75C6:: ; heuristic: map object selector; C0
Data_069_75C6:: ; address name
    objsel_skip_if_clear $0025, $04, $00
    objsel_list MapObjects_75E6

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_75D0:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_75D0:: ; address name
    objsel_skip_if_clear $00D1, $08, $00
    objsel_unless_flag $0001, MapObjects_761F
    objsel_list MapObjects_764C

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_75DE:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_75DE:: ; address name
    objsel_unless_flag $0024, MapObjects_75E6
    objsel_list MapObjects_75F2

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_75E6::
Data_069_75E6:: ; address name
    db $01 ; entry 0
    db $85, $01, $12, $00, $00, $30, $50, $05, $00, $50, $8D

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 4 object(s), the layout of the other object lists
MapObjects_75F2::
Data_069_75F2:: ; address name
    db $04 ; entry 0
    db $85, $01, $1A, $00, $00, $30, $50, $05, $00, $50, $DE
    db $85, $01, $1A, $00, $00, $20, $10, $05, $02, $50, $DF
    db $86, $01, $10, $00, $00, $50, $20, $06, $02, $60, $E0
    db $87, $01, $11, $00, $02, $70, $30, $07, $01, $70, $E1

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 4 object(s), the layout of the other object lists
MapObjects_761F::
Data_069_761F:: ; address name
    db $04 ; entry 0
    db $85, $01, $04, $00, $00, $80, $20, $05, $03, $50, $00
    db $86, $01, $05, $00, $00, $80, $30, $06, $03, $60, $00
    db $87, $01, $00, $00, $00, $80, $40, $07, $03, $70, $00
    db $84, $01, $02, $00, $00, $E0, $30, $04, $01, $40, $00

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 4 object(s), the layout of the other object lists
MapObjects_764C::
Data_069_764C:: ; address name
    db $04 ; entry 0
    db $85, $01, $04, $00, $00, $80, $20, $05, $03, $50, $00
    db $86, $01, $05, $00, $00, $80, $30, $06, $03, $60, $00
    db $87, $01, $01, $00, $00, $80, $40, $07, $03, $70, $00
    db $84, $01, $02, $00, $00, $E0, $30, $04, $01, $40, $00

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7679:: ; heuristic: map object selector; C0
Data_069_7679:: ; address name
    objsel_unless_flag $0024, MapObjects_7689
    objsel_unless_flag $00D1, MapObjects_76AB
    objsel_unless_flag $0025, MapObjects_7689
    objsel_list MapObjects_76C2

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7689::
Data_069_7689:: ; address name
    db $03 ; entry 0
    db $85, $01, $10, $00, $00, $20, $20, $05, $00, $50, $8C
    db $86, $00, $7A, $00, $00, $40, $40, $06, $02, $60, $D7
    db $87, $01, $11, $00, $00, $40, $30, $07, $00, $70, $D6

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_76AB::
Data_069_76AB:: ; address name
    db $02 ; entry 0
    db $85, $01, $10, $00, $00, $30, $20, $05, $00, $50, $8C
    db $86, $01, $12, $00, $00, $60, $30, $06, $01, $60, $8D

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_76C2::
Data_069_76C2:: ; address name
    db $03 ; entry 0
    db $85, $01, $10, $00, $00, $20, $20, $05, $00, $50, $8C
    db $86, $00, $7A, $00, $00, $50, $40, $06, $02, $60, $D7
    db $87, $01, $11, $00, $00, $50, $30, $07, $00, $70, $D6

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_76E4::
Data_069_76E4:: ; address name
    dw ObjSelector_76E8 ; id 0
    dw Data_069_76F8 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_76E8:: ; heuristic: map object selector; C0
Data_069_76E8:: ; address name
    objsel_list MapObjects_76EC

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_76EC::
Data_069_76EC:: ; address name
    db $02 ; entry 0
    db $85, $01, $57, $00, $00, $45, $80, $05, $02, $50, $00
Data_069_76F8:: ; heuristic: map object selector; C0
    db $FE, $FF, $FC, $76, $01, $85, $01, $57, $00, $00, $45
    db $A0, $05, $02, $50, $00

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_7708::
Data_069_7708:: ; address name
    dw ObjSelector_770C ; id 0
    dw ObjSelector_776E ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_770C:: ; heuristic: map object selector; C0
Data_069_770C:: ; address name
    objsel_unless_flag $0001, MapObjects_7714
    objsel_list MapObjects_7741

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7714::
Data_069_7714:: ; address name
    db $04 ; entry 0
    db $85, $01, $04, $00, $00, $50, $10, $05, $00, $50, $32
    db $86, $01, $05, $00, $00, $40, $10, $06, $00, $60, $31
    db $87, $01, $28, $00, $00, $80, $40, $07, $01, $70, $30
    db $84, $01, $00, $00, $00, $B0, $50, $04, $03, $40, $00

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7741::
Data_069_7741:: ; address name
    db $04 ; entry 0
    db $85, $01, $04, $00, $00, $50, $10, $05, $00, $50, $32
    db $86, $01, $05, $00, $00, $40, $10, $06, $00, $60, $31
    db $87, $01, $28, $00, $00, $80, $40, $07, $01, $70, $30
    db $84, $01, $01, $00, $00, $B0, $50, $04, $03, $40, $00

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_776E:: ; heuristic: map object selector; C0
Data_069_776E:: ; address name
    objsel_skip_if_set $0012, $08, $00
    objsel_unless_flag $0001, MapObjects_7784
    objsel_list MapObjects_77B1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_777C:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_777C:: ; address name
    objsel_unless_flag $0001, MapObjects_77DE
    objsel_list MapObjects_7800

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7784::
Data_069_7784:: ; address name
    db $04 ; entry 0
    db $85, $01, $29, $00, $02, $50, $30, $05, $01, $50, $2D
    db $86, $01, $29, $00, $00, $10, $60, $06, $00, $60, $2E
    db $87, $01, $00, $00, $00, $E0, $50, $07, $01, $70, $2F
    db $86, $01, $29, $00, $00, $20, $E0, $06, $02, $60, $00

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_77B1::
Data_069_77B1:: ; address name
    db $04 ; entry 0
    db $85, $01, $29, $00, $02, $50, $30, $05, $01, $50, $2D
    db $86, $01, $29, $00, $00, $10, $60, $06, $00, $60, $2E
    db $87, $01, $01, $00, $00, $E0, $50, $07, $01, $70, $2F
    db $86, $01, $29, $00, $00, $20, $E0, $06, $02, $60, $00

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_77DE::
Data_069_77DE:: ; address name
    db $03 ; entry 0
    db $85, $01, $29, $00, $02, $50, $30, $05, $01, $50, $2D
    db $86, $01, $29, $00, $00, $10, $60, $06, $00, $60, $2E
    db $87, $01, $00, $00, $00, $30, $40, $07, $01, $70, $2F

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_7800::
Data_069_7800:: ; address name
    db $03 ; entry 0
    db $85, $01, $29, $00, $02, $50, $30, $05, $01, $50, $2D
    db $86, $01, $29, $00, $00, $10, $60, $06, $00, $60, $2E
    db $87, $01, $01, $00, $00, $30, $40, $07, $01, $70, $2F

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_7822::
Data_069_7822:: ; address name
    dw ObjSelector_7826 ; id 0
    dw ObjSelector_7857 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7826:: ; heuristic: map object selector; C0
Data_069_7826:: ; address name
    objsel_list MapObjects_782A

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_782A::
Data_069_782A:: ; address name
    db $04 ; entry 0
    db $85, $01, $23, $00, $00, $40, $70, $05, $01, $50, $00
    db $86, $01, $24, $00, $00, $10, $60, $06, $02, $60, $01
    db $87, $01, $25, $00, $00, $10, $50, $07, $00, $70, $02
    db $87, $01, $25, $00, $00, $70, $30, $07, $00, $70, $03

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7857:: ; heuristic: map object selector; C0
Data_069_7857:: ; address name
    objsel_list MapObjects_785B

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_785B::
Data_069_785B:: ; address name
    db $03 ; entry 0
    db $85, $01, $26, $00, $00, $60, $50, $05, $00, $50, $04
    db $86, $01, $25, $00, $02, $30, $60, $06, $01, $60, $05
    db $87, $01, $24, $00, $00, $10, $30, $07, $00, $70, $06

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_787D::
Data_069_787D:: ; address name
    dw ObjSelector_787F ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_787F:: ; heuristic: map object selector; C0
Data_069_787F:: ; address name
    objsel_list MapObjects_7883

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7883::
Data_069_7883:: ; address name
    db $03 ; entry 0
    db $85, $01, $24, $00, $00, $30, $40, $05, $01, $50, $0A
    db $86, $01, $25, $00, $00, $80, $70, $06, $03, $60, $0B
    db $87, $01, $12, $00, $00, $50, $10, $07, $00, $70, $45

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_78A5::
Data_069_78A5:: ; address name
    dw ObjSelector_78A7 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_78A7:: ; heuristic: map object selector; C0
Data_069_78A7:: ; address name
    objsel_list MapObjects_78AB

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_78AB::
Data_069_78AB:: ; address name
    db $02 ; entry 0
    db $85, $01, $24, $00, $00, $10, $60, $05, $02, $50, $1F
    db $86, $01, $24, $00, $00, $50, $10, $06, $00, $60, $20

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_78C2::
Data_069_78C2:: ; address name
    dw ObjSelector_78CA ; id 0
    dw ObjSelector_792C ; id 1
    dw ObjSelector_7947 ; id 2
    dw ObjSelector_7978 ; id 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_78CA:: ; heuristic: map object selector; C0
Data_069_78CA:: ; address name
    objsel_unless_flag $0043, MapObjects_78D2
    objsel_list MapObjects_78FF

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_78D2::
Data_069_78D2:: ; address name
    db $04 ; entry 0
    db $85, $01, $4D, $00, $00, $40, $10, $05, $00, $50, $13
    db $85, $01, $4D, $00, $00, $50, $10, $05, $00, $50, $14
    db $86, $01, $24, $00, $00, $70, $60, $06, $03, $60, $0D
    db $87, $01, $25, $00, $00, $30, $70, $07, $00, $70, $15

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_78FF::
Data_069_78FF:: ; address name
    db $04 ; entry 0
    db $85, $01, $4D, $00, $00, $30, $20, $05, $00, $50, $13
    db $85, $01, $4D, $00, $02, $60, $30, $05, $00, $50, $14
    db $86, $01, $24, $00, $00, $70, $60, $06, $03, $60, $0D
    db $87, $01, $25, $00, $00, $30, $70, $07, $00, $70, $15

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_792C:: ; heuristic: map object selector; C0
Data_069_792C:: ; address name
    objsel_list MapObjects_7930

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7930::
Data_069_7930:: ; address name
    db $02 ; entry 0
    db $85, $01, $12, $00, $00, $60, $30, $05, $00, $50, $17
    db $86, $01, $4D, $00, $00, $20, $60, $06, $01, $60, $0E

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7947:: ; heuristic: map object selector; C0
Data_069_7947:: ; address name
    objsel_list MapObjects_794B

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_794B::
Data_069_794B:: ; address name
    db $04 ; entry 0
    db $85, $01, $26, $00, $00, $70, $70, $05, $03, $50, $0C
    db $86, $01, $24, $00, $00, $20, $40, $06, $00, $60, $10
    db $87, $01, $15, $00, $00, $80, $20, $07, $00, $70, $12
    db $85, $01, $26, $00, $02, $60, $50, $05, $01, $50, $11

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7978:: ; heuristic: map object selector; C0
Data_069_7978:: ; address name
    objsel_unless_flag $0043, MapObjects_7980
    objsel_list MapObjects_79A2

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7980::
Data_069_7980:: ; address name
    db $03 ; entry 0
    db $85, $01, $25, $00, $00, $20, $60, $05, $03, $50, $0F
    db $86, $01, $24, $00, $00, $50, $50, $06, $00, $60, $16
    db $87, $01, $4B, $00, $00, $40, $30, $07, $00, $70, $18

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_79A2::
Data_069_79A2:: ; address name
    db $02 ; entry 0
    db $85, $01, $25, $00, $00, $20, $60, $05, $03, $50, $0F
    db $86, $01, $24, $00, $00, $50, $50, $06, $00, $60, $16

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_79B9::
Data_069_79B9:: ; address name
    dw ObjSelector_79BD ; id 0
    dw ObjSelector_7A32 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_79BD:: ; heuristic: map object selector; C0
Data_069_79BD:: ; address name
    objsel_skip_if_clear $005A, $04, $00
    objsel_list MapObjects_79ED

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_79C7:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_79C7:: ; address name
    objsel_skip_if_set $0043, $02, $00
    objsel_none

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_79CF:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_79CF:: ; address name
    objsel_skip_if_clear $0055, $06, $00
    objsel_unless_flag $0056, MapObjects_7A10
    objsel_none

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_79DB:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_79DB:: ; address name
    objsel_skip_if_clear $0053, $04, $00
    objsel_list MapObjects_79ED

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_79E5:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_79E5:: ; address name
    objsel_unless_flag $0049, MapObjects_79ED
    objsel_list MapObjects_7A04

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_79ED::
Data_069_79ED:: ; address name
    db $02 ; entry 0
    db $85, $01, $4D, $00, $00, $30, $50, $05, $00, $50, $27
    db $86, $01, $24, $00, $02, $60, $40, $06, $00, $60, $28

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_7A04::
Data_069_7A04:: ; address name
    db $01 ; entry 0
    db $85, $01, $4D, $00, $00, $30, $50, $05, $00, $50, $27

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_7A10::
Data_069_7A10:: ; address name
    db $03 ; entry 0
    db $85, $01, $22, $00, $00, $40, $18, $05, $00, $50, $2B
    db $86, $01, $4D, $00, $00, $30, $50, $06, $00, $60, $27
    db $87, $01, $24, $00, $00, $60, $40, $07, $00, $70, $28

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7A32:: ; heuristic: map object selector; C0
Data_069_7A32:: ; address name
    objsel_skip_if_clear $005A, $04, $00
    objsel_list MapObjects_7A6F

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7A3C:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_7A3C:: ; address name
    objsel_unless_flag $0056, MapObjects_7A42
    objsel_none

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 4 object(s), the layout of the other object lists
MapObjects_7A42::
Data_069_7A42:: ; address name
    db $04 ; entry 0
    db $85, $01, $4C, $00, $00, $20, $10, $05, $03, $50, $22
    db $85, $01, $4C, $00, $00, $20, $20, $05, $03, $50, $23
    db $85, $01, $4C, $00, $00, $10, $30, $05, $02, $50, $24
    db $86, $01, $4B, $00, $00, $30, $50, $06, $00, $60, $21

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7A6F::
Data_069_7A6F:: ; address name
    db $03 ; entry 0
    db $85, $01, $4C, $00, $00, $20, $10, $05, $03, $50, $22
    db $85, $01, $4C, $00, $00, $20, $20, $05, $03, $50, $23
    db $86, $01, $4B, $00, $00, $30, $50, $06, $00, $60, $21

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_7A91::
Data_069_7A91:: ; address name
    dw ObjSelector_7A93 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7A93:: ; heuristic: map object selector; C0
Data_069_7A93:: ; address name
    objsel_skip_if_set $0025, $0A, $00
    objsel_skip_if_clear $00D1, $04, $00
    objsel_list MapObjects_7B26

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7AA3:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_7AA3:: ; address name
    objsel_skip_if_clear $005A, $04, $00
    objsel_list MapObjects_7ACB

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7AAD:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_7AAD:: ; address name
    objsel_skip_if_clear $0055, $06, $00
    objsel_unless_flag $0056, MapObjects_7AEE
    objsel_none

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7AB9:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_7AB9:: ; address name
    objsel_skip_if_clear $0053, $04, $00
    objsel_list MapObjects_7ACB

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7AC3:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_7AC3:: ; address name
    objsel_unless_flag $0049, MapObjects_7ACB
    objsel_list MapObjects_7AE2

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_7ACB::
Data_069_7ACB:: ; address name
    db $02 ; entry 0
    db $85, $01, $24, $00, $00, $50, $A0, $05, $02, $50, $28
    db $86, $01, $22, $00, $00, $40, $10, $06, $00, $60, $2B

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_7AE2::
Data_069_7AE2:: ; address name
    db $01 ; entry 0
    db $85, $01, $24, $00, $00, $50, $40, $05, $00, $50, $28

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 5 object(s), the layout of the other object lists
MapObjects_7AEE::
Data_069_7AEE:: ; address name
    db $05 ; entry 0
    db $85, $01, $22, $00, $00, $40, $10, $05, $00, $50, $2B
    db $87, $01, $4D, $00, $00, $50, $50, $07, $02, $70, $00
    db $86, $01, $24, $00, $00, $40, $50, $06, $02, $60, $28
    db $87, $01, $4D, $00, $00, $30, $50, $06, $02, $70, $00
    db $87, $01, $4D, $00, $00, $60, $50, $06, $02, $70, $00

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 5 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7B26::
Data_069_7B26:: ; address name
    db $05 ; entry 0
    db $85, $01, $22, $00, $00, $40, $10, $05, $00, $50, $2B
    db $86, $01, $24, $00, $00, $60, $20, $06, $00, $60, $28
    db $87, $01, $4B, $00, $00, $40, $50, $07, $02, $70, $21
    db $83, $01, $4C, $00, $00, $30, $60, $03, $02, $30, $23
    db $83, $01, $4C, $00, $00, $60, $60, $03, $02, $30, $23

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_7B5E::
Data_069_7B5E:: ; address name
    dw ObjSelector_7B62 ; id 0
    dw ObjSelector_7B72 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7B62:: ; heuristic: map object selector; C0
Data_069_7B62:: ; address name
    objsel_list MapObjects_7B66

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7B66::
Data_069_7B66:: ; address name
    db $01 ; entry 0
    db $85, $00, $4F, $00, $00, $50, $20, $05, $00, $50, $3B

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7B72:: ; heuristic: map object selector; C0
Data_069_7B72:: ; address name
    objsel_skip_if_clear $005A, $02, $00
    objsel_none

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7B7A:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_7B7A:: ; address name
    objsel_list MapObjects_7B7E

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 4 object(s), the layout of the other object lists
MapObjects_7B7E::
Data_069_7B7E:: ; address name
    db $04 ; entry 0
    db $85, $01, $5C, $00, $00, $40, $10, $05, $00, $50, $3C
    db $86, $01, $22, $00, $00, $40, $A0, $06, $02, $60, $2B
    db $87, $01, $4D, $00, $00, $40, $B0, $07, $02, $70, $00
    db $87, $01, $4D, $00, $00, $40, $C0, $07, $02, $70, $00

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_7BAB::
Data_069_7BAB:: ; address name
    dw ObjSelector_7BAD ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7BAD:: ; heuristic: map object selector; C0
Data_069_7BAD:: ; address name
    objsel_skip_if_set $004A, $08, $00
    objsel_unless_flag $0049, MapObjects_7BBF
    objsel_list MapObjects_7BCB

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7BBB:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_7BBB:: ; address name
    objsel_list MapObjects_7BE2

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7BBF::
Data_069_7BBF:: ; address name
    db $01 ; entry 0
    db $85, $01, $26, $00, $00, $20, $40, $05, $00, $50, $09

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7BCB::
Data_069_7BCB:: ; address name
    db $02 ; entry 0
    db $85, $01, $22, $00, $00, $20, $50, $05, $02, $50, $2B
    db $86, $01, $26, $00, $00, $20, $40, $06, $00, $60, $09

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_7BE2::
Data_069_7BE2:: ; address name
    db $02 ; entry 0
    db $85, $01, $22, $00, $00, $E0, $E0, $05, $02, $50, $2B
    db $86, $01, $26, $00, $00, $20, $10, $06, $00, $60, $09

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_7BF9::
Data_069_7BF9:: ; address name
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
ObjSelector_7C19:: ; heuristic: map object selector; C0
Data_069_7C19:: ; address name
    objsel_skip_if_clear $0054, $02, $00
    objsel_none

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7C21:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_7C21:: ; address name
    objsel_unless_flag $0053, MapObjects_7C29
    objsel_list MapObjects_7C40

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_7C29::
Data_069_7C29:: ; address name
    db $02 ; entry 0
    db $85, $01, $22, $00, $00, $30, $70, $05, $02, $50, $2B
    db $86, $00, $4F, $00, $00, $30, $60, $06, $00, $60, $37

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_7C40::
Data_069_7C40:: ; address name
    db $01 ; entry 0
    db $85, $01, $22, $00, $00, $30, $70, $05, $02, $50, $2B

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_7C4C::
Data_069_7C4C:: ; address name
    dw ObjSelector_7C4E ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7C4E:: ; heuristic: map object selector; C0
Data_069_7C4E:: ; address name
    objsel_skip_if_clear $005A, $04, $00
    objsel_list MapObjects_7CAF

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7C58:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_7C58:: ; address name
    objsel_unless_flag $0056, MapObjects_7C60
    objsel_list MapObjects_7C82

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_7C60::
Data_069_7C60:: ; address name
    db $03 ; entry 0
    db $85, $01, $4D, $00, $00, $50, $30, $05, $00, $50, $2C
    db $86, $01, $4D, $00, $00, $20, $40, $06, $02, $60, $2D
    db $87, $01, $24, $00, $00, $20, $20, $07, $00, $70, $00

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 4 object(s), the layout of the other object lists
MapObjects_7C82::
Data_069_7C82:: ; address name
    db $04 ; entry 0
    db $85, $01, $24, $00, $00, $20, $20, $05, $00, $50, $00
    db $86, $01, $4B, $00, $00, $20, $60, $06, $02, $60, $00
    db $87, $01, $4C, $00, $00, $20, $70, $07, $01, $70, $00
    db $87, $01, $4C, $00, $00, $30, $70, $07, $03, $70, $00

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7CAF::
Data_069_7CAF:: ; address name
    db $04 ; entry 0
    db $85, $01, $4D, $00, $00, $50, $30, $05, $00, $50, $2C
    db $86, $01, $27, $00, $00, $30, $70, $06, $00, $60, $00
    db $86, $01, $27, $00, $00, $10, $70, $06, $01, $60, $00
    db $86, $01, $27, $00, $00, $20, $70, $06, $03, $60, $00

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_7CDC::
Data_069_7CDC:: ; address name
    dw ObjSelector_7CDE ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7CDE:: ; heuristic: map object selector; C0
Data_069_7CDE:: ; address name
    objsel_skip_if_clear $005A, $04, $00
    objsel_list MapObjects_7CF8

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7CE8:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_7CE8:: ; address name
    objsel_skip_if_clear $0055, $06, $00
    objsel_unless_flag $0056, MapObjects_7D0F
    objsel_none

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7CF4:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_7CF4:: ; address name
    objsel_list MapObjects_7CF8

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7CF8::
Data_069_7CF8:: ; address name
    db $02 ; entry 0
    db $85, $01, $4D, $00, $00, $40, $40, $05, $00, $50, $25
    db $85, $01, $4D, $00, $00, $50, $40, $05, $00, $50, $26

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 3 object(s), the layout of the other object lists
MapObjects_7D0F::
Data_069_7D0F:: ; address name
    db $03 ; entry 0
    db $85, $01, $22, $00, $00, $30, $60, $05, $01, $50, $2B
    db $86, $01, $4D, $00, $00, $60, $50, $06, $02, $60, $25
    db $86, $01, $4D, $00, $00, $70, $70, $06, $03, $60, $26

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_7D31::
Data_069_7D31:: ; address name
    dw ObjSelector_7D39 ; id 0
    dw ObjSelector_7D51 ; id 1
    dw ObjSelector_7DDD ; id 2
    dw $0000 ; id 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7D39:: ; heuristic: map object selector; C0
Data_069_7D39:: ; address name
    objsel_skip_if_set $005A, $02, $00
    objsel_none

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7D41:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_7D41:: ; address name
    objsel_list MapObjects_7D45

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_7D45::
Data_069_7D45:: ; address name
    db $01 ; entry 0
    db $85, $00, $4F, $00, $00, $30, $60, $05, $01, $50, $3D

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7D51:: ; heuristic: map object selector; C0
Data_069_7D51:: ; address name
    objsel_skip_if_set $0025, $0A, $00
    objsel_skip_if_clear $00D1, $04, $00
    objsel_list MapObjects_7DBB

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7D61:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_7D61:: ; address name
    objsel_skip_if_clear $005C, $04, $00
    objsel_list MapObjects_7DAF

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7D6B:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_7D6B:: ; address name
    objsel_skip_if_clear $005A, $04, $00
    objsel_list MapObjects_7D98

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7D75:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_7D75:: ; address name
    objsel_skip_if_set $0058, $02, $00
    objsel_none

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7D7D:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_7D7D:: ; address name
    objsel_list MapObjects_7D81

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_7D81::
Data_069_7D81:: ; address name
    db $02 ; entry 0
    db $85, $00, $4F, $00, $00, $30, $60, $05, $00, $50, $3A
    db $85, $00, $4F, $00, $00, $60, $40, $05, $03, $50, $3B

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 2 object(s), the layout of the other object lists
MapObjects_7D98::
Data_069_7D98:: ; address name
    db $02 ; entry 0
    db $85, $00, $4F, $00, $00, $30, $60, $05, $00, $50, $3A
    db $85, $00, $4F, $00, $00, $60, $40, $05, $00, $50, $37

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 1 object(s), the layout of the other object lists
MapObjects_7DAF::
Data_069_7DAF:: ; address name
    db $01 ; entry 0
    db $85, $00, $4F, $00, $00, $30, $60, $05, $00, $50, $3A

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7DBB::
Data_069_7DBB:: ; address name
    db $03 ; entry 0
    db $85, $00, $4F, $00, $00, $40, $E0, $05, $00, $50, $37
    db $85, $00, $4F, $00, $00, $50, $E0, $05, $00, $50, $37
    db $85, $00, $4F, $00, $00, $40, $E0, $05, $00, $50, $3A

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7DDD:: ; heuristic: map object selector; C0
Data_069_7DDD:: ; address name
    objsel_skip_if_clear $0058, $02, $00
    objsel_none

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7DE5:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_7DE5:: ; address name
    objsel_skip_if_set $0056, $02, $00
    objsel_none

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7DED:: ; heuristic: map object selector found by tiling a gap; C0
Data_069_7DED:: ; address name
    objsel_list MapObjects_7DF1

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 4 object(s), the layout of the other object lists
MapObjects_7DF1::
Data_069_7DF1:: ; address name
    db $04 ; entry 0
    db $85, $01, $22, $00, $00, $60, $60, $05, $02, $50, $2B
    db $86, $01, $4D, $00, $00, $10, $40, $06, $02, $60, $25
    db $86, $01, $4D, $00, $02, $20, $70, $06, $02, $60, $26
    db $86, $01, $4D, $00, $00, $80, $50, $06, $02, $60, $2D

; E-0218 (derived: an object list found by tiling a gap between map object layouts)
; record: count, then 4 object(s), the layout of the other object lists
MapObjects_7E1E::
Data_069_7E1E:: ; address name
    db $04 ; entry 0
    db $85, $01, $22, $00, $00, $60, $30, $05, $03, $50, $2B
    db $86, $01, $4D, $00, $00, $10, $10, $06, $02, $60, $25
    db $86, $01, $4D, $00, $02, $20, $40, $06, $01, $60, $26
    db $86, $01, $4D, $00, $00, $80, $20, $06, $03, $60, $2D

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_7E4B::
Data_069_7E4B:: ; address name
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
