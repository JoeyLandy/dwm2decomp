; ROM bank $11: map records and warps
; The annotated listing of this bank is build/listing/bank11.asm.

SECTION "Bank 11", ROMX[$4000], BANK[$11]
    db $11, $c9

; unless a special mode is set (wMapType bit 7 hands over to CheckWarpAtPlayer_ReadMapType): walks
; the warp list MapWarpTable[hMapId]; an entry matching hPlayerFacing, the player's position and its
; screen nibbles starts a map change: wWarpPending = 1, sound effect $60 is queued, and the entry's
; new hMapId, hMapScreenX, hMapScreenY and position (wWarpDestX/wWarpDestY) are stored (E-0036)
CheckWarpAtPlayer::
    ld a, [wMapType]
    bit 7, a
    jr z, .read_map_id
    farcall CheckWarpAtPlayer_ReadMapType
    ret

.read_map_id:
    ldh a, [hMapId]
    ld l, a
    ld h, $00
    add hl, hl
    ld de, MapWarpTable
    add hl, de
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a

.skip:
    push de
    ld a, [de]
    inc de
    cp $80
    jr nz, .cp_FD
    pop de
    ld c, $00
    ret

.cp_FD:
    cp $fd
    jr z, .restore2
    cp $fe
    jr z, .set_warp_dest_facing
    cp $ff
    jr z, .set_warp_dest_facing
    ld c, a
    ldh a, [hPlayerFacing]
    cp c
    jr nz, .restore2
    ld a, [de]
    inc de
    ld [wWarpDestFacing], a
    push af
    swap a
    and $0f
    ld c, a
    ldh a, [hMapScreenX]
    cp c
    jr nz, .restore
    pop af
    and $0f
    ld c, a
    ldh a, [hMapScreenY]
    cp c
    jr nz, .restore2
    ld a, [de]
    inc de
    ld c, a
    ldh a, [hPlayerX]
    cp c
    jr nz, .restore2
    ld a, [de]
    inc de
    ld c, a
    ldh a, [hPlayerY]
    cp c
    jr nz, .restore2
    jr .set_warp_pending_to_01

.set_warp_dest_facing:
    ld [wWarpDestFacing], a
    inc de
    ld a, [de]
    inc de
    ld c, a
    ldh a, [hMapScreenX]
    cp c
    jr nz, .restore2
    ld a, [de]
    inc de
    ld c, a
    ldh a, [hMapScreenY]
    cp c
    jr nz, .restore2
    jr .set_warp_pending_to_01

.restore:
    pop af

.restore2:
    pop de
    ld a, e
    add $09
    ld e, a
    ld a, d
    adc $00
    ld d, a
    jr .skip

.set_warp_pending_to_01:
    ld a, $01
    ld [wWarpPending], a
    ld a, $60
    call QueueSoundEffect
    ld a, [de]
    inc de
    ldh [hMapId], a
    ld a, [de]
    inc de
    and $0f
    ldh [hMapScreenX], a
    ld a, [de]
    and $0f
    inc de
    ldh [hMapScreenY], a
    ld a, [wWarpDestFacing]
    cp $ff
    jr z, .skip2
    ld a, [de]
    inc de
    swap a
    and $f0
    ld [wWarpDestX], a
    ld a, [de]
    swap a
    and $f0
    ld [wWarpDestY], a
    dec de
    dec de
    dec de
    ld a, [de]
    bit 7, a
    jr z, .skip3
    ldh a, [hPlayerStateFlags]
    or $40
    ldh [hPlayerStateFlags], a
    ld a, [wWarpDestY]
    add $08
    ld [wWarpDestY], a
    jr .skip3

.skip2:
    ld a, [de]
    inc de
    ld c, a
    ldh a, [hPlayerX]
    add c
    ld [wWarpDestX], a
    ld a, [de]
    ld c, a
    ldh a, [hPlayerY]
    add c
    ld [wWarpDestY], a
    dec de
    dec de
    dec de
    ld a, [de]
    bit 7, a
    jr z, .skip3
    ldh a, [hPlayerStateFlags]
    or $40
    ldh [hPlayerStateFlags], a
    ld a, [wWarpDestY]
    add $08
    ld [wWarpDestY], a

.skip3:
    ld a, [de]
    swap a
    and $03
    cp $03
    jr z, .next
    ld [wLastWarpIndex], a

.next:
    inc de
    ld a, [de]
    swap a
    and $0f
    ld [wFieldTransitionKind], a
    ld a, $04
    call StartPaletteFade
    ld hl, wFieldInitStage
    inc [hl]
    ld a, $04
    ld [wModeState], a
    xor a
    ld [wFieldTransitionStep], a
    ldh a, [hPlayerStateFlags]
    or $80
    ldh [hPlayerStateFlags], a
    farcall ClearPendingFieldEventIfBit7AndNot6
    pop de
    ld c, $01
    ret

; special maps use CheckWarpsByMapType; otherwise checks the map exit table, then the warp list
; MapWarpTable[hMapId] against the player position and warps on a match (E-0131)
CheckWarpsAtPlayerPosition::
    ld a, [wMapType]
    bit 7, a
    jr z, .call_check_map_exit_table
    farcall CheckWarpsByMapType
    ret

.call_check_map_exit_table:
    call CheckMapExitTable
    bit 0, c
    ret nz
    ldh a, [hMapId]
    ld l, a
    ld h, $00
    add hl, hl
    ld de, MapWarpTable
    add hl, de
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a

.skip:
    push de
    ld a, [de]
    inc de
    cp $80
    jr nz, .cp_FD
    pop de
    ldh a, [hPlayerStateFlags]
    bit 7, a
    jr z, .done
    ldh a, [hMapId]
    cp $30
    jr nz, .check_player_state_flags
    ldh a, [hMapScreenX]
    cp $05
    jr nz, .check_player_state_flags
    ldh a, [hMapScreenY]
    cp $05
    jr nz, .check_player_state_flags
    ldh a, [hPlayerX]
    cp $40
    jr nz, .check_player_state_flags
    ldh a, [hPlayerY]
    cp $50
    jr nz, .check_player_state_flags
    ld de, EVENT_SCENE_CRATE
    call TestFlagBit
    jr c, .check_player_state_flags
    ld de, EVENT_WELCOME_YOUNG_HUMAN_I_HEARD
    call TestFlagBit
    jr nc, .check_player_state_flags
    jr .done

.check_player_state_flags:
    ldh a, [hPlayerStateFlags]
    and $7f
    ldh [hPlayerStateFlags], a

.done:
    ld c, $00
    ret

.cp_FD:
    cp $fd
    jr z, .set_warp_dest_facing
    jr .restore2

.set_warp_dest_facing:
    ld a, [de]
    inc de
    ld [wWarpDestFacing], a
    push af
    swap a
    and $0f
    ld c, a
    ldh a, [hMapScreenX]
    cp c
    jr nz, .restore
    pop af
    and $0f
    ld c, a
    ldh a, [hMapScreenY]
    cp c
    jr nz, .restore2
    ld a, [de]
    inc de
    ld c, a
    ldh a, [hPlayerX]
    cp c
    jr nz, .restore2
    ld a, [de]
    inc de
    ld c, a
    ldh a, [hPlayerY]
    cp c
    jr z, .check_player_state_flags2
    add $f8
    cp c
    jr nz, .restore2

.check_player_state_flags2:
    ldh a, [hPlayerStateFlags]
    bit 7, a
    jr z, .skip2
    pop de
    ld c, $00
    ret

.skip2:
    jr .set_warp_pending_to_01

.restore:
    pop af

.restore2:
    pop de
    ld a, e
    add $09
    ld e, a
    ld a, d
    adc $00
    ld d, a
    jp .skip

.set_warp_pending_to_01:
    ld a, $01
    ld [wWarpPending], a
    ld a, $60
    call QueueSoundEffect
    ld a, [de]
    inc de
    ldh [hMapId], a
    ld a, [de]
    and $0f
    inc de
    ldh [hMapScreenX], a
    ld a, [de]
    and $0f
    inc de
    ldh [hMapScreenY], a
    ld a, [de]
    inc de
    swap a
    and $f0
    ld [wWarpDestX], a
    ld a, [de]
    swap a
    and $f0
    ld [wWarpDestY], a
    dec de
    dec de
    dec de
    ld a, [de]
    bit 7, a
    jr z, .skip3
    ldh a, [hPlayerStateFlags]
    or $40
    ldh [hPlayerStateFlags], a
    ld a, [wWarpDestY]
    add $08
    ld [wWarpDestY], a
    jr .skip3

.skip3:
    ld a, [de]
    swap a
    and $03
    cp $03
    jr z, .next
    ld [wLastWarpIndex], a

.next:
    inc de
    ld a, [de]
    swap a
    and $0f
    ld [wFieldTransitionKind], a
    ld a, $04
    call StartPaletteFade
    ld hl, wFieldInitStage
    inc [hl]
    xor a
    ld [wFieldReturnPhase], a
    ld a, $04
    ld [wModeState], a
    xor a
    ld [wFieldTransitionStep], a
    ldh a, [hPlayerStateFlags]
    or $80
    ldh [hPlayerStateFlags], a
    farcall ClearPendingFieldEventIfBit7AndNot6
    pop de
    xor a
    ld [wJoypadPressed], a
    ld c, $01
    ret

; unless bit 7 of wMapType is set, looks hMapId up in WarpToLinkedMapForCurrentMap_Data1; when
; listed, sets the linked map from WarpToLinkedMapForCurrentMap_Data2 and warps (using wKeyWorldGoal
; when wKeyWorldKey selects it), C = 1; otherwise C = 0 (E-0125)
WarpToLinkedMapForCurrentMap::
    ld a, [wMapType]
    bit 7, a
    jp nz, WarpToLinkedMapForCurrentMap_Data2_Cp87
    ldh a, [hMapId]
    ld c, a
    ld b, $00
    ld hl, WarpToLinkedMapForCurrentMap_Data1

.skip:
    ld a, [hli]
    cp $ff
    jr nz, .skip2
    ld c, $00
    ret

.skip2:
    cp c
    jr z, .skip3
    inc b
    jr .skip

.skip3:
    ld a, b
    sla a
    add b
    ld de, WarpToLinkedMapForCurrentMap_Data2
    add e
    ld e, a
    jr nc, .set_map_id
    inc d

.set_map_id:
    ld a, [de]
    inc de
    ldh [hMapId], a
    ld a, [wKeyWorldActive]
    or a
    jr z, .call_script_warp_to_map_from_bytes_at_de
    ld a, [wKeyWorldKey]
    dec a
    cp b
    jr nz, .call_script_warp_to_map_from_bytes_at_de
    ld de, wKeyWorldGoal

.call_script_warp_to_map_from_bytes_at_de:
    call ScriptWarpToMapFromBytesAtDE
    ld c, $01
    ret

; data read by WarpToLinkedMapForCurrentMap (12 bytes) (E-0347)
WarpToLinkedMapForCurrentMap_Data1::
    db $29, $45, $68, $9d, $a4, $af, $b2, $c5, $d0, $d9, $e2, $ff

WarpToLinkedMapForCurrentMap_Data2::
    db $20, $44, $00, $30, $44, $76, $48, $44, $b4, $70, $44, $b4, $a0, $44, $10, $a8
    db $44, $00, $b0, $44, $01, $b8, $44, $44, $c8, $44, $01, $d1, $44, $00, $da, $44
    db $00

; Branches on wKeyWorldActive; branches on wKeyWorldKey; branches on wKeyWorldSlot; copies
; wKeyWorldGoal & $f0 to wWarpDestX; copies wKeyWorldGoal & $0f to wWarpDestY; copies
; wKeyWorldGoalCell & $f0 to hMapScreenX; copies wKeyWorldGoalCell & $0f to hMapScreenY; calls
; StartWarpTransition; copies wKeyWorldGoalPos to wWarpDestX; copies wKeyWorldGoalPos2 to
; wWarpDestY; copies wKeyWorldGoalScreen & $f0 to hMapScreenX; copies wKeyWorldGoalScreen & $0f to
; hMapScreenY; then 2 more steps (see the code) (E-0347)
; why: part of WarpToLinkedMapForCurrentMap_Data2, in part of WarpToLinkedMapForCurrentMap;
; WarpToLinkedMapForCurrentMap: unless bit 7 of wMapType is set, looks hMapId up in
; WarpToLinkedMapForCurrentMap_Data1 (E-0352, E-0125)
WarpToLinkedMapForCurrentMap_Data2_Cp87::
    cp $87
    jr z, .check_key_world_active
    ld c, $00
    ret

.check_key_world_active:
    ld a, [wKeyWorldActive]
    or a
    jr z, .read_key_world_goal_pos
    ld a, [wKeyWorldKey]
    bit 7, a
    jr z, .read_key_world_goal_pos
    and $7f
    ld c, a
    ld a, [wKeyWorldSlot]
    cp c
    jr nz, .read_key_world_goal_pos
    ld a, [wKeyWorldGoal]
    and $f0
    ld [wWarpDestX], a
    ld a, [wKeyWorldGoal]
    and $0f
    swap a
    ld [wWarpDestY], a
    ld a, [wKeyWorldGoalCell]
    and $f0
    swap a
    ldh [hMapScreenX], a
    ld a, [wKeyWorldGoalCell]
    and $0f
    ldh [hMapScreenY], a
    call StartWarpTransition
    ld c, $01
    ret

.read_key_world_goal_pos:
    ld a, [wKeyWorldGoalPos]
    ld [wWarpDestX], a
    ld a, [wKeyWorldGoalPos2]
    ld [wWarpDestY], a
    ld a, [wKeyWorldGoalScreen]
    and $f0
    swap a
    ldh [hMapScreenX], a
    ld a, [wKeyWorldGoalScreen]
    and $0f
    ldh [hMapScreenY], a
    call StartWarpTransition
    ld c, $01
    ret

; script command: plays sound $60 and reads a warp destination at DE (wWarpDestX/9 from the nibbles
; of byte 0, hMapScreenX/Y from byte 1), starts palette fade 4, wFieldInitStage += 1, wModeState =
; 4, updates hPlayerStateFlags and returns C = 1 (E-0121)
ScriptWarpToMapFromBytesAtDE::
    ld a, $01
    ld [wWarpPending], a
    ld a, $60
    call QueueSoundEffect
    ld a, [de]
    and $f0
    ld [wWarpDestX], a
    ld a, [de]
    swap a
    and $f0
    ld [wWarpDestY], a
    inc de
    ld a, [de]
    swap a
    and $0f
    ldh [hMapScreenX], a
    ld a, [de]
    and $0f
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
    xor a
    ld [wFieldTransitionStep], a
    ldh a, [hPlayerStateFlags]
    or $20
    and $7f
    ldh [hPlayerStateFlags], a
    farcall ClearPendingFieldEventIfBit7AndNot6
    pop de
    ld c, $01
    ret

; wWarpDestFacing = $F0, plays sound $60, starts palette fade 4, wModeState = 4, clears
; wFieldTransitionStep, updates hPlayerStateFlags and sets wFieldTransitionKind = 1 (E-0124)
StartWarpTransition::
    ld a, $f0
    ld [wWarpDestFacing], a
    ld a, $60
    call QueueSoundEffect
    ld a, $04
    call StartPaletteFade
    ld a, $04
    ld [wModeState], a
    xor a
    ld [wFieldTransitionStep], a
    ldh a, [hPlayerStateFlags]
    or $20
    and $7f
    ldh [hPlayerStateFlags], a
    ldh a, [hPlayerStateFlags]
    and $fe
    ldh [hPlayerStateFlags], a
    ld a, $01
    ld [wFieldTransitionKind], a
    ret

; for maps from $20 looks hMapId up in the 4-byte table CheckMapExitTable_Data and runs
; CheckMapExitTable_WriteWarpPendingAndMapIdEtc with its entry (or wKeyWorldGoal); unlisted maps
; clear bit 5 of hPlayerStateFlags and return C = 0 (E-0125) (E-0344: the address in its name
; dropped or read as the label there; was CheckMapExitTable)
CheckMapExitTable::
    ldh a, [hMapId]
    cp $20
    jr c, .check_player_state_flags
    ld c, a
    ld b, $00
    ld hl, CheckMapExitTable_Data

.skip:
    ld a, [hl]
    cp $ff
    jr nz, .skip2

.check_player_state_flags:
    ldh a, [hPlayerStateFlags]
    and $df
    ldh [hPlayerStateFlags], a
    ld c, $00
    ret

.skip2:
    cp c
    jr z, .check_key_world_active
    inc b
    inc hl
    inc hl
    inc hl
    inc hl
    jr .skip

.check_key_world_active:
    ld a, [wKeyWorldActive]
    or a
    jr z, .skip3
    ld a, [wKeyWorldKey]
    dec a
    cp b
    jr nz, .skip3
    ld de, wKeyWorldGoal
    call CheckMapExitTable_WriteWarpPendingAndMapIdEtc
    ret

.skip3:
    ld e, l
    ld d, h
    inc de
    call CheckMapExitTable_WriteWarpPendingAndMapIdEtc
    ret

; called from CheckMapExitTable: branches on hPlayerStateFlags; copies hPlayerStateFlags & $df to
; hPlayerStateFlags; sets wWarpPending to 1; plays sound $60; copies the byte at
; CheckMapExitTable_WriteWarpPendingAndMapIdEtc_Data to hMapId; sets hMapScreenX to 0; sets
; hMapScreenY to 0; sets wWarpDestX to $40; sets wWarpDestY to $80; sets wLastWarpIndex to 0; sets
; wFieldTransitionKind to 3; calls StartPaletteFade; then 7 more steps (see the code) (E-0347)
; why: a helper of CheckMapExitTable; CheckMapExitTable: for maps from $20 looks hMapId up in the
; 4-byte table CheckMapExitTable_Data and runs CheckMapExitTable_WriteWarpPendingAndMapIdEtc with
; ... (E-0352, E-0125, E-0344)
CheckMapExitTable_WriteWarpPendingAndMapIdEtc::
    ldh a, [hPlayerX]
    and $f0
    ld c, a
    ldh a, [hPlayerY]
    and $f0
    swap a
    or c
    ld c, a
    ld a, [de]
    cp c
    jr nz, .check_player_state_flags
    ldh a, [hMapScreenX]
    swap a
    ld c, a
    ldh a, [hMapScreenY]
    or c
    ld c, a
    inc de
    ld a, [de]
    cp c
    jr nz, .check_player_state_flags
    ldh a, [hPlayerStateFlags]
    bit 5, a
    jr z, .set_warp_pending_to_01
    ld c, $00
    ret

.check_player_state_flags:
    ldh a, [hPlayerStateFlags]
    and $df
    ldh [hPlayerStateFlags], a
    ld c, $00
    ret

.set_warp_pending_to_01:
    ld a, $01
    ld [wWarpPending], a
    ld a, $60
    call QueueSoundEffect
    inc de
    ld a, [de]
    dec a
    ld hl, CheckMapExitTable_WriteWarpPendingAndMapIdEtc_Data
    add_a_to_hl
    ld a, [hl]
    ldh [hMapId], a
    xor a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestX], a
    ld a, $80
    ld [wWarpDestY], a
    xor a
    ld [wLastWarpIndex], a
    ld a, $03
    ld [wFieldTransitionKind], a
    ld a, $04
    call StartPaletteFade
    ld hl, wFieldInitStage
    inc [hl]
    xor a
    ld [wFieldReturnPhase], a
    ld a, $04
    ld [wModeState], a
    xor a
    ld [wFieldTransitionStep], a
    ldh a, [hPlayerStateFlags]
    or $20
    ldh [hPlayerStateFlags], a
    farcall ClearPendingFieldEventIfBit7AndNot6
    ld c, $01
    ret

; data read by CheckMapExitTable (45 bytes) (E-0347)
CheckMapExitTable_Data::
    db $20, $44, $00, $01, $30, $44, $76, $02, $48, $44, $b4, $03, $70, $44, $b4, $04
    db $a0, $44, $10, $05, $a8, $44, $00, $06, $b0, $44, $01, $07, $b8, $44, $44, $08
    db $c8, $44, $01, $09, $d1, $44, $00, $0a, $da, $44, $00, $0b, $ff

CheckMapExitTable_WriteWarpPendingAndMapIdEtc_Data::
    db $29, $45, $68, $9d, $a4, $af, $b2, $c5, $d0, $d9, $e2

; E-0036 (C1: the pointer for map 56 is the record whose tileset stream (Map38Tileset) the game
; decompressed to $9000 on the emulator while hMapId was 56; the table has 256 words and ends where
; the first record begins; entries 30, 31 and 39 are not valid pointers and the system strings for
; map numbers 30, 31 and 39 (index 10 + number) read 'NO'; map 29 is the ship deck where a new game
; starts and the string at index 39 is 'Deck'). Records are 48 or 66 bytes; the first three far
; pointers (address and bank byte) name streams: the tileset for $9000 and, in later fields, the
; tile map for $C198 and the attribute map for $D000. E-0201: the complete map records at $59E4,
; $6248 and $62F0 (1 x 1 screens, found as trailing bytes of the records before them) have no entry
; here and are listed as extra records.
; record: map record in this bank, indexed by the map number hMapId
MapTable::
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

; map record of map $00, 3 x 4 screens, 8 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecord00::
    dfar AreaTileset0 ; entry 0: tileset
    dfar AreaPalettes0 ; palettes
    db $03, $04, $4e, $00, $01, $00, $00, $01, $10, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $60 ; variant flag byte
    dfar Map00Screens0 ; variant 0 screens
    dfar Map00Attrs0 ; variant 0 attributes
    dfar Map00Screens0 ; variant 1 screens
    dfar Map00Attrs0 ; variant 1 attributes
    dfar Map00Screens2 ; variant 2 screens
    dfar Map00Attrs2 ; variant 2 attributes
    dfar Map00Screens3 ; variant 3 screens
    dfar Map00Attrs3 ; variant 3 attributes
    dfar Map00Screens4 ; variant 4 screens
    dfar Map00Attrs4 ; variant 4 attributes
    dfar Map00Screens5 ; variant 5 screens
    dfar Map00Attrs5 ; variant 5 attributes
    dfar Map00Screens6 ; variant 6 screens
    dfar Map00Attrs6 ; variant 6 attributes
    dfar Map00Screens6 ; variant 7 screens
    dfar Map00Attrs6 ; variant 7 attributes

; map record of map $01, 4 x 3 screens, 8 decoded variant(s) (E-0142)
MapRecord01::
    dfar Map01Tileset ; entry 0: tileset
    dfar Map01Palettes ; palettes
    db $04, $03, $4f, $00, $01, $00, $00, $01, $0d, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $60 ; variant flag byte
    dfar Map01Screens0 ; variant 0 screens
    dfar Map01Attrs0 ; variant 0 attributes
    dfar Map01Screens0 ; variant 1 screens
    dfar Map01Attrs0 ; variant 1 attributes
    dfar Map01Screens0 ; variant 2 screens
    dfar Map01Attrs0 ; variant 2 attributes
    dfar Map01Screens3 ; variant 3 screens
    dfar Map01Attrs3 ; variant 3 attributes
    dfar Map01Screens4 ; variant 4 screens
    dfar Map01Attrs4 ; variant 4 attributes
    dfar Map01Screens5 ; variant 5 screens
    dfar Map01Attrs5 ; variant 5 attributes
    dfar Map01Screens6 ; variant 6 screens
    dfar Map01Attrs6 ; variant 6 attributes
    dfar Map01Screens6 ; variant 7 screens
    dfar Map01Attrs6 ; variant 7 attributes

; map record of map $02, 3 x 1 screens, 8 decoded variant(s) (E-0142)
MapRecord02::
    dfar Map02Tileset ; entry 0: tileset
    dfar Map02Palettes ; palettes
    db $03, $01, $31, $00, $01, $00, $00, $01, $0d, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $60 ; variant flag byte
    dfar Map02Screens0 ; variant 0 screens
    dfar Map02Attrs0 ; variant 0 attributes
    dfar Map02Screens1 ; variant 1 screens
    dfar Map02Attrs1 ; variant 1 attributes
    dfar Map02Screens1 ; variant 2 screens
    dfar Map02Attrs1 ; variant 2 attributes
    dfar Map02Screens3 ; variant 3 screens
    dfar Map02Attrs3 ; variant 3 attributes
    dfar Map02Screens4 ; variant 4 screens
    dfar Map02Attrs4 ; variant 4 attributes
    dfar Map02Screens5 ; variant 5 screens
    dfar Map02Attrs5 ; variant 5 attributes
    dfar Map02Screens6 ; variant 6 screens
    dfar Map02Attrs6 ; variant 6 attributes
    dfar Map02Screens6 ; variant 7 screens
    dfar Map02Attrs6 ; variant 7 attributes

; map record of map $03, 1 x 1 screens, 8 decoded variant(s) (E-0142)
MapRecord03::
    dfar Map03Tileset ; entry 0: tileset
    dfar Map03Palettes ; palettes
    db $01, $01, $2f, $2c, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $60 ; variant flag byte
    dfar Map03Screens0 ; variant 0 screens
    dfar Map03Attrs0 ; variant 0 attributes
    dfar Map03Screens0 ; variant 1 screens
    dfar Map03Attrs0 ; variant 1 attributes
    dfar Map03Screens0 ; variant 2 screens
    dfar Map03Attrs0 ; variant 2 attributes
    dfar Map03Screens0 ; variant 3 screens
    dfar Map03Attrs0 ; variant 3 attributes
    dfar Map03Screens0 ; variant 4 screens
    dfar Map03Attrs0 ; variant 4 attributes
    dfar Map03Screens0 ; variant 5 screens
    dfar Map03Attrs0 ; variant 5 attributes
    dfar Map03Screens0 ; variant 6 screens
    dfar Map03Attrs0 ; variant 6 attributes
    dfar Map03Screens0 ; variant 7 screens
    dfar Map03Attrs0 ; variant 7 attributes

; map record of map $04, 3 x 1 screens, 8 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecord04::
    dfar Map04Tileset ; entry 0: tileset
    dfar Map04Palettes ; palettes
    db $03, $01, $2e, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $60 ; variant flag byte
    dfar Map04Screens0 ; variant 0 screens
    dfar Map04Attrs0 ; variant 0 attributes
    dfar Map04Screens0 ; variant 1 screens
    dfar Map04Attrs0 ; variant 1 attributes
    dfar Map04Screens0 ; variant 2 screens
    dfar Map04Attrs0 ; variant 2 attributes
    dfar Map04Screens0 ; variant 3 screens
    dfar Map04Attrs0 ; variant 3 attributes
    dfar Map04Screens0 ; variant 4 screens
    dfar Map04Attrs0 ; variant 4 attributes
    dfar Map04Screens0 ; variant 5 screens
    dfar Map04Attrs0 ; variant 5 attributes
    dfar Map04Screens0 ; variant 6 screens
    dfar Map04Attrs0 ; variant 6 attributes
    dfar Map04Screens0 ; variant 7 screens
    dfar Map04Attrs0 ; variant 7 attributes

; map record of map $05, 3 x 1 screens, 8 decoded variant(s) (E-0142)
MapRecord05::
    dfar Map05Tileset ; entry 0: tileset
    dfar Map05Palettes ; palettes
    db $03, $01, $67, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $60 ; variant flag byte
    dfar Map05Screens0 ; variant 0 screens
    dfar Map05Attrs0 ; variant 0 attributes
    dfar Map05Screens0 ; variant 1 screens
    dfar Map05Attrs0 ; variant 1 attributes
    dfar Map05Screens0 ; variant 2 screens
    dfar Map05Attrs0 ; variant 2 attributes
    dfar Map05Screens0 ; variant 3 screens
    dfar Map05Attrs0 ; variant 3 attributes
    dfar Map05Screens0 ; variant 4 screens
    dfar Map05Attrs0 ; variant 4 attributes
    dfar Map05Screens0 ; variant 5 screens
    dfar Map05Attrs0 ; variant 5 attributes
    dfar Map05Screens0 ; variant 6 screens
    dfar Map05Attrs0 ; variant 6 attributes
    dfar Map05Screens7 ; variant 7 screens
    dfar Map05Attrs7 ; variant 7 attributes

; map record of map $06, 1 x 1 screens, 8 decoded variant(s) (E-0142)
MapRecord06::
    dfar Map06Tileset ; entry 0: tileset
    dfar Map06Palettes ; palettes
    db $01, $01, $33, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $60 ; variant flag byte
    dfar Map06Screens0 ; variant 0 screens
    dfar Map06Attrs0 ; variant 0 attributes
    dfar Map06Screens0 ; variant 1 screens
    dfar Map06Attrs0 ; variant 1 attributes
    dfar Map06Screens0 ; variant 2 screens
    dfar Map06Attrs0 ; variant 2 attributes
    dfar Map06Screens0 ; variant 3 screens
    dfar Map06Attrs0 ; variant 3 attributes
    dfar Map06Screens0 ; variant 4 screens
    dfar Map06Attrs0 ; variant 4 attributes
    dfar Map06Screens0 ; variant 5 screens
    dfar Map06Attrs0 ; variant 5 attributes
    dfar Map06Screens0 ; variant 6 screens
    dfar Map06Attrs0 ; variant 6 attributes
    dfar Map06Screens0 ; variant 7 screens
    dfar Map06Attrs0 ; variant 7 attributes

