SECTION "Bank 14", ROMX[$4000], BANK[$14]
    db $14

; implements script command type EC; reached through ScriptCommandEC in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommandEC)
; reads: wD788
ScriptCommandEC_Run::
Func_014_4001:: ; address name
    ld a, [wD788]
    rst $00
    dw ScriptCommandEC_Run_Case00
    dw ScriptCommandEC_Run_Case01
    dw ScriptCommandEC_Run_Case02
    dw ScriptCommandEC_Run_Case03

; entry 0 of the `rst $00` table in ScriptCommandEC_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wD788
; writes: wD788
; points at: wC364, wScreenTileBuffer, wD1CC, wD000
ScriptCommandEC_Run_Case00::
Jump_014_400D:: ; address name
    ld hl, wC364
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank14
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_014_402B
    ld hl, wD1CC
    ld de, wD000
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank14

Jump_014_402B::
    call BGMapAddressAtScroll_Bank14
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    ld a, [wD788]
    inc a
    ld [wD788], a
    ret

; entry 1 of the `rst $00` table in ScriptCommandEC_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5, wD788
; writes: wD7F1, wD7F2, wD7F3, wD7F4, wD784, wD785, wD780, wD781, ...
ScriptCommandEC_Run_Case01::
Jump_014_403F:: ; address name
    ld a, $9C
    ld [wD7F1], a
    xor a, a
    ld [wD7F2], a
    ld de, Data_014_6D84
    ld a, d
    ld [wD7F3], a
    ld a, e
    ld [wD7F4], a
    farcall Func_01D_6C14
    ld a, [wD7F5]
    cp a, $FF
    ret nz
    xor a, a
    ld [wD784], a
    ld [wD785], a
    ld [wD780], a
    ld [wD781], a
    ld [wC46B], a
    ld a, [wD788]
    inc a
    ld [wD788], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in ScriptCommandEC_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD788
; writes: wD788
; points at: wC52D
ScriptCommandEC_Run_Case02::
Jump_014_4080:: ; address name
    ld hl, vTiles1 + $500
    ld bc, $0F01
    call FillTilesBxC
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, [wD788]
    inc a
    ld [wD788], a
    ret

; entry 3 of the `rst $00` table in ScriptCommandEC_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wD7F0, wD788, hFFBA, wScriptCommandType, wScriptStartRequest
; points at: wD780
ScriptCommandEC_Run_Case03::
Jump_014_409E:: ; address name
    farcall Func_01D_62AD
    xor a, a
    ld [wD7F0], a
    ld [wD788], a
    ld bc, $006F
    ld hl, wD780

Jump_014_40B1::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_014_40B1
    ld a, $80
    ldh [hFFBA], a
    farcall Func_002_470B
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type EB; reached through ScriptCommandEB in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommandEB)
; reads: wD780
ScriptCommandEB_Run::
Func_014_40CC:: ; address name
    ld a, [wD780]
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
; writes: wD7F0, hFFBA, wScriptCommandType, wScriptStartRequest
; points at: wD780, wC364, wScreenTileBuffer, wD1CC, wD000
ScriptCommandEB_Run_Case00::
Jump_014_40E8:: ; address name
    ld hl, wD780
    ld bc, $006F

Jump_014_40EE::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_014_40EE
    ld hl, wC364
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank14
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_014_4113
    ld hl, wD1CC
    ld de, wD000
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank14

Jump_014_4113::
    ld a, $04
    ld [wD7F0], a
    ld a, $70
    ldh [hFFBA], a
    xor a, a
    ld hl, wD780
    inc [hl]
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 1 of the `rst $00` table in ScriptCommandEB_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
ScriptCommandEB_Run_Case01::
Jump_014_412B:: ; address name
    ld a, [wD781]
    rst $00
    dw ScriptCommandEB_Run_Table2_Case00
    dw ScriptCommandEB_Run_Table2_Case01
    dw ScriptCommandEB_Run_Table2_Case02
    dw ScriptCommandEB_Run_Table2_Case03

; entry 0 of the `rst $00` table in ScriptCommandEB_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommandEB_Run_Table2_Case00::
Jump_014_4137:: ; address name
    farcall Func_01D_6C8A
    ret

; entry 1 of the `rst $00` table in ScriptCommandEB_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wD781
ScriptCommandEB_Run_Table2_Case01::
Jump_014_413E:: ; address name
    ld hl, Data_014_5A28
    ld de, Data_014_5A84
    call Func_014_5898
    cp a, $FF
    ret nz
    ld hl, wD781
    inc [hl]
    ret

; entry 2 of the `rst $00` table in ScriptCommandEB_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
ScriptCommandEB_Run_Table2_Case02::
Jump_014_414F:: ; address name
    farcall Func_01D_5E79
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 3 of the `rst $00` table in ScriptCommandEB_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD780
; writes: wD781, wD780
; points at: wC364
ScriptCommandEB_Run_Table2_Case03::
Jump_014_415D:: ; address name
    ld de, Data_014_5AC4
    ld hl, wC364
    ld bc, $0A09
    call CopyRectTo20ByteRows_Bank14
    call Func_014_5910
    call BGMapAddressAtScroll_Bank14
    ld bc, $140B
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    farcall Func_01D_5E3F
    xor a, a
    ld [wD781], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

; entry 2 of the `rst $00` table in ScriptCommandEB_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wD786, wD780
; writes: wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wD780, wD7AB, wD7AD, wD7AF, wD786
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
    ld a, [wD786]
    and a, a
    jr nz, Jump_014_41BD
    ld a, $03
    ld [wD786], a
    call ScriptCommandEB_Run_Case02_Sub01
    ld a, $69
    call QueueSoundEffect
    ret

Jump_014_41BD::
    dec a

Jump_014_41BE::
    ld [wD786], a
    xor a, a
    ld [wD7AB], a
    ld [wD7AD], a
    ld [wD7AF], a
    call ScriptCommandEB_Run_Case02_Sub02
    ld a, $69
    call QueueSoundEffect
    ret

Jump_014_41D4::
    call ScriptCommandEB_Run_Case02_Sub03
    ld a, [wD786]
    cp a, $03
    jr c, Jump_014_41EB
    xor a, a
    ld [wD786], a
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
    ld a, [wD786]
    cp a, $03
    jr z, Jump_014_4230
    ld [wTwoChoiceCursor], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    xor a, a
    ld [wD7AB], a
    ld [wD7AD], a
    ld [wD7AF], a
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
; reads: wJoypadRepeatTimer, wD787, wD786
; writes: wD787
ScriptCommandEB_Run_Case02_Sub01::
Func_014_423F:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, ScriptCommandEB_Run_Case02_Sub02
    ld a, [wD787]
    inc a
    ld [wD787], a
    cp a, $10
    jr c, ScriptCommandEB_Run_Case02_Sub02
    cp a, $18
    jr c, ScriptCommandEB_Run_Case02_Sub03
    xor a, a
    ld [wD787], a

; only called from ScriptCommandEB_Run_Case02 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandEB_Run_Case02)
; reads: wD786
ScriptCommandEB_Run_Case02_Sub02::
Func_014_4259:: ; address name
    ld b, $BB
    jr Jump_014_4263

; only called from ScriptCommandEB_Run_Case02 (E-0047)
; 2 call sites from 1 routine (e.g. ScriptCommandEB_Run_Case02)
; reads: wD786
ScriptCommandEB_Run_Case02_Sub03::
Func_014_425D:: ; address name
    ld b, $C3
    jr Jump_014_4263

; only called from ScriptCommandEB_Run_Case02 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandEB_Run_Case02)
; reads: wD786
ScriptCommandEB_Run_Case02_Sub04::
Func_014_4261:: ; address name
    ld b, $BC

Jump_014_4263::
    ld a, [wD786]
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

Data_014_4280:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $21, $00, $61, $00, $A1, $00, $E1, $00, $21, $01

; entry 3 of the `rst $00` table in ScriptCommandEB_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD786, wD7F5, wD780, wD7A9, wD7B9, wC6FD
; writes: wTwoChoiceCursor, wD780, wD781, wD782, wScriptCommandType, wScriptStartRequest, wD7AF, wD7AB
ScriptCommandEB_Run_Case03::
Jump_014_428A:: ; address name
    ld a, [wD786]
    and a, a
    jr z, Jump_014_429B
    cp a, $01
    jp z, Jump_014_4309
    cp a, $02
    jp z, Jump_014_4409
    ret

Jump_014_429B::
    farcall Func_01D_5ECE
    ld a, [wD780]
    inc a
    ld [wD780], a
    ld a, [wD7A9]
    and a, a
    jr z, Jump_014_42F1
    farcall Func_01D_6DF8
    farcall LoadWD7FFFromWC7C7Table
    ld a, [wD7F5]
    cp a, c
    jr c, Jump_014_42DA
    ld a, $1E
    ld [wD781], a
    xor a, a
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wD7AF], a
    ld [wD7AB], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_014_42DA::
    xor a, a
    ld [wD781], a
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wD7AF], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_014_42F1::
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $02
    ld [wD780], a
    xor a, a
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_014_4309::
    farcall Func_01D_6DF8
    ld a, [wD7F5]
    and a, a
    jp z, Jump_014_43B1
    farcall Func_01D_5F2D
    farcall LoadWD7FFFromWC7C7Table
    ld a, [wD7A9]
    cp a, c
    jr nc, Jump_014_4339
    ld b, a
    ld a, [wD7B9]
    cp a, c
    jr nc, Jump_014_4396
    add a, b
    cp a, c
    jr c, Jump_014_4359
    ld a, [wC6FD]
    cp a, b
    jr z, Jump_014_437B

Jump_014_4339::
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wD782], a
    ld a, $1B
    ld [wD781], a
    ld a, [wD780]
    inc a
    inc a
    ld [wD780], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_014_4359::
    farcall Func_01D_5ECE
    xor a, a
    ld [wTwoChoiceCursor], a
    ld [wD782], a
    ld [wD781], a
    ld a, [wD780]
    inc a
    inc a
    ld [wD780], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_014_437B::
    ld a, $04
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wD782], a
    ld [wD781], a
    ld a, $02
    ld [wD780], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_014_4396::
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wD782], a
    ld [wD781], a
    ld a, $02
    ld [wD780], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_014_43B1::
    ld a, $03
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wD782], a
    ld [wD781], a
    ld a, $02
    ld [wD780], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD7A9, wD780
; writes: wTwoChoiceCursor, wD780, wD781, wD782, wScriptCommandType, wScriptStartRequest
Func_014_43CC:: ; heuristic: follows a terminator; C0
    farcall Func_01D_5ECE
    ld a, [wD7A9]
    and a, a
    jr nz, Jump_014_43F3
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $02
    ld [wD780], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_014_43F3::
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wD780]
    add a, $03
    ld [wD780], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_014_4409::
    farcall Func_01D_6DF8
    ld a, [wD7F5]
    and a, a
    jr nz, Jump_014_4430
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $02
    ld [wD780], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_014_4430::
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

; entry 5 of the `rst $00` table in ScriptCommandEB_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
ScriptCommandEB_Run_Case05::
Jump_014_4446:: ; address name
    ld a, [wD781]
    rst $00
    dw Func_014_43CC_Case00
    dw Func_014_4B5A
    dw Func_014_43CC_Case02
    dw Func_014_43CC_Case03
    dw Func_014_43CC_Case04
    dw Func_014_43CC_Case05
    dw Func_014_43CC_Case06
    dw Func_014_43CC_Case07
    dw Func_014_43CC_Case08
    dw Func_014_43CC_Case09
    dw Func_014_43CC_Case0A
    dw Func_014_43CC_Case0B
    dw Func_014_43CC_Case00
    dw Func_014_43CC_Case0D
    dw Func_014_43CC_Case0E
    dw Func_014_43CC_Case0F
    dw Func_014_43CC_Case10
    dw Func_014_43CC_Case11
    dw Func_014_43CC_Case12
    dw Func_014_43CC_Case13
    dw Func_014_43CC_Case09
    dw Func_014_43CC_Case0A
    dw Func_014_43CC_Case0B
    dw Func_014_43CC_Case00
    dw Func_014_43CC_Case0D
    dw Func_014_43CC_Case0E
    dw Func_014_43CC_Case0F
    dw Func_014_43CC_Case1B
    dw Func_014_43CC_Case1C
    dw Func_014_43CC_Case00
    dw Func_014_4B5A
    dw Func_014_43CC_Case1F
    dw Func_014_43CC_Case20
    dw Func_014_43CC_Case21
    dw Func_014_43CC_Case05
    dw Func_014_43CC_Case23
    dw Func_014_43CC_Case07
    dw Func_014_43CC_Case25
    dw Func_014_43CC_Case09
    dw Func_014_43CC_Case0A
    dw Func_014_43CC_Case0B
    dw Func_014_43CC_Case00
    dw Func_014_43CC_Case0D
    dw Func_014_43CC_Case0E
    dw Func_014_43CC_Case2C
    dw Func_014_43CC_Case2D
    dw Func_014_43CC_Case2E
    dw Func_014_43CC_Case2F
    dw Func_014_4932
    dw Func_014_43CC_Case31
    dw Func_014_43CC_Case32
    dw Func_014_43CC_Case00
    dw Func_014_4B5A
    dw Func_014_43CC_Case02
    dw Func_014_43CC_Case03
    dw Func_014_43CC_Case04
    dw Func_014_43CC_Case05
    dw Func_014_43CC_Case06
    dw Func_014_43CC_Case07
    dw Func_014_43CC_Case3B
    dw Func_014_43CC_Case3C
    dw Func_014_43CC_Case10
    dw Func_014_43CC_Case3E
    dw Func_014_43CC_Case3F
    dw Func_014_43CC_Case40
    dw Func_014_43CC_Case09
    dw Func_014_43CC_Case0A
    dw Func_014_43CC_Case0B
    dw Func_014_43CC_Case00
    dw Func_014_43CC_Case0D
    dw Func_014_43CC_Case0E
    dw Func_014_43CC_Case0F

; entry 50 of the `rst $00` table in Func_014_43CC
; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5, wD7F6, wD7AB, wD7AF, wD7B4
; writes: wD7B4, wD7B5, wD7B6, wD7AB, wD7AF
Func_014_43CC_Case32::
Jump_014_44DA:: ; address name
    call Func_014_4932
    farcall Func_01D_5ECE
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld [wD7B4], a
    ld a, [wD7AB]
    ld [wD7B5], a
    ld a, [wD7AF]
    ld [wD7B6], a
    ld a, [wD7B4]
    ld b, a
    ld c, $00
    call Func_014_56B0
    xor a, a
    ld [wD7AB], a
    ld [wD7AF], a
    ret

; entry 60 of the `rst $00` table in Func_014_43CC
; no direct call (reached through a table, a jump or a vector)
; reads: wD7AB, wD7B5, wD7B6
; writes: wD7AB, wD7AF, wTwoChoiceCursor, wD781, wScriptCommandType, wScriptStartRequest
; points at: wC52D
Func_014_43CC_Case3C::
Jump_014_450C:: ; address name
    call BGMapAddressAtScroll_Bank14
    push hl
    ld a, [wD7AB]
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
    ld a, [wD7B5]
    ld [wD7AB], a
    ld a, [wD7B6]
    ld [wD7AF], a
    farcall Func_01D_5ECE
    call Func_014_4BA0
    call Func_014_58EE
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
    ld [wD781], a
    ld hl, wC52D
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

Data_014_4586:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $21, $00, $61, $00, $A1, $00, $E1, $00, $21, $01

; entry 62 of the `rst $00` table in Func_014_43CC
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wTwoChoiceCursor, wD781, wD7AB
; writes: wD781, wD782, wScriptCommandType, wScriptStartRequest, wTwoChoiceCursor
Func_014_43CC_Case3E::
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
    farcall Func_01D_5CA3
    call Func_014_56EB
    jp Jump_014_4EA7

