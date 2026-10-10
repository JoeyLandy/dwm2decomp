SECTION "Bank 24", ROMX[$4000], BANK[$24]
    db $24

; start-up for wGameMode = 6; forcing this mode on the emulator shows: victory screen when forced (E-0029)
; 1 call site from 1 routine (e.g. RunGameModeInit_Case06)
; reads: wD04C, wD092, wC991, wC992, wC8CB, wC986, wC94C, wC8C3
; writes: hScrollY, hScrollX, wC52D, wC52E, wC52F, wC530, wD0DF, wD0E0, ...
; points at: wD780
GameMode6_Init::
Func_024_4001:: ; address name
    ld hl, wD780
    ld bc, $006F

Jump_024_4007::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_024_4007
    ld a, [wD04C]
    and a, a
    jr nz, Jump_024_4014
    jr Jump_024_4057

Jump_024_4014::
    ld a, [wD092]
    cp a, $80
    jr z, Jump_024_4057
    and a, $01
    and a, a
    jr nz, Jump_024_4022
    jr Jump_024_4057

Jump_024_4022::
    ld a, [wC986]
    and a, a
    jr z, Jump_024_4057
    ld a, [wC94C]
    ld [wD7F1], a
    xor a, a
    ld [wD7F2], a
    farcall Func_014_7E96
    xor a, a
    ld [wC8C3], a
    ld [wC8C4], a

Jump_024_403F::
    farcall Func_002_7333
    ld a, [wC8C3]
    bit 7, a
    jr z, Jump_024_403F
    ld hl, wD780
    ld bc, $006F

Jump_024_4052::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_024_4052

Jump_024_4057::
    ld b, $46
    ld de, Data_046_4001
    ld hl, vTiles1
    call DecompressToVRAM
    farcall Func_0F1_4AA8
    xor a, a
    ldh [hScrollY], a
    ldh [hScrollX], a
    call BGMapAddressAtScroll_Bank24
    ld bc, $140D
    ld de, $01CC
    call Func_024_4E57
    farcall Func_01B_53AF
    farcall Func_002_5F9B
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
    ld a, [wD092]
    cp a, $08
    jr nz, Jump_024_40B1
    ld a, [wC991]
    ld [wD0DF], a
    ld a, [wC992]
    ld [wD0E0], a

Jump_024_40B1::
    call GameMode6_Init_Sub02
    ld a, [wD092]
    cp a, $80
    jr nz, Jump_024_40C2
    ld de, Data_024_6F4E
    ld b, $24
    jr Jump_024_40D3

Jump_024_40C2::
    and a, $01
    and a, a
    jr nz, Jump_024_40CE
    ld de, Data_024_6CE4
    ld b, $24
    jr Jump_024_40D3

Jump_024_40CE::
    ld de, Data_024_6E13
    ld b, $24

Jump_024_40D3::
    ld hl, vTiles1 + $600
    call DecompressToRAMLocked
    call GameMode6_Init_Sub01
    ld a, $01
    ld [wC8CB], a
    ld a, $00
    ld [wC8CC], a
    ld a, $00
    ldh [hFFB9], a

Jump_024_40EA::
    farcall Func_002_69D0
    ld a, [wC8CB]
    and a, $03
    jr nz, Jump_024_40EA
    ld a, $FC
    call StartPaletteFade
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    xor a, a
    ld [wSpriteSlotCount], a
    ld a, $02
    ldh [hFFB9], a
    ld a, $03
    ld [wC5EC], a
    ld a, $01
    jp Jump_000_077A

; per-frame routine for wGameMode = 6
; 2 call sites from 2 routines (e.g. RunGameModeUpdate_Case06, Func_0F0_56C2_Case21)
; reads: wFadeState, wC52B, wD780, wD781, wD782
GameMode6_Update::
Func_024_4117:: ; address name
    ld a, [wFadeState]
    and a, a
    ret nz
    ld a, [wC52B]
    and a, a
    jr z, Jump_024_414C
    ld a, [wD780]
    cp a, $02
    jr z, Jump_024_413C
    cp a, $03
    ret nz
    ld a, [wD781]
    cp a, $01
    ret nz
    ld a, [wD782]
    cp a, $09
    ret nz
    call Func_024_567C
    ret

Jump_024_413C::
    ld a, [wD781]
    cp a, $0E
    ret nz
    ld a, [wD782]
    cp a, $09
    ret nz
    call Func_024_567C
    ret

Jump_024_414C::
    ld a, [wD780]
    rst $00
    dw GameMode6_Update_Case00
    dw GameMode6_Update_Case01
    dw GameMode6_Update_Case02
    dw GameMode6_Update_Case03
    dw GameMode6_Update_Case04
    dw GameMode6_Update_Case05
    dw GameMode6_Update_Case06
    dw GameMode6_Update_Case06
    dw GameMode6_Update_Case06
    dw GameMode6_Update_Case06
    dw GameMode6_Update_Case06
    dw GameMode6_Update_Case06
    dw GameMode6_Update_Case0C
    dw GameMode6_Update_Case0D
    dw GameMode6_Update_Case0E
    dw GameMode6_Update_Case0F

; entry 0 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
GameMode6_Update_Case00::
Jump_024_4170:: ; address name
    ld a, [wD781]
    rst $00
    dw GameMode6_Update_Table2_Case00
    dw GameMode6_Update_Table2_Case01

; entry 0 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD092, wD781
; writes: wD781, wC13A, wStringCategory, wStringIndex
; points at: wC37A, wC987, wC130
GameMode6_Update_Table2_Case00::
Jump_024_4178:: ; address name
    ld a, [wD092]
    cp a, $08
    jr z, Jump_024_41C0
    cp a, $80
    jr z, Jump_024_4185
    jr Jump_024_418A

Jump_024_4185::
    ld de, Data_024_57B4
    jr Jump_024_418D

Jump_024_418A::
    ld de, Data_024_5792

Jump_024_418D::
    ld hl, wC37A
    ld bc, $1102
    call CopyRectTo20ByteRowsJp_Bank24
    call GameMode6_Update_Table2_Case00_Sub01
    call BGMapAddressAtScroll_Bank24
    ld bc, $1406
    ld de, $01CC
    call Func_024_4E57
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld a, [wD092]
    cp a, $80
    jr z, Jump_024_41BB
    and a, $01
    add a, $01
    call Func_024_4EE8
    ret

Jump_024_41BB::
    xor a, a
    call Func_024_4EE8
    ret

Jump_024_41C0::
    call BGMapAddressAtScroll_Bank24
    ld bc, $1406
    ld de, $01CC
    call Func_024_4E57
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld hl, wC987
    ld de, wC130
    ld bc, $000A
    call CopyBytes
    ld a, $F0
    ld [wC13A], a
    ld a, $05
    ld [wStringCategory], a
    ld a, $13
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank07
    ret

; entry 1 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD04C, wD092, wC986, wD780, wCA2B
; writes: wD781, wD780
GameMode6_Update_Table2_Case01::
Jump_024_41F5:: ; address name
    ld a, [wD04C]
    and a, a
    jr nz, Jump_024_41FF

Jump_024_41FB::
    call Func_024_4DEB
    ret

Jump_024_41FF::
    ld a, [wD092]
    cp a, $80
    jr z, Jump_024_41FB
    and a, $01
    and a, a
    jr z, Jump_024_4213
    ld a, [wC986]
    and a, a
    jr z, Jump_024_41FB
    jr Jump_024_4219

Jump_024_4213::
    ld a, [wCA2B]
    and a, a
    jr z, Jump_024_41FB

Jump_024_4219::
    xor a, a
    ld [wD781], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

; entry 1 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD092, wD780
; writes: wD780
; points at: wC3F0
GameMode6_Update_Case01::
Jump_024_4225:: ; address name
    ld de, Data_024_58CA
    ld hl, wC3F0
    ld bc, $1406
    call CopyRectTo20ByteRowsJp_Bank24
    call BGMapAddressAtScroll_Bank24
    ld bc, $140D
    ld de, $01CC
    call Func_024_4E57
    ld a, [wD092]
    and a, $01
    add a, $01
    ld b, a
    ld a, [wD780]
    add a, b
    ld [wD780], a
    ret

; entry 2 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
GameMode6_Update_Case02::
Jump_024_424D:: ; address name
    ld a, [wD781]
    rst $00
    dw GameMode6_Update_Table3_Case00
    dw GameMode6_Update_Table3_Case01
    dw GameMode6_Update_Table3_Case02
    dw GameMode6_Update_Table3_Case03
    dw GameMode6_Update_Table3_Case04
    dw GameMode6_Update_Table3_Case05
    dw GameMode6_Update_Table3_Case06
    dw GameMode6_Update_Table3_Case07
    dw GameMode6_Update_Table3_Case08
    dw GameMode6_Update_Table3_Case09
    dw GameMode6_Update_Table3_Case0A
    dw GameMode6_Update_Table3_Case0B
    dw GameMode6_Update_Table3_Case0C
    dw GameMode6_Update_Table3_Case0D
    dw GameMode6_Update_Table3_Case0E
    dw GameMode6_Update_Table3_Case0F

; entry 0 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD092, wD782, wD7FF, wD7AA, wD781
; writes: wD781, wD782
GameMode6_Update_Table3_Case00::
Jump_024_4271:: ; address name
    ld a, [wD092]
    cp a, $08
    jr z, Jump_024_4284
    ld a, [wD782]
    and a, a
    jr nz, Jump_024_4284
    ld a, $0D
    ld [wD781], a
    ret

Jump_024_4284::
    farcall Func_01D_5E3F
    farcall Func_01D_6D70
    ld a, [wD7FF]
    ld b, a
    ld a, [wD7AA]
    cp a, b
    jr c, Jump_024_42A4
    ld a, $03
    ld [wD781], a
    xor a, a
    ld [wD782], a
    ret

Jump_024_42A4::
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wD782], a
    ret
    db $0A, $14, $1E

; entry 1 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wCA36, wCA37, wD781
; writes: rRAMG, rRAMB, wD006, wD007, wC8C3, wC8C4, wD781
; points at: sA000, wCA2B
GameMode6_Update_Table3_Case01::
Jump_024_42B3:: ; address name
    farcall Func_01D_6D70
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld hl, sA000

Jump_024_42C5::
    ld a, [hl]
    and a, a
    jr z, Jump_024_42D6
    cp a, $FF
    jr z, Jump_024_42D6
    ld a, $A5
    add_a_to_hl
    jr Jump_024_42C5

Jump_024_42D6::
    ld de, wCA2B
    ld b, $A5

Jump_024_42DB::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_024_42DB
    ld a, [wCA36]
    ld [wD006], a
    ld a, [wCA37]
    ld [wD007], a
    farcall Func_016_5AAF
    xor a, a
    ld [rRAMG], a
    ld [rRAMB], a
    xor a, a
    ld [wC8C3], a
    ld [wC8C4], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 2 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wC8C3
GameMode6_Update_Table3_Case02::
Jump_024_4309:: ; address name
    farcall Func_002_7333
    ld a, [wC8C3]
    bit 7, a
    ret z
    call Func_024_4DEB
    ret

; entry 3 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
GameMode6_Update_Table3_Case03::
Jump_024_4319:: ; address name
    ld a, $05
    call Func_024_4EE8
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 4 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wTwoChoiceCursor, wD781
; points at: wC412
GameMode6_Update_Table3_Case04::
Jump_024_4326:: ; address name
    ld a, $6C
    call QueueSoundEffect
    call Func_024_4D65
    ld de, Data_024_5A0A
    ld hl, wC412
    ld bc, $0605
    call CopyRectTo20ByteRowsJp_Bank24
    call Func_024_51A3
    call BGMapAddressAtScroll_Bank24
    ld bc, $140D
    ld de, $01CC
    call Func_024_4E57
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 5 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wTwoChoiceCursor, wD781
; writes: wD781
GameMode6_Update_Table3_Case05::
Jump_024_4355:: ; address name
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_024_437D
    cp a, $FF
    jr z, Jump_024_4369
    ret

Jump_024_4369::
    ld a, [wTwoChoiceCursor]
    and a, a
    jr nz, Jump_024_437D
    ld a, $07
    call Func_024_4EE8
    ld a, [wD781]
    add a, $02
    ld [wD781], a
    ret

Jump_024_437D::
    call Func_024_4D65
    call Func_024_4F0C
    ld a, $06
    call Func_024_4EE8
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 6 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
GameMode6_Update_Table3_Case06::
Jump_024_4390:: ; address name
    call Func_024_4DEB
    ret

; entry 7 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wTwoChoiceCursor, wD781
; points at: wC40E
GameMode6_Update_Table3_Case07::
Jump_024_4394:: ; address name
    ld a, $6C
    call QueueSoundEffect
    call Func_024_4DA8
    ld de, Data_024_5A50
    ld hl, wC40E
    ld bc, $0A05
    call CopyRectTo20ByteRowsJp_Bank24
    call Func_024_51A3
    call BGMapAddressAtScroll_Bank24
    ld bc, $140D
    ld de, $01CC
    call Func_024_4E57
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 8 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wTwoChoiceCursor, wD781
; writes: wD781, wTwoChoiceCursor
; points at: wC412
GameMode6_Update_Table3_Case08::
Jump_024_43C3:: ; address name
    call GameMode6_Update_Table3_Case08_Sub01
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_024_43F1
    cp a, $FF
    jr z, Jump_024_43D4
    ret

Jump_024_43D4::
    ld a, [wTwoChoiceCursor]
    and a, a
    jr nz, Jump_024_43E2
    farcall Func_01D_5F2D
    jr Jump_024_43E8

Jump_024_43E2::
    farcall Func_01D_6026

Jump_024_43E8::
    ld a, [wD781]
    add a, $02
    ld [wD781], a
    ret

Jump_024_43F1::
    call Func_024_4D65
    ld de, Data_024_5A0A
    ld hl, wC412
    ld bc, $0605
    call CopyRectTo20ByteRowsJp_Bank24
    xor a, a
    ld b, $BC
    ld hl, Data_024_5AAA
    call StoreBAtWordTableEntry_Bank24_52CE
    call Func_024_51A3
    call BGMapAddressAtScroll_Bank24
    ld bc, $140D
    ld de, $01CC
    call Func_024_4E57
    xor a, a
    ld b, $C3
    ld hl, Data_024_5AAA
    call StoreBAtWordTableEntry_Bank24_52CE
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, $05
    call Func_024_4EE8
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 9 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; writes: wD781
GameMode6_Update_Table3_Case09::
Jump_024_4432:: ; address name
    ld a, $05
    ld [wD781], a
    ret

; entry 10 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD7A9, wD781, wTwoChoiceCursor
; writes: wD781
GameMode6_Update_Table3_Case0A::
Jump_024_4438:: ; address name
    ld a, [wD7A9]
    and a, a
    jr nz, Jump_024_444C
    ld a, $11
    call Func_024_4EE8
    ld a, [wD781]
    sub a, $02
    ld [wD781], a
    ret

Jump_024_444C::
    ld a, [wTwoChoiceCursor]
    ld b, $BC
    ld hl, Data_024_5AAA
    call StoreBAtWordTableEntry_Bank24_52CE
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 11 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD092, wD781
; writes: wD781
; points at: wC3F7, wC300
GameMode6_Update_Table3_Case0B::
Jump_024_445F:: ; address name
    ld a, [wD092]
    cp a, $08
    jr nz, Jump_024_4474
    ld de, Data_024_58CA
    ld hl, wC3F7
    ld bc, $0606
    call CopyRectTo20ByteRowsJp_Bank24
    jr Jump_024_4477

Jump_024_4474::
    call Func_024_4D21

Jump_024_4477::
    call BGMapAddressAtScroll_Bank24
    ld bc, $140D
    ld de, $01CC
    call Func_024_4E57
    ld de, Data_024_5942
    ld hl, wC300
    ld bc, $1405
    call CopyRectTo20ByteRowsJp_Bank24
    call Func_024_51A3
    call BGMapAddressAtScroll_Bank24
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call Func_024_4E57
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 12 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wTwoChoiceCursor, wD780
; writes: wD781, wD780
; points at: wC300
GameMode6_Update_Table3_Case0C::
Jump_024_44AA:: ; address name
    ld b, $46
    ld de, Data_046_4001
    ld hl, vTiles1
    call DecompressToVRAM
    ld de, vTiles1
    ld b, $24

Jump_024_44BA::
    push bc
    ld hl, Data_024_44FE
    call CopyTileBytesToVRAM_Bank24_52BA
    pop bc
    dec b
    jr nz, Jump_024_44BA
    ld de, Data_024_59A6
    ld hl, wC300
    ld bc, $1405
    call CopyRectTo20ByteRowsJp_Bank24
    call Func_024_51A3
    call BGMapAddressAtScroll_Bank24
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call Func_024_4E57
    ld a, [wTwoChoiceCursor]
    add a, $08
    call Func_024_4EE8
    xor a, a
    ld [wD781], a
    ld a, [wD780]
    add a, $02
    ld b, a
    ld a, [wTwoChoiceCursor]
    add a, b
    ld [wD780], a
    ret

Data_024_44FE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00

; entry 13 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
GameMode6_Update_Table3_Case0D::
Jump_024_450E:: ; address name
    call Func_024_568E
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 14 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
GameMode6_Update_Table3_Case0E::
Jump_024_4519:: ; address name
    call Func_024_567C
    call GameMode6_Update_Table3_Case0E_Sub01
    ret

; entry 15 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; writes: wD781, wD782
GameMode6_Update_Table3_Case0F::
Jump_024_4520:: ; address name
    xor a, a
    ld [wD781], a
    ld a, $01
    ld [wD782], a
    ret

; entry 3 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
GameMode6_Update_Case03::
Jump_024_452A:: ; address name
    ld a, [wD781]
    rst $00
    dw GameMode6_Update_Table4_Case00
    dw GameMode6_Update_Table4_Case01
    dw GameMode6_Update_Table4_Case02
    dw GameMode6_Update_Table4_Case03

; entry 0 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
GameMode6_Update_Table4_Case00::
Jump_024_4536:: ; address name
    call Func_024_568E
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 1 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
GameMode6_Update_Table4_Case01::
Jump_024_4541:: ; address name
    call Func_024_567C
    call GameMode6_Update_Table4_Case01_Sub01
    ret

