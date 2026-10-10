SECTION "Bank 11", ROMX[$4000], BANK[$11]
    db $11, $C9

; unless a special mode is set (wCC44 bit 7 hands over to Func_061_5764): walks the warp list MapWarpTable[hMapId]; an entry matching hPlayerFacing, the player's position and its screen nibbles starts a map change: wCCEA = 1, sound effect $60 is queued, and the entry's new hMapId, hFF8F, hFF92 and position (wC8C8/wC8C9) are stored
; 6 call sites from 1 routine (e.g. UpdatePlayerMovement)
; reads: wCC44, hMapId, hPlayerFacing, hMapScreenX, hMapScreenY, hPlayerX, hPlayerY, wC8CA, ...
; writes: wC8CA, wCCEA, hMapId, hMapScreenX, hMapScreenY, wC8C8, wC8C9, hFF8C, ...
; points at: wC5E0
CheckWarpAtPlayer::
Func_011_4002:: ; address name
    ld a, [wCC44]
    bit 7, a
    jr z, Jump_011_4010
    farcall Func_061_5764
    ret

Jump_011_4010::
    ldh a, [hMapId]
    ld l, a
    ld h, $00
    add hl, hl
    ld de, Data_011_67A6
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a

Jump_011_401E::
    push de
    ld a, [de]
    inc de
    cp a, $80
    jr nz, Jump_011_4029
    pop de
    ld c, $00
    ret

Jump_011_4029::
    cp a, $FD
    jr z, Jump_011_407D
    cp a, $FE
    jr z, Jump_011_4066
    cp a, $FF
    jr z, Jump_011_4066
    ld c, a
    ldh a, [hPlayerFacing]
    cp a, c
    jr nz, Jump_011_407D
    ld a, [de]
    inc de
    ld [wC8CA], a
    push af
    swap a
    and a, $0F
    ld c, a
    ldh a, [hMapScreenX]
    cp a, c
    jr nz, Jump_011_407C
    pop af
    and a, $0F
    ld c, a
    ldh a, [hMapScreenY]
    cp a, c
    jr nz, Jump_011_407D
    ld a, [de]
    inc de
    ld c, a
    ldh a, [hPlayerX]
    cp a, c
    jr nz, Jump_011_407D
    ld a, [de]
    inc de
    ld c, a
    ldh a, [hPlayerY]
    cp a, c
    jr nz, Jump_011_407D
    jr Jump_011_4088

Jump_011_4066::
    ld [wC8CA], a
    inc de
    ld a, [de]
    inc de
    ld c, a
    ldh a, [hMapScreenX]
    cp a, c
    jr nz, Jump_011_407D
    ld a, [de]
    inc de
    ld c, a
    ldh a, [hMapScreenY]
    cp a, c
    jr nz, Jump_011_407D
    jr Jump_011_4088

Jump_011_407C::
    pop af

Jump_011_407D::
    pop de
    ld a, e
    add a, $09
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    jr Jump_011_401E

Jump_011_4088::
    ld a, $01
    ld [wCCEA], a
    ld a, $60
    call QueueSoundEffect
    ld a, [de]
    inc de
    ldh [hMapId], a
    ld a, [de]
    inc de
    and a, $0F
    ldh [hMapScreenX], a
    ld a, [de]
    and a, $0F
    inc de
    ldh [hMapScreenY], a
    ld a, [wC8CA]
    cp a, $FF
    jr z, Jump_011_40D2
    ld a, [de]
    inc de
    swap a
    and a, $F0
    ld [wC8C8], a
    ld a, [de]
    swap a
    and a, $F0
    ld [wC8C9], a
    dec de
    dec de
    dec de
    ld a, [de]
    bit 7, a
    jr z, Jump_011_40F9
    ldh a, [hFF8C]
    or a, $40
    ldh [hFF8C], a
    ld a, [wC8C9]
    add a, $08
    ld [wC8C9], a
    jr Jump_011_40F9

Jump_011_40D2::
    ld a, [de]
    inc de
    ld c, a
    ldh a, [hPlayerX]
    add a, c
    ld [wC8C8], a
    ld a, [de]
    ld c, a
    ldh a, [hPlayerY]
    add a, c
    ld [wC8C9], a
    dec de
    dec de
    dec de
    ld a, [de]
    bit 7, a
    jr z, Jump_011_40F9
    ldh a, [hFF8C]
    or a, $40
    ldh [hFF8C], a
    ld a, [wC8C9]
    add a, $08
    ld [wC8C9], a

Jump_011_40F9::
    ld a, [de]
    swap a
    and a, $03
    cp a, $03
    jr z, Jump_011_4105
    ld [wC88B], a

Jump_011_4105::
    inc de
    ld a, [de]
    swap a
    and a, $0F
    ld [wC8C6], a
    ld a, $04
    call StartPaletteFade
    ld hl, wC5E0
    inc [hl]
    ld a, $04
    ld [wModeState], a
    xor a, a
    ld [wC8C5], a
    ldh a, [hFF8C]
    or a, $80
    ldh [hFF8C], a
    farcall Func_012_7B9F
    pop de
    ld c, $01
    ret

; 3 call sites from 3 routines (e.g. Func_002_4C4E, Func_002_56DC, Func_002_5BD7)
; reads: wCC44, hMapId, hFF8C, hMapScreenX, hMapScreenY, hPlayerX, hPlayerY, wC8C9
; writes: hFF8C, wC8CA, wCCEA, hMapId, hMapScreenX, hMapScreenY, wC8C8, wC8C9, ...
; points at: wC5E0
Func_011_4130::
    ld a, [wCC44]
    bit 7, a
    jr z, Jump_011_413E
    farcall Func_061_596F
    ret

Jump_011_413E::
    call Func_011_43BB
    bit 0, c
    ret nz
    ldh a, [hMapId]
    ld l, a
    ld h, $00
    add hl, hl
    ld de, Data_011_67A6
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a

Jump_011_4152::
    push de
    ld a, [de]
    inc de
    cp a, $80
    jr nz, Jump_011_4199
    pop de
    ldh a, [hFF8C]
    bit 7, a
    jr z, Jump_011_4196
    ldh a, [hMapId]
    cp a, $30
    jr nz, Jump_011_4190
    ldh a, [hMapScreenX]
    cp a, $05
    jr nz, Jump_011_4190
    ldh a, [hMapScreenY]
    cp a, $05
    jr nz, Jump_011_4190
    ldh a, [hPlayerX]
    cp a, $40
    jr nz, Jump_011_4190
    ldh a, [hPlayerY]
    cp a, $50
    jr nz, Jump_011_4190
    ld de, $0076
    call TestFlagBit
    jr c, Jump_011_4190
    ld de, $0070
    call TestFlagBit
    jr nc, Jump_011_4190
    jr Jump_011_4196

Jump_011_4190::
    ldh a, [hFF8C]
    and a, $7F
    ldh [hFF8C], a

Jump_011_4196::
    ld c, $00
    ret

Jump_011_4199::
    cp a, $FD
    jr z, Jump_011_419F
    jr Jump_011_41DA

Jump_011_419F::
    ld a, [de]
    inc de
    ld [wC8CA], a
    push af
    swap a
    and a, $0F
    ld c, a
    ldh a, [hMapScreenX]
    cp a, c
    jr nz, Jump_011_41D9
    pop af
    and a, $0F
    ld c, a
    ldh a, [hMapScreenY]
    cp a, c
    jr nz, Jump_011_41DA
    ld a, [de]
    inc de
    ld c, a
    ldh a, [hPlayerX]
    cp a, c
    jr nz, Jump_011_41DA
    ld a, [de]
    inc de
    ld c, a
    ldh a, [hPlayerY]
    cp a, c
    jr z, Jump_011_41CD
    add a, $F8
    cp a, c
    jr nz, Jump_011_41DA

Jump_011_41CD::
    ldh a, [hFF8C]
    bit 7, a
    jr z, Jump_011_41D7
    pop de
    ld c, $00
    ret

Jump_011_41D7::
    jr Jump_011_41E6

Jump_011_41D9::
    pop af

Jump_011_41DA::
    pop de
    ld a, e
    add a, $09
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    jp Jump_011_4152

Jump_011_41E6::
    ld a, $01
    ld [wCCEA], a
    ld a, $60
    call QueueSoundEffect
    ld a, [de]
    inc de
    ldh [hMapId], a
    ld a, [de]
    and a, $0F
    inc de
    ldh [hMapScreenX], a
    ld a, [de]
    and a, $0F
    inc de
    ldh [hMapScreenY], a
    ld a, [de]
    inc de
    swap a
    and a, $F0
    ld [wC8C8], a
    ld a, [de]
    swap a
    and a, $F0
    ld [wC8C9], a
    dec de
    dec de
    dec de
    ld a, [de]
    bit 7, a
    jr z, Jump_011_4229
    ldh a, [hFF8C]
    or a, $40
    ldh [hFF8C], a
    ld a, [wC8C9]
    add a, $08
    ld [wC8C9], a
    jr Jump_011_4229

Jump_011_4229::
    ld a, [de]
    swap a
    and a, $03
    cp a, $03
    jr z, Jump_011_4235
    ld [wC88B], a

Jump_011_4235::
    inc de
    ld a, [de]
    swap a
    and a, $0F
    ld [wC8C6], a
    ld a, $04
    call StartPaletteFade
    ld hl, wC5E0
    inc [hl]
    xor a, a
    ld [wC8C7], a
    ld a, $04
    ld [wModeState], a
    xor a, a
    ld [wC8C5], a
    ldh a, [hFF8C]
    or a, $80
    ldh [hFF8C], a
    farcall Func_012_7B9F
    pop de
    xor a, a
    ld [wJoypadPressed], a
    ld c, $01
    ret

; 2 call sites from 2 routines (e.g. UpdatePlayerMovement, Func_061_5794)
; reads: wCC44, hMapId, wC88E, wC891, wCC42, wC88F, wC890, wCD09, ...
; writes: hMapId, wC8C8, wC8C9, hMapScreenX, hMapScreenY
; points at: wC88F
Func_011_4268::
    ld a, [wCC44]
    bit 7, a
    jp nz, Jump_011_42D9
    ldh a, [hMapId]
    ld c, a
    ld b, $00
    ld hl, Func_011_42AC

Jump_011_4278::
    ld a, [hl+]
    cp a, $FF
    jr nz, Jump_011_4280
    ld c, $00
    ret

Jump_011_4280::
    cp a, c
    jr z, Jump_011_4286
    inc b
    jr Jump_011_4278

Jump_011_4286::
    ld a, b
    sla a
    add a, b
    ld de, Data_011_42B8
    add a, e
    ld e, a
    jr nc, Jump_011_4292
    inc d

Jump_011_4292::
    ld a, [de]
    inc de
    ldh [hMapId], a
    ld a, [wC88E]
    or a, a
    jr z, Jump_011_42A6
    ld a, [wC891]
    dec a
    cp a, b
    jr nz, Jump_011_42A6
    ld de, wC88F

Jump_011_42A6::
    call Func_011_4340
    ld c, $01
    ret

; no direct call (reached through a table, a jump or a vector)
Func_011_42AC:: ; heuristic: follows a terminator; C0
    add hl, hl
    ld b, l
    ld l, b
    sbc a, l
    and a, h
    xor a, a
    or a, d
    push bc
    ret nc
    reti
    db $E2, $FF

Data_011_42B8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $20, $44, $00, $30, $44, $76, $48, $44, $B4, $70, $44, $B4, $A0, $44, $10, $A8
    db $44, $00, $B0, $44, $01, $B8, $44, $44, $C8, $44, $01, $D1, $44, $00, $DA, $44
    db $00

Jump_011_42D9::
    cp a, $87
    jr z, Jump_011_42E0
    ld c, $00
    ret

Jump_011_42E0::
    ld a, [wC88E]
    or a, a
    jr z, Jump_011_431E
    ld a, [wC891]
    bit 7, a
    jr z, Jump_011_431E
    and a, $7F
    ld c, a
    ld a, [wCC42]
    cp a, c
    jr nz, Jump_011_431E
    ld a, [wC88F]
    and a, $F0
    ld [wC8C8], a
    ld a, [wC88F]
    and a, $0F
    swap a
    ld [wC8C9], a
    ld a, [wC890]
    and a, $F0
    swap a
    ldh [hMapScreenX], a
    ld a, [wC890]
    and a, $0F
    ldh [hMapScreenY], a
    call Func_011_438F
    ld c, $01
    ret

Jump_011_431E::
    ld a, [wCD09]
    ld [wC8C8], a
    ld a, [wCD0A]
    ld [wC8C9], a
    ld a, [wCD08]
    and a, $F0
    swap a
    ldh [hMapScreenX], a
    ld a, [wCD08]
    and a, $0F
    ldh [hMapScreenY], a
    call Func_011_438F
    ld c, $01
    ret

; 1 call site from 1 routine (e.g. Func_011_4268)
; reads: hFF8C
; writes: wCCEA, wC8C8, wC8C9, hMapScreenX, hMapScreenY, wC8C6, wModeState, wC8C5, ...
; points at: wC5E0
Func_011_4340::
    ld a, $01
    ld [wCCEA], a
    ld a, $60
    call QueueSoundEffect
    ld a, [de]
    and a, $F0
    ld [wC8C8], a
    ld a, [de]
    swap a
    and a, $F0
    ld [wC8C9], a
    inc de
    ld a, [de]
    swap a
    and a, $0F
    ldh [hMapScreenX], a
    ld a, [de]
    and a, $0F
    inc de
    ldh [hMapScreenY], a
    ld a, $01
    ld [wC8C6], a
    ld a, $04
    call StartPaletteFade
    ld hl, wC5E0
    inc [hl]
    ld a, $04
    ld [wModeState], a
    xor a, a
    ld [wC8C5], a
    ldh a, [hFF8C]
    or a, $20
    and a, $7F
    ldh [hFF8C], a
    farcall Func_012_7B9F
    pop de
    ld c, $01
    ret

; 2 call sites from 1 routine (e.g. Func_011_42AC)
; reads: hFF8C
; writes: wC8CA, wModeState, wC8C5, hFF8C, wC8C6
Func_011_438F::
    ld a, $F0
    ld [wC8CA], a
    ld a, $60
    call QueueSoundEffect
    ld a, $04
    call StartPaletteFade
    ld a, $04
    ld [wModeState], a
    xor a, a
    ld [wC8C5], a
    ldh a, [hFF8C]
    or a, $20
    and a, $7F
    ldh [hFF8C], a
    ldh a, [hFF8C]
    and a, $FE
    ldh [hFF8C], a
    ld a, $01
    ld [wC8C6], a
    ret

; 1 call site from 1 routine (e.g. Func_011_4130)
; reads: hMapId, hFF8C, wC88E, wC891
; writes: hFF8C
; points at: wC88F
Func_011_43BB::
    ldh a, [hMapId]
    cp a, $20
    jr c, Jump_011_43CC
    ld c, a
    ld b, $00
    ld hl, Data_011_4480

Jump_011_43C7::
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_011_43D5

Jump_011_43CC::
    ldh a, [hFF8C]
    and a, $DF
    ldh [hFF8C], a
    ld c, $00
    ret

Jump_011_43D5::
    cp a, c
    jr z, Jump_011_43DF
    inc b
    inc hl
    inc hl
    inc hl
    inc hl
    jr Jump_011_43C7

Jump_011_43DF::
    ld a, [wC88E]
    or a, a
    jr z, Jump_011_43F3
    ld a, [wC891]
    dec a
    cp a, b
    jr nz, Jump_011_43F3
    ld de, wC88F
    call Func_011_43FA
    ret

Jump_011_43F3::
    ld e, l
    ld d, h
    inc de
    call Func_011_43FA
    ret

; 2 call sites from 1 routine (e.g. Func_011_43BB)
; reads: hPlayerX, hPlayerY, hMapScreenX, hMapScreenY, hFF8C
; writes: wCCEA, hMapId, hMapScreenX, hMapScreenY, wC8C8, wC8C9, wC88B, wC8C6, ...
; points at: wC5E0
Func_011_43FA::
    ldh a, [hPlayerX]
    and a, $F0
    ld c, a
    ldh a, [hPlayerY]
    and a, $F0
    swap a
    or a, c
    ld c, a
    ld a, [de]
    cp a, c
    jr nz, Jump_011_4422
    ldh a, [hMapScreenX]
    swap a
    ld c, a
    ldh a, [hMapScreenY]
    or a, c
    ld c, a
    inc de
    ld a, [de]
    cp a, c
    jr nz, Jump_011_4422
    ldh a, [hFF8C]
    bit 5, a
    jr z, Jump_011_442B
    ld c, $00
    ret

Jump_011_4422::
    ldh a, [hFF8C]
    and a, $DF
    ldh [hFF8C], a
    ld c, $00
    ret

Jump_011_442B::
    ld a, $01
    ld [wCCEA], a
    ld a, $60
    call QueueSoundEffect
    inc de
    ld a, [de]
    dec a
    ld hl, Data_011_44AD
    add_a_to_hl
    ld a, [hl]
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wC8C8], a
    ld a, $80
    ld [wC8C9], a
    xor a, a
    ld [wC88B], a
    ld a, $03
    ld [wC8C6], a
    ld a, $04
    call StartPaletteFade
    ld hl, wC5E0
    inc [hl]
    xor a, a
    ld [wC8C7], a
    ld a, $04
    ld [wModeState], a
    xor a, a
    ld [wC8C5], a
    ldh a, [hFF8C]
    or a, $20
    ldh [hFF8C], a
    farcall Func_012_7B9F
    ld c, $01
    ret

Data_011_4480:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $20, $44, $00, $01, $30, $44, $76, $02, $48, $44, $B4, $03, $70, $44, $B4, $04
    db $A0, $44, $10, $05, $A8, $44, $00, $06, $B0, $44, $01, $07, $B8, $44, $44, $08
    db $C8, $44, $01, $09, $D1, $44, $00, $0A, $DA, $44, $00, $0B, $FF

Data_011_44AD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $29, $45, $68, $9D, $A4, $AF, $B2, $C5, $D0, $D9, $E2