Jump_014_45B8::
    call Func_014_4EBF
    ld a, [wD7AB]
    ld b, $C3
    ld hl, Data_014_5B1E
    call StoreBAtWordTableEntry_Bank14
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $3B
    ld [wD781], a
    xor a, a
    ld [wD782], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 63 of the `rst $00` table in Func_014_43CC
; no direct call (reached through a table, a jump or a vector)
; reads: wD782, wD7B4, wD7F5, wD7F6, wD781
; writes: rRAMG2, rRAMB, wD7F1, wD7F2, wD7F3, wD7F4, wD7B4, wD782, ...
; points at: wC986, sB356, sA000
Func_014_43CC_Case3F::
Jump_014_45DE:: ; address name
    ld a, [wD782]
    and a, a
    jp nz, Jump_014_4630
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [wD7B4]
    ld [wD7F1], a
    xor a, a
    ld [rRAMG2], a
    ld [wD7F2], a
    ld hl, wC986
    ld a, l
    ld [wD7F3], a
    ld a, h
    ld [wD7F4], a
    farcall Func_01D_6E39
    ld a, [wD7F5]
    cp a, $FF
    ret nz
    ld a, [wD7B4]
    ld [wD7F1], a
    xor a, a
    ld [wD7F2], a
    farcall Func_014_7E96
    ld a, [wD7F5]
    ld [wD7B4], a
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_014_4630::
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    cp a, $1D
    jr z, Jump_014_464F
    ld c, $6F
    call Multiply8
    ld de, sB356
    add hl, de
    xor a, a
    jr Jump_014_4654

Jump_014_464F::
    ld hl, sA000
    ld a, $01

Jump_014_4654::
    ld [wD7F2], a
    push hl
    ld a, [wD7B4]
    ld [wD7F1], a
    pop hl
    ld a, l
    ld [wD7F3], a
    ld a, h
    ld [wD7F4], a
    farcall Func_01D_7492
    ld a, [wD7F5]
    cp a, $FF
    ret nz
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld [wD7F1], a
    xor a, a
    ld [wD7F2], a
    farcall Func_014_7D7F
    ld a, [wD7F5]
    ld [wD7B4], a
    xor a, a
    ld [wD782], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 64 of the `rst $00` table in Func_014_43CC
; no direct call (reached through a table, a jump or a vector)
; reads: wD7B4
; writes: rRAMG2, rRAMB, wD7B5, wD7B6, wD7B4, wD7AB, wD7AD, wD7AF, ...
; points at: sB356, wC986, sA000
Func_014_43CC_Case40::
Jump_014_46A1:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    ld a, [wD7B4]
    cp a, $1D
    jr z, Jump_014_46B9
    ld c, $6F
    call Multiply8
    ld de, sB356
    add hl, de
    xor a, a
    jr Jump_014_46BE

Jump_014_46B9::
    ld hl, sA000
    ld a, $01

Jump_014_46BE::
    ld [rRAMB], a
    ld de, wC986
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
    ld [wD7B5], a
    ld [wD7B6], a
    ld [wD7B4], a
    farcall Func_01D_5E79
    call Func_014_4932
    xor a, a
    ld [wD7AB], a
    ld [wD7AD], a
    ld [wD7AF], a
    ld [wD7AC], a
    ld [wD7AE], a
    ret

; entry 5 of the `rst $00` table in Func_014_43CC
; no direct call (reached through a table, a jump or a vector)
; points at: wC52D, wD781
Func_014_43CC_Case05::
Jump_014_46F4:: ; address name
    ld hl, vTiles1 + $270
    ld bc, $0901
    call FillTilesBxC
    ld hl, vTiles1 + $780
    ld bc, $0501
    call FillTilesBxC
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld hl, wD781
    inc [hl]
    ret

; entry 7 of the `rst $00` table in Func_014_43CC
; no direct call (reached through a table, a jump or a vector)
; reads: wD7AB, wD781
; writes: wD781
Func_014_43CC_Case07::
Jump_014_4718:: ; address name
    ld a, [wD7AB]
    ld b, $BB
    ld hl, Data_014_5B1E
    call StoreBAtWordTableEntry_Bank14
    call BGMapAddressAtScroll_Bank14
    ld bc, $140B
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    ld a, [wD7AB]
    ld b, $C3
    ld hl, Data_014_5B1E
    call StoreBAtWordTableEntry_Bank14
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 9 of the `rst $00` table in Func_014_43CC
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD7F1, wD7F2, wD781
Func_014_43CC_Case09::
Jump_014_4742:: ; address name
    ld c, $0D
    ld hl, $01D4
    ld de, $0008
    xor a, a
    ld [wD7F1], a
    ld a, $0C
    ld [wD7F2], a
    call Func_014_5925
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 10 of the `rst $00` table in Func_014_43CC
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
Func_014_43CC_Case0A::
Jump_014_475E:: ; address name
    call BGMapAddressAtScroll_Bank14
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 11 of the `rst $00` table in Func_014_43CC
; no direct call (reached through a table, a jump or a vector)
; points at: wD781
Func_014_43CC_Case0B::
Jump_014_4772:: ; address name
    ld hl, Data_014_5C36
    ld de, Data_014_5C4A
    call Func_014_5898
    cp a, $FF
    ret nz
    ld hl, wD781
    inc [hl]
    ret

; entry 45 of the `rst $00` table in Func_014_43CC
; no direct call (reached through a table, a jump or a vector)
; points at: wD781
Func_014_43CC_Case2D::
Jump_014_4783:: ; address name
    ld hl, Data_014_5C8A
    ld de, Data_014_5C9A
    call Func_014_5898
    cp a, $FF
    ret nz
    ld hl, wD781
    inc [hl]
    ret

; entry 46 of the `rst $00` table in Func_014_43CC
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD7AD, wD7AE, wD781
; points at: wC410
Func_014_43CC_Case2E::
Jump_014_4794:: ; address name
    ld de, Data_014_47C0
    ld hl, wC410
    ld bc, $0805
    call CopyRectTo20ByteRows_Bank14
    call BGMapAddressAtScroll_Bank14
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    ld a, $6C
    call QueueSoundEffect
    xor a, a
    ld [wD7AD], a
    ld [wD7AE], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Data_014_47C0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $70, $71, $72, $73, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $74, $75, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; entry 47 of the `rst $00` table in Func_014_43CC
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wD781, wD7AD, wD780
; writes: wTwoChoiceCursor, wD781, wScriptCommandType, wScriptStartRequest, wD7B2, wD7B3, wD780, wD782, ...
Func_014_43CC_Case2F::
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
    call Func_014_48ED
    ret

Jump_014_4804::
    call Func_014_490B
    ld a, [wD7AD]
    and a, a
    jr nz, Jump_014_4811
    ld a, $01
    jr Jump_014_4812

Jump_014_4811::
    dec a

Jump_014_4812::
    ld [wD7AD], a
    call Func_014_4907
    ld a, $69
    call QueueSoundEffect
    ret

Jump_014_481E::
    call Func_014_490B
    ld a, [wD7AD]
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
    call Func_014_490F
    ld a, [wD7AD]
    and a, a
    jp nz, Jump_014_48AC
    ld a, [wD780]
    cp a, $05
    jr z, Jump_014_486D
    cp a, $04
    jr z, Jump_014_4848

Jump_014_4848::
    ld a, [wD781]
    cp a, $13
    jr c, Jump_014_485E
    ld a, $04
    ld [wD7B2], a
    ld a, $3F
    ld [wD7B3], a
    ld a, $09
    jp Jump_014_488F

Jump_014_485E::
    ld a, $04
    ld [wD7B2], a
    ld a, $12
    ld [wD7B3], a
    ld a, $09
    jp Jump_014_488F

Jump_014_486D::
    ld a, [wD781]
    cp a, $2E
    jr c, Jump_014_4883
    ld a, $05
    ld [wD7B2], a
    ld a, $2F
    ld [wD7B3], a
    ld a, $09
    jp Jump_014_488F

Jump_014_4883::
    ld a, $04
    ld [wD7B2], a
    ld a, $25
    ld [wD7B3], a
    ld a, $09

Jump_014_488F::
    ld [wD780], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld [wTwoChoiceCursor], a
    farcall SaveAndHideSpriteState_Bank1E
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_014_48AC::
    ld a, [wD780]
    cp a, $04
    jr nz, Jump_014_48C0
    ld a, [wD781]
    cp a, $3F
    jr nz, Jump_014_48C0
    call Func_014_578E
    call Func_014_574E

Jump_014_48C0::
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wD781]
    add a, $03
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_014_48D7::
    ld a, $02
    ld [wTwoChoiceCursor], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; 1 call site from 1 routine (e.g. Func_014_43CC_Case2F)
; reads: wJoypadRepeatTimer, wD7AE, wD7AD
; writes: wD7AE
Func_014_48ED::
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, Func_014_4907
    ld a, [wD7AE]
    inc a
    ld [wD7AE], a
    cp a, $10
    jr c, Func_014_4907
    cp a, $18
    jr c, Func_014_490B
    xor a, a
    ld [wD7AE], a

; 1 call site from 1 routine (e.g. Func_014_43CC_Case2F)
; reads: wD7AD
Func_014_4907::
    ld b, $BB
    jr Jump_014_4911

; 2 call sites from 1 routine (e.g. Func_014_43CC_Case2F)
; reads: wD7AD
Func_014_490B::
    ld b, $C3
    jr Jump_014_4911

; 1 call site from 1 routine (e.g. Func_014_43CC_Case2F)
; reads: wD7AD
Func_014_490F::
    ld b, $BC

Jump_014_4911::
    ld a, [wD7AD]
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

Data_014_492E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2D, $01, $6D, $01

; 5 call sites from 5 routines (e.g. Func_014_4BA0_Case43, Func_014_4BA0_Case16, Func_014_4BA0_Case15, Func_014_43CC_Case40, ...)
; reads: wD7AB, wD781
; writes: wD7F1, wD7F2, wD781
; points at: wC410
Func_014_4932::
    ld de, Data_014_4965
    ld hl, wC410
    ld bc, $0801
    call CopyRectTo20ByteRows_Bank14
    ld c, $04
    ld hl, $028C
    ld de, $00C0
    xor a, a
    ld [wD7F1], a
    ld a, $08
    ld [wD7F2], a
    call Func_014_5925
    ld a, [wD7AB]
    ld b, $C3
    ld hl, Data_014_5B1E
    call StoreBAtWordTableEntry_Bank14
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Data_014_4965:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; entry 27 of the `rst $00` table in Func_014_43CC
; no direct call (reached through a table, a jump or a vector)
; reads: wD786, wD781
; writes: wD781, wTwoChoiceCursor
; points at: wC412
Func_014_43CC_Case1B::
Jump_014_496D:: ; address name
    ld de, Data_01F_4330
    ld hl, vTiles2 + $730
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, $6C
    call QueueSoundEffect
    ld de, Data_014_49AE
    ld hl, wC412
    ld bc, $0605
    call CopyRectTo20ByteRows_Bank14
    ld a, [wD786]
    ld b, $BC
    ld hl, Data_014_5B1E
    call StoreBAtWordTableEntry_Bank14
    call BGMapAddressAtScroll_Bank14
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ret

Data_014_49AE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $CE, $CF, $DF, $B7, $B6, $C3, $C3, $C3
    db $C3, $B7, $B6, $C3, $EF, $73, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B5

; entry 28 of the `rst $00` table in Func_014_43CC
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wTwoChoiceCursor, wD781
; writes: wD781, wD782, wScriptCommandType, wScriptStartRequest, wTwoChoiceCursor, wD780
Func_014_43CC_Case1C::
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
    call Func_014_4A1F
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $01
    ld [wD780], a
    ld a, $03
    ld [wD781], a
    xor a, a
    ld [wD782], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_014_4A00::
    ld a, [wTwoChoiceCursor]
    cp a, $01
    jr z, Jump_014_49E0
    call Func_014_4A1F
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wD782], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; 2 call sites from 1 routine (e.g. Func_014_43CC_Case1C)
; reads: wIsCGB, rSVBK
; writes: rSVBK
; points at: wC412, wC246, wD27A, wD0AE
Func_014_4A1F::
    ld hl, wC412
    ld de, wC246
    ld c, $00
    call Func_014_4A54
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_014_4A47
    ldh a, [rSVBK]
    set 1, a
    ldh [rSVBK], a
    ld hl, wD27A
    ld de, wD0AE
    ld c, $00
    call Func_014_4A54
    ldh a, [rSVBK]
    res 1, a
    ldh [rSVBK], a

Jump_014_4A47::
    call BGMapAddressAtScroll_Bank14
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    ret

; 2 call sites from 1 routine (e.g. Func_014_4A1F)
Func_014_4A54::
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
    jr c, Func_014_4A54
    ret

; entry 0 of the `rst $00` table in Func_014_43CC
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD7AF, wD7AE, wD781
; points at: wC364
Func_014_43CC_Case00::
Jump_014_4A75:: ; address name
    ld de, Data_014_4AA8
    ld hl, wC364
    ld bc, $0A09
    call CopyRectTo20ByteRows_Bank14
    ld de, Data_014_4B02
    ld hl, wC364
    ld bc, $080B
    call CopyRectTo20ByteRows_Bank14
    call BGMapAddressAtScroll_Bank14
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    xor a, a
    ld [wD7AF], a
    ld [wD7AE], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Data_014_4AA8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $050AA8, $5A

Data_014_4B02:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $050B02, $58

; 1 call site from 1 routine (e.g. Func_014_43CC_Case08)
; reads: wD781
; writes: wD781
; points at: wC364
Func_014_4B5A::
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
    ld de, Data_014_5B36
    ld hl, wC364
    ld bc, $080B
    call CopyRectTo20ByteRows_Bank14
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 31 of the `rst $00` table in Func_014_43CC
; no direct call (reached through a table, a jump or a vector)
; reads: wD7B0, wD781
; writes: wD7F1, wD7F2, wD781
; points at: wC42E, wC42F
Func_014_43CC_Case1F::
Jump_014_4B92:: ; address name
    farcall Func_01D_5ECE
    jr Func_014_4BA0
    db $21, $2D, $5F, $06, $1D, $D7

; 2 call sites from 2 routines (e.g. Func_014_4BA0_Case3C, Func_014_43CC_Case3C)
; reads: wD7B0, wD781
; writes: wD7F1, wD7F2, wD781
; points at: wC42E, wC42F
Func_014_4BA0::
    farcall Func_01E_7163
    ld a, [wD7B0]
    cp a, $02
    jr c, Jump_014_4BDB
    ld de, $0142
    call Func_014_599F
    ld hl, wC42E
    call StoreC5BEC6AtHLStride2_Bank14
    ld de, $0143
    ld a, d
    ld [wD7F1], a
    ld a, e
    ld [wD7F2], a
    farcall Func_01E_7564
    ld hl, wC42F
    ld a, h
    ld [wD7F1], a
    ld a, l
    ld [wD7F2], a
    farcall Func_01E_759A

Jump_014_4BDB::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 32 of the `rst $00` table in Func_014_43CC
; no direct call (reached through a table, a jump or a vector)
Func_014_43CC_Case20::
Jump_014_4BE3:: ; address name
    farcall Func_01F_5C15
    ret

; entry 33 of the `rst $00` table in Func_014_43CC
; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5, wD7F6, wD781
; writes: wD7F1, wD781
; points at: wC36C
Func_014_43CC_Case21::
Jump_014_4BEA:: ; address name
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld b, a
    push af
    call Func_014_5979
    ld de, Data_014_5B8E
    ld hl, wC36C
    ld bc, $0C09
    call CopyRectTo20ByteRows_Bank14
    pop af
    ld [wD7F1], a
    farcall Func_01D_5B4D
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 35 of the `rst $00` table in Func_014_43CC
; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5, wD7F6, wD781
; writes: wD7F1, wD781
Func_014_43CC_Case23::
Jump_014_4C1C:: ; address name
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld [wD7F1], a
    farcall Func_01D_5CD7
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 37 of the `rst $00` table in Func_014_43CC
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wD781, wD7AB
; writes: wMenuInputResult, wD781, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
; points at: wC52D
Func_014_43CC_Case25::
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
    ld a, [wD781]
    sub a, $07
    ld [wD781], a
    ret

