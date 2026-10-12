SECTION "Bank 1E", ROMX[$4000], BANK[$1E]
    db $1E

; implements script command type E9 (SCRIPT_MENU_CLOSE): ends a menu session (runs CloseBreedMenu's code); follows the swap and NPC breeding menus; reached through ScriptCommandE9 in bank $10 (E-0038, E-0244)
; 2 call sites from 2 routines (e.g. ScriptCommandE9_RunFar, ScriptCommandE9)
; reads: wScreenList
CloseMenuE9::
Func_01E_4001:: ; address name
    ld a, [wScreenList]
    rst $00
    dw CloseMenuE9_Case00
    dw CloseMenuE9_Case01
    dw CloseMenuE9_Case02
    dw CloseMenuE9_Case03

; entry 0 of the `rst $00` table in CloseMenuE9
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wScreenList
; writes: wScreenList
; points at: wScreenTileBuffer, wScreenAttrBuffer
CloseMenuE9_Case00::
Jump_01E_400D:: ; address name
    ld hl, wWindowTileBuffer + $64
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank1E
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_01E_402B
    ld hl, wWindowAttrBuffer + $64
    ld de, wScreenAttrBuffer
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank1E

Jump_01E_402B::
    call BGMapAddressAtScroll_Bank1E
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank1E
    ld a, [wScreenList]
    inc a
    ld [wScreenList], a
    ret

; entry 1 of the `rst $00` table in CloseMenuE9
; no direct call (reached through a table, a jump or a vector)
CloseMenuE9_Case01::
Jump_01E_403F:: ; address name
    farcall CloseBreedMenu
    ret

; entry 2 of the `rst $00` table in CloseMenuE9
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenList
; writes: wScreenList
CloseMenuE9_Case02::
Jump_01E_4046:: ; address name
    ld b, $46
    ld de, Data_046_4001
    ld hl, vTiles1
    call DecompressToVRAM
    ld hl, vTiles1 + $500
    ld bc, $0F01
    call FillTilesBxC
    ld a, [wScreenList]
    inc a
    ld [wScreenList], a
    ret

; entry 3 of the `rst $00` table in CloseMenuE9
; no direct call (reached through a table, a jump or a vector)
CloseMenuE9_Case03::
Jump_01E_4062:: ; address name
    farcall CloseBreedMenu
    ret

; implements script command type E8 (SCRIPT_SWAP_MONSTERS): Cobi's swap of party and farm monsters: 'What'll you switch it with?', 'I switched 0.' (mode 3, bank $1F strings); reached through ScriptCommandE8 in bank $10 (E-0038, E-0244)
; 18 call sites from 18 routines (e.g. EggServiceMenu_Case0D, NpcBreedMenu_Case00, NpcBreedMenu_Case0C, ScriptCommandE8, ...)
; reads: wScreenState
SwapMonstersMenu::
Func_01E_4069:: ; address name
    ld a, [wScreenState]
    rst $00
    dw SwapMonstersMenu_Case00
    dw SwapMonstersMenu_Case01
    dw SwapMonstersMenu_Case02
    dw SwapMonstersMenu_Case03
    dw SwapMonstersMenu_Case04
    dw SwapMonstersMenu_Case05
    dw SwapMonstersMenu_Case06
    dw SwapMonstersMenu_Case07
    dw SwapMonstersMenu_Case08
    dw SwapMonstersMenu_Case09
    dw SwapMonstersMenu_Case0A
    dw SwapMonstersMenu_Case0B
    dw SwapMonstersMenu_Case0C
    dw SwapMonstersMenu_Case0D
    dw SwapMonstersMenu_Case0E

; entry 0 of the `rst $00` table in SwapMonstersMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: wMessageMode, hSpriteHideTile, wAreaGraphicsIndex, wScriptCommandType, wScriptStartRequest
; points at: wScreenState, wScreenTileBuffer, wScreenAttrBuffer
SwapMonstersMenu_Case00::
Jump_01E_408B:: ; address name
    ld hl, wScreenState
    ld bc, $006F

Jump_01E_4091::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_01E_4091
    ld hl, wWindowTileBuffer + $64
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank1E
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_01E_40B6
    ld hl, wWindowAttrBuffer + $64
    ld de, wScreenAttrBuffer
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank1E

Jump_01E_40B6::
    ld a, $03
    ld [wMessageMode], a
    ld a, $70
    ldh [hSpriteHideTile], a
    xor a, a
    ld [wAreaGraphicsIndex], a
    ld hl, wScreenState
    inc [hl]
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 1 of the `rst $00` table in SwapMonstersMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
SwapMonstersMenu_Case01::
Jump_01E_40D1:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw SwapMonstersMenu_Case01_Case00
    dw SwapMonstersMenu_Case01_Case01
    dw SwapMonstersMenu_Case01_Case02
    dw SwapMonstersMenu_Case01_Case03

; entry 0 of the `rst $00` table in SwapMonstersMenu_Case01
; no direct call (reached through a table, a jump or a vector)
SwapMonstersMenu_Case01_Case00::
Jump_01E_40DD:: ; address name
    farcall SetupTileMap6D84AtBGMap1
    ret

; entry 1 of the `rst $00` table in SwapMonstersMenu_Case01
; no direct call (reached through a table, a jump or a vector)
; points at: wScreenStep
SwapMonstersMenu_Case01_Case01::
Jump_01E_40E4:: ; address name
    ld hl, GlyphCopyDestList0
    ld de, GlyphCopySrcList0
    call SwapMonstersMenu_Shared05
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in SwapMonstersMenu_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
SwapMonstersMenu_Case01_Case02::
Jump_01E_40F2:: ; address name
    farcall ListPartyRecordsWithState2ToListEntries
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 3 of the `rst $00` table in SwapMonstersMenu_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wScreenStep, wScreenState
SwapMonstersMenu_Case01_Case03::
Jump_01E_4100:: ; address name
    ld de, $79C8
    ld hl, wWindowTileBuffer + $64
    ld bc, $0B0B
    call CopyRectTo20ByteRows_Bank1E
    call BGMapAddressAtScroll_Bank1E
    ld bc, $140B
    ld de, $01CC
    call DrawScreenBufferRect_Bank1E
    farcall CountRecordsInUse
    xor a, a
    ld [wScreenStep], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; entry 2 of the `rst $00` table in SwapMonstersMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wGridCursorX, wScreenState
; writes: wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wScreenState, wListCursor, wChoiceCursor, wListPageIndex, wGridCursorX
SwapMonstersMenu_Case02::
Jump_01E_412A:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, Jump_01E_4146
    bit 7, a
    jr nz, Jump_01E_4174
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, Jump_01E_418E
    bit 1, a
    jp nz, Jump_01E_41D0
    call SwapMonstersMenu_Case02_Sub01
    ret

Jump_01E_4146::
    call SwapMonstersMenu_Case02_Sub03
    ld a, [wGridCursorX]
    and a, a
    jr nz, Jump_01E_415D
    ld a, $04
    ld [wGridCursorX], a
    call SwapMonstersMenu_Case02_Sub01
    ld a, $69
    call QueueSoundEffect
    ret

Jump_01E_415D::
    dec a

Jump_01E_415E::
    ld [wGridCursorX], a
    xor a, a
    ld [wListCursor], a
    ld [wChoiceCursor], a
    ld [wListPageIndex], a
    call SwapMonstersMenu_Case02_Sub02
    ld a, $69
    call QueueSoundEffect
    ret

Jump_01E_4174::
    call SwapMonstersMenu_Case02_Sub03
    ld a, [wGridCursorX]
    cp a, $04
    jr c, Jump_01E_418B
    xor a, a
    ld [wGridCursorX], a
    call SwapMonstersMenu_Case02_Sub01
    ld a, $69
    call QueueSoundEffect
    ret

Jump_01E_418B::
    inc a
    jr Jump_01E_415E

Jump_01E_418E::
    ld a, $69
    call QueueSoundEffect
    call SwapMonstersMenu_Case02_Sub04
    ld c, $00

Jump_01E_4198::
    ld a, c
    ld b, $C3
    ld hl, CursorCellTable7880
    push bc
    push hl
    call StoreBAtWordTableEntry_Bank1E
    pop hl
    pop bc
    inc c
    ld a, c
    cp a, $05
    jr c, Jump_01E_4198
    ld a, [wGridCursorX]
    cp a, $04
    jr z, Jump_01E_41D0
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

Jump_01E_41D0::
    ld a, $04
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; only called from SwapMonstersMenu_Case02 (E-0047)
; 3 call sites from 1 routine (e.g. SwapMonstersMenu_Case02)
; reads: wJoypadRepeatTimer, wGridCursorY, wGridCursorX
; writes: wGridCursorY
SwapMonstersMenu_Case02_Sub01::
Func_01E_41DF:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, SwapMonstersMenu_Case02_Sub02
    ld a, [wGridCursorY]
    inc a
    ld [wGridCursorY], a
    cp a, $10
    jr c, SwapMonstersMenu_Case02_Sub02
    cp a, $18
    jr c, SwapMonstersMenu_Case02_Sub03
    xor a, a
    ld [wGridCursorY], a

; only called from SwapMonstersMenu_Case02 (E-0047)
; 1 call site from 1 routine (e.g. SwapMonstersMenu_Case02)
; reads: wGridCursorX
SwapMonstersMenu_Case02_Sub02::
Func_01E_41F9:: ; address name
    ld b, $BB
    jr Jump_01E_4203

; only called from SwapMonstersMenu_Case02 (E-0047)
; 2 call sites from 1 routine (e.g. SwapMonstersMenu_Case02)
; reads: wGridCursorX
SwapMonstersMenu_Case02_Sub03::
Func_01E_41FD:: ; address name
    ld b, $C3
    jr Jump_01E_4203

; only called from SwapMonstersMenu_Case02 (E-0047)
; 1 call site from 1 routine (e.g. SwapMonstersMenu_Case02)
; reads: wGridCursorX
SwapMonstersMenu_Case02_Sub04::
Func_01E_4201:: ; address name
    ld b, $BC

Jump_01E_4203::
    ld a, [wGridCursorX]
    add a, a
    ld hl, $4223
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1E
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret
    db $21, $00, $61, $00, $A1, $00, $E1, $00, $21, $01

; entry 3 of the `rst $00` table in SwapMonstersMenu
; no direct call (reached through a table, a jump or a vector)
SwapMonstersMenu_Case03::
Jump_01E_422D:: ; address name
    farcall SwapMonstersMenu_Case03_Sub01
    ret

; entry 4 of the `rst $00` table in SwapMonstersMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
SwapMonstersMenu_Case04::
Jump_01E_4234:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw SwapMonstersMenu_Case04_Case00
    dw SwapMonstersMenu_Case04_Case01
    dw SwapMonstersMenu_Case04_Case02
    dw SwapMonstersMenu_Case04_Case03
    dw SwapMonstersMenu_Case04_Case04
    dw SwapMonstersMenu_Case04_Case05
    dw SwapMonstersMenu_Case04_Case06
    dw SwapMonstersMenu_Case04_Case07
    dw SwapMonstersMenu_Case04_Case08
    dw SwapMonstersMenu_Case04_Case09
    dw SwapMonstersMenu_Case04_Case0A
    dw SwapMonstersMenu_Case04_Case0B
    dw SwapMonstersMenu_Case04_Case0C
    dw DrawBox4718AndMenuAndStep_1E
    dw SwapMonstersMenu_Case04_Case0E
    dw SwapMonstersMenu_Case04_Case0F
    dw SwapMonstersMenu_Case04_Case10
    dw SwapMonstersMenu_Case04_Case11
    dw SwapMonstersMenu_Case04_Case12
    dw SwapMonstersMenu_Case04_Case13
    dw SwapMonstersMenu_Case04_Case14
    dw ListRecordsState1ThenContinue
    dw CallFunc5C15InBank1F
    dw SwapMonstersMenu_Case04_Case17
    dw SwapMonstersMenu_Case04_Case02
    dw SwapMonstersMenu_Case04_Case19
    dw SwapMonstersMenu_Case04_Case04
    dw SwapMonstersMenu_Case04_Case1B
    dw SwapMonstersMenu_Case04_Case06
    dw SwapMonstersMenu_Case04_Case07
    dw SwapMonstersMenu_Case04_Case08
    dw SwapMonstersMenu_Case04_Case13
    dw SwapMonstersMenu_Case04_Case20
    dw SwapMonstersMenu_Case04_Case21
    dw SwapMonstersMenu_Case04_Case22
    dw SwapMonstersMenu_Case04_Case0A
    dw SwapMonstersMenu_Case04_Case0B
    dw SwapMonstersMenu_Case04_Case0C
    dw DrawBox4718AndMenuAndStep_1E
    dw SwapMonstersMenu_Case04_Case27
    dw SwapMonstersMenu_Case04_Case28
    dw SwapMonstersMenu_Case04_Case29
    dw SwapMonstersMenu_Case04_Case06
    dw SwapMonstersMenu_Case04_Case07
    dw SwapMonstersMenu_Case04_Case08
    dw SwapMonstersMenu_Case04_Case13
    dw SwapMonstersMenu_Case04_Case20
    dw SwapMonstersMenu_Case04_Case21
    dw SwapMonstersMenu_Case04_Case30

; entry 0 of the `rst $00` table in SwapMonstersMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep, wScreenStep, wPartyCount
; writes: wScreenSubStep, wScreenStep, rRAMG2, rRAMB, wNameGlyphBuf
; points at: wPartyList
SwapMonstersMenu_Case04_Case00::
Jump_01E_429A:: ; address name
    ld a, [wScreenSubStep]
    and a, a
    jp z, Jump_01E_42A9
    cp a, $01
    jp z, SwapMonstersMenu_Case0E_Case07_Sub01
    jp Jump_01E_430D

Jump_01E_42A9::
    ld de, $4333
    ld hl, wWindowTileBuffer + $64
    ld bc, $0807
    call CopyRectTo20ByteRows_Bank1E
    ld hl, vTiles1 + $500
    ld bc, $0F01
    call FillTilesBxC
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; only called from SwapMonstersMenu_Case0E_Case07 (E-0047)
; 1 call site from 1 routine (e.g. SwapMonstersMenu_Case0E_Case07)
; reads: wPartyCount, wScreenSubStep
; writes: rRAMG2, rRAMB, wNameGlyphBuf, wScreenSubStep
; points at: wPartyList
SwapMonstersMenu_Case0E_Case07_Sub01::
Func_01E_42C6:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld b, $00

Jump_01E_42D1::
    push bc
    ld hl, wPartyList
    ld a, b
    add_a_to_hl
    ld a, [hl]
    ld b, a
    ld c, $01
    call CopyRecordNameToNameGlyphBuf
    ld a, $F0
    ld [wNameGlyphBuf + $A], a
    pop bc
    push bc
    ld a, b
    add a, a
    ld hl, $436B
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    call CopyGlyphTilesToVRAM
    pop bc
    inc b
    ld a, [wPartyCount]
    cp a, b
    jr nz, Jump_01E_42D1
    xor a, a
    ld [rRAMG2], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

Jump_01E_430D::
    farcall ListPartyRecordsWithState2ToListEntries
    ld hl, wWindowTileBuffer + $78
    ld c, $28
    call SwapMonstersMenu_Shared07
    call BGMapAddressAtScroll_Bank1E
    ld bc, $140B
    ld de, $01CC
    call DrawScreenBufferRect_Bank1E
    xor a, a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 7 tiles, one row per line
TileRect_1E_4333::
Data_01E_4333:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $D0, $D1, $D2, $D3, $D4, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $D5, $D6, $D7, $D8, $D9, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $DA, $DB, $DC, $DD, $DE, $B7 ; id 5
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 6
    db $00, $8D, $50, $8D, $A0, $8D

; entry 1 of the `rst $00` table in SwapMonstersMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wListCursor, wScreenStep
; writes: wArg1, wScreenStep
; points at: wListEntries
SwapMonstersMenu_Case04_Case01::
Jump_01E_4371:: ; address name
    ld a, [wListCursor]
    ld hl, wListEntries
    add_a_to_hl
    ld a, [hl]
    ld b, a
    push af
    call LoadFamilyIconTileForRecordB_Bank1E
    ld de, $795C
    ld hl, wWindowTileBuffer + $6C
    ld bc, $0C09
    call CopyRectTo20ByteRows_Bank1E
    pop af
    ld b, a
    ld [wArg1], a
    call CallFunc5B4DInBank1D
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 2 of the `rst $00` table in SwapMonstersMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; points at: wTextWindowTileLo, wScreenStep
SwapMonstersMenu_Case04_Case02::
Jump_01E_439E:: ; address name
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

; entry 3 of the `rst $00` table in SwapMonstersMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wListCursor, wScreenStep
; writes: wArg1, wScreenStep
; points at: wListEntries
SwapMonstersMenu_Case04_Case03::
Jump_01E_43C2:: ; address name
    ld a, [wListCursor]
    ld hl, wListEntries
    add_a_to_hl
    ld a, [hl]
    ld b, a
    ld [wArg1], a
    farcall DrawRecordNameAndSpeciesNameTiles
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 4 of the `rst $00` table in SwapMonstersMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wListCursor, wScreenStep
; writes: wScreenStep
SwapMonstersMenu_Case04_Case04::
Jump_01E_43E0:: ; address name
    ld a, [wListCursor]
    ld b, $BB
    ld hl, CursorCellTable7880
    call StoreBAtWordTableEntry_Bank1E
    call BGMapAddressAtScroll_Bank1E
    ld bc, $140B
    ld de, $01CC
    call DrawScreenBufferRect_Bank1E
    ld a, [wListCursor]
    ld b, $C3
    ld hl, CursorCellTable7880
    call StoreBAtWordTableEntry_Bank1E
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 5 of the `rst $00` table in SwapMonstersMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wListCursor, wScreenStep
; writes: wMenuInputResult, wTwoChoiceCursor, wScreenStep, wScriptCommandType, wScriptStartRequest
SwapMonstersMenu_Case04_Case05::
Jump_01E_440A:: ; address name
    xor a, a
    ld [wMenuInputResult], a
    farcall UpdateListCursorListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FD
    jr z, Jump_01E_4426
    cp a, $FE
    jr z, Jump_01E_442C
    cp a, $FF
    jr z, Jump_01E_4442
    ret

Jump_01E_4426::
    ld a, $01
    ld [wScreenStep], a
    ret

Jump_01E_442C::
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

Jump_01E_4442::
    ld a, [wListCursor]
    ld b, $BC
    ld hl, CursorCellTable7880
    call StoreBAtWordTableEntry_Bank1E
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    add a, $05
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 6 of the `rst $00` table in SwapMonstersMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg1, wArg2, wScreenStep
SwapMonstersMenu_Case04_Case06::
Jump_01E_4463:: ; address name
    ld c, $0D
    ld hl, $01D4
    ld de, $0008
    xor a, a
    ld [wArg1], a
    ld a, $0C
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_1E
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 7 of the `rst $00` table in SwapMonstersMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
SwapMonstersMenu_Case04_Case07::
Jump_01E_447F:: ; address name
    call BGMapAddressAtScroll_Bank1E
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank1E
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 8 of the `rst $00` table in SwapMonstersMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; points at: wScreenStep
SwapMonstersMenu_Case04_Case08::
Jump_01E_4493:: ; address name
    ld hl, GlyphCopyDestList1
    ld de, GlyphCopySrcList1
    call SwapMonstersMenu_Shared05
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in SwapMonstersMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wScreenState, wScriptCommandType, wScriptStartRequest
SwapMonstersMenu_Case04_Case09::
Jump_01E_44A1:: ; address name
    ld a, $03
    ld [wScreenStep], a
    ld a, $01
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 10 of the `rst $00` table in SwapMonstersMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; points at: wScreenStep
SwapMonstersMenu_Case04_Case0A::
Jump_01E_44B5:: ; address name
    ld hl, GlyphCopyDestList3
    ld de, GlyphCopySrcList3
    call SwapMonstersMenu_Shared05
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 11 of the `rst $00` table in SwapMonstersMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wChoiceCursor, wCursorBlinkAE, wScreenStep
SwapMonstersMenu_Case04_Case0B::
Jump_01E_44C3:: ; address name
    ld de, $44EF
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRows_Bank1E
    call BGMapAddressAtScroll_Bank1E
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank1E
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
TileRect_1E_44EF::
Data_01E_44EF:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $70, $71, $72, $73, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $74, $75, $C3, $C3, $C3, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 4

; entry 12 of the `rst $00` table in SwapMonstersMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wScreenStep, wChoiceCursor, wScreenState, wChoiceCursorF0, wListCursor, wPartyCount, ...
; writes: wTwoChoiceCursor, wScreenStep, wScriptCommandType, wScriptStartRequest, wScreenByteB2, wScreenByteB3, wScreenState, wScreenSubStep, ...
SwapMonstersMenu_Case04_Case0C::
Jump_01E_4517:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, Jump_01E_4533
    bit 7, a
    jr nz, Jump_01E_454D
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, Jump_01E_455D
    bit 1, a
    jp nz, Jump_01E_4687
    call BlinkCursorBlinkAE_Bank1E
    ret

Jump_01E_4533::
    call DrawBlankTileC3_46BB_Bank1E
    ld a, [wChoiceCursor]
    and a, a
    jr nz, Jump_01E_4540
    ld a, $01
    jr Jump_01E_4541

Jump_01E_4540::
    dec a

Jump_01E_4541::
    ld [wChoiceCursor], a
    call DrawCursorTileBB_46B7_Bank1E
    ld a, $69
    call QueueSoundEffect
    ret

Jump_01E_454D::
    call DrawBlankTileC3_46BB_Bank1E
    ld a, [wChoiceCursor]
    cp a, $01
    jr c, Jump_01E_455A
    xor a, a
    jr Jump_01E_4541

Jump_01E_455A::
    inc a
    jr Jump_01E_4541

Jump_01E_455D::
    ld a, $69
    call QueueSoundEffect
    call SwapMonstersMenu_Case04_Case0C_Sub01
    ld a, [wChoiceCursor]
    and a, a
    jp nz, Jump_01E_460F
    ld a, [wScreenState]
    cp a, $07
    jp z, Jump_01E_45EC
    cp a, $04
    jr z, Jump_01E_45B1
    cp a, $05
    jr z, Jump_01E_457C

Jump_01E_457C::
    ld a, [wScreenStep]
    cp a, $13
    jr c, Jump_01E_45A3
    cp a, $42
    jr c, Jump_01E_4595
    ld a, $05
    ld [wScreenByteB2], a
    ld a, $44
    ld [wScreenByteB3], a
    ld a, $09
    jr Jump_01E_45D2

Jump_01E_4595::
    ld a, $05
    ld [wScreenByteB2], a
    ld a, $2C
    ld [wScreenByteB3], a
    ld a, $08
    jr Jump_01E_45D2

Jump_01E_45A3::
    ld a, $05
    ld [wScreenByteB2], a
    ld a, $12
    ld [wScreenByteB3], a
    ld a, $09
    jr Jump_01E_45D2

Jump_01E_45B1::
    ld a, [wScreenStep]
    cp a, $10
    jr nc, Jump_01E_45C6
    ld a, $04
    ld [wScreenByteB2], a
    ld a, $0C
    ld [wScreenByteB3], a
    ld a, $08
    jr Jump_01E_45D2

Jump_01E_45C6::
    ld a, $04
    ld [wScreenByteB2], a
    ld a, $25
    ld [wScreenByteB3], a
    ld a, $09

Jump_01E_45D2::
    ld [wScreenState], a
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld [wTwoChoiceCursor], a
    call SaveAndHideSpriteState_Bank1E
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01E_45EC::
    ld a, [wScreenStep]
    cp a, $16
    jr nz, Jump_01E_4601
    ld a, $07
    ld [wScreenByteB2], a
    ld a, $16
    ld [wScreenByteB3], a
    ld a, $0A
    jr Jump_01E_45D2

Jump_01E_4601::
    ld a, $07
    ld [wScreenByteB2], a
    ld a, $2E
    ld [wScreenByteB3], a
    ld a, $0B
    jr Jump_01E_45D2

Jump_01E_460F::
    ld a, [wScreenState]
    cp a, $07
    jr nz, Jump_01E_465C
    ld a, [wChoiceCursorF0]
    and a, a
    jr nz, Jump_01E_4655
    ld a, [wListCursor]
    and a, a
    jr nz, Jump_01E_465C
    ld a, [wPartyCount]
    cp a, $02
    jr nc, Jump_01E_465C
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld b, a
    ld a, [wPartyList]
    cp a, b
    jr nz, Jump_01E_465C
    ld a, $03
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01E_4655::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a

Jump_01E_465C::
    ld a, [wScreenState]
    cp a, $04
    jr nz, Jump_01E_4670
    ld a, [wScreenStep]
    cp a, $0C
    jr nz, Jump_01E_4670
    farcall WritePlayerNameWithFlag0SuffixToTextBuf0

Jump_01E_4670::
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

Jump_01E_4687::
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

; cycles wD7AE through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3) for $10-$17 (after the joypad repeat timer reaches $14) (E-0122)
; 1 call site from 1 routine (e.g. SwapMonstersMenu_Case04_Case0C)
; reads: wJoypadRepeatTimer, wCursorBlinkAE, wChoiceCursor
; writes: wCursorBlinkAE
BlinkCursorBlinkAE_Bank1E::
Func_01E_469D:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, DrawCursorTileBB_46B7_Bank1E
    ld a, [wCursorBlinkAE]
    inc a
    ld [wCursorBlinkAE], a
    cp a, $10
    jr c, DrawCursorTileBB_46B7_Bank1E
    cp a, $18
    jr c, DrawBlankTileC3_46BB_Bank1E
    xor a, a
    ld [wCursorBlinkAE], a

; B = $BB (cursor tile) and joins the cursor draw (E-0122)
; 1 call site from 1 routine (e.g. SwapMonstersMenu_Case04_Case0C)
; reads: wChoiceCursor
DrawCursorTileBB_46B7_Bank1E::
Func_01E_46B7:: ; address name
    ld b, $BB
    jr Jump_01E_46C1

; B = $C3 (blank tile) and joins the cursor draw (E-0122)
; 2 call sites from 1 routine (e.g. SwapMonstersMenu_Case04_Case0C)
; reads: wChoiceCursor
DrawBlankTileC3_46BB_Bank1E::
Func_01E_46BB:: ; address name
    ld b, $C3
    jr Jump_01E_46C1

; only called from SwapMonstersMenu_Case04_Case0C (E-0047)
; 1 call site from 1 routine (e.g. SwapMonstersMenu_Case04_Case0C)
; reads: wChoiceCursor
SwapMonstersMenu_Case04_Case0C_Sub01::
Func_01E_46BF:: ; address name
    ld b, $BC

Jump_01E_46C1::
    ld a, [wChoiceCursor]
    add a, a
    ld hl, $46E1
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1E
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret
    db $2D, $01, $6D, $01

; copies box $4718 to wC410, runs Func_01E_75F2, blanks the cursor entry wD7AB of table $7880 and wD781 += 1 (E-0124)
; 5 call sites from 5 routines (e.g. SwapMonstersMenu_Case04_Case29, SwapMonstersMenu_Case04_Case0F, SwapMonstersMenu_Case05_Case48, SwapMonstersMenu_Case05_Case2F, ...)
; reads: wListCursor, wScreenStep
; writes: wArg1, wArg2, wScreenStep
DrawBox4718AndMenuAndStep_1E::
Func_01E_46E5:: ; address name
    ld de, $4718
    ld hl, wWindowTileBuffer + $110
    ld bc, $0801
    call CopyRectTo20ByteRows_Bank1E
    ld c, $04
    ld hl, $028C
    ld de, $00C0
    xor a, a
    ld [wArg1], a
    ld a, $08
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_1E
    ld a, [wListCursor]
    ld b, $C3
    ld hl, CursorCellTable7880
    call StoreBAtWordTableEntry_Bank1E
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 1 tiles, one row per line
TileRect_1E_4718::
Data_01E_4718:: ; address name
    db $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 0

