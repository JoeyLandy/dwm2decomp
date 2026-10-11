SECTION "Bank 69", ROMX[$4000], BANK[$69]
    db $69

; clears the sprite slots; key-world maps set up their objects, other maps load the object list for hMapId (with a story-flag case on map $2F) (E-0131)
; 4 call sites from 4 routines (e.g. InitFieldScreen, RunFieldActionRequestActionIfBit7_Case02, ScriptCommandF6_Run_Case06, ScriptCommandED_Run_Case07_Case02)
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
    ld hl, Data_069_7E1E
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
Data_069_4174:: ; heuristic: start of a structured table; C0
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
Data_069_433C:: ; heuristic: map object screen array; C0
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
Data_069_4348:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $01, $41, $00, $00, $40, $20, $05, $00, $50, $A7

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4354::
Data_069_4354:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $01, $41, $00, $00, $30, $20, $05, $00, $50, $A7

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4360::
Data_069_4360:: ; heuristic: map object screen array; C0
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
Data_069_436A:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $00, $0D, $00, $00, $40, $30, $05, $00, $50, $A6

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4376::
Data_069_4376:: ; heuristic: map object screen array; C0
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
Data_069_4380:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $00, $5C, $00, $00, $40, $30, $05, $00, $50, $A5

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_438C::
Data_069_438C:: ; heuristic: map object screen array; C0
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
Data_069_4396:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $00, $55, $00, $00, $40, $30, $05, $00, $50, $A4

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_43A2::
Data_069_43A2:: ; heuristic: map object screen array; C0
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
Data_069_43AC:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $00, $10, $00, $00, $40, $30, $05, $00, $50, $A3

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_43B8::
Data_069_43B8:: ; heuristic: map object screen array; C0
    dw ObjSelector_43BC ; id 0
    dw ObjSelector_43D7 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_43BC:: ; heuristic: map object selector; C0
Data_069_43BC:: ; address name
    objsel_list MapObjects_43C0

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_43C0::
Data_069_43C0:: ; heuristic: start of a structured table; C0
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
Data_069_43DB:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $00, $59, $00, $00, $40, $30, $05, $00, $50, $A2

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_43E7::
Data_069_43E7:: ; heuristic: map object screen array; C0
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
Data_069_43F3:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $00, $9A, $00, $00, $40, $20, $05, $00, $50, $87

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_43FF::
Data_069_43FF:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $00, $9A, $00, $00, $30, $20, $05, $00, $50, $87

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_440B::
Data_069_440B:: ; heuristic: map object screen array; C0
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
Data_069_4415:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $00, $8D, $00, $00, $40, $30, $05, $00, $50, $86

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4421::
Data_069_4421:: ; heuristic: map object screen array; C0
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
Data_069_442B:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $00, $80, $00, $00, $40, $30, $05, $00, $50, $85

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4437::
Data_069_4437:: ; heuristic: map object screen array; C0
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
Data_069_4441:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $00, $92, $00, $00, $40, $30, $05, $00, $50, $84

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_444D::
Data_069_444D:: ; heuristic: map object screen array; C0
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
Data_069_4457:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $00, $39, $00, $00, $40, $30, $05, $00, $50, $83

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4463::
Data_069_4463:: ; heuristic: map object screen array; C0
    dw ObjSelector_4467 ; id 0
    dw ObjSelector_4482 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4467:: ; heuristic: map object selector; C0
Data_069_4467:: ; address name
    objsel_list MapObjects_446B

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_446B::
Data_069_446B:: ; heuristic: start of a structured table; C0
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
Data_069_4486:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $00, $51, $00, $00, $40, $30, $05, $00, $50, $82

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4492::
Data_069_4492:: ; heuristic: map object screen array; C0
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
Data_069_449E:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $00, $ED, $00, $00, $40, $20, $05, $00, $50, $67

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_44AA::
Data_069_44AA:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $00, $ED, $00, $00, $30, $20, $05, $00, $50, $67

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_44B6::
Data_069_44B6:: ; heuristic: map object screen array; C0
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
Data_069_44C0:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $00, $25, $01, $00, $40, $30, $05, $00, $50, $66

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_44CC::
Data_069_44CC:: ; heuristic: map object screen array; C0
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
Data_069_44D6:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $00, $2E, $01, $00, $40, $30, $05, $00, $50, $65

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_44E2::
Data_069_44E2:: ; heuristic: map object screen array; C0
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
Data_069_44EC:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $00, $55, $01, $00, $40, $30, $05, $00, $50, $64

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_44F8::
Data_069_44F8:: ; heuristic: map object screen array; C0
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
Data_069_4502:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $00, $4E, $00, $00, $40, $30, $05, $00, $50, $63

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_450E::
Data_069_450E:: ; heuristic: map object screen array; C0
    dw ObjSelector_4512 ; id 0
    dw ObjSelector_452D ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4512:: ; heuristic: map object selector; C0
Data_069_4512:: ; address name
    objsel_list MapObjects_4516

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4516::
Data_069_4516:: ; heuristic: start of a structured table; C0
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
Data_069_4531:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $00, $06, $00, $00, $40, $30, $05, $00, $50, $62

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_453D::
Data_069_453D:: ; heuristic: map object screen array; C0
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
Data_069_4549:: ; heuristic: start of a structured table; C0
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
Data_069_456F:: ; heuristic: start of a structured table; C0
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
Data_069_45A0:: ; heuristic: start of a structured table; C0
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
Data_069_45C6:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $01, $07, $00, $02, $20, $60, $05, $01, $50, $33
    db $86, $01, $0A, $00, $00, $60, $40, $06, $00, $60, $34
    db $87, $01, $0B, $00, $00, $20, $20, $07, $00, $70, $35

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_45E8::
Data_069_45E8:: ; heuristic: map object screen array; C0
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
Data_069_45F4:: ; heuristic: start of a structured table; C0
    db $02 ; entry 0
    db $85, $01, $2A, $00, $00, $70, $60, $05, $03, $50, $43
    db $86, $01, $51, $00, $00, $30, $40, $06, $00, $60, $44

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_460B::
Data_069_460B:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $01, $2A, $00, $00, $70, $60, $05, $03, $50, $43

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4617:: ; heuristic: map object selector; C0
Data_069_4617:: ; address name
    objsel_list MapObjects_461B

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_461B::
Data_069_461B:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $01, $16, $00, $00, $50, $60, $05, $00, $50, $40
    db $86, $01, $22, $00, $02, $50, $20, $06, $01, $60, $41
    db $87, $01, $13, $00, $00, $30, $40, $07, $00, $70, $42

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_463D::
Data_069_463D:: ; heuristic: map object screen array; C0
    dw ObjSelector_4641 ; id 0
    dw ObjSelector_466B ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4641:: ; heuristic: map object selector; C0
Data_069_4641:: ; address name
    objsel_skip_if_set $01C0, $02, $00
    objsel_none
    db $C1, $01, $53, $46, $C3, $01, $5F, $46, $FF, $FF, $01, $85, $01, $43, $00, $00
    db $40, $20, $05, $02, $50, $3F, $01, $85, $01, $43, $00, $00, $30, $20, $05, $00
    db $50, $3F

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_466B:: ; heuristic: map object selector; C0
Data_069_466B:: ; address name
    objsel_skip_if_set $01B9, $02, $00
    objsel_none
    db $BB, $01, $7D, $46, $BC, $01, $9F, $46, $FF, $FF, $03, $85, $00, $D3, $00, $00
    db $40, $10, $05, $01, $50, $45, $86, $00, $D3, $00, $00, $50, $10, $06, $03, $60
    db $46, $87, $01, $5A, $00, $00, $50, $E0, $07, $00, $70, $47, $01, $85, $01, $5A
    db $00, $00, $50, $10, $05, $00, $50, $47

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_46AB::
Data_069_46AB:: ; heuristic: map object screen array; C0
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
Data_069_46C5:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $01, $15, $00, $00, $30, $20, $05, $00, $50, $3D
    db $86, $01, $43, $00, $00, $70, $40, $06, $00, $60, $3F
    db $87, $01, $13, $00, $00, $70, $70, $07, $00, $70, $3E

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_46E7::
Data_069_46E7:: ; heuristic: start of a structured table; C0
    db $02 ; entry 0
    db $85, $01, $15, $00, $00, $30, $20, $05, $00, $50, $3D
    db $86, $01, $13, $00, $00, $70, $70, $06, $00, $60, $3E

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_46FE::
Data_069_46FE:: ; heuristic: map object screen array; C0
    dw ObjSelector_4700 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4700:: ; heuristic: map object selector; C0
Data_069_4700:: ; address name
    objsel_unless_flag $01C3, MapObjects_4706
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4706::
Data_069_4706:: ; heuristic: start of a structured table; C0
    db $02 ; entry 0
    db $85, $01, $51, $00, $00, $50, $20, $05, $00, $50, $48
    db $86, $01, $43, $00, $00, $E0, $E0, $06, $00, $60, $3F

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_471D::
Data_069_471D:: ; heuristic: map object screen array; C0
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
Data_069_472B:: ; heuristic: start of a structured table; C0
    db $02 ; entry 0
    db $85, $01, $20, $00, $00, $30, $40, $05, $02, $50, $20
    db $86, $00, $2A, $01, $00, $40, $30, $06, $00, $60, $21

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4742::
Data_069_4742:: ; heuristic: start of a structured table; C0
    db $02 ; entry 0
    db $85, $01, $20, $00, $00, $10, $40, $05, $02, $50, $20
    db $86, $00, $2A, $01, $00, $40, $30, $06, $00, $60, $21

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4759::
Data_069_4759:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $01, $20, $00, $00, $60, $50, $05, $02, $50, $20
    db $86, $00, $2A, $01, $00, $40, $30, $06, $00, $60, $21
    db $87, $00, $29, $01, $00, $50, $10, $07, $00, $70, $2D

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_477B::
Data_069_477B:: ; heuristic: map object screen array; C0
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
Data_069_4787:: ; heuristic: start of a structured table; C0
    db $02 ; entry 0
    db $85, $00, $29, $01, $00, $40, $20, $05, $00, $50, $2D
    db $86, $01, $61, $00, $00, $40, $E0, $06, $00, $60, $2D

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_479E::
Data_069_479E:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $01, $61, $00, $00, $40, $20, $05, $00, $50, $2D

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_47AA::
Data_069_47AA:: ; heuristic: map object screen array; C0
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
Data_069_47B6:: ; heuristic: start of a structured table; C0
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
Data_069_47E1:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $01, $35, $00, $00, $70, $10, $05, $00, $50, $0B
    db $86, $01, $31, $00, $00, $40, $A0, $06, $02, $60, $01
    db $87, $01, $32, $00, $00, $40, $B0, $07, $02, $70, $02

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4803::
Data_069_4803:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $01, $35, $00, $00, $70, $10, $05, $00, $50, $0B
    db $86, $01, $31, $00, $00, $60, $40, $06, $02, $60, $01
    db $87, $01, $32, $00, $00, $20, $70, $07, $00, $70, $02

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4825::
Data_069_4825:: ; heuristic: start of a structured table; C0
    db $02 ; entry 0
    db $85, $01, $35, $00, $00, $70, $10, $05, $00, $50, $0B
    db $86, $01, $31, $00, $00, $60, $40, $06, $02, $60, $01

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_483C::
Data_069_483C:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $01, $35, $00, $00, $70, $10, $05, $00, $50, $0B

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4848::
Data_069_4848:: ; heuristic: start of a structured table; C0
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
Data_069_486E:: ; heuristic: start of a structured table; C0
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
Data_069_4894:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $01, $37, $00, $00, $80, $40, $05, $00, $50, $03
    db $86, $01, $34, $00, $00, $20, $30, $06, $01, $60, $04
    db $87, $01, $31, $00, $02, $40, $60, $07, $00, $70, $05

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_48B6::
Data_069_48B6:: ; heuristic: map object screen array; C0
    dw ObjSelector_48BA ; id 0
    dw ObjSelector_4916 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_48BA:: ; heuristic: map object selector; C0
Data_069_48BA:: ; address name
    objsel_skip_if_clear $014B, $02, $00
    objsel_none
    INCBIN "dwm2-cobi-us.gbc", $1A48C2, $54

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4916:: ; heuristic: map object selector; C0
Data_069_4916:: ; address name
    objsel_skip_if_clear $0148, $02, $00
    objsel_none
    db $FC, $FF, $47, $01, $04, $00, $FE, $FF, $2E, $49, $40, $01, $2E, $49, $FF, $FF
    db $01, $85, $01, $32, $00, $00, $40, $30, $05, $02, $50, $02

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_493A::
Data_069_493A:: ; heuristic: map object screen array; C0
    dw ObjSelector_493C ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_493C:: ; heuristic: map object selector; C0
Data_069_493C:: ; address name
    objsel_list MapObjects_4940

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4940::
Data_069_4940:: ; heuristic: start of a structured table; C0
    db $02 ; entry 0
    db $85, $01, $37, $00, $00, $50, $40, $05, $00, $50, $0F
    db $86, $01, $38, $00, $00, $30, $20, $06, $03, $60, $10

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4957::
Data_069_4957:: ; heuristic: map object screen array; C0
    dw ObjSelector_4959 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4959:: ; heuristic: map object selector; C0