; E-0036 (C1: the pointer for map 56 is the record whose tileset stream (57:6E96) the game decompressed to $9000 on the emulator while hMapId was 56; the table has 256 words and ends where the first record begins; entries 30, 31 and 39 are not valid pointers and the system strings for map numbers 30, 31 and 39 (index 10 + number) read 'NO'; map 29 is the ship deck where a new game starts and the string at index 39 is 'Deck'). Records are 48 or 66 bytes; the first three far pointers (address and bank byte) name streams: the tileset for $9000 and, in later fields, the tile map for $C198 and the attribute map for $D000.
; record: map record in this bank, indexed by the map number hMapId
MapTable::
Data_011_44B8:: ; heuristic: start of a structured table; C0
    dw Data_011_46B8 ; entry 0
    dw Data_011_46FA ; entry 1
    dw Data_011_473C ; entry 2
    dw Data_011_477E ; entry 3
    dw Data_011_47C0 ; entry 4
    dw Data_011_4802 ; entry 5
    dw Data_011_4844 ; entry 6
    dw Data_011_4886 ; entry 7
    dw Data_011_490A ; entry 8
    dw Data_011_48C8 ; entry 9
    dw Data_011_494C ; entry 10
    dw Data_011_498E ; entry 11
    dw Data_011_49D0 ; entry 12
    dw Data_011_4A12 ; entry 13
    dw Data_011_4A54 ; entry 14
    dw Data_011_4A96 ; entry 15
    dw Data_011_4AD8 ; entry 16
    dw Data_011_4B1A ; entry 17
    dw Data_011_4B5C ; entry 18
    dw Data_011_4B9E ; entry 19
    dw Data_011_4BE0 ; entry 20
    dw Data_011_4C22 ; entry 21
    dw Data_011_4C64 ; entry 22
    dw Data_011_4CA6 ; entry 23
    dw Data_011_4CE8 ; entry 24
    dw Data_011_4D2A ; entry 25
    dw Data_011_4D6C ; entry 26
    dw Data_011_4DAE ; entry 27
    dw Data_011_4DF0 ; entry 28
    dw Data_011_4E0E ; entry 29
    dw $0000 ; entry 30
    dw $0000 ; entry 31
    dw Data_011_4E2C ; entry 32
    dw Data_011_4E68 ; entry 33
    dw Data_011_4EA4 ; entry 34
    dw Data_011_4EE0 ; entry 35
    dw Data_011_4F1C ; entry 36
    dw Data_011_4F58 ; entry 37
    dw Data_011_4F94 ; entry 38
    dw $0000 ; entry 39
    dw Data_011_4FD0 ; entry 40
    dw Data_011_500C ; entry 41
    dw Data_011_5048 ; entry 42
    dw Data_011_5084 ; entry 43
    dw $0000 ; entry 44
    dw Data_011_50C0 ; entry 45
    dw Data_011_50FC ; entry 46
    dw Data_011_5138 ; entry 47
    dw Data_011_5174 ; entry 48
    dw Data_011_51A4 ; entry 49
    dw Data_011_51D4 ; entry 50
    dw Data_011_5204 ; entry 51
    dw Data_011_5234 ; entry 52
    dw Data_011_5264 ; entry 53
    dw Data_011_5294 ; entry 54
    dw Data_011_52C4 ; entry 55
    dw Data_011_52F4 ; entry 56
    dw Data_011_5324 ; entry 57
    dw Data_011_5354 ; entry 58
    dw Data_011_5384 ; entry 59
    dw Data_011_53B4 ; entry 60
    dw Data_011_53E4 ; entry 61
    dw Data_011_5414 ; entry 62
    dw Data_011_5444 ; entry 63
    dw Data_011_5474 ; entry 64
    dw Data_011_54A4 ; entry 65
    dw Data_011_54D4 ; entry 66
    dw Data_011_5504 ; entry 67
    dw Data_011_5534 ; entry 68
    dw Data_011_500C ; entry 69
    dw $0000 ; entry 70
    dw $0000 ; entry 71
    dw Data_011_5564 ; entry 72
    dw Data_011_5588 ; entry 73
    dw Data_011_55AC ; entry 74
    dw Data_011_55D0 ; entry 75
    dw Data_011_55F4 ; entry 76
    dw Data_011_5618 ; entry 77
    dw Data_011_563C ; entry 78
    dw Data_011_5660 ; entry 79
    dw Data_011_5684 ; entry 80
    dw Data_011_56A8 ; entry 81
    dw Data_011_56CC ; entry 82
    dw Data_011_56F0 ; entry 83
    dw Data_011_5714 ; entry 84
    dw Data_011_5738 ; entry 85
    dw Data_011_575C ; entry 86
    dw Data_011_5780 ; entry 87
    dw Data_011_57A4 ; entry 88
    dw Data_011_57C8 ; entry 89
    dw Data_011_57EC ; entry 90
    dw Data_011_5810 ; entry 91
    dw Data_011_5834 ; entry 92
    dw Data_011_5858 ; entry 93
    dw Data_011_587C ; entry 94
    dw Data_011_58A0 ; entry 95
    dw Data_011_58C4 ; entry 96
    dw Data_011_58E8 ; entry 97
    dw Data_011_590C ; entry 98
    dw Data_011_5930 ; entry 99
    dw Data_011_5954 ; entry 100
    dw Data_011_5978 ; entry 101
    dw Data_011_599C ; entry 102
    dw Data_011_59C0 ; entry 103
    dw Data_011_500C ; entry 104
    dw $0000 ; entry 105
    dw $0000 ; entry 106
    dw $0000 ; entry 107
    dw $0000 ; entry 108
    dw $0000 ; entry 109
    dw $0000 ; entry 110
    dw $0000 ; entry 111
    dw Data_011_5A08 ; entry 112
    dw Data_011_5A38 ; entry 113
    dw Data_011_5A68 ; entry 114
    dw Data_011_5A98 ; entry 115
    dw Data_011_5AC8 ; entry 116
    dw Data_011_5AF8 ; entry 117
    dw Data_011_5B28 ; entry 118
    dw Data_011_5B58 ; entry 119
    dw Data_011_5B88 ; entry 120
    dw Data_011_5BB8 ; entry 121
    dw Data_011_5BE8 ; entry 122
    dw Data_011_5C18 ; entry 123
    dw Data_011_5C48 ; entry 124
    dw Data_011_5C78 ; entry 125
    dw Data_011_5CA8 ; entry 126
    dw Data_011_5CD8 ; entry 127
    dw Data_011_5D08 ; entry 128
    dw Data_011_5D38 ; entry 129
    dw Data_011_5D68 ; entry 130
    dw Data_011_5D98 ; entry 131
    dw Data_011_5DC8 ; entry 132
    dw Data_011_5DF8 ; entry 133
    dw Data_011_5E28 ; entry 134
    dw Data_011_5E58 ; entry 135
    dw Data_011_5E88 ; entry 136
    dw Data_011_5EB8 ; entry 137
    dw Data_011_5EE8 ; entry 138
    dw Data_011_5F18 ; entry 139
    dw Data_011_5F48 ; entry 140
    dw Data_011_5F78 ; entry 141
    dw Data_011_5FA8 ; entry 142
    dw Data_011_5FD8 ; entry 143
    dw Data_011_6008 ; entry 144
    dw Data_011_6038 ; entry 145
    dw Data_011_6068 ; entry 146
    dw Data_011_6098 ; entry 147
    dw Data_011_60C8 ; entry 148
    dw Data_011_60F8 ; entry 149
    dw Data_011_6128 ; entry 150
    dw Data_011_6158 ; entry 151
    dw Data_011_6188 ; entry 152
    dw Data_011_61B8 ; entry 153
    dw Data_011_61E8 ; entry 154
    dw Data_011_6218 ; entry 155
    dw $0000 ; entry 156
    dw Data_011_500C ; entry 157
    dw $0000 ; entry 158
    dw $0000 ; entry 159
    dw Data_011_6278 ; entry 160
    dw Data_011_6296 ; entry 161
    dw Data_011_62B4 ; entry 162
    dw Data_011_62D2 ; entry 163
    dw Data_011_500C ; entry 164
    dw $0000 ; entry 165
    dw $0000 ; entry 166
    dw $0000 ; entry 167
    dw Data_011_630E ; entry 168
    dw Data_011_6326 ; entry 169
    dw Data_011_633E ; entry 170
    dw Data_011_6356 ; entry 171
    dw Data_011_636E ; entry 172
    dw Data_011_6386 ; entry 173
    dw Data_011_639E ; entry 174
    dw Data_011_500C ; entry 175
    dw Data_011_63B6 ; entry 176
    dw Data_011_63D4 ; entry 177
    dw Data_011_500C ; entry 178
    dw Data_011_63F2 ; entry 179
    dw Data_011_6410 ; entry 180
    dw Data_011_642E ; entry 181
    dw Data_011_644C ; entry 182
    dw $0000 ; entry 183
    dw Data_011_646A ; entry 184
    dw Data_011_648E ; entry 185
    dw Data_011_64B2 ; entry 186
    dw Data_011_64D6 ; entry 187
    dw Data_011_64FA ; entry 188
    dw Data_011_651E ; entry 189
    dw Data_011_6542 ; entry 190
    dw Data_011_6566 ; entry 191
    dw Data_011_658A ; entry 192
    dw Data_011_65AE ; entry 193
    dw Data_011_65D2 ; entry 194
    dw Data_011_65F6 ; entry 195
    dw Data_011_661A ; entry 196
    dw Data_011_500C ; entry 197
    dw $0000 ; entry 198
    dw $0000 ; entry 199
    dw Data_011_663E ; entry 200
    dw Data_011_665C ; entry 201
    dw Data_011_667A ; entry 202
    dw Data_011_667A ; entry 203
    dw Data_011_667A ; entry 204
    dw Data_011_667A ; entry 205
    dw Data_011_6698 ; entry 206
    dw $0000 ; entry 207
    dw Data_011_500C ; entry 208
    dw Data_011_66B6 ; entry 209
    dw Data_011_66D4 ; entry 210
    dw Data_011_66F2 ; entry 211
    dw Data_011_66F2 ; entry 212
    dw Data_011_66F2 ; entry 213
    dw Data_011_66F2 ; entry 214
    dw Data_011_6710 ; entry 215
    dw $0000 ; entry 216
    dw Data_011_500C ; entry 217
    dw Data_011_672E ; entry 218
    dw Data_011_674C ; entry 219
    dw Data_011_676A ; entry 220
    dw Data_011_676A ; entry 221
    dw Data_011_676A ; entry 222
    dw Data_011_676A ; entry 223
    dw Data_011_6788 ; entry 224
    dw $0000 ; entry 225
    dw Data_011_500C ; entry 226
    dw $0000 ; entry 227
    dw $0000 ; entry 228
    dw $0000 ; entry 229
    dw $0000 ; entry 230
    dw $0000 ; entry 231
    dw $0000 ; entry 232
    dw $0000 ; entry 233
    dw $0000 ; entry 234
    dw $0000 ; entry 235
    dw $0000 ; entry 236
    dw $0000 ; entry 237
    dw $0000 ; entry 238
    dw $0000 ; entry 239
    dw $0000 ; entry 240
    dw $0000 ; entry 241
    dw $0000 ; entry 242
    dw $0000 ; entry 243
    dw $0000 ; entry 244
    dw $0000 ; entry 245
    dw $0000 ; entry 246
    dw $0000 ; entry 247
    dw $0000 ; entry 248
    dw $0000 ; entry 249
    dw $0000 ; entry 250
    dw $0000 ; entry 251
    dw $0000 ; entry 252
    dw $0000 ; entry 253
    dw $0000 ; entry 254
    dw $0000 ; entry 255

Data_011_46B8:: ; heuristic: map record of the map table; C0
    INCBIN "dwm2-cobi-us.gbc", $0446B8, $42

Data_011_46FA:: ; heuristic: map record of the map table; C0
    db $0C, $57, $46, $41, $40, $48, $04, $03, $4F, $00, $01, $00, $00, $01, $0D, $00
    db $37, $CC
    dw Data_011_5C54
    db $46, $78, $5C, $46
    dw Data_011_5C54
    db $46, $78, $5C, $46
    dw Data_011_5C54
    db $46, $78, $5C, $46
    dw Data_011_5C9C
    db $46, $C0, $5C, $46
    dw Data_011_5CE4
    db $46, $08, $5D, $46
    dw Data_011_5D2C
    db $46, $50, $5D, $46
    dw Data_011_5D74
    db $46, $98, $5D, $46
    dw Data_011_5D74
    db $46, $98, $5D, $46

Data_011_473C:: ; heuristic: map record of the map table; C0
    dw Data_011_7025
    db $46, $81, $40, $48, $03, $01, $31, $00, $01, $00, $00, $01, $0D, $00, $37, $CC
    dw Data_011_7360
    db $46, $69, $73, $46
    dw Data_011_7372
    db $46, $7B, $73, $46
    dw Data_011_7372
    db $46, $7B, $73, $46
    dw Data_011_7384
    db $46, $8D, $73, $46
    dw Data_011_7396
    db $46, $9F, $73, $46
    dw Data_011_73A8
    db $46, $B1, $73, $46
    dw Data_011_73BA
    db $46, $C3, $73, $46
    dw Data_011_73BA
    db $46, $C3, $73, $46

Data_011_477E:: ; heuristic: map record of the map table; C0
    INCBIN "dwm2-cobi-us.gbc", $04477E, $42

Data_011_47C0:: ; heuristic: map record of the map table; C0
    INCBIN "dwm2-cobi-us.gbc", $0447C0, $42

Data_011_4802:: ; heuristic: map record of the map table; C0
    INCBIN "dwm2-cobi-us.gbc", $044802, $42

Data_011_4844:: ; heuristic: map record of the map table; C0
    INCBIN "dwm2-cobi-us.gbc", $044844, $42

Data_011_4886:: ; heuristic: map record of the map table; C0
    INCBIN "dwm2-cobi-us.gbc", $044886, $42

Data_011_48C8:: ; heuristic: map record of the map table; C0
    INCBIN "dwm2-cobi-us.gbc", $0448C8, $42

Data_011_490A:: ; heuristic: map record of the map table; C0
    INCBIN "dwm2-cobi-us.gbc", $04490A, $42

Data_011_494C:: ; heuristic: map record of the map table; C0
    INCBIN "dwm2-cobi-us.gbc", $04494C, $42

Data_011_498E:: ; heuristic: map record of the map table; C0
    INCBIN "dwm2-cobi-us.gbc", $04498E, $42

Data_011_49D0:: ; heuristic: map record of the map table; C0
    INCBIN "dwm2-cobi-us.gbc", $0449D0, $42

Data_011_4A12:: ; heuristic: map record of the map table; C0
    db $9A, $62, $47, $E2, $67, $47, $04, $02, $3F, $00, $0F, $00, $00, $00, $00, $00
    db $37, $CC
    dw Data_011_6822
    db $47, $3A, $68, $47
    dw Data_011_6822
    db $47, $3A, $68, $47
    dw Data_011_6822
    db $47, $3A, $68, $47
    dw Data_011_6822
    db $47, $3A, $68, $47
    dw Data_011_6852
    db $47, $6A, $68, $47
    dw Data_011_6852
    db $47, $6A, $68, $47
    dw Data_011_6852
    db $47, $6A, $68, $47
    dw Data_011_6882
    db $47, $9A, $68, $47

Data_011_4A54:: ; heuristic: map record of the map table; C0
    dw Data_011_6E1E
    db $47, $6B, $71, $47, $01, $01, $2F, $00, $00, $00, $00, $00, $00, $00, $37, $CC
    db $AB, $71, $47, $AE, $71, $47, $AB, $71, $47, $AE, $71, $47, $AB, $71, $47, $AE
    db $71, $47, $AB, $71, $47, $AE, $71, $47, $AB, $71, $47, $AE, $71, $47, $AB, $71
    db $47, $AE, $71, $47, $AB, $71, $47, $AE, $71, $47, $AB, $71, $47, $AE, $71, $47

Data_011_4A96:: ; heuristic: map record of the map table; C0
    INCBIN "dwm2-cobi-us.gbc", $044A96, $42

Data_011_4AD8:: ; heuristic: map record of the map table; C0
    INCBIN "dwm2-cobi-us.gbc", $044AD8, $42

Data_011_4B1A:: ; heuristic: map record of the map table; C0
    INCBIN "dwm2-cobi-us.gbc", $044B1A, $42

Data_011_4B5C:: ; heuristic: map record of the map table; C0
    INCBIN "dwm2-cobi-us.gbc", $044B5C, $42

Data_011_4B9E:: ; heuristic: map record of the map table; C0
    INCBIN "dwm2-cobi-us.gbc", $044B9E, $42

Data_011_4BE0:: ; heuristic: map record of the map table; C0
    INCBIN "dwm2-cobi-us.gbc", $044BE0, $42

Data_011_4C22:: ; heuristic: map record of the map table; C0
    INCBIN "dwm2-cobi-us.gbc", $044C22, $42

Data_011_4C64:: ; heuristic: map record of the map table; C0
    INCBIN "dwm2-cobi-us.gbc", $044C64, $42

Data_011_4CA6:: ; heuristic: map record of the map table; C0
    INCBIN "dwm2-cobi-us.gbc", $044CA6, $42

Data_011_4CE8:: ; heuristic: map record of the map table; C0
    INCBIN "dwm2-cobi-us.gbc", $044CE8, $42

Data_011_4D2A:: ; heuristic: map record of the map table; C0
    INCBIN "dwm2-cobi-us.gbc", $044D2A, $42

Data_011_4D6C:: ; heuristic: map record of the map table; C0
    INCBIN "dwm2-cobi-us.gbc", $044D6C, $42

Data_011_4DAE:: ; heuristic: map record of the map table; C0
    INCBIN "dwm2-cobi-us.gbc", $044DAE, $42

Data_011_4DF0:: ; heuristic: map record of the map table; C0
    db $75, $78, $90, $DE, $7C, $90, $01, $02, $00, $00, $01, $00, $00, $00, $00, $00
    db $37, $CC, $1E, $7D, $90, $24, $7D, $90, $1E, $7D, $90, $24, $7D, $90

Data_011_4E0E:: ; heuristic: map record of the map table; C0
    db $33, $72, $90, $9E, $75, $90, $02, $01, $37, $00, $0E, $00, $00, $00, $00, $00
    db $37, $CC, $DE, $75, $90, $E4, $75, $90, $DE, $75, $90, $E4, $75, $90

Data_011_4E2C:: ; heuristic: map record of the map table; C0
    db $01, $40, $4A, $A1, $42, $4A, $08, $08, $2B, $00, $00, $01, $00, $00, $00, $00
    db $38, $CC, $E1, $42, $4A, $A1, $43, $4A, $E1, $42, $4A, $A1, $43, $4A, $E1, $42
    db $4A, $A1, $43, $4A, $E1, $42, $4A, $A1, $43, $4A, $E1, $42, $4A, $A1, $43, $4A
    db $E1, $42, $4A, $A1, $43, $4A, $E1, $42, $4A, $A1, $43, $4A

Data_011_4E68:: ; heuristic: map record of the map table; C0
    db $0B, $70, $4A, $EB, $74, $4A, $02, $01, $4E, $00, $01, $00, $00, $00, $00, $00
    db $38, $CC, $2B, $75, $4A, $31, $75, $4A, $2B, $75, $4A, $31, $75, $4A, $2B, $75
    db $4A, $31, $75, $4A, $2B, $75, $4A, $31, $75, $4A, $2B, $75, $4A, $31, $75, $4A
    db $2B, $75, $4A, $31, $75, $4A, $2B, $75, $4A, $31, $75, $4A

Data_011_4EA4:: ; heuristic: map record of the map table; C0
    db $D2, $61, $49, $5C, $64, $49, $01, $01, $30, $00, $00, $00, $00, $00, $00, $00
    db $38, $CC, $9C, $64, $49, $9F, $64, $49, $9C, $64, $49, $9F, $64, $49, $9C, $64
    db $49, $9F, $64, $49, $9C, $64, $49, $9F, $64, $49, $9C, $64, $49, $9F, $64, $49
    db $9C, $64, $49, $9F, $64, $49, $9C, $64, $49, $9F, $64, $49

Data_011_4EE0:: ; heuristic: map record of the map table; C0
    db $E1, $65, $49, $85, $68, $49, $01, $01, $31, $00, $00, $00, $00, $00, $00, $00
    db $38, $CC, $C5, $68, $49, $C8, $68, $49, $C5, $68, $49, $C8, $68, $49, $C5, $68
    db $49, $C8, $68, $49, $C5, $68, $49, $C8, $68, $49, $C5, $68, $49, $C8, $68, $49
    db $C5, $68, $49, $C8, $68, $49, $C5, $68, $49, $C8, $68, $49

