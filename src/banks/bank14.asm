SECTION "Bank 14", ROMX[$4000], BANK[$14]
    db $14

; implements script command type EC; reached through ScriptCommandEC in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommandEC)
; reads: wScreenList
ScriptCommandEC_Run::
Func_014_4001:: ; address name
    ld a, [wScreenList]
    rst $00
    dw ScriptCommandEC_Run_Case00
    dw ScriptCommandEC_Run_Case01
    dw ScriptCommandEC_Run_Case02
    dw ScriptCommandEC_Run_Case03

; entry 0 of the `rst $00` table in ScriptCommandEC_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wScreenList
; writes: wScreenList
; points at: wScreenTileBuffer, wScreenAttrBuffer
ScriptCommandEC_Run_Case00::
Jump_014_400D:: ; address name
    ld hl, wWindowTileBuffer + $64
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank14
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_014_402B
    ld hl, wWindowAttrBuffer + $64
    ld de, wScreenAttrBuffer
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank14

Jump_014_402B::
    call BGMapAddressAtScroll_Bank14
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    ld a, [wScreenList]
    inc a
    ld [wScreenList], a
    ret

; entry 1 of the `rst $00` table in ScriptCommandEC_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wScreenList
; writes: wArg1, wArg2, wArg3, wArg4, wGlyphListPos, wGlyphListStart, wScreenState, wScreenStep, ...
ScriptCommandEC_Run_Case01::
Jump_014_403F:: ; address name
    ld a, $9C
    ld [wArg1], a
    xor a, a
    ld [wArg2], a
    ld de, $6D84
    ld a, d
    ld [wArg3], a
    ld a, e
    ld [wArg4], a
    farcall LoadTileListSixPerCall
    ld a, [wArg5]
    cp a, $FF
    ret nz
    xor a, a
    ld [wGlyphListPos], a
    ld [wGlyphListStart], a
    ld [wScreenState], a
    ld [wScreenStep], a
    ld [wMenuState], a
    ld a, [wScreenList]
    inc a
    ld [wScreenList], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in ScriptCommandEC_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenList
; writes: wScreenList
; points at: wTextWindowTileLo
ScriptCommandEC_Run_Case02::
Jump_014_4080:: ; address name
    ld hl, vTiles1 + $500
    ld bc, $0F01
    call FillTilesBxC
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, [wScreenList]
    inc a
    ld [wScreenList], a
    ret

; entry 3 of the `rst $00` table in ScriptCommandEC_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wMessageMode, wScreenList, hSpriteHideTile, wScriptCommandType, wScriptStartRequest
; points at: wScreenState
ScriptCommandEC_Run_Case03::
Jump_014_409E:: ; address name
    farcall DrawRecordListNameTiles_Bank1D
    xor a, a
    ld [wMessageMode], a
    ld [wScreenList], a
    ld bc, $006F
    ld hl, wScreenState

Jump_014_40B1::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_014_40B1
    ld a, $80
    ldh [hSpriteHideTile], a
    farcall WritePlayerNameWithFlag0SuffixToTextBuf0
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type EB; reached through ScriptCommandEB in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommandEB)
; reads: wScreenState
ScriptCommandEB_Run::
Func_014_40CC:: ; address name
    ld a, [wScreenState]
    rst $00
    dw ScriptCommandEB_Run_Case00
    dw ScriptCommandEB_Run_Case01
    dw ScriptCommandEB_Run_Case02
    dw ScriptCommandEB_Run_Case03
    dw ScriptCommandEB_Run_Case04
    dw ScriptCommandEB_Run_Case05
    dw ScriptCommandEB_Run_Case06
    dw ScriptCommandEB_Run_Case07
    dw ScriptCommandEB_Run_Case08
    dw ScriptCommandEB_Run_Case08
    dw ScriptCommandEB_Run_Case08
    dw ScriptCommandEB_Run_Case08

; entry 0 of the `rst $00` table in ScriptCommandEB_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: wMessageMode, hSpriteHideTile, wScriptCommandType, wScriptStartRequest
; points at: wScreenState, wScreenTileBuffer, wScreenAttrBuffer
ScriptCommandEB_Run_Case00::
Jump_014_40E8:: ; address name
    ld hl, wScreenState
    ld bc, $006F

Jump_014_40EE::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_014_40EE
    ld hl, wWindowTileBuffer + $64
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank14
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_014_4113
    ld hl, wWindowAttrBuffer + $64
    ld de, wScreenAttrBuffer
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank14

Jump_014_4113::
    ld a, $04
    ld [wMessageMode], a
    ld a, $70
    ldh [hSpriteHideTile], a
    xor a, a
    ld hl, wScreenState
    inc [hl]
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 1 of the `rst $00` table in ScriptCommandEB_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
ScriptCommandEB_Run_Case01::
Jump_014_412B:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw ScriptCommandEB_Run_Case01_Case00
    dw ScriptCommandEB_Run_Case01_Case01
    dw ScriptCommandEB_Run_Case01_Case02
    dw ScriptCommandEB_Run_Case01_Case03

; entry 0 of the `rst $00` table in ScriptCommandEB_Run_Case01
; no direct call (reached through a table, a jump or a vector)
ScriptCommandEB_Run_Case01_Case00::
Jump_014_4137:: ; address name
    farcall SetupTileMap6D84AtBGMap1
    ret

; entry 1 of the `rst $00` table in ScriptCommandEB_Run_Case01
; no direct call (reached through a table, a jump or a vector)
; points at: wScreenStep
ScriptCommandEB_Run_Case01_Case01::
Jump_014_413E:: ; address name
    ld hl, NamingScreenTileDestListA
    ld de, TileCopySrcList_14_5A84
    call ScriptCommandEB_Run_Shared04
    cp a, $FF
    ret nz
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in ScriptCommandEB_Run_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
ScriptCommandEB_Run_Case01_Case02::
Jump_014_414F:: ; address name
    farcall ListPartyRecordsWithState2ToListEntries
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 3 of the `rst $00` table in ScriptCommandEB_Run_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wScreenStep, wScreenState
ScriptCommandEB_Run_Case01_Case03::
Jump_014_415D:: ; address name
    ld de, TileRect_14_5AC4
    ld hl, wWindowTileBuffer + $64
    ld bc, $0A09
    call CopyRectTo20ByteRows_Bank14
    call RunFunc5925At0280
    call BGMapAddressAtScroll_Bank14
    ld bc, $140B
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    farcall CountRecordsInUse
    xor a, a
    ld [wScreenStep], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; entry 2 of the `rst $00` table in ScriptCommandEB_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wGridCursorX, wScreenState
; writes: wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wScreenState, wListCursor, wChoiceCursor, wListPageIndex, wGridCursorX
ScriptCommandEB_Run_Case02::
Jump_014_418A:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, Jump_014_41A6
    bit 7, a
    jr nz, Jump_014_41D4
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, Jump_014_41EE
    bit 1, a
    jp nz, Jump_014_4230
    call ScriptCommandEB_Run_Case02_Sub01
    ret

Jump_014_41A6::
    call ScriptCommandEB_Run_Case02_Sub03
    ld a, [wGridCursorX]
    and a, a
    jr nz, Jump_014_41BD
    ld a, $03
    ld [wGridCursorX], a
    call ScriptCommandEB_Run_Case02_Sub01
    ld a, $69
    call QueueSoundEffect
    ret

Jump_014_41BD::
    dec a

Jump_014_41BE::
    ld [wGridCursorX], a
    xor a, a
    ld [wListCursor], a
    ld [wChoiceCursor], a
    ld [wListPageIndex], a
    call ScriptCommandEB_Run_Case02_Sub02
    ld a, $69
    call QueueSoundEffect
    ret

Jump_014_41D4::
    call ScriptCommandEB_Run_Case02_Sub03
    ld a, [wGridCursorX]
    cp a, $03
    jr c, Jump_014_41EB
    xor a, a
    ld [wGridCursorX], a
    call ScriptCommandEB_Run_Case02_Sub01
    ld a, $69
    call QueueSoundEffect
    ret

Jump_014_41EB::
    inc a
    jr Jump_014_41BE

Jump_014_41EE::
    ld a, $69
    call QueueSoundEffect
    call ScriptCommandEB_Run_Case02_Sub04
    ld c, $00

Jump_014_41F8::
    ld a, c
    ld b, $C3
    ld hl, Data_014_5B1E
    push bc
    push hl
    call StoreBAtWordTableEntry_Bank14
    pop hl
    pop bc
    inc c
    ld a, c
    cp a, $04
    jr c, Jump_014_41F8
    ld a, [wGridCursorX]
    cp a, $03
    jr z, Jump_014_4230
    ld [wTwoChoiceCursor], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a, a
    ld [wListCursor], a
    ld [wChoiceCursor], a
    ld [wListPageIndex], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_014_4230::
    ld a, $03
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; only called from ScriptCommandEB_Run_Case02 (E-0047)
; 3 call sites from 1 routine (e.g. ScriptCommandEB_Run_Case02)
; reads: wJoypadRepeatTimer, wGridCursorY, wGridCursorX
; writes: wGridCursorY
ScriptCommandEB_Run_Case02_Sub01::
Func_014_423F:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, ScriptCommandEB_Run_Case02_Sub02
    ld a, [wGridCursorY]
    inc a
    ld [wGridCursorY], a
    cp a, $10
    jr c, ScriptCommandEB_Run_Case02_Sub02
    cp a, $18
    jr c, ScriptCommandEB_Run_Case02_Sub03
    xor a, a
    ld [wGridCursorY], a

; only called from ScriptCommandEB_Run_Case02 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandEB_Run_Case02)
; reads: wGridCursorX
ScriptCommandEB_Run_Case02_Sub02::
Func_014_4259:: ; address name
    ld b, $BB
    jr Jump_014_4263

; only called from ScriptCommandEB_Run_Case02 (E-0047)
; 2 call sites from 1 routine (e.g. ScriptCommandEB_Run_Case02)
; reads: wGridCursorX
ScriptCommandEB_Run_Case02_Sub03::
Func_014_425D:: ; address name
    ld b, $C3
    jr Jump_014_4263

; only called from ScriptCommandEB_Run_Case02 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandEB_Run_Case02)
; reads: wGridCursorX
ScriptCommandEB_Run_Case02_Sub04::
Func_014_4261:: ; address name
    ld b, $BC

Jump_014_4263::
    ld a, [wGridCursorX]
    add a, a
    ld hl, Data_014_4280
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank14
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; address loaded by ScriptCommandEB_Run_Case02_Sub04
Data_014_4280:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $21, $00, $61, $00, $A1, $00, $E1, $00, $21, $01

; entry 3 of the `rst $00` table in ScriptCommandEB_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wGridCursorX, wArg5, wScreenState, wListCount, wRecordsFlagged, wPartyCount
; writes: wTwoChoiceCursor, wScreenState, wScreenStep, wScreenSubStep, wScriptCommandType, wScriptStartRequest, wListPageIndex, wListCursor
ScriptCommandEB_Run_Case03::
Jump_014_428A:: ; address name
    ld a, [wGridCursorX]
    and a, a
    jr z, Jump_014_429B
    cp a, $01
    jp z, Jump_014_4309
    cp a, $02
    jp z, Jump_014_4409
    ret

Jump_014_429B::
    farcall ListRecordsState1WithByte6EClear
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ld a, [wListCount]
    and a, a
    jr z, Jump_014_42F1
    farcall CountFlaggedSRAMRecords
    farcall LoadRecordCapacityFromFarmLevelTable
    ld a, [wArg5]
    cp a, c
    jr c, Jump_014_42DA
    ld a, $1E
    ld [wScreenStep], a
    xor a, a
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wListPageIndex], a
    ld [wListCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_014_42DA::
    xor a, a
    ld [wScreenStep], a
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wListPageIndex], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_014_42F1::
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $02
    ld [wScreenState], a
    xor a, a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_014_4309::
    farcall CountFlaggedSRAMRecords
    ld a, [wArg5]
    and a, a
    jp z, Jump_014_43B1
    farcall ListRecordsInUseWithByte6EClear
    farcall LoadRecordCapacityFromFarmLevelTable
    ld a, [wListCount]
    cp a, c
    jr nc, Jump_014_4339
    ld b, a
    ld a, [wRecordsFlagged]
    cp a, c
    jr nc, Jump_014_4396
    add a, b
    cp a, c
    jr c, Jump_014_4359
    ld a, [wPartyCount]
    cp a, b
    jr z, Jump_014_437B

Jump_014_4339::
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScreenSubStep], a
    ld a, $1B
    ld [wScreenStep], a
    ld a, [wScreenState]
    inc a
    inc a
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_014_4359::
    farcall ListRecordsState1WithByte6EClear
    xor a, a
    ld [wTwoChoiceCursor], a
    ld [wScreenSubStep], a
    ld [wScreenStep], a
    ld a, [wScreenState]
    inc a
    inc a
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_014_437B::
    ld a, $04
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScreenSubStep], a
    ld [wScreenStep], a
    ld a, $02
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_014_4396::
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScreenSubStep], a
    ld [wScreenStep], a
    ld a, $02
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_014_43B1::
    ld a, $03
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScreenSubStep], a
    ld [wScreenStep], a
    ld a, $02
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; lists the records; with none sets wTwoChoiceCursor = 1 and wD780 = 2, otherwise wD780 += 3; then requests script $80 (the next entry does the same with CountFlaggedSRAMRecords) (E-0127)
; no direct call (reached through a table, a jump or a vector)
; reads: wListCount, wScreenState
; writes: wTwoChoiceCursor, wScreenState, wScreenStep, wScreenSubStep, wScriptCommandType, wScriptStartRequest
StartRecordListOrNoneMessage:: ; heuristic: follows a terminator; C0
Func_014_43CC:: ; address name
    farcall ListRecordsState1WithByte6EClear
    ld a, [wListCount]
    and a, a
    jr nz, Jump_014_43F3
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $02
    ld [wScreenState], a
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_014_43F3::
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenState]
    add a, $03
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_014_4409::
    farcall CountFlaggedSRAMRecords
    ld a, [wArg5]
    and a, a
    jr nz, Jump_014_4430
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $02
    ld [wScreenState], a
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_014_4430::
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

; entry 5 of the `rst $00` table in ScriptCommandEB_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
ScriptCommandEB_Run_Case05::
Jump_014_4446:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw ScriptCommandEB_Run_Case05_Case00
    dw ClearTilesAndDrawRect5B36AndStep
    dw ScriptCommandEB_Run_Case05_Case02
    dw ScriptCommandEB_Run_Case05_Case03
    dw ScriptCommandEB_Run_Case05_Case04
    dw ScriptCommandEB_Run_Case05_Case05
    dw ScriptCommandEB_Run_Case05_Case06
    dw ScriptCommandEB_Run_Case05_Case07
    dw ScriptCommandEB_Run_Case05_Case08
    dw ScriptCommandEB_Run_Case05_Case09
    dw ScriptCommandEB_Run_Case05_Case0A
    dw ScriptCommandEB_Run_Case05_Case0B
    dw ScriptCommandEB_Run_Case05_Case00
    dw ScriptCommandEB_Run_Case05_Case0D
    dw ScriptCommandEB_Run_Case05_Case0E
    dw ScriptCommandEB_Run_Case05_Case0F
    dw ScriptCommandEB_Run_Case05_Case10
    dw ScriptCommandEB_Run_Case05_Case11
    dw ScriptCommandEB_Run_Case05_Case12
    dw ScriptCommandEB_Run_Case05_Case13
    dw ScriptCommandEB_Run_Case05_Case09
    dw ScriptCommandEB_Run_Case05_Case0A
    dw ScriptCommandEB_Run_Case05_Case0B
    dw ScriptCommandEB_Run_Case05_Case00
    dw ScriptCommandEB_Run_Case05_Case0D
    dw ScriptCommandEB_Run_Case05_Case0E
    dw ScriptCommandEB_Run_Case05_Case0F
    dw ScriptCommandEB_Run_Case05_Case1B
    dw ScriptCommandEB_Run_Case05_Case1C
    dw ScriptCommandEB_Run_Case05_Case00
    dw ClearTilesAndDrawRect5B36AndStep
    dw ScriptCommandEB_Run_Case05_Case1F
    dw ScriptCommandEB_Run_Case05_Case20
    dw ScriptCommandEB_Run_Case05_Case21
    dw ScriptCommandEB_Run_Case05_Case05
    dw ScriptCommandEB_Run_Case05_Case23
    dw ScriptCommandEB_Run_Case05_Case07
    dw ScriptCommandEB_Run_Case05_Case25
    dw ScriptCommandEB_Run_Case05_Case09
    dw ScriptCommandEB_Run_Case05_Case0A
    dw ScriptCommandEB_Run_Case05_Case0B
    dw ScriptCommandEB_Run_Case05_Case00
    dw ScriptCommandEB_Run_Case05_Case0D
    dw ScriptCommandEB_Run_Case05_Case0E
    dw ScriptCommandEB_Run_Case05_Case2C
    dw ScriptCommandEB_Run_Case05_Case2D
    dw ScriptCommandEB_Run_Case05_Case2E
    dw ScriptCommandEB_Run_Case05_Case2F
    dw DrawBox4965AndMenuAndStep
    dw ScriptCommandEB_Run_Case05_Case31
    dw ScriptCommandEB_Run_Case05_Case32
    dw ScriptCommandEB_Run_Case05_Case00
    dw ClearTilesAndDrawRect5B36AndStep
    dw ScriptCommandEB_Run_Case05_Case02
    dw ScriptCommandEB_Run_Case05_Case03
    dw ScriptCommandEB_Run_Case05_Case04
    dw ScriptCommandEB_Run_Case05_Case05
    dw ScriptCommandEB_Run_Case05_Case06
    dw ScriptCommandEB_Run_Case05_Case07
    dw ScriptCommandEB_Run_Case05_Case3B
    dw ScriptCommandEB_Run_Case05_Case3C
    dw ScriptCommandEB_Run_Case05_Case10
    dw ScriptCommandEB_Run_Case05_Case3E
    dw ScriptCommandEB_Run_Case05_Case3F
    dw ScriptCommandEB_Run_Case05_Case40
    dw ScriptCommandEB_Run_Case05_Case09
    dw ScriptCommandEB_Run_Case05_Case0A
    dw ScriptCommandEB_Run_Case05_Case0B
    dw ScriptCommandEB_Run_Case05_Case00
    dw ScriptCommandEB_Run_Case05_Case0D
    dw ScriptCommandEB_Run_Case05_Case0E
    dw ScriptCommandEB_Run_Case05_Case0F

; entry 50 of the `rst $00` table in ScriptCommandEB_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, wListCursor, wListPageIndex, wSelectedRecord
; writes: wSelectedRecord, wItemGridX, wItemGridY, wListCursor, wListPageIndex
ScriptCommandEB_Run_Case05_Case32::
Jump_014_44DA:: ; address name
    call DrawBox4965AndMenuAndStep
    farcall ListRecordsState1WithByte6EClear
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld [wSelectedRecord], a
    ld a, [wListCursor]
    ld [wItemGridX], a
    ld a, [wListPageIndex]
    ld [wItemGridY], a
    ld a, [wSelectedRecord]
    ld b, a
    ld c, $00
    call ScriptCommandEB_Run_Case05_Case32_Sub01
    xor a, a
    ld [wListCursor], a
    ld [wListPageIndex], a
    ret

; entry 60 of the `rst $00` table in ScriptCommandEB_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wListCursor, wItemGridX, wItemGridY
; writes: wListCursor, wListPageIndex, wTwoChoiceCursor, wScreenStep, wScriptCommandType, wScriptStartRequest
; points at: wTextWindowTileLo
ScriptCommandEB_Run_Case05_Case3C::
Jump_014_450C:: ; address name
    call BGMapAddressAtScroll_Bank14
    push hl
    ld a, [wListCursor]
    add a, a
    ld hl, Data_014_4586
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, $BC
    ld [hl], a
    ei
    ld a, [wItemGridX]
    ld [wListCursor], a
    ld a, [wItemGridY]
    ld [wListPageIndex], a
    farcall ListRecordsState1WithByte6EClear
    call ScriptCommandEB_Run_Shared01
    call EraseFiveEntriesOf5B1E
    ld hl, vTiles1 + $240
    ld bc, $0C01
    call FillTilesBxC
    ld hl, vTiles1 + $500
    ld bc, $0F01
    call FillTilesBxC
    ld hl, vTiles1 + $700
    ld bc, $0501
    call FillTilesBxC
    ld hl, vTiles1 + $4E0
    ld bc, $0201
    call FillTilesBxC
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $20
    ld [wScreenStep], a
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; address loaded by ScriptCommandEB_Run_Case05_Case3C
Data_014_4586:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $21, $00, $61, $00, $A1, $00, $E1, $00, $21, $01

; entry 62 of the `rst $00` table in ScriptCommandEB_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wTwoChoiceCursor, wScreenStep, wListCursor
; writes: wScreenStep, wScreenSubStep, wScriptCommandType, wScriptStartRequest, wTwoChoiceCursor
ScriptCommandEB_Run_Case05_Case3E::
Jump_014_4590:: ; address name
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_014_45B8
    cp a, $FF
    jp z, Jump_014_45A5
    ret

Jump_014_45A5::
    ld a, [wTwoChoiceCursor]
    cp a, $01
    jr z, Jump_014_45B8
    farcall ScriptCommandEB_Run_Case05_Case3E_Sub01
    call ScriptCommandEB_Run_Shared03
    jp Jump_014_4EA7

Jump_014_45B8::
    call ScriptCommandEB_Run_Shared02
    ld a, [wListCursor]
    ld b, $C3
    ld hl, Data_014_5B1E
    call StoreBAtWordTableEntry_Bank14
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $3B
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 63 of the `rst $00` table in ScriptCommandEB_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep, wSelectedRecord, wArg5, wArg6, wScreenStep
; writes: rRAMG2, rRAMB, wArg1, wArg2, wArg3, wArg4, wSelectedRecord, wScreenSubStep, ...
; points at: wRecordBufA, sCompactRecords, sRecords
ScriptCommandEB_Run_Case05_Case3F::
Jump_014_45DE:: ; address name
    ld a, [wScreenSubStep]
    and a, a
    jp nz, Jump_014_4630
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [wSelectedRecord]
    ld [wArg1], a
    xor a, a
    ld [rRAMG2], a
    ld [wArg2], a
    ld hl, wRecordBufA
    ld a, l
    ld [wArg3], a
    ld a, h
    ld [wArg4], a
    farcall PackRecordFieldsToBank1Slot
    ld a, [wArg5]
    cp a, $FF
    ret nz
    ld a, [wSelectedRecord]
    ld [wArg1], a
    xor a, a
    ld [wArg2], a
    farcall DeleteSRAMRecordAndCompact
    ld a, [wArg5]
    ld [wSelectedRecord], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

Jump_014_4630::
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    cp a, $1D
    jr z, Jump_014_464F
    ld c, $6F
    call Multiply8
    ld de, sCompactRecords
    add hl, de
    xor a, a
    jr Jump_014_4654

Jump_014_464F::
    ld hl, sRecords
    ld a, $01

Jump_014_4654::
    ld [wArg2], a
    push hl
    ld a, [wSelectedRecord]
    ld [wArg1], a
    pop hl
    ld a, l
    ld [wArg3], a
    ld a, h
    ld [wArg4], a
    farcall UnpackRecordFromBank1Slot
    ld a, [wArg5]
    cp a, $FF
    ret nz
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld [wArg1], a
    xor a, a
    ld [wArg2], a
    farcall ScriptCommandEB_Run_Shared05
    ld a, [wArg5]
    ld [wSelectedRecord], a
    xor a, a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 64 of the `rst $00` table in ScriptCommandEB_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wSelectedRecord
; writes: rRAMG2, rRAMB, wItemGridX, wItemGridY, wSelectedRecord, wListCursor, wChoiceCursor, wListPageIndex, ...
; points at: sCompactRecords, wRecordBufA, sRecords
ScriptCommandEB_Run_Case05_Case40::
Jump_014_46A1:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    ld a, [wSelectedRecord]
    cp a, $1D
    jr z, Jump_014_46B9
    ld c, $6F
    call Multiply8
    ld de, sCompactRecords
    add hl, de
    xor a, a
    jr Jump_014_46BE

Jump_014_46B9::
    ld hl, sRecords
    ld a, $01

Jump_014_46BE::
    ld [rRAMB], a
    ld de, wRecordBufA
    ld b, $6F

Jump_014_46C6::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_014_46C6
    xor a, a
    ld [rRAMG2], a
    xor a, a
    ld [wItemGridX], a
    ld [wItemGridY], a
    ld [wSelectedRecord], a
    farcall ListPartyRecordsWithState2ToListEntries
    call DrawBox4965AndMenuAndStep
    xor a, a
    ld [wListCursor], a
    ld [wChoiceCursor], a
    ld [wListPageIndex], a
    ld [wListCursorAux], a
    ld [wCursorBlinkAE], a
    ret

; entry 5 of the `rst $00` table in ScriptCommandEB_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; points at: wTextWindowTileLo, wScreenStep
ScriptCommandEB_Run_Case05_Case05::
Jump_014_46F4:: ; address name
    ld hl, vTiles1 + $270
    ld bc, $0901
    call FillTilesBxC
    ld hl, vTiles1 + $780
    ld bc, $0501
    call FillTilesBxC
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in ScriptCommandEB_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wListCursor, wScreenStep
; writes: wScreenStep
ScriptCommandEB_Run_Case05_Case07::
Jump_014_4718:: ; address name
    ld a, [wListCursor]
    ld b, $BB
    ld hl, Data_014_5B1E
    call StoreBAtWordTableEntry_Bank14
    call BGMapAddressAtScroll_Bank14
    ld bc, $140B
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    ld a, [wListCursor]
    ld b, $C3
    ld hl, Data_014_5B1E
    call StoreBAtWordTableEntry_Bank14
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 9 of the `rst $00` table in ScriptCommandEB_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg1, wArg2, wScreenStep
ScriptCommandEB_Run_Case05_Case09::
Jump_014_4742:: ; address name
    ld c, $0D
    ld hl, $01D4
    ld de, $0008
    xor a, a
    ld [wArg1], a
    ld a, $0C
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_Bank14
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 10 of the `rst $00` table in ScriptCommandEB_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
ScriptCommandEB_Run_Case05_Case0A::
Jump_014_475E:: ; address name
    call BGMapAddressAtScroll_Bank14
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 11 of the `rst $00` table in ScriptCommandEB_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; points at: wScreenStep
ScriptCommandEB_Run_Case05_Case0B::
Jump_014_4772:: ; address name
    ld hl, TileCopyDestList_14_5C36
    ld de, TileCopySrcList_14_5C4A
    call ScriptCommandEB_Run_Shared04
    cp a, $FF
    ret nz
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 45 of the `rst $00` table in ScriptCommandEB_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; points at: wScreenStep
ScriptCommandEB_Run_Case05_Case2D::
Jump_014_4783:: ; address name
    ld hl, TileCopyDestList_14_5C8A
    ld de, TileCopySrcList_14_5C9A
    call ScriptCommandEB_Run_Shared04
    cp a, $FF
    ret nz
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 46 of the `rst $00` table in ScriptCommandEB_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wChoiceCursor, wCursorBlinkAE, wScreenStep
ScriptCommandEB_Run_Case05_Case2E::
Jump_014_4794:: ; address name
    ld de, TileRect_14_47C0
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRows_Bank14
    call BGMapAddressAtScroll_Bank14
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    ld a, $6C
    call QueueSoundEffect
    xor a, a
    ld [wChoiceCursor], a
    ld [wCursorBlinkAE], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 5 tiles, one row per line
TileRect_14_47C0::
Data_014_47C0:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $70, $71, $72, $73, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $74, $75, $C3, $C3, $C3, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 4

; entry 47 of the `rst $00` table in ScriptCommandEB_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wScreenStep, wChoiceCursor, wScreenState
; writes: wTwoChoiceCursor, wScreenStep, wScriptCommandType, wScriptStartRequest, wScreenByteB2, wScreenByteB3, wScreenState, wScreenSubStep, ...
ScriptCommandEB_Run_Case05_Case2F::
Jump_014_47E8:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, Jump_014_4804
    bit 7, a
    jr nz, Jump_014_481E
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, Jump_014_482E
    bit 1, a
    jp nz, Jump_014_48D7
    call BlinkCursorBlinkAE_Bank14
    ret

Jump_014_4804::
    call DrawBlankTileC3_Bank14
    ld a, [wChoiceCursor]
    and a, a
    jr nz, Jump_014_4811
    ld a, $01
    jr Jump_014_4812

Jump_014_4811::
    dec a

Jump_014_4812::
    ld [wChoiceCursor], a
    call DrawCursorTileBB_Bank14
    ld a, $69
    call QueueSoundEffect
    ret

Jump_014_481E::
    call DrawBlankTileC3_Bank14
    ld a, [wChoiceCursor]
    cp a, $01
    jr c, Jump_014_482B
    xor a, a
    jr Jump_014_4812

Jump_014_482B::
    inc a
    jr Jump_014_4812

Jump_014_482E::
    ld a, $69
    call QueueSoundEffect
    call ScriptCommandEB_Run_Case05_Case2F_Sub01
    ld a, [wChoiceCursor]
    and a, a
    jp nz, Jump_014_48AC
    ld a, [wScreenState]
    cp a, $05
    jr z, Jump_014_486D
    cp a, $04
    jr z, Jump_014_4848

Jump_014_4848::
    ld a, [wScreenStep]
    cp a, $13
    jr c, Jump_014_485E
    ld a, $04
    ld [wScreenByteB2], a
    ld a, $3F
    ld [wScreenByteB3], a
    ld a, $09
    jp Jump_014_488F

Jump_014_485E::
    ld a, $04
    ld [wScreenByteB2], a
    ld a, $12
    ld [wScreenByteB3], a
    ld a, $09
    jp Jump_014_488F

