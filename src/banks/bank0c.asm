SECTION "Bank 0C", ROMX[$4000], BANK[$0C]
    db $0C

; implements script command type F6; reached through ScriptCommandF6 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommandF6)
; reads: wD780
ScriptCommandF6_Run::
Func_00C_4001:: ; address name
    ld a, [wD780]
    rst $00
    dw ScriptCommandF6_Run_Case00
    dw ScriptCommandF6_Run_Case01
    dw ScriptCommandF6_Run_Case02
    dw ScriptCommandF6_Run_Case03
    dw ScriptCommandF6_Run_Case04
    dw ScriptCommandF6_Run_Case05
    dw ScriptCommandF6_Run_Case06
    dw ScriptCommandF6_Run_Case07
    dw ScriptCommandF6_Run_Case08
    dw ScriptCommandF6_Run_Case09
    dw ScriptCommandF6_Run_Case0A
    dw ScriptCommandF6_Run_Case0B
    dw ScriptCommandF6_Run_Case0C
    dw ScriptCommandF6_Run_Case0D
    dw ScriptCommandF6_Run_Case0E
    dw ScriptCommandF6_Run_Case0F
    dw ScriptCommandF6_Run_Case10

; entry 0 of the `rst $00` table in ScriptCommandF6_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD780
; writes: wD7F0, wD780, wScriptCommandType, wScriptStartRequest
; points at: wD780
ScriptCommandF6_Run_Case00::
Jump_00C_4027:: ; address name
    ld hl, wD780
    ld bc, $0020

Jump_00C_402D::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_00C_402D
    ld a, $09
    ld [wD7F0], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 1 of the `rst $00` table in ScriptCommandF6_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hFFB9, hFFBA, rSTAT, wD780
; writes: hScrollY, hScrollX, wD799, wD79A, hFFBA, hFFB9, hFF8D, wD780
ScriptCommandF6_Run_Case01::
Jump_00C_404A:: ; address name
    call ScriptCommandF6_Run_Shared06
    xor a, a
    ldh [hScrollY], a
    ldh [hScrollX], a
    ldh a, [hFFB9]
    ld [wD799], a
    ldh a, [hFFBA]
    ld [wD79A], a
    ld a, $90
    ldh [hFFBA], a
    ld a, $01
    ldh [hFFB9], a
    ld a, $0F
    ldh [hFF8D], a
    ld hl, vTiles0
    ld bc, $0800

Jump_00C_406E::
    di

Jump_00C_406F::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_00C_406F
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_00C_406E
    call ScriptCommandF6_Run_Shared05
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

; entry 2 of the `rst $00` table in ScriptCommandF6_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD780
; writes: wD780
ScriptCommandF6_Run_Case02::
Jump_00C_4087:: ; address name
    call ClearStringWindowAt2020
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

; entry 3 of the `rst $00` table in ScriptCommandF6_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD787, wD786, wD780
; writes: wC445, wD780
; points at: wC364
ScriptCommandF6_Run_Case03::
Jump_00C_4092:: ; address name
    ld de, Data_00C_56D9
    ld hl, wC364
    ld bc, $090D
    call CopyRectTo20ByteRows_Bank0C
    ld a, [wD787]
    and a, a
    jr z, Jump_00C_40A9
    ld a, $C3
    ld [wC445], a

Jump_00C_40A9::
    ld a, [wD786]
    ld hl, Data_00C_58FE
    ld b, $BB
    call StoreBAtWordTableEntry_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    ld a, [wD786]
    ld hl, Data_00C_58FE
    ld b, $C3
    call StoreBAtWordTableEntry_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call DrawScreenBufferRect_Bank0C
    call ScriptCommandF6_Run_Shared02
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

; entry 4 of the `rst $00` table in ScriptCommandF6_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD787, wD7F5, wD780
; writes: wD7F1, wD7F2, wD7F3, wD7F4, wD780, wC52D, wC52E, wC52F, ...
; points at: wC7FC, wD78E
ScriptCommandF6_Run_Case04::
Jump_00C_40E6:: ; address name
    call BGMapAddressAtScroll_Bank0C
    ld de, $0182
    add hl, de
    ld a, [wD787]
    add a, $E1
    ld b, a
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl+], a
    ei
    ld c, $00

Jump_00C_40FC::
    ld a, [wD787]
    add a, a
    ld b, a
    add a, a
    add a, b
    ld b, a
    ld a, c
    add a, b
    add a, a
    ld hl, Data_00C_5916
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld b, $00

Jump_00C_4114::
    ld a, d
    cp a, $FF
    jp z, Jump_00C_41AA
    push de
    push bc
    ld a, e
    ld [wD7F1], a
    ld a, d
    ld [wD7F2], a
    ld de, wC7FC
    ld a, e
    ld [wD7F3], a
    ld a, d
    ld [wD7F4], a
    farcall TestBitInFieldAtWD7F3
    ld a, [wD7F5]
    cp a, $FF
    jr nz, Jump_00C_4141

Jump_00C_413C::
    pop bc
    inc b
    push bc
    jr Jump_00C_4159

Jump_00C_4141::
    pop bc
    pop de
    push de
    push bc
    ld a, e
    ld [wSpeciesIdLo], a
    ld a, d
    ld [wSpeciesIdHi], a
    farcall TestSpeciesFlag
    ld a, c
    and a, a
    jr z, Jump_00C_4159
    jr Jump_00C_413C

Jump_00C_4159::
    pop bc
    pop de
    inc de
    ld a, [wD787]
    add a, a
    ld l, a
    add a, a
    add a, l
    ld l, a
    ld a, c
    add a, l
    add a, a
    ld hl, Data_00C_592E
    add_a_to_hl
    push de
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    pop de
    ld a, d
    cp a, h
    jr c, Jump_00C_4114
    jr nz, Jump_00C_417F
    ld a, e
    cp a, l
    jr c, Jump_00C_4114

Jump_00C_417F::
    push bc
    ld a, [wD787]
    add a, a
    ld b, a
    add a, a
    add a, b
    ld hl, wD78E
    add_a_to_hl
    pop bc
    ld a, c
    add_a_to_hl
    ld a, b
    ld [hl], a
    ld a, [wD787]
    and a, a
    jr z, Jump_00C_41A2
    ld b, $05
    jr Jump_00C_41A4

Jump_00C_41A2::
    ld b, $06

Jump_00C_41A4::
    inc c
    ld a, c
    cp a, b
    jp c, Jump_00C_40FC

Jump_00C_41AA::
    xor a, a
    ld [wD7F1], a
    call ScriptCommandF6_Run_Shared04
    ld a, $01
    ld [wD7F1], a
    call ScriptCommandF6_Run_Shared04
    ld a, [wD780]
    inc a
    ld [wD780], a
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ret

; entry 5 of the `rst $00` table in ScriptCommandF6_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wD780, wD787, wD786
; writes: wD780, wTwoChoiceCursor, hFFB9, hFFBA, wScriptCommandType, wScriptStartRequest, wC456, wD786, ...
; points at: wD78E
ScriptCommandF6_Run_Case05::
Jump_00C_41D7:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 4, a
    jr nz, Jump_00C_41FB
    bit 5, a
    jr nz, Jump_00C_4229
    bit 6, a
    jr nz, Jump_00C_4236
    bit 7, a
    jr nz, Jump_00C_425C
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, Jump_00C_4278
    bit 1, a
    jp nz, Jump_00C_42D3
    call ScriptCommandF6_Run_Case05_Sub01
    ret

Jump_00C_41FB::
    ld a, [wD787]
    cp a, $01
    jr c, Jump_00C_4205
    xor a, a
    jr Jump_00C_4206

Jump_00C_4205::
    inc a

Jump_00C_4206::
    ld [wD787], a
    cp a, $01
    jr c, Jump_00C_4218
    ld a, [wD786]
    cp a, $05
    jr c, Jump_00C_4218
    dec a
    ld [wD786], a

Jump_00C_4218::
    call ScriptCommandF6_Run_Case05_Sub02
    ld a, $69
    call QueueSoundEffect
    ld a, [wD780]
    sub a, $03
    ld [wD780], a
    ret

Jump_00C_4229::
    ld a, [wD787]
    and a, a
    jr nz, Jump_00C_4233
    ld a, $01
    jr Jump_00C_4206

Jump_00C_4233::
    dec a
    jr Jump_00C_4206

Jump_00C_4236::
    call ScriptCommandF6_Run_Case05_Sub03
    ld a, [wD787]
    ld de, Data_00C_56D7
    add a, e
    ld e, a
    jr nc, Jump_00C_4244
    inc d

Jump_00C_4244::
    ld a, [de]
    ld b, a
    ld a, [wD786]
    and a, a
    jr nz, Jump_00C_424F
    ld a, b
    jr Jump_00C_4250

Jump_00C_424F::
    dec a

Jump_00C_4250::
    ld [wD786], a
    call ScriptCommandF6_Run_Case05_Sub02
    ld a, $69
    call QueueSoundEffect
    ret

Jump_00C_425C::
    call ScriptCommandF6_Run_Case05_Sub03
    ld a, [wD787]
    ld de, Data_00C_56D7
    add a, e
    ld e, a
    jr nc, Jump_00C_426A
    inc d

Jump_00C_426A::
    ld a, [de]
    ld b, a
    ld a, [wD786]
    cp a, b
    jr c, Jump_00C_4275
    xor a, a
    jr Jump_00C_4250

Jump_00C_4275::
    inc a
    jr Jump_00C_4250

Jump_00C_4278::
    ld a, [wD787]
    add a, a
    ld b, a
    add a, a
    add a, b
    ld b, a
    ld a, [wD786]
    add a, b
    ld hl, wD78E
    add_a_to_hl
    ld a, [hl]
    and a, a
    jr nz, Jump_00C_42A2
    call ScriptCommandF6_Run_Case05_Sub04
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_00C_42A2::
    ld a, $69
    call QueueSoundEffect
    call ScriptCommandF6_Run_Case05_Sub04
    ld a, [wD786]
    ld hl, Data_00C_58FE
    ld b, $BC
    call StoreBAtWordTableEntry_Bank0C
    ld a, [wD787]
    add a, $E1
    ld [wC456], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wD780]
    add a, $04
    ld [wD780], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_00C_42D3::
    ld a, [wD780]
    inc a
    ld [wD780], a
    ld a, $02
    ld [wTwoChoiceCursor], a
    ld a, $02
    ldh [hFFB9], a
    xor a, a
    ldh [hFFBA], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; only called from ScriptCommandF6_Run_Case05 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandF6_Run_Case05)
; reads: wJoypadRepeatTimer, wD785, wD786
; writes: wD785
ScriptCommandF6_Run_Case05_Sub01::
Func_00C_42F0:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, ScriptCommandF6_Run_Case05_Sub02
    ld a, [wD785]
    inc a
    ld [wD785], a
    cp a, $10
    jr c, ScriptCommandF6_Run_Case05_Sub02
    cp a, $18
    jr c, ScriptCommandF6_Run_Case05_Sub03
    xor a, a
    ld [wD785], a

; only called from ScriptCommandF6_Run_Case05 (E-0047)
; 2 call sites from 1 routine (e.g. ScriptCommandF6_Run_Case05)
; reads: wD786
ScriptCommandF6_Run_Case05_Sub02::
Func_00C_430A:: ; address name
    ld b, $BB
    jr Jump_00C_4314

; only called from ScriptCommandF6_Run_Case05 (E-0047)
; 2 call sites from 1 routine (e.g. ScriptCommandF6_Run_Case05)
; reads: wD786
ScriptCommandF6_Run_Case05_Sub03::
Func_00C_430E:: ; address name
    ld b, $C3
    jr Jump_00C_4314

; only called from ScriptCommandF6_Run_Case05 (E-0047)
; 2 call sites from 1 routine (e.g. ScriptCommandF6_Run_Case05)
; reads: wD786
ScriptCommandF6_Run_Case05_Sub04::
Func_00C_4312:: ; address name
    ld b, $BC

Jump_00C_4314::
    ld a, [wD786]
    add a, a
    ld hl, Data_00C_4331
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank0C
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

Data_00C_4331:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $21, $00, $61, $00, $A1, $00, $E1, $00, $21, $01, $61, $01

; entry 6 of the `rst $00` table in ScriptCommandF6_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD780
; writes: hMapId, wC527, wD780
ScriptCommandF6_Run_Case06::
Jump_00C_433D:: ; address name
    call ScriptCommandF6_Run_Shared06
    ld a, $11
    ldh [hMapId], a
    call Func_000_1C0C
    farcall Func_004_4AA8
    ld a, $7F
    ld [wC527], a
    farcall Func_069_4001
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

; entry 7 of the `rst $00` table in ScriptCommandF6_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wD799, wD79A, wD780
; writes: hFFB9, hFFBA, hFF8D, wD780, wC52D, wC52E, wC52F, wC530, ...
; points at: wC364, wScreenTileBuffer, wD1CC, wD000
ScriptCommandF6_Run_Case07::
Jump_00C_4360:: ; address name
    ld hl, wC364
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank0C
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_00C_437E
    ld hl, wD1CC
    ld de, wD000
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank0C

Jump_00C_437E::
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call DrawScreenBufferRect_Bank0C
    ld a, [wD799]
    ldh [hFFB9], a
    ld a, [wD79A]
    ldh [hFFBA], a
    xor a, a
    ldh [hFF8D], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 8 of the `rst $00` table in ScriptCommandF6_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wD7F0, wScriptCommandType, wScriptStartRequest
; points at: wD780, wC130
ScriptCommandF6_Run_Case08::
Jump_00C_43CE:: ; address name
    ld hl, $2940
    ld de, vTiles1 + $500
    call CopyTileBytesToVRAM_Bank0C
    call ScriptCommandF6_Run_Case08_Sub01
    call ScriptCommandF6_Run_Case08_Sub01
    call ScriptCommandF6_Run_Case08_Sub01
    ld hl, $2940
    call CopyTileBytesToVRAM_Bank0C
    ld hl, $2940
    call CopyTileBytesToVRAM_Bank0C
    farcall DrawRecordListNameTiles_Bank1D
    farcall LoadTilesForPartyRecords
    xor a, a
    ld [wD7F0], a
    ld hl, wD780
    ld bc, $0020

Jump_00C_4402::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_00C_4402
    ld hl, wC130
    ld b, $10

Jump_00C_440E::
    ld a, $F0
    ld [hl+], a
    dec b
    jr nz, Jump_00C_440E
    farcall WritePlayerNameWithFlag0SuffixToWC130
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; only called from ScriptCommandF6_Run_Case08 (E-0047)
; 3 call sites from 1 routine (e.g. ScriptCommandF6_Run_Case08)
ScriptCommandF6_Run_Case08_Sub01::
Func_00C_4424:: ; address name
    ld hl, $2940
    call CopyTileBytesToVRAM_Bank0C
    ld hl, $2940
    call CopyTileBytesToVRAM_Bank0C
    ld hl, $2940
    call CopyTileBytesToVRAM_Bank0C
    ld hl, $2940
    call CopyTileBytesToVRAM_Bank0C
    ret

; entry 9 of the `rst $00` table in ScriptCommandF6_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD780
; writes: wD780
ScriptCommandF6_Run_Case09::
Jump_00C_443D:: ; address name
    call ClearStringWindowAt2200
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

; entry 10 of the `rst $00` table in ScriptCommandF6_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD78A, wD780
; writes: wC465, wD780
; points at: wC36C
ScriptCommandF6_Run_Case0A::
Jump_00C_4448:: ; address name
    ld de, Data_00C_574E
    ld hl, wC36C
    ld bc, $0C0D
    call CopyRectTo20ByteRows_Bank0C
    call GridIndexFromWD786WD787
    ld de, Data_00C_5944
    add a, e
    ld e, a
    jr nc, Jump_00C_445F
    inc d

Jump_00C_445F::
    ld a, [de]
    add a, $E1
    ld [wC465], a
    ld a, [wD78A]
    ld hl, Data_00C_590A
    ld b, $BB
    call StoreBAtWordTableEntry_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    ld a, [wD78A]
    ld hl, Data_00C_590A
    ld b, $C3
    call StoreBAtWordTableEntry_Bank0C
    call ScriptCommandF6_Run_Shared01
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

; entry 11 of the `rst $00` table in ScriptCommandF6_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD780
; writes: wD780
ScriptCommandF6_Run_Case0B::
Jump_00C_4492:: ; address name
    call ScriptCommandF6_Run_Shared03
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

; entry 12 of the `rst $00` table in ScriptCommandF6_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wD780, wD78A, wD78B
; writes: wD780, wTwoChoiceCursor, wD78A, wD78B, wScriptCommandType, wScriptStartRequest
ScriptCommandF6_Run_Case0C::
Jump_00C_449D:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 4, a
    jr nz, Jump_00C_44C3
    bit 5, a
    jr nz, Jump_00C_451C
    bit 6, a
    jp nz, Jump_00C_4533
    bit 7, a
    jp nz, Jump_00C_4550
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, Jump_00C_4563
    bit 1, a
    jp nz, Jump_00C_459F
    call ScriptCommandF6_Run_Case0C_Sub01
    ret

Jump_00C_44C3::
    call GridIndexFromWD786WD787
    ld de, Data_00C_5944
    add a, e
    ld e, a
    jr nc, Jump_00C_44CE
    inc d

Jump_00C_44CE::
    ld a, [de]
    ld b, a
    ld a, [wD78B]
    cp a, b
    jr c, Jump_00C_44D9
    xor a, a
    jr Jump_00C_44DA

Jump_00C_44D9::
    inc a

Jump_00C_44DA::
    ld [wD78B], a
    push af
    call GridIndexFromWD786WD787
    ld de, Data_00C_5944
    add a, e
    ld e, a
    jr nc, Jump_00C_44E9
    inc d