; map record of map $07, 1 x 2 screens, 8 decoded variant(s) (E-0142)
MapRecord07::
    dfar AreaTileset1 ; entry 0: tileset
    dfar AreaPalettes1 ; palettes
    db $01, $02, $3f, $00, $01, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $60 ; variant flag byte
    dfar Map07Screens0 ; variant 0 screens
    dfar Map07Attrs0 ; variant 0 attributes
    dfar Map07Screens0 ; variant 1 screens
    dfar Map07Attrs0 ; variant 1 attributes
    dfar Map07Screens0 ; variant 2 screens
    dfar Map07Attrs0 ; variant 2 attributes
    dfar Map07Screens0 ; variant 3 screens
    dfar Map07Attrs0 ; variant 3 attributes
    dfar Map07Screens0 ; variant 4 screens
    dfar Map07Attrs0 ; variant 4 attributes
    dfar Map07Screens0 ; variant 5 screens
    dfar Map07Attrs0 ; variant 5 attributes
    dfar Map07Screens0 ; variant 6 screens
    dfar Map07Attrs0 ; variant 6 attributes
    dfar Map07Screens7 ; variant 7 screens
    dfar Map07Attrs7 ; variant 7 attributes

; map record of map $09, 1 x 1 screens, 8 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecord09::
    dfar Map09Tileset ; entry 0: tileset
    dfar Map09Palettes ; palettes
    db $01, $01, $24, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $60 ; variant flag byte
    dfar Map09Screens0 ; variant 0 screens
    dfar Map09Attrs0 ; variant 0 attributes
    dfar Map09Screens0 ; variant 1 screens
    dfar Map09Attrs0 ; variant 1 attributes
    dfar Map09Screens0 ; variant 2 screens
    dfar Map09Attrs0 ; variant 2 attributes
    dfar Map09Screens0 ; variant 3 screens
    dfar Map09Attrs0 ; variant 3 attributes
    dfar Map09Screens0 ; variant 4 screens
    dfar Map09Attrs0 ; variant 4 attributes
    dfar Map09Screens0 ; variant 5 screens
    dfar Map09Attrs0 ; variant 5 attributes
    dfar Map09Screens0 ; variant 6 screens
    dfar Map09Attrs0 ; variant 6 attributes
    dfar Map09Screens0 ; variant 7 screens
    dfar Map09Attrs0 ; variant 7 attributes

; map record of map $08, 1 x 1 screens, 8 decoded variant(s) (E-0142)
MapRecord08::
    dfar Map08Tileset ; entry 0: tileset
    dfar Map08Palettes ; palettes
    db $01, $01, $24, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $60 ; variant flag byte
    dfar Map08Screens0 ; variant 0 screens
    dfar Map08Attrs0 ; variant 0 attributes
    dfar Map08Screens0 ; variant 1 screens
    dfar Map08Attrs0 ; variant 1 attributes
    dfar Map08Screens0 ; variant 2 screens
    dfar Map08Attrs0 ; variant 2 attributes
    dfar Map08Screens0 ; variant 3 screens
    dfar Map08Attrs0 ; variant 3 attributes
    dfar Map08Screens0 ; variant 4 screens
    dfar Map08Attrs0 ; variant 4 attributes
    dfar Map08Screens0 ; variant 5 screens
    dfar Map08Attrs0 ; variant 5 attributes
    dfar Map08Screens0 ; variant 6 screens
    dfar Map08Attrs0 ; variant 6 attributes
    dfar Map08Screens0 ; variant 7 screens
    dfar Map08Attrs0 ; variant 7 attributes

; map record of map $0A, 1 x 1 screens, 8 decoded variant(s) (E-0142)
MapRecord0A::
    dfar Map0ATileset ; entry 0: tileset
    dfar Map0APalettes ; palettes
    db $01, $01, $2a, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $60 ; variant flag byte
    dfar Map0AScreens0 ; variant 0 screens
    dfar Map0AAttrs0 ; variant 0 attributes
    dfar Map0AScreens0 ; variant 1 screens
    dfar Map0AAttrs0 ; variant 1 attributes
    dfar Map0AScreens0 ; variant 2 screens
    dfar Map0AAttrs0 ; variant 2 attributes
    dfar Map0AScreens0 ; variant 3 screens
    dfar Map0AAttrs0 ; variant 3 attributes
    dfar Map0AScreens0 ; variant 4 screens
    dfar Map0AAttrs0 ; variant 4 attributes
    dfar Map0AScreens0 ; variant 5 screens
    dfar Map0AAttrs0 ; variant 5 attributes
    dfar Map0AScreens0 ; variant 6 screens
    dfar Map0AAttrs0 ; variant 6 attributes
    dfar Map0AScreens0 ; variant 7 screens
    dfar Map0AAttrs0 ; variant 7 attributes

; map record of map $0B, 1 x 1 screens, 8 decoded variant(s) (E-0142)
MapRecord0B::
    dfar Map0BTileset ; entry 0: tileset
    dfar Map0BPalettes ; palettes
    db $01, $01, $00, $00, $07, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $60 ; variant flag byte
    dfar Map0BScreens0 ; variant 0 screens
    dfar Map0BAttrs0 ; variant 0 attributes
    dfar Map0BScreens0 ; variant 1 screens
    dfar Map0BAttrs0 ; variant 1 attributes
    dfar Map0BScreens0 ; variant 2 screens
    dfar Map0BAttrs0 ; variant 2 attributes
    dfar Map0BScreens0 ; variant 3 screens
    dfar Map0BAttrs0 ; variant 3 attributes
    dfar Map0BScreens0 ; variant 4 screens
    dfar Map0BAttrs0 ; variant 4 attributes
    dfar Map0BScreens0 ; variant 5 screens
    dfar Map0BAttrs0 ; variant 5 attributes
    dfar Map0BScreens0 ; variant 6 screens
    dfar Map0BAttrs0 ; variant 6 attributes
    dfar Map0BScreens0 ; variant 7 screens
    dfar Map0BAttrs0 ; variant 7 attributes

; map record of map $0C, 2 x 1 screens, 8 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecord0C::
    dfar Map0CTileset ; entry 0: tileset
    dfar Map0CPalettes ; palettes
    db $02, $01, $2f, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $60 ; variant flag byte
    dfar Map0CScreens0 ; variant 0 screens
    dfar Map0CAttrs0 ; variant 0 attributes
    dfar Map0CScreens0 ; variant 1 screens
    dfar Map0CAttrs0 ; variant 1 attributes
    dfar Map0CScreens0 ; variant 2 screens
    dfar Map0CAttrs0 ; variant 2 attributes
    dfar Map0CScreens0 ; variant 3 screens
    dfar Map0CAttrs0 ; variant 3 attributes
    dfar Map0CScreens0 ; variant 4 screens
    dfar Map0CAttrs0 ; variant 4 attributes
    dfar Map0CScreens0 ; variant 5 screens
    dfar Map0CAttrs0 ; variant 5 attributes
    dfar Map0CScreens0 ; variant 6 screens
    dfar Map0CAttrs0 ; variant 6 attributes
    dfar Map0CScreens0 ; variant 7 screens
    dfar Map0CAttrs0 ; variant 7 attributes

; map record of map $0D, 4 x 2 screens, 8 decoded variant(s) (E-0142)
MapRecord0D::
    dfar Map0DTileset ; entry 0: tileset
    dfar Map0DPalettes ; palettes
    db $04, $02, $3f, $00, $0f, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $60 ; variant flag byte
    dfar Map0DScreens0 ; variant 0 screens
    dfar Map0DAttrs0 ; variant 0 attributes
    dfar Map0DScreens0 ; variant 1 screens
    dfar Map0DAttrs0 ; variant 1 attributes
    dfar Map0DScreens0 ; variant 2 screens
    dfar Map0DAttrs0 ; variant 2 attributes
    dfar Map0DScreens0 ; variant 3 screens
    dfar Map0DAttrs0 ; variant 3 attributes
    dfar Map0DScreens4 ; variant 4 screens
    dfar Map0DAttrs4 ; variant 4 attributes
    dfar Map0DScreens4 ; variant 5 screens
    dfar Map0DAttrs4 ; variant 5 attributes
    dfar Map0DScreens4 ; variant 6 screens
    dfar Map0DAttrs4 ; variant 6 attributes
    dfar Map0DScreens7 ; variant 7 screens
    dfar Map0DAttrs7 ; variant 7 attributes

; map record of map $0E, 1 x 1 screens, 8 decoded variant(s) (E-0142)
MapRecord0E::
    dfar Map0ETileset ; entry 0: tileset
    dfar Map0EPalettes ; palettes
    db $01, $01, $2f, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $60 ; variant flag byte
    dfar Map0EScreens0 ; variant 0 screens
    dfar Map0EAttrs0 ; variant 0 attributes
    dfar Map0EScreens0 ; variant 1 screens
    dfar Map0EAttrs0 ; variant 1 attributes
    dfar Map0EScreens0 ; variant 2 screens
    dfar Map0EAttrs0 ; variant 2 attributes
    dfar Map0EScreens0 ; variant 3 screens
    dfar Map0EAttrs0 ; variant 3 attributes
    dfar Map0EScreens0 ; variant 4 screens
    dfar Map0EAttrs0 ; variant 4 attributes
    dfar Map0EScreens0 ; variant 5 screens
    dfar Map0EAttrs0 ; variant 5 attributes
    dfar Map0EScreens0 ; variant 6 screens
    dfar Map0EAttrs0 ; variant 6 attributes
    dfar Map0EScreens0 ; variant 7 screens
    dfar Map0EAttrs0 ; variant 7 attributes

; map record of map $0F, 1 x 1 screens, 8 decoded variant(s) (E-0142)
MapRecord0F::
    dfar Map0FTileset ; entry 0: tileset
    dfar Map0FPalettes ; palettes
    db $01, $01, $50, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $60 ; variant flag byte
    dfar Map0FScreens0 ; variant 0 screens
    dfar Map0FAttrs0 ; variant 0 attributes
    dfar Map0FScreens0 ; variant 1 screens
    dfar Map0FAttrs0 ; variant 1 attributes
    dfar Map0FScreens0 ; variant 2 screens
    dfar Map0FAttrs0 ; variant 2 attributes
    dfar Map0FScreens0 ; variant 3 screens
    dfar Map0FAttrs0 ; variant 3 attributes
    dfar Map0FScreens0 ; variant 4 screens
    dfar Map0FAttrs0 ; variant 4 attributes
    dfar Map0FScreens0 ; variant 5 screens
    dfar Map0FAttrs0 ; variant 5 attributes
    dfar Map0FScreens0 ; variant 6 screens
    dfar Map0FAttrs0 ; variant 6 attributes
    dfar Map0FScreens7 ; variant 7 screens
    dfar Map0FAttrs7 ; variant 7 attributes

; map record of map $10, 1 x 1 screens, 8 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecord10::
    dfar Map10Tileset ; entry 0: tileset
    dfar Map10Palettes ; palettes
    db $01, $01, $24, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $60 ; variant flag byte
    dfar Map10Screens0 ; variant 0 screens
    dfar Map10Attrs0 ; variant 0 attributes
    dfar Map10Screens0 ; variant 1 screens
    dfar Map10Attrs0 ; variant 1 attributes
    dfar Map10Screens0 ; variant 2 screens
    dfar Map10Attrs0 ; variant 2 attributes
    dfar Map10Screens0 ; variant 3 screens
    dfar Map10Attrs0 ; variant 3 attributes
    dfar Map10Screens0 ; variant 4 screens
    dfar Map10Attrs0 ; variant 4 attributes
    dfar Map10Screens0 ; variant 5 screens
    dfar Map10Attrs0 ; variant 5 attributes
    dfar Map10Screens0 ; variant 6 screens
    dfar Map10Attrs0 ; variant 6 attributes
    dfar Map10Screens0 ; variant 7 screens
    dfar Map10Attrs0 ; variant 7 attributes

; map record of map $11, 1 x 2 screens, 8 decoded variant(s) (E-0142)
MapRecord11::
    dfar Map11Tileset ; entry 0: tileset
    dfar Map11Palettes ; palettes
    db $01, $02, $33, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $60 ; variant flag byte
    dfar Map11Screens0 ; variant 0 screens
    dfar Map11Attrs0 ; variant 0 attributes
    dfar Map11Screens0 ; variant 1 screens
    dfar Map11Attrs0 ; variant 1 attributes
    dfar Map11Screens0 ; variant 2 screens
    dfar Map11Attrs0 ; variant 2 attributes
    dfar Map11Screens0 ; variant 3 screens
    dfar Map11Attrs0 ; variant 3 attributes
    dfar Map11Screens0 ; variant 4 screens
    dfar Map11Attrs0 ; variant 4 attributes
    dfar Map11Screens0 ; variant 5 screens
    dfar Map11Attrs0 ; variant 5 attributes
    dfar Map11Screens0 ; variant 6 screens
    dfar Map11Attrs0 ; variant 6 attributes
    dfar Map11Screens0 ; variant 7 screens
    dfar Map11Attrs0 ; variant 7 attributes

; map record of map $12, 1 x 1 screens, 8 decoded variant(s) (E-0142)
MapRecord12::
    dfar Map12Tileset ; entry 0: tileset
    dfar Map12Palettes ; palettes
    db $01, $01, $2f, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $60 ; variant flag byte
    dfar Map12Screens0 ; variant 0 screens
    dfar Map12Attrs0 ; variant 0 attributes
    dfar Map12Screens0 ; variant 1 screens
    dfar Map12Attrs0 ; variant 1 attributes
    dfar Map12Screens0 ; variant 2 screens
    dfar Map12Attrs0 ; variant 2 attributes
    dfar Map12Screens0 ; variant 3 screens
    dfar Map12Attrs0 ; variant 3 attributes
    dfar Map12Screens0 ; variant 4 screens
    dfar Map12Attrs0 ; variant 4 attributes
    dfar Map12Screens0 ; variant 5 screens
    dfar Map12Attrs0 ; variant 5 attributes
    dfar Map12Screens0 ; variant 6 screens
    dfar Map12Attrs0 ; variant 6 attributes
    dfar Map12Screens0 ; variant 7 screens
    dfar Map12Attrs0 ; variant 7 attributes

; map record of map $13, 1 x 1 screens, 8 decoded variant(s) (E-0142)
MapRecord13::
    dfar Map13Tileset ; entry 0: tileset
    dfar Map13Palettes ; palettes
    db $01, $01, $27, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $60 ; variant flag byte
    dfar Map13Screens0 ; variant 0 screens
    dfar Map13Attrs0 ; variant 0 attributes
    dfar Map13Screens0 ; variant 1 screens
    dfar Map13Attrs0 ; variant 1 attributes
    dfar Map13Screens0 ; variant 2 screens
    dfar Map13Attrs0 ; variant 2 attributes
    dfar Map13Screens0 ; variant 3 screens
    dfar Map13Attrs0 ; variant 3 attributes
    dfar Map13Screens0 ; variant 4 screens
    dfar Map13Attrs0 ; variant 4 attributes
    dfar Map13Screens0 ; variant 5 screens
    dfar Map13Attrs0 ; variant 5 attributes
    dfar Map13Screens0 ; variant 6 screens
    dfar Map13Attrs0 ; variant 6 attributes
    dfar Map13Screens0 ; variant 7 screens
    dfar Map13Attrs0 ; variant 7 attributes

; map record of map $14, 1 x 1 screens, 8 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecord14::
    dfar Map14Tileset ; entry 0: tileset
    dfar Map14Palettes ; palettes
    db $01, $01, $00, $00, $08, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $60 ; variant flag byte
    dfar Map14Screens0 ; variant 0 screens
    dfar Map14Attrs0 ; variant 0 attributes
    dfar Map14Screens0 ; variant 1 screens
    dfar Map14Attrs0 ; variant 1 attributes
    dfar Map14Screens0 ; variant 2 screens
    dfar Map14Attrs0 ; variant 2 attributes
    dfar Map14Screens0 ; variant 3 screens
    dfar Map14Attrs0 ; variant 3 attributes
    dfar Map14Screens0 ; variant 4 screens
    dfar Map14Attrs0 ; variant 4 attributes
    dfar Map14Screens0 ; variant 5 screens
    dfar Map14Attrs0 ; variant 5 attributes
    dfar Map14Screens0 ; variant 6 screens
    dfar Map14Attrs0 ; variant 6 attributes
    dfar Map14Screens0 ; variant 7 screens
    dfar Map14Attrs0 ; variant 7 attributes

; map record of map $15, 1 x 1 screens, 8 decoded variant(s) (E-0142)
MapRecord15::
    dfar Map15Tileset ; entry 0: tileset
    dfar Map15Palettes ; palettes
    db $01, $01, $2f, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $60 ; variant flag byte
    dfar Map15Screens0 ; variant 0 screens
    dfar Map15Attrs0 ; variant 0 attributes
    dfar Map15Screens0 ; variant 1 screens
    dfar Map15Attrs0 ; variant 1 attributes
    dfar Map15Screens0 ; variant 2 screens
    dfar Map15Attrs0 ; variant 2 attributes
    dfar Map15Screens0 ; variant 3 screens
    dfar Map15Attrs0 ; variant 3 attributes
    dfar Map15Screens0 ; variant 4 screens
    dfar Map15Attrs0 ; variant 4 attributes
    dfar Map15Screens0 ; variant 5 screens
    dfar Map15Attrs0 ; variant 5 attributes
    dfar Map15Screens0 ; variant 6 screens
    dfar Map15Attrs0 ; variant 6 attributes
    dfar Map15Screens0 ; variant 7 screens
    dfar Map15Attrs0 ; variant 7 attributes

; map record of map $16, 1 x 1 screens, 8 decoded variant(s) (E-0142)
MapRecord16::
    dfar Map16Tileset ; entry 0: tileset
    dfar Map16Palettes ; palettes
    db $01, $01, $2b, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $60 ; variant flag byte
    dfar Map16Screens0 ; variant 0 screens
    dfar Map16Attrs0 ; variant 0 attributes
    dfar Map16Screens0 ; variant 1 screens
    dfar Map16Attrs0 ; variant 1 attributes
    dfar Map16Screens0 ; variant 2 screens
    dfar Map16Attrs0 ; variant 2 attributes
    dfar Map16Screens0 ; variant 3 screens
    dfar Map16Attrs0 ; variant 3 attributes
    dfar Map16Screens0 ; variant 4 screens
    dfar Map16Attrs0 ; variant 4 attributes
    dfar Map16Screens0 ; variant 5 screens
    dfar Map16Attrs0 ; variant 5 attributes
    dfar Map16Screens0 ; variant 6 screens
    dfar Map16Attrs0 ; variant 6 attributes
    dfar Map16Screens0 ; variant 7 screens
    dfar Map16Attrs0 ; variant 7 attributes

; map record of map $17, 1 x 1 screens, 8 decoded variant(s) (E-0142)
MapRecord17::
    dfar Map17Tileset ; entry 0: tileset
    dfar Map17Palettes ; palettes
    db $01, $01, $3a, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $60 ; variant flag byte
    dfar Map17Screens0 ; variant 0 screens
    dfar Map17Attrs0 ; variant 0 attributes
    dfar Map17Screens0 ; variant 1 screens
    dfar Map17Attrs0 ; variant 1 attributes
    dfar Map17Screens0 ; variant 2 screens
    dfar Map17Attrs0 ; variant 2 attributes
    dfar Map17Screens0 ; variant 3 screens
    dfar Map17Attrs0 ; variant 3 attributes
    dfar Map17Screens0 ; variant 4 screens
    dfar Map17Attrs0 ; variant 4 attributes
    dfar Map17Screens0 ; variant 5 screens
    dfar Map17Attrs0 ; variant 5 attributes
    dfar Map17Screens0 ; variant 6 screens
    dfar Map17Attrs0 ; variant 6 attributes
    dfar Map17Screens0 ; variant 7 screens
    dfar Map17Attrs0 ; variant 7 attributes

; map record of map $18, 3 x 2 screens, 8 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecord18::
    dfar Map18Tileset ; entry 0: tileset
    dfar Map18Palettes ; palettes
    db $03, $02, $39, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $60 ; variant flag byte
    dfar Map18Screens0 ; variant 0 screens
    dfar Map18Attrs0 ; variant 0 attributes
    dfar Map18Screens0 ; variant 1 screens
    dfar Map18Attrs0 ; variant 1 attributes
    dfar Map18Screens0 ; variant 2 screens
    dfar Map18Attrs0 ; variant 2 attributes
    dfar Map18Screens0 ; variant 3 screens
    dfar Map18Attrs0 ; variant 3 attributes
    dfar Map18Screens0 ; variant 4 screens
    dfar Map18Attrs0 ; variant 4 attributes
    dfar Map18Screens0 ; variant 5 screens
    dfar Map18Attrs0 ; variant 5 attributes
    dfar Map18Screens0 ; variant 6 screens
    dfar Map18Attrs0 ; variant 6 attributes
    dfar Map18Screens0 ; variant 7 screens
    dfar Map18Attrs0 ; variant 7 attributes

; map record of map $19, 2 x 3 screens, 8 decoded variant(s) (E-0142)
MapRecord19::
    dfar Map19Tileset ; entry 0: tileset
    dfar Map19Palettes ; palettes
    db $02, $03, $57, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $60 ; variant flag byte
    dfar Map19Screens0 ; variant 0 screens
    dfar Map19Attrs0 ; variant 0 attributes
    dfar Map19Screens0 ; variant 1 screens
    dfar Map19Attrs0 ; variant 1 attributes
    dfar Map19Screens0 ; variant 2 screens
    dfar Map19Attrs0 ; variant 2 attributes
    dfar Map19Screens0 ; variant 3 screens
    dfar Map19Attrs0 ; variant 3 attributes
    dfar Map19Screens0 ; variant 4 screens
    dfar Map19Attrs0 ; variant 4 attributes
    dfar Map19Screens0 ; variant 5 screens
    dfar Map19Attrs0 ; variant 5 attributes
    dfar Map19Screens6 ; variant 6 screens
    dfar Map19Attrs6 ; variant 6 attributes
    dfar Map19Screens0 ; variant 7 screens
    dfar Map19Attrs0 ; variant 7 attributes

; map record of map $1A, 3 x 1 screens, 8 decoded variant(s) (E-0142)
MapRecord1A::
    dfar Map1ATileset ; entry 0: tileset
    dfar Map1APalettes ; palettes
    db $03, $01, $4b, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $60 ; variant flag byte
    dfar Map1AScreens0 ; variant 0 screens
    dfar Map1AAttrs0 ; variant 0 attributes
    dfar Map1AScreens0 ; variant 1 screens
    dfar Map1AAttrs0 ; variant 1 attributes
    dfar Map1AScreens0 ; variant 2 screens
    dfar Map1AAttrs0 ; variant 2 attributes
    dfar Map1AScreens0 ; variant 3 screens
    dfar Map1AAttrs0 ; variant 3 attributes
    dfar Map1AScreens0 ; variant 4 screens
    dfar Map1AAttrs0 ; variant 4 attributes
    dfar Map1AScreens5 ; variant 5 screens
    dfar Map1AAttrs5 ; variant 5 attributes
    dfar Map1AScreens5 ; variant 6 screens
    dfar Map1AAttrs5 ; variant 6 attributes
    dfar Map1AScreens5 ; variant 7 screens
    dfar Map1AAttrs5 ; variant 7 attributes

; map record of map $1B, 1 x 3 screens, 8 decoded variant(s) (E-0142)
MapRecord1B::
    dfar Map1BTileset ; entry 0: tileset
    dfar Map1BPalettes ; palettes
    db $01, $03, $1f, $00, $00, $00, $00, $02, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $60 ; variant flag byte
    dfar Map1BScreens0 ; variant 0 screens
    dfar Map1BAttrs0 ; variant 0 attributes
    dfar Map1BScreens0 ; variant 1 screens
    dfar Map1BAttrs0 ; variant 1 attributes
    dfar Map1BScreens0 ; variant 2 screens
    dfar Map1BAttrs0 ; variant 2 attributes
    dfar Map1BScreens0 ; variant 3 screens
    dfar Map1BAttrs0 ; variant 3 attributes
    dfar Map1BScreens0 ; variant 4 screens
    dfar Map1BAttrs0 ; variant 4 attributes
    dfar Map1BScreens0 ; variant 5 screens
    dfar Map1BAttrs0 ; variant 5 attributes
    dfar Map1BScreens0 ; variant 6 screens
    dfar Map1BAttrs0 ; variant 6 attributes
    dfar Map1BScreens0 ; variant 7 screens
    dfar Map1BAttrs0 ; variant 7 attributes

; map record of map $1C, 1 x 2 screens, 2 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecord1C::
    dfar Map1CTileset ; entry 0: tileset
    dfar Map1CPalettes ; palettes
    db $01, $02, $00, $00, $01, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $60 ; variant flag byte
    dfar Map1CScreens0 ; variant 0 screens
    dfar Map1CAttrs0 ; variant 0 attributes
    dfar Map1CScreens0 ; variant 1 screens
    dfar Map1CAttrs0 ; variant 1 attributes

; map record of map $1D, 2 x 1 screens, 2 decoded variant(s) (E-0142)
MapRecord1D::
    dfar Map1DTileset ; entry 0: tileset
    dfar Map1DPalettes ; palettes
    db $02, $01, $37, $00, $0e, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $60 ; variant flag byte
    dfar Map1DScreens0 ; variant 0 screens
    dfar Map1DAttrs0 ; variant 0 attributes
    dfar Map1DScreens0 ; variant 1 screens
    dfar Map1DAttrs0 ; variant 1 attributes

; map record of map $20, 8 x 8 screens, 7 decoded variant(s) (E-0142)
MapRecord20::
    dfar Map20Tileset ; entry 0: tileset
    dfar Map20Palettes ; palettes
    db $08, $08, $2b, $00, $00, $01, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $61 ; variant flag byte
    dfar Map20Screens0 ; variant 0 screens
    dfar Map20Attrs0 ; variant 0 attributes
    dfar Map20Screens0 ; variant 1 screens
    dfar Map20Attrs0 ; variant 1 attributes
    dfar Map20Screens0 ; variant 2 screens
    dfar Map20Attrs0 ; variant 2 attributes
    dfar Map20Screens0 ; variant 3 screens
    dfar Map20Attrs0 ; variant 3 attributes
    dfar Map20Screens0 ; variant 4 screens
    dfar Map20Attrs0 ; variant 4 attributes
    dfar Map20Screens0 ; variant 5 screens
    dfar Map20Attrs0 ; variant 5 attributes
    dfar Map20Screens0 ; variant 6 screens
    dfar Map20Attrs0 ; variant 6 attributes

; map record of map $21, 2 x 1 screens, 7 decoded variant(s) (E-0142)
MapRecord21::
    dfar Map21Tileset ; entry 0: tileset
    dfar Map21Palettes ; palettes
    db $02, $01, $4e, $00, $01, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $61 ; variant flag byte
    dfar Map21Screens0 ; variant 0 screens
    dfar Map21Attrs0 ; variant 0 attributes
    dfar Map21Screens0 ; variant 1 screens
    dfar Map21Attrs0 ; variant 1 attributes
    dfar Map21Screens0 ; variant 2 screens
    dfar Map21Attrs0 ; variant 2 attributes
    dfar Map21Screens0 ; variant 3 screens
    dfar Map21Attrs0 ; variant 3 attributes
    dfar Map21Screens0 ; variant 4 screens
    dfar Map21Attrs0 ; variant 4 attributes
    dfar Map21Screens0 ; variant 5 screens
    dfar Map21Attrs0 ; variant 5 attributes
    dfar Map21Screens0 ; variant 6 screens
    dfar Map21Attrs0 ; variant 6 attributes

; map record of map $22, 1 x 1 screens, 7 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecord22::
    dfar Map22Tileset ; entry 0: tileset
    dfar Map22Palettes ; palettes
    db $01, $01, $30, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $61 ; variant flag byte
    dfar Map22Screens0 ; variant 0 screens
    dfar Map22Attrs0 ; variant 0 attributes
    dfar Map22Screens0 ; variant 1 screens
    dfar Map22Attrs0 ; variant 1 attributes
    dfar Map22Screens0 ; variant 2 screens
    dfar Map22Attrs0 ; variant 2 attributes
    dfar Map22Screens0 ; variant 3 screens
    dfar Map22Attrs0 ; variant 3 attributes
    dfar Map22Screens0 ; variant 4 screens
    dfar Map22Attrs0 ; variant 4 attributes
    dfar Map22Screens0 ; variant 5 screens
    dfar Map22Attrs0 ; variant 5 attributes
    dfar Map22Screens0 ; variant 6 screens
    dfar Map22Attrs0 ; variant 6 attributes

