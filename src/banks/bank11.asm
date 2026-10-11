SECTION "Bank 11", ROMX[$4000], BANK[$11]
    db $11, $C9

; unless a special mode is set (wCC44 bit 7 hands over to Func_061_5764): walks the warp list MapWarpTable[hMapId]; an entry matching hPlayerFacing, the player's position and its screen nibbles starts a map change: wCCEA = 1, sound effect $60 is queued, and the entry's new hMapId, hFF8F, hFF92 and position (wC8C8/wC8C9) are stored
; 6 call sites from 1 routine (e.g. UpdatePlayerMovement)
; reads: wMapType, hMapId, hPlayerFacing, hMapScreenX, hMapScreenY, hPlayerX, hPlayerY, wWarpDestFacing, ...
; writes: wWarpDestFacing, wWarpPending, hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, hPlayerStateFlags, ...
; points at: wFieldInitStage
CheckWarpAtPlayer::
Func_011_4002:: ; address name
    ld a, [wMapType]
    bit 7, a
    jr z, Jump_011_4010
    farcall CheckWarpAtPlayer_Sub01
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
    ld [wWarpDestFacing], a
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
    ld [wWarpDestFacing], a
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
    ld [wWarpPending], a
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
    ld a, [wWarpDestFacing]
    cp a, $FF
    jr z, Jump_011_40D2
    ld a, [de]
    inc de
    swap a
    and a, $F0
    ld [wWarpDestX], a
    ld a, [de]
    swap a
    and a, $F0
    ld [wWarpDestY], a
    dec de
    dec de
    dec de
    ld a, [de]
    bit 7, a
    jr z, Jump_011_40F9
    ldh a, [hPlayerStateFlags]
    or a, $40
    ldh [hPlayerStateFlags], a
    ld a, [wWarpDestY]
    add a, $08
    ld [wWarpDestY], a
    jr Jump_011_40F9

Jump_011_40D2::
    ld a, [de]
    inc de
    ld c, a
    ldh a, [hPlayerX]
    add a, c
    ld [wWarpDestX], a
    ld a, [de]
    ld c, a
    ldh a, [hPlayerY]
    add a, c
    ld [wWarpDestY], a
    dec de
    dec de
    dec de
    ld a, [de]
    bit 7, a
    jr z, Jump_011_40F9
    ldh a, [hPlayerStateFlags]
    or a, $40
    ldh [hPlayerStateFlags], a
    ld a, [wWarpDestY]
    add a, $08
    ld [wWarpDestY], a

Jump_011_40F9::
    ld a, [de]
    swap a
    and a, $03
    cp a, $03
    jr z, Jump_011_4105
    ld [wLastWarpIndex], a

Jump_011_4105::
    inc de
    ld a, [de]
    swap a
    and a, $0F
    ld [wFieldTransitionKind], a
    ld a, $04
    call StartPaletteFade
    ld hl, wFieldInitStage
    inc [hl]
    ld a, $04
    ld [wModeState], a
    xor a, a
    ld [wFieldTransitionStep], a
    ldh a, [hPlayerStateFlags]
    or a, $80
    ldh [hPlayerStateFlags], a
    farcall ClearWC935IfBit7AndNot6
    pop de
    ld c, $01
    ret

; special maps use RunWCC44Type_596F; otherwise checks the map exit table, then the warp list Data_011_67A6[hMapId] against the player position and warps on a match (E-0131)
; 3 call sites from 3 routines (e.g. FieldModeStateDispatch_Case07, UpdatePlayerMovement_Sub01, RunWC468ActionIfBit7_Case03)
; reads: wMapType, hMapId, hPlayerStateFlags, hMapScreenX, hMapScreenY, hPlayerX, hPlayerY, wWarpDestY
; writes: hPlayerStateFlags, wWarpDestFacing, wWarpPending, hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, ...
; points at: wFieldInitStage
CheckWarpsAtPlayerPosition::
Func_011_4130:: ; address name
    ld a, [wMapType]
    bit 7, a
    jr z, Jump_011_413E
    farcall RunWCC44Type_596F
    ret

Jump_011_413E::
    call CheckMapExitTable4480
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
    ldh a, [hPlayerStateFlags]
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
    ldh a, [hPlayerStateFlags]
    and a, $7F
    ldh [hPlayerStateFlags], a

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
    ld [wWarpDestFacing], a
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
    ldh a, [hPlayerStateFlags]
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
    ld [wWarpPending], a
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
    ld [wWarpDestX], a
    ld a, [de]
    swap a
    and a, $F0
    ld [wWarpDestY], a
    dec de
    dec de
    dec de
    ld a, [de]
    bit 7, a
    jr z, Jump_011_4229
    ldh a, [hPlayerStateFlags]
    or a, $40
    ldh [hPlayerStateFlags], a
    ld a, [wWarpDestY]
    add a, $08
    ld [wWarpDestY], a
    jr Jump_011_4229

Jump_011_4229::
    ld a, [de]
    swap a
    and a, $03
    cp a, $03
    jr z, Jump_011_4235
    ld [wLastWarpIndex], a

Jump_011_4235::
    inc de
    ld a, [de]
    swap a
    and a, $0F
    ld [wFieldTransitionKind], a
    ld a, $04
    call StartPaletteFade
    ld hl, wFieldInitStage
    inc [hl]
    xor a, a
    ld [wFieldReturnPhase], a
    ld a, $04
    ld [wModeState], a
    xor a, a
    ld [wFieldTransitionStep], a
    ldh a, [hPlayerStateFlags]
    or a, $80
    ldh [hPlayerStateFlags], a
    farcall ClearWC935IfBit7AndNot6
    pop de
    xor a, a
    ld [wJoypadPressed], a
    ld c, $01
    ret

; unless bit 7 of wCC44 is set, looks hMapId up in Data_011_42AC; when listed, sets the linked map from Data_011_42B8 and warps (using wC88F when wC891 selects it), C = 1; otherwise C = 0 (E-0125)
; 2 call sites from 2 routines (e.g. UpdatePlayerMovement, CallF4268OnScreenY1)
; reads: wMapType, hMapId, wKeyWorldActive, wKeyWorldKey, wKeyWorldSlot, wKeyWorldGoal, wKeyWorldGoalCell, wKeyWorldGoalPos, ...
; writes: hMapId, wWarpDestX, wWarpDestY, hMapScreenX, hMapScreenY
; points at: wKeyWorldGoal
WarpToLinkedMapForCurrentMap::
Func_011_4268:: ; address name
    ld a, [wMapType]
    bit 7, a
    jp nz, Jump_011_42D9
    ldh a, [hMapId]
    ld c, a
    ld b, $00
    ld hl, Data_011_42AC

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
    ld a, [wKeyWorldActive]
    or a, a
    jr z, Jump_011_42A6
    ld a, [wKeyWorldKey]
    dec a
    cp a, b
    jr nz, Jump_011_42A6
    ld de, wKeyWorldGoal

Jump_011_42A6::
    call ScriptWarpToMapFromBytesAtDE
    ld c, $01
    ret

Data_011_42AC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $29, $45, $68, $9D, $A4, $AF, $B2, $C5, $D0, $D9, $E2, $FF

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
    ld a, [wKeyWorldActive]
    or a, a
    jr z, Jump_011_431E
    ld a, [wKeyWorldKey]
    bit 7, a
    jr z, Jump_011_431E
    and a, $7F
    ld c, a
    ld a, [wKeyWorldSlot]
    cp a, c
    jr nz, Jump_011_431E
    ld a, [wKeyWorldGoal]
    and a, $F0
    ld [wWarpDestX], a
    ld a, [wKeyWorldGoal]
    and a, $0F
    swap a
    ld [wWarpDestY], a
    ld a, [wKeyWorldGoalCell]
    and a, $F0
    swap a
    ldh [hMapScreenX], a
    ld a, [wKeyWorldGoalCell]
    and a, $0F
    ldh [hMapScreenY], a
    call StartWarpTransition
    ld c, $01
    ret

Jump_011_431E::
    ld a, [wKeyWorldGoalPos]
    ld [wWarpDestX], a
    ld a, [wKeyWorldGoalPos2]
    ld [wWarpDestY], a
    ld a, [wKeyWorldGoalScreen]
    and a, $F0
    swap a
    ldh [hMapScreenX], a
    ld a, [wKeyWorldGoalScreen]
    and a, $0F
    ldh [hMapScreenY], a
    call StartWarpTransition
    ld c, $01
    ret

; script command: plays sound $60 and reads a warp destination at DE (wC8C8/9 from the nibbles of byte 0, hMapScreenX/Y from byte 1), starts palette fade 4, wC5E0 += 1, wModeState = 4, updates hFF8C and returns C = 1 (E-0121)
; 1 call site from 1 routine (e.g. WarpToLinkedMapForCurrentMap)
; reads: hPlayerStateFlags
; writes: wWarpPending, wWarpDestX, wWarpDestY, hMapScreenX, hMapScreenY, wFieldTransitionKind, wModeState, wFieldTransitionStep, ...
; points at: wFieldInitStage
ScriptWarpToMapFromBytesAtDE::
Func_011_4340:: ; address name
    ld a, $01
    ld [wWarpPending], a
    ld a, $60
    call QueueSoundEffect
    ld a, [de]
    and a, $F0
    ld [wWarpDestX], a
    ld a, [de]
    swap a
    and a, $F0
    ld [wWarpDestY], a
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
    ld [wFieldTransitionKind], a
    ld a, $04
    call StartPaletteFade
    ld hl, wFieldInitStage
    inc [hl]
    ld a, $04
    ld [wModeState], a
    xor a, a
    ld [wFieldTransitionStep], a
    ldh a, [hPlayerStateFlags]
    or a, $20
    and a, $7F
    ldh [hPlayerStateFlags], a
    farcall ClearWC935IfBit7AndNot6
    pop de
    ld c, $01
    ret

; wC8CA = $F0, plays sound $60, starts palette fade 4, wModeState = 4, clears wC8C5, updates hFF8C and sets wC8C6 = 1 (E-0124)
; 2 call sites from 1 routine (e.g. WarpToLinkedMapForCurrentMap)
; reads: hPlayerStateFlags
; writes: wWarpDestFacing, wModeState, wFieldTransitionStep, hPlayerStateFlags, wFieldTransitionKind
StartWarpTransition::
Func_011_438F:: ; address name
    ld a, $F0
    ld [wWarpDestFacing], a
    ld a, $60
    call QueueSoundEffect
    ld a, $04
    call StartPaletteFade
    ld a, $04
    ld [wModeState], a
    xor a, a
    ld [wFieldTransitionStep], a
    ldh a, [hPlayerStateFlags]
    or a, $20
    and a, $7F
    ldh [hPlayerStateFlags], a
    ldh a, [hPlayerStateFlags]
    and a, $FE
    ldh [hPlayerStateFlags], a
    ld a, $01
    ld [wFieldTransitionKind], a
    ret

; for maps from $20 looks hMapId up in the 4-byte table Data_011_4480 and runs Func_011_43FA with its entry (or wC88F); unlisted maps clear bit 5 of hFF8C and return C = 0 (E-0125)
; 1 call site from 1 routine (e.g. CheckWarpsAtPlayerPosition)
; reads: hMapId, hPlayerStateFlags, wKeyWorldActive, wKeyWorldKey
; writes: hPlayerStateFlags
; points at: wKeyWorldGoal
CheckMapExitTable4480::
Func_011_43BB:: ; address name
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
    ldh a, [hPlayerStateFlags]
    and a, $DF
    ldh [hPlayerStateFlags], a
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
    ld a, [wKeyWorldActive]
    or a, a
    jr z, Jump_011_43F3
    ld a, [wKeyWorldKey]
    dec a
    cp a, b
    jr nz, Jump_011_43F3
    ld de, wKeyWorldGoal
    call CheckMapExitTable4480_Sub01
    ret

Jump_011_43F3::
    ld e, l
    ld d, h
    inc de
    call CheckMapExitTable4480_Sub01
    ret

; only called from CheckMapExitTable4480 (E-0047)
; 2 call sites from 1 routine (e.g. CheckMapExitTable4480)
; reads: hPlayerX, hPlayerY, hMapScreenX, hMapScreenY, hPlayerStateFlags
; writes: wWarpPending, hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wLastWarpIndex, wFieldTransitionKind, ...
; points at: wFieldInitStage
CheckMapExitTable4480_Sub01::
Func_011_43FA:: ; address name
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
    ldh a, [hPlayerStateFlags]
    bit 5, a
    jr z, Jump_011_442B
    ld c, $00
    ret

Jump_011_4422::
    ldh a, [hPlayerStateFlags]
    and a, $DF
    ldh [hPlayerStateFlags], a
    ld c, $00
    ret