; entry 14 of the `rst $00` table in SwapMonstersMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wScriptCommandType, wScriptStartRequest
SwapMonstersMenu_Case04_Case0E::
Jump_01E_4720:: ; address name
    call BGMapAddressAtScroll_Bank1E
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank1E
    ld a, $05
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 15 of the `rst $00` table in SwapMonstersMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wListCursor, wPartyCount
; writes: rRAMG2, rRAMB, hTemp0, wPartyCount, wOBJPaletteUploadRequest, wScreenStep, wListCursor, wChoiceCursor, ...
; points at: wListEntries, wPartyList
SwapMonstersMenu_Case04_Case0F::
Jump_01E_473B:: ; address name
    ld a, [wListCursor]
    ld hl, wListEntries
    add_a_to_hl
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, $01
    ldh [hTemp0], a
    ld a, [hl]
    ld c, $00
    ld b, $01
    call StoreTemp0BytesToSRAMRecord
    xor a, a
    ldh [hTemp0], a
    ld a, [hl]
    ld c, $55
    ld b, $01
    call StoreTemp0BytesToSRAMRecord
    xor a, a
    ld [rRAMG2], a
    ld a, [wPartyCount]
    and a, a
    jr z, Jump_01E_4774
    dec a
    ld [wPartyCount], a

Jump_01E_4774::
    farcall ListPartyRecordsWithState2ToListEntries
    ld hl, wListEntries
    ld de, wPartyList
    ld b, $03

Jump_01E_4782::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_01E_4782
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    call DrawBox4718AndMenuAndStep_1E
    ld a, $06
    ld [wScreenStep], a
    xor a, a
    ld [wListCursor], a
    ld [wChoiceCursor], a
    ld [wListCursorAux], a
    ld [wCursorBlinkAE], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 16 of the `rst $00` table in SwapMonstersMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wGridCursorX, wScreenStep
; writes: rRAMG2, rRAMB, wTwoChoiceCursor, wScreenState, wScreenStep, wScreenSubStep, wScriptCommandType, wScriptStartRequest
; points at: sRecords
SwapMonstersMenu_Case04_Case10::
Jump_01E_47B2:: ; address name
    farcall LoadRecordCapacityFromFarmLevelTable
    ld d, c
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld hl, sRecords
    ld c, $00

Jump_01E_47C7::
    ld a, [hl]
    cp a, $01
    jr z, Jump_01E_47DA

Jump_01E_47CC::
    ld a, $A5
    add_a_to_hl
    inc c
    ld a, c
    cp a, d
    jr c, Jump_01E_47C7
    jr Jump_01E_47EC

Jump_01E_47DA::
    push hl
    ld a, $6E
    add_a_to_hl
    ld a, [hl]
    and a, a
    jr z, Jump_01E_47E9
    pop hl
    jr Jump_01E_47CC

Jump_01E_47E9::
    pop hl
    jr Jump_01E_4817

Jump_01E_47EC::
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, $01
    ld [wScreenState], a
    ld a, $03
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    xor a, a
    ld [rRAMG2], a
    ld a, [wGridCursorX]
    ld b, $BC
    ld hl, CursorCellTable7880
    call StoreBAtWordTableEntry_Bank1E
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01E_4817::
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [rRAMG2], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 17 of the `rst $00` table in SwapMonstersMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wGridCursorX, wScreenStep
; writes: wScreenStep, wTwoChoiceCursor
SwapMonstersMenu_Case04_Case11::
Jump_01E_4831:: ; address name
    ld de, Data_01F_4370
    ld hl, vTiles1 + $5F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, $6C
    call QueueSoundEffect
    ld de, $4872
    ld hl, wWindowTileBuffer + $112
    ld bc, $0605
    call CopyRectTo20ByteRows_Bank1E
    ld a, [wGridCursorX]
    ld b, $BC
    ld hl, CursorCellTable7880
    call StoreBAtWordTableEntry_Bank1E
    call BGMapAddressAtScroll_Bank1E
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank1E
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 6 x 5 tiles, one row per line
TileRect_1E_4872::
Data_01E_4872:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $CE, $CF, $DF, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $F3, $A6, $C3, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B5 ; id 4

; entry 18 of the `rst $00` table in SwapMonstersMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wTwoChoiceCursor, wScreenStep
; writes: wScreenStep, wScreenSubStep, wScriptCommandType, wScriptStartRequest, wTwoChoiceCursor, wScreenState
SwapMonstersMenu_Case04_Case12::
Jump_01E_4890:: ; address name
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_01E_48A4
    cp a, $FF
    jr z, Jump_01E_48C4
    ret

Jump_01E_48A4::
    call SwapMonstersMenu_Case04_Case12_Sub01
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

Jump_01E_48C4::
    ld a, [wTwoChoiceCursor]
    cp a, $01
    jr z, Jump_01E_48A4
    call SwapMonstersMenu_Case04_Case12_Sub01
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

; only called from SwapMonstersMenu_Case04_Case12 (E-0047)
; 2 call sites from 1 routine (e.g. SwapMonstersMenu_Case04_Case12)
; reads: wIsCGB, rSVBK
; writes: rSVBK
SwapMonstersMenu_Case04_Case12_Sub01::
Func_01E_48E3:: ; address name
    ld hl, wWindowTileBuffer + $112
    ld de, wScreenTileBuffer + $AE
    ld c, $05
    call SwapMonstersMenu_Case04_Case12_Sub01_Sub01
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_01E_490B
    ldh a, [rSVBK]
    set 1, a
    ldh [rSVBK], a
    ld hl, wWindowAttrBuffer + $112
    ld de, wWorkBuf + $11
    ld c, $05
    call SwapMonstersMenu_Case04_Case12_Sub01_Sub01
    ldh a, [rSVBK]
    res 1, a
    ldh [rSVBK], a

Jump_01E_490B::
    call BGMapAddressAtScroll_Bank1E
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank1E
    ret

; only called from SwapMonstersMenu_Case04_Case12_Sub01 (E-0047)
; 2 call sites from 1 routine (e.g. SwapMonstersMenu_Case04_Case12_Sub01)
SwapMonstersMenu_Case04_Case12_Sub01_Sub01::
Func_01E_4918:: ; address name
    push bc
    push hl
    push de
    ld bc, $0006
    call CopyBytesDEToHL_Bank1E
    pop de
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    ld a, $14
    add a, e
    ld e, a
    jr nc, Jump_01E_492F
    inc d

Jump_01E_492F::
    dec c
    jr nz, SwapMonstersMenu_Case04_Case12_Sub01_Sub01
    ret

; entry 19 of the `rst $00` table in SwapMonstersMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wListPageIndex, wCursorBlinkAE, wScreenStep
SwapMonstersMenu_Case04_Case13::
Jump_01E_4933:: ; address name
    ld de, $495A
    ld hl, wWindowTileBuffer + $64
    ld bc, $080B
    call CopyRectTo20ByteRows_Bank1E
    call BGMapAddressAtScroll_Bank1E
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank1E
    xor a, a
    ld [wListPageIndex], a
    ld [wCursorBlinkAE], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 11 tiles, one row per line
TileRect_1E_495A::
Data_01E_495A:: ; address name
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

; entry 20 of the `rst $00` table in SwapMonstersMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
SwapMonstersMenu_Case04_Case14::
Jump_01E_49B2:: ; address name
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
    ld de, $7A41
    ld hl, wWindowTileBuffer + $64
    ld bc, $080B
    call CopyRectTo20ByteRows_Bank1E
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; far-calls ListRecordsState1WithByte6EClear and continues with Func_01E_49F8 (E-0122)
; 4 call sites from 4 routines (e.g. SwapMonstersMenu_Case09_Case06_Case03, SwapMonstersMenu_Case09_Case15_Case03, SwapMonstersMenu_Case09_Case1B_Case03, SwapMonstersMenu_Case09_Case20_Case03)
; reads: wListPages, wScreenStep
; writes: wArg1, wArg2, wScreenStep
ListRecordsState1ThenContinue::
Func_01E_49EA:: ; address name
    farcall ListRecordsState1WithByte6EClear
    jr SwapMonstersMenu_Shared02

; entry 6 of the `rst $00` table in SwapMonstersMenu_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wListPages, wScreenStep
; writes: wArg1, wArg2, wScreenStep
SwapMonstersMenu_Case06_Case06::
Jump_01E_49F2:: ; address name
    farcall ListRecordsInUseWithByte6EClear

; only called from routines of SwapMonstersMenu (E-0098)
; 5 call sites from 5 routines (e.g. SwapMonstersMenu_Case0E_Case01, SwapMonstersMenu_Case0E_Case06_Case03, SwapMonstersMenu_Case0E_Case15_Case03, SwapMonstersMenu_Case0E_Case1B_Case03, ...)
; reads: wListPages, wScreenStep
; writes: wArg1, wArg2, wScreenStep
SwapMonstersMenu_Shared02::
Func_01E_49F8:: ; address name
    call ClampRecordListPageCursor5
    ld a, [wListPages]
    cp a, $02
    jr c, Jump_01E_4A2A
    ld de, $0142
    call DrawC5BEC6AtScrollOffsetDE_Bank1E
    ld hl, wWindowTileBuffer + $12E
    call StoreC5BEC6AtHLStride2_Bank1E
    ld de, $0143
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    call DrawPageOfPagesAtScrollOffset
    ld hl, wWindowTileBuffer + $12F
    ld a, h
    ld [wArg1], a
    ld a, l
    ld [wArg2], a
    call DrawPageOfPagesAtArg1_Bank1E

Jump_01E_4A2A::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; far-calls Func_01F_5C15 (E-0122)
; 1 call site from 1 routine (e.g. RedrawRecordListAndNextStep)
CallFunc5C15InBank1F::
Func_01E_4A32:: ; address name
    farcall DrawRecordListPageNames
    ret

; entry 23 of the `rst $00` table in SwapMonstersMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg1, wScreenStep
SwapMonstersMenu_Case04_Case17::
Jump_01E_4A39:: ; address name
    call GetListEntriesCell5Address
    ld a, [hl]
    ld b, a
    push af
    call LoadFamilyIconTileForRecordB_Bank1E
    ld de, $795C
    ld hl, wWindowTileBuffer + $6C
    ld bc, $0C09
    call CopyRectTo20ByteRows_Bank1E
    pop af
    ld b, a
    ld [wArg1], a
    call CallFunc5B4DInBank1D
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 25 of the `rst $00` table in SwapMonstersMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg1, wScreenStep
SwapMonstersMenu_Case04_Case19::
Jump_01E_4A5E:: ; address name
    call GetListEntriesCell5Address
    ld a, [hl]
    ld b, a
    ld [wArg1], a
    farcall DrawRecordNameAndSpeciesNameTiles
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 27 of the `rst $00` table in SwapMonstersMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wScreenStep, wListCursor
; writes: wMenuInputResult, wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
; points at: wTextWindowTileLo
SwapMonstersMenu_Case04_Case1B::
Jump_01E_4A74:: ; address name
    xor a, a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_01E_4A98
    cp a, $FC
    jr z, Jump_01E_4A98
    cp a, $FD
    jr z, Jump_01E_4AD7
    cp a, $FE
    jr z, Jump_01E_4AA1
    cp a, $FF
    jr z, Jump_01E_4AA9
    ret

Jump_01E_4A98::
    ld a, [wScreenStep]
    sub a, $07
    ld [wScreenStep], a
    ret

Jump_01E_4AA1::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

Jump_01E_4AA9::
    ld a, [wScreenStep]
    add a, $08
    ld [wScreenStep], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wListCursor]
    ld b, $BC
    ld hl, CursorCellTable7880
    call StoreBAtWordTableEntry_Bank1E
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

Jump_01E_4AD7::
    ld a, [wScreenStep]
    sub a, $04
    ld [wScreenStep], a
    ret

; entry 32 of the `rst $00` table in SwapMonstersMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
SwapMonstersMenu_Case04_Case20::
Jump_01E_4AE0:: ; address name
    ld hl, GlyphCopyDestList2
    ld de, GlyphCopySrcList2
    call SwapMonstersMenu_Shared05
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 33 of the `rst $00` table in SwapMonstersMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
SwapMonstersMenu_Case04_Case21::
Jump_01E_4AF1:: ; address name
    farcall DrawRecordListNameTiles_Bank1D
    farcall ListPartyRecordsWithState2ToListEntries
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 34 of the `rst $00` table in SwapMonstersMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wGridCursorX
; writes: wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
SwapMonstersMenu_Case04_Case22::
Jump_01E_4B05:: ; address name
    ld de, $79C8
    ld hl, wWindowTileBuffer + $64
    ld bc, $0B0B
    call CopyRectTo20ByteRows_Bank1E
    ld a, [wGridCursorX]
    ld b, $C3
    ld hl, CursorCellTable7880
    call StoreBAtWordTableEntry_Bank1E
    call BGMapAddressAtScroll_Bank1E
    ld bc, $140B
    ld de, $01CC
    call DrawScreenBufferRect_Bank1E
    farcall CountRecordsInUse
    ld a, $11
    ld [wScreenStep], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 39 of the `rst $00` table in SwapMonstersMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wScriptCommandType, wScriptStartRequest
SwapMonstersMenu_Case04_Case27::
Jump_01E_4B42:: ; address name
    call BGMapAddressAtScroll_Bank1E
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank1E
    ld a, $1B
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 40 of the `rst $00` table in SwapMonstersMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wPartyList, wScreenStep
; writes: rRAMG2, rRAMB, wNameGlyphBuf, wScreenStep, wScriptCommandType, wScriptStartRequest
; points at: wNameGlyphBuf, wTextBuf0, wTextWindowTileLo
SwapMonstersMenu_Case04_Case28::
Jump_01E_4B5D:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [wPartyList]
    ld c, $01
    call CopyRecordNameToNameGlyphBuf
    ld a, $F0
    ld [wNameGlyphBuf + $A], a
    ld hl, wNameGlyphBuf
    ld de, wTextBuf0
    ld c, $00

Jump_01E_4B7B::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_01E_4B89
    ld [de], a
    inc de
    inc hl
    inc c
    ld a, c
    cp a, $0A
    jr c, Jump_01E_4B7B

Jump_01E_4B89::
    ld a, $90
    ld [de], a
    inc de
    ld a, $3A
    ld [de], a
    inc de
    ld a, $2C
    ld [de], a
    inc de
    ld a, $37
    ld [de], a
    inc de
    ld a, $2B
    ld [de], a
    inc de
    ld a, $90
    ld [de], a
    inc de
    push de
    call GetListEntriesCell5Address
    ld a, [hl]
    ld c, $01
    call CopyRecordNameToNameGlyphBuf
    pop de
    ld a, $F0
    ld [wNameGlyphBuf + $A], a
    ld hl, wNameGlyphBuf

Jump_01E_4BB4::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_01E_4BBE
    ld [de], a
    inc de
    inc hl
    jr Jump_01E_4BB4

Jump_01E_4BBE::
    ld [de], a
    xor a, a
    ld [rRAMG2], a
    ld a, [wScreenStep]
    inc a
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

; entry 41 of the `rst $00` table in SwapMonstersMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: rRAMG2, rRAMB, hTemp0, wPartyList, wOBJPaletteUploadRequest, wListCursor, wChoiceCursor, wListPageIndex, ...
; points at: wPartyList
SwapMonstersMenu_Case04_Case29::
Jump_01E_4BE1:: ; address name
    ld hl, wPartyList
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, $01
    ldh [hTemp0], a
    ld a, [hl]
    ld c, $00
    ld b, $01
    call StoreTemp0BytesToSRAMRecord
    xor a, a
    ldh [hTemp0], a
    ld a, [hl]
    ld c, $55
    ld b, $01
    call StoreTemp0BytesToSRAMRecord
    call GetListEntriesCell5Address
    push hl
    ld a, $02
    ldh [hTemp0], a
    ld a, [hl]
    ld c, $00
    ld b, $01
    call StoreTemp0BytesToSRAMRecord
    xor a, a
    ld [rRAMG2], a
    pop hl
    ld a, [hl]
    ld [wPartyList], a
    farcall ListPartyRecordsWithState2ToListEntries
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    call DrawBox4718AndMenuAndStep_1E
    xor a, a
    ld [wListCursor], a
    ld [wChoiceCursor], a
    ld [wListPageIndex], a
    ld [wListCursorAux], a
    ld [wCursorBlinkAE], a
    ret

; entry 48 of the `rst $00` table in SwapMonstersMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wScreenState, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
SwapMonstersMenu_Case04_Case30::
Jump_01E_4C42:: ; address name
    ld de, $79C8
    ld hl, wWindowTileBuffer + $64
    ld bc, $0B0B
    call CopyRectTo20ByteRows_Bank1E
    call BGMapAddressAtScroll_Bank1E
    ld bc, $140B
    ld de, $01CC
    call DrawScreenBufferRect_Bank1E
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

; entry 5 of the `rst $00` table in SwapMonstersMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
SwapMonstersMenu_Case05::
Jump_01E_4C78:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw SwapMonstersMenu_Case04_Case13
    dw SwapMonstersMenu_Case04_Case14
    dw ListRecordsState1ThenContinue
    dw CallFunc5C15InBank1F
    dw SwapMonstersMenu_Case04_Case17
    dw SwapMonstersMenu_Case04_Case02
    dw SwapMonstersMenu_Case04_Case19
    dw SwapMonstersMenu_Case04_Case04
    dw SwapMonstersMenu_Case04_Case1B
    dw SwapMonstersMenu_Case04_Case06
    dw SwapMonstersMenu_Case04_Case07
    dw SwapMonstersMenu_Case04_Case08
    dw SwapMonstersMenu_Case04_Case13
    dw SwapMonstersMenu_Case04_Case20
    dw SwapMonstersMenu_Case04_Case21
    dw SwapMonstersMenu_Case04_Case30
    dw SwapMonstersMenu_Case04_Case0A
    dw SwapMonstersMenu_Case04_Case0B
    dw SwapMonstersMenu_Case04_Case0C
    dw DrawBox4718AndMenuAndStep_1E
    dw SwapMonstersMenu_Case05_Case14
    dw SwapMonstersMenu_Case05_Case15
    dw SwapMonstersMenu_Case05_Case16
    dw SwapMonstersMenu_Case04_Case06
    dw SwapMonstersMenu_Case04_Case07
    dw SwapMonstersMenu_Case04_Case08
    dw SwapMonstersMenu_Case04_Case13
    dw SwapMonstersMenu_Case04_Case20
    dw SwapMonstersMenu_Case04_Case21
    dw SwapMonstersMenu_Case04_Case30
    dw SwapMonstersMenu_Case04_Case11
    dw SwapMonstersMenu_Case04_Case12
    dw SwapMonstersMenu_Case04_Case00
    dw SwapMonstersMenu_Case04_Case01
    dw SwapMonstersMenu_Case04_Case02
    dw SwapMonstersMenu_Case04_Case03
    dw SwapMonstersMenu_Case04_Case04
    dw SwapMonstersMenu_Case05_Case25
    dw SwapMonstersMenu_Case04_Case06
    dw SwapMonstersMenu_Case04_Case07
    dw SwapMonstersMenu_Case04_Case08
    dw SwapMonstersMenu_Case05_Case29
    dw SwapMonstersMenu_Case04_Case0A
    dw SwapMonstersMenu_Case04_Case0B
    dw SwapMonstersMenu_Case04_Case0C
    dw DrawBox4718AndMenuAndStep_1E
    dw SwapMonstersMenu_Case05_Case2E
    dw SwapMonstersMenu_Case05_Case2F
    dw SwapMonstersMenu_Case05_Case30
    dw SwapMonstersMenu_Case04_Case13
    dw SwapMonstersMenu_Case04_Case14
    dw ListRecordsState1ThenContinue
    dw CallFunc5C15InBank1F
    dw SwapMonstersMenu_Case04_Case17
    dw SwapMonstersMenu_Case04_Case02
    dw SwapMonstersMenu_Case04_Case19
    dw SwapMonstersMenu_Case04_Case04
    dw SwapMonstersMenu_Case05_Case39
    dw SwapMonstersMenu_Case05_Case3A
    dw SwapMonstersMenu_Case05_Case3B
    dw SwapMonstersMenu_Case05_Case3C
    dw SwapMonstersMenu_Case05_Case3D
    dw SwapMonstersMenu_Case04_Case01
    dw SwapMonstersMenu_Case04_Case02
    dw SwapMonstersMenu_Case04_Case03
    dw SwapMonstersMenu_Case05_Case41
    dw SwapMonstersMenu_Case04_Case0A
    dw SwapMonstersMenu_Case04_Case0B
    dw SwapMonstersMenu_Case04_Case0C
    dw DrawBox4718AndMenuAndStep_1E
    dw SwapMonstersMenu_Case05_Case46
    dw SwapMonstersMenu_Case05_Case47
    dw SwapMonstersMenu_Case05_Case48
    dw SwapMonstersMenu_Case04_Case06
    dw SwapMonstersMenu_Case04_Case07
    dw SwapMonstersMenu_Case04_Case08
    dw SwapMonstersMenu_Case04_Case13
    dw SwapMonstersMenu_Case04_Case20
    dw SwapMonstersMenu_Case04_Case21
    dw SwapMonstersMenu_Case04_Case30

; entry 20 of the `rst $00` table in SwapMonstersMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wScriptCommandType, wScriptStartRequest
SwapMonstersMenu_Case05_Case14::
Jump_01E_4D1C:: ; address name
    call BGMapAddressAtScroll_Bank1E
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank1E
    ld a, $08
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 21 of the `rst $00` table in SwapMonstersMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep, wScriptCommandType, wScriptStartRequest
; points at: wTextWindowTileLo
SwapMonstersMenu_Case05_Case15::
Jump_01E_4D37:: ; address name
    farcall WritePlayerNameWithFlag0SuffixToTextBuf0
    ld a, [wScreenStep]
    inc a
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

; entry 22 of the `rst $00` table in SwapMonstersMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wPartyCount
; writes: rRAMG2, rRAMB, hTemp0, wPartyCount, wOBJPaletteUploadRequest, wListCursor, wChoiceCursor, wListPageIndex, ...
; points at: wPartyList
SwapMonstersMenu_Case05_Case16::
Jump_01E_4D5B:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    call GetListEntriesCell5Address
    ld a, $02
    ldh [hTemp0], a
    ld a, [hl]
    ld c, $00
    ld b, $01
    call StoreTemp0BytesToSRAMRecord
    ld a, [wPartyCount]
    ld hl, wPartyList
    add_a_to_hl
    push hl
    call GetListEntriesCell5Address
    ld a, [hl]
    pop hl
    ld [hl], a
    ld a, [wPartyCount]
    inc a
    ld [wPartyCount], a
    xor a, a
    ld [rRAMG2], a
    farcall ListPartyRecordsWithState2ToListEntries
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    call DrawBox4718AndMenuAndStep_1E
    xor a, a
    ld [wListCursor], a
    ld [wChoiceCursor], a
    ld [wListPageIndex], a
    ld [wListCursorAux], a
    ld [wCursorBlinkAE], a
    ret

; entry 37 of the `rst $00` table in SwapMonstersMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wListCursor, wScreenStep
; writes: wMenuInputResult, wTwoChoiceCursor, wScreenStep, wScriptCommandType, wScriptStartRequest
SwapMonstersMenu_Case05_Case25::
Jump_01E_4DB5:: ; address name
    xor a, a
    ld [wMenuInputResult], a
    farcall UpdateListCursorListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FD
    jr z, Jump_01E_4DD1
    cp a, $FE
    jr z, Jump_01E_4DD7
    cp a, $FF
    jr z, Jump_01E_4DED
    ret

Jump_01E_4DD1::
    ld a, $21
    ld [wScreenStep], a
    ret

Jump_01E_4DD7::
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

Jump_01E_4DED::
    ld a, [wListCursor]
    ld b, $BC
    ld hl, CursorCellTable7880
    call StoreBAtWordTableEntry_Bank1E
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    add a, $05
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 41 of the `rst $00` table in SwapMonstersMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wGridCursorX
; writes: wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
SwapMonstersMenu_Case05_Case29::
Jump_01E_4E0E:: ; address name
    ld de, $79C8
    ld hl, wWindowTileBuffer + $64
    ld bc, $0B0B
    call CopyRectTo20ByteRows_Bank1E
    ld a, [wGridCursorX]
    ld b, $BC
    ld hl, CursorCellTable7880
    call StoreBAtWordTableEntry_Bank1E
    call BGMapAddressAtScroll_Bank1E
    ld bc, $140B
    ld de, $01CC
    call DrawScreenBufferRect_Bank1E
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

; entry 46 of the `rst $00` table in SwapMonstersMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wScriptCommandType, wScriptStartRequest
SwapMonstersMenu_Case05_Case2E::
Jump_01E_4E4B:: ; address name
    call BGMapAddressAtScroll_Bank1E
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank1E
    ld a, $25
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 48 of the `rst $00` table in SwapMonstersMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep, wListCursor
; writes: wScreenStep, wItemGridX, wSelectedRecord, wListCursor, wListPageIndex, wScriptCommandType, wScriptStartRequest
; points at: wListEntries
SwapMonstersMenu_Case05_Case30::
Jump_01E_4E66:: ; address name
    call BGMapAddressAtScroll_Bank1E
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank1E
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, [wListCursor]
    ld [wItemGridX], a
    ld hl, wListEntries
    add_a_to_hl
    ld a, [hl]
    ld [wSelectedRecord], a
    xor a, a
    ld [wListCursor], a
    ld [wListPageIndex], a
    farcall ListRecordsState1WithByte6EClear
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret
    db $C9

; entry 58 of the `rst $00` table in SwapMonstersMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
SwapMonstersMenu_Case05_Case3A::
Jump_01E_4EA3:: ; address name
    ld de, $7A99
    ld hl, wWindowTileBuffer + $64
    ld bc, $080B
    call CopyRectTo20ByteRows_Bank1E
    call BGMapAddressAtScroll_Bank1E
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank1E
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 59 of the `rst $00` table in SwapMonstersMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
SwapMonstersMenu_Case05_Case3B::
Jump_01E_4EC3:: ; address name
    ld hl, GlyphCopyDestList2
    ld de, GlyphCopySrcList2
    call SwapMonstersMenu_Shared05
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 60 of the `rst $00` table in SwapMonstersMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wItemGridX, wScreenStep
; writes: wListCursor, wListPageIndex, wScreenStep
SwapMonstersMenu_Case05_Case3C::
Jump_01E_4ED4:: ; address name
    ld de, $7AF1
    ld hl, wWindowTileBuffer + $64
    ld bc, $080B
    call CopyRectTo20ByteRows_Bank1E
    ld a, [wItemGridX]
    ld [wListCursor], a
    xor a, a
    ld [wListPageIndex], a
    call BGMapAddressAtScroll_Bank1E
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank1E
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 65 of the `rst $00` table in SwapMonstersMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
; points at: wTextWindowTileLo
SwapMonstersMenu_Case05_Case41::
Jump_01E_4EFE:: ; address name
    call BGMapAddressAtScroll_Bank1E
    ld bc, $140B
    ld de, $01CC
    call DrawScreenBufferRect_Bank1E
    ld a, $25
    ld [wScreenStep], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    farcall ListPartyRecordsWithState2ToListEntries
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

; entry 57 of the `rst $00` table in SwapMonstersMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wScreenStep, wListCursor
; writes: wMenuInputResult, wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
; points at: wTextWindowTileLo
SwapMonstersMenu_Case05_Case39::
Jump_01E_4F31:: ; address name
    xor a, a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_01E_4F55
    cp a, $FC
    jr z, Jump_01E_4F55
    cp a, $FD
    jr z, Jump_01E_4F94
    cp a, $FE
    jr z, Jump_01E_4F5E
    cp a, $FF
    jr z, Jump_01E_4F66
    ret

Jump_01E_4F55::
    ld a, [wScreenStep]
    sub a, $07
    ld [wScreenStep], a
    ret

Jump_01E_4F5E::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

Jump_01E_4F66::
    ld a, [wScreenStep]
    add a, $09
    ld [wScreenStep], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wListCursor]
    ld b, $BC
    ld hl, CursorCellTable7880
    call StoreBAtWordTableEntry_Bank1E
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

Jump_01E_4F94::
    ld a, [wScreenStep]
    sub a, $04
    ld [wScreenStep], a
    ret

; entry 47 of the `rst $00` table in SwapMonstersMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wListCursor
SwapMonstersMenu_Case05_Case2F::
Jump_01E_4F9D:: ; address name
    call DrawBox4718AndMenuAndStep_1E
    ld a, [wListCursor]
    ld b, $BC
    ld hl, CursorCellTable7880
    call StoreBAtWordTableEntry_Bank1E
    ret