Jump_014_486D::
    ld a, [wScreenStep]
    cp a, $2E
    jr c, Jump_014_4883
    ld a, $05
    ld [wScreenByteB2], a
    ld a, $2F
    ld [wScreenByteB3], a
    ld a, $09
    jp Jump_014_488F

Jump_014_4883::
    ld a, $04
    ld [wScreenByteB2], a
    ld a, $25
    ld [wScreenByteB3], a
    ld a, $09

Jump_014_488F::
    ld [wScreenState], a
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld [wTwoChoiceCursor], a
    farcall SaveAndHideSpriteState_Bank1E
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_014_48AC::
    ld a, [wScreenState]
    cp a, $04
    jr nz, Jump_014_48C0
    ld a, [wScreenStep]
    cp a, $3F
    jr nz, Jump_014_48C0
    call ScriptCommandEB_Run_Case05_Case2F_Sub03
    call ScriptCommandEB_Run_Case05_Case2F_Sub02

Jump_014_48C0::
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    add a, $03
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_014_48D7::
    ld a, $02
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; once the joypad repeat timer reaches $14, cycles wD7AE through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3) for $10-$17 (E-0122)
; 1 call site from 1 routine (e.g. ScriptCommandEB_Run_Case05_Case2F)
; reads: wJoypadRepeatTimer, wCursorBlinkAE, wChoiceCursor
; writes: wCursorBlinkAE
BlinkCursorBlinkAE_Bank14::
Func_014_48ED:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, DrawCursorTileBB_Bank14
    ld a, [wCursorBlinkAE]
    inc a
    ld [wCursorBlinkAE], a
    cp a, $10
    jr c, DrawCursorTileBB_Bank14
    cp a, $18
    jr c, DrawBlankTileC3_Bank14
    xor a, a
    ld [wCursorBlinkAE], a

; B = $BB (cursor tile) and joins the cursor draw (E-0122)
; 1 call site from 1 routine (e.g. ScriptCommandEB_Run_Case05_Case2F)
; reads: wChoiceCursor
DrawCursorTileBB_Bank14::
Func_014_4907:: ; address name
    ld b, $BB
    jr Jump_014_4911

; B = $C3 (blank tile) and joins the cursor draw (E-0122)
; 2 call sites from 1 routine (e.g. ScriptCommandEB_Run_Case05_Case2F)
; reads: wChoiceCursor
DrawBlankTileC3_Bank14::
Func_014_490B:: ; address name
    ld b, $C3
    jr Jump_014_4911

; only called from ScriptCommandEB_Run_Case05_Case2F (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandEB_Run_Case05_Case2F)
; reads: wChoiceCursor
ScriptCommandEB_Run_Case05_Case2F_Sub01::
Func_014_490F:: ; address name
    ld b, $BC

Jump_014_4911::
    ld a, [wChoiceCursor]
    add a, a
    ld hl, Data_014_492E
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank14
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; address loaded by ScriptCommandEB_Run_Case05_Case2F_Sub01
Data_014_492E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2D, $01, $6D, $01

; copies box Data_014_4965 to wC410, runs Func_014_5925, blanks the cursor entry wD7AB of Data_014_5B1E and wD781 += 1 (E-0124)
; 5 call sites from 5 routines (e.g. ScriptCommandEB_Run_Case04_Case43, ScriptCommandEB_Run_Case04_Case16, ScriptCommandEB_Run_Case04_Case15, ScriptCommandEB_Run_Case05_Case40, ...)
; reads: wListCursor, wScreenStep
; writes: wArg1, wArg2, wScreenStep
DrawBox4965AndMenuAndStep::
Func_014_4932:: ; address name
    ld de, TileRect_14_4965
    ld hl, wWindowTileBuffer + $110
    ld bc, $0801
    call CopyRectTo20ByteRows_Bank14
    ld c, $04
    ld hl, $028C
    ld de, $00C0
    xor a, a
    ld [wArg1], a
    ld a, $08
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_Bank14
    ld a, [wListCursor]
    ld b, $C3
    ld hl, Data_014_5B1E
    call StoreBAtWordTableEntry_Bank14
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 1 tiles, one row per line
TileRect_14_4965::
Data_014_4965:: ; address name
    db $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 0

; entry 27 of the `rst $00` table in ScriptCommandEB_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wGridCursorX, wScreenStep
; writes: wScreenStep, wTwoChoiceCursor
ScriptCommandEB_Run_Case05_Case1B::
Jump_014_496D:: ; address name
    ld de, Data_01F_4330
    ld hl, vTiles2 + $730
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, $6C
    call QueueSoundEffect
    ld de, TileRect_14_49AE
    ld hl, wWindowTileBuffer + $112
    ld bc, $0605
    call CopyRectTo20ByteRows_Bank14
    ld a, [wGridCursorX]
    ld b, $BC
    ld hl, Data_014_5B1E
    call StoreBAtWordTableEntry_Bank14
    call BGMapAddressAtScroll_Bank14
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 6 x 5 tiles, one row per line
TileRect_14_49AE::
Data_014_49AE:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $CE, $CF, $DF, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $EF, $73, $C3, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B5 ; id 4

; entry 28 of the `rst $00` table in ScriptCommandEB_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wTwoChoiceCursor, wScreenStep
; writes: wScreenStep, wScreenSubStep, wScriptCommandType, wScriptStartRequest, wTwoChoiceCursor, wScreenState
ScriptCommandEB_Run_Case05_Case1C::
Jump_014_49CC:: ; address name
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_014_49E0
    cp a, $FF
    jr z, Jump_014_4A00
    ret

Jump_014_49E0::
    call ScriptCommandEB_Run_Case05_Case1C_Sub01
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $01
    ld [wScreenState], a
    ld a, $03
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_014_4A00::
    ld a, [wTwoChoiceCursor]
    cp a, $01
    jr z, Jump_014_49E0
    call ScriptCommandEB_Run_Case05_Case1C_Sub01
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; only called from ScriptCommandEB_Run_Case05_Case1C (E-0047)
; 2 call sites from 1 routine (e.g. ScriptCommandEB_Run_Case05_Case1C)
; reads: wIsCGB, rSVBK
; writes: rSVBK
ScriptCommandEB_Run_Case05_Case1C_Sub01::
Func_014_4A1F:: ; address name
    ld hl, wWindowTileBuffer + $112
    ld de, wScreenTileBuffer + $AE
    ld c, $00
    call ScriptCommandEB_Run_Case05_Case1C_Sub01_Sub01
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_014_4A47
    ldh a, [rSVBK]
    set 1, a
    ldh [rSVBK], a
    ld hl, wWindowAttrBuffer + $112
    ld de, wWorkBuf + $11
    ld c, $00
    call ScriptCommandEB_Run_Case05_Case1C_Sub01_Sub01
    ldh a, [rSVBK]
    res 1, a
    ldh [rSVBK], a

Jump_014_4A47::
    call BGMapAddressAtScroll_Bank14
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    ret

; only called from ScriptCommandEB_Run_Case05_Case1C_Sub01 (E-0047)
; 2 call sites from 1 routine (e.g. ScriptCommandEB_Run_Case05_Case1C_Sub01)
ScriptCommandEB_Run_Case05_Case1C_Sub01_Sub01::
Func_014_4A54:: ; address name
    push hl
    push de
    push bc
    ld bc, $0006
    call CopyBytesDEToHL_Bank14
    pop bc
    pop de
    pop hl
    ld a, $14
    add_a_to_hl
    ld a, $14
    add a, e
    ld e, a
    jr nc, Jump_014_4A6E
    inc d

Jump_014_4A6E::
    inc c
    ld a, c
    cp a, $05
    jr c, ScriptCommandEB_Run_Case05_Case1C_Sub01_Sub01
    ret

; entry 0 of the `rst $00` table in ScriptCommandEB_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wListPageIndex, wCursorBlinkAE, wScreenStep
ScriptCommandEB_Run_Case05_Case00::
Jump_014_4A75:: ; address name
    ld de, TileRect_14_4AA8
    ld hl, wWindowTileBuffer + $64
    ld bc, $0A09
    call CopyRectTo20ByteRows_Bank14
    ld de, TileRect_14_4B02
    ld hl, wWindowTileBuffer + $64
    ld bc, $080B
    call CopyRectTo20ByteRows_Bank14
    call BGMapAddressAtScroll_Bank14
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    xor a, a
    ld [wListPageIndex], a
    ld [wCursorBlinkAE], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 10 x 9 tiles, one row per line
TileRect_14_4AA8::
Data_014_4AA8:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 8

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 11 tiles, one row per line
TileRect_14_4B02::
Data_014_4B02:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 8
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 9
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 10

; clears four tile rows (vTiles1 + $240, $500, $700, $4E0), copies rectangle Data_014_5B36 to wC364 and wD781 += 1 (E-0124)
; 1 call site from 1 routine (e.g. ScriptCommandEB_Run_Case05_Case08)
; reads: wScreenStep
; writes: wScreenStep
ClearTilesAndDrawRect5B36AndStep::
Func_014_4B5A:: ; address name
    ld hl, vTiles1 + $240
    ld bc, $0C01
    call FillTilesBxC
    ld hl, vTiles1 + $500
    ld bc, $0F01
    call FillTilesBxC
    ld hl, vTiles1 + $700
    ld bc, $0501
    call FillTilesBxC
    ld hl, vTiles1 + $4E0
    ld bc, $0201
    call FillTilesBxC
    ld de, TileRect_14_5B36
    ld hl, wWindowTileBuffer + $64
    ld bc, $080B
    call CopyRectTo20ByteRows_Bank14
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 31 of the `rst $00` table in ScriptCommandEB_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wListPages, wScreenStep
; writes: wArg1, wArg2, wScreenStep
ScriptCommandEB_Run_Case05_Case1F::
Jump_014_4B92:: ; address name
    farcall ListRecordsState1WithByte6EClear
    jr ScriptCommandEB_Run_Shared01
    db $21, $2D, $5F, $06, $1D, $D7

; only called from routines of ScriptCommandEB_Run (E-0098)
; 2 call sites from 2 routines (e.g. ScriptCommandEB_Run_Case04_Case3C, ScriptCommandEB_Run_Case05_Case3C)
; reads: wListPages, wScreenStep
; writes: wArg1, wArg2, wScreenStep
ScriptCommandEB_Run_Shared01::
Func_014_4BA0:: ; address name
    farcall ClampRecordListPageCursor5
    ld a, [wListPages]
    cp a, $02
    jr c, Jump_014_4BDB
    ld de, $0142
    call DrawC5BEC6AtScrollOffsetDE_Bank14
    ld hl, wWindowTileBuffer + $12E
    call StoreC5BEC6AtHLStride2_Bank14
    ld de, $0143
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    farcall DrawPageOfPagesAtScrollOffset
    ld hl, wWindowTileBuffer + $12F
    ld a, h
    ld [wArg1], a
    ld a, l
    ld [wArg2], a
    farcall DrawPageOfPagesAtArg1_Bank1E

Jump_014_4BDB::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 32 of the `rst $00` table in ScriptCommandEB_Run_Case05
; no direct call (reached through a table, a jump or a vector)
ScriptCommandEB_Run_Case05_Case20::
Jump_014_4BE3:: ; address name
    farcall DrawRecordListPageNames
    ret

; entry 33 of the `rst $00` table in ScriptCommandEB_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, wScreenStep
; writes: wArg1, wScreenStep
ScriptCommandEB_Run_Case05_Case21::
Jump_014_4BEA:: ; address name
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld b, a
    push af
    call LoadFamilyIconTileForRecordB_Bank14
    ld de, TileRect_14_5B8E
    ld hl, wWindowTileBuffer + $6C
    ld bc, $0C09
    call CopyRectTo20ByteRows_Bank14
    pop af
    ld [wArg1], a
    farcall DrawRecordStatsBoxForArg1
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 35 of the `rst $00` table in ScriptCommandEB_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, wScreenStep
; writes: wArg1, wScreenStep
ScriptCommandEB_Run_Case05_Case23::
Jump_014_4C1C:: ; address name
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld [wArg1], a
    farcall DrawRecordNameAndSpeciesNameTiles
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 37 of the `rst $00` table in ScriptCommandEB_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wScreenStep, wListCursor
; writes: wMenuInputResult, wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
; points at: wTextWindowTileLo
ScriptCommandEB_Run_Case05_Case25::
Jump_014_4C3C:: ; address name
    xor a, a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_014_4C60
    cp a, $FC
    jr z, Jump_014_4C60
    cp a, $FD
    jr z, Jump_014_4C9F
    cp a, $FE
    jr z, Jump_014_4C69
    cp a, $FF
    jr z, Jump_014_4C71
    ret

Jump_014_4C60::
    ld a, [wScreenStep]
    sub a, $07
    ld [wScreenStep], a
    ret

Jump_014_4C69::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

Jump_014_4C71::
    ld a, [wScreenStep]
    add a, $08
    ld [wScreenStep], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wListCursor]
    ld b, $BC
    ld hl, Data_014_5B1E
    call StoreBAtWordTableEntry_Bank14
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_014_4C9F::
    ld a, [wScreenStep]
    sub a, $04
    ld [wScreenStep], a
    ret

; entry 13 of the `rst $00` table in ScriptCommandEB_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
ScriptCommandEB_Run_Case05_Case0D::
Jump_014_4CA8:: ; address name
    ld hl, TileCopyDestList_14_5C5E
    ld de, TileCopySrcList_14_5C74
    call ScriptCommandEB_Run_Shared04
    cp a, $FF
    ret nz
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 14 of the `rst $00` table in ScriptCommandEB_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
ScriptCommandEB_Run_Case05_Case0E::
Jump_014_4CBC:: ; address name
    farcall DrawRecordListNameTiles_Bank1D
    farcall ListPartyRecordsWithState2ToListEntries
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 44 of the `rst $00` table in ScriptCommandEB_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wGridCursorX
; writes: wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
ScriptCommandEB_Run_Case05_Case2C::
Jump_014_4CD0:: ; address name
    ld de, TileRect_14_5AC4
    ld hl, wWindowTileBuffer + $64
    ld bc, $0A09
    call CopyRectTo20ByteRows_Bank14
    call RunFunc5925At0280
    ld a, [wGridCursorX]
    ld b, $C3
    ld hl, Data_014_5B1E
    call StoreBAtWordTableEntry_Bank14
    call BGMapAddressAtScroll_Bank14
    ld bc, $140B
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    farcall CountRecordsInUse
    ld a, $1B
    ld [wScreenStep], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 49 of the `rst $00` table in ScriptCommandEB_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wScriptCommandType, wScriptStartRequest
ScriptCommandEB_Run_Case05_Case31::
Jump_014_4D10:: ; address name
    call BGMapAddressAtScroll_Bank14
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    ld a, $25
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 15 of the `rst $00` table in ScriptCommandEB_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wScreenState, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
ScriptCommandEB_Run_Case05_Case0F::
Jump_014_4D2B:: ; address name
    ld de, TileRect_14_5AC4
    ld hl, wWindowTileBuffer + $64
    ld bc, $0A09
    call CopyRectTo20ByteRows_Bank14
    call RunFunc5925At0280
    call BGMapAddressAtScroll_Bank14
    ld bc, $140B
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    farcall CountRecordsInUse
    xor a, a
    ld [wScreenStep], a
    ld a, $02
    ld [wScreenState], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 4 of the `rst $00` table in ScriptCommandEB_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
ScriptCommandEB_Run_Case04::
Jump_014_4D64:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw ScriptCommandEB_Run_Case05_Case00
    dw ClearTilesAndDrawRect5B36AndStep
    dw ScriptCommandEB_Run_Case05_Case1F
    dw ScriptCommandEB_Run_Case05_Case20
    dw ScriptCommandEB_Run_Case05_Case21
    dw ScriptCommandEB_Run_Case05_Case05
    dw ScriptCommandEB_Run_Case05_Case23
    dw ScriptCommandEB_Run_Case05_Case07
    dw ScriptCommandEB_Run_Case05_Case25
    dw ScriptCommandEB_Run_Case05_Case09
    dw ScriptCommandEB_Run_Case05_Case0A
    dw ScriptCommandEB_Run_Case05_Case0B
    dw ScriptCommandEB_Run_Case05_Case00
    dw ScriptCommandEB_Run_Case05_Case0D
    dw ScriptCommandEB_Run_Case05_Case0E
    dw ScriptCommandEB_Run_Case05_Case0F
    dw ScriptCommandEB_Run_Case05_Case2D
    dw ScriptCommandEB_Run_Case05_Case2E
    dw ScriptCommandEB_Run_Case05_Case2F
    dw DrawBox4965AndMenuAndStep
    dw ScriptCommandEB_Run_Case04_Case14
    dw ScriptCommandEB_Run_Case04_Case15
    dw ScriptCommandEB_Run_Case04_Case16
    dw ScriptCommandEB_Run_Case05_Case09
    dw ScriptCommandEB_Run_Case05_Case0A
    dw ScriptCommandEB_Run_Case05_Case0B
    dw ScriptCommandEB_Run_Case05_Case00
    dw ScriptCommandEB_Run_Case05_Case0D
    dw ScriptCommandEB_Run_Case05_Case0E
    dw ScriptCommandEB_Run_Case05_Case0F
    dw ScriptCommandEB_Run_Case05_Case1B
    dw ScriptCommandEB_Run_Case05_Case1C
    dw ScriptCommandEB_Run_Case05_Case00
    dw ClearTilesAndDrawRect5B36AndStep
    dw ScriptCommandEB_Run_Case05_Case02
    dw ScriptCommandEB_Run_Case05_Case03
    dw ScriptCommandEB_Run_Case05_Case04
    dw ScriptCommandEB_Run_Case05_Case05
    dw ScriptCommandEB_Run_Case05_Case06
    dw ScriptCommandEB_Run_Case05_Case07
    dw ScriptCommandEB_Run_Case05_Case08
    dw ScriptCommandEB_Run_Case05_Case09
    dw ScriptCommandEB_Run_Case05_Case0A
    dw ScriptCommandEB_Run_Case05_Case0B
    dw ScriptCommandEB_Run_Case05_Case00
    dw ScriptCommandEB_Run_Case05_Case0D
    dw ScriptCommandEB_Run_Case05_Case0E
    dw ScriptCommandEB_Run_Case04_Case2F
    dw ScriptCommandEB_Run_Case05_Case10
    dw ScriptCommandEB_Run_Case04_Case31
    dw ScriptCommandEB_Run_Case04_Case32
    dw ScriptCommandEB_Run_Case05_Case00
    dw ClearTilesAndDrawRect5B36AndStep
    dw ScriptCommandEB_Run_Case05_Case1F
    dw ScriptCommandEB_Run_Case05_Case20
    dw ScriptCommandEB_Run_Case05_Case21
    dw ScriptCommandEB_Run_Case05_Case05
    dw ScriptCommandEB_Run_Case05_Case23
    dw ScriptCommandEB_Run_Case05_Case07
    dw ScriptCommandEB_Run_Case05_Case3B
    dw ScriptCommandEB_Run_Case04_Case3C
    dw ScriptCommandEB_Run_Case05_Case2D
    dw ScriptCommandEB_Run_Case05_Case2E
    dw ScriptCommandEB_Run_Case05_Case2F
    dw DrawBox4965AndMenuAndStep
    dw ScriptCommandEB_Run_Case04_Case41
    dw ScriptCommandEB_Run_Case04_Case42
    dw ScriptCommandEB_Run_Case04_Case43
    dw ScriptCommandEB_Run_Case05_Case09
    dw ScriptCommandEB_Run_Case05_Case0A
    dw ScriptCommandEB_Run_Case05_Case0B
    dw ScriptCommandEB_Run_Case05_Case00
    dw ScriptCommandEB_Run_Case05_Case0D
    dw ScriptCommandEB_Run_Case05_Case0E
    dw ScriptCommandEB_Run_Case05_Case0F

; entry 2 of the `rst $00` table in ScriptCommandEB_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wListPages, wScreenStep
; writes: wArg1, wArg2, wScreenStep
ScriptCommandEB_Run_Case05_Case02::
Jump_014_4DFE:: ; address name
    farcall ScriptCommandEB_Run_Shared06
    jp ScriptCommandEB_Run_Shared01

; entry 3 of the `rst $00` table in ScriptCommandEB_Run_Case05
; no direct call (reached through a table, a jump or a vector)
ScriptCommandEB_Run_Case05_Case03::
Jump_014_4E07:: ; address name
    farcall ScriptCommandEB_Run_Case05_Case03_Sub01
    ret

; entry 4 of the `rst $00` table in ScriptCommandEB_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, wScreenStep
; writes: wArg1, wScreenStep
ScriptCommandEB_Run_Case05_Case04::
Jump_014_4E0E:: ; address name
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld b, a
    push af
    ld [wArg1], a
    farcall LoadFamilyIconTileForArg1Record
    ld de, TileRect_14_5B8E
    ld hl, wWindowTileBuffer + $6C
    ld bc, $0C09
    call CopyRectTo20ByteRows_Bank14
    pop af
    ld [wArg1], a
    farcall ScriptCommandEB_Run_Case05_Case04_Sub01
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 6 of the `rst $00` table in ScriptCommandEB_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, wScreenStep
; writes: wArg1, wScreenStep
ScriptCommandEB_Run_Case05_Case06::
Jump_014_4E46:: ; address name
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld [wArg1], a
    farcall ScriptCommandEB_Run_Case05_Case06_Sub01
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 49 of the `rst $00` table in ScriptCommandEB_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wTwoChoiceCursor, wScreenStep, wListCursor
; writes: wScreenStep, wScreenSubStep, wScriptCommandType, wScriptStartRequest, wTwoChoiceCursor
ScriptCommandEB_Run_Case04_Case31::
Jump_014_4E66:: ; address name
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_014_4E7A
    cp a, $FF
    jr z, Jump_014_4EA0
    ret

Jump_014_4E7A::
    ld a, [wListCursor]
    ld b, $C3
    ld hl, Data_014_5B1E
    call StoreBAtWordTableEntry_Bank14
    call ScriptCommandEB_Run_Shared02
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $28
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_014_4EA0::
    ld a, [wTwoChoiceCursor]
    cp a, $01
    jr z, Jump_014_4E7A

Jump_014_4EA7::
    call ScriptCommandEB_Run_Shared02
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; only called from routines of ScriptCommandEB_Run (E-0098)
; 4 call sites from 3 routines (e.g. ScriptCommandEB_Run_Case04_Case31, ScriptCommandEB_Run_Case05_Case3E, ScriptCommandEB_Run_Case05_Case11)
; reads: wIsCGB, rSVBK
; writes: rSVBK
ScriptCommandEB_Run_Shared02::
Func_014_4EBF:: ; address name
    ld hl, wWindowTileBuffer + $112
    ld de, wScreenTileBuffer + $AE
    ld c, $00
    call ScriptCommandEB_Run_Shared02_Sub01
    ld hl, wWindowTileBuffer + $112
    ld de, Data_014_4F24
    ld c, $04
    call ScriptCommandEB_Run_Shared02_Sub01
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_014_4EFD
    ldh a, [rSVBK]
    set 1, a
    ldh [rSVBK], a
    ld hl, wWindowAttrBuffer + $112
    ld de, wWorkBuf + $11
    ld c, $00
    call ScriptCommandEB_Run_Shared02_Sub01
    ld hl, wWindowAttrBuffer + $112
    ld de, Data_014_4F2A
    ld c, $04
    call ScriptCommandEB_Run_Shared02_Sub01
    ldh a, [rSVBK]
    res 1, a
    ldh [rSVBK], a

Jump_014_4EFD::
    call BGMapAddressAtScroll_Bank14
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    ld de, Data_01F_4130
    ld hl, vTiles2 + $700
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4320
    ld hl, vTiles2 + $710
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ret

; address loaded by ScriptCommandEB_Run_Shared02
Data_014_4F24:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B4, $B4, $B4, $B4, $B4, $B5

; address loaded by ScriptCommandEB_Run_Shared02
Data_014_4F2A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $00, $00

; only called from ScriptCommandEB_Run_Shared02 (E-0047)
; 4 call sites from 1 routine (e.g. ScriptCommandEB_Run_Shared02)
ScriptCommandEB_Run_Shared02_Sub01::
Func_014_4F30:: ; address name
    push hl
    push de
    push bc
    ld bc, $0006
    call CopyBytesDEToHL_Bank14
    pop bc
    pop de
    pop hl
    ld a, $14
    add_a_to_hl
    ld a, $14
    add a, e
    ld e, a
    jr nc, Jump_014_4F4A
    inc d

Jump_014_4F4A::
    inc c
    ld a, c
    cp a, $05
    jr c, ScriptCommandEB_Run_Shared02_Sub01
    ret

; entry 16 of the `rst $00` table in ScriptCommandEB_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep, wTwoChoiceCursor
ScriptCommandEB_Run_Case05_Case10::
Jump_014_4F51:: ; address name
    ld de, Data_01F_4330
    ld hl, vTiles2 + $730
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, $6C
    call QueueSoundEffect
    ld de, TileRect_14_4FAE
    ld hl, wWindowTileBuffer + $112
    ld bc, $0605
    call CopyRectTo20ByteRows_Bank14
    ld de, Data_01F_4230
    ld hl, vTiles2 + $700
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4290
    ld hl, vTiles2 + $710
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4180
    ld hl, vTiles2 + $760
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    call BGMapAddressAtScroll_Bank14
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 6 x 5 tiles, one row per line
TileRect_14_4FAE::
Data_014_4FAE:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $70, $71, $DF, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $76, $73, $C3, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B5 ; id 4

; entry 60 of the `rst $00` table in ScriptCommandEB_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wItemGridX, wItemGridY
; writes: wListCursor, wListPageIndex, wTwoChoiceCursor, wScreenStep, wScriptCommandType, wScriptStartRequest
; points at: wTextWindowTileLo
ScriptCommandEB_Run_Case04_Case3C::
Jump_014_4FCC:: ; address name
    ld a, [wItemGridX]
    ld [wListCursor], a
    ld a, [wItemGridY]
    ld [wListPageIndex], a
    farcall ScriptCommandEB_Run_Shared06
    call ScriptCommandEB_Run_Shared01
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $20
    ld [wScreenStep], a
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 18 of the `rst $00` table in ScriptCommandEB_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, wArg1, wArg2, wArg3, wArg4, wScreenStep
; writes: rRAMG2, rRAMB, wArg2, wArg3, wArg4, wArg1, wListEntries2, wScreenByteBF, ...
; points at: sCompactRecords, sRecords
ScriptCommandEB_Run_Case05_Case12::
Jump_014_5002:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    cp a, $1D
    jr nc, Jump_014_502A
    ld c, $6F
    call Multiply8
    ld de, sCompactRecords
    add hl, de
    xor a, a
    jr Jump_014_502F

Jump_014_502A::
    ld hl, sRecords
    ld a, $01

Jump_014_502F::
    ld [wArg2], a
    ld a, l
    ld [wArg3], a
    ld a, h
    ld [wArg4], a
    ld hl, sRecords
    ld c, $00

Jump_014_503F::
    ld a, [hl]
    cp a, $01
    jr z, Jump_014_504A
    cp a, $02
    jr z, Jump_014_504A
    jr Jump_014_506D

Jump_014_504A::
    ld a, $A5
    add_a_to_hl
    inc c
    ld a, c
    cp a, $1E
    jr c, Jump_014_503F
    xor a, a
    ld [rRAMG2], a
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_014_506D::
    ld a, c
    ld [wArg1], a
    xor a, a
    ld [rRAMG2], a
    ld a, [wArg1]
    ld [wListEntries2], a
    ld a, [wArg2]
    ld [wScreenByteBF], a
    ld a, [wArg3]
    ld [wScreenByteC0], a
    ld a, [wArg4]
    ld [wScreenByteC1], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 19 of the `rst $00` table in ScriptCommandEB_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wListEntries2, wScreenByteBF, wScreenByteC0, wScreenByteC1, wArg5, wArg6, wScreenStep
; writes: wArg1, wArg2, wArg3, wArg4, rRAMG2, rRAMB, wScreenStep, wScriptCommandType, ...
ScriptCommandEB_Run_Case05_Case13::
Jump_014_5095:: ; address name
    ld a, [wListEntries2]
    ld [wArg1], a
    ld a, [wScreenByteBF]
    ld [wArg2], a
    ld a, [wScreenByteC0]
    ld [wArg3], a
    ld a, [wScreenByteC1]
    ld [wArg4], a
    farcall UnpackRecordFromBank1Slot
    ld a, [wArg5]
    cp a, $FF
    ret nz
    ld a, $0A
    ld [rRAMG2], a
    ld a, [wScreenByteBF]
    ld [rRAMB], a
    ld a, [wScreenByteC0]
    ld l, a
    ld a, [wScreenByteC1]
    ld h, a
    ld b, $6F

Jump_014_50CE::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_014_50CE
    xor a, a
    ld [rRAMG2], a
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld [wArg1], a
    xor a, a
    ld [wArg2], a
    farcall ScriptCommandEB_Run_Shared05
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 20 of the `rst $00` table in ScriptCommandEB_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wScriptCommandType, wScriptStartRequest
ScriptCommandEB_Run_Case04_Case14::
Jump_014_5104:: ; address name
    call BGMapAddressAtScroll_Bank14
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    ld a, $08
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 21 of the `rst $00` table in ScriptCommandEB_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, wScreenStep
; writes: rRAMG2, rRAMB, wScreenStep, wListCursor, wChoiceCursor, wListPageIndex, wListCursorAux, wCursorBlinkAE
ScriptCommandEB_Run_Case04_Case15::
Jump_014_511F:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    push hl
    call ScriptCommandEB_Run_Case04_Case15_Sub01
    pop hl
    cp a, $FF
    jr z, Jump_014_514B
    xor a, a
    ld [rRAMG2], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

Jump_014_514B::
    xor a, a
    ld [rRAMG2], a
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    farcall ListPartyRecordsWithState2ToListEntries
    call DrawBox4965AndMenuAndStep
    xor a, a
    ld [wListCursor], a
    ld [wChoiceCursor], a
    ld [wListPageIndex], a
    ld [wListCursorAux], a
    ld [wCursorBlinkAE], a
    ret

