SECTION "Bank 72", ROMX[$4000], BANK[$72]
    db $72

; E-0141 (C1: LoadMapScreen_Sub03_Case05 reads the word at $4001 + 2 * wKeyWorldRoomTable[...] in bank $72 with ReadByteInBank; every non-zero word is $4181 + $63 * n).
; record: room record in KeyWorldRooms ($0000 = none)
KeyWorldRoomPointers::
Data_072_4001:: ; address name
    dw KeyWorldRoom05 ; id 0
    dw KeyWorldRoom05 ; id 1
    dw KeyWorldRoom02 ; id 2
    dw KeyWorldRoom05 ; id 3
    dw KeyWorldRoom05 ; id 4
    dw KeyWorldRoom04 ; id 5
    dw KeyWorldRoom06 ; id 6
    dw KeyWorldRoom05 ; id 7
    dw KeyWorldRoom07 ; id 8
    dw KeyWorldRoom0C ; id 9
    dw KeyWorldRoom0C ; id 10
    dw KeyWorldRoom0C ; id 11
    dw KeyWorldRoom0C ; id 12
    dw KeyWorldRoom08 ; id 13
    dw KeyWorldRoom0D ; id 14
    dw KeyWorldRoom0C ; id 15
    dw KeyWorldRoom0E ; id 16
    dw KeyWorldRoom13 ; id 17
    dw KeyWorldRoom13 ; id 18
    dw KeyWorldRoom13 ; id 19
    dw KeyWorldRoom13 ; id 20
    dw KeyWorldRoom12 ; id 21
    dw KeyWorldRoom14 ; id 22
    dw KeyWorldRoom13 ; id 23
    dw KeyWorldRoom15 ; id 24
    dw KeyWorldRoom1A ; id 25
    dw KeyWorldRoom1A ; id 26
    dw KeyWorldRoom1A ; id 27
    dw KeyWorldRoom1A ; id 28
    dw KeyWorldRoom16 ; id 29
    dw KeyWorldRoom1B ; id 30
    dw KeyWorldRoom1A ; id 31
    dw KeyWorldRoom1C ; id 32
    dw KeyWorldRoom21 ; id 33
    dw KeyWorldRoom21 ; id 34
    dw KeyWorldRoom21 ; id 35
    dw KeyWorldRoom21 ; id 36
    dw KeyWorldRoom20 ; id 37
    dw KeyWorldRoom22 ; id 38
    dw KeyWorldRoom21 ; id 39
    dw KeyWorldRoom28 ; id 40
    dw KeyWorldRoom24 ; id 41
    dw KeyWorldRoom28 ; id 42
    dw KeyWorldRoom28 ; id 43
    dw KeyWorldRoom28 ; id 44
    dw KeyWorldRoom23 ; id 45
    dw KeyWorldRoom29 ; id 46
    dw KeyWorldRoom28 ; id 47
    dw KeyWorldRoom2F ; id 48
    dw KeyWorldRoom2F ; id 49
    dw KeyWorldRoom2F ; id 50
    dw KeyWorldRoom2D ; id 51
    dw KeyWorldRoom2F ; id 52
    dw KeyWorldRoom2A ; id 53
    dw KeyWorldRoom30 ; id 54
    dw KeyWorldRoom2F ; id 55
    dw KeyWorldRoom36 ; id 56
    dw KeyWorldRoom36 ; id 57
    dw KeyWorldRoom36 ; id 58
    dw KeyWorldRoom36 ; id 59
    dw KeyWorldRoom35 ; id 60
    dw KeyWorldRoom33 ; id 61
    dw KeyWorldRoom37 ; id 62
    dw KeyWorldRoom36 ; id 63
    dw KeyWorldRoom38 ; id 64
    dw KeyWorldRoom3D ; id 65
    dw KeyWorldRoom3D ; id 66
    dw KeyWorldRoom3D ; id 67
    dw KeyWorldRoom3D ; id 68
    dw KeyWorldRoom3B ; id 69
    dw KeyWorldRoom3E ; id 70
    dw KeyWorldRoom3D ; id 71
    dw KeyWorldRoom44 ; id 72
    dw KeyWorldRoom40 ; id 73
    dw KeyWorldRoom44 ; id 74
    dw KeyWorldRoom44 ; id 75
    dw KeyWorldRoom44 ; id 76
    dw KeyWorldRoom41 ; id 77
    dw KeyWorldRoom45 ; id 78
    dw KeyWorldRoom44 ; id 79
    dw KeyWorldRoom46 ; id 80
    dw KeyWorldRoom4B ; id 81
    dw KeyWorldRoom4B ; id 82
    dw KeyWorldRoom4B ; id 83
    dw KeyWorldRoom4B ; id 84
    dw KeyWorldRoom48 ; id 85
    dw KeyWorldRoom4C ; id 86
    dw KeyWorldRoom4B ; id 87
    dw KeyWorldRoom52 ; id 88
    dw KeyWorldRoom4E ; id 89
    dw KeyWorldRoom52 ; id 90
    dw KeyWorldRoom52 ; id 91
    dw KeyWorldRoom52 ; id 92
    dw KeyWorldRoom51 ; id 93
    dw KeyWorldRoom53 ; id 94
    dw KeyWorldRoom52 ; id 95
    dw KeyWorldRoom59 ; id 96
    dw KeyWorldRoom59 ; id 97
    dw KeyWorldRoom59 ; id 98
    dw KeyWorldRoom57 ; id 99
    dw KeyWorldRoom59 ; id 100
    dw KeyWorldRoom55 ; id 101
    dw KeyWorldRoom5A ; id 102
    dw KeyWorldRoom59 ; id 103
    dw KeyWorldRoom60 ; id 104
    dw KeyWorldRoom60 ; id 105
    dw KeyWorldRoom60 ; id 106
    dw KeyWorldRoom60 ; id 107
    dw KeyWorldRoom5F ; id 108
    dw KeyWorldRoom5E ; id 109
    dw KeyWorldRoom61 ; id 110
    dw KeyWorldRoom60 ; id 111
    dw KeyWorldRoom67 ; id 112
    dw KeyWorldRoom67 ; id 113
    dw KeyWorldRoom64 ; id 114
    dw KeyWorldRoom67 ; id 115
    dw KeyWorldRoom67 ; id 116
    dw KeyWorldRoom66 ; id 117
    dw KeyWorldRoom68 ; id 118
    dw KeyWorldRoom67 ; id 119
    dw KeyWorldRoom69 ; id 120
    dw KeyWorldRoom6E ; id 121
    dw KeyWorldRoom6E ; id 122
    dw KeyWorldRoom6E ; id 123
    dw KeyWorldRoom6E ; id 124
    dw KeyWorldRoom6A ; id 125
    dw KeyWorldRoom6F ; id 126
    dw KeyWorldRoom6E ; id 127
    dw KeyWorldRoom75 ; id 128
    dw KeyWorldRoom75 ; id 129
    dw KeyWorldRoom75 ; id 130
    dw KeyWorldRoom75 ; id 131
    dw KeyWorldRoom74 ; id 132
    dw KeyWorldRoom73 ; id 133
    dw KeyWorldRoom76 ; id 134
    dw KeyWorldRoom75 ; id 135
    dw KeyWorldRoom7C ; id 136
    dw KeyWorldRoom7C ; id 137
    dw KeyWorldRoom7C ; id 138
    dw KeyWorldRoom7A ; id 139
    dw KeyWorldRoom7C ; id 140
    dw KeyWorldRoom77 ; id 141
    dw KeyWorldRoom7D ; id 142
    dw KeyWorldRoom7C ; id 143
    dw KeyWorldRoom83 ; id 144
    dw KeyWorldRoom7F ; id 145
    dw KeyWorldRoom83 ; id 146
    dw KeyWorldRoom83 ; id 147
    dw KeyWorldRoom83 ; id 148
    dw KeyWorldRoom80 ; id 149
    dw KeyWorldRoom84 ; id 150
    dw KeyWorldRoom83 ; id 151
    dw KeyWorldRoom8A ; id 152
    dw KeyWorldRoom8A ; id 153
    dw KeyWorldRoom8A ; id 154
    dw KeyWorldRoom88 ; id 155
    dw KeyWorldRoom8A ; id 156
    dw KeyWorldRoom87 ; id 157
    dw KeyWorldRoom8B ; id 158
    dw KeyWorldRoom8A ; id 159
    dw KeyWorldRoom8C ; id 160
    dw KeyWorldRoom8D ; id 161
    dw KeyWorldRoom8E ; id 162
    dw KeyWorldRoom8F ; id 163
    dw KeyWorldRoom90 ; id 164
    dw $0000 ; id 165
    dw $0000 ; id 166
    dw $0000 ; id 167
    dw KeyWorldRoom91 ; id 168
    dw KeyWorldRoom92 ; id 169
    dw KeyWorldRoom93 ; id 170
    dw KeyWorldRoom94 ; id 171
    dw KeyWorldRoom95 ; id 172
    dw $0000 ; id 173
    dw $0000 ; id 174
    dw $0000 ; id 175
    dw KeyWorldRoom96 ; id 176
    dw KeyWorldRoom97 ; id 177
    dw KeyWorldRoom98 ; id 178
    dw KeyWorldRoom99 ; id 179
    dw KeyWorldRoom9A ; id 180
    dw $0000 ; id 181
    dw $0000 ; id 182
    dw $0000 ; id 183
    dw KeyWorldRoom9B ; id 184
    dw KeyWorldRoom9C ; id 185
    dw KeyWorldRoom9D ; id 186
    dw KeyWorldRoom9E ; id 187
    dw KeyWorldRoom9F ; id 188
    dw $0000 ; id 189
    dw $0000 ; id 190
    dw $0000 ; id 191

; E-0141 (C1: LoadMapScreen_Sub03_Case05 skips the 3-byte header, takes the far pointer at 3 + 12 * hMapScreenY + 3 * hMapScreenX and decompresses it into wScreenTileBuffer; on CGB the far pointer $30 bytes later is decompressed as the attribute map. All 5,056 non-zero pointers of the 160 records decode to 360 bytes).
; record: 3-byte header; 16 far pointers to compressed screen tile maps (4 x 4 grid, row by row); 16 far pointers to their attribute maps
KeyWorldRooms::
KeyWorldRoom00:: ; heuristic: start of a structured table; C0
Data_072_4181:: ; address name
    db $00, $01, $02 ; id 0
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom00_Y0X1_Tiles
    dfar KeyWorldRoom00_Y0X2_Tiles
    dfar KeyWorldRoom00_Y0X3_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom00_Y0X3_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom00_Y2X1_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom00_Y3X1_Tiles
    dfar KeyWorldRoom00_Y3X2_Tiles
    dfar KeyWorldRoom00_Y3X3_Tiles
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom00_Y0X1_Attrs
    dfar KeyWorldRoom00_Y0X2_Attrs
    dfar KeyWorldRoom00_Y0X3_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom00_Y0X3_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom00_Y2X1_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom00_Y3X1_Attrs
    dfar KeyWorldRoom00_Y3X2_Attrs
    dfar KeyWorldRoom00_Y3X3_Attrs
KeyWorldRoom01:: ; heuristic: string; C0
    db $00, $01, $02 ; id 1
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom01_Y0X1_Tiles
    dfar KeyWorldRoom01_Y0X1_Tiles
    dfar KeyWorldRoom00_Y0X3_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom01_Y1X2_Tiles
    dfar KeyWorldRoom01_Y1X3_Tiles
    dfar KeyWorldRoom00_Y2X1_Tiles
    dfar KeyWorldRoom01_Y2X1_Tiles
    dfar KeyWorldRoom01_Y2X2_Tiles
    dfar KeyWorldRoom01_Y2X3_Tiles
    dfar KeyWorldRoom01_Y3X0_Tiles
    dfar KeyWorldRoom01_Y3X1_Tiles
    dfar KeyWorldRoom00_Y0X1_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom01_Y0X1_Attrs
    dfar KeyWorldRoom01_Y0X1_Attrs
    dfar KeyWorldRoom00_Y0X3_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom01_Y1X2_Attrs
    dfar KeyWorldRoom01_Y1X3_Attrs
    dfar KeyWorldRoom00_Y2X1_Attrs
    dfar KeyWorldRoom01_Y2X1_Attrs
    dfar KeyWorldRoom01_Y2X2_Attrs
    dfar KeyWorldRoom01_Y2X3_Attrs
    dfar KeyWorldRoom01_Y3X0_Attrs
    dfar KeyWorldRoom01_Y3X1_Attrs
    dfar KeyWorldRoom00_Y0X1_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
KeyWorldRoom02:: ; heuristic: key-world room record; C0
Data_072_4247:: ; address name
    db $00, $01, $02 ; id 2
    dfar KeyWorldRoom02_Y0X0_Tiles
    dfar KeyWorldRoom02_Y0X1_Tiles
    dfar KeyWorldRoom01_Y0X1_Tiles
    dfar KeyWorldRoom00_Y0X3_Tiles
    dfar KeyWorldRoom02_Y1X0_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom02_Y1X2_Tiles
    dfar KeyWorldRoom02_Y1X3_Tiles
    dfar KeyWorldRoom02_Y2X0_Tiles
    dfar KeyWorldRoom02_Y2X1_Tiles
    dfar KeyWorldRoom02_Y2X2_Tiles
    dfar KeyWorldRoom02_Y2X3_Tiles
    dfar KeyWorldRoom02_Y3X0_Tiles
    dfar KeyWorldRoom00_Y0X2_Tiles
    dfar KeyWorldRoom02_Y3X2_Tiles
    dfar KeyWorldRoom02_Y3X3_Tiles
    dfar KeyWorldRoom02_Y0X0_Attrs
    dfar KeyWorldRoom02_Y0X1_Attrs
    dfar KeyWorldRoom01_Y0X1_Attrs
    dfar KeyWorldRoom00_Y0X3_Attrs
    dfar KeyWorldRoom02_Y1X0_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom02_Y1X2_Attrs
    dfar KeyWorldRoom02_Y1X3_Attrs
    dfar KeyWorldRoom02_Y2X0_Attrs
    dfar KeyWorldRoom02_Y2X1_Attrs
    dfar KeyWorldRoom02_Y2X2_Attrs
    dfar KeyWorldRoom02_Y2X3_Attrs
    dfar KeyWorldRoom02_Y3X0_Attrs
    dfar KeyWorldRoom00_Y0X2_Attrs
    dfar KeyWorldRoom02_Y3X2_Attrs
    dfar KeyWorldRoom02_Y3X3_Attrs
KeyWorldRoom03:: ; heuristic: string; C0
    db $00, $01, $02 ; id 3
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom03_Y0X1_Tiles
    dfar KeyWorldRoom03_Y0X2_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom03_Y1X0_Tiles
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom03_Y1X2_Tiles
    dfar KeyWorldRoom03_Y1X3_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom03_Y2X1_Tiles
    dfar KeyWorldRoom03_Y2X2_Tiles
    dfar KeyWorldRoom03_Y2X3_Tiles
    dfar KeyWorldRoom03_Y3X0_Tiles
    dfar KeyWorldRoom03_Y3X1_Tiles
    dfar KeyWorldRoom03_Y3X2_Tiles
    dfar KeyWorldRoom00_Y3X2_Tiles
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom03_Y0X1_Attrs
    dfar KeyWorldRoom03_Y0X2_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom03_Y1X0_Attrs
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom03_Y1X2_Attrs
    dfar KeyWorldRoom03_Y1X3_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom03_Y2X1_Attrs
    dfar KeyWorldRoom03_Y2X2_Attrs
    dfar KeyWorldRoom03_Y2X3_Attrs
    dfar KeyWorldRoom03_Y3X0_Attrs
    dfar KeyWorldRoom03_Y3X1_Attrs
    dfar KeyWorldRoom03_Y3X2_Attrs
    dfar KeyWorldRoom00_Y3X2_Attrs
KeyWorldRoom04:: ; heuristic: key-world room record; C0
Data_072_430D:: ; address name
    db $00, $01, $02 ; id 4
    dfar KeyWorldRoom04_Y0X0_Tiles
    dfar KeyWorldRoom04_Y0X1_Tiles
    dfar KeyWorldRoom04_Y0X2_Tiles
    dfar KeyWorldRoom00_Y0X3_Tiles
    dfar KeyWorldRoom01_Y1X3_Tiles
    dfar KeyWorldRoom04_Y1X1_Tiles
    dfar KeyWorldRoom01_Y0X1_Tiles
    dfar KeyWorldRoom04_Y1X3_Tiles
    dfar KeyWorldRoom02_Y1X2_Tiles
    dfar KeyWorldRoom04_Y2X1_Tiles
    dfar KeyWorldRoom04_Y2X2_Tiles
    dfar KeyWorldRoom02_Y1X3_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom00_Y0X2_Tiles
    dfar KeyWorldRoom02_Y3X2_Tiles
    dfar KeyWorldRoom04_Y3X3_Tiles
    dfar KeyWorldRoom04_Y0X0_Attrs
    dfar KeyWorldRoom04_Y0X1_Attrs
    dfar KeyWorldRoom04_Y0X2_Attrs
    dfar KeyWorldRoom00_Y0X3_Attrs
    dfar KeyWorldRoom01_Y1X3_Attrs
    dfar KeyWorldRoom04_Y1X1_Attrs
    dfar KeyWorldRoom01_Y0X1_Attrs
    dfar KeyWorldRoom04_Y1X3_Attrs
    dfar KeyWorldRoom02_Y1X2_Attrs
    dfar KeyWorldRoom04_Y2X1_Attrs
    dfar KeyWorldRoom04_Y2X2_Attrs
    dfar KeyWorldRoom02_Y1X3_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom00_Y0X2_Attrs
    dfar KeyWorldRoom02_Y3X2_Attrs
    dfar KeyWorldRoom04_Y3X3_Attrs
KeyWorldRoom05:: ; heuristic: key-world room record; C0
Data_072_4370:: ; address name
    db $00, $01, $02 ; id 5
    dfar KeyWorldRoom02_Y0X1_Tiles
    dfar KeyWorldRoom05_Y0X1_Tiles
    dfar KeyWorldRoom03_Y0X1_Tiles
    dfar KeyWorldRoom00_Y3X2_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X1_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom02_Y0X1_Attrs
    dfar KeyWorldRoom05_Y0X1_Attrs
    dfar KeyWorldRoom03_Y0X1_Attrs
    dfar KeyWorldRoom00_Y3X2_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X1_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
KeyWorldRoom06:: ; heuristic: key-world room record; C0
Data_072_43D3:: ; address name
    db $00, $01, $02 ; id 6
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom06_Y0X1_Tiles
    dfar KeyWorldRoom02_Y0X1_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom03_Y2X1_Tiles
    dfar KeyWorldRoom06_Y1X1_Tiles
    dfar KeyWorldRoom06_Y1X2_Tiles
    dfar KeyWorldRoom04_Y2X2_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom03_Y1X0_Tiles
    dfar KeyWorldRoom01_Y3X0_Tiles
    dfar KeyWorldRoom06_Y2X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom06_Y3X1_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom06_Y0X1_Attrs
    dfar KeyWorldRoom02_Y0X1_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom03_Y2X1_Attrs
    dfar KeyWorldRoom06_Y1X1_Attrs
    dfar KeyWorldRoom06_Y1X2_Attrs
    dfar KeyWorldRoom04_Y2X2_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom03_Y1X0_Attrs
    dfar KeyWorldRoom01_Y3X0_Attrs
    dfar KeyWorldRoom06_Y2X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom06_Y3X1_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
KeyWorldRoom07:: ; heuristic: key-world room record; C0
Data_072_4436:: ; address name
    db $00, $01, $03 ; id 7
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom00_Y0X2_Tiles
    dfar KeyWorldRoom01_Y0X1_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom07_Y1X0_Tiles
    dfar KeyWorldRoom01_Y0X1_Tiles
    dfar KeyWorldRoom07_Y1X2_Tiles
    dfar KeyWorldRoom01_Y1X2_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom07_Y1X0_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom01_Y3X1_Tiles
    dfar KeyWorldRoom00_Y0X2_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom00_Y0X2_Attrs
    dfar KeyWorldRoom01_Y0X1_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom07_Y1X0_Attrs
    dfar KeyWorldRoom01_Y0X1_Attrs
    dfar KeyWorldRoom07_Y1X2_Attrs
    dfar KeyWorldRoom01_Y1X2_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom07_Y1X0_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom01_Y3X1_Attrs
    dfar KeyWorldRoom00_Y0X2_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
KeyWorldRoom08:: ; heuristic: key-world room record; C0
Data_072_4499:: ; address name
    db $00, $01, $03 ; id 8
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom08_Y0X1_Tiles
    dfar KeyWorldRoom08_Y0X2_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom08_Y1X0_Tiles
    dfar KeyWorldRoom08_Y1X1_Tiles
    dfar KeyWorldRoom08_Y1X2_Tiles
    dfar KeyWorldRoom08_Y1X3_Tiles
    dfar KeyWorldRoom08_Y2X0_Tiles
    dfar KeyWorldRoom08_Y2X1_Tiles
    dfar KeyWorldRoom06_Y1X1_Tiles
    dfar KeyWorldRoom01_Y2X1_Tiles
    dfar KeyWorldRoom05_Y1X1_Tiles
    dfar KeyWorldRoom08_Y3X1_Tiles
    dfar KeyWorldRoom01_Y2X2_Tiles
    dfar KeyWorldRoom08_Y3X3_Tiles
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom08_Y0X1_Attrs
    dfar KeyWorldRoom08_Y0X2_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom08_Y1X0_Attrs
    dfar KeyWorldRoom08_Y1X1_Attrs
    dfar KeyWorldRoom08_Y1X2_Attrs
    dfar KeyWorldRoom08_Y1X3_Attrs
    dfar KeyWorldRoom08_Y2X0_Attrs
    dfar KeyWorldRoom08_Y2X1_Attrs
    dfar KeyWorldRoom06_Y1X1_Attrs
    dfar KeyWorldRoom01_Y2X1_Attrs
    dfar KeyWorldRoom05_Y1X1_Attrs
    dfar KeyWorldRoom08_Y3X1_Attrs
    dfar KeyWorldRoom01_Y2X2_Attrs
    dfar KeyWorldRoom08_Y3X3_Attrs
KeyWorldRoom09:: ; heuristic: string; C0
    db $00, $01, $03 ; id 9
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom09_Y0X1_Tiles
    dfar KeyWorldRoom03_Y0X1_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom02_Y2X0_Tiles
    dfar KeyWorldRoom09_Y1X1_Tiles
    dfar KeyWorldRoom09_Y1X2_Tiles
    dfar KeyWorldRoom03_Y1X0_Tiles
    dfar KeyWorldRoom03_Y1X3_Tiles
    dfar KeyWorldRoom09_Y2X1_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom01_Y3X0_Tiles
    dfar KeyWorldRoom09_Y3X1_Tiles
    dfar KeyWorldRoom03_Y0X2_Tiles
    dfar KeyWorldRoom02_Y3X3_Tiles
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom09_Y0X1_Attrs
    dfar KeyWorldRoom03_Y0X1_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom02_Y2X0_Attrs
    dfar KeyWorldRoom09_Y1X1_Attrs
    dfar KeyWorldRoom09_Y1X2_Attrs
    dfar KeyWorldRoom03_Y1X0_Attrs
    dfar KeyWorldRoom03_Y1X3_Attrs
    dfar KeyWorldRoom09_Y2X1_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom01_Y3X0_Attrs
    dfar KeyWorldRoom09_Y3X1_Attrs
    dfar KeyWorldRoom03_Y0X2_Attrs
    dfar KeyWorldRoom02_Y3X3_Attrs
KeyWorldRoom0A:: ; heuristic: string; C0
    db $00, $01, $03 ; id 10
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom0A_Y0X1_Tiles
    dfar KeyWorldRoom0A_Y0X2_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom02_Y2X1_Tiles
    dfar KeyWorldRoom0A_Y1X1_Tiles
    dfar KeyWorldRoom0A_Y1X2_Tiles
    dfar KeyWorldRoom0A_Y1X3_Tiles
    dfar KeyWorldRoom0A_Y2X0_Tiles
    dfar KeyWorldRoom0A_Y2X1_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom02_Y1X2_Tiles
    dfar KeyWorldRoom02_Y3X0_Tiles
    dfar KeyWorldRoom0A_Y3X1_Tiles
    dfar KeyWorldRoom0A_Y3X2_Tiles
    dfar KeyWorldRoom03_Y2X3_Tiles
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom0A_Y0X1_Attrs
    dfar KeyWorldRoom0A_Y0X2_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom02_Y2X1_Attrs
    dfar KeyWorldRoom0A_Y1X1_Attrs
    dfar KeyWorldRoom0A_Y1X2_Attrs
    dfar KeyWorldRoom0A_Y1X3_Attrs
    dfar KeyWorldRoom0A_Y2X0_Attrs
    dfar KeyWorldRoom0A_Y2X1_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom02_Y1X2_Attrs
    dfar KeyWorldRoom02_Y3X0_Attrs
    dfar KeyWorldRoom0A_Y3X1_Attrs
    dfar KeyWorldRoom0A_Y3X2_Attrs
    dfar KeyWorldRoom03_Y2X3_Attrs
KeyWorldRoom0B:: ; heuristic: string; C0
    db $00, $01, $03 ; id 11
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom03_Y1X2_Tiles
    dfar KeyWorldRoom0B_Y0X2_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom03_Y2X1_Tiles
    dfar KeyWorldRoom0B_Y1X1_Tiles
    dfar KeyWorldRoom07_Y1X0_Tiles
    dfar KeyWorldRoom01_Y2X3_Tiles
    dfar KeyWorldRoom0B_Y2X0_Tiles
    dfar KeyWorldRoom0B_Y2X1_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom02_Y1X3_Tiles
    dfar KeyWorldRoom0B_Y3X0_Tiles
    dfar KeyWorldRoom03_Y3X0_Tiles
    dfar KeyWorldRoom03_Y3X1_Tiles
    dfar KeyWorldRoom04_Y3X3_Tiles
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom03_Y1X2_Attrs
    dfar KeyWorldRoom0B_Y0X2_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom03_Y2X1_Attrs
    dfar KeyWorldRoom0B_Y1X1_Attrs
    dfar KeyWorldRoom07_Y1X0_Attrs
    dfar KeyWorldRoom01_Y2X3_Attrs
    dfar KeyWorldRoom0B_Y2X0_Attrs
    dfar KeyWorldRoom0B_Y2X1_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
    dfar KeyWorldRoom02_Y1X3_Attrs
    dfar KeyWorldRoom0B_Y3X0_Attrs
    dfar KeyWorldRoom03_Y3X0_Attrs
    dfar KeyWorldRoom03_Y3X1_Attrs
    dfar KeyWorldRoom04_Y3X3_Attrs
KeyWorldRoom0C:: ; heuristic: key-world room record; C0
Data_072_4625:: ; address name
    db $00, $01, $03 ; id 12
    dfar KeyWorldRoom02_Y0X1_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom02_Y0X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom06_Y1X1_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X1_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom02_Y0X1_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom02_Y0X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom06_Y1X1_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X1_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
