SECTION "Bank F1", ROMX[$4000], BANK[$F1]
    db $F1

; only called from PauseMenu_State4 (E-0047)
; 1 call site from 1 routine (e.g. PauseMenu_State4)
; reads: wC0A0
PauseMenu_State4_Sub02::
Func_0F1_4001:: ; address name
    ld a, [wC0A0]
    rst $00
    dw Func_0F1_4001_Case00
    dw Func_0F1_4001_Case01
    dw Func_0F1_4001_Case02

; entry 0 of the `rst $00` table in Func_0F1_4001
; no direct call (reached through a table, a jump or a vector)
; reads: wC0A1
Func_0F1_4001_Case00::
Jump_0F1_400B:: ; address name
    ld a, [wC0A1]
    rst $00
    dw Func_0F1_4001_Table2_Case00
    dw Func_0F1_4001_Table2_Case01

; entry 0 of the `rst $00` table in Func_0F1_4001
; no direct call (reached through a table, a jump or a vector)
; reads: wD095
; writes: wC52D, wC52E, wC52F, wC530, wStringIndex, wStringCategory, wCF8B
; points at: wC0A1
Func_0F1_4001_Table2_Case00::
Jump_0F1_4013:: ; address name
    ld a, [wD095]
    or a, a
    call nz, Func_0F1_4866
    call Func_0F1_43E0
    call Func_0F1_41EE
    call Func_0F1_43B4
    call Func_0F1_42D9
    call CopyTileBufferToBGMap_BankF1
    ld hl, vTiles1 + $720
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0107
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld a, $1B
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    farcall ShowString_BankF0
    ld hl, wC0A1
    inc [hl]
    xor a, a
    ld [wCF8B], a
    ret

; entry 1 of the `rst $00` table in Func_0F1_4001
; no direct call (reached through a table, a jump or a vector)
; reads: wInventory, wJoypadPressed, wJoypadPressedRepeat, wMenuRowCount, wMenuPage, wC46E
; writes: wDataBankSave, wD082, wItemId, wC0A1, wC46F
; points at: wC46E, wInventory, wC150, wC60C, wC130, wC0A0
Func_0F1_4001_Table2_Case01::
Jump_0F1_4057:: ; address name
    ld a, [wInventory]
    or a, a
    jr nz, Jump_0F1_4062
    ld a, [wJoypadPressed]
    jr Jump_0F1_40DC

Jump_0F1_4062::
    ld de, $4A6A
    ld hl, wC46E
    call Func_0F1_4870
    ld a, [wJoypadPressedRepeat]
    and a, $C0
    jr z, Jump_0F1_407C
    ld a, [wMenuRowCount]
    cp a, $01
    ret z
    call Func_0F1_42D9
    ret

Jump_0F1_407C::
    ld hl, wC46E
    bit 7, [hl]
    jr z, Jump_0F1_4092
    res 7, [hl]
    call Func_0F1_43B4
    call Func_0F1_42D9
    call Func_0F1_4307
    call Func_0F1_43A0
    ret

Jump_0F1_4092::
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_0F1_40DC
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuPage]
    add a, a
    add a, a
    ld c, a
    ld a, [wC46E]
    add a, c
    ld [wD082], a
    ld hl, wInventory
    add_a_to_hl
    ld a, [hl]
    ld [wItemId], a
    ld l, a
    ld h, $05
    ld de, wC150
    call CopyStringHLToDE
    ld de, wC60C
    ld hl, wC130
    call Func_000_2FE1
    farcall LoadItemRecord
    ld hl, wC0A0
    inc [hl]
    xor a, a
    ld [wC0A1], a
    xor a, a
    ld [wC46F], a
    ret

Jump_0F1_40DC::
    bit 1, a
    jr z, Jump_0F1_40EC
    ld a, $40
    ld [wDataBankSave], a
    farcall Func_003_4339
    ret

Jump_0F1_40EC::
    bit 2, a
    ret z
    farcall Func_016_590C
    call Func_0F1_42D9
    call Func_0F1_4307
    ret

; entry 1 of the `rst $00` table in Func_0F1_4001
; no direct call (reached through a table, a jump or a vector)
; reads: wC0A1
Func_0F1_4001_Case01::
Jump_0F1_40FC:: ; address name
    ld a, [wC0A1]
    rst $00
    dw Func_0F1_4001_Table3_Case00
    dw Func_0F1_4001_Table3_Case01

; entry 0 of the `rst $00` table in Func_0F1_4001
; no direct call (reached through a table, a jump or a vector)
; writes: wMenuRowCount, wMenuPageCount
; points at: wC0A1
Func_0F1_4001_Table3_Case00::
Jump_0F1_4104:: ; address name
    call Func_0F1_422D
    call CopyTileBufferToBGMap_BankF1
    ld a, $02
    ld [wMenuRowCount], a
    ld a, $01
    ld [wMenuPageCount], a
    ld hl, wC0A1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_0F1_4001
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wC46F
; writes: wC0A1, wC0A0
; points at: wC46F, wC0A0
Func_0F1_4001_Table3_Case01::
Jump_0F1_4119:: ; address name
    ld de, Data_0F1_4A72
    ld hl, wC46F
    call Func_0F1_4870
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_0F1_4142
    ld a, [wC46F]
    and a, $01
    and a, a
    jr z, Jump_0F1_4133
    jr Jump_0F1_4145

Jump_0F1_4133::
    ld a, [wC46F]
    and a, $01
    add a, $02
    ld [wC0A0], a
    xor a, a
    ld [wC0A1], a
    ret

Jump_0F1_4142::
    bit 1, a
    ret z

Jump_0F1_4145::
    ld hl, wC0A0
    dec [hl]
    xor a, a
    ld [wC0A1], a
    ret

; entry 2 of the `rst $00` table in Func_0F1_4001
; no direct call (reached through a table, a jump or a vector)
; reads: wC0A1
Func_0F1_4001_Case02::
Jump_0F1_414E:: ; address name
    ld a, [wC0A1]
    rst $00
    dw Func_0F1_4001_Table4_Case00
    dw Func_0F1_4001_Table4_Case01
    dw Func_0F1_4001_Table4_Case02
    dw Func_0F1_4001_Table4_Case03

; entry 0 of the `rst $00` table in Func_0F1_4001
; no direct call (reached through a table, a jump or a vector)
; reads: wItemId, wD082
; writes: wD7F1, wCF8B, wDataBankSave, wStringIndex
; points at: wInventory, wC0A1
Func_0F1_4001_Table4_Case00::
Jump_0F1_415A:: ; address name
    ld a, [wItemId]
    cp a, $1F
    jr z, Jump_0F1_4183
    cp a, $21
    jr z, Jump_0F1_4183
    ld b, $2B
    ld c, $2E
    cp a, c
    jr nc, Jump_0F1_416E
    cp a, b
    ccf

Jump_0F1_416E::
    jr c, Jump_0F1_4183
    ld b, $2F
    ld c, $40
    cp a, c
    jr nc, Jump_0F1_4179
    cp a, b
    ccf

Jump_0F1_4179::
    jr c, Jump_0F1_4183
    ld b, $54
    ld c, $5A
    jr c, Jump_0F1_4183
    jr Jump_0F1_4187

Jump_0F1_4183::
    ld a, $22
    jr Jump_0F1_41B9

Jump_0F1_4187::
    ld [wD7F1], a
    farcall Func_0F0_7284
    ld a, $FF
    ld [wCF8B], a
    ld a, $69
    call QueueSoundEffect
    ld a, [wD082]
    ld hl, wInventory
    add_a_to_hl
    ld [hl], $00
    farcall Func_016_4C48
    ld a, $40
    ld [wDataBankSave], a
    farcall Func_003_4339
    ret

Jump_0F1_41B9::
    ld [wStringIndex], a
    ld hl, wC0A1
    inc [hl]
    ld a, $69
    call QueueSoundEffect
    ret

; entry 1 of the `rst $00` table in Func_0F1_4001
; no direct call (reached through a table, a jump or a vector)
; points at: wC0A1
Func_0F1_4001_Table4_Case01::
Jump_0F1_41C6:: ; address name
    call Func_0F1_42B6
    call CopyTileBufferToBGMap_BankF1
    ld hl, wC0A1
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_0F1_4001
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory
; points at: wC0A1
Func_0F1_4001_Table4_Case02::
Jump_0F1_41D1:: ; address name
    xor a, a
    ld [wStringCategory], a
    farcall BeginStringDisplay_BankF0_48A0
    ld hl, wC0A1
    inc [hl]
    ret

; entry 3 of the `rst $00` table in Func_0F1_4001
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B
; writes: wC0A0, wC0A1
Func_0F1_4001_Table4_Case03::
Jump_0F1_41E0:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    xor a, a
    ld [wC0A0], a
    xor a, a
    ld [wC0A1], a
    ret

; 2 call sites from 2 routines (e.g. Func_0F1_4001_Table2_Case00, Func_0F1_422D)
; reads: wInventory, wC0A7, wMenuPage
; points at: wC2A6
Func_0F1_41EE::
    call ClearScreenTileBuffer_BankF1
    ld e, $0B
    farcall CopyBlockToTileBuffer
    ld e, $0C
    farcall CopyBlockToTileBuffer
    ld a, [wInventory]
    or a, a
    ret z
    ld e, $0D
    farcall CopyBlockToTileBuffer
    ld a, [wC0A7]
    cp a, $02
    jr c, Jump_0F1_422C
    ld hl, wC2A6
    ld a, $C5
    ld [hl+], a
    ld a, [wMenuPage]
    add a, $E1
    ld [hl+], a
    ld a, $BE
    ld [hl+], a
    ld a, [wC0A7]
    add a, $E0
    ld [hl+], a
    ld [hl], $C6

Jump_0F1_422C::
    ret

; 4 call sites from 4 routines (e.g. Func_0F1_4001_Table3_Case00, Func_0F1_42B6, Func_0F1_4244, Func_0F1_4290)
; reads: wC46E
Func_0F1_422D::
    call Func_0F1_41EE
    ld e, $32
    farcall CopyBlockToTileBuffer
    ld a, [wC46E]
    and a, $07
    ld hl, $4A6A
    call Func_0F1_4983
    ret

; 1 call site from 1 routine (e.g. Func_0F1_4276)
; reads: wItemId
Func_0F1_4244:: ; heuristic: follows a terminator; C0
    call Func_0F1_422D
    ld e, $11
    farcall CopyBlockToTileBuffer
    ld e, $1B
    farcall CopyBlockToTileBuffer
    ld a, [wItemId]
    ld hl, Data_0F1_4613
    add_a_to_hl
    ld a, [hl]
    ld hl, Data_0F1_4676
    add a, a
    add_a_to_hl
    deref_hl
    call Func_0F1_49ED
    call Func_0F1_442F
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC46D
Func_0F1_4276:: ; heuristic: follows a terminator; C0
    call FillTilesFromRequest
    call Func_0F1_4244
    ld e, $10
    farcall CopyBlockToTileBuffer
    ld a, [wC46D]
    and a, $03
    ld hl, Func_0F1_4A5E
    call Func_0F1_4983
    ret

; 1 call site from 1 routine (e.g. Func_0F1_429C)
Func_0F1_4290:: ; heuristic: follows a terminator; C0
    call Func_0F1_422D
    ld e, $0F
    farcall CopyBlockToTileBuffer
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC46F
Func_0F1_429C:: ; heuristic: follows a terminator; C0
    call FillTilesFromRequest
    call Func_0F1_4290
    ld e, $10
    farcall CopyBlockToTileBuffer
    ld a, [wC46F]
    and a, $03
    ld hl, Data_0F1_4A72
    call Func_0F1_4983
    ret

; 1 call site from 1 routine (e.g. Func_0F1_4001_Table4_Case01)
; reads: wC46F
Func_0F1_42B6::
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    call FillTilesFromRequest
    call Func_0F1_422D
    ld e, $10
    farcall CopyBlockToTileBuffer
    ld a, [wC46F]
    and a, $03
    ld hl, Data_0F1_4A72
    call Func_0F1_4983
    ret

; 4 call sites from 2 routines (e.g. Func_0F1_4001_Table2_Case01, Func_0F1_4001_Table2_Case00)
; reads: wMenuPage, wC46E
; writes: wStringIndex, wStringCategory
; points at: wInventory
Func_0F1_42D9::
    ld a, [wMenuPage]
    and a, $0F
    add a, a
    add a, a
    ld c, a
    ld a, [wC46E]
    and a, $0F
    add a, c
    ld c, a
    ld b, $00
    ld hl, wInventory
    add hl, bc
    ld a, [hl]
    cp a, $1F
    jr nz, Jump_0F1_42F5
    ld a, $6F

Jump_0F1_42F5::
    ld [wStringIndex], a
    ld a, $06
    ld [wStringCategory], a
    ld hl, vTiles2 + $230
    ld de, $1203
    call Func_0F1_4A23
    ret