; entry 22 of the `rst $00` table in ScriptCommandEB_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, wArg7, wListPageIndex, wListCursor
; writes: wArg2, wArg3, wArg4, wArg1, rRAMG2, rRAMB, wListCursor, wChoiceCursor, ...
; points at: wListEntries
ScriptCommandEB_Run_Case04_Case16::
Jump_014_5171:: ; address name
    ld a, [wArg5]
    ld [wArg2], a
    ld a, [wArg6]
    ld [wArg3], a
    ld a, [wArg7]
    ld [wArg4], a
    ld a, [wListPageIndex]
    ld b, a
    add a, a
    add a, a
    add a, b
    ld b, a
    ld a, [wListCursor]
    add a, b
    ld hl, wListEntries
    add_a_to_hl
    ld a, [hl]
    ld [wArg1], a
    farcall PackRecordFieldsToBank1Slot
    ld a, [wArg5]
    cp a, $FF
    ret nz
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld [wArg1], a
    xor a, a
    ld [rRAMG2], a
    ld [wArg2], a
    farcall DeleteSRAMRecordAndCompact
    farcall ListPartyRecordsWithState2ToListEntries
    call DrawBox4965AndMenuAndStep
    xor a, a
    ld [wListCursor], a
    ld [wChoiceCursor], a
    ld [wListPageIndex], a
    ld [wListCursorAux], a
    ld [wCursorBlinkAE], a
    ret

; entry 8 of the `rst $00` table in ScriptCommandEB_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wListCursor, wScreenStep
; writes: wMenuInputResult, wTwoChoiceCursor, wScreenStep, wScriptCommandType, wScriptStartRequest
ScriptCommandEB_Run_Case05_Case08::
Jump_014_51E9:: ; address name
    xor a, a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_014_520D
    cp a, $FC
    jr z, Jump_014_520D
    cp a, $FD
    jr z, Jump_014_5219
    cp a, $FE
    jr z, Jump_014_5222
    cp a, $FF
    jr z, Jump_014_5238
    ret

Jump_014_520D::
    call ClearTilesAndDrawRect5B36AndStep
    ld a, [wScreenStep]
    sub a, $07
    ld [wScreenStep], a
    ret

Jump_014_5219::
    ld a, [wScreenStep]
    sub a, $04
    ld [wScreenStep], a
    ret

Jump_014_5222::
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_014_5238::
    call EraseFiveEntriesOf5B1E
    ld a, [wListCursor]
    ld b, $BC
    ld hl, Data_014_5B1E
    call StoreBAtWordTableEntry_Bank14
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    add a, $08
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 47 of the `rst $00` table in ScriptCommandEB_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wGridCursorX
; writes: wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
ScriptCommandEB_Run_Case04_Case2F::
Jump_014_525C:: ; address name
    ld de, TileRect_14_5AC4
    ld hl, wWindowTileBuffer + $64
    ld bc, $0A09
    call CopyRectTo20ByteRows_Bank14
    call RunFunc5925At0280
    ld a, [wGridCursorX]
    ld b, $C3
    ld hl, Data_014_5B1E
    call StoreBAtWordTableEntry_Bank14
    call BGMapAddressAtScroll_Bank14
    ld bc, $140B
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    farcall CountRecordsInUse
    ld a, $1E
    ld [wScreenStep], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 50 of the `rst $00` table in ScriptCommandEB_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep, wListCursor, wArg5, wArg6, wListPageIndex
; writes: wScreenStep, wItemGridX, wSelectedRecord, wItemGridY, wListCursor, wListPageIndex, wScriptCommandType, wScriptStartRequest
ScriptCommandEB_Run_Case04_Case32::
Jump_014_529C:: ; address name
    call BGMapAddressAtScroll_Bank14
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, [wListCursor]
    ld [wItemGridX], a
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld [wSelectedRecord], a
    ld a, [wListPageIndex]
    ld [wItemGridY], a
    xor a, a
    ld [wListCursor], a
    ld [wListPageIndex], a
    farcall ListRecordsState1WithByte6EClear
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 59 of the `rst $00` table in ScriptCommandEB_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wScreenStep, wListCursor, wScreenState
; writes: wMenuInputResult, wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
; points at: wTextWindowTileLo
ScriptCommandEB_Run_Case05_Case3B::
Jump_014_52E4:: ; address name
    xor a, a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_014_5308
    cp a, $FC
    jr z, Jump_014_5308
    cp a, $FD
    jr z, Jump_014_5368
    cp a, $FE
    jr z, Jump_014_5311
    cp a, $FF
    jr z, Jump_014_533A
    ret

Jump_014_5308::
    ld a, [wScreenStep]
    sub a, $07
    ld [wScreenStep], a
    ret

Jump_014_5311::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, [wScreenState]
    cp a, $04
    jr z, Jump_014_532E
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_014_532E::
    ld a, [wListCursor]
    ld b, $BC
    ld hl, Data_014_5B1E
    call StoreBAtWordTableEntry_Bank14
    ret

Jump_014_533A::
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wListCursor]
    ld b, $BC
    ld hl, Data_014_5B1E
    call StoreBAtWordTableEntry_Bank14
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_014_5368::
    ld a, [wScreenStep]
    sub a, $04
    ld [wScreenStep], a
    ret

; entry 65 of the `rst $00` table in ScriptCommandEB_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wScriptCommandType, wScriptStartRequest
ScriptCommandEB_Run_Case04_Case41::
Jump_014_5371:: ; address name
    call BGMapAddressAtScroll_Bank14
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    ld a, $3B
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 66 of the `rst $00` table in ScriptCommandEB_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep, wArg5, wArg6, wSelectedRecord, wScreenStep
; writes: rRAMG2, rRAMB, wArg1, wArg2, wArg3, wArg4, wScreenSubStep, wSelectedRecord, ...
; points at: wRecordBufA, sCompactRecords, sRecords
ScriptCommandEB_Run_Case04_Case42::
Jump_014_538C:: ; address name
    ld a, [wScreenSubStep]
    and a, a
    jp nz, Jump_014_53EC
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    push af
    ld [wArg1], a
    xor a, a
    ld [rRAMG2], a
    ld [wArg2], a
    ld hl, wRecordBufA
    ld a, l
    ld [wArg3], a
    ld a, h
    ld [wArg4], a
    farcall PackRecordFieldsToBank1Slot
    ld a, [wArg5]
    cp a, $FF
    jr z, Jump_014_53D0
    pop af
    ret

Jump_014_53D0::
    pop af
    ld [wArg1], a
    xor a, a
    ld [wArg2], a
    farcall DeleteSRAMRecordAndCompact
    ld a, [wArg5]
    ld [wArg1], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

Jump_014_53EC::
    ld a, [wSelectedRecord]
    cp a, $1D
    jr z, Jump_014_53FF
    ld c, $6F
    call Multiply8
    ld de, sCompactRecords
    add hl, de
    xor a, a
    jr Jump_014_5404

Jump_014_53FF::
    ld hl, sRecords
    ld a, $01

Jump_014_5404::
    ld [wArg2], a
    push hl
    pop hl
    ld a, l
    ld [wArg3], a
    ld a, h
    ld [wArg4], a
    farcall UnpackRecordFromBank1Slot
    ld a, [wArg5]
    cp a, $FF
    ret nz
    ld a, [wSelectedRecord]
    ld [wArg1], a
    xor a, a
    ld [wArg2], a
    farcall ScriptCommandEB_Run_Shared05
    ld a, [wArg5]
    ld [wSelectedRecord], a
    xor a, a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 67 of the `rst $00` table in ScriptCommandEB_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wSelectedRecord
; writes: rRAMG2, rRAMB, wItemGridX, wItemGridY, wSelectedRecord, wListCursor, wChoiceCursor, wListPageIndex, ...
; points at: sCompactRecords, wRecordBufA, sRecords
ScriptCommandEB_Run_Case04_Case43::
Jump_014_543F:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    ld a, [wSelectedRecord]
    cp a, $1D
    jr z, Jump_014_5457
    ld c, $6F
    call Multiply8
    ld de, sCompactRecords
    add hl, de
    xor a, a
    jr Jump_014_545C

Jump_014_5457::
    ld hl, sRecords
    ld a, $01

Jump_014_545C::
    ld [rRAMB], a
    ld de, wRecordBufA
    ld b, $6F

Jump_014_5464::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_014_5464
    xor a, a
    ld [rRAMG2], a
    xor a, a
    ld [wItemGridX], a
    ld [wItemGridY], a
    ld [wSelectedRecord], a
    farcall ListPartyRecordsWithState2ToListEntries
    call DrawBox4965AndMenuAndStep
    xor a, a
    ld [wListCursor], a
    ld [wChoiceCursor], a
    ld [wListPageIndex], a
    ld [wListCursorAux], a
    ld [wCursorBlinkAE], a
    ret

; entry 6 of the `rst $00` table in ScriptCommandEB_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
ScriptCommandEB_Run_Case06::
Jump_014_5492:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw ScriptCommandEB_Run_Case05_Case00
    dw ClearTilesAndDrawRect5B36AndStep
    dw ScriptCommandEB_Run_Case05_Case1F
    dw ScriptCommandEB_Run_Case05_Case20
    dw ScriptCommandEB_Run_Case06_Case04
    dw ScriptCommandEB_Run_Case05_Case05
    dw ScriptCommandEB_Run_Case05_Case23
    dw ScriptCommandEB_Run_Case05_Case07
    dw ScriptCommandEB_Run_Case06_Case08
    dw ScriptCommandEB_Run_Case05_Case09
    dw ScriptCommandEB_Run_Case05_Case0A
    dw ScriptCommandEB_Run_Case05_Case0B
    dw ScriptCommandEB_Run_Case05_Case00
    dw ScriptCommandEB_Run_Case05_Case0D
    dw ScriptCommandEB_Run_Case05_Case0E
    dw ScriptCommandEB_Run_Case05_Case0F
    dw ScriptCommandEB_Run_Case06_Case10

; entry 4 of the `rst $00` table in ScriptCommandEB_Run_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, wScreenStep
; writes: wArg1, wScreenStep
ScriptCommandEB_Run_Case06_Case04::
Jump_014_54B8:: ; address name
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld b, a
    call LoadFamilyIconTileForRecordB_Bank14
    ld de, TileRect_14_5B8E
    ld hl, wWindowTileBuffer + $6C
    ld bc, $0C09
    call CopyRectTo20ByteRows_Bank14
    xor a, a
    ld [wArg1], a
    farcall MarkPartyMembersInRecordListPage
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld [wArg1], a
    farcall DrawRecordStatsBoxForArg1
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 8 of the `rst $00` table in ScriptCommandEB_Run_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wScreenStep, wListCursor
; writes: wMenuInputResult, wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
; points at: wTextWindowTileLo
ScriptCommandEB_Run_Case06_Case08::
Jump_014_5501:: ; address name
    xor a, a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_014_5525
    cp a, $FC
    jr z, Jump_014_5525
    cp a, $FD
    jr z, Jump_014_5564
    cp a, $FE
    jr z, Jump_014_552E
    cp a, $FF
    jr z, Jump_014_5536
    ret

Jump_014_5525::
    ld a, [wScreenStep]
    sub a, $07
    ld [wScreenStep], a
    ret

Jump_014_552E::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

Jump_014_5536::
    ld a, [wScreenStep]
    add a, $08
    ld [wScreenStep], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wListCursor]
    ld b, $BC
    ld hl, Data_014_5B1E
    call StoreBAtWordTableEntry_Bank14
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_014_5564::
    ld a, [wScreenStep]
    sub a, $04
    ld [wScreenStep], a
    ret

; runs Func_014_5925 (C = 9, HL = $01D4, DE = 8, wD7F1/2 = 0/$0C), copies the 11 x 1 rectangle Data_014_5595 to wC40D and wD781 += 1 (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg1, wArg2, wScreenStep
DrawBox1D4AndCopyRect5595:: ; heuristic: follows a terminator; C0
Func_014_556D:: ; address name
    ld c, $09
    ld hl, $01D4
    ld de, $0008
    xor a, a
    ld [wArg1], a
    ld a, $0C
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_Bank14
    ld de, TileRect_14_5595
    ld hl, wWindowTileBuffer + $10D
    ld bc, $0B01
    call CopyRectTo20ByteRows_Bank14
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 11 x 1 tiles, one row per line
TileRect_14_5595::
Data_014_5595:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0

; entry 16 of the `rst $00` table in ScriptCommandEB_Run_Case06
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenByteB2, wScreenByteB3, wScreenStep, wScreenSubStep, wScreenState
ScriptCommandEB_Run_Case06_Case10::
Jump_014_55A0:: ; address name
    ld hl, TileCopyDestList_14_5C8A
    ld de, TileCopySrcList_14_5C9A
    call ScriptCommandEB_Run_Shared04
    cp a, $FF
    ret nz
    ld a, $06
    ld [wScreenByteB2], a
    ld a, $08
    ld [wScreenByteB3], a
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $09
    ld [wScreenState], a
    farcall SaveAndHideSpriteState_Bank1E
    ret

; entry 7 of the `rst $00` table in ScriptCommandEB_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
ScriptCommandEB_Run_Case07::
Jump_014_55C9:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw ScriptCommandEB_Run_Case05_Case00
    dw ClearTilesAndDrawRect5B36AndStep
    dw ScriptCommandEB_Run_Case05_Case02
    dw ScriptCommandEB_Run_Case05_Case03
    dw ScriptCommandEB_Run_Case05_Case04
    dw ScriptCommandEB_Run_Case05_Case05
    dw ScriptCommandEB_Run_Case05_Case06
    dw ScriptCommandEB_Run_Case05_Case07
    dw ScriptCommandEB_Run_Case05_Case08
    dw ScriptCommandEB_Run_Case05_Case09
    dw ScriptCommandEB_Run_Case05_Case0A
    dw ScriptCommandEB_Run_Case05_Case0B
    dw ScriptCommandEB_Run_Case05_Case00
    dw ScriptCommandEB_Run_Case05_Case0D
    dw ScriptCommandEB_Run_Case05_Case0E
    dw ScriptCommandEB_Run_Case05_Case0F
    dw ScriptCommandEB_Run_Case05_Case10
    dw ScriptCommandEB_Run_Case05_Case11
    dw ScriptCommandEB_Run_Case07_Case12
    dw ScriptCommandEB_Run_Case05_Case09
    dw ScriptCommandEB_Run_Case05_Case0A
    dw ScriptCommandEB_Run_Case05_Case0B
    dw ScriptCommandEB_Run_Case05_Case00
    dw ScriptCommandEB_Run_Case05_Case0D
    dw ScriptCommandEB_Run_Case05_Case0E
    dw ScriptCommandEB_Run_Case05_Case0F

; entry 17 of the `rst $00` table in ScriptCommandEB_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wTwoChoiceCursor, wScreenStep, wListCursor
; writes: wScreenStep, wScreenSubStep, wScriptCommandType, wScriptStartRequest, wTwoChoiceCursor
ScriptCommandEB_Run_Case05_Case11::
Jump_014_5601:: ; address name
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_014_5623
    cp a, $FF
    jp z, Jump_014_5616
    ret

Jump_014_5616::
    ld a, [wTwoChoiceCursor]
    cp a, $01
    jr z, Jump_014_5623
    call ScriptCommandEB_Run_Shared03
    jp Jump_014_4EA7

Jump_014_5623::
    call ScriptCommandEB_Run_Shared02
    ld a, [wListCursor]
    ld b, $C3
    ld hl, Data_014_5B1E
    call StoreBAtWordTableEntry_Bank14
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $08
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 18 of the `rst $00` table in ScriptCommandEB_Run_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, wScreenStep
; writes: rRAMG2, rRAMB, wArg1, wArg2, wScreenStep
; points at: sCompactRecords, sRecords
ScriptCommandEB_Run_Case07_Case12::
Jump_014_5649:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    cp a, $1D
    jr z, Jump_014_566D
    ld c, $6F
    call Multiply8
    ld de, sCompactRecords
    add hl, de
    xor a, a
    jr Jump_014_5672

Jump_014_566D::
    ld hl, sRecords
    ld a, $01

Jump_014_5672::
    ld [rRAMB], a
    ld b, $6F

Jump_014_5677::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_014_5677
    xor a, a
    ld [rRAMG2], a
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld [wArg1], a
    xor a, a
    ld [wArg2], a
    farcall ScriptCommandEB_Run_Shared05
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 8 of the `rst $00` table in ScriptCommandEB_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wAreaGraphicsIndex
ScriptCommandEB_Run_Case08::
Jump_014_56A4:: ; address name
    ld a, $01
    ld [wAreaGraphicsIndex], a
    farcall ScriptCommandE8_Run
    ret

; only called from ScriptCommandEB_Run_Case05_Case32 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandEB_Run_Case05_Case32)
; writes: rRAMG2, rRAMB, wNameGlyphBuf
; points at: wNameGlyphBuf, wTextBuf0
ScriptCommandEB_Run_Case05_Case32_Sub01::
Func_014_56B0:: ; address name
    push bc
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, b
    ld a, [hl]
    ld c, $01
    call CopyRecordNameToNameGlyphBuf
    ld a, $F0
    ld [wNameGlyphBuf + $A], a
    xor a, a
    ld [rRAMG2], a
    ld hl, wNameGlyphBuf
    ld de, wTextBuf0
    pop bc
    ld a, c
    add a, e
    ld e, a
    jr nc, Jump_014_56D7
    inc d

Jump_014_56D7::
    ld c, $00

Jump_014_56D9::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_014_56E7
    ld [de], a
    inc hl
    inc de
    inc c
    ld a, c
    cp a, $0A
    jr c, Jump_014_56D9

Jump_014_56E7::
    ld a, $F0
    ld [de], a
    ret

; only called from routines of ScriptCommandEB_Run (E-0098)
; 2 call sites from 2 routines (e.g. ScriptCommandEB_Run_Case05_Case3E, ScriptCommandEB_Run_Case05_Case11)
; reads: wArg5, wArg6, wTextBuf1
; writes: wArg2, wArg3, wArg4, wArg1, wNameGlyphBuf, wTextBuf1
; points at: sCompactRecords, wNameGlyphBuf, wTextBuf1, sRecords
ScriptCommandEB_Run_Shared03::
Func_014_56EB:: ; address name
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    cp a, $1D
    jr z, Jump_014_570A
    ld c, $6F
    call Multiply8
    ld de, sCompactRecords
    add hl, de
    xor a, a
    jr Jump_014_570F

Jump_014_570A::
    ld hl, sRecords
    ld a, $01

Jump_014_570F::
    ld [wArg2], a
    ld a, l
    ld [wArg3], a
    ld a, h
    ld [wArg4], a
    xor a, a
    ld [wArg1], a
    farcall LoadRecordNameEntry0
    ld a, $F0
    ld [wNameGlyphBuf + $A], a
    ld hl, wNameGlyphBuf
    ld de, wTextBuf1
    ld c, $00

Jump_014_5731::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_014_573F
    ld [de], a
    inc hl
    inc de
    inc c
    ld a, c
    cp a, $0A
    jr c, Jump_014_5731

Jump_014_573F::
    ld a, $F0
    ld [de], a
    ld a, [wTextBuf1]
    cp a, $E0
    ret c
    ld a, $F0
    ld [wTextBuf1], a
    ret

; only called from ScriptCommandEB_Run_Case05_Case2F (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandEB_Run_Case05_Case2F)
; reads: wArg5, wArg6
; writes: rRAMG2, rRAMB, wNameGlyphBuf
; points at: wNameGlyphBuf, wTextBuf1
ScriptCommandEB_Run_Case05_Case2F_Sub02::
Func_014_574E:: ; address name
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, $01
    call CopyRecordNameToNameGlyphBuf
    ld a, $F0
    ld [wNameGlyphBuf + $A], a
    xor a, a
    ld [rRAMG2], a
    ld hl, wNameGlyphBuf
    ld de, wTextBuf1
    ld c, $00

Jump_014_577C::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_014_578A
    ld [de], a
    inc hl
    inc de
    inc c
    ld a, c
    cp a, $0A
    jr c, Jump_014_577C

Jump_014_578A::
    ld a, $F0
    ld [de], a
    ret

; only called from ScriptCommandEB_Run_Case05_Case2F (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandEB_Run_Case05_Case2F)
; reads: wSelectedRecord, wTextBuf0
; writes: wArg2, wArg3, wArg4, wArg1, wNameGlyphBuf, wTextBuf0
; points at: sCompactRecords, wNameGlyphBuf, wTextBuf0, sRecords
ScriptCommandEB_Run_Case05_Case2F_Sub03::
Func_014_578E:: ; address name
    ld a, [wSelectedRecord]
    cp a, $1D
    jr z, Jump_014_57A1
    ld c, $6F
    call Multiply8
    ld de, sCompactRecords
    add hl, de
    xor a, a
    jr Jump_014_57A6

Jump_014_57A1::
    ld hl, sRecords
    ld a, $01

Jump_014_57A6::
    ld [wArg2], a
    ld a, l
    ld [wArg3], a
    ld a, h
    ld [wArg4], a
    xor a, a
    ld [wArg1], a
    farcall LoadRecordNameEntry0
    ld a, $F0
    ld [wNameGlyphBuf + $A], a
    ld hl, wNameGlyphBuf
    ld de, wTextBuf0
    ld c, $00

Jump_014_57C8::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_014_57D6
    ld [de], a
    inc hl
    inc de
    inc c
    ld a, c
    cp a, $0A
    jr c, Jump_014_57C8

Jump_014_57D6::
    ld a, $F0
    ld [de], a
    ld a, [wTextBuf0]
    cp a, $E0
    ret c
    ld a, $F0
    ld [wTextBuf0 + $2], a
    ret

; DE = source, HL = destination, BC = count: copies BC bytes (BC = 0 copies 65536); DE and HL end past the copy; clobbers A, BC = 0 (E-0064) (the same 9 bytes appear in 13 banks)
; 5 call sites from 5 routines (e.g. ScriptCommandEC_Run_Case00, ScriptCommandEB_Run_Case00, CopyScreenBufferRectWithAttrs_Bank14, ScriptCommandEB_Run_Shared02_Sub01, ...)
CopyBytesDEToHL_Bank14::
Func_014_57E5:: ; address name
    ld a, [de]
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, CopyBytesDEToHL_Bank14
    ret

; With rSVBK = 2, copies BC bytes from [DE] to [HL], each ANDed with $07; then rSVBK = 0 (the same 18 bytes appear in 7 banks)
; 3 call sites from 3 routines (e.g. ScriptCommandEC_Run_Case00, ScriptCommandEB_Run_Case00, CopyScreenBufferRectWithAttrs_Bank14)
; writes: rSVBK
CopyLow3BitsToWRAMBank2_Bank14::
Func_014_57EE:: ; address name
    ld a, $02
    ldh [rSVBK], a

Jump_014_57F2::
    ld a, [de]
    and a, $07
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_014_57F2
    xor a, a
    ldh [rSVBK], a
    ret

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX, hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
; 21 call sites from 21 routines (e.g. ScriptCommandEC_Run_Case00, ScriptCommandEB_Run_Case02_Sub04, ScriptCommandEB_Run_Case01_Case03, ScriptCommandEB_Run_Case04_Case41, ...)
; reads: hScrollY, hScrollX
BGMapAddressAtScroll_Bank14::
Func_014_5800:: ; address name
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

; Copies a rectangle of B bytes by C rows from [DE] to [HL], rows 20 ($14) bytes apart; on CGB it then zero-fills the same-shaped rectangle at HL + $0E68 with rSVBK = 2 and restores rSVBK = 0 (the same 58 bytes appear in 8 banks)
; 15 call sites from 14 routines (e.g. ScriptCommandEB_Run_Case01_Case03, ScriptCommandEB_Run_Case04_Case2F, DrawBox4965AndMenuAndStep, ScriptCommandEB_Run_Case05_Case2E, ...)
; reads: wIsCGB
; writes: rSVBK
CopyRectTo20ByteRows_Bank14::
Func_014_5821:: ; address name
    push hl
    push bc

Jump_014_5823::
    push bc
    push hl

Jump_014_5825::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_014_5825
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_014_5823
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

Jump_014_5847::
    push bc
    push hl

Jump_014_5849::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_014_5849
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_014_5847
    xor a, a
    ldh [rSVBK], a
    ret

; DE = offset into wScreenTileBuffer, B = width, C = rows, HL = BG map address: CopyRectToBGMapWrapped from wScreenTileBuffer + DE; on CGB the same rectangle is then copied from wD000 + DE (rSVBK = 2) into VRAM bank 1, the attributes; on DMG BC, DE and HL are kept. wC554/wC555 = HL + $1C1 (E-0062)
; 17 call sites from 17 routines (e.g. ScriptCommandEC_Run_Case00, ScriptCommandEB_Run_Case01_Case03, ScriptCommandEB_Run_Case04_Case41, ScriptCommandEB_Run_Case04_Case32, ...)
; reads: wIsCGB
; writes: wTextCursorLo, wTextCursorHi, rVBK, rSVBK
; points at: wScreenTileBuffer, wScreenAttrBuffer
DrawScreenBufferRect_Bank14::
Func_014_585B:: ; address name
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
    pop hl
    pop bc
    pop de
    ld a, [wIsCGB]
    or a, a
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

; only called from routines of ScriptCommandEB_Run (E-0098)
; 5 call sites from 5 routines (e.g. ScriptCommandEB_Run_Case01_Case01, ScriptCommandEB_Run_Case05_Case2D, ScriptCommandEB_Run_Case06_Case10, ScriptCommandEB_Run_Case05_Case0D, ...)
; reads: wGlyphListStart, wGlyphListPos
; writes: wGlyphListPos, wGlyphListStart
ScriptCommandEB_Run_Shared04::
Func_014_5898:: ; address name
    xor a, a
    ld [wGlyphListPos], a

Jump_014_589C::
    push hl
    push de
    ld a, [wGlyphListStart]
    add a, a
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    jp z, Jump_014_58E2
    ld e, a
    inc hl
    ld h, [hl]
    ld l, e
    pop de
    push de
    push hl
    ld a, [wGlyphListStart]
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_014_58BD
    inc d

Jump_014_58BD::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld d, a
    ld a, l
    ld e, a
    pop hl
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    pop de
    pop hl
    ld a, [wGlyphListStart]
    inc a
    ld [wGlyphListStart], a
    ld a, [wGlyphListPos]
    inc a
    ld [wGlyphListPos], a
    cp a, $08
    jr c, Jump_014_589C
    xor a, a
    ret

Jump_014_58E2::
    pop de
    pop hl
    xor a, a
    ld [wGlyphListStart], a
    ld [wGlyphListPos], a
    ld a, $FF
    ret

; stores tile $C3 at the addresses of entries 0-4 of the word table Data_014_5B1E (E-0122)
; 2 call sites from 2 routines (e.g. ScriptCommandEB_Run_Case05_Case3C, ScriptCommandEB_Run_Case05_Case08)
EraseFiveEntriesOf5B1E::
Func_014_58EE:: ; address name
    ld c, $00

Jump_014_58F0::
    push bc
    ld a, c
    ld b, $C3
    ld hl, Data_014_5B1E
    call StoreBAtWordTableEntry_Bank14
    pop bc
    inc c
    ld a, c
    cp a, $05
    jr c, Jump_014_58F0
    ret

; HL = table of 16-bit addresses, A = index: stores B at the address in entry A; keeps BC; clobbers A, DE, HL (the same 14 bytes appear in 8 banks)
; 16 call sites from 14 routines (e.g. ScriptCommandEB_Run_Case02, ScriptCommandEB_Run_Case04_Case31, ScriptCommandEB_Run_Case04_Case2F, ScriptCommandEB_Run_Case05_Case3E, ...)
StoreBAtWordTableEntry_Bank14::
Func_014_5902:: ; address name
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

; runs Func_014_5925 with C = 2, HL = $0280, DE = $00B4, wD7F1/2 = 0/8 (E-0122)
; 4 call sites from 4 routines (e.g. ScriptCommandEB_Run_Case01_Case03, ScriptCommandEB_Run_Case04_Case2F, ScriptCommandEB_Run_Case05_Case2C, ScriptCommandEB_Run_Case05_Case0F)
; writes: wArg1, wArg2
RunFunc5925At0280::
Func_014_5910:: ; address name
    ld c, $02
    ld hl, $0280
    ld de, $00B4
    xor a, a
    ld [wArg1], a
    ld a, $08
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_Bank14
    ret

; copies a wD7F1 x wD7F2 block inside the screen buffer from offset DE to offset HL, C rows, with CGB attributes (E-0127)
; 4 call sites from 4 routines (e.g. RunFunc5925At0280, DrawBox4965AndMenuAndStep, ScriptCommandEB_Run_Case05_Case09, DrawBox1D4AndCopyRect5595)
; reads: wArg1, wArg2, wIsCGB
; points at: wScreenTileBuffer, wScreenAttrBuffer
CopyScreenBufferRectWithAttrs_Bank14::
Func_014_5925:: ; address name
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
    ld e, l
    ld d, h
    pop hl
    ld a, [wArg1]
    ld b, a
    ld a, [wArg2]
    ld c, a
    call CopyBytesDEToHL_Bank14
    pop de
    pop hl
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_014_5966
    push hl
    push de
    ld de, wScreenAttrBuffer
    add hl, de
    pop de
    push de
    push hl
    ld hl, wScreenAttrBuffer
    add hl, de
    ld e, l
    ld d, h
    pop hl
    ld a, [wArg1]
    ld b, a
    ld a, [wArg2]
    ld c, a
    call CopyLow3BitsToWRAMBank2_Bank14
    pop de
    pop hl

Jump_014_5966::
    pop bc
    ld a, $14
    add_a_to_hl
    ld a, $14
    add a, e
    ld e, a
    jr nc, Jump_014_5975
    inc d