KeyWorldRoom0D:: ; heuristic: key-world room record; C0
Data_072_4688:: ; address name
    db $00, $01, $03 ; id 13
    dfar KeyWorldRoom04_Y0X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom04_Y0X0_Tiles
    dfar KeyWorldRoom0D_Y1X0_Tiles
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom0D_Y1X2_Tiles
    dfar KeyWorldRoom0A_Y1X1_Tiles
    dfar KeyWorldRoom02_Y3X0_Tiles
    dfar KeyWorldRoom01_Y1X2_Tiles
    dfar KeyWorldRoom04_Y1X1_Tiles
    dfar KeyWorldRoom02_Y3X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom0D_Y3X1_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom04_Y0X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom04_Y0X0_Attrs
    dfar KeyWorldRoom0D_Y1X0_Attrs
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom0D_Y1X2_Attrs
    dfar KeyWorldRoom0A_Y1X1_Attrs
    dfar KeyWorldRoom02_Y3X0_Attrs
    dfar KeyWorldRoom01_Y1X2_Attrs
    dfar KeyWorldRoom04_Y1X1_Attrs
    dfar KeyWorldRoom02_Y3X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom0D_Y3X1_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
KeyWorldRoom0E:: ; heuristic: key-world room record; C0
Data_072_46EB:: ; address name
    db $00, $01, $04 ; id 14
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom00_Y0X3_Tiles
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom00_Y0X3_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom01_Y1X2_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom07_Y1X2_Tiles
    dfar KeyWorldRoom01_Y1X2_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom05_Y1X1_Tiles
    dfar KeyWorldRoom00_Y3X3_Tiles
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom00_Y0X3_Attrs
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom00_Y0X3_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom01_Y1X2_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom07_Y1X2_Attrs
    dfar KeyWorldRoom01_Y1X2_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
    dfar KeyWorldRoom05_Y1X1_Attrs
    dfar KeyWorldRoom00_Y3X3_Attrs
KeyWorldRoom0F:: ; heuristic: string; C0
    db $00, $01, $04 ; id 15
    dfar KeyWorldRoom04_Y1X1_Tiles
    dfar KeyWorldRoom00_Y0X3_Tiles
    dfar KeyWorldRoom0F_Y0X2_Tiles
    dfar KeyWorldRoom0F_Y0X3_Tiles
    dfar KeyWorldRoom0F_Y1X0_Tiles
    dfar KeyWorldRoom00_Y3X1_Tiles
    dfar KeyWorldRoom02_Y2X2_Tiles
    dfar KeyWorldRoom01_Y2X1_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom06_Y1X1_Tiles
    dfar KeyWorldRoom08_Y0X1_Tiles
    dfar KeyWorldRoom08_Y1X3_Tiles
    dfar KeyWorldRoom04_Y1X1_Tiles
    dfar KeyWorldRoom08_Y3X3_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom06_Y0X1_Tiles
    dfar KeyWorldRoom04_Y1X1_Attrs
    dfar KeyWorldRoom00_Y0X3_Attrs
    dfar KeyWorldRoom0F_Y0X2_Attrs
    dfar KeyWorldRoom0F_Y0X3_Attrs
    dfar KeyWorldRoom0F_Y1X0_Attrs
    dfar KeyWorldRoom00_Y3X1_Attrs
    dfar KeyWorldRoom02_Y2X2_Attrs
    dfar KeyWorldRoom01_Y2X1_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom06_Y1X1_Attrs
    dfar KeyWorldRoom08_Y0X1_Attrs
    dfar KeyWorldRoom08_Y1X3_Attrs
    dfar KeyWorldRoom04_Y1X1_Attrs
    dfar KeyWorldRoom08_Y3X3_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom06_Y0X1_Attrs
KeyWorldRoom10:: ; heuristic: string; C0
    db $00, $01, $04 ; id 16
    dfar KeyWorldRoom04_Y0X0_Tiles
    dfar KeyWorldRoom10_Y0X1_Tiles
    dfar KeyWorldRoom10_Y0X2_Tiles
    dfar KeyWorldRoom04_Y0X0_Tiles
    dfar KeyWorldRoom01_Y2X2_Tiles
    dfar KeyWorldRoom02_Y2X3_Tiles
    dfar KeyWorldRoom02_Y1X0_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom10_Y2X0_Tiles
    dfar KeyWorldRoom10_Y2X1_Tiles
    dfar KeyWorldRoom10_Y2X2_Tiles
    dfar KeyWorldRoom10_Y2X3_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom02_Y2X1_Tiles
    dfar KeyWorldRoom02_Y3X3_Tiles
    dfar KeyWorldRoom04_Y0X0_Attrs
    dfar KeyWorldRoom10_Y0X1_Attrs
    dfar KeyWorldRoom10_Y0X2_Attrs
    dfar KeyWorldRoom04_Y0X0_Attrs
    dfar KeyWorldRoom01_Y2X2_Attrs
    dfar KeyWorldRoom02_Y2X3_Attrs
    dfar KeyWorldRoom02_Y1X0_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
    dfar KeyWorldRoom10_Y2X0_Attrs
    dfar KeyWorldRoom10_Y2X1_Attrs
    dfar KeyWorldRoom10_Y2X2_Attrs
    dfar KeyWorldRoom10_Y2X3_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
    dfar KeyWorldRoom02_Y2X1_Attrs
    dfar KeyWorldRoom02_Y3X3_Attrs
KeyWorldRoom11:: ; heuristic: string; C0
    db $00, $01, $04 ; id 17
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom09_Y1X2_Tiles
    dfar KeyWorldRoom11_Y0X2_Tiles
    dfar KeyWorldRoom04_Y0X0_Tiles
    dfar KeyWorldRoom02_Y3X0_Tiles
    dfar KeyWorldRoom03_Y2X2_Tiles
    dfar KeyWorldRoom11_Y1X2_Tiles
    dfar KeyWorldRoom04_Y1X3_Tiles
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom11_Y2X1_Tiles
    dfar KeyWorldRoom11_Y2X2_Tiles
    dfar KeyWorldRoom02_Y2X0_Tiles
    dfar KeyWorldRoom00_Y3X3_Tiles
    dfar KeyWorldRoom03_Y2X1_Tiles
    dfar KeyWorldRoom03_Y3X2_Tiles
    dfar KeyWorldRoom03_Y2X3_Tiles
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom09_Y1X2_Attrs
    dfar KeyWorldRoom11_Y0X2_Attrs
    dfar KeyWorldRoom04_Y0X0_Attrs
    dfar KeyWorldRoom02_Y3X0_Attrs
    dfar KeyWorldRoom03_Y2X2_Attrs
    dfar KeyWorldRoom11_Y1X2_Attrs
    dfar KeyWorldRoom04_Y1X3_Attrs
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom11_Y2X1_Attrs
    dfar KeyWorldRoom11_Y2X2_Attrs
    dfar KeyWorldRoom02_Y2X0_Attrs
    dfar KeyWorldRoom00_Y3X3_Attrs
    dfar KeyWorldRoom03_Y2X1_Attrs
    dfar KeyWorldRoom03_Y3X2_Attrs
    dfar KeyWorldRoom03_Y2X3_Attrs
KeyWorldRoom12:: ; heuristic: key-world room record; C0
Data_072_4877:: ; address name
    db $00, $01, $04 ; id 18
    dfar KeyWorldRoom02_Y0X0_Tiles
    dfar KeyWorldRoom0B_Y0X2_Tiles
    dfar KeyWorldRoom03_Y1X2_Tiles
    dfar KeyWorldRoom04_Y0X0_Tiles
    dfar KeyWorldRoom03_Y3X0_Tiles
    dfar KeyWorldRoom0A_Y1X1_Tiles
    dfar KeyWorldRoom08_Y1X0_Tiles
    dfar KeyWorldRoom04_Y2X2_Tiles
    dfar KeyWorldRoom0B_Y2X0_Tiles
    dfar KeyWorldRoom0A_Y1X3_Tiles
    dfar KeyWorldRoom08_Y2X0_Tiles
    dfar KeyWorldRoom12_Y2X3_Tiles
    dfar KeyWorldRoom00_Y3X3_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom04_Y3X3_Tiles
    dfar KeyWorldRoom12_Y3X3_Tiles
    dfar KeyWorldRoom02_Y0X0_Attrs
    dfar KeyWorldRoom0B_Y0X2_Attrs
    dfar KeyWorldRoom03_Y1X2_Attrs
    dfar KeyWorldRoom04_Y0X0_Attrs
    dfar KeyWorldRoom03_Y3X0_Attrs
    dfar KeyWorldRoom0A_Y1X1_Attrs
    dfar KeyWorldRoom08_Y1X0_Attrs
    dfar KeyWorldRoom04_Y2X2_Attrs
    dfar KeyWorldRoom0B_Y2X0_Attrs
    dfar KeyWorldRoom0A_Y1X3_Attrs
    dfar KeyWorldRoom08_Y2X0_Attrs
    dfar KeyWorldRoom12_Y2X3_Attrs
    dfar KeyWorldRoom00_Y3X3_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom04_Y3X3_Attrs
    dfar KeyWorldRoom12_Y3X3_Attrs
KeyWorldRoom13:: ; heuristic: key-world room record; C0
Data_072_48DA:: ; address name
    db $00, $01, $04 ; id 19
    dfar KeyWorldRoom02_Y0X1_Tiles
    dfar KeyWorldRoom01_Y0X1_Tiles
    dfar KeyWorldRoom03_Y0X2_Tiles
    dfar KeyWorldRoom00_Y3X2_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom0B_Y0X2_Tiles
    dfar KeyWorldRoom04_Y2X2_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X1_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom02_Y0X1_Attrs
    dfar KeyWorldRoom01_Y0X1_Attrs
    dfar KeyWorldRoom03_Y0X2_Attrs
    dfar KeyWorldRoom00_Y3X2_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom0B_Y0X2_Attrs
    dfar KeyWorldRoom04_Y2X2_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X1_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
KeyWorldRoom14:: ; heuristic: key-world room record; C0
Data_072_493D:: ; address name
    db $00, $01, $04 ; id 20
    dfar KeyWorldRoom04_Y1X1_Tiles
    dfar KeyWorldRoom01_Y0X1_Tiles
    dfar KeyWorldRoom05_Y0X1_Tiles
    dfar KeyWorldRoom0F_Y0X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom14_Y1X1_Tiles
    dfar KeyWorldRoom01_Y1X2_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom14_Y2X1_Tiles
    dfar KeyWorldRoom08_Y2X1_Tiles
    dfar KeyWorldRoom06_Y0X1_Tiles
    dfar KeyWorldRoom04_Y1X1_Tiles
    dfar KeyWorldRoom03_Y3X2_Tiles
    dfar KeyWorldRoom04_Y2X2_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom04_Y1X1_Attrs
    dfar KeyWorldRoom01_Y0X1_Attrs
    dfar KeyWorldRoom05_Y0X1_Attrs
    dfar KeyWorldRoom0F_Y0X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom14_Y1X1_Attrs
    dfar KeyWorldRoom01_Y1X2_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom14_Y2X1_Attrs
    dfar KeyWorldRoom08_Y2X1_Attrs
    dfar KeyWorldRoom06_Y0X1_Attrs
    dfar KeyWorldRoom04_Y1X1_Attrs
    dfar KeyWorldRoom03_Y3X2_Attrs
    dfar KeyWorldRoom04_Y2X2_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
KeyWorldRoom15:: ; heuristic: key-world room record; C0
Data_072_49A0:: ; address name
    db $00, $01, $05 ; id 21
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom0F_Y0X3_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom08_Y1X1_Tiles
    dfar KeyWorldRoom00_Y3X1_Tiles
    dfar KeyWorldRoom00_Y3X2_Tiles
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom07_Y1X2_Tiles
    dfar KeyWorldRoom01_Y0X1_Tiles
    dfar KeyWorldRoom0F_Y0X3_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom00_Y3X2_Tiles
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom0F_Y0X3_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom08_Y1X1_Attrs
    dfar KeyWorldRoom00_Y3X1_Attrs
    dfar KeyWorldRoom00_Y3X2_Attrs
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom07_Y1X2_Attrs
    dfar KeyWorldRoom01_Y0X1_Attrs
    dfar KeyWorldRoom0F_Y0X3_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom00_Y3X2_Attrs
KeyWorldRoom16:: ; heuristic: key-world room record; C0
Data_072_4A03:: ; address name
    db $00, $01, $05 ; id 22
    dfar KeyWorldRoom04_Y1X1_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom0F_Y0X2_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom0F_Y1X0_Tiles
    dfar KeyWorldRoom08_Y1X3_Tiles
    dfar KeyWorldRoom09_Y1X1_Tiles
    dfar KeyWorldRoom08_Y3X3_Tiles
    dfar KeyWorldRoom03_Y1X0_Tiles
    dfar KeyWorldRoom04_Y1X1_Tiles
    dfar KeyWorldRoom16_Y2X2_Tiles
    dfar KeyWorldRoom16_Y2X3_Tiles
    dfar KeyWorldRoom01_Y2X2_Tiles
    dfar KeyWorldRoom04_Y0X2_Tiles
    dfar KeyWorldRoom08_Y1X2_Tiles
    dfar KeyWorldRoom0F_Y0X3_Tiles
    dfar KeyWorldRoom04_Y1X1_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom0F_Y0X2_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom0F_Y1X0_Attrs
    dfar KeyWorldRoom08_Y1X3_Attrs
    dfar KeyWorldRoom09_Y1X1_Attrs
    dfar KeyWorldRoom08_Y3X3_Attrs
    dfar KeyWorldRoom03_Y1X0_Attrs
    dfar KeyWorldRoom04_Y1X1_Attrs
    dfar KeyWorldRoom16_Y2X2_Attrs
    dfar KeyWorldRoom16_Y2X3_Attrs
    dfar KeyWorldRoom01_Y2X2_Attrs
    dfar KeyWorldRoom04_Y0X2_Attrs
    dfar KeyWorldRoom08_Y1X2_Attrs
    dfar KeyWorldRoom0F_Y0X3_Attrs
KeyWorldRoom17:: ; heuristic: string; C0
    db $00, $01, $05 ; id 23
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom10_Y2X3_Tiles
    dfar KeyWorldRoom10_Y0X2_Tiles
    dfar KeyWorldRoom04_Y0X0_Tiles
    dfar KeyWorldRoom09_Y2X1_Tiles
    dfar KeyWorldRoom0A_Y2X1_Tiles
    dfar KeyWorldRoom03_Y1X3_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom0A_Y1X2_Tiles
    dfar KeyWorldRoom08_Y1X1_Tiles
    dfar KeyWorldRoom08_Y2X1_Tiles
    dfar KeyWorldRoom01_Y1X2_Tiles
    dfar KeyWorldRoom01_Y3X0_Tiles
    dfar KeyWorldRoom09_Y3X1_Tiles
    dfar KeyWorldRoom0A_Y3X1_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom10_Y2X3_Attrs
    dfar KeyWorldRoom10_Y0X2_Attrs
    dfar KeyWorldRoom04_Y0X0_Attrs
    dfar KeyWorldRoom09_Y2X1_Attrs
    dfar KeyWorldRoom0A_Y2X1_Attrs
    dfar KeyWorldRoom03_Y1X3_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom0A_Y1X2_Attrs
    dfar KeyWorldRoom08_Y1X1_Attrs
    dfar KeyWorldRoom08_Y2X1_Attrs
    dfar KeyWorldRoom01_Y1X2_Attrs
    dfar KeyWorldRoom01_Y3X0_Attrs
    dfar KeyWorldRoom09_Y3X1_Attrs
    dfar KeyWorldRoom0A_Y3X1_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
KeyWorldRoom18:: ; heuristic: string; C0
    db $00, $01, $05 ; id 24
    dfar KeyWorldRoom04_Y0X0_Tiles
    dfar KeyWorldRoom0A_Y2X0_Tiles
    dfar KeyWorldRoom08_Y0X2_Tiles
    dfar KeyWorldRoom0F_Y0X3_Tiles
    dfar KeyWorldRoom00_Y2X1_Tiles
    dfar KeyWorldRoom01_Y2X3_Tiles
    dfar KeyWorldRoom01_Y1X3_Tiles
    dfar KeyWorldRoom11_Y0X2_Tiles
    dfar KeyWorldRoom02_Y1X0_Tiles
    dfar KeyWorldRoom02_Y2X3_Tiles
    dfar KeyWorldRoom08_Y1X0_Tiles
    dfar KeyWorldRoom04_Y1X3_Tiles
    dfar KeyWorldRoom02_Y2X1_Tiles
    dfar KeyWorldRoom02_Y3X3_Tiles
    dfar KeyWorldRoom02_Y3X0_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom04_Y0X0_Attrs
    dfar KeyWorldRoom0A_Y2X0_Attrs
    dfar KeyWorldRoom08_Y0X2_Attrs
    dfar KeyWorldRoom0F_Y0X3_Attrs
    dfar KeyWorldRoom00_Y2X1_Attrs
    dfar KeyWorldRoom01_Y2X3_Attrs
    dfar KeyWorldRoom01_Y1X3_Attrs
    dfar KeyWorldRoom11_Y0X2_Attrs
    dfar KeyWorldRoom02_Y1X0_Attrs
    dfar KeyWorldRoom02_Y2X3_Attrs
    dfar KeyWorldRoom08_Y1X0_Attrs
    dfar KeyWorldRoom04_Y1X3_Attrs
    dfar KeyWorldRoom02_Y2X1_Attrs
    dfar KeyWorldRoom02_Y3X3_Attrs
    dfar KeyWorldRoom02_Y3X0_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
KeyWorldRoom19:: ; heuristic: string; C0
    db $00, $01, $05 ; id 25
    dfar KeyWorldRoom04_Y1X1_Tiles
    dfar KeyWorldRoom09_Y1X2_Tiles
    dfar KeyWorldRoom19_Y0X2_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom19_Y1X0_Tiles
    dfar KeyWorldRoom03_Y2X1_Tiles
    dfar KeyWorldRoom03_Y1X2_Tiles
    dfar KeyWorldRoom02_Y1X2_Tiles
    dfar KeyWorldRoom02_Y1X3_Tiles
    dfar KeyWorldRoom04_Y0X0_Tiles
    dfar KeyWorldRoom03_Y3X0_Tiles
    dfar KeyWorldRoom0A_Y1X1_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom0A_Y3X2_Tiles
    dfar KeyWorldRoom00_Y0X1_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom04_Y1X1_Attrs
    dfar KeyWorldRoom09_Y1X2_Attrs
    dfar KeyWorldRoom19_Y0X2_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom19_Y1X0_Attrs
    dfar KeyWorldRoom03_Y2X1_Attrs
    dfar KeyWorldRoom03_Y1X2_Attrs
    dfar KeyWorldRoom02_Y1X2_Attrs
    dfar KeyWorldRoom02_Y1X3_Attrs
    dfar KeyWorldRoom04_Y0X0_Attrs
    dfar KeyWorldRoom03_Y3X0_Attrs
    dfar KeyWorldRoom0A_Y1X1_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom0A_Y3X2_Attrs
    dfar KeyWorldRoom00_Y0X1_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
KeyWorldRoom1A:: ; heuristic: key-world room record; C0
Data_072_4B8F:: ; address name
    db $00, $01, $05 ; id 26
    dfar KeyWorldRoom02_Y0X1_Tiles
    dfar KeyWorldRoom00_Y0X1_Tiles
    dfar KeyWorldRoom03_Y1X2_Tiles
    dfar KeyWorldRoom02_Y0X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom02_Y3X0_Tiles
    dfar KeyWorldRoom02_Y2X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom0D_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X1_Tiles
    dfar KeyWorldRoom02_Y0X1_Attrs
    dfar KeyWorldRoom00_Y0X1_Attrs
    dfar KeyWorldRoom03_Y1X2_Attrs
    dfar KeyWorldRoom02_Y0X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom02_Y3X0_Attrs
    dfar KeyWorldRoom02_Y2X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom0D_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X1_Attrs
KeyWorldRoom1B:: ; heuristic: key-world room record; C0
Data_072_4BF2:: ; address name
    db $00, $01, $05 ; id 27
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom1B_Y0X1_Tiles
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom00_Y0X3_Tiles
    dfar KeyWorldRoom14_Y1X1_Tiles
    dfar KeyWorldRoom01_Y1X2_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom1B_Y2X1_Tiles
    dfar KeyWorldRoom00_Y0X3_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom1B_Y3X1_Tiles
    dfar KeyWorldRoom01_Y3X1_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom1B_Y0X1_Attrs
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom00_Y0X3_Attrs
    dfar KeyWorldRoom14_Y1X1_Attrs
    dfar KeyWorldRoom01_Y1X2_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom1B_Y2X1_Attrs
    dfar KeyWorldRoom00_Y0X3_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom1B_Y3X1_Attrs
    dfar KeyWorldRoom01_Y3X1_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
KeyWorldRoom1C:: ; heuristic: key-world room record; C0
Data_072_4C55:: ; address name
    db $00, $02, $03 ; id 28
    dfar KeyWorldRoom04_Y0X0_Tiles
    dfar KeyWorldRoom02_Y0X0_Tiles
    dfar KeyWorldRoom04_Y0X0_Tiles
    dfar KeyWorldRoom02_Y0X0_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom07_Y1X0_Tiles
    dfar KeyWorldRoom08_Y1X1_Tiles
    dfar KeyWorldRoom00_Y3X1_Tiles
    dfar KeyWorldRoom01_Y1X2_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom00_Y3X1_Tiles
    dfar KeyWorldRoom00_Y0X1_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom04_Y0X0_Attrs
    dfar KeyWorldRoom02_Y0X0_Attrs
    dfar KeyWorldRoom04_Y0X0_Attrs
    dfar KeyWorldRoom02_Y0X0_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom07_Y1X0_Attrs
    dfar KeyWorldRoom08_Y1X1_Attrs
    dfar KeyWorldRoom00_Y3X1_Attrs
    dfar KeyWorldRoom01_Y1X2_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom00_Y3X1_Attrs
    dfar KeyWorldRoom00_Y0X1_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
KeyWorldRoom1D:: ; heuristic: string; C0
    db $00, $02, $03 ; id 29
    dfar KeyWorldRoom04_Y1X1_Tiles
    dfar KeyWorldRoom1D_Y0X1_Tiles
    dfar KeyWorldRoom12_Y2X3_Tiles
    dfar KeyWorldRoom1D_Y0X3_Tiles
    dfar KeyWorldRoom1B_Y3X1_Tiles
    dfar KeyWorldRoom07_Y1X2_Tiles
    dfar KeyWorldRoom00_Y3X1_Tiles
    dfar KeyWorldRoom0A_Y1X3_Tiles
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom04_Y3X3_Tiles
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom0A_Y2X1_Tiles
    dfar KeyWorldRoom00_Y3X3_Tiles
    dfar KeyWorldRoom1D_Y3X1_Tiles
    dfar KeyWorldRoom02_Y2X2_Tiles
    dfar KeyWorldRoom02_Y3X3_Tiles
    dfar KeyWorldRoom04_Y1X1_Attrs
    dfar KeyWorldRoom1D_Y0X1_Attrs
    dfar KeyWorldRoom12_Y2X3_Attrs
    dfar KeyWorldRoom1D_Y0X3_Attrs
    dfar KeyWorldRoom1B_Y3X1_Attrs
    dfar KeyWorldRoom07_Y1X2_Attrs
    dfar KeyWorldRoom00_Y3X1_Attrs
    dfar KeyWorldRoom0A_Y1X3_Attrs
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom04_Y3X3_Attrs
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom0A_Y2X1_Attrs
    dfar KeyWorldRoom00_Y3X3_Attrs
    dfar KeyWorldRoom1D_Y3X1_Attrs
    dfar KeyWorldRoom02_Y2X2_Attrs
    dfar KeyWorldRoom02_Y3X3_Attrs
KeyWorldRoom1E:: ; heuristic: string; C0
    db $00, $02, $03 ; id 30
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom1E_Y0X1_Tiles
    dfar KeyWorldRoom0F_Y0X2_Tiles
    dfar KeyWorldRoom00_Y0X3_Tiles
    dfar KeyWorldRoom02_Y2X0_Tiles
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom10_Y2X1_Tiles
    dfar KeyWorldRoom08_Y1X3_Tiles
    dfar KeyWorldRoom08_Y2X0_Tiles
    dfar KeyWorldRoom0B_Y1X1_Tiles
    dfar KeyWorldRoom07_Y1X0_Tiles
    dfar KeyWorldRoom01_Y2X1_Tiles
    dfar KeyWorldRoom08_Y3X1_Tiles
    dfar KeyWorldRoom01_Y3X0_Tiles
    dfar KeyWorldRoom03_Y2X2_Tiles
    dfar KeyWorldRoom08_Y3X3_Tiles
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom1E_Y0X1_Attrs
    dfar KeyWorldRoom0F_Y0X2_Attrs
    dfar KeyWorldRoom00_Y0X3_Attrs
    dfar KeyWorldRoom02_Y2X0_Attrs
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom10_Y2X1_Attrs
    dfar KeyWorldRoom08_Y1X3_Attrs
    dfar KeyWorldRoom08_Y2X0_Attrs
    dfar KeyWorldRoom0B_Y1X1_Attrs
    dfar KeyWorldRoom07_Y1X0_Attrs
    dfar KeyWorldRoom01_Y2X1_Attrs
    dfar KeyWorldRoom08_Y3X1_Attrs
    dfar KeyWorldRoom01_Y3X0_Attrs
    dfar KeyWorldRoom03_Y2X2_Attrs
    dfar KeyWorldRoom08_Y3X3_Attrs
KeyWorldRoom1F:: ; heuristic: string; C0
    db $00, $02, $03 ; id 31
    dfar KeyWorldRoom04_Y1X1_Tiles
    dfar KeyWorldRoom00_Y0X2_Tiles
    dfar KeyWorldRoom09_Y0X1_Tiles
    dfar KeyWorldRoom10_Y2X3_Tiles
    dfar KeyWorldRoom02_Y0X1_Tiles
    dfar KeyWorldRoom00_Y0X2_Tiles
    dfar KeyWorldRoom10_Y2X2_Tiles
    dfar KeyWorldRoom01_Y2X3_Tiles
    dfar KeyWorldRoom10_Y2X0_Tiles
    dfar KeyWorldRoom0A_Y0X1_Tiles
    dfar KeyWorldRoom07_Y1X2_Tiles
    dfar KeyWorldRoom02_Y2X3_Tiles
    dfar KeyWorldRoom02_Y2X1_Tiles
    dfar KeyWorldRoom08_Y1X2_Tiles
    dfar KeyWorldRoom09_Y3X1_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom04_Y1X1_Attrs
    dfar KeyWorldRoom00_Y0X2_Attrs
    dfar KeyWorldRoom09_Y0X1_Attrs
    dfar KeyWorldRoom10_Y2X3_Attrs
    dfar KeyWorldRoom02_Y0X1_Attrs
    dfar KeyWorldRoom00_Y0X2_Attrs
    dfar KeyWorldRoom10_Y2X2_Attrs
    dfar KeyWorldRoom01_Y2X3_Attrs
    dfar KeyWorldRoom10_Y2X0_Attrs
    dfar KeyWorldRoom0A_Y0X1_Attrs
    dfar KeyWorldRoom07_Y1X2_Attrs
    dfar KeyWorldRoom02_Y2X3_Attrs
    dfar KeyWorldRoom02_Y2X1_Attrs
    dfar KeyWorldRoom08_Y1X2_Attrs
    dfar KeyWorldRoom09_Y3X1_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