; 2 call sites from 1 routine (e.g. Func_0F1_4001_Table2_Case01)
; reads: wC52D, wC52E, wC52F, wC530, wInventory, wMenuPage
; writes: wC52F, wC530, wStringCategory, wStringIndex, wC52D, wC52E
; points at: wC61E, wInventory
Func_0F1_4307::
    ld a, [wC52D]
    ld l, a
    ld a, [wC52E]
    ld h, a
    push hl
    ld a, [wC52F]
    ld l, a
    ld a, [wC530]
    ld h, a
    push hl
    ld hl, $0901
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld a, [wInventory]
    or a, a
    jr nz, Jump_0F1_434F
    ld a, $08
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    ld hl, vTiles2 + $5C0
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    farcall ShowString_Bank08
    ld de, wC61E
    ld hl, vTiles2 + $650
    ld b, $03
    jr Jump_0F1_4363

Jump_0F1_434F::
    ld a, [wMenuPage]
    and a, $0F
    add a, a
    add a, a
    ld de, wInventory
    add a, e
    ld e, a
    jr nc, Jump_0F1_435E
    inc d

Jump_0F1_435E::
    ld b, $04
    ld hl, vTiles2 + $5C0

Jump_0F1_4363::
    ld a, $05
    ld [wStringCategory], a

Jump_0F1_4368::
    ld a, [de]
    cp a, $FF
    jr nz, Jump_0F1_436E
    xor a, a

Jump_0F1_436E::
    inc de
    ld [wStringIndex], a
    push bc
    push de
    push hl
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    farcall ShowString_Bank08
    pop hl
    ld de, $0090
    add hl, de
    pop de
    pop bc
    dec b
    jr nz, Jump_0F1_4368
    pop hl
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    pop hl
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ret

; 1 call site from 1 routine (e.g. Func_0F1_4001_Table2_Case01)
; reads: wMenuPageCount, wMenuPage
Func_0F1_43A0::
    ld a, [wMenuPageCount]
    or a, a
    jr z, Jump_0F1_43B3
    ld a, [wMenuPage]
    and a, $0F
    add a, $E1
    ld hl, vBGMap0 + $10F
    call WriteVRAMByte

Jump_0F1_43B3::
    ret

; 2 call sites from 2 routines (e.g. Func_0F1_4001_Table2_Case01, Func_0F1_4001_Table2_Case00)
; reads: wC0A7, wMenuPage, wMenuLastPageRows, wC46E
; writes: wMenuRowCount, wC46E
; points at: wMenuPage
Func_0F1_43B4::
    ld a, [wC0A7]
    dec a
    ld c, a
    ld a, [wMenuPage]
    and a, $0F
    cp a, c
    jr nz, Jump_0F1_43D5
    ld a, [wMenuLastPageRows]
    ld [wMenuRowCount], a
    ld c, a
    ld a, [wC46E]
    cp a, c
    jr c, Jump_0F1_43DA
    dec c
    ld a, c
    ld [wC46E], a
    jr Jump_0F1_43DA

Jump_0F1_43D5::
    ld a, $04
    ld [wMenuRowCount], a

Jump_0F1_43DA::
    ld hl, wMenuPage
    res 7, [hl]
    ret

; 1 call site from 1 routine (e.g. Func_0F1_4001_Table2_Case00)
; reads: wMenuPage, wMenuLastPageRows
; writes: wMenuPageCount, wC0A7, wMenuLastPageRows, wMenuRowCount
; points at: wInventory
Func_0F1_43E0::
    ld hl, wInventory
    ld bc, $1800

Jump_0F1_43E6::
    ld a, [hl+]
    or a, a
    jr z, Jump_0F1_43FA
    cp a, $FF
    jr z, Jump_0F1_43F4
    inc c
    dec b
    jr nz, Jump_0F1_43E6
    jr Jump_0F1_43FA

Jump_0F1_43F4::
    dec hl
    xor a, a

Jump_0F1_43F6::
    ld [hl+], a
    dec b
    jr nz, Jump_0F1_43F6

Jump_0F1_43FA::
    ld b, c
    ld a, $04
    call DivideBByA
    ld a, c
    and a, $03
    jr z, Jump_0F1_4406
    inc b

Jump_0F1_4406::
    ld a, b
    cp a, $00
    jr nz, Jump_0F1_440D
    inc b
    ld a, b

Jump_0F1_440D::
    ld [wMenuPageCount], a
    ld [wC0A7], a
    ld a, c
    and a, $03
    or a, a
    jr nz, Jump_0F1_441B
    ld a, $04

Jump_0F1_441B::
    ld [wMenuLastPageRows], a
    ld a, [wMenuPage]
    cp a, b
    jr nz, Jump_0F1_4429
    ld a, [wMenuLastPageRows]
    jr Jump_0F1_442B

Jump_0F1_4429::
    ld a, $04

Jump_0F1_442B::
    ld [wMenuRowCount], a
    ret

; 1 call site from 1 routine (e.g. Func_0F1_4244)
; reads: wC46D, wItemId, hFFC6, hFFC7
; writes: rRAMG, rRAMB, wStringIndex, wStringCategory, hFFC6, hFFC7, wC2DE, wC2DF, ...
; points at: wC2D9, wC319, wC31D
Func_0F1_442F:: ; heuristic: follows a terminator; C0
    ld a, [wC46D]
    ld c, a
    ld a, [wItemId]
    ld hl, Data_0F1_4613
    add_a_to_hl
    ld a, [hl]
    push af
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    pop af
    or a, a
    jr z, Jump_0F1_446D
    cp a, $01
    jr z, Jump_0F1_4472
    cp a, $02
    jr z, Jump_0F1_44BA
    cp a, $03
    jr z, Jump_0F1_4489
    cp a, $04
    jr z, Jump_0F1_448E
    cp a, $05
    jr z, Jump_0F1_4493
    cp a, $06
    jr z, Jump_0F1_4498
    cp a, $07
    jr z, Jump_0F1_449D
    jp Jump_0F1_450D

Jump_0F1_446D::
    ld a, c
    ld c, $5B
    jr Jump_0F1_4475

Jump_0F1_4472::
    ld a, c
    ld c, $5F

Jump_0F1_4475::
    call SRAMRecordAddressMapped
    ld a, [hl+]
    push hl
    ld h, [hl]
    ld l, a
    call HLToDecimalDigits
    ld de, wC319
    call WriteDecimalDigitTiles
    pop hl
    inc hl
    jr Jump_0F1_44A3

Jump_0F1_4489::
    ld a, c
    ld c, $6B
    jr Jump_0F1_44A0

Jump_0F1_448E::
    ld a, c
    ld c, $63
    jr Jump_0F1_44A0

Jump_0F1_4493::
    ld a, c
    ld c, $65
    jr Jump_0F1_44A0

Jump_0F1_4498::
    ld a, c
    ld c, $67
    jr Jump_0F1_44A0

Jump_0F1_449D::
    ld a, c
    ld c, $69

Jump_0F1_44A0::
    call SRAMRecordAddressMapped

Jump_0F1_44A3::
    deref_hl
    call HLToDecimalDigits
    ld de, wC31D
    call WriteDecimalDigitTiles
    ld a, $C3
    ld [wC2DE], a
    ld [wC2DF], a
    jp Jump_0F1_4582

Jump_0F1_44BA::
    ld a, c
    call MapIndexViaWC6FE
    call PersonalityIndexOfRecord
    ld c, a
    ld [wStringIndex], a
    ld a, $07
    ld [wStringCategory], a
    ld hl, Data_0F1_45B0
    ld b, $00
    add hl, bc
    ld a, [hl]
    push af
    ld hl, vTiles2 + $1A0
    ld de, $0901
    call Func_0F1_4A23
    pop af
    ld hl, wC319
    ld c, a
    ld b, c
    ld a, $1A

Jump_0F1_44E3::
    ld [hl+], a
    inc a
    dec b
    jr nz, Jump_0F1_44E3
    ld a, $09
    sub a, c
    ld b, a
    or a, a
    jr z, Jump_0F1_44F5
    ld a, $C3

Jump_0F1_44F1::
    ld [hl+], a
    dec b
    jr nz, Jump_0F1_44F1

Jump_0F1_44F5::
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
    jr Jump_0F1_4582

Jump_0F1_450D::
    ld a, c
    ld c, $A4
    call SRAMRecordAddressMapped
    ld a, [hl]
    push af
    or a, a
    jr z, Jump_0F1_451A
    add a, $3F

Jump_0F1_451A::
    ld [wStringIndex], a
    ld a, $05
    ld [wStringCategory], a
    ld hl, vTiles2 + $1A0
    ld de, $0901
    call Func_0F1_4A23
    pop af
    ld hl, Data_0F1_45CB
    add a, a
    add_a_to_hl
    ld b, [hl]
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    ld hl, wC2D9
    ld a, b
    ld c, a
    or a, a
    jr z, Jump_0F1_454C
    ld a, $1A

Jump_0F1_4546::
    ld [hl+], a
    inc a
    dec b
    jr nz, Jump_0F1_4546
    ld d, a

Jump_0F1_454C::
    ld a, $07
    sub a, c
    cp a, $00
    jr z, Jump_0F1_455A
    ld b, a
    ld a, $C3

Jump_0F1_4556::
    ld [hl+], a
    dec b
    jr nz, Jump_0F1_4556

Jump_0F1_455A::
    ld hl, wC319
    ld b, $07
    ld a, c
    or a, a
    jr z, Jump_0F1_457A
    push hl
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    inc hl
    ld b, [hl]
    pop hl

Jump_0F1_456D::
    ld a, b
    cp a, $00
    jr z, Jump_0F1_4578
    ld a, d
    ld [hl+], a
    inc d
    dec b
    jr nz, Jump_0F1_456D

Jump_0F1_4578::
    ld b, $03

Jump_0F1_457A::
    ld a, $C3

Jump_0F1_457C::
    ld [hl+], a
    dec b
    jr nz, Jump_0F1_457C
    jr Jump_0F1_4599

Jump_0F1_4582::
    ld a, [wC46D]
    ld c, $55
    call SRAMRecordAddressMapped
    bit 7, [hl]
    call nz, Func_0F1_459E
    bit 2, [hl]
    call nz, Func_0F1_45A4
    bit 0, [hl]
    call nz, Func_0F1_45AA

Jump_0F1_4599::
    xor a, a
    ld [rRAMG], a
    ret

; 1 call site from 1 routine (e.g. Func_0F1_442F)
; writes: wC2DF
Func_0F1_459E::
    ld a, $C2
    ld [wC2DF], a
    ret

; 1 call site from 1 routine (e.g. Func_0F1_442F)
; writes: wC2DF
Func_0F1_45A4::
    ld a, $C1
    ld [wC2DF], a
    ret

; 1 call site from 1 routine (e.g. Func_0F1_442F)
; writes: wC2DE
Func_0F1_45AA::
    ld a, $C0
    ld [wC2DE], a
    ret

Data_0F1_45B0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $08, $05, $04, $07, $05, $06, $08, $06, $09, $09, $07, $07, $06, $08, $08, $05
    db $06, $07, $05, $03, $05, $03, $07, $05, $08, $08, $04

Data_0F1_45CB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $3C45CB, $48

Data_0F1_4613:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $04, $05, $06
    db $07, $00, $01, $02, $02, $02, $02, $02, $02, $03, $03, $03, $03, $03
    ds $22, $00
    ds $23, $08

Data_0F1_4676:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_0F1_4688
    dw Data_0F1_46B0
    dw Data_0F1_46D8
    dw Data_0F1_4700
    dw Data_0F1_4728
    dw Data_0F1_4750
    dw Data_0F1_4778
    dw Data_0F1_47A0
    dw Data_0F1_47C8

; LZSS-compressed asset: 253 bytes expand to 321 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F1_4688:: ; heuristic: target of a monotone pointer table; C0
    db $41, $01, $0C, $03, $FB, $FC, $ED
    ds $18, $C3
    db $BE, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3

; LZSS-compressed asset: 258 bytes expand to 321 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F1_46B0:: ; heuristic: target of a monotone pointer table; C0
    db $41, $01, $0C, $03, $FD, $FE, $ED
    ds $18, $C3
    db $BE, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3

; LZSS-compressed asset: 261 bytes expand to 321 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F1_46D8:: ; heuristic: target of a monotone pointer table; C0
    db $41, $01, $0C, $03, $F6, $F7, $F8, $F9, $FA, $0E, $0F, $10, $11, $12, $13, $C3
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $1A, $1B, $1C, $1D
    db $1E, $1F, $20, $21, $22, $C3, $C3, $C3

; LZSS-compressed asset: 273 bytes expand to 321 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F1_4700:: ; heuristic: target of a monotone pointer table; C0
    db $41, $01, $0C, $03, $0B, $0C, $0D, $ED
    ds $20, $C3

; LZSS-compressed asset: 302 bytes expand to 321 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F1_4728:: ; heuristic: target of a monotone pointer table; C0
    db $41, $01, $0C, $03, $FF, $00, $01, $ED
    ds $20, $C3

; LZSS-compressed asset: 305 bytes expand to 321 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F1_4750:: ; heuristic: target of a monotone pointer table; C0
    db $41, $01, $0C, $03, $02, $03, $04, $ED
    ds $20, $C3

