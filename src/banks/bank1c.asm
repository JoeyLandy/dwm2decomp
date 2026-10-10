SECTION "Bank 1C", ROMX[$4000], BANK[$1C]
    db $1C

; implements script command type E1; reached through ScriptCommandE1 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommandE1)
; reads: wIsCGB
; writes: wD7F0, wD780, wC46B, wC56D, wScriptCommandType, wScriptStartRequest
; points at: wScreenTileBuffer, wC3A0, wD000, wD208, wC300, wD168, wD780
ScriptCommandE1_Run::
Func_01C_4001:: ; address name
    ld hl, wScreenTileBuffer
    ld de, wC3A0
    ld bc, $00A0
    call CopyBytesDEToHL_Bank1C
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_01C_401F
    ld hl, wD000
    ld de, wD208
    ld bc, $00A0
    call CopyLow3BitsToWRAMBank2_Bank1C

Jump_01C_401F::
    ld hl, wC300
    ld de, wC3A0
    ld bc, $00A0
    call CopyBytesDEToHL_Bank1C
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_01C_403D
    ld hl, wD168
    ld de, wD208
    ld bc, $00A0
    call CopyLow3BitsToWRAMBank2_Bank1C

Jump_01C_403D::
    call BGMapAddressAtScroll_Bank1C
    ld bc, $1408
    ld de, $0168
    call Func_01C_449F
    ld bc, $001A
    ld hl, wD780

Jump_01C_404F::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_01C_404F
    farcall Func_002_470B
    xor a, a
    ld [wD7F0], a
    ld [wD780], a
    ld [wC46B], a
    ld a, $07
    ld [wC56D], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type E0; reached through ScriptCommandE0 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommandE0)
; reads: wD780
ScriptCommandE0_Run::
Func_01C_4075:: ; address name
    ld a, [wD780]
    rst $00
    dw ScriptCommandE0_Run_Case00
    dw ScriptCommandE0_Run_Case01
    dw ScriptCommandE0_Run_Case02
    dw ScriptCommandE0_Run_Case03
    dw ScriptCommandE0_Run_Case04
    dw ScriptCommandE0_Run_Case05
    dw ScriptCommandE0_Run_Case06
    dw ScriptCommandE0_Run_Case07
    dw ScriptCommandE0_Run_Case08

; entry 0 of the `rst $00` table in ScriptCommandE0_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: wD7F0, wScriptCommandType, wScriptStartRequest
; points at: wD780, wC300, wScreenTileBuffer, wD168, wD000, wC3A0, wD208
ScriptCommandE0_Run_Case00::
Jump_01C_408B:: ; address name
    ld bc, $001A
    ld hl, wD780

Jump_01C_4091::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_01C_4091
    ld hl, wC300
    ld de, wScreenTileBuffer
    ld bc, $00A0
    call CopyBytesDEToHL_Bank1C
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_01C_40B6
    ld hl, wD168
    ld de, wD000
    ld bc, $00A0
    call CopyLow3BitsToWRAMBank2_Bank1C

Jump_01C_40B6::
    ld hl, wC3A0
    ld de, wScreenTileBuffer
    ld bc, $00A0
    call CopyBytesDEToHL_Bank1C
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_01C_40D4
    ld hl, wD208
    ld de, wD000
    ld bc, $00A0
    call CopyLow3BitsToWRAMBank2_Bank1C

Jump_01C_40D4::
    call ScriptCommandE0_Run_Case00_Sub01
    ld a, $01
    ld [wD7F0], a
    ld hl, wD780
    inc [hl]
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 1 of the `rst $00` table in ScriptCommandE0_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC8CB
; writes: wC46B, wScriptCommandType, wScriptStartRequest
; points at: wD782, wD78C, wC30C, wC1A4, wD780, wC370, wC208
ScriptCommandE0_Run_Case01::
Jump_01C_40EA:: ; address name
    ld hl, wD782
    ld de, Data_01C_4158
    ld c, $00

Jump_01C_40F2::
    ld a, [de]
    ld [hl+], a
    inc de
    inc c
    ld a, c
    cp a, $18
    jr c, Jump_01C_40F2
    ld hl, wD78C
    call Func_01C_4395
    ld a, [wC8CB]
    bit 7, a
    jr nz, Jump_01C_4122
    ld de, wD782
    ld hl, wC30C
    ld bc, $0803
    call CopyRectTo20ByteRowsJp_Bank1C
    ld de, wD782
    ld hl, wC1A4
    ld bc, $0803
    call CopyRectTo20ByteRowsJp_Bank1C
    jr Jump_01C_413A

Jump_01C_4122::
    ld de, wD782
    ld hl, wC370
    ld bc, $0803
    call CopyRectTo20ByteRowsJp_Bank1C
    ld de, wD782
    ld hl, wC208
    ld bc, $0803
    call CopyRectTo20ByteRowsJp_Bank1C

Jump_01C_413A::
    call BGMapAddressAtScroll_Bank1C
    ld bc, $1408
    ld de, $0168
    call Func_01C_449F
    xor a, a
    ld [wC46B], a
    ld hl, wD780
    inc [hl]
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Data_01C_4158:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $BF, $C3, $C3, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; entry 2 of the `rst $00` table in ScriptCommandE0_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD7F7, wD7F8, wMenuInputResult, wD7F1
; writes: wD7F3, wD7F2, wD7F1, wC552, wC46B, wScriptCommandType, wScriptStartRequest
; points at: wD780
ScriptCommandE0_Run_Case02::
Jump_01C_4170:: ; address name
    ld a, [wD7F7]
    ld e, a
    ld a, [wD7F8]
    ld h, a
    ld a, [wMenuInputResult]
    ld l, a
    push de
    push hl
    ld a, e
    ld [wD7F3], a
    ld a, h
    ld [wD7F2], a
    ld a, l
    ld [wD7F1], a
    call IsAmountInWD7F1AboveGold
    ld a, [wD7F1]
    cp a, $FF
    jr z, Jump_01C_41B4
    pop hl
    pop de
    xor a, a
    ld [wC552], a
    ld [wC46B], a
    call ScriptCommandE0_Run_Case02_Sub01
    call ScriptCommandE0_Run_Case02_Sub02
    call ScriptCommandE0_Run_Case02_Sub03
    ld hl, wD780
    inc [hl]
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01C_41B4::
    pop hl
    pop de
    ld a, $01
    ld [wC552], a
    xor a, a
    ld [wC46B], a
    ld hl, wD780
    inc [hl]
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 3 of the `rst $00` table in ScriptCommandE0_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wC56D
; points at: wD780
ScriptCommandE0_Run_Case03::
Jump_01C_41CD:: ; address name
    ld a, $87
    ld [wC56D], a
    ld a, $04
    call StartPaletteFade
    ld hl, wD780
    inc [hl]
    ret

; entry 4 of the `rst $00` table in ScriptCommandE0_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState
; points at: wD780
ScriptCommandE0_Run_Case04::
Jump_01C_41DC:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ld hl, wD780
    inc [hl]
    ret

; entry 5 of the `rst $00` table in ScriptCommandE0_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wD780
ScriptCommandE0_Run_Case05::
Jump_01C_41E6:: ; address name
    ld hl, wD780
    inc [hl]
    ret

; entry 6 of the `rst $00` table in ScriptCommandE0_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC6FD, hFFC6, wD7F5, wD7F6, wD7F7, wD7F8
; writes: rRAMG2, rRAMB, wD7F5, wD7F6, wD7F7, wD7F8
; points at: wC6FE, wD780
ScriptCommandE0_Run_Case06::
Jump_01C_41EB:: ; address name
    ld a, [wC6FD]
    and a, a
    jp z, Jump_01C_424E
    ld c, a
    ld hl, wC6FE
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a

Jump_01C_41FF::
    push bc
    push hl
    ld a, [hl]
    ld c, $55
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    bit 7, a
    jr nz, Jump_01C_4241
    pop hl
    push hl
    ld a, [hl]
    ld c, $5D
    call SRAMRecordAddress
    ld a, [hl+]
    ld [wD7F5], a
    ld a, [hl+]
    ld [wD7F6], a
    inc hl
    inc hl
    ld a, [hl+]
    ld [wD7F7], a
    ld a, [hl]
    ld [wD7F8], a
    pop hl
    push hl
    ld a, [hl]
    ld c, $5B
    call SRAMRecordAddress
    ld a, [wD7F5]
    ld [hl+], a
    ld a, [wD7F6]
    ld [hl+], a
    inc hl
    inc hl
    ld a, [wD7F7]
    ld [hl+], a
    ld a, [wD7F8]
    ld [hl], a

Jump_01C_4241::
    pop hl
    pop bc
    inc hl
    dec c
    ld a, c
    and a, a
    jp nz, Jump_01C_41FF
    xor a, a
    ld [rRAMG2], a

Jump_01C_424E::
    ld hl, wD780
    inc [hl]
    ld a, $40
    call QueueMusic
    ret

; entry 7 of the `rst $00` table in ScriptCommandE0_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD781, wCC44
; writes: wD781, wC56D, wC950, wC893
; points at: wD781, wD780
ScriptCommandE0_Run_Case07::
Jump_01C_4258:: ; address name
    ld hl, wD781
    inc [hl]
    ld a, [wD781]
    cp a, $90
    ret c
    xor a, a
    ld [wD781], a
    call Func_01C_42B3
    ld a, $87
    ld [wC56D], a
    ld a, $F8
    call StartPaletteFade
    ld hl, wD780
    inc [hl]
    xor a, a
    ld [wC950], a
    ld a, $80
    ld [wC893], a
    ld a, [wCC44]
    bit 7, a
    jr nz, Jump_01C_428E
    farcall Func_060_639D
    ret

Jump_01C_428E::
    farcall Func_060_62F9
    ret

; entry 8 of the `rst $00` table in ScriptCommandE0_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState
; writes: wC56D, wScriptCommandType, wScriptStartRequest
; points at: wD780
ScriptCommandE0_Run_Case08::
Jump_01C_4295:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    farcall Func_002_604B
    ld a, $07
    ld [wC56D], a
    ld hl, wD780
    inc [hl]
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; 3 call sites from 3 routines (e.g. ScriptCommandE0_Run_Case07, Func_015_5A2D_Case05, GameMode5_Update_Case07_Sub01)
; reads: wSGBActive, wC51F, wC520
; writes: wC577, wC578, wC579, wC57A, wC57B, wC57C, wC57D, wC57E, ...
Func_01C_42B3::
    ld a, [wSGBActive]
    and a, a
    ret z
    ld a, [wC51F]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    ld [wC577], a
    ld a, h
    ld [wC578], a
    inc hl
    ld a, l
    ld [wC579], a
    ld a, h
    ld [wC57A], a
    inc hl
    ld a, l
    ld [wC57B], a
    ld a, h
    ld [wC57C], a
    inc hl
    ld a, l
    ld [wC57D], a
    ld a, h
    ld [wC57E], a
    ld a, $B1
    ld [wSGBPacketBuffer], a
    ld a, [wC520]
    ld [wC480], a
    ld a, $FF
    ld [wSGBPacketIndex], a
    farcall_b SendSGBPacketSet
    call SpinDelay
    farcall Func_017_421A
    ret

; With rSVBK = 2, copies BC bytes from [DE] to [HL], each ANDed with $07; then rSVBK = 0 (the same 19 bytes appear in 5 banks)
; 8 call sites from 6 routines (e.g. ScriptCommandE1_Run, ScriptCommandE5_Run_Case00, ScriptCommandE3_Run_Case00_Sub01, ScriptCommandE2_Run_Case00, ...)
; writes: rSVBK
CopyLow3BitsToWRAMBank2_Bank1C::
Func_01C_4303:: ; address name
    ld a, $02
    ldh [rSVBK], a

Jump_01C_4307::
    ld a, [de]
    and a, $07
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_01C_4307
    ld a, $00
    ldh [rSVBK], a
    ret

; DE = source, HL = destination, BC = count: copies BC bytes (BC = 0 copies 65536); DE and HL end past the copy; clobbers A, BC = 0 (E-0064) (the same 9 bytes appear in 13 banks)
; 8 call sites from 6 routines (e.g. ScriptCommandE1_Run, ScriptCommandE5_Run_Case00, ScriptCommandE3_Run_Case00_Sub01, ScriptCommandE2_Run_Case00, ...)
CopyBytesDEToHL_Bank1C::
Func_01C_4316:: ; address name
    ld a, [de]
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, CopyBytesDEToHL_Bank1C
    ret

; the same instructions as CopyRectTo20ByteRowsJp_Bank24: copies a B x C rectangle from DE to HL with rows 20 bytes apart; on CGB zero-fills the same rectangle at HL + $0E68 with rSVBK = 2 (E-0073)
; 11 call sites from 5 routines (e.g. ScriptCommandE0_Run_Case02_Sub03, ScriptCommandE0_Run_Case01, ScriptCommandE2_Run_Table2_Case03, Func_01C_6A71, ...)
; reads: wIsCGB
; writes: rSVBK
CopyRectTo20ByteRowsJp_Bank1C::
Func_01C_431F:: ; address name
    push hl
    push bc

Jump_01C_4321::
    push hl
    push bc

Jump_01C_4323::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_01C_4323
    pop bc
    pop hl
    ld a, l
    add a, $14
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec c
    jp nz, Jump_01C_4321
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

Jump_01C_434A::
    push hl
    push bc

Jump_01C_434C::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_01C_434C
    pop bc
    pop hl
    ld a, l
    add a, $14
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec c
    jp nz, Jump_01C_434A
    ld a, $00
    ldh [rSVBK], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC8CB, wC468, wC6FD, hFF8C
; writes: hFFB9
Func_01C_4364:: ; heuristic: follows a terminator; C0
    ld de, $0002
    call TestFlagBit
    jr nc, Jump_01C_4393
    ld a, [wC8CB]
    and a, $03
    jr nz, Jump_01C_4393
    ld a, [wC468]
    bit 7, a
    jr nz, Jump_01C_4393
    ld a, [wC6FD]
    or a, a
    jr z, Jump_01C_4393
    ldh a, [hFF8C]
    bit 0, a
    jr nz, Jump_01C_4393
    ld a, $03
    ldh [hFFB9], a
    farcall Func_004_4470
    ld a, $FF
    ret

Jump_01C_4393::
    xor a, a
    ret

; 7 call sites from 7 routines (e.g. ScriptCommandE0_Run_Case02_Sub03, ScriptCommandE0_Run_Case01, Func_01C_6A22, Func_01C_4867_Case0E, ...)
; reads: wGoldLo, wGoldMid, wGoldHi
; writes: wC8C0, wC8C1, wC8C2
; points at: hFFC8
Func_01C_4395::
    push hl
    ld a, [wGoldLo]
    ld l, a
    ld a, [wGoldMid]
    ld h, a
    ld a, l
    ld [wC8C0], a
    ld a, h
    ld [wC8C1], a
    ld a, [wGoldHi]
    ld [wC8C2], a
    call Number24ToPackedBCD
    pop hl
    ld c, $00
    ld b, $03
    ld de, hFFC8
    jp Jump_01C_43E9

Jump_01C_43BA::
    ld a, [de]
    srl a
    srl a
    srl a
    srl a
    or a, a
    jp nz, Jump_01C_43CC
    bit 0, c
    jp z, Jump_01C_43D3

Jump_01C_43CC::
    add a, $E0
    call WriteVRAMByte
    ld c, $01

Jump_01C_43D3::
    inc hl
    ld a, l
    and a, $1F
    jp nz, Jump_01C_43E2
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

Jump_01C_43E2::
    ld a, b
    dec a
    jp nz, Jump_01C_43E9
    ld c, $01

Jump_01C_43E9::
    ld a, [de]
    dec de
    and a, $0F
    jp nz, Jump_01C_43F5
    bit 0, c
    jp z, Jump_01C_43FC

Jump_01C_43F5::
    add a, $E0
    call WriteVRAMByte
    ld c, $01

Jump_01C_43FC::
    inc hl
    ld a, l
    and a, $1F
    jp nz, Jump_01C_440B
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

Jump_01C_440B::
    dec b
    jr nz, Jump_01C_43BA
    ret

; compares the 24-bit value wD7F3:wD7F2:wD7F1 (wD7F3 most significant) with wGoldHi:wGoldMid:wGoldLo: wD7F1 = $FF when it is greater, 0 when it is less or equal (the low byte is overwritten with the result) (E-0073)
; 10 call sites from 9 routines (e.g. ScriptCommandE0_Run_Case02, Func_01C_4867_Case0C, ScriptCommandF7_Run_Case04, ScriptCommandF7_Run_Case17, ...)
; reads: wGoldHi, wD7F3, wGoldMid, wD7F2, wGoldLo, wD7F1
; writes: wD7F1
IsAmountInWD7F1AboveGold::
Func_01C_440F:: ; address name
    ld a, [wGoldHi]
    ld b, a
    ld a, [wD7F3]
    cp a, b
    jr z, Jump_01C_441D
    jr c, Jump_01C_443D
    jr Jump_01C_4437

Jump_01C_441D::
    ld a, [wGoldMid]
    ld b, a
    ld a, [wD7F2]
    cp a, b
    jr z, Jump_01C_442B
    jr c, Jump_01C_443D
    jr Jump_01C_4437

Jump_01C_442B::
    ld a, [wGoldLo]
    ld b, a
    ld a, [wD7F1]
    cp a, b
    jr z, Jump_01C_443D
    jr c, Jump_01C_443D

Jump_01C_4437::
    ld a, $FF
    ld [wD7F1], a
    ret

Jump_01C_443D::
    xor a, a
    ld [wD7F1], a
    ret

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX, hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
; 3 call sites from 3 routines (e.g. ScriptCommandE1_Run, ScriptCommandE0_Run_Case02_Sub03, ScriptCommandE0_Run_Case01)
; reads: hScrollY, hScrollX
BGMapAddressAtScroll_Bank1C::
Func_01C_4442:: ; address name
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

; only called from ScriptCommandE0_Run_Case00 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandE0_Run_Case00)
; writes: wD7F7, wD7F8, wMenuInputResult
; points at: wC8C0, wC130
ScriptCommandE0_Run_Case00_Sub01::
Func_01C_4463:: ; address name
    ld hl, wC8C0
    xor a, a
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    xor a, a
    ld [hl], a
    ld l, $0A
    ld h, $00
    xor a, a
    ld [wD7F7], a
    ld a, h
    ld [wD7F8], a
    ld a, l
    ld [wMenuInputResult], a
    ld hl, wC8C0
    ld de, wC130
    ld c, $03
    ld a, [hl]
    and a, a
    jr nz, Jump_01C_4491
    inc hl
    dec c
    ld a, [hl]
    and a, a
    jr nz, Jump_01C_4491
    inc hl
    dec c

Jump_01C_4491::
    ld a, c
    and a, a
    jr z, Jump_01C_449B
    ld a, [hl+]
    ld [de], a
    inc de
    dec c
    jr Jump_01C_4491

Jump_01C_449B::
    ld a, $F0
    ld [de], a
    ret

; 5 call sites from 5 routines (e.g. ScriptCommandE1_Run, ScriptCommandE3_Run_Case00_Sub01, ScriptCommandE0_Run_Case02_Sub03, ScriptCommandE0_Run_Case01, ...)
; reads: wIsCGB
; writes: wC554, wC555, rSVBK
; points at: wScreenTileBuffer, wD000
Func_01C_449F::
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

; only called from ScriptCommandE0_Run_Case02 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandE0_Run_Case02)
; reads: wD7F7, wD7F8, wMenuInputResult, wGoldHi, wGoldMid, wGoldLo
; writes: wGoldHi, wGoldMid, wGoldLo
ScriptCommandE0_Run_Case02_Sub01::
Func_01C_44F3:: ; address name
    ld a, [wD7F7]
    ld e, a
    ld a, [wD7F8]
    ld h, a
    ld a, [wMenuInputResult]
    ld l, a
    ld a, [wGoldHi]
    ld d, a
    ld a, [wGoldMid]
    ld b, a
    ld a, [wGoldLo]
    sub a, l
    ld c, a
    ld a, b
    sbc a, h
    ld b, a
    ld a, d
    sbc a, e
    ld [wGoldHi], a
    ld a, b
    ld [wGoldMid], a
    ld a, c
    ld [wGoldLo], a
    ret

; only called from ScriptCommandE0_Run_Case02 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandE0_Run_Case02)
; reads: wIsCGB
; points at: wC300, wC3A0, wD168, wD208
ScriptCommandE0_Run_Case02_Sub02::
Func_01C_451D:: ; address name
    ld hl, wC300
    ld de, wC3A0
    ld bc, $00A0
    call CopyBytesDEToHL_Bank1C
    ld a, [wIsCGB]
    and a, a
    ret z
    ld hl, wD168
    ld de, wD208
    ld bc, $00A0
    call CopyLow3BitsToWRAMBank2_Bank1C
    ret

