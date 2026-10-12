SECTION "Bank 0C", ROMX[$4000], BANK[$0C]
    db $0C

; implements script command type F6; reached through ScriptCommandF6 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommandF6)
; reads: wScreenState
ScriptCommandF6_Run::
Func_00C_4001:: ; address name
    ld a, [wScreenState]
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
; reads: wScreenState
; writes: wMessageMode, wScreenState, wScriptCommandType, wScriptStartRequest
; points at: wScreenState
ScriptCommandF6_Run_Case00::
Jump_00C_4027:: ; address name
    ld hl, wScreenState
    ld bc, $0020

Jump_00C_402D::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_00C_402D
    ld a, $09
    ld [wMessageMode], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 1 of the `rst $00` table in ScriptCommandF6_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hSpriteWindowClipMode, hSpriteHideTile, rSTAT, wScreenState
; writes: hScrollY, hScrollX, wScreenByte99, wScreenByte9A, hSpriteHideTile, hSpriteWindowClipMode, hFieldDrawFlags, wScreenState
ScriptCommandF6_Run_Case01::
Jump_00C_404A:: ; address name
    call ScriptCommandF6_Run_Shared06
    xor a, a
    ldh [hScrollY], a
    ldh [hScrollX], a
    ldh a, [hSpriteWindowClipMode]
    ld [wScreenByte99], a
    ldh a, [hSpriteHideTile]
    ld [wScreenByte9A], a
    ld a, $90
    ldh [hSpriteHideTile], a
    ld a, $01
    ldh [hSpriteWindowClipMode], a
    ld a, $0F
    ldh [hFieldDrawFlags], a
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
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; entry 2 of the `rst $00` table in ScriptCommandF6_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wScreenState
ScriptCommandF6_Run_Case02::
Jump_00C_4087:: ; address name
    call ClearStringWindowAt2020
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; entry 3 of the `rst $00` table in ScriptCommandF6_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wGridCursorY, wGridCursorX, wScreenState
; writes: wWindowTileBuffer, wScreenState
ScriptCommandF6_Run_Case03::
Jump_00C_4092:: ; address name
    ld de, TileRect_0C_56D9
    ld hl, wWindowTileBuffer + $64
    ld bc, $090D
    call CopyRectTo20ByteRows_Bank0C
    ld a, [wGridCursorY]
    and a, a
    jr z, Jump_00C_40A9
    ld a, $C3
    ld [wWindowTileBuffer + $145], a

Jump_00C_40A9::
    ld a, [wGridCursorX]
    ld hl, Data_00C_58FE
    ld b, $BB
    call StoreBAtWordTableEntry_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    ld a, [wGridCursorX]
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
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; entry 4 of the `rst $00` table in ScriptCommandF6_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wGridCursorY, wArg5, wScreenState
; writes: wArg1, wArg2, wArg3, wArg4, wScreenState, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, ...
; points at: wMonsterLibraryBuf, wScreenCountPlusOne
ScriptCommandF6_Run_Case04::
Jump_00C_40E6:: ; address name
    call BGMapAddressAtScroll_Bank0C
    ld de, $0182
    add hl, de
    ld a, [wGridCursorY]
    add a, $E1
    ld b, a
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl+], a
    ei
    ld c, $00

Jump_00C_40FC::
    ld a, [wGridCursorY]
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
    ld [wArg1], a
    ld a, d
    ld [wArg2], a
    ld de, wMonsterLibraryBuf
    ld a, e
    ld [wArg3], a
    ld a, d
    ld [wArg4], a
    farcall TestBitInFieldAtArg3
    ld a, [wArg5]
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
    ld a, [wGridCursorY]
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
    ld a, [wGridCursorY]
    add a, a
    ld b, a
    add a, a
    add a, b
    ld hl, wScreenCountPlusOne
    add_a_to_hl
    pop bc
    ld a, c
    add_a_to_hl
    ld a, b
    ld [hl], a
    ld a, [wGridCursorY]
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
    ld [wArg1], a
    call ScriptCommandF6_Run_Shared04
    ld a, $01
    ld [wArg1], a
    call ScriptCommandF6_Run_Shared04
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ret

; entry 5 of the `rst $00` table in ScriptCommandF6_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wScreenState, wGridCursorY, wGridCursorX
; writes: wScreenState, wTwoChoiceCursor, hSpriteWindowClipMode, hSpriteHideTile, wScriptCommandType, wScriptStartRequest, wWindowTileBuffer, wGridCursorX, ...
; points at: wScreenCountPlusOne
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
    ld a, [wGridCursorY]
    cp a, $01
    jr c, Jump_00C_4205
    xor a, a
    jr Jump_00C_4206

Jump_00C_4205::
    inc a

Jump_00C_4206::
    ld [wGridCursorY], a
    cp a, $01
    jr c, Jump_00C_4218
    ld a, [wGridCursorX]
    cp a, $05
    jr c, Jump_00C_4218
    dec a
    ld [wGridCursorX], a

Jump_00C_4218::
    call ScriptCommandF6_Run_Case05_Sub02
    ld a, $69
    call QueueSoundEffect
    ld a, [wScreenState]
    sub a, $03
    ld [wScreenState], a
    ret

Jump_00C_4229::
    ld a, [wGridCursorY]
    and a, a
    jr nz, Jump_00C_4233
    ld a, $01
    jr Jump_00C_4206

Jump_00C_4233::
    dec a
    jr Jump_00C_4206

Jump_00C_4236::
    call ScriptCommandF6_Run_Case05_Sub03
    ld a, [wGridCursorY]
    ld de, Data_00C_56D7
    add a, e
    ld e, a
    jr nc, Jump_00C_4244
    inc d

Jump_00C_4244::
    ld a, [de]
    ld b, a
    ld a, [wGridCursorX]
    and a, a
    jr nz, Jump_00C_424F
    ld a, b
    jr Jump_00C_4250

Jump_00C_424F::
    dec a

Jump_00C_4250::
    ld [wGridCursorX], a
    call ScriptCommandF6_Run_Case05_Sub02
    ld a, $69
    call QueueSoundEffect
    ret

Jump_00C_425C::
    call ScriptCommandF6_Run_Case05_Sub03
    ld a, [wGridCursorY]
    ld de, Data_00C_56D7
    add a, e
    ld e, a
    jr nc, Jump_00C_426A
    inc d

Jump_00C_426A::
    ld a, [de]
    ld b, a
    ld a, [wGridCursorX]
    cp a, b
    jr c, Jump_00C_4275
    xor a, a
    jr Jump_00C_4250

Jump_00C_4275::
    inc a
    jr Jump_00C_4250

Jump_00C_4278::
    ld a, [wGridCursorY]
    add a, a
    ld b, a
    add a, a
    add a, b
    ld b, a
    ld a, [wGridCursorX]
    add a, b
    ld hl, wScreenCountPlusOne
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
    ld a, [wGridCursorX]
    ld hl, Data_00C_58FE
    ld b, $BC
    call StoreBAtWordTableEntry_Bank0C
    ld a, [wGridCursorY]
    add a, $E1
    ld [wWindowTileBuffer + $156], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenState]
    add a, $04
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_00C_42D3::
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ld a, $02
    ld [wTwoChoiceCursor], a
    ld a, $02
    ldh [hSpriteWindowClipMode], a
    xor a, a
    ldh [hSpriteHideTile], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; only called from ScriptCommandF6_Run_Case05 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandF6_Run_Case05)
; reads: wJoypadRepeatTimer, wGlyphListStart, wGridCursorX
; writes: wGlyphListStart
ScriptCommandF6_Run_Case05_Sub01::
Func_00C_42F0:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, ScriptCommandF6_Run_Case05_Sub02
    ld a, [wGlyphListStart]
    inc a
    ld [wGlyphListStart], a
    cp a, $10
    jr c, ScriptCommandF6_Run_Case05_Sub02
    cp a, $18
    jr c, ScriptCommandF6_Run_Case05_Sub03
    xor a, a
    ld [wGlyphListStart], a

; only called from ScriptCommandF6_Run_Case05 (E-0047)
; 2 call sites from 1 routine (e.g. ScriptCommandF6_Run_Case05)
; reads: wGridCursorX
ScriptCommandF6_Run_Case05_Sub02::
Func_00C_430A:: ; address name
    ld b, $BB
    jr Jump_00C_4314

; only called from ScriptCommandF6_Run_Case05 (E-0047)
; 2 call sites from 1 routine (e.g. ScriptCommandF6_Run_Case05)
; reads: wGridCursorX
ScriptCommandF6_Run_Case05_Sub03::
Func_00C_430E:: ; address name
    ld b, $C3
    jr Jump_00C_4314

; only called from ScriptCommandF6_Run_Case05 (E-0047)
; 2 call sites from 1 routine (e.g. ScriptCommandF6_Run_Case05)
; reads: wGridCursorX
ScriptCommandF6_Run_Case05_Sub04::
Func_00C_4312:: ; address name
    ld b, $BC

Jump_00C_4314::
    ld a, [wGridCursorX]
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

; address loaded by ScriptCommandF6_Run_Case05_Sub04
Data_00C_4331:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $21, $00, $61, $00, $A1, $00, $E1, $00, $21, $01, $61, $01

; entry 6 of the `rst $00` table in ScriptCommandF6_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: hMapId, wOBJPaletteUploadRequest, wScreenState
ScriptCommandF6_Run_Case06::
Jump_00C_433D:: ; address name
    call ScriptCommandF6_Run_Shared06
    ld a, $11
    ldh [hMapId], a
    call LoadMapHeader
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    farcall LoadMapObjectsForScreen
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; entry 7 of the `rst $00` table in ScriptCommandF6_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wScreenByte99, wScreenByte9A, wScreenState
; writes: hSpriteWindowClipMode, hSpriteHideTile, hFieldDrawFlags, wScreenState, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, ...
; points at: wScreenTileBuffer, wScreenAttrBuffer
ScriptCommandF6_Run_Case07::
Jump_00C_4360:: ; address name
    ld hl, wWindowTileBuffer + $64
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank0C
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_00C_437E
    ld hl, wWindowAttrBuffer + $64
    ld de, wScreenAttrBuffer
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
    ld a, [wScreenByte99]
    ldh [hSpriteWindowClipMode], a
    ld a, [wScreenByte9A]
    ldh [hSpriteHideTile], a
    xor a, a
    ldh [hFieldDrawFlags], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 8 of the `rst $00` table in ScriptCommandF6_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wMessageMode, wScriptCommandType, wScriptStartRequest
; points at: wScreenState, wTextBuf0
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
    ld [wMessageMode], a
    ld hl, wScreenState
    ld bc, $0020

Jump_00C_4402::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_00C_4402
    ld hl, wTextBuf0
    ld b, $10

Jump_00C_440E::
    ld a, $F0
    ld [hl+], a
    dec b
    jr nz, Jump_00C_440E
    farcall WritePlayerNameWithFlag0SuffixToTextBuf0
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
; reads: wScreenState
; writes: wScreenState
ScriptCommandF6_Run_Case09::
Jump_00C_443D:: ; address name
    call ClearStringWindowAt2200
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; entry 10 of the `rst $00` table in ScriptCommandF6_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wGrid2CursorX, wScreenState
; writes: wWindowTileBuffer, wScreenState
ScriptCommandF6_Run_Case0A::
Jump_00C_4448:: ; address name
    ld de, TileRect_0C_574E
    ld hl, wWindowTileBuffer + $6C
    ld bc, $0C0D
    call CopyRectTo20ByteRows_Bank0C
    call GridIndexFromGridCursorXGridCursorY
    ld de, Data_00C_5944
    add a, e
    ld e, a
    jr nc, Jump_00C_445F
    inc d

Jump_00C_445F::
    ld a, [de]
    add a, $E1
    ld [wWindowTileBuffer + $165], a
    ld a, [wGrid2CursorX]
    ld hl, Data_00C_590A
    ld b, $BB
    call StoreBAtWordTableEntry_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    ld a, [wGrid2CursorX]
    ld hl, Data_00C_590A
    ld b, $C3
    call StoreBAtWordTableEntry_Bank0C
    call ScriptCommandF6_Run_Shared01
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; entry 11 of the `rst $00` table in ScriptCommandF6_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wScreenState
ScriptCommandF6_Run_Case0B::
Jump_00C_4492:: ; address name
    call ScriptCommandF6_Run_Shared03
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; entry 12 of the `rst $00` table in ScriptCommandF6_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wScreenState, wGrid2CursorX, wGrid2CursorY
; writes: wScreenState, wTwoChoiceCursor, wGrid2CursorX, wGrid2CursorY, wScriptCommandType, wScriptStartRequest
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
    call GridIndexFromGridCursorXGridCursorY
    ld de, Data_00C_5944
    add a, e
    ld e, a
    jr nc, Jump_00C_44CE
    inc d

Jump_00C_44CE::
    ld a, [de]
    ld b, a
    ld a, [wGrid2CursorY]
    cp a, b
    jr c, Jump_00C_44D9
    xor a, a
    jr Jump_00C_44DA

Jump_00C_44D9::
    inc a

Jump_00C_44DA::
    ld [wGrid2CursorY], a
    push af
    call GridIndexFromGridCursorXGridCursorY
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
    call ReadGridCellByteForGridCursorXGridCursorY
    ld b, a
    ld a, [wGrid2CursorX]
    cp a, b
    jr c, Jump_00C_450B
    ld a, b
    ld [wGrid2CursorX], a
    ld a, [wScreenState]
    sub a, $03
    ld [wScreenState], a
    ld a, $69
    call QueueSoundEffect
    ret

Jump_00C_450B::
    call ScriptCommandF6_Run_Case0C_Sub02
    ld a, [wScreenState]
    sub a, $03
    ld [wScreenState], a
    ld a, $69
    call QueueSoundEffect
    ret

Jump_00C_451C::
    ld a, [wGrid2CursorY]
    and a, a
    jr nz, Jump_00C_4530
    call GridIndexFromGridCursorXGridCursorY
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
    call ReadGridCellByteForGridCursorXGridCursorY
    ld b, a
    ld a, [wGrid2CursorX]
    and a, a
    jr nz, Jump_00C_4543
    ld a, b
    jr Jump_00C_4544

Jump_00C_4543::
    dec a

Jump_00C_4544::
    ld [wGrid2CursorX], a
    call ScriptCommandF6_Run_Case0C_Sub02
    ld a, $69
    call QueueSoundEffect
    ret

Jump_00C_4550::
    call ScriptCommandF6_Run_Case0C_Sub03
    call ReadGridCellByteForGridCursorXGridCursorY
    ld b, a
    ld a, [wGrid2CursorX]
    cp a, b
    jr c, Jump_00C_4560
    xor a, a
    jr Jump_00C_4544

Jump_00C_4560::
    inc a
    jr Jump_00C_4544

Jump_00C_4563::
    call GridIndexFromGridCursorXGridCursorY
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
    call GridIndexFromGrid2CursorXGrid2CursorY
    pop hl
    add_a_to_hl
    call ScriptCommandF6_Run_Shared08
    and a, a
    jr z, Jump_00C_459B
    ld a, $69
    call QueueSoundEffect
    ld a, [wScreenState]
    add a, $03
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_00C_459B::
    call ScriptCommandF6_Run_Case0C_Sub02
    ret

Jump_00C_459F::
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wGrid2CursorX], a
    ld [wGrid2CursorY], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; only called from ScriptCommandF6_Run_Case0C (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandF6_Run_Case0C)
; reads: wJoypadRepeatTimer, wListEntries, wGrid2CursorX
; writes: wListEntries
ScriptCommandF6_Run_Case0C_Sub01::
Func_00C_45BC:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, ScriptCommandF6_Run_Case0C_Sub02
    ld a, [wListEntries]
    inc a
    ld [wListEntries], a
    cp a, $10
    jr c, ScriptCommandF6_Run_Case0C_Sub02
    cp a, $18
    jr c, ScriptCommandF6_Run_Case0C_Sub03
    xor a, a
    ld [wListEntries], a

; only called from ScriptCommandF6_Run_Case0C (E-0047)
; 3 call sites from 1 routine (e.g. ScriptCommandF6_Run_Case0C)
; reads: wGrid2CursorX
ScriptCommandF6_Run_Case0C_Sub02::
Func_00C_45D6:: ; address name
    ld b, $BB
    jr Jump_00C_45E0

; only called from ScriptCommandF6_Run_Case0C (E-0047)
; 2 call sites from 1 routine (e.g. ScriptCommandF6_Run_Case0C)
; reads: wGrid2CursorX
ScriptCommandF6_Run_Case0C_Sub03::
Func_00C_45DA:: ; address name
    ld b, $C3
    jr Jump_00C_45E0
    db $06, $BC

Jump_00C_45E0::
    ld a, [wGrid2CursorX]
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

; address loaded by ScriptCommandF6_Run_Case0C_Sub03
Data_00C_45FD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $29, $00, $69, $00, $A9, $00, $E9, $00, $29, $01, $69, $01

; entry 13 of the `rst $00` table in ScriptCommandF6_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wArg1, wScreenState, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScriptCommandType, wScriptStartRequest
ScriptCommandF6_Run_Case0D::
Jump_00C_4609:: ; address name
    ld de, TileRect_0C_57EA
    ld hl, wWindowTileBuffer + $6C
    ld bc, $0C0D
    call CopyRectTo20ByteRows_Bank0C
    ld a, $01
    ld [wArg1], a
    call ScriptCommandF6_Run_Shared04
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 14 of the `rst $00` table in ScriptCommandF6_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wGridCursorX
; writes: wScreenState, wScriptCommandType, wScriptStartRequest
ScriptCommandF6_Run_Case0E::
Jump_00C_4650:: ; address name
    ld a, [wGridCursorX]
    ld hl, Data_00C_58FE
    ld b, $C3
    call StoreBAtWordTableEntry_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    ld a, $05
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 15 of the `rst $00` table in ScriptCommandF6_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wScreenState
ScriptCommandF6_Run_Case0F::
Jump_00C_4676:: ; address name
    call ScriptCommandF6_Run_Shared06
    call ScriptCommandF6_Run_Shared05
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; entry 16 of the `rst $00` table in ScriptCommandF6_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
ScriptCommandF6_Run_Case10::
Jump_00C_4684:: ; address name
    ld a, [wScreenStep]
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
; reads: wScreenStep
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScreenStep, wScreenSubStep
ScriptCommandF6_Run_Case10_Case00::
Jump_00C_46A4:: ; address name
    call ScriptCommandF6_Run_Shared07
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld hl, Tiles_0C_4718
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
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    ret

; E-0237 (C1: ScriptCommandF6 code loads HL = $4718 and DE = vTiles2 + $610 and calls CopyTileBytesToVRAM_Bank0C six times, 16 bytes each).
; record: tile (16 bytes, 2 bits per pixel)
Tiles_0C_4718::
Data_00C_4718:: ; address name
    db $FF, $03, $FF, $03, $FF, $03, $FF, $FF, $FF, $FF, $FF, $03, $FF, $03, $FF, $03 ; id 0
    db $FF, $00, $FF, $00, $FF, $00, $FF, $03, $FF, $03, $FF, $03, $FF, $03, $FF, $03 ; id 1
    db $FF, $03, $FF, $03, $FF, $03, $FF, $03, $FF, $03, $FF, $00, $FF, $00, $FF, $00 ; id 2
    db $FF, $00, $FF, $00, $FF, $00, $FF, $FF, $FF, $FF, $FF, $00, $FF, $00, $FF, $00 ; id 3
    db $FF, $00, $FF, $00, $FF, $00, $FF, $FF, $FF, $FF, $FF, $60, $FF, $60, $FF, $60 ; id 4
    db $FF, $60, $FF, $60, $FF, $60, $FF, $FF, $FF, $FF, $FF, $00, $FF, $00, $FF, $00 ; id 5

; entry 1 of the `rst $00` table in ScriptCommandF6_Run_Case10
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep, wIsCGB, wScreenStep
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, rSVBK, wBGPaletteUploadRequest, wScreenStep, wScreenSubStep
; points at: wWindowTileBuffer, wWindowAttrBuffer, wScreenBlock9C
ScriptCommandF6_Run_Case10_Case01::
Jump_00C_4778:: ; address name
    ld a, [wScreenSubStep]
    and a, a
    jr nz, Jump_00C_47E9
    ld hl, vTiles1 + $220
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld de, Data_0F1_5C14
    ld hl, vTiles1
    ld b, $F1
    call DecompressToVRAM
    ld de, Data_0F1_5D44
    ld hl, wWindowTileBuffer + $64
    ld b, $F1
    call DecompressToVRAM
    ld de, Data_0F1_5D9C
    ld hl, wWindowTileBuffer
    ld b, $F1
    call DecompressToVRAM
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_00C_47E9
    ld a, $02
    ldh [rSVBK], a
    ld de, Data_0F1_5DBC
    ld hl, wWindowAttrBuffer + $64
    ld b, $F1
    call DecompressToVRAM
    ld de, Data_0F1_5DEE
    ld hl, wWindowAttrBuffer
    ld b, $F1
    call DecompressToVRAM
    xor a, a
    ldh [rSVBK], a
    farcall LoadBGPalettesFrom5E04
    ld a, $7F
    ld [wBGPaletteUploadRequest], a
    call UploadBGPalettes

Jump_00C_47E9::
    ld de, TileRect_0C_48AB
    ld hl, wWindowTileBuffer + $81
    ld bc, $0A01
    call CopyRectTo20ByteRows_Bank0C
    ld de, TileRect_0C_48B5
    ld hl, wWindowTileBuffer + $BD
    ld bc, $0A01
    call CopyRectTo20ByteRows_Bank0C
    ld de, TileRect_0C_48BF
    ld hl, wWindowTileBuffer + $E5
    ld bc, $0A01
    call CopyRectTo20ByteRows_Bank0C
    ld de, TileRect_0C_48C9
    ld hl, wWindowTileBuffer + $10D
    ld bc, $0901
    call CopyRectTo20ByteRows_Bank0C
    ld de, TileRect_0C_48D2
    ld hl, wWindowTileBuffer + $135
    ld bc, $0901
    call CopyRectTo20ByteRows_Bank0C
    ld de, TileRect_0C_48DB
    ld hl, wWindowTileBuffer + $15D
    ld bc, $0901
    call CopyRectTo20ByteRows_Bank0C
    ld de, TileRect_0C_48E4
    ld hl, wWindowTileBuffer + $15
    ld bc, $1201
    call CopyRectTo20ByteRows_Bank0C
    ld de, TileRect_0C_48F6
    ld hl, wWindowTileBuffer + $3D
    ld bc, $1201
    call CopyRectTo20ByteRows_Bank0C
    call ScriptCommandF6_Run_Case10_Case01_Sub01
    ld de, wScreenBlock9C
    ld hl, wWindowTileBuffer + $108
    ld bc, $0201
    call CopyRectTo20ByteRows_Bank0C
    call ScriptCommandF6_Run_Case10_Case01_Sub02
    ld de, wScreenBlock9C
    ld hl, wWindowTileBuffer + $130
    ld bc, $0401
    call CopyRectTo20ByteRows_Bank0C
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_00C_4883
    ld a, $02
    ldh [rSVBK], a
    ld hl, wWindowAttrBuffer + $130
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
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 10 x 1 tiles, one row per line
TileRect_0C_48AB::
Data_00C_48AB:: ; address name
    db $2F, $26, $27, $28, $29, $2A, $2B, $2C, $2D, $2E ; id 0

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 10 x 1 tiles, one row per line
TileRect_0C_48B5::
Data_00C_48B5:: ; address name
    db $42, $30, $31, $32, $33, $34, $35, $36, $37, $38 ; id 0

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 10 x 1 tiles, one row per line
TileRect_0C_48BF::
Data_00C_48BF:: ; address name
    db $43, $39, $3A, $3B, $3C, $3D, $3E, $3F, $40, $41 ; id 0

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 9 x 1 tiles, one row per line
TileRect_0C_48C9::
Data_00C_48C9:: ; address name
    db $44, $45, $46, $47, $48, $49, $4A, $4B, $4C ; id 0

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 9 x 1 tiles, one row per line
TileRect_0C_48D2::
Data_00C_48D2:: ; address name
    db $4D, $4E, $4F, $50, $51, $52, $53, $54, $55 ; id 0

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 9 x 1 tiles, one row per line
TileRect_0C_48DB::
Data_00C_48DB:: ; address name
    db $56, $57, $58, $59, $5A, $5B, $5C, $5D, $5E ; id 0

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 18 x 1 tiles, one row per line
TileRect_0C_48E4::
Data_00C_48E4:: ; address name
    db $A2, $A3, $A4, $A5, $A6, $A7, $A8, $A9, $AA, $AB, $AC, $AD, $AE, $AF, $B0, $B1, $B2, $B3 ; id 0

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 18 x 1 tiles, one row per line
TileRect_0C_48F6::
Data_00C_48F6:: ; address name
    db $B4, $B5, $B6, $B7, $B8, $B9, $BA, $BB, $BC, $BD, $BE, $BF, $C0, $C1, $C2, $C3, $C4, $C5 ; id 0
    db $7E, $7F

; entry 2 of the `rst $00` table in ScriptCommandF6_Run_Case10
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep, wIsCGB, wScreenStep
; writes: wArg5, wArg6, wArg1, wArg2, wArg3, wArg4, wArg7, wScreenSubStep, ...
ScriptCommandF6_Run_Case10_Case02::
Jump_00C_490A:: ; address name
    ld a, [wScreenSubStep]
    and a, a
    jp nz, Jump_00C_4957
    call BGMapAddressAtScroll_Bank0C
    ld de, $0021
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, TileRect_1F_651B
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $06
    ld [wArg3], a
    ld a, $06
    ld [wArg4], a
    ld a, $00
    ld [wArg7], a
    farcall DrawTileRectFromArg1Params
    call GridCellAddressFromGridCursorXAndGrid2CursorX
    ld e, l
    ld d, h
    push de
    ld hl, vTiles2 + $20
    ld c, $04
    call LoadMonsterPicture
    pop de
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

Jump_00C_4957::
    call GridCellAddressFromGridCursorXAndGrid2CursorX
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_00C_497A
    ld e, l
    ld d, h
    push de
    ld a, $7F
    ld [wBGPaletteUploadRequest], a
    call UploadBGPalettes
    ld a, $04
    ldh [hTemp0], a
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
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, TileRect_1F_64D3
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $06
    ld [wArg3], a
    ld a, $06
    ld [wArg4], a
    ld a, $01
    ld [wArg7], a
    farcall DrawTileRectFromArg1Params
    xor a, a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 3 of the `rst $00` table in ScriptCommandF6_Run_Case10
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg1, wArg2, wArg3, wArg4, wArg5, wScreenStep
ScriptCommandF6_Run_Case10_Case03::
Jump_00C_49B5:: ; address name
    call GridCellAddressFromGridCursorXAndGrid2CursorX
    ld a, l
    ld [wArg1], a
    ld a, h
    ld [wArg2], a
    xor a, a
    ld [wArg3], a
    ld [wArg4], a
    ld a, $80
    ld [wArg5], a
    farcall DecompressGraphicsArg1ToArg4
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 4 of the `rst $00` table in ScriptCommandF6_Run_Case10
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wStringCategory, wStringIndex, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wWorkBuf, wArg1, ...
; points at: wArg5
ScriptCommandF6_Run_Case10_Case04::
Jump_00C_49DA:: ; address name
    call DrawThreeMetaSpritePartsFor5050
    call GridCellAddressFromGridCursorXAndGrid2CursorX
    ld a, h
    add a, $02
    ld [wStringCategory], a
    ld a, l
    ld [wStringIndex], a
    ld hl, vTiles2 + $260
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0901
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    farcall ShowString_Bank08
    call GridIndexFromGridCursorXGridCursorY
    and a, $0F
    ld [wWorkBuf], a
    ld a, $2F
    ld [wWorkBuf + $1], a
    farcall LoadFamilyIconTileForWorkBuf
    call GridIndexFromGridCursorXGridCursorY
    ld [wStringIndex], a
    ld a, $02
    ld [wStringCategory], a
    ld hl, vTiles2 + $670
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0701
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    farcall ShowString_Bank0B
    call GridCellAddressFromGridCursorXAndGrid2CursorX
    ld a, l
    ld [wArg1], a
    ld a, h
    ld [wArg2], a
    farcall LoadSpeciesBytes8To10ToArg5
    farcall PermuteArg5To7ByMonster
    ld a, $04
    ld [wStringCategory], a
    ld hl, wArg5
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
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0901
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    farcall ShowString_Bank08
    pop bc
    pop hl
    inc hl
    inc c
    ld a, c
    cp a, $03
    jr c, Jump_00C_4A61
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; address loaded by ScriptCommandF6_Run_Case10_Case04
Data_00C_4AA0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $40, $94, $D0, $94, $60, $95

; entry 5 of the `rst $00` table in ScriptCommandF6_Run_Case10
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wStringCategory, wStringIndex, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScreenStep
ScriptCommandF6_Run_Case10_Case05::
Jump_00C_4AA6:: ; address name
    call DrawThreeMetaSpritePartsFor5050
    call GridCellAddressFromGridCursorXAndGrid2CursorX
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
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0901
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    farcall ShowString_Bank0B
    ld hl, vTiles2 + $390
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    farcall ShowString_Bank0B
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    ret