; entry 2 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wC8C3, wC8C4, wD781
GameMode6_Update_Table4_Case02::
Jump_024_4548:: ; address name
    xor a, a
    ld [wC8C3], a
    ld [wC8C4], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 3 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wC8C3
GameMode6_Update_Table4_Case03::
Jump_024_4557:: ; address name
    farcall Func_002_7333
    ld a, [wC8C3]
    bit 7, a
    ret z
    call Func_024_4DEB
    ret

; entry 4 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
GameMode6_Update_Case04::
Jump_024_4567:: ; address name
    ld a, [wD781]
    rst $00
    dw GameMode6_Update_Table5_Case00
    dw GameMode6_Update_Table5_Case00
    dw GameMode6_Update_Table5_Case00
    dw GameMode6_Update_Table5_Case00
    dw GameMode6_Update_Table5_Case04
    dw GameMode6_Update_Table5_Case04
    dw GameMode6_Update_Table5_Case06
    dw GameMode6_Update_Table5_Case07
    dw GameMode6_Update_Table5_Case08
    dw GameMode6_Update_Table5_Case04
    dw GameMode6_Update_Table5_Case0A
    dw GameMode6_Update_Table5_Case0B
    dw GameMode6_Update_Table5_Case0C
    dw GameMode6_Update_Table5_Case0D

; entry 0 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
GameMode6_Update_Table5_Case00::
Jump_024_4587:: ; address name
    farcall ScriptCommandED_Run
    ret

; entry 4 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
GameMode6_Update_Table5_Case04::
Jump_024_458E:: ; address name
    farcall Func_01B_665E
    ret

; entry 6 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
GameMode6_Update_Table5_Case06::
Jump_024_4595:: ; address name
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 7 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD7AB, wD781
; writes: wD781
GameMode6_Update_Table5_Case07::
Jump_024_459D:: ; address name
    ld a, [wD7AB]
    ld b, $BB
    ld hl, Data_024_5AAE
    call StoreBAtWordTableEntry_Bank24_52CE
    call BGMapAddressAtScroll_Bank24
    ld bc, $140D
    ld de, $01CC
    call Func_024_4E57
    ld a, [wD7AB]
    ld b, $C3
    ld hl, Data_024_5AAE
    call StoreBAtWordTableEntry_Bank24_52CE
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 8 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD782
GameMode6_Update_Table5_Case08::
Jump_024_45C7:: ; address name
    ld a, [wD782]
    rst $00
    dw GameMode6_Update_Table6_Case00
    dw GameMode6_Update_Table6_Case01
    dw GameMode6_Update_Table6_Case02

; entry 0 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wD7AB, wD781, wD782
; writes: wMenuInputResult, wD782, wD781
GameMode6_Update_Table6_Case00::
Jump_024_45D1:: ; address name
    xor a, a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_024_45F5
    cp a, $FC
    jr z, Jump_024_45F5
    cp a, $FD
    jr z, Jump_024_45FE
    cp a, $FE
    jr z, Jump_024_4607
    cp a, $FF
    jr z, Jump_024_460F
    ret

Jump_024_45F5::
    ld a, [wD781]
    sub a, $07
    ld [wD781], a
    ret

Jump_024_45FE::
    ld a, [wD781]
    sub a, $04
    ld [wD781], a
    ret

Jump_024_4607::
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_024_460F::
    call GameMode6_Update_Table6_Case00_Sub01
    cp a, $FF
    jr nz, Jump_024_4621
    ld a, $02
    ld [wD782], a
    ld a, $12
    call Func_024_4EE8
    ret

Jump_024_4621::
    ld a, [wD7AB]
    ld b, $BC
    ld hl, Data_024_5AAE
    call StoreBAtWordTableEntry_Bank24_52CE
    farcall Func_01B_76E3
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 1 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wTwoChoiceCursor, wD092, wD7EB
; writes: wD782, wD7AF, wD7AB, wD780, wD781
; points at: wC364, wC3F7, wC40E, wC37A
GameMode6_Update_Table6_Case01::
Jump_024_463A:: ; address name
    ld de, Data_024_5814
    ld hl, wC364
    ld bc, $0E0D
    call CopyRectTo20ByteRowsJp_Bank24
    ld a, [wTwoChoiceCursor]
    ld b, $BB
    ld hl, Data_024_5AAA
    call StoreBAtWordTableEntry_Bank24_52CE
    ld a, [wD092]
    cp a, $08
    jr nz, Jump_024_4666
    ld de, Data_024_58CA
    ld hl, wC3F7
    ld bc, $0606
    call CopyRectTo20ByteRowsJp_Bank24
    jr Jump_024_4678

Jump_024_4666::
    ld a, [wD7EB]
    and a, a
    jr nz, Jump_024_4678
    ld de, Data_024_57F2
    ld hl, wC37A
    ld bc, $1102
    call CopyRectTo20ByteRowsJp_Bank24

Jump_024_4678::
    ld de, Data_024_5A50
    ld hl, wC40E
    ld bc, $0A05
    call CopyRectTo20ByteRowsJp_Bank24
    call BGMapAddressAtScroll_Bank24
    ld bc, $140D
    ld de, $01CC
    call Func_024_4E57
    ld a, [wTwoChoiceCursor]
    ld b, $C3
    ld hl, Data_024_5AAA
    call StoreBAtWordTableEntry_Bank24_52CE
    xor a, a
    ld [wD782], a
    ld [wD7AF], a
    ld [wD7AB], a
    ld a, $07
    call Func_024_4EE8
    ld a, $02
    ld [wD780], a
    ld a, $08
    ld [wD781], a
    ret

; entry 2 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; writes: wD782
GameMode6_Update_Table6_Case02::
Jump_024_46B5:: ; address name
    xor a, a
    ld [wD782], a
    ret

; entry 10 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5, wD7AD, wD780, wD781, wC6FD, wD7AF, wD7AB
; writes: wD7F5, wD7B2, wD7B3, wD781, wD782, wD780
GameMode6_Update_Table5_Case0A::
Jump_024_46BA:: ; address name
    xor a, a
    ld [wD7F5], a
    farcall Func_00D_4D24
    ld a, [wD7F5]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_024_46D2
    cp a, $FF
    jr z, Jump_024_46DA
    ret

Jump_024_46D2::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_024_46DA::
    ld a, [wD7AD]
    and a, a
    jr nz, Jump_024_46F9
    ld a, [wD780]
    ld [wD7B2], a
    ld a, [wD781]
    ld [wD7B3], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $0C
    ld [wD780], a
    ret

Jump_024_46F9::
    ld a, [wC6FD]
    cp a, $02
    jr nc, Jump_024_4713
    ld a, [wD7AF]
    and a, a
    jr nz, Jump_024_4713
    ld a, [wD7AB]
    and a, a
    jr nz, Jump_024_4713
    ld a, $12
    call Func_024_4EE8
    jr Jump_024_46D2

Jump_024_4713::
    call GameMode6_Update_Table5_Case0A_Sub01
    ld a, $0A
    call Func_024_4EE8
    ld a, [wD781]
    add a, $02
    ld [wD781], a
    ret

; entry 11 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD7AB, wD781
; writes: wD781
; points at: wC410
GameMode6_Update_Table5_Case0B::
Jump_024_4724:: ; address name
    ld de, Data_024_5A28
    ld hl, wC410
    ld bc, $0805
    call CopyRectTo20ByteRowsJp_Bank24
    xor a, a
    ld b, $BC
    ld hl, Data_024_5AAA
    call StoreBAtWordTableEntry_Bank24_52CE
    call Func_024_4DA8
    call BGMapAddressAtScroll_Bank24
    ld bc, $140D
    ld de, $01CC
    call Func_024_4E57
    ld a, [wD7AB]
    ld b, $C3
    ld hl, Data_024_5AAE
    call StoreBAtWordTableEntry_Bank24_52CE
    ld a, [wD781]
    sub a, $03
    ld [wD781], a
    ret

; entry 12 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5, wD7F6, wCA36, wCA37, wD781
; writes: wD7F1, wD7F2, rRAMG, rRAMB, wD006, wD007, wC8C3, wC8C4, ...
; points at: sA000, wCA2B
GameMode6_Update_Table5_Case0C::
Jump_024_475C:: ; address name
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld [wD7F1], a
    xor a, a
    ld [wD7F2], a
    farcall Func_014_7E96
    ld a, [wD7F5]
    ld c, $A5
    call Multiply8
    ld de, sA000
    add hl, de
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld b, $A5
    ld de, wCA2B

Jump_024_4792::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_024_4792
    ld a, [wCA36]
    ld [wD006], a
    ld a, [wCA37]
    ld [wD007], a
    farcall Func_016_5AAF
    xor a, a
    ld [rRAMG], a
    ld [rRAMB], a
    ld [wC8C3], a
    ld [wC8C4], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 13 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wC8C3
GameMode6_Update_Table5_Case0D::
Jump_024_47BF:: ; address name
    farcall Func_002_7333
    ld a, [wC8C3]
    bit 7, a
    ret z
    call Func_024_4DEB
    ret

; entry 5 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
GameMode6_Update_Case05::
Jump_024_47CF:: ; address name
    ld a, [wD781]
    rst $00
    dw GameMode6_Update_Table7_Case00
    dw GameMode6_Update_Table7_Case01
    dw GameMode6_Update_Table7_Case02
    dw GameMode6_Update_Table7_Case03
    dw GameMode6_Update_Table7_Case04
    dw GameMode6_Update_Table7_Case05
    dw GameMode6_Update_Table7_Case06
    dw GameMode6_Update_Table7_Case07
    dw GameMode6_Update_Table7_Case08
    dw GameMode6_Update_Table7_Case09
    dw GameMode6_Update_Table7_Case0A
    dw GameMode6_Update_Table7_Case0B

; entry 0 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
GameMode6_Update_Table7_Case00::
Jump_024_47EB:: ; address name
    call Func_024_53A0
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 1 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
; points at: wC364
GameMode6_Update_Table7_Case01::
Jump_024_47F6:: ; address name
    ld de, Data_024_5B10
    ld hl, wC364
    ld bc, $0D09
    call CopyRectTo20ByteRowsJp_Bank24
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 2 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD7B0, wD781
; writes: wD7F1, wD7F2, wD781
; points at: wC40B, wC40C
GameMode6_Update_Table7_Case02::
Jump_024_480A:: ; address name
    farcall Func_01E_71E1
    ld a, [wD7B0]
    cp a, $02
    jr c, Jump_024_482E
    ld hl, wC40B
    call StoreC5BEC6AtHLStride2_Bank24
    ld hl, wC40C
    ld a, h
    ld [wD7F1], a
    ld a, l
    ld [wD7F2], a
    farcall Func_01E_759A

Jump_024_482E::
    call BGMapAddressAtScroll_Bank24
    ld bc, $140D
    ld de, $01CC
    call Func_024_4E57
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 3 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD7F5, wD781
GameMode6_Update_Table7_Case03::
Jump_024_4842:: ; address name
    xor a, a
    ld [wD7F5], a
    farcall Func_01D_6088
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 4 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD7F1, wD7F2, wD781
GameMode6_Update_Table7_Case04::
Jump_024_4854:: ; address name
    ld de, Data_01F_4990
    ld hl, vTiles1 + $4E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    xor a, a
    ld [wD7F1], a
    ld a, $02
    ld [wD7F2], a
    farcall Func_01D_6320
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 5 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wD7AB, wD781
; writes: wMenuInputResult, wD781
GameMode6_Update_Table7_Case05::
Jump_024_4878:: ; address name
    xor a, a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_024_489C
    cp a, $FC
    jr z, Jump_024_489C
    cp a, $FD
    jr z, Jump_024_48A5
    cp a, $FE
    jr z, Jump_024_48A6
    cp a, $FF
    jr z, Jump_024_48AE
    ret

Jump_024_489C::
    ld a, [wD781]
    sub a, $05
    ld [wD781], a
    ret

Jump_024_48A5::
    ret

Jump_024_48A6::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_024_48AE::
    ld a, [wD7AB]
    ld b, $BC
    ld hl, Data_024_5AAE
    call StoreBAtWordTableEntry_Bank24_52CE
    farcall Func_01B_76E3
    ld a, [wD781]
    add a, $02
    ld [wD781], a
    ret

; entry 6 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wTwoChoiceCursor
; writes: wD780, wD781, wD782, wD7AF, wD7AB
GameMode6_Update_Table7_Case06::
Jump_024_48C8:: ; address name
    ld a, [wTwoChoiceCursor]
    ld b, $C3
    ld hl, Data_024_5AAA
    call StoreBAtWordTableEntry_Bank24_52CE
    ld a, $04
    ld [wD780], a
    ld a, $08
    ld [wD781], a
    ld a, $01
    ld [wD782], a
    xor a, a
    ld [wD7AF], a
    ld [wD7AB], a
    ret

; entry 7 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wC52D, wC52E, wC52F, wC530, wStringCategory, wStringIndex, wD7AD, wD781
; points at: wC410
GameMode6_Update_Table7_Case07::
Jump_024_48EA:: ; address name
    ld hl, vTiles2 + $700
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0C01
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    xor a, a
    ld [wStringCategory], a
    ld a, $0D
    ld [wStringIndex], a
    farcall ShowString_Bank33_7045
    ld a, $6C
    call QueueSoundEffect
    ld de, Data_024_5B85
    ld hl, wC410
    ld bc, $0805
    call CopyRectTo20ByteRowsJp_Bank24
    call BGMapAddressAtScroll_Bank24
    ld bc, $140D
    ld de, $01CC
    call Func_024_4E57
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
    ld [wD7AD], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 8 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5, wD7AD, wD780, wD781, wD7F6
; writes: wD7F5, wD7B2, wD7B3, wD781, wD782, wD780
GameMode6_Update_Table7_Case08::
Jump_024_494E:: ; address name
    xor a, a
    ld [wD7F5], a
    farcall Func_00D_4D24
    ld a, [wD7F5]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_024_4966
    cp a, $FF
    jr z, Jump_024_496E
    ret

Jump_024_4966::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_024_496E::
    ld a, [wD7AD]
    and a, a
    jr nz, Jump_024_498D
    ld a, [wD780]
    ld [wD7B2], a
    ld a, [wD781]
    ld [wD7B3], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $0D
    ld [wD780], a
    ret

Jump_024_498D::
    farcall SetWD7F5ToWD789Cell4
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    call GameMode6_Update_Table7_Case08_Sub01
    call CopyMonsterNameToBuffer_B24
    ld a, $0A
    call Func_024_4EE8
    ld a, [wD781]
    add a, $02
    ld [wD781], a
    ret

; entry 9 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD7AB, wD781
; writes: wD781
; points at: wC410
GameMode6_Update_Table7_Case09::
Jump_024_49AF:: ; address name
    ld de, Data_024_5A82
    ld hl, wC410
    ld bc, $0805
    call CopyRectTo20ByteRowsJp_Bank24
    ld a, $01
    ld b, $BC
    ld hl, Data_024_5AAA
    call StoreBAtWordTableEntry_Bank24_52CE
    call Func_024_4DA8
    call BGMapAddressAtScroll_Bank24
    ld bc, $140D
    ld de, $01CC
    call Func_024_4E57
    ld a, [wD7AB]
    ld b, $C3
    ld hl, Data_024_5AAE
    call StoreBAtWordTableEntry_Bank24_52CE
    ld a, [wD781]
    sub a, $04
    ld [wD781], a
    ret

; entry 10 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5, wD7F6, wCA36, wCA37, wD781
; writes: wD7F1, wD7F2, rRAMG, rRAMB, wD006, wD007, wC8C3, wC8C4, ...
; points at: sA000, wCA2B
GameMode6_Update_Table7_Case0A::
Jump_024_49E8:: ; address name
    farcall SetWD7F5ToWD789Cell4
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld [wD7F1], a
    xor a, a
    ld [wD7F2], a
    farcall Func_014_7E96
    ld a, [wD7F5]
    ld c, $A5
    call Multiply8
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld de, sA000
    add hl, de
    ld b, $A5
    ld de, wCA2B

Jump_024_4A1E::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_024_4A1E
    ld a, [wCA36]
    ld [wD006], a
    ld a, [wCA37]
    ld [wD007], a
    farcall Func_016_5AAF
    xor a, a
    ld [rRAMG], a
    ld [rRAMB], a
    xor a, a
    ld [wC8C3], a
    ld [wC8C4], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 11 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wC8C3
GameMode6_Update_Table7_Case0B::
Jump_024_4A4C:: ; address name
    farcall Func_002_7333
    ld a, [wC8C3]
    bit 7, a
    ret z
    call Func_024_4DEB
    ret

; entry 6 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
GameMode6_Update_Case06::
Jump_024_4A5C:: ; address name
    ret

; entry 12 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD781, wD780
; writes: wD781, wD782, wD780
GameMode6_Update_Case0C::
Jump_024_4A5D:: ; address name
    farcall ScriptCommandE8_Run
    ld a, [wD781]
    cp a, $0A
    ret nz
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, [wD780]
    add a, $03
    ld [wD780], a
    ret

; entry 13 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD781, wD780
; writes: wD781, wD782, wD780
GameMode6_Update_Case0D::
Jump_024_4A79:: ; address name
    farcall ScriptCommandE8_Run
    ld a, [wD781]
    cp a, $0A
    ret nz
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

; entry 14 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
GameMode6_Update_Case0E::
Jump_024_4A94:: ; address name
    ld a, [wD781]
    rst $00
    dw GameMode6_Update_Table8_Case00
    dw GameMode6_Update_Table8_Case01
    dw GameMode6_Update_Table8_Case02
    dw GameMode6_Update_Table8_Case03
    dw GameMode6_Update_Table8_Case04
    dw GameMode6_Update_Table8_Case05

; entry 0 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD092, wD7AB, wD781
; writes: wC52D, wC52E, wC52F, wC530, wStringCategory, wStringIndex, wD781
; points at: wC3F7, wC364
GameMode6_Update_Table8_Case00::
Jump_024_4AA4:: ; address name
    ld b, $46
    ld de, Data_046_4001
    ld hl, vTiles1
    call DecompressToVRAM
    ld hl, vTiles2 + $700
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0C01
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    xor a, a
    ld [wStringCategory], a
    ld a, $0D
    ld [wStringIndex], a
    farcall ShowString_Bank33_7045
    call Func_024_53A0
    ld a, [wD092]
    cp a, $08
    jr nz, Jump_024_4AEC
    ld de, Data_024_58CA
    ld hl, wC3F7
    ld bc, $0606
    call CopyRectTo20ByteRowsJp_Bank24
    jr Jump_024_4AEF