; map record of map $23, 1 x 1 screens, 7 decoded variant(s) (E-0142)
MapRecord23::
    dfar Map23Tileset ; entry 0: tileset
    dfar Map23Palettes ; palettes
    db $01, $01, $31, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $61 ; variant flag byte
    dfar Map23Screens0 ; variant 0 screens
    dfar Map23Attrs0 ; variant 0 attributes
    dfar Map23Screens0 ; variant 1 screens
    dfar Map23Attrs0 ; variant 1 attributes
    dfar Map23Screens0 ; variant 2 screens
    dfar Map23Attrs0 ; variant 2 attributes
    dfar Map23Screens0 ; variant 3 screens
    dfar Map23Attrs0 ; variant 3 attributes
    dfar Map23Screens0 ; variant 4 screens
    dfar Map23Attrs0 ; variant 4 attributes
    dfar Map23Screens0 ; variant 5 screens
    dfar Map23Attrs0 ; variant 5 attributes
    dfar Map23Screens0 ; variant 6 screens
    dfar Map23Attrs0 ; variant 6 attributes

; map record of map $24, 2 x 2 screens, 7 decoded variant(s) (E-0142)
MapRecord24::
    dfar Map24Tileset ; entry 0: tileset
    dfar Map24Palettes ; palettes
    db $02, $02, $48, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $61 ; variant flag byte
    dfar Map24Screens0 ; variant 0 screens
    dfar Map24Attrs0 ; variant 0 attributes
    dfar Map24Screens0 ; variant 1 screens
    dfar Map24Attrs0 ; variant 1 attributes
    dfar Map24Screens0 ; variant 2 screens
    dfar Map24Attrs0 ; variant 2 attributes
    dfar Map24Screens0 ; variant 3 screens
    dfar Map24Attrs0 ; variant 3 attributes
    dfar Map24Screens0 ; variant 4 screens
    dfar Map24Attrs0 ; variant 4 attributes
    dfar Map24Screens0 ; variant 5 screens
    dfar Map24Attrs0 ; variant 5 attributes
    dfar Map24Screens0 ; variant 6 screens
    dfar Map24Attrs0 ; variant 6 attributes

; map record of map $25, 2 x 1 screens, 7 decoded variant(s) (E-0142)
MapRecord25::
    dfar Map25Tileset ; entry 0: tileset
    dfar Map25Palettes ; palettes
    db $02, $01, $37, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $61 ; variant flag byte
    dfar Map25Screens0 ; variant 0 screens
    dfar Map25Attrs0 ; variant 0 attributes
    dfar Map25Screens0 ; variant 1 screens
    dfar Map25Attrs0 ; variant 1 attributes
    dfar Map25Screens0 ; variant 2 screens
    dfar Map25Attrs0 ; variant 2 attributes
    dfar Map25Screens0 ; variant 3 screens
    dfar Map25Attrs0 ; variant 3 attributes
    dfar Map25Screens0 ; variant 4 screens
    dfar Map25Attrs0 ; variant 4 attributes
    dfar Map25Screens0 ; variant 5 screens
    dfar Map25Attrs0 ; variant 5 attributes
    dfar Map25Screens0 ; variant 6 screens
    dfar Map25Attrs0 ; variant 6 attributes

; map record of map $26, 1 x 1 screens, 7 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecord26::
    dfar Map26Tileset ; entry 0: tileset
    dfar Map26Palettes ; palettes
    db $01, $01, $58, $00, $06, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $61 ; variant flag byte
    dfar Map26Screens0 ; variant 0 screens
    dfar Map26Attrs0 ; variant 0 attributes
    dfar Map26Screens1 ; variant 1 screens
    dfar Map26Attrs1 ; variant 1 attributes
    dfar Map26Screens1 ; variant 2 screens
    dfar Map26Attrs1 ; variant 2 attributes
    dfar Map26Screens1 ; variant 3 screens
    dfar Map26Attrs1 ; variant 3 attributes
    dfar Map26Screens1 ; variant 4 screens
    dfar Map26Attrs1 ; variant 4 attributes
    dfar Map26Screens1 ; variant 5 screens
    dfar Map26Attrs1 ; variant 5 attributes
    dfar Map26Screens1 ; variant 6 screens
    dfar Map26Attrs1 ; variant 6 attributes

; map record of map $28, 1 x 2 screens, 7 decoded variant(s) (E-0142)
MapRecord28::
    dfar Map28Tileset ; entry 0: tileset
    dfar Map28Palettes ; palettes
    db $01, $02, $2f, $00, $01, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $61 ; variant flag byte
    dfar Map28Screens0 ; variant 0 screens
    dfar Map28Attrs0 ; variant 0 attributes
    dfar Map28Screens0 ; variant 1 screens
    dfar Map28Attrs0 ; variant 1 attributes
    dfar Map28Screens0 ; variant 2 screens
    dfar Map28Attrs0 ; variant 2 attributes
    dfar Map28Screens0 ; variant 3 screens
    dfar Map28Attrs0 ; variant 3 attributes
    dfar Map28Screens0 ; variant 4 screens
    dfar Map28Attrs0 ; variant 4 attributes
    dfar Map28Screens0 ; variant 5 screens
    dfar Map28Attrs0 ; variant 5 attributes
    dfar Map28Screens0 ; variant 6 screens
    dfar Map28Attrs0 ; variant 6 attributes

; map record of map $29, 1 x 1 screens, 7 decoded variant(s) (E-0142)
MapRecord29::
    dfar Map29Tileset ; entry 0: tileset
    dfar Map29Palettes ; palettes
    db $01, $01, $32, $2c, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $61 ; variant flag byte
    dfar Map29Screens0 ; variant 0 screens
    dfar Map29Attrs0 ; variant 0 attributes
    dfar Map29Screens0 ; variant 1 screens
    dfar Map29Attrs0 ; variant 1 attributes
    dfar Map29Screens0 ; variant 2 screens
    dfar Map29Attrs0 ; variant 2 attributes
    dfar Map29Screens0 ; variant 3 screens
    dfar Map29Attrs0 ; variant 3 attributes
    dfar Map29Screens0 ; variant 4 screens
    dfar Map29Attrs0 ; variant 4 attributes
    dfar Map29Screens0 ; variant 5 screens
    dfar Map29Attrs0 ; variant 5 attributes
    dfar Map29Screens0 ; variant 6 screens
    dfar Map29Attrs0 ; variant 6 attributes

; map record of map $2A, 1 x 1 screens, 7 decoded variant(s) (E-0142)
MapRecord2A::
    dfar Map2ATileset ; entry 0: tileset
    dfar Map2APalettes ; palettes
    db $01, $01, $27, $00, $01, $00, $00, $01, $0f, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $61 ; variant flag byte
    dfar Map2AScreens0 ; variant 0 screens
    dfar Map2AAttrs0 ; variant 0 attributes
    dfar Map2AScreens0 ; variant 1 screens
    dfar Map2AAttrs0 ; variant 1 attributes
    dfar Map2AScreens0 ; variant 2 screens
    dfar Map2AAttrs0 ; variant 2 attributes
    dfar Map2AScreens0 ; variant 3 screens
    dfar Map2AAttrs0 ; variant 3 attributes
    dfar Map2AScreens0 ; variant 4 screens
    dfar Map2AAttrs0 ; variant 4 attributes
    dfar Map2AScreens0 ; variant 5 screens
    dfar Map2AAttrs0 ; variant 5 attributes
    dfar Map2AScreens0 ; variant 6 screens
    dfar Map2AAttrs0 ; variant 6 attributes

; map record of map $2B, 4 x 4 screens, 7 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecord2B::
    dfar Map2BTileset ; entry 0: tileset
    dfar Map2BPalettes ; palettes
    db $04, $04, $4f, $00, $01, $02, $00, $01, $0d, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $61 ; variant flag byte
    dfar Map2BScreens0 ; variant 0 screens
    dfar Map2BAttrs0 ; variant 0 attributes
    dfar Map2BScreens0 ; variant 1 screens
    dfar Map2BAttrs0 ; variant 1 attributes
    dfar Map2BScreens2 ; variant 2 screens
    dfar Map2BAttrs2 ; variant 2 attributes
    dfar Map2BScreens2 ; variant 3 screens
    dfar Map2BAttrs2 ; variant 3 attributes
    dfar Map2BScreens2 ; variant 4 screens
    dfar Map2BAttrs2 ; variant 4 attributes
    dfar Map2BScreens2 ; variant 5 screens
    dfar Map2BAttrs2 ; variant 5 attributes
    dfar Map2BScreens2 ; variant 6 screens
    dfar Map2BAttrs2 ; variant 6 attributes

; map record of map $2D, 1 x 1 screens, 7 decoded variant(s) (E-0142)
MapRecord2D::
    dfar Map2DTileset ; entry 0: tileset
    dfar Map2DPalettes ; palettes
    db $01, $01, $21, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $61 ; variant flag byte
    dfar Map2DScreens0 ; variant 0 screens
    dfar Map2DAttrs0 ; variant 0 attributes
    dfar Map2DScreens0 ; variant 1 screens
    dfar Map2DAttrs0 ; variant 1 attributes
    dfar Map2DScreens0 ; variant 2 screens
    dfar Map2DAttrs0 ; variant 2 attributes
    dfar Map2DScreens0 ; variant 3 screens
    dfar Map2DAttrs0 ; variant 3 attributes
    dfar Map2DScreens0 ; variant 4 screens
    dfar Map2DAttrs0 ; variant 4 attributes
    dfar Map2DScreens0 ; variant 5 screens
    dfar Map2DAttrs0 ; variant 5 attributes
    dfar Map2DScreens0 ; variant 6 screens
    dfar Map2DAttrs0 ; variant 6 attributes

; map record of map $2E, 1 x 1 screens, 7 decoded variant(s) (E-0142)
MapRecord2E::
    dfar Map25Tileset ; entry 0: tileset
    dfar Map25Palettes ; palettes
    db $01, $01, $37, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $61 ; variant flag byte
    dfar Map2EScreens0 ; variant 0 screens
    dfar Map2EAttrs0 ; variant 0 attributes
    dfar Map2EScreens0 ; variant 1 screens
    dfar Map2EAttrs0 ; variant 1 attributes
    dfar Map2EScreens0 ; variant 2 screens
    dfar Map2EAttrs0 ; variant 2 attributes
    dfar Map2EScreens3 ; variant 3 screens
    dfar Map2EAttrs3 ; variant 3 attributes
    dfar Map2EScreens3 ; variant 4 screens
    dfar Map2EAttrs3 ; variant 4 attributes
    dfar Map2EScreens3 ; variant 5 screens
    dfar Map2EAttrs3 ; variant 5 attributes
    dfar Map2EScreens0 ; variant 6 screens
    dfar Map2EAttrs0 ; variant 6 attributes

; map record of map $2F, 2 x 2 screens, 7 decoded variant(s) (E-0142)
MapRecord2F::
    dfar Map2FTileset ; entry 0: tileset
    dfar Map2FPalettes ; palettes
    db $02, $02, $37, $00, $01, $00, $00, $01, $09, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $61 ; variant flag byte
    dfar Map2FScreens0 ; variant 0 screens
    dfar Map2FAttrs0 ; variant 0 attributes
    dfar Map2FScreens0 ; variant 1 screens
    dfar Map2FAttrs0 ; variant 1 attributes
    dfar Map2FScreens0 ; variant 2 screens
    dfar Map2FAttrs0 ; variant 2 attributes
    dfar Map2FScreens0 ; variant 3 screens
    dfar Map2FAttrs0 ; variant 3 attributes
    dfar Map2FScreens4 ; variant 4 screens
    dfar Map2FAttrs4 ; variant 4 attributes
    dfar Map2FScreens5 ; variant 5 screens
    dfar Map2FAttrs5 ; variant 5 attributes
    dfar Map2FScreens5 ; variant 6 screens
    dfar Map2FAttrs5 ; variant 6 attributes

; map record of map $30, 8 x 8 screens, 5 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecord30::
    dfar Map30Tileset ; entry 0: tileset
    dfar Map30Palettes ; palettes
    db $08, $08, $3d, $00, $01, $03, $00, $01, $27, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $62 ; variant flag byte
    dfar Map30Screens0 ; variant 0 screens
    dfar Map30Attrs0 ; variant 0 attributes
    dfar Map30Screens0 ; variant 1 screens
    dfar Map30Attrs0 ; variant 1 attributes
    dfar Map30Screens2 ; variant 2 screens
    dfar Map30Attrs2 ; variant 2 attributes
    dfar Map30Screens2 ; variant 3 screens
    dfar Map30Attrs2 ; variant 3 attributes
    dfar Map30Screens2 ; variant 4 screens
    dfar Map30Attrs2 ; variant 4 attributes

; map record of map $31, 1 x 2 screens, 5 decoded variant(s) (E-0142)
MapRecord31::
    dfar Map31Tileset ; entry 0: tileset
    dfar Map31Palettes ; palettes
    db $01, $02, $3f, $00, $01, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $62 ; variant flag byte
    dfar Map31Screens0 ; variant 0 screens
    dfar Map31Attrs0 ; variant 0 attributes
    dfar Map31Screens0 ; variant 1 screens
    dfar Map31Attrs0 ; variant 1 attributes
    dfar Map31Screens0 ; variant 2 screens
    dfar Map31Attrs0 ; variant 2 attributes
    dfar Map31Screens0 ; variant 3 screens
    dfar Map31Attrs0 ; variant 3 attributes
    dfar Map31Screens0 ; variant 4 screens
    dfar Map31Attrs0 ; variant 4 attributes

; map record of map $32, 2 x 2 screens, 5 decoded variant(s) (E-0142)
MapRecord32::
    dfar Map32Tileset ; entry 0: tileset
    dfar Map32Palettes ; palettes
    db $02, $02, $4b, $00, $01, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $62 ; variant flag byte
    dfar Map32Screens0 ; variant 0 screens
    dfar Map32Attrs0 ; variant 0 attributes
    dfar Map32Screens0 ; variant 1 screens
    dfar Map32Attrs0 ; variant 1 attributes
    dfar Map32Screens2 ; variant 2 screens
    dfar Map32Attrs2 ; variant 2 attributes
    dfar Map32Screens2 ; variant 3 screens
    dfar Map32Attrs2 ; variant 3 attributes
    dfar Map32Screens2 ; variant 4 screens
    dfar Map32Attrs2 ; variant 4 attributes

; map record of map $33, 1 x 2 screens, 5 decoded variant(s) (E-0142)
MapRecord33::
    dfar Map33Tileset ; entry 0: tileset
    dfar Map33Palettes ; palettes
    db $01, $02, $3f, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $62 ; variant flag byte
    dfar Map33Screens0 ; variant 0 screens
    dfar Map33Attrs0 ; variant 0 attributes
    dfar Map33Screens0 ; variant 1 screens
    dfar Map33Attrs0 ; variant 1 attributes
    dfar Map33Screens0 ; variant 2 screens
    dfar Map33Attrs0 ; variant 2 attributes
    dfar Map33Screens0 ; variant 3 screens
    dfar Map33Attrs0 ; variant 3 attributes
    dfar Map33Screens0 ; variant 4 screens
    dfar Map33Attrs0 ; variant 4 attributes

; map record of map $34, 1 x 1 screens, 5 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecord34::
    dfar Map34Tileset ; entry 0: tileset
    dfar Map34Palettes ; palettes
    db $01, $01, $2a, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $62 ; variant flag byte
    dfar Map34Screens0 ; variant 0 screens
    dfar Map34Attrs0 ; variant 0 attributes
    dfar Map34Screens0 ; variant 1 screens
    dfar Map34Attrs0 ; variant 1 attributes
    dfar Map34Screens0 ; variant 2 screens
    dfar Map34Attrs0 ; variant 2 attributes
    dfar Map34Screens0 ; variant 3 screens
    dfar Map34Attrs0 ; variant 3 attributes
    dfar Map34Screens0 ; variant 4 screens
    dfar Map34Attrs0 ; variant 4 attributes

; map record of map $35, 4 x 4 screens, 5 decoded variant(s) (E-0142)
MapRecord35::
    dfar Map35Tileset ; entry 0: tileset
    dfar Map35Palettes ; palettes
    db $04, $04, $29, $00, $01, $04, $00, $01, $0f, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $62 ; variant flag byte
    dfar Map35Screens0 ; variant 0 screens
    dfar Map35Attrs0 ; variant 0 attributes
    dfar Map35Screens0 ; variant 1 screens
    dfar Map35Attrs0 ; variant 1 attributes
    dfar Map35Screens0 ; variant 2 screens
    dfar Map35Attrs0 ; variant 2 attributes
    dfar Map35Screens0 ; variant 3 screens
    dfar Map35Attrs0 ; variant 3 attributes
    dfar Map35Screens0 ; variant 4 screens
    dfar Map35Attrs0 ; variant 4 attributes

; map record of map $36, 1 x 1 screens, 5 decoded variant(s) (E-0142)
MapRecord36::
    dfar Map36Tileset ; entry 0: tileset
    dfar Map36Palettes ; palettes
    db $01, $01, $23, $00, $01, $00, $00, $01, $09, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $62 ; variant flag byte
    dfar Map36Screens0 ; variant 0 screens
    dfar Map36Attrs0 ; variant 0 attributes
    dfar Map36Screens0 ; variant 1 screens
    dfar Map36Attrs0 ; variant 1 attributes
    dfar Map36Screens0 ; variant 2 screens
    dfar Map36Attrs0 ; variant 2 attributes
    dfar Map36Screens0 ; variant 3 screens
    dfar Map36Attrs0 ; variant 3 attributes
    dfar Map36Screens0 ; variant 4 screens
    dfar Map36Attrs0 ; variant 4 attributes

; map record of map $37, 3 x 1 screens, 5 decoded variant(s) (E-0142)
MapRecord37::
    dfar Map37Tileset ; entry 0: tileset
    dfar Map37Palettes ; palettes
    db $03, $01, $4f, $00, $01, $07, $00, $01, $0d, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $62 ; variant flag byte
    dfar Map37Screens0 ; variant 0 screens
    dfar Map37Attrs0 ; variant 0 attributes
    dfar Map37Screens0 ; variant 1 screens
    dfar Map37Attrs0 ; variant 1 attributes
    dfar Map37Screens0 ; variant 2 screens
    dfar Map37Attrs0 ; variant 2 attributes
    dfar Map37Screens0 ; variant 3 screens
    dfar Map37Attrs0 ; variant 3 attributes
    dfar Map37Screens0 ; variant 4 screens
    dfar Map37Attrs0 ; variant 4 attributes

; map record of map $38, 4 x 4 screens, 5 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecord38::
    dfar Map38Tileset ; entry 0: tileset
    dfar Map38Palettes ; palettes
    db $04, $04, $3f, $00, $00, $05, $00, $00, $01, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $62 ; variant flag byte
    dfar Map38Screens0 ; variant 0 screens
    dfar Map38Attrs0 ; variant 0 attributes
    dfar Map38Screens0 ; variant 1 screens
    dfar Map38Attrs0 ; variant 1 attributes
    dfar Map38Screens0 ; variant 2 screens
    dfar Map38Attrs0 ; variant 2 attributes
    dfar Map38Screens0 ; variant 3 screens
    dfar Map38Attrs0 ; variant 3 attributes
    dfar Map38Screens0 ; variant 4 screens
    dfar Map38Attrs0 ; variant 4 attributes

; map record of map $39, 4 x 3 screens, 5 decoded variant(s) (E-0142)
MapRecord39::
    dfar Map38Tileset ; entry 0: tileset
    dfar Map38Palettes ; palettes
    db $04, $03, $3f, $00, $00, $05, $00, $02, $01, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $62 ; variant flag byte
    dfar Map39Screens0 ; variant 0 screens
    dfar Map39Attrs0 ; variant 0 attributes
    dfar Map39Screens0 ; variant 1 screens
    dfar Map39Attrs0 ; variant 1 attributes
    dfar Map39Screens0 ; variant 2 screens
    dfar Map39Attrs0 ; variant 2 attributes
    dfar Map39Screens3 ; variant 3 screens
    dfar Map39Attrs3 ; variant 3 attributes
    dfar Map39Screens3 ; variant 4 screens
    dfar Map39Attrs3 ; variant 4 attributes

; map record of map $3A, 3 x 3 screens, 5 decoded variant(s) (E-0142)
MapRecord3A::
    dfar Map38Tileset ; entry 0: tileset
    dfar Map38Palettes ; palettes
    db $03, $03, $3f, $00, $00, $05, $06, $02, $01, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $62 ; variant flag byte
    dfar Map3AScreens0 ; variant 0 screens
    dfar Map3AAttrs0 ; variant 0 attributes
    dfar Map3AScreens0 ; variant 1 screens
    dfar Map3AAttrs0 ; variant 1 attributes
    dfar Map3AScreens0 ; variant 2 screens
    dfar Map3AAttrs0 ; variant 2 attributes
    dfar Map3AScreens0 ; variant 3 screens
    dfar Map3AAttrs0 ; variant 3 attributes
    dfar Map3AScreens0 ; variant 4 screens
    dfar Map3AAttrs0 ; variant 4 attributes

; map record of map $3B, 1 x 1 screens, 5 decoded variant(s) (E-0142)
MapRecord3B::
    dfar Map3BTileset ; entry 0: tileset
    dfar Map3BPalettes ; palettes
    db $01, $01, $37, $2c, $00, $00, $00, $02, $01, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $62 ; variant flag byte
    dfar Map3BScreens0 ; variant 0 screens
    dfar Map3BAttrs0 ; variant 0 attributes
    dfar Map3BScreens0 ; variant 1 screens
    dfar Map3BAttrs0 ; variant 1 attributes
    dfar Map3BScreens0 ; variant 2 screens
    dfar Map3BAttrs0 ; variant 2 attributes
    dfar Map3BScreens0 ; variant 3 screens
    dfar Map3BAttrs0 ; variant 3 attributes
    dfar Map3BScreens4 ; variant 4 screens
    dfar Map3BAttrs4 ; variant 4 attributes

; map record of map $3C, 3 x 1 screens, 5 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecord3C::
    dfar Map3CTileset ; entry 0: tileset
    dfar Map3CPalettes ; palettes
    db $03, $01, $3f, $00, $01, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $62 ; variant flag byte
    dfar Map3CScreens0 ; variant 0 screens
    dfar Map3CAttrs0 ; variant 0 attributes
    dfar Map3CScreens0 ; variant 1 screens
    dfar Map3CAttrs0 ; variant 1 attributes
    dfar Map3CScreens0 ; variant 2 screens
    dfar Map3CAttrs0 ; variant 2 attributes
    dfar Map3CScreens0 ; variant 3 screens
    dfar Map3CAttrs0 ; variant 3 attributes
    dfar Map3CScreens0 ; variant 4 screens
    dfar Map3CAttrs0 ; variant 4 attributes

; map record of map $3D, 1 x 1 screens, 5 decoded variant(s) (E-0142)
MapRecord3D::
    dfar Map3DTileset ; entry 0: tileset
    dfar Map3DPalettes ; palettes
    db $01, $01, $2a, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $62 ; variant flag byte
    dfar Map3DScreens0 ; variant 0 screens
    dfar Map3DAttrs0 ; variant 0 attributes
    dfar Map3DScreens0 ; variant 1 screens
    dfar Map3DAttrs0 ; variant 1 attributes
    dfar Map3DScreens0 ; variant 2 screens
    dfar Map3DAttrs0 ; variant 2 attributes
    dfar Map3DScreens0 ; variant 3 screens
    dfar Map3DAttrs0 ; variant 3 attributes
    dfar Map3DScreens0 ; variant 4 screens
    dfar Map3DAttrs0 ; variant 4 attributes

; map record of map $3E, 2 x 2 screens, 5 decoded variant(s) (E-0142)
MapRecord3E::
    dfar Map3ETileset ; entry 0: tileset
    dfar Map3EPalettes ; palettes
    db $02, $02, $2f, $00, $01, $06, $00, $01, $0e, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $62 ; variant flag byte
    dfar Map3EScreens0 ; variant 0 screens
    dfar Map3EAttrs0 ; variant 0 attributes
    dfar Map3EScreens0 ; variant 1 screens
    dfar Map3EAttrs0 ; variant 1 attributes
    dfar Map3EScreens0 ; variant 2 screens
    dfar Map3EAttrs0 ; variant 2 attributes
    dfar Map3EScreens0 ; variant 3 screens
    dfar Map3EAttrs0 ; variant 3 attributes
    dfar Map3EScreens0 ; variant 4 screens
    dfar Map3EAttrs0 ; variant 4 attributes

; map record of map $3F, 2 x 2 screens, 5 decoded variant(s) (E-0142)
MapRecord3F::
    dfar Map3ETileset ; entry 0: tileset
    dfar Map3EPalettes ; palettes
    db $02, $02, $2f, $00, $01, $06, $00, $01, $0e, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $62 ; variant flag byte
    dfar Map3FScreens0 ; variant 0 screens
    dfar Map3FAttrs0 ; variant 0 attributes
    dfar Map3FScreens0 ; variant 1 screens
    dfar Map3FAttrs0 ; variant 1 attributes
    dfar Map3FScreens0 ; variant 2 screens
    dfar Map3FAttrs0 ; variant 2 attributes
    dfar Map3FScreens0 ; variant 3 screens
    dfar Map3FAttrs0 ; variant 3 attributes
    dfar Map3FScreens0 ; variant 4 screens
    dfar Map3FAttrs0 ; variant 4 attributes

; map record of map $40, 1 x 2 screens, 5 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecord40::
    dfar Map40Tileset ; entry 0: tileset
    dfar Map40Palettes ; palettes
    db $01, $02, $3f, $00, $01, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $62 ; variant flag byte
    dfar Map40Screens0 ; variant 0 screens
    dfar Map40Attrs0 ; variant 0 attributes
    dfar Map40Screens0 ; variant 1 screens
    dfar Map40Attrs0 ; variant 1 attributes
    dfar Map40Screens2 ; variant 2 screens
    dfar Map40Attrs2 ; variant 2 attributes
    dfar Map40Screens2 ; variant 3 screens
    dfar Map40Attrs2 ; variant 3 attributes
    dfar Map40Screens2 ; variant 4 screens
    dfar Map40Attrs2 ; variant 4 attributes

; map record of map $41, 1 x 2 screens, 5 decoded variant(s) (E-0142)
MapRecord41::
    dfar Map41Tileset ; entry 0: tileset
    dfar Map41Palettes ; palettes
    db $01, $02, $3b, $00, $01, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $62 ; variant flag byte
    dfar Map41Screens0 ; variant 0 screens
    dfar Map41Attrs0 ; variant 0 attributes
    dfar Map41Screens0 ; variant 1 screens
    dfar Map41Attrs0 ; variant 1 attributes
    dfar Map41Screens0 ; variant 2 screens
    dfar Map41Attrs0 ; variant 2 attributes
    dfar Map41Screens0 ; variant 3 screens
    dfar Map41Attrs0 ; variant 3 attributes
    dfar Map41Screens0 ; variant 4 screens
    dfar Map41Attrs0 ; variant 4 attributes

; map record of map $42, 3 x 1 screens, 5 decoded variant(s) (E-0142)
MapRecord42::
    dfar Map37Tileset ; entry 0: tileset
    dfar Map37Palettes ; palettes
    db $03, $01, $4f, $00, $01, $08, $00, $02, $10, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $62 ; variant flag byte
    dfar Map42Screens0 ; variant 0 screens
    dfar Map42Attrs0 ; variant 0 attributes
    dfar Map42Screens0 ; variant 1 screens
    dfar Map42Attrs0 ; variant 1 attributes
    dfar Map42Screens0 ; variant 2 screens
    dfar Map42Attrs0 ; variant 2 attributes
    dfar Map42Screens0 ; variant 3 screens
    dfar Map42Attrs0 ; variant 3 attributes
    dfar Map42Screens0 ; variant 4 screens
    dfar Map42Attrs0 ; variant 4 attributes

; map record of map $43, 3 x 1 screens, 5 decoded variant(s) (E-0142)
MapRecord43::
    dfar Map43Tileset ; entry 0: tileset
    dfar Map43Palettes ; palettes
    db $03, $01, $4f, $00, $0d, $08, $00, $02, $02, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $62 ; variant flag byte
    dfar Map43Screens0 ; variant 0 screens
    dfar Map43Attrs0 ; variant 0 attributes
    dfar Map43Screens1 ; variant 1 screens
    dfar Map43Attrs1 ; variant 1 attributes
    dfar Map43Screens1 ; variant 2 screens
    dfar Map43Attrs1 ; variant 2 attributes
    dfar Map43Screens1 ; variant 3 screens
    dfar Map43Attrs1 ; variant 3 attributes
    dfar Map43Screens1 ; variant 4 screens
    dfar Map43Attrs1 ; variant 4 attributes

; map record of map $44, 1 x 1 screens, 5 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecord44::
    dfar Map44Tileset ; entry 0: tileset
    dfar Map44Palettes ; palettes
    db $01, $01, $4f, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $62 ; variant flag byte
    dfar Map44Screens0 ; variant 0 screens
    dfar Map44Attrs0 ; variant 0 attributes
    dfar Map44Screens0 ; variant 1 screens
    dfar Map44Attrs0 ; variant 1 attributes
    dfar Map44Screens0 ; variant 2 screens
    dfar Map44Attrs0 ; variant 2 attributes
    dfar Map44Screens0 ; variant 3 screens
    dfar Map44Attrs0 ; variant 3 attributes
    dfar Map44Screens0 ; variant 4 screens
    dfar Map44Attrs0 ; variant 4 attributes