Jump_00C_4B0A::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 6 of the `rst $00` table in ScriptCommandF6_Run_Case10
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
ScriptCommandF6_Run_Case10_Case06::
Jump_00C_4B12:: ; address name
    call DrawThreeMetaSpritePartsFor5050
    call GridCellAddressFromGridCursorXAndGrid2CursorX
    push hl
    sla l
    rl h
    ld de, MonsterPedigreeTableA
    add hl, de
    ld a, $42
    call ScriptCommandF6_Run_Case10_Case06_Sub02
    pop hl
    push hl
    sla l
    rl h
    ld de, MonsterPedigreeTableB
    add hl, de
    ld a, $43
    call ScriptCommandF6_Run_Case10_Case06_Sub02
    pop hl
    push hl
    sla l
    rl h
    ld de, MonsterPedigreeTableA
    add hl, de
    ld de, vTiles2 + $300
    call ScriptCommandF6_Run_Case10_Case06_Sub01
    pop hl
    sla l
    rl h
    ld de, MonsterPedigreeTableB
    add hl, de
    ld de, vTiles2 + $390
    call ScriptCommandF6_Run_Case10_Case06_Sub01
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 7 of the `rst $00` table in ScriptCommandF6_Run_Case10
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wStringCategory, wStringIndex, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScreenStep
ScriptCommandF6_Run_Case10_Case07::
Jump_00C_4B5C:: ; address name
    call DrawThreeMetaSpritePartsFor5050
    call GridCellAddressFromGridCursorXAndGrid2CursorX
    ld a, $10
    add_a_to_hl
    ld a, h
    ld [wStringCategory], a
    ld a, l
    ld [wStringIndex], a
    ld hl, vTiles1 + $220
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    farcall ShowString_Bank0B
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 8 of the `rst $00` table in ScriptCommandF6_Run_Case10
; no direct call (reached through a table, a jump or a vector)
; reads: wGridCursorY, wGridCursorX, wJoypadPressedRepeat, wJoypadPressed, wScreenStep, wGrid2CursorX, wGrid2CursorY
; writes: wScreenStep, wGrid2CursorY, wGrid2CursorX, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScreenSubStep
; points at: wScreenCountPlusOne
ScriptCommandF6_Run_Case10_Case08::
Jump_00C_4B95:: ; address name
    call DrawThreeMetaSpritePartsFor5050
    ld a, [wGridCursorY]
    add a, a
    ld b, a
    add a, a
    add a, b
    ld b, a
    ld a, [wGridCursorX]
    add a, b
    ld hl, wScreenCountPlusOne
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
    ld a, [wGrid2CursorX]
    cp a, $05
    jr c, Jump_00C_4BF8
    xor a, a
    ld [wGrid2CursorX], a
    call GridIndexFromGridCursorXGridCursorY
    ld de, Data_00C_5944
    add a, e
    ld e, a
    jr nc, Jump_00C_4BE1
    inc d

Jump_00C_4BE1::
    ld a, [de]
    ld b, a
    ld a, [wGrid2CursorY]
    cp a, b
    jr c, Jump_00C_4BF2

Jump_00C_4BE9::
    xor a, a
    ld [wGrid2CursorX], a
    ld [wGrid2CursorY], a
    jr Jump_00C_4BFC

Jump_00C_4BF2::
    inc a
    ld [wGrid2CursorY], a
    jr Jump_00C_4BFC

Jump_00C_4BF8::
    inc a
    ld [wGrid2CursorX], a

Jump_00C_4BFC::
    call GridCellAddressFromGridCursorXAndGrid2CursorX
    push hl
    call GridIndexFromGridCursorXGridCursorY
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
    call GridCellAddressFromGridCursorXAndGrid2CursorX
    call ScriptCommandF6_Run_Shared08
    and a, a
    jr z, Jump_00C_4BCB
    ld a, $69
    call QueueSoundEffect
    call ScriptCommandF6_Run_Shared07
    ld hl, vTiles1 + $220
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld a, $01
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ret

Jump_00C_4C4F::
    ld a, [wGrid2CursorX]
    and a, a
    jr nz, Jump_00C_4C7E
    ld a, [wGrid2CursorY]
    and a, a
    jr nz, Jump_00C_4C72

Jump_00C_4C5B::
    call GridIndexFromGridCursorXGridCursorY
    ld de, Data_00C_5944
    add a, e
    ld e, a
    jr nc, Jump_00C_4C66
    inc d

Jump_00C_4C66::
    ld a, [de]
    ld [wGrid2CursorY], a
    call ReadGridCellByteForGridCursorXGridCursorY
    ld [wGrid2CursorX], a
    jr Jump_00C_4C82

Jump_00C_4C72::
    dec a
    ld [wGrid2CursorY], a
    call ReadGridCellByteForGridCursorXGridCursorY
    ld [wGrid2CursorX], a
    jr Jump_00C_4C82

Jump_00C_4C7E::
    dec a
    ld [wGrid2CursorX], a

Jump_00C_4C82::
    call GridCellAddressFromGridCursorXAndGrid2CursorX
    push hl
    call GridIndexFromGridCursorXGridCursorY
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
    call GridCellAddressFromGridCursorXAndGrid2CursorX
    call ScriptCommandF6_Run_Shared08
    and a, a
    jr z, Jump_00C_4C4F
    ld a, $69
    call QueueSoundEffect
    call ScriptCommandF6_Run_Shared07
    ld hl, vTiles1 + $220
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld a, $01
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ret

Jump_00C_4CD5::
    ld a, $69
    call QueueSoundEffect

Jump_00C_4CDA::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 9 of the `rst $00` table in ScriptCommandF6_Run_Case10
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
ScriptCommandF6_Run_Case10_Case09::
Jump_00C_4CE2:: ; address name
    call ScriptCommandF6_Run_Shared06
    ld b, $46
    ld de, Data_046_4001
    ld hl, vTiles1
    call DecompressToVRAM
    call ScriptCommandF6_Run_Shared05
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 10 of the `rst $00` table in ScriptCommandF6_Run_Case10
; no direct call (reached through a table, a jump or a vector)
; reads: wGridCursorY, wGridCursorX, wGrid2CursorX, wScreenStep
; writes: wWindowTileBuffer, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wBGPaletteUploadRequest, wScreenStep
ScriptCommandF6_Run_Case10_Case0A::
Jump_00C_4CFB:: ; address name
    ld de, TileRect_0C_56D9
    ld hl, wWindowTileBuffer + $64
    ld bc, $090D
    call CopyRectTo20ByteRows_Bank0C
    ld a, [wGridCursorY]
    and a, a
    jr z, Jump_00C_4D12
    ld a, $C3
    ld [wWindowTileBuffer + $145], a

Jump_00C_4D12::
    ld a, [wGridCursorX]
    ld hl, Data_00C_58FE
    ld b, $BC
    call StoreBAtWordTableEntry_Bank0C
    ld a, [wGridCursorY]
    add a, $E1
    ld [wWindowTileBuffer + $156], a
    ld de, TileRect_0C_574E
    ld hl, wWindowTileBuffer + $6C
    ld bc, $0C0D
    call CopyRectTo20ByteRows_Bank0C
    ld a, [wGrid2CursorX]
    ld b, $BC
    ld hl, Data_00C_590A
    call StoreBAtWordTableEntry_Bank0C
    call ClearStringWindowAt2020
    call ClearStringWindowAt2200
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld a, $7F
    ld [wBGPaletteUploadRequest], a
    call UploadBGPalettes
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 11 of the `rst $00` table in ScriptCommandF6_Run_Case10
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
ScriptCommandF6_Run_Case10_Case0B::
Jump_00C_4D6B:: ; address name
    call WriteBGPalette0From555C
    call ScriptCommandF6_Run_Shared02
    call ScriptCommandF6_Run_Shared01
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 12 of the `rst $00` table in ScriptCommandF6_Run_Case10
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg1, wScreenStep, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScriptCommandType, wScriptStartRequest
; points at: wWindowTileBuffer
ScriptCommandF6_Run_Case10_Case0C::
Jump_00C_4D7C:: ; address name
    ld a, $01
    ld [wArg1], a
    call ScriptCommandF6_Run_Shared04
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    ld de, TileRect_0C_589A
    ld hl, wWindowTileBuffer
    ld bc, $1405
    call CopyRectTo20ByteRows_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call DrawScreenBufferRect_Bank0C
    call ScriptCommandF6_Run_Shared03
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 13 of the `rst $00` table in ScriptCommandF6_Run_Case10
; no direct call (reached through a table, a jump or a vector)
; reads: wGrid2CursorX
; writes: wScreenStep, wScreenState, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScriptCommandType, wScriptStartRequest
ScriptCommandF6_Run_Case10_Case0D::
Jump_00C_4DD6:: ; address name
    ld a, [wGrid2CursorX]
    ld b, $C3
    ld hl, Data_00C_590A
    call StoreBAtWordTableEntry_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140C
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    xor a, a
    ld [wScreenStep], a
    ld a, $0C
    ld [wScreenState], a
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; only called from ScriptCommandF6_Run_Case10_Case06 (E-0047)
; 2 call sites from 1 routine (e.g. ScriptCommandF6_Run_Case10_Case06)
; writes: wStringIndex, wStringCategory, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
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
    ld [wTextWindowTileLo], a
    ld a, d
    ld [wTextWindowTileHi], a
    ld hl, $0901
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
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
    ld [wTextWindowTileLo], a
    ld a, d
    ld [wTextWindowTileHi], a
    ld hl, $0901
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    farcall ShowString_Bank0B
    ret

; only called from ScriptCommandF6_Run_Case10_Case06 (E-0047)
; 2 call sites from 1 routine (e.g. ScriptCommandF6_Run_Case10_Case06)
; reads: wArg5
; writes: wArg6, wArg7, wWorkBuf
ScriptCommandF6_Run_Case10_Case06_Sub02::
Func_00C_4E75:: ; address name
    push af
    inc hl
    ld a, [hl-]
    cp a, $FE
    jr z, Jump_00C_4E8F
    ld a, [hl+]
    ld [wArg6], a
    ld a, [hl]
    ld [wArg7], a
    farcall FamilyForSpeciesIdArg6
    ld a, [wArg5]
    jr Jump_00C_4E94

Jump_00C_4E8F::
    ld a, [hl]
    cp a, $FE
    jr z, Jump_00C_4EA4

Jump_00C_4E94::
    and a, $0F
    ld [wWorkBuf], a
    pop af
    ld [wWorkBuf + $1], a
    farcall LoadFamilyIconTileForWorkBuf
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
; reads: wGrid2CursorY
; writes: wStringCategory, wStringIndex, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
ScriptCommandF6_Run_Shared01::
Func_00C_4EC7:: ; address name
    call GridIndexFromGridCursorXGridCursorY
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
    ld a, [wGrid2CursorY]
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
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0901
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
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
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0901
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    farcall ShowString_Bank0B

Jump_00C_4F57::
    pop bc
    pop hl
    inc hl
    push hl
    inc c
    call ReadGridCellByteForGridCursorXGridCursorY
    inc a
    ld b, a
    pop hl
    ld a, c
    cp a, b
    jp c, Jump_00C_4EE6
    ret

; address loaded by ScriptCommandF6_Run_Shared01
Data_00C_4F68:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $92, $90, $92, $20, $93, $B0, $93, $40, $94, $D0, $94

; only called from routines of ScriptCommandF6_Run (E-0098)
; 2 call sites from 2 routines (e.g. ScriptCommandF6_Run_Case03, ScriptCommandF6_Run_Case10_Case0B)
; reads: wGridCursorY
; writes: wWorkBuf
ScriptCommandF6_Run_Shared02::
Func_00C_4F74:: ; address name
    ld a, [wGridCursorY]
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
    ld [wWorkBuf], a
    cp a, $06
    jr c, Jump_00C_4F95
    sub a, $06

Jump_00C_4F95::
    inc a
    inc a
    ld [wWorkBuf + $1], a
    farcall LoadFamilyIconTileForWorkBuf
    pop bc
    pop de

Jump_00C_4FA2::
    inc de
    inc c
    ld a, c
    cp a, $06
    jr c, Jump_00C_4F85
    ret

; address loaded by ScriptCommandF6_Run_Shared02
Data_00C_4FAA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $FF, $20, $90, $70, $90
    db $C0, $90, $10, $91, $60, $91, $B0, $91

; with the pointer from Func_00C_5050 draws sub-indices 0, 4 and 2 (Func_01D_6A36) at Y = $10, $24 and $38, X = $6C (E-0121)
; 5 call sites from 5 routines (e.g. ScriptCommandF6_Run_Case10_Case08, ScriptCommandF6_Run_Case10_Case07, ScriptCommandF6_Run_Case10_Case06, ScriptCommandF6_Run_Case10_Case05, ...)
; writes: wArg1, wArg2, wArg3, wArg4, wArg5, wArg6, hSpriteSubIndex
DrawThreeMetaSpritePartsFor5050::
Func_00C_4FC2:: ; address name
    call GridCellAddressFromGridCursorXAndGrid2CursorX
    ld a, l
    ld [wArg1], a
    ld a, h
    ld [wArg2], a
    xor a, a
    ld [wArg3], a
    ld a, $10
    ld [wArg4], a
    ld a, $6C
    ld [wArg5], a
    xor a, a
    ld [wArg6], a
    ld c, $01
    xor a, a
    ldh [hSpriteSubIndex], a
    farcall DrawThreeMetaSpritePartsFor5050_Sub01
    ld a, $24
    ld [wArg4], a
    ld a, $6C
    ld [wArg5], a
    xor a, a
    ld [wArg6], a
    ld c, $01
    ld a, $04
    ldh [hSpriteSubIndex], a
    farcall DrawThreeMetaSpritePartsFor5050_Sub01
    ld a, $38
    ld [wArg4], a
    ld a, $6C
    ld [wArg5], a
    xor a, a
    ld [wArg6], a
    ld c, $01
    ld a, $02
    ldh [hSpriteSubIndex], a
    farcall DrawThreeMetaSpritePartsFor5050_Sub01
    ret

; only called from routines of ScriptCommandF6_Run (E-0098)
; 2 call sites from 2 routines (e.g. ScriptCommandF6_Run_Case0B, ScriptCommandF6_Run_Case10_Case0C)
; reads: wGrid2CursorY
ScriptCommandF6_Run_Shared03::
Func_00C_501F:: ; address name
    call BGMapAddressAtScroll_Bank0C
    ld de, $018F
    add hl, de
    push hl
    ld a, [wGrid2CursorY]
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
    call GridIndexFromGridCursorXGridCursorY
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

; HL = the word Data_00C_5916[GridIndexFromGridCursorXGridCursorY] + GridIndexFromGrid2CursorXGrid2CursorY (E-0124)
; 15 call sites from 10 routines (e.g. ScriptCommandF6_Run_Case10_Case08, DrawThreeMetaSpritePartsFor5050, ScriptCommandF6_Run_Case10_Case07, ScriptCommandF6_Run_Case10_Case06, ...)
GridCellAddressFromGridCursorXAndGrid2CursorX::
Func_00C_5050:: ; address name
    call GridIndexFromGridCursorXGridCursorY
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
    call GridIndexFromGrid2CursorXGrid2CursorY
    pop hl
    add_a_to_hl
    ret

; A = the byte at Data_00C_594F[GridIndexFromGridCursorXGridCursorY] + wD78B (E-0122)
; 6 call sites from 3 routines (e.g. ScriptCommandF6_Run_Case0C, ScriptCommandF6_Run_Shared01, ScriptCommandF6_Run_Case10_Case08)
; reads: wGrid2CursorY
ReadGridCellByteForGridCursorXGridCursorY::
Func_00C_506C:: ; address name
    call GridIndexFromGridCursorXGridCursorY
    add a, a
    ld hl, Data_00C_594F
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, [wGrid2CursorY]
    add a, e
    ld e, a
    jr nc, Jump_00C_5083
    inc d

Jump_00C_5083::
    ld a, [de]
    ret

; only called from routines of ScriptCommandF6_Run (E-0098)
; 4 call sites from 3 routines (e.g. ScriptCommandF6_Run_Case0D, ScriptCommandF6_Run_Case04, ScriptCommandF6_Run_Case10_Case0C)
; reads: wGridCursorY, wDigits, wArg1
; writes: wDigits
; points at: wScreenCountPlusOne
ScriptCommandF6_Run_Shared04::
Func_00C_5085:: ; address name
    ld a, [wGridCursorY]
    add a, a
    ld b, a
    add a, a
    add a, b
    ld hl, wScreenCountPlusOne
    add_a_to_hl
    ld a, [wGridCursorY]
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
    ld a, [wDigits + $1]
    and a, a
    jr nz, Jump_00C_50B6
    add a, $E3
    ld [wDigits + $1], a

Jump_00C_50B6::
    call BGMapAddressAtScroll_Bank0C
    pop bc
    push bc
    ld a, c
    add a, a
    push hl
    push af
    ld a, [wArg1]
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
    ld a, [wDigits + $1]
    add a, $E0
    ld [hl+], a
    ei
    di
    call WaitForVRAMAccess
    ld a, [wDigits + $2]
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

; address loaded by ScriptCommandF6_Run_Shared04
Data_00C_5103:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $26, $00, $66, $00, $A6, $00, $E6, $00, $26, $01, $66, $01

; address loaded by ScriptCommandF6_Run_Shared04
Data_00C_510F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $7E, $C3, $A6, $C3, $CE, $C3, $F6, $C3, $1E, $C4, $46, $C4

; only called from routines of ScriptCommandF6_Run (E-0098)
; 3 call sites from 3 routines (e.g. ScriptCommandF6_Run_Case0F, ScriptCommandF6_Run_Case01, ScriptCommandF6_Run_Case10_Case09)
; reads: wIsCGB
; writes: rSVBK
ScriptCommandF6_Run_Shared05::
Func_00C_511B:: ; address name
    ld hl, wWindowTileBuffer + $64
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
    ld hl, wWindowAttrBuffer + $64
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
; 40 call sites from 31 routines (e.g. ScriptCommandF7_Run_Case26, RedrawFullScreenBoxes_0C, ScriptCommandF7_Run_Case19, ScriptCommandF7_Run_Case18, ...)
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
; writes: wArg5, wArg6, wArg1, wArg2, wArg3, wArg4, wArg7
ScriptCommandF6_Run_Shared06::
Func_00C_5177:: ; address name
    ld hl, Data_00C_51AB
    ld de, vTiles1 + $430
    call CopyTileBytesToVRAM_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, BGFillTile
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $20
    ld [wArg3], a
    ld a, $20
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    farcall FillTileRectWithArg1Tile
    ret

; address loaded by ScriptCommandF6_Run_Shared06
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
; 29 call sites from 22 routines (e.g. ScriptCommandF7_Run_Case26, RedrawFullScreenBoxes_0C, ScriptCommandF7_Run_Case19, ScriptCommandF7_Run_Case18, ...)
; reads: wStringIndex, wIsCGB
; writes: wTextCursorLo, wTextCursorHi, rVBK, rSVBK
; points at: wScreenTileBuffer, wScreenAttrBuffer
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
    ld [wTextCursorLo], a
    ld a, h
    adc a, $01
    ld [wTextCursorHi], a
    ld a, [wStringIndex]
    cp a, $18
    jr z, Jump_00C_5226
    cp a, $12
    jr z, Jump_00C_5226
    ld a, $C1
    ld [wTextCursorLo], a
    ld a, $99
    ld [wTextCursorHi], a

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
    ld hl, wScreenAttrBuffer
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
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
ClearStringWindowAt2020::
Func_00C_5269:: ; address name
    ld hl, vTiles2 + $20
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1702
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ret

; sets the string window to tile destination vTiles2 + $200 and size word $5301, then FillTilesFromRequest (clears it) (E-0117)
; 2 call sites from 2 routines (e.g. ScriptCommandF6_Run_Case09, ScriptCommandF6_Run_Case10_Case0A)
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
ClearStringWindowAt2200::
Func_00C_5283:: ; address name
    ld hl, vTiles2 + $200
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $5301
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ret

; only called from routines of ScriptCommandF6_Run (E-0098)
; 3 call sites from 2 routines (e.g. ScriptCommandF6_Run_Case10_Case08, ScriptCommandF6_Run_Case10_Case00)
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
ScriptCommandF6_Run_Shared07::
Func_00C_529D:: ; address name
    ld hl, vTiles2
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $6101
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld hl, vTiles2 + $670
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0701
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ret

; DE = source, HL = destination, BC = count: copies BC bytes (BC = 0 copies 65536); DE and HL end past the copy; clobbers A, BC = 0 (E-0064) (the same 9 bytes appear in 13 banks)
; 4 call sites from 4 routines (e.g. CopyScreenBufferRectWithAttrs_0C, RedrawFullScreenBoxes_0C, ScriptCommandF7_Run_Case00, ScriptCommandF6_Run_Case07)
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
; 4 call sites from 4 routines (e.g. CopyScreenBufferRectWithAttrs_0C, RedrawFullScreenBoxes_0C, ScriptCommandF7_Run_Case00, ScriptCommandF6_Run_Case07)
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
; 15 call sites from 8 routines (e.g. ScriptCommandF6_Run_Case0C, ReadGridCellByteForGridCursorXGridCursorY, ScriptCommandF6_Run_Shared03, ScriptCommandF6_Run_Case0A, ...)
; reads: wGridCursorY, wGridCursorX
GridIndexFromGridCursorXGridCursorY::
Func_00C_52EC:: ; address name
    push bc
    ld a, [wGridCursorY]
    add a, a
    ld b, a
    add a, a
    add a, b
    ld b, a
    ld a, [wGridCursorX]
    add a, b
    pop bc
    ret

; A = 6 * wD78B + wD78A (row-major index in a 6-column grid); BC kept (E-0117)
; 2 call sites from 2 routines (e.g. ScriptCommandF6_Run_Case0C, GridCellAddressFromGridCursorXAndGrid2CursorX)
; reads: wGrid2CursorY, wGrid2CursorX
GridIndexFromGrid2CursorXGrid2CursorY::
Func_00C_52FB:: ; address name
    push bc
    ld a, [wGrid2CursorY]
    add a, a
    ld b, a
    add a, a
    add a, b
    ld b, a
    ld a, [wGrid2CursorX]
    add a, b
    pop bc
    ret

; only called from routines of ScriptCommandF6_Run (E-0098)
; 5 call sites from 4 routines (e.g. ScriptCommandF6_Run_Case0C, ScriptCommandF6_Run_Shared01, ScriptCommandF6_Run_Case10_Case08, ScriptCommandF6_Run_Case10_Case05)
; reads: wArg5
; writes: wArg1, wArg2, wArg3, wArg4, wSpeciesIdLo, wSpeciesIdHi
; points at: wMonsterLibraryBuf
ScriptCommandF6_Run_Shared08::
Func_00C_530A:: ; address name
    push hl
    ld a, l
    ld [wArg1], a
    ld a, h
    ld [wArg2], a
    ld de, wMonsterLibraryBuf
    ld a, e
    ld [wArg3], a
    ld a, d
    ld [wArg4], a
    farcall TestBitInFieldAtArg3
    ld a, [wArg5]
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
; points at: wScreenBlock9C
ScriptCommandF6_Run_Case10_Case01_Sub01::
Func_00C_534A:: ; address name
    call GridCellAddressFromGridCursorXAndGrid2CursorX
    ld de, MonsterIconKindTable_536A
    add hl, de
    ld a, [hl]
    ld hl, Data_00C_54DF
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld b, $02
    ld hl, wScreenBlock9C

Jump_00C_5363::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_00C_5363
    ret

; E-0206 (C1: ScriptCommandF6_Run_Case10_Case01_Sub01 reads the byte at $536A + the monster number from GridCellAddressFromGridCursorXAndGrid2CursorX and copies the two tile bytes that Data_00C_54DF[value] points to into wScreenBlock9C; 373 bytes, one per monster id up to $174).
; record: index into Data_00C_54DF
MonsterIconKindTable_536A::
Data_00C_536A:: ; address name
    db $00 ; id 0
    db $00 ; id 1 DrakSlime
    db $00 ; id 2 SpotSlime
    db $01 ; id 3 WingSlime
    db $00 ; id 4 TreeSlime
    db $00 ; id 5 Snaily
    db $01 ; id 6 SlimeNite
    db $00 ; id 7 Babble
    db $00 ; id 8 BoxSlime
    db $00 ; id 9 PearlGel
    db $00 ; id 10 Slime
    db $00 ; id 11 Healer
    db $01 ; id 12 FangSlime
    db $00 ; id 13 RockSlime
    db $01 ; id 14 SlimeBorg
    db $00 ; id 15 Slabbit
    db $01 ; id 16 KingSlime
    db $00 ; id 17 Metaly
    db $00 ; id 18 Metabble
    db $01 ; id 19 SpotKing
    db $01 ; id 20 TropicGel
    db $01 ; id 21 MimeSlime
    db $00 ; id 22 HaloSlime
    db $01 ; id 23 MetalKing
    db $01 ; id 24 GoldSlime
    db $02 ; id 25 GranSlime
    db $00 ; id 26 WonderEgg
    db $00 ; id 27 Butch
    db $00 ; id 28 ?
    db $00 ; id 29 ?
    db $00 ; id 30 ?
    db $00 ; id 31 ?
    db $00 ; id 32 ?
    db $00 ; id 33 ?
    db $00 ; id 34 ?
    db $00 ; id 35 ?
    db $00 ; id 36 DragonKid
    db $01 ; id 37 Tortragon
    db $01 ; id 38 Pteranod
    db $01 ; id 39 Gasgon
    db $00 ; id 40 FairyDrak
    db $02 ; id 41 LizardMan
    db $02 ; id 42 Poisongon
    db $02 ; id 43 Swordgon
    db $02 ; id 44 Drygon
    db $02 ; id 45 Dragon
    db $00 ; id 46 MiniDrak
    db $02 ; id 47 MadDragon
    db $02 ; id 48 Rayburn
    db $00 ; id 49 Chamelgon
    db $00 ; id 50 LizardFly
    db $02 ; id 51 Andreal
    db $00 ; id 52 KingCobra
    db $02 ; id 53 Vampirus
    db $00 ; id 54 SnakeBat
    db $02 ; id 55 Spikerous
    db $03 ; id 56 GreatDrak
    db $00 ; id 57 Crestpent
    db $00 ; id 58 WingSnake
    db $02 ; id 59 Coatol
    db $03 ; id 60 Orochi
    db $02 ; id 61 BattleRex
    db $02 ; id 62 SkyDragon
    db $02 ; id 63 Serpentia
    db $03 ; id 64 Divinegon
    db $03 ; id 65 Orligon
    db $04 ; id 66 GigaDraco
    db $00 ; id 67 ?
    db $00 ; id 68 ?
    db $00 ; id 69 ?
    db $00 ; id 70 ?
    db $01 ; id 71 Tonguella
    db $00 ; id 72 Almiraj
    db $00 ; id 73 CatFly
    db $00 ; id 74 PillowRat
    db $00 ; id 75 Saccer
    db $02 ; id 76 GulpBeast
    db $00 ; id 77 Skullroo
    db $01 ; id 78 WindBeast
    db $00 ; id 79 Beavern
    db $00 ; id 80 Antbear
    db $01 ; id 81 SuperTen
    db $01 ; id 82 IronTurt
    db $00 ; id 83 Mommonja
    db $00 ; id 84 HammerMan
    db $02 ; id 85 Grizzly
    db $02 ; id 86 Yeti
    db $00 ; id 87 ArrowDog
    db $02 ; id 88 NoctoKing
    db $01 ; id 89 BeastNite
    db $00 ; id 90 MadGopher
    db $00 ; id 91 FairyRat
    db $01 ; id 92 Unicorn
    db $01 ; id 93 Goategon
    db $01 ; id 94 WildApe
    db $03 ; id 95 Trumpeter
    db $02 ; id 96 KingLeo
    db $02 ; id 97 DarkHorn
    db $02 ; id 98 MadCat
    db $01 ; id 99 BigEye
    db $02 ; id 100 Gorago
    db $00 ; id 101 CatMage
    db $02 ; id 102 Dumbira
    db $00 ; id 103 ?
    db $00 ; id 104 ?
    db $00 ; id 105 ?
    db $00 ; id 106 Picky
    db $01 ; id 107 Wyvern
    db $01 ; id 108 BullBird
    db $00 ; id 109 Florajay
    db $01 ; id 110 DuckKite
    db $00 ; id 111 MadPecker
    db $00 ; id 112 MadRaven
    db $00 ; id 113 MistyWing
    db $02 ; id 114 AquaHawk
    db $00 ; id 115 Dracky
    db $00 ; id 116 KiteHawk
    db $01 ; id 117 BigRoost
    db $00 ; id 118 StubBird
    db $01 ; id 119 LandOwl
    db $01 ; id 120 MadGoose
    db $01 ; id 121 MadCondor
    db $01 ; id 122 Emyu
    db $01 ; id 123 Blizzardy
    db $01 ; id 124 Phoenix
    db $01 ; id 125 ZapBird
    db $01 ; id 126 Garudian
    db $03 ; id 127 WhipBird
    db $01 ; id 128 FunkyBird
    db $02 ; id 129 RainHawk
    db $02 ; id 130 Azurile
    db $03 ; id 131 Shantak
    db $00 ; id 132 CragDevil
    db $00 ; id 133 ?
    db $00 ; id 134 ?
    db $00 ; id 135 ?
    db $00 ; id 136 ?
    db $00 ; id 137 ?
    db $00 ; id 138 ?
    db $00 ; id 139 ?
    db $00 ; id 140 ?
    db $00 ; id 141 MadPlant
    db $00 ; id 142 FireWeed
    db $02 ; id 143 FloraMan
    db $02 ; id 144 WingTree
    db $00 ; id 145 CactiBall
    db $00 ; id 146 Gulpple
    db $00 ; id 147 Toadstool
    db $00 ; id 148 AmberWeed
    db $00 ; id 149 Slurperon
    db $00 ; id 150 Stubsuck
    db $00 ; id 151 Oniono
    db $01 ; id 152 DanceVegi
    db $00 ; id 153 TreeBoy
    db $00 ; id 154 Devipine
    db $03 ; id 155 FaceTree
    db $01 ; id 156 HerbMan
    db $01 ; id 157 BeanMan
    db $00 ; id 158 EvilSeed
    db $02 ; id 159 ManEater
    db $03 ; id 160 Snapper
    db $02 ; id 161 GhosTree
    db $03 ; id 162 Rosevine
    db $04 ; id 163 Egdracil
    db $00 ; id 164 Warubou
    db $00 ; id 165 Watabou
    db $00 ; id 166 Eggplaton
    db $00 ; id 167 FooHero
    db $00 ; id 168 ?
    db $00 ; id 169 ?
    db $00 ; id 170 ?
    db $00 ; id 171 ?
    db $00 ; id 172 ?
    db $00 ; id 173 ?
    db $00 ; id 174 ?
    db $00 ; id 175 ?
    db $00 ; id 176 GiantSlug
    db $00 ; id 177 Catapila
    db $00 ; id 178 Gophecada
    db $00 ; id 179 Butterfly
    db $00 ; id 180 WeedBug
    db $00 ; id 181 GiantWorm
    db $00 ; id 182 Lipsy
    db $00 ; id 183 StagBug
    db $01 ; id 184 Pyuro
    db $00 ; id 185 ArmyAnt
    db $00 ; id 186 GoHopper
    db $00 ; id 187 TailEater
    db $01 ; id 188 ArmorPede
    db $00 ; id 189 Eyeder
    db $01 ; id 190 GiantMoth
    db $00 ; id 191 Droll
    db $01 ; id 192 ArmyCrab
    db $01 ; id 193 MadHornet
    db $01 ; id 194 Belzebub
    db $02 ; id 195 WarMantis
    db $02 ; id 196 HornBeet
    db $00 ; id 197 Sickler
    db $02 ; id 198 Armorpion
    db $03 ; id 199 Digster
    db $03 ; id 200 Skularach
    db $02 ; id 201 MultiEyes
    db $00 ; id 202 ?
    db $00 ; id 203 ?
    db $00 ; id 204 ?
    db $00 ; id 205 ?
    db $00 ; id 206 ?
    db $00 ; id 207 ?
    db $00 ; id 208 ?
    db $00 ; id 209 ?
    db $00 ; id 210 ?
    db $00 ; id 211 Pixy
    db $00 ; id 212 MedusaEye
    db $01 ; id 213 AgDevil
    db $00 ; id 214 Demonite
    db $00 ; id 215 DarkEye
    db $00 ; id 216 EyeBall
    db $01 ; id 217 SkulRider
    db $02 ; id 218 EvilBeast
    db $02 ; id 219 Bubblemon
    db $00 ; id 220 1EyeClown
    db $00 ; id 221 Gremlin
    db $02 ; id 222 ArcDemon
    db $02 ; id 223 Lionex
    db $02 ; id 224 GoatHorn
    db $01 ; id 225 Orc
    db $02 ; id 226 Ogre
    db $01 ; id 227 GateGuard
    db $01 ; id 228 ChopClown
    db $03 ; id 229 BossTroll
    db $02 ; id 230 Grendal
    db $02 ; id 231 Akubar
    db $02 ; id 232 MadKnight
    db $01 ; id 233 EvilWell
    db $04 ; id 234 Gigantes
    db $02 ; id 235 Centasaur
    db $02 ; id 236 EvilArmor
    db $02 ; id 237 Jamirus
    db $02 ; id 238 Durran
    db $04 ; id 239 Titanis
    db $02 ; id 240 LampGenie
    db $00 ; id 241 ?
    db $00 ; id 242 ?
    db $00 ; id 243 ?
    db $00 ; id 244 ?
    db $00 ; id 245 ?
    db $00 ; id 246 Spooky
    db $03 ; id 247 Skullgon
    db $00 ; id 248 PutrePup
    db $00 ; id 249 RotRaven
    db $01 ; id 250 Mummy
    db $01 ; id 251 DarkCrab
    db $01 ; id 252 DeadNite
    db $00 ; id 253 Shadow
    db $01 ; id 254 Skulpent
    db $01 ; id 255 Hork
    db $00 ; id 256 Mudron
    db $00 ; id 257 NiteWhip
    db $01 ; id 258 WindMerge
    db $00 ; id 259 Reaper
    db $01 ; id 260 Inverzon
    db $00 ; id 261 FoxFire
    db $02 ; id 262 CaptDead
    db $02 ; id 263 DeadNoble
    db $01 ; id 264 WhiteKing
    db $01 ; id 265 BoneSlave
    db $01 ; id 266 Skeletor
    db $02 ; id 267 Servant
    db $01 ; id 268 Lazamanus
    db $00 ; id 269 Copycat
    db $00 ; id 270 MadSpirit
    db $01 ; id 271 PomPomBom
    db $02 ; id 272 Niterich
    db $00 ; id 273 ?
    db $00 ; id 274 ?
    db $00 ; id 275 ?
    db $00 ; id 276 ?
    db $00 ; id 277 ?
    db $00 ; id 278 ?
    db $00 ; id 279 ?
    db $00 ; id 280 ?
    db $00 ; id 281 JewelBag
    db $01 ; id 282 EvilWand
    db $00 ; id 283 MadCandle
    db $00 ; id 284 CoilBird
    db $02 ; id 285 Facer
    db $00 ; id 286 SpikyBoy
    db $01 ; id 287 MadMirror
    db $02 ; id 288 RogueNite
    db $00 ; id 289 Puppetor
    db $00 ; id 290 Goopi
    db $01 ; id 291 Voodoll
    db $03 ; id 292 MetalDrak
    db $02 ; id 293 Balzak
    db $00 ; id 294 SabreMan
    db $00 ; id 295 CurseLamp
    db $01 ; id 296 Brushead
    db $01 ; id 297 Roboster
    db $01 ; id 298 Roboster2
    db $00 ; id 299 EvilPot
    db $00 ; id 300 Gismo
    db $01 ; id 301 LavaMan
    db $01 ; id 302 IceMan
    db $01 ; id 303 Mimic
    db $01 ; id 304 Exaucers
    db $01 ; id 305 MudDoll
    db $02 ; id 306 Golem
    db $03 ; id 307 StoneMan
    db $01 ; id 308 BombCrag
    db $02 ; id 309 GoldGolem
    db $02 ; id 310 DarkMate
    db $01 ; id 311 ProtoMech
    db $04 ; id 312 CloudKing
    db $00 ; id 313 ?
    db $00 ; id 314 ?
    db $00 ; id 315 ?
    db $00 ; id 316 Petiteel
    db $00 ; id 317 Moray
    db $01 ; id 318 WalrusMan
    db $01 ; id 319 RayGigas
    db $00 ; id 320 Anemon
    db $01 ; id 321 Aquarella
    db $01 ; id 322 Merman
    db $01 ; id 323 Octokid
    db $00 ; id 324 PutreFish
    db $01 ; id 325 Octoreach
    db $01 ; id 326 Angleron
    db $01 ; id 327 FishRider
    db $01 ; id 328 RushFish
    db $00 ; id 329 Gamanian
    db $01 ; id 330 Clawster
    db $01 ; id 331 CancerMan
    db $02 ; id 332 RogueWave
    db $00 ; id 333 Scallopa
    db $00 ; id 334 SeaHorse
    db $02 ; id 335 HoodSquid
    db $02 ; id 336 MerTiger
    db $02 ; id 337 AxeShark
    db $03 ; id 338 Octogon
    db $03 ; id 339 KingSquid
    db $02 ; id 340 Digong
    db $01 ; id 341 WhaleMage
    db $04 ; id 342 Aquadon
    db $02 ; id 343 Octoraid
    db $02 ; id 344 Grakos
    db $03 ; id 345 Poseidon
    db $00 ; id 346 Pumpoise
    db $00 ; id 347 Starfish
    db $00 ; id 348 ?
    db $00 ; id 349 ?
    db $00 ; id 350 ?
    db $01 ; id 351 DracoLord
    db $03 ; id 352 DracoLord
    db $03 ; id 353 LordDraco
    db $02 ; id 354 Hargon
    db $02 ; id 355 Sidoh
    db $03 ; id 356 Genosidoh
    db $02 ; id 357 Baramos
    db $02 ; id 358 Zoma
    db $02 ; id 359 AsuraZoma
    db $03 ; id 360 Pizzaro
    db $02 ; id 361 PsychoPiz
    db $02 ; id 362 Esterk
    db $01 ; id 363 Mirudraas
    db $03 ; id 364 Mirudraas
    db $02 ; id 365 Mudou
    db $01 ; id 366 DeathMore
    db $03 ; id 367 DeathMore
    db $04 ; id 368 DeathMore
    db $02 ; id 369 Darkdrium
    db $01 ; id 370 Orgodemir
    db $03 ; id 371 Orgodemir
    db $02 ; id 372 Darck