Jump_00C_44E9::
    ld a, [de]
    ld b, a
    pop af
    cp a, b
    jr c, Jump_00C_450B
    call ReadGridCellByteForWD786WD787
    ld b, a
    ld a, [wD78A]
    cp a, b
    jr c, Jump_00C_450B
    ld a, b
    ld [wD78A], a
    ld a, [wD780]
    sub a, $03
    ld [wD780], a
    ld a, $69
    call QueueSoundEffect
    ret

Jump_00C_450B::
    call ScriptCommandF6_Run_Case0C_Sub02
    ld a, [wD780]
    sub a, $03
    ld [wD780], a
    ld a, $69
    call QueueSoundEffect
    ret

Jump_00C_451C::
    ld a, [wD78B]
    and a, a
    jr nz, Jump_00C_4530
    call GridIndexFromWD786WD787
    ld de, Data_00C_5944
    add a, e
    ld e, a
    jr nc, Jump_00C_452D
    inc d

Jump_00C_452D::
    ld a, [de]
    jr Jump_00C_44DA

Jump_00C_4530::
    dec a
    jr Jump_00C_44DA

Jump_00C_4533::
    call ScriptCommandF6_Run_Case0C_Sub03
    call ReadGridCellByteForWD786WD787
    ld b, a
    ld a, [wD78A]
    and a, a
    jr nz, Jump_00C_4543
    ld a, b
    jr Jump_00C_4544

Jump_00C_4543::
    dec a

Jump_00C_4544::
    ld [wD78A], a
    call ScriptCommandF6_Run_Case0C_Sub02
    ld a, $69
    call QueueSoundEffect
    ret

Jump_00C_4550::
    call ScriptCommandF6_Run_Case0C_Sub03
    call ReadGridCellByteForWD786WD787
    ld b, a
    ld a, [wD78A]
    cp a, b
    jr c, Jump_00C_4560
    xor a, a
    jr Jump_00C_4544

Jump_00C_4560::
    inc a
    jr Jump_00C_4544

Jump_00C_4563::
    call GridIndexFromWD786WD787
    add a, a
    ld de, Data_00C_5916
    add a, e
    ld e, a
    jr nc, Jump_00C_456F
    inc d

Jump_00C_456F::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    push hl
    call GridIndexFromWD78AWD78B
    pop hl
    add_a_to_hl
    call ScriptCommandF6_Run_Shared08
    and a, a
    jr z, Jump_00C_459B
    ld a, $69
    call QueueSoundEffect
    ld a, [wD780]
    add a, $03
    ld [wD780], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_00C_459B::
    call ScriptCommandF6_Run_Case0C_Sub02
    ret

Jump_00C_459F::
    ld a, [wD780]
    inc a
    ld [wD780], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wD78A], a
    ld [wD78B], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; only called from ScriptCommandF6_Run_Case0C (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandF6_Run_Case0C)
; reads: wJoypadRepeatTimer, wD789, wD78A
; writes: wD789
ScriptCommandF6_Run_Case0C_Sub01::
Func_00C_45BC:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, ScriptCommandF6_Run_Case0C_Sub02
    ld a, [wD789]
    inc a
    ld [wD789], a
    cp a, $10
    jr c, ScriptCommandF6_Run_Case0C_Sub02
    cp a, $18
    jr c, ScriptCommandF6_Run_Case0C_Sub03
    xor a, a
    ld [wD789], a

; only called from ScriptCommandF6_Run_Case0C (E-0047)
; 3 call sites from 1 routine (e.g. ScriptCommandF6_Run_Case0C)
; reads: wD78A
ScriptCommandF6_Run_Case0C_Sub02::
Func_00C_45D6:: ; address name
    ld b, $BB
    jr Jump_00C_45E0

; only called from ScriptCommandF6_Run_Case0C (E-0047)
; 2 call sites from 1 routine (e.g. ScriptCommandF6_Run_Case0C)
; reads: wD78A
ScriptCommandF6_Run_Case0C_Sub03::
Func_00C_45DA:: ; address name
    ld b, $C3
    jr Jump_00C_45E0
    db $06, $BC

Jump_00C_45E0::
    ld a, [wD78A]
    add a, a
    ld hl, Data_00C_45FD
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank0C
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

Data_00C_45FD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $29, $00, $69, $00, $A9, $00, $E9, $00, $29, $01, $69, $01

; entry 13 of the `rst $00` table in ScriptCommandF6_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD780
; writes: wD7F1, wD780, wC52D, wC52E, wC52F, wC530, wScriptCommandType, wScriptStartRequest
; points at: wC36C
ScriptCommandF6_Run_Case0D::
Jump_00C_4609:: ; address name
    ld de, Data_00C_57EA
    ld hl, wC36C
    ld bc, $0C0D
    call CopyRectTo20ByteRows_Bank0C
    ld a, $01
    ld [wD7F1], a
    call ScriptCommandF6_Run_Shared04
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    ld a, [wD780]
    inc a
    ld [wD780], a
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 14 of the `rst $00` table in ScriptCommandF6_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD786
; writes: wD780, wScriptCommandType, wScriptStartRequest
ScriptCommandF6_Run_Case0E::
Jump_00C_4650:: ; address name
    ld a, [wD786]
    ld hl, Data_00C_58FE
    ld b, $C3
    call StoreBAtWordTableEntry_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    ld a, $05
    ld [wD780], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 15 of the `rst $00` table in ScriptCommandF6_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD780
; writes: wD780
ScriptCommandF6_Run_Case0F::
Jump_00C_4676:: ; address name
    call ScriptCommandF6_Run_Shared06
    call ScriptCommandF6_Run_Shared05
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

; entry 16 of the `rst $00` table in ScriptCommandF6_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
ScriptCommandF6_Run_Case10::
Jump_00C_4684:: ; address name
    ld a, [wD781]
    rst $00
    dw ScriptCommandF6_Run_Case10_Case00
    dw ScriptCommandF6_Run_Case10_Case01
    dw ScriptCommandF6_Run_Case10_Case02
    dw ScriptCommandF6_Run_Case10_Case03
    dw ScriptCommandF6_Run_Case10_Case04
    dw ScriptCommandF6_Run_Case10_Case05
    dw ScriptCommandF6_Run_Case10_Case06
    dw ScriptCommandF6_Run_Case10_Case07
    dw ScriptCommandF6_Run_Case10_Case08
    dw ScriptCommandF6_Run_Case10_Case09
    dw ScriptCommandF6_Run_Case10_Case0A
    dw ScriptCommandF6_Run_Case10_Case0B
    dw ScriptCommandF6_Run_Case10_Case0C
    dw ScriptCommandF6_Run_Case10_Case0D

; entry 0 of the `rst $00` table in ScriptCommandF6_Run_Case10
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wC52D, wC52E, wC52F, wC530, wD781, wD782
ScriptCommandF6_Run_Case10_Case00::
Jump_00C_46A4:: ; address name
    call ScriptCommandF6_Run_Shared07
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ld hl, Data_00C_4718
    ld de, vTiles2 + $610
    call CopyTileBytesToVRAM_Bank0C
    call CopyTileBytesToVRAM_Bank0C
    call CopyTileBytesToVRAM_Bank0C
    call CopyTileBytesToVRAM_Bank0C
    call CopyTileBytesToVRAM_Bank0C
    call CopyTileBytesToVRAM_Bank0C
    ld de, Data_01F_41D0
    ld hl, vTiles2 + $7C0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4170
    ld hl, vTiles2 + $7D0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4160
    ld hl, vTiles2 + $7E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4110
    ld hl, vTiles2 + $7F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wD782], a
    ret

Data_00C_4718:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $030718, $60

; entry 1 of the `rst $00` table in ScriptCommandF6_Run_Case10
; no direct call (reached through a table, a jump or a vector)
; reads: wD782, wIsCGB, wD781
; writes: wC52D, wC52E, wC52F, wC530, rSVBK, wC526, wD781, wD782
; points at: wC364, wC300, wD1CC, wD168, wC381, wC3BD, wC3E5, wC40D, ...
ScriptCommandF6_Run_Case10_Case01::
Jump_00C_4778:: ; address name
    ld a, [wD782]
    and a, a
    jr nz, Jump_00C_47E9
    ld hl, vTiles1 + $220
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ld de, Data_0F1_5C14
    ld hl, vTiles1
    ld b, $F1
    call DecompressToVRAM
    ld de, Data_0F1_5D44
    ld hl, wC364
    ld b, $F1
    call DecompressToVRAM
    ld de, Data_0F1_5D9C
    ld hl, wC300
    ld b, $F1
    call DecompressToVRAM
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_00C_47E9
    ld a, $02
    ldh [rSVBK], a
    ld de, Data_0F1_5DBC
    ld hl, wD1CC
    ld b, $F1
    call DecompressToVRAM
    ld de, Data_0F1_5DEE
    ld hl, wD168
    ld b, $F1
    call DecompressToVRAM
    xor a, a
    ldh [rSVBK], a
    farcall LoadBGPalettesFrom5E04
    ld a, $7F
    ld [wC526], a
    call UploadBGPalettes

Jump_00C_47E9::
    ld de, Data_00C_48AB
    ld hl, wC381
    ld bc, $0A01
    call CopyRectTo20ByteRows_Bank0C
    ld de, Data_00C_48B5
    ld hl, wC3BD
    ld bc, $0A01
    call CopyRectTo20ByteRows_Bank0C
    ld de, Data_00C_48BF
    ld hl, wC3E5
    ld bc, $0A01
    call CopyRectTo20ByteRows_Bank0C
    ld de, Data_00C_48C9
    ld hl, wC40D
    ld bc, $0901
    call CopyRectTo20ByteRows_Bank0C
    ld de, Data_00C_48D2
    ld hl, wC435
    ld bc, $0901
    call CopyRectTo20ByteRows_Bank0C
    ld de, Data_00C_48DB
    ld hl, wC45D
    ld bc, $0901
    call CopyRectTo20ByteRows_Bank0C
    ld de, Data_00C_48E4
    ld hl, wC315
    ld bc, $1201
    call CopyRectTo20ByteRows_Bank0C
    ld de, Data_00C_48F6
    ld hl, wC33D
    ld bc, $1201
    call CopyRectTo20ByteRows_Bank0C
    call ScriptCommandF6_Run_Case10_Case01_Sub01
    ld de, wD79C
    ld hl, wC408
    ld bc, $0201
    call CopyRectTo20ByteRows_Bank0C
    call ScriptCommandF6_Run_Case10_Case01_Sub02
    ld de, wD79C
    ld hl, wC430
    ld bc, $0401
    call CopyRectTo20ByteRows_Bank0C
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_00C_4883
    ld a, $02
    ldh [rSVBK], a
    ld hl, wD298
    ld a, $02
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    xor a, a
    ldh [rSVBK], a

Jump_00C_4883::
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call DrawScreenBufferRect_Bank0C
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wD782], a
    ret

Data_00C_48AB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2F, $26, $27, $28, $29, $2A, $2B, $2C, $2D, $2E

Data_00C_48B5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $42, $30, $31, $32, $33, $34, $35, $36, $37, $38

Data_00C_48BF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $43, $39, $3A, $3B, $3C, $3D, $3E, $3F, $40, $41

Data_00C_48C9:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $44, $45, $46, $47, $48, $49, $4A, $4B, $4C

Data_00C_48D2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $4D, $4E, $4F, $50, $51, $52, $53, $54, $55

Data_00C_48DB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $56, $57, $58, $59, $5A, $5B, $5C, $5D, $5E

Data_00C_48E4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A2, $A3, $A4, $A5, $A6, $A7, $A8, $A9, $AA, $AB, $AC, $AD, $AE, $AF, $B0, $B1
    db $B2, $B3

Data_00C_48F6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B4, $B5, $B6, $B7, $B8, $B9, $BA, $BB, $BC, $BD, $BE, $BF, $C0, $C1, $C2, $C3
    db $C4, $C5, $7E, $7F

; entry 2 of the `rst $00` table in ScriptCommandF6_Run_Case10
; no direct call (reached through a table, a jump or a vector)
; reads: wD782, wIsCGB, wD781
; writes: wD7F5, wD7F6, wD7F1, wD7F2, wD7F3, wD7F4, wD7F7, wD782, ...
ScriptCommandF6_Run_Case10_Case02::
Jump_00C_490A:: ; address name
    ld a, [wD782]
    and a, a
    jp nz, Jump_00C_4957
    call BGMapAddressAtScroll_Bank0C
    ld de, $0021
    add hl, de
    ld a, h
    ld [wD7F5], a
    ld a, l
    ld [wD7F6], a
    ld de, Data_00C_651B
    ld a, d
    ld [wD7F1], a
    ld a, e
    ld [wD7F2], a
    ld a, $06
    ld [wD7F3], a
    ld a, $06
    ld [wD7F4], a
    ld a, $00
    ld [wD7F7], a
    farcall DrawTileRectFromWD7F1Params
    call GridCellAddressFromWD786AndWD78A
    ld e, l
    ld d, h
    push de
    ld hl, vTiles2 + $20
    ld c, $04
    call LoadMonsterPicture
    pop de
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_00C_4957::
    call GridCellAddressFromWD786AndWD78A
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_00C_497A
    ld e, l
    ld d, h
    push de
    ld a, $7F
    ld [wC526], a
    call UploadBGPalettes
    ld a, $04
    ldh [hFFC6], a
    call BGMapAddressAtScroll_Bank0C
    ld de, $0021
    add hl, de
    pop de
    call LoadMonsterPictureAttributes

Jump_00C_497A::
    call BGMapAddressAtScroll_Bank0C
    ld de, $0021
    add hl, de
    ld a, h
    ld [wD7F5], a
    ld a, l
    ld [wD7F6], a
    ld de, Data_00C_64D3
    ld a, d
    ld [wD7F1], a
    ld a, e
    ld [wD7F2], a
    ld a, $06
    ld [wD7F3], a
    ld a, $06
    ld [wD7F4], a
    ld a, $01
    ld [wD7F7], a
    farcall DrawTileRectFromWD7F1Params
    xor a, a
    ld [wD782], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 3 of the `rst $00` table in ScriptCommandF6_Run_Case10
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD7F1, wD7F2, wD7F3, wD7F4, wD7F5, wD781
ScriptCommandF6_Run_Case10_Case03::
Jump_00C_49B5:: ; address name
    call GridCellAddressFromWD786AndWD78A
    ld a, l
    ld [wD7F1], a
    ld a, h
    ld [wD7F2], a
    xor a, a
    ld [wD7F3], a
    ld [wD7F4], a
    ld a, $80
    ld [wD7F5], a
    farcall DecompressGraphicsWD7F1ToWD7F4
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 4 of the `rst $00` table in ScriptCommandF6_Run_Case10
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wStringCategory, wStringIndex, wC52D, wC52E, wC52F, wC530, wD09D, wD09E, ...
; points at: wD7F5
ScriptCommandF6_Run_Case10_Case04::
Jump_00C_49DA:: ; address name
    call DrawThreeMetaSpritePartsFor5050
    call GridCellAddressFromWD786AndWD78A
    ld a, h
    add a, $02
    ld [wStringCategory], a
    ld a, l
    ld [wStringIndex], a
    ld hl, vTiles2 + $260
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0901
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    farcall ShowString_Bank08
    call GridIndexFromWD786WD787
    and a, $0F
    ld [wD09D], a
    ld a, $2F
    ld [wD09E], a
    farcall LoadFamilyIconTileForWD09D
    call GridIndexFromWD786WD787
    ld [wStringIndex], a
    ld a, $02
    ld [wStringCategory], a
    ld hl, vTiles2 + $670
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0701
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    farcall ShowString_Bank0B
    call GridCellAddressFromWD786AndWD78A
    ld a, l
    ld [wD7F1], a
    ld a, h
    ld [wD7F2], a
    farcall LoadSpeciesBytes8To10ToWD7F5
    farcall ScriptCommandF6_Run_Case10_Case04_Sub01
    ld a, $04
    ld [wStringCategory], a
    ld hl, wD7F5
    ld c, $00

Jump_00C_4A61::
    push hl
    push bc
    ld a, [hl]
    ld [wStringIndex], a
    ld a, c
    add a, a
    ld de, Data_00C_4AA0
    add a, e
    ld e, a
    jr nc, Jump_00C_4A71
    inc d

Jump_00C_4A71::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0901
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    farcall ShowString_Bank08
    pop bc
    pop hl
    inc hl
    inc c
    ld a, c
    cp a, $03
    jr c, Jump_00C_4A61
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Data_00C_4AA0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $40, $94, $D0, $94, $60, $95

; entry 5 of the `rst $00` table in ScriptCommandF6_Run_Case10
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wStringCategory, wStringIndex, wC52D, wC52E, wC52F, wC530, wD781
ScriptCommandF6_Run_Case10_Case05::
Jump_00C_4AA6:: ; address name
    call DrawThreeMetaSpritePartsFor5050
    call GridCellAddressFromWD786AndWD78A
    call ScriptCommandF6_Run_Shared08
    cp a, $FF
    jr z, Jump_00C_4B0A
    ld de, Data_01F_4990
    ld hl, vTiles2 + $420
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4990
    ld hl, vTiles2 + $430
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    xor a, a
    ld [wStringCategory], a
    ld [wStringIndex], a
    ld hl, vTiles2 + $300
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0901
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    farcall ShowString_Bank0B
    ld hl, vTiles2 + $390
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    farcall ShowString_Bank0B
    ld a, [wD781]
    inc a
    inc a
    ld [wD781], a
    ret