; map record of map $48, 12 x 12 screens, 3 decoded variant(s) (E-0142)
MapRecord48::
    dfar Map48Tileset ; entry 0: tileset
    dfar Map48Palettes ; palettes
    db $0c, $0c, $2b, $00, $01, $09, $00, $01, $27, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $63 ; variant flag byte
    dfar Map48Screens0 ; variant 0 screens
    dfar Map48Attrs0 ; variant 0 attributes
    dfar Map48Screens0 ; variant 1 screens
    dfar Map48Attrs0 ; variant 1 attributes
    dfar Map48Screens2 ; variant 2 screens
    dfar Map48Attrs2 ; variant 2 attributes

; map record of map $49, 1 x 1 screens, 3 decoded variant(s) (E-0142)
MapRecord49::
    dfar Map49Tileset ; entry 0: tileset
    dfar Map49Palettes ; palettes
    db $01, $01, $2b, $00, $01, $00, $00, $01, $0a, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $63 ; variant flag byte
    dfar Map49Screens0 ; variant 0 screens
    dfar Map49Attrs0 ; variant 0 attributes
    dfar Map49Screens0 ; variant 1 screens
    dfar Map49Attrs0 ; variant 1 attributes
    dfar Map49Screens2 ; variant 2 screens
    dfar Map49Attrs2 ; variant 2 attributes

; map record of map $4A, 2 x 2 screens, 3 decoded variant(s) (E-0142)
MapRecord4A::
    dfar Map4ATileset ; entry 0: tileset
    dfar Map4APalettes ; palettes
    db $02, $02, $4c, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $63 ; variant flag byte
    dfar Map4AScreens0 ; variant 0 screens
    dfar Map4AAttrs0 ; variant 0 attributes
    dfar Map4AScreens0 ; variant 1 screens
    dfar Map4AAttrs0 ; variant 1 attributes
    dfar Map4AScreens0 ; variant 2 screens
    dfar Map4AAttrs0 ; variant 2 attributes

; map record of map $4B, 1 x 1 screens, 3 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecord4B::
    dfar Map4BTileset ; entry 0: tileset
    dfar Map4BPalettes ; palettes
    db $01, $01, $2b, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $63 ; variant flag byte
    dfar Map4BScreens0 ; variant 0 screens
    dfar Map4BAttrs0 ; variant 0 attributes
    dfar Map4BScreens0 ; variant 1 screens
    dfar Map4BAttrs0 ; variant 1 attributes
    dfar Map4BScreens0 ; variant 2 screens
    dfar Map4BAttrs0 ; variant 2 attributes

; map record of map $4C, 2 x 2 screens, 3 decoded variant(s) (E-0142)
MapRecord4C::
    dfar Map4CTileset ; entry 0: tileset
    dfar Map4CPalettes ; palettes
    db $02, $02, $46, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $63 ; variant flag byte
    dfar Map4CScreens0 ; variant 0 screens
    dfar Map4CAttrs0 ; variant 0 attributes
    dfar Map4CScreens0 ; variant 1 screens
    dfar Map4CAttrs0 ; variant 1 attributes
    dfar Map4CScreens0 ; variant 2 screens
    dfar Map4CAttrs0 ; variant 2 attributes

; map record of map $4D, 1 x 2 screens, 3 decoded variant(s) (E-0142)
MapRecord4D::
    dfar Map4DTileset ; entry 0: tileset
    dfar Map4DPalettes ; palettes
    db $01, $02, $17, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $63 ; variant flag byte
    dfar Map4DScreens0 ; variant 0 screens
    dfar Map4DAttrs0 ; variant 0 attributes
    dfar Map4DScreens1 ; variant 1 screens
    dfar Map4DAttrs1 ; variant 1 attributes
    dfar Map4DScreens1 ; variant 2 screens
    dfar Map4DAttrs1 ; variant 2 attributes

; map record of map $4E, 1 x 3 screens, 3 decoded variant(s) (E-0142)
MapRecord4E::
    dfar Map4ETileset ; entry 0: tileset
    dfar Map4EPalettes ; palettes
    db $01, $03, $2f, $00, $09, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $63 ; variant flag byte
    dfar Map4EScreens0 ; variant 0 screens
    dfar Map4EAttrs0 ; variant 0 attributes
    dfar Map4EScreens0 ; variant 1 screens
    dfar Map4EAttrs0 ; variant 1 attributes
    dfar Map4EScreens0 ; variant 2 screens
    dfar Map4EAttrs0 ; variant 2 attributes

; map record of map $4F, 2 x 2 screens, 3 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecord4F::
    dfar Map4FTileset ; entry 0: tileset
    dfar Map4FPalettes ; palettes
    db $02, $02, $57, $00, $01, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $63 ; variant flag byte
    dfar Map4FScreens0 ; variant 0 screens
    dfar Map4FAttrs0 ; variant 0 attributes
    dfar Map4FScreens0 ; variant 1 screens
    dfar Map4FAttrs0 ; variant 1 attributes
    dfar Map4FScreens2 ; variant 2 screens
    dfar Map4FAttrs2 ; variant 2 attributes

; map record of map $50, 1 x 1 screens, 3 decoded variant(s) (E-0142)
MapRecord50::
    dfar Map50Tileset ; entry 0: tileset
    dfar Map50Palettes ; palettes
    db $01, $01, $3f, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $63 ; variant flag byte
    dfar Map50Screens0 ; variant 0 screens
    dfar Map50Attrs0 ; variant 0 attributes
    dfar Map50Screens0 ; variant 1 screens
    dfar Map50Attrs0 ; variant 1 attributes
    dfar Map50Screens0 ; variant 2 screens
    dfar Map50Attrs0 ; variant 2 attributes

; map record of map $51, 1 x 1 screens, 3 decoded variant(s) (E-0142)
MapRecord51::
    dfar Map50Tileset ; entry 0: tileset
    dfar Map50Palettes ; palettes
    db $01, $01, $3f, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $63 ; variant flag byte
    dfar Map51Screens0 ; variant 0 screens
    dfar Map51Attrs0 ; variant 0 attributes
    dfar Map51Screens0 ; variant 1 screens
    dfar Map51Attrs0 ; variant 1 attributes
    dfar Map51Screens0 ; variant 2 screens
    dfar Map51Attrs0 ; variant 2 attributes

; map record of map $52, 3 x 2 screens, 3 decoded variant(s) (E-0142)
MapRecord52::
    dfar Map52Tileset ; entry 0: tileset
    dfar Map52Palettes ; palettes
    db $03, $02, $2f, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $63 ; variant flag byte
    dfar Map52Screens0 ; variant 0 screens
    dfar Map52Attrs0 ; variant 0 attributes
    dfar Map52Screens0 ; variant 1 screens
    dfar Map52Attrs0 ; variant 1 attributes
    dfar Map52Screens0 ; variant 2 screens
    dfar Map52Attrs0 ; variant 2 attributes

; map record of map $53, 4 x 4 screens, 3 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecord53::
    dfar Map53Tileset ; entry 0: tileset
    dfar Map53Palettes ; palettes
    db $04, $04, $33, $00, $00, $0a, $00, $10, $30, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $63 ; variant flag byte
    dfar Map53Screens0 ; variant 0 screens
    dfar Map53Attrs0 ; variant 0 attributes
    dfar Map53Screens0 ; variant 1 screens
    dfar Map53Attrs0 ; variant 1 attributes
    dfar Map53Screens0 ; variant 2 screens
    dfar Map53Attrs0 ; variant 2 attributes

; map record of map $54, 1 x 1 screens, 3 decoded variant(s) (E-0142)
MapRecord54::
    dfar Map53Tileset ; entry 0: tileset
    dfar Map53Palettes ; palettes
    db $01, $01, $33, $00, $00, $0b, $00, $10, $30, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $63 ; variant flag byte
    dfar Map54Screens0 ; variant 0 screens
    dfar Map54Attrs0 ; variant 0 attributes
    dfar Map54Screens0 ; variant 1 screens
    dfar Map54Attrs0 ; variant 1 attributes
    dfar Map54Screens0 ; variant 2 screens
    dfar Map54Attrs0 ; variant 2 attributes

; map record of map $55, 2 x 1 screens, 3 decoded variant(s) (E-0142)
MapRecord55::
    dfar Map53Tileset ; entry 0: tileset
    dfar Map53Palettes ; palettes
    db $02, $01, $33, $00, $00, $0b, $00, $10, $30, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $63 ; variant flag byte
    dfar Map55Screens0 ; variant 0 screens
    dfar Map55Attrs0 ; variant 0 attributes
    dfar Map55Screens0 ; variant 1 screens
    dfar Map55Attrs0 ; variant 1 attributes
    dfar Map55Screens0 ; variant 2 screens
    dfar Map55Attrs0 ; variant 2 attributes

; map record of map $56, 1 x 3 screens, 3 decoded variant(s) (E-0142)
MapRecord56::
    dfar Map53Tileset ; entry 0: tileset
    dfar Map53Palettes ; palettes
    db $01, $03, $33, $00, $00, $0b, $00, $10, $30, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $63 ; variant flag byte
    dfar Map56Screens0 ; variant 0 screens
    dfar Map56Attrs0 ; variant 0 attributes
    dfar Map56Screens0 ; variant 1 screens
    dfar Map56Attrs0 ; variant 1 attributes
    dfar Map56Screens0 ; variant 2 screens
    dfar Map56Attrs0 ; variant 2 attributes

; map record of map $57, 3 x 1 screens, 3 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecord57::
    dfar Map57Tileset ; entry 0: tileset
    dfar Map57Palettes ; palettes
    db $03, $01, $3f, $00, $00, $00, $00, $10, $2c, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $63 ; variant flag byte
    dfar Map57Screens0 ; variant 0 screens
    dfar Map57Attrs0 ; variant 0 attributes
    dfar Map57Screens0 ; variant 1 screens
    dfar Map57Attrs0 ; variant 1 attributes
    dfar Map57Screens0 ; variant 2 screens
    dfar Map57Attrs0 ; variant 2 attributes

; map record of map $58, 2 x 2 screens, 3 decoded variant(s) (E-0142)
MapRecord58::
    dfar Map58Tileset ; entry 0: tileset
    dfar Map58Palettes ; palettes
    db $02, $02, $57, $00, $01, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $63 ; variant flag byte
    dfar Map58Screens0 ; variant 0 screens
    dfar Map58Attrs0 ; variant 0 attributes
    dfar Map58Screens0 ; variant 1 screens
    dfar Map58Attrs0 ; variant 1 attributes
    dfar Map58Screens0 ; variant 2 screens
    dfar Map58Attrs0 ; variant 2 attributes

; map record of map $59, 2 x 1 screens, 3 decoded variant(s) (E-0142)
MapRecord59::
    dfar Map59Tileset ; entry 0: tileset
    dfar Map59Palettes ; palettes
    db $02, $01, $3f, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $63 ; variant flag byte
    dfar Map59Screens0 ; variant 0 screens
    dfar Map59Attrs0 ; variant 0 attributes
    dfar Map59Screens0 ; variant 1 screens
    dfar Map59Attrs0 ; variant 1 attributes
    dfar Map59Screens0 ; variant 2 screens
    dfar Map59Attrs0 ; variant 2 attributes

; map record of map $5A, 2 x 1 screens, 3 decoded variant(s) (E-0142)
MapRecord5A::
    dfar Map5ATileset ; entry 0: tileset
    dfar Map5APalettes ; palettes
    db $02, $01, $21, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $63 ; variant flag byte
    dfar Map5AScreens0 ; variant 0 screens
    dfar Map5AAttrs0 ; variant 0 attributes
    dfar Map5AScreens0 ; variant 1 screens
    dfar Map5AAttrs0 ; variant 1 attributes
    dfar Map5AScreens0 ; variant 2 screens
    dfar Map5AAttrs0 ; variant 2 attributes

; map record of map $5B, 2 x 2 screens, 3 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecord5B::
    dfar Map5BTileset ; entry 0: tileset
    dfar Map5BPalettes ; palettes
    db $02, $02, $43, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $63 ; variant flag byte
    dfar Map5BScreens0 ; variant 0 screens
    dfar Map5BAttrs0 ; variant 0 attributes
    dfar Map5BScreens0 ; variant 1 screens
    dfar Map5BAttrs0 ; variant 1 attributes
    dfar Map5BScreens0 ; variant 2 screens
    dfar Map5BAttrs0 ; variant 2 attributes

; map record of map $5C, 1 x 2 screens, 3 decoded variant(s) (E-0142)
MapRecord5C::
    dfar Map5CTileset ; entry 0: tileset
    dfar Map5CPalettes ; palettes
    db $01, $02, $33, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $63 ; variant flag byte
    dfar Map5CScreens0 ; variant 0 screens
    dfar Map5CAttrs0 ; variant 0 attributes
    dfar Map5CScreens0 ; variant 1 screens
    dfar Map5CAttrs0 ; variant 1 attributes
    dfar Map5CScreens0 ; variant 2 screens
    dfar Map5CAttrs0 ; variant 2 attributes

; map record of map $5D, 4 x 4 screens, 3 decoded variant(s) (E-0142)
MapRecord5D::
    dfar Map5DTileset ; entry 0: tileset
    dfar Map5DPalettes ; palettes
    db $04, $04, $11, $00, $00, $0c, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $63 ; variant flag byte
    dfar Map5DScreens0 ; variant 0 screens
    dfar Map5DAttrs0 ; variant 0 attributes
    dfar Map5DScreens0 ; variant 1 screens
    dfar Map5DAttrs0 ; variant 1 attributes
    dfar Map5DScreens0 ; variant 2 screens
    dfar Map5DAttrs0 ; variant 2 attributes

; map record of map $5E, 2 x 2 screens, 3 decoded variant(s) (E-0142)
MapRecord5E::
    dfar Map5ETileset ; entry 0: tileset
    dfar Map5EPalettes ; palettes
    db $02, $02, $4b, $00, $01, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $63 ; variant flag byte
    dfar Map5EScreens0 ; variant 0 screens
    dfar Map5EAttrs0 ; variant 0 attributes
    dfar Map5EScreens0 ; variant 1 screens
    dfar Map5EAttrs0 ; variant 1 attributes
    dfar Map5EScreens0 ; variant 2 screens
    dfar Map5EAttrs0 ; variant 2 attributes

; map record of map $5F, 1 x 1 screens, 3 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecord5F::
    dfar Map5FTileset ; entry 0: tileset
    dfar Map5FPalettes ; palettes
    db $01, $01, $1f, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $63 ; variant flag byte
    dfar Map5FScreens0 ; variant 0 screens
    dfar Map5FAttrs0 ; variant 0 attributes
    dfar Map5FScreens0 ; variant 1 screens
    dfar Map5FAttrs0 ; variant 1 attributes
    dfar Map5FScreens0 ; variant 2 screens
    dfar Map5FAttrs0 ; variant 2 attributes

; map record of map $60, 1 x 3 screens, 3 decoded variant(s) (E-0142)
MapRecord60::
    dfar Map60Tileset ; entry 0: tileset
    dfar Map60Palettes ; palettes
    db $01, $03, $31, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $63 ; variant flag byte
    dfar Map60Screens0 ; variant 0 screens
    dfar Map60Attrs0 ; variant 0 attributes
    dfar Map60Screens0 ; variant 1 screens
    dfar Map60Attrs0 ; variant 1 attributes
    dfar Map60Screens0 ; variant 2 screens
    dfar Map60Attrs0 ; variant 2 attributes

; map record of map $61, 1 x 2 screens, 3 decoded variant(s) (E-0142)
MapRecord61::
    dfar Map61Tileset ; entry 0: tileset
    dfar Map61Palettes ; palettes
    db $01, $02, $33, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $63 ; variant flag byte
    dfar Map61Screens0 ; variant 0 screens
    dfar Map61Attrs0 ; variant 0 attributes
    dfar Map61Screens0 ; variant 1 screens
    dfar Map61Attrs0 ; variant 1 attributes
    dfar Map61Screens0 ; variant 2 screens
    dfar Map61Attrs0 ; variant 2 attributes

; map record of map $62, 2 x 4 screens, 3 decoded variant(s) (E-0142)
MapRecord62::
    dfar Map62Tileset ; entry 0: tileset
    dfar Map62Palettes ; palettes
    db $02, $04, $32, $00, $00, $0d, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $63 ; variant flag byte
    dfar Map62Screens0 ; variant 0 screens
    dfar Map62Attrs0 ; variant 0 attributes
    dfar Map62Screens0 ; variant 1 screens
    dfar Map62Attrs0 ; variant 1 attributes
    dfar Map62Screens0 ; variant 2 screens
    dfar Map62Attrs0 ; variant 2 attributes

; map record of map $63, 2 x 2 screens, 3 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecord63::
    dfar Map63Tileset ; entry 0: tileset
    dfar Map63Palettes ; palettes
    db $02, $02, $33, $00, $00, $0e, $07, $02, $01, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $63 ; variant flag byte
    dfar Map63Screens0 ; variant 0 screens
    dfar Map63Attrs0 ; variant 0 attributes
    dfar Map63Screens0 ; variant 1 screens
    dfar Map63Attrs0 ; variant 1 attributes
    dfar Map63Screens0 ; variant 2 screens
    dfar Map63Attrs0 ; variant 2 attributes

; map record of map $64, 2 x 2 screens, 3 decoded variant(s) (E-0142)
MapRecord64::
    dfar Map63Tileset ; entry 0: tileset
    dfar Map63Palettes ; palettes
    db $02, $02, $33, $00, $00, $0e, $07, $02, $01, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $63 ; variant flag byte
    dfar Map64Screens0 ; variant 0 screens
    dfar Map64Attrs0 ; variant 0 attributes
    dfar Map64Screens0 ; variant 1 screens
    dfar Map64Attrs0 ; variant 1 attributes
    dfar Map64Screens0 ; variant 2 screens
    dfar Map64Attrs0 ; variant 2 attributes

; map record of map $65, 2 x 2 screens, 3 decoded variant(s) (E-0142)
MapRecord65::
    dfar Map63Tileset ; entry 0: tileset
    dfar Map63Palettes ; palettes
    db $02, $02, $33, $00, $00, $0e, $07, $02, $01, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $63 ; variant flag byte
    dfar Map65Screens0 ; variant 0 screens
    dfar Map65Attrs0 ; variant 0 attributes
    dfar Map65Screens0 ; variant 1 screens
    dfar Map65Attrs0 ; variant 1 attributes
    dfar Map65Screens0 ; variant 2 screens
    dfar Map65Attrs0 ; variant 2 attributes

; map record of map $66, 2 x 2 screens, 3 decoded variant(s) (E-0142)
MapRecord66::
    dfar Map63Tileset ; entry 0: tileset
    dfar Map63Palettes ; palettes
    db $02, $02, $33, $00, $00, $0f, $07, $02, $01, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $63 ; variant flag byte
    dfar Map66Screens0 ; variant 0 screens
    dfar Map66Attrs0 ; variant 0 attributes
    dfar Map66Screens0 ; variant 1 screens
    dfar Map66Attrs0 ; variant 1 attributes
    dfar Map66Screens0 ; variant 2 screens
    dfar Map66Attrs0 ; variant 2 attributes

; map record of map $67, 1 x 1 screens, 3 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecord67::
    dfar Map63Tileset ; entry 0: tileset
    dfar Map63Palettes ; palettes
    db $01, $01, $33, $00, $00, $0f, $00, $02, $01, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $63 ; variant flag byte
    dfar Map67Screens0 ; variant 0 screens
    dfar Map67Attrs0 ; variant 0 attributes
    dfar Map67Screens0 ; variant 1 screens
    dfar Map67Attrs0 ; variant 1 attributes
    dfar Map67Screens0 ; variant 2 screens
    dfar Map67Attrs0 ; variant 2 attributes

; map record that no MapTable entry points to, 1 x 1 screens, 3 decoded variant(s) (E-0142, E-0201)
MapRecordX59E4::
    dfar MapX59E4Tileset ; entry 0: tileset
    dfar MapX59E4Palettes ; palettes
    db $01, $01, $1f, $1c, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $63 ; variant flag byte
    dfar MapX59E4Screens0 ; variant 0 screens
    dfar MapX59E4Attrs0 ; variant 0 attributes
    dfar MapX59E4Screens0 ; variant 1 screens
    dfar MapX59E4Attrs0 ; variant 1 attributes
    dfar MapX59E4Screens0 ; variant 2 screens
    dfar MapX59E4Attrs0 ; variant 2 attributes

; map record of map $70, 12 x 12 screens, 5 decoded variant(s) (E-0142)
MapRecord70::
    dfar Map70Tileset ; entry 0: tileset
    dfar Map70Palettes ; palettes
    db $0c, $0c, $2d, $00, $00, $10, $00, $02, $29, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $64 ; variant flag byte
    dfar Map70Screens0 ; variant 0 screens
    dfar Map70Attrs0 ; variant 0 attributes
    dfar Map70Screens0 ; variant 1 screens
    dfar Map70Attrs0 ; variant 1 attributes
    dfar Map70Screens0 ; variant 2 screens
    dfar Map70Attrs0 ; variant 2 attributes
    dfar Map70Screens0 ; variant 3 screens
    dfar Map70Attrs0 ; variant 3 attributes
    dfar Map70Screens0 ; variant 4 screens
    dfar Map70Attrs0 ; variant 4 attributes

; map record of map $71, 3 x 1 screens, 5 decoded variant(s) (E-0142)
MapRecord71::
    dfar Map71Tileset ; entry 0: tileset
    dfar Map71Palettes ; palettes
    db $03, $01, $31, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $64 ; variant flag byte
    dfar Map71Screens0 ; variant 0 screens
    dfar Map71Attrs0 ; variant 0 attributes
    dfar Map71Screens0 ; variant 1 screens
    dfar Map71Attrs0 ; variant 1 attributes
    dfar Map71Screens0 ; variant 2 screens
    dfar Map71Attrs0 ; variant 2 attributes
    dfar Map71Screens0 ; variant 3 screens
    dfar Map71Attrs0 ; variant 3 attributes
    dfar Map71Screens0 ; variant 4 screens
    dfar Map71Attrs0 ; variant 4 attributes

; map record of map $72, 1 x 1 screens, 5 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecord72::
    dfar Map72Tileset ; entry 0: tileset
    dfar Map72Palettes ; palettes
    db $01, $01, $23, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $64 ; variant flag byte
    dfar Map72Screens0 ; variant 0 screens
    dfar Map72Attrs0 ; variant 0 attributes
    dfar Map72Screens0 ; variant 1 screens
    dfar Map72Attrs0 ; variant 1 attributes
    dfar Map72Screens0 ; variant 2 screens
    dfar Map72Attrs0 ; variant 2 attributes
    dfar Map72Screens0 ; variant 3 screens
    dfar Map72Attrs0 ; variant 3 attributes
    dfar Map72Screens0 ; variant 4 screens
    dfar Map72Attrs0 ; variant 4 attributes

; map record of map $73, 2 x 2 screens, 5 decoded variant(s) (E-0142)
MapRecord73::
    dfar Map73Tileset ; entry 0: tileset
    dfar Map73Palettes ; palettes
    db $02, $02, $4f, $00, $00, $11, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $64 ; variant flag byte
    dfar Map73Screens0 ; variant 0 screens
    dfar Map73Attrs0 ; variant 0 attributes
    dfar Map73Screens0 ; variant 1 screens
    dfar Map73Attrs0 ; variant 1 attributes
    dfar Map73Screens0 ; variant 2 screens
    dfar Map73Attrs0 ; variant 2 attributes
    dfar Map73Screens0 ; variant 3 screens
    dfar Map73Attrs0 ; variant 3 attributes
    dfar Map73Screens0 ; variant 4 screens
    dfar Map73Attrs0 ; variant 4 attributes

; map record of map $74, 2 x 2 screens, 5 decoded variant(s) (E-0142)
MapRecord74::
    dfar Map73Tileset ; entry 0: tileset
    dfar Map73Palettes ; palettes
    db $02, $02, $4f, $00, $00, $11, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $64 ; variant flag byte
    dfar Map74Screens0 ; variant 0 screens
    dfar Map74Attrs0 ; variant 0 attributes
    dfar Map74Screens0 ; variant 1 screens
    dfar Map74Attrs0 ; variant 1 attributes
    dfar Map74Screens0 ; variant 2 screens
    dfar Map74Attrs0 ; variant 2 attributes
    dfar Map74Screens0 ; variant 3 screens
    dfar Map74Attrs0 ; variant 3 attributes
    dfar Map74Screens0 ; variant 4 screens
    dfar Map74Attrs0 ; variant 4 attributes

; map record of map $75, 2 x 2 screens, 5 decoded variant(s) (E-0142)
MapRecord75::
    dfar Map73Tileset ; entry 0: tileset
    dfar Map73Palettes ; palettes
    db $02, $02, $4f, $00, $00, $11, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $64 ; variant flag byte
    dfar Map75Screens0 ; variant 0 screens
    dfar Map75Attrs0 ; variant 0 attributes
    dfar Map75Screens0 ; variant 1 screens
    dfar Map75Attrs0 ; variant 1 attributes
    dfar Map75Screens0 ; variant 2 screens
    dfar Map75Attrs0 ; variant 2 attributes
    dfar Map75Screens0 ; variant 3 screens
    dfar Map75Attrs0 ; variant 3 attributes
    dfar Map75Screens0 ; variant 4 screens
    dfar Map75Attrs0 ; variant 4 attributes

; map record of map $76, 2 x 2 screens, 5 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecord76::
    dfar Map73Tileset ; entry 0: tileset
    dfar Map73Palettes ; palettes
    db $02, $02, $4f, $00, $00, $11, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $64 ; variant flag byte
    dfar Map76Screens0 ; variant 0 screens
    dfar Map76Attrs0 ; variant 0 attributes
    dfar Map76Screens0 ; variant 1 screens
    dfar Map76Attrs0 ; variant 1 attributes
    dfar Map76Screens0 ; variant 2 screens
    dfar Map76Attrs0 ; variant 2 attributes
    dfar Map76Screens0 ; variant 3 screens
    dfar Map76Attrs0 ; variant 3 attributes
    dfar Map76Screens0 ; variant 4 screens
    dfar Map76Attrs0 ; variant 4 attributes

; map record of map $77, 3 x 1 screens, 5 decoded variant(s) (E-0142)
MapRecord77::
    dfar Map77Tileset ; entry 0: tileset
    dfar Map77Palettes ; palettes
    db $03, $01, $3f, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $64 ; variant flag byte
    dfar Map77Screens0 ; variant 0 screens
    dfar Map77Attrs0 ; variant 0 attributes
    dfar Map77Screens0 ; variant 1 screens
    dfar Map77Attrs0 ; variant 1 attributes
    dfar Map77Screens0 ; variant 2 screens
    dfar Map77Attrs0 ; variant 2 attributes
    dfar Map77Screens0 ; variant 3 screens
    dfar Map77Attrs0 ; variant 3 attributes
    dfar Map77Screens0 ; variant 4 screens
    dfar Map77Attrs0 ; variant 4 attributes

; map record of map $78, 2 x 2 screens, 5 decoded variant(s) (E-0142)
MapRecord78::
    dfar Map78Tileset ; entry 0: tileset
    dfar Map78Palettes ; palettes
    db $02, $02, $3d, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $64 ; variant flag byte
    dfar Map78Screens0 ; variant 0 screens
    dfar Map78Attrs0 ; variant 0 attributes
    dfar Map78Screens0 ; variant 1 screens
    dfar Map78Attrs0 ; variant 1 attributes
    dfar Map78Screens0 ; variant 2 screens
    dfar Map78Attrs0 ; variant 2 attributes
    dfar Map78Screens0 ; variant 3 screens
    dfar Map78Attrs0 ; variant 3 attributes
    dfar Map78Screens0 ; variant 4 screens
    dfar Map78Attrs0 ; variant 4 attributes

; map record of map $79, 1 x 2 screens, 5 decoded variant(s) (E-0142)
MapRecord79::
    dfar Map79Tileset ; entry 0: tileset
    dfar Map79Palettes ; palettes
    db $01, $02, $45, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $64 ; variant flag byte
    dfar Map79Screens0 ; variant 0 screens
    dfar Map79Attrs0 ; variant 0 attributes
    dfar Map79Screens0 ; variant 1 screens
    dfar Map79Attrs0 ; variant 1 attributes
    dfar Map79Screens0 ; variant 2 screens
    dfar Map79Attrs0 ; variant 2 attributes
    dfar Map79Screens0 ; variant 3 screens
    dfar Map79Attrs0 ; variant 3 attributes
    dfar Map79Screens0 ; variant 4 screens
    dfar Map79Attrs0 ; variant 4 attributes

; map record of map $7A, 1 x 2 screens, 5 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecord7A::
    dfar Map7ATileset ; entry 0: tileset
    dfar Map7APalettes ; palettes
    db $01, $02, $4b, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $64 ; variant flag byte
    dfar Map7AScreens0 ; variant 0 screens
    dfar Map7AAttrs0 ; variant 0 attributes
    dfar Map7AScreens0 ; variant 1 screens
    dfar Map7AAttrs0 ; variant 1 attributes
    dfar Map7AScreens0 ; variant 2 screens
    dfar Map7AAttrs0 ; variant 2 attributes
    dfar Map7AScreens0 ; variant 3 screens
    dfar Map7AAttrs0 ; variant 3 attributes
    dfar Map7AScreens0 ; variant 4 screens
    dfar Map7AAttrs0 ; variant 4 attributes