; only called from ScriptCommandE0_Run_Case02 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandE0_Run_Case02)
; reads: wC8CB
; points at: wD782, wD78C, wC30C, wC1A4, wC370, wC208
ScriptCommandE0_Run_Case02_Sub03::
Func_01C_453B:: ; address name
    ld hl, wD782
    ld de, Data_01C_4598
    ld c, $00

Jump_01C_4543::
    ld a, [de]
    ld [hl+], a
    inc de
    inc c
    ld a, c
    cp a, $18
    jr c, Jump_01C_4543
    ld hl, wD78C
    call Func_01C_4395
    ld a, [wC8CB]
    bit 7, a
    jr nz, Jump_01C_4573
    ld de, wD782
    ld hl, wC30C
    ld bc, $0803
    call CopyRectTo20ByteRowsJp_Bank1C
    ld de, wD782
    ld hl, wC1A4
    ld bc, $0803
    call CopyRectTo20ByteRowsJp_Bank1C
    jr Jump_01C_458B

Jump_01C_4573::
    ld de, wD782
    ld hl, wC370
    ld bc, $0803
    call CopyRectTo20ByteRowsJp_Bank1C
    ld de, wD782
    ld hl, wC208
    ld bc, $0803
    call CopyRectTo20ByteRowsJp_Bank1C

Jump_01C_458B::
    call BGMapAddressAtScroll_Bank1C
    ld bc, $1408
    ld de, $0168
    call Func_01C_449F
    ret

Data_01C_4598:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $BF, $C3, $C3, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; 2 call sites from 2 routines (e.g. Func_01C_52E8_Case0D, ScriptCommandF7_Run_Shared06)
; reads: wGoldLo, wGoldMid, wGoldHi, wD7F1, wD7F2, wD7F3
; writes: wGoldHi, wGoldMid, wGoldLo
Func_01C_45B0::
    ld a, [wGoldLo]
    ld e, a
    ld a, [wGoldMid]
    ld d, a
    ld a, [wGoldHi]
    ld h, a
    ld a, [wD7F1]
    add a, e
    ld c, a
    ld a, [wD7F2]
    adc a, d
    ld b, a
    ld a, [wD7F3]
    adc a, h
    ld h, a
    ld a, h
    cp a, $02
    jr nc, Jump_01C_45F5
    cp a, $01
    jr c, Jump_01C_45E8
    ld a, b
    cp a, $87
    jr nc, Jump_01C_45F5
    cp a, $86
    jr c, Jump_01C_45E8
    ld a, c
    cp a, $A1
    jr nc, Jump_01C_45F5
    cp a, $A0
    jr c, Jump_01C_45E8
    jr Jump_01C_45F5

Jump_01C_45E8::
    ld a, h
    ld [wGoldHi], a
    ld a, b
    ld [wGoldMid], a
    ld a, c
    ld [wGoldLo], a
    ret

Jump_01C_45F5::
    ld a, $01
    ld [wGoldHi], a
    ld a, $86
    ld [wGoldMid], a
    ld a, $9F
    ld [wGoldLo], a
    ret

; implements script command type E3; reached through ScriptCommandE3 in bank $10 (E-0038)
; 2 call sites from 2 routines (e.g. ScriptCommandE6_Run, ScriptCommandE3)
; reads: wD787
ScriptCommandE3_Run::
Func_01C_4605:: ; address name
    ld a, [wD787]
    rst $00
    dw ScriptCommandE3_Run_Case00
    dw ScriptCommandE3_Run_Case01
    dw ScriptCommandE3_Run_Case02
    dw ScriptCommandE3_Run_Case03

; entry 0 of the `rst $00` table in ScriptCommandE3_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommandE3_Run_Case00::
Jump_01C_4611:: ; address name
    call ScriptCommandE3_Run_Case00_Sub01
    ret

; entry 1 of the `rst $00` table in ScriptCommandE3_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommandE3_Run_Case01::
Jump_01C_4615:: ; address name
    call ScriptCommandE3_Run_Case01_Sub01
    ret

; entry 2 of the `rst $00` table in ScriptCommandE3_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD787
; writes: wC52D, wC52E, wC52F, wC530, wD787
ScriptCommandE3_Run_Case02::
Jump_01C_4619:: ; address name
    ld b, $46
    ld de, Data_046_4001
    ld hl, vTiles1
    call DecompressToVRAM
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
    ld a, [wD787]
    inc a
    ld [wD787], a
    ret

; entry 3 of the `rst $00` table in ScriptCommandE3_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wD7F0, wD787, wScriptCommandType, wScriptStartRequest
; points at: wD780, wC130
ScriptCommandE3_Run_Case03::
Jump_01C_465B:: ; address name
    farcall DrawRecordListNameTiles_Bank1D
    farcall LoadTilesForPartyRecords
    xor a, a
    ld [wD7F0], a
    ld [wD787], a
    ld bc, $0070
    ld hl, wD780

Jump_01C_4674::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_01C_4674
    ld hl, wC130
    ld b, $10

Jump_01C_4680::
    ld a, $F0
    ld [hl+], a
    dec b
    jr nz, Jump_01C_4680
    farcall Func_002_470B
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type E2; reached through ScriptCommandE2 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommandE2)
; reads: wD780
ScriptCommandE2_Run::
Func_01C_4696:: ; address name
    ld a, [wD780]
    rst $00
    dw ScriptCommandE2_Run_Case00
    dw ScriptCommandE2_Run_Case01
    dw ScriptCommandE2_Run_Case02
    dw ScriptCommandE2_Run_Case03
    dw ScriptCommandE2_Run_Case04

; entry 0 of the `rst $00` table in ScriptCommandE2_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: wD7F0, wD784, wD783, wD7CA, wD7CB, wD7CC, wScriptCommandType, wScriptStartRequest
; points at: wD780, wC364, wScreenTileBuffer, wD1CC, wD000
ScriptCommandE2_Run_Case00::
Jump_01C_46A4:: ; address name
    ld bc, $0070
    ld hl, wD780

Jump_01C_46AA::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_01C_46AA
    ld hl, wC364
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank1C
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_01C_46CF
    ld hl, wD1CC
    ld de, wD000
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank1C

Jump_01C_46CF::
    ld a, $02
    ld [wD7F0], a
    xor a, a
    ld [wD784], a
    ld [wD783], a
    ld [wD7CA], a
    ld a, $01
    ld [wD7CB], a
    ld [wD7CC], a
    ld hl, wD780
    inc [hl]
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 1 of the `rst $00` table in ScriptCommandE2_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
ScriptCommandE2_Run_Case01::
Jump_01C_46F4:: ; address name
    ld a, [wD781]
    rst $00
    dw ScriptCommandE2_Run_Table2_Case00
    dw ScriptCommandE2_Run_Table2_Case01
    dw ScriptCommandE2_Run_Table2_Case02
    dw ScriptCommandE2_Run_Table2_Case03
    dw ScriptCommandE2_Run_Table2_Case04

; entry 0 of the `rst $00` table in ScriptCommandE2_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wD781
ScriptCommandE2_Run_Table2_Case00::
Jump_01C_4702:: ; address name
    ld hl, wD781
    inc [hl]

; entry 1 of the `rst $00` table in ScriptCommandE2_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommandE2_Run_Table2_Case01::
Jump_01C_4706:: ; address name
    ld hl, Data_01C_5F86
    ld de, Data_01C_5FE8
    call Func_01C_69D5
    ret

; entry 2 of the `rst $00` table in ScriptCommandE2_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommandE2_Run_Table2_Case02::
Jump_01C_4710:: ; address name
    call Func_01C_6A22
    ret

; entry 3 of the `rst $00` table in ScriptCommandE2_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wD781, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
; points at: wC364, wD780
ScriptCommandE2_Run_Table2_Case03::
Jump_01C_4714:: ; address name
    ld de, Data_01C_4738
    ld hl, wC364
    ld bc, $0807
    call CopyRectTo20ByteRowsJp_Bank1C
    call Func_01C_6A71
    xor a, a
    ld [wD781], a
    ld [wTwoChoiceCursor], a
    ld hl, wD780
    inc [hl]
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Data_01C_4738:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $EA, $EB, $EC, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $ED, $CF, $EF, $EF, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $A9, $AB, $AC, $AD, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; entry 4 of the `rst $00` table in ScriptCommandE2_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wD781, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
; points at: wD780
ScriptCommandE2_Run_Table2_Case04::
Jump_01C_4770:: ; address name
    xor a, a
    ld [wD781], a
    ld [wTwoChoiceCursor], a
    ld hl, wD780
    inc [hl]
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in ScriptCommandE2_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wD7B1, wD7B2, wD7B0, wD780
; writes: wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wD7B5, wD7B6, wD7B2, wD780, wD7C7, ...
ScriptCommandE2_Run_Case02::
Jump_01C_4785:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, Jump_01C_47A0
    bit 7, a
    jr nz, Jump_01C_47BE
    ld a, [wJoypadPressed]
    bit 0, a
    jr nz, Jump_01C_47CE
    bit 1, a
    jp nz, Jump_01C_483D
    call ScriptCommandE2_Run_Case02_Sub01
    ret

Jump_01C_47A0::
    call ScriptCommandE2_Run_Case02_Sub03
    ld a, [wD7B1]
    and a, a
    jr nz, Jump_01C_47BB
    ld a, $02

Jump_01C_47AB::
    ld [wD7B1], a
    xor a, a
    ld [wD7B3], a
    call ScriptCommandE2_Run_Case02_Sub02
    ld a, $69
    call QueueSoundEffect
    ret

Jump_01C_47BB::
    dec a
    jr Jump_01C_47AB

Jump_01C_47BE::
    call ScriptCommandE2_Run_Case02_Sub03
    ld a, [wD7B1]
    cp a, $02
    jr c, Jump_01C_47CB
    xor a, a
    jr Jump_01C_47AB

Jump_01C_47CB::
    inc a
    jr Jump_01C_47AB

Jump_01C_47CE::
    call ScriptCommandE2_Run_Case02_Sub04
    ld a, $69
    call QueueSoundEffect
    ld a, [wD7B1]
    ld [wTwoChoiceCursor], a
    ld b, a
    ld a, [wD7B2]
    cp a, b
    jr z, Jump_01C_47EE
    ld a, [wD7B1]
    ld b, a
    xor a, a
    ld [wD7B5], a
    ld [wD7B6], a

Jump_01C_47EE::
    ld a, b
    ld [wD7B2], a
    ld a, [wD7B1]
    and a, a
    jr z, Jump_01C_4806
    cp a, $01
    jr z, Jump_01C_481B

Jump_01C_47FC::
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01C_4806::
    ld a, [wD7B0]
    cp a, $18
    jr c, Jump_01C_480D

Jump_01C_480D::
    ld a, [wD780]
    inc a
    ld [wD780], a
    xor a, a
    ld [wD7C7], a
    jp Jump_01C_47FC

Jump_01C_481B::
    ld a, [wD7B0]
    and a, a
    jr nz, Jump_01C_4829
    ld a, $04
    ld [wTwoChoiceCursor], a
    jp Jump_01C_47FC

Jump_01C_4829::
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wD780]
    add a, $02
    ld [wD780], a
    xor a, a
    ld [wD7C7], a
    jp Jump_01C_47FC

Jump_01C_483D::
    ld a, $02
    ld [wTwoChoiceCursor], a
    jp Jump_01C_47FC

; only called from ScriptCommandE2_Run_Case02 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandE2_Run_Case02)
; reads: wJoypadRepeatTimer, wD7B3, wD7B1
; writes: wD7B3
ScriptCommandE2_Run_Case02_Sub01::
Func_01C_4845:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, ScriptCommandE2_Run_Case02_Sub02
    ld a, [wD7B3]
    inc a
    ld [wD7B3], a
    cp a, $10
    jr c, ScriptCommandE2_Run_Case02_Sub02
    cp a, $18
    jr c, ScriptCommandE2_Run_Case02_Sub03
    xor a, a
    ld [wD7B3], a

; only called from ScriptCommandE2_Run_Case02 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandE2_Run_Case02)
; reads: wD7B1
ScriptCommandE2_Run_Case02_Sub02::
Func_01C_485F:: ; address name
    ld b, $BB
    jr Jump_01C_4869

; only called from ScriptCommandE2_Run_Case02 (E-0047)
; 2 call sites from 1 routine (e.g. ScriptCommandE2_Run_Case02)
; reads: wD7B1
ScriptCommandE2_Run_Case02_Sub03::
Func_01C_4863:: ; address name
    ld b, $C3
    jr Jump_01C_4869

; only called from ScriptCommandE2_Run_Case02 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandE2_Run_Case02)
; reads: wD7B1
ScriptCommandE2_Run_Case02_Sub04::
Func_01C_4867:: ; address name
    ld b, $BC

Jump_01C_4869::
    ld a, [wD7B1]
    add a, a
    ld hl, Data_01C_4888
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1C_67AF
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld [hl], b
    ei
    ret

Data_01C_4888:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $21, $00, $61, $00, $A1, $00

; entry 3 of the `rst $00` table in ScriptCommandE2_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
ScriptCommandE2_Run_Case03::
Jump_01C_488E:: ; address name
    ld a, [wD781]
    rst $00
    dw Func_01C_4867_Case00
    dw Func_01C_4867_Case01
    dw Func_01C_4867_Case02
    dw Func_01C_4867_Case03
    dw Func_01C_4867_Case04
    dw Func_01C_4867_Case05
    dw Func_01C_4867_Case06
    dw Func_01C_4867_Case07
    dw Func_01C_4867_Case08
    dw Func_01C_4867_Case09
    dw Func_01C_4867_Case0A
    dw Func_01C_4867_Case0B
    dw Func_01C_4867_Case0C
    dw Func_01C_52E8
    dw Func_01C_4867_Case0E
    dw Func_01C_4867_Case0F
    dw Func_01C_4867_Case10

; entry 0 of the `rst $00` table in Func_01C_4867
; no direct call (reached through a table, a jump or a vector)
; reads: rSTAT, wIsCGB, wD781
; writes: rVBK, wD781
Func_01C_4867_Case00::
Jump_01C_48B4:: ; address name
    ld hl, Data_01C_60AC
    ld de, vBGMap1 + $300

Jump_01C_48BA::
    ld a, [hl]
    cp a, $7F
    jr z, Jump_01C_48CC
    di

Jump_01C_48C0::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_01C_48C0
    ld a, [hl+]
    ld [de], a
    ei
    inc de
    jr Jump_01C_48BA

Jump_01C_48CC::
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_01C_48ED
    ld a, $01
    ldh [rVBK], a
    ld hl, vBGMap1 + $300
    ld b, $56

Jump_01C_48DB::
    di

Jump_01C_48DC::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_01C_48DC
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ei
    dec b
    jr nz, Jump_01C_48DB
    ld a, $00
    ldh [rVBK], a

Jump_01C_48ED::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 1 of the `rst $00` table in Func_01C_4867
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
Func_01C_4867_Case01::
Jump_01C_48F5:: ; address name
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $0081
    add hl, de
    ld bc, $1309
    ld de, vBGMap1 + $300
    call Func_01C_67D0
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 2 of the `rst $00` table in Func_01C_4867
; no direct call (reached through a table, a jump or a vector)
; reads: wD7B6, wD7BA, wC8C2, wD781, wD7B5
; writes: wD7BC, wD7BA, wD7B6, wD7B7, wD781, wD783, wD784, wD7B5
Func_01C_4867_Case02::
Jump_01C_490D:: ; address name
    call Func_01C_68DF
    ld c, $00

Jump_01C_4912::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_01C_491B
    inc hl
    inc c
    jr Jump_01C_4912

Jump_01C_491B::
    ld a, c
    ld [wD7BC], a
    ld l, a
    ld h, $00
    ld a, $04
    call DivideHLByA
    push af
    and a, a
    jr z, Jump_01C_492C
    inc l

Jump_01C_492C::
    ld a, l
    ld [wD7BA], a
    ld a, [wD7B6]
    inc a
    cp a, l
    jr c, Jump_01C_4967
    pop af
    push af
    and a, a
    jr nz, Jump_01C_494C
    ld a, [wD7B6]
    inc a
    cp a, l
    jr z, Jump_01C_4967
    ld a, [wD7B6]
    dec a
    ld [wD7B6], a
    jr Jump_01C_4967

Jump_01C_494C::
    pop af
    dec a
    ld [wD7B7], a
    ld b, a
    ld a, [wD7B5]
    cp a, b
    jr c, Jump_01C_496D
    jr z, Jump_01C_496D
    push bc
    push hl
    call EraseWD7B5Cursor
    pop hl
    pop bc
    ld a, b
    ld [wD7B5], a
    jr Jump_01C_496D

Jump_01C_4967::
    pop af
    ld a, $03
    ld [wD7B7], a

Jump_01C_496D::
    ld a, [wD7BA]
    cp a, $02
    jr c, Jump_01C_49AD
    call Func_01C_6C78
    call HLToDecimalDigits
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $0191
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, [wC8C2]
    add a, $E0
    ld [hl], a
    ei
    ld a, [wD7B6]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $018F
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, [wC8C2]
    add a, $E1
    ld [hl], a
    ei

Jump_01C_49AD::
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wD783], a
    ld [wD784], a
    ret

; entry 3 of the `rst $00` table in Func_01C_4867
; no direct call (reached through a table, a jump or a vector)
; reads: wD783, wD784, wD7B6, wD7B8, wD781
; writes: wD784, wD7B8, wD783, wD781
Func_01C_4867_Case03::
Jump_01C_49BC:: ; address name
    ld a, [wD783]
    add a, a
    ld hl, Data_01C_6289
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]

Jump_01C_49CB::
    push de
    ld a, [wD784]
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_01C_49D5
    inc d

Jump_01C_49D5::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld de, Data_01F_4910
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    pop de
    ld a, [wD784]
    inc a
    ld [wD784], a
    cp a, $09
    jr c, Jump_01C_49CB
    xor a, a
    ld [wD784], a
    call Func_01C_68DF
    ld a, [wD7B6]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, [wD783]
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    jp z, Jump_01C_4A9F
    ld e, a
    ld d, $00
    sla e
    rl d
    ld hl, Data_01C_63FE
    add hl, de
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e

Jump_01C_4A23::
    ld a, [hl]
    cp a, $F0
    jp z, Jump_01C_4A9F
    ld [wD7B8], a
    push hl
    ld hl, $4010
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    push de
    ld a, [wD783]
    add a, a
    ld de, Data_01C_6289
    add a, e
    ld e, a
    jr nc, Jump_01C_4A55
    inc d

Jump_01C_4A55::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, [wD7B8]
    cp a, $8D
    jr z, Jump_01C_4A67
    cp a, $8E
    jr z, Jump_01C_4A67
    jr Jump_01C_4A6E

Jump_01C_4A67::
    ld a, [wD784]
    dec a
    ld [wD784], a

Jump_01C_4A6E::
    ld a, [wD784]
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    pop de
    ld b, $1F
    ld c, $10
    ld a, [wD7B8]
    cp a, $8D
    jr z, Jump_01C_4A90
    cp a, $8E
    jr z, Jump_01C_4A90
    call CopyFromBankWaitVRAM
    jr Jump_01C_4A93

Jump_01C_4A90::
    call OrFromBankWaitVRAM

Jump_01C_4A93::
    pop hl
    inc hl
    ld a, [wD784]
    inc a
    ld [wD784], a
    jp Jump_01C_4A23

Jump_01C_4A9F::
    xor a, a
    ld [wD784], a
    ld a, [wD783]
    inc a
    ld [wD783], a
    cp a, $04
    jr c, Jump_01C_4ABB
    xor a, a
    ld [wD783], a
    ld a, [wD781]
    inc a
    inc a
    ld [wD781], a
    ret

Jump_01C_4ABB::
    ret

; entry 4 of the `rst $00` table in Func_01C_4867
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
Func_01C_4867_Case04::
Jump_01C_4ABC:: ; address name
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 5 of the `rst $00` table in Func_01C_4867
; no direct call (reached through a table, a jump or a vector)
; reads: wD7B6, wD783, wD7EE, wD781
; writes: wD7F3, wD7F4, wD7F5, wD7F6, wD7F7, wD7F8, wD7EE, wD783, ...
; points at: wD7F3
Func_01C_4867_Case05::
Jump_01C_4AC4:: ; address name
    call Func_01C_68DF
    ld a, [wD7B6]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    add hl, de

Jump_01C_4AD6::
    push hl
    ld a, [wD783]
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_01C_4AFA
    ld a, $E3
    ld [wD7F3], a
    ld [wD7F4], a
    ld [wD7F5], a
    ld [wD7F6], a
    ld [wD7F7], a
    ld [wD7F8], a
    jr Jump_01C_4B2F