; entry 61 of the `rst $00` table in SwapMonstersMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep, wScreenStep, wPartyCount
; writes: wScreenSubStep, wScreenStep, rRAMG2, rRAMB, wNameGlyphBuf
; points at: wPartyList
SwapMonstersMenu_Case05_Case3D::
Jump_01E_4FAC:: ; address name
    ld a, [wScreenSubStep]
    and a, a
    jp z, Jump_01E_42A9
    cp a, $01
    jp z, SwapMonstersMenu_Case0E_Case07_Sub01
    jp Jump_01E_430D

; entry 70 of the `rst $00` table in SwapMonstersMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wScriptCommandType, wScriptStartRequest
SwapMonstersMenu_Case05_Case46::
Jump_01E_4FBB:: ; address name
    call BGMapAddressAtScroll_Bank1E
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank1E
    ld a, $39
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 71 of the `rst $00` table in SwapMonstersMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wSelectedRecord, wScreenStep
; writes: rRAMG2, rRAMB, wNameGlyphBuf, wScreenStep, wScriptCommandType, wScriptStartRequest
; points at: wNameGlyphBuf, wTextBuf0, wTextWindowTileLo
SwapMonstersMenu_Case05_Case47::
Jump_01E_4FD6:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [wSelectedRecord]
    ld c, $01
    call CopyRecordNameToNameGlyphBuf
    ld a, $F0
    ld [wNameGlyphBuf + $A], a
    ld hl, wNameGlyphBuf
    ld de, wTextBuf0
    ld c, $00
    jp Jump_01E_4B7B

; entry 72 of the `rst $00` table in SwapMonstersMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wSelectedRecord, wItemGridX
; writes: rRAMG2, rRAMB, hTemp0, wItemGridX, wSelectedRecord, wOBJPaletteUploadRequest, wListCursor, wChoiceCursor, ...
; points at: wPartyList
SwapMonstersMenu_Case05_Case48::
Jump_01E_4FF7:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    call GetListEntriesCell5Address
    ld a, $02
    ldh [hTemp0], a
    ld a, [hl]
    ld c, $00
    ld b, $01
    call StoreTemp0BytesToSRAMRecord
    ld a, $01
    ldh [hTemp0], a
    ld a, [wSelectedRecord]
    ld c, $00
    ld b, $01
    call StoreTemp0BytesToSRAMRecord
    xor a, a
    ldh [hTemp0], a
    ld a, [wSelectedRecord]
    ld c, $55
    ld b, $01
    call StoreTemp0BytesToSRAMRecord
    ld a, [wItemGridX]
    ld hl, wPartyList
    add_a_to_hl
    push hl
    call GetListEntriesCell5Address
    ld a, [hl]
    pop hl
    ld [hl], a
    xor a, a
    ld [wItemGridX], a
    ld [wSelectedRecord], a
    xor a, a
    ld [rRAMG2], a
    farcall ListPartyRecordsWithState2ToListEntries
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    call DrawBox4718AndMenuAndStep_1E
    xor a, a
    ld [wListCursor], a
    ld [wChoiceCursor], a
    ld [wListPageIndex], a
    ld [wListCursorAux], a
    ld [wCursorBlinkAE], a
    ret

; entry 6 of the `rst $00` table in SwapMonstersMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
SwapMonstersMenu_Case06::
Jump_01E_506C:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw SwapMonstersMenu_Case06_Case00
    dw SwapMonstersMenu_Case06_Case01
    dw SwapMonstersMenu_Case06_Case02
    dw SwapMonstersMenu_Case06_Case03
    dw SwapMonstersMenu_Case04_Case13
    dw SwapMonstersMenu_Case04_Case14
    dw SwapMonstersMenu_Case06_Case06
    dw CallFunc5C15InBank1F
    dw SwapMonstersMenu_Case06_Case08
    dw SwapMonstersMenu_Case04_Case02
    dw SwapMonstersMenu_Case04_Case19
    dw SwapMonstersMenu_Case04_Case04
    dw SwapMonstersMenu_Case06_Case0C
    dw SwapMonstersMenu_Case06_Case0D
    dw SwapMonstersMenu_Case04_Case07
    dw SwapMonstersMenu_Case04_Case08
    dw SwapMonstersMenu_Case04_Case13
    dw SwapMonstersMenu_Case04_Case20
    dw SwapMonstersMenu_Case04_Case21
    dw SwapMonstersMenu_Case06_Case13
    dw SwapMonstersMenu_Case06_Case14
    dw SwapMonstersMenu_Case06_Case15
    dw SwapMonstersMenu_Case06_Case16
    dw SwapMonstersMenu_Case06_Case17
    dw SwapMonstersMenu_Case06_Case18
    dw SwapMonstersMenu_Case06_Case19
    dw SwapMonstersMenu_Case06_Case1A
    dw SwapMonstersMenu_Case06_Case1B
    dw SwapMonstersMenu_Case06_Case0D
    dw SwapMonstersMenu_Case06_Case1D
    dw SwapMonstersMenu_Case06_Case1E

; entry 0 of the `rst $00` table in SwapMonstersMenu_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep, wListCount, wDigits, wRecordsFlagged, wGridCursorX
; writes: wScreenStep, wChoiceCursorF0
SwapMonstersMenu_Case06_Case00::
Jump_01E_50AE:: ; address name
    ld hl, GlyphCopyDestList5
    ld de, GlyphCopySrcList5
    call SwapMonstersMenu_Shared05
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a

; entry 1 of the `rst $00` table in SwapMonstersMenu_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wListCount, wDigits, wRecordsFlagged, wGridCursorX, wScreenStep
; writes: wChoiceCursorF0, wScreenStep
SwapMonstersMenu_Case06_Case01::
Jump_01E_50BE:: ; address name
    ld de, $7BBE
    ld hl, wWindowTileBuffer + $10B
    ld bc, $0D05
    call CopyRectTo20ByteRows_Bank1E
    ld a, $6C
    call QueueSoundEffect
    farcall ListRecordsInUseWithByte6EClear
    ld a, [wListCount]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call BlankLeadingZeroDigits_F
    ld hl, wWindowTileBuffer + $129
    ld a, [wDigits + $1]
    add a, $E0
    ld [hl+], a
    ld a, [wDigits + $2]
    add a, $E0
    ld [hl], a
    ld a, [wRecordsFlagged]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call BlankLeadingZeroDigits_F
    ld hl, wWindowTileBuffer + $151
    ld a, [wDigits + $1]
    add a, $E0
    ld [hl+], a
    ld a, [wDigits + $2]
    add a, $E0
    ld [hl], a
    ld a, [wGridCursorX]
    ld b, $BC
    ld hl, CursorCellTable7880
    call StoreBAtWordTableEntry_Bank1E
    call BGMapAddressAtScroll_Bank1E
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank1E
    xor a, a
    ld [wChoiceCursorF0], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 2 of the `rst $00` table in SwapMonstersMenu_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wChoiceCursorF0, wScreenStep, wRecordsFlagged, wScreenState
; writes: wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wChoiceCursorF0, wCursorBlinkB8
; points at: wTextWindowTileLo
SwapMonstersMenu_Case06_Case02::
Jump_01E_512E:: ; address name
    farcall SwapMonstersMenu_Shared01
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FD
    ret z
    cp a, $FE
    jr z, Jump_01E_5145
    cp a, $FF
    jr z, Jump_01E_5162
    ret

Jump_01E_5145::
    ld a, $03
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wChoiceCursorF0], a
    ld [wCursorBlinkB8], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01E_5162::
    ld a, [wChoiceCursorF0]
    and a, a
    jr nz, Jump_01E_5199
    call BlankTwoTableEntries788A
    ld a, [wChoiceCursorF0]
    ld b, $BC
    ld hl, CursorCellTable788A
    call StoreBAtWordTableEntry_Bank1E
    ld a, [wScreenStep]
    add a, $02
    ld [wScreenStep], a
    xor a, a
    ld [wTwoChoiceCursor], a
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

Jump_01E_5199::
    ld a, [wRecordsFlagged]
    and a, a
    jr nz, Jump_01E_51AE
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01E_51AE::
    call BlankTwoTableEntries788A
    ld a, [wChoiceCursorF0]
    ld b, $BC
    ld hl, CursorCellTable788A
    call StoreBAtWordTableEntry_Bank1E
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wScreenState]
    cp a, $07
    jr z, Jump_01E_51D7
    ld a, $15
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01E_51D7::
    ld a, $22
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 3 of the `rst $00` table in SwapMonstersMenu_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wGridCursorX
; writes: wArg1, wArg2, wScreenStep, wScreenSubStep, wScreenState, wScriptCommandType, wScriptStartRequest
SwapMonstersMenu_Case06_Case03::
Jump_01E_51E6:: ; address name
    ld c, $05
    ld hl, $0273
    ld de, $00A7
    xor a, a
    ld [wArg1], a
    ld a, $0D
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_1E
    ld a, [wGridCursorX]
    ld b, $C3
    ld hl, CursorCellTable7880
    call StoreBAtWordTableEntry_Bank1E
    call BGMapAddressAtScroll_Bank1E
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank1E
    ld de, Data_01F_4A70
    ld hl, vTiles1 + $7F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4370
    ld hl, vTiles1 + $5F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, $79C8
    ld hl, wWindowTileBuffer + $64
    ld bc, $0B0B
    call CopyRectTo20ByteRows_Bank1E
    call BGMapAddressAtScroll_Bank1E
    ld bc, $140B
    ld de, $01CC
    call DrawScreenBufferRect_Bank1E
    farcall CountRecordsInUse
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $02
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 8 of the `rst $00` table in SwapMonstersMenu_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg1, wScreenStep
SwapMonstersMenu_Case06_Case08::
Jump_01E_525F:: ; address name
    call GetListEntriesCell5Address
    ld a, [hl]
    ld b, a
    call LoadFamilyIconTileForRecordB_Bank1E
    ld de, $795C
    ld hl, wWindowTileBuffer + $6C
    ld bc, $0C09
    call CopyRectTo20ByteRows_Bank1E
    xor a, a
    ld [wArg1], a
    farcall MarkPartyMembersInRecordListPage
    call GetListEntriesCell5Address
    ld a, [hl]
    ld b, a
    ld [wArg1], a
    call CallFunc5B4DInBank1D
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 12 of the `rst $00` table in SwapMonstersMenu_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wScreenStep, wListCursor
; writes: wMenuInputResult, wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wListCursor
; points at: wTextWindowTileLo
SwapMonstersMenu_Case06_Case0C::
Jump_01E_5290:: ; address name
    xor a, a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_01E_52B4
    cp a, $FC
    jr z, Jump_01E_52B4
    cp a, $FD
    jr z, Jump_01E_52F7
    cp a, $FE
    jr z, Jump_01E_52BD
    cp a, $FF
    jr z, Jump_01E_52C9
    ret

Jump_01E_52B4::
    ld a, [wScreenStep]
    sub a, $07
    ld [wScreenStep], a
    ret

Jump_01E_52BD::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wListCursor], a
    ret

Jump_01E_52C9::
    ld a, [wScreenStep]
    add a, $08
    ld [wScreenStep], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wListCursor]
    ld b, $BC
    ld hl, CursorCellTable7880
    call StoreBAtWordTableEntry_Bank1E
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

Jump_01E_52F7::
    ld a, [wScreenStep]
    sub a, $04
    ld [wScreenStep], a
    ret

; entry 13 of the `rst $00` table in SwapMonstersMenu_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wListCount, wDigits, wScreenStep
; writes: wArg1, wArg2, wScreenStep
SwapMonstersMenu_Case06_Case0D::
Jump_01E_5300:: ; address name
    ld c, $09
    ld hl, $01D4
    ld de, $0008
    xor a, a
    ld [wArg1], a
    ld a, $0C
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_1E
    ld de, $5343
    ld hl, wWindowTileBuffer + $10B
    ld bc, $0D03
    call CopyRectTo20ByteRows_Bank1E
    ld a, [wListCount]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call BlankLeadingZeroDigits_F
    ld hl, wWindowTileBuffer + $129
    ld a, [wDigits + $1]
    add a, $E0
    ld [hl+], a
    ld a, [wDigits + $2]
    add a, $E0
    ld [hl], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 13 x 3 tiles, one row per line
TileRect_1E_5343::
Data_01E_5343:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $BC, $7C, $7D, $7E, $DF, $7F, $FE, $FF, $76, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2

; entry 19 of the `rst $00` table in SwapMonstersMenu_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wGridCursorX, wListCount, wDigits, wRecordsFlagged
; writes: wChoiceCursorF0, wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
SwapMonstersMenu_Case06_Case13::
Jump_01E_536A:: ; address name
    ld de, $79C8
    ld hl, wWindowTileBuffer + $64
    ld bc, $0B0B
    call CopyRectTo20ByteRows_Bank1E
    ld a, [wGridCursorX]
    ld b, $BC
    ld hl, CursorCellTable7880
    call StoreBAtWordTableEntry_Bank1E
    call BGMapAddressAtScroll_Bank1E
    ld bc, $140B
    ld de, $01CC
    call DrawScreenBufferRect_Bank1E
    farcall CountRecordsInUse
    ld de, $7BBE
    ld hl, wWindowTileBuffer + $10B
    ld bc, $0D05
    call CopyRectTo20ByteRows_Bank1E
    ld a, $6C
    call QueueSoundEffect
    farcall ListRecordsInUseWithByte6EClear
    ld a, [wListCount]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call BlankLeadingZeroDigits_F
    ld hl, wWindowTileBuffer + $129
    ld a, [wDigits + $1]
    add a, $E0
    ld [hl+], a
    ld a, [wDigits + $2]
    add a, $E0
    ld [hl], a
    ld a, [wRecordsFlagged]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call BlankLeadingZeroDigits_F
    ld hl, wWindowTileBuffer + $151
    ld a, [wDigits + $1]
    add a, $E0
    ld [hl+], a
    ld a, [wDigits + $2]
    add a, $E0
    ld [hl], a
    ld a, [wGridCursorX]
    ld b, $BC
    ld hl, CursorCellTable7880
    call StoreBAtWordTableEntry_Bank1E
    call BGMapAddressAtScroll_Bank1E
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank1E
    xor a, a
    ld [wChoiceCursorF0], a
    ld a, $02
    ld [wScreenStep], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 20 of the `rst $00` table in SwapMonstersMenu_Case06
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenByteB2, wScreenByteB3, wScreenStep, wScreenSubStep, wScreenState
SwapMonstersMenu_Case06_Case14::
Jump_01E_540F:: ; address name
    ld a, $06
    ld [wScreenByteB2], a
    ld a, $0C
    ld [wScreenByteB3], a
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $0A
    ld [wScreenState], a
    call SaveAndHideSpriteState_Bank1E
    ret

; entry 21 of the `rst $00` table in SwapMonstersMenu_Case06
; no direct call (reached through a table, a jump or a vector)
SwapMonstersMenu_Case06_Case15::
Jump_01E_5429:: ; address name
    farcall LoadTileList6DC4SixPerFrame
    ret

; entry 22 of the `rst $00` table in SwapMonstersMenu_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wChoiceCursorF0, wScreenStep
; writes: wScreenStep
SwapMonstersMenu_Case06_Case16::
Jump_01E_5430:: ; address name
    ld de, $5461
    ld hl, wWindowTileBuffer + $6B
    ld bc, $0D09
    call CopyRectTo20ByteRows_Bank1E
    ld a, [wChoiceCursorF0]
    ld b, $BC
    ld hl, CursorCellTable788A
    call StoreBAtWordTableEntry_Bank1E
    call BGMapAddressAtScroll_Bank1E
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank1E
    farcall ListRecordsInUseWithByte6ESet
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 13 x 9 tiles, one row per line
TileRect_1E_5461::
Data_01E_5461:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 8

; entry 23 of the `rst $00` table in SwapMonstersMenu_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
; points at: wTextWindowTileLo
SwapMonstersMenu_Case06_Case17::
Jump_01E_54D6:: ; address name
    ld hl, vTiles1 + $3F0
    ld bc, $0401
    call FillTilesBxC
    ld hl, vTiles1 + $470
    ld bc, $0501
    call FillTilesBxC
    ld hl, vTiles1 + $500
    ld bc, $0F01
    call FillTilesBxC
    ld hl, vTiles1 + $6A0
    ld bc, $0401
    call FillTilesBxC
    ld hl, vTiles1 + $750
    ld bc, $0801
    call FillTilesBxC
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 24 of the `rst $00` table in SwapMonstersMenu_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wListPages, wScreenStep
; writes: wArg1, wArg2, wScreenStep
SwapMonstersMenu_Case06_Case18::
Jump_01E_5518:: ; address name
    ld de, $7B49
    ld hl, wWindowTileBuffer + $6B
    ld bc, $0D09
    call CopyRectTo20ByteRows_Bank1E
    call ClampRecordListPageCursor4
    ld a, [wListPages]
    cp a, $02
    jr c, Jump_01E_5556
    ld de, $010E
    call DrawC5BEC6AtScrollOffsetDE_Bank1E
    ld hl, wWindowTileBuffer + $112
    call StoreC5BEC6AtHLStride2_Bank1E
    ld de, $010F
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    call DrawPageOfPagesAtScrollOffset
    ld hl, wWindowTileBuffer + $113
    ld a, h
    ld [wArg1], a
    ld a, l
    ld [wArg2], a
    call DrawPageOfPagesAtArg1_Bank1E

Jump_01E_5556::
    call BGMapAddressAtScroll_Bank1E
    ld bc, $1409
    ld de, $01CC
    call DrawScreenBufferRect_Bank1E
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 25 of the `rst $00` table in SwapMonstersMenu_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg5, wScreenStep
SwapMonstersMenu_Case06_Case19::
Jump_01E_556A:: ; address name
    xor a, a
    ld [wArg5], a
    farcall DrawRecordListPageSpeciesNames
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 26 of the `rst $00` table in SwapMonstersMenu_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg1, wArg2, wScreenStep
SwapMonstersMenu_Case06_Case1A::
Jump_01E_557C:: ; address name
    ld de, Data_01F_4990
    ld hl, vTiles1 + $4E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    xor a, a
    ld [wArg1], a
    ld [wArg2], a
    farcall DrawRecordListPageMarks
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 27 of the `rst $00` table in SwapMonstersMenu_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wScreenStep
; writes: wMenuInputResult, wScreenByteB2, wScreenByteB3, wScreenStep, wScreenSubStep, wScreenState, wListCursor
SwapMonstersMenu_Case06_Case1B::
Jump_01E_559E:: ; address name
    ld a, $01
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_01E_55C3
    cp a, $FC
    jr z, Jump_01E_55C3
    cp a, $FD
    jr z, Jump_01E_55CC
    cp a, $FE
    jr z, Jump_01E_55CD
    cp a, $FF
    jr z, Jump_01E_55D9
    ret

Jump_01E_55C3::
    ld a, [wScreenStep]
    sub a, $04
    ld [wScreenStep], a
    ret

Jump_01E_55CC::
    ret

Jump_01E_55CD::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wListCursor], a
    ret

Jump_01E_55D9::
    ld a, $06
    ld [wScreenByteB2], a
    ld a, $1B
    ld [wScreenByteB3], a
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $0B
    ld [wScreenState], a
    call SaveAndHideSpriteState_Bank1E
    ret

; entry 29 of the `rst $00` table in SwapMonstersMenu_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
SwapMonstersMenu_Case06_Case1D::
Jump_01E_55F3:: ; address name
    ld de, $7BFF
    ld hl, wWindowTileBuffer + $6B
    ld bc, $0408
    call CopyRectTo20ByteRows_Bank1E
    call BGMapAddressAtScroll_Bank1E
    ld bc, $1409
    ld de, $01CC
    call DrawScreenBufferRect_Bank1E
    ld de, Data_01F_4290
    ld hl, vTiles1 + $4F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4230
    ld hl, vTiles1 + $4E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4120
    ld hl, vTiles1 + $750
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4170
    ld hl, vTiles1 + $760
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_41A0
    ld hl, vTiles1 + $770
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 30 of the `rst $00` table in SwapMonstersMenu_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wChoiceCursorF0
; writes: wArg1, wArg2, wArg3, wArg4, wScreenStep, wScriptCommandType, wScriptStartRequest
SwapMonstersMenu_Case06_Case1E::
Jump_01E_5654:: ; address name
    ld a, $9E
    ld [wArg1], a
    xor a, a
    ld [wArg2], a
    ld de, $6DC4
    ld a, d
    ld [wArg3], a
    ld a, e
    ld [wArg4], a
    farcall LoadTileListSixPerCall
    ld a, [wArg5]
    cp a, $FF
    ret nz
    ld a, [wChoiceCursorF0]
    ld b, $C3
    ld hl, CursorCellTable788A
    call StoreBAtWordTableEntry_Bank1E
    ld a, $02
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 7 of the `rst $00` table in SwapMonstersMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
SwapMonstersMenu_Case07::
Jump_01E_568E:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw SwapMonstersMenu_Case06_Case00
    dw SwapMonstersMenu_Case06_Case01
    dw SwapMonstersMenu_Case07_Case02
    dw SwapMonstersMenu_Case06_Case03
    dw SwapMonstersMenu_Case04_Case13
    dw SwapMonstersMenu_Case04_Case14
    dw SwapMonstersMenu_Case06_Case06
    dw CallFunc5C15InBank1F
    dw SwapMonstersMenu_Case06_Case08
    dw SwapMonstersMenu_Case04_Case02
    dw SwapMonstersMenu_Case04_Case19
    dw SwapMonstersMenu_Case04_Case04
    dw SwapMonstersMenu_Case06_Case0C
    dw SwapMonstersMenu_Case06_Case0D
    dw SwapMonstersMenu_Case04_Case07
    dw SwapMonstersMenu_Case04_Case08
    dw SwapMonstersMenu_Case04_Case13
    dw SwapMonstersMenu_Case04_Case20
    dw SwapMonstersMenu_Case04_Case21
    dw SwapMonstersMenu_Case06_Case13
    dw SwapMonstersMenu_Case04_Case0A
    dw SwapMonstersMenu_Case04_Case0B
    dw SwapMonstersMenu_Case04_Case0C
    dw SwapMonstersMenu_Case07_Case17
    dw SwapMonstersMenu_Case07_Case18
    dw SwapMonstersMenu_Case07_Case19
    dw SwapMonstersMenu_Case07_Case1A
    dw SwapMonstersMenu_Case04_Case06
    dw SwapMonstersMenu_Case04_Case07
    dw SwapMonstersMenu_Case04_Case08
    dw SwapMonstersMenu_Case04_Case13
    dw SwapMonstersMenu_Case04_Case20
    dw SwapMonstersMenu_Case04_Case21
    dw SwapMonstersMenu_Case04_Case30
    dw SwapMonstersMenu_Case06_Case15
    dw SwapMonstersMenu_Case06_Case16
    dw SwapMonstersMenu_Case06_Case17
    dw SwapMonstersMenu_Case06_Case18
    dw SwapMonstersMenu_Case06_Case19
    dw SwapMonstersMenu_Case06_Case1A
    dw SwapMonstersMenu_Case07_Case28
    dw SwapMonstersMenu_Case06_Case0D
    dw SwapMonstersMenu_Case06_Case1D
    dw SwapMonstersMenu_Case06_Case1E
    dw SwapMonstersMenu_Case04_Case0A
    dw SwapMonstersMenu_Case04_Case0B
    dw SwapMonstersMenu_Case04_Case0C
    dw SwapMonstersMenu_Case07_Case2F
    dw SwapMonstersMenu_Case07_Case30
    dw SwapMonstersMenu_Case07_Case31
    dw SwapMonstersMenu_Case07_Case32
    dw SwapMonstersMenu_Case07_Case33
    dw SwapMonstersMenu_Case04_Case06
    dw SwapMonstersMenu_Case07_Case35
    dw SwapMonstersMenu_Case07_Case36
    dw SwapMonstersMenu_Case07_Case37
    dw SwapMonstersMenu_Case04_Case08
    dw SwapMonstersMenu_Case04_Case21
    dw SwapMonstersMenu_Case07_Case3A

; entry 2 of the `rst $00` table in SwapMonstersMenu_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wChoiceCursorF0, wListCount, wScreenStep, wRecordsFlagged, wScreenState
; writes: wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wScreenStep, wChoiceCursorF0, wCursorBlinkB8
; points at: wTextWindowTileLo
SwapMonstersMenu_Case07_Case02::
Jump_01E_5708:: ; address name
    farcall SwapMonstersMenu_Shared01
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FD
    ret z
    cp a, $FE
    jp z, Jump_01E_5145
    cp a, $FF
    jr z, Jump_01E_5720
    ret

Jump_01E_5720::
    ld a, [wChoiceCursorF0]
    and a, a
    jp nz, Jump_01E_5199
    farcall ListRecordsInUseWithByte6EClear
    ld a, [wListCount]
    cp a, $02
    jr nc, Jump_01E_5743
    ld a, $04
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01E_5743::
    ld a, [wScreenStep]
    add a, $02
    ld [wScreenStep], a
    xor a, a
    ld [wTwoChoiceCursor], a
    call BlankTwoTableEntries788A
    ld a, [wChoiceCursorF0]
    ld b, $BC
    ld hl, CursorCellTable788A
    call StoreBAtWordTableEntry_Bank1E
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

; entry 23 of the `rst $00` table in SwapMonstersMenu_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wListCount, wDigits, wRecordsFlagged, wScreenStep
; writes: wScreenStep
SwapMonstersMenu_Case07_Case17::
Jump_01E_5774:: ; address name
    ld de, $7BBE
    ld hl, wWindowTileBuffer + $10B
    ld bc, $0D05
    call CopyRectTo20ByteRows_Bank1E
    ld de, $57DC
    ld hl, wWindowTileBuffer + $10B
    ld bc, $0D01
    call CopyRectTo20ByteRows_Bank1E
    ld de, $57E9
    ld hl, wWindowTileBuffer + $11F
    ld bc, $0102
    call CopyRectTo20ByteRows_Bank1E
    farcall ListRecordsInUseWithByte6EClear
    ld a, [wListCount]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call BlankLeadingZeroDigits_F
    ld hl, wWindowTileBuffer + $129
    ld a, [wDigits + $1]
    add a, $E0
    ld [hl+], a
    ld a, [wDigits + $2]
    add a, $E0
    ld [hl], a
    ld a, [wRecordsFlagged]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call BlankLeadingZeroDigits_F
    ld hl, wWindowTileBuffer + $151
    ld a, [wDigits + $1]
    add a, $E0
    ld [hl+], a
    ld a, [wDigits + $2]
    add a, $E0
    ld [hl], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 13 x 1 tiles, one row per line
TileRect_1E_57DC::
Data_01E_57DC:: ; address name
    db $B7, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 0

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 1 x 2 tiles, one row per line
TileRect_1E_57E9::
Data_01E_57E9:: ; address name
    db $B7 ; id 0
    db $B5 ; id 1

; entry 24 of the `rst $00` table in SwapMonstersMenu_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wListCursor, wChoiceCursorF0
; writes: wScreenStep, wScriptCommandType, wScriptStartRequest
SwapMonstersMenu_Case07_Case18::
Jump_01E_57EB:: ; address name
    ld a, [wListCursor]
    ld b, $C3
    ld hl, CursorCellTable7880
    call StoreBAtWordTableEntry_Bank1E
    ld a, [wChoiceCursorF0]
    ld b, $BC
    ld hl, CursorCellTable788A
    call StoreBAtWordTableEntry_Bank1E
    call BGMapAddressAtScroll_Bank1E
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank1E
    ld a, $0C
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 25 of the `rst $00` table in SwapMonstersMenu_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: rRAMG2, rRAMB, wNameGlyphBuf, wScreenStep, wScriptCommandType, wScriptStartRequest
; points at: wNameGlyphBuf, wTextBuf0, wTextWindowTileLo
SwapMonstersMenu_Case07_Case19::
Jump_01E_581C:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    call GetListEntriesCell5Address
    ld a, [hl]
    ld c, $01
    call CopyRecordNameToNameGlyphBuf
    ld a, $F0
    ld [wNameGlyphBuf + $A], a
    ld hl, wNameGlyphBuf
    ld de, wTextBuf0
    ld c, $00

Jump_01E_583B::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_01E_5849
    ld [de], a
    inc de
    inc hl
    inc c
    ld a, c
    cp a, $0A
    jr c, Jump_01E_583B