; map record of map $7B, 1 x 3 screens, 5 decoded variant(s) (E-0142)
MapRecord7B::
    dfar Map7BTileset ; entry 0: tileset
    dfar Map7BPalettes ; palettes
    db $01, $03, $1f, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $64 ; variant flag byte
    dfar Map7BScreens0 ; variant 0 screens
    dfar Map7BAttrs0 ; variant 0 attributes
    dfar Map7BScreens0 ; variant 1 screens
    dfar Map7BAttrs0 ; variant 1 attributes
    dfar Map7BScreens0 ; variant 2 screens
    dfar Map7BAttrs0 ; variant 2 attributes
    dfar Map7BScreens0 ; variant 3 screens
    dfar Map7BAttrs0 ; variant 3 attributes
    dfar Map7BScreens0 ; variant 4 screens
    dfar Map7BAttrs0 ; variant 4 attributes

; map record of map $7C, 2 x 2 screens, 5 decoded variant(s) (E-0142)
MapRecord7C::
    dfar Map7CTileset ; entry 0: tileset
    dfar Map7CPalettes ; palettes
    db $02, $02, $45, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $64 ; variant flag byte
    dfar Map7CScreens0 ; variant 0 screens
    dfar Map7CAttrs0 ; variant 0 attributes
    dfar Map7CScreens0 ; variant 1 screens
    dfar Map7CAttrs0 ; variant 1 attributes
    dfar Map7CScreens0 ; variant 2 screens
    dfar Map7CAttrs0 ; variant 2 attributes
    dfar Map7CScreens0 ; variant 3 screens
    dfar Map7CAttrs0 ; variant 3 attributes
    dfar Map7CScreens0 ; variant 4 screens
    dfar Map7CAttrs0 ; variant 4 attributes

; map record of map $7D, 1 x 1 screens, 5 decoded variant(s) (E-0142)
MapRecord7D::
    dfar Map7DTileset ; entry 0: tileset
    dfar Map7DPalettes ; palettes
    db $01, $01, $3b, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $64 ; variant flag byte
    dfar Map7DScreens0 ; variant 0 screens
    dfar Map7DAttrs0 ; variant 0 attributes
    dfar Map7DScreens0 ; variant 1 screens
    dfar Map7DAttrs0 ; variant 1 attributes
    dfar Map7DScreens0 ; variant 2 screens
    dfar Map7DAttrs0 ; variant 2 attributes
    dfar Map7DScreens0 ; variant 3 screens
    dfar Map7DAttrs0 ; variant 3 attributes
    dfar Map7DScreens0 ; variant 4 screens
    dfar Map7DAttrs0 ; variant 4 attributes

; map record of map $7E, 1 x 1 screens, 5 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecord7E::
    dfar Map7DTileset ; entry 0: tileset
    dfar Map7DPalettes ; palettes
    db $01, $01, $3b, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $64 ; variant flag byte
    dfar Map7EScreens0 ; variant 0 screens
    dfar Map7EAttrs0 ; variant 0 attributes
    dfar Map7EScreens0 ; variant 1 screens
    dfar Map7EAttrs0 ; variant 1 attributes
    dfar Map7EScreens0 ; variant 2 screens
    dfar Map7EAttrs0 ; variant 2 attributes
    dfar Map7EScreens0 ; variant 3 screens
    dfar Map7EAttrs0 ; variant 3 attributes
    dfar Map7EScreens0 ; variant 4 screens
    dfar Map7EAttrs0 ; variant 4 attributes

; map record of map $7F, 1 x 2 screens, 5 decoded variant(s) (E-0142)
MapRecord7F::
    dfar Map7FTileset ; entry 0: tileset
    dfar Map7FPalettes ; palettes
    db $01, $02, $2f, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $64 ; variant flag byte
    dfar Map7FScreens0 ; variant 0 screens
    dfar Map7FAttrs0 ; variant 0 attributes
    dfar Map7FScreens0 ; variant 1 screens
    dfar Map7FAttrs0 ; variant 1 attributes
    dfar Map7FScreens0 ; variant 2 screens
    dfar Map7FAttrs0 ; variant 2 attributes
    dfar Map7FScreens0 ; variant 3 screens
    dfar Map7FAttrs0 ; variant 3 attributes
    dfar Map7FScreens0 ; variant 4 screens
    dfar Map7FAttrs0 ; variant 4 attributes

; map record of map $80, 3 x 1 screens, 5 decoded variant(s) (E-0142)
MapRecord80::
    dfar Map80Tileset ; entry 0: tileset
    dfar Map80Palettes ; palettes
    db $03, $01, $3f, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $64 ; variant flag byte
    dfar Map80Screens0 ; variant 0 screens
    dfar Map80Attrs0 ; variant 0 attributes
    dfar Map80Screens0 ; variant 1 screens
    dfar Map80Attrs0 ; variant 1 attributes
    dfar Map80Screens0 ; variant 2 screens
    dfar Map80Attrs0 ; variant 2 attributes
    dfar Map80Screens0 ; variant 3 screens
    dfar Map80Attrs0 ; variant 3 attributes
    dfar Map80Screens0 ; variant 4 screens
    dfar Map80Attrs0 ; variant 4 attributes

; map record of map $81, 1 x 1 screens, 5 decoded variant(s) (E-0142)
MapRecord81::
    dfar Map81Tileset ; entry 0: tileset
    dfar Map81Palettes ; palettes
    db $01, $01, $2f, $00, $00, $12, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $64 ; variant flag byte
    dfar Map81Screens0 ; variant 0 screens
    dfar Map81Attrs0 ; variant 0 attributes
    dfar Map81Screens0 ; variant 1 screens
    dfar Map81Attrs0 ; variant 1 attributes
    dfar Map81Screens0 ; variant 2 screens
    dfar Map81Attrs0 ; variant 2 attributes
    dfar Map81Screens0 ; variant 3 screens
    dfar Map81Attrs0 ; variant 3 attributes
    dfar Map81Screens0 ; variant 4 screens
    dfar Map81Attrs0 ; variant 4 attributes

; map record of map $82, 3 x 3 screens, 5 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecord82::
    dfar Map81Tileset ; entry 0: tileset
    dfar Map81Palettes ; palettes
    db $03, $03, $2f, $00, $00, $13, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $64 ; variant flag byte
    dfar Map82Screens0 ; variant 0 screens
    dfar Map82Attrs0 ; variant 0 attributes
    dfar Map82Screens0 ; variant 1 screens
    dfar Map82Attrs0 ; variant 1 attributes
    dfar Map82Screens0 ; variant 2 screens
    dfar Map82Attrs0 ; variant 2 attributes
    dfar Map82Screens0 ; variant 3 screens
    dfar Map82Attrs0 ; variant 3 attributes
    dfar Map82Screens0 ; variant 4 screens
    dfar Map82Attrs0 ; variant 4 attributes

; map record of map $83, 3 x 3 screens, 5 decoded variant(s) (E-0142)
MapRecord83::
    dfar Map81Tileset ; entry 0: tileset
    dfar Map81Palettes ; palettes
    db $03, $03, $2f, $00, $00, $13, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $64 ; variant flag byte
    dfar Map83Screens0 ; variant 0 screens
    dfar Map83Attrs0 ; variant 0 attributes
    dfar Map83Screens0 ; variant 1 screens
    dfar Map83Attrs0 ; variant 1 attributes
    dfar Map83Screens0 ; variant 2 screens
    dfar Map83Attrs0 ; variant 2 attributes
    dfar Map83Screens0 ; variant 3 screens
    dfar Map83Attrs0 ; variant 3 attributes
    dfar Map83Screens0 ; variant 4 screens
    dfar Map83Attrs0 ; variant 4 attributes

; map record of map $84, 1 x 1 screens, 5 decoded variant(s) (E-0142)
MapRecord84::
    dfar Map81Tileset ; entry 0: tileset
    dfar Map81Palettes ; palettes
    db $01, $01, $2f, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $64 ; variant flag byte
    dfar Map84Screens0 ; variant 0 screens
    dfar Map84Attrs0 ; variant 0 attributes
    dfar Map84Screens0 ; variant 1 screens
    dfar Map84Attrs0 ; variant 1 attributes
    dfar Map84Screens0 ; variant 2 screens
    dfar Map84Attrs0 ; variant 2 attributes
    dfar Map84Screens0 ; variant 3 screens
    dfar Map84Attrs0 ; variant 3 attributes
    dfar Map84Screens0 ; variant 4 screens
    dfar Map84Attrs0 ; variant 4 attributes

; map record of map $85, 2 x 2 screens, 5 decoded variant(s) (E-0142)
MapRecord85::
    dfar Map85Tileset ; entry 0: tileset
    dfar Map85Palettes ; palettes
    db $02, $02, $3f, $00, $00, $14, $00, $02, $01, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $64 ; variant flag byte
    dfar Map85Screens0 ; variant 0 screens
    dfar Map85Attrs0 ; variant 0 attributes
    dfar Map85Screens0 ; variant 1 screens
    dfar Map85Attrs0 ; variant 1 attributes
    dfar Map85Screens0 ; variant 2 screens
    dfar Map85Attrs0 ; variant 2 attributes
    dfar Map85Screens0 ; variant 3 screens
    dfar Map85Attrs0 ; variant 3 attributes
    dfar Map85Screens0 ; variant 4 screens
    dfar Map85Attrs0 ; variant 4 attributes

; map record of map $86, 2 x 2 screens, 5 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecord86::
    dfar Map85Tileset ; entry 0: tileset
    dfar Map85Palettes ; palettes
    db $02, $02, $2f, $00, $00, $14, $00, $02, $01, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $64 ; variant flag byte
    dfar Map86Screens0 ; variant 0 screens
    dfar Map86Attrs0 ; variant 0 attributes
    dfar Map86Screens0 ; variant 1 screens
    dfar Map86Attrs0 ; variant 1 attributes
    dfar Map86Screens0 ; variant 2 screens
    dfar Map86Attrs0 ; variant 2 attributes
    dfar Map86Screens0 ; variant 3 screens
    dfar Map86Attrs0 ; variant 3 attributes
    dfar Map86Screens0 ; variant 4 screens
    dfar Map86Attrs0 ; variant 4 attributes

; map record of map $87, 2 x 2 screens, 5 decoded variant(s) (E-0142)
MapRecord87::
    dfar Map85Tileset ; entry 0: tileset
    dfar Map85Palettes ; palettes
    db $02, $02, $2f, $00, $00, $14, $00, $02, $01, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $64 ; variant flag byte
    dfar Map87Screens0 ; variant 0 screens
    dfar Map87Attrs0 ; variant 0 attributes
    dfar Map87Screens0 ; variant 1 screens
    dfar Map87Attrs0 ; variant 1 attributes
    dfar Map87Screens0 ; variant 2 screens
    dfar Map87Attrs0 ; variant 2 attributes
    dfar Map87Screens0 ; variant 3 screens
    dfar Map87Attrs0 ; variant 3 attributes
    dfar Map87Screens0 ; variant 4 screens
    dfar Map87Attrs0 ; variant 4 attributes

; map record of map $88, 2 x 2 screens, 5 decoded variant(s) (E-0142)
MapRecord88::
    dfar Map85Tileset ; entry 0: tileset
    dfar Map85Palettes ; palettes
    db $02, $02, $2f, $00, $00, $14, $00, $02, $01, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $64 ; variant flag byte
    dfar Map88Screens0 ; variant 0 screens
    dfar Map88Attrs0 ; variant 0 attributes
    dfar Map88Screens0 ; variant 1 screens
    dfar Map88Attrs0 ; variant 1 attributes
    dfar Map88Screens0 ; variant 2 screens
    dfar Map88Attrs0 ; variant 2 attributes
    dfar Map88Screens0 ; variant 3 screens
    dfar Map88Attrs0 ; variant 3 attributes
    dfar Map88Screens0 ; variant 4 screens
    dfar Map88Attrs0 ; variant 4 attributes

; map record of map $89, 2 x 2 screens, 5 decoded variant(s) (E-0142)
MapRecord89::
    dfar Map89Tileset ; entry 0: tileset
    dfar Map89Palettes ; palettes
    db $02, $02, $48, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $64 ; variant flag byte
    dfar Map89Screens0 ; variant 0 screens
    dfar Map89Attrs0 ; variant 0 attributes
    dfar Map89Screens0 ; variant 1 screens
    dfar Map89Attrs0 ; variant 1 attributes
    dfar Map89Screens0 ; variant 2 screens
    dfar Map89Attrs0 ; variant 2 attributes
    dfar Map89Screens0 ; variant 3 screens
    dfar Map89Attrs0 ; variant 3 attributes
    dfar Map89Screens0 ; variant 4 screens
    dfar Map89Attrs0 ; variant 4 attributes

; map record of map $8A, 1 x 1 screens, 5 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecord8A::
    dfar Map8ATileset ; entry 0: tileset
    dfar Map8APalettes ; palettes
    db $01, $01, $33, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $64 ; variant flag byte
    dfar Map8AScreens0 ; variant 0 screens
    dfar Map8AAttrs0 ; variant 0 attributes
    dfar Map8AScreens0 ; variant 1 screens
    dfar Map8AAttrs0 ; variant 1 attributes
    dfar Map8AScreens0 ; variant 2 screens
    dfar Map8AAttrs0 ; variant 2 attributes
    dfar Map8AScreens0 ; variant 3 screens
    dfar Map8AAttrs0 ; variant 3 attributes
    dfar Map8AScreens0 ; variant 4 screens
    dfar Map8AAttrs0 ; variant 4 attributes

; map record of map $8B, 3 x 4 screens, 5 decoded variant(s) (E-0142)
MapRecord8B::
    dfar Map8BTileset ; entry 0: tileset
    dfar Map8BPalettes ; palettes
    db $03, $04, $2d, $00, $00, $15, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $64 ; variant flag byte
    dfar Map8BScreens0 ; variant 0 screens
    dfar Map8BAttrs0 ; variant 0 attributes
    dfar Map8BScreens0 ; variant 1 screens
    dfar Map8BAttrs0 ; variant 1 attributes
    dfar Map8BScreens0 ; variant 2 screens
    dfar Map8BAttrs0 ; variant 2 attributes
    dfar Map8BScreens0 ; variant 3 screens
    dfar Map8BAttrs0 ; variant 3 attributes
    dfar Map8BScreens0 ; variant 4 screens
    dfar Map8BAttrs0 ; variant 4 attributes

; map record of map $8C, 3 x 3 screens, 5 decoded variant(s) (E-0142)
MapRecord8C::
    dfar Map8CTileset ; entry 0: tileset
    dfar Map8CPalettes ; palettes
    db $03, $03, $4f, $00, $00, $15, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $64 ; variant flag byte
    dfar Map8CScreens0 ; variant 0 screens
    dfar Map8CAttrs0 ; variant 0 attributes
    dfar Map8CScreens0 ; variant 1 screens
    dfar Map8CAttrs0 ; variant 1 attributes
    dfar Map8CScreens0 ; variant 2 screens
    dfar Map8CAttrs0 ; variant 2 attributes
    dfar Map8CScreens0 ; variant 3 screens
    dfar Map8CAttrs0 ; variant 3 attributes
    dfar Map8CScreens0 ; variant 4 screens
    dfar Map8CAttrs0 ; variant 4 attributes

; map record of map $8D, 1 x 1 screens, 5 decoded variant(s) (E-0142)
MapRecord8D::
    dfar Map8DTileset ; entry 0: tileset
    dfar Map8DPalettes ; palettes
    db $01, $01, $2c, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $64 ; variant flag byte
    dfar Map8DScreens0 ; variant 0 screens
    dfar Map8DAttrs0 ; variant 0 attributes
    dfar Map8DScreens1 ; variant 1 screens
    dfar Map8DAttrs1 ; variant 1 attributes
    dfar Map8DScreens1 ; variant 2 screens
    dfar Map8DAttrs1 ; variant 2 attributes
    dfar Map8DScreens1 ; variant 3 screens
    dfar Map8DAttrs1 ; variant 3 attributes
    dfar Map8DScreens1 ; variant 4 screens
    dfar Map8DAttrs1 ; variant 4 attributes

; map record of map $8E, 3 x 3 screens, 5 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecord8E::
    dfar Map8ETileset ; entry 0: tileset
    dfar Map8EPalettes ; palettes
    db $03, $03, $53, $00, $00, $15, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $64 ; variant flag byte
    dfar Map8EScreens0 ; variant 0 screens
    dfar Map8EAttrs0 ; variant 0 attributes
    dfar Map8EScreens0 ; variant 1 screens
    dfar Map8EAttrs0 ; variant 1 attributes
    dfar Map8EScreens0 ; variant 2 screens
    dfar Map8EAttrs0 ; variant 2 attributes
    dfar Map8EScreens3 ; variant 3 screens
    dfar Map8EAttrs3 ; variant 3 attributes
    dfar Map8EScreens3 ; variant 4 screens
    dfar Map8EAttrs3 ; variant 4 attributes

; map record of map $8F, 1 x 1 screens, 5 decoded variant(s) (E-0142)
MapRecord8F::
    dfar Map8FTileset ; entry 0: tileset
    dfar Map8FPalettes ; palettes
    db $01, $01, $2f, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $64 ; variant flag byte
    dfar Map8FScreens0 ; variant 0 screens
    dfar Map8FAttrs0 ; variant 0 attributes
    dfar Map8FScreens0 ; variant 1 screens
    dfar Map8FAttrs0 ; variant 1 attributes
    dfar Map8FScreens2 ; variant 2 screens
    dfar Map8FAttrs2 ; variant 2 attributes
    dfar Map8FScreens2 ; variant 3 screens
    dfar Map8FAttrs2 ; variant 3 attributes
    dfar Map8FScreens2 ; variant 4 screens
    dfar Map8FAttrs2 ; variant 4 attributes

; map record of map $90, 3 x 2 screens, 5 decoded variant(s) (E-0142)
MapRecord90::
    dfar Map8CTileset ; entry 0: tileset
    dfar Map8CPalettes ; palettes
    db $03, $02, $4f, $00, $00, $15, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $64 ; variant flag byte
    dfar Map90Screens0 ; variant 0 screens
    dfar Map90Attrs0 ; variant 0 attributes
    dfar Map90Screens0 ; variant 1 screens
    dfar Map90Attrs0 ; variant 1 attributes
    dfar Map90Screens0 ; variant 2 screens
    dfar Map90Attrs0 ; variant 2 attributes
    dfar Map90Screens0 ; variant 3 screens
    dfar Map90Attrs0 ; variant 3 attributes
    dfar Map90Screens0 ; variant 4 screens
    dfar Map90Attrs0 ; variant 4 attributes

; map record of map $91, 1 x 1 screens, 5 decoded variant(s) (E-0142)
MapRecord91::
    dfar Map91Tileset ; entry 0: tileset
    dfar Map91Palettes ; palettes
    db $01, $01, $3b, $00, $03, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $64 ; variant flag byte
    dfar Map91Screens0 ; variant 0 screens
    dfar Map91Attrs0 ; variant 0 attributes
    dfar Map91Screens0 ; variant 1 screens
    dfar Map91Attrs0 ; variant 1 attributes
    dfar Map91Screens0 ; variant 2 screens
    dfar Map91Attrs0 ; variant 2 attributes
    dfar Map91Screens0 ; variant 3 screens
    dfar Map91Attrs0 ; variant 3 attributes
    dfar Map91Screens0 ; variant 4 screens
    dfar Map91Attrs0 ; variant 4 attributes

; map record of map $92, 1 x 1 screens, 5 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecord92::
    dfar Map92Tileset ; entry 0: tileset
    dfar Map92Palettes ; palettes
    db $01, $01, $17, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $64 ; variant flag byte
    dfar Map92Screens0 ; variant 0 screens
    dfar Map92Attrs0 ; variant 0 attributes
    dfar Map92Screens0 ; variant 1 screens
    dfar Map92Attrs0 ; variant 1 attributes
    dfar Map92Screens0 ; variant 2 screens
    dfar Map92Attrs0 ; variant 2 attributes
    dfar Map92Screens0 ; variant 3 screens
    dfar Map92Attrs0 ; variant 3 attributes
    dfar Map92Screens0 ; variant 4 screens
    dfar Map92Attrs0 ; variant 4 attributes

; map record of map $93, 1 x 1 screens, 5 decoded variant(s) (E-0142)
MapRecord93::
    dfar Map93Tileset ; entry 0: tileset
    dfar Map93Palettes ; palettes
    db $01, $01, $24, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $64 ; variant flag byte
    dfar Map93Screens0 ; variant 0 screens
    dfar Map93Attrs0 ; variant 0 attributes
    dfar Map93Screens0 ; variant 1 screens
    dfar Map93Attrs0 ; variant 1 attributes
    dfar Map93Screens0 ; variant 2 screens
    dfar Map93Attrs0 ; variant 2 attributes
    dfar Map93Screens0 ; variant 3 screens
    dfar Map93Attrs0 ; variant 3 attributes
    dfar Map93Screens0 ; variant 4 screens
    dfar Map93Attrs0 ; variant 4 attributes

; map record of map $94, 3 x 3 screens, 5 decoded variant(s) (E-0142)
MapRecord94::
    dfar Map94Tileset ; entry 0: tileset
    dfar Map94Palettes ; palettes
    db $03, $03, $3f, $00, $04, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $64 ; variant flag byte
    dfar Map94Screens0 ; variant 0 screens
    dfar Map94Attrs0 ; variant 0 attributes
    dfar Map94Screens0 ; variant 1 screens
    dfar Map94Attrs0 ; variant 1 attributes
    dfar Map94Screens0 ; variant 2 screens
    dfar Map94Attrs0 ; variant 2 attributes
    dfar Map94Screens0 ; variant 3 screens
    dfar Map94Attrs0 ; variant 3 attributes
    dfar Map94Screens0 ; variant 4 screens
    dfar Map94Attrs0 ; variant 4 attributes

; map record of map $95, 2 x 3 screens, 5 decoded variant(s) (E-0142)
MapRecord95::
    dfar Map94Tileset ; entry 0: tileset
    dfar Map94Palettes ; palettes
    db $02, $03, $3f, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $64 ; variant flag byte
    dfar Map95Screens0 ; variant 0 screens
    dfar Map95Attrs0 ; variant 0 attributes
    dfar Map95Screens0 ; variant 1 screens
    dfar Map95Attrs0 ; variant 1 attributes
    dfar Map95Screens0 ; variant 2 screens
    dfar Map95Attrs0 ; variant 2 attributes
    dfar Map95Screens0 ; variant 3 screens
    dfar Map95Attrs0 ; variant 3 attributes
    dfar Map95Screens0 ; variant 4 screens
    dfar Map95Attrs0 ; variant 4 attributes

; map record of map $96, 2 x 2 screens, 5 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecord96::
    dfar Map94Tileset ; entry 0: tileset
    dfar Map94Palettes ; palettes
    db $02, $02, $3f, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $64 ; variant flag byte
    dfar Map96Screens0 ; variant 0 screens
    dfar Map96Attrs0 ; variant 0 attributes
    dfar Map96Screens0 ; variant 1 screens
    dfar Map96Attrs0 ; variant 1 attributes
    dfar Map96Screens0 ; variant 2 screens
    dfar Map96Attrs0 ; variant 2 attributes
    dfar Map96Screens0 ; variant 3 screens
    dfar Map96Attrs0 ; variant 3 attributes
    dfar Map96Screens0 ; variant 4 screens
    dfar Map96Attrs0 ; variant 4 attributes

; map record of map $97, 1 x 1 screens, 5 decoded variant(s) (E-0142)
MapRecord97::
    dfar Map97Tileset ; entry 0: tileset
    dfar Map97Palettes ; palettes
    db $01, $01, $3f, $00, $00, $00, $00, $02, $1f, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $64 ; variant flag byte
    dfar Map97Screens0 ; variant 0 screens
    dfar Map97Attrs0 ; variant 0 attributes
    dfar Map97Screens0 ; variant 1 screens
    dfar Map97Attrs0 ; variant 1 attributes
    dfar Map97Screens0 ; variant 2 screens
    dfar Map97Attrs0 ; variant 2 attributes
    dfar Map97Screens0 ; variant 3 screens
    dfar Map97Attrs0 ; variant 3 attributes
    dfar Map97Screens0 ; variant 4 screens
    dfar Map97Attrs0 ; variant 4 attributes

; map record of map $98, 1 x 1 screens, 5 decoded variant(s) (E-0142)
MapRecord98::
    dfar Map97Tileset ; entry 0: tileset
    dfar Map97Palettes ; palettes
    db $01, $01, $3f, $00, $00, $00, $00, $02, $1f, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $64 ; variant flag byte
    dfar Map98Screens0 ; variant 0 screens
    dfar Map98Attrs0 ; variant 0 attributes
    dfar Map98Screens0 ; variant 1 screens
    dfar Map98Attrs0 ; variant 1 attributes
    dfar Map98Screens0 ; variant 2 screens
    dfar Map98Attrs0 ; variant 2 attributes
    dfar Map98Screens0 ; variant 3 screens
    dfar Map98Attrs0 ; variant 3 attributes
    dfar Map98Screens0 ; variant 4 screens
    dfar Map98Attrs0 ; variant 4 attributes

; map record of map $99, 1 x 1 screens, 5 decoded variant(s) (E-0142)
MapRecord99::
    dfar Map97Tileset ; entry 0: tileset
    dfar Map97Palettes ; palettes
    db $01, $01, $3f, $00, $00, $00, $00, $02, $1f, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $64 ; variant flag byte
    dfar Map99Screens0 ; variant 0 screens
    dfar Map99Attrs0 ; variant 0 attributes
    dfar Map99Screens0 ; variant 1 screens
    dfar Map99Attrs0 ; variant 1 attributes
    dfar Map99Screens0 ; variant 2 screens
    dfar Map99Attrs0 ; variant 2 attributes
    dfar Map99Screens0 ; variant 3 screens
    dfar Map99Attrs0 ; variant 3 attributes
    dfar Map99Screens0 ; variant 4 screens
    dfar Map99Attrs0 ; variant 4 attributes

; map record of map $9A, 1 x 1 screens, 5 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecord9A::
    dfar Map97Tileset ; entry 0: tileset
    dfar Map97Palettes ; palettes
    db $01, $01, $3f, $00, $00, $00, $00, $02, $1f, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $64 ; variant flag byte
    dfar Map9AScreens0 ; variant 0 screens
    dfar Map9AAttrs0 ; variant 0 attributes
    dfar Map9AScreens0 ; variant 1 screens
    dfar Map9AAttrs0 ; variant 1 attributes
    dfar Map9AScreens0 ; variant 2 screens
    dfar Map9AAttrs0 ; variant 2 attributes
    dfar Map9AScreens0 ; variant 3 screens
    dfar Map9AAttrs0 ; variant 3 attributes
    dfar Map9AScreens0 ; variant 4 screens
    dfar Map9AAttrs0 ; variant 4 attributes

; map record of map $9B, 1 x 3 screens, 5 decoded variant(s) (E-0142)
MapRecord9B::
    dfar Map9BTileset ; entry 0: tileset
    dfar Map9BPalettes ; palettes
    db $01, $03, $4f, $00, $00, $00, $00, $02, $0f, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $64 ; variant flag byte
    dfar Map9BScreens0 ; variant 0 screens
    dfar Map9BAttrs0 ; variant 0 attributes
    dfar Map9BScreens0 ; variant 1 screens
    dfar Map9BAttrs0 ; variant 1 attributes
    dfar Map9BScreens0 ; variant 2 screens
    dfar Map9BAttrs0 ; variant 2 attributes
    dfar Map9BScreens0 ; variant 3 screens
    dfar Map9BAttrs0 ; variant 3 attributes
    dfar Map9BScreens4 ; variant 4 screens
    dfar Map9BAttrs4 ; variant 4 attributes

; map record that no MapTable entry points to, 1 x 1 screens, 5 decoded variant(s) (E-0142, E-0201)
MapRecordX6248::
    dfar MapX6248Tileset ; entry 0: tileset
    dfar MapX6248Palettes ; palettes
    db $01, $01, $1f, $1c, $00, $00, $00, $02, $06, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $64 ; variant flag byte
    dfar MapX6248Screens0 ; variant 0 screens
    dfar MapX6248Attrs0 ; variant 0 attributes
    dfar MapX6248Screens0 ; variant 1 screens
    dfar MapX6248Attrs0 ; variant 1 attributes
    dfar MapX6248Screens0 ; variant 2 screens
    dfar MapX6248Attrs0 ; variant 2 attributes
    dfar MapX6248Screens0 ; variant 3 screens
    dfar MapX6248Attrs0 ; variant 3 attributes
    dfar MapX6248Screens0 ; variant 4 screens
    dfar MapX6248Attrs0 ; variant 4 attributes

; map record of map $A0, 4 x 3 screens, 2 decoded variant(s) (E-0142)
MapRecordA0::
    dfar MapA0Tileset ; entry 0: tileset
    dfar MapA0Palettes ; palettes
    db $04, $03, $3f, $00, $01, $16, $00, $02, $29, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $65 ; variant flag byte
    dfar MapA0Screens0 ; variant 0 screens
    dfar MapA0Attrs0 ; variant 0 attributes
    dfar MapA0Screens1 ; variant 1 screens
    dfar MapA0Attrs1 ; variant 1 attributes