Jump_01C_4AFA::
    ld e, a
    ld l, a
    ld h, $00
    ld d, $00
    sla e
    rl d
    add hl, de
    ld e, l
    ld d, h
    call Func_01C_5F26
    add hl, de
    call Func_01C_5EEC
    ld e, l
    ld d, h
    ld b, $F2
    call ReadFarPointerAtDEInBankB
    ld a, l
    ld [wC8C0], a
    ld a, h
    ld [wC8C1], a
    ld a, b
    ld [wC8C2], a
    call Number24ToPackedBCD
    farcall UnpackBCDToDigitsWD7F1_Bank1E
    ld a, $DF
    ld [wD7F8], a

Jump_01C_4B2F::
    ld hl, Data_01C_62D9
    ld a, [wD783]
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1C_67AF
    pop de
    add hl, de
    dec hl
    ld e, l
    ld d, h
    xor a, a
    ld [wD7EE], a
    ld hl, wD7F3
    ld c, $00

Jump_01C_4B50::
    ld a, [wD7EE]
    and a, a
    jr nz, Jump_01C_4B68
    push hl
    ld l, e
    ld h, d
    call StepBGMapAddressBackOnScrollWrap
    cp a, $FF
    jr nz, Jump_01C_4B65
    ld a, $01
    ld [wD7EE], a

Jump_01C_4B65::
    ld e, l
    ld d, h
    pop hl

Jump_01C_4B68::
    di
    call WaitForVRAMAccess
    ld a, [hl+]
    add a, $E0
    ld [de], a
    inc de
    ei
    inc c
    ld a, c
    cp a, $06
    jr c, Jump_01C_4B50
    xor a, a
    pop hl
    ld a, [wD783]
    inc a
    ld [wD783], a
    cp a, $04
    jp c, Jump_01C_4AD6
    xor a, a
    ld [wD783], a
    ld [wD784], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 6 of the `rst $00` table in Func_01C_4867
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wD7C2, wD781, wD7B7, wD7B5, wD7BA, wD7B6
; writes: wD7C7, wD780, wD781, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wD7B5, wD7B4, ...
Func_01C_4867_Case06::
Jump_01C_4B95:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 4, a
    jr nz, Jump_01C_4BE4
    bit 5, a
    jr nz, Jump_01C_4C12
    bit 6, a
    jp nz, Jump_01C_4C30
    bit 7, a
    jp nz, Jump_01C_4C58
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, Jump_01C_4C74
    call Func_01C_4C87
    call Func_01C_6AF7
    ld a, [wD7C2]
    cp a, $03
    ret c
    ld a, [wJoypadPressed]
    bit 1, a
    ret z
    call ResetWD7C2Counters
    xor a, a
    ld [wD7C7], a
    ld a, $01
    ld [wD780], a
    ld a, $01
    ld [wD781], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01C_4BE4::
    ld a, [wD7BA]
    cp a, $02
    jr c, Jump_01C_4C05
    call EraseWD7B5Cursor
    call ResetWD7C2Counters
    ld a, [wD7BA]
    ld b, a
    ld a, [wD7B6]
    inc a
    cp a, b
    jr c, Jump_01C_4BFD
    xor a, a

Jump_01C_4BFD::
    ld [wD7B6], a
    ld a, $02
    ld [wD781], a

Jump_01C_4C05::
    xor a, a
    ld [wD7B4], a
    call DrawWD7B5Cursor
    ld a, $69
    call QueueSoundEffect
    ret

Jump_01C_4C12::
    ld a, [wD7BA]
    cp a, $02
    jr c, Jump_01C_4C05
    call EraseWD7B5Cursor
    call ResetWD7C2Counters
    ld a, [wD7B6]
    and a, a
    jr nz, Jump_01C_4C2C
    ld a, [wD7BA]
    dec a
    jp Jump_01C_4BFD

Jump_01C_4C2C::
    dec a
    jp Jump_01C_4BFD

Jump_01C_4C30::
    ld a, [wD7B7]
    and a, a
    jr z, Jump_01C_4C4B
    call ResetWD7C2Counters
    call EraseWD7B5Cursor
    ld a, [wD7B5]
    and a, a
    jr nz, Jump_01C_4C47
    ld a, [wD7B7]
    jr Jump_01C_4C48

Jump_01C_4C47::
    dec a

Jump_01C_4C48::
    ld [wD7B5], a

Jump_01C_4C4B::
    xor a, a
    ld [wD7B4], a
    call DrawWD7B5Cursor
    ld a, $69
    call QueueSoundEffect
    ret

Jump_01C_4C58::
    ld a, [wD7B7]
    and a, a
    jr z, Jump_01C_4C4B
    call ResetWD7C2Counters
    call EraseWD7B5Cursor
    ld a, [wD7B7]
    ld b, a
    ld a, [wD7B5]
    cp a, b
    jr c, Jump_01C_4C71
    xor a, a
    jr Jump_01C_4C48

Jump_01C_4C71::
    inc a
    jr Jump_01C_4C48

Jump_01C_4C74::
    call DrawWD7B5CursorConfirmed
    ld a, $69
    call QueueSoundEffect
    call ResetWD7C2Counters
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; 2 call sites from 2 routines (e.g. Func_01C_4867_Case06, Func_01C_52E8_Case05)
; reads: wD7B4, wD7B5
; writes: wD7B4
Func_01C_4C87::
    ld a, [wD7B4]
    inc a
    ld [wD7B4], a
    cp a, $10
    jr c, DrawWD7B5Cursor
    cp a, $18
    jr c, EraseWD7B5Cursor
    xor a, a
    ld [wD7B4], a

; writes the cursor tile $BB at the position for wD7B5 (0-3; BG map offsets $00A2, $00E2, $0122, $0162 from the scroll origin, Data_01C_4CC4), via StepBGMapAddressBackOnScrollWrap and WaitForVRAMAccess (E-0074)
; 4 call sites from 2 routines (e.g. Func_01C_4867_Case06, Func_01C_52E8_Case05)
; reads: wD7B5
DrawWD7B5Cursor::
Func_01C_4C9A:: ; address name
    ld b, $BB
    jr Jump_01C_4CA4

; writes the blank tile $C3 at the position for wD7B5 (0-3; BG map offsets $00A2, $00E2, $0122, $0162 from the scroll origin, Data_01C_4CC4), via StepBGMapAddressBackOnScrollWrap and WaitForVRAMAccess (E-0074)
; 8 call sites from 4 routines (e.g. Func_01C_4867_Case06, Func_01C_4867_Case02, Func_01C_52E8_Case05, Func_01C_52E8_Case02)
; reads: wD7B5
EraseWD7B5Cursor::
Func_01C_4C9E:: ; address name
    ld b, $C3
    jr Jump_01C_4CA4

; writes the confirmed-cursor tile $BC at the position for wD7B5 (0-3; BG map offsets $00A2, $00E2, $0122, $0162 from the scroll origin, Data_01C_4CC4), via StepBGMapAddressBackOnScrollWrap and WaitForVRAMAccess (E-0074)
; 2 call sites from 2 routines (e.g. Func_01C_4867_Case06, Func_01C_52E8_Case05)
; reads: wD7B5
DrawWD7B5CursorConfirmed::
Func_01C_4CA2:: ; address name
    ld b, $BC

Jump_01C_4CA4::
    ld a, [wD7B5]
    add a, a
    ld hl, Data_01C_4CC4
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1C_67AF
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

Data_01C_4CC4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A2, $00, $E2, $00, $22, $01, $62, $01

; entry 7 of the `rst $00` table in Func_01C_4867
; no direct call (reached through a table, a jump or a vector)
; reads: wD7B0, wD781
; writes: wD7C7, wD780, wD781, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wD7CA, wD7CB, ...
Func_01C_4867_Case07::
Jump_01C_4CCC:: ; address name
    call ResetWD7C2Counters
    ld a, [wD7B0]
    cp a, $18
    jr c, Jump_01C_4CF3
    xor a, a
    ld [wD7C7], a
    ld a, $01
    ld [wD780], a
    ld a, $01
    ld [wD781], a
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01C_4CF3::
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ld [wD7CA], a
    ld a, $01
    ld [wD7CB], a
    ld [wD7CC], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 8 of the `rst $00` table in Func_01C_4867
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wD7CA, wD7CB, wD781
; writes: wD7CA, wD7CB, wD78D, wD78E, wD781
; points at: wD788
Func_01C_4867_Case08::
Jump_01C_4D13:: ; address name
    xor a, a
    ld [wD7CA], a
    ld a, $01
    ld [wD7CB], a
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $0140
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    ld de, vBGMap1 + $3B0
    ld b, $00
    ld c, $00
    push hl
    push hl

Jump_01C_4D2F::
    di
    call WaitForVRAMAccess
    ld a, [hl]
    ld [de], a
    ei
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_01C_4D50
    push bc
    ld c, $4F
    ld a, $01
    ldh [c], a
    pop bc
    di
    call WaitForVRAMAccess
    ld a, [hl]
    ld [de], a
    ei
    push bc
    ld c, $4F
    xor a, a
    ldh [c], a
    pop bc

Jump_01C_4D50::
    inc hl
    inc de
    inc c
    ld a, c
    cp a, $04
    jp c, Jump_01C_4D2F
    xor a, a
    ld c, a
    pop hl
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    push hl
    inc b
    ld a, b
    cp a, $03
    jp c, Jump_01C_4D2F
    pop hl
    pop hl
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_01C_4DA7
    push bc
    ld c, $4F
    ld a, $01
    ldh [c], a
    pop bc
    di
    call WaitForVRAMAccess
    xor a, a
    ld [hl], a
    ei
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    di
    call WaitForVRAMAccess
    xor a, a
    ld [hl], a
    ei
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    di
    call WaitForVRAMAccess
    xor a, a
    ld [hl], a
    ei
    push bc
    ld c, $4F
    ld a, $00
    ldh [c], a
    pop bc

Jump_01C_4DA7::
    ld hl, wD788
    ld de, Data_01C_62E1
    ld bc, $000C

Jump_01C_4DB0::
    ld a, [de]
    ld [hl+], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_01C_4DB0
    ld a, [wD7CA]
    add a, $E0
    ld [wD78D], a
    ld a, [wD7CB]
    add a, $E0
    ld [wD78E], a
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $0140
    add hl, de
    ld bc, $0403
    ld de, wD788
    call Func_01C_6806
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 9 of the `rst $00` table in Func_01C_4867
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wD7CA, wD7CB, wD781, wD7CC
; writes: wD7C7, wTwoChoiceCursor, wD781, wScriptCommandType, wScriptStartRequest, wD7CA, wD7CB, wD7CC
Func_01C_4867_Case09::
Jump_01C_4DE0:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 1, a
    jr nz, Jump_01C_4E05
    bit 4, a
    jr nz, Jump_01C_4E2D
    bit 5, a
    jr nz, Jump_01C_4E47
    bit 6, a
    jp nz, Jump_01C_4E57
    bit 7, a
    jp nz, Jump_01C_4ECE
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, Jump_01C_4F53
    call Func_01C_4F87
    ret

Jump_01C_4E05::
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $0140
    add hl, de
    ld bc, $0403
    ld de, vBGMap1 + $3B0
    call Func_01C_67D0
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $06
    ld [wD781], a
    xor a, a
    ld [wD7C7], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01C_4E2D::
    call Func_01C_4F9A
    ld a, [wD7CC]
    cp a, $01
    jr nz, Jump_01C_4E3A
    xor a, a
    jr Jump_01C_4E3B

Jump_01C_4E3A::
    inc a

Jump_01C_4E3B::
    ld [wD7CC], a
    call Func_01C_4F87
    ld a, $69
    call QueueSoundEffect
    ret

Jump_01C_4E47::
    call Func_01C_4F9A
    ld a, [wD7CC]
    and a, a
    jr nz, Jump_01C_4E54
    ld a, $01
    jr Jump_01C_4E3B

Jump_01C_4E54::
    dec a
    jr Jump_01C_4E3B

Jump_01C_4E57::
    ld a, $69
    call QueueSoundEffect
    ld a, [wD7CC]
    and a, a
    jr nz, Jump_01C_4E98
    ld a, [wD7CA]
    cp a, $02
    jr c, Jump_01C_4E8B
    ld a, $02
    ld [wD7CA], a
    ld a, $04
    ld [wD7CB], a
    call Func_01C_4FCF
    ret

Jump_01C_4E77::
    ld a, [wD7CB]
    cp a, $04
    jr c, Jump_01C_4E87
    ld a, $04
    ld [wD7CB], a
    call Func_01C_4FCF
    ret

Jump_01C_4E87::
    call Func_01C_4FCF
    ret

Jump_01C_4E8B::
    inc a
    ld [wD7CA], a
    cp a, $02
    jp nc, Jump_01C_4E77
    call Func_01C_4F87
    ret

Jump_01C_4E98::
    ld a, [wD7CA]
    cp a, $02
    jr c, Jump_01C_4EA3
    ld b, $04
    jr Jump_01C_4EA5

Jump_01C_4EA3::
    ld b, $09

Jump_01C_4EA5::
    ld a, [wD7CB]
    cp a, b
    jr c, Jump_01C_4EC6
    ld a, b
    cp a, $04
    jr nz, Jump_01C_4EB4
    call Func_01C_4F87
    ret

Jump_01C_4EB4::
    ld a, [wD7CA]
    and a, a
    jr nz, Jump_01C_4EBE
    ld a, $01
    jr Jump_01C_4EBF

Jump_01C_4EBE::
    xor a, a

Jump_01C_4EBF::
    ld [wD7CB], a
    call Func_01C_4F87
    ret

Jump_01C_4EC6::
    inc a
    ld [wD7CB], a
    call Func_01C_4F87
    ret

Jump_01C_4ECE::
    ld a, $69
    call QueueSoundEffect
    ld a, [wD7CC]
    and a, a
    jr nz, Jump_01C_4F18
    ld a, [wD7CA]
    and a, a
    jr nz, Jump_01C_4EFD
    ld a, [wD7CB]
    cp a, $04
    jr c, Jump_01C_4EF4
    ld a, $02
    ld [wD7CA], a
    ld a, $04
    ld [wD7CB], a
    call Func_01C_4FCF
    ret

Jump_01C_4EF4::
    ld a, $02
    ld [wD7CA], a
    call Func_01C_4F87
    ret

Jump_01C_4EFD::
    dec a
    ld [wD7CA], a
    ld a, [wD7CA]
    ld b, a
    ld a, [wD7CB]
    or a, b
    jr nz, Jump_01C_4F14
    ld a, $01
    ld [wD7CB], a
    call Func_01C_4FCF
    ret

Jump_01C_4F14::
    call Func_01C_4F87
    ret

Jump_01C_4F18::
    ld a, [wD7CA]
    and a, a
    jr nz, Jump_01C_4F27
    ld a, [wD7CB]
    cp a, $01
    jr nz, Jump_01C_4F4B
    jr Jump_01C_4F2D

Jump_01C_4F27::
    ld a, [wD7CB]
    and a, a
    jr nz, Jump_01C_4F4B

Jump_01C_4F2D::
    ld a, [wD7CA]
    cp a, $02
    jr c, Jump_01C_4F42
    ld a, $02
    ld [wD7CA], a
    ld a, $04
    ld [wD7CB], a
    call Func_01C_4FCF
    ret

Jump_01C_4F42::
    ld a, $09
    ld [wD7CB], a
    call Func_01C_4F87
    ret

Jump_01C_4F4B::
    dec a
    ld [wD7CB], a
    call Func_01C_4F87
    ret

Jump_01C_4F53::
    xor a, a
    ld [wD7C7], a
    ld a, [wD7CA]
    and a, a
    jr nz, Jump_01C_4F67
    ld a, [wD7CB]
    and a, a
    jr nz, Jump_01C_4F67
    call Func_01C_4F87
    ret

Jump_01C_4F67::
    ld a, $69
    call QueueSoundEffect
    call Func_01C_4F9A
    call Func_01C_500C
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; 11 call sites from 1 routine (e.g. Func_01C_4867_Case09)
; reads: wD7CD, wD7CC, wD7CA, wD7CB
; writes: wD7CD
Func_01C_4F87::
    ld a, [wD7CD]
    inc a
    ld [wD7CD], a
    cp a, $10
    jr c, Func_01C_4F9A
    cp a, $18
    jr c, Jump_01C_4FAD
    xor a, a
    ld [wD7CD], a

; 3 call sites from 1 routine (e.g. Func_01C_4867_Case09)
; reads: wD7CC, wD7CA, wD7CB
Func_01C_4F9A::
    ld a, [wD7CC]
    and a, a
    jr nz, Jump_01C_4FA5
    ld a, [wD7CA]
    jr Jump_01C_4FA8

Jump_01C_4FA5::
    ld a, [wD7CB]

Jump_01C_4FA8::
    add a, $E0
    ld b, a
    jr Jump_01C_4FAF

Jump_01C_4FAD::
    ld b, $CB

Jump_01C_4FAF::
    ld a, [wD7CC]
    add a, a
    ld hl, Data_01C_5008
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1C_67AF
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; 6 call sites from 1 routine (e.g. Func_01C_4867_Case09)
; reads: wD7CA, wD7CB
Func_01C_4FCF::
    ld hl, Data_01C_5008
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1C_67AF
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    ld a, [wD7CA]
    add a, $E0
    ld b, a
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ld hl, Data_01C_500A
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1C_67AF
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    ld a, [wD7CB]
    add a, $E0
    ld b, a
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

Data_01C_5008:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $61, $01

Data_01C_500A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $62, $01

; 1 call site from 1 routine (e.g. Func_01C_4867_Case09)
; reads: wD7CA, wD7CB, wD7B6, wD7B5
; writes: wD7D0, wD7CF, wD7CE
Func_01C_500C::
    ld a, [wD7CA]
    ld e, a
    ld d, $00
    ld l, a
    ld h, $00
    sla l
    rl h
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    ld a, [wD7CB]
    add a, e
    ld e, a
    jr nc, Jump_01C_5032
    inc d

Jump_01C_5032::
    push de
    call Func_01C_68DF
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
    ld e, a
    ld l, a
    ld h, $00
    ld d, $00
    sla e
    rl d
    add hl, de
    ld e, l
    ld d, h
    call Func_01C_5F26
    add hl, de
    call Func_01C_5EEC
    ld e, l
    ld d, h
    ld b, $F2
    call ReadFarPointerAtDEInBankB
    ld e, b
    pop bc
    ld a, c
    call Func_01C_6CAB
    ld a, e
    ld [wD7D0], a
    ld a, h
    ld [wD7CF], a
    ld a, l
    ld [wD7CE], a
    ret

; entry 10 of the `rst $00` table in Func_01C_4867
; no direct call (reached through a table, a jump or a vector)
; reads: wD7B6, wD7B5, hFFC9, hFFC8, hFFC7, hFFC6, wD788, wD789, ...
; writes: wD7B8, wC8C0, wC8C1, wC8C2, wD788, wD789, wD78A, wD78B, ...
; points at: wC130, wD7CE, wD788
Func_01C_4867_Case0A::
Jump_01C_507C:: ; address name
    call Func_01C_68DF
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
    ld [wD7B8], a
    ld de, wC130
    push de
    ld hl, wD7CE
    ld a, [hl+]
    ld [wC8C0], a
    ld a, [hl+]
    ld [wC8C1], a
    ld a, [hl]
    ld [wC8C2], a
    call Number24ToPackedBCD
    ldh a, [hFFC9]
    and a, $0F
    ld [wD788], a
    ldh a, [hFFC8]
    and a, $F0
    swap a
    ld [wD789], a
    ldh a, [hFFC8]
    and a, $0F
    ld [wD78A], a
    ldh a, [hFFC7]
    and a, $F0
    swap a
    ld [wD78B], a
    ldh a, [hFFC7]
    and a, $0F
    ld [wD78C], a
    ldh a, [hFFC6]
    and a, $F0
    swap a
    ld [wD78D], a
    ldh a, [hFFC6]
    and a, $0F
    ld [wD78E], a
    ld c, $00
    ld a, [wD788]
    and a, a
    jr nz, Jump_01C_512B
    ld a, $90
    ld [wD788], a
    ld a, [wD789]
    and a, a
    jr nz, Jump_01C_512B
    ld a, $90
    ld [wD789], a
    ld a, [wD78A]
    and a, a
    jr nz, Jump_01C_512B
    ld a, $90
    ld [wD78A], a
    ld a, [wD78B]
    and a, a
    jr nz, Jump_01C_512B
    ld a, $90
    ld [wD78B], a
    ld a, [wD78C]
    and a, a
    jr nz, Jump_01C_512B
    ld a, $90
    ld [wD78C], a
    ld a, [wD78D]
    and a, a
    jr nz, Jump_01C_512B
    ld a, $90
    ld [wD78D], a

Jump_01C_512B::
    pop de
    ld hl, wD788

Jump_01C_512F::
    ld a, [hl]
    cp a, $90
    jr nz, Jump_01C_5138
    inc c
    inc hl
    jr Jump_01C_512F