KeyWorldRoom20:: ; heuristic: key-world room record; C0
Data_072_4DE1:: ; address name
    db $00, $02, $03 ; id 32
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom03_Y0X1_Tiles
    dfar KeyWorldRoom0A_Y0X2_Tiles
    dfar KeyWorldRoom09_Y1X2_Tiles
    dfar KeyWorldRoom0B_Y3X0_Tiles
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom02_Y3X3_Tiles
    dfar KeyWorldRoom03_Y1X0_Tiles
    dfar KeyWorldRoom0B_Y0X2_Tiles
    dfar KeyWorldRoom03_Y2X3_Tiles
    dfar KeyWorldRoom04_Y1X1_Tiles
    dfar KeyWorldRoom04_Y1X3_Tiles
    dfar KeyWorldRoom11_Y2X2_Tiles
    dfar KeyWorldRoom19_Y0X2_Tiles
    dfar KeyWorldRoom03_Y0X2_Tiles
    dfar KeyWorldRoom04_Y2X2_Tiles
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom03_Y0X1_Attrs
    dfar KeyWorldRoom0A_Y0X2_Attrs
    dfar KeyWorldRoom09_Y1X2_Attrs
    dfar KeyWorldRoom0B_Y3X0_Attrs
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom02_Y3X3_Attrs
    dfar KeyWorldRoom03_Y1X0_Attrs
    dfar KeyWorldRoom0B_Y0X2_Attrs
    dfar KeyWorldRoom03_Y2X3_Attrs
    dfar KeyWorldRoom04_Y1X1_Attrs
    dfar KeyWorldRoom04_Y1X3_Attrs
    dfar KeyWorldRoom11_Y2X2_Attrs
    dfar KeyWorldRoom19_Y0X2_Attrs
    dfar KeyWorldRoom03_Y0X2_Attrs
    dfar KeyWorldRoom04_Y2X2_Attrs
KeyWorldRoom21:: ; heuristic: key-world room record; C0
Data_072_4E44:: ; address name
    db $00, $02, $03 ; id 33
    dfar KeyWorldRoom02_Y0X1_Tiles
    dfar KeyWorldRoom00_Y0X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom00_Y3X2_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom02_Y0X1_Attrs
    dfar KeyWorldRoom00_Y0X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom00_Y3X2_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
KeyWorldRoom22:: ; heuristic: key-world room record; C0
Data_072_4EA7:: ; address name
    db $00, $02, $03 ; id 34
    dfar KeyWorldRoom04_Y1X1_Tiles
    dfar KeyWorldRoom02_Y3X2_Tiles
    dfar KeyWorldRoom00_Y0X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom22_Y1X2_Tiles
    dfar KeyWorldRoom03_Y1X2_Tiles
    dfar KeyWorldRoom04_Y0X1_Tiles
    dfar KeyWorldRoom22_Y2X1_Tiles
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom04_Y3X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom02_Y3X0_Tiles
    dfar KeyWorldRoom03_Y2X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom04_Y1X1_Attrs
    dfar KeyWorldRoom02_Y3X2_Attrs
    dfar KeyWorldRoom00_Y0X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom22_Y1X2_Attrs
    dfar KeyWorldRoom03_Y1X2_Attrs
    dfar KeyWorldRoom04_Y0X1_Attrs
    dfar KeyWorldRoom22_Y2X1_Attrs
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom04_Y3X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom02_Y3X0_Attrs
    dfar KeyWorldRoom03_Y2X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
KeyWorldRoom23:: ; heuristic: key-world room record; C0
Data_072_4F0A:: ; address name
    db $00, $02, $04 ; id 35
    dfar KeyWorldRoom02_Y0X1_Tiles
    dfar KeyWorldRoom00_Y0X2_Tiles
    dfar KeyWorldRoom01_Y0X1_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom04_Y1X1_Tiles
    dfar KeyWorldRoom01_Y0X1_Tiles
    dfar KeyWorldRoom07_Y1X2_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom02_Y0X0_Tiles
    dfar KeyWorldRoom00_Y3X3_Tiles
    dfar KeyWorldRoom00_Y2X1_Tiles
    dfar KeyWorldRoom0F_Y0X3_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom00_Y0X1_Tiles
    dfar KeyWorldRoom00_Y3X1_Tiles
    dfar KeyWorldRoom00_Y3X2_Tiles
    dfar KeyWorldRoom02_Y0X1_Attrs
    dfar KeyWorldRoom00_Y0X2_Attrs
    dfar KeyWorldRoom01_Y0X1_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom04_Y1X1_Attrs
    dfar KeyWorldRoom01_Y0X1_Attrs
    dfar KeyWorldRoom07_Y1X2_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
    dfar KeyWorldRoom02_Y0X0_Attrs
    dfar KeyWorldRoom00_Y3X3_Attrs
    dfar KeyWorldRoom00_Y2X1_Attrs
    dfar KeyWorldRoom0F_Y0X3_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom00_Y0X1_Attrs
    dfar KeyWorldRoom00_Y3X1_Attrs
    dfar KeyWorldRoom00_Y3X2_Attrs
KeyWorldRoom24:: ; heuristic: key-world room record; C0
Data_072_4F6D:: ; address name
    db $00, $02, $04 ; id 36
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom03_Y3X1_Tiles
    dfar KeyWorldRoom06_Y1X1_Tiles
    dfar KeyWorldRoom11_Y2X1_Tiles
    dfar KeyWorldRoom24_Y1X0_Tiles
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom04_Y3X3_Tiles
    dfar KeyWorldRoom03_Y1X3_Tiles
    dfar KeyWorldRoom10_Y0X1_Tiles
    dfar KeyWorldRoom02_Y3X0_Tiles
    dfar KeyWorldRoom03_Y1X2_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom03_Y3X2_Tiles
    dfar KeyWorldRoom0A_Y3X1_Tiles
    dfar KeyWorldRoom08_Y1X3_Tiles
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom03_Y3X1_Attrs
    dfar KeyWorldRoom06_Y1X1_Attrs
    dfar KeyWorldRoom11_Y2X1_Attrs
    dfar KeyWorldRoom24_Y1X0_Attrs
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom04_Y3X3_Attrs
    dfar KeyWorldRoom03_Y1X3_Attrs
    dfar KeyWorldRoom10_Y0X1_Attrs
    dfar KeyWorldRoom02_Y3X0_Attrs
    dfar KeyWorldRoom03_Y1X2_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom03_Y3X2_Attrs
    dfar KeyWorldRoom0A_Y3X1_Attrs
    dfar KeyWorldRoom08_Y1X3_Attrs
KeyWorldRoom25:: ; heuristic: string; C0
    db $00, $02, $04 ; id 37
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom25_Y0X1_Tiles
    dfar KeyWorldRoom25_Y0X2_Tiles
    dfar KeyWorldRoom10_Y0X2_Tiles
    dfar KeyWorldRoom01_Y1X3_Tiles
    dfar KeyWorldRoom04_Y1X1_Tiles
    dfar KeyWorldRoom0A_Y1X1_Tiles
    dfar KeyWorldRoom02_Y1X2_Tiles
    dfar KeyWorldRoom09_Y2X1_Tiles
    dfar KeyWorldRoom08_Y0X1_Tiles
    dfar KeyWorldRoom16_Y2X2_Tiles
    dfar KeyWorldRoom0A_Y1X3_Tiles
    dfar KeyWorldRoom00_Y3X3_Tiles
    dfar KeyWorldRoom12_Y3X3_Tiles
    dfar KeyWorldRoom03_Y3X0_Tiles
    dfar KeyWorldRoom08_Y3X3_Tiles
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom25_Y0X1_Attrs
    dfar KeyWorldRoom25_Y0X2_Attrs
    dfar KeyWorldRoom10_Y0X2_Attrs
    dfar KeyWorldRoom01_Y1X3_Attrs
    dfar KeyWorldRoom04_Y1X1_Attrs
    dfar KeyWorldRoom0A_Y1X1_Attrs
    dfar KeyWorldRoom02_Y1X2_Attrs
    dfar KeyWorldRoom09_Y2X1_Attrs
    dfar KeyWorldRoom08_Y0X1_Attrs
    dfar KeyWorldRoom16_Y2X2_Attrs
    dfar KeyWorldRoom0A_Y1X3_Attrs
    dfar KeyWorldRoom00_Y3X3_Attrs
    dfar KeyWorldRoom12_Y3X3_Attrs
    dfar KeyWorldRoom03_Y3X0_Attrs
    dfar KeyWorldRoom08_Y3X3_Attrs
KeyWorldRoom26:: ; heuristic: string; C0
    db $00, $02, $04 ; id 38
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom08_Y0X2_Tiles
    dfar KeyWorldRoom1D_Y0X1_Tiles
    dfar KeyWorldRoom12_Y2X3_Tiles
    dfar KeyWorldRoom02_Y1X3_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom07_Y1X2_Tiles
    dfar KeyWorldRoom0A_Y2X1_Tiles
    dfar KeyWorldRoom02_Y2X0_Tiles
    dfar KeyWorldRoom0A_Y2X0_Tiles
    dfar KeyWorldRoom01_Y1X2_Tiles
    dfar KeyWorldRoom05_Y1X1_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom0A_Y3X2_Tiles
    dfar KeyWorldRoom00_Y3X1_Tiles
    dfar KeyWorldRoom0F_Y0X3_Tiles
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom08_Y0X2_Attrs
    dfar KeyWorldRoom1D_Y0X1_Attrs
    dfar KeyWorldRoom12_Y2X3_Attrs
    dfar KeyWorldRoom02_Y1X3_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom07_Y1X2_Attrs
    dfar KeyWorldRoom0A_Y2X1_Attrs
    dfar KeyWorldRoom02_Y2X0_Attrs
    dfar KeyWorldRoom0A_Y2X0_Attrs
    dfar KeyWorldRoom01_Y1X2_Attrs
    dfar KeyWorldRoom05_Y1X1_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom0A_Y3X2_Attrs
    dfar KeyWorldRoom00_Y3X1_Attrs
    dfar KeyWorldRoom0F_Y0X3_Attrs
KeyWorldRoom27:: ; heuristic: string; C0
    db $00, $02, $04 ; id 39
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom09_Y0X1_Tiles
    dfar KeyWorldRoom0A_Y0X1_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom03_Y1X0_Tiles
    dfar KeyWorldRoom07_Y1X0_Tiles
    dfar KeyWorldRoom0B_Y1X1_Tiles
    dfar KeyWorldRoom03_Y1X3_Tiles
    dfar KeyWorldRoom07_Y1X0_Tiles
    dfar KeyWorldRoom02_Y2X2_Tiles
    dfar KeyWorldRoom08_Y1X2_Tiles
    dfar KeyWorldRoom01_Y2X3_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom04_Y0X2_Tiles
    dfar KeyWorldRoom00_Y0X2_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom09_Y0X1_Attrs
    dfar KeyWorldRoom0A_Y0X1_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom03_Y1X0_Attrs
    dfar KeyWorldRoom07_Y1X0_Attrs
    dfar KeyWorldRoom0B_Y1X1_Attrs
    dfar KeyWorldRoom03_Y1X3_Attrs
    dfar KeyWorldRoom07_Y1X0_Attrs
    dfar KeyWorldRoom02_Y2X2_Attrs
    dfar KeyWorldRoom08_Y1X2_Attrs
    dfar KeyWorldRoom01_Y2X3_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom04_Y0X2_Attrs
    dfar KeyWorldRoom00_Y0X2_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
KeyWorldRoom28:: ; heuristic: key-world room record; C0
Data_072_50F9:: ; address name
    db $00, $02, $04 ; id 40
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom12_Y2X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom03_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X1_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom01_Y1X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X1_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom12_Y2X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom03_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X1_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom01_Y1X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X1_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
KeyWorldRoom29:: ; heuristic: key-world room record; C0
Data_072_515C:: ; address name
    db $00, $02, $04 ; id 41
    dfar KeyWorldRoom04_Y1X1_Tiles
    dfar KeyWorldRoom04_Y0X2_Tiles
    dfar KeyWorldRoom10_Y2X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom04_Y1X1_Tiles
    dfar KeyWorldRoom29_Y1X2_Tiles
    dfar KeyWorldRoom01_Y2X1_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom1D_Y3X1_Tiles
    dfar KeyWorldRoom16_Y2X2_Tiles
    dfar KeyWorldRoom29_Y2X3_Tiles
    dfar KeyWorldRoom04_Y1X1_Tiles
    dfar KeyWorldRoom03_Y0X1_Tiles
    dfar KeyWorldRoom02_Y3X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom04_Y1X1_Attrs
    dfar KeyWorldRoom04_Y0X2_Attrs
    dfar KeyWorldRoom10_Y2X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom04_Y1X1_Attrs
    dfar KeyWorldRoom29_Y1X2_Attrs
    dfar KeyWorldRoom01_Y2X1_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom1D_Y3X1_Attrs
    dfar KeyWorldRoom16_Y2X2_Attrs
    dfar KeyWorldRoom29_Y2X3_Attrs
    dfar KeyWorldRoom04_Y1X1_Attrs
    dfar KeyWorldRoom03_Y0X1_Attrs
    dfar KeyWorldRoom02_Y3X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
KeyWorldRoom2A:: ; heuristic: key-world room record; C0
Data_072_51BF:: ; address name
    db $00, $02, $05 ; id 42
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom00_Y0X1_Tiles
    dfar KeyWorldRoom0F_Y0X3_Tiles
    dfar KeyWorldRoom02_Y0X0_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom01_Y0X1_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom07_Y1X2_Tiles
    dfar KeyWorldRoom00_Y0X3_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom00_Y0X2_Tiles
    dfar KeyWorldRoom01_Y3X1_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom00_Y0X1_Attrs
    dfar KeyWorldRoom0F_Y0X3_Attrs
    dfar KeyWorldRoom02_Y0X0_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom01_Y0X1_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom07_Y1X2_Attrs
    dfar KeyWorldRoom00_Y0X3_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom00_Y0X2_Attrs
    dfar KeyWorldRoom01_Y3X1_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
KeyWorldRoom2B:: ; heuristic: string; C0
    db $00, $02, $05 ; id 43
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom06_Y0X1_Tiles
    dfar KeyWorldRoom1B_Y3X1_Tiles
    dfar KeyWorldRoom01_Y2X1_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom10_Y2X3_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom08_Y1X0_Tiles
    dfar KeyWorldRoom02_Y3X3_Tiles
    dfar KeyWorldRoom02_Y2X1_Tiles
    dfar KeyWorldRoom01_Y2X3_Tiles
    dfar KeyWorldRoom02_Y3X0_Tiles
    dfar KeyWorldRoom03_Y0X1_Tiles
    dfar KeyWorldRoom02_Y3X2_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom06_Y0X1_Attrs
    dfar KeyWorldRoom1B_Y3X1_Attrs
    dfar KeyWorldRoom01_Y2X1_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom10_Y2X3_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom08_Y1X0_Attrs
    dfar KeyWorldRoom02_Y3X3_Attrs
    dfar KeyWorldRoom02_Y2X1_Attrs
    dfar KeyWorldRoom01_Y2X3_Attrs
    dfar KeyWorldRoom02_Y3X0_Attrs
    dfar KeyWorldRoom03_Y0X1_Attrs
    dfar KeyWorldRoom02_Y3X2_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
KeyWorldRoom2C:: ; heuristic: string; C0
    db $00, $02, $05 ; id 44
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom16_Y2X3_Tiles
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom09_Y1X2_Tiles
    dfar KeyWorldRoom02_Y1X3_Tiles
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom04_Y1X3_Tiles
    dfar KeyWorldRoom02_Y2X0_Tiles
    dfar KeyWorldRoom03_Y1X0_Tiles
    dfar KeyWorldRoom08_Y1X0_Tiles
    dfar KeyWorldRoom04_Y2X2_Tiles
    dfar KeyWorldRoom03_Y1X3_Tiles
    dfar KeyWorldRoom03_Y2X1_Tiles
    dfar KeyWorldRoom03_Y2X2_Tiles
    dfar KeyWorldRoom03_Y0X2_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom16_Y2X3_Attrs
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom09_Y1X2_Attrs
    dfar KeyWorldRoom02_Y1X3_Attrs
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom04_Y1X3_Attrs
    dfar KeyWorldRoom02_Y2X0_Attrs
    dfar KeyWorldRoom03_Y1X0_Attrs
    dfar KeyWorldRoom08_Y1X0_Attrs
    dfar KeyWorldRoom04_Y2X2_Attrs
    dfar KeyWorldRoom03_Y1X3_Attrs
    dfar KeyWorldRoom03_Y2X1_Attrs
    dfar KeyWorldRoom03_Y2X2_Attrs
    dfar KeyWorldRoom03_Y0X2_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
KeyWorldRoom2D:: ; heuristic: key-world room record; C0
Data_072_52E8:: ; address name
    db $00, $02, $05 ; id 45
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom03_Y3X1_Tiles
    dfar KeyWorldRoom0A_Y0X2_Tiles
    dfar KeyWorldRoom2D_Y0X3_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom0A_Y1X1_Tiles
    dfar KeyWorldRoom11_Y0X2_Tiles
    dfar KeyWorldRoom01_Y1X3_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom08_Y1X3_Tiles
    dfar KeyWorldRoom02_Y1X2_Tiles
    dfar KeyWorldRoom03_Y3X0_Tiles
    dfar KeyWorldRoom04_Y0X2_Tiles
    dfar KeyWorldRoom03_Y3X2_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom03_Y3X1_Attrs
    dfar KeyWorldRoom0A_Y0X2_Attrs
    dfar KeyWorldRoom2D_Y0X3_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom0A_Y1X1_Attrs
    dfar KeyWorldRoom11_Y0X2_Attrs
    dfar KeyWorldRoom01_Y1X3_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom08_Y1X3_Attrs
    dfar KeyWorldRoom02_Y1X2_Attrs
    dfar KeyWorldRoom03_Y3X0_Attrs
    dfar KeyWorldRoom04_Y0X2_Attrs
    dfar KeyWorldRoom03_Y3X2_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
KeyWorldRoom2E:: ; heuristic: string; C0
    db $00, $02, $05 ; id 46
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom02_Y3X2_Tiles
    dfar KeyWorldRoom00_Y0X2_Tiles
    dfar KeyWorldRoom03_Y1X2_Tiles
    dfar KeyWorldRoom02_Y2X0_Tiles
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom11_Y2X1_Tiles
    dfar KeyWorldRoom02_Y1X3_Tiles
    dfar KeyWorldRoom08_Y2X0_Tiles
    dfar KeyWorldRoom09_Y3X1_Tiles
    dfar KeyWorldRoom0A_Y3X2_Tiles
    dfar KeyWorldRoom0A_Y1X3_Tiles
    dfar KeyWorldRoom01_Y2X2_Tiles
    dfar KeyWorldRoom03_Y0X2_Tiles
    dfar KeyWorldRoom03_Y0X1_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom02_Y3X2_Attrs
    dfar KeyWorldRoom00_Y0X2_Attrs
    dfar KeyWorldRoom03_Y1X2_Attrs
    dfar KeyWorldRoom02_Y2X0_Attrs
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom11_Y2X1_Attrs
    dfar KeyWorldRoom02_Y1X3_Attrs
    dfar KeyWorldRoom08_Y2X0_Attrs
    dfar KeyWorldRoom09_Y3X1_Attrs
    dfar KeyWorldRoom0A_Y3X2_Attrs
    dfar KeyWorldRoom0A_Y1X3_Attrs
    dfar KeyWorldRoom01_Y2X2_Attrs
    dfar KeyWorldRoom03_Y0X2_Attrs
    dfar KeyWorldRoom03_Y0X1_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
KeyWorldRoom2F:: ; heuristic: key-world room record; C0
Data_072_53AE:: ; address name
    db $00, $02, $05 ; id 47
    dfar KeyWorldRoom02_Y0X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom00_Y3X2_Tiles
    dfar KeyWorldRoom02_Y0X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom00_Y3X2_Attrs
KeyWorldRoom30:: ; heuristic: key-world room record; C0
Data_072_5411:: ; address name
    db $00, $02, $05 ; id 48
    dfar KeyWorldRoom04_Y1X1_Tiles
    dfar KeyWorldRoom00_Y0X1_Tiles
    dfar KeyWorldRoom00_Y0X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom04_Y1X1_Tiles
    dfar KeyWorldRoom30_Y1X2_Tiles
    dfar KeyWorldRoom00_Y0X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom0D_Y3X1_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom00_Y3X3_Tiles
    dfar KeyWorldRoom04_Y1X1_Attrs
    dfar KeyWorldRoom00_Y0X1_Attrs
    dfar KeyWorldRoom00_Y0X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom04_Y1X1_Attrs
    dfar KeyWorldRoom30_Y1X2_Attrs
    dfar KeyWorldRoom00_Y0X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom0D_Y3X1_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom00_Y3X3_Attrs
KeyWorldRoom31:: ; heuristic: string; C0
    db $00, $03, $04 ; id 49
    dfar KeyWorldRoom02_Y0X1_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom04_Y1X1_Tiles
    dfar KeyWorldRoom08_Y1X1_Tiles
    dfar KeyWorldRoom07_Y1X2_Tiles
    dfar KeyWorldRoom01_Y1X2_Tiles
    dfar KeyWorldRoom02_Y0X0_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom00_Y0X1_Tiles
    dfar KeyWorldRoom00_Y0X2_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom02_Y0X1_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom04_Y1X1_Attrs
    dfar KeyWorldRoom08_Y1X1_Attrs
    dfar KeyWorldRoom07_Y1X2_Attrs
    dfar KeyWorldRoom01_Y1X2_Attrs
    dfar KeyWorldRoom02_Y0X0_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom00_Y0X1_Attrs
    dfar KeyWorldRoom00_Y0X2_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
KeyWorldRoom32:: ; heuristic: string; C0
    db $00, $03, $04 ; id 50
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom01_Y0X1_Tiles
    dfar KeyWorldRoom08_Y0X1_Tiles
    dfar KeyWorldRoom32_Y0X3_Tiles
    dfar KeyWorldRoom08_Y3X1_Tiles
    dfar KeyWorldRoom09_Y1X1_Tiles
    dfar KeyWorldRoom08_Y2X1_Tiles
    dfar KeyWorldRoom1E_Y0X1_Tiles
    dfar KeyWorldRoom1D_Y3X1_Tiles
    dfar KeyWorldRoom0A_Y2X1_Tiles
    dfar KeyWorldRoom07_Y1X0_Tiles
    dfar KeyWorldRoom12_Y2X3_Tiles
    dfar KeyWorldRoom04_Y1X1_Tiles
    dfar KeyWorldRoom02_Y3X3_Tiles
    dfar KeyWorldRoom01_Y3X0_Tiles
    dfar KeyWorldRoom03_Y2X3_Tiles
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom01_Y0X1_Attrs
    dfar KeyWorldRoom08_Y0X1_Attrs
    dfar KeyWorldRoom32_Y0X3_Attrs
    dfar KeyWorldRoom08_Y3X1_Attrs
    dfar KeyWorldRoom09_Y1X1_Attrs
    dfar KeyWorldRoom08_Y2X1_Attrs
    dfar KeyWorldRoom1E_Y0X1_Attrs
    dfar KeyWorldRoom1D_Y3X1_Attrs
    dfar KeyWorldRoom0A_Y2X1_Attrs
    dfar KeyWorldRoom07_Y1X0_Attrs
    dfar KeyWorldRoom12_Y2X3_Attrs
    dfar KeyWorldRoom04_Y1X1_Attrs
    dfar KeyWorldRoom02_Y3X3_Attrs
    dfar KeyWorldRoom01_Y3X0_Attrs
    dfar KeyWorldRoom03_Y2X3_Attrs
KeyWorldRoom33:: ; heuristic: key-world room record; C0
Data_072_553A:: ; address name
    db $00, $03, $04 ; id 51
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom08_Y0X2_Tiles
    dfar KeyWorldRoom03_Y3X1_Tiles
    dfar KeyWorldRoom00_Y0X3_Tiles
    dfar KeyWorldRoom03_Y1X0_Tiles
    dfar KeyWorldRoom03_Y1X3_Tiles
    dfar KeyWorldRoom04_Y1X1_Tiles
    dfar KeyWorldRoom01_Y1X2_Tiles
    dfar KeyWorldRoom02_Y2X1_Tiles
    dfar KeyWorldRoom0B_Y2X1_Tiles
    dfar KeyWorldRoom00_Y0X2_Tiles
    dfar KeyWorldRoom01_Y2X3_Tiles
    dfar KeyWorldRoom02_Y0X1_Tiles
    dfar KeyWorldRoom0A_Y3X1_Tiles
    dfar KeyWorldRoom03_Y3X2_Tiles
    dfar KeyWorldRoom04_Y2X2_Tiles
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom08_Y0X2_Attrs
    dfar KeyWorldRoom03_Y3X1_Attrs
    dfar KeyWorldRoom00_Y0X3_Attrs
    dfar KeyWorldRoom03_Y1X0_Attrs
    dfar KeyWorldRoom03_Y1X3_Attrs
    dfar KeyWorldRoom04_Y1X1_Attrs
    dfar KeyWorldRoom01_Y1X2_Attrs
    dfar KeyWorldRoom02_Y2X1_Attrs
    dfar KeyWorldRoom0B_Y2X1_Attrs
    dfar KeyWorldRoom00_Y0X2_Attrs
    dfar KeyWorldRoom01_Y2X3_Attrs
    dfar KeyWorldRoom02_Y0X1_Attrs
    dfar KeyWorldRoom0A_Y3X1_Attrs
    dfar KeyWorldRoom03_Y3X2_Attrs
    dfar KeyWorldRoom04_Y2X2_Attrs
KeyWorldRoom34:: ; heuristic: string; C0
    db $00, $03, $04 ; id 52
    dfar KeyWorldRoom04_Y0X0_Tiles
    dfar KeyWorldRoom04_Y0X0_Tiles
    dfar KeyWorldRoom0F_Y1X0_Tiles
    dfar KeyWorldRoom01_Y2X1_Tiles
    dfar KeyWorldRoom02_Y3X0_Tiles
    dfar KeyWorldRoom02_Y2X3_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom0B_Y3X0_Tiles
    dfar KeyWorldRoom19_Y0X2_Tiles
    dfar KeyWorldRoom10_Y2X1_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom1D_Y0X3_Tiles
    dfar KeyWorldRoom04_Y1X1_Tiles
    dfar KeyWorldRoom00_Y3X1_Tiles
    dfar KeyWorldRoom00_Y0X2_Tiles
    dfar KeyWorldRoom08_Y1X3_Tiles
    dfar KeyWorldRoom04_Y0X0_Attrs
    dfar KeyWorldRoom04_Y0X0_Attrs
    dfar KeyWorldRoom0F_Y1X0_Attrs
    dfar KeyWorldRoom01_Y2X1_Attrs
    dfar KeyWorldRoom02_Y3X0_Attrs
    dfar KeyWorldRoom02_Y2X3_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom0B_Y3X0_Attrs
    dfar KeyWorldRoom19_Y0X2_Attrs
    dfar KeyWorldRoom10_Y2X1_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
    dfar KeyWorldRoom1D_Y0X3_Attrs
    dfar KeyWorldRoom04_Y1X1_Attrs
    dfar KeyWorldRoom00_Y3X1_Attrs
    dfar KeyWorldRoom00_Y0X2_Attrs
    dfar KeyWorldRoom08_Y1X3_Attrs
KeyWorldRoom35:: ; heuristic: key-world room record; C0
Data_072_5600:: ; address name
    db $00, $03, $04 ; id 53
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom02_Y3X2_Tiles
    dfar KeyWorldRoom1D_Y0X1_Tiles
    dfar KeyWorldRoom10_Y2X3_Tiles
    dfar KeyWorldRoom0A_Y1X2_Tiles
    dfar KeyWorldRoom03_Y0X1_Tiles
    dfar KeyWorldRoom04_Y1X3_Tiles
    dfar KeyWorldRoom02_Y1X2_Tiles
    dfar KeyWorldRoom11_Y2X2_Tiles
    dfar KeyWorldRoom0A_Y2X0_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom01_Y1X3_Tiles
    dfar KeyWorldRoom02_Y0X1_Tiles
    dfar KeyWorldRoom02_Y2X2_Tiles
    dfar KeyWorldRoom03_Y0X2_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom02_Y3X2_Attrs
    dfar KeyWorldRoom1D_Y0X1_Attrs
    dfar KeyWorldRoom10_Y2X3_Attrs
    dfar KeyWorldRoom0A_Y1X2_Attrs
    dfar KeyWorldRoom03_Y0X1_Attrs
    dfar KeyWorldRoom04_Y1X3_Attrs
    dfar KeyWorldRoom02_Y1X2_Attrs
    dfar KeyWorldRoom11_Y2X2_Attrs
    dfar KeyWorldRoom0A_Y2X0_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
    dfar KeyWorldRoom01_Y1X3_Attrs
    dfar KeyWorldRoom02_Y0X1_Attrs
    dfar KeyWorldRoom02_Y2X2_Attrs
    dfar KeyWorldRoom03_Y0X2_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