; address loaded by ScriptCommandF6_Run_Case10_Case01_Sub01
Data_00C_54DF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $E9, $54, $EB, $54, $ED, $54, $EF, $54, $F1, $54, $7C, $80, $7D, $80, $7E, $80
    db $7E, $7E, $7F, $80

; only called from ScriptCommandF6_Run_Case10_Case01 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandF6_Run_Case10_Case01)
; points at: wScreenBlock9C
ScriptCommandF6_Run_Case10_Case01_Sub02::
Func_00C_54F3:: ; address name
    call GridCellAddressFromGridCursorXAndGrid2CursorX
    ld de, MonsterClassByteTable_5562
    add hl, de
    ld a, [hl]
    add a, a
    ld hl, Data_00C_5513
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld b, $04
    ld hl, wScreenBlock9C

Jump_00C_550C::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_00C_550C
    ret

; address loaded by ScriptCommandF6_Run_Case10_Case01_Sub02
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

; address loaded by WriteBGPalette0From555C
Data_00C_555C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $86, $7D, $FF, $7F, $E1, $7F

; E-0206 (C1: ScriptCommandF6_Run_Case10_Case01_Sub02 reads the byte at $5562 + the monster number from GridCellAddressFromGridCursorXAndGrid2CursorX and copies the 4-byte tile block that Data_00C_5513[class] points to into wScreenBlock9C; the same 373 values as MonsterClassByteTable_71AC in bank $16 except at ids 26, 352, 355, 358, 360, 364, 366, 367, 372).
; record: class 0-7
MonsterClassByteTable_5562::
Data_00C_5562:: ; address name
    db $00 ; id 0
    db $03 ; id 1 DrakSlime
    db $00 ; id 2 SpotSlime
    db $02 ; id 3 WingSlime
    db $01 ; id 4 TreeSlime
    db $00 ; id 5 Snaily
    db $03 ; id 6 SlimeNite
    db $01 ; id 7 Babble
    db $02 ; id 8 BoxSlime
    db $02 ; id 9 PearlGel
    db $01 ; id 10 Slime
    db $02 ; id 11 Healer
    db $03 ; id 12 FangSlime
    db $03 ; id 13 RockSlime
    db $03 ; id 14 SlimeBorg
    db $00 ; id 15 Slabbit
    db $05 ; id 16 KingSlime
    db $04 ; id 17 Metaly
    db $05 ; id 18 Metabble
    db $04 ; id 19 SpotKing
    db $01 ; id 20 TropicGel
    db $04 ; id 21 MimeSlime
    db $04 ; id 22 HaloSlime
    db $05 ; id 23 MetalKing
    db $06 ; id 24 GoldSlime
    db $07 ; id 25 GranSlime
    db $01 ; id 26 WonderEgg
    db $00 ; id 27 Butch
    db $00 ; id 28 ?
    db $00 ; id 29 ?
    db $00 ; id 30 ?
    db $00 ; id 31 ?
    db $00 ; id 32 ?
    db $00 ; id 33 ?
    db $00 ; id 34 ?
    db $00 ; id 35 ?
    db $02 ; id 36 DragonKid
    db $02 ; id 37 Tortragon
    db $02 ; id 38 Pteranod
    db $02 ; id 39 Gasgon
    db $00 ; id 40 FairyDrak
    db $04 ; id 41 LizardMan
    db $01 ; id 42 Poisongon
    db $03 ; id 43 Swordgon
    db $03 ; id 44 Drygon
    db $04 ; id 45 Dragon
    db $01 ; id 46 MiniDrak
    db $04 ; id 47 MadDragon
    db $03 ; id 48 Rayburn
    db $00 ; id 49 Chamelgon
    db $00 ; id 50 LizardFly
    db $04 ; id 51 Andreal
    db $01 ; id 52 KingCobra
    db $03 ; id 53 Vampirus
    db $01 ; id 54 SnakeBat
    db $04 ; id 55 Spikerous
    db $05 ; id 56 GreatDrak
    db $01 ; id 57 Crestpent
    db $02 ; id 58 WingSnake
    db $04 ; id 59 Coatol
    db $06 ; id 60 Orochi
    db $05 ; id 61 BattleRex
    db $05 ; id 62 SkyDragon
    db $05 ; id 63 Serpentia
    db $06 ; id 64 Divinegon
    db $07 ; id 65 Orligon
    db $06 ; id 66 GigaDraco
    db $00 ; id 67 ?
    db $00 ; id 68 ?
    db $00 ; id 69 ?
    db $00 ; id 70 ?
    db $02 ; id 71 Tonguella
    db $00 ; id 72 Almiraj
    db $00 ; id 73 CatFly
    db $00 ; id 74 PillowRat
    db $00 ; id 75 Saccer
    db $04 ; id 76 GulpBeast
    db $01 ; id 77 Skullroo
    db $01 ; id 78 WindBeast
    db $02 ; id 79 Beavern
    db $00 ; id 80 Antbear
    db $02 ; id 81 SuperTen
    db $02 ; id 82 IronTurt
    db $01 ; id 83 Mommonja
    db $01 ; id 84 HammerMan
    db $03 ; id 85 Grizzly
    db $03 ; id 86 Yeti
    db $01 ; id 87 ArrowDog
    db $02 ; id 88 NoctoKing
    db $02 ; id 89 BeastNite
    db $01 ; id 90 MadGopher
    db $00 ; id 91 FairyRat
    db $05 ; id 92 Unicorn
    db $03 ; id 93 Goategon
    db $03 ; id 94 WildApe
    db $04 ; id 95 Trumpeter
    db $06 ; id 96 KingLeo
    db $05 ; id 97 DarkHorn
    db $04 ; id 98 MadCat
    db $04 ; id 99 BigEye
    db $07 ; id 100 Gorago
    db $03 ; id 101 CatMage
    db $03 ; id 102 Dumbira
    db $00 ; id 103 ?
    db $00 ; id 104 ?
    db $00 ; id 105 ?
    db $00 ; id 106 Picky
    db $03 ; id 107 Wyvern
    db $02 ; id 108 BullBird
    db $01 ; id 109 Florajay
    db $03 ; id 110 DuckKite
    db $03 ; id 111 MadPecker
    db $01 ; id 112 MadRaven
    db $02 ; id 113 MistyWing
    db $02 ; id 114 AquaHawk
    db $00 ; id 115 Dracky
    db $01 ; id 116 KiteHawk
    db $01 ; id 117 BigRoost
    db $02 ; id 118 StubBird
    db $02 ; id 119 LandOwl
    db $03 ; id 120 MadGoose
    db $03 ; id 121 MadCondor
    db $03 ; id 122 Emyu
    db $04 ; id 123 Blizzardy
    db $04 ; id 124 Phoenix
    db $04 ; id 125 ZapBird
    db $05 ; id 126 Garudian
    db $05 ; id 127 WhipBird
    db $04 ; id 128 FunkyBird
    db $06 ; id 129 RainHawk
    db $07 ; id 130 Azurile
    db $06 ; id 131 Shantak
    db $02 ; id 132 CragDevil
    db $00 ; id 133 ?
    db $00 ; id 134 ?
    db $00 ; id 135 ?
    db $00 ; id 136 ?
    db $00 ; id 137 ?
    db $00 ; id 138 ?
    db $00 ; id 139 ?
    db $00 ; id 140 ?
    db $01 ; id 141 MadPlant
    db $02 ; id 142 FireWeed
    db $02 ; id 143 FloraMan
    db $01 ; id 144 WingTree
    db $00 ; id 145 CactiBall
    db $02 ; id 146 Gulpple
    db $00 ; id 147 Toadstool
    db $03 ; id 148 AmberWeed
    db $00 ; id 149 Slurperon
    db $02 ; id 150 Stubsuck
    db $01 ; id 151 Oniono
    db $02 ; id 152 DanceVegi
    db $03 ; id 153 TreeBoy
    db $03 ; id 154 Devipine
    db $05 ; id 155 FaceTree
    db $05 ; id 156 HerbMan
    db $03 ; id 157 BeanMan
    db $03 ; id 158 EvilSeed
    db $03 ; id 159 ManEater
    db $04 ; id 160 Snapper
    db $04 ; id 161 GhosTree
    db $06 ; id 162 Rosevine
    db $07 ; id 163 Egdracil
    db $07 ; id 164 Warubou
    db $07 ; id 165 Watabou
    db $00 ; id 166 Eggplaton
    db $03 ; id 167 FooHero
    db $00 ; id 168 ?
    db $00 ; id 169 ?
    db $00 ; id 170 ?
    db $00 ; id 171 ?
    db $00 ; id 172 ?
    db $00 ; id 173 ?
    db $00 ; id 174 ?
    db $00 ; id 175 ?
    db $00 ; id 176 GiantSlug
    db $03 ; id 177 Catapila
    db $01 ; id 178 Gophecada
    db $01 ; id 179 Butterfly
    db $03 ; id 180 WeedBug
    db $00 ; id 181 GiantWorm
    db $02 ; id 182 Lipsy
    db $02 ; id 183 StagBug
    db $02 ; id 184 Pyuro
    db $00 ; id 185 ArmyAnt
    db $01 ; id 186 GoHopper
    db $00 ; id 187 TailEater
    db $03 ; id 188 ArmorPede
    db $02 ; id 189 Eyeder
    db $03 ; id 190 GiantMoth
    db $03 ; id 191 Droll
    db $04 ; id 192 ArmyCrab
    db $03 ; id 193 MadHornet
    db $02 ; id 194 Belzebub
    db $05 ; id 195 WarMantis
    db $05 ; id 196 HornBeet
    db $04 ; id 197 Sickler
    db $06 ; id 198 Armorpion
    db $05 ; id 199 Digster
    db $07 ; id 200 Skularach
    db $03 ; id 201 MultiEyes
    db $00 ; id 202 ?
    db $00 ; id 203 ?
    db $00 ; id 204 ?
    db $00 ; id 205 ?
    db $00 ; id 206 ?
    db $00 ; id 207 ?
    db $00 ; id 208 ?
    db $00 ; id 209 ?
    db $00 ; id 210 ?
    db $00 ; id 211 Pixy
    db $02 ; id 212 MedusaEye
    db $04 ; id 213 AgDevil
    db $00 ; id 214 Demonite
    db $03 ; id 215 DarkEye
    db $02 ; id 216 EyeBall
    db $03 ; id 217 SkulRider
    db $04 ; id 218 EvilBeast
    db $04 ; id 219 Bubblemon
    db $01 ; id 220 1EyeClown
    db $01 ; id 221 Gremlin
    db $05 ; id 222 ArcDemon
    db $04 ; id 223 Lionex
    db $05 ; id 224 GoatHorn
    db $03 ; id 225 Orc
    db $04 ; id 226 Ogre
    db $05 ; id 227 GateGuard
    db $05 ; id 228 ChopClown
    db $05 ; id 229 BossTroll
    db $05 ; id 230 Grendal
    db $06 ; id 231 Akubar
    db $04 ; id 232 MadKnight
    db $05 ; id 233 EvilWell
    db $03 ; id 234 Gigantes
    db $05 ; id 235 Centasaur
    db $03 ; id 236 EvilArmor
    db $06 ; id 237 Jamirus
    db $06 ; id 238 Durran
    db $07 ; id 239 Titanis
    db $06 ; id 240 LampGenie
    db $00 ; id 241 ?
    db $00 ; id 242 ?
    db $00 ; id 243 ?
    db $00 ; id 244 ?
    db $00 ; id 245 ?
    db $00 ; id 246 Spooky
    db $05 ; id 247 Skullgon
    db $02 ; id 248 PutrePup
    db $01 ; id 249 RotRaven
    db $02 ; id 250 Mummy
    db $03 ; id 251 DarkCrab
    db $03 ; id 252 DeadNite
    db $02 ; id 253 Shadow
    db $02 ; id 254 Skulpent
    db $02 ; id 255 Hork
    db $01 ; id 256 Mudron
    db $02 ; id 257 NiteWhip
    db $02 ; id 258 WindMerge
    db $03 ; id 259 Reaper
    db $01 ; id 260 Inverzon
    db $01 ; id 261 FoxFire
    db $03 ; id 262 CaptDead
    db $06 ; id 263 DeadNoble
    db $06 ; id 264 WhiteKing
    db $03 ; id 265 BoneSlave
    db $04 ; id 266 Skeletor
    db $05 ; id 267 Servant
    db $07 ; id 268 Lazamanus
    db $06 ; id 269 Copycat
    db $03 ; id 270 MadSpirit
    db $02 ; id 271 PomPomBom
    db $06 ; id 272 Niterich
    db $00 ; id 273 ?
    db $00 ; id 274 ?
    db $00 ; id 275 ?
    db $00 ; id 276 ?
    db $00 ; id 277 ?
    db $00 ; id 278 ?
    db $00 ; id 279 ?
    db $00 ; id 280 ?
    db $01 ; id 281 JewelBag
    db $02 ; id 282 EvilWand
    db $00 ; id 283 MadCandle
    db $01 ; id 284 CoilBird
    db $00 ; id 285 Facer
    db $00 ; id 286 SpikyBoy
    db $03 ; id 287 MadMirror
    db $03 ; id 288 RogueNite
    db $02 ; id 289 Puppetor
    db $00 ; id 290 Goopi
    db $03 ; id 291 Voodoll
    db $04 ; id 292 MetalDrak
    db $05 ; id 293 Balzak
    db $03 ; id 294 SabreMan
    db $02 ; id 295 CurseLamp
    db $01 ; id 296 Brushead
    db $04 ; id 297 Roboster
    db $05 ; id 298 Roboster2
    db $03 ; id 299 EvilPot
    db $03 ; id 300 Gismo
    db $05 ; id 301 LavaMan
    db $05 ; id 302 IceMan
    db $04 ; id 303 Mimic
    db $03 ; id 304 Exaucers
    db $00 ; id 305 MudDoll
    db $04 ; id 306 Golem
    db $05 ; id 307 StoneMan
    db $04 ; id 308 BombCrag
    db $06 ; id 309 GoldGolem
    db $07 ; id 310 DarkMate
    db $02 ; id 311 ProtoMech
    db $04 ; id 312 CloudKing
    db $00 ; id 313 ?
    db $00 ; id 314 ?
    db $00 ; id 315 ?
    db $00 ; id 316 Petiteel
    db $00 ; id 317 Moray
    db $03 ; id 318 WalrusMan
    db $03 ; id 319 RayGigas
    db $02 ; id 320 Anemon
    db $02 ; id 321 Aquarella
    db $03 ; id 322 Merman
    db $01 ; id 323 Octokid
    db $00 ; id 324 PutreFish
    db $02 ; id 325 Octoreach
    db $03 ; id 326 Angleron
    db $03 ; id 327 FishRider
    db $04 ; id 328 RushFish
    db $01 ; id 329 Gamanian
    db $03 ; id 330 Clawster
    db $04 ; id 331 CancerMan
    db $02 ; id 332 RogueWave
    db $01 ; id 333 Scallopa
    db $04 ; id 334 SeaHorse
    db $04 ; id 335 HoodSquid
    db $04 ; id 336 MerTiger
    db $05 ; id 337 AxeShark
    db $05 ; id 338 Octogon
    db $06 ; id 339 KingSquid
    db $05 ; id 340 Digong
    db $05 ; id 341 WhaleMage
    db $06 ; id 342 Aquadon
    db $05 ; id 343 Octoraid
    db $06 ; id 344 Grakos
    db $07 ; id 345 Poseidon
    db $02 ; id 346 Pumpoise
    db $01 ; id 347 Starfish
    db $00 ; id 348 ?
    db $00 ; id 349 ?
    db $00 ; id 350 ?
    db $06 ; id 351 DracoLord
    db $06 ; id 352 DracoLord
    db $07 ; id 353 LordDraco
    db $06 ; id 354 Hargon
    db $06 ; id 355 Sidoh
    db $07 ; id 356 Genosidoh
    db $06 ; id 357 Baramos
    db $06 ; id 358 Zoma
    db $07 ; id 359 AsuraZoma
    db $06 ; id 360 Pizzaro
    db $07 ; id 361 PsychoPiz
    db $06 ; id 362 Esterk
    db $06 ; id 363 Mirudraas
    db $06 ; id 364 Mirudraas
    db $06 ; id 365 Mudou
    db $06 ; id 366 DeathMore
    db $06 ; id 367 DeathMore
    db $07 ; id 368 DeathMore
    db $07 ; id 369 Darkdrium
    db $07 ; id 370 Orgodemir
    db $07 ; id 371 Orgodemir
    db $06 ; id 372 Darck

; address loaded by ScriptCommandF6_Run_Case05
Data_00C_56D7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $05, $04

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 9 x 13 tiles, one row per line
TileRect_0C_56D9::
Data_00C_56D9:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $02, $C3, $C3, $ED, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $03, $C3, $C3, $ED, $C3, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $04, $C3, $C3, $ED, $C3, $C3, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $05, $C3, $C3, $ED, $C3, $C3, $B7 ; id 7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 8
    db $B6, $C3, $06, $C3, $C3, $ED, $C3, $C3, $B7 ; id 9
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 10
    db $B6, $C3, $07, $C3, $C3, $ED, $C3, $C3, $B7 ; id 11
    db $B3, $C5, $C3, $BE, $E2, $C6, $B4, $B4, $B5 ; id 12

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 12 x 13 tiles, one row per line
TileRect_0C_574E::
Data_00C_574E:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $20, $21, $22, $23, $24, $25, $26, $27, $28, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $29, $2A, $2B, $2C, $2D, $2E, $2F, $30, $31, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $32, $33, $34, $35, $36, $37, $38, $39, $3A, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $3B, $3C, $3D, $3E, $3F, $40, $41, $42, $43, $B7 ; id 7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 8
    db $B6, $C3, $44, $45, $46, $47, $48, $49, $4A, $4B, $4C, $B7 ; id 9
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 10
    db $B6, $C3, $4D, $4E, $4F, $50, $51, $52, $53, $54, $55, $B7 ; id 11
    db $B3, $B4, $B4, $B4, $B4, $B4, $C5, $C3, $BE, $C3, $C6, $B5 ; id 12

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 12 x 13 tiles, one row per line
TileRect_0C_57EA::
Data_00C_57EA:: ; address name
    db $B2, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 0
    db $B7, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 1
    db $B7, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 2
    db $B7, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 3
    db $B7, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 4
    db $B7, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 5
    db $B7, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 6
    db $B7, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 7
    db $B7, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 8
    db $B7, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 9
    db $B7, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 10
    db $B7, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 11
    db $B5, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 12
    db $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $66, $B9, $B9, $B9, $B9, $B9, $B9, $B9
    db $B9, $B9, $B9, $BA

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 20 x 5 tiles, one row per line
TileRect_0C_589A::
Data_00C_589A:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8A, $8B, $8C, $8D, $8E, $8F, $90, $91, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $92, $93, $94, $95, $96, $97, $98, $99, $9A, $9B, $9C, $9D, $9E, $9F, $A0, $A1, $A2, $A3, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 4

; address loaded by ScriptCommandF6_Run_Case03, ScriptCommandF6_Run_Case05, ScriptCommandF6_Run_Case0E, ScriptCommandF6_Run_Case10_Case0A
Data_00C_58FE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $79, $C3, $A1, $C3, $C9, $C3, $F1, $C3, $19, $C4, $41, $C4

; address loaded by ScriptCommandF6_Run_Case0A, ScriptCommandF6_Run_Case10_Case0A, ScriptCommandF6_Run_Case10_Case0D
Data_00C_590A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $81, $C3, $A9, $C3, $D1, $C3, $F9, $C3, $21, $C4, $49, $C4

; address loaded by ScriptCommandF6_Run_Case04, ScriptCommandF6_Run_Case0C, ScriptCommandF6_Run_Shared01, GridCellAddressFromGridCursorXAndGrid2CursorX
Data_00C_5916:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $00, $24, $00, $47, $00, $6A, $00, $8D, $00, $B0, $00, $D3, $00, $F6, $00
    db $19, $01, $3C, $01, $5F, $01, $FF, $FF

; address loaded by ScriptCommandF6_Run_Case04, ScriptCommandF6_Run_Case10_Case08
Data_00C_592E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $1B, $00, $43, $00, $67, $00, $85, $00, $A8, $00, $CA, $00, $F1, $00, $11, $01
    db $39, $01, $5C, $01, $75, $01

; address loaded by ScriptCommandF6_Run_Case0A, ScriptCommandF6_Run_Case0C, ScriptCommandF6_Run_Case10_Case08, ScriptCommandF6_Run_Shared03
Data_00C_5944:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $04, $05, $05, $04, $04, $04, $04, $04, $05, $05, $03

; address loaded by ReadGridCellByteForGridCursorXGridCursorY
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