Jump_014_4C69::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_014_4C71::
    ld a, [wD781]
    add a, $08
    ld [wD781], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wD7AB]
    ld b, $BC
    ld hl, Data_014_5B1E
    call StoreBAtWordTableEntry_Bank14
    ld hl, wC52D
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
    ld a, [wD781]
    sub a, $04
    ld [wD781], a
    ret

; entry 13 of the `rst $00` table in Func_014_43CC
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
Func_014_43CC_Case0D::
Jump_014_4CA8:: ; address name
    ld hl, Data_014_5C5E
    ld de, Data_014_5C74
    call Func_014_5898
    cp a, $FF
    ret nz
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 14 of the `rst $00` table in Func_014_43CC
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
Func_014_43CC_Case0E::
Jump_014_4CBC:: ; address name
    farcall Func_01D_62AD
    farcall Func_01D_5E79
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 44 of the `rst $00` table in Func_014_43CC
; no direct call (reached through a table, a jump or a vector)
; reads: wD786
; writes: wD781, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
; points at: wC364
Func_014_43CC_Case2C::
Jump_014_4CD0:: ; address name
    ld de, Data_014_5AC4
    ld hl, wC364
    ld bc, $0A09
    call CopyRectTo20ByteRows_Bank14
    call Func_014_5910
    ld a, [wD786]
    ld b, $C3
    ld hl, Data_014_5B1E
    call StoreBAtWordTableEntry_Bank14
    call BGMapAddressAtScroll_Bank14
    ld bc, $140B
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    farcall Func_01D_5E3F
    ld a, $1B
    ld [wD781], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 49 of the `rst $00` table in Func_014_43CC
; no direct call (reached through a table, a jump or a vector)
; writes: wD781, wScriptCommandType, wScriptStartRequest
Func_014_43CC_Case31::
Jump_014_4D10:: ; address name
    call BGMapAddressAtScroll_Bank14
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    ld a, $25
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 15 of the `rst $00` table in Func_014_43CC
; no direct call (reached through a table, a jump or a vector)
; writes: wD781, wD780, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
; points at: wC364
Func_014_43CC_Case0F::
Jump_014_4D2B:: ; address name
    ld de, Data_014_5AC4
    ld hl, wC364
    ld bc, $0A09
    call CopyRectTo20ByteRows_Bank14
    call Func_014_5910
    call BGMapAddressAtScroll_Bank14
    ld bc, $140B
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    farcall Func_01D_5E3F
    xor a, a
    ld [wD781], a
    ld a, $02
    ld [wD780], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 4 of the `rst $00` table in ScriptCommandEB_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
ScriptCommandEB_Run_Case04::
Jump_014_4D64:: ; address name
    ld a, [wD781]
    rst $00
    dw Func_014_43CC_Case00
    dw Func_014_4B5A
    dw Func_014_43CC_Case1F
    dw Func_014_43CC_Case20
    dw Func_014_43CC_Case21
    dw Func_014_43CC_Case05
    dw Func_014_43CC_Case23
    dw Func_014_43CC_Case07
    dw Func_014_43CC_Case25
    dw Func_014_43CC_Case09
    dw Func_014_43CC_Case0A
    dw Func_014_43CC_Case0B
    dw Func_014_43CC_Case00
    dw Func_014_43CC_Case0D
    dw Func_014_43CC_Case0E
    dw Func_014_43CC_Case0F
    dw Func_014_43CC_Case2D
    dw Func_014_43CC_Case2E
    dw Func_014_43CC_Case2F
    dw Func_014_4932
    dw Func_014_4BA0_Case14
    dw Func_014_4BA0_Case15
    dw Func_014_4BA0_Case16
    dw Func_014_43CC_Case09
    dw Func_014_43CC_Case0A
    dw Func_014_43CC_Case0B
    dw Func_014_43CC_Case00
    dw Func_014_43CC_Case0D
    dw Func_014_43CC_Case0E
    dw Func_014_43CC_Case0F
    dw Func_014_43CC_Case1B
    dw Func_014_43CC_Case1C
    dw Func_014_43CC_Case00
    dw Func_014_4B5A
    dw Func_014_43CC_Case02
    dw Func_014_43CC_Case03
    dw Func_014_43CC_Case04
    dw Func_014_43CC_Case05
    dw Func_014_43CC_Case06
    dw Func_014_43CC_Case07
    dw Func_014_43CC_Case08
    dw Func_014_43CC_Case09
    dw Func_014_43CC_Case0A
    dw Func_014_43CC_Case0B
    dw Func_014_43CC_Case00
    dw Func_014_43CC_Case0D
    dw Func_014_43CC_Case0E
    dw Func_014_4BA0_Case2F
    dw Func_014_43CC_Case10
    dw Func_014_4BA0_Case31
    dw Func_014_4BA0_Case32
    dw Func_014_43CC_Case00
    dw Func_014_4B5A
    dw Func_014_43CC_Case1F
    dw Func_014_43CC_Case20
    dw Func_014_43CC_Case21
    dw Func_014_43CC_Case05
    dw Func_014_43CC_Case23
    dw Func_014_43CC_Case07
    dw Func_014_43CC_Case3B
    dw Func_014_4BA0_Case3C
    dw Func_014_43CC_Case2D
    dw Func_014_43CC_Case2E
    dw Func_014_43CC_Case2F
    dw Func_014_4932
    dw Func_014_4BA0_Case41
    dw Func_014_4BA0_Case42
    dw Func_014_4BA0_Case43
    dw Func_014_43CC_Case09
    dw Func_014_43CC_Case0A
    dw Func_014_43CC_Case0B
    dw Func_014_43CC_Case00
    dw Func_014_43CC_Case0D
    dw Func_014_43CC_Case0E
    dw Func_014_43CC_Case0F

; entry 2 of the `rst $00` table in Func_014_43CC
; no direct call (reached through a table, a jump or a vector)
; reads: wD7B0, wD781
; writes: wD7F1, wD7F2, wD781
; points at: wC42E, wC42F
Func_014_43CC_Case02::
Jump_014_4DFE:: ; address name
    farcall Func_015_77AC
    jp Func_014_4BA0

; entry 3 of the `rst $00` table in Func_014_43CC
; no direct call (reached through a table, a jump or a vector)
Func_014_43CC_Case03::
Jump_014_4E07:: ; address name
    farcall Func_015_77FB
    ret

; entry 4 of the `rst $00` table in Func_014_43CC
; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5, wD7F6, wD781
; writes: wD7F1, wD781
; points at: wC36C
Func_014_43CC_Case04::
Jump_014_4E0E:: ; address name
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld b, a
    push af
    ld [wD7F1], a
    farcall Func_015_7954
    ld de, Data_014_5B8E
    ld hl, wC36C
    ld bc, $0C09
    call CopyRectTo20ByteRows_Bank14
    pop af
    ld [wD7F1], a
    farcall Func_015_7976
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 6 of the `rst $00` table in Func_014_43CC
; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5, wD7F6, wD781
; writes: wD7F1, wD781
Func_014_43CC_Case06::
Jump_014_4E46:: ; address name
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld [wD7F1], a
    farcall Func_015_7A5F
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 49 of the `rst $00` table in Func_014_4BA0
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wTwoChoiceCursor, wD781, wD7AB
; writes: wD781, wD782, wScriptCommandType, wScriptStartRequest, wTwoChoiceCursor
Func_014_4BA0_Case31::
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
    ld a, [wD7AB]
    ld b, $C3
    ld hl, Data_014_5B1E
    call StoreBAtWordTableEntry_Bank14
    call Func_014_4EBF
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $28
    ld [wD781], a
    xor a, a
    ld [wD782], a
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
    call Func_014_4EBF
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wD782], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; 4 call sites from 3 routines (e.g. Func_014_4BA0_Case31, Func_014_43CC_Case3E, Func_014_43CC_Case11)
; reads: wIsCGB, rSVBK
; writes: rSVBK
; points at: wC412, wC246, wD27A, wD0AE
Func_014_4EBF::
    ld hl, wC412
    ld de, wC246
    ld c, $00
    call Func_014_4F30
    ld hl, wC412
    ld de, Data_014_4F24
    ld c, $04
    call Func_014_4F30
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_014_4EFD
    ldh a, [rSVBK]
    set 1, a
    ldh [rSVBK], a
    ld hl, wD27A
    ld de, wD0AE
    ld c, $00
    call Func_014_4F30
    ld hl, wD27A
    ld de, Data_014_4F2A
    ld c, $04
    call Func_014_4F30
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

Data_014_4F24:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B4, $B4, $B4, $B4, $B4, $B5

Data_014_4F2A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $00, $00

; 4 call sites from 1 routine (e.g. Func_014_4EBF)
Func_014_4F30::
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
    jr c, Func_014_4F30
    ret

; entry 16 of the `rst $00` table in Func_014_43CC
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781, wTwoChoiceCursor
; points at: wC412
Func_014_43CC_Case10::
Jump_014_4F51:: ; address name
    ld de, Data_01F_4330
    ld hl, vTiles2 + $730
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, $6C
    call QueueSoundEffect
    ld de, Data_014_4FAE
    ld hl, wC412
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
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ret

Data_014_4FAE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $70, $71, $DF, $B7, $B6, $C3, $C3, $C3
    db $C3, $B7, $B6, $C3, $76, $73, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B5

; entry 60 of the `rst $00` table in Func_014_4BA0
; no direct call (reached through a table, a jump or a vector)
; reads: wD7B5, wD7B6
; writes: wD7AB, wD7AF, wTwoChoiceCursor, wD781, wScriptCommandType, wScriptStartRequest
; points at: wC52D
Func_014_4BA0_Case3C::
Jump_014_4FCC:: ; address name
    ld a, [wD7B5]
    ld [wD7AB], a
    ld a, [wD7B6]
    ld [wD7AF], a
    farcall Func_015_77AC
    call Func_014_4BA0
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $20
    ld [wD781], a
    ld hl, wC52D
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

; entry 18 of the `rst $00` table in Func_014_43CC
; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5, wD7F6, wD7F1, wD7F2, wD7F3, wD7F4, wD781
; writes: rRAMG2, rRAMB, wD7F2, wD7F3, wD7F4, wD7F1, wD7BE, wD7BF, ...
; points at: sB356, sA000
Func_014_43CC_Case12::
Jump_014_5002:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    cp a, $1D
    jr nc, Jump_014_502A
    ld c, $6F
    call Multiply8
    ld de, sB356
    add hl, de
    xor a, a
    jr Jump_014_502F

Jump_014_502A::
    ld hl, sA000
    ld a, $01

Jump_014_502F::
    ld [wD7F2], a
    ld a, l
    ld [wD7F3], a
    ld a, h
    ld [wD7F4], a
    ld hl, sA000
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
    ld a, [wD781]
    inc a
    inc a
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_014_506D::
    ld a, c
    ld [wD7F1], a
    xor a, a
    ld [rRAMG2], a
    ld a, [wD7F1]
    ld [wD7BE], a
    ld a, [wD7F2]
    ld [wD7BF], a
    ld a, [wD7F3]
    ld [wD7C0], a
    ld a, [wD7F4]
    ld [wD7C1], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 19 of the `rst $00` table in Func_014_43CC
; no direct call (reached through a table, a jump or a vector)
; reads: wD7BE, wD7BF, wD7C0, wD7C1, wD7F5, wD7F6, wD781
; writes: wD7F1, wD7F2, wD7F3, wD7F4, rRAMG2, rRAMB, wD781, wScriptCommandType, ...
Func_014_43CC_Case13::
Jump_014_5095:: ; address name
    ld a, [wD7BE]
    ld [wD7F1], a
    ld a, [wD7BF]
    ld [wD7F2], a
    ld a, [wD7C0]
    ld [wD7F3], a
    ld a, [wD7C1]
    ld [wD7F4], a
    farcall Func_01D_7492
    ld a, [wD7F5]
    cp a, $FF
    ret nz
    ld a, $0A
    ld [rRAMG2], a
    ld a, [wD7BF]
    ld [rRAMB], a
    ld a, [wD7C0]
    ld l, a
    ld a, [wD7C1]
    ld h, a
    ld b, $6F

Jump_014_50CE::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_014_50CE
    xor a, a
    ld [rRAMG2], a
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld [wD7F1], a
    xor a, a
    ld [wD7F2], a
    farcall Func_014_7D7F
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 20 of the `rst $00` table in Func_014_4BA0
; no direct call (reached through a table, a jump or a vector)
; writes: wD781, wScriptCommandType, wScriptStartRequest
Func_014_4BA0_Case14::
Jump_014_5104:: ; address name
    call BGMapAddressAtScroll_Bank14
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    ld a, $08
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 21 of the `rst $00` table in Func_014_4BA0
; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5, wD7F6, wD781
; writes: rRAMG2, rRAMB, wD781, wD7AB, wD7AD, wD7AF, wD7AC, wD7AE
Func_014_4BA0_Case15::
Jump_014_511F:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    push hl
    call Func_014_59D0
    pop hl
    cp a, $FF
    jr z, Jump_014_514B
    xor a, a
    ld [rRAMG2], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_014_514B::
    xor a, a
    ld [rRAMG2], a
    ld a, [wD781]
    inc a
    inc a
    ld [wD781], a
    farcall Func_01D_5E79
    call Func_014_4932
    xor a, a
    ld [wD7AB], a
    ld [wD7AD], a
    ld [wD7AF], a
    ld [wD7AC], a
    ld [wD7AE], a
    ret

; entry 22 of the `rst $00` table in Func_014_4BA0
; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5, wD7F6, wD7F7, wD7AF, wD7AB
; writes: wD7F2, wD7F3, wD7F4, wD7F1, rRAMG2, rRAMB, wD7AB, wD7AD, ...
; points at: wD789
Func_014_4BA0_Case16::
Jump_014_5171:: ; address name
    ld a, [wD7F5]
    ld [wD7F2], a
    ld a, [wD7F6]
    ld [wD7F3], a
    ld a, [wD7F7]
    ld [wD7F4], a
    ld a, [wD7AF]
    ld b, a
    add a, a
    add a, a
    add a, b
    ld b, a
    ld a, [wD7AB]
    add a, b
    ld hl, wD789
    add_a_to_hl
    ld a, [hl]
    ld [wD7F1], a
    farcall Func_01D_6E39
    ld a, [wD7F5]
    cp a, $FF
    ret nz
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld [wD7F1], a
    xor a, a
    ld [rRAMG2], a
    ld [wD7F2], a
    farcall Func_014_7E96
    farcall Func_01D_5E79
    call Func_014_4932
    xor a, a
    ld [wD7AB], a
    ld [wD7AD], a
    ld [wD7AF], a
    ld [wD7AC], a
    ld [wD7AE], a
    ret

; entry 8 of the `rst $00` table in Func_014_43CC
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wD7AB, wD781
; writes: wMenuInputResult, wTwoChoiceCursor, wD781, wScriptCommandType, wScriptStartRequest
Func_014_43CC_Case08::
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
    call Func_014_4B5A
    ld a, [wD781]
    sub a, $07
    ld [wD781], a
    ret

Jump_014_5219::
    ld a, [wD781]
    sub a, $04
    ld [wD781], a
    ret

