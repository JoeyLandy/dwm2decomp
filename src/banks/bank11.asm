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
    ld de, MapWarpTable
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
    farcall ClearPendingFieldEventIfBit7AndNot6
    pop de
    ld c, $01
    ret

; special maps use CheckWarpsByMapType; otherwise checks the map exit table, then the warp list Data_011_67A6[hMapId] against the player position and warps on a match (E-0131)
; 3 call sites from 3 routines (e.g. FieldModeStateDispatch_Case07, UpdatePlayerMovement_Sub01, RunFieldActionRequestActionIfBit7_Case03)
; reads: wMapType, hMapId, hPlayerStateFlags, hMapScreenX, hMapScreenY, hPlayerX, hPlayerY, wWarpDestY
; writes: hPlayerStateFlags, wWarpDestFacing, wWarpPending, hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, ...
; points at: wFieldInitStage
CheckWarpsAtPlayerPosition::
Func_011_4130:: ; address name
    ld a, [wMapType]
    bit 7, a
    jr z, Jump_011_413E
    farcall CheckWarpsByMapType
    ret

Jump_011_413E::
    call CheckMapExitTable4480
    bit 0, c
    ret nz
    ldh a, [hMapId]
    ld l, a
    ld h, $00
    add hl, hl
    ld de, MapWarpTable
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
    farcall ClearPendingFieldEventIfBit7AndNot6
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

; address loaded by WarpToLinkedMapForCurrentMap
Data_011_42AC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $29, $45, $68, $9D, $A4, $AF, $B2, $C5, $D0, $D9, $E2, $FF

; address loaded by WarpToLinkedMapForCurrentMap
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
    farcall ClearPendingFieldEventIfBit7AndNot6
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
    farcall ClearPendingFieldEventIfBit7AndNot6
    ld c, $01
    ret

; address loaded by CheckMapExitTable4480
Data_011_4480:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $20, $44, $00, $01, $30, $44, $76, $02, $48, $44, $B4, $03, $70, $44, $B4, $04
    db $A0, $44, $10, $05, $A8, $44, $00, $06, $B0, $44, $01, $07, $B8, $44, $44, $08
    db $C8, $44, $01, $09, $D1, $44, $00, $0A, $DA, $44, $00, $0B, $FF

; address loaded by CheckMapExitTable4480_Sub01
Data_011_44AD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $29, $45, $68, $9D, $A4, $AF, $B2, $C5, $D0, $D9, $E2

; E-0036 (C1: the pointer for map 56 is the record whose tileset stream (57:6E96) the game decompressed to $9000 on the emulator while hMapId was 56; the table has 256 words and ends where the first record begins; entries 30, 31 and 39 are not valid pointers and the system strings for map numbers 30, 31 and 39 (index 10 + number) read 'NO'; map 29 is the ship deck where a new game starts and the string at index 39 is 'Deck'). Records are 48 or 66 bytes; the first three far pointers (address and bank byte) name streams: the tileset for $9000 and, in later fields, the tile map for $C198 and the attribute map for $D000. E-0201: the complete map records at $59E4, $6248 and $62F0 (1 x 1 screens, found as trailing bytes of the records before them) have no entry here and are listed as extra records.
; record: map record in this bank, indexed by the map number hMapId
MapTable::
Data_011_44B8:: ; address name
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
Data_011_46B8:: ; address name
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
Data_011_46FA:: ; address name
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
Data_011_473C:: ; address name
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
Data_011_477E:: ; address name
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
Data_011_47C0:: ; address name
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
Data_011_4802:: ; address name
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
Data_011_4844:: ; address name
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
Data_011_4886:: ; address name
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
Data_011_48C8:: ; address name
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
Data_011_490A:: ; address name
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
Data_011_494C:: ; address name
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
Data_011_498E:: ; address name
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
Data_011_49D0:: ; address name
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
Data_011_4A12:: ; address name
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
Data_011_4A54:: ; address name
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
Data_011_4A96:: ; address name
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
Data_011_4AD8:: ; address name
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
Data_011_4B1A:: ; address name
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
Data_011_4B5C:: ; address name
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
Data_011_4B9E:: ; address name
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
Data_011_4BE0:: ; address name
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
Data_011_4C22:: ; address name
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
Data_011_4C64:: ; address name
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
Data_011_4CA6:: ; address name
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
Data_011_4CE8:: ; address name
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
Data_011_4D2A:: ; address name
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
Data_011_4D6C:: ; address name
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
Data_011_4DAE:: ; address name
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
Data_011_4DF0:: ; address name
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
Data_011_4E0E:: ; address name
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
Data_011_4E2C:: ; address name
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
Data_011_4E68:: ; address name
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
Data_011_4EA4:: ; address name
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
Data_011_4EE0:: ; address name
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
Data_011_4F1C:: ; address name
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
Data_011_4F58:: ; address name
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
Data_011_4F94:: ; address name
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
Data_011_4FD0:: ; address name
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
Data_011_500C:: ; address name
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
Data_011_5048:: ; address name
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
Data_011_5084:: ; address name
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
Data_011_50C0:: ; address name
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
Data_011_50FC:: ; address name
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
Data_011_5138:: ; address name
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
Data_011_5174:: ; address name
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
Data_011_51A4:: ; address name
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
Data_011_51D4:: ; address name
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
Data_011_5204:: ; address name
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
Data_011_5234:: ; address name
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
Data_011_5264:: ; address name
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
Data_011_5294:: ; address name
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
Data_011_52C4:: ; address name
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
Data_011_52F4:: ; address name
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
Data_011_5324:: ; address name
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
Data_011_5354:: ; address name
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
Data_011_5384:: ; address name
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
Data_011_53B4:: ; address name
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
Data_011_53E4:: ; address name
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
Data_011_5414:: ; address name
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
Data_011_5444:: ; address name
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
Data_011_5474:: ; address name
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
Data_011_54A4:: ; address name
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
Data_011_54D4:: ; address name
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
Data_011_5504:: ; address name
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
Data_011_5534:: ; address name
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
Data_011_5564:: ; address name
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
Data_011_5588:: ; address name
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
Data_011_55AC:: ; address name
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
Data_011_55D0:: ; address name
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
Data_011_55F4:: ; address name
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
Data_011_5618:: ; address name
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
Data_011_563C:: ; address name
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
Data_011_5660:: ; address name
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
Data_011_5684:: ; address name
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
Data_011_56A8:: ; address name
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
Data_011_56CC:: ; address name
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
Data_011_56F0:: ; address name
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
Data_011_5714:: ; address name
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
Data_011_5738:: ; address name
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
Data_011_575C:: ; address name
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
Data_011_5780:: ; address name
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
Data_011_57A4:: ; address name
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
Data_011_57C8:: ; address name
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
Data_011_57EC:: ; address name
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
Data_011_5810:: ; address name
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
Data_011_5834:: ; address name
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
Data_011_5858:: ; address name
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
Data_011_587C:: ; address name
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
Data_011_58A0:: ; address name
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
Data_011_58C4:: ; address name
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
Data_011_58E8:: ; address name
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
Data_011_590C:: ; address name
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
Data_011_5930:: ; address name
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
Data_011_5954:: ; address name
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
Data_011_5978:: ; address name
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
Data_011_599C:: ; address name
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
Data_011_59C0:: ; address name
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