Jump_011_442B::
    ld a, $01
    ld [wWarpPending], a
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
    ld [wWarpDestX], a
    ld a, $80
    ld [wWarpDestY], a
    xor a, a
    ld [wLastWarpIndex], a
    ld a, $03
    ld [wFieldTransitionKind], a
    ld a, $04
    call StartPaletteFade
    ld hl, wFieldInitStage
    inc [hl]
    xor a, a
    ld [wFieldReturnPhase], a
    ld a, $04
    ld [wModeState], a
    xor a, a
    ld [wFieldTransitionStep], a
    ldh a, [hPlayerStateFlags]
    or a, $20
    ldh [hPlayerStateFlags], a
    farcall ClearWC935IfBit7AndNot6
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
    dw MapRecord00 ; entry 0
    dw MapRecord01 ; entry 1
    dw MapRecord02 ; entry 2
    dw MapRecord03 ; entry 3
    dw MapRecord04 ; entry 4
    dw MapRecord05 ; entry 5
    dw MapRecord06 ; entry 6
    dw MapRecord07 ; entry 7
    dw MapRecord08 ; entry 8
    dw MapRecord09 ; entry 9
    dw MapRecord0A ; entry 10
    dw MapRecord0B ; entry 11
    dw MapRecord0C ; entry 12
    dw MapRecord0D ; entry 13
    dw MapRecord0E ; entry 14
    dw MapRecord0F ; entry 15
    dw MapRecord10 ; entry 16
    dw MapRecord11 ; entry 17
    dw MapRecord12 ; entry 18
    dw MapRecord13 ; entry 19
    dw MapRecord14 ; entry 20
    dw MapRecord15 ; entry 21
    dw MapRecord16 ; entry 22
    dw MapRecord17 ; entry 23
    dw MapRecord18 ; entry 24
    dw MapRecord19 ; entry 25
    dw MapRecord1A ; entry 26
    dw MapRecord1B ; entry 27
    dw MapRecord1C ; entry 28
    dw MapRecord1D ; entry 29
    dw $0000 ; entry 30
    dw $0000 ; entry 31
    dw MapRecord20 ; entry 32
    dw MapRecord21 ; entry 33
    dw MapRecord22 ; entry 34
    dw MapRecord23 ; entry 35
    dw MapRecord24 ; entry 36
    dw MapRecord25 ; entry 37
    dw MapRecord26 ; entry 38
    dw $0000 ; entry 39
    dw MapRecord28 ; entry 40
    dw MapRecord29 ; entry 41
    dw MapRecord2A ; entry 42
    dw MapRecord2B ; entry 43
    dw $0000 ; entry 44
    dw MapRecord2D ; entry 45
    dw MapRecord2E ; entry 46
    dw MapRecord2F ; entry 47
    dw MapRecord30 ; entry 48
    dw MapRecord31 ; entry 49
    dw MapRecord32 ; entry 50
    dw MapRecord33 ; entry 51
    dw MapRecord34 ; entry 52
    dw MapRecord35 ; entry 53
    dw MapRecord36 ; entry 54
    dw MapRecord37 ; entry 55
    dw MapRecord38 ; entry 56
    dw MapRecord39 ; entry 57
    dw MapRecord3A ; entry 58
    dw MapRecord3B ; entry 59
    dw MapRecord3C ; entry 60
    dw MapRecord3D ; entry 61
    dw MapRecord3E ; entry 62
    dw MapRecord3F ; entry 63
    dw MapRecord40 ; entry 64
    dw MapRecord41 ; entry 65
    dw MapRecord42 ; entry 66
    dw MapRecord43 ; entry 67
    dw MapRecord44 ; entry 68
    dw MapRecord29 ; entry 69
    dw $0000 ; entry 70
    dw $0000 ; entry 71
    dw MapRecord48 ; entry 72
    dw MapRecord49 ; entry 73
    dw MapRecord4A ; entry 74
    dw MapRecord4B ; entry 75
    dw MapRecord4C ; entry 76
    dw MapRecord4D ; entry 77
    dw MapRecord4E ; entry 78
    dw MapRecord4F ; entry 79
    dw MapRecord50 ; entry 80
    dw MapRecord51 ; entry 81
    dw MapRecord52 ; entry 82
    dw MapRecord53 ; entry 83
    dw MapRecord54 ; entry 84
    dw MapRecord55 ; entry 85
    dw MapRecord56 ; entry 86
    dw MapRecord57 ; entry 87
    dw MapRecord58 ; entry 88
    dw MapRecord59 ; entry 89
    dw MapRecord5A ; entry 90
    dw MapRecord5B ; entry 91
    dw MapRecord5C ; entry 92
    dw MapRecord5D ; entry 93
    dw MapRecord5E ; entry 94
    dw MapRecord5F ; entry 95
    dw MapRecord60 ; entry 96
    dw MapRecord61 ; entry 97
    dw MapRecord62 ; entry 98
    dw MapRecord63 ; entry 99
    dw MapRecord64 ; entry 100
    dw MapRecord65 ; entry 101
    dw MapRecord66 ; entry 102
    dw MapRecord67 ; entry 103
    dw MapRecord29 ; entry 104
    dw $0000 ; entry 105
    dw $0000 ; entry 106
    dw $0000 ; entry 107
    dw $0000 ; entry 108
    dw $0000 ; entry 109
    dw $0000 ; entry 110
    dw $0000 ; entry 111
    dw MapRecord70 ; entry 112
    dw MapRecord71 ; entry 113
    dw MapRecord72 ; entry 114
    dw MapRecord73 ; entry 115
    dw MapRecord74 ; entry 116
    dw MapRecord75 ; entry 117
    dw MapRecord76 ; entry 118
    dw MapRecord77 ; entry 119
    dw MapRecord78 ; entry 120
    dw MapRecord79 ; entry 121
    dw MapRecord7A ; entry 122
    dw MapRecord7B ; entry 123
    dw MapRecord7C ; entry 124
    dw MapRecord7D ; entry 125
    dw MapRecord7E ; entry 126
    dw MapRecord7F ; entry 127
    dw MapRecord80 ; entry 128
    dw MapRecord81 ; entry 129
    dw MapRecord82 ; entry 130
    dw MapRecord83 ; entry 131
    dw MapRecord84 ; entry 132
    dw MapRecord85 ; entry 133
    dw MapRecord86 ; entry 134
    dw MapRecord87 ; entry 135
    dw MapRecord88 ; entry 136
    dw MapRecord89 ; entry 137
    dw MapRecord8A ; entry 138
    dw MapRecord8B ; entry 139
    dw MapRecord8C ; entry 140
    dw MapRecord8D ; entry 141
    dw MapRecord8E ; entry 142
    dw MapRecord8F ; entry 143
    dw MapRecord90 ; entry 144
    dw MapRecord91 ; entry 145
    dw MapRecord92 ; entry 146
    dw MapRecord93 ; entry 147
    dw MapRecord94 ; entry 148
    dw MapRecord95 ; entry 149
    dw MapRecord96 ; entry 150
    dw MapRecord97 ; entry 151
    dw MapRecord98 ; entry 152
    dw MapRecord99 ; entry 153
    dw MapRecord9A ; entry 154
    dw MapRecord9B ; entry 155
    dw $0000 ; entry 156
    dw MapRecord29 ; entry 157
    dw $0000 ; entry 158
    dw $0000 ; entry 159
    dw MapRecordA0 ; entry 160
    dw MapRecordA1 ; entry 161
    dw MapRecordA2 ; entry 162
    dw MapRecordA3 ; entry 163
    dw MapRecord29 ; entry 164
    dw $0000 ; entry 165
    dw $0000 ; entry 166
    dw $0000 ; entry 167
    dw MapRecordA8 ; entry 168
    dw MapRecordA9 ; entry 169
    dw MapRecordAA ; entry 170
    dw MapRecordAB ; entry 171
    dw MapRecordAC ; entry 172
    dw MapRecordAD ; entry 173
    dw MapRecordAE ; entry 174
    dw MapRecord29 ; entry 175
    dw MapRecordB0 ; entry 176
    dw MapRecordB1 ; entry 177
    dw MapRecord29 ; entry 178
    dw MapRecordB3 ; entry 179
    dw MapRecordB4 ; entry 180
    dw MapRecordB5 ; entry 181
    dw MapRecordB6 ; entry 182
    dw $0000 ; entry 183
    dw MapRecordB8 ; entry 184
    dw MapRecordB9 ; entry 185
    dw MapRecordBA ; entry 186
    dw MapRecordBB ; entry 187
    dw MapRecordBC ; entry 188
    dw MapRecordBD ; entry 189
    dw MapRecordBE ; entry 190
    dw MapRecordBF ; entry 191
    dw MapRecordC0 ; entry 192
    dw MapRecordC1 ; entry 193
    dw MapRecordC2 ; entry 194
    dw MapRecordC3 ; entry 195
    dw MapRecordC4 ; entry 196
    dw MapRecord29 ; entry 197
    dw $0000 ; entry 198
    dw $0000 ; entry 199
    dw MapRecordC8 ; entry 200
    dw MapRecordC9 ; entry 201
    dw MapRecordCA ; entry 202
    dw MapRecordCA ; entry 203
    dw MapRecordCA ; entry 204
    dw MapRecordCA ; entry 205
    dw MapRecordCE ; entry 206
    dw $0000 ; entry 207
    dw MapRecord29 ; entry 208
    dw MapRecordD1 ; entry 209
    dw MapRecordD2 ; entry 210
    dw MapRecordD3 ; entry 211
    dw MapRecordD3 ; entry 212
    dw MapRecordD3 ; entry 213
    dw MapRecordD3 ; entry 214
    dw MapRecordD7 ; entry 215
    dw $0000 ; entry 216
    dw MapRecord29 ; entry 217
    dw MapRecordDA ; entry 218
    dw MapRecordDB ; entry 219
    dw MapRecordDC ; entry 220
    dw MapRecordDC ; entry 221
    dw MapRecordDC ; entry 222
    dw MapRecordDC ; entry 223
    dw MapRecordE0 ; entry 224
    dw $0000 ; entry 225
    dw MapRecord29 ; entry 226
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