Jump_014_5975::
    dec c
    jr nz, CopyScreenBufferRectWithAttrs_Bank14
    ret

; wD09D = field $0D of SRAM record B & $0F (its family), wD09E = $C7, then LoadFamilyIconTileForWorkBuf (E-0122)
; 2 call sites from 2 routines (e.g. ScriptCommandEB_Run_Case05_Case21, ScriptCommandEB_Run_Case06_Case04)
; reads: hTemp0
; writes: rRAMG2, rRAMB, wWorkBuf
LoadFamilyIconTileForRecordB_Bank14::
Func_014_5979:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, b
    ld c, $0D
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and a, $0F
    ld [wWorkBuf], a
    ld a, $C7
    ld [wWorkBuf + $1], a
    farcall LoadFamilyIconTileForWorkBuf
    xor a, a
    ld [rRAMG2], a
    ret

; draws tiles $C5, $BE, $C6 at BGMapAddressAtScroll + DE, two entries apart (WaitForVRAMAccess, interrupts off) (E-0120)
; 1 call site from 1 routine (e.g. ScriptCommandEB_Run_Shared01)
DrawC5BEC6AtScrollOffsetDE_Bank14::
Func_014_599F:: ; address name
    push de
    call BGMapAddressAtScroll_Bank14
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, $C5
    ld [hl], a
    ei
    inc hl
    inc hl
    di
    call WaitForVRAMAccess
    ld a, $BE
    ld [hl], a
    ei
    inc hl
    inc hl
    di
    call WaitForVRAMAccess
    ld a, $C6
    ld [hl], a
    ei
    ret

; [HL] = $C5, [HL+2] = $BE, [HL+4] = $C6; HL ends at HL+4; clobbers A (the same 14 bytes appear in 8 banks)
; 1 call site from 1 routine (e.g. ScriptCommandEB_Run_Shared01)
StoreC5BEC6AtHLStride2_Bank14::
Func_014_59C2:: ; address name
    ld a, $C5
    ld [hl], a
    inc hl
    inc hl
    ld a, $BE
    ld [hl], a
    inc hl
    inc hl
    ld a, $C6
    ld [hl], a
    ret

; only called from ScriptCommandEB_Run_Case04_Case15 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandEB_Run_Case04_Case15)
; writes: rRAMB, wArg6, wArg7, wArg5
; points at: sCompactRecords, sRecords
ScriptCommandEB_Run_Case04_Case15_Sub01::
Func_014_59D0:: ; address name
    ld hl, sCompactRecords
    ld c, $00

Jump_014_59D5::
    ld a, [hl]
    bit 7, a
    jr z, Jump_014_59F7
    ld a, $6F
    add_a_to_hl
    inc c
    ld a, c
    cp a, $1D
    jr c, Jump_014_59D5
    ld a, $01
    ld [rRAMB], a
    ld hl, sRecords
    ld a, [hl]
    bit 7, a
    jr z, Jump_014_59F7
    ld a, $FF
    ret

Jump_014_59F7::
    push bc
    ld a, c
    cp a, $1D
    jr z, Jump_014_5A15
    ld c, $6F
    call Multiply8
    ld de, sCompactRecords
    add hl, de
    ld a, l
    ld [wArg6], a
    ld a, h
    ld [wArg7], a
    xor a, a
    ld [wArg5], a
    pop bc
    xor a, a
    ret

Jump_014_5A15::
    pop bc
    ld hl, sRecords
    ld a, l
    ld [wArg6], a
    ld a, h
    ld [wArg7], a
    ld a, $01
    ld [wArg5], a
    xor a, a
    ret

; E-0224 (C1: ScriptCommandEB_Run_Case01_Case01 passes $5A28 with sources Data_014_5A84 to ScriptCommandEB_Run_Shared04, which copies one tile per destination until $FFFF).
; record: 27 VRAM destinations, then $FFFF
NamingScreenTileDestListA::
Data_014_5A28:: ; address name
    dw vTiles1 + $240, vTiles1 + $250, vTiles1 + $260, vTiles1 + $270, vTiles1 + $280, vTiles1 + $290, vTiles1 + $2A0, vTiles1 + $2B0 ; entry 0
    dw vTiles1 + $2C0, vTiles1 + $2D0, vTiles1 + $2E0, vTiles1 + $2F0, vTiles1 + $6E0, vTiles1 + $6F0, vTiles1 + $700, vTiles1 + $710
    dw vTiles1 + $720, vTiles1 + $730, vTiles1 + $740, vTiles1 + $750, vTiles1 + $760, vTiles1 + $770, vTiles1 + $780, vTiles1 + $790
    dw vTiles1 + $7A0, vTiles1 + $7B0, vTiles1 + $7C0, vTiles1 + $7D0

; E-0224 (C1: the second $FFFF-terminated destination list, right after the first; it ends at the source list Data_014_5A84).
; record: 17 VRAM destinations, then $FFFF
NamingScreenTileDestListB::
Data_014_5A60:: ; address name
    dw vTiles1 + $7E0, vTiles1 + $7F0, vTiles1 + $6B0, rIE, vTiles1 + $400, vTiles1 + $410, vTiles1 + $420, vTiles1 + $470 ; entry 0
    dw vTiles1 + $480, vTiles1 + $490, vTiles1 + $4A0, vTiles1 + $4B0, vTiles1 + $3F0, vTiles1 + $6A0, vTiles1 + $6B0, vTiles1 + $6C0
    dw vTiles1 + $6D0, rIE

; E-0225 (derived: a list passed to a tile-list copier, which copies 16 bytes from bank $1F per destination until a low byte of $FF)
; record: bank-$1F tile sources
TileCopySrcList_14_5A84::
Data_014_5A84:: ; address name
    dw $41D0, $4300, $4290, $4340, $4210, $4250, $42F0, $41C0 ; entry 0
    dw $4370, $40F0, $43C0, $42D0, $4380, $4180, $4910, $4910
    dw $4910, $4910, $4910, $4120, $4170, $41A0, $4910, $4910
    dw $4910, $4910, $4910, $4910, $4910, $4A70, $4910, $FFFF

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 10 x 9 tiles, one row per line
TileRect_14_5AC4::
Data_014_5AC4:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $A4, $A5, $A6, $A6, $A7, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $A8, $A9, $AA, $A6, $C3, $C3, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $AB, $A6, $A5, $A6, $A9, $AC, $A6, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $AD, $AE, $AF, $EE, $C3, $C3, $C3, $B7 ; id 7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 8

; address loaded by ScriptCommandEB_Run_Case02, ScriptCommandEB_Run_Case05_Case3E, ScriptCommandEB_Run_Case05_Case07, DrawBox4965AndMenuAndStep and 10 more
Data_014_5B1E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $79, $C3, $A1, $C3, $C9, $C3, $F1, $C3, $19, $C4, $22, $C4, $4A, $C4, $80, $C3
    db $A8, $C3, $D0, $C3, $F8, $C3, $20, $C4

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 11 tiles, one row per line
TileRect_14_5B36::
Data_014_5B36:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $D0, $D1, $D2, $D3, $D4, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $D5, $D6, $D7, $D8, $D9, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $DA, $DB, $DC, $DD, $DE, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $F0, $F1, $F2, $F3, $F4, $B7 ; id 7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 8
    db $B6, $C3, $A4, $A5, $A6, $CE, $CF, $B7 ; id 9
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 10

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 12 x 9 tiles, one row per line
TileRect_14_5B8E::
Data_014_5B8E:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $F8, $F9, $FA, $FB, $FC, $C3, $EA, $ED, $C3, $C3, $B7 ; id 1
    db $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $BA ; id 2
    db $B6, $C7, $A7, $A8, $A9, $AA, $AB, $AC, $AD, $AE, $AF, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $F5, $F7, $ED, $C3, $C3, $C3, $BE, $C3, $C3, $C3, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $F6, $F7, $ED, $C3, $C3, $C3, $BE, $C3, $C3, $C3, $B7 ; id 7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 8
    db $70, $8A, $80, $8A, $90, $8A, $A0, $8A, $B0, $8A, $C0, $8A, $D0, $8A, $E0, $8A
    db $F0, $8A, $80, $8F, $90, $8F, $A0, $8F, $B0, $8F, $C0, $8F, $FF, $FF, $10, $49
    db $10, $49, $10, $49, $10, $49, $10, $49, $10, $49, $10, $49, $10, $49, $10, $49
    db $10, $49, $10, $49, $10, $49, $10, $49, $10, $49, $FF, $FF

; E-0225 (derived: a list passed to a tile-list copier, which copies 16 bytes from bank $1F per destination until a low byte of $FF)
; record: VRAM destinations, then $FFxx
TileCopyDestList_14_5C36::
Data_014_5C36:: ; address name
    dw vTiles1 + $270, vTiles1 + $280, vTiles1 + $290, vTiles1 + $2A0, vTiles1 + $2B0, vTiles1 + $2C0, vTiles1 + $2D0, vTiles1 + $2E0 ; entry 0
    dw vTiles1 + $2F0, rIE

; E-0225 (derived: a list passed to a tile-list copier, which copies 16 bytes from bank $1F per destination until a low byte of $FF)
; record: bank-$1F tile sources
TileCopySrcList_14_5C4A::
Data_014_5C4A:: ; address name
    dw $4340, $4210, $4250, $42F0, $41C0, $4370, $40F0, $43C0 ; entry 0
    dw $42D0, $FFFF

; E-0225 (derived: a list passed to a tile-list copier, which copies 16 bytes from bank $1F per destination until a low byte of $FF)
; record: VRAM destinations, then $FFxx
TileCopyDestList_14_5C5E::
Data_014_5C5E:: ; address name
    dw vTiles1 + $240, vTiles1 + $250, vTiles1 + $260, vTiles1 + $700, vTiles1 + $710, vTiles1 + $720, vTiles1 + $730, vTiles1 + $740 ; entry 0
    dw vTiles1 + $4E0, vTiles1 + $4F0, rIE

; E-0225 (derived: a list passed to a tile-list copier, which copies 16 bytes from bank $1F per destination until a low byte of $FF)
; record: bank-$1F tile sources
TileCopySrcList_14_5C74::
Data_014_5C74:: ; address name
    dw $41D0, $4300, $4290, $4910, $4910, $4910, $4910, $4910 ; entry 0
    dw $4230, $4290, $FFFF

; E-0225 (derived: a list passed to a tile-list copier, which copies 16 bytes from bank $1F per destination until a low byte of $FF)
; record: VRAM destinations, then $FFxx
TileCopyDestList_14_5C8A::
Data_014_5C8A:: ; address name
    dw vTiles2 + $700, vTiles2 + $710, vTiles2 + $720, vTiles2 + $730, vTiles2 + $740, vTiles2 + $750, vTiles2 + $760, rIE ; entry 0

; E-0225 (derived: a list passed to a tile-list copier, which copies 16 bytes from bank $1F per destination until a low byte of $FF)
; record: bank-$1F tile sources
TileCopySrcList_14_5C9A::
Data_014_5C9A:: ; address name
    dw $4130, $4320, $42A0, $4330, $4190, $4150, $FFFF ; entry 0

; unless a fade is running, runs the routine for wCFA8 (jump table of eight) (E-0122)
; 5 call sites from 5 routines (e.g. GameMode5_Update_Case01_Case06_Case05, ScriptCommandF0_Run_Case05, ScriptCommandED_Run_Case06, RunBattleSubStep_6A4E_Case02, ...)
; reads: wFadeState, wNameEntryState
RunNameEntryStateWhenNotFading::
Func_014_5CA8:: ; address name
    ld a, [wFadeState]
    and a, a
    ret nz
    ld a, [wNameEntryState]
    rst $00
    dw RunNameEntryStateWhenNotFading_Case00
    dw RunNameEntryStateWhenNotFading_Case01
    dw RunNameEntryStateWhenNotFading_Case02
    dw RunNameEntryStateWhenNotFading_Case03
    dw RunNameEntryStateWhenNotFading_Case04
    dw RunNameEntryStateWhenNotFading_Case05
    dw RunNameEntryStateWhenNotFading_Case06
    dw RunNameEntryStateWhenNotFading_Case07

; entry 0 of the `rst $00` table in RunNameEntryStateWhenNotFading
; no direct call (reached through a table, a jump or a vector)
; reads: wNameEntrySubState
RunNameEntryStateWhenNotFading_Case00::
Jump_014_5CC1:: ; address name
    ld a, [wNameEntrySubState]
    rst $00
    dw RunNameEntryStateWhenNotFading_Case00_Case00
    dw RunNameEntryStateWhenNotFading_Case00_Case01
    dw RunNameEntryStateWhenNotFading_Case00_Case02
    dw RunNameEntryStateWhenNotFading_Case00_Case03
    dw RunNameEntryStateWhenNotFading_Case00_Case04

; entry 0 of the `rst $00` table in RunNameEntryStateWhenNotFading_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: hSpriteWindowClipMode, wNameEntrySubState
; writes: wArg5, wArg6, wArg1, wArg2, wArg3, wArg4, wArg7, hScrollY, ...
; points at: wNameEntryState
RunNameEntryStateWhenNotFading_Case00_Case00::
Jump_014_5CCF:: ; address name
    ld hl, wNameEntryState
    ld bc, $001D

Jump_014_5CD5::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_014_5CD5
    call BGMapAddressAtScroll_Bank14_6BCF
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
    xor a, a
    ldh [hScrollY], a
    ldh [hScrollX], a
    ldh a, [hSpriteWindowClipMode]
    ld [wSavedSpriteClipMode], a
    ld a, $01
    ldh [hSpriteHideTile], a
    ld a, $02
    ldh [hSpriteWindowClipMode], a
    ld de, Data_01F_4910
    ld hl, vTiles2
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4230
    ld hl, vTiles1 + $4E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4290
    ld hl, vTiles1 + $4F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4370
    ld hl, vTiles1 + $5F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4A80
    ld hl, vTiles1 + $4C0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4A90
    ld hl, vTiles1 + $4D0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wNameEntrySubState]
    inc a
    ld [wNameEntrySubState], a
    xor a, a
    ld [wArg5], a
    ret

; entry 1 of the `rst $00` table in RunNameEntryStateWhenNotFading_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wNameEntrySubState
; writes: wNameEntrySubState, wArg5
RunNameEntryStateWhenNotFading_Case00_Case01::
Jump_014_5D72:: ; address name
    ld hl, NameEntryTileDestList
    ld de, NameEntryTileSrcListA
    call RunNameEntryStateWhenNotFading_Shared05
    cp a, $FF
    jr nz, Jump_014_5D86
    ld a, [wNameEntrySubState]
    inc a
    ld [wNameEntrySubState], a

Jump_014_5D86::
    xor a, a
    ld [wArg5], a
    ret

; entry 2 of the `rst $00` table in RunNameEntryStateWhenNotFading_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wArg2, wNameEntrySubState
; writes: wArg5, wArg6, wArg1, wArg2, wArg3, wArg4, wArg7, wNameEntrySubState
RunNameEntryStateWhenNotFading_Case00_Case02::
Jump_014_5D8B:: ; address name
    ld a, [wArg2]
    push af
    call BGMapAddressAtScroll_Bank14_6BCF
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, TileRect_1F_6FE7
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $14
    ld [wArg3], a
    ld a, $12
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    farcall DrawTileRectFromArg1Params
    call BGMapAddressAtScroll_Bank14_6BCF
    ld de, $0043
    add hl, de
    di
    call WaitForVRAMAccess
    pop af
    and a, $01
    add a, $CC
    ld [hl], a
    ei
    ld hl, $6F3E
    ld de, vTiles2 + $550
    call CopyTileBytesToVRAM_Bank14
    ld a, [wNameEntrySubState]
    inc a
    ld [wNameEntrySubState], a
    xor a, a
    ld [wArg5], a
    ret

; entry 3 of the `rst $00` table in RunNameEntryStateWhenNotFading_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wArg1, wArg2, wIsCGB, wNameEntrySubState, wArg4, wArg5
; writes: wSpriteSlotCount, wOBJPaletteUploadRequest, wNameEntrySubState, wArg5, wArg1, wArg2, wArg3, wArg4
; points at: wArg1, wCounterPtr0Lo, wSpriteSlots, hTemp0
RunNameEntryStateWhenNotFading_Case00_Case03::
Jump_014_5DE0:: ; address name
    ld hl, wArg1
    ld de, wCounterPtr0Lo
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [wArg1]
    or a, a
    jr nz, Jump_014_5E44
    ld hl, Data_014_5E9F
    ld a, [wArg2]
    or a, a
    jr z, Jump_014_5E10
    ld hl, Data_014_5EAF

Jump_014_5E10::
    ld de, wSpriteSlots
    ld b, $10
    call CopyBytesDEFromHL_Bank14
    ld hl, Data_014_5E93
    ld a, [wArg2]
    or a, a
    jr z, Jump_014_5E24
    ld hl, Data_014_5E99

Jump_014_5E24::
    ld de, hTemp0
    ld b, $06
    call CopyBytesDEFromHL_Bank14
    farcall DecompressGraphicsTemp0ToTemp4
    ld a, $01
    ld [wSpriteSlotCount], a
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_014_5E62
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    jr Jump_014_5E62

Jump_014_5E44::
    ld a, [wArg4]
    ld [wArg1], a
    ld a, [wArg5]
    ld [wArg2], a
    xor a, a
    ld [wArg3], a
    ld [wArg4], a
    ld a, $80
    ld [wArg5], a
    farcall DecompressGraphicsArg1ToArg4

Jump_014_5E62::
    ld hl, wCounterPtr0Lo
    ld de, wArg1
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [wNameEntrySubState]
    inc a
    ld [wNameEntrySubState], a
    xor a, a
    ld [wArg5], a
    ret

; the same 7 bytes as CopyBytesDEFromHL (34:406E)
; 2 call sites from 1 routine (e.g. RunNameEntryStateWhenNotFading_Case00_Case03)
CopyBytesDEFromHL_Bank14::
Func_014_5E8C:: ; address name
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, CopyBytesDEFromHL_Bank14
    ret

; address loaded by RunNameEntryStateWhenNotFading_Case00_Case03
Data_014_5E93:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $01, $04, $00, $80

; address loaded by RunNameEntryStateWhenNotFading_Case00_Case03
Data_014_5E99:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $00, $01, $01, $00, $80

; address loaded by RunNameEntryStateWhenNotFading_Case00_Case03
Data_014_5E9F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $01, $00, $00, $08, $08, $04, $00, $00, $00, $00, $08, $08, $04, $00, $00

; address loaded by RunNameEntryStateWhenNotFading_Case00_Case03
Data_014_5EAF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $01, $01, $00, $08, $08, $01, $00, $00, $00, $00, $08, $08, $04, $00, $00

; entry 4 of the `rst $00` table in RunNameEntryStateWhenNotFading_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wArg1, wGridCursorX, wNameEntryState
; writes: rRAMG2, rRAMB, wNameEntryCursorX, wNameEntryCursorY, wNameEntrySubState, wNameEntryState, wArg5, wNameEntryLength
; points at: wPartyList, wNameEntryText
RunNameEntryStateWhenNotFading_Case00_Case04::
Jump_014_5EBF:: ; address name
    call RunNameEntryStateWhenNotFading_Shared03
    ld a, [wArg1]
    and a, a
    jp z, Jump_014_5F12
    cp a, $01
    jp z, Jump_014_5F44
    cp a, $02
    jp z, Jump_014_5F44
    ld hl, wPartyList
    ld a, [wGridCursorX]
    add_a_to_hl
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, $01
    call SRAMRecordAddress
    ld de, wNameEntryText
    ld c, $00

Jump_014_5EF2::
    push hl
    push bc
    ld a, [hl]
    cp a, $F0
    jr z, Jump_014_5F07
    call RunNameEntryStateWhenNotFading_Case00_Case04_Sub01
    pop bc
    pop hl
    inc hl
    inc c
    ld a, c
    cp a, $0A
    jr c, Jump_014_5EF2
    jr Jump_014_5F09

Jump_014_5F07::
    pop bc
    pop hl

Jump_014_5F09::
    xor a, a
    ld [wNameEntryCursorX], a
    ld [wNameEntryCursorY], a
    jr Jump_014_5F44

Jump_014_5F12::
    ld de, $0000
    call TestFlagBit
    jr c, Jump_014_5F30
    ld hl, wNameEntryText
    ld a, $0C
    ld [hl+], a
    ld a, $32
    ld [hl+], a
    ld a, $25
    ld [hl+], a
    ld a, $2C
    ld [hl], a
    ld a, $04
    ld [wNameEntryLength], a
    jr Jump_014_5F44

Jump_014_5F30::
    ld hl, wNameEntryText
    ld a, $1D
    ld [hl+], a
    ld a, $24
    ld [hl+], a
    ld a, $35
    ld [hl+], a
    ld a, $24
    ld [hl], a
    ld a, $04
    ld [wNameEntryLength], a

Jump_014_5F44::
    call RunNameEntryStateWhenNotFading_Shared01
    xor a, a
    ld [wNameEntrySubState], a
    ld a, [wNameEntryState]
    inc a
    ld [wNameEntryState], a
    xor a, a
    ld [wArg5], a
    ret

; entry 1 of the `rst $00` table in RunNameEntryStateWhenNotFading
; no direct call (reached through a table, a jump or a vector)
; reads: wNameEntrySubState
RunNameEntryStateWhenNotFading_Case01::
Jump_014_5F57:: ; address name
    call RunNameEntryStateWhenNotFading_Shared01
    ld a, [wNameEntrySubState]
    rst $00
    dw RunNameEntryStateWhenNotFading_Case01_Case00
    dw RunNameEntryStateWhenNotFading_Case01_Case01
    dw RunNameEntryStateWhenNotFading_Case01_Case02
    dw RunNameEntryStateWhenNotFading_Case01_Case03
    dw RunNameEntryStateWhenNotFading_Case01_Case04
    dw RunNameEntryStateWhenNotFading_Case01_Case00
    dw RunNameEntryStateWhenNotFading_Case01_Case01
    dw RunNameEntryStateWhenNotFading_Case01_Case02
    dw RunNameEntryStateWhenNotFading_Case01_Case03
    dw RunNameEntryStateWhenNotFading_Case01_Case09

; entry 0 of the `rst $00` table in RunNameEntryStateWhenNotFading_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wNameEntrySubState, wNameEntryCursorX, wNameEntryCursorY
; writes: wNameEntryCursorX, wNameEntryCursorY, wArg5, wNameEntrySubState
RunNameEntryStateWhenNotFading_Case01_Case00::
Jump_014_5F72:: ; address name
    call RunNameEntryStateWhenNotFading_Shared02
    ld b, $55
    call WriteTileBAtScrollOffset47PlusNameEntryLength
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jp nz, Jump_014_5FA7
    bit 7, a
    jp nz, Jump_014_5FD4
    bit 4, a
    jp nz, Jump_014_601A
    bit 5, a
    jp nz, Jump_014_6063
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, Jump_014_60A6
    bit 1, a
    jp nz, Jump_014_60BB
    bit 3, a
    jp nz, Jump_014_60CF
    call RunNameEntryStateWhenNotFading_Case01_Case00_Sub01
    ret

Jump_014_5FA7::
    call DrawBlankTileC3_6189
    ld a, [wNameEntryCursorY]
    and a, a
    jr nz, Jump_014_5FC3
    ld a, $04
    ld [wNameEntryCursorY], a
    ld a, [wNameEntryCursorX]
    cp a, $06
    jr c, Jump_014_5FC7
    ld a, $0D
    ld [wNameEntryCursorX], a
    jr Jump_014_5FC7

Jump_014_5FC3::
    dec a
    ld [wNameEntryCursorY], a

Jump_014_5FC7::
    call RunNameEntryStateWhenNotFading_Case01_Case00_Sub01
    ld a, $69
    call QueueSoundEffect
    xor a, a
    ld [wArg5], a
    ret

Jump_014_5FD4::
    call DrawBlankTileC3_6189
    ld a, [wNameEntryCursorY]
    cp a, $04
    jr c, Jump_014_5FE4
    xor a, a
    ld [wNameEntryCursorY], a
    jr Jump_014_600D

Jump_014_5FE4::
    cp a, $02
    jr nz, Jump_014_5FF6
    ld a, [wNameEntryCursorX]
    cp a, $0D
    jr c, Jump_014_6006
    ld a, $0D
    ld [wNameEntryCursorX], a
    jr Jump_014_6006

Jump_014_5FF6::
    cp a, $03
    jr nz, Jump_014_6006
    ld a, [wNameEntryCursorX]
    cp a, $06
    jr c, Jump_014_6006
    ld a, $0D
    ld [wNameEntryCursorX], a

Jump_014_6006::
    ld a, [wNameEntryCursorY]
    inc a
    ld [wNameEntryCursorY], a

Jump_014_600D::
    call RunNameEntryStateWhenNotFading_Case01_Case00_Sub01
    ld a, $69
    call QueueSoundEffect
    xor a, a
    ld [wArg5], a
    ret

Jump_014_601A::
    call DrawBlankTileC3_6189
    ld a, [wNameEntryCursorY]
    ld hl, Data_014_605E
    add_a_to_hl
    ld b, [hl]
    ld a, [wNameEntryCursorX]
    cp a, b
    jr c, Jump_014_6035
    xor a, a
    ld [wNameEntryCursorX], a
    jr Jump_014_6051

Jump_014_6035::
    ld a, [wNameEntryCursorY]
    cp a, $04
    jr nz, Jump_014_604A
    ld a, [wNameEntryCursorX]
    cp a, $05
    jr c, Jump_014_604A
    ld a, $0D
    ld [wNameEntryCursorX], a
    jr Jump_014_6051

Jump_014_604A::
    ld a, [wNameEntryCursorX]
    inc a
    ld [wNameEntryCursorX], a

Jump_014_6051::
    call RunNameEntryStateWhenNotFading_Case01_Case00_Sub01
    ld a, $69
    call QueueSoundEffect
    xor a, a
    ld [wArg5], a
    ret

; address loaded by RunNameEntryStateWhenNotFading_Case01_Case00
Data_014_605E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $10, $10, $10, $0D, $0D

Jump_014_6063::
    call DrawBlankTileC3_6189
    ld a, [wNameEntryCursorX]
    and a, a
    jr nz, Jump_014_607D
    ld a, [wNameEntryCursorY]
    ld hl, Data_014_605E
    add_a_to_hl
    ld a, [hl]
    ld [wNameEntryCursorX], a
    jr Jump_014_6099

Jump_014_607D::
    ld a, [wNameEntryCursorY]
    cp a, $04
    jr nz, Jump_014_6092
    ld a, [wNameEntryCursorX]
    cp a, $0D
    jr c, Jump_014_6092
    ld a, $05
    ld [wNameEntryCursorX], a
    jr Jump_014_6099

Jump_014_6092::
    ld a, [wNameEntryCursorX]
    dec a
    ld [wNameEntryCursorX], a

Jump_014_6099::
    call RunNameEntryStateWhenNotFading_Case01_Case00_Sub01
    ld a, $69
    call QueueSoundEffect
    xor a, a
    ld [wArg5], a
    ret

Jump_014_60A6::
    ld a, $69
    call QueueSoundEffect
    call RunNameEntryStateWhenNotFading_Case01_Case00_Sub02
    ld a, [wNameEntrySubState]
    inc a
    inc a
    ld [wNameEntrySubState], a
    xor a, a
    ld [wArg5], a
    ret

Jump_014_60BB::
    ld a, $69
    call QueueSoundEffect
    call RunNameEntryStateWhenNotFading_Case01_Case00_Sub01
    ld a, [wNameEntrySubState]
    inc a
    ld [wNameEntrySubState], a
    xor a, a
    ld [wArg5], a
    ret

Jump_014_60CF::
    ld a, $69
    call QueueSoundEffect
    call DrawBlankTileC3_6189
    ld a, $0D
    ld [wNameEntryCursorX], a
    ld a, $04
    ld [wNameEntryCursorY], a
    xor a, a
    ld [wArg5], a
    ret

; on the last glyph of the name entry wCFAD adds or cycles the marks $8D and $8E when the glyph allows them (lists Data_014_688A and 68CA), with sound $69 (E-0129)
; no direct call (reached through a table, a jump or a vector)
; writes: wArg5
; points at: wNameEntryText
ToggleVoicingMarkOnNameEntry:: ; heuristic: follows a terminator; C0
Func_014_60E6:: ; address name
    call CopyTileForNameEntryLength
    ld hl, wNameEntryText

Jump_014_60EC::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_014_60F8
    cp a, $9F
    jr z, Jump_014_60F8
    inc hl
    jr Jump_014_60EC

Jump_014_60F8::
    dec hl
    ld a, [hl]
    cp a, $8E
    jr z, Jump_014_6142
    cp a, $8D
    jr z, Jump_014_6154
    ld b, $8D
    push bc
    call IsHLByteInList688A
    pop bc
    cp a, $FF
    jr nz, Jump_014_6112
    xor a, a
    ld [wArg5], a
    ret

Jump_014_6112::
    ld a, $69
    call QueueSoundEffect
    ld hl, wNameEntryText

Jump_014_611A::
    ld a, [hl]
    cp a, $9F
    jr z, Jump_014_612D
    cp a, $F0
    jr z, Jump_014_6126
    inc hl
    jr Jump_014_611A

Jump_014_6126::
    ld a, b
    ld [hl], a
    xor a, a
    ld [wArg5], a
    ret

Jump_014_612D::
    ld a, b
    ld [hl], a
    ld hl, wNameEntryText

Jump_014_6132::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_014_613A
    inc hl
    jr Jump_014_6132

Jump_014_613A::
    ld a, $9F
    ld [hl], a
    xor a, a
    ld [wArg5], a
    ret

Jump_014_6142::
    ld a, $9F
    ld [hl], a

Jump_014_6145::
    ld a, [hl+]
    cp a, $F0
    jr nz, Jump_014_6145
    dec hl
    dec hl
    ld a, $F0
    ld [hl], a
    xor a, a
    ld [wArg5], a
    ret