KeyWorldRoom36:: ; heuristic: key-world room record; C0
Data_072_5663:: ; address name
    db $00, $03, $04 ; id 54
    dfar KeyWorldRoom04_Y0X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom12_Y2X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom00_Y2X1_Tiles
    dfar KeyWorldRoom0F_Y0X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom04_Y1X1_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom04_Y0X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom12_Y2X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom00_Y2X1_Attrs
    dfar KeyWorldRoom0F_Y0X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom04_Y1X1_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
KeyWorldRoom37:: ; heuristic: key-world room record; C0
Data_072_56C6:: ; address name
    db $00, $03, $04 ; id 55
    dfar KeyWorldRoom02_Y0X1_Tiles
    dfar KeyWorldRoom00_Y0X3_Tiles
    dfar KeyWorldRoom37_Y0X2_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom30_Y1X2_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom37_Y2X0_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom00_Y0X1_Tiles
    dfar KeyWorldRoom37_Y2X3_Tiles
    dfar KeyWorldRoom05_Y1X1_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom02_Y0X1_Attrs
    dfar KeyWorldRoom00_Y0X3_Attrs
    dfar KeyWorldRoom37_Y0X2_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom30_Y1X2_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom37_Y2X0_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom00_Y0X1_Attrs
    dfar KeyWorldRoom37_Y2X3_Attrs
    dfar KeyWorldRoom05_Y1X1_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
KeyWorldRoom38:: ; heuristic: key-world room record; C0
Data_072_5729:: ; address name
    db $00, $03, $05 ; id 56
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom00_Y0X1_Tiles
    dfar KeyWorldRoom06_Y1X1_Tiles
    dfar KeyWorldRoom00_Y3X2_Tiles
    dfar KeyWorldRoom00_Y2X1_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom07_Y1X0_Tiles
    dfar KeyWorldRoom08_Y1X1_Tiles
    dfar KeyWorldRoom0F_Y0X3_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X1_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom00_Y0X1_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom00_Y0X1_Attrs
    dfar KeyWorldRoom06_Y1X1_Attrs
    dfar KeyWorldRoom00_Y3X2_Attrs
    dfar KeyWorldRoom00_Y2X1_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom07_Y1X0_Attrs
    dfar KeyWorldRoom08_Y1X1_Attrs
    dfar KeyWorldRoom0F_Y0X3_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X1_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom00_Y0X1_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
KeyWorldRoom39:: ; heuristic: string; C0
    db $00, $03, $05 ; id 57
    dfar KeyWorldRoom02_Y0X1_Tiles
    dfar KeyWorldRoom03_Y1X2_Tiles
    dfar KeyWorldRoom1D_Y3X1_Tiles
    dfar KeyWorldRoom09_Y1X2_Tiles
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom10_Y2X2_Tiles
    dfar KeyWorldRoom11_Y2X1_Tiles
    dfar KeyWorldRoom02_Y2X0_Tiles
    dfar KeyWorldRoom07_Y1X0_Tiles
    dfar KeyWorldRoom03_Y2X2_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom02_Y1X3_Tiles
    dfar KeyWorldRoom03_Y2X1_Tiles
    dfar KeyWorldRoom03_Y3X1_Tiles
    dfar KeyWorldRoom04_Y0X2_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom02_Y0X1_Attrs
    dfar KeyWorldRoom03_Y1X2_Attrs
    dfar KeyWorldRoom1D_Y3X1_Attrs
    dfar KeyWorldRoom09_Y1X2_Attrs
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom10_Y2X2_Attrs
    dfar KeyWorldRoom11_Y2X1_Attrs
    dfar KeyWorldRoom02_Y2X0_Attrs
    dfar KeyWorldRoom07_Y1X0_Attrs
    dfar KeyWorldRoom03_Y2X2_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
    dfar KeyWorldRoom02_Y1X3_Attrs
    dfar KeyWorldRoom03_Y2X1_Attrs
    dfar KeyWorldRoom03_Y3X1_Attrs
    dfar KeyWorldRoom04_Y0X2_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
KeyWorldRoom3A:: ; heuristic: string; C0
    db $00, $03, $05 ; id 58
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom09_Y0X1_Tiles
    dfar KeyWorldRoom03_Y3X2_Tiles
    dfar KeyWorldRoom12_Y2X3_Tiles
    dfar KeyWorldRoom03_Y3X0_Tiles
    dfar KeyWorldRoom11_Y1X2_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom03_Y1X3_Tiles
    dfar KeyWorldRoom0B_Y2X0_Tiles
    dfar KeyWorldRoom16_Y2X2_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom03_Y1X0_Tiles
    dfar KeyWorldRoom24_Y1X0_Tiles
    dfar KeyWorldRoom3A_Y3X1_Tiles
    dfar KeyWorldRoom3A_Y3X2_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom09_Y0X1_Attrs
    dfar KeyWorldRoom03_Y3X2_Attrs
    dfar KeyWorldRoom12_Y2X3_Attrs
    dfar KeyWorldRoom03_Y3X0_Attrs
    dfar KeyWorldRoom11_Y1X2_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom03_Y1X3_Attrs
    dfar KeyWorldRoom0B_Y2X0_Attrs
    dfar KeyWorldRoom16_Y2X2_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
    dfar KeyWorldRoom03_Y1X0_Attrs
    dfar KeyWorldRoom24_Y1X0_Attrs
    dfar KeyWorldRoom3A_Y3X1_Attrs
    dfar KeyWorldRoom3A_Y3X2_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
KeyWorldRoom3B:: ; heuristic: key-world room record; C0
Data_072_5852:: ; address name
    db $00, $03, $05 ; id 59
    dfar KeyWorldRoom02_Y0X1_Tiles
    dfar KeyWorldRoom10_Y2X3_Tiles
    dfar KeyWorldRoom0F_Y0X2_Tiles
    dfar KeyWorldRoom01_Y2X1_Tiles
    dfar KeyWorldRoom10_Y0X1_Tiles
    dfar KeyWorldRoom02_Y1X0_Tiles
    dfar KeyWorldRoom08_Y1X1_Tiles
    dfar KeyWorldRoom0A_Y1X1_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom01_Y2X2_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom00_Y0X2_Tiles
    dfar KeyWorldRoom03_Y0X1_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom02_Y0X1_Attrs
    dfar KeyWorldRoom10_Y2X3_Attrs
    dfar KeyWorldRoom0F_Y0X2_Attrs
    dfar KeyWorldRoom01_Y2X1_Attrs
    dfar KeyWorldRoom10_Y0X1_Attrs
    dfar KeyWorldRoom02_Y1X0_Attrs
    dfar KeyWorldRoom08_Y1X1_Attrs
    dfar KeyWorldRoom0A_Y1X1_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom01_Y2X2_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom00_Y0X2_Attrs
    dfar KeyWorldRoom03_Y0X1_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
KeyWorldRoom3C:: ; heuristic: string; C0
    db $00, $03, $05 ; id 60
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom0A_Y0X1_Tiles
    dfar KeyWorldRoom02_Y3X2_Tiles
    dfar KeyWorldRoom11_Y2X1_Tiles
    dfar KeyWorldRoom02_Y1X3_Tiles
    dfar KeyWorldRoom08_Y1X0_Tiles
    dfar KeyWorldRoom09_Y1X2_Tiles
    dfar KeyWorldRoom02_Y1X2_Tiles
    dfar KeyWorldRoom12_Y3X3_Tiles
    dfar KeyWorldRoom00_Y3X3_Tiles
    dfar KeyWorldRoom05_Y1X1_Tiles
    dfar KeyWorldRoom01_Y1X3_Tiles
    dfar KeyWorldRoom04_Y1X1_Tiles
    dfar KeyWorldRoom03_Y3X1_Tiles
    dfar KeyWorldRoom03_Y0X2_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom0A_Y0X1_Attrs
    dfar KeyWorldRoom02_Y3X2_Attrs
    dfar KeyWorldRoom11_Y2X1_Attrs
    dfar KeyWorldRoom02_Y1X3_Attrs
    dfar KeyWorldRoom08_Y1X0_Attrs
    dfar KeyWorldRoom09_Y1X2_Attrs
    dfar KeyWorldRoom02_Y1X2_Attrs
    dfar KeyWorldRoom12_Y3X3_Attrs
    dfar KeyWorldRoom00_Y3X3_Attrs
    dfar KeyWorldRoom05_Y1X1_Attrs
    dfar KeyWorldRoom01_Y1X3_Attrs
    dfar KeyWorldRoom04_Y1X1_Attrs
    dfar KeyWorldRoom03_Y3X1_Attrs
    dfar KeyWorldRoom03_Y0X2_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
KeyWorldRoom3D:: ; heuristic: key-world room record; C0
Data_072_5918:: ; address name
    db $00, $03, $05 ; id 61
    dfar KeyWorldRoom02_Y0X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom02_Y3X0_Tiles
    dfar KeyWorldRoom3D_Y1X1_Tiles
    dfar KeyWorldRoom00_Y0X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom3D_Y2X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X1_Tiles
    dfar KeyWorldRoom02_Y0X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom02_Y3X0_Attrs
    dfar KeyWorldRoom3D_Y1X1_Attrs
    dfar KeyWorldRoom00_Y0X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom3D_Y2X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X1_Attrs
KeyWorldRoom3E:: ; heuristic: key-world room record; C0
Data_072_597B:: ; address name
    db $00, $03, $05 ; id 62
    dfar KeyWorldRoom02_Y0X1_Tiles
    dfar KeyWorldRoom3E_Y0X1_Tiles
    dfar KeyWorldRoom11_Y2X1_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom3E_Y1X2_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom0F_Y1X0_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom14_Y1X1_Tiles
    dfar KeyWorldRoom04_Y0X2_Tiles
    dfar KeyWorldRoom00_Y3X2_Tiles
    dfar KeyWorldRoom02_Y0X1_Attrs
    dfar KeyWorldRoom3E_Y0X1_Attrs
    dfar KeyWorldRoom11_Y2X1_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom3E_Y1X2_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom0F_Y1X0_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom14_Y1X1_Attrs
    dfar KeyWorldRoom04_Y0X2_Attrs
    dfar KeyWorldRoom00_Y3X2_Attrs
KeyWorldRoom3F:: ; heuristic: string; C0
    db $00, $04, $05 ; id 63
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom02_Y0X1_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom01_Y1X2_Tiles
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom01_Y1X2_Tiles
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom0B_Y1X1_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom00_Y3X3_Tiles
    dfar KeyWorldRoom00_Y3X3_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom00_Y3X1_Tiles
    dfar KeyWorldRoom00_Y3X2_Tiles
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom02_Y0X1_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom01_Y1X2_Attrs
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom01_Y1X2_Attrs
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom0B_Y1X1_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom00_Y3X3_Attrs
    dfar KeyWorldRoom00_Y3X3_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom00_Y3X1_Attrs
    dfar KeyWorldRoom00_Y3X2_Attrs
KeyWorldRoom40:: ; heuristic: key-world room record; C0
Data_072_5A41:: ; address name
    db $00, $04, $05 ; id 64
    dfar KeyWorldRoom04_Y1X1_Tiles
    dfar KeyWorldRoom0A_Y0X2_Tiles
    dfar KeyWorldRoom03_Y3X2_Tiles
    dfar KeyWorldRoom12_Y2X3_Tiles
    dfar KeyWorldRoom10_Y2X0_Tiles
    dfar KeyWorldRoom08_Y1X2_Tiles
    dfar KeyWorldRoom03_Y1X2_Tiles
    dfar KeyWorldRoom0B_Y3X0_Tiles
    dfar KeyWorldRoom08_Y2X0_Tiles
    dfar KeyWorldRoom06_Y1X1_Tiles
    dfar KeyWorldRoom08_Y2X1_Tiles
    dfar KeyWorldRoom01_Y2X1_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom02_Y2X1_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom04_Y1X1_Attrs
    dfar KeyWorldRoom0A_Y0X2_Attrs
    dfar KeyWorldRoom03_Y3X2_Attrs
    dfar KeyWorldRoom12_Y2X3_Attrs
    dfar KeyWorldRoom10_Y2X0_Attrs
    dfar KeyWorldRoom08_Y1X2_Attrs
    dfar KeyWorldRoom03_Y1X2_Attrs
    dfar KeyWorldRoom0B_Y3X0_Attrs
    dfar KeyWorldRoom08_Y2X0_Attrs
    dfar KeyWorldRoom06_Y1X1_Attrs
    dfar KeyWorldRoom08_Y2X1_Attrs
    dfar KeyWorldRoom01_Y2X1_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
    dfar KeyWorldRoom02_Y2X1_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
KeyWorldRoom41:: ; heuristic: key-world room record; C0
Data_072_5AA4:: ; address name
    db $00, $04, $05 ; id 65
    dfar KeyWorldRoom04_Y0X0_Tiles
    dfar KeyWorldRoom0A_Y2X0_Tiles
    dfar KeyWorldRoom04_Y0X2_Tiles
    dfar KeyWorldRoom00_Y0X3_Tiles
    dfar KeyWorldRoom02_Y3X0_Tiles
    dfar KeyWorldRoom0B_Y2X1_Tiles
    dfar KeyWorldRoom08_Y0X1_Tiles
    dfar KeyWorldRoom0A_Y1X3_Tiles
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom04_Y2X2_Tiles
    dfar KeyWorldRoom03_Y1X0_Tiles
    dfar KeyWorldRoom02_Y2X0_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom25_Y0X1_Tiles
    dfar KeyWorldRoom03_Y3X0_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom04_Y0X0_Attrs
    dfar KeyWorldRoom0A_Y2X0_Attrs
    dfar KeyWorldRoom04_Y0X2_Attrs
    dfar KeyWorldRoom00_Y0X3_Attrs
    dfar KeyWorldRoom02_Y3X0_Attrs
    dfar KeyWorldRoom0B_Y2X1_Attrs
    dfar KeyWorldRoom08_Y0X1_Attrs
    dfar KeyWorldRoom0A_Y1X3_Attrs
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom04_Y2X2_Attrs
    dfar KeyWorldRoom03_Y1X0_Attrs
    dfar KeyWorldRoom02_Y2X0_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom25_Y0X1_Attrs
    dfar KeyWorldRoom03_Y3X0_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
KeyWorldRoom42:: ; heuristic: string; C0
    db $00, $04, $05 ; id 66
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom00_Y0X1_Tiles
    dfar KeyWorldRoom08_Y0X2_Tiles
    dfar KeyWorldRoom10_Y2X3_Tiles
    dfar KeyWorldRoom03_Y1X3_Tiles
    dfar KeyWorldRoom0B_Y2X0_Tiles
    dfar KeyWorldRoom0A_Y2X1_Tiles
    dfar KeyWorldRoom11_Y2X2_Tiles
    dfar KeyWorldRoom01_Y1X3_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom08_Y3X3_Tiles
    dfar KeyWorldRoom25_Y0X2_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom03_Y0X1_Tiles
    dfar KeyWorldRoom00_Y0X2_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom00_Y0X1_Attrs
    dfar KeyWorldRoom08_Y0X2_Attrs
    dfar KeyWorldRoom10_Y2X3_Attrs
    dfar KeyWorldRoom03_Y1X3_Attrs
    dfar KeyWorldRoom0B_Y2X0_Attrs
    dfar KeyWorldRoom0A_Y2X1_Attrs
    dfar KeyWorldRoom11_Y2X2_Attrs
    dfar KeyWorldRoom01_Y1X3_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom08_Y3X3_Attrs
    dfar KeyWorldRoom25_Y0X2_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom03_Y0X1_Attrs
    dfar KeyWorldRoom00_Y0X2_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
KeyWorldRoom43:: ; heuristic: string; C0
    db $00, $04, $05 ; id 67
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom03_Y0X2_Tiles
    dfar KeyWorldRoom02_Y3X2_Tiles
    dfar KeyWorldRoom10_Y2X3_Tiles
    dfar KeyWorldRoom24_Y1X0_Tiles
    dfar KeyWorldRoom0F_Y1X0_Tiles
    dfar KeyWorldRoom09_Y1X2_Tiles
    dfar KeyWorldRoom02_Y1X2_Tiles
    dfar KeyWorldRoom10_Y2X0_Tiles
    dfar KeyWorldRoom10_Y2X1_Tiles
    dfar KeyWorldRoom0B_Y1X1_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom05_Y1X1_Tiles
    dfar KeyWorldRoom01_Y3X0_Tiles
    dfar KeyWorldRoom09_Y3X1_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom03_Y0X2_Attrs
    dfar KeyWorldRoom02_Y3X2_Attrs
    dfar KeyWorldRoom10_Y2X3_Attrs
    dfar KeyWorldRoom24_Y1X0_Attrs
    dfar KeyWorldRoom0F_Y1X0_Attrs
    dfar KeyWorldRoom09_Y1X2_Attrs
    dfar KeyWorldRoom02_Y1X2_Attrs
    dfar KeyWorldRoom10_Y2X0_Attrs
    dfar KeyWorldRoom10_Y2X1_Attrs
    dfar KeyWorldRoom0B_Y1X1_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom05_Y1X1_Attrs
    dfar KeyWorldRoom01_Y3X0_Attrs
    dfar KeyWorldRoom09_Y3X1_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
KeyWorldRoom44:: ; heuristic: key-world room record; C0
Data_072_5BCD:: ; address name
    db $00, $04, $05 ; id 68
    dfar KeyWorldRoom04_Y1X1_Tiles
    dfar KeyWorldRoom44_Y0X1_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom02_Y1X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom44_Y2X0_Tiles
    dfar KeyWorldRoom0A_Y3X2_Tiles
    dfar KeyWorldRoom00_Y0X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom00_Y3X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom01_Y2X2_Tiles
    dfar KeyWorldRoom0F_Y0X3_Tiles
    dfar KeyWorldRoom04_Y1X1_Attrs
    dfar KeyWorldRoom44_Y0X1_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom02_Y1X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom44_Y2X0_Attrs
    dfar KeyWorldRoom0A_Y3X2_Attrs
    dfar KeyWorldRoom00_Y0X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom00_Y3X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom01_Y2X2_Attrs
    dfar KeyWorldRoom0F_Y0X3_Attrs
KeyWorldRoom45:: ; heuristic: key-world room record; C0
Data_072_5C30:: ; address name
    db $00, $04, $05 ; id 69
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom06_Y2X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom02_Y2X1_Tiles
    dfar KeyWorldRoom00_Y0X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom45_Y1X3_Tiles
    dfar KeyWorldRoom0B_Y2X0_Tiles
    dfar KeyWorldRoom22_Y1X2_Tiles
    dfar KeyWorldRoom03_Y0X1_Tiles
    dfar KeyWorldRoom0A_Y1X3_Tiles
    dfar KeyWorldRoom05_Y1X1_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X1_Tiles
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom06_Y2X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom02_Y2X1_Attrs
    dfar KeyWorldRoom00_Y0X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom45_Y1X3_Attrs
    dfar KeyWorldRoom0B_Y2X0_Attrs
    dfar KeyWorldRoom22_Y1X2_Attrs
    dfar KeyWorldRoom03_Y0X1_Attrs
    dfar KeyWorldRoom0A_Y1X3_Attrs
    dfar KeyWorldRoom05_Y1X1_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X1_Attrs
KeyWorldRoom46:: ; heuristic: key-world room record; C0
Data_072_5C93:: ; address name
    db $01, $02, $03 ; id 70
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom00_Y0X3_Tiles
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom00_Y0X3_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom00_Y3X3_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom07_Y1X0_Tiles
    dfar KeyWorldRoom00_Y0X1_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom00_Y0X2_Tiles
    dfar KeyWorldRoom00_Y0X1_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom00_Y0X3_Attrs
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom00_Y0X3_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom00_Y3X3_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom07_Y1X0_Attrs
    dfar KeyWorldRoom00_Y0X1_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom00_Y0X2_Attrs
    dfar KeyWorldRoom00_Y0X1_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
KeyWorldRoom47:: ; heuristic: string; C0
    db $01, $02, $03 ; id 71
    dfar KeyWorldRoom0A_Y2X0_Tiles
    dfar KeyWorldRoom11_Y2X1_Tiles
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom08_Y2X0_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom02_Y3X0_Tiles
    dfar KeyWorldRoom04_Y1X3_Tiles
    dfar KeyWorldRoom09_Y1X1_Tiles
    dfar KeyWorldRoom12_Y2X3_Tiles
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom01_Y2X3_Tiles
    dfar KeyWorldRoom03_Y2X1_Tiles
    dfar KeyWorldRoom0A_Y3X1_Tiles
    dfar KeyWorldRoom01_Y3X1_Tiles
    dfar KeyWorldRoom03_Y2X3_Tiles
    dfar KeyWorldRoom0A_Y2X0_Attrs
    dfar KeyWorldRoom11_Y2X1_Attrs
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom08_Y2X0_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
    dfar KeyWorldRoom02_Y3X0_Attrs
    dfar KeyWorldRoom04_Y1X3_Attrs
    dfar KeyWorldRoom09_Y1X1_Attrs
    dfar KeyWorldRoom12_Y2X3_Attrs
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom01_Y2X3_Attrs
    dfar KeyWorldRoom03_Y2X1_Attrs
    dfar KeyWorldRoom0A_Y3X1_Attrs
    dfar KeyWorldRoom01_Y3X1_Attrs
    dfar KeyWorldRoom03_Y2X3_Attrs
KeyWorldRoom48:: ; heuristic: key-world room record; C0
Data_072_5D59:: ; address name
    db $01, $02, $03 ; id 72
    dfar KeyWorldRoom0B_Y2X0_Tiles
    dfar KeyWorldRoom03_Y3X1_Tiles
    dfar KeyWorldRoom1D_Y0X1_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom09_Y2X1_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom0A_Y1X2_Tiles
    dfar KeyWorldRoom02_Y2X3_Tiles
    dfar KeyWorldRoom00_Y2X1_Tiles
    dfar KeyWorldRoom01_Y1X2_Tiles
    dfar KeyWorldRoom07_Y1X0_Tiles
    dfar KeyWorldRoom0A_Y1X1_Tiles
    dfar KeyWorldRoom03_Y3X0_Tiles
    dfar KeyWorldRoom02_Y2X2_Tiles
    dfar KeyWorldRoom04_Y3X3_Tiles
    dfar KeyWorldRoom12_Y3X3_Tiles
    dfar KeyWorldRoom0B_Y2X0_Attrs
    dfar KeyWorldRoom03_Y3X1_Attrs
    dfar KeyWorldRoom1D_Y0X1_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom09_Y2X1_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom0A_Y1X2_Attrs
    dfar KeyWorldRoom02_Y2X3_Attrs
    dfar KeyWorldRoom00_Y2X1_Attrs
    dfar KeyWorldRoom01_Y1X2_Attrs
    dfar KeyWorldRoom07_Y1X0_Attrs
    dfar KeyWorldRoom0A_Y1X1_Attrs
    dfar KeyWorldRoom03_Y3X0_Attrs
    dfar KeyWorldRoom02_Y2X2_Attrs
    dfar KeyWorldRoom04_Y3X3_Attrs
    dfar KeyWorldRoom12_Y3X3_Attrs
KeyWorldRoom49:: ; heuristic: string; C0
    db $01, $02, $03 ; id 73
    dfar KeyWorldRoom0F_Y1X0_Tiles
    dfar KeyWorldRoom03_Y3X2_Tiles
    dfar KeyWorldRoom10_Y2X3_Tiles
    dfar KeyWorldRoom04_Y0X0_Tiles
    dfar KeyWorldRoom03_Y1X0_Tiles
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom04_Y1X3_Tiles
    dfar KeyWorldRoom03_Y1X3_Tiles
    dfar KeyWorldRoom02_Y1X3_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom02_Y2X0_Tiles
    dfar KeyWorldRoom01_Y2X2_Tiles
    dfar KeyWorldRoom04_Y0X2_Tiles
    dfar KeyWorldRoom02_Y3X2_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom0F_Y1X0_Attrs
    dfar KeyWorldRoom03_Y3X2_Attrs
    dfar KeyWorldRoom10_Y2X3_Attrs
    dfar KeyWorldRoom04_Y0X0_Attrs
    dfar KeyWorldRoom03_Y1X0_Attrs
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom04_Y1X3_Attrs
    dfar KeyWorldRoom03_Y1X3_Attrs
    dfar KeyWorldRoom02_Y1X3_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
    dfar KeyWorldRoom02_Y2X0_Attrs
    dfar KeyWorldRoom01_Y2X2_Attrs
    dfar KeyWorldRoom04_Y0X2_Attrs
    dfar KeyWorldRoom02_Y3X2_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
KeyWorldRoom4A:: ; heuristic: string; C0
    db $01, $02, $03 ; id 74
    dfar KeyWorldRoom0A_Y2X0_Tiles
    dfar KeyWorldRoom03_Y0X1_Tiles
    dfar KeyWorldRoom00_Y0X2_Tiles
    dfar KeyWorldRoom00_Y0X3_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom03_Y0X2_Tiles
    dfar KeyWorldRoom08_Y1X3_Tiles
    dfar KeyWorldRoom08_Y1X0_Tiles
    dfar KeyWorldRoom02_Y3X3_Tiles
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom09_Y1X2_Tiles
    dfar KeyWorldRoom01_Y3X0_Tiles
    dfar KeyWorldRoom03_Y3X1_Tiles
    dfar KeyWorldRoom03_Y2X2_Tiles
    dfar KeyWorldRoom03_Y2X3_Tiles
    dfar KeyWorldRoom0A_Y2X0_Attrs
    dfar KeyWorldRoom03_Y0X1_Attrs
    dfar KeyWorldRoom00_Y0X2_Attrs
    dfar KeyWorldRoom00_Y0X3_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom03_Y0X2_Attrs
    dfar KeyWorldRoom08_Y1X3_Attrs
    dfar KeyWorldRoom08_Y1X0_Attrs
    dfar KeyWorldRoom02_Y3X3_Attrs
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom09_Y1X2_Attrs
    dfar KeyWorldRoom01_Y3X0_Attrs
    dfar KeyWorldRoom03_Y3X1_Attrs
    dfar KeyWorldRoom03_Y2X2_Attrs
    dfar KeyWorldRoom03_Y2X3_Attrs
KeyWorldRoom4B:: ; heuristic: key-world room record; C0
Data_072_5E82:: ; address name
    db $01, $02, $03 ; id 75
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom0F_Y0X2_Tiles
    dfar KeyWorldRoom0F_Y0X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom02_Y0X1_Tiles
    dfar KeyWorldRoom4B_Y1X2_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X1_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom0F_Y0X2_Attrs
    dfar KeyWorldRoom0F_Y0X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom02_Y0X1_Attrs
    dfar KeyWorldRoom4B_Y1X2_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X1_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