; map record of map $A1, 1 x 3 screens, 2 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecordA1::
    dfar MapA1Tileset ; entry 0: tileset
    dfar MapA1Palettes ; palettes
    db $01, $03, $5f, $00, $05, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $65 ; variant flag byte
    dfar MapA1Screens0 ; variant 0 screens
    dfar MapA1Attrs0 ; variant 0 attributes
    dfar MapA1Screens1 ; variant 1 screens
    dfar MapA1Attrs1 ; variant 1 attributes

; map record of map $A2, 3 x 4 screens, 2 decoded variant(s) (E-0142)
MapRecordA2::
    dfar MapA2Tileset ; entry 0: tileset
    dfar MapA2Palettes ; palettes
    db $03, $04, $55, $00, $01, $17, $00, $02, $07, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $65 ; variant flag byte
    dfar MapA2Screens0 ; variant 0 screens
    dfar MapA2Attrs0 ; variant 0 attributes
    dfar MapA2Screens0 ; variant 1 screens
    dfar MapA2Attrs0 ; variant 1 attributes

; map record of map $A3, 1 x 2 screens, 2 decoded variant(s) (E-0142)
MapRecordA3::
    dfar MapA3Tileset ; entry 0: tileset
    dfar MapA3Palettes ; palettes
    db $01, $02, $68, $00, $0a, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $65 ; variant flag byte
    dfar MapA3Screens0 ; variant 0 screens
    dfar MapA3Attrs0 ; variant 0 attributes
    dfar MapA3Screens0 ; variant 1 screens
    dfar MapA3Attrs0 ; variant 1 attributes

; map record that no MapTable entry points to, 1 x 1 screens, 2 decoded variant(s) (E-0142, E-0201)
MapRecordX62F0::
    dfar MapX62F0Tileset ; entry 0: tileset
    dfar MapX62F0Palettes ; palettes
    db $01, $01, $1f, $1c, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $65 ; variant flag byte
    dfar MapX62F0Screens0 ; variant 0 screens
    dfar MapX62F0Attrs0 ; variant 0 attributes
    dfar MapX62F0Screens0 ; variant 1 screens
    dfar MapX62F0Attrs0 ; variant 1 attributes

; map record of map $A8, 6 x 6 screens, 1 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecordA8::
    dfar MapA8Tileset ; entry 0: tileset
    dfar MapA8Palettes ; palettes
    db $06, $06, $3b, $00, $00, $18, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $66 ; variant flag byte
    dfar MapA8Screens0 ; variant 0 screens
    dfar MapA8Attrs0 ; variant 0 attributes

; map record of map $A9, 2 x 2 screens, 1 decoded variant(s) (E-0142)
MapRecordA9::
    dfar MapA9Tileset ; entry 0: tileset
    dfar MapA9Palettes ; palettes
    db $02, $02, $2d, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $66 ; variant flag byte
    dfar MapA9Screens0 ; variant 0 screens
    dfar MapA9Attrs0 ; variant 0 attributes

; map record of map $AA, 1 x 2 screens, 1 decoded variant(s) (E-0142)
MapRecordAA::
    dfar MapA9Tileset ; entry 0: tileset
    dfar MapA9Palettes ; palettes
    db $01, $02, $2d, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $66 ; variant flag byte
    dfar MapAAScreens0 ; variant 0 screens
    dfar MapAAAttrs0 ; variant 0 attributes

; map record of map $AB, 1 x 1 screens, 1 decoded variant(s) (E-0142)
MapRecordAB::
    dfar MapA9Tileset ; entry 0: tileset
    dfar MapA9Palettes ; palettes
    db $01, $01, $2d, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $66 ; variant flag byte
    dfar MapABScreens0 ; variant 0 screens
    dfar MapABAttrs0 ; variant 0 attributes

; map record of map $AC, 1 x 1 screens, 1 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecordAC::
    dfar MapACTileset ; entry 0: tileset
    dfar MapACPalettes ; palettes
    db $01, $01, $31, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $66 ; variant flag byte
    dfar MapACScreens0 ; variant 0 screens
    dfar MapACAttrs0 ; variant 0 attributes

; map record of map $AD, 3 x 4 screens, 1 decoded variant(s) (E-0142)
MapRecordAD::
    dfar MapADTileset ; entry 0: tileset
    dfar MapADPalettes ; palettes
    db $03, $04, $3f, $00, $00, $19, $01, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $66 ; variant flag byte
    dfar MapADScreens0 ; variant 0 screens
    dfar MapADAttrs0 ; variant 0 attributes

; map record of map $AE, 3 x 4 screens, 1 decoded variant(s) (E-0142)
MapRecordAE::
    dfar MapADTileset ; entry 0: tileset
    dfar MapADPalettes ; palettes
    db $03, $04, $3f, $00, $00, $19, $01, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $66 ; variant flag byte
    dfar MapAEScreens0 ; variant 0 screens
    dfar MapAEAttrs0 ; variant 0 attributes

; map record of map $B0, 3 x 2 screens, 2 decoded variant(s) (E-0142)
MapRecordB0::
    dfar MapB0Tileset ; entry 0: tileset
    dfar MapB0Palettes ; palettes
    db $03, $02, $3f, $00, $00, $1a, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $67 ; variant flag byte
    dfar MapB0Screens0 ; variant 0 screens
    dfar MapB0Attrs0 ; variant 0 attributes
    dfar MapB0Screens0 ; variant 1 screens
    dfar MapB0Attrs0 ; variant 1 attributes

; map record of map $B1, 1 x 1 screens, 2 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecordB1::
    dfar MapB1Tileset ; entry 0: tileset
    dfar MapB1Palettes ; palettes
    db $01, $01, $37, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $67 ; variant flag byte
    dfar MapB1Screens0 ; variant 0 screens
    dfar MapB1Attrs0 ; variant 0 attributes
    dfar MapB1Screens0 ; variant 1 screens
    dfar MapB1Attrs0 ; variant 1 attributes

; map record of map $B3, 2 x 2 screens, 2 decoded variant(s) (E-0142)
MapRecordB3::
    dfar MapB3Tileset ; entry 0: tileset
    dfar MapB3Palettes ; palettes
    db $02, $02, $1f, $00, $00, $1b, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $67 ; variant flag byte
    dfar MapB3Screens0 ; variant 0 screens
    dfar MapB3Attrs0 ; variant 0 attributes
    dfar MapB3Screens0 ; variant 1 screens
    dfar MapB3Attrs0 ; variant 1 attributes

; map record of map $B4, 2 x 2 screens, 2 decoded variant(s) (E-0142)
MapRecordB4::
    dfar MapB3Tileset ; entry 0: tileset
    dfar MapB3Palettes ; palettes
    db $02, $02, $1f, $00, $00, $1b, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $67 ; variant flag byte
    dfar MapB4Screens0 ; variant 0 screens
    dfar MapB4Attrs0 ; variant 0 attributes
    dfar MapB4Screens0 ; variant 1 screens
    dfar MapB4Attrs0 ; variant 1 attributes

; map record of map $B5, 2 x 2 screens, 2 decoded variant(s) (E-0142)
MapRecordB5::
    dfar MapB3Tileset ; entry 0: tileset
    dfar MapB3Palettes ; palettes
    db $02, $02, $1f, $00, $00, $1b, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $67 ; variant flag byte
    dfar MapB5Screens0 ; variant 0 screens
    dfar MapB5Attrs0 ; variant 0 attributes
    dfar MapB5Screens0 ; variant 1 screens
    dfar MapB5Attrs0 ; variant 1 attributes

; map record of map $B6, 1 x 1 screens, 2 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecordB6::
    dfar MapB3Tileset ; entry 0: tileset
    dfar MapB3Palettes ; palettes
    db $01, $01, $1f, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $67 ; variant flag byte
    dfar MapB6Screens0 ; variant 0 screens
    dfar MapB6Attrs0 ; variant 0 attributes
    dfar MapB6Screens0 ; variant 1 screens
    dfar MapB6Attrs0 ; variant 1 attributes

; map record of map $B8, 5 x 5 screens, 3 decoded variant(s) (E-0142)
MapRecordB8::
    dfar MapB8Tileset ; entry 0: tileset
    dfar MapB8Palettes ; palettes
    db $05, $05, $3f, $00, $01, $1c, $00, $01, $29, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $68 ; variant flag byte
    dfar MapB8Screens0 ; variant 0 screens
    dfar MapB8Attrs0 ; variant 0 attributes
    dfar MapB8Screens0 ; variant 1 screens
    dfar MapB8Attrs0 ; variant 1 attributes
    dfar MapB8Screens0 ; variant 2 screens
    dfar MapB8Attrs0 ; variant 2 attributes

; map record of map $B9, 2 x 2 screens, 3 decoded variant(s) (E-0142)
MapRecordB9::
    dfar MapB9Tileset ; entry 0: tileset
    dfar MapB9Palettes ; palettes
    db $02, $02, $3d, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $68 ; variant flag byte
    dfar MapB9Screens0 ; variant 0 screens
    dfar MapB9Attrs0 ; variant 0 attributes
    dfar MapB9Screens0 ; variant 1 screens
    dfar MapB9Attrs0 ; variant 1 attributes
    dfar MapB9Screens0 ; variant 2 screens
    dfar MapB9Attrs0 ; variant 2 attributes

; map record of map $BA, 1 x 2 screens, 3 decoded variant(s) (E-0142)
MapRecordBA::
    dfar MapBATileset ; entry 0: tileset
    dfar MapBAPalettes ; palettes
    db $01, $02, $39, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $68 ; variant flag byte
    dfar MapBAScreens0 ; variant 0 screens
    dfar MapBAAttrs0 ; variant 0 attributes
    dfar MapBAScreens0 ; variant 1 screens
    dfar MapBAAttrs0 ; variant 1 attributes
    dfar MapBAScreens0 ; variant 2 screens
    dfar MapBAAttrs0 ; variant 2 attributes

; map record of map $BB, 1 x 2 screens, 3 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecordBB::
    dfar MapBBTileset ; entry 0: tileset
    dfar MapBBPalettes ; palettes
    db $01, $02, $0f, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $68 ; variant flag byte
    dfar MapBBScreens0 ; variant 0 screens
    dfar MapBBAttrs0 ; variant 0 attributes
    dfar MapBBScreens1 ; variant 1 screens
    dfar MapBBAttrs1 ; variant 1 attributes
    dfar MapBBScreens1 ; variant 2 screens
    dfar MapBBAttrs1 ; variant 2 attributes

; map record of map $BC, 1 x 1 screens, 3 decoded variant(s) (E-0142)
MapRecordBC::
    dfar MapBCTileset ; entry 0: tileset
    dfar MapBCPalettes ; palettes
    db $01, $01, $2c, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $68 ; variant flag byte
    dfar MapBCScreens0 ; variant 0 screens
    dfar MapBCAttrs0 ; variant 0 attributes
    dfar MapBCScreens0 ; variant 1 screens
    dfar MapBCAttrs0 ; variant 1 attributes
    dfar MapBCScreens0 ; variant 2 screens
    dfar MapBCAttrs0 ; variant 2 attributes

; map record of map $BD, 1 x 1 screens, 3 decoded variant(s) (E-0142)
MapRecordBD::
    dfar MapBDTileset ; entry 0: tileset
    dfar MapBDPalettes ; palettes
    db $01, $01, $3f, $00, $00, $00, $03, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $68 ; variant flag byte
    dfar MapBDScreens0 ; variant 0 screens
    dfar MapBDAttrs0 ; variant 0 attributes
    dfar MapBDScreens0 ; variant 1 screens
    dfar MapBDAttrs0 ; variant 1 attributes
    dfar MapBDScreens0 ; variant 2 screens
    dfar MapBDAttrs0 ; variant 2 attributes

; map record of map $BE, 1 x 1 screens, 3 decoded variant(s) (E-0142)
MapRecordBE::
    dfar MapBDTileset ; entry 0: tileset
    dfar MapBDPalettes ; palettes
    db $01, $01, $3f, $00, $00, $1d, $03, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $68 ; variant flag byte
    dfar MapBEScreens0 ; variant 0 screens
    dfar MapBEAttrs0 ; variant 0 attributes
    dfar MapBEScreens0 ; variant 1 screens
    dfar MapBEAttrs0 ; variant 1 attributes
    dfar MapBEScreens0 ; variant 2 screens
    dfar MapBEAttrs0 ; variant 2 attributes

; map record of map $BF, 2 x 2 screens, 3 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecordBF::
    dfar MapBDTileset ; entry 0: tileset
    dfar MapBDPalettes ; palettes
    db $02, $02, $3f, $00, $00, $1e, $03, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $68 ; variant flag byte
    dfar MapBFScreens0 ; variant 0 screens
    dfar MapBFAttrs0 ; variant 0 attributes
    dfar MapBFScreens0 ; variant 1 screens
    dfar MapBFAttrs0 ; variant 1 attributes
    dfar MapBFScreens2 ; variant 2 screens
    dfar MapBFAttrs2 ; variant 2 attributes

; map record of map $C0, 2 x 2 screens, 3 decoded variant(s) (E-0142)
MapRecordC0::
    dfar MapBDTileset ; entry 0: tileset
    dfar MapBDPalettes ; palettes
    db $02, $02, $3f, $00, $00, $1f, $03, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $68 ; variant flag byte
    dfar MapC0Screens0 ; variant 0 screens
    dfar MapC0Attrs0 ; variant 0 attributes
    dfar MapC0Screens0 ; variant 1 screens
    dfar MapC0Attrs0 ; variant 1 attributes
    dfar MapC0Screens0 ; variant 2 screens
    dfar MapC0Attrs0 ; variant 2 attributes

; map record of map $C1, 2 x 2 screens, 3 decoded variant(s) (E-0142)
MapRecordC1::
    dfar MapBDTileset ; entry 0: tileset
    dfar MapBDPalettes ; palettes
    db $02, $02, $3f, $00, $00, $1f, $03, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $68 ; variant flag byte
    dfar MapC1Screens0 ; variant 0 screens
    dfar MapC1Attrs0 ; variant 0 attributes
    dfar MapC1Screens0 ; variant 1 screens
    dfar MapC1Attrs0 ; variant 1 attributes
    dfar MapC1Screens0 ; variant 2 screens
    dfar MapC1Attrs0 ; variant 2 attributes

; map record of map $C2, 2 x 2 screens, 3 decoded variant(s) (E-0142)
MapRecordC2::
    dfar MapBDTileset ; entry 0: tileset
    dfar MapBDPalettes ; palettes
    db $02, $02, $3f, $00, $00, $20, $03, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $68 ; variant flag byte
    dfar MapC2Screens0 ; variant 0 screens
    dfar MapC2Attrs0 ; variant 0 attributes
    dfar MapC2Screens0 ; variant 1 screens
    dfar MapC2Attrs0 ; variant 1 attributes
    dfar MapC2Screens0 ; variant 2 screens
    dfar MapC2Attrs0 ; variant 2 attributes

; map record of map $C3, 2 x 2 screens, 3 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecordC3::
    dfar MapBDTileset ; entry 0: tileset
    dfar MapBDPalettes ; palettes
    db $02, $02, $3f, $00, $00, $20, $03, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $68 ; variant flag byte
    dfar MapC3Screens0 ; variant 0 screens
    dfar MapC3Attrs0 ; variant 0 attributes
    dfar MapC3Screens0 ; variant 1 screens
    dfar MapC3Attrs0 ; variant 1 attributes
    dfar MapC3Screens0 ; variant 2 screens
    dfar MapC3Attrs0 ; variant 2 attributes

; map record of map $C4, 1 x 1 screens, 3 decoded variant(s) (E-0142)
MapRecordC4::
    dfar MapBDTileset ; entry 0: tileset
    dfar MapBDPalettes ; palettes
    db $01, $01, $3f, $00, $00, $00, $03, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $68 ; variant flag byte
    dfar MapC4Screens0 ; variant 0 screens
    dfar MapC4Attrs0 ; variant 0 attributes
    dfar MapC4Screens0 ; variant 1 screens
    dfar MapC4Attrs0 ; variant 1 attributes
    dfar MapC4Screens0 ; variant 2 screens
    dfar MapC4Attrs0 ; variant 2 attributes

; map record of map $C8, 1 x 2 screens, 2 decoded variant(s) (E-0142)
MapRecordC8::
    dfar MapC8Tileset ; entry 0: tileset
    dfar MapC8Palettes ; palettes
    db $01, $02, $3f, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $69 ; variant flag byte
    dfar MapC8Screens0 ; variant 0 screens
    dfar MapC8Attrs0 ; variant 0 attributes
    dfar MapC8Screens0 ; variant 1 screens
    dfar MapC8Attrs0 ; variant 1 attributes

; map record of map $C9, 1 x 2 screens, 2 decoded variant(s) (E-0142)
MapRecordC9::
    dfar MapC9Tileset ; entry 0: tileset
    dfar MapC9Palettes ; palettes
    db $01, $02, $4f, $00, $04, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $69 ; variant flag byte
    dfar MapC9Screens0 ; variant 0 screens
    dfar MapC9Attrs0 ; variant 0 attributes
    dfar MapC9Screens0 ; variant 1 screens
    dfar MapC9Attrs0 ; variant 1 attributes

; map record of map $CA, 1 x 2 screens, 2 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecordCA::
    dfar MapC9Tileset ; entry 0: tileset
    dfar MapC9Palettes ; palettes
    db $01, $02, $4f, $00, $04, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $69 ; variant flag byte
    dfar MapCAScreens0 ; variant 0 screens
    dfar MapCAAttrs0 ; variant 0 attributes
    dfar MapCAScreens0 ; variant 1 screens
    dfar MapCAAttrs0 ; variant 1 attributes

; map record of map $CE, 1 x 2 screens, 2 decoded variant(s) (E-0142)
MapRecordCE::
    dfar MapC9Tileset ; entry 0: tileset
    dfar MapC9Palettes ; palettes
    db $01, $02, $4f, $00, $04, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $69 ; variant flag byte
    dfar MapCEScreens0 ; variant 0 screens
    dfar MapCEAttrs0 ; variant 0 attributes
    dfar MapCEScreens0 ; variant 1 screens
    dfar MapCEAttrs0 ; variant 1 attributes

; map record of map $D1, 1 x 2 screens, 2 decoded variant(s) (E-0142)
MapRecordD1::
    dfar MapD1Tileset ; entry 0: tileset
    dfar MapD1Palettes ; palettes
    db $01, $02, $3f, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $69 ; variant flag byte
    dfar MapD1Screens0 ; variant 0 screens
    dfar MapD1Attrs0 ; variant 0 attributes
    dfar MapD1Screens0 ; variant 1 screens
    dfar MapD1Attrs0 ; variant 1 attributes

; map record of map $D2, 1 x 2 screens, 2 decoded variant(s) (E-0142)
MapRecordD2::
    dfar MapD2Tileset ; entry 0: tileset
    dfar MapD2Palettes ; palettes
    db $01, $02, $4f, $00, $04, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $69 ; variant flag byte
    dfar MapC9Screens0 ; variant 0 screens
    dfar MapC9Attrs0 ; variant 0 attributes
    dfar MapC9Screens0 ; variant 1 screens
    dfar MapC9Attrs0 ; variant 1 attributes

; map record of map $D3, 1 x 2 screens, 2 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecordD3::
    dfar MapD2Tileset ; entry 0: tileset
    dfar MapD2Palettes ; palettes
    db $01, $02, $4f, $00, $04, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $69 ; variant flag byte
    dfar MapCAScreens0 ; variant 0 screens
    dfar MapCAAttrs0 ; variant 0 attributes
    dfar MapCAScreens0 ; variant 1 screens
    dfar MapCAAttrs0 ; variant 1 attributes

; map record of map $D7, 1 x 2 screens, 2 decoded variant(s) (E-0142)
MapRecordD7::
    dfar MapD2Tileset ; entry 0: tileset
    dfar MapD2Palettes ; palettes
    db $01, $02, $4f, $00, $04, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $69 ; variant flag byte
    dfar MapD7Screens0 ; variant 0 screens
    dfar MapD7Attrs0 ; variant 0 attributes
    dfar MapD7Screens0 ; variant 1 screens
    dfar MapD7Attrs0 ; variant 1 attributes

; map record of map $DA, 2 x 1 screens, 2 decoded variant(s) (E-0142)
MapRecordDA::
    dfar MapDATileset ; entry 0: tileset
    dfar MapDAPalettes ; palettes
    db $02, $01, $3f, $00, $00, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $69 ; variant flag byte
    dfar MapDAScreens0 ; variant 0 screens
    dfar MapDAAttrs0 ; variant 0 attributes
    dfar MapDAScreens0 ; variant 1 screens
    dfar MapDAAttrs0 ; variant 1 attributes

; map record of map $DB, 1 x 2 screens, 2 decoded variant(s) (E-0142)
MapRecordDB::
    dfar MapDBTileset ; entry 0: tileset
    dfar MapDBPalettes ; palettes
    db $01, $02, $4f, $00, $04, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $69 ; variant flag byte
    dfar MapC9Screens0 ; variant 0 screens
    dfar MapC9Attrs0 ; variant 0 attributes
    dfar MapC9Screens0 ; variant 1 screens
    dfar MapC9Attrs0 ; variant 1 attributes

; map record of map $DC, 1 x 2 screens, 2 decoded variant(s) (E-0142)
; record: tileset; palettes; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind,
; encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; variant flag byte; then per variant: screen
; array, attribute array
MapRecordDC::
    dfar MapDBTileset ; entry 0: tileset
    dfar MapDBPalettes ; palettes
    db $01, $02, $4f, $00, $04, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $69 ; variant flag byte
    dfar MapCAScreens0 ; variant 0 screens
    dfar MapCAAttrs0 ; variant 0 attributes
    dfar MapCAScreens0 ; variant 1 screens
    dfar MapCAAttrs0 ; variant 1 attributes

; map record of map $E0, 1 x 2 screens, 2 decoded variant(s) (E-0142)
MapRecordE0::
    dfar MapDBTileset ; entry 0: tileset
    dfar MapDBPalettes ; palettes
    db $01, $02, $4f, $00, $04, $00, $00, $00, $00, $00 ; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes
    dw wStoryFlags + $69 ; variant flag byte
    dfar MapE0Screens0 ; variant 0 screens
    dfar MapE0Attrs0 ; variant 0 attributes
    dfar MapE0Screens0 ; variant 1 screens
    dfar MapE0Attrs0 ; variant 1 attributes