Jump_01C_5138::
    ld a, [hl+]
    ld [de], a
    inc de
    inc c
    ld a, c
    cp a, $07
    jr c, Jump_01C_512F
    ld a, $F0
    ld [de], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wD7D1], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 11 of the `rst $00` table in Func_01C_4867
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
Func_01C_4867_Case0B::
Jump_01C_5159:: ; address name
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $010E
    add hl, de
    push hl
    call StepBGMapAddressBackOnScrollWrap
    ld de, vBGMap1 + $3D0
    ld b, $00
    ld c, $00
    push hl

Jump_01C_516C::
    di
    call WaitForVRAMAccess
    ld a, [hl]
    ld [de], a
    ei
    inc hl
    inc de
    inc c
    ld a, c
    cp a, $06
    jp c, Jump_01C_516C
    xor a, a
    ld c, a
    pop hl
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    push hl
    inc b
    ld a, b
    cp a, $05
    jp c, Jump_01C_516C
    pop hl
    pop hl
    ld de, Data_01C_6302
    ld bc, $0605
    call Func_01C_6806
    ld a, $6C
    call QueueSoundEffect
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 12 of the `rst $00` table in Func_01C_4867
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wD781, wD7D1, wD7D0, wD7CF, wD7CE, wD7F1, ...
; writes: wD781, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wD7F3, wD7F2, wD7F1, wD7D1
Func_01C_4867_Case0C::
Jump_01C_51A7:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, Jump_01C_51C3
    bit 7, a
    jr nz, Jump_01C_51DD
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, Jump_01C_51ED
    bit 1, a
    jp nz, Jump_01C_5279
    call Func_01C_52A0
    ret

Jump_01C_51C3::
    call Func_01C_52BE
    ld a, [wD7D1]
    and a, a
    jr nz, Jump_01C_51D0
    ld a, $01
    jr Jump_01C_51D1

Jump_01C_51D0::
    dec a

Jump_01C_51D1::
    ld [wD7D1], a
    call Func_01C_52A0
    ld a, $69
    call QueueSoundEffect
    ret

Jump_01C_51DD::
    call Func_01C_52BE
    ld a, [wD7D1]
    cp a, $01
    jr c, Jump_01C_51EA
    xor a, a
    jr Jump_01C_51D1

Jump_01C_51EA::
    inc a
    jr Jump_01C_51D1

Jump_01C_51ED::
    ld a, $69
    call QueueSoundEffect
    call Func_01C_52C2
    ld a, [wD7D1]
    and a, a
    jr nz, Jump_01C_5279
    ld a, [wD7D0]
    ld [wD7F3], a
    ld a, [wD7CF]
    ld [wD7F2], a
    ld a, [wD7CE]
    ld [wD7F1], a
    call IsAmountInWD7F1AboveGold
    ld a, [wD7F1]
    cp a, $FF
    jp z, Jump_01C_525D
    ld a, [wD7CA]
    ld e, a
    ld d, $00
    ld l, a
    ld h, $00
    sla l
    rl h
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    ld a, [wD7CB]
    add a, e
    ld e, a
    jr nc, Jump_01C_523E
    inc d

Jump_01C_523E::
    ld a, [wD7B0]
    add a, e
    cp a, $19
    jr nc, Jump_01C_5263
    ld a, $02
    ld [wTwoChoiceCursor], a
    ld a, [wD781]
    inc a
    inc a
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01C_525D::
    xor a, a
    ld [wTwoChoiceCursor], a
    jr Jump_01C_5268

Jump_01C_5263::
    ld a, $01
    ld [wTwoChoiceCursor], a

Jump_01C_5268::
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01C_5279::
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $010E
    add hl, de
    ld bc, $0605
    ld de, vBGMap1 + $3D0
    call Func_01C_6806
    ld a, [wD781]
    sub a, $03
    ld [wD781], a
    ld a, $03
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; 2 call sites from 1 routine (e.g. Func_01C_4867_Case0C)
; reads: wJoypadRepeatTimer, wD7D2, wD7D1
; writes: wD7D2
Func_01C_52A0::
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, Jump_01C_52BA
    ld a, [wD7D2]
    inc a
    ld [wD7D2], a
    cp a, $10
    jr c, Jump_01C_52BA
    cp a, $18
    jr c, Func_01C_52BE
    xor a, a
    ld [wD7D2], a

Jump_01C_52BA::
    ld b, $BB
    jr Jump_01C_52C4

; 2 call sites from 1 routine (e.g. Func_01C_4867_Case0C)
; reads: wD7D1
Func_01C_52BE::
    ld b, $C3
    jr Jump_01C_52C4

; 1 call site from 1 routine (e.g. Func_01C_4867_Case0C)
; reads: wD7D1
Func_01C_52C2::
    ld b, $BC

Jump_01C_52C4::
    ld a, [wD7D1]
    add a, a
    ld hl, Data_01C_52E4
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1C_67AF
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

Data_01C_52E4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2F, $01, $6F, $01

; 1 call site from 1 routine (e.g. Func_01C_4867_Case0F)
; writes: wD781, wScriptCommandType, wScriptStartRequest
Func_01C_52E8::
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $010E
    add hl, de
    ld bc, $0605
    ld de, vBGMap1 + $3D0
    call Func_01C_6806
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $0140
    add hl, de
    ld bc, $0403
    ld de, vBGMap1 + $3B0
    call Func_01C_67D0
    ld a, $06
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 15 of the `rst $00` table in Func_01C_4867
; no direct call (reached through a table, a jump or a vector)
; writes: wD781
Func_01C_4867_Case0F::
Jump_01C_5317:: ; address name
    call Func_01C_52E8
    ld a, $10
    ld [wD781], a
    ret

; entry 16 of the `rst $00` table in Func_01C_4867
; no direct call (reached through a table, a jump or a vector)
; reads: wD7B6
; writes: wD781, wD7B5, wD7B6
Func_01C_4867_Case10::
Jump_01C_5320:: ; address name
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $00A2
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    ld b, $04

Jump_01C_532C::
    di
    call WaitForVRAMAccess
    ld a, $C3
    ld [hl], a
    ei
    ld a, l
    add a, $40
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec b
    jr nz, Jump_01C_532C
    ld a, [wD7B6]
    and a, a
    jr nz, Jump_01C_5349
    ld a, $06
    jr Jump_01C_534A

Jump_01C_5349::
    xor a, a

Jump_01C_534A::
    ld [wD781], a
    xor a, a
    ld [wD7B5], a
    ld [wD7B6], a
    ret

; entry 14 of the `rst $00` table in Func_01C_4867
; no direct call (reached through a table, a jump or a vector)
; reads: wD7D0, wD7CF, wD7CE, wD7CA, wD7CB, wD7B6, wD7B5, wD7B0, ...
; writes: wD7F3, wD7F2, wD7F1, wD7B8, wD780, wD781, wD7B5, wD7B6, ...
; points at: wInventory, wD788, wD792
Func_01C_4867_Case0E::
Jump_01C_5355:: ; address name
    ld a, [wD7D0]
    ld [wD7F3], a
    ld a, [wD7CF]
    ld [wD7F2], a
    ld a, [wD7CE]
    ld [wD7F1], a
    farcall SubtractWD7F1AmountFromGold
    ld a, [wD7CA]
    ld e, a
    ld d, $00
    ld l, a
    ld h, $00
    sla l
    rl h
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    ld a, [wD7CB]
    add a, e
    ld e, a
    jr nc, Jump_01C_5393
    inc d

Jump_01C_5393::
    push de
    call Func_01C_68DF
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
    ld [wD7B8], a
    pop de
    push de
    ld a, e
    ld c, a
    ld hl, wInventory
    ld b, $00

Jump_01C_53BB::
    ld a, [hl]
    and a, a
    jr z, Jump_01C_53CC
    cp a, $FF
    jr z, Jump_01C_53CC
    inc hl
    inc b

Jump_01C_53C5::
    ld a, b
    cp a, $18
    jr c, Jump_01C_53BB
    jr Jump_01C_53D9

Jump_01C_53CC::
    ld a, [wD7B8]
    ld [hl], a
    inc hl
    inc b
    dec c
    ld a, c
    and a, a
    jr z, Jump_01C_53D9
    jr Jump_01C_53C5

Jump_01C_53D9::
    pop de
    ld a, [wD7B0]
    add a, e
    cp a, $18
    jr c, Jump_01C_5400
    ld a, $01
    ld [wD780], a
    ld a, $01
    ld [wD781], a
    xor a, a
    ld [wD7B5], a
    ld [wD7B6], a
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01C_5400::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld hl, wD788
    ld de, Data_01C_5F5E
    ld bc, $0020

Jump_01C_5415::
    ld a, [de]
    ld [hl+], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_01C_5415
    ld hl, wD792
    call Func_01C_4395
    ld hl, wInventory
    ld c, $00
    ld b, $00

Jump_01C_542A::
    ld a, [hl+]
    and a, a
    jr z, Jump_01C_5433
    cp a, $FF
    jr z, Jump_01C_5433
    inc b

Jump_01C_5433::
    inc c
    ld a, c
    cp a, $18
    jr c, Jump_01C_542A
    ld a, b
    ld [wD7B0], a
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    ld a, [wC8C1]
    and a, a
    jr z, Jump_01C_5451
    ld a, [wC8C1]
    add a, $E0
    ld [wD7A5], a

Jump_01C_5451::
    ld a, [wC8C2]
    add a, $E0
    ld [wD7A6], a
    call BGMapAddressAtScroll_Bank1C_67AF
    ld a, $0C
    add_a_to_hl
    ld de, wD788
    ld bc, $0804
    call Func_01C_6806
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 4 of the `rst $00` table in ScriptCommandE2_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
ScriptCommandE2_Run_Case04::
Jump_01C_5476:: ; address name
    ld a, [wD781]
    rst $00
    dw Func_01C_4867_Case00
    dw Func_01C_4867_Case01
    dw Func_01C_52E8_Case02
    dw Func_01C_52E8_Case03
    dw Func_01C_52E8_Case04
    dw Func_01C_52E8_Case05
    dw Func_01C_52E8_Case06
    dw Func_01C_52E8_Case07
    dw Func_01C_52E8_Case08
    dw Func_01C_52E8_Case09
    dw Func_01C_4867_Case0B
    dw Func_01C_52E8_Case0B
    dw Func_01C_52E8_Case0C
    dw Func_01C_52E8_Case0D

; entry 2 of the `rst $00` table in Func_01C_52E8
; no direct call (reached through a table, a jump or a vector)
; reads: wD7B6, wD7BB, wC8C1, wC8C2, wD781, wD7B5
; writes: wD7B0, wD7BB, wD7B6, wD7B7, wC8C1, wD781, wD783, wD784, ...
; points at: wInventory, wD7D5
Func_01C_52E8_Case02::
Jump_01C_5496:: ; address name
    ld hl, wInventory
    ld b, $00
    ld c, $00

Jump_01C_549D::
    ld a, [hl]
    and a, a
    jr z, Jump_01C_54A6
    cp a, $FF
    jr z, Jump_01C_54A6
    inc c

Jump_01C_54A6::
    inc hl
    inc b
    ld a, b
    cp a, $18
    jr c, Jump_01C_549D
    ld a, c
    ld [wD7B0], a
    call Func_01C_689A
    ld hl, wD7D5
    ld b, $00
    ld c, $00

Jump_01C_54BB::
    ld a, [hl]
    and a, a
    jr z, Jump_01C_54C0
    inc c

Jump_01C_54C0::
    inc hl
    inc b
    ld a, b
    cp a, $18
    jr c, Jump_01C_54BB
    ld a, c
    ld l, a
    ld h, $00
    ld a, $04
    call DivideHLByA
    push af
    and a, a
    jr z, Jump_01C_54D5
    inc l

Jump_01C_54D5::
    ld a, l
    ld [wD7BB], a
    ld a, [wD7B6]
    inc a
    cp a, l
    jr c, Jump_01C_5510
    pop af
    push af
    and a, a
    jr nz, Jump_01C_54F5
    ld a, [wD7B6]
    inc a
    cp a, l
    jr z, Jump_01C_5510
    ld a, [wD7B6]
    dec a
    ld [wD7B6], a
    jr Jump_01C_5510

Jump_01C_54F5::
    pop af
    dec a
    ld [wD7B7], a
    ld b, a
    ld a, [wD7B5]
    cp a, b
    jr c, Jump_01C_5516
    jr z, Jump_01C_5516
    push bc
    push hl
    call EraseWD7B5Cursor
    pop hl
    pop bc
    ld a, b
    ld [wD7B5], a
    jr Jump_01C_5516

Jump_01C_5510::
    pop af
    ld a, $03
    ld [wD7B7], a

Jump_01C_5516::
    ld a, [wD7BB]
    cp a, $02
    jr c, Jump_01C_5561
    call Func_01C_6C78
    call HLToDecimalDigits
    ld a, [wC8C1]
    and a, a
    jr nz, Jump_01C_552E
    ld a, $E3
    ld [wC8C1], a

Jump_01C_552E::
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $0191
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, [wC8C2]
    add a, $E0
    ld [hl], a
    ei
    ld a, [wD7B6]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $018F
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, [wC8C2]
    add a, $E1
    ld [hl], a
    ei

Jump_01C_5561::
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wD783], a
    ld [wD784], a
    ret

; entry 3 of the `rst $00` table in Func_01C_52E8
; no direct call (reached through a table, a jump or a vector)
; reads: wD783, wD784, wD7B6, wD7B8, wD781
; writes: wD784, wD7B8, wD783, wD781
; points at: wD7D5
Func_01C_52E8_Case03::
Jump_01C_5570:: ; address name
    ld a, [wD783]
    add a, a
    ld hl, Data_01C_6289
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]

Jump_01C_557F::
    push de
    ld a, [wD784]
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_01C_5589
    inc d

Jump_01C_5589::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld de, Data_01F_4910
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    pop de
    ld a, [wD784]
    inc a
    ld [wD784], a
    cp a, $09
    jr c, Jump_01C_557F
    xor a, a
    ld [wD784], a
    ld hl, wD7D5
    ld a, [wD7B6]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, [wD783]
    add_a_to_hl
    ld a, [hl]
    ld e, a
    ld d, $00
    sla e
    rl d
    ld hl, Data_01C_63FE
    add hl, de
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e

Jump_01C_55D2::
    ld a, [hl]
    cp a, $F0
    jp z, Jump_01C_564E
    ld [wD7B8], a
    push hl
    ld hl, $4010
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    push de
    ld a, [wD783]
    add a, a
    ld de, Data_01C_6289
    add a, e
    ld e, a
    jr nc, Jump_01C_5604
    inc d

Jump_01C_5604::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, [wD7B8]
    cp a, $8D
    jr z, Jump_01C_5616
    cp a, $8E
    jr z, Jump_01C_5616
    jr Jump_01C_561D

Jump_01C_5616::
    ld a, [wD784]
    dec a
    ld [wD784], a

Jump_01C_561D::
    ld a, [wD784]
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    pop de
    ld b, $1F
    ld c, $10
    ld a, [wD7B8]
    cp a, $8D
    jr z, Jump_01C_563F
    cp a, $8E
    jr z, Jump_01C_563F
    call CopyFromBankWaitVRAM
    jr Jump_01C_5642

Jump_01C_563F::
    call OrFromBankWaitVRAM

Jump_01C_5642::
    pop hl
    inc hl
    ld a, [wD784]
    inc a
    ld [wD784], a
    jp Jump_01C_55D2

Jump_01C_564E::
    xor a, a
    ld [wD784], a
    ld a, [wD783]
    inc a
    ld [wD783], a
    cp a, $04
    jr c, Jump_01C_5669
    xor a, a
    ld [wD783], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01C_5669::
    ret

; entry 4 of the `rst $00` table in Func_01C_52E8
; no direct call (reached through a table, a jump or a vector)
; reads: wD7B6, wD783, hFFC7, hFFC6, wD7BD, wD7BE, wD7BF, wD7C0, ...
; writes: wC8C0, wC8C1, wC8C2, wD7BD, wD7BE, wD7BF, wD7C0, wD7C1, ...
; points at: wD7D5, wD7BD
Func_01C_52E8_Case04::
Jump_01C_566A:: ; address name
    ld hl, wD7D5
    ld a, [wD7B6]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    add hl, de

Jump_01C_567C::
    push hl
    ld a, [wD783]
    add_a_to_hl
    ld a, [hl]
    ld e, a
    ld d, $00
    sla e
    rl d
    call Func_01C_5F3E
    ld a, l
    ld [wC8C0], a
    ld a, h
    ld [wC8C1], a
    xor a, a
    ld [wC8C2], a
    call Number24ToPackedBCD
    ldh a, [hFFC7]
    and a, $F0
    swap a
    ld [wD7BD], a
    ldh a, [hFFC7]
    and a, $0F
    ld [wD7BE], a
    ldh a, [hFFC6]
    and a, $F0
    swap a
    ld [wD7BF], a
    ldh a, [hFFC6]
    and a, $0F
    ld [wD7C0], a
    ld a, [wD7BD]
    and a, a
    jr nz, Jump_01C_56F2
    add a, $E3
    ld [wD7BD], a
    ld a, [wD7BE]
    and a, a
    jr nz, Jump_01C_56F2
    add a, $E3
    ld [wD7BE], a
    ld a, [wD7BF]
    and a, a
    jr nz, Jump_01C_56F2
    add a, $E3
    ld [wD7BF], a
    ld a, [wD7C0]
    and a, a
    jr nz, Jump_01C_56F2
    add a, $E3
    ld [wD7C0], a
    ld a, $E3
    ld [wD7C1], a
    jr Jump_01C_56F7

Jump_01C_56F2::
    ld a, $DF
    ld [wD7C1], a

Jump_01C_56F7::
    ld hl, Data_01C_62D9
    ld a, [wD783]
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1C_67AF
    pop de
    add hl, de
    ld e, l
    ld d, h
    xor a, a
    ld [wD7EE], a
    ld hl, wD7BD
    ld c, $00

Jump_01C_5717::
    ld a, [wD7EE]
    and a, a
    jr nz, Jump_01C_572F
    push hl
    ld l, e
    ld h, d
    call StepBGMapAddressBackOnScrollWrap
    cp a, $FF
    jr nz, Jump_01C_572C
    ld a, $01
    ld [wD7EE], a

Jump_01C_572C::
    ld e, l
    ld d, h
    pop hl

Jump_01C_572F::
    di
    call WaitForVRAMAccess
    ld a, [hl+]
    add a, $E0
    ld [de], a
    inc de
    ei
    inc c
    ld a, c
    cp a, $05
    jr c, Jump_01C_5717
    pop hl
    ld a, [wD783]
    inc a
    ld [wD783], a
    cp a, $04
    jp c, Jump_01C_567C
    xor a, a
    ld [wD783], a
    ld [wD784], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 5 of the `rst $00` table in Func_01C_52E8
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wD7C2, wD781, wD7B7, wD7B5, wD7BB, wD7B6
; writes: wD7C7, wD780, wD781, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wD7B4, wD7B5, ...
Func_01C_52E8_Case05::
Jump_01C_575B:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 4, a
    jr nz, Jump_01C_57AA
    bit 5, a
    jr nz, Jump_01C_57D5
    bit 6, a
    jp nz, Jump_01C_57F0
    bit 7, a
    jp nz, Jump_01C_581C
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, Jump_01C_583C
    call Func_01C_4C87
    call Func_01C_6AF7
    ld a, [wD7C2]
    cp a, $03
    ret c
    ld a, [wJoypadPressedRepeat]
    bit 1, a
    ret z
    call ResetWD7C2Counters
    xor a, a
    ld [wD7C7], a
    ld a, $01
    ld [wD780], a
    ld a, $01
    ld [wD781], a
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01C_57AA::
    ld a, [wD7BB]
    cp a, $02
    jr c, Jump_01C_57C8
    call ResetWD7C2Counters
    ld a, [wD7BB]
    ld b, a
    ld a, [wD7B6]
    inc a
    cp a, b
    jr c, Jump_01C_57C0
    xor a, a

Jump_01C_57C0::
    ld [wD7B6], a
    ld a, $02
    ld [wD781], a

Jump_01C_57C8::
    xor a, a
    ld [wD7B4], a
    call DrawWD7B5Cursor
    ld a, $69
    call QueueSoundEffect
    ret

Jump_01C_57D5::
    ld a, [wD7BB]
    cp a, $02
    jr c, Jump_01C_57C8
    call ResetWD7C2Counters
    ld a, [wD7B6]
    and a, a
    jr nz, Jump_01C_57EC
    ld a, [wD7BB]
    dec a
    jp Jump_01C_57C0

Jump_01C_57EC::
    dec a
    jp Jump_01C_57C0