KeyWorldRoom4C:: ; heuristic: key-world room record; C0
Data_072_5EE5:: ; address name
    db $01, $02, $03 ; id 76
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom02_Y0X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom02_Y0X0_Tiles
    dfar KeyWorldRoom14_Y2X1_Tiles
    dfar KeyWorldRoom4C_Y1X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom03_Y3X0_Tiles
    dfar KeyWorldRoom00_Y0X1_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom02_Y0X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom02_Y0X0_Attrs
    dfar KeyWorldRoom14_Y2X1_Attrs
    dfar KeyWorldRoom4C_Y1X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom03_Y3X0_Attrs
    dfar KeyWorldRoom00_Y0X1_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
KeyWorldRoom4D:: ; heuristic: string; C0
    db $01, $02, $04 ; id 77
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom07_Y1X0_Tiles
    dfar KeyWorldRoom01_Y3X1_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom06_Y1X1_Tiles
    dfar KeyWorldRoom01_Y0X1_Tiles
    dfar KeyWorldRoom0B_Y1X1_Tiles
    dfar KeyWorldRoom04_Y1X1_Tiles
    dfar KeyWorldRoom01_Y3X1_Tiles
    dfar KeyWorldRoom00_Y3X1_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom07_Y1X0_Attrs
    dfar KeyWorldRoom01_Y3X1_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom06_Y1X1_Attrs
    dfar KeyWorldRoom01_Y0X1_Attrs
    dfar KeyWorldRoom0B_Y1X1_Attrs
    dfar KeyWorldRoom04_Y1X1_Attrs
    dfar KeyWorldRoom01_Y3X1_Attrs
    dfar KeyWorldRoom00_Y3X1_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
KeyWorldRoom4E:: ; heuristic: key-world room record; C0
Data_072_5FAB:: ; address name
    db $01, $02, $04 ; id 78
    dfar KeyWorldRoom19_Y0X2_Tiles
    dfar KeyWorldRoom03_Y1X2_Tiles
    dfar KeyWorldRoom04_Y0X0_Tiles
    dfar KeyWorldRoom04_Y0X0_Tiles
    dfar KeyWorldRoom1D_Y0X3_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom10_Y2X2_Tiles
    dfar KeyWorldRoom0A_Y1X3_Tiles
    dfar KeyWorldRoom08_Y2X0_Tiles
    dfar KeyWorldRoom12_Y2X3_Tiles
    dfar KeyWorldRoom09_Y1X1_Tiles
    dfar KeyWorldRoom04_Y2X2_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom08_Y1X2_Tiles
    dfar KeyWorldRoom0A_Y3X1_Tiles
    dfar KeyWorldRoom00_Y3X2_Tiles
    dfar KeyWorldRoom19_Y0X2_Attrs
    dfar KeyWorldRoom03_Y1X2_Attrs
    dfar KeyWorldRoom04_Y0X0_Attrs
    dfar KeyWorldRoom04_Y0X0_Attrs
    dfar KeyWorldRoom1D_Y0X3_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom10_Y2X2_Attrs
    dfar KeyWorldRoom0A_Y1X3_Attrs
    dfar KeyWorldRoom08_Y2X0_Attrs
    dfar KeyWorldRoom12_Y2X3_Attrs
    dfar KeyWorldRoom09_Y1X1_Attrs
    dfar KeyWorldRoom04_Y2X2_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom08_Y1X2_Attrs
    dfar KeyWorldRoom0A_Y3X1_Attrs
    dfar KeyWorldRoom00_Y3X2_Attrs
KeyWorldRoom4F:: ; heuristic: string; C0
    db $01, $02, $04 ; id 79
    dfar KeyWorldRoom0B_Y0X2_Tiles
    dfar KeyWorldRoom09_Y0X1_Tiles
    dfar KeyWorldRoom03_Y3X2_Tiles
    dfar KeyWorldRoom00_Y0X3_Tiles
    dfar KeyWorldRoom02_Y1X2_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom10_Y2X3_Tiles
    dfar KeyWorldRoom01_Y1X3_Tiles
    dfar KeyWorldRoom09_Y2X1_Tiles
    dfar KeyWorldRoom01_Y2X1_Tiles
    dfar KeyWorldRoom02_Y2X0_Tiles
    dfar KeyWorldRoom02_Y1X3_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom08_Y1X3_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom04_Y3X3_Tiles
    dfar KeyWorldRoom0B_Y0X2_Attrs
    dfar KeyWorldRoom09_Y0X1_Attrs
    dfar KeyWorldRoom03_Y3X2_Attrs
    dfar KeyWorldRoom00_Y0X3_Attrs
    dfar KeyWorldRoom02_Y1X2_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom10_Y2X3_Attrs
    dfar KeyWorldRoom01_Y1X3_Attrs
    dfar KeyWorldRoom09_Y2X1_Attrs
    dfar KeyWorldRoom01_Y2X1_Attrs
    dfar KeyWorldRoom02_Y2X0_Attrs
    dfar KeyWorldRoom02_Y1X3_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom08_Y1X3_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom04_Y3X3_Attrs
KeyWorldRoom50:: ; heuristic: string; C0
    db $01, $02, $04 ; id 80
    dfar KeyWorldRoom0B_Y2X0_Tiles
    dfar KeyWorldRoom09_Y1X2_Tiles
    dfar KeyWorldRoom0F_Y0X2_Tiles
    dfar KeyWorldRoom0F_Y0X3_Tiles
    dfar KeyWorldRoom05_Y1X1_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom11_Y1X2_Tiles
    dfar KeyWorldRoom11_Y2X1_Tiles
    dfar KeyWorldRoom0F_Y1X0_Tiles
    dfar KeyWorldRoom04_Y0X2_Tiles
    dfar KeyWorldRoom0A_Y2X1_Tiles
    dfar KeyWorldRoom03_Y1X0_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom00_Y0X1_Tiles
    dfar KeyWorldRoom09_Y3X1_Tiles
    dfar KeyWorldRoom08_Y3X3_Tiles
    dfar KeyWorldRoom0B_Y2X0_Attrs
    dfar KeyWorldRoom09_Y1X2_Attrs
    dfar KeyWorldRoom0F_Y0X2_Attrs
    dfar KeyWorldRoom0F_Y0X3_Attrs
    dfar KeyWorldRoom05_Y1X1_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom11_Y1X2_Attrs
    dfar KeyWorldRoom11_Y2X1_Attrs
    dfar KeyWorldRoom0F_Y1X0_Attrs
    dfar KeyWorldRoom04_Y0X2_Attrs
    dfar KeyWorldRoom0A_Y2X1_Attrs
    dfar KeyWorldRoom03_Y1X0_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom00_Y0X1_Attrs
    dfar KeyWorldRoom09_Y3X1_Attrs
    dfar KeyWorldRoom08_Y3X3_Attrs
KeyWorldRoom51:: ; heuristic: key-world room record; C0
Data_072_60D4:: ; address name
    db $01, $02, $04 ; id 81
    dfar KeyWorldRoom10_Y0X1_Tiles
    dfar KeyWorldRoom25_Y0X2_Tiles
    dfar KeyWorldRoom11_Y0X2_Tiles
    dfar KeyWorldRoom04_Y0X0_Tiles
    dfar KeyWorldRoom0A_Y1X2_Tiles
    dfar KeyWorldRoom00_Y3X1_Tiles
    dfar KeyWorldRoom03_Y2X2_Tiles
    dfar KeyWorldRoom0B_Y1X1_Tiles
    dfar KeyWorldRoom07_Y1X0_Tiles
    dfar KeyWorldRoom0A_Y0X1_Tiles
    dfar KeyWorldRoom02_Y3X2_Tiles
    dfar KeyWorldRoom02_Y2X3_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom02_Y2X2_Tiles
    dfar KeyWorldRoom03_Y0X1_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom10_Y0X1_Attrs
    dfar KeyWorldRoom25_Y0X2_Attrs
    dfar KeyWorldRoom11_Y0X2_Attrs
    dfar KeyWorldRoom04_Y0X0_Attrs
    dfar KeyWorldRoom0A_Y1X2_Attrs
    dfar KeyWorldRoom00_Y3X1_Attrs
    dfar KeyWorldRoom03_Y2X2_Attrs
    dfar KeyWorldRoom0B_Y1X1_Attrs
    dfar KeyWorldRoom07_Y1X0_Attrs
    dfar KeyWorldRoom0A_Y0X1_Attrs
    dfar KeyWorldRoom02_Y3X2_Attrs
    dfar KeyWorldRoom02_Y2X3_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom02_Y2X2_Attrs
    dfar KeyWorldRoom03_Y0X1_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
KeyWorldRoom52:: ; heuristic: key-world room record; C0
Data_072_6137:: ; address name
    db $01, $02, $04 ; id 82
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom0B_Y0X2_Tiles
    dfar KeyWorldRoom00_Y3X2_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom29_Y2X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom52_Y2X0_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X1_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom0B_Y0X2_Attrs
    dfar KeyWorldRoom00_Y3X2_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom29_Y2X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom52_Y2X0_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X1_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
KeyWorldRoom53:: ; heuristic: key-world room record; C0
Data_072_619A:: ; address name
    db $01, $02, $04 ; id 83
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom45_Y1X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom04_Y0X0_Tiles
    dfar KeyWorldRoom53_Y1X0_Tiles
    dfar KeyWorldRoom07_Y1X2_Tiles
    dfar KeyWorldRoom3D_Y1X1_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom0D_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom04_Y1X1_Tiles
    dfar KeyWorldRoom04_Y3X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom45_Y1X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom04_Y0X0_Attrs
    dfar KeyWorldRoom53_Y1X0_Attrs
    dfar KeyWorldRoom07_Y1X2_Attrs
    dfar KeyWorldRoom3D_Y1X1_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom0D_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom04_Y1X1_Attrs
    dfar KeyWorldRoom04_Y3X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
KeyWorldRoom54:: ; heuristic: string; C0
    db $01, $02, $05 ; id 84
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom01_Y0X1_Tiles
    dfar KeyWorldRoom00_Y0X2_Tiles
    dfar KeyWorldRoom00_Y3X2_Tiles
    dfar KeyWorldRoom00_Y2X1_Tiles
    dfar KeyWorldRoom07_Y1X2_Tiles
    dfar KeyWorldRoom00_Y0X1_Tiles
    dfar KeyWorldRoom0F_Y0X3_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom00_Y2X1_Tiles
    dfar KeyWorldRoom00_Y0X2_Tiles
    dfar KeyWorldRoom32_Y0X3_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom00_Y3X1_Tiles
    dfar KeyWorldRoom00_Y0X1_Tiles
    dfar KeyWorldRoom0F_Y0X3_Tiles
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom01_Y0X1_Attrs
    dfar KeyWorldRoom00_Y0X2_Attrs
    dfar KeyWorldRoom00_Y3X2_Attrs
    dfar KeyWorldRoom00_Y2X1_Attrs
    dfar KeyWorldRoom07_Y1X2_Attrs
    dfar KeyWorldRoom00_Y0X1_Attrs
    dfar KeyWorldRoom0F_Y0X3_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom00_Y2X1_Attrs
    dfar KeyWorldRoom00_Y0X2_Attrs
    dfar KeyWorldRoom32_Y0X3_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom00_Y3X1_Attrs
    dfar KeyWorldRoom00_Y0X1_Attrs
    dfar KeyWorldRoom0F_Y0X3_Attrs
KeyWorldRoom55:: ; heuristic: key-world room record; C0
Data_072_6260:: ; address name
    db $01, $02, $05 ; id 85
    dfar KeyWorldRoom10_Y2X0_Tiles
    dfar KeyWorldRoom0A_Y0X2_Tiles
    dfar KeyWorldRoom01_Y0X1_Tiles
    dfar KeyWorldRoom0F_Y0X3_Tiles
    dfar KeyWorldRoom02_Y1X0_Tiles
    dfar KeyWorldRoom0B_Y1X1_Tiles
    dfar KeyWorldRoom08_Y1X0_Tiles
    dfar KeyWorldRoom32_Y0X3_Tiles
    dfar KeyWorldRoom03_Y1X3_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom08_Y2X0_Tiles
    dfar KeyWorldRoom2D_Y0X3_Tiles
    dfar KeyWorldRoom02_Y2X1_Tiles
    dfar KeyWorldRoom03_Y2X2_Tiles
    dfar KeyWorldRoom08_Y1X2_Tiles
    dfar KeyWorldRoom00_Y3X2_Tiles
    dfar KeyWorldRoom10_Y2X0_Attrs
    dfar KeyWorldRoom0A_Y0X2_Attrs
    dfar KeyWorldRoom01_Y0X1_Attrs
    dfar KeyWorldRoom0F_Y0X3_Attrs
    dfar KeyWorldRoom02_Y1X0_Attrs
    dfar KeyWorldRoom0B_Y1X1_Attrs
    dfar KeyWorldRoom08_Y1X0_Attrs
    dfar KeyWorldRoom32_Y0X3_Attrs
    dfar KeyWorldRoom03_Y1X3_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom08_Y2X0_Attrs
    dfar KeyWorldRoom2D_Y0X3_Attrs
    dfar KeyWorldRoom02_Y2X1_Attrs
    dfar KeyWorldRoom03_Y2X2_Attrs
    dfar KeyWorldRoom08_Y1X2_Attrs
    dfar KeyWorldRoom00_Y3X2_Attrs
KeyWorldRoom56:: ; heuristic: string; C0
    db $01, $02, $05 ; id 86
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom04_Y0X2_Tiles
    dfar KeyWorldRoom03_Y3X1_Tiles
    dfar KeyWorldRoom0F_Y0X3_Tiles
    dfar KeyWorldRoom02_Y1X3_Tiles
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom12_Y2X3_Tiles
    dfar KeyWorldRoom19_Y1X0_Tiles
    dfar KeyWorldRoom01_Y1X3_Tiles
    dfar KeyWorldRoom03_Y2X1_Tiles
    dfar KeyWorldRoom09_Y3X1_Tiles
    dfar KeyWorldRoom04_Y1X3_Tiles
    dfar KeyWorldRoom02_Y3X0_Tiles
    dfar KeyWorldRoom03_Y3X2_Tiles
    dfar KeyWorldRoom03_Y0X2_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom04_Y0X2_Attrs
    dfar KeyWorldRoom03_Y3X1_Attrs
    dfar KeyWorldRoom0F_Y0X3_Attrs
    dfar KeyWorldRoom02_Y1X3_Attrs
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom12_Y2X3_Attrs
    dfar KeyWorldRoom19_Y1X0_Attrs
    dfar KeyWorldRoom01_Y1X3_Attrs
    dfar KeyWorldRoom03_Y2X1_Attrs
    dfar KeyWorldRoom09_Y3X1_Attrs
    dfar KeyWorldRoom04_Y1X3_Attrs
    dfar KeyWorldRoom02_Y3X0_Attrs
    dfar KeyWorldRoom03_Y3X2_Attrs
    dfar KeyWorldRoom03_Y0X2_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
KeyWorldRoom57:: ; heuristic: key-world room record; C0
Data_072_6326:: ; address name
    db $01, $02, $05 ; id 87
    dfar KeyWorldRoom0B_Y0X2_Tiles
    dfar KeyWorldRoom00_Y0X2_Tiles
    dfar KeyWorldRoom03_Y3X1_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom09_Y1X1_Tiles
    dfar KeyWorldRoom06_Y1X1_Tiles
    dfar KeyWorldRoom02_Y3X2_Tiles
    dfar KeyWorldRoom03_Y2X3_Tiles
    dfar KeyWorldRoom02_Y1X2_Tiles
    dfar KeyWorldRoom09_Y2X1_Tiles
    dfar KeyWorldRoom03_Y0X2_Tiles
    dfar KeyWorldRoom00_Y0X3_Tiles
    dfar KeyWorldRoom03_Y3X0_Tiles
    dfar KeyWorldRoom0A_Y3X1_Tiles
    dfar KeyWorldRoom03_Y0X1_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom0B_Y0X2_Attrs
    dfar KeyWorldRoom00_Y0X2_Attrs
    dfar KeyWorldRoom03_Y3X1_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom09_Y1X1_Attrs
    dfar KeyWorldRoom06_Y1X1_Attrs
    dfar KeyWorldRoom02_Y3X2_Attrs
    dfar KeyWorldRoom03_Y2X3_Attrs
    dfar KeyWorldRoom02_Y1X2_Attrs
    dfar KeyWorldRoom09_Y2X1_Attrs
    dfar KeyWorldRoom03_Y0X2_Attrs
    dfar KeyWorldRoom00_Y0X3_Attrs
    dfar KeyWorldRoom03_Y3X0_Attrs
    dfar KeyWorldRoom0A_Y3X1_Attrs
    dfar KeyWorldRoom03_Y0X1_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
KeyWorldRoom58:: ; heuristic: string; C0
    db $01, $02, $05 ; id 88
    dfar KeyWorldRoom0B_Y2X0_Tiles
    dfar KeyWorldRoom08_Y0X1_Tiles
    dfar KeyWorldRoom08_Y0X2_Tiles
    dfar KeyWorldRoom00_Y3X2_Tiles
    dfar KeyWorldRoom03_Y1X0_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom0A_Y1X2_Tiles
    dfar KeyWorldRoom0F_Y0X3_Tiles
    dfar KeyWorldRoom07_Y1X0_Tiles
    dfar KeyWorldRoom16_Y2X2_Tiles
    dfar KeyWorldRoom0A_Y1X1_Tiles
    dfar KeyWorldRoom04_Y0X0_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom0A_Y3X2_Tiles
    dfar KeyWorldRoom03_Y2X2_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom0B_Y2X0_Attrs
    dfar KeyWorldRoom08_Y0X1_Attrs
    dfar KeyWorldRoom08_Y0X2_Attrs
    dfar KeyWorldRoom00_Y3X2_Attrs
    dfar KeyWorldRoom03_Y1X0_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom0A_Y1X2_Attrs
    dfar KeyWorldRoom0F_Y0X3_Attrs
    dfar KeyWorldRoom07_Y1X0_Attrs
    dfar KeyWorldRoom16_Y2X2_Attrs
    dfar KeyWorldRoom0A_Y1X1_Attrs
    dfar KeyWorldRoom04_Y0X0_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom0A_Y3X2_Attrs
    dfar KeyWorldRoom03_Y2X2_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
KeyWorldRoom59:: ; heuristic: key-world room record; C0
Data_072_63EC:: ; address name
    db $01, $02, $05 ; id 89
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom02_Y0X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom02_Y0X1_Tiles
    dfar KeyWorldRoom01_Y0X1_Tiles
    dfar KeyWorldRoom02_Y3X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom37_Y2X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom02_Y3X0_Tiles
    dfar KeyWorldRoom0F_Y0X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom02_Y0X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom02_Y0X1_Attrs
    dfar KeyWorldRoom01_Y0X1_Attrs
    dfar KeyWorldRoom02_Y3X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom37_Y2X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom02_Y3X0_Attrs
    dfar KeyWorldRoom0F_Y0X3_Attrs
KeyWorldRoom5A:: ; heuristic: key-world room record; C0
Data_072_644F:: ; address name
    db $01, $02, $05 ; id 90
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom37_Y0X2_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom04_Y0X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom07_Y1X0_Tiles
    dfar KeyWorldRoom5A_Y1X2_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom08_Y2X0_Tiles
    dfar KeyWorldRoom03_Y3X1_Tiles
    dfar KeyWorldRoom4B_Y1X2_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom06_Y3X1_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X1_Tiles
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom37_Y0X2_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom04_Y0X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom07_Y1X0_Attrs
    dfar KeyWorldRoom5A_Y1X2_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom08_Y2X0_Attrs
    dfar KeyWorldRoom03_Y3X1_Attrs
    dfar KeyWorldRoom4B_Y1X2_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom06_Y3X1_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X1_Attrs
KeyWorldRoom5B:: ; heuristic: string; C0
    db $01, $03, $04 ; id 91
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom00_Y0X2_Tiles
    dfar KeyWorldRoom01_Y0X1_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom07_Y1X0_Tiles
    dfar KeyWorldRoom01_Y0X1_Tiles
    dfar KeyWorldRoom0B_Y1X1_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom00_Y0X2_Attrs
    dfar KeyWorldRoom01_Y0X1_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom07_Y1X0_Attrs
    dfar KeyWorldRoom01_Y0X1_Attrs
    dfar KeyWorldRoom0B_Y1X1_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
KeyWorldRoom5C:: ; heuristic: string; C0
    db $01, $03, $04 ; id 92
    dfar KeyWorldRoom10_Y0X2_Tiles
    dfar KeyWorldRoom1D_Y0X3_Tiles
    dfar KeyWorldRoom0F_Y0X2_Tiles
    dfar KeyWorldRoom00_Y3X2_Tiles
    dfar KeyWorldRoom02_Y1X0_Tiles
    dfar KeyWorldRoom07_Y1X2_Tiles
    dfar KeyWorldRoom00_Y3X1_Tiles
    dfar KeyWorldRoom06_Y0X1_Tiles
    dfar KeyWorldRoom03_Y1X3_Tiles
    dfar KeyWorldRoom02_Y2X1_Tiles
    dfar KeyWorldRoom00_Y0X2_Tiles
    dfar KeyWorldRoom01_Y2X1_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom2D_Y0X3_Tiles
    dfar KeyWorldRoom04_Y2X1_Tiles
    dfar KeyWorldRoom04_Y3X3_Tiles
    dfar KeyWorldRoom10_Y0X2_Attrs
    dfar KeyWorldRoom1D_Y0X3_Attrs
    dfar KeyWorldRoom0F_Y0X2_Attrs
    dfar KeyWorldRoom00_Y3X2_Attrs
    dfar KeyWorldRoom02_Y1X0_Attrs
    dfar KeyWorldRoom07_Y1X2_Attrs
    dfar KeyWorldRoom00_Y3X1_Attrs
    dfar KeyWorldRoom06_Y0X1_Attrs
    dfar KeyWorldRoom03_Y1X3_Attrs
    dfar KeyWorldRoom02_Y2X1_Attrs
    dfar KeyWorldRoom00_Y0X2_Attrs
    dfar KeyWorldRoom01_Y2X1_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom2D_Y0X3_Attrs
    dfar KeyWorldRoom04_Y2X1_Attrs
    dfar KeyWorldRoom04_Y3X3_Attrs
KeyWorldRoom5D:: ; heuristic: string; C0
    db $01, $03, $04 ; id 93
    dfar KeyWorldRoom0F_Y1X0_Tiles
    dfar KeyWorldRoom09_Y0X1_Tiles
    dfar KeyWorldRoom04_Y0X2_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom08_Y1X0_Tiles
    dfar KeyWorldRoom08_Y2X1_Tiles
    dfar KeyWorldRoom00_Y0X1_Tiles
    dfar KeyWorldRoom0A_Y1X3_Tiles
    dfar KeyWorldRoom08_Y2X0_Tiles
    dfar KeyWorldRoom02_Y2X2_Tiles
    dfar KeyWorldRoom06_Y1X1_Tiles
    dfar KeyWorldRoom01_Y1X2_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom32_Y0X3_Tiles
    dfar KeyWorldRoom08_Y3X1_Tiles
    dfar KeyWorldRoom00_Y3X3_Tiles
    dfar KeyWorldRoom0F_Y1X0_Attrs
    dfar KeyWorldRoom09_Y0X1_Attrs
    dfar KeyWorldRoom04_Y0X2_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom08_Y1X0_Attrs
    dfar KeyWorldRoom08_Y2X1_Attrs
    dfar KeyWorldRoom00_Y0X1_Attrs
    dfar KeyWorldRoom0A_Y1X3_Attrs
    dfar KeyWorldRoom08_Y2X0_Attrs
    dfar KeyWorldRoom02_Y2X2_Attrs
    dfar KeyWorldRoom06_Y1X1_Attrs
    dfar KeyWorldRoom01_Y1X2_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom32_Y0X3_Attrs
    dfar KeyWorldRoom08_Y3X1_Attrs
    dfar KeyWorldRoom00_Y3X3_Attrs
KeyWorldRoom5E:: ; heuristic: key-world room record; C0
Data_072_65DB:: ; address name
    db $01, $03, $04 ; id 94
    dfar KeyWorldRoom0A_Y2X0_Tiles
    dfar KeyWorldRoom03_Y1X2_Tiles
    dfar KeyWorldRoom10_Y2X0_Tiles
    dfar KeyWorldRoom00_Y0X3_Tiles
    dfar KeyWorldRoom09_Y1X1_Tiles
    dfar KeyWorldRoom0B_Y2X1_Tiles
    dfar KeyWorldRoom10_Y2X1_Tiles
    dfar KeyWorldRoom0A_Y2X1_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom02_Y3X0_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom01_Y1X3_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom02_Y3X2_Tiles
    dfar KeyWorldRoom03_Y3X1_Tiles
    dfar KeyWorldRoom08_Y1X3_Tiles
    dfar KeyWorldRoom0A_Y2X0_Attrs
    dfar KeyWorldRoom03_Y1X2_Attrs
    dfar KeyWorldRoom10_Y2X0_Attrs
    dfar KeyWorldRoom00_Y0X3_Attrs
    dfar KeyWorldRoom09_Y1X1_Attrs
    dfar KeyWorldRoom0B_Y2X1_Attrs
    dfar KeyWorldRoom10_Y2X1_Attrs
    dfar KeyWorldRoom0A_Y2X1_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom02_Y3X0_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
    dfar KeyWorldRoom01_Y1X3_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom02_Y3X2_Attrs
    dfar KeyWorldRoom03_Y3X1_Attrs
    dfar KeyWorldRoom08_Y1X3_Attrs
KeyWorldRoom5F:: ; heuristic: key-world room record; C0
Data_072_663E:: ; address name
    db $01, $03, $04 ; id 95
    dfar KeyWorldRoom1B_Y3X1_Tiles
    dfar KeyWorldRoom11_Y2X1_Tiles
    dfar KeyWorldRoom25_Y0X2_Tiles
    dfar KeyWorldRoom04_Y0X0_Tiles
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom10_Y2X2_Tiles
    dfar KeyWorldRoom03_Y2X2_Tiles
    dfar KeyWorldRoom01_Y2X3_Tiles
    dfar KeyWorldRoom02_Y1X2_Tiles
    dfar KeyWorldRoom09_Y2X1_Tiles
    dfar KeyWorldRoom00_Y0X2_Tiles
    dfar KeyWorldRoom04_Y1X3_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom08_Y1X2_Tiles
    dfar KeyWorldRoom03_Y0X2_Tiles
    dfar KeyWorldRoom02_Y3X3_Tiles
    dfar KeyWorldRoom1B_Y3X1_Attrs
    dfar KeyWorldRoom11_Y2X1_Attrs
    dfar KeyWorldRoom25_Y0X2_Attrs
    dfar KeyWorldRoom04_Y0X0_Attrs
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom10_Y2X2_Attrs
    dfar KeyWorldRoom03_Y2X2_Attrs
    dfar KeyWorldRoom01_Y2X3_Attrs
    dfar KeyWorldRoom02_Y1X2_Attrs
    dfar KeyWorldRoom09_Y2X1_Attrs
    dfar KeyWorldRoom00_Y0X2_Attrs
    dfar KeyWorldRoom04_Y1X3_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom08_Y1X2_Attrs
    dfar KeyWorldRoom03_Y0X2_Attrs
    dfar KeyWorldRoom02_Y3X3_Attrs
KeyWorldRoom60:: ; heuristic: key-world room record; C0
Data_072_66A1:: ; address name
    db $01, $03, $04 ; id 96
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom02_Y0X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom02_Y1X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom10_Y2X0_Tiles
    dfar KeyWorldRoom00_Y0X2_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom02_Y0X1_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom02_Y0X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom02_Y1X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom10_Y2X0_Attrs
    dfar KeyWorldRoom00_Y0X2_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
    dfar KeyWorldRoom02_Y0X1_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