; LZSS-compressed asset: 310 bytes expand to 321 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F1_4778:: ; heuristic: target of a monotone pointer table; C0
    db $41, $01, $0C, $03, $05, $06, $07, $ED
    ds $20, $C3

; LZSS-compressed asset: 313 bytes expand to 321 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F1_47A0:: ; heuristic: target of a monotone pointer table; C0
    db $41, $01, $0C, $03, $08, $09, $0A, $ED
    ds $20, $C3

; LZSS-compressed asset: 317 bytes expand to 321 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F1_47C8:: ; heuristic: target of a monotone pointer table; C0
    db $41, $01, $0C, $03
    ds $24, $C3
    db $AF, $EA, $A6, $C0, $AF, $EA, $6E, $C4, $CD, $E0, $43, $21, $A6, $C0, $2A, $BE
    db $38, $04, $2B, $35, $18, $F8, $CD, $07, $43, $AF, $EA, $A0, $C0, $EA, $A1, $C0
    db $C9

; the same 57 bytes as CopyTileBufferToBGMap (03:42DA)
; 3 call sites from 3 routines (e.g. Func_0F1_4001_Table2_Case00, Func_0F1_4001_Table3_Case00, Func_0F1_4001_Table4_Case01)
; points at: wScreenTileBuffer
CopyTileBufferToBGMap_BankF1::
Func_0F1_4811:: ; address name
    ld hl, vBGMap0
    ld de, wScreenTileBuffer
    ld bc, $1412

Jump_0F1_481A::
    push bc
    push hl
    push de

Jump_0F1_481D::
    ld a, [de]
    inc de
    call WriteVRAMByte
    ld a, l
    and a, $1F
    cp a, $1F
    jr z, Jump_0F1_482C
    inc hl
    jr Jump_0F1_4830

Jump_0F1_482C::
    ld a, l
    and a, $E0
    ld l, a

Jump_0F1_4830::
    dec b
    jr nz, Jump_0F1_481D
    pop de
    ld a, e
    add a, $20
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    pop hl
    ld bc, $0020
    add hl, bc
    ld a, h
    and a, $9B
    ld h, a
    pop bc
    dec c
    jr nz, Jump_0F1_481A
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0F1_484A:: ; heuristic: follows a terminator; C0
    push bc
    push hl

Jump_0F1_484C::
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    dec b
    jr nz, Jump_0F1_484C
    ld a, e
    add a, $0E
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, Func_0F1_484A
    ret

; 1 call site from 1 routine (e.g. Func_0F1_4001_Table2_Case00)
Func_0F1_4866::
    farcall Func_002_5E82
    call LoadRecordListNameTiles
    ret

; 2 call sites from 2 routines (e.g. Func_0F1_4001_Table2_Case01, Func_0F1_4001_Table3_Case01)
; reads: wJoypadPressedRepeat, wMenuRowCount, wMenuPageCount, wMenuPage, wMenuLastPageRows, wFrameCounterLo
; writes: wFrameCounterLo, wMenuPage
Func_0F1_4870::
    ld a, [wJoypadPressedRepeat]
    and a, $40
    jr z, Jump_0F1_4885
    ld a, [hl]
    and a, $0F
    dec a
    cp a, $FF
    jr nz, Jump_0F1_48C9
    ld a, [wMenuRowCount]
    dec a
    jr Jump_0F1_48C9

Jump_0F1_4885::
    ld a, [wJoypadPressedRepeat]
    and a, $80
    jr z, Jump_0F1_489A
    ld a, [wMenuRowCount]
    ld c, a
    ld a, [hl]
    and a, $0F
    inc a
    cp a, c
    jr nz, Jump_0F1_48C9
    xor a, a
    jr Jump_0F1_48C9

Jump_0F1_489A::
    ld a, [wMenuPageCount]
    or a, a
    jr z, Jump_0F1_4916
    cp a, $01
    jr z, Jump_0F1_4916
    ld b, a
    ld a, [wJoypadPressedRepeat]
    and a, $20
    jr z, Jump_0F1_48B8
    ld a, [wMenuPage]
    dec a
    cp a, $FF
    jr nz, Jump_0F1_48E7
    ld a, b
    dec a
    jr Jump_0F1_48E7

Jump_0F1_48B8::
    ld a, [wJoypadPressedRepeat]
    and a, $10
    jr z, Jump_0F1_4916
    ld a, [wMenuPage]
    inc a
    cp a, b
    jr nz, Jump_0F1_48E7
    xor a, a
    jr Jump_0F1_48E7

Jump_0F1_48C9::
    and a, $0F
    ld b, a
    ld a, [hl]
    and a, $0F
    cp a, b
    jr z, Jump_0F1_48DC
    push de
    call Func_0F1_493B
    pop de
    ld a, $69
    call QueueSoundEffect

Jump_0F1_48DC::
    ld [hl], b
    ld a, b
    call Func_0F1_4951
    xor a, a
    ld [wFrameCounterLo], a
    jr Jump_0F1_493A

Jump_0F1_48E7::
    ld [wMenuPage], a
    inc a
    cp a, b
    jr nz, Jump_0F1_4909
    ld a, [hl]
    and a, $0F
    ld c, a
    ld a, [wMenuLastPageRows]
    dec a
    cp a, c
    jr nc, Jump_0F1_4909
    jr z, Jump_0F1_4909
    push af
    push de
    ld a, [hl]
    and a, $0F
    call Func_0F1_493B
    pop de
    pop af
    ld [hl], a
    call Func_0F1_4951

Jump_0F1_4909::
    set 7, [hl]
    xor a, a
    ld [wFrameCounterLo], a
    ld a, $69
    call QueueSoundEffect
    jr Jump_0F1_493A

Jump_0F1_4916::
    ld a, [wFrameCounterLo]
    and a, $0F
    jr nz, Jump_0F1_493A
    ld a, [wFrameCounterLo]
    bit 4, a
    jr z, Jump_0F1_492C
    ld a, [hl]
    and a, $0F
    call Func_0F1_4951
    jr Jump_0F1_493A

Jump_0F1_492C::
    ld a, [hl]
    and a, $0F
    call Func_0F1_493B
    ld a, [wFrameCounterLo]
    set 3, a
    ld [wFrameCounterLo], a

Jump_0F1_493A::
    ret

; 3 call sites from 1 routine (e.g. Func_0F1_4870)
Func_0F1_493B::
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_0F1_4941
    inc d

Jump_0F1_4941::
    ld a, [de]
    push af
    inc de
    ld a, [de]
    ld d, a
    pop af
    ld e, a
    di
    call WaitForVRAMAccess
    ld a, $C3
    ld [de], a
    ei
    ret

; 3 call sites from 1 routine (e.g. Func_0F1_4870)
Func_0F1_4951::
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_0F1_4957
    inc d

Jump_0F1_4957::
    ld a, [de]
    push af
    inc de
    ld a, [de]
    ld d, a
    pop af
    ld e, a
    di
    call WaitForVRAMAccess
    ld a, $BB
    ld [de], a
    ei
    ret
    db $FA, $6D, $C4, $E6, $03, $21, $5E, $4A, $87, $85, $6F, $30, $01, $24, $2A, $66
    db $6F, $7D, $C6, $98, $6F, $7C, $CE, $29, $67, $36, $BB, $C9

; 4 call sites from 4 routines (e.g. Func_0F1_422D, Func_0F1_42B6, Func_0F1_4276, Func_0F1_429C)
Func_0F1_4983::
    add a, a
    add_a_to_hl
    deref_hl
    ld a, l
    add a, $98
    ld l, a
    ld a, h
    adc a, $29
    ld h, a
    ld [hl], $BC
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0F1_4997:: ; heuristic: follows a terminator; C0
    add a, a
    add_a_to_hl
    deref_hl
    ld a, $BC
    call WriteVRAMByte
    ret
    db $FA, $2D, $C5, $4F, $FA, $2E, $C5, $47, $C5, $FA, $2F, $C5, $4F, $FA, $30, $C5
    db $47, $C5, $7D, $EA, $2D, $C5, $7C, $EA, $2E, $C5, $7B, $EA, $2F, $C5, $7A, $EA
    db $30, $C5, $21, $2B, $40, $06, $08, $D7, $E1, $7D, $EA, $2F, $C5, $7C, $EA, $30
    db $C5, $E1, $7D, $EA, $2D, $C5, $7C, $EA, $2E, $C5, $C9

; fills the $240 bytes at wScreenTileBuffer with $C3 (the same 12 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. Func_0F1_41EE)
; points at: wScreenTileBuffer
ClearScreenTileBuffer_BankF1::
Func_0F1_49E1:: ; address name
    ld hl, wScreenTileBuffer
    ld bc, $0240
    ld a, $C3
    call FillBytes
    ret

; 1 call site from 1 routine (e.g. Func_0F1_4244)
; points at: wScreenTileBuffer
Func_0F1_49ED:: ; heuristic: follows a terminator; C0
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld c, [hl]
    inc hl
    push hl
    ld hl, wScreenTileBuffer
    add hl, de
    pop de

Jump_0F1_49FB::
    push bc
    push hl

Jump_0F1_49FD::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_0F1_49FD
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_0F1_49FB
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC52D, wC52E, wC52F, wC530
; writes: wStringCategory, wStringIndex, wC52D, wC52E, wC52F, wC530
Func_0F1_4A0D:: ; heuristic: follows a terminator; C0
    add a, a
    add_a_to_hl
    deref_hl
    ld a, $08
    ld [wStringCategory], a
    ld a, $05
    ld [wStringIndex], a
    ld de, $0501

; 3 call sites from 2 routines (e.g. Func_0F1_42D9, Func_0F1_442F)
; reads: wC52D, wC52E, wC52F, wC530
; writes: wC52D, wC52E, wC52F, wC530
Func_0F1_4A23::
    ld a, [wC52D]
    ld c, a
    ld a, [wC52E]
    ld b, a
    push bc
    ld a, [wC52F]
    ld c, a
    ld a, [wC530]
    ld b, a
    push bc
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld a, e
    ld [wC52F], a
    ld a, d
    ld [wC530], a
    farcall ShowString_Bank08
    pop bc
    ld a, c
    ld [wC52F], a
    ld a, b
    ld [wC530], a
    pop bc
    ld a, c
    ld [wC52D], a
    ld a, b
    ld [wC52E], a
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0F1_4A5E:: ; heuristic: follows a terminator; C0
    ld h, c
    sbc a, b
    and a, c
    sbc a, b
    pop hl
    sbc a, b
    ld hl, Data_0F1_6199
    sbc a, c
    and a, c
    sbc a, c
    add hl, hl
    sbc a, b
    ld l, c
    sbc a, b
    xor a, c
    sbc a, b
    jp hl
    db $98

Data_0F1_4A72:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A1, $98, $E1, $98, $21, $99, $61, $99, $47, $99, $87, $99, $C7, $99, $07, $9A
    db $61, $98, $A1, $98, $4A, $99, $8A, $99, $CA, $99, $0A, $9A, $64, $98, $A4, $98
    db $E4, $98, $2F, $99, $6F, $99, $82, $99, $84, $99, $86, $99, $88, $99, $8A, $99
    db $8C, $99, $8E, $99, $90, $99

; 6 call sites from 6 routines (e.g. GameMode5_Init_Case02, GameMode5_Init_Case03, GameMode5_Init_Case06, Func_01B_660D, ...)
; reads: wIsCGB
; writes: rSVBK
; points at: wScreenTileBuffer, wD000
Func_0F1_4AA8::
    ld hl, wScreenTileBuffer
    ld bc, $02D0

Jump_0F1_4AAE::
    ld a, $C3
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_0F1_4AAE
    ld a, [wIsCGB]
    and a, a
    ret z
    ld a, $02
    ldh [rSVBK], a
    ld hl, wD000
    ld bc, $02D0

Jump_0F1_4AC5::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_0F1_4AC5
    xor a, a
    ldh [rSVBK], a
    ret

; 3 call sites from 3 routines (e.g. Func_01B_4431_Case01, Func_01B_665E_Case0D, Func_033_5215_Table2_Case0D)
; reads: wFadeState, wD780
Func_0F1_4AD0::
    ld a, [wFadeState]
    and a, a
    ret nz
    ld a, [wD780]
    rst $00
    dw Func_0F1_4AD0_Case00
    dw Func_0F1_4AD0_Case01
    dw Func_0F1_4AD0_Case02
    dw Func_0F1_4AD0_Case03
    dw Func_0F1_4AD0_Case04
    dw Func_0F1_4AD0_Case01
    dw Func_0F1_4AD0_Case01
    dw Func_0F1_4AD0_Case01
    dw Func_0F1_4AD0_Case01
    dw Func_0F1_4AD0_Case01
    dw Func_0F1_4AD0_Case01
    dw Func_0F1_4AD0_Case01
    dw Func_0F1_4AD0_Case0C
    dw Func_0F1_4AD0_Case0D
    dw Func_0F1_4AD0_Case0E
    dw Func_0F1_4AD0_Case01
    dw Func_0F1_4AD0_Case01
    dw Func_0F1_4AD0_Case11