Data_069_4959:: ; address name
    objsel_skip_if_set $014C, $02, $00
    objsel_none
    INCBIN "dwm2-cobi-us.gbc", $1A4961, $4E

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_49AF::
Data_069_49AF:: ; heuristic: map object screen array; C0
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
Data_069_49BB:: ; heuristic: start of a structured table; C0
    db $02 ; entry 0
    db $85, $01, $5C, $00, $00, $40, $30, $05, $00, $50, $00
    db $86, $00, $DF, $00, $00, $40, $E0, $06, $00, $60, $00

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_49D2::
Data_069_49D2:: ; heuristic: map object screen array; C0
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
Data_069_49DC:: ; heuristic: start of a structured table; C0
    db $02 ; entry 0
    db $85, $01, $4A, $00, $00, $40, $E0, $05, $00, $50, $00
    db $86, $01, $48, $00, $05, $48, $30, $06, $00, $60, $01

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_49F3::
Data_069_49F3:: ; heuristic: map object screen array; C0
    dw ObjSelector_49F9 ; id 0
    dw ObjSelector_4A51 ; id 1
    dw ObjSelector_4A82 ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_49F9:: ; heuristic: map object selector; C0
Data_069_49F9:: ; address name
    objsel_skip_if_set $0025, $0A, $00
    objsel_skip_if_clear $00D1, $04, $00
    objsel_list MapObjects_4A24
    db $FE, $FF, $0D, $4A, $02, $85, $00, $6D, $00, $00, $70, $20, $05, $00, $50, $0B
    db $86, $00, $55, $01, $00, $20, $E0, $06, $00, $60, $00

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4A24::
Data_069_4A24:: ; heuristic: start of a structured table; C0
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
Data_069_4A55:: ; heuristic: start of a structured table; C0
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
Data_069_4A86:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $00, $6A, $00, $02, $30, $40, $05, $01, $50, $05
    db $86, $00, $51, $00, $00, $20, $60, $06, $02, $60, $04
    db $87, $00, $6A, $00, $00, $50, $30, $07, $00, $70, $06

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4AA8::
Data_069_4AA8:: ; heuristic: map object screen array; C0
    dw ObjSelector_4AAA ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4AAA:: ; heuristic: map object selector; C0
Data_069_4AAA:: ; address name
    objsel_list MapObjects_4AAE

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4AAE::
Data_069_4AAE:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $00, $77, $00, $00, $30, $10, $05, $00, $50, $00

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4ABA::
Data_069_4ABA:: ; heuristic: map object screen array; C0
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
Data_069_4AC8:: ; heuristic: start of a structured table; C0
    db $02 ; entry 0
    db $85, $00, $79, $00, $00, $6E, $EC, $05, $00, $50, $00
    db $86, $01, $5A, $00, $00, $40, $50, $06, $00, $60, $00

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4ADF::
Data_069_4ADF:: ; heuristic: map object screen array; C0
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
Data_069_4AED:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $00, $61, $00, $00, $40, $20, $05, $00, $50, $16

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4AF9::
Data_069_4AF9:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $00, $61, $00, $00, $50, $20, $05, $03, $50, $16

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4B05::
Data_069_4B05:: ; heuristic: map object screen array; C0
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
Data_069_4B11:: ; heuristic: start of a structured table; C0
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
Data_069_4B37:: ; heuristic: start of a structured table; C0
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
Data_069_4B5D:: ; heuristic: start of a structured table; C0
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
Data_069_4B8E:: ; heuristic: start of a structured table; C0
    db $04 ; entry 0
    db $85, $00, $5F, $00, $00, $10, $20, $05, $00, $50, $21
    db $86, $00, $80, $00, $02, $10, $60, $06, $03, $60, $22
    db $87, $00, $47, $00, $00, $40, $70, $07, $02, $70, $19
    db $84, $00, $49, $00, $00, $70, $30, $04, $00, $40, $18

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4BBB::
Data_069_4BBB:: ; heuristic: map object screen array; C0
    dw ObjSelector_4BBF ; id 0
    dw ObjSelector_4BCF ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4BBF:: ; heuristic: map object selector; C0
Data_069_4BBF:: ; address name
    objsel_list MapObjects_4BC3

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4BC3::
Data_069_4BC3:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $00, $0C, $00, $00, $50, $60, $05, $00, $50, $6B

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4BCF:: ; heuristic: map object selector; C0
Data_069_4BCF:: ; address name
    objsel_list MapObjects_4BD3

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4BD3::
Data_069_4BD3:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $00, $53, $00, $00, $70, $10, $05, $00, $50, $00
    db $86, $00, $5D, $00, $00, $30, $20, $06, $03, $60, $6C
    db $87, $00, $4E, $00, $00, $20, $30, $07, $02, $70, $6D

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4BF5::
Data_069_4BF5:: ; heuristic: map object screen array; C0
    dw ObjSelector_4BF9 ; id 0
    dw ObjSelector_4C50 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4BF9:: ; heuristic: map object selector; C0
Data_069_4BF9:: ; address name
    objsel_skip_if_clear $00C4, $04, $00
    objsel_list MapObjects_4C44
    INCBIN "dwm2-cobi-us.gbc", $1A4C03, $41

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4C44::
Data_069_4C44:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $00, $1F, $01, $00, $50, $40, $05, $00, $50, $2A

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4C50:: ; heuristic: map object selector; C0
Data_069_4C50:: ; address name
    objsel_list MapObjects_4C54

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4C54::
Data_069_4C54:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $00, $79, $00, $00, $00, $E0, $05, $00, $50, $00

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4C60::
Data_069_4C60:: ; heuristic: map object screen array; C0
    dw ObjSelector_4C68 ; id 0
    dw ObjSelector_4CCA ; id 1
    dw ObjSelector_4CFB ; id 2
    dw ObjSelector_4D2C ; id 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4C68:: ; heuristic: map object selector; C0
Data_069_4C68:: ; address name
    objsel_skip_if_clear $00B6, $04, $00
    objsel_list MapObjects_4CB3
    INCBIN "dwm2-cobi-us.gbc", $1A4C72, $41

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4CB3::
Data_069_4CB3:: ; heuristic: start of a structured table; C0
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
Data_069_4CCE:: ; heuristic: start of a structured table; C0
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
Data_069_4CFF:: ; heuristic: start of a structured table; C0
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
Data_069_4D34:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $00, $4E, $00, $00, $30, $70, $05, $00, $50, $2D
    db $86, $00, $4D, $00, $02, $70, $10, $06, $03, $60, $2E
    db $87, $00, $9B, $00, $00, $80, $40, $07, $02, $70, $2F

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4D56::
Data_069_4D56:: ; heuristic: start of a structured table; C0
    db $04 ; entry 0
    db $85, $00, $4E, $00, $00, $30, $70, $05, $00, $50, $2D
    db $86, $00, $4D, $00, $02, $70, $10, $06, $03, $60, $2E
    db $87, $00, $9B, $00, $00, $80, $40, $07, $02, $70, $2F
    db $84, $00, $57, $00, $00, $30, $50, $04, $00, $40, $37

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4D83::
Data_069_4D83:: ; heuristic: map object screen array; C0
    dw ObjSelector_4D85 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4D85:: ; heuristic: map object selector; C0
Data_069_4D85:: ; address name
    objsel_unless_flag $00A8, MapObjects_4D8D
    objsel_list MapObjects_4D99

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4D8D::
Data_069_4D8D:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $00, $56, $00, $00, $10, $10, $05, $01, $50, $3D

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4D99::
Data_069_4D99:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $00, $56, $00, $00, $10, $10, $05, $01, $50, $3F

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4DA5::
Data_069_4DA5:: ; heuristic: map object screen array; C0
    dw ObjSelector_4DA7 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4DA7:: ; heuristic: map object selector; C0
Data_069_4DA7:: ; address name
    objsel_unless_flag $00A8, MapObjects_4DAF
    objsel_list MapObjects_4DBB

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4DAF::
Data_069_4DAF:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $00, $80, $00, $00, $30, $10, $05, $00, $50, $43

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4DBB::
Data_069_4DBB:: ; heuristic: start of a structured table; C0
    db $04 ; entry 0
    db $85, $00, $80, $00, $00, $30, $10, $05, $00, $50, $43
    db $86, $00, $5A, $00, $00, $40, $40, $06, $02, $60, $44
    db $87, $00, $76, $00, $00, $50, $50, $07, $00, $70, $45
    db $87, $00, $76, $00, $00, $50, $70, $07, $02, $70, $46

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4DE8::
Data_069_4DE8:: ; heuristic: map object screen array; C0
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
Data_069_4DF4:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $00, $61, $00, $00, $50, $40, $05, $00, $50, $5A

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4E00::
Data_069_4E00:: ; heuristic: start of a structured table; C0
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
Data_069_4E14:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $00, $5A, $00, $00, $30, $30, $05, $01, $50, $57
    db $86, $00, $59, $00, $00, $70, $50, $06, $00, $60, $58
    db $87, $00, $57, $00, $00, $70, $70, $07, $02, $70, $59

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4E36::
Data_069_4E36:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $00, $5A, $00, $00, $30, $30, $05, $01, $50, $57

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4E42::
Data_069_4E42:: ; heuristic: map object screen array; C0
    dw ObjSelector_4E44 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4E44:: ; heuristic: map object selector; C0
Data_069_4E44:: ; address name
    objsel_unless_flag $00AE, MapObjects_4E4A
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4E4A::
Data_069_4E4A:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $00, $12, $00, $00, $40, $30, $05, $00, $50, $4A

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4E56::
Data_069_4E56:: ; heuristic: map object screen array; C0
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
Data_069_4E62:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $00, $5E, $00, $00, $80, $60, $05, $02, $50, $0A

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4E6E:: ; heuristic: map object selector; C0
Data_069_4E6E:: ; address name
    objsel_list MapObjects_4E72

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4E72::
Data_069_4E72:: ; heuristic: start of a structured table; C0
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
Data_069_4E8D:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $00, $50, $00, $00, $40, $60, $05, $02, $50, $08

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4E99::
Data_069_4E99:: ; heuristic: map object screen array; C0
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
Data_069_4EB1:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $00, $0A, $01, $00, $20, $20, $05, $00, $50, $4C

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4EBD::
Data_069_4EBD:: ; heuristic: map object screen array; C0
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
    db $FF, $FF

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4ED5::
Data_069_4ED5:: ; heuristic: start of a structured table; C0
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
Data_069_4EFB:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $01, $44, $00, $00, $30, $50, $05, $00, $50, $69

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4F07:: ; heuristic: map object selector; C0
Data_069_4F07:: ; address name
    objsel_list MapObjects_4F0B

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4F0B::
Data_069_4F0B:: ; heuristic: start of a structured table; C0
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
Data_069_4F31:: ; heuristic: start of a structured table; C0
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
Data_069_4F57:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $01, $44, $00, $00, $30, $30, $05, $01, $50, $69

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4F63:: ; heuristic: map object selector; C0
Data_069_4F63:: ; address name
    objsel_list MapObjects_4F67

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4F67::
Data_069_4F67:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $01, $44, $00, $00, $10, $30, $05, $02, $50, $69
    db $86, $01, $44, $00, $00, $20, $70, $06, $02, $60, $69
    db $87, $01, $44, $00, $00, $30, $40, $07, $01, $70, $69

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4F89::
Data_069_4F89:: ; heuristic: map object screen array; C0
    dw ObjSelector_4F8B ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4F8B:: ; heuristic: map object selector; C0
Data_069_4F8B:: ; address name
    objsel_unless_flag $00B1, MapObjects_4F91
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4F91::
Data_069_4F91:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $00, $F6, $00, $00, $40, $40, $05, $00, $50, $4F

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4F9D::
Data_069_4F9D:: ; heuristic: map object screen array; C0
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
Data_069_4FAF:: ; heuristic: start of a structured table; C0
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
Data_069_4FC1:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $00, $0A, $01, $00, $80, $50, $05, $03, $50, $6F

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4FCD::
Data_069_4FCD:: ; heuristic: map object screen array; C0
    dw ObjSelector_4FCF ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_4FCF:: ; heuristic: map object selector; C0
Data_069_4FCF:: ; address name
    objsel_unless_flag $00B4, MapObjects_4FD5
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_4FD5::
Data_069_4FD5:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $00, $10, $01, $00, $40, $30, $05, $00, $50, $55

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_4FE1::
Data_069_4FE1:: ; heuristic: map object screen array; C0
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
    db $B9, $00, $01, $50, $FF, $FF, $01, $85, $00, $EC, $00, $00, $40, $20, $05, $00
    db $50, $5C

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_500D:: ; heuristic: map object selector; C0
Data_069_500D:: ; address name
    objsel_skip_if_clear $0024, $02, $00
    objsel_none
    db $BA, $00, $1B, $50, $FF, $FF, $01, $85, $00, $EC, $00, $00, $40, $20, $05, $00
    db $50, $5C

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5027:: ; heuristic: map object selector; C0
Data_069_5027:: ; address name
    objsel_skip_if_clear $0024, $02, $00
    objsel_none
    db $BB, $00, $35, $50, $FF, $FF, $01, $85, $00, $EC, $00, $00, $40, $20, $05, $00
    db $50, $5C

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5041:: ; heuristic: map object selector; C0
Data_069_5041:: ; address name
    objsel_unless_flag $0024, MapObjects_5047
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5047::
Data_069_5047:: ; heuristic: start of a structured table; C0
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
Data_069_5059:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $00, $D6, $00, $00, $30, $40, $05, $03, $50, $60

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_5065::
Data_069_5065:: ; heuristic: map object screen array; C0
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
Data_069_5077:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $00, $D6, $00, $00, $80, $40, $05, $00, $50, $61

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_5083::
Data_069_5083:: ; heuristic: map object screen array; C0
    dw $0000 ; id 0
    dw ObjSelector_508B ; id 1
    dw $0000 ; id 2
    dw $0000 ; id 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_508B:: ; heuristic: map object selector; C0