Jump_01E_5849::
    ld a, $F0
    ld [de], a
    xor a, a
    ld [rRAMG2], a
    ld a, [wScreenStep]
    inc a
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

; entry 26 of the `rst $00` table in SwapMonstersMenu_Case07
; no direct call (reached through a table, a jump or a vector)
; writes: rRAMG2, rRAMB, wArg1, wArg2, wOBJPaletteUploadRequest, wListCursor, wChoiceCursor, wListPageIndex, ...
SwapMonstersMenu_Case07_Case1A::
Jump_01E_586E:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    call GetListEntriesCell5Address
    ld a, [hl]
    ld [wArg1], a
    xor a, a
    ld [rRAMG2], a
    ld [wArg2], a
    farcall DeleteSRAMRecordAndCompact
    farcall ListPartyRecordsWithState2ToListEntries
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    call SwapMonstersMenu_Shared03
    xor a, a
    ld [wListCursor], a
    ld [wChoiceCursor], a
    ld [wListPageIndex], a
    ld [wListCursorAux], a
    ld [wCursorBlinkAE], a
    ret

; entry 40 of the `rst $00` table in SwapMonstersMenu_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wScreenStep, wListCursor
; writes: wMenuInputResult, wTwoChoiceCursor, wScreenStep, wScriptCommandType, wScriptStartRequest, wListCursor
; points at: wTextWindowTileLo
SwapMonstersMenu_Case07_Case28::
Jump_01E_58B0:: ; address name
    ld a, $01
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_01E_58D5
    cp a, $FC
    jr z, Jump_01E_58D5
    cp a, $FD
    jr z, Jump_01E_58DE
    cp a, $FE
    jr z, Jump_01E_58DF
    cp a, $FF
    jr z, Jump_01E_58FD
    ret

Jump_01E_58D5::
    ld a, [wScreenStep]
    sub a, $04
    ld [wScreenStep], a
    ret

Jump_01E_58DE::
    ret

Jump_01E_58DF::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wListCursor], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ret

Jump_01E_58FD::
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    add a, $04
    ld [wScreenStep], a
    ld a, [wListCursor]
    ld b, $BC
    ld hl, $788E
    call StoreBAtWordTableEntry_Bank1E
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

; entry 47 of the `rst $00` table in SwapMonstersMenu_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wListCount, wDigits, wRecordsFlagged, wScreenStep
; writes: wScreenStep
SwapMonstersMenu_Case07_Case2F::
Jump_01E_592B:: ; address name
    ld de, $7BBE
    ld hl, wWindowTileBuffer + $10B
    ld bc, $0D05
    call CopyRectTo20ByteRows_Bank1E
    ld de, $5987
    ld hl, wWindowTileBuffer + $10B
    ld bc, $0D01
    call CopyRectTo20ByteRows_Bank1E
    farcall ListRecordsInUseWithByte6EClear
    ld a, [wListCount]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call BlankLeadingZeroDigits_F
    ld hl, wWindowTileBuffer + $129
    ld a, [wDigits + $1]
    add a, $E0
    ld [hl+], a
    ld a, [wDigits + $2]
    add a, $E0
    ld [hl], a
    ld a, [wRecordsFlagged]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call BlankLeadingZeroDigits_F
    ld hl, wWindowTileBuffer + $151
    ld a, [wDigits + $1]
    add a, $E0
    ld [hl+], a
    ld a, [wDigits + $2]
    add a, $E0
    ld [hl], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 13 x 1 tiles, one row per line
TileRect_1E_5987::
Data_01E_5987:: ; address name
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 0

; entry 48 of the `rst $00` table in SwapMonstersMenu_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wListPages, wScreenStep
; writes: wArg1, wArg2, wScreenStep
SwapMonstersMenu_Case07_Case30::
Jump_01E_5994:: ; address name
    farcall ListRecordsInUseWithByte6ESet
    call ClampRecordListPageCursor4
    ld a, [wListPages]
    cp a, $02
    jr c, Jump_01E_59CC
    ld de, $010E
    call DrawC5BEC6AtScrollOffsetDE_Bank1E
    ld hl, wWindowTileBuffer + $112
    call StoreC5BEC6AtHLStride2_Bank1E
    ld de, $010F
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    call DrawPageOfPagesAtScrollOffset
    ld hl, wWindowTileBuffer + $113
    ld a, h
    ld [wArg1], a
    ld a, l
    ld [wArg2], a
    call DrawPageOfPagesAtArg1_Bank1E

Jump_01E_59CC::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 49 of the `rst $00` table in SwapMonstersMenu_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wListCursor, wChoiceCursorF0
; writes: wScreenStep, wScriptCommandType, wScriptStartRequest
SwapMonstersMenu_Case07_Case31::
Jump_01E_59D4:: ; address name
    ld a, [wListCursor]
    ld b, $C3
    ld hl, $788E
    call StoreBAtWordTableEntry_Bank1E
    ld a, [wChoiceCursorF0]
    ld b, $BC
    ld hl, CursorCellTable788A
    call StoreBAtWordTableEntry_Bank1E
    call BGMapAddressAtScroll_Bank1E
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank1E
    ld a, $28
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 50 of the `rst $00` table in SwapMonstersMenu_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep, wScriptCommandType, wScriptStartRequest
SwapMonstersMenu_Case07_Case32::
Jump_01E_5A05:: ; address name
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 51 of the `rst $00` table in SwapMonstersMenu_Case07
; no direct call (reached through a table, a jump or a vector)
; writes: rRAMG2, rRAMB, wArg1, wArg2, wListCursor, wChoiceCursor, wListPageIndex, wListCursorAux, ...
SwapMonstersMenu_Case07_Case33::
Jump_01E_5A16:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    call GetListEntriesCell4Address
    ld a, [hl]
    ld [wArg1], a
    xor a, a
    ld [rRAMG2], a
    ld [wArg2], a
    farcall DeleteSRAMRecordAndCompact
    farcall ListPartyRecordsWithState2ToListEntries
    call SwapMonstersMenu_Shared03
    xor a, a
    ld [wListCursor], a
    ld [wChoiceCursor], a
    ld [wListPageIndex], a
    ld [wListCursorAux], a
    ld [wCursorBlinkAE], a
    ret

; only called from routines of SwapMonstersMenu (E-0098)
; 2 call sites from 2 routines (e.g. SwapMonstersMenu_Case07_Case33, SwapMonstersMenu_Case07_Case1A)
; reads: wListCursor, wScreenStep
; writes: wArg1, wArg2, wScreenStep
SwapMonstersMenu_Shared03::
Func_01E_5A4D:: ; address name
    ld de, $5A80
    ld hl, wWindowTileBuffer + $110
    ld bc, $0801
    call CopyRectTo20ByteRows_Bank1E
    ld c, $05
    ld hl, $0287
    ld de, $00BB
    xor a, a
    ld [wArg1], a
    ld a, $0D
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_1E
    ld a, [wListCursor]
    ld b, $C3
    ld hl, CursorCellTable7880
    call StoreBAtWordTableEntry_Bank1E
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 1 tiles, one row per line
TileRect_1E_5A80::
Data_01E_5A80:: ; address name
    db $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 0

; entry 54 of the `rst $00` table in SwapMonstersMenu_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wScreenStep
; writes: wArg1, wArg2, wArg3, wArg4, wScreenStep
SwapMonstersMenu_Case07_Case36::
Jump_01E_5A88:: ; address name
    ld a, $9E
    ld [wArg1], a
    xor a, a
    ld [wArg2], a
    ld de, $6DC4
    ld a, d
    ld [wArg3], a
    ld a, e
    ld [wArg4], a
    farcall LoadTileListSixPerCall
    ld a, [wArg5]
    cp a, $FF
    ret nz
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 55 of the `rst $00` table in SwapMonstersMenu_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
SwapMonstersMenu_Case07_Case37::
Jump_01E_5AB0:: ; address name
    ld de, Data_01F_4370
    ld hl, vTiles1 + $5F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4290
    ld hl, vTiles1 + $4F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4230
    ld hl, vTiles1 + $4E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4120
    ld hl, vTiles1 + $750
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4170
    ld hl, vTiles1 + $760
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_41A0
    ld hl, vTiles1 + $770
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 53 of the `rst $00` table in SwapMonstersMenu_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
SwapMonstersMenu_Case07_Case35::
Jump_01E_5B06:: ; address name
    ld de, $7BFF
    ld hl, wWindowTileBuffer + $6B
    ld bc, $0408
    call CopyRectTo20ByteRows_Bank1E
    ld de, $7C1F
    ld hl, wWindowTileBuffer + $10B
    ld bc, $0403
    call CopyRectTo20ByteRows_Bank1E
    call BGMapAddressAtScroll_Bank1E
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank1E
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 58 of the `rst $00` table in SwapMonstersMenu_Case07
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wScreenState, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
SwapMonstersMenu_Case07_Case3A::
Jump_01E_5B32:: ; address name
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

; entry 9 of the `rst $00` table in SwapMonstersMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
SwapMonstersMenu_Case09::
Jump_01E_5B50:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw ClearBGMapAtScrollAndResetScroll
    dw SwapMonstersMenu_Case09_Case01
    dw SwapMonstersMenu_Case09_Case02
    dw SwapMonstersMenu_Case09_Case03
    dw DrawListEntriesCell5RecordDetails
    dw SwapMonstersMenu_Case09_Case05
    dw SwapMonstersMenu_Case09_Case06
    dw ClearBGMapAtScrollAndResetScroll
    dw SwapMonstersMenu_Case09_Case08
    dw SwapMonstersMenu_Case09_Case09
    dw ListRecordsAndDrawListEntriesCell5Panel
    dw SwapMonstersMenu_Case09_Case0B
    dw SwapMonstersMenu_Case09_Case0C
    dw SwapMonstersMenu_Case09_Case0D
    dw SwapMonstersMenu_Case09_Case0E
    dw SwapMonstersMenu_Case09_Case0B
    dw SwapMonstersMenu_Case09_Case0C
    dw SwapMonstersMenu_Case09_Case11
    dw SwapMonstersMenu_Case09_Case12
    dw SwapMonstersMenu_Case09_Case13
    dw SwapMonstersMenu_Case09_Case14
    dw SwapMonstersMenu_Case09_Case15
    dw SwapMonstersMenu_Case09_Case16
    dw SwapMonstersMenu_Case09_Case17
    dw SwapMonstersMenu_Case09_Case18
    dw SwapMonstersMenu_Case09_Case19
    dw SwapMonstersMenu_Case09_Case1A
    dw SwapMonstersMenu_Case09_Case1B
    dw SwapMonstersMenu_Case09_Case1C
    dw SwapMonstersMenu_Case09_Case1D
    dw SwapMonstersMenu_Case09_Case1E
    dw SwapMonstersMenu_Case09_Case1F
    dw SwapMonstersMenu_Case09_Case20

; entry 3 of the `rst $00` table in SwapMonstersMenu_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: wListPages, wScreenStep
; writes: wArg3, wArg4, wArg7, wArg1, wArg2, wScreenStep
SwapMonstersMenu_Case09_Case03::
Jump_01E_5B96:: ; address name
    call BGMapAddressAtScroll_Bank1E
    ld de, TileRect_1F_6717
    ld a, $14
    ld [wArg3], a
    ld a, $12
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    ld a, [wListPages]
    cp a, $02
    jr c, Jump_01E_5BC8
    ld de, $0142
    call DrawC5BEC6AtScrollOffsetDE_Bank1E
    ld de, $0143
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    call DrawPageOfPagesAtScrollOffset

Jump_01E_5BC8::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 6 of the `rst $00` table in SwapMonstersMenu_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
SwapMonstersMenu_Case09_Case06::
Jump_01E_5BD0:: ; address name
    ld a, [wScreenSubStep]
    rst $00
    dw SwapMonstersMenu_Case09_Case06_Case00
    dw ClearTileAreasAndIncScreenSubStep
    dw RedrawRecordListAndNextStep
    dw SwapMonstersMenu_Case09_Case06_Case03

; entry 0 of the `rst $00` table in SwapMonstersMenu_Case09_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wScreenStep, wScreenSubStep
; writes: wMenuInputResult, wArg3, wArg4, wArg7, wScreenStep, wScreenSubStep
SwapMonstersMenu_Case09_Case06_Case00::
Jump_01E_5BDC:: ; address name
    xor a, a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_01E_5C00
    cp a, $FC
    jr z, Jump_01E_5C00
    cp a, $FD
    jr z, Jump_01E_5C08
    cp a, $FE
    jr z, Jump_01E_5C0E
    cp a, $FF
    jr z, Jump_01E_5C16
    ret

Jump_01E_5C00::
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

Jump_01E_5C08::
    ld a, $04
    ld [wScreenStep], a
    ret

Jump_01E_5C0E::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

Jump_01E_5C16::
    call BGMapAddressAtScroll_Bank1E
    ld de, $0161
    add hl, de
    ld de, TileRect_1F_651B
    ld a, $06
    ld [wArg3], a
    ld a, $06
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    ld a, $0E
    ld [wScreenStep], a
    ret

; clears tile areas with FillTilesBxC (12 x 1 at vTiles1 + $240, 15 x 1 at + $500, 5 x 1 at + $700, 2 x 1 at + $4E0), then wD782 += 1 (E-0118)
; 1 call site from 1 routine (e.g. SwapMonstersMenu_Case0E_Case01)
; reads: wScreenSubStep
; writes: wScreenSubStep
ClearTileAreasAndIncScreenSubStep::
Func_01E_5C37:: ; address name
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
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; runs Func_01E_7163 and Func_01F_5C15, wD781 -= 1 and wD782 += 1 (E-0122)
; 1 call site from 1 routine (e.g. SwapMonstersMenu_Case0E_Case01)
; reads: wScreenStep, wScreenSubStep
; writes: wScreenStep, wScreenSubStep
RedrawRecordListAndNextStep::
Func_01E_5C63:: ; address name
    call ClampRecordListPageCursor5
    call CallFunc5C15InBank1F
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 3 of the `rst $00` table in SwapMonstersMenu_Case09_Case06
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wScreenSubStep
SwapMonstersMenu_Case09_Case06_Case03::
Jump_01E_5C78:: ; address name
    call ListRecordsState1ThenContinue
    ld a, $04
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    ret

; entry 13 of the `rst $00` table in SwapMonstersMenu_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: wDataBank, wScreenByteB2, wScreenByteB3, wListCursor, wScreenState, wScriptCommandType
; writes: wOBJPaletteUploadRequest, hSpriteHideTile, wScreenSubStep, wScreenState, wScreenStep, wScriptCommandType, wScriptStartRequest
; points at: wTextWindowTileLo
SwapMonstersMenu_Case09_Case0D::
Jump_01E_5C85:: ; address name
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ld c, $05
    ld hl, CursorCellTable7880
    call EraseCEntriesOfWordTable_Bank1E
    ld a, [wDataBank]
    cp a, $1F
    jr z, Jump_01E_5CB3
    ld a, [wScreenByteB2]
    cp a, $04
    jr z, Jump_01E_5CCA
    cp a, $05
    jr nz, Jump_01E_5CD5
    ld a, [wScreenByteB3]
    cp a, $2F
    jr c, Jump_01E_5CD5
    jr Jump_01E_5CCA

Jump_01E_5CB3::
    ld a, [wScreenState]
    cp a, $0A
    jr nz, Jump_01E_5CCA
    ld a, [wScreenByteB2]
    cp a, $06
    jr z, Jump_01E_5CD5
    ld a, [wScriptCommandType]
    cp a, $E8
    jr z, Jump_01E_5CCA
    jr Jump_01E_5CD5

Jump_01E_5CCA::
    ld a, [wListCursor]
    ld b, $BC
    ld hl, CursorCellTable7880
    call StoreBAtWordTableEntry_Bank1E

Jump_01E_5CD5::
    call BGMapAddressAtScroll_Bank1E
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank1E
    call BGMapAddressAtScroll_Bank1E
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call DrawScreenBufferRect_Bank1E
    call RestoreSpriteStateFromSavedFieldDrawFlags
    ld a, $70
    ldh [hSpriteHideTile], a
    xor a, a
    ld [wScreenSubStep], a
    ld a, [wScreenByteB2]
    ld [wScreenState], a
    ld a, [wScreenByteB3]
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

; entry 21 of the `rst $00` table in SwapMonstersMenu_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
SwapMonstersMenu_Case09_Case15::
Jump_01E_5D1F:: ; address name
    ld a, [wScreenSubStep]
    rst $00
    dw SwapMonstersMenu_Case09_Case15_Case00
    dw ClearTileAreasAndIncScreenSubStep
    dw RedrawRecordListAndNextStep
    dw SwapMonstersMenu_Case09_Case15_Case03

; entry 0 of the `rst $00` table in SwapMonstersMenu_Case09_Case15
; no direct call (reached through a table, a jump or a vector)
; reads: wGameMode, wMenuInputResult, wScreenStep, wScreenSubStep
; writes: wMenuInputResult, hSpriteHideTile, wScreenStep, wArg3, wArg4, wArg7, wScreenSubStep
SwapMonstersMenu_Case09_Case15_Case00::
Jump_01E_5D2B:: ; address name
    ld a, [wGameMode]
    cp a, $05
    jr z, Jump_01E_5D38
    farcall DrawListEntriesCell5SpeciesSprite

Jump_01E_5D38::
    xor a, a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_01E_5D5C
    cp a, $FC
    jr z, Jump_01E_5D5C
    cp a, $FD
    jr z, Jump_01E_5D67
    cp a, $FE
    jr z, Jump_01E_5D7E
    cp a, $FF
    jr z, Jump_01E_5D72
    ret

Jump_01E_5D5C::
    xor a, a
    ldh [hSpriteHideTile], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

Jump_01E_5D67::
    xor a, a
    ldh [hSpriteHideTile], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

Jump_01E_5D72::
    xor a, a
    ldh [hSpriteHideTile], a
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    ret

Jump_01E_5D7E::
    xor a, a
    ldh [hSpriteHideTile], a
    call BGMapAddressAtScroll_Bank1E
    ld de, $0068
    add hl, de
    ld de, TileRect_1F_662B
    ld a, $0C
    ld [wArg3], a
    ld a, $0F
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    call BGMapAddressAtScroll_Bank1E
    ld de, $0160
    add hl, de
    ld de, TileRect_1F_653F
    ld a, $08
    ld [wArg3], a
    ld a, $07
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    ld a, $04
    ld [wScreenStep], a
    ret

; entry 3 of the `rst $00` table in SwapMonstersMenu_Case09_Case15
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenSubStep
SwapMonstersMenu_Case09_Case15_Case03::
Jump_01E_5DBD:: ; address name
    call ListRecordsState1ThenContinue
    xor a, a
    ld [wScreenSubStep], a
    ret

; entry 27 of the `rst $00` table in SwapMonstersMenu_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
SwapMonstersMenu_Case09_Case1B::
Jump_01E_5DC5:: ; address name
    ld a, [wScreenSubStep]
    rst $00
    dw SwapMonstersMenu_Case09_Case1B_Case00
    dw ClearTileAreasAndIncScreenSubStep
    dw RedrawRecordListAndNextStep
    dw SwapMonstersMenu_Case09_Case1B_Case03

; entry 0 of the `rst $00` table in SwapMonstersMenu_Case09_Case1B
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wScreenStep, wScreenSubStep
; writes: wMenuInputResult, wArg3, wArg4, wArg7, wScreenStep, wScreenSubStep
; points at: wTextWindowTileLo
SwapMonstersMenu_Case09_Case1B_Case00::
Jump_01E_5DD1:: ; address name
    xor a, a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_01E_5DF5
    cp a, $FC
    jr z, Jump_01E_5DF5
    cp a, $FD
    jr z, Jump_01E_5DFD
    cp a, $FE
    jr z, Jump_01E_5E06
    cp a, $FF
    jr z, Jump_01E_5E17
    ret

Jump_01E_5DF5::
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

Jump_01E_5DFD::
    ld a, [wScreenStep]
    sub a, $02
    ld [wScreenStep], a
    ret

Jump_01E_5E06::
    ld hl, vTiles2 + $200
    ld bc, $1504
    call FillTilesBxC
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

Jump_01E_5E17::
    ld hl, vTiles2 + $730
    ld de, Data_01F_42D0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    farcall UploadTilesFromData6D20
    call BGMapAddressAtScroll_Bank1E
    ld de, $0160
    add hl, de
    ld de, TileRect_1F_6E47
    ld a, $08
    ld [wArg3], a
    ld a, $07
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    ld hl, vTiles2 + $6C0
    ld bc, $0201
    call FillTilesBxC
    call BGMapAddressAtScroll_Bank1E
    ld de, $0008
    add hl, de
    ld de, TileRect_1F_6D6F
    ld a, $0C
    ld [wArg3], a
    ld a, $12
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    ld hl, vTiles2 + $200
    ld bc, $0805
    call FillTilesBxC
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, [wScreenStep]
    add a, $03
    ld [wScreenStep], a
    ret

; entry 3 of the `rst $00` table in SwapMonstersMenu_Case09_Case1B
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep, wScreenSubStep
SwapMonstersMenu_Case09_Case1B_Case03::
Jump_01E_5E88:: ; address name
    call ListRecordsState1ThenContinue
    ld a, [wScreenStep]
    sub a, $04
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    ret

; entry 23 of the `rst $00` table in SwapMonstersMenu_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg3, wArg4, wArg7, wScreenStep
SwapMonstersMenu_Case09_Case17::
Jump_01E_5E98:: ; address name
    call BGMapAddressAtScroll_Bank1E
    ld de, $0008
    add hl, de
    ld de, TileRect_1F_6B4F
    ld a, $0C
    ld [wArg3], a
    ld a, $12
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    call BGMapAddressAtScroll_Bank1E
    ld de, $0160
    add hl, de
    ld de, TileRect_1F_6C27
    ld a, $08
    ld [wArg3], a
    ld a, $07
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 24 of the `rst $00` table in SwapMonstersMenu_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg3, wArg4, wArg7, wScreenStep
SwapMonstersMenu_Case09_Case18::
Jump_01E_5ED6:: ; address name
    ld hl, vTiles2 + $200
    ld bc, $1504
    call FillTilesBxC
    call BGMapAddressAtScroll_Bank1E
    ld de, $0008
    add hl, de
    ld de, TileRect_1F_6C5F
    ld a, $0C
    ld [wArg3], a
    ld a, $12
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    call BGMapAddressAtScroll_Bank1E
    ld de, $0160
    add hl, de
    ld de, TileRect_1F_6D37
    ld a, $08
    ld [wArg3], a
    ld a, $07
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 32 of the `rst $00` table in SwapMonstersMenu_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
SwapMonstersMenu_Case09_Case20::
Jump_01E_5F1D:: ; address name
    ld a, [wScreenSubStep]
    rst $00
    dw SwapMonstersMenu_Case09_Case20_Case00
    dw ClearTileAreasAndIncScreenSubStep
    dw RedrawRecordListAndNextStep
    dw SwapMonstersMenu_Case09_Case20_Case03

; entry 0 of the `rst $00` table in SwapMonstersMenu_Case09_Case20
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wGameMode, wScreenStep, wScreenSubStep
; writes: wMenuInputResult, hSpriteHideTile, wScreenStep, wScreenSubStep
; points at: wTextWindowTileLo
SwapMonstersMenu_Case09_Case20_Case00::
Jump_01E_5F29:: ; address name
    xor a, a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a, a
    jr z, Jump_01E_5F4D
    cp a, $FB
    jr z, Jump_01E_5F5A
    cp a, $FC
    jr z, Jump_01E_5F5A
    cp a, $FD
    jr z, Jump_01E_5F65
    cp a, $FE
    jr z, Jump_01E_5F87
    cp a, $FF
    jr z, Jump_01E_5F90

Jump_01E_5F4D::
    ld a, [wGameMode]
    cp a, $05
    ret z
    farcall CallFunc6899PreservingArg1AndTemp0
    ret

Jump_01E_5F5A::
    xor a, a
    ldh [hSpriteHideTile], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

Jump_01E_5F65::
    xor a, a
    ldh [hSpriteHideTile], a
    ld a, [wScreenStep]
    dec a
    dec a
    ld [wScreenStep], a
    ld hl, vTiles2 + $200
    ld bc, $0805
    call FillTilesBxC
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ret

Jump_01E_5F87::
    xor a, a
    ldh [hSpriteHideTile], a
    ld a, $17
    ld [wScreenStep], a
    ret

Jump_01E_5F90::
    xor a, a
    ldh [hSpriteHideTile], a
    ld a, $07
    ld [wScreenStep], a
    ret

; entry 3 of the `rst $00` table in SwapMonstersMenu_Case09_Case20
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep, wScreenSubStep, hSpriteHideTile
; points at: wTextWindowTileLo
SwapMonstersMenu_Case09_Case20_Case03::
Jump_01E_5F99:: ; address name
    call ListRecordsState1ThenContinue
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    jp Jump_01E_5F65

; entry 14 of the `rst $00` table in SwapMonstersMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
SwapMonstersMenu_Case0E::
Jump_01E_5FAA:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw SwapMonstersMenu_Case0E_Case00
    dw SwapMonstersMenu_Case0E_Case01
    dw SwapMonstersMenu_Case09_Case02
    dw SwapMonstersMenu_Case0E_Case03
    dw SwapMonstersMenu_Case0E_Case04
    dw SwapMonstersMenu_Case09_Case05
    dw SwapMonstersMenu_Case0E_Case06
    dw SwapMonstersMenu_Case0E_Case07
    dw SwapMonstersMenu_Case0E_Case08
    dw SwapMonstersMenu_Case0E_Case08
    dw SwapMonstersMenu_Case0E_Case0A
    dw SwapMonstersMenu_Case09_Case0B
    dw SwapMonstersMenu_Case09_Case0C
    dw SwapMonstersMenu_Case09_Case0D
    dw SwapMonstersMenu_Case09_Case0E
    dw SwapMonstersMenu_Case09_Case0B
    dw SwapMonstersMenu_Case09_Case0C
    dw SwapMonstersMenu_Case09_Case11
    dw SwapMonstersMenu_Case09_Case12
    dw SwapMonstersMenu_Case09_Case13
    dw SwapMonstersMenu_Case09_Case14
    dw SwapMonstersMenu_Case0E_Case15
    dw SwapMonstersMenu_Case09_Case16
    dw SwapMonstersMenu_Case09_Case17
    dw SwapMonstersMenu_Case09_Case18
    dw SwapMonstersMenu_Case09_Case19
    dw SwapMonstersMenu_Case09_Case1A
    dw SwapMonstersMenu_Case0E_Case1B
    dw SwapMonstersMenu_Case09_Case1C
    dw SwapMonstersMenu_Case09_Case1D
    dw SwapMonstersMenu_Case09_Case1E
    dw SwapMonstersMenu_Case09_Case1F
    dw SwapMonstersMenu_Case0E_Case20

; entry 3 of the `rst $00` table in SwapMonstersMenu_Case0E
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg3, wArg4, wArg7, wScreenStep
SwapMonstersMenu_Case0E_Case03::
Jump_01E_5FF0:: ; address name
    call BGMapAddressAtScroll_Bank1E
    ld de, TileRect_1F_69E7
    ld a, $14
    ld [wArg3], a
    ld a, $12
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 12 of the `rst $00` table in SwapMonstersMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
SwapMonstersMenu_Case0C::
Jump_01E_600F:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw SwapMonstersMenu_Case0E_Case00
    dw SwapMonstersMenu_Case0E_Case01
    dw SwapMonstersMenu_Case09_Case02
    dw SwapMonstersMenu_Case09_Case03
    dw SwapMonstersMenu_Case0E_Case04
    dw SwapMonstersMenu_Case09_Case05
    dw SwapMonstersMenu_Case0E_Case06
    dw SwapMonstersMenu_Case0E_Case07
    dw SwapMonstersMenu_Case0E_Case08
    dw SwapMonstersMenu_Case0E_Case08
    dw SwapMonstersMenu_Case0E_Case0A
    dw SwapMonstersMenu_Case09_Case0B
    dw SwapMonstersMenu_Case09_Case0C
    dw SwapMonstersMenu_Case09_Case0D
    dw SwapMonstersMenu_Case09_Case0E
    dw SwapMonstersMenu_Case09_Case0B
    dw SwapMonstersMenu_Case09_Case0C
    dw SwapMonstersMenu_Case09_Case11
    dw SwapMonstersMenu_Case09_Case12
    dw SwapMonstersMenu_Case09_Case13
    dw SwapMonstersMenu_Case09_Case14
    dw SwapMonstersMenu_Case0E_Case15
    dw SwapMonstersMenu_Case09_Case16
    dw SwapMonstersMenu_Case09_Case17
    dw SwapMonstersMenu_Case09_Case18
    dw SwapMonstersMenu_Case09_Case19
    dw SwapMonstersMenu_Case09_Case1A
    dw SwapMonstersMenu_Case0E_Case1B
    dw SwapMonstersMenu_Case09_Case1C
    dw SwapMonstersMenu_Case09_Case1D
    dw SwapMonstersMenu_Case09_Case1E
    dw SwapMonstersMenu_Case09_Case1F
    dw SwapMonstersMenu_Case0E_Case20