Jump_014_6154::
    dec hl
    ld b, $8E
    push bc
    call IsHLByteInList68CA
    pop bc
    cp a, $FF
    jr nz, Jump_014_6164
    inc hl
    jp Jump_014_6142

Jump_014_6164::
    inc hl
    ld a, $8E
    ld [hl], a
    ld a, $69
    call QueueSoundEffect
    xor a, a
    ld [wArg5], a
    ret

; only called from RunNameEntryStateWhenNotFading_Case01_Case00 (E-0047)
; 6 call sites from 1 routine (e.g. RunNameEntryStateWhenNotFading_Case01_Case00)
; reads: wNameEntryCursorByte, wNameEntryCursorY, wNameEntryCursorX
; writes: wNameEntryCursorByte
RunNameEntryStateWhenNotFading_Case01_Case00_Sub01::
Func_014_6172:: ; address name
    ld a, [wNameEntryCursorByte]
    inc a
    ld [wNameEntryCursorByte], a
    cp a, $10
    jr c, Jump_014_6185
    cp a, $18
    jr c, DrawBlankTileC3_6189
    xor a, a
    ld [wNameEntryCursorByte], a

Jump_014_6185::
    ld b, $55
    jr Jump_014_618F

; B = $C3 (blank tile) and joins the tile draw at Jump_014_618F (E-0122)
; 7 call sites from 2 routines (e.g. RunNameEntryStateWhenNotFading_Case00_Case04_Sub01, RunNameEntryStateWhenNotFading_Case01_Case00)
; reads: wNameEntryCursorY, wNameEntryCursorX
DrawBlankTileC3_6189::
Func_014_6189:: ; address name
    ld b, $C3
    jr Jump_014_618F

; only called from RunNameEntryStateWhenNotFading_Case01_Case00 (E-0047)
; 1 call site from 1 routine (e.g. RunNameEntryStateWhenNotFading_Case01_Case00)
; reads: wNameEntryCursorY, wNameEntryCursorX
RunNameEntryStateWhenNotFading_Case01_Case00_Sub02::
Func_014_618D:: ; address name
    ld b, $55

Jump_014_618F::
    ld a, [wNameEntryCursorY]
    ld hl, NameEntryKeyPositions
    cp a, $00
    jr z, Jump_014_61A1
    ld e, $22
    ld d, $00

Jump_014_619D::
    add hl, de
    dec a
    jr nz, Jump_014_619D

Jump_014_61A1::
    ld a, [wNameEntryCursorX]
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank14_6BCF
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ld a, [wNameEntryCursorX]
    cp a, $0D
    ret nz
    ld a, [wNameEntryCursorY]
    cp a, $04
    jr z, Jump_014_61D2
    cp a, $03
    ret nz
    inc hl
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei

Jump_014_61D2::
    inc hl
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl+], a
    ei
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; E-0224 (C1: RunNameEntryStateWhenNotFading_Case01_Case00_Sub02 reads row $22 * wNameEntryCursorY from $61E2, then the word for wNameEntryCursorX; 5 rows).
; record: 17 position words (one per key column) for a keyboard row
NameEntryKeyPositions::
Data_014_61E2:: ; address name
    dw $0101, $0102, $0103, $0104, $0105, $0106, $0107, $0108, $0109, $010A, $010B, $010C, $010D, $010F, $0110, $0111, $0112 ; id 0
    dw $0141, $0142, $0143, $0144, $0145, $0146, $0147, $0148, $0149, $014A, $014B, $014C, $014D, $014F, $0150, $0151, $0152 ; id 1
    dw $0181, $0182, $0183, $0184, $0185, $0186, $0187, $0188, $0189, $018A, $018B, $018C, $018D, $018F, $0190, $0191, $0192 ; id 2
    dw $01C1, $01C2, $01C3, $01C4, $01C5, $01C6, $01C7, $01C8, $01C9, $01CA, $01CB, $01CC, $01CD, $01CF, $01D0, $01D1, $01D2 ; id 3
    dw $0201, $0202, $0203, $0204, $0205, $0206, $0207, $0208, $0209, $020A, $020B, $020C, $020D, $020F, $0210, $0211, $0212 ; id 4

; entry 1 of the `rst $00` table in RunNameEntryStateWhenNotFading_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wNameEntryLength, wNameEntrySubState, wNameEntryByteC3
; writes: wNameEntrySubState, wArg5, wNameEntryByteC3, wNameEntryLength
; points at: wNameEntryText
RunNameEntryStateWhenNotFading_Case01_Case01::
Jump_014_628C:: ; address name
    ld b, $55
    call WriteTileBAtScrollOffset47PlusNameEntryLength
    ld a, [wNameEntryLength]
    and a, a
    jr nz, Jump_014_62A6
    call RunNameEntryStateWhenNotFading_Shared03
    ld a, [wNameEntrySubState]
    dec a
    ld [wNameEntrySubState], a
    xor a, a
    ld [wArg5], a
    ret

Jump_014_62A6::
    ld b, $C3
    call WriteTileBAtScrollOffset47PlusNameEntryLength
    ld hl, wNameEntryText

Jump_014_62AE::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_014_62BA
    cp a, $9F
    jr z, Jump_014_62BA
    inc hl
    jr Jump_014_62AE

Jump_014_62BA::
    dec hl
    ld a, [hl]
    cp a, $8D
    jr z, Jump_014_62C6
    cp a, $8E
    jr z, Jump_014_62C6
    jr Jump_014_62DD

Jump_014_62C6::
    ld a, $9F
    ld [hl-], a
    ld a, $9F
    ld [hl], a
    ld hl, wNameEntryText

Jump_014_62CF::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_014_62D7
    inc hl
    jr Jump_014_62CF

Jump_014_62D7::
    dec hl
    ld a, $F0
    ld [hl], a
    jr Jump_014_62E0

Jump_014_62DD::
    ld a, $9F
    ld [hl-], a

Jump_014_62E0::
    call CopyTileForNameEntryLength
    ld a, [wNameEntryByteC3]
    and a, a
    jr z, Jump_014_62EF
    xor a, a
    ld [wNameEntryByteC3], a
    jr Jump_014_62F6

Jump_014_62EF::
    ld a, [wNameEntryLength]
    dec a
    ld [wNameEntryLength], a

Jump_014_62F6::
    ld a, [wNameEntrySubState]
    dec a
    ld [wNameEntrySubState], a
    xor a, a
    ld [wArg5], a
    ret

; entry 2 of the `rst $00` table in RunNameEntryStateWhenNotFading_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wNameEntryCursorY, wNameEntryCursorX, wNameEntryLength, wNameEntrySubState, wNameEntryByteC3, wNameEntryState
; writes: wNameEntryByteC3, wNameEntryLength, wNameEntrySubState, wArg5, wNameEntryCursorX, wNameEntryCursorY, wNameEntryState
; points at: wNameEntryText
RunNameEntryStateWhenNotFading_Case01_Case02::
Jump_014_6302:: ; address name
    ld a, [wNameEntryCursorY]
    ld hl, NameEntryKeyboard
    cp a, $00
    jr z, Jump_014_6314
    ld e, $11
    ld d, $00

Jump_014_6310::
    add hl, de
    dec a
    jr nz, Jump_014_6310

Jump_014_6314::
    ld a, [wNameEntryCursorX]
    add a, l
    ld l, a
    jr nc, RunNameEntryStateWhenNotFading_Case00_Case04_Sub01
    inc h

; only called from RunNameEntryStateWhenNotFading_Case00_Case04 (E-0047)
; 1 call site from 1 routine (e.g. RunNameEntryStateWhenNotFading_Case00_Case04)
; reads: wNameEntryLength, wNameEntrySubState, wNameEntryByteC3, wNameEntryState
; writes: wNameEntryByteC3, wNameEntryLength, wNameEntrySubState, wArg5, wNameEntryCursorX, wNameEntryCursorY, wNameEntryState
; points at: wNameEntryText
RunNameEntryStateWhenNotFading_Case00_Case04_Sub01::
Func_014_631C:: ; address name
    ld a, [hl]
    cp a, $FD
    jp z, Jump_014_643F
    cp a, $FE
    jp z, Jump_014_644C
    cp a, $FF
    jp z, Jump_014_6458
    push af
    ld hl, wNameEntryText

Jump_014_6330::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_014_633C
    cp a, $9F
    jr z, Jump_014_633C
    inc hl
    jr Jump_014_6330

Jump_014_633C::
    pop af
    cp a, $8D
    jr z, Jump_014_6375
    cp a, $8E
    jr z, Jump_014_6375
    push af
    ld a, [wNameEntryLength]
    cp a, $04
    jr nz, Jump_014_6371
    ld a, $01
    ld [wNameEntryByteC3], a
    dec hl
    ld a, [hl]
    cp a, $8D
    jr z, Jump_014_6365
    cp a, $8E
    jr z, Jump_014_6365
    inc hl
    ld a, [hl]
    cp a, $9F
    jr z, Jump_014_6371
    dec hl
    jr Jump_014_6371

Jump_014_6365::
    inc hl
    ld a, [hl-]
    cp a, $9F
    jr nz, Jump_014_636D
    inc hl
    inc hl

Jump_014_636D::
    ld a, $F0
    ld [hl], a
    dec hl

Jump_014_6371::
    pop af
    ld [hl+], a
    jr Jump_014_63CE

Jump_014_6375::
    dec hl
    push af
    ld a, [hl]
    cp a, $8D
    jp z, Jump_014_641A
    cp a, $8E
    jp z, Jump_014_6431
    pop af
    push af
    cp a, $8D
    jr z, Jump_014_6392
    call IsHLByteInList68CA
    cp a, $FF
    jp z, Jump_014_63FD
    jr Jump_014_639A

Jump_014_6392::
    call IsHLByteInList688A
    cp a, $FF
    jp z, Jump_014_63FD

Jump_014_639A::
    pop af
    inc hl
    ld [hl], a
    ld a, [wNameEntryLength]
    cp a, $04
    jr z, Jump_014_63A8

Jump_014_63A4::
    ld b, $F0
    jr Jump_014_63B0

Jump_014_63A8::
    ld a, [wNameEntryByteC3]
    and a, a
    jr z, Jump_014_63A4
    ld b, $9F

Jump_014_63B0::
    ld hl, wNameEntryText
    ld c, $00

Jump_014_63B5::
    ld a, [hl]
    cp a, b
    jr z, Jump_014_63C2
    inc hl
    inc c
    ld a, c
    cp a, $0A
    jr z, Jump_014_63C7
    jr Jump_014_63B5

Jump_014_63C2::
    ld a, $9F
    ld [hl], a
    jr Jump_014_63F0

Jump_014_63C7::
    ld a, $01
    ld [wNameEntryByteC3], a
    jr Jump_014_63FE

Jump_014_63CE::
    ld b, $C3
    call WriteTileBAtScrollOffset47PlusNameEntryLength
    ld a, [wNameEntryLength]
    cp a, $04
    jr nc, Jump_014_63E3
    ld a, [wNameEntryLength]
    inc a
    ld [wNameEntryLength], a
    jr Jump_014_63F0

Jump_014_63E3::
    call DrawBlankTileC3_6189
    ld a, $0D
    ld [wNameEntryCursorX], a
    ld a, $04
    ld [wNameEntryCursorY], a

Jump_014_63F0::
    ld a, [wNameEntrySubState]
    dec a
    dec a
    ld [wNameEntrySubState], a
    xor a, a
    ld [wArg5], a
    ret

Jump_014_63FD::
    pop af

Jump_014_63FE::
    ld a, [wNameEntryLength]
    cp a, $04
    jr c, Jump_014_63F0
    ld a, [wNameEntryByteC3]
    and a, a
    jr z, Jump_014_63F0
    call DrawBlankTileC3_6189
    ld a, $0D
    ld [wNameEntryCursorX], a
    ld a, $04
    ld [wNameEntryCursorY], a
    jr Jump_014_63F0

Jump_014_641A::
    pop af
    push af
    cp a, $8D
    jr z, Jump_014_63FD
    dec hl
    call IsHLByteInList68CA
    cp a, $FF
    jr z, Jump_014_63FD
    inc hl
    ld a, $8E
    ld [hl], a
    call CopyTileForNameEntryLength
    jr Jump_014_63FD

Jump_014_6431::
    pop af
    push af
    cp a, $8E
    jr z, Jump_014_63FD
    ld a, $8D
    ld [hl], a
    call CopyTileForNameEntryLength
    jr Jump_014_63FD

Jump_014_643F::
    ld a, [wNameEntrySubState]
    inc a
    inc a
    ld [wNameEntrySubState], a
    xor a, a
    ld [wArg5], a
    ret

Jump_014_644C::
    ld a, [wNameEntrySubState]
    dec a
    ld [wNameEntrySubState], a
    xor a, a
    ld [wArg5], a
    ret

Jump_014_6458::
    ld a, [wNameEntryLength]
    and a, a
    jr z, Jump_014_646A
    ld a, [wNameEntryState]
    inc a
    ld [wNameEntryState], a
    xor a, a
    ld [wArg5], a
    ret

Jump_014_646A::
    ld a, [wNameEntrySubState]
    inc a
    ld [wNameEntrySubState], a
    xor a, a
    ld [wArg5], a
    ret

; entry 3 of the `rst $00` table in RunNameEntryStateWhenNotFading_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wNameEntryState
; writes: wNameEntryState, wArg5
RunNameEntryStateWhenNotFading_Case01_Case03::
Jump_014_6476:: ; address name
    call RunNameEntryStateWhenNotFading_Case01_Case03_Sub01
    call RunNameEntryStateWhenNotFading_Shared02
    ld a, [wNameEntryState]
    inc a
    ld [wNameEntryState], a
    xor a, a
    ld [wArg5], a
    ret

; entry 4 of the `rst $00` table in RunNameEntryStateWhenNotFading_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wNameEntrySubState
; writes: wNameEntrySubState, wArg5
RunNameEntryStateWhenNotFading_Case01_Case04::
Jump_014_6488:: ; address name
    ld hl, NameEntryTileDestListEmpty
    ld de, NameEntryTileSrcListB
    call RunNameEntryStateWhenNotFading_Shared05
    cp a, $FF
    jr nz, Jump_014_64A9
    ld a, [wNameEntrySubState]
    inc a
    ld [wNameEntrySubState], a
    ld de, Data_01F_48E0
    ld hl, vTiles2 + $480
    ld b, $1F
    ld c, $10
    call OrFromBankWaitVRAM

Jump_014_64A9::
    xor a, a
    ld [wArg5], a
    ret

; entry 9 of the `rst $00` table in RunNameEntryStateWhenNotFading_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wNameEntrySubState, wArg5
RunNameEntryStateWhenNotFading_Case01_Case09::
Jump_014_64AE:: ; address name
    ld hl, NameEntryTileDestListEmpty
    ld de, NameEntryTileSrcListA
    call RunNameEntryStateWhenNotFading_Shared05
    cp a, $FF
    jr nz, Jump_014_64BF
    xor a, a
    ld [wNameEntrySubState], a

Jump_014_64BF::
    xor a, a
    ld [wArg5], a
    ret

; entry 2 of the `rst $00` table in RunNameEntryStateWhenNotFading
; no direct call (reached through a table, a jump or a vector)
; reads: wNameEntryStep
RunNameEntryStateWhenNotFading_Case02::
Jump_014_64C4:: ; address name
    call RunNameEntryStateWhenNotFading_Shared01
    ld a, [wNameEntryStep]
    rst $00
    dw RunNameEntryStateWhenNotFading_Case02_Case00
    dw RunNameEntryStateWhenNotFading_Case02_Case01
    dw RunNameEntryStateWhenNotFading_Case02_Case02
    dw RunNameEntryStateWhenNotFading_Case02_Case03

; entry 0 of the `rst $00` table in RunNameEntryStateWhenNotFading_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wNameEntryStep
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wNameEntryStep, wArg5
RunNameEntryStateWhenNotFading_Case02_Case00::
Jump_014_64D3:: ; address name
    ld hl, vTiles2 + $5C0
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
    ld a, [wNameEntryStep]
    inc a
    ld [wNameEntryStep], a
    xor a, a
    ld [wArg5], a
    ret

; entry 1 of the `rst $00` table in RunNameEntryStateWhenNotFading_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wNameEntryStep
; writes: wArg5, wArg6, wArg1, wArg2, wArg3, wArg4, wArg7, wNameEntryStep
RunNameEntryStateWhenNotFading_Case02_Case01::
Jump_014_64F8:: ; address name
    call BGMapAddressAtScroll_Bank14_6BCF
    ld de, $01E0
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, Data_01F_7177
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $14
    ld [wArg3], a
    ld a, $01
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    farcall DrawTileRectFromArg1Params
    ld a, [wNameEntryStep]
    inc a
    ld [wNameEntryStep], a
    xor a, a
    ld [wArg5], a
    ret

; entry 2 of the `rst $00` table in RunNameEntryStateWhenNotFading_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wNameEntryStep
; writes: wArg5, wArg6, wArg1, wArg2, wArg3, wArg4, wArg7, wNameEntryStep
RunNameEntryStateWhenNotFading_Case02_Case02::
Jump_014_6532:: ; address name
    call BGMapAddressAtScroll_Bank14_6BCF
    ld de, $01C0
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, TileRect_1F_71B3
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $14
    ld [wArg3], a
    ld a, $03
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    farcall DrawTileRectFromArg1Params
    ld a, [wNameEntryStep]
    inc a
    ld [wNameEntryStep], a
    xor a, a
    ld [wArg5], a
    ret

; entry 3 of the `rst $00` table in RunNameEntryStateWhenNotFading_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wNameEntryState
; writes: wArg5, wArg6, wArg1, wArg2, wArg3, wArg4, wArg7, wNameEntryStep, ...
RunNameEntryStateWhenNotFading_Case02_Case03::
Jump_014_656C:: ; address name
    call BGMapAddressAtScroll_Bank14_6BCF
    ld de, $01A0
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, TileRect_1F_714F
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $14
    ld [wArg3], a
    ld a, $05
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    farcall DrawTileRectFromArg1Params
    xor a, a
    ld [wNameEntryStep], a
    ld a, [wNameEntryState]
    inc a
    ld [wNameEntryState], a
    xor a, a
    ld [wArg5], a
    ret

; entry 3 of the `rst $00` table in RunNameEntryStateWhenNotFading
; no direct call (reached through a table, a jump or a vector)
; reads: wNameEntryStep
RunNameEntryStateWhenNotFading_Case03::
Jump_014_65AA:: ; address name
    call RunNameEntryStateWhenNotFading_Shared01
    ld a, [wNameEntryStep]
    rst $00
    dw RunNameEntryStateWhenNotFading_Case03_Case00
    dw RunNameEntryStateWhenNotFading_Case03_Case01
    dw RunNameEntryStateWhenNotFading_Case03_Case02
    dw RunNameEntryStateWhenNotFading_Case03_Case03
    dw RunNameEntryStateWhenNotFading_Case03_Case04
    dw RunNameEntryStateWhenNotFading_Case03_Case05

; entry 5 of the `rst $00` table in RunNameEntryStateWhenNotFading_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wNameEntryState
; writes: wStringCategory, wStringIndex, wNameEntryState, wNameEntryMenuCursor, wArg5
RunNameEntryStateWhenNotFading_Case03_Case05::
Jump_014_65BD:: ; address name
    xor a, a
    ld [wStringCategory], a
    ld a, $03
    ld [wStringIndex], a
    call RunNameEntryStateWhenNotFading_Shared04
    cp a, $FF
    ret nz
    ld a, [wNameEntryState]
    add a, $04
    ld [wNameEntryState], a
    xor a, a
    ld [wNameEntryMenuCursor], a
    ld [wArg5], a
    ret

; entry 0 of the `rst $00` table in RunNameEntryStateWhenNotFading_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wArg1, wNameEntryStep
; writes: wNameEntryStep, wArg5
RunNameEntryStateWhenNotFading_Case03_Case00::
Jump_014_65DC:: ; address name
    ld a, [wArg1]
    and a, a
    jp z, Jump_014_661F
    call RunNameEntryStateWhenNotFading_Case03_Case00_Sub02
    cp a, $FF
    jr z, Jump_014_663A
    call RunNameEntryStateWhenNotFading_Case03_Case00_Sub03
    cp a, $FF
    jr z, Jump_014_663A
    call RunNameEntryStateWhenNotFading_Case03_Case00_Sub01
    cp a, $FF
    jr nz, Jump_014_6604
    ld a, [wNameEntryStep]
    inc a
    ld [wNameEntryStep], a
    xor a, a
    ld [wArg5], a
    ret

Jump_014_6604::
    call RunNameEntryStateWhenNotFading_Case03_Case00_Sub02
    cp a, $FF
    jr z, Jump_014_663A
    call RunNameEntryStateWhenNotFading_Case03_Case00_Sub03
    cp a, $FF
    jr z, Jump_014_663A
    ld a, [wNameEntryStep]
    add a, $03
    ld [wNameEntryStep], a
    xor a, a
    ld [wArg5], a
    ret

Jump_014_661F::
    call RunNameEntryStateWhenNotFading_Case03_Case00_Sub02
    cp a, $FF
    jr z, Jump_014_663A
    call RunNameEntryStateWhenNotFading_Case03_Case00_Sub03
    cp a, $FF
    jr z, Jump_014_663A
    ld a, [wNameEntryStep]
    inc a
    inc a
    ld [wNameEntryStep], a
    xor a, a
    ld [wArg5], a
    ret

Jump_014_663A::
    ld a, [wNameEntryStep]
    add a, $05
    ld [wNameEntryStep], a
    xor a, a
    ld [wArg5], a
    ret

; entry 1 of the `rst $00` table in RunNameEntryStateWhenNotFading_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wNameEntryStep
; writes: wStringCategory, wStringIndex, wNameEntryStep, wArg5
RunNameEntryStateWhenNotFading_Case03_Case01::
Jump_014_6647:: ; address name
    xor a, a
    ld [wStringCategory], a
    ld a, $02
    ld [wStringIndex], a
    call RunNameEntryStateWhenNotFading_Shared04
    cp a, $FF
    jr nz, Jump_014_665F
    ld a, [wNameEntryStep]
    inc a
    inc a
    ld [wNameEntryStep], a

Jump_014_665F::
    xor a, a
    ld [wArg5], a
    ret

; entry 2 of the `rst $00` table in RunNameEntryStateWhenNotFading_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wNameEntryStep
; writes: wNameEntryStep, wArg5
; points at: wTextBuf0, wNameEntryText
RunNameEntryStateWhenNotFading_Case03_Case02::
Jump_014_6664:: ; address name
    ld de, wTextBuf0
    ld a, [wNameEntryStep]
    inc a
    ld [wNameEntryStep], a
    jp RunNameEntryStateWhenNotFading_Case03_Case03

; entry 3 of the `rst $00` table in RunNameEntryStateWhenNotFading_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wNameEntryStep
; writes: wNameEntryStep, wArg5
; points at: wNameEntryText, wTextBuf0
RunNameEntryStateWhenNotFading_Case03_Case03::
Jump_014_6671:: ; address name
    ld hl, wNameEntryText
    ld de, wTextBuf0

Jump_014_6677::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_014_6685
    cp a, $9F
    jr z, Jump_014_6685
    ld [de], a
    inc hl
    inc de
    jr Jump_014_6677

Jump_014_6685::
    ld a, $F0
    ld [de], a
    ld a, [wNameEntryStep]
    inc a
    ld [wNameEntryStep], a
    xor a, a
    ld [wArg5], a
    ret

; entry 4 of the `rst $00` table in RunNameEntryStateWhenNotFading_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wNameEntryState
; writes: wStringCategory, wStringIndex, wNameEntryStep, wNameEntryState, wArg5
RunNameEntryStateWhenNotFading_Case03_Case04::
Jump_014_6694:: ; address name
    xor a, a
    ld [wStringCategory], a
    ld [wStringIndex], a
    call RunNameEntryStateWhenNotFading_Shared04
    cp a, $FF
    ret nz
    xor a, a
    ld [wNameEntryStep], a
    ld a, [wNameEntryState]
    inc a
    ld [wNameEntryState], a
    xor a, a
    ld [wArg5], a
    ret

; entry 4 of the `rst $00` table in RunNameEntryStateWhenNotFading
; no direct call (reached through a table, a jump or a vector)
; reads: wNameEntryState
; writes: wArg5, wArg6, wArg1, wArg2, wArg3, wArg4, wArg7, wNameEntryState
RunNameEntryStateWhenNotFading_Case04::
Jump_014_66B1:: ; address name
    call RunNameEntryStateWhenNotFading_Shared01
    call BGMapAddressAtScroll_Bank14_6BCF
    ld de, $010E
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, TileRect_1F_71EF
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $06
    ld [wArg3], a
    ld a, $05
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    farcall DrawTileRectFromArg1Params
    ld a, [wNameEntryState]
    inc a
    ld [wNameEntryState], a
    ld a, $6C
    call QueueSoundEffect
    xor a, a
    ld [wArg5], a
    ret

; entry 5 of the `rst $00` table in RunNameEntryStateWhenNotFading
; no direct call (reached through a table, a jump or a vector)
; reads: wNameEntryMenuCursor, wNameEntryState
; writes: wNameEntryState, wNameEntryMenuCursor, wArg5
RunNameEntryStateWhenNotFading_Case05::
Jump_014_66F3:: ; address name
    call RunNameEntryStateWhenNotFading_Shared01
    call RunNameEntryStateWhenNotFading_Case05_Sub01
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_014_6704
    cp a, $FF
    jr z, Jump_014_6714
    ret

Jump_014_6704::
    ld a, [wNameEntryState]
    inc a
    inc a
    ld [wNameEntryState], a
    xor a, a
    ld [wNameEntryMenuCursor], a
    ld [wArg5], a
    ret

Jump_014_6714::
    ld a, [wNameEntryMenuCursor]
    and a, a
    jr nz, Jump_014_6704
    ld a, [wNameEntryState]
    inc a
    ld [wNameEntryState], a
    xor a, a
    ld [wNameEntryMenuCursor], a
    ld [wArg5], a
    ret

; entry 6 of the `rst $00` table in RunNameEntryStateWhenNotFading
; no direct call (reached through a table, a jump or a vector)
; reads: wNameEntryStep
RunNameEntryStateWhenNotFading_Case06::
Jump_014_6729:: ; address name
    call RunNameEntryStateWhenNotFading_Shared01
    ld a, [wNameEntryStep]
    rst $00
    dw RunNameEntryStateWhenNotFading_Case06_Case00
    dw RunNameEntryStateWhenNotFading_Case06_Case01

; entry 0 of the `rst $00` table in RunNameEntryStateWhenNotFading_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wNameEntryStep
; writes: wArg5, wArg6, wArg1, wArg2, wArg3, wArg4, wArg7, wNameEntryStep
RunNameEntryStateWhenNotFading_Case06_Case00::
Jump_014_6734:: ; address name
    call BGMapAddressAtScroll_Bank14_6BCF
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
    ld a, [wNameEntryStep]
    inc a
    ld [wNameEntryStep], a
    xor a, a
    ld [wArg5], a
    ret

; entry 1 of the `rst $00` table in RunNameEntryStateWhenNotFading_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wSavedSpriteClipMode
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, hSpriteHideTile, wArg5
; points at: wNameEntryText, wNameGlyphBuf, wNameEntryState
RunNameEntryStateWhenNotFading_Case06_Case01::
Jump_014_676A:: ; address name
    ld hl, wNameEntryText
    ld de, wNameGlyphBuf

Jump_014_6770::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_014_677E
    cp a, $9F
    jr z, Jump_014_677E
    ld [de], a
    inc hl
    inc de
    jr Jump_014_6770

Jump_014_677E::
    ld a, $F0
    ld [de], a
    ld hl, wNameEntryState
    ld bc, $001D

Jump_014_6787::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_014_6787
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
    ldh [hSpriteHideTile], a
    ld a, [wSavedSpriteClipMode]
    ld a, $FF
    ld [wArg5], a
    ret

; entry 7 of the `rst $00` table in RunNameEntryStateWhenNotFading
; no direct call (reached through a table, a jump or a vector)
; reads: wNameEntrySubState
; writes: wArg5, wArg6, wArg1, wArg2, wArg3, wArg4, wArg7, wNameEntryState, ...
RunNameEntryStateWhenNotFading_Case07::
Jump_014_67B0:: ; address name
    call RunNameEntryStateWhenNotFading_Shared01
    call BGMapAddressAtScroll_Bank14_6BCF
    ld de, $0100
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, Data_01F_7087
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $14
    ld [wArg3], a
    ld a, $0A
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    farcall DrawTileRectFromArg1Params
    ld a, $01
    ld [wNameEntryState], a
    xor a, a
    ld [wNameEntryStep], a
    ld a, [wNameEntrySubState]
    cp a, $04
    jr nc, Jump_014_67FA
    xor a, a
    ld [wNameEntrySubState], a
    xor a, a
    ld [wArg5], a
    ret

Jump_014_67FA::
    ld a, $05
    ld [wNameEntrySubState], a
    xor a, a
    ld [wArg5], a
    ret

; only called from routines of RunNameEntryStateWhenNotFading (E-0098)
; 8 call sites from 8 routines (e.g. RunNameEntryStateWhenNotFading_Case07, RunNameEntryStateWhenNotFading_Case06, RunNameEntryStateWhenNotFading_Case05, RunNameEntryStateWhenNotFading_Case04, ...)
; reads: wArg1, wArg4, wArg5
; writes: wArg1, wArg2, wArg3, wArg4, wArg5, wArg6
; points at: wArg1, wCounterPtr0Lo
RunNameEntryStateWhenNotFading_Shared01::
Func_014_6804:: ; address name
    ld hl, wArg1
    ld de, wCounterPtr0Lo
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [wArg1]
    or a, a
    jr nz, Jump_014_6830
    farcall UpdateAndDrawSpriteSlots
    jr Jump_014_6856