Data_011_4F1C:: ; heuristic: map record of the map table; C0
    db $E6, $69, $49, $06, $6F, $49, $02, $02, $48, $00, $00, $00, $00, $00, $00, $00
    db $38, $CC, $46, $6F, $49, $52, $6F, $49, $46, $6F, $49, $52, $6F, $49, $46, $6F
    db $49, $52, $6F, $49, $46, $6F, $49, $52, $6F, $49, $46, $6F, $49, $52, $6F, $49
    db $46, $6F, $49, $52, $6F, $49, $46, $6F, $49, $52, $6F, $49

Data_011_4F58:: ; heuristic: map record of the map table; C0
    db $14, $74, $49, $A6, $78, $49, $02, $01, $37, $00, $00, $00, $00, $00, $00, $00
    db $38, $CC, $E6, $78, $49, $EC, $78, $49, $E6, $78, $49, $EC, $78, $49, $E6, $78
    db $49, $EC, $78, $49, $E6, $78, $49, $EC, $78, $49, $E6, $78, $49, $EC, $78, $49
    db $E6, $78, $49, $EC, $78, $49, $E6, $78, $49, $EC, $78, $49

Data_011_4F94:: ; heuristic: map record of the map table; C0
    db $0F, $45, $90, $CF, $77, $4A, $01, $01, $58, $00, $06, $00, $00, $00, $00, $00
    db $38, $CC, $01, $40, $4B, $04, $40, $4B, $07, $40, $4B, $0A, $40, $4B, $07, $40
    db $4B, $0A, $40, $4B, $07, $40, $4B, $0A, $40, $4B, $07, $40, $4B, $0A, $40, $4B
    db $07, $40, $4B, $0A, $40, $4B, $07, $40, $4B, $0A, $40, $4B

Data_011_4FD0:: ; heuristic: map record of the map table; C0
    db $92, $42, $4B, $0F, $78, $4A, $01, $02, $2F, $00, $01, $00, $00, $00, $00, $00
    db $38, $CC, $FF, $45, $4B, $05, $46, $4B, $FF, $45, $4B, $05, $46, $4B, $FF, $45
    db $4B, $05, $46, $4B, $FF, $45, $4B, $05, $46, $4B, $FF, $45, $4B, $05, $46, $4B
    db $FF, $45, $4B, $05, $46, $4B, $FF, $45, $4B, $05, $46, $4B

Data_011_500C:: ; heuristic: map record of the map table; C0
    db $08, $4B, $90, $FE, $4E, $90, $01, $01, $32, $2C, $00, $00, $00, $00, $00, $00
    db $38, $CC, $3E, $4F, $90, $41, $4F, $90, $3E, $4F, $90, $41, $4F, $90, $3E, $4F
    db $90, $41, $4F, $90, $3E, $4F, $90, $41, $4F, $90, $3E, $4F, $90, $41, $4F, $90
    db $3E, $4F, $90, $41, $4F, $90, $3E, $4F, $90, $41, $4F, $90

Data_011_5048:: ; heuristic: map record of the map table; C0
    db $4F, $78, $4A, $19, $7B, $4A, $01, $01, $27, $00, $01, $00, $00, $01, $0F, $00
    db $38, $CC, $59, $7B, $4A, $5C, $7B, $4A, $59, $7B, $4A, $5C, $7B, $4A, $59, $7B
    db $4A, $5C, $7B, $4A, $59, $7B, $4A, $5C, $7B, $4A, $59, $7B, $4A, $5C, $7B, $4A
    db $59, $7B, $4A, $5C, $7B, $4A, $59, $7B, $4A, $5C, $7B, $4A

Data_011_5084:: ; heuristic: map record of the map table; C0
    db $DC, $48, $4B, $27, $4E, $4B, $04, $04, $4F, $00, $01, $02, $00, $01, $0D, $00
    db $38, $CC, $67, $4E, $4B, $97, $4E, $4B, $67, $4E, $4B, $97, $4E, $4B, $C7, $4E
    db $4B, $F7, $4E, $4B, $C7, $4E, $4B, $F7, $4E, $4B, $C7, $4E, $4B, $F7, $4E, $4B
    db $C7, $4E, $4B, $F7, $4E, $4B, $C7, $4E, $4B, $F7, $4E, $4B

Data_011_50C0:: ; heuristic: map record of the map table; C0
    db $7F, $7B, $49, $6E, $7E, $49, $01, $01, $21, $00, $00, $00, $00, $00, $00, $00
    db $38, $CC, $AE, $7E, $49, $B1, $7E, $49, $AE, $7E, $49, $B1, $7E, $49, $AE, $7E
    db $49, $B1, $7E, $49, $AE, $7E, $49, $B1, $7E, $49, $AE, $7E, $49, $B1, $7E, $49
    db $AE, $7E, $49, $B1, $7E, $49, $AE, $7E, $49, $B1, $7E, $49

Data_011_50FC:: ; heuristic: map record of the map table; C0
    db $14, $74, $49, $A6, $78, $49, $01, $01, $37, $00, $00, $00, $00, $00, $00, $00
    db $38, $CC, $C1, $5E, $4B, $C4, $5E, $4B, $C1, $5E, $4B, $C4, $5E, $4B, $C1, $5E
    db $4B, $C4, $5E, $4B, $C7, $5E, $4B, $CA, $5E, $4B, $C7, $5E, $4B, $CA, $5E, $4B
    db $C7, $5E, $4B, $CA, $5E, $4B, $C1, $5E, $4B, $C4, $5E, $4B

Data_011_5138:: ; heuristic: map record of the map table; C0
    db $3D, $53, $93, $60, $57, $93, $02, $02, $37, $00, $01, $00, $00, $01, $09, $00
    db $38, $CC, $A0, $57, $93, $AC, $57, $93, $A0, $57, $93, $AC, $57, $93, $A0, $57
    db $93, $AC, $57, $93, $A0, $57, $93, $AC, $57, $93, $B8, $57, $93, $C4, $57, $93
    db $D0, $57, $93, $DC, $57, $93, $D0, $57, $93, $DC, $57, $93

Data_011_5174:: ; heuristic: map record of the map table; C0
    db $01, $40, $5F, $6E, $44, $5F, $08, $08, $3D, $00, $01, $03, $00, $01, $27, $00
    db $39, $CC, $01, $40, $56, $C1, $40, $56, $01, $40, $56, $C1, $40, $56, $81, $41
    db $56, $41, $42, $56, $81, $41, $56, $41, $42, $56, $81, $41, $56, $41, $42, $56

Data_011_51A4:: ; heuristic: map record of the map table; C0
    db $AE, $44, $5F, $C0, $49, $5F, $01, $02, $3F, $00, $01, $00, $00, $00, $00, $00
    db $39, $CC, $00, $4A, $5F, $06, $4A, $5F, $00, $4A, $5F, $06, $4A, $5F, $00, $4A
    db $5F, $06, $4A, $5F, $00, $4A, $5F, $06, $4A, $5F, $00, $4A, $5F, $06, $4A, $5F

Data_011_51D4:: ; heuristic: map record of the map table; C0
    db $D6, $62, $93, $01, $40, $58, $02, $02, $4B, $00, $01, $00, $00, $00, $00, $00
    db $39, $CC, $01, $40, $57, $0D, $40, $57, $01, $40, $57, $0D, $40, $57, $19, $40
    db $57, $25, $40, $57, $19, $40, $57, $25, $40, $57, $19, $40, $57, $25, $40, $57

Data_011_5204:: ; heuristic: map record of the map table; C0
    db $A2, $48, $57, $41, $40, $58, $01, $02, $3F, $00, $00, $00, $00, $00, $00, $00
    db $39, $CC, $7B, $4B, $57, $81, $4B, $57, $7B, $4B, $57, $81, $4B, $57, $7B, $4B
    db $57, $81, $4B, $57, $7B, $4B, $57, $81, $4B, $57, $7B, $4B, $57, $81, $4B, $57

Data_011_5234:: ; heuristic: map record of the map table; C0
    db $04, $4D, $57, $81, $40, $58, $01, $01, $2A, $00, $00, $00, $00, $00, $00, $00
    db $39, $CC, $B6, $4F, $57, $B9, $4F, $57, $B6, $4F, $57, $B9, $4F, $57, $B6, $4F
    db $57, $B9, $4F, $57, $B6, $4F, $57, $B9, $4F, $57, $B6, $4F, $57, $B9, $4F, $57

Data_011_5264:: ; heuristic: map record of the map table; C0
    db $C7, $50, $57, $C1, $40, $58, $04, $04, $29, $00, $01, $04, $00, $01, $0F, $00
    db $39, $CC, $AA, $53, $57, $DA, $53, $57, $AA, $53, $57, $DA, $53, $57, $AA, $53
    db $57, $DA, $53, $57, $AA, $53, $57, $DA, $53, $57, $AA, $53, $57, $DA, $53, $57

Data_011_5294:: ; heuristic: map record of the map table; C0
    db $83, $4C, $5F, $01, $41, $58, $01, $01, $23, $00, $01, $00, $00, $01, $09, $00
    db $39, $CC, $0C, $4E, $5F, $0F, $4E, $5F, $0C, $4E, $5F, $0F, $4E, $5F, $0C, $4E
    db $5F, $0F, $4E, $5F, $0C, $4E, $5F, $0F, $4E, $5F, $0C, $4E, $5F, $0F, $4E, $5F

Data_011_52C4:: ; heuristic: map record of the map table; C0
    db $7D, $65, $57, $41, $41, $58, $03, $01, $4F, $00, $01, $07, $00, $01, $0D, $00
    db $39, $CC, $0B, $6A, $57, $14, $6A, $57, $0B, $6A, $57, $14, $6A, $57, $0B, $6A
    db $57, $14, $6A, $57, $0B, $6A, $57, $14, $6A, $57, $0B, $6A, $57, $14, $6A, $57

Data_011_52F4:: ; heuristic: map record of the map table; C0
    db $96, $6E, $57, $26, $71, $57, $04, $04, $3F, $00, $00, $05, $00, $00, $01, $00
    db $39, $CC, $66, $71, $57, $96, $71, $57, $66, $71, $57, $96, $71, $57, $66, $71
    db $57, $96, $71, $57, $66, $71, $57, $96, $71, $57, $66, $71, $57, $96, $71, $57

Data_011_5324:: ; heuristic: map record of the map table; C0
    db $96, $6E, $57, $26, $71, $57, $04, $03, $3F, $00, $00, $05, $00, $02, $01, $00
    db $39, $CC, $BD, $60, $4B, $E1, $60, $4B, $BD, $60, $4B, $E1, $60, $4B, $BD, $60
    db $4B, $E1, $60, $4B, $05, $61, $4B, $29, $61, $4B, $05, $61, $4B, $29, $61, $4B

Data_011_5354:: ; heuristic: map record of the map table; C0
    db $96, $6E, $57, $26, $71, $57, $03, $03, $3F, $00, $00, $05, $06, $02, $01, $00
    db $39, $CC, $4C, $6C, $4B, $67, $6C, $4B, $4C, $6C, $4B, $67, $6C, $4B, $4C, $6C
    db $4B, $67, $6C, $4B, $4C, $6C, $4B, $67, $6C, $4B, $4C, $6C, $4B, $67, $6C, $4B

Data_011_5384:: ; heuristic: map record of the map table; C0
    db $3C, $4F, $5F, $DD, $52, $5F, $01, $01, $37, $2C, $00, $00, $00, $02, $01, $00
    db $39, $CC, $1D, $53, $5F, $20, $53, $5F, $1D, $53, $5F, $20, $53, $5F, $1D, $53
    db $5F, $20, $53, $5F, $1D, $53, $5F, $20, $53, $5F, $23, $53, $5F, $26, $53, $5F

Data_011_53B4:: ; heuristic: map record of the map table; C0
    db $D4, $54, $5F, $28, $59, $5F, $03, $01, $3F, $00, $01, $00, $00, $00, $00, $00
    db $39, $CC, $68, $59, $5F, $71, $59, $5F, $68, $59, $5F, $71, $59, $5F, $68, $59
    db $5F, $71, $59, $5F, $68, $59, $5F, $71, $59, $5F, $68, $59, $5F, $71, $59, $5F

Data_011_53E4:: ; heuristic: map record of the map table; C0
    db $D7, $50, $90, $7B, $53, $90, $01, $01, $2A, $00, $00, $00, $00, $00, $00, $00
    db $39, $CC, $BB, $53, $90, $BE, $53, $90, $BB, $53, $90, $BE, $53, $90, $BB, $53
    db $90, $BE, $53, $90, $BB, $53, $90, $BE, $53, $90, $BB, $53, $90, $BE, $53, $90

Data_011_5414:: ; heuristic: map record of the map table; C0
    db $DE, $68, $93, $D8, $6B, $93, $02, $02, $2F, $00, $01, $06, $00, $01, $0E, $00
    db $39, $CC, $18, $6C, $93, $24, $6C, $93, $18, $6C, $93, $24, $6C, $93, $18, $6C
    db $93, $24, $6C, $93, $18, $6C, $93, $24, $6C, $93, $18, $6C, $93, $24, $6C, $93

Data_011_5444:: ; heuristic: map record of the map table; C0
    db $DE, $68, $93, $D8, $6B, $93, $02, $02, $2F, $00, $01, $06, $00, $01, $0E, $00
    db $39, $CC, $31, $71, $93, $3D, $71, $93, $31, $71, $93, $3D, $71, $93, $31, $71
    db $93, $3D, $71, $93, $31, $71, $93, $3D, $71, $93, $31, $71, $93, $3D, $71, $93

Data_011_5474:: ; heuristic: map record of the map table; C0
    db $81, $41, $58, $A7, $45, $58, $01, $02, $3F, $00, $01, $00, $00, $00, $00, $00
    db $39, $CC, $E7, $45, $58, $ED, $45, $58, $E7, $45, $58, $ED, $45, $58, $F3, $45
    db $58, $F9, $45, $58, $F3, $45, $58, $F9, $45, $58, $F3, $45, $58, $F9, $45, $58

Data_011_54A4:: ; heuristic: map record of the map table; C0
    db $81, $4E, $58, $E4, $53, $58, $01, $02, $3B, $00, $01, $00, $00, $00, $00, $00
    db $39, $CC, $24, $54, $58, $2A, $54, $58, $24, $54, $58, $2A, $54, $58, $24, $54
    db $58, $2A, $54, $58, $24, $54, $58, $2A, $54, $58, $24, $54, $58, $2A, $54, $58

Data_011_54D4:: ; heuristic: map record of the map table; C0
    db $7D, $65, $57, $41, $41, $58, $03, $01, $4F, $00, $01, $08, $00, $02, $10, $00
    db $39, $CC, $85, $57, $58, $8E, $57, $58, $85, $57, $58, $8E, $57, $58, $85, $57
    db $58, $8E, $57, $58, $85, $57, $58, $8E, $57, $58, $85, $57, $58, $8E, $57, $58

Data_011_5504:: ; heuristic: map record of the map table; C0
    db $99, $5D, $5F, $A4, $62, $5F, $03, $01, $4F, $00, $0D, $08, $00, $02, $02, $00
    db $39, $CC, $E4, $62, $5F, $ED, $62, $5F, $F6, $62, $5F, $FF, $62, $5F, $F6, $62
    db $5F, $FF, $62, $5F, $F6, $62, $5F, $FF, $62, $5F, $F6, $62, $5F, $FF, $62, $5F

Data_011_5534:: ; heuristic: map record of the map table; C0
    db $68, $5B, $58, $F4, $5F, $58, $01, $01, $4F, $00, $00, $00, $00, $00, $00, $00
    db $39, $CC, $34, $60, $58, $37, $60, $58, $34, $60, $58, $37, $60, $58, $34, $60
    db $58, $37, $60, $58, $34, $60, $58, $37, $60, $58, $34, $60, $58, $37, $60, $58

Data_011_5564:: ; heuristic: map record of the map table; C0
    db $01, $40, $4C, $7D, $45, $4C, $0C, $0C, $2B, $00, $01, $09, $00, $01, $27, $00
    db $3A, $CC, $BD, $45, $4C, $01, $40, $4D, $BD, $45, $4C, $01, $40, $4D, $6D, $47
    db $4C, $B1, $41, $4D

Data_011_5588:: ; heuristic: map record of the map table; C0
    db $2A, $5F, $5E, $6D, $62, $5E, $01, $01, $2B, $00, $01, $00, $00, $01, $0A, $00
    db $3A, $CC, $B3, $62, $5E, $B6, $62, $5E, $B3, $62, $5E, $B6, $62, $5E, $AD, $62
    db $5E, $B0, $62, $5E

Data_011_55AC:: ; heuristic: map record of the map table; C0
    db $45, $61, $4D, $09, $65, $5E, $02, $02, $4C, $00, $00, $00, $00, $00, $00, $00
    db $3A, $CC, $CC, $66, $4D, $D8, $66, $4D, $CC, $66, $4D, $D8, $66, $4D, $CC, $66
    db $4D, $D8, $66, $4D

Data_011_55D0:: ; heuristic: map record of the map table; C0
    db $D9, $54, $90, $92, $57, $90, $01, $01, $2B, $00, $00, $00, $00, $00, $00, $00
    db $3A, $CC, $D2, $57, $90, $D5, $57, $90, $D2, $57, $90, $D5, $57, $90, $D2, $57
    db $90, $D5, $57, $90

Data_011_55F4:: ; heuristic: map record of the map table; C0
    db $2B, $6C, $4D, $01, $40, $5B, $02, $02, $46, $00, $00, $00, $00, $00, $00, $00
    db $3A, $CC, $36, $72, $4D, $42, $72, $4D, $36, $72, $4D, $42, $72, $4D, $36, $72
    db $4D, $42, $72, $4D

Data_011_5618:: ; heuristic: map record of the map table; C0
    db $5A, $77, $4D, $2E, $7A, $4D, $01, $02, $17, $00, $00, $00, $00, $00, $00, $00
    db $3A, $CC, $6E, $7A, $4D, $74, $7A, $4D, $7A, $7A, $4D, $80, $7A, $4D, $7A, $7A
    db $4D, $80, $7A, $4D

Data_011_563C:: ; heuristic: map record of the map table; C0
    db $01, $40, $95, $A5, $7E, $4D, $01, $03, $2F, $00, $09, $00, $00, $00, $00, $00
    db $3A, $CC, $02, $42, $95, $0B, $42, $95, $02, $42, $95, $0B, $42, $95, $02, $42
    db $95, $0B, $42, $95

Data_011_5660:: ; heuristic: map record of the map table; C0
    db $01, $40, $4E, $E5, $7E, $4D, $02, $02, $57, $00, $01, $00, $00, $00, $00, $00
    db $3A, $CC, $D3, $45, $4E, $DF, $45, $4E, $D3, $45, $4E, $DF, $45, $4E, $EB, $45
    db $4E, $F7, $45, $4E

Data_011_5684:: ; heuristic: map record of the map table; C0
    db $DB, $4C, $4E, $25, $7F, $4D, $01, $01, $3F, $00, $00, $00, $00, $00, $00, $00
    db $3A, $CC, $79, $51, $4E, $7C, $51, $4E, $79, $51, $4E, $7C, $51, $4E, $79, $51
    db $4E, $7C, $51, $4E