; entry 1 of the `rst $00` table in SwapMonstersMenu_Case0E
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenSubStep, wScreenStep
SwapMonstersMenu_Case0E_Case01::
Jump_01E_6055:: ; address name
    ld hl, GlyphCopyDestList4
    ld de, GlyphCopySrcList4
    call SwapMonstersMenu_Shared05
    call SwapMonstersMenu_Shared04
    call ClearTileAreasAndIncScreenSubStep
    call RedrawRecordListAndNextStep
    call SwapMonstersMenu_Shared02
    xor a, a
    ld [wScreenSubStep], a
    ld a, $02
    ld [wScreenStep], a
    ret

; only called from routines of SwapMonstersMenu (E-0098)
; 2 call sites from 2 routines (e.g. SwapMonstersMenu_Case0D_Case01, SwapMonstersMenu_Case0E_Case01)
SwapMonstersMenu_Shared04::
Func_01E_6074:: ; address name
    ld c, $00
    ld b, $10

Jump_01E_6078::
    push bc
    ld a, c
    ld de, $60B1
    add a, e
    ld e, a
    jr nc, Jump_01E_6082
    inc d

Jump_01E_6082::
    ld a, [de]
    swap a
    ld d, a
    and a, $F0
    ld e, a
    ld a, d
    and a, $0F
    ld d, a
    ld hl, $4010
    add hl, de
    ld e, l
    ld d, h
    push de
    ld a, c
    add a, a
    ld de, $60C1
    add a, e
    ld e, a
    jr nc, Jump_01E_609E
    inc d

Jump_01E_609E::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    pop de
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    pop bc
    inc c
    dec b
    jr nz, Jump_01E_6078
    ret
    db $A3, $54, $44, $11, $16, $19, $48, $24, $A6, $12, $31, $29, $32, $18, $14, $A3
    db $D0, $8E, $E0, $8E, $F0, $8E, $50, $8F, $60, $8F, $70, $8F, $D0, $8F, $E0, $8F
    db $F0, $8F, $00, $97, $10, $97, $20, $97, $30, $97, $40, $97, $50, $97, $60, $97

; entry 7 of the `rst $00` table in SwapMonstersMenu_Case0E
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenSubStep
SwapMonstersMenu_Case0E_Case07::
Jump_01E_60E1:: ; address name
    call ClearBGMapAtScrollAndResetScroll
    call SwapMonstersMenu_Case0E_Case07_Sub01
    xor a, a
    ld [wScreenSubStep], a
    ret

; entry 8 of the `rst $00` table in SwapMonstersMenu_Case0E
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
SwapMonstersMenu_Case0E_Case08::
Jump_01E_60EC:: ; address name
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 10 of the `rst $00` table in SwapMonstersMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
SwapMonstersMenu_Case0A::
Jump_01E_60F4:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw SwapMonstersMenu_Case0E_Case00
    dw SwapMonstersMenu_Case09_Case01
    dw SwapMonstersMenu_Case09_Case02
    dw SwapMonstersMenu_Case09_Case03
    dw SwapMonstersMenu_Case0E_Case04
    dw SwapMonstersMenu_Case09_Case05
    dw SwapMonstersMenu_Case0E_Case06
    dw ClearBGMapAtScrollAndResetScroll
    dw SwapMonstersMenu_Case09_Case08
    dw SwapMonstersMenu_Case09_Case09
    dw SwapMonstersMenu_Case0A_Case0A
    dw SwapMonstersMenu_Case09_Case0B
    dw SwapMonstersMenu_Case09_Case0C
    dw SwapMonstersMenu_Case09_Case0D
    dw SwapMonstersMenu_Case09_Case0E
    dw SwapMonstersMenu_Case09_Case0B
    dw SwapMonstersMenu_Case09_Case0C
    dw SwapMonstersMenu_Case09_Case11
    dw SwapMonstersMenu_Case09_Case12
    dw SwapMonstersMenu_Case09_Case13
    dw SwapMonstersMenu_Case09_Case14
    dw SwapMonstersMenu_Case0E_Case15
    dw SwapMonstersMenu_Case09_Case16
    dw SwapMonstersMenu_Case09_Case17
    dw SwapMonstersMenu_Case09_Case18
    dw SwapMonstersMenu_Case09_Case19
    dw SwapMonstersMenu_Case09_Case1A
    dw SwapMonstersMenu_Case0E_Case1B
    dw SwapMonstersMenu_Case09_Case1C
    dw SwapMonstersMenu_Case09_Case1D
    dw SwapMonstersMenu_Case09_Case1E
    dw SwapMonstersMenu_Case09_Case1F
    dw SwapMonstersMenu_Case0E_Case20

; entry 10 of the `rst $00` table in SwapMonstersMenu_Case0A
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg1, wScreenStep
SwapMonstersMenu_Case0A_Case0A::
Jump_01E_613A:: ; address name
    ld hl, GlyphCopyDestList5
    ld de, GlyphCopySrcList5
    call SwapMonstersMenu_Shared05
    farcall ListRecordsInUseWithByte6EClear
    call GetListEntriesCell5Address
    push hl
    ld a, [hl]
    ld b, a
    call LoadFamilyIconTileForRecordB_Bank1E
    pop hl
    push hl
    ld a, [hl]
    ld b, a
    ld [wArg1], a
    call CallFunc5B4DInBank1D
    pop hl
    ld a, [hl]
    ld b, a
    call LoadFamilyIconTileForRecordB_Bank1E
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 4 of the `rst $00` table in SwapMonstersMenu_Case0E
; no direct call (reached through a table, a jump or a vector)
; writes: wArg1
SwapMonstersMenu_Case0E_Case04::
Jump_01E_616A:: ; address name
    call DrawListEntriesCell5RecordDetails
    ld a, $01
    ld [wArg1], a
    farcall MarkPartyMembersInRecordListPage
    xor a, a
    ld [wArg1], a
    farcall MarkPartyMembersInRecordListPage
    ret

; entry 6 of the `rst $00` table in SwapMonstersMenu_Case0E
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
SwapMonstersMenu_Case0E_Case06::
Jump_01E_6183:: ; address name
    ld a, [wScreenSubStep]
    rst $00
    dw SwapMonstersMenu_Case09_Case06_Case00
    dw ClearTileAreasAndIncScreenSubStep
    dw RedrawRecordListAndNextStep
    dw SwapMonstersMenu_Case0E_Case06_Case03

; entry 3 of the `rst $00` table in SwapMonstersMenu_Case0E_Case06
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wScreenSubStep
SwapMonstersMenu_Case0E_Case06_Case03::
Jump_01E_618F:: ; address name
    call SwapMonstersMenu_Shared02
    call SwapMonstersMenu_Shared06
    ld a, $04
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    ret

; entry 10 of the `rst $00` table in SwapMonstersMenu_Case0E
; no direct call (reached through a table, a jump or a vector)
SwapMonstersMenu_Case0E_Case0A::
Jump_01E_619F:: ; address name
    ld hl, GlyphCopyDestList5
    ld de, GlyphCopySrcList5
    call SwapMonstersMenu_Shared05
    call ListRecordsAndDrawListEntriesCell5Panel
    call GetListEntriesCell5Address
    ld a, [hl]
    ld b, a
    call LoadFamilyIconTileForRecordB_Bank1E
    ret

; entry 0 of the `rst $00` table in SwapMonstersMenu_Case0E
; no direct call (reached through a table, a jump or a vector)
SwapMonstersMenu_Case0E_Case00::
Jump_01E_61B4:: ; address name
    call ClearBGMapAtScrollAndResetScroll
    ld de, Data_01F_4A70
    ld hl, vTiles1 + $7F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ret

; entry 21 of the `rst $00` table in SwapMonstersMenu_Case0E
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
SwapMonstersMenu_Case0E_Case15::
Jump_01E_61C5:: ; address name
    ld a, [wScreenSubStep]
    rst $00
    dw SwapMonstersMenu_Case09_Case15_Case00
    dw ClearTileAreasAndIncScreenSubStep
    dw RedrawRecordListAndNextStep
    dw SwapMonstersMenu_Case0E_Case15_Case03

; entry 3 of the `rst $00` table in SwapMonstersMenu_Case0E_Case15
; no direct call (reached through a table, a jump or a vector)
; writes: wArg1, wScreenSubStep
SwapMonstersMenu_Case0E_Case15_Case03::
Jump_01E_61D1:: ; address name
    call SwapMonstersMenu_Shared02
    call SwapMonstersMenu_Shared06
    ld a, $01
    ld [wArg1], a
    farcall MarkPartyMembersInRecordListPage
    xor a, a
    ld [wArg1], a
    farcall MarkPartyMembersInRecordListPage
    xor a, a
    ld [wScreenSubStep], a
    ret

; entry 27 of the `rst $00` table in SwapMonstersMenu_Case0E
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
SwapMonstersMenu_Case0E_Case1B::
Jump_01E_61F1:: ; address name
    ld a, [wScreenSubStep]
    rst $00
    dw SwapMonstersMenu_Case09_Case1B_Case00
    dw ClearTileAreasAndIncScreenSubStep
    dw RedrawRecordListAndNextStep
    dw SwapMonstersMenu_Case0E_Case1B_Case03

; entry 3 of the `rst $00` table in SwapMonstersMenu_Case0E_Case1B
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg1, wScreenStep, wScreenSubStep
SwapMonstersMenu_Case0E_Case1B_Case03::
Jump_01E_61FD:: ; address name
    call SwapMonstersMenu_Shared02
    call SwapMonstersMenu_Shared06
    ld a, $01
    ld [wArg1], a
    farcall MarkPartyMembersInRecordListPage
    xor a, a
    ld [wArg1], a
    farcall MarkPartyMembersInRecordListPage
    ld a, [wScreenStep]
    sub a, $04
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    ret

; entry 32 of the `rst $00` table in SwapMonstersMenu_Case0E
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
SwapMonstersMenu_Case0E_Case20::
Jump_01E_6225:: ; address name
    ld a, [wScreenSubStep]
    rst $00
    dw SwapMonstersMenu_Case09_Case20_Case00
    dw ClearTileAreasAndIncScreenSubStep
    dw RedrawRecordListAndNextStep
    dw SwapMonstersMenu_Case0E_Case20_Case03

; entry 3 of the `rst $00` table in SwapMonstersMenu_Case0E_Case20
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg1, wScreenStep, wScreenSubStep, hSpriteHideTile
; points at: wTextWindowTileLo
SwapMonstersMenu_Case0E_Case20_Case03::
Jump_01E_6231:: ; address name
    call SwapMonstersMenu_Shared02
    call SwapMonstersMenu_Shared06
    ld a, $01
    ld [wArg1], a
    farcall MarkPartyMembersInRecordListPage
    xor a, a
    ld [wArg1], a
    farcall MarkPartyMembersInRecordListPage
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    jp Jump_01E_5F65

; entry 13 of the `rst $00` table in SwapMonstersMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
SwapMonstersMenu_Case0D::
Jump_01E_625A:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw SwapMonstersMenu_Case0E_Case00
    dw SwapMonstersMenu_Case0D_Case01
    dw SwapMonstersMenu_Case09_Case02
    dw SwapMonstersMenu_Case0D_Case03
    dw SwapMonstersMenu_Case0D_Case04
    dw SwapMonstersMenu_Case0D_Case05
    dw SwapMonstersMenu_Case0D_Case06
    dw SwapMonstersMenu_Case0D_Case07
    dw SwapMonstersMenu_Case0D_Case08
    dw SwapMonstersMenu_Case0E_Case07
    dw SwapMonstersMenu_Case09_Case08
    dw SwapMonstersMenu_Case09_Case09
    dw SwapMonstersMenu_Case0D_Case0C
    dw SwapMonstersMenu_Case06_Case17
    dw SwapMonstersMenu_Case0D_Case0E
    dw SwapMonstersMenu_Case06_Case19
    dw SwapMonstersMenu_Case0D_Case10
    dw SwapMonstersMenu_Case0D_Case11

; entry 1 of the `rst $00` table in SwapMonstersMenu_Case0D
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenSubStep, wScreenStep
SwapMonstersMenu_Case0D_Case01::
Jump_01E_6282:: ; address name
    ld hl, GlyphCopyDestList4
    ld de, GlyphCopySrcList4
    call SwapMonstersMenu_Shared05
    call SwapMonstersMenu_Shared04
    xor a, a
    ld [wScreenSubStep], a
    ld a, $02
    ld [wScreenStep], a
    ret

; entry 11 of the `rst $00` table in SwapMonstersMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
SwapMonstersMenu_Case0B::
Jump_01E_6298:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw SwapMonstersMenu_Case0E_Case00
    dw SwapMonstersMenu_Case09_Case01
    dw SwapMonstersMenu_Case09_Case02
    dw SwapMonstersMenu_Case0D_Case03
    dw SwapMonstersMenu_Case0D_Case04
    dw SwapMonstersMenu_Case0D_Case05
    dw SwapMonstersMenu_Case0D_Case06
    dw SwapMonstersMenu_Case0D_Case07
    dw SwapMonstersMenu_Case0D_Case08
    dw ClearBGMapAtScrollAndResetScroll
    dw SwapMonstersMenu_Case09_Case08
    dw SwapMonstersMenu_Case09_Case09
    dw SwapMonstersMenu_Case0D_Case0C
    dw SwapMonstersMenu_Case06_Case17
    dw SwapMonstersMenu_Case0D_Case0E
    dw SwapMonstersMenu_Case06_Case19
    dw SwapMonstersMenu_Case0D_Case10
    dw SwapMonstersMenu_Case0D_Case11

; entry 3 of the `rst $00` table in SwapMonstersMenu_Case0D
; no direct call (reached through a table, a jump or a vector)
; reads: wListPageIndex, wListCursor, wScreenStep
; writes: wListCursor, wListPageIndex, wScreenStep
SwapMonstersMenu_Case0D_Case03::
Jump_01E_62C0:: ; address name
    ld hl, vTiles2 + $200
    ld bc, $1304
    call FillTilesBxC
    ld de, Data_01F_4A40
    ld hl, vTiles1 + $6D0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wListPageIndex]
    add a, a
    add a, a
    ld b, a
    ld a, [wListCursor]
    add a, b
    ld [wListCursor], a
    xor a, a
    ld [wListPageIndex], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 4 of the `rst $00` table in SwapMonstersMenu_Case0D
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg3, wArg4, wArg7, wArg1, wArg2, wScreenStep
SwapMonstersMenu_Case0D_Case04::
Jump_01E_62EF:: ; address name
    farcall UploadTilesFromData6D20
    call BGMapAddressAtScroll_Bank1E
    ld de, TileRect_1F_6E7F
    ld a, $14
    ld [wArg3], a
    ld a, $12
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    call GetListEntriesCell4Address
    ld a, l
    ld [wArg1], a
    ld a, h
    ld [wArg2], a
    farcall LoadPartySpeciesSpriteGraphics
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 5 of the `rst $00` table in SwapMonstersMenu_Case0D
; no direct call (reached through a table, a jump or a vector)
; reads: wListCount, wScreenStep
; writes: hSpriteHideTile, wScreenStep
SwapMonstersMenu_Case0D_Case05::
Jump_01E_6325:: ; address name
    call GetListEntriesCell4Address
    ld a, [hl]
    ld b, a
    call DrawRecordParentNames
    call DrawRecordFamilyEntries_6FEB
    ld a, $F0
    ldh [hSpriteHideTile], a
    call BGMapAddressAtScroll_Bank1E
    ld de, $0069
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, $6C
    ld [hl], a
    ei
    ld de, $0120
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, $6D
    ld [hl], a
    ei
    ld a, [wListCount]
    cp a, $02
    jr c, Jump_01E_6391
    ld de, Data_01F_4AA0
    ld hl, vTiles2 + $20
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4AE0
    ld hl, vTiles2 + $30
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    call BGMapAddressAtScroll_Bank1E
    ld de, $0012
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, $02
    ld [hl], a
    ei
    ld de, $0220
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, $03
    ld [hl], a
    ei

Jump_01E_6391::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 6 of the `rst $00` table in SwapMonstersMenu_Case0D
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep, hTemp0, hTemp1, wIsCGB, wScreenStep
; writes: rRAMG2, rRAMB, wScreenSubStep, wBGPaletteUploadRequest, hTemp0, wArg3, wArg4, wArg7, ...
SwapMonstersMenu_Case0D_Case06::
Jump_01E_6399:: ; address name
    ld a, [wScreenSubStep]
    and a, a
    jp nz, Jump_01E_63D3
    call DrawRect6x6From651BAtScroll41
    call GetListEntriesCell4Address
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    push hl
    ld a, [hl]
    ld c, $0B
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    push de
    ld hl, vTiles2 + $480
    ld c, $01
    call LoadMonsterPicture
    pop de
    pop hl
    xor a, a
    ld [rRAMG2], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

Jump_01E_63D3::
    call GetListEntriesCell4Address
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    push hl
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_01E_640A
    ld a, [hl]
    ld c, $0B
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    push de
    ld a, $7F
    ld [wBGPaletteUploadRequest], a
    call UploadBGPalettes
    ld a, $01
    ldh [hTemp0], a
    call BGMapAddressAtScroll_Bank1E
    ld de, $0041
    add hl, de
    pop de
    call LoadMonsterPictureAttributes

Jump_01E_640A::
    pop hl
    xor a, a
    ld [rRAMG2], a
    call BGMapAddressAtScroll_Bank1E
    ld de, $0041
    add hl, de
    ld de, TileRect_1F_64F7
    ld a, $06
    ld [wArg3], a
    ld a, $06
    ld [wArg4], a
    ld a, $01
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    xor a, a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 7 of the `rst $00` table in SwapMonstersMenu_Case0D
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wLinkMode, wLinkSession, wScreenStep, wRecordsFlagged
; writes: wArg1, wArg2, hSpriteHideTile, wScreenStep
SwapMonstersMenu_Case0D_Case07::
Jump_01E_6437:: ; address name
    farcall HandleListCursorInput_1D
    ld a, [wMenuInputResult]
    and a, a
    jr z, Jump_01E_644F
    cp a, $FD
    jr z, Jump_01E_6471
    cp a, $FE
    jr z, Jump_01E_6483
    cp a, $FF
    jr z, Jump_01E_6483

Jump_01E_644F::
    ld a, [wLinkMode]
    and a, a
    jr z, Jump_01E_645D
    ld a, [wLinkSession]
    cp a, $08
    jr nz, Jump_01E_645D
    ret

Jump_01E_645D::
    call GetListEntriesCell4Address
    ld c, $00
    ld a, l
    ld [wArg1], a
    ld a, h
    ld [wArg2], a
    farcall DrawPartySpeciesSprites
    ret

Jump_01E_6471::
    ld a, [wRecordsFlagged]
    cp a, $02
    jr c, Jump_01E_644F
    xor a, a
    ldh [hSpriteHideTile], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

Jump_01E_6483::
    call SplitListCursorBy4_Bank1E
    xor a, a
    ldh [hSpriteHideTile], a
    ld a, [wScreenStep]
    add a, $02
    ld [wScreenStep], a
    ret

; entry 8 of the `rst $00` table in SwapMonstersMenu_Case0D
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
SwapMonstersMenu_Case0D_Case08::
Jump_01E_6492:: ; address name
    ld hl, vTiles2 + $200
    ld bc, $0805
    call FillTilesBxC
    ld hl, vTiles2 + $480
    ld bc, $0904
    call FillTilesBxC
    ld a, [wScreenStep]
    sub a, $04
    ld [wScreenStep], a
    ret

; entry 12 of the `rst $00` table in SwapMonstersMenu_Case0D
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
SwapMonstersMenu_Case0D_Case0C::
Jump_01E_64AD:: ; address name
    ld hl, GlyphCopyDestList5
    ld de, GlyphCopySrcList5
    call SwapMonstersMenu_Shared05
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 17 of the `rst $00` table in SwapMonstersMenu_Case0D
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenByteB2, wScreenByteB3
; writes: wOBJPaletteUploadRequest, hSpriteHideTile, wScreenSubStep, wScreenState, wScreenStep, wScriptCommandType, wScriptStartRequest
; points at: wTextWindowTileLo
SwapMonstersMenu_Case0D_Case11::
Jump_01E_64BE:: ; address name
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    call BGMapAddressAtScroll_Bank1E
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank1E
    call BGMapAddressAtScroll_Bank1E
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call DrawScreenBufferRect_Bank1E
    call RestoreSpriteStateFromSavedFieldDrawFlags
    ld a, $70
    ldh [hSpriteHideTile], a
    xor a, a
    ld [wScreenSubStep], a
    ld a, [wScreenByteB2]
    ld [wScreenState], a
    ld a, [wScreenByteB3]
    ld [wScreenStep], a
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, [wScreenByteB2]
    cp a, $07
    ret nz
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 14 of the `rst $00` table in SwapMonstersMenu_Case0D
; no direct call (reached through a table, a jump or a vector)
; reads: wListPages, wScreenByteB2, wScreenStep
; writes: wArg1, wArg2, wScreenStep
SwapMonstersMenu_Case0D_Case0E::
Jump_01E_6519:: ; address name
    ld de, $7B49
    ld hl, wWindowTileBuffer + $6B
    ld bc, $0D09
    call CopyRectTo20ByteRows_Bank1E
    call ClampRecordListPageCursor4
    ld a, [wListPages]
    cp a, $02
    jr c, Jump_01E_6552
    ld a, [wScreenByteB2]
    cp a, $07
    jr z, Jump_01E_6559
    ld hl, wWindowTileBuffer + $112
    call StoreC5BEC6AtHLStride2_Bank1E
    ld hl, wWindowTileBuffer + $113
    ld a, h
    ld [wArg1], a
    ld a, l
    ld [wArg2], a
    call DrawPageOfPagesAtArg1_Bank1E

Jump_01E_654A::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

Jump_01E_6552::
    ld a, [wScreenByteB2]
    cp a, $07
    jr nz, Jump_01E_654A

Jump_01E_6559::
    ld de, $6567
    ld hl, wWindowTileBuffer + $110
    ld bc, $0801
    call CopyRectTo20ByteRows_Bank1E
    jr Jump_01E_654A

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 1 tiles, one row per line
TileRect_1E_6567::
Data_01E_6567:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0

; entry 16 of the `rst $00` table in SwapMonstersMenu_Case0D
; no direct call (reached through a table, a jump or a vector)
; reads: wGridCursorX, wScreenByteB2, wScreenStep, wListCursor
; writes: wArg1, wArg2, wScreenStep
SwapMonstersMenu_Case0D_Case10::
Jump_01E_656F:: ; address name
    ld de, Data_01F_4990
    ld hl, vTiles1 + $4E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, $01
    ld [wArg1], a
    xor a, a
    ld [wArg2], a
    farcall DrawRecordListPageMarks
    ld a, [wGridCursorX]
    ld b, $BC
    ld hl, CursorCellTable7880
    call StoreBAtWordTableEntry_Bank1E
    ld a, [wScreenByteB2]
    cp a, $07
    jr z, Jump_01E_65A5
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

Jump_01E_65A5::
    ld a, [wListCursor]
    ld b, $BC
    ld hl, $788E
    call StoreBAtWordTableEntry_Bank1E
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 8 of the `rst $00` table in SwapMonstersMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
SwapMonstersMenu_Case08::
Jump_01E_65B8:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw ClearBGMapAtScrollAndResetScroll
    dw SwapMonstersMenu_Case09_Case01
    dw SwapMonstersMenu_Case09_Case02
    dw SwapMonstersMenu_Case08_Case03
    dw DrawListEntriesCell5RecordDetails
    dw SwapMonstersMenu_Case09_Case05
    dw SwapMonstersMenu_Case08_Case06
    dw ClearBGMapAtScrollAndResetScroll
    dw SwapMonstersMenu_Case09_Case08
    dw SwapMonstersMenu_Case09_Case09
    dw ListRecordsAndDrawListEntriesCell5Panel
    dw SwapMonstersMenu_Case09_Case0B
    dw SwapMonstersMenu_Case09_Case0C
    dw SwapMonstersMenu_Case08_Case0D
    dw SwapMonstersMenu_Case09_Case0E
    dw SwapMonstersMenu_Case09_Case0B
    dw SwapMonstersMenu_Case09_Case0C
    dw SwapMonstersMenu_Case09_Case11
    dw SwapMonstersMenu_Case09_Case12
    dw SwapMonstersMenu_Case09_Case13
    dw SwapMonstersMenu_Case09_Case14
    dw SwapMonstersMenu_Case08_Case15
    dw SwapMonstersMenu_Case09_Case16
    dw SwapMonstersMenu_Case09_Case17
    dw SwapMonstersMenu_Case09_Case18
    dw SwapMonstersMenu_Case09_Case19
    dw SwapMonstersMenu_Case09_Case1A
    dw SwapMonstersMenu_Case08_Case1B
    dw SwapMonstersMenu_Case09_Case1C
    dw SwapMonstersMenu_Case09_Case1D
    dw SwapMonstersMenu_Case09_Case1E
    dw SwapMonstersMenu_Case09_Case1F
    dw SwapMonstersMenu_Case08_Case20

; fills the 32 x 32 BG map from the scroll origin with BGFillTile (tile $C3) through FillTileRectWithArg1Tile with wArg7 = 0, then hScrollX = hScrollY = 0 and wD781 += 1 (E-0120; fill, not a tile map: E-0186)
; 2 call sites from 2 routines (e.g. SwapMonstersMenu_Case0E_Case07, SwapMonstersMenu_Case0E_Case00)
; reads: wScreenStep
; writes: wArg5, wArg6, wArg1, wArg2, wArg3, wArg4, wArg7, hScrollX, ...
ClearBGMapAtScrollAndResetScroll::
Func_01E_65FE:: ; address name
    call BGMapAddressAtScroll_Bank1E
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
    ldh [hScrollX], a
    ldh [hScrollY], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 1 of the `rst $00` table in SwapMonstersMenu_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
SwapMonstersMenu_Case09_Case01::
Jump_01E_6635:: ; address name
    ld hl, GlyphCopyDestList4
    ld de, GlyphCopySrcList4
    call SwapMonstersMenu_Shared05
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 2 of the `rst $00` table in SwapMonstersMenu_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
SwapMonstersMenu_Case09_Case02::
Jump_01E_6646:: ; address name
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 3 of the `rst $00` table in SwapMonstersMenu_Case08
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg3, wArg4, wArg7, wScreenStep
SwapMonstersMenu_Case08_Case03::
Jump_01E_664E:: ; address name
    call BGMapAddressAtScroll_Bank1E
    ld de, TileRect_1F_5E37
    ld a, $14
    ld [wArg3], a
    ld a, $12
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    call BGMapAddressAtScroll_Bank1E
    ld de, $0020
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    ld c, $40
    call SwapMonstersMenu_Shared07
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; for the record at WD789 cell 5, with SRAM enabled, runs Func_01E_725D, 7332 and 7399; wD781 += 1 (E-0122)
; 1 call site from 1 routine (e.g. SwapMonstersMenu_Case0E_Case04)
; reads: wScreenStep
; writes: rRAMG2, rRAMB, wScreenStep
DrawListEntriesCell5RecordDetails::
Func_01E_667C:: ; address name
    call GetListEntriesCell5Address
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    call DrawRecordLevelAndStatusRow_1E
    call DrawListEntriesCell5RecordDetails_Sub01
    call DrawListEntriesCell5RecordDetails_Sub02
    xor a, a
    ld [rRAMG2], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 5 of the `rst $00` table in SwapMonstersMenu_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep, hTemp0, hTemp1, wIsCGB, wScreenStep