Jump_014_6830::
    ld a, [wArg4]
    ld [wArg1], a
    ld a, [wArg5]
    ld [wArg2], a
    xor a, a
    ld [wArg3], a
    ld a, $10
    ld [wArg4], a
    ld a, $18
    ld [wArg5], a
    xor a, a
    ld [wArg6], a
    ld c, $00
    farcall DrawMetaSpritePartC0

Jump_014_6856::
    ld hl, wCounterPtr0Lo
    ld de, wArg1
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ret

; A = 0 when [HL] is in the $FF-terminated list Data_014_688A, else $FF (E-0124)
; 2 call sites from 2 routines (e.g. RunNameEntryStateWhenNotFading_Case00_Case04_Sub01, ToggleVoicingMarkOnNameEntry)
IsHLByteInList688A::
Func_014_6875:: ; address name
    ld de, Data_014_688A

Jump_014_6878::
    ld a, [de]
    cp a, $FF
    jr z, Jump_014_6887
    ld b, a
    ld a, [hl]
    cp a, b
    jr z, Jump_014_6885
    inc de
    jr Jump_014_6878

Jump_014_6885::
    xor a, a
    ret

Jump_014_6887::
    ld a, $FF
    ret

; address loaded by IsHLByteInList688A
Data_014_688A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $3E, $3F, $40, $41, $42, $29, $2A, $2B, $2C, $2D, $2E, $2F, $30, $31, $32, $33
    db $34, $35, $37, $38, $75, $76, $77, $78, $79, $60, $61, $62, $63, $64, $65, $66
    db $67, $68, $69, $6A, $6B, $6C, $6E, $6F, $26, $5A, $FF

; A = 0 when [HL] is in the $FF-terminated list Data_014_68CA, else $FF (E-0124)
; 3 call sites from 2 routines (e.g. RunNameEntryStateWhenNotFading_Case00_Case04_Sub01, ToggleVoicingMarkOnNameEntry)
IsHLByteInList68CA::
Func_014_68B5:: ; address name
    ld de, Data_014_68CA

Jump_014_68B8::
    ld a, [de]
    cp a, $FF
    jr z, Jump_014_68C7
    ld b, a
    ld a, [hl]
    cp a, b
    jr z, Jump_014_68C5
    inc de
    jr Jump_014_68B8

Jump_014_68C5::
    xor a, a
    ret

Jump_014_68C7::
    ld a, $FF
    ret

; address loaded by IsHLByteInList68CA
Data_014_68CA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $3E, $3F, $40, $41, $42, $75, $76, $77, $78, $79, $FF

; only called from RunNameEntryStateWhenNotFading_Case05 (E-0047)
; 1 call site from 1 routine (e.g. RunNameEntryStateWhenNotFading_Case05)
; reads: wJoypadPressedRepeat, wJoypadPressed, wNameEntryMenuCursor
; writes: wMenuInputResult, wNameEntryMenuCursor, wNameEntryBlink
RunNameEntryStateWhenNotFading_Case05_Sub01::
Func_014_68D5:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, Jump_014_68F3
    bit 7, a
    jr nz, Jump_014_6909
    ld a, [wJoypadPressed]
    bit 0, a
    jr nz, Jump_014_692F
    bit 1, a
    jr nz, Jump_014_693D
    call BlinkCursorNameEntryBlink_Bank14
    xor a, a
    ld [wMenuInputResult], a
    ret

Jump_014_68F3::
    call DrawBlankTileC3_695A
    ld a, [wNameEntryMenuCursor]
    and a, a
    jr nz, Jump_014_6903
    ld a, $01
    ld [wNameEntryMenuCursor], a
    jr Jump_014_691D

Jump_014_6903::
    dec a
    ld [wNameEntryMenuCursor], a
    jr Jump_014_691D

Jump_014_6909::
    call DrawBlankTileC3_695A
    ld a, [wNameEntryMenuCursor]
    cp a, $01
    jr c, Jump_014_6919
    xor a, a
    ld [wNameEntryMenuCursor], a
    jr Jump_014_691D

Jump_014_6919::
    inc a
    ld [wNameEntryMenuCursor], a

Jump_014_691D::
    xor a, a
    ld [wNameEntryBlink], a
    call BlinkCursorNameEntryBlink_Bank14
    ld a, $69
    call QueueSoundEffect
    ld a, $FD
    ld [wMenuInputResult], a
    ret

Jump_014_692F::
    ld a, $69
    call QueueSoundEffect
    call RunNameEntryStateWhenNotFading_Case05_Sub01_Sub01
    ld a, $FF
    ld [wMenuInputResult], a
    ret

Jump_014_693D::
    ld a, $FE
    ld [wMenuInputResult], a
    ret

; cycles wCFBE through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3) for $10-$17 (E-0122)
; 2 call sites from 1 routine (e.g. RunNameEntryStateWhenNotFading_Case05_Sub01)
; reads: wNameEntryBlink, wNameEntryMenuCursor
; writes: wNameEntryBlink
BlinkCursorNameEntryBlink_Bank14::
Func_014_6943:: ; address name
    ld a, [wNameEntryBlink]
    inc a
    ld [wNameEntryBlink], a
    cp a, $10
    jr c, Jump_014_6956
    cp a, $18
    jr c, DrawBlankTileC3_695A
    xor a, a
    ld [wNameEntryBlink], a

Jump_014_6956::
    ld b, $BB
    jr Jump_014_6960

; B = $C3 (blank tile) and joins the cursor draw (E-0122)
; 2 call sites from 1 routine (e.g. RunNameEntryStateWhenNotFading_Case05_Sub01)
; reads: wNameEntryMenuCursor
DrawBlankTileC3_695A::
Func_014_695A:: ; address name
    ld b, $C3
    jr Jump_014_6960

; only called from RunNameEntryStateWhenNotFading_Case05_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. RunNameEntryStateWhenNotFading_Case05_Sub01)
; reads: wNameEntryMenuCursor
RunNameEntryStateWhenNotFading_Case05_Sub01_Sub01::
Func_014_695E:: ; address name
    ld b, $BC

Jump_014_6960::
    ld a, [wNameEntryMenuCursor]
    add a, a
    ld hl, Data_014_697D
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank14_6BCF
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; address loaded by RunNameEntryStateWhenNotFading_Case05_Sub01_Sub01
Data_014_697D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2F, $01, $6F, $01

; Copies 16 bytes from [HL] to [DE]; each byte is written with interrupts off after waiting for rSTAT bit 1 to clear; clobbers A, C; HL and DE advance (the same 17 bytes appear in 7 banks)
; 2 call sites from 2 routines (e.g. CopyTileForNameEntryLength, RunNameEntryStateWhenNotFading_Case00_Case02)
; reads: rSTAT
CopyTileBytesToVRAM_Bank14::
Func_014_6981:: ; address name
    ld c, $10

Jump_014_6983::
    di

Jump_014_6984::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_014_6984
    ld a, [hl+]
    ld [de], a
    inc de
    ei
    dec c
    jr nz, Jump_014_6983
    ret

; only called from routines of RunNameEntryStateWhenNotFading (E-0098)
; 2 call sites from 2 routines (e.g. RunNameEntryStateWhenNotFading_Case01_Case03, RunNameEntryStateWhenNotFading_Case01_Case00)
; writes: wNameEntryByteBC
; points at: wNameEntryText
RunNameEntryStateWhenNotFading_Shared02::
Func_014_6992:: ; address name
    ld hl, wNameEntryText
    ld bc, $0000

Jump_014_6998::
    ld a, [hl]
    cp a, $F0
    ret z
    ld [wNameEntryByteBC], a
    push hl
    ld hl, $4010
    swap a
    ld d, a
    and a, $F0
    ld e, a
    ld a, d
    and a, $0F
    ld d, a
    add hl, de
    ld e, l
    ld d, h
    push de
    ld e, c
    ld d, b
    ld hl, vTiles2 + $500
    add hl, de
    pop de
    push bc
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    pop bc
    pop hl
    inc hl
    ld a, $10
    add a, c
    ld c, a
    jr nc, Jump_014_69CA
    inc b

Jump_014_69CA::
    jp Jump_014_6998
    db $40, $95, $30, $95, $20, $95, $10, $95, $00, $95, $D9, $69, $AD, $CF, $D5, $FA
    db $2D, $C5, $EA, $31, $C5, $EA, $35, $C5, $FA, $2E, $C5, $EA, $32, $C5, $EA, $36
    db $C5, $D1, $CD, $40, $2E, $7B, $EA, $33, $C5, $EA, $37, $C5, $7A, $EA, $34, $C5
    db $EA, $38, $C5, $3E, $01, $EA, $2B, $C5, $AF, $EA, $2C, $C5, $EA, $4F, $C5, $C9

; writes B at the BG map entry BGMapAddressAtScroll + $47 (row 2, column 7 of the view) + wCFC2, with interrupts off after rSTAT bit 1 clears; BC kept (E-0079)
; 6 call sites from 4 routines (e.g. RunNameEntryStateWhenNotFading_Case00_Case04_Sub01, CopyF0StringAndRedrawNameEntry, RunNameEntryStateWhenNotFading_Case01_Case01, RunNameEntryStateWhenNotFading_Case01_Case00)
; reads: wNameEntryLength, rSTAT
WriteTileBAtScrollOffset47PlusNameEntryLength::
Func_014_6A0D:: ; address name
    push bc
    call BGMapAddressAtScroll_Bank14_6BCF
    ld de, $0047
    add hl, de
    ld a, [wNameEntryLength]
    add_a_to_hl
    pop bc
    di

Jump_014_6A1F::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_014_6A1F
    ld [hl], b
    ei
    ret

; only called from routines of RunNameEntryStateWhenNotFading (E-0098)
; 2 call sites from 2 routines (e.g. RunNameEntryStateWhenNotFading_Case00_Case04, RunNameEntryStateWhenNotFading_Case01_Case01)
; points at: wNameEntryText
RunNameEntryStateWhenNotFading_Shared03::
Func_014_6A28:: ; address name
    ld hl, wNameEntryText
    ld c, $00

Jump_014_6A2D::
    ld a, $F0
    ld [hl+], a
    inc c
    ld a, c
    cp a, $0B
    jr c, Jump_014_6A2D
    ld hl, wNameEntryText
    ld c, $00

Jump_014_6A3B::
    ld a, $9F
    ld [hl+], a
    inc c
    ld a, c
    cp a, $05
    jr c, Jump_014_6A3B
    ret

; only called from RunNameEntryStateWhenNotFading_Case03_Case00 (E-0047)
; 1 call site from 1 routine (e.g. RunNameEntryStateWhenNotFading_Case03_Case00)
; reads: wArg1, wGridCursorX
; writes: rRAMG2, rRAMB
; points at: sRecords, wNameEntryText, wPartyList
RunNameEntryStateWhenNotFading_Case03_Case00_Sub01::
Func_014_6A45:: ; address name
    ld hl, sRecords
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld c, $00

Jump_014_6A53::
    ld a, [hl]
    and a, a
    jr z, Jump_014_6A7E
    push bc
    push hl
    inc hl
    ld de, wNameEntryText
    ld c, $00
    ld b, $00

Jump_014_6A61::
    ld a, [de]
    cp a, $9F
    jr nz, Jump_014_6A69
    inc de
    jr Jump_014_6A61

Jump_014_6A69::
    ld a, [de]
    cp a, $F0
    jr z, Jump_014_6A8D
    push bc
    ld b, a
    ld a, [hl]
    cp a, b
    jr nz, Jump_014_6A7B
    pop bc
    inc de
    inc hl
    inc c
    inc b
    jr Jump_014_6A61

Jump_014_6A7B::
    pop bc

Jump_014_6A7C::
    pop hl
    pop bc

Jump_014_6A7E::
    ld a, $A5
    add_a_to_hl
    inc c
    ld a, c
    cp a, $1E
    jr c, Jump_014_6A53
    xor a, a
    ret

Jump_014_6A8D::
    ld a, c
    cp a, $0A
    jr z, Jump_014_6A97
    ld a, [hl]
    cp a, $F0
    jr nz, Jump_014_6A7C

Jump_014_6A97::
    ld a, [wArg1]
    cp a, $03
    jr nz, Jump_014_6AB2
    ld hl, wPartyList
    ld a, [wGridCursorX]
    add_a_to_hl
    ld e, [hl]
    pop hl
    pop bc
    push bc
    push hl
    ld a, c
    cp a, e
    jr z, Jump_014_6A7C

Jump_014_6AB2::
    pop hl
    pop bc
    ld a, $FF
    ret

; only called from RunNameEntryStateWhenNotFading_Case03_Case00 (E-0047)
; 3 call sites from 1 routine (e.g. RunNameEntryStateWhenNotFading_Case03_Case00)
; reads: wArg1
; points at: wNameEntryText
RunNameEntryStateWhenNotFading_Case03_Case00_Sub02::
Func_014_6AB7:: ; address name
    ld hl, RejectedNameList
    ld c, $00

Jump_014_6ABC::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_014_6AF0
    push bc
    push hl
    ld de, wNameEntryText
    ld c, $00
    ld b, $00

Jump_014_6ACA::
    ld a, [de]
    cp a, $9F
    jr nz, Jump_014_6AD2
    inc de
    jr Jump_014_6ACA

Jump_014_6AD2::
    ld a, [de]
    cp a, $F0
    jr z, Jump_014_6AF2
    push bc
    ld b, a
    ld a, [hl]
    cp a, b
    jr nz, Jump_014_6AE4
    pop bc
    inc de
    inc hl
    inc c
    inc b
    jr Jump_014_6ACA

Jump_014_6AE4::
    pop bc

Jump_014_6AE5::
    pop hl
    pop bc
    ld a, $0A
    add_a_to_hl
    jr Jump_014_6ABC

Jump_014_6AF0::
    xor a, a
    ret

Jump_014_6AF2::
    ld a, c
    cp a, $0A
    jr z, Jump_014_6AFC
    ld a, [hl]
    cp a, $F0
    jr nz, Jump_014_6AE5

Jump_014_6AFC::
    ld a, [wArg1]
    cp a, $03
    jr nz, Jump_014_6B03

Jump_014_6B03::
    pop hl
    pop bc
    ld a, $FF
    ret

; only called from RunNameEntryStateWhenNotFading_Case03_Case00 (E-0047)
; 3 call sites from 1 routine (e.g. RunNameEntryStateWhenNotFading_Case03_Case00)
; points at: wNameEntryText
RunNameEntryStateWhenNotFading_Case03_Case00_Sub03::
Func_014_6B08:: ; address name
    ld hl, wNameEntryText
    ld c, $00
    ld b, [hl]
    inc hl
    ld a, [hl-]
    cp a, $8D
    jr z, Jump_014_6B1D
    cp a, $8E
    jr z, Jump_014_6B1D
    xor a, a
    ld e, $00
    jr Jump_014_6B21

Jump_014_6B1D::
    ld d, a
    ld e, $01
    inc hl

Jump_014_6B21::
    inc hl

Jump_014_6B22::
    ld a, [hl]
    cp a, $9F
    jr z, Jump_014_6B61
    cp a, $F0
    jr z, Jump_014_6B64
    ld a, e
    and a, a
    jr z, Jump_014_6B48
    ld a, [hl]
    cp a, $8D
    jr z, Jump_014_6B58
    cp a, $8E
    jr z, Jump_014_6B58
    ld a, [hl]
    cp a, b
    jr nz, Jump_014_6B74
    inc hl
    ld a, [hl-]
    cp a, $8D
    jr z, Jump_014_6B61
    cp a, $8E
    jr z, Jump_014_6B61
    jr Jump_014_6B74

Jump_014_6B48::
    ld a, [hl]
    cp a, b
    jr nz, Jump_014_6B74
    inc hl
    ld a, [hl-]
    cp a, $8D
    jr z, Jump_014_6B61
    cp a, $8E
    jr z, Jump_014_6B61
    jr Jump_014_6B5B

Jump_014_6B58::
    cp a, d
    jr nz, Jump_014_6B74

Jump_014_6B5B::
    inc c
    ld a, c
    cp a, $03
    jr nc, Jump_014_6B64

Jump_014_6B61::
    inc hl
    jr Jump_014_6B22

Jump_014_6B64::
    ld a, c
    cp a, $03
    jr c, Jump_014_6B6C
    ld a, $FF
    ret

Jump_014_6B6C::
    ld a, b
    cp a, $90
    jr nz, Jump_014_6B74
    ld a, $FF
    ret

Jump_014_6B74::
    xor a, a
    ret

; only called from routines of RunNameEntryStateWhenNotFading (E-0098)
; 3 call sites from 3 routines (e.g. RunNameEntryStateWhenNotFading_Case03_Case05, RunNameEntryStateWhenNotFading_Case03_Case04, RunNameEntryStateWhenNotFading_Case03_Case01)
; reads: wNameEntryByteC4, wTextFlags, wArg1
; writes: wNameEntryByteC4, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
RunNameEntryStateWhenNotFading_Shared04::
Func_014_6B76:: ; address name
    ld a, [wNameEntryByteC4]
    and a, a
    jr z, Jump_014_6B82
    cp a, $01
    jr z, Jump_014_6BA4
    jr Jump_014_6BBF

Jump_014_6B82::
    ld hl, vTiles2 + $5C0
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
    ld a, [wNameEntryByteC4]
    inc a
    ld [wNameEntryByteC4], a
    xor a, a
    ret

Jump_014_6BA4::
    ld a, [wArg1]
    cp a, $03
    jr z, Jump_014_6BB0
    ld de, Data_014_7003
    jr Jump_014_6BB3

Jump_014_6BB0::
    ld de, StringCategories_14_706D

Jump_014_6BB3::
    call BeginStringDisplay
    ld a, [wNameEntryByteC4]
    inc a
    ld [wNameEntryByteC4], a
    xor a, a
    ret

Jump_014_6BBF::
    ld a, [wTextFlags]
    bit 0, a
    jr nz, Jump_014_6BCD
    xor a, a
    ld [wNameEntryByteC4], a
    ld a, $FF
    ret

Jump_014_6BCD::
    xor a, a
    ret

; HL = $9800 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX, hScrollY); clobbers A, DE (the same 41 bytes appear in 3 banks)
; 12 call sites from 11 routines (e.g. RunNameEntryStateWhenNotFading_Case07, RunNameEntryStateWhenNotFading_Case05_Sub01_Sub01, RunNameEntryStateWhenNotFading_Case04, RunNameEntryStateWhenNotFading_Case01_Case00_Sub02, ...)
; reads: hScrollY, hScrollX
BGMapAddressAtScroll_Bank14_6BCF::
Func_014_6BCF:: ; address name
    ldh a, [hScrollY]
    and a, $F8
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add a, $00
    ld e, a
    ld a, d
    adc a, $98
    ld d, a
    ldh a, [hScrollX]
    srl a
    srl a
    srl a
    add a, e
    ld e, a
    jr nc, Jump_014_6BF3
    inc d

Jump_014_6BF3::
    ld a, e
    ld l, a
    ld a, d
    ld h, a
    ret

; only called from routines of RunNameEntryStateWhenNotFading (E-0098)
; 3 call sites from 3 routines (e.g. RunNameEntryStateWhenNotFading_Case00_Case01, RunNameEntryStateWhenNotFading_Case01_Case09, RunNameEntryStateWhenNotFading_Case01_Case04)
; reads: wNameEntryTimer
; writes: wNameEntryTimer, wNameEntryByteAC
RunNameEntryStateWhenNotFading_Shared05::
Func_014_6BF8:: ; address name
    push hl
    push de
    ld a, [wNameEntryTimer]
    add a, a
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    jp z, Jump_014_6C33
    ld e, a
    inc hl
    ld h, [hl]
    ld l, e
    pop de
    push de
    push hl
    ld a, [wNameEntryTimer]
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_014_6C19
    inc d

Jump_014_6C19::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld d, a
    ld a, l
    ld e, a
    pop hl
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    pop de
    pop hl
    ld a, [wNameEntryTimer]
    inc a
    ld [wNameEntryTimer], a
    jr RunNameEntryStateWhenNotFading_Shared05

Jump_014_6C33::
    pop de
    pop hl
    xor a, a
    ld [wNameEntryTimer], a
    ld [wNameEntryByteAC], a
    ld a, $FF
    ret

; copies the 16-byte tile at Data_014_6C60 to the VRAM address from the word table Data_014_6C56 + 2 * wCFC2 (CopyTileBytesToVRAM_Bank14) (E-0119)
; 4 call sites from 3 routines (e.g. RunNameEntryStateWhenNotFading_Case00_Case04_Sub01, RunNameEntryStateWhenNotFading_Case01_Case01, ToggleVoicingMarkOnNameEntry)
; reads: wNameEntryLength
CopyTileForNameEntryLength::
Func_014_6C3F:: ; address name
    ld hl, Data_014_6C56
    ld a, [wNameEntryLength]
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    ld de, Data_014_6C60
    call CopyTileBytesToVRAM_Bank14
    ret

; address loaded by CopyTileForNameEntryLength
Data_014_6C56:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $95, $10, $95, $20, $95, $30, $95, $40, $95

; address loaded by CopyTileForNameEntryLength
Data_014_6C60:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00

; only called from RunNameEntryStateWhenNotFading_Case01_Case03 (E-0047)
; 1 call site from 1 routine (e.g. RunNameEntryStateWhenNotFading_Case01_Case03)
; reads: wArg1, wRandomLo, wArg3, wArg2
; writes: wNameEntryLength, wNameEntryByteC3
; points at: wNameEntryText
RunNameEntryStateWhenNotFading_Case01_Case03_Sub01::
Func_014_6C70:: ; address name
    ld a, [wArg1]
    or a, a
    jp z, Jump_014_6D28
    ld a, [wRandomLo]
    ld b, a

Jump_014_6C7B::
    ld a, b
    cp a, $4D
    jr c, Jump_014_6C85
    sub a, $4D
    ld b, a
    jr Jump_014_6C7B

Jump_014_6C85::
    and a, $7F
    cp a, $07
    jp nc, Jump_014_6CC0
    ld b, a
    ld hl, Data_014_7439
    ld a, [wArg3]
    and a, $0F
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, [wArg2]
    ld c, a
    add a, a
    add a, c
    ld c, a
    ld a, [wArg2]
    add a, a
    add a, a
    add a, c
    ld c, a
    ld a, b
    add a, c
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_014_6CB4
    inc d

Jump_014_6CB4::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld de, wNameEntryText
    call CopyF0StringAndRedrawNameEntry
    ret

Jump_014_6CC0::
    sub a, $07
    ld b, a
    push bc
    ld a, [wArg2]
    and a, $01
    ld c, $46
    call Multiply8
    pop bc
    ld a, b
    add a, l
    ld de, Data_014_791F
    ld l, a
    ld h, $00
    sla l
    rl h
    add hl, de
    ld e, l
    ld d, h
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld de, wNameEntryText
    call CopyF0StringAndRedrawNameEntry
    ret

; copies the $F0-terminated string at HL to DE, then erases the name-entry cursor tile and redraws wNameEntryText glyph by glyph (handling the $9F cursor end and the $8D/$8E voicing marks) (E-0175)
; 2 call sites from 1 routine (e.g. RunNameEntryStateWhenNotFading_Case01_Case03_Sub01)
; writes: wNameEntryLength, wNameEntryByteC3
; points at: wNameEntryText
CopyF0StringAndRedrawNameEntry::
Func_014_6CEA:: ; address name
    ld a, [hl]
    cp a, $F0
    jr z, Jump_014_6CF4
    ld [de], a
    inc de
    inc hl
    jr CopyF0StringAndRedrawNameEntry

Jump_014_6CF4::
    ld b, $C3
    call WriteTileBAtScrollOffset47PlusNameEntryLength
    ld hl, wNameEntryText
    ld c, $00

Jump_014_6CFE::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_014_6D13
    cp a, $9F
    jr z, Jump_014_6D18
    cp a, $8D
    jr z, Jump_014_6D10
    cp a, $8E
    jr z, Jump_014_6D10
    inc c

Jump_014_6D10::
    inc hl
    jr Jump_014_6CFE

Jump_014_6D13::
    ld a, $01
    ld [wNameEntryByteC3], a

Jump_014_6D18::
    ld a, c
    cp a, $05
    jr c, Jump_014_6D1F
    ld a, $04

Jump_014_6D1F::
    ld [wNameEntryLength], a
    ld b, $55
    call WriteTileBAtScrollOffset47PlusNameEntryLength
    ret

Jump_014_6D28::
    ld a, [wArg2]
    or a, a
    jr nz, Jump_014_6D42
    ld hl, wNameEntryText
    ld hl, wNameEntryText
    ld a, $0C
    ld [hl+], a
    ld a, $32
    ld [hl+], a
    ld a, $25
    ld [hl+], a
    ld a, $2C
    ld [hl], a
    jr Jump_014_6D54

Jump_014_6D42::
    ld hl, wNameEntryText
    ld hl, wNameEntryText
    ld a, $1D
    ld [hl+], a
    ld a, $24
    ld [hl+], a
    ld a, $35
    ld [hl+], a
    ld a, $24
    ld [hl], a

Jump_014_6D54::
    jr Jump_014_6CF4

; E-0224 (C1: RunNameEntryStateWhenNotFading_Shared05 copies 16 bytes from bank $1F for each destination word (until a low byte of $FF) from the parallel source list in DE; ScriptCommandEC_Run_Case01 also passes $6D84, entry 23 of this list, to LoadTileListSixPerCall).
; record: 79 VRAM destinations, then $FFFF
NameEntryTileDestList::
Data_014_6D56:: ; address name
    dw vTiles2 + $20, vTiles2 + $30, vTiles2 + $40, vTiles2 + $50, vTiles2 + $60, vTiles2 + $70, vTiles2 + $80, vTiles2 + $90 ; entry 0
    dw vTiles2 + $A0, vTiles2 + $B0, vTiles2 + $C0, vTiles2 + $D0, vTiles2 + $E0, vTiles2 + $F0, vTiles2 + $100, vTiles2 + $110
    dw vTiles2 + $120, vTiles2 + $130, vTiles2 + $140, vTiles2 + $150, vTiles2 + $160, vTiles2 + $170, vTiles2 + $180, vTiles2 + $190
    dw vTiles2 + $1A0, vTiles2 + $1B0, vTiles2 + $1C0, vTiles2 + $1D0, vTiles2 + $1E0, vTiles2 + $1F0, vTiles2 + $200, vTiles2 + $210
    dw vTiles2 + $220, vTiles2 + $230, vTiles2 + $240, vTiles2 + $250, vTiles2 + $260, vTiles2 + $270, vTiles2 + $280, vTiles2 + $290
    dw vTiles2 + $2A0, vTiles2 + $2B0, vTiles2 + $2C0, vTiles2 + $2D0, vTiles2 + $2E0, vTiles2 + $2F0, vTiles2 + $300, vTiles2 + $310
    dw vTiles2 + $320, vTiles2 + $330, vTiles2 + $340, vTiles2 + $350, vTiles2 + $360, vTiles2 + $370, vTiles2 + $380, vTiles2 + $390
    dw vTiles2 + $3A0, vTiles2 + $3B0, vTiles2 + $3C0, vTiles2 + $3D0, vTiles2 + $3E0, vTiles2 + $3F0, vTiles2 + $400, vTiles2 + $410
    dw vTiles2 + $420, vTiles2 + $430, vTiles2 + $440, vTiles2 + $450, vTiles2 + $460, vTiles2 + $470, vTiles2 + $480, vTiles2 + $490
    dw vTiles2 + $4A0, vTiles2 + $4B0, vTiles2 + $500, vTiles2 + $510, vTiles2 + $520, vTiles2 + $530, vTiles2 + $540, rIE

; E-0224 (C1: RunNameEntryStateWhenNotFading_Case01_Case04 and _Case09 pass this list to RunNameEntryStateWhenNotFading_Shared05, which therefore copies nothing).
; record: $FFFF: no destinations
NameEntryTileDestListEmpty::
Data_014_6DF6:: ; address name
    dw $FFFF ; entry 0

; E-0224 (C1: the source list paired with NameEntryTileDestList (Case00_Case01) and with the empty list (Case01_Case09)).
; record: 80 bank-$1F tile sources (the last is $FFFF)
NameEntryTileSrcListA::
Data_014_6DF8:: ; address name
    dw $40B0, $40C0, $40D0, $40E0, $40F0, $4100, $4110, $4120 ; entry 0
    dw $4130, $4140, $4150, $4160, $4170, $4010, $4020, $4030
    dw $4040, $4180, $4190, $41A0, $41B0, $41C0, $41D0, $41E0
    dw $41F0, $4200, $4210, $4220, $4230, $4240, $4050, $4060
    dw $4070, $4080, $4250, $4260, $4270, $4280, $4290, $42A0
    dw $42B0, $42C0, $42D0, $42E0, $42F0, $4300, $4310, $4090
    dw $40A0, $49A0, $4990, $4320, $4330, $4340, $4350, $4360
    dw $4370, $4380, $4390, $43A0, $43B0, $43C0, $43D0, $43E0
    dw $40C0, $40B0, $40D0, $4150, $4960, $4AC0, $4B60, $4950
    dw $4940, $4B00, $4A00, $4A00, $4A00, $4A00, $4A00, $FFFF

; E-0224 (C1: passed with the empty destination list by Case01_Case04; 82 words and $FFFF, then 16 bytes of $FF before NameEntryKeyboard).
; record: 82 bank-$1F tile sources, then $FFFF
NameEntryTileSrcListB::
Data_014_6E98:: ; address name
    dw $4570, $4590, $45B0, $45D0, $45F0, $4610, $4620, $4630 ; entry 0
    dw $4640, $4650, $4660, $4670, $4680, $4690, $46A0, $46B0
    dw $46C0, $46D0, $46F0, $4700, $4710, $4720, $4730, $4740
    dw $4750, $4020, $4030, $4040, $4050, $4060, $4760, $4770
    dw $4780, $4790, $47A0, $47B0, $47C0, $47D0, $47E0, $47F0
    dw $4800, $4820, $4840, $4860, $4870, $4880, $4890, $48A0
    dw $48B0, $48C0, $48D0, $46E0, $49D0, $4070, $4080, $4090
    dw $40A0, $4010, $4580, $45A0, $45C0, $45E0, $4600, $4810
    dw $4830, $4850, $48E0, $48F0, $4400, $44F0, $42A0, $43A0
    dw $4480, $4510, $4290, $4540, $4510, $4A00, $4A00, $4A00
    dw $4A00, $4A00, $FFFF
    db $FF, $00, $FF, $FF, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; end