KeyWorldRoom61:: ; heuristic: key-world room record; C0
Data_072_6704:: ; address name
    db $01, $03, $04 ; id 97
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom44_Y2X0_Tiles
    dfar KeyWorldRoom00_Y3X2_Tiles
    dfar KeyWorldRoom61_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom09_Y1X1_Tiles
    dfar KeyWorldRoom5A_Y1X2_Tiles
    dfar KeyWorldRoom02_Y1X0_Tiles
    dfar KeyWorldRoom04_Y0X2_Tiles
    dfar KeyWorldRoom01_Y1X2_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X1_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom61_Y3X2_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom44_Y2X0_Attrs
    dfar KeyWorldRoom00_Y3X2_Attrs
    dfar KeyWorldRoom61_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom09_Y1X1_Attrs
    dfar KeyWorldRoom5A_Y1X2_Attrs
    dfar KeyWorldRoom02_Y1X0_Attrs
    dfar KeyWorldRoom04_Y0X2_Attrs
    dfar KeyWorldRoom01_Y1X2_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X1_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom61_Y3X2_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
KeyWorldRoom62:: ; heuristic: string; C0
    db $01, $03, $05 ; id 98
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom01_Y0X1_Tiles
    dfar KeyWorldRoom00_Y0X2_Tiles
    dfar KeyWorldRoom00_Y3X2_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom07_Y1X0_Tiles
    dfar KeyWorldRoom00_Y0X1_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom05_Y1X1_Tiles
    dfar KeyWorldRoom04_Y0X0_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom00_Y0X2_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom00_Y3X3_Tiles
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom01_Y0X1_Attrs
    dfar KeyWorldRoom00_Y0X2_Attrs
    dfar KeyWorldRoom00_Y3X2_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom07_Y1X0_Attrs
    dfar KeyWorldRoom00_Y0X1_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom05_Y1X1_Attrs
    dfar KeyWorldRoom04_Y0X0_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom00_Y0X2_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
    dfar KeyWorldRoom00_Y3X3_Attrs
KeyWorldRoom63:: ; heuristic: string; C0
    db $01, $03, $05 ; id 99
    dfar KeyWorldRoom0B_Y0X2_Tiles
    dfar KeyWorldRoom0A_Y0X2_Tiles
    dfar KeyWorldRoom06_Y1X1_Tiles
    dfar KeyWorldRoom00_Y0X3_Tiles
    dfar KeyWorldRoom0A_Y1X2_Tiles
    dfar KeyWorldRoom02_Y2X3_Tiles
    dfar KeyWorldRoom02_Y2X0_Tiles
    dfar KeyWorldRoom02_Y1X3_Tiles
    dfar KeyWorldRoom07_Y1X0_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom00_Y2X1_Tiles
    dfar KeyWorldRoom0A_Y1X1_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom03_Y3X2_Tiles
    dfar KeyWorldRoom03_Y2X3_Tiles
    dfar KeyWorldRoom05_Y1X1_Tiles
    dfar KeyWorldRoom0B_Y0X2_Attrs
    dfar KeyWorldRoom0A_Y0X2_Attrs
    dfar KeyWorldRoom06_Y1X1_Attrs
    dfar KeyWorldRoom00_Y0X3_Attrs
    dfar KeyWorldRoom0A_Y1X2_Attrs
    dfar KeyWorldRoom02_Y2X3_Attrs
    dfar KeyWorldRoom02_Y2X0_Attrs
    dfar KeyWorldRoom02_Y1X3_Attrs
    dfar KeyWorldRoom07_Y1X0_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
    dfar KeyWorldRoom00_Y2X1_Attrs
    dfar KeyWorldRoom0A_Y1X1_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom03_Y3X2_Attrs
    dfar KeyWorldRoom03_Y2X3_Attrs
    dfar KeyWorldRoom05_Y1X1_Attrs
KeyWorldRoom64:: ; heuristic: key-world room record; C0
Data_072_682D:: ; address name
    db $01, $03, $05 ; id 100
    dfar KeyWorldRoom11_Y0X2_Tiles
    dfar KeyWorldRoom0B_Y2X0_Tiles
    dfar KeyWorldRoom00_Y0X2_Tiles
    dfar KeyWorldRoom0F_Y0X3_Tiles
    dfar KeyWorldRoom03_Y1X0_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom1D_Y3X1_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom08_Y1X0_Tiles
    dfar KeyWorldRoom09_Y3X1_Tiles
    dfar KeyWorldRoom0F_Y0X3_Tiles
    dfar KeyWorldRoom03_Y1X3_Tiles
    dfar KeyWorldRoom01_Y2X2_Tiles
    dfar KeyWorldRoom02_Y3X2_Tiles
    dfar KeyWorldRoom04_Y0X2_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom11_Y0X2_Attrs
    dfar KeyWorldRoom0B_Y2X0_Attrs
    dfar KeyWorldRoom00_Y0X2_Attrs
    dfar KeyWorldRoom0F_Y0X3_Attrs
    dfar KeyWorldRoom03_Y1X0_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom1D_Y3X1_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom08_Y1X0_Attrs
    dfar KeyWorldRoom09_Y3X1_Attrs
    dfar KeyWorldRoom0F_Y0X3_Attrs
    dfar KeyWorldRoom03_Y1X3_Attrs
    dfar KeyWorldRoom01_Y2X2_Attrs
    dfar KeyWorldRoom02_Y3X2_Attrs
    dfar KeyWorldRoom04_Y0X2_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
KeyWorldRoom65:: ; heuristic: string; C0
    db $01, $03, $05 ; id 101
    dfar KeyWorldRoom0F_Y0X2_Tiles
    dfar KeyWorldRoom03_Y3X1_Tiles
    dfar KeyWorldRoom08_Y0X1_Tiles
    dfar KeyWorldRoom00_Y3X2_Tiles
    dfar KeyWorldRoom08_Y2X0_Tiles
    dfar KeyWorldRoom03_Y0X2_Tiles
    dfar KeyWorldRoom0A_Y3X1_Tiles
    dfar KeyWorldRoom01_Y2X1_Tiles
    dfar KeyWorldRoom09_Y1X1_Tiles
    dfar KeyWorldRoom08_Y0X2_Tiles
    dfar KeyWorldRoom0F_Y0X3_Tiles
    dfar KeyWorldRoom01_Y1X3_Tiles
    dfar KeyWorldRoom01_Y3X0_Tiles
    dfar KeyWorldRoom0A_Y3X2_Tiles
    dfar KeyWorldRoom03_Y0X1_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom0F_Y0X2_Attrs
    dfar KeyWorldRoom03_Y3X1_Attrs
    dfar KeyWorldRoom08_Y0X1_Attrs
    dfar KeyWorldRoom00_Y3X2_Attrs
    dfar KeyWorldRoom08_Y2X0_Attrs
    dfar KeyWorldRoom03_Y0X2_Attrs
    dfar KeyWorldRoom0A_Y3X1_Attrs
    dfar KeyWorldRoom01_Y2X1_Attrs
    dfar KeyWorldRoom09_Y1X1_Attrs
    dfar KeyWorldRoom08_Y0X2_Attrs
    dfar KeyWorldRoom0F_Y0X3_Attrs
    dfar KeyWorldRoom01_Y1X3_Attrs
    dfar KeyWorldRoom01_Y3X0_Attrs
    dfar KeyWorldRoom0A_Y3X2_Attrs
    dfar KeyWorldRoom03_Y0X1_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
KeyWorldRoom66:: ; heuristic: key-world room record; C0
Data_072_68F3:: ; address name
    db $01, $03, $05 ; id 102
    dfar KeyWorldRoom10_Y2X0_Tiles
    dfar KeyWorldRoom1D_Y0X1_Tiles
    dfar KeyWorldRoom03_Y3X2_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom02_Y2X1_Tiles
    dfar KeyWorldRoom11_Y1X2_Tiles
    dfar KeyWorldRoom10_Y2X3_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom0F_Y1X0_Tiles
    dfar KeyWorldRoom16_Y2X2_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom02_Y1X2_Tiles
    dfar KeyWorldRoom02_Y3X0_Tiles
    dfar KeyWorldRoom01_Y3X1_Tiles
    dfar KeyWorldRoom04_Y0X2_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom10_Y2X0_Attrs
    dfar KeyWorldRoom1D_Y0X1_Attrs
    dfar KeyWorldRoom03_Y3X2_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom02_Y2X1_Attrs
    dfar KeyWorldRoom11_Y1X2_Attrs
    dfar KeyWorldRoom10_Y2X3_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom0F_Y1X0_Attrs
    dfar KeyWorldRoom16_Y2X2_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
    dfar KeyWorldRoom02_Y1X2_Attrs
    dfar KeyWorldRoom02_Y3X0_Attrs
    dfar KeyWorldRoom01_Y3X1_Attrs
    dfar KeyWorldRoom04_Y0X2_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
KeyWorldRoom67:: ; heuristic: key-world room record; C0
Data_072_6956:: ; address name
    db $01, $03, $05 ; id 103
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom02_Y0X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom67_Y1X2_Tiles
    dfar KeyWorldRoom08_Y3X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom67_Y2X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X1_Tiles
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom02_Y0X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom67_Y1X2_Attrs
    dfar KeyWorldRoom08_Y3X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom67_Y2X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X1_Attrs
KeyWorldRoom68:: ; heuristic: key-world room record; C0
Data_072_69B9:: ; address name
    db $01, $03, $05 ; id 104
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom0F_Y0X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom14_Y2X1_Tiles
    dfar KeyWorldRoom0A_Y1X1_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom68_Y3X2_Tiles
    dfar KeyWorldRoom0F_Y0X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom0F_Y0X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom14_Y2X1_Attrs
    dfar KeyWorldRoom0A_Y1X1_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom68_Y3X2_Attrs
    dfar KeyWorldRoom0F_Y0X3_Attrs
KeyWorldRoom69:: ; heuristic: key-world room record; C0
Data_072_6A1C:: ; address name
    db $01, $04, $05 ; id 105
    dfar KeyWorldRoom02_Y0X1_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom0F_Y0X3_Tiles
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom01_Y1X2_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom02_Y0X0_Tiles
    dfar KeyWorldRoom00_Y2X1_Tiles
    dfar KeyWorldRoom00_Y3X1_Tiles
    dfar KeyWorldRoom08_Y1X1_Tiles
    dfar KeyWorldRoom0B_Y1X1_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom00_Y3X2_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom02_Y0X1_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom0F_Y0X3_Attrs
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom01_Y1X2_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom02_Y0X0_Attrs
    dfar KeyWorldRoom00_Y2X1_Attrs
    dfar KeyWorldRoom00_Y3X1_Attrs
    dfar KeyWorldRoom08_Y1X1_Attrs
    dfar KeyWorldRoom0B_Y1X1_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom00_Y3X2_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
KeyWorldRoom6A:: ; heuristic: key-world room record; C0
Data_072_6A7F:: ; address name
    db $01, $04, $05 ; id 106
    dfar KeyWorldRoom19_Y1X0_Tiles
    dfar KeyWorldRoom3A_Y3X2_Tiles
    dfar KeyWorldRoom09_Y0X1_Tiles
    dfar KeyWorldRoom00_Y0X3_Tiles
    dfar KeyWorldRoom0A_Y1X2_Tiles
    dfar KeyWorldRoom03_Y1X2_Tiles
    dfar KeyWorldRoom02_Y1X0_Tiles
    dfar KeyWorldRoom0A_Y2X1_Tiles
    dfar KeyWorldRoom07_Y1X0_Tiles
    dfar KeyWorldRoom08_Y1X1_Tiles
    dfar KeyWorldRoom02_Y2X2_Tiles
    dfar KeyWorldRoom0A_Y1X3_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom08_Y1X3_Tiles
    dfar KeyWorldRoom04_Y1X1_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom19_Y1X0_Attrs
    dfar KeyWorldRoom3A_Y3X2_Attrs
    dfar KeyWorldRoom09_Y0X1_Attrs
    dfar KeyWorldRoom00_Y0X3_Attrs
    dfar KeyWorldRoom0A_Y1X2_Attrs
    dfar KeyWorldRoom03_Y1X2_Attrs
    dfar KeyWorldRoom02_Y1X0_Attrs
    dfar KeyWorldRoom0A_Y2X1_Attrs
    dfar KeyWorldRoom07_Y1X0_Attrs
    dfar KeyWorldRoom08_Y1X1_Attrs
    dfar KeyWorldRoom02_Y2X2_Attrs
    dfar KeyWorldRoom0A_Y1X3_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom08_Y1X3_Attrs
    dfar KeyWorldRoom04_Y1X1_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
KeyWorldRoom6B:: ; heuristic: string; C0
    db $01, $04, $05 ; id 107
    dfar KeyWorldRoom1D_Y0X3_Tiles
    dfar KeyWorldRoom04_Y0X0_Tiles
    dfar KeyWorldRoom0A_Y2X0_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom08_Y1X0_Tiles
    dfar KeyWorldRoom08_Y2X1_Tiles
    dfar KeyWorldRoom03_Y2X2_Tiles
    dfar KeyWorldRoom03_Y2X3_Tiles
    dfar KeyWorldRoom08_Y2X0_Tiles
    dfar KeyWorldRoom08_Y1X2_Tiles
    dfar KeyWorldRoom0A_Y0X1_Tiles
    dfar KeyWorldRoom00_Y0X3_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom06_Y0X1_Tiles
    dfar KeyWorldRoom11_Y2X2_Tiles
    dfar KeyWorldRoom00_Y3X3_Tiles
    dfar KeyWorldRoom1D_Y0X3_Attrs
    dfar KeyWorldRoom04_Y0X0_Attrs
    dfar KeyWorldRoom0A_Y2X0_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom08_Y1X0_Attrs
    dfar KeyWorldRoom08_Y2X1_Attrs
    dfar KeyWorldRoom03_Y2X2_Attrs
    dfar KeyWorldRoom03_Y2X3_Attrs
    dfar KeyWorldRoom08_Y2X0_Attrs
    dfar KeyWorldRoom08_Y1X2_Attrs
    dfar KeyWorldRoom0A_Y0X1_Attrs
    dfar KeyWorldRoom00_Y0X3_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom06_Y0X1_Attrs
    dfar KeyWorldRoom11_Y2X2_Attrs
    dfar KeyWorldRoom00_Y3X3_Attrs
KeyWorldRoom6C:: ; heuristic: string; C0
    db $01, $04, $05 ; id 108
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom0A_Y0X2_Tiles
    dfar KeyWorldRoom00_Y0X1_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom09_Y1X1_Tiles
    dfar KeyWorldRoom09_Y3X1_Tiles
    dfar KeyWorldRoom02_Y3X2_Tiles
    dfar KeyWorldRoom01_Y2X3_Tiles
    dfar KeyWorldRoom09_Y2X1_Tiles
    dfar KeyWorldRoom01_Y0X1_Tiles
    dfar KeyWorldRoom08_Y0X1_Tiles
    dfar KeyWorldRoom0B_Y1X1_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom04_Y3X3_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom0A_Y0X2_Attrs
    dfar KeyWorldRoom00_Y0X1_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom09_Y1X1_Attrs
    dfar KeyWorldRoom09_Y3X1_Attrs
    dfar KeyWorldRoom02_Y3X2_Attrs
    dfar KeyWorldRoom01_Y2X3_Attrs
    dfar KeyWorldRoom09_Y2X1_Attrs
    dfar KeyWorldRoom01_Y0X1_Attrs
    dfar KeyWorldRoom08_Y0X1_Attrs
    dfar KeyWorldRoom0B_Y1X1_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom04_Y3X3_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
KeyWorldRoom6D:: ; heuristic: string; C0
    db $01, $04, $05 ; id 109
    dfar KeyWorldRoom0B_Y2X0_Tiles
    dfar KeyWorldRoom08_Y0X2_Tiles
    dfar KeyWorldRoom03_Y0X1_Tiles
    dfar KeyWorldRoom00_Y0X3_Tiles
    dfar KeyWorldRoom02_Y2X1_Tiles
    dfar KeyWorldRoom0A_Y3X1_Tiles
    dfar KeyWorldRoom01_Y2X1_Tiles
    dfar KeyWorldRoom02_Y1X3_Tiles
    dfar KeyWorldRoom0B_Y0X2_Tiles
    dfar KeyWorldRoom1D_Y0X1_Tiles
    dfar KeyWorldRoom0B_Y2X1_Tiles
    dfar KeyWorldRoom08_Y1X3_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom08_Y3X3_Tiles
    dfar KeyWorldRoom02_Y3X0_Tiles
    dfar KeyWorldRoom00_Y3X2_Tiles
    dfar KeyWorldRoom0B_Y2X0_Attrs
    dfar KeyWorldRoom08_Y0X2_Attrs
    dfar KeyWorldRoom03_Y0X1_Attrs
    dfar KeyWorldRoom00_Y0X3_Attrs
    dfar KeyWorldRoom02_Y2X1_Attrs
    dfar KeyWorldRoom0A_Y3X1_Attrs
    dfar KeyWorldRoom01_Y2X1_Attrs
    dfar KeyWorldRoom02_Y1X3_Attrs
    dfar KeyWorldRoom0B_Y0X2_Attrs
    dfar KeyWorldRoom1D_Y0X1_Attrs
    dfar KeyWorldRoom0B_Y2X1_Attrs
    dfar KeyWorldRoom08_Y1X3_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom08_Y3X3_Attrs
    dfar KeyWorldRoom02_Y3X0_Attrs
    dfar KeyWorldRoom00_Y3X2_Attrs
KeyWorldRoom6E:: ; heuristic: key-world room record; C0
Data_072_6C0B:: ; address name
    db $01, $04, $05 ; id 110
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom02_Y0X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom0F_Y1X0_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom3E_Y1X2_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom02_Y0X1_Tiles
    dfar KeyWorldRoom3D_Y1X1_Tiles
    dfar KeyWorldRoom0A_Y3X1_Tiles
    dfar KeyWorldRoom00_Y3X2_Tiles
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom02_Y0X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom0F_Y1X0_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom3E_Y1X2_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom02_Y0X1_Attrs
    dfar KeyWorldRoom3D_Y1X1_Attrs
    dfar KeyWorldRoom0A_Y3X1_Attrs
    dfar KeyWorldRoom00_Y3X2_Attrs
KeyWorldRoom6F:: ; heuristic: key-world room record; C0
Data_072_6C6E:: ; address name
    db $01, $04, $05 ; id 111
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom0F_Y0X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom67_Y2X3_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom03_Y1X2_Tiles
    dfar KeyWorldRoom00_Y3X3_Tiles
    dfar KeyWorldRoom03_Y3X0_Tiles
    dfar KeyWorldRoom3E_Y0X1_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom0F_Y0X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom67_Y2X3_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom03_Y1X2_Attrs
    dfar KeyWorldRoom00_Y3X3_Attrs
    dfar KeyWorldRoom03_Y3X0_Attrs
    dfar KeyWorldRoom3E_Y0X1_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
KeyWorldRoom70:: ; heuristic: string; C0
    db $02, $03, $04 ; id 112
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom00_Y0X1_Tiles
    dfar KeyWorldRoom06_Y1X1_Tiles
    dfar KeyWorldRoom00_Y0X3_Tiles
    dfar KeyWorldRoom00_Y2X1_Tiles
    dfar KeyWorldRoom06_Y1X1_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom07_Y1X0_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom01_Y1X2_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom00_Y0X2_Tiles
    dfar KeyWorldRoom01_Y3X1_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom00_Y0X1_Attrs
    dfar KeyWorldRoom06_Y1X1_Attrs
    dfar KeyWorldRoom00_Y0X3_Attrs
    dfar KeyWorldRoom00_Y2X1_Attrs
    dfar KeyWorldRoom06_Y1X1_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom07_Y1X0_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom01_Y1X2_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom00_Y0X2_Attrs
    dfar KeyWorldRoom01_Y3X1_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
KeyWorldRoom71:: ; heuristic: string; C0
    db $02, $03, $04 ; id 113
    dfar KeyWorldRoom10_Y0X1_Tiles
    dfar KeyWorldRoom0F_Y1X0_Tiles
    dfar KeyWorldRoom03_Y0X2_Tiles
    dfar KeyWorldRoom09_Y1X2_Tiles
    dfar KeyWorldRoom0A_Y1X2_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom10_Y0X2_Tiles
    dfar KeyWorldRoom02_Y2X0_Tiles
    dfar KeyWorldRoom03_Y1X0_Tiles
    dfar KeyWorldRoom0F_Y0X2_Tiles
    dfar KeyWorldRoom07_Y1X2_Tiles
    dfar KeyWorldRoom02_Y3X3_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom00_Y3X1_Tiles
    dfar KeyWorldRoom0A_Y3X2_Tiles
    dfar KeyWorldRoom2D_Y0X3_Tiles
    dfar KeyWorldRoom10_Y0X1_Attrs
    dfar KeyWorldRoom0F_Y1X0_Attrs
    dfar KeyWorldRoom03_Y0X2_Attrs
    dfar KeyWorldRoom09_Y1X2_Attrs
    dfar KeyWorldRoom0A_Y1X2_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
    dfar KeyWorldRoom10_Y0X2_Attrs
    dfar KeyWorldRoom02_Y2X0_Attrs
    dfar KeyWorldRoom03_Y1X0_Attrs
    dfar KeyWorldRoom0F_Y0X2_Attrs
    dfar KeyWorldRoom07_Y1X2_Attrs
    dfar KeyWorldRoom02_Y3X3_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom00_Y3X1_Attrs
    dfar KeyWorldRoom0A_Y3X2_Attrs
    dfar KeyWorldRoom2D_Y0X3_Attrs
KeyWorldRoom72:: ; heuristic: string; C0
    db $02, $03, $04 ; id 114
    dfar KeyWorldRoom10_Y2X0_Tiles
    dfar KeyWorldRoom09_Y0X1_Tiles
    dfar KeyWorldRoom0A_Y0X1_Tiles
    dfar KeyWorldRoom11_Y2X1_Tiles
    dfar KeyWorldRoom03_Y1X3_Tiles
    dfar KeyWorldRoom05_Y1X1_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom00_Y2X1_Tiles
    dfar KeyWorldRoom03_Y3X2_Tiles
    dfar KeyWorldRoom08_Y1X1_Tiles
    dfar KeyWorldRoom02_Y2X3_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom03_Y3X1_Tiles
    dfar KeyWorldRoom03_Y2X3_Tiles
    dfar KeyWorldRoom12_Y3X3_Tiles
    dfar KeyWorldRoom10_Y2X0_Attrs
    dfar KeyWorldRoom09_Y0X1_Attrs
    dfar KeyWorldRoom0A_Y0X1_Attrs
    dfar KeyWorldRoom11_Y2X1_Attrs
    dfar KeyWorldRoom03_Y1X3_Attrs
    dfar KeyWorldRoom05_Y1X1_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom00_Y2X1_Attrs
    dfar KeyWorldRoom03_Y3X2_Attrs
    dfar KeyWorldRoom08_Y1X1_Attrs
    dfar KeyWorldRoom02_Y2X3_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom03_Y3X1_Attrs
    dfar KeyWorldRoom03_Y2X3_Attrs
    dfar KeyWorldRoom12_Y3X3_Attrs
KeyWorldRoom73:: ; heuristic: key-world room record; C0
Data_072_6DFA:: ; address name
    db $02, $03, $04 ; id 115
    dfar KeyWorldRoom0A_Y2X0_Tiles
    dfar KeyWorldRoom0A_Y0X2_Tiles
    dfar KeyWorldRoom08_Y0X1_Tiles
    dfar KeyWorldRoom03_Y1X2_Tiles
    dfar KeyWorldRoom02_Y1X2_Tiles
    dfar KeyWorldRoom07_Y1X0_Tiles
    dfar KeyWorldRoom0A_Y1X1_Tiles
    dfar KeyWorldRoom01_Y1X3_Tiles
    dfar KeyWorldRoom02_Y2X0_Tiles
    dfar KeyWorldRoom02_Y1X0_Tiles
    dfar KeyWorldRoom0B_Y1X1_Tiles
    dfar KeyWorldRoom02_Y1X2_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom02_Y2X2_Tiles
    dfar KeyWorldRoom08_Y1X2_Tiles
    dfar KeyWorldRoom04_Y2X2_Tiles
    dfar KeyWorldRoom0A_Y2X0_Attrs
    dfar KeyWorldRoom0A_Y0X2_Attrs
    dfar KeyWorldRoom08_Y0X1_Attrs
    dfar KeyWorldRoom03_Y1X2_Attrs
    dfar KeyWorldRoom02_Y1X2_Attrs
    dfar KeyWorldRoom07_Y1X0_Attrs
    dfar KeyWorldRoom0A_Y1X1_Attrs
    dfar KeyWorldRoom01_Y1X3_Attrs
    dfar KeyWorldRoom02_Y2X0_Attrs
    dfar KeyWorldRoom02_Y1X0_Attrs
    dfar KeyWorldRoom0B_Y1X1_Attrs
    dfar KeyWorldRoom02_Y1X2_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom02_Y2X2_Attrs
    dfar KeyWorldRoom08_Y1X2_Attrs
    dfar KeyWorldRoom04_Y2X2_Attrs
KeyWorldRoom74:: ; heuristic: key-world room record; C0
Data_072_6E5D:: ; address name
    db $02, $03, $04 ; id 116
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom06_Y1X1_Tiles
    dfar KeyWorldRoom32_Y0X3_Tiles
    dfar KeyWorldRoom25_Y0X2_Tiles
    dfar KeyWorldRoom00_Y3X3_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom04_Y0X2_Tiles
    dfar KeyWorldRoom0A_Y1X3_Tiles
    dfar KeyWorldRoom0B_Y0X2_Tiles
    dfar KeyWorldRoom08_Y0X2_Tiles
    dfar KeyWorldRoom06_Y1X1_Tiles
    dfar KeyWorldRoom04_Y3X3_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom08_Y1X3_Tiles
    dfar KeyWorldRoom01_Y3X0_Tiles
    dfar KeyWorldRoom1E_Y0X1_Tiles
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom06_Y1X1_Attrs
    dfar KeyWorldRoom32_Y0X3_Attrs
    dfar KeyWorldRoom25_Y0X2_Attrs
    dfar KeyWorldRoom00_Y3X3_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom04_Y0X2_Attrs
    dfar KeyWorldRoom0A_Y1X3_Attrs
    dfar KeyWorldRoom0B_Y0X2_Attrs
    dfar KeyWorldRoom08_Y0X2_Attrs
    dfar KeyWorldRoom06_Y1X1_Attrs
    dfar KeyWorldRoom04_Y3X3_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom08_Y1X3_Attrs
    dfar KeyWorldRoom01_Y3X0_Attrs
    dfar KeyWorldRoom1E_Y0X1_Attrs
KeyWorldRoom75:: ; heuristic: key-world room record; C0
Data_072_6EC0:: ; address name
    db $02, $03, $04 ; id 117
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom04_Y1X1_Tiles
    dfar KeyWorldRoom00_Y0X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom04_Y1X1_Tiles
    dfar KeyWorldRoom00_Y0X1_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom04_Y1X1_Attrs
    dfar KeyWorldRoom00_Y0X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom04_Y1X1_Attrs
    dfar KeyWorldRoom00_Y0X1_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
KeyWorldRoom76:: ; heuristic: key-world room record; C0
Data_072_6F23:: ; address name
    db $02, $03, $04 ; id 118
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom08_Y0X1_Tiles
    dfar KeyWorldRoom3D_Y2X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom0D_Y1X0_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom02_Y1X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dw KeyWorldRoom00_Y1X0_Tiles