; writes: wArg3, wArg4, wArg7, rRAMG2, rRAMB, wScreenSubStep, wBGPaletteUploadRequest, hTemp0, ...
SwapMonstersMenu_Case09_Case05::
Jump_01E_669D:: ; address name
    ld a, [wScreenSubStep]
    and a, a
    jp nz, Jump_01E_66EF
    call BGMapAddressAtScroll_Bank1E
    ld de, $0161
    add hl, de
    ld de, TileRect_1F_651B
    ld a, $06
    ld [wArg3], a
    ld a, $06
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    call GetListEntriesCell5Address
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    push hl
    ld a, [hl]
    ld c, $0B
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    push de
    ld hl, vTiles2 + $200
    ld c, $01
    call LoadMonsterPicture
    pop de
    pop hl
    xor a, a
    ld [rRAMG2], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

Jump_01E_66EF::
    call GetListEntriesCell5Address
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    push hl
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_01E_6726
    ld a, [hl]
    ld c, $0B
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    push de
    ld a, $7F
    ld [wBGPaletteUploadRequest], a
    call UploadBGPalettes
    ld a, $01
    ldh [hTemp0], a
    call BGMapAddressAtScroll_Bank1E
    ld de, $0161
    add hl, de
    pop de
    call LoadMonsterPictureAttributes

Jump_01E_6726::
    pop hl
    xor a, a
    ld [rRAMG2], a
    call BGMapAddressAtScroll_Bank1E
    ld de, $0161
    add hl, de
    ld de, TileRect_1F_64AF
    ld a, $06
    ld [wArg3], a
    ld a, $06
    ld [wArg4], a
    ld a, $01
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    xor a, a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 6 of the `rst $00` table in SwapMonstersMenu_Case08
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wScreenStep
; writes: wMenuInputResult, wArg3, wArg4, wArg7, wScreenStep
SwapMonstersMenu_Case08_Case06::
Jump_01E_6753:: ; address name
    xor a, a
    ld [wMenuInputResult], a
    farcall UpdateListCursorListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FD
    jr z, Jump_01E_676F
    cp a, $FE
    jr z, Jump_01E_6775
    cp a, $FF
    jr z, Jump_01E_677D
    ret

Jump_01E_676F::
    ld a, $04
    ld [wScreenStep], a
    ret

Jump_01E_6775::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

Jump_01E_677D::
    call BGMapAddressAtScroll_Bank1E
    ld de, $0161
    add hl, de
    ld de, TileRect_1F_651B
    ld a, $06
    ld [wArg3], a
    ld a, $06
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    ld a, $0E
    ld [wScreenStep], a
    ret

; entry 8 of the `rst $00` table in SwapMonstersMenu_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wBGPaletteUploadRequest, wScreenStep
SwapMonstersMenu_Case09_Case08::
Jump_01E_679E:: ; address name
    farcall LoadAreaGraphicsForAreaGraphicsIndex
    ld a, $7F
    ld [wBGPaletteUploadRequest], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 9 of the `rst $00` table in SwapMonstersMenu_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState, wListCursor, wScreenStep
; writes: wScreenStep
SwapMonstersMenu_Case09_Case09::
Jump_01E_67B1:: ; address name
    ld hl, GlyphCopyDestList3
    ld de, GlyphCopySrcList3
    call SwapMonstersMenu_Shared05
    xor a, a
    ld b, $C3
    ld hl, CursorCellTable7880
    call StoreBAtWordTableEntry_Bank1E
    ld a, $01
    ld b, $C3
    ld hl, CursorCellTable7880
    call StoreBAtWordTableEntry_Bank1E
    ld a, $02
    ld b, $C3
    ld hl, CursorCellTable7880
    call StoreBAtWordTableEntry_Bank1E
    ld a, [wScreenState]
    cp a, $08
    jr z, Jump_01E_67F2
    ld a, $03
    ld b, $C3
    ld hl, CursorCellTable7880
    call StoreBAtWordTableEntry_Bank1E
    ld a, $04
    ld b, $C3
    ld hl, CursorCellTable7880
    call StoreBAtWordTableEntry_Bank1E

Jump_01E_67F2::
    ld a, [wScreenState]
    cp a, $0A
    jr z, Jump_01E_6808
    cp a, $0B
    jr z, Jump_01E_6808
    ld a, [wListCursor]
    ld b, $BC
    ld hl, CursorCellTable7880
    call StoreBAtWordTableEntry_Bank1E

Jump_01E_6808::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; lists the records (Func_01D_5E79 in state 8, else ListRecordsState1WithByte6EClear), loads the family icon of the record at WD789 cell 5 and draws it, then wD781 += 1 (E-0124)
; 1 call site from 1 routine (e.g. SwapMonstersMenu_Case0E_Case0A)
; reads: wScreenState, wScreenStep
; writes: wArg1, wScreenStep
ListRecordsAndDrawListEntriesCell5Panel::
Func_01E_6810:: ; address name
    ld a, [wScreenState]
    cp a, $08
    jr nz, Jump_01E_681F
    farcall ListPartyRecordsWithState2ToListEntries
    jr Jump_01E_6825

Jump_01E_681F::
    farcall ListRecordsState1WithByte6EClear

Jump_01E_6825::
    call GetListEntriesCell5Address
    ld a, [hl]
    ld b, a
    call LoadFamilyIconTileForRecordB_Bank1E
    call GetListEntriesCell5Address
    ld a, [hl]
    ld b, a
    ld [wArg1], a
    call CallFunc5B4DInBank1D
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 11 of the `rst $00` table in SwapMonstersMenu_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
SwapMonstersMenu_Case09_Case0B::
Jump_01E_6840:: ; address name
    ld hl, vTiles1 + $270
    ld bc, $0901
    call FillTilesBxC
    ld hl, vTiles1 + $780
    ld bc, $0501
    call FillTilesBxC
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 12 of the `rst $00` table in SwapMonstersMenu_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg1, wScreenStep
SwapMonstersMenu_Case09_Case0C::
Jump_01E_685A:: ; address name
    call GetListEntriesCell5Address
    ld a, [hl]
    ld b, a
    ld [wArg1], a
    farcall DrawRecordNameAndSpeciesNameTiles
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 13 of the `rst $00` table in SwapMonstersMenu_Case08
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenByteB2, wScreenByteB3
; writes: wOBJPaletteUploadRequest, hSpriteHideTile, wScreenSubStep, wScreenState, wScreenStep, wScriptCommandType, wScriptStartRequest
; points at: wTextWindowTileLo
SwapMonstersMenu_Case08_Case0D::
Jump_01E_6870:: ; address name
    farcall ListPartyRecordsWithState2ToListEntries
    call GetListEntriesCell4Address
    ld a, [hl]
    ld b, a
    call LoadFamilyIconTileForRecordB_Bank1E
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    call BGMapAddressAtScroll_Bank1E
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank1E
    call BGMapAddressAtScroll_Bank1E
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call DrawScreenBufferRect_Bank1E
    call RestoreSpriteStateFromSavedFieldDrawFlags
    ld a, $70
    ldh [hSpriteHideTile], a
    xor a, a
    ld [wScreenSubStep], a
    ld a, [wScreenByteB2]
    ld [wScreenState], a
    ld a, [wScreenByteB3]
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

; entry 14 of the `rst $00` table in SwapMonstersMenu_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
SwapMonstersMenu_Case09_Case0E::
Jump_01E_68D3:: ; address name
    ld hl, vTiles2 + $200
    ld bc, $0F02
    call FillTilesBxC
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 17 of the `rst $00` table in SwapMonstersMenu_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg3, wArg4, wArg7, wScreenStep
SwapMonstersMenu_Case09_Case11::
Jump_01E_68E4:: ; address name
    call BGMapAddressAtScroll_Bank1E
    ld de, $0068
    add hl, de
    ld de, TileRect_1F_6577
    ld a, $0C
    ld [wArg3], a
    ld a, $0F
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 18 of the `rst $00` table in SwapMonstersMenu_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0, hTemp1, wScreenStep
; writes: rRAMG2, rRAMB, wArg1, wArg2, wArg3, wArg4, wArg5, hSpriteHideTile, ...
SwapMonstersMenu_Case09_Case12::
Jump_01E_6907:: ; address name
    call GetListEntriesCell5Address
    ld a, [hl]
    push hl
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    call ShowRecordPersonalityName
    pop hl
    call DrawRecordName0FAtTiles2290
    xor a, a
    ld [rRAMG2], a

; entry 19 of the `rst $00` table in SwapMonstersMenu_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0, hTemp1, wScreenStep
; writes: rRAMG2, rRAMB, wArg1, wArg2, wArg3, wArg4, wArg5, hSpriteHideTile, ...
SwapMonstersMenu_Case09_Case13::
Jump_01E_6920:: ; address name
    call GetListEntriesCell5Address
    push hl
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld b, a
    ld a, $6D
    ld [wArg1], a
    xor a, a
    ld [wArg2], a
    ld a, $EA
    ld [wArg3], a
    ld a, $C7
    ld [wArg4], a
    call SwapMonstersMenu_Case09_Case13_Sub02
    pop hl
    call SwapMonstersMenu_Case09_Case13_Sub01
    xor a, a
    ld [rRAMG2], a

; entry 20 of the `rst $00` table in SwapMonstersMenu_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0, hTemp1, wScreenStep
; writes: rRAMG2, rRAMB, wArg1, wArg2, wArg3, wArg4, wArg5, hSpriteHideTile, ...
SwapMonstersMenu_Case09_Case14::
Jump_01E_694D:: ; address name
    call GetListEntriesCell5Address
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, $0B
    call LoadSRAMRecordWord
    xor a, a
    ld [rRAMG2], a
    ldh a, [hTemp0]
    ld [wArg1], a
    ldh a, [hTemp1]
    ld [wArg2], a
    xor a, a
    ld [wArg3], a
    ld [wArg4], a
    ld a, $80
    ld [wArg5], a
    farcall DecompressGraphicsArg1ToArg4
    ld a, $F0
    ldh [hSpriteHideTile], a
    farcall ShowCategory11StringOfListEntriesCell5Record
    call BGMapAddressAtScroll_Bank1E
    ld de, $0160
    add hl, de
    ld de, TileRect_1F_66DF
    ld a, $08
    ld [wArg3], a
    ld a, $07
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    ld a, [wScreenStep]
    add a, $03
    ld [wScreenStep], a
    ret

; entry 21 of the `rst $00` table in SwapMonstersMenu_Case08
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0, hTemp1, wMenuInputResult, wScreenStep
; writes: rRAMG2, rRAMB, wArg1, wArg2, wArg3, wArg4, wArg5, wArg6, ...
SwapMonstersMenu_Case08_Case15::
Jump_01E_69AD:: ; address name
    call GetListEntriesCell5Address
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, $0B
    call LoadSRAMRecordWord
    xor a, a
    ld [rRAMG2], a
    ldh a, [hTemp0]
    ld [wArg1], a
    ldh a, [hTemp1]
    ld [wArg2], a
    xor a, a
    ld [wArg3], a
    ld a, $90
    ld [wArg4], a
    ld a, $40
    ld [wArg5], a
    xor a, a
    ld [wArg6], a
    farcall DrawMetaSpritePartC0
    xor a, a
    ld [wMenuInputResult], a
    farcall UpdateListCursorListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FD
    jr z, Jump_01E_6A01
    cp a, $FE
    jr z, Jump_01E_6A18
    cp a, $FF
    jr z, Jump_01E_6A0C
    ret

Jump_01E_6A01::
    xor a, a
    ldh [hSpriteHideTile], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

Jump_01E_6A0C::
    xor a, a
    ldh [hSpriteHideTile], a
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    ret

Jump_01E_6A18::
    xor a, a
    ldh [hSpriteHideTile], a
    call BGMapAddressAtScroll_Bank1E
    ld de, $0068
    add hl, de
    ld de, TileRect_1F_662B
    ld a, $0C
    ld [wArg3], a
    ld a, $0F
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    call BGMapAddressAtScroll_Bank1E
    ld de, $0160
    add hl, de
    ld de, TileRect_1F_653F
    ld a, $08
    ld [wArg3], a
    ld a, $07
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    ld a, $04
    ld [wScreenStep], a
    ret

; entry 22 of the `rst $00` table in SwapMonstersMenu_Case09
; no direct call (reached through a table, a jump or a vector)
; writes: rRAMG2, rRAMB, wScreenStep
SwapMonstersMenu_Case09_Case16::
Jump_01E_6A57:: ; address name
    call GetListEntriesCell5Address
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    call DrawRecordLevelAndStatusRow_1E
    xor a, a
    ld [rRAMG2], a
    ld a, $0F
    ld [wScreenStep], a
    ret

; entry 25 of the `rst $00` table in SwapMonstersMenu_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0, hTemp5, wScreenStep
; writes: rRAMG2, rRAMB, hTemp5, wTextWindowRows, wTextWindowWidth, wStringCategory, wTextWindowTileLo, wTextWindowTileHi, ...
; points at: wTextWindowTileLo
SwapMonstersMenu_Case09_Case19::
Jump_01E_6A70:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    call GetListEntriesCell5Address
    ld a, [hl]
    ldh [hTemp5], a
    ld c, $34
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    cp a, $FF
    jr z, Jump_01E_6A8F
    and a, a
    jr z, Jump_01E_6A8F
    jr Jump_01E_6AB7

Jump_01E_6A8F::
    ld hl, vTiles2 + $200
    ld bc, $1504
    call FillTilesBxC
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $92
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld [hl], $09
    ld a, $08
    ld [wStringCategory], a
    ld a, $0E
    ld [wStringIndex], a
    farcall ShowString_Bank08
    jr Jump_01E_6AFF

Jump_01E_6AB7::
    ld hl, vTiles2 + $200
    ld c, $34
    ld b, $08
    ld a, $01
    ld [wTextWindowRows], a
    ld a, $09
    ld [wTextWindowWidth], a
    ld a, $04
    ld [wStringCategory], a

Jump_01E_6ACD::
    push bc
    push hl
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ldh a, [hTemp5]
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and a, a
    jr z, Jump_01E_6AE7
    cp a, $FF
    jr z, Jump_01E_6AE7
    jr Jump_01E_6AEC

Jump_01E_6AE7::
    call FillTilesFromRequest
    jr Jump_01E_6AF5

Jump_01E_6AEC::
    ld [wStringIndex], a
    farcall ShowString_Bank08

Jump_01E_6AF5::
    pop hl
    ld bc, $0090
    add hl, bc
    pop bc
    inc c
    dec b
    jr nz, Jump_01E_6ACD

Jump_01E_6AFF::
    xor a, a
    ld [rRAMG2], a
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12

; entry 26 of the `rst $00` table in SwapMonstersMenu_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
SwapMonstersMenu_Case09_Case1A::
Jump_01E_6B10:: ; address name
    farcall ShowSpeciesCategory13StringOfListEntriesCell5Record
    ld a, [wScreenStep]
    add a, $02
    ld [wScreenStep], a
    ret

; entry 27 of the `rst $00` table in SwapMonstersMenu_Case08
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wScreenStep
; writes: wMenuInputResult, wArg3, wArg4, wArg7, wScreenStep
; points at: wTextWindowTileLo
SwapMonstersMenu_Case08_Case1B::
Jump_01E_6B1F:: ; address name
    xor a, a
    ld [wMenuInputResult], a
    farcall UpdateListCursorListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FD
    jr z, Jump_01E_6B3B
    cp a, $FE
    jr z, Jump_01E_6B44
    cp a, $FF
    jr z, Jump_01E_6B55
    ret

Jump_01E_6B3B::
    ld a, [wScreenStep]
    sub a, $02
    ld [wScreenStep], a
    ret

Jump_01E_6B44::
    ld hl, vTiles2 + $200
    ld bc, $1504
    call FillTilesBxC
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

Jump_01E_6B55::
    ld hl, vTiles2 + $730
    ld de, Data_01F_42D0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    farcall UploadTilesFromData6D20
    call BGMapAddressAtScroll_Bank1E
    ld de, $0160
    add hl, de
    ld de, TileRect_1F_6E47
    ld a, $08
    ld [wArg3], a
    ld a, $07
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    ld hl, vTiles2 + $6C0
    ld bc, $0201
    call FillTilesBxC
    call BGMapAddressAtScroll_Bank1E
    ld de, $0008
    add hl, de
    ld de, TileRect_1F_6D6F
    ld a, $0C
    ld [wArg3], a
    ld a, $12
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    ld hl, vTiles2 + $200
    ld bc, $0805
    call FillTilesBxC
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, [wScreenStep]
    add a, $03
    ld [wScreenStep], a
    ret

; entry 28 of the `rst $00` table in SwapMonstersMenu_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep, wScreenStep
; writes: wArg3, wArg4, wArg7, wScreenSubStep, wScreenStep
SwapMonstersMenu_Case09_Case1C::
Jump_01E_6BC6:: ; address name
    ld a, [wScreenSubStep]
    and a, a
    jr nz, Jump_01E_6C0A
    call BGMapAddressAtScroll_Bank1E
    ld de, $0008
    add hl, de
    ld de, TileRect_1F_5E13
    ld a, $0C
    ld [wArg3], a
    ld a, $03
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    call BGMapAddressAtScroll_Bank1E
    ld de, $0160
    add hl, de
    ld de, TileRect_1F_66DF
    ld a, $08
    ld [wArg3], a
    ld a, $07
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

Jump_01E_6C0A::
    ld hl, GlyphCopyDestList3
    ld de, GlyphCopySrcList3
    call SwapMonstersMenu_Shared05
    xor a, a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 29 of the `rst $00` table in SwapMonstersMenu_Case09
; no direct call (reached through a table, a jump or a vector)
; writes: rRAMG2, rRAMB, wArg1, wScreenStep
; points at: wTextWindowTileLo
SwapMonstersMenu_Case09_Case1D::
Jump_01E_6C1F:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    call GetListEntriesCell5Address
    ld a, [hl]
    ld b, a
    push bc
    call DrawRecordLevelAndStatusRow_1E
    xor a, a
    ld [rRAMG2], a
    ld hl, vTiles1 + $270
    ld bc, $0901
    call FillTilesBxC
    pop bc
    ld a, b
    ld [wArg1], a
    farcall DrawRecordNameAndSpeciesNameTiles
    ld de, Data_01F_4AD0
    ld hl, vTiles2 + $6F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, $11
    ld [wScreenStep], a
    ret

; entry 30 of the `rst $00` table in SwapMonstersMenu_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg3, wArg4, wArg7, wArg1, wArg2, hSpriteHideTile, wScreenStep
SwapMonstersMenu_Case09_Case1E::
Jump_01E_6C69:: ; address name
    call BGMapAddressAtScroll_Bank1E
    ld de, $0008
    add hl, de
    ld de, TileRect_1F_63D7
    ld a, $0C
    ld [wArg3], a
    ld a, $12
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    call GetListEntriesCell5Address
    ld a, l
    ld [wArg1], a
    ld a, h
    ld [wArg2], a
    push hl
    farcall LoadPartySpeciesSpriteGraphics
    pop hl

; entry 31 of the `rst $00` table in SwapMonstersMenu_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: hSpriteHideTile, wScreenStep
SwapMonstersMenu_Case09_Case1F::
Jump_01E_6C97:: ; address name
    ld b, [hl]
    call DrawRecordParentNames
    call DrawRecordFamilyEntries_6FEB
    ld a, $F0
    ldh [hSpriteHideTile], a
    ld a, [wScreenStep]
    add a, $02
    ld [wScreenStep], a
    ret

; entry 32 of the `rst $00` table in SwapMonstersMenu_Case08
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wScreenStep
; writes: wMenuInputResult, wArg1, wArg2, hSpriteHideTile, wScreenStep
; points at: wTextWindowTileLo
SwapMonstersMenu_Case08_Case20::
Jump_01E_6CAB:: ; address name
    xor a, a
    ld [wMenuInputResult], a
    farcall UpdateListCursorListCursor
    ld a, [wMenuInputResult]
    and a, a
    jr z, Jump_01E_6CC7
    cp a, $FD
    jr z, Jump_01E_6CDB
    cp a, $FE
    jr z, Jump_01E_6CFD
    cp a, $FF
    jr z, Jump_01E_6D06

Jump_01E_6CC7::
    call GetListEntriesCell5Address
    ld c, $00
    ld a, l
    ld [wArg1], a
    ld a, h
    ld [wArg2], a
    farcall DrawPartySpeciesSprites
    ret

Jump_01E_6CDB::
    xor a, a
    ldh [hSpriteHideTile], a
    ld a, [wScreenStep]
    dec a
    dec a
    ld [wScreenStep], a
    ld hl, vTiles2 + $200
    ld bc, $0805
    call FillTilesBxC
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ret

Jump_01E_6CFD::
    xor a, a
    ldh [hSpriteHideTile], a
    ld a, $17
    ld [wScreenStep], a
    ret

Jump_01E_6D06::
    xor a, a
    ldh [hSpriteHideTile], a
    ld a, $07
    ld [wScreenStep], a
    ret

; draws a 6 x 6 tile rectangle from $651B at BGMapAddressAtScroll + $41 (DrawTileRectAtHLFromDE_Bank1E, attributes cleared) (E-0118)
; 1 call site from 1 routine (e.g. SwapMonstersMenu_Case0D_Case06)
; writes: wArg3, wArg4, wArg7
DrawRect6x6From651BAtScroll41::
Func_01E_6D0F:: ; address name
    call BGMapAddressAtScroll_Bank1E
    ld de, $0041
    add hl, de
    ld de, TileRect_1F_651B
    ld a, $06
    ld [wArg3], a
    ld a, $06
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    ret

; wD7F5/wD7F6 = HL (destination), wD7F1/wD7F2 = DE (source), then far-calls DrawTileRectFromArg1Params (width and rows already in wD7F3/wD7F4) (E-0093) (the same 23 bytes appear in 4 banks)
; 27 call sites from 19 routines (e.g. SwapMonstersMenu_Case08_Case1B, SwapMonstersMenu_Case08_Case15, SwapMonstersMenu_Case08_Case06, SwapMonstersMenu_Case08_Case03, ...)
; writes: wArg5, wArg6, wArg1, wArg2
DrawTileRectAtHLFromDE_Bank1E::
Func_01E_6D2B:: ; address name
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    farcall DrawTileRectFromArg1Params
    ret

; A = [HL] (a record): shows string PersonalityIndexOfRecord of category 7 (personality names) in a window at $9200 with size $0109 (ShowString_Bank08), then restores the default window ($8800, $1202) (E-0120)
; 1 call site from 1 routine (e.g. SwapMonstersMenu_Case09_Case12)
; writes: wStringIndex, wStringCategory
; points at: wTextWindowTileLo
ShowRecordPersonalityName::
Func_01E_6D42:: ; address name
    ld a, [hl]
    call PersonalityIndexOfRecord
    ld c, a
    ld [wStringIndex], a
    ld a, $07
    ld [wStringCategory], a
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $92
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld [hl], $09
    farcall ShowString_Bank08
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ret

; for record B draws the names of its parents (fields from $6ED2 or $6EDA by bit 4 of field $0D), or '???' when unknown (E-0131)
; 3 call sites from 3 routines (e.g. SwapMonstersMenu_Case0D_Case05, SwapMonstersMenu_Case09_Case1F, RunScreenStep_F0_5DE8_Case05_Sub01)
; reads: hTemp0, hTemp1
; writes: rRAMG2, rRAMB, wNameGlyphBuf, wArg1, wArg2, wArg3
DrawRecordParentNames::
Func_01E_6D70:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    push bc
    ld a, b
    ld c, $0D
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and a, $10
    and a, a
    jr nz, Jump_01E_6D8C
    ld de, $6ED2
    jr Jump_01E_6D8F

Jump_01E_6D8C::
    ld de, $6EDA

Jump_01E_6D8F::
    pop bc
    push bc
    ld a, [de]
    ld c, a
    ld a, b
    push de
    call LoadSRAMRecordWord
    pop de
    ldh a, [hTemp1]
    cp a, $FF
    jr nz, Jump_01E_6DC5
    ld a, $98
    ld [wNameGlyphBuf], a
    ld a, $98
    ld [wNameGlyphBuf + $1], a
    ld a, $98
    ld [wNameGlyphBuf + $2], a
    ld a, $F0
    ld [wNameGlyphBuf + $3], a
    push de
    ld de, vTiles2 + $200
    call CopyGlyphTilesToVRAM
    pop de
    pop bc
    ld a, $03
    add a, e
    ld e, a
    jr nc, Jump_01E_6DC3
    inc d

Jump_01E_6DC3::
    jr Jump_01E_6DF3

Jump_01E_6DC5::
    inc de
    pop bc
    push bc
    ld a, [de]
    ld c, a
    inc de
    push de
    ld a, b
    call CopyRecordNameToNameGlyphBuf
    ld a, $F0
    ld [wNameGlyphBuf + $A], a
    ld de, vTiles2 + $200
    call CopyGlyphTilesToVRAM
    pop de
    pop bc
    push bc
    ld a, $92
    ld [wArg1], a
    ld a, $50
    ld [wArg2], a
    ld a, [de]
    inc de
    push de
    ld [wArg3], a
    call DrawMonsterNameOfRecordField
    pop de
    pop bc

Jump_01E_6DF3::
    push bc
    ld a, [de]
    ld c, a
    inc de
    push de
    ld a, b
    call CopyRecordNameToNameGlyphBuf
    ld de, vTiles2 + $2F0
    ld a, $F0
    ld [wNameGlyphBuf + $A], a
    call CopyGlyphTilesToVRAM
    pop de
    pop bc
    push bc
    ld a, [de]
    ld c, a
    ld a, b
    push de
    call LoadSRAMRecordWord
    pop de
    ldh a, [hTemp1]
    cp a, $FF
    jr nz, Jump_01E_6E3E
    ld a, $98
    ld [wNameGlyphBuf], a
    ld a, $98
    ld [wNameGlyphBuf + $1], a
    ld a, $98
    ld [wNameGlyphBuf + $2], a
    ld a, $F0
    ld [wNameGlyphBuf + $3], a
    push de
    ld de, vTiles2 + $340
    call CopyGlyphTilesToVRAM
    pop de
    pop bc
    ld a, $03
    add a, e
    ld e, a
    jr nc, Jump_01E_6E3C
    inc d

Jump_01E_6E3C::
    jr Jump_01E_6E6C

Jump_01E_6E3E::
    inc de
    pop bc
    push bc
    ld a, [de]
    ld c, a
    inc de
    push de
    ld a, b
    call CopyRecordNameToNameGlyphBuf
    ld a, $F0
    ld [wNameGlyphBuf + $A], a
    ld de, vTiles2 + $340
    call CopyGlyphTilesToVRAM
    pop de
    pop bc
    push bc
    ld a, $93
    ld [wArg1], a
    ld a, $90
    ld [wArg2], a
    ld a, [de]
    inc de
    push de
    ld [wArg3], a
    call DrawMonsterNameOfRecordField
    pop de
    pop bc

Jump_01E_6E6C::
    push bc
    ld a, [de]
    ld c, a
    ld a, b
    call CopyRecordNameToNameGlyphBuf
    ld de, vTiles2 + $430
    ld a, $F0
    ld [wNameGlyphBuf + $A], a
    call CopyGlyphTilesToVRAM
    pop bc
    xor a, a
    ld [rRAMG2], a
    ret

; reads word field wD7F3 of record B, copies that monster name (category 2 of the bank-08 string database) to wC8CF and draws its glyphs at the address in wD7F1/2 (E-0121)
; 2 call sites from 1 routine (e.g. DrawRecordParentNames)
; reads: wArg3, hTemp0, hTemp1, wDataBank, wArg1, wArg2
; writes: wDataBank
; points at: wNameGlyphBuf
DrawMonsterNameOfRecordField::
Func_01E_6E84:: ; address name
    push bc
    ld a, [wArg3]
    ld c, a
    ld a, b
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    push hl
    ld a, [wDataBank]
    push af
    ld a, $08
    ld [wDataBank], a
    ld hl, StringDatabase
    ld bc, $0004
    add hl, bc
    call ReadWordFromDataBank
    ld e, b
    ld b, c
    ld c, e
    pop af
    pop hl
    push af
    sla l
    rl h
    add hl, bc
    call ReadWordFromDataBank
    ld e, b
    ld d, c
    pop af
    ld [wDataBank], a
    ld hl, wNameGlyphBuf
    ld b, $08
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wArg1]
    ld d, a
    ld a, [wArg2]
    ld e, a
    call CopyGlyphTilesToVRAM
    pop bc
    ret
    db $1A, $8E, $1A, $1E, $1C, $99, $1C, $29, $1C, $99, $1C, $29, $1A, $8E, $1A, $1E