Jump_00C_4B0A::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 6 of the `rst $00` table in ScriptCommandF6_Run_Case10
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
ScriptCommandF6_Run_Case10_Case06::
Jump_00C_4B12:: ; address name
    call DrawThreeMetaSpritePartsFor5050
    call GridCellAddressFromWD786AndWD78A
    push hl
    sla l
    rl h
    ld de, Data_00C_599F
    add hl, de
    ld a, $42
    call ScriptCommandF6_Run_Case10_Case06_Sub02
    pop hl
    push hl
    sla l
    rl h
    ld de, Data_00C_5F9F
    add hl, de
    ld a, $43
    call ScriptCommandF6_Run_Case10_Case06_Sub02
    pop hl
    push hl
    sla l
    rl h
    ld de, Data_00C_599F
    add hl, de
    ld de, vTiles2 + $300
    call ScriptCommandF6_Run_Case10_Case06_Sub01
    pop hl
    sla l
    rl h
    ld de, Data_00C_5F9F
    add hl, de
    ld de, vTiles2 + $390
    call ScriptCommandF6_Run_Case10_Case06_Sub01
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 7 of the `rst $00` table in ScriptCommandF6_Run_Case10
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wStringCategory, wStringIndex, wC52D, wC52E, wC52F, wC530, wD781
ScriptCommandF6_Run_Case10_Case07::
Jump_00C_4B5C:: ; address name
    call DrawThreeMetaSpritePartsFor5050
    call GridCellAddressFromWD786AndWD78A
    ld a, $10
    add_a_to_hl
    ld a, h
    ld [wStringCategory], a
    ld a, l
    ld [wStringIndex], a
    ld hl, vTiles1 + $220
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    farcall ShowString_Bank0B
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 8 of the `rst $00` table in ScriptCommandF6_Run_Case10
; no direct call (reached through a table, a jump or a vector)
; reads: wD787, wD786, wJoypadPressedRepeat, wJoypadPressed, wD781, wD78A, wD78B
; writes: wD781, wD78B, wD78A, wC52D, wC52E, wC52F, wC530, wD782
; points at: wD78E
ScriptCommandF6_Run_Case10_Case08::
Jump_00C_4B95:: ; address name
    call DrawThreeMetaSpritePartsFor5050
    ld a, [wD787]
    add a, a
    ld b, a
    add a, a
    add a, b
    ld b, a
    ld a, [wD786]
    add a, b
    ld hl, wD78E
    add_a_to_hl
    ld a, [hl]
    cp a, $01
    jr z, Jump_00C_4BBD
    ld a, [wJoypadPressedRepeat]
    bit 4, a
    jr nz, Jump_00C_4BCB
    bit 5, a
    jp nz, Jump_00C_4C4F

Jump_00C_4BBD::
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, Jump_00C_4CD5
    bit 1, a
    jp nz, Jump_00C_4CDA
    ret

Jump_00C_4BCB::
    ld a, [wD78A]
    cp a, $05
    jr c, Jump_00C_4BF8
    xor a, a
    ld [wD78A], a
    call GridIndexFromWD786WD787
    ld de, Data_00C_5944
    add a, e
    ld e, a
    jr nc, Jump_00C_4BE1
    inc d

Jump_00C_4BE1::
    ld a, [de]
    ld b, a
    ld a, [wD78B]
    cp a, b
    jr c, Jump_00C_4BF2

Jump_00C_4BE9::
    xor a, a
    ld [wD78A], a
    ld [wD78B], a
    jr Jump_00C_4BFC

Jump_00C_4BF2::
    inc a
    ld [wD78B], a
    jr Jump_00C_4BFC

Jump_00C_4BF8::
    inc a
    ld [wD78A], a

Jump_00C_4BFC::
    call GridCellAddressFromWD786AndWD78A
    push hl
    call GridIndexFromWD786WD787
    add a, a
    ld hl, Data_00C_592E
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    ld a, h
    cp a, d
    jr c, Jump_00C_4C1C
    jr nz, Jump_00C_4BE9
    ld a, l
    cp a, e
    jr c, Jump_00C_4C1C
    jr Jump_00C_4BE9

Jump_00C_4C1C::
    call GridCellAddressFromWD786AndWD78A
    call ScriptCommandF6_Run_Shared08
    and a, a
    jr z, Jump_00C_4BCB
    ld a, $69
    call QueueSoundEffect
    call ScriptCommandF6_Run_Shared07
    ld hl, vTiles1 + $220
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ld a, $01
    ld [wD781], a
    ld [wD782], a
    ret

Jump_00C_4C4F::
    ld a, [wD78A]
    and a, a
    jr nz, Jump_00C_4C7E
    ld a, [wD78B]
    and a, a
    jr nz, Jump_00C_4C72

Jump_00C_4C5B::
    call GridIndexFromWD786WD787
    ld de, Data_00C_5944
    add a, e
    ld e, a
    jr nc, Jump_00C_4C66
    inc d

Jump_00C_4C66::
    ld a, [de]
    ld [wD78B], a
    call ReadGridCellByteForWD786WD787
    ld [wD78A], a
    jr Jump_00C_4C82

Jump_00C_4C72::
    dec a
    ld [wD78B], a
    call ReadGridCellByteForWD786WD787
    ld [wD78A], a
    jr Jump_00C_4C82

Jump_00C_4C7E::
    dec a
    ld [wD78A], a

Jump_00C_4C82::
    call GridCellAddressFromWD786AndWD78A
    push hl
    call GridIndexFromWD786WD787
    add a, a
    ld hl, Data_00C_592E
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    ld a, h
    cp a, d
    jr c, Jump_00C_4CA2
    jr nz, Jump_00C_4C5B
    ld a, l
    cp a, e
    jr c, Jump_00C_4CA2
    jr nz, Jump_00C_4C5B

Jump_00C_4CA2::
    call GridCellAddressFromWD786AndWD78A
    call ScriptCommandF6_Run_Shared08
    and a, a
    jr z, Jump_00C_4C4F
    ld a, $69
    call QueueSoundEffect
    call ScriptCommandF6_Run_Shared07
    ld hl, vTiles1 + $220
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ld a, $01
    ld [wD781], a
    ld [wD782], a
    ret

Jump_00C_4CD5::
    ld a, $69
    call QueueSoundEffect

Jump_00C_4CDA::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 9 of the `rst $00` table in ScriptCommandF6_Run_Case10
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
ScriptCommandF6_Run_Case10_Case09::
Jump_00C_4CE2:: ; address name
    call ScriptCommandF6_Run_Shared06
    ld b, $46
    ld de, Data_046_4001
    ld hl, vTiles1
    call DecompressToVRAM
    call ScriptCommandF6_Run_Shared05
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 10 of the `rst $00` table in ScriptCommandF6_Run_Case10
; no direct call (reached through a table, a jump or a vector)
; reads: wD787, wD786, wD78A, wD781
; writes: wC445, wC456, wC52D, wC52E, wC52F, wC530, wC526, wD781
; points at: wC364, wC36C
ScriptCommandF6_Run_Case10_Case0A::
Jump_00C_4CFB:: ; address name
    ld de, Data_00C_56D9
    ld hl, wC364
    ld bc, $090D
    call CopyRectTo20ByteRows_Bank0C
    ld a, [wD787]
    and a, a
    jr z, Jump_00C_4D12
    ld a, $C3
    ld [wC445], a

Jump_00C_4D12::
    ld a, [wD786]
    ld hl, Data_00C_58FE
    ld b, $BC
    call StoreBAtWordTableEntry_Bank0C
    ld a, [wD787]
    add a, $E1
    ld [wC456], a
    ld de, Data_00C_574E
    ld hl, wC36C
    ld bc, $0C0D
    call CopyRectTo20ByteRows_Bank0C
    ld a, [wD78A]
    ld b, $BC
    ld hl, Data_00C_590A
    call StoreBAtWordTableEntry_Bank0C
    call ClearStringWindowAt2020
    call ClearStringWindowAt2200
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ld a, $7F
    ld [wC526], a
    call UploadBGPalettes
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 11 of the `rst $00` table in ScriptCommandF6_Run_Case10
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
ScriptCommandF6_Run_Case10_Case0B::
Jump_00C_4D6B:: ; address name
    call WriteBGPalette0From555C
    call ScriptCommandF6_Run_Shared02
    call ScriptCommandF6_Run_Shared01
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 12 of the `rst $00` table in ScriptCommandF6_Run_Case10
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD7F1, wD781, wC52D, wC52E, wC52F, wC530, wScriptCommandType, wScriptStartRequest
; points at: wC300
ScriptCommandF6_Run_Case10_Case0C::
Jump_00C_4D7C:: ; address name
    ld a, $01
    ld [wD7F1], a
    call ScriptCommandF6_Run_Shared04
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    ld de, Data_00C_589A
    ld hl, wC300
    ld bc, $1405
    call CopyRectTo20ByteRows_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call DrawScreenBufferRect_Bank0C
    call ScriptCommandF6_Run_Shared03
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 13 of the `rst $00` table in ScriptCommandF6_Run_Case10
; no direct call (reached through a table, a jump or a vector)
; reads: wD78A
; writes: wD781, wD780, wC52D, wC52E, wC52F, wC530, wScriptCommandType, wScriptStartRequest
ScriptCommandF6_Run_Case10_Case0D::
Jump_00C_4DD6:: ; address name
    ld a, [wD78A]
    ld b, $C3
    ld hl, Data_00C_590A
    call StoreBAtWordTableEntry_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140C
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    xor a, a
    ld [wD781], a
    ld a, $0C
    ld [wD780], a
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; only called from ScriptCommandF6_Run_Case10_Case06 (E-0047)
; 2 call sites from 1 routine (e.g. ScriptCommandF6_Run_Case10_Case06)
; writes: wStringIndex, wStringCategory, wC52D, wC52E, wC52F, wC530
ScriptCommandF6_Run_Case10_Case06_Sub01::
Func_00C_4E16:: ; address name
    push de
    inc hl
    ld a, [hl-]
    cp a, $FE
    jr z, Jump_00C_4E42
    ld a, [hl+]
    ld [wStringIndex], a
    ld a, [hl]
    add a, $02
    ld [wStringCategory], a
    pop de
    ld a, e
    ld [wC52D], a
    ld a, d
    ld [wC52E], a
    ld hl, $0901
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    farcall ShowString_Bank08
    ret

Jump_00C_4E42::
    ld a, [hl]
    cp a, $FE
    jr z, Jump_00C_4E53
    and a, $0F
    ld [wStringIndex], a
    ld a, $02
    ld [wStringCategory], a
    jr Jump_00C_4E5A

Jump_00C_4E53::
    xor a, a
    ld [wStringCategory], a
    ld [wStringIndex], a

Jump_00C_4E5A::
    pop de
    ld a, e
    ld [wC52D], a
    ld a, d
    ld [wC52E], a
    ld hl, $0901
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    farcall ShowString_Bank0B
    ret

; only called from ScriptCommandF6_Run_Case10_Case06 (E-0047)
; 2 call sites from 1 routine (e.g. ScriptCommandF6_Run_Case10_Case06)
; reads: wD7F5
; writes: wD7F6, wD7F7, wD09D, wD09E
ScriptCommandF6_Run_Case10_Case06_Sub02::
Func_00C_4E75:: ; address name
    push af
    inc hl
    ld a, [hl-]
    cp a, $FE
    jr z, Jump_00C_4E8F
    ld a, [hl+]
    ld [wD7F6], a
    ld a, [hl]
    ld [wD7F7], a
    farcall Func_00E_615A
    ld a, [wD7F5]
    jr Jump_00C_4E94

Jump_00C_4E8F::
    ld a, [hl]
    cp a, $FE
    jr z, Jump_00C_4EA4

Jump_00C_4E94::
    and a, $0F
    ld [wD09D], a
    pop af
    ld [wD09E], a
    farcall LoadFamilyIconTileForWD09D
    ret

Jump_00C_4EA4::
    pop af
    ld l, a
    ld h, $00
    sla l
    rl h
    sla l
    rl h
    sla l
    rl h
    sla l
    rl h
    ld de, vTiles2
    add hl, de
    ld de, Data_01F_4990
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ret

; only called from routines of ScriptCommandF6_Run (E-0098)
; 2 call sites from 2 routines (e.g. ScriptCommandF6_Run_Case0A, ScriptCommandF6_Run_Case10_Case0B)
; reads: wD78B
; writes: wStringCategory, wStringIndex, wC52D, wC52E, wC52F, wC530
ScriptCommandF6_Run_Shared01::
Func_00C_4EC7:: ; address name
    call GridIndexFromWD786WD787
    add a, a
    ld de, Data_00C_5916
    add a, e
    ld e, a
    jr nc, Jump_00C_4ED3
    inc d

Jump_00C_4ED3::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, [wD78B]
    add a, a
    ld b, a
    add a, a
    add a, b
    add_a_to_hl
    ld c, $00

Jump_00C_4EE6::
    push hl
    push bc
    call ScriptCommandF6_Run_Shared08
    and a, a
    jr z, Jump_00C_4F26
    pop bc
    pop hl
    push hl
    push bc
    ld a, h
    add a, $02
    ld [wStringCategory], a
    ld a, l
    ld [wStringIndex], a
    ld a, c
    add a, a
    ld de, Data_00C_4F68
    add a, e
    ld e, a
    jr nc, Jump_00C_4F06
    inc d

Jump_00C_4F06::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0901
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    farcall ShowString_Bank08
    jr Jump_00C_4F57

Jump_00C_4F26::
    pop bc
    push bc
    xor a, a
    ld [wStringCategory], a
    ld [wStringIndex], a
    ld a, c
    add a, a
    ld de, Data_00C_4F68
    add a, e
    ld e, a
    jr nc, Jump_00C_4F39
    inc d

Jump_00C_4F39::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0901
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    farcall ShowString_Bank0B

Jump_00C_4F57::
    pop bc
    pop hl
    inc hl
    push hl
    inc c
    call ReadGridCellByteForWD786WD787
    inc a
    ld b, a
    pop hl
    ld a, c
    cp a, b
    jp c, Jump_00C_4EE6
    ret

Data_00C_4F68:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $92, $90, $92, $20, $93, $B0, $93, $40, $94, $D0, $94

; only called from routines of ScriptCommandF6_Run (E-0098)
; 2 call sites from 2 routines (e.g. ScriptCommandF6_Run_Case03, ScriptCommandF6_Run_Case10_Case0B)
; reads: wD787
; writes: wD09D, wD09E
ScriptCommandF6_Run_Shared02::
Func_00C_4F74:: ; address name
    ld a, [wD787]
    add a, a
    ld b, a
    add a, a
    add a, b
    ld de, Data_00C_4FAA
    add a, e
    ld e, a
    jr nc, Jump_00C_4F83
    inc d

Jump_00C_4F83::
    ld c, $00

Jump_00C_4F85::
    ld a, [de]
    cp a, $FF
    jr z, Jump_00C_4FA2
    push de
    push bc
    ld [wD09D], a
    cp a, $06
    jr c, Jump_00C_4F95
    sub a, $06

Jump_00C_4F95::
    inc a
    inc a
    ld [wD09E], a
    farcall LoadFamilyIconTileForWD09D
    pop bc
    pop de

Jump_00C_4FA2::
    inc de
    inc c
    ld a, c
    cp a, $06
    jr c, Jump_00C_4F85
    ret

Data_00C_4FAA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $FF, $20, $90, $70, $90
    db $C0, $90, $10, $91, $60, $91, $B0, $91

; with the pointer from Func_00C_5050 draws sub-indices 0, 4 and 2 (Func_01D_6A36) at Y = $10, $24 and $38, X = $6C (E-0121)
; 5 call sites from 5 routines (e.g. ScriptCommandF6_Run_Case10_Case08, ScriptCommandF6_Run_Case10_Case07, ScriptCommandF6_Run_Case10_Case06, ScriptCommandF6_Run_Case10_Case05, ...)
; writes: wD7F1, wD7F2, wD7F3, wD7F4, wD7F5, wD7F6, hSpriteSubIndex
DrawThreeMetaSpritePartsFor5050::
Func_00C_4FC2:: ; address name
    call GridCellAddressFromWD786AndWD78A
    ld a, l
    ld [wD7F1], a
    ld a, h
    ld [wD7F2], a
    xor a, a
    ld [wD7F3], a
    ld a, $10
    ld [wD7F4], a
    ld a, $6C
    ld [wD7F5], a
    xor a, a
    ld [wD7F6], a
    ld c, $01
    xor a, a
    ldh [hSpriteSubIndex], a
    farcall DrawThreeMetaSpritePartsFor5050_Sub01
    ld a, $24
    ld [wD7F4], a
    ld a, $6C
    ld [wD7F5], a
    xor a, a
    ld [wD7F6], a
    ld c, $01
    ld a, $04
    ldh [hSpriteSubIndex], a
    farcall DrawThreeMetaSpritePartsFor5050_Sub01
    ld a, $38
    ld [wD7F4], a
    ld a, $6C
    ld [wD7F5], a
    xor a, a
    ld [wD7F6], a
    ld c, $01
    ld a, $02
    ldh [hSpriteSubIndex], a
    farcall DrawThreeMetaSpritePartsFor5050_Sub01
    ret

; only called from routines of ScriptCommandF6_Run (E-0098)
; 2 call sites from 2 routines (e.g. ScriptCommandF6_Run_Case0B, ScriptCommandF6_Run_Case10_Case0C)
; reads: wD78B
ScriptCommandF6_Run_Shared03::
Func_00C_501F:: ; address name
    call BGMapAddressAtScroll_Bank0C
    ld de, $018F
    add hl, de
    push hl
    ld a, [wD78B]
    add a, $E1
    ld b, a
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl+], a
    ei
    pop hl
    inc hl
    inc hl
    push hl
    call GridIndexFromWD786WD787
    ld de, Data_00C_5944
    add a, e
    ld e, a
    jr nc, Jump_00C_5043
    inc d