; E-0216 (C1: RunNameEntryStateWhenNotFading_Case01_Case02 reads the byte at $6F4E + 17 * wNameEntryCursorY + wNameEntryCursorX as the chosen character; rows 0-3 are A-M 0-3, N-Z 4-7, a-m 8 9 ! ?, n-z; 10 rows, then 11 bytes not placed in a row).
; record: one row of 17 character codes (charmap.inc; codes without a charmap entry print as bytes)
NameEntryKeyboard::
Data_014_6F4E:: ; address name
    db "ABCDEFGHIJKLM0123" ; id 0
    db "NOPQRSTUVWXYZ4567" ; id 1
    db "abcdefghijklm89!?" ; id 2
    db "nopqrstuvwxyz", $FE, $FF, $FF, $FF ; id 3
    db $95, ",.", $94, $93, " ", $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; id 4
    db $56, $58, $5A, $5C, $5E, $75, $76, $77, $78, $79, $57, $59, $5B, $5D, $5F, $FF, $60 ; id 5
    db $61, $62, $63, $64, $7A, $7B, $7C, $7D, $7E, $80, $82, $84, $8D, $8E, $FF, $65, $66 ; id 6
    db $67, $68, $69, $7F, $FF, $81, $FF, $83, $FF, $FF, $FF, $FF, $FF, $FF, $6A, $6B, $6C ; id 7
    db $6E, $6F, $85, $86, $87, $88, $89, $FD, $FF, $FF, $FF, $FF, $FF, $70, $71, $72, $73 ; id 8
    db $74, $8A, $8B, $8C, $6D, "-", $FE, $FF, $FF, $FF, $FF, $FF, "12345" ; id 9
    db $06, $07, $08, $09, $00, $FF, $FF, $FF, $FF, $FF, $FF ; end

; address loaded by RunNameEntryStateWhenNotFading_Shared04
Data_014_7003:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $05, $70, $0D, $70, $1C, $70, $2B, $70, $4D, $70
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Is ", $F9, "0 correct?", $F0, "Is ", $F9, "0 correct?", $F0, "A monster already", $F1
    db "has that name.", $F7
    db $F0, "Sorry, that name", $F1
    db "can't be used.", $F7
    db $F0

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_14_706D::
Data_014_706D:: ; address name
    dw StringList_14_706F ; id 0

; E-0217 (derived: category list of StringCategories_14_706D; one pointer per wStringIndex)
; record: string
StringList_14_706F::
Data_014_706F:: ; address name
    dw Data_014_7077 ; id 0
    dw Data_014_7084 ; id 1
    dw Data_014_7091 ; id 2
    dw Data_014_70B2 ; id 3

Data_014_7077:: ; heuristic: string; C0
    db $EB, $45, $90, $12, $36, $90, $F9, $00, $90, $18, $14, $98, $F0

Data_014_7084:: ; heuristic: string; C0
    db $EB, $45, $90, $12, $36, $90, $F9, $00, $90, $18, $14, $98, $F0

Data_014_7091:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " That name is", $F1
    db "already in use.", $F7
    db $F0

Data_014_70B2:: ; heuristic: string; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " That name can't", $F1
    db "be used.", $FA, $F7
    db $F2, "You'll have to use", $F1
    db "another name.", $F7
    db $F0

; E-0191 (C1: RunNameEntryStateWhenNotFading_Case03_Case00_Sub02 walks 10-byte records from $70F0 until a first byte of $FF, comparing each with wNameEntryText (skipping $9F bytes) up to its $F0; 84 records, each in mixed case and capitals, then the $FF terminator).
; record: a name the name entry screen refuses: text ending in $F0, zero padded to 10 bytes
RejectedNameList::
Data_014_70F0:: ; address name
    db "Ass", $F0, $00, $00, $00, $00, $00, $00 ; id 0
    db "ASS", $F0, $00, $00, $00, $00, $00, $00 ; id 1
    db "Dink", $F0, $00, $00, $00, $00, $00 ; id 2
    db "DINK", $F0, $00, $00, $00, $00, $00 ; id 3
    db "Dork", $F0, $00, $00, $00, $00, $00 ; id 4
    db "DORK", $F0, $00, $00, $00, $00, $00 ; id 5
    db "Cunt", $F0, $00, $00, $00, $00, $00 ; id 6
    db "CUNT", $F0, $00, $00, $00, $00, $00 ; id 7
    db "Kunt", $F0, $00, $00, $00, $00, $00 ; id 8
    db "KUNT", $F0, $00, $00, $00, $00, $00 ; id 9
    db "Fuck", $F0, $00, $00, $00, $00, $00 ; id 10
    db "FUCK", $F0, $00, $00, $00, $00, $00 ; id 11
    db "Shit", $F0, $00, $00, $00, $00, $00 ; id 12
    db "SHIT", $F0, $00, $00, $00, $00, $00 ; id 13
    db "Sex", $F0, $00, $00, $00, $00, $00, $00 ; id 14
    db "SEX", $F0, $00, $00, $00, $00, $00, $00 ; id 15
    db "Poop", $F0, $00, $00, $00, $00, $00 ; id 16
    db "POOP", $F0, $00, $00, $00, $00, $00 ; id 17
    db "Dong", $F0, $00, $00, $00, $00, $00 ; id 18
    db "DONG", $F0, $00, $00, $00, $00, $00 ; id 19
    db "Pene", $F0, $00, $00, $00, $00, $00 ; id 20
    db "PENE", $F0, $00, $00, $00, $00, $00 ; id 21
    db "Clit", $F0, $00, $00, $00, $00, $00 ; id 22
    db "CLIT", $F0, $00, $00, $00, $00, $00 ; id 23
    db "Twat", $F0, $00, $00, $00, $00, $00 ; id 24
    db "TWAT", $F0, $00, $00, $00, $00, $00 ; id 25
    db "Snot", $F0, $00, $00, $00, $00, $00 ; id 26
    db "SNOT", $F0, $00, $00, $00, $00, $00 ; id 27
    db "Fag", $F0, $00, $00, $00, $00, $00, $00 ; id 28
    db "FAG", $F0, $00, $00, $00, $00, $00, $00 ; id 29
    db "Homo", $F0, $00, $00, $00, $00, $00 ; id 30
    db "HOMO", $F0, $00, $00, $00, $00, $00 ; id 31
    db "Poon", $F0, $00, $00, $00, $00, $00 ; id 32
    db "POON", $F0, $00, $00, $00, $00, $00 ; id 33
    db "Piss", $F0, $00, $00, $00, $00, $00 ; id 34
    db "PISS", $F0, $00, $00, $00, $00, $00 ; id 35
    db "Prick", $F0, $00, $00, $00, $00 ; id 36
    db "PRICK", $F0, $00, $00, $00, $00 ; id 37
    db "Fukk", $F0, $00, $00, $00, $00, $00 ; id 38
    db "FUKK", $F0, $00, $00, $00, $00, $00 ; id 39
    db "Coon", $F0, $00, $00, $00, $00, $00 ; id 40
    db "COON", $F0, $00, $00, $00, $00, $00 ; id 41
    db "Nazi", $F0, $00, $00, $00, $00, $00 ; id 42
    db "NAZI", $F0, $00, $00, $00, $00, $00 ; id 43
    db "Niga", $F0, $00, $00, $00, $00, $00 ; id 44
    db "NIGA", $F0, $00, $00, $00, $00, $00 ; id 45
    db "Nigga", $F0, $00, $00, $00, $00 ; id 46
    db "NIGGA", $F0, $00, $00, $00, $00 ; id 47
    db "Jap", $F0, $00, $00, $00, $00, $00, $00 ; id 48
    db "JAP", $F0, $00, $00, $00, $00, $00, $00 ; id 49
    db "Jew", $F0, $00, $00, $00, $00, $00, $00 ; id 50
    db "JEW", $F0, $00, $00, $00, $00, $00, $00 ; id 51
    db "Wop", $F0, $00, $00, $00, $00, $00, $00 ; id 52
    db "WOP", $F0, $00, $00, $00, $00, $00, $00 ; id 53
    db "Spic", $F0, $00, $00, $00, $00, $00 ; id 54
    db "SPIC", $F0, $00, $00, $00, $00, $00 ; id 55
    db "Butt", $F0, $00, $00, $00, $00, $00 ; id 56
    db "BUTT", $F0, $00, $00, $00, $00, $00 ; id 57
    db "Perv", $F0, $00, $00, $00, $00, $00 ; id 58
    db "PERV", $F0, $00, $00, $00, $00, $00 ; id 59
    db "Dumb", $F0, $00, $00, $00, $00, $00 ; id 60
    db "DUMB", $F0, $00, $00, $00, $00, $00 ; id 61
    db "Dolt", $F0, $00, $00, $00, $00, $00 ; id 62
    db "DOLT", $F0, $00, $00, $00, $00, $00 ; id 63
    db "Anus", $F0, $00, $00, $00, $00, $00 ; id 64
    db "ANUS", $F0, $00, $00, $00, $00, $00 ; id 65
    db "Anal", $F0, $00, $00, $00, $00, $00 ; id 66
    db "ANAL", $F0, $00, $00, $00, $00, $00 ; id 67
    db "Jerk", $F0, $00, $00, $00, $00, $00 ; id 68
    db "JERK", $F0, $00, $00, $00, $00, $00 ; id 69
    db "Puke", $F0, $00, $00, $00, $00, $00 ; id 70
    db "PUKE", $F0, $00, $00, $00, $00, $00 ; id 71
    db "Snot", $F0, $00, $00, $00, $00, $00 ; id 72
    db "SNOT", $F0, $00, $00, $00, $00, $00 ; id 73
    db "Barf", $F0, $00, $00, $00, $00, $00 ; id 74
    db "BARF", $F0, $00, $00, $00, $00, $00 ; id 75
    db "Pus", $F0, $00, $00, $00, $00, $00, $00 ; id 76
    db "PUS", $F0, $00, $00, $00, $00, $00, $00 ; id 77
    db "Pussy", $F0, $00, $00, $00, $00 ; id 78
    db "PUSSY", $F0, $00, $00, $00, $00 ; id 79
    db "Bung", $F0, $00, $00, $00, $00, $00 ; id 80
    db "BUNG", $F0, $00, $00, $00, $00, $00 ; id 81
    db "Suck", $F0, $00, $00, $00, $00, $00 ; id 82
    db "SUCK", $F0, $00, $00, $00, $00, $00 ; id 83
    db $FF ; end

; address loaded by RunNameEntryStateWhenNotFading_Case01_Case03_Sub01, CreateMonsterRecordOfKindTemp1_Sub01_Sub01_Sub01
Data_014_7439:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_014_744F
    dw Data_014_74BF
    dw Data_014_752F
    dw Data_014_759F
    dw Data_014_760F
    dw Data_014_767F
    dw Data_014_76EF
    dw Data_014_775F
    dw Data_014_77CF
    dw Data_014_783F
    dw Data_014_78AF

Data_014_744F:: ; heuristic: target of a monotone pointer table; C0
    dw Data_014_746B
    dw Data_014_7471
    dw Data_014_7477
    dw Data_014_747D
    dw Data_014_7483
    dw Data_014_7489
    dw Data_014_748F
    dw Data_014_7495
    dw Data_014_749B
    dw Data_014_74A1
    dw Data_014_74A7
    dw Data_014_74AD
    dw Data_014_74B3
    dw Data_014_74B9

Data_014_746B:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2F, $2C, $25, $9F, $F0

Data_014_7471:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $24, $35, $26, $28, $F0

Data_014_7477:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $32, $31, $32, $9F, $F0

Data_014_747D:: ; heuristic: target of a monotone pointer table; C0
    db $16, $2C, $2F, $28, $36, $F0

Data_014_7483:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $25, $25, $24, $F0

Data_014_7489:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $28, $35, $2C, $32, $F0

Data_014_748F:: ; heuristic: target of a monotone pointer table; C0
    db $18, $31, $28, $32, $9F, $F0

Data_014_7495:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2F, $24, $35, $2C, $F0

Data_014_749B:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $28, $35, $24, $F0

Data_014_74A1:: ; heuristic: target of a monotone pointer table; C0
    db $19, $38, $35, $2F, $24, $F0

Data_014_74A7:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2C, $2E, $32, $35, $F0

Data_014_74AD:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $2C, $33, $33, $9F, $F0

Data_014_74B3:: ; heuristic: target of a monotone pointer table; C0
    db $19, $28, $37, $37, $2C, $F0

Data_014_74B9:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2B, $24, $2F, $32, $F0

Data_014_74BF:: ; heuristic: target of a monotone pointer table; C0
    dw Data_014_74DB
    dw Data_014_74E1
    dw Data_014_74E7
    dw Data_014_74ED
    dw Data_014_74F3
    dw Data_014_74F9
    dw Data_014_74FF
    dw Data_014_7505
    dw Data_014_750B
    dw Data_014_7511
    dw Data_014_7517
    dw Data_014_751D
    dw Data_014_7523
    dw Data_014_7529

Data_014_74DB:: ; heuristic: target of a monotone pointer table; C0
    db $11, $32, $35, $35, $3C, $F0

Data_014_74E1:: ; heuristic: target of a monotone pointer table; C0
    db $14, $24, $25, $28, $2F, $F0

Data_014_74E7:: ; heuristic: target of a monotone pointer table; C0
    db $10, $24, $2F, $28, $37, $F0

Data_014_74ED:: ; heuristic: target of a monotone pointer table; C0
    db $19, $32, $35, $33, $32, $F0

Data_014_74F3:: ; heuristic: target of a monotone pointer table; C0
    db $14, $28, $2D, $28, $37, $F0

Data_014_74F9:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $32, $35, $24, $27, $F0

Data_014_74FF:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $24, $35, $32, $31, $F0

Data_014_7505:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $32, $38, $2A, $28, $F0

Data_014_750B:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $3D, $24, $35, $2C, $F0

Data_014_7511:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2B, $24, $25, $32, $F0

Data_014_7517:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $35, $2C, $36, $36, $F0

Data_014_751D:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $38, $31, $24, $35, $F0

Data_014_7523:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $38, $27, $2C, $9F, $F0

Data_014_7529:: ; heuristic: target of a monotone pointer table; C0
    db $1F, $38, $3C, $9F, $9F, $F0

Data_014_752F:: ; heuristic: target of a monotone pointer table; C0
    dw Data_014_754B
    dw Data_014_7551
    dw Data_014_7557
    dw Data_014_755D
    dw Data_014_7563
    dw Data_014_7569
    dw Data_014_756F
    dw Data_014_7575
    dw Data_014_757B
    dw Data_014_7581
    dw Data_014_7587
    dw Data_014_758D
    dw Data_014_7593
    dw Data_014_7599

Data_014_754B:: ; heuristic: target of a monotone pointer table; C0
    db $1E, $3A, $2C, $31, $2A, $F0

Data_014_7551:: ; heuristic: target of a monotone pointer table; C0
    db $12, $39, $28, $35, $9F, $F0

Data_014_7557:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $32, $27, $30, $24, $F0

Data_014_755D:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $2C, $27, $2C, $28, $F0

Data_014_7563:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $35, $2A, $2A, $F0

Data_014_7569:: ; heuristic: target of a monotone pointer table; C0
    db $18, $2A, $24, $30, $2C, $F0

Data_014_756F:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $24, $35, $35, $32, $F0

Data_014_7575:: ; heuristic: target of a monotone pointer table; C0
    db $17, $2C, $2E, $2C, $37, $F0

Data_014_757B:: ; heuristic: target of a monotone pointer table; C0
    db $16, $28, $36, $36, $24, $F0

Data_014_7581:: ; heuristic: target of a monotone pointer table; C0
    db $15, $24, $35, $30, $24, $F0

Data_014_7587:: ; heuristic: target of a monotone pointer table; C0
    db $13, $24, $31, $31, $38, $F0

Data_014_758D:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $28, $39, $35, $2C, $F0

Data_014_7593:: ; heuristic: target of a monotone pointer table; C0
    db $13, $24, $39, $28, $2F, $F0

Data_014_7599:: ; heuristic: target of a monotone pointer table; C0
    db $10, $38, $35, $35, $2C, $F0

Data_014_759F:: ; heuristic: target of a monotone pointer table; C0
    dw Data_014_75BB
    dw Data_014_75C1
    dw Data_014_75C7
    dw Data_014_75CD
    dw Data_014_75D3
    dw Data_014_75D9
    dw Data_014_75DF
    dw Data_014_75E5
    dw Data_014_75EB
    dw Data_014_75F1
    dw Data_014_75F7
    dw Data_014_75FD
    dw Data_014_7603
    dw Data_014_7609

Data_014_75BB:: ; heuristic: target of a monotone pointer table; C0
    db $19, $24, $37, $37, $24, $F0

Data_014_75C1:: ; heuristic: target of a monotone pointer table; C0
    db $1F, $28, $31, $2D, $3C, $F0

Data_014_75C7:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $31, $2A, $3C, $9F, $F0

Data_014_75CD:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $32, $39, $3C, $31, $F0

Data_014_75D3:: ; heuristic: target of a monotone pointer table; C0
    db $15, $28, $2C, $37, $9F, $F0

Data_014_75D9:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $3C, $35, $32, $31, $F0

Data_014_75DF:: ; heuristic: target of a monotone pointer table; C0
    db $17, $2C, $2F, $36, $28, $F0

Data_014_75E5:: ; heuristic: target of a monotone pointer table; C0
    db $19, $24, $2E, $2C, $31, $F0

Data_014_75EB:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $28, $35, $35, $9F, $F0

Data_014_75F1:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $24, $30, $24, $35, $F0

Data_014_75F7:: ; heuristic: target of a monotone pointer table; C0
    db $14, $24, $26, $2C, $36, $F0

Data_014_75FD:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $24, $2E, $2C, $9F, $F0

Data_014_7603:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $2F, $2F, $2C, $F0

Data_014_7609:: ; heuristic: target of a monotone pointer table; C0
    db $16, $32, $2E, $32, $9F, $F0

Data_014_760F:: ; heuristic: target of a monotone pointer table; C0
    dw Data_014_762B
    dw Data_014_7631
    dw Data_014_7637
    dw Data_014_763D
    dw Data_014_7643
    dw Data_014_7649
    dw Data_014_764F
    dw Data_014_7655
    dw Data_014_765B
    dw Data_014_7661
    dw Data_014_7667
    dw Data_014_766D
    dw Data_014_7673
    dw Data_014_7679

Data_014_762B:: ; heuristic: target of a monotone pointer table; C0
    db $10, $24, $31, $2C, $30, $F0

Data_014_7631:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $28, $2F, $35, $2C, $F0

Data_014_7637:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $24, $2C, $30, $9F, $F0

Data_014_763D:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $24, $35, $3D, $3D, $F0

Data_014_7643:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2C, $37, $24, $9F, $F0

Data_014_7649:: ; heuristic: target of a monotone pointer table; C0
    db $19, $28, $3C, $32, $37, $F0

Data_014_764F:: ; heuristic: target of a monotone pointer table; C0
    db $16, $38, $33, $33, $24, $F0

Data_014_7655:: ; heuristic: target of a monotone pointer table; C0
    db $15, $24, $39, $28, $31, $F0

Data_014_765B:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $24, $35, $24, $27, $F0

Data_014_7661:: ; heuristic: target of a monotone pointer table; C0
    db $10, $3C, $24, $30, $9F, $F0

Data_014_7667:: ; heuristic: target of a monotone pointer table; C0
    db $10, $38, $30, $30, $3C, $F0

Data_014_766D:: ; heuristic: target of a monotone pointer table; C0
    db $19, $38, $33, $38, $2F, $F0

Data_014_7673:: ; heuristic: target of a monotone pointer table; C0
    db $1F, $24, $31, $3C, $2F, $F0

Data_014_7679:: ; heuristic: target of a monotone pointer table; C0
    db $19, $32, $33, $2F, $24, $F0

Data_014_767F:: ; heuristic: target of a monotone pointer table; C0
    dw Data_014_769B
    dw Data_014_76A1
    dw Data_014_76A7
    dw Data_014_76AD
    dw Data_014_76B3
    dw Data_014_76B9
    dw Data_014_76BF
    dw Data_014_76C5
    dw Data_014_76CB
    dw Data_014_76D1
    dw Data_014_76D7
    dw Data_014_76DD
    dw Data_014_76E3
    dw Data_014_76E9

Data_014_769B:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $25, $2C, $2C, $9F, $F0

Data_014_76A1:: ; heuristic: target of a monotone pointer table; C0
    db $1E, $2F, $35, $2C, $2E, $F0

Data_014_76A7:: ; heuristic: target of a monotone pointer table; C0
    db $20, $28, $35, $37, $2B, $F0

Data_014_76AD:: ; heuristic: target of a monotone pointer table; C0
    db $10, $35, $38, $31, $37, $F0

Data_014_76B3:: ; heuristic: target of a monotone pointer table; C0
    db $10, $2F, $24, $37, $2B, $F0

Data_014_76B9:: ; heuristic: target of a monotone pointer table; C0
    db $10, $24, $30, $2B, $24, $F0

Data_014_76BF:: ; heuristic: target of a monotone pointer table; C0
    db $16, $32, $24, $2B, $30, $F0

Data_014_76C5:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $35, $32, $31, $F0

Data_014_76CB:: ; heuristic: target of a monotone pointer table; C0
    db $1A, $38, $2C, $2C, $9F, $F0

Data_014_76D1:: ; heuristic: target of a monotone pointer table; C0
    db $14, $32, $2E, $2C, $36, $F0

Data_014_76D7:: ; heuristic: target of a monotone pointer table; C0
    db $13, $38, $27, $27, $2C, $F0

Data_014_76DD:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2B, $28, $35, $35, $F0

Data_014_76E3:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2F, $2C, $36, $36, $F0

Data_014_76E9:: ; heuristic: target of a monotone pointer table; C0
    db $10, $38, $39, $35, $2C, $F0

Data_014_76EF:: ; heuristic: target of a monotone pointer table; C0
    dw Data_014_770B
    dw Data_014_7711
    dw Data_014_7717
    dw Data_014_771D
    dw Data_014_7723
    dw Data_014_7729
    dw Data_014_772F
    dw Data_014_7735
    dw Data_014_773B
    dw Data_014_7741
    dw Data_014_7747
    dw Data_014_774D
    dw Data_014_7753
    dw Data_014_7759

Data_014_770B:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $24, $30, $2C, $24, $F0

Data_014_7711:: ; heuristic: target of a monotone pointer table; C0
    db $1A, $38, $25, $28, $9F, $F0

Data_014_7717:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $2C, $2A, $2A, $9F, $F0

Data_014_771D:: ; heuristic: target of a monotone pointer table; C0
    db $13, $24, $3B, $32, $31, $F0

Data_014_7723:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2B, $28, $2F, $9F, $F0

Data_014_7729:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $24, $38, $36, $36, $F0

Data_014_772F:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $31, $26, $2B, $32, $F0

Data_014_7735:: ; heuristic: target of a monotone pointer table; C0
    db $12, $3C, $24, $31, $9F, $F0

Data_014_773B:: ; heuristic: target of a monotone pointer table; C0
    db $12, $35, $35, $2C, $36, $F0

Data_014_7741:: ; heuristic: target of a monotone pointer table; C0
    db $14, $28, $35, $2C, $2A, $F0

Data_014_7747:: ; heuristic: target of a monotone pointer table; C0
    db $14, $24, $2C, $26, $32, $F0

Data_014_774D:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $24, $2F, $32, $35, $F0

Data_014_7753:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $2E, $31, $28, $36, $F0

Data_014_7759:: ; heuristic: target of a monotone pointer table; C0
    db $17, $2C, $39, $28, $2F, $F0

Data_014_775F:: ; heuristic: target of a monotone pointer table; C0
    dw Data_014_777B
    dw Data_014_7781
    dw Data_014_7787
    dw Data_014_778D
    dw Data_014_7793
    dw Data_014_7799
    dw Data_014_779F
    dw Data_014_77A5
    dw Data_014_77AB
    dw Data_014_77B1
    dw Data_014_77B7
    dw Data_014_77BD
    dw Data_014_77C3
    dw Data_014_77C9

Data_014_777B:: ; heuristic: target of a monotone pointer table; C0
    db $10, $2F, $28, $3C, $9F, $F0

Data_014_7781:: ; heuristic: target of a monotone pointer table; C0
    db $1F, $28, $35, $32, $31, $F0

Data_014_7787:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $32, $31, $24, $27, $F0

Data_014_778D:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $32, $25, $32, $36, $F0

Data_014_7793:: ; heuristic: target of a monotone pointer table; C0
    db $13, $38, $31, $24, $36, $F0

Data_014_7799:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $38, $33, $28, $2F, $F0

Data_014_779F:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $32, $2F, $32, $F0

Data_014_77A5:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $38, $30, $2C, $9F, $F0

Data_014_77AB:: ; heuristic: target of a monotone pointer table; C0
    db $14, $3C, $24, $35, $9F, $F0

Data_014_77B1:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $32, $3D, $24, $35, $F0

Data_014_77B7:: ; heuristic: target of a monotone pointer table; C0
    db $14, $3C, $35, $2C, $28, $F0

Data_014_77BD:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2C, $31, $24, $9F, $F0

Data_014_77C3:: ; heuristic: target of a monotone pointer table; C0
    db $16, $3C, $35, $24, $31, $F0

Data_014_77C9:: ; heuristic: target of a monotone pointer table; C0
    db $19, $24, $31, $27, $32, $F0

Data_014_77CF:: ; heuristic: target of a monotone pointer table; C0
    dw Data_014_77EB
    dw Data_014_77F1
    dw Data_014_77F7
    dw Data_014_77FD
    dw Data_014_7803
    dw Data_014_7809
    dw Data_014_780F
    dw Data_014_7815
    dw Data_014_781B
    dw Data_014_7821
    dw Data_014_7827
    dw Data_014_782D
    dw Data_014_7833
    dw Data_014_7839

Data_014_77EB:: ; heuristic: target of a monotone pointer table; C0
    db $14, $2B, $28, $35, $2C, $F0

Data_014_77F1:: ; heuristic: target of a monotone pointer table; C0
    db $17, $28, $36, $37, $24, $F0

Data_014_77F7:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $31, $39, $24, $35, $F0

Data_014_77FD:: ; heuristic: target of a monotone pointer table; C0
    db $1F, $3C, $31, $2A, $9F, $F0

Data_014_7803:: ; heuristic: target of a monotone pointer table; C0
    db $18, $2F, $3C, $39, $24, $F0

Data_014_7809:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $35, $2C, $27, $3D, $F0

Data_014_780F:: ; heuristic: target of a monotone pointer table; C0
    db $12, $3A, $24, $31, $9F, $F0

Data_014_7815:: ; heuristic: target of a monotone pointer table; C0
    db $22, $36, $36, $24, $9F, $F0

Data_014_781B:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $28, $39, $39, $2C, $F0

Data_014_7821:: ; heuristic: target of a monotone pointer table; C0
    db $18, $33, $24, $2F, $2F, $F0

Data_014_7827:: ; heuristic: target of a monotone pointer table; C0
    db $13, $2C, $27, $27, $24, $F0

Data_014_782D:: ; heuristic: target of a monotone pointer table; C0
    db $16, $38, $35, $35, $2C, $F0

Data_014_7833:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $2C, $31, $24, $F0

Data_014_7839:: ; heuristic: target of a monotone pointer table; C0
    db $22, $32, $32, $35, $2C, $F0

Data_014_783F:: ; heuristic: target of a monotone pointer table; C0
    dw Data_014_785B
    dw Data_014_7861
    dw Data_014_7867
    dw Data_014_786D
    dw Data_014_7873
    dw Data_014_7879
    dw Data_014_787F
    dw Data_014_7885
    dw Data_014_788B
    dw Data_014_7891
    dw Data_014_7897
    dw Data_014_789D
    dw Data_014_78A3
    dw Data_014_78A9

Data_014_785B:: ; heuristic: target of a monotone pointer table; C0
    db $12, $3D, $24, $2E, $9F, $F0

Data_014_7861:: ; heuristic: target of a monotone pointer table; C0
    db $20, $24, $2F, $2F, $2C, $F0

Data_014_7867:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $32, $27, $24, $9F, $F0

Data_014_786D:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $39, $2C, $9F, $9F, $F0

Data_014_7873:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $28, $31, $3C, $9F, $F0

Data_014_7879:: ; heuristic: target of a monotone pointer table; C0
    db $13, $24, $3A, $24, $2B, $F0

Data_014_787F:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $24, $39, $2C, $31, $F0

Data_014_7885:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $3C, $24, $26, $2C, $F0

Data_014_788B:: ; heuristic: target of a monotone pointer table; C0
    db $16, $2C, $3D, $38, $35, $F0

Data_014_7891:: ; heuristic: target of a monotone pointer table; C0
    db $19, $38, $35, $2F, $2F, $F0

Data_014_7897:: ; heuristic: target of a monotone pointer table; C0
    db $18, $24, $36, $2C, $3D, $F0

Data_014_789D:: ; heuristic: target of a monotone pointer table; C0
    db $17, $24, $27, $28, $24, $F0

Data_014_78A3:: ; heuristic: target of a monotone pointer table; C0
    db $15, $38, $24, $9F, $9F, $F0

Data_014_78A9:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $32, $39, $2C, $31, $F0

Data_014_78AF:: ; heuristic: target of a monotone pointer table; C0
    dw Data_014_78CB
    dw Data_014_78D1
    dw Data_014_78D7
    dw Data_014_78DD
    dw Data_014_78E3
    dw Data_014_78E9
    dw Data_014_78EF
    dw Data_014_78F5
    dw Data_014_78FB
    dw Data_014_7901
    dw Data_014_7907
    dw Data_014_790D
    dw Data_014_7913
    dw Data_014_7919