; clears five tiles at vTiles2 + $290 (copying the tile at $2940), then copies the name at record [HL] field $0F (CopyRecordNameToNameGlyphBuf) and draws it there (E-0120)
; 1 call site from 1 routine (e.g. SwapMonstersMenu_Case09_Case12)
; writes: wNameGlyphBuf
DrawRecordName0FAtTiles2290::
Func_01E_6EE2:: ; address name
    push hl
    ld hl, $2940
    ld de, vTiles2 + $290
    call CopyTileBytesToVRAM_Bank1E
    ld hl, $2940
    call CopyTileBytesToVRAM_Bank1E
    ld hl, $2940
    call CopyTileBytesToVRAM_Bank1E
    ld hl, $2940
    call CopyTileBytesToVRAM_Bank1E
    ld hl, $2940
    call CopyTileBytesToVRAM_Bank1E
    pop hl
    ld a, [hl]
    ld c, $0F
    call CopyRecordNameToNameGlyphBuf
    ld de, vTiles2 + $290
    ld a, $F0
    ld [wNameGlyphBuf + $A], a
    call CopyGlyphTilesToVRAM
    ret

; only called from SwapMonstersMenu_Case09_Case13 (E-0047)
; 1 call site from 1 routine (e.g. SwapMonstersMenu_Case09_Case13)
; reads: hTemp0, hTemp1, hTemp2, wSpeciesExpCurve
; writes: wDigits, wSpeciesIdLo, wSpeciesIdHi, hTemp0, hTemp1, wArg1, wArg2, wArg3, ...
; points at: hTemp2
SwapMonstersMenu_Case09_Case13_Sub01::
Func_01E_6F17:: ; address name
    call GetListEntriesCell5Address
    push hl
    ld a, [hl]
    ld c, $58
    call LoadRecordThreeBytesToTemp0
    ldh a, [hTemp0]
    ld [wDigits], a
    ldh a, [hTemp1]
    ld [wDigits + $1], a
    ldh a, [hTemp2]
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    call UnpackBCDToDigitsArg1_Bank1E
    call BGMapAddressAtScroll_Bank1E
    ld de, $018C
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    call DrawSevenDigitsFromArg1_Bank1E
    pop hl
    push hl
    ld a, [hl]
    ld c, $56
    call LoadSRAMRecordWord
    ldh a, [hTemp1]
    ld b, a
    ldh a, [hTemp0]
    cp a, b
    jp nc, Jump_01E_6FC9
    ldh a, [hTemp0]
    ld b, a
    pop hl
    push hl
    push bc
    ld a, [hl]
    ld c, $0B
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld [wSpeciesIdLo], a
    ldh a, [hTemp1]
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wSpeciesExpCurve]
    ldh [hTemp0], a
    pop bc
    ld a, b
    ldh [hTemp1], a
    farcall LoadTable4E60EntryToTemp2
    ld de, hTemp2
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    inc de
    ld a, [de]
    ld e, a
    pop hl
    push hl
    push bc
    push de
    ld a, [hl]
    ld c, $58
    call LoadRecordThreeBytesToTemp0
    pop de
    pop bc
    ldh a, [hTemp0]
    ld l, a
    ld a, c
    sub a, l
    ld c, a
    ldh a, [hTemp1]
    ld l, a
    ld a, b
    sbc a, l
    ld b, a
    ldh a, [hTemp2]
    ld l, a
    ld a, e
    sbc a, l
    ld e, a
    ld a, c
    ld [wDigits], a
    ld a, b
    ld [wDigits + $1], a
    ld a, e
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    call UnpackBCDToDigitsArg1_Bank1E

Jump_01E_6FBA::
    call BGMapAddressAtScroll_Bank1E
    ld de, $020C
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    call DrawSevenDigitsFromArg1_Bank1E
    pop hl
    ret

Jump_01E_6FC9::
    ld a, $E3
    ld [wArg1], a
    ld [wArg2], a
    ld [wArg3], a
    ld [wArg4], a
    ld [wArg5], a
    ld [wArg6], a
    xor a, a
    ld [wArg7], a
    jr Jump_01E_6FBA

; only called from RunScreenStep_F0_5DE8_Case05 (E-0047)
; 1 call site from 1 routine (e.g. RunScreenStep_F0_5DE8_Case05)
RunScreenStep_F0_5DE8_Case05_Sub01::
Func_01E_6FE3:: ; address name
    ld b, e
    call DrawRecordParentNames
    call DrawRecordFamilyEntries_6FEB
    ret

; for record B draws the species names and marks named by the field lists $70D7 or $70DD (by bit 4 of field $0D), or a blank tile for missing entries (E-0130)
; 3 call sites from 3 routines (e.g. SwapMonstersMenu_Case0D_Case05, SwapMonstersMenu_Case09_Case1F, RunScreenStep_F0_5DE8_Case05_Sub01)
; reads: hTemp0, hTemp1, rSTAT
; writes: rRAMG2, rRAMB, wArg1, wArg5, wArg2, wArg3, wArg4
DrawRecordFamilyEntries_6FEB::
Func_01E_6FEB:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    push bc
    ld a, b
    ld c, $0D
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and a, $10
    and a, a
    jr nz, Jump_01E_7007
    ld de, $70D7
    jr Jump_01E_700A

Jump_01E_7007::
    ld de, $70DD

Jump_01E_700A::
    pop bc
    push bc
    ld a, [de]
    ld c, a
    ld a, b
    push de
    call LoadSRAMRecordWord
    pop de
    ldh a, [hTemp1]
    cp a, $FF
    jr nz, Jump_01E_702A
    push de
    ld hl, vTiles1 + $430
    ld de, vTiles2 + $6C0
    call CopyTileBytesToVRAM_Bank1E
    pop de
    inc de
    inc de
    inc de
    jr Jump_01E_7067

Jump_01E_702A::
    inc de
    pop bc
    push bc
    ld a, [de]
    ld [wArg1], a
    inc de
    ld a, [de]
    dec de
    push de
    ld [wArg5], a
    xor a, a
    ld [wArg2], a
    ld a, $6A
    ld [wArg3], a
    ld a, $6C
    ld [wArg4], a
    call LoadRecordWordFieldAndContinue710A
    pop de
    pop bc
    push bc
    call PickNameBufferForFirstByte
    inc de
    inc de
    push de
    call BGMapAddressAtScroll_Bank1E
    ld de, $006E
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di

Jump_01E_705D::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_01E_705D
    ld a, b
    ld [hl], a
    ei
    pop de

Jump_01E_7067::
    pop bc
    push bc
    ld a, [de]
    ld c, a
    ld a, b
    push de
    call LoadSRAMRecordWord
    pop de
    ldh a, [hTemp1]
    cp a, $FF
    jr nz, Jump_01E_7087
    push de
    ld hl, vTiles1 + $430
    ld de, vTiles2 + $6D0
    call CopyTileBytesToVRAM_Bank1E
    pop de
    inc de
    inc de
    inc de
    jr Jump_01E_70C3

Jump_01E_7087::
    inc de
    pop bc
    push bc
    ld a, [de]
    ld [wArg1], a
    inc de
    ld a, [de]
    dec de
    push de
    ld [wArg5], a
    ld a, $01
    ld [wArg2], a
    ld a, $8A
    ld [wArg3], a
    ld a, $6D
    ld [wArg4], a
    call LoadRecordWordFieldAndContinue710A
    pop de
    pop bc
    push bc
    call PickNameBufferForFirstByte
    push de
    call BGMapAddressAtScroll_Bank1E
    ld de, $018E
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di

Jump_01E_70B9::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_01E_70B9
    ld a, b
    ld [hl], a
    ei
    pop de

Jump_01E_70C3::
    pop bc
    xor a, a
    ld [rRAMG2], a
    ret

; BC = wCCCD when the byte at DE is $98 (the '???' placeholder), else wCDCC (E-0122)
; 2 call sites from 1 routine (e.g. DrawRecordFamilyEntries_6FEB)
; points at: wNameBufAlt, wNameBufUnknown
PickNameBufferForFirstByte::
Func_01E_70C9:: ; address name
    ld a, [de]
    cp a, $98
    jr z, Jump_01E_70D3
    ld bc, wNameBufAlt
    jr Jump_01E_70D6

Jump_01E_70D3::
    ld bc, wNameBufUnknown

Jump_01E_70D6::
    ret
    db $1A, $98, $1A, $1C, $A3, $1C, $1C, $A3, $1C, $1A, $98, $1A

; far-calls LoadRecordWordFieldArg5AndShowIcon for record B and continues at Jump_01E_710A (E-0126)
; 2 call sites from 1 routine (e.g. DrawRecordFamilyEntries_6FEB)
; reads: wArg1, hTemp0, wArg2, wArg3, rSTAT, wDigits
LoadRecordWordFieldAndContinue710A::
Func_01E_70E3:: ; address name
    push bc
    ld c, b
    farcall LoadRecordWordFieldArg5AndShowIcon
    pop bc
    jp Jump_01E_710A

; only called from SwapMonstersMenu_Case09_Case13 (E-0047)
; 1 call site from 1 routine (e.g. SwapMonstersMenu_Case09_Case13)
; reads: hTemp0, wArg4, wArg1, wArg2, wArg3, rSTAT, wDigits
; writes: wWorkBuf
SwapMonstersMenu_Case09_Case13_Sub02::
Func_01E_70EF:: ; address name
    push bc
    ld c, $0D
    ld a, b
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and a, $0F
    ld [wWorkBuf], a
    ld a, [wArg4]
    ld [wWorkBuf + $1], a
    farcall LoadFamilyIconTileForWorkBuf
    pop bc

Jump_01E_710A::
    ld a, [wArg1]
    ld c, a
    ld a, b
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and a, a
    jr nz, Jump_01E_7118
    ret

Jump_01E_7118::
    push af
    call BGMapAddressAtScroll_Bank1E
    ld a, [wArg2]
    ld d, a
    ld a, [wArg3]
    ld e, a
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di

Jump_01E_7129::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_01E_7129
    ld a, $1E
    ld [hl+], a
    ei
    pop af
    push hl
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call BlankLeadingZeroDigits_F
    pop hl
    ld a, [wDigits + $1]
    cp a, $E3
    jr z, Jump_01E_7154
    di

Jump_01E_7147::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_01E_7147
    ld a, [wDigits + $1]
    add a, $E0
    ld [hl+], a
    ei

Jump_01E_7154::
    di

Jump_01E_7155::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_01E_7155
    ld a, [wDigits + $2]
    add a, $E0
    ld [hl+], a
    ei
    ret

; wD7B0 = the number of 5-entry pages of wD7A9 records; clamps the page wD7AF and the cursor wD7AB to the last page (wD7B1) (E-0127)
; 12 call sites from 12 routines (e.g. SwapMonstersMenu_Shared02, RedrawRecordListAndNextStep, HibernateMenu_Shared01, BreedMenu_Case04_Case02, ...)
; reads: wListCount, wListPageIndex, wListCursor
; writes: wListPages, wListPageIndex, wListLastRow, wListCursor
ClampRecordListPageCursor5::
Func_01E_7163:: ; address name
    ld a, [wListCount]
    ld l, a
    ld h, $00
    ld a, $05
    call DivideHLByA
    push af
    and a, a
    jr z, Jump_01E_7173
    inc l

Jump_01E_7173::
    ld a, l
    ld [wListPages], a
    ld a, [wListPageIndex]
    inc a
    cp a, l
    jr c, Jump_01E_71AE
    pop af
    push af
    and a, a
    jr nz, Jump_01E_7193
    ld a, [wListPageIndex]
    inc a
    cp a, l
    jr z, Jump_01E_71AE
    ld a, [wListPageIndex]
    dec a
    ld [wListPageIndex], a
    jr Jump_01E_71AE

Jump_01E_7193::
    pop af
    dec a
    ld [wListLastRow], a
    ld b, a
    ld a, [wListCursor]
    cp a, b
    jr c, Jump_01E_71B4
    jr z, Jump_01E_71B4
    push bc
    push hl
    call EraseCursorAt71D7ForListCursor
    pop hl
    pop bc
    ld a, b
    ld [wListCursor], a
    jr Jump_01E_71B4

Jump_01E_71AE::
    pop af
    ld a, $04
    ld [wListLastRow], a

Jump_01E_71B4::
    ret

; writes tile $C3 at BGMapAddressAtScroll + the offset from the word table $71D7 + 2 * wD7AB (E-0120)
; 1 call site from 1 routine (e.g. ClampRecordListPageCursor5)
; reads: wListCursor
EraseCursorAt71D7ForListCursor::
Func_01E_71B5:: ; address name
    ld b, $C3
    ld a, [wListCursor]
    add a, a
    ld hl, $71D7
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1E
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret
    db $21, $00, $61, $00, $A1, $00, $E1, $00, $21, $01

; wD7B0 = the number of 4-entry pages of wD7A9 records; clamps the page wD7AF and the cursor wD7AB to the last page (wD7B1) (E-0127)
; 11 call sites from 11 routines (e.g. SwapMonstersMenu_Case07_Case30, SwapMonstersMenu_Case06_Case18, SwapMonstersMenu_Case0D_Case0E, DrawBox5022WithPageIndicator, ...)
; reads: wListCount, wListPageIndex, wListCursor
; writes: wListPages, wListPageIndex, wListLastRow, wListCursor
ClampRecordListPageCursor4::
Func_01E_71E1:: ; address name
    ld a, [wListCount]
    ld l, a
    ld h, $00
    ld a, $04
    call DivideHLByA
    push af
    and a, a
    jr z, Jump_01E_71F1
    inc l

Jump_01E_71F1::
    ld a, l
    ld [wListPages], a
    ld a, [wListPageIndex]
    inc a
    cp a, l
    jr c, Jump_01E_722C
    pop af
    push af
    and a, a
    jr nz, Jump_01E_7211
    ld a, [wListPageIndex]
    inc a
    cp a, l
    jr z, Jump_01E_722C
    ld a, [wListPageIndex]
    dec a
    ld [wListPageIndex], a
    jr Jump_01E_722C

Jump_01E_7211::
    pop af
    dec a
    ld [wListLastRow], a
    ld b, a
    ld a, [wListCursor]
    cp a, b
    jr c, Jump_01E_7232
    jr z, Jump_01E_7232
    push bc
    push hl
    call EraseCursorAt7255ForListCursor
    pop hl
    pop bc
    ld a, b
    ld [wListCursor], a
    jr Jump_01E_7232

Jump_01E_722C::
    pop af
    ld a, $03
    ld [wListLastRow], a

Jump_01E_7232::
    ret

; writes tile $C3 at BGMapAddressAtScroll + the offset from the word table $7255 + 2 * wD7AB (E-0120)
; 1 call site from 1 routine (e.g. ClampRecordListPageCursor4)
; reads: wListCursor
EraseCursorAt7255ForListCursor::
Func_01E_7233:: ; address name
    ld b, $C3
    ld a, [wListCursor]
    add a, a
    ld hl, $7255
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1E
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret
    db $28, $00, $68, $00, $A8, $00, $E8, $00

; writes the record's level (field $56, marked $6F at the cap in field $57) and its status marks into the BG map at scroll + $29 (E-0130)
; 3 call sites from 3 routines (e.g. DrawListEntriesCell5RecordDetails, SwapMonstersMenu_Case09_Case1D, SwapMonstersMenu_Case09_Case16)
; reads: hTemp1, hTemp0, wDigits
DrawRecordLevelAndStatusRow_1E::
Func_01E_725D:: ; address name
    push hl
    ld a, [hl]
    ld c, $56
    ld b, $02
    call LoadSRAMRecordWord
    call BGMapAddressAtScroll_Bank1E
    ld de, $0029
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    ldh a, [hTemp1]
    ld b, a
    ldh a, [hTemp0]
    cp a, b
    jr c, Jump_01E_7282
    di
    call WaitForVRAMAccess
    ld a, $6F
    ld [hl], a
    ei
    jr Jump_01E_728A

Jump_01E_7282::
    di
    call WaitForVRAMAccess
    ld a, $C3
    ld [hl], a
    ei

Jump_01E_728A::
    inc hl
    di
    call WaitForVRAMAccess
    ld a, $EA
    ld [hl+], a
    ld a, $ED
    ld [hl+], a
    ei
    push hl
    ldh a, [hTemp0]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call BlankLeadingZeroDigits_F
    pop hl
    ld a, [wDigits + $1]
    add a, $E0
    ld e, a
    di
    call WaitForVRAMAccess
    ld [hl], e
    ei
    inc hl
    ld a, [wDigits + $2]
    add a, $E0
    ld e, a
    di
    call WaitForVRAMAccess
    ld [hl], e
    ei
    inc hl
    ld e, l
    ld d, h
    pop hl
    push hl
    push de
    ld a, [hl]
    ld c, $55
    call LoadSRAMRecordByte
    pop de
    ld l, e
    ld h, d
    call WriteThreeC3TilesAtHL_Bank1E
    ldh a, [hTemp0]
    push af
    bit 0, a
    call nz, WriteTileC0AtHL_Bank1E
    pop af
    inc hl
    push af
    bit 2, a
    call nz, WriteTileC1AtHL_Bank1E
    pop af
    inc hl
    bit 7, a
    call nz, WriteTileC2AtHL_Bank1E
    inc hl
    inc hl
    ld e, l
    ld d, h
    pop hl
    push hl
    push de
    ld a, [hl]
    ld c, $0E
    ld b, $01
    call LoadSRAMRecordByte
    pop de
    ld l, e
    ld h, d
    ldh a, [hTemp0]
    and a, $01
    add a, $CC
    ld e, a
    di
    call WaitForVRAMAccess
    ld [hl], e
    ei
    pop hl
    ret

; writes tile $C3 to the 3 VRAM bytes from HL (WaitForVRAMAccess, interrupts off per byte); HL kept; clobbers C, E (E-0067) (the same 17 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. DrawRecordLevelAndStatusRow_1E)
WriteThreeC3TilesAtHL_Bank1E::
Func_01E_7306:: ; address name
    push hl
    ld e, $C3
    ld c, $03

Jump_01E_730B::
    di
    call WaitForVRAMAccess
    ld [hl], e
    ei
    inc hl
    dec c
    jr nz, Jump_01E_730B
    pop hl
    ret

; writes tile $C0 at VRAM address HL (WaitForVRAMAccess, interrupts off) (E-0067) (the same 9 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. DrawRecordLevelAndStatusRow_1E)
WriteTileC0AtHL_Bank1E::
Func_01E_7317:: ; address name
    di
    call WaitForVRAMAccess
    ld a, $C0
    ld [hl], a
    ei
    ret

; writes tile $C1 at VRAM address HL (WaitForVRAMAccess, interrupts off) (E-0067) (the same 9 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. DrawRecordLevelAndStatusRow_1E)
WriteTileC1AtHL_Bank1E::
Func_01E_7320:: ; address name
    di
    call WaitForVRAMAccess
    ld a, $C1
    ld [hl], a
    ei
    ret

; writes tile $C2 at VRAM address HL (WaitForVRAMAccess, interrupts off) (E-0067) (the same 9 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. DrawRecordLevelAndStatusRow_1E)
WriteTileC2AtHL_Bank1E::
Func_01E_7329:: ; address name
    di
    call WaitForVRAMAccess
    ld a, $C2
    ld [hl], a
    ei
    ret

; only called from DrawListEntriesCell5RecordDetails (E-0047)
; 1 call site from 1 routine (e.g. DrawListEntriesCell5RecordDetails)
; reads: hTemp0, hTemp1, wDigits
DrawListEntriesCell5RecordDetails_Sub01::
Func_01E_7332:: ; address name
    push hl
    call BGMapAddressAtScroll_Bank1E
    ld de, $0070
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    ld e, l
    ld d, h
    pop hl
    ld c, $00

Jump_01E_7342::
    push bc
    push hl
    push de
    ld a, c
    ld de, $7394
    add a, e
    ld e, a
    jr nc, Jump_01E_734E
    inc d

Jump_01E_734E::
    ld a, [de]
    ld c, a
    ld a, [hl]
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    call HLToDecimalDigits
    call BlankLeadingZeroDigits_F
    pop de
    ld l, e
    ld h, d
    di
    call WaitForVRAMAccess
    ld a, [wDigits]
    add a, $E0
    ld [hl+], a
    ei
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
    ld [hl+], a
    ei
    ld a, $40
    add a, e
    ld e, a
    jr nc, Jump_01E_738B
    inc d

Jump_01E_738B::
    pop hl
    pop bc
    inc c
    ld a, c
    cp a, $05
    jr c, Jump_01E_7342
    ret
    db $63, $65, $67, $69, $6B

; only called from DrawListEntriesCell5RecordDetails (E-0047)
; 1 call site from 1 routine (e.g. DrawListEntriesCell5RecordDetails)
; reads: hTemp0, hTemp1, wDigits
DrawListEntriesCell5RecordDetails_Sub02::
Func_01E_7399:: ; address name
    ld c, $00

Jump_01E_739B::
    push hl
    ld a, [hl]
    ld b, a
    push bc
    ld a, c
    ld hl, $73FA
    add_a_to_hl
    ld a, [hl]
    ld c, a
    ld a, b
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    call HLToDecimalDigits
    call BlankLeadingZeroDigits_F
    pop bc
    ld a, c
    add a, a
    ld hl, $73FE
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1E
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, [wDigits]
    add a, $E0
    ld [hl+], a
    ei
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
    pop hl
    inc c
    ld a, c
    cp a, $04
    jr c, Jump_01E_739B
    ret
    db $5B, $5D, $5F, $61, $CC, $01, $D0, $01, $0C, $02, $10, $02

; stores tile $C3 at the addresses of entries 0 to C - 1 of the word table at HL (E-0122)
; 1 call site from 1 routine (e.g. SwapMonstersMenu_Case09_Case0D)
EraseCEntriesOfWordTable_Bank1E::
Func_01E_7406:: ; address name
    ld a, c
    ld b, a
    ld c, $00

Jump_01E_740A::
    ld a, c
    push bc
    ld b, $C3
    push hl
    call StoreBAtWordTableEntry_Bank1E
    pop hl
    pop bc
    inc c
    ld a, c
    cp a, b
    jr c, Jump_01E_740A
    ret

; HL = table of 16-bit addresses, A = index: stores B at the address in entry A; keeps BC; clobbers A, DE, HL (the same 14 bytes appear in 8 banks)
; 41 call sites from 29 routines (e.g. SwapMonstersMenu_Case02, SwapMonstersMenu_Case04_Case22, SwapMonstersMenu_Case04_Case10, SwapMonstersMenu_Case04_Case05, ...)
StoreBAtWordTableEntry_Bank1E::
Func_01E_741A:: ; address name
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

; DE = source, HL = destination, BC = count: copies BC bytes (BC = 0 copies 65536); DE and HL end past the copy; clobbers A, BC = 0 (E-0064) (the same 9 bytes appear in 13 banks)
; 4 call sites from 4 routines (e.g. CloseMenuE9_Case00, SwapMonstersMenu_Case00, SwapMonstersMenu_Case04_Case12_Sub01_Sub01, CopyScreenBufferRectWithAttrs_1E)
CopyBytesDEToHL_Bank1E::
Func_01E_7428:: ; address name
    ld a, [de]
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, CopyBytesDEToHL_Bank1E
    ret

; With rSVBK = 2, copies BC bytes from [DE] to [HL], each ANDed with $07; then rSVBK = 0 (the same 18 bytes appear in 7 banks)
; 3 call sites from 3 routines (e.g. CloseMenuE9_Case00, SwapMonstersMenu_Case00, CopyScreenBufferRectWithAttrs_1E)
; writes: rSVBK
CopyLow3BitsToWRAMBank2_Bank1E::
Func_01E_7431:: ; address name
    ld a, $02
    ldh [rSVBK], a

Jump_01E_7435::
    ld a, [de]
    and a, $07
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_01E_7435
    xor a, a
    ldh [rSVBK], a
    ret

; Copies 16 bytes from [HL] to [DE]; each byte is written with interrupts off after waiting for rSTAT bit 1 to clear; clobbers A, C; HL and DE advance (the same 17 bytes appear in 7 banks)
; 7 call sites from 2 routines (e.g. DrawRecordFamilyEntries_6FEB, DrawRecordName0FAtTiles2290)
; reads: rSTAT
CopyTileBytesToVRAM_Bank1E::
Func_01E_7443:: ; address name
    ld c, $10

Jump_01E_7445::
    di

Jump_01E_7446::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_01E_7446
    ld a, [hl+]
    ld [de], a
    inc de
    ei
    dec c
    jr nz, Jump_01E_7445
    ret

; only called from routines of SwapMonstersMenu (E-0098)
; 14 call sites from 14 routines (e.g. SwapMonstersMenu_Case01_Case01, SwapMonstersMenu_Case05_Case3B, SwapMonstersMenu_Case04_Case0A, SwapMonstersMenu_Case04_Case20, ...)
; writes: wGlyphListPos
SwapMonstersMenu_Shared05::
Func_01E_7454:: ; address name
    ld b, $00

Jump_01E_7456::
    push bc
    push hl
    push de
    ld a, b
    add a, a
    add_a_to_hl
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_01E_7486
    ld e, a
    ld a, [hl]
    ld h, a
    ld l, e
    pop de
    push de
    push hl
    ld l, e
    ld h, d
    ld a, b
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    pop de
    pop hl
    pop bc
    inc b
    jr Jump_01E_7456

Jump_01E_7486::
    pop de
    pop hl
    pop bc
    xor a, a
    ld [wGlyphListPos], a
    ret

; Copies a rectangle of B bytes by C rows from [DE] to [HL], rows 20 ($14) bytes apart; on CGB it then zero-fills the same-shaped rectangle at HL + $0E68 with rSVBK = 2 and restores rSVBK = 0 (the same 58 bytes appear in 8 banks)
; 33 call sites from 27 routines (e.g. SwapMonstersMenu_Case01_Case03, SwapMonstersMenu_Case04_Case22, SwapMonstersMenu_Case04_Case00, SwapMonstersMenu_Case05_Case3C, ...)
; reads: wIsCGB
; writes: rSVBK
CopyRectTo20ByteRows_Bank1E::
Func_01E_748E:: ; address name
    push hl
    push bc

Jump_01E_7490::
    push bc
    push hl

Jump_01E_7492::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_01E_7492
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_01E_7490
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

Jump_01E_74B4::
    push bc
    push hl

Jump_01E_74B6::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_01E_74B6
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_01E_74B4
    xor a, a
    ldh [rSVBK], a
    ret

; DE = offset into wScreenTileBuffer, B = width, C = rows, HL = BG map address: CopyRectToBGMapWrapped from wScreenTileBuffer + DE; on CGB the same rectangle is then copied from wD000 + DE (rSVBK = 2) into VRAM bank 1, the attributes; on DMG BC, DE and HL are kept. wC554/wC555 = HL + $1C1 only when HL = $9800 (E-0062)
; 38 call sites from 33 routines (e.g. CloseMenuE9_Case00, SwapMonstersMenu_Case01_Case03, SwapMonstersMenu_Case04_Case27, SwapMonstersMenu_Case04_Case22, ...)
; reads: wIsCGB
; writes: wTextCursorLo, wTextCursorHi, rVBK, rSVBK
; points at: wScreenTileBuffer, wScreenAttrBuffer
DrawScreenBufferRect_Bank1E::
Func_01E_74C8:: ; address name
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
    cp a, $00
    jr nz, Jump_01E_74EE
    ld a, h
    cp a, $98
    jr nz, Jump_01E_74EE
    ld a, l
    add a, $C1
    ld [wTextCursorLo], a
    ld a, h
    adc a, $01
    ld [wTextCursorHi], a

Jump_01E_74EE::
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

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX, hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
; 86 call sites from 67 routines (e.g. CloseMenuE9_Case00, SwapMonstersMenu_Case02_Sub04, EraseCursorAt7255ForListCursor, DrawPageOfPagesAtScrollOffset, ...)
; reads: hScrollY, hScrollX
BGMapAddressAtScroll_Bank1E::
Func_01E_750F:: ; address name
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