; entry 0 of the `rst $00` table in Func_0F1_4AD0
; no direct call (reached through a table, a jump or a vector)
; reads: wD780
; writes: wD780
Func_0F1_4AD0_Case00::
Jump_0F1_4AFD:: ; address name
    farcall ScriptCommandE8_Run
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

; entry 1 of the `rst $00` table in Func_0F1_4AD0
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B
; writes: wGameMode, wModeState, wModeChangeRequest
; points at: wD780
Func_0F1_4AD0_Case01::
Jump_0F1_4B0B:: ; address name
    ld a, [wC52B]
    bit 0, a
    ret nz
    ld hl, wD780
    ld bc, $006F

Jump_0F1_4B17::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_0F1_4B17
    ld a, $05
    ld [wGameMode], a
    ld a, $01
    ld [wModeState], a
    ld a, $01
    ld [wModeChangeRequest], a
    ret

; entry 2 of the `rst $00` table in Func_0F1_4AD0
; no direct call (reached through a table, a jump or a vector)
; reads: wD780
; writes: wD780, wStringCategory, wC594
; points at: wD06A
Func_0F1_4AD0_Case02::
Jump_0F1_4B2E:: ; address name
    ld a, [wD780]
    inc a
    ld [wD780], a
    xor a, a
    ld [wStringCategory], a
    ld a, $01
    call BeginString_Bank0E_Cat0
    xor a, a
    ld [wC594], a
    ld hl, wD06A
    inc [hl]
    ret

; entry 3 of the `rst $00` table in Func_0F1_4AD0
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
Func_0F1_4AD0_Case03::
Jump_0F1_4B47:: ; address name
    ld a, [wD781]
    rst $00
    dw Func_0F1_4AD0_Table2_Case00
    dw Func_0F1_4AD0_Table2_Case01
    dw Func_0F1_4AD0_Table2_Case02
    dw Func_0F1_4AD0_Table2_Case03

; entry 0 of the `rst $00` table in Func_0F1_4AD0
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wD781
; writes: wD781
Func_0F1_4AD0_Table2_Case00::
Jump_0F1_4B53:: ; address name
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, $07
    call BeginString_Bank0E_Cat0
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 1 of the `rst $00` table in Func_0F1_4AD0
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wD781
; writes: wC594, wD781
Func_0F1_4AD0_Table2_Case01::
Jump_0F1_4B65:: ; address name
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, $01
    ld [wC594], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 2 of the `rst $00` table in Func_0F1_4AD0
; no direct call (reached through a table, a jump or a vector)
; reads: wC58F, wD781
; writes: wC594, wD781
Func_0F1_4AD0_Table2_Case02::
Jump_0F1_4B77:: ; address name
    ld a, [wC58F]
    cp a, $01
    ret nz
    xor a, a
    ld [wC594], a
    ld a, $09
    call BeginString_Bank0E_Cat0
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 3 of the `rst $00` table in Func_0F1_4AD0
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wD780
; writes: wD781, wD780
Func_0F1_4AD0_Table2_Case03::
Jump_0F1_4B8E:: ; address name
    ld a, [wC52B]
    and a, a
    ret nz
    xor a, a
    ld [wD781], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

; entry 4 of the `rst $00` table in Func_0F1_4AD0
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
Func_0F1_4AD0_Case04::
Jump_0F1_4B9F:: ; address name
    ld a, [wD781]
    rst $00
    dw Func_0F1_4AD0_Table3_Case00
    dw Func_0F1_4AD0_Table3_Case00
    dw Func_0F1_4AD0_Table3_Case00
    dw Func_0F1_4AD0_Table3_Case00
    dw Func_0F1_4AD0_Table3_Case04
    dw Func_0F1_4AD0_Table3_Case00
    dw Func_0F1_4AD0_Table3_Case00
    dw Func_0F1_4AD0_Table3_Case00
    dw Func_0F1_4AD0_Table3_Case08
    dw Func_0F1_4AD0_Table3_Case09
    dw Func_0F1_4AD0_Table3_Case0A
    dw Func_0F1_4AD0_Table3_Case0B
    dw Func_0F1_4AD0_Table3_Case0C
    dw Func_0F1_4AD0_Table3_Case00
    dw Func_0F1_4AD0_Table3_Case0E
    dw Func_0F1_4AD0_Table3_Case0F
    dw Func_0F1_4AD0_Table3_Case10
    dw Func_0F1_4AD0_Table3_Case11
    dw Func_0F1_4AD0_Table3_Case12
    dw Func_0F1_4AD0_Table3_Case13
    dw Func_0F1_4AD0_Table3_Case14
    dw Func_0F1_4AD0_Table3_Case15
    dw Func_0F1_4AD0_Table3_Case16
    dw Func_0F1_4AD0_Table3_Case17
    dw Func_0F1_4AD0_Table3_Case18
    dw Func_0F1_4AD0_Table3_Case19
    dw Func_0F1_4AD0_Table3_Case1A
    dw Func_0F1_4AD0_Table3_Case13
    dw Func_0F1_4AD0_Table3_Case1C
    dw Func_0F1_4AD0_Table3_Case1D
    dw Func_0F1_4AD0_Table3_Case1E
    dw Func_0F1_4AD0_Table3_Case13
    dw Func_0F1_4AD0_Table3_Case20

; entry 14 of the `rst $00` table in Func_0F1_4AD0
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wC58F
; writes: wD781, wC594
Func_0F1_4AD0_Table3_Case0E::
Jump_0F1_4BE5:: ; address name
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, [wC58F]
    cp a, $FE
    jr nz, Jump_0F1_4C01
    ld a, $09
    ld [wD781], a
    ld a, $03
    call BeginString_Bank0E_Cat0
    ld a, $FE
    ld [wC594], a
    ret

Jump_0F1_4C01::
    farcall ScriptCommandED_Run
    ret

; entry 8 of the `rst $00` table in Func_0F1_4AD0
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wC58F, wD7F9
; writes: wD781, wC594
Func_0F1_4AD0_Table3_Case08::
Jump_0F1_4C08:: ; address name
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, [wC58F]
    cp a, $FE
    jr nz, Jump_0F1_4C24
    ld a, $09
    ld [wD781], a
    ld a, $03
    call BeginString_Bank0E_Cat0
    ld a, $FE
    ld [wC594], a
    ret

Jump_0F1_4C24::
    farcall ScriptCommandED_Run
    ld a, [wD7F9]
    cp a, $FE
    ret nz
    ld a, $09
    ld [wD781], a
    ld a, $02
    call BeginString_Bank0E_Cat0
    ld a, $FE
    ld [wC594], a
    ret

; entry 0 of the `rst $00` table in Func_0F1_4AD0
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B
Func_0F1_4AD0_Table3_Case00::
Jump_0F1_4C40:: ; address name
    ld a, [wC52B]
    and a, a
    ret nz
    farcall ScriptCommandED_Run
    ret

; entry 16 of the `rst $00` table in Func_0F1_4AD0
; no direct call (reached through a table, a jump or a vector)
; reads: wD7B4, wC52B, wD782
Func_0F1_4AD0_Table3_Case10::
Jump_0F1_4C4C:: ; address name
    ld a, [wD7B4]
    cp a, $FF
    jr z, Jump_0F1_4C64
    ld a, [wC52B]
    and a, a
    ret nz
    farcall ScriptCommandED_Run
    ld a, $09
    call BeginString_Bank0E_Cat0
    ret

Jump_0F1_4C64::
    ld a, [wD782]
    rst $00
    dw Func_0F1_4AD0_Table4_Case00
    dw Func_0F1_4AD0_Table4_Case01
    dw Func_0F1_4AD0_Table4_Case02
    dw Func_0F1_4AD0_Table4_Case03
    dw Func_0F1_4AD0_Table4_Case00
    dw Func_0F1_4AD0_Table4_Case01
    dw Func_0F1_4AD0_Table4_Case02
    dw Func_0F1_4AD0_Table4_Case03

; entry 0 of the `rst $00` table in Func_0F1_4AD0
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wD782
; writes: wC594, wD782
Func_0F1_4AD0_Table4_Case00::
Jump_0F1_4C78:: ; address name
    ld a, [wC52B]
    and a, a
    ret nz
    xor a, a
    ld [wC594], a
    ld a, [wD782]
    inc a
    ld [wD782], a
    ld a, $07
    call BeginString_Bank0E_Cat0
    ret

; entry 1 of the `rst $00` table in Func_0F1_4AD0
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wD782
; writes: wD782, wC594
Func_0F1_4AD0_Table4_Case01::
Jump_0F1_4C8E:: ; address name
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, [wD782]
    inc a
    ld [wD782], a
    ld a, $01
    ld [wC594], a
    ret

; entry 2 of the `rst $00` table in Func_0F1_4AD0
; no direct call (reached through a table, a jump or a vector)
; reads: wC58F, wD782
; writes: wC594, wD782
Func_0F1_4AD0_Table4_Case02::
Jump_0F1_4CA0:: ; address name
    ld a, [wC58F]
    cp a, $01
    ret nz
    xor a, a
    ld [wC594], a
    ld a, $09
    call BeginString_Bank0E_Cat0
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

; entry 3 of the `rst $00` table in Func_0F1_4AD0
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B
; writes: wD7B4, wD782
Func_0F1_4AD0_Table4_Case03::
Jump_0F1_4CB7:: ; address name
    ld a, [wC52B]
    and a, a
    ret nz
    farcall ScriptCommandED_Run
    xor a, a
    ld [wD7B4], a
    ld [wD782], a
    ret

; entry 12 of the `rst $00` table in Func_0F1_4AD0
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wD782
; writes: wD782
Func_0F1_4AD0_Table3_Case0C::
Jump_0F1_4CCA:: ; address name
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, [wD782]
    and a, a
    jr nz, Jump_0F1_4CE2
    ld a, $04
    call BeginString_Bank0E_Cat0
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_0F1_4CE2::
    farcall ScriptCommandED_Run
    ld de, Data_01F_4510
    ld hl, vTiles1 + $6E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4450
    ld hl, vTiles1 + $6F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    xor a, a
    ld [wD782], a
    ret

; entry 4 of the `rst $00` table in Func_0F1_4AD0
; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5, wD7F6, wD781
; writes: wD7F1, wD7F2, wD7F3, wD781
; points at: wC36C, wC386
Func_0F1_4AD0_Table3_Case04::
Jump_0F1_4D07:: ; address name
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld b, a
    push af
    ld a, $C7
    ld [wD7F1], a
    call Func_0F1_5969
    ld de, Data_0F1_5A36
    ld hl, wC36C
    ld bc, $0C05
    call CopyRectTo20ByteRows_BankF1
    pop af
    ld [wD7F1], a
    ld hl, wC386
    ld a, l
    ld [wD7F2], a
    ld a, h
    ld [wD7F3], a
    farcall Func_015_688D
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 15 of the `rst $00` table in Func_0F1_4AD0
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wD781
; writes: wD7F1, wD7F2, wD781, wD7B4
Func_0F1_4AD0_Table3_Case0F::
Jump_0F1_4D49:: ; address name
    ld a, [wC52B]
    and a, a
    ret nz

; 1 call site from 1 routine (e.g. Func_0F1_4AD0_Table3_Case12)
; reads: wD781
; writes: wD7F1, wD7F2, wD781, wD7B4
Func_0F1_4D4E::
    ld bc, $0005
    ld hl, $0278
    ld de, $00AC
    xor a, a
    ld [wD7F1], a
    ld a, $08
    ld [wD7F2], a
    call Func_0F1_58FA
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wD7B4], a
    ret

; entry 17 of the `rst $00` table in Func_0F1_4AD0
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wD7F5, wD7F6, hFFC6, wD781, wC6FD, wD7AB, wD7AF
; writes: rRAMG2, rRAMB, wD781, wD7B4, wD7B5, wD7B6
; points at: wC6FE
Func_0F1_4AD0_Table3_Case11::
Jump_0F1_4D6F:: ; address name
    ld a, [wC52B]
    and a, a
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
    push hl
    ld a, [hl]
    ld c, $56
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    cp a, $0A
    jr nc, Jump_0F1_4DAB
    pop hl
    xor a, a
    ld [rRAMG2], a
    ld a, [wD781]
    dec a
    dec a
    ld [wD781], a
    ld a, $05
    call BeginString_Bank0E_Cat0
    ret

Jump_0F1_4DAB::
    pop hl
    ld c, [hl]
    ld a, [wC6FD]
    ld b, a
    ld de, wC6FE

Jump_0F1_4DB4::
    ld a, [de]
    cp a, c
    jr z, Jump_0F1_4DBE
    inc de
    dec b
    jr nz, Jump_0F1_4DB4
    jr Jump_0F1_4DD0

Jump_0F1_4DBE::
    xor a, a
    ld [rRAMG2], a
    ld a, [wD781]
    dec a
    dec a
    ld [wD781], a
    ld a, $06
    call BeginString_Bank0E_Cat0
    ret