; E-0211 (C1: ScriptCommandF6_Run_Case10_Case06 takes the monster number from GridCellAddressFromGridCursorXAndGrid2CursorX (page base from Data_00C_5916 plus the grid position) and reads the word at $599F + 2 * number: the first word ScriptCommandF6_Run_Case10_Case06 draws (graphics at vTiles2 + $300, sprite part $42); the two parents shown for the monster: for all 95 monsters whose two entries are families, FamilyPairResultTable (bank $0E) row A, column B gives that monster or parent A's species (C2 for those entries); 384 words).
; record: monster id, or $FExx = any monster of family xx ($FEFE = none)
MonsterPedigreeTableA::
Data_00C_599F:: ; address name
    dw $FE00 ; id 0 family 0
    dw $FE00 ; id 1 DrakSlime family 0
    dw $FE00 ; id 2 SpotSlime family 0
    dw $FE00 ; id 3 WingSlime family 0
    dw $FE00 ; id 4 TreeSlime family 0
    dw $FE00 ; id 5 Snaily family 0
    dw $FE00 ; id 6 SlimeNite family 0
    dw $FE00 ; id 7 Babble family 0
    dw $FE00 ; id 8 BoxSlime family 0
    dw $FE00 ; id 9 PearlGel family 0
    dw $FEFE ; id 10 Slime none
    dw $FE00 ; id 11 Healer family 0
    dw $FE00 ; id 12 FangSlime family 0
    dw $FE00 ; id 13 RockSlime family 0
    dw $0001 ; id 14 SlimeBorg DrakSlime
    dw $FE00 ; id 15 Slabbit family 0
    dw $FE00 ; id 16 KingSlime family 0
    dw $FE00 ; id 17 Metaly family 0
    dw $0011 ; id 18 Metabble Metaly
    dw $0010 ; id 19 SpotKing KingSlime
    dw $0004 ; id 20 TropicGel TreeSlime
    dw $000B ; id 21 MimeSlime Healer
    dw $0015 ; id 22 HaloSlime MimeSlime
    dw $0013 ; id 23 MetalKing SpotKing
    dw $0017 ; id 24 GoldSlime MetalKing
    dw $0018 ; id 25 GranSlime GoldSlime
    dw $FEFE ; id 26 WonderEgg none
    dw $FEFE ; id 27 Butch none
    dw $FEFE ; id 28 ? none
    dw $FEFE ; id 29 ? none
    dw $FEFE ; id 30 ? none
    dw $FEFE ; id 31 ? none
    dw $FEFE ; id 32 ? none
    dw $FEFE ; id 33 ? none
    dw $FEFE ; id 34 ? none
    dw $FEFE ; id 35 ? none
    dw $FE01 ; id 36 DragonKid family 1
    dw $FE01 ; id 37 Tortragon family 1
    dw $FE01 ; id 38 Pteranod family 1
    dw $FE01 ; id 39 Gasgon family 1
    dw $FE01 ; id 40 FairyDrak family 1
    dw $FE01 ; id 41 LizardMan family 1
    dw $FE01 ; id 42 Poisongon family 1
    dw $FE01 ; id 43 Swordgon family 1
    dw $FE01 ; id 44 Drygon family 1
    dw $0024 ; id 45 Dragon DragonKid
    dw $FE01 ; id 46 MiniDrak family 1
    dw $0027 ; id 47 MadDragon Gasgon
    dw $0029 ; id 48 Rayburn LizardMan
    dw $FE01 ; id 49 Chamelgon family 1
    dw $FE01 ; id 50 LizardFly family 1
    dw $FE01 ; id 51 Andreal family 1
    dw $FE01 ; id 52 KingCobra family 1
    dw $FE01 ; id 53 Vampirus family 1
    dw $0034 ; id 54 SnakeBat KingCobra
    dw $FE01 ; id 55 Spikerous family 1
    dw $002D ; id 56 GreatDrak Dragon
    dw $FE01 ; id 57 Crestpent family 1
    dw $0039 ; id 58 WingSnake Crestpent
    dw $003A ; id 59 Coatol WingSnake
    dw $0033 ; id 60 Orochi Andreal
    dw $FE01 ; id 61 BattleRex family 1
    dw $FE01 ; id 62 SkyDragon family 1
    dw $0038 ; id 63 Serpentia GreatDrak
    dw $003E ; id 64 Divinegon SkyDragon
    dw $0040 ; id 65 Orligon Divinegon
    dw $0038 ; id 66 GigaDraco GreatDrak
    dw $FEFE ; id 67 ? none
    dw $FEFE ; id 68 ? none
    dw $FEFE ; id 69 ? none
    dw $FEFE ; id 70 ? none
    dw $FE02 ; id 71 Tonguella family 2
    dw $FE02 ; id 72 Almiraj family 2
    dw $FE02 ; id 73 CatFly family 2
    dw $FE02 ; id 74 PillowRat family 2
    dw $FE02 ; id 75 Saccer family 2
    dw $0055 ; id 76 GulpBeast Grizzly
    dw $FE02 ; id 77 Skullroo family 2
    dw $FE02 ; id 78 WindBeast family 2
    dw $FE02 ; id 79 Beavern family 2
    dw $004B ; id 80 Antbear Saccer
    dw $0047 ; id 81 SuperTen Tonguella
    dw $FE02 ; id 82 IronTurt family 2
    dw $FE02 ; id 83 Mommonja family 2
    dw $FE02 ; id 84 HammerMan family 2
    dw $FE02 ; id 85 Grizzly family 2
    dw $005E ; id 86 Yeti WildApe
    dw $FE02 ; id 87 ArrowDog family 2
    dw $0057 ; id 88 NoctoKing ArrowDog
    dw $FE02 ; id 89 BeastNite family 2
    dw $FE02 ; id 90 MadGopher family 2
    dw $FE02 ; id 91 FairyRat family 2
    dw $0056 ; id 92 Unicorn Yeti
    dw $FE02 ; id 93 Goategon family 2
    dw $0048 ; id 94 WildApe Almiraj
    dw $005E ; id 95 Trumpeter WildApe
    dw $005F ; id 96 KingLeo Trumpeter
    dw $FE02 ; id 97 DarkHorn family 2
    dw $FE02 ; id 98 MadCat family 2
    dw $FE02 ; id 99 BigEye family 2
    dw $0061 ; id 100 Gorago DarkHorn
    dw $0049 ; id 101 CatMage CatFly
    dw $0051 ; id 102 Dumbira SuperTen
    dw $FEFE ; id 103 ? none
    dw $FEFE ; id 104 ? none
    dw $FEFE ; id 105 ? none
    dw $FE03 ; id 106 Picky family 3
    dw $FE03 ; id 107 Wyvern family 3
    dw $FE03 ; id 108 BullBird family 3
    dw $FE03 ; id 109 Florajay family 3
    dw $FE03 ; id 110 DuckKite family 3
    dw $FE03 ; id 111 MadPecker family 3
    dw $FE03 ; id 112 MadRaven family 3
    dw $FE03 ; id 113 MistyWing family 3
    dw $FE03 ; id 114 AquaHawk family 3
    dw $006A ; id 115 Dracky Picky
    dw $006E ; id 116 KiteHawk DuckKite
    dw $FEFE ; id 117 BigRoost none
    dw $FE03 ; id 118 StubBird family 3
    dw $006C ; id 119 LandOwl BullBird
    dw $006B ; id 120 MadGoose Wyvern
    dw $0077 ; id 121 MadCondor LandOwl
    dw $006F ; id 122 Emyu MadPecker
    dw $FE03 ; id 123 Blizzardy family 3
    dw $FE03 ; id 124 Phoenix family 3
    dw $007C ; id 125 ZapBird Phoenix
    dw $007D ; id 126 Garudian ZapBird
    dw $FE03 ; id 127 WhipBird family 3
    dw $FE03 ; id 128 FunkyBird family 3
    dw $007B ; id 129 RainHawk Blizzardy
    dw $0081 ; id 130 Azurile RainHawk
    dw $007F ; id 131 Shantak WhipBird
    dw $007A ; id 132 CragDevil Emyu
    dw $FEFE ; id 133 ? none
    dw $FEFE ; id 134 ? none
    dw $FEFE ; id 135 ? none
    dw $FEFE ; id 136 ? none
    dw $FEFE ; id 137 ? none
    dw $FEFE ; id 138 ? none
    dw $FEFE ; id 139 ? none
    dw $FEFE ; id 140 ? none
    dw $FE04 ; id 141 MadPlant family 4
    dw $FE04 ; id 142 FireWeed family 4
    dw $FE04 ; id 143 FloraMan family 4
    dw $FE04 ; id 144 WingTree family 4
    dw $FE04 ; id 145 CactiBall family 4
    dw $FE04 ; id 146 Gulpple family 4
    dw $FE04 ; id 147 Toadstool family 4
    dw $FE04 ; id 148 AmberWeed family 4
    dw $FE04 ; id 149 Slurperon family 4
    dw $0094 ; id 150 Stubsuck AmberWeed
    dw $FE04 ; id 151 Oniono family 4
    dw $FE04 ; id 152 DanceVegi family 4
    dw $FE04 ; id 153 TreeBoy family 4
    dw $FE04 ; id 154 Devipine family 4
    dw $009C ; id 155 FaceTree HerbMan
    dw $FE04 ; id 156 HerbMan family 4
    dw $FE04 ; id 157 BeanMan family 4
    dw $FE04 ; id 158 EvilSeed family 4
    dw $009E ; id 159 ManEater EvilSeed
    dw $009F ; id 160 Snapper ManEater
    dw $0096 ; id 161 GhosTree Stubsuck
    dw $FE04 ; id 162 Rosevine family 4
    dw $00A2 ; id 163 Egdracil Rosevine
    dw $FEFE ; id 164 Warubou none
    dw $FEFE ; id 165 Watabou none
    dw $FE04 ; id 166 Eggplaton family 4
    dw $0099 ; id 167 FooHero TreeBoy
    dw $FEFE ; id 168 ? none
    dw $FEFE ; id 169 ? none
    dw $FEFE ; id 170 ? none
    dw $FEFE ; id 171 ? none
    dw $FEFE ; id 172 ? none
    dw $FEFE ; id 173 ? none
    dw $FEFE ; id 174 ? none
    dw $FEFE ; id 175 ? none
    dw $FE05 ; id 176 GiantSlug family 5
    dw $FE05 ; id 177 Catapila family 5
    dw $FE05 ; id 178 Gophecada family 5
    dw $FE05 ; id 179 Butterfly family 5
    dw $FE05 ; id 180 WeedBug family 5
    dw $FE05 ; id 181 GiantWorm family 5
    dw $FE05 ; id 182 Lipsy family 5
    dw $FE05 ; id 183 StagBug family 5
    dw $FE05 ; id 184 Pyuro family 5
    dw $00B0 ; id 185 ArmyAnt GiantSlug
    dw $FEFE ; id 186 GoHopper none
    dw $00B4 ; id 187 TailEater WeedBug
    dw $00B5 ; id 188 ArmorPede GiantWorm
    dw $FE05 ; id 189 Eyeder family 5
    dw $00B3 ; id 190 GiantMoth Butterfly
    dw $FE05 ; id 191 Droll family 5
    dw $FE05 ; id 192 ArmyCrab family 5
    dw $00B8 ; id 193 MadHornet Pyuro
    dw $00C1 ; id 194 Belzebub MadHornet
    dw $00C5 ; id 195 WarMantis Sickler
    dw $00B7 ; id 196 HornBeet StagBug
    dw $FE05 ; id 197 Sickler family 5
    dw $00C4 ; id 198 Armorpion HornBeet
    dw $FE05 ; id 199 Digster family 5
    dw $00C6 ; id 200 Skularach Armorpion
    dw $00B1 ; id 201 MultiEyes Catapila
    dw $FEFE ; id 202 ? none
    dw $FEFE ; id 203 ? none
    dw $FEFE ; id 204 ? none
    dw $FEFE ; id 205 ? none
    dw $FEFE ; id 206 ? none
    dw $FEFE ; id 207 ? none
    dw $FEFE ; id 208 ? none
    dw $FEFE ; id 209 ? none
    dw $FEFE ; id 210 ? none
    dw $FE06 ; id 211 Pixy family 6
    dw $FE06 ; id 212 MedusaEye family 6
    dw $00DD ; id 213 AgDevil Gremlin
    dw $FE06 ; id 214 Demonite family 6
    dw $FE06 ; id 215 DarkEye family 6
    dw $FE06 ; id 216 EyeBall family 6
    dw $FE06 ; id 217 SkulRider family 6
    dw $FE06 ; id 218 EvilBeast family 6
    dw $FE06 ; id 219 Bubblemon family 6
    dw $00D8 ; id 220 1EyeClown EyeBall
    dw $FE06 ; id 221 Gremlin family 6
    dw $00E2 ; id 222 ArcDemon Ogre
    dw $FE06 ; id 223 Lionex family 6
    dw $00DE ; id 224 GoatHorn ArcDemon
    dw $FE06 ; id 225 Orc family 6
    dw $FE06 ; id 226 Ogre family 6
    dw $00D6 ; id 227 GateGuard Demonite
    dw $00DC ; id 228 ChopClown 1EyeClown
    dw $00E0 ; id 229 BossTroll GoatHorn
    dw $FE06 ; id 230 Grendal family 6
    dw $00E6 ; id 231 Akubar Grendal
    dw $FE06 ; id 232 MadKnight family 6
    dw $00E5 ; id 233 EvilWell BossTroll
    dw $00DA ; id 234 Gigantes EvilBeast
    dw $00E2 ; id 235 Centasaur Ogre
    dw $FE06 ; id 236 EvilArmor family 6
    dw $00E7 ; id 237 Jamirus Akubar
    dw $00ED ; id 238 Durran Jamirus
    dw $00EE ; id 239 Titanis Durran
    dw $00EB ; id 240 LampGenie Centasaur
    dw $FEFE ; id 241 ? none
    dw $FEFE ; id 242 ? none
    dw $FEFE ; id 243 ? none
    dw $FEFE ; id 244 ? none
    dw $FEFE ; id 245 ? none
    dw $FE07 ; id 246 Spooky family 7
    dw $00FE ; id 247 Skullgon Skulpent
    dw $00FE ; id 248 PutrePup Skulpent
    dw $FE07 ; id 249 RotRaven family 7
    dw $FE07 ; id 250 Mummy family 7
    dw $FE07 ; id 251 DarkCrab family 7
    dw $FE07 ; id 252 DeadNite family 7
    dw $FE07 ; id 253 Shadow family 7
    dw $FE07 ; id 254 Skulpent family 7
    dw $00F6 ; id 255 Hork Spooky
    dw $FE07 ; id 256 Mudron family 7
    dw $FE07 ; id 257 NiteWhip family 7
    dw $FE07 ; id 258 WindMerge family 7
    dw $00F6 ; id 259 Reaper Spooky
    dw $00FF ; id 260 Inverzon Hork
    dw $0101 ; id 261 FoxFire NiteWhip
    dw $0109 ; id 262 CaptDead BoneSlave
    dw $00FC ; id 263 DeadNoble DeadNite
    dw $0107 ; id 264 WhiteKing DeadNoble
    dw $00FA ; id 265 BoneSlave Mummy
    dw $0109 ; id 266 Skeletor BoneSlave
    dw $010A ; id 267 Servant Skeletor
    dw $0108 ; id 268 Lazamanus WhiteKing
    dw $FEFE ; id 269 Copycat none
    dw $FE07 ; id 270 MadSpirit family 7
    dw $010D ; id 271 PomPomBom Copycat
    dw $010A ; id 272 Niterich Skeletor
    dw $FEFE ; id 273 ? none
    dw $FEFE ; id 274 ? none
    dw $FEFE ; id 275 ? none
    dw $FEFE ; id 276 ? none
    dw $FEFE ; id 277 ? none
    dw $FEFE ; id 278 ? none
    dw $FEFE ; id 279 ? none
    dw $FEFE ; id 280 ? none
    dw $FE08 ; id 281 JewelBag family 8
    dw $FE08 ; id 282 EvilWand family 8
    dw $FE08 ; id 283 MadCandle family 8
    dw $FE08 ; id 284 CoilBird family 8
    dw $FE08 ; id 285 Facer family 8
    dw $FE08 ; id 286 SpikyBoy family 8
    dw $FE08 ; id 287 MadMirror family 8
    dw $FE08 ; id 288 RogueNite family 8
    dw $FE08 ; id 289 Puppetor family 8
    dw $0119 ; id 290 Goopi JewelBag
    dw $0121 ; id 291 Voodoll Puppetor
    dw $FE08 ; id 292 MetalDrak family 8
    dw $FE08 ; id 293 Balzak family 8
    dw $FE08 ; id 294 SabreMan family 8
    dw $FE08 ; id 295 CurseLamp family 8
    dw $FE08 ; id 296 Brushead family 8
    dw $0126 ; id 297 Roboster SabreMan
    dw $0129 ; id 298 Roboster2 Roboster
    dw $FE08 ; id 299 EvilPot family 8
    dw $011B ; id 300 Gismo MadCandle
    dw $0124 ; id 301 LavaMan MetalDrak
    dw $0124 ; id 302 IceMan MetalDrak
    dw $FE08 ; id 303 Mimic family 8
    dw $FE08 ; id 304 Exaucers family 8
    dw $0122 ; id 305 MudDoll Goopi
    dw $0131 ; id 306 Golem MudDoll
    dw $0132 ; id 307 StoneMan Golem
    dw $011E ; id 308 BombCrag SpikyBoy
    dw $012E ; id 309 GoldGolem IceMan
    dw $0135 ; id 310 DarkMate GoldGolem
    dw $0120 ; id 311 ProtoMech RogueNite
    dw $012C ; id 312 CloudKing Gismo
    dw $FEFE ; id 313 ? none
    dw $FEFE ; id 314 ? none
    dw $FEFE ; id 315 ? none
    dw $FE09 ; id 316 Petiteel family 9
    dw $FE09 ; id 317 Moray family 9
    dw $FE09 ; id 318 WalrusMan family 9
    dw $FE09 ; id 319 RayGigas family 9
    dw $FE09 ; id 320 Anemon family 9
    dw $FE09 ; id 321 Aquarella family 9
    dw $FE09 ; id 322 Merman family 9
    dw $FE09 ; id 323 Octokid family 9
    dw $FE09 ; id 324 PutreFish family 9
    dw $013C ; id 325 Octoreach Petiteel
    dw $013C ; id 326 Angleron Petiteel
    dw $0146 ; id 327 FishRider Angleron
    dw $0146 ; id 328 RushFish Angleron
    dw $0141 ; id 329 Gamanian Aquarella
    dw $0149 ; id 330 Clawster Gamanian
    dw $014A ; id 331 CancerMan Clawster
    dw $FE09 ; id 332 RogueWave family 9
    dw $014C ; id 333 Scallopa RogueWave
    dw $013C ; id 334 SeaHorse Petiteel
    dw $014B ; id 335 HoodSquid CancerMan
    dw $0142 ; id 336 MerTiger Merman
    dw $014B ; id 337 AxeShark CancerMan
    dw $0145 ; id 338 Octogon Octoreach
    dw $0152 ; id 339 KingSquid Octogon
    dw $0148 ; id 340 Digong RushFish
    dw $014F ; id 341 WhaleMage HoodSquid
    dw $0154 ; id 342 Aquadon Digong
    dw $0152 ; id 343 Octoraid Octogon
    dw $FE09 ; id 344 Grakos family 9
    dw $0158 ; id 345 Poseidon Grakos
    dw $FE09 ; id 346 Pumpoise family 9
    dw $0145 ; id 347 Starfish Octoreach
    dw $FEFE ; id 348 ? none
    dw $FEFE ; id 349 ? none
    dw $FEFE ; id 350 ? none
    dw $010B ; id 351 DracoLord Servant
    dw $015F ; id 352 DracoLord DracoLord
    dw $0160 ; id 353 LordDraco DracoLord
    dw $0108 ; id 354 Hargon WhiteKing
    dw $00ED ; id 355 Sidoh Jamirus
    dw $0163 ; id 356 Genosidoh Sidoh
    dw $0162 ; id 357 Baramos Hargon
    dw $015F ; id 358 Zoma DracoLord
    dw $0166 ; id 359 AsuraZoma Zoma
    dw $00EE ; id 360 Pizzaro Durran
    dw $0168 ; id 361 PsychoPiz Pizzaro
    dw $0168 ; id 362 Esterk Pizzaro
    dw $016A ; id 363 Mirudraas Esterk
    dw $016B ; id 364 Mirudraas Mirudraas
    dw $0165 ; id 365 Mudou Baramos
    dw $016B ; id 366 DeathMore Mirudraas
    dw $016E ; id 367 DeathMore DeathMore
    dw $016F ; id 368 DeathMore DeathMore
    dw $0170 ; id 369 Darkdrium DeathMore
    dw $0169 ; id 370 Orgodemir PsychoPiz
    dw $0172 ; id 371 Orgodemir Orgodemir
    dw $FEFE ; id 372 Darck none
    dw $FEFE ; id 373 Tatsu none
    dw $FEFE ; id 374 Diago none
    dw $FEFE ; id 375 Samsi none
    dw $FEFE ; id 376 Bazoo none
    dw $FEFE ; id 377 ? none
    dw $FEFE ; id 378 ? none
    dw $FEFE ; id 379 ? none
    dw $FEFE ; id 380 Lamia none
    dw $FEFE ; id 381 Dimensaur none
    dw $FEFE ; id 382 Kagebou none
    dw $FEFE ; id 383 ? none

; E-0211 (C1: a second copy of MonsterPedigreeTableA, paired with MonsterPedigreeTableB_Alt at $629F; the pair differs from A/B for 7 monsters only, and its 95 family-pair entries agree with FamilyPairResultTable too; no reader found).
; record: monster id, or $FExx = any monster of family xx ($FEFE = none)
MonsterPedigreeTableA_Alt::
Data_00C_5C9F:: ; address name
    dw $FE00 ; id 0 family 0
    dw $FE00 ; id 1 DrakSlime family 0
    dw $FE00 ; id 2 SpotSlime family 0
    dw $FE00 ; id 3 WingSlime family 0
    dw $FE00 ; id 4 TreeSlime family 0
    dw $FE00 ; id 5 Snaily family 0
    dw $FE00 ; id 6 SlimeNite family 0
    dw $FE00 ; id 7 Babble family 0
    dw $FE00 ; id 8 BoxSlime family 0
    dw $FE00 ; id 9 PearlGel family 0
    dw $FEFE ; id 10 Slime none
    dw $FE00 ; id 11 Healer family 0
    dw $FE00 ; id 12 FangSlime family 0
    dw $FE00 ; id 13 RockSlime family 0
    dw $0001 ; id 14 SlimeBorg DrakSlime
    dw $FE00 ; id 15 Slabbit family 0
    dw $FE00 ; id 16 KingSlime family 0
    dw $FE00 ; id 17 Metaly family 0
    dw $0011 ; id 18 Metabble Metaly
    dw $0010 ; id 19 SpotKing KingSlime
    dw $0004 ; id 20 TropicGel TreeSlime
    dw $000B ; id 21 MimeSlime Healer
    dw $0015 ; id 22 HaloSlime MimeSlime
    dw $0013 ; id 23 MetalKing SpotKing
    dw $0017 ; id 24 GoldSlime MetalKing
    dw $0018 ; id 25 GranSlime GoldSlime
    dw $FEFE ; id 26 WonderEgg none
    dw $FEFE ; id 27 Butch none
    dw $FEFE ; id 28 ? none
    dw $FEFE ; id 29 ? none
    dw $FEFE ; id 30 ? none
    dw $FEFE ; id 31 ? none
    dw $FEFE ; id 32 ? none
    dw $FEFE ; id 33 ? none
    dw $FEFE ; id 34 ? none
    dw $FEFE ; id 35 ? none
    dw $FE01 ; id 36 DragonKid family 1
    dw $FE01 ; id 37 Tortragon family 1
    dw $FE01 ; id 38 Pteranod family 1
    dw $FE01 ; id 39 Gasgon family 1
    dw $FE01 ; id 40 FairyDrak family 1
    dw $FE01 ; id 41 LizardMan family 1
    dw $FE01 ; id 42 Poisongon family 1
    dw $FE01 ; id 43 Swordgon family 1
    dw $FE01 ; id 44 Drygon family 1
    dw $0024 ; id 45 Dragon DragonKid
    dw $FE01 ; id 46 MiniDrak family 1
    dw $0027 ; id 47 MadDragon Gasgon
    dw $0029 ; id 48 Rayburn LizardMan
    dw $FE01 ; id 49 Chamelgon family 1
    dw $FE01 ; id 50 LizardFly family 1
    dw $FE01 ; id 51 Andreal family 1
    dw $FE01 ; id 52 KingCobra family 1
    dw $FE01 ; id 53 Vampirus family 1
    dw $0034 ; id 54 SnakeBat KingCobra
    dw $FE01 ; id 55 Spikerous family 1
    dw $002D ; id 56 GreatDrak Dragon
    dw $FE01 ; id 57 Crestpent family 1
    dw $0039 ; id 58 WingSnake Crestpent
    dw $003A ; id 59 Coatol WingSnake
    dw $0033 ; id 60 Orochi Andreal
    dw $FE01 ; id 61 BattleRex family 1
    dw $FE01 ; id 62 SkyDragon family 1
    dw $0038 ; id 63 Serpentia GreatDrak
    dw $003E ; id 64 Divinegon SkyDragon
    dw $0040 ; id 65 Orligon Divinegon
    dw $0038 ; id 66 GigaDraco GreatDrak
    dw $FEFE ; id 67 ? none
    dw $FEFE ; id 68 ? none
    dw $FEFE ; id 69 ? none
    dw $FEFE ; id 70 ? none
    dw $FE02 ; id 71 Tonguella family 2
    dw $FE02 ; id 72 Almiraj family 2
    dw $FE02 ; id 73 CatFly family 2
    dw $FE02 ; id 74 PillowRat family 2
    dw $FE02 ; id 75 Saccer family 2
    dw $0055 ; id 76 GulpBeast Grizzly
    dw $FE02 ; id 77 Skullroo family 2
    dw $FE02 ; id 78 WindBeast family 2
    dw $FE02 ; id 79 Beavern family 2
    dw $004B ; id 80 Antbear Saccer
    dw $FE02 ; id 81 SuperTen family 2
    dw $FE02 ; id 82 IronTurt family 2
    dw $FE02 ; id 83 Mommonja family 2
    dw $FE02 ; id 84 HammerMan family 2
    dw $FE02 ; id 85 Grizzly family 2
    dw $005E ; id 86 Yeti WildApe
    dw $FE02 ; id 87 ArrowDog family 2
    dw $0057 ; id 88 NoctoKing ArrowDog
    dw $FE02 ; id 89 BeastNite family 2
    dw $FE02 ; id 90 MadGopher family 2
    dw $FE02 ; id 91 FairyRat family 2
    dw $0056 ; id 92 Unicorn Yeti
    dw $FE02 ; id 93 Goategon family 2
    dw $0048 ; id 94 WildApe Almiraj
    dw $005E ; id 95 Trumpeter WildApe
    dw $005F ; id 96 KingLeo Trumpeter
    dw $FE02 ; id 97 DarkHorn family 2
    dw $FE02 ; id 98 MadCat family 2
    dw $FE02 ; id 99 BigEye family 2
    dw $0061 ; id 100 Gorago DarkHorn
    dw $0049 ; id 101 CatMage CatFly
    dw $0051 ; id 102 Dumbira SuperTen
    dw $FEFE ; id 103 ? none
    dw $FEFE ; id 104 ? none
    dw $FEFE ; id 105 ? none
    dw $FE03 ; id 106 Picky family 3
    dw $FE03 ; id 107 Wyvern family 3
    dw $FE03 ; id 108 BullBird family 3
    dw $FE03 ; id 109 Florajay family 3
    dw $FE03 ; id 110 DuckKite family 3
    dw $FE03 ; id 111 MadPecker family 3
    dw $FE03 ; id 112 MadRaven family 3
    dw $FE03 ; id 113 MistyWing family 3
    dw $FE03 ; id 114 AquaHawk family 3
    dw $006A ; id 115 Dracky Picky
    dw $FE03 ; id 116 KiteHawk family 3
    dw $FEFE ; id 117 BigRoost none
    dw $FE03 ; id 118 StubBird family 3
    dw $006C ; id 119 LandOwl BullBird
    dw $006B ; id 120 MadGoose Wyvern
    dw $0077 ; id 121 MadCondor LandOwl
    dw $006F ; id 122 Emyu MadPecker
    dw $FE03 ; id 123 Blizzardy family 3
    dw $FE03 ; id 124 Phoenix family 3
    dw $007C ; id 125 ZapBird Phoenix
    dw $007D ; id 126 Garudian ZapBird
    dw $FE03 ; id 127 WhipBird family 3
    dw $FE03 ; id 128 FunkyBird family 3
    dw $007B ; id 129 RainHawk Blizzardy
    dw $0081 ; id 130 Azurile RainHawk
    dw $007F ; id 131 Shantak WhipBird
    dw $007A ; id 132 CragDevil Emyu
    dw $FEFE ; id 133 ? none
    dw $FEFE ; id 134 ? none
    dw $FEFE ; id 135 ? none
    dw $FEFE ; id 136 ? none
    dw $FEFE ; id 137 ? none
    dw $FEFE ; id 138 ? none
    dw $FEFE ; id 139 ? none
    dw $FEFE ; id 140 ? none
    dw $FE04 ; id 141 MadPlant family 4
    dw $FE04 ; id 142 FireWeed family 4
    dw $FE04 ; id 143 FloraMan family 4
    dw $FE04 ; id 144 WingTree family 4
    dw $FE04 ; id 145 CactiBall family 4
    dw $FE04 ; id 146 Gulpple family 4
    dw $FE04 ; id 147 Toadstool family 4
    dw $FE04 ; id 148 AmberWeed family 4
    dw $FE04 ; id 149 Slurperon family 4
    dw $0094 ; id 150 Stubsuck AmberWeed
    dw $FE04 ; id 151 Oniono family 4
    dw $008D ; id 152 DanceVegi MadPlant
    dw $FE04 ; id 153 TreeBoy family 4
    dw $FE04 ; id 154 Devipine family 4
    dw $FE04 ; id 155 FaceTree family 4
    dw $FE04 ; id 156 HerbMan family 4
    dw $FE04 ; id 157 BeanMan family 4
    dw $FE04 ; id 158 EvilSeed family 4
    dw $009E ; id 159 ManEater EvilSeed
    dw $009F ; id 160 Snapper ManEater
    dw $0096 ; id 161 GhosTree Stubsuck
    dw $FE04 ; id 162 Rosevine family 4
    dw $00A2 ; id 163 Egdracil Rosevine
    dw $FEFE ; id 164 Warubou none
    dw $FEFE ; id 165 Watabou none
    dw $FE04 ; id 166 Eggplaton family 4
    dw $0099 ; id 167 FooHero TreeBoy
    dw $FEFE ; id 168 ? none
    dw $FEFE ; id 169 ? none
    dw $FEFE ; id 170 ? none
    dw $FEFE ; id 171 ? none
    dw $FEFE ; id 172 ? none
    dw $FEFE ; id 173 ? none
    dw $FEFE ; id 174 ? none
    dw $FEFE ; id 175 ? none
    dw $FE05 ; id 176 GiantSlug family 5
    dw $FE05 ; id 177 Catapila family 5
    dw $FE05 ; id 178 Gophecada family 5
    dw $FE05 ; id 179 Butterfly family 5
    dw $FE05 ; id 180 WeedBug family 5
    dw $FE05 ; id 181 GiantWorm family 5
    dw $FE05 ; id 182 Lipsy family 5
    dw $FE05 ; id 183 StagBug family 5
    dw $FE05 ; id 184 Pyuro family 5
    dw $00B0 ; id 185 ArmyAnt GiantSlug
    dw $FEFE ; id 186 GoHopper none
    dw $00B4 ; id 187 TailEater WeedBug
    dw $00B5 ; id 188 ArmorPede GiantWorm
    dw $FE05 ; id 189 Eyeder family 5
    dw $00B3 ; id 190 GiantMoth Butterfly
    dw $FE05 ; id 191 Droll family 5
    dw $FE05 ; id 192 ArmyCrab family 5
    dw $00B8 ; id 193 MadHornet Pyuro
    dw $00C1 ; id 194 Belzebub MadHornet
    dw $00C5 ; id 195 WarMantis Sickler
    dw $00B7 ; id 196 HornBeet StagBug
    dw $FE05 ; id 197 Sickler family 5
    dw $00C4 ; id 198 Armorpion HornBeet
    dw $FE05 ; id 199 Digster family 5
    dw $00C6 ; id 200 Skularach Armorpion
    dw $00B1 ; id 201 MultiEyes Catapila
    dw $FEFE ; id 202 ? none
    dw $FEFE ; id 203 ? none
    dw $FEFE ; id 204 ? none
    dw $FEFE ; id 205 ? none
    dw $FEFE ; id 206 ? none
    dw $FEFE ; id 207 ? none
    dw $FEFE ; id 208 ? none
    dw $FEFE ; id 209 ? none
    dw $FEFE ; id 210 ? none
    dw $FE06 ; id 211 Pixy family 6
    dw $FE06 ; id 212 MedusaEye family 6
    dw $00DD ; id 213 AgDevil Gremlin
    dw $FE06 ; id 214 Demonite family 6
    dw $FE06 ; id 215 DarkEye family 6
    dw $FE06 ; id 216 EyeBall family 6
    dw $FE06 ; id 217 SkulRider family 6
    dw $FE06 ; id 218 EvilBeast family 6
    dw $FE06 ; id 219 Bubblemon family 6
    dw $00D8 ; id 220 1EyeClown EyeBall
    dw $FE06 ; id 221 Gremlin family 6
    dw $00E2 ; id 222 ArcDemon Ogre
    dw $FE06 ; id 223 Lionex family 6
    dw $00DE ; id 224 GoatHorn ArcDemon
    dw $FE06 ; id 225 Orc family 6
    dw $FE06 ; id 226 Ogre family 6
    dw $00D6 ; id 227 GateGuard Demonite
    dw $00DC ; id 228 ChopClown 1EyeClown
    dw $00E0 ; id 229 BossTroll GoatHorn
    dw $FE06 ; id 230 Grendal family 6
    dw $00E6 ; id 231 Akubar Grendal
    dw $FE06 ; id 232 MadKnight family 6
    dw $00E5 ; id 233 EvilWell BossTroll
    dw $00DA ; id 234 Gigantes EvilBeast
    dw $00E2 ; id 235 Centasaur Ogre
    dw $FE06 ; id 236 EvilArmor family 6
    dw $00E7 ; id 237 Jamirus Akubar
    dw $00ED ; id 238 Durran Jamirus
    dw $00EE ; id 239 Titanis Durran
    dw $00EB ; id 240 LampGenie Centasaur
    dw $FEFE ; id 241 ? none
    dw $FEFE ; id 242 ? none
    dw $FEFE ; id 243 ? none
    dw $FEFE ; id 244 ? none
    dw $FEFE ; id 245 ? none
    dw $FE07 ; id 246 Spooky family 7
    dw $00FE ; id 247 Skullgon Skulpent
    dw $00FE ; id 248 PutrePup Skulpent
    dw $FE07 ; id 249 RotRaven family 7
    dw $FE07 ; id 250 Mummy family 7
    dw $FE07 ; id 251 DarkCrab family 7
    dw $FE07 ; id 252 DeadNite family 7
    dw $FE07 ; id 253 Shadow family 7
    dw $FE07 ; id 254 Skulpent family 7
    dw $00F6 ; id 255 Hork Spooky
    dw $FE07 ; id 256 Mudron family 7
    dw $FE07 ; id 257 NiteWhip family 7
    dw $FE07 ; id 258 WindMerge family 7
    dw $00F6 ; id 259 Reaper Spooky
    dw $00FF ; id 260 Inverzon Hork
    dw $0101 ; id 261 FoxFire NiteWhip
    dw $0109 ; id 262 CaptDead BoneSlave
    dw $00FC ; id 263 DeadNoble DeadNite
    dw $0107 ; id 264 WhiteKing DeadNoble
    dw $00FA ; id 265 BoneSlave Mummy
    dw $0109 ; id 266 Skeletor BoneSlave
    dw $010A ; id 267 Servant Skeletor
    dw $0108 ; id 268 Lazamanus WhiteKing
    dw $FEFE ; id 269 Copycat none
    dw $FE07 ; id 270 MadSpirit family 7
    dw $010D ; id 271 PomPomBom Copycat
    dw $010A ; id 272 Niterich Skeletor
    dw $FEFE ; id 273 ? none
    dw $FEFE ; id 274 ? none
    dw $FEFE ; id 275 ? none
    dw $FEFE ; id 276 ? none
    dw $FEFE ; id 277 ? none
    dw $FEFE ; id 278 ? none
    dw $FEFE ; id 279 ? none
    dw $FEFE ; id 280 ? none
    dw $FE08 ; id 281 JewelBag family 8
    dw $FE08 ; id 282 EvilWand family 8
    dw $FE08 ; id 283 MadCandle family 8
    dw $FE08 ; id 284 CoilBird family 8
    dw $FE08 ; id 285 Facer family 8
    dw $FE08 ; id 286 SpikyBoy family 8
    dw $FE08 ; id 287 MadMirror family 8
    dw $FE08 ; id 288 RogueNite family 8
    dw $FE08 ; id 289 Puppetor family 8
    dw $0119 ; id 290 Goopi JewelBag
    dw $0121 ; id 291 Voodoll Puppetor
    dw $FE08 ; id 292 MetalDrak family 8
    dw $FE08 ; id 293 Balzak family 8
    dw $FE08 ; id 294 SabreMan family 8
    dw $FE08 ; id 295 CurseLamp family 8
    dw $FE08 ; id 296 Brushead family 8
    dw $0126 ; id 297 Roboster SabreMan
    dw $0129 ; id 298 Roboster2 Roboster
    dw $FE08 ; id 299 EvilPot family 8
    dw $011B ; id 300 Gismo MadCandle
    dw $0124 ; id 301 LavaMan MetalDrak
    dw $0124 ; id 302 IceMan MetalDrak
    dw $FE08 ; id 303 Mimic family 8
    dw $FE08 ; id 304 Exaucers family 8
    dw $0122 ; id 305 MudDoll Goopi
    dw $0131 ; id 306 Golem MudDoll
    dw $0132 ; id 307 StoneMan Golem
    dw $011E ; id 308 BombCrag SpikyBoy
    dw $012E ; id 309 GoldGolem IceMan
    dw $0135 ; id 310 DarkMate GoldGolem
    dw $0120 ; id 311 ProtoMech RogueNite
    dw $012C ; id 312 CloudKing Gismo
    dw $FEFE ; id 313 ? none
    dw $FEFE ; id 314 ? none
    dw $FEFE ; id 315 ? none
    dw $FE09 ; id 316 Petiteel family 9
    dw $FE09 ; id 317 Moray family 9
    dw $FE09 ; id 318 WalrusMan family 9
    dw $FE09 ; id 319 RayGigas family 9
    dw $FE09 ; id 320 Anemon family 9
    dw $FE09 ; id 321 Aquarella family 9
    dw $FE09 ; id 322 Merman family 9
    dw $FE09 ; id 323 Octokid family 9
    dw $FE09 ; id 324 PutreFish family 9
    dw $013C ; id 325 Octoreach Petiteel
    dw $013C ; id 326 Angleron Petiteel
    dw $0146 ; id 327 FishRider Angleron
    dw $0146 ; id 328 RushFish Angleron
    dw $0141 ; id 329 Gamanian Aquarella
    dw $0149 ; id 330 Clawster Gamanian
    dw $014A ; id 331 CancerMan Clawster
    dw $FE09 ; id 332 RogueWave family 9
    dw $014C ; id 333 Scallopa RogueWave
    dw $013C ; id 334 SeaHorse Petiteel
    dw $014B ; id 335 HoodSquid CancerMan
    dw $0142 ; id 336 MerTiger Merman
    dw $014B ; id 337 AxeShark CancerMan
    dw $0145 ; id 338 Octogon Octoreach
    dw $0152 ; id 339 KingSquid Octogon
    dw $0148 ; id 340 Digong RushFish
    dw $014F ; id 341 WhaleMage HoodSquid
    dw $0154 ; id 342 Aquadon Digong
    dw $0152 ; id 343 Octoraid Octogon
    dw $FE09 ; id 344 Grakos family 9
    dw $0158 ; id 345 Poseidon Grakos
    dw $FE09 ; id 346 Pumpoise family 9
    dw $0145 ; id 347 Starfish Octoreach
    dw $FEFE ; id 348 ? none
    dw $FEFE ; id 349 ? none
    dw $FEFE ; id 350 ? none
    dw $010B ; id 351 DracoLord Servant
    dw $015F ; id 352 DracoLord DracoLord
    dw $0160 ; id 353 LordDraco DracoLord
    dw $0108 ; id 354 Hargon WhiteKing
    dw $00ED ; id 355 Sidoh Jamirus
    dw $0163 ; id 356 Genosidoh Sidoh
    dw $0162 ; id 357 Baramos Hargon
    dw $015F ; id 358 Zoma DracoLord
    dw $0166 ; id 359 AsuraZoma Zoma
    dw $00EE ; id 360 Pizzaro Durran
    dw $0168 ; id 361 PsychoPiz Pizzaro
    dw $0168 ; id 362 Esterk Pizzaro
    dw $016A ; id 363 Mirudraas Esterk
    dw $016B ; id 364 Mirudraas Mirudraas
    dw $0165 ; id 365 Mudou Baramos
    dw $016B ; id 366 DeathMore Mirudraas
    dw $016E ; id 367 DeathMore DeathMore
    dw $016F ; id 368 DeathMore DeathMore
    dw $0170 ; id 369 Darkdrium DeathMore
    dw $0169 ; id 370 Orgodemir PsychoPiz
    dw $0172 ; id 371 Orgodemir Orgodemir
    dw $FEFE ; id 372 Darck none
    dw $FEFE ; id 373 Tatsu none
    dw $FEFE ; id 374 Diago none
    dw $FEFE ; id 375 Samsi none
    dw $FEFE ; id 376 Bazoo none
    dw $FEFE ; id 377 ? none
    dw $FEFE ; id 378 ? none
    dw $FEFE ; id 379 ? none
    dw $FEFE ; id 380 Lamia none
    dw $FEFE ; id 381 Dimensaur none
    dw $FEFE ; id 382 Kagebou none
    dw $FEFE ; id 383 ? none

; E-0211 (C1: ScriptCommandF6_Run_Case10_Case06 takes the monster number from GridCellAddressFromGridCursorXAndGrid2CursorX (page base from Data_00C_5916 plus the grid position) and reads the word at $5F9F + 2 * number: the second word (vTiles2 + $390, sprite part $43); the two parents shown for the monster: for all 95 monsters whose two entries are families, FamilyPairResultTable (bank $0E) row A, column B gives that monster or parent A's species (C2 for those entries); 384 words).
; record: monster id, or $FExx = any monster of family xx ($FEFE = none)
MonsterPedigreeTableB::
Data_00C_5F9F:: ; address name
    dw $FEFE ; id 0 none
    dw $FE01 ; id 1 DrakSlime family 1
    dw $FE02 ; id 2 SpotSlime family 2
    dw $FE03 ; id 3 WingSlime family 3
    dw $FE04 ; id 4 TreeSlime family 4
    dw $FE05 ; id 5 Snaily family 5
    dw $FE06 ; id 6 SlimeNite family 6
    dw $FE07 ; id 7 Babble family 7
    dw $FE08 ; id 8 BoxSlime family 8
    dw $FE09 ; id 9 PearlGel family 9
    dw $FEFE ; id 10 Slime none
    dw $004A ; id 11 Healer PillowRat
    dw $0048 ; id 12 FangSlime Almiraj
    dw $0132 ; id 13 RockSlime Golem
    dw $002B ; id 14 SlimeBorg Swordgon
    dw $004D ; id 15 Slabbit Skullroo
    dw $FE0A ; id 16 KingSlime family 10
    dw $0124 ; id 17 Metaly MetalDrak
    dw $0011 ; id 18 Metabble Metaly
    dw $005C ; id 19 SpotKing Unicorn
    dw $FE02 ; id 20 TropicGel family 2
    dw $00DC ; id 21 MimeSlime 1EyeClown
    dw $FE07 ; id 22 HaloSlime family 7
    dw $0124 ; id 23 MetalKing MetalDrak
    dw $0017 ; id 24 GoldSlime MetalKing
    dw $0018 ; id 25 GranSlime GoldSlime
    dw $FEFE ; id 26 WonderEgg none
    dw $FEFE ; id 27 Butch none
    dw $FEFE ; id 28 ? none
    dw $FEFE ; id 29 ? none
    dw $FEFE ; id 30 ? none
    dw $FEFE ; id 31 ? none
    dw $FEFE ; id 32 ? none
    dw $FEFE ; id 33 ? none
    dw $FEFE ; id 34 ? none
    dw $FEFE ; id 35 ? none
    dw $FE00 ; id 36 DragonKid family 0
    dw $FE02 ; id 37 Tortragon family 2
    dw $FE03 ; id 38 Pteranod family 3
    dw $FE04 ; id 39 Gasgon family 4
    dw $FE05 ; id 40 FairyDrak family 5
    dw $FE06 ; id 41 LizardMan family 6
    dw $FE07 ; id 42 Poisongon family 7
    dw $FE08 ; id 43 Swordgon family 8
    dw $FE09 ; id 44 Drygon family 9
    dw $0024 ; id 45 Dragon DragonKid
    dw $006A ; id 46 MiniDrak Picky
    dw $FE02 ; id 47 MadDragon family 2
    dw $0003 ; id 48 Rayburn WingSlime
    dw $0123 ; id 49 Chamelgon Voodoll
    dw $00BA ; id 50 LizardFly GoHopper
    dw $0092 ; id 51 Andreal Gulpple
    dw $0007 ; id 52 KingCobra Babble
    dw $0078 ; id 53 Vampirus MadGoose
    dw $0073 ; id 54 SnakeBat Dracky
    dw $00C0 ; id 55 Spikerous ArmyCrab
    dw $002D ; id 56 GreatDrak Dragon
    dw $0075 ; id 57 Crestpent BigRoost
    dw $0039 ; id 58 WingSnake Crestpent
    dw $003A ; id 59 Coatol WingSnake
    dw $00D4 ; id 60 Orochi MedusaEye
    dw $00E8 ; id 61 BattleRex MadKnight
    dw $007C ; id 62 SkyDragon Phoenix
    dw $00DF ; id 63 Serpentia Lionex
    dw $003C ; id 64 Divinegon Orochi
    dw $0135 ; id 65 Orligon GoldGolem
    dw $00EA ; id 66 GigaDraco Gigantes
    dw $FEFE ; id 67 ? none
    dw $FEFE ; id 68 ? none
    dw $FEFE ; id 69 ? none
    dw $FEFE ; id 70 ? none
    dw $FE00 ; id 71 Tonguella family 0
    dw $FE01 ; id 72 Almiraj family 1
    dw $FE03 ; id 73 CatFly family 3
    dw $FE04 ; id 74 PillowRat family 4
    dw $FE05 ; id 75 Saccer family 5
    dw $FE01 ; id 76 GulpBeast family 1
    dw $FE07 ; id 77 Skullroo family 7
    dw $FE08 ; id 78 WindBeast family 8
    dw $FE09 ; id 79 Beavern family 9
    dw $FE01 ; id 80 Antbear family 1
    dw $00D6 ; id 81 SuperTen Demonite
    dw $0025 ; id 82 IronTurt Tortragon
    dw $006E ; id 83 Mommonja DuckKite
    dw $0096 ; id 84 HammerMan Stubsuck
    dw $FE06 ; id 85 Grizzly family 6
    dw $002B ; id 86 Yeti Swordgon
    dw $00F8 ; id 87 ArrowDog PutrePup
    dw $00FD ; id 88 NoctoKing Shadow
    dw $00EC ; id 89 BeastNite EvilArmor
    dw $0126 ; id 90 MadGopher SabreMan
    dw $0032 ; id 91 FairyRat LizardFly
    dw $FE00 ; id 92 Unicorn family 0
    dw $0029 ; id 93 Goategon LizardMan
    dw $FE01 ; id 94 WildApe family 1
    dw $005E ; id 95 Trumpeter WildApe
    dw $005F ; id 96 KingLeo Trumpeter
    dw $FE0A ; id 97 DarkHorn family 10
    dw $002D ; id 98 MadCat Dragon
    dw $00D8 ; id 99 BigEye EyeBall
    dw $003C ; id 100 Gorago Orochi
    dw $0099 ; id 101 CatMage TreeBoy
    dw $0126 ; id 102 Dumbira SabreMan
    dw $FEFE ; id 103 ? none
    dw $FEFE ; id 104 ? none
    dw $FEFE ; id 105 ? none
    dw $FE00 ; id 106 Picky family 0
    dw $FE01 ; id 107 Wyvern family 1
    dw $FE02 ; id 108 BullBird family 2
    dw $FE04 ; id 109 Florajay family 4
    dw $FE05 ; id 110 DuckKite family 5
    dw $FE06 ; id 111 MadPecker family 6
    dw $FE07 ; id 112 MadRaven family 7
    dw $FE08 ; id 113 MistyWing family 8
    dw $FE09 ; id 114 AquaHawk family 9
    dw $FE00 ; id 115 Dracky family 0
    dw $FE08 ; id 116 KiteHawk family 8
    dw $FEFE ; id 117 BigRoost none
    dw $000D ; id 118 StubBird RockSlime
    dw $FE06 ; id 119 LandOwl family 6
    dw $FE07 ; id 120 MadGoose family 7
    dw $FE06 ; id 121 MadCondor family 6
    dw $00D7 ; id 122 Emyu DarkEye
    dw $0011 ; id 123 Blizzardy Metaly
    dw $0001 ; id 124 Phoenix DrakSlime
    dw $012C ; id 125 ZapBird Gismo
    dw $00DF ; id 126 Garudian Lionex
    dw $0030 ; id 127 WhipBird Rayburn
    dw $0098 ; id 128 FunkyBird DanceVegi
    dw $007C ; id 129 RainHawk Phoenix
    dw $FE0A ; id 130 Azurile family 10
    dw $0038 ; id 131 Shantak GreatDrak
    dw $FE02 ; id 132 CragDevil family 2
    dw $FEFE ; id 133 ? none
    dw $FEFE ; id 134 ? none
    dw $FEFE ; id 135 ? none
    dw $FEFE ; id 136 ? none
    dw $FEFE ; id 137 ? none
    dw $FEFE ; id 138 ? none
    dw $FEFE ; id 139 ? none
    dw $FEFE ; id 140 ? none
    dw $FE00 ; id 141 MadPlant family 0
    dw $FE01 ; id 142 FireWeed family 1
    dw $FE02 ; id 143 FloraMan family 2
    dw $FE03 ; id 144 WingTree family 3
    dw $FE05 ; id 145 CactiBall family 5
    dw $FE06 ; id 146 Gulpple family 6
    dw $FE07 ; id 147 Toadstool family 7
    dw $FE08 ; id 148 AmberWeed family 8
    dw $FE09 ; id 149 Slurperon family 9
    dw $FE02 ; id 150 Stubsuck family 2
    dw $0140 ; id 151 Oniono Anemon
    dw $011D ; id 152 DanceVegi Facer
    dw $00D3 ; id 153 TreeBoy Pixy
    dw $0092 ; id 154 Devipine Gulpple
    dw $FE01 ; id 155 FaceTree family 1
    dw $0080 ; id 156 HerbMan FunkyBird
    dw $004A ; id 157 BeanMan PillowRat
    dw $000D ; id 158 EvilSeed RockSlime
    dw $009E ; id 159 ManEater EvilSeed
    dw $009F ; id 160 Snapper ManEater
    dw $FE07 ; id 161 GhosTree family 7
    dw $FE0A ; id 162 Rosevine family 10
    dw $00EA ; id 163 Egdracil Gigantes
    dw $FEFE ; id 164 Warubou none
    dw $FEFE ; id 165 Watabou none
    dw $00B6 ; id 166 Eggplaton Lipsy
    dw $0006 ; id 167 FooHero SlimeNite
    dw $FEFE ; id 168 ? none
    dw $FEFE ; id 169 ? none
    dw $FEFE ; id 170 ? none
    dw $FEFE ; id 171 ? none
    dw $FEFE ; id 172 ? none
    dw $FEFE ; id 173 ? none
    dw $FEFE ; id 174 ? none
    dw $FEFE ; id 175 ? none
    dw $FE00 ; id 176 GiantSlug family 0
    dw $FE01 ; id 177 Catapila family 1
    dw $FE02 ; id 178 Gophecada family 2
    dw $FE03 ; id 179 Butterfly family 3
    dw $FE04 ; id 180 WeedBug family 4
    dw $FE06 ; id 181 GiantWorm family 6
    dw $FE07 ; id 182 Lipsy family 7
    dw $FE08 ; id 183 StagBug family 8
    dw $FE09 ; id 184 Pyuro family 9
    dw $FE00 ; id 185 ArmyAnt family 0
    dw $FEFE ; id 186 GoHopper none
    dw $FE04 ; id 187 TailEater family 4
    dw $FE08 ; id 188 ArmorPede family 8
    dw $0149 ; id 189 Eyeder Gamanian
    dw $FE06 ; id 190 GiantMoth family 6
    dw $00F6 ; id 191 Droll Spooky
    dw $00FB ; id 192 ArmyCrab DarkCrab
    dw $FE07 ; id 193 MadHornet family 7
    dw $FE07 ; id 194 Belzebub family 7
    dw $FE06 ; id 195 WarMantis family 6
    dw $00B7 ; id 196 HornBeet StagBug
    dw $00DC ; id 197 Sickler 1EyeClown
    dw $00C4 ; id 198 Armorpion HornBeet
    dw $FE0A ; id 199 Digster family 10
    dw $0108 ; id 200 Skularach WhiteKing
    dw $00B1 ; id 201 MultiEyes Catapila
    dw $FEFE ; id 202 ? none
    dw $FEFE ; id 203 ? none
    dw $FEFE ; id 204 ? none
    dw $FEFE ; id 205 ? none
    dw $FEFE ; id 206 ? none
    dw $FEFE ; id 207 ? none
    dw $FEFE ; id 208 ? none
    dw $FEFE ; id 209 ? none
    dw $FEFE ; id 210 ? none
    dw $FE00 ; id 211 Pixy family 0
    dw $FE01 ; id 212 MedusaEye family 1
    dw $FE01 ; id 213 AgDevil family 1
    dw $FE03 ; id 214 Demonite family 3
    dw $FE04 ; id 215 DarkEye family 4
    dw $FE05 ; id 216 EyeBall family 5
    dw $FE07 ; id 217 SkulRider family 7
    dw $FE08 ; id 218 EvilBeast family 8
    dw $FE09 ; id 219 Bubblemon family 9
    dw $FE00 ; id 220 1EyeClown family 0
    dw $FE02 ; id 221 Gremlin family 2
    dw $FE01 ; id 222 ArcDemon family 1
    dw $0029 ; id 223 Lionex LizardMan
    dw $FE02 ; id 224 GoatHorn family 2
    dw $009D ; id 225 Orc BeanMan
    dw $0054 ; id 226 Ogre HammerMan
    dw $00D6 ; id 227 GateGuard Demonite
    dw $00DC ; id 228 ChopClown 1EyeClown
    dw $FE02 ; id 229 BossTroll family 2
    dw $0059 ; id 230 Grendal BeastNite
    dw $00E6 ; id 231 Akubar Grendal
    dw $0120 ; id 232 MadKnight RogueNite
    dw $012E ; id 233 EvilWell IceMan
    dw $FE07 ; id 234 Gigantes family 7
    dw $FE02 ; id 235 Centasaur family 2
    dw $00BC ; id 236 EvilArmor ArmorPede
    dw $0081 ; id 237 Jamirus RainHawk
    dw $003F ; id 238 Durran Serpentia
    dw $0061 ; id 239 Titanis DarkHorn
    dw $FE0A ; id 240 LampGenie family 10
    dw $FEFE ; id 241 ? none
    dw $FEFE ; id 242 ? none
    dw $FEFE ; id 243 ? none
    dw $FEFE ; id 244 ? none
    dw $FEFE ; id 245 ? none
    dw $FE00 ; id 246 Spooky family 0
    dw $FE01 ; id 247 Skullgon family 1
    dw $FE02 ; id 248 PutrePup family 2
    dw $FE03 ; id 249 RotRaven family 3
    dw $FE04 ; id 250 Mummy family 4
    dw $FE05 ; id 251 DarkCrab family 5
    dw $FE06 ; id 252 DeadNite family 6
    dw $FE08 ; id 253 Shadow family 8
    dw $FE09 ; id 254 Skulpent family 9
    dw $FE02 ; id 255 Hork family 2
    dw $00BF ; id 256 Mudron Droll
    dw $0071 ; id 257 NiteWhip MistyWing
    dw $004E ; id 258 WindMerge WindBeast
    dw $FE06 ; id 259 Reaper family 6
    dw $00FF ; id 260 Inverzon Hork
    dw $FE02 ; id 261 FoxFire family 2
    dw $FE09 ; id 262 CaptDead family 9
    dw $00FC ; id 263 DeadNoble DeadNite
    dw $0013 ; id 264 WhiteKing SpotKing
    dw $008F ; id 265 BoneSlave FloraMan
    dw $0109 ; id 266 Skeletor BoneSlave
    dw $010A ; id 267 Servant Skeletor
    dw $015F ; id 268 Lazamanus DracoLord
    dw $FEFE ; id 269 Copycat none
    dw $FE01 ; id 270 MadSpirit family 1
    dw $0027 ; id 271 PomPomBom Gasgon
    dw $012A ; id 272 Niterich Roboster2
    dw $FEFE ; id 273 ? none
    dw $FEFE ; id 274 ? none
    dw $FEFE ; id 275 ? none
    dw $FEFE ; id 276 ? none
    dw $FEFE ; id 277 ? none
    dw $FEFE ; id 278 ? none
    dw $FEFE ; id 279 ? none
    dw $FEFE ; id 280 ? none
    dw $FE00 ; id 281 JewelBag family 0
    dw $FE01 ; id 282 EvilWand family 1
    dw $FE02 ; id 283 MadCandle family 2
    dw $FE03 ; id 284 CoilBird family 3
    dw $FE04 ; id 285 Facer family 4
    dw $FE05 ; id 286 SpikyBoy family 5
    dw $FE06 ; id 287 MadMirror family 6
    dw $FE07 ; id 288 RogueNite family 7
    dw $00DD ; id 289 Puppetor Gremlin
    dw $FE08 ; id 290 Goopi family 8
    dw $FE06 ; id 291 Voodoll family 6
    dw $0033 ; id 292 MetalDrak Andreal
    dw $FE0A ; id 293 Balzak family 10
    dw $00B5 ; id 294 SabreMan GiantWorm
    dw $0090 ; id 295 CurseLamp WingTree
    dw $FE09 ; id 296 Brushead family 9
    dw $000E ; id 297 Roboster SlimeBorg
    dw $0129 ; id 298 Roboster2 Roboster
    dw $0005 ; id 299 EvilPot Snaily
    dw $006B ; id 300 Gismo Wyvern
    dw $007D ; id 301 LavaMan ZapBird
    dw $00F7 ; id 302 IceMan Skullgon
    dw $0008 ; id 303 Mimic BoxSlime
    dw $0073 ; id 304 Exaucers Dracky
    dw $0122 ; id 305 MudDoll Goopi
    dw $0131 ; id 306 Golem MudDoll
    dw $0132 ; id 307 StoneMan Golem
    dw $011E ; id 308 BombCrag SpikyBoy
    dw $012D ; id 309 GoldGolem LavaMan
    dw $0017 ; id 310 DarkMate MetalKing
    dw $FE06 ; id 311 ProtoMech family 6
    dw $003E ; id 312 CloudKing SkyDragon
    dw $FEFE ; id 313 ? none
    dw $FEFE ; id 314 ? none
    dw $FEFE ; id 315 ? none
    dw $FE00 ; id 316 Petiteel family 0
    dw $FE01 ; id 317 Moray family 1
    dw $FE02 ; id 318 WalrusMan family 2
    dw $FE03 ; id 319 RayGigas family 3
    dw $FE04 ; id 320 Anemon family 4
    dw $FE05 ; id 321 Aquarella family 5
    dw $FE06 ; id 322 Merman family 6
    dw $FE08 ; id 323 Octokid family 8
    dw $FE07 ; id 324 PutreFish family 7
    dw $FE02 ; id 325 Octoreach family 2
    dw $FE08 ; id 326 Angleron family 8
    dw $00D9 ; id 327 FishRider SkulRider
    dw $FE01 ; id 328 RushFish family 1
    dw $FE05 ; id 329 Gamanian family 5
    dw $00C0 ; id 330 Clawster ArmyCrab
    dw $014A ; id 331 CancerMan Clawster
    dw $0119 ; id 332 RogueWave JewelBag
    dw $FE06 ; id 333 Scallopa family 6
    dw $FE01 ; id 334 SeaHorse family 1
    dw $0155 ; id 335 HoodSquid WhaleMage
    dw $0062 ; id 336 MerTiger MadCat
    dw $003D ; id 337 AxeShark BattleRex
    dw $0145 ; id 338 Octogon Octoreach
    dw $0152 ; id 339 KingSquid Octogon
    dw $0037 ; id 340 Digong Spikerous
    dw $00DC ; id 341 WhaleMage 1EyeClown
    dw $0038 ; id 342 Aquadon GreatDrak
    dw $00DF ; id 343 Octoraid Lionex
    dw $FE0A ; id 344 Grakos family 10
    dw $016D ; id 345 Poseidon Mudou
    dw $011E ; id 346 Pumpoise SpikyBoy
    dw $FE00 ; id 347 Starfish family 0
    dw $FEFE ; id 348 ? none
    dw $FEFE ; id 349 ? none
    dw $FEFE ; id 350 ? none
    dw $0033 ; id 351 DracoLord Andreal
    dw $0040 ; id 352 DracoLord Divinegon
    dw $0041 ; id 353 LordDraco Orligon
    dw $0017 ; id 354 Hargon MetalKing
    dw $00A2 ; id 355 Sidoh Rosevine
    dw $00EF ; id 356 Genosidoh Titanis
    dw $003C ; id 357 Baramos Orochi
    dw $0163 ; id 358 Zoma Sidoh
    dw $0169 ; id 359 AsuraZoma PsychoPiz
    dw $0040 ; id 360 Pizzaro Divinegon
    dw $016A ; id 361 PsychoPiz Esterk
    dw $0064 ; id 362 Esterk Gorago
    dw $0018 ; id 363 Mirudraas GoldSlime
    dw $0041 ; id 364 Mirudraas Orligon
    dw $0064 ; id 365 Mudou Gorago
    dw $0082 ; id 366 DeathMore Azurile
    dw $00EF ; id 367 DeathMore Titanis
    dw $0136 ; id 368 DeathMore DarkMate
    dw $0019 ; id 369 Darkdrium GranSlime
    dw $0110 ; id 370 Orgodemir Niterich
    dw $0161 ; id 371 Orgodemir LordDraco
    dw $FEFE ; id 372 Darck none
    dw $FEFE ; id 373 Tatsu none
    dw $FEFE ; id 374 Diago none
    dw $FEFE ; id 375 Samsi none
    dw $FEFE ; id 376 Bazoo none
    dw $FEFE ; id 377 ? none
    dw $FEFE ; id 378 ? none
    dw $FEFE ; id 379 ? none
    dw $FEFE ; id 380 Lamia none
    dw $FEFE ; id 381 Dimensaur none
    dw $FEFE ; id 382 Kagebou none
    dw $FEFE ; id 383 ? none

; E-0211 (C1: the partner of MonsterPedigreeTableA_Alt, a variant of MonsterPedigreeTableB; 384 words end at ScriptCommandF7_Run ($659F); no reader found).
; record: monster id, or $FExx = any monster of family xx ($FEFE = none)
MonsterPedigreeTableB_Alt::
Data_00C_629F:: ; address name
    dw $FEFE ; id 0 none
    dw $FE01 ; id 1 DrakSlime family 1
    dw $FE02 ; id 2 SpotSlime family 2
    dw $FE03 ; id 3 WingSlime family 3
    dw $FE04 ; id 4 TreeSlime family 4
    dw $FE05 ; id 5 Snaily family 5
    dw $FE06 ; id 6 SlimeNite family 6
    dw $FE07 ; id 7 Babble family 7
    dw $FE08 ; id 8 BoxSlime family 8
    dw $FE09 ; id 9 PearlGel family 9
    dw $FEFE ; id 10 Slime none
    dw $004A ; id 11 Healer PillowRat
    dw $0048 ; id 12 FangSlime Almiraj
    dw $0132 ; id 13 RockSlime Golem
    dw $002B ; id 14 SlimeBorg Swordgon
    dw $004D ; id 15 Slabbit Skullroo
    dw $FE0A ; id 16 KingSlime family 10
    dw $0124 ; id 17 Metaly MetalDrak
    dw $0011 ; id 18 Metabble Metaly
    dw $005C ; id 19 SpotKing Unicorn
    dw $FE02 ; id 20 TropicGel family 2
    dw $00DC ; id 21 MimeSlime 1EyeClown
    dw $FE07 ; id 22 HaloSlime family 7
    dw $0124 ; id 23 MetalKing MetalDrak
    dw $0017 ; id 24 GoldSlime MetalKing
    dw $0018 ; id 25 GranSlime GoldSlime
    dw $FEFE ; id 26 WonderEgg none
    dw $FEFE ; id 27 Butch none
    dw $FEFE ; id 28 ? none
    dw $FEFE ; id 29 ? none
    dw $FEFE ; id 30 ? none
    dw $FEFE ; id 31 ? none
    dw $FEFE ; id 32 ? none
    dw $FEFE ; id 33 ? none
    dw $FEFE ; id 34 ? none
    dw $FEFE ; id 35 ? none
    dw $FE00 ; id 36 DragonKid family 0
    dw $FE02 ; id 37 Tortragon family 2
    dw $FE03 ; id 38 Pteranod family 3
    dw $FE04 ; id 39 Gasgon family 4
    dw $FE05 ; id 40 FairyDrak family 5
    dw $FE06 ; id 41 LizardMan family 6
    dw $FE07 ; id 42 Poisongon family 7
    dw $FE08 ; id 43 Swordgon family 8
    dw $FE09 ; id 44 Drygon family 9
    dw $0024 ; id 45 Dragon DragonKid
    dw $006A ; id 46 MiniDrak Picky
    dw $FE02 ; id 47 MadDragon family 2
    dw $0003 ; id 48 Rayburn WingSlime
    dw $0123 ; id 49 Chamelgon Voodoll
    dw $00BA ; id 50 LizardFly GoHopper
    dw $0092 ; id 51 Andreal Gulpple
    dw $0007 ; id 52 KingCobra Babble
    dw $0078 ; id 53 Vampirus MadGoose
    dw $0073 ; id 54 SnakeBat Dracky
    dw $00C0 ; id 55 Spikerous ArmyCrab
    dw $002D ; id 56 GreatDrak Dragon
    dw $0075 ; id 57 Crestpent BigRoost
    dw $0039 ; id 58 WingSnake Crestpent
    dw $003A ; id 59 Coatol WingSnake
    dw $00D4 ; id 60 Orochi MedusaEye
    dw $00E8 ; id 61 BattleRex MadKnight
    dw $007C ; id 62 SkyDragon Phoenix
    dw $00DF ; id 63 Serpentia Lionex
    dw $003C ; id 64 Divinegon Orochi
    dw $0135 ; id 65 Orligon GoldGolem
    dw $00EA ; id 66 GigaDraco Gigantes
    dw $FEFE ; id 67 ? none
    dw $FEFE ; id 68 ? none
    dw $FEFE ; id 69 ? none
    dw $FEFE ; id 70 ? none
    dw $FE00 ; id 71 Tonguella family 0
    dw $FE01 ; id 72 Almiraj family 1
    dw $FE03 ; id 73 CatFly family 3
    dw $FE04 ; id 74 PillowRat family 4
    dw $FE05 ; id 75 Saccer family 5
    dw $FE01 ; id 76 GulpBeast family 1
    dw $FE07 ; id 77 Skullroo family 7
    dw $FE08 ; id 78 WindBeast family 8
    dw $FE09 ; id 79 Beavern family 9
    dw $FE01 ; id 80 Antbear family 1
    dw $0100 ; id 81 SuperTen Mudron
    dw $0025 ; id 82 IronTurt Tortragon
    dw $006E ; id 83 Mommonja DuckKite
    dw $0096 ; id 84 HammerMan Stubsuck
    dw $FE06 ; id 85 Grizzly family 6
    dw $002B ; id 86 Yeti Swordgon
    dw $00F8 ; id 87 ArrowDog PutrePup
    dw $00FD ; id 88 NoctoKing Shadow
    dw $00EC ; id 89 BeastNite EvilArmor
    dw $0126 ; id 90 MadGopher SabreMan
    dw $0032 ; id 91 FairyRat LizardFly
    dw $FE00 ; id 92 Unicorn family 0
    dw $0029 ; id 93 Goategon LizardMan
    dw $FE01 ; id 94 WildApe family 1
    dw $005E ; id 95 Trumpeter WildApe
    dw $005F ; id 96 KingLeo Trumpeter
    dw $FE0A ; id 97 DarkHorn family 10
    dw $002D ; id 98 MadCat Dragon
    dw $00D8 ; id 99 BigEye EyeBall
    dw $003C ; id 100 Gorago Orochi
    dw $0099 ; id 101 CatMage TreeBoy
    dw $0126 ; id 102 Dumbira SabreMan
    dw $FEFE ; id 103 ? none
    dw $FEFE ; id 104 ? none
    dw $FEFE ; id 105 ? none
    dw $FE00 ; id 106 Picky family 0
    dw $FE01 ; id 107 Wyvern family 1
    dw $FE02 ; id 108 BullBird family 2
    dw $FE04 ; id 109 Florajay family 4
    dw $FE05 ; id 110 DuckKite family 5
    dw $FE06 ; id 111 MadPecker family 6
    dw $FE07 ; id 112 MadRaven family 7
    dw $FE08 ; id 113 MistyWing family 8
    dw $FE09 ; id 114 AquaHawk family 9
    dw $FE00 ; id 115 Dracky family 0
    dw $011D ; id 116 KiteHawk Facer
    dw $FEFE ; id 117 BigRoost none
    dw $000D ; id 118 StubBird RockSlime
    dw $FE06 ; id 119 LandOwl family 6
    dw $FE07 ; id 120 MadGoose family 7
    dw $FE06 ; id 121 MadCondor family 6
    dw $00D7 ; id 122 Emyu DarkEye
    dw $0011 ; id 123 Blizzardy Metaly
    dw $0001 ; id 124 Phoenix DrakSlime
    dw $012C ; id 125 ZapBird Gismo
    dw $00DF ; id 126 Garudian Lionex
    dw $0030 ; id 127 WhipBird Rayburn
    dw $0128 ; id 128 FunkyBird Brushead
    dw $007C ; id 129 RainHawk Phoenix
    dw $FE0A ; id 130 Azurile family 10
    dw $0038 ; id 131 Shantak GreatDrak
    dw $FE02 ; id 132 CragDevil family 2
    dw $FEFE ; id 133 ? none
    dw $FEFE ; id 134 ? none
    dw $FEFE ; id 135 ? none
    dw $FEFE ; id 136 ? none
    dw $FEFE ; id 137 ? none
    dw $FEFE ; id 138 ? none
    dw $FEFE ; id 139 ? none
    dw $FEFE ; id 140 ? none
    dw $FE00 ; id 141 MadPlant family 0
    dw $FE01 ; id 142 FireWeed family 1
    dw $FE02 ; id 143 FloraMan family 2
    dw $FE03 ; id 144 WingTree family 3
    dw $FE05 ; id 145 CactiBall family 5
    dw $FE06 ; id 146 Gulpple family 6
    dw $FE07 ; id 147 Toadstool family 7
    dw $FE08 ; id 148 AmberWeed family 8
    dw $FE09 ; id 149 Slurperon family 9
    dw $FE02 ; id 150 Stubsuck family 2
    dw $00B2 ; id 151 Oniono Gophecada
    dw $FE02 ; id 152 DanceVegi family 2
    dw $00D3 ; id 153 TreeBoy Pixy
    dw $0092 ; id 154 Devipine Gulpple
    dw $0101 ; id 155 FaceTree NiteWhip
    dw $0080 ; id 156 HerbMan FunkyBird
    dw $004A ; id 157 BeanMan PillowRat
    dw $000D ; id 158 EvilSeed RockSlime
    dw $009E ; id 159 ManEater EvilSeed
    dw $009F ; id 160 Snapper ManEater
    dw $FE07 ; id 161 GhosTree family 7
    dw $FE0A ; id 162 Rosevine family 10
    dw $00EA ; id 163 Egdracil Gigantes
    dw $FEFE ; id 164 Warubou none
    dw $FEFE ; id 165 Watabou none
    dw $00B6 ; id 166 Eggplaton Lipsy
    dw $0006 ; id 167 FooHero SlimeNite
    dw $FEFE ; id 168 ? none
    dw $FEFE ; id 169 ? none
    dw $FEFE ; id 170 ? none
    dw $FEFE ; id 171 ? none
    dw $FEFE ; id 172 ? none
    dw $FEFE ; id 173 ? none
    dw $FEFE ; id 174 ? none
    dw $FEFE ; id 175 ? none
    dw $FE00 ; id 176 GiantSlug family 0
    dw $FE01 ; id 177 Catapila family 1
    dw $FE02 ; id 178 Gophecada family 2
    dw $FE03 ; id 179 Butterfly family 3
    dw $FE04 ; id 180 WeedBug family 4
    dw $FE06 ; id 181 GiantWorm family 6
    dw $FE07 ; id 182 Lipsy family 7
    dw $FE08 ; id 183 StagBug family 8
    dw $FE09 ; id 184 Pyuro family 9
    dw $FE00 ; id 185 ArmyAnt family 0
    dw $FEFE ; id 186 GoHopper none
    dw $FE04 ; id 187 TailEater family 4
    dw $FE08 ; id 188 ArmorPede family 8
    dw $0145 ; id 189 Eyeder Octoreach
    dw $FE06 ; id 190 GiantMoth family 6
    dw $00F6 ; id 191 Droll Spooky
    dw $00FB ; id 192 ArmyCrab DarkCrab
    dw $FE07 ; id 193 MadHornet family 7
    dw $FE07 ; id 194 Belzebub family 7
    dw $FE06 ; id 195 WarMantis family 6
    dw $00B7 ; id 196 HornBeet StagBug
    dw $00DC ; id 197 Sickler 1EyeClown
    dw $00C4 ; id 198 Armorpion HornBeet
    dw $FE0A ; id 199 Digster family 10
    dw $0108 ; id 200 Skularach WhiteKing
    dw $00B1 ; id 201 MultiEyes Catapila
    dw $FEFE ; id 202 ? none
    dw $FEFE ; id 203 ? none
    dw $FEFE ; id 204 ? none
    dw $FEFE ; id 205 ? none
    dw $FEFE ; id 206 ? none
    dw $FEFE ; id 207 ? none
    dw $FEFE ; id 208 ? none
    dw $FEFE ; id 209 ? none
    dw $FEFE ; id 210 ? none
    dw $FE00 ; id 211 Pixy family 0
    dw $FE01 ; id 212 MedusaEye family 1
    dw $FE01 ; id 213 AgDevil family 1
    dw $FE03 ; id 214 Demonite family 3
    dw $FE04 ; id 215 DarkEye family 4
    dw $FE05 ; id 216 EyeBall family 5
    dw $FE07 ; id 217 SkulRider family 7
    dw $FE08 ; id 218 EvilBeast family 8
    dw $FE09 ; id 219 Bubblemon family 9
    dw $FE00 ; id 220 1EyeClown family 0
    dw $FE02 ; id 221 Gremlin family 2
    dw $FE01 ; id 222 ArcDemon family 1
    dw $0029 ; id 223 Lionex LizardMan
    dw $FE02 ; id 224 GoatHorn family 2
    dw $009D ; id 225 Orc BeanMan
    dw $0054 ; id 226 Ogre HammerMan
    dw $00D6 ; id 227 GateGuard Demonite
    dw $00DC ; id 228 ChopClown 1EyeClown
    dw $FE02 ; id 229 BossTroll family 2
    dw $0059 ; id 230 Grendal BeastNite
    dw $00E6 ; id 231 Akubar Grendal
    dw $0120 ; id 232 MadKnight RogueNite
    dw $012E ; id 233 EvilWell IceMan
    dw $FE07 ; id 234 Gigantes family 7
    dw $FE02 ; id 235 Centasaur family 2
    dw $00BC ; id 236 EvilArmor ArmorPede
    dw $0081 ; id 237 Jamirus RainHawk
    dw $003F ; id 238 Durran Serpentia
    dw $0061 ; id 239 Titanis DarkHorn
    dw $FE0A ; id 240 LampGenie family 10
    dw $FEFE ; id 241 ? none
    dw $FEFE ; id 242 ? none
    dw $FEFE ; id 243 ? none
    dw $FEFE ; id 244 ? none
    dw $FEFE ; id 245 ? none
    dw $FE00 ; id 246 Spooky family 0
    dw $FE01 ; id 247 Skullgon family 1
    dw $FE02 ; id 248 PutrePup family 2
    dw $FE03 ; id 249 RotRaven family 3
    dw $FE04 ; id 250 Mummy family 4
    dw $FE05 ; id 251 DarkCrab family 5
    dw $FE06 ; id 252 DeadNite family 6
    dw $FE08 ; id 253 Shadow family 8
    dw $FE09 ; id 254 Skulpent family 9
    dw $FE02 ; id 255 Hork family 2
    dw $00BF ; id 256 Mudron Droll
    dw $0071 ; id 257 NiteWhip MistyWing
    dw $004E ; id 258 WindMerge WindBeast
    dw $FE06 ; id 259 Reaper family 6
    dw $00FF ; id 260 Inverzon Hork
    dw $FE02 ; id 261 FoxFire family 2
    dw $FE09 ; id 262 CaptDead family 9
    dw $00FC ; id 263 DeadNoble DeadNite
    dw $0013 ; id 264 WhiteKing SpotKing
    dw $008F ; id 265 BoneSlave FloraMan
    dw $0109 ; id 266 Skeletor BoneSlave
    dw $010A ; id 267 Servant Skeletor
    dw $015F ; id 268 Lazamanus DracoLord
    dw $FEFE ; id 269 Copycat none
    dw $FE01 ; id 270 MadSpirit family 1
    dw $0027 ; id 271 PomPomBom Gasgon
    dw $012A ; id 272 Niterich Roboster2
    dw $FEFE ; id 273 ? none
    dw $FEFE ; id 274 ? none
    dw $FEFE ; id 275 ? none
    dw $FEFE ; id 276 ? none
    dw $FEFE ; id 277 ? none
    dw $FEFE ; id 278 ? none
    dw $FEFE ; id 279 ? none
    dw $FEFE ; id 280 ? none
    dw $FE00 ; id 281 JewelBag family 0
    dw $FE01 ; id 282 EvilWand family 1
    dw $FE02 ; id 283 MadCandle family 2
    dw $FE03 ; id 284 CoilBird family 3
    dw $FE04 ; id 285 Facer family 4
    dw $FE05 ; id 286 SpikyBoy family 5
    dw $FE06 ; id 287 MadMirror family 6
    dw $FE07 ; id 288 RogueNite family 7
    dw $00DD ; id 289 Puppetor Gremlin
    dw $FE08 ; id 290 Goopi family 8
    dw $FE06 ; id 291 Voodoll family 6
    dw $0033 ; id 292 MetalDrak Andreal
    dw $FE0A ; id 293 Balzak family 10
    dw $00B5 ; id 294 SabreMan GiantWorm
    dw $0090 ; id 295 CurseLamp WingTree
    dw $FE09 ; id 296 Brushead family 9
    dw $000E ; id 297 Roboster SlimeBorg
    dw $0129 ; id 298 Roboster2 Roboster
    dw $0005 ; id 299 EvilPot Snaily
    dw $006B ; id 300 Gismo Wyvern
    dw $007D ; id 301 LavaMan ZapBird
    dw $00F7 ; id 302 IceMan Skullgon
    dw $0008 ; id 303 Mimic BoxSlime
    dw $0073 ; id 304 Exaucers Dracky
    dw $0122 ; id 305 MudDoll Goopi
    dw $0131 ; id 306 Golem MudDoll
    dw $0132 ; id 307 StoneMan Golem
    dw $011E ; id 308 BombCrag SpikyBoy
    dw $012D ; id 309 GoldGolem LavaMan
    dw $0017 ; id 310 DarkMate MetalKing
    dw $FE06 ; id 311 ProtoMech family 6
    dw $003E ; id 312 CloudKing SkyDragon
    dw $FEFE ; id 313 ? none
    dw $FEFE ; id 314 ? none
    dw $FEFE ; id 315 ? none
    dw $FE00 ; id 316 Petiteel family 0
    dw $FE01 ; id 317 Moray family 1
    dw $FE02 ; id 318 WalrusMan family 2
    dw $FE03 ; id 319 RayGigas family 3
    dw $FE04 ; id 320 Anemon family 4
    dw $FE05 ; id 321 Aquarella family 5
    dw $FE06 ; id 322 Merman family 6
    dw $FE08 ; id 323 Octokid family 8
    dw $FE07 ; id 324 PutreFish family 7
    dw $FE02 ; id 325 Octoreach family 2
    dw $FE08 ; id 326 Angleron family 8
    dw $00D9 ; id 327 FishRider SkulRider
    dw $FE01 ; id 328 RushFish family 1
    dw $FE05 ; id 329 Gamanian family 5
    dw $00C0 ; id 330 Clawster ArmyCrab
    dw $014A ; id 331 CancerMan Clawster
    dw $0119 ; id 332 RogueWave JewelBag
    dw $FE06 ; id 333 Scallopa family 6
    dw $FE01 ; id 334 SeaHorse family 1
    dw $0155 ; id 335 HoodSquid WhaleMage
    dw $0062 ; id 336 MerTiger MadCat
    dw $003D ; id 337 AxeShark BattleRex
    dw $0145 ; id 338 Octogon Octoreach
    dw $0152 ; id 339 KingSquid Octogon
    dw $0037 ; id 340 Digong Spikerous
    dw $00DC ; id 341 WhaleMage 1EyeClown
    dw $0038 ; id 342 Aquadon GreatDrak
    dw $00DF ; id 343 Octoraid Lionex
    dw $FE0A ; id 344 Grakos family 10
    dw $016D ; id 345 Poseidon Mudou
    dw $011E ; id 346 Pumpoise SpikyBoy
    dw $FE00 ; id 347 Starfish family 0
    dw $FEFE ; id 348 ? none
    dw $FEFE ; id 349 ? none
    dw $FEFE ; id 350 ? none
    dw $0033 ; id 351 DracoLord Andreal
    dw $0040 ; id 352 DracoLord Divinegon
    dw $0041 ; id 353 LordDraco Orligon
    dw $0017 ; id 354 Hargon MetalKing
    dw $00A2 ; id 355 Sidoh Rosevine
    dw $00EF ; id 356 Genosidoh Titanis
    dw $003C ; id 357 Baramos Orochi
    dw $0163 ; id 358 Zoma Sidoh
    dw $0169 ; id 359 AsuraZoma PsychoPiz
    dw $0040 ; id 360 Pizzaro Divinegon
    dw $016A ; id 361 PsychoPiz Esterk
    dw $0064 ; id 362 Esterk Gorago
    dw $0018 ; id 363 Mirudraas GoldSlime
    dw $0041 ; id 364 Mirudraas Orligon
    dw $0064 ; id 365 Mudou Gorago
    dw $0082 ; id 366 DeathMore Azurile
    dw $00EF ; id 367 DeathMore Titanis
    dw $0136 ; id 368 DeathMore DarkMate
    dw $0019 ; id 369 Darkdrium GranSlime
    dw $0110 ; id 370 Orgodemir Niterich
    dw $0161 ; id 371 Orgodemir LordDraco
    dw $FEFE ; id 372 Darck none
    dw $FEFE ; id 373 Tatsu none
    dw $FEFE ; id 374 Diago none
    dw $FEFE ; id 375 Samsi none
    dw $FEFE ; id 376 Bazoo none
    dw $FEFE ; id 377 ? none
    dw $FEFE ; id 378 ? none
    dw $FEFE ; id 379 ? none
    dw $FEFE ; id 380 Lamia none
    dw $FEFE ; id 381 Dimensaur none
    dw $FEFE ; id 382 Kagebou none
    dw $FEFE ; id 383 ? none

; implements script command type F7; reached through ScriptCommandF7 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommandF7)
; reads: wScreenState
ScriptCommandF7_Run::
Func_00C_659F:: ; address name
    ld a, [wScreenState]
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
; reads: wAreaGraphicsIndex, hTemp0
; writes: wArg1, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wAreaGraphicsIndex
ScriptCommandF7_Run_Case27::
Jump_00C_65F3:: ; address name
    ld a, [wAreaGraphicsIndex]
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
    ld a, [wAreaGraphicsIndex]
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
    ld [wArg1], a
    call ScriptCommandF7_Run_Case27_Sub02
    jp Jump_00C_6663

Jump_00C_663F::
    farcall GenerateNewKeyEntry
    ldh a, [hTemp0]
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
    ld [wAreaGraphicsIndex], a
    ret

; entry 38 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wTwoChoiceCursor, wScreenState
; writes: wScreenState, wScriptCommandType, wScriptStartRequest, wTwoChoiceCursor, wArg1, wArg2
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
    ld a, [wScreenState]
    dec a
    ld [wScreenState], a
    ld b, $00
    ld c, $05
    ld hl, $027A
    ld de, $00AE
    xor a, a
    ld [wArg1], a
    ld a, $06
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_0C
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
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 0 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wArenaRank, wScreenTableIndex, wScreenState
; writes: wMessageMode, wScreenState, wTwoChoiceCursor, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScriptCommandType, ...
; points at: wScreenState, wScreenTileBuffer, wScreenAttrBuffer
ScriptCommandF7_Run_Case00::
Jump_00C_66D7:: ; address name
    ld hl, wScreenState
    ld b, $6F

Jump_00C_66DC::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_00C_66DC
    ld hl, wWindowTileBuffer + $64
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank0C
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_00C_66FF
    ld hl, wWindowAttrBuffer + $64
    ld de, wScreenAttrBuffer
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank0C

Jump_00C_66FF::
    ld a, $0A
    ld [wMessageMode], a
    ld a, [wArenaRank]
    cp a, $05
    jr nc, Jump_00C_6770
    and a, a
    jr nz, Jump_00C_673F
    ld a, [wScreenTableIndex]
    cp a, $1F
    jr z, Jump_00C_6717
    ld a, $1D

Jump_00C_6717::
    ld [wScreenState], a
    ld a, $02
    ld [wTwoChoiceCursor], a
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
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
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0A01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    farcall ShowString_Bank33_649E
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
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
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0A01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    farcall ShowString_Bank33_649E
    ld hl, vTiles1 + $700
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, $18
    ld [wStringIndex], a
    farcall ShowString_Bank33_649E
    ld a, $0B
    ld [wScreenState], a

Jump_00C_67B5::
    ld a, [wScreenTableIndex]
    cp a, $08
    jr z, Jump_00C_67C2
    cp a, $1B
    jr z, Jump_00C_67C2
    jr Jump_00C_67C5

Jump_00C_67C2::
    ld [wScreenState], a

Jump_00C_67C5::
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 1 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wScreenState
ScriptCommandF7_Run_Case01::
Jump_00C_67E5:: ; address name
    ld de, TileRect_0C_762E
    ld hl, wWindowTileBuffer + $B4
    ld bc, $1109
    call CopyRectTo20ByteRows_Bank0C
    call ScriptCommandF7_Run_Case01_Sub01
    call ScriptCommandF7_Run_Shared02
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; entry 2 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wArenaRank, wGridCursorX, wScreenState
; writes: wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wTextBuf0, wScreenState, wGridCursorX
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
    ld a, [wGridCursorX]
    and a, a
    jr nz, Jump_00C_6832
    ld a, $03
    jr Jump_00C_6833

Jump_00C_6832::
    dec a

Jump_00C_6833::
    ld [wGridCursorX], a
    call ScriptCommandF7_Run_Case02_Sub02
    ld a, $69
    call QueueSoundEffect
    ret

Jump_00C_683F::
    call ScriptCommandF7_Run_Case02_Sub03
    ld a, [wGridCursorX]
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
    ld a, [wArenaRank]
    dec a
    ld b, a
    ld a, [wGridCursorX]
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
    ld a, [wGridCursorX]
    ld hl, Data_00C_68D1
    add_a_to_hl
    ld a, [hl]
    ld [wTextBuf0], a
    ld a, $F0
    ld [wTextBuf0 + $1], a
    ld a, [wGridCursorX]
    ld hl, Data_00C_784F
    ld b, $BC
    call StoreBAtWordTableEntry_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a, a
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; address loaded by ScriptCommandF7_Run_Case02
Data_00C_68D1:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0C, $0B, $0A, $1C

; only called from ScriptCommandF7_Run_Case02 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandF7_Run_Case02)
; reads: wJoypadRepeatTimer, wGridCursorY, wGridCursorX
; writes: wGridCursorY
ScriptCommandF7_Run_Case02_Sub01::
Func_00C_68D5:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, ScriptCommandF7_Run_Case02_Sub02
    ld a, [wGridCursorY]
    inc a
    ld [wGridCursorY], a
    cp a, $10
    jr c, ScriptCommandF7_Run_Case02_Sub02
    cp a, $18
    jr c, ScriptCommandF7_Run_Case02_Sub03
    xor a, a
    ld [wGridCursorY], a