Jump_024_4AEC::
    call Func_024_4D21

Jump_024_4AEF::
    ld de, Data_024_5B10
    ld hl, wC364
    ld bc, $0D09
    call CopyRectTo20ByteRowsJp_Bank24
    ld a, [wD7AB]
    ld b, $BB
    ld hl, Data_024_5AAE
    call StoreBAtWordTableEntry_Bank24_52CE
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 1 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD7B0, wD781
; writes: wD7F1, wD7F2, wD781
; points at: wC40B, wC40C
GameMode6_Update_Table8_Case01::
Jump_024_4B0E:: ; address name
    farcall Func_01D_6026
    farcall Func_01E_71E1
    ld a, [wD7B0]
    cp a, $02
    jr c, Jump_024_4B38
    ld hl, wC40B
    call StoreC5BEC6AtHLStride2_Bank24
    ld hl, wC40C
    ld a, h
    ld [wD7F1], a
    ld a, l
    ld [wD7F2], a
    farcall Func_01E_759A

Jump_024_4B38::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 2 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD7F5, wD781
GameMode6_Update_Table8_Case02::
Jump_024_4B40:: ; address name
    xor a, a
    ld [wD7F5], a
    farcall Func_01D_6088
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 3 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD7F1, wD7F2, wD781
GameMode6_Update_Table8_Case03::
Jump_024_4B52:: ; address name
    ld de, Data_01F_4990
    ld hl, vTiles1 + $4E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, $01
    ld [wD7F1], a
    ld a, $02
    ld [wD7F2], a
    farcall Func_01D_6320
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 4 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wC52D, wC52E, wC52F, wC530, wStringCategory, wStringIndex, wD781
; points at: wC410
GameMode6_Update_Table8_Case04::
Jump_024_4B77:: ; address name
    ld de, Data_024_5B85
    ld hl, wC410
    ld bc, $0805
    call CopyRectTo20ByteRowsJp_Bank24
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
    ld [wStringCategory], a
    ld a, $09
    ld [wStringIndex], a
    farcall ShowString_Bank33_7045
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 5 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD7AB, wD7B2, wD7B3, wGameMode, wC581
; writes: hFFBA, wD782, wD780, wD781, wC52D, wC52E, wC52F, wC530
GameMode6_Update_Table8_Case05::
Jump_024_4BB0:: ; address name
    ld a, [wD7AB]
    ld b, $BC
    ld hl, Data_024_5AAE
    call StoreBAtWordTableEntry_Bank24_52CE
    call BGMapAddressAtScroll_Bank24
    ld bc, $140D
    ld de, $01CC
    call Func_024_4E57
    call BGMapAddressAtScroll_Bank24
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call Func_024_4E57
    ld a, $70
    ldh [hFFBA], a
    xor a, a
    ld [wD782], a
    ld a, [wD7B2]
    ld [wD780], a
    ld a, [wD7B3]
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
    ld a, [wGameMode]
    cp a, $05
    ret nz
    ld a, [wC581]
    cp a, $08
    ret z
    ld a, $08
    ld [wD781], a
    ld a, $11
    ld [wD780], a
    ret

; entry 15 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
GameMode6_Update_Case0F::
Jump_024_4C18:: ; address name
    ld a, [wD781]
    rst $00
    dw GameMode6_Update_Table9_Case00
    dw GameMode6_Update_Table9_Case01
    dw GameMode6_Update_Table9_Case02
    dw GameMode6_Update_Table9_Case03
    dw GameMode6_Update_Table9_Case03
    dw GameMode6_Update_Table9_Case05
    dw GameMode6_Update_Table9_Case03
    dw GameMode6_Update_Table9_Case07

; entry 0 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD092, wD7AB, wD781
; writes: wC52D, wC52E, wC52F, wC530, wStringCategory, wStringIndex, wD781
; points at: wC364, wC3F7
GameMode6_Update_Table9_Case00::
Jump_024_4C2C:: ; address name
    ld b, $46
    ld de, Data_046_4001
    ld hl, vTiles1
    call DecompressToVRAM
    ld hl, vTiles2 + $700
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0C01
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    xor a, a
    ld [wStringCategory], a
    ld a, $0D
    ld [wStringIndex], a
    farcall ShowString_Bank33_7045
    call GameMode6_Update_Table9_Case00_Sub01
    ld a, [wD092]
    cp a, $08
    jr z, Jump_024_4C69
    call Func_024_4D21

Jump_024_4C69::
    ld a, [wD092]
    cp a, $08
    jr z, Jump_024_4C75
    call GameMode6_Update_Table9_Case00_Sub02
    jr Jump_024_4C81

Jump_024_4C75::
    ld de, Data_024_58CA
    ld hl, wC3F7
    ld bc, $0606
    call CopyRectTo20ByteRowsJp_Bank24

Jump_024_4C81::
    ld de, Data_024_5AB8
    ld hl, wC364
    ld bc, $080B
    call CopyRectTo20ByteRowsJp_Bank24
    ld a, [wD7AB]
    ld b, $BC
    ld hl, Data_024_5AAE
    call StoreBAtWordTableEntry_Bank24_52CE
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 1 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD7B0, wD781
; writes: wD7F1, wD7F2, wD781
; points at: wC42E, wC42F
GameMode6_Update_Table9_Case01::
Jump_024_4CA0:: ; address name
    farcall Func_01D_5F2D
    farcall Func_01E_7163
    ld a, [wD7B0]
    cp a, $02
    jr c, Jump_024_4CCA
    ld hl, wC42E
    call StoreC5BEC6AtHLStride2_Bank24
    ld hl, wC42F
    ld a, h
    ld [wD7F1], a
    ld a, l
    ld [wD7F2], a
    farcall Func_01E_759A

Jump_024_4CCA::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 2 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; writes: wD7F1
GameMode6_Update_Table9_Case02::
Jump_024_4CD2:: ; address name
    farcall Func_01F_5C15
    xor a, a
    ld [wD7F1], a
    farcall Func_01D_6AA5
    ret

; entry 3 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
GameMode6_Update_Table9_Case03::
Jump_024_4CE3:: ; address name
    farcall Func_01B_665E
    ret

; entry 5 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
GameMode6_Update_Table9_Case05::
Jump_024_4CEA:: ; address name
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 7 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; writes: wC52D, wC52E, wC52F, wC530, wStringIndex, wStringCategory
GameMode6_Update_Table9_Case07::
Jump_024_4CF2:: ; address name
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
    ld a, $08
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    farcall ShowString_Bank33_7045
    farcall Func_01B_665E
    ret

; 3 call sites from 3 routines (e.g. GameMode6_Update_Table3_Case0B, GameMode6_Update_Table8_Case00, GameMode6_Update_Table9_Case00)
; reads: wD7EB
; points at: wC37A
Func_024_4D21::
    ld a, [wD7EB]
    and a, a
    ret nz
    call Func_024_504C
    ld de, Data_024_57F2
    ld hl, wC37A
    ld bc, $1102
    call CopyRectTo20ByteRowsJp_Bank24
    ret

; only called from GameMode6_Update_Table2_Case00 (E-0047)
; 1 call site from 1 routine (e.g. GameMode6_Update_Table2_Case00)
; reads: wIsCGB
; points at: wD1E3
GameMode6_Update_Table2_Case00_Sub01::
Func_024_4D36:: ; address name
    ld a, [wIsCGB]
    and a, a
    ret z
    ld hl, rBGPI
    di
    call WaitForVRAMAccess
    ld a, $B8
    ld [hl+], a
    ei
    ld de, Data_024_6CA4
    ld b, $08

Jump_024_4D4B::
    di
    call WaitForVRAMAccess
    ld a, [de]
    ld [hl], a
    ei
    inc de
    dec b
    jr nz, Jump_024_4D4B
    ld de, Data_024_57D6
    ld hl, wD1E3
    ld b, $1C

Jump_024_4D5E::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_024_4D5E
    ret

; 3 call sites from 3 routines (e.g. GameMode6_Update_Table3_Case08, GameMode6_Update_Table3_Case05, GameMode6_Update_Table3_Case04)
; writes: wC52D, wC52E, wC52F, wC530, wStringCategory, wStringIndex, wC52B, wC52C
Func_024_4D65::
    ld hl, vTiles2 + $6D0
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0301
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    xor a, a
    ld [wStringCategory], a
    ld a, $0C
    ld [wStringIndex], a
    farcall ShowString_Bank33_7045
    xor a, a
    ld [wC52B], a
    ld [wC52C], a
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

; 3 call sites from 3 routines (e.g. GameMode6_Update_Table3_Case07, GameMode6_Update_Table5_Case0B, GameMode6_Update_Table7_Case09)
; writes: wC52D, wC52E, wC52F, wC530, wStringCategory, wStringIndex, wC52B, wC52C
Func_024_4DA8::
    ld hl, vTiles2 + $760
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0701
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    xor a, a
    ld [wStringCategory], a
    ld a, $0B
    ld [wStringIndex], a
    farcall ShowString_Bank33_7045
    xor a, a
    ld [wC52B], a
    ld [wC52C], a
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

; 6 call sites from 6 routines (e.g. GameMode6_Update_Table2_Case01, GameMode6_Update_Table3_Case06, GameMode6_Update_Table3_Case02, GameMode6_Update_Table4_Case03, ...)
; reads: wD092
; writes: wC94B, wGameMode, wModeState, wModeChangeRequest
; points at: wD780
Func_024_4DEB::
    ld hl, wD780
    ld bc, $006F

Jump_024_4DF1::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_024_4DF1
    xor a, a
    ld [wC94B], a
    ld a, $05
    ld [wGameMode], a
    ld a, $01
    ld [wModeState], a
    ld a, $01
    ld [wModeChangeRequest], a
    ld a, [wD092]
    cp a, $08
    ret nz
    ret

; the same steps as CopyRectTo20ByteRows (copy a B x C rectangle from DE to HL with rows 20 bytes apart; on CGB zero-fill the same rectangle at HL + $0E68 with rSVBK = 2) but encoded with jp instead of jr, so its bytes differ (E-0066)
; 22 call sites from 16 routines (e.g. GameMode6_Update_Case01, GameMode6_Update_Table2_Case00, GameMode6_Update_Table3_Case0C, GameMode6_Update_Table3_Case0B, ...)
; reads: wIsCGB
; writes: rSVBK
CopyRectTo20ByteRowsJp_Bank24::
Func_024_4E12:: ; address name
    push hl
    push bc

Jump_024_4E14::
    push hl
    push bc

Jump_024_4E16::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_024_4E16
    pop bc
    pop hl
    ld a, l
    add a, $14
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec c
    jp nz, Jump_024_4E14
    pop bc
    pop hl
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, l
    add a, $68
    ld l, a
    ld a, h
    adc a, $0E
    ld h, a
    ld a, $02
    ldh [rSVBK], a

Jump_024_4E3D::
    push hl
    push bc

Jump_024_4E3F::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_024_4E3F
    pop bc
    pop hl
    ld a, l
    add a, $14
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec c
    jp nz, Jump_024_4E3D
    ld a, $00
    ldh [rSVBK], a
    ret

; 18 call sites from 15 routines (e.g. GameMode6_Init, GameMode6_Update_Case01, GameMode6_Update_Table2_Case00, GameMode6_Update_Table3_Case0C, ...)
; reads: wIsCGB
; writes: wC554, wC555, rSVBK
; points at: wScreenTileBuffer, wD000
Func_024_4E57::
    push de
    push bc
    push hl
    ld hl, wScreenTileBuffer
    add hl, de
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    pop hl
    push hl
    call CopyRectToBGMapWrapped
    pop hl
    push hl
    ld a, l
    add a, $C1
    ld l, a
    ld a, h
    adc a, $01
    ld h, a
    ld a, l
    ld [wC554], a
    ld a, h
    ld [wC555], a
    pop hl
    pop bc
    pop de
    ld a, [wIsCGB]
    or a, a
    ret z
    push de
    call WaitForVRAMAccess
    push bc
    ld c, $4F
    ld a, $01
    ldh [c], a
    pop bc
    pop de
    ld a, $02
    ldh [rSVBK], a
    push hl
    ld hl, wD000
    add hl, de
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    pop hl
    call CopyRectToBGMapWrapped
    call WaitForVRAMAccess
    ld a, $00
    ldh [rSVBK], a
    ld c, $4F
    ld a, $00
    ldh [c], a
    ret

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX, hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
; 22 call sites from 17 routines (e.g. GameMode6_Init, GameMode6_Init_Sub01, GameMode6_Init_Sub01_Sub01, GameMode6_Update_Case01, ...)
; reads: hScrollY, hScrollX
BGMapAddressAtScroll_Bank24::
Func_024_4EAB:: ; address name
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

; DE = source, HL = destination, BC = count: copies BC bytes (BC = 0 copies 65536); DE and HL end past the copy; clobbers A, BC = 0 (E-0064) (the same 9 bytes appear in 13 banks)
; no direct call (reached through a table, a jump or a vector)
CopyBytesDEToHL_Bank24_4ECC:: ; heuristic: follows a terminator; C0
Func_024_4ECC:: ; address name
    ld a, [de]
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, CopyBytesDEToHL_Bank24_4ECC
    ret

; With rSVBK = 2, copies BC bytes from [DE] to [HL], each ANDed with $07; then rSVBK = 0 (the same 19 bytes appear in 5 banks)
; no direct call (reached through a table, a jump or a vector)
; writes: rSVBK
CopyLow3BitsToWRAMBank2_Bank24_4ED5:: ; heuristic: follows a terminator; C0
Func_024_4ED5:: ; address name
    ld a, $02
    ldh [rSVBK], a

Jump_024_4ED9::
    ld a, [de]
    and a, $07
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_024_4ED9
    ld a, $00
    ldh [rSVBK], a
    ret

; 15 call sites from 12 routines (e.g. GameMode6_Update_Table2_Case00, GameMode6_Update_Table3_Case0C, GameMode6_Update_Table3_Case0A, GameMode6_Update_Table3_Case08, ...)
; writes: wStringIndex, wStringCategory, wC52D, wC52E, wC52F, wC530
Func_024_4EE8::
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
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
    farcall BeginStringDisplay_Bank33_7037
    ret

; 2 call sites from 2 routines (e.g. GameMode6_Update_Table3_Case05, Func_024_5553_Case08)
; points at: wCA2C, wC130
Func_024_4F0C::
    ld hl, wCA2C
    jp Jump_024_4F15

; 1 call site from 1 routine (e.g. Func_024_5434_Case08)
; points at: wC987, wC130
Func_024_4F12::
    ld hl, wC987

Jump_024_4F15::
    ld de, wC130
    ld b, $0A

Jump_024_4F1A::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_024_4F25
    ld [de], a
    inc de
    inc hl
    dec b
    jr nz, Jump_024_4F1A

Jump_024_4F25::
    ld a, $F0
    ld [de], a
    ret

; only called from GameMode6_Update_Table6_Case00 (E-0047)
; 1 call site from 1 routine (e.g. GameMode6_Update_Table6_Case00)
; reads: wC6FD, wD7AB, wD7AF
GameMode6_Update_Table6_Case00_Sub01::
Func_024_4F29:: ; address name
    ld a, [wC6FD]
    cp a, $02
    jr nc, Jump_024_4F3F
    ld a, [wD7AB]
    and a, a
    jr nz, Jump_024_4F3F
    ld a, [wD7AF]
    and a, a
    jr nz, Jump_024_4F3F
    ld a, $FF
    ret

Jump_024_4F3F::
    xor a, a
    ret

; only called from GameMode6_Update_Table7_Case08 (E-0047)
; 1 call site from 1 routine (e.g. GameMode6_Update_Table7_Case08)
; writes: rRAMG, rRAMB
; points at: sA000
GameMode6_Update_Table7_Case08_Sub01::
Func_024_4F41:: ; address name
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, $A5
    call Multiply8
    ld de, sA000
    add hl, de
    ld a, $0B
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld d, [hl]
    ld h, d
    ld l, e
    xor a, a
    ld [rRAMG], a
    ld [rRAMB], a
    ret

; HL = string number; copies 16 bytes of that string of StringTable_MonsterNames (bank $08, via wDataBank) to wC8CF; wDataBank is restored
; 1 call site from 1 routine (e.g. GameMode6_Update_Table7_Case08)
; reads: wDataBank
; writes: wDataBank
; points at: wC130
CopyMonsterNameToBuffer_B24::
Func_024_4F68:: ; address name
    push hl
    ld a, [wDataBank]
    push af
    ld a, $08
    ld [wDataBank], a
    ld hl, StringDatabase
    ld a, $04
    add_a_to_hl
    call ReadWordFromDataBank
    ld a, b
    ld e, a
    ld a, c
    ld b, a
    ld a, e
    ld c, a
    pop af
    pop hl
    push af
    sla l
    rl h
    add hl, bc
    call ReadWordFromDataBank
    ld a, b
    ld e, a
    ld a, c
    ld d, a
    pop af
    ld [wDataBank], a
    ld hl, wC130
    ld b, $08
    ld c, $10
    call CopyFromBankWaitVRAM
    ret

; only called from GameMode6_Update_Table5_Case0A (E-0047)
; 1 call site from 1 routine (e.g. GameMode6_Update_Table5_Case0A)
; reads: wD7F5, wD7F6
; writes: rRAMG, rRAMB, wC8D9
; points at: wC8CF, wC130
GameMode6_Update_Table5_Case0A_Sub01::
Func_024_4FA3:: ; address name
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld c, $01
    call CopyRecordNameToWC8CF
    ld a, $F0
    ld [wC8D9], a
    ld hl, wC8CF
    ld de, wC130

Jump_024_4FCB::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_024_4FD5
    ld [de], a
    inc hl
    inc de
    jr Jump_024_4FCB

Jump_024_4FD5::
    ld a, $F0
    ld [de], a
    ret

; only called from GameMode6_Update_Table9_Case00 (E-0047)
; 1 call site from 1 routine (e.g. GameMode6_Update_Table9_Case00)
; writes: wC52D, wC52E, wC52F, wC530
GameMode6_Update_Table9_Case00_Sub01::
Func_024_4FD9:: ; address name
    ld hl, vTiles1 + $500
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0F01
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ld hl, vTiles1 + $700
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0501
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ld hl, vTiles1 + $780
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    call FillTilesFromRequest
    ld hl, vTiles1 + $240
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0301
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ld hl, vTiles1 + $4E0
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0201
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ret