Jump_00C_5043::
    ld a, [de]
    add a, $E1
    ld b, a
    pop hl
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; HL = the word Data_00C_5916[GridIndexFromWD786WD787] + GridIndexFromWD78AWD78B (E-0124)
; 15 call sites from 10 routines (e.g. ScriptCommandF6_Run_Case10_Case08, DrawThreeMetaSpritePartsFor5050, ScriptCommandF6_Run_Case10_Case07, ScriptCommandF6_Run_Case10_Case06, ...)
GridCellAddressFromWD786AndWD78A::
Func_00C_5050:: ; address name
    call GridIndexFromWD786WD787
    add a, a
    ld de, Data_00C_5916
    add a, e
    ld e, a
    jr nc, Jump_00C_505C
    inc d

Jump_00C_505C::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    push hl
    call GridIndexFromWD78AWD78B
    pop hl
    add_a_to_hl
    ret

; A = the byte at Data_00C_594F[GridIndexFromWD786WD787] + wD78B (E-0122)
; 6 call sites from 3 routines (e.g. ScriptCommandF6_Run_Case0C, ScriptCommandF6_Run_Shared01, ScriptCommandF6_Run_Case10_Case08)
; reads: wD78B
ReadGridCellByteForWD786WD787::
Func_00C_506C:: ; address name
    call GridIndexFromWD786WD787
    add a, a
    ld hl, Data_00C_594F
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, [wD78B]
    add a, e
    ld e, a
    jr nc, Jump_00C_5083
    inc d

Jump_00C_5083::
    ld a, [de]
    ret

; only called from routines of ScriptCommandF6_Run (E-0098)
; 4 call sites from 3 routines (e.g. ScriptCommandF6_Run_Case0D, ScriptCommandF6_Run_Case04, ScriptCommandF6_Run_Case10_Case0C)
; reads: wD787, wC8C1, wD7F1, wC8C2
; writes: wC8C1
; points at: wD78E
ScriptCommandF6_Run_Shared04::
Func_00C_5085:: ; address name
    ld a, [wD787]
    add a, a
    ld b, a
    add a, a
    add a, b
    ld hl, wD78E
    add_a_to_hl
    ld a, [wD787]
    and a, a
    jr nz, Jump_00C_509E
    ld b, $06
    jr Jump_00C_50A0

Jump_00C_509E::
    ld b, $05

Jump_00C_50A0::
    ld c, $00

Jump_00C_50A2::
    push hl
    push bc
    ld a, [hl]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    ld a, [wC8C1]
    and a, a
    jr nz, Jump_00C_50B6
    add a, $E3
    ld [wC8C1], a

Jump_00C_50B6::
    call BGMapAddressAtScroll_Bank0C
    pop bc
    push bc
    ld a, c
    add a, a
    push hl
    push af
    ld a, [wD7F1]
    and a, a
    jr z, Jump_00C_50D6
    ld hl, Data_00C_510F
    pop af
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    ld l, e
    ld h, d
    jr Jump_00C_50E4

Jump_00C_50D6::
    ld hl, Data_00C_5103
    pop af
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    add hl, de

Jump_00C_50E4::
    di
    call WaitForVRAMAccess
    ld a, [wC8C1]
    add a, $E0
    ld [hl+], a
    ei
    di
    call WaitForVRAMAccess
    ld a, [wC8C2]
    add a, $E0
    ld [hl], a
    ei
    pop bc
    pop hl
    inc hl
    inc c
    ld a, c
    cp a, b
    jr c, Jump_00C_50A2
    ret

Data_00C_5103:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $26, $00, $66, $00, $A6, $00, $E6, $00, $26, $01, $66, $01

Data_00C_510F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $7E, $C3, $A6, $C3, $CE, $C3, $F6, $C3, $1E, $C4, $46, $C4

; only called from routines of ScriptCommandF6_Run (E-0098)
; 3 call sites from 3 routines (e.g. ScriptCommandF6_Run_Case0F, ScriptCommandF6_Run_Case01, ScriptCommandF6_Run_Case10_Case09)
; reads: wIsCGB
; writes: rSVBK
; points at: wC364, wD1CC
ScriptCommandF6_Run_Shared05::
Func_00C_511B:: ; address name
    ld hl, wC364
    ld bc, $0104

Jump_00C_5121::
    ld a, $C3
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_00C_5121
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_00C_5144
    ld a, $02
    ldh [rSVBK], a
    ld hl, wD1CC
    ld bc, $0104

Jump_00C_5139::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_00C_5139
    ld a, $00
    ldh [rSVBK], a

Jump_00C_5144::
    ret

; Copies 16 bytes from [HL] to [DE]; each byte is written with interrupts off after waiting for rSTAT bit 1 to clear; clobbers A, C; HL and DE advance (the same 17 bytes appear in 7 banks)
; 14 call sites from 4 routines (e.g. ScriptCommandF6_Run_Shared06, ScriptCommandF6_Run_Case08, ScriptCommandF6_Run_Case08_Sub01, ScriptCommandF6_Run_Case10_Case00)
; reads: rSTAT
CopyTileBytesToVRAM_Bank0C::
Func_00C_5145:: ; address name
    ld c, $10

Jump_00C_5147::
    di

Jump_00C_5148::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_00C_5148
    ld a, [hl+]
    ld [de], a
    inc de
    ei
    dec c
    jr nz, Jump_00C_5147
    ret

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX, hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
; 40 call sites from 31 routines (e.g. ScriptCommandF7_Run_Case26, Func_00C_6FCB, ScriptCommandF7_Run_Case19, ScriptCommandF7_Run_Case18, ...)
; reads: hScrollY, hScrollX
BGMapAddressAtScroll_Bank0C::
Func_00C_5156:: ; address name
    ld hl, vBGMap0
    ldh a, [hScrollY]
    and a, $F8
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ldh a, [hScrollX]
    srl a
    srl a
    srl a
    add_a_to_hl
    ret

; only called from routines of ScriptCommandF6_Run (E-0098)
; 4 call sites from 4 routines (e.g. ScriptCommandF6_Run_Case0F, ScriptCommandF6_Run_Case06, ScriptCommandF6_Run_Case01, ScriptCommandF6_Run_Case10_Case09)
; writes: wD7F5, wD7F6, wD7F1, wD7F2, wD7F3, wD7F4, wD7F7
ScriptCommandF6_Run_Shared06::
Func_00C_5177:: ; address name
    ld hl, Data_00C_51AB
    ld de, vTiles1 + $430
    call CopyTileBytesToVRAM_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld a, h
    ld [wD7F5], a
    ld a, l
    ld [wD7F6], a
    ld de, Data_00C_5E12
    ld a, d
    ld [wD7F1], a
    ld a, e
    ld [wD7F2], a
    ld a, $20
    ld [wD7F3], a
    ld a, $20
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    farcall Func_01F_5D9A
    ret

Data_00C_51AB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00

; Copies a rectangle of B bytes by C rows from [DE] to [HL], rows 20 ($14) bytes apart; on CGB it then zero-fills the same-shaped rectangle at HL + $0E68 with rSVBK = 2 and restores rSVBK = 0 (the same 58 bytes appear in 8 banks)
; 23 call sites from 13 routines (e.g. ScriptCommandF7_Run_Shared02, ScriptCommandF7_Run_Case18, ScriptCommandF7_Run_Case11, ScriptCommandF7_Run_Case10, ...)
; reads: wIsCGB
; writes: rSVBK
CopyRectTo20ByteRows_Bank0C::
Func_00C_51BB:: ; address name
    push hl
    push bc

Jump_00C_51BD::
    push bc
    push hl

Jump_00C_51BF::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_00C_51BF
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_00C_51BD
    pop bc
    pop hl
    ld a, [wIsCGB]
    and a, a
    ret z
    ld a, l
    add a, $68
    ld l, a
    ld a, h
    adc a, $0E
    ld h, a
    ld a, $02
    ldh [rSVBK], a

Jump_00C_51E1::
    push bc
    push hl

Jump_00C_51E3::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_00C_51E3
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_00C_51E1
    xor a, a
    ldh [rSVBK], a
    ret

; DE = offset into wScreenTileBuffer, B = width, C = rows, HL = BG map address: CopyRectToBGMapWrapped from wScreenTileBuffer + DE; on CGB the same rectangle is then copied from wD000 + DE (rSVBK = 2) into VRAM bank 1, the attributes; on DMG BC, DE and HL are kept. wC554/wC555 = HL + $1C1 (row 14, column 1 of the drawn area) when wStringIndex is $18 or $12, otherwise $99C1 (E-0062)
; 29 call sites from 22 routines (e.g. ScriptCommandF7_Run_Case26, Func_00C_6FCB, ScriptCommandF7_Run_Case19, ScriptCommandF7_Run_Case18, ...)
; reads: wStringIndex, wIsCGB
; writes: wC554, wC555, rVBK, rSVBK
; points at: wScreenTileBuffer, wD000
DrawScreenBufferRect_Bank0C::
Func_00C_51F5:: ; address name
    push de
    push bc
    push hl
    ld hl, wScreenTileBuffer
    add hl, de
    ld e, l
    ld d, h
    pop hl
    push hl
    call CopyRectToBGMapWrapped
    pop hl
    push hl
    ld a, l
    add a, $C1
    ld [wC554], a
    ld a, h
    adc a, $01
    ld [wC555], a
    ld a, [wStringIndex]
    cp a, $18
    jr z, Jump_00C_5226
    cp a, $12
    jr z, Jump_00C_5226
    ld a, $C1
    ld [wC554], a
    ld a, $99
    ld [wC555], a

Jump_00C_5226::
    pop hl
    pop bc
    pop de
    ld a, [wIsCGB]
    and a, a
    ret z
    ld a, $01
    ldh [rVBK], a
    ld a, $02
    ldh [rSVBK], a
    push hl
    ld hl, wD000
    add hl, de
    ld e, l
    ld d, h
    pop hl
    call CopyRectToBGMapWrapped
    xor a, a
    ldh [rSVBK], a
    ldh [rVBK], a
    ret

; only called from ScriptCommandF7_Run_Case05 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandF7_Run_Case05)
ScriptCommandF7_Run_Case05_Sub01::
Func_00C_5247:: ; address name
    ld a, c
    ld b, a
    ld c, $00

Jump_00C_524B::
    ld a, c
    push bc
    ld b, $C3
    push hl
    call StoreBAtWordTableEntry_Bank0C
    pop hl
    pop bc
    inc c
    ld a, c
    cp a, b
    jr c, Jump_00C_524B
    ret

; HL = table of 16-bit addresses, A = index: stores B at the address in entry A; keeps BC; clobbers A, DE, HL (the same 14 bytes appear in 8 banks)
; 12 call sites from 9 routines (e.g. ScriptCommandF7_Run_Case12, ScriptCommandF7_Run_Case05_Sub01, ScriptCommandF7_Run_Case02, ScriptCommandF6_Run_Case0E, ...)
StoreBAtWordTableEntry_Bank0C::
Func_00C_525B:: ; address name
    push bc
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop bc
    ld a, b
    ld [de], a
    ret

; sets the string window to tile destination vTiles2 + $20 and size word $1702, then FillTilesFromRequest (clears it) (E-0117)
; 2 call sites from 2 routines (e.g. ScriptCommandF6_Run_Case02, ScriptCommandF6_Run_Case10_Case0A)
; writes: wC52D, wC52E, wC52F, wC530
ClearStringWindowAt2020::
Func_00C_5269:: ; address name
    ld hl, vTiles2 + $20
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1702
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ret

; sets the string window to tile destination vTiles2 + $200 and size word $5301, then FillTilesFromRequest (clears it) (E-0117)
; 2 call sites from 2 routines (e.g. ScriptCommandF6_Run_Case09, ScriptCommandF6_Run_Case10_Case0A)
; writes: wC52D, wC52E, wC52F, wC530
ClearStringWindowAt2200::
Func_00C_5283:: ; address name
    ld hl, vTiles2 + $200
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $5301
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ret

; only called from routines of ScriptCommandF6_Run (E-0098)
; 3 call sites from 2 routines (e.g. ScriptCommandF6_Run_Case10_Case08, ScriptCommandF6_Run_Case10_Case00)
; writes: wC52D, wC52E, wC52F, wC530
ScriptCommandF6_Run_Shared07::
Func_00C_529D:: ; address name
    ld hl, vTiles2
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, Data_00C_6101
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ld hl, vTiles2 + $670
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0701
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ret

; DE = source, HL = destination, BC = count: copies BC bytes (BC = 0 copies 65536); DE and HL end past the copy; clobbers A, BC = 0 (E-0064) (the same 9 bytes appear in 13 banks)
; 4 call sites from 4 routines (e.g. Func_00C_72CC, Func_00C_6FCB, ScriptCommandF7_Run_Case00, ScriptCommandF6_Run_Case07)
CopyBytesDEToHL_Bank0C::
Func_00C_52D0:: ; address name
    ld a, [de]
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, CopyBytesDEToHL_Bank0C
    ret

; With rSVBK = 2, copies BC bytes from [DE] to [HL], each ANDed with $07; then rSVBK = 0 (the same 19 bytes appear in 5 banks)
; 4 call sites from 4 routines (e.g. Func_00C_72CC, Func_00C_6FCB, ScriptCommandF7_Run_Case00, ScriptCommandF6_Run_Case07)
; writes: rSVBK
CopyLow3BitsToWRAMBank2_Bank0C::
Func_00C_52D9:: ; address name
    ld a, $02
    ldh [rSVBK], a

Jump_00C_52DD::
    ld a, [de]
    and a, $07
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_00C_52DD
    ld a, $00
    ldh [rSVBK], a
    ret

; A = 6 * wD787 + wD786 (row-major index in a 6-column grid: wD786 column, wD787 row); BC kept (E-0072)
; 15 call sites from 8 routines (e.g. ScriptCommandF6_Run_Case0C, ReadGridCellByteForWD786WD787, ScriptCommandF6_Run_Shared03, ScriptCommandF6_Run_Case0A, ...)
; reads: wD787, wD786
GridIndexFromWD786WD787::
Func_00C_52EC:: ; address name
    push bc
    ld a, [wD787]
    add a, a
    ld b, a
    add a, a
    add a, b
    ld b, a
    ld a, [wD786]
    add a, b
    pop bc
    ret

; A = 6 * wD78B + wD78A (row-major index in a 6-column grid); BC kept (E-0117)
; 2 call sites from 2 routines (e.g. ScriptCommandF6_Run_Case0C, GridCellAddressFromWD786AndWD78A)
; reads: wD78B, wD78A
GridIndexFromWD78AWD78B::
Func_00C_52FB:: ; address name
    push bc
    ld a, [wD78B]
    add a, a
    ld b, a
    add a, a
    add a, b
    ld b, a
    ld a, [wD78A]
    add a, b
    pop bc
    ret

; only called from routines of ScriptCommandF6_Run (E-0098)
; 5 call sites from 4 routines (e.g. ScriptCommandF6_Run_Case0C, ScriptCommandF6_Run_Shared01, ScriptCommandF6_Run_Case10_Case08, ScriptCommandF6_Run_Case10_Case05)
; reads: wD7F5
; writes: wD7F1, wD7F2, wD7F3, wD7F4, wSpeciesIdLo, wSpeciesIdHi
; points at: wC7FC
ScriptCommandF6_Run_Shared08::
Func_00C_530A:: ; address name
    push hl
    ld a, l
    ld [wD7F1], a
    ld a, h
    ld [wD7F2], a
    ld de, wC7FC
    ld a, e
    ld [wD7F3], a
    ld a, d
    ld [wD7F4], a
    farcall TestBitInFieldAtWD7F3
    ld a, [wD7F5]
    cp a, $FF
    jr nz, Jump_00C_532F
    pop hl
    ld a, $FF
    ret

Jump_00C_532F::
    pop hl
    push hl
    ld a, l
    ld [wSpeciesIdLo], a
    ld a, h
    ld [wSpeciesIdHi], a
    farcall TestSpeciesFlag
    ld a, c
    and a, a
    jr nz, Jump_00C_5346
    pop hl
    xor a, a
    ret

Jump_00C_5346::
    pop hl
    ld a, $FE
    ret

; only called from ScriptCommandF6_Run_Case10_Case01 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandF6_Run_Case10_Case01)
; points at: wD79C
ScriptCommandF6_Run_Case10_Case01_Sub01::
Func_00C_534A:: ; address name
    call GridCellAddressFromWD786AndWD78A
    ld de, Data_00C_536A
    add hl, de
    ld a, [hl]
    ld hl, Data_00C_54DF
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld b, $02
    ld hl, wD79C

Jump_00C_5363::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_00C_5363
    ret

Data_00C_536A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $03136A, $A4
    ds $14, $00
    INCBIN "dwm2-cobi-us.gbc", $031422, $BD

Data_00C_54DF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $E9, $54, $EB, $54, $ED, $54, $EF, $54, $F1, $54, $7C, $80, $7D, $80, $7E, $80
    db $7E, $7E, $7F, $80

; only called from ScriptCommandF6_Run_Case10_Case01 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandF6_Run_Case10_Case01)
; points at: wD79C
ScriptCommandF6_Run_Case10_Case01_Sub02::
Func_00C_54F3:: ; address name
    call GridCellAddressFromWD786AndWD78A
    ld de, Data_00C_5562
    add hl, de
    ld a, [hl]
    add a, a
    ld hl, Data_00C_5513
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld b, $04
    ld hl, wD79C

Jump_00C_550C::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_00C_550C
    ret

Data_00C_5513:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_00C_5523
    dw Data_00C_5527
    dw Data_00C_552B
    dw Data_00C_552F
    dw Data_00C_5533
    dw Data_00C_5537
    dw Data_00C_553B
    dw Data_00C_553F

Data_00C_5523:: ; heuristic: target of a monotone pointer table; C0
    db $81, $80, $80, $80

Data_00C_5527:: ; heuristic: target of a monotone pointer table; C0
    db $82, $80, $80, $80