Data_014_78CB:: ; heuristic: target of a monotone pointer table; C0
    db $11, $28, $39, $31, $3D, $F0

Data_014_78D1:: ; heuristic: target of a monotone pointer table; C0
    db $11, $24, $27, $28, $3D, $F0

Data_014_78D7:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $2E, $35, $32, $F0

Data_014_78DD:: ; heuristic: target of a monotone pointer table; C0
    db $18, $36, $2E, $35, $32, $F0

Data_014_78E3:: ; heuristic: target of a monotone pointer table; C0
    db $16, $2C, $35, $2C, $32, $F0

Data_014_78E9:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $24, $36, $2C, $36, $F0

Data_014_78EF:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $2E, $38, $2F, $2F, $F0

Data_014_78F5:: ; heuristic: target of a monotone pointer table; C0
    db $15, $28, $27, $24, $2B, $F0

Data_014_78FB:: ; heuristic: target of a monotone pointer table; C0
    db $1E, $2F, $33, $2B, $9F, $F0

Data_014_7901:: ; heuristic: target of a monotone pointer table; C0
    db $20, $3C, $2F, $2F, $9F, $F0

Data_014_7907:: ; heuristic: target of a monotone pointer table; C0
    db $20, $28, $39, $9F, $9F, $F0

Data_014_790D:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $28, $36, $2C, $2F, $F0

Data_014_7913:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $3C, $24, $2F, $2F, $F0

Data_014_7919:: ; heuristic: target of a monotone pointer table; C0
    db $20, $24, $2F, $37, $3D, $F0

; address loaded by RunNameEntryStateWhenNotFading_Case01_Case03_Sub01
Data_014_791F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_014_7A37
    dw Data_014_7A3D
    dw Data_014_7A43
    dw Data_014_7A49
    dw Data_014_7A4F
    dw Data_014_7A55
    dw Data_014_7A5B
    dw Data_014_7A61
    dw Data_014_7A67
    dw Data_014_7A6D
    dw Data_014_7A73
    dw Data_014_7A79
    dw Data_014_7A7F
    dw Data_014_7A85
    dw Data_014_7A8B
    dw Data_014_7A91
    dw Data_014_7A97
    dw Data_014_7A9D
    dw Data_014_7AA3
    dw Data_014_7AA9
    dw Data_014_7AAF
    dw Data_014_7AB5
    dw Data_014_7ABB
    dw Data_014_7AC1
    dw Data_014_7AC7
    dw Data_014_7ACD
    dw Data_014_7AD3
    dw Data_014_7AD9
    dw Data_014_7ADF
    dw Data_014_7AE5
    dw Data_014_7AEB
    dw Data_014_7AF1
    dw Data_014_7AF7
    dw Data_014_7AFD
    dw Data_014_7B03
    dw Data_014_7B09
    dw Data_014_7B0F
    dw Data_014_7B15
    dw Data_014_7B1B
    dw Data_014_7B21
    dw Data_014_7B27
    dw Data_014_7B2D
    dw Data_014_7B33
    dw Data_014_7B39
    dw Data_014_7B3F
    dw Data_014_7B45
    dw Data_014_7B4B
    dw Data_014_7B51
    dw Data_014_7B57
    dw Data_014_7B5D
    dw Data_014_7B63
    dw Data_014_7B69
    dw Data_014_7B6F
    dw Data_014_7B75
    dw Data_014_7B7B
    dw Data_014_7B81
    dw Data_014_7B87
    dw Data_014_7B8D
    dw Data_014_7B93
    dw Data_014_7B99
    dw Data_014_7B9F
    dw Data_014_7BA5
    dw Data_014_7BAB
    dw Data_014_7BB1
    dw Data_014_7BB7
    dw Data_014_7BBD
    dw Data_014_7BC3
    dw Data_014_7BC9
    dw Data_014_7BCF
    dw Data_014_7BD5
    dw Data_014_7BDB
    dw Data_014_7BE1
    dw Data_014_7BE7
    dw Data_014_7BED
    dw Data_014_7BF3
    dw Data_014_7BF9
    dw Data_014_7BFF
    dw Data_014_7C05
    dw Data_014_7C0B
    dw Data_014_7C11
    dw Data_014_7C17
    dw Data_014_7C1D
    dw Data_014_7C23
    dw Data_014_7C29
    dw Data_014_7C2F
    dw Data_014_7C35
    dw Data_014_7C3B
    dw Data_014_7C41
    dw Data_014_7C47
    dw Data_014_7C4D
    dw Data_014_7C53
    dw Data_014_7C59
    dw Data_014_7C5F
    dw Data_014_7C65
    dw Data_014_7C6B
    dw Data_014_7C71
    dw Data_014_7C77
    dw Data_014_7C7D
    dw Data_014_7C83
    dw Data_014_7C89
    dw Data_014_7C8F
    dw Data_014_7C95
    dw Data_014_7C9B
    dw Data_014_7CA1
    dw Data_014_7CA7
    dw Data_014_7CAD
    dw Data_014_7CB3
    dw Data_014_7CB9
    dw Data_014_7CBF
    dw Data_014_7CC5
    dw Data_014_7CCB
    dw Data_014_7CD1
    dw Data_014_7CD7
    dw Data_014_7CDD
    dw Data_014_7CE3
    dw Data_014_7CE9
    dw Data_014_7CEF
    dw Data_014_7CF5
    dw Data_014_7CFB
    dw Data_014_7D01
    dw Data_014_7D07
    dw Data_014_7D0D
    dw Data_014_7D13
    dw Data_014_7D19
    dw Data_014_7D1F
    dw Data_014_7D25
    dw Data_014_7D2B
    dw Data_014_7D31
    dw Data_014_7D37
    dw Data_014_7D3D
    dw Data_014_7D43
    dw Data_014_7D49
    dw Data_014_7D4F
    dw Data_014_7D55
    dw Data_014_7D5B
    dw Data_014_7D61
    dw Data_014_7D67
    dw Data_014_7D6D
    dw Data_014_7D73
    dw Data_014_7D79

Data_014_7A37:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $3C, $2E, $28, $31, $F0

Data_014_7A3D:: ; heuristic: target of a monotone pointer table; C0
    db $15, $2C, $9F, $9F, $9F, $F0

Data_014_7A43:: ; heuristic: target of a monotone pointer table; C0
    db $19, $3C, $31, $31, $9F, $F0

Data_014_7A49:: ; heuristic: target of a monotone pointer table; C0
    db $19, $24, $3D, $38, $9F, $F0

Data_014_7A4F:: ; heuristic: target of a monotone pointer table; C0
    db $14, $32, $35, $27, $2C, $F0

Data_014_7A55:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $3C, $30, $25, $32, $F0

Data_014_7A5B:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2B, $28, $36, $37, $F0

Data_014_7A61:: ; heuristic: target of a monotone pointer table; C0
    db $23, $28, $35, $35, $32, $F0

Data_014_7A67:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $2F, $3C, $24, $2B, $F0

Data_014_7A6D:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $28, $35, $32, $2F, $F0

Data_014_7A73:: ; heuristic: target of a monotone pointer table; C0
    db $1F, $24, $35, $28, $2F, $F0

Data_014_7A79:: ; heuristic: target of a monotone pointer table; C0
    db $10, $24, $35, $32, $31, $F0

Data_014_7A7F:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $2F, $37, $2B, $32, $F0

Data_014_7A85:: ; heuristic: target of a monotone pointer table; C0
    db $16, $38, $31, $32, $31, $F0

Data_014_7A8B:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $2F, $29, $28, $35, $F0

Data_014_7A91:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $32, $37, $38, $30, $F0

Data_014_7A97:: ; heuristic: target of a monotone pointer table; C0
    db $13, $38, $31, $31, $32, $F0

Data_014_7A9D:: ; heuristic: target of a monotone pointer table; C0
    db $20, $28, $2C, $25, $9F, $F0

Data_014_7AA3:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $32, $35, $30, $24, $F0

Data_014_7AA9:: ; heuristic: target of a monotone pointer table; C0
    db $11, $38, $2E, $2E, $38, $F0

Data_014_7AAF:: ; heuristic: target of a monotone pointer table; C0
    db $10, $28, $37, $37, $38, $F0

Data_014_7AB5:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2C, $27, $3D, $24, $F0

Data_014_7ABB:: ; heuristic: target of a monotone pointer table; C0
    db $17, $24, $2E, $2E, $9F, $F0

Data_014_7AC1:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $38, $2F, $32, $9F, $F0

Data_014_7AC7:: ; heuristic: target of a monotone pointer table; C0
    db $18, $2F, $2A, $24, $31, $F0

Data_014_7ACD:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $28, $29, $37, $2C, $F0

Data_014_7AD3:: ; heuristic: target of a monotone pointer table; C0
    db $18, $36, $2B, $24, $31, $F0

Data_014_7AD9:: ; heuristic: target of a monotone pointer table; C0
    db $17, $32, $26, $2E, $32, $F0

Data_014_7ADF:: ; heuristic: target of a monotone pointer table; C0
    db $18, $2F, $37, $2B, $32, $F0

Data_014_7AE5:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $3D, $28, $35, $F0

Data_014_7AEB:: ; heuristic: target of a monotone pointer table; C0
    db $11, $3C, $27, $28, $9F, $F0

Data_014_7AF1:: ; heuristic: target of a monotone pointer table; C0
    db $18, $35, $32, $35, $24, $F0

Data_014_7AF7:: ; heuristic: target of a monotone pointer table; C0
    db $1F, $24, $35, $2F, $2C, $F0

Data_014_7AFD:: ; heuristic: target of a monotone pointer table; C0
    db $18, $29, $29, $36, $2C, $F0

Data_014_7B03:: ; heuristic: target of a monotone pointer table; C0
    db $14, $24, $33, $37, $24, $F0

Data_014_7B09:: ; heuristic: target of a monotone pointer table; C0
    db $13, $24, $36, $36, $9F, $F0

Data_014_7B0F:: ; heuristic: target of a monotone pointer table; C0
    db $23, $28, $2C, $2E, $9F, $F0

Data_014_7B15:: ; heuristic: target of a monotone pointer table; C0
    db $22, $38, $31, $31, $9F, $F0

Data_014_7B1B:: ; heuristic: target of a monotone pointer table; C0
    db $13, $38, $31, $2C, $24, $F0

Data_014_7B21:: ; heuristic: target of a monotone pointer table; C0
    db $1F, $38, $2F, $9F, $9F, $F0

Data_014_7B27:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2C, $28, $2F, $2F, $F0

Data_014_7B2D:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $32, $2F, $37, $32, $F0

Data_014_7B33:: ; heuristic: target of a monotone pointer table; C0
    db $1F, $38, $2F, $32, $9F, $F0

Data_014_7B39:: ; heuristic: target of a monotone pointer table; C0
    db $13, $2C, $2E, $2C, $2F, $F0

Data_014_7B3F:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $28, $39, $2C, $31, $F0

Data_014_7B45:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $28, $37, $2B, $24, $F0

Data_014_7B4B:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $2C, $36, $36, $F0

Data_014_7B51:: ; heuristic: target of a monotone pointer table; C0
    db $14, $38, $31, $32, $31, $F0

Data_014_7B57:: ; heuristic: target of a monotone pointer table; C0
    db $23, $24, $2E, $38, $2F, $F0

Data_014_7B5D:: ; heuristic: target of a monotone pointer table; C0
    db $14, $2C, $35, $38, $24, $F0

Data_014_7B63:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $32, $35, $25, $2C, $F0

Data_014_7B69:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $2C, $37, $28, $3C, $F0

Data_014_7B6F:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $39, $2C, $31, $9F, $F0

Data_014_7B75:: ; heuristic: target of a monotone pointer table; C0
    db $14, $38, $2F, $32, $28, $F0

Data_014_7B7B:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $38, $27, $2C, $9F, $F0

Data_014_7B81:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $2B, $3C, $9F, $F0

Data_014_7B87:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $38, $38, $9F, $9F, $F0

Data_014_7B8D:: ; heuristic: target of a monotone pointer table; C0
    db $10, $24, $35, $35, $2C, $F0

Data_014_7B93:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $24, $25, $38, $9F, $F0

Data_014_7B99:: ; heuristic: target of a monotone pointer table; C0
    db $1F, $28, $2B, $27, $24, $F0

Data_014_7B9F:: ; heuristic: target of a monotone pointer table; C0
    db $14, $24, $35, $37, $32, $F0

Data_014_7BA5:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $2C, $24, $9F, $9F, $F0

Data_014_7BAB:: ; heuristic: target of a monotone pointer table; C0
    db $16, $38, $37, $24, $2B, $F0

Data_014_7BB1:: ; heuristic: target of a monotone pointer table; C0
    db $16, $32, $31, $36, $38, $F0

Data_014_7BB7:: ; heuristic: target of a monotone pointer table; C0
    db $19, $38, $2F, $2E, $9F, $F0

Data_014_7BBD:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $24, $2C, $3D, $9F, $F0

Data_014_7BC3:: ; heuristic: target of a monotone pointer table; C0
    db $23, $28, $2C, $2F, $9F, $F0

Data_014_7BC9:: ; heuristic: target of a monotone pointer table; C0
    db $14, $24, $3D, $31, $24, $F0

Data_014_7BCF:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2C, $2E, $2E, $24, $F0

Data_014_7BD5:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $35, $3D, $32, $F0

Data_014_7BDB:: ; heuristic: target of a monotone pointer table; C0
    db $16, $38, $28, $3C, $9F, $F0

Data_014_7BE1:: ; heuristic: target of a monotone pointer table; C0
    db $16, $3C, $36, $37, $2C, $F0

Data_014_7BE7:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $24, $30, $24, $31, $F0

Data_014_7BED:: ; heuristic: target of a monotone pointer table; C0
    db $12, $24, $31, $24, $9F, $F0

Data_014_7BF3:: ; heuristic: target of a monotone pointer table; C0
    db $16, $2C, $2E, $2E, $32, $F0

Data_014_7BF9:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $32, $33, $24, $3D, $F0

Data_014_7BFF:: ; heuristic: target of a monotone pointer table; C0
    db $19, $38, $2F, $24, $30, $F0

Data_014_7C05:: ; heuristic: target of a monotone pointer table; C0
    db $17, $3C, $24, $35, $9F, $F0

Data_014_7C0B:: ; heuristic: target of a monotone pointer table; C0
    db $23, $32, $31, $2C, $24, $F0

Data_014_7C11:: ; heuristic: target of a monotone pointer table; C0
    db $19, $38, $2F, $2C, $31, $F0

Data_014_7C17:: ; heuristic: target of a monotone pointer table; C0
    db $14, $31, $38, $2F, $2F, $F0

Data_014_7C1D:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $38, $2F, $2C, $F0

Data_014_7C23:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $24, $35, $2C, $31, $F0

Data_014_7C29:: ; heuristic: target of a monotone pointer table; C0
    db $16, $3C, $2F, $2E, $2C, $F0

Data_014_7C2F:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $2F, $29, $38, $24, $F0

Data_014_7C35:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $38, $35, $2C, $2F, $F0

Data_014_7C3B:: ; heuristic: target of a monotone pointer table; C0
    db $11, $24, $30, $28, $31, $F0

Data_014_7C41:: ; heuristic: target of a monotone pointer table; C0
    db $15, $2C, $2A, $2A, $9F, $F0

Data_014_7C47:: ; heuristic: target of a monotone pointer table; C0
    db $15, $2C, $30, $30, $28, $F0

Data_014_7C4D:: ; heuristic: target of a monotone pointer table; C0
    db $11, $32, $2B, $30, $2C, $F0

Data_014_7C53:: ; heuristic: target of a monotone pointer table; C0
    db $15, $2C, $36, $28, $37, $F0

Data_014_7C59:: ; heuristic: target of a monotone pointer table; C0
    db $14, $24, $37, $38, $24, $F0

Data_014_7C5F:: ; heuristic: target of a monotone pointer table; C0
    db $19, $24, $28, $2F, $24, $F0

Data_014_7C65:: ; heuristic: target of a monotone pointer table; C0
    db $19, $38, $37, $37, $2C, $F0

Data_014_7C6B:: ; heuristic: target of a monotone pointer table; C0
    db $16, $3C, $30, $28, $28, $F0

Data_014_7C71:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $31, $31, $2C, $36, $F0

Data_014_7C77:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $2E, $2E, $2C, $F0

Data_014_7C7D:: ; heuristic: target of a monotone pointer table; C0
    db $13, $28, $30, $31, $2C, $F0

Data_014_7C83:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2B, $24, $24, $35, $F0

Data_014_7C89:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $29, $2C, $31, $F0

Data_014_7C8F:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2C, $24, $31, $31, $F0

Data_014_7C95:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $2F, $2C, $31, $F0

Data_014_7C9B:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $24, $33, $2F, $2C, $F0

Data_014_7CA1:: ; heuristic: target of a monotone pointer table; C0
    db $16, $38, $2F, $37, $3C, $F0

Data_014_7CA7:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $26, $2B, $24, $2C, $F0

Data_014_7CAD:: ; heuristic: target of a monotone pointer table; C0
    db $11, $3C, $2F, $27, $24, $F0

Data_014_7CB3:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2B, $24, $35, $32, $F0

Data_014_7CB9:: ; heuristic: target of a monotone pointer table; C0
    db $16, $2C, $2F, $2F, $2E, $F0

Data_014_7CBF:: ; heuristic: target of a monotone pointer table; C0
    db $16, $2C, $2F, $27, $24, $F0

Data_014_7CC5:: ; heuristic: target of a monotone pointer table; C0
    db $14, $32, $31, $31, $2C, $F0

Data_014_7CCB:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $38, $31, $27, $2C, $F0

Data_014_7CD1:: ; heuristic: target of a monotone pointer table; C0
    db $14, $32, $30, $28, $37, $F0

Data_014_7CD7:: ; heuristic: target of a monotone pointer table; C0
    db $16, $28, $2F, $24, $31, $F0

Data_014_7CDD:: ; heuristic: target of a monotone pointer table; C0
    db $16, $32, $38, $35, $24, $F0

Data_014_7CE3:: ; heuristic: target of a monotone pointer table; C0
    db $16, $32, $31, $28, $3D, $F0

Data_014_7CE9:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $2F, $2F, $24, $31, $F0

Data_014_7CEF:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $35, $2C, $36, $36, $F0

Data_014_7CF5:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $38, $2F, $32, $28, $F0

Data_014_7CFB:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $2F, $32, $35, $24, $F0

Data_014_7D01:: ; heuristic: target of a monotone pointer table; C0
    db $17, $2C, $37, $2B, $28, $F0

Data_014_7D07:: ; heuristic: target of a monotone pointer table; C0
    db $22, $38, $3A, $30, $2C, $F0

Data_014_7D0D:: ; heuristic: target of a monotone pointer table; C0
    db $22, $38, $35, $35, $32, $F0

Data_014_7D13:: ; heuristic: target of a monotone pointer table; C0
    db $19, $24, $2C, $3D, $28, $F0

Data_014_7D19:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $28, $2F, $28, $31, $F0

Data_014_7D1F:: ; heuristic: target of a monotone pointer table; C0
    db $11, $28, $35, $28, $31, $F0

Data_014_7D25:: ; heuristic: target of a monotone pointer table; C0
    db $1F, $28, $2F, $24, $2B, $F0

Data_014_7D2B:: ; heuristic: target of a monotone pointer table; C0
    db $16, $2C, $31, $37, $32, $F0

Data_014_7D31:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $2C, $37, $37, $32, $F0

Data_014_7D37:: ; heuristic: target of a monotone pointer table; C0
    db $15, $38, $30, $24, $31, $F0

Data_014_7D3D:: ; heuristic: target of a monotone pointer table; C0
    db $1F, $28, $31, $31, $2C, $F0

Data_014_7D43:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $28, $35, $3C, $2F, $F0

Data_014_7D49:: ; heuristic: target of a monotone pointer table; C0
    db $14, $35, $2C, $30, $9F, $F0

Data_014_7D4F:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $37, $26, $2B, $9F, $F0

Data_014_7D55:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $35, $2F, $28, $9F, $F0

Data_014_7D5B:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2B, $28, $36, $9F, $F0

Data_014_7D61:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $2C, $3D, $24, $9F, $F0

Data_014_7D67:: ; heuristic: target of a monotone pointer table; C0
    db $19, $28, $36, $37, $2F, $F0

Data_014_7D6D:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $2F, $30, $30, $32, $F0

Data_014_7D73:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $32, $35, $37, $28, $F0

Data_014_7D79:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $32, $29, $29, $2C, $F0

; only called from routines of ScriptCommandEB_Run (E-0098)
; 4 call sites from 4 routines (e.g. ScriptCommandEB_Run_Case05_Case3F, ScriptCommandEB_Run_Case05_Case13, ScriptCommandEB_Run_Case04_Case42, ScriptCommandEB_Run_Case07_Case12)
; reads: wArg1
; writes: rRAMG2, rRAMB, wArg5, wArg6, wArg7
; points at: sCompactRecords, sRecords, wRecordBufB
ScriptCommandEB_Run_Shared05::
Func_014_7D7F:: ; address name
    ld a, [wArg1]
    cp a, $1E
    jr nc, Jump_014_7DB2
    cp a, $1D
    jr z, Jump_014_7D9E
    ld c, $6F
    call Multiply8
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld de, sCompactRecords
    add hl, de
    jr Jump_014_7DAB

Jump_014_7D9E::
    ld hl, sRecords
    ld a, $0A
    ld [rRAMG2], a
    ld a, $01
    ld [rRAMB], a

Jump_014_7DAB::
    ld b, $6F

Jump_014_7DAD::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_014_7DAD

Jump_014_7DB2::
    ld hl, sCompactRecords
    ld de, sCompactRecords + $6F
    xor a, a
    ld [rRAMB], a
    ld bc, $0000

Jump_014_7DBF::
    push de
    push hl
    ld a, [hl]
    bit 7, a
    jr nz, Jump_014_7DCD
    ld a, [de]
    bit 7, a
    jr nz, Jump_014_7DE7
    jr Jump_014_7DD6

Jump_014_7DCD::
    pop hl
    ld a, $6F
    add_a_to_hl
    push hl

Jump_014_7DD6::
    pop hl
    pop de
    ld a, $6F
    add a, e
    ld e, a
    jr nc, Jump_014_7DDF
    inc d

Jump_014_7DDF::
    inc c
    ld a, c
    cp a, $1D
    jr c, Jump_014_7DBF
    jr Jump_014_7DF8

Jump_014_7DE7::
    pop hl
    pop de
    ld a, [de]
    ld [hl+], a
    xor a, a
    ld [de], a
    inc de
    ld b, $6E

Jump_014_7DF0::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_014_7DF0
    jr Jump_014_7DDF

Jump_014_7DF8::
    ld hl, sCompactRecords
    xor a, a
    ld [rRAMB], a
    ld c, $00

Jump_014_7E01::
    ld a, [hl]
    bit 7, a
    jr z, Jump_014_7E16
    ld a, l
    add a, $6F
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc c
    ld a, c
    cp a, $1D
    jr c, Jump_014_7E01
    jr Jump_014_7E44

Jump_014_7E16::
    push hl
    ld de, wRecordBufB
    ld hl, sRecords
    ld a, $01
    ld [rRAMB], a
    ld b, $6F

Jump_014_7E24::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_014_7E24
    ld hl, sRecords
    ld b, $6F

Jump_014_7E2F::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_014_7E2F
    pop hl
    xor a, a
    ld [rRAMB], a
    ld de, wRecordBufB
    ld b, $6F

Jump_014_7E3E::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_014_7E3E

Jump_014_7E44::
    xor a, a
    ld [rRAMB], a
    ld hl, sCompactRecords
    ld c, $00

Jump_014_7E4D::
    ld a, [hl]
    bit 7, a
    jr nz, Jump_014_7E6D

Jump_014_7E52::
    ld a, c
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld a, h
    ld [wArg7], a
    ld b, $6F

Jump_014_7E60::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_014_7E60
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    ret

Jump_014_7E6D::
    ld a, $6F
    add_a_to_hl
    inc c
    ld a, c
    cp a, $1D
    jr c, Jump_014_7E4D
    ld a, $01
    ld [rRAMB], a
    ld hl, sRecords
    ld a, [hl]
    bit 7, a
    jr nz, Jump_014_7E89
    jr Jump_014_7E52

Jump_014_7E89::
    ld a, $FF
    ld [wArg5], a
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    ret

; clears SRAM record wD7F1 (when below 30) and moves the later stored records up to fill the gap, updating the party list (E-0131)
; 19 call sites from 18 routines (e.g. RunLinkScreenState_6C12_Case08_Case04_Sub01, ScriptCommandF4_Run_Case04_Case17, ScriptCommandEB_Run_Case05_Case3F, ScriptCommandEB_Run_Case04_Case16, ...)
; reads: wArg1, wArg2, wPartyCount
; writes: rRAMG2, rRAMB, wArg3, wArg5, wArg6, wArg7, wPartyCount
; points at: sRecords, sRecord1, wPartyList
DeleteSRAMRecordAndCompact::
Func_014_7E96:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [wArg1]
    cp a, $1E
    jr nc, Jump_014_7EB6
    ld c, $A5
    call Multiply8
    ld de, sRecords
    add hl, de
    ld b, $A5

Jump_014_7EB1::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_014_7EB1

Jump_014_7EB6::
    ld hl, sRecords
    ld de, sRecord1
    ld bc, $0000

Jump_014_7EBF::
    push de
    push hl
    ld a, [hl]
    cp a, $01
    jr z, Jump_014_7ED5
    cp a, $02
    jr z, Jump_014_7ED5
    ld a, [de]
    cp a, $01
    jr z, Jump_014_7EEF
    cp a, $02
    jr z, Jump_014_7EEF
    jr Jump_014_7EDE

Jump_014_7ED5::
    pop hl
    ld a, $A5
    add_a_to_hl
    push hl

Jump_014_7EDE::
    pop hl
    pop de
    ld a, $A5
    add a, e
    ld e, a
    jr nc, Jump_014_7EE7
    inc d

Jump_014_7EE7::
    inc c
    ld a, c
    cp a, $1E
    jr c, Jump_014_7EBF
    jr Jump_014_7F00

Jump_014_7EEF::
    pop hl
    pop de
    ld a, [de]
    ld [hl+], a
    xor a, a
    ld [de], a
    inc de
    ld b, $A4

Jump_014_7EF8::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_014_7EF8
    jr Jump_014_7EE7

Jump_014_7F00::
    xor a, a
    ld [wArg3], a
    ld a, [wArg2]
    and a, a
    jr nz, Jump_014_7F41
    ld a, [wArg1]
    cp a, $1E
    jr nc, Jump_014_7F41
    ld b, a
    ld a, [wPartyCount]
    ld e, a
    ld c, $00
    ld hl, wPartyList

Jump_014_7F1B::
    ld a, [hl]
    cp a, b
    jr z, Jump_014_7F28
    inc hl
    inc c
    ld a, c
    cp a, e
    jr c, Jump_014_7F1B
    jp Jump_014_7F41

Jump_014_7F28::
    ld a, c
    cp a, $02
    jr z, Jump_014_7F33
    inc hl
    ld a, [hl-]
    ld [hl+], a
    inc c
    jr Jump_014_7F28

Jump_014_7F33::
    xor a, a
    ld [hl], a
    ld a, [wPartyCount]
    dec a
    ld [wPartyCount], a
    ld a, $01
    ld [wArg3], a

Jump_014_7F41::
    ld hl, wPartyList
    ld a, [wArg1]
    cp a, $1E
    jr nc, Jump_014_7F5F
    ld c, $00

Jump_014_7F4D::
    ld a, [hl]
    ld b, a
    ld a, [wArg1]
    cp a, b
    jr nc, Jump_014_7F58
    ld a, b
    dec a
    ld [hl], a

Jump_014_7F58::
    inc hl
    inc c
    ld a, c
    cp a, $03
    jr c, Jump_014_7F4D

Jump_014_7F5F::
    ld hl, sRecords
    ld c, $00

Jump_014_7F64::
    ld a, [hl]
    cp a, $01
    jr z, Jump_014_7F85
    cp a, $02
    jr z, Jump_014_7F85
    ld a, c
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld a, h
    ld [wArg7], a
    ld b, $A5

Jump_014_7F7B::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_014_7F7B
    xor a, a
    ld [rRAMG2], a
    ret

Jump_014_7F85::
    ld a, $A5
    add_a_to_hl
    inc c
    ld a, c
    cp a, $1E
    jr c, Jump_014_7F64
    ld a, $FF
    ld [wArg5], a
    xor a, a
    ld [rRAMG2], a
    ret

; only called from CreateMonsterRecordOfKindTemp1_Sub01_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. CreateMonsterRecordOfKindTemp1_Sub01_Sub01)
; reads: wWorkBuf
CreateMonsterRecordOfKindTemp1_Sub01_Sub01_Sub01::
Func_014_7F9C:: ; address name
    ld a, [wWorkBuf]
    ld c, a
    ld b, $00
    ld hl, Data_014_7439
    add hl, bc
    add hl, bc
    deref_hl
    ld a, [wWorkBuf + $1]
    ld c, a
    jr Jump_014_7FB9
    db $FA, $9E, $D0, $4F, $06, $00, $21, $1F, $79

Jump_014_7FB9::
    add hl, bc
    add hl, bc
    deref_hl
    ld a, [wWorkBuf + $2]
    ld e, a
    ld a, [wWorkBuf + $3]
    ld d, a

Jump_014_7FC6::
    ld a, [hl+]
    cp a, $9F
    jr z, Jump_014_7FC6
    ld [de], a
    cp a, $F0
    jr z, Jump_014_7FD3
    inc de
    jr Jump_014_7FC6

Jump_014_7FD3::
    ret
    ds $2C, $00