Jump_014_5222::
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_014_5238::
    call Func_014_58EE
    ld a, [wD7AB]
    ld b, $BC
    ld hl, Data_014_5B1E
    call StoreBAtWordTableEntry_Bank14
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wD781]
    add a, $08
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 47 of the `rst $00` table in Func_014_4BA0
; no direct call (reached through a table, a jump or a vector)
; reads: wD786
; writes: wD781, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
; points at: wC364
Func_014_4BA0_Case2F::
Jump_014_525C:: ; address name
    ld de, Data_014_5AC4
    ld hl, wC364
    ld bc, $0A09
    call CopyRectTo20ByteRows_Bank14
    call Func_014_5910
    ld a, [wD786]
    ld b, $C3
    ld hl, Data_014_5B1E
    call StoreBAtWordTableEntry_Bank14
    call BGMapAddressAtScroll_Bank14
    ld bc, $140B
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    farcall Func_01D_5E3F
    ld a, $1E
    ld [wD781], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 50 of the `rst $00` table in Func_014_4BA0
; no direct call (reached through a table, a jump or a vector)
; reads: wD781, wD7AB, wD7F5, wD7F6, wD7AF
; writes: wD781, wD7B5, wD7B4, wD7B6, wD7AB, wD7AF, wScriptCommandType, wScriptStartRequest
Func_014_4BA0_Case32::
Jump_014_529C:: ; address name
    call BGMapAddressAtScroll_Bank14
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld a, [wD7AB]
    ld [wD7B5], a
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld [wD7B4], a
    ld a, [wD7AF]
    ld [wD7B6], a
    xor a, a
    ld [wD7AB], a
    ld [wD7AF], a
    farcall Func_01D_5ECE
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 59 of the `rst $00` table in Func_014_43CC
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wD781, wD7AB, wD780
; writes: wMenuInputResult, wD781, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
; points at: wC52D
Func_014_43CC_Case3B::
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
    ld a, [wD781]
    sub a, $07
    ld [wD781], a
    ret

Jump_014_5311::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld a, [wD780]
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
    ld a, [wD7AB]
    ld b, $BC
    ld hl, Data_014_5B1E
    call StoreBAtWordTableEntry_Bank14
    ret

Jump_014_533A::
    ld a, [wD781]
    inc a
    inc a
    ld [wD781], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wD7AB]
    ld b, $BC
    ld hl, Data_014_5B1E
    call StoreBAtWordTableEntry_Bank14
    ld hl, wC52D
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
    ld a, [wD781]
    sub a, $04
    ld [wD781], a
    ret

; entry 65 of the `rst $00` table in Func_014_4BA0
; no direct call (reached through a table, a jump or a vector)
; writes: wD781, wScriptCommandType, wScriptStartRequest
Func_014_4BA0_Case41::
Jump_014_5371:: ; address name
    call BGMapAddressAtScroll_Bank14
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    ld a, $3B
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 66 of the `rst $00` table in Func_014_4BA0
; no direct call (reached through a table, a jump or a vector)
; reads: wD782, wD7F5, wD7F6, wD7B4, wD781
; writes: rRAMG2, rRAMB, wD7F1, wD7F2, wD7F3, wD7F4, wD782, wD7B4, ...
; points at: wC986, sB356, sA000
Func_014_4BA0_Case42::
Jump_014_538C:: ; address name
    ld a, [wD782]
    and a, a
    jp nz, Jump_014_53EC
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    push af
    ld [wD7F1], a
    xor a, a
    ld [rRAMG2], a
    ld [wD7F2], a
    ld hl, wC986
    ld a, l
    ld [wD7F3], a
    ld a, h
    ld [wD7F4], a
    farcall Func_01D_6E39
    ld a, [wD7F5]
    cp a, $FF
    jr z, Jump_014_53D0
    pop af
    ret

Jump_014_53D0::
    pop af
    ld [wD7F1], a
    xor a, a
    ld [wD7F2], a
    farcall Func_014_7E96
    ld a, [wD7F5]
    ld [wD7F1], a
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_014_53EC::
    ld a, [wD7B4]
    cp a, $1D
    jr z, Jump_014_53FF
    ld c, $6F
    call Multiply8
    ld de, sB356
    add hl, de
    xor a, a
    jr Jump_014_5404

Jump_014_53FF::
    ld hl, sA000
    ld a, $01

Jump_014_5404::
    ld [wD7F2], a
    push hl
    pop hl
    ld a, l
    ld [wD7F3], a
    ld a, h
    ld [wD7F4], a
    farcall Func_01D_7492
    ld a, [wD7F5]
    cp a, $FF
    ret nz
    ld a, [wD7B4]
    ld [wD7F1], a
    xor a, a
    ld [wD7F2], a
    farcall Func_014_7D7F
    ld a, [wD7F5]
    ld [wD7B4], a
    xor a, a
    ld [wD782], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 67 of the `rst $00` table in Func_014_4BA0
; no direct call (reached through a table, a jump or a vector)
; reads: wD7B4
; writes: rRAMG2, rRAMB, wD7B5, wD7B6, wD7B4, wD7AB, wD7AD, wD7AF, ...
; points at: sB356, wC986, sA000
Func_014_4BA0_Case43::
Jump_014_543F:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    ld a, [wD7B4]
    cp a, $1D
    jr z, Jump_014_5457
    ld c, $6F
    call Multiply8
    ld de, sB356
    add hl, de
    xor a, a
    jr Jump_014_545C

Jump_014_5457::
    ld hl, sA000
    ld a, $01

Jump_014_545C::
    ld [rRAMB], a
    ld de, wC986
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
    ld [wD7B5], a
    ld [wD7B6], a
    ld [wD7B4], a
    farcall Func_01D_5E79
    call Func_014_4932
    xor a, a
    ld [wD7AB], a
    ld [wD7AD], a
    ld [wD7AF], a
    ld [wD7AC], a
    ld [wD7AE], a
    ret

; entry 6 of the `rst $00` table in ScriptCommandEB_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
ScriptCommandEB_Run_Case06::
Jump_014_5492:: ; address name
    ld a, [wD781]
    rst $00
    dw Func_014_43CC_Case00
    dw Func_014_4B5A
    dw Func_014_43CC_Case1F
    dw Func_014_43CC_Case20
    dw Func_014_4F30_Case04
    dw Func_014_43CC_Case05
    dw Func_014_43CC_Case23
    dw Func_014_43CC_Case07
    dw Func_014_4F30_Case08
    dw Func_014_43CC_Case09
    dw Func_014_43CC_Case0A
    dw Func_014_43CC_Case0B
    dw Func_014_43CC_Case00
    dw Func_014_43CC_Case0D
    dw Func_014_43CC_Case0E
    dw Func_014_43CC_Case0F
    dw Func_014_4F30_Case10

; entry 4 of the `rst $00` table in Func_014_4F30
; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5, wD7F6, wD781
; writes: wD7F1, wD781
; points at: wC36C
Func_014_4F30_Case04::
Jump_014_54B8:: ; address name
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld b, a
    call Func_014_5979
    ld de, Data_014_5B8E
    ld hl, wC36C
    ld bc, $0C09
    call CopyRectTo20ByteRows_Bank14
    xor a, a
    ld [wD7F1], a
    farcall Func_01D_6AA5
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld [wD7F1], a
    farcall Func_01D_5B4D
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 8 of the `rst $00` table in Func_014_4F30
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wD781, wD7AB
; writes: wMenuInputResult, wD781, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
; points at: wC52D
Func_014_4F30_Case08::
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
    ld a, [wD781]
    sub a, $07
    ld [wD781], a
    ret

Jump_014_552E::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_014_5536::
    ld a, [wD781]
    add a, $08
    ld [wD781], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wD7AB]
    ld b, $BC
    ld hl, Data_014_5B1E
    call StoreBAtWordTableEntry_Bank14
    ld hl, wC52D
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
    ld a, [wD781]
    sub a, $04
    ld [wD781], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD7F1, wD7F2, wD781
; points at: wC40D
Func_014_556D:: ; heuristic: follows a terminator; C0
    ld c, $09
    ld hl, $01D4
    ld de, $0008
    xor a, a
    ld [wD7F1], a
    ld a, $0C
    ld [wD7F2], a
    call Func_014_5925
    ld de, Data_014_5595
    ld hl, wC40D
    ld bc, $0B01
    call CopyRectTo20ByteRows_Bank14
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Data_014_5595:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2

; entry 16 of the `rst $00` table in Func_014_4F30
; no direct call (reached through a table, a jump or a vector)
; writes: wD7B2, wD7B3, wD781, wD782, wD780
Func_014_4F30_Case10::
Jump_014_55A0:: ; address name
    ld hl, Data_014_5C8A
    ld de, Data_014_5C9A
    call Func_014_5898
    cp a, $FF
    ret nz
    ld a, $06
    ld [wD7B2], a
    ld a, $08
    ld [wD7B3], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $09
    ld [wD780], a
    farcall SaveAndHideSpriteState_Bank1E
    ret

; entry 7 of the `rst $00` table in ScriptCommandEB_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
ScriptCommandEB_Run_Case07::
Jump_014_55C9:: ; address name
    ld a, [wD781]
    rst $00
    dw Func_014_43CC_Case00
    dw Func_014_4B5A
    dw Func_014_43CC_Case02
    dw Func_014_43CC_Case03
    dw Func_014_43CC_Case04
    dw Func_014_43CC_Case05
    dw Func_014_43CC_Case06
    dw Func_014_43CC_Case07
    dw Func_014_43CC_Case08
    dw Func_014_43CC_Case09
    dw Func_014_43CC_Case0A
    dw Func_014_43CC_Case0B
    dw Func_014_43CC_Case00
    dw Func_014_43CC_Case0D
    dw Func_014_43CC_Case0E
    dw Func_014_43CC_Case0F
    dw Func_014_43CC_Case10
    dw Func_014_43CC_Case11
    dw Func_014_556D_Case12
    dw Func_014_43CC_Case09
    dw Func_014_43CC_Case0A
    dw Func_014_43CC_Case0B
    dw Func_014_43CC_Case00
    dw Func_014_43CC_Case0D
    dw Func_014_43CC_Case0E
    dw Func_014_43CC_Case0F

; entry 17 of the `rst $00` table in Func_014_43CC
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wTwoChoiceCursor, wD781, wD7AB
; writes: wD781, wD782, wScriptCommandType, wScriptStartRequest, wTwoChoiceCursor
Func_014_43CC_Case11::
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
    call Func_014_56EB
    jp Jump_014_4EA7

Jump_014_5623::
    call Func_014_4EBF
    ld a, [wD7AB]
    ld b, $C3
    ld hl, Data_014_5B1E
    call StoreBAtWordTableEntry_Bank14
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $08
    ld [wD781], a
    xor a, a
    ld [wD782], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 18 of the `rst $00` table in Func_014_556D
; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5, wD7F6, wD781
; writes: rRAMG2, rRAMB, wD7F1, wD7F2, wD781
; points at: sB356, sA000
Func_014_556D_Case12::
Jump_014_5649:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    cp a, $1D
    jr z, Jump_014_566D
    ld c, $6F
    call Multiply8
    ld de, sB356
    add hl, de
    xor a, a
    jr Jump_014_5672

Jump_014_566D::
    ld hl, sA000
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
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld [wD7F1], a
    xor a, a
    ld [wD7F2], a
    farcall Func_014_7D7F
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 8 of the `rst $00` table in ScriptCommandEB_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wD7FC
ScriptCommandEB_Run_Case08::
Jump_014_56A4:: ; address name
    ld a, $01
    ld [wD7FC], a
    farcall ScriptCommandE8_Run
    ret

; 1 call site from 1 routine (e.g. Func_014_43CC_Case32)
; writes: rRAMG2, rRAMB, wC8D9
; points at: wC8CF, wC130
Func_014_56B0::
    push bc
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, b
    ld a, [hl]
    ld c, $01
    call CopyRecordNameToWC8CF
    ld a, $F0
    ld [wC8D9], a
    xor a, a
    ld [rRAMG2], a
    ld hl, wC8CF
    ld de, wC130
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

; 2 call sites from 2 routines (e.g. Func_014_43CC_Case3E, Func_014_43CC_Case11)
; reads: wD7F5, wD7F6, wC140
; writes: wD7F2, wD7F3, wD7F4, wD7F1, wC8D9, wC140
; points at: sB356, wC8CF, wC140, sA000
Func_014_56EB::
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    cp a, $1D
    jr z, Jump_014_570A
    ld c, $6F
    call Multiply8
    ld de, sB356
    add hl, de
    xor a, a
    jr Jump_014_570F

Jump_014_570A::
    ld hl, sA000
    ld a, $01

Jump_014_570F::
    ld [wD7F2], a
    ld a, l
    ld [wD7F3], a
    ld a, h
    ld [wD7F4], a
    xor a, a
    ld [wD7F1], a
    farcall Func_01D_795D
    ld a, $F0
    ld [wC8D9], a
    ld hl, wC8CF
    ld de, wC140
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
    ld a, [wC140]
    cp a, $E0
    ret c
    ld a, $F0
    ld [wC140], a
    ret

; 1 call site from 1 routine (e.g. Func_014_43CC_Case2F)
; reads: wD7F5, wD7F6
; writes: rRAMG2, rRAMB, wC8D9
; points at: wC8CF, wC140
Func_014_574E::
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, $01
    call CopyRecordNameToWC8CF
    ld a, $F0
    ld [wC8D9], a
    xor a, a
    ld [rRAMG2], a
    ld hl, wC8CF
    ld de, wC140
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

; 1 call site from 1 routine (e.g. Func_014_43CC_Case2F)
; reads: wD7B4, wC130
; writes: wD7F2, wD7F3, wD7F4, wD7F1, wC8D9, wC132
; points at: sB356, wC8CF, wC130, sA000
Func_014_578E::
    ld a, [wD7B4]
    cp a, $1D
    jr z, Jump_014_57A1
    ld c, $6F
    call Multiply8
    ld de, sB356
    add hl, de
    xor a, a
    jr Jump_014_57A6

Jump_014_57A1::
    ld hl, sA000
    ld a, $01

Jump_014_57A6::
    ld [wD7F2], a
    ld a, l
    ld [wD7F3], a
    ld a, h
    ld [wD7F4], a
    xor a, a
    ld [wD7F1], a
    farcall Func_01D_795D
    ld a, $F0
    ld [wC8D9], a
    ld hl, wC8CF
    ld de, wC130
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
    ld a, [wC130]
    cp a, $E0
    ret c
    ld a, $F0
    ld [wC132], a
    ret

; DE = source, HL = destination, BC = count: copies BC bytes (BC = 0 copies 65536); DE and HL end past the copy; clobbers A, BC = 0 (E-0064) (the same 9 bytes appear in 13 banks)
; 5 call sites from 5 routines (e.g. ScriptCommandEC_Run_Case00, ScriptCommandEB_Run_Case00, Func_014_5925, Func_014_4F30, ...)
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
; 3 call sites from 3 routines (e.g. ScriptCommandEC_Run_Case00, ScriptCommandEB_Run_Case00, Func_014_5925)
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
; 21 call sites from 21 routines (e.g. ScriptCommandEC_Run_Case00, ScriptCommandEB_Run_Case02_Sub04, ScriptCommandEB_Run_Table2_Case03, Func_014_4BA0_Case41, ...)
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
; 15 call sites from 14 routines (e.g. ScriptCommandEB_Run_Table2_Case03, Func_014_4BA0_Case2F, Func_014_4932, Func_014_43CC_Case2E, ...)
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
; 17 call sites from 17 routines (e.g. ScriptCommandEC_Run_Case00, ScriptCommandEB_Run_Table2_Case03, Func_014_4BA0_Case41, Func_014_4BA0_Case32, ...)
; reads: wIsCGB
; writes: wC554, wC555, rVBK, rSVBK
; points at: wScreenTileBuffer, wD000
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
    ld [wC554], a
    ld a, h
    adc a, $01
    ld [wC555], a
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