Jump_01C_57F0::
    xor a, a
    ld [wD7B4], a
    ld a, [wD7B7]
    and a, a
    jr z, Jump_01C_580F
    call ResetWD7C2Counters
    call EraseWD7B5Cursor
    ld a, [wD7B5]
    and a, a
    jr nz, Jump_01C_580B
    ld a, [wD7B7]
    jr Jump_01C_580C

Jump_01C_580B::
    dec a

Jump_01C_580C::
    ld [wD7B5], a

Jump_01C_580F::
    xor a, a
    ld [wD7B4], a
    call DrawWD7B5Cursor
    ld a, $69
    call QueueSoundEffect
    ret

Jump_01C_581C::
    xor a, a
    ld [wD7B4], a
    ld a, [wD7B7]
    and a, a
    jr z, Jump_01C_580F
    call ResetWD7C2Counters
    call EraseWD7B5Cursor
    ld a, [wD7B7]
    ld b, a
    ld a, [wD7B5]
    cp a, b
    jr c, Jump_01C_5839
    xor a, a
    jr Jump_01C_580C

Jump_01C_5839::
    inc a
    jr Jump_01C_580C

Jump_01C_583C::
    ld a, $69
    call QueueSoundEffect
    call DrawWD7B5CursorConfirmed
    call ResetWD7C2Counters
    xor a, a
    ld [wD7C7], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 6 of the `rst $00` table in Func_01C_52E8
; no direct call (reached through a table, a jump or a vector)
; reads: wD7B6, wD7B5, wD781
; writes: wD781, wD7C7, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wD7CD, wD7CA, wD7CB, ...
; points at: wD7D5
Func_01C_52E8_Case06::
Jump_01C_5853:: ; address name
    call ResetWD7C2Counters
    ld hl, wD7D5
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
    ld e, a
    ld d, $00
    sla e
    rl d
    call Func_01C_5F3E
    ld a, l
    and a, a
    jr nz, Jump_01C_589D
    ld a, h
    and a, a
    jr nz, Jump_01C_589D
    ld a, [wD781]
    dec a
    ld [wD781], a
    xor a, a
    ld [wD7C7], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01C_589D::
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ld [wD7CD], a
    ld [wD7CA], a
    ld a, $01
    ld [wD7CB], a
    ld [wD7CC], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 7 of the `rst $00` table in Func_01C_52E8
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wD7CA, wD7CB, wD7D3, wD7D4, wD781
; writes: wD7CA, wD7CB, wD790, wD791, wD793, wD794, wD781
; points at: wD788
Func_01C_52E8_Case07::
Jump_01C_58C0:: ; address name
    xor a, a
    ld [wD7CA], a
    ld a, $01
    ld [wD7CB], a
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $0140
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    ld de, vBGMap1 + $3B0
    ld b, $00
    ld c, $00
    push hl
    push hl

Jump_01C_58DC::
    di
    call WaitForVRAMAccess
    ld a, [hl]
    ld [de], a
    ei
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_01C_58FD
    push bc
    ld c, $4F
    ld a, $01
    ldh [c], a
    pop bc
    di
    call WaitForVRAMAccess
    ld a, [hl]
    ld [de], a
    ei
    push bc
    ld c, $4F
    xor a, a
    ldh [c], a
    pop bc

Jump_01C_58FD::
    inc hl
    inc de
    inc c
    ld a, c
    cp a, $07
    jp c, Jump_01C_58DC
    xor a, a
    ld c, a
    pop hl
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    push hl
    inc b
    ld a, b
    cp a, $03
    jp c, Jump_01C_58DC
    pop hl
    pop hl
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_01C_5954
    push bc
    ld c, $4F
    ld a, $01
    ldh [c], a
    pop bc
    di
    call WaitForVRAMAccess
    xor a, a
    ld [hl], a
    ei
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    di
    call WaitForVRAMAccess
    xor a, a
    ld [hl], a
    ei
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    di
    call WaitForVRAMAccess
    xor a, a
    ld [hl], a
    ei
    push bc
    ld c, $4F
    ld a, $00
    ldh [c], a
    pop bc

Jump_01C_5954::
    ld hl, wD788
    ld de, Data_01C_62ED
    ld bc, $0015

Jump_01C_595D::
    ld a, [de]
    ld [hl+], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_01C_595D
    ld a, [wD7CA]
    add a, $E0
    ld [wD790], a
    ld a, [wD7CB]
    add a, $E0
    ld [wD791], a
    call Func_01C_6999
    ld a, [wD7D3]
    and a, a
    jr nz, Jump_01C_5985
    ld a, $C3
    ld [wD793], a
    jr Jump_01C_598D

Jump_01C_5985::
    ld a, [wD7D3]
    add a, $E0
    ld [wD793], a

Jump_01C_598D::
    ld a, [wD7D4]
    add a, $E0
    ld [wD794], a
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $0140
    add hl, de
    ld bc, $0703
    ld de, wD788
    call Func_01C_6806
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 8 of the `rst $00` table in Func_01C_52E8
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wD7CA, wD7CB, wD781, wD7CC, wD7D4, wD7D3
; writes: wTwoChoiceCursor, wD7C7, wD781, wD7CA, wD7CB, wD7CC, wScriptCommandType, wScriptStartRequest
Func_01C_52E8_Case08::
Jump_01C_59AD:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 1, a
    jr nz, Jump_01C_59D2
    bit 4, a
    jr nz, Jump_01C_59FA
    bit 5, a
    jr nz, Jump_01C_5A0F
    bit 6, a
    jp nz, Jump_01C_5A1F
    bit 7, a
    jp nz, Jump_01C_5AA6
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, Jump_01C_5B36
    call Func_01C_5B61
    ret

Jump_01C_59D2::
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $0140
    add hl, de
    ld bc, $0703
    ld de, vBGMap1 + $3B0
    call Func_01C_67D0
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $05
    ld [wD781], a
    xor a, a
    ld [wD7C7], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01C_59FA::
    call Func_01C_5B74
    ld a, [wD7CC]
    cp a, $01
    jr nz, Jump_01C_5A07
    xor a, a
    jr Jump_01C_5A08

Jump_01C_5A07::
    inc a

Jump_01C_5A08::
    ld [wD7CC], a
    call Func_01C_5B61
    ret

Jump_01C_5A0F::
    call Func_01C_5B74
    ld a, [wD7CC]
    and a, a
    jr nz, Jump_01C_5A1C
    ld a, $01
    jr Jump_01C_5A08

Jump_01C_5A1C::
    dec a
    jr Jump_01C_5A08

Jump_01C_5A1F::
    ld a, $69
    call QueueSoundEffect
    ld a, [wD7CC]
    and a, a
    jr nz, Jump_01C_5A6A
    ld a, [wD7D3]
    ld b, a
    ld a, [wD7CA]
    cp a, b
    jr c, Jump_01C_5A58
    ld a, b
    ld [wD7CA], a
    ld a, [wD7D4]
    ld [wD7CB], a
    call Func_01C_5BA9
    ret

Jump_01C_5A42::
    ld a, [wD7D4]
    ld b, a
    ld a, [wD7CB]
    cp a, b
    jr c, Jump_01C_5A54
    ld a, b
    ld [wD7CB], a
    call Func_01C_5BA9
    ret

Jump_01C_5A54::
    call Func_01C_5BA9
    ret

Jump_01C_5A58::
    inc a
    ld [wD7CA], a
    push af
    ld a, [wD7D3]
    ld b, a
    pop af
    cp a, b
    jp nc, Jump_01C_5A42
    call Func_01C_5B61
    ret

Jump_01C_5A6A::
    ld a, [wD7D3]
    ld b, a
    ld a, [wD7CA]
    cp a, b
    jr c, Jump_01C_5A7A
    ld a, [wD7D4]
    ld b, a
    jr Jump_01C_5A7C

Jump_01C_5A7A::
    ld b, $09

Jump_01C_5A7C::
    ld a, [wD7CB]
    cp a, b
    jr c, Jump_01C_5A9E
    ld a, [wD7D4]
    cp a, b
    jr nz, Jump_01C_5A8C
    call Func_01C_5B61
    ret

Jump_01C_5A8C::
    ld a, [wD7CA]
    and a, a
    jr nz, Jump_01C_5A96
    ld a, $01
    jr Jump_01C_5A97

Jump_01C_5A96::
    xor a, a

Jump_01C_5A97::
    ld [wD7CB], a
    call Func_01C_5B61
    ret

Jump_01C_5A9E::
    inc a
    ld [wD7CB], a
    call Func_01C_5B61
    ret

Jump_01C_5AA6::
    ld a, $69
    call QueueSoundEffect
    ld a, [wD7CC]
    and a, a
    jr nz, Jump_01C_5AF6
    ld a, [wD7CA]
    and a, a
    jr nz, Jump_01C_5ADB
    ld a, [wD7D4]
    ld b, a
    ld a, [wD7CB]
    cp a, b
    jr c, Jump_01C_5AD1
    ld a, [wD7D3]
    ld [wD7CA], a
    ld a, [wD7D4]
    ld [wD7CB], a
    call Func_01C_5BA9
    ret

Jump_01C_5AD1::
    ld a, [wD7D3]
    ld [wD7CA], a
    call Func_01C_5B61
    ret

Jump_01C_5ADB::
    dec a
    ld [wD7CA], a
    ld a, [wD7CA]
    ld b, a
    ld a, [wD7CB]
    or a, b
    jr nz, Jump_01C_5AF2
    ld a, $01
    ld [wD7CB], a
    call Func_01C_5BA9
    ret

Jump_01C_5AF2::
    call Func_01C_5B61
    ret

Jump_01C_5AF6::
    ld a, [wD7CA]
    and a, a
    jr nz, Jump_01C_5B05
    ld a, [wD7CB]
    cp a, $01
    jr nz, Jump_01C_5B2E
    jr Jump_01C_5B0B

Jump_01C_5B05::
    ld a, [wD7CB]
    and a, a
    jr nz, Jump_01C_5B2E

Jump_01C_5B0B::
    ld a, [wD7D3]
    ld b, a
    ld a, [wD7CA]
    cp a, b
    jr c, Jump_01C_5B25
    ld a, [wD7D3]
    ld [wD7CA], a
    ld a, [wD7D4]
    ld [wD7CB], a
    call Func_01C_5BA9
    ret

Jump_01C_5B25::
    ld a, $09
    ld [wD7CB], a
    call Func_01C_5B61
    ret

Jump_01C_5B2E::
    dec a
    ld [wD7CB], a
    call Func_01C_5B61
    ret

Jump_01C_5B36::
    ld a, [wD7CA]
    and a, a
    jr nz, Jump_01C_5B46
    ld a, [wD7CB]
    and a, a
    jr nz, Jump_01C_5B46
    call Func_01C_5B74
    ret

Jump_01C_5B46::
    ld a, $69
    call QueueSoundEffect
    call Func_01C_5B74
    call Func_01C_5BE6
    xor a, a
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wD7C7], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; 10 call sites from 1 routine (e.g. Func_01C_52E8_Case08)
; reads: wD7CD, wD7CC, wD7CA, wD7CB
; writes: wD7CD
Func_01C_5B61::
    ld a, [wD7CD]
    inc a
    ld [wD7CD], a
    cp a, $10
    jr c, Func_01C_5B74
    cp a, $18
    jr c, Jump_01C_5B87
    xor a, a
    ld [wD7CD], a

; 4 call sites from 1 routine (e.g. Func_01C_52E8_Case08)
; reads: wD7CC, wD7CA, wD7CB
Func_01C_5B74::
    ld a, [wD7CC]
    and a, a
    jr nz, Jump_01C_5B7F
    ld a, [wD7CA]
    jr Jump_01C_5B82

Jump_01C_5B7F::
    ld a, [wD7CB]

Jump_01C_5B82::
    add a, $E0
    ld b, a
    jr Jump_01C_5B89

Jump_01C_5B87::
    ld b, $CB

Jump_01C_5B89::
    ld a, [wD7CC]
    add a, a
    ld hl, Data_01C_5008
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1C_67AF
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; 6 call sites from 1 routine (e.g. Func_01C_52E8_Case08)
; reads: wD7CA, wD7CB
Func_01C_5BA9::
    ld hl, Data_01C_5008
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1C_67AF
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    ld a, [wD7CA]
    add a, $E0
    ld b, a
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ld hl, Data_01C_5BE4
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1C_67AF
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    ld a, [wD7CB]
    add a, $E0
    ld b, a
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret
    db $61, $01

Data_01C_5BE4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $62, $01

; 1 call site from 1 routine (e.g. Func_01C_52E8_Case08)
; reads: wD7CA, wD7CB, wD7B6, wD7B5
; writes: wD7D0, wD7CF, wD7CE
; points at: wD7D5
Func_01C_5BE6::
    ld a, [wD7CA]
    ld e, a
    ld d, $00
    ld l, a
    ld h, $00
    sla l
    rl h
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    ld a, [wD7CB]
    add a, e
    ld e, a
    jr nc, Jump_01C_5C0C
    inc d

Jump_01C_5C0C::
    push de
    ld hl, wD7D5
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
    ld e, a
    ld d, $00
    sla e
    rl d
    call Func_01C_5F3E
    ld c, l
    ld b, h
    pop de
    ld a, e
    call Multiply8By16
    ld a, e
    ld [wD7D0], a
    ld a, h
    ld [wD7CF], a
    ld a, l
    ld [wD7CE], a
    ret

; entry 9 of the `rst $00` table in Func_01C_52E8
; no direct call (reached through a table, a jump or a vector)
; reads: wD7B6, wD7B5, hFFC8, hFFC7, hFFC6, wD788, wD789, wD78A, ...
; writes: wD7B8, wC8C0, wC8C1, wC8C2, wD788, wD789, wD78A, wD78B, ...
; points at: wD7D5, wC130, wD7CE, wD788
Func_01C_52E8_Case09::
Jump_01C_5C46:: ; address name
    ld hl, wD7D5
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
    ld [wD7B8], a
    ld de, wC130
    push de
    ld hl, wD7CE
    ld a, [hl+]
    ld [wC8C0], a
    ld a, [hl+]
    ld [wC8C1], a
    ld a, [hl]
    ld [wC8C2], a
    call Number24ToPackedBCD
    ldh a, [hFFC8]
    and a, $F0
    swap a
    ld [wD788], a
    ldh a, [hFFC8]
    and a, $0F
    ld [wD789], a
    ldh a, [hFFC7]
    and a, $F0
    swap a
    ld [wD78A], a
    ldh a, [hFFC7]
    and a, $0F
    ld [wD78B], a
    ldh a, [hFFC6]
    and a, $F0
    swap a
    ld [wD78C], a
    ldh a, [hFFC6]
    and a, $0F
    ld [wD78D], a
    ld c, $00
    ld a, [wD788]
    and a, a
    jr nz, Jump_01C_5CE3
    ld a, $90
    ld [wD788], a
    ld a, [wD789]
    and a, a
    jr nz, Jump_01C_5CE3
    ld a, $90
    ld [wD789], a
    ld a, [wD78A]
    and a, a
    jr nz, Jump_01C_5CE3
    ld a, $90
    ld [wD78A], a
    ld a, [wD78B]
    and a, a
    jr nz, Jump_01C_5CE3
    ld a, $90
    ld [wD78B], a
    ld a, [wD78C]
    and a, a
    jr nz, Jump_01C_5CE3
    ld a, $90
    ld [wD78C], a

Jump_01C_5CE3::
    pop de
    ld hl, wD788
    ld c, $00

Jump_01C_5CE9::
    ld a, [hl]
    cp a, $90
    jr nz, Jump_01C_5CF2
    inc c
    inc hl
    jr Jump_01C_5CE9

Jump_01C_5CF2::
    ld a, [hl+]
    ld [de], a
    inc de
    inc c
    ld a, c
    cp a, $06
    jr c, Jump_01C_5CE9
    ld a, $F0
    ld [de], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wD7D1], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 11 of the `rst $00` table in Func_01C_52E8
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wD781, wD7D1
; writes: wD781, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wD7D1
Func_01C_52E8_Case0B::
Jump_01C_5D13:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, Jump_01C_5D2F
    bit 7, a
    jr nz, Jump_01C_5D49
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, Jump_01C_5D59
    bit 1, a
    jp nz, Jump_01C_5D7D
    call Func_01C_5DA4
    ret

Jump_01C_5D2F::
    call Func_01C_5DC2
    ld a, [wD7D1]
    and a, a
    jr nz, Jump_01C_5D3C
    ld a, $01
    jr Jump_01C_5D3D

Jump_01C_5D3C::
    dec a

Jump_01C_5D3D::
    ld [wD7D1], a
    call Func_01C_5DA4
    ld a, $69
    call QueueSoundEffect
    ret

Jump_01C_5D49::
    call Func_01C_5DC2
    ld a, [wD7D1]
    cp a, $01
    jr c, Jump_01C_5D56
    xor a, a
    jr Jump_01C_5D3D

Jump_01C_5D56::
    inc a
    jr Jump_01C_5D3D

Jump_01C_5D59::
    ld a, $69
    call QueueSoundEffect
    call Func_01C_5DC6
    ld a, [wD7D1]
    and a, a
    jr nz, Jump_01C_5D7D
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wD781]
    inc a
    inc a
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01C_5D7D::
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $010E
    add hl, de
    ld bc, $0605
    ld de, vBGMap1 + $3D0
    call Func_01C_6806
    ld a, [wD781]
    sub a, $03
    ld [wD781], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; 2 call sites from 1 routine (e.g. Func_01C_52E8_Case0B)
; reads: wJoypadRepeatTimer, wD7D2, wD7D1
; writes: wD7D2
Func_01C_5DA4::
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, Jump_01C_5DBE
    ld a, [wD7D2]
    inc a
    ld [wD7D2], a
    cp a, $10
    jr c, Jump_01C_5DBE
    cp a, $18
    jr c, Func_01C_5DC2
    xor a, a
    ld [wD7D2], a

Jump_01C_5DBE::
    ld b, $BB
    jr Jump_01C_5DC8

; 2 call sites from 1 routine (e.g. Func_01C_52E8_Case0B)
; reads: wD7D1
Func_01C_5DC2::
    ld b, $C3
    jr Jump_01C_5DC8

; 1 call site from 1 routine (e.g. Func_01C_52E8_Case0B)
; reads: wD7D1
Func_01C_5DC6::
    ld b, $BC

Jump_01C_5DC8::
    ld a, [wD7D1]
    add a, a
    ld hl, Data_01C_5DE8
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1C_67AF
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

Data_01C_5DE8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2F, $01, $6F, $01

; entry 12 of the `rst $00` table in Func_01C_52E8
; no direct call (reached through a table, a jump or a vector)
; writes: wD781, wScriptCommandType, wScriptStartRequest
Func_01C_52E8_Case0C::
Jump_01C_5DEC:: ; address name
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $010E
    add hl, de
    ld bc, $0605
    ld de, vBGMap1 + $3D0
    call Func_01C_6806
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $0140
    add hl, de
    ld bc, $0703
    ld de, vBGMap1 + $3B0
    call Func_01C_67D0
    ld a, $01
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 13 of the `rst $00` table in Func_01C_52E8
; no direct call (reached through a table, a jump or a vector)
; reads: wD7D0, wD7CF, wD7CE, wD781, wC8C1, wC8C2
; writes: wD7F3, wD7F2, wD7F1, wD7B0, wD780, wD781, wTwoChoiceCursor, wD7B5, ...
; points at: wInventory, wD788, wD792
Func_01C_52E8_Case0D::
Jump_01C_5E1B:: ; address name
    ld a, [wD7D0]
    ld [wD7F3], a
    ld a, [wD7CF]
    ld [wD7F2], a
    ld a, [wD7CE]
    ld [wD7F1], a
    call Func_01C_45B0
    call Func_01C_6919
    ld hl, wInventory
    ld b, $00
    ld c, $00

Jump_01C_5E3A::
    ld a, [hl]
    and a, a
    jr z, Jump_01C_5E43
    cp a, $FF
    jr z, Jump_01C_5E43
    inc c

Jump_01C_5E43::
    inc hl
    inc b
    ld a, b
    cp a, $18
    jr c, Jump_01C_5E3A
    ld a, c
    ld [wD7B0], a
    and a, a
    jr nz, Jump_01C_5E6F
    ld a, $01
    ld [wD780], a
    ld a, $01
    ld [wD781], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ld [wD7B5], a
    ld [wD7B6], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01C_5E6F::
    ld a, [wD781]
    dec a
    ld [wD781], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld hl, wD788
    ld de, Data_01C_5F5E
    ld bc, $0020

Jump_01C_5E84::
    ld a, [de]
    ld [hl+], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_01C_5E84
    ld hl, wD792
    call Func_01C_4395
    ld hl, wInventory
    ld c, $00
    ld b, $00

Jump_01C_5E99::
    ld a, [hl+]
    and a, a
    jr z, Jump_01C_5EA2
    cp a, $FF
    jr z, Jump_01C_5EA2
    inc b