; 1 call site from 1 routine (e.g. Func_024_4D21)
Func_024_504C::
    and a, $01
    and a, a
    jr nz, Jump_024_5058
    ld de, Data_024_6CE4
    ld b, $24
    jr Jump_024_505D

Jump_024_5058::
    ld de, Data_024_6E13
    ld b, $24

Jump_024_505D::
    ld hl, vTiles2
    call DecompressToVRAM
    ret

; only called from GameMode6_Init (E-0047)
; 1 call site from 1 routine (e.g. GameMode6_Init)
; reads: wD092, wIsCGB, wD7BD
; writes: wC526, hFFC6, wD7F5, wD7F6, wD7F1, wD7F2, wD7F3, wD7F4, ...
; points at: wD0DF, wD1C9, wD12D, wD217, wD17B, wD265, wC3F7, wC22B
GameMode6_Init_Sub01::
Func_024_5064:: ; address name
    ld a, [wD092]
    cp a, $08
    ret z
    ld a, [wIsCGB]
    and a, a
    jp z, Jump_024_50F0
    ld hl, wD0DF
    ld de, wD1C9
    call Func_024_51F7
    ld a, [hl+]
    ld e, a
    ld d, [hl]
    push de
    ld a, $7F
    ld [wC526], a
    call UploadBGPalettes
    ld a, $01
    ldh [hFFC6], a
    call BGMapAddressAtScroll_Bank24
    xor a, a
    call GameMode6_Init_Sub01_Sub02
    add hl, de
    pop de
    call LoadMonsterPictureAttributes
    ld a, [wD7BD]
    cp a, $01
    jr z, Jump_024_50F0
    ld hl, wD12D
    ld de, wD217
    call Func_024_51F7
    ld a, [hl+]
    ld e, a
    ld d, [hl]
    push de
    ld a, $7F
    ld [wC526], a
    call UploadBGPalettes
    ld a, $03
    ldh [hFFC6], a
    call BGMapAddressAtScroll_Bank24
    ld a, $02
    call GameMode6_Init_Sub01_Sub02
    add hl, de
    pop de
    call LoadMonsterPictureAttributes
    ld a, [wD7BD]
    cp a, $02
    jr z, Jump_024_50F0
    ld hl, wD17B
    ld de, wD265
    call Func_024_51F7
    ld a, [hl+]
    ld e, a
    ld d, [hl]
    push de
    ld a, $7F
    ld [wC526], a
    call UploadBGPalettes
    ld a, $05
    ldh [hFFC6], a
    call BGMapAddressAtScroll_Bank24
    ld a, $04
    call GameMode6_Init_Sub01_Sub02
    add hl, de
    pop de
    call LoadMonsterPictureAttributes

Jump_024_50F0::
    ld a, [wD092]
    cp a, $08
    jp nz, Jump_024_513A
    ld hl, wC3F7
    call GameMode6_Init_Sub01_Sub01
    ld hl, wC22B

; only called from GameMode6_Init_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. GameMode6_Init_Sub01)
GameMode6_Init_Sub01_Sub01::
Func_024_5101:: ; address name
    ld bc, $0606
    ld d, $20

Jump_024_5106::
    ld [hl], d
    inc d
    inc hl
    dec b
    jr nz, Jump_024_5106
    ld b, $06
    ld a, l
    add a, $0E
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec c
    jr nz, Jump_024_5106
    ld hl, vBGMap0 + $E7
    ld bc, $0606
    ld d, $20

Jump_024_5121::
    ld a, d
    call WriteVRAMByteInc
    inc d
    dec b
    jr nz, Jump_024_5121
    ld a, l
    add a, $1A
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld b, $06
    dec c
    jr nz, Jump_024_5121
    call Func_024_51A3
    ret

Jump_024_513A::
    call BGMapAddressAtScroll_Bank24
    ld de, $00E0
    add hl, de
    ld a, h
    ld [wD7F5], a
    ld a, l
    ld [wD7F6], a
    ld a, [wD7BD]
    dec a
    ld c, $78
    call Multiply8
    ld de, $720D
    add hl, de
    ld a, h
    ld [wD7F1], a
    ld a, l
    ld [wD7F2], a
    ld a, $14
    ld [wD7F3], a
    ld a, $06
    ld [wD7F4], a
    ld a, $01
    ld [wD7F7], a
    farcall Func_01F_5D2A
    ret

; only called from GameMode6_Init_Sub01 (E-0047)
; 3 call sites from 1 routine (e.g. GameMode6_Init_Sub01)
; reads: wD7BD
GameMode6_Init_Sub01_Sub02::
Func_024_5174:: ; address name
    push hl
    ld e, a
    ld d, $00
    ld a, [wD7BD]
    dec a
    ld hl, Data_024_5191
    jr z, Jump_024_518A
    dec a
    ld hl, Data_024_5197
    jr z, Jump_024_518A
    ld hl, Data_024_519D

Jump_024_518A::
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    pop hl
    ret

Data_024_5191:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $E7, $00, $00, $00, $00, $00

Data_024_5197:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $E4, $00, $EA, $00, $00, $00

Data_024_519D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $E1, $00, $E7, $00, $ED, $00

; 6 call sites from 6 routines (e.g. GameMode6_Init_Sub01_Sub01, GameMode6_Update_Table3_Case0C, GameMode6_Update_Table3_Case0B, GameMode6_Update_Table3_Case08, ...)
Func_024_51A3::
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wD092
; writes: rSVBK
; points at: wD25F
Func_024_51A4:: ; heuristic: follows a terminator; C0
    ld a, [wIsCGB]
    and a, a
    ret z
    ld a, [wD092]
    cp a, $08
    ret nz
    ld hl, Data_024_51D3
    ld de, wD25F
    ld a, $02
    ldh [rSVBK], a
    ld bc, $0606

Jump_024_51BC::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_024_51BC
    ld b, $06
    ld a, e
    add a, $0E
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    dec c
    jr nz, Jump_024_51BC
    xor a, a
    ldh [rSVBK], a
    ret

Data_024_51D3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $24, $01

; 7 call sites from 2 routines (e.g. GameMode6_Init_Sub01, GameMode6_Init_Sub02)
; reads: wC94B
Func_024_51F7::
    ld a, [wC94B]
    and a, a
    jr nz, Jump_024_51FE
    ret

Jump_024_51FE::
    ld l, e
    ld h, d
    ret

; only called from GameMode6_Init (E-0047)
; 1 call site from 1 routine (e.g. GameMode6_Init)
; reads: wD092
; writes: wD7BD
; points at: wD0DF, wD1C9, wD12D, wD217, wD17B, wD265
GameMode6_Init_Sub02::
Func_024_5201:: ; address name
    ld a, [wD092]
    cp a, $08
    jr nz, Jump_024_5222
    ld hl, wD0DF
    ld de, wD1C9
    call Func_024_51F7
    ld a, [hl+]
    ld e, a
    ld d, [hl]
    ld hl, vTiles2 + $200
    ld c, $01
    call LoadMonsterPicture
    ld a, $01
    ld [wD7BD], a
    ret

Jump_024_5222::
    ld hl, wD0DF
    ld de, wD1C9
    call Func_024_51F7
    ld a, [hl+]
    ld e, a
    ld d, [hl]
    ld hl, vTiles2
    ld c, $01
    call LoadMonsterPicture
    ld hl, wD12D
    ld de, wD217
    call Func_024_51F7
    ld a, [hl+]
    ld b, a
    ld a, [hl-]
    or a, b
    and a, a
    jr nz, Jump_024_524C
    ld a, $01
    ld [wD7BD], a
    ret

Jump_024_524C::
    ld a, [hl+]
    ld e, a
    ld d, [hl]
    ld hl, vTiles2 + $240
    ld c, $03
    call LoadMonsterPicture
    ld hl, wD17B
    ld de, wD265
    call Func_024_51F7
    ld a, [hl+]
    ld b, a
    ld a, [hl-]
    or a, b
    and a, a
    jr nz, Jump_024_526D
    ld a, $02
    ld [wD7BD], a
    ret

Jump_024_526D::
    ld a, [hl+]
    ld e, a
    ld d, [hl]
    ld hl, vTiles2 + $480
    ld c, $05
    call LoadMonsterPicture
    ld a, $03
    ld [wD7BD], a
    ret

; only called from GameMode6_Update_Table9_Case00 (E-0047)
; 1 call site from 1 routine (e.g. GameMode6_Update_Table9_Case00)
; reads: wD7AF, wD7AB, hFFC6, hFFC7
; writes: rRAMG2, rRAMB
; points at: wD789
GameMode6_Update_Table9_Case00_Sub02::
Func_024_527E:: ; address name
    ld a, [wD7AF]
    ld b, a
    sla a
    sla a
    add a, b
    ld b, a
    ld a, [wD7AB]
    add a, b
    ld hl, wD789
    add_a_to_hl
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    push hl
    ld a, [hl]
    ld c, $0B
    call LoadSRAMRecordWord
    ldh a, [hFFC6]
    ld e, a
    ldh a, [hFFC7]
    ld d, a
    push de
    ld hl, vTiles2 + $200
    ld c, $01
    call LoadMonsterPicture
    pop de
    pop hl
    xor a, a
    ld [rRAMG2], a
    ret

; Copies 16 bytes from [HL] to [DE]; each byte is written with interrupts off after waiting for rSTAT bit 1 to clear; clobbers A; HL and DE advance (the same 20 bytes appear in 3 banks)
; 1 call site from 1 routine (e.g. GameMode6_Update_Table3_Case0C)
; reads: rSTAT
CopyTileBytesToVRAM_Bank24_52BA::
Func_024_52BA:: ; address name
    xor a, a

Jump_024_52BB::
    push af
    di

Jump_024_52BD::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_024_52BD
    ld a, [hl+]
    ld [de], a
    inc de
    ei
    pop af
    inc a
    cp a, $10
    jr c, Jump_024_52BB
    ret

; HL = table of 16-bit addresses, A = index: stores B at the address in entry A; keeps BC; clobbers A, DE, HL (the same 16 bytes appear in 4 banks)
; 17 call sites from 12 routines (e.g. GameMode6_Update_Table3_Case0A, GameMode6_Update_Table3_Case08, GameMode6_Update_Table5_Case0B, GameMode6_Update_Table5_Case07, ...)
StoreBAtWordTableEntry_Bank24_52CE::
Func_024_52CE:: ; address name
    push bc
    sla a
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    pop bc
    ld a, b
    ld [de], a
    ret

; no direct call (reached through a table, a jump or a vector)
; points at: wCA2B
Func_024_52DE:: ; heuristic: follows a terminator; C0
    ld hl, Data_024_52ED
    ld de, wCA2B
    ld b, $A5

Jump_024_52E6::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_024_52E6
    ret

Data_024_52ED:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $D4, $00, $07, $00, $98
    db $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00, $FF, $FF, $FF, $FF, $98, $98
    db $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00, $98, $98, $98, $F0, $F0, $F0, $F0
    db $F0, $F0, $F0, $00, $16, $1B, $40
    ds $1F, $00
    INCBIN "dwm2-cobi-us.gbc", $091343, $4F

; [HL] = $C5, [HL+2] = $BE, [HL+4] = $C6; HL ends at HL+4; clobbers A (the same 14 bytes appear in 8 banks)
; 3 call sites from 3 routines (e.g. GameMode6_Update_Table7_Case02, GameMode6_Update_Table8_Case01, GameMode6_Update_Table9_Case01)
StoreC5BEC6AtHLStride2_Bank24::
Func_024_5392:: ; address name
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

; 2 call sites from 2 routines (e.g. GameMode6_Update_Table7_Case00, GameMode6_Update_Table8_Case00)
; writes: wC52D, wC52E, wC52F, wC530
Func_024_53A0::
    ld hl, vTiles1 + $3F0
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0401
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ld hl, vTiles1 + $470
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0501
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ld hl, vTiles1 + $500
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0F01
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ld hl, vTiles1 + $6A0
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0401
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ld hl, vTiles1 + $750
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0801
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
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

; only called from GameMode6_Update_Table4_Case01 (E-0047)
; 1 call site from 1 routine (e.g. GameMode6_Update_Table4_Case01)
; reads: wD782
GameMode6_Update_Table4_Case01_Sub01::
Func_024_5434:: ; address name
    ld a, [wD782]
    rst $00
    dw Func_024_5434_Case00
    dw Func_024_5434_Case01
    dw Func_024_5434_Case00
    dw Func_024_5434_Case03
    dw Func_024_5434_Case00
    dw Func_024_5434_Case05
    dw Func_024_5434_Case00
    dw Func_024_5434_Case07
    dw Func_024_5434_Case08
    dw Func_024_5434_Case00
    dw Func_024_5434_Case00
    dw Func_024_5434_Case0B
    dw Func_024_5434_Case0C
    dw Func_024_5434_Case0D

; entry 1 of the `rst $00` table in Func_024_5434
; no direct call (reached through a table, a jump or a vector)
; reads: wCB88, wCBAA, wCB8A, wD782
; writes: wCBAA, wCB8A, wD782
Func_024_5434_Case01::
Jump_024_5454:: ; address name
    ld a, [wCB88]
    and a, $03
    and a, a
    ret z
    ld a, [wCBAA]
    dec a
    ld [wCBAA], a
    ld a, [wCB8A]
    dec a
    ld [wCB8A], a
    cp a, $58
    ret nz
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

; entry 0 of the `rst $00` table in Func_024_5434
; no direct call (reached through a table, a jump or a vector)
; reads: wD783, wD782
; writes: wD783, wD782
Func_024_5434_Case00::
Jump_024_5474:: ; address name
    ld a, [wD783]
    inc a
    ld [wD783], a
    cp a, $10
    ret c
    xor a, a
    ld [wD783], a
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

; entry 3 of the `rst $00` table in Func_024_5434
; no direct call (reached through a table, a jump or a vector)
; reads: wCB98, wCB9A, wD782
; writes: wCB9A, wD782
Func_024_5434_Case03::
Jump_024_548A:: ; address name
    ld a, [wCB98]
    and a, $03
    and a, a
    ret z
    ld a, [wCB9A]
    inc a
    ld [wCB9A], a
    cp a, $38
    ret nz
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

; entry 5 of the `rst $00` table in Func_024_5434
; no direct call (reached through a table, a jump or a vector)
; reads: wCA99, wD782
; writes: wCBCF, wD782
Func_024_5434_Case05::
Jump_024_54A3:: ; address name
    ld a, [wCA99]
    and a, a
    jr z, Jump_024_54AE
    ld a, $80
    ld [wCBCF], a

Jump_024_54AE::
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

; entry 7 of the `rst $00` table in Func_024_5434
; no direct call (reached through a table, a jump or a vector)
; reads: wCA99, wCBA8, wCBAA, wD782
; writes: wCBAA, wCBA6, wD782
Func_024_5434_Case07::
Jump_024_54B6:: ; address name
    ld a, [wCA99]
    and a, a
    jr nz, Jump_024_54D2
    ld a, [wCBA8]
    and a, $03
    and a, a
    ret z
    ld a, [wCBAA]
    dec a
    ld [wCBAA], a
    cp a, $28
    ret nz
    ld a, $01
    ld [wCBA6], a

Jump_024_54D2::
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

; entry 8 of the `rst $00` table in Func_024_5434
; no direct call (reached through a table, a jump or a vector)
; reads: wD782
; writes: wD782
Func_024_5434_Case08::
Jump_024_54DA:: ; address name
    call Func_024_4F12
    ld a, $03
    call Func_024_4EE8
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

; entry 11 of the `rst $00` table in Func_024_5434
; no direct call (reached through a table, a jump or a vector)
; reads: wCB98, wCB9A, wD782
; writes: wCBCF, wCB96, wCB9A, wD782
Func_024_5434_Case0B::
Jump_024_54EA:: ; address name
    xor a, a
    ld [wCBCF], a
    ld a, $03
    ld [wCB96], a
    ld a, [wCB98]
    and a, $03
    and a, a
    ret z
    ld a, [wCB9A]
    dec a
    ld [wCB9A], a
    cp a, $18
    ret nz
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

; entry 12 of the `rst $00` table in Func_024_5434
; no direct call (reached through a table, a jump or a vector)
; reads: wCB98, wCBAA, wCB9A, wD782
; writes: wCBA6, wCBAA, wCB9A, wD782
Func_024_5434_Case0C::
Jump_024_550C:: ; address name
    ld a, $03
    ld [wCBA6], a
    ld a, [wCB98]
    and a, $03
    and a, a
    ret z
    ld a, [wCBAA]
    dec a
    ld [wCBAA], a
    ld a, [wCB9A]
    dec a
    ld [wCB9A], a
    cp a, $D8
    ret nz
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

; entry 13 of the `rst $00` table in Func_024_5434
; no direct call (reached through a table, a jump or a vector)
; reads: wCB88, wCB8A, wD781
; writes: wCB86, wCB8A, wD782, wD781
Func_024_5434_Case0D::
Jump_024_5531:: ; address name
    ld a, $01
    ld [wCB86], a
    ld a, [wCB88]
    and a, $03
    and a, a
    ret z
    ld a, [wCB8A]
    inc a
    ld [wCB8A], a
    cp a, $B0
    ret nz
    xor a, a
    ld [wD782], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; only called from GameMode6_Update_Table3_Case0E (E-0047)
; 1 call site from 1 routine (e.g. GameMode6_Update_Table3_Case0E)
; reads: wD782
GameMode6_Update_Table3_Case0E_Sub01::
Func_024_5553:: ; address name
    ld a, [wD782]
    rst $00
    dw Func_024_5553_Case00
    dw Func_024_5553_Case01
    dw Func_024_5553_Case00
    dw Func_024_5553_Case03
    dw Func_024_5553_Case00
    dw Func_024_5553_Case05
    dw Func_024_5553_Case00
    dw Func_024_5553_Case07
    dw Func_024_5553_Case08
    dw Func_024_5553_Case00
    dw Func_024_5553_Case00
    dw Func_024_5553_Case0B
    dw Func_024_5553_Case0C
    dw Func_024_5553_Case0D