Data_072_6F40:: ; heuristic: label inside a table; C0
    db $70
    dfar KeyWorldRoom76_Y2X1_Tiles
    dfar KeyWorldRoom05_Y1X1_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X1_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom08_Y0X1_Attrs
    dfar KeyWorldRoom3D_Y2X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom0D_Y1X0_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom02_Y1X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom76_Y2X1_Attrs
    dfar KeyWorldRoom05_Y1X1_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X1_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
KeyWorldRoom77:: ; heuristic: key-world room record; C0
Data_072_6F86:: ; address name
    db $02, $03, $05 ; id 119
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom0B_Y2X0_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom07_Y1X0_Tiles
    dfar KeyWorldRoom08_Y1X1_Tiles
    dfar KeyWorldRoom0B_Y1X1_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom01_Y3X1_Tiles
    dfar KeyWorldRoom00_Y3X1_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom0B_Y2X0_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom07_Y1X0_Attrs
    dfar KeyWorldRoom08_Y1X1_Attrs
    dfar KeyWorldRoom0B_Y1X1_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom01_Y3X1_Attrs
    dfar KeyWorldRoom00_Y3X1_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
KeyWorldRoom78:: ; heuristic: string; C0
    db $02, $03, $05 ; id 120
    dfar KeyWorldRoom0F_Y1X0_Tiles
    dfar KeyWorldRoom03_Y3X1_Tiles
    dfar KeyWorldRoom03_Y0X2_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom03_Y3X0_Tiles
    dfar KeyWorldRoom06_Y1X1_Tiles
    dfar KeyWorldRoom03_Y0X1_Tiles
    dfar KeyWorldRoom0B_Y1X1_Tiles
    dfar KeyWorldRoom0A_Y2X0_Tiles
    dfar KeyWorldRoom11_Y1X2_Tiles
    dfar KeyWorldRoom00_Y0X2_Tiles
    dfar KeyWorldRoom0A_Y2X1_Tiles
    dfar KeyWorldRoom03_Y2X1_Tiles
    dfar KeyWorldRoom03_Y2X2_Tiles
    dfar KeyWorldRoom03_Y3X2_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom0F_Y1X0_Attrs
    dfar KeyWorldRoom03_Y3X1_Attrs
    dfar KeyWorldRoom03_Y0X2_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom03_Y3X0_Attrs
    dfar KeyWorldRoom06_Y1X1_Attrs
    dfar KeyWorldRoom03_Y0X1_Attrs
    dfar KeyWorldRoom0B_Y1X1_Attrs
    dfar KeyWorldRoom0A_Y2X0_Attrs
    dfar KeyWorldRoom11_Y1X2_Attrs
    dfar KeyWorldRoom00_Y0X2_Attrs
    dfar KeyWorldRoom0A_Y2X1_Attrs
    dfar KeyWorldRoom03_Y2X1_Attrs
    dfar KeyWorldRoom03_Y2X2_Attrs
    dfar KeyWorldRoom03_Y3X2_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
KeyWorldRoom79:: ; heuristic: string; C0
    db $02, $03, $05 ; id 121
    dfar KeyWorldRoom11_Y0X2_Tiles
    dfar KeyWorldRoom04_Y0X1_Tiles
    dfar KeyWorldRoom03_Y3X1_Tiles
    dfar KeyWorldRoom01_Y2X1_Tiles
    dfar KeyWorldRoom08_Y1X0_Tiles
    dfar KeyWorldRoom01_Y0X1_Tiles
    dfar KeyWorldRoom12_Y2X3_Tiles
    dfar KeyWorldRoom03_Y1X3_Tiles
    dfar KeyWorldRoom03_Y1X0_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom02_Y3X0_Tiles
    dfar KeyWorldRoom04_Y0X2_Tiles
    dfar KeyWorldRoom03_Y0X1_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom11_Y0X2_Attrs
    dfar KeyWorldRoom04_Y0X1_Attrs
    dfar KeyWorldRoom03_Y3X1_Attrs
    dfar KeyWorldRoom01_Y2X1_Attrs
    dfar KeyWorldRoom08_Y1X0_Attrs
    dfar KeyWorldRoom01_Y0X1_Attrs
    dfar KeyWorldRoom12_Y2X3_Attrs
    dfar KeyWorldRoom03_Y1X3_Attrs
    dfar KeyWorldRoom03_Y1X0_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom02_Y3X0_Attrs
    dfar KeyWorldRoom04_Y0X2_Attrs
    dfar KeyWorldRoom03_Y0X1_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
KeyWorldRoom7A:: ; heuristic: key-world room record; C0
Data_072_70AF:: ; address name
    db $02, $03, $05 ; id 122
    dfar KeyWorldRoom10_Y2X0_Tiles
    dfar KeyWorldRoom0A_Y0X2_Tiles
    dfar KeyWorldRoom25_Y0X1_Tiles
    dfar KeyWorldRoom19_Y1X0_Tiles
    dfar KeyWorldRoom08_Y2X0_Tiles
    dfar KeyWorldRoom07_Y1X2_Tiles
    dfar KeyWorldRoom06_Y1X1_Tiles
    dfar KeyWorldRoom01_Y2X3_Tiles
    dfar KeyWorldRoom09_Y2X1_Tiles
    dfar KeyWorldRoom03_Y2X3_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom02_Y2X3_Tiles
    dfar KeyWorldRoom01_Y3X0_Tiles
    dfar KeyWorldRoom00_Y0X2_Tiles
    dfar KeyWorldRoom02_Y3X2_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom10_Y2X0_Attrs
    dfar KeyWorldRoom0A_Y0X2_Attrs
    dfar KeyWorldRoom25_Y0X1_Attrs
    dfar KeyWorldRoom19_Y1X0_Attrs
    dfar KeyWorldRoom08_Y2X0_Attrs
    dfar KeyWorldRoom07_Y1X2_Attrs
    dfar KeyWorldRoom06_Y1X1_Attrs
    dfar KeyWorldRoom01_Y2X3_Attrs
    dfar KeyWorldRoom09_Y2X1_Attrs
    dfar KeyWorldRoom03_Y2X3_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom02_Y2X3_Attrs
    dfar KeyWorldRoom01_Y3X0_Attrs
    dfar KeyWorldRoom00_Y0X2_Attrs
    dfar KeyWorldRoom02_Y3X2_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
KeyWorldRoom7B:: ; heuristic: string; C0
    db $02, $03, $05 ; id 123
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom04_Y0X2_Tiles
    dfar KeyWorldRoom03_Y3X1_Tiles
    dfar KeyWorldRoom10_Y2X3_Tiles
    dfar KeyWorldRoom02_Y3X0_Tiles
    dfar KeyWorldRoom01_Y0X1_Tiles
    dfar KeyWorldRoom11_Y2X1_Tiles
    dfar KeyWorldRoom01_Y1X3_Tiles
    dfar KeyWorldRoom04_Y0X0_Tiles
    dfar KeyWorldRoom03_Y2X1_Tiles
    dfar KeyWorldRoom01_Y3X1_Tiles
    dfar KeyWorldRoom04_Y1X3_Tiles
    dfar KeyWorldRoom02_Y2X1_Tiles
    dfar KeyWorldRoom03_Y0X2_Tiles
    dfar KeyWorldRoom03_Y3X2_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom04_Y0X2_Attrs
    dfar KeyWorldRoom03_Y3X1_Attrs
    dfar KeyWorldRoom10_Y2X3_Attrs
    dfar KeyWorldRoom02_Y3X0_Attrs
    dfar KeyWorldRoom01_Y0X1_Attrs
    dfar KeyWorldRoom11_Y2X1_Attrs
    dfar KeyWorldRoom01_Y1X3_Attrs
Data_072_715D:: ; heuristic: label inside a table; C0
    dfar KeyWorldRoom04_Y0X0_Attrs
    dfar KeyWorldRoom03_Y2X1_Attrs
    dfar KeyWorldRoom01_Y3X1_Attrs
    dfar KeyWorldRoom04_Y1X3_Attrs
    dfar KeyWorldRoom02_Y2X1_Attrs
Data_072_716C:: ; heuristic: label inside a table; C0
    dfar KeyWorldRoom03_Y0X2_Attrs
    dfar KeyWorldRoom03_Y3X2_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
KeyWorldRoom7C:: ; heuristic: key-world room record; C0
Data_072_7175:: ; address name
    db $02, $03, $05 ; id 124
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
Data_072_717E:: ; heuristic: label inside a table; C0
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom02_Y0X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom00_Y0X2_Tiles
    dfar KeyWorldRoom00_Y0X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X1_Tiles
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom02_Y0X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom00_Y0X2_Attrs
    dfar KeyWorldRoom00_Y0X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X1_Attrs
KeyWorldRoom7D:: ; heuristic: key-world room record; C0
Data_072_71D8:: ; address name
    db $02, $03, $05 ; id 125
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom02_Y0X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom04_Y1X1_Tiles
    dfar KeyWorldRoom03_Y3X1_Tiles
    dfar KeyWorldRoom0A_Y1X1_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom22_Y2X1_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom06_Y3X1_Tiles
    dfar KeyWorldRoom00_Y3X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom02_Y0X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom04_Y1X1_Attrs
    dfar KeyWorldRoom03_Y3X1_Attrs
    dfar KeyWorldRoom0A_Y1X1_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom22_Y2X1_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom06_Y3X1_Attrs
    dfar KeyWorldRoom00_Y3X3_Attrs
KeyWorldRoom7E:: ; heuristic: string; C0
    db $02, $04, $05 ; id 126
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom00_Y0X1_Tiles
    dfar KeyWorldRoom06_Y1X1_Tiles
    dfar KeyWorldRoom00_Y3X2_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom06_Y1X1_Tiles
    dfar KeyWorldRoom08_Y1X1_Tiles
    dfar KeyWorldRoom0F_Y0X3_Tiles
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom00_Y0X3_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom00_Y0X2_Tiles
    dfar KeyWorldRoom00_Y0X1_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom00_Y0X1_Attrs
    dfar KeyWorldRoom06_Y1X1_Attrs
    dfar KeyWorldRoom00_Y3X2_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom06_Y1X1_Attrs
    dfar KeyWorldRoom08_Y1X1_Attrs
    dfar KeyWorldRoom0F_Y0X3_Attrs
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom00_Y0X3_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom00_Y0X2_Attrs
    dfar KeyWorldRoom00_Y0X1_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
KeyWorldRoom7F:: ; heuristic: key-world room record; C0
Data_072_729E:: ; address name
    db $02, $04, $05 ; id 127
    dfar KeyWorldRoom0B_Y0X2_Tiles
    dfar KeyWorldRoom02_Y3X2_Tiles
    dfar KeyWorldRoom00_Y0X1_Tiles
    dfar KeyWorldRoom09_Y1X2_Tiles
    dfar KeyWorldRoom03_Y3X0_Tiles
    dfar KeyWorldRoom00_Y0X2_Tiles
    dfar KeyWorldRoom03_Y1X2_Tiles
    dfar KeyWorldRoom02_Y2X0_Tiles
    dfar KeyWorldRoom0F_Y0X2_Tiles
    dfar KeyWorldRoom00_Y3X2_Tiles
    dfar KeyWorldRoom02_Y1X3_Tiles
    dfar KeyWorldRoom02_Y1X2_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom03_Y0X1_Tiles
    dfar KeyWorldRoom0A_Y3X1_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom0B_Y0X2_Attrs
    dfar KeyWorldRoom02_Y3X2_Attrs
    dfar KeyWorldRoom00_Y0X1_Attrs
    dfar KeyWorldRoom09_Y1X2_Attrs
    dfar KeyWorldRoom03_Y3X0_Attrs
    dfar KeyWorldRoom00_Y0X2_Attrs
    dfar KeyWorldRoom03_Y1X2_Attrs
    dfar KeyWorldRoom02_Y2X0_Attrs
    dfar KeyWorldRoom0F_Y0X2_Attrs
    dfar KeyWorldRoom00_Y3X2_Attrs
    dfar KeyWorldRoom02_Y1X3_Attrs
    dfar KeyWorldRoom02_Y1X2_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom03_Y0X1_Attrs
    dfar KeyWorldRoom0A_Y3X1_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
KeyWorldRoom80:: ; heuristic: key-world room record; C0
Data_072_7301:: ; address name
    db $02, $04, $05 ; id 128
    dfar KeyWorldRoom0B_Y2X0_Tiles
    dfar KeyWorldRoom03_Y3X1_Tiles
    dfar KeyWorldRoom08_Y0X2_Tiles
    dfar KeyWorldRoom12_Y2X3_Tiles
    dfar KeyWorldRoom09_Y1X1_Tiles
    dfar KeyWorldRoom01_Y0X1_Tiles
    dfar KeyWorldRoom0A_Y1X3_Tiles
    dfar KeyWorldRoom03_Y1X0_Tiles
    dfar KeyWorldRoom0A_Y1X2_Tiles
    dfar KeyWorldRoom0A_Y3X2_Tiles
    dfar KeyWorldRoom0A_Y1X1_Tiles
    dfar KeyWorldRoom03_Y1X3_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom03_Y3X2_Tiles
    dfar KeyWorldRoom00_Y3X1_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom0B_Y2X0_Attrs
    dfar KeyWorldRoom03_Y3X1_Attrs
    dfar KeyWorldRoom08_Y0X2_Attrs
    dfar KeyWorldRoom12_Y2X3_Attrs
    dfar KeyWorldRoom09_Y1X1_Attrs
    dfar KeyWorldRoom01_Y0X1_Attrs
    dfar KeyWorldRoom0A_Y1X3_Attrs
    dfar KeyWorldRoom03_Y1X0_Attrs
    dfar KeyWorldRoom0A_Y1X2_Attrs
    dfar KeyWorldRoom0A_Y3X2_Attrs
    dfar KeyWorldRoom0A_Y1X1_Attrs
    dfar KeyWorldRoom03_Y1X3_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom03_Y3X2_Attrs
    dfar KeyWorldRoom00_Y3X1_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
KeyWorldRoom81:: ; heuristic: string; C0
    db $02, $04, $05 ; id 129
    dfar KeyWorldRoom0F_Y1X0_Tiles
    dfar KeyWorldRoom09_Y0X1_Tiles
    dfar KeyWorldRoom0A_Y0X1_Tiles
    dfar KeyWorldRoom00_Y0X3_Tiles
    dfar KeyWorldRoom07_Y1X0_Tiles
    dfar KeyWorldRoom00_Y3X1_Tiles
    dfar KeyWorldRoom0A_Y2X1_Tiles
    dfar KeyWorldRoom08_Y3X1_Tiles
    dfar KeyWorldRoom0B_Y3X0_Tiles
    dfar KeyWorldRoom10_Y2X0_Tiles
    dfar KeyWorldRoom07_Y1X2_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom04_Y1X1_Tiles
    dfar KeyWorldRoom08_Y1X2_Tiles
    dfar KeyWorldRoom03_Y2X2_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom0F_Y1X0_Attrs
    dfar KeyWorldRoom09_Y0X1_Attrs
    dfar KeyWorldRoom0A_Y0X1_Attrs
    dfar KeyWorldRoom00_Y0X3_Attrs
    dfar KeyWorldRoom07_Y1X0_Attrs
    dfar KeyWorldRoom00_Y3X1_Attrs
    dfar KeyWorldRoom0A_Y2X1_Attrs
    dfar KeyWorldRoom08_Y3X1_Attrs
    dfar KeyWorldRoom0B_Y3X0_Attrs
    dfar KeyWorldRoom10_Y2X0_Attrs
    dfar KeyWorldRoom07_Y1X2_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom04_Y1X1_Attrs
    dfar KeyWorldRoom08_Y1X2_Attrs
    dfar KeyWorldRoom03_Y2X2_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
KeyWorldRoom82:: ; heuristic: string; C0
    db $02, $04, $05 ; id 130
    dfar KeyWorldRoom1D_Y0X3_Tiles
    dfar KeyWorldRoom04_Y2X1_Tiles
    dfar KeyWorldRoom0A_Y0X2_Tiles
    dfar KeyWorldRoom01_Y2X1_Tiles
    dfar KeyWorldRoom02_Y1X0_Tiles
    dfar KeyWorldRoom00_Y0X1_Tiles
    dfar KeyWorldRoom09_Y3X1_Tiles
    dfar KeyWorldRoom04_Y2X2_Tiles
    dfar KeyWorldRoom01_Y3X0_Tiles
    dfar KeyWorldRoom06_Y1X1_Tiles
    dfar KeyWorldRoom08_Y0X2_Tiles
    dfar KeyWorldRoom09_Y1X2_Tiles
    dfar KeyWorldRoom02_Y0X1_Tiles
    dfar KeyWorldRoom0A_Y3X2_Tiles
    dfar KeyWorldRoom0A_Y3X1_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom1D_Y0X3_Attrs
    dfar KeyWorldRoom04_Y2X1_Attrs
    dfar KeyWorldRoom0A_Y0X2_Attrs
    dfar KeyWorldRoom01_Y2X1_Attrs
    dfar KeyWorldRoom02_Y1X0_Attrs
    dfar KeyWorldRoom00_Y0X1_Attrs
    dfar KeyWorldRoom09_Y3X1_Attrs
    dfar KeyWorldRoom04_Y2X2_Attrs
    dfar KeyWorldRoom01_Y3X0_Attrs
    dfar KeyWorldRoom06_Y1X1_Attrs
    dfar KeyWorldRoom08_Y0X2_Attrs
    dfar KeyWorldRoom09_Y1X2_Attrs
    dfar KeyWorldRoom02_Y0X1_Attrs
    dfar KeyWorldRoom0A_Y3X2_Attrs
    dfar KeyWorldRoom0A_Y3X1_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
KeyWorldRoom83:: ; heuristic: key-world room record; C0
Data_072_742A:: ; address name
    db $02, $04, $05 ; id 131
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom52_Y2X0_Tiles
    dfar KeyWorldRoom00_Y0X1_Tiles
    dfar KeyWorldRoom12_Y2X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom14_Y1X1_Tiles
    dfar KeyWorldRoom10_Y2X3_Tiles
    dfar KeyWorldRoom00_Y3X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X1_Tiles
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom52_Y2X0_Attrs
    dfar KeyWorldRoom00_Y0X1_Attrs
    dfar KeyWorldRoom12_Y2X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom14_Y1X1_Attrs
    dfar KeyWorldRoom10_Y2X3_Attrs
    dfar KeyWorldRoom00_Y3X3_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X1_Attrs
KeyWorldRoom84:: ; heuristic: key-world room record; C0
Data_072_748D:: ; address name
    db $02, $04, $05 ; id 132
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom02_Y0X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom61_Y1X0_Tiles
    dfar KeyWorldRoom10_Y2X0_Tiles
    dfar KeyWorldRoom22_Y1X2_Tiles
    dfar KeyWorldRoom00_Y0X1_Tiles
    dfar KeyWorldRoom01_Y2X3_Tiles
    dfar KeyWorldRoom05_Y1X1_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom00_Y3X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom02_Y0X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom61_Y1X0_Attrs
    dfar KeyWorldRoom10_Y2X0_Attrs
    dfar KeyWorldRoom22_Y1X2_Attrs
    dfar KeyWorldRoom00_Y0X1_Attrs
    dfar KeyWorldRoom01_Y2X3_Attrs
    dfar KeyWorldRoom05_Y1X1_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom00_Y3X3_Attrs
KeyWorldRoom85:: ; heuristic: string; C0
    db $03, $04, $05 ; id 133
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom07_Y1X0_Tiles
    dfar KeyWorldRoom01_Y1X2_Tiles
    dfar KeyWorldRoom07_Y1X0_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom00_Y2X1_Tiles
    dfar KeyWorldRoom07_Y1X2_Tiles
    dfar KeyWorldRoom08_Y1X1_Tiles
    dfar KeyWorldRoom0F_Y0X3_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom01_Y3X1_Tiles
    dfar KeyWorldRoom00_Y3X1_Tiles
    dfar KeyWorldRoom00_Y3X2_Tiles
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom07_Y1X0_Attrs
    dfar KeyWorldRoom01_Y1X2_Attrs
    dfar KeyWorldRoom07_Y1X0_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
    dfar KeyWorldRoom00_Y2X1_Attrs
    dfar KeyWorldRoom07_Y1X2_Attrs
    dfar KeyWorldRoom08_Y1X1_Attrs
    dfar KeyWorldRoom0F_Y0X3_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom01_Y3X1_Attrs
    dfar KeyWorldRoom00_Y3X1_Attrs
    dfar KeyWorldRoom00_Y3X2_Attrs
KeyWorldRoom86:: ; heuristic: string; C0
    db $03, $04, $05 ; id 134
    dfar KeyWorldRoom0A_Y2X0_Tiles
    dfar KeyWorldRoom08_Y0X1_Tiles
    dfar KeyWorldRoom00_Y0X2_Tiles
    dfar KeyWorldRoom11_Y2X1_Tiles
    dfar KeyWorldRoom08_Y1X0_Tiles
    dfar KeyWorldRoom08_Y2X1_Tiles
    dfar KeyWorldRoom03_Y1X2_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom01_Y1X3_Tiles
    dfar KeyWorldRoom08_Y2X0_Tiles
    dfar KeyWorldRoom00_Y3X1_Tiles
    dfar KeyWorldRoom01_Y1X2_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom02_Y2X2_Tiles
    dfar KeyWorldRoom02_Y3X2_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom0A_Y2X0_Attrs
    dfar KeyWorldRoom08_Y0X1_Attrs
    dfar KeyWorldRoom00_Y0X2_Attrs
    dfar KeyWorldRoom11_Y2X1_Attrs
    dfar KeyWorldRoom08_Y1X0_Attrs
    dfar KeyWorldRoom08_Y2X1_Attrs
    dfar KeyWorldRoom03_Y1X2_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom01_Y1X3_Attrs
    dfar KeyWorldRoom08_Y2X0_Attrs
    dfar KeyWorldRoom00_Y3X1_Attrs
    dfar KeyWorldRoom01_Y1X2_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom02_Y2X2_Attrs
    dfar KeyWorldRoom02_Y3X2_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
KeyWorldRoom87:: ; heuristic: key-world room record; C0
Data_072_75B6:: ; address name
    db $03, $04, $05 ; id 135
    dfar KeyWorldRoom3A_Y3X2_Tiles
    dfar KeyWorldRoom1D_Y0X1_Tiles
    dfar KeyWorldRoom09_Y0X1_Tiles
    dfar KeyWorldRoom12_Y2X3_Tiles
    dfar KeyWorldRoom1D_Y3X1_Tiles
    dfar KeyWorldRoom0B_Y1X1_Tiles
    dfar KeyWorldRoom02_Y1X3_Tiles
    dfar KeyWorldRoom02_Y1X2_Tiles
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom0B_Y2X1_Tiles
    dfar KeyWorldRoom01_Y3X1_Tiles
    dfar KeyWorldRoom01_Y2X3_Tiles
    dfar KeyWorldRoom05_Y1X1_Tiles
    dfar KeyWorldRoom02_Y2X1_Tiles
    dfar KeyWorldRoom03_Y0X1_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom3A_Y3X2_Attrs
    dfar KeyWorldRoom1D_Y0X1_Attrs
    dfar KeyWorldRoom09_Y0X1_Attrs
    dfar KeyWorldRoom12_Y2X3_Attrs
    dfar KeyWorldRoom1D_Y3X1_Attrs
    dfar KeyWorldRoom0B_Y1X1_Attrs
    dfar KeyWorldRoom02_Y1X3_Attrs
    dfar KeyWorldRoom02_Y1X2_Attrs
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom0B_Y2X1_Attrs
    dfar KeyWorldRoom01_Y3X1_Attrs
    dfar KeyWorldRoom01_Y2X3_Attrs
    dfar KeyWorldRoom05_Y1X1_Attrs
    dfar KeyWorldRoom02_Y2X1_Attrs
    dfar KeyWorldRoom03_Y0X1_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
KeyWorldRoom88:: ; heuristic: key-world room record; C0
Data_072_7619:: ; address name
    db $03, $04, $05 ; id 136
    dfar KeyWorldRoom0B_Y0X2_Tiles
    dfar KeyWorldRoom03_Y0X2_Tiles
    dfar KeyWorldRoom04_Y0X2_Tiles
    dfar KeyWorldRoom10_Y2X3_Tiles
    dfar KeyWorldRoom09_Y1X1_Tiles
    dfar KeyWorldRoom0A_Y0X1_Tiles
    dfar KeyWorldRoom08_Y0X1_Tiles
    dfar KeyWorldRoom04_Y1X3_Tiles
    dfar KeyWorldRoom09_Y2X1_Tiles
    dfar KeyWorldRoom08_Y1X2_Tiles
    dfar KeyWorldRoom01_Y3X1_Tiles
    dfar KeyWorldRoom02_Y2X3_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom03_Y3X2_Tiles
    dfar KeyWorldRoom03_Y3X1_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom0B_Y0X2_Attrs
    dfar KeyWorldRoom03_Y0X2_Attrs
    dfar KeyWorldRoom04_Y0X2_Attrs
    dfar KeyWorldRoom10_Y2X3_Attrs
    dfar KeyWorldRoom09_Y1X1_Attrs
    dfar KeyWorldRoom0A_Y0X1_Attrs
    dfar KeyWorldRoom08_Y0X1_Attrs
    dfar KeyWorldRoom04_Y1X3_Attrs
    dfar KeyWorldRoom09_Y2X1_Attrs
    dfar KeyWorldRoom08_Y1X2_Attrs
    dfar KeyWorldRoom01_Y3X1_Attrs
    dfar KeyWorldRoom02_Y2X3_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom03_Y3X2_Attrs
    dfar KeyWorldRoom03_Y3X1_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
KeyWorldRoom89:: ; heuristic: string; C0
    db $03, $04, $05 ; id 137
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom05_Y0X1_Tiles
    dfar KeyWorldRoom00_Y0X1_Tiles
    dfar KeyWorldRoom00_Y0X3_Tiles
    dfar KeyWorldRoom00_Y3X3_Tiles
    dfar KeyWorldRoom0D_Y3X1_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom00_Y3X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom05_Y0X1_Attrs
    dfar KeyWorldRoom00_Y0X1_Attrs
    dfar KeyWorldRoom00_Y0X3_Attrs
    dfar KeyWorldRoom00_Y3X3_Attrs
    dfar KeyWorldRoom0D_Y3X1_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom00_Y3X3_Attrs
KeyWorldRoom8A:: ; heuristic: key-world room record; C0
Data_072_76DF:: ; address name
    db $03, $04, $05 ; id 138
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom8A_Y1X1_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom09_Y1X1_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom37_Y0X2_Tiles
    dfar KeyWorldRoom02_Y0X1_Tiles
    dfar KeyWorldRoom08_Y1X2_Tiles
    dfar KeyWorldRoom0A_Y3X1_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom8A_Y1X1_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom09_Y1X1_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom37_Y0X2_Attrs
    dfar KeyWorldRoom02_Y0X1_Attrs
    dfar KeyWorldRoom08_Y1X2_Attrs
    dfar KeyWorldRoom0A_Y3X1_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
KeyWorldRoom8B:: ; heuristic: key-world room record; C0
Data_072_7742:: ; address name
    db $03, $04, $05 ; id 139
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom44_Y0X1_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X0_Tiles
    dfar KeyWorldRoom37_Y2X0_Tiles
    dfar KeyWorldRoom0A_Y1X2_Tiles
    dfar KeyWorldRoom00_Y0X1_Tiles
    dfar KeyWorldRoom67_Y2X3_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom00_Y2X1_Tiles
    dfar KeyWorldRoom0F_Y0X3_Tiles
    dfar KeyWorldRoom03_Y1X0_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom8B_Y3X1_Tiles
    dfar KeyWorldRoom8B_Y3X2_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom44_Y0X1_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X0_Attrs
    dfar KeyWorldRoom37_Y2X0_Attrs
    dfar KeyWorldRoom0A_Y1X2_Attrs
    dfar KeyWorldRoom00_Y0X1_Attrs
    dfar KeyWorldRoom67_Y2X3_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom00_Y2X1_Attrs
    dfar KeyWorldRoom0F_Y0X3_Attrs
    dfar KeyWorldRoom03_Y1X0_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom8B_Y3X1_Attrs
    dfar KeyWorldRoom8B_Y3X2_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