Jump_01C_5EA2::
    inc c
    ld a, c
    cp a, $18
    jr c, Jump_01C_5E99
    ld a, b
    ld [wD7B0], a
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    ld a, [wC8C1]
    and a, a
    jr z, Jump_01C_5EC0
    ld a, [wC8C1]
    add a, $E0
    ld [wD7A5], a

Jump_01C_5EC0::
    ld a, [wC8C2]
    add a, $E0
    ld [wD7A6], a
    call BGMapAddressAtScroll_Bank1C_67AF
    ld a, $0C
    add_a_to_hl
    ld de, wD788
    ld bc, $0804
    call Func_01C_6806
    xor a, a
    ld [wD7B5], a
    ld [wD7B6], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; 2 call sites from 2 routines (e.g. Func_01C_500C, Func_01C_4867_Case05)
; points at: wInventory, wD7F1
Func_01C_5EEC::
    push hl
    ld hl, wInventory
    ld b, $18

Jump_01C_5EF2::
    ld a, [hl]
    and a, a
    jr z, Jump_01C_5EFA
    cp a, $2D
    jr z, Jump_01C_5F00

Jump_01C_5EFA::
    inc hl
    dec b
    jr nz, Jump_01C_5EF2
    jr Jump_01C_5F24

Jump_01C_5F00::
    pop hl
    push hl
    ld e, l
    ld d, h
    ld b, $F2
    call ReadFarPointerAtDEInBankB
    ld e, b
    ld a, $09
    call Func_01C_6CAB
    ld a, $0A
    call Divide24ByA
    ld bc, wD7F1
    ld a, l
    ld [bc], a
    inc bc
    ld a, h
    ld [bc], a
    inc bc
    ld a, e
    ld [bc], a
    pop hl
    ld hl, wD7F1
    ret

Jump_01C_5F24::
    pop hl
    ret

; 2 call sites from 2 routines (e.g. Func_01C_500C, Func_01C_4867_Case05)
; reads: wD7FB
Func_01C_5F26::
    push de
    ld a, [wD7FB]
    ld e, a
    ld d, $00
    sla e
    rl d
    ld hl, Data_0F2_5643
    add hl, de
    ld e, l
    ld d, h
    ld b, $F2
    call ReadFarPointerAtDEInBankB
    pop de
    ret

; 3 call sites from 3 routines (e.g. Func_01C_5BE6, Func_01C_52E8_Case06, Func_01C_52E8_Case04)
; reads: wD7FB
Func_01C_5F3E::
    push bc
    ld hl, Data_01C_6320
    ld a, [wD7FB]
    add_a_to_hl
    ld a, [hl]
    push af
    ld hl, Data_01C_6338
    add hl, de
    ld c, [hl]
    inc hl
    ld b, [hl]
    pop af
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    pop bc
    ret

Data_01C_5F5E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $BF, $C3, $C3, $C3, $C3, $C3, $B7
    db $B8, $B9, $B9, $B9, $B9, $B9, $B9, $BA, $B6, $AE, $AD, $EC, $AF, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_01C_5F86:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $071F86, $62

Data_01C_5FE8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $071FE8, $62

Data_01C_604A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $07204A, $62

Data_01C_60AC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0
    ds $11, $B1
    db $B2, $B6, $C3, $F0, $F1, $F2, $F3, $F4, $F5, $F6, $F7, $C7, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $B7, $B6
    ds $11, $C3
    db $B7, $B6, $C3, $F8, $F9, $FA, $FB, $FC, $FD, $FE, $FF, $C8, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $B7, $B6
    ds $11, $C3
    db $B7, $B6, $C3, $D0, $D1, $D2, $D3, $D4, $D5, $D6, $D7, $C9, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $B7, $B6
    ds $11, $C3
    db $B7, $B6, $C3, $D8, $D9, $DA, $DB, $DC, $DD, $DE, $AA, $CA, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $B7, $B3
    ds $11, $B4
    db $B5, $7F

Data_01C_6158:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_01C_6188
    dw Data_01C_6191
    dw Data_01C_619D
    dw Data_01C_61A9
    dw Data_01C_61B1
    dw Data_01C_61B9
    dw Data_01C_61BA
    dw Data_01C_61C2
    dw Data_01C_61CE
    dw Data_01C_61D6
    dw Data_01C_61DF
    dw Data_01C_61E7
    dw Data_01C_61EF
    dw Data_01C_61F8
    dw Data_01C_6201
    dw Data_01C_620D
    dw Data_01C_621A
    dw Data_01C_6223
    dw Data_01C_622B
    dw Data_01C_6234
    db $B9, $61, $B9, $61, $B9, $61, $3D, $62

Data_01C_6188:: ; heuristic: target of a monotone pointer table; C0
    db $01, $02, $06, $19, $1A, $29, $2B, $53, $FF

Data_01C_6191:: ; heuristic: target of a monotone pointer table; C0
    db $03, $04, $07, $08, $09, $0A, $1B, $2E, $2B, $FF, $FF, $FF

Data_01C_619D:: ; heuristic: target of a monotone pointer table; C0
    db $05, $0C, $1C, $22, $23, $24, $25, $1F, $21, $2D, $FF, $FF

Data_01C_61A9:: ; heuristic: target of a monotone pointer table; C0
    db $01, $06, $09, $19, $29, $FF, $FF, $FF

Data_01C_61B1:: ; heuristic: target of a monotone pointer table; C0
    db $01, $02, $06, $09, $1A, $29, $2B, $FF

Data_01C_61B9:: ; heuristic: target of a monotone pointer table; C0
    db $FF

Data_01C_61BA:: ; heuristic: target of a monotone pointer table; C0
    db $02, $06, $09, $1A, $1B, $28, $2A, $FF

Data_01C_61C2:: ; heuristic: target of a monotone pointer table; C0
    db $02, $06, $07, $08, $1A, $1B, $28, $2A, $2E, $FF, $FF, $FF

Data_01C_61CE:: ; heuristic: target of a monotone pointer table; C0
    db $02, $03, $04, $0A, $1A, $28, $2A, $FF

Data_01C_61D6:: ; heuristic: target of a monotone pointer table; C0
    db $08, $0C, $1B, $2B, $2E, $1F, $21, $2D, $FF

Data_01C_61DF:: ; heuristic: target of a monotone pointer table; C0
    db $13, $14, $15, $16, $17, $18, $FF, $FF

Data_01C_61E7:: ; heuristic: target of a monotone pointer table; C0
    db $02, $07, $0A, $1B, $29, $2A, $2E, $FF

Data_01C_61EF:: ; heuristic: target of a monotone pointer table; C0
    db $02, $07, $0A, $1B, $28, $2A, $2B, $2E, $FF

Data_01C_61F8:: ; heuristic: target of a monotone pointer table; C0
    db $02, $03, $04, $1B, $1C, $20, $28, $2A, $FF

Data_01C_6201:: ; heuristic: target of a monotone pointer table; C0
    db $02, $03, $04, $0C, $1C, $20, $28, $2A, $2B, $2E, $FF, $FF

Data_01C_620D:: ; heuristic: target of a monotone pointer table; C0
    db $01, $02, $03, $04, $06, $07, $08, $0A, $1B, $20, $28, $2A, $FF

Data_01C_621A:: ; heuristic: target of a monotone pointer table; C0
    db $01, $02, $03, $05, $06, $07, $08, $27, $FF

Data_01C_6223:: ; heuristic: target of a monotone pointer table; C0
    db $02, $04, $0B, $1C, $20, $21, $FF, $FF

Data_01C_622B:: ; heuristic: target of a monotone pointer table; C0
    db $02, $03, $05, $1C, $20, $24, $28, $2A, $FF

Data_01C_6234:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $072234, $55

Data_01C_6289:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $072289, $50

Data_01C_62D9:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $AE, $00, $EE, $00, $2E, $01, $6E, $01

Data_01C_62E1:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B2, $B6, $C3, $C3, $B7, $B3, $B4, $B4, $B5

Data_01C_62ED:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $C3, $BE, $C3, $C3, $B7, $B3, $B4
    db $B4, $B4, $B4, $B4, $B5

Data_01C_6302:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $CE, $CF, $DF, $B7, $B6, $C3, $C3, $C3
    db $C3, $B7, $B6, $C3, $A5, $EE, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B5

Data_01C_6320:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $4B, $4B, $4B, $50, $50, $00, $50, $50, $50, $50, $50, $50, $50, $50, $50, $4B
    db $50, $50, $50, $50, $50, $50, $50, $50

Data_01C_6338:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $072338, $5D
    ds $23, $00
    INCBIN "dwm2-cobi-us.gbc", $0723B8, $46

Data_01C_63FE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_01C_64C4
    dw Data_01C_64C5
    dw Data_01C_64CA
    dw Data_01C_64D4
    dw Data_01C_64DD
    dw Data_01C_64E4
    dw Data_01C_64ED
    dw Data_01C_64F6
    dw Data_01C_64FF
    dw Data_01C_6506
    dw Data_01C_6510
    dw Data_01C_6518
    dw Data_01C_6521
    dw Data_01C_652B
    dw Data_01C_6533
    dw Data_01C_653B
    dw Data_01C_6543
    dw Data_01C_654B
    dw Data_01C_6555
    dw Data_01C_655F
    dw Data_01C_6566
    dw Data_01C_656E
    dw Data_01C_6576
    dw Data_01C_657F
    dw Data_01C_6586
    dw Data_01C_658E
    dw Data_01C_6598
    dw Data_01C_65A1
    dw Data_01C_65A5
    dw Data_01C_65AD
    dw Data_01C_65B5
    dw Data_01C_65BD
    dw Data_01C_65C7
    dw Data_01C_65D1
    dw Data_01C_65DB
    dw Data_01C_65E1
    dw Data_01C_65E9
    dw Data_01C_65EF
    dw Data_01C_65F5
    dw Data_01C_65FB
    dw Data_01C_6601
    dw Data_01C_6607
    dw Data_01C_6610
    dw Data_01C_6619
    dw Data_01C_6622
    dw Data_01C_662C
    dw Data_01C_6635
    dw Data_01C_663D
    dw Data_01C_663E
    dw Data_01C_6648
    dw Data_01C_6651
    dw Data_01C_6657
    dw Data_01C_6660
    dw Data_01C_666A
    dw Data_01C_6672
    dw Data_01C_667C
    dw Data_01C_6686
    dw Data_01C_668B
    dw Data_01C_6693
    dw Data_01C_669B
    dw Data_01C_66A3
    dw Data_01C_66AC
    dw Data_01C_66B4
    dw Data_01C_66B4
    dw Data_01C_66B4
    dw Data_01C_66BC
    dw Data_01C_66C6
    dw Data_01C_66D0
    dw Data_01C_66D8
    dw Data_01C_66E2
    dw Data_01C_66EC
    dw Data_01C_66F6
    dw Data_01C_6700
    dw Data_01C_6705
    dw Data_01C_670D
    dw Data_01C_6714
    dw Data_01C_671A
    dw Data_01C_6724
    dw Data_01C_672E
    dw Data_01C_6738
    dw Data_01C_6741
    dw Data_01C_674B
    dw Data_01C_6754
    dw Data_01C_675E
    dw Data_01C_6766
    dw Data_01C_6766
    dw Data_01C_6766
    dw Data_01C_6766
    dw Data_01C_6766
    dw Data_01C_6766
    dw Data_01C_6766
    dw Data_01C_676C
    dw Data_01C_6774
    dw Data_01C_6779
    dw Data_01C_677F
    dw Data_01C_6786
    dw Data_01C_678E
    dw Data_01C_6795
    dw Data_01C_679D

Data_01C_64C4:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_01C_64C5:: ; heuristic: target of a monotone pointer table; C0
    db $11, $28, $35, $25, $F0

Data_01C_64CA:: ; heuristic: target of a monotone pointer table; C0
    db $15, $32, $39, $28, $20, $24, $37, $28, $35, $F0

Data_01C_64D4:: ; heuristic: target of a monotone pointer table; C0
    db $20, $32, $35, $2F, $27, $0D, $28, $3A, $F0

Data_01C_64DD:: ; heuristic: target of a monotone pointer table; C0
    db $19, $32, $37, $2C, $32, $31, $F0

Data_01C_64E4:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $2F, $29, $20, $24, $37, $28, $35, $F0

Data_01C_64ED:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $31, $37, $2C, $27, $32, $37, $28, $F0

Data_01C_64F6:: ; heuristic: target of a monotone pointer table; C0
    db $16, $32, $32, $31, $11, $28, $35, $25, $F0

Data_01C_64FF:: ; heuristic: target of a monotone pointer table; C0
    db $15, $24, $38, $35, $28, $2F, $F0

Data_01C_6506:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $3A, $24, $2E, $28, $1C, $24, $31, $27, $F0

Data_01C_6510:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2E, $3C, $0B, $28, $2F, $2F, $F0

Data_01C_6518:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $24, $2A, $28, $1B, $32, $26, $2E, $F0

Data_01C_6521:: ; heuristic: target of a monotone pointer table; C0
    db $20, $32, $35, $2F, $27, $15, $28, $24, $29, $F0

Data_01C_652B:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $1D, $14, $36, $28, $28, $27, $F0

Data_01C_6533:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $0E, $0F, $36, $28, $28, $27, $F0

Data_01C_653B:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $10, $15, $36, $28, $28, $27, $F0

Data_01C_6543:: ; heuristic: target of a monotone pointer table; C0
    db $12, $17, $1D, $36, $28, $28, $27, $F0

Data_01C_654B:: ; heuristic: target of a monotone pointer table; C0
    db $15, $2C, $29, $28, $0A, $26, $32, $35, $31, $F0

Data_01C_6555:: ; heuristic: target of a monotone pointer table; C0
    db $16, $3C, $36, $37, $2C, $26, $17, $38, $37, $F0

Data_01C_655F:: ; heuristic: target of a monotone pointer table; C0
    db $1A, $38, $28, $36, $37, $50, $F0

Data_01C_6566:: ; heuristic: target of a monotone pointer table; C0
    db $11, $32, $35, $35, $32, $35, $50, $F0

Data_01C_656E:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $28, $17, $2C, $26, $28, $50, $F0

Data_01C_6576:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2B, $28, $24, $37, $28, $35, $50, $F0

Data_01C_657F:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $30, $24, $35, $37, $50, $F0

Data_01C_6586:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $32, $30, $28, $27, $3C, $50, $F0

Data_01C_658E:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $28, $28, $29, $13, $28, $35, $2E, $3C, $F0

Data_01C_6598:: ; heuristic: target of a monotone pointer table; C0
    db $19, $32, $35, $2E, $0C, $2B, $32, $33, $F0

Data_01C_65A1:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $2C, $25, $F0

Data_01C_65A5:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2C, $35, $2F, $32, $2C, $31, $F0

Data_01C_65AD:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $24, $27, $16, $28, $24, $37, $F0

Data_01C_65B5:: ; heuristic: target of a monotone pointer table; C0
    db $16, $28, $37, $28, $18, $35, $25, $F0

Data_01C_65BD:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $28, $24, $36, $37, $1D, $24, $2C, $2F, $F0

Data_01C_65C7:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $28, $33, $28, $2F, $2F, $28, $31, $37, $F0

Data_01C_65D1:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2B, $2C, $31, $3C, $11, $24, $35, $33, $F0

Data_01C_65DB:: ; heuristic: target of a monotone pointer table; C0
    db $16, $2C, $36, $37, $51, $F0

Data_01C_65E1:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $35, $2C, $28, $31, $27, $51, $F0

Data_01C_65E9:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2C, $31, $27, $51, $F0

Data_01C_65EF:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $32, $2F, $37, $51, $F0

Data_01C_65F5:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $31, $32, $3A, $51, $F0

Data_01C_65FB:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $2C, $35, $28, $51, $F0

Data_01C_6601:: ; heuristic: target of a monotone pointer table; C0
    db $20, $24, $35, $33, $51, $F0

Data_01C_6607:: ; heuristic: target of a monotone pointer table; C0
    db $20, $24, $35, $33, $20, $2C, $31, $2A, $F0

Data_01C_6610:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $3B, $2C, $37, $0B, $28, $2F, $2F, $F0

Data_01C_6619:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $32, $32, $2E, $30, $24, $35, $2E, $F0

Data_01C_6622:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2C, $31, $3C, $16, $28, $27, $24, $2F, $F0

Data_01C_662C:: ; heuristic: target of a monotone pointer table; C0
    db $10, $32, $2F, $27, $19, $24, $36, $36, $F0

Data_01C_6635:: ; heuristic: target of a monotone pointer table; C0
    db $15, $32, $2A, $1D, $3A, $2C, $2A, $F0

Data_01C_663D:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_01C_663E:: ; heuristic: target of a monotone pointer table; C0
    db $20, $24, $37, $28, $35, $0C, $24, $2F, $2F, $F0

Data_01C_6648:: ; heuristic: target of a monotone pointer table; C0
    db $16, $32, $32, $31, $1B, $32, $26, $2E, $F0

Data_01C_6651:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $35, $28, $36, $37, $F0

Data_01C_6657:: ; heuristic: target of a monotone pointer table; C0
    db $22, $38, $31, $24, $1C, $32, $38, $2F, $F0

Data_01C_6660:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2F, $28, $28, $33, $11, $28, $35, $25, $F0

Data_01C_666A:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2B, $24, $31, $2A, $28, $51, $F0

Data_01C_6672:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2C, $27, $24, $2F, $0B, $28, $2F, $2F, $F0

Data_01C_667C:: ; heuristic: target of a monotone pointer table; C0
    db $11, $24, $35, $16, $2C, $35, $35, $32, $35, $F0

Data_01C_6686:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2E, $3C, $5E, $F0

Data_01C_668B:: ; heuristic: target of a monotone pointer table; C0
    db $11, $28, $24, $39, $28, $31, $52, $F0

Data_01C_6693:: ; heuristic: target of a monotone pointer table; C0
    db $11, $28, $24, $39, $28, $31, $54, $F0

Data_01C_669B:: ; heuristic: target of a monotone pointer table; C0
    db $11, $28, $24, $39, $28, $31, $53, $F0

Data_01C_66A3:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2C, $3D, $1C, $37, $32, $31, $28, $F0

Data_01C_66AC:: ; heuristic: target of a monotone pointer table; C0
    db $19, $35, $28, $37, $37, $3C, $55, $F0

Data_01C_66B4:: ; heuristic: target of a monotone pointer table; C0
    db $1F, $12, $1D, $25, $28, $2F, $37, $F0

Data_01C_66BC:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $24, $26, $32, $0B, $28, $2F, $37, $F0

Data_01C_66C6:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $2A, $2C, $26, $0B, $28, $2F, $37, $F0

Data_01C_66D0:: ; heuristic: target of a monotone pointer table; C0
    db $18, $27, $27, $0B, $28, $2F, $37, $F0

Data_01C_66D8:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $32, $31, $28, $0F, $24, $31, $2A, $F0

Data_01C_66E2:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $28, $28, $2F, $0F, $24, $31, $2A, $F0

Data_01C_66EC:: ; heuristic: target of a monotone pointer table; C0
    db $16, $28, $35, $30, $1C, $26, $24, $2F, $28, $F0

Data_01C_66F6:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $24, $2E, $1C, $26, $24, $2F, $28, $F0

Data_01C_6700:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $10, $15, $55, $F0

Data_01C_6705:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $24, $35, $35, $3C, $55, $F0

Data_01C_670D:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $30, $24, $35, $37, $56, $F0

Data_01C_6714:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2C, $36, $28, $56, $F0

Data_01C_671A:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $2A, $2C, $26, $0C, $24, $33, $28, $F0

Data_01C_6724:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $24, $26, $32, $0C, $24, $33, $28, $F0

Data_01C_672E:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2C, $2F, $39, $35, $0C, $24, $33, $28, $F0

Data_01C_6738:: ; heuristic: target of a monotone pointer table; C0
    db $10, $32, $2F, $27, $0C, $24, $33, $28, $F0

Data_01C_6741:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2F, $37, $31, $30, $0C, $24, $33, $28, $F0

Data_01C_674B:: ; heuristic: target of a monotone pointer table; C0
    db $18, $35, $26, $24, $0C, $24, $33, $28, $F0

Data_01C_6754:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $35, $24, $39, $28, $0C, $24, $33, $28, $F0

Data_01C_675E:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $9C, $1C, $26, $24, $2F, $28, $F0

Data_01C_6766:: ; heuristic: target of a monotone pointer table; C0
    db $15, $2C, $29, $28, $55, $F0

Data_01C_676C:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $2C, $39, $2C, $31, $28, $55, $F0

Data_01C_6774:: ; heuristic: target of a monotone pointer table; C0
    db $20, $24, $35, $55, $F0

Data_01C_6779:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $2A, $28, $55, $F0

Data_01C_677F:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $2C, $2A, $2B, $37, $55, $F0

Data_01C_6786:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $24, $2C, $2F, $32, $35, $55, $F0