; entry 1 of the `rst $00` table in Func_024_5553
; no direct call (reached through a table, a jump or a vector)
; reads: wCB88, wCB8A, wD782
; writes: wCB8A, wD782
Func_024_5553_Case01::
Jump_024_5573:: ; address name
    ld a, [wCB88]
    and a, $03
    and a, a
    ret z
    ld a, [wCB8A]
    dec a
    ld [wCB8A], a
    cp a, $59
    ret nc
    ld a, $58
    ld [wCB8A], a
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

; entry 3 of the `rst $00` table in Func_024_5553
; no direct call (reached through a table, a jump or a vector)
; reads: wCB98, wCBAA, wCB9A, wD782
; writes: wCBAA, wCB9A, wD782
Func_024_5553_Case03::
Jump_024_5591:: ; address name
    ld a, [wCB98]
    and a, $03
    and a, a
    ret z
    ld a, [wCBAA]
    inc a
    ld [wCBAA], a
    ld a, [wCB9A]
    inc a
    ld [wCB9A], a
    cp a, $38
    ret nz
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

; entry 0 of the `rst $00` table in Func_024_5553
; no direct call (reached through a table, a jump or a vector)
; reads: wD783, wD782
; writes: wD783, wD782
Func_024_5553_Case00::
Jump_024_55B1:: ; address name
    ld a, [wD783]
    inc a
    ld [wD783], a
    cp a, $10
    ret c
    xor a, a
    ld [wD783], a
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

; entry 5 of the `rst $00` table in Func_024_5553
; no direct call (reached through a table, a jump or a vector)
; reads: wCA99, wD782
; writes: wCBCF, wD782
Func_024_5553_Case05::
Jump_024_55C7:: ; address name
    ld a, [wCA99]
    and a, a
    jr z, Jump_024_55D2
    ld a, $80
    ld [wCBCF], a

Jump_024_55D2::
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

; entry 7 of the `rst $00` table in Func_024_5553
; no direct call (reached through a table, a jump or a vector)
; reads: wCA99, wCBA8, wCBAA, wD782
; writes: wCBAA, wCBA6, wD782
Func_024_5553_Case07::
Jump_024_55DA:: ; address name
    ld a, [wCA99]
    and a, a
    jr nz, Jump_024_55FB
    ld a, [wCBA8]
    and a, $03
    and a, a
    ret z
    ld a, [wCBAA]
    inc a
    ld [wCBAA], a
    cp a, $68
    ret c
    ld a, $68
    ld [wCBAA], a
    ld a, $03
    ld [wCBA6], a

Jump_024_55FB::
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

; entry 8 of the `rst $00` table in Func_024_5553
; no direct call (reached through a table, a jump or a vector)
; reads: wD782
; writes: wD782
Func_024_5553_Case08::
Jump_024_5603:: ; address name
    call Func_024_4F0C
    ld a, $04
    call Func_024_4EE8
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

; entry 11 of the `rst $00` table in Func_024_5553
; no direct call (reached through a table, a jump or a vector)
; reads: wCB98, wCB9A, wD782
; writes: wCB96, wCB9A, wD782
Func_024_5553_Case0B::
Jump_024_5613:: ; address name
    ld a, $03
    ld [wCB96], a
    ld a, [wCB98]
    and a, $03
    and a, a
    ret z
    ld a, [wCB9A]
    dec a
    ld [wCB9A], a
    cp a, $E0
    ret nz
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

; entry 12 of the `rst $00` table in Func_024_5553
; no direct call (reached through a table, a jump or a vector)
; reads: wCB88, wCB8A, wD782
; writes: wCBCF, wCB86, wCB8A, wD782
Func_024_5553_Case0C::
Jump_024_5631:: ; address name
    xor a, a
    ld [wCBCF], a
    ld a, $01
    ld [wCB86], a
    ld a, [wCB88]
    and a, $03
    and a, a
    ret z
    ld a, [wCB8A]
    inc a
    ld [wCB8A], a
    cp a, $78
    ret c
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

; entry 13 of the `rst $00` table in Func_024_5553
; no direct call (reached through a table, a jump or a vector)
; reads: wCB88, wCBAA, wCB8A, wD781
; writes: wCBA6, wCBAA, wCB8A, wD782, wD781
Func_024_5553_Case0D::
Jump_024_5653:: ; address name
    ld a, $01
    ld [wCBA6], a
    ld a, [wCB88]
    and a, $03
    and a, a
    ret z
    ld a, [wCBAA]
    inc a
    ld [wCBAA], a
    ld a, [wCB8A]
    inc a
    ld [wCB8A], a
    cp a, $C0
    ret c
    xor a, a
    ld [wD782], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; 4 call sites from 3 routines (e.g. GameMode6_Update, GameMode6_Update_Table3_Case0E, GameMode6_Update_Table4_Case01)
; reads: wCA99
Func_024_567C::
    farcall Func_004_44CE
    ld a, [wCA99]
    and a, a
    ret z
    farcall DrawFieldSprites
    ret

; 2 call sites from 2 routines (e.g. GameMode6_Update_Table3_Case0D, GameMode6_Update_Table4_Case00)
; reads: wCA99, wD092, wCA36, wCA37, wIsCGB, wC991, wC992
; writes: hFFC6, hFFC7, wCBA1, wCBA2, wSpriteSlotCount, wC527, wCBCF, wCBD3, ...
; points at: wSpriteSlots, wCB8F, hFFC6, wCB9F
Func_024_568E::
    ld de, $0000
    call TestFlagBit
    jr c, Jump_024_569B
    ld hl, Data_024_5BE9
    jr Jump_024_569E

Jump_024_569B::
    ld hl, Data_024_5BF9

Jump_024_569E::
    ld de, wSpriteSlots
    ld b, $10
    call CopyBytesDEFromHL_Bank24
    ld hl, Data_024_5C09
    ld de, wCB8F
    ld b, $10
    call CopyBytesDEFromHL_Bank24
    ld de, $0000
    call TestFlagBit
    jr c, Jump_024_56BE
    ld hl, Data_024_5BD1
    jr Jump_024_56C1

Jump_024_56BE::
    ld hl, Data_024_5BD7

Jump_024_56C1::
    ld de, hFFC6
    ld b, $06
    call CopyBytesDEFromHL_Bank24
    farcall Func_004_431F
    ld hl, Data_024_5BDD
    ld de, hFFC6
    ld b, $06
    call CopyBytesDEFromHL_Bank24
    farcall Func_004_431F
    ld a, [wCA99]
    and a, a
    jr nz, Jump_024_5762
    ld hl, Data_024_5BE3
    ld de, hFFC6
    ld b, $06
    call CopyBytesDEFromHL_Bank24
    ld a, [wD092]
    cp a, $08
    jr z, Jump_024_5709
    and a, $01
    and a, a
    jr nz, Jump_024_5709
    ld a, [wCA36]
    ldh [hFFC6], a
    ld a, [wCA37]
    ldh [hFFC7], a
    jr Jump_024_5713

Jump_024_5709::
    ld a, [wC991]
    ldh [hFFC6], a
    ld a, [wC992]
    ldh [hFFC7], a

Jump_024_5713::
    farcall Func_004_431F
    ld a, [wD092]
    cp a, $08
    jr z, Jump_024_572A
    and a, $01
    and a, a
    jr nz, Jump_024_572A
    ld hl, Data_024_5C19
    jr Jump_024_572D

Jump_024_572A::
    ld hl, Data_024_5C29

Jump_024_572D::
    ld de, wCB9F
    ld b, $10
    call CopyBytesDEFromHL_Bank24
    ld a, [wD092]
    cp a, $08
    jr z, Jump_024_574F
    and a, $01
    and a, a
    jr nz, Jump_024_574F
    ld a, [wCA36]
    ld [wCBA1], a
    ld a, [wCA37]
    ld [wCBA2], a
    jr Jump_024_575B

Jump_024_574F::
    ld a, [wC991]
    ld [wCBA1], a
    ld a, [wC992]
    ld [wCBA2], a

Jump_024_575B::
    ld a, $03
    ld [wSpriteSlotCount], a
    jr Jump_024_577F

Jump_024_5762::
    ld a, $0D
    ldh [hFFC6], a
    farcall Func_012_6B98
    xor a, a
    ld [wCBCF], a
    ld a, $48
    ld [wCBD3], a
    ld a, $40
    ld [wCBD4], a
    ld a, $02
    ld [wSpriteSlotCount], a

Jump_024_577F::
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_024_578A
    ld a, $7F
    ld [wC527], a

Jump_024_578A::
    ret

; the same 7 bytes as CopyBytesDEFromHL (34:406E)
; 6 call sites from 1 routine (e.g. Func_024_568E)
CopyBytesDEFromHL_Bank24::
Func_024_578B:: ; address name
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, CopyBytesDEFromHL_Bank24
    ret

Data_024_5792:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $E0, $E1, $E2, $E3, $E4, $E5, $C3, $E6, $E7, $E8, $E9, $EA, $EB, $EC, $ED, $EE
    db $EF, $F0, $F1, $F2, $F3, $F4, $F5, $C3, $F6, $F7, $F8, $F9, $FA, $FB, $FC, $FD
    db $FE, $FF

Data_024_57B4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C3, $C3, $C3, $C3, $C3, $E0, $E1, $E2, $E3, $E4, $E5, $E6, $E7, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $C3, $C3, $F0, $F1, $F2, $F3, $F4, $F5, $F6, $F7, $C3, $C3
    db $C3, $C3

Data_024_57D6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $1C, $07

Data_024_57F2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $01, $02, $03, $04, $05, $C3, $06, $07, $08, $09, $0A, $0B, $0C, $0D, $0E
    db $0F, $10, $11, $12, $13, $14, $15, $C3, $16, $17, $18, $19, $1A, $1B, $1C, $1D
    db $1E, $1F

Data_024_5814:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $B6, $C3

Data_024_58CA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $78, $C3

Data_024_5942:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0
    ds $12, $B1
    db $B2, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B3
    ds $12, $B4
    db $B5

Data_024_59A6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0
    ds $12, $B1
    db $B2, $B6, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8A, $8B, $8C, $8D
    db $8E, $8F, $90, $91, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $92, $93, $94, $95, $96, $97, $98, $99, $9A, $9B, $9C, $9D, $9E, $9F
    db $A0, $A1, $A2, $A3, $B7, $B3
    ds $12, $B4
    db $B5

Data_024_5A0A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $6D, $6E, $6F, $B7, $B6, $C3, $C3, $C3
    db $C3, $B7, $B6, $C3, $70, $71, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B5

Data_024_5A28:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $76, $77, $78, $79, $7A, $7B, $7C, $B7
    db $B2, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B7, $7F, $7F, $C3, $C3, $C3, $C3, $B7
    db $B5, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_024_5A50:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $76, $77, $78, $79
    db $7A, $7B, $7C, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3
    db $7D, $7F, $7F, $C3, $C3, $C3, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4
    db $B4, $B5

Data_024_5A82:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B5, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $76, $77, $78, $79, $7A, $7B, $7C, $B7
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $7D, $7F, $7F, $C3, $C3, $C3, $C3, $B7
    db $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_024_5AAA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $23, $C4, $4B, $C4

Data_024_5AAE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $79, $C3, $A1, $C3, $C9, $C3, $F1, $C3, $19, $C4

Data_024_5AB8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $091AB8, $58

Data_024_5B10:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $091B10, $75

Data_024_5B85:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $091B85, $4C

Data_024_5BD1:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $01, $04, $00, $80

Data_024_5BD7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $00, $01, $01, $00, $80

Data_024_5BDD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0C, $00, $01, $05, $00, $81

Data_024_5BE3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $02, $00, $82

Data_024_5BE9:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $01, $00, $00, $A0, $40, $04, $03, $00, $00, $00, $A0, $40, $04, $00, $00

Data_024_5BF9:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $01, $01, $00, $A0, $40, $01, $03, $00, $00, $00, $A0, $40, $04, $00, $00

Data_024_5C09:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $01, $0C, $00, $E0, $40, $05, $01, $10, $00, $00, $E0, $40, $04, $00, $00

Data_024_5C19:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $D0, $40, $02, $01, $20, $00, $00, $D0, $40, $04, $00, $00

Data_024_5C29:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $B0, $40, $02, $03, $20, $00, $00, $B0, $40, $04, $00, $00

; only called from GameMode6_Update_Table3_Case08 (E-0047)
; 1 call site from 1 routine (e.g. GameMode6_Update_Table3_Case08)
; reads: wJoypadPressedRepeat, wJoypadPressed, wTwoChoiceCursor
; writes: wMenuInputResult, wTwoChoiceCursor, wD783
GameMode6_Update_Table3_Case08_Sub01::
Func_024_5C39:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, Jump_024_5C57
    bit 7, a
    jr nz, Jump_024_5C6D
    ld a, [wJoypadPressed]
    bit 0, a
    jr nz, Jump_024_5C93
    bit 1, a
    jr nz, Jump_024_5CA1
    call GameMode6_Update_Table3_Case08_Sub01_Sub01
    xor a, a
    ld [wMenuInputResult], a
    ret

Jump_024_5C57::
    call GameMode6_Update_Table3_Case08_Sub01_Sub03
    ld a, [wTwoChoiceCursor]
    and a, a
    jr nz, Jump_024_5C67
    ld a, $01
    ld [wTwoChoiceCursor], a
    jr Jump_024_5C81

Jump_024_5C67::
    dec a
    ld [wTwoChoiceCursor], a
    jr Jump_024_5C81

Jump_024_5C6D::
    call GameMode6_Update_Table3_Case08_Sub01_Sub03
    ld a, [wTwoChoiceCursor]
    cp a, $01
    jr c, Jump_024_5C7D
    xor a, a
    ld [wTwoChoiceCursor], a
    jr Jump_024_5C81

Jump_024_5C7D::
    inc a
    ld [wTwoChoiceCursor], a

Jump_024_5C81::
    xor a, a
    ld [wD783], a
    call GameMode6_Update_Table3_Case08_Sub01_Sub02
    ld a, $69
    call QueueSoundEffect
    ld a, $FD
    ld [wMenuInputResult], a
    ret

Jump_024_5C93::
    call GameMode6_Update_Table3_Case08_Sub01_Sub04
    ld a, $69
    call QueueSoundEffect
    ld a, $FF
    ld [wMenuInputResult], a
    ret

Jump_024_5CA1::
    ld a, $FE
    ld [wMenuInputResult], a
    ret

; only called from GameMode6_Update_Table3_Case08_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. GameMode6_Update_Table3_Case08_Sub01)
; reads: wJoypadRepeatTimer, wD783, wTwoChoiceCursor
; writes: wD783
GameMode6_Update_Table3_Case08_Sub01_Sub01::
Func_024_5CA7:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, GameMode6_Update_Table3_Case08_Sub01_Sub02
    ld a, [wD783]
    inc a
    ld [wD783], a
    cp a, $10
    jr c, GameMode6_Update_Table3_Case08_Sub01_Sub02
    cp a, $18
    jr c, GameMode6_Update_Table3_Case08_Sub01_Sub03
    xor a, a
    ld [wD783], a

; only called from GameMode6_Update_Table3_Case08_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. GameMode6_Update_Table3_Case08_Sub01)
; reads: wTwoChoiceCursor
GameMode6_Update_Table3_Case08_Sub01_Sub02::
Func_024_5CC1:: ; address name
    ld b, $BB
    jr Jump_024_5CCB

; only called from GameMode6_Update_Table3_Case08_Sub01 (E-0047)
; 2 call sites from 1 routine (e.g. GameMode6_Update_Table3_Case08_Sub01)
; reads: wTwoChoiceCursor
GameMode6_Update_Table3_Case08_Sub01_Sub03::
Func_024_5CC5:: ; address name
    ld b, $C3
    jr Jump_024_5CCB

; only called from GameMode6_Update_Table3_Case08_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. GameMode6_Update_Table3_Case08_Sub01)
; reads: wTwoChoiceCursor
GameMode6_Update_Table3_Case08_Sub01_Sub04::
Func_024_5CC9:: ; address name
    ld b, $BC

Jump_024_5CCB::
    ld a, [wTwoChoiceCursor]
    add a, a
    ld hl, Data_024_5D0C
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank24_5CEB
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX, hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
; 1 call site from 1 routine (e.g. GameMode6_Update_Table3_Case08_Sub01_Sub04)
; reads: hScrollY, hScrollX
BGMapAddressAtScroll_Bank24_5CEB::
Func_024_5CEB:: ; address name
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

Data_024_5D0C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2B, $01, $6B, $01

; ld de, this bank's string table / BeginStringDisplay
; 2 call sites from 2 routines (e.g. ShowString_Bank24, GameMode0_Update_Table2_Case1B)
BeginStringDisplay_Bank24::
Func_024_5D10:: ; address name
    ld de, Data_024_5D25
    call BeginStringDisplay
    ret
    db $11, $25, $5D, $CD, $FE, $25, $C9

; Func_024_5D10 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
; 1 call site from 1 routine (e.g. ScriptCommandF8_Run_Table2_Case00)
ShowString_Bank24::
Func_024_5D1E:: ; address name
    call BeginStringDisplay_Bank24
    call RunStringDisplayToEnd
    ret

Data_024_5D25:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_024_5D27

Data_024_5D27:: ; heuristic: target of a monotone pointer table; C0
    dw Data_024_5D53
    dw Data_024_5D53
    dw Data_024_5D78
    dw Data_024_5D99
    dw Data_024_5DBC
    dw Data_024_5DDB
    dw Data_024_5DF9
    dw Data_024_5E1D
    dw Data_024_5E3F
    dw Data_024_5E62
    dw Data_024_5E8B
    dw Data_024_5EB2
    dw Data_024_5ED7
    dw Data_024_5F15
    dw Data_024_5F57
    dw Data_024_5F90
    dw Data_024_5FCB
    dw Data_024_5FDD
    dw Data_024_5FFA
    dw Data_024_6019
    dw Data_024_6087
    dw Data_024_60CD

Data_024_5D53:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh? But none", $F1
    db "appear to be dead", $A4, $FA, $F7
    db $F0

Data_024_5D78:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh? But no one", $F1
    db "is poisoned.", $FA, $F7
    db $F0

Data_024_5D99:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " But none appear", $F1
    db "to be cursed", $A4, $FA, $F7
    db $F0

Data_024_5DBC:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Do you need any", $F1
    db "other help?", $F0