Data_069_508B:: ; address name
    objsel_skip_if_clear $0024, $02, $00
    objsel_none
    db $01, $02, $99, $50, $FF, $FF, $01, $85, $00, $EC, $00, $00, $10, $40, $05, $01
    db $50, $5C

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_50A5::
Data_069_50A5:: ; heuristic: map object screen array; C0
    dw ObjSelector_50AB ; id 0
    dw ObjSelector_50DE ; id 1
    dw $0000 ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_50AB:: ; heuristic: map object selector; C0
Data_069_50AB:: ; address name
    objsel_skip_if_clear $00C3, $02, $00
    objsel_none
    db $C2, $00, $BB, $50, $FE, $FF, $D2, $50, $02, $85, $01, $03, $00, $00, $40, $20
    db $05, $00, $50, $5C, $86, $01, $48, $00, $05, $48, $C0, $06, $00, $60, $00, $01
    db $85, $01, $03, $00, $00, $50, $30, $05, $02, $50, $5C

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_50DE:: ; heuristic: map object selector; C0
Data_069_50DE:: ; address name
    objsel_unless_flag $00C1, MapObjects_50E4
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_50E4::
Data_069_50E4:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $01, $54, $00, $04, $48, $20, $05, $00, $50, $67

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_50F0::
Data_069_50F0:: ; heuristic: map object screen array; C0
    dw ObjSelector_50F2 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_50F2:: ; heuristic: map object selector; C0
Data_069_50F2:: ; address name
    objsel_skip_if_set $0025, $0A, $00
    objsel_skip_if_clear $00D1, $04, $00
    objsel_list MapObjects_519C
    INCBIN "dwm2-cobi-us.gbc", $1A5102, $9A

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 5 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_519C::
Data_069_519C:: ; heuristic: start of a structured table; C0
    db $05 ; entry 0
    db $85, $01, $53, $00, $00, $40, $E0, $05, $00, $50, $00
    db $86, $01, $3A, $00, $00, $40, $50, $06, $02, $60, $72
    db $87, $01, $42, $00, $00, $50, $70, $07, $03, $70, $2E
    db $83, $01, $52, $00, $00, $30, $B0, $03, $02, $30, $61
    db $83, $01, $52, $00, $00, $50, $B0, $03, $02, $30, $61

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_51D4::
Data_069_51D4:: ; heuristic: map object screen array; C0
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
Data_069_51E4:: ; heuristic: start of a structured table; C0
    db $04 ; entry 0
    db $85, $01, $10, $00, $00, $40, $10, $05, $00, $50, $0B
    db $85, $01, $10, $00, $00, $50, $10, $05, $00, $50, $0C
    db $86, $01, $2F, $00, $00, $10, $40, $06, $01, $60, $09
    db $87, $01, $30, $00, $00, $70, $70, $07, $02, $70, $0A

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5211::
Data_069_5211:: ; heuristic: start of a structured table; C0
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
Data_069_5242:: ; heuristic: start of a structured table; C0
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
Data_069_5268:: ; heuristic: start of a structured table; C0
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
Data_069_5299:: ; heuristic: start of a structured table; C0
    db $04 ; entry 0
    db $85, $01, $2F, $00, $02, $50, $50, $05, $01, $50, $04
    db $85, $01, $2F, $00, $00, $30, $40, $05, $03, $50, $07
    db $86, $01, $12, $00, $00, $80, $60, $06, $03, $60, $08
    db $87, $01, $15, $00, $00, $70, $20, $07, $00, $70, $0D

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_52C6::
Data_069_52C6:: ; heuristic: map object screen array; C0
    dw ObjSelector_52C8 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_52C8:: ; heuristic: map object selector; C0
Data_069_52C8:: ; address name
    objsel_unless_flag $0094, MapObjects_52D0
    objsel_list MapObjects_52E7

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_52D0::
Data_069_52D0:: ; heuristic: start of a structured table; C0
    db $02 ; entry 0
    db $85, $01, $2E, $00, $00, $60, $20, $05, $01, $50, $12
    db $86, $01, $15, $00, $00, $20, $50, $06, $01, $60, $13

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_52E7::
Data_069_52E7:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $01, $2E, $00, $00, $60, $20, $05, $01, $50, $12

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_52F3::
Data_069_52F3:: ; heuristic: map object screen array; C0
    dw ObjSelector_52FB ; id 0
    dw ObjSelector_537E ; id 1
    dw ObjSelector_538E ; id 2
    dw ObjSelector_53EF ; id 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_52FB:: ; heuristic: map object selector; C0
Data_069_52FB:: ; address name
    objsel_skip_if_clear $0094, $04, $00
    objsel_list MapObjects_5367
    INCBIN "dwm2-cobi-us.gbc", $1A5305, $62

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5367::
Data_069_5367:: ; heuristic: start of a structured table; C0
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
Data_069_5382:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $01, $12, $00, $00, $20, $20, $05, $02, $50, $17

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_538E:: ; heuristic: map object selector; C0
Data_069_538E:: ; address name
    objsel_skip_if_clear $0087, $04, $00
    objsel_list MapObjects_53D8
    db $FC, $FF, $82, $00, $04, $00, $FE, $FF, $AA, $53, $83, $00, $AA, $53, $FE, $FF
    db $C1, $53, $02, $85, $01, $10, $00, $00, $50, $00, $05, $00, $50, $15, $86, $01
    db $10, $00, $00, $40, $00, $06, $00, $60, $18, $02, $85, $01, $10, $00, $00, $50
    db $00, $05, $00, $50, $15, $86, $01, $10, $00, $00, $40, $E0, $06, $00, $60, $18

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_53D8::
Data_069_53D8:: ; heuristic: start of a structured table; C0
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
Data_069_53F3:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $01, $10, $00, $00, $80, $30, $05, $00, $50, $16

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_53FF::
Data_069_53FF:: ; heuristic: map object screen array; C0
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
Data_069_5409:: ; heuristic: start of a structured table; C0
    db $02 ; entry 0
    db $85, $01, $0E, $00, $00, $70, $30, $05, $00, $50, $48
    db $86, $01, $03, $00, $00, $30, $50, $06, $03, $60, $49

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_5420::
Data_069_5420:: ; heuristic: map object screen array; C0
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
Data_069_542A:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $01, $2E, $00, $00, $50, $30, $05, $00, $50, $1C

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_5436::
Data_069_5436:: ; heuristic: map object screen array; C0
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
Data_069_5442:: ; heuristic: start of a structured table; C0
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
Data_069_5477:: ; heuristic: start of a structured table; C0
    db $04 ; entry 0
    db $85, $01, $16, $00, $00, $10, $30, $05, $01, $50, $29
    db $86, $01, $15, $00, $00, $70, $20, $06, $00, $60, $2A
    db $86, $01, $15, $00, $00, $80, $40, $06, $03, $60, $2B
    db $87, $01, $29, $00, $00, $70, $50, $07, $01, $70, $28

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_54A4::
Data_069_54A4:: ; heuristic: start of a structured table; C0
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
Data_069_54CA:: ; heuristic: start of a structured table; C0
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
Data_069_54FB:: ; heuristic: start of a structured table; C0
    db $04 ; entry 0
    db $85, $01, $2E, $00, $00, $40, $50, $05, $00, $50, $1E
    db $86, $01, $30, $00, $00, $80, $20, $06, $03, $60, $25
    db $85, $01, $2E, $00, $00, $20, $30, $05, $00, $50, $26
    db $87, $01, $10, $00, $00, $20, $10, $07, $01, $70, $27

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_5528::
Data_069_5528:: ; heuristic: map object screen array; C0
    dw ObjSelector_552A ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_552A:: ; heuristic: map object selector; C0
Data_069_552A:: ; address name
    objsel_unless_flag $01E5, MapObjects_5532
    objsel_list MapObjects_555F

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5532::
Data_069_5532:: ; heuristic: start of a structured table; C0
    db $04 ; entry 0
    db $85, $01, $16, $00, $00, $20, $20, $05, $01, $50, $31
    db $85, $01, $16, $00, $00, $40, $30, $05, $02, $50, $32
    db $86, $01, $17, $00, $00, $40, $50, $06, $00, $60, $33
    db $87, $01, $21, $00, $00, $10, $60, $07, $00, $70, $34

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_555F::
Data_069_555F:: ; heuristic: start of a structured table; C0
    db $02 ; entry 0
    db $85, $01, $16, $00, $00, $20, $20, $05, $01, $50, $31
    db $86, $01, $17, $00, $00, $40, $50, $06, $00, $60, $33

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_5576::
Data_069_5576:: ; heuristic: map object screen array; C0
    dw ObjSelector_5578 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5578:: ; heuristic: map object selector; C0
Data_069_5578:: ; address name
    objsel_list MapObjects_557C

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_557C::
Data_069_557C:: ; heuristic: start of a structured table; C0
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
Data_069_559D:: ; heuristic: start of a structured table; C0
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
Data_069_55BC:: ; heuristic: start of a structured table; C0
    db $04 ; entry 0
    db $85, $01, $10, $00, $00, $30, $30, $05, $00, $50, $38
    db $85, $01, $10, $00, $00, $00, $40, $05, $01, $50, $39
    db $85, $01, $10, $00, $00, $00, $50, $05, $01, $50, $3A
    db $86, $01, $16, $00, $00, $70, $60, $06, $00, $60, $3B

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_55E9::
Data_069_55E9:: ; heuristic: start of a structured table; C0
    db $04 ; entry 0
    db $85, $01, $10, $00, $00, $30, $30, $05, $00, $50, $38
    db $85, $01, $10, $00, $00, $60, $40, $05, $00, $50, $39
    db $85, $01, $10, $00, $00, $60, $50, $05, $02, $50, $3A
    db $86, $01, $16, $00, $00, $70, $60, $06, $00, $60, $3B

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_5616::
Data_069_5616:: ; heuristic: map object screen array; C0
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
Data_069_563A:: ; heuristic: start of a structured table; C0
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
Data_069_564E:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $01, $52, $00, $00, $40, $60, $05, $02, $50, $3C
    db $86, $01, $52, $00, $00, $50, $60, $06, $02, $60, $3D
    db $87, $01, $16, $00, $02, $50, $20, $07, $01, $70, $3E

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5670::
Data_069_5670:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $01, $16, $00, $02, $50, $20, $05, $01, $50, $3E

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_567C::
Data_069_567C:: ; heuristic: map object screen array; C0
    dw ObjSelector_567E ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_567E:: ; heuristic: map object selector; C0
Data_069_567E:: ; address name
    objsel_list MapObjects_5682

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5682::
Data_069_5682:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $01, $52, $00, $00, $60, $30, $05, $00, $50, $40

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_568E::
Data_069_568E:: ; heuristic: map object screen array; C0
    dw $0000 ; id 0
    dw ObjSelector_5692 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5692:: ; heuristic: map object selector; C0
Data_069_5692:: ; address name
    objsel_list MapObjects_5696

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5696::
Data_069_5696:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $01, $16, $00, $00, $50, $50, $05, $03, $50, $41

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_56A2::
Data_069_56A2:: ; heuristic: map object screen array; C0
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
Data_069_56AE:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $01, $16, $00, $02, $60, $10, $05, $01, $50, $44

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_56BA:: ; heuristic: map object selector; C0
Data_069_56BA:: ; address name
    objsel_skip_if_clear $0086, $02, $00
    objsel_none
    INCBIN "dwm2-cobi-us.gbc", $1A56C2, $4C

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_570E:: ; heuristic: map object selector; C0
Data_069_570E:: ; address name
    objsel_unless_flag $0086, MapObjects_5714
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5714::
Data_069_5714:: ; heuristic: start of a structured table; C0
    db $02 ; entry 0
    db $85, $01, $16, $00, $02, $30, $10, $05, $01, $50, $42
    db $86, $01, $10, $00, $00, $70, $30, $06, $02, $60, $43

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_572B::
Data_069_572B:: ; heuristic: map object screen array; C0
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
Data_069_5737:: ; heuristic: start of a structured table; C0
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
Data_069_5768:: ; heuristic: start of a structured table; C0
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
Data_069_5799:: ; heuristic: start of a structured table; C0
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
Data_069_57CA:: ; heuristic: start of a structured table; C0
    db $02 ; entry 0
    db $85, $01, $2D, $00, $00, $30, $50, $05, $00, $50, $59
    db $86, $01, $30, $00, $02, $60, $40, $06, $01, $60, $5A

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_57E1::
Data_069_57E1:: ; heuristic: map object screen array; C0
    dw ObjSelector_57E5 ; id 0
    dw ObjSelector_5800 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_57E5:: ; heuristic: map object selector; C0
Data_069_57E5:: ; address name
    objsel_list MapObjects_57E9

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_57E9::
Data_069_57E9:: ; heuristic: start of a structured table; C0
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
Data_069_5804:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $01, $29, $00, $00, $20, $20, $05, $00, $50, $60

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_5810::
Data_069_5810:: ; heuristic: map object screen array; C0
    dw ObjSelector_5814 ; id 0
    dw ObjSelector_585D ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5814:: ; heuristic: map object selector; C0