KeyWorldRoom8C:: ; heuristic: key-world room record; C0
Data_072_77A5:: ; address name
    db $00, $01, $02 ; id 140
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom00_Y3X2_Tiles
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom00_Y3X2_Tiles
    dfar KeyWorldRoom00_Y2X1_Tiles
    dfar KeyWorldRoom00_Y0X2_Tiles
    dfar KeyWorldRoom08_Y1X1_Tiles
    dfar KeyWorldRoom0F_Y0X3_Tiles
    dfar KeyWorldRoom07_Y1X0_Tiles
    dfar KeyWorldRoom00_Y0X1_Tiles
    dfar KeyWorldRoom0B_Y1X1_Tiles
    dfar KeyWorldRoom02_Y0X0_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom8C_Y3X1_Tiles
    dfar KeyWorldRoom01_Y3X1_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom00_Y3X2_Attrs
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom00_Y3X2_Attrs
    dfar KeyWorldRoom00_Y2X1_Attrs
    dfar KeyWorldRoom00_Y0X2_Attrs
    dfar KeyWorldRoom08_Y1X1_Attrs
    dfar KeyWorldRoom0F_Y0X3_Attrs
    dfar KeyWorldRoom07_Y1X0_Attrs
    dfar KeyWorldRoom00_Y0X1_Attrs
    dfar KeyWorldRoom0B_Y1X1_Attrs
    dfar KeyWorldRoom02_Y0X0_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom8C_Y3X1_Attrs
    dfar KeyWorldRoom01_Y3X1_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
KeyWorldRoom8D:: ; heuristic: key-world room record; C0
Data_072_7808:: ; address name
    db $00, $01, $03 ; id 141
    dfar KeyWorldRoom02_Y0X1_Tiles
    dfar KeyWorldRoom00_Y0X2_Tiles
    dfar KeyWorldRoom01_Y0X1_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom04_Y0X0_Tiles
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom0B_Y1X1_Tiles
    dfar KeyWorldRoom05_Y1X1_Tiles
    dfar KeyWorldRoom00_Y2X1_Tiles
    dfar KeyWorldRoom0B_Y1X1_Tiles
    dfar KeyWorldRoom00_Y2X1_Tiles
    dfar KeyWorldRoom0F_Y0X3_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom8D_Y3X1_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom00_Y3X2_Tiles
    dfar KeyWorldRoom02_Y0X1_Attrs
    dfar KeyWorldRoom00_Y0X2_Attrs
    dfar KeyWorldRoom01_Y0X1_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom04_Y0X0_Attrs
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom0B_Y1X1_Attrs
    dfar KeyWorldRoom05_Y1X1_Attrs
    dfar KeyWorldRoom00_Y2X1_Attrs
    dfar KeyWorldRoom0B_Y1X1_Attrs
    dfar KeyWorldRoom00_Y2X1_Attrs
    dfar KeyWorldRoom0F_Y0X3_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom8D_Y3X1_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom00_Y3X2_Attrs
KeyWorldRoom8E:: ; heuristic: key-world room record; C0
Data_072_786B:: ; address name
    db $00, $01, $04 ; id 142
    dfar KeyWorldRoom04_Y1X1_Tiles
    dfar KeyWorldRoom01_Y0X1_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom02_Y0X0_Tiles
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom0B_Y1X1_Tiles
    dfar KeyWorldRoom05_Y1X1_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom00_Y2X1_Tiles
    dfar KeyWorldRoom00_Y0X2_Tiles
    dfar KeyWorldRoom01_Y1X2_Tiles
    dfar KeyWorldRoom05_Y1X1_Tiles
    dfar KeyWorldRoom8E_Y3X1_Tiles
    dfar KeyWorldRoom00_Y0X1_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom04_Y1X1_Attrs
    dfar KeyWorldRoom01_Y0X1_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom02_Y0X0_Attrs
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom0B_Y1X1_Attrs
    dfar KeyWorldRoom05_Y1X1_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom00_Y2X1_Attrs
    dfar KeyWorldRoom00_Y0X2_Attrs
    dfar KeyWorldRoom01_Y1X2_Attrs
    dfar KeyWorldRoom05_Y1X1_Attrs
    dfar KeyWorldRoom8E_Y3X1_Attrs
    dfar KeyWorldRoom00_Y0X1_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
KeyWorldRoom8F:: ; heuristic: key-world room record; C0
Data_072_78CE:: ; address name
    db $00, $01, $05 ; id 143
    dfar KeyWorldRoom02_Y0X1_Tiles
    dfar KeyWorldRoom06_Y1X1_Tiles
    dfar KeyWorldRoom00_Y3X2_Tiles
    dfar KeyWorldRoom04_Y0X0_Tiles
    dfar KeyWorldRoom04_Y0X0_Tiles
    dfar KeyWorldRoom00_Y2X1_Tiles
    dfar KeyWorldRoom00_Y0X2_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom00_Y2X1_Tiles
    dfar KeyWorldRoom07_Y1X2_Tiles
    dfar KeyWorldRoom01_Y0X1_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom8F_Y3X1_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom05_Y1X1_Tiles
    dfar KeyWorldRoom02_Y0X1_Attrs
    dfar KeyWorldRoom06_Y1X1_Attrs
    dfar KeyWorldRoom00_Y3X2_Attrs
    dfar KeyWorldRoom04_Y0X0_Attrs
    dfar KeyWorldRoom04_Y0X0_Attrs
    dfar KeyWorldRoom00_Y2X1_Attrs
    dfar KeyWorldRoom00_Y0X2_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
    dfar KeyWorldRoom00_Y2X1_Attrs
    dfar KeyWorldRoom07_Y1X2_Attrs
    dfar KeyWorldRoom01_Y0X1_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom8F_Y3X1_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
    dfar KeyWorldRoom05_Y1X1_Attrs
KeyWorldRoom90:: ; heuristic: key-world room record; C0
Data_072_7931:: ; address name
    db $00, $02, $03 ; id 144
    dfar KeyWorldRoom04_Y1X1_Tiles
    dfar KeyWorldRoom00_Y0X1_Tiles
    dfar KeyWorldRoom06_Y1X1_Tiles
    dfar KeyWorldRoom00_Y0X3_Tiles
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom00_Y0X2_Tiles
    dfar KeyWorldRoom01_Y3X1_Tiles
    dfar KeyWorldRoom0B_Y1X1_Tiles
    dfar KeyWorldRoom07_Y1X0_Tiles
    dfar KeyWorldRoom00_Y3X2_Tiles
    dfar KeyWorldRoom04_Y1X1_Tiles
    dfar KeyWorldRoom01_Y1X2_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom8C_Y3X1_Tiles
    dfar KeyWorldRoom00_Y0X1_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom04_Y1X1_Attrs
    dfar KeyWorldRoom00_Y0X1_Attrs
    dfar KeyWorldRoom06_Y1X1_Attrs
    dfar KeyWorldRoom00_Y0X3_Attrs
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom00_Y0X2_Attrs
    dfar KeyWorldRoom01_Y3X1_Attrs
    dfar KeyWorldRoom0B_Y1X1_Attrs
    dfar KeyWorldRoom07_Y1X0_Attrs
    dfar KeyWorldRoom00_Y3X2_Attrs
    dfar KeyWorldRoom04_Y1X1_Attrs
    dfar KeyWorldRoom01_Y1X2_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom8C_Y3X1_Attrs
    dfar KeyWorldRoom00_Y0X1_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
KeyWorldRoom91:: ; heuristic: key-world room record; C0
Data_072_7994:: ; address name
    db $00, $02, $04 ; id 145
    dfar KeyWorldRoom02_Y0X1_Tiles
    dfar KeyWorldRoom00_Y0X2_Tiles
    dfar KeyWorldRoom01_Y0X1_Tiles
    dfar KeyWorldRoom0F_Y0X3_Tiles
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom01_Y0X1_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom02_Y0X0_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom01_Y0X1_Tiles
    dfar KeyWorldRoom0B_Y1X1_Tiles
    dfar KeyWorldRoom00_Y3X3_Tiles
    dfar KeyWorldRoom91_Y3X1_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom05_Y1X1_Tiles
    dfar KeyWorldRoom02_Y0X1_Attrs
    dfar KeyWorldRoom00_Y0X2_Attrs
    dfar KeyWorldRoom01_Y0X1_Attrs
    dfar KeyWorldRoom0F_Y0X3_Attrs
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom01_Y0X1_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
    dfar KeyWorldRoom02_Y0X0_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom01_Y0X1_Attrs
    dfar KeyWorldRoom0B_Y1X1_Attrs
    dfar KeyWorldRoom00_Y3X3_Attrs
    dfar KeyWorldRoom91_Y3X1_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
    dfar KeyWorldRoom05_Y1X1_Attrs
KeyWorldRoom92:: ; heuristic: key-world room record; C0
Data_072_79F7:: ; address name
    db $00, $02, $05 ; id 146
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom01_Y0X1_Tiles
    dfar KeyWorldRoom00_Y0X2_Tiles
    dfar KeyWorldRoom00_Y0X3_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom00_Y3X2_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom07_Y1X0_Tiles
    dfar KeyWorldRoom00_Y0X1_Tiles
    dfar KeyWorldRoom06_Y1X1_Tiles
    dfar KeyWorldRoom01_Y1X2_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom8C_Y3X1_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom00_Y3X3_Tiles
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom01_Y0X1_Attrs
    dfar KeyWorldRoom00_Y0X2_Attrs
    dfar KeyWorldRoom00_Y0X3_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom00_Y3X2_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom07_Y1X0_Attrs
    dfar KeyWorldRoom00_Y0X1_Attrs
    dfar KeyWorldRoom06_Y1X1_Attrs
    dfar KeyWorldRoom01_Y1X2_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom8C_Y3X1_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
    dfar KeyWorldRoom00_Y3X3_Attrs
KeyWorldRoom93:: ; heuristic: key-world room record; C0
Data_072_7A5A:: ; address name
    db $00, $03, $04 ; id 147
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom06_Y1X1_Tiles
    dfar KeyWorldRoom00_Y0X3_Tiles
    dfar KeyWorldRoom04_Y0X0_Tiles
    dfar KeyWorldRoom07_Y1X0_Tiles
    dfar KeyWorldRoom08_Y1X1_Tiles
    dfar KeyWorldRoom00_Y3X1_Tiles
    dfar KeyWorldRoom01_Y1X2_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom02_Y0X1_Tiles
    dfar KeyWorldRoom0B_Y1X1_Tiles
    dfar KeyWorldRoom00_Y3X3_Tiles
    dfar KeyWorldRoom8E_Y3X1_Tiles
    dfar KeyWorldRoom00_Y0X2_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom06_Y1X1_Attrs
    dfar KeyWorldRoom00_Y0X3_Attrs
    dfar KeyWorldRoom04_Y0X0_Attrs
    dfar KeyWorldRoom07_Y1X0_Attrs
    dfar KeyWorldRoom08_Y1X1_Attrs
    dfar KeyWorldRoom00_Y3X1_Attrs
    dfar KeyWorldRoom01_Y1X2_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom02_Y0X1_Attrs
    dfar KeyWorldRoom0B_Y1X1_Attrs
    dfar KeyWorldRoom00_Y3X3_Attrs
    dfar KeyWorldRoom8E_Y3X1_Attrs
    dfar KeyWorldRoom00_Y0X2_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
KeyWorldRoom94:: ; heuristic: key-world room record; C0
Data_072_7ABD:: ; address name
    db $00, $03, $05 ; id 148
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom00_Y0X1_Tiles
    dfar KeyWorldRoom06_Y1X1_Tiles
    dfar KeyWorldRoom00_Y3X2_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom06_Y1X1_Tiles
    dfar KeyWorldRoom01_Y3X1_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom04_Y0X0_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom04_Y1X1_Tiles
    dfar KeyWorldRoom01_Y1X2_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom8D_Y3X1_Tiles
    dfar KeyWorldRoom02_Y0X1_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom00_Y0X1_Attrs
    dfar KeyWorldRoom06_Y1X1_Attrs
    dfar KeyWorldRoom00_Y3X2_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom06_Y1X1_Attrs
    dfar KeyWorldRoom01_Y3X1_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom04_Y0X0_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom04_Y1X1_Attrs
    dfar KeyWorldRoom01_Y1X2_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom8D_Y3X1_Attrs
    dfar KeyWorldRoom02_Y0X1_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
KeyWorldRoom95:: ; heuristic: key-world room record; C0
Data_072_7B20:: ; address name
    db $00, $04, $05 ; id 149
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom0F_Y0X3_Tiles
    dfar KeyWorldRoom02_Y0X1_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom07_Y1X0_Tiles
    dfar KeyWorldRoom00_Y0X3_Tiles
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom01_Y1X2_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom08_Y1X1_Tiles
    dfar KeyWorldRoom0B_Y1X1_Tiles
    dfar KeyWorldRoom00_Y3X3_Tiles
    dfar KeyWorldRoom91_Y3X1_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom05_Y1X1_Tiles
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom0F_Y0X3_Attrs
    dfar KeyWorldRoom02_Y0X1_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom07_Y1X0_Attrs
    dfar KeyWorldRoom00_Y0X3_Attrs
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom01_Y1X2_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom08_Y1X1_Attrs
    dfar KeyWorldRoom0B_Y1X1_Attrs
    dfar KeyWorldRoom00_Y3X3_Attrs
    dfar KeyWorldRoom91_Y3X1_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
    dfar KeyWorldRoom05_Y1X1_Attrs
KeyWorldRoom96:: ; heuristic: key-world room record; C0
Data_072_7B83:: ; address name
    db $01, $02, $03 ; id 150
    dfar KeyWorldRoom04_Y1X1_Tiles
    dfar KeyWorldRoom00_Y0X1_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom02_Y0X0_Tiles
    dfar KeyWorldRoom02_Y0X0_Tiles
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom08_Y1X1_Tiles
    dfar KeyWorldRoom0B_Y1X1_Tiles
    dfar KeyWorldRoom07_Y1X0_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom96_Y3X1_Tiles
    dfar KeyWorldRoom05_Y1X1_Tiles
    dfar KeyWorldRoom00_Y3X3_Tiles
    dfar KeyWorldRoom04_Y1X1_Attrs
    dfar KeyWorldRoom00_Y0X1_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom02_Y0X0_Attrs
    dfar KeyWorldRoom02_Y0X0_Attrs
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom08_Y1X1_Attrs
    dfar KeyWorldRoom0B_Y1X1_Attrs
    dfar KeyWorldRoom07_Y1X0_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom96_Y3X1_Attrs
    dfar KeyWorldRoom05_Y1X1_Attrs
    dfar KeyWorldRoom00_Y3X3_Attrs
KeyWorldRoom97:: ; heuristic: key-world room record; C0
Data_072_7BE6:: ; address name
    db $01, $02, $04 ; id 151
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom00_Y0X2_Tiles
    dfar KeyWorldRoom01_Y0X1_Tiles
    dfar KeyWorldRoom0F_Y0X3_Tiles
    dfar KeyWorldRoom07_Y1X0_Tiles
    dfar KeyWorldRoom00_Y0X1_Tiles
    dfar KeyWorldRoom00_Y3X1_Tiles
    dfar KeyWorldRoom00_Y0X3_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom04_Y0X0_Tiles
    dfar KeyWorldRoom02_Y0X0_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom00_Y3X3_Tiles
    dfar KeyWorldRoom8E_Y3X1_Tiles
    dfar KeyWorldRoom00_Y3X1_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom00_Y0X2_Attrs
    dfar KeyWorldRoom01_Y0X1_Attrs
    dfar KeyWorldRoom0F_Y0X3_Attrs
    dfar KeyWorldRoom07_Y1X0_Attrs
    dfar KeyWorldRoom00_Y0X1_Attrs
    dfar KeyWorldRoom00_Y3X1_Attrs
    dfar KeyWorldRoom00_Y0X3_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom04_Y0X0_Attrs
    dfar KeyWorldRoom02_Y0X0_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom00_Y3X3_Attrs
    dfar KeyWorldRoom8E_Y3X1_Attrs
    dfar KeyWorldRoom00_Y3X1_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
KeyWorldRoom98:: ; heuristic: key-world room record; C0
Data_072_7C49:: ; address name
    db $01, $02, $05 ; id 152
    dfar KeyWorldRoom04_Y0X0_Tiles
    dfar KeyWorldRoom02_Y0X1_Tiles
    dfar KeyWorldRoom06_Y1X1_Tiles
    dfar KeyWorldRoom00_Y3X2_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom04_Y1X1_Tiles
    dfar KeyWorldRoom08_Y1X1_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom07_Y1X0_Tiles
    dfar KeyWorldRoom00_Y0X1_Tiles
    dfar KeyWorldRoom07_Y1X2_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom96_Y3X1_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom0F_Y0X3_Tiles
    dfar KeyWorldRoom04_Y0X0_Attrs
    dfar KeyWorldRoom02_Y0X1_Attrs
    dfar KeyWorldRoom06_Y1X1_Attrs
    dfar KeyWorldRoom00_Y3X2_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom04_Y1X1_Attrs
    dfar KeyWorldRoom08_Y1X1_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom07_Y1X0_Attrs
    dfar KeyWorldRoom00_Y0X1_Attrs
    dfar KeyWorldRoom07_Y1X2_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom96_Y3X1_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom0F_Y0X3_Attrs
KeyWorldRoom99:: ; heuristic: key-world room record; C0
Data_072_7CAC:: ; address name
    db $01, $03, $04 ; id 153
    dfar KeyWorldRoom02_Y0X0_Tiles
    dfar KeyWorldRoom04_Y0X0_Tiles
    dfar KeyWorldRoom02_Y0X0_Tiles
    dfar KeyWorldRoom04_Y0X0_Tiles
    dfar KeyWorldRoom07_Y1X0_Tiles
    dfar KeyWorldRoom08_Y1X1_Tiles
    dfar KeyWorldRoom07_Y1X2_Tiles
    dfar KeyWorldRoom01_Y1X2_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom00_Y3X3_Tiles
    dfar KeyWorldRoom99_Y3X1_Tiles
    dfar KeyWorldRoom00_Y3X3_Tiles
    dfar KeyWorldRoom05_Y1X1_Tiles
    dfar KeyWorldRoom02_Y0X0_Attrs
    dfar KeyWorldRoom04_Y0X0_Attrs
    dfar KeyWorldRoom02_Y0X0_Attrs
    dfar KeyWorldRoom04_Y0X0_Attrs
    dfar KeyWorldRoom07_Y1X0_Attrs
    dfar KeyWorldRoom08_Y1X1_Attrs
    dfar KeyWorldRoom07_Y1X2_Attrs
    dfar KeyWorldRoom01_Y1X2_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom00_Y3X3_Attrs
    dfar KeyWorldRoom99_Y3X1_Attrs
    dfar KeyWorldRoom00_Y3X3_Attrs
    dfar KeyWorldRoom05_Y1X1_Attrs
KeyWorldRoom9A:: ; heuristic: key-world room record; C0
Data_072_7D0F:: ; address name
    db $01, $03, $05 ; id 154
    dfar KeyWorldRoom04_Y0X0_Tiles
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom00_Y0X2_Tiles
    dfar KeyWorldRoom00_Y0X3_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom07_Y1X0_Tiles
    dfar KeyWorldRoom00_Y0X1_Tiles
    dfar KeyWorldRoom0B_Y1X1_Tiles
    dfar KeyWorldRoom07_Y1X0_Tiles
    dfar KeyWorldRoom01_Y1X2_Tiles
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom01_Y1X2_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom8D_Y3X1_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom04_Y0X0_Attrs
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom00_Y0X2_Attrs
    dfar KeyWorldRoom00_Y0X3_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom07_Y1X0_Attrs
    dfar KeyWorldRoom00_Y0X1_Attrs
    dfar KeyWorldRoom0B_Y1X1_Attrs
    dfar KeyWorldRoom07_Y1X0_Attrs
    dfar KeyWorldRoom01_Y1X2_Attrs
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom01_Y1X2_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom8D_Y3X1_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
KeyWorldRoom9B:: ; heuristic: key-world room record; C0
Data_072_7D72:: ; address name
    db $01, $04, $05 ; id 155
    dfar KeyWorldRoom02_Y0X1_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom0F_Y0X3_Tiles
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom08_Y1X1_Tiles
    dfar KeyWorldRoom07_Y1X2_Tiles
    dfar KeyWorldRoom00_Y0X3_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom07_Y1X0_Tiles
    dfar KeyWorldRoom01_Y1X2_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom00_Y3X3_Tiles
    dfar KeyWorldRoom8E_Y3X1_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom05_Y1X1_Tiles
    dfar KeyWorldRoom02_Y0X1_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom0F_Y0X3_Attrs
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom08_Y1X1_Attrs
    dfar KeyWorldRoom07_Y1X2_Attrs
    dfar KeyWorldRoom00_Y0X3_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom07_Y1X0_Attrs
    dfar KeyWorldRoom01_Y1X2_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom00_Y3X3_Attrs
    dfar KeyWorldRoom8E_Y3X1_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
    dfar KeyWorldRoom05_Y1X1_Attrs
KeyWorldRoom9C:: ; heuristic: key-world room record; C0
Data_072_7DD5:: ; address name
    db $02, $03, $04 ; id 156
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom00_Y0X1_Tiles
    dfar KeyWorldRoom06_Y1X1_Tiles
    dfar KeyWorldRoom00_Y0X3_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom01_Y1X2_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom07_Y1X0_Tiles
    dfar KeyWorldRoom01_Y3X1_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom05_Y1X1_Tiles
    dfar KeyWorldRoom91_Y3X1_Tiles
    dfar KeyWorldRoom00_Y0X1_Tiles
    dfar KeyWorldRoom00_Y2X2_Tiles
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom00_Y0X1_Attrs
    dfar KeyWorldRoom06_Y1X1_Attrs
    dfar KeyWorldRoom00_Y0X3_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom01_Y1X2_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom07_Y1X0_Attrs
    dfar KeyWorldRoom01_Y3X1_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom05_Y1X1_Attrs
    dfar KeyWorldRoom91_Y3X1_Attrs
    dfar KeyWorldRoom00_Y0X1_Attrs
    dfar KeyWorldRoom00_Y2X2_Attrs
KeyWorldRoom9D:: ; heuristic: key-world room record; C0
Data_072_7E38:: ; address name
    db $02, $03, $05 ; id 157
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom06_Y1X1_Tiles
    dfar KeyWorldRoom00_Y0X1_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom00_Y2X1_Tiles
    dfar KeyWorldRoom00_Y0X2_Tiles
    dfar KeyWorldRoom01_Y1X2_Tiles
    dfar KeyWorldRoom00_Y2X1_Tiles
    dfar KeyWorldRoom00_Y3X1_Tiles
    dfar KeyWorldRoom01_Y0X1_Tiles
    dfar KeyWorldRoom0B_Y1X1_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom96_Y3X1_Tiles
    dfar KeyWorldRoom04_Y3X0_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom06_Y1X1_Attrs
    dfar KeyWorldRoom00_Y0X1_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom00_Y2X1_Attrs
    dfar KeyWorldRoom00_Y0X2_Attrs
    dfar KeyWorldRoom01_Y1X2_Attrs
    dfar KeyWorldRoom00_Y2X1_Attrs
    dfar KeyWorldRoom00_Y3X1_Attrs
    dfar KeyWorldRoom01_Y0X1_Attrs
    dfar KeyWorldRoom0B_Y1X1_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom96_Y3X1_Attrs
    dfar KeyWorldRoom04_Y3X0_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
KeyWorldRoom9E:: ; heuristic: key-world room record; C0
Data_072_7E9B:: ; address name
    db $02, $04, $05 ; id 158
    dfar KeyWorldRoom00_Y0X0_Tiles
    dfar KeyWorldRoom01_Y0X1_Tiles
    dfar KeyWorldRoom06_Y1X1_Tiles
    dfar KeyWorldRoom00_Y3X2_Tiles
    dfar KeyWorldRoom00_Y2X1_Tiles
    dfar KeyWorldRoom00_Y3X1_Tiles
    dfar KeyWorldRoom08_Y1X1_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom07_Y1X2_Tiles
    dfar KeyWorldRoom01_Y3X3_Tiles
    dfar KeyWorldRoom05_Y1X1_Tiles
    dfar KeyWorldRoom99_Y3X1_Tiles
    dfar KeyWorldRoom00_Y3X0_Tiles
    dfar KeyWorldRoom0F_Y0X3_Tiles
    dfar KeyWorldRoom00_Y0X0_Attrs
    dfar KeyWorldRoom01_Y0X1_Attrs
    dfar KeyWorldRoom06_Y1X1_Attrs
    dfar KeyWorldRoom00_Y3X2_Attrs
    dfar KeyWorldRoom00_Y2X1_Attrs
    dfar KeyWorldRoom00_Y3X1_Attrs
    dfar KeyWorldRoom08_Y1X1_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom07_Y1X2_Attrs
    dfar KeyWorldRoom01_Y3X3_Attrs
    dfar KeyWorldRoom05_Y1X1_Attrs
    dfar KeyWorldRoom99_Y3X1_Attrs
    dfar KeyWorldRoom00_Y3X0_Attrs
    dfar KeyWorldRoom0F_Y0X3_Attrs
KeyWorldRoom9F:: ; heuristic: key-world room record; C0
Data_072_7EFE:: ; address name
    db $03, $04, $05 ; id 159
    dfar KeyWorldRoom01_Y0X0_Tiles
    dfar KeyWorldRoom06_Y1X1_Tiles
    dfar KeyWorldRoom01_Y0X1_Tiles
    dfar KeyWorldRoom02_Y1X1_Tiles
    dfar KeyWorldRoom07_Y1X0_Tiles
    dfar KeyWorldRoom01_Y1X2_Tiles
    dfar KeyWorldRoom07_Y1X0_Tiles
    dfar KeyWorldRoom01_Y1X2_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom00_Y1X0_Tiles
    dfar KeyWorldRoom00_Y1X3_Tiles
    dfar KeyWorldRoom00_Y3X3_Tiles
    dfar KeyWorldRoom99_Y3X1_Tiles
    dfar KeyWorldRoom00_Y3X3_Tiles
    dfar KeyWorldRoom05_Y1X1_Tiles
    dfar KeyWorldRoom01_Y0X0_Attrs
    dfar KeyWorldRoom06_Y1X1_Attrs
    dfar KeyWorldRoom01_Y0X1_Attrs
    dfar KeyWorldRoom02_Y1X1_Attrs
    dfar KeyWorldRoom07_Y1X0_Attrs
    dfar KeyWorldRoom01_Y1X2_Attrs
    dfar KeyWorldRoom07_Y1X0_Attrs
    dfar KeyWorldRoom01_Y1X2_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom00_Y1X0_Attrs
    dfar KeyWorldRoom00_Y1X3_Attrs
    dfar KeyWorldRoom00_Y3X3_Attrs
    dfar KeyWorldRoom99_Y3X1_Attrs
    dfar KeyWorldRoom00_Y3X3_Attrs
    dfar KeyWorldRoom05_Y1X1_Attrs
    ds $9F, $00