Jump_0F1_4DD0::
    farcall SetWD7F5ToWD789Cell5
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
    xor a, a
    ld [rRAMG2], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 18 of the `rst $00` table in Func_0F1_4AD0
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wD7B4
; writes: rRAMG2, rRAMB
; points at: sA000, wC986
Func_0F1_4AD0_Table3_Case12::
Jump_0F1_4DFA:: ; address name
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [wD7B4]
    ld c, $A5
    call Multiply8
    ld de, sA000
    add hl, de
    ld de, wC986
    ld b, $A5

Jump_0F1_4E19::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_0F1_4E19
    xor a, a
    ld [rRAMG2], a
    ld a, $07
    call BeginString_Bank0E_Cat0
    call Func_0F1_4D4E
    call BGMapAddressAtScroll_BankF1
    ld bc, $140D
    ld de, $01CC
    call Func_0F1_59CA
    ret

; entry 19 of the `rst $00` table in Func_0F1_4AD0
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wD781
; writes: wD781, wC594
Func_0F1_4AD0_Table3_Case13::
Jump_0F1_4E38:: ; address name
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld a, $01
    ld [wC594], a
    ret

; entry 20 of the `rst $00` table in Func_0F1_4AD0
; no direct call (reached through a table, a jump or a vector)
; reads: wC58F, wD781
; writes: wD781, wC594, wC592, wC593, wC595, wC596, wC590, wC591, ...
; points at: wC986, wCA2B
Func_0F1_4AD0_Table3_Case14::
Jump_0F1_4E4A:: ; address name
    ld a, [wC58F]
    cp a, $01
    jr z, Jump_0F1_4E64
    cp a, $FE
    ret nz
    ld a, $09
    ld [wD781], a
    ld a, $03
    call BeginString_Bank0E_Cat0
    ld a, $FE
    ld [wC594], a
    ret

Jump_0F1_4E64::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld a, $A5
    ld [wC592], a
    xor a, a
    ld [wC593], a
    ld hl, wC986
    ld a, l
    ld [wC595], a
    ld a, h
    ld [wC596], a
    ld hl, wCA2B
    ld a, l
    ld [wC590], a
    ld a, h
    ld [wC591], a
    ld a, $FF
    ld [wC594], a
    ld a, $01
    ld [wC58C], a
    ret

; entry 21 of the `rst $00` table in Func_0F1_4AD0
; no direct call (reached through a table, a jump or a vector)
; reads: wC58F, wD781
; writes: wC58C, wD781
Func_0F1_4AD0_Table3_Case15::
Jump_0F1_4E95:: ; address name
    ld a, [wC58F]
    cp a, $F0
    ret nz
    xor a, a
    ld [wC58C], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 22 of the `rst $00` table in Func_0F1_4AD0
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wC994, wCA39, wD7F5, wC9DC, wC9F3, wCA81, wCA98, ...
; writes: wD781, wD782, wD7B4, wC594, wStringIndex, wStringCategory
; points at: wC994, wC52D
Func_0F1_4AD0_Table3_Case16::
Jump_0F1_4EA7:: ; address name
    ld a, [wC52B]
    and a, a
    ret nz
    ld hl, wC994
    ld a, [wC994]
    and a, $01
    ld b, a
    ld a, [wCA39]
    and a, $01
    cp a, b
    jr nz, Jump_0F1_4ED1
    ld a, $08
    call BeginString_Bank0E_Cat0
    ld a, $10
    ld [wD781], a
    xor a, a
    ld [wD782], a
    ld a, $FF
    ld [wD7B4], a
    ret

Jump_0F1_4ED1::
    farcall Func_00E_5F91
    ld a, [wD7F5]
    cp a, $03
    jr nz, Jump_0F1_4EF2

Jump_0F1_4EDE::
    ld a, $0A
    call BeginString_Bank0E_Cat0
    ld a, $10
    ld [wD781], a
    xor a, a
    ld [wD782], a
    ld a, $FF
    ld [wD7B4], a
    ret

Jump_0F1_4EF2::
    cp a, $02
    jr nz, Jump_0F1_4F12
    ld a, [wC9DC]
    cp a, $28
    jr c, Jump_0F1_4EDE
    ld a, [wC9F3]
    cp a, $05
    jr c, Jump_0F1_4EDE
    ld a, [wCA81]
    cp a, $28
    jr c, Jump_0F1_4EDE
    ld a, [wCA98]
    cp a, $05
    jr c, Jump_0F1_4EDE

Jump_0F1_4F12::
    xor a, a
    ld [wC594], a
    ld a, $0F
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $96
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld [hl], $0D
    farcall ShowString_Bank0E
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, $0B
    call BeginString_Bank0E_Cat0
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 29 of the `rst $00` table in Func_0F1_4AD0
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wD7F5, wD781
; writes: wD7F1, wD781
Func_0F1_4AD0_Table3_Case1D::
Jump_0F1_4F4C:: ; address name
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, $02
    ld [wD7F1], a
    farcall Func_00E_5688
    ld a, [wD7F5]
    cp a, $FF
    ret nz
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld a, $0D
    call BeginString_Bank0E_Cat0
    ret

; entry 23 of the `rst $00` table in Func_0F1_4AD0
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wD781
; writes: wD7FA, wD781
; points at: wC52D, wC3E7
Func_0F1_4AD0_Table3_Case17::
Jump_0F1_4F6F:: ; address name
    ld a, [wC52B]
    and a, a
    ret nz
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [wD7FA], a
    ld a, $6C
    call QueueSoundEffect
    ld de, Data_0F1_5A90
    ld hl, wC3E7
    ld bc, $0907
    call CopyRectTo20ByteRows_BankF1
    call BGMapAddressAtScroll_BankF1
    ld bc, $140D
    ld de, $01CC
    call Func_0F1_59CA
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 24 of the `rst $00` table in Func_0F1_4AD0
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wC58F, wD7FA, wD781, wD780, wD7AB, wD7AF
; writes: wD781, wC594, wD782, wD7B2, wD7B3, wD7B5, wD7B6, wD7AB, ...
Func_0F1_4AD0_Table3_Case18::
Jump_0F1_4FAA:: ; address name
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, [wC58F]
    cp a, $FE
    jr nz, Jump_0F1_4FC9
    call Func_0F1_5812
    ld a, $09
    ld [wD781], a
    ld a, $03
    call BeginString_Bank0E_Cat0
    ld a, $FE
    ld [wC594], a
    ret

Jump_0F1_4FC9::
    call Func_0F1_5842
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_0F1_4FD7
    cp a, $FF
    jr z, Jump_0F1_4FEA
    ret

Jump_0F1_4FD7::
    call Func_0F1_5812
    ld a, $09
    ld [wD781], a
    ld a, $02
    call BeginString_Bank0E_Cat0
    ld a, $FE
    ld [wC594], a
    ret

Jump_0F1_4FEA::
    ld a, [wD7FA]
    cp a, $02
    jr z, Jump_0F1_4FD7
    cp a, $01
    jr z, Jump_0F1_500C
    ld a, [wD7FA]
    ld b, $BC
    ld hl, Data_0F1_5ACF
    call StoreBAtWordTableEntry_BankF1
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wD782], a
    ret

Jump_0F1_500C::
    ld a, [wD780]
    ld [wD7B2], a
    ld a, [wD781]
    ld [wD7B3], a
    ld a, [wD7AB]
    ld [wD7B5], a
    ld a, [wD7AF]
    ld [wD7B6], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld [wD7AB], a
    ld [wD7AF], a
    ld a, $0D
    ld [wD780], a
    ret

; entry 25 of the `rst $00` table in Func_0F1_4AD0
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wD782, wD781, wD7FA
; writes: wD782, wD7FA, wD781
; points at: wC412
Func_0F1_4AD0_Table3_Case19::
Jump_0F1_5037:: ; address name
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, [wD782]
    and a, a
    jr z, Jump_0F1_5048
    cp a, $01
    jr z, Jump_0F1_505A
    jr Jump_0F1_5067

Jump_0F1_5048::
    farcall Func_015_6EA5
    ld a, [wD7FA]
    and a, a
    jr z, Jump_0F1_5059
    ld a, $16
    call BeginString_Bank0E_Cat0

Jump_0F1_5059::
    ret

Jump_0F1_505A::
    ld a, $0C
    call BeginString_Bank0E_Cat0
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_0F1_5067::
    xor a, a
    ld [wD782], a
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
    ld de, Data_01F_4370
    ld hl, vTiles2 + $720
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4180
    ld hl, vTiles2 + $760
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    xor a, a
    ld [wD7FA], a
    ld de, Data_0F1_5A72
    ld hl, wC412
    ld bc, $0605
    call CopyRectTo20ByteRows_BankF1
    call BGMapAddressAtScroll_BankF1
    ld bc, $140D
    ld de, $01CC
    call Func_0F1_59CA
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 26 of the `rst $00` table in Func_0F1_4AD0
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wD7F9, wD7FA, wD781
; writes: wD781, wD782
Func_0F1_4AD0_Table3_Case1A::
Jump_0F1_50C3:: ; address name
    ld a, [wC52B]
    and a, a
    ret nz
    farcall Func_01D_6540
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_0F1_50DC
    cp a, $FF
    jr z, Jump_0F1_50E7
    ret

Jump_0F1_50DC::
    ld a, $0B
    call BeginString_Bank0E_Cat0
    ld a, $17
    ld [wD781], a
    ret

Jump_0F1_50E7::
    ld a, [wD7FA]
    cp a, $01
    jr z, Jump_0F1_50DC
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wD782], a
    ld a, $07
    call BeginString_Bank0E_Cat0
    ret

; entry 30 of the `rst $00` table in Func_0F1_4AD0
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wD782, wD7EE, wD781, wD7B5, wD7B6, wD7F5, wD7F6, ...
; writes: wD782, wD781, wD7AB, wD7AF, wD7F1, wD7F2, rRAMG2, rRAMB, ...
; points at: wCAD0, wCADB, wC7FC, wD7E0
Func_0F1_4AD0_Table3_Case1E::
Jump_0F1_50FF:: ; address name
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, [wD782]
    and a, a
    jr z, Jump_0F1_511B
    ld a, [wD7EE]
    and a, a
    ret nz
    xor a, a
    ld [wD782], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_0F1_511B::
    ld a, [wD7B5]
    ld [wD7AB], a
    ld a, [wD7B6]
    ld [wD7AF], a
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld [wD7F1], a
    ld a, $01
    ld [wD7F2], a
    farcall Func_014_7E96
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [wD7F6]
    ld l, a
    ld a, [wD7F7]
    ld h, a
    ld de, wCAD0
    ld b, $A5

Jump_0F1_515A::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_0F1_515A
    xor a, a
    ld [rRAMG2], a
    xor a, a
    ld [wC8C3], a
    ld [wC8C4], a
    ld hl, wCADB
    ld a, [hl+]
    ld [wD7F1], a
    ld a, [hl]
    ld [wD7F2], a
    ld de, wC7FC
    ld a, e
    ld [wD7F3], a
    ld a, d
    ld [wD7F4], a
    farcall Func_015_68F3
    ld hl, wD7E0
    ld b, $07

Jump_0F1_518C::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_0F1_518C
    farcall Func_015_6E64
    ld a, [wD782]
    inc a
    ld [wD782], a
    ld a, $01
    ld [wD7EE], a
    ret

; entry 28 of the `rst $00` table in Func_0F1_4AD0
; no direct call (reached through a table, a jump or a vector)
; reads: wC58F, wD781
; writes: wD781, wC594
Func_0F1_4AD0_Table3_Case1C::
Jump_0F1_51A4:: ; address name
    ld a, [wC58F]
    cp a, $01
    jr z, Jump_0F1_51BE
    cp a, $FE
    ret nz
    ld a, $09
    ld [wD781], a
    ld a, $03
    call BeginString_Bank0E_Cat0
    ld a, $FE
    ld [wC594], a
    ret

Jump_0F1_51BE::
    xor a, a
    ld [wC594], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 9 of the `rst $00` table in Func_0F1_4AD0
; no direct call (reached through a table, a jump or a vector)
; reads: wC58F, wD781
; writes: wC594, wD781
Func_0F1_4AD0_Table3_Case09::
Jump_0F1_51CA:: ; address name
    ld a, [wC58F]
    cp a, $FE
    ret nz
    xor a, a
    ld [wC594], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 10 of the `rst $00` table in Func_0F1_4AD0
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wD781
; writes: wD781, wD782
Func_0F1_4AD0_Table3_Case0A::
Jump_0F1_51DC:: ; address name
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, $07
    call BeginString_Bank0E_Cat0
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wD782], a
    ret

; entry 11 of the `rst $00` table in Func_0F1_4AD0
; no direct call (reached through a table, a jump or a vector)
; reads: wD782
Func_0F1_4AD0_Table3_Case0B::
Jump_0F1_51F2:: ; address name
    ld a, [wD782]
    rst $00
    dw Func_0F1_4D4E_Case00
    dw Func_0F1_4D4E_Case01

; entry 0 of the `rst $00` table in Func_0F1_4D4E
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wD782
; writes: wC594, wD782
Func_0F1_4D4E_Case00::
Jump_0F1_51FA:: ; address name
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, $01
    ld [wC594], a
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