Data_069_5814:: ; address name
    objsel_skip_if_clear $01E5, $04, $00
    objsel_list MapObjects_5851
    db $96, $00, $24, $58, $FF, $FF, $04, $85, $01, $52, $00, $00, $80, $60, $05, $00
    db $50, $61, $85, $01, $52, $00, $00, $40, $50, $05, $00, $50, $67, $86, $01, $15
    db $00, $02, $20, $70, $06, $01, $60, $63, $87, $01, $4C, $00, $00, $60, $80, $07
    db $02, $70, $65

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5851::
Data_069_5851:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $87, $01, $42, $00, $00, $30, $50, $07, $00, $70, $2E

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_585D:: ; heuristic: map object selector; C0
Data_069_585D:: ; address name
    objsel_skip_if_clear $0096, $04, $00
    objsel_list MapObjects_58A8
    INCBIN "dwm2-cobi-us.gbc", $1A5867, $41

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_58A8::
Data_069_58A8:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $01, $52, $00, $00, $20, $50, $05, $00, $50, $66
    db $86, $01, $52, $00, $00, $70, $60, $06, $03, $60, $61
    db $87, $01, $52, $00, $00, $10, $70, $07, $00, $70, $67

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_58CA::
Data_069_58CA:: ; heuristic: map object screen array; C0
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
Data_069_58D6:: ; heuristic: start of a structured table; C0
    db $02 ; entry 0
    db $85, $01, $52, $00, $00, $70, $40, $05, $00, $50, $6E
    db $86, $01, $14, $00, $00, $20, $10, $06, $02, $60, $6B

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_58ED:: ; heuristic: map object selector; C0
Data_069_58ED:: ; address name
    objsel_skip_if_clear $009B, $04, $00
    objsel_list MapObjects_5938
    INCBIN "dwm2-cobi-us.gbc", $1A58F7, $41

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5938::
Data_069_5938:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $01, $0E, $00, $00, $40, $20, $05, $00, $50, $71

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5944:: ; heuristic: map object selector; C0
Data_069_5944:: ; address name
    objsel_list MapObjects_5948

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5948::
Data_069_5948:: ; heuristic: start of a structured table; C0
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
Data_069_5967:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $01, $12, $00, $00, $40, $10, $05, $00, $50, $6F
    db $86, $01, $52, $00, $00, $50, $10, $06, $00, $60, $69
    db $87, $01, $52, $00, $02, $60, $40, $07, $01, $70, $6D

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5989::
Data_069_5989:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $01, $12, $00, $00, $30, $30, $05, $00, $50, $6F
    db $86, $01, $52, $00, $00, $60, $20, $06, $00, $60, $69
    db $87, $01, $52, $00, $02, $60, $40, $07, $01, $70, $6D

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_59AB::
Data_069_59AB:: ; heuristic: map object screen array; C0
    dw $0000 ; id 0
    dw ObjSelector_59AF ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_59AF:: ; heuristic: map object selector; C0
Data_069_59AF:: ; address name
    objsel_skip_if_clear $009D, $04, $00
    objsel_list MapObjects_59FA
    INCBIN "dwm2-cobi-us.gbc", $1A59B9, $41

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_59FA::
Data_069_59FA:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $01, $3A, $00, $00, $60, $30, $05, $03, $50, $72

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_5A06::
Data_069_5A06:: ; heuristic: map object screen array; C0
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
Data_069_5A2E:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $01, $2E, $00, $00, $30, $50, $05, $01, $50, $92
    db $86, $01, $2F, $00, $02, $60, $30, $06, $01, $60, $93
    db $87, $01, $42, $00, $02, $50, $60, $07, $01, $70, $2E

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5A50::
Data_069_5A50:: ; heuristic: start of a structured table; C0
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
Data_069_5A79:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $01, $3A, $00, $00, $50, $40, $05, $02, $50, $99

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_5A85::
Data_069_5A85:: ; heuristic: map object screen array; C0
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
Data_069_5A95:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $01, $2F, $00, $00, $60, $50, $05, $00, $50, $78
    db $86, $01, $2F, $00, $00, $40, $20, $06, $00, $60, $7E
    db $87, $01, $14, $00, $00, $80, $30, $07, $03, $70, $7F

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5AB7::
Data_069_5AB7:: ; heuristic: start of a structured table; C0
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
Data_069_5AEC:: ; heuristic: start of a structured table; C0
    db $04 ; entry 0
    db $85, $01, $10, $00, $00, $40, $10, $05, $00, $50, $7C
    db $85, $01, $10, $00, $00, $50, $10, $05, $00, $50, $7C
    db $86, $01, $2E, $00, $00, $70, $70, $06, $03, $60, $79
    db $87, $01, $2D, $00, $02, $60, $40, $07, $01, $70, $77

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5B19::
Data_069_5B19:: ; heuristic: start of a structured table; C0
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
Data_069_5B4A:: ; heuristic: start of a structured table; C0
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
Data_069_5B7B:: ; heuristic: start of a structured table; C0
    db $04 ; entry 0
    db $85, $01, $30, $00, $00, $60, $60, $05, $00, $50, $73
    db $86, $01, $2F, $00, $00, $20, $50, $06, $03, $60, $7A
    db $86, $01, $2F, $00, $00, $50, $30, $06, $00, $60, $7B
    db $87, $01, $15, $00, $00, $80, $20, $07, $03, $70, $7D

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_5BA8::
Data_069_5BA8:: ; heuristic: map object screen array; C0
    dw ObjSelector_5BAA ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5BAA:: ; heuristic: map object selector; C0
Data_069_5BAA:: ; address name
    objsel_unless_flag $01E5, MapObjects_5BB2
    objsel_list MapObjects_5BDF

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5BB2::
Data_069_5BB2:: ; heuristic: start of a structured table; C0
    db $04 ; entry 0
    db $85, $01, $2E, $00, $00, $40, $60, $05, $02, $50, $86
    db $86, $01, $15, $00, $00, $20, $20, $06, $00, $60, $87
    db $85, $01, $2E, $00, $00, $50, $40, $05, $03, $50, $88
    db $87, $01, $29, $00, $00, $10, $70, $07, $01, $70, $89

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5BDF::
Data_069_5BDF:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $01, $2E, $00, $00, $40, $60, $05, $02, $50, $86
    db $86, $01, $2E, $00, $00, $50, $40, $06, $03, $60, $88
    db $87, $01, $29, $00, $00, $10, $70, $07, $01, $70, $89

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_5C01::
Data_069_5C01:: ; heuristic: map object screen array; C0
    dw ObjSelector_5C07 ; id 0
    dw ObjSelector_5C71 ; id 1
    dw ObjSelector_5CB2 ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5C07:: ; heuristic: map object selector; C0
Data_069_5C07:: ; address name
    objsel_skip_if_set $0025, $0A, $00
    objsel_skip_if_clear $00D1, $04, $00
    objsel_list MapObjects_5C39
    db $FC, $FF, $E5, $01, $04, $00, $FE, $FF, $2D, $5C, $FC, $FF, $9D, $00, $02, $00
    db $FF, $FF, $FE, $FF, $2D, $5C, $01, $85, $01, $0F, $00, $00, $40, $10, $05, $00
    db $50, $90

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 5 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5C39::
Data_069_5C39:: ; heuristic: start of a structured table; C0
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
Data_069_5C79:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $01, $10, $00, $00, $30, $10, $05, $01, $50, $8E
    db $86, $01, $12, $00, $00, $20, $50, $06, $02, $60, $8F
    db $87, $01, $2A, $00, $00, $60, $60, $07, $03, $70, $8D

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5C9B::
Data_069_5C9B:: ; heuristic: start of a structured table; C0
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
Data_069_5CB6:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $01, $10, $00, $00, $30, $10, $05, $00, $50, $8A
    db $86, $01, $10, $00, $02, $50, $40, $06, $01, $60, $8B
    db $87, $01, $12, $00, $00, $20, $50, $07, $00, $70, $8C

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_5CD8::
Data_069_5CD8:: ; heuristic: map object screen array; C0
    dw ObjSelector_5CDC ; id 0
    dw ObjSelector_5D8B ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5CDC:: ; heuristic: map object selector; C0
Data_069_5CDC:: ; address name
    objsel_skip_if_clear $01E5, $04, $00
    objsel_list MapObjects_5D7F
    INCBIN "dwm2-cobi-us.gbc", $1A5CE6, $99

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5D7F::
Data_069_5D7F:: ; heuristic: start of a structured table; C0
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
Data_069_5D91:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $01, $2A, $00, $00, $70, $60, $05, $03, $50, $8D

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_5D9D::
Data_069_5D9D:: ; heuristic: map object screen array; C0
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
    db $F4, $00, $2B, $5E, $FF, $FF, $01, $85, $00, $53, $01, $00, $50, $50, $05, $00
    db $50, $6C

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5E37:: ; heuristic: map object selector; C0
Data_069_5E37:: ; address name
    objsel_skip_if_clear $0076, $02, $00
    objsel_none
    db $FB, $FF, $70, $00, $02, $00, $FF, $FF, $FE, $FF, $4B, $5E, $01, $85, $01, $55
    db $00, $02, $40, $40, $05, $00, $50, $46

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_5E57::
Data_069_5E57:: ; heuristic: map object screen array; C0
    dw ObjSelector_5E5B ; id 0
    dw ObjSelector_5E8C ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5E5B:: ; heuristic: map object selector; C0
Data_069_5E5B:: ; address name
    objsel_list MapObjects_5E5F

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5E5F::
Data_069_5E5F:: ; heuristic: start of a structured table; C0
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
Data_069_5E90:: ; heuristic: start of a structured table; C0
    db $04 ; entry 0
    db $85, $01, $08, $00, $00, $60, $60, $05, $00, $50, $00
    db $86, $01, $09, $00, $00, $80, $40, $06, $03, $60, $01
    db $85, $01, $08, $00, $02, $30, $50, $05, $01, $50, $02
    db $87, $01, $15, $00, $00, $10, $30, $07, $01, $70, $07

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_5EBD::
Data_069_5EBD:: ; heuristic: map object screen array; C0
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
Data_069_5EC9:: ; heuristic: start of a structured table; C0
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
Data_069_5EFA:: ; heuristic: start of a structured table; C0
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
Data_069_5F20:: ; heuristic: start of a structured table; C0
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
Data_069_5F51:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $01, $0C, $00, $00, $70, $60, $05, $00, $50, $25
    db $86, $01, $09, $00, $00, $60, $30, $06, $00, $60, $26
    db $87, $01, $16, $00, $02, $20, $40, $07, $01, $70, $27

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_5F73::
Data_069_5F73:: ; heuristic: map object screen array; C0
    dw ObjSelector_5F77 ; id 0
    dw ObjSelector_5FE5 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_5F77:: ; heuristic: map object selector; C0
Data_069_5F77:: ; address name
    objsel_skip_if_set $0025, $0A, $00
    objsel_skip_if_clear $00D1, $04, $00
    objsel_list MapObjects_5FB8
    db $FE, $FF, $8B, $5F, $04, $85, $01, $16, $00, $00, $50, $30, $05, $00, $50, $30
    db $86, $01, $29, $00, $00, $70, $50, $06, $00, $60, $31, $86, $01, $29, $00, $00
    db $70, $60, $06, $02, $60, $32, $87, $01, $0C, $00, $00, $20, $40, $07, $01, $70
    db $33

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_5FB8::
Data_069_5FB8:: ; heuristic: start of a structured table; C0
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
Data_069_5FED:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $01, $03, $00, $00, $40, $E0, $05, $00, $50, $00
    db $86, $01, $28, $00, $00, $30, $D0, $06, $00, $60, $00
    db $87, $01, $29, $00, $00, $50, $D0, $07, $00, $70, $00

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_600F::
Data_069_600F:: ; heuristic: start of a structured table; C0
    db $02 ; entry 0
    db $85, $01, $0A, $00, $00, $60, $10, $05, $00, $50, $3B
    db $86, $01, $29, $00, $00, $60, $30, $06, $02, $60, $3C

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_6026::
Data_069_6026:: ; heuristic: map object screen array; C0
    dw ObjSelector_6028 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6028:: ; heuristic: map object selector; C0
Data_069_6028:: ; address name
    objsel_list MapObjects_602C

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_602C::
Data_069_602C:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $01, $0A, $00, $00, $30, $10, $05, $00, $50, $2C
    db $86, $01, $16, $00, $00, $20, $50, $06, $00, $60, $2D
    db $87, $01, $29, $00, $00, $20, $70, $07, $02, $70, $2E

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_604E::
Data_069_604E:: ; heuristic: map object screen array; C0
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
Data_069_6074:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $00, $4F, $01, $00, $40, $30, $05, $03, $50, $34

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_6080::
Data_069_6080:: ; heuristic: map object screen array; C0
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
Data_069_608C:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $01, $44, $00, $00, $70, $10, $05, $00, $50, $47

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6098:: ; heuristic: map object selector; C0
Data_069_6098:: ; address name
    objsel_list MapObjects_609C

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_609C::
Data_069_609C:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $01, $56, $00, $00, $70, $60, $05, $00, $50, $4D

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_60A8::
Data_069_60A8:: ; heuristic: map object screen array; C0
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
Data_069_60CE:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $01, $03, $00, $00, $50, $A0, $05, $02, $50, $00
    db $86, $01, $28, $00, $00, $50, $B0, $06, $02, $60, $00
    db $87, $01, $29, $00, $00, $50, $C0, $07, $02, $70, $00

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_60F0::
Data_069_60F0:: ; heuristic: map object screen array; C0
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
    INCBIN "dwm2-cobi-us.gbc", $1A6110, $4C

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_615C::
Data_069_615C:: ; heuristic: map object screen array; C0
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
Data_069_6174:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $01, $03, $00, $00, $60, $A0, $05, $02, $50, $00
    db $86, $01, $28, $00, $00, $60, $B0, $06, $02, $60, $00
    db $87, $01, $29, $00, $00, $60, $C0, $07, $02, $70, $00

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_6196::
Data_069_6196:: ; heuristic: map object screen array; C0
    dw ObjSelector_6198 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6198:: ; heuristic: map object selector; C0