; only called from ScriptCommandF7_Run_Case02 (E-0047)
; 2 call sites from 1 routine (e.g. ScriptCommandF7_Run_Case02)
; reads: wGridCursorX
ScriptCommandF7_Run_Case02_Sub02::
Func_00C_68EF:: ; address name
    ld b, $BB
    jr Jump_00C_68F9

; only called from ScriptCommandF7_Run_Case02 (E-0047)
; 2 call sites from 1 routine (e.g. ScriptCommandF7_Run_Case02)
; reads: wGridCursorX
ScriptCommandF7_Run_Case02_Sub03::
Func_00C_68F3:: ; address name
    ld b, $C3
    jr Jump_00C_68F9
    db $06, $BC

Jump_00C_68F9::
    ld a, [wGridCursorX]
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

; address loaded by ScriptCommandF7_Run_Case02_Sub03
Data_00C_691A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A2, $00, $E2, $00, $22, $01, $62, $01

; plays sound $6C, copies the 6 x 5 box Data_00C_7831 to wC412, draws it at the scroll position + $1CC, wD780 += 1 and wTwoChoiceCursor = 0 (E-0122)
; 1 call site from 1 routine (e.g. ScriptCommandF7_Run_Case0B)
; reads: wScreenState
; writes: wScreenState, wTwoChoiceCursor
ShowTwoChoiceBoxAtWC412::
Func_00C_6922:: ; address name
    ld a, $6C
    call QueueSoundEffect
    ld de, TileRect_0C_7831
    ld hl, wWindowTileBuffer + $112
    ld bc, $0605
    call CopyRectTo20ByteRows_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ret