; entry 1 of the `rst $00` table in Func_0F1_4D4E
; no direct call (reached through a table, a jump or a vector)
; reads: wC58F
; writes: wC594, wD781, wD780
Func_0F1_4D4E_Case01::
Jump_0F1_520C:: ; address name
    ld a, [wC58F]
    cp a, $01
    ret nz
    xor a, a
    ld [wC594], a
    xor a, a
    ld [wD781], a
    ld a, $01
    ld [wD780], a
    ret

; entry 32 of the `rst $00` table in Func_0F1_4AD0
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wC58F
; writes: wC594, wC94B
; points at: wD780
Func_0F1_4AD0_Table3_Case20::
Jump_0F1_5220:: ; address name
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, [wC58F]
    cp a, $01
    ret nz
    xor a, a
    ld [wC594], a
    ld hl, wD780
    ld bc, $006F

Jump_0F1_5235::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_0F1_5235
    ld a, $01
    ld [wC94B], a
    ret

; entry 12 of the `rst $00` table in Func_0F1_4AD0
; no direct call (reached through a table, a jump or a vector)
; reads: wD781, wD780
; writes: wD781, wD782, wD780
Func_0F1_4AD0_Case0C::
Jump_0F1_5242:: ; address name
    farcall ScriptCommandE8_Run
    ld a, [wD781]
    cp a, $0A
    ret nz
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, [wD780]
    add a, $05
    ld [wD780], a
    ret

; entry 17 of the `rst $00` table in Func_0F1_4AD0
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
Func_0F1_4AD0_Case11::
Jump_0F1_525E:: ; address name
    ld a, [wD781]
    rst $00
    dw Func_0F1_4D4E_Table2_Case00
    dw Func_0F1_5285
    dw Func_0F1_4D4E_Table2_Case02
    dw Func_0F1_4D4E_Table2_Case02
    dw Func_0F1_4D4E_Table2_Case02
    dw Func_0F1_4AD0_Table3_Case04
    dw Func_0F1_4D4E_Table2_Case06
    dw Func_0F1_4D4E_Table2_Case07
    dw Func_0F1_4D4E_Table2_Case02
    dw Func_0F1_4D4E_Table2_Case02

; entry 2 of the `rst $00` table in Func_0F1_4D4E
; no direct call (reached through a table, a jump or a vector)
Func_0F1_4D4E_Table2_Case02::
Jump_0F1_5276:: ; address name
    farcall ScriptCommandED_Run
    ret

; entry 0 of the `rst $00` table in Func_0F1_4D4E
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
Func_0F1_4D4E_Table2_Case00::
Jump_0F1_527D:: ; address name
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; 1 call site from 1 routine (e.g. Func_0F1_5285_Case1C)
; reads: wD781
; writes: wD781
Func_0F1_5285::
    farcall Func_0F2_4A0B
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 6 of the `rst $00` table in Func_0F1_4D4E
; no direct call (reached through a table, a jump or a vector)
; points at: wC52D, wD781
Func_0F1_4D4E_Table2_Case06::
Jump_0F1_5293:: ; address name
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

; entry 7 of the `rst $00` table in Func_0F1_4D4E
; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5, wD7F6, wD781
; writes: wD7F1, wD781
Func_0F1_4D4E_Table2_Case07::
Jump_0F1_52B7:: ; address name
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld b, a
    ld [wD7F1], a
    farcall Func_01D_5CD7
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 13 of the `rst $00` table in Func_0F1_4AD0
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
Func_0F1_4AD0_Case0D::
Jump_0F1_52D8:: ; address name
    ld a, [wD781]
    rst $00
    dw Func_0F1_5285_Case00
    dw Func_0F1_5285_Case01
    dw Func_0F1_5285_Case02
    dw Func_0F1_5285_Case03
    dw Func_0F1_5285_Case04
    dw Func_0F1_5285_Case05
    dw Func_0F1_5285_Case06
    dw Func_0F1_5285_Case07
    dw Func_0F1_5285_Case08
    dw Func_0F1_5285_Case08
    dw Func_0F1_5285_Case08
    dw Func_0F1_5285_Case08
    dw Func_0F1_5285_Case08
    dw Func_0F1_5285_Case08
    dw Func_0F1_5285_Case0E
    dw Func_0F1_5285_Case0F
    dw Func_0F1_5285_Case10
    dw Func_0F1_5285_Case11
    dw Func_0F1_5285_Case12
    dw Func_0F1_5285_Case13
    dw Func_0F1_5285_Case14
    dw Func_0F1_5285_Case15
    dw Func_0F1_5285_Case16
    dw Func_0F1_5285_Case17
    dw Func_0F1_5285_Case18
    dw Func_0F1_5285_Case19
    dw Func_0F1_5285_Case1A
    dw Func_0F1_5285_Case1B
    dw Func_0F1_5285_Case1C
    dw Func_0F1_5285_Case1D
    dw Func_0F1_5285_Case1E
    dw Func_0F1_5285_Case1F
    dw Func_0F1_5285_Case20

; entry 8 of the `rst $00` table in Func_0F1_5285
; no direct call (reached through a table, a jump or a vector)
Func_0F1_5285_Case08::
Jump_0F1_531E:: ; address name
    ret

; entry 0 of the `rst $00` table in Func_0F1_5285
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
Func_0F1_5285_Case00::
Jump_0F1_531F:: ; address name
    farcall Func_01F_7494
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 1 of the `rst $00` table in Func_0F1_5285
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
Func_0F1_5285_Case01::
Jump_0F1_532D:: ; address name
    farcall Func_0F2_49CF
    farcall Func_01F_7375
    call Func_0F1_5344

; entry 2 of the `rst $00` table in Func_0F1_5285
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
Func_0F1_5285_Case02::
Jump_0F1_533C:: ; address name
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; 1 call site from 1 routine (e.g. Func_0F1_5285_Case01)
; points at: wCA2C
Func_0F1_5344::
    ld hl, vTiles1 + $500
    ld bc, $0501
    call FillTilesBxC
    ld hl, wCA2C
    call CopyShortStringToWC8CF_BankF1
    ld de, vTiles1 + $500
    call CopyGlyphTilesToVRAM
    ret

; entry 3 of the `rst $00` table in Func_0F1_5285
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD7F3, wD7F4, wD7F7, wD781
Func_0F1_5285_Case03::
Jump_0F1_535A:: ; address name
    call BGMapAddressAtScroll_BankF1
    ld de, Data_0F1_687F
    ld a, $14
    ld [wD7F3], a
    ld a, $12
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_0F1_57FB
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 4 of the `rst $00` table in Func_0F1_5285
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
Func_0F1_5285_Case04::
Jump_0F1_5379:: ; address name
    farcall Func_0F2_5002
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 5 of the `rst $00` table in Func_0F1_5285
; no direct call (reached through a table, a jump or a vector)
Func_0F1_5285_Case05::
Jump_0F1_5387:: ; address name
    farcall Func_01F_73EC
    ret

; entry 6 of the `rst $00` table in Func_0F1_5285
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wD7F9, wD781
; writes: wJoypadPressedRepeat, wD7F9, wD7F3, wD7F4, wD7F7, wD781
Func_0F1_5285_Case06::
Jump_0F1_538E:: ; address name
    ld a, [wJoypadPressedRepeat]
    res 7, a
    res 6, a
    ld [wJoypadPressedRepeat], a
    xor a, a
    ld [wD7F9], a
    farcall Func_01D_66B6
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_0F1_53B0
    cp a, $FF
    jr z, Jump_0F1_53B8
    ret

Jump_0F1_53B0::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_0F1_53B8::
    call BGMapAddressAtScroll_BankF1
    ld de, $0161
    add hl, de
    ld de, Data_0F1_651B
    ld a, $06
    ld [wD7F3], a
    ld a, $06
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_0F1_57FB
    ld a, $0E
    ld [wD781], a
    ret

; entry 7 of the `rst $00` table in Func_0F1_5285
; no direct call (reached through a table, a jump or a vector)
; reads: wD780
; writes: wD7F5, wD7F6, wD7F1, wD7F2, wD7F3, wD7F4, wD7F7, wD781, ...
Func_0F1_5285_Case07::
Jump_0F1_53D9:: ; address name
    call BGMapAddressAtScroll_BankF1
    ld a, h
    ld [wD7F5], a
    ld a, l
    ld [wD7F6], a
    ld de, Data_0F1_5E12
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
    ld [wD781], a
    ld [wD782], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

; entry 14 of the `rst $00` table in Func_0F1_5285
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
Func_0F1_5285_Case0E::
Jump_0F1_5412:: ; address name
    ld hl, vTiles2 + $200
    ld bc, $0F02
    call FillTilesBxC
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 15 of the `rst $00` table in Func_0F1_5285
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
Func_0F1_5285_Case0F::
Jump_0F1_5423:: ; address name
    ld hl, vTiles1 + $270
    ld bc, $0901
    call FillTilesBxC
    ld hl, vTiles1 + $780
    ld bc, $0501
    call FillTilesBxC
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 16 of the `rst $00` table in Func_0F1_5285
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
Func_0F1_5285_Case10::
Jump_0F1_543D:: ; address name
    call Func_0F1_57CD
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 17 of the `rst $00` table in Func_0F1_5285
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD7F3, wD7F4, wD7F7, wD781
Func_0F1_5285_Case11::
Jump_0F1_5448:: ; address name
    call BGMapAddressAtScroll_BankF1
    ld de, $0068
    add hl, de
    ld de, Data_0F1_6577
    ld a, $0C
    ld [wD7F3], a
    ld a, $0F
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_0F1_57FB
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 18 of the `rst $00` table in Func_0F1_5285
; no direct call (reached through a table, a jump or a vector)
; reads: wD781, wCA36, wCA37
; writes: wD781, wD7F1, wD7F2, wD7F3, wD7F4, wD7F5, hFFBA, wD7F7
Func_0F1_5285_Case12::
Jump_0F1_546B:: ; address name
    farcall Func_0F2_4AFE
    ld a, [wD781]
    inc a
    ld [wD781], a

; entry 19 of the `rst $00` table in Func_0F1_5285
; no direct call (reached through a table, a jump or a vector)
; reads: wD781, wCA36, wCA37
; writes: wD7F1, wD7F2, wD7F3, wD7F4, wD781, wD7F5, hFFBA, wD7F7
Func_0F1_5285_Case13::
Jump_0F1_5478:: ; address name
    ld a, $6D
    ld [wD7F1], a
    xor a, a
    ld [wD7F2], a
    ld a, $EA
    ld [wD7F3], a
    ld a, $C7
    ld [wD7F4], a
    farcall Func_0F2_50E2
    farcall Func_0F2_4B05
    ld a, [wD781]
    inc a
    ld [wD781], a

; entry 20 of the `rst $00` table in Func_0F1_5285
; no direct call (reached through a table, a jump or a vector)
; reads: wCA36, wCA37, wD781
; writes: wD7F1, wD7F2, wD7F3, wD7F4, wD7F5, hFFBA, wD7F7, wD781
Func_0F1_5285_Case14::
Jump_0F1_549E:: ; address name
    ld a, [wCA36]
    ld [wD7F1], a
    ld a, [wCA37]
    ld [wD7F2], a
    xor a, a
    ld [wD7F3], a
    ld [wD7F4], a
    ld a, $80
    ld [wD7F5], a
    farcall Func_01D_6973
    ld a, $F0
    ldh [hFFBA], a
    farcall Func_0F2_4BD0
    call BGMapAddressAtScroll_BankF1
    ld de, $0160
    add hl, de
    ld de, Data_0F1_66DF
    ld a, $08
    ld [wD7F3], a
    ld a, $07
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_0F1_57FB
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 21 of the `rst $00` table in Func_0F1_5285
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wD7F9, wD781
; writes: wJoypadPressedRepeat, wD7F9, hFFBA, wD781
Func_0F1_5285_Case15::
Jump_0F1_54E9:: ; address name
    ld a, [wJoypadPressedRepeat]
    res 7, a
    res 6, a
    ld [wJoypadPressedRepeat], a
    xor a, a
    ld [wD7F9], a
    farcall Func_01D_66B6
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_0F1_5517
    cp a, $FF
    jr z, Jump_0F1_550B
    ret

Jump_0F1_550B::
    xor a, a
    ldh [hFFBA], a
    ld a, [wD781]
    inc a
    inc a
    ld [wD781], a
    ret

Jump_0F1_5517::
    xor a, a
    ldh [hFFBA], a
    farcall Func_01F_74E3
    ld a, $04
    ld [wD781], a
    ret

; entry 22 of the `rst $00` table in Func_0F1_5285
; no direct call (reached through a table, a jump or a vector)
; writes: wD781
Func_0F1_5285_Case16::
Jump_0F1_5526:: ; address name
    farcall Func_0F2_4F47
    ld a, $0F
    ld [wD781], a
    ret