; 5 call sites from 5 routines (e.g. ScriptCommandEB_Run_Table2_Case01, Func_014_43CC_Case2D, Func_014_4F30_Case10, Func_014_43CC_Case0D, ...)
; reads: wD785, wD784
; writes: wD784, wD785
Func_014_5898::
    xor a, a
    ld [wD784], a

Jump_014_589C::
    push hl
    push de
    ld a, [wD785]
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
    ld a, [wD785]
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
    ld a, [wD785]
    inc a
    ld [wD785], a
    ld a, [wD784]
    inc a
    ld [wD784], a
    cp a, $08
    jr c, Jump_014_589C
    xor a, a
    ret

Jump_014_58E2::
    pop de
    pop hl
    xor a, a
    ld [wD785], a
    ld [wD784], a
    ld a, $FF
    ret

; 2 call sites from 2 routines (e.g. Func_014_43CC_Case3C, Func_014_43CC_Case08)
Func_014_58EE::
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
; 16 call sites from 14 routines (e.g. ScriptCommandEB_Run_Case02, Func_014_4BA0_Case31, Func_014_4BA0_Case2F, Func_014_43CC_Case3E, ...)
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

; 4 call sites from 4 routines (e.g. ScriptCommandEB_Run_Table2_Case03, Func_014_4BA0_Case2F, Func_014_43CC_Case2C, Func_014_43CC_Case0F)
; writes: wD7F1, wD7F2
Func_014_5910::
    ld c, $02
    ld hl, $0280
    ld de, $00B4
    xor a, a
    ld [wD7F1], a
    ld a, $08
    ld [wD7F2], a
    call Func_014_5925
    ret

; 4 call sites from 4 routines (e.g. Func_014_5910, Func_014_4932, Func_014_43CC_Case09, Func_014_556D)
; reads: wD7F1, wD7F2, wIsCGB
; points at: wScreenTileBuffer, wD000
Func_014_5925::
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
    ld a, [wD7F1]
    ld b, a
    ld a, [wD7F2]
    ld c, a
    call CopyBytesDEToHL_Bank14
    pop de
    pop hl
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_014_5966
    push hl
    push de
    ld de, wD000
    add hl, de
    pop de
    push de
    push hl
    ld hl, wD000
    add hl, de
    ld e, l
    ld d, h
    pop hl
    ld a, [wD7F1]
    ld b, a
    ld a, [wD7F2]
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
    jr nz, Func_014_5925
    ret

; 2 call sites from 2 routines (e.g. Func_014_43CC_Case21, Func_014_4F30_Case04)
; reads: hFFC6
; writes: rRAMG2, rRAMB, wD09D, wD09E
Func_014_5979::
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, b
    ld c, $0D
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    and a, $0F
    ld [wD09D], a
    ld a, $C7
    ld [wD09E], a
    farcall Func_016_7A48
    xor a, a
    ld [rRAMG2], a
    ret

; 1 call site from 1 routine (e.g. Func_014_4BA0)
Func_014_599F::
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
; 1 call site from 1 routine (e.g. Func_014_4BA0)
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

; 1 call site from 1 routine (e.g. Func_014_4BA0_Case15)
; writes: rRAMB, wD7F6, wD7F7, wD7F5
; points at: sB356, sA000
Func_014_59D0::
    ld hl, sB356
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
    ld hl, sA000
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
    ld de, sB356
    add hl, de
    ld a, l
    ld [wD7F6], a
    ld a, h
    ld [wD7F7], a
    xor a, a
    ld [wD7F5], a
    pop bc
    xor a, a
    ret

Jump_014_5A15::
    pop bc
    ld hl, sA000
    ld a, l
    ld [wD7F6], a
    ld a, h
    ld [wD7F7], a
    ld a, $01
    ld [wD7F5], a
    xor a, a
    ret

Data_014_5A28:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $051A28, $5C

Data_014_5A84:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $D0, $41, $00, $43, $90, $42, $40, $43, $10, $42, $50, $42, $F0, $42, $C0, $41
    db $70, $43, $F0, $40, $C0, $43, $D0, $42, $80, $43, $80, $41, $10, $49, $10, $49
    db $10, $49, $10, $49, $10, $49, $20, $41, $70, $41, $A0, $41, $10, $49, $10, $49
    db $10, $49, $10, $49, $10, $49, $10, $49, $10, $49, $70, $4A, $10, $49, $FF, $FF

Data_014_5AC4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $051AC4, $5A

Data_014_5B1E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $79, $C3, $A1, $C3, $C9, $C3, $F1, $C3, $19, $C4, $22, $C4, $4A, $C4, $80, $C3
    db $A8, $C3, $D0, $C3, $F8, $C3, $20, $C4

Data_014_5B36:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $051B36, $58

Data_014_5B8E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $051B8E, $A8

Data_014_5C36:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $70, $8A, $80, $8A, $90, $8A, $A0, $8A, $B0, $8A, $C0, $8A, $D0, $8A, $E0, $8A
    db $F0, $8A, $FF, $FF

Data_014_5C4A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $40, $43, $10, $42, $50, $42, $F0, $42, $C0, $41, $70, $43, $F0, $40, $C0, $43
    db $D0, $42, $FF, $FF

Data_014_5C5E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $40, $8A, $50, $8A, $60, $8A, $00, $8F, $10, $8F, $20, $8F, $30, $8F, $40, $8F
    db $E0, $8C, $F0, $8C, $FF, $FF

Data_014_5C74:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $D0, $41, $00, $43, $90, $42, $10, $49, $10, $49, $10, $49, $10, $49, $10, $49
    db $30, $42, $90, $42, $FF, $FF

Data_014_5C8A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $97, $10, $97, $20, $97, $30, $97, $40, $97, $50, $97, $60, $97, $FF, $FF

Data_014_5C9A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $30, $41, $20, $43, $A0, $42, $30, $43, $90, $41, $50, $41, $FF, $FF

; 5 call sites from 5 routines (e.g. Func_007_65F1_Table2_Case05, ScriptCommandF0_Run_Case05, ScriptCommandED_Run_Case06, Func_016_6A4E_Case02, ...)
; reads: wFadeState, wCFA8
Func_014_5CA8::
    ld a, [wFadeState]
    and a, a
    ret nz
    ld a, [wCFA8]
    rst $00
    dw Func_014_5CA8_Case00
    dw Func_014_5CA8_Case01
    dw Func_014_5CA8_Case02
    dw Func_014_5CA8_Case03
    dw Func_014_5CA8_Case04
    dw Func_014_5CA8_Case05
    dw Func_014_5CA8_Case06
    dw Func_014_5CA8_Case07

; entry 0 of the `rst $00` table in Func_014_5CA8
; no direct call (reached through a table, a jump or a vector)
; reads: wCFA9
Func_014_5CA8_Case00::
Jump_014_5CC1:: ; address name
    ld a, [wCFA9]
    rst $00
    dw Func_014_5CA8_Table2_Case00
    dw Func_014_5CA8_Table2_Case01
    dw Func_014_5CA8_Table2_Case02
    dw Func_014_5CA8_Table2_Case03
    dw Func_014_5CA8_Table2_Case04

; entry 0 of the `rst $00` table in Func_014_5CA8
; no direct call (reached through a table, a jump or a vector)
; reads: hFFB9, wCFA9
; writes: wD7F5, wD7F6, wD7F1, wD7F2, wD7F3, wD7F4, wD7F7, hScrollY, ...
; points at: wCFA8
Func_014_5CA8_Table2_Case00::
Jump_014_5CCF:: ; address name
    ld hl, wCFA8
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
    ld [wD7F5], a
    ld a, l
    ld [wD7F6], a
    ld de, $5E12
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
    xor a, a
    ldh [hScrollY], a
    ldh [hScrollX], a
    ldh a, [hFFB9]
    ld [wD7BC], a
    ld a, $01
    ldh [hFFBA], a
    ld a, $02
    ldh [hFFB9], a
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
    ld a, [wCFA9]
    inc a
    ld [wCFA9], a
    xor a, a
    ld [wD7F5], a
    ret

; entry 1 of the `rst $00` table in Func_014_5CA8
; no direct call (reached through a table, a jump or a vector)
; reads: wCFA9
; writes: wCFA9, wD7F5
Func_014_5CA8_Table2_Case01::
Jump_014_5D72:: ; address name
    ld hl, Data_014_6D56
    ld de, Data_014_6DF8
    call Func_014_6BF8
    cp a, $FF
    jr nz, Jump_014_5D86
    ld a, [wCFA9]
    inc a
    ld [wCFA9], a

Jump_014_5D86::
    xor a, a
    ld [wD7F5], a
    ret

; entry 2 of the `rst $00` table in Func_014_5CA8
; no direct call (reached through a table, a jump or a vector)
; reads: wD7F2, wCFA9
; writes: wD7F5, wD7F6, wD7F1, wD7F2, wD7F3, wD7F4, wD7F7, wCFA9
Func_014_5CA8_Table2_Case02::
Jump_014_5D8B:: ; address name
    ld a, [wD7F2]
    push af
    call BGMapAddressAtScroll_Bank14_6BCF
    ld a, h
    ld [wD7F5], a
    ld a, l
    ld [wD7F6], a
    ld de, Data_014_6FE7
    ld a, d
    ld [wD7F1], a
    ld a, e
    ld [wD7F2], a
    ld a, $14
    ld [wD7F3], a
    ld a, $12
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    farcall Func_01F_5D2A
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
    ld hl, Data_014_6F3E
    ld de, vTiles2 + $550
    call CopyTileBytesToVRAM_Bank14
    ld a, [wCFA9]
    inc a
    ld [wCFA9], a
    xor a, a
    ld [wD7F5], a
    ret

; entry 3 of the `rst $00` table in Func_014_5CA8
; no direct call (reached through a table, a jump or a vector)
; reads: wD7F1, wD7F2, wIsCGB, wCFA9, wD7F4, wD7F5
; writes: wSpriteSlotCount, wC527, wCFA9, wD7F5, wD7F1, wD7F2, wD7F3, wD7F4
; points at: wD7F1, wCF8B, wSpriteSlots, hFFC6
Func_014_5CA8_Table2_Case03::
Jump_014_5DE0:: ; address name
    ld hl, wD7F1
    ld de, wCF8B
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
    ld a, [wD7F1]
    or a, a
    jr nz, Jump_014_5E44
    ld hl, Data_014_5E9F
    ld a, [wD7F2]
    or a, a
    jr z, Jump_014_5E10
    ld hl, Data_014_5EAF

Jump_014_5E10::
    ld de, wSpriteSlots
    ld b, $10
    call CopyBytesDEFromHL_Bank14
    ld hl, Data_014_5E93
    ld a, [wD7F2]
    or a, a
    jr z, Jump_014_5E24
    ld hl, Data_014_5E99

Jump_014_5E24::
    ld de, hFFC6
    ld b, $06
    call CopyBytesDEFromHL_Bank14
    farcall Func_004_431F
    ld a, $01
    ld [wSpriteSlotCount], a
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_014_5E62
    ld a, $7F
    ld [wC527], a
    jr Jump_014_5E62

Jump_014_5E44::
    ld a, [wD7F4]
    ld [wD7F1], a
    ld a, [wD7F5]
    ld [wD7F2], a
    xor a, a
    ld [wD7F3], a
    ld [wD7F4], a
    ld a, $80
    ld [wD7F5], a
    farcall Func_01D_6973

Jump_014_5E62::
    ld hl, wCF8B
    ld de, wD7F1
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
    ld a, [wCFA9]
    inc a
    ld [wCFA9], a
    xor a, a
    ld [wD7F5], a
    ret

; the same 7 bytes as CopyBytesDEFromHL (34:406E)
; 2 call sites from 1 routine (e.g. Func_014_5CA8_Table2_Case03)
CopyBytesDEFromHL_Bank14::
Func_014_5E8C:: ; address name
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, CopyBytesDEFromHL_Bank14
    ret

Data_014_5E93:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $01, $04, $00, $80

Data_014_5E99:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $00, $01, $01, $00, $80

Data_014_5E9F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $01, $00, $00, $08, $08, $04, $00, $00, $00, $00, $08, $08, $04, $00, $00

Data_014_5EAF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $01, $01, $00, $08, $08, $01, $00, $00, $00, $00, $08, $08, $04, $00, $00

; entry 4 of the `rst $00` table in Func_014_5CA8
; no direct call (reached through a table, a jump or a vector)
; reads: wD7F1, wD786, wCFA8
; writes: rRAMG2, rRAMB, wCFBF, wCFC0, wCFA9, wCFA8, wD7F5, wCFC2
; points at: wC6FE, wCFAD
Func_014_5CA8_Table2_Case04::
Jump_014_5EBF:: ; address name
    call Func_014_6A28
    ld a, [wD7F1]
    and a, a
    jp z, Jump_014_5F12
    cp a, $01
    jp z, Jump_014_5F44
    cp a, $02
    jp z, Jump_014_5F44
    ld hl, wC6FE
    ld a, [wD786]
    add_a_to_hl
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, $01
    call SRAMRecordAddress
    ld de, wCFAD
    ld c, $00

Jump_014_5EF2::
    push hl
    push bc
    ld a, [hl]
    cp a, $F0
    jr z, Jump_014_5F07
    call Func_014_631C
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
    ld [wCFBF], a
    ld [wCFC0], a
    jr Jump_014_5F44

Jump_014_5F12::
    ld de, $0000
    call TestFlagBit
    jr c, Jump_014_5F30
    ld hl, wCFAD
    ld a, $0C
    ld [hl+], a
    ld a, $32
    ld [hl+], a
    ld a, $25
    ld [hl+], a
    ld a, $2C
    ld [hl], a
    ld a, $04
    ld [wCFC2], a
    jr Jump_014_5F44

Jump_014_5F30::
    ld hl, wCFAD
    ld a, $1D
    ld [hl+], a
    ld a, $24
    ld [hl+], a
    ld a, $35
    ld [hl+], a
    ld a, $24
    ld [hl], a
    ld a, $04
    ld [wCFC2], a

Jump_014_5F44::
    call Func_014_6804
    xor a, a
    ld [wCFA9], a
    ld a, [wCFA8]
    inc a
    ld [wCFA8], a
    xor a, a
    ld [wD7F5], a
    ret

; entry 1 of the `rst $00` table in Func_014_5CA8
; no direct call (reached through a table, a jump or a vector)
; reads: wCFA9
Func_014_5CA8_Case01::
Jump_014_5F57:: ; address name
    call Func_014_6804
    ld a, [wCFA9]
    rst $00
    dw CopyBytesDEFromHL_Bank14_Case00
    dw CopyBytesDEFromHL_Bank14_Case01
    dw CopyBytesDEFromHL_Bank14_Case02
    dw CopyBytesDEFromHL_Bank14_Case03
    dw CopyBytesDEFromHL_Bank14_Case04
    dw CopyBytesDEFromHL_Bank14_Case00
    dw CopyBytesDEFromHL_Bank14_Case01
    dw CopyBytesDEFromHL_Bank14_Case02
    dw CopyBytesDEFromHL_Bank14_Case03
    dw CopyBytesDEFromHL_Bank14_Case09

; entry 0 of the `rst $00` table in CopyBytesDEFromHL_Bank14
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wCFA9, wCFBF, wCFC0
; writes: wCFBF, wCFC0, wD7F5, wCFA9
CopyBytesDEFromHL_Bank14_Case00::
Jump_014_5F72:: ; address name
    call Func_014_6992
    ld b, $55
    call WriteTileBAtScrollOffset47PlusWCFC2
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
    call CopyBytesDEFromHL_Bank14_Case00_Sub01
    ret

Jump_014_5FA7::
    call Func_014_6189
    ld a, [wCFC0]
    and a, a
    jr nz, Jump_014_5FC3
    ld a, $04
    ld [wCFC0], a
    ld a, [wCFBF]
    cp a, $06
    jr c, Jump_014_5FC7
    ld a, $0D
    ld [wCFBF], a
    jr Jump_014_5FC7