Data_01C_678E:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $2C, $28, $29, $55, $F0

Data_01C_6795:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2F, $28, $35, $2C, $26, $55, $F0

Data_01C_679D:: ; heuristic: target of a monotone pointer table; C0
    db $F0

; Copies 16 bytes from [HL] to [DE]; each byte is written with interrupts off after waiting for rSTAT bit 1 to clear; clobbers A, C; HL and DE advance (the same 17 bytes appear in 7 banks)
; 6 call sites from 4 routines (e.g. ScriptCommandE5_Run_Table2_Case00, Func_01C_7196, Func_01C_6F00_Case12, Func_01C_6AF7_Case00)
; reads: rSTAT
CopyTileBytesToVRAM_Bank1C::
Func_01C_679E:: ; address name
    ld c, $10

Jump_01C_67A0::
    di

Jump_01C_67A1::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_01C_67A1
    ld a, [hl+]
    ld [de], a
    inc de
    ei
    dec c
    jr nz, Jump_01C_67A0
    ret

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX, hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
; 47 call sites from 37 routines (e.g. ScriptCommandE5_Run_Case02_Sub03, ScriptCommandE3_Run_Case00_Sub01, ScriptCommandE2_Run_Case02_Sub04, Func_01C_6A71, ...)
; reads: hScrollY, hScrollX
BGMapAddressAtScroll_Bank1C_67AF::
Func_01C_67AF:: ; address name
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

; 11 call sites from 9 routines (e.g. Func_01C_52E8, Func_01C_4867_Case09, Func_01C_52E8_Case0C, Func_01C_52E8_Case08, ...)
; reads: wIsCGB
; writes: wC554, wC555, rVBK, rSVBK
Func_01C_67D0::
    push de
    push bc
    push hl
    xor a, a
    call Func_01C_6823
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
    ld a, $01
    ldh [rVBK], a
    ld a, $02
    ldh [rSVBK], a
    xor a, a
    call Func_01C_6823
    ld a, $00
    ldh [rSVBK], a
    ld a, $00
    ldh [rVBK], a
    ret

; 13 call sites from 13 routines (e.g. Func_01C_4867_Case0E, Func_01C_52E8, Func_01C_4867_Case0C, Func_01C_4867_Case08, ...)
; writes: wC554, wC555
Func_01C_6806::
    push de
    push bc
    push hl
    xor a, a
    call Func_01C_6823
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
    ret

; 3 call sites from 2 routines (e.g. Func_01C_6806, Func_01C_67D0)
; reads: hScrollX, rSTAT, hFFC5
; writes: hFFC5
Func_01C_6823::
    push hl
    push bc
    push de
    ldh a, [hScrollX]
    srl a
    srl a
    srl a
    and a, $1F
    ld b, a
    ld a, $20
    sub a, b
    ld b, a
    ld a, $14
    sub a, b
    bit 7, a
    jr nz, Jump_01C_6858
    pop de
    pop bc
    pop hl
    push hl
    push bc
    push de
    ld d, a
    ld a, l
    and a, $1F
    cp a, d
    jr nc, Jump_01C_685D
    pop de
    pop bc
    pop hl
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

Jump_01C_6854::
    push hl
    push bc
    jr Jump_01C_685E

Jump_01C_6858::
    pop de
    pop bc
    pop hl
    jr Jump_01C_6854

Jump_01C_685D::
    pop de

Jump_01C_685E::
    di

Jump_01C_685F::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_01C_685F
    ld a, [de]
    ei
    ldh [hFFC5], a
    di

Jump_01C_686A::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_01C_686A
    ldh a, [hFFC5]
    ld [hl+], a
    ei
    ld a, l
    and a, $1F
    jr nz, Jump_01C_6881
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

Jump_01C_6881::
    inc de
    dec b
    jr nz, Jump_01C_685E
    pop bc
    pop hl
    dec c
    jr z, Jump_01C_6899
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, h
    and a, $9B
    ld h, a
    jp Jump_01C_6854

Jump_01C_6899::
    ret

; 2 call sites from 2 routines (e.g. Func_01C_52E8_Case02, Func_01D_485C)
; reads: wD785
; writes: wD785, wD786
; points at: wD7D5, wInventory
Func_01C_689A::
    push af
    push bc
    push de
    push hl
    ld hl, wD7D5
    ld c, $18

Jump_01C_68A3::
    xor a, a
    ld [hl+], a
    dec c
    jr nz, Jump_01C_68A3
    xor a, a
    ld [wD785], a
    ld [wD786], a
    ld b, $01

Jump_01C_68B1::
    ld hl, wInventory
    ld c, $18

Jump_01C_68B6::
    ld a, [hl]
    cp a, b
    jr z, Jump_01C_68C9
    inc hl
    dec c
    jr nz, Jump_01C_68B6

Jump_01C_68BE::
    inc b
    ld a, b
    cp a, $63
    jr c, Jump_01C_68B1
    pop hl
    pop de
    pop bc
    pop af
    ret

Jump_01C_68C9::
    ld a, [wD785]
    ld de, wD7D5
    add a, e
    ld e, a
    jr nc, Jump_01C_68D4
    inc d

Jump_01C_68D4::
    ld a, b
    ld [de], a
    ld a, [wD785]
    inc a
    ld [wD785], a
    jr Jump_01C_68BE

; 7 call sites from 7 routines (e.g. Func_01C_4867_Case0E, Func_01C_4867_Case0A, Func_01C_500C, Func_01C_4867_Case05, ...)
; reads: wD7FB
; writes: wD7F2, wD7F1
Func_01C_68DF::
    ld hl, Data_01C_6158
    ld a, [wD7FB]
    ld e, a
    ld d, $00
    sla e
    rl d
    add hl, de
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld a, h
    ld [wD7F2], a
    ld l, e
    ld a, l
    ld [wD7F1], a
    ret

; 1 call site from 1 routine (e.g. Func_024_7045)
; reads: wD7B6, wD7B5
; writes: wD7F1
Func_01C_68FA::
    call Func_01C_68DF
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
    ld [wD7F1], a
    ret

; 2 call sites from 2 routines (e.g. Func_01C_52E8_Case0D, Func_01C_6F00_Case0E)
; reads: wD7CA, wD7CB, wD7B6, wD7B5, wD7B8, wD7B9
; writes: wD7B9, wD7B8
; points at: wD7D5, wInventory
Func_01C_6919::
    ld a, [wD7CA]
    ld e, a
    ld d, $00
    ld l, a
    ld h, $00
    sla l
    rl h
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    ld a, [wD7CB]
    add a, e
    ld e, a
    jr nc, Jump_01C_693F
    inc d

Jump_01C_693F::
    ld a, e
    ld [wD7B9], a
    ld hl, wD7D5
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
    ld [wD7B8], a
    ld de, wInventory
    ld hl, wInventory
    ld b, $00
    ld c, $00

Jump_01C_696B::
    ld a, [wD7B8]
    cp a, [hl]
    jr nz, Jump_01C_6984
    ld a, [wD7B9]
    and a, a
    jr z, Jump_01C_6984
    dec a
    ld [wD7B9], a
    inc hl
    inc c
    ld a, c
    cp a, $18
    jr nc, Jump_01C_698F
    jr Jump_01C_696B

Jump_01C_6984::
    ld a, [hl]
    ld [de], a
    inc hl
    inc de
    inc b
    inc c
    ld a, c
    cp a, $18
    jr c, Jump_01C_696B

Jump_01C_698F::
    xor a, a
    ld [de], a
    inc de
    inc b
    ld a, b
    cp a, $18
    jr c, Jump_01C_698F
    ret

; 2 call sites from 2 routines (e.g. Func_01C_52E8_Case07, Func_01D_4BF9)
; reads: wD7B6, wD7B5
; writes: wD7D4, wD7D3
; points at: wD7D5, wInventory
Func_01C_6999::
    ld hl, wD7D5
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
    ld b, a
    ld hl, wInventory
    ld d, $18
    ld c, $00

Jump_01C_69BC::
    ld a, [hl]
    cp a, b
    jr nz, Jump_01C_69C1
    inc c

Jump_01C_69C1::
    inc hl
    dec d
    jr nz, Jump_01C_69BC
    ld l, c
    ld h, $00
    ld a, $0A
    call DivideHLByA
    ld [wD7D4], a
    ld a, l
    ld [wD7D3], a
    ret

; 2 call sites from 2 routines (e.g. ScriptCommandE2_Run_Table2_Case01, ScriptCommandE5_Run_Table2_Case01)
; reads: wD783
; writes: wD784, wD783
; points at: wD781
Func_01C_69D5::
    xor a, a
    ld [wD784], a

Jump_01C_69D9::
    push hl
    push de
    ld a, [wD783]
    add a, a
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    jp z, Jump_01C_6A14
    ld e, a
    inc hl
    ld h, [hl]
    ld l, e
    pop de
    push de
    push hl
    ld a, [wD783]
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_01C_69FA
    inc d

Jump_01C_69FA::
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
    ld a, [wD783]
    inc a
    ld [wD783], a
    jr Jump_01C_69D9

Jump_01C_6A14::
    pop de
    pop hl
    xor a, a
    ld [wD783], a
    ld [wD784], a
    ld hl, wD781
    inc [hl]
    ret

; 2 call sites from 2 routines (e.g. ScriptCommandE2_Run_Table2_Case02, ScriptCommandE5_Run_Table2_Case04)
; reads: wC8C1, wC8C2
; writes: wD7B0, wD7A5, wD7A6
; points at: wD788, wD792, wInventory, wD781
Func_01C_6A22::
    ld hl, wD788
    ld de, Data_01C_5F5E
    ld bc, $0028

Jump_01C_6A2B::
    ld a, [de]
    ld [hl+], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_01C_6A2B
    ld hl, wD792
    call Func_01C_4395
    ld hl, wInventory
    ld c, $18
    ld b, $00

Jump_01C_6A40::
    ld a, [hl+]
    and a, a
    jr z, Jump_01C_6A49
    cp a, $FF
    jr z, Jump_01C_6A49
    inc b

Jump_01C_6A49::
    dec c
    jr nz, Jump_01C_6A40
    ld a, b
    ld [wD7B0], a
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    ld a, [wC8C1]
    and a, a
    jr z, Jump_01C_6A64
    ld a, [wC8C1]
    add a, $E0
    ld [wD7A5], a

Jump_01C_6A64::
    ld a, [wC8C2]
    add a, $E0
    ld [wD7A6], a
    ld hl, wD781
    inc [hl]
    ret

; 2 call sites from 2 routines (e.g. ScriptCommandE2_Run_Table2_Case03, ScriptCommandE5_Run_Table2_Case05)
; points at: wD788, wC370, wD781
Func_01C_6A71::
    ld de, wD788
    ld hl, wC370
    ld bc, $0805
    call CopyRectTo20ByteRowsJp_Bank1C
    call BGMapAddressAtScroll_Bank1C_67AF
    ld bc, $140D
    ld de, $01CC
    call Func_01C_449F
    ld hl, wD781
    inc [hl]
    ret

; only called from ScriptCommandE3_Run_Case01 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandE3_Run_Case01)
; writes: wD784, wD783, wD780, wD781, wC46B, wScriptCommandType, wScriptStartRequest
; points at: wD787
ScriptCommandE3_Run_Case01_Sub01::
Func_01C_6A8E:: ; address name
    xor a, a
    ld [wD784], a
    ld [wD783], a
    ld [wD780], a
    ld [wD781], a
    ld [wC46B], a
    ld hl, wD787
    inc [hl]
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; only called from ScriptCommandE3_Run_Case00 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandE3_Run_Case00)
; reads: wIsCGB
; points at: wC364, wScreenTileBuffer, wD1CC, wD000, wD787
ScriptCommandE3_Run_Case00_Sub01::
Func_01C_6AAC:: ; address name
    ld hl, wC364
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank1C
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_01C_6ACA
    ld hl, wD1CC
    ld de, wD000
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank1C

Jump_01C_6ACA::
    call BGMapAddressAtScroll_Bank1C_67AF
    ld bc, $140D
    ld de, $01CC
    call Func_01C_449F
    ld hl, wD787
    inc [hl]
    ret

; clears wD7C2-wD7C6, wD7C8 and wD7C9, and sets wD7C7 = $3C (60) (E-0072)
; 14 call sites from 4 routines (e.g. Func_01C_4867_Case07, Func_01C_4867_Case06, Func_01C_52E8_Case06, Func_01C_52E8_Case05)
; writes: wD7C2, wD7C3, wD7C4, wD7C5, wD7C6, wD7C8, wD7C9, wD7C7
ResetWD7C2Counters::
Func_01C_6ADB:: ; address name
    xor a, a
    ld [wD7C2], a
    ld [wD7C3], a
    ld [wD7C4], a
    ld [wD7C5], a
    ld [wD7C6], a
    ld [wD7C8], a
    ld [wD7C9], a
    ld a, $3C
    ld [wD7C7], a
    ret

; 2 call sites from 2 routines (e.g. Func_01C_4867_Case06, Func_01C_52E8_Case05)
; reads: wJoypadPressedRepeat, wD780, wD7C7, wD7C2, wD781
; writes: wD7C9, wD7C7, wD7C2
Func_01C_6AF7::
    ld a, [wJoypadPressedRepeat]
    bit 0, a
    jr nz, Jump_01C_6B38
    and a, a
    jr z, Jump_01C_6B38
    ld a, [wD780]
    cp a, $03
    jr z, Jump_01C_6B1A
    ld a, [wD780]
    cp a, $04
    jr z, Jump_01C_6B11
    jr Jump_01C_6B2E

Jump_01C_6B11::
    ld a, [wD781]
    cp a, $05
    jr nz, Jump_01C_6B2E
    jr Jump_01C_6B21

Jump_01C_6B1A::
    ld a, [wD781]
    cp a, $06
    jr nz, Jump_01C_6B2E

Jump_01C_6B21::
    ld a, [wJoypadPressedRepeat]
    bit 1, a
    jr z, Jump_01C_6B2E
    ld a, $03
    ld [wD7C2], a
    ret

Jump_01C_6B2E::
    ld a, $01
    ld [wD7C9], a
    ld a, $3C
    ld [wD7C7], a

Jump_01C_6B38::
    ld a, [wD7C7]
    inc a
    ld [wD7C7], a
    cp a, $3C
    ret c
    ld a, $3C
    ld [wD7C7], a
    ld a, [wD7C2]
    rst $00
    dw Func_01C_6AF7_Case00
    dw Func_01C_6AF7_Case01
    dw Func_01C_6AF7_Case02
    dw Func_01C_6AF7_Case03

; entry 0 of the `rst $00` table in Func_01C_6AF7
; no direct call (reached through a table, a jump or a vector)
; reads: wD7C2
; writes: wD7C2
Func_01C_6AF7_Case00::
Jump_01C_6B53:: ; address name
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, Data_01C_6B7D
    call Func_01C_6806
    ld c, $24
    ld de, vTiles1

Jump_01C_6B68::
    push bc
    ld hl, Data_01C_6BE1
    call CopyTileBytesToVRAM_Bank1C
    pop bc
    dec c
    jr nz, Jump_01C_6B68
    ld a, [wD7C2]
    inc a
    ld [wD7C2], a
    jp Func_01C_6AF7_Case01

Data_01C_6B7D:: ; heuristic: pointer load in the same bank (bank assumed); C0
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

Data_01C_6BE1:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00

; entry 1 of the `rst $00` table in Func_01C_6AF7
; no direct call (reached through a table, a jump or a vector)
; reads: wD7C2
; writes: wD7C2
Func_01C_6AF7_Case01::
Jump_01C_6BF1:: ; address name
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, Data_01C_6C0C
    call Func_01C_6806
    ld a, [wD7C2]
    inc a
    ld [wD7C2], a
    jp Func_01C_6AF7_Case02
    db $C9

Data_01C_6C0C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0
    ds $12, $B1
    db $B2, $B6, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8A, $8B, $8C, $8D
    db $8E, $8F, $90, $91, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $92, $93, $94, $95, $96, $97, $98, $99, $9A, $9B, $9C, $9D, $9E, $9F
    db $A0, $A1, $A2, $A3, $B7, $B3
    ds $12, $B4
    db $B5

; entry 2 of the `rst $00` table in Func_01C_6AF7
; no direct call (reached through a table, a jump or a vector)
Func_01C_6AF7_Case02::
Jump_01C_6C70:: ; address name
    farcall Func_024_7045
    ret

; entry 3 of the `rst $00` table in Func_01C_6AF7
; no direct call (reached through a table, a jump or a vector)
Func_01C_6AF7_Case03::
Jump_01C_6C77:: ; address name
    ret

; 2 call sites from 2 routines (e.g. Func_01C_4867_Case02, Func_01C_52E8_Case02)
Func_01C_6C78::
    push hl
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $018E
    add hl, de
    push hl
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, $C5
    ld [hl], a
    ei
    pop hl
    inc hl
    inc hl
    push hl
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, $BE
    ld [hl], a
    ei
    pop hl
    inc hl
    inc hl
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, $C6
    ld [hl], a
    ei
    pop hl
    ret

; 2 call sites from 2 routines (e.g. Func_01C_500C, Func_01C_5EEC)
; reads: wD7F1, wD7F2, wD7F3, wD7F4
; writes: wD7F1, wD7F2, wD7F3, wD7F4
Func_01C_6CAB::
    push af
    push de
    push hl
    ld c, l
    call Multiply8
    ld a, l
    ld [wD7F1], a
    ld a, h
    ld [wD7F2], a
    pop hl
    pop de
    pop af
    push af
    push de
    ld c, h
    call Multiply8
    ld a, l
    ld [wD7F3], a
    ld a, h
    ld [wD7F4], a
    pop de
    pop af
    ld c, e
    call Multiply8
    push hl
    pop bc
    ld a, [wD7F1]
    ld l, a
    ld a, [wD7F2]
    ld e, a
    ld a, [wD7F3]
    add a, e
    ld h, a
    ld a, [wD7F4]
    ld e, a
    adc a, c
    ld e, a
    ld a, b
    adc a, $00
    ld d, a
    ret

; implements script command type E6; reached through ScriptCommandE6 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommandE6)
ScriptCommandE6_Run::
Func_01C_6CEB:: ; address name
    call ScriptCommandE3_Run
    ret

; implements script command type E5; reached through ScriptCommandE5 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommandE5)
; reads: wD780
ScriptCommandE5_Run::
Func_01C_6CEF:: ; address name
    ld a, [wD780]
    rst $00
    dw ScriptCommandE5_Run_Case00
    dw ScriptCommandE5_Run_Case01
    dw ScriptCommandE5_Run_Case02
    dw ScriptCommandE5_Run_Case03
    dw ScriptCommandE5_Run_Case04

; entry 0 of the `rst $00` table in ScriptCommandE5_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: wD7F0, wD784, wD783, wD7CA, wD7CB, wD7CC, wScriptCommandType, wScriptStartRequest
; points at: wD780, wC364, wScreenTileBuffer, wD1CC, wD000
ScriptCommandE5_Run_Case00::
Jump_01C_6CFD:: ; address name
    ld bc, $0070
    ld hl, wD780

Jump_01C_6D03::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_01C_6D03
    ld hl, wC364
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank1C
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_01C_6D28
    ld hl, wD1CC
    ld de, wD000
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank1C

Jump_01C_6D28::
    ld a, $02
    ld [wD7F0], a
    xor a, a
    ld [wD784], a
    ld [wD783], a
    ld [wD7CA], a
    ld a, $01
    ld [wD7CB], a
    ld [wD7CC], a
    ld hl, wD780
    inc [hl]
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 1 of the `rst $00` table in ScriptCommandE5_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
ScriptCommandE5_Run_Case01::
Jump_01C_6D4D:: ; address name
    ld a, [wD781]
    rst $00
    dw ScriptCommandE5_Run_Table2_Case00
    dw ScriptCommandE5_Run_Table2_Case01
    dw ScriptCommandE5_Run_Table2_Case02
    dw ScriptCommandE5_Run_Table2_Case03
    dw ScriptCommandE5_Run_Table2_Case04
    dw ScriptCommandE5_Run_Table2_Case05

; entry 0 of the `rst $00` table in ScriptCommandE5_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
ScriptCommandE5_Run_Table2_Case00::
Jump_01C_6D5D:: ; address name
    ld hl, vTiles1 + $240
    ld de, vTiles2 + $7D0
    call CopyTileBytesToVRAM_Bank1C
    call CopyTileBytesToVRAM_Bank1C
    call CopyTileBytesToVRAM_Bank1C
    ld a, [wD781]
    inc a
    ld [wD781], a

; entry 1 of the `rst $00` table in ScriptCommandE5_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommandE5_Run_Table2_Case01::
Jump_01C_6D73:: ; address name
    ld hl, Data_01C_5F86
    ld de, Data_01C_604A
    call Func_01C_69D5
    ret