Data_011_56A8:: ; heuristic: map record of the map table; C0
    db $DB, $4C, $4E, $25, $7F, $4D, $01, $01, $3F, $00, $00, $00, $00, $00, $00, $00
    db $3A, $CC, $7F, $51, $4E, $82, $51, $4E, $7F, $51, $4E, $82, $51, $4E, $7F, $51
    db $4E, $82, $51, $4E

Data_011_56CC:: ; heuristic: map record of the map table; C0
    db $78, $53, $4E, $65, $7F, $4D, $03, $02, $2F, $00, $00, $00, $00, $00, $00, $00
    db $3A, $CC, $A3, $56, $4E, $B5, $56, $4E, $A3, $56, $4E, $B5, $56, $4E, $A3, $56
    db $4E, $B5, $56, $4E

Data_011_56F0:: ; heuristic: map record of the map table; C0
    db $E2, $5B, $4E, $41, $40, $5B, $04, $04, $33, $00, $00, $0A, $00, $10, $30, $00
    db $3A, $CC, $31, $60, $4E, $61, $60, $4E, $31, $60, $4E, $61, $60, $4E, $31, $60
    db $4E, $61, $60, $4E

Data_011_5714:: ; heuristic: map record of the map table; C0
    db $E2, $5B, $4E, $41, $40, $5B, $01, $01, $33, $00, $00, $0B, $00, $10, $30, $00
    db $3A, $CC, $D8, $62, $66, $DB, $62, $66, $D8, $62, $66, $DB, $62, $66, $D8, $62
    db $66, $DB, $62, $66

Data_011_5738:: ; heuristic: map record of the map table; C0
    db $E2, $5B, $4E, $41, $40, $5B, $02, $01, $33, $00, $00, $0B, $00, $10, $30, $00
    db $3A, $CC, $81, $40, $5B, $87, $40, $5B, $81, $40, $5B, $87, $40, $5B, $81, $40
    db $5B, $87, $40, $5B

Data_011_575C:: ; heuristic: map record of the map table; C0
    db $E2, $5B, $4E, $41, $40, $5B, $01, $03, $33, $00, $00, $0B, $00, $10, $30, $00
    db $3A, $CC, $20, $71, $4E, $29, $71, $4E, $20, $71, $4E, $29, $71, $4E, $20, $71
    db $4E, $29, $71, $4E

Data_011_5780:: ; heuristic: map record of the map table; C0
    db $87, $74, $4E, $C8, $79, $4E, $03, $01, $3F, $00, $00, $00, $00, $10, $2C, $00
    db $3A, $CC, $08, $7A, $4E, $11, $7A, $4E, $08, $7A, $4E, $11, $7A, $4E, $08, $7A
    db $4E, $11, $7A, $4E

Data_011_57A4:: ; heuristic: map record of the map table; C0
    db $49, $65, $5E, $03, $6B, $5E, $02, $02, $57, $00, $01, $00, $00, $00, $00, $00
    db $3A, $CC, $43, $6B, $5E, $4F, $6B, $5E, $43, $6B, $5E, $4F, $6B, $5E, $43, $6B
    db $5E, $4F, $6B, $5E

Data_011_57C8:: ; heuristic: map record of the map table; C0
    db $26, $70, $5E, $AE, $74, $5E, $02, $01, $3F, $00, $00, $00, $00, $00, $00, $00
    db $3A, $CC, $EE, $74, $5E, $F4, $74, $5E, $EE, $74, $5E, $F4, $74, $5E, $EE, $74
    db $5E, $F4, $74, $5E

Data_011_57EC:: ; heuristic: map record of the map table; C0
    db $01, $40, $4F, $8C, $43, $4F, $02, $01, $21, $00, $00, $00, $00, $00, $00, $00
    db $3A, $CC, $CC, $43, $4F, $D2, $43, $4F, $CC, $43, $4F, $D2, $43, $4F, $CC, $43
    db $4F, $D2, $43, $4F

Data_011_5810:: ; heuristic: map record of the map table; C0
    db $42, $46, $4F, $07, $4C, $4F, $02, $02, $43, $00, $00, $00, $00, $00, $00, $00
    db $3A, $CC, $47, $4C, $4F, $53, $4C, $4F, $47, $4C, $4F, $53, $4C, $4F, $47, $4C
    db $4F, $53, $4C, $4F

Data_011_5834:: ; heuristic: map record of the map table; C0
    db $3F, $51, $4F, $3D, $55, $4F, $01, $02, $33, $00, $00, $00, $00, $00, $00, $00
    db $3A, $CC, $7D, $55, $4F, $83, $55, $4F, $7D, $55, $4F, $83, $55, $4F, $7D, $55
    db $4F, $83, $55, $4F

Data_011_5858:: ; heuristic: map record of the map table; C0
    db $87, $57, $4F, $4D, $59, $4F, $04, $04, $11, $00, $00, $0C, $00, $00, $00, $00
    db $3A, $CC, $8D, $59, $4F, $BD, $59, $4F, $8D, $59, $4F, $BD, $59, $4F, $8D, $59
    db $4F, $BD, $59, $4F

Data_011_587C:: ; heuristic: map record of the map table; C0
    db $1A, $66, $4F, $F7, $6B, $4F, $02, $02, $4B, $00, $01, $00, $00, $00, $00, $00
    db $3A, $CC, $37, $6C, $4F, $43, $6C, $4F, $37, $6C, $4F, $43, $6C, $4F, $37, $6C
    db $4F, $43, $6C, $4F

Data_011_58A0:: ; heuristic: map record of the map table; C0
    db $87, $76, $5E, $1F, $79, $5E, $01, $01, $1F, $00, $00, $00, $00, $00, $00, $00
    db $3A, $CC, $5F, $79, $5E, $62, $79, $5E, $5F, $79, $5E, $62, $79, $5E, $5F, $79
    db $5E, $62, $79, $5E

Data_011_58C4:: ; heuristic: map record of the map table; C0
    db $6D, $71, $4F, $9A, $76, $4F, $01, $03, $31, $00, $00, $00, $00, $00, $00, $00
    db $3A, $CC, $DA, $76, $4F, $E3, $76, $4F, $DA, $76, $4F, $E3, $76, $4F, $DA, $76
    db $4F, $E3, $76, $4F

Data_011_58E8:: ; heuristic: map record of the map table; C0
    db $94, $7A, $4F, $D4, $7E, $4F, $01, $02, $33, $00, $00, $00, $00, $00, $00, $00
    db $3A, $CC, $71, $7A, $5E, $77, $7A, $5E, $71, $7A, $5E, $77, $7A, $5E, $71, $7A
    db $5E, $77, $7A, $5E

Data_011_590C:: ; heuristic: map record of the map table; C0
    db $02, $64, $66, $82, $68, $66, $02, $04, $32, $00, $00, $0D, $00, $00, $00, $00
    db $3A, $CC, $C2, $68, $66, $DA, $68, $66, $C2, $68, $66, $DA, $68, $66, $C2, $68
    db $66, $DA, $68, $66

Data_011_5930:: ; heuristic: map record of the map table; C0
    db $5F, $71, $66, $B7, $74, $66, $02, $02, $33, $00, $00, $0E, $07, $02, $01, $00
    db $3A, $CC, $F7, $74, $66, $03, $75, $66, $F7, $74, $66, $03, $75, $66, $F7, $74
    db $66, $03, $75, $66

Data_011_5954:: ; heuristic: map record of the map table; C0
    db $5F, $71, $66, $B7, $74, $66, $02, $02, $33, $00, $00, $0E, $07, $02, $01, $00
    db $3A, $CC, $71, $78, $66, $7D, $78, $66, $71, $78, $66, $7D, $78, $66, $71, $78
    db $66, $7D, $78, $66

Data_011_5978:: ; heuristic: map record of the map table; C0
    db $5F, $71, $66, $B7, $74, $66, $02, $02, $33, $00, $00, $0E, $07, $02, $01, $00
    db $3A, $CC, $EA, $7B, $66, $F6, $7B, $66, $EA, $7B, $66, $F6, $7B, $66, $EA, $7B
    db $66, $F6, $7B, $66

Data_011_599C:: ; heuristic: map record of the map table; C0
    db $5F, $71, $66, $B7, $74, $66, $02, $02, $33, $00, $00, $0F, $07, $02, $01, $00
    db $3A, $CC, $73, $42, $5B, $7F, $42, $5B, $73, $42, $5B, $7F, $42, $5B, $73, $42
    db $5B, $7F, $42, $5B

Data_011_59C0:: ; heuristic: map record of the map table; C0
    INCBIN "dwm2-cobi-us.gbc", $0459C0, $48

Data_011_5A08:: ; heuristic: map record of the map table; C0
    db $91, $4C, $51, $01, $40, $50, $0C, $0C, $2D, $00, $00, $10, $00, $02, $29, $00
    db $3B, $CC, $41, $40, $50, $66, $52, $51, $41, $40, $50, $66, $52, $51, $41, $40
    db $50, $66, $52, $51, $41, $40, $50, $66, $52, $51, $41, $40, $50, $66, $52, $51

Data_011_5A38:: ; heuristic: map record of the map table; C0
    db $68, $6C, $51, $56, $70, $51, $03, $01, $31, $00, $00, $00, $00, $00, $00, $00
    db $3B, $CC, $96, $70, $51, $9F, $70, $51, $96, $70, $51, $9F, $70, $51, $96, $70
    db $51, $9F, $70, $51, $96, $70, $51, $9F, $70, $51, $96, $70, $51, $9F, $70, $51

Data_011_5A68:: ; heuristic: map record of the map table; C0
    db $89, $74, $51, $BD, $76, $51, $01, $01, $23, $00, $00, $00, $00, $00, $00, $00
    db $3B, $CC, $FD, $76, $51, $00, $77, $51, $FD, $76, $51, $00, $77, $51, $FD, $76
    db $51, $00, $77, $51, $FD, $76, $51, $00, $77, $51, $FD, $76, $51, $00, $77, $51

Data_011_5A98:: ; heuristic: map record of the map table; C0
    db $01, $40, $52, $43, $45, $52, $02, $02, $4F, $00, $00, $11, $00, $00, $00, $00
    db $3B, $CC, $83, $45, $52, $8F, $45, $52, $83, $45, $52, $8F, $45, $52, $83, $45
    db $52, $8F, $45, $52, $83, $45, $52, $8F, $45, $52, $83, $45, $52, $8F, $45, $52

Data_011_5AC8:: ; heuristic: map record of the map table; C0
    db $01, $40, $52, $43, $45, $52, $02, $02, $4F, $00, $00, $11, $00, $00, $00, $00
    db $3B, $CC, $C7, $49, $52, $D3, $49, $52, $C7, $49, $52, $D3, $49, $52, $C7, $49
    db $52, $D3, $49, $52, $C7, $49, $52, $D3, $49, $52, $C7, $49, $52, $D3, $49, $52

Data_011_5AF8:: ; heuristic: map record of the map table; C0
    db $01, $40, $52, $43, $45, $52, $02, $02, $4F, $00, $00, $11, $00, $00, $00, $00
    db $3B, $CC, $BE, $4D, $52, $CA, $4D, $52, $BE, $4D, $52, $CA, $4D, $52, $BE, $4D
    db $52, $CA, $4D, $52, $BE, $4D, $52, $CA, $4D, $52, $BE, $4D, $52, $CA, $4D, $52

Data_011_5B28:: ; heuristic: map record of the map table; C0
    db $01, $40, $52, $43, $45, $52, $02, $02, $4F, $00, $00, $11, $00, $00, $00, $00
    db $3B, $CC, $08, $52, $52, $14, $52, $52, $08, $52, $52, $14, $52, $52, $08, $52
    db $52, $14, $52, $52, $08, $52, $52, $14, $52, $52, $08, $52, $52, $14, $52, $52

Data_011_5B58:: ; heuristic: map record of the map table; C0
    db $A0, $56, $52, $B3, $5B, $52, $03, $01, $3F, $00, $00, $00, $00, $00, $00, $00
    db $3B, $CC, $F3, $5B, $52, $FC, $5B, $52, $F3, $5B, $52, $FC, $5B, $52, $F3, $5B
    db $52, $FC, $5B, $52, $F3, $5B, $52, $FC, $5B, $52, $F3, $5B, $52, $FC, $5B, $52

Data_011_5B88:: ; heuristic: map record of the map table; C0
    db $B2, $5F, $52, $10, $65, $52, $02, $02, $3D, $00, $00, $00, $00, $00, $00, $00
    db $3B, $CC, $50, $65, $52, $5C, $65, $52, $50, $65, $52, $5C, $65, $52, $50, $65
    db $52, $5C, $65, $52, $50, $65, $52, $5C, $65, $52, $50, $65, $52, $5C, $65, $52

Data_011_5BB8:: ; heuristic: map record of the map table; C0
    db $91, $6B, $52, $E3, $6F, $52, $01, $02, $45, $00, $00, $00, $00, $00, $00, $00
    db $3B, $CC, $23, $70, $52, $29, $70, $52, $23, $70, $52, $29, $70, $52, $23, $70
    db $52, $29, $70, $52, $23, $70, $52, $29, $70, $52, $23, $70, $52, $29, $70, $52

Data_011_5BE8:: ; heuristic: map record of the map table; C0
    db $84, $72, $52, $A5, $78, $52, $01, $02, $4B, $00, $00, $00, $00, $00, $00, $00
    db $3B, $CC, $E5, $78, $52, $EB, $78, $52, $E5, $78, $52, $EB, $78, $52, $E5, $78
    db $52, $EB, $78, $52, $E5, $78, $52, $EB, $78, $52, $E5, $78, $52, $EB, $78, $52

Data_011_5C18:: ; heuristic: map record of the map table; C0
    db $01, $40, $53, $CE, $42, $53, $01, $03, $1F, $00, $00, $00, $00, $00, $00, $00
    db $3B, $CC, $0E, $43, $53, $17, $43, $53, $0E, $43, $53, $17, $43, $53, $0E, $43
    db $53, $17, $43, $53, $0E, $43, $53, $17, $43, $53, $0E, $43, $53, $17, $43, $53

Data_011_5C48:: ; heuristic: map record of the map table; C0
    db $AF, $45, $53, $9A, $4B, $53, $02, $02, $45, $00, $00, $00

Data_011_5C54:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $3B, $CC, $DA, $4B, $53, $E6, $4B, $53, $DA, $4B, $53, $E6
    db $4B, $53, $DA, $4B, $53, $E6, $4B, $53, $DA, $4B, $53, $E6, $4B, $53, $DA, $4B
    db $53, $E6, $4B, $53

Data_011_5C78:: ; heuristic: map record of the map table; C0
    db $69, $52, $53, $C1, $56, $53, $01, $01, $3B, $00, $00, $00, $00, $00, $00, $00
    db $3B, $CC, $01, $57, $53, $04, $57, $53, $01, $57, $53, $04, $57, $53, $01, $57
    db $53, $04, $57, $53

Data_011_5C9C:: ; heuristic: target of a monotone pointer table; C0
    db $01, $57, $53, $04, $57, $53, $01, $57, $53, $04, $57, $53

Data_011_5CA8:: ; heuristic: map record of the map table; C0
    db $69, $52, $53, $C1, $56, $53, $01, $01, $3B, $00, $00, $00, $00, $00, $00, $00
    db $3B, $CC, $0B, $58, $53, $0E, $58, $53, $0B, $58, $53, $0E, $58, $53, $0B, $58
    db $53, $0E, $58, $53, $0B, $58, $53, $0E, $58, $53, $0B, $58, $53, $0E, $58, $53

Data_011_5CD8:: ; heuristic: map record of the map table; C0
    db $FF, $58, $53, $E8, $5C, $53, $01, $02, $2F, $00, $00, $00

Data_011_5CE4:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $3B, $CC, $28, $5D, $53, $2E, $5D, $53, $28, $5D, $53, $2E
    db $5D, $53, $28, $5D, $53, $2E, $5D, $53, $28, $5D, $53, $2E, $5D, $53, $28, $5D
    db $53, $2E, $5D, $53

Data_011_5D08:: ; heuristic: map record of the map table; C0
    db $E9, $5F, $53, $FB, $64, $53, $03, $01, $3F, $00, $00, $00, $00, $00, $00, $00
    db $3B, $CC, $3B, $65, $53, $44, $65, $53, $3B, $65, $53, $44, $65, $53, $3B, $65
    db $53, $44, $65, $53

Data_011_5D2C:: ; heuristic: target of a monotone pointer table; C0
    db $3B, $65, $53, $44, $65, $53, $3B, $65, $53, $44, $65, $53

Data_011_5D38:: ; heuristic: map record of the map table; C0
    db $01, $40, $54, $2C, $43, $54, $01, $01, $2F, $00, $00, $12, $00, $00, $00, $00
    db $3B, $CC, $6C, $43, $54, $6F, $43, $54, $6C, $43, $54, $6F, $43, $54, $6C, $43
    db $54, $6F, $43, $54, $6C, $43, $54, $6F, $43, $54, $6C, $43, $54, $6F, $43, $54

Data_011_5D68:: ; heuristic: map record of the map table; C0
    db $01, $40, $54, $2C, $43, $54, $03, $03, $2F, $00, $00, $13

Data_011_5D74:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $3B, $CC, $63, $44, $54, $7E, $44, $54, $63, $44, $54, $7E
    db $44, $54, $63, $44, $54, $7E, $44, $54, $63, $44, $54, $7E, $44, $54, $63, $44
    db $54, $7E, $44, $54

Data_011_5D98:: ; heuristic: map record of the map table; C0
    db $01, $40, $54, $2C, $43, $54, $03, $03, $2F, $00, $00, $13, $00, $00, $00, $00
    db $3B, $CC, $C7, $4E, $54, $E2, $4E, $54, $C7, $4E, $54, $E2, $4E, $54, $C7, $4E
    db $54, $E2, $4E, $54, $C7, $4E, $54, $E2, $4E, $54, $C7, $4E, $54, $E2, $4E, $54

Data_011_5DC8:: ; heuristic: map record of the map table; C0
    db $01, $40, $54, $2C, $43, $54, $01, $01, $2F, $00, $00, $00, $00, $00, $00, $00
    db $3B, $CC, $1A, $57, $54, $1D, $57, $54, $1A, $57, $54, $1D, $57, $54, $1A, $57
    db $54, $1D, $57, $54, $1A, $57, $54, $1D, $57, $54, $1A, $57, $54, $1D, $57, $54

Data_011_5DF8:: ; heuristic: map record of the map table; C0
    db $56, $58, $54, $25, $5D, $54, $02, $02, $3F, $00, $00, $14, $00, $02, $01, $00
    db $3B, $CC, $65, $5D, $54, $71, $5D, $54, $65, $5D, $54, $71, $5D, $54, $65, $5D
    db $54, $71, $5D, $54, $65, $5D, $54, $71, $5D, $54, $65, $5D, $54, $71, $5D, $54

Data_011_5E28:: ; heuristic: map record of the map table; C0
    db $56, $58, $54, $25, $5D, $54, $02, $02, $2F, $00, $00, $14, $00, $02, $01, $00
    db $3B, $CC, $63, $62, $54, $6F, $62, $54, $63, $62, $54, $6F, $62, $54, $63, $62
    db $54, $6F, $62, $54, $63, $62, $54, $6F, $62, $54, $63, $62, $54, $6F, $62, $54