Data_024_5DDB:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " May the gods go", $F1
    db "with you.", $F7
    db $F0

Data_024_5DF9:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Which monster", $F1
    db "should be revived?", $F0

Data_024_5E1D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Who should be", $F1
    db "cured of poison?", $F0

Data_024_5E3F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Who should be", $F1
    db "freed of a curse?", $F0

Data_024_5E62:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Surely you jest.", $F1
    db "That one is alive.", $FA, $F7
    db $F0

Data_024_5E8B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " But that monster", $F1
    db "is not poisoned.", $FA, $F7
    db $F0

Data_024_5EB2:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " But that monster", $F1
    db "is not cursed.", $FA, $F7
    db $F0

Data_024_5ED7:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I must ask for a", $F1
    db "small donation of", $FA, $F7
    db $EF, $EE, $F9, "0G.", $EF, $EE, "Do you accept?", $F0

Data_024_5F15:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Gods, the", $F1
    db "spirits of earth!", $FA, $F7
    db $EF, $EE, "Please summon the", $EF, $EE, "soul of ", $F9, "0!", $F7
    db $F0

Data_024_5F57:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Gods, I  beg", $F1
    db "you, purify the", $FA, $F7
    db $EF, $EE, "poison sullying", $EF, $EE, $F9, "0!", $F7
    db $F0

Data_024_5F90:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Gods, I beg", $F1
    db "you, free ", $F9, "0", $FA, $F7
    db $EF, $EE, "from its enslaving", $EF, $EE, "curse!", $F7
    db $F0

Data_024_5FCB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $F9, "0 was revived!", $F7
    db $F0

Data_024_5FDD:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $F9, "0 was cleansed", $F1
    db "of poison.", $F7
    db $F0

Data_024_5FFA:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $F9, "0 was freed", $F1
    db "from the curse.", $F7
    db $F0

Data_024_6019:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "No one else seems", $F1
    db "to need help.", $FA, $F7
    db $EF, $EE, "Come see me again", $EF, $EE, "if you need to.", $FA, $F7
    db $EF, $EE, "The gods will be", $EF, $EE, "with you always.", $F7
    db $F0

Data_024_6087:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh, my, my", $A4, $F1
    db "How deplorable!", $FA, $F7
    db $EF, $EE, "You haven't enough", $EF, $EE, "gold for this.", $FA, $F7
    db $F0

Data_024_60CD:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "RviD-oxUncurt", $F0

; implements script command type F8; reached through ScriptCommandF8 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommandF8)
; reads: wD780
ScriptCommandF8_Run::
Func_024_60DB:: ; address name
    ld a, [wD780]
    rst $00
    dw ScriptCommandF8_Run_Case00
    dw ScriptCommandF8_Run_Case01
    dw ScriptCommandF8_Run_Case02

; entry 0 of the `rst $00` table in ScriptCommandF8_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wD7F0
ScriptCommandF8_Run_Case00::
Jump_024_60E5:: ; address name
    farcall ScriptCommandE8_Run
    ld a, $0B
    ld [wD7F0], a
    ret

; entry 1 of the `rst $00` table in ScriptCommandF8_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
ScriptCommandF8_Run_Case01::
Jump_024_60F1:: ; address name
    ld a, [wD781]
    rst $00
    dw ScriptCommandF8_Run_Table2_Case00
    dw ScriptCommandF8_Run_Table2_Case01
    dw ScriptCommandF8_Run_Table2_Case02

; entry 0 of the `rst $00` table in ScriptCommandF8_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wStringCategory, wStringIndex, wD781
; points at: wC52D
ScriptCommandF8_Run_Table2_Case00::
Jump_024_60FB:: ; address name
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $8F
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld [hl], $0E
    xor a, a
    ld [wStringCategory], a
    ld a, $15
    ld [wStringIndex], a
    farcall ShowString_Bank24
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

; entry 1 of the `rst $00` table in ScriptCommandF8_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
; points at: wC364
ScriptCommandF8_Run_Table2_Case01::
Jump_024_612C:: ; address name
    ld de, Data_024_6B8B
    ld hl, wC364
    ld bc, $0A09
    call CopyRectTo20ByteRows_Bank24
    call Func_024_68B0
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 2 of the `rst $00` table in ScriptCommandF8_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD780
; writes: wD781, wD780
ScriptCommandF8_Run_Table2_Case02::
Jump_024_6143:: ; address name
    call BGMapAddressAtScroll_Bank24_6866
    ld bc, $140B
    ld de, $01CC
    call DrawScreenBufferRectNoOrigin_Bank24
    xor a, a
    ld [wD781], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

; entry 2 of the `rst $00` table in ScriptCommandF8_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
ScriptCommandF8_Run_Case02::
Jump_024_615B:: ; address name
    ld a, [wD781]
    rst $00
    dw ScriptCommandF8_Run_Table3_Case00
    dw ScriptCommandF8_Run_Table3_Case01
    dw ScriptCommandF8_Run_Table3_Case02
    dw ScriptCommandF8_Run_Table3_Case03
    dw ScriptCommandF8_Run_Table3_Case04
    dw ScriptCommandF8_Run_Table3_Case05
    dw ScriptCommandF8_Run_Table3_Case06
    dw ScriptCommandF8_Run_Table3_Case07
    dw ScriptCommandF8_Run_Table3_Case08
    dw ScriptCommandF8_Run_Table3_Case09
    dw ScriptCommandF8_Run_Table3_Case0A
    dw ScriptCommandF8_Run_Table3_Case0B
    dw ScriptCommandF8_Run_Table3_Case0C
    dw ScriptCommandF8_Run_Table3_Case0D
    dw ScriptCommandF8_Run_Table3_Case0C
    dw ScriptCommandF8_Run_Table3_Case0F
    dw ScriptCommandF8_Run_Table3_Case10
    dw ScriptCommandF8_Run_Table3_Case11

; entry 0 of the `rst $00` table in ScriptCommandF8_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wD7AB, wD781
; writes: wMenuInputResult, wD7A9, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wD781, wD7AD
ScriptCommandF8_Run_Table3_Case00::
Jump_024_6183:: ; address name
    xor a, a
    ld [wMenuInputResult], a
    ld a, $04
    ld [wD7A9], a
    farcall Func_01D_65F6
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_024_61A0
    cp a, $FF
    jr z, Jump_024_61AF
    ret

Jump_024_61A0::
    ld a, $04

Jump_024_61A2::
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_024_61AF::
    ld a, [wD7AB]
    and a, a
    jr z, Jump_024_61BF
    cp a, $01
    jr z, Jump_024_61CC
    cp a, $02
    jr z, Jump_024_61D9
    jr Jump_024_61A0

Jump_024_61BF::
    ld b, $80
    call Func_024_6903
    cp a, $FF
    jr z, Jump_024_61E6
    ld a, $01
    jr Jump_024_61A2

Jump_024_61CC::
    ld b, $04
    call Func_024_6903
    cp a, $FF
    jr z, Jump_024_61E6
    ld a, $02
    jr Jump_024_61A2

Jump_024_61D9::
    ld b, $01
    call Func_024_6903
    cp a, $FF
    jr z, Jump_024_61E6
    ld a, $03
    jr Jump_024_61A2

Jump_024_61E6::
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld a, [wD7AB]
    ld b, $BC
    ld hl, Data_024_6C96
    call StoreBAtWordTableEntry_Bank24
    xor a, a
    ld [wD7AD], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 1 of the `rst $00` table in ScriptCommandF8_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD7AB, wD781
; writes: wTwoChoiceCursor, wD781, wScriptCommandType, wScriptStartRequest
ScriptCommandF8_Run_Table3_Case01::
Jump_024_620A:: ; address name
    ld a, [wD7AB]
    ld [wTwoChoiceCursor], a
    ld hl, Data_024_6239
    ld de, vTiles1 + $7E0
    call CopyTileBytesToVRAM_Bank24
    ld hl, Data_024_6249
    call CopyTileBytesToVRAM_Bank24
    ld hl, Data_024_6259
    ld de, vTiles1 + $6F0
    call CopyTileBytesToVRAM_Bank24
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Data_024_6239:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $06, $FF, $06, $FF, $06, $FF, $FF, $FF, $FF, $FF, $00, $FF, $00, $FF, $00

Data_024_6249:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $00, $FF, $00, $FF, $00, $FF, $F8, $FF, $FC, $FF, $0E, $FF, $06, $FF, $06

Data_024_6259:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $60, $FF, $60, $FF, $60, $FF, $1F, $FF, $3F, $FF, $70, $FF, $60, $FF, $60

; entry 2 of the `rst $00` table in ScriptCommandF8_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
; points at: wC3DC
ScriptCommandF8_Run_Table3_Case02::
Jump_024_6269:: ; address name
    ld de, Data_024_6C49
    ld hl, wC3DC
    ld bc, $0B07
    call CopyRectTo20ByteRows_Bank24
    call ScriptCommandF8_Run_Table3_Case02_Sub01
    call BGMapAddressAtScroll_Bank24_6866
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectNoOrigin_Bank24
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 3 of the `rst $00` table in ScriptCommandF8_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wD781
; writes: wD781, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
ScriptCommandF8_Run_Table3_Case03::
Jump_024_628C:: ; address name
    call ScriptCommandF8_Run_Table3_Case03_Sub01
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_024_629D
    cp a, $FF
    jr z, Jump_024_62B3
    ret

Jump_024_629D::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_024_62B3::
    ld a, [wD781]
    add a, $02
    ld [wD781], a
    xor a, a
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 4 of the `rst $00` table in ScriptCommandF8_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD7AB
; writes: wD7F1, wD7F2, wD781, wScriptCommandType, wScriptStartRequest
; points at: wC364
ScriptCommandF8_Run_Table3_Case04::
Jump_024_62C9:: ; address name
    ld b, $00
    ld c, $07
    ld hl, $0244
    ld de, $0078
    xor a, a
    ld [wD7F1], a
    ld a, $0B
    ld [wD7F2], a
    call ScriptCommandF8_Run_Table3_Case04_Sub01
    ld de, Data_024_6B8B
    ld hl, wC364
    ld bc, $0A09
    call CopyRectTo20ByteRows_Bank24
    call Func_024_68B0
    ld a, [wD7AB]
    ld b, $BB
    ld hl, Data_024_6C96
    call StoreBAtWordTableEntry_Bank24
    call BGMapAddressAtScroll_Bank24_6866
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectNoOrigin_Bank24
    ld a, [wD7AB]
    ld b, $C3
    ld hl, Data_024_6C96
    call StoreBAtWordTableEntry_Bank24
    xor a, a
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 5 of the `rst $00` table in ScriptCommandF8_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD7AB, wD7AD, hFFC6, wD781
; writes: rRAMG, rRAMB, wD781, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
; points at: wC6FE
ScriptCommandF8_Run_Table3_Case05::
Jump_024_631E:: ; address name
    ld a, [wD7AB]
    and a, a
    jr z, Jump_024_632C
    cp a, $01
    jr z, Jump_024_6330
    ld b, $01
    jr Jump_024_6332

Jump_024_632C::
    ld b, $80
    jr Jump_024_6332

Jump_024_6330::
    ld b, $04

Jump_024_6332::
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [wD7AD]
    ld hl, wC6FE
    add_a_to_hl
    ld a, [hl]
    ld c, $55
    push bc
    call LoadSRAMRecordByte
    pop bc
    xor a, a
    ld [rRAMG], a
    ld [rRAMB], a
    ldh a, [hFFC6]
    and a, b
    and a, a
    jr nz, Jump_024_6366
    ld a, $01
    ld [wD781], a
    ld a, [wD7AB]
    inc a
    jr Jump_024_636E

Jump_024_6366::
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a

Jump_024_636E::
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 6 of the `rst $00` table in ScriptCommandF8_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD7AB, wD781, wD7AD, hFFC6
; writes: wD789, wD78A, wD78B, wC130, wC131, wC132, wD781, wScriptCommandType, ...
; points at: wC6FE, wD7F4, wC130
ScriptCommandF8_Run_Table3_Case06::
Jump_024_637B:: ; address name
    ld a, [wD7AB]
    and a, a
    jr z, Jump_024_63C9
    cp a, $01
    jr z, Jump_024_63A2
    ld a, $14
    ld [wD789], a
    xor a, a
    ld [wD78A], a
    ld [wD78B], a
    ld a, $02
    ld [wC130], a
    ld a, $00
    ld [wC131], a
    ld a, $F0
    ld [wC132], a
    jr Jump_024_63B8

Jump_024_63A2::
    ld a, $03
    ld [wD789], a
    xor a, a
    ld [wD78A], a
    ld [wD78B], a
    ld a, $03
    ld [wC130], a
    ld a, $F0
    ld [wC131], a

Jump_024_63B8::
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_024_63C9::
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [wD7AD]
    ld hl, wC6FE
    add_a_to_hl
    ld a, [hl]
    ld c, $56
    call LoadSRAMRecordByte
    xor a, a
    ld [rRAMG], a
    ld [rRAMB], a
    ldh a, [hFFC6]
    ld c, $0A
    call Multiply8
    ld a, $0A
    add_a_to_hl
    srl h
    rr l
    ld a, l
    ld [wD789], a
    ld [wC8C0], a
    ld a, h
    ld [wD78A], a
    ld [wC8C1], a
    xor a, a
    ld [wD78B], a
    ld [wC8C2], a
    call Number24ToPackedBCD
    farcall Func_015_6676
    ld hl, wD7F4
    ld de, wC130
    ld b, $04

Jump_024_6422::
    ld a, [hl]
    cp a, $E3
    jr nz, Jump_024_642B
    inc hl
    dec b
    jr nz, Jump_024_6422

Jump_024_642B::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_024_642B
    ld a, $F0
    ld [de], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 7 of the `rst $00` table in ScriptCommandF8_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD7AD, wD781
; writes: wD781, wTwoChoiceCursor
; points at: wC412
ScriptCommandF8_Run_Table3_Case07::
Jump_024_6445:: ; address name
    ld a, $6C
    call QueueSoundEffect
    ld de, Data_024_6479
    ld hl, wC412
    ld bc, $0605
    call CopyRectTo20ByteRows_Bank24
    ld a, [wD7AD]
    ld b, $BC
    ld hl, Data_024_6C9E
    call StoreBAtWordTableEntry_Bank24
    call BGMapAddressAtScroll_Bank24_6866
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectNoOrigin_Bank24
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ret

Data_024_6479:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $CE, $CF, $DF, $B7, $B6, $C3, $C3, $C3
    db $C3, $B7, $B6, $C3, $A5, $F5, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B5

; entry 8 of the `rst $00` table in ScriptCommandF8_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wTwoChoiceCursor, wD78B, wD78A, wD789, wD7F1, wD781
; writes: wD7F3, wD7F2, wD7F1, wTwoChoiceCursor, wD781, wD782, wScriptCommandType, wScriptStartRequest
ScriptCommandF8_Run_Table3_Case08::
Jump_024_6497:: ; address name
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_024_64AB
    cp a, $FF
    jr z, Jump_024_64C8
    ret

Jump_024_64AB::
    call Func_024_6AE4
    xor a, a
    ld [wD782], a
    ld a, $02

Jump_024_64B4::
    ld [wTwoChoiceCursor], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_024_64C8::
    ld a, [wTwoChoiceCursor]
    and a, a
    jr nz, Jump_024_64AB
    ld a, [wD78B]
    ld [wD7F3], a
    ld a, [wD78A]
    ld [wD7F2], a
    ld a, [wD789]
    ld [wD7F1], a
    farcall Func_01C_440F
    ld a, [wD7F1]
    cp a, $FF
    jr z, Jump_024_650A
    call Func_024_6AE4
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wD781]
    add a, $02
    ld [wD781], a
    xor a, a
    ld [wD782], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_024_650A::
    ld a, $01
    ld [wD782], a
    ld a, $01
    jr Jump_024_64B4

; entry 9 of the `rst $00` table in ScriptCommandF8_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD782
; writes: wD781, wScriptCommandType, wScriptStartRequest, wD782
ScriptCommandF8_Run_Table3_Case09::
Jump_024_6513:: ; address name
    call Func_024_6AE4
    ld a, [wD782]
    and a, a
    jr nz, Jump_024_652B
    ld a, $01
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_024_652B::
    ld a, $04
    ld [wD781], a
    xor a, a
    ld [wD782], a
    ret

; entry 10 of the `rst $00` table in ScriptCommandF8_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD782, wD781, wD7AB, wD78A, wD789
; writes: wD781, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wD782, wD7F3, wD7F2, wD7F1
ScriptCommandF8_Run_Table3_Case0A::
Jump_024_6535:: ; address name
    ld a, [wD782]
    and a, a
    jr z, Jump_024_6541
    cp a, $01
    jr z, Jump_024_6571
    jr Jump_024_659A

Jump_024_6541::
    xor a, a
    ld [wD7F3], a
    ld a, [wD78A]
    ld [wD7F2], a
    ld a, [wD789]
    ld [wD7F1], a
    farcall Func_015_683C
    call Func_024_68B0
    call BGMapAddressAtScroll_Bank24_6866
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectNoOrigin_Bank24
    call Func_024_6B3A
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_024_6571::
    ld a, [wD7AB]
    and a, a
    jr z, Jump_024_657F
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_024_657F::
    xor a, a
    ld [wD782], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld a, [wD7AB]
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_024_659A::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld a, [wD7AB]
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 11 of the `rst $00` table in ScriptCommandF8_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD782, wIsCGB, wD781, wD783, wD784
; writes: hFFB9, wD782, wD781, wD783, wD784
; points at: wC364, wScreenTileBuffer, wC300, wC29C, wD1CC, wD000, wD168, wD104
ScriptCommandF8_Run_Table3_Case0B::
Jump_024_65B1:: ; address name
    ld a, [wD782]
    and a, a
    jr z, Jump_024_65BD
    cp a, $01
    jr z, Jump_024_65CA
    jr Jump_024_65F4

Jump_024_65BD::
    ld a, $3D
    call QueueMusic
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_024_65CA::
    ld a, [wD783]
    add a, $01
    ld [wD783], a
    ld a, [wD784]
    adc a, $00
    ld [wD784], a
    ld a, [wD784]
    and a, a
    ret z
    ld a, [wD783]
    cp a, $28
    ret c
    xor a, a
    ld [wD783], a
    ld [wD784], a
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_024_65F4::
    ld hl, wC364
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank24
    ld hl, wC300
    ld de, wC29C
    ld bc, $0064
    call CopyBytesDEToHL_Bank24
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_024_662A
    ld hl, wD1CC
    ld de, wD000
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank24
    ld hl, wD168
    ld de, wD104
    ld bc, $0064
    call CopyLow3BitsToWRAMBank2_Bank24