Data_069_6198:: ; address name
    objsel_skip_if_clear $005F, $02, $00
    objsel_none
    INCBIN "dwm2-cobi-us.gbc", $1A61A0, $4C

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_61EC::
Data_069_61EC:: ; heuristic: map object screen array; C0
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
Data_069_61FA:: ; heuristic: start of a structured table; C0
    db $02 ; entry 0
    db $85, $01, $13, $00, $00, $60, $20, $05, $00, $50, $13
    db $86, $01, $4E, $00, $00, $E0, $40, $06, $00, $60, $3D

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6211::
Data_069_6211:: ; heuristic: start of a structured table; C0
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
Data_069_622C:: ; heuristic: start of a structured table; C0
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
Data_069_625D:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $01, $13, $00, $00, $70, $20, $05, $00, $50, $15
    db $86, $01, $07, $00, $00, $20, $10, $06, $00, $60, $12
    db $87, $01, $0C, $00, $00, $80, $60, $07, $03, $70, $10

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_627F::
Data_069_627F:: ; heuristic: map object screen array; C0
    dw ObjSelector_6281 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6281:: ; heuristic: map object selector; C0
Data_069_6281:: ; address name
    objsel_list MapObjects_6285

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6285::
Data_069_6285:: ; heuristic: start of a structured table; C0
    db $02 ; entry 0
    db $85, $01, $0A, $00, $00, $70, $10, $05, $00, $50, $14
    db $86, $01, $12, $00, $00, $40, $10, $06, $00, $60, $6D

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_629C::
Data_069_629C:: ; heuristic: map object screen array; C0
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
Data_069_62A8:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $01, $58, $00, $00, $E0, $18, $05, $00, $50, $00

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_62B4::
Data_069_62B4:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $01, $58, $00, $00, $48, $18, $05, $00, $50, $00

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_62C0::
Data_069_62C0:: ; heuristic: map object screen array; C0
    dw ObjSelector_62C4 ; id 0
    dw ObjSelector_633D ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_62C4:: ; heuristic: map object selector; C0
Data_069_62C4:: ; address name
    objsel_skip_if_set $0025, $0A, $00
    objsel_skip_if_clear $00D1, $04, $00
    objsel_list MapObjects_6305
    db $FE, $FF, $D8, $62, $04, $85, $01, $4F, $00, $00, $40, $20, $05, $00, $50, $45
    db $86, $01, $2C, $00, $02, $50, $40, $06, $01, $60, $43, $86, $01, $2C, $00, $00
    db $30, $60, $06, $00, $60, $44, $86, $01, $2C, $00, $00, $70, $70, $06, $00, $60
    db $42

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 5 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6305::
Data_069_6305:: ; heuristic: start of a structured table; C0
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
Data_069_6341:: ; heuristic: start of a structured table; C0
    db $04 ; entry 0
    db $85, $01, $2C, $00, $00, $60, $30, $05, $01, $50, $3E
    db $86, $01, $2C, $00, $00, $40, $70, $06, $01, $60, $3F
    db $85, $01, $2C, $00, $00, $50, $70, $05, $03, $50, $40
    db $85, $01, $2C, $00, $00, $20, $40, $05, $00, $50, $41

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_636E::
Data_069_636E:: ; heuristic: map object screen array; C0
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
Data_069_637A:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $01, $44, $00, $00, $80, $60, $05, $00, $50, $48

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_6386::
Data_069_6386:: ; heuristic: map object screen array; C0
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
Data_069_6392:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $01, $44, $00, $00, $60, $30, $05, $00, $50, $49

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_639E::
Data_069_639E:: ; heuristic: map object screen array; C0
    dw ObjSelector_63A0 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_63A0:: ; heuristic: map object selector; C0
Data_069_63A0:: ; address name
    objsel_unless_flag $0075, MapObjects_63A6
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_63A6::
Data_069_63A6:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $00, $06, $01, $00, $60, $20, $05, $00, $50, $4A

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_63B2::
Data_069_63B2:: ; heuristic: map object screen array; C0
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
Data_069_63D6:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $01, $1A, $00, $00, $40, $00, $05, $00, $50, $0A
    db $86, $01, $03, $00, $00, $40, $60, $06, $00, $60, $18
    db $87, $01, $02, $00, $00, $50, $60, $07, $00, $70, $17

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_63F8::
Data_069_63F8:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $01, $1A, $00, $00, $40, $00, $05, $00, $50, $0A

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6404::
Data_069_6404:: ; heuristic: start of a structured table; C0
    db $02 ; entry 0
    db $85, $01, $1A, $00, $00, $20, $10, $05, $00, $50, $0A
    db $86, $01, $10, $00, $00, $40, $E0, $06, $00, $60, $00

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_641B:: ; heuristic: map object selector; C0
Data_069_641B:: ; address name
    objsel_skip_if_clear $0023, $04, $00
    objsel_list MapObjects_645B
    db $91, $01, $2D, $64, $FE, $FF, $44, $64, $02, $85, $01, $04, $00, $00, $60, $30
    db $05, $01, $50, $07, $86, $00, $5A, $00, $00, $60, $E0, $06, $00, $60, $4B, $02
    db $85, $01, $04, $00, $00, $60, $30, $05, $01, $50, $07, $86, $00, $5A, $00, $00
    db $60, $20, $06, $00, $60, $4B

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_645B::
Data_069_645B:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $01, $04, $00, $00, $50, $30, $05, $01, $50, $07
    db $86, $00, $5A, $00, $00, $60, $20, $06, $00, $60, $4B
    db $87, $00, $01, $01, $00, $30, $60, $07, $00, $70, $7C

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_647D:: ; heuristic: map object selector; C0
Data_069_647D:: ; address name
    objsel_skip_if_clear $0024, $04, $00
    objsel_list MapObjects_649F
    db $FC, $FF, $03, $00, $04, $00, $02, $00, $93, $64, $FF, $FF, $01, $85, $00, $0A
    db $00, $00, $80, $40, $05, $00, $50, $08

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_649F::
Data_069_649F:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $00, $F0, $00, $00, $80, $30, $05, $00, $50, $98

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_64AB:: ; heuristic: map object selector; C0
Data_069_64AB:: ; address name
    objsel_skip_if_clear $0025, $08, $00
    objsel_unless_flag $0000, MapObjects_655F
    objsel_list MapObjects_653D
    INCBIN "dwm2-cobi-us.gbc", $1A64B9, $84

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_653D::
Data_069_653D:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $01, $00, $00, $00, $60, $30, $05, $00, $50, $1B
    db $86, $00, $01, $00, $02, $50, $50, $06, $01, $60, $1A
    db $84, $00, $24, $00, $00, $70, $60, $04, $03, $40, $B2

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_655F::
Data_069_655F:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $01, $01, $00, $00, $60, $30, $05, $00, $50, $1C
    db $86, $00, $01, $00, $02, $50, $50, $06, $03, $60, $1A
    db $84, $00, $24, $00, $00, $70, $60, $04, $03, $40, $B2
    db $02, $85, $01, $00, $00, $00, $60, $30, $05, $00, $50, $1B, $86, $00, $24, $00
    db $00, $70, $60, $06, $03, $60, $B2, $02, $85, $01, $01, $00, $00, $60, $30, $05
    db $00, $50, $1C, $86, $00, $24, $00, $00, $70, $60, $06, $03, $60, $B2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_65AF:: ; heuristic: map object selector; C0
Data_069_65AF:: ; address name
    objsel_skip_if_clear $0023, $04, $00
    objsel_list MapObjects_660D
    INCBIN "dwm2-cobi-us.gbc", $1A65B9, $54

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_660D::
Data_069_660D:: ; heuristic: start of a structured table; C0
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
Data_069_6633:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $86, $00, $91, $00, $00, $30, $30, $06, $01, $60, $04

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_663F:: ; heuristic: map object selector; C0
Data_069_663F:: ; address name
    objsel_skip_if_clear $0023, $04, $00
    objsel_list MapObjects_669B
    INCBIN "dwm2-cobi-us.gbc", $1A6649, $52

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_669B::
Data_069_669B:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $00, $B9, $00, $02, $40, $20, $05, $01, $50, $09
    db $86, $00, $F6, $00, $00, $60, $40, $06, $00, $60, $B4
    db $87, $00, $B1, $00, $00, $70, $30, $07, $00, $70, $D4

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_66BD:: ; heuristic: map object selector; C0
Data_069_66BD:: ; address name
    objsel_skip_if_clear $0023, $04, $00
    objsel_list MapObjects_6700
    db $FC, $FF, $22, $00, $04, $00, $FE, $FF, $E9, $66, $FC, $FF, $21, $00, $04, $00
    db $FE, $FF, $DD, $66, $FF, $FF, $01, $85, $00, $3D, $00, $00, $40, $10, $05, $01
    db $50, $7D, $02, $85, $00, $3D, $00, $00, $40, $10, $05, $01, $50, $7D, $86, $00
    db $2E, $00, $00, $20, $30, $06, $00, $60, $7E

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6700::
Data_069_6700:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $00, $3D, $00, $00, $40, $10, $05, $01, $50, $7D
    db $86, $00, $2E, $00, $00, $20, $30, $06, $00, $60, $7E
    db $87, $00, $F8, $00, $00, $10, $40, $07, $00, $70, $D5

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_6722::
Data_069_6722:: ; heuristic: map object screen array; C0
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
Data_069_673E:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $01, $11, $00, $00, $20, $60, $05, $01, $50, $80

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_674A:: ; heuristic: map object selector; C0
Data_069_674A:: ; address name
    objsel_list MapObjects_674E

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_674E::
Data_069_674E:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $01, $1A, $00, $00, $80, $40, $05, $01, $50, $DA

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_675A:: ; heuristic: map object selector; C0
Data_069_675A:: ; address name
    objsel_list MapObjects_675E

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_675E::
Data_069_675E:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $01, $19, $00, $00, $20, $60, $05, $01, $50, $22

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_676A:: ; heuristic: map object selector; C0
Data_069_676A:: ; address name
    objsel_skip_if_clear $0117, $02, $00
    objsel_none
    db $07, $01, $7A, $67, $FE, $FF, $91, $67, $02, $85, $01, $10, $00, $00, $50, $20
    db $05, $00, $50, $20, $86, $01, $18, $00, $00, $70, $70, $06, $03, $60, $21, $01
    db $85, $01, $10, $00, $00, $50, $20, $05, $00, $50, $20

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_679D:: ; heuristic: map object selector; C0
Data_069_679D:: ; address name
    objsel_unless_flag $0022, MapObjects_67A3
    objsel_none

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_67A3::
Data_069_67A3:: ; heuristic: start of a structured table; C0
    db $02 ; entry 0
    db $85, $01, $15, $00, $00, $50, $60, $05, $02, $50, $B7
    db $86, $01, $12, $00, $00, $50, $70, $06, $02, $60, $B8

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_67BA:: ; heuristic: map object selector; C0
Data_069_67BA:: ; address name
    objsel_skip_if_set $0002, $02, $00
    objsel_none
    db $FE, $FF, $C6, $67, $01, $85, $01, $1A, $00, $00, $40, $60, $05, $00, $50, $EA

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_67D2:: ; heuristic: map object selector; C0
Data_069_67D2:: ; address name
    objsel_unless_flag $0007, MapObjects_67DE
    objsel_unless_flag $000A, MapObjects_67F5
    objsel_list MapObjects_67DE

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_67DE::
Data_069_67DE:: ; heuristic: start of a structured table; C0
    db $02 ; entry 0
    db $85, $01, $1B, $00, $00, $60, $70, $05, $03, $50, $12
    db $86, $01, $10, $00, $00, $20, $50, $06, $00, $60, $0B

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_67F5::
Data_069_67F5:: ; heuristic: start of a structured table; C0
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
    db $FC, $FF, $24, $00, $02, $00, $FF, $FF, $21, $00, $44, $68, $FB, $FF, $07, $01
    db $02, $00, $FF, $FF, $FE, $FF, $5B, $68, $02, $85, $01, $1D, $00, $00, $20, $40
    db $05, $00, $50, $15, $86, $01, $10, $00, $00, $50, $40, $06, $00, $60, $20

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_685B::
Data_069_685B:: ; heuristic: start of a structured table; C0
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
Data_069_687F:: ; heuristic: start of a structured table; C0
    db $02 ; entry 0
    db $85, $01, $1C, $00, $00, $50, $00, $05, $00, $50, $0C
    db $86, $01, $1D, $00, $00, $50, $60, $06, $00, $60, $16

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6896::
Data_069_6896:: ; heuristic: start of a structured table; C0
    db $04 ; entry 0
    db $85, $01, $1C, $00, $00, $50, $00, $05, $00, $50, $0C
    db $86, $01, $03, $00, $00, $30, $60, $06, $03, $60, $18
    db $87, $01, $02, $00, $00, $30, $50, $07, $03, $70, $17
    db $83, $01, $1D, $00, $00, $50, $60, $03, $00, $30, $16

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_68C3::
Data_069_68C3:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $01, $1C, $00, $00, $40, $30, $05, $00, $50, $0C
    db $86, $01, $08, $00, $02, $E0, $E0, $06, $01, $60, $B9
    db $84, $01, $10, $00, $00, $E0, $50, $04, $03, $40, $00

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_68E5::
Data_069_68E5:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $01, $1C, $00, $00, $50, $60, $05, $00, $50, $0C

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_68F1::
Data_069_68F1:: ; heuristic: start of a structured table; C0
    db $02 ; entry 0
    db $85, $01, $1C, $00, $00, $40, $30, $05, $00, $50, $0C
    db $86, $01, $08, $00, $02, $30, $40, $06, $01, $60, $B9

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6908:: ; heuristic: map object selector; C0
Data_069_6908:: ; address name
    objsel_skip_if_clear $0025, $04, $00
    objsel_list MapObjects_692E
    db $FC, $FF, $24, $00, $02, $00, $FF, $FF, $21, $00, $22, $69, $FE, $FF, $2E, $69
    db $01, $85, $01, $1B, $00, $02, $40, $40, $05, $01, $50, $14

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_692E::
Data_069_692E:: ; heuristic: start of a structured table; C0
    db $02 ; entry 0
    db $85, $01, $1A, $00, $00, $30, $60, $05, $00, $50, $1E
    db $86, $01, $10, $00, $00, $20, $40, $06, $01, $60, $EB

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_6945::
Data_069_6945:: ; heuristic: map object screen array; C0
    dw ObjSelector_694B ; id 0
    dw ObjSelector_6A33 ; id 1
    dw ObjSelector_6A74 ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_694B:: ; heuristic: map object selector; C0