; CheckWarpAtPlayer indexes it with hMapId; the lists hold entries matched against the player's
; facing and position, and a match queues sound effect $60 and loads a new map number and position;
; all 256 words point into the bank; the first list starts at $69A6, directly after the table).
; E-0231: the lists are laid out as 9-byte entries ending with $80 (CheckWarpAtPlayer: a facing
; byte, $FD = skip, $FE/$FF = any facing, then screen and position matched against the player
; (E-0036, C1)
; record: list of warps for this map number (hMapId); a list ends with $80; maps without warps share
; one empty list
MapWarpTable::
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

; list for entry $0B of MapWarpTable; 0 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarps0B::
    db $80 ; end

; list for entry $00 of MapWarpTable; 5 record(s), then $80 (E-0157)
MapWarps00::
    db $fd, $02, $40, $40, $06, $00, $00, $04, $08 ; id 0
    db $ff, $00, $00, $01, $02, $02, $00, $90, $00 ; id 1
    db $02, $10, $40, $00, $01, $03, $02, $04, $08 ; id 2
    db $ff, $00, $01, $00, $01, $03, $02, $90, $00 ; id 3
    db $fd, $21, $60, $30, $07, $00, $10, $06, $03 ; id 4
    db $80 ; end

; list for entry $01 of MapWarpTable; 15 record(s), then $80 (E-0157)
MapWarps01::
    db $fd, $22, $50, $50, $05, $02, $30, $05, $00 ; id 0
    db $fd, $00, $50, $50, $15, $00, $00, $05, $08 ; id 1
    db $fd, $10, $30, $40, $17, $00, $00, $05, $08 ; id 2
    db $fd, $10, $50, $00, $19, $01, $01, $05, $08 ; id 3
    db $fd, $01, $40, $50, $11, $00, $01, $04, $08 ; id 4
    db $fd, $01, $50, $50, $11, $00, $01, $05, $08 ; id 5
    db $fd, $11, $30, $40, $09, $00, $00, $03, $08 ; id 6
    db $fd, $11, $20, $10, $13, $00, $00, $02, $08 ; id 7
    db $fd, $21, $50, $50, $0a, $00, $00, $05, $08 ; id 8
    db $fd, $02, $40, $40, $08, $00, $00, $04, $08 ; id 9
    db $fd, $02, $60, $10, $16, $00, $00, $06, $08 ; id 10
    db $ff, $00, $00, $03, $02, $00, $00, $00, $80 ; id 11
    db $fd, $12, $20, $30, $0c, $01, $00, $03, $08 ; id 12
    db $ff, $00, $04, $02, $00, $02, $00, $70, $00 ; id 13
    db $ff, $00, $03, $03, $00, $01, $01, $00, $80 ; id 14
    db $80 ; end

; list for entry $02 of MapWarpTable; 2 record(s), then $80 (E-0157)
MapWarps02::
    db $ff, $00, $00, $ff, $01, $00, $02, $00, $80 ; id 0
    db $ff, $00, $03, $00, $00, $01, $01, $70, $00 ; id 1
    db $80 ; end

; list for entry $03 of MapWarpTable; 1 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarps03::
    db $fd, $00, $50, $50, $05, $00, $10, $05, $05 ; id 0
    db $80 ; end

; list for entry $04 of MapWarpTable; 3 record(s), then $80 (E-0157)
MapWarps04::
    db $fd, $20, $40, $40, $0c, $01, $10, $04, $04 ; id 0
    db $ff, $00, $02, $01, $18, $82, $00, $00, $a0 ; id 1
    db $ff, $00, $01, $01, $18, $81, $00, $00, $80 ; id 2
    db $80 ; end

; list for entry $05 of MapWarpTable; 3 record(s), then $80 (E-0157)
MapWarps05::
    db $fe, $00, $02, $ff, $01, $02, $12, $05, $05 ; id 0
    db $fd, $00, $50, $50, $03, $00, $10, $05, $05 ; id 1
    db $fd, $00, $50, $10, $0d, $00, $31, $05, $08 ; id 2
    db $80 ; end

; list for entry $06 of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarps06::
    db $fe, $00, $00, $01, $00, $80, $02, $04, $04 ; id 0
    db $80 ; end

; list for entry $07 of MapWarpTable; 2 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarps07::
    db $fd, $00, $60, $30, $00, $02, $11, $06, $03 ; id 0
    db $fd, $00, $50, $00, $0d, $03, $31, $05, $08 ; id 1
    db $80 ; end

; list for entry $08 of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarps08::
    db $fe, $00, $00, $01, $01, $80, $02, $04, $04 ; id 0
    db $80 ; end

; list for entry $09 of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarps09::
    db $fe, $00, $00, $01, $01, $81, $01, $03, $04 ; id 0
    db $80 ; end

; list for entry $0A of MapWarpTable; 2 record(s), then $80 (E-0157)
MapWarps0A::
    db $fe, $00, $00, $01, $01, $82, $01, $05, $05 ; id 0
    db $fd, $00, $80, $40, $0d, $01, $11, $08, $04 ; id 1
    db $80 ; end

; list for entry $0C of MapWarpTable; 4 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarps0C::
    db $fe, $00, $01, $01, $01, $81, $02, $02, $03 ; id 0
    db $fd, $10, $40, $40, $04, $02, $10, $04, $04 ; id 1
    db $fd, $00, $30, $40, $0e, $00, $00, $03, $08 ; id 2
    db $fd, $00, $70, $40, $12, $00, $00, $07, $08 ; id 3
    db $80 ; end

; list for entry $0D of MapWarpTable; 3 record(s), then $80 (E-0157)
MapWarps0D::
    db $fd, $11, $80, $40, $0a, $00, $10, $08, $04 ; id 0
    db $fe, $00, $00, $02, $05, $80, $10, $05, $01 ; id 1
    db $fe, $00, $03, $02, $07, $80, $10, $05, $00 ; id 2
    db $80 ; end

; list for entry $0E of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarps0E::
    db $fe, $00, $00, $01, $0c, $80, $00, $03, $04 ; id 0
    db $80 ; end

; list for entry $0F of MapWarpTable; 3 record(s), then $80 (E-0157)
MapWarps0F::
    db $00, $00, $40, $80, $0c, $80, $00, $02, $01 ; id 0
    db $00, $00, $20, $80, $0c, $80, $00, $02, $01 ; id 1
    db $00, $00, $70, $80, $0c, $80, $00, $07, $01 ; id 2
    db $80 ; end

; list for entry $10 of MapWarpTable; 1 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarps10::
    db $fe, $00, $00, $01, $0c, $80, $00, $07, $01 ; id 0
    db $80 ; end

; list for entry $11 of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarps11::
    db $ff, $00, $00, $02, $01, $80, $01, $00, $d0 ; id 0
    db $80 ; end

; list for entry $12 of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarps12::
    db $fe, $00, $00, $01, $0c, $80, $00, $07, $04 ; id 0
    db $80 ; end

; list for entry $13 of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarps13::
    db $fe, $00, $00, $01, $01, $81, $01, $02, $01 ; id 0
    db $80 ; end

; list for entry $15 of MapWarpTable; 1 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarps15::
    db $fe, $00, $00, $01, $01, $80, $00, $05, $05 ; id 0
    db $80 ; end

; list for entry $16 of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarps16::
    db $fe, $00, $00, $01, $01, $80, $02, $06, $01 ; id 0
    db $80 ; end

; list for entry $17 of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarps17::
    db $fe, $00, $00, $01, $01, $81, $00, $03, $04 ; id 0
    db $80 ; end

; list for entry $18 of MapWarpTable; 4 record(s), then $80 (E-0157)
MapWarps18::
    db $fd, $20, $40, $20, $04, $02, $00, $04, $08 ; id 0
    db $fd, $20, $50, $20, $04, $02, $00, $05, $08 ; id 1
    db $fd, $10, $40, $00, $04, $01, $00, $04, $08 ; id 2
    db $fd, $10, $50, $00, $04, $01, $00, $05, $08 ; id 3
    db $80 ; end

; list for entry $19 of MapWarpTable; 2 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarps19::
    db $fe, $00, $01, $02, $01, $81, $00, $05, $00 ; id 0
    db $fd, $11, $50, $40, $1a, $01, $10, $05, $04 ; id 1
    db $80 ; end

; list for entry $1A of MapWarpTable; 2 record(s), then $80 (E-0157)
MapWarps1A::
    db $fd, $10, $50, $40, $19, $01, $11, $05, $04 ; id 0
    db $fd, $20, $40, $30, $1b, $00, $10, $04, $03 ; id 1
    db $80 ; end

; list for entry $1B of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarps1B::
    db $fd, $00, $40, $30, $1a, $02, $10, $04, $03 ; id 0
    db $80 ; end

; list for entry $20 of MapWarpTable; 6 record(s), then $80 (E-0157)
MapWarps20::
    db $fd, $21, $40, $40, $21, $00, $30, $05, $08 ; id 0
    db $fd, $21, $50, $40, $21, $00, $30, $05, $08 ; id 1
    db $fd, $25, $40, $40, $24, $00, $31, $05, $08 ; id 2
    db $fd, $25, $50, $40, $24, $00, $31, $05, $08 ; id 3
    db $fd, $55, $40, $40, $2f, $00, $31, $06, $08 ; id 4
    db $fd, $55, $50, $40, $2f, $00, $31, $06, $08 ; id 5
    db $80 ; end

; list for entry $21 of MapWarpTable; 4 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarps21::
    db $fe, $00, $00, $01, $20, $02, $11, $04, $04 ; id 0
    db $fe, $00, $02, $00, $20, $02, $11, $04, $04 ; id 1
    db $fd, $00, $50, $10, $22, $00, $00, $05, $08 ; id 2
    db $fd, $10, $20, $20, $2a, $00, $00, $02, $08 ; id 3
    db $80 ; end

; list for entry $22 of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarps22::
    db $fe, $00, $00, $01, $21, $80, $00, $05, $01 ; id 0
    db $80 ; end

; list for entry $23 of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarps23::
    db $fe, $00, $00, $01, $24, $81, $01, $03, $02 ; id 0
    db $80 ; end

; list for entry $24 of MapWarpTable; 7 record(s), then $80 (E-0157)
MapWarps24::
    db $fe, $00, $ff, $00, $20, $02, $15, $04, $04 ; id 0
    db $fe, $00, $02, $01, $20, $02, $15, $04, $04 ; id 1
    db $fe, $00, $00, $02, $20, $02, $15, $04, $04 ; id 2
    db $fd, $00, $40, $00, $25, $00, $00, $04, $08 ; id 3
    db $fd, $00, $50, $00, $25, $00, $00, $05, $08 ; id 4
    db $fd, $11, $30, $20, $23, $00, $00, $04, $08 ; id 5
    db $fd, $11, $20, $50, $2b, $23, $33, $02, $00 ; id 6
    db $80 ; end

; list for entry $25 of MapWarpTable; 5 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarps25::
    db $ff, $00, $00, $01, $24, $80, $00, $00, $80 ; id 0
    db $fd, $00, $40, $00, $26, $00, $00, $04, $08 ; id 1
    db $fd, $00, $50, $00, $26, $00, $00, $05, $08 ; id 2
    db $fd, $00, $20, $60, $2e, $00, $10, $02, $06 ; id 3
    db $fd, $10, $80, $30, $2d, $00, $10, $08, $03 ; id 4
    db $80 ; end

; list for entry $26 of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarps26::
    db $ff, $00, $00, $01, $25, $80, $00, $00, $80 ; id 0
    db $80 ; end

; list for entry $28 of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarps28::
    db $fe, $00, $00, $02, $2f, $81, $10, $04, $03 ; id 0
    db $80 ; end

; list for entry $29 of MapWarpTable; 0 record(s), then $80 (E-0157)
MapWarps29::
    db $80 ; end

; list for entry $2A of MapWarpTable; 2 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarps2A::
    db $fe, $00, $00, $01, $21, $81, $00, $02, $02 ; id 0
    db $fd, $00, $10, $20, $2b, $11, $10, $01, $02 ; id 1
    db $80 ; end

; list for entry $2B of MapWarpTable; 2 record(s), then $80 (E-0157)
MapWarps2B::
    db $fd, $10, $10, $20, $2a, $00, $10, $01, $02 ; id 0
    db $fe, $00, $03, $02, $24, $01, $11, $02, $05 ; id 1
    db $80 ; end

; list for entry $2D of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarps2D::
    db $fd, $00, $80, $30, $25, $01, $10, $08, $03 ; id 0
    db $80 ; end

; list for entry $2E of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarps2E::
    db $fd, $00, $20, $60, $25, $00, $10, $02, $06 ; id 0
    db $80 ; end

; list for entry $2F of MapWarpTable; 8 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarps2F::
    db $fe, $00, $ff, $00, $20, $05, $15, $04, $04 ; id 0
    db $fe, $00, $ff, $01, $20, $05, $15, $04, $04 ; id 1
    db $fe, $00, $00, $ff, $20, $05, $15, $04, $04 ; id 2
    db $fe, $00, $01, $ff, $20, $05, $15, $04, $04 ; id 3
    db $fe, $00, $02, $00, $20, $05, $15, $04, $04 ; id 4
    db $fe, $00, $02, $01, $20, $05, $15, $04, $04 ; id 5
    db $fe, $00, $00, $02, $20, $05, $15, $04, $04 ; id 6
    db $fe, $00, $01, $02, $20, $05, $15, $04, $04 ; id 7
    db $80 ; end

; list for entry $30 of MapWarpTable; 9 record(s), then $80 (E-0157)
MapWarps30::
    db $fd, $56, $40, $40, $31, $00, $31, $04, $08 ; id 0
    db $fd, $56, $50, $40, $31, $00, $31, $04, $08 ; id 1
    db $fd, $42, $40, $40, $32, $00, $10, $06, $00 ; id 2
    db $fd, $42, $50, $40, $32, $00, $10, $06, $00 ; id 3
    db $fd, $24, $40, $40, $3c, $01, $30, $04, $08 ; id 4
    db $fd, $24, $50, $40, $3c, $01, $30, $04, $08 ; id 5
    db $fd, $03, $40, $40, $35, $01, $33, $04, $08 ; id 6
    db $fd, $62, $40, $40, $3e, $00, $31, $04, $08 ; id 7
    db $fd, $53, $40, $40, $38, $02, $33, $04, $08 ; id 8
    db $80 ; end

; list for entry $31 of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarps31::
    db $fe, $00, $00, $02, $30, $05, $16, $04, $04 ; id 0
    db $80 ; end

; list for entry $32 of MapWarpTable; 4 record(s), then $80 (E-0157)
MapWarps32::
    db $fe, $00, $00, $ff, $30, $04, $12, $04, $04 ; id 0
    db $fe, $00, $02, $00, $30, $04, $12, $04, $04 ; id 1
    db $fd, $10, $40, $10, $33, $00, $01, $04, $08 ; id 2
    db $fd, $11, $40, $20, $34, $00, $00, $04, $08 ; id 3
    db $80 ; end

; list for entry $33 of MapWarpTable; 1 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarps33::
    db $fe, $00, $00, $02, $32, $81, $00, $04, $01 ; id 0
    db $80 ; end

; list for entry $34 of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarps34::
    db $fe, $00, $00, $01, $32, $81, $01, $04, $02 ; id 0
    db $80 ; end

; list for entry $35 of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarps35::
    db $fe, $00, $01, $04, $30, $00, $13, $04, $04 ; id 0
    db $80 ; end

; list for entry $36 of MapWarpTable; 3 record(s), then $80 (E-0157)
MapWarps36::
    db $fd, $00, $40, $20, $37, $02, $30, $04, $08 ; id 0
    db $fd, $00, $50, $20, $37, $02, $30, $04, $08 ; id 1
    db $fe, $00, $00, $01, $30, $05, $15, $04, $05 ; id 2
    db $80 ; end

; list for entry $37 of MapWarpTable; 2 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarps37::
    db $fe, $00, $02, $01, $36, $80, $10, $04, $02 ; id 0
    db $fd, $20, $20, $50, $42, $02, $10, $02, $05 ; id 1
    db $80 ; end

; list for entry $38 of MapWarpTable; 3 record(s), then $80 (E-0157)
MapWarps38::
    db $fe, $00, $02, $04, $30, $05, $13, $04, $04 ; id 0
    db $fd, $01, $40, $40, $39, $00, $10, $04, $04 ; id 1
    db $fd, $31, $40, $40, $39, $03, $10, $04, $04 ; id 2
    db $80 ; end

; list for entry $39 of MapWarpTable; 3 record(s), then $80 (E-0157)
MapWarps39::
    db $fd, $00, $40, $40, $38, $00, $11, $04, $04 ; id 0
    db $fd, $30, $40, $40, $38, $03, $11, $04, $04 ; id 1
    db $fd, $02, $40, $40, $3a, $02, $11, $04, $04 ; id 2
    db $80 ; end

; list for entry $3A of MapWarpTable; 2 record(s), then $80 (E-0157)
MapWarps3A::
    db $ff, $00, $01, $03, $3b, $80, $00, $00, $80 ; id 0
    db $fd, $21, $40, $40, $39, $00, $12, $04, $04 ; id 1
    db $80 ; end

; list for entry $3B of MapWarpTable; 1 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarps3B::
    db $ff, $00, $00, $ff, $3a, $01, $02, $00, $80 ; id 0
    db $80 ; end

; list for entry $3C of MapWarpTable; 2 record(s), then $80 (E-0157)
MapWarps3C::
    db $fe, $00, $01, $01, $30, $02, $14, $04, $04 ; id 0
    db $fd, $10, $70, $20, $3d, $00, $30, $07, $08 ; id 1
    db $80 ; end

; list for entry $3D of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarps3D::
    db $fe, $00, $00, $01, $3c, $81, $10, $07, $02 ; id 0
    db $80 ; end

; list for entry $3E of MapWarpTable; 5 record(s), then $80 (E-0157)
MapWarps3E::
    db $fe, $00, $00, $02, $30, $06, $12, $04, $04 ; id 0
    db $fd, $00, $60, $30, $3e, $01, $10, $06, $03 ; id 1
    db $fd, $10, $60, $30, $3e, $00, $10, $06, $03 ; id 2
    db $fd, $10, $30, $30, $3f, $00, $10, $03, $03 ; id 3
    db $fd, $11, $10, $60, $3f, $00, $11, $01, $06 ; id 4
    db $80 ; end

; list for entry $3F of MapWarpTable; 9 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarps3F::
    db $fd, $00, $30, $30, $3e, $01, $10, $03, $03 ; id 0
    db $fd, $01, $10, $60, $3e, $01, $11, $01, $06 ; id 1
    db $fd, $00, $60, $30, $3f, $01, $10, $06, $03 ; id 2
    db $fd, $10, $60, $30, $3f, $00, $10, $06, $03 ; id 3
    db $fd, $10, $20, $30, $3f, $01, $11, $02, $03 ; id 4
    db $fd, $11, $20, $30, $3f, $01, $10, $02, $03 ; id 5
    db $fd, $10, $60, $70, $3f, $01, $11, $06, $07 ; id 6
    db $fd, $11, $60, $70, $3f, $01, $10, $06, $07 ; id 7
    db $fd, $11, $40, $40, $40, $00, $11, $04, $04 ; id 8
    db $80 ; end

; list for entry $40 of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarps40::
    db $fd, $01, $40, $40, $3f, $01, $11, $04, $04 ; id 0
    db $80 ; end

; list for entry $41 of MapWarpTable; 0 record(s), then $80 (E-0157)
MapWarps41::
    db $80 ; end

; list for entry $42 of MapWarpTable; 3 record(s), then $80 (E-0157)
MapWarps42::
    db $fd, $20, $20, $50, $37, $02, $10, $02, $05 ; id 0
    db $fd, $00, $80, $10, $43, $00, $10, $08, $02 ; id 1
    db $fd, $00, $50, $40, $43, $00, $10, $05, $04 ; id 2
    db $80 ; end

; list for entry $43 of MapWarpTable; 3 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarps43::
    db $fd, $00, $80, $20, $42, $00, $10, $08, $01 ; id 0
    db $fd, $00, $50, $40, $42, $00, $10, $05, $04 ; id 1
    db $fd, $20, $40, $40, $44, $00, $30, $04, $08 ; id 2
    db $80 ; end

; list for entry $44 of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarps44::
    db $fe, $00, $00, $01, $43, $82, $10, $04, $04 ; id 0
    db $80 ; end

; list for entry $45 of MapWarpTable; 0 record(s), then $80 (E-0157)
MapWarps45::
    db $80 ; end

; list for entry $48 of MapWarpTable; 20 record(s), then $80 (E-0157)
MapWarps48::
    db $fd, $82, $40, $40, $4a, $00, $31, $05, $08 ; id 0
    db $fd, $82, $50, $40, $4a, $00, $31, $05, $08 ; id 1
    db $fd, $73, $40, $40, $4e, $10, $10, $04, $04 ; id 2
    db $fd, $74, $40, $40, $4e, $20, $12, $04, $04 ; id 3
    db $fd, $75, $40, $40, $4f, $00, $10, $00, $06 ; id 4
    db $fd, $75, $50, $40, $4f, $00, $10, $00, $06 ; id 5
    db $fd, $46, $40, $40, $52, $00, $30, $04, $08 ; id 6
    db $fd, $46, $60, $40, $52, $02, $30, $04, $08 ; id 7
    db $fd, $48, $40, $40, $58, $00, $31, $04, $08 ; id 8
    db $fd, $48, $50, $40, $58, $00, $31, $04, $08 ; id 9
    db $fd, $29, $40, $40, $5a, $01, $30, $04, $08 ; id 10
    db $fd, $29, $50, $40, $5a, $01, $30, $04, $08 ; id 11
    db $fd, $5a, $40, $30, $5d, $02, $10, $04, $00 ; id 12
    db $fd, $5a, $50, $30, $5d, $02, $10, $04, $00 ; id 13
    db $fd, $99, $40, $40, $5e, $01, $31, $04, $08 ; id 14
    db $fd, $99, $50, $40, $5e, $01, $31, $04, $08 ; id 15
    db $fd, $a5, $40, $40, $62, $01, $33, $04, $08 ; id 16
    db $fd, $87, $40, $40, $63, $00, $10, $04, $00 ; id 17
    db $fd, $50, $40, $40, $49, $00, $30, $04, $08 ; id 18
    db $fd, $50, $50, $40, $49, $00, $30, $04, $08 ; id 19
    db $80 ; end

; list for entry $49 of MapWarpTable; 1 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarps49::
    db $fe, $00, $00, $01, $48, $05, $10, $04, $04 ; id 0
    db $80 ; end

; list for entry $4A of MapWarpTable; 6 record(s), then $80 (E-0157)
MapWarps4A::
    db $fe, $00, $02, $00, $48, $08, $12, $04, $04 ; id 0
    db $fe, $00, $00, $02, $48, $08, $12, $04, $04 ; id 1
    db $fe, $00, $01, $02, $48, $08, $12, $04, $04 ; id 2
    db $fd, $10, $70, $40, $4b, $00, $30, $07, $08 ; id 3
    db $fd, $00, $40, $00, $4c, $00, $01, $04, $08 ; id 4
    db $fd, $00, $50, $00, $4c, $00, $01, $05, $08 ; id 5
    db $80 ; end

; list for entry $4B of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarps4B::
    db $fe, $00, $00, $01, $4a, $81, $10, $07, $04 ; id 0
    db $80 ; end

; list for entry $4C of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarps4C::
    db $ff, $00, $00, $02, $4a, $80, $10, $00, $80 ; id 0
    db $80 ; end

; list for entry $4D of MapWarpTable; 1 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarps4D::
    db $fd, $00, $60, $20, $4c, $00, $10, $06, $01 ; id 0
    db $80 ; end

; list for entry $4E of MapWarpTable; 2 record(s), then $80 (E-0157)
MapWarps4E::
    db $fd, $00, $40, $40, $48, $07, $13, $04, $04 ; id 0
    db $fd, $02, $40, $40, $48, $07, $14, $04, $04 ; id 1
    db $80 ; end

; list for entry $4F of MapWarpTable; 3 record(s), then $80 (E-0157)
MapWarps4F::
    db $fe, $00, $01, $ff, $48, $07, $15, $04, $04 ; id 0
    db $fe, $00, $ff, $00, $48, $07, $15, $04, $04 ; id 1
    db $fd, $00, $20, $40, $50, $00, $30, $03, $08 ; id 2
    db $80 ; end

; list for entry $50 of MapWarpTable; 2 record(s), then $80 (E-0157)
MapWarps50::
    db $fe, $00, $00, $01, $4f, $80, $10, $02, $04 ; id 0
    db $fd, $00, $50, $10, $51, $00, $10, $05, $01 ; id 1
    db $80 ; end

; list for entry $51 of MapWarpTable; 1 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarps51::
    db $fd, $00, $50, $10, $50, $00, $10, $05, $01 ; id 0
    db $80 ; end

; list for entry $52 of MapWarpTable; 6 record(s), then $80 (E-0157)
MapWarps52::
    db $fe, $00, $00, $01, $48, $04, $16, $04, $04 ; id 0
    db $fe, $00, $02, $01, $48, $04, $16, $06, $04 ; id 1
    db $fd, $00, $40, $00, $53, $20, $33, $04, $08 ; id 2
    db $fd, $00, $50, $00, $53, $20, $33, $05, $08 ; id 3
    db $fd, $20, $40, $00, $53, $12, $33, $04, $08 ; id 4
    db $fd, $20, $50, $00, $53, $12, $33, $05, $08 ; id 5
    db $80 ; end

; list for entry $53 of MapWarpTable; 9 record(s), then $80 (E-0157)
MapWarps53::
    db $fe, $00, $00, $04, $52, $b0, $00, $04, $00 ; id 0
    db $fe, $00, $02, $04, $52, $b2, $00, $04, $00 ; id 1
    db $fd, $02, $20, $40, $54, $30, $10, $02, $04 ; id 2
    db $fd, $31, $60, $30, $55, $31, $10, $06, $03 ; id 3
    db $fd, $11, $70, $20, $56, $30, $12, $07, $02 ; id 4
    db $fd, $00, $20, $00, $57, $30, $30, $02, $08 ; id 5
    db $fd, $00, $30, $00, $57, $30, $30, $03, $08 ; id 6
    db $fd, $20, $60, $00, $57, $32, $30, $06, $08 ; id 7
    db $fd, $20, $70, $00, $57, $32, $30, $07, $08 ; id 8
    db $80 ; end

; list for entry $54 of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarps54::
    db $fd, $00, $20, $40, $53, $30, $12, $02, $04 ; id 0
    db $80 ; end

; list for entry $55 of MapWarpTable; 1 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarps55::
    db $fd, $10, $60, $30, $53, $33, $11, $06, $03 ; id 0
    db $80 ; end

; list for entry $56 of MapWarpTable; 2 record(s), then $80 (E-0157)
MapWarps56::
    db $fd, $02, $70, $20, $53, $31, $11, $07, $02 ; id 0
    db $fd, $00, $40, $70, $57, $31, $10, $04, $07 ; id 1
    db $80 ; end

; list for entry $57 of MapWarpTable; 3 record(s), then $80 (E-0157)
MapWarps57::
    db $fd, $10, $40, $70, $56, $30, $10, $04, $07 ; id 0
    db $ff, $00, $00, $01, $53, $b0, $00, $00, $80 ; id 1
    db $ff, $00, $02, $01, $53, $b2, $00, $00, $80 ; id 2
    db $80 ; end

; list for entry $58 of MapWarpTable; 4 record(s), then $80 (E-0157)
MapWarps58::
    db $fe, $00, $ff, $00, $48, $04, $18, $04, $04 ; id 0
    db $fe, $00, $ff, $01, $48, $04, $18, $04, $04 ; id 1
    db $fe, $00, $00, $02, $48, $04, $18, $04, $04 ; id 2
    db $fd, $01, $80, $40, $59, $00, $30, $08, $08 ; id 3
    db $80 ; end

; list for entry $59 of MapWarpTable; 1 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarps59::
    db $fe, $00, $00, $01, $58, $80, $11, $08, $04 ; id 0
    db $80 ; end

; list for entry $5A of MapWarpTable; 7 record(s), then $80 (E-0157)
MapWarps5A::
    db $fe, $00, $ff, $00, $48, $02, $19, $04, $04 ; id 0
    db $fe, $00, $00, $01, $48, $02, $19, $04, $04 ; id 1
    db $fe, $00, $02, $00, $48, $02, $19, $04, $04 ; id 2
    db $fe, $00, $01, $01, $48, $02, $19, $04, $04 ; id 3
    db $fd, $10, $30, $30, $5b, $01, $31, $04, $08 ; id 4
    db $fd, $10, $40, $30, $5b, $01, $31, $05, $08 ; id 5
    db $fd, $00, $40, $10, $5c, $00, $31, $03, $08 ; id 6
    db $80 ; end

; list for entry $5B of MapWarpTable; 2 record(s), then $80 (E-0157)
MapWarps5B::
    db $ff, $00, $01, $02, $5a, $81, $10, $f0, $b0 ; id 0
    db $fd, $00, $70, $20, $5c, $00, $10, $07, $03 ; id 1
    db $80 ; end

; list for entry $5C of MapWarpTable; 2 record(s), then $80 (E-0157)
MapWarps5C::
    db $fd, $00, $70, $30, $5b, $00, $10, $07, $02 ; id 0
    db $fe, $00, $00, $02, $5a, $80, $30, $04, $01 ; id 1
    db $80 ; end

; list for entry $5D of MapWarpTable; 1 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarps5D::
    db $fe, $00, $02, $ff, $48, $05, $1a, $04, $03 ; id 0
    db $80 ; end

; list for entry $5E of MapWarpTable; 6 record(s), then $80 (E-0157)
MapWarps5E::
    db $fe, $00, $ff, $01, $48, $09, $19, $04, $04 ; id 0
    db $fe, $00, $01, $02, $48, $09, $19, $04, $04 ; id 1
    db $fe, $00, $02, $01, $48, $09, $19, $04, $04 ; id 2
    db $fd, $11, $20, $20, $5f, $00, $30, $02, $08 ; id 3
    db $fd, $10, $40, $00, $60, $00, $32, $04, $08 ; id 4
    db $fd, $10, $50, $00, $60, $00, $32, $05, $08 ; id 5
    db $80 ; end

; list for entry $5F of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarps5F::
    db $fe, $00, $00, $01, $5e, $81, $11, $02, $02 ; id 0
    db $80 ; end

; list for entry $60 of MapWarpTable; 2 record(s), then $80 (E-0157)
MapWarps60::
    db $ff, $00, $00, $03, $5e, $81, $00, $00, $80 ; id 0
    db $fd, $01, $80, $60, $61, $00, $11, $08, $06 ; id 1
    db $80 ; end

; list for entry $61 of MapWarpTable; 1 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarps61::
    db $fd, $01, $80, $60, $60, $00, $11, $08, $06 ; id 0
    db $80 ; end

; list for entry $62 of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarps62::
    db $fe, $00, $01, $04, $48, $0a, $15, $04, $04 ; id 0
    db $80 ; end

; list for entry $63 of MapWarpTable; 2 record(s), then $80 (E-0157)
MapWarps63::
    db $fe, $00, $00, $ff, $48, $08, $17, $04, $04 ; id 0
    db $fd, $11, $10, $70, $64, $01, $11, $01, $07 ; id 1
    db $80 ; end

; list for entry $64 of MapWarpTable; 9 record(s), then $80 (E-0157)
MapWarps64::
    db $fd, $11, $10, $70, $63, $01, $11, $01, $07 ; id 0
    db $fd, $10, $80, $20, $65, $01, $10, $08, $02 ; id 1
    db $fd, $10, $60, $40, $65, $01, $10, $06, $04 ; id 2
    db $fd, $10, $40, $60, $65, $01, $10, $04, $06 ; id 3
    db $fd, $01, $40, $20, $65, $00, $11, $04, $02 ; id 4
    db $fd, $01, $60, $40, $65, $00, $11, $06, $04 ; id 5
    db $fd, $01, $80, $60, $65, $00, $11, $08, $06 ; id 6
    db $fd, $11, $80, $20, $65, $01, $11, $08, $02 ; id 7
    db $fd, $11, $80, $70, $65, $01, $11, $08, $07 ; id 8
    db $80 ; end

; list for entry $65 of MapWarpTable; 10 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarps65::
    db $fd, $10, $80, $20, $64, $01, $10, $08, $02 ; id 0
    db $fd, $10, $60, $40, $64, $01, $10, $06, $04 ; id 1
    db $fd, $10, $40, $60, $64, $01, $10, $04, $06 ; id 2
    db $fd, $01, $40, $20, $64, $00, $11, $04, $02 ; id 3
    db $fd, $01, $60, $40, $64, $00, $11, $06, $04 ; id 4
    db $fd, $01, $80, $60, $64, $00, $11, $08, $06 ; id 5
    db $fd, $11, $80, $20, $64, $01, $11, $08, $02 ; id 6
    db $fd, $11, $80, $70, $64, $01, $11, $08, $07 ; id 7
    db $fd, $00, $10, $20, $66, $00, $10, $01, $02 ; id 8
    db $fd, $01, $10, $60, $66, $00, $11, $01, $06 ; id 9
    db $80 ; end

; list for entry $66 of MapWarpTable; 3 record(s), then $80 (E-0157)
MapWarps66::
    db $fd, $00, $10, $20, $65, $00, $10, $01, $02 ; id 0
    db $fd, $01, $10, $60, $65, $00, $11, $01, $06 ; id 1
    db $fd, $10, $40, $40, $67, $00, $10, $04, $04 ; id 2
    db $80 ; end

; list for entry $67 of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarps67::
    db $fd, $00, $40, $40, $66, $01, $10, $04, $04 ; id 0
    db $80 ; end

; list for entry $68 of MapWarpTable; 0 record(s), then $80 (E-0157)
MapWarps68::
    db $80 ; end

; list for entry $70 of MapWarpTable; 19 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarps70::
    db $fd, $b1, $40, $40, $71, $01, $30, $04, $08 ; id 0
    db $fd, $a4, $40, $40, $77, $12, $30, $04, $08 ; id 1
    db $fd, $94, $40, $40, $77, $20, $30, $04, $08 ; id 2
    db $fd, $56, $40, $40, $78, $00, $31, $04, $08 ; id 3
    db $fd, $56, $50, $40, $78, $00, $31, $04, $08 ; id 4
    db $fd, $04, $40, $40, $7a, $00, $31, $04, $08 ; id 5
    db $fd, $36, $40, $40, $7b, $10, $10, $04, $04 ; id 6
    db $fd, $37, $40, $40, $7b, $20, $12, $04, $04 ; id 7
    db $fd, $59, $40, $40, $7c, $01, $31, $05, $08 ; id 8
    db $fd, $59, $50, $40, $7c, $01, $31, $05, $08 ; id 9
    db $fd, $89, $40, $40, $80, $10, $30, $04, $08 ; id 10
    db $fd, $99, $40, $40, $80, $22, $30, $04, $08 ; id 11
    db $fd, $5b, $40, $40, $81, $00, $10, $04, $04 ; id 12
    db $fd, $1b, $40, $40, $85, $00, $31, $04, $08 ; id 13
    db $fd, $ba, $40, $40, $8a, $00, $30, $04, $08 ; id 14
    db $fd, $ba, $50, $40, $8a, $00, $30, $04, $08 ; id 15
    db $fd, $52, $40, $40, $92, $00, $30, $04, $08 ; id 16
    db $fd, $41, $40, $40, $93, $00, $30, $04, $08 ; id 17
    db $fd, $41, $50, $40, $93, $00, $30, $04, $08 ; id 18
    db $80 ; end

; list for entry $71 of MapWarpTable; 4 record(s), then $80 (E-0157)
MapWarps71::
    db $fe, $00, $00, $01, $70, $0b, $11, $04, $04 ; id 0
    db $fe, $00, $01, $01, $70, $0b, $11, $04, $04 ; id 1
    db $fd, $20, $20, $20, $72, $00, $30, $03, $08 ; id 2
    db $fe, $00, $01, $ff, $89, $00, $31, $04, $08 ; id 3
    db $80 ; end

; list for entry $72 of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarps72::
    db $fe, $00, $00, $01, $71, $82, $10, $02, $02 ; id 0
    db $80 ; end

; list for entry $73 of MapWarpTable; 4 record(s), then $80 (E-0157)
MapWarps73::
    db $fe, $00, $00, $02, $89, $00, $11, $05, $06 ; id 0
    db $fd, $00, $40, $40, $74, $00, $10, $04, $04 ; id 1
    db $fd, $01, $60, $20, $74, $00, $11, $06, $02 ; id 2
    db $fd, $11, $50, $50, $74, $01, $11, $05, $05 ; id 3
    db $80 ; end

; list for entry $74 of MapWarpTable; 6 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarps74::
    db $fd, $00, $40, $40, $73, $00, $10, $04, $04 ; id 0
    db $fd, $01, $60, $20, $73, $00, $11, $06, $02 ; id 1
    db $fd, $11, $50, $50, $73, $01, $11, $05, $05 ; id 2
    db $fd, $10, $50, $40, $75, $01, $10, $05, $04 ; id 3
    db $fd, $01, $40, $50, $75, $00, $11, $04, $05 ; id 4
    db $fd, $11, $30, $20, $75, $01, $11, $03, $02 ; id 5
    db $80 ; end

; list for entry $75 of MapWarpTable; 4 record(s), then $80 (E-0157)
MapWarps75::
    db $fd, $10, $50, $40, $74, $01, $10, $05, $04 ; id 0
    db $fd, $01, $40, $50, $74, $00, $11, $04, $05 ; id 1
    db $fd, $11, $30, $20, $74, $01, $11, $03, $02 ; id 2
    db $fd, $01, $40, $20, $76, $00, $11, $04, $02 ; id 3
    db $80 ; end

; list for entry $76 of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarps76::
    db $fd, $01, $40, $20, $75, $00, $11, $04, $02 ; id 0
    db $80 ; end

; list for entry $77 of MapWarpTable; 2 record(s), then $80 (E-0157)
MapWarps77::
    db $fe, $00, $02, $01, $70, $0a, $14, $04, $04 ; id 0
    db $fe, $00, $00, $01, $70, $09, $14, $04, $04 ; id 1
    db $80 ; end

; list for entry $78 of MapWarpTable; 3 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarps78::
    db $fe, $00, $00, $02, $70, $05, $16, $04, $04 ; id 0
    db $fe, $00, $02, $01, $70, $05, $16, $04, $04 ; id 1
    db $fd, $11, $60, $30, $79, $00, $11, $06, $03 ; id 2
    db $80 ; end

; list for entry $79 of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarps79::
    db $fd, $01, $60, $30, $78, $01, $11, $06, $03 ; id 0
    db $80 ; end

; list for entry $7A of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarps7A::
    db $fe, $00, $00, $02, $70, $00, $14, $04, $04 ; id 0
    db $80 ; end

; list for entry $7B of MapWarpTable; 2 record(s), then $80 (E-0157)
MapWarps7B::
    db $fd, $00, $40, $40, $70, $03, $16, $04, $04 ; id 0
    db $fd, $02, $40, $40, $70, $03, $17, $04, $04 ; id 1
    db $80 ; end

; list for entry $7C of MapWarpTable; 4 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarps7C::
    db $fe, $00, $01, $02, $70, $05, $19, $04, $04 ; id 0
    db $fd, $11, $20, $40, $7d, $00, $30, $02, $08 ; id 1
    db $fd, $00, $40, $40, $7f, $00, $31, $04, $08 ; id 2
    db $fd, $00, $50, $40, $7f, $00, $31, $05, $08 ; id 3
    db $80 ; end

; list for entry $7D of MapWarpTable; 2 record(s), then $80 (E-0157)
MapWarps7D::
    db $fe, $00, $00, $01, $7c, $81, $11, $02, $04 ; id 0
    db $fd, $00, $10, $60, $7e, $00, $10, $01, $06 ; id 1
    db $80 ; end

; list for entry $7E of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarps7E::
    db $fd, $00, $10, $60, $7d, $00, $10, $01, $06 ; id 0
    db $80 ; end

; list for entry $7F of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarps7F::
    db $ff, $00, $00, $02, $7c, $80, $10, $00, $c0 ; id 0
    db $80 ; end

; list for entry $80 of MapWarpTable; 2 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarps80::
    db $fe, $00, $00, $01, $70, $08, $19, $04, $04 ; id 0
    db $fe, $00, $02, $01, $70, $09, $19, $04, $04 ; id 1
    db $80 ; end

; list for entry $81 of MapWarpTable; 2 record(s), then $80 (E-0157)
MapWarps81::
    db $fd, $00, $40, $40, $70, $05, $1b, $04, $04 ; id 0
    db $fd, $00, $40, $20, $82, $01, $32, $04, $08 ; id 1
    db $80 ; end

; list for entry $82 of MapWarpTable; 9 record(s), then $80 (E-0157)
MapWarps82::
    db $fe, $00, $01, $03, $81, $00, $10, $04, $03 ; id 0
    db $fd, $00, $60, $60, $83, $00, $10, $06, $06 ; id 1
    db $fd, $10, $30, $60, $83, $01, $10, $03, $06 ; id 2
    db $fd, $20, $40, $60, $83, $02, $10, $04, $06 ; id 3
    db $fd, $01, $70, $20, $83, $00, $11, $07, $02 ; id 4
    db $fd, $01, $40, $60, $83, $00, $11, $04, $06 ; id 5
    db $fd, $21, $20, $20, $83, $02, $11, $02, $02 ; id 6
    db $fd, $22, $70, $60, $83, $02, $12, $07, $06 ; id 7
    db $fd, $02, $20, $50, $84, $00, $10, $02, $05 ; id 8
    db $80 ; end

; list for entry $83 of MapWarpTable; 7 record(s), then $80 (E-0157)
MapWarps83::
    db $fd, $00, $60, $60, $82, $00, $10, $06, $06 ; id 0
    db $fd, $10, $30, $60, $82, $01, $10, $03, $06 ; id 1
    db $fd, $20, $40, $60, $82, $02, $10, $04, $06 ; id 2
    db $fd, $01, $70, $20, $82, $00, $11, $07, $02 ; id 3
    db $fd, $01, $40, $60, $82, $00, $11, $04, $06 ; id 4
    db $fd, $21, $20, $20, $82, $02, $11, $02, $02 ; id 5
    db $fd, $22, $70, $60, $82, $02, $12, $07, $06 ; id 6
    db $80 ; end

; list for entry $84 of MapWarpTable; 1 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarps84::
    db $fd, $00, $20, $50, $82, $00, $12, $02, $05 ; id 0
    db $80 ; end

; list for entry $85 of MapWarpTable; 3 record(s), then $80 (E-0157)
MapWarps85::
    db $fe, $00, $00, $02, $70, $01, $1b, $04, $04 ; id 0
    db $fd, $00, $20, $30, $86, $00, $10, $02, $03 ; id 1
    db $fd, $10, $80, $50, $86, $01, $10, $08, $05 ; id 2
    db $80 ; end

; list for entry $86 of MapWarpTable; 4 record(s), then $80 (E-0157)
MapWarps86::
    db $fd, $00, $20, $30, $85, $00, $10, $02, $03 ; id 0
    db $fd, $10, $80, $50, $85, $01, $10, $08, $05 ; id 1
    db $fd, $10, $60, $20, $87, $01, $10, $06, $02 ; id 2
    db $fd, $10, $80, $30, $87, $01, $10, $08, $03 ; id 3
    db $80 ; end

; list for entry $87 of MapWarpTable; 4 record(s), then $80 (E-0157)
MapWarps87::
    db $fd, $10, $60, $20, $86, $01, $10, $06, $02 ; id 0
    db $fd, $10, $80, $30, $86, $01, $10, $08, $03 ; id 1
    db $fd, $10, $80, $50, $88, $01, $10, $08, $05 ; id 2
    db $fd, $01, $20, $60, $88, $00, $11, $02, $06 ; id 3
    db $80 ; end

; list for entry $88 of MapWarpTable; 2 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarps88::
    db $fd, $10, $80, $50, $87, $01, $10, $08, $05 ; id 0
    db $fd, $01, $20, $60, $87, $00, $11, $02, $06 ; id 1
    db $80 ; end

; list for entry $89 of MapWarpTable; 2 record(s), then $80 (E-0157)
MapWarps89::
    db $fe, $00, $00, $02, $71, $01, $10, $04, $00 ; id 0
    db $fd, $01, $50, $50, $73, $00, $31, $05, $08 ; id 1
    db $80 ; end

; list for entry $8A of MapWarpTable; 3 record(s), then $80 (E-0157)
MapWarps8A::
    db $fe, $00, $00, $01, $70, $0b, $1a, $04, $04 ; id 0
    db $fd, $00, $40, $40, $8b, $01, $33, $04, $08 ; id 1
    db $fd, $00, $50, $40, $8b, $01, $33, $05, $08 ; id 2
    db $80 ; end

; list for entry $8B of MapWarpTable; 4 record(s), then $80 (E-0157)
MapWarps8B::
    db $ff, $00, $01, $04, $8a, $80, $10, $00, $c0 ; id 0
    db $fd, $01, $20, $60, $8c, $00, $11, $02, $06 ; id 1
    db $fd, $21, $70, $60, $8c, $02, $11, $07, $06 ; id 2
    db $fd, $21, $60, $10, $8d, $00, $30, $04, $08 ; id 3
    db $80 ; end

; list for entry $8C of MapWarpTable; 2 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarps8C::
    db $fd, $01, $20, $60, $8b, $00, $11, $02, $06 ; id 0
    db $fd, $21, $70, $60, $8b, $02, $11, $07, $06 ; id 1
    db $80 ; end

; list for entry $8D of MapWarpTable; 3 record(s), then $80 (E-0157)
MapWarps8D::
    db $fe, $00, $00, $01, $8b, $82, $11, $06, $01 ; id 0
    db $fd, $00, $40, $10, $8e, $02, $32, $04, $08 ; id 1
    db $fd, $00, $50, $10, $8e, $02, $32, $05, $08 ; id 2
    db $80 ; end

; list for entry $8E of MapWarpTable; 5 record(s), then $80 (E-0157)
MapWarps8E::
    db $ff, $00, $02, $03, $8d, $80, $10, $00, $90 ; id 0
    db $fd, $00, $10, $10, $8f, $00, $10, $01, $07 ; id 1
    db $fd, $10, $50, $60, $90, $01, $11, $05, $06 ; id 2
    db $fd, $10, $40, $10, $91, $00, $30, $04, $08 ; id 3
    db $fd, $10, $50, $10, $91, $00, $30, $05, $08 ; id 4
    db $80 ; end

; list for entry $8F of MapWarpTable; 3 record(s), then $80 (E-0157)
MapWarps8F::
    db $fd, $00, $10, $70, $8e, $00, $10, $01, $01 ; id 0
    db $fd, $00, $10, $00, $90, $00, $31, $01, $08 ; id 1
    db $fd, $00, $20, $00, $90, $00, $31, $02, $08 ; id 2
    db $80 ; end

; list for entry $90 of MapWarpTable; 2 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarps90::
    db $ff, $00, $00, $02, $8f, $80, $10, $00, $80 ; id 0
    db $fd, $11, $50, $60, $8e, $01, $10, $05, $06 ; id 1
    db $80 ; end

; list for entry $91 of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarps91::
    db $ff, $00, $00, $01, $8e, $81, $10, $00, $90 ; id 0
    db $80 ; end

; list for entry $92 of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarps92::
    db $fe, $00, $00, $01, $70, $05, $12, $04, $04 ; id 0
    db $80 ; end

; list for entry $93 of MapWarpTable; 3 record(s), then $80 (E-0157)
MapWarps93::
    db $fe, $00, $00, $01, $70, $04, $11, $04, $04 ; id 0
    db $fd, $00, $40, $20, $94, $00, $32, $04, $08 ; id 1
    db $fd, $00, $50, $20, $94, $00, $32, $05, $08 ; id 2
    db $80 ; end

; list for entry $94 of MapWarpTable; 2 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarps94::
    db $ff, $00, $00, $03, $93, $80, $10, $00, $a0 ; id 0
    db $fd, $10, $40, $40, $95, $00, $10, $04, $04 ; id 1
    db $80 ; end

; list for entry $95 of MapWarpTable; 3 record(s), then $80 (E-0157)
MapWarps95::
    db $fd, $00, $40, $40, $94, $01, $10, $04, $04 ; id 0
    db $fd, $01, $40, $40, $96, $00, $11, $04, $04 ; id 1
    db $fd, $11, $40, $40, $96, $01, $11, $04, $04 ; id 2
    db $80 ; end

; list for entry $96 of MapWarpTable; 3 record(s), then $80 (E-0157)
MapWarps96::
    db $fd, $01, $40, $40, $95, $00, $11, $04, $04 ; id 0
    db $fd, $11, $40, $40, $95, $01, $11, $04, $04 ; id 1
    db $fd, $01, $10, $70, $97, $00, $10, $01, $07 ; id 2
    db $80 ; end

; list for entry $97 of MapWarpTable; 2 record(s), then $80 (E-0157)
MapWarps97::
    db $fd, $00, $10, $70, $96, $00, $11, $01, $07 ; id 0
    db $fd, $00, $80, $70, $98, $00, $10, $08, $07 ; id 1
    db $80 ; end

; list for entry $98 of MapWarpTable; 2 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarps98::
    db $fd, $00, $80, $70, $97, $00, $10, $08, $07 ; id 0
    db $fd, $00, $80, $10, $99, $00, $10, $08, $01 ; id 1
    db $80 ; end

; list for entry $99 of MapWarpTable; 2 record(s), then $80 (E-0157)
MapWarps99::
    db $fd, $00, $80, $10, $98, $00, $10, $08, $01 ; id 0
    db $fd, $00, $10, $10, $9a, $00, $10, $01, $01 ; id 1
    db $80 ; end

; list for entry $9A of MapWarpTable; 2 record(s), then $80 (E-0157)
MapWarps9A::
    db $fd, $00, $10, $10, $99, $00, $10, $01, $01 ; id 0
    db $fd, $00, $10, $70, $9b, $00, $12, $01, $07 ; id 1
    db $80 ; end

; list for entry $9B of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarps9B::
    db $fd, $02, $10, $70, $9a, $00, $10, $01, $07 ; id 0
    db $80 ; end

; list for entry $9D of MapWarpTable; 0 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarps9D::
    db $80 ; end

; list for entry $A0 of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarpsA0::
    db $fd, $12, $40, $40, $a1, $00, $32, $04, $08 ; id 0
    db $80 ; end

; list for entry $A1 of MapWarpTable; 2 record(s), then $80 (E-0157)
MapWarpsA1::
    db $fe, $00, $00, $03, $a0, $01, $12, $04, $04 ; id 0
    db $ff, $00, $00, $ff, $a2, $01, $32, $00, $80 ; id 1
    db $80 ; end

; list for entry $A2 of MapWarpTable; 3 record(s), then $80 (E-0157)
MapWarpsA2::
    db $ff, $00, $01, $03, $a1, $00, $10, $00, $80 ; id 0
    db $fd, $10, $40, $10, $a3, $00, $31, $04, $08 ; id 1
    db $fd, $10, $50, $10, $a3, $00, $31, $05, $08 ; id 2
    db $80 ; end

; list for entry $A3 of MapWarpTable; 1 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarpsA3::
    db $ff, $00, $00, $02, $a2, $81, $10, $00, $90 ; id 0
    db $80 ; end

; list for entry $A4 of MapWarpTable; 0 record(s), then $80 (E-0157)
MapWarpsA4::
    db $80 ; end

; list for entry $A8 of MapWarpTable; 5 record(s), then $80 (E-0157)
MapWarpsA8::
    db $fd, $24, $40, $40, $a9, $00, $31, $04, $08 ; id 0
    db $fd, $24, $50, $40, $a9, $00, $31, $04, $08 ; id 1
    db $fd, $11, $40, $40, $aa, $00, $31, $04, $08 ; id 2
    db $fd, $43, $40, $40, $ab, $00, $30, $04, $08 ; id 3
    db $fd, $51, $40, $40, $ad, $01, $33, $04, $08 ; id 4
    db $80 ; end

; list for entry $A9 of MapWarpTable; 3 record(s), then $80 (E-0157)
MapWarpsA9::
    db $fe, $01, $00, $02, $a8, $02, $14, $04, $04 ; id 0
    db $fe, $10, $02, $00, $a8, $02, $14, $04, $04 ; id 1
    db $fe, $11, $01, $02, $a8, $02, $14, $04, $04 ; id 2
    db $80 ; end

; list for entry $AA of MapWarpTable; 1 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarpsAA::
    db $fe, $01, $00, $02, $a8, $01, $11, $04, $04 ; id 0
    db $80 ; end

; list for entry $AB of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarpsAB::
    db $fe, $00, $00, $01, $a8, $04, $13, $04, $04 ; id 0
    db $80 ; end

; list for entry $AC of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarpsAC::
    db $fe, $00, $00, $01, $ae, $01, $00, $04, $00 ; id 0
    db $80 ; end

; list for entry $AD of MapWarpTable; 2 record(s), then $80 (E-0157)
MapWarpsAD::
    db $fe, $00, $01, $04, $a8, $05, $11, $04, $04 ; id 0
    db $ff, $00, $02, $ff, $ae, $02, $03, $00, $80 ; id 1
    db $80 ; end

; list for entry $AE of MapWarpTable; 2 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarpsAE::
    db $fe, $00, $01, $ff, $ac, $00, $30, $04, $08 ; id 0
    db $ff, $00, $02, $04, $ad, $02, $00, $00, $80 ; id 1
    db $80 ; end

; list for entry $AF of MapWarpTable; 0 record(s), then $80 (E-0157)
MapWarpsAF::
    db $80 ; end

; list for entry $B0 of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarpsB0::
    db $fd, $10, $40, $40, $b1, $00, $30, $04, $08 ; id 0
    db $80 ; end

; list for entry $B1 of MapWarpTable; 2 record(s), then $80 (E-0157)
MapWarpsB1::
    db $fe, $00, $00, $01, $b0, $01, $10, $04, $04 ; id 0
    db $fd, $00, $10, $30, $b3, $00, $11, $01, $03 ; id 1
    db $80 ; end

; list for entry $B3 of MapWarpTable; 2 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarpsB3::
    db $fd, $01, $10, $30, $b1, $00, $10, $01, $03 ; id 0
    db $fd, $11, $50, $40, $b4, $01, $11, $05, $04 ; id 1
    db $80 ; end

; list for entry $B4 of MapWarpTable; 2 record(s), then $80 (E-0157)
MapWarpsB4::
    db $fd, $11, $50, $40, $b3, $01, $11, $05, $04 ; id 0
    db $fd, $01, $20, $50, $b5, $00, $11, $02, $05 ; id 1
    db $80 ; end

; list for entry $B5 of MapWarpTable; 3 record(s), then $80 (E-0157)
MapWarpsB5::
    db $fd, $01, $20, $50, $b4, $00, $11, $02, $05 ; id 0
    db $fd, $11, $40, $00, $b6, $00, $30, $04, $08 ; id 1
    db $fd, $11, $50, $00, $b6, $00, $30, $04, $08 ; id 2
    db $80 ; end

; list for entry $B6 of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarpsB6::
    db $ff, $00, $00, $01, $b5, $81, $11, $00, $80 ; id 0
    db $80 ; end

; list for entry $B8 of MapWarpTable; 4 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarpsB8::
    db $fd, $43, $40, $40, $b9, $00, $31, $04, $08 ; id 0
    db $fd, $43, $50, $40, $b9, $00, $31, $04, $08 ; id 1
    db $fd, $11, $30, $50, $ba, $00, $31, $03, $08 ; id 2
    db $fd, $40, $40, $40, $bb, $00, $31, $04, $08 ; id 3
    db $80 ; end

; list for entry $B9 of MapWarpTable; 4 record(s), then $80 (E-0157)
MapWarpsB9::
    db $fe, $00, $00, $ff, $b8, $04, $13, $04, $04 ; id 0
    db $fe, $00, $00, $02, $b8, $04, $13, $04, $04 ; id 1
    db $fe, $00, $01, $02, $b8, $04, $13, $04, $04 ; id 2
    db $fd, $11, $50, $20, $bc, $00, $30, $05, $08 ; id 3
    db $80 ; end

; list for entry $BA of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarpsBA::
    db $fe, $00, $00, $02, $b8, $01, $11, $03, $05 ; id 0
    db $80 ; end

; list for entry $BB of MapWarpTable; 2 record(s), then $80 (E-0157)
MapWarpsBB::
    db $fe, $01, $00, $02, $b8, $04, $10, $04, $04 ; id 0
    db $fd, $00, $40, $00, $be, $00, $00, $04, $08 ; id 1
    db $80 ; end

; list for entry $BC of MapWarpTable; 1 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarpsBC::
    db $fe, $00, $00, $01, $b9, $81, $11, $05, $02 ; id 0
    db $80 ; end

; list for entry $BD of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarpsBD::
    db $fd, $00, $50, $70, $c4, $00, $10, $05, $07 ; id 0
    db $80 ; end

; list for entry $BE of MapWarpTable; 2 record(s), then $80 (E-0157)
MapWarpsBE::
    db $fe, $00, $00, $01, $bb, $80, $00, $04, $00 ; id 0
    db $fd, $00, $40, $30, $bf, $00, $10, $04, $03 ; id 1
    db $80 ; end

; list for entry $BF of MapWarpTable; 2 record(s), then $80 (E-0157)
MapWarpsBF::
    db $fd, $00, $40, $30, $be, $00, $10, $04, $03 ; id 0
    db $fd, $11, $50, $50, $c0, $01, $11, $05, $05 ; id 1
    db $80 ; end

; list for entry $C0 of MapWarpTable; 2 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarpsC0::
    db $fd, $11, $50, $50, $bf, $01, $11, $05, $05 ; id 0
    db $fd, $10, $70, $20, $c1, $01, $10, $07, $02 ; id 1
    db $80 ; end

; list for entry $C1 of MapWarpTable; 2 record(s), then $80 (E-0157)
MapWarpsC1::
    db $fd, $10, $70, $20, $c0, $01, $10, $07, $02 ; id 0
    db $fd, $00, $70, $20, $c2, $00, $10, $07, $02 ; id 1
    db $80 ; end

; list for entry $C2 of MapWarpTable; 2 record(s), then $80 (E-0157)
MapWarpsC2::
    db $fd, $00, $70, $20, $c1, $00, $10, $07, $02 ; id 0
    db $fd, $10, $40, $50, $c3, $01, $10, $04, $05 ; id 1
    db $80 ; end

; list for entry $C3 of MapWarpTable; 2 record(s), then $80 (E-0157)
MapWarpsC3::
    db $fd, $10, $40, $50, $c2, $01, $10, $04, $05 ; id 0
    db $fd, $00, $70, $20, $c4, $00, $10, $07, $02 ; id 1
    db $80 ; end

; list for entry $C4 of MapWarpTable; 2 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarpsC4::
    db $fd, $00, $70, $20, $c3, $00, $10, $07, $02 ; id 0
    db $fd, $00, $50, $70, $bd, $00, $10, $05, $07 ; id 1
    db $80 ; end

; list for entry $C8 of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarpsC8::
    db $fd, $00, $40, $40, $c9, $00, $31, $04, $08 ; id 0
    db $80 ; end

; list for entry $C9 of MapWarpTable; 2 record(s), then $80 (E-0157)
MapWarpsC9::
    db $fe, $00, $00, $02, $c8, $00, $10, $04, $04 ; id 0
    db $fd, $00, $40, $50, $ca, $00, $11, $04, $05 ; id 1
    db $80 ; end

; list for entry $CA of MapWarpTable; 2 record(s), then $80 (E-0157)
MapWarpsCA::
    db $fd, $01, $40, $50, $c9, $00, $10, $04, $05 ; id 0
    db $fd, $00, $40, $50, $cb, $00, $11, $04, $05 ; id 1
    db $80 ; end

; list for entry $CB of MapWarpTable; 2 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarpsCB::
    db $fd, $01, $40, $50, $ca, $00, $10, $04, $05 ; id 0
    db $fd, $00, $40, $50, $cc, $00, $11, $04, $05 ; id 1
    db $80 ; end

; list for entry $CC of MapWarpTable; 2 record(s), then $80 (E-0157)
MapWarpsCC::
    db $fd, $01, $40, $50, $cb, $00, $10, $04, $05 ; id 0
    db $fd, $00, $40, $50, $cd, $00, $11, $04, $05 ; id 1
    db $80 ; end

; list for entry $CD of MapWarpTable; 2 record(s), then $80 (E-0157)
MapWarpsCD::
    db $fd, $01, $40, $50, $cc, $00, $10, $04, $05 ; id 0
    db $fd, $00, $40, $50, $ce, $00, $11, $04, $05 ; id 1
    db $80 ; end

; list for entry $CE of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarpsCE::
    db $fd, $01, $40, $50, $cd, $00, $10, $04, $05 ; id 0
    db $80 ; end

; list for entry $D1 of MapWarpTable; 1 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarpsD1::
    db $fd, $01, $40, $40, $d2, $00, $31, $04, $08 ; id 0
    db $80 ; end

; list for entry $D2 of MapWarpTable; 2 record(s), then $80 (E-0157)
MapWarpsD2::
    db $fe, $00, $00, $02, $d1, $00, $11, $04, $04 ; id 0
    db $fd, $00, $40, $50, $d3, $00, $11, $04, $05 ; id 1
    db $80 ; end

; list for entry $D3 of MapWarpTable; 2 record(s), then $80 (E-0157)
MapWarpsD3::
    db $fd, $01, $40, $50, $d2, $00, $10, $04, $05 ; id 0
    db $fd, $00, $40, $50, $d4, $00, $11, $04, $05 ; id 1
    db $80 ; end

; list for entry $D4 of MapWarpTable; 2 record(s), then $80 (E-0157)
MapWarpsD4::
    db $fd, $01, $40, $50, $d3, $00, $10, $04, $05 ; id 0
    db $fd, $00, $40, $50, $d5, $00, $11, $04, $05 ; id 1
    db $80 ; end

; list for entry $D5 of MapWarpTable; 2 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarpsD5::
    db $fd, $01, $40, $50, $d4, $00, $10, $04, $05 ; id 0
    db $fd, $00, $40, $50, $d6, $00, $11, $04, $05 ; id 1
    db $80 ; end

; list for entry $D6 of MapWarpTable; 2 record(s), then $80 (E-0157)
MapWarpsD6::
    db $fd, $01, $40, $50, $d5, $00, $10, $04, $05 ; id 0
    db $fd, $00, $40, $50, $d7, $00, $11, $04, $05 ; id 1
    db $80 ; end

; list for entry $D7 of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarpsD7::
    db $fd, $01, $40, $50, $d6, $00, $10, $04, $05 ; id 0
    db $80 ; end

; list for entry $DA of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarpsDA::
    db $fd, $10, $40, $40, $db, $00, $31, $04, $08 ; id 0
    db $80 ; end

; list for entry $DB of MapWarpTable; 2 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarpsDB::
    db $fe, $00, $00, $02, $da, $01, $10, $04, $04 ; id 0
    db $fd, $00, $40, $50, $dc, $00, $11, $04, $05 ; id 1
    db $80 ; end

; list for entry $DC of MapWarpTable; 2 record(s), then $80 (E-0157)
MapWarpsDC::
    db $fd, $01, $40, $50, $db, $00, $10, $04, $05 ; id 0
    db $fd, $00, $40, $50, $dd, $00, $11, $04, $05 ; id 1
    db $80 ; end

; list for entry $DD of MapWarpTable; 2 record(s), then $80 (E-0157)
MapWarpsDD::
    db $fd, $01, $40, $50, $dc, $00, $10, $04, $05 ; id 0
    db $fd, $00, $40, $50, $de, $00, $11, $04, $05 ; id 1
    db $80 ; end

; list for entry $DE of MapWarpTable; 2 record(s), then $80 (E-0157)
MapWarpsDE::
    db $fd, $01, $40, $50, $dd, $00, $10, $04, $05 ; id 0
    db $fd, $00, $40, $50, $df, $00, $11, $04, $05 ; id 1
    db $80 ; end

; list for entry $DF of MapWarpTable; 2 record(s), then $80 (E-0157)
; record: facing (0-3; $FE/$FF any facing; $FD skipped), screen X/Y nibbles, player X, player Y;
; then destination map, screen and position bytes
MapWarpsDF::
    db $fd, $01, $40, $50, $de, $00, $10, $04, $05 ; id 0
    db $fd, $00, $40, $50, $e0, $00, $11, $04, $05 ; id 1
    db $80 ; end

; list for entry $E0 of MapWarpTable; 1 record(s), then $80 (E-0157)
MapWarpsE0::
    db $fd, $01, $40, $50, $df, $00, $10, $04, $05 ; id 0
    db $80 ; end
    ds $3e0, $00