Jump_024_662A::
    call BGMapAddressAtScroll_Bank24_6866
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectNoOrigin_Bank24
    call BGMapAddressAtScroll_Bank24_6866
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call DrawScreenBufferRectNoOrigin_Bank24
    xor a, a
    ldh [hFFB9], a
    xor a, a
    ld [wD782], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 15 of the `rst $00` table in ScriptCommandF8_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: hFFB9, wD781
; points at: wC52D, wC300
ScriptCommandF8_Run_Table3_Case0F::
Jump_024_6655:: ; address name
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    call FillTilesFromRequest
    ld de, Data_024_6BE5
    ld hl, wC300
    ld bc, $1405
    call CopyRectTo20ByteRows_Bank24
    call BGMapAddressAtScroll_Bank24_6866
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call DrawScreenBufferRectNoOrigin_Bank24
    ld a, $02
    ldh [hFFB9], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 12 of the `rst $00` table in ScriptCommandF8_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD783, wD781
; writes: wD783, wD781
; points at: wD783
ScriptCommandF8_Run_Table3_Case0C::
Jump_024_668D:: ; address name
    ld hl, wD783
    inc [hl]
    ld a, [wD783]
    cp a, $1C
    ret c
    xor a, a
    ld [wD783], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 13 of the `rst $00` table in ScriptCommandF8_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD782
ScriptCommandF8_Run_Table3_Case0D::
Jump_024_66A3:: ; address name
    ld a, [wD782]
    rst $00
    dw ScriptCommandF8_Run_Table4_Case00
    dw ScriptCommandF8_Run_Table4_Case01

; entry 0 of the `rst $00` table in ScriptCommandF8_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wD782
; writes: wD782
; points at: wC49F, wC0F0
ScriptCommandF8_Run_Table4_Case00::
Jump_024_66AB:: ; address name
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_024_66BD
    ld hl, wC49F
    ld de, wC0F0
    ld bc, $0040
    call CopyBytes

Jump_024_66BD::
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

; entry 1 of the `rst $00` table in ScriptCommandF8_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD783, wIsCGB, wD781, wD7AB
; writes: wC526, wD783, wD782, wD781
; points at: wC5E9, wC0F0, wC49F
ScriptCommandF8_Run_Table4_Case01::
Jump_024_66C5:: ; address name
    ld a, [wD783]
    sra a
    sra a
    and a, $01
    jr z, Jump_024_66F0
    ld hl, wC5E9
    ld a, $D2
    ld [hl+], a
    ld a, $D2
    ld [hl+], a
    ld a, $E2
    ld [hl], a
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_024_6717
    ld hl, wC0F0
    ld de, wC49F
    ld bc, $0040
    call CopyBytes
    jr Jump_024_6712

Jump_024_66F0::
    ld hl, wC5E9
    ld a, $2D
    ld [hl+], a
    ld a, $2D
    ld [hl+], a
    ld a, $1D
    ld [hl], a
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_024_6717
    ld b, $40
    ld hl, wC0F0
    ld de, wC49F

Jump_024_670A::
    ld a, [hl+]
    xor a, $FF
    ld [de], a
    inc de
    dec b
    jr nz, Jump_024_670A

Jump_024_6712::
    ld a, $7F
    ld [wC526], a

Jump_024_6717::
    ld a, [wD783]
    inc a
    ld [wD783], a
    cp a, $1E
    ret c
    xor a, a
    ld [wD783], a
    xor a, a
    ld [wD782], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld a, [wD7AB]
    and a, a
    ret nz
    farcall Func_002_604B
    ret

; entry 16 of the `rst $00` table in ScriptCommandF8_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD7AD, wD7AB, wD781
; writes: rRAMG, rRAMB, wD781, wC527, wScriptCommandType, wScriptStartRequest
; points at: wC6FE
ScriptCommandF8_Run_Table3_Case10::
Jump_024_673C:: ; address name
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [wD7AD]
    ld hl, wC6FE
    add_a_to_hl
    push hl
    ld a, [hl]
    ld c, $55
    call SRAMRecordAddress
    ld a, [wD7AB]
    ld de, Data_024_67BD
    add a, e
    ld e, a
    jr nc, Jump_024_6762
    inc d

Jump_024_6762::
    ld a, [de]
    ld b, a
    ld a, [hl]
    and a, b
    ld [hl], a
    pop hl
    ld a, [wD7AB]
    and a, a
    jr nz, Jump_024_6797
    ld a, [hl]
    ld c, $5D
    call SRAMRecordAddress
    ld a, [hl+]
    ld e, a
    ld a, [hl-]
    ld d, a
    dec hl
    dec hl
    ld a, e
    ld [hl+], a
    ld [hl], d
    inc hl
    ld a, $04
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl-]
    ld d, a
    dec hl
    dec hl
    ld a, e
    ld [hl+], a
    ld [hl], d
    farcall Func_002_5E82
    call LoadRecordListNameTiles

Jump_024_6797::
    xor a, a
    ld [rRAMG], a
    ld [rRAMB], a
    call Func_024_6B3A
    ld a, [wD781]
    inc a
    ld [wD781], a
    farcall Func_004_4AA8
    ld a, $7F
    ld [wC527], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Data_024_67BD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $FB, $FE

; entry 17 of the `rst $00` table in ScriptCommandF8_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wD781
ScriptCommandF8_Run_Table3_Case11::
Jump_024_67C0:: ; address name
    ld b, $80
    call Func_024_6903
    cp a, $FF
    jr z, Jump_024_67EA
    ld b, $04
    call Func_024_6903
    cp a, $FF
    jr z, Jump_024_67EA
    ld b, $01
    call Func_024_6903
    cp a, $FF
    jr z, Jump_024_67EA
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_024_67EA::
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, $04
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Copies a rectangle of B bytes by C rows from [DE] to [HL], rows 20 ($14) bytes apart; on CGB it then zero-fills the same-shaped rectangle at HL + $0E68 with rSVBK = 2 and restores rSVBK = 0 (the same 58 bytes appear in 8 banks)
; 6 call sites from 6 routines (e.g. ScriptCommandF8_Run_Table2_Case01, Func_024_68B0, ScriptCommandF8_Run_Table3_Case0F, ScriptCommandF8_Run_Table3_Case07, ...)
; reads: wIsCGB
; writes: rSVBK
CopyRectTo20ByteRows_Bank24::
Func_024_67FD:: ; address name
    push hl
    push bc

Jump_024_67FF::
    push bc
    push hl

Jump_024_6801::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_024_6801
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_024_67FF
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

Jump_024_6823::
    push bc
    push hl

Jump_024_6825::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_024_6825
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_024_6823
    xor a, a
    ldh [rSVBK], a
    ret

; DE = offset into wScreenTileBuffer, B = width, C = rows, HL = BG map address: CopyRectToBGMapWrapped from wScreenTileBuffer + DE; on CGB the same rectangle is then copied from wD000 + DE (rSVBK = 2) into VRAM bank 1, the attributes; on DMG BC, DE and HL are kept. wC554/wC555 are not written (E-0062)
; 9 call sites from 8 routines (e.g. ScriptCommandF8_Run_Table2_Case02, ScriptCommandF8_Run_Table3_Case0F, ScriptCommandF8_Run_Table3_Case0B, ScriptCommandF8_Run_Table3_Case0A, ...)
; reads: wIsCGB
; writes: rVBK, rSVBK
; points at: wScreenTileBuffer, wD000
DrawScreenBufferRectNoOrigin_Bank24::
Func_024_6837:: ; address name
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

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX, hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
; 10 call sites from 9 routines (e.g. ScriptCommandF8_Run_Table2_Case02, ScriptCommandF8_Run_Table3_Case0F, ScriptCommandF8_Run_Table3_Case0B, ScriptCommandF8_Run_Table3_Case0A, ...)
; reads: hScrollY, hScrollX
BGMapAddressAtScroll_Bank24_6866::
Func_024_6866:: ; address name
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

; DE = source, HL = destination, BC = count: copies BC bytes (BC = 0 copies 65536); DE and HL end past the copy; clobbers A, BC = 0 (E-0064) (the same 9 bytes appear in 13 banks)
; 4 call sites from 3 routines (e.g. ScriptCommandF8_Run_Table3_Case0B, Func_024_6B19, ScriptCommandF8_Run_Table3_Case04_Sub01)
CopyBytesDEToHL_Bank24::
Func_024_6887:: ; address name
    ld a, [de]
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, CopyBytesDEToHL_Bank24
    ret

; With rSVBK = 2, copies BC bytes from [DE] to [HL], each ANDed with $07; then rSVBK = 0 (the same 18 bytes appear in 7 banks)
; 3 call sites from 2 routines (e.g. ScriptCommandF8_Run_Table3_Case0B, ScriptCommandF8_Run_Table3_Case04_Sub01)
; writes: rSVBK
CopyLow3BitsToWRAMBank2_Bank24::
Func_024_6890:: ; address name
    ld a, $02
    ldh [rSVBK], a

Jump_024_6894::
    ld a, [de]
    and a, $07
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_024_6894
    xor a, a
    ldh [rSVBK], a
    ret

; HL = table of 16-bit addresses, A = index: stores B at the address in entry A; keeps BC; clobbers A, DE, HL (the same 14 bytes appear in 8 banks)
; 4 call sites from 3 routines (e.g. ScriptCommandF8_Run_Table3_Case07, ScriptCommandF8_Run_Table3_Case04, ScriptCommandF8_Run_Table3_Case00)
StoreBAtWordTableEntry_Bank24::
Func_024_68A2:: ; address name
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

; 3 call sites from 3 routines (e.g. ScriptCommandF8_Run_Table2_Case01, ScriptCommandF8_Run_Table3_Case0A, ScriptCommandF8_Run_Table3_Case04)
; reads: wC617, wC618, wC619
; writes: wC8C0, wC8C1, wC8C2
; points at: wC370, wC386, wD7F3
Func_024_68B0::
    ld de, Data_024_68EB
    ld hl, wC370
    ld bc, $0803
    call CopyRectTo20ByteRows_Bank24
    ld a, [wC617]
    ld [wC8C0], a
    ld a, [wC618]
    ld [wC8C1], a
    ld a, [wC619]
    ld [wC8C2], a
    call Number24ToPackedBCD
    farcall Func_015_6676
    ld hl, wC386
    ld de, wD7F3
    ld c, $00

Jump_024_68DF::
    ld a, [de]
    add a, $E0
    ld [hl+], a
    inc de
    inc c
    ld a, c
    cp a, $05
    jr c, Jump_024_68DF
    ret

Data_024_68EB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $BF, $C3, $C3, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; 6 call sites from 2 routines (e.g. ScriptCommandF8_Run_Table3_Case11, ScriptCommandF8_Run_Table3_Case00)
; reads: wC6FD, hFFC6
; writes: rRAMG, rRAMB
; points at: wC6FE
Func_024_6903::
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [wC6FD]
    ld c, a
    ld hl, wC6FE
    ld e, $00

Jump_024_6915::
    push de
    push hl
    push bc
    ld a, [hl]
    ld c, $55
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    pop bc
    push bc
    and a, b
    and a, a
    jr nz, Jump_024_6937
    pop bc
    pop hl
    pop de
    inc hl
    inc e
    ld a, e
    cp a, c
    jr c, Jump_024_6915
    xor a, a
    ld [rRAMG], a
    ld [rRAMB], a
    ret

Jump_024_6937::
    pop bc
    pop hl
    pop de
    xor a, a
    ld [rRAMG], a
    ld [rRAMB], a
    ld a, $FF
    ret

; only called from ScriptCommandF8_Run_Table3_Case02 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandF8_Run_Table3_Case02)
; reads: wC6FD, hFFC6
; writes: rRAMG, rRAMB
; points at: wC6FE
ScriptCommandF8_Run_Table3_Case02_Sub01::
Func_024_6944:: ; address name
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [wC6FD]
    ld c, a
    ld e, $00
    ld hl, wC6FE

Jump_024_6956::
    push hl
    push bc
    push de
    ld a, [hl]
    ld c, $55
    call LoadSRAMRecordByte
    pop de
    push de
    ldh a, [hFFC6]
    bit 0, a
    call nz, ScriptCommandF8_Run_Table3_Case02_Sub01_Sub01
    ldh a, [hFFC6]
    bit 2, a
    call nz, ScriptCommandF8_Run_Table3_Case02_Sub01_Sub02
    ldh a, [hFFC6]
    bit 7, a
    call nz, ScriptCommandF8_Run_Table3_Case02_Sub01_Sub03
    pop de
    pop bc
    pop hl
    inc hl
    inc e
    ld a, e
    cp a, c
    jr c, Jump_024_6956
    xor a, a
    ld [rRAMG], a
    ld [rRAMB], a
    ret

; only called from ScriptCommandF8_Run_Table3_Case02_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandF8_Run_Table3_Case02_Sub01)
ScriptCommandF8_Run_Table3_Case02_Sub01_Sub01::
Func_024_6987:: ; address name
    push de
    ld a, e
    add a, a
    ld hl, Data_024_69C0
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, $C0
    ld [de], a
    pop de
    ret

; only called from ScriptCommandF8_Run_Table3_Case02_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandF8_Run_Table3_Case02_Sub01)
ScriptCommandF8_Run_Table3_Case02_Sub01_Sub02::
Func_024_699A:: ; address name
    push de
    ld a, e
    add a, a
    ld hl, Data_024_69C6
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, $C1
    ld [de], a
    pop de
    ret

; only called from ScriptCommandF8_Run_Table3_Case02_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandF8_Run_Table3_Case02_Sub01)
ScriptCommandF8_Run_Table3_Case02_Sub01_Sub03::
Func_024_69AD:: ; address name
    push de
    ld a, e
    add a, a
    ld hl, Data_024_69CC
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, $C2
    ld [de], a
    pop de
    ret

Data_024_69C0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $F7, $C3, $1F, $C4, $47, $C4

Data_024_69C6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $F8, $C3, $20, $C4, $48, $C4

Data_024_69CC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $F9, $C3, $21, $C4, $49, $C4

; only called from ScriptCommandF8_Run_Table3_Case03 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandF8_Run_Table3_Case03)
; reads: wJoypadPressedRepeat, wJoypadPressed, wC6FD, wD7AD
; writes: wMenuInputResult, wD7AD, wD7AE
ScriptCommandF8_Run_Table3_Case03_Sub01::
Func_024_69D2:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, Jump_024_69F0
    bit 7, a
    jr nz, Jump_024_6A08
    ld a, [wJoypadPressed]
    bit 0, a
    jr nz, Jump_024_6A32
    bit 1, a
    jr nz, Jump_024_6A40
    call ScriptCommandF8_Run_Table3_Case03_Sub01_Sub01
    xor a, a
    ld [wMenuInputResult], a
    ret

Jump_024_69F0::
    call ScriptCommandF8_Run_Table3_Case03_Sub01_Sub03
    ld a, [wD7AD]
    and a, a
    jr nz, Jump_024_6A02
    ld a, [wC6FD]
    dec a
    ld [wD7AD], a
    jr Jump_024_6A20

Jump_024_6A02::
    dec a
    ld [wD7AD], a
    jr Jump_024_6A20

Jump_024_6A08::
    call ScriptCommandF8_Run_Table3_Case03_Sub01_Sub03
    ld a, [wC6FD]
    dec a
    ld b, a
    ld a, [wD7AD]
    cp a, b
    jr c, Jump_024_6A1C
    xor a, a
    ld [wD7AD], a
    jr Jump_024_6A20

Jump_024_6A1C::
    inc a
    ld [wD7AD], a

Jump_024_6A20::
    xor a, a
    ld [wD7AE], a
    call ScriptCommandF8_Run_Table3_Case03_Sub01_Sub02
    ld a, $69
    call QueueSoundEffect
    ld a, $FD
    ld [wMenuInputResult], a
    ret

Jump_024_6A32::
    ld a, $69
    call QueueSoundEffect
    call ScriptCommandF8_Run_Table3_Case03_Sub01_Sub04
    ld a, $FF
    ld [wMenuInputResult], a
    ret

Jump_024_6A40::
    ld a, $FE
    ld [wMenuInputResult], a
    ret

; only called from ScriptCommandF8_Run_Table3_Case03_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandF8_Run_Table3_Case03_Sub01)
; reads: wJoypadRepeatTimer, wD7AE, wD7AD
; writes: wD7AE
ScriptCommandF8_Run_Table3_Case03_Sub01_Sub01::
Func_024_6A46:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, ScriptCommandF8_Run_Table3_Case03_Sub01_Sub02
    ld a, [wD7AE]
    inc a
    ld [wD7AE], a
    cp a, $10
    jr c, ScriptCommandF8_Run_Table3_Case03_Sub01_Sub02
    cp a, $18
    jr c, ScriptCommandF8_Run_Table3_Case03_Sub01_Sub03
    xor a, a
    ld [wD7AE], a

; only called from ScriptCommandF8_Run_Table3_Case03_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandF8_Run_Table3_Case03_Sub01)
; reads: wD7AD
ScriptCommandF8_Run_Table3_Case03_Sub01_Sub02::
Func_024_6A60:: ; address name
    ld b, $BB
    jr Jump_024_6A6A

; only called from ScriptCommandF8_Run_Table3_Case03_Sub01 (E-0047)
; 2 call sites from 1 routine (e.g. ScriptCommandF8_Run_Table3_Case03_Sub01)
; reads: wD7AD
ScriptCommandF8_Run_Table3_Case03_Sub01_Sub03::
Func_024_6A64:: ; address name
    ld b, $C3
    jr Jump_024_6A6A

; only called from ScriptCommandF8_Run_Table3_Case03_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandF8_Run_Table3_Case03_Sub01)
; reads: wD7AD
ScriptCommandF8_Run_Table3_Case03_Sub01_Sub04::
Func_024_6A68:: ; address name
    ld b, $BC

Jump_024_6A6A::
    ld a, [wD7AD]
    add a, a
    ld hl, Data_024_6A8A
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank24_6866
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

Data_024_6A8A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $E1, $00, $21, $01, $61, $01