; entry 4 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wTwoChoiceCursor, wGridCursorX, wArg1, wScreenState
; writes: wArg3, wArg2, wArg1, wTwoChoiceCursor, wScreenState, wScriptCommandType, wScriptStartRequest
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
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
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
    ld a, [wGridCursorX]
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
    ld [wArg3], a
    ld a, h
    ld [wArg2], a
    ld a, l
    ld [wArg1], a
    farcall IsAmountInArg1AboveGold
    ld a, [wArg1]
    cp a, $FF
    jr nz, Jump_00C_69BF
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_00C_69BF::
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenState]
    inc a
    inc a
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; only called from routines of ScriptCommandF7_Run (E-0098)
; 3 call sites from 3 routines (e.g. ScriptCommandF7_Run_Case0C, ScriptCommandF7_Run_Case05, ScriptCommandF7_Run_Case04)
; writes: wArg1, wArg2
ScriptCommandF7_Run_Shared01::
Func_00C_69D5:: ; address name
    ld b, $00
    ld c, $05
    ld hl, $027A
    ld de, $00AE
    xor a, a
    ld [wArg1], a
    ld a, $06
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_0C
    ld de, TileRect_0C_76C7
    ld hl, wWindowTileBuffer + $112
    ld bc, $0305
    call CopyRectTo20ByteRows_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    ret

; entry 5 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenState
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
    ld [wScreenState], a
    ret

; entry 6 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wScreenState
ScriptCommandF7_Run_Case06::
Jump_00C_6A21:: ; address name
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; entry 7 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wGridCursorX, wScreenState, wScreenCountPlusOne
; writes: wArg3, wArg2, wArg1, wScreenState, wScreenTableIndex, wRecordCapacity, wAreaGraphicsIndex
ScriptCommandF7_Run_Case07::
Jump_00C_6A29:: ; address name
    call ScriptCommandF7_Run_Shared04
    ld a, [wGridCursorX]
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
    ld [wArg3], a
    ld a, h
    ld [wArg2], a
    ld a, l
    ld [wArg1], a
    farcall SubtractArg1AmountFromGold
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ld [wScreenTableIndex], a
    ld a, [wScreenCountPlusOne]
    ld [wRecordCapacity], a
    ld a, [wGridCursorX]
    ld [wAreaGraphicsIndex], a
    call RedrawFullScreenBoxes_0C
    ret

; entry 8 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleScene, wRecordCapacity, wScreenState, wArenaRank
; writes: wScriptCommandType, wScriptStartRequest, wScreenState, wArenaRank, wTwoChoiceCursor, wAreaGraphicsIndex, wScreenTableIndex, wRecordCapacity
ScriptCommandF7_Run_Case08::
Jump_00C_6A6A:: ; address name
    ld a, [wBattleScene]
    and a, a
    jr nz, Jump_00C_6AA1
    ld a, [wRecordCapacity]
    cp a, $02
    jr nc, Jump_00C_6A8B
    call SetupScreenCountPlusOneFromRecordCapacity
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