; entry 23 of the `rst $00` table in Func_0F1_5285
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
Func_0F1_5285_Case17::
Jump_0F1_5532:: ; address name
    farcall Func_01F_753A
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 24 of the `rst $00` table in Func_0F1_5285
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
Func_0F1_5285_Case18::
Jump_0F1_5540:: ; address name
    farcall Func_01F_7591
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 25 of the `rst $00` table in Func_0F1_5285
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
Func_0F1_5285_Case19::
Jump_0F1_554E:: ; address name
    farcall Func_01F_7601
    ld a, [wD781]
    inc a
    ld [wD781], a

; entry 26 of the `rst $00` table in Func_0F1_5285
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
Func_0F1_5285_Case1A::
Jump_0F1_555B:: ; address name
    farcall Func_0F2_4BFC
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 27 of the `rst $00` table in Func_0F1_5285
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wD7F9, wD781
; writes: wJoypadPressedRepeat, wD7F9, wD781
Func_0F1_5285_Case1B::
Jump_0F1_5569:: ; address name
    ld a, [wJoypadPressedRepeat]
    res 7, a
    res 6, a
    ld [wJoypadPressedRepeat], a
    xor a, a
    ld [wD7F9], a
    farcall Func_01D_66B6
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_0F1_558B
    cp a, $FF
    jr z, Jump_0F1_559C
    ret

Jump_0F1_558B::
    ld hl, vTiles2 + $200
    ld bc, $1504
    call FillTilesFromRequest
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_0F1_559C::
    call Func_0F1_573E
    farcall Func_01F_76B5
    ld a, [wD781]
    add a, $03
    ld [wD781], a
    ret

; entry 28 of the `rst $00` table in Func_0F1_5285
; no direct call (reached through a table, a jump or a vector)
; reads: wD782
; writes: wC52D, wC52E, wC52F, wC530, wD782
Func_0F1_5285_Case1C::
Jump_0F1_55AE:: ; address name
    ld a, [wD782]
    and a, a
    jr nz, Jump_0F1_55DB
    ld hl, vTiles2 + $200
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1504
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    farcall Func_01F_7754
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_0F1_55DB::
    farcall Func_0F2_49CF
    call Func_0F1_5285
    xor a, a
    ld [wD782], a
    ret

; entry 29 of the `rst $00` table in Func_0F1_5285
; no direct call (reached through a table, a jump or a vector)
; writes: wD781
; points at: wC52D
Func_0F1_5285_Case1D::
Jump_0F1_55E9:: ; address name
    farcall Func_0F2_4F47
    ld hl, vTiles1 + $270
    ld bc, $0901
    call FillTilesBxC
    call Func_0F1_57CD
    ld de, Data_01F_4AD0
    ld hl, vTiles2 + $6F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, $11
    ld [wD781], a
    ret

; entry 30 of the `rst $00` table in Func_0F1_5285
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD7F3, wD7F4, wD7F7, wD781
Func_0F1_5285_Case1E::
Jump_0F1_561B:: ; address name
    call BGMapAddressAtScroll_BankF1
    ld de, $0008
    add hl, de
    ld de, Data_0F1_63D7
    ld a, $0C
    ld [wD7F3], a
    ld a, $12
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_0F1_57FB
    farcall Func_0F2_4E76
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 31 of the `rst $00` table in Func_0F1_5285
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: hFFBA, wD781
Func_0F1_5285_Case1F::
Jump_0F1_5644:: ; address name
    farcall Func_0F2_4C36
    ld a, $F0
    ldh [hFFBA], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 32 of the `rst $00` table in Func_0F1_5285
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wD7F9
; writes: wJoypadPressedRepeat, wD7F9, hFFBA, wD781
Func_0F1_5285_Case20::
Jump_0F1_5656:: ; address name
    ld a, [wJoypadPressedRepeat]
    res 7, a
    res 6, a
    ld [wJoypadPressedRepeat], a
    xor a, a
    ld [wD7F9], a
    farcall Func_01D_66B6
    ld a, [wD7F9]
    and a, a
    jr z, Jump_0F1_5678
    cp a, $FE
    jr z, Jump_0F1_5679
    cp a, $FF
    jr z, Jump_0F1_5682

Jump_0F1_5678::
    ret

Jump_0F1_5679::
    xor a, a
    ldh [hFFBA], a
    ld a, $17
    ld [wD781], a
    ret

Jump_0F1_5682::
    xor a, a
    ldh [hFFBA], a
    ld a, $07
    ld [wD781], a
    ret

; entry 14 of the `rst $00` table in Func_0F1_4AD0
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
Func_0F1_4AD0_Case0E::
Jump_0F1_568B:: ; address name
    ld a, [wD781]
    rst $00
    dw Func_0F1_5344_Case00
    dw Func_0F1_5285
    dw Func_0F1_5344_Case02
    dw Func_0F1_5344_Case02
    dw Func_0F1_5344_Case02
    dw Func_0F1_4AD0_Table3_Case04
    dw Func_0F1_4D4E_Table2_Case06
    dw Func_0F1_4D4E_Table2_Case07
    dw Func_0F1_5344_Case08
    dw Func_0F1_5344_Case09

; entry 0 of the `rst $00` table in Func_0F1_5344
; no direct call (reached through a table, a jump or a vector)
; reads: wD7B5, wD7B6, wD781
; writes: wD7AB, wD7AF, wD781
Func_0F1_5344_Case00::
Jump_0F1_56A3:: ; address name
    ld a, [wD7B5]
    ld [wD7AB], a
    ld a, [wD7B6]
    ld [wD7AF], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 9 of the `rst $00` table in Func_0F1_5344
; no direct call (reached through a table, a jump or a vector)
; reads: wD780
; writes: wD780
Func_0F1_5344_Case09::
Jump_0F1_56B7:: ; address name
    ld a, [wD780]
    push af
    ld a, $11
    ld [wD780], a
    farcall ScriptCommandED_Run
    pop af
    ret

; entry 2 of the `rst $00` table in Func_0F1_5344
; no direct call (reached through a table, a jump or a vector)
; reads: wD780
; writes: wD780
Func_0F1_5344_Case02::
Jump_0F1_56C8:: ; address name
    ld a, [wD780]
    push af
    ld a, $11
    ld [wD780], a
    farcall ScriptCommandED_Run
    pop af
    ld [wD780], a
    ret

; entry 8 of the `rst $00` table in Func_0F1_5344
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wStringIndex, wStringCategory, wD781
; points at: wC3E7, wC52D
Func_0F1_5344_Case08::
Jump_0F1_56DC:: ; address name
    ld de, Data_0F1_5A90
    ld hl, wC3E7
    ld bc, $0907
    call CopyRectTo20ByteRows_BankF1
    ld a, $0F
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $96
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld [hl], $0D
    farcall ShowString_Bank0E
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; 4 call sites from 4 routines (e.g. GameMode5_Update_Case02, GameMode5_Update_Case04, Func_007_7C5F_Case04, GameMode5_Update_Case05_Sub01)
; reads: wCA36, wCA37
; writes: wD7F1, wD7F2, wD7F3, wD7F4, wD7F5, wD7F6
Func_0F1_5719::
    ld a, [wCA36]
    ld [wD7F1], a
    ld a, [wCA37]
    ld [wD7F2], a
    xor a, a
    ld [wD7F3], a
    ld a, $90
    ld [wD7F4], a
    ld a, $40
    ld [wD7F5], a
    xor a, a
    ld [wD7F6], a
    farcall Func_01D_6A3D
    ret

; 1 call site from 1 routine (e.g. Func_0F1_5285_Case1B)
Func_0F1_573E::
    ld hl, Data_0F1_5757
    ld de, vTiles2 + $6E0
    call Func_0F1_57A7
    call Func_0F1_57A7
    ld de, vTiles2 + $7C0
    call Func_0F1_57A7
    call Func_0F1_57A7
    call Func_0F1_57A7
    ret

Data_0F1_5757:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $3C5757, $50

; 5 call sites from 1 routine (e.g. Func_0F1_573E)
; reads: rSTAT
Func_0F1_57A7::
    ld a, $10

Jump_0F1_57A9::
    push af
    di

Jump_0F1_57AB::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_0F1_57AB
    ld a, [hl+]
    ld [de], a
    ei
    inc de
    pop af
    dec a
    jr nz, Jump_0F1_57A9
    ret

; Copies up to 10 bytes from [HL] to wC8CF, stopping at a $F0 byte, then stores a $F0 terminator (the same 19 bytes appear in 2 banks)
; 2 call sites from 2 routines (e.g. Func_0F1_57CD, Func_0F1_5344)
; points at: wC8CF
CopyShortStringToWC8CF_BankF1::
Func_0F1_57BA:: ; address name
    ld de, wC8CF
    ld c, $0A

Jump_0F1_57BF::
    ld a, [hl+]
    cp a, $F0
    jr z, Jump_0F1_57C9
    ld [de], a
    inc de
    dec c
    jr nz, Jump_0F1_57BF

Jump_0F1_57C9::
    ld a, $F0
    ld [de], a
    ret

; 2 call sites from 2 routines (e.g. Func_0F1_5285_Case1D, Func_0F1_5285_Case10)
; writes: wStringIndex, wStringCategory
; points at: wCA2C, wCA36, wC52D
Func_0F1_57CD::
    ld hl, wCA2C
    call CopyShortStringToWC8CF_BankF1
    ld de, vTiles1 + $780
    call CopyGlyphTilesToVRAM
    ld hl, wCA36
    ld a, [hl+]
    ld [wStringIndex], a
    ld a, [hl]
    add a, $02
    ld [wStringCategory], a
    ld hl, wC52D
    ld a, $70
    ld [hl+], a
    ld a, $8A
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld [hl], $09
    farcall ShowString_Bank08
    ret

; 5 call sites from 5 routines (e.g. Func_0F1_5285_Case1E, Func_0F1_5285_Case14, Func_0F1_5285_Case11, Func_0F1_5285_Case06, ...)
; writes: wD7F5, wD7F6, wD7F1, wD7F2
Func_0F1_57FB::
    ld a, h
    ld [wD7F5], a
    ld a, l
    ld [wD7F6], a
    ld a, d
    ld [wD7F1], a
    ld a, e
    ld [wD7F2], a
    farcall Func_01F_5D2A
    ret

; 2 call sites from 1 routine (e.g. Func_0F1_4AD0_Table3_Case18)
; writes: wD7F1, wD7F2
Func_0F1_5812::
    ld bc, $0007
    ld hl, $024F
    ld de, $0083
    xor a, a
    ld [wD7F1], a
    ld a, $09
    ld [wD7F2], a
    call Func_0F1_58FA
    call BGMapAddressAtScroll_BankF1
    ld bc, $140D
    ld de, $01CC
    call Func_0F1_59CA
    ret

; A = string index: wStringIndex = A, wStringCategory = 0, then BeginStringDisplay_Bank0E
; 26 call sites from 19 routines (e.g. Func_0F1_4AD0_Case02, Func_0F1_4AD0_Table2_Case02, Func_0F1_4AD0_Table2_Case00, Func_0F1_4AD0_Table3_Case1D, ...)
; writes: wStringIndex, wStringCategory
BeginString_Bank0E_Cat0::
Func_0F1_5834:: ; address name
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank0E
    ret

; 3 call sites from 3 routines (e.g. Func_0F1_4AD0_Table3_Case18, Func_01B_6A5E_Table2_Case07, Func_033_562A_Case06)
; reads: wJoypadPressedRepeat, wJoypadPressed, wD7FA
; writes: wD7F9, wD7FA, wD783
Func_0F1_5842::
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, Jump_0F1_5860
    bit 7, a
    jr nz, Jump_0F1_5876
    ld a, [wJoypadPressed]
    bit 0, a
    jr nz, Jump_0F1_589C
    bit 1, a
    jr nz, Jump_0F1_58AA
    call Func_0F1_58B0
    xor a, a
    ld [wD7F9], a
    ret

Jump_0F1_5860::
    call Func_0F1_58CE
    ld a, [wD7FA]
    and a, a
    jr nz, Jump_0F1_5870
    ld a, $02
    ld [wD7FA], a
    jr Jump_0F1_588A

Jump_0F1_5870::
    dec a
    ld [wD7FA], a
    jr Jump_0F1_588A

Jump_0F1_5876::
    call Func_0F1_58CE
    ld a, [wD7FA]
    cp a, $02
    jr c, Jump_0F1_5886
    xor a, a
    ld [wD7FA], a
    jr Jump_0F1_588A

Jump_0F1_5886::
    inc a
    ld [wD7FA], a

Jump_0F1_588A::
    xor a, a
    ld [wD783], a
    call Func_0F1_58CA
    ld a, $69
    call QueueSoundEffect
    ld a, $FD
    ld [wD7F9], a
    ret

Jump_0F1_589C::
    call Func_0F1_58D2
    ld a, $69
    call QueueSoundEffect
    ld a, $FF
    ld [wD7F9], a
    ret

Jump_0F1_58AA::
    ld a, $FE
    ld [wD7F9], a
    ret

; 1 call site from 1 routine (e.g. Func_0F1_5842)
; reads: wJoypadRepeatTimer, wD783, wD7FA
; writes: wD783
Func_0F1_58B0::
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, Func_0F1_58CA
    ld a, [wD783]
    inc a
    ld [wD783], a
    cp a, $10
    jr c, Func_0F1_58CA
    cp a, $18
    jr c, Func_0F1_58CE
    xor a, a
    ld [wD783], a