Data_00C_552B:: ; heuristic: target of a monotone pointer table; C0
    db $82, $81, $80, $80

Data_00C_552F:: ; heuristic: target of a monotone pointer table; C0
    db $82, $82, $80, $80

Data_00C_5533:: ; heuristic: target of a monotone pointer table; C0
    db $82, $82, $81, $80

Data_00C_5537:: ; heuristic: target of a monotone pointer table; C0
    db $82, $82, $82, $80

Data_00C_553B:: ; heuristic: target of a monotone pointer table; C0
    db $82, $82, $82, $81

Data_00C_553F:: ; heuristic: target of a monotone pointer table; C0
    db $82, $82, $82, $82

; writes six bytes from Data_00C_555C to the CGB background palette data (rBCPS = $80, auto-increment), waiting for VRAM access (E-0122)
; 1 call site from 1 routine (e.g. ScriptCommandF6_Run_Case10_Case0B)
; reads: rSTAT
WriteBGPalette0From555C::
Func_00C_5543:: ; address name
    ld hl, Data_00C_555C
    ld b, $80
    ld c, $68
    ld a, b
    ldh [c], a
    ld c, $69
    ld d, $06

Jump_00C_5550::
    ldh a, [rSTAT]
    and a, $02
    jr nz, Jump_00C_5550
    ld a, [hl+]
    ldh [c], a
    dec d
    jr nz, Jump_00C_5550
    ret

Data_00C_555C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $86, $7D, $FF, $7F, $E1, $7F

Data_00C_5562:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $031562, $79

Data_00C_55DB:: ; heuristic: bank from RAM variable $D7FE; C0
    INCBIN "dwm2-cobi-us.gbc", $0315DB, $FC

Data_00C_56D7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $05, $04

Data_00C_56D9:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0316D9, $75

Data_00C_574E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $03174E, $9C

Data_00C_57EA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0317EA, $B0

Data_00C_589A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0
    ds $12, $B1
    db $B2, $B6, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8A, $8B, $8C, $8D
    db $8E, $8F, $90, $91, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $92, $93, $94, $95, $96, $97, $98, $99, $9A, $9B, $9C, $9D, $9E, $9F
    db $A0, $A1, $A2, $A3, $B7, $B3
    ds $12, $B4
    db $B5

Data_00C_58FE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $79, $C3, $A1, $C3, $C9, $C3, $F1, $C3, $19, $C4, $41, $C4

Data_00C_590A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $81, $C3, $A9, $C3, $D1, $C3, $F9, $C3, $21, $C4, $49, $C4

Data_00C_5916:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $00, $24, $00, $47, $00, $6A, $00, $8D, $00, $B0, $00, $D3, $00, $F6, $00
    db $19, $01, $3C, $01, $5F, $01, $FF, $FF

Data_00C_592E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $1B, $00, $43, $00, $67, $00, $85, $00, $A8, $00, $CA, $00, $F1, $00, $11, $01
    db $39, $01, $5C, $01, $75, $01

Data_00C_5944:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $04, $05, $05, $04, $04, $04, $04, $04, $05, $05, $03

Data_00C_594F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_00C_5965
    dw Data_00C_596A
    dw Data_00C_5970
    dw Data_00C_5976
    dw Data_00C_597B
    dw Data_00C_5980
    dw Data_00C_5985
    dw Data_00C_598A
    dw Data_00C_598F
    dw Data_00C_5995
    dw Data_00C_599B

Data_00C_5965:: ; heuristic: target of a monotone pointer table; C0
    db $05, $05, $05, $05, $01

Data_00C_596A:: ; heuristic: target of a monotone pointer table; C0
    db $05, $05, $05, $05, $05, $00

Data_00C_5970:: ; heuristic: target of a monotone pointer table; C0
    db $05, $05, $05, $05, $05, $01

Data_00C_5976:: ; heuristic: target of a monotone pointer table; C0
    db $05, $05, $05, $05, $02

Data_00C_597B:: ; heuristic: target of a monotone pointer table; C0
    db $05, $05, $05, $05, $02

Data_00C_5980:: ; heuristic: target of a monotone pointer table; C0
    db $05, $05, $05, $05, $01

Data_00C_5985:: ; heuristic: target of a monotone pointer table; C0
    db $05, $05, $05, $05, $05

Data_00C_598A:: ; heuristic: target of a monotone pointer table; C0
    db $05, $05, $05, $05, $02

Data_00C_598F:: ; heuristic: target of a monotone pointer table; C0
    db $05, $05, $05, $05, $05, $01

Data_00C_5995:: ; heuristic: target of a monotone pointer table; C0
    db $05, $05, $05, $05, $05, $01

Data_00C_599B:: ; heuristic: target of a monotone pointer table; C0
    db $05, $05, $05, $03

Data_00C_599F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $FE, $00, $FE, $00, $FE, $00, $FE, $00, $FE, $00, $FE, $00, $FE, $00, $FE
    db $00, $FE, $00, $FE, $FE, $FE, $00, $FE, $00, $FE, $00, $FE, $01, $00, $00, $FE
    db $00, $FE, $00, $FE, $11, $00, $10, $00, $04, $00, $0B, $00, $15, $00, $13, $00
    db $17, $00, $18, $00
    ds $14, $FE
    INCBIN "dwm2-cobi-us.gbc", $0319E7, $C2
    ds $10, $FE
    db $04, $FE, $04, $FE, $04, $FE, $04, $FE, $04, $FE, $04, $FE, $04, $FE, $04, $FE
    db $04, $FE, $94, $00, $04, $FE, $04, $FE, $04, $FE, $04, $FE, $9C, $00, $04, $FE
    db $04, $FE, $04, $FE, $9E, $00, $9F, $00, $96, $00, $04, $FE, $A2, $00, $FE, $FE
    db $FE, $FE, $04, $FE, $99, $00
    ds $10, $FE
    db $05, $FE, $05, $FE, $05, $FE, $05, $FE, $05, $FE, $05, $FE, $05, $FE, $05, $FE
    db $05, $FE, $B0, $00, $FE, $FE, $B4, $00, $B5, $00, $05, $FE, $B3, $00, $05, $FE
    db $05, $FE, $B8, $00, $C1, $00, $C5, $00, $B7, $00, $05, $FE, $C4, $00, $05, $FE
    db $C6, $00, $B1, $00
    ds $12, $FE
    INCBIN "dwm2-cobi-us.gbc", $031B45, $7C
    ds $10, $FE
    INCBIN "dwm2-cobi-us.gbc", $031BD1, $B6
    ds $18, $FE
    db $00, $FE, $00, $FE, $00, $FE, $00, $FE, $00, $FE, $00, $FE, $00, $FE, $00, $FE
    db $00, $FE, $00, $FE, $FE, $FE, $00, $FE, $00, $FE, $00, $FE, $01, $00, $00, $FE
    db $00, $FE, $00, $FE, $11, $00, $10, $00, $04, $00, $0B, $00, $15, $00, $13, $00
    db $17, $00, $18, $00
    ds $14, $FE
    INCBIN "dwm2-cobi-us.gbc", $031CE7, $C2
    ds $10, $FE
    db $04, $FE, $04, $FE, $04, $FE, $04, $FE, $04, $FE, $04, $FE, $04, $FE, $04, $FE
    db $04, $FE, $94, $00, $04, $FE, $8D, $00, $04, $FE, $04, $FE, $04, $FE, $04, $FE
    db $04, $FE, $04, $FE, $9E, $00, $9F, $00, $96, $00, $04, $FE, $A2, $00, $FE, $FE
    db $FE, $FE, $04, $FE, $99, $00
    ds $10, $FE
    db $05, $FE, $05, $FE, $05, $FE, $05, $FE, $05, $FE, $05, $FE, $05, $FE, $05, $FE
    db $05, $FE, $B0

Data_00C_5E12:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $FE, $FE, $B4, $00, $B5, $00, $05, $FE, $B3, $00, $05, $FE, $05, $FE, $B8
    db $00, $C1, $00, $C5, $00, $B7, $00, $05, $FE, $C4, $00, $05, $FE, $C6, $00, $B1
    db $00
    ds $12, $FE
    INCBIN "dwm2-cobi-us.gbc", $031E45, $7C
    ds $10, $FE
    INCBIN "dwm2-cobi-us.gbc", $031ED1, $B6
    ds $18, $FE

Data_00C_5F9F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FE, $FE, $01, $FE, $02, $FE, $03, $FE, $04, $FE, $05, $FE, $06, $FE, $07, $FE
    db $08, $FE, $09, $FE, $FE, $FE, $4A, $00, $48, $00, $32, $01, $2B, $00, $4D, $00
    db $0A, $FE, $24, $01, $11, $00, $5C, $00, $02, $FE, $DC, $00, $07, $FE, $24, $01
    db $17, $00, $18, $00
    ds $14, $FE
    INCBIN "dwm2-cobi-us.gbc", $031FE7, $C1
    ds $11, $FE
    db $00, $FE, $01, $FE, $02, $FE, $03, $FE, $05, $FE, $06, $FE, $07, $FE, $08, $FE
    db $09, $FE, $02, $FE, $40, $01, $1D, $01, $D3, $00, $92, $00, $01, $FE, $80, $00
    db $4A, $00, $0D, $00, $9E, $00, $9F, $00, $07, $FE, $0A, $FE, $EA, $00, $FE, $FE
    db $FE, $FE, $B6, $00, $06, $00
    ds $10, $FE
    db $00, $FE

Data_00C_6101:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $FE, $02, $FE, $03, $FE, $04, $FE, $06, $FE, $07, $FE, $08, $FE, $09, $FE
    db $00, $FE, $FE, $FE, $04, $FE, $08, $FE, $49, $01, $06, $FE, $F6, $00, $FB, $00
    db $07, $FE, $07, $FE, $06, $FE, $B7, $00, $DC, $00, $C4, $00, $0A, $FE, $08, $01
    db $B1, $00
    ds $12, $FE
    INCBIN "dwm2-cobi-us.gbc", $032145, $7C
    ds $10, $FE
    INCBIN "dwm2-cobi-us.gbc", $0321D1, $B6
    ds $1A, $FE
    db $01, $FE, $02, $FE, $03, $FE, $04, $FE, $05, $FE, $06, $FE, $07, $FE, $08, $FE
    db $09, $FE, $FE, $FE, $4A, $00, $48, $00, $32, $01, $2B, $00, $4D, $00, $0A, $FE
    db $24, $01, $11, $00, $5C, $00, $02, $FE, $DC, $00, $07, $FE, $24, $01, $17, $00
    db $18, $00
    ds $14, $FE
    INCBIN "dwm2-cobi-us.gbc", $0322E7, $C1
    ds $11, $FE
    db $00, $FE, $01, $FE, $02, $FE, $03, $FE, $05, $FE, $06, $FE, $07, $FE, $08, $FE
    db $09, $FE, $02, $FE, $B2, $00, $02, $FE, $D3, $00, $92, $00, $01, $01, $80, $00
    db $4A, $00, $0D, $00, $9E, $00, $9F, $00, $07, $FE, $0A, $FE, $EA, $00, $FE, $FE
    db $FE, $FE, $B6, $00, $06, $00
    ds $10, $FE
    db $00, $FE, $01, $FE, $02, $FE, $03, $FE, $04, $FE, $06, $FE, $07, $FE, $08, $FE
    db $09, $FE, $00, $FE, $FE, $FE, $04, $FE, $08, $FE, $45, $01, $06, $FE, $F6, $00
    db $FB, $00, $07, $FE, $07, $FE, $06, $FE, $B7, $00, $DC, $00, $C4, $00, $0A, $FE
    db $08, $01, $B1, $00
    ds $12, $FE
    INCBIN "dwm2-cobi-us.gbc", $032445, $7C
    ds $10, $FE
    db $00, $FE

Data_00C_64D3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0324D3, $48

Data_00C_651B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $03251B, $6C
    ds $18, $FE

; implements script command type F7; reached through ScriptCommandF7 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommandF7)
; reads: wD780
ScriptCommandF7_Run::
Func_00C_659F:: ; address name
    ld a, [wD780]
    rst $00
    dw ScriptCommandF7_Run_Case00
    dw ScriptCommandF7_Run_Case01
    dw ScriptCommandF7_Run_Case02
    dw ShowTwoChoiceBoxAtWC412
    dw ScriptCommandF7_Run_Case04
    dw ScriptCommandF7_Run_Case05
    dw ScriptCommandF7_Run_Case06
    dw ScriptCommandF7_Run_Case07
    dw ScriptCommandF7_Run_Case08
    dw ScriptCommandF7_Run_Case06
    dw ScriptCommandF7_Run_Case0A
    dw ScriptCommandF7_Run_Case0B
    dw ScriptCommandF7_Run_Case0C
    dw ScriptCommandF7_Run_Case0D
    dw ScriptCommandF7_Run_Case0E
    dw ScriptCommandF7_Run_Case0F
    dw ScriptCommandF7_Run_Case10
    dw ScriptCommandF7_Run_Case11
    dw ScriptCommandF7_Run_Case12
    dw ScriptCommandF7_Run_Case13
    dw ScriptCommandF7_Run_Case14
    dw ScriptCommandF7_Run_Case15
    dw ShowTwoChoiceBoxAtWC412
    dw ScriptCommandF7_Run_Case17
    dw ScriptCommandF7_Run_Case18
    dw ScriptCommandF7_Run_Case19
    dw ScriptCommandF7_Run_Case1A
    dw ScriptCommandF7_Run_Case1B
    dw ScriptCommandF7_Run_Case1C
    dw ScriptCommandF7_Run_Case06
    dw ScriptCommandF7_Run_Case1E
    dw ScriptCommandF7_Run_Case08
    dw ScriptCommandF7_Run_Case06
    dw ScriptCommandF7_Run_Case21
    dw ScriptCommandF7_Run_Case22
    dw ScriptCommandF7_Run_Case23
    dw ScriptCommandF7_Run_Case24
    dw ShowTwoChoiceBoxAtWC412
    dw ScriptCommandF7_Run_Case26
    dw ScriptCommandF7_Run_Case27

; entry 39 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD7FC, hFFC6
; writes: wD7F1, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wD7FC
ScriptCommandF7_Run_Case27::
Jump_00C_65F3:: ; address name
    ld a, [wD7FC]
    add a, a
    ld hl, Data_00C_75D2
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    ld b, $1F
    call RandomModulo52
    pop de
    ld b, $00

Jump_00C_660B::
    ld a, [de]
    cp a, $FF
    jp z, Jump_00C_665E
    cp a, l
    jr nc, Jump_00C_6618
    inc de
    inc b
    jr Jump_00C_660B

Jump_00C_6618::
    ld a, [wD7FC]
    add a, a
    ld hl, Data_00C_7602
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, b
    add a, e
    ld e, a
    jr nc, Jump_00C_662D
    inc d

Jump_00C_662D::
    ld a, [de]
    cp a, $FE
    jr z, Jump_00C_663F
    cp a, $FD
    jr z, Jump_00C_6655
    ld [wD7F1], a
    call ScriptCommandF7_Run_Case27_Sub02
    jp Jump_00C_6663

Jump_00C_663F::
    farcall Func_012_689A
    ldh a, [hFFC6]
    and a, a
    jr z, Jump_00C_664E
    ld a, $01
    jr Jump_00C_6663

Jump_00C_664E::
    call ScriptCommandF7_Run_Shared06
    ld a, $03
    jr Jump_00C_6663

Jump_00C_6655::
    call ScriptCommandF7_Run_Case27_Sub01
    call ScriptCommandF7_Run_Case27_Sub02
    jp Jump_00C_6663

Jump_00C_665E::
    call ScriptCommandF7_Run_Shared06
    ld a, $03

Jump_00C_6663::
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    xor a, a
    ld [wD7FC], a
    ret

; entry 38 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wTwoChoiceCursor, wD780
; writes: wD780, wScriptCommandType, wScriptStartRequest, wTwoChoiceCursor, wD7F1, wD7F2
ScriptCommandF7_Run_Case26::
Jump_00C_6674:: ; address name
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_00C_6688
    cp a, $FF
    jr z, Jump_00C_66C0
    ret

Jump_00C_6688::
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wD780]
    dec a
    ld [wD780], a
    ld b, $00
    ld c, $05
    ld hl, $027A
    ld de, $00AE
    xor a, a
    ld [wD7F1], a
    ld a, $06
    ld [wD7F2], a
    call Func_00C_72CC
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_00C_66C0::
    ld a, [wTwoChoiceCursor]
    and a, a
    jr nz, Jump_00C_6688
    ld a, [wD780]
    inc a
    ld [wD780], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 0 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wC82C, wD7FB, wD780
; writes: wD7F0, wD780, wTwoChoiceCursor, wC52D, wC52E, wC52F, wC530, wScriptCommandType, ...
; points at: wD780, wC364, wScreenTileBuffer, wD1CC, wD000
ScriptCommandF7_Run_Case00::
Jump_00C_66D7:: ; address name
    ld hl, wD780
    ld b, $6F

Jump_00C_66DC::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_00C_66DC
    ld hl, wC364
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank0C
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_00C_66FF
    ld hl, wD1CC
    ld de, wD000
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank0C

Jump_00C_66FF::
    ld a, $0A
    ld [wD7F0], a
    ld a, [wC82C]
    cp a, $05
    jr nc, Jump_00C_6770
    and a, a
    jr nz, Jump_00C_673F
    ld a, [wD7FB]
    cp a, $1F
    jr z, Jump_00C_6717
    ld a, $1D

Jump_00C_6717::
    ld [wD780], a
    ld a, $02
    ld [wTwoChoiceCursor], a
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_00C_673F::
    xor a, a
    ld [wTwoChoiceCursor], a
    ld [wStringCategory], a
    ld a, $17
    ld [wStringIndex], a
    ld hl, vTiles1 + $240
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0A01
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    farcall ShowString_Bank33_649E
    ld a, [wD780]
    inc a
    ld [wD780], a
    jr Jump_00C_67B5