; draws tiles $C5, $BE, $C6 at BGMapAddressAtScroll + DE, two entries apart (WaitForVRAMAccess, interrupts off), through StepBGMapAddressBackOnScrollWrap (E-0120)
; 4 call sites from 4 routines (e.g. SwapMonstersMenu_Shared02, SwapMonstersMenu_Case07_Case30, SwapMonstersMenu_Case06_Case18, SwapMonstersMenu_Case09_Case03)
DrawC5BEC6AtScrollOffsetDE_Bank1E::
Func_01E_7530:: ; address name
    push de
    call BGMapAddressAtScroll_Bank1E
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
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
; 4 call sites from 4 routines (e.g. SwapMonstersMenu_Shared02, SwapMonstersMenu_Case07_Case30, SwapMonstersMenu_Case06_Case18, SwapMonstersMenu_Case0D_Case0E)
StoreC5BEC6AtHLStride2_Bank1E::
Func_01E_7556:: ; address name
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

; HL = BGMapAddressAtScroll + the offset in wD7F1 (high) / wD7F2 (low): writes tile $E0 + wD7AF + 1 there and tile $E0 + wD7B0 two entries later, each through StepBGMapAddressBackOnScrollWrap and WaitForVRAMAccess (current page and page count) (E-0106)
; 11 call sites from 11 routines (e.g. SwapMonstersMenu_Shared02, SwapMonstersMenu_Case07_Case30, SwapMonstersMenu_Case06_Case18, SwapMonstersMenu_Case09_Case03, ...)
; reads: wArg1, wArg2, wListPageIndex, wListPages
DrawPageOfPagesAtScrollOffset::
Func_01E_7564:: ; address name
    ld a, [wArg1]
    ld d, a
    ld a, [wArg2]
    ld e, a
    push de
    call BGMapAddressAtScroll_Bank1E
    pop de
    add hl, de
    push hl
    call StepBGMapAddressBackOnScrollWrap
    ld a, [wListPageIndex]
    inc a
    ld b, a
    di
    call WaitForVRAMAccess
    ld a, b
    add a, $E0
    ld [hl], a
    ei
    pop hl
    inc hl
    inc hl
    push hl
    ld a, [wListPages]
    ld b, a
    pop hl
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    add a, $E0
    ld [hl], a
    ei
    ret

; HL = the address in wD7F1 (high) / wD7F2 (low): writes tile $E0 + wD7AF + 1 there and tile $E0 + wD7B0 two bytes later (current page and page count, 1-based display) (E-0093) (the same 25 bytes appear in 2 banks)
; 20 call sites from 20 routines (e.g. SwapMonstersMenu_Shared02, SwapMonstersMenu_Case07_Case30, SwapMonstersMenu_Case06_Case18, SwapMonstersMenu_Case0D_Case0E, ...)
; reads: wArg1, wArg2, wListPageIndex, wListPages
DrawPageOfPagesAtArg1_Bank1E::
Func_01E_759A:: ; address name
    ld a, [wArg1]
    ld h, a
    ld a, [wArg2]
    ld l, a
    ld a, [wListPageIndex]
    inc a
    add a, $E0
    ld [hl+], a
    inc hl
    ld a, [wListPages]
    ld b, a
    ld a, b
    add a, $E0
    ld [hl], a
    ret

; when wC8C0 is 0 it becomes $E3, and then when wC8C1 is 0 too it becomes $E3 (the same effect as the bank-$15 copy, coded through HL): leading zeros become the blank tile once $E0 is added (E-0093)
; 21 call sites from 16 routines (e.g. SwapMonstersMenu_Case07_Case2F, SwapMonstersMenu_Case07_Case17, SwapMonstersMenu_Case06_Case13, SwapMonstersMenu_Case06_Case0D, ...)
; points at: wDigits
BlankLeadingZeroDigits_F::
Func_01E_75B3:: ; address name
    ld hl, wDigits
    ld a, [hl]
    and a, a
    jr nz, Jump_01E_75C4
    add a, $E3
    ld [hl+], a
    ld a, [hl]
    and a, a
    jr nz, Jump_01E_75C4
    add a, $E3
    ld [hl], a

Jump_01E_75C4::
    ret

; wD09D = field $0D of SRAM record B & $0F (its family), wD09E = $C7, then LoadFamilyIconTileForWorkBuf (E-0122)
; 8 call sites from 7 routines (e.g. SwapMonstersMenu_Case04_Case01, SwapMonstersMenu_Case04_Case17, SwapMonstersMenu_Case06_Case08, SwapMonstersMenu_Case08_Case0D, ...)
; reads: hTemp0
; writes: rRAMG2, rRAMB, wWorkBuf
LoadFamilyIconTileForRecordB_Bank1E::
Func_01E_75C5:: ; address name
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

; far-calls Func_01D_5B4D (E-0122)
; 5 call sites from 5 routines (e.g. SwapMonstersMenu_Case04_Case01, SwapMonstersMenu_Case04_Case17, SwapMonstersMenu_Case06_Case08, ListRecordsAndDrawListEntriesCell5Panel, ...)
CallFunc5B4DInBank1D::
Func_01E_75EB:: ; address name
    farcall DrawRecordStatsBoxForArg1
    ret

; copies a wD7F1 x wD7F2 block inside the screen buffer from offset DE to offset HL, C rows, with CGB attributes (E-0127)
; 5 call sites from 5 routines (e.g. DrawBox4718AndMenuAndStep_1E, SwapMonstersMenu_Shared03, SwapMonstersMenu_Case04_Case06, SwapMonstersMenu_Case06_Case0D, ...)
; reads: wArg1, wArg2, wIsCGB
; points at: wScreenTileBuffer, wScreenAttrBuffer
CopyScreenBufferRectWithAttrs_1E::
Func_01E_75F2:: ; address name
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
    call CopyBytesDEToHL_Bank1E
    pop de
    pop hl
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_01E_7633
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
    call CopyLow3BitsToWRAMBank2_Bank1E
    pop de
    pop hl

Jump_01E_7633::
    pop bc
    ld a, $14
    add_a_to_hl
    ld a, $14
    add a, e
    ld e, a
    jr nc, Jump_01E_7642
    inc d

Jump_01E_7642::
    dec c
    jr nz, CopyScreenBufferRectWithAttrs_1E
    ret

; only called from routines of SwapMonstersMenu (E-0098)
; 2 call sites from 2 routines (e.g. SwapMonstersMenu_Case0E_Case07_Sub01, SwapMonstersMenu_Case08_Case03)
; reads: hTemp0, rSTAT, wPartyCount
; writes: rRAMG2, rRAMB
; points at: wListEntries
SwapMonstersMenu_Shared07::
Func_01E_7646:: ; address name
    ld b, $00

Jump_01E_7648::
    push bc
    push hl
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld hl, wListEntries
    ld a, b
    add_a_to_hl
    ld a, [hl]
    ld c, $00
    ld b, $01
    call LoadSRAMRecordByte
    xor a, a
    ld [rRAMG2], a
    ldh a, [hTemp0]
    cp a, $02
    jr nz, Jump_01E_7684
    pop hl
    pop bc
    push bc
    di

Jump_01E_7672::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_01E_7672
    ld a, b
    add a, $E1
    ld [hl], a
    ei
    ld a, c
    add_a_to_hl
    push hl

Jump_01E_7684::
    pop hl
    pop bc
    inc b
    ld a, [wPartyCount]
    cp a, b
    jr nz, Jump_01E_7648
    ret

; the same 57 bytes as UnpackBCDToDigitsArg1 (15:6676)
; 6 call sites from 4 routines (e.g. SwapMonstersMenu_Case09_Case13_Sub01, ArenaMenu_Shared02, ShopMenu_Case03_Case05, DrawWCA83ExpAndToNextLevel)
; points at: hTemp3, wArg1
UnpackBCDToDigitsArg1_Bank1E::
Func_01E_768E:: ; address name
    ld de, hTemp3
    ld hl, wArg1
    ld a, [de]
    ld [hl+], a
    dec de
    ld a, [de]
    and a, $F0
    swap a
    ld [hl+], a
    ld a, [de]
    and a, $0F
    ld [hl+], a
    dec de
    ld a, [de]
    and a, $F0
    swap a
    ld [hl+], a
    ld a, [de]
    and a, $0F
    ld [hl+], a
    dec de
    ld a, [de]
    and a, $F0
    swap a
    ld [hl+], a
    ld a, [de]
    and a, $0F
    ld [hl], a
    ld c, $06
    ld hl, wArg1

Jump_01E_76BC::
    ld a, [hl]
    and a, a
    jr nz, Jump_01E_76C6
    add a, $E3
    ld [hl+], a
    dec c
    jr nz, Jump_01E_76BC

Jump_01E_76C6::
    ret

; HL = VRAM address: writes the 7 bytes at wD7F1 as tiles $E0 + digit to HL onward (WaitForVRAMAccess, interrupts off per byte) (E-0067) (the same 19 bytes appear in 2 banks)
; 2 call sites from 1 routine (e.g. SwapMonstersMenu_Case09_Case13_Sub01)
; points at: wArg1
DrawSevenDigitsFromArg1_Bank1E::
Func_01E_76C7:: ; address name
    ld de, wArg1
    ld c, $07

Jump_01E_76CC::
    di
    call WaitForVRAMAccess
    ld a, [de]
    add a, $E0
    ld [hl+], a
    inc de
    ei
    dec c
    jr nz, Jump_01E_76CC
    ret

; A = record, C = field offset (SRAMRecordAddress), B = count: copies B bytes from hFFC6 onward into the SRAM record (SRAM must be enabled); DE and HL kept (E-0074)
; 9 call sites from 4 routines (e.g. SwapMonstersMenu_Case04_Case29, SwapMonstersMenu_Case04_Case0F, SwapMonstersMenu_Case05_Case48, SwapMonstersMenu_Case05_Case16)
; points at: hTemp0
StoreTemp0BytesToSRAMRecord::
Func_01E_76DA:: ; address name
    push hl
    push de
    call SRAMRecordAddress
    ld de, hTemp0

Jump_01E_76E2::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_01E_76E2
    pop de
    pop hl
    ret

; far-calls SetArg5ToListEntriesCell5, then HL = wD7F5 (high) / wD7F6 (low) (E-0075)
; 30 call sites from 25 routines (e.g. SwapMonstersMenu_Case04_Case29, SwapMonstersMenu_Case04_Case28, SwapMonstersMenu_Case05_Case48, SwapMonstersMenu_Case05_Case16, ...)
; reads: wArg5, wArg6
GetListEntriesCell5Address::
Func_01E_76EB:: ; address name
    farcall SetArg5ToListEntriesCell5
    jr Jump_01E_76F9

; far-calls SetArg5ToListEntriesCell4, then HL = wD7F5 (high) / wD7F6 (low) (E-0075)
; 8 call sites from 7 routines (e.g. SwapMonstersMenu_Case07_Case33, SwapMonstersMenu_Case08_Case0D, SwapMonstersMenu_Case0D_Case07, SwapMonstersMenu_Case0D_Case06, ...)
; reads: wArg5, wArg6
GetListEntriesCell4Address::
Func_01E_76F3:: ; address name
    farcall SetArg5ToListEntriesCell4

Jump_01E_76F9::
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ret

; only called from routines of SwapMonstersMenu (E-0098)
; 4 call sites from 4 routines (e.g. SwapMonstersMenu_Case0E_Case06_Case03, SwapMonstersMenu_Case0E_Case15_Case03, SwapMonstersMenu_Case0E_Case1B_Case03, SwapMonstersMenu_Case0E_Case20_Case03)
; writes: wWindowTileBuffer
SwapMonstersMenu_Shared06::
Func_01E_7702:: ; address name
    call BGMapAddressAtScroll_Bank1E
    ld de, $0020
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    ld c, $05

Jump_01E_770E::
    di
    call WaitForVRAMAccess
    ld a, $B6
    ld [hl], a
    ei
    ld a, $40
    add_a_to_hl
    dec c
    jr nz, Jump_01E_770E
    ld a, $B6
    ld [wWindowTileBuffer + $78], a
    ld [wWindowTileBuffer + $A0], a
    ld [wWindowTileBuffer + $C8], a
    ld [wWindowTileBuffer + $F0], a
    ld [wWindowTileBuffer + $118], a
    ret

; wD7AF = wD7AB / 4 and wD7AB = wD7AB mod 4 (DivideHLByA) (E-0067) (the same 19 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. SwapMonstersMenu_Case0D_Case07)
; reads: wListCursor
; writes: wListCursor, wListPageIndex
SplitListCursorBy4_Bank1E::
Func_01E_7732:: ; address name
    ld a, [wListCursor]
    ld l, a
    ld h, $00
    ld a, $04
    call DivideHLByA
    ld [wListCursor], a
    ld a, l
    ld [wListPageIndex], a
    ret

; wD7BC = hFFB9, then hFFB9 = hFFBA = 0; wD7BA = hFF8D, wD7BB = wSpriteSlotCount; then hFF8D = $FF and wSpriteSlotCount = 0 (E-0078) (the same 30 bytes appear in 2 banks)
; 10 call sites from 10 routines (e.g. SwapMonstersMenu_Case06_Case1B, SwapMonstersMenu_Case06_Case14, SwapMonstersMenu_Case04_Case0C, EggServiceMenu_Case05_Case0C, ...)
; reads: hSpriteWindowClipMode, hFieldDrawFlags, wSpriteSlotCount
; writes: wSavedSpriteClipMode, hSpriteWindowClipMode, hSpriteHideTile, wSavedFieldDrawFlags, wSavedSpriteSlotCount, hFieldDrawFlags, wSpriteSlotCount
SaveAndHideSpriteState_Bank1E::
Func_01E_7745:: ; address name
    ldh a, [hSpriteWindowClipMode]
    ld [wSavedSpriteClipMode], a
    xor a, a
    ldh [hSpriteWindowClipMode], a
    ldh [hSpriteHideTile], a
    ldh a, [hFieldDrawFlags]
    ld [wSavedFieldDrawFlags], a
    ld a, [wSpriteSlotCount]
    ld [wSavedSpriteSlotCount], a
    ld a, $FF
    ldh [hFieldDrawFlags], a
    xor a, a
    ld [wSpriteSlotCount], a
    ret

; hFFB9 = wD7BC, hFFBA = $80, hFF8D = wD7BA, wSpriteSlotCount = wD7BB: puts back the values SaveAndHideSpriteState stored (hFFBA is set to $80 rather than restored) (E-0078)
; 5 call sites from 5 routines (e.g. SwapMonstersMenu_Case08_Case0D, SwapMonstersMenu_Case0D_Case11, SwapMonstersMenu_Case09_Case0D, EggServiceMenu_Case0F_Case08, ...)
; reads: wSavedSpriteClipMode, wSavedFieldDrawFlags, wSavedSpriteSlotCount
; writes: hSpriteWindowClipMode, hSpriteHideTile, hFieldDrawFlags, wSpriteSlotCount
RestoreSpriteStateFromSavedFieldDrawFlags::
Func_01E_7763:: ; address name
    ld a, [wSavedSpriteClipMode]
    ldh [hSpriteWindowClipMode], a
    ld a, $80
    ldh [hSpriteHideTile], a
    ld a, [wSavedFieldDrawFlags]
    ldh [hFieldDrawFlags], a
    ld a, [wSavedSpriteSlotCount]
    ld [wSpriteSlotCount], a
    ret

; stores tile $C3 at the addresses in entries 0 and 1 of the table at $788A (StoreBAtWordTableEntry_Bank1E) (E-0118)
; 3 call sites from 2 routines (e.g. SwapMonstersMenu_Case06_Case02, SwapMonstersMenu_Case07_Case02)
BlankTwoTableEntries788A::
Func_01E_7778:: ; address name
    xor a, a
    ld b, $C3
    ld hl, CursorCellTable788A
    call StoreBAtWordTableEntry_Bank1E
    ld a, $01
    ld b, $C3
    ld hl, CursorCellTable788A
    call StoreBAtWordTableEntry_Bank1E
    ret

; E-0200 (C1: passed in HL, with GlyphCopySrcList0 in DE, to SwapMonstersMenu_Shared05, which copies 16 bytes from bank $1F at each source to each destination until a destination of $FFFF).
; record: 32 VRAM tile addresses, then $FFFF
GlyphCopyDestList0::
Data_01E_778C:: ; address name
    dw vTiles1 + $240, vTiles1 + $250, vTiles1 + $260, vTiles1 + $270, vTiles1 + $280, vTiles1 + $290, vTiles1 + $2A0, vTiles1 + $2B0 ; entry 0
    dw vTiles1 + $2C0, vTiles1 + $2D0, vTiles1 + $2E0, vTiles1 + $2F0, vTiles1 + $6E0, vTiles1 + $6F0, vTiles1 + $700, vTiles1 + $710
    dw vTiles1 + $720, vTiles1 + $730, vTiles1 + $740, vTiles1 + $750, vTiles1 + $760, vTiles1 + $770, vTiles1 + $780, vTiles1 + $790
    dw vTiles1 + $7A0, vTiles1 + $7B0, vTiles1 + $7C0, vTiles1 + $7D0, vTiles1 + $7E0, vTiles1 + $7F0, vTiles1 + $6B0, vTiles2 + $760
    dw rIE

; E-0200 (C1: the source list paired with GlyphCopyDestList0; its own $FFFF is not read).
; record: 32 source addresses in bank $1F, then $FFFF (not read)
GlyphCopySrcList0::
Data_01E_77CE:: ; address name
    dw $41C0, $42D0, $4330, $4340, $42A0, $40E0, $4270, $42F0 ; entry 0
    dw $4390, $40D0, $42C0, $4360, $4300, $4250, $40F0, $43C0
    dw $4380, $4180, $41A0, $4120, $4170, $41A0, $4910, $4910
    dw $4910, $4910, $4910, $4910, $4910, $4910, $4910, $4A40
    dw $FFFF

; E-0200 (C1: passed in HL, with GlyphCopySrcList1 in DE, to SwapMonstersMenu_Shared05, which copies 16 bytes from bank $1F at each source to each destination until a destination of $FFFF).
; record: 9 VRAM tile addresses, then $FFFF
GlyphCopyDestList1::
Data_01E_7810:: ; address name
    dw vTiles1 + $270, vTiles1 + $280, vTiles1 + $290, vTiles1 + $2A0, vTiles1 + $2B0, vTiles1 + $2C0, vTiles1 + $2D0, vTiles1 + $2E0 ; entry 0
    dw vTiles1 + $2F0, rIE

; E-0200 (C1: the source list paired with GlyphCopyDestList1; its own $FFFF is not read).
; record: 9 source addresses in bank $1F, then $FFFF (not read)
GlyphCopySrcList1::
Data_01E_7824:: ; address name
    dw $4340, $42A0, $40E0, $4270, $42F0, $4390, $40D0, $42C0 ; entry 0
    dw $4360, $FFFF

; E-0200 (C1: passed in HL, with GlyphCopySrcList2 in DE, to SwapMonstersMenu_Shared05, which copies 16 bytes from bank $1F at each source to each destination until a destination of $FFFF).
; record: 10 VRAM tile addresses, then $FFFF
GlyphCopyDestList2::
Data_01E_7838:: ; address name
    dw vTiles1 + $240, vTiles1 + $250, vTiles1 + $260, vTiles1 + $700, vTiles1 + $710, vTiles1 + $720, vTiles1 + $730, vTiles1 + $740 ; entry 0
    dw vTiles1 + $4E0, vTiles1 + $4F0, rIE

; E-0200 (C1: the source list paired with GlyphCopyDestList2; its own $FFFF is not read).
; record: 10 source addresses in bank $1F, then $FFFF (not read)
GlyphCopySrcList2::
Data_01E_784E:: ; address name
    dw $41C0, $42D0, $4330, $40F0, $43C0, $4380, $4180, $41A0 ; entry 0
    dw $4230, $4290, $FFFF

; E-0200 (C1: passed in HL, with GlyphCopySrcList3 in DE, to SwapMonstersMenu_Shared05, which copies 16 bytes from bank $1F at each source to each destination until a destination of $FFFF).
; record: 6 VRAM tile addresses, then $FFFF
GlyphCopyDestList3::
Data_01E_7864:: ; address name
    dw vTiles2 + $700, vTiles2 + $710, vTiles2 + $720, vTiles2 + $730, vTiles2 + $740, vTiles2 + $750, rIE ; entry 0

; E-0200 (C1: the source list paired with GlyphCopyDestList3; its own $FFFF is not read).
; record: 6 source addresses in bank $1F, then $FFFF (not read)
GlyphCopySrcList3::
Data_01E_7872:: ; address name
    dw $4130, $4320, $42A0, $4330, $4190, $4150, $FFFF ; entry 0

; E-0200 (C1: StoreBAtWordTableEntry_Bank1E writes a tile at entry wD7AB of $7880 (cursor blanking); entries from 5 on are the table at $788A).
; record: screen buffer address
CursorCellTable7880::
Data_01E_7880:: ; address name
    dw wWindowTileBuffer + $79 ; id 0
    dw wWindowTileBuffer + $A1 ; id 1
    dw wWindowTileBuffer + $C9 ; id 2
    dw wWindowTileBuffer + $F1 ; id 3
    dw wWindowTileBuffer + $119 ; id 4

; E-0200 (C1: BlankTwoTableEntries788A stores tile $C3 at entries 0 and 1 through StoreBAtWordTableEntry_Bank1E; 7 words end at GlyphCopyDestList4).
; record: screen buffer address
CursorCellTable788A::
Data_01E_788A:: ; address name
    dw wWindowTileBuffer + $120 ; id 0
    dw wWindowTileBuffer + $148 ; id 1
    dw wWindowTileBuffer + $80 ; id 2
    dw wWindowTileBuffer + $A8 ; id 3
    dw wWindowTileBuffer + $D0 ; id 4
    dw wWindowTileBuffer + $F8 ; id 5
    dw wWindowTileBuffer + $120 ; id 6

; E-0200 (C1: passed in HL, with GlyphCopySrcList4 in DE, to SwapMonstersMenu_Shared05, which copies 16 bytes from bank $1F at each source to each destination until a destination of $FFFF).
; record: 32 VRAM tile addresses, then $FFFF
GlyphCopyDestList4::
Data_01E_7898:: ; address name
    dw vTiles2 + $20, vTiles2 + $30, vTiles2 + $40, vTiles2 + $50, vTiles2 + $60, vTiles2 + $70, vTiles2 + $80, vTiles2 + $90 ; entry 0
    dw vTiles2 + $A0, vTiles2 + $B0, vTiles2 + $C0, vTiles2 + $D0, vTiles2 + $E0, vTiles2 + $F0, vTiles2 + $100, vTiles2 + $110
    dw vTiles2 + $120, vTiles2 + $130, vTiles2 + $140, vTiles2 + $150, vTiles2 + $160, vTiles2 + $170, vTiles2 + $180, vTiles2 + $190
    dw vTiles2 + $1A0, vTiles2 + $1B0, vTiles2 + $1C0, vTiles2 + $1D0, vTiles2 + $1E0, vTiles2 + $1F0, vTiles2 + $6F0, vTiles1 + $7F0
    dw rIE

; E-0200 (C1: the source list paired with GlyphCopyDestList4; its own $FFFF is not read).
; record: 32 source addresses in bank $1F, then $FFFF (not read)
GlyphCopySrcList4::
Data_01E_78DA:: ; address name
    dw $40B0, $41E0, $4150, $40E0, $40F0, $4100, $4110, $4160 ; entry 0
    dw $4130, $4180, $4210, $4170, $4290, $43C0, $4380, $43A0
    dw $4300, $40C0, $4250, $4370, $4910, $4910, $4910, $4910
    dw $4910, $4910, $4910, $4910, $4A30, $4910, $4AD0, $4A70
    dw $FFFF

; E-0200 (C1: the source list paired with GlyphCopyDestList5; its own $FFFF is not read).
; record: 15 source addresses in bank $1F, then $FFFF (not read)
GlyphCopySrcList5::
Data_01E_791C:: ; address name
    dw $4170, $4330, $4320, $4380, $4370, $4290, $4360, $40F0 ; entry 0
    dw $42B0, $4130, $4320, $42A0, $4330, $4190, $4150, $FFFF

; E-0200 (C1: passed in HL, with GlyphCopySrcList5 in DE, to SwapMonstersMenu_Shared05, which copies 16 bytes from bank $1F at each source to each destination until a destination of $FFFF).
; record: 15 VRAM tile addresses, then $FFFF
GlyphCopyDestList5::
Data_01E_793C:: ; address name
    dw vTiles2 + $7C0, vTiles2 + $7D0, vTiles2 + $7E0, vTiles2 + $7F0, vTiles1 + $5F0, vTiles1 + $7E0, vTiles1 + $7F0, vTiles2 + $770 ; entry 0
    dw vTiles2 + $780, vTiles2 + $700, vTiles2 + $710, vTiles2 + $720, vTiles2 + $730, vTiles2 + $740, vTiles2 + $750, rIE

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 12 x 9 tiles, one row per line
TileRect_1E_795C::
Data_01E_795C:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $F8, $F9, $FA, $FB, $FC, $C3, $EA, $ED, $C3, $C3, $B7 ; id 1
    db $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $BA ; id 2
    db $B6, $C7, $A7, $A8, $A9, $AA, $AB, $AC, $AD, $AE, $AF, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $F5, $F7, $ED, $C3, $C3, $C3, $BE, $C3, $C3, $C3, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $F6, $F7, $ED, $C3, $C3, $C3, $BE, $C3, $C3, $C3, $B7 ; id 7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 8

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 11 x 11 tiles, one row per line
TileRect_1E_79C8::
Data_01E_79C8:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $A9, $AF, $A6, $A7, $C3, $A6, $A8, $A8, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $F4, $A5, $AA, $AB, $C3, $AC, $A7, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $AD, $AE, $CF, $AA, $AB, $C3, $C3, $C3, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $A4, $CF, $EE, $CF, $EF, $DF, $CF, $C3, $B7 ; id 7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 8
    db $B6, $C3, $F0, $F1, $A5, $F2, $C3, $C3, $C3, $C3, $B7 ; id 9
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 10

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 11 tiles, one row per line
TileRect_1E_7A41::
Data_01E_7A41:: ; address name
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
; record: 8 x 11 tiles, one row per line
TileRect_1E_7A99::
Data_01E_7A99:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 5
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 6
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 8
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 9
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 10

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 11 tiles, one row per line
TileRect_1E_7AF1::
Data_01E_7AF1:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 5
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 6
    db $B6, $C3, $A4, $CF, $EE, $CF, $EF, $DF ; id 7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 8
    db $B6, $C3, $F0, $F1, $A5, $F2, $C3, $C3 ; id 9
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4 ; id 10

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 13 x 9 tiles, one row per line
TileRect_1E_7B49::
Data_01E_7B49:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $D0, $D1, $D2, $D3, $D4, $D5, $D6, $D7, $D8, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $D9, $DA, $DB, $DC, $DD, $DE, $C0, $C1, $C2, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $F5, $F6, $F7, $F8, $F9, $FA, $FB, $FC, $BF, $C3, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $C7, $C8, $C9, $CA, $CB, $EA, $EB, $EC, $ED, $C3, $B7 ; id 7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 8

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 13 x 5 tiles, one row per line
TileRect_1E_7BBE::
Data_01E_7BBE:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $7C, $7D, $7E, $DF, $7F, $FE, $FF, $76, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $77, $78, $78, $76, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 4

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 4 x 8 tiles, one row per line
TileRect_1E_7BFF::
Data_01E_7BFF:: ; address name
    db $B1, $B1, $B1, $B2 ; id 0
    db $A6, $A8, $A8, $B7 ; id 1
    db $C3, $C3, $C3, $B7 ; id 2
    db $AC, $A7, $C3, $B7 ; id 3
    db $C3, $C3, $C3, $B7 ; id 4
    db $C3, $C3, $C3, $B7 ; id 5
    db $C3, $C3, $C3, $B7 ; id 6
    db $DF, $CF, $C3, $B7 ; id 7

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 4 x 3 tiles, one row per line
TileRect_1E_7C1F::
Data_01E_7C1F:: ; address name
    db $C3, $C3, $C3, $B7 ; id 0
    db $C3, $C3, $C3, $B7 ; id 1
    db $B4, $B4, $B4, $B5 ; id 2
    ds $3D5, $00