Data_011_5E58:: ; heuristic: map record of the map table; C0
    db $56, $58, $54, $25, $5D, $54, $02, $02, $2F, $00, $00, $14, $00, $02, $01, $00
    db $3B, $CC, $73, $67, $54, $7F, $67, $54, $73, $67, $54, $7F, $67, $54, $73, $67
    db $54, $7F, $67, $54, $73, $67, $54, $7F, $67, $54, $73, $67, $54, $7F, $67, $54

Data_011_5E88:: ; heuristic: map record of the map table; C0
    db $56, $58, $54, $25, $5D, $54, $02, $02, $2F, $00, $00, $14, $00, $02, $01, $00
    db $3B, $CC, $6F, $6C, $54, $7B, $6C, $54, $6F, $6C, $54, $7B, $6C, $54, $6F, $6C
    db $54, $7B, $6C, $54, $6F, $6C, $54, $7B, $6C, $54, $6F, $6C, $54, $7B, $6C, $54

Data_011_5EB8:: ; heuristic: map record of the map table; C0
    db $1C, $69, $53, $2C, $6F, $53, $02, $02, $48, $00, $00, $00, $00, $00, $00, $00
    db $3B, $CC, $6C, $6F, $53, $78, $6F, $53, $6C, $6F, $53, $78, $6F, $53, $6C, $6F
    db $53, $78, $6F, $53, $6C, $6F, $53, $78, $6F, $53, $6C, $6F, $53, $78, $6F, $53

Data_011_5EE8:: ; heuristic: map record of the map table; C0
    db $FD, $73, $53, $8B, $77, $53, $01, $01, $33, $00, $00, $00, $00, $00, $00, $00
    db $3B, $CC, $B5, $70, $54, $B8, $70, $54, $B5, $70, $54, $B8, $70, $54, $B5, $70
    db $54, $B8, $70, $54, $B5, $70, $54, $B8, $70, $54, $B5, $70, $54, $B8, $70, $54

Data_011_5F18:: ; heuristic: map record of the map table; C0
    db $EB, $7B, $52, $4A, $72, $54, $03, $04, $2D, $00, $00, $15, $00, $00, $00, $00
    db $3B, $CC, $CB, $77, $53, $EF, $77, $53, $CB, $77, $53, $EF, $77, $53, $CB, $77
    db $53, $EF, $77, $53, $CB, $77, $53, $EF, $77, $53, $CB, $77, $53, $EF, $77, $53

Data_011_5F48:: ; heuristic: map record of the map table; C0
    db $01, $40, $55, $45, $76, $93, $03, $03, $4F, $00, $00, $15, $00, $00, $00, $00
    db $3B, $CC, $DC, $42, $55, $F7, $42, $55, $DC, $42, $55, $F7, $42, $55, $DC, $42
    db $55, $F7, $42, $55, $DC, $42, $55, $F7, $42, $55, $DC, $42, $55, $F7, $42, $55

Data_011_5F78:: ; heuristic: map record of the map table; C0
    db $8A, $72, $54, $6C, $76, $54, $01, $01, $2C, $00, $00, $00, $00, $00, $00, $00
    db $3B, $CC, $AC, $76, $54, $AF, $76, $54, $B2, $76, $54, $B5, $76, $54, $B2, $76
    db $54, $B5, $76, $54, $B2, $76, $54, $B5, $76, $54, $B2, $76, $54, $B5, $76, $54

Data_011_5FA8:: ; heuristic: map record of the map table; C0
    db $24, $51, $55, $85, $76, $93, $03, $03, $53, $00, $00, $15, $00, $00, $00, $00
    db $3B, $CC, $42, $57, $55, $5D, $57, $55, $42, $57, $55, $5D, $57, $55, $42, $57
    db $55, $5D, $57, $55, $78, $57, $55, $93, $57, $55, $78, $57, $55, $93, $57, $55

Data_011_5FD8:: ; heuristic: map record of the map table; C0
    db $02, $7A, $93, $28, $7F, $93, $01, $01, $2F, $00, $00, $00, $00, $00, $00, $00
    db $3B, $CC, $F2, $77, $51, $F5, $77, $51, $F2, $77, $51, $F5, $77, $51, $F8, $77
    db $51, $FB, $77, $51, $F8, $77, $51, $FB, $77, $51, $F8, $77, $51, $FB, $77, $51

Data_011_6008:: ; heuristic: map record of the map table; C0
    db $01, $40, $55, $45, $76, $93, $03, $02, $4F, $00, $00, $15, $00, $00, $00, $00
    db $3B, $CC, $FF, $4A, $55, $11, $4B, $55, $FF, $4A, $55, $11, $4B, $55, $FF, $4A
    db $55, $11, $4B, $55, $FF, $4A, $55, $11, $4B, $55, $FF, $4A, $55, $11, $4B, $55

Data_011_6038:: ; heuristic: map record of the map table; C0
    db $70, $79, $54, $58, $7D, $54, $01, $01, $3B, $00, $03, $00, $00, $00, $00, $00
    db $3B, $CC, $98, $7D, $54, $9B, $7D, $54, $98, $7D, $54, $9B, $7D, $54, $98, $7D
    db $54, $9B, $7D, $54, $98, $7D, $54, $9B, $7D, $54, $98, $7D, $54, $9B, $7D, $54

Data_011_6068:: ; heuristic: map record of the map table; C0
    db $E6, $43, $95, $C5, $76, $93, $01, $01, $17, $00, $00, $00, $00, $00, $00, $00
    db $3B, $CC, $81, $45, $95, $84, $45, $95, $81, $45, $95, $84, $45, $95, $81, $45
    db $95, $84, $45, $95, $81, $45, $95, $84, $45, $95, $81, $45, $95, $84, $45, $95

Data_011_6098:: ; heuristic: map record of the map table; C0
    db $40, $7B, $51, $55, $7E, $51, $01, $01, $24, $00, $00, $00, $00, $00, $00, $00
    db $3B, $CC, $95, $7E, $51, $98, $7E, $51, $95, $7E, $51, $98, $7E, $51, $95, $7E
    db $51, $98, $7E, $51, $95, $7E, $51, $98, $7E, $51, $95, $7E, $51, $98, $7E, $51

Data_011_60C8:: ; heuristic: map record of the map table; C0
    db $34, $65, $55, $05, $77, $93, $03, $03, $3F, $00, $04, $00, $00, $00, $00, $00
    db $3B, $CC, $70, $69, $55, $8B, $69, $55, $70, $69, $55, $8B, $69, $55, $70, $69
    db $55, $8B, $69, $55, $70, $69, $55, $8B, $69, $55, $70, $69, $55, $8B, $69, $55

Data_011_60F8:: ; heuristic: map record of the map table; C0
    db $34, $65, $55, $05, $77, $93, $02, $03, $3F, $00, $00, $00, $00, $00, $00, $00
    db $3B, $CC, $5E, $73, $55, $70, $73, $55, $5E, $73, $55, $70, $73, $55, $5E, $73
    db $55, $70, $73, $55, $5E, $73, $55, $70, $73, $55, $5E, $73, $55, $70, $73, $55

Data_011_6128:: ; heuristic: map record of the map table; C0
    db $34, $65, $55, $05, $77, $93, $02, $02, $3F, $00, $00, $00, $00, $00, $00, $00
    db $3B, $CC, $89, $79, $55, $95, $79, $55, $89, $79, $55, $95, $79, $55, $89, $79
    db $55, $95, $79, $55, $89, $79, $55, $95, $79, $55, $89, $79, $55, $95, $79, $55

Data_011_6158:: ; heuristic: map record of the map table; C0
    db $4F, $5C, $90, $1F, $60, $90, $01, $01, $3F, $00, $00, $00, $00, $02, $1F, $00
    db $3B, $CC, $5F, $60, $90, $62, $60, $90, $5F, $60, $90, $62, $60, $90, $5F, $60
    db $90, $62, $60, $90, $5F, $60, $90, $62, $60, $90, $5F, $60, $90, $62, $60, $90

Data_011_6188:: ; heuristic: map record of the map table; C0
    db $4F, $5C, $90, $1F, $60, $90, $01, $01, $3F, $00, $00, $00, $00, $02, $1F, $00
    db $3B, $CC, $65, $60, $90, $68, $60, $90, $65, $60, $90, $68, $60, $90, $65, $60
    db $90, $68, $60, $90, $65, $60, $90, $68, $60, $90, $65, $60, $90, $68, $60, $90

Data_011_61B8:: ; heuristic: map record of the map table; C0
    db $4F, $5C, $90, $1F, $60, $90, $01, $01, $3F, $00, $00, $00, $00, $02, $1F, $00
    db $3B, $CC, $6B, $60, $90, $6E, $60, $90, $6B, $60, $90, $6E, $60, $90, $6B, $60
    db $90, $6E, $60, $90, $6B, $60, $90, $6E, $60, $90, $6B, $60, $90, $6E, $60, $90

Data_011_61E8:: ; heuristic: map record of the map table; C0
    db $4F, $5C, $90, $1F, $60, $90, $01, $01, $3F, $00, $00, $00, $00, $02, $1F, $00
    db $3B, $CC, $71, $60, $90, $74, $60, $90, $71, $60, $90, $74, $60, $90, $71, $60
    db $90, $74, $60, $90, $71, $60, $90, $74, $60, $90, $71, $60, $90, $74, $60, $90

Data_011_6218:: ; heuristic: map record of the map table; C0
    INCBIN "dwm2-cobi-us.gbc", $046218, $60

Data_011_6278:: ; heuristic: map record of the map table; C0
    db $C4, $61, $58, $92, $65, $58, $04, $03, $3F, $00, $01, $16, $00, $02, $29, $00
    db $3C, $CC, $D2, $65, $58, $F6, $65, $58, $1A, $66, $58, $3E, $66, $58

Data_011_6296:: ; heuristic: map record of the map table; C0
    db $F4, $6E, $58, $28, $74, $58, $01, $03, $5F, $00, $05, $00, $00, $00, $00, $00
    db $3C, $CC, $68, $74, $58, $71, $74, $58, $7A, $74, $58, $83, $74, $58

Data_011_62B4:: ; heuristic: map record of the map table; C0
    db $79, $6D, $68, $14, $73, $68, $03, $04, $55, $00, $01, $17, $00, $02, $07, $00
    db $3C, $CC, $54, $73, $68, $78, $73, $68, $54, $73, $68, $78, $73, $68

Data_011_62D2:: ; heuristic: map record of the map table; C0
    db $41, $40, $94, $68, $46, $94, $01, $02, $68, $00, $0A, $00, $00, $00, $00, $00
    db $3C, $CC, $A8, $46, $94, $AE, $46, $94, $A8, $46, $94, $AE, $46, $94, $B4, $6F
    db $90, $BE, $7D, $68, $01, $01, $1F, $1C, $00, $00, $00, $00, $00, $00, $3C, $CC
    db $FE, $7D, $68, $01, $7E, $68, $FE, $7D, $68, $01, $7E, $68

Data_011_630E:: ; heuristic: map record of the map table; C0
    db $01, $40, $59, $A3, $44, $59, $06, $06, $3B, $00, $00, $18, $00, $00, $00, $00
    db $3D, $CC, $E3, $44, $59, $4F, $45, $59

Data_011_6326:: ; heuristic: map record of the map table; C0
    db $3E, $5D, $59, $60, $62, $59, $02, $02, $2D, $00, $00, $00, $00, $00, $00, $00
    db $3D, $CC, $A0, $62, $59, $AC, $62, $59

Data_011_633E:: ; heuristic: map record of the map table; C0
    db $3E, $5D, $59, $60, $62, $59, $01, $02, $2D, $00, $00, $00, $00, $00, $00, $00
    db $3D, $CC, $99, $67, $59, $9F, $67, $59

Data_011_6356:: ; heuristic: map record of the map table; C0
    db $3E, $5D, $59, $60, $62, $59, $01, $01, $2D, $00, $00, $00, $00, $00, $00, $00
    db $3D, $CC, $6B, $69, $59, $6E, $69, $59

Data_011_636E:: ; heuristic: map record of the map table; C0
    db $BC, $6A, $59, $0C, $6E, $59, $01, $01, $31, $00, $00, $00, $00, $00, $00, $00
    db $3D, $CC, $4C, $6E, $59, $4F, $6E, $59

Data_011_6386:: ; heuristic: map record of the map table; C0
    db $FB, $6F, $59, $43, $72, $59, $03, $04, $3F, $00, $00, $19, $01, $00, $00, $00
    db $3D, $CC, $83, $72, $59, $A7, $72, $59

Data_011_639E:: ; heuristic: map record of the map table; C0
    db $FB, $6F, $59, $43, $72, $59, $03, $04, $3F, $00, $00, $19, $01, $00, $00, $00
    db $3D, $CC, $01, $40, $5A, $25, $40, $5A

Data_011_63B6:: ; heuristic: map record of the map table; C0
    db $C4, $49, $5A, $68, $7F, $93, $03, $02, $3F, $00, $00, $1A, $00, $00, $00, $00
    db $3E, $CC, $87, $4E, $5A, $99, $4E, $5A, $87, $4E, $5A, $99, $4E, $5A

Data_011_63D4:: ; heuristic: map record of the map table; C0
    db $A2, $53, $5A, $B7, $57, $5A, $01, $01, $37, $00, $00, $00, $00, $00, $00, $00
    db $3E, $CC, $F7, $57, $5A, $FA, $57, $5A, $F7, $57, $5A, $FA, $57, $5A

Data_011_63F2:: ; heuristic: map record of the map table; C0
    db $35, $59, $5A, $F8, $5B, $5A, $02, $02, $1F, $00, $00, $1B, $00, $00, $00, $00
    db $3E, $CC, $38, $5C, $5A, $44, $5C, $5A, $38, $5C, $5A, $44, $5C, $5A

Data_011_6410:: ; heuristic: map record of the map table; C0
    db $35, $59, $5A, $F8, $5B, $5A, $02, $02, $1F, $00, $00, $1B, $00, $00, $00, $00
    db $3E, $CC, $0B, $60, $5A, $17, $60, $5A, $0B, $60, $5A, $17, $60, $5A

Data_011_642E:: ; heuristic: map record of the map table; C0
    db $35, $59, $5A, $F8, $5B, $5A, $02, $02, $1F, $00, $00, $1B, $00, $00, $00, $00
    db $3E, $CC, $43, $64, $5A, $4F, $64, $5A, $43, $64, $5A, $4F, $64, $5A

Data_011_644C:: ; heuristic: map record of the map table; C0
    db $35, $59, $5A, $F8, $5B, $5A, $01, $01, $1F, $00, $00, $00, $00, $00, $00, $00
    db $3E, $CC, $5C, $67, $5A, $5F, $67, $5A, $5C, $67, $5A, $5F, $67, $5A

Data_011_646A:: ; heuristic: map record of the map table; C0
    db $A9, $68, $5A, $6F, $6D, $5A, $05, $05, $3F, $00, $01, $1C, $00, $01, $29, $00
    db $3F, $CC, $AF, $6D, $5A, $FA, $6D, $5A, $AF, $6D, $5A, $FA, $6D, $5A, $AF, $6D
    db $5A, $FA, $6D, $5A

Data_011_648E:: ; heuristic: map record of the map table; C0
    db $5D, $46, $5B, $66, $4B, $5B, $02, $02, $3D, $00, $00, $00, $00, $00, $00, $00
    db $3F, $CC, $A6, $4B, $5B, $B2, $4B, $5B, $A6, $4B, $5B, $B2, $4B, $5B, $A6, $4B
    db $5B, $B2, $4B, $5B

Data_011_64B2:: ; heuristic: map record of the map table; C0
    db $5C, $51, $5B, $94, $55, $5B, $01, $02, $39, $00, $00, $00, $00, $00, $00, $00
    db $3F, $CC, $D4, $55, $5B, $DA, $55, $5B, $D4, $55, $5B, $DA, $55, $5B, $D4, $55
    db $5B, $DA, $55, $5B

Data_011_64D6:: ; heuristic: map record of the map table; C0
    db $66, $58, $5B, $4B, $5A, $5B, $01, $02, $0F, $00, $00, $00, $00, $00, $00, $00
    db $3F, $CC, $8B, $5A, $5B, $91, $5A, $5B, $97, $5A, $5B, $9D, $5A, $5B, $97, $5A
    db $5B, $9D, $5A, $5B

Data_011_64FA:: ; heuristic: map record of the map table; C0
    db $46, $5E, $5B, $E9, $60, $5B, $01, $01, $2C, $00, $00, $00, $00, $00, $00, $00
    db $3F, $CC, $29, $61, $5B, $2C, $61, $5B, $29, $61, $5B, $2C, $61, $5B, $29, $61
    db $5B, $2C, $61, $5B

Data_011_651E:: ; heuristic: map record of the map table; C0
    db $46, $62, $5B, $EA, $64, $5B, $01, $01, $3F, $00, $00, $00, $03, $00, $00, $00
    db $3F, $CC, $2A, $65, $5B, $2D, $65, $5B, $2A, $65, $5B, $2D, $65, $5B, $2A, $65
    db $5B, $2D, $65, $5B

Data_011_6542:: ; heuristic: map record of the map table; C0
    db $46, $62, $5B, $EA, $64, $5B, $01, $01, $3F, $00, $00, $1D, $03, $00, $00, $00
    db $3F, $CC, $28, $66, $5B, $2B, $66, $5B, $28, $66, $5B, $2B, $66, $5B, $28, $66
    db $5B, $2B, $66, $5B

Data_011_6566:: ; heuristic: map record of the map table; C0
    db $46, $62, $5B, $EA, $64, $5B, $02, $02, $3F, $00, $00, $1E, $03, $00, $00, $00
    db $3F, $CC, $E3, $66, $5B, $EF, $66, $5B, $E3, $66, $5B, $EF, $66, $5B, $FB, $66
    db $5B, $07, $67, $5B

Data_011_658A:: ; heuristic: map record of the map table; C0
    db $46, $62, $5B, $EA, $64, $5B, $02, $02, $3F, $00, $00, $1F, $03, $00, $00, $00
    db $3F, $CC, $4C, $69, $5B, $58, $69, $5B, $4C, $69, $5B, $58, $69, $5B, $4C, $69
    db $5B, $58, $69, $5B

Data_011_65AE:: ; heuristic: map record of the map table; C0
    db $46, $62, $5B, $EA, $64, $5B, $02, $02, $3F, $00, $00, $1F, $03, $00, $00, $00
    db $3F, $CC, $AC, $6B, $5B, $B8, $6B, $5B, $AC, $6B, $5B, $B8, $6B, $5B, $AC, $6B
    db $5B, $B8, $6B, $5B

Data_011_65D2:: ; heuristic: map record of the map table; C0
    db $46, $62, $5B, $EA, $64, $5B, $02, $02, $3F, $00, $00, $20, $03, $00, $00, $00
    db $3F, $CC, $F8, $6E, $5B, $04, $6F, $5B, $F8, $6E, $5B, $04, $6F, $5B, $F8, $6E
    db $5B, $04, $6F, $5B