; 1 call site from 1 routine (e.g. Func_0F1_5842)
; reads: wD7FA
Func_0F1_58CA::
    ld b, $BB
    jr Jump_0F1_58D4

; 2 call sites from 1 routine (e.g. Func_0F1_5842)
; reads: wD7FA
Func_0F1_58CE::
    ld b, $C3
    jr Jump_0F1_58D4

; 1 call site from 1 routine (e.g. Func_0F1_5842)
; reads: wD7FA
Func_0F1_58D2::
    ld b, $BC

Jump_0F1_58D4::
    ld a, [wD7FA]
    add a, a
    ld hl, Data_0F1_58F4
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_BankF1
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

Data_0F1_58F4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $EC, $00, $2C, $01, $6C, $01

; 2 call sites from 2 routines (e.g. Func_0F1_5812, Func_0F1_4D4E)
; reads: wD7F1, wD7F2, wIsCGB
; points at: wScreenTileBuffer, wD000
Func_0F1_58FA::
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
    call Func_0F1_594E
    pop de
    pop hl
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_0F1_593B
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
    call CopyLow3BitsToWRAMBank2_BankF1
    pop de
    pop hl

Jump_0F1_593B::
    pop bc
    ld a, $14
    add_a_to_hl
    ld a, $14
    add a, e
    ld e, a
    jr nc, Jump_0F1_594A
    inc d

Jump_0F1_594A::
    dec c
    jr nz, Func_0F1_58FA
    ret

; 1 call site from 1 routine (e.g. Func_0F1_58FA)
Func_0F1_594E::
    ld a, [de]
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Func_0F1_594E
    ret

; With rSVBK = 2, copies BC bytes from [DE] to [HL], each ANDed with $07; then rSVBK = 0 (the same 18 bytes appear in 7 banks)
; 1 call site from 1 routine (e.g. Func_0F1_58FA)
; writes: rSVBK
CopyLow3BitsToWRAMBank2_BankF1::
Func_0F1_5957:: ; address name
    ld a, $02
    ldh [rSVBK], a

Jump_0F1_595B::
    ld a, [de]
    and a, $07
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_0F1_595B
    xor a, a
    ldh [rSVBK], a
    ret

; 1 call site from 1 routine (e.g. Func_0F1_4AD0_Table3_Case04)
; reads: hFFC6, wD7F1
; writes: rRAMG2, rRAMB, wD09D, wD09E
Func_0F1_5969::
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
    ld a, [wD7F1]
    ld [wD09E], a
    farcall Func_016_7A48
    xor a, a
    ld [rRAMG2], a
    ret

; Copies a rectangle of B bytes by C rows from [DE] to [HL], rows 20 ($14) bytes apart; on CGB it then zero-fills the same-shaped rectangle at HL + $0E68 with rSVBK = 2 and restores rSVBK = 0 (the same 58 bytes appear in 8 banks)
; 4 call sites from 4 routines (e.g. Func_0F1_4AD0_Table3_Case19, Func_0F1_4AD0_Table3_Case17, Func_0F1_5344_Case08, Func_0F1_4AD0_Table3_Case04)
; reads: wIsCGB
; writes: rSVBK
CopyRectTo20ByteRows_BankF1::
Func_0F1_5990:: ; address name
    push hl
    push bc

Jump_0F1_5992::
    push bc
    push hl

Jump_0F1_5994::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_0F1_5994
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_0F1_5992
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

Jump_0F1_59B6::
    push bc
    push hl

Jump_0F1_59B8::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_0F1_59B8
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_0F1_59B6
    xor a, a
    ldh [rSVBK], a
    ret

; 4 call sites from 4 routines (e.g. Func_0F1_4AD0_Table3_Case19, Func_0F1_5812, Func_0F1_4AD0_Table3_Case17, Func_0F1_4AD0_Table3_Case12)
; reads: wIsCGB
; writes: wC554, wC555, rVBK, rSVBK
; points at: wScreenTileBuffer, wD000
Func_0F1_59CA::
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

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX, hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
; 11 call sites from 11 routines (e.g. Func_0F1_58D2, Func_0F1_4AD0_Table3_Case19, Func_0F1_5812, Func_0F1_4AD0_Table3_Case17, ...)
; reads: hScrollY, hScrollX
BGMapAddressAtScroll_BankF1::
Func_0F1_5A07:: ; address name
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

; HL = table of 16-bit addresses, A = index: stores B at the address in entry A; keeps BC; clobbers A, DE, HL (the same 14 bytes appear in 8 banks)
; 1 call site from 1 routine (e.g. Func_0F1_4AD0_Table3_Case18)
StoreBAtWordTableEntry_BankF1::
Func_0F1_5A28:: ; address name
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

Data_0F1_5A36:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $F8, $F9, $FA
    db $FB, $FC, $C3, $EA, $ED, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $B7, $B6, $C7, $A7, $A8, $A9, $AA, $AB, $AC, $AD, $AE, $AF, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_0F1_5A72:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $70, $71, $72, $B7, $B6, $C3, $C3, $C3
    db $C3, $B7, $B6, $C3, $76, $73, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B5

Data_0F1_5A90:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $C3, $60, $61, $62, $62
    db $63, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $64, $65
    db $66, $67, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3
    db $68, $69, $6A, $6B, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_0F1_5ACF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FC, $C3, $24, $C4, $4C, $C4

; only called from GameMode5_Update_Case07 (E-0047)
; 1 call site from 1 routine (e.g. GameMode5_Update_Case07)
; reads: wD06A, wD7EE, wD780
; writes: wD7EE
GameMode5_Update_Case07_Sub01::
Func_0F1_5AD5:: ; address name
    call Func_000_0535
    ld a, [wD06A]
    cp a, $01
    jr z, Jump_0F1_5AE0
    ret

Jump_0F1_5AE0::
    ld a, [wD7EE]
    cp a, $02
    jr nz, Jump_0F1_5AF7
    farcall Func_01C_42B3
    ld a, $FC
    call StartPaletteFade
    xor a, a
    ld [wD7EE], a
    ret

Jump_0F1_5AF7::
    call GameMode5_Update_Case07_Sub01_Sub01
    ld a, [wD780]
    cp a, $07
    ret c
    call GameMode5_Update_Case07_Sub01_Sub03
    call GameMode5_Update_Case07_Sub01_Sub02
    ld a, [wD7EE]
    and a, a
    ret z
    call GameMode5_Update_Case07_Sub01_Sub04
    ret

; only called from GameMode5_Update_Case07_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. GameMode5_Update_Case07_Sub01)
; reads: wD7DC
; writes: rRAMG2, rRAMB
; points at: sBB0F
GameMode5_Update_Case07_Sub01_Sub01::
Func_0F1_5B0F:: ; address name
    ld a, [wD7DC]
    and a, a
    ret z
    ld a, $0A
    ld [rRAMG2], a
    ld a, $01
    ld [rRAMB], a
    ld hl, sBB0F
    ld de, $022B
    add hl, de
    ld a, [hl]
    and a, a
    jr nz, Jump_0F1_5B31
    xor a, a
    ld [rRAMB], a
    ld [rRAMG2], a
    ret

Jump_0F1_5B31::
    farcall Func_015_6403
    ret

; only called from GameMode5_Update_Case07_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. GameMode5_Update_Case07_Sub01)
; reads: wD7E8, wD7EA, wD7E9
; writes: wD7F1, wD7F2, hFFB9
GameMode5_Update_Case07_Sub01_Sub02::
Func_0F1_5B38:: ; address name
    ld a, [wD7E8]
    cp a, $0C
    jr z, Jump_0F1_5B45
    cp a, $0D
    jp z, Jump_0F1_5B68
    ret

Jump_0F1_5B45::
    ld a, [wD7EA]
    and a, a
    ret nz
    ld a, [wD7E9]
    cp a, $15
    jr z, Jump_0F1_5B56
    cp a, $20
    jr z, Jump_0F1_5B5D
    ret

Jump_0F1_5B56::
    farcall Func_01D_5C35
    ret

Jump_0F1_5B5D::
    ld a, $01
    ldh [hFFB9], a
    farcall Func_01D_5BF2
    ret

Jump_0F1_5B68::
    ld a, [wD7EA]
    and a, a
    ret nz
    ld a, [wD7E9]
    cp a, $07
    ret nz
    farcall Func_01E_76F3
    ld c, $00
    ld a, l
    ld [wD7F1], a
    ld a, h
    ld [wD7F2], a
    ld a, $01
    ldh [hFFB9], a
    farcall Func_01D_6899
    ret

; only called from GameMode5_Update_Case07_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. GameMode5_Update_Case07_Sub01)
; reads: wSpriteSlotCount, wD7F1
GameMode5_Update_Case07_Sub01_Sub03::
Func_0F1_5B8E:: ; address name
    ld a, [wSpriteSlotCount]
    and a, a
    ret z
    farcall Func_004_44CE
    ld a, [wD7F1]
    and a, a
    ret z
    farcall DrawFieldSprites
    ret

; only called from GameMode5_Update_Case07_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. GameMode5_Update_Case07_Sub01)
; reads: wCEDC, wCEDB, wCED9, wCEDA, wD7F5
; writes: wD7F1, wD7F2, wD7F3, wD7F4, wD7F5, wCA99, wD7EE
; points at: wC8CF, wCECF, wCECE, wCA2B, wCE9B
GameMode5_Update_Case07_Sub01_Sub04::
Func_0F1_5BA5:: ; address name
    ld a, $01
    ld [wD7F1], a
    ld a, [wCEDC]
    ld [wD7F2], a
    ld a, [wCEDB]
    ld [wD7F3], a
    ld a, [wCED9]
    ld [wD7F4], a
    ld a, [wCEDA]
    ld [wD7F5], a
    farcall Func_014_5CA8
    ld a, [wD7F5]
    cp a, $FF
    ret nz
    ld hl, wC8CF
    ld de, wCECF
    ld b, $0A

Jump_0F1_5BD6::
    ld a, [hl+]
    cp a, $F0
    jr z, Jump_0F1_5BE2
    ld [de], a
    inc de
    dec b
    jr nz, Jump_0F1_5BD6
    jr Jump_0F1_5BE5

Jump_0F1_5BE2::
    ld a, $F0
    ld [de], a

Jump_0F1_5BE5::
    ld hl, wCECE
    ld de, wCA2B
    ld b, $A5

Jump_0F1_5BED::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_0F1_5BED
    ld hl, wCE9B
    ld b, $D8

Jump_0F1_5BF8::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_0F1_5BF8
    xor a, a
    ld [wCA99], a
    ld [wD7EE], a
    ret

; 1 call site from 1 routine (e.g. Func_00C_45DA_Case01)
; points at: wC49F
Func_0F1_5C05::
    ld hl, Data_0F1_5E04
    ld de, wC49F
    ld c, $40

Jump_0F1_5C0D::
    ld a, [hl+]
    ld [de], a
    inc de
    dec c
    jr nz, Jump_0F1_5C0D
    ret

; LZSS-compressed asset: 304 bytes expand to 544 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F1_5C14:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $3C5C14, $130

; LZSS-compressed asset: 88 bytes expand to 260 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F1_5D44:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $3C5D44, $58

; LZSS-compressed asset: 32 bytes expand to 100 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F1_5D9C:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    db $64, $00, $00, $9C, $80, $00, $01, $02, $90, $91, $00, $09, $04, $92, $9D, $00
    db $00, $04, $00, $15, $07, $00, $13, $0F, $16, $9E, $9F, $A0, $00, $52, $0C, $A1

; LZSS-compressed asset: 50 bytes expand to 260 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F1_5DBC:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    db $04, $01, $03, $01, $03, $00, $0F, $01, $03, $EE, $FF, $01, $03, $F8, $FD, $03
    db $26, $07, $03, $1D, $0F, $01, $03, $45, $0F, $28, $03, $08, $0F, $01, $03, $14
    db $06, $03, $9E, $07, $03, $09, $0B, $02, $02, $02, $02, $03, $A8, $0F, $11, $03
    db $A4, $0C

; LZSS-compressed asset: 22 bytes expand to 100 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F1_5DEE:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    db $64, $00, $02, $01, $02, $F9, $F4, $02, $08, $08, $02, $EE, $FF, $00, $02, $14
    db $0F, $16, $02, $4F, $0F, $00

Data_0F1_5E04:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $EE, $3D, $FF, $7F, $D6, $5A, $63, $00, $12, $36, $FF, $7F, $D8, $42

Data_0F1_5E12:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $66, $00, $12, $36, $FF, $7F, $D8, $42, $BF, $30, $FF, $7F, $FF, $7F, $FF, $7F
    db $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F
    db $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F
    db $FF, $7F
    ds $355, $00

Data_0F1_6199:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $23E, $00

Data_0F1_63D7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $144, $00

Data_0F1_651B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $5C, $00

Data_0F1_6577:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $168, $00

Data_0F1_66DF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $1A0, $00

Data_0F1_687F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $1781, $00