Jump_00C_6A8B::
    ld a, [wArenaRank]
    inc a
    ld [wArenaRank], a
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
    ld [wAreaGraphicsIndex], a
    ld [wScreenTableIndex], a
    ld [wRecordCapacity], a
    ld a, [wArenaRank]
    and a, a
    ret z
    ld a, $22
    ld [wScreenState], a
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
; reads: wMenuInputResult, wTwoChoiceCursor, wScreenState
; writes: wTwoChoiceCursor, wScreenState, wScriptCommandType, wScriptStartRequest
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
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 13 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wScreenState
ScriptCommandF7_Run_Case0D::
Jump_00C_6B10:: ; address name
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; entry 14 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wScreenState, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
ScriptCommandF7_Run_Case0E::
Jump_00C_6B18:: ; address name
    ld a, [wScreenState]
    inc a
    inc a
    ld [wScreenState], a
    xor a, a
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 15 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wArg1, wArg2, wScreenState, wScriptCommandType, wScriptStartRequest
ScriptCommandF7_Run_Case0F::
Jump_00C_6B2E:: ; address name
    ld b, $00
    ld c, $03
    ld hl, $01E0
    ld de, $0014
    xor a, a
    ld [wArg1], a
    ld a, $08
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_0C
    ld b, $00
    ld c, $07
    ld hl, $0244
    ld de, $0078
    xor a, a
    ld [wArg1], a
    ld a, $0D
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_0C
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    ld a, [wScreenState]
    sub a, $04
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 16 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wScreenState, wScriptCommandType, wScriptStartRequest
ScriptCommandF7_Run_Case10::
Jump_00C_6B78:: ; address name
    ld de, TileRect_0C_76D6
    ld hl, wWindowTileBuffer + $B4
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
    ld a, [wScreenState]
    inc a
    inc a
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 17 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wScreenState
ScriptCommandF7_Run_Case11::
Jump_00C_6BB4:: ; address name
    ld de, TileRect_0C_76D6
    ld hl, wWindowTileBuffer + $B4
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
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; entry 18 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wGridCursorX, wScreenState
; writes: wTextBuf0, wScreenState, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wGridCursorX
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
    ld a, [wGridCursorX]
    and a, a
    jr nz, Jump_00C_6C0A
    ld a, $03
    jr Jump_00C_6C0B

Jump_00C_6C0A::
    dec a

Jump_00C_6C0B::
    ld [wGridCursorX], a
    call ScriptCommandF7_Run_Case12_Sub02
    ld a, $69
    call QueueSoundEffect
    ret

Jump_00C_6C17::
    call ScriptCommandF7_Run_Case12_Sub03
    ld a, [wGridCursorX]
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
    ld a, [wGridCursorX]
    ld hl, Data_00C_6C7F
    add_a_to_hl
    ld a, [hl]
    ld [wTextBuf0], a
    ld a, $F0
    ld [wTextBuf0 + $1], a
    ld a, [wGridCursorX]
    ld hl, Data_00C_7857
    ld b, $BC
    call StoreBAtWordTableEntry_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    ld a, [wScreenState]
    inc a
    inc a
    ld [wScreenState], a
    xor a, a
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; address loaded by ScriptCommandF7_Run_Case12
Data_00C_6C7F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0C, $0B, $0A, $1C

; only called from ScriptCommandF7_Run_Case12 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandF7_Run_Case12)
; reads: wJoypadRepeatTimer, wGridCursorY, wGridCursorX
; writes: wGridCursorY
ScriptCommandF7_Run_Case12_Sub01::
Func_00C_6C83:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, ScriptCommandF7_Run_Case12_Sub02
    ld a, [wGridCursorY]
    inc a
    ld [wGridCursorY], a
    cp a, $10
    jr c, ScriptCommandF7_Run_Case12_Sub02
    cp a, $18
    jr c, ScriptCommandF7_Run_Case12_Sub03
    xor a, a
    ld [wGridCursorY], a

; only called from ScriptCommandF7_Run_Case12 (E-0047)
; 2 call sites from 1 routine (e.g. ScriptCommandF7_Run_Case12)
; reads: wGridCursorX
ScriptCommandF7_Run_Case12_Sub02::
Func_00C_6C9D:: ; address name
    ld b, $BB
    jr Jump_00C_6CA7

; only called from ScriptCommandF7_Run_Case12 (E-0047)
; 2 call sites from 1 routine (e.g. ScriptCommandF7_Run_Case12)
; reads: wGridCursorX
ScriptCommandF7_Run_Case12_Sub03::
Func_00C_6CA1:: ; address name
    ld b, $C3
    jr Jump_00C_6CA7
    db $06, $BC

Jump_00C_6CA7::
    ld a, [wGridCursorX]
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

; address loaded by ScriptCommandF7_Run_Case12_Sub03
Data_00C_6CC8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A1, $00, $E1, $00, $21, $01, $61, $01

; entry 19 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wArg1, wArg2, wScreenState, wGrid2CursorX, wScriptCommandType, wScriptStartRequest
ScriptCommandF7_Run_Case13::
Jump_00C_6CD0:: ; address name
    ld b, $00
    ld c, $05
    ld hl, $01E0
    ld de, $0014
    xor a, a
    ld [wArg1], a
    ld a, $08
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_0C
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    ld a, $0D
    ld [wScreenState], a
    xor a, a
    ld [wGrid2CursorX], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 20 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wScreenState
ScriptCommandF7_Run_Case14::
Jump_00C_6D05:: ; address name
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; entry 21 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wGridCursorX, wScreenState
; writes: wScreenArea, wGrid2CursorX, wArenaByte86, wArenaByte87, wScreenState, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
ScriptCommandF7_Run_Case15::
Jump_00C_6D0D:: ; address name
    ld a, [wGridCursorX]
    inc a
    inc a
    ld [wScreenArea], a
    ld a, $02
    ld [wGrid2CursorX], a
    ld a, [wGridCursorX]
    add a, a
    ld hl, Data_00C_6D44
    add_a_to_hl
    ld a, [hl]
    ld [wArenaByte86], a
    inc hl
    ld a, [hl]
    ld [wArenaByte87], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a, a
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; address loaded by ScriptCommandF7_Run_Case15
Data_00C_6D44:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $E8, $03, $D0, $07, $B8, $0B, $88, $13

; entry 23 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wTwoChoiceCursor, wArenaByte86, wArenaByte87, wArg1, wScreenState
; writes: wArg1, wArg2, wArg3, wTwoChoiceCursor, wScreenState, wScriptCommandType, wScriptStartRequest
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
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_00C_6D76::
    ld a, [wTwoChoiceCursor]
    and a, a
    jr nz, Jump_00C_6D60
    ld a, [wArenaByte86]
    ld [wArg1], a
    ld a, [wArenaByte87]
    ld [wArg2], a
    xor a, a
    ld [wArg3], a
    farcall IsAmountInArg1AboveGold
    ld a, [wArg1]
    cp a, $FF
    jr nz, Jump_00C_6DAF
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_00C_6DAF::
    ld a, [wScreenState]
    inc a
    inc a
    ld [wScreenState], a
    xor a, a
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 24 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wArg1, wArg2, wScreenState, wGrid2CursorX, wScreenArea, wScriptCommandType, wScriptStartRequest
ScriptCommandF7_Run_Case18::
Jump_00C_6DC5:: ; address name
    ld b, $00
    ld c, $05
    ld hl, $027A
    ld de, $00AE
    xor a, a
    ld [wArg1], a
    ld a, $06
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_0C
    ld de, TileRect_0C_776F
    ld hl, wWindowTileBuffer + $112
    ld bc, $0305
    call CopyRectTo20ByteRows_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    call ScriptCommandF7_Run_Shared05
    ld a, $11
    ld [wScreenState], a
    xor a, a
    ld [wGrid2CursorX], a
    ld [wScreenArea], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 25 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wArenaByte87, wArenaByte86, wScreenState
; writes: wArg3, wArg2, wArg1, wScreenState, wScriptCommandType, wScriptStartRequest
ScriptCommandF7_Run_Case19::
Jump_00C_6E0C:: ; address name
    xor a, a
    ld [wArg3], a
    ld a, [wArenaByte87]
    ld [wArg2], a
    ld a, [wArenaByte86]
    ld [wArg1], a
    farcall SubtractArg1AmountFromGold
    call ScriptCommandF7_Run_Shared02
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 26 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenArea, wScreenState
; writes: wAreaGraphicsIndex, wScreenState, wScreenTableIndex
ScriptCommandF7_Run_Case1A::
Jump_00C_6E42:: ; address name
    ld a, [wScreenArea]
    ld [wAreaGraphicsIndex], a
    call ScriptCommandF7_Run_Case1A_Sub01
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ld [wScreenTableIndex], a
    call RedrawFullScreenBoxes_0C
    ret

; entry 27 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleScene, wArenaRound, wScreenState
; writes: wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wScreenTableIndex, wScreenState, wRecordCapacity, wArg3, wArg2, ...
ScriptCommandF7_Run_Case1B::
Jump_00C_6E59:: ; address name
    ld a, [wBattleScene]
    and a, a
    jr nz, Jump_00C_6EA2
    ld a, [wArenaRound]
    cp a, $02
    jr nc, Jump_00C_6E85
    call IncArenaRoundAndCopyAreaGraphicsIndexToScreenArea
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ld a, [wScreenState]
    ld [wScreenTableIndex], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
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
    ld [wScreenTableIndex], a
    ld [wRecordCapacity], a
    ld a, $23
    ld [wScreenState], a
    ret

Jump_00C_6EA2::
    xor a, a
    ld [wArg3], a
    ld [wArg2], a
    ld [wArg1], a
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
; reads: wScreenState, wScreenCountPlusOne, wGridCursorX
; writes: wScreenState, wScreenTableIndex, wRecordCapacity, wAreaGraphicsIndex
ScriptCommandF7_Run_Case1E::
Jump_00C_6EB4:: ; address name
    call ScriptCommandF7_Run_Shared03
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ld [wScreenTableIndex], a
    ld a, [wScreenCountPlusOne]
    xor a, a
    ld [wRecordCapacity], a
    ld a, [wGridCursorX]
    xor a, a
    ld [wAreaGraphicsIndex], a
    call RedrawFullScreenBoxes_0C
    ret

; entry 33 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommandF7_Run_Case21::
Jump_00C_6ED3:: ; address name
    call ScriptCommandF7_Run_Shared03
    ret

; entry 34 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleScene, wArenaRank, wScreenState
; writes: wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wScreenState
ScriptCommandF7_Run_Case22::
Jump_00C_6ED7:: ; address name
    ld a, [wBattleScene]
    and a, a
    jr nz, Jump_00C_6F02
    ld a, [wArenaRank]
    dec a
    dec a
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ld a, [wArenaRank]
    cp a, $01
    jr c, Jump_00C_6F01
    cp a, $05
    jr nc, Jump_00C_6F01
    ld a, [wScreenState]
    inc a
    inc a
    ld [wScreenState], a

Jump_00C_6F01::
    ret

Jump_00C_6F02::
    ld a, [wArenaRank]
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
; reads: wBattleScene, wScreenState
; writes: wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wScreenState
ScriptCommandF7_Run_Case23::
Jump_00C_6F26:: ; address name
    ld a, [wBattleScene]
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
    ld a, [wScreenState]
    inc a
    inc a
    ld [wScreenState], a
    ret

Jump_00C_6F49::
    farcall WritePlayerNameWithFlag0SuffixToTextBuf0
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 36 of the `rst $00` table in ScriptCommandF7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wArenaRank, wGameFlags836, hTemp0
; writes: hTemp1, wGameFlags836, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wTalkEventByte92
; points at: wTextBuf0, wPlayerName
ScriptCommandF7_Run_Case24::
Jump_00C_6F5E:: ; address name
    ld a, [wArenaRank]
    cp a, $01
    jr nz, Jump_00C_6F8B
    ld de, $0188
    call SetFlagBit
    farcall CountKeysOrFull
    ld a, $03
    ldh [hTemp1], a
    farcall WriteKeyEntryTemp0
    ld a, [wGameFlags836]
    set 7, a
    ld [wGameFlags836], a
    ld de, $012F
    call SetFlagBit
    jr Jump_00C_6F99

Jump_00C_6F8B::
    farcall GenerateNewKeyEntry
    ldh a, [hTemp0]
    ld [wTalkEventByte92], a
    and a, a
    jr z, Jump_00C_6FBC

Jump_00C_6F99::
    ld hl, wTextBuf0
    ld de, wPlayerName
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

; runs Func_00C_72CC for the bottom box, copies $64 bytes of tiles (and CGB attributes) and draws the two screen-buffer rectangles at scroll + $1CC and + $1A0 (E-0125)
; 4 call sites from 4 routines (e.g. ScriptCommandF7_Run_Case1E, ScriptCommandF7_Run_Case1A, ScriptCommandF7_Run_Case07, ScriptCommandF4_Run_Case04_Case18)
; reads: wIsCGB
; writes: wArg1, wArg2
; points at: wWindowTileBuffer, wWindowAttrBuffer
RedrawFullScreenBoxes_0C::
Func_00C_6FCB:: ; address name
    ld b, $00
    ld c, $0D
    ld hl, $01CC
    ld de, $0000
    xor a, a
    ld [wArg1], a
    ld a, $14
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_0C
    ld hl, wWindowTileBuffer
    ld de, wScreenTileBuffer + $104
    ld bc, $0064
    call CopyBytesDEToHL_Bank0C
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_00C_6FFF
    ld hl, wWindowAttrBuffer
    ld de, wScreenAttrBuffer + $104
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
; reads: wAreaGraphicsIndex
; writes: wTextBuf0
ScriptCommandF7_Run_Case23_Sub01::
Func_00C_701C:: ; address name
    farcall WritePlayerNameWithFlag0SuffixToTextBuf0
    ld a, [wAreaGraphicsIndex]
    ld hl, Data_00C_7037
    add_a_to_hl
    ld a, [hl]
    ld [wTextBuf0], a
    ld a, $F0
    ld [wTextBuf0 + $1], a
    ret

; address loaded by ScriptCommandF7_Run_Case23_Sub01
Data_00C_7037:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0C, $0C, $0C, $0B, $0A, $1C

; wD588 += 1 and wD78C = wD7FC (E-0122)
; 3 call sites from 3 routines (e.g. ScriptCommandF7_Run_Case1B, ScriptCommand96_Run_Case0D, ScriptCommand96_Run_Case05)
; reads: wArenaRound, wAreaGraphicsIndex
; writes: wArenaRound, wScreenArea
IncArenaRoundAndCopyAreaGraphicsIndexToScreenArea::
Func_00C_703D:: ; address name
    ld a, [wArenaRound]
    inc a
    ld [wArenaRound], a
    ld a, [wAreaGraphicsIndex]
    ld [wScreenArea], a
    ret

; wD78E = wD7FF + 1 (and stored back to wD7FF), wD786 = wD7FC, wTwoChoiceCursor = 1 (E-0122)
; 5 call sites from 3 routines (e.g. ScriptCommandF7_Run_Case08, ScriptCommand95_Run_Case0E, ScriptCommand95_Run_Case06)
; reads: wRecordCapacity, wAreaGraphicsIndex, wScreenCountPlusOne
; writes: wScreenCountPlusOne, wGridCursorX, wTwoChoiceCursor, wRecordCapacity
SetupScreenCountPlusOneFromRecordCapacity::
Func_00C_704B:: ; address name
    ld a, [wRecordCapacity]
    inc a
    ld [wScreenCountPlusOne], a
    ld a, [wAreaGraphicsIndex]
    ld [wGridCursorX], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wScreenCountPlusOne]
    ld [wRecordCapacity], a
    ret

; only called from ScriptCommandF7_Run_Case01 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandF7_Run_Case01)
; reads: wArenaRank
ScriptCommandF7_Run_Case01_Sub01::
Func_00C_7064:: ; address name
    ld hl, wWindowTileBuffer + $C9
    ld a, [wArenaRank]
    cp a, $02
    jr c, Jump_00C_7071
    ld a, $AD
    ld [hl], a

Jump_00C_7071::
    ld a, [wArenaRank]
    cp a, $03
    jr c, Jump_00C_707E
    ld hl, wWindowTileBuffer + $F1
    ld a, $AD
    ld [hl], a

Jump_00C_707E::
    ld a, [wArenaRank]
    cp a, $04
    jr c, Jump_00C_708B
    ld hl, wWindowTileBuffer + $119
    ld a, $AD
    ld [hl], a

Jump_00C_708B::
    ld a, [wArenaRank]
    cp a, $05
    ret c
    ld hl, wWindowTileBuffer + $141
    ld a, $AD
    ld [hl], a
    ret

; only called from routines of ScriptCommandF7_Run (E-0098)
; 5 call sites from 5 routines (e.g. ScriptCommandF7_Run_Case19, ScriptCommandF7_Run_Case11, ScriptCommandF7_Run_Case10, ScriptCommandF7_Run_Case0B, ...)
; reads: wGoldLo, wGoldMid, wGoldHi
; writes: wDigits
; points at: wArg3
ScriptCommandF7_Run_Shared02::
Func_00C_7098:: ; address name
    ld de, TileRect_0C_777E
    ld hl, wWindowTileBuffer + $70
    ld bc, $0803
    call CopyRectTo20ByteRows_Bank0C
    ld a, [wGoldLo]
    ld [wDigits], a
    ld a, [wGoldMid]
    ld [wDigits + $1], a
    ld a, [wGoldHi]
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    farcall UnpackBCDToDigitsArg1_Bank1E
    ld hl, wWindowTileBuffer + $86
    ld de, wArg3
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
; reads: wPartyCount
; points at: wArenaEntry
ScriptCommandF7_Run_Shared05_Sub01::
Func_00C_70D3:: ; address name
    ld hl, $0000
    ld de, wArenaEntry
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
    ld a, [wPartyCount]
    ld b, a
    ld a, c
    cp a, b
    jr c, Jump_00C_70DB
    ld a, [wPartyCount]
    call DivideHLByA
    ld a, h
    and a, a
    ret z
    ld h, $00
    ld l, $FF
    ret

; only called from ScriptCommandF7_Run_Shared05 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandF7_Run_Shared05)
; reads: hTemp0, wPartyCount
; writes: wArenaEntry, rRAMG2, rRAMB
; points at: wPartyList, wArenaEntry
ScriptCommandF7_Run_Shared05_Sub02::
Func_00C_70FE:: ; address name
    xor a, a
    ld [wArenaEntry], a
    ld [wArenaEntry + $1], a
    ld [wArenaEntry + $2], a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld de, wPartyList
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
    call AddTemp0WordToHL
    pop de
    push de
    ld hl, $0000
    push hl
    ld a, [de]
    ld c, $61
    call LoadSRAMRecordWord
    pop hl
    call AddTemp0WordToHL
    pop de
    push de
    push hl
    ld a, [de]
    ld c, $63
    call LoadSRAMRecordWord
    pop hl
    call AddTemp0WordToHL
    pop de
    push de
    push hl
    ld a, [de]
    ld c, $65
    call LoadSRAMRecordWord
    pop hl
    call AddTemp0WordToHL
    pop de
    push de
    push hl
    ld a, [de]
    ld c, $67
    call LoadSRAMRecordWord
    ld hl, $0000
    call AddTemp0WordToHL
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
    call AddTemp0WordToHL
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
    ld de, wArenaEntry
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
    call AddTemp0WordToHL
    pop de
    push de
    ld hl, $0000
    push hl
    ld a, [de]
    ld c, $61
    call LoadSRAMRecordWord
    pop hl
    call AddTemp0WordToHL
    pop de
    push de
    push hl
    ld a, [de]
    ld c, $63
    call LoadSRAMRecordWord
    pop hl
    call AddTemp0WordToHL
    pop de
    push de
    push hl
    ld a, [de]
    ld c, $65
    call LoadSRAMRecordWord
    pop hl
    call AddTemp0WordToHL
    pop de
    push de
    push hl
    ld a, [de]
    ld c, $67
    call LoadSRAMRecordWord
    pop hl
    call AddTemp0WordToHL
    pop de
    push de
    push hl
    ld a, [de]
    ld c, $69
    call LoadSRAMRecordWord
    pop hl
    call AddTemp0WordToHL
    pop de
    push de
    push hl
    ld a, [de]
    ld c, $56
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
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
    ld de, wArenaEntry
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
    ld a, [wPartyCount]
    ld b, a
    ld a, c
    cp a, b
    jp c, Jump_00C_7116
    xor a, a
    ld [rRAMG2], a
    ret

; HL += the word in hFFC6/hFFC7; clobbers A (E-0073)
; 12 call sites from 1 routine (e.g. ScriptCommandF7_Run_Shared05_Sub02)
; reads: hTemp0, hTemp1
AddTemp0WordToHL::
Func_00C_7246:: ; address name
    ldh a, [hTemp0]
    add a, l
    ld l, a
    ldh a, [hTemp1]
    adc a, h
    ld h, a
    ret

; HL = the word Data_00C_72C0[band] for the party's total level (bands at 49, 91, 139, 181, 220 and 256) (E-0128)
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0, wPartyCount
; writes: rRAMG2, rRAMB
; points at: wPartyList
PickTableEntryByPartyLevelTotal:: ; heuristic: follows a terminator; C0
Func_00C_724F:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld hl, wPartyList
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
    ldh a, [hTemp0]
    add a, e
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    pop hl
    pop bc
    inc hl
    inc c
    ld a, [wPartyCount]
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

; address loaded by PickTableEntryByPartyLevelTotal
Data_00C_72C0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $90, $01, $58, $02, $20, $03, $B0, $04, $78, $05, $78, $05

; copies a wD7F1 x wD7F2 block inside the screen buffer from offset DE to offset HL for rows B to C, with CGB attributes (E-0128)
; 7 call sites from 6 routines (e.g. ScriptCommandF7_Run_Case26, RedrawFullScreenBoxes_0C, ScriptCommandF7_Run_Case18, ScriptCommandF7_Run_Case13, ...)
; reads: wArg1, wArg2, wIsCGB
; points at: wScreenTileBuffer, wScreenAttrBuffer
CopyScreenBufferRectWithAttrs_0C::
Func_00C_72CC:: ; address name
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
    ld a, [wArg1]
    ld b, a
    ld a, [wArg2]
    ld c, a
    call CopyBytesDEToHL_Bank0C
    pop de
    pop hl
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_00C_7311
    push hl
    push de
    ld de, wScreenAttrBuffer
    add hl, de
    pop de
    push de
    push hl
    ld hl, wScreenAttrBuffer
    add hl, de
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    pop hl
    ld a, [wArg1]
    ld b, a
    ld a, [wArg2]
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
    jr c, CopyScreenBufferRectWithAttrs_0C
    ret

; only called from ScriptCommand96_Run_Shared01 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommand96_Run_Shared01)
; reads: wArenaRound, wAreaGraphicsIndex
; points at: wArenaList, wArenaList2
ScriptCommand96_Run_Shared01_Sub01::
Func_00C_7326:: ; address name
    ld hl, wArenaList
    ld b, $28

Jump_00C_732B::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_00C_732B
    ld a, [wArenaRound]
    ld b, a
    ld c, $00

Jump_00C_7336::
    push bc
    ld b, $1F
    call RandomModulo52

Jump_00C_733C::
    ld de, ArenaEncounterListSizes
    ld a, [wAreaGraphicsIndex]
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
    ld hl, wArenaList
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
    ld hl, ArenaEncounterLists
    ld a, [wAreaGraphicsIndex]
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
    ld hl, wArenaList2
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
; reads: wRandomLo
RandomModulo52::
Func_00C_73B3:: ; address name
    push bc
    call NextTableByte
    pop bc
    ld a, [wRandomLo]
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
; reads: wScriptStartRequest, wScriptPointerLo, wScriptPointerHi, wArenaRound
; writes: wScriptReturnBank, wScriptReturnLo, wScriptReturnHi, wTalkEventIndex, wTalkEventGroup, wScriptInDataBank, hSpriteWindowClipMode, wBattleIntroKind, ...
; points at: wArenaList2, wEncounterMonsters
ScriptCommandF7_Run_Case1A_Sub01::
Func_00C_73C7:: ; address name
    ld a, [wScriptStartRequest]
    ld [wScriptReturnBank], a
    ld a, [wScriptPointerLo]
    ld [wScriptReturnLo], a
    ld a, [wScriptPointerHi]
    ld [wScriptReturnHi], a
    xor a, a
    ld [wTalkEventIndex], a
    ld a, $1F
    ld [wTalkEventGroup], a
    farcall DispatchTalkEvent
    xor a, a
    ld [wScriptInDataBank], a
    xor a, a
    ldh [hSpriteWindowClipMode], a
    farcall ClearBit1OfPlayerAndObjectFlags

; only called from routines of ScriptCommand96_Run (E-0098)
; 2 call sites from 2 routines (e.g. ScriptCommand96_Run_Case0D, ScriptCommand96_Run_Case05)
; reads: wArenaRound
; writes: wBattleIntroKind, wEncounterKind
; points at: wArenaList2, wEncounterMonsters
ScriptCommand96_Run_Shared01::
Func_00C_73F5:: ; address name
    ld a, $04
    ld [wBattleIntroKind], a
    ld a, $02
    ld [wEncounterKind], a
    call ScriptCommand96_Run_Shared01_Sub01

; only called from ScriptCommandF7_Run_Case1C (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandF7_Run_Case1C)
; reads: wArenaRound
; points at: wArenaList2, wEncounterMonsters
ScriptCommandF7_Run_Case1C_Sub01::
Func_00C_7402:: ; address name
    ld a, [wArenaRound]
    sla a
    ld b, a
    sla a
    add a, b
    ld hl, wArenaList2
    add_a_to_hl
    ld de, wEncounterMonsters
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
; reads: wScriptStartRequest, wScriptPointerLo, wScriptPointerHi, wScreenCountPlusOne
; writes: wScriptReturnBank, wScriptReturnLo, wScriptReturnHi, wTalkEventIndex, wTalkEventGroup, wScriptInDataBank, hSpriteWindowClipMode, wBattleIntroKind, ...
; points at: wEncounterMonsters
ScriptCommandF7_Run_Shared03::
Func_00C_741F:: ; address name
    ld a, [wScriptStartRequest]
    ld [wScriptReturnBank], a
    ld a, [wScriptPointerLo]
    ld [wScriptReturnLo], a
    ld a, [wScriptPointerHi]
    ld [wScriptReturnHi], a
    xor a, a
    ld [wTalkEventIndex], a
    ld a, $18
    ld [wTalkEventGroup], a
    farcall DispatchTalkEvent
    xor a, a
    ld [wScriptInDataBank], a
    xor a, a
    ldh [hSpriteWindowClipMode], a
    farcall ClearBit1OfPlayerAndObjectFlags

; only called from routines of ScriptCommand95_Run (E-0098)
; 2 call sites from 2 routines (e.g. ScriptCommand95_Run_Case0E, ScriptCommand95_Run_Case06)
; reads: wScreenCountPlusOne
; writes: wBattleIntroKind, wEncounterKind
; points at: wEncounterMonsters
ScriptCommand95_Run_Shared01::
Func_00C_744D:: ; address name
    ld a, $04
    ld [wBattleIntroKind], a
    ld a, $02
    ld [wEncounterKind], a
    ld hl, Data_00C_787D
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, [wScreenCountPlusOne]
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
    ld de, wEncounterMonsters
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
; reads: wScriptStartRequest, wScriptPointerLo, wScriptPointerHi, wGridCursorX, wScreenCountPlusOne
; writes: wScriptReturnBank, wScriptReturnLo, wScriptReturnHi, wTalkEventIndex, wTalkEventGroup, wScriptInDataBank, hSpriteWindowClipMode, wBattleIntroKind, ...
; points at: wEncounterMonsters
ScriptCommandF7_Run_Shared04::
Func_00C_7478:: ; address name
    ld a, [wScriptStartRequest]
    ld [wScriptReturnBank], a
    ld a, [wScriptPointerLo]
    ld [wScriptReturnLo], a
    ld a, [wScriptPointerHi]
    ld [wScriptReturnHi], a
    xor a, a
    ld [wTalkEventIndex], a
    ld a, $18
    ld [wTalkEventGroup], a
    farcall DispatchTalkEvent
    xor a, a
    ld [wScriptInDataBank], a
    xor a, a
    ldh [hSpriteWindowClipMode], a
    farcall ClearBit1OfPlayerAndObjectFlags

; only called from routines of ScriptCommand95_Run (E-0098)
; 2 call sites from 2 routines (e.g. ScriptCommand95_Run_Case0E, ScriptCommand95_Run_Case06)
; reads: wGridCursorX, wScreenCountPlusOne
; writes: wBattleIntroKind, wEncounterKind
; points at: wEncounterMonsters
ScriptCommand95_Run_Shared02::
Func_00C_74A6:: ; address name
    ld a, $04
    ld [wBattleIntroKind], a
    ld a, $02
    ld [wEncounterKind], a
    ld a, [wGridCursorX]
    sla a
    ld hl, GridEncounterTable
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, [wScreenCountPlusOne]
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
    ld de, wEncounterMonsters
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
; writes: wArg1
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
    ld [wArg1], a
    ret

; address loaded by ScriptCommandF7_Run_Case27_Sub01
Data_00C_7538:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $40, $75, $47, $75, $4E, $75, $55, $75, $40, $41, $42, $43, $44, $45, $46, $47
    db $48, $49, $4A, $4B, $4C, $4D, $4E, $4F, $50, $51, $52, $53, $5A, $5B, $5C, $5D
    db $5E, $5F, $60, $61

; only called from ScriptCommandF7_Run_Case27 (E-0047)
; 2 call sites from 1 routine (e.g. ScriptCommandF7_Run_Case27)
; reads: wArg1
; writes: wArg1
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
    ld a, [wArg1]
    push af
    call ScriptCommandF7_Run_Shared06
    pop af
    ld [wArg1], a
    call ScriptCommandF7_Run_Case27_Sub02_Sub01
    ld a, $02
    ret

Jump_00C_757E::
    ld a, [wArg1]
    ld [hl], a
    call ScriptCommandF7_Run_Case27_Sub02_Sub01
    xor a, a
    ret

; only called from ScriptCommandF7_Run_Case27_Sub02 (E-0047)
; 2 call sites from 1 routine (e.g. ScriptCommandF7_Run_Case27_Sub02)
; reads: wArg1
; points at: wTextBuf1
ScriptCommandF7_Run_Case27_Sub02_Sub01::
Func_00C_7587:: ; address name
    ld de, Data_008_403C
    ld b, $08
    call ReadFarPointerAtDEInBankB
    ld c, l
    ld b, h
    ld a, [wArg1]
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
    ld hl, wTextBuf1

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
; writes: wArg1, wArg2, wArg3
ScriptCommandF7_Run_Shared06::
Func_00C_75BC:: ; address name
    ld hl, $1770
    ld a, l
    ld [wArg1], a
    ld a, h
    ld [wArg2], a
    xor a, a
    ld [wArg3], a
    farcall AddArg1ToGoldCapped99999
    ret