Jump_00C_6770::
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wStringCategory], a
    ld a, $1A
    ld [wStringIndex], a
    ld hl, vTiles1 + $240
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0A01
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    farcall ShowString_Bank33_649E
    ld hl, vTiles1 + $700
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld a, $18
    ld [wStringIndex], a
    farcall ShowString_Bank33_649E
    ld a, $0B
    ld [wD780], a

Jump_00C_67B5::
    ld a, [wD7FB]
    cp a, $08
    jr z, Jump_00C_67C2
    cp a, $1B
    jr z, Jump_00C_67C2
    jr Jump_00C_67C5

Jump_00C_67C2::
    ld [wD780], a

Jump_00C_67C5::
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 1 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD780
; writes: wD780
; points at: wC3B4
ScriptCommandF7_Run_Case01::
Jump_00C_67E5:: ; address name
    ld de, Data_00C_762E
    ld hl, wC3B4
    ld bc, $1109
    call CopyRectTo20ByteRows_Bank0C
    call ScriptCommandF7_Run_Case01_Sub01
    call ScriptCommandF7_Run_Shared02
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

; entry 2 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wC82C, wD786, wD780
; writes: wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wC130, wC131, wD780, wD786
ScriptCommandF7_Run_Case02::
Jump_00C_680B:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, Jump_00C_6825
    bit 7, a
    jr nz, Jump_00C_683F
    ld a, [wJoypadPressed]
    bit 1, a
    jr nz, Jump_00C_684F
    bit 0, a
    jr nz, Jump_00C_685E
    call ScriptCommandF7_Run_Case02_Sub01
    ret

Jump_00C_6825::
    call ScriptCommandF7_Run_Case02_Sub03
    ld a, [wD786]
    and a, a
    jr nz, Jump_00C_6832
    ld a, $03
    jr Jump_00C_6833

Jump_00C_6832::
    dec a

Jump_00C_6833::
    ld [wD786], a
    call ScriptCommandF7_Run_Case02_Sub02
    ld a, $69
    call QueueSoundEffect
    ret

Jump_00C_683F::
    call ScriptCommandF7_Run_Case02_Sub03
    ld a, [wD786]
    cp a, $03
    jr c, Jump_00C_684C
    xor a, a
    jr Jump_00C_6833

Jump_00C_684C::
    inc a
    jr Jump_00C_6833

Jump_00C_684F::
    ld a, $03
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_00C_685E::
    call ScriptCommandF7_Run_Case02_Sub02
    ld a, [wC82C]
    dec a
    ld b, a
    ld a, [wD786]
    cp a, b
    jr c, Jump_00C_687D
    jr z, Jump_00C_688C
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_00C_687D::
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_00C_688C::
    ld a, $69
    call QueueSoundEffect
    ld a, [wD786]
    ld hl, Data_00C_68D1
    add_a_to_hl
    ld a, [hl]
    ld [wC130], a
    ld a, $F0
    ld [wC131], a
    ld a, [wD786]
    ld hl, Data_00C_784F
    ld b, $BC
    call StoreBAtWordTableEntry_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    ld a, [wD780]
    inc a
    ld [wD780], a
    xor a, a
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Data_00C_68D1:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0C, $0B, $0A, $1C

; only called from ScriptCommandF7_Run_Case02 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandF7_Run_Case02)
; reads: wJoypadRepeatTimer, wD787, wD786
; writes: wD787
ScriptCommandF7_Run_Case02_Sub01::
Func_00C_68D5:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, ScriptCommandF7_Run_Case02_Sub02
    ld a, [wD787]
    inc a
    ld [wD787], a
    cp a, $10
    jr c, ScriptCommandF7_Run_Case02_Sub02
    cp a, $18
    jr c, ScriptCommandF7_Run_Case02_Sub03
    xor a, a
    ld [wD787], a

; only called from ScriptCommandF7_Run_Case02 (E-0047)
; 2 call sites from 1 routine (e.g. ScriptCommandF7_Run_Case02)
; reads: wD786
ScriptCommandF7_Run_Case02_Sub02::
Func_00C_68EF:: ; address name
    ld b, $BB
    jr Jump_00C_68F9

; only called from ScriptCommandF7_Run_Case02 (E-0047)
; 2 call sites from 1 routine (e.g. ScriptCommandF7_Run_Case02)
; reads: wD786
ScriptCommandF7_Run_Case02_Sub03::
Func_00C_68F3:: ; address name
    ld b, $C3
    jr Jump_00C_68F9
    db $06, $BC

Jump_00C_68F9::
    ld a, [wD786]
    sla a
    ld hl, Data_00C_691A
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank0C
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

Data_00C_691A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A2, $00, $E2, $00, $22, $01, $62, $01

; plays sound $6C, copies the 6 x 5 box Data_00C_7831 to wC412, draws it at the scroll position + $1CC, wD780 += 1 and wTwoChoiceCursor = 0 (E-0122)
; 1 call site from 1 routine (e.g. ScriptCommandF7_Run_Case0B)
; reads: wD780
; writes: wD780, wTwoChoiceCursor
; points at: wC412
ShowTwoChoiceBoxAtWC412::
Func_00C_6922:: ; address name
    ld a, $6C
    call QueueSoundEffect
    ld de, Data_00C_7831
    ld hl, wC412
    ld bc, $0605
    call CopyRectTo20ByteRows_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    ld a, [wD780]
    inc a
    ld [wD780], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ret

; entry 4 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wTwoChoiceCursor, wD786, wD7F1, wD780
; writes: wD7F3, wD7F2, wD7F1, wTwoChoiceCursor, wD780, wScriptCommandType, wScriptStartRequest
ScriptCommandF7_Run_Case04::
Jump_00C_694B:: ; address name
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_00C_695F
    cp a, $FF
    jr z, Jump_00C_6978
    ret

Jump_00C_695F::
    call ScriptCommandF7_Run_Shared01
    ld a, [wD780]
    inc a
    ld [wD780], a
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_00C_6978::
    ld a, [wTwoChoiceCursor]
    and a, a
    jr nz, Jump_00C_695F
    ld a, [wD786]
    sla a
    ld de, Data_00C_7871
    add a, e
    ld e, a
    jr nc, Jump_00C_698B
    inc d

Jump_00C_698B::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    xor a, a
    ld [wD7F3], a
    ld a, h
    ld [wD7F2], a
    ld a, l
    ld [wD7F1], a
    farcall IsAmountInWD7F1AboveGold
    ld a, [wD7F1]
    cp a, $FF
    jr nz, Jump_00C_69BF
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_00C_69BF::
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wD780]
    inc a
    inc a
    ld [wD780], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; only called from routines of ScriptCommandF7_Run (E-0098)
; 3 call sites from 3 routines (e.g. ScriptCommandF7_Run_Case0C, ScriptCommandF7_Run_Case05, ScriptCommandF7_Run_Case04)
; writes: wD7F1, wD7F2
; points at: wC412
ScriptCommandF7_Run_Shared01::
Func_00C_69D5:: ; address name
    ld b, $00
    ld c, $05
    ld hl, $027A
    ld de, $00AE
    xor a, a
    ld [wD7F1], a
    ld a, $06
    ld [wD7F2], a
    call Func_00C_72CC
    ld de, Data_00C_76C7
    ld hl, wC412
    ld bc, $0305
    call CopyRectTo20ByteRows_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    ret

; entry 5 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wD780
ScriptCommandF7_Run_Case05::
Jump_00C_6A04:: ; address name
    call ScriptCommandF7_Run_Shared01
    ld c, $04
    ld hl, Data_00C_784F
    call ScriptCommandF7_Run_Case05_Sub01
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    ld a, $02
    ld [wD780], a
    ret

; entry 6 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD780
; writes: wD780
ScriptCommandF7_Run_Case06::
Jump_00C_6A21:: ; address name
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

; entry 7 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD786, wD780, wD78E
; writes: wD7F3, wD7F2, wD7F1, wD780, wD7FB, wD7FF, wD7FC
ScriptCommandF7_Run_Case07::
Jump_00C_6A29:: ; address name
    call ScriptCommandF7_Run_Shared04
    ld a, [wD786]
    sla a
    ld de, Data_00C_7871
    add a, e
    ld e, a
    jr nc, Jump_00C_6A39
    inc d

Jump_00C_6A39::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    xor a, a
    ld [wD7F3], a
    ld a, h
    ld [wD7F2], a
    ld a, l
    ld [wD7F1], a
    farcall SubtractWD7F1AmountFromGold
    ld a, [wD780]
    inc a
    ld [wD780], a
    ld [wD7FB], a
    ld a, [wD78E]
    ld [wD7FF], a
    ld a, [wD786]
    ld [wD7FC], a
    call Func_00C_6FCB
    ret

; entry 8 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD092, wD7FF, wD780, wC82C
; writes: wScriptCommandType, wScriptStartRequest, wD780, wC82C, wTwoChoiceCursor, wD7FC, wD7FB, wD7FF
ScriptCommandF7_Run_Case08::
Jump_00C_6A6A:: ; address name
    ld a, [wD092]
    and a, a
    jr nz, Jump_00C_6AA1
    ld a, [wD7FF]
    cp a, $02
    jr nc, Jump_00C_6A8B
    call SetupWD78EFromWD7FF
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

Jump_00C_6A8B::
    ld a, [wC82C]
    inc a
    ld [wC82C], a
    xor a, a
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    jr Jump_00C_6AAF

Jump_00C_6AA1::
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a

Jump_00C_6AAF::
    xor a, a
    ld [wD7FC], a
    ld [wD7FB], a
    ld [wD7FF], a
    ld a, [wC82C]
    and a, a
    ret z
    ld a, $22
    ld [wD780], a
    ret

; entry 10 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommandF7_Run_Case0A::
Jump_00C_6AC4:: ; address name
    call ScriptCommandF7_Run_Shared04
    ret

; entry 11 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommandF7_Run_Case0B::
Jump_00C_6AC8:: ; address name
    call ScriptCommandF7_Run_Shared02
    call ShowTwoChoiceBoxAtWC412
    ret

; entry 12 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wTwoChoiceCursor, wD780
; writes: wTwoChoiceCursor, wD780, wScriptCommandType, wScriptStartRequest
ScriptCommandF7_Run_Case0C::
Jump_00C_6ACF:: ; address name
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_00C_6AE3
    cp a, $FF
    jr z, Jump_00C_6AF2
    ret

Jump_00C_6AE3::
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_00C_6AF2::
    ld a, [wTwoChoiceCursor]
    and a, a
    jr nz, Jump_00C_6AE3
    call ScriptCommandF7_Run_Shared01
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 13 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD780
; writes: wD780
ScriptCommandF7_Run_Case0D::
Jump_00C_6B10:: ; address name
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

; entry 14 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD780
; writes: wD780, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
ScriptCommandF7_Run_Case0E::
Jump_00C_6B18:: ; address name
    ld a, [wD780]
    inc a
    inc a
    ld [wD780], a
    xor a, a
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 15 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD780
; writes: wD7F1, wD7F2, wD780, wScriptCommandType, wScriptStartRequest
ScriptCommandF7_Run_Case0F::
Jump_00C_6B2E:: ; address name
    ld b, $00
    ld c, $03
    ld hl, $01E0
    ld de, $0014
    xor a, a
    ld [wD7F1], a
    ld a, $08
    ld [wD7F2], a
    call Func_00C_72CC
    ld b, $00
    ld c, $07
    ld hl, $0244
    ld de, $0078
    xor a, a
    ld [wD7F1], a
    ld a, $0D
    ld [wD7F2], a
    call Func_00C_72CC
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    ld a, [wD780]
    sub a, $04
    ld [wD780], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 16 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD780
; writes: wD780, wScriptCommandType, wScriptStartRequest
; points at: wC3B4
ScriptCommandF7_Run_Case10::
Jump_00C_6B78:: ; address name
    ld de, Data_00C_76D6
    ld hl, wC3B4
    ld bc, $1109
    call CopyRectTo20ByteRows_Bank0C
    call ScriptCommandF7_Run_Shared02
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    call ScriptCommandF7_Run_Shared05
    ld a, [wD780]
    inc a
    inc a
    ld [wD780], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 17 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD780
; writes: wD780
; points at: wC3B4
ScriptCommandF7_Run_Case11::
Jump_00C_6BB4:: ; address name
    ld de, Data_00C_76D6
    ld hl, wC3B4
    ld bc, $1109
    call CopyRectTo20ByteRows_Bank0C
    call ScriptCommandF7_Run_Shared02
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

; entry 18 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wD786, wD780
; writes: wC130, wC131, wD780, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wD786
ScriptCommandF7_Run_Case12::
Jump_00C_6BE3:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, Jump_00C_6BFD
    bit 7, a
    jr nz, Jump_00C_6C17
    ld a, [wJoypadPressed]
    bit 1, a
    jr nz, Jump_00C_6C27
    bit 0, a
    jr nz, Jump_00C_6C36
    call ScriptCommandF7_Run_Case12_Sub01
    ret

Jump_00C_6BFD::
    call ScriptCommandF7_Run_Case12_Sub03
    ld a, [wD786]
    and a, a
    jr nz, Jump_00C_6C0A
    ld a, $03
    jr Jump_00C_6C0B

Jump_00C_6C0A::
    dec a

Jump_00C_6C0B::
    ld [wD786], a
    call ScriptCommandF7_Run_Case12_Sub02
    ld a, $69
    call QueueSoundEffect
    ret

Jump_00C_6C17::
    call ScriptCommandF7_Run_Case12_Sub03
    ld a, [wD786]
    cp a, $03
    jr c, Jump_00C_6C24
    xor a, a
    jr Jump_00C_6C0B

Jump_00C_6C24::
    inc a
    jr Jump_00C_6C0B

Jump_00C_6C27::
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_00C_6C36::
    call ScriptCommandF7_Run_Case12_Sub02
    ld a, $69
    call QueueSoundEffect
    ld a, [wD786]
    ld hl, Data_00C_6C7F
    add_a_to_hl
    ld a, [hl]
    ld [wC130], a
    ld a, $F0
    ld [wC131], a
    ld a, [wD786]
    ld hl, Data_00C_7857
    ld b, $BC
    call StoreBAtWordTableEntry_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    ld a, [wD780]
    inc a
    inc a
    ld [wD780], a
    xor a, a
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Data_00C_6C7F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0C, $0B, $0A, $1C

; only called from ScriptCommandF7_Run_Case12 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandF7_Run_Case12)
; reads: wJoypadRepeatTimer, wD787, wD786
; writes: wD787
ScriptCommandF7_Run_Case12_Sub01::
Func_00C_6C83:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, ScriptCommandF7_Run_Case12_Sub02
    ld a, [wD787]
    inc a
    ld [wD787], a
    cp a, $10
    jr c, ScriptCommandF7_Run_Case12_Sub02
    cp a, $18
    jr c, ScriptCommandF7_Run_Case12_Sub03
    xor a, a
    ld [wD787], a

; only called from ScriptCommandF7_Run_Case12 (E-0047)
; 2 call sites from 1 routine (e.g. ScriptCommandF7_Run_Case12)
; reads: wD786
ScriptCommandF7_Run_Case12_Sub02::
Func_00C_6C9D:: ; address name
    ld b, $BB
    jr Jump_00C_6CA7

; only called from ScriptCommandF7_Run_Case12 (E-0047)
; 2 call sites from 1 routine (e.g. ScriptCommandF7_Run_Case12)
; reads: wD786
ScriptCommandF7_Run_Case12_Sub03::
Func_00C_6CA1:: ; address name
    ld b, $C3
    jr Jump_00C_6CA7
    db $06, $BC

Jump_00C_6CA7::
    ld a, [wD786]
    sla a
    ld hl, Data_00C_6CC8
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank0C
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

Data_00C_6CC8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A1, $00, $E1, $00, $21, $01, $61, $01

; entry 19 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wD7F1, wD7F2, wD780, wD78A, wScriptCommandType, wScriptStartRequest
ScriptCommandF7_Run_Case13::
Jump_00C_6CD0:: ; address name
    ld b, $00
    ld c, $05
    ld hl, $01E0
    ld de, $0014
    xor a, a
    ld [wD7F1], a
    ld a, $08
    ld [wD7F2], a
    call Func_00C_72CC
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    ld a, $0D
    ld [wD780], a
    xor a, a
    ld [wD78A], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 20 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD780
; writes: wD780
ScriptCommandF7_Run_Case14::
Jump_00C_6D05:: ; address name
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

; entry 21 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD786, wD780
; writes: wD78C, wD78A, wD586, wD587, wD780, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
ScriptCommandF7_Run_Case15::
Jump_00C_6D0D:: ; address name
    ld a, [wD786]
    inc a
    inc a
    ld [wD78C], a
    ld a, $02
    ld [wD78A], a
    ld a, [wD786]
    add a, a
    ld hl, Data_00C_6D44
    add_a_to_hl
    ld a, [hl]
    ld [wD586], a
    inc hl
    ld a, [hl]
    ld [wD587], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    xor a, a
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Data_00C_6D44:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $E8, $03, $D0, $07, $B8, $0B, $88, $13

; entry 23 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wTwoChoiceCursor, wD586, wD587, wD7F1, wD780
; writes: wD7F1, wD7F2, wD7F3, wTwoChoiceCursor, wD780, wScriptCommandType, wScriptStartRequest
ScriptCommandF7_Run_Case17::
Jump_00C_6D4C:: ; address name
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_00C_6D60
    cp a, $FF
    jr z, Jump_00C_6D76
    ret