Data_011_65F6:: ; heuristic: map record of the map table; C0
    db $46, $62, $5B, $EA, $64, $5B, $02, $02, $3F, $00, $00, $20, $03, $00, $00, $00
    db $3F, $CC, $88, $72, $5B, $94, $72, $5B, $88, $72, $5B, $94, $72, $5B, $88, $72
    db $5B, $94, $72, $5B

Data_011_661A:: ; heuristic: map record of the map table; C0
    db $46, $62, $5B, $EA, $64, $5B, $01, $01, $3F, $00, $00, $00, $03, $00, $00, $00
    db $3F, $CC, $ED, $75, $5B, $F0, $75, $5B, $ED, $75, $5B, $F0, $75, $5B, $ED, $75
    db $5B, $F0, $75, $5B

Data_011_663E:: ; heuristic: map record of the map table; C0
    db $01, $40, $5C, $D6, $45, $5C, $01, $02, $3F, $00, $00, $00, $00, $00, $00, $00
    db $40, $CC, $0A, $77, $5B, $10, $77, $5B, $0A, $77, $5B, $10, $77, $5B

Data_011_665C:: ; heuristic: map record of the map table; C0
    db $16, $46, $5C, $04, $4B, $5C, $01, $02, $4F, $00, $04, $00, $00, $00, $00, $00
    db $40, $CC, $44, $4B, $5C, $4A, $4B, $5C, $44, $4B, $5C, $4A, $4B, $5C

Data_011_667A:: ; heuristic: map record of the map table; C0
    db $16, $46, $5C, $04, $4B, $5C, $01, $02, $4F, $00, $04, $00, $00, $00, $00, $00
    db $40, $CC, $35, $4D, $5C, $3B, $4D, $5C, $35, $4D, $5C, $3B, $4D, $5C

Data_011_6698:: ; heuristic: map record of the map table; C0
    db $16, $46, $5C, $04, $4B, $5C, $01, $02, $4F, $00, $04, $00, $00, $00, $00, $00
    db $40, $CC, $71, $4F, $5C, $77, $4F, $5C, $71, $4F, $5C, $77, $4F, $5C

Data_011_66B6:: ; heuristic: map record of the map table; C0
    db $BF, $51, $5C, $37, $54, $5C, $01, $02, $3F, $00, $00, $00, $00, $00, $00, $00
    db $40, $CC, $77, $54, $5C, $7D, $54, $5C, $77, $54, $5C, $7D, $54, $5C

Data_011_66D4:: ; heuristic: map record of the map table; C0
    db $E3, $55, $5C, $DB, $5A, $5C, $01, $02, $4F, $00, $04, $00, $00, $00, $00, $00
    db $40, $CC, $44, $4B, $5C, $4A, $4B, $5C, $44, $4B, $5C, $4A, $4B, $5C

Data_011_66F2:: ; heuristic: map record of the map table; C0
    db $E3, $55, $5C, $DB, $5A, $5C, $01, $02, $4F, $00, $04, $00, $00, $00, $00, $00
    db $40, $CC, $35, $4D, $5C, $3B, $4D, $5C, $35, $4D, $5C, $3B, $4D, $5C

Data_011_6710:: ; heuristic: map record of the map table; C0
    db $E3, $55, $5C, $DB, $5A, $5C, $01, $02, $4F, $00, $04, $00, $00, $00, $00, $00
    db $40, $CC, $1B, $5B, $5C, $21, $5B, $5C, $1B, $5B, $5C, $21, $5B, $5C

Data_011_672E:: ; heuristic: map record of the map table; C0
    db $85, $5D, $5C, $CD, $60, $5C, $02, $01, $3F, $00, $00, $00, $00, $00, $00, $00
    db $40, $CC, $0D, $61, $5C, $13, $61, $5C, $0D, $61, $5C, $13, $61, $5C

Data_011_674C:: ; heuristic: map record of the map table; C0
    db $7C, $62, $5C, $76, $67, $5C, $01, $02, $4F, $00, $04, $00, $00, $00, $00, $00
    db $40, $CC, $44, $4B, $5C, $4A, $4B, $5C, $44, $4B, $5C, $4A, $4B, $5C

Data_011_676A:: ; heuristic: map record of the map table; C0
    db $7C, $62, $5C, $76, $67, $5C, $01, $02, $4F, $00, $04, $00, $00, $00, $00, $00
    db $40, $CC, $35, $4D, $5C, $3B, $4D, $5C, $35, $4D, $5C, $3B, $4D, $5C

Data_011_6788:: ; heuristic: map record of the map table; C0
    db $7C, $62, $5C, $76, $67, $5C, $01, $02, $4F, $00, $04, $00, $00, $00, $00, $00
    db $40, $CC
    dw Data_011_67B6
    db $5C, $BC, $67, $5C
    dw Data_011_67B6
    db $5C, $BC, $67, $5C