; E-0142 (derived: map record of map $00, 3 x 4 screens, 8 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord00::
Data_011_46B8:: ; heuristic: map record of the map table; C0
    dfar AreaTileset0 ; entry 0
    dfar AreaPalettes0
    db $03, $04, $4E, $00, $01, $00, $00, $01, $10, $00
    dw wStoryFlags + $60
    dfar Map00Screens0
    dfar Map00Attrs0
    dfar Map00Screens0
    dfar Map00Attrs0
    dfar Map00Screens2
    dfar Map00Attrs2
    dfar Map00Screens3
    dfar Map00Attrs3
    dfar Map00Screens4
    dfar Map00Attrs4
    dfar Map00Screens5
    dfar Map00Attrs5
    dfar Map00Screens6
    dfar Map00Attrs6
    dfar Map00Screens6
    dfar Map00Attrs6

; E-0142 (derived: map record of map $01, 4 x 3 screens, 8 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord01::
Data_011_46FA:: ; heuristic: map record of the map table; C0
    dfar Map01Tileset ; entry 0
    dfar Map01Palettes
    db $04, $03, $4F, $00, $01, $00, $00, $01, $0D, $00
    dw wStoryFlags + $60
    dfar Map01Screens0
    dfar Map01Attrs0
    dfar Map01Screens0
    dfar Map01Attrs0
    dfar Map01Screens0
    dfar Map01Attrs0
    dfar Map01Screens3
    dfar Map01Attrs3
    dfar Map01Screens4
    dfar Map01Attrs4
    dfar Map01Screens5
    dfar Map01Attrs5
    dfar Map01Screens6
    dfar Map01Attrs6
    dfar Map01Screens6
    dfar Map01Attrs6

; E-0142 (derived: map record of map $02, 3 x 1 screens, 8 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord02::
Data_011_473C:: ; heuristic: map record of the map table; C0
    dfar Map02Tileset ; entry 0
    dfar Map02Palettes
    db $03, $01, $31, $00, $01, $00, $00, $01, $0D, $00
    dw wStoryFlags + $60
    dfar Map02Screens0
    dfar Map02Attrs0
    dfar Map02Screens1
    dfar Map02Attrs1
    dfar Map02Screens1
    dfar Map02Attrs1
    dfar Map02Screens3
    dfar Map02Attrs3
    dfar Map02Screens4
    dfar Map02Attrs4
    dfar Map02Screens5
    dfar Map02Attrs5
    dfar Map02Screens6
    dfar Map02Attrs6
    dfar Map02Screens6
    dfar Map02Attrs6

; E-0142 (derived: map record of map $03, 1 x 1 screens, 8 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord03::
Data_011_477E:: ; heuristic: map record of the map table; C0
    dfar Map03Tileset ; entry 0
    dfar Map03Palettes
    db $01, $01, $2F, $2C, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $60
    dfar Map03Screens0
    dfar Map03Attrs0
    dfar Map03Screens0
    dfar Map03Attrs0
    dfar Map03Screens0
    dfar Map03Attrs0
    dfar Map03Screens0
    dfar Map03Attrs0
    dfar Map03Screens0
    dfar Map03Attrs0
    dfar Map03Screens0
    dfar Map03Attrs0
    dfar Map03Screens0
    dfar Map03Attrs0
    dfar Map03Screens0
    dfar Map03Attrs0

; E-0142 (derived: map record of map $04, 3 x 1 screens, 8 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord04::
Data_011_47C0:: ; heuristic: map record of the map table; C0
    dfar Map04Tileset ; entry 0
    dfar Map04Palettes
    db $03, $01, $2E, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $60
    dfar Map04Screens0
    dfar Map04Attrs0
    dfar Map04Screens0
    dfar Map04Attrs0
    dfar Map04Screens0
    dfar Map04Attrs0
    dfar Map04Screens0
    dfar Map04Attrs0
    dfar Map04Screens0
    dfar Map04Attrs0
    dfar Map04Screens0
    dfar Map04Attrs0
    dfar Map04Screens0
    dfar Map04Attrs0
    dfar Map04Screens0
    dfar Map04Attrs0

; E-0142 (derived: map record of map $05, 3 x 1 screens, 8 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord05::
Data_011_4802:: ; heuristic: map record of the map table; C0
    dfar Map05Tileset ; entry 0
    dfar Map05Palettes
    db $03, $01, $67, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $60
    dfar Map05Screens0
    dfar Map05Attrs0
    dfar Map05Screens0
    dfar Map05Attrs0
    dfar Map05Screens0
    dfar Map05Attrs0
    dfar Map05Screens0
    dfar Map05Attrs0
    dfar Map05Screens0
    dfar Map05Attrs0
    dfar Map05Screens0
    dfar Map05Attrs0
    dfar Map05Screens0
    dfar Map05Attrs0
    dfar Map05Screens7
    dfar Map05Attrs7

; E-0142 (derived: map record of map $06, 1 x 1 screens, 8 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord06::
Data_011_4844:: ; heuristic: map record of the map table; C0
    dfar Map06Tileset ; entry 0
    dfar Map06Palettes
    db $01, $01, $33, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $60
    dfar Map06Screens0
    dfar Map06Attrs0
    dfar Map06Screens0
    dfar Map06Attrs0
    dfar Map06Screens0
    dfar Map06Attrs0
    dfar Map06Screens0
    dfar Map06Attrs0
    dfar Map06Screens0
    dfar Map06Attrs0
    dfar Map06Screens0
    dfar Map06Attrs0
    dfar Map06Screens0
    dfar Map06Attrs0
    dfar Map06Screens0
    dfar Map06Attrs0

; E-0142 (derived: map record of map $07, 1 x 2 screens, 8 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord07::
Data_011_4886:: ; heuristic: map record of the map table; C0
    dfar AreaTileset1 ; entry 0
    dfar AreaPalettes1
    db $01, $02, $3F, $00, $01, $00, $00, $00, $00, $00
    dw wStoryFlags + $60
    dfar Map07Screens0
    dfar Map07Attrs0
    dfar Map07Screens0
    dfar Map07Attrs0
    dfar Map07Screens0
    dfar Map07Attrs0
    dfar Map07Screens0
    dfar Map07Attrs0
    dfar Map07Screens0
    dfar Map07Attrs0
    dfar Map07Screens0
    dfar Map07Attrs0
    dfar Map07Screens0
    dfar Map07Attrs0
    dfar Map07Screens7
    dfar Map07Attrs7

; E-0142 (derived: map record of map $09, 1 x 1 screens, 8 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord09::
Data_011_48C8:: ; heuristic: map record of the map table; C0
    dfar Map09Tileset ; entry 0
    dfar Map09Palettes
    db $01, $01, $24, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $60
    dfar Map09Screens0
    dfar Map09Attrs0
    dfar Map09Screens0
    dfar Map09Attrs0
    dfar Map09Screens0
    dfar Map09Attrs0
    dfar Map09Screens0
    dfar Map09Attrs0
    dfar Map09Screens0
    dfar Map09Attrs0
    dfar Map09Screens0
    dfar Map09Attrs0
    dfar Map09Screens0
    dfar Map09Attrs0
    dfar Map09Screens0
    dfar Map09Attrs0

; E-0142 (derived: map record of map $08, 1 x 1 screens, 8 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord08::
Data_011_490A:: ; heuristic: map record of the map table; C0
    dfar Map08Tileset ; entry 0
    dfar Map08Palettes
    db $01, $01, $24, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $60
    dfar Map08Screens0
    dfar Map08Attrs0
    dfar Map08Screens0
    dfar Map08Attrs0
    dfar Map08Screens0
    dfar Map08Attrs0
    dfar Map08Screens0
    dfar Map08Attrs0
    dfar Map08Screens0
    dfar Map08Attrs0
    dfar Map08Screens0
    dfar Map08Attrs0
    dfar Map08Screens0
    dfar Map08Attrs0
    dfar Map08Screens0
    dfar Map08Attrs0

; E-0142 (derived: map record of map $0A, 1 x 1 screens, 8 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord0A::
Data_011_494C:: ; heuristic: map record of the map table; C0
    dfar Map0ATileset ; entry 0
    dfar Map0APalettes
    db $01, $01, $2A, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $60
    dfar Map0AScreens0
    dfar Map0AAttrs0
    dfar Map0AScreens0
    dfar Map0AAttrs0
    dfar Map0AScreens0
    dfar Map0AAttrs0
    dfar Map0AScreens0
    dfar Map0AAttrs0
    dfar Map0AScreens0
    dfar Map0AAttrs0
    dfar Map0AScreens0
    dfar Map0AAttrs0
    dfar Map0AScreens0
    dfar Map0AAttrs0
    dfar Map0AScreens0
    dfar Map0AAttrs0

; E-0142 (derived: map record of map $0B, 1 x 1 screens, 8 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord0B::
Data_011_498E:: ; heuristic: map record of the map table; C0
    dfar Map0BTileset ; entry 0
    dfar Map0BPalettes
    db $01, $01, $00, $00, $07, $00, $00, $00, $00, $00
    dw wStoryFlags + $60
    dfar Map0BScreens0
    dfar Map0BAttrs0
    dfar Map0BScreens0
    dfar Map0BAttrs0
    dfar Map0BScreens0
    dfar Map0BAttrs0
    dfar Map0BScreens0
    dfar Map0BAttrs0
    dfar Map0BScreens0
    dfar Map0BAttrs0
    dfar Map0BScreens0
    dfar Map0BAttrs0
    dfar Map0BScreens0
    dfar Map0BAttrs0
    dfar Map0BScreens0
    dfar Map0BAttrs0

; E-0142 (derived: map record of map $0C, 2 x 1 screens, 8 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord0C::
Data_011_49D0:: ; heuristic: map record of the map table; C0
    dfar Map0CTileset ; entry 0
    dfar Map0CPalettes
    db $02, $01, $2F, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $60
    dfar Map0CScreens0
    dfar Map0CAttrs0
    dfar Map0CScreens0
    dfar Map0CAttrs0
    dfar Map0CScreens0
    dfar Map0CAttrs0
    dfar Map0CScreens0
    dfar Map0CAttrs0
    dfar Map0CScreens0
    dfar Map0CAttrs0
    dfar Map0CScreens0
    dfar Map0CAttrs0
    dfar Map0CScreens0
    dfar Map0CAttrs0
    dfar Map0CScreens0
    dfar Map0CAttrs0

; E-0142 (derived: map record of map $0D, 4 x 2 screens, 8 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord0D::
Data_011_4A12:: ; heuristic: map record of the map table; C0
    dfar Map0DTileset ; entry 0
    dfar Map0DPalettes
    db $04, $02, $3F, $00, $0F, $00, $00, $00, $00, $00
    dw wStoryFlags + $60
    dfar Map0DScreens0
    dfar Map0DAttrs0
    dfar Map0DScreens0
    dfar Map0DAttrs0
    dfar Map0DScreens0
    dfar Map0DAttrs0
    dfar Map0DScreens0
    dfar Map0DAttrs0
    dfar Map0DScreens4
    dfar Map0DAttrs4
    dfar Map0DScreens4
    dfar Map0DAttrs4
    dfar Map0DScreens4
    dfar Map0DAttrs4
    dfar Map0DScreens7
    dfar Map0DAttrs7

; E-0142 (derived: map record of map $0E, 1 x 1 screens, 8 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord0E::
Data_011_4A54:: ; heuristic: map record of the map table; C0
    dfar Map0ETileset ; entry 0
    dfar Map0EPalettes
    db $01, $01, $2F, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $60
    dfar Map0EScreens0
    dfar Map0EAttrs0
    dfar Map0EScreens0
    dfar Map0EAttrs0
    dfar Map0EScreens0
    dfar Map0EAttrs0
    dfar Map0EScreens0
    dfar Map0EAttrs0
    dfar Map0EScreens0
    dfar Map0EAttrs0
    dfar Map0EScreens0
    dfar Map0EAttrs0
    dfar Map0EScreens0
    dfar Map0EAttrs0
    dfar Map0EScreens0
    dfar Map0EAttrs0

; E-0142 (derived: map record of map $0F, 1 x 1 screens, 8 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord0F::
Data_011_4A96:: ; heuristic: map record of the map table; C0
    dfar Map0FTileset ; entry 0
    dfar Map0FPalettes
    db $01, $01, $50, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $60
    dfar Map0FScreens0
    dfar Map0FAttrs0
    dfar Map0FScreens0
    dfar Map0FAttrs0
    dfar Map0FScreens0
    dfar Map0FAttrs0
    dfar Map0FScreens0
    dfar Map0FAttrs0
    dfar Map0FScreens0
    dfar Map0FAttrs0
    dfar Map0FScreens0
    dfar Map0FAttrs0
    dfar Map0FScreens0
    dfar Map0FAttrs0
    dfar Map0FScreens7
    dfar Map0FAttrs7

; E-0142 (derived: map record of map $10, 1 x 1 screens, 8 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord10::
Data_011_4AD8:: ; heuristic: map record of the map table; C0
    dfar Map10Tileset ; entry 0
    dfar Map10Palettes
    db $01, $01, $24, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $60
    dfar Map10Screens0
    dfar Map10Attrs0
    dfar Map10Screens0
    dfar Map10Attrs0
    dfar Map10Screens0
    dfar Map10Attrs0
    dfar Map10Screens0
    dfar Map10Attrs0
    dfar Map10Screens0
    dfar Map10Attrs0
    dfar Map10Screens0
    dfar Map10Attrs0
    dfar Map10Screens0
    dfar Map10Attrs0
    dfar Map10Screens0
    dfar Map10Attrs0

; E-0142 (derived: map record of map $11, 1 x 2 screens, 8 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord11::
Data_011_4B1A:: ; heuristic: map record of the map table; C0
    dfar Map11Tileset ; entry 0
    dfar Map11Palettes
    db $01, $02, $33, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $60
    dfar Map11Screens0
    dfar Map11Attrs0
    dfar Map11Screens0
    dfar Map11Attrs0
    dfar Map11Screens0
    dfar Map11Attrs0
    dfar Map11Screens0
    dfar Map11Attrs0
    dfar Map11Screens0
    dfar Map11Attrs0
    dfar Map11Screens0
    dfar Map11Attrs0
    dfar Map11Screens0
    dfar Map11Attrs0
    dfar Map11Screens0
    dfar Map11Attrs0

; E-0142 (derived: map record of map $12, 1 x 1 screens, 8 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord12::
Data_011_4B5C:: ; heuristic: map record of the map table; C0
    dfar Map12Tileset ; entry 0
    dfar Map12Palettes
    db $01, $01, $2F, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $60
    dfar Map12Screens0
    dfar Map12Attrs0
    dfar Map12Screens0
    dfar Map12Attrs0
    dfar Map12Screens0
    dfar Map12Attrs0
    dfar Map12Screens0
    dfar Map12Attrs0
    dfar Map12Screens0
    dfar Map12Attrs0
    dfar Map12Screens0
    dfar Map12Attrs0
    dfar Map12Screens0
    dfar Map12Attrs0
    dfar Map12Screens0
    dfar Map12Attrs0

; E-0142 (derived: map record of map $13, 1 x 1 screens, 8 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord13::
Data_011_4B9E:: ; heuristic: map record of the map table; C0
    dfar Map13Tileset ; entry 0
    dfar Map13Palettes
    db $01, $01, $27, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $60
    dfar Map13Screens0
    dfar Map13Attrs0
    dfar Map13Screens0
    dfar Map13Attrs0
    dfar Map13Screens0
    dfar Map13Attrs0
    dfar Map13Screens0
    dfar Map13Attrs0
    dfar Map13Screens0
    dfar Map13Attrs0
    dfar Map13Screens0
    dfar Map13Attrs0
    dfar Map13Screens0
    dfar Map13Attrs0
    dfar Map13Screens0
    dfar Map13Attrs0

; E-0142 (derived: map record of map $14, 1 x 1 screens, 8 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord14::
Data_011_4BE0:: ; heuristic: map record of the map table; C0
    dfar Map14Tileset ; entry 0
    dfar Map14Palettes
    db $01, $01, $00, $00, $08, $00, $00, $00, $00, $00
    dw wStoryFlags + $60
    dfar Map14Screens0
    dfar Map14Attrs0
    dfar Map14Screens0
    dfar Map14Attrs0
    dfar Map14Screens0
    dfar Map14Attrs0
    dfar Map14Screens0
    dfar Map14Attrs0
    dfar Map14Screens0
    dfar Map14Attrs0
    dfar Map14Screens0
    dfar Map14Attrs0
    dfar Map14Screens0
    dfar Map14Attrs0
    dfar Map14Screens0
    dfar Map14Attrs0

; E-0142 (derived: map record of map $15, 1 x 1 screens, 8 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord15::
Data_011_4C22:: ; heuristic: map record of the map table; C0
    dfar Map15Tileset ; entry 0
    dfar Map15Palettes
    db $01, $01, $2F, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $60
    dfar Map15Screens0
    dfar Map15Attrs0
    dfar Map15Screens0
    dfar Map15Attrs0
    dfar Map15Screens0
    dfar Map15Attrs0
    dfar Map15Screens0
    dfar Map15Attrs0
    dfar Map15Screens0
    dfar Map15Attrs0
    dfar Map15Screens0
    dfar Map15Attrs0
    dfar Map15Screens0
    dfar Map15Attrs0
    dfar Map15Screens0
    dfar Map15Attrs0

; E-0142 (derived: map record of map $16, 1 x 1 screens, 8 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord16::
Data_011_4C64:: ; heuristic: map record of the map table; C0
    dfar Map16Tileset ; entry 0
    dfar Map16Palettes
    db $01, $01, $2B, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $60
    dfar Map16Screens0
    dfar Map16Attrs0
    dfar Map16Screens0
    dfar Map16Attrs0
    dfar Map16Screens0
    dfar Map16Attrs0
    dfar Map16Screens0
    dfar Map16Attrs0
    dfar Map16Screens0
    dfar Map16Attrs0
    dfar Map16Screens0
    dfar Map16Attrs0
    dfar Map16Screens0
    dfar Map16Attrs0
    dfar Map16Screens0
    dfar Map16Attrs0

; E-0142 (derived: map record of map $17, 1 x 1 screens, 8 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord17::
Data_011_4CA6:: ; heuristic: map record of the map table; C0
    dfar Map17Tileset ; entry 0
    dfar Map17Palettes
    db $01, $01, $3A, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $60
    dfar Map17Screens0
    dfar Map17Attrs0
    dfar Map17Screens0
    dfar Map17Attrs0
    dfar Map17Screens0
    dfar Map17Attrs0
    dfar Map17Screens0
    dfar Map17Attrs0
    dfar Map17Screens0
    dfar Map17Attrs0
    dfar Map17Screens0
    dfar Map17Attrs0
    dfar Map17Screens0
    dfar Map17Attrs0
    dfar Map17Screens0
    dfar Map17Attrs0

; E-0142 (derived: map record of map $18, 3 x 2 screens, 8 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord18::
Data_011_4CE8:: ; heuristic: map record of the map table; C0
    dfar Map18Tileset ; entry 0
    dfar Map18Palettes
    db $03, $02, $39, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $60
    dfar Map18Screens0
    dfar Map18Attrs0
    dfar Map18Screens0
    dfar Map18Attrs0
    dfar Map18Screens0
    dfar Map18Attrs0
    dfar Map18Screens0
    dfar Map18Attrs0
    dfar Map18Screens0
    dfar Map18Attrs0
    dfar Map18Screens0
    dfar Map18Attrs0
    dfar Map18Screens0
    dfar Map18Attrs0
    dfar Map18Screens0
    dfar Map18Attrs0

; E-0142 (derived: map record of map $19, 2 x 3 screens, 8 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord19::
Data_011_4D2A:: ; heuristic: map record of the map table; C0
    dfar Map19Tileset ; entry 0
    dfar Map19Palettes
    db $02, $03, $57, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $60
    dfar Map19Screens0
    dfar Map19Attrs0
    dfar Map19Screens0
    dfar Map19Attrs0
    dfar Map19Screens0
    dfar Map19Attrs0
    dfar Map19Screens0
    dfar Map19Attrs0
    dfar Map19Screens0
    dfar Map19Attrs0
    dfar Map19Screens0
    dfar Map19Attrs0
    dfar Map19Screens6
    dfar Map19Attrs6
    dfar Map19Screens0
    dfar Map19Attrs0

; E-0142 (derived: map record of map $1A, 3 x 1 screens, 8 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord1A::
Data_011_4D6C:: ; heuristic: map record of the map table; C0
    dfar Map1ATileset ; entry 0
    dfar Map1APalettes
    db $03, $01, $4B, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $60
    dfar Map1AScreens0
    dfar Map1AAttrs0
    dfar Map1AScreens0
    dfar Map1AAttrs0
    dfar Map1AScreens0
    dfar Map1AAttrs0
    dfar Map1AScreens0
    dfar Map1AAttrs0
    dfar Map1AScreens0
    dfar Map1AAttrs0
    dfar Map1AScreens5
    dfar Map1AAttrs5
    dfar Map1AScreens5
    dfar Map1AAttrs5
    dfar Map1AScreens5
    dfar Map1AAttrs5

; E-0142 (derived: map record of map $1B, 1 x 3 screens, 8 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord1B::
Data_011_4DAE:: ; heuristic: map record of the map table; C0
    dfar Map1BTileset ; entry 0
    dfar Map1BPalettes
    db $01, $03, $1F, $00, $00, $00, $00, $02, $00, $00
    dw wStoryFlags + $60
    dfar Map1BScreens0
    dfar Map1BAttrs0
    dfar Map1BScreens0
    dfar Map1BAttrs0
    dfar Map1BScreens0
    dfar Map1BAttrs0
    dfar Map1BScreens0
    dfar Map1BAttrs0
    dfar Map1BScreens0
    dfar Map1BAttrs0
    dfar Map1BScreens0
    dfar Map1BAttrs0
    dfar Map1BScreens0
    dfar Map1BAttrs0
    dfar Map1BScreens0
    dfar Map1BAttrs0

; E-0142 (derived: map record of map $1C, 1 x 2 screens, 2 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord1C::
Data_011_4DF0:: ; heuristic: map record of the map table; C0
    dfar Map1CTileset ; entry 0
    dfar Map1CPalettes
    db $01, $02, $00, $00, $01, $00, $00, $00, $00, $00
    dw wStoryFlags + $60
    dfar Map1CScreens0
    dfar Map1CAttrs0
    dfar Map1CScreens0
    dfar Map1CAttrs0

; E-0142 (derived: map record of map $1D, 2 x 1 screens, 2 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord1D::
Data_011_4E0E:: ; heuristic: map record of the map table; C0
    dfar Map1DTileset ; entry 0
    dfar Map1DPalettes
    db $02, $01, $37, $00, $0E, $00, $00, $00, $00, $00
    dw wStoryFlags + $60
    dfar Map1DScreens0
    dfar Map1DAttrs0
    dfar Map1DScreens0
    dfar Map1DAttrs0

; E-0142 (derived: map record of map $20, 8 x 8 screens, 7 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord20::
Data_011_4E2C:: ; heuristic: map record of the map table; C0
    dfar Map20Tileset ; entry 0
    dfar Map20Palettes
    db $08, $08, $2B, $00, $00, $01, $00, $00, $00, $00
    dw wStoryFlags + $61
    dfar Map20Screens0
    dfar Map20Attrs0
    dfar Map20Screens0
    dfar Map20Attrs0
    dfar Map20Screens0
    dfar Map20Attrs0
    dfar Map20Screens0
    dfar Map20Attrs0
    dfar Map20Screens0
    dfar Map20Attrs0
    dfar Map20Screens0
    dfar Map20Attrs0
    dfar Map20Screens0
    dfar Map20Attrs0

; E-0142 (derived: map record of map $21, 2 x 1 screens, 7 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord21::
Data_011_4E68:: ; heuristic: map record of the map table; C0
    dfar Map21Tileset ; entry 0
    dfar Map21Palettes
    db $02, $01, $4E, $00, $01, $00, $00, $00, $00, $00
    dw wStoryFlags + $61
    dfar Map21Screens0
    dfar Map21Attrs0
    dfar Map21Screens0
    dfar Map21Attrs0
    dfar Map21Screens0
    dfar Map21Attrs0
    dfar Map21Screens0
    dfar Map21Attrs0
    dfar Map21Screens0
    dfar Map21Attrs0
    dfar Map21Screens0
    dfar Map21Attrs0
    dfar Map21Screens0
    dfar Map21Attrs0

; E-0142 (derived: map record of map $22, 1 x 1 screens, 7 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord22::
Data_011_4EA4:: ; heuristic: map record of the map table; C0
    dfar Map22Tileset ; entry 0
    dfar Map22Palettes
    db $01, $01, $30, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $61
    dfar Map22Screens0
    dfar Map22Attrs0
    dfar Map22Screens0
    dfar Map22Attrs0
    dfar Map22Screens0
    dfar Map22Attrs0
    dfar Map22Screens0
    dfar Map22Attrs0
    dfar Map22Screens0
    dfar Map22Attrs0
    dfar Map22Screens0
    dfar Map22Attrs0
    dfar Map22Screens0
    dfar Map22Attrs0

; E-0142 (derived: map record of map $23, 1 x 1 screens, 7 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord23::
Data_011_4EE0:: ; heuristic: map record of the map table; C0
    dfar Map23Tileset ; entry 0
    dfar Map23Palettes
    db $01, $01, $31, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $61
    dfar Map23Screens0
    dfar Map23Attrs0
    dfar Map23Screens0
    dfar Map23Attrs0
    dfar Map23Screens0
    dfar Map23Attrs0
    dfar Map23Screens0
    dfar Map23Attrs0
    dfar Map23Screens0
    dfar Map23Attrs0
    dfar Map23Screens0
    dfar Map23Attrs0
    dfar Map23Screens0
    dfar Map23Attrs0

; E-0142 (derived: map record of map $24, 2 x 2 screens, 7 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord24::
Data_011_4F1C:: ; heuristic: map record of the map table; C0
    dfar Map24Tileset ; entry 0
    dfar Map24Palettes
    db $02, $02, $48, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $61
    dfar Map24Screens0
    dfar Map24Attrs0
    dfar Map24Screens0
    dfar Map24Attrs0
    dfar Map24Screens0
    dfar Map24Attrs0
    dfar Map24Screens0
    dfar Map24Attrs0
    dfar Map24Screens0
    dfar Map24Attrs0
    dfar Map24Screens0
    dfar Map24Attrs0
    dfar Map24Screens0
    dfar Map24Attrs0

; E-0142 (derived: map record of map $25, 2 x 1 screens, 7 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord25::
Data_011_4F58:: ; heuristic: map record of the map table; C0
    dfar Map25Tileset ; entry 0
    dfar Map25Palettes
    db $02, $01, $37, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $61
    dfar Map25Screens0
    dfar Map25Attrs0
    dfar Map25Screens0
    dfar Map25Attrs0
    dfar Map25Screens0
    dfar Map25Attrs0
    dfar Map25Screens0
    dfar Map25Attrs0
    dfar Map25Screens0
    dfar Map25Attrs0
    dfar Map25Screens0
    dfar Map25Attrs0
    dfar Map25Screens0
    dfar Map25Attrs0

; E-0142 (derived: map record of map $26, 1 x 1 screens, 7 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord26::
Data_011_4F94:: ; heuristic: map record of the map table; C0
    dfar Map26Tileset ; entry 0
    dfar Map26Palettes
    db $01, $01, $58, $00, $06, $00, $00, $00, $00, $00
    dw wStoryFlags + $61
    dfar Map26Screens0
    dfar Map26Attrs0
    dfar Map26Screens1
    dfar Map26Attrs1
    dfar Map26Screens1
    dfar Map26Attrs1
    dfar Map26Screens1
    dfar Map26Attrs1
    dfar Map26Screens1
    dfar Map26Attrs1
    dfar Map26Screens1
    dfar Map26Attrs1
    dfar Map26Screens1
    dfar Map26Attrs1

; E-0142 (derived: map record of map $28, 1 x 2 screens, 7 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord28::
Data_011_4FD0:: ; heuristic: map record of the map table; C0
    dfar Map28Tileset ; entry 0
    dfar Map28Palettes
    db $01, $02, $2F, $00, $01, $00, $00, $00, $00, $00
    dw wStoryFlags + $61
    dfar Map28Screens0
    dfar Map28Attrs0
    dfar Map28Screens0
    dfar Map28Attrs0
    dfar Map28Screens0
    dfar Map28Attrs0
    dfar Map28Screens0
    dfar Map28Attrs0
    dfar Map28Screens0
    dfar Map28Attrs0
    dfar Map28Screens0
    dfar Map28Attrs0
    dfar Map28Screens0
    dfar Map28Attrs0

; E-0142 (derived: map record of map $29, 1 x 1 screens, 7 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord29::
Data_011_500C:: ; heuristic: map record of the map table; C0
    dfar Map29Tileset ; entry 0
    dfar Map29Palettes
    db $01, $01, $32, $2C, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $61
    dfar Map29Screens0
    dfar Map29Attrs0
    dfar Map29Screens0
    dfar Map29Attrs0
    dfar Map29Screens0
    dfar Map29Attrs0
    dfar Map29Screens0
    dfar Map29Attrs0
    dfar Map29Screens0
    dfar Map29Attrs0
    dfar Map29Screens0
    dfar Map29Attrs0
    dfar Map29Screens0
    dfar Map29Attrs0

; E-0142 (derived: map record of map $2A, 1 x 1 screens, 7 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord2A::
Data_011_5048:: ; heuristic: map record of the map table; C0
    dfar Map2ATileset ; entry 0
    dfar Map2APalettes
    db $01, $01, $27, $00, $01, $00, $00, $01, $0F, $00
    dw wStoryFlags + $61
    dfar Map2AScreens0
    dfar Map2AAttrs0
    dfar Map2AScreens0
    dfar Map2AAttrs0
    dfar Map2AScreens0
    dfar Map2AAttrs0
    dfar Map2AScreens0
    dfar Map2AAttrs0
    dfar Map2AScreens0
    dfar Map2AAttrs0
    dfar Map2AScreens0
    dfar Map2AAttrs0
    dfar Map2AScreens0
    dfar Map2AAttrs0

; E-0142 (derived: map record of map $2B, 4 x 4 screens, 7 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord2B::
Data_011_5084:: ; heuristic: map record of the map table; C0
    dfar Map2BTileset ; entry 0
    dfar Map2BPalettes
    db $04, $04, $4F, $00, $01, $02, $00, $01, $0D, $00
    dw wStoryFlags + $61
    dfar Map2BScreens0
    dfar Map2BAttrs0
    dfar Map2BScreens0
    dfar Map2BAttrs0
    dfar Map2BScreens2
    dfar Map2BAttrs2
    dfar Map2BScreens2
    dfar Map2BAttrs2
    dfar Map2BScreens2
    dfar Map2BAttrs2
    dfar Map2BScreens2
    dfar Map2BAttrs2
    dfar Map2BScreens2
    dfar Map2BAttrs2

; E-0142 (derived: map record of map $2D, 1 x 1 screens, 7 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord2D::
Data_011_50C0:: ; heuristic: map record of the map table; C0
    dfar Map2DTileset ; entry 0
    dfar Map2DPalettes
    db $01, $01, $21, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $61
    dfar Map2DScreens0
    dfar Map2DAttrs0
    dfar Map2DScreens0
    dfar Map2DAttrs0
    dfar Map2DScreens0
    dfar Map2DAttrs0
    dfar Map2DScreens0
    dfar Map2DAttrs0
    dfar Map2DScreens0
    dfar Map2DAttrs0
    dfar Map2DScreens0
    dfar Map2DAttrs0
    dfar Map2DScreens0
    dfar Map2DAttrs0

; E-0142 (derived: map record of map $2E, 1 x 1 screens, 7 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord2E::
Data_011_50FC:: ; heuristic: map record of the map table; C0
    dfar Map25Tileset ; entry 0
    dfar Map25Palettes
    db $01, $01, $37, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $61
    dfar Map2EScreens0
    dfar Map2EAttrs0
    dfar Map2EScreens0
    dfar Map2EAttrs0
    dfar Map2EScreens0
    dfar Map2EAttrs0
    dfar Map2EScreens3
    dfar Map2EAttrs3
    dfar Map2EScreens3
    dfar Map2EAttrs3
    dfar Map2EScreens3
    dfar Map2EAttrs3
    dfar Map2EScreens0
    dfar Map2EAttrs0

; E-0142 (derived: map record of map $2F, 2 x 2 screens, 7 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord2F::
Data_011_5138:: ; heuristic: map record of the map table; C0
    dfar Map2FTileset ; entry 0
    dfar Map2FPalettes
    db $02, $02, $37, $00, $01, $00, $00, $01, $09, $00
    dw wStoryFlags + $61
    dfar Map2FScreens0
    dfar Map2FAttrs0
    dfar Map2FScreens0
    dfar Map2FAttrs0
    dfar Map2FScreens0
    dfar Map2FAttrs0
    dfar Map2FScreens0
    dfar Map2FAttrs0
    dfar Map2FScreens4
    dfar Map2FAttrs4
    dfar Map2FScreens5
    dfar Map2FAttrs5
    dfar Map2FScreens5
    dfar Map2FAttrs5

; E-0142 (derived: map record of map $30, 8 x 8 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord30::
Data_011_5174:: ; heuristic: map record of the map table; C0
    dfar Map30Tileset ; entry 0
    dfar Map30Palettes
    db $08, $08, $3D, $00, $01, $03, $00, $01, $27, $00
    dw wStoryFlags + $62
    dfar Map30Screens0
    dfar Map30Attrs0
    dfar Map30Screens0
    dfar Map30Attrs0
    dfar Map30Screens2
    dfar Map30Attrs2
    dfar Map30Screens2
    dfar Map30Attrs2
    dfar Map30Screens2
    dfar Map30Attrs2

; E-0142 (derived: map record of map $31, 1 x 2 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord31::
Data_011_51A4:: ; heuristic: map record of the map table; C0
    dfar Map31Tileset ; entry 0
    dfar Map31Palettes
    db $01, $02, $3F, $00, $01, $00, $00, $00, $00, $00
    dw wStoryFlags + $62
    dfar Map31Screens0
    dfar Map31Attrs0
    dfar Map31Screens0
    dfar Map31Attrs0
    dfar Map31Screens0
    dfar Map31Attrs0
    dfar Map31Screens0
    dfar Map31Attrs0
    dfar Map31Screens0
    dfar Map31Attrs0

; E-0142 (derived: map record of map $32, 2 x 2 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord32::
Data_011_51D4:: ; heuristic: map record of the map table; C0
    dfar Map32Tileset ; entry 0
    dfar Map32Palettes
    db $02, $02, $4B, $00, $01, $00, $00, $00, $00, $00
    dw wStoryFlags + $62
    dfar Map32Screens0
    dfar Map32Attrs0
    dfar Map32Screens0
    dfar Map32Attrs0
    dfar Map32Screens2
    dfar Map32Attrs2
    dfar Map32Screens2
    dfar Map32Attrs2
    dfar Map32Screens2
    dfar Map32Attrs2

; E-0142 (derived: map record of map $33, 1 x 2 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord33::
Data_011_5204:: ; heuristic: map record of the map table; C0
    dfar Map33Tileset ; entry 0
    dfar Map33Palettes
    db $01, $02, $3F, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $62
    dfar Map33Screens0
    dfar Map33Attrs0
    dfar Map33Screens0
    dfar Map33Attrs0
    dfar Map33Screens0
    dfar Map33Attrs0
    dfar Map33Screens0
    dfar Map33Attrs0
    dfar Map33Screens0
    dfar Map33Attrs0

; E-0142 (derived: map record of map $34, 1 x 1 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord34::
Data_011_5234:: ; heuristic: map record of the map table; C0
    dfar Map34Tileset ; entry 0
    dfar Map34Palettes
    db $01, $01, $2A, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $62
    dfar Map34Screens0
    dfar Map34Attrs0
    dfar Map34Screens0
    dfar Map34Attrs0
    dfar Map34Screens0
    dfar Map34Attrs0
    dfar Map34Screens0
    dfar Map34Attrs0
    dfar Map34Screens0
    dfar Map34Attrs0

; E-0142 (derived: map record of map $35, 4 x 4 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord35::
Data_011_5264:: ; heuristic: map record of the map table; C0
    dfar Map35Tileset ; entry 0
    dfar Map35Palettes
    db $04, $04, $29, $00, $01, $04, $00, $01, $0F, $00
    dw wStoryFlags + $62
    dfar Map35Screens0
    dfar Map35Attrs0
    dfar Map35Screens0
    dfar Map35Attrs0
    dfar Map35Screens0
    dfar Map35Attrs0
    dfar Map35Screens0
    dfar Map35Attrs0
    dfar Map35Screens0
    dfar Map35Attrs0

; E-0142 (derived: map record of map $36, 1 x 1 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord36::
Data_011_5294:: ; heuristic: map record of the map table; C0
    dfar Map36Tileset ; entry 0
    dfar Map36Palettes
    db $01, $01, $23, $00, $01, $00, $00, $01, $09, $00
    dw wStoryFlags + $62
    dfar Map36Screens0
    dfar Map36Attrs0
    dfar Map36Screens0
    dfar Map36Attrs0
    dfar Map36Screens0
    dfar Map36Attrs0
    dfar Map36Screens0
    dfar Map36Attrs0
    dfar Map36Screens0
    dfar Map36Attrs0

; E-0142 (derived: map record of map $37, 3 x 1 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord37::
Data_011_52C4:: ; heuristic: map record of the map table; C0
    dfar Map37Tileset ; entry 0
    dfar Map37Palettes
    db $03, $01, $4F, $00, $01, $07, $00, $01, $0D, $00
    dw wStoryFlags + $62
    dfar Map37Screens0
    dfar Map37Attrs0
    dfar Map37Screens0
    dfar Map37Attrs0
    dfar Map37Screens0
    dfar Map37Attrs0
    dfar Map37Screens0
    dfar Map37Attrs0
    dfar Map37Screens0
    dfar Map37Attrs0

; E-0142 (derived: map record of map $38, 4 x 4 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord38::
Data_011_52F4:: ; heuristic: map record of the map table; C0
    dfar Map38Tileset ; entry 0
    dfar Map38Palettes
    db $04, $04, $3F, $00, $00, $05, $00, $00, $01, $00
    dw wStoryFlags + $62
    dfar Map38Screens0
    dfar Map38Attrs0
    dfar Map38Screens0
    dfar Map38Attrs0
    dfar Map38Screens0
    dfar Map38Attrs0
    dfar Map38Screens0
    dfar Map38Attrs0
    dfar Map38Screens0
    dfar Map38Attrs0

; E-0142 (derived: map record of map $39, 4 x 3 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord39::
Data_011_5324:: ; heuristic: map record of the map table; C0
    dfar Map38Tileset ; entry 0
    dfar Map38Palettes
    db $04, $03, $3F, $00, $00, $05, $00, $02, $01, $00
    dw wStoryFlags + $62
    dfar Map39Screens0
    dfar Map39Attrs0
    dfar Map39Screens0
    dfar Map39Attrs0
    dfar Map39Screens0
    dfar Map39Attrs0
    dfar Map39Screens3
    dfar Map39Attrs3
    dfar Map39Screens3
    dfar Map39Attrs3

; E-0142 (derived: map record of map $3A, 3 x 3 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord3A::
Data_011_5354:: ; heuristic: map record of the map table; C0
    dfar Map38Tileset ; entry 0
    dfar Map38Palettes
    db $03, $03, $3F, $00, $00, $05, $06, $02, $01, $00
    dw wStoryFlags + $62
    dfar Map3AScreens0
    dfar Map3AAttrs0
    dfar Map3AScreens0
    dfar Map3AAttrs0
    dfar Map3AScreens0
    dfar Map3AAttrs0
    dfar Map3AScreens0
    dfar Map3AAttrs0
    dfar Map3AScreens0
    dfar Map3AAttrs0

; E-0142 (derived: map record of map $3B, 1 x 1 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord3B::
Data_011_5384:: ; heuristic: map record of the map table; C0
    dfar Map3BTileset ; entry 0
    dfar Map3BPalettes
    db $01, $01, $37, $2C, $00, $00, $00, $02, $01, $00
    dw wStoryFlags + $62
    dfar Map3BScreens0
    dfar Map3BAttrs0
    dfar Map3BScreens0
    dfar Map3BAttrs0
    dfar Map3BScreens0
    dfar Map3BAttrs0
    dfar Map3BScreens0
    dfar Map3BAttrs0
    dfar Map3BScreens4
    dfar Map3BAttrs4

; E-0142 (derived: map record of map $3C, 3 x 1 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord3C::
Data_011_53B4:: ; heuristic: map record of the map table; C0
    dfar Map3CTileset ; entry 0
    dfar Map3CPalettes
    db $03, $01, $3F, $00, $01, $00, $00, $00, $00, $00
    dw wStoryFlags + $62
    dfar Map3CScreens0
    dfar Map3CAttrs0
    dfar Map3CScreens0
    dfar Map3CAttrs0
    dfar Map3CScreens0
    dfar Map3CAttrs0
    dfar Map3CScreens0
    dfar Map3CAttrs0
    dfar Map3CScreens0
    dfar Map3CAttrs0

; E-0142 (derived: map record of map $3D, 1 x 1 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord3D::
Data_011_53E4:: ; heuristic: map record of the map table; C0
    dfar Map3DTileset ; entry 0
    dfar Map3DPalettes
    db $01, $01, $2A, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $62
    dfar Map3DScreens0
    dfar Map3DAttrs0
    dfar Map3DScreens0
    dfar Map3DAttrs0
    dfar Map3DScreens0
    dfar Map3DAttrs0
    dfar Map3DScreens0
    dfar Map3DAttrs0
    dfar Map3DScreens0
    dfar Map3DAttrs0

; E-0142 (derived: map record of map $3E, 2 x 2 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord3E::
Data_011_5414:: ; heuristic: map record of the map table; C0
    dfar Map3ETileset ; entry 0
    dfar Map3EPalettes
    db $02, $02, $2F, $00, $01, $06, $00, $01, $0E, $00
    dw wStoryFlags + $62
    dfar Map3EScreens0
    dfar Map3EAttrs0
    dfar Map3EScreens0
    dfar Map3EAttrs0
    dfar Map3EScreens0
    dfar Map3EAttrs0
    dfar Map3EScreens0
    dfar Map3EAttrs0
    dfar Map3EScreens0
    dfar Map3EAttrs0

; E-0142 (derived: map record of map $3F, 2 x 2 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord3F::
Data_011_5444:: ; heuristic: map record of the map table; C0
    dfar Map3ETileset ; entry 0
    dfar Map3EPalettes
    db $02, $02, $2F, $00, $01, $06, $00, $01, $0E, $00
    dw wStoryFlags + $62
    dfar Map3FScreens0
    dfar Map3FAttrs0
    dfar Map3FScreens0
    dfar Map3FAttrs0
    dfar Map3FScreens0
    dfar Map3FAttrs0
    dfar Map3FScreens0
    dfar Map3FAttrs0
    dfar Map3FScreens0
    dfar Map3FAttrs0

; E-0142 (derived: map record of map $40, 1 x 2 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord40::
Data_011_5474:: ; heuristic: map record of the map table; C0
    dfar Map40Tileset ; entry 0
    dfar Map40Palettes
    db $01, $02, $3F, $00, $01, $00, $00, $00, $00, $00
    dw wStoryFlags + $62
    dfar Map40Screens0
    dfar Map40Attrs0
    dfar Map40Screens0
    dfar Map40Attrs0
    dfar Map40Screens2
    dfar Map40Attrs2
    dfar Map40Screens2
    dfar Map40Attrs2
    dfar Map40Screens2
    dfar Map40Attrs2

; E-0142 (derived: map record of map $41, 1 x 2 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord41::
Data_011_54A4:: ; heuristic: map record of the map table; C0
    dfar Map41Tileset ; entry 0
    dfar Map41Palettes
    db $01, $02, $3B, $00, $01, $00, $00, $00, $00, $00
    dw wStoryFlags + $62
    dfar Map41Screens0
    dfar Map41Attrs0
    dfar Map41Screens0
    dfar Map41Attrs0
    dfar Map41Screens0
    dfar Map41Attrs0
    dfar Map41Screens0
    dfar Map41Attrs0
    dfar Map41Screens0
    dfar Map41Attrs0

; E-0142 (derived: map record of map $42, 3 x 1 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord42::
Data_011_54D4:: ; heuristic: map record of the map table; C0
    dfar Map37Tileset ; entry 0
    dfar Map37Palettes
    db $03, $01, $4F, $00, $01, $08, $00, $02, $10, $00
    dw wStoryFlags + $62
    dfar Map42Screens0
    dfar Map42Attrs0
    dfar Map42Screens0
    dfar Map42Attrs0
    dfar Map42Screens0
    dfar Map42Attrs0
    dfar Map42Screens0
    dfar Map42Attrs0
    dfar Map42Screens0
    dfar Map42Attrs0

; E-0142 (derived: map record of map $43, 3 x 1 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord43::
Data_011_5504:: ; heuristic: map record of the map table; C0
    dfar Map43Tileset ; entry 0
    dfar Map43Palettes
    db $03, $01, $4F, $00, $0D, $08, $00, $02, $02, $00
    dw wStoryFlags + $62
    dfar Map43Screens0
    dfar Map43Attrs0
    dfar Map43Screens1
    dfar Map43Attrs1
    dfar Map43Screens1
    dfar Map43Attrs1
    dfar Map43Screens1
    dfar Map43Attrs1
    dfar Map43Screens1
    dfar Map43Attrs1

; E-0142 (derived: map record of map $44, 1 x 1 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord44::
Data_011_5534:: ; heuristic: map record of the map table; C0
    dfar Map44Tileset ; entry 0
    dfar Map44Palettes
    db $01, $01, $4F, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $62
    dfar Map44Screens0
    dfar Map44Attrs0
    dfar Map44Screens0
    dfar Map44Attrs0
    dfar Map44Screens0
    dfar Map44Attrs0
    dfar Map44Screens0
    dfar Map44Attrs0
    dfar Map44Screens0
    dfar Map44Attrs0

; E-0142 (derived: map record of map $48, 12 x 12 screens, 3 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord48::
Data_011_5564:: ; heuristic: map record of the map table; C0
    dfar Map48Tileset ; entry 0
    dfar Map48Palettes
    db $0C, $0C, $2B, $00, $01, $09, $00, $01, $27, $00
    dw wStoryFlags + $63
    dfar Map48Screens0
    dfar Map48Attrs0
    dfar Map48Screens0
    dfar Map48Attrs0
    dfar Map48Screens2
    dfar Map48Attrs2

; E-0142 (derived: map record of map $49, 1 x 1 screens, 3 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord49::
Data_011_5588:: ; heuristic: map record of the map table; C0
    dfar Map49Tileset ; entry 0
    dfar Map49Palettes
    db $01, $01, $2B, $00, $01, $00, $00, $01, $0A, $00
    dw wStoryFlags + $63
    dfar Map49Screens0
    dfar Map49Attrs0
    dfar Map49Screens0
    dfar Map49Attrs0
    dfar Map49Screens2
    dfar Map49Attrs2

; E-0142 (derived: map record of map $4A, 2 x 2 screens, 3 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord4A::
Data_011_55AC:: ; heuristic: map record of the map table; C0
    dfar Map4ATileset ; entry 0
    dfar Map4APalettes
    db $02, $02, $4C, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $63
    dfar Map4AScreens0
    dfar Map4AAttrs0
    dfar Map4AScreens0
    dfar Map4AAttrs0
    dfar Map4AScreens0
    dfar Map4AAttrs0

; E-0142 (derived: map record of map $4B, 1 x 1 screens, 3 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord4B::
Data_011_55D0:: ; heuristic: map record of the map table; C0
    dfar Map4BTileset ; entry 0
    dfar Map4BPalettes
    db $01, $01, $2B, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $63
    dfar Map4BScreens0
    dfar Map4BAttrs0
    dfar Map4BScreens0
    dfar Map4BAttrs0
    dfar Map4BScreens0
    dfar Map4BAttrs0

; E-0142 (derived: map record of map $4C, 2 x 2 screens, 3 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord4C::
Data_011_55F4:: ; heuristic: map record of the map table; C0
    dfar Map4CTileset ; entry 0
    dfar Map4CPalettes
    db $02, $02, $46, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $63
    dfar Map4CScreens0
    dfar Map4CAttrs0
    dfar Map4CScreens0
    dfar Map4CAttrs0
    dfar Map4CScreens0
    dfar Map4CAttrs0

; E-0142 (derived: map record of map $4D, 1 x 2 screens, 3 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord4D::
Data_011_5618:: ; heuristic: map record of the map table; C0
    dfar Map4DTileset ; entry 0
    dfar Map4DPalettes
    db $01, $02, $17, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $63
    dfar Map4DScreens0
    dfar Map4DAttrs0
    dfar Map4DScreens1
    dfar Map4DAttrs1
    dfar Map4DScreens1
    dfar Map4DAttrs1

; E-0142 (derived: map record of map $4E, 1 x 3 screens, 3 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord4E::
Data_011_563C:: ; heuristic: map record of the map table; C0
    dfar Map4ETileset ; entry 0
    dfar Map4EPalettes
    db $01, $03, $2F, $00, $09, $00, $00, $00, $00, $00
    dw wStoryFlags + $63
    dfar Map4EScreens0
    dfar Map4EAttrs0
    dfar Map4EScreens0
    dfar Map4EAttrs0
    dfar Map4EScreens0
    dfar Map4EAttrs0

; E-0142 (derived: map record of map $4F, 2 x 2 screens, 3 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord4F::
Data_011_5660:: ; heuristic: map record of the map table; C0
    dfar Map4FTileset ; entry 0
    dfar Map4FPalettes
    db $02, $02, $57, $00, $01, $00, $00, $00, $00, $00
    dw wStoryFlags + $63
    dfar Map4FScreens0
    dfar Map4FAttrs0
    dfar Map4FScreens0
    dfar Map4FAttrs0
    dfar Map4FScreens2
    dfar Map4FAttrs2

; E-0142 (derived: map record of map $50, 1 x 1 screens, 3 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord50::
Data_011_5684:: ; heuristic: map record of the map table; C0
    dfar Map50Tileset ; entry 0
    dfar Map50Palettes
    db $01, $01, $3F, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $63
    dfar Map50Screens0
    dfar Map50Attrs0
    dfar Map50Screens0
    dfar Map50Attrs0
    dfar Map50Screens0
    dfar Map50Attrs0

; E-0142 (derived: map record of map $51, 1 x 1 screens, 3 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord51::
Data_011_56A8:: ; heuristic: map record of the map table; C0
    dfar Map50Tileset ; entry 0
    dfar Map50Palettes
    db $01, $01, $3F, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $63
    dfar Map51Screens0
    dfar Map51Attrs0
    dfar Map51Screens0
    dfar Map51Attrs0
    dfar Map51Screens0
    dfar Map51Attrs0

; E-0142 (derived: map record of map $52, 3 x 2 screens, 3 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord52::
Data_011_56CC:: ; heuristic: map record of the map table; C0
    dfar Map52Tileset ; entry 0
    dfar Map52Palettes
    db $03, $02, $2F, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $63
    dfar Map52Screens0
    dfar Map52Attrs0
    dfar Map52Screens0
    dfar Map52Attrs0
    dfar Map52Screens0
    dfar Map52Attrs0

; E-0142 (derived: map record of map $53, 4 x 4 screens, 3 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord53::
Data_011_56F0:: ; heuristic: map record of the map table; C0
    dfar Map53Tileset ; entry 0
    dfar Map53Palettes
    db $04, $04, $33, $00, $00, $0A, $00, $10, $30, $00
    dw wStoryFlags + $63
    dfar Map53Screens0
    dfar Map53Attrs0
    dfar Map53Screens0
    dfar Map53Attrs0
    dfar Map53Screens0
    dfar Map53Attrs0

; E-0142 (derived: map record of map $54, 1 x 1 screens, 3 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord54::
Data_011_5714:: ; heuristic: map record of the map table; C0
    dfar Map53Tileset ; entry 0
    dfar Map53Palettes
    db $01, $01, $33, $00, $00, $0B, $00, $10, $30, $00
    dw wStoryFlags + $63
    dfar Map54Screens0
    dfar Map54Attrs0
    dfar Map54Screens0
    dfar Map54Attrs0
    dfar Map54Screens0
    dfar Map54Attrs0

; E-0142 (derived: map record of map $55, 2 x 1 screens, 3 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord55::
Data_011_5738:: ; heuristic: map record of the map table; C0
    dfar Map53Tileset ; entry 0
    dfar Map53Palettes
    db $02, $01, $33, $00, $00, $0B, $00, $10, $30, $00
    dw wStoryFlags + $63
    dfar Map55Screens0
    dfar Map55Attrs0
    dfar Map55Screens0
    dfar Map55Attrs0
    dfar Map55Screens0
    dfar Map55Attrs0

; E-0142 (derived: map record of map $56, 1 x 3 screens, 3 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord56::
Data_011_575C:: ; heuristic: map record of the map table; C0
    dfar Map53Tileset ; entry 0
    dfar Map53Palettes
    db $01, $03, $33, $00, $00, $0B, $00, $10, $30, $00
    dw wStoryFlags + $63
    dfar Map56Screens0
    dfar Map56Attrs0
    dfar Map56Screens0
    dfar Map56Attrs0
    dfar Map56Screens0
    dfar Map56Attrs0

; E-0142 (derived: map record of map $57, 3 x 1 screens, 3 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord57::
Data_011_5780:: ; heuristic: map record of the map table; C0
    dfar Map57Tileset ; entry 0
    dfar Map57Palettes
    db $03, $01, $3F, $00, $00, $00, $00, $10, $2C, $00
    dw wStoryFlags + $63
    dfar Map57Screens0
    dfar Map57Attrs0
    dfar Map57Screens0
    dfar Map57Attrs0
    dfar Map57Screens0
    dfar Map57Attrs0

; E-0142 (derived: map record of map $58, 2 x 2 screens, 3 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord58::
Data_011_57A4:: ; heuristic: map record of the map table; C0
    dfar Map58Tileset ; entry 0
    dfar Map58Palettes
    db $02, $02, $57, $00, $01, $00, $00, $00, $00, $00
    dw wStoryFlags + $63
    dfar Map58Screens0
    dfar Map58Attrs0
    dfar Map58Screens0
    dfar Map58Attrs0
    dfar Map58Screens0
    dfar Map58Attrs0

; E-0142 (derived: map record of map $59, 2 x 1 screens, 3 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord59::
Data_011_57C8:: ; heuristic: map record of the map table; C0
    dfar Map59Tileset ; entry 0
    dfar Map59Palettes
    db $02, $01, $3F, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $63
    dfar Map59Screens0
    dfar Map59Attrs0
    dfar Map59Screens0
    dfar Map59Attrs0
    dfar Map59Screens0
    dfar Map59Attrs0

; E-0142 (derived: map record of map $5A, 2 x 1 screens, 3 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord5A::
Data_011_57EC:: ; heuristic: map record of the map table; C0
    dfar Map5ATileset ; entry 0
    dfar Map5APalettes
    db $02, $01, $21, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $63
    dfar Map5AScreens0
    dfar Map5AAttrs0
    dfar Map5AScreens0
    dfar Map5AAttrs0
    dfar Map5AScreens0
    dfar Map5AAttrs0

; E-0142 (derived: map record of map $5B, 2 x 2 screens, 3 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord5B::
Data_011_5810:: ; heuristic: map record of the map table; C0
    dfar Map5BTileset ; entry 0
    dfar Map5BPalettes
    db $02, $02, $43, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $63
    dfar Map5BScreens0
    dfar Map5BAttrs0
    dfar Map5BScreens0
    dfar Map5BAttrs0
    dfar Map5BScreens0
    dfar Map5BAttrs0

; E-0142 (derived: map record of map $5C, 1 x 2 screens, 3 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord5C::
Data_011_5834:: ; heuristic: map record of the map table; C0
    dfar Map5CTileset ; entry 0
    dfar Map5CPalettes
    db $01, $02, $33, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $63
    dfar Map5CScreens0
    dfar Map5CAttrs0
    dfar Map5CScreens0
    dfar Map5CAttrs0
    dfar Map5CScreens0
    dfar Map5CAttrs0

; E-0142 (derived: map record of map $5D, 4 x 4 screens, 3 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord5D::
Data_011_5858:: ; heuristic: map record of the map table; C0
    dfar Map5DTileset ; entry 0
    dfar Map5DPalettes
    db $04, $04, $11, $00, $00, $0C, $00, $00, $00, $00
    dw wStoryFlags + $63
    dfar Map5DScreens0
    dfar Map5DAttrs0
    dfar Map5DScreens0
    dfar Map5DAttrs0
    dfar Map5DScreens0
    dfar Map5DAttrs0

; E-0142 (derived: map record of map $5E, 2 x 2 screens, 3 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord5E::
Data_011_587C:: ; heuristic: map record of the map table; C0
    dfar Map5ETileset ; entry 0
    dfar Map5EPalettes
    db $02, $02, $4B, $00, $01, $00, $00, $00, $00, $00
    dw wStoryFlags + $63
    dfar Map5EScreens0
    dfar Map5EAttrs0
    dfar Map5EScreens0
    dfar Map5EAttrs0
    dfar Map5EScreens0
    dfar Map5EAttrs0

; E-0142 (derived: map record of map $5F, 1 x 1 screens, 3 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord5F::
Data_011_58A0:: ; heuristic: map record of the map table; C0
    dfar Map5FTileset ; entry 0
    dfar Map5FPalettes
    db $01, $01, $1F, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $63
    dfar Map5FScreens0
    dfar Map5FAttrs0
    dfar Map5FScreens0
    dfar Map5FAttrs0
    dfar Map5FScreens0
    dfar Map5FAttrs0

; E-0142 (derived: map record of map $60, 1 x 3 screens, 3 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord60::
Data_011_58C4:: ; heuristic: map record of the map table; C0
    dfar Map60Tileset ; entry 0
    dfar Map60Palettes
    db $01, $03, $31, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $63
    dfar Map60Screens0
    dfar Map60Attrs0
    dfar Map60Screens0
    dfar Map60Attrs0
    dfar Map60Screens0
    dfar Map60Attrs0

; E-0142 (derived: map record of map $61, 1 x 2 screens, 3 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord61::
Data_011_58E8:: ; heuristic: map record of the map table; C0
    dfar Map61Tileset ; entry 0
    dfar Map61Palettes
    db $01, $02, $33, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $63
    dfar Map61Screens0
    dfar Map61Attrs0
    dfar Map61Screens0
    dfar Map61Attrs0
    dfar Map61Screens0
    dfar Map61Attrs0

; E-0142 (derived: map record of map $62, 2 x 4 screens, 3 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord62::
Data_011_590C:: ; heuristic: map record of the map table; C0
    dfar Map62Tileset ; entry 0
    dfar Map62Palettes
    db $02, $04, $32, $00, $00, $0D, $00, $00, $00, $00
    dw wStoryFlags + $63
    dfar Map62Screens0
    dfar Map62Attrs0
    dfar Map62Screens0
    dfar Map62Attrs0
    dfar Map62Screens0
    dfar Map62Attrs0

; E-0142 (derived: map record of map $63, 2 x 2 screens, 3 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord63::
Data_011_5930:: ; heuristic: map record of the map table; C0
    dfar Map63Tileset ; entry 0
    dfar Map63Palettes
    db $02, $02, $33, $00, $00, $0E, $07, $02, $01, $00
    dw wStoryFlags + $63
    dfar Map63Screens0
    dfar Map63Attrs0
    dfar Map63Screens0
    dfar Map63Attrs0
    dfar Map63Screens0
    dfar Map63Attrs0

; E-0142 (derived: map record of map $64, 2 x 2 screens, 3 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord64::
Data_011_5954:: ; heuristic: map record of the map table; C0
    dfar Map63Tileset ; entry 0
    dfar Map63Palettes
    db $02, $02, $33, $00, $00, $0E, $07, $02, $01, $00
    dw wStoryFlags + $63
    dfar Map64Screens0
    dfar Map64Attrs0
    dfar Map64Screens0
    dfar Map64Attrs0
    dfar Map64Screens0
    dfar Map64Attrs0

; E-0142 (derived: map record of map $65, 2 x 2 screens, 3 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord65::
Data_011_5978:: ; heuristic: map record of the map table; C0
    dfar Map63Tileset ; entry 0
    dfar Map63Palettes
    db $02, $02, $33, $00, $00, $0E, $07, $02, $01, $00
    dw wStoryFlags + $63
    dfar Map65Screens0
    dfar Map65Attrs0
    dfar Map65Screens0
    dfar Map65Attrs0
    dfar Map65Screens0
    dfar Map65Attrs0

; E-0142 (derived: map record of map $66, 2 x 2 screens, 3 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord66::
Data_011_599C:: ; heuristic: map record of the map table; C0
    dfar Map63Tileset ; entry 0
    dfar Map63Palettes
    db $02, $02, $33, $00, $00, $0F, $07, $02, $01, $00
    dw wStoryFlags + $63
    dfar Map66Screens0
    dfar Map66Attrs0
    dfar Map66Screens0
    dfar Map66Attrs0
    dfar Map66Screens0
    dfar Map66Attrs0

; E-0142 (derived: map record of map $67, 1 x 1 screens, 3 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord67::
Data_011_59C0:: ; heuristic: map record of the map table; C0
    dfar Map63Tileset ; entry 0
    dfar Map63Palettes
    db $01, $01, $33, $00, $00, $0F, $00, $02, $01, $00
    dw wStoryFlags + $63
    dfar Map67Screens0
    dfar Map67Attrs0
    dfar Map67Screens0
    dfar Map67Attrs0
    dfar Map67Screens0
    dfar Map67Attrs0
    db $E9, $58, $90, $28, $5B, $90, $01, $01, $1F, $1C, $00, $00, $00, $00, $00, $00, $3A, $CC, $68, $5B, $90, $6B, $5B, $90, $68, $5B, $90, $6B, $5B, $90, $68, $5B, $90, $6B, $5B, $90

; E-0142 (derived: map record of map $70, 12 x 12 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord70::
Data_011_5A08:: ; heuristic: map record of the map table; C0
    dfar Map70Tileset ; entry 0
    dfar Map70Palettes
    db $0C, $0C, $2D, $00, $00, $10, $00, $02, $29, $00
    dw wStoryFlags + $64
    dfar Map70Screens0
    dfar Map70Attrs0
    dfar Map70Screens0
    dfar Map70Attrs0
    dfar Map70Screens0
    dfar Map70Attrs0
    dfar Map70Screens0
    dfar Map70Attrs0
    dfar Map70Screens0
    dfar Map70Attrs0

; E-0142 (derived: map record of map $71, 3 x 1 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord71::
Data_011_5A38:: ; heuristic: map record of the map table; C0
    dfar Map71Tileset ; entry 0
    dfar Map71Palettes
    db $03, $01, $31, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $64
    dfar Map71Screens0
    dfar Map71Attrs0
    dfar Map71Screens0
    dfar Map71Attrs0
    dfar Map71Screens0
    dfar Map71Attrs0
    dfar Map71Screens0
    dfar Map71Attrs0
    dfar Map71Screens0
    dfar Map71Attrs0

; E-0142 (derived: map record of map $72, 1 x 1 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord72::
Data_011_5A68:: ; heuristic: map record of the map table; C0
    dfar Map72Tileset ; entry 0
    dfar Map72Palettes
    db $01, $01, $23, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $64
    dfar Map72Screens0
    dfar Map72Attrs0
    dfar Map72Screens0
    dfar Map72Attrs0
    dfar Map72Screens0
    dfar Map72Attrs0
    dfar Map72Screens0
    dfar Map72Attrs0
    dfar Map72Screens0
    dfar Map72Attrs0

; E-0142 (derived: map record of map $73, 2 x 2 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord73::
Data_011_5A98:: ; heuristic: map record of the map table; C0
    dfar Map73Tileset ; entry 0
    dfar Map73Palettes
    db $02, $02, $4F, $00, $00, $11, $00, $00, $00, $00
    dw wStoryFlags + $64
    dfar Map73Screens0
    dfar Map73Attrs0
    dfar Map73Screens0
    dfar Map73Attrs0
    dfar Map73Screens0
    dfar Map73Attrs0
    dfar Map73Screens0
    dfar Map73Attrs0
    dfar Map73Screens0
    dfar Map73Attrs0

; E-0142 (derived: map record of map $74, 2 x 2 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord74::
Data_011_5AC8:: ; heuristic: map record of the map table; C0
    dfar Map73Tileset ; entry 0
    dfar Map73Palettes
    db $02, $02, $4F, $00, $00, $11, $00, $00, $00, $00
    dw wStoryFlags + $64
    dfar Map74Screens0
    dfar Map74Attrs0
    dfar Map74Screens0
    dfar Map74Attrs0
    dfar Map74Screens0
    dfar Map74Attrs0
    dfar Map74Screens0
    dfar Map74Attrs0
    dfar Map74Screens0
    dfar Map74Attrs0

; E-0142 (derived: map record of map $75, 2 x 2 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord75::
Data_011_5AF8:: ; heuristic: map record of the map table; C0
    dfar Map73Tileset ; entry 0
    dfar Map73Palettes
    db $02, $02, $4F, $00, $00, $11, $00, $00, $00, $00
    dw wStoryFlags + $64
    dfar Map75Screens0
    dfar Map75Attrs0
    dfar Map75Screens0
    dfar Map75Attrs0
    dfar Map75Screens0
    dfar Map75Attrs0
    dfar Map75Screens0
    dfar Map75Attrs0
    dfar Map75Screens0
    dfar Map75Attrs0

; E-0142 (derived: map record of map $76, 2 x 2 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord76::
Data_011_5B28:: ; heuristic: map record of the map table; C0
    dfar Map73Tileset ; entry 0
    dfar Map73Palettes
    db $02, $02, $4F, $00, $00, $11, $00, $00, $00, $00
    dw wStoryFlags + $64
    dfar Map76Screens0
    dfar Map76Attrs0
    dfar Map76Screens0
    dfar Map76Attrs0
    dfar Map76Screens0
    dfar Map76Attrs0
    dfar Map76Screens0
    dfar Map76Attrs0
    dfar Map76Screens0
    dfar Map76Attrs0

; E-0142 (derived: map record of map $77, 3 x 1 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord77::
Data_011_5B58:: ; heuristic: map record of the map table; C0
    dfar Map77Tileset ; entry 0
    dfar Map77Palettes
    db $03, $01, $3F, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $64
    dfar Map77Screens0
    dfar Map77Attrs0
    dfar Map77Screens0
    dfar Map77Attrs0
    dfar Map77Screens0
    dfar Map77Attrs0
    dfar Map77Screens0
    dfar Map77Attrs0
    dfar Map77Screens0
    dfar Map77Attrs0

; E-0142 (derived: map record of map $78, 2 x 2 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord78::
Data_011_5B88:: ; heuristic: map record of the map table; C0
    dfar Map78Tileset ; entry 0
    dfar Map78Palettes
    db $02, $02, $3D, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $64
    dfar Map78Screens0
    dfar Map78Attrs0
    dfar Map78Screens0
    dfar Map78Attrs0
    dfar Map78Screens0
    dfar Map78Attrs0
    dfar Map78Screens0
    dfar Map78Attrs0
    dfar Map78Screens0
    dfar Map78Attrs0

; E-0142 (derived: map record of map $79, 1 x 2 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord79::
Data_011_5BB8:: ; heuristic: map record of the map table; C0
    dfar Map79Tileset ; entry 0
    dfar Map79Palettes
    db $01, $02, $45, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $64
    dfar Map79Screens0
    dfar Map79Attrs0
    dfar Map79Screens0
    dfar Map79Attrs0
    dfar Map79Screens0
    dfar Map79Attrs0
    dfar Map79Screens0
    dfar Map79Attrs0
    dfar Map79Screens0
    dfar Map79Attrs0

; E-0142 (derived: map record of map $7A, 1 x 2 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord7A::
Data_011_5BE8:: ; heuristic: map record of the map table; C0
    dfar Map7ATileset ; entry 0
    dfar Map7APalettes
    db $01, $02, $4B, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $64
    dfar Map7AScreens0
    dfar Map7AAttrs0
    dfar Map7AScreens0
    dfar Map7AAttrs0
    dfar Map7AScreens0
    dfar Map7AAttrs0
    dfar Map7AScreens0
    dfar Map7AAttrs0
    dfar Map7AScreens0
    dfar Map7AAttrs0

; E-0142 (derived: map record of map $7B, 1 x 3 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord7B::
Data_011_5C18:: ; heuristic: map record of the map table; C0
    dfar Map7BTileset ; entry 0
    dfar Map7BPalettes
    db $01, $03, $1F, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $64
    dfar Map7BScreens0
    dfar Map7BAttrs0
    dfar Map7BScreens0
    dfar Map7BAttrs0
    dfar Map7BScreens0
    dfar Map7BAttrs0
    dfar Map7BScreens0
    dfar Map7BAttrs0
    dfar Map7BScreens0
    dfar Map7BAttrs0

; E-0142 (derived: map record of map $7C, 2 x 2 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord7C::
Data_011_5C48:: ; heuristic: map record of the map table; C0
    dfar Map7CTileset ; entry 0
    dfar Map7CPalettes
    db $02, $02, $45, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $64
    dfar Map7CScreens0
    dfar Map7CAttrs0
    dfar Map7CScreens0
    dfar Map7CAttrs0
    dfar Map7CScreens0
    dfar Map7CAttrs0
    dfar Map7CScreens0
    dfar Map7CAttrs0
    dfar Map7CScreens0
    dfar Map7CAttrs0

; E-0142 (derived: map record of map $7D, 1 x 1 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord7D::
Data_011_5C78:: ; heuristic: map record of the map table; C0
    dfar Map7DTileset ; entry 0
    dfar Map7DPalettes
    db $01, $01, $3B, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $64
    dfar Map7DScreens0
    dfar Map7DAttrs0
    dfar Map7DScreens0
    dfar Map7DAttrs0
    dfar Map7DScreens0
    dfar Map7DAttrs0
Data_011_5C9C:: ; heuristic: label inside a table; C0
    dfar Map7DScreens0
    dfar Map7DAttrs0
    dfar Map7DScreens0
    dfar Map7DAttrs0

; E-0142 (derived: map record of map $7E, 1 x 1 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord7E::
Data_011_5CA8:: ; heuristic: map record of the map table; C0
    dfar Map7DTileset ; entry 0
    dfar Map7DPalettes
    db $01, $01, $3B, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $64
    dfar Map7EScreens0
    dfar Map7EAttrs0
    dfar Map7EScreens0
    dfar Map7EAttrs0
    dfar Map7EScreens0
    dfar Map7EAttrs0
    dfar Map7EScreens0
    dfar Map7EAttrs0
    dfar Map7EScreens0
    dfar Map7EAttrs0

; E-0142 (derived: map record of map $7F, 1 x 2 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord7F::
Data_011_5CD8:: ; heuristic: map record of the map table; C0
    dfar Map7FTileset ; entry 0
    dfar Map7FPalettes
    db $01, $02, $2F, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $64
    dfar Map7FScreens0
    dfar Map7FAttrs0
    dfar Map7FScreens0
    dfar Map7FAttrs0
    dfar Map7FScreens0
    dfar Map7FAttrs0
    dfar Map7FScreens0
    dfar Map7FAttrs0
    dfar Map7FScreens0
    dfar Map7FAttrs0

; E-0142 (derived: map record of map $80, 3 x 1 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord80::
Data_011_5D08:: ; heuristic: map record of the map table; C0
    dfar Map80Tileset ; entry 0
    dfar Map80Palettes
    db $03, $01, $3F, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $64
    dfar Map80Screens0
    dfar Map80Attrs0
    dfar Map80Screens0
    dfar Map80Attrs0
    dfar Map80Screens0
    dfar Map80Attrs0
Data_011_5D2C:: ; heuristic: label inside a table; C0
    dfar Map80Screens0
    dfar Map80Attrs0
    dfar Map80Screens0
    dfar Map80Attrs0

; E-0142 (derived: map record of map $81, 1 x 1 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord81::
Data_011_5D38:: ; heuristic: map record of the map table; C0
    dfar Map81Tileset ; entry 0
    dfar Map81Palettes
    db $01, $01, $2F, $00, $00, $12, $00, $00, $00, $00
    dw wStoryFlags + $64
    dfar Map81Screens0
    dfar Map81Attrs0
    dfar Map81Screens0
    dfar Map81Attrs0
    dfar Map81Screens0
    dfar Map81Attrs0
    dfar Map81Screens0
    dfar Map81Attrs0
    dfar Map81Screens0
    dfar Map81Attrs0

; E-0142 (derived: map record of map $82, 3 x 3 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord82::
Data_011_5D68:: ; heuristic: map record of the map table; C0
    dfar Map81Tileset ; entry 0
    dfar Map81Palettes
    db $03, $03, $2F, $00, $00, $13, $00, $00, $00, $00
    dw wStoryFlags + $64
    dfar Map82Screens0
    dfar Map82Attrs0
    dfar Map82Screens0
    dfar Map82Attrs0
    dfar Map82Screens0
    dfar Map82Attrs0
    dfar Map82Screens0
    dfar Map82Attrs0
    dfar Map82Screens0
    dfar Map82Attrs0

; E-0142 (derived: map record of map $83, 3 x 3 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord83::
Data_011_5D98:: ; heuristic: map record of the map table; C0
    dfar Map81Tileset ; entry 0
    dfar Map81Palettes
    db $03, $03, $2F, $00, $00, $13, $00, $00, $00, $00
    dw wStoryFlags + $64
    dfar Map83Screens0
    dfar Map83Attrs0
    dfar Map83Screens0
    dfar Map83Attrs0
    dfar Map83Screens0
    dfar Map83Attrs0
    dfar Map83Screens0
    dfar Map83Attrs0
    dfar Map83Screens0
    dfar Map83Attrs0

; E-0142 (derived: map record of map $84, 1 x 1 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord84::
Data_011_5DC8:: ; heuristic: map record of the map table; C0
    dfar Map81Tileset ; entry 0
    dfar Map81Palettes
    db $01, $01, $2F, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $64
    dfar Map84Screens0
    dfar Map84Attrs0
    dfar Map84Screens0
    dfar Map84Attrs0
    dfar Map84Screens0
    dfar Map84Attrs0
    dfar Map84Screens0
    dfar Map84Attrs0
    dfar Map84Screens0
    dfar Map84Attrs0

; E-0142 (derived: map record of map $85, 2 x 2 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord85::
Data_011_5DF8:: ; heuristic: map record of the map table; C0
    dfar Map85Tileset ; entry 0
    dfar Map85Palettes
    db $02, $02, $3F, $00, $00, $14, $00, $02, $01, $00
    dw wStoryFlags + $64
    dfar Map85Screens0
    dfar Map85Attrs0
    dfar Map85Screens0
    dfar Map85Attrs0
    dfar Map85Screens0
    dfar Map85Attrs0
    dfar Map85Screens0
    dfar Map85Attrs0
    dfar Map85Screens0
    dfar Map85Attrs0

; E-0142 (derived: map record of map $86, 2 x 2 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord86::
Data_011_5E28:: ; heuristic: map record of the map table; C0
    dfar Map85Tileset ; entry 0
    dfar Map85Palettes
    db $02, $02, $2F, $00, $00, $14, $00, $02, $01, $00
    dw wStoryFlags + $64
    dfar Map86Screens0
    dfar Map86Attrs0
    dfar Map86Screens0
    dfar Map86Attrs0
    dfar Map86Screens0
    dfar Map86Attrs0
    dfar Map86Screens0
    dfar Map86Attrs0
    dfar Map86Screens0
    dfar Map86Attrs0

; E-0142 (derived: map record of map $87, 2 x 2 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord87::
Data_011_5E58:: ; heuristic: map record of the map table; C0
    dfar Map85Tileset ; entry 0
    dfar Map85Palettes
    db $02, $02, $2F, $00, $00, $14, $00, $02, $01, $00
    dw wStoryFlags + $64
    dfar Map87Screens0
    dfar Map87Attrs0
    dfar Map87Screens0
    dfar Map87Attrs0
    dfar Map87Screens0
    dfar Map87Attrs0
    dfar Map87Screens0
    dfar Map87Attrs0
    dfar Map87Screens0
    dfar Map87Attrs0

; E-0142 (derived: map record of map $88, 2 x 2 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord88::
Data_011_5E88:: ; heuristic: map record of the map table; C0
    dfar Map85Tileset ; entry 0
    dfar Map85Palettes
    db $02, $02, $2F, $00, $00, $14, $00, $02, $01, $00
    dw wStoryFlags + $64
    dfar Map88Screens0
    dfar Map88Attrs0
    dfar Map88Screens0
    dfar Map88Attrs0
    dfar Map88Screens0
    dfar Map88Attrs0
    dfar Map88Screens0
    dfar Map88Attrs0
    dfar Map88Screens0
    dfar Map88Attrs0

; E-0142 (derived: map record of map $89, 2 x 2 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord89::
Data_011_5EB8:: ; heuristic: map record of the map table; C0
    dfar Map89Tileset ; entry 0
    dfar Map89Palettes
    db $02, $02, $48, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $64
    dfar Map89Screens0
    dfar Map89Attrs0
    dfar Map89Screens0
    dfar Map89Attrs0
    dfar Map89Screens0
    dfar Map89Attrs0
    dfar Map89Screens0
    dfar Map89Attrs0
    dfar Map89Screens0
    dfar Map89Attrs0

; E-0142 (derived: map record of map $8A, 1 x 1 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord8A::
Data_011_5EE8:: ; heuristic: map record of the map table; C0
    dfar Map8ATileset ; entry 0
    dfar Map8APalettes
    db $01, $01, $33, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $64
    dfar Map8AScreens0
    dfar Map8AAttrs0
    dfar Map8AScreens0
    dfar Map8AAttrs0
    dfar Map8AScreens0
    dfar Map8AAttrs0
    dfar Map8AScreens0
    dfar Map8AAttrs0
    dfar Map8AScreens0
    dfar Map8AAttrs0

; E-0142 (derived: map record of map $8B, 3 x 4 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord8B::
Data_011_5F18:: ; heuristic: map record of the map table; C0
    dfar Map8BTileset ; entry 0
    dfar Map8BPalettes
    db $03, $04, $2D, $00, $00, $15, $00, $00, $00, $00
    dw wStoryFlags + $64
    dfar Map8BScreens0
    dfar Map8BAttrs0
    dfar Map8BScreens0
    dfar Map8BAttrs0
    dfar Map8BScreens0
    dfar Map8BAttrs0
    dfar Map8BScreens0
    dfar Map8BAttrs0
    dfar Map8BScreens0
    dfar Map8BAttrs0

; E-0142 (derived: map record of map $8C, 3 x 3 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord8C::
Data_011_5F48:: ; heuristic: map record of the map table; C0
    dfar Map8CTileset ; entry 0
    dfar Map8CPalettes
    db $03, $03, $4F, $00, $00, $15, $00, $00, $00, $00
    dw wStoryFlags + $64
    dfar Map8CScreens0
    dfar Map8CAttrs0
    dfar Map8CScreens0
    dfar Map8CAttrs0
    dfar Map8CScreens0
    dfar Map8CAttrs0
    dfar Map8CScreens0
    dfar Map8CAttrs0
    dfar Map8CScreens0
    dfar Map8CAttrs0

; E-0142 (derived: map record of map $8D, 1 x 1 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord8D::
Data_011_5F78:: ; heuristic: map record of the map table; C0
    dfar Map8DTileset ; entry 0
    dfar Map8DPalettes
    db $01, $01, $2C, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $64
    dfar Map8DScreens0
    dfar Map8DAttrs0
    dfar Map8DScreens1
    dfar Map8DAttrs1
    dfar Map8DScreens1
    dfar Map8DAttrs1
    dfar Map8DScreens1
    dfar Map8DAttrs1
    dfar Map8DScreens1
    dfar Map8DAttrs1

; E-0142 (derived: map record of map $8E, 3 x 3 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord8E::
Data_011_5FA8:: ; heuristic: map record of the map table; C0
    dfar Map8ETileset ; entry 0
    dfar Map8EPalettes
    db $03, $03, $53, $00, $00, $15, $00, $00, $00, $00
    dw wStoryFlags + $64
    dfar Map8EScreens0
    dfar Map8EAttrs0
    dfar Map8EScreens0
    dfar Map8EAttrs0
    dfar Map8EScreens0
    dfar Map8EAttrs0
    dfar Map8EScreens3
    dfar Map8EAttrs3
    dfar Map8EScreens3
    dfar Map8EAttrs3

; E-0142 (derived: map record of map $8F, 1 x 1 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord8F::
Data_011_5FD8:: ; heuristic: map record of the map table; C0
    dfar Map8FTileset ; entry 0
    dfar Map8FPalettes
    db $01, $01, $2F, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $64
    dfar Map8FScreens0
    dfar Map8FAttrs0
    dfar Map8FScreens0
    dfar Map8FAttrs0
    dfar Map8FScreens2
    dfar Map8FAttrs2
    dfar Map8FScreens2
    dfar Map8FAttrs2
    dfar Map8FScreens2
    dfar Map8FAttrs2

; E-0142 (derived: map record of map $90, 3 x 2 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord90::
Data_011_6008:: ; heuristic: map record of the map table; C0
    dfar Map8CTileset ; entry 0
    dfar Map8CPalettes
    db $03, $02, $4F, $00, $00, $15, $00, $00, $00, $00
    dw wStoryFlags + $64
    dfar Map90Screens0
    dfar Map90Attrs0
    dfar Map90Screens0
    dfar Map90Attrs0
    dfar Map90Screens0
    dfar Map90Attrs0
    dfar Map90Screens0
    dfar Map90Attrs0
    dfar Map90Screens0
    dfar Map90Attrs0

; E-0142 (derived: map record of map $91, 1 x 1 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord91::
Data_011_6038:: ; heuristic: map record of the map table; C0
    dfar Map91Tileset ; entry 0
    dfar Map91Palettes
    db $01, $01, $3B, $00, $03, $00, $00, $00, $00, $00
    dw wStoryFlags + $64
    dfar Map91Screens0
    dfar Map91Attrs0
    dfar Map91Screens0
    dfar Map91Attrs0
    dfar Map91Screens0
    dfar Map91Attrs0
    dfar Map91Screens0
    dfar Map91Attrs0
    dfar Map91Screens0
    dfar Map91Attrs0

; E-0142 (derived: map record of map $92, 1 x 1 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord92::
Data_011_6068:: ; heuristic: map record of the map table; C0
    dfar Map92Tileset ; entry 0
    dfar Map92Palettes
    db $01, $01, $17, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $64
    dfar Map92Screens0
    dfar Map92Attrs0
    dfar Map92Screens0
    dfar Map92Attrs0
    dfar Map92Screens0
    dfar Map92Attrs0
    dfar Map92Screens0
    dfar Map92Attrs0
    dfar Map92Screens0
    dfar Map92Attrs0

; E-0142 (derived: map record of map $93, 1 x 1 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord93::
Data_011_6098:: ; heuristic: map record of the map table; C0
    dfar Map93Tileset ; entry 0
    dfar Map93Palettes
    db $01, $01, $24, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $64
    dfar Map93Screens0
    dfar Map93Attrs0
    dfar Map93Screens0
    dfar Map93Attrs0
    dfar Map93Screens0
    dfar Map93Attrs0
    dfar Map93Screens0
    dfar Map93Attrs0
    dfar Map93Screens0
    dfar Map93Attrs0

; E-0142 (derived: map record of map $94, 3 x 3 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord94::
Data_011_60C8:: ; heuristic: map record of the map table; C0
    dfar Map94Tileset ; entry 0
    dfar Map94Palettes
    db $03, $03, $3F, $00, $04, $00, $00, $00, $00, $00
    dw wStoryFlags + $64
    dfar Map94Screens0
    dfar Map94Attrs0
    dfar Map94Screens0
    dfar Map94Attrs0
    dfar Map94Screens0
    dfar Map94Attrs0
    dfar Map94Screens0
    dfar Map94Attrs0
    dfar Map94Screens0
    dfar Map94Attrs0

; E-0142 (derived: map record of map $95, 2 x 3 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord95::
Data_011_60F8:: ; heuristic: map record of the map table; C0
    dfar Map94Tileset ; entry 0
    dfar Map94Palettes
    db $02, $03, $3F, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $64
    dfar Map95Screens0
    dfar Map95Attrs0
    dfar Map95Screens0
    dfar Map95Attrs0
    dfar Map95Screens0
    dfar Map95Attrs0
    dfar Map95Screens0
    dfar Map95Attrs0
    dfar Map95Screens0
    dfar Map95Attrs0

; E-0142 (derived: map record of map $96, 2 x 2 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord96::
Data_011_6128:: ; heuristic: map record of the map table; C0
    dfar Map94Tileset ; entry 0
    dfar Map94Palettes
    db $02, $02, $3F, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $64
    dfar Map96Screens0
    dfar Map96Attrs0
    dfar Map96Screens0
    dfar Map96Attrs0
    dfar Map96Screens0
    dfar Map96Attrs0
    dfar Map96Screens0
    dfar Map96Attrs0
    dfar Map96Screens0
    dfar Map96Attrs0

; E-0142 (derived: map record of map $97, 1 x 1 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord97::
Data_011_6158:: ; heuristic: map record of the map table; C0
    dfar Map97Tileset ; entry 0
    dfar Map97Palettes
    db $01, $01, $3F, $00, $00, $00, $00, $02, $1F, $00
    dw wStoryFlags + $64
    dfar Map97Screens0
    dfar Map97Attrs0
    dfar Map97Screens0
    dfar Map97Attrs0
    dfar Map97Screens0
    dfar Map97Attrs0
    dfar Map97Screens0
    dfar Map97Attrs0
    dfar Map97Screens0
    dfar Map97Attrs0

; E-0142 (derived: map record of map $98, 1 x 1 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord98::
Data_011_6188:: ; heuristic: map record of the map table; C0
    dfar Map97Tileset ; entry 0
    dfar Map97Palettes
    db $01, $01, $3F, $00, $00, $00, $00, $02, $1F, $00
    dw wStoryFlags + $64
    dfar Map98Screens0
    dfar Map98Attrs0
    dfar Map98Screens0
    dfar Map98Attrs0
    dfar Map98Screens0
    dfar Map98Attrs0
    dfar Map98Screens0
    dfar Map98Attrs0
    dfar Map98Screens0
    dfar Map98Attrs0

; E-0142 (derived: map record of map $99, 1 x 1 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord99::
Data_011_61B8:: ; heuristic: map record of the map table; C0
    dfar Map97Tileset ; entry 0
    dfar Map97Palettes
    db $01, $01, $3F, $00, $00, $00, $00, $02, $1F, $00
    dw wStoryFlags + $64
    dfar Map99Screens0
    dfar Map99Attrs0
    dfar Map99Screens0
    dfar Map99Attrs0
    dfar Map99Screens0
    dfar Map99Attrs0
    dfar Map99Screens0
    dfar Map99Attrs0
    dfar Map99Screens0
    dfar Map99Attrs0

; E-0142 (derived: map record of map $9A, 1 x 1 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord9A::
Data_011_61E8:: ; heuristic: map record of the map table; C0
    dfar Map97Tileset ; entry 0
    dfar Map97Palettes
    db $01, $01, $3F, $00, $00, $00, $00, $02, $1F, $00
    dw wStoryFlags + $64
    dfar Map9AScreens0
    dfar Map9AAttrs0
    dfar Map9AScreens0
    dfar Map9AAttrs0
    dfar Map9AScreens0
    dfar Map9AAttrs0
    dfar Map9AScreens0
    dfar Map9AAttrs0
    dfar Map9AScreens0
    dfar Map9AAttrs0

; E-0142 (derived: map record of map $9B, 1 x 3 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord9B::
Data_011_6218:: ; heuristic: map record of the map table; C0
    dfar Map9BTileset ; entry 0
    dfar Map9BPalettes
    db $01, $03, $4F, $00, $00, $00, $00, $02, $0F, $00
    dw wStoryFlags + $64
    dfar Map9BScreens0
    dfar Map9BAttrs0
    dfar Map9BScreens0
    dfar Map9BAttrs0
    dfar Map9BScreens0
    dfar Map9BAttrs0
    dfar Map9BScreens0
    dfar Map9BAttrs0
    dfar Map9BScreens4
    dfar Map9BAttrs4
    db $45, $77, $93, $D4, $78, $93, $01, $01, $1F, $1C, $00, $00, $00, $02, $06, $00, $3B, $CC, $14, $79, $93, $17, $79, $93, $14, $79, $93, $17, $79, $93, $14, $79, $93, $17, $79, $93, $14, $79, $93, $17, $79, $93, $14, $79, $93, $17, $79, $93

; E-0142 (derived: map record of map $A0, 4 x 3 screens, 2 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordA0::
Data_011_6278:: ; heuristic: map record of the map table; C0
    dfar MapA0Tileset ; entry 0
    dfar MapA0Palettes
    db $04, $03, $3F, $00, $01, $16, $00, $02, $29, $00
    dw wStoryFlags + $65
    dfar MapA0Screens0
    dfar MapA0Attrs0
    dfar MapA0Screens1
    dfar MapA0Attrs1

; E-0142 (derived: map record of map $A1, 1 x 3 screens, 2 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordA1::
Data_011_6296:: ; heuristic: map record of the map table; C0
    dfar MapA1Tileset ; entry 0
    dfar MapA1Palettes
    db $01, $03, $5F, $00, $05, $00, $00, $00, $00, $00
    dw wStoryFlags + $65
    dfar MapA1Screens0
    dfar MapA1Attrs0
    dfar MapA1Screens1
    dfar MapA1Attrs1

; E-0142 (derived: map record of map $A2, 3 x 4 screens, 2 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordA2::
Data_011_62B4:: ; heuristic: map record of the map table; C0
    dfar MapA2Tileset ; entry 0
    dfar MapA2Palettes
    db $03, $04, $55, $00, $01, $17, $00, $02, $07, $00
    dw wStoryFlags + $65
    dfar MapA2Screens0
    dfar MapA2Attrs0
    dfar MapA2Screens0
    dfar MapA2Attrs0

; E-0142 (derived: map record of map $A3, 1 x 2 screens, 2 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordA3::
Data_011_62D2:: ; heuristic: map record of the map table; C0
    dfar MapA3Tileset ; entry 0
    dfar MapA3Palettes
    db $01, $02, $68, $00, $0A, $00, $00, $00, $00, $00
    dw wStoryFlags + $65
    dfar MapA3Screens0
    dfar MapA3Attrs0
    dfar MapA3Screens0
    dfar MapA3Attrs0
    db $B4, $6F, $90, $BE, $7D, $68, $01, $01, $1F, $1C, $00, $00, $00, $00, $00, $00, $3C, $CC, $FE, $7D, $68, $01, $7E, $68, $FE, $7D, $68, $01, $7E, $68

; E-0142 (derived: map record of map $A8, 6 x 6 screens, 1 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordA8::
Data_011_630E:: ; heuristic: map record of the map table; C0
    dfar MapA8Tileset ; entry 0
    dfar MapA8Palettes
    db $06, $06, $3B, $00, $00, $18, $00, $00, $00, $00
    dw wStoryFlags + $66
    dfar MapA8Screens0
    dfar MapA8Attrs0

; E-0142 (derived: map record of map $A9, 2 x 2 screens, 1 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordA9::
Data_011_6326:: ; heuristic: map record of the map table; C0
    dfar MapA9Tileset ; entry 0
    dfar MapA9Palettes
    db $02, $02, $2D, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $66
    dfar MapA9Screens0
    dfar MapA9Attrs0

; E-0142 (derived: map record of map $AA, 1 x 2 screens, 1 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordAA::
Data_011_633E:: ; heuristic: map record of the map table; C0
    dfar MapA9Tileset ; entry 0
    dfar MapA9Palettes
    db $01, $02, $2D, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $66
    dfar MapAAScreens0
    dfar MapAAAttrs0

; E-0142 (derived: map record of map $AB, 1 x 1 screens, 1 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordAB::
Data_011_6356:: ; heuristic: map record of the map table; C0
    dfar MapA9Tileset ; entry 0
    dfar MapA9Palettes
    db $01, $01, $2D, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $66
    dfar MapABScreens0
    dfar MapABAttrs0

; E-0142 (derived: map record of map $AC, 1 x 1 screens, 1 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordAC::
Data_011_636E:: ; heuristic: map record of the map table; C0
    dfar MapACTileset ; entry 0
    dfar MapACPalettes
    db $01, $01, $31, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $66
    dfar MapACScreens0
    dfar MapACAttrs0

; E-0142 (derived: map record of map $AD, 3 x 4 screens, 1 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordAD::
Data_011_6386:: ; heuristic: map record of the map table; C0
    dfar MapADTileset ; entry 0
    dfar MapADPalettes
    db $03, $04, $3F, $00, $00, $19, $01, $00, $00, $00
    dw wStoryFlags + $66
    dfar MapADScreens0
    dfar MapADAttrs0

; E-0142 (derived: map record of map $AE, 3 x 4 screens, 1 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordAE::
Data_011_639E:: ; heuristic: map record of the map table; C0
    dfar MapADTileset ; entry 0
    dfar MapADPalettes
    db $03, $04, $3F, $00, $00, $19, $01, $00, $00, $00
    dw wStoryFlags + $66
    dfar MapAEScreens0
    dfar MapAEAttrs0

; E-0142 (derived: map record of map $B0, 3 x 2 screens, 2 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordB0::
Data_011_63B6:: ; heuristic: map record of the map table; C0
    dfar MapB0Tileset ; entry 0
    dfar MapB0Palettes
    db $03, $02, $3F, $00, $00, $1A, $00, $00, $00, $00
    dw wStoryFlags + $67
    dfar MapB0Screens0
    dfar MapB0Attrs0
    dfar MapB0Screens0
    dfar MapB0Attrs0

; E-0142 (derived: map record of map $B1, 1 x 1 screens, 2 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordB1::
Data_011_63D4:: ; heuristic: map record of the map table; C0
    dfar MapB1Tileset ; entry 0
    dfar MapB1Palettes
    db $01, $01, $37, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $67
    dfar MapB1Screens0
    dfar MapB1Attrs0
    dfar MapB1Screens0
    dfar MapB1Attrs0

; E-0142 (derived: map record of map $B3, 2 x 2 screens, 2 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordB3::
Data_011_63F2:: ; heuristic: map record of the map table; C0
    dfar MapB3Tileset ; entry 0
    dfar MapB3Palettes
    db $02, $02, $1F, $00, $00, $1B, $00, $00, $00, $00
    dw wStoryFlags + $67
    dfar MapB3Screens0
    dfar MapB3Attrs0
    dfar MapB3Screens0
    dfar MapB3Attrs0

; E-0142 (derived: map record of map $B4, 2 x 2 screens, 2 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordB4::
Data_011_6410:: ; heuristic: map record of the map table; C0
    dfar MapB3Tileset ; entry 0
    dfar MapB3Palettes
    db $02, $02, $1F, $00, $00, $1B, $00, $00, $00, $00
    dw wStoryFlags + $67
    dfar MapB4Screens0
    dfar MapB4Attrs0
    dfar MapB4Screens0
    dfar MapB4Attrs0

; E-0142 (derived: map record of map $B5, 2 x 2 screens, 2 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordB5::
Data_011_642E:: ; heuristic: map record of the map table; C0
    dfar MapB3Tileset ; entry 0
    dfar MapB3Palettes
    db $02, $02, $1F, $00, $00, $1B, $00, $00, $00, $00
    dw wStoryFlags + $67
    dfar MapB5Screens0
    dfar MapB5Attrs0
    dfar MapB5Screens0
    dfar MapB5Attrs0

; E-0142 (derived: map record of map $B6, 1 x 1 screens, 2 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordB6::
Data_011_644C:: ; heuristic: map record of the map table; C0
    dfar MapB3Tileset ; entry 0
    dfar MapB3Palettes
    db $01, $01, $1F, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $67
    dfar MapB6Screens0
    dfar MapB6Attrs0
    dfar MapB6Screens0
    dfar MapB6Attrs0

; E-0142 (derived: map record of map $B8, 5 x 5 screens, 3 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordB8::
Data_011_646A:: ; heuristic: map record of the map table; C0
    dfar MapB8Tileset ; entry 0
    dfar MapB8Palettes
    db $05, $05, $3F, $00, $01, $1C, $00, $01, $29, $00
    dw wStoryFlags + $68
    dfar MapB8Screens0
    dfar MapB8Attrs0
    dfar MapB8Screens0
    dfar MapB8Attrs0
    dfar MapB8Screens0
    dfar MapB8Attrs0

; E-0142 (derived: map record of map $B9, 2 x 2 screens, 3 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordB9::
Data_011_648E:: ; heuristic: map record of the map table; C0
    dfar MapB9Tileset ; entry 0
    dfar MapB9Palettes
    db $02, $02, $3D, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $68
    dfar MapB9Screens0
    dfar MapB9Attrs0
    dfar MapB9Screens0
    dfar MapB9Attrs0
    dfar MapB9Screens0
    dfar MapB9Attrs0

; E-0142 (derived: map record of map $BA, 1 x 2 screens, 3 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordBA::
Data_011_64B2:: ; heuristic: map record of the map table; C0
    dfar MapBATileset ; entry 0
    dfar MapBAPalettes
    db $01, $02, $39, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $68
    dfar MapBAScreens0
    dfar MapBAAttrs0
    dfar MapBAScreens0
    dfar MapBAAttrs0
    dfar MapBAScreens0
    dfar MapBAAttrs0

; E-0142 (derived: map record of map $BB, 1 x 2 screens, 3 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordBB::
Data_011_64D6:: ; heuristic: map record of the map table; C0
    dfar MapBBTileset ; entry 0
    dfar MapBBPalettes
    db $01, $02, $0F, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $68
    dfar MapBBScreens0
    dfar MapBBAttrs0
    dfar MapBBScreens1
    dfar MapBBAttrs1
    dfar MapBBScreens1
    dfar MapBBAttrs1

; E-0142 (derived: map record of map $BC, 1 x 1 screens, 3 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordBC::
Data_011_64FA:: ; heuristic: map record of the map table; C0
    dfar MapBCTileset ; entry 0
    dfar MapBCPalettes
    db $01, $01, $2C, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $68
    dfar MapBCScreens0
    dfar MapBCAttrs0
    dfar MapBCScreens0
    dfar MapBCAttrs0
    dfar MapBCScreens0
    dfar MapBCAttrs0

; E-0142 (derived: map record of map $BD, 1 x 1 screens, 3 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordBD::
Data_011_651E:: ; heuristic: map record of the map table; C0
    dfar MapBDTileset ; entry 0
    dfar MapBDPalettes
    db $01, $01, $3F, $00, $00, $00, $03, $00, $00, $00
    dw wStoryFlags + $68
    dfar MapBDScreens0
    dfar MapBDAttrs0
    dfar MapBDScreens0
    dfar MapBDAttrs0
    dfar MapBDScreens0
    dfar MapBDAttrs0

; E-0142 (derived: map record of map $BE, 1 x 1 screens, 3 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordBE::
Data_011_6542:: ; heuristic: map record of the map table; C0
    dfar MapBDTileset ; entry 0
    dfar MapBDPalettes
    db $01, $01, $3F, $00, $00, $1D, $03, $00, $00, $00
    dw wStoryFlags + $68
    dfar MapBEScreens0
    dfar MapBEAttrs0
    dfar MapBEScreens0
    dfar MapBEAttrs0
    dfar MapBEScreens0
    dfar MapBEAttrs0

; E-0142 (derived: map record of map $BF, 2 x 2 screens, 3 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordBF::
Data_011_6566:: ; heuristic: map record of the map table; C0
    dfar MapBDTileset ; entry 0
    dfar MapBDPalettes
    db $02, $02, $3F, $00, $00, $1E, $03, $00, $00, $00
    dw wStoryFlags + $68
    dfar MapBFScreens0
    dfar MapBFAttrs0
    dfar MapBFScreens0
    dfar MapBFAttrs0
    dfar MapBFScreens2
    dfar MapBFAttrs2

; E-0142 (derived: map record of map $C0, 2 x 2 screens, 3 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordC0::
Data_011_658A:: ; heuristic: map record of the map table; C0
    dfar MapBDTileset ; entry 0
    dfar MapBDPalettes
    db $02, $02, $3F, $00, $00, $1F, $03, $00, $00, $00
    dw wStoryFlags + $68
    dfar MapC0Screens0
    dfar MapC0Attrs0
    dfar MapC0Screens0
    dfar MapC0Attrs0
    dfar MapC0Screens0
    dfar MapC0Attrs0

; E-0142 (derived: map record of map $C1, 2 x 2 screens, 3 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordC1::
Data_011_65AE:: ; heuristic: map record of the map table; C0
    dfar MapBDTileset ; entry 0
    dfar MapBDPalettes
    db $02, $02, $3F, $00, $00, $1F, $03, $00, $00, $00
    dw wStoryFlags + $68
    dfar MapC1Screens0
    dfar MapC1Attrs0
    dfar MapC1Screens0
    dfar MapC1Attrs0
    dfar MapC1Screens0
    dfar MapC1Attrs0

; E-0142 (derived: map record of map $C2, 2 x 2 screens, 3 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordC2::
Data_011_65D2:: ; heuristic: map record of the map table; C0
    dfar MapBDTileset ; entry 0
    dfar MapBDPalettes
    db $02, $02, $3F, $00, $00, $20, $03, $00, $00, $00
    dw wStoryFlags + $68
    dfar MapC2Screens0
    dfar MapC2Attrs0
    dfar MapC2Screens0
    dfar MapC2Attrs0
    dfar MapC2Screens0
    dfar MapC2Attrs0

; E-0142 (derived: map record of map $C3, 2 x 2 screens, 3 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordC3::
Data_011_65F6:: ; heuristic: map record of the map table; C0
    dfar MapBDTileset ; entry 0
    dfar MapBDPalettes
    db $02, $02, $3F, $00, $00, $20, $03, $00, $00, $00
    dw wStoryFlags + $68
    dfar MapC3Screens0
    dfar MapC3Attrs0
    dfar MapC3Screens0
    dfar MapC3Attrs0
    dfar MapC3Screens0
    dfar MapC3Attrs0

; E-0142 (derived: map record of map $C4, 1 x 1 screens, 3 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordC4::
Data_011_661A:: ; heuristic: map record of the map table; C0
    dfar MapBDTileset ; entry 0
    dfar MapBDPalettes
    db $01, $01, $3F, $00, $00, $00, $03, $00, $00, $00
    dw wStoryFlags + $68
    dfar MapC4Screens0
    dfar MapC4Attrs0
    dfar MapC4Screens0
    dfar MapC4Attrs0
    dfar MapC4Screens0
    dfar MapC4Attrs0

; E-0142 (derived: map record of map $C8, 1 x 2 screens, 2 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordC8::
Data_011_663E:: ; heuristic: map record of the map table; C0
    dfar MapC8Tileset ; entry 0
    dfar MapC8Palettes
    db $01, $02, $3F, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $69
    dfar MapC8Screens0
    dfar MapC8Attrs0
    dfar MapC8Screens0
    dfar MapC8Attrs0

; E-0142 (derived: map record of map $C9, 1 x 2 screens, 2 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordC9::
Data_011_665C:: ; heuristic: map record of the map table; C0
    dfar MapC9Tileset ; entry 0
    dfar MapC9Palettes
    db $01, $02, $4F, $00, $04, $00, $00, $00, $00, $00
    dw wStoryFlags + $69
    dfar MapC9Screens0
    dfar MapC9Attrs0
    dfar MapC9Screens0
    dfar MapC9Attrs0

; E-0142 (derived: map record of map $CA, 1 x 2 screens, 2 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordCA::
Data_011_667A:: ; heuristic: map record of the map table; C0
    dfar MapC9Tileset ; entry 0
    dfar MapC9Palettes
    db $01, $02, $4F, $00, $04, $00, $00, $00, $00, $00
    dw wStoryFlags + $69
    dfar MapCAScreens0
    dfar MapCAAttrs0
    dfar MapCAScreens0
    dfar MapCAAttrs0

; E-0142 (derived: map record of map $CE, 1 x 2 screens, 2 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordCE::
Data_011_6698:: ; heuristic: map record of the map table; C0
    dfar MapC9Tileset ; entry 0
    dfar MapC9Palettes
    db $01, $02, $4F, $00, $04, $00, $00, $00, $00, $00
    dw wStoryFlags + $69
    dfar MapCEScreens0
    dfar MapCEAttrs0
    dfar MapCEScreens0
    dfar MapCEAttrs0

; E-0142 (derived: map record of map $D1, 1 x 2 screens, 2 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordD1::
Data_011_66B6:: ; heuristic: map record of the map table; C0
    dfar MapD1Tileset ; entry 0
    dfar MapD1Palettes
    db $01, $02, $3F, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $69
    dfar MapD1Screens0
    dfar MapD1Attrs0
    dfar MapD1Screens0
    dfar MapD1Attrs0

; E-0142 (derived: map record of map $D2, 1 x 2 screens, 2 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordD2::
Data_011_66D4:: ; heuristic: map record of the map table; C0
    dfar MapD2Tileset ; entry 0
    dfar MapD2Palettes
    db $01, $02, $4F, $00, $04, $00, $00, $00, $00, $00
    dw wStoryFlags + $69
    dfar MapC9Screens0
    dfar MapC9Attrs0
    dfar MapC9Screens0
    dfar MapC9Attrs0

; E-0142 (derived: map record of map $D3, 1 x 2 screens, 2 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordD3::
Data_011_66F2:: ; heuristic: map record of the map table; C0
    dfar MapD2Tileset ; entry 0
    dfar MapD2Palettes
    db $01, $02, $4F, $00, $04, $00, $00, $00, $00, $00
    dw wStoryFlags + $69
    dfar MapCAScreens0
    dfar MapCAAttrs0
    dfar MapCAScreens0
    dfar MapCAAttrs0

; E-0142 (derived: map record of map $D7, 1 x 2 screens, 2 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordD7::
Data_011_6710:: ; heuristic: map record of the map table; C0
    dfar MapD2Tileset ; entry 0
    dfar MapD2Palettes
    db $01, $02, $4F, $00, $04, $00, $00, $00, $00, $00
    dw wStoryFlags + $69
    dfar MapD7Screens0
    dfar MapD7Attrs0
    dfar MapD7Screens0
    dfar MapD7Attrs0

; E-0142 (derived: map record of map $DA, 2 x 1 screens, 2 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordDA::
Data_011_672E:: ; heuristic: map record of the map table; C0
    dfar MapDATileset ; entry 0
    dfar MapDAPalettes
    db $02, $01, $3F, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $69
    dfar MapDAScreens0
    dfar MapDAAttrs0
    dfar MapDAScreens0
    dfar MapDAAttrs0

; E-0142 (derived: map record of map $DB, 1 x 2 screens, 2 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordDB::
Data_011_674C:: ; heuristic: map record of the map table; C0
    dfar MapDBTileset ; entry 0
    dfar MapDBPalettes
    db $01, $02, $4F, $00, $04, $00, $00, $00, $00, $00
    dw wStoryFlags + $69
    dfar MapC9Screens0
    dfar MapC9Attrs0
    dfar MapC9Screens0
    dfar MapC9Attrs0

; E-0142 (derived: map record of map $DC, 1 x 2 screens, 2 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordDC::
Data_011_676A:: ; heuristic: map record of the map table; C0
    dfar MapDBTileset ; entry 0
    dfar MapDBPalettes
    db $01, $02, $4F, $00, $04, $00, $00, $00, $00, $00
    dw wStoryFlags + $69
    dfar MapCAScreens0
    dfar MapCAAttrs0
    dfar MapCAScreens0
    dfar MapCAAttrs0

; E-0142 (derived: map record of map $E0, 1 x 2 screens, 2 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordE0::
Data_011_6788:: ; heuristic: map record of the map table; C0
    dfar MapDBTileset ; entry 0
    dfar MapDBPalettes
    db $01, $02, $4F, $00, $04, $00, $00, $00, $00, $00
    dw wStoryFlags + $69
    dfar MapE0Screens0
    dfar MapE0Attrs0
    dfar MapE0Screens0
    dfar MapE0Attrs0

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