; entry 2 of the `rst $00` table in ScriptCommandE5_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
ScriptCommandE5_Run_Table2_Case02::
Jump_01C_6D7D:: ; address name
    farcall Func_01D_4A62
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 3 of the `rst $00` table in ScriptCommandE5_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
ScriptCommandE5_Run_Table2_Case03::
Jump_01C_6D8B:: ; address name
    ld hl, vTiles1 + $240
    ld de, Data_01F_43C0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles1 + $250
    ld de, Data_01F_4340
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles1 + $260
    ld de, Data_01F_40E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles1 + $270
    ld de, Data_01F_4330
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 4 of the `rst $00` table in ScriptCommandE5_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommandE5_Run_Table2_Case04::
Jump_01C_6DC7:: ; address name
    call Func_01C_6A22
    ret

; entry 5 of the `rst $00` table in ScriptCommandE5_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wD781, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
; points at: wC364, wD780
ScriptCommandE5_Run_Table2_Case05::
Jump_01C_6DCB:: ; address name
    ld de, Data_01C_6DEF
    ld hl, wC364
    ld bc, $0B07
    call CopyRectTo20ByteRowsJp_Bank1C
    call Func_01C_6A71
    xor a, a
    ld [wD781], a
    ld [wTwoChoiceCursor], a
    ld hl, wD780
    inc [hl]
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Data_01C_6DEF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $072DEF, $4D

; entry 2 of the `rst $00` table in ScriptCommandE5_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wD7B1, wD7B2, wD780
; writes: wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wD7B5, wD7B6, wD7B2, wD780, wD7B1
ScriptCommandE5_Run_Case02::
Jump_01C_6E3C:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, Jump_01C_6E54
    bit 7, a
    jr nz, Jump_01C_6E6E
    bit 0, a
    jr nz, Jump_01C_6E7E
    bit 1, a
    jp nz, Jump_01C_6ED6
    call ScriptCommandE5_Run_Case02_Sub01
    ret

Jump_01C_6E54::
    call ScriptCommandE5_Run_Case02_Sub02
    ld a, [wD7B1]
    and a, a
    jr nz, Jump_01C_6E61
    ld a, $02
    jr Jump_01C_6E62

Jump_01C_6E61::
    dec a

Jump_01C_6E62::
    ld [wD7B1], a
    call ScriptCommandE5_Run_Case02_Sub01
    ld a, $69
    call QueueSoundEffect
    ret

Jump_01C_6E6E::
    call ScriptCommandE5_Run_Case02_Sub02
    ld a, [wD7B1]
    cp a, $02
    jr c, Jump_01C_6E7B
    xor a, a
    jr Jump_01C_6E62

Jump_01C_6E7B::
    inc a
    jr Jump_01C_6E62

Jump_01C_6E7E::
    ld a, $69
    call QueueSoundEffect
    call ScriptCommandE5_Run_Case02_Sub03
    ld a, [wD7B1]
    ld b, a
    ld a, [wD7B2]
    cp a, b
    jr z, Jump_01C_6E9B
    ld a, [wD7B1]
    ld b, a
    xor a, a
    ld [wD7B5], a
    ld [wD7B6], a

Jump_01C_6E9B::
    ld a, b
    ld [wD7B2], a
    ld a, [wD7B1]
    and a, a
    jr z, Jump_01C_6EB8
    cp a, $01
    jr z, Jump_01C_6EC6
    ld a, $02
    ld [wTwoChoiceCursor], a

Jump_01C_6EAE::
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01C_6EB8::
    ld a, [wD780]
    inc a
    ld [wD780], a
    xor a, a
    ld [wTwoChoiceCursor], a
    jp Jump_01C_6EAE

Jump_01C_6EC6::
    ld a, [wD780]
    inc a
    inc a
    ld [wD780], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    jp Jump_01C_6EAE

Jump_01C_6ED6::
    ld a, $02
    ld [wTwoChoiceCursor], a
    jp Jump_01C_6EAE

; only called from ScriptCommandE5_Run_Case02 (E-0047)
; 2 call sites from 1 routine (e.g. ScriptCommandE5_Run_Case02)
; reads: wJoypadRepeatTimer, wD7B3, wD7B1
; writes: wD7B3
ScriptCommandE5_Run_Case02_Sub01::
Func_01C_6EDE:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, Jump_01C_6EF8
    ld a, [wD7B3]
    inc a
    ld [wD7B3], a
    cp a, $10
    jr c, Jump_01C_6EF8
    cp a, $18
    jr c, ScriptCommandE5_Run_Case02_Sub02
    xor a, a
    ld [wD7B3], a

Jump_01C_6EF8::
    ld b, $BB
    jr Jump_01C_6F02

; only called from ScriptCommandE5_Run_Case02 (E-0047)
; 2 call sites from 1 routine (e.g. ScriptCommandE5_Run_Case02)
; reads: wD7B1
ScriptCommandE5_Run_Case02_Sub02::
Func_01C_6EFC:: ; address name
    ld b, $C3
    jr Jump_01C_6F02

; only called from ScriptCommandE5_Run_Case02 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandE5_Run_Case02)
; reads: wD7B1
ScriptCommandE5_Run_Case02_Sub03::
Func_01C_6F00:: ; address name
    ld b, $BC

Jump_01C_6F02::
    ld a, [wD7B1]
    sla a
    ld hl, Data_01C_6F21
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    push de
    call BGMapAddressAtScroll_Bank1C_67AF
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

Data_01C_6F21:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $21, $00, $61, $00, $A1, $00

; entry 3 of the `rst $00` table in ScriptCommandE5_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
ScriptCommandE5_Run_Case03::
Jump_01C_6F27:: ; address name
    ld a, [wD781]
    rst $00
    dw Func_01C_6F00_Case00
    dw Func_01C_6F00_Case01
    dw Func_01C_6F00_Case02
    dw Func_01C_6F00_Case03
    dw Func_01C_6F00_Case04
    dw Func_01C_6F00_Case05
    dw Func_01C_6F00_Case06
    dw Func_01C_6F00_Case07
    dw Func_01C_6F00_Case08
    dw Func_01C_6F00_Case09
    dw Func_01C_6F00_Case0A
    dw Func_01C_6F00_Case0B
    dw Func_01C_6F00_Case0C
    dw Func_01C_6F00_Case0D
    dw Func_01C_6F00_Case0E
    dw Func_01C_6F00_Case0F
    dw Func_01C_6F00_Case10
    dw Func_01C_6F00_Case11
    dw Func_01C_6F00_Case12
    dw Func_01C_6F00_Case13
    dw Func_01C_6F00_Case14
    dw Func_01C_6F00_Case15
    dw Func_01C_7196
    dw Func_01C_6F00_Case17
    dw Func_01C_6F00_Case18

; entry 0 of the `rst $00` table in Func_01C_6F00
; no direct call (reached through a table, a jump or a vector)
Func_01C_6F00_Case00::
Jump_01C_6F5D:: ; address name
    farcall Func_01D_44BA
    ret

; entry 1 of the `rst $00` table in Func_01C_6F00
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
Func_01C_6F00_Case01::
Jump_01C_6F64:: ; address name
    call BGMapAddressAtScroll_Bank1C_67AF
    ld bc, $0B09
    ld de, vBGMap1 + $300
    call Func_01C_67D0
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 2 of the `rst $00` table in Func_01C_6F00
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD7ED, wD781, wScriptCommandType, wScriptStartRequest
Func_01C_6F00_Case02::
Jump_01C_6F78:: ; address name
    farcall Func_01D_45AB
    xor a, a
    ld [wD7ED], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 3 of the `rst $00` table in Func_01C_6F00
; no direct call (reached through a table, a jump or a vector)
Func_01C_6F00_Case03::
Jump_01C_6F93:: ; address name
    farcall Func_01D_46E1
    ret

; entry 4 of the `rst $00` table in Func_01C_6F00
; no direct call (reached through a table, a jump or a vector)
; writes: wD780, wD781, wTwoChoiceCursor, wD7ED, wScriptCommandType, wScriptStartRequest
Func_01C_6F00_Case04::
Jump_01C_6F9A:: ; address name
    ld a, $01
    ld [wD780], a
    ld a, $02
    ld [wD781], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ld [wD7ED], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 5 of the `rst $00` table in Func_01C_6F00
; no direct call (reached through a table, a jump or a vector)
Func_01C_6F00_Case05::
Jump_01C_6FB5:: ; address name
    farcall Func_01D_4848
    ret

; entry 6 of the `rst $00` table in Func_01C_6F00
; no direct call (reached through a table, a jump or a vector)
; reads: wD783
; writes: wD783
Func_01C_6F00_Case06::
Jump_01C_6FBC:: ; address name
    call Func_01C_72B3
    ld a, [wD783]
    inc a
    ld [wD783], a
    cp a, $04
    jr c, Func_01C_6F00_Case06
    xor a, a
    ld [wD783], a
    farcall Func_01D_485C
    ret

; entry 9 of the `rst $00` table in Func_01C_6F00
; no direct call (reached through a table, a jump or a vector)
; reads: wD780, wD7B6, wD783, wD7B8, wD784, wD781
; writes: wD7B8, wD784, wD783, wD781
; points at: wC635, wD7D5
Func_01C_6F00_Case09::
Jump_01C_6FD5:: ; address name
    call Func_01C_72B3
    ld a, [wD780]
    cp a, $03
    jr z, Jump_01C_6FFC
    ld hl, wC635
    ld a, [wD7B6]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, [wD783]
    sla a
    jr Jump_01C_7011

Jump_01C_6FFC::
    ld hl, wD7D5
    ld a, [wD7B6]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, [wD783]

Jump_01C_7011::
    add_a_to_hl
    ld e, [hl]
    ld d, $00
    sla e
    rl d
    ld hl, Data_01C_63FE
    add hl, de
    ld e, [hl]
    inc hl
    ld a, [hl]
    ld h, a
    ld l, e

Jump_01C_7026::
    ld a, [hl]
    cp a, $F0
    jp z, Jump_01C_709C
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
    ld a, [wD783]
    sla a
    ld de, Data_01C_6289
    add a, e
    ld e, a
    jr nc, Jump_01C_704E
    inc d

Jump_01C_704E::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, [wD7B8]
    cp a, $8D
    jr z, Jump_01C_7060
    cp a, $8E
    jr z, Jump_01C_7060
    jr Jump_01C_7067

Jump_01C_7060::
    ld a, [wD784]
    dec a
    ld [wD784], a

Jump_01C_7067::
    ld a, [wD784]
    sla a
    add_a_to_hl
    ld a, [hl]
    ld e, a
    inc hl
    ld a, [hl]
    ld h, a
    ld a, e
    ld l, a
    pop de
    ld b, $1F
    ld c, $10
    ld a, [wD7B8]
    cp a, $8D
    jr z, Jump_01C_708D
    cp a, $8E
    jr z, Jump_01C_708D
    call CopyFromBankWaitVRAM
    jr Jump_01C_7090

Jump_01C_708D::
    call OrFromBankWaitVRAM

Jump_01C_7090::
    pop hl
    inc hl
    ld a, [wD784]
    inc a
    ld [wD784], a
    jp Jump_01C_7026

Jump_01C_709C::
    xor a, a
    ld [wD784], a
    ld a, [wD783]
    inc a
    ld [wD783], a
    cp a, $04
    jr c, Jump_01C_70B7
    xor a, a
    ld [wD783], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01C_70B7::
    ret

; entry 7 of the `rst $00` table in Func_01C_6F00
; no direct call (reached through a table, a jump or a vector)
Func_01C_6F00_Case07::
Jump_01C_70B8:: ; address name
    farcall Func_01D_4883
    ret

; entry 8 of the `rst $00` table in Func_01C_6F00
; no direct call (reached through a table, a jump or a vector)
Func_01C_6F00_Case08::
Jump_01C_70BF:: ; address name
    farcall Func_01D_49D4
    ret

; entry 10 of the `rst $00` table in Func_01C_6F00
; no direct call (reached through a table, a jump or a vector)
Func_01C_6F00_Case0A::
Jump_01C_70C6:: ; address name
    farcall Func_01D_4ADC
    ret

; entry 11 of the `rst $00` table in Func_01C_6F00
; no direct call (reached through a table, a jump or a vector)
Func_01C_6F00_Case0B::
Jump_01C_70CD:: ; address name
    farcall Func_01D_4BF9
    ret

; entry 12 of the `rst $00` table in Func_01C_6F00
; no direct call (reached through a table, a jump or a vector)
; writes: wD781, wScriptCommandType, wScriptStartRequest
Func_01C_6F00_Case0C::
Jump_01C_70D4:: ; address name
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $0088
    add hl, de
    ld bc, $0C09
    ld de, vBGMap1 + $370
    call Func_01C_67D0
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $0140
    add hl, de
    ld bc, $0703
    ld de, vBGMap1 + $3E0
    call Func_01C_67D0
    ld a, $03
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 13 of the `rst $00` table in Func_01C_6F00
; no direct call (reached through a table, a jump or a vector)
Func_01C_6F00_Case0D::
Jump_01C_7103:: ; address name
    farcall Func_01D_4DC7
    ret

; entry 14 of the `rst $00` table in Func_01C_6F00
; no direct call (reached through a table, a jump or a vector)
; reads: wD780
Func_01C_6F00_Case0E::
Jump_01C_710A:: ; address name
    ld a, [wD780]
    cp a, $03
    jr z, Jump_01C_7118
    farcall Func_01D_508B
    ret

Jump_01C_7118::
    call Func_01C_6919
    farcall Func_01D_5101
    farcall Func_0F2_6454
    ret

; entry 15 of the `rst $00` table in Func_01C_6F00
; no direct call (reached through a table, a jump or a vector)
Func_01C_6F00_Case0F::
Jump_01C_7128:: ; address name
    call Func_01C_7252
    farcall Func_01D_5259
    ret

; entry 16 of the `rst $00` table in Func_01C_6F00
; no direct call (reached through a table, a jump or a vector)
; writes: wTwoChoiceCursor, wD781
Func_01C_6F00_Case10::
Jump_01C_7132:: ; address name
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $0088
    add hl, de
    ld bc, $0C09
    ld de, vBGMap1 + $370
    call Func_01C_67D0
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $0140
    add hl, de
    ld bc, $0703
    ld de, vBGMap1 + $3E0
    call Func_01C_67D0
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, $04
    ld [wD781], a
    ret

; entry 17 of the `rst $00` table in Func_01C_6F00
; no direct call (reached through a table, a jump or a vector)
Func_01C_6F00_Case11::
Jump_01C_715C:: ; address name
    farcall Func_01D_5297
    ret

; entry 19 of the `rst $00` table in Func_01C_6F00
; no direct call (reached through a table, a jump or a vector)
Func_01C_6F00_Case13::
Jump_01C_7163:: ; address name
    farcall Func_01D_52BD
    ret

; entry 18 of the `rst $00` table in Func_01C_6F00
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
Func_01C_6F00_Case12::
Jump_01C_716A:: ; address name
    ld hl, vTiles1 + $4C0
    ld de, vTiles2 + $700
    call CopyTileBytesToVRAM_Bank1C
    ld hl, vTiles1 + $4C0
    ld de, Data_01F_4500
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 20 of the `rst $00` table in Func_01C_6F00
; no direct call (reached through a table, a jump or a vector)
Func_01C_6F00_Case14::
Jump_01C_7188:: ; address name
    farcall Func_01D_53BD
    ret

; entry 21 of the `rst $00` table in Func_01C_6F00
; no direct call (reached through a table, a jump or a vector)
Func_01C_6F00_Case15::
Jump_01C_718F:: ; address name
    farcall Func_01D_549D
    ret

; 1 call site from 1 routine (e.g. Func_01C_6F00_Case18)
; writes: wD781, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
Func_01C_7196::
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $0147
    add hl, de
    ld de, vBGMap1 + $370
    ld bc, $0D03
    call Func_01C_67D0
    ld hl, vTiles2 + $700
    ld de, vTiles1 + $4C0
    call CopyTileBytesToVRAM_Bank1C
    call Func_01C_7252
    ld a, $03
    ld [wD781], a
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 23 of the `rst $00` table in Func_01C_6F00
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType, wScriptStartRequest
; points at: wD788, wD792
Func_01C_6F00_Case17::
Jump_01C_71C6:: ; address name
    ld hl, wD788
    ld de, Data_01C_5F5E
    ld bc, $0020

Jump_01C_71CF::
    ld a, [de]
    ld [hl+], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_01C_71CF
    ld hl, wD792
    call Func_01C_4395
    call BGMapAddressAtScroll_Bank1C_67AF
    ld a, $0C
    add_a_to_hl
    ld de, wD788
    ld bc, $0802
    call Func_01C_6806
    farcall Func_01D_52BD
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 24 of the `rst $00` table in Func_01C_6F00
; no direct call (reached through a table, a jump or a vector)
; writes: wD780, wD781
Func_01C_6F00_Case18::
Jump_01C_7200:: ; address name
    call Func_01C_7196
    ld a, $01
    ld [wD780], a
    ld a, $02
    ld [wD781], a
    ret

; entry 4 of the `rst $00` table in ScriptCommandE5_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
ScriptCommandE5_Run_Case04::
Jump_01C_720E:: ; address name
    ld a, [wD781]
    rst $00
    dw Func_01C_6F00_Case00
    dw Func_01C_6F00_Case01
    dw Func_01C_6F00_Case02
    dw Func_01C_7196_Case03
    dw Func_01C_6F00_Case04
    dw Func_01C_6F00_Case05
    dw Func_01C_6F00_Case06
    dw Func_01C_6F00_Case07
    dw Func_01C_6F00_Case08
    dw Func_01C_6F00_Case09
    dw Func_01C_6F00_Case0A
    dw Func_01C_6F00_Case0B
    dw Func_01C_6F00_Case0C
    dw Func_01C_6F00_Case0D
    dw Func_01C_6F00_Case0E
    dw Func_01C_6F00_Case0F
    dw Func_01C_6F00_Case10
    dw Func_01C_6F00_Case11
    dw Func_01C_6F00_Case12
    dw Func_01C_6F00_Case13
    dw Func_01C_6F00_Case14
    dw Func_01C_7196_Case15
    dw Func_01C_7196
    dw Func_01C_6F00_Case17
    dw Func_01C_6F00_Case18

; entry 3 of the `rst $00` table in Func_01C_7196
; no direct call (reached through a table, a jump or a vector)
Func_01C_7196_Case03::
Jump_01C_7244:: ; address name
    farcall Func_01D_460F
    ret

; entry 21 of the `rst $00` table in Func_01C_7196
; no direct call (reached through a table, a jump or a vector)
Func_01C_7196_Case15::
Jump_01C_724B:: ; address name
    farcall Func_01D_5573
    ret

; 2 call sites from 2 routines (e.g. Func_01C_7196, Func_01C_6F00_Case0F)
; reads: wC8C1, wC8C2
; writes: wD7B0, wD7A5, wD7A6
; points at: wD788, wD792, wInventory
Func_01C_7252::
    ld hl, wD788
    ld de, Data_01C_5F5E
    ld bc, $0020

Jump_01C_725B::
    ld a, [de]
    ld [hl+], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_01C_725B
    ld hl, wD792
    call Func_01C_4395
    ld hl, wInventory
    ld c, $00
    ld b, $00

Jump_01C_7270::
    ld a, [hl+]
    and a, a
    jr z, Jump_01C_7279
    cp a, $FF
    jr z, Jump_01C_7279
    inc b

Jump_01C_7279::
    inc c
    ld a, c
    cp a, $18
    jr c, Jump_01C_7270
    ld a, b
    ld [wD7B0], a
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    ld a, [wC8C1]
    and a, a
    jr z, Jump_01C_7297
    ld a, [wC8C1]
    add a, $E0
    ld [wD7A5], a

Jump_01C_7297::
    ld a, [wC8C2]
    add a, $E0
    ld [wD7A6], a
    call BGMapAddressAtScroll_Bank1C_67AF
    ld a, $0C
    add_a_to_hl
    ld de, wD788
    ld bc, $0804
    call Func_01C_6806
    ret

; 2 call sites from 2 routines (e.g. Func_01C_6F00_Case09, Func_01C_6F00_Case06)
; reads: wD783, wD784
; writes: wD784
Func_01C_72B3::
    ld a, [wD783]
    sla a
    ld hl, Data_01C_6289
    add_a_to_hl
    ld a, [hl]
    ld e, a
    inc hl
    ld a, [hl]
    ld d, a

Jump_01C_72C5::
    push de
    ld a, [wD784]
    sla a
    add a, e
    ld e, a
    jr nc, Jump_01C_72D0
    inc d

Jump_01C_72D0::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld de, Data_01F_4910
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    pop de
    ld a, [wD784]
    inc a
    ld [wD784], a
    cp a, $09
    jr c, Jump_01C_72C5
    xor a, a
    ld [wD784], a
    ret
    ds $D10, $00