; only called from ScriptCommandF8_Run_Table3_Case04 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandF8_Run_Table3_Case04)
; reads: wD7F1, wD7F2, wIsCGB
; points at: wScreenTileBuffer, wD000
ScriptCommandF8_Run_Table3_Case04_Sub01::
Func_024_6A90:: ; address name
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
    call CopyBytesDEToHL_Bank24
    pop de
    pop hl
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_024_6AD1
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
    call CopyLow3BitsToWRAMBank2_Bank24
    pop de
    pop hl

Jump_024_6AD1::
    pop bc
    ld a, $14
    add_a_to_hl
    ld a, $14
    add a, e
    ld e, a
    jr nc, Jump_024_6AE0
    inc d

Jump_024_6AE0::
    dec c
    jr nz, ScriptCommandF8_Run_Table3_Case04_Sub01
    ret

; 3 call sites from 2 routines (e.g. ScriptCommandF8_Run_Table3_Case09, ScriptCommandF8_Run_Table3_Case08)
; reads: wIsCGB, rSVBK
; writes: rSVBK
; points at: wC412, wC246, wD27A, wD0AE
Func_024_6AE4::
    ld hl, wC412
    ld de, wC246
    ld c, $00
    call Func_024_6B19
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_024_6B0C
    ldh a, [rSVBK]
    set 1, a
    ldh [rSVBK], a
    ld hl, wD27A
    ld de, wD0AE
    ld c, $00
    call Func_024_6B19
    ldh a, [rSVBK]
    res 1, a
    ldh [rSVBK], a

Jump_024_6B0C::
    call BGMapAddressAtScroll_Bank24_6866
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectNoOrigin_Bank24
    ret

; 2 call sites from 1 routine (e.g. Func_024_6AE4)
Func_024_6B19::
    push hl
    push de
    push bc
    ld bc, $0006
    call CopyBytesDEToHL_Bank24
    pop bc
    pop de
    pop hl
    ld a, $14
    add_a_to_hl
    ld a, $14
    add a, e
    ld e, a
    jr nc, Jump_024_6B33
    inc d

Jump_024_6B33::
    inc c
    ld a, c
    cp a, $05
    jr c, Func_024_6B19
    ret

; 2 call sites from 2 routines (e.g. ScriptCommandF8_Run_Table3_Case10, ScriptCommandF8_Run_Table3_Case0A)
; reads: wD7AD
; writes: rRAMG, rRAMB, wC8D9
; points at: wC6FE, wC8CF, wC130
Func_024_6B3A::
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [wD7AD]
    ld hl, wC6FE
    add_a_to_hl
    ld a, [hl]
    ld c, $01
    call CopyRecordNameToWC8CF
    ld a, $F0
    ld [wC8D9], a
    xor a, a
    ld [rRAMG], a
    ld [rRAMB], a
    ld hl, wC8CF
    ld de, wC130
    ld c, $00

Jump_024_6B68::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_024_6B76
    ld [de], a
    inc hl
    inc de
    inc c
    ld a, c
    cp a, $0A
    jr c, Jump_024_6B68

Jump_024_6B76::
    ld a, $F0
    ld [de], a
    ret

; Copies 16 bytes from [HL] to [DE]; each byte is written with interrupts off after waiting for rSTAT bit 1 to clear; clobbers A, C; HL and DE advance (the same 17 bytes appear in 7 banks)
; 3 call sites from 1 routine (e.g. ScriptCommandF8_Run_Table3_Case01)
; reads: rSTAT
CopyTileBytesToVRAM_Bank24::
Func_024_6B7A:: ; address name
    ld c, $10

Jump_024_6B7C::
    di

Jump_024_6B7D::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_024_6B7D
    ld a, [hl+]
    ld [de], a
    inc de
    ei
    dec c
    jr nz, Jump_024_6B7C
    ret

Data_024_6B8B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $092B8B, $5A

Data_024_6BE5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0
    ds $12, $B1
    db $B2, $B6, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8A, $8B, $8C, $8D
    db $8E, $8F, $90, $91, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $92, $93, $94, $95, $96, $97, $98, $99, $9A, $9B, $9C, $9D, $9E, $9F
    db $A0, $A1, $A2, $A3, $B7, $B3
    ds $12, $B4
    db $B5

Data_024_6C49:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $092C49, $4D

Data_024_6C96:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $79, $C3, $A1, $C3, $C9, $C3, $F1, $C3

Data_024_6C9E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $F1, $C3, $19, $C4, $41, $C4

Data_024_6CA4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $38, $00
    db $1F, $00, $FF, $7F, $00, $7E, $00, $00

; LZSS-compressed asset: 303 bytes expand to 512 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_024_6CE4:: ; heuristic: stream decompressed while the game ran on the emulator; C0
    INCBIN "dwm2-cobi-us.gbc", $092CE4, $12F

; LZSS-compressed asset: 315 bytes expand to 512 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_024_6E13:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $092E13, $13B

Data_024_6F4E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $092F4E, $F7

; 1 call site from 1 routine (e.g. Func_01C_6AF7_Case02)
; reads: wD7C9, wD780, wD7B6, wD7B5, wD7C4, wD7C3, wD7B8, wD7C6, ...
; writes: wD7B8, wD7C4, wD7C3, wD7C5, wD7C6, wD7C2
; points at: wD7D5
Func_024_7045::
    ld a, [wD7C9]
    and a, a
    jr nz, Jump_024_704B

Jump_024_704B::
    ld a, [wD780]
    cp a, $04
    jr nz, Jump_024_7057
    ld hl, wD7D5
    jr Jump_024_7062

Jump_024_7057::
    farcall Func_01C_68FA
    ld a, [wD7F1]
    jr Jump_024_707A

Jump_024_7062::
    ld a, [wD7B6]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, [wD7B5]
    add_a_to_hl
    ld a, [hl]

Jump_024_707A::
    ld e, a
    ld d, $00
    sla e
    rl d
    ld hl, Data_024_7158
    add hl, de
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    ld a, [wD7C4]
    ld e, a
    ld a, [wD7C3]
    ld d, a
    add hl, de
    ld a, [hl]
    cp a, $F0
    jp z, Jump_024_7124
    cp a, $F1
    jp z, Jump_024_7139
    ld [wD7B8], a
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
    ld a, [wD7B8]
    cp a, $8D
    jr z, Jump_024_70BF
    cp a, $8E
    jr z, Jump_024_70BF
    jr Jump_024_70D5

Jump_024_70BF::
    ld a, [wD7C6]
    ld e, a
    ld a, [wD7C5]
    ld d, a
    ld a, e
    sub a, $10
    ld e, a
    ld a, d
    sbc a, $00
    ld [wD7C5], a
    ld a, e
    ld [wD7C6], a

Jump_024_70D5::
    ld a, [wD7C6]
    ld e, a
    ld a, [wD7C5]
    ld d, a
    ld hl, vTiles1
    add hl, de
    pop de
    ld b, $1F
    ld c, $10
    ld a, [wD7B8]
    cp a, $8D
    jr z, Jump_024_70F6
    cp a, $8E
    jr z, Jump_024_70F6
    call CopyFromBankWaitVRAM
    jr Jump_024_70F9

Jump_024_70F6::
    call OrFromBankWaitVRAM

Jump_024_70F9::
    pop hl
    ld a, [wD7C3]
    ld d, a
    ld a, [wD7C4]
    add a, $01
    ld [wD7C4], a
    ld a, d
    adc a, $00
    ld [wD7C3], a
    ld a, [wD7C5]
    ld d, a
    ld a, [wD7C6]
    ld e, a
    add a, $10
    ld e, a
    ld a, d
    adc a, $00
    ld [wD7C5], a
    ld a, e
    ld [wD7C6], a
    jp Func_024_7045

Jump_024_7124::
    xor a, a
    ld [wD7C3], a
    ld [wD7C4], a
    ld [wD7C5], a
    ld [wD7C6], a
    ld a, [wD7C2]
    inc a
    ld [wD7C2], a
    ret

Jump_024_7139::
    ld a, [wD7C3]
    ld d, a
    ld a, [wD7C4]
    add a, $01
    ld [wD7C4], a
    ld a, d
    adc a, $00
    ld [wD7C3], a
    ld a, $01
    ld [wD7C5], a
    ld a, $20
    ld [wD7C6], a
    jp Func_024_7045

Data_024_7158:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_024_721E
    dw Data_024_721E
    dw Data_024_7243
    dw Data_024_7268
    dw Data_024_728B
    dw Data_024_72B0
    dw Data_024_72D2
    dw Data_024_72F0
    dw Data_024_7301
    dw Data_024_7320
    dw Data_024_733C
    dw Data_024_735E
    dw Data_024_7384
    dw Data_024_739C
    dw Data_024_73AD
    dw Data_024_73BE
    dw Data_024_73CF
    dw Data_024_73E0
    dw Data_024_73F5
    dw Data_024_740A
    dw Data_024_7423
    dw Data_024_7443
    dw Data_024_7461
    dw Data_024_747C
    dw Data_024_749E
    dw Data_024_74BE
    dw Data_024_74DC
    dw Data_024_74F9
    dw Data_024_750F
    dw Data_024_7529
    dw Data_024_754D
    dw Data_024_7568
    dw Data_024_758D
    dw Data_024_75AF
    dw Data_024_75D0
    dw Data_024_75EC
    dw Data_024_760B
    dw Data_024_762E
    dw Data_024_764F
    dw Data_024_7671
    dw Data_024_7692
    dw Data_024_76B6
    dw Data_024_76D3
    dw Data_024_76F0
    dw Data_024_770F
    dw Data_024_7731
    dw Data_024_7755
    dw Data_024_776C
    dw Data_024_776C
    dw Data_024_7781
    dw Data_024_77A5
    dw Data_024_77C8
    dw Data_024_77E5
    dw Data_024_7807
    dw Data_024_7827
    dw Data_024_784C
    dw Data_024_7867
    dw Data_024_7883
    dw Data_024_78A7
    dw Data_024_78CB
    dw Data_024_78F0
    dw Data_024_7911
    dw Data_024_7928
    dw Data_024_7928
    dw Data_024_7933
    dw Data_024_7949
    dw Data_024_795F
    dw Data_024_7975
    dw Data_024_798B
    dw Data_024_799D
    dw Data_024_79AF
    dw Data_024_79C1
    dw Data_024_79D3
    dw Data_024_79E5
    dw Data_024_79F7
    dw Data_024_7A09
    dw Data_024_7A1C
    dw Data_024_7A40
    dw Data_024_7A63
    dw Data_024_7A86
    dw Data_024_7AA2
    dw Data_024_7AC4
    dw Data_024_7AE7
    dw Data_024_7B0A
    dw Data_024_7B1B
    dw Data_024_7B1B
    dw Data_024_7B1B
    dw Data_024_7B1B
    dw Data_024_7B1B
    dw Data_024_7B1B
    dw Data_024_7B26
    dw Data_024_7B46
    dw Data_024_7B66
    dw Data_024_7B7D
    dw Data_024_7B94
    dw Data_024_7BB5
    dw Data_024_7BD6
    dw Data_024_7BF7
    dw Data_024_7C18

Data_024_721E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Restores HP of one", $F1
    db "monster by "
    db $03, $00, $9D, $04, $00, $B5, $F0

Data_024_7243:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Restores HP of one", $F1
    db "monster by "
    db $06, $00, $9D, $07, $00, $B5, $F0

Data_024_7268:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Fully restores HP", $F1
    db "of all monsters.", $F0

Data_024_728B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Restores MP of one", $F1
    db "monster by "
    db $02, $00, $9D, $03, $00, $B5, $F0

Data_024_72B0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Fully restores MP", $F1
    db "of one monster.", $F0

Data_024_72D2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Removes all traces", $F1
    db "of poison.", $F0

Data_024_72F0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Cures paralysis.", $F0

Data_024_7301:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lifts a curse off", $F1
    db "one monster.", $F0

Data_024_7320:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Awakens a sleeping", $F1
    db "monster.", $F0

Data_024_733C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Snaps a monster", $F1
    db "out of confusion.", $F0

Data_024_735E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Restores HP of all", $F1
    db "monsters by "
    db $06, $00, $9D, $07, $00, $B5, $F0

Data_024_7384:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Revives a dead", $F1
    db "monster.", $F0

Data_024_739C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises ATK by 3.", $F0

Data_024_73AD:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises DEF by 3.", $F0

Data_024_73BE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises AGL by 3.", $F0

Data_024_73CF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises INT by 3.", $F0

Data_024_73E0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises max. HP", $F1
    db "by 5.", $F0

Data_024_73F5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises max. MP", $F1
    db "by 5.", $F0

Data_024_740A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Makes the reader", $F1
    db "braver.", $F0

Data_024_7423:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Makes the reader", $F1
    db "more cowardly.", $F0

Data_024_7443:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Makes the reader", $F1
    db "more kindly.", $F0

Data_024_7461:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Makes the reader", $F1
    db "more sly.", $F0

Data_024_747C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Makes the reader", $F1
    db "more thoughtful.", $F0

Data_024_749E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Makes the reader", $F1
    db "simple-minded.", $F0

Data_024_74BE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tames monsters", $F1
    db "just a little.", $F0

Data_024_74DC:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tames monsters a", $F1
    db "little bit.", $F0

Data_024_74F9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tames monsters a", $F1
    db "lot.", $F0

Data_024_750F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tames monsters", $F1
    db "very much.", $F0

Data_024_7529:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tames a tiny bit,", $F1
    db "but also poisons.", $F0

Data_024_754D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tames monsters", $F1
    db "incredibly.", $F0

Data_024_7568:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Checks if monster", $F1
    db "was caught before.", $F0

Data_024_758D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Prevents monsters", $F1
    db "from appearing.", $F0

Data_024_75AF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Attracts monsters", $F1
    db "when strummed.", $F0

Data_024_75D0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Prevents casting", $F1
    db "of spells.", $F0

Data_024_75EC:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Doubles physical", $F1
    db "power of one.", $F0

Data_024_760B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hits all enemies", $F1
    db "with a windstorm.", $F0

Data_024_762E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hits all enemies", $F1
    db "with lightning.", $F0

Data_024_764F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hits all enemies", $F1
    db "with a blizzard.", $F0

Data_024_7671:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hits one target", $F1
    db "with a fireball.", $F0

Data_024_7692:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Instantly warps to", $F1
    db "the Door Shrine.", $F0

Data_024_76B6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Instantly warps to", $F1
    db "GreatLog.", $F0

Data_024_76D3:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Instantly warps to", $F1
    db "the exit.", $F0

Data_024_76F0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Enables saving in", $F1
    db "the Journal.", $F0

Data_024_770F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Collect and trade", $F1
    db "for rare gifts.", $F0

Data_024_7731:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Get a 10-percent", $F1
    db "discount at shops.", $F0

Data_024_7755:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Moves the Door", $F1
    db "Shrine.", $F0

Data_024_776C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Reveals Mirage", $F1
    db "Lake.", $F0

Data_024_7781:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A magic stone that", $F1
    db "raises the tide.", $F0

Data_024_77A5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A medal from the", $F1
    db "elemental spirit.", $F0

Data_024_77C8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The lost soul of a", $F1
    db "princess.", $F0

Data_024_77E5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A blue flower that", $F1
    db "grows in snow.", $F0

Data_024_7807:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Transforms users", $F1
    db "into monsters.", $F0

Data_024_7827:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Summons a clam for", $F1
    db "crossing the sea.", $F0

Data_024_784C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Destroys what it", $F1
    db "reflects.", $F0

Data_024_7867:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Summons a cloud", $F1
    db "for flying.", $F0

Data_024_7883:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A legendary helmet", $F1
    db "found in a cave.", $F0

Data_024_78A7:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A legendary armor", $F1
    db "found in a tower.", $F0

Data_024_78CB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A legendary sword", $F1
    db "found in a castle.", $F0

Data_024_78F0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A magical stone", $F1
    db "that glows blue.", $F0

Data_024_7911:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A beautiful gold", $F1
    db "ring.", $F0

Data_024_7928:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Undefined.", $F0

Data_024_7933:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises max. HP", $F1
    db "by 30.", $F0

Data_024_7949:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises max. HP", $F1
    db "by 80.", $F0

Data_024_795F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises max. MP", $F1
    db "by 30.", $F0

Data_024_7975:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises max. MP", $F1
    db "by 80.", $F0

Data_024_798B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises ATK by 10.", $F0

Data_024_799D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises ATK by 50.", $F0

Data_024_79AF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises DEF by 10.", $F0

Data_024_79C1:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises DEF by 50.", $F0

Data_024_79D3:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises AGL by 10.", $F0

Data_024_79E5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises AGL by 50.", $F0

Data_024_79F7:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises INT by 50.", $F0

Data_024_7A09:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises INT by 100.", $F0

Data_024_7A1C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises resistance", $F1
    db "to attack spells.", $F0

Data_024_7A40:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises resistance", $F1
    db "to fire and ice.", $F0

Data_024_7A63:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Resists confusion,", $F1
    db "poison "
    db $B6
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " sleep.", $F0

Data_024_7A86:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Resists most", $F1
    db "status skills.", $F0

Data_024_7AA2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Resists curse,", $F1
    db "paralysis "
    db $B6
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " death.", $F0

Data_024_7AC4:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises resistance", $F1
    db "to water skills.", $F0

Data_024_7AE7:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Prevents skills", $F1
    db "from being sealed.", $F0

Data_024_7B0A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises DEF by 5.", $F0

Data_024_7B1B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Undefined.", $F0

Data_024_7B26:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Restores HP by 1", $F1
    db "on every step.", $F0

Data_024_7B46:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Restores MP by 1", $F1
    db "on every step.", $F0

Data_024_7B66:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Promotes max. HP", $F1
    db "gain.", $F0

Data_024_7B7D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Promotes max.", $F1
    db "MP gain.", $F0

Data_024_7B94:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Promotes ATK gain", $F1
    db "while growing.", $F0

Data_024_7BB5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Promotes DEF gain", $F1
    db "while growing.", $F0

Data_024_7BD6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Promotes AGL gain", $F1
    db "while growing.", $F0

Data_024_7BF7:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Promotes INT gain", $F1
    db "while growing.", $F0

Data_024_7C18:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Undefined.", $F0
    ds $3DD, $00