Jump_00C_6D60::
    ld a, $02
    ld [wTwoChoiceCursor], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_00C_6D76::
    ld a, [wTwoChoiceCursor]
    and a, a
    jr nz, Jump_00C_6D60
    ld a, [wD586]
    ld [wD7F1], a
    ld a, [wD587]
    ld [wD7F2], a
    xor a, a
    ld [wD7F3], a
    farcall IsAmountInWD7F1AboveGold
    ld a, [wD7F1]
    cp a, $FF
    jr nz, Jump_00C_6DAF
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_00C_6DAF::
    ld a, [wD780]
    inc a
    inc a
    ld [wD780], a
    xor a, a
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 24 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wD7F1, wD7F2, wD780, wD78A, wD78C, wScriptCommandType, wScriptStartRequest
; points at: wC412
ScriptCommandF7_Run_Case18::
Jump_00C_6DC5:: ; address name
    ld b, $00
    ld c, $05
    ld hl, $027A
    ld de, $00AE
    xor a, a
    ld [wD7F1], a
    ld a, $06
    ld [wD7F2], a
    call Func_00C_72CC
    ld de, Data_00C_776F
    ld hl, wC412
    ld bc, $0305
    call CopyRectTo20ByteRows_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    call ScriptCommandF7_Run_Shared05
    ld a, $11
    ld [wD780], a
    xor a, a
    ld [wD78A], a
    ld [wD78C], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 25 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD587, wD586, wD780
; writes: wD7F3, wD7F2, wD7F1, wD780, wScriptCommandType, wScriptStartRequest
ScriptCommandF7_Run_Case19::
Jump_00C_6E0C:: ; address name
    xor a, a
    ld [wD7F3], a
    ld a, [wD587]
    ld [wD7F2], a
    ld a, [wD586]
    ld [wD7F1], a
    farcall SubtractWD7F1AmountFromGold
    call ScriptCommandF7_Run_Shared02
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    ld a, [wD780]
    inc a
    ld [wD780], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 26 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD78C, wD780
; writes: wD7FC, wD780, wD7FB
ScriptCommandF7_Run_Case1A::
Jump_00C_6E42:: ; address name
    ld a, [wD78C]
    ld [wD7FC], a
    call ScriptCommandF7_Run_Case1A_Sub01
    ld a, [wD780]
    inc a
    ld [wD780], a
    ld [wD7FB], a
    call Func_00C_6FCB
    ret

; entry 27 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD092, wD588, wD780
; writes: wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wD7FB, wD780, wD7FF, wD7F3, wD7F2, ...
ScriptCommandF7_Run_Case1B::
Jump_00C_6E59:: ; address name
    ld a, [wD092]
    and a, a
    jr nz, Jump_00C_6EA2
    ld a, [wD588]
    cp a, $02
    jr nc, Jump_00C_6E85
    call IncWD588AndCopyWD7FCToWD78C
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ld a, [wD780]
    ld [wD7FB], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

Jump_00C_6E85::
    call ScriptCommandF7_Run_Case1B_Sub01
    xor a, a

Jump_00C_6E89::
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    xor a, a
    ld [wD7FB], a
    ld [wD7FF], a
    ld a, $23
    ld [wD780], a
    ret

Jump_00C_6EA2::
    xor a, a
    ld [wD7F3], a
    ld [wD7F2], a
    ld [wD7F1], a
    ld a, $02
    jr Jump_00C_6E89

; entry 28 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommandF7_Run_Case1C::
Jump_00C_6EB0:: ; address name
    call ScriptCommandF7_Run_Case1C_Sub01
    ret

; entry 30 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD780, wD78E, wD786
; writes: wD780, wD7FB, wD7FF, wD7FC
ScriptCommandF7_Run_Case1E::
Jump_00C_6EB4:: ; address name
    call ScriptCommandF7_Run_Shared03
    ld a, [wD780]
    inc a
    ld [wD780], a
    ld [wD7FB], a
    ld a, [wD78E]
    xor a, a
    ld [wD7FF], a
    ld a, [wD786]
    xor a, a
    ld [wD7FC], a
    call Func_00C_6FCB
    ret

; entry 33 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommandF7_Run_Case21::
Jump_00C_6ED3:: ; address name
    call ScriptCommandF7_Run_Shared03
    ret

; entry 34 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD092, wC82C, wD780
; writes: wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wD780
ScriptCommandF7_Run_Case22::
Jump_00C_6ED7:: ; address name
    ld a, [wD092]
    and a, a
    jr nz, Jump_00C_6F02
    ld a, [wC82C]
    dec a
    dec a
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ld a, [wC82C]
    cp a, $01
    jr c, Jump_00C_6F01
    cp a, $05
    jr nc, Jump_00C_6F01
    ld a, [wD780]
    inc a
    inc a
    ld [wD780], a

Jump_00C_6F01::
    ret

Jump_00C_6F02::
    ld a, [wC82C]
    cp a, $03
    jr nc, Jump_00C_6F17
    xor a, a
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_00C_6F17::
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 35 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD092, wD780
; writes: wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wD780
ScriptCommandF7_Run_Case23::
Jump_00C_6F26:: ; address name
    ld a, [wD092]
    and a, a
    jr nz, Jump_00C_6F2E
    jr Jump_00C_6F30

Jump_00C_6F2E::
    jr Jump_00C_6F49

Jump_00C_6F30::
    call ScriptCommandF7_Run_Case23_Sub01
    xor a, a
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ld a, [wD780]
    inc a
    inc a
    ld [wD780], a
    ret

Jump_00C_6F49::
    farcall WritePlayerNameWithFlag0SuffixToWC130
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 36 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC82C, wC836, hFFC6
; writes: hFFC7, wC836, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wC892
; points at: wC130, wC60C
ScriptCommandF7_Run_Case24::
Jump_00C_6F5E:: ; address name
    ld a, [wC82C]
    cp a, $01
    jr nz, Jump_00C_6F8B
    ld de, $0188
    call SetFlagBit
    farcall CountKeysOrFull
    ld a, $03
    ldh [hFFC7], a
    farcall Func_012_6955
    ld a, [wC836]
    set 7, a
    ld [wC836], a
    ld de, $012F
    call SetFlagBit
    jr Jump_00C_6F99

Jump_00C_6F8B::
    farcall Func_012_689A
    ldh a, [hFFC6]
    ld [wC892], a
    and a, a
    jr z, Jump_00C_6FBC

Jump_00C_6F99::
    ld hl, wC130
    ld de, wC60C
    ld b, $0A

Jump_00C_6FA1::
    ld a, [de]
    cp a, $F0
    jr z, Jump_00C_6FAB
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_00C_6FA1

Jump_00C_6FAB::
    ld a, $F0
    ld [hl], a
    xor a, a
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_00C_6FBC::
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; 4 call sites from 4 routines (e.g. ScriptCommandF7_Run_Case1E, ScriptCommandF7_Run_Case1A, ScriptCommandF7_Run_Case07, ScriptCommandF4_Run_Case04_Case18)
; reads: wIsCGB
; writes: wD7F1, wD7F2
; points at: wC300, wC29C, wD168, wD104
Func_00C_6FCB::
    ld b, $00
    ld c, $0D
    ld hl, $01CC
    ld de, $0000
    xor a, a
    ld [wD7F1], a
    ld a, $14
    ld [wD7F2], a
    call Func_00C_72CC
    ld hl, wC300
    ld de, wC29C
    ld bc, $0064
    call CopyBytesDEToHL_Bank0C
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_00C_6FFF
    ld hl, wD168
    ld de, wD104
    ld bc, $0064
    call CopyLow3BitsToWRAMBank2_Bank0C

Jump_00C_6FFF::
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call DrawScreenBufferRect_Bank0C
    ret

; only called from ScriptCommandF7_Run_Case23 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandF7_Run_Case23)
; reads: wD7FC
; writes: wC130, wC131
ScriptCommandF7_Run_Case23_Sub01::
Func_00C_701C:: ; address name
    farcall WritePlayerNameWithFlag0SuffixToWC130
    ld a, [wD7FC]
    ld hl, Data_00C_7037
    add_a_to_hl
    ld a, [hl]
    ld [wC130], a
    ld a, $F0
    ld [wC131], a
    ret

Data_00C_7037:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0C, $0C, $0C, $0B, $0A, $1C

; wD588 += 1 and wD78C = wD7FC (E-0122)
; 3 call sites from 3 routines (e.g. ScriptCommandF7_Run_Case1B, ScriptCommand96_Run_Case0D, ScriptCommand96_Run_Case05)
; reads: wD588, wD7FC
; writes: wD588, wD78C
IncWD588AndCopyWD7FCToWD78C::
Func_00C_703D:: ; address name
    ld a, [wD588]
    inc a
    ld [wD588], a
    ld a, [wD7FC]
    ld [wD78C], a
    ret

; wD78E = wD7FF + 1 (and stored back to wD7FF), wD786 = wD7FC, wTwoChoiceCursor = 1 (E-0122)
; 5 call sites from 3 routines (e.g. ScriptCommandF7_Run_Case08, ScriptCommand95_Run_Case0E, ScriptCommand95_Run_Case06)
; reads: wD7FF, wD7FC, wD78E
; writes: wD78E, wD786, wTwoChoiceCursor, wD7FF
SetupWD78EFromWD7FF::
Func_00C_704B:: ; address name
    ld a, [wD7FF]
    inc a
    ld [wD78E], a
    ld a, [wD7FC]
    ld [wD786], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wD78E]
    ld [wD7FF], a
    ret

; only called from ScriptCommandF7_Run_Case01 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandF7_Run_Case01)
; reads: wC82C
; points at: wC3C9, wC3F1, wC419, wC441
ScriptCommandF7_Run_Case01_Sub01::
Func_00C_7064:: ; address name
    ld hl, wC3C9
    ld a, [wC82C]
    cp a, $02
    jr c, Jump_00C_7071
    ld a, $AD
    ld [hl], a

Jump_00C_7071::
    ld a, [wC82C]
    cp a, $03
    jr c, Jump_00C_707E
    ld hl, wC3F1
    ld a, $AD
    ld [hl], a

Jump_00C_707E::
    ld a, [wC82C]
    cp a, $04
    jr c, Jump_00C_708B
    ld hl, wC419
    ld a, $AD
    ld [hl], a

Jump_00C_708B::
    ld a, [wC82C]
    cp a, $05
    ret c
    ld hl, wC441
    ld a, $AD
    ld [hl], a
    ret

; only called from routines of ScriptCommandF7_Run (E-0098)
; 5 call sites from 5 routines (e.g. ScriptCommandF7_Run_Case19, ScriptCommandF7_Run_Case11, ScriptCommandF7_Run_Case10, ScriptCommandF7_Run_Case0B, ...)
; reads: wGoldLo, wGoldMid, wGoldHi
; writes: wC8C0, wC8C1, wC8C2
; points at: wC370, wC386, wD7F3
ScriptCommandF7_Run_Shared02::
Func_00C_7098:: ; address name
    ld de, Data_00C_777E
    ld hl, wC370
    ld bc, $0803
    call CopyRectTo20ByteRows_Bank0C
    ld a, [wGoldLo]
    ld [wC8C0], a
    ld a, [wGoldMid]
    ld [wC8C1], a
    ld a, [wGoldHi]
    ld [wC8C2], a
    call Number24ToPackedBCD
    farcall UnpackBCDToDigitsWD7F1_Bank1E
    ld hl, wC386
    ld de, wD7F3
    ld c, $00

Jump_00C_70C7::
    ld a, [de]
    add a, $E0
    ld [hl+], a
    inc de
    inc c
    ld a, c
    cp a, $05
    jr c, Jump_00C_70C7
    ret

; only called from ScriptCommandF7_Run_Shared05 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandF7_Run_Shared05)
; reads: wC6FD
; points at: wD580
ScriptCommandF7_Run_Shared05_Sub01::
Func_00C_70D3:: ; address name
    ld hl, $0000
    ld de, wD580
    ld c, $00

Jump_00C_70DB::
    push de
    push bc
    ld a, [de]
    add a, l
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    pop bc
    pop de
    inc de
    inc c
    ld a, [wC6FD]
    ld b, a
    ld a, c
    cp a, b
    jr c, Jump_00C_70DB
    ld a, [wC6FD]
    call DivideHLByA
    ld a, h
    and a, a
    ret z
    ld h, $00
    ld l, $FF
    ret

; only called from ScriptCommandF7_Run_Shared05 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandF7_Run_Shared05)
; reads: hFFC6, wC6FD
; writes: wD580, wD581, wD582, rRAMG2, rRAMB
; points at: wC6FE, wD580
ScriptCommandF7_Run_Shared05_Sub02::
Func_00C_70FE:: ; address name
    xor a, a
    ld [wD580], a
    ld [wD581], a
    ld [wD582], a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld de, wC6FE
    ld c, $00

Jump_00C_7116::
    push bc
    push de
    ld hl, $0000
    push hl
    ld a, [de]
    ld c, $5D
    call LoadSRAMRecordWord
    pop hl
    call AddHFFC6WordToHL
    pop de
    push de
    ld hl, $0000
    push hl
    ld a, [de]
    ld c, $61
    call LoadSRAMRecordWord
    pop hl
    call AddHFFC6WordToHL
    pop de
    push de
    push hl
    ld a, [de]
    ld c, $63
    call LoadSRAMRecordWord
    pop hl
    call AddHFFC6WordToHL
    pop de
    push de
    push hl
    ld a, [de]
    ld c, $65
    call LoadSRAMRecordWord
    pop hl
    call AddHFFC6WordToHL
    pop de
    push de
    push hl
    ld a, [de]
    ld c, $67
    call LoadSRAMRecordWord
    ld hl, $0000
    call AddHFFC6WordToHL
    ld c, l
    ld b, h
    pop hl
    pop de
    push de
    push hl
    push bc
    ld a, [de]
    ld c, $69
    call LoadSRAMRecordWord
    pop hl
    call AddHFFC6WordToHL
    srl h
    rr l
    ld c, l
    ld b, h
    pop hl
    add hl, bc
    ld a, $32
    call DivideHLByA
    ld a, h
    and a, a
    jr z, Jump_00C_7187
    ld h, $00
    ld l, $63
    jr Jump_00C_7190

Jump_00C_7187::
    ld a, l
    cp a, $64
    jr c, Jump_00C_7190
    ld h, $00
    ld l, $63

Jump_00C_7190::
    pop de
    pop bc
    push bc
    push de
    ld de, wD580
    ld a, c
    add a, e
    ld e, a
    jr nc, Jump_00C_719D
    inc d

Jump_00C_719D::
    ld a, l
    ld [de], a
    pop de
    push de
    ld hl, $0000
    push hl
    ld a, [de]
    ld c, $5D
    call LoadSRAMRecordWord
    pop hl
    call AddHFFC6WordToHL
    pop de
    push de
    ld hl, $0000
    push hl
    ld a, [de]
    ld c, $61
    call LoadSRAMRecordWord
    pop hl
    call AddHFFC6WordToHL
    pop de
    push de
    push hl
    ld a, [de]
    ld c, $63
    call LoadSRAMRecordWord
    pop hl
    call AddHFFC6WordToHL
    pop de
    push de
    push hl
    ld a, [de]
    ld c, $65
    call LoadSRAMRecordWord
    pop hl
    call AddHFFC6WordToHL
    pop de
    push de
    push hl
    ld a, [de]
    ld c, $67
    call LoadSRAMRecordWord
    pop hl
    call AddHFFC6WordToHL
    pop de
    push de
    push hl
    ld a, [de]
    ld c, $69
    call LoadSRAMRecordWord
    pop hl
    call AddHFFC6WordToHL
    pop de
    push de
    push hl
    ld a, [de]
    ld c, $56
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    ld c, $18
    call Multiply8
    ld b, h
    ld c, l
    pop hl
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    ld a, $32
    call DivideHLByA
    ld a, h
    and a, a
    jr z, Jump_00C_721B
    ld h, $00
    ld l, $63
    jr Jump_00C_7224

Jump_00C_721B::
    ld a, l
    cp a, $64
    jr c, Jump_00C_7224
    ld h, $00
    ld l, $63

Jump_00C_7224::
    pop de
    pop bc
    push bc
    push de
    ld de, wD580
    ld a, c
    add a, e
    ld e, a
    jr nc, Jump_00C_7231
    inc d

Jump_00C_7231::
    ld a, [de]
    add a, l
    ld [de], a
    pop de
    pop bc
    inc de
    inc c
    ld a, [wC6FD]
    ld b, a
    ld a, c
    cp a, b
    jp c, Jump_00C_7116
    xor a, a
    ld [rRAMG2], a
    ret

; HL += the word in hFFC6/hFFC7; clobbers A (E-0073)
; 12 call sites from 1 routine (e.g. ScriptCommandF7_Run_Shared05_Sub02)
; reads: hFFC6, hFFC7
AddHFFC6WordToHL::
Func_00C_7246:: ; address name
    ldh a, [hFFC6]
    add a, l
    ld l, a
    ldh a, [hFFC7]
    adc a, h
    ld h, a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: hFFC6, wC6FD
; writes: rRAMG2, rRAMB
; points at: wC6FE
Func_00C_724F:: ; heuristic: follows a terminator; C0
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld hl, wC6FE
    ld de, $0000
    ld c, $00

Jump_00C_7260::
    push bc
    push hl
    push de
    ld a, [hl]
    ld c, $56
    call LoadSRAMRecordByte
    pop de
    ldh a, [hFFC6]
    add a, e
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    pop hl
    pop bc
    inc hl
    inc c
    ld a, [wC6FD]
    ld b, a
    ld a, c
    cp a, b
    jr c, Jump_00C_7260
    xor a, a
    ld [rRAMG2], a
    ld a, d
    and a, a
    jr nz, Jump_00C_729E
    ld a, e
    cp a, $DC
    jr nc, Jump_00C_729E
    cp a, $B5
    jr nc, Jump_00C_72A2
    cp a, $8B
    jr nc, Jump_00C_72A6
    cp a, $5B
    jr nc, Jump_00C_72AA
    cp a, $31
    jr nc, Jump_00C_72AE
    xor a, a
    jr Jump_00C_72B0