Data_069_694B:: ; address name
    objsel_skip_if_clear $0134, $08, $00
    objsel_unless_flag $0023, MapObjects_69D9
    objsel_list MapObjects_6A06
    INCBIN "dwm2-cobi-us.gbc", $1A6959, $80

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_69D9::
Data_069_69D9:: ; heuristic: start of a structured table; C0
    db $04 ; entry 0
    db $85, $01, $15, $00, $00, $60, $50, $05, $02, $50, $10
    db $85, $01, $15, $00, $00, $20, $50, $05, $03, $50, $7F
    db $86, $01, $57, $00, $00, $80, $60, $06, $02, $60, $00
    db $87, $00, $B9, $00, $02, $40, $40, $07, $01, $70, $CD

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6A06::
Data_069_6A06:: ; heuristic: start of a structured table; C0
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
Data_069_6A3B:: ; heuristic: start of a structured table; C0
    db $02 ; entry 0
    db $85, $01, $15, $00, $00, $40, $10, $05, $00, $50, $11
    db $86, $01, $1C, $00, $00, $10, $50, $06, $00, $60, $AA

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6A52::
Data_069_6A52:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $01, $15, $00, $00, $40, $10, $05, $00, $50, $11
    db $86, $01, $1D, $00, $02, $50, $30, $06, $03, $60, $0F
    db $87, $01, $1C, $00, $00, $10, $50, $07, $00, $70, $AA

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6A74:: ; heuristic: map object selector; C0
Data_069_6A74:: ; address name
    objsel_skip_if_clear $0025, $04, $00
    objsel_list MapObjects_6AC2
    INCBIN "dwm2-cobi-us.gbc", $1A6A7E, $44

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6AC2::
Data_069_6AC2:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $01, $1D, $00, $00, $40, $40, $05, $00, $50, $0E
    db $86, $01, $1D, $00, $00, $20, $50, $06, $00, $60, $15
    db $84, $01, $1D, $00, $00, $20, $60, $04, $02, $40, $16
    db $02, $85, $01, $1D, $00, $00, $40, $30, $05, $00, $50, $15, $86, $01, $1D, $00
    db $00, $40, $40, $06, $02, $60, $16

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_6AFB::
Data_069_6AFB:: ; heuristic: map object screen array; C0
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
Data_069_6B05:: ; heuristic: start of a structured table; C0
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
Data_069_6B2B:: ; heuristic: start of a structured table; C0
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
    INCBIN "dwm2-cobi-us.gbc", $1A6B54, $78

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6BCC::
Data_069_6BCC:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $01, $2E, $00, $00, $50, $20, $05, $00, $50, $F1
    db $86, $00, $7B, $00, $00, $60, $40, $06, $00, $60, $67
    db $87, $00, $2E, $01, $00, $60, $50, $07, $02, $70, $68

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6BEE::
Data_069_6BEE:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $01, $14, $00, $00, $50, $20, $05, $00, $50, $F1
    db $86, $00, $32, $01, $00, $60, $40, $06, $00, $60, $36
    db $87, $00, $31, $01, $00, $60, $50, $07, $02, $70, $37

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6C10::
Data_069_6C10:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $01, $5F, $00, $00, $50, $20, $05, $00, $50, $F2
    db $86, $00, $A5, $00, $00, $60, $40, $06, $00, $60, $28
    db $87, $00, $EE, $00, $00, $60, $50, $07, $02, $70, $29

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_6C32::
Data_069_6C32:: ; heuristic: map object screen array; C0
    dw $0000 ; id 0
    dw ObjSelector_6C38 ; id 1
    dw $0000 ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6C38:: ; heuristic: map object selector; C0
Data_069_6C38:: ; address name
    objsel_skip_if_clear $0025, $04, $00
    objsel_list MapObjects_6D0B
    INCBIN "dwm2-cobi-us.gbc", $1A6C42, $C9

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6D0B::
Data_069_6D0B:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $01, $4A, $00, $00, $E0, $E0, $05, $00, $50, $A9
    db $86, $01, $02, $00, $00, $50, $20, $06, $00, $60, $19
    db $87, $01, $02, $00, $00, $E0, $E0, $07, $00, $70, $19

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_6D2D::
Data_069_6D2D:: ; heuristic: map object screen array; C0
    dw ObjSelector_6D2F ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6D2F:: ; heuristic: map object selector; C0
Data_069_6D2F:: ; address name
    objsel_skip_if_clear $0025, $04, $00
    objsel_list MapObjects_6D61
    db $FB, $FF, $02, $00, $08, $00, $17, $00, $61, $6D, $FE, $FF, $9B, $6D, $FC, $FF
    db $20, $00, $0C, $00, $21, $00, $61, $6D, $81, $01, $A7, $6D, $FE, $FF, $61, $6D
    db $01, $00, $6D, $6D, $FE, $FF, $84, $6D

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6D61::
Data_069_6D61:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $01, $05, $00, $00, $40, $30, $05, $00, $50, $02
    INCBIN "dwm2-cobi-us.gbc", $1A6D6D, $CE

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_6E3B::
Data_069_6E3B:: ; heuristic: map object screen array; C0
    dw ObjSelector_6E3F ; id 0
    dw ObjSelector_6E65 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6E3F:: ; heuristic: map object selector; C0
Data_069_6E3F:: ; address name
    objsel_list MapObjects_6E43

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6E43::
Data_069_6E43:: ; heuristic: start of a structured table; C0
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
Data_069_6E69:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $00, $4E, $01, $00, $50, $40, $05, $03, $50, $4E
    db $86, $00, $8E, $00, $00, $20, $50, $06, $01, $60, $4F
    db $87, $00, $77, $00, $00, $50, $70, $07, $02, $70, $B6

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_6E8B::
Data_069_6E8B:: ; heuristic: map object screen array; C0
    dw ObjSelector_6E8D ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6E8D:: ; heuristic: map object selector; C0
Data_069_6E8D:: ; address name
    objsel_unless_flag $0002, MapObjects_6E95
    objsel_list MapObjects_6EA1

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6E95::
Data_069_6E95:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $01, $15, $00, $00, $40, $20, $05, $00, $50, $14

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6EA1::
Data_069_6EA1:: ; heuristic: start of a structured table; C0
    db $02 ; entry 0
    db $85, $01, $15, $00, $00, $40, $20, $05, $00, $50, $14
    db $86, $01, $10, $00, $00, $60, $60, $06, $00, $60, $1D

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_6EB8::
Data_069_6EB8:: ; heuristic: map object screen array; C0
    dw ObjSelector_6EBA ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6EBA:: ; heuristic: map object selector; C0
Data_069_6EBA:: ; address name
    objsel_list MapObjects_6EBE

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6EBE::
Data_069_6EBE:: ; heuristic: start of a structured table; C0
    db $04 ; entry 0
    db $85, $01, $1C, $00, $00, $30, $20, $05, $00, $50, $92
    db $86, $01, $1A, $00, $00, $20, $60, $06, $03, $60, $93
    db $86, $01, $1A, $00, $00, $60, $50, $06, $00, $60, $94
    db $87, $01, $10, $00, $00, $50, $70, $07, $02, $70, $E9

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_6EEB::
Data_069_6EEB:: ; heuristic: map object screen array; C0
    dw ObjSelector_6EED ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6EED:: ; heuristic: map object selector; C0
Data_069_6EED:: ; address name
    objsel_list MapObjects_6EF1

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6EF1::
Data_069_6EF1:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $01, $2A, $00, $00, $50, $30, $05, $00, $50, $69
    db $86, $01, $15, $00, $00, $10, $60, $06, $01, $60, $B7
    db $87, $01, $12, $00, $00, $70, $50, $07, $00, $70, $B8

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_6F13::
Data_069_6F13:: ; heuristic: map object screen array; C0
    dw ObjSelector_6F15 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6F15:: ; heuristic: map object selector; C0
Data_069_6F15:: ; address name
    objsel_list MapObjects_6F19

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6F19::
Data_069_6F19:: ; heuristic: start of a structured table; C0
    db $04 ; entry 0
    db $84, $01, $00, $00, $00, $70, $30, $04, $03, $40, $00
    db $85, $00, $01, $00, $00, $60, $40, $05, $03, $50, $00
    db $86, $00, $01, $00, $00, $60, $30, $06, $03, $60, $00
    db $87, $00, $01, $00, $00, $60, $20, $07, $03, $70, $00

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_6F46::
Data_069_6F46:: ; heuristic: map object screen array; C0
    dw ObjSelector_6F4A ; id 0
    dw ObjSelector_6F71 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6F4A:: ; heuristic: map object selector; C0
Data_069_6F4A:: ; address name
    objsel_skip_if_clear $0025, $04, $00
    objsel_list MapObjects_6F5A
    db $24, $00, $5A, $6F, $FF, $FF

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6F5A::
Data_069_6F5A:: ; heuristic: start of a structured table; C0
    db $02 ; entry 0
    db $85, $01, $1E, $00, $00, $40, $70, $05, $02, $50, $25
    db $86, $01, $1F, $00, $00, $40, $60, $06, $00, $60, $26

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_6F71:: ; heuristic: map object selector; C0
Data_069_6F71:: ; address name
    objsel_skip_if_clear $0025, $04, $00
    objsel_list MapObjects_6F83
    db $24, $00, $83, $6F, $FE, $FF, $9A, $6F

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_6F83::
Data_069_6F83:: ; heuristic: start of a structured table; C0
    db $02 ; entry 0
    db $85, $01, $10, $00, $00, $50, $30, $05, $00, $50, $23
    db $86, $01, $10, $00, $00, $60, $70, $06, $03, $60, $24
    db $02, $85, $01, $10, $00, $00, $40, $50, $05, $00, $50, $23, $86, $01, $10, $00
    db $00, $50, $50, $06, $00, $60, $24

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_6FB1::
Data_069_6FB1:: ; heuristic: map object screen array; C0
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
Data_069_6FC5:: ; heuristic: start of a structured table; C0
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
Data_069_6FE0:: ; heuristic: start of a structured table; C0
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
Data_069_7013:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $01, $16, $00, $00, $40, $60, $05, $01, $50, $A8

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_701F::
Data_069_701F:: ; heuristic: map object screen array; C0
    dw ObjSelector_7021 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7021:: ; heuristic: map object selector; C0
Data_069_7021:: ; address name
    objsel_list MapObjects_7025

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7025::
Data_069_7025:: ; heuristic: start of a structured table; C0
    db $04 ; entry 0
    db $85, $01, $1C, $00, $00, $70, $40, $05, $03, $50, $38
    db $86, $01, $1D, $00, $00, $60, $50, $06, $02, $60, $39
    db $87, $01, $18, $00, $00, $20, $20, $07, $00, $70, $3A
    db $87, $01, $18, $00, $00, $40, $10, $07, $00, $70, $B0

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_7052::
Data_069_7052:: ; heuristic: map object screen array; C0
    dw ObjSelector_7054 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7054:: ; heuristic: map object selector; C0
Data_069_7054:: ; address name
    objsel_skip_if_clear $0025, $04, $00
    objsel_list MapObjects_7070
    db $24, $00, $64, $70, $FF, $FF, $01, $85, $01, $1A, $00, $00, $10, $20, $05, $00
    db $50, $3E

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7070::
Data_069_7070:: ; heuristic: start of a structured table; C0
    db $02 ; entry 0
    db $85, $01, $1B, $00, $00, $20, $40, $05, $02, $50, $42
    db $86, $01, $1A, $00, $00, $30, $30, $06, $03, $60, $3E

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_7087::
Data_069_7087:: ; heuristic: map object screen array; C0
    dw ObjSelector_7089 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7089:: ; heuristic: map object selector; C0
Data_069_7089:: ; address name
    objsel_unless_flag $0024, MapObjects_7091
    objsel_list MapObjects_709D

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7091::
Data_069_7091:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $01, $1B, $00, $00, $60, $50, $05, $01, $50, $42

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_709D::
Data_069_709D:: ; heuristic: start of a structured table; C0
    db $02 ; entry 0
    db $85, $01, $1B, $00, $00, $60, $40, $05, $00, $50, $42
    db $86, $01, $1A, $00, $00, $60, $50, $06, $02, $60, $3E

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_70B4::
Data_069_70B4:: ; heuristic: map object screen array; C0
    dw ObjSelector_70B8 ; id 0
    dw ObjSelector_70D3 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_70B8:: ; heuristic: map object selector; C0
Data_069_70B8:: ; address name
    objsel_list MapObjects_70BC

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_70BC::
Data_069_70BC:: ; heuristic: start of a structured table; C0
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
Data_069_70D7:: ; heuristic: start of a structured table; C0
    db $04 ; entry 0
    db $85, $01, $1B, $00, $00, $40, $20, $05, $00, $50, $29
    db $86, $01, $1A, $00, $00, $30, $40, $06, $03, $60, $2C
    db $87, $01, $11, $00, $02, $60, $60, $07, $01, $70, $2A
    db $85, $01, $1B, $00, $00, $80, $70, $05, $03, $50, $AE

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_7104::
Data_069_7104:: ; heuristic: map object screen array; C0
    dw ObjSelector_7106 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7106:: ; heuristic: map object selector; C0