; E-0142, E-0201 (derived: map record that no MapTable entry points to, 1 x 1 screens, 3 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordX59E4::
Data_011_59E4:: ; address name
    dfar MapX59E4Tileset ; entry 0
    dfar MapX59E4Palettes
    db $01, $01, $1F, $1C, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $63
    dfar MapX59E4Screens0
    dfar MapX59E4Attrs0
    dfar MapX59E4Screens0
    dfar MapX59E4Attrs0
    dfar MapX59E4Screens0
    dfar MapX59E4Attrs0

; E-0142 (derived: map record of map $70, 12 x 12 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord70::
Data_011_5A08:: ; address name
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
Data_011_5A38:: ; address name
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
Data_011_5A68:: ; address name
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
Data_011_5A98:: ; address name
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
Data_011_5AC8:: ; address name
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
Data_011_5AF8:: ; address name
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
Data_011_5B28:: ; address name
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
Data_011_5B58:: ; address name
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
Data_011_5B88:: ; address name
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
Data_011_5BB8:: ; address name
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
Data_011_5BE8:: ; address name
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
Data_011_5C18:: ; address name
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
Data_011_5C48:: ; address name
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
Data_011_5C78:: ; address name
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
    dfar Map7DScreens0
    dfar Map7DAttrs0
    dfar Map7DScreens0
    dfar Map7DAttrs0

; E-0142 (derived: map record of map $7E, 1 x 1 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord7E::
Data_011_5CA8:: ; address name
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
Data_011_5CD8:: ; address name
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
Data_011_5D08:: ; address name
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
    dfar Map80Screens0
    dfar Map80Attrs0
    dfar Map80Screens0
    dfar Map80Attrs0

; E-0142 (derived: map record of map $81, 1 x 1 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecord81::
Data_011_5D38:: ; address name
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
Data_011_5D68:: ; address name
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
Data_011_5D98:: ; address name
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
Data_011_5DC8:: ; address name
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
Data_011_5DF8:: ; address name
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
Data_011_5E28:: ; address name
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
Data_011_5E58:: ; address name
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
Data_011_5E88:: ; address name
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
Data_011_5EB8:: ; address name
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
Data_011_5EE8:: ; address name
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
Data_011_5F18:: ; address name
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
Data_011_5F48:: ; address name
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
Data_011_5F78:: ; address name
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
Data_011_5FA8:: ; address name
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
Data_011_5FD8:: ; address name
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
Data_011_6008:: ; address name
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
Data_011_6038:: ; address name
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
Data_011_6068:: ; address name
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
Data_011_6098:: ; address name
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
Data_011_60C8:: ; address name
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
Data_011_60F8:: ; address name
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
Data_011_6128:: ; address name
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
Data_011_6158:: ; address name
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
Data_011_6188:: ; address name
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
Data_011_61B8:: ; address name
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
Data_011_61E8:: ; address name
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
Data_011_6218:: ; address name
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

; E-0142, E-0201 (derived: map record that no MapTable entry points to, 1 x 1 screens, 5 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordX6248::
Data_011_6248:: ; address name
    dfar MapX6248Tileset ; entry 0
    dfar MapX6248Palettes
    db $01, $01, $1F, $1C, $00, $00, $00, $02, $06, $00
    dw wStoryFlags + $64
    dfar MapX6248Screens0
    dfar MapX6248Attrs0
    dfar MapX6248Screens0
    dfar MapX6248Attrs0
    dfar MapX6248Screens0
    dfar MapX6248Attrs0
    dfar MapX6248Screens0
    dfar MapX6248Attrs0
    dfar MapX6248Screens0
    dfar MapX6248Attrs0

; E-0142 (derived: map record of map $A0, 4 x 3 screens, 2 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordA0::
Data_011_6278:: ; address name
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
Data_011_6296:: ; address name
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
Data_011_62B4:: ; address name
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
Data_011_62D2:: ; address name
    dfar MapA3Tileset ; entry 0
    dfar MapA3Palettes
    db $01, $02, $68, $00, $0A, $00, $00, $00, $00, $00
    dw wStoryFlags + $65
    dfar MapA3Screens0
    dfar MapA3Attrs0
    dfar MapA3Screens0
    dfar MapA3Attrs0

; E-0142, E-0201 (derived: map record that no MapTable entry points to, 1 x 1 screens, 2 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordX62F0::
Data_011_62F0:: ; address name
    dfar MapX62F0Tileset ; entry 0
    dfar MapX62F0Palettes
    db $01, $01, $1F, $1C, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $65
    dfar MapX62F0Screens0
    dfar MapX62F0Attrs0
    dfar MapX62F0Screens0
    dfar MapX62F0Attrs0

; E-0142 (derived: map record of map $A8, 6 x 6 screens, 1 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordA8::
Data_011_630E:: ; address name
    dfar MapA8Tileset ; entry 0
    dfar MapA8Palettes
    db $06, $06, $3B, $00, $00, $18, $00, $00, $00, $00
    dw wStoryFlags + $66
    dfar MapA8Screens0
    dfar MapA8Attrs0

; E-0142 (derived: map record of map $A9, 2 x 2 screens, 1 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordA9::
Data_011_6326:: ; address name
    dfar MapA9Tileset ; entry 0
    dfar MapA9Palettes
    db $02, $02, $2D, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $66
    dfar MapA9Screens0
    dfar MapA9Attrs0

; E-0142 (derived: map record of map $AA, 1 x 2 screens, 1 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordAA::
Data_011_633E:: ; address name
    dfar MapA9Tileset ; entry 0
    dfar MapA9Palettes
    db $01, $02, $2D, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $66
    dfar MapAAScreens0
    dfar MapAAAttrs0

; E-0142 (derived: map record of map $AB, 1 x 1 screens, 1 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordAB::
Data_011_6356:: ; address name
    dfar MapA9Tileset ; entry 0
    dfar MapA9Palettes
    db $01, $01, $2D, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $66
    dfar MapABScreens0
    dfar MapABAttrs0

; E-0142 (derived: map record of map $AC, 1 x 1 screens, 1 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordAC::
Data_011_636E:: ; address name
    dfar MapACTileset ; entry 0
    dfar MapACPalettes
    db $01, $01, $31, $00, $00, $00, $00, $00, $00, $00
    dw wStoryFlags + $66
    dfar MapACScreens0
    dfar MapACAttrs0

; E-0142 (derived: map record of map $AD, 3 x 4 screens, 1 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordAD::
Data_011_6386:: ; address name
    dfar MapADTileset ; entry 0
    dfar MapADPalettes
    db $03, $04, $3F, $00, $00, $19, $01, $00, $00, $00
    dw wStoryFlags + $66
    dfar MapADScreens0
    dfar MapADAttrs0

; E-0142 (derived: map record of map $AE, 3 x 4 screens, 1 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordAE::
Data_011_639E:: ; address name
    dfar MapADTileset ; entry 0
    dfar MapADPalettes
    db $03, $04, $3F, $00, $00, $19, $01, $00, $00, $00
    dw wStoryFlags + $66
    dfar MapAEScreens0
    dfar MapAEAttrs0

; E-0142 (derived: map record of map $B0, 3 x 2 screens, 2 decoded variant(s))
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen array, attribute array
MapRecordB0::
Data_011_63B6:: ; address name
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
Data_011_63D4:: ; address name
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
Data_011_63F2:: ; address name
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
Data_011_6410:: ; address name
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
Data_011_642E:: ; address name
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
Data_011_644C:: ; address name
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
Data_011_646A:: ; address name
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
Data_011_648E:: ; address name
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
Data_011_64B2:: ; address name
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
Data_011_64D6:: ; address name
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
Data_011_64FA:: ; address name
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
Data_011_651E:: ; address name
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
Data_011_6542:: ; address name
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
Data_011_6566:: ; address name
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
Data_011_658A:: ; address name
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
Data_011_65AE:: ; address name
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
Data_011_65D2:: ; address name
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
Data_011_65F6:: ; address name
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
Data_011_661A:: ; address name
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
Data_011_663E:: ; address name
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
Data_011_665C:: ; address name
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
Data_011_667A:: ; address name
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
Data_011_6698:: ; address name
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
Data_011_66B6:: ; address name
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
Data_011_66D4:: ; address name
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
Data_011_66F2:: ; address name
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
Data_011_6710:: ; address name
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
Data_011_672E:: ; address name
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
Data_011_674C:: ; address name
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
Data_011_676A:: ; address name
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
Data_011_6788:: ; address name
    dfar MapDBTileset ; entry 0
    dfar MapDBPalettes
    db $01, $02, $4F, $00, $04, $00, $00, $00, $00, $00
    dw wStoryFlags + $69
    dfar MapE0Screens0
    dfar MapE0Attrs0
    dfar MapE0Screens0
    dfar MapE0Attrs0

; E-0036 (C1: CheckWarpAtPlayer indexes it with hMapId; the lists hold entries matched against the player's facing and position, and a match queues sound effect $60 and loads a new map number and position; all 256 words point into the bank; the first list starts at $69A6, directly after the table). E-0231: the lists are laid out as 9-byte entries ending with $80 (CheckWarpAtPlayer: a facing byte, $FD = skip, $FE/$FF = any facing, then screen and position matched against the player).
; record: list of warps for this map number (hMapId); a list ends with $80; maps without warps share one empty list
MapWarpTable::
Data_011_67A6:: ; address name
    dw MapWarps00 ; entry 0
    dw MapWarps01 ; entry 1
    dw MapWarps02 ; entry 2
    dw MapWarps03 ; entry 3
    dw MapWarps04 ; entry 4
    dw MapWarps05 ; entry 5
    dw MapWarps06 ; entry 6
    dw MapWarps07 ; entry 7
    dw MapWarps08 ; entry 8
    dw MapWarps09 ; entry 9
    dw MapWarps0A ; entry 10
    dw MapWarps0B ; entry 11
    dw MapWarps0C ; entry 12
    dw MapWarps0D ; entry 13
    dw MapWarps0E ; entry 14
    dw MapWarps0F ; entry 15
    dw MapWarps10 ; entry 16
    dw MapWarps11 ; entry 17
    dw MapWarps12 ; entry 18
    dw MapWarps13 ; entry 19
    dw MapWarps0B ; entry 20
    dw MapWarps15 ; entry 21
    dw MapWarps16 ; entry 22
    dw MapWarps17 ; entry 23
    dw MapWarps18 ; entry 24
    dw MapWarps19 ; entry 25
    dw MapWarps1A ; entry 26
    dw MapWarps1B ; entry 27
    dw MapWarps0B ; entry 28
    dw MapWarps0B ; entry 29
    dw MapWarps0B ; entry 30
    dw MapWarps0B ; entry 31
    dw MapWarps20 ; entry 32
    dw MapWarps21 ; entry 33
    dw MapWarps22 ; entry 34
    dw MapWarps23 ; entry 35
    dw MapWarps24 ; entry 36
    dw MapWarps25 ; entry 37
    dw MapWarps26 ; entry 38
    dw MapWarps0B ; entry 39
    dw MapWarps28 ; entry 40
    dw MapWarps29 ; entry 41
    dw MapWarps2A ; entry 42
    dw MapWarps2B ; entry 43
    dw MapWarps0B ; entry 44
    dw MapWarps2D ; entry 45
    dw MapWarps2E ; entry 46
    dw MapWarps2F ; entry 47
    dw MapWarps30 ; entry 48
    dw MapWarps31 ; entry 49
    dw MapWarps32 ; entry 50
    dw MapWarps33 ; entry 51
    dw MapWarps34 ; entry 52
    dw MapWarps35 ; entry 53
    dw MapWarps36 ; entry 54
    dw MapWarps37 ; entry 55
    dw MapWarps38 ; entry 56
    dw MapWarps39 ; entry 57
    dw MapWarps3A ; entry 58
    dw MapWarps3B ; entry 59
    dw MapWarps3C ; entry 60
    dw MapWarps3D ; entry 61
    dw MapWarps3E ; entry 62
    dw MapWarps3F ; entry 63
    dw MapWarps40 ; entry 64
    dw MapWarps41 ; entry 65
    dw MapWarps42 ; entry 66
    dw MapWarps43 ; entry 67
    dw MapWarps44 ; entry 68
    dw MapWarps45 ; entry 69
    dw MapWarps0B ; entry 70
    dw MapWarps0B ; entry 71
    dw MapWarps48 ; entry 72
    dw MapWarps49 ; entry 73
    dw MapWarps4A ; entry 74
    dw MapWarps4B ; entry 75
    dw MapWarps4C ; entry 76
    dw MapWarps4D ; entry 77
    dw MapWarps4E ; entry 78
    dw MapWarps4F ; entry 79
    dw MapWarps50 ; entry 80
    dw MapWarps51 ; entry 81
    dw MapWarps52 ; entry 82
    dw MapWarps53 ; entry 83
    dw MapWarps54 ; entry 84
    dw MapWarps55 ; entry 85
    dw MapWarps56 ; entry 86
    dw MapWarps57 ; entry 87
    dw MapWarps58 ; entry 88
    dw MapWarps59 ; entry 89
    dw MapWarps5A ; entry 90
    dw MapWarps5B ; entry 91
    dw MapWarps5C ; entry 92
    dw MapWarps5D ; entry 93
    dw MapWarps5E ; entry 94
    dw MapWarps5F ; entry 95
    dw MapWarps60 ; entry 96
    dw MapWarps61 ; entry 97
    dw MapWarps62 ; entry 98
    dw MapWarps63 ; entry 99
    dw MapWarps64 ; entry 100
    dw MapWarps65 ; entry 101
    dw MapWarps66 ; entry 102
    dw MapWarps67 ; entry 103
    dw MapWarps68 ; entry 104
    dw MapWarps0B ; entry 105
    dw MapWarps0B ; entry 106
    dw MapWarps0B ; entry 107
    dw MapWarps0B ; entry 108
    dw MapWarps0B ; entry 109
    dw MapWarps0B ; entry 110
    dw MapWarps0B ; entry 111
    dw MapWarps70 ; entry 112
    dw MapWarps71 ; entry 113
    dw MapWarps72 ; entry 114
    dw MapWarps73 ; entry 115
    dw MapWarps74 ; entry 116
    dw MapWarps75 ; entry 117
    dw MapWarps76 ; entry 118
    dw MapWarps77 ; entry 119
    dw MapWarps78 ; entry 120
    dw MapWarps79 ; entry 121
    dw MapWarps7A ; entry 122
    dw MapWarps7B ; entry 123
    dw MapWarps7C ; entry 124
    dw MapWarps7D ; entry 125
    dw MapWarps7E ; entry 126
    dw MapWarps7F ; entry 127
    dw MapWarps80 ; entry 128
    dw MapWarps81 ; entry 129
    dw MapWarps82 ; entry 130
    dw MapWarps83 ; entry 131
    dw MapWarps84 ; entry 132
    dw MapWarps85 ; entry 133
    dw MapWarps86 ; entry 134
    dw MapWarps87 ; entry 135
    dw MapWarps88 ; entry 136
    dw MapWarps89 ; entry 137
    dw MapWarps8A ; entry 138
    dw MapWarps8B ; entry 139
    dw MapWarps8C ; entry 140
    dw MapWarps8D ; entry 141
    dw MapWarps8E ; entry 142
    dw MapWarps8F ; entry 143
    dw MapWarps90 ; entry 144
    dw MapWarps91 ; entry 145
    dw MapWarps92 ; entry 146
    dw MapWarps93 ; entry 147
    dw MapWarps94 ; entry 148
    dw MapWarps95 ; entry 149
    dw MapWarps96 ; entry 150
    dw MapWarps97 ; entry 151
    dw MapWarps98 ; entry 152
    dw MapWarps99 ; entry 153
    dw MapWarps9A ; entry 154
    dw MapWarps9B ; entry 155
    dw MapWarps0B ; entry 156
    dw MapWarps9D ; entry 157
    dw MapWarps0B ; entry 158
    dw MapWarps0B ; entry 159
    dw MapWarpsA0 ; entry 160
    dw MapWarpsA1 ; entry 161
    dw MapWarpsA2 ; entry 162
    dw MapWarpsA3 ; entry 163
    dw MapWarpsA4 ; entry 164
    dw MapWarps0B ; entry 165
    dw MapWarps0B ; entry 166
    dw MapWarps0B ; entry 167
    dw MapWarpsA8 ; entry 168
    dw MapWarpsA9 ; entry 169
    dw MapWarpsAA ; entry 170
    dw MapWarpsAB ; entry 171
    dw MapWarpsAC ; entry 172
    dw MapWarpsAD ; entry 173
    dw MapWarpsAE ; entry 174
    dw MapWarpsAF ; entry 175
    dw MapWarpsB0 ; entry 176
    dw MapWarpsB1 ; entry 177
    dw MapWarps0B ; entry 178
    dw MapWarpsB3 ; entry 179
    dw MapWarpsB4 ; entry 180
    dw MapWarpsB5 ; entry 181
    dw MapWarpsB6 ; entry 182
    dw MapWarps0B ; entry 183
    dw MapWarpsB8 ; entry 184
    dw MapWarpsB9 ; entry 185
    dw MapWarpsBA ; entry 186
    dw MapWarpsBB ; entry 187
    dw MapWarpsBC ; entry 188
    dw MapWarpsBD ; entry 189
    dw MapWarpsBE ; entry 190
    dw MapWarpsBF ; entry 191
    dw MapWarpsC0 ; entry 192
    dw MapWarpsC1 ; entry 193
    dw MapWarpsC2 ; entry 194
    dw MapWarpsC3 ; entry 195
    dw MapWarpsC4 ; entry 196
    dw MapWarps0B ; entry 197
    dw MapWarps0B ; entry 198
    dw MapWarps0B ; entry 199
    dw MapWarpsC8 ; entry 200
    dw MapWarpsC9 ; entry 201
    dw MapWarpsCA ; entry 202
    dw MapWarpsCB ; entry 203
    dw MapWarpsCC ; entry 204
    dw MapWarpsCD ; entry 205
    dw MapWarpsCE ; entry 206
    dw MapWarps0B ; entry 207
    dw MapWarps0B ; entry 208
    dw MapWarpsD1 ; entry 209
    dw MapWarpsD2 ; entry 210
    dw MapWarpsD3 ; entry 211
    dw MapWarpsD4 ; entry 212
    dw MapWarpsD5 ; entry 213
    dw MapWarpsD6 ; entry 214
    dw MapWarpsD7 ; entry 215
    dw MapWarps0B ; entry 216
    dw MapWarps0B ; entry 217
    dw MapWarpsDA ; entry 218
    dw MapWarpsDB ; entry 219
    dw MapWarpsDC ; entry 220
    dw MapWarpsDD ; entry 221
    dw MapWarpsDE ; entry 222
    dw MapWarpsDF ; entry 223
    dw MapWarpsE0 ; entry 224
    dw MapWarps0B ; entry 225
    dw MapWarps0B ; entry 226
    dw MapWarps0B ; entry 227
    dw MapWarps0B ; entry 228
    dw MapWarps0B ; entry 229
    dw MapWarps0B ; entry 230
    dw MapWarps0B ; entry 231
    dw MapWarps0B ; entry 232
    dw MapWarps0B ; entry 233
    dw MapWarps0B ; entry 234
    dw MapWarps0B ; entry 235
    dw MapWarps0B ; entry 236
    dw MapWarps0B ; entry 237
    dw MapWarps0B ; entry 238
    dw MapWarps0B ; entry 239
    dw MapWarps0B ; entry 240
    dw MapWarps0B ; entry 241
    dw MapWarps0B ; entry 242
    dw MapWarps0B ; entry 243
    dw MapWarps0B ; entry 244
    dw MapWarps0B ; entry 245
    dw MapWarps0B ; entry 246
    dw MapWarps0B ; entry 247
    dw MapWarps0B ; entry 248
    dw MapWarps0B ; entry 249
    dw MapWarps0B ; entry 250
    dw MapWarps0B ; entry 251
    dw MapWarps0B ; entry 252
    dw MapWarps0B ; entry 253
    dw MapWarps0B ; entry 254
    dw MapWarps0B ; entry 255

; E-0157 (derived: list for entry $0B of MapWarpTable; 0 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps0B::
    db $80 ; end

; E-0157 (derived: list for entry $00 of MapWarpTable; 5 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps00::
Data_011_69A7:: ; address name
    db $FD, $02, $40, $40, $06, $00, $00, $04, $08 ; id 0
    db $FF, $00, $00, $01, $02, $02, $00, $90, $00 ; id 1
    db $02, $10, $40, $00, $01, $03, $02, $04, $08 ; id 2
    db $FF, $00, $01, $00, $01, $03, $02, $90, $00 ; id 3
    db $FD, $21, $60, $30, $07, $00, $10, $06, $03 ; id 4
    db $80 ; end

; E-0157 (derived: list for entry $01 of MapWarpTable; 15 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps01::
Data_011_69D5:: ; address name
    db $FD, $22, $50, $50, $05, $02, $30, $05, $00 ; id 0
    db $FD, $00, $50, $50, $15, $00, $00, $05, $08 ; id 1
    db $FD, $10, $30, $40, $17, $00, $00, $05, $08 ; id 2
    db $FD, $10, $50, $00, $19, $01, $01, $05, $08 ; id 3
    db $FD, $01, $40, $50, $11, $00, $01, $04, $08 ; id 4
    db $FD, $01, $50, $50, $11, $00, $01, $05, $08 ; id 5
    db $FD, $11, $30, $40, $09, $00, $00, $03, $08 ; id 6
    db $FD, $11, $20, $10, $13, $00, $00, $02, $08 ; id 7
    db $FD, $21, $50, $50, $0A, $00, $00, $05, $08 ; id 8
    db $FD, $02, $40, $40, $08, $00, $00, $04, $08 ; id 9
    db $FD, $02, $60, $10, $16, $00, $00, $06, $08 ; id 10
    db $FF, $00, $00, $03, $02, $00, $00, $00, $80 ; id 11
    db $FD, $12, $20, $30, $0C, $01, $00, $03, $08 ; id 12
    db $FF, $00, $04, $02, $00, $02, $00, $70, $00 ; id 13
    db $FF, $00, $03, $03, $00, $01, $01, $00, $80 ; id 14
    db $80 ; end

; E-0157 (derived: list for entry $02 of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps02::
Data_011_6A5D:: ; address name
    db $FF, $00, $00, $FF, $01, $00, $02, $00, $80 ; id 0
    db $FF, $00, $03, $00, $00, $01, $01, $70, $00 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $03 of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps03::
Data_011_6A70:: ; address name
    db $FD, $00, $50, $50, $05, $00, $10, $05, $05 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $04 of MapWarpTable; 3 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps04::
Data_011_6A7A:: ; address name
    db $FD, $20, $40, $40, $0C, $01, $10, $04, $04 ; id 0
    db $FF, $00, $02, $01, $18, $82, $00, $00, $A0 ; id 1
    db $FF, $00, $01, $01, $18, $81, $00, $00, $80 ; id 2
    db $80 ; end

; E-0157 (derived: list for entry $05 of MapWarpTable; 3 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps05::
Data_011_6A96:: ; address name
    db $FE, $00, $02, $FF, $01, $02, $12, $05, $05 ; id 0
    db $FD, $00, $50, $50, $03, $00, $10, $05, $05 ; id 1
    db $FD, $00, $50, $10, $0D, $00, $31, $05, $08 ; id 2
    db $80 ; end

; E-0157 (derived: list for entry $06 of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps06::
Data_011_6AB2:: ; address name
    db $FE, $00, $00, $01, $00, $80, $02, $04, $04 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $07 of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps07::
Data_011_6ABC:: ; address name
    db $FD, $00, $60, $30, $00, $02, $11, $06, $03 ; id 0
    db $FD, $00, $50, $00, $0D, $03, $31, $05, $08 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $08 of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps08::
Data_011_6ACF:: ; address name
    db $FE, $00, $00, $01, $01, $80, $02, $04, $04 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $09 of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps09::
Data_011_6AD9:: ; address name
    db $FE, $00, $00, $01, $01, $81, $01, $03, $04 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $0A of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps0A::
Data_011_6AE3:: ; address name
    db $FE, $00, $00, $01, $01, $82, $01, $05, $05 ; id 0
    db $FD, $00, $80, $40, $0D, $01, $11, $08, $04 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $0C of MapWarpTable; 4 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps0C::
Data_011_6AF6:: ; address name
    db $FE, $00, $01, $01, $01, $81, $02, $02, $03 ; id 0
    db $FD, $10, $40, $40, $04, $02, $10, $04, $04 ; id 1
    db $FD, $00, $30, $40, $0E, $00, $00, $03, $08 ; id 2
    db $FD, $00, $70, $40, $12, $00, $00, $07, $08 ; id 3
    db $80 ; end

; E-0157 (derived: list for entry $0D of MapWarpTable; 3 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps0D::
Data_011_6B1B:: ; address name
    db $FD, $11, $80, $40, $0A, $00, $10, $08, $04 ; id 0
    db $FE, $00, $00, $02, $05, $80, $10, $05, $01 ; id 1
    db $FE, $00, $03, $02, $07, $80, $10, $05, $00 ; id 2
    db $80 ; end

; E-0157 (derived: list for entry $0E of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps0E::
Data_011_6B37:: ; address name
    db $FE, $00, $00, $01, $0C, $80, $00, $03, $04 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $0F of MapWarpTable; 3 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps0F::
Data_011_6B41:: ; address name
    db $00, $00, $40, $80, $0C, $80, $00, $02, $01 ; id 0
    db $00, $00, $20, $80, $0C, $80, $00, $02, $01 ; id 1
    db $00, $00, $70, $80, $0C, $80, $00, $07, $01 ; id 2
    db $80 ; end

; E-0157 (derived: list for entry $10 of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps10::
Data_011_6B5D:: ; address name
    db $FE, $00, $00, $01, $0C, $80, $00, $07, $01 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $11 of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps11::
Data_011_6B67:: ; address name
    db $FF, $00, $00, $02, $01, $80, $01, $00, $D0 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $12 of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps12::
Data_011_6B71:: ; address name
    db $FE, $00, $00, $01, $0C, $80, $00, $07, $04 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $13 of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps13::
Data_011_6B7B:: ; address name
    db $FE, $00, $00, $01, $01, $81, $01, $02, $01 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $15 of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps15::
Data_011_6B85:: ; address name
    db $FE, $00, $00, $01, $01, $80, $00, $05, $05 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $16 of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps16::
Data_011_6B8F:: ; address name
    db $FE, $00, $00, $01, $01, $80, $02, $06, $01 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $17 of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps17::
Data_011_6B99:: ; address name
    db $FE, $00, $00, $01, $01, $81, $00, $03, $04 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $18 of MapWarpTable; 4 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps18::
Data_011_6BA3:: ; address name
    db $FD, $20, $40, $20, $04, $02, $00, $04, $08 ; id 0
    db $FD, $20, $50, $20, $04, $02, $00, $05, $08 ; id 1
    db $FD, $10, $40, $00, $04, $01, $00, $04, $08 ; id 2
    db $FD, $10, $50, $00, $04, $01, $00, $05, $08 ; id 3
    db $80 ; end

; E-0157 (derived: list for entry $19 of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps19::
Data_011_6BC8:: ; address name
    db $FE, $00, $01, $02, $01, $81, $00, $05, $00 ; id 0
    db $FD, $11, $50, $40, $1A, $01, $10, $05, $04 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $1A of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps1A::
Data_011_6BDB:: ; address name
    db $FD, $10, $50, $40, $19, $01, $11, $05, $04 ; id 0
    db $FD, $20, $40, $30, $1B, $00, $10, $04, $03 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $1B of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps1B::
Data_011_6BEE:: ; address name
    db $FD, $00, $40, $30, $1A, $02, $10, $04, $03 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $20 of MapWarpTable; 6 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps20::
Data_011_6BF8:: ; address name
    db $FD, $21, $40, $40, $21, $00, $30, $05, $08 ; id 0
    db $FD, $21, $50, $40, $21, $00, $30, $05, $08 ; id 1
    db $FD, $25, $40, $40, $24, $00, $31, $05, $08 ; id 2
    db $FD, $25, $50, $40, $24, $00, $31, $05, $08 ; id 3
    db $FD, $55, $40, $40, $2F, $00, $31, $06, $08 ; id 4
    db $FD, $55, $50, $40, $2F, $00, $31, $06, $08 ; id 5
    db $80 ; end

; E-0157 (derived: list for entry $21 of MapWarpTable; 4 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps21::
Data_011_6C2F:: ; address name
    db $FE, $00, $00, $01, $20, $02, $11, $04, $04 ; id 0
    db $FE, $00, $02, $00, $20, $02, $11, $04, $04 ; id 1
    db $FD, $00, $50, $10, $22, $00, $00, $05, $08 ; id 2
    db $FD, $10, $20, $20, $2A, $00, $00, $02, $08 ; id 3
    db $80 ; end

; E-0157 (derived: list for entry $22 of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps22::
Data_011_6C54:: ; address name
    db $FE, $00, $00, $01, $21, $80, $00, $05, $01 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $23 of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps23::
Data_011_6C5E:: ; address name
    db $FE, $00, $00, $01, $24, $81, $01, $03, $02 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $24 of MapWarpTable; 7 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps24::
Data_011_6C68:: ; address name
    db $FE, $00, $FF, $00, $20, $02, $15, $04, $04 ; id 0
    db $FE, $00, $02, $01, $20, $02, $15, $04, $04 ; id 1
    db $FE, $00, $00, $02, $20, $02, $15, $04, $04 ; id 2
    db $FD, $00, $40, $00, $25, $00, $00, $04, $08 ; id 3
    db $FD, $00, $50, $00, $25, $00, $00, $05, $08 ; id 4
    db $FD, $11, $30, $20, $23, $00, $00, $04, $08 ; id 5
    db $FD, $11, $20, $50, $2B, $23, $33, $02, $00 ; id 6
    db $80 ; end

; E-0157 (derived: list for entry $25 of MapWarpTable; 5 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps25::
Data_011_6CA8:: ; address name
    db $FF, $00, $00, $01, $24, $80, $00, $00, $80 ; id 0
    db $FD, $00, $40, $00, $26, $00, $00, $04, $08 ; id 1
    db $FD, $00, $50, $00, $26, $00, $00, $05, $08 ; id 2
    db $FD, $00, $20, $60, $2E, $00, $10, $02, $06 ; id 3
    db $FD, $10, $80, $30, $2D, $00, $10, $08, $03 ; id 4
    db $80 ; end

; E-0157 (derived: list for entry $26 of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps26::
Data_011_6CD6:: ; address name
    db $FF, $00, $00, $01, $25, $80, $00, $00, $80 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $28 of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps28::
Data_011_6CE0:: ; address name
    db $FE, $00, $00, $02, $2F, $81, $10, $04, $03 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $29 of MapWarpTable; 0 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps29::
    db $80 ; end

; E-0157 (derived: list for entry $2A of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps2A::
Data_011_6CEB:: ; address name
    db $FE, $00, $00, $01, $21, $81, $00, $02, $02 ; id 0
    db $FD, $00, $10, $20, $2B, $11, $10, $01, $02 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $2B of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps2B::
Data_011_6CFE:: ; address name
    db $FD, $10, $10, $20, $2A, $00, $10, $01, $02 ; id 0
    db $FE, $00, $03, $02, $24, $01, $11, $02, $05 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $2D of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps2D::
Data_011_6D11:: ; address name
    db $FD, $00, $80, $30, $25, $01, $10, $08, $03 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $2E of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps2E::
Data_011_6D1B:: ; address name
    db $FD, $00, $20, $60, $25, $00, $10, $02, $06 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $2F of MapWarpTable; 8 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps2F::
Data_011_6D25:: ; address name
    db $FE, $00, $FF, $00, $20, $05, $15, $04, $04 ; id 0
    db $FE, $00, $FF, $01, $20, $05, $15, $04, $04 ; id 1
    db $FE, $00, $00, $FF, $20, $05, $15, $04, $04 ; id 2
    db $FE, $00, $01, $FF, $20, $05, $15, $04, $04 ; id 3
    db $FE, $00, $02, $00, $20, $05, $15, $04, $04 ; id 4
    db $FE, $00, $02, $01, $20, $05, $15, $04, $04 ; id 5
    db $FE, $00, $00, $02, $20, $05, $15, $04, $04 ; id 6
    db $FE, $00, $01, $02, $20, $05, $15, $04, $04 ; id 7
    db $80 ; end

; E-0157 (derived: list for entry $30 of MapWarpTable; 9 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps30::
Data_011_6D6E:: ; address name
    db $FD, $56, $40, $40, $31, $00, $31, $04, $08 ; id 0
    db $FD, $56, $50, $40, $31, $00, $31, $04, $08 ; id 1
    db $FD, $42, $40, $40, $32, $00, $10, $06, $00 ; id 2
    db $FD, $42, $50, $40, $32, $00, $10, $06, $00 ; id 3
    db $FD, $24, $40, $40, $3C, $01, $30, $04, $08 ; id 4
    db $FD, $24, $50, $40, $3C, $01, $30, $04, $08 ; id 5
    db $FD, $03, $40, $40, $35, $01, $33, $04, $08 ; id 6
    db $FD, $62, $40, $40, $3E, $00, $31, $04, $08 ; id 7
    db $FD, $53, $40, $40, $38, $02, $33, $04, $08 ; id 8
    db $80 ; end

; E-0157 (derived: list for entry $31 of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps31::
Data_011_6DC0:: ; address name
    db $FE, $00, $00, $02, $30, $05, $16, $04, $04 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $32 of MapWarpTable; 4 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps32::
Data_011_6DCA:: ; address name
    db $FE, $00, $00, $FF, $30, $04, $12, $04, $04 ; id 0
    db $FE, $00, $02, $00, $30, $04, $12, $04, $04 ; id 1
    db $FD, $10, $40, $10, $33, $00, $01, $04, $08 ; id 2
    db $FD, $11, $40, $20, $34, $00, $00, $04, $08 ; id 3
    db $80 ; end

; E-0157 (derived: list for entry $33 of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps33::
Data_011_6DEF:: ; address name
    db $FE, $00, $00, $02, $32, $81, $00, $04, $01 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $34 of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps34::
Data_011_6DF9:: ; address name
    db $FE, $00, $00, $01, $32, $81, $01, $04, $02 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $35 of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps35::
Data_011_6E03:: ; address name
    db $FE, $00, $01, $04, $30, $00, $13, $04, $04 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $36 of MapWarpTable; 3 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps36::
Data_011_6E0D:: ; address name
    db $FD, $00, $40, $20, $37, $02, $30, $04, $08 ; id 0
    db $FD, $00, $50, $20, $37, $02, $30, $04, $08 ; id 1
    db $FE, $00, $00, $01, $30, $05, $15, $04, $05 ; id 2
    db $80 ; end

; E-0157 (derived: list for entry $37 of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps37::
Data_011_6E29:: ; address name
    db $FE, $00, $02, $01, $36, $80, $10, $04, $02 ; id 0
    db $FD, $20, $20, $50, $42, $02, $10, $02, $05 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $38 of MapWarpTable; 3 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps38::
Data_011_6E3C:: ; address name
    db $FE, $00, $02, $04, $30, $05, $13, $04, $04 ; id 0
    db $FD, $01, $40, $40, $39, $00, $10, $04, $04 ; id 1
    db $FD, $31, $40, $40, $39, $03, $10, $04, $04 ; id 2
    db $80 ; end

; E-0157 (derived: list for entry $39 of MapWarpTable; 3 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps39::
Data_011_6E58:: ; address name
    db $FD, $00, $40, $40, $38, $00, $11, $04, $04 ; id 0
    db $FD, $30, $40, $40, $38, $03, $11, $04, $04 ; id 1
    db $FD, $02, $40, $40, $3A, $02, $11, $04, $04 ; id 2
    db $80 ; end

; E-0157 (derived: list for entry $3A of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps3A::
Data_011_6E74:: ; address name
    db $FF, $00, $01, $03, $3B, $80, $00, $00, $80 ; id 0
    db $FD, $21, $40, $40, $39, $00, $12, $04, $04 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $3B of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps3B::
Data_011_6E87:: ; address name
    db $FF, $00, $00, $FF, $3A, $01, $02, $00, $80 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $3C of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps3C::
Data_011_6E91:: ; address name
    db $FE, $00, $01, $01, $30, $02, $14, $04, $04 ; id 0
    db $FD, $10, $70, $20, $3D, $00, $30, $07, $08 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $3D of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps3D::
Data_011_6EA4:: ; address name
    db $FE, $00, $00, $01, $3C, $81, $10, $07, $02 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $3E of MapWarpTable; 5 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps3E::
Data_011_6EAE:: ; address name
    db $FE, $00, $00, $02, $30, $06, $12, $04, $04 ; id 0
    db $FD, $00, $60, $30, $3E, $01, $10, $06, $03 ; id 1
    db $FD, $10, $60, $30, $3E, $00, $10, $06, $03 ; id 2
    db $FD, $10, $30, $30, $3F, $00, $10, $03, $03 ; id 3
    db $FD, $11, $10, $60, $3F, $00, $11, $01, $06 ; id 4
    db $80 ; end

; E-0157 (derived: list for entry $3F of MapWarpTable; 9 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps3F::
Data_011_6EDC:: ; address name
    db $FD, $00, $30, $30, $3E, $01, $10, $03, $03 ; id 0
    db $FD, $01, $10, $60, $3E, $01, $11, $01, $06 ; id 1
    db $FD, $00, $60, $30, $3F, $01, $10, $06, $03 ; id 2
    db $FD, $10, $60, $30, $3F, $00, $10, $06, $03 ; id 3
    db $FD, $10, $20, $30, $3F, $01, $11, $02, $03 ; id 4
    db $FD, $11, $20, $30, $3F, $01, $10, $02, $03 ; id 5
    db $FD, $10, $60, $70, $3F, $01, $11, $06, $07 ; id 6
    db $FD, $11, $60, $70, $3F, $01, $10, $06, $07 ; id 7
    db $FD, $11, $40, $40, $40, $00, $11, $04, $04 ; id 8
    db $80 ; end

; E-0157 (derived: list for entry $40 of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps40::
Data_011_6F2E:: ; address name
    db $FD, $01, $40, $40, $3F, $01, $11, $04, $04 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $41 of MapWarpTable; 0 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps41::
    db $80 ; end

; E-0157 (derived: list for entry $42 of MapWarpTable; 3 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps42::
Data_011_6F39:: ; address name
    db $FD, $20, $20, $50, $37, $02, $10, $02, $05 ; id 0
    db $FD, $00, $80, $10, $43, $00, $10, $08, $02 ; id 1
    db $FD, $00, $50, $40, $43, $00, $10, $05, $04 ; id 2
    db $80 ; end

; E-0157 (derived: list for entry $43 of MapWarpTable; 3 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps43::
Data_011_6F55:: ; address name
    db $FD, $00, $80, $20, $42, $00, $10, $08, $01 ; id 0
    db $FD, $00, $50, $40, $42, $00, $10, $05, $04 ; id 1
    db $FD, $20, $40, $40, $44, $00, $30, $04, $08 ; id 2
    db $80 ; end

; E-0157 (derived: list for entry $44 of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps44::
Data_011_6F71:: ; address name
    db $FE, $00, $00, $01, $43, $82, $10, $04, $04 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $45 of MapWarpTable; 0 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps45::
    db $80 ; end

; E-0157 (derived: list for entry $48 of MapWarpTable; 20 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps48::
Data_011_6F7C:: ; address name
    db $FD, $82, $40, $40, $4A, $00, $31, $05, $08 ; id 0
    db $FD, $82, $50, $40, $4A, $00, $31, $05, $08 ; id 1
    db $FD, $73, $40, $40, $4E, $10, $10, $04, $04 ; id 2
    db $FD, $74, $40, $40, $4E, $20, $12, $04, $04 ; id 3
    db $FD, $75, $40, $40, $4F, $00, $10, $00, $06 ; id 4
    db $FD, $75, $50, $40, $4F, $00, $10, $00, $06 ; id 5
    db $FD, $46, $40, $40, $52, $00, $30, $04, $08 ; id 6
    db $FD, $46, $60, $40, $52, $02, $30, $04, $08 ; id 7
    db $FD, $48, $40, $40, $58, $00, $31, $04, $08 ; id 8
    db $FD, $48, $50, $40, $58, $00, $31, $04, $08 ; id 9
    db $FD, $29, $40, $40, $5A, $01, $30, $04, $08 ; id 10
    db $FD, $29, $50, $40, $5A, $01, $30, $04, $08 ; id 11
    db $FD, $5A, $40, $30, $5D, $02, $10, $04, $00 ; id 12
    db $FD, $5A, $50, $30, $5D, $02, $10, $04, $00 ; id 13
    db $FD, $99, $40, $40, $5E, $01, $31, $04, $08 ; id 14
    db $FD, $99, $50, $40, $5E, $01, $31, $04, $08 ; id 15
    db $FD, $A5, $40, $40, $62, $01, $33, $04, $08 ; id 16
    db $FD, $87, $40, $40, $63, $00, $10, $04, $00 ; id 17
    db $FD, $50, $40, $40, $49, $00, $30, $04, $08 ; id 18
    db $FD, $50, $50, $40, $49, $00, $30, $04, $08 ; id 19
    db $80 ; end

; E-0157 (derived: list for entry $49 of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps49::
Data_011_7031:: ; address name
    db $FE, $00, $00, $01, $48, $05, $10, $04, $04 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $4A of MapWarpTable; 6 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps4A::
Data_011_703B:: ; address name
    db $FE, $00, $02, $00, $48, $08, $12, $04, $04 ; id 0
    db $FE, $00, $00, $02, $48, $08, $12, $04, $04 ; id 1
    db $FE, $00, $01, $02, $48, $08, $12, $04, $04 ; id 2
    db $FD, $10, $70, $40, $4B, $00, $30, $07, $08 ; id 3
    db $FD, $00, $40, $00, $4C, $00, $01, $04, $08 ; id 4
    db $FD, $00, $50, $00, $4C, $00, $01, $05, $08 ; id 5
    db $80 ; end

; E-0157 (derived: list for entry $4B of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps4B::
Data_011_7072:: ; address name
    db $FE, $00, $00, $01, $4A, $81, $10, $07, $04 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $4C of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps4C::
Data_011_707C:: ; address name
    db $FF, $00, $00, $02, $4A, $80, $10, $00, $80 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $4D of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps4D::
Data_011_7086:: ; address name
    db $FD, $00, $60, $20, $4C, $00, $10, $06, $01 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $4E of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps4E::
Data_011_7090:: ; address name
    db $FD, $00, $40, $40, $48, $07, $13, $04, $04 ; id 0
    db $FD, $02, $40, $40, $48, $07, $14, $04, $04 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $4F of MapWarpTable; 3 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps4F::
Data_011_70A3:: ; address name
    db $FE, $00, $01, $FF, $48, $07, $15, $04, $04 ; id 0
    db $FE, $00, $FF, $00, $48, $07, $15, $04, $04 ; id 1
    db $FD, $00, $20, $40, $50, $00, $30, $03, $08 ; id 2
    db $80 ; end

; E-0157 (derived: list for entry $50 of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps50::
Data_011_70BF:: ; address name
    db $FE, $00, $00, $01, $4F, $80, $10, $02, $04 ; id 0
    db $FD, $00, $50, $10, $51, $00, $10, $05, $01 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $51 of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps51::
Data_011_70D2:: ; address name
    db $FD, $00, $50, $10, $50, $00, $10, $05, $01 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $52 of MapWarpTable; 6 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps52::
Data_011_70DC:: ; address name
    db $FE, $00, $00, $01, $48, $04, $16, $04, $04 ; id 0
    db $FE, $00, $02, $01, $48, $04, $16, $06, $04 ; id 1
    db $FD, $00, $40, $00, $53, $20, $33, $04, $08 ; id 2
    db $FD, $00, $50, $00, $53, $20, $33, $05, $08 ; id 3
    db $FD, $20, $40, $00, $53, $12, $33, $04, $08 ; id 4
    db $FD, $20, $50, $00, $53, $12, $33, $05, $08 ; id 5
    db $80 ; end

; E-0157 (derived: list for entry $53 of MapWarpTable; 9 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps53::
Data_011_7113:: ; address name
    db $FE, $00, $00, $04, $52, $B0, $00, $04, $00 ; id 0
    db $FE, $00, $02, $04, $52, $B2, $00, $04, $00 ; id 1
    db $FD, $02, $20, $40, $54, $30, $10, $02, $04 ; id 2
    db $FD, $31, $60, $30, $55, $31, $10, $06, $03 ; id 3
    db $FD, $11, $70, $20, $56, $30, $12, $07, $02 ; id 4
    db $FD, $00, $20, $00, $57, $30, $30, $02, $08 ; id 5
    db $FD, $00, $30, $00, $57, $30, $30, $03, $08 ; id 6
    db $FD, $20, $60, $00, $57, $32, $30, $06, $08 ; id 7
    db $FD, $20, $70, $00, $57, $32, $30, $07, $08 ; id 8
    db $80 ; end

; E-0157 (derived: list for entry $54 of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps54::
Data_011_7165:: ; address name
    db $FD, $00, $20, $40, $53, $30, $12, $02, $04 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $55 of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps55::
Data_011_716F:: ; address name
    db $FD, $10, $60, $30, $53, $33, $11, $06, $03 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $56 of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps56::
Data_011_7179:: ; address name
    db $FD, $02, $70, $20, $53, $31, $11, $07, $02 ; id 0
    db $FD, $00, $40, $70, $57, $31, $10, $04, $07 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $57 of MapWarpTable; 3 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps57::
Data_011_718C:: ; address name
    db $FD, $10, $40, $70, $56, $30, $10, $04, $07 ; id 0
    db $FF, $00, $00, $01, $53, $B0, $00, $00, $80 ; id 1
    db $FF, $00, $02, $01, $53, $B2, $00, $00, $80 ; id 2
    db $80 ; end

; E-0157 (derived: list for entry $58 of MapWarpTable; 4 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps58::
Data_011_71A8:: ; address name
    db $FE, $00, $FF, $00, $48, $04, $18, $04, $04 ; id 0
    db $FE, $00, $FF, $01, $48, $04, $18, $04, $04 ; id 1
    db $FE, $00, $00, $02, $48, $04, $18, $04, $04 ; id 2
    db $FD, $01, $80, $40, $59, $00, $30, $08, $08 ; id 3
    db $80 ; end

; E-0157 (derived: list for entry $59 of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps59::
Data_011_71CD:: ; address name
    db $FE, $00, $00, $01, $58, $80, $11, $08, $04 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $5A of MapWarpTable; 7 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps5A::
Data_011_71D7:: ; address name
    db $FE, $00, $FF, $00, $48, $02, $19, $04, $04 ; id 0
    db $FE, $00, $00, $01, $48, $02, $19, $04, $04 ; id 1
    db $FE, $00, $02, $00, $48, $02, $19, $04, $04 ; id 2
    db $FE, $00, $01, $01, $48, $02, $19, $04, $04 ; id 3
    db $FD, $10, $30, $30, $5B, $01, $31, $04, $08 ; id 4
    db $FD, $10, $40, $30, $5B, $01, $31, $05, $08 ; id 5
    db $FD, $00, $40, $10, $5C, $00, $31, $03, $08 ; id 6
    db $80 ; end

; E-0157 (derived: list for entry $5B of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps5B::
Data_011_7217:: ; address name
    db $FF, $00, $01, $02, $5A, $81, $10, $F0, $B0 ; id 0
    db $FD, $00, $70, $20, $5C, $00, $10, $07, $03 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $5C of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps5C::
Data_011_722A:: ; address name
    db $FD, $00, $70, $30, $5B, $00, $10, $07, $02 ; id 0
    db $FE, $00, $00, $02, $5A, $80, $30, $04, $01 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $5D of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps5D::
Data_011_723D:: ; address name
    db $FE, $00, $02, $FF, $48, $05, $1A, $04, $03 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $5E of MapWarpTable; 6 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps5E::
Data_011_7247:: ; address name
    db $FE, $00, $FF, $01, $48, $09, $19, $04, $04 ; id 0
    db $FE, $00, $01, $02, $48, $09, $19, $04, $04 ; id 1
    db $FE, $00, $02, $01, $48, $09, $19, $04, $04 ; id 2
    db $FD, $11, $20, $20, $5F, $00, $30, $02, $08 ; id 3
    db $FD, $10, $40, $00, $60, $00, $32, $04, $08 ; id 4
    db $FD, $10, $50, $00, $60, $00, $32, $05, $08 ; id 5
    db $80 ; end

; E-0157 (derived: list for entry $5F of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps5F::
Data_011_727E:: ; address name
    db $FE, $00, $00, $01, $5E, $81, $11, $02, $02 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $60 of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps60::
Data_011_7288:: ; address name
    db $FF, $00, $00, $03, $5E, $81, $00, $00, $80 ; id 0
    db $FD, $01, $80, $60, $61, $00, $11, $08, $06 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $61 of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps61::
Data_011_729B:: ; address name
    db $FD, $01, $80, $60, $60, $00, $11, $08, $06 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $62 of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps62::
Data_011_72A5:: ; address name
    db $FE, $00, $01, $04, $48, $0A, $15, $04, $04 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $63 of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps63::
Data_011_72AF:: ; address name
    db $FE, $00, $00, $FF, $48, $08, $17, $04, $04 ; id 0
    db $FD, $11, $10, $70, $64, $01, $11, $01, $07 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $64 of MapWarpTable; 9 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps64::
Data_011_72C2:: ; address name
    db $FD, $11, $10, $70, $63, $01, $11, $01, $07 ; id 0
    db $FD, $10, $80, $20, $65, $01, $10, $08, $02 ; id 1
    db $FD, $10, $60, $40, $65, $01, $10, $06, $04 ; id 2
    db $FD, $10, $40, $60, $65, $01, $10, $04, $06 ; id 3
    db $FD, $01, $40, $20, $65, $00, $11, $04, $02 ; id 4
    db $FD, $01, $60, $40, $65, $00, $11, $06, $04 ; id 5
    db $FD, $01, $80, $60, $65, $00, $11, $08, $06 ; id 6
    db $FD, $11, $80, $20, $65, $01, $11, $08, $02 ; id 7
    db $FD, $11, $80, $70, $65, $01, $11, $08, $07 ; id 8
    db $80 ; end

; E-0157 (derived: list for entry $65 of MapWarpTable; 10 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps65::
Data_011_7314:: ; address name
    db $FD, $10, $80, $20, $64, $01, $10, $08, $02 ; id 0
    db $FD, $10, $60, $40, $64, $01, $10, $06, $04 ; id 1
    db $FD, $10, $40, $60, $64, $01, $10, $04, $06 ; id 2
    db $FD, $01, $40, $20, $64, $00, $11, $04, $02 ; id 3
    db $FD, $01, $60, $40, $64, $00, $11, $06, $04 ; id 4
    db $FD, $01, $80, $60, $64, $00, $11, $08, $06 ; id 5
    db $FD, $11, $80, $20, $64, $01, $11, $08, $02 ; id 6
    db $FD, $11, $80, $70, $64, $01, $11, $08, $07 ; id 7
    db $FD, $00, $10, $20, $66, $00, $10, $01, $02 ; id 8
    db $FD, $01, $10, $60, $66, $00, $11, $01, $06 ; id 9
    db $80 ; end

; E-0157 (derived: list for entry $66 of MapWarpTable; 3 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps66::
Data_011_736F:: ; address name
    db $FD, $00, $10, $20, $65, $00, $10, $01, $02 ; id 0
    db $FD, $01, $10, $60, $65, $00, $11, $01, $06 ; id 1
    db $FD, $10, $40, $40, $67, $00, $10, $04, $04 ; id 2
    db $80 ; end

; E-0157 (derived: list for entry $67 of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps67::
Data_011_738B:: ; address name
    db $FD, $00, $40, $40, $66, $01, $10, $04, $04 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $68 of MapWarpTable; 0 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps68::
    db $80 ; end

; E-0157 (derived: list for entry $70 of MapWarpTable; 19 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps70::
Data_011_7396:: ; address name
    db $FD, $B1, $40, $40, $71, $01, $30, $04, $08 ; id 0
    db $FD, $A4, $40, $40, $77, $12, $30, $04, $08 ; id 1
    db $FD, $94, $40, $40, $77, $20, $30, $04, $08 ; id 2
    db $FD, $56, $40, $40, $78, $00, $31, $04, $08 ; id 3
    db $FD, $56, $50, $40, $78, $00, $31, $04, $08 ; id 4
    db $FD, $04, $40, $40, $7A, $00, $31, $04, $08 ; id 5
    db $FD, $36, $40, $40, $7B, $10, $10, $04, $04 ; id 6
    db $FD, $37, $40, $40, $7B, $20, $12, $04, $04 ; id 7
    db $FD, $59, $40, $40, $7C, $01, $31, $05, $08 ; id 8
    db $FD, $59, $50, $40, $7C, $01, $31, $05, $08 ; id 9
    db $FD, $89, $40, $40, $80, $10, $30, $04, $08 ; id 10
    db $FD, $99, $40, $40, $80, $22, $30, $04, $08 ; id 11
    db $FD, $5B, $40, $40, $81, $00, $10, $04, $04 ; id 12
    db $FD, $1B, $40, $40, $85, $00, $31, $04, $08 ; id 13
    db $FD, $BA, $40, $40, $8A, $00, $30, $04, $08 ; id 14
    db $FD, $BA, $50, $40, $8A, $00, $30, $04, $08 ; id 15
    db $FD, $52, $40, $40, $92, $00, $30, $04, $08 ; id 16
    db $FD, $41, $40, $40, $93, $00, $30, $04, $08 ; id 17
    db $FD, $41, $50, $40, $93, $00, $30, $04, $08 ; id 18
    db $80 ; end

; E-0157 (derived: list for entry $71 of MapWarpTable; 4 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps71::
Data_011_7442:: ; address name
    db $FE, $00, $00, $01, $70, $0B, $11, $04, $04 ; id 0
    db $FE, $00, $01, $01, $70, $0B, $11, $04, $04 ; id 1
    db $FD, $20, $20, $20, $72, $00, $30, $03, $08 ; id 2
    db $FE, $00, $01, $FF, $89, $00, $31, $04, $08 ; id 3
    db $80 ; end

; E-0157 (derived: list for entry $72 of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps72::
Data_011_7467:: ; address name
    db $FE, $00, $00, $01, $71, $82, $10, $02, $02 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $73 of MapWarpTable; 4 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps73::
Data_011_7471:: ; address name
    db $FE, $00, $00, $02, $89, $00, $11, $05, $06 ; id 0
    db $FD, $00, $40, $40, $74, $00, $10, $04, $04 ; id 1
    db $FD, $01, $60, $20, $74, $00, $11, $06, $02 ; id 2
    db $FD, $11, $50, $50, $74, $01, $11, $05, $05 ; id 3
    db $80 ; end

; E-0157 (derived: list for entry $74 of MapWarpTable; 6 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps74::
Data_011_7496:: ; address name
    db $FD, $00, $40, $40, $73, $00, $10, $04, $04 ; id 0
    db $FD, $01, $60, $20, $73, $00, $11, $06, $02 ; id 1
    db $FD, $11, $50, $50, $73, $01, $11, $05, $05 ; id 2
    db $FD, $10, $50, $40, $75, $01, $10, $05, $04 ; id 3
    db $FD, $01, $40, $50, $75, $00, $11, $04, $05 ; id 4
    db $FD, $11, $30, $20, $75, $01, $11, $03, $02 ; id 5
    db $80 ; end

; E-0157 (derived: list for entry $75 of MapWarpTable; 4 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps75::
Data_011_74CD:: ; address name
    db $FD, $10, $50, $40, $74, $01, $10, $05, $04 ; id 0
    db $FD, $01, $40, $50, $74, $00, $11, $04, $05 ; id 1
    db $FD, $11, $30, $20, $74, $01, $11, $03, $02 ; id 2
    db $FD, $01, $40, $20, $76, $00, $11, $04, $02 ; id 3
    db $80 ; end

; E-0157 (derived: list for entry $76 of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps76::
Data_011_74F2:: ; address name
    db $FD, $01, $40, $20, $75, $00, $11, $04, $02 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $77 of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps77::
Data_011_74FC:: ; address name
    db $FE, $00, $02, $01, $70, $0A, $14, $04, $04 ; id 0
    db $FE, $00, $00, $01, $70, $09, $14, $04, $04 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $78 of MapWarpTable; 3 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps78::
Data_011_750F:: ; address name
    db $FE, $00, $00, $02, $70, $05, $16, $04, $04 ; id 0
    db $FE, $00, $02, $01, $70, $05, $16, $04, $04 ; id 1
    db $FD, $11, $60, $30, $79, $00, $11, $06, $03 ; id 2
    db $80 ; end

; E-0157 (derived: list for entry $79 of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps79::
Data_011_752B:: ; address name
    db $FD, $01, $60, $30, $78, $01, $11, $06, $03 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $7A of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps7A::
Data_011_7535:: ; address name
    db $FE, $00, $00, $02, $70, $00, $14, $04, $04 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $7B of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps7B::
Data_011_753F:: ; address name
    db $FD, $00, $40, $40, $70, $03, $16, $04, $04 ; id 0
    db $FD, $02, $40, $40, $70, $03, $17, $04, $04 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $7C of MapWarpTable; 4 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps7C::
Data_011_7552:: ; address name
    db $FE, $00, $01, $02, $70, $05, $19, $04, $04 ; id 0
    db $FD, $11, $20, $40, $7D, $00, $30, $02, $08 ; id 1
    db $FD, $00, $40, $40, $7F, $00, $31, $04, $08 ; id 2
    db $FD, $00, $50, $40, $7F, $00, $31, $05, $08 ; id 3
    db $80 ; end

; E-0157 (derived: list for entry $7D of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps7D::
Data_011_7577:: ; address name
    db $FE, $00, $00, $01, $7C, $81, $11, $02, $04 ; id 0
    db $FD, $00, $10, $60, $7E, $00, $10, $01, $06 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $7E of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps7E::
Data_011_758A:: ; address name
    db $FD, $00, $10, $60, $7D, $00, $10, $01, $06 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $7F of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps7F::
Data_011_7594:: ; address name
    db $FF, $00, $00, $02, $7C, $80, $10, $00, $C0 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $80 of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps80::
Data_011_759E:: ; address name
    db $FE, $00, $00, $01, $70, $08, $19, $04, $04 ; id 0
    db $FE, $00, $02, $01, $70, $09, $19, $04, $04 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $81 of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps81::
Data_011_75B1:: ; address name
    db $FD, $00, $40, $40, $70, $05, $1B, $04, $04 ; id 0
    db $FD, $00, $40, $20, $82, $01, $32, $04, $08 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $82 of MapWarpTable; 9 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps82::
Data_011_75C4:: ; address name
    db $FE, $00, $01, $03, $81, $00, $10, $04, $03 ; id 0
    db $FD, $00, $60, $60, $83, $00, $10, $06, $06 ; id 1
    db $FD, $10, $30, $60, $83, $01, $10, $03, $06 ; id 2
    db $FD, $20, $40, $60, $83, $02, $10, $04, $06 ; id 3
    db $FD, $01, $70, $20, $83, $00, $11, $07, $02 ; id 4
    db $FD, $01, $40, $60, $83, $00, $11, $04, $06 ; id 5
    db $FD, $21, $20, $20, $83, $02, $11, $02, $02 ; id 6
    db $FD, $22, $70, $60, $83, $02, $12, $07, $06 ; id 7
    db $FD, $02, $20, $50, $84, $00, $10, $02, $05 ; id 8
    db $80 ; end

; E-0157 (derived: list for entry $83 of MapWarpTable; 7 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps83::
Data_011_7616:: ; address name
    db $FD, $00, $60, $60, $82, $00, $10, $06, $06 ; id 0
    db $FD, $10, $30, $60, $82, $01, $10, $03, $06 ; id 1
    db $FD, $20, $40, $60, $82, $02, $10, $04, $06 ; id 2
    db $FD, $01, $70, $20, $82, $00, $11, $07, $02 ; id 3
    db $FD, $01, $40, $60, $82, $00, $11, $04, $06 ; id 4
    db $FD, $21, $20, $20, $82, $02, $11, $02, $02 ; id 5
    db $FD, $22, $70, $60, $82, $02, $12, $07, $06 ; id 6
    db $80 ; end

; E-0157 (derived: list for entry $84 of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps84::
Data_011_7656:: ; address name
    db $FD, $00, $20, $50, $82, $00, $12, $02, $05 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $85 of MapWarpTable; 3 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps85::
Data_011_7660:: ; address name
    db $FE, $00, $00, $02, $70, $01, $1B, $04, $04 ; id 0
    db $FD, $00, $20, $30, $86, $00, $10, $02, $03 ; id 1
    db $FD, $10, $80, $50, $86, $01, $10, $08, $05 ; id 2
    db $80 ; end

; E-0157 (derived: list for entry $86 of MapWarpTable; 4 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps86::
Data_011_767C:: ; address name
    db $FD, $00, $20, $30, $85, $00, $10, $02, $03 ; id 0
    db $FD, $10, $80, $50, $85, $01, $10, $08, $05 ; id 1
    db $FD, $10, $60, $20, $87, $01, $10, $06, $02 ; id 2
    db $FD, $10, $80, $30, $87, $01, $10, $08, $03 ; id 3
    db $80 ; end

; E-0157 (derived: list for entry $87 of MapWarpTable; 4 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps87::
Data_011_76A1:: ; address name
    db $FD, $10, $60, $20, $86, $01, $10, $06, $02 ; id 0
    db $FD, $10, $80, $30, $86, $01, $10, $08, $03 ; id 1
    db $FD, $10, $80, $50, $88, $01, $10, $08, $05 ; id 2
    db $FD, $01, $20, $60, $88, $00, $11, $02, $06 ; id 3
    db $80 ; end

; E-0157 (derived: list for entry $88 of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps88::
Data_011_76C6:: ; address name
    db $FD, $10, $80, $50, $87, $01, $10, $08, $05 ; id 0
    db $FD, $01, $20, $60, $87, $00, $11, $02, $06 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $89 of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps89::
Data_011_76D9:: ; address name
    db $FE, $00, $00, $02, $71, $01, $10, $04, $00 ; id 0
    db $FD, $01, $50, $50, $73, $00, $31, $05, $08 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $8A of MapWarpTable; 3 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps8A::
Data_011_76EC:: ; address name
    db $FE, $00, $00, $01, $70, $0B, $1A, $04, $04 ; id 0
    db $FD, $00, $40, $40, $8B, $01, $33, $04, $08 ; id 1
    db $FD, $00, $50, $40, $8B, $01, $33, $05, $08 ; id 2
    db $80 ; end

; E-0157 (derived: list for entry $8B of MapWarpTable; 4 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps8B::
Data_011_7708:: ; address name
    db $FF, $00, $01, $04, $8A, $80, $10, $00, $C0 ; id 0
    db $FD, $01, $20, $60, $8C, $00, $11, $02, $06 ; id 1
    db $FD, $21, $70, $60, $8C, $02, $11, $07, $06 ; id 2
    db $FD, $21, $60, $10, $8D, $00, $30, $04, $08 ; id 3
    db $80 ; end

; E-0157 (derived: list for entry $8C of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps8C::
Data_011_772D:: ; address name
    db $FD, $01, $20, $60, $8B, $00, $11, $02, $06 ; id 0
    db $FD, $21, $70, $60, $8B, $02, $11, $07, $06 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $8D of MapWarpTable; 3 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps8D::
Data_011_7740:: ; address name
    db $FE, $00, $00, $01, $8B, $82, $11, $06, $01 ; id 0
    db $FD, $00, $40, $10, $8E, $02, $32, $04, $08 ; id 1
    db $FD, $00, $50, $10, $8E, $02, $32, $05, $08 ; id 2
    db $80 ; end

; E-0157 (derived: list for entry $8E of MapWarpTable; 5 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps8E::
Data_011_775C:: ; address name
    db $FF, $00, $02, $03, $8D, $80, $10, $00, $90 ; id 0
    db $FD, $00, $10, $10, $8F, $00, $10, $01, $07 ; id 1
    db $FD, $10, $50, $60, $90, $01, $11, $05, $06 ; id 2
    db $FD, $10, $40, $10, $91, $00, $30, $04, $08 ; id 3
    db $FD, $10, $50, $10, $91, $00, $30, $05, $08 ; id 4
    db $80 ; end

; E-0157 (derived: list for entry $8F of MapWarpTable; 3 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps8F::
Data_011_778A:: ; address name
    db $FD, $00, $10, $70, $8E, $00, $10, $01, $01 ; id 0
    db $FD, $00, $10, $00, $90, $00, $31, $01, $08 ; id 1
    db $FD, $00, $20, $00, $90, $00, $31, $02, $08 ; id 2
    db $80 ; end

; E-0157 (derived: list for entry $90 of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps90::
Data_011_77A6:: ; address name
    db $FF, $00, $00, $02, $8F, $80, $10, $00, $80 ; id 0
    db $FD, $11, $50, $60, $8E, $01, $10, $05, $06 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $91 of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps91::
Data_011_77B9:: ; address name
    db $FF, $00, $00, $01, $8E, $81, $10, $00, $90 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $92 of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps92::
Data_011_77C3:: ; address name
    db $FE, $00, $00, $01, $70, $05, $12, $04, $04 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $93 of MapWarpTable; 3 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps93::
Data_011_77CD:: ; address name
    db $FE, $00, $00, $01, $70, $04, $11, $04, $04 ; id 0
    db $FD, $00, $40, $20, $94, $00, $32, $04, $08 ; id 1
    db $FD, $00, $50, $20, $94, $00, $32, $05, $08 ; id 2
    db $80 ; end

; E-0157 (derived: list for entry $94 of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps94::
Data_011_77E9:: ; address name
    db $FF, $00, $00, $03, $93, $80, $10, $00, $A0 ; id 0
    db $FD, $10, $40, $40, $95, $00, $10, $04, $04 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $95 of MapWarpTable; 3 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps95::
Data_011_77FC:: ; address name
    db $FD, $00, $40, $40, $94, $01, $10, $04, $04 ; id 0
    db $FD, $01, $40, $40, $96, $00, $11, $04, $04 ; id 1
    db $FD, $11, $40, $40, $96, $01, $11, $04, $04 ; id 2
    db $80 ; end

; E-0157 (derived: list for entry $96 of MapWarpTable; 3 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps96::
Data_011_7818:: ; address name
    db $FD, $01, $40, $40, $95, $00, $11, $04, $04 ; id 0
    db $FD, $11, $40, $40, $95, $01, $11, $04, $04 ; id 1
    db $FD, $01, $10, $70, $97, $00, $10, $01, $07 ; id 2
    db $80 ; end

; E-0157 (derived: list for entry $97 of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps97::
Data_011_7834:: ; address name
    db $FD, $00, $10, $70, $96, $00, $11, $01, $07 ; id 0
    db $FD, $00, $80, $70, $98, $00, $10, $08, $07 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $98 of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps98::
Data_011_7847:: ; address name
    db $FD, $00, $80, $70, $97, $00, $10, $08, $07 ; id 0
    db $FD, $00, $80, $10, $99, $00, $10, $08, $01 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $99 of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps99::
Data_011_785A:: ; address name
    db $FD, $00, $80, $10, $98, $00, $10, $08, $01 ; id 0
    db $FD, $00, $10, $10, $9A, $00, $10, $01, $01 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $9A of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps9A::
Data_011_786D:: ; address name
    db $FD, $00, $10, $10, $99, $00, $10, $01, $01 ; id 0
    db $FD, $00, $10, $70, $9B, $00, $12, $01, $07 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $9B of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps9B::
Data_011_7880:: ; address name
    db $FD, $02, $10, $70, $9A, $00, $10, $01, $07 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $9D of MapWarpTable; 0 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarps9D::
    db $80 ; end

; E-0157 (derived: list for entry $A0 of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsA0::
Data_011_788B:: ; address name
    db $FD, $12, $40, $40, $A1, $00, $32, $04, $08 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $A1 of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsA1::
Data_011_7895:: ; address name
    db $FE, $00, $00, $03, $A0, $01, $12, $04, $04 ; id 0
    db $FF, $00, $00, $FF, $A2, $01, $32, $00, $80 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $A2 of MapWarpTable; 3 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsA2::
Data_011_78A8:: ; address name
    db $FF, $00, $01, $03, $A1, $00, $10, $00, $80 ; id 0
    db $FD, $10, $40, $10, $A3, $00, $31, $04, $08 ; id 1
    db $FD, $10, $50, $10, $A3, $00, $31, $05, $08 ; id 2
    db $80 ; end

; E-0157 (derived: list for entry $A3 of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsA3::
Data_011_78C4:: ; address name
    db $FF, $00, $00, $02, $A2, $81, $10, $00, $90 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $A4 of MapWarpTable; 0 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsA4::
    db $80 ; end

; E-0157 (derived: list for entry $A8 of MapWarpTable; 5 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsA8::
Data_011_78CF:: ; address name
    db $FD, $24, $40, $40, $A9, $00, $31, $04, $08 ; id 0
    db $FD, $24, $50, $40, $A9, $00, $31, $04, $08 ; id 1
    db $FD, $11, $40, $40, $AA, $00, $31, $04, $08 ; id 2
    db $FD, $43, $40, $40, $AB, $00, $30, $04, $08 ; id 3
    db $FD, $51, $40, $40, $AD, $01, $33, $04, $08 ; id 4
    db $80 ; end

; E-0157 (derived: list for entry $A9 of MapWarpTable; 3 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsA9::
Data_011_78FD:: ; address name
    db $FE, $01, $00, $02, $A8, $02, $14, $04, $04 ; id 0
    db $FE, $10, $02, $00, $A8, $02, $14, $04, $04 ; id 1
    db $FE, $11, $01, $02, $A8, $02, $14, $04, $04 ; id 2
    db $80 ; end

; E-0157 (derived: list for entry $AA of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsAA::
Data_011_7919:: ; address name
    db $FE, $01, $00, $02, $A8, $01, $11, $04, $04 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $AB of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsAB::
Data_011_7923:: ; address name
    db $FE, $00, $00, $01, $A8, $04, $13, $04, $04 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $AC of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsAC::
Data_011_792D:: ; address name
    db $FE, $00, $00, $01, $AE, $01, $00, $04, $00 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $AD of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsAD::
Data_011_7937:: ; address name
    db $FE, $00, $01, $04, $A8, $05, $11, $04, $04 ; id 0
    db $FF, $00, $02, $FF, $AE, $02, $03, $00, $80 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $AE of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsAE::
Data_011_794A:: ; address name
    db $FE, $00, $01, $FF, $AC, $00, $30, $04, $08 ; id 0
    db $FF, $00, $02, $04, $AD, $02, $00, $00, $80 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $AF of MapWarpTable; 0 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsAF::
    db $80 ; end

; E-0157 (derived: list for entry $B0 of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsB0::
Data_011_795E:: ; address name
    db $FD, $10, $40, $40, $B1, $00, $30, $04, $08 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $B1 of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsB1::
Data_011_7968:: ; address name
    db $FE, $00, $00, $01, $B0, $01, $10, $04, $04 ; id 0
    db $FD, $00, $10, $30, $B3, $00, $11, $01, $03 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $B3 of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsB3::
Data_011_797B:: ; address name
    db $FD, $01, $10, $30, $B1, $00, $10, $01, $03 ; id 0
    db $FD, $11, $50, $40, $B4, $01, $11, $05, $04 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $B4 of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsB4::
Data_011_798E:: ; address name
    db $FD, $11, $50, $40, $B3, $01, $11, $05, $04 ; id 0
    db $FD, $01, $20, $50, $B5, $00, $11, $02, $05 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $B5 of MapWarpTable; 3 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsB5::
Data_011_79A1:: ; address name
    db $FD, $01, $20, $50, $B4, $00, $11, $02, $05 ; id 0
    db $FD, $11, $40, $00, $B6, $00, $30, $04, $08 ; id 1
    db $FD, $11, $50, $00, $B6, $00, $30, $04, $08 ; id 2
    db $80 ; end

; E-0157 (derived: list for entry $B6 of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsB6::
Data_011_79BD:: ; address name
    db $FF, $00, $00, $01, $B5, $81, $11, $00, $80 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $B8 of MapWarpTable; 4 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsB8::
Data_011_79C7:: ; address name
    db $FD, $43, $40, $40, $B9, $00, $31, $04, $08 ; id 0
    db $FD, $43, $50, $40, $B9, $00, $31, $04, $08 ; id 1
    db $FD, $11, $30, $50, $BA, $00, $31, $03, $08 ; id 2
    db $FD, $40, $40, $40, $BB, $00, $31, $04, $08 ; id 3
    db $80 ; end

; E-0157 (derived: list for entry $B9 of MapWarpTable; 4 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsB9::
Data_011_79EC:: ; address name
    db $FE, $00, $00, $FF, $B8, $04, $13, $04, $04 ; id 0
    db $FE, $00, $00, $02, $B8, $04, $13, $04, $04 ; id 1
    db $FE, $00, $01, $02, $B8, $04, $13, $04, $04 ; id 2
    db $FD, $11, $50, $20, $BC, $00, $30, $05, $08 ; id 3
    db $80 ; end

; E-0157 (derived: list for entry $BA of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsBA::
Data_011_7A11:: ; address name
    db $FE, $00, $00, $02, $B8, $01, $11, $03, $05 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $BB of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsBB::
Data_011_7A1B:: ; address name
    db $FE, $01, $00, $02, $B8, $04, $10, $04, $04 ; id 0
    db $FD, $00, $40, $00, $BE, $00, $00, $04, $08 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $BC of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsBC::
Data_011_7A2E:: ; address name
    db $FE, $00, $00, $01, $B9, $81, $11, $05, $02 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $BD of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsBD::
Data_011_7A38:: ; address name
    db $FD, $00, $50, $70, $C4, $00, $10, $05, $07 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $BE of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsBE::
Data_011_7A42:: ; address name
    db $FE, $00, $00, $01, $BB, $80, $00, $04, $00 ; id 0
    db $FD, $00, $40, $30, $BF, $00, $10, $04, $03 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $BF of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsBF::
Data_011_7A55:: ; address name
    db $FD, $00, $40, $30, $BE, $00, $10, $04, $03 ; id 0
    db $FD, $11, $50, $50, $C0, $01, $11, $05, $05 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $C0 of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsC0::
Data_011_7A68:: ; address name
    db $FD, $11, $50, $50, $BF, $01, $11, $05, $05 ; id 0
    db $FD, $10, $70, $20, $C1, $01, $10, $07, $02 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $C1 of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsC1::
Data_011_7A7B:: ; address name
    db $FD, $10, $70, $20, $C0, $01, $10, $07, $02 ; id 0
    db $FD, $00, $70, $20, $C2, $00, $10, $07, $02 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $C2 of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsC2::
Data_011_7A8E:: ; address name
    db $FD, $00, $70, $20, $C1, $00, $10, $07, $02 ; id 0
    db $FD, $10, $40, $50, $C3, $01, $10, $04, $05 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $C3 of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsC3::
Data_011_7AA1:: ; address name
    db $FD, $10, $40, $50, $C2, $01, $10, $04, $05 ; id 0
    db $FD, $00, $70, $20, $C4, $00, $10, $07, $02 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $C4 of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsC4::
Data_011_7AB4:: ; address name
    db $FD, $00, $70, $20, $C3, $00, $10, $07, $02 ; id 0
    db $FD, $00, $50, $70, $BD, $00, $10, $05, $07 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $C8 of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsC8::
Data_011_7AC7:: ; address name
    db $FD, $00, $40, $40, $C9, $00, $31, $04, $08 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $C9 of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsC9::
Data_011_7AD1:: ; address name
    db $FE, $00, $00, $02, $C8, $00, $10, $04, $04 ; id 0
    db $FD, $00, $40, $50, $CA, $00, $11, $04, $05 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $CA of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsCA::
Data_011_7AE4:: ; address name
    db $FD, $01, $40, $50, $C9, $00, $10, $04, $05 ; id 0
    db $FD, $00, $40, $50, $CB, $00, $11, $04, $05 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $CB of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsCB::
Data_011_7AF7:: ; address name
    db $FD, $01, $40, $50, $CA, $00, $10, $04, $05 ; id 0
    db $FD, $00, $40, $50, $CC, $00, $11, $04, $05 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $CC of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsCC::
Data_011_7B0A:: ; address name
    db $FD, $01, $40, $50, $CB, $00, $10, $04, $05 ; id 0
    db $FD, $00, $40, $50, $CD, $00, $11, $04, $05 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $CD of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsCD::
Data_011_7B1D:: ; address name
    db $FD, $01, $40, $50, $CC, $00, $10, $04, $05 ; id 0
    db $FD, $00, $40, $50, $CE, $00, $11, $04, $05 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $CE of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsCE::
Data_011_7B30:: ; address name
    db $FD, $01, $40, $50, $CD, $00, $10, $04, $05 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $D1 of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsD1::
Data_011_7B3A:: ; address name
    db $FD, $01, $40, $40, $D2, $00, $31, $04, $08 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $D2 of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsD2::
Data_011_7B44:: ; address name
    db $FE, $00, $00, $02, $D1, $00, $11, $04, $04 ; id 0
    db $FD, $00, $40, $50, $D3, $00, $11, $04, $05 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $D3 of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsD3::
Data_011_7B57:: ; address name
    db $FD, $01, $40, $50, $D2, $00, $10, $04, $05 ; id 0
    db $FD, $00, $40, $50, $D4, $00, $11, $04, $05 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $D4 of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsD4::
Data_011_7B6A:: ; address name
    db $FD, $01, $40, $50, $D3, $00, $10, $04, $05 ; id 0
    db $FD, $00, $40, $50, $D5, $00, $11, $04, $05 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $D5 of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsD5::
Data_011_7B7D:: ; address name
    db $FD, $01, $40, $50, $D4, $00, $10, $04, $05 ; id 0
    db $FD, $00, $40, $50, $D6, $00, $11, $04, $05 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $D6 of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsD6::
Data_011_7B90:: ; address name
    db $FD, $01, $40, $50, $D5, $00, $10, $04, $05 ; id 0
    db $FD, $00, $40, $50, $D7, $00, $11, $04, $05 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $D7 of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsD7::
Data_011_7BA3:: ; address name
    db $FD, $01, $40, $50, $D6, $00, $10, $04, $05 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $DA of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsDA::
Data_011_7BAD:: ; address name
    db $FD, $10, $40, $40, $DB, $00, $31, $04, $08 ; id 0
    db $80 ; end

; E-0157 (derived: list for entry $DB of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsDB::
Data_011_7BB7:: ; address name
    db $FE, $00, $00, $02, $DA, $01, $10, $04, $04 ; id 0
    db $FD, $00, $40, $50, $DC, $00, $11, $04, $05 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $DC of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsDC::
Data_011_7BCA:: ; address name
    db $FD, $01, $40, $50, $DB, $00, $10, $04, $05 ; id 0
    db $FD, $00, $40, $50, $DD, $00, $11, $04, $05 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $DD of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsDD::
Data_011_7BDD:: ; address name
    db $FD, $01, $40, $50, $DC, $00, $10, $04, $05 ; id 0
    db $FD, $00, $40, $50, $DE, $00, $11, $04, $05 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $DE of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsDE::
Data_011_7BF0:: ; address name
    db $FD, $01, $40, $50, $DD, $00, $10, $04, $05 ; id 0
    db $FD, $00, $40, $50, $DF, $00, $11, $04, $05 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $DF of MapWarpTable; 2 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsDF::
Data_011_7C03:: ; address name
    db $FD, $01, $40, $50, $DE, $00, $10, $04, $05 ; id 0
    db $FD, $00, $40, $50, $E0, $00, $11, $04, $05 ; id 1
    db $80 ; end

; E-0157 (derived: list for entry $E0 of MapWarpTable; 1 record(s), then $80)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y; then destination map, screen and position bytes
MapWarpsE0::
Data_011_7C16:: ; address name
    db $FD, $01, $40, $50, $DF, $00, $10, $04, $05 ; id 0
    db $80 ; end
    ds $3E0, $00