; E-0036 (C1: CheckWarpAtPlayer indexes it with hMapId; the lists hold entries matched against the player's facing and position, and a match queues sound effect $60 and loads a new map number and position; all 256 words point into the bank; the first list starts at $69A6, directly after the table).
; record: list of warps for this map number (hMapId); a list ends with $80; maps without warps share one empty list
MapWarpTable::
Data_011_67A6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_011_69A7 ; entry 0
    dw Data_011_69D5 ; entry 1
    dw Data_011_6A5D ; entry 2
    dw Data_011_6A70 ; entry 3
    dw Data_011_6A7A ; entry 4
    dw Data_011_6A96 ; entry 5
    dw Data_011_6AB2 ; entry 6
    dw Data_011_6ABC ; entry 7
Data_011_67B6:: ; heuristic: label inside a table; C0
    dw Data_011_6ACF ; entry 8
    dw Data_011_6AD9 ; entry 9
    dw Data_011_6AE3 ; entry 10
    dw Data_011_69A6 ; entry 11
    dw Data_011_6AF6 ; entry 12
    dw Data_011_6B1B ; entry 13
    dw Data_011_6B37 ; entry 14
    dw Data_011_6B41 ; entry 15
    dw Data_011_6B5D ; entry 16
    dw Data_011_6B67 ; entry 17
    dw Data_011_6B71 ; entry 18
    dw Data_011_6B7B ; entry 19
    dw Data_011_69A6 ; entry 20
    dw Data_011_6B85 ; entry 21
    dw Data_011_6B8F ; entry 22
    dw Data_011_6B99 ; entry 23
    dw Data_011_6BA3 ; entry 24
    dw Data_011_6BC8 ; entry 25
    dw Data_011_6BDB ; entry 26
    dw Data_011_6BEE ; entry 27
    dw Data_011_69A6 ; entry 28
    dw Data_011_69A6 ; entry 29
    dw Data_011_69A6 ; entry 30
    dw Data_011_69A6 ; entry 31
    dw Data_011_6BF8 ; entry 32
    dw Data_011_6C2F ; entry 33
    dw Data_011_6C54 ; entry 34
    dw Data_011_6C5E ; entry 35
    dw Data_011_6C68 ; entry 36
    dw Data_011_6CA8 ; entry 37
    dw Data_011_6CD6 ; entry 38
    dw Data_011_69A6 ; entry 39
    dw Data_011_6CE0 ; entry 40
    dw Data_011_6CEA ; entry 41
    dw Data_011_6CEB ; entry 42
    dw Data_011_6CFE ; entry 43
    dw Data_011_69A6 ; entry 44
    dw Data_011_6D11 ; entry 45
    dw Data_011_6D1B ; entry 46
    dw Data_011_6D25 ; entry 47
    dw Data_011_6D6E ; entry 48
    dw Data_011_6DC0 ; entry 49
    dw Data_011_6DCA ; entry 50
    dw Data_011_6DEF ; entry 51
    dw Data_011_6DF9 ; entry 52
    dw Data_011_6E03 ; entry 53
    dw Data_011_6E0D ; entry 54
    dw Data_011_6E29 ; entry 55
    dw Data_011_6E3C ; entry 56
    dw Data_011_6E58 ; entry 57
    dw Data_011_6E74 ; entry 58
    dw Data_011_6E87 ; entry 59
    dw Data_011_6E91 ; entry 60
    dw Data_011_6EA4 ; entry 61
Data_011_6822:: ; heuristic: label inside a table; C0
    dw Data_011_6EAE ; entry 62
    dw Data_011_6EDC ; entry 63
    dw Data_011_6F2E ; entry 64
    dw Data_011_6F38 ; entry 65
    dw Data_011_6F39 ; entry 66
    dw Data_011_6F55 ; entry 67
    dw Data_011_6F71 ; entry 68
    dw Data_011_6F7B ; entry 69
    dw Data_011_69A6 ; entry 70
    dw Data_011_69A6 ; entry 71
    dw Data_011_6F7C ; entry 72
    dw Data_011_7031 ; entry 73
    dw Data_011_703B ; entry 74
    dw Data_011_7072 ; entry 75
    dw Data_011_707C ; entry 76
    dw Data_011_7086 ; entry 77
    dw Data_011_7090 ; entry 78
    dw Data_011_70A3 ; entry 79
    dw Data_011_70BF ; entry 80
    dw Data_011_70D2 ; entry 81
    dw Data_011_70DC ; entry 82
    dw Data_011_7113 ; entry 83
    dw Data_011_7165 ; entry 84
    dw Data_011_716F ; entry 85
Data_011_6852:: ; heuristic: label inside a table; C0
    dw Data_011_7179 ; entry 86
    dw Data_011_718C ; entry 87
    dw Data_011_71A8 ; entry 88
    dw Data_011_71CD ; entry 89
    dw Data_011_71D7 ; entry 90
    dw Data_011_7217 ; entry 91
    dw Data_011_722A ; entry 92
    dw Data_011_723D ; entry 93
    dw Data_011_7247 ; entry 94
    dw Data_011_727E ; entry 95
    dw Data_011_7288 ; entry 96
    dw Data_011_729B ; entry 97
    dw Data_011_72A5 ; entry 98
    dw Data_011_72AF ; entry 99
    dw Data_011_72C2 ; entry 100
    dw Data_011_7314 ; entry 101
    dw Data_011_736F ; entry 102
    dw Data_011_738B ; entry 103
    dw Data_011_7395 ; entry 104
    dw Data_011_69A6 ; entry 105
    dw Data_011_69A6 ; entry 106
    dw Data_011_69A6 ; entry 107
    dw Data_011_69A6 ; entry 108
    dw Data_011_69A6 ; entry 109
Data_011_6882:: ; heuristic: label inside a table; C0
    dw Data_011_69A6 ; entry 110
    dw Data_011_69A6 ; entry 111
    dw Data_011_7396 ; entry 112
    dw Data_011_7442 ; entry 113
    dw Data_011_7467 ; entry 114
    dw Data_011_7471 ; entry 115
    dw Data_011_7496 ; entry 116
    dw Data_011_74CD ; entry 117
    dw Data_011_74F2 ; entry 118
    dw Data_011_74FC ; entry 119
    dw Data_011_750F ; entry 120
    dw Data_011_752B ; entry 121
    dw Data_011_7535 ; entry 122
    dw Data_011_753F ; entry 123
    dw Data_011_7552 ; entry 124
    dw Data_011_7577 ; entry 125
    dw Data_011_758A ; entry 126
    dw Data_011_7594 ; entry 127
    dw Data_011_759E ; entry 128
    dw Data_011_75B1 ; entry 129
    dw Data_011_75C4 ; entry 130
    dw Data_011_7616 ; entry 131
    dw Data_011_7656 ; entry 132
    dw Data_011_7660 ; entry 133
    dw Data_011_767C ; entry 134
    dw Data_011_76A1 ; entry 135
    dw Data_011_76C6 ; entry 136
    dw Data_011_76D9 ; entry 137
    dw Data_011_76EC ; entry 138
    dw Data_011_7708 ; entry 139
    dw Data_011_772D ; entry 140
    dw Data_011_7740 ; entry 141
    dw Data_011_775C ; entry 142
    dw Data_011_778A ; entry 143
    dw Data_011_77A6 ; entry 144
    dw Data_011_77B9 ; entry 145
    dw Data_011_77C3 ; entry 146
    dw Data_011_77CD ; entry 147
    dw Data_011_77E9 ; entry 148
    dw Data_011_77FC ; entry 149
    dw Data_011_7818 ; entry 150
    dw Data_011_7834 ; entry 151
    dw Data_011_7847 ; entry 152
    dw Data_011_785A ; entry 153
    dw Data_011_786D ; entry 154
    dw Data_011_7880 ; entry 155
    dw Data_011_69A6 ; entry 156
    dw Data_011_788A ; entry 157
    dw Data_011_69A6 ; entry 158
    dw Data_011_69A6 ; entry 159
    dw Data_011_788B ; entry 160
    dw Data_011_7895 ; entry 161
    dw Data_011_78A8 ; entry 162
    dw Data_011_78C4 ; entry 163
    dw Data_011_78CE ; entry 164
    dw Data_011_69A6 ; entry 165
    dw Data_011_69A6 ; entry 166
    dw Data_011_69A6 ; entry 167
    dw Data_011_78CF ; entry 168
    dw Data_011_78FD ; entry 169
    dw Data_011_7919 ; entry 170
    dw Data_011_7923 ; entry 171
    dw Data_011_792D ; entry 172
    dw Data_011_7937 ; entry 173
    dw Data_011_794A ; entry 174
    dw Data_011_795D ; entry 175
    dw Data_011_795E ; entry 176
    dw Data_011_7968 ; entry 177
    dw Data_011_69A6 ; entry 178
    dw Data_011_797B ; entry 179
    dw Data_011_798E ; entry 180
    dw Data_011_79A1 ; entry 181
    dw Data_011_79BD ; entry 182
    dw Data_011_69A6 ; entry 183
    dw Data_011_79C7 ; entry 184
    dw Data_011_79EC ; entry 185
    dw Data_011_7A11 ; entry 186
    dw Data_011_7A1B ; entry 187
    dw Data_011_7A2E ; entry 188
    dw Data_011_7A38 ; entry 189
    dw Data_011_7A42 ; entry 190
    dw Data_011_7A55 ; entry 191
    dw Data_011_7A68 ; entry 192
    dw Data_011_7A7B ; entry 193
    dw Data_011_7A8E ; entry 194
    dw Data_011_7AA1 ; entry 195
    dw Data_011_7AB4 ; entry 196
    dw Data_011_69A6 ; entry 197
    dw Data_011_69A6 ; entry 198
    dw Data_011_69A6 ; entry 199
    dw Data_011_7AC7 ; entry 200
    dw Data_011_7AD1 ; entry 201
    dw Data_011_7AE4 ; entry 202
    dw Data_011_7AF7 ; entry 203
    dw Data_011_7B0A ; entry 204
    dw Data_011_7B1D ; entry 205
    dw Data_011_7B30 ; entry 206
    dw Data_011_69A6 ; entry 207
    dw Data_011_69A6 ; entry 208
    dw Data_011_7B3A ; entry 209
    dw Data_011_7B44 ; entry 210
    dw Data_011_7B57 ; entry 211
    dw Data_011_7B6A ; entry 212
    dw Data_011_7B7D ; entry 213
    dw Data_011_7B90 ; entry 214
    dw Data_011_7BA3 ; entry 215
    dw Data_011_69A6 ; entry 216
    dw Data_011_69A6 ; entry 217
    dw Data_011_7BAD ; entry 218
    dw Data_011_7BB7 ; entry 219
    dw Data_011_7BCA ; entry 220
    dw Data_011_7BDD ; entry 221
    dw Data_011_7BF0 ; entry 222
    dw Data_011_7C03 ; entry 223
    dw Data_011_7C16 ; entry 224
    dw Data_011_69A6 ; entry 225
    dw Data_011_69A6 ; entry 226
    dw Data_011_69A6 ; entry 227
    dw Data_011_69A6 ; entry 228
    dw Data_011_69A6 ; entry 229
    dw Data_011_69A6 ; entry 230
    dw Data_011_69A6 ; entry 231
    dw Data_011_69A6 ; entry 232
    dw Data_011_69A6 ; entry 233
    dw Data_011_69A6 ; entry 234
    dw Data_011_69A6 ; entry 235
    dw Data_011_69A6 ; entry 236
    dw Data_011_69A6 ; entry 237
    dw Data_011_69A6 ; entry 238
    dw Data_011_69A6 ; entry 239
    dw Data_011_69A6 ; entry 240
    dw Data_011_69A6 ; entry 241
    dw Data_011_69A6 ; entry 242
    dw Data_011_69A6 ; entry 243
    dw Data_011_69A6 ; entry 244
    dw Data_011_69A6 ; entry 245
    dw Data_011_69A6 ; entry 246
    dw Data_011_69A6 ; entry 247
    dw Data_011_69A6 ; entry 248
    dw Data_011_69A6 ; entry 249
    dw Data_011_69A6 ; entry 250
    dw Data_011_69A6 ; entry 251
    dw Data_011_69A6 ; entry 252
    dw Data_011_69A6 ; entry 253
    dw Data_011_69A6 ; entry 254
    dw Data_011_69A6 ; entry 255

Data_011_69A6:: ; heuristic: warp list of the map warp table; C0
    db $80

Data_011_69A7:: ; heuristic: warp list of the map warp table; C0
    db $FD, $02, $40, $40, $06, $00, $00, $04, $08, $FF, $00, $00, $01, $02, $02, $00
    db $90, $00, $02, $10, $40, $00, $01, $03, $02, $04, $08, $FF, $00, $01, $00, $01
    db $03, $02, $90, $00, $FD, $21, $60, $30, $07, $00, $10, $06, $03, $80

Data_011_69D5:: ; heuristic: warp list of the map warp table; C0
    INCBIN "dwm2-cobi-us.gbc", $0469D5, $88

Data_011_6A5D:: ; heuristic: warp list of the map warp table; C0
    db $FF, $00, $00, $FF, $01, $00, $02, $00, $80, $FF, $00, $03, $00, $00, $01, $01
    db $70, $00, $80

Data_011_6A70:: ; heuristic: warp list of the map warp table; C0
    db $FD, $00, $50, $50, $05, $00, $10, $05, $05, $80

Data_011_6A7A:: ; heuristic: warp list of the map warp table; C0
    db $FD, $20, $40, $40, $0C, $01, $10, $04, $04, $FF, $00, $02, $01, $18, $82, $00
    db $00, $A0, $FF, $00, $01, $01, $18, $81, $00, $00, $80, $80

Data_011_6A96:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $02, $FF, $01, $02, $12, $05, $05, $FD, $00, $50, $50, $03, $00, $10
    db $05, $05, $FD, $00, $50, $10, $0D, $00, $31, $05, $08, $80

Data_011_6AB2:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $01, $00, $80, $02, $04, $04, $80

Data_011_6ABC:: ; heuristic: warp list of the map warp table; C0
    db $FD, $00, $60, $30, $00, $02, $11, $06, $03, $FD, $00, $50, $00, $0D, $03, $31
    db $05, $08, $80

Data_011_6ACF:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $01, $01, $80, $02, $04, $04, $80

Data_011_6AD9:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $01, $01, $81, $01, $03, $04, $80

Data_011_6AE3:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $01, $01, $82, $01, $05, $05, $FD, $00, $80, $40, $0D, $01, $11
    db $08, $04, $80

Data_011_6AF6:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $01, $01, $01, $81, $02, $02, $03, $FD, $10, $40, $40, $04, $02, $10
    db $04, $04, $FD, $00, $30, $40, $0E, $00, $00, $03, $08, $FD, $00, $70, $40, $12
    db $00, $00, $07, $08, $80

Data_011_6B1B:: ; heuristic: warp list of the map warp table; C0
    db $FD, $11, $80, $40, $0A, $00, $10, $08, $04, $FE, $00, $00, $02, $05, $80, $10
    db $05, $01, $FE, $00, $03, $02, $07, $80, $10, $05, $00, $80

Data_011_6B37:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $01, $0C, $80, $00, $03, $04, $80

Data_011_6B41:: ; heuristic: warp list of the map warp table; C0
    db $00, $00, $40, $80, $0C, $80, $00, $02, $01, $00, $00, $20, $80, $0C, $80, $00
    db $02, $01, $00, $00, $70, $80, $0C, $80, $00, $07, $01, $80

Data_011_6B5D:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $01, $0C, $80, $00, $07, $01, $80

Data_011_6B67:: ; heuristic: warp list of the map warp table; C0
    db $FF, $00, $00, $02, $01, $80, $01, $00, $D0, $80

Data_011_6B71:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $01, $0C, $80, $00, $07, $04, $80

Data_011_6B7B:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $01, $01, $81, $01, $02, $01, $80

Data_011_6B85:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $01, $01, $80, $00, $05, $05, $80

Data_011_6B8F:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $01, $01, $80, $02, $06, $01, $80

Data_011_6B99:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $01, $01, $81, $00, $03, $04, $80

Data_011_6BA3:: ; heuristic: warp list of the map warp table; C0
    db $FD, $20, $40, $20, $04, $02, $00, $04, $08, $FD, $20, $50, $20, $04, $02, $00
    db $05, $08, $FD, $10, $40, $00, $04, $01, $00, $04, $08, $FD, $10, $50, $00, $04
    db $01, $00, $05, $08, $80

Data_011_6BC8:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $01, $02, $01, $81, $00, $05, $00, $FD, $11, $50, $40, $1A, $01, $10
    db $05, $04, $80

Data_011_6BDB:: ; heuristic: warp list of the map warp table; C0
    db $FD, $10, $50, $40, $19, $01, $11, $05, $04, $FD, $20, $40, $30, $1B, $00, $10
    db $04, $03, $80

Data_011_6BEE:: ; heuristic: warp list of the map warp table; C0
    db $FD, $00, $40, $30, $1A, $02, $10, $04, $03, $80

Data_011_6BF8:: ; heuristic: warp list of the map warp table; C0
    db $FD, $21, $40, $40, $21, $00, $30, $05, $08, $FD, $21, $50, $40, $21, $00, $30
    db $05, $08, $FD, $25, $40, $40, $24, $00, $31, $05, $08, $FD, $25, $50, $40, $24
    db $00, $31, $05, $08, $FD, $55, $40, $40, $2F, $00, $31, $06, $08, $FD, $55, $50
    db $40, $2F, $00, $31, $06, $08, $80

Data_011_6C2F:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $01, $20, $02, $11, $04, $04, $FE, $00, $02, $00, $20, $02, $11
    db $04, $04, $FD, $00, $50, $10, $22, $00, $00, $05, $08, $FD, $10, $20, $20, $2A
    db $00, $00, $02, $08, $80

Data_011_6C54:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $01, $21, $80, $00, $05, $01, $80

Data_011_6C5E:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $01, $24, $81, $01, $03, $02, $80

Data_011_6C68:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $FF, $00, $20, $02, $15, $04, $04, $FE, $00, $02, $01, $20, $02, $15
    db $04, $04, $FE, $00, $00, $02, $20, $02, $15, $04, $04, $FD, $00, $40, $00, $25
    db $00, $00, $04, $08, $FD, $00, $50, $00, $25, $00, $00, $05, $08, $FD, $11, $30
    db $20, $23, $00, $00, $04, $08, $FD, $11, $20, $50, $2B, $23, $33, $02, $00, $80

Data_011_6CA8:: ; heuristic: warp list of the map warp table; C0
    db $FF, $00, $00, $01, $24, $80, $00, $00, $80, $FD, $00, $40, $00, $26, $00, $00
    db $04, $08, $FD, $00, $50, $00, $26, $00, $00, $05, $08, $FD, $00, $20, $60, $2E
    db $00, $10, $02, $06, $FD, $10, $80, $30, $2D, $00, $10, $08, $03, $80

Data_011_6CD6:: ; heuristic: warp list of the map warp table; C0
    db $FF, $00, $00, $01, $25, $80, $00, $00, $80, $80

Data_011_6CE0:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $02, $2F, $81, $10, $04, $03, $80

Data_011_6CEA:: ; heuristic: warp list of the map warp table; C0
    db $80

Data_011_6CEB:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $01, $21, $81, $00, $02, $02, $FD, $00, $10, $20, $2B, $11, $10
    db $01, $02, $80

Data_011_6CFE:: ; heuristic: warp list of the map warp table; C0
    db $FD, $10, $10, $20, $2A, $00, $10, $01, $02, $FE, $00, $03, $02, $24, $01, $11
    db $02, $05, $80

Data_011_6D11:: ; heuristic: warp list of the map warp table; C0
    db $FD, $00, $80, $30, $25, $01, $10, $08, $03, $80

Data_011_6D1B:: ; heuristic: warp list of the map warp table; C0
    db $FD, $00, $20, $60, $25, $00, $10, $02, $06, $80

Data_011_6D25:: ; heuristic: warp list of the map warp table; C0
    INCBIN "dwm2-cobi-us.gbc", $046D25, $49

Data_011_6D6E:: ; heuristic: warp list of the map warp table; C0
    INCBIN "dwm2-cobi-us.gbc", $046D6E, $52

Data_011_6DC0:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $02, $30, $05, $16, $04, $04, $80

Data_011_6DCA:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $FF, $30, $04, $12, $04, $04, $FE, $00, $02, $00, $30, $04, $12
    db $04, $04, $FD, $10, $40, $10, $33, $00, $01, $04, $08, $FD, $11, $40, $20, $34
    db $00, $00, $04, $08, $80

Data_011_6DEF:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $02, $32, $81, $00, $04, $01, $80

Data_011_6DF9:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $01, $32, $81, $01, $04, $02, $80

Data_011_6E03:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $01, $04, $30, $00, $13, $04, $04, $80

Data_011_6E0D:: ; heuristic: warp list of the map warp table; C0
    db $FD, $00, $40, $20, $37, $02, $30, $04, $08, $FD, $00, $50, $20, $37, $02, $30
    db $04

Data_011_6E1E:: ; heuristic: target of a monotone pointer table; C0
    db $08, $FE, $00, $00, $01, $30, $05, $15, $04, $05, $80

Data_011_6E29:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $02, $01, $36, $80, $10, $04, $02, $FD, $20, $20, $50, $42, $02, $10
    db $02, $05, $80

Data_011_6E3C:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $02, $04, $30, $05, $13, $04, $04, $FD, $01, $40, $40, $39, $00, $10
    db $04, $04, $FD, $31, $40, $40, $39, $03, $10, $04, $04, $80

Data_011_6E58:: ; heuristic: warp list of the map warp table; C0
    db $FD, $00, $40, $40, $38, $00, $11, $04, $04, $FD, $30, $40, $40, $38, $03, $11
    db $04, $04, $FD, $02, $40, $40, $3A, $02, $11, $04, $04, $80

Data_011_6E74:: ; heuristic: warp list of the map warp table; C0
    db $FF, $00, $01, $03, $3B, $80, $00, $00, $80, $FD, $21, $40, $40, $39, $00, $12
    db $04, $04, $80

Data_011_6E87:: ; heuristic: warp list of the map warp table; C0
    db $FF, $00, $00, $FF, $3A, $01, $02, $00, $80, $80

Data_011_6E91:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $01, $01, $30, $02, $14, $04, $04, $FD, $10, $70, $20, $3D, $00, $30
    db $07, $08, $80

Data_011_6EA4:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $01, $3C, $81, $10, $07, $02, $80

Data_011_6EAE:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $02, $30, $06, $12, $04, $04, $FD, $00, $60, $30, $3E, $01, $10
    db $06, $03, $FD, $10, $60, $30, $3E, $00, $10, $06, $03, $FD, $10, $30, $30, $3F
    db $00, $10, $03, $03, $FD, $11, $10, $60, $3F, $00, $11, $01, $06, $80

Data_011_6EDC:: ; heuristic: warp list of the map warp table; C0
    INCBIN "dwm2-cobi-us.gbc", $046EDC, $52

Data_011_6F2E:: ; heuristic: warp list of the map warp table; C0
    db $FD, $01, $40, $40, $3F, $01, $11, $04, $04, $80

Data_011_6F38:: ; heuristic: warp list of the map warp table; C0
    db $80

Data_011_6F39:: ; heuristic: warp list of the map warp table; C0
    db $FD, $20, $20, $50, $37, $02, $10, $02, $05, $FD, $00, $80, $10, $43, $00, $10
    db $08, $02, $FD, $00, $50, $40, $43, $00, $10, $05, $04, $80

Data_011_6F55:: ; heuristic: warp list of the map warp table; C0
    db $FD, $00, $80, $20, $42, $00, $10, $08, $01, $FD, $00, $50, $40, $42, $00, $10
    db $05, $04, $FD, $20, $40, $40, $44, $00, $30, $04, $08, $80

Data_011_6F71:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $01, $43, $82, $10, $04, $04, $80

Data_011_6F7B:: ; heuristic: warp list of the map warp table; C0
    db $80

Data_011_6F7C:: ; heuristic: warp list of the map warp table; C0
    INCBIN "dwm2-cobi-us.gbc", $046F7C, $A9

Data_011_7025:: ; heuristic: target of a monotone pointer table; C0
    db $04, $08, $FD, $50, $50, $40, $49, $00, $30, $04, $08, $80

Data_011_7031:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $01, $48, $05, $10, $04, $04, $80

Data_011_703B:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $02, $00, $48, $08, $12, $04, $04, $FE, $00, $00, $02, $48, $08, $12
    db $04, $04, $FE, $00, $01, $02, $48, $08, $12, $04, $04, $FD, $10, $70, $40, $4B
    db $00, $30, $07, $08, $FD, $00, $40, $00, $4C, $00, $01, $04, $08, $FD, $00, $50
    db $00, $4C, $00, $01, $05, $08, $80

Data_011_7072:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $01, $4A, $81, $10, $07, $04, $80

Data_011_707C:: ; heuristic: warp list of the map warp table; C0
    db $FF, $00, $00, $02, $4A, $80, $10, $00, $80, $80

Data_011_7086:: ; heuristic: warp list of the map warp table; C0
    db $FD, $00, $60, $20, $4C, $00, $10, $06, $01, $80

Data_011_7090:: ; heuristic: warp list of the map warp table; C0
    db $FD, $00, $40, $40, $48, $07, $13, $04, $04, $FD, $02, $40, $40, $48, $07, $14
    db $04, $04, $80

Data_011_70A3:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $01, $FF, $48, $07, $15, $04, $04, $FE, $00, $FF, $00, $48, $07, $15
    db $04, $04, $FD, $00, $20, $40, $50, $00, $30, $03, $08, $80

Data_011_70BF:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $01, $4F, $80, $10, $02, $04, $FD, $00, $50, $10, $51, $00, $10
    db $05, $01, $80

Data_011_70D2:: ; heuristic: warp list of the map warp table; C0
    db $FD, $00, $50, $10, $50, $00, $10, $05, $01, $80

Data_011_70DC:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $01, $48, $04, $16, $04, $04, $FE, $00, $02, $01, $48, $04, $16
    db $06, $04, $FD, $00, $40, $00, $53, $20, $33, $04, $08, $FD, $00, $50, $00, $53
    db $20, $33, $05, $08, $FD, $20, $40, $00, $53, $12, $33, $04, $08, $FD, $20, $50
    db $00, $53, $12, $33, $05, $08, $80

Data_011_7113:: ; heuristic: warp list of the map warp table; C0
    INCBIN "dwm2-cobi-us.gbc", $047113, $52

Data_011_7165:: ; heuristic: warp list of the map warp table; C0
    db $FD, $00, $20, $40, $53, $30, $12, $02, $04, $80

Data_011_716F:: ; heuristic: warp list of the map warp table; C0
    db $FD, $10, $60, $30, $53, $33, $11, $06, $03, $80

Data_011_7179:: ; heuristic: warp list of the map warp table; C0
    db $FD, $02, $70, $20, $53, $31, $11, $07, $02, $FD, $00, $40, $70, $57, $31, $10
    db $04, $07, $80

Data_011_718C:: ; heuristic: warp list of the map warp table; C0
    db $FD, $10, $40, $70, $56, $30, $10, $04, $07, $FF, $00, $00, $01, $53, $B0, $00
    db $00, $80, $FF, $00, $02, $01, $53, $B2, $00, $00, $80, $80

Data_011_71A8:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $FF, $00, $48, $04, $18, $04, $04, $FE, $00, $FF, $01, $48, $04, $18
    db $04, $04, $FE, $00, $00, $02, $48, $04, $18, $04, $04, $FD, $01, $80, $40, $59
    db $00, $30, $08, $08, $80

Data_011_71CD:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $01, $58, $80, $11, $08, $04, $80

Data_011_71D7:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $FF, $00, $48, $02, $19, $04, $04, $FE, $00, $00, $01, $48, $02, $19
    db $04, $04, $FE, $00, $02, $00, $48, $02, $19, $04, $04, $FE, $00, $01, $01, $48
    db $02, $19, $04, $04, $FD, $10, $30, $30, $5B, $01, $31, $04, $08, $FD, $10, $40
    db $30, $5B, $01, $31, $05, $08, $FD, $00, $40, $10, $5C, $00, $31, $03, $08, $80

Data_011_7217:: ; heuristic: warp list of the map warp table; C0
    db $FF, $00, $01, $02, $5A, $81, $10, $F0, $B0, $FD, $00, $70, $20, $5C, $00, $10
    db $07, $03, $80

Data_011_722A:: ; heuristic: warp list of the map warp table; C0
    db $FD, $00, $70, $30, $5B, $00, $10, $07, $02, $FE, $00, $00, $02, $5A, $80, $30
    db $04, $01, $80

Data_011_723D:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $02, $FF, $48, $05, $1A, $04, $03, $80

Data_011_7247:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $FF, $01, $48, $09, $19, $04, $04, $FE, $00, $01, $02, $48, $09, $19
    db $04, $04, $FE, $00, $02, $01, $48, $09, $19, $04, $04, $FD, $11, $20, $20, $5F
    db $00, $30, $02, $08, $FD, $10, $40, $00, $60, $00, $32, $04, $08, $FD, $10, $50
    db $00, $60, $00, $32, $05, $08, $80

Data_011_727E:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $01, $5E, $81, $11, $02, $02, $80

Data_011_7288:: ; heuristic: warp list of the map warp table; C0
    db $FF, $00, $00, $03, $5E, $81, $00, $00, $80, $FD, $01, $80, $60, $61, $00, $11
    db $08, $06, $80

Data_011_729B:: ; heuristic: warp list of the map warp table; C0
    db $FD, $01, $80, $60, $60, $00, $11, $08, $06, $80

Data_011_72A5:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $01, $04, $48, $0A, $15, $04, $04, $80

Data_011_72AF:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $FF, $48, $08, $17, $04, $04, $FD, $11, $10, $70, $64, $01, $11
    db $01, $07, $80

Data_011_72C2:: ; heuristic: warp list of the map warp table; C0
    INCBIN "dwm2-cobi-us.gbc", $0472C2, $52

Data_011_7314:: ; heuristic: warp list of the map warp table; C0
    INCBIN "dwm2-cobi-us.gbc", $047314, $4C

Data_011_7360:: ; heuristic: target of a monotone pointer table; C0
    db $66, $00, $10, $01, $02, $FD, $01, $10, $60, $66, $00, $11, $01, $06, $80

Data_011_736F:: ; heuristic: warp list of the map warp table; C0
    db $FD, $00, $10

Data_011_7372:: ; heuristic: target of a monotone pointer table; C0
    db $20, $65, $00, $10, $01, $02, $FD, $01, $10, $60, $65, $00, $11, $01, $06, $FD
    db $10, $40

Data_011_7384:: ; heuristic: target of a monotone pointer table; C0
    db $40, $67, $00, $10, $04, $04, $80

Data_011_738B:: ; heuristic: warp list of the map warp table; C0
    db $FD, $00, $40, $40, $66, $01, $10, $04, $04, $80

Data_011_7395:: ; heuristic: warp list of the map warp table; C0
    db $80

Data_011_7396:: ; heuristic: warp list of the map warp table; C0
    db $FD, $B1, $40, $40, $71, $01, $30, $04, $08, $FD, $A4, $40, $40, $77, $12, $30
    db $04, $08

Data_011_73A8:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $94, $40, $40, $77, $20, $30, $04, $08, $FD, $56, $40, $40, $78, $00, $31
    db $04, $08

Data_011_73BA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0473BA, $88

Data_011_7442:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $01, $70, $0B, $11, $04, $04, $FE, $00, $01, $01, $70, $0B, $11
    db $04, $04, $FD, $20, $20, $20, $72, $00, $30, $03, $08, $FE, $00, $01, $FF, $89
    db $00, $31, $04, $08, $80

Data_011_7467:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $01, $71, $82, $10, $02, $02, $80

Data_011_7471:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $02, $89, $00, $11, $05, $06, $FD, $00, $40, $40, $74, $00, $10
    db $04, $04, $FD, $01, $60, $20, $74, $00, $11, $06, $02, $FD, $11, $50, $50, $74
    db $01, $11, $05, $05, $80

Data_011_7496:: ; heuristic: warp list of the map warp table; C0
    db $FD, $00, $40, $40, $73, $00, $10, $04, $04, $FD, $01, $60, $20, $73, $00, $11
    db $06, $02, $FD, $11, $50, $50, $73, $01, $11, $05, $05, $FD, $10, $50, $40, $75
    db $01, $10, $05, $04, $FD, $01, $40, $50, $75, $00, $11, $04, $05, $FD, $11, $30
    db $20, $75, $01, $11, $03, $02, $80

Data_011_74CD:: ; heuristic: warp list of the map warp table; C0
    db $FD, $10, $50, $40, $74, $01, $10, $05, $04, $FD, $01, $40, $50, $74, $00, $11
    db $04, $05, $FD, $11, $30, $20, $74, $01, $11, $03, $02, $FD, $01, $40, $20, $76
    db $00, $11, $04, $02, $80

Data_011_74F2:: ; heuristic: warp list of the map warp table; C0
    db $FD, $01, $40, $20, $75, $00, $11, $04, $02, $80

Data_011_74FC:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $02, $01, $70, $0A, $14, $04, $04, $FE, $00, $00, $01, $70, $09, $14
    db $04, $04, $80

Data_011_750F:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $02, $70, $05, $16, $04, $04, $FE, $00, $02, $01, $70, $05, $16
    db $04, $04, $FD, $11, $60, $30, $79, $00, $11, $06, $03, $80

Data_011_752B:: ; heuristic: warp list of the map warp table; C0
    db $FD, $01, $60, $30, $78, $01, $11, $06, $03, $80

Data_011_7535:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $02, $70, $00, $14, $04, $04, $80

Data_011_753F:: ; heuristic: warp list of the map warp table; C0
    db $FD, $00, $40, $40, $70, $03, $16, $04, $04, $FD, $02, $40, $40, $70, $03, $17
    db $04, $04, $80

Data_011_7552:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $01, $02, $70, $05, $19, $04, $04, $FD, $11, $20, $40, $7D, $00, $30
    db $02, $08, $FD, $00, $40, $40, $7F, $00, $31, $04, $08, $FD, $00, $50, $40, $7F
    db $00, $31, $05, $08, $80

Data_011_7577:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $01, $7C, $81, $11, $02, $04, $FD, $00, $10, $60, $7E, $00, $10
    db $01, $06, $80

Data_011_758A:: ; heuristic: warp list of the map warp table; C0
    db $FD, $00, $10, $60, $7D, $00, $10, $01, $06, $80

Data_011_7594:: ; heuristic: warp list of the map warp table; C0
    db $FF, $00, $00, $02, $7C, $80, $10, $00, $C0, $80

Data_011_759E:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $01, $70, $08, $19, $04, $04, $FE, $00, $02, $01, $70, $09, $19
    db $04, $04, $80

Data_011_75B1:: ; heuristic: warp list of the map warp table; C0
    db $FD, $00, $40, $40, $70, $05, $1B, $04, $04, $FD, $00, $40, $20, $82, $01, $32
    db $04, $08, $80

Data_011_75C4:: ; heuristic: warp list of the map warp table; C0
    INCBIN "dwm2-cobi-us.gbc", $0475C4, $52

Data_011_7616:: ; heuristic: warp list of the map warp table; C0
    db $FD, $00, $60, $60, $82, $00, $10, $06, $06, $FD, $10, $30, $60, $82, $01, $10
    db $03, $06, $FD, $20, $40, $60, $82, $02, $10, $04, $06, $FD, $01, $70, $20, $82
    db $00, $11, $07, $02, $FD, $01, $40, $60, $82, $00, $11, $04, $06, $FD, $21, $20
    db $20, $82, $02, $11, $02, $02, $FD, $22, $70, $60, $82, $02, $12, $07, $06, $80

Data_011_7656:: ; heuristic: warp list of the map warp table; C0
    db $FD, $00, $20, $50, $82, $00, $12, $02, $05, $80

Data_011_7660:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $02, $70, $01, $1B, $04, $04, $FD, $00, $20, $30, $86, $00, $10
    db $02, $03, $FD, $10, $80, $50, $86, $01, $10, $08, $05, $80

Data_011_767C:: ; heuristic: warp list of the map warp table; C0
    db $FD, $00, $20, $30, $85, $00, $10, $02, $03, $FD, $10, $80, $50, $85, $01, $10
    db $08, $05, $FD, $10, $60, $20, $87, $01, $10, $06, $02, $FD, $10, $80, $30, $87
    db $01, $10, $08, $03, $80

Data_011_76A1:: ; heuristic: warp list of the map warp table; C0
    db $FD, $10, $60, $20, $86, $01, $10, $06, $02, $FD, $10, $80, $30, $86, $01, $10
    db $08, $03, $FD, $10, $80, $50, $88, $01, $10, $08, $05, $FD, $01, $20, $60, $88
    db $00, $11, $02, $06, $80

Data_011_76C6:: ; heuristic: warp list of the map warp table; C0
    db $FD, $10, $80, $50, $87, $01, $10, $08, $05, $FD, $01, $20, $60, $87, $00, $11
    db $02, $06, $80

Data_011_76D9:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $02, $71, $01, $10, $04, $00, $FD, $01, $50, $50, $73, $00, $31
    db $05, $08, $80

Data_011_76EC:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $01, $70, $0B, $1A, $04, $04, $FD, $00, $40, $40, $8B, $01, $33
    db $04, $08, $FD, $00, $50, $40, $8B, $01, $33, $05, $08, $80

Data_011_7708:: ; heuristic: warp list of the map warp table; C0
    db $FF, $00, $01, $04, $8A, $80, $10, $00, $C0, $FD, $01, $20, $60, $8C, $00, $11
    db $02, $06, $FD, $21, $70, $60, $8C, $02, $11, $07, $06, $FD, $21, $60, $10, $8D
    db $00, $30, $04, $08, $80

Data_011_772D:: ; heuristic: warp list of the map warp table; C0
    db $FD, $01, $20, $60, $8B, $00, $11, $02, $06, $FD, $21, $70, $60, $8B, $02, $11
    db $07, $06, $80

Data_011_7740:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $01, $8B, $82, $11, $06, $01, $FD, $00, $40, $10, $8E, $02, $32
    db $04, $08, $FD, $00, $50, $10, $8E, $02, $32, $05, $08, $80

Data_011_775C:: ; heuristic: warp list of the map warp table; C0
    db $FF, $00, $02, $03, $8D, $80, $10, $00, $90, $FD, $00, $10, $10, $8F, $00, $10
    db $01, $07, $FD, $10, $50, $60, $90, $01, $11, $05, $06, $FD, $10, $40, $10, $91
    db $00, $30, $04, $08, $FD, $10, $50, $10, $91, $00, $30, $05, $08, $80

Data_011_778A:: ; heuristic: warp list of the map warp table; C0
    db $FD, $00, $10, $70, $8E, $00, $10, $01, $01, $FD, $00, $10, $00, $90, $00, $31
    db $01, $08, $FD, $00, $20, $00, $90, $00, $31, $02, $08, $80

Data_011_77A6:: ; heuristic: warp list of the map warp table; C0
    db $FF, $00, $00, $02, $8F, $80, $10, $00, $80, $FD, $11, $50, $60, $8E, $01, $10
    db $05, $06, $80

Data_011_77B9:: ; heuristic: warp list of the map warp table; C0
    db $FF, $00, $00, $01, $8E, $81, $10, $00, $90, $80

Data_011_77C3:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $01, $70, $05, $12, $04, $04, $80

Data_011_77CD:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $01, $70, $04, $11, $04, $04, $FD, $00, $40, $20, $94, $00, $32
    db $04, $08, $FD, $00, $50, $20, $94, $00, $32, $05, $08, $80

Data_011_77E9:: ; heuristic: warp list of the map warp table; C0
    db $FF, $00, $00, $03, $93, $80, $10, $00, $A0, $FD, $10, $40, $40, $95, $00, $10
    db $04, $04, $80

Data_011_77FC:: ; heuristic: warp list of the map warp table; C0
    db $FD, $00, $40, $40, $94, $01, $10, $04, $04, $FD, $01, $40, $40, $96, $00, $11
    db $04, $04, $FD, $11, $40, $40, $96, $01, $11, $04, $04, $80

Data_011_7818:: ; heuristic: warp list of the map warp table; C0
    db $FD, $01, $40, $40, $95, $00, $11, $04, $04, $FD, $11, $40, $40, $95, $01, $11
    db $04, $04, $FD, $01, $10, $70, $97, $00, $10, $01, $07, $80

Data_011_7834:: ; heuristic: warp list of the map warp table; C0
    db $FD, $00, $10, $70, $96, $00, $11, $01, $07, $FD, $00, $80, $70, $98, $00, $10
    db $08, $07, $80

Data_011_7847:: ; heuristic: warp list of the map warp table; C0
    db $FD, $00, $80, $70, $97, $00, $10, $08, $07, $FD, $00, $80, $10, $99, $00, $10
    db $08, $01, $80

Data_011_785A:: ; heuristic: warp list of the map warp table; C0
    db $FD, $00, $80, $10, $98, $00, $10, $08, $01, $FD, $00, $10, $10, $9A, $00, $10
    db $01, $01, $80

Data_011_786D:: ; heuristic: warp list of the map warp table; C0
    db $FD, $00, $10, $10, $99, $00, $10, $01, $01, $FD, $00, $10, $70, $9B, $00, $12
    db $01, $07, $80

Data_011_7880:: ; heuristic: warp list of the map warp table; C0
    db $FD, $02, $10, $70, $9A, $00, $10, $01, $07, $80

Data_011_788A:: ; heuristic: warp list of the map warp table; C0
    db $80

Data_011_788B:: ; heuristic: warp list of the map warp table; C0
    db $FD, $12, $40, $40, $A1, $00, $32, $04, $08, $80

Data_011_7895:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $03, $A0, $01, $12, $04, $04, $FF, $00, $00, $FF, $A2, $01, $32
    db $00, $80, $80

Data_011_78A8:: ; heuristic: warp list of the map warp table; C0
    db $FF, $00, $01, $03, $A1, $00, $10, $00, $80, $FD, $10, $40, $10, $A3, $00, $31
    db $04, $08, $FD, $10, $50, $10, $A3, $00, $31, $05, $08, $80

Data_011_78C4:: ; heuristic: warp list of the map warp table; C0
    db $FF, $00, $00, $02, $A2, $81, $10, $00, $90, $80

Data_011_78CE:: ; heuristic: warp list of the map warp table; C0
    db $80

Data_011_78CF:: ; heuristic: warp list of the map warp table; C0
    db $FD, $24, $40, $40, $A9, $00, $31, $04, $08, $FD, $24, $50, $40, $A9, $00, $31
    db $04, $08, $FD, $11, $40, $40, $AA, $00, $31, $04, $08, $FD, $43, $40, $40, $AB
    db $00, $30, $04, $08, $FD, $51, $40, $40, $AD, $01, $33, $04, $08, $80

Data_011_78FD:: ; heuristic: warp list of the map warp table; C0
    db $FE, $01, $00, $02, $A8, $02, $14, $04, $04, $FE, $10, $02, $00, $A8, $02, $14
    db $04, $04, $FE, $11, $01, $02, $A8, $02, $14, $04, $04, $80

Data_011_7919:: ; heuristic: warp list of the map warp table; C0
    db $FE, $01, $00, $02, $A8, $01, $11, $04, $04, $80

Data_011_7923:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $01, $A8, $04, $13, $04, $04, $80

Data_011_792D:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $01, $AE, $01, $00, $04, $00, $80

Data_011_7937:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $01, $04, $A8, $05, $11, $04, $04, $FF, $00, $02, $FF, $AE, $02, $03
    db $00, $80, $80

Data_011_794A:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $01, $FF, $AC, $00, $30, $04, $08, $FF, $00, $02, $04, $AD, $02, $00
    db $00, $80, $80

Data_011_795D:: ; heuristic: warp list of the map warp table; C0
    db $80

Data_011_795E:: ; heuristic: warp list of the map warp table; C0
    db $FD, $10, $40, $40, $B1, $00, $30, $04, $08, $80

Data_011_7968:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $01, $B0, $01, $10, $04, $04, $FD, $00, $10, $30, $B3, $00, $11
    db $01, $03, $80

Data_011_797B:: ; heuristic: warp list of the map warp table; C0
    db $FD, $01, $10, $30, $B1, $00, $10, $01, $03, $FD, $11, $50, $40, $B4, $01, $11
    db $05, $04, $80

Data_011_798E:: ; heuristic: warp list of the map warp table; C0
    db $FD, $11, $50, $40, $B3, $01, $11, $05, $04, $FD, $01, $20, $50, $B5, $00, $11
    db $02, $05, $80

Data_011_79A1:: ; heuristic: warp list of the map warp table; C0
    db $FD, $01, $20, $50, $B4, $00, $11, $02, $05, $FD, $11, $40, $00, $B6, $00, $30
    db $04, $08, $FD, $11, $50, $00, $B6, $00, $30, $04, $08, $80

Data_011_79BD:: ; heuristic: warp list of the map warp table; C0
    db $FF, $00, $00, $01, $B5, $81, $11, $00, $80, $80

Data_011_79C7:: ; heuristic: warp list of the map warp table; C0
    db $FD, $43, $40, $40, $B9, $00, $31, $04, $08, $FD, $43, $50, $40, $B9, $00, $31
    db $04, $08, $FD, $11, $30, $50, $BA, $00, $31, $03, $08, $FD, $40, $40, $40, $BB
    db $00, $31, $04, $08, $80

Data_011_79EC:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $FF, $B8, $04, $13, $04, $04, $FE, $00, $00, $02, $B8, $04, $13
    db $04, $04, $FE, $00, $01, $02, $B8, $04, $13, $04, $04, $FD, $11, $50, $20, $BC
    db $00, $30, $05, $08, $80

Data_011_7A11:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $02, $B8, $01, $11, $03, $05, $80

Data_011_7A1B:: ; heuristic: warp list of the map warp table; C0
    db $FE, $01, $00, $02, $B8, $04, $10, $04, $04, $FD, $00, $40, $00, $BE, $00, $00
    db $04, $08, $80

Data_011_7A2E:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $01, $B9, $81, $11, $05, $02, $80

Data_011_7A38:: ; heuristic: warp list of the map warp table; C0
    db $FD, $00, $50, $70, $C4, $00, $10, $05, $07, $80

Data_011_7A42:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $01, $BB, $80, $00, $04, $00, $FD, $00, $40, $30, $BF, $00, $10
    db $04, $03, $80

Data_011_7A55:: ; heuristic: warp list of the map warp table; C0
    db $FD, $00, $40, $30, $BE, $00, $10, $04, $03, $FD, $11, $50, $50, $C0, $01, $11
    db $05, $05, $80

Data_011_7A68:: ; heuristic: warp list of the map warp table; C0
    db $FD, $11, $50, $50, $BF, $01, $11, $05, $05, $FD, $10, $70, $20, $C1, $01, $10
    db $07, $02, $80

Data_011_7A7B:: ; heuristic: warp list of the map warp table; C0
    db $FD, $10, $70, $20, $C0, $01, $10, $07, $02, $FD, $00, $70, $20, $C2, $00, $10
    db $07, $02, $80

Data_011_7A8E:: ; heuristic: warp list of the map warp table; C0
    db $FD, $00, $70, $20, $C1, $00, $10, $07, $02, $FD, $10, $40, $50, $C3, $01, $10
    db $04, $05, $80

Data_011_7AA1:: ; heuristic: warp list of the map warp table; C0
    db $FD, $10, $40, $50, $C2, $01, $10, $04, $05, $FD, $00, $70, $20, $C4, $00, $10
    db $07, $02, $80

Data_011_7AB4:: ; heuristic: warp list of the map warp table; C0
    db $FD, $00, $70, $20, $C3, $00, $10, $07, $02, $FD, $00, $50, $70, $BD, $00, $10
    db $05, $07, $80

Data_011_7AC7:: ; heuristic: warp list of the map warp table; C0
    db $FD, $00, $40, $40, $C9, $00, $31, $04, $08, $80

Data_011_7AD1:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $02, $C8, $00, $10, $04, $04, $FD, $00, $40, $50, $CA, $00, $11
    db $04, $05, $80

; LZSS-compressed asset: 273 bytes expand to 509 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_011_7AE4:: ; heuristic: warp list of the map warp table; C0
    db $FD, $01, $40, $50, $C9, $00, $10, $04, $05, $FD, $00, $40, $50, $CB, $00, $11
    db $04, $05, $80

; LZSS-compressed asset: 265 bytes expand to 509 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_011_7AF7:: ; heuristic: warp list of the map warp table; C0
    db $FD, $01, $40, $50, $CA, $00, $10, $04, $05, $FD, $00, $40, $50, $CC, $00, $11
    db $04, $05, $80

; LZSS-compressed asset: 274 bytes expand to 509 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_011_7B0A:: ; heuristic: warp list of the map warp table; C0
    db $FD, $01, $40, $50, $CB, $00, $10, $04, $05, $FD, $00, $40, $50, $CD, $00, $11
    db $04, $05, $80

; LZSS-compressed asset: 286 bytes expand to 509 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_011_7B1D:: ; heuristic: warp list of the map warp table; C0
    db $FD, $01, $40, $50, $CC, $00, $10, $04, $05, $FD, $00, $40, $50, $CE, $00, $11
    db $04, $05, $80

; LZSS-compressed asset: 315 bytes expand to 509 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_011_7B30:: ; heuristic: warp list of the map warp table; C0
    db $FD, $01, $40, $50, $CD, $00, $10, $04, $05, $80

Data_011_7B3A:: ; heuristic: warp list of the map warp table; C0
    db $FD, $01, $40, $40, $D2, $00, $31, $04, $08, $80

Data_011_7B44:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $02, $D1, $00, $11, $04, $04, $FD, $00, $40, $50, $D3, $00, $11
    db $04, $05, $80

; LZSS-compressed asset: 325 bytes expand to 509 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_011_7B57:: ; heuristic: warp list of the map warp table; C0
    db $FD, $01, $40, $50, $D2, $00, $10, $04, $05, $FD, $00, $40, $50, $D4, $00, $11
    db $04, $05, $80

; LZSS-compressed asset: 334 bytes expand to 509 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_011_7B6A:: ; heuristic: warp list of the map warp table; C0
    db $FD, $01, $40, $50, $D3, $00, $10, $04, $05, $FD, $00, $40, $50, $D5, $00, $11
    db $04, $05, $80

; LZSS-compressed asset: 345 bytes expand to 509 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_011_7B7D:: ; heuristic: warp list of the map warp table; C0
    db $FD, $01, $40, $50, $D4, $00, $10, $04, $05, $FD, $00, $40, $50, $D6, $00, $11
    db $04, $05, $80

; LZSS-compressed asset: 358 bytes expand to 509 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_011_7B90:: ; heuristic: warp list of the map warp table; C0
    db $FD, $01, $40, $50, $D5, $00, $10, $04, $05, $FD, $00, $40, $50, $D7, $00, $11
    db $04, $05, $80

; LZSS-compressed asset: 373 bytes expand to 509 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_011_7BA3:: ; heuristic: warp list of the map warp table; C0
    db $FD, $01, $40, $50, $D6, $00, $10, $04, $05, $80

Data_011_7BAD:: ; heuristic: warp list of the map warp table; C0
    db $FD, $10, $40, $40, $DB, $00, $31, $04, $08, $80

Data_011_7BB7:: ; heuristic: warp list of the map warp table; C0
    db $FE, $00, $00, $02, $DA, $01, $10, $04, $04, $FD, $00, $40, $50, $DC, $00, $11
    db $04, $05, $80

; LZSS-compressed asset: 410 bytes expand to 509 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_011_7BCA:: ; heuristic: warp list of the map warp table; C0
    db $FD, $01, $40, $50, $DB, $00, $10, $04, $05, $FD, $00, $40, $50, $DD, $00, $11
    db $04, $05, $80

; LZSS-compressed asset: 437 bytes expand to 509 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_011_7BDD:: ; heuristic: warp list of the map warp table; C0
    db $FD, $01, $40, $50, $DC, $00, $10, $04, $05, $FD, $00, $40, $50, $DE, $00, $11
    db $04, $05, $80

; LZSS-compressed asset: 466 bytes expand to 509 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_011_7BF0:: ; heuristic: warp list of the map warp table; C0
    db $FD, $01, $40, $50, $DD, $00, $10, $04, $05, $FD, $00, $40, $50, $DF, $00, $11
    db $04, $05, $80

; LZSS-compressed asset: 496 bytes expand to 509 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_011_7C03:: ; heuristic: warp list of the map warp table; C0
    db $FD, $01, $40, $50, $DE, $00, $10, $04, $05, $FD, $00, $40, $50, $E0, $00, $11
    db $04, $05, $80

; LZSS-compressed asset: 512 bytes expand to 509 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_011_7C16:: ; heuristic: warp list of the map warp table; C0
    db $FD, $01, $40, $50, $DF, $00, $10, $04, $05, $80
    ds $3E0, $00