Data_069_7106:: ; address name
    objsel_skip_if_clear $0025, $04, $00
    objsel_list MapObjects_713A
    db $2D, $01, $18, $71, $FE, $FF, $3A, $71, $03, $85, $00, $02, $00, $00, $E0, $30
    db $05, $00, $50, $AD, $86, $01, $1E, $00, $00, $60, $60, $06, $00, $60, $77, $87
    db $01, $19, $00, $00, $40, $40, $07, $01, $70, $27

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_713A::
Data_069_713A:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $01, $1E, $00, $00, $60, $60, $05, $00, $50, $77
    db $86, $01, $19, $00, $00, $40, $40, $06, $02, $60, $27
    db $87, $00, $02, $00, $00, $40, $30, $07, $00, $70, $AD

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_715C::
Data_069_715C:: ; heuristic: map object screen array; C0
    dw ObjSelector_715E ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_715E:: ; heuristic: map object selector; C0
Data_069_715E:: ; address name
    objsel_list MapObjects_7162

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7162::
Data_069_7162:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $01, $21, $00, $00, $40, $30, $05, $00, $50, $46

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_716E::
Data_069_716E:: ; heuristic: map object screen array; C0
    dw ObjSelector_7170 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7170:: ; heuristic: map object selector; C0
Data_069_7170:: ; address name
    objsel_list MapObjects_7174

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7174::
Data_069_7174:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $01, $0C, $00, $00, $50, $90, $05, $02, $50, $00
    db $86, $00, $01, $00, $00, $50, $A0, $06, $00, $60, $00
    db $87, $00, $01, $00, $00, $50, $A0, $07, $00, $70, $00

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_7196::
Data_069_7196:: ; heuristic: map object screen array; C0
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
Data_069_71B0:: ; heuristic: start of a structured table; C0
    db $02 ; entry 0
    db $85, $01, $1E, $00, $00, $50, $30, $05, $00, $50, $8F
    db $86, $01, $5D, $00, $00, $60, $08, $06, $00, $60, $DB

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_71C7::
Data_069_71C7:: ; heuristic: start of a structured table; C0
    db $02 ; entry 0
    db $85, $01, $1E, $00, $00, $40, $30, $05, $00, $50, $8F
    db $86, $01, $5D, $00, $00, $60, $08, $06, $00, $60, $DB

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_71DE::
Data_069_71DE:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $01, $1E, $00, $00, $50, $30, $05, $00, $50, $8F

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_71EA::
Data_069_71EA:: ; heuristic: map object screen array; C0
    dw ObjSelector_71EC ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_71EC:: ; heuristic: map object selector; C0
Data_069_71EC:: ; address name
    objsel_list MapObjects_71F0

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_71F0::
Data_069_71F0:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $01, $1E, $00, $00, $60, $30, $05, $00, $50, $72
    db $86, $01, $1F, $00, $00, $30, $60, $06, $00, $60, $73
    db $87, $00, $11, $00, $00, $40, $20, $07, $01, $70, $D0

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_7212::
Data_069_7212:: ; heuristic: map object screen array; C0
    dw ObjSelector_7214 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7214:: ; heuristic: map object selector; C0
Data_069_7214:: ; address name
    objsel_skip_if_clear $0025, $0C, $00
    objsel_unless_flag $00C9, MapObjects_7288
    objsel_unless_flag $00CA, MapObjects_72B5
    objsel_list MapObjects_72E2
    INCBIN "dwm2-cobi-us.gbc", $1A7226, $62

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7288::
Data_069_7288:: ; heuristic: start of a structured table; C0
    db $04 ; entry 0
    db $87, $01, $2A, $00, $00, $40, $30, $07, $03, $70, $F0
    db $85, $01, $16, $00, $00, $70, $40, $05, $03, $50, $86
    db $85, $01, $16, $00, $00, $10, $60, $05, $02, $50, $87
    db $86, $01, $12, $00, $00, $50, $50, $06, $01, $60, $88

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_72B5::
Data_069_72B5:: ; heuristic: start of a structured table; C0
    db $04 ; entry 0
    db $87, $01, $13, $00, $00, $40, $30, $07, $03, $70, $F0
    db $85, $01, $16, $00, $00, $70, $40, $05, $03, $50, $86
    db $85, $01, $16, $00, $00, $10, $60, $05, $02, $50, $87
    db $86, $01, $12, $00, $00, $50, $50, $06, $01, $60, $88

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_72E2::
Data_069_72E2:: ; heuristic: start of a structured table; C0
    db $04 ; entry 0
    db $87, $01, $17, $00, $00, $40, $30, $07, $03, $70, $F0
    db $85, $01, $16, $00, $00, $70, $40, $05, $03, $50, $86
    db $85, $01, $16, $00, $00, $10, $60, $05, $02, $50, $87
    db $86, $01, $12, $00, $00, $50, $50, $06, $01, $60, $88

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_730F::
Data_069_730F:: ; heuristic: map object screen array; C0
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
Data_069_731F:: ; heuristic: start of a structured table; C0
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
Data_069_7350:: ; heuristic: start of a structured table; C0
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
Data_069_7376:: ; heuristic: start of a structured table; C0
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
Data_069_73A7:: ; heuristic: start of a structured table; C0
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
Data_069_73CD:: ; heuristic: start of a structured table; C0
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
Data_069_73F3:: ; heuristic: start of a structured table; C0
    db $04 ; entry 0
    db $85, $01, $1C, $00, $00, $50, $50, $05, $03, $50, $55
    db $86, $01, $1D, $00, $00, $20, $30, $06, $00, $60, $5E
    db $85, $01, $1C, $00, $00, $20, $40, $05, $02, $50, $C1
    db $87, $01, $1B, $00, $02, $40, $20, $07, $01, $70, $C2

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_7420::
Data_069_7420:: ; heuristic: map object screen array; C0
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
    db $FC, $FF, $D1, $00, $04, $00, $FE, $FF, $81, $74, $17, $01, $48, $74, $FE, $FF
    db $5F, $74, $02, $85, $01, $3B, $00, $00, $40, $20, $05, $00, $50, $81, $86, $01
    db $12, $00, $00, $60, $30, $06, $03, $60, $82

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_745F::
Data_069_745F:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $01, $3B, $00, $00, $40, $20, $05, $00, $50, $81
    db $86, $01, $12, $00, $00, $60, $30, $06, $03, $60, $82
    db $87, $01, $10, $00, $00, $20, $40, $07, $02, $70, $20
    db $03, $85, $01, $3B, $00, $00, $40, $20, $05, $00, $50, $81, $86, $01, $03, $00
    db $00, $30, $40, $06, $01, $60, $99, $87, $01, $1A, $00, $00, $60, $60, $07, $02
    db $70, $0A

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_74A3:: ; heuristic: map object selector; C0
Data_069_74A3:: ; address name
    objsel_skip_if_clear $0025, $04, $00
    objsel_list MapObjects_74CB
    db $FC, $FF, $D1, $00, $04, $00, $FE, $FF, $D7, $74, $22, $01, $BF, $74, $FE, $FF
    db $CB, $74, $01, $85, $01, $10, $00, $00, $40, $70, $05, $02, $50, $83

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_74CB::
Data_069_74CB:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $01, $10, $00, $00, $30, $60, $05, $02, $50, $83
    db $03, $85, $01, $10, $00, $00, $40, $70, $05, $02, $50, $83, $86, $01, $1B, $00
    db $00, $30, $40, $06, $00, $60, $12, $87, $01, $1D, $00, $00, $60, $50, $07, $03
    db $70, $15

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_74F9:: ; heuristic: map object selector; C0
Data_069_74F9:: ; address name
    objsel_skip_if_clear $0025, $04, $00
    objsel_list MapObjects_7511
    db $FC, $FF, $D1, $00, $04, $00, $FE, $FF, $28, $75, $FE, $FF, $11, $75

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7511::
Data_069_7511:: ; heuristic: start of a structured table; C0
    db $02 ; entry 0
    db $85, $01, $10, $00, $00, $20, $30, $05, $01, $50, $84
    db $86, $01, $10, $00, $00, $20, $60, $06, $01, $60, $85
    db $03, $85, $01, $10, $00, $00, $50, $70, $05, $00, $50, $84, $86, $01, $1C, $00
    db $02, $30, $30, $06, $01, $60, $0C, $87, $01, $1E, $00, $00, $70, $40, $07, $00
    db $70, $25

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_754A:: ; heuristic: map object selector; C0
Data_069_754A:: ; address name
    objsel_unless_flag $0025, MapObjects_7552
    objsel_list MapObjects_755E

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7552::
Data_069_7552:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $01, $03, $00, $00, $30, $30, $05, $00, $50, $99

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_755E::
Data_069_755E:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $01, $03, $00, $00, $D0, $30, $05, $00, $50, $99

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_756A::
Data_069_756A:: ; heuristic: map object screen array; C0
    dw ObjSelector_7570 ; id 0
    dw ObjSelector_75C6 ; id 1
    dw ObjSelector_7679 ; id 2

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7570:: ; heuristic: map object selector; C0
Data_069_7570:: ; address name
    objsel_skip_if_clear $0025, $04, $00
    objsel_list MapObjects_7582
    db $24, $00, $82, $75, $FE, $FF, $99, $75

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7582::
Data_069_7582:: ; heuristic: start of a structured table; C0
    db $02 ; entry 0
    db $85, $01, $1E, $00, $00, $40, $60, $05, $00, $50, $8A
    db $86, $01, $1F, $00, $00, $50, $20, $06, $02, $60, $D9
    db $04, $85, $01, $1E, $00, $00, $40, $60, $05, $00, $50, $8A, $86, $01, $1F, $00
    db $00, $50, $20, $06, $02, $60, $D9, $87, $01, $1B, $00, $00, $70, $30, $07, $00
    db $70, $DC, $87, $01, $1B, $00, $00, $70, $40, $07, $02, $70, $DD

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_75C6:: ; heuristic: map object selector; C0
Data_069_75C6:: ; address name
    objsel_skip_if_clear $0025, $04, $00
    objsel_list MapObjects_75E6
    db $FC, $FF, $D1, $00, $08, $00, $01, $00, $1F, $76, $FE, $FF, $4C, $76, $24, $00
    db $E6, $75, $FE, $FF, $F2, $75

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_75E6::
Data_069_75E6:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $01, $12, $00, $00, $30, $50, $05, $00, $50, $8D
    INCBIN "dwm2-cobi-us.gbc", $1A75F2, $87

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
Data_069_7689:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $01, $10, $00, $00, $20, $20, $05, $00, $50, $8C
    db $86, $00, $7A, $00, $00, $40, $40, $06, $02, $60, $D7
    db $87, $01, $11, $00, $00, $40, $30, $07, $00, $70, $D6

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_76AB::
Data_069_76AB:: ; heuristic: start of a structured table; C0
    db $02 ; entry 0
    db $85, $01, $10, $00, $00, $30, $20, $05, $00, $50, $8C
    db $86, $01, $12, $00, $00, $60, $30, $06, $01, $60, $8D

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_76C2::
Data_069_76C2:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $01, $10, $00, $00, $20, $20, $05, $00, $50, $8C
    db $86, $00, $7A, $00, $00, $50, $40, $06, $02, $60, $D7
    db $87, $01, $11, $00, $00, $50, $30, $07, $00, $70, $D6

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_76E4::
Data_069_76E4:: ; heuristic: map object screen array; C0
    dw ObjSelector_76E8 ; id 0
    dw Data_069_76F8 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_76E8:: ; heuristic: map object selector; C0
Data_069_76E8:: ; address name
    objsel_list MapObjects_76EC

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_76EC::
Data_069_76EC:: ; heuristic: start of a structured table; C0
    db $02 ; entry 0
    db $85, $01, $57, $00, $00, $45, $80, $05, $02, $50, $00
Data_069_76F8:: ; heuristic: map object selector; C0
    db $FE, $FF, $FC, $76, $01, $85, $01, $57, $00, $00, $45
    db $A0, $05, $02, $50, $00

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_7708::
Data_069_7708:: ; heuristic: map object screen array; C0
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
Data_069_7714:: ; heuristic: start of a structured table; C0
    db $04 ; entry 0
    db $85, $01, $04, $00, $00, $50, $10, $05, $00, $50, $32
    db $86, $01, $05, $00, $00, $40, $10, $06, $00, $60, $31
    db $87, $01, $28, $00, $00, $80, $40, $07, $01, $70, $30
    db $84, $01, $00, $00, $00, $B0, $50, $04, $03, $40, $00

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7741::
Data_069_7741:: ; heuristic: start of a structured table; C0
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
    db $01, $00, $DE, $77, $FE, $FF, $00, $78

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7784::
Data_069_7784:: ; heuristic: start of a structured table; C0
    db $04 ; entry 0
    db $85, $01, $29, $00, $02, $50, $30, $05, $01, $50, $2D
    db $86, $01, $29, $00, $00, $10, $60, $06, $00, $60, $2E
    db $87, $01, $00, $00, $00, $E0, $50, $07, $01, $70, $2F
    db $86, $01, $29, $00, $00, $20, $E0, $06, $02, $60, $00

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_77B1::
Data_069_77B1:: ; heuristic: start of a structured table; C0
    db $04 ; entry 0
    db $85, $01, $29, $00, $02, $50, $30, $05, $01, $50, $2D
    db $86, $01, $29, $00, $00, $10, $60, $06, $00, $60, $2E
    db $87, $01, $01, $00, $00, $E0, $50, $07, $01, $70, $2F
    db $86, $01, $29, $00, $00, $20, $E0, $06, $02, $60, $00
    INCBIN "dwm2-cobi-us.gbc", $1A77DE, $44

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_7822::
Data_069_7822:: ; heuristic: map object screen array; C0
    dw ObjSelector_7826 ; id 0
    dw ObjSelector_7857 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7826:: ; heuristic: map object selector; C0