Jump_014_5FC3::
    dec a
    ld [wCFC0], a

Jump_014_5FC7::
    call CopyBytesDEFromHL_Bank14_Case00_Sub01
    ld a, $69
    call QueueSoundEffect
    xor a, a
    ld [wD7F5], a
    ret

Jump_014_5FD4::
    call Func_014_6189
    ld a, [wCFC0]
    cp a, $04
    jr c, Jump_014_5FE4
    xor a, a
    ld [wCFC0], a
    jr Jump_014_600D

Jump_014_5FE4::
    cp a, $02
    jr nz, Jump_014_5FF6
    ld a, [wCFBF]
    cp a, $0D
    jr c, Jump_014_6006
    ld a, $0D
    ld [wCFBF], a
    jr Jump_014_6006

Jump_014_5FF6::
    cp a, $03
    jr nz, Jump_014_6006
    ld a, [wCFBF]
    cp a, $06
    jr c, Jump_014_6006
    ld a, $0D
    ld [wCFBF], a

Jump_014_6006::
    ld a, [wCFC0]
    inc a
    ld [wCFC0], a

Jump_014_600D::
    call CopyBytesDEFromHL_Bank14_Case00_Sub01
    ld a, $69
    call QueueSoundEffect
    xor a, a
    ld [wD7F5], a
    ret

Jump_014_601A::
    call Func_014_6189
    ld a, [wCFC0]
    ld hl, Data_014_605E
    add_a_to_hl
    ld b, [hl]
    ld a, [wCFBF]
    cp a, b
    jr c, Jump_014_6035
    xor a, a
    ld [wCFBF], a
    jr Jump_014_6051

Jump_014_6035::
    ld a, [wCFC0]
    cp a, $04
    jr nz, Jump_014_604A
    ld a, [wCFBF]
    cp a, $05
    jr c, Jump_014_604A
    ld a, $0D
    ld [wCFBF], a
    jr Jump_014_6051

Jump_014_604A::
    ld a, [wCFBF]
    inc a
    ld [wCFBF], a

Jump_014_6051::
    call CopyBytesDEFromHL_Bank14_Case00_Sub01
    ld a, $69
    call QueueSoundEffect
    xor a, a
    ld [wD7F5], a
    ret

Data_014_605E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $10, $10, $10, $0D, $0D

Jump_014_6063::
    call Func_014_6189
    ld a, [wCFBF]
    and a, a
    jr nz, Jump_014_607D
    ld a, [wCFC0]
    ld hl, Data_014_605E
    add_a_to_hl
    ld a, [hl]
    ld [wCFBF], a
    jr Jump_014_6099

Jump_014_607D::
    ld a, [wCFC0]
    cp a, $04
    jr nz, Jump_014_6092
    ld a, [wCFBF]
    cp a, $0D
    jr c, Jump_014_6092
    ld a, $05
    ld [wCFBF], a
    jr Jump_014_6099

Jump_014_6092::
    ld a, [wCFBF]
    dec a
    ld [wCFBF], a

Jump_014_6099::
    call CopyBytesDEFromHL_Bank14_Case00_Sub01
    ld a, $69
    call QueueSoundEffect
    xor a, a
    ld [wD7F5], a
    ret

Jump_014_60A6::
    ld a, $69
    call QueueSoundEffect
    call CopyBytesDEFromHL_Bank14_Case00_Sub02
    ld a, [wCFA9]
    inc a
    inc a
    ld [wCFA9], a
    xor a, a
    ld [wD7F5], a
    ret

Jump_014_60BB::
    ld a, $69
    call QueueSoundEffect
    call CopyBytesDEFromHL_Bank14_Case00_Sub01
    ld a, [wCFA9]
    inc a
    ld [wCFA9], a
    xor a, a
    ld [wD7F5], a
    ret

Jump_014_60CF::
    ld a, $69
    call QueueSoundEffect
    call Func_014_6189
    ld a, $0D
    ld [wCFBF], a
    ld a, $04
    ld [wCFC0], a
    xor a, a
    ld [wD7F5], a
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wD7F5
; points at: wCFAD
Func_014_60E6:: ; heuristic: follows a terminator; C0
    call Func_014_6C3F
    ld hl, wCFAD

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
    call Func_014_6875
    pop bc
    cp a, $FF
    jr nz, Jump_014_6112
    xor a, a
    ld [wD7F5], a
    ret

Jump_014_6112::
    ld a, $69
    call QueueSoundEffect
    ld hl, wCFAD

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
    ld [wD7F5], a
    ret

Jump_014_612D::
    ld a, b
    ld [hl], a
    ld hl, wCFAD

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
    ld [wD7F5], a
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
    ld [wD7F5], a
    ret

Jump_014_6154::
    dec hl
    ld b, $8E
    push bc
    call Func_014_68B5
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
    ld [wD7F5], a
    ret

; only called from CopyBytesDEFromHL_Bank14_Case00 (E-0047)
; 6 call sites from 1 routine (e.g. CopyBytesDEFromHL_Bank14_Case00)
; reads: wCFC1, wCFC0, wCFBF
; writes: wCFC1
CopyBytesDEFromHL_Bank14_Case00_Sub01::
Func_014_6172:: ; address name
    ld a, [wCFC1]
    inc a
    ld [wCFC1], a
    cp a, $10
    jr c, Jump_014_6185
    cp a, $18
    jr c, Func_014_6189
    xor a, a
    ld [wCFC1], a

Jump_014_6185::
    ld b, $55
    jr Jump_014_618F

; 7 call sites from 2 routines (e.g. Func_014_631C, CopyBytesDEFromHL_Bank14_Case00)
; reads: wCFC0, wCFBF
Func_014_6189::
    ld b, $C3
    jr Jump_014_618F

; only called from CopyBytesDEFromHL_Bank14_Case00 (E-0047)
; 1 call site from 1 routine (e.g. CopyBytesDEFromHL_Bank14_Case00)
; reads: wCFC0, wCFBF
CopyBytesDEFromHL_Bank14_Case00_Sub02::
Func_014_618D:: ; address name
    ld b, $55

Jump_014_618F::
    ld a, [wCFC0]
    ld hl, Data_014_61E2
    cp a, $00
    jr z, Jump_014_61A1
    ld e, $22
    ld d, $00

Jump_014_619D::
    add hl, de
    dec a
    jr nz, Jump_014_619D

Jump_014_61A1::
    ld a, [wCFBF]
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
    ld a, [wCFBF]
    cp a, $0D
    ret nz
    ld a, [wCFC0]
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

Data_014_61E2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0521E2, $AA

; entry 1 of the `rst $00` table in CopyBytesDEFromHL_Bank14
; no direct call (reached through a table, a jump or a vector)
; reads: wCFC2, wCFA9, wCFC3
; writes: wCFA9, wD7F5, wCFC3, wCFC2
; points at: wCFAD
CopyBytesDEFromHL_Bank14_Case01::
Jump_014_628C:: ; address name
    ld b, $55
    call WriteTileBAtScrollOffset47PlusWCFC2
    ld a, [wCFC2]
    and a, a
    jr nz, Jump_014_62A6
    call Func_014_6A28
    ld a, [wCFA9]
    dec a
    ld [wCFA9], a
    xor a, a
    ld [wD7F5], a
    ret

Jump_014_62A6::
    ld b, $C3
    call WriteTileBAtScrollOffset47PlusWCFC2
    ld hl, wCFAD

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
    ld hl, wCFAD

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
    call Func_014_6C3F
    ld a, [wCFC3]
    and a, a
    jr z, Jump_014_62EF
    xor a, a
    ld [wCFC3], a
    jr Jump_014_62F6

Jump_014_62EF::
    ld a, [wCFC2]
    dec a
    ld [wCFC2], a

Jump_014_62F6::
    ld a, [wCFA9]
    dec a
    ld [wCFA9], a
    xor a, a
    ld [wD7F5], a
    ret

; entry 2 of the `rst $00` table in CopyBytesDEFromHL_Bank14
; no direct call (reached through a table, a jump or a vector)
; reads: wCFC0, wCFBF, wCFC2, wCFA9, wCFC3, wCFA8
; writes: wCFC3, wCFC2, wCFA9, wD7F5, wCFBF, wCFC0, wCFA8
; points at: wCFAD
CopyBytesDEFromHL_Bank14_Case02::
Jump_014_6302:: ; address name
    ld a, [wCFC0]
    ld hl, Data_014_6F4E
    cp a, $00
    jr z, Jump_014_6314
    ld e, $11
    ld d, $00

Jump_014_6310::
    add hl, de
    dec a
    jr nz, Jump_014_6310

Jump_014_6314::
    ld a, [wCFBF]
    add a, l
    ld l, a
    jr nc, Func_014_631C
    inc h

; 1 call site from 1 routine (e.g. Func_014_5CA8_Table2_Case04)
; reads: wCFC2, wCFA9, wCFC3, wCFA8
; writes: wCFC3, wCFC2, wCFA9, wD7F5, wCFBF, wCFC0, wCFA8
; points at: wCFAD
Func_014_631C::
    ld a, [hl]
    cp a, $FD
    jp z, Jump_014_643F
    cp a, $FE
    jp z, Jump_014_644C
    cp a, $FF
    jp z, Jump_014_6458
    push af
    ld hl, wCFAD

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
    ld a, [wCFC2]
    cp a, $04
    jr nz, Jump_014_6371
    ld a, $01
    ld [wCFC3], a
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
    call Func_014_68B5
    cp a, $FF
    jp z, Jump_014_63FD
    jr Jump_014_639A

Jump_014_6392::
    call Func_014_6875
    cp a, $FF
    jp z, Jump_014_63FD

Jump_014_639A::
    pop af
    inc hl
    ld [hl], a
    ld a, [wCFC2]
    cp a, $04
    jr z, Jump_014_63A8

Jump_014_63A4::
    ld b, $F0
    jr Jump_014_63B0

Jump_014_63A8::
    ld a, [wCFC3]
    and a, a
    jr z, Jump_014_63A4
    ld b, $9F

Jump_014_63B0::
    ld hl, wCFAD
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
    ld [wCFC3], a
    jr Jump_014_63FE

Jump_014_63CE::
    ld b, $C3
    call WriteTileBAtScrollOffset47PlusWCFC2
    ld a, [wCFC2]
    cp a, $04
    jr nc, Jump_014_63E3
    ld a, [wCFC2]
    inc a
    ld [wCFC2], a
    jr Jump_014_63F0

Jump_014_63E3::
    call Func_014_6189
    ld a, $0D
    ld [wCFBF], a
    ld a, $04
    ld [wCFC0], a

Jump_014_63F0::
    ld a, [wCFA9]
    dec a
    dec a
    ld [wCFA9], a
    xor a, a
    ld [wD7F5], a
    ret

Jump_014_63FD::
    pop af

Jump_014_63FE::
    ld a, [wCFC2]
    cp a, $04
    jr c, Jump_014_63F0
    ld a, [wCFC3]
    and a, a
    jr z, Jump_014_63F0
    call Func_014_6189
    ld a, $0D
    ld [wCFBF], a
    ld a, $04
    ld [wCFC0], a
    jr Jump_014_63F0

Jump_014_641A::
    pop af
    push af
    cp a, $8D
    jr z, Jump_014_63FD
    dec hl
    call Func_014_68B5
    cp a, $FF
    jr z, Jump_014_63FD
    inc hl
    ld a, $8E
    ld [hl], a
    call Func_014_6C3F
    jr Jump_014_63FD

Jump_014_6431::
    pop af
    push af
    cp a, $8E
    jr z, Jump_014_63FD
    ld a, $8D
    ld [hl], a
    call Func_014_6C3F
    jr Jump_014_63FD

Jump_014_643F::
    ld a, [wCFA9]
    inc a
    inc a
    ld [wCFA9], a
    xor a, a
    ld [wD7F5], a
    ret

Jump_014_644C::
    ld a, [wCFA9]
    dec a
    ld [wCFA9], a
    xor a, a
    ld [wD7F5], a
    ret

Jump_014_6458::
    ld a, [wCFC2]
    and a, a
    jr z, Jump_014_646A
    ld a, [wCFA8]
    inc a
    ld [wCFA8], a
    xor a, a
    ld [wD7F5], a
    ret

Jump_014_646A::
    ld a, [wCFA9]
    inc a
    ld [wCFA9], a
    xor a, a
    ld [wD7F5], a
    ret

; entry 3 of the `rst $00` table in CopyBytesDEFromHL_Bank14
; no direct call (reached through a table, a jump or a vector)
; reads: wCFA8
; writes: wCFA8, wD7F5
CopyBytesDEFromHL_Bank14_Case03::
Jump_014_6476:: ; address name
    call CopyBytesDEFromHL_Bank14_Case03_Sub01
    call Func_014_6992
    ld a, [wCFA8]
    inc a
    ld [wCFA8], a
    xor a, a
    ld [wD7F5], a
    ret

; entry 4 of the `rst $00` table in CopyBytesDEFromHL_Bank14
; no direct call (reached through a table, a jump or a vector)
; reads: wCFA9
; writes: wCFA9, wD7F5
CopyBytesDEFromHL_Bank14_Case04::
Jump_014_6488:: ; address name
    ld hl, Data_014_6DF6
    ld de, Data_014_6E98
    call Func_014_6BF8
    cp a, $FF
    jr nz, Jump_014_64A9
    ld a, [wCFA9]
    inc a
    ld [wCFA9], a
    ld de, Data_01F_48E0
    ld hl, vTiles2 + $480
    ld b, $1F
    ld c, $10
    call OrFromBankWaitVRAM

Jump_014_64A9::
    xor a, a
    ld [wD7F5], a
    ret

; entry 9 of the `rst $00` table in CopyBytesDEFromHL_Bank14
; no direct call (reached through a table, a jump or a vector)
; writes: wCFA9, wD7F5
CopyBytesDEFromHL_Bank14_Case09::
Jump_014_64AE:: ; address name
    ld hl, Data_014_6DF6
    ld de, Data_014_6DF8
    call Func_014_6BF8
    cp a, $FF
    jr nz, Jump_014_64BF
    xor a, a
    ld [wCFA9], a

Jump_014_64BF::
    xor a, a
    ld [wD7F5], a
    ret

; entry 2 of the `rst $00` table in Func_014_5CA8
; no direct call (reached through a table, a jump or a vector)
; reads: wCFAA
Func_014_5CA8_Case02::
Jump_014_64C4:: ; address name
    call Func_014_6804
    ld a, [wCFAA]
    rst $00
    dw Func_014_631C_Case00
    dw Func_014_631C_Case01
    dw Func_014_631C_Case02
    dw Func_014_631C_Case03

; entry 0 of the `rst $00` table in Func_014_631C
; no direct call (reached through a table, a jump or a vector)
; reads: wCFAA
; writes: wC52D, wC52E, wC52F, wC530, wCFAA, wD7F5
Func_014_631C_Case00::
Jump_014_64D3:: ; address name
    ld hl, vTiles2 + $5C0
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
    ld a, [wCFAA]
    inc a
    ld [wCFAA], a
    xor a, a
    ld [wD7F5], a
    ret

; entry 1 of the `rst $00` table in Func_014_631C
; no direct call (reached through a table, a jump or a vector)
; reads: wCFAA
; writes: wD7F5, wD7F6, wD7F1, wD7F2, wD7F3, wD7F4, wD7F7, wCFAA
Func_014_631C_Case01::
Jump_014_64F8:: ; address name
    call BGMapAddressAtScroll_Bank14_6BCF
    ld de, $01E0
    add hl, de
    ld a, h
    ld [wD7F5], a
    ld a, l
    ld [wD7F6], a
    ld de, Data_014_7177
    ld a, d
    ld [wD7F1], a
    ld a, e
    ld [wD7F2], a
    ld a, $14
    ld [wD7F3], a
    ld a, $01
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    farcall Func_01F_5D2A
    ld a, [wCFAA]
    inc a
    ld [wCFAA], a
    xor a, a
    ld [wD7F5], a
    ret