; address loaded by ScriptCommandF7_Run_Case27
Data_00C_75D2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $DE, $75, $DE, $75, $DE, $75, $E7, $75, $F0, $75, $F9, $75, $19, $23, $2D, $37
    db $41, $4B, $5F, $64, $FF, $14, $1F, $2A, $35, $40, $4B, $5A, $64, $FF, $0F, $17
    db $1F, $27, $2F, $37, $50, $64, $FF, $0A, $15, $20, $2B, $36, $41, $50, $64, $FF

; address loaded by ScriptCommandF7_Run_Case27
Data_00C_7602:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0E, $76, $0E, $76, $0E, $76, $16, $76, $1E, $76, $26, $76, $01, $53, $05, $0C
    db $24, $0B, $1C, $44, $02, $18, $0F, $10, $13, $15, $45, $FE, $03, $0D, $11, $12
    db $17, $2C, $FD, $FE, $23, $2C, $0D, $0E, $17, $FD, $1E, $FE

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 17 x 9 tiles, one row per line
TileRect_0C_762E::
Data_00C_762E:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $C3, $AA, $C3, $AA, $A4, $A5, $A6, $A6, $C3, $C3, $E1, $E0, $E0, $BF, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $C3, $A9, $C3, $AA, $A4, $A5, $A6, $A6, $C3, $C3, $E5, $E0, $E0, $BF, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $C3, $A8, $C3, $AA, $A4, $A5, $A6, $A6, $C3, $E1, $E0, $E0, $E0, $BF, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $C3, $A7, $C3, $AA, $A4, $A5, $A6, $A6, $C3, $E5, $E0, $E0, $E0, $BF, $B7 ; id 7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 8

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 3 x 5 tiles, one row per line
TileRect_0C_76C7::
Data_00C_76C7:: ; address name
    db $C3, $C3, $B7 ; id 0
    db $E0, $BF, $B7 ; id 1
    db $C3, $C3, $B7 ; id 2
    db $E0, $BF, $B7 ; id 3
    db $B4, $B4, $B5 ; id 4

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 17 x 9 tiles, one row per line
TileRect_0C_76D6::
Data_00C_76D6:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $AA, $C3, $AA, $A4, $A5, $A6, $A6, $C3, $E1, $E0, $E0, $E0, $BF, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $A9, $C3, $AA, $A4, $A5, $A6, $A6, $C3, $E2, $E0, $E0, $E0, $BF, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $A8, $C3, $AA, $A4, $A5, $A6, $A6, $C3, $E3, $E0, $E0, $E0, $BF, $C3, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $A7, $C3, $AA, $A4, $A5, $A6, $A6, $C3, $E5, $E0, $E0, $E0, $BF, $C3, $B7 ; id 7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 8

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 3 x 5 tiles, one row per line
TileRect_0C_776F::
Data_00C_776F:: ; address name
    db $C3, $C3, $B7 ; id 0
    db $BF, $C3, $B7 ; id 1
    db $C3, $C3, $B7 ; id 2
    db $BF, $C3, $B7 ; id 3
    db $B4, $B4, $B5 ; id 4

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 3 tiles, one row per line
TileRect_0C_777E::
Data_00C_777E:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $BF, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 2

; E-0234 (C1: no reference found; the bytes form a window frame with the frame tiles used by the referenced rectangles beside it: top row $B0 $B1.. $B2, side columns $B6/$B7, bottom row $B3 $B4.. $B5).
; record: 13 x 7 tiles, one row per line
TileRect_0C_7796::
Data_00C_7796:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $F0, $F1, $F2, $F3, $F4, $ED, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $C3, $A4, $A5, $A6, $ED, $C3, $C3, $C3, $C3, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $F5, $F6, $F7, $F8, $ED, $C3, $C3, $C3, $C3, $C3, $B7 ; id 5
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 6

; E-0234 (C1: no reference found; the bytes form a window frame with the frame tiles used by the referenced rectangles beside it: top row $B0 $B1.. $B2, side columns $B6/$B7, bottom row $B3 $B4.. $B5).
; record: 8 x 3 tiles, one row per line
TileRect_0C_77F1::
Data_00C_77F1:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $E1, $C3, $E2, $C3, $E3, $B7 ; id 1
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 2

; E-0234 (C1: no reference found; the bytes form a window frame with the frame tiles used by the referenced rectangles beside it: top row $B0 $B1.. $B2, side columns $B6/$B7, bottom row $B3 $B4.. $B5).
; record: 8 x 5 tiles, one row per line
TileRect_0C_7809::
Data_00C_7809:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $AC, $C3, $AB, $C3, $AA, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $A9, $C3, $A8, $C3, $A7, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 4

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 6 x 5 tiles, one row per line
TileRect_0C_7831::
Data_00C_7831:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $CE, $CF, $DF, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $AE, $AF, $C3, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B5 ; id 4

; address loaded by ScriptCommandF7_Run_Case02, ScriptCommandF7_Run_Case05
Data_00C_784F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $CA, $C3, $F2, $C3, $1A, $C4, $42, $C4

; address loaded by ScriptCommandF7_Run_Case12
Data_00C_7857:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C9, $C3, $F1, $C3, $19, $C4, $41, $C4, $8D, $C3, $8F, $C3, $91, $C3, $8D, $C3
    db $8F, $C3, $91, $C3, $B5, $C3, $B7, $C3, $B9, $C3

; address loaded by ScriptCommandF7_Run_Case04, ScriptCommandF7_Run_Case07
Data_00C_7871:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $64, $00, $F4, $01, $E8, $03, $88, $13, $02, $04, $08, $10

; address loaded by ScriptCommand95_Run_Shared01
Data_00C_787D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $7F, $78, $85, $78, $8B, $78, $91, $78, $83, $00, $84, $00, $83, $00, $85, $00
    db $86, $00, $87, $00, $88, $00, $89, $00, $88, $00

; E-0236 (C1: ScriptCommand95_Run_Shared02 sets battle intro 4 and encounter kind 2, reads the word at $7897 + 2 * wGridCursorX, then the word at that pointer + 2 * wScreenCountPlusOne, and copies 6 bytes from it to wEncounterMonsters (three encounter words, as E-0202)).
; record: encounter list for this wGridCursorX
GridEncounterTable::
Data_00C_7897:: ; address name
    dw GridEncounterList0 ; id 0
    dw GridEncounterList1 ; id 1
    dw GridEncounterList2 ; id 2
    dw GridEncounterList3 ; id 3

; E-0236 (C1: list 0 of GridEncounterTable).
; record: three encounter words for this wScreenCountPlusOne
GridEncounterList0::
Data_00C_789F:: ; address name
    dw GridEncounters0 ; id 0
    dw Data_00C_78AB ; id 1
    dw Data_00C_78B1 ; id 2

; E-0236 (C1: the three records of GridEncounterList0).
; record: three encounter words copied to wEncounterMonsters
GridEncounters0::
Data_00C_78A5:: ; address name
    dw $008A, $008B, $008C ; id 0
Data_00C_78AB:: ; heuristic: grid encounter; C0
    dw $008D, $008E, $008F ; id 1
Data_00C_78B1:: ; heuristic: grid encounter; C0
    dw $0090, $0091, $0090 ; id 2

; E-0236 (C1: list 1 of GridEncounterTable).
; record: three encounter words for this wScreenCountPlusOne
GridEncounterList1::
Data_00C_78B7:: ; address name
    dw GridEncounters1 ; id 0
    dw Data_00C_78C3 ; id 1
    dw Data_00C_78C9 ; id 2

; E-0236 (C1: the three records of GridEncounterList1).
; record: three encounter words copied to wEncounterMonsters
GridEncounters1::
Data_00C_78BD:: ; address name
    dw $0092, $0093, $0092 ; id 0
Data_00C_78C3:: ; heuristic: grid encounter; C0
    dw $0094, $0095, $0094 ; id 1
Data_00C_78C9:: ; heuristic: grid encounter; C0
    dw $0096, $0097, $0098 ; id 2

; E-0236 (C1: list 2 of GridEncounterTable).
; record: three encounter words for this wScreenCountPlusOne
GridEncounterList2::
Data_00C_78CF:: ; address name
    dw GridEncounters2 ; id 0
    dw Data_00C_78DB ; id 1
    dw Data_00C_78E1 ; id 2

; E-0236 (C1: the three records of GridEncounterList2).
; record: three encounter words copied to wEncounterMonsters
GridEncounters2::
Data_00C_78D5:: ; address name
    dw $0099, $009A, $009B ; id 0
Data_00C_78DB:: ; heuristic: grid encounter; C0
    dw $009C, $009D, $009E ; id 1
Data_00C_78E1:: ; heuristic: grid encounter; C0
    dw $009F, $00A0, $00A1 ; id 2

; E-0236 (C1: list 3 of GridEncounterTable).
; record: three encounter words for this wScreenCountPlusOne
GridEncounterList3::
Data_00C_78E7:: ; address name
    dw GridEncounters3 ; id 0
    dw Data_00C_78F3 ; id 1
    dw Data_00C_78F9 ; id 2

; E-0236 (C1: the three records of GridEncounterList3).
; record: three encounter words copied to wEncounterMonsters
GridEncounters3::
Data_00C_78ED:: ; address name
    dw $00A2, $00A3, $00A2 ; id 0
Data_00C_78F3:: ; heuristic: grid encounter; C0
    dw $00A4, $00A5, $00A4 ; id 1
Data_00C_78F9:: ; heuristic: grid encounter; C0
    dw $00A6, $00A7, $00A8 ; id 2

; E-0183 (C1: ScriptCommand96_Run_Shared01_Sub01 reads the byte at $78FF + wAreaGraphicsIndex and reduces a random number below it by repeated subtraction before indexing the list).
; record: number of usable entries in the list (39 each)
ArenaEncounterListSizes::
Data_00C_78FF:: ; address name
    db $27 ; id 0
    db $27 ; id 1
    db $27 ; id 2
    db $27 ; id 3
    db $27 ; id 4
    db $27 ; id 5

; E-0183 (C1: ScriptCommand96_Run_Shared01_Sub01 doubles wAreaGraphicsIndex, reads the word at $7905 + 2 * index and then the word at that pointer + 2 * the chosen entry; indexes 0-2 share one list).
; record: encounter word list for this wAreaGraphicsIndex
ArenaEncounterLists::
Data_00C_7905:: ; address name
    dw ArenaEncounterList0 ; id 0
    dw ArenaEncounterList0 ; id 1
    dw ArenaEncounterList0 ; id 2
    dw ArenaEncounterList1 ; id 3
    dw ArenaEncounterList2 ; id 4
    dw ArenaEncounterList3 ; id 5

; E-0183 (C1: the chosen word is stored in wArenaList2 (3 rounds x 3 words) and ScriptCommandF7_Run_Case1C_Sub01 copies one round's three words to wEncounterMonsters; each entry is drawn at most three times, counted in wArenaList).
; record: 40 encounter words (entries 0-38 are drawn; entry 39 is not reached)
ArenaEncounterList0::
Data_00C_7911:: ; address name
    dw $0104, $0105, $0106, $0107, $0108, $0109, $010A, $010B ; entry 0
    dw $010C, $010D, $010E, $010F, $0110, $0111, $0112, $0113
    dw $0114, $0115, $0116, $0117, $0118, $0119, $011A, $011B
    dw $0152, $0153, $0154, $0155, $0156, $0157, $0158, $0159
    dw $015A, $015B, $015C, $015D, $015E, $015F, $0160, $0161

; E-0183 (C1: the chosen word is stored in wArenaList2 (3 rounds x 3 words) and ScriptCommandF7_Run_Case1C_Sub01 copies one round's three words to wEncounterMonsters; each entry is drawn at most three times, counted in wArenaList).
; record: 40 encounter words (entries 0-38 are drawn; entry 39 is not reached)
ArenaEncounterList1::
Data_00C_7961:: ; address name
    dw $0136, $0137, $0138, $0139, $013A, $013B, $013C, $013D ; entry 0
    dw $013E, $013F, $0140, $0141, $0142, $0143, $0144, $0145
    dw $0146, $0147, $0148, $0149, $014A, $014B, $0162, $0163
    dw $0164, $0165, $0166, $0167, $0168, $0169, $016A, $016B
    dw $016C, $016D, $016E, $016F, $0170, $0171, $0172, $0173

; E-0183 (C1: the chosen word is stored in wArenaList2 (3 rounds x 3 words) and ScriptCommandF7_Run_Case1C_Sub01 copies one round's three words to wEncounterMonsters; each entry is drawn at most three times, counted in wArenaList).
; record: 40 encounter words (entries 0-38 are drawn; entry 39 is not reached)
ArenaEncounterList2::
Data_00C_79B1:: ; address name
    dw $021E, $021F, $0220, $0221, $0222, $0223, $0224, $0225 ; entry 0
    dw $0226, $0227, $0228, $0229, $022A, $022B, $022C, $022D
    dw $022E, $022F, $0230, $0231, $0232, $0233, $0234, $0235
    dw $0236, $0237, $0238, $0239, $023A, $023B, $023C, $023D
    dw $023E, $023F, $0240, $0241, $0242, $0243, $0244, $0245

; E-0183 (C1: the chosen word is stored in wArenaList2 (3 rounds x 3 words) and ScriptCommandF7_Run_Case1C_Sub01 copies one round's three words to wEncounterMonsters; each entry is drawn at most three times, counted in wArenaList).
; record: 40 encounter words (entries 0-38 are drawn; entry 39 is not reached)
ArenaEncounterList3::
Data_00C_7A01:: ; address name
    dw $01FF, $0200, $0201, $0202, $0203, $0204, $0246, $0247 ; entry 0
    dw $0248, $0249, $024A, $024B, $024C, $024D, $024E, $024F
    dw $0250, $0251, $0252, $0253, $0254, $0255, $0256, $0257
    dw $0267, $0268, $0269, $026A, $026B, $026C, $026D, $026E
    dw $026F, $0270, $0271, $0272, $0273, $0274, $0275, $0276

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_0C_7A51:: ; heuristic: event script entry or jump target; C0
    script_command $F7
    script_choice_jump Script_0C_7A5C, Script_0C_7A59, Script_0C_7A56
Script_0C_7A56:: ; heuristic: event script entry or jump target; C0
    script_jump Script_0C_7A5F
Script_0C_7A59:: ; heuristic: event script entry or jump target; C0
    script_jump Script_0C_7AFE
Script_0C_7A5C:: ; heuristic: event script entry or jump target; C0
    script_jump Script_0C_7A75
Script_0C_7A5F:: ; heuristic: event script entry or jump target; C0
    script_command $F7
    script_command $F7
    script_choice_jump Script_0C_7A6E, Script_0C_7A6B, Script_0C_7A65
Script_0C_7A65:: ; heuristic: event script entry or jump target; C0
    script_command $E9
    script_message $0025 ; '0 checked the dresser. Children's clothes'
    script_command $E9
    script_end
Script_0C_7A6B:: ; heuristic: event script entry or jump target; C0
    script_jump Script_0C_7A5F
Script_0C_7A6E:: ; heuristic: event script entry or jump target; C0
    script_message $4020 ; 'Cobi Sure, Mama! We'll be fine.'
    script_command $F7
    script_jump Script_0C_7ADB
Script_0C_7A75:: ; heuristic: event script entry or jump target; C0
    script_command $F7
    script_choice_jump Script_0C_7A8D, Script_0C_7A87, Script_0C_7A81, Script_0C_7A7B
Script_0C_7A7B:: ; heuristic: event script entry or jump target; C0
    script_command $E9
    script_message $8003 ; 'Tara There you are, big brother!'
    script_command $E9
    script_end
Script_0C_7A81:: ; heuristic: event script entry or jump target; C0
    script_message $C016 ; 'Listen you two! Quit your horsing'
    script_jump Script_0C_7A75
Script_0C_7A87:: ; heuristic: event script entry or jump target; C0
    script_message $C001 ; 'In the middle of the sea'
    script_jump Script_0C_7A75
Script_0C_7A8D:: ; heuristic: event script entry or jump target; C0
    script_message $C004 ; 'Cobi What's wrong, 0? Papa's calling'
    script_command $F7
    script_choice_jump Script_0C_7A9E, Script_0C_7A98, Script_0C_7A95
Script_0C_7A95:: ; heuristic: event script entry or jump target; C0
    script_jump Script_0C_7A75
Script_0C_7A98:: ; heuristic: event script entry or jump target; C0
    script_message $C006 ; 'You folks run a monster farm?'
    script_jump Script_0C_7A75
Script_0C_7A9E:: ; heuristic: event script entry or jump target; C0
    script_message $C005 ; 'Tara Hurry! Papa will be angry!'
Script_0C_7AA1:: ; heuristic: event script entry or jump target; C0
    script_command $F7
    script_command $F7
    script_choice_jump Script_0C_7AAD, Script_0C_7AAA, Script_0C_7AA7
Script_0C_7AA7:: ; heuristic: event script entry or jump target; C0
    script_jump Script_0C_7AEB
Script_0C_7AAA:: ; heuristic: event script entry or jump target; C0
    script_jump Script_0C_7AA1
Script_0C_7AAD:: ; heuristic: event script entry or jump target; C0
    script_jump Script_0C_7AB0
Script_0C_7AB0:: ; heuristic: event script entry or jump target; C0
    script_command $F7
    script_choice_jump Script_0C_7AC8, Script_0C_7AC2, Script_0C_7ABC, Script_0C_7AB6
Script_0C_7AB6:: ; heuristic: event script entry or jump target; C0
    script_command $E9
    script_message $0024 ; '0 checked the bookshelf. Behavior of'
    script_command $E9
    script_end
Script_0C_7ABC:: ; heuristic: event script entry or jump target; C0
    script_message $4023 ; 'Go to the Vault and pick'
    script_jump Script_0C_7ACB
Script_0C_7AC2:: ; heuristic: event script entry or jump target; C0
    script_message $4022 ; 'Tara We'll be OK! I'm going'
    script_jump Script_0C_7ACB
Script_0C_7AC8:: ; heuristic: event script entry or jump target; C0
    script_message $4021 ; 'Good, that's settled then. The Vault'
Script_0C_7ACB:: ; heuristic: event script entry or jump target; C0
    script_command $F7
    script_choice_jump Script_0C_7ACF, Script_0C_7AD5
Script_0C_7ACF:: ; heuristic: event script entry or jump target; C0
    script_command $E9
    script_message $802A ; 'Oh? Well, that's fine then. Go'
    script_command $E9
    script_end
Script_0C_7AD5:: ; heuristic: event script entry or jump target; C0
    script_command $E9
    script_message $802B ; 'Monster masters are those people who'
    script_command $E9
    script_end
Script_0C_7ADB:: ; heuristic: event script entry or jump target; C0
    script_command $F7
    script_choice_jump Script_0C_7ADF, Script_0C_7AE5
Script_0C_7ADF:: ; heuristic: event script entry or jump target; C0
    script_command $E9
    script_message $802D ; 'I aspired to be one long'
    script_command $E9
    script_end
Script_0C_7AE5:: ; heuristic: event script entry or jump target; C0
    script_command $E9
    script_message $802B ; 'Monster masters are those people who'
    script_command $E9
    script_end
Script_0C_7AEB:: ; heuristic: event script entry or jump target; C0
    script_command $F7
    script_choice_jump Script_0C_7AF5, Script_0C_7AEF
Script_0C_7AEF:: ; heuristic: event script entry or jump target; C0
    script_command $E9
    script_message $0026 ; '0 checked the dresser. It smelled'
    script_command $E9
    script_end
Script_0C_7AF5:: ; heuristic: event script entry or jump target; C0
    script_command $E9
    script_message $0025 ; '0 checked the dresser. Children's clothes'
    script_command $E9
    script_end
    db $00, $0B, $C0

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_0C_7AFE:: ; heuristic: event script entry or jump target; C0
    script_command $F7
    script_choice_jump Script_0C_7B08, Script_0C_7B02
Script_0C_7B02:: ; heuristic: event script entry or jump target; C0
    script_command $E9
    script_message $8009 ; 'Good. That's good to hear! You'
    script_command $E9
    script_end
Script_0C_7B08:: ; heuristic: event script entry or jump target; C0
    script_command $F7
    script_command $F7
Script_0C_7B0A:: ; heuristic: event script entry or jump target; C0
    script_choice_jump Script_0C_7B2F, Script_0C_7B29, Script_0C_7B23, Script_0C_7B1D, Script_0C_7B17, Script_0C_7B11
Script_0C_7B11:: ; heuristic: event script entry or jump target; C0
    script_message $C011 ; '0 peered into the vase. Freshly'
    script_jump Script_0C_7B32
Script_0C_7B17:: ; heuristic: event script entry or jump target; C0
    script_message $C010 ; '0 peered into the barrel. It'
    script_jump Script_0C_7B32
Script_0C_7B1D:: ; heuristic: event script entry or jump target; C0
    script_message $C00F ; 'Worried about your monsters? Don't be!'
    script_jump Script_0C_7B32
Script_0C_7B23:: ; heuristic: event script entry or jump target; C0
    script_message $C00E ; 'When our farm gets established in'
    script_jump Script_0C_7B32
Script_0C_7B29:: ; heuristic: event script entry or jump target; C0
    script_message $C00D ; 'GreatLog's King asked us to settle'
    script_jump Script_0C_7B32
Script_0C_7B2F:: ; heuristic: event script entry or jump target; C0
    script_message $C00C ; 'GreatLog's King asked us to settle'
Script_0C_7B32:: ; heuristic: event script entry or jump target; C0
    script_command $F7
    script_choice_jump Script_0C_7B3C, Script_0C_7B36
Script_0C_7B36:: ; heuristic: event script entry or jump target; C0
    script_command $E9
    script_message $8009 ; 'Good. That's good to hear! You'
    script_command $E9
    script_end
Script_0C_7B3C:: ; heuristic: event script entry or jump target; C0
    script_command $F7
    script_message $C012 ; 'Cobi 0! They said GreatLog will'
    script_command $F7
    script_choice_jump Script_0C_7B50, Script_0C_7B49, Script_0C_7B45
Script_0C_7B45:: ; heuristic: event script entry or jump target; C0
    script_command $F7
    script_jump Script_0C_7B0A
Script_0C_7B49:: ; heuristic: event script entry or jump target; C0
    script_message $C014 ; 'Tara Big brother! GreatLog will be'
    script_command $F7
    script_jump Script_0C_7B0A
Script_0C_7B50:: ; heuristic: event script entry or jump target; C0
    script_command $F7
    script_message $C013 ; 'Land ho! There's GreatLog!'
Script_0C_7B54:: ; heuristic: event script entry or jump target; C0
    script_command $F7
    script_command $F7
    script_choice_jump Script_0C_7B60, Script_0C_7B5D, Script_0C_7B5A
Script_0C_7B5A:: ; heuristic: event script entry or jump target; C0
    script_jump Script_0C_7B99
Script_0C_7B5D:: ; heuristic: event script entry or jump target; C0
    script_jump Script_0C_7B54
Script_0C_7B60:: ; heuristic: event script entry or jump target; C0
    script_jump Script_0C_7B63
Script_0C_7B63:: ; heuristic: event script entry or jump target; C0
    script_command $F7
    script_message $402F ; 'Go help your mother now.'
    script_message $C031 ; 'Heh, so these are the newcomers?'
Script_0C_7B6A:: ; heuristic: event script entry or jump target; C0
    script_command $F7
    script_choice_jump Script_0C_7B7B, Script_0C_7B6E
Script_0C_7B6E:: ; heuristic: event script entry or jump target; C0
    script_message $C030 ; 'If some monster masters keep their'
    script_command $F7
    script_choice_jump Script_0C_7B7B, Script_0C_7B75
Script_0C_7B75:: ; heuristic: event script entry or jump target; C0
    script_message $C031 ; 'Heh, so these are the newcomers?'
    script_jump Script_0C_7B6A
Script_0C_7B7B:: ; heuristic: event script entry or jump target; C0
    script_command $F7
    script_choice_jump Script_0C_7B81, Script_0C_7B87, Script_0C_7B8D, Script_0C_7B93
Script_0C_7B81:: ; heuristic: event script entry or jump target; C0
    script_command $E9
    script_message $8032 ; 'C'mon, Warubou!'
    script_command $E9
    script_end
Script_0C_7B87:: ; heuristic: event script entry or jump target; C0
    script_command $E9
    script_message $8033 ; 'Hello, there! You must be the'
    script_command $E9
    script_end
Script_0C_7B8D:: ; heuristic: event script entry or jump target; C0
    script_command $E9
    script_message $8034 ; 'Oh It's all spinning around That'
    script_command $E9
    script_end
Script_0C_7B93:: ; heuristic: event script entry or jump target; C0
    script_command $E9
    script_message $8035 ; 'The horrid Prince and that elemental'
    script_command $E9
    script_end
Script_0C_7B99:: ; heuristic: event script entry or jump target; C0
    script_command $F7
    script_choice_jump Script_0C_7BA3, Script_0C_7B9D
Script_0C_7B9D:: ; heuristic: event script entry or jump target; C0
    script_command $E9
    script_message $0029 ; 'I e heard that there are'
    script_command $E9
    script_end
Script_0C_7BA3:: ; heuristic: event script entry or jump target; C0
    script_command $E9
    script_message $0028 ; '0 peered into the vase. It'
    script_command $E9
    script_end
Script_0C_7BA9:: ; heuristic: event script entry or jump target; C0
    script_command $F3
    script_choice_jump Script_0C_7BB0, Script_0C_7BAD
Script_0C_7BAD:: ; heuristic: event script entry or jump target; C0
    script_jump Script_0C_7BBA
Script_0C_7BB0:: ; heuristic: event script entry or jump target; C0
    script_message $C011 ; '0 peered into the vase. Freshly'
    script_command $F3
    script_choice_jump Script_0C_7BBA, Script_0C_7BB7
Script_0C_7BB7:: ; heuristic: event script entry or jump target; C0
    script_message $C012 ; 'Cobi 0! They said GreatLog will'
Script_0C_7BBA:: ; heuristic: event script entry or jump target; C0
    script_command $F3
    script_choice_jump Script_0C_7BC1, Script_0C_7BBE
Script_0C_7BBE:: ; heuristic: event script entry or jump target; C0
    script_jump Script_0C_7C41
Script_0C_7BC1:: ; heuristic: event script entry or jump target; C0
    script_message $C013 ; 'Land ho! There's GreatLog!'
    script_message $C015 ; 'This is a tale of children'
    script_command $F3
    script_choice_jump Script_0C_7BD1, Script_0C_7BCB
Script_0C_7BCB:: ; heuristic: event script entry or jump target; C0
    script_command $EE
    script_message $8014 ; 'Tara Big brother! GreatLog will be'
    script_command $EE
    script_end
Script_0C_7BD1:: ; heuristic: event script entry or jump target; C0
    script_message $C016 ; 'Listen you two! Quit your horsing'
Script_0C_7BD4:: ; heuristic: event script entry or jump target; C0
    script_command $F3
    script_command $F3
    script_command $F3
    script_choice_jump Script_0C_7BE4, Script_0C_7BE1, Script_0C_7BDB
Script_0C_7BDB:: ; heuristic: event script entry or jump target; C0
    script_command $EE
    script_message $8014 ; 'Tara Big brother! GreatLog will be'
    script_command $EE
    script_end
Script_0C_7BE1:: ; heuristic: event script entry or jump target; C0
    script_jump Script_0C_7BD4
Script_0C_7BE4:: ; heuristic: event script entry or jump target; C0
    script_message $C017 ; 'It seems to me that the'
    script_command $F3
    script_choice_jump Script_0C_7BF7, Script_0C_7BF0, Script_0C_7BEC
Script_0C_7BEC:: ; heuristic: event script entry or jump target; C0
    script_message $C018 ; 'Yo, did you enjoy the voyage?'
    script_command $F3
Script_0C_7BF0:: ; heuristic: event script entry or jump target; C0
    script_message $C016 ; 'Listen you two! Quit your horsing'
    script_command $F3
    script_jump Script_0C_7BD4
Script_0C_7BF7:: ; heuristic: event script entry or jump target; C0
    script_command $F3
    script_choice_jump Script_0C_7C12, Script_0C_7C0B, Script_0C_7C04, Script_0C_7BFD
Script_0C_7BFD:: ; heuristic: event script entry or jump target; C0
    script_message $C01B ; 'I accidentally went outside. People gave'
    script_command $F3
    script_jump Script_0C_7BF0
Script_0C_7C04:: ; heuristic: event script entry or jump target; C0
    script_message $C01A ; 'There aren't many friends here. It's'
    script_command $F3
    script_jump Script_0C_7BF0
Script_0C_7C0B:: ; heuristic: event script entry or jump target; C0
    script_message $C019 ; 'Slash If you're in need of'
    script_command $F3
    script_jump Script_0C_7BF0
Script_0C_7C12:: ; heuristic: event script entry or jump target; C0
    script_command $F3
    script_choice_jump Script_0C_7C1F, Script_0C_7C16
Script_0C_7C16:: ; heuristic: event script entry or jump target; C0
    script_message $C01C ; 'This hay is pretty good. Maybe'
    script_message $C01D ; '0 checked the pump. It's rusted'
    script_jump Script_0C_7C22
Script_0C_7C1F:: ; heuristic: event script entry or jump target; C0
    script_message $C01C ; 'This hay is pretty good. Maybe'
Script_0C_7C22:: ; heuristic: event script entry or jump target; C0
    script_command $F3
    script_choice_jump Script_0C_7C3D, Script_0C_7C36, Script_0C_7C2F, Script_0C_7C28
Script_0C_7C28:: ; heuristic: event script entry or jump target; C0
    script_message $C020 ; 'Cobi Sure, Mama! We'll be fine.'
    script_command $F3
    script_jump Script_0C_7BF0
Script_0C_7C2F:: ; heuristic: event script entry or jump target; C0
    script_message $C01F ; 'You e come at the right'
    script_command $F3
    script_jump Script_0C_7BF0
Script_0C_7C36:: ; heuristic: event script entry or jump target; C0
    script_message $C01E ; '0 peered into the barrel. It'
    script_command $F3
    script_jump Script_0C_7BF0
Script_0C_7C3D:: ; heuristic: event script entry or jump target; C0
    script_command $F3
    script_jump Script_0C_7BF0
Script_0C_7C41:: ; heuristic: event script entry or jump target; C0
    script_command $EE
    script_message $8024 ; '0 checked the bookshelf. Behavior of'
    script_command $EE
    script_end
    ds $3B9, $00