Data_069_7826:: ; address name
    objsel_list MapObjects_782A

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_782A::
Data_069_782A:: ; heuristic: start of a structured table; C0
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
Data_069_785B:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $01, $26, $00, $00, $60, $50, $05, $00, $50, $04
    db $86, $01, $25, $00, $02, $30, $60, $06, $01, $60, $05
    db $87, $01, $24, $00, $00, $10, $30, $07, $00, $70, $06

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_787D::
Data_069_787D:: ; heuristic: map object screen array; C0
    dw ObjSelector_787F ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_787F:: ; heuristic: map object selector; C0
Data_069_787F:: ; address name
    objsel_list MapObjects_7883

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7883::
Data_069_7883:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $01, $24, $00, $00, $30, $40, $05, $01, $50, $0A
    db $86, $01, $25, $00, $00, $80, $70, $06, $03, $60, $0B
    db $87, $01, $12, $00, $00, $50, $10, $07, $00, $70, $45

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_78A5::
Data_069_78A5:: ; heuristic: map object screen array; C0
    dw ObjSelector_78A7 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_78A7:: ; heuristic: map object selector; C0
Data_069_78A7:: ; address name
    objsel_list MapObjects_78AB

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_78AB::
Data_069_78AB:: ; heuristic: start of a structured table; C0
    db $02 ; entry 0
    db $85, $01, $24, $00, $00, $10, $60, $05, $02, $50, $1F
    db $86, $01, $24, $00, $00, $50, $10, $06, $00, $60, $20

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_78C2::
Data_069_78C2:: ; heuristic: map object screen array; C0
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
Data_069_78D2:: ; heuristic: start of a structured table; C0
    db $04 ; entry 0
    db $85, $01, $4D, $00, $00, $40, $10, $05, $00, $50, $13
    db $85, $01, $4D, $00, $00, $50, $10, $05, $00, $50, $14
    db $86, $01, $24, $00, $00, $70, $60, $06, $03, $60, $0D
    db $87, $01, $25, $00, $00, $30, $70, $07, $00, $70, $15

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_78FF::
Data_069_78FF:: ; heuristic: start of a structured table; C0
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
Data_069_7930:: ; heuristic: start of a structured table; C0
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
Data_069_794B:: ; heuristic: start of a structured table; C0
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
Data_069_7980:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $01, $25, $00, $00, $20, $60, $05, $03, $50, $0F
    db $86, $01, $24, $00, $00, $50, $50, $06, $00, $60, $16
    db $87, $01, $4B, $00, $00, $40, $30, $07, $00, $70, $18

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_79A2::
Data_069_79A2:: ; heuristic: start of a structured table; C0
    db $02 ; entry 0
    db $85, $01, $25, $00, $00, $20, $60, $05, $03, $50, $0F
    db $86, $01, $24, $00, $00, $50, $50, $06, $00, $60, $16

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_79B9::
Data_069_79B9:: ; heuristic: map object screen array; C0
    dw ObjSelector_79BD ; id 0
    dw ObjSelector_7A32 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_79BD:: ; heuristic: map object selector; C0
Data_069_79BD:: ; address name
    objsel_skip_if_clear $005A, $04, $00
    objsel_list MapObjects_79ED
    db $FB, $FF, $43, $00, $02, $00, $FF, $FF, $FC, $FF, $55, $00, $06, $00, $56, $00
    db $10, $7A, $FF, $FF, $FC, $FF, $53, $00, $04, $00, $FE, $FF, $ED, $79, $49, $00
    db $ED, $79, $FE, $FF, $04, $7A

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_79ED::
Data_069_79ED:: ; heuristic: start of a structured table; C0
    db $02 ; entry 0
    db $85, $01, $4D, $00, $00, $30, $50, $05, $00, $50, $27
    db $86, $01, $24, $00, $02, $60, $40, $06, $00, $60, $28
    db $01, $85, $01, $4D, $00, $00, $30, $50, $05, $00, $50, $27, $03, $85, $01, $22
    db $00, $00, $40, $18, $05, $00, $50, $2B, $86, $01, $4D, $00, $00, $30, $50, $06
    db $00, $60, $27, $87, $01, $24, $00, $00, $60, $40, $07, $00, $70, $28

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7A32:: ; heuristic: map object selector; C0
Data_069_7A32:: ; address name
    objsel_skip_if_clear $005A, $04, $00
    objsel_list MapObjects_7A6F
    db $56, $00, $42, $7A, $FF, $FF, $04, $85, $01, $4C, $00, $00, $20, $10, $05, $03
    db $50, $22, $85, $01, $4C, $00, $00, $20, $20, $05, $03, $50, $23, $85, $01, $4C
    db $00, $00, $10, $30, $05, $02, $50, $24, $86, $01, $4B, $00, $00, $30, $50, $06
    db $00, $60, $21

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7A6F::
Data_069_7A6F:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $01, $4C, $00, $00, $20, $10, $05, $03, $50, $22
    db $85, $01, $4C, $00, $00, $20, $20, $05, $03, $50, $23
    db $86, $01, $4B, $00, $00, $30, $50, $06, $00, $60, $21

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_7A91::
Data_069_7A91:: ; heuristic: map object screen array; C0
    dw ObjSelector_7A93 ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7A93:: ; heuristic: map object selector; C0
Data_069_7A93:: ; address name
    objsel_skip_if_set $0025, $0A, $00
    objsel_skip_if_clear $00D1, $04, $00
    objsel_list MapObjects_7B26
    INCBIN "dwm2-cobi-us.gbc", $1A7AA3, $83

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 5 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7B26::
Data_069_7B26:: ; heuristic: start of a structured table; C0
    db $05 ; entry 0
    db $85, $01, $22, $00, $00, $40, $10, $05, $00, $50, $2B
    db $86, $01, $24, $00, $00, $60, $20, $06, $00, $60, $28
    db $87, $01, $4B, $00, $00, $40, $50, $07, $02, $70, $21
    db $83, $01, $4C, $00, $00, $30, $60, $03, $02, $30, $23
    db $83, $01, $4C, $00, $00, $60, $60, $03, $02, $30, $23

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_7B5E::
Data_069_7B5E:: ; heuristic: map object screen array; C0
    dw ObjSelector_7B62 ; id 0
    dw ObjSelector_7B72 ; id 1

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7B62:: ; heuristic: map object selector; C0
Data_069_7B62:: ; address name
    objsel_list MapObjects_7B66

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7B66::
Data_069_7B66:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $00, $4F, $00, $00, $50, $20, $05, $00, $50, $3B

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7B72:: ; heuristic: map object selector; C0
Data_069_7B72:: ; address name
    objsel_skip_if_clear $005A, $02, $00
    objsel_none
    db $FE, $FF, $7E, $7B, $04, $85, $01, $5C, $00, $00, $40, $10, $05, $00, $50, $3C
    db $86, $01, $22, $00, $00, $40, $A0, $06, $02, $60, $2B, $87, $01, $4D, $00, $00
    db $40, $B0, $07, $02, $70, $00, $87, $01, $4D, $00, $00, $40, $C0, $07, $02, $70
    db $00

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_7BAB::
Data_069_7BAB:: ; heuristic: map object screen array; C0
    dw ObjSelector_7BAD ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7BAD:: ; heuristic: map object selector; C0
Data_069_7BAD:: ; address name
    objsel_skip_if_set $004A, $08, $00
    objsel_unless_flag $0049, MapObjects_7BBF
    objsel_list MapObjects_7BCB
    db $FE, $FF, $E2, $7B

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 1 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7BBF::
Data_069_7BBF:: ; heuristic: start of a structured table; C0
    db $01 ; entry 0
    db $85, $01, $26, $00, $00, $20, $40, $05, $00, $50, $09

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7BCB::
Data_069_7BCB:: ; heuristic: start of a structured table; C0
    db $02 ; entry 0
    db $85, $01, $22, $00, $00, $20, $50, $05, $02, $50, $2B
    db $86, $01, $26, $00, $00, $20, $40, $06, $00, $60, $09
    db $02, $85, $01, $22, $00, $00, $E0, $E0, $05, $02, $50, $2B, $86, $01, $26, $00
    db $00, $20, $10, $06, $00, $60, $09

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_7BF9::
Data_069_7BF9:: ; heuristic: map object screen array; C0
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
    db $53, $00, $29, $7C, $FE, $FF, $40, $7C, $02, $85, $01, $22, $00, $00, $30, $70
    db $05, $02, $50, $2B, $86, $00, $4F, $00, $00, $30, $60, $06, $00, $60, $37, $01
    db $85, $01, $22, $00, $00, $30, $70, $05, $02, $50, $2B

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_7C4C::
Data_069_7C4C:: ; heuristic: map object screen array; C0
    dw ObjSelector_7C4E ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7C4E:: ; heuristic: map object selector; C0
Data_069_7C4E:: ; address name
    objsel_skip_if_clear $005A, $04, $00
    objsel_list MapObjects_7CAF
    INCBIN "dwm2-cobi-us.gbc", $1A7C58, $57

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 4 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7CAF::
Data_069_7CAF:: ; heuristic: start of a structured table; C0
    db $04 ; entry 0
    db $85, $01, $4D, $00, $00, $50, $30, $05, $00, $50, $2C
    db $86, $01, $27, $00, $00, $30, $70, $06, $00, $60, $00
    db $86, $01, $27, $00, $00, $10, $70, $06, $01, $60, $00
    db $86, $01, $27, $00, $00, $20, $70, $06, $03, $60, $00

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_7CDC::
Data_069_7CDC:: ; heuristic: map object screen array; C0
    dw ObjSelector_7CDE ; id 0

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7CDE:: ; heuristic: map object selector; C0
Data_069_7CDE:: ; address name
    objsel_skip_if_clear $005A, $04, $00
    objsel_list MapObjects_7CF8
    db $FC, $FF, $55, $00, $06, $00, $56, $00, $0F, $7D, $FF, $FF, $FE, $FF, $F8, $7C

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 2 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7CF8::
Data_069_7CF8:: ; heuristic: start of a structured table; C0
    db $02 ; entry 0
    db $85, $01, $4D, $00, $00, $40, $40, $05, $00, $50, $25
    db $85, $01, $4D, $00, $00, $50, $40, $05, $00, $50, $26
    db $03, $85, $01, $22, $00, $00, $30, $60, $05, $01, $50, $2B, $86, $01, $4D, $00
    db $00, $60, $50, $06, $02, $60, $25, $86, $01, $4D, $00, $00, $70, $70, $06, $03
    db $60, $26

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_7D31::
Data_069_7D31:: ; heuristic: map object screen array; C0
    dw ObjSelector_7D39 ; id 0
    dw ObjSelector_7D51 ; id 1
    dw ObjSelector_7DDD ; id 2
    dw $0000 ; id 3

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7D39:: ; heuristic: map object selector; C0
Data_069_7D39:: ; address name
    objsel_skip_if_set $005A, $02, $00
    objsel_none
    db $FE, $FF, $45, $7D, $01, $85, $00, $4F, $00, $00, $30, $60, $05, $01, $50, $3D

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7D51:: ; heuristic: map object selector; C0
Data_069_7D51:: ; address name
    objsel_skip_if_set $0025, $0A, $00
    objsel_skip_if_clear $00D1, $04, $00
    objsel_list MapObjects_7DBB
    INCBIN "dwm2-cobi-us.gbc", $1A7D61, $5A

; E-0163 (derived: an object list of LoadMapObjectsForScreen)
; record: count, then 3 object(s): VRAM page, graphics table (0 = monster sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, slot byte 7, talk event group, slot byte 15
MapObjects_7DBB::
Data_069_7DBB:: ; heuristic: start of a structured table; C0
    db $03 ; entry 0
    db $85, $00, $4F, $00, $00, $40, $E0, $05, $00, $50, $37
    db $85, $00, $4F, $00, $00, $50, $E0, $05, $00, $50, $37
    db $85, $00, $4F, $00, $00, $40, $E0, $05, $00, $50, $3A

; map object selector (E-0163): the first entry that applies picks the object list
ObjSelector_7DDD:: ; heuristic: map object selector; C0
Data_069_7DDD:: ; address name
    objsel_skip_if_clear $0058, $02, $00
    objsel_none
    db $FB, $FF, $56, $00, $02, $00, $FF, $FF, $FE, $FF, $F1, $7D, $04, $85, $01, $22
    db $00, $00, $60, $60, $05, $02, $50, $2B, $86, $01, $4D, $00, $00, $10, $40, $06
    db $02, $60, $25, $86, $01, $4D, $00, $02, $20, $70, $06, $02, $60, $26, $86, $01
    db $4D, $00, $00, $80, $50, $06, $02, $60, $2D

; address loaded by LoadMapObjectsForScreen
Data_069_7E1E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $04, $85, $01, $22, $00, $00, $60, $30, $05, $03, $50, $2B, $86, $01, $4D, $00
    db $00, $10, $10, $06, $02, $60, $25, $86, $01, $4D, $00, $02, $20, $40, $06, $01
    db $60, $26, $86, $01, $4D, $00, $00, $80, $20, $06, $03, $60, $2D

; E-0163 (derived: one selector per screen, row by row)
; record: selector for this screen
MapObjectScreens_7E4B::
Data_069_7E4B:: ; heuristic: map object screen array; C0
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