; entry 2 of the `rst $00` table in Func_014_631C
; no direct call (reached through a table, a jump or a vector)
; reads: wCFAA
; writes: wD7F5, wD7F6, wD7F1, wD7F2, wD7F3, wD7F4, wD7F7, wCFAA
Func_014_631C_Case02::
Jump_014_6532:: ; address name
    call BGMapAddressAtScroll_Bank14_6BCF
    ld de, $01C0
    add hl, de
    ld a, h
    ld [wD7F5], a
    ld a, l
    ld [wD7F6], a
    ld de, Data_014_71B3
    ld a, d
    ld [wD7F1], a
    ld a, e
    ld [wD7F2], a
    ld a, $14
    ld [wD7F3], a
    ld a, $03
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    farcall Func_01F_5D2A
    ld a, [wCFAA]
    inc a
    ld [wCFAA], a
    xor a, a
    ld [wD7F5], a
    ret

; entry 3 of the `rst $00` table in Func_014_631C
; no direct call (reached through a table, a jump or a vector)
; reads: wCFA8
; writes: wD7F5, wD7F6, wD7F1, wD7F2, wD7F3, wD7F4, wD7F7, wCFAA, ...
Func_014_631C_Case03::
Jump_014_656C:: ; address name
    call BGMapAddressAtScroll_Bank14_6BCF
    ld de, $01A0
    add hl, de
    ld a, h
    ld [wD7F5], a
    ld a, l
    ld [wD7F6], a
    ld de, Data_014_714F
    ld a, d
    ld [wD7F1], a
    ld a, e
    ld [wD7F2], a
    ld a, $14
    ld [wD7F3], a
    ld a, $05
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    farcall Func_01F_5D2A
    xor a, a
    ld [wCFAA], a
    ld a, [wCFA8]
    inc a
    ld [wCFA8], a
    xor a, a
    ld [wD7F5], a
    ret

; entry 3 of the `rst $00` table in Func_014_5CA8
; no direct call (reached through a table, a jump or a vector)
; reads: wCFAA
Func_014_5CA8_Case03::
Jump_014_65AA:: ; address name
    call Func_014_6804
    ld a, [wCFAA]
    rst $00
    dw Func_014_631C_Table2_Case00
    dw Func_014_631C_Table2_Case01
    dw Func_014_631C_Table2_Case02
    dw Func_014_631C_Table2_Case03
    dw Func_014_631C_Table2_Case04
    dw Func_014_631C_Table2_Case05

; entry 5 of the `rst $00` table in Func_014_631C
; no direct call (reached through a table, a jump or a vector)
; reads: wCFA8
; writes: wStringCategory, wStringIndex, wCFA8, wCFBD, wD7F5
Func_014_631C_Table2_Case05::
Jump_014_65BD:: ; address name
    xor a, a
    ld [wStringCategory], a
    ld a, $03
    ld [wStringIndex], a
    call Func_014_6B76
    cp a, $FF
    ret nz
    ld a, [wCFA8]
    add a, $04
    ld [wCFA8], a
    xor a, a
    ld [wCFBD], a
    ld [wD7F5], a
    ret

; entry 0 of the `rst $00` table in Func_014_631C
; no direct call (reached through a table, a jump or a vector)
; reads: wD7F1, wCFAA
; writes: wCFAA, wD7F5
Func_014_631C_Table2_Case00::
Jump_014_65DC:: ; address name
    ld a, [wD7F1]
    and a, a
    jp z, Jump_014_661F
    call Func_014_6AB7
    cp a, $FF
    jr z, Jump_014_663A
    call Func_014_6B08
    cp a, $FF
    jr z, Jump_014_663A
    call Func_014_6A45
    cp a, $FF
    jr nz, Jump_014_6604
    ld a, [wCFAA]
    inc a
    ld [wCFAA], a
    xor a, a
    ld [wD7F5], a
    ret

Jump_014_6604::
    call Func_014_6AB7
    cp a, $FF
    jr z, Jump_014_663A
    call Func_014_6B08
    cp a, $FF
    jr z, Jump_014_663A
    ld a, [wCFAA]
    add a, $03
    ld [wCFAA], a
    xor a, a
    ld [wD7F5], a
    ret

Jump_014_661F::
    call Func_014_6AB7
    cp a, $FF
    jr z, Jump_014_663A
    call Func_014_6B08
    cp a, $FF
    jr z, Jump_014_663A
    ld a, [wCFAA]
    inc a
    inc a
    ld [wCFAA], a
    xor a, a
    ld [wD7F5], a
    ret

Jump_014_663A::
    ld a, [wCFAA]
    add a, $05
    ld [wCFAA], a
    xor a, a
    ld [wD7F5], a
    ret

; entry 1 of the `rst $00` table in Func_014_631C
; no direct call (reached through a table, a jump or a vector)
; reads: wCFAA
; writes: wStringCategory, wStringIndex, wCFAA, wD7F5
Func_014_631C_Table2_Case01::
Jump_014_6647:: ; address name
    xor a, a
    ld [wStringCategory], a
    ld a, $02
    ld [wStringIndex], a
    call Func_014_6B76
    cp a, $FF
    jr nz, Jump_014_665F
    ld a, [wCFAA]
    inc a
    inc a
    ld [wCFAA], a

Jump_014_665F::
    xor a, a
    ld [wD7F5], a
    ret

; entry 2 of the `rst $00` table in Func_014_631C
; no direct call (reached through a table, a jump or a vector)
; reads: wCFAA
; writes: wCFAA, wD7F5
; points at: wC130, wCFAD
Func_014_631C_Table2_Case02::
Jump_014_6664:: ; address name
    ld de, wC130
    ld a, [wCFAA]
    inc a
    ld [wCFAA], a
    jp Func_014_631C_Table2_Case03

; entry 3 of the `rst $00` table in Func_014_631C
; no direct call (reached through a table, a jump or a vector)
; reads: wCFAA
; writes: wCFAA, wD7F5
; points at: wCFAD, wC130
Func_014_631C_Table2_Case03::
Jump_014_6671:: ; address name
    ld hl, wCFAD
    ld de, wC130

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
    ld a, [wCFAA]
    inc a
    ld [wCFAA], a
    xor a, a
    ld [wD7F5], a
    ret

; entry 4 of the `rst $00` table in Func_014_631C
; no direct call (reached through a table, a jump or a vector)
; reads: wCFA8
; writes: wStringCategory, wStringIndex, wCFAA, wCFA8, wD7F5
Func_014_631C_Table2_Case04::
Jump_014_6694:: ; address name
    xor a, a
    ld [wStringCategory], a
    ld [wStringIndex], a
    call Func_014_6B76
    cp a, $FF
    ret nz
    xor a, a
    ld [wCFAA], a
    ld a, [wCFA8]
    inc a
    ld [wCFA8], a
    xor a, a
    ld [wD7F5], a
    ret

; entry 4 of the `rst $00` table in Func_014_5CA8
; no direct call (reached through a table, a jump or a vector)
; reads: wCFA8
; writes: wD7F5, wD7F6, wD7F1, wD7F2, wD7F3, wD7F4, wD7F7, wCFA8
Func_014_5CA8_Case04::
Jump_014_66B1:: ; address name
    call Func_014_6804
    call BGMapAddressAtScroll_Bank14_6BCF
    ld de, $010E
    add hl, de
    ld a, h
    ld [wD7F5], a
    ld a, l
    ld [wD7F6], a
    ld de, Data_014_71EF
    ld a, d
    ld [wD7F1], a
    ld a, e
    ld [wD7F2], a
    ld a, $06
    ld [wD7F3], a
    ld a, $05
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    farcall Func_01F_5D2A
    ld a, [wCFA8]
    inc a
    ld [wCFA8], a
    ld a, $6C
    call QueueSoundEffect
    xor a, a
    ld [wD7F5], a
    ret

; entry 5 of the `rst $00` table in Func_014_5CA8
; no direct call (reached through a table, a jump or a vector)
; reads: wCFBD, wCFA8
; writes: wCFA8, wCFBD, wD7F5
Func_014_5CA8_Case05::
Jump_014_66F3:: ; address name
    call Func_014_6804
    call Func_014_68D5
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_014_6704
    cp a, $FF
    jr z, Jump_014_6714
    ret

Jump_014_6704::
    ld a, [wCFA8]
    inc a
    inc a
    ld [wCFA8], a
    xor a, a
    ld [wCFBD], a
    ld [wD7F5], a
    ret

Jump_014_6714::
    ld a, [wCFBD]
    and a, a
    jr nz, Jump_014_6704
    ld a, [wCFA8]
    inc a
    ld [wCFA8], a
    xor a, a
    ld [wCFBD], a
    ld [wD7F5], a
    ret

; entry 6 of the `rst $00` table in Func_014_5CA8
; no direct call (reached through a table, a jump or a vector)
; reads: wCFAA
Func_014_5CA8_Case06::
Jump_014_6729:: ; address name
    call Func_014_6804
    ld a, [wCFAA]
    rst $00
    dw Func_014_631C_Table3_Case00
    dw Func_014_631C_Table3_Case01

; entry 0 of the `rst $00` table in Func_014_631C
; no direct call (reached through a table, a jump or a vector)
; reads: wCFAA
; writes: wD7F5, wD7F6, wD7F1, wD7F2, wD7F3, wD7F4, wD7F7, wCFAA
Func_014_631C_Table3_Case00::
Jump_014_6734:: ; address name
    call BGMapAddressAtScroll_Bank14_6BCF
    ld a, h
    ld [wD7F5], a
    ld a, l
    ld [wD7F6], a
    ld de, $5E12
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
    ld a, [wCFAA]
    inc a
    ld [wCFAA], a
    xor a, a
    ld [wD7F5], a
    ret

; entry 1 of the `rst $00` table in Func_014_631C
; no direct call (reached through a table, a jump or a vector)
; reads: wD7BC
; writes: wC52D, wC52E, wC52F, wC530, hFFBA, wD7F5
; points at: wCFAD, wC8CF, wCFA8
Func_014_631C_Table3_Case01::
Jump_014_676A:: ; address name
    ld hl, wCFAD
    ld de, wC8CF

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
    ld hl, wCFA8
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
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    xor a, a
    ldh [hFFBA], a
    ld a, [wD7BC]
    ld a, $FF
    ld [wD7F5], a
    ret

; entry 7 of the `rst $00` table in Func_014_5CA8
; no direct call (reached through a table, a jump or a vector)
; reads: wCFA9
; writes: wD7F5, wD7F6, wD7F1, wD7F2, wD7F3, wD7F4, wD7F7, wCFA8, ...
Func_014_5CA8_Case07::
Jump_014_67B0:: ; address name
    call Func_014_6804
    call BGMapAddressAtScroll_Bank14_6BCF
    ld de, $0100
    add hl, de
    ld a, h
    ld [wD7F5], a
    ld a, l
    ld [wD7F6], a
    ld de, Data_014_7087
    ld a, d
    ld [wD7F1], a
    ld a, e
    ld [wD7F2], a
    ld a, $14
    ld [wD7F3], a
    ld a, $0A
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    farcall Func_01F_5D2A
    ld a, $01
    ld [wCFA8], a
    xor a, a
    ld [wCFAA], a
    ld a, [wCFA9]
    cp a, $04
    jr nc, Jump_014_67FA
    xor a, a
    ld [wCFA9], a
    xor a, a
    ld [wD7F5], a
    ret

Jump_014_67FA::
    ld a, $05
    ld [wCFA9], a
    xor a, a
    ld [wD7F5], a
    ret

; 8 call sites from 8 routines (e.g. Func_014_5CA8_Case07, Func_014_5CA8_Case06, Func_014_5CA8_Case05, Func_014_5CA8_Case04, ...)
; reads: wD7F1, wD7F4, wD7F5
; writes: wD7F1, wD7F2, wD7F3, wD7F4, wD7F5, wD7F6
; points at: wD7F1, wCF8B
Func_014_6804::
    ld hl, wD7F1
    ld de, wCF8B
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
    ld a, [wD7F1]
    or a, a
    jr nz, Jump_014_6830
    farcall Func_004_44CE
    jr Jump_014_6856

Jump_014_6830::
    ld a, [wD7F4]
    ld [wD7F1], a
    ld a, [wD7F5]
    ld [wD7F2], a
    xor a, a
    ld [wD7F3], a
    ld a, $10
    ld [wD7F4], a
    ld a, $18
    ld [wD7F5], a
    xor a, a
    ld [wD7F6], a
    ld c, $00
    farcall Func_01D_6A3D

Jump_014_6856::
    ld hl, wCF8B
    ld de, wD7F1
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

; 2 call sites from 2 routines (e.g. Func_014_631C, Func_014_60E6)
Func_014_6875::
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

Data_014_688A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $3E, $3F, $40, $41, $42, $29, $2A, $2B, $2C, $2D, $2E, $2F, $30, $31, $32, $33
    db $34, $35, $37, $38, $75, $76, $77, $78, $79, $60, $61, $62, $63, $64, $65, $66
    db $67, $68, $69, $6A, $6B, $6C, $6E, $6F, $26, $5A, $FF

; 3 call sites from 2 routines (e.g. Func_014_631C, Func_014_60E6)
Func_014_68B5::
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

Data_014_68CA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $3E, $3F, $40, $41, $42, $75, $76, $77, $78, $79, $FF

; 1 call site from 1 routine (e.g. Func_014_5CA8_Case05)
; reads: wJoypadPressedRepeat, wJoypadPressed, wCFBD
; writes: wMenuInputResult, wCFBD, wCFBE
Func_014_68D5::
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
    call Func_014_6943
    xor a, a
    ld [wMenuInputResult], a
    ret

Jump_014_68F3::
    call Func_014_695A
    ld a, [wCFBD]
    and a, a
    jr nz, Jump_014_6903
    ld a, $01
    ld [wCFBD], a
    jr Jump_014_691D

Jump_014_6903::
    dec a
    ld [wCFBD], a
    jr Jump_014_691D

Jump_014_6909::
    call Func_014_695A
    ld a, [wCFBD]
    cp a, $01
    jr c, Jump_014_6919
    xor a, a
    ld [wCFBD], a
    jr Jump_014_691D

Jump_014_6919::
    inc a
    ld [wCFBD], a

Jump_014_691D::
    xor a, a
    ld [wCFBE], a
    call Func_014_6943
    ld a, $69
    call QueueSoundEffect
    ld a, $FD
    ld [wMenuInputResult], a
    ret

Jump_014_692F::
    ld a, $69
    call QueueSoundEffect
    call Func_014_695E
    ld a, $FF
    ld [wMenuInputResult], a
    ret

Jump_014_693D::
    ld a, $FE
    ld [wMenuInputResult], a
    ret

; 2 call sites from 1 routine (e.g. Func_014_68D5)
; reads: wCFBE, wCFBD
; writes: wCFBE
Func_014_6943::
    ld a, [wCFBE]
    inc a
    ld [wCFBE], a
    cp a, $10
    jr c, Jump_014_6956
    cp a, $18
    jr c, Func_014_695A
    xor a, a
    ld [wCFBE], a

Jump_014_6956::
    ld b, $BB
    jr Jump_014_6960

; 2 call sites from 1 routine (e.g. Func_014_68D5)
; reads: wCFBD
Func_014_695A::
    ld b, $C3
    jr Jump_014_6960

; 1 call site from 1 routine (e.g. Func_014_68D5)
; reads: wCFBD
Func_014_695E::
    ld b, $BC

Jump_014_6960::
    ld a, [wCFBD]
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

Data_014_697D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2F, $01, $6F, $01