Jump_00C_729E::
    ld a, $05
    jr Jump_00C_72B0

Jump_00C_72A2::
    ld a, $04
    jr Jump_00C_72B0

Jump_00C_72A6::
    ld a, $03
    jr Jump_00C_72B0

Jump_00C_72AA::
    ld a, $02
    jr Jump_00C_72B0

Jump_00C_72AE::
    ld a, $01

Jump_00C_72B0::
    sla a
    ld de, Data_00C_72C0
    add a, e
    ld e, a
    jr nc, Jump_00C_72BA
    inc d

Jump_00C_72BA::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ret

Data_00C_72C0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $90, $01, $58, $02, $20, $03, $B0, $04, $78, $05, $78, $05

; 7 call sites from 6 routines (e.g. ScriptCommandF7_Run_Case26, Func_00C_6FCB, ScriptCommandF7_Run_Case18, ScriptCommandF7_Run_Case13, ...)
; reads: wD7F1, wD7F2, wIsCGB
; points at: wScreenTileBuffer, wD000
Func_00C_72CC::
    push bc
    push hl
    push de
    ld de, wScreenTileBuffer
    add hl, de
    pop de
    push de
    push hl
    ld hl, wScreenTileBuffer
    add hl, de
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    pop hl
    ld a, [wD7F1]
    ld b, a
    ld a, [wD7F2]
    ld c, a
    call CopyBytesDEToHL_Bank0C
    pop de
    pop hl
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_00C_7311
    push hl
    push de
    ld de, wD000
    add hl, de
    pop de
    push de
    push hl
    ld hl, wD000
    add hl, de
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    pop hl
    ld a, [wD7F1]
    ld b, a
    ld a, [wD7F2]
    ld c, a
    call CopyLow3BitsToWRAMBank2_Bank0C
    pop de
    pop hl

Jump_00C_7311::
    pop bc
    ld a, $14
    add_a_to_hl
    ld a, $14
    add a, e
    ld e, a
    jr nc, Jump_00C_7320
    inc d

Jump_00C_7320::
    inc b
    ld a, b
    cp a, c
    jr c, Func_00C_72CC
    ret

; only called from ScriptCommand96_Run_Shared01 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommand96_Run_Shared01)
; reads: wD588, wD7FC
; points at: wD589, wD5B1
ScriptCommand96_Run_Shared01_Sub01::
Func_00C_7326:: ; address name
    ld hl, wD589
    ld b, $28

Jump_00C_732B::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_00C_732B
    ld a, [wD588]
    ld b, a
    ld c, $00

Jump_00C_7336::
    push bc
    ld b, $1F
    call RandomModulo52

Jump_00C_733C::
    ld de, Data_00C_78FF
    ld a, [wD7FC]
    add a, e
    ld e, a
    jr nc, Jump_00C_7347
    inc d

Jump_00C_7347::
    ld a, [de]
    ld b, a

Jump_00C_7349::
    ld a, l
    cp a, b
    jr c, Jump_00C_7351
    sub a, b
    ld l, a
    jr Jump_00C_733C

Jump_00C_7351::
    push hl
    ld hl, wD589
    add_a_to_hl
    ld a, [hl]
    cp a, $03
    jr c, Jump_00C_7363
    pop hl
    inc l
    jr Jump_00C_7349

Jump_00C_7363::
    inc a
    ld [hl], a
    pop hl
    ld b, l
    ld hl, Data_00C_7905
    ld a, [wD7FC]
    sla a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, b
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_00C_737E
    inc d

Jump_00C_737E::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld d, a
    ld e, l
    pop bc
    push bc
    ld a, b
    sla a
    ld l, a
    sla a
    add a, l
    ld hl, wD5B1
    add_a_to_hl
    ld a, c
    sla a
    add_a_to_hl
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl], a
    pop bc
    inc c
    ld a, c
    cp a, $03
    jp c, Jump_00C_7336
    ld c, $00
    inc b
    ld a, b
    cp a, $03
    jp c, Jump_00C_7336
    ret

; NextTableByte; L = wC5E7, H = (wC5E7 rotated left through carry) & B; returns A = HL mod $52 (E-0117)
; 3 call sites from 3 routines (e.g. ScriptCommandF7_Run_Case27, ScriptCommandF7_Run_Case27_Sub01, ScriptCommand96_Run_Shared01_Sub01)
; reads: wC5E7
RandomModulo52::
Func_00C_73B3:: ; address name
    push bc
    call NextTableByte
    pop bc
    ld a, [wC5E7]
    ld l, a
    rl a
    and a, b
    ld h, a
    ld a, $52
    call DivideHLByA
    ret

; only called from ScriptCommandF7_Run_Case1B (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandF7_Run_Case1B)
ScriptCommandF7_Run_Case1B_Sub01::
Func_00C_73C6:: ; address name
    ret

; only called from ScriptCommandF7_Run_Case1A (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandF7_Run_Case1A)
; reads: wScriptStartRequest, wScriptPointerLo, wScriptPointerHi, wD588
; writes: wC91C, wC91D, wC91E, wC917, wC916, wScriptInDataBank, hFFB9, wC903, ...
; points at: wD5B1, wCFDD
ScriptCommandF7_Run_Case1A_Sub01::
Func_00C_73C7:: ; address name
    ld a, [wScriptStartRequest]
    ld [wC91C], a
    ld a, [wScriptPointerLo]
    ld [wC91D], a
    ld a, [wScriptPointerHi]
    ld [wC91E], a
    xor a, a
    ld [wC917], a
    ld a, $1F
    ld [wC916], a
    farcall DispatchTalkEvent
    xor a, a
    ld [wScriptInDataBank], a
    xor a, a
    ldh [hFFB9], a
    farcall ClearBit1OfPlayerAndObjectFlags

; only called from routines of ScriptCommand96_Run (E-0098)
; 2 call sites from 2 routines (e.g. ScriptCommand96_Run_Case0D, ScriptCommand96_Run_Case05)
; reads: wD588
; writes: wC903, wCFDC
; points at: wD5B1, wCFDD
ScriptCommand96_Run_Shared01::
Func_00C_73F5:: ; address name
    ld a, $04
    ld [wC903], a
    ld a, $02
    ld [wCFDC], a
    call ScriptCommand96_Run_Shared01_Sub01

; only called from ScriptCommandF7_Run_Case1C (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandF7_Run_Case1C)
; reads: wD588
; points at: wD5B1, wCFDD
ScriptCommandF7_Run_Case1C_Sub01::
Func_00C_7402:: ; address name
    ld a, [wD588]
    sla a
    ld b, a
    sla a
    add a, b
    ld hl, wD5B1
    add_a_to_hl
    ld de, wCFDD
    ld b, $06

Jump_00C_7418::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_00C_7418
    ret

; only called from routines of ScriptCommandF7_Run (E-0098)
; 2 call sites from 2 routines (e.g. ScriptCommandF7_Run_Case21, ScriptCommandF7_Run_Case1E)
; reads: wScriptStartRequest, wScriptPointerLo, wScriptPointerHi, wD78E
; writes: wC91C, wC91D, wC91E, wC917, wC916, wScriptInDataBank, hFFB9, wC903, ...
; points at: wCFDD
ScriptCommandF7_Run_Shared03::
Func_00C_741F:: ; address name
    ld a, [wScriptStartRequest]
    ld [wC91C], a
    ld a, [wScriptPointerLo]
    ld [wC91D], a
    ld a, [wScriptPointerHi]
    ld [wC91E], a
    xor a, a
    ld [wC917], a
    ld a, $18
    ld [wC916], a
    farcall DispatchTalkEvent
    xor a, a
    ld [wScriptInDataBank], a
    xor a, a
    ldh [hFFB9], a
    farcall ClearBit1OfPlayerAndObjectFlags

; only called from routines of ScriptCommand95_Run (E-0098)
; 2 call sites from 2 routines (e.g. ScriptCommand95_Run_Case0E, ScriptCommand95_Run_Case06)
; reads: wD78E
; writes: wC903, wCFDC
; points at: wCFDD
ScriptCommand95_Run_Shared01::
Func_00C_744D:: ; address name
    ld a, $04
    ld [wC903], a
    ld a, $02
    ld [wCFDC], a
    ld hl, Data_00C_787D
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, [wD78E]
    sla a
    add a, e
    ld e, a
    jr nc, Jump_00C_7467
    inc d

Jump_00C_7467::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld de, wCFDD
    ld b, $06

Jump_00C_7471::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_00C_7471
    ret

; only called from routines of ScriptCommandF7_Run (E-0098)
; 2 call sites from 2 routines (e.g. ScriptCommandF7_Run_Case0A, ScriptCommandF7_Run_Case07)
; reads: wScriptStartRequest, wScriptPointerLo, wScriptPointerHi, wD786, wD78E
; writes: wC91C, wC91D, wC91E, wC917, wC916, wScriptInDataBank, hFFB9, wC903, ...
; points at: wCFDD
ScriptCommandF7_Run_Shared04::
Func_00C_7478:: ; address name
    ld a, [wScriptStartRequest]
    ld [wC91C], a
    ld a, [wScriptPointerLo]
    ld [wC91D], a
    ld a, [wScriptPointerHi]
    ld [wC91E], a
    xor a, a
    ld [wC917], a
    ld a, $18
    ld [wC916], a
    farcall DispatchTalkEvent
    xor a, a
    ld [wScriptInDataBank], a
    xor a, a
    ldh [hFFB9], a
    farcall ClearBit1OfPlayerAndObjectFlags

; only called from routines of ScriptCommand95_Run (E-0098)
; 2 call sites from 2 routines (e.g. ScriptCommand95_Run_Case0E, ScriptCommand95_Run_Case06)
; reads: wD786, wD78E
; writes: wC903, wCFDC
; points at: wCFDD
ScriptCommand95_Run_Shared02::
Func_00C_74A6:: ; address name
    ld a, $04
    ld [wC903], a
    ld a, $02
    ld [wCFDC], a
    ld a, [wD786]
    sla a
    ld hl, Data_00C_7897
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, [wD78E]
    sla a
    add a, e
    ld e, a
    jr nc, Jump_00C_74CA
    inc d

Jump_00C_74CA::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld de, wCFDD
    ld b, $06

Jump_00C_74D4::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_00C_74D4
    ret

; only called from routines of ScriptCommandF7_Run (E-0098)
; 2 call sites from 2 routines (e.g. ScriptCommandF7_Run_Case18, ScriptCommandF7_Run_Case10)
; writes: wTwoChoiceCursor
ScriptCommandF7_Run_Shared05::
Func_00C_74DB:: ; address name
    call ScriptCommandF7_Run_Shared05_Sub02
    call ScriptCommandF7_Run_Shared05_Sub01
    ld a, l
    cp a, $50
    jr nc, Jump_00C_74FA
    cp a, $3C
    jr nc, Jump_00C_74FD
    cp a, $28
    jr nc, Jump_00C_7501
    cp a, $1E
    jr nc, Jump_00C_7505
    cp a, $00
    jr nc, Jump_00C_7509
    ld a, $05
    jr Jump_00C_750B

Jump_00C_74FA::
    xor a, a
    jr Jump_00C_750B

Jump_00C_74FD::
    ld a, $01
    jr Jump_00C_750B

Jump_00C_7501::
    ld a, $02
    jr Jump_00C_750B

Jump_00C_7505::
    ld a, $03
    jr Jump_00C_750B

Jump_00C_7509::
    ld a, $04

Jump_00C_750B::
    ld [wTwoChoiceCursor], a
    ret

; only called from ScriptCommandF7_Run_Case27 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandF7_Run_Case27)
; writes: wD7F1
ScriptCommandF7_Run_Case27_Sub01::
Func_00C_750F:: ; address name
    ld b, $1F
    call RandomModulo52
    ld c, l
    ld a, l
    and a, $03
    sla a
    ld hl, Data_00C_7538
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, c

Jump_00C_7526::
    cp a, $07
    jr c, Jump_00C_752E
    sub a, $07
    jr Jump_00C_7526

Jump_00C_752E::
    add a, e
    ld e, a
    jr nc, Jump_00C_7533
    inc d

Jump_00C_7533::
    ld a, [de]
    ld [wD7F1], a
    ret

Data_00C_7538:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $40, $75, $47, $75, $4E, $75, $55, $75, $40, $41, $42, $43, $44, $45, $46, $47
    db $48, $49, $4A, $4B, $4C, $4D, $4E, $4F, $50, $51, $52, $53, $5A, $5B, $5C, $5D
    db $5E, $5F, $60, $61

; only called from ScriptCommandF7_Run_Case27 (E-0047)
; 2 call sites from 1 routine (e.g. ScriptCommandF7_Run_Case27)
; reads: wD7F1
; writes: wD7F1
; points at: wInventory
ScriptCommandF7_Run_Case27_Sub02::
Func_00C_755C:: ; address name
    ld hl, wInventory
    ld c, $18

Jump_00C_7561::
    ld a, [hl]
    and a, a
    jr z, Jump_00C_757E
    cp a, $FF
    jr z, Jump_00C_757E
    inc hl
    dec c
    jr nz, Jump_00C_7561
    ld a, [wD7F1]
    push af
    call ScriptCommandF7_Run_Shared06
    pop af
    ld [wD7F1], a
    call ScriptCommandF7_Run_Case27_Sub02_Sub01
    ld a, $02
    ret

Jump_00C_757E::
    ld a, [wD7F1]
    ld [hl], a
    call ScriptCommandF7_Run_Case27_Sub02_Sub01
    xor a, a
    ret

; only called from ScriptCommandF7_Run_Case27_Sub02 (E-0047)
; 2 call sites from 1 routine (e.g. ScriptCommandF7_Run_Case27_Sub02)
; reads: wD7F1
; points at: wC140
ScriptCommandF7_Run_Case27_Sub02_Sub01::
Func_00C_7587:: ; address name
    ld de, Data_008_403C
    ld b, $08
    call ReadFarPointerAtDEInBankB
    ld c, l
    ld b, h
    ld a, [wD7F1]
    ld e, a
    ld d, $00
    sla e
    rl d
    ld l, c
    ld h, b
    add hl, de
    ld e, l
    ld d, h
    ld b, $08
    call ReadFarPointerAtDEInBankB
    ld e, l
    ld d, h
    ld hl, wC140

Jump_00C_75AA::
    ld b, $08
    call ReadByteInBank
    ld a, c
    cp a, $F0
    jr z, Jump_00C_75B8
    ld [hl+], a
    inc de
    jr Jump_00C_75AA

Jump_00C_75B8::
    ld a, $F0
    ld [hl+], a
    ret

; only called from routines of ScriptCommandF7_Run (E-0098)
; 3 call sites from 2 routines (e.g. ScriptCommandF7_Run_Case27_Sub02, ScriptCommandF7_Run_Case27)
; writes: wD7F1, wD7F2, wD7F3
ScriptCommandF7_Run_Shared06::
Func_00C_75BC:: ; address name
    ld hl, $1770
    ld a, l
    ld [wD7F1], a
    ld a, h
    ld [wD7F2], a
    xor a, a
    ld [wD7F3], a
    farcall Func_01C_45B0
    ret

Data_00C_75D2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $DE, $75, $DE, $75, $DE, $75, $E7, $75, $F0, $75, $F9, $75, $19, $23, $2D, $37
    db $41, $4B, $5F, $64, $FF, $14, $1F, $2A, $35, $40, $4B, $5A, $64, $FF, $0F, $17
    db $1F, $27, $2F, $37, $50, $64, $FF, $0A, $15, $20, $2B, $36, $41, $50, $64, $FF

Data_00C_7602:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0E, $76, $0E, $76, $0E, $76, $16, $76, $1E, $76, $26, $76, $01, $53, $05, $0C
    db $24, $0B, $1C, $44, $02, $18, $0F, $10, $13, $15, $45, $FE, $03, $0D, $11, $12
    db $17, $2C, $FD, $FE, $23, $2C, $0D, $0E, $17, $FD, $1E, $FE

Data_00C_762E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $03362E, $99

Data_00C_76C7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C3, $C3, $B7, $E0, $BF, $B7, $C3, $C3, $B7, $E0, $BF, $B7, $B4, $B4, $B5

Data_00C_76D6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0336D6, $99

Data_00C_776F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C3, $C3, $B7, $BF, $C3, $B7, $C3, $C3, $B7, $BF, $C3, $B7, $B4, $B4, $B5

Data_00C_777E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $03377E, $B3

Data_00C_7831:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $CE, $CF, $DF, $B7, $B6, $C3, $C3, $C3
    db $C3, $B7, $B6, $C3, $AE, $AF, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B5

Data_00C_784F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $CA, $C3, $F2, $C3, $1A, $C4, $42, $C4

Data_00C_7857:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C9, $C3, $F1, $C3, $19, $C4, $41, $C4, $8D, $C3, $8F, $C3, $91, $C3, $8D, $C3
    db $8F, $C3, $91, $C3, $B5, $C3, $B7, $C3, $B9, $C3

Data_00C_7871:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $64, $00, $F4, $01, $E8, $03, $88, $13, $02, $04, $08, $10

Data_00C_787D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $7F, $78, $85, $78, $8B, $78, $91, $78, $83, $00, $84, $00, $83, $00, $85, $00
    db $86, $00, $87, $00, $88, $00, $89, $00, $88, $00

Data_00C_7897:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $033897, $68

Data_00C_78FF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $27, $27, $27, $27, $27, $27

Data_00C_7905:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $033905, $342
    ds $3B9, $00