; Copies 16 bytes from [HL] to [DE]; each byte is written with interrupts off after waiting for rSTAT bit 1 to clear; clobbers A, C; HL and DE advance (the same 17 bytes appear in 7 banks)
; 2 call sites from 2 routines (e.g. Func_014_6C3F, Func_014_5CA8_Table2_Case02)
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

; 2 call sites from 2 routines (e.g. CopyBytesDEFromHL_Bank14_Case03, CopyBytesDEFromHL_Bank14_Case00)
; writes: wCFBC
; points at: wCFAD
Func_014_6992::
    ld hl, wCFAD
    ld bc, $0000

Jump_014_6998::
    ld a, [hl]
    cp a, $F0
    ret z
    ld [wCFBC], a
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
; 6 call sites from 4 routines (e.g. Func_014_631C, CopyBytesDEFromHL_Bank14_Case03_Sub01_Sub01, CopyBytesDEFromHL_Bank14_Case01, CopyBytesDEFromHL_Bank14_Case00)
; reads: wCFC2, rSTAT
WriteTileBAtScrollOffset47PlusWCFC2::
Func_014_6A0D:: ; address name
    push bc
    call BGMapAddressAtScroll_Bank14_6BCF
    ld de, $0047
    add hl, de
    ld a, [wCFC2]
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

; 2 call sites from 2 routines (e.g. Func_014_5CA8_Table2_Case04, CopyBytesDEFromHL_Bank14_Case01)
; points at: wCFAD
Func_014_6A28::
    ld hl, wCFAD
    ld c, $00

Jump_014_6A2D::
    ld a, $F0
    ld [hl+], a
    inc c
    ld a, c
    cp a, $0B
    jr c, Jump_014_6A2D
    ld hl, wCFAD
    ld c, $00

Jump_014_6A3B::
    ld a, $9F
    ld [hl+], a
    inc c
    ld a, c
    cp a, $05
    jr c, Jump_014_6A3B
    ret

; 1 call site from 1 routine (e.g. Func_014_631C_Table2_Case00)
; reads: wD7F1, wD786
; writes: rRAMG2, rRAMB
; points at: sA000, wCFAD, wC6FE
Func_014_6A45::
    ld hl, sA000
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
    ld de, wCFAD
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
    ld a, [wD7F1]
    cp a, $03
    jr nz, Jump_014_6AB2
    ld hl, wC6FE
    ld a, [wD786]
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

; 3 call sites from 1 routine (e.g. Func_014_631C_Table2_Case00)
; reads: wD7F1
; points at: wCFAD
Func_014_6AB7::
    ld hl, Data_014_70F0
    ld c, $00

Jump_014_6ABC::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_014_6AF0
    push bc
    push hl
    ld de, wCFAD
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
    ld a, [wD7F1]
    cp a, $03
    jr nz, Jump_014_6B03

Jump_014_6B03::
    pop hl
    pop bc
    ld a, $FF
    ret

; 3 call sites from 1 routine (e.g. Func_014_631C_Table2_Case00)
; points at: wCFAD
Func_014_6B08::
    ld hl, wCFAD
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

; 3 call sites from 3 routines (e.g. Func_014_631C_Table2_Case05, Func_014_631C_Table2_Case04, Func_014_631C_Table2_Case01)
; reads: wCFC4, wC52B, wD7F1
; writes: wCFC4, wC52D, wC52E, wC52F, wC530
Func_014_6B76::
    ld a, [wCFC4]
    and a, a
    jr z, Jump_014_6B82
    cp a, $01
    jr z, Jump_014_6BA4
    jr Jump_014_6BBF

Jump_014_6B82::
    ld hl, vTiles2 + $5C0
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
    ld a, [wCFC4]
    inc a
    ld [wCFC4], a
    xor a, a
    ret

Jump_014_6BA4::
    ld a, [wD7F1]
    cp a, $03
    jr z, Jump_014_6BB0
    ld de, Data_014_7003
    jr Jump_014_6BB3

Jump_014_6BB0::
    ld de, Data_014_706D

Jump_014_6BB3::
    call BeginStringDisplay
    ld a, [wCFC4]
    inc a
    ld [wCFC4], a
    xor a, a
    ret

Jump_014_6BBF::
    ld a, [wC52B]
    bit 0, a
    jr nz, Jump_014_6BCD
    xor a, a
    ld [wCFC4], a
    ld a, $FF
    ret

Jump_014_6BCD::
    xor a, a
    ret

; HL = $9800 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX, hScrollY); clobbers A, DE (the same 41 bytes appear in 3 banks)
; 12 call sites from 11 routines (e.g. Func_014_5CA8_Case07, Func_014_695E, Func_014_5CA8_Case04, CopyBytesDEFromHL_Bank14_Case00_Sub02, ...)
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

; 3 call sites from 3 routines (e.g. Func_014_5CA8_Table2_Case01, CopyBytesDEFromHL_Bank14_Case09, CopyBytesDEFromHL_Bank14_Case04)
; reads: wCFAB
; writes: wCFAB, wCFAC
Func_014_6BF8::
    push hl
    push de
    ld a, [wCFAB]
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
    ld a, [wCFAB]
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
    ld a, [wCFAB]
    inc a
    ld [wCFAB], a
    jr Func_014_6BF8

Jump_014_6C33::
    pop de
    pop hl
    xor a, a
    ld [wCFAB], a
    ld [wCFAC], a
    ld a, $FF
    ret

; 4 call sites from 3 routines (e.g. Func_014_631C, CopyBytesDEFromHL_Bank14_Case01, Func_014_60E6)
; reads: wCFC2
Func_014_6C3F::
    ld hl, Data_014_6C56
    ld a, [wCFC2]
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    ld de, Data_014_6C60
    call CopyTileBytesToVRAM_Bank14
    ret

Data_014_6C56:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $95, $10, $95, $20, $95, $30, $95, $40, $95

Data_014_6C60:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00

; only called from CopyBytesDEFromHL_Bank14_Case03 (E-0047)
; 1 call site from 1 routine (e.g. CopyBytesDEFromHL_Bank14_Case03)
; reads: wD7F1, wC5E7, wD7F3, wD7F2
; writes: wCFC2, wCFC3
; points at: wCFAD
CopyBytesDEFromHL_Bank14_Case03_Sub01::
Func_014_6C70:: ; address name
    ld a, [wD7F1]
    or a, a
    jp z, Jump_014_6D28
    ld a, [wC5E7]
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
    ld a, [wD7F3]
    and a, $0F
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, [wD7F2]
    ld c, a
    add a, a
    add a, c
    ld c, a
    ld a, [wD7F2]
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
    ld de, wCFAD
    call CopyBytesDEFromHL_Bank14_Case03_Sub01_Sub01
    ret

Jump_014_6CC0::
    sub a, $07
    ld b, a
    push bc
    ld a, [wD7F2]
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
    ld de, wCFAD
    call CopyBytesDEFromHL_Bank14_Case03_Sub01_Sub01
    ret

; only called from CopyBytesDEFromHL_Bank14_Case03_Sub01 (E-0047)
; 2 call sites from 1 routine (e.g. CopyBytesDEFromHL_Bank14_Case03_Sub01)
; writes: wCFC2, wCFC3
; points at: wCFAD
CopyBytesDEFromHL_Bank14_Case03_Sub01_Sub01::
Func_014_6CEA:: ; address name
    ld a, [hl]
    cp a, $F0
    jr z, Jump_014_6CF4
    ld [de], a
    inc de
    inc hl
    jr CopyBytesDEFromHL_Bank14_Case03_Sub01_Sub01

Jump_014_6CF4::
    ld b, $C3
    call WriteTileBAtScrollOffset47PlusWCFC2
    ld hl, wCFAD
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
    ld [wCFC3], a

Jump_014_6D18::
    ld a, c
    cp a, $05
    jr c, Jump_014_6D1F
    ld a, $04

Jump_014_6D1F::
    ld [wCFC2], a
    ld b, $55
    call WriteTileBAtScrollOffset47PlusWCFC2
    ret

Jump_014_6D28::
    ld a, [wD7F2]
    or a, a
    jr nz, Jump_014_6D42
    ld hl, wCFAD
    ld hl, wCFAD
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
    ld hl, wCFAD
    ld hl, wCFAD
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

Data_014_6D56:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $20, $90, $30, $90, $40, $90, $50, $90, $60, $90, $70, $90, $80, $90, $90, $90
    db $A0, $90, $B0, $90, $C0, $90, $D0, $90, $E0, $90, $F0, $90, $00, $91, $10, $91
    db $20, $91, $30, $91, $40, $91, $50, $91, $60, $91, $70, $91, $80, $91

Data_014_6D84:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $052D84, $72

Data_014_6DF6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $FF

Data_014_6DF8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $052DF8, $A0

Data_014_6E98:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $052E98, $A6

Data_014_6F3E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $00, $FF, $FF, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00

Data_014_6F4E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $052F4E, $99

Data_014_6FE7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $74, $8A, $8B, $8C, $6D, $9C, $FE, $FF, $FF, $FF, $FF, $FF, $01, $02, $03, $04
    db $05, $06, $07, $08, $09, $00, $FF, $FF, $FF, $FF, $FF, $FF

Data_014_7003:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $05, $70, $0D, $70, $1C, $70, $2B, $70, $4D, $70
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Is ", $F9, "0 correct?", $F0, "Is ", $F9, "0 correct?", $F0, "A monster already", $F1
    db "has that name.", $F7
    db $F0, "Sorry, that name", $F1
    db "can't be used.", $F7
    db $F0

Data_014_706D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $6F, $70, $77, $70, $84, $70, $91, $70, $B2, $70, $EB, $45, $90, $12, $36, $90
    db $F9, $00, $90, $18, $14, $98, $F0, $EB, $45, $90

Data_014_7087:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $12, $36, $90, $F9, $00, $90, $18, $14, $98, $F0, $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " That name is", $F1
    db "already in use.", $F7
    db $F0, $EB
    db $45, $90, $1D, $2B, $24, $37, $90, $31, $24, $30, $28, $90, $26, $24, $31, $41
    db $F1, $25, $28, $90, $38, $36, $28, $27, $B5, $FA, $F7, $F2, $22, $32, $38, $43
    db $2F, $90, $2B, $24, $39, $28, $90, $37, $32, $90, $38, $36, $28, $F1, $24, $31
    db $32, $37, $2B, $28, $35, $90, $31, $24, $30, $28, $B5, $F7, $F0

Data_014_70F0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0530F0, $5F

Data_014_714F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $00, $0F, $38, $26, $2E, $F0, $00, $00, $00, $00, $00, $0F
    db $1E, $0C, $14, $F0, $00, $00, $00, $00, $00, $1C, $2B, $2C, $37, $F0, $00, $00
    db $00, $00, $00, $1C, $11, $12, $1D, $F0

Data_014_7177:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $00, $1C, $28, $3B, $F0, $00, $00, $00, $00, $00, $00, $1C
    db $0E, $21, $F0, $00, $00, $00, $00, $00, $00, $19, $32, $32, $33, $F0, $00, $00
    db $00, $00, $00, $19, $18, $18, $19, $F0, $00, $00, $00, $00, $00, $0D, $32, $31
    db $2A, $F0, $00, $00, $00, $00, $00, $0D, $18, $17, $10, $F0

Data_014_71B3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $00, $19, $28, $31, $28, $F0, $00, $00, $00, $00, $00, $19
    db $0E, $17, $0E, $F0, $00, $00, $00, $00, $00, $0C, $2F, $2C, $37, $F0, $00, $00
    db $00, $00, $00, $0C, $15, $12, $1D, $F0, $00, $00, $00, $00, $00, $1D, $3A, $24
    db $37, $F0, $00, $00, $00, $00, $00, $1D, $20, $0A, $1D, $F0

Data_014_71EF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0531EF, $24A

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

; 4 call sites from 4 routines (e.g. Func_014_43CC_Case3F, Func_014_43CC_Case13, Func_014_4BA0_Case42, Func_014_556D_Case12)
; reads: wD7F1
; writes: rRAMG2, rRAMB, wD7F5, wD7F6, wD7F7
; points at: sB356, sB3C5, sA000, wCA2B
Func_014_7D7F::
    ld a, [wD7F1]
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
    ld de, sB356
    add hl, de
    jr Jump_014_7DAB

Jump_014_7D9E::
    ld hl, sA000
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
    ld hl, sB356
    ld de, sB3C5
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
    ld hl, sB356
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
    ld de, wCA2B
    ld hl, sA000
    ld a, $01
    ld [rRAMB], a
    ld b, $6F

Jump_014_7E24::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_014_7E24
    ld hl, sA000
    ld b, $6F

Jump_014_7E2F::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_014_7E2F
    pop hl
    xor a, a
    ld [rRAMB], a
    ld de, wCA2B
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
    ld hl, sB356
    ld c, $00

Jump_014_7E4D::
    ld a, [hl]
    bit 7, a
    jr nz, Jump_014_7E6D

Jump_014_7E52::
    ld a, c
    ld [wD7F5], a
    ld a, l
    ld [wD7F6], a
    ld a, h
    ld [wD7F7], a
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
    ld hl, sA000
    ld a, [hl]
    bit 7, a
    jr nz, Jump_014_7E89
    jr Jump_014_7E52

Jump_014_7E89::
    ld a, $FF
    ld [wD7F5], a
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    ret

; 19 call sites from 18 routines (e.g. Func_007_7DE5, ScriptCommandF4_Run_Table2_Case17, Func_014_43CC_Case3F, Func_014_4BA0_Case16, ...)
; reads: wD7F1, wD7F2, wC6FD
; writes: rRAMG2, rRAMB, wD7F3, wD7F5, wD7F6, wD7F7, wC6FD
; points at: sA000, sA0A5, wC6FE
Func_014_7E96::
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [wD7F1]
    cp a, $1E
    jr nc, Jump_014_7EB6
    ld c, $A5
    call Multiply8
    ld de, sA000
    add hl, de
    ld b, $A5

Jump_014_7EB1::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_014_7EB1

Jump_014_7EB6::
    ld hl, sA000
    ld de, sA0A5
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
    ld [wD7F3], a
    ld a, [wD7F2]
    and a, a
    jr nz, Jump_014_7F41
    ld a, [wD7F1]
    cp a, $1E
    jr nc, Jump_014_7F41
    ld b, a
    ld a, [wC6FD]
    ld e, a
    ld c, $00
    ld hl, wC6FE

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
    ld a, [wC6FD]
    dec a
    ld [wC6FD], a
    ld a, $01
    ld [wD7F3], a

Jump_014_7F41::
    ld hl, wC6FE
    ld a, [wD7F1]
    cp a, $1E
    jr nc, Jump_014_7F5F
    ld c, $00

Jump_014_7F4D::
    ld a, [hl]
    ld b, a
    ld a, [wD7F1]
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
    ld hl, sA000
    ld c, $00

Jump_014_7F64::
    ld a, [hl]
    cp a, $01
    jr z, Jump_014_7F85
    cp a, $02
    jr z, Jump_014_7F85
    ld a, c
    ld [wD7F5], a
    ld a, l
    ld [wD7F6], a
    ld a, h
    ld [wD7F7], a
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
    ld [wD7F5], a
    xor a, a
    ld [rRAMG2], a
    ret

; 1 call site from 1 routine (e.g. Func_001_6C48)
; reads: wD09D, wD09E, wD09F, wD0A0
Func_014_7F9C::
    ld a, [wD09D]
    ld c, a
    ld b, $00
    ld hl, Data_014_7439
    add hl, bc
    add hl, bc
    deref_hl
    ld a, [wD09E]
    ld c, a
    jr Jump_014_7FB9
    db $FA, $9E, $D0, $4F, $06, $00, $21, $1F, $79

Jump_014_7FB9::
    add hl, bc
    add hl, bc
    deref_hl
    ld a, [wD09F]
    ld e, a
    ld a, [wD0A0]
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
