SECTION "Bank 73", ROMX[$4000], BANK[$73]
    db $73

; implements script command type 82; reached through ScriptCommand82 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand82)
; reads: wC935
ScriptCommand82_Run::
Func_073_4001:: ; address name
    ld a, [wC935]
    and a, $0F
    rst $00
    dw ScriptCommand82_Run_Case00
    dw ScriptCommand82_Run_Case01
    dw ScriptCommand82_Run_Case02
    dw ScriptCommand82_Run_Case03
    dw ScriptCommand82_Run_Case04
    dw ScriptCommand82_Run_Case05
    dw ScriptCommand82_Run_Case06
    dw ScriptCommand82_Run_Case07
    dw ScriptCommand82_Run_Case08
    dw ScriptCommand82_Run_Case09
    dw ScriptCommand82_Run_Case0A
    dw ScriptCommand82_Run_Case0B
    dw ScriptCommand82_Run_Case0C
    dw ScriptCommand82_Run_Case0C
    dw ScriptCommand82_Run_Case0C
    dw ScriptCommand82_Run_Case0C

; entry 12 of the `rst $00` table in ScriptCommand82_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptStep
ScriptCommand82_Run_Case0C::
Jump_073_4027:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand82_Run_Table2_Case00
    dw ScriptCommand82_Run_Table2_Case01
    dw ScriptCommand82_Run_Table2_Case02
    dw ScriptCommand82_Run_Table2_Case03
    dw ScriptCommand82_Run_Table2_Case01
    dw Func_073_4E9C
    dw ScriptCommand82_Run_Table2_Case01
    dw ScriptCommand82_Run_Table2_Case07
    dw ScriptCommand82_Run_Table2_Case01
    dw Func_073_4E9C

; entry 0 of the `rst $00` table in ScriptCommand82_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC935
; points at: wScriptStep
ScriptCommand82_Run_Table2_Case00::
Jump_073_403F:: ; address name
    ld a, [wC935]
    and a, $0F
    sub a, $0C
    add a, $3A
    ld l, a
    ld h, $00
    call StoreHLInWC924_B73
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in ScriptCommand82_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD092, wC935
; writes: wScriptStep
; points at: wScriptStep
ScriptCommand82_Run_Table2_Case03::
Jump_073_4053:: ; address name
    ld a, [wD092]
    or a, a
    jr nz, Jump_073_407B
    ld hl, $003E
    call StoreHLInWC924_B73
    ld a, [wC935]
    and a, $0F
    sub a, $0C
    add a, a
    ld hl, $4090
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_073_407B::
    ld a, [wC935]
    and a, $0F
    sub a, $0C
    add a, $3F
    ld l, a
    ld h, $00
    call StoreHLInWC924_B73
    ld a, $06
    ld [wScriptStep], a
    ret
    db $93, $01, $96, $01, $99, $01, $9C, $01

; entry 11 of the `rst $00` table in ScriptCommand82_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptStep
ScriptCommand82_Run_Case0B::
Jump_073_4098:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand82_Run_Table3_Case00
    dw ScriptCommand82_Run_Table2_Case01
    dw ScriptCommand82_Run_Table3_Case02
    dw ScriptCommand82_Run_Table2_Case01
    dw ScriptCommand82_Run_Table2_Case02
    dw ScriptCommand82_Run_Table3_Case05
    dw ScriptCommand82_Run_Table2_Case01
    dw ScriptCommand82_Run_Table3_Case07
    dw ScriptCommand82_Run_Table3_Case08
    dw ScriptCommand82_Run_Table3_Case09
    dw Func_073_4E9C
    dw ScriptCommand82_Run_Table2_Case01
    dw ScriptCommand82_Run_Table2_Case07
    dw ScriptCommand82_Run_Table2_Case01
    dw Func_073_4E9C

; entry 0 of the `rst $00` table in ScriptCommand82_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand82_Run_Table3_Case00::
Jump_073_40BA:: ; address name
    ld hl, $4037
    call StoreHLInWC924_B73
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in ScriptCommand82_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC552
; writes: wScriptStep
; points at: wScriptStep
ScriptCommand82_Run_Table3_Case02::
Jump_073_40C5:: ; address name
    ld a, [wC552]
    or a, a
    jr nz, Jump_073_40D6
    ld hl, vTiles0 + $49
    call StoreHLInWC924_B73
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_073_40D6::
    ld hl, vTiles0 + $48
    call StoreHLInWC924_B73
    ld a, $0D
    ld [wScriptStep], a
    ret

; entry 5 of the `rst $00` table in ScriptCommand82_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD092, wIsCGB
; writes: wScriptStep
; points at: wC49F, wC0F0, wScriptStep
ScriptCommand82_Run_Table3_Case05::
Jump_073_40E2:: ; address name
    ld a, [wD092]
    or a, a
    jr nz, Jump_073_4105
    ld hl, $0038
    call StoreHLInWC924_B73
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_073_4100
    ld hl, wC49F
    ld de, wC0F0
    ld bc, $0040
    call CopyBytes

Jump_073_4100::
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_073_4105::
    ld hl, $0039
    call StoreHLInWC924_B73
    ld a, $0B
    ld [wScriptStep], a
    ret

; entry 7 of the `rst $00` table in ScriptCommand82_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand82_Run_Table2_Case07::
Jump_073_4111:: ; address name
    ld hl, $000F
    call StoreHLInWC924_B73
    call Func_073_4C5D
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 10 of the `rst $00` table in ScriptCommand82_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptStep
ScriptCommand82_Run_Case0A::
Jump_073_411F:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand82_Run_Table4_Case00
    dw ScriptCommand82_Run_Table2_Case01
    dw ScriptCommand82_Run_Table4_Case02
    dw ScriptCommand82_Run_Table2_Case01
    dw ScriptCommand82_Run_Table4_Case04
    dw ScriptCommand82_Run_Table4_Case05
    dw ScriptCommand82_Run_Table4_Case06
    dw ScriptCommand82_Run_Table4_Case07
    dw ScriptCommand82_Run_Table4_Case08
    dw ScriptCommand82_Run_Table2_Case01
    dw Func_073_4E9C

; entry 8 of the `rst $00` table in ScriptCommand82_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wC46B, wC46C, wC46D
; writes: wScriptParam0, wC928, hFFC6, hFFC7
; points at: wScriptStep
ScriptCommand82_Run_Table4_Case08::
Jump_073_4139:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $3C
    ret nz
    farcall Func_002_5F22
    farcall Func_05F_6DDB
    ld b, $46
    ld de, Data_046_4001
    ld hl, vTiles1
    call DecompressToVRAM
    call Func_000_222B
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ld a, [wC46B]
    and a, $F0
    swap a
    ld de, $453A
    add a, e
    ld e, a
    jr nc, Jump_073_4174
    inc d

Jump_073_4174::
    ld a, [de]
    ld c, a
    ld a, [wC46C]
    and a, $F0
    swap a
    ld de, $4544
    add a, e
    ld e, a
    jr nc, Jump_073_4185
    inc d

Jump_073_4185::
    ld a, [de]
    cp a, c
    jp nz, Jump_073_4220
    ld a, [wC46D]
    and a, $F0
    swap a
    ld de, $454E
    add a, e
    ld e, a
    jr nc, Jump_073_4199
    inc d

Jump_073_4199::
    ld a, [de]
    cp a, c
    jp nz, Jump_073_4227
    ld a, [wC46B]
    and a, $F0
    swap a
    ld de, $453A
    add a, e
    ld e, a
    jr nc, Jump_073_41AD
    inc d

Jump_073_41AD::
    ld a, [de]
    or a, a
    jr nz, Jump_073_41C3
    ld hl, $0032
    call StoreHLInWC924_B73
    ld a, $1E
    ld [wC928], a
    farcall Func_05F_6C8C
    ret

Jump_073_41C3::
    dec a
    jr nz, Jump_073_41D8
    ld hl, $0030
    call StoreHLInWC924_B73
    ld a, $2C
    ld [wC928], a
    farcall Func_05F_6C8C
    ret

Jump_073_41D8::
    dec a
    jr nz, Jump_073_41F1
    ld hl, $0031
    call StoreHLInWC924_B73
    ld hl, $03E8
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    farcall Func_012_7EC2
    ret

Jump_073_41F1::
    dec a
    jr nz, Jump_073_420A
    ld hl, $0044
    call StoreHLInWC924_B73
    ld hl, $01F4
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    farcall Func_012_7EC2
    ret

Jump_073_420A::
    ld hl, $0045
    call StoreHLInWC924_B73
    ld hl, $00C8
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    farcall Func_012_7EC2
    ret

Jump_073_4220::
    ld hl, $0035
    call StoreHLInWC924_B73
    ret

Jump_073_4227::
    ld a, [wC46B]
    and a, $F0
    swap a
    ld de, $453A
    add a, e
    ld e, a
    jr nc, Jump_073_4236
    inc d

Jump_073_4236::
    ld a, [de]
    or a, a
    jr nz, Jump_073_4250
    ld hl, $0046
    call StoreHLInWC924_B73
    ld hl, $0064
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    farcall Func_012_7EC2
    ret

Jump_073_4250::
    dec a
    jr nz, Jump_073_4220
    ld hl, $0047
    call StoreHLInWC924_B73
    ld hl, $0032
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    farcall Func_012_7EC2
    ret

; entry 7 of the `rst $00` table in ScriptCommand82_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wFrameCounterLo, wC46E
; points at: wC46B, wScriptStep, wC46C, wC46D
ScriptCommand82_Run_Table4_Case07::
Jump_073_4269:: ; address name
    call Func_073_43BE
    ld a, [wFrameCounterLo]
    and a, $01
    jr z, Jump_073_42A7
    ld a, [wC46E]
    dec a
    jr nz, Jump_073_4288
    ld hl, wC46B
    call Func_073_42AB
    or a, a
    jr z, Jump_073_42A7
    ld hl, wScriptStep
    dec [hl]
    jr Jump_073_42A7

Jump_073_4288::
    dec a
    jr nz, Jump_073_429A
    ld hl, wC46C
    call Func_073_42AB
    or a, a
    jr z, Jump_073_42A7
    ld hl, wScriptStep
    dec [hl]
    jr Jump_073_42A7

Jump_073_429A::
    ld hl, wC46D
    call Func_073_42AB
    or a, a
    jr z, Jump_073_42A7
    ld hl, wScriptStep
    inc [hl]

Jump_073_42A7::
    call Func_073_441D
    ret

; 3 call sites from 1 routine (e.g. ScriptCommand82_Run_Table4_Case07)
Func_073_42AB::
    ld a, [hl]
    and a, $0F
    jr z, Jump_073_42BF
    ld a, [hl]
    inc a
    ld [hl], a
    and a, $F0
    swap a
    cp a, $0A
    jr nz, Jump_073_42BD
    xor a, a
    ld [hl], a

Jump_073_42BD::
    xor a, a
    ret

Jump_073_42BF::
    ld a, $01
    ret

; entry 6 of the `rst $00` table in ScriptCommand82_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed
; points at: wC46E, wScriptStep
ScriptCommand82_Run_Table4_Case06::
Jump_073_42C2:: ; address name
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_073_42D1
    ld hl, wC46E
    inc [hl]
    ld hl, wScriptStep
    inc [hl]

Jump_073_42D1::
    call Func_073_43BE
    call Func_073_441D
    ret

; entry 5 of the `rst $00` table in ScriptCommand82_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wScriptParam0
; points at: wScriptStep
ScriptCommand82_Run_Table4_Case05::
Jump_073_42D8:: ; address name
    call Func_073_43BE
    call Func_073_441D
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $1E
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in ScriptCommand82_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCD04, wIsCGB
; writes: wC46B, wC46C, wC46D, wC46E, rSVBK
; points at: wScreenTileBuffer, wScriptStep
ScriptCommand82_Run_Table4_Case04::
Jump_073_42F1:: ; address name
    farcall Func_002_5EEE
    call NextRandomSeed
    ld a, [wCD04]
    and a, $07
    swap a
    ld [wC46B], a
    call NextRandomSeed
    ld a, [wCD04]
    and a, $07
    swap a
    ld [wC46C], a
    call NextRandomSeed
    ld a, [wCD04]
    and a, $07
    swap a
    ld [wC46D], a
    xor a, a
    ld [wC46E], a
    call Func_073_441D
    ld de, $4378
    ld hl, wScreenTileBuffer
    ld b, $03

Jump_073_432D::
    push hl
    ld a, [de]
    inc de
    ld [hl+], a
    ld a, [de]
    inc de
    ld [hl+], a
    ld a, [de]
    inc de
    ld [hl+], a
    ld a, [de]
    inc de
    ld [hl+], a
    ld a, [de]
    inc de
    ld [hl+], a
    pop hl
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_073_4363
    push hl
    ld a, l
    sub a, $98
    ld l, a
    ld a, h
    sbc a, $C1
    ld h, a
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $D0
    ld h, a
    ld a, $02
    ldh [rSVBK], a
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    xor a, a
    ldh [rSVBK], a
    pop hl

Jump_073_4363::
    ld a, $14
    add_a_to_hl
    dec b
    jr nz, Jump_073_432D
    farcall Func_05F_6DDB
    ld hl, wScriptStep
    inc [hl]
    ret
    db $B0, $B1, $B1, $B1, $B2, $B6, $A4, $A5, $A6, $B7, $B3, $B4, $B4, $B4, $B5

; entry 2 of the `rst $00` table in ScriptCommand82_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC552
; writes: hFFC6, hFFC7, wScriptStep
; points at: wScriptStep
ScriptCommand82_Run_Table4_Case02::
Jump_073_4387:: ; address name
    ld a, [wC552]
    or a, a
    jr nz, Jump_073_43A7
    ld hl, $002F
    call StoreHLInWC924_B73
    ld hl, $0064
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    farcall Func_012_7E84
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_073_43A7::
    ld hl, $0036
    call StoreHLInWC924_B73
    ld a, $09
    ld [wScriptStep], a
    ret

; entry 0 of the `rst $00` table in ScriptCommand82_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand82_Run_Table4_Case00::
Jump_073_43B3:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld hl, $002E
    call StoreHLInWC924_B73
    ret

; 3 call sites from 3 routines (e.g. ScriptCommand82_Run_Table4_Case07, ScriptCommand82_Run_Table4_Case06, ScriptCommand82_Run_Table4_Case05)
; reads: wFrameCounterLo, wC46E, wC46B, wC46C, wC46D
; writes: wC46B, wC46C, wC46D
Func_073_43BE::
    ld a, [wFrameCounterLo]
    and a, $01
    ret z
    ld a, [wC46E]
    cp a, $03
    ret z
    or a, a
    jr nz, Jump_073_43E5
    ld a, [wC46B]
    add a, $02
    ld [wC46B], a
    and a, $F0
    swap a
    cp a, $0A
    jr nz, Jump_073_43E5
    ld a, [wC46B]
    and a, $0F
    ld [wC46B], a

Jump_073_43E5::
    ld a, [wC46E]
    cp a, $02
    jr z, Jump_073_4404
    ld a, [wC46C]
    add a, $01
    ld [wC46C], a
    and a, $F0
    swap a
    cp a, $0A
    jr nz, Jump_073_4404
    ld a, [wC46C]
    and a, $0F
    ld [wC46C], a

Jump_073_4404::
    ld a, [wC46D]
    add a, $04
    ld [wC46D], a
    and a, $F0
    swap a
    cp a, $0A
    jr nz, Jump_073_441C
    ld a, [wC46D]
    and a, $0F
    ld [wC46D], a

Jump_073_441C::
    ret

; 4 call sites from 4 routines (e.g. ScriptCommand82_Run_Table4_Case07, ScriptCommand82_Run_Table4_Case06, ScriptCommand82_Run_Table4_Case05, ScriptCommand82_Run_Table4_Case04)
; reads: wC46B, wC46C, wC46D
; writes: hFFC6, hFFC7
Func_073_441D::
    ld hl, vTiles1 + $240
    ld a, [wC46B]
    and a, $F0
    swap a
    push af
    ld de, $453A
    add a, e
    ld e, a
    jr nc, Jump_073_4430
    inc d

Jump_073_4430::
    ld a, [de]
    ldh [hFFC6], a
    pop af
    inc a
    cp a, $0A
    jr nz, Jump_073_443B
    ld a, $00

Jump_073_443B::
    ld de, $453A
    add a, e
    ld e, a
    jr nc, Jump_073_4443
    inc d

Jump_073_4443::
    ld a, [de]
    ldh [hFFC7], a
    ld a, [wC46B]
    call Func_073_44A5
    ld a, [wC46C]
    and a, $F0
    swap a
    push af
    ld de, $4544
    add a, e
    ld e, a
    jr nc, Jump_073_445C
    inc d

Jump_073_445C::
    ld a, [de]
    ldh [hFFC6], a
    pop af
    inc a
    cp a, $0A
    jr nz, Jump_073_4467
    ld a, $00

Jump_073_4467::
    ld de, $4544
    add a, e
    ld e, a
    jr nc, Jump_073_446F
    inc d

Jump_073_446F::
    ld a, [de]
    ldh [hFFC7], a
    ld a, [wC46C]
    call Func_073_44A5
    ld a, [wC46D]
    and a, $F0
    swap a
    push af
    ld de, $454E
    add a, e
    ld e, a
    jr nc, Jump_073_4488
    inc d

Jump_073_4488::
    ld a, [de]
    ldh [hFFC6], a
    pop af
    inc a
    cp a, $0A
    jr nz, Jump_073_4493
    ld a, $00

Jump_073_4493::
    ld de, $454E
    add a, e
    ld e, a
    jr nc, Jump_073_449B
    inc d

Jump_073_449B::
    ld a, [de]
    ldh [hFFC7], a
    ld a, [wC46D]
    call Func_073_44A5
    ret

; 3 call sites from 1 routine (e.g. Func_073_441D)
; reads: hFFC7, hFFC8, hFFC6
; writes: hFFC8
Func_073_44A5::
    and a, $0E
    ldh [hFFC8], a
    or a, a
    jr z, Jump_073_44CE
    ldh a, [hFFC7]
    swap a
    ld de, $44EA
    add a, e
    ld e, a
    jr nc, Jump_073_44B8
    inc d

Jump_073_44B8::
    ldh a, [hFFC8]
    ld c, a
    ld a, $10
    sub a, c
    add a, e
    ld e, a
    jr nc, Jump_073_44C3
    inc d

Jump_073_44C3::
    ldh a, [hFFC8]
    ld b, a

Jump_073_44C6::
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    dec b
    jr nz, Jump_073_44C6

Jump_073_44CE::
    ldh a, [hFFC8]
    ld c, a
    ld a, $10
    sub a, c
    ld b, a
    ldh a, [hFFC6]
    swap a
    ld de, $44EA
    add a, e
    ld e, a
    jr nc, Jump_073_44E1
    inc d

Jump_073_44E1::
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    dec b
    jr nz, Jump_073_44E1
    ret
    INCBIN "dwm2-cobi-us.gbc", $1CC4EA, $E6

; entry 8 of the `rst $00` table in ScriptCommand82_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptStep
ScriptCommand82_Run_Case08::
Jump_073_45D0:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw Func_073_44A5_Case00
    dw ScriptCommand82_Run_Table2_Case01
    dw Func_073_44A5_Case02
    dw Func_073_44A5_Case03
    dw Func_073_44A5_Case04
    dw Func_073_44A5_Case05
    dw ScriptCommand82_Run_Table2_Case01
    dw Func_073_4E9C

; entry 0 of the `rst $00` table in Func_073_44A5
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
Func_073_44A5_Case00::
Jump_073_45E4:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld hl, $4021
    call StoreHLInWC924_B73
    ret

; entry 2 of the `rst $00` table in Func_073_44A5
; no direct call (reached through a table, a jump or a vector)
; reads: wC552
; writes: wCE93, wCE94, wCE95, wCE96, wCE97, wCE98, wCE99, wCE9A, ...
; points at: wScriptStep
Func_073_44A5_Case02::
Jump_073_45EF:: ; address name
    ld a, [wC552]
    or a, a
    jr nz, Jump_073_4629
    ld hl, vTiles0 + $23
    call StoreHLInWC924_B73
    ld a, $FF
    ld [wCE93], a
    ld [wCE94], a
    ld [wCE95], a
    ld [wCE96], a
    ld [wCE97], a
    ld [wCE98], a
    ld [wCE99], a
    ld [wCE9A], a
    ld hl, $00C8
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    farcall Func_012_7E84
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_073_4629::
    ld hl, vTiles0 + $22
    call StoreHLInWC924_B73
    ld a, $06
    ld [wScriptStep], a
    ret

; entry 4 of the `rst $00` table in Func_073_44A5
; no direct call (reached through a table, a jump or a vector)
Func_073_44A5_Case04::
Jump_073_4635:: ; address name
    farcall Func_012_653F
    ret

; entry 5 of the `rst $00` table in Func_073_44A5
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
Func_073_44A5_Case05::
Jump_073_463C:: ; address name
    ld hl, $0052
    call StoreHLInWC924_B73
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in ScriptCommand82_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptStep
ScriptCommand82_Run_Case06::
Jump_073_4647:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw Func_073_44A5_Table2_Case00
    dw ScriptCommand82_Run_Table2_Case01
    dw Func_073_44A5_Table2_Case02
    dw ScriptCommand82_Run_Table2_Case01
    dw Func_073_44A5_Table2_Case04
    dw ScriptCommand82_Run_Table2_Case01
    dw Func_073_4E9C
    INCBIN "dwm2-cobi-us.gbc", $1CC659, $5A

; entry 4 of the `rst $00` table in Func_073_44A5
; no direct call (reached through a table, a jump or a vector)
; reads: wCD03, wC46B, wC46C, wScriptParam1, wC8C0, wC617, wC8C1, wC618, ...
; writes: wC46C, wC8C0, wC8C1, wC8C2, wC617, wC618, wC619, wScriptParam1, ...
; points at: wC17E, wC181, wScriptStep, wC152, wC016
Func_073_44A5_Table2_Case04::
Jump_073_46B3:: ; address name
    call NextRandomSeed
    ld a, [wCD03]
    and a, $0F
    cp a, $0D
    jr nc, Func_073_44A5_Table2_Case04
    ld [wC46C], a
    inc a
    ld [wC8C0], a
    xor a, a
    ld [wC8C1], a
    xor a, a
    ld [wC8C2], a
    call Number24ToPackedBCD
    ld de, wC17E
    call Func_000_23CA
    ld a, [wC46B]
    ld c, a
    ld a, [wC46C]
    cp a, c
    jr nz, Jump_073_46EA
    ld hl, vTiles0 + $18
    call StoreHLInWC924_B73
    jp Jump_073_4797

Jump_073_46EA::
    ld a, [wC552]
    or a, a
    jr nz, Jump_073_46FD
    ld a, [wC46B]
    ld c, a
    ld a, [wC46C]
    cp a, c
    jp c, Jump_073_4791
    jr Jump_073_470A

Jump_073_46FD::
    ld a, [wC46B]
    ld c, a
    ld a, [wC46C]
    cp a, c
    jp nc, Jump_073_4791
    jr Jump_073_470A

Jump_073_470A::
    ld a, [wScriptParam1]
    inc a
    ld [wScriptParam1], a
    ld a, [wScriptParam0]
    ld [wC46D], a
    ld a, [wScriptParam1]
    cp a, $05
    jr nz, Jump_073_473F
    ld hl, vTiles0 + $1C
    call StoreHLInWC924_B73
    ld a, [wC46D]
    ld de, wC152
    call Func_000_2431
    ld a, [wC46D]
    ld [wC928], a
    farcall Func_05F_6C8C
    ld a, $0E
    ld [wScriptStep], a
    ret

Jump_073_473F::
    call NextRandomSeed
    ld a, [wCD03]
    and a, $03
    ld hl, $4822
    add_a_to_hl
    ld a, [wScriptParam1]
    add a, a
    add a, a
    add_a_to_hl
    ld a, [hl]
    ld [wScriptParam0], a
    ld de, wC152
    call Func_000_2431
    ld a, [wScriptParam1]
    sla a
    ld hl, $4836
    add_a_to_hl
    ld a, [hl+]
    ld [wC8C0], a
    ld a, [hl]
    ld [wC8C1], a
    xor a, a
    ld [wC8C2], a
    call Number24ToPackedBCD
    ld de, wC181
    call Func_000_23CA
    ld hl, wC016
    call StoreHLInWC924_B73
    ld a, $08
    ld [wScriptStep], a
    ret

Jump_073_4791::
    ld hl, vTiles0 + $17
    call StoreHLInWC924_B73

Jump_073_4797::
    ld a, [wScriptParam1]
    add a, a
    ld hl, $4836
    add_a_to_hl
    ld a, [hl+]
    ld [wC8C0], a
    ld a, [hl]
    ld [wC8C1], a
    xor a, a
    ld [wC8C2], a
    ld a, [wC8C0]
    ld c, a
    ld a, [wC617]
    sub a, c
    ld [wC617], a
    ld a, [wC8C1]
    ld c, a
    ld a, [wC618]
    sbc a, c
    ld [wC618], a
    ld a, [wC619]
    sbc a, $00
    ld [wC619], a
    call Number24ToPackedBCD
    ld de, wC181
    call Func_000_23CA
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_073_44A5
; no direct call (reached through a table, a jump or a vector)
; reads: wC552
; writes: wC46B, wScriptStep
; points at: wScriptStep, wC014
Func_073_44A5_Table2_Case02::
Jump_073_47DB:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, [wC552]
    or a, a
    jr nz, Jump_073_47F1
    ld a, $06
    ld [wC46B], a
    ld hl, wC014
    call StoreHLInWC924_B73
    ret

Jump_073_47F1::
    ld hl, vTiles0 + $15
    call StoreHLInWC924_B73
    ld a, $10
    ld [wScriptStep], a
    ret

; entry 0 of the `rst $00` table in Func_073_44A5
; no direct call (reached through a table, a jump or a vector)
; reads: wCD03
; writes: wScriptParam0
; points at: wC152, wScriptStep
Func_073_44A5_Table2_Case00::
Jump_073_47FD:: ; address name
    call NextRandomSeed
    ld a, [wCD03]
    and a, $03
    ld hl, $4822
    add_a_to_hl
    ld a, [hl]
    ld [wScriptParam0], a
    ld de, wC152
    call Func_000_2431
    ld hl, $4013
    call StoreHLInWC924_B73
    ld hl, wScriptStep
    inc [hl]
    ret
    db $03, $22, $28, $2A, $0B, $25, $05, $2B, $0C, $23, $27, $2C, $11, $12, $26, $1E
    db $0D, $0E, $0F, $10, $64, $00, $2C, $01, $58, $02, $E8, $03, $DC, $05

; entry 9 of the `rst $00` table in ScriptCommand82_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptStep
ScriptCommand82_Run_Case09::
Jump_073_4840:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw Func_073_44A5_Table3_Case00
    dw ScriptCommand82_Run_Table2_Case01
    dw Func_073_44A5_Table3_Case02
    dw ScriptCommand82_Run_Table2_Case01
    dw ScriptCommand82_Run_Table2_Case02
    dw Func_073_44A5_Table3_Case05
    dw ScriptCommand82_Run_Table2_Case01
    dw Func_073_44A5_Table3_Case07
    dw ScriptCommand82_Run_Table2_Case01
    dw Func_073_44A5_Table3_Case09
    dw ScriptCommand82_Run_Table2_Case01
    dw Func_073_44A5_Table3_Case0B
    dw ScriptCommand82_Run_Table2_Case01
    dw Func_073_4E9C

; entry 0 of the `rst $00` table in Func_073_44A5
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
Func_073_44A5_Table3_Case00::
Jump_073_4860:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld hl, $4024
    call StoreHLInWC924_B73
    ret

; entry 2 of the `rst $00` table in Func_073_44A5
; no direct call (reached through a table, a jump or a vector)
; reads: wC552
; writes: wScriptStep
; points at: wScriptStep
Func_073_44A5_Table3_Case02::
Jump_073_486B:: ; address name
    ld a, [wC552]
    or a, a
    jr nz, Jump_073_487C
    ld hl, vTiles0 + $51
    call StoreHLInWC924_B73
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_073_487C::
    ld hl, vTiles0 + $50
    call StoreHLInWC924_B73
    ld a, $0C
    ld [wScriptStep], a
    ret

; entry 5 of the `rst $00` table in Func_073_44A5
; no direct call (reached through a table, a jump or a vector)
; reads: wD092
; points at: wScriptStep
Func_073_44A5_Table3_Case05::
Jump_073_4888:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, [wD092]
    or a, a
    jr nz, Jump_073_4899
    ld hl, $0025
    call StoreHLInWC924_B73
    ret

Jump_073_4899::
    ld hl, $0053
    call StoreHLInWC924_B73
    ret

; entry 7 of the `rst $00` table in Func_073_44A5
; no direct call (reached through a table, a jump or a vector)
; reads: wD092, wC6FD, wC6FF, hFFC6
; writes: wScriptStep, rRAMG
; points at: wScriptStep
Func_073_44A5_Table3_Case07::
Jump_073_48A0:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, [wD092]
    or a, a
    jr nz, Jump_073_48E9
    ld a, $00
    call Func_073_4956
    ld a, $00
    call Func_073_49E6
    ld a, $00
    call Func_073_4A0F
    ld a, [wC6FD]
    dec a
    jr nz, Jump_073_48CB

Jump_073_48BF::
    ld hl, $0026
    call StoreHLInWC924_B73
    ld a, $0C
    ld [wScriptStep], a
    ret

Jump_073_48CB::
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC6FF]
    ld c, $55
    call LoadSRAMRecordByte
    xor a, a
    ld [rRAMG], a
    ldh a, [hFFC6]
    bit 7, a
    jr nz, Jump_073_48BF
    ld hl, $4026
    call StoreHLInWC924_B73
    ret

Jump_073_48E9::
    ld hl, $000F
    call StoreHLInWC924_B73
    call Func_073_4C5D
    ld a, $0C
    ld [wScriptStep], a
    ret

; entry 9 of the `rst $00` table in Func_073_44A5
; no direct call (reached through a table, a jump or a vector)
; reads: wC6FD, wC700, hFFC6
; writes: wScriptStep, rRAMG
; points at: wScriptStep, wC026
Func_073_44A5_Table3_Case09::
Jump_073_48F8:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, $01
    call Func_073_4956
    ld a, $01
    call Func_073_49E6
    ld a, $01
    call Func_073_4A0F
    ld a, [wC6FD]
    dec a
    dec a
    jr nz, Jump_073_491E

Jump_073_4912::
    ld hl, vTiles0 + $26
    call StoreHLInWC924_B73
    ld a, $0C
    ld [wScriptStep], a
    ret

Jump_073_491E::
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC700]
    ld c, $55
    call LoadSRAMRecordByte
    xor a, a
    ld [rRAMG], a
    ldh a, [hFFC6]
    bit 7, a
    jr nz, Jump_073_4912
    ld hl, wC026
    call StoreHLInWC924_B73
    ret

; entry 11 of the `rst $00` table in Func_073_44A5
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
Func_073_44A5_Table3_Case0B::
Jump_073_493C:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld hl, vTiles0 + $26
    call StoreHLInWC924_B73
    ld a, $02
    call Func_073_4956
    ld a, $02
    call Func_073_49E6
    ld a, $02
    call Func_073_4A0F
    ret

; 3 call sites from 3 routines (e.g. Func_073_44A5_Table3_Case0B, Func_073_44A5_Table3_Case09, Func_073_44A5_Table3_Case07)
; reads: hFFC6, hFFC7
; writes: rRAMG, hFFC8
; points at: wC6FE
Func_073_4956::
    ld hl, wC6FE
    add_a_to_hl
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ldh [hFFC8], a
    ld a, [hl]
    ld c, $5D
    call LoadSRAMRecordWord
    ldh a, [hFFC6]
    ld e, a
    ldh a, [hFFC7]
    ld d, a
    ld b, $01
    ld a, [hl]
    ld c, $61
    call LoadSRAMRecordWord
    call Func_073_49B1
    ld b, $02
    ld a, [hl]
    ld c, $63
    call LoadSRAMRecordWord
    call Func_073_49B1
    ld b, $03
    ld a, [hl]
    ld c, $65
    call LoadSRAMRecordWord
    call Func_073_49B1
    ld b, $04
    ld a, [hl]
    ld c, $67
    call LoadSRAMRecordWord
    call Func_073_49B1
    ld b, $05
    ld a, [hl]
    ld c, $69
    call LoadSRAMRecordWord
    call Func_073_49B1
    xor a, a
    ld [rRAMG], a
    call Func_073_49C5
    ret

; 5 call sites from 1 routine (e.g. Func_073_4956)
; reads: hFFC7, hFFC6
; writes: hFFC8
Func_073_49B1::
    ldh a, [hFFC7]
    cp a, d
    jr c, Jump_073_49BB
    ret nz
    ldh a, [hFFC6]
    cp a, e
    ret nc

Jump_073_49BB::
    ld a, b
    ldh [hFFC8], a
    ldh a, [hFFC6]
    ld e, a
    ldh a, [hFFC7]
    ld d, a
    ret

; 1 call site from 1 routine (e.g. Func_073_4956)
; reads: hFFC8
; writes: wScriptParam0, wStringIndex, wStringCategory, wC53D, wC53E
; points at: wC152
Func_073_49C5::
    ldh a, [hFFC8]
    ld [wScriptParam0], a
    add a, $28
    ld [wStringIndex], a
    ld a, $05
    ld [wStringCategory], a
    ld hl, wC152
    ld a, l
    ld [wC53D], a
    ld a, h
    ld [wC53E], a
    farcall CopyStringToBuffer_Bank09
    ret

; 3 call sites from 3 routines (e.g. Func_073_44A5_Table3_Case0B, Func_073_44A5_Table3_Case09, Func_073_44A5_Table3_Case07)
; writes: rRAMG
; points at: wC6FE, wC8CF, wC147
Func_073_49E6::
    ld hl, wC6FE
    add_a_to_hl
    ld a, $0A
    ld [rRAMG], a
    ld a, [hl]
    ld c, $01
    call CopyRecordNameToWC8CF
    xor a, a
    ld [rRAMG], a
    ld hl, wC8CF
    ld de, wC147
    ld b, $0A

Jump_073_4A05::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_073_4A05
    ld a, $F0
    ld [de], a
    ret

; 3 call sites from 3 routines (e.g. Func_073_44A5_Table3_Case0B, Func_073_44A5_Table3_Case09, Func_073_44A5_Table3_Case07)
; reads: wScriptParam0, hFFC6, hFFC7, hFFC9, hFFC8
; writes: rRAMG, hFFC8, hFFC9, wC8C0, wC8C1, wC8C2
; points at: wC6FE, wC17E
Func_073_4A0F::
    ld hl, wC6FE
    add_a_to_hl
    ld a, $0A
    ld [rRAMG], a
    ld a, [wScriptParam0]
    ld de, $4A7C
    add a, e
    ld e, a
    jr nc, Jump_073_4A27
    inc d

Jump_073_4A27::
    ld a, [de]
    ld c, a
    ld a, [hl]
    call LoadSRAMRecordWord
    ldh a, [hFFC6]
    add a, $14
    ldh [hFFC8], a
    ldh a, [hFFC7]
    adc a, $00
    ldh [hFFC9], a
    ldh a, [hFFC9]
    cp a, $03
    jr nz, Jump_073_4A4E
    ldh a, [hFFC8]
    cp a, $E8
    jr c, Jump_073_4A4E
    ld de, $03E7
    ld a, e
    ldh [hFFC8], a
    ld a, d
    ldh [hFFC9], a

Jump_073_4A4E::
    ld a, [hl]
    call SRAMRecordAddress
    ldh a, [hFFC8]
    ld [hl+], a
    ldh a, [hFFC9]
    ld [hl], a
    xor a, a
    ld [rRAMG], a
    ldh a, [hFFC6]
    ld c, a
    ldh a, [hFFC8]
    sub a, c
    ld [wC8C0], a
    ldh a, [hFFC7]
    ld c, a
    ldh a, [hFFC9]
    sbc a, c
    ld [wC8C1], a
    xor a, a
    ld [wC8C2], a
    call Number24ToPackedBCD
    ld de, wC17E
    call Func_000_23CA
    ret
    db $5D, $61, $63, $65, $67, $69

; entry 7 of the `rst $00` table in ScriptCommand82_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptStep
ScriptCommand82_Run_Case07::
Jump_073_4A82:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw Func_073_4A0F_Case00
    dw ScriptCommand82_Run_Table2_Case01
    dw Func_073_4A0F_Case02
    dw ScriptCommand82_Run_Table2_Case01
    dw ScriptCommand82_Run_Table2_Case02
    dw Func_073_4A0F_Case05
    dw ScriptCommand82_Run_Table2_Case01
    dw Func_073_4A0F_Case07
    dw ScriptCommand82_Run_Table2_Case01
    dw Func_073_4E9C
    dw ScriptCommand82_Run_Table2_Case01
    dw Func_073_4A0F_Case0B

; entry 0 of the `rst $00` table in Func_073_4A0F
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
Func_073_4A0F_Case00::
Jump_073_4A9E:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld hl, $401D
    call StoreHLInWC924_B73
    ret

; entry 2 of the `rst $00` table in Func_073_4A0F
; no direct call (reached through a table, a jump or a vector)
; reads: wC552
; writes: wScriptStep
; points at: wScriptStep
Func_073_4A0F_Case02::
Jump_073_4AA9:: ; address name
    ld a, [wC552]
    or a, a
    jr nz, Jump_073_4ABA
    ld hl, vTiles0 + $4B
    call StoreHLInWC924_B73
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_073_4ABA::
    ld hl, vTiles0 + $4A
    call StoreHLInWC924_B73
    ld a, $08
    ld [wScriptStep], a
    ret

; entry 5 of the `rst $00` table in Func_073_4A0F
; no direct call (reached through a table, a jump or a vector)
; reads: wD092
; points at: wScriptStep
Func_073_4A0F_Case05::
Jump_073_4AC6:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, [wD092]
    or a, a
    jr nz, Jump_073_4AD7
    ld hl, $001E
    call StoreHLInWC924_B73
    ret

Jump_073_4AD7::
    ld hl, $001F
    call StoreHLInWC924_B73
    ret

; entry 7 of the `rst $00` table in Func_073_4A0F
; no direct call (reached through a table, a jump or a vector)
; reads: wD092, wCD03, wC928, wC634
; writes: wC928, wScriptStep
; points at: wScriptStep, wC152
Func_073_4A0F_Case07::
Jump_073_4ADE:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, [wD092]
    or a, a
    jr nz, Jump_073_4B21
    call NextRandomSeed
    ld a, [wCD03]
    and a, $03
    add a, $19
    ld [wC928], a
    farcall Func_05F_6C8C
    ld a, [wC928]
    ld de, wC152
    call Func_000_2431
    ld a, [wC634]
    or a, a
    jr z, Jump_073_4B15
    cp a, $FF
    jr z, Jump_073_4B15
    ld hl, $001B
    call StoreHLInWC924_B73
    ret

Jump_073_4B15::
    ld hl, $401B
    call StoreHLInWC924_B73
    ld a, $0A
    ld [wScriptStep], a
    ret

Jump_073_4B21::
    ld hl, $000F
    call StoreHLInWC924_B73
    call Func_073_4C5D
    ret

; entry 11 of the `rst $00` table in Func_073_4A0F
; no direct call (reached through a table, a jump or a vector)
; reads: wCD03, wC928, wC634
; writes: wC928, wScriptStep
; points at: wC152, wC01B, wScriptStep
Func_073_4A0F_Case0B::
Jump_073_4B2B:: ; address name
    call NextRandomSeed
    ld a, [wCD03]
    and a, $03
    add a, $19
    ld [wC928], a
    farcall Func_05F_6C8C
    ld a, [wC928]
    ld de, wC152
    call Func_000_2431
    ld a, [wC634]
    or a, a
    jr z, Jump_073_4B5D
    cp a, $FF
    jr z, Jump_073_4B5D
    ld hl, vTiles0 + $1B
    call StoreHLInWC924_B73
    ld a, $08
    ld [wScriptStep], a
    ret

Jump_073_4B5D::
    ld hl, wC01B
    call StoreHLInWC924_B73
    ld hl, wScriptStep
    dec [hl]
    ret

; entry 5 of the `rst $00` table in ScriptCommand82_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptStep
ScriptCommand82_Run_Case05::
Jump_073_4B68:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw Func_073_4A0F_Table2_Case00
    dw ScriptCommand82_Run_Table2_Case01
    dw Func_073_4A0F_Table2_Case02
    dw ScriptCommand82_Run_Table2_Case01
    dw ScriptCommand82_Run_Table2_Case02
    dw Func_073_4A0F_Table2_Case05
    dw ScriptCommand82_Run_Table2_Case01
    dw Func_073_4A0F_Table2_Case07
    dw ScriptCommand82_Run_Table2_Case01
    dw Func_073_4E9C

; entry 0 of the `rst $00` table in Func_073_4A0F
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
Func_073_4A0F_Table2_Case00::
Jump_073_4B80:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld hl, $4010
    call StoreHLInWC924_B73
    ret

; entry 2 of the `rst $00` table in Func_073_4A0F
; no direct call (reached through a table, a jump or a vector)
; reads: wC552
; writes: wScriptStep
; points at: wScriptStep
Func_073_4A0F_Table2_Case02::
Jump_073_4B8B:: ; address name
    ld a, [wC552]
    or a, a
    jr nz, Jump_073_4B9C
    ld hl, vTiles0 + $4F
    call StoreHLInWC924_B73
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_073_4B9C::
    ld hl, vTiles0 + $4E
    call StoreHLInWC924_B73
    ld a, $08
    ld [wScriptStep], a
    ret

; entry 5 of the `rst $00` table in Func_073_4A0F
; no direct call (reached through a table, a jump or a vector)
; reads: wD092
; points at: wScriptStep
Func_073_4A0F_Table2_Case05::
Jump_073_4BA8:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, [wD092]
    or a, a
    jr nz, Jump_073_4BB9
    ld hl, $0011
    call StoreHLInWC924_B73
    ret

Jump_073_4BB9::
    ld hl, $0012
    call StoreHLInWC924_B73
    call Func_073_4C5D
    ret

; entry 4 of the `rst $00` table in ScriptCommand82_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptStep
ScriptCommand82_Run_Case04::
Jump_073_4BC3:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw Func_073_4A0F_Table3_Case00
    dw ScriptCommand82_Run_Table2_Case01
    dw Func_073_4A0F_Table3_Case02
    dw ScriptCommand82_Run_Table2_Case01
    dw ScriptCommand82_Run_Table2_Case02
    dw Func_073_4A0F_Table3_Case05
    dw ScriptCommand82_Run_Table2_Case01
    dw Func_073_4A0F_Table2_Case07
    dw ScriptCommand82_Run_Table2_Case01
    dw Func_073_4E9C

; entry 0 of the `rst $00` table in Func_073_4A0F
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
Func_073_4A0F_Table3_Case00::
Jump_073_4BDB:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld hl, $400B
    call StoreHLInWC924_B73
    ret

; entry 2 of the `rst $00` table in Func_073_4A0F
; no direct call (reached through a table, a jump or a vector)
; reads: wC552
; writes: wScriptStep
; points at: wScriptStep
Func_073_4A0F_Table3_Case02::
Jump_073_4BE6:: ; address name
    ld a, [wC552]
    or a, a
    jr nz, Jump_073_4BF7
    ld hl, vTiles0 + $4D
    call StoreHLInWC924_B73
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_073_4BF7::
    ld hl, vTiles0 + $4C
    call StoreHLInWC924_B73
    ld a, $08
    ld [wScriptStep], a
    ret

; entry 5 of the `rst $00` table in Func_073_4A0F
; no direct call (reached through a table, a jump or a vector)
; reads: wD092
; points at: wScriptStep
Func_073_4A0F_Table3_Case05::
Jump_073_4C03:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, [wD092]
    or a, a
    jr nz, Jump_073_4C14
    ld hl, $000C
    call StoreHLInWC924_B73
    ret

Jump_073_4C14::
    ld hl, $000E
    call StoreHLInWC924_B73
    ret

; entry 7 of the `rst $00` table in Func_073_4A0F
; no direct call (reached through a table, a jump or a vector)
; reads: wD092, wC5E7, hFFC6
; writes: wC928
; points at: wScriptStep
Func_073_4A0F_Table2_Case07::
Jump_073_4C1B:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, [wD092]
    or a, a
    jr nz, Jump_073_4C53
    call NextTableByte
    ld a, [wC5E7]
    cp a, $10
    jr c, Jump_073_4C41

Jump_073_4C2F::
    ld hl, $000D
    call StoreHLInWC924_B73
    ld a, $29
    ld [wC928], a
    farcall Func_05F_6C8C
    ret

Jump_073_4C41::
    farcall Func_012_689A
    ldh a, [hFFC6]
    or a, a
    jr z, Jump_073_4C2F
    ld hl, $0043
    call StoreHLInWC924_B73
    ret

Jump_073_4C53::
    ld hl, $000F
    call StoreHLInWC924_B73
    call Func_073_4C5D
    ret

; 5 call sites from 5 routines (e.g. Func_073_4A0F_Table2_Case07, Func_073_4A0F_Table2_Case05, Func_073_4A0F_Case07, Func_073_44A5_Table3_Case07, ...)
; reads: wC617, wC618, wC619, wC8C0, wC8C1, wC8C2
; writes: wC8C0, wC8C1, wC8C2
; points at: wC17E
Func_073_4C5D::
    ld a, [wC617]
    ld [wC8C0], a
    ld a, [wC618]
    ld [wC8C1], a
    ld a, [wC619]
    ld [wC8C2], a
    farcall Func_012_7F1C
    ld a, [wC617]
    ld c, a
    ld a, [wC8C0]
    sub a, c
    ld [wC8C0], a
    ld a, [wC618]
    ld c, a
    ld a, [wC8C1]
    sbc a, c
    ld [wC8C1], a
    ld a, [wC619]
    ld c, a
    ld a, [wC8C2]
    sbc a, c
    ld [wC8C2], a
    call Number24ToPackedBCD
    ld de, wC17E
    call Func_000_23CA
    ret

; entry 3 of the `rst $00` table in ScriptCommand82_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptStep
ScriptCommand82_Run_Case03::
Jump_073_4CA0:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw Func_073_4C5D_Case00
    dw ScriptCommand82_Run_Table2_Case01
    dw Func_073_4C5D_Case02
    dw ScriptCommand82_Run_Table2_Case01
    dw Func_073_4E9C

; entry 0 of the `rst $00` table in Func_073_4C5D
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wC8C0, wC8C1, wC8C2
; points at: wScriptStep, wC152, wC17E
Func_073_4C5D_Case00::
Jump_073_4CAE:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld hl, $4008
    call StoreHLInWC924_B73
    call Func_073_4FD2
    ld a, [wScriptParam0]
    ld de, wC152
    call Func_000_2431
    ld a, [wScriptParam0]
    call Func_073_4FB7
    ld e, l
    ld d, h
    add hl, hl
    add hl, hl
    add hl, de
    ld a, l
    ld [wC8C0], a
    ld a, h
    ld [wC8C1], a
    xor a, a
    ld [wC8C2], a
    call Number24ToPackedBCD
    ld de, wC17E
    call Func_000_23CA
    ret

; entry 2 of the `rst $00` table in Func_073_4C5D
; no direct call (reached through a table, a jump or a vector)
; reads: wC552, wScriptParam0
; writes: wC928, hFFC6, hFFC7
; points at: wScriptStep
Func_073_4C5D_Case02::
Jump_073_4CE5:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, [wC552]
    or a, a
    jr nz, Jump_073_4D19
    ld a, [wScriptParam0]
    ld [wC928], a
    farcall Func_05F_6C8C
    ld a, [wScriptParam0]
    call Func_073_4FB7
    ld e, l
    ld d, h
    add hl, hl
    add hl, hl
    add hl, de
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    farcall Func_012_7E84
    ld hl, vTiles0 + $9
    call StoreHLInWC924_B73
    ret

Jump_073_4D19::
    ld hl, vTiles0 + $A
    call StoreHLInWC924_B73
    ret

; entry 2 of the `rst $00` table in ScriptCommand82_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptStep
ScriptCommand82_Run_Case02::
Jump_073_4D20:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw Func_073_4C5D_Table2_Case00
    dw ScriptCommand82_Run_Table2_Case01
    dw Func_073_4C5D_Table2_Case02
    dw Func_073_44A5_Case03
    dw ScriptCommand82_Run_Table3_Case07
    dw Func_073_4C5D_Table2_Case05
    dw ScriptCommand82_Run_Table3_Case09
    dw ScriptCommand82_Run_Table2_Case01
    dw Func_073_4E9C

; entry 0 of the `rst $00` table in Func_073_4C5D
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
Func_073_4C5D_Table2_Case00::
Jump_073_4D36:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld hl, $4005
    call StoreHLInWC924_B73
    ret

; entry 2 of the `rst $00` table in Func_073_4C5D
; no direct call (reached through a table, a jump or a vector)
; reads: wC552
; points at: wScriptStep
Func_073_4C5D_Table2_Case02::
Jump_073_4D41:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, [wC552]
    or a, a
    jr nz, Jump_073_4D52
    ld hl, vTiles0 + $27
    call StoreHLInWC924_B73
    ret

Jump_073_4D52::
    ld hl, wScriptStep
    inc [hl]
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in Func_073_4C5D
; no direct call (reached through a table, a jump or a vector)
; reads: wC924
; writes: hFFC6, hFFC7
; points at: wScriptStep
Func_073_4C5D_Table2_Case05::
Jump_073_4D5B:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, [wC924]
    cp a, $27
    jr nz, Jump_073_4D82
    ld hl, $03E8
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    farcall Func_012_7E84
    farcall Func_012_64F8
    ld hl, $0006
    call StoreHLInWC924_B73
    ret

Jump_073_4D82::
    ld hl, vTiles0 + $7
    call StoreHLInWC924_B73
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand82_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptStep
ScriptCommand82_Run_Case01::
Jump_073_4D8D:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw Func_073_4C5D_Table3_Case00
    dw ScriptCommand82_Run_Table2_Case01
    dw Func_073_4C5D_Table3_Case02
    dw ScriptCommand82_Run_Table2_Case01
    dw Func_073_4E9C

; entry 0 of the `rst $00` table in Func_073_4C5D
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wC8C0, wC8C1, wC8C2
; points at: wScriptStep, wC152, wC17E
Func_073_4C5D_Table3_Case00::
Jump_073_4D9B:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld hl, $4002
    call StoreHLInWC924_B73
    call Func_073_4FD2
    ld a, [wScriptParam0]
    ld de, wC152
    call Func_000_2431
    ld a, [wScriptParam0]
    call Func_073_4FB7
    ld a, l
    ld [wC8C0], a
    ld a, h
    ld [wC8C1], a
    xor a, a
    ld [wC8C2], a
    call Number24ToPackedBCD
    ld de, wC17E
    call Func_000_23CA
    ret

; entry 2 of the `rst $00` table in Func_073_4C5D
; no direct call (reached through a table, a jump or a vector)
; reads: wC552, wScriptParam0
; writes: wC928, hFFC6, hFFC7
; points at: wScriptStep
Func_073_4C5D_Table3_Case02::
Jump_073_4DCD:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, [wC552]
    or a, a
    jr nz, Jump_073_4DFC
    ld a, [wScriptParam0]
    ld [wC928], a
    farcall Func_05F_6C8C
    ld a, [wScriptParam0]
    call Func_073_4FB7
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    farcall Func_012_7E84
    ld hl, vTiles0 + $3
    call StoreHLInWC924_B73
    ret

Jump_073_4DFC::
    ld hl, vTiles0 + $4
    call StoreHLInWC924_B73
    ret

; entry 0 of the `rst $00` table in ScriptCommand82_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptStep
ScriptCommand82_Run_Case00::
Jump_073_4E03:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw Func_073_4C5D_Table4_Case00
    dw Func_073_44A5_Case03
    dw ScriptCommand82_Run_Table3_Case07
    dw ScriptCommand82_Run_Table3_Case08
    dw ScriptCommand82_Run_Table3_Case09
    dw ScriptCommand82_Run_Table2_Case01
    dw Func_073_4E9C

; entry 0 of the `rst $00` table in Func_073_4C5D
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
Func_073_4C5D_Table4_Case00::
Jump_073_4E15:: ; address name
    ld hl, $0000
    call StoreHLInWC924_B73
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in Func_073_44A5
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; points at: wC49F, wC0F0, wScriptStep
Func_073_44A5_Case03::
Jump_073_4E20:: ; address name
    xor a, a
    call Func_073_4FA9
    ret nc
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_073_4E37
    ld hl, wC49F
    ld de, wC0F0
    ld bc, $0040
    call CopyBytes

Jump_073_4E37::
    ld a, $7A
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in ScriptCommand82_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand82_Run_Table3_Case07::
Jump_073_4E41:: ; address name
    farcall Func_012_653F
    ret

; entry 8 of the `rst $00` table in ScriptCommand82_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0
; points at: wScriptStep
ScriptCommand82_Run_Table3_Case08::
Jump_073_4E48:: ; address name
    farcall Func_012_64F8
    ld hl, $0001
    call StoreHLInWC924_B73
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand82_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand82_Run_Table2_Case01::
Jump_073_4E5D:: ; address name
    xor a, a
    call Func_073_4FA9
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in ScriptCommand82_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wScriptParam0, hFF8D, wC527
; points at: wScriptStep
ScriptCommand82_Run_Table3_Case09::
Jump_073_4E67:: ; address name
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_073_4E76
    inc a
    ld [wScriptParam0], a
    ld a, $0E
    ldh [hFF8D], a
    ret

Jump_073_4E76::
    farcall Func_002_5E85
    farcall Func_002_5E85
    call Func_000_222B
    farcall Func_004_4AA8
    ld a, $7F
    ld [wC527], a
    xor a, a
    ldh [hFF8D], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. ScriptCommand47_Run_Case01)
; reads: wScriptParam0
; writes: wSpriteSlotCount, wScriptParam0, wScriptStartRequest, wC935
Func_073_4E9C::
    ld a, [wScriptParam0]
    cp a, $1E
    jr nc, Jump_073_4EA9
    bit 3, a
    jr z, Jump_073_4EB9
    jr Jump_073_4EC0

Jump_073_4EA9::
    cp a, $3C
    jr nc, Jump_073_4EB3
    bit 2, a
    jr z, Jump_073_4EB9
    jr Jump_073_4EC0

Jump_073_4EB3::
    bit 1, a
    jr z, Jump_073_4EB9
    jr Jump_073_4EC0

Jump_073_4EB9::
    ld a, $01
    ld [wSpriteSlotCount], a
    jr Jump_073_4EC4

Jump_073_4EC0::
    xor a, a
    ld [wSpriteSlotCount], a

Jump_073_4EC4::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $78
    ret nz
    ld a, $80
    ld [wScriptStartRequest], a
    xor a, a
    ld [wC935], a
    ret

; HL is stored in wC924 (low) and wC925 (high); then wC926 = 0
; 77 call sites from 42 routines (e.g. Func_073_4C5D_Table4_Case00, Func_073_4C5D_Table3_Case02, Func_073_4C5D_Table3_Case00, Func_073_4C5D_Table2_Case05, ...)
; writes: wC924, wC925, wC926
StoreHLInWC924_B73::
Func_073_4ED8:: ; address name
    ld a, l
    ld [wC924], a
    ld a, h
    ld [wC925], a
    xor a, a
    ld [wC926], a
    ret

; 1 call site from 1 routine (e.g. Func_073_4FA9)
; reads: wC926
Func_073_4EE5::
    push af
    ld a, [wC926]
    cp a, $FF
    jr nz, Jump_073_4EEF
    pop af
    ret

Jump_073_4EEF::
    rst $00
    dw Func_073_4EE5_Case00
    dw Func_073_4EE5_Case01
    dw Func_073_4EE5_Case02
    dw Func_073_4EE5_Case03

; entry 0 of the `rst $00` table in Func_073_4EE5
; no direct call (reached through a table, a jump or a vector)
; reads: wC925, hPlayerY
; writes: wC8CB, wC8CC, hFFB9
; points at: wC926
Func_073_4EE5_Case00::
Jump_073_4EF8:: ; address name
    pop af
    or a, a
    jr nz, Jump_073_4F02
    farcall Func_004_4470

Jump_073_4F02::
    ld a, [wC925]
    bit 7, a
    jr nz, Jump_073_4F37
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    call FillTilesFromRequest
    ld a, $69
    call QueueSoundEffect
    ld a, $01
    ld [wC8CB], a
    ld a, $00
    ld [wC8CC], a
    ld a, $02
    ldh [hFFB9], a
    ldh a, [hPlayerY]
    cp a, $48
    jr c, Jump_073_4F37
    ld a, $81
    ld [wC8CB], a
    ld a, $01
    ldh [hFFB9], a

Jump_073_4F37::
    ld hl, wC926
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_073_4EE5
; no direct call (reached through a table, a jump or a vector)
; reads: wC8CB, wC924
; writes: wStringIndex, wStringCategory
; points at: wC926
Func_073_4EE5_Case01::
Jump_073_4F3C:: ; address name
    pop af
    ld a, [wC8CB]
    and a, $03
    ret nz
    ld a, [wC924]
    ld [wStringIndex], a
    ld a, $05
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank09
    ld hl, wC926
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_073_4EE5
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wC925, hPlayerY
; writes: wC926, wC8CB, wC8CC, hFFB9
; points at: wC926
Func_073_4EE5_Case02::
Jump_073_4F59:: ; address name
    pop af
    ld a, [wC52B]
    bit 0, a
    ret nz
    ld a, [wC925]
    bit 6, a
    jr z, Jump_073_4F6D
    ld a, $FF
    ld [wC926], a
    ret

Jump_073_4F6D::
    ld a, $69
    call QueueSoundEffect
    ld a, $02
    ld [wC8CB], a
    ld a, $00
    ld [wC8CC], a
    ld a, $00
    ldh [hFFB9], a
    ldh a, [hPlayerY]
    cp a, $48
    jr c, Jump_073_4F8B
    ld a, $82
    ld [wC8CB], a

Jump_073_4F8B::
    ld hl, wC926
    inc [hl]
    ret

; entry 3 of the `rst $00` table in Func_073_4EE5
; no direct call (reached through a table, a jump or a vector)
; reads: wC8CB
; writes: wC926
Func_073_4EE5_Case03::
Jump_073_4F90:: ; address name
    ld a, [wC8CB]
    and a, $03
    jr z, Jump_073_4F99
    pop af
    ret

Jump_073_4F99::
    pop af
    or a, a
    jr nz, Jump_073_4FA3
    farcall Func_004_449F

Jump_073_4FA3::
    ld a, $FF
    ld [wC926], a
    ret

; 2 call sites from 2 routines (e.g. Func_073_44A5_Case03, ScriptCommand82_Run_Table2_Case01)
; reads: wC926
Func_073_4FA9::
    call Func_073_4EE5
    ld a, [wC926]
    cp a, $FF
    jr z, Jump_073_4FB5
    sub a, a
    ret

Jump_073_4FB5::
    scf
    ret

; 5 call sites from 5 routines (e.g. Func_073_4C5D_Table3_Case02, Func_073_4C5D_Table3_Case00, Func_073_516B, Func_073_4C5D_Case02, ...)
Func_073_4FB7::
    ld c, $0D
    call Multiply8
    ld a, l
    add a, $C3
    ld l, a
    ld a, h
    adc a, $4C
    ld h, a
    ld e, l
    ld d, h
    ld b, $16
    call ReadByteInBank
    ld l, c
    inc de
    call ReadByteInBank
    ld h, c
    ret

; 2 call sites from 2 routines (e.g. Func_073_4C5D_Table3_Case00, Func_073_4C5D_Case00)
; reads: wC92C, wC6FD, wD7AA, hFFC9, hFFC8
; writes: wScriptParam0
Func_073_4FD2::
    farcall Func_05F_6CA9
    ld a, [wC92C]
    or a, a
    jr z, Jump_073_4FE8
    ld a, $0C
    ld [wScriptParam0], a
    call Func_073_516B
    or a, a
    ret nz

Jump_073_4FE8::
    farcall Func_05F_6D0D
    ld a, [wC92C]
    or a, a
    jr z, Jump_073_4FFE
    ld a, $08
    ld [wScriptParam0], a
    call Func_073_516B
    or a, a
    ret nz

Jump_073_4FFE::
    farcall Func_05F_6CDB
    ld a, [wC92C]
    or a, a
    jr z, Jump_073_5014
    ld a, $06
    ld [wScriptParam0], a
    call Func_073_516B
    or a, a
    ret nz

Jump_073_5014::
    ld a, [wC6FD]
    cp a, $03
    jr z, Jump_073_505C
    farcall Func_01D_5E3F
    ld a, [wD7AA]
    cp a, $03
    jr nc, Jump_073_5032
    ld a, $19
    ld [wScriptParam0], a
    call Func_073_516B
    or a, a
    ret nz

Jump_073_5032::
    ld a, [wD7AA]
    cp a, $03
    jr c, Jump_073_5047
    cp a, $06
    jr nc, Jump_073_5047
    ld a, $1A
    ld [wScriptParam0], a
    call Func_073_516B
    or a, a
    ret nz

Jump_073_5047::
    ld a, [wD7AA]
    cp a, $06
    jr c, Jump_073_505C
    cp a, $0B
    jr nc, Jump_073_505C
    ld a, $1B
    ld [wScriptParam0], a
    call Func_073_516B
    or a, a
    ret nz

Jump_073_505C::
    call Func_073_5117
    ldh a, [hFFC9]
    or a, a
    jr nz, Jump_073_506A
    ldh a, [hFFC8]
    cp a, $65
    jr c, Jump_073_5074

Jump_073_506A::
    ld a, $05
    ld [wScriptParam0], a
    call Func_073_516B
    or a, a
    ret nz

Jump_073_5074::
    ldh a, [hFFC9]
    or a, a
    jr nz, Jump_073_508C
    ldh a, [hFFC8]
    cp a, $65
    jr nc, Jump_073_508C
    or a, a
    jr z, Jump_073_508C
    ld a, $04
    ld [wScriptParam0], a
    call Func_073_516B
    or a, a
    ret nz

Jump_073_508C::
    call Func_073_50C3
    ldh a, [hFFC9]
    or a, a
    jr nz, Jump_073_509A
    ldh a, [hFFC8]
    cp a, $65
    jr c, Jump_073_50A4

Jump_073_509A::
    ld a, $03
    ld [wScriptParam0], a
    call Func_073_516B
    or a, a
    ret nz

Jump_073_50A4::
    ldh a, [hFFC9]
    or a, a
    jr nz, Jump_073_50BD
    ldh a, [hFFC8]
    cp a, $33
    jr c, Jump_073_50BD
    cp a, $64
    jr nc, Jump_073_50BD
    ld a, $02
    ld [wScriptParam0], a
    call Func_073_516B
    or a, a
    ret nz

Jump_073_50BD::
    ld a, $01
    ld [wScriptParam0], a
    ret

; 1 call site from 1 routine (e.g. Func_073_4FD2)
; reads: wC6FD, hFFC6, hFFC7, hFFC8, hFFC9
; writes: hFFC8, hFFC9, rRAMG
; points at: wC6FE
Func_073_50C3::
    ld hl, $0000
    ld a, l
    ldh [hFFC8], a
    ld a, h
    ldh [hFFC9], a
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC6FD]
    or a, a
    jr z, Jump_073_5112
    ld b, a
    ld hl, wC6FE

Jump_073_50DB::
    ld a, [hl]
    ld c, $5D
    call LoadSRAMRecordWord
    push hl
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ldh a, [hFFC8]
    ld e, a
    ldh a, [hFFC9]
    ld d, a
    add hl, de
    ld a, l
    ldh [hFFC8], a
    ld a, h
    ldh [hFFC9], a
    pop hl
    ld a, [hl]
    ld c, $5B
    call LoadSRAMRecordWord
    push hl
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ldh a, [hFFC8]
    sub a, l
    ldh [hFFC8], a
    ldh a, [hFFC9]
    sbc a, h
    ldh [hFFC9], a
    pop hl
    inc hl
    dec b
    jr nz, Jump_073_50DB

Jump_073_5112::
    xor a, a
    ld [rRAMG], a
    ret

; 1 call site from 1 routine (e.g. Func_073_4FD2)
; reads: wC6FD, hFFC6, hFFC7, hFFC8, hFFC9
; writes: hFFC8, hFFC9, rRAMG
; points at: wC6FE
Func_073_5117::
    ld hl, $0000
    ld a, l
    ldh [hFFC8], a
    ld a, h
    ldh [hFFC9], a
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC6FD]
    or a, a
    jr z, Jump_073_5166
    ld b, a
    ld hl, wC6FE

Jump_073_512F::
    ld a, [hl]
    ld c, $61
    call LoadSRAMRecordWord
    push hl
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ldh a, [hFFC8]
    ld e, a
    ldh a, [hFFC9]
    ld d, a
    add hl, de
    ld a, l
    ldh [hFFC8], a
    ld a, h
    ldh [hFFC9], a
    pop hl
    ld a, [hl]
    ld c, $5F
    call LoadSRAMRecordWord
    push hl
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ldh a, [hFFC8]
    sub a, l
    ldh [hFFC8], a
    ldh a, [hFFC9]
    sbc a, h
    ldh [hFFC9], a
    pop hl
    inc hl
    dec b
    jr nz, Jump_073_512F

Jump_073_5166::
    xor a, a
    ld [rRAMG], a
    ret

; 10 call sites from 1 routine (e.g. Func_073_4FD2)
; reads: wC935, wC619, wC618, wC617
Func_073_516B::
    call Func_073_4FB7
    ld a, [wC935]
    and a, $0F
    dec a
    jr z, Jump_073_517B
    ld e, l
    ld d, h
    add hl, hl
    add hl, hl
    add hl, de

Jump_073_517B::
    ld a, [wC619]
    or a, a
    jr z, Jump_073_5184

Jump_073_5181::
    ld a, $01
    ret

Jump_073_5184::
    ld a, [wC618]
    cp a, h
    jr c, Jump_073_5192
    jr nz, Jump_073_5181
    ld a, [wC617]
    cp a, l
    jr nc, Jump_073_5181

Jump_073_5192::
    xor a, a
    ret

; entry 2 of the `rst $00` table in ScriptCommand82_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wC903, wC905, wModeState, wC904, wC8C7
; points at: wScriptStep
ScriptCommand82_Run_Table2_Case02::
Jump_073_5194:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, $06
    ld [wC903], a
    ld a, $01
    ld [wC905], a
    ld a, $03
    ld [wModeState], a
    xor a, a
    ld [wC904], a
    ld a, $02
    ld [wC8C7], a
    farcall Func_002_5EEE
    farcall Func_00A_476E
    ret

; implements script command type CB; reached through ScriptCommandCB in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommandCB)
; reads: wScriptStep
ScriptCommandCB_Run::
Func_073_51BD:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommandCB_Run_Case00
    dw ScriptCommandCB_Run_Case01
    dw ScriptCommandCB_Run_Case02
    dw ScriptCommandCB_Run_Case03
    dw ScriptCommandCB_Run_Case01
    dw ScriptCommandCB_Run_Case05
    dw ScriptCommandCB_Run_Case06
    dw ScriptCommandCB_Run_Case07
    dw ScriptCommandCB_Run_Case08
    dw ScriptCommandCB_Run_Case09
    dw ScriptCommandCB_Run_Case07

; entry 9 of the `rst $00` table in ScriptCommandCB_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1, wCB8A, wScriptParam0
; writes: wCB8A, wScriptParam0, wCB86
; points at: wCB8C, wScriptStep
ScriptCommandCB_Run_Case09::
Jump_073_51D7:: ; address name
    ld a, [wScriptParam1]
    ld c, a
    ld a, [wCB8A]
    add a, c
    ld [wCB8A], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $10
    ret nz
    xor a, a
    ld [wCB86], a
    ld hl, wCB8C
    call ClearBit2AtHL_Bank73
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in ScriptCommandCB_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hMapId
; writes: wScriptStartRequest
ScriptCommandCB_Run_Case07::
Jump_073_51FB:: ; address name
    ldh a, [hMapId]
    sub a, $C8
    add a, a
    ld hl, $5215
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    call SetFlagBit
    ld a, $80
    ld [wScriptStartRequest], a
    ret
    db $00, $00, $00, $00, $D4, $01, $D9, $01, $DD, $01, $6A, $01, $6E, $01, $00, $00
    db $00, $00, $00, $00, $00, $00, $74, $01, $78, $01, $7C, $01, $D5, $00, $D9, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $DF, $00, $F8, $00, $FC, $00, $F2, $01
    db $F6, $01, $00, $00, $00, $00

; entry 6 of the `rst $00` table in ScriptCommandCB_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hFFC6
; writes: hFFC6, hFFC7, wSpriteSlotCount
; points at: wScriptStep
ScriptCommandCB_Run_Case06::
Jump_073_524B:: ; address name
    xor a, a
    ldh [hFFC6], a
    ld a, $30
    ldh [hFFC7], a
    farcall Func_05F_6BF8
    ldh a, [hFFC6]
    or a, a
    ret z
    xor a, a
    ld [wSpriteSlotCount], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in ScriptCommandCB_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hMapId
; writes: hFFC6, wScriptStep
; points at: wScriptStep
ScriptCommandCB_Run_Case05::
Jump_073_5265:: ; address name
    ldh a, [hMapId]
    cp a, $CE
    jr z, Jump_073_5278
    cp a, $D7
    jr z, Jump_073_528A
    cp a, $E0
    jr z, Jump_073_529C
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_073_5278::
    ld a, $0A
    ldh [hFFC6], a
    farcall Func_05F_6DAC
    ld de, $0206
    call SetFlagBit
    jr Jump_073_52AC

Jump_073_528A::
    ld a, $0B
    ldh [hFFC6], a
    farcall Func_05F_6DAC
    ld de, $0207
    call SetFlagBit
    jr Jump_073_52AC

Jump_073_529C::
    ld a, $0C
    ldh [hFFC6], a
    farcall Func_05F_6DAC
    ld de, $0208
    call SetFlagBit

Jump_073_52AC::
    ld a, $08
    ld [wScriptStep], a
    ret

; entry 3 of the `rst $00` table in ScriptCommandCB_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommandCB_Run_Case03::
Jump_073_52B2:: ; address name
    ld de, $5342
    call Func_073_52F5
    ret

; entry 2 of the `rst $00` table in ScriptCommandCB_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hMapId
; writes: hFFC6
; points at: wScriptStep
ScriptCommandCB_Run_Case02::
Jump_073_52B9:: ; address name
    ldh a, [hMapId]
    sub a, $C8
    ld de, $52D3
    add a, e
    ld e, a
    jr nc, Jump_073_52C5
    inc d

Jump_073_52C5::
    ld a, [de]
    ldh [hFFC6], a
    farcall Func_00A_47A4
    ld hl, wScriptStep
    inc [hl]
    ret
    db $00, $00, $20, $21, $22, $23, $24, $00, $00, $00, $00, $25, $26, $27, $28, $29
    db $00, $00, $00, $00, $2A, $2B, $2C, $2D, $2E, $00, $00

; entry 0 of the `rst $00` table in ScriptCommandCB_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommandCB_Run_Case00::
Jump_073_52EE:: ; address name
    ld de, $530C
    call Func_073_52F5
    ret

; 2 call sites from 2 routines (e.g. ScriptCommandCB_Run_Case03, ScriptCommandCB_Run_Case00)
; reads: hMapId
; points at: wScriptStep
Func_073_52F5::
    ldh a, [hMapId]
    sub a, $C8
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_073_52FF
    inc d

Jump_073_52FF::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    call StoreHLInWC924_B73b
    ld hl, wScriptStep
    inc [hl]
    ret
    INCBIN "dwm2-cobi-us.gbc", $1CD30C, $6C

; implements script command type CA; reached through ScriptCommandCA in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommandCA)
; reads: hFFC6, wCC3F
; writes: hFFC6, hFFC7, wCC3F, wCB9A, wCB9B, wScriptStartRequest
ScriptCommandCA_Run::
Func_073_5378:: ; address name
    xor a, a
    ldh [hFFC6], a
    ld a, $20
    ldh [hFFC7], a
    farcall Func_05F_6BF8
    ldh a, [hFFC6]
    or a, a
    ret z
    ld a, $09
    ldh [hFFC6], a
    farcall Func_05F_6DAC
    ld a, [wCC3F]
    set 1, a
    ld [wCC3F], a
    ld a, $50
    ld [wCB9A], a
    ld a, $70
    ld [wCB9B], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type C9; reached through ScriptCommandC9 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommandC9)
; reads: wScriptStep
ScriptCommandC9_Run::
Func_073_53AB:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommandCB_Run_Case08
    dw ScriptCommandC9_Run_Case01

; entry 1 of the `rst $00` table in ScriptCommandC9_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1, wCB8A, wScriptParam0
; writes: wCB8A, wScriptParam0, wCB86, wScriptStartRequest
; points at: wCB8C
ScriptCommandC9_Run_Case01::
Jump_073_53B3:: ; address name
    ld a, [wScriptParam1]
    ld c, a
    ld a, [wCB8A]
    add a, c
    ld [wCB8A], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $10
    ret nz
    xor a, a
    ld [wCB86], a
    ld hl, wCB8C
    call ClearBit2AtHL_Bank73
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 8 of the `rst $00` table in ScriptCommandCB_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX, hPlayerY, wC6FD
; writes: wScriptParam1, wCB86
; points at: wCB8C, wScriptStep, wC8F0
ScriptCommandCB_Run_Case08::
Jump_073_53D8:: ; address name
    ld hl, wCB8C
    call SetBit2AtHL_B73
    ld hl, wScriptStep
    inc [hl]
    ldh a, [hPlayerX]
    cp a, $30
    jr nz, Jump_073_53EE
    ldh a, [hPlayerY]
    cp a, $20
    jr z, Jump_073_5412

Jump_073_53EE::
    ld a, [wC6FD]
    ld b, a
    ld hl, wC8F0

Jump_073_53F5::
    push hl
    ld a, [hl+]
    cp a, $30
    jr nz, Jump_073_5400
    ld a, [hl]
    cp a, $20
    jr z, Jump_073_5411

Jump_073_5400::
    pop hl
    inc hl
    inc hl
    dec b
    jr nz, Jump_073_53F5
    ld a, $FF
    ld [wScriptParam1], a
    ld a, $03
    ld [wCB86], a
    ret

Jump_073_5411::
    pop hl

Jump_073_5412::
    ld a, $01
    ld [wScriptParam1], a
    ld a, $01
    ld [wCB86], a
    ret

; implements script command type C8; reached through ScriptCommandC8 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommandC8)
; reads: wCB8B
; writes: wCBAB, wCB86, wCB96, wCB8B, wCB9B, wScriptStartRequest
; points at: wCB8C, wCB9C
ScriptCommandC8_Run::
Func_073_541D:: ; address name
    ld a, $10
    ld [wCBAB], a
    xor a, a
    ld [wCB86], a
    ld [wCB96], a
    ld hl, wCB8C
    call SetBit2AtHL_B73
    ld hl, wCB9C
    call SetBit2AtHL_B73
    ld a, [wCB8B]
    inc a
    inc a
    ld [wCB8B], a
    ld [wCB9B], a
    cp a, $B0
    ret nz
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type C5; reached through ScriptCommandC5 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommandC5)
; reads: wScriptStep
ScriptCommandC5_Run::
Func_073_5449:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommandC5_Run_Case00
    dw ScriptCommandC5_Run_Case01
    dw ScriptCommandC5_Run_Case02
    dw ScriptCommandCB_Run_Case01
    dw ScriptCommandC5_Run_Case04
    dw ScriptCommandC5_Run_Case05
    dw ScriptCommandCB_Run_Case01
    dw ScriptCommandC5_Run_Case07
    dw ScriptCommandC5_Run_Case08
    dw ScriptCommandC5_Run_Case09

; entry 8 of the `rst $00` table in ScriptCommandC5_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommandC5_Run_Case08::
Jump_073_5461:: ; address name
    ld hl, $0782
    call StoreHLInWC924_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in ScriptCommandC5_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCB8B, wC92C, hPlayerFacing
; writes: wC929, wC92A, wC928, wCB86
; points at: wScriptStep
ScriptCommandC5_Run_Case07::
Jump_073_546C:: ; address name
    ld a, [wCB8B]
    cp a, $40
    jr z, Jump_073_5488
    xor a, a
    ld [wC929], a
    ld a, $00
    ld [wC92A], a
    ld a, $40
    ld [wC928], a
    farcall Func_05F_6B54
    ret

Jump_073_5488::
    xor a, a
    ld [wC929], a
    ld a, $03
    ld [wC92A], a
    ld a, $10
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ldh a, [hPlayerFacing]
    inc a
    inc a
    and a, $03
    ld [wCB86], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in ScriptCommandC5_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommandC5_Run_Case05::
Jump_073_54AF:: ; address name
    ld hl, $0781
    call StoreHLInWC924_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in ScriptCommandC5_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommandC5_Run_Case04::
Jump_073_54BA:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in ScriptCommandC5_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommandC5_Run_Case02::
Jump_073_54BF:: ; address name
    ld hl, $0780
    call StoreHLInWC924_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommandC5_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCB8A, wC92C
; writes: wC929, wC92A, wC928, wCB86
; points at: wScriptStep
ScriptCommandC5_Run_Case01::
Jump_073_54CA:: ; address name
    ld a, [wCB8A]
    cp a, $50
    jr z, Jump_073_54E6
    xor a, a
    ld [wC929], a
    ld a, $01
    ld [wC92A], a
    ld a, $50
    ld [wC928], a
    farcall Func_05F_6B54
    ret

Jump_073_54E6::
    xor a, a
    ld [wC929], a
    ld a, $02
    ld [wC92A], a
    ld a, $30
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $03
    ld [wCB86], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommandC5_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX, hPlayerY, wC6FD
; writes: wCB86, wScriptStep
; points at: wC8F0, wScriptStep
ScriptCommandC5_Run_Case00::
Jump_073_5509:: ; address name
    ldh a, [hPlayerX]
    cp a, $40
    jr nz, Jump_073_5515
    ldh a, [hPlayerY]
    cp a, $40
    jr z, Jump_073_5541

Jump_073_5515::
    ld a, [wC6FD]
    or a, a
    jr z, Jump_073_5535
    ld b, a
    ld hl, wC8F0

Jump_073_551F::
    push hl
    ld a, [hl+]
    cp a, $40
    jr nz, Jump_073_552A
    ld a, [hl]
    cp a, $40
    jr z, Jump_073_5540

Jump_073_552A::
    pop hl
    ld a, $05
    add_a_to_hl
    dec b
    jr nz, Jump_073_551F

Jump_073_5535::
    ld a, $02
    ld [wCB86], a
    ld a, $02
    ld [wScriptStep], a
    ret

Jump_073_5540::
    pop hl

Jump_073_5541::
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type CC; reached through ScriptCommandCC in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommandCC)
; reads: wScriptStep
ScriptCommandCC_Run::
Func_073_5546:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommandCC_Run_Case00
    dw ScriptCommandCC_Run_Case01

; entry 1 of the `rst $00` table in ScriptCommandCC_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wCBCF, wScriptStartRequest
ScriptCommandCC_Run_Case01::
Jump_073_554E:: ; address name
    ld b, $3C
    call StepWC921Counter_Bank73
    ret nc
    xor a, a
    ld [wCBCF], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 0 of the `rst $00` table in ScriptCommandCC_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hFFC6, wCBD3, wCBD4
; points at: wScriptStep
ScriptCommandCC_Run_Case00::
Jump_073_555E:: ; address name
    ld a, $05
    ldh [hFFC6], a
    farcall Func_012_6B98
    ld a, $40
    ld [wCBD3], a
    ld a, $20
    ld [wCBD4], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type C6; reached through ScriptCommandC6 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommandC6)
; reads: wScriptStep
; writes: hMapId, hMapScreenX, hMapScreenY, wC8C8, wC8C9, wC8C6, wScriptStartRequest
ScriptCommandC6_Run::
Func_073_5577:: ; address name
    ld a, [wScriptStep]
    or a, a
    jr nz, Jump_073_559E
    ld a, $A9
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a, a
    ldh [hMapScreenY], a
    ld a, $60
    ld [wC8C8], a
    ld a, $10
    ld [wC8C9], a
    ld a, $02
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ret

Jump_073_559E::
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type C3; reached through ScriptCommandC3 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommandC3)
; reads: hFFC6
; writes: hFFC6, hFFC7, wScriptStartRequest
ScriptCommandC3_Run::
Func_073_55A4:: ; address name
    xor a, a
    ldh [hFFC6], a
    ld a, $30
    ldh [hFFC7], a
    farcall Func_05F_6BF8
    ldh a, [hFFC6]
    or a, a
    ret z
    ld a, $07
    ldh [hFFC6], a
    farcall Func_05F_6DAC
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type C1; reached through ScriptCommandC1 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommandC1)
; reads: wScriptStep
ScriptCommandC1_Run::
Func_073_55C5:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommandC1_Run_Case00
    dw ScriptCommandCB_Run_Case01
    dw ScriptCommandC1_Run_Case02
    dw ScriptCommandC1_Run_Case03

; entry 3 of the `rst $00` table in ScriptCommandC1_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC924, wC925, wCB8B, wCB9B, wC92C
; writes: wC924, wC925, wCB8B, wCB9B, wC929, wC92A, wC928, wScriptStartRequest
ScriptCommandC1_Run_Case03::
Jump_073_55D1:: ; address name
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    ld a, l
    sub a, $08
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld a, l
    ld [wC924], a
    ld a, h
    ld [wC925], a
    ld a, [wCB8B]
    sub a, h
    ld [wCB8B], a
    ld a, [wCB9B]
    sub a, h
    ld [wCB9B], a
    ld a, $00
    ld [wC929], a
    ld a, $01
    ld [wC92A], a
    ld a, $C0
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, $01
    ld [wC929], a
    ld a, $01
    ld [wC92A], a
    ld a, $C0
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in ScriptCommandC1_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCB9A
; writes: wCB96, wCB9A, wC924, wC925
; points at: wCB9C, wScriptStep
ScriptCommandC1_Run_Case02::
Jump_073_562C:: ; address name
    ld hl, wCB9C
    call SetBit2AtHL_B73
    ld a, $01
    ld [wCB96], a
    ld a, [wCB9A]
    cp a, $60
    jr z, Jump_073_5643
    inc a
    ld [wCB9A], a
    ret

Jump_073_5643::
    ld hl, wCB9C
    call ClearBit2AtHL_Bank73
    ld hl, $0300
    ld a, l
    ld [wC924], a
    ld a, h
    ld [wC925], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommandC1_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCBAB, hFFC6, wSpriteSlotCount
; writes: hFFC6, hFFC7, wCBBB, wSpriteSlotCount, wCB96
; points at: wScriptStep
ScriptCommandC1_Run_Case00::
Jump_073_5659:: ; address name
    ld a, $02
    ldh [hFFC6], a
    ld a, $40
    ldh [hFFC7], a
    farcall Func_05F_6BF8
    ld a, [wCBAB]
    cp a, $40
    jr z, Jump_073_5670
    ld a, $30

Jump_073_5670::
    ld [wCBBB], a
    ldh a, [hFFC6]
    or a, a
    ret z
    ld a, [wSpriteSlotCount]
    dec a
    dec a
    ld [wSpriteSlotCount], a
    xor a, a
    ld [wCB96], a
    ld hl, $0725
    call StoreHLInWC924_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type C0; reached through ScriptCommandC0 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommandC0)
; reads: wScriptStep
ScriptCommandC0_Run::
Func_073_568E:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommandC0_Run_Case00
    dw ScriptCommandC0_Run_Case01
    dw ScriptCommandC0_Run_Case02
    dw ScriptCommandC0_Run_Case03

; entry 3 of the `rst $00` table in ScriptCommandC0_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCBAB, wCB9B
; writes: wCBAB, wCB9B, wScriptStartRequest
; points at: wCB9C, wCBAC
ScriptCommandC0_Run_Case03::
Jump_073_569A:: ; address name
    ld a, [wCBAB]
    dec a
    ld [wCBAB], a
    ld a, [wCB9B]
    dec a
    ld [wCB9B], a
    cp a, $50
    ret nz
    ld hl, wCB9C
    call ClearBit2AtHL_Bank73
    ld hl, wCBAC
    call ClearBit2AtHL_Bank73
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in ScriptCommandC0_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCBAA, wCB9A
; writes: wCBAA, wCB9A, wCB96, wCBA6
; points at: wScriptStep
ScriptCommandC0_Run_Case02::
Jump_073_56BD:: ; address name
    ld a, [wCBAA]
    inc a
    ld [wCBAA], a
    ld a, [wCB9A]
    inc a
    ld [wCB9A], a
    cp a, $60
    ret nz
    ld a, $02
    ld [wCB96], a
    ld [wCBA6], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommandC0_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCB9A, wCBAB
; writes: wCB9A, wCBAB, wCBA6
; points at: wScriptStep
ScriptCommandC0_Run_Case01::
Jump_073_56DB:: ; address name
    ld a, [wCB9A]
    inc a
    ld [wCB9A], a
    ld a, [wCBAB]
    dec a
    ld [wCBAB], a
    cp a, $60
    ret nz
    ld a, $01
    ld [wCBA6], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommandC0_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCBAB, wCB9B
; writes: wCBAB, wCB9B, wCB96
; points at: wCB9C, wCBAC, wScriptStep
ScriptCommandC0_Run_Case00::
Jump_073_56F6:: ; address name
    ld hl, wCB9C
    call SetBit2AtHL_B73
    ld hl, wCBAC
    call SetBit2AtHL_B73
    ld a, [wCBAB]
    dec a
    ld [wCBAB], a
    ld a, [wCB9B]
    dec a
    ld [wCB9B], a
    cp a, $60
    ret nz
    ld a, $01
    ld [wCB96], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 64; reached through ScriptCommand64 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand64)
; reads: wScriptStep
ScriptCommand64_Run::
Func_073_571D:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand64_Run_Case00
    dw ScriptCommand64_Run_Case00
    dw ScriptCommand64_Run_Case00
    dw ScriptCommand64_Run_Case03

; entry 3 of the `rst $00` table in ScriptCommand64_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStartRequest
ScriptCommand64_Run_Case03::
Jump_073_5729:: ; address name
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 63; reached through ScriptCommand63 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand63)
; reads: wScriptStep
; writes: hMapId, hMapScreenX, hMapScreenY, wC8C8, wC8C9, wC8C6, wScriptStartRequest
ScriptCommand63_Run::
Func_073_572F:: ; address name
    ld a, [wScriptStep]
    or a, a
    jr nz, Jump_073_575B
    ld a, $28
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ld a, $01
    ldh [hMapScreenY], a
    ld a, $40
    ld [wC8C8], a
    ld a, $80
    ld [wC8C9], a
    ld a, $03
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ld a, $04
    call StartPaletteFade
    ret

Jump_073_575B::
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 61; reached through ScriptCommand61 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand61)
; reads: wScriptStep
ScriptCommand61_Run::
Func_073_5761:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand61_Run_Case00
    dw ScriptCommand61_Run_Case00
    dw ScriptCommand61_Run_Case00
    dw ScriptCommand61_Run_Case03
    dw ScriptCommand61_Run_Case04
    dw ScriptCommand61_Run_Case05
    dw ScriptCommand61_Run_Case06

; entry 6 of the `rst $00` table in ScriptCommand61_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC6FD
; writes: wC94D, wC195, wScriptStartRequest
; points at: wC240, wC254, wC266, wC27A, wC290, wC2A4
ScriptCommand61_Run_Case06::
Jump_073_5773:: ; address name
    ld hl, wC240
    ld [hl], $2B
    inc hl
    ld [hl], $2C
    ld hl, wC254
    ld [hl], $2D
    inc hl
    ld [hl], $2E
    ld a, [wC6FD]
    dec a
    jr z, Jump_073_57B0
    ld hl, wC266
    ld [hl], $2B
    inc hl
    ld [hl], $2C
    ld hl, wC27A
    ld [hl], $2D
    inc hl
    ld [hl], $2E
    ld a, [wC6FD]
    dec a
    dec a
    jr z, Jump_073_57B0
    ld hl, wC290
    ld [hl], $2B
    inc hl
    ld [hl], $2C
    ld hl, wC2A4
    ld [hl], $2D
    inc hl
    ld [hl], $2E

Jump_073_57B0::
    farcall Func_05F_6DDB
    ld a, $01
    ld [wC94D], a
    xor a, a
    ld [wC195], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 5 of the `rst $00` table in ScriptCommand61_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC8FB, wC8FA
; writes: wC8F9, wC8FA
; points at: wC8FB, wScriptStep
ScriptCommand61_Run_Case05::
Jump_073_57C5:: ; address name
    ld a, [wC8FB]
    cp a, $60
    jr z, Jump_073_57D1
    ld hl, wC8FB
    inc [hl]
    ret

Jump_073_57D1::
    ld a, $01
    ld [wC8F9], a
    ld a, [wC8FA]
    inc a
    ld [wC8FA], a
    cp a, $40
    ret nz
    ld a, $02
    ld [wC8F9], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in ScriptCommand61_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC8F5, wC8F6, wC6FD
; writes: wC8F5, wC8FA, wC8F4, wC8F9, wC8F6, wC8FB, wScriptStep
; points at: wScriptStep
ScriptCommand61_Run_Case04::
Jump_073_57EA:: ; address name
    ld a, [wC8F5]
    cp a, $30
    jr z, Jump_073_57FC
    ld a, [wC8F5]
    dec a
    ld [wC8F5], a
    ld [wC8FA], a
    ret

Jump_073_57FC::
    xor a, a
    ld [wC8F4], a
    ld [wC8F9], a
    ld a, [wC8F6]
    inc a
    ld [wC8F6], a
    ld [wC8FB], a
    cp a, $50
    ret nz
    ld a, $01
    ld [wC8F4], a
    ld hl, wScriptStep
    inc [hl]
    ld a, [wC6FD]
    dec a
    dec a
    ret nz
    ld a, $06
    ld [wScriptStep], a
    ret

; entry 3 of the `rst $00` table in ScriptCommand61_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC8F1, wC8F0, wC6FD
; writes: wC8EF, wC8F4, wC8F9, wC8F1, wC8F6, wC8FB, wC8F0, wC8F5, ...
; points at: wScriptStep
ScriptCommand61_Run_Case03::
Jump_073_5825:: ; address name
    ld a, [wC8F1]
    cp a, $40
    jr z, Jump_073_5845
    ld a, $02
    ld [wC8EF], a
    ld [wC8F4], a
    ld [wC8F9], a
    ld a, [wC8F1]
    dec a
    ld [wC8F1], a
    ld [wC8F6], a
    ld [wC8FB], a
    ret

Jump_073_5845::
    ld a, $03
    ld [wC8EF], a
    ld [wC8F4], a
    ld [wC8F9], a
    ld a, [wC8F0]
    dec a
    ld [wC8F0], a
    ld [wC8F5], a
    ld [wC8FA], a
    cp a, $40
    ret nz
    xor a, a
    ld [wC8EF], a
    ld hl, wScriptStep
    inc [hl]
    ld a, [wC6FD]
    dec a
    ret nz
    ld a, $06
    ld [wScriptStep], a
    ret

; entry 0 of the `rst $00` table in ScriptCommand61_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand61_Run_Case00::
Jump_073_5873:: ; address name
    farcall Func_012_61EF
    ret

; implements script command type 60; reached through ScriptCommand60 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand60)
; reads: wScriptStep
ScriptCommand60_Run::
Func_073_587A:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand60_Run_Case00
    dw ScriptCommand60_Run_Case01
    dw ScriptCommand60_Run_Case02
    dw ScriptCommand60_Run_Case03
    dw ScriptCommand60_Run_Case04

; entry 4 of the `rst $00` table in ScriptCommand60_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wCBCF, hFFC6, wScriptStartRequest
; points at: wCBD3, wCBD4
ScriptCommand60_Run_Case04::
Jump_073_5888:: ; address name
    ld hl, wCBD3
    inc [hl]
    ld hl, wCBD4
    inc [hl]
    ld de, wCBD4
    call Func_073_7A5D
    ret nc
    xor a, a
    ld [wCBCF], a
    ld a, $2C
    ldh [hFFC6], a
    farcall FindHFFC6InWC61DList
    farcall Func_012_7DF1
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 3 of the `rst $00` table in ScriptCommand60_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand60_Run_Case03::
Jump_073_58B1:: ; address name
    ld b, $5A
    call StepWC921Counter_Bank73
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in ScriptCommand60_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wC928, wC929, wScriptParam0
; points at: wCB8B, wScriptStep
ScriptCommand60_Run_Case02::
Jump_073_58BC:: ; address name
    ld de, wCB8B
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand60_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hFFC6, wCBD3, wCBD4, wCBCF
; points at: wScriptStep
ScriptCommand60_Run_Case00::
Jump_073_58E0:: ; address name
    ld a, $10
    ldh [hFFC6], a
    farcall Func_012_6B98
    ld a, $50
    ld [wCBD3], a
    ld a, $30
    ld [wCBD4], a
    ld a, $80
    ld [wCBCF], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 5D; reached through ScriptCommand5D in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand5D)
; reads: hFFC6
; writes: hFFC6, hFFC7, wSpriteSlotCount, wScriptStartRequest
ScriptCommand5D_Run::
Func_073_58FE:: ; address name
    xor a, a
    ldh [hFFC6], a
    ld a, $30
    ldh [hFFC7], a
    farcall Func_05F_6BF8
    ldh a, [hFFC6]
    or a, a
    ret z
    xor a, a
    ld [wSpriteSlotCount], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 5C; reached through ScriptCommand5C in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand5C)
; reads: wScriptParam0
; writes: wCB9B, wScriptParam0, hFFC6, wScriptStartRequest
ScriptCommand5C_Run::
Func_073_5919:: ; address name
    ld a, [wScriptParam0]
    cp a, $1E
    jr nc, Jump_073_5926
    bit 1, a
    jr z, Jump_073_5936
    jr Jump_073_593D

Jump_073_5926::
    cp a, $3C
    jr nc, Jump_073_5930
    bit 2, a
    jr z, Jump_073_5936
    jr Jump_073_593D

Jump_073_5930::
    bit 3, a
    jr z, Jump_073_5936
    jr Jump_073_593D

Jump_073_5936::
    ld a, $20
    ld [wCB9B], a
    jr Jump_073_5942

Jump_073_593D::
    ld a, $E0
    ld [wCB9B], a

Jump_073_5942::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $78
    ret nz
    ld a, $20
    ld [wCB9B], a
    ld a, $36
    ldh [hFFC6], a
    farcall FindHFFC6InWC61DList
    farcall Func_012_7DF1
    ld a, $37
    ldh [hFFC6], a
    farcall FindHFFC6InWC61DList
    farcall Func_012_7DF1
    ld a, $38
    ldh [hFFC6], a
    farcall FindHFFC6InWC61DList
    farcall Func_012_7DF1
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 59 (also 5A); reached through ScriptCommand59 in bank $10 (E-0038)
; 2 call sites from 2 routines (e.g. ScriptCommand59, ScriptCommand5A)
; reads: wScriptStep
ScriptCommand59_Run::
Func_073_5987:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand59_Run_Case00
    dw ScriptCommand59_Run_Case01
    dw ScriptCommand59_Run_Case02

; entry 2 of the `rst $00` table in ScriptCommand59_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC836
; writes: hFFC7, wC836, wScriptStartRequest
ScriptCommand59_Run_Case02::
Jump_073_5991:: ; address name
    farcall Func_012_6990
    ld a, $05
    ldh [hFFC7], a
    farcall Func_012_6955
    ld a, [wC836]
    set 7, a
    ld [wC836], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 1 of the `rst $00` table in ScriptCommand59_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY
; writes: hPlayerY, hMapId, hMapScreenX, hMapScreenY, wC8C8, wC8C9, wC8C6
; points at: wC8F1, wC8F6, wC8FB, hFF8C
ScriptCommand59_Run_Case01::
Jump_073_59AF:: ; address name
    ld hl, wC8F1
    dec [hl]
    ld hl, wC8F6
    dec [hl]
    ld hl, wC8FB
    dec [hl]
    ldh a, [hPlayerY]
    dec a
    ldh [hPlayerY], a
    cp a, $C0
    ret nz
    ld hl, hFF8C
    call ClearBit2AtHL_Bank73
    ld a, $19
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wC8C8], a
    ld [wC8C9], a
    ld a, $03
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ret

; entry 0 of the `rst $00` table in ScriptCommand59_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC92C
; writes: wC929, wC92A, wC928
; points at: hFF8C, wScriptStep
ScriptCommand59_Run_Case00::
Jump_073_59E6:: ; address name
    ld a, $00
    ld [wC929], a
    ld a, $02
    ld [wC92A], a
    ld a, $B0
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, $00
    ld [wC928], a
    farcall Func_05F_6AEB
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, hFF8C
    call SetBit2AtHL_B73
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 57; reached through ScriptCommand57 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand57)
; reads: wScriptStep
ScriptCommand57_Run::
Func_073_5A16:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand57_Run_Case00
    dw ScriptCommand57_Run_Case01
    dw ScriptCommandCB_Run_Case01
    dw ScriptCommand57_Run_Case03

; entry 3 of the `rst $00` table in ScriptCommand57_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hFFC6
; writes: hFFC6, hFFC7, wSpriteSlotCount, wScriptStartRequest
ScriptCommand57_Run_Case03::
Jump_073_5A22:: ; address name
    xor a, a
    ldh [hFFC6], a
    ld a, $20
    ldh [hFFC7], a
    farcall Func_05F_6BF8
    ldh a, [hFFC6]
    or a, a
    ret z
    xor a, a
    ld [wSpriteSlotCount], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 1 of the `rst $00` table in ScriptCommand57_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand57_Run_Case01::
Jump_073_5A3D:: ; address name
    ld hl, $0480
    call StoreHLInWC924_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand57_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hFFC6
; points at: wScriptStep
ScriptCommand57_Run_Case00::
Jump_073_5A48:: ; address name
    ld a, $1C
    ldh [hFFC6], a
    farcall Func_00A_47A4
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 68; reached through ScriptCommand68 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand68)
; reads: hPlayerX, wC6FD, wC92C
; writes: wC92A, wC928, wC929, wScriptStartRequest
; points at: wC8F0
ScriptCommand68_Run::
Func_073_5A57:: ; address name
    ldh a, [hPlayerX]
    cp a, $40
    jr z, Jump_073_5A9C
    cp a, $60
    jr z, Jump_073_5A90
    ld a, [wC6FD]
    ld b, a
    ld hl, wC8F0

Jump_073_5A68::
    push hl
    ld a, [hl]
    cp a, $40
    jr nz, Jump_073_5A77
    inc hl
    ld a, [hl]
    cp a, $40
    jr nz, Jump_073_5A85
    pop hl
    jr Jump_073_5A9C

Jump_073_5A77::
    ld a, [hl]
    cp a, $60
    jr nz, Jump_073_5A85
    inc hl
    ld a, [hl]
    cp a, $40
    jr nz, Jump_073_5A85
    pop hl
    jr Jump_073_5A90

Jump_073_5A85::
    pop hl
    ld a, $05
    add_a_to_hl
    dec b
    jr nz, Jump_073_5A68

Jump_073_5A90::
    ld a, $03
    ld [wC92A], a
    ld a, $40
    ld [wC928], a
    jr Jump_073_5AA6

Jump_073_5A9C::
    ld a, $01
    ld [wC92A], a
    ld a, $60
    ld [wC928], a

Jump_073_5AA6::
    xor a, a
    ld [wC929], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 56; reached through ScriptCommand56 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand56)
; reads: hFFC6
; writes: hFFC6, hFFC7, wSpriteSlotCount, wScriptStartRequest
ScriptCommand56_Run::
Func_073_5ABB:: ; address name
    xor a, a
    ldh [hFFC6], a
    ld a, $30
    ldh [hFFC7], a
    farcall Func_05F_6BF8
    ldh a, [hFFC6]
    or a, a
    ret z
    xor a, a
    ld [wSpriteSlotCount], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 55; reached through ScriptCommand55 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand55)
; reads: wCC3B
; writes: wCC3B, wScriptStartRequest
ScriptCommand55_Run::
Func_073_5AD6:: ; address name
    ld a, [wCC3B]
    set 2, a
    ld [wCC3B], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 54; reached through ScriptCommand54 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand54)
; reads: wScriptStep
ScriptCommand54_Run::
Func_073_5AE4:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand54_Run_Case00
    dw ScriptCommand54_Run_Case01
    dw Func_073_5B66
    dw ScriptCommand54_Run_Case03
    dw ScriptCommand54_Run_Case04

; entry 4 of the `rst $00` table in ScriptCommand54_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hFFC6, wCC3B
; writes: hFFC6, hFFC7, wSpriteSlotCount, wCC3B, wScriptStartRequest
; points at: wC19A
ScriptCommand54_Run_Case04::
Jump_073_5AF2:: ; address name
    xor a, a
    ldh [hFFC6], a
    ld a, $20
    ldh [hFFC7], a
    farcall Func_05F_6BF8
    ldh a, [hFFC6]
    or a, a
    ret z
    xor a, a
    ld [wSpriteSlotCount], a
    ld a, [wCC3B]
    set 1, a
    ld [wCC3B], a
    ld a, $66
    call QueueSoundEffect
    ld hl, wC19A
    ld [hl], $56
    inc hl
    ld [hl], $57
    inc hl
    ld [hl], $57
    inc hl
    ld [hl], $58
    inc hl
    ld a, $10
    add_a_to_hl
    ld [hl], $59
    inc hl
    ld [hl], $5A
    inc hl
    ld [hl], $5A
    inc hl
    ld [hl], $5B
    farcall Func_05F_6DDB
    ld de, $00B1
    call SetFlagBit
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 3 of the `rst $00` table in ScriptCommand54_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC92C
; writes: wC929, wC92A, wC928
; points at: wScriptStep
ScriptCommand54_Run_Case03::
Jump_073_5B47:: ; address name
    ld a, $00
    ld [wC929], a
    ld a, $02
    ld [wC92A], a
    ld a, $20
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. ScriptCommand54_Run_Case01)
; reads: wScriptParam1, wScriptParam0, wCB8B, wCB8A
; writes: wScriptParam0
; points at: wCB8B, wScriptStep, wCB8A
Func_073_5B66::
    ld a, [wScriptParam1]
    or a, a
    jr nz, Jump_073_5B72
    ld hl, wCB8B
    inc [hl]
    jr Jump_073_5B88

Jump_073_5B72::
    dec a
    jr nz, Jump_073_5B7B
    ld hl, wCB8A
    inc [hl]
    jr Jump_073_5B88

Jump_073_5B7B::
    dec a
    jr nz, Jump_073_5B84
    ld hl, wCB8B
    dec [hl]
    jr Jump_073_5B88

Jump_073_5B84::
    ld hl, wCB8A
    dec [hl]

Jump_073_5B88::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $10
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld a, [wCB8B]
    cp a, $30
    jr nz, Jump_073_5BA9
    ld a, [wCB8A]
    cp a, $80
    jr nz, Jump_073_5BA9
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_073_5BA9::
    ld hl, wScriptStep
    dec [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand54_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC924, wCB8A, wC925, wCB8B, wMaxBlockingTile
; writes: wScriptStartRequest
; points at: wScreenTileBuffer, wC910, wCB8C, wScriptStep
ScriptCommand54_Run_Case01::
Jump_073_5BAE:: ; address name
    ld a, [wC924]
    ld d, a
    ld a, [wCB8A]
    add a, d
    ld b, a
    ld a, [wC925]
    ld d, a
    ld a, [wCB8B]
    add a, d
    ld c, a
    ld a, c
    srl a
    srl a
    srl a
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add_a_to_hl
    add hl, hl
    add hl, hl
    ld a, b
    srl a
    srl a
    srl a
    add_a_to_hl
    ld de, wScreenTileBuffer
    add hl, de
    ld de, wC910
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    ld a, $13
    inc de
    add_a_to_hl
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    dec de
    dec de
    dec de
    ld b, $04

Jump_073_5BFD::
    ld a, [de]
    inc de
    ld c, a
    ld a, [wMaxBlockingTile]
    cp a, c
    jr c, Jump_073_5C08
    jr Jump_073_5C13

Jump_073_5C08::
    dec b
    jr nz, Jump_073_5BFD
    call Func_073_5B66
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_073_5C13::
    ld hl, wCB8C
    call ClearBit2AtHL_Bank73
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 0 of the `rst $00` table in ScriptCommand54_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX
; writes: wScriptParam1, wCB86, wC924, wC925
; points at: wCB8C, wScriptStep
ScriptCommand54_Run_Case00::
Jump_073_5C1F:: ; address name
    ldh a, [hPlayerX]
    swap a
    and a, $0F
    sub a, $05
    and a, $03
    sla a
    sla a
    ld hl, $5C4F
    add_a_to_hl
    ld a, [hl+]
    ld [wScriptParam1], a
    ld [wCB86], a
    ld a, [hl+]
    ld [wC924], a
    ld a, [hl]
    ld [wC925], a
    ld hl, wCB8C
    call SetBit2AtHL_B73
    ld hl, wScriptStep
    inc [hl]
    ret
    db $03, $F0, $00, $00, $02, $00, $F0, $00, $00, $00, $10, $00, $01, $10, $00, $00

; implements script command type 53; reached through ScriptCommand53 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand53)
; reads: hPlayerX, hPlayerY, wC1EA, wC1F8, wC28A, wC298, wCC3B
; writes: wCC3B, wScriptStartRequest
; points at: wC1EA, wC28A, wC298, wC1C8, wC1F8
ScriptCommand53_Run::
Func_073_5C5F:: ; address name
    ldh a, [hPlayerX]
    cp a, $30
    jr nz, Jump_073_5C8D
    ldh a, [hPlayerY]
    cp a, $30
    jr nz, Jump_073_5C7F
    ld hl, wC1EA
    call Func_073_5D09
    ld hl, wC28A
    call Func_073_5D09
    ld hl, wC298
    call Func_073_5D09
    jr Jump_073_5CAD

Jump_073_5C7F::
    ld hl, wC28A
    call Func_073_5D09
    ld hl, wC298
    call Func_073_5D09
    jr Jump_073_5CAD

Jump_073_5C8D::
    ldh a, [hPlayerY]
    cp a, $30
    jr nz, Jump_073_5CA1
    ld hl, wC1F8
    call Func_073_5D09
    ld hl, wC28A
    call Func_073_5D09
    jr Jump_073_5CAD

Jump_073_5CA1::
    ld hl, wC1F8
    call Func_073_5D09
    ld hl, wC298
    call Func_073_5D09

Jump_073_5CAD::
    ld a, [wC1EA]
    cp a, $10
    jr nz, Jump_073_5CFD
    ld a, [wC1F8]
    cp a, $10
    jr nz, Jump_073_5CFD
    ld a, [wC28A]
    cp a, $10
    jr nz, Jump_073_5CFD
    ld a, [wC298]
    cp a, $10
    jr nz, Jump_073_5CFD
    ld a, $66
    call QueueSoundEffect
    ld hl, wC1C8
    ld [hl], $46
    inc hl
    ld [hl], $47
    inc hl
    ld [hl], $47
    inc hl
    ld [hl], $48
    inc hl
    ld a, $10
    add_a_to_hl
    ld [hl], $49
    inc hl
    ld [hl], $4A
    inc hl
    ld [hl], $4A
    inc hl
    ld [hl], $4B
    ld a, [wCC3B]
    set 0, a
    ld [wCC3B], a
    ld de, $00B0
    call SetFlagBit

Jump_073_5CFD::
    farcall Func_05F_6DDB
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; 9 call sites from 1 routine (e.g. ScriptCommand53_Run)
; reads: wIsCGB
; writes: rSVBK
Func_073_5D09::
    push hl
    call Func_073_5D48
    call Func_073_5D48
    call Func_073_5D48
    call Func_073_5D48
    pop hl
    ld a, [wIsCGB]
    or a, a
    ret z
    ld c, $04
    ld a, [hl]
    cp a, $18
    ld c, $05
    ld a, l
    sub a, $98
    ld l, a
    ld a, h
    sbc a, $C1
    ld h, a
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $D0
    ld h, a
    ld a, $02
    ldh [rSVBK], a
    call Func_073_5D65
    call Func_073_5D65
    call Func_073_5D65
    call Func_073_5D65
    ld a, $00
    ldh [rSVBK], a
    ret

; 4 call sites from 1 routine (e.g. Func_073_5D09)
Func_073_5D48::
    ld a, [hl]
    add a, $08
    cp a, $28
    jr c, Jump_073_5D51
    sub a, $18

Jump_073_5D51::
    ld [hl+], a
    ld a, [hl]
    add a, $08
    cp a, $28
    jr c, Jump_073_5D5B
    sub a, $18

Jump_073_5D5B::
    ld [hl-], a
    ld a, $14
    add_a_to_hl
    ld a, [hl]
    ret

; 4 call sites from 1 routine (e.g. Func_073_5D09)
Func_073_5D65::
    ld a, c
    ld [hl+], a
    ld [hl-], a
    ld a, $14
    add_a_to_hl
    ld a, [hl]
    ret

; implements script command type 67; reached through ScriptCommand67 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand67)
; reads: hMapId, hMapScreenX, hFFC6
; writes: hFFC6, hFFC7, wSpriteSlotCount, wScriptStartRequest
ScriptCommand67_Run::
Func_073_5D71:: ; address name
    xor a, a
    ldh [hFFC6], a
    ld a, $20
    ldh [hFFC7], a
    ldh a, [hMapId]
    cp a, $8C
    jr z, Jump_073_5D88
    ldh a, [hMapScreenX]
    cp a, $01
    jr nz, Jump_073_5D88
    ld a, $50
    ldh [hFFC7], a

Jump_073_5D88::
    farcall Func_05F_6BF8
    ldh a, [hFFC6]
    or a, a
    ret z
    xor a, a
    ld [wSpriteSlotCount], a
    ld a, $80
    ld [wScriptStartRequest], a
    ld de, $00C5
    ldh a, [hMapId]
    cp a, $8C
    jr z, Jump_073_5DAB
    inc de
    ldh a, [hMapScreenX]
    or a, a
    jr z, Jump_073_5DAB
    inc de

Jump_073_5DAB::
    call SetFlagBit
    ret

; implements script command type 52; reached through ScriptCommand52 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand52)
; reads: wScriptStep
; writes: hMapId, hMapScreenX, hMapScreenY, wC8C8, wC8C9, wC8C6, wScriptStartRequest
ScriptCommand52_Run::
Func_073_5DAF:: ; address name
    ld a, [wScriptStep]
    or a, a
    jr nz, Jump_073_5DD7
    ld a, $82
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    ld a, $02
    ldh [hMapScreenY], a
    ld a, $40
    ld [wC8C8], a
    ld a, $80
    ld [wC8C9], a
    ld a, $03
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ret

Jump_073_5DD7::
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 51; reached through ScriptCommand51 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand51)
; reads: wScriptStep
ScriptCommand51_Run::
Func_073_5DDD:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand51_Run_Case00
    dw ScriptCommand51_Run_Case01
    dw ScriptCommand51_Run_Case02
    dw ScriptCommand51_Run_Case03
    dw ScriptCommand51_Run_Case04
    dw ScriptCommandC5_Run_Case09

; entry 4 of the `rst $00` table in ScriptCommand51_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand51_Run_Case04::
Jump_073_5DED:: ; address name
    ld hl, $0433
    call StoreHLInWC924_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in ScriptCommand51_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hMapScreenY, wC8C8, wC8C9, wC8C6
ScriptCommand51_Run_Case03::
Jump_073_5DF8:: ; address name
    xor a, a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wC8C8], a
    ld a, $30
    ld [wC8C9], a
    ld a, $03
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ret

; entry 2 of the `rst $00` table in ScriptCommand51_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wCB8A, wCB8B
; writes: hPlayerY, wC8F1, wC8F6, wC8FB, hPlayerX, wC8F0, wC8F5, wC8FA, ...
; points at: wCB8A, wScriptParam0, wScriptStep
ScriptCommand51_Run_Case02::
Jump_073_5E11:: ; address name
    ld hl, wCB8A
    inc [hl]
    ld a, [wScriptParam0]
    and a, $01
    jr nz, Jump_073_5E20
    ld hl, wCB8A
    inc [hl]

Jump_073_5E20::
    ld hl, wScriptParam0
    inc [hl]
    call Func_073_5E73
    add a, $10
    ldh [hPlayerY], a
    ld [wC8F1], a
    ld [wC8F6], a
    ld [wC8FB], a
    ld a, [wCB8A]
    ldh [hPlayerX], a
    ld [wC8F0], a
    ld [wC8F5], a
    ld [wC8FA], a
    ld a, [wCB8B]
    cp a, $C0
    ret c
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand51_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wScriptParam0
; points at: wCB8A, wScriptParam0, wScriptStep
ScriptCommand51_Run_Case01::
Jump_073_5E51:: ; address name
    ld hl, wCB8A
    inc [hl]
    ld a, [wScriptParam0]
    and a, $01
    jr nz, Jump_073_5E60
    ld hl, wCB8A
    inc [hl]

Jump_073_5E60::
    ld hl, wScriptParam0
    inc [hl]
    call Func_073_5E73
    cp a, $70
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; 2 call sites from 2 routines (e.g. ScriptCommand51_Run_Case02, ScriptCommand51_Run_Case01)
; reads: wC924, wC925, wCB8B
; writes: wC924, wC925, wCB8B
Func_073_5E73::
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    ld a, l
    sub a, $18
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld a, l
    ld [wC924], a
    ld a, h
    ld [wC925], a
    ld a, [wC925]
    ld h, a
    ld a, [wCB8B]
    add a, h
    ld [wCB8B], a
    ret

; entry 0 of the `rst $00` table in ScriptCommand51_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wC924, wC925
; points at: wCB8C, wScriptStep
ScriptCommand51_Run_Case00::
Jump_073_5E97:: ; address name
    ld b, $3C
    call StepWC921Counter_Bank73
    ret nc
    ld hl, wCB8C
    call SetBit2AtHL_B73
    ld hl, $05C0
    ld a, l
    ld [wC924], a
    ld a, h
    ld [wC925], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 50; reached through ScriptCommand50 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand50)
; reads: wScriptStep
ScriptCommand50_Run::
Func_073_5EB3:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand50_Run_Case00
    dw ScriptCommand50_Run_Case01
    dw ScriptCommand50_Run_Case02

; entry 2 of the `rst $00` table in ScriptCommand50_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCB8A
; writes: wCB9B, wCB9A, wScriptStartRequest
; points at: wCB8A, wScriptParam0
ScriptCommand50_Run_Case02::
Jump_073_5EBD:: ; address name
    ld hl, wCB8A
    dec [hl]
    ld hl, wScriptParam0
    inc [hl]
    call Func_073_5EF9
    add a, $10
    ld [wCB9B], a
    ld a, [wCB8A]
    ld [wCB9A], a
    ld a, [wCB8A]
    cp a, $E0
    ret nz
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 1 of the `rst $00` table in ScriptCommand50_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCB8A
; writes: wScriptParam0
; points at: wCB8A, wScriptParam0, wScriptStep
ScriptCommand50_Run_Case01::
Jump_073_5EDF:: ; address name
    ld hl, wCB8A
    dec [hl]
    ld hl, wScriptParam0
    inc [hl]
    call Func_073_5EF9
    ld a, [wCB8A]
    cp a, $40
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; 2 call sites from 2 routines (e.g. ScriptCommand50_Run_Case02, ScriptCommand50_Run_Case01)
; reads: wC924, wC925, wCB8B
; writes: wC924, wC925, wCB8B
Func_073_5EF9::
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    ld a, l
    sub a, $10
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld a, l
    ld [wC924], a
    ld a, h
    ld [wC925], a
    ld a, [wC925]
    ld h, a
    ld a, [wCB8B]
    add a, h
    ld [wCB8B], a
    ret

; entry 0 of the `rst $00` table in ScriptCommand50_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wC924, wC925
; points at: wCB8C, wScriptStep
ScriptCommand50_Run_Case00::
Jump_073_5F1D:: ; address name
    ld b, $3C
    call StepWC921Counter_Bank73
    ret nc
    ld hl, wCB8C
    call SetBit2AtHL_B73
    ld hl, $03C0
    ld a, l
    ld [wC924], a
    ld a, h
    ld [wC925], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 4F; reached through ScriptCommand4F in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand4F)
; writes: wScriptStartRequest
; points at: wC26A, wC27E
ScriptCommand4F_Run::
Func_073_5F39:: ; address name
    ld hl, wC26A
    ld [hl], $68
    inc hl
    ld [hl], $69
    ld hl, wC27E
    ld [hl], $6A
    inc hl
    ld [hl], $6B
    farcall Func_05F_6DDB
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5, wC6FD, wCBB6, wCBBA, wCBBB
; writes: hFFC7, hFFC8, hFFC9, wC527, wScriptStartRequest
; points at: wC6FD, wC8EF, wC6FE, wSpriteSlotCount
Func_073_5F55:: ; heuristic: follows a terminator; C0
    ld a, $00
    ldh [hFFC7], a
    ld a, [wD7F5]
    ldh [hFFC8], a
    ld a, $02
    ldh [hFFC9], a
    farcall Func_001_6E46
    ld hl, wC6FD
    inc [hl]
    ld a, [wC6FD]
    dec a
    ld c, a
    add a, a
    add a, a
    add a, c
    ld hl, wC8EF
    add_a_to_hl
    ld a, [wCBB6]
    ld [hl+], a
    ld a, [wCBBA]
    ld [hl+], a
    ld a, [wCBBB]
    ld [hl], a
    ld a, [wC6FD]
    dec a
    ld hl, wC6FE
    add_a_to_hl
    ld a, [wD7F5]
    ld [hl], a
    farcall Func_002_5E85
    farcall Func_002_5E85
    call Func_000_222B
    farcall Func_004_4AA8
    ld a, $7F
    ld [wC527], a
    ld hl, wSpriteSlotCount
    dec [hl]
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 4C; reached through ScriptCommand4C in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand4C)
; reads: wScriptStep
ScriptCommand4C_Run::
Func_073_5FBC:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand4C_Run_Case00
    dw ScriptCommand4C_Run_Case01

; entry 1 of the `rst $00` table in ScriptCommand4C_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wCBCF, wScriptStartRequest
; points at: wCBD4
ScriptCommand4C_Run_Case01::
Jump_073_5FC4:: ; address name
    ld a, $80
    ld [wCBCF], a
    ld a, [wScriptParam0]
    and a, $03
    jr nz, Jump_073_5FD4
    ld hl, wCBD4
    dec [hl]

Jump_073_5FD4::
    ld b, $5A
    call StepWC921Counter_Bank73
    ret nc
    xor a, a
    ld [wCBCF], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 0 of the `rst $00` table in ScriptCommand4C_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hMapId
; writes: hFFC6, wCBD3, wCBD4
; points at: wScriptStep
ScriptCommand4C_Run_Case00::
Jump_073_5FE4:: ; address name
    ld a, $11
    ldh [hFFC6], a
    farcall Func_012_6B98
    ld hl, $6020
    ld de, $00D1
    call TestFlagBit
    jr nc, Jump_073_5FFC
    ld hl, $602C

Jump_073_5FFC::
    ldh a, [hMapId]
    ld c, a

Jump_073_5FFF::
    push hl
    ld a, [hl]
    cp a, c
    jr nz, Jump_073_601B
    inc hl
    ld a, [hl]
    and a, $F0
    ld [wCBD3], a
    ld a, [hl]
    and a, $0F
    swap a
    add a, $F8
    ld [wCBD4], a
    pop hl
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_073_601B::
    pop hl
    inc hl
    inc hl
    jr Jump_073_5FFF
    db $06, $31, $12, $44, $00, $63, $02, $24, $16, $53, $1A, $43, $06, $31, $12, $44
    db $00, $53, $02, $24, $16, $42, $1A, $43

; implements script command type 47; reached through ScriptCommand47 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand47)
; reads: wScriptStep
ScriptCommand47_Run::
Func_073_6038:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand47_Run_Case00
    dw ScriptCommand47_Run_Case01

; entry 1 of the `rst $00` table in ScriptCommand47_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; points at: wCB8B
ScriptCommand47_Run_Case01::
Jump_073_6040:: ; address name
    ld a, [wScriptParam0]
    and a, $01
    jr z, Jump_073_604B
    ld hl, wCB8B
    inc [hl]

Jump_073_604B::
    call Func_073_4E9C
    ret

; entry 0 of the `rst $00` table in ScriptCommand47_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wCB86
; points at: wCB8C, wScriptStep
ScriptCommand47_Run_Case00::
Jump_073_604F:: ; address name
    ld hl, wCB8C
    call SetBit1AtHL_Bank73
    ld b, $1E
    call StepWC921Counter_Bank73
    ret nc
    xor a, a
    ld [wCB86], a
    ld hl, wScriptStep
    inc [hl]
    ld de, $0098
    call TestFlagBit
    jr c, Jump_073_6072
    ld de, $0098
    call SetFlagBit
    ret

Jump_073_6072::
    ld de, $0099
    call SetFlagBit
    ret

; implements script command type 44; reached through ScriptCommand44 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand44)
; reads: wScriptStep
ScriptCommand44_Run::
Func_073_6079:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand44_Run_Case00
    dw ScriptCommand44_Run_Case01
    dw ScriptCommand44_Run_Case02

; entry 2 of the `rst $00` table in ScriptCommand44_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wCBAB, wCB9B, wCBCF, wSpriteSlotCount, wScriptStartRequest
ScriptCommand44_Run_Case02::
Jump_073_6083:: ; address name
    ld b, $78
    call StepWC921Counter_Bank73
    ret nc
    ld a, $40
    ld [wCBAB], a
    ld a, $50
    ld [wCB9B], a
    xor a, a
    ld [wCBCF], a
    ld a, $03
    ld [wSpriteSlotCount], a
    ld a, $00
    call QueueSoundEffect
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 1 of the `rst $00` table in ScriptCommand44_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCBAB, wCB9B
; writes: wCBAB, wCB9B, wSpriteSlotCount, wCBCF
; points at: wScriptStep
ScriptCommand44_Run_Case01::
Jump_073_60A7:: ; address name
    ld a, [wCBAB]
    inc a
    inc a
    ld [wCBAB], a
    ld a, [wCB9B]
    dec a
    dec a
    ld [wCB9B], a
    cp a, $48
    ret nz
    xor a, a
    ld [wSpriteSlotCount], a
    ld a, $80
    ld [wCBCF], a
    ld a, $7D
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand44_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wCB9B
; writes: wScriptParam0, wCB9B, hFFC6, wCBD3, wCBD4
; points at: wCBAB, wScriptStep
ScriptCommand44_Run_Case00::
Jump_073_60CD:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and a, $03
    ret nz
    ld hl, wCBAB
    dec [hl]
    ld a, [wCB9B]
    inc a
    ld [wCB9B], a
    cp a, $58
    ret nz
    ld a, $0C
    ldh [hFFC6], a
    farcall Func_012_6B98
    ld a, $40
    ld [wCBD3], a
    ld a, $48
    ld [wCBD4], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 3F; reached through ScriptCommand3F in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand3F)
; reads: wFrameCounterLo, wCB9B
; writes: wSpriteSlotCount, wCB9B, wScriptStartRequest
ScriptCommand3F_Run::
Func_073_60FE:: ; address name
    ld a, [wFrameCounterLo]
    bit 2, a
    jr z, Jump_073_610C
    ld a, $01
    ld [wSpriteSlotCount], a
    jr Jump_073_6111

Jump_073_610C::
    ld a, $02
    ld [wSpriteSlotCount], a

Jump_073_6111::
    ld a, [wCB9B]
    inc a
    ld [wCB9B], a
    cp a, $70
    ret nz
    ld a, $02
    ld [wSpriteSlotCount], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 3E; reached through ScriptCommand3E in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand3E)
; reads: wScriptStep
ScriptCommand3E_Run::
Func_073_6126:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand3E_Run_Case00
    dw ScriptCommand3E_Run_Case01
    dw ScriptCommand3E_Run_Case02
    dw ScriptCommand3E_Run_Case03

; entry 3 of the `rst $00` table in ScriptCommand3E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC925, wC924
; writes: hFF8D, wC195, wScriptStartRequest
ScriptCommand3E_Run_Case03::
Jump_073_6132:: ; address name
    ld a, [wC925]
    swap a
    and a, $0F
    sla a
    ld l, a
    ld e, a
    ld h, $00
    ld d, $00
    add hl, hl
    add hl, hl
    add hl, de
    add hl, hl
    add hl, hl
    ld a, [wC924]
    swap a
    and a, $0F
    add a, a
    add_a_to_hl
    ld a, l
    add a, $98
    ld l, a
    ld a, h
    adc a, $C1
    ld h, a
    push hl
    ld [hl], $44
    inc hl
    ld [hl], $45
    ld a, $13
    add_a_to_hl
    ld [hl], $46
    inc hl
    ld [hl], $47
    pop hl
    farcall Func_05F_6DDB
    xor a, a
    ldh [hFF8D], a
    xor a, a
    ld [wC195], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in ScriptCommand3E_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand3E_Run_Case02::
Jump_073_6181:: ; address name
    farcall Func_012_5B9A
    ret

; entry 1 of the `rst $00` table in ScriptCommand3E_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand3E_Run_Case01::
Jump_073_6188:: ; address name
    farcall Func_012_5C27
    ret

; entry 0 of the `rst $00` table in ScriptCommand3E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wC195
ScriptCommand3E_Run_Case00::
Jump_073_618F:: ; address name
    ld a, $10
    ld [wC195], a
    farcall Func_012_5C31
    ret

; entry 0 of the `rst $00` table in ScriptCommand64_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wC195
ScriptCommand64_Run_Case00::
Jump_073_619B:: ; address name
    ld a, $10
    ld [wC195], a
    farcall Func_012_61EF
    ret

; implements script command type 3D; reached through ScriptCommand3D in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand3D)
; reads: wScriptStep
ScriptCommand3D_Run::
Func_073_61A7:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand3D_Run_Case00
    dw ScriptCommand3D_Run_Case01
    dw ScriptCommand3D_Run_Case02
    dw ScriptCommand3D_Run_Case03
    dw ScriptCommand3D_Run_Case04
    dw ScriptCommand3D_Run_Case05
    dw ScriptCommandCB_Run_Case01
    dw ScriptCommand3D_Run_Case07
    dw ScriptCommandCB_Run_Case01
    dw ScriptCommand3D_Run_Case09

; entry 9 of the `rst $00` table in ScriptCommand3D_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerFacing, wC634, wC836
; writes: wScriptStartRequest, wCB96, wC928, hFFC7, wC836
ScriptCommand3D_Run_Case09::
Jump_073_61BF:: ; address name
    ld a, $80
    ld [wScriptStartRequest], a
    ldh a, [hPlayerFacing]
    inc a
    inc a
    and a, $03
    ld [wCB96], a
    ld de, $0191
    call TestFlagBit
    jr c, Jump_073_61EC
    ld a, [wC634]
    cp a, $FF
    jr z, Jump_073_61E0
    or a, a
    jr z, Jump_073_61E0
    ret

Jump_073_61E0::
    ld a, $2C
    ld [wC928], a
    farcall Func_05F_6C8C
    ret

Jump_073_61EC::
    farcall Func_012_6990
    ld a, $04
    ldh [hFFC7], a
    farcall Func_012_6955
    ld a, [wC836]
    set 7, a
    ld [wC836], a
    ld de, $0135
    call SetFlagBit
    ret

; entry 7 of the `rst $00` table in ScriptCommand3D_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wCB96, wCBB6
; points at: wScriptStep
ScriptCommand3D_Run_Case07::
Jump_073_620B:: ; address name
    ld de, $0191
    call TestFlagBit
    jr c, Jump_073_6218
    ld hl, $0D3F
    jr Jump_073_621B

Jump_073_6218::
    ld hl, $0D4B

Jump_073_621B::
    call StoreHLInWC924_B73b
    ld a, $00
    ld [wCB96], a
    ld a, $02
    ld [wCBB6], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in ScriptCommand3D_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wCBB6, wScriptParam0
; points at: wScriptStep
ScriptCommand3D_Run_Case05::
Jump_073_622D:: ; address name
    ld a, [wScriptParam0]
    swap a
    and a, $01
    add a, a
    inc a
    ld [wCBB6], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $78
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ld hl, $0D3E
    call StoreHLInWC924_B73b
    ret

; entry 4 of the `rst $00` table in ScriptCommand3D_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand3D_Run_Case04::
Jump_073_6252:: ; address name
    ld b, $3C
    call StepWC921Counter_Bank73
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in ScriptCommand3D_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC924, wC925, wC937, wC938, wC939
; writes: hFFC6, hFFC7, hFF8D, wScriptParam0
; points at: wScriptStep
ScriptCommand3D_Run_Case03::
Jump_073_625D:: ; address name
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    ld a, [wC937]
    ld [hl+], a
    ld a, [wC938]
    ld [hl+], a
    ld a, [wC939]
    ld [hl], a
    ld hl, $00B9
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    farcall Func_05F_6D3F
    xor a, a
    ldh [hFF8D], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in ScriptCommand3D_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC924, wC925
; writes: wCBBB
; points at: wScriptStep
ScriptCommand3D_Run_Case02::
Jump_073_628C:: ; address name
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    inc hl
    inc hl
    ld a, [hl]
    cp a, $50
    jr z, Jump_073_62A2
    inc a
    ld [hl], a
    dec hl
    dec hl
    ld [hl], $00
    ret

Jump_073_62A2::
    dec hl
    dec hl
    ld [hl], $01
    ld a, $50
    ld [wCBBB], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand3D_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC924, wC925
; points at: wScriptStep
ScriptCommand3D_Run_Case01::
Jump_073_62B0:: ; address name
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    inc hl
    inc hl
    ld a, [hl]
    cp a, $40
    jr z, Jump_073_62C6
    inc a
    ld [hl], a
    dec hl
    dec hl
    ld [hl], $00
    ret

Jump_073_62C6::
    dec hl
    ld a, [hl]
    cp a, $20
    jr z, Jump_073_62D2
    dec a
    ld [hl], a
    dec hl
    ld [hl], $03
    ret

Jump_073_62D2::
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand3D_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hFFC6
; writes: hFFC6, hFFC7, wC924, wC925, wC937, wC938, wC939
; points at: wC8EF, wScriptStep
ScriptCommand3D_Run_Case00::
Jump_073_62D7:: ; address name
    ld hl, $00B9
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    farcall Func_012_7D95
    ldh a, [hFFC6]
    ld c, a
    sla a
    sla a
    add a, c
    ld hl, wC8EF
    add_a_to_hl
    ld a, l
    ld [wC924], a
    ld a, h
    ld [wC925], a
    ld a, [hl+]
    ld [wC937], a
    ld a, [hl+]
    ld [wC938], a
    ld a, [hl]
    ld [wC939], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 3C; reached through ScriptCommand3C in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand3C)
; reads: wScriptStep
ScriptCommand3C_Run::
Func_073_630F:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand3C_Run_Case00
    dw ScriptCommand3C_Run_Case01
    dw ScriptCommand3C_Run_Case02
    dw ScriptCommand3C_Run_Case03
    dw ScriptCommand3C_Run_Case04
    dw ScriptCommand3C_Run_Case05
    dw ScriptCommand3C_Run_Case06
    dw ScriptCommand3C_Run_Case01
    dw ScriptCommand3C_Run_Case08
    dw ScriptCommand3C_Run_Case03
    dw ScriptCommand3C_Run_Case04
    dw ScriptCommand3C_Run_Case0B
    dw ScriptCommand3C_Run_Case06
    dw ScriptCommand3C_Run_Case0D
    dw ScriptCommand3C_Run_Case0E
    dw ScriptCommand3C_Run_Case0F
    dw ScriptCommandCB_Run_Case01
    dw ScriptCommand3C_Run_Case11
    dw ScriptCommandCB_Run_Case01
    dw ScriptCommand3C_Run_Case13

; entry 19 of the `rst $00` table in ScriptCommand3C_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerFacing, wC634, wC836
; writes: wScriptStartRequest, wCB86, wC928, hFFC7, wC836
ScriptCommand3C_Run_Case13::
Jump_073_633B:: ; address name
    ld a, $80
    ld [wScriptStartRequest], a
    ldh a, [hPlayerFacing]
    inc a
    inc a
    and a, $03
    ld [wCB86], a
    ld de, $0134
    call TestFlagBit
    jr c, Jump_073_6368
    ld a, [wC634]
    cp a, $FF
    jr z, Jump_073_635C
    or a, a
    jr z, Jump_073_635C
    ret

Jump_073_635C::
    ld a, $2C
    ld [wC928], a
    farcall Func_05F_6C8C
    ret

Jump_073_6368::
    farcall Func_012_6990
    ld a, $04
    ldh [hFFC7], a
    farcall Func_012_6955
    ld a, [wC836]
    set 7, a
    ld [wC836], a
    ld de, $0135
    call SetFlagBit
    ret

; entry 17 of the `rst $00` table in ScriptCommand3C_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCB9A, wCB9B
; writes: wCB86, wCB96
; points at: wScriptStep
ScriptCommand3C_Run_Case11::
Jump_073_6387:: ; address name
    ld de, $0134
    call TestFlagBit
    jr c, Jump_073_6394
    ld hl, $0D46
    jr Jump_073_6397

Jump_073_6394::
    ld hl, $0D16

Jump_073_6397::
    call StoreHLInWC924_B73b
    ld hl, wScriptStep
    inc [hl]
    ld a, [wCB9A]
    cp a, $50
    jr nz, Jump_073_63B0
    ld a, $03
    ld [wCB86], a
    ld a, $01
    ld [wCB96], a
    ret

Jump_073_63B0::
    cp a, $70
    jr nz, Jump_073_63BF
    ld a, $01
    ld [wCB86], a
    ld a, $03
    ld [wCB96], a
    ret

Jump_073_63BF::
    ld a, [wCB9B]
    cp a, $20
    jr nz, Jump_073_63D0
    ld a, $02
    ld [wCB86], a
    xor a, a
    ld [wCB96], a
    ret

Jump_073_63D0::
    xor a, a
    ld [wCB86], a
    ld a, $02
    ld [wCB96], a
    ret

; entry 15 of the `rst $00` table in ScriptCommand3C_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wCB96, wScriptParam0
; points at: wScriptStep
ScriptCommand3C_Run_Case0F::
Jump_073_63DA:: ; address name
    ld a, [wScriptParam0]
    swap a
    and a, $01
    add a, a
    inc a
    ld [wCB96], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $78
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ld hl, $0D15
    call StoreHLInWC924_B73b
    ret

; entry 14 of the `rst $00` table in ScriptCommand3C_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand3C_Run_Case0E::
Jump_073_63FF:: ; address name
    ld b, $3C
    call StepWC921Counter_Bank73
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 13 of the `rst $00` table in ScriptCommand3C_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC924, wC925, wC937, wC938, wC939
; writes: hFFC6, hFFC7, hFF8D, wCB96, wScriptParam0
; points at: wSpriteSlotCount, wScriptStep
ScriptCommand3C_Run_Case0D::
Jump_073_640A:: ; address name
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    ld a, [wC937]
    ld [hl+], a
    ld a, [wC938]
    ld [hl+], a
    ld a, [wC939]
    ld [hl], a
    ld hl, $005A
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    farcall Func_05F_6D3F
    xor a, a
    ldh [hFF8D], a
    xor a, a
    ld [wCB96], a
    ld hl, wSpriteSlotCount
    inc [hl]
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 11 of the `rst $00` table in ScriptCommand3C_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC924, wC925
; writes: wCB9A
; points at: wScriptStep
ScriptCommand3C_Run_Case0B::
Jump_073_6441:: ; address name
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    inc hl
    ld a, [hl]
    cp a, $50
    jr nz, Jump_073_6459
    ld a, $50
    ld [wCB9A], a
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_073_6459::
    call Func_073_65A4
    ret

; entry 8 of the `rst $00` table in ScriptCommand3C_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC924, wC925
; writes: wCB9B
; points at: wScriptStep
ScriptCommand3C_Run_Case08::
Jump_073_645D:: ; address name
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    inc hl
    inc hl
    ld a, [hl]
    cp a, $20
    jr nz, Jump_073_6476
    ld a, $20
    ld [wCB9B], a
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_073_6476::
    call Func_073_659D
    ret

; entry 6 of the `rst $00` table in ScriptCommand3C_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC924, wC925
; writes: wCB9B, wScriptStep
ScriptCommand3C_Run_Case06::
Jump_073_647A:: ; address name
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    inc hl
    inc hl
    ld a, [hl]
    cp a, $30
    jr nz, Jump_073_6494
    ld a, $30
    ld [wCB9B], a
    ld a, $0D
    ld [wScriptStep], a
    ret

Jump_073_6494::
    jr nc, Jump_073_649A
    call Func_073_6596
    ret

Jump_073_649A::
    call Func_073_659D
    ret

; entry 5 of the `rst $00` table in ScriptCommand3C_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC924, wC925
; writes: wCB9A
; points at: wScriptStep
ScriptCommand3C_Run_Case05::
Jump_073_649E:: ; address name
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    inc hl
    ld a, [hl]
    cp a, $70
    jr nz, Jump_073_64B6
    ld a, $70
    ld [wCB9A], a
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_073_64B6::
    call Func_073_65AA
    ret

; entry 4 of the `rst $00` table in ScriptCommand3C_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC924, wC925
; points at: wScriptStep
ScriptCommand3C_Run_Case04::
Jump_073_64BA:: ; address name
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    inc hl
    inc hl
    ld a, [hl]
    cp a, $20
    jr nz, Jump_073_64CE

Jump_073_64C9::
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_073_64CE::
    cp a, $40
    jr z, Jump_073_64C9
    jr nc, Jump_073_64D8
    call Func_073_6596
    ret

Jump_073_64D8::
    call Func_073_659D
    ret

; entry 3 of the `rst $00` table in ScriptCommand3C_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC924, wC925
; writes: wCB9A, wScriptStep
ScriptCommand3C_Run_Case03::
Jump_073_64DC:: ; address name
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    inc hl
    ld a, [hl]
    cp a, $60
    jr nz, Jump_073_64F5
    ld a, $60
    ld [wCB9A], a
    ld a, $0D
    ld [wScriptStep], a
    ret

Jump_073_64F5::
    jr nc, Jump_073_64FB
    call Func_073_65AA
    ret

Jump_073_64FB::
    call Func_073_65A4
    ret

; entry 2 of the `rst $00` table in ScriptCommand3C_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC924, wC925
; writes: wCB9B
; points at: wScriptStep
ScriptCommand3C_Run_Case02::
Jump_073_64FF:: ; address name
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    inc hl
    inc hl
    ld a, [hl]
    cp a, $40
    jr nz, Jump_073_6518
    ld a, $40
    ld [wCB9B], a
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_073_6518::
    call Func_073_6596
    ret

; entry 1 of the `rst $00` table in ScriptCommand3C_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC924, wC925
; points at: wScriptStep
ScriptCommand3C_Run_Case01::
Jump_073_651C:: ; address name
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    inc hl
    ld a, [hl]
    cp a, $70
    jr nz, Jump_073_652F

Jump_073_652A::
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_073_652F::
    cp a, $50
    jr z, Jump_073_652A
    jr nc, Jump_073_6539
    call Func_073_65AA
    ret

Jump_073_6539::
    call Func_073_65A4
    ret

; entry 0 of the `rst $00` table in ScriptCommand3C_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hFFC6, hPlayerFacing
; writes: hFFC6, hFFC7, wC924, wC925, wC937, wC938, wC939, wScriptStep
; points at: wC8EF, wSpriteSlotCount, wScriptStep
ScriptCommand3C_Run_Case00::
Jump_073_653D:: ; address name
    ld hl, $005A
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    farcall Func_012_7D95
    ldh a, [hFFC6]
    ld c, a
    sla a
    sla a
    add a, c
    ld hl, wC8EF
    add_a_to_hl
    ld a, l
    ld [wC924], a
    ld a, h
    ld [wC925], a
    ld a, [hl+]
    ld [wC937], a
    ld a, [hl+]
    ld [wC938], a
    ld a, [hl]
    ld [wC939], a
    ld hl, wSpriteSlotCount
    dec [hl]
    ldh a, [hPlayerFacing]
    or a, a
    jr nz, Jump_073_657E
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_073_657E::
    dec a
    jr nz, Jump_073_6587
    ld a, $04
    ld [wScriptStep], a
    ret

Jump_073_6587::
    dec a
    jr nz, Jump_073_6590
    ld a, $07
    ld [wScriptStep], a
    ret

Jump_073_6590::
    ld a, $0A
    ld [wScriptStep], a
    ret

; 3 call sites from 3 routines (e.g. ScriptCommand3C_Run_Case06, ScriptCommand3C_Run_Case04, ScriptCommand3C_Run_Case02)
Func_073_6596::
    inc a
    ld [hl], a
    dec hl
    dec hl
    ld [hl], $00
    ret

; 3 call sites from 3 routines (e.g. ScriptCommand3C_Run_Case08, ScriptCommand3C_Run_Case06, ScriptCommand3C_Run_Case04)
Func_073_659D::
    dec a
    ld [hl], a
    dec hl
    dec hl
    ld [hl], $02
    ret

; 3 call sites from 3 routines (e.g. ScriptCommand3C_Run_Case0B, ScriptCommand3C_Run_Case03, ScriptCommand3C_Run_Case01)
Func_073_65A4::
    dec a
    ld [hl], a
    dec hl
    ld [hl], $03
    ret

; 3 call sites from 3 routines (e.g. ScriptCommand3C_Run_Case05, ScriptCommand3C_Run_Case03, ScriptCommand3C_Run_Case01)
Func_073_65AA::
    inc a
    ld [hl], a
    dec hl
    ld [hl], $01
    ret

; implements script command type 3A; reached through ScriptCommand3A in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand3A)
; reads: wScriptStep
ScriptCommand3A_Run::
Func_073_65B0:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand3A_Run_Case00
    dw ScriptCommand3A_Run_Case01
    dw ScriptCommand3A_Run_Case02
    dw ScriptCommand3A_Run_Case03
    dw ScriptCommand3A_Run_Case04
    dw ScriptCommand3A_Run_Case05
    dw ScriptCommand3A_Run_Case06
    dw ScriptCommand3A_Run_Case03
    dw ScriptCommand3A_Run_Case08
    dw ScriptCommand3A_Run_Case09
    dw ScriptCommand3A_Run_Case0A
    dw ScriptCommand3A_Run_Case0B

; entry 11 of the `rst $00` table in ScriptCommand3A_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wC928, wC929, wScriptParam0, wScriptStartRequest
; points at: wCB8B
ScriptCommand3A_Run_Case0B::
Jump_073_65CC:: ; address name
    ld de, wCB8B
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 10 of the `rst $00` table in ScriptCommand3A_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC924, wC925, wC937, wC938, wC939
; writes: hFFC6, hFFC7, hFF8D
; points at: wScriptStep
ScriptCommand3A_Run_Case0A::
Jump_073_65ED:: ; address name
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    ld a, [wC937]
    ld [hl+], a
    ld a, [wC938]
    ld [hl+], a
    ld a, [wC939]
    ld [hl], a
    ld hl, $0002
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    farcall Func_05F_6D3F
    xor a, a
    ldh [hFF8D], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in ScriptCommand3A_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC924, wC925
; writes: wCB86, wCB8A, wCB8B, hFF8D
; points at: wScriptStep
ScriptCommand3A_Run_Case09::
Jump_073_6618:: ; address name
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    inc hl
    ld a, [hl]
    cp a, $40
    jr nz, Jump_073_6641
    dec hl
    ld [hl], $02
    ld a, $02
    ld [wCB86], a
    ld a, $40
    ld [wCB8A], a
    ld a, $50
    ld [wCB8B], a
    ld a, $0E
    ldh [hFF8D], a
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_073_6641::
    jr nc, Jump_073_6649
    inc a
    ld [hl], a
    dec hl
    ld [hl], $01
    ret

Jump_073_6649::
    dec a
    ld [hl], a
    dec hl
    ld [hl], $03
    ret

; entry 8 of the `rst $00` table in ScriptCommand3A_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC924, wC925
; points at: wScriptStep
ScriptCommand3A_Run_Case08::
Jump_073_664F:: ; address name
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    inc hl
    inc hl
    ld a, [hl]
    cp a, $50
    jr nz, Jump_073_6663
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_073_6663::
    inc a
    ld [hl], a
    dec hl
    dec hl
    ld [hl], $00
    ret

; entry 6 of the `rst $00` table in ScriptCommand3A_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC924, wC925
; writes: wScriptStep
ScriptCommand3A_Run_Case06::
Jump_073_666A:: ; address name
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    inc hl
    ld a, [hl]
    cp a, $40
    jr z, Jump_073_667C
    cp a, $50
    jr nz, Jump_073_6682

Jump_073_667C::
    ld a, $07
    ld [wScriptStep], a
    ret

Jump_073_6682::
    ld a, $08
    ld [wScriptStep], a
    ret

; entry 5 of the `rst $00` table in ScriptCommand3A_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC924, wC925
; writes: wCB8A, hFF8D, wScriptStep
ScriptCommand3A_Run_Case05::
Jump_073_6688:: ; address name
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    inc hl
    ld a, [hl]
    cp a, $40
    jr nz, Jump_073_66A8
    dec hl
    ld [hl], $00
    ld a, $40
    ld [wCB8A], a
    ld a, $0E
    ldh [hFF8D], a
    ld a, $0A
    ld [wScriptStep], a
    ret

Jump_073_66A8::
    jr nc, Jump_073_66B0
    inc a
    ld [hl], a
    dec hl
    ld [hl], $01
    ret

Jump_073_66B0::
    dec a
    ld [hl], a
    dec hl
    ld [hl], $03
    ret

; entry 4 of the `rst $00` table in ScriptCommand3A_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC924, wC925
; points at: wScriptStep
ScriptCommand3A_Run_Case04::
Jump_073_66B6:: ; address name
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    inc hl
    inc hl
    ld a, [hl]
    cp a, $30
    jr nz, Jump_073_66CA
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_073_66CA::
    dec a
    ld [hl], a
    dec hl
    dec hl
    ld [hl], $02
    ret

; entry 3 of the `rst $00` table in ScriptCommand3A_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC924, wC925
; points at: wScriptStep
ScriptCommand3A_Run_Case03::
Jump_073_66D1:: ; address name
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    inc hl
    ld a, [hl]
    cp a, $60
    jr nz, Jump_073_66E4
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_073_66E4::
    inc a
    ld [hl], a
    dec hl
    ld [hl], $01
    ret

; entry 2 of the `rst $00` table in ScriptCommand3A_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC924, wC925
; points at: wScriptStep
ScriptCommand3A_Run_Case02::
Jump_073_66EA:: ; address name
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    inc hl
    inc hl
    ld a, [hl]
    cp a, $50
    jr nz, Jump_073_66FE
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_073_66FE::
    dec a
    ld [hl], a
    dec hl
    dec hl
    ld [hl], $02
    ret

; entry 1 of the `rst $00` table in ScriptCommand3A_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC924, wC925
; writes: wScriptStep
ScriptCommand3A_Run_Case01::
Jump_073_6705:: ; address name
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    inc hl
    ld a, [hl]
    cp a, $40
    jr nz, Jump_073_6719
    ld a, $02
    ld [wScriptStep], a
    ret

Jump_073_6719::
    cp a, $50
    jr nz, Jump_073_6723
    ld a, $03
    ld [wScriptStep], a
    ret

Jump_073_6723::
    ld a, $04
    ld [wScriptStep], a
    ret

; entry 0 of the `rst $00` table in ScriptCommand3A_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hFFC6, hPlayerY, wC924, wC6FD
; writes: hFFC6, hFFC7, wC924, wC925, wC937, wC938, wC939, wScriptStep
; points at: wC8EF, wScriptStep, wC924, wC8F0
ScriptCommand3A_Run_Case00::
Jump_073_6729:: ; address name
    ld hl, $0002
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    farcall Func_012_7D95
    ldh a, [hFFC6]
    ld c, a
    sla a
    sla a
    add a, c
    ld hl, wC8EF
    add_a_to_hl
    ld a, l
    ld [wC924], a
    ld a, h
    ld [wC925], a
    ld a, [hl+]
    ld [wC937], a
    ld a, [hl+]
    ld [wC938], a
    ld a, [hl]
    ld [wC939], a
    ldh a, [hPlayerY]
    cp a, $50
    jr nz, Jump_073_6767

Jump_073_6762::
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_073_6767::
    ldh a, [hPlayerY]
    cp a, $30
    jr nz, Jump_073_6773

Jump_073_676D::
    ld a, $06
    ld [wScriptStep], a
    ret

Jump_073_6773::
    ld hl, wC924
    inc hl
    inc hl
    ld a, [wC924]
    cp a, $40
    jr z, Jump_073_6783
    jr c, Jump_073_676D
    jr Jump_073_6762

Jump_073_6783::
    ld a, [wC6FD]
    ld b, a
    ld hl, wC8F0

Jump_073_678A::
    push hl
    ld a, [hl+]
    cp a, $40
    jr nz, Jump_073_6798
    ld a, [hl]
    cp a, $30
    jr nz, Jump_073_6798
    pop hl
    jr Jump_073_676D

Jump_073_6798::
    pop hl
    dec b
    jr nz, Jump_073_678A
    jr Jump_073_6762
    db $C9

; implements script command type 35; reached through ScriptCommand35 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand35)
; reads: wScriptStep
ScriptCommand35_Run::
Func_073_679F:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand35_Run_Case00
    dw ScriptCommand35_Run_Case01
    dw ScriptCommand35_Run_Case02
    dw ScriptCommand35_Run_Case03
    dw ScriptCommand35_Run_Case01
    dw ScriptCommand35_Run_Case01
    dw ScriptCommand35_Run_Case06
    dw ScriptCommand35_Run_Case01
    dw ScriptCommand35_Run_Case08
    dw ScriptCommand35_Run_Case02
    dw ScriptCommand35_Run_Case0A
    dw ScriptCommand35_Run_Case01
    dw ScriptCommand35_Run_Case01
    dw ScriptCommand35_Run_Case0D
    dw ScriptCommand35_Run_Case01
    dw ScriptCommand35_Run_Case08
    dw ScriptCommand35_Run_Case02
    dw ScriptCommand35_Run_Case11
    dw ScriptCommand35_Run_Case01
    dw ScriptCommand35_Run_Case01
    dw ScriptCommand35_Run_Case14
    dw ScriptCommand35_Run_Case15

; entry 21 of the `rst $00` table in ScriptCommand35_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStartRequest
ScriptCommand35_Run_Case15::
Jump_073_67CF:: ; address name
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 20 of the `rst $00` table in ScriptCommand35_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCC39, hPlayerX
; writes: wCC39, hMapId, hMapScreenX, hMapScreenY, wC8C8, wC8C9, wC8C6
ScriptCommand35_Run_Case14::
Jump_073_67D5:: ; address name
    ld a, [wCC39]
    set 1, a
    ld [wCC39], a
    ld a, $40
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ldh a, [hPlayerX]
    ld [wC8C8], a
    ld a, $40
    ld [wC8C9], a
    ld a, $03
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ret

; entry 17 of the `rst $00` table in ScriptCommand35_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wScriptParam0
; points at: wScriptStep, wScreenTileBuffer
ScriptCommand35_Run_Case11::
Jump_073_67FC:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $14
    jr nz, Jump_073_680F
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]

Jump_073_680F::
    ld a, [wScriptParam0]
    bit 0, a
    jr z, Jump_073_6826
    ld de, $77D0
    ld b, $56
    call Func_073_6882
    ld de, $5ADB
    ld b, $56
    jp Func_073_6875

Jump_073_6826::
    ld de, $7827
    ld b, $56
    call Func_073_6882
    ld de, $5B8F
    ld b, $56
    jr Func_073_6875

; entry 13 of the `rst $00` table in ScriptCommand35_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX
; writes: hMapScreenX, hMapScreenY, hMapId, wC8C8, wC8C9, wC8C6
ScriptCommand35_Run_Case0D::
Jump_073_6835:: ; address name
    ld a, $05
    ldh [hMapScreenX], a
    ld a, $04
    ldh [hMapScreenY], a
    jr Jump_073_689E

; entry 10 of the `rst $00` table in ScriptCommand35_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wScriptParam0
; points at: wScriptStep, wScreenTileBuffer
ScriptCommand35_Run_Case0A::
Jump_073_683F:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $14
    jr nz, Jump_073_6852
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]

Jump_073_6852::
    ld a, [wScriptParam0]
    bit 0, a
    jr z, Jump_073_6868
    ld de, $7ABA
    ld b, $56
    call Func_073_6882
    ld de, $61F0
    ld b, $56
    jr Func_073_6875

Jump_073_6868::
    ld de, $6D99
    ld b, $56
    call Func_073_6882
    ld de, Data_056_4301
    ld b, $56

; 1 call site from 1 routine (e.g. ScriptCommand35_Run_Case03)
; points at: wScreenTileBuffer
Func_073_6875::
    ld hl, wScreenTileBuffer
    call DecompressToVRAM
    farcall Func_05F_6DDB
    ret

; 5 call sites from 3 routines (e.g. ScriptCommand35_Run_Case11, ScriptCommand35_Run_Case0A, ScriptCommand35_Run_Case03)
; reads: wIsCGB
; writes: rSVBK
; points at: wD000
Func_073_6882::
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, $02
    ldh [rSVBK], a
    ld hl, wD000
    call DecompressToVRAM
    ld a, $00
    ldh [rSVBK], a
    ret

; entry 6 of the `rst $00` table in ScriptCommand35_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX
; writes: hMapScreenX, hMapScreenY, hMapId, wC8C8, wC8C9, wC8C6
ScriptCommand35_Run_Case06::
Jump_073_6896:: ; address name
    ld a, $06
    ldh [hMapScreenX], a
    ld a, $05
    ldh [hMapScreenY], a

Jump_073_689E::
    ld a, $30
    ldh [hMapId], a
    ldh a, [hPlayerX]
    ld [wC8C8], a
    ld a, $E0
    ld [wC8C9], a
    ld a, $03
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ret

; entry 3 of the `rst $00` table in ScriptCommand35_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wScriptParam0
; points at: wScriptStep
ScriptCommand35_Run_Case03::
Jump_073_68B8:: ; address name
    ld a, [wScriptParam0]
    ld b, a
    ld a, $06
    call DivideBByA
    add a, a
    add a, a
    ld hl, $68F8
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld b, $58
    push hl
    call Func_073_6875
    pop hl
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld b, $58
    call Func_073_6882
    farcall Func_05F_6DDB
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $09
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret
    db $06, $47, $42, $4C, $FB, $47, $CB, $4C, $EE, $48, $3C, $4D, $FB, $47, $CB, $4C
    db $06, $47, $42, $4C, $FF, $45, $B3, $4B

; entry 2 of the `rst $00` table in ScriptCommand35_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wC928
ScriptCommand35_Run_Case02::
Jump_073_6910:: ; address name
    ld a, $B4
    ld [wC928], a
    farcall Func_00F_729C
    ret

; entry 1 of the `rst $00` table in ScriptCommand35_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand35_Run_Case01::
Jump_073_691C:: ; address name
    ld b, $3C
    call StepWC921Counter_Bank73
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand35_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wCB8A
; points at: wScriptStep
ScriptCommand35_Run_Case00::
Jump_073_6927:: ; address name
    ld a, $02
    call QueueMusic
    ld a, $70
    call QueueSoundEffect

; entry 8 of the `rst $00` table in ScriptCommand35_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wCB8A
; points at: wScriptStep
ScriptCommand35_Run_Case08::
Jump_073_6931:: ; address name
    ld a, $48
    ld [wCB8A], a
    farcall Func_05F_6E09
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 34; reached through ScriptCommand34 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand34)
; reads: wCC39
; writes: wC242, wC243, wC256, wC257, wCC39, wScriptStartRequest
ScriptCommand34_Run::
Func_073_6941:: ; address name
    ld a, $58
    ld [wC242], a
    ld a, $59
    ld [wC243], a
    ld a, $5A
    ld [wC256], a
    ld a, $5B
    ld [wC257], a
    farcall Func_05F_6DDB
    ld a, [wCC39]
    set 0, a
    ld [wCC39], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 33; reached through ScriptCommand33 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand33)
; reads: wScriptStep
ScriptCommand33_Run::
Func_073_6969:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand33_Run_Case00
    dw ScriptCommand33_Run_Case01
    dw ScriptCommand33_Run_Case02
    dw ScriptCommand33_Run_Case03
    dw ScriptCommand33_Run_Case04
    dw ScriptCommand33_Run_Case05
    dw ScriptCommand33_Run_Case06
    dw ScriptCommand33_Run_Case07
    dw Func_073_4E9C

; entry 7 of the `rst $00` table in ScriptCommand33_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC8FB
; writes: wC8FB
; points at: wScriptStep
ScriptCommand33_Run_Case07::
Jump_073_697F:: ; address name
    ld a, [wC8FB]
    inc a
    ld [wC8FB], a
    cp a, $40
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in ScriptCommand33_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC8F6
; writes: wC8F6, wC8FA, wC8FB, wC8F9
; points at: wScriptStep
ScriptCommand33_Run_Case06::
Jump_073_698E:: ; address name
    ld a, [wC8F6]
    inc a
    ld [wC8F6], a
    cp a, $40
    ret nz
    ld a, $40
    ld [wC8FA], a
    ld a, $30
    ld [wC8FB], a
    xor a, a
    ld [wC8F9], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in ScriptCommand33_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC8F1
; writes: wC8F1, wC8F5, wC8F6, wC8F4
; points at: wScriptStep
ScriptCommand33_Run_Case05::
Jump_073_69AB:: ; address name
    ld a, [wC8F1]
    inc a
    ld [wC8F1], a
    cp a, $40
    ret nz
    ld a, $40
    ld [wC8F5], a
    ld a, $30
    ld [wC8F6], a
    xor a, a
    ld [wC8F4], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in ScriptCommand33_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY
; writes: hPlayerY, wC8F0, wC8F1, wC8EF
; points at: wScriptStep
ScriptCommand33_Run_Case04::
Jump_073_69C8:: ; address name
    ldh a, [hPlayerY]
    inc a
    ldh [hPlayerY], a
    cp a, $40
    ret nz
    ld a, $40
    ld [wC8F0], a
    ld a, $30
    ld [wC8F1], a
    xor a, a
    ld [wC8EF], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in ScriptCommand33_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wCB8B
; writes: wScriptParam0, wCB8B, hPlayerX, hPlayerY, hPlayerFacing
; points at: wScriptStep
ScriptCommand33_Run_Case03::
Jump_073_69E3:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and a, $01
    ret nz
    ld a, [wCB8B]
    inc a
    ld [wCB8B], a
    cp a, $30
    ret nz
    ld a, $40
    ldh [hPlayerX], a
    ld a, $30
    ldh [hPlayerY], a
    xor a, a
    ldh [hPlayerFacing], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in ScriptCommand33_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC468
; writes: wCB8B, wSpriteSlotCount
; points at: wScriptStep
ScriptCommand33_Run_Case02::
Jump_073_6A0B:: ; address name
    farcall UpdatePlayerMovement
    farcall Func_002_5BD7
    ld a, [wC468]
    bit 7, a
    ret nz
    xor a, a
    ld [wCB8B], a
    ld a, $01
    ld [wSpriteSlotCount], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand33_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wCB8B, hFF8C
; writes: wScriptParam0, wCB8B, wC468, wC46A, hFF8C, hFF9D, hFF9E
; points at: hMapScreenY, hFF80, wScriptStep
ScriptCommand33_Run_Case01::
Jump_073_6A2B:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and a, $01
    ret nz
    ld a, [wCB8B]
    inc a
    ld [wCB8B], a
    cp a, $80
    ret nz
    ld a, $80
    ld [wC468], a
    ld a, $08
    ld [wC46A], a
    ld hl, hMapScreenY
    inc [hl]
    ldh a, [hFF8C]
    or a, $01
    ldh [hFF8C], a
    ld hl, hFF80
    ld a, l
    ldh [hFF9D], a
    ld a, h
    ldh [hFF9E], a
    farcall UpdatePlayerMovement
    farcall Func_002_5BD7
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand33_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wC8C8, wC8C9, wC8C6
ScriptCommand33_Run_Case00::
Jump_073_6A71:: ; address name
    ld a, $30
    ldh [hMapId], a
    ld a, $05
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $E0
    ld [wC8C8], a
    ld a, $E0
    ld [wC8C9], a
    ld a, $03
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ret

; implements script command type 30; reached through ScriptCommand30 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand30)
; reads: wScriptStep
ScriptCommand30_Run::
Func_073_6A91:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand30_Run_Case00
    dw ScriptCommand30_Run_Case01

; entry 0 of the `rst $00` table in ScriptCommand30_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wC8C8, wC8C9, wC8C6
ScriptCommand30_Run_Case00::
Jump_073_6A99:: ; address name
    ld a, $36
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wC8C8], a
    ld a, $80
    ld [wC8C9], a
    ld a, $03
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ret

; entry 1 of the `rst $00` table in ScriptCommand30_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStartRequest
ScriptCommand30_Run_Case01::
Jump_073_6AB8:: ; address name
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 2F; reached through ScriptCommand2F in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand2F)
; reads: wScriptStep
; writes: hMapId, hMapScreenX, hMapScreenY, wC8C8, wC8C9, wC8C6, wScriptStartRequest
ScriptCommand2F_Run::
Func_073_6ABE:: ; address name
    ld a, [wScriptStep]
    or a, a
    jr nz, Jump_073_6AE9
    ld a, [wScriptStep]
    or a, a
    jr nz, Jump_073_6AE9
    ld a, $3C
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $50
    ld [wC8C8], a
    ld a, $40
    ld [wC8C9], a
    ld a, $04
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ret

Jump_073_6AE9::
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 2E; reached through ScriptCommand2E in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand2E)
; reads: wScriptStep
; writes: wScriptStartRequest
ScriptCommand2E_Run::
Func_073_6AEF:: ; address name
    ld a, [wScriptStep]
    or a, a
    jr nz, Jump_073_6AF9
    call Func_073_6B1F
    ret

Jump_073_6AF9::
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 2D; reached through ScriptCommand2D in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand2D)
; reads: wScriptStep
ScriptCommand2D_Run::
Func_073_6AFF:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand2D_Run_Case00
    dw ScriptCommand2D_Run_Case01
    dw ScriptCommand2D_Run_Case01
    dw ScriptCommand2D_Run_Case01
    dw ScriptCommand2D_Run_Case04
    dw ScriptCommand2D_Run_Case05
    dw Func_073_6C77
    dw ScriptCommand2D_Run_Case07
    dw ScriptCommandCB_Run_Case01
    dw Func_073_6B1F
    dw ScriptCommand2D_Run_Case0A

; entry 10 of the `rst $00` table in ScriptCommand2D_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStartRequest
ScriptCommand2D_Run_Case0A::
Jump_073_6B19:: ; address name
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; 1 call site from 1 routine (e.g. ScriptCommand2E_Run)
; writes: hMapId, hMapScreenX, hMapScreenY, wC8C8, wC8C9, wC8C6
Func_073_6B1F::
    ld a, $41
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ld a, $01
    ldh [hMapScreenY], a
    ld a, $70
    ld [wC8C8], a
    ld a, $30
    ld [wC8C9], a
    ld a, $01
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ld de, $006F
    call SetFlagBit
    ret

; entry 7 of the `rst $00` table in ScriptCommand2D_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wCB96
; points at: wScriptStep
ScriptCommand2D_Run_Case07::
Jump_073_6B46:: ; address name
    xor a, a
    call Func_073_7AB2
    ret nc
    ld a, $01
    ld [wCB96], a
    ld hl, wScriptStep
    inc [hl]
    ld hl, $0849
    call StoreHLInWC924_B73b
    ret

; implements script command type 2C; reached through ScriptCommand2C in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand2C)
; reads: wScriptStep
ScriptCommand2C_Run::
Func_073_6B5B:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand2D_Run_Case00
    dw ScriptCommand2D_Run_Case01
    dw ScriptCommand2D_Run_Case01
    dw ScriptCommand2D_Run_Case01
    dw ScriptCommand2D_Run_Case04
    dw ScriptCommand2C_Run_Case05
    dw ScriptCommand2C_Run_Case06
    dw ScriptCommand2C_Run_Case07
    dw ScriptCommand2C_Run_Case08

; entry 8 of the `rst $00` table in ScriptCommand2C_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStartRequest
ScriptCommand2C_Run_Case08::
Jump_073_6B71:: ; address name
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 7 of the `rst $00` table in ScriptCommand2C_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wCB9A
ScriptCommand2C_Run_Case07::
Jump_073_6B77:: ; address name
    call Func_073_6C77
    ld a, $E0
    ld [wCB9A], a
    ret

; entry 6 of the `rst $00` table in ScriptCommand2C_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand2C_Run_Case06::
Jump_073_6B80:: ; address name
    farcall Func_05F_6E58
    ret

; entry 5 of the `rst $00` table in ScriptCommand2C_Run
; no direct call (reached through a table, a jump or a vector)
; points at: hFF8C, wScriptStep
ScriptCommand2C_Run_Case05::
Jump_073_6B87:: ; address name
    ld hl, hFF8C
    call SetBit2AtHL_B73
    ld hl, hFF8C
    call SetBit1AtHL_Bank73
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 2B; reached through ScriptCommand2B in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand2B)
; reads: wScriptStep
ScriptCommand2B_Run::
Func_073_6B98:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand2D_Run_Case00
    dw ScriptCommand2D_Run_Case01
    dw ScriptCommand2D_Run_Case01
    dw ScriptCommand2D_Run_Case01
    dw ScriptCommand2D_Run_Case04
    dw ScriptCommand2D_Run_Case05
    dw Func_073_6C77
    dw ScriptCommand2B_Run_Case07
    dw ScriptCommand2B_Run_Case08
    dw ScriptCommand2B_Run_Case09
    dw ScriptCommand60_Run_Case01
    dw ScriptCommand2B_Run_Case0B
    dw ScriptCommand2B_Run_Case08

; entry 8 of the `rst $00` table in ScriptCommand2B_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wCB9A, wScriptStartRequest
ScriptCommand2B_Run_Case08::
Jump_073_6BB6:: ; address name
    xor a, a
    call Func_073_7AB2
    ret nc
    ld a, $E0
    ld [wCB9A], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 11 of the `rst $00` table in ScriptCommand2B_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCBD3, wScriptParam0
; writes: wCBD3, wC928, wC929, wScriptParam0, wCBCF, hFF8D
; points at: wCBD4, wScriptStep
ScriptCommand2B_Run_Case0B::
Jump_073_6BC6:: ; address name
    ld a, [wCBD3]
    inc a
    inc a
    ld [wCBD3], a
    ld de, wCBD4
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    xor a, a
    ld [wCBCF], a
    ld a, $2C
    ld [wC928], a
    farcall Func_05F_6C8C
    ld de, $006E
    call SetFlagBit
    ld hl, $0813
    call StoreHLInWC924_B73b
    xor a, a
    ldh [hFF8D], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand60_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wCBD4, wScriptStep
ScriptCommand60_Run_Case01::
Jump_073_6C0C:: ; address name
    ld hl, wCBD4
    dec [hl]
    ld de, wCBD4
    call Func_073_7A5D
    ret nc
    ld a, $65
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in ScriptCommand2B_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hFFC6, wCBCF, hFF8D
; points at: wScriptStep
ScriptCommand2B_Run_Case09::
Jump_073_6C21:: ; address name
    xor a, a
    call Func_073_7AB2
    ret nc
    ld a, $10
    ldh [hFFC6], a
    farcall Func_012_6B98
    ld a, $80
    ld [wCBCF], a
    ld a, $0E
    ldh [hFF8D], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in ScriptCommand2B_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC634
; writes: wCB96
; points at: wScriptStep
ScriptCommand2B_Run_Case07::
Jump_073_6C3E:: ; address name
    xor a, a
    call Func_073_7AB2
    ret nc
    ld a, $01
    ld [wCB96], a
    ld hl, wScriptStep
    inc [hl]
    ld de, $006E
    call TestFlagBit
    jr nc, Jump_073_6C5B
    ld hl, $0815
    call StoreHLInWC924_B73b
    ret

Jump_073_6C5B::
    ld a, [wC634]
    cp a, $FF
    jr z, Jump_073_6C6C
    or a, a
    jr z, Jump_073_6C6C
    ld hl, $0814
    call StoreHLInWC924_B73b
    ret

Jump_073_6C6C::
    ld hl, $0812
    call StoreHLInWC924_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. ScriptCommand2C_Run_Case07)
; reads: hPlayerX
; writes: wC8EF, wC8F4, wC8F9, hPlayerFacing, hPlayerX, wScriptParam0, wCB9A
; points at: hFF8C, wC8F0, wC8F6, wC8FB, wScriptStep
Func_073_6C77::
    ld hl, hFF8C
    call SetBit2AtHL_B73
    ld a, $03
    ld [wC8EF], a
    xor a, a
    ld [wC8F4], a
    ld a, $02
    ld [wC8F9], a
    ld a, $01
    ldh [hPlayerFacing], a
    ld hl, wC8F0
    dec [hl]
    ld hl, wC8F6
    inc [hl]
    ld hl, wC8FB
    dec [hl]
    ldh a, [hPlayerX]
    inc a
    ldh [hPlayerX], a
    cp a, $70
    ret nz
    ld a, $03
    ldh [hPlayerFacing], a
    ld [wC8EF], a
    ld [wC8F4], a
    ld [wC8F9], a
    ld hl, hFF8C
    call ClearBit2AtHL_Bank73
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ld a, $30
    ld [wCB9A], a
    ld hl, $0886
    call StoreHLInWC924_B73b
    ret

; entry 5 of the `rst $00` table in ScriptCommand2D_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand2D_Run_Case05::
Jump_073_6CCA:: ; address name
    farcall Func_05F_6EC3
    ret

; entry 4 of the `rst $00` table in ScriptCommand2D_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX
; writes: wC8EF, wC8F4, wC8F9, hPlayerFacing, hPlayerX, wScriptParam0, wC92D
; points at: hFF8C, wC8F0, wC8F6, wC8FB, wScriptStep
ScriptCommand2D_Run_Case04::
Jump_073_6CD1:: ; address name
    ld hl, hFF8C
    call SetBit2AtHL_B73
    ld a, $01
    ld [wC8EF], a
    ld a, $02
    ld [wC8F4], a
    xor a, a
    ld [wC8F9], a
    ld a, $03
    ldh [hPlayerFacing], a
    ld hl, wC8F0
    inc [hl]
    ld hl, wC8F6
    dec [hl]
    ld hl, wC8FB
    inc [hl]
    ldh a, [hPlayerX]
    dec a
    ldh [hPlayerX], a
    cp a, $60
    ret nz
    xor a, a
    ldh [hPlayerFacing], a
    ld [wC8EF], a
    ld [wC8F4], a
    ld [wC8F9], a
    ld hl, hFF8C
    call ClearBit2AtHL_Bank73
    ld hl, wScriptStep
    inc [hl]
    xor a, a
    ld [wScriptParam0], a
    ld [wC92D], a
    ret

; entry 1 of the `rst $00` table in ScriptCommand2D_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand2D_Run_Case01::
Jump_073_6D1B:: ; address name
    farcall Func_012_61EF
    ret

; entry 0 of the `rst $00` table in ScriptCommand2D_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY, hPlayerX, wC92C
; writes: wC928, hPlayerFacing
; points at: wScriptStep
ScriptCommand2D_Run_Case00::
Jump_073_6D22:: ; address name
    ldh a, [hPlayerY]
    cp a, $40
    jr z, Jump_073_6D34
    ld a, $40
    ld [wC928], a
    farcall Func_05F_6A94
    ret

Jump_073_6D34::
    ldh a, [hPlayerX]
    cp a, $70
    jr z, Jump_073_6D4D
    ld a, $70
    ld [wC928], a
    farcall Func_05F_6ABF
    ld a, [wC92C]
    or a, a
    ret z
    xor a, a
    ldh [hPlayerFacing], a

Jump_073_6D4D::
    ld hl, wScriptStep
    inc [hl]
    ret
    INCBIN "dwm2-cobi-us.gbc", $1CED52, $C5

; implements script command type 26; reached through ScriptCommand26 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand26)
; reads: wScriptStep
ScriptCommand26_Run::
Func_073_6E17:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand26_Run_Case00
    dw ScriptCommand82_Run_Table3_Case07
    dw ScriptCommand26_Run_Case02
    dw ScriptCommand26_Run_Case03

; entry 3 of the `rst $00` table in ScriptCommand26_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStartRequest
ScriptCommand26_Run_Case03::
Jump_073_6E23:: ; address name
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in ScriptCommand26_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX, hPlayerY, hPlayerFacing
; writes: wC8C8, wC8C9, wC8C6
ScriptCommand26_Run_Case02::
Jump_073_6E29:: ; address name
    ldh a, [hPlayerX]
    ld [wC8C8], a
    ldh a, [hPlayerY]
    ld [wC8C9], a
    ldh a, [hPlayerFacing]
    inc a
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ret

; entry 0 of the `rst $00` table in ScriptCommand26_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: hFFB9
; points at: wC49F, wC0F0, wScriptStep
ScriptCommand26_Run_Case00::
Jump_073_6E40:: ; address name
    xor a, a
    ldh [hFFB9], a
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_073_6E55
    ld hl, wC49F
    ld de, wC0F0
    ld bc, $0040
    call CopyBytes

Jump_073_6E55::
    ld a, $7A
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 1E; reached through ScriptCommand1E in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand1E)
; reads: hFFC6, wC836
; writes: hFFC6, wC836, wScriptStartRequest
; points at: wInventory
ScriptCommand1E_Run::
Func_073_6E5F:: ; address name
    ld a, $19
    ldh [hFFC6], a
    farcall FindHFFC6InWC61DList
    ldh a, [hFFC6]
    bit 7, a
    jr z, Jump_073_6EA0
    ld a, $1A
    ldh [hFFC6], a
    farcall FindHFFC6InWC61DList
    ldh a, [hFFC6]
    bit 7, a
    jr z, Jump_073_6EA0
    ld a, $1B
    ldh [hFFC6], a
    farcall FindHFFC6InWC61DList
    ldh a, [hFFC6]
    bit 7, a
    jr z, Jump_073_6EA0
    ld a, $1C
    ldh [hFFC6], a
    farcall FindHFFC6InWC61DList
    ldh a, [hFFC6]
    bit 7, a
    jr z, Jump_073_6EA0
    ret

Jump_073_6EA0::
    ld hl, wInventory
    ldh a, [hFFC6]
    add_a_to_hl
    ld [hl], $30
    ld a, [wC836]
    set 6, a
    ld [wC836], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 25; reached through ScriptCommand25 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand25)
; reads: wScriptStep
ScriptCommand25_Run::
Func_073_6EBA:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand25_Run_Case00
    dw ScriptCommand25_Run_Case01

; entry 1 of the `rst $00` table in ScriptCommand25_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStartRequest
ScriptCommand25_Run_Case01::
Jump_073_6EC2:: ; address name
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 0 of the `rst $00` table in ScriptCommand25_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCC38, hPlayerX, hPlayerY, hPlayerFacing
; writes: wCC38, wC8C8, wC8C9, wC8C6
ScriptCommand25_Run_Case00::
Jump_073_6EC8:: ; address name
    ld a, [wCC38]
    or a, $02
    ld [wCC38], a
    ldh a, [hPlayerX]
    ld [wC8C8], a
    ldh a, [hPlayerY]
    ld [wC8C9], a
    ldh a, [hPlayerFacing]
    inc a
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ret

; implements script command type 21; reached through ScriptCommand21 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand21)
; reads: wScriptStep
ScriptCommand21_Run::
Func_073_6EE7:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand21_Run_Case00
    dw ScriptCommand21_Run_Case01

; entry 0 of the `rst $00` table in ScriptCommand21_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hFFC6
; points at: wScriptStep
ScriptCommand21_Run_Case00::
Jump_073_6EEF:: ; address name
    ld b, $5A
    call StepWC921Counter_Bank73
    ret nc
    ld a, $05
    ldh [hFFC6], a
    farcall Func_012_6B98
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand21_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wCBCF, wScriptStartRequest
ScriptCommand21_Run_Case01::
Jump_073_6F04:: ; address name
    ld b, $28
    call StepWC921Counter_Bank73
    ret nc
    xor a, a
    ld [wCBCF], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 1A; reached through ScriptCommand1A in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand1A)
; reads: hPlayerX, hPlayerY, wCBD4
; writes: wCBCF, wCBD3, wCBD4, wScriptStartRequest
; points at: wCBD3, wCBD4
ScriptCommand1A_Run::
Func_073_6F14:: ; address name
    ldh a, [hPlayerX]
    cp a, $50
    jr nz, Jump_073_6F24
    ld hl, wCBD3
    inc [hl]
    ld hl, wCBD4
    inc [hl]
    jr Jump_073_6F40

Jump_073_6F24::
    cp a, $30
    jr nz, Jump_073_6F32
    ld hl, wCBD3
    dec [hl]
    ld hl, wCBD4
    inc [hl]
    jr Jump_073_6F40

Jump_073_6F32::
    ldh a, [hPlayerY]
    cp a, $20
    jr z, Jump_073_6F40
    ld a, [wCBD4]
    inc a
    inc a
    ld [wCBD4], a

Jump_073_6F40::
    ld de, wCBD4
    call Func_073_7A5D
    ret nc
    xor a, a
    ld [wCBCF], a
    ld a, $40
    ld [wCBD3], a
    ld a, $30
    ld [wCBD4], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 19; reached through ScriptCommand19 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand19)
; reads: wScriptStep
; writes: wCBCF, wScriptStartRequest
; points at: wScriptStep, wCBD4
ScriptCommand19_Run::
Func_073_6F5B:: ; address name
    ld a, [wScriptStep]
    or a, a
    jr nz, Jump_073_6F6B
    ld a, $80
    ld [wCBCF], a
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_073_6F6B::
    ld hl, wCBD4
    dec [hl]
    ld de, wCBD4
    call Func_073_7A5D
    ret nc
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 20; reached through ScriptCommand20 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand20)
; reads: wScriptStep
ScriptCommand20_Run::
Func_073_6F7C:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand20_Run_Case00
    dw ScriptCommand20_Run_Case01
    dw ScriptCommand20_Run_Case02
    dw ScriptCommand20_Run_Case03

; entry 3 of the `rst $00` table in ScriptCommand20_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, hPlayerFacing
; writes: wScriptParam0, wCB86, wCB8A, wScriptStartRequest
ScriptCommand20_Run_Case03::
Jump_073_6F88:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $3C
    ret nz
    ld a, $72
    call QueueSoundEffect
    ldh a, [hPlayerFacing]
    inc a
    inc a
    and a, $03
    ld [wCB86], a
    ld a, $40
    ld [wCB8A], a
    ld de, $0019
    call SetFlagBit
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in ScriptCommand20_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC8F5
; writes: wC8F4, wC8F5
; points at: wScriptStep
ScriptCommand20_Run_Case02::
Jump_073_6FB1:: ; address name
    ld a, $01
    ld [wC8F4], a
    ld a, [wC8F5]
    inc a
    ld [wC8F5], a
    cp a, $B0
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand20_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wC8F5, wC8F6
; writes: wScriptParam0, wC8F4
; points at: wC8F5, wScriptStep, wC8F6
ScriptCommand20_Run_Case01::
Jump_073_6FC5:: ; address name
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_073_6FE2
    ld a, [wC8F5]
    cp a, $50
    jr nz, Jump_073_6FD8
    ld a, $01
    ld [wScriptParam0], a
    ret

Jump_073_6FD8::
    ld a, $01
    ld [wC8F4], a
    ld hl, wC8F5
    inc [hl]
    ret

Jump_073_6FE2::
    ld a, [wC8F6]
    cp a, $40
    jr nz, Jump_073_6FF2
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_073_6FF2::
    jr nc, Jump_073_6FFD
    xor a, a
    ld [wC8F4], a
    ld hl, wC8F6
    inc [hl]
    ret

Jump_073_6FFD::
    ld a, $02
    ld [wC8F4], a
    ld hl, wC8F6
    dec [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand20_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC8F5, wC8F6
; writes: wScriptParam0
; points at: wScriptStep
ScriptCommand20_Run_Case00::
Jump_073_7007:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, [wC8F5]
    cp a, $40
    jr nz, Jump_073_701E
    ld a, [wC8F6]
    cp a, $20
    jr nz, Jump_073_701E
    xor a, a
    ld [wScriptParam0], a
    ret

Jump_073_701E::
    ld a, $01
    ld [wScriptParam0], a
    ret

; implements script command type 16; reached through ScriptCommand16 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand16)
; reads: wScriptStep
ScriptCommand16_Run::
Func_073_7024:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw Func_073_734D
    dw ScriptCommand16_Run_Case01
    dw ScriptCommand16_Run_Case01
    dw ScriptCommandCB_Run_Case01
    dw ScriptCommand16_Run_Case04
    dw ScriptCommand16_Run_Case04
    dw ScriptCommandCB_Run_Case01
    dw ScriptCommand16_Run_Case07
    dw ScriptCommand16_Run_Case07
    dw ScriptCommandCB_Run_Case01
    dw Func_073_734D
    dw ScriptCommand16_Run_Case0B
    dw ScriptCommand16_Run_Case0C
    dw ScriptCommandCB_Run_Case01
    dw ScriptCommand16_Run_Case0E
    dw ScriptCommand16_Run_Case0F
    dw ScriptCommand16_Run_Case10
    dw ScriptCommand16_Run_Case11
    dw ScriptCommand16_Run_Case12
    dw ScriptCommand16_Run_Case13
    dw ScriptCommand16_Run_Case12
    dw ScriptCommand16_Run_Case15
    dw ScriptCommand16_Run_Case16
    dw ScriptCommand16_Run_Case17
    dw ScriptCommand16_Run_Case18
    dw ScriptCommandCB_Run_Case01
    dw ScriptCommand16_Run_Case1A
    dw ScriptCommand16_Run_Case1B
    dw ScriptCommand16_Run_Case1C

; entry 28 of the `rst $00` table in ScriptCommand16_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wC92C
; writes: wScriptParam0, wC928, hPlayerFacing, wC8EF, wScriptStartRequest
ScriptCommand16_Run_Case1C::
Jump_073_7062:: ; address name
    ld a, [wScriptParam0]
    inc a
    cp a, $1E
    jr z, Jump_073_706E
    ld [wScriptParam0], a
    ret

Jump_073_706E::
    dec a
    ld [wScriptParam0], a
    ld a, $40
    ld [wC928], a
    farcall Func_05F_6B17
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $02
    ldh [hPlayerFacing], a
    ld [wC8EF], a
    ld de, $000C
    call SetFlagBit
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 27 of the `rst $00` table in ScriptCommand16_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wCBCF
; points at: wCBD4, wScriptStep
ScriptCommand16_Run_Case1B::
Jump_073_7095:: ; address name
    ld hl, wCBD4
    inc [hl]
    ld de, wCBD4
    call Func_073_7A5D
    ret nc
    xor a, a
    ld [wCBCF], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 26 of the `rst $00` table in ScriptCommand16_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC92C
; writes: wC928, hPlayerFacing
; points at: wScriptStep
ScriptCommand16_Run_Case1A::
Jump_073_70A9:: ; address name
    ld a, $68
    ld [wC928], a
    farcall Func_05F_6B17
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $02
    ldh [hPlayerFacing], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 24 of the `rst $00` table in ScriptCommand16_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand16_Run_Case18::
Jump_073_70C2:: ; address name
    ld b, $B4
    call StepWC921Counter_Bank73
    ret nc
    ld hl, $005C
    call StoreHLInWC924_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 23 of the `rst $00` table in ScriptCommand16_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC926, wScriptParam0, wCB86, wCB8A
; writes: wC928, wC929, wCB86, wCB8A, wScriptParam0, hFFC6, wCB81
; points at: wCB8B, wScriptStep
ScriptCommand16_Run_Case17::
Jump_073_70D3:: ; address name
    ld a, [wC926]
    cp a, $FF
    jr z, Jump_073_70E5
    xor a, a
    ld [wC928], a
    farcall Func_05F_6936
    ret

Jump_073_70E5::
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_073_70F0
    ld a, $65
    call QueueSoundEffect

Jump_073_70F0::
    ld de, wCB8B
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    and a, $01
    jr nz, Jump_073_7111
    ld a, [wCB86]
    inc a
    and a, $03
    ld [wCB86], a

Jump_073_7111::
    ld a, [wCB8A]
    cp a, $40
    jr z, Jump_073_711D
    dec a
    dec a
    ld [wCB8A], a

Jump_073_711D::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    jr z, Jump_073_7138
    farcall Func_012_6B22
    xor a, a
    ldh [hFFC6], a
    farcall Func_012_6B33
    ret

Jump_073_7138::
    ld a, $72
    call QueueSoundEffect
    ld de, Data_07D_7AD4
    ld b, $7D
    ld hl, vTiles0 + $500
    call DecompressToVRAM
    ld a, $49
    ld [wCB81], a
    xor a, a
    ld [wCB86], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 22 of the `rst $00` table in ScriptCommand16_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hFFC6
; points at: wCB86, wScriptStep
ScriptCommand16_Run_Case16::
Jump_073_715A:: ; address name
    farcall Func_012_6B22
    xor a, a
    ldh [hFFC6], a
    farcall Func_012_6B33
    ld de, wCB86
    call Func_073_7A51
    ld b, $78
    call StepWC921Counter_Bank73
    ret nc
    ld hl, $005B
    call StoreHLInWC924_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 21 of the `rst $00` table in ScriptCommand16_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC92C
; writes: hFFC6, wC929, wC92A, wC928, wScriptParam0
; points at: wCB86, wScriptParam0, wScriptStep
ScriptCommand16_Run_Case15::
Jump_073_7180:: ; address name
    farcall Func_012_6B22
    xor a, a
    ldh [hFFC6], a
    farcall Func_012_6B33
    ld de, wCB86
    call Func_073_7A51
    ld hl, wScriptParam0
    inc [hl]
    ld a, $01
    ld [wC929], a
    ld a, $81
    ld [wC92A], a
    ld a, $B0
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 19 of the `rst $00` table in ScriptCommand16_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hFFC6
; points at: wCB86, wCB9B
ScriptCommand16_Run_Case13::
Jump_073_71BC:: ; address name
    farcall Func_012_6B22
    xor a, a
    ldh [hFFC6], a
    farcall Func_012_6B33
    ld de, wCB86
    call Func_073_7A51
    ld de, wCB9B
    ld hl, $005A
    call Func_073_7A7F
    ret

; entry 18 of the `rst $00` table in ScriptCommand16_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0
; points at: wCB86, wScriptParam0, wScriptStep
ScriptCommand16_Run_Case12::
Jump_073_71DB:: ; address name
    ld a, $01
    call Func_073_7AB2
    push af
    ld de, wCB86
    call Func_073_7A51
    ld hl, wScriptParam0
    inc [hl]
    pop af
    ret nc
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 17 of the `rst $00` table in ScriptCommand16_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wC8EF, wC8F0, wC8F1, hFFC6, wCBCF
; points at: wCB8B
ScriptCommand16_Run_Case11::
Jump_073_71F6:: ; address name
    ld a, $02
    ld [wC8EF], a
    ld a, $70
    ld [wC8F0], a
    ld a, $40
    ld [wC8F1], a
    farcall Func_012_6B22
    xor a, a
    ldh [hFFC6], a
    farcall Func_012_6B33
    ld a, $80
    ld [wCBCF], a
    ld de, wCB8B
    ld hl, $0059
    call Func_073_7A7F
    ret

; entry 16 of the `rst $00` table in ScriptCommand16_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX, hPlayerY
; writes: wCBA6, wC8C8, wC8C9, wC8C6
; points at: wCBAB
ScriptCommand16_Run_Case10::
Jump_073_7223:: ; address name
    ld a, $02
    ld [wCBA6], a
    ld hl, wCBAB
    inc [hl]
    ld de, wCBAB
    call Func_073_7A5D
    ret nc
    ld de, $000B
    call SetFlagBit
    ldh a, [hPlayerX]
    ld [wC8C8], a
    ldh a, [hPlayerY]
    ld [wC8C9], a
    ld a, $04
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ret

; entry 15 of the `rst $00` table in ScriptCommand16_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wC928, wC929, wScriptParam0, hFFC6
; points at: wCBAA, wCB9B, wCBAB, wCBD4, wScriptStep
ScriptCommand16_Run_Case0F::
Jump_073_724F:: ; address name
    ld hl, wCBAA
    dec [hl]
    ld de, wCB9B
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld de, wCBAB
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld de, wCBD4
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    and a, $01
    jr z, Jump_073_728D

Jump_073_728D::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    xor a, a
    ldh [hFFC6], a
    farcall Func_012_6AD9
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 14 of the `rst $00` table in ScriptCommand16_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC8F1
; writes: wC8F1, wCB9A, wCBAA, wCBD3, wScriptParam0
; points at: wScriptStep
ScriptCommand16_Run_Case0E::
Jump_073_72A9:: ; address name
    ld a, [wC8F1]
    dec a
    dec a
    ld [wC8F1], a
    cp a, $38
    jr z, Jump_073_72B9
    call Func_073_736B
    ret

Jump_073_72B9::
    ld a, $80
    ld [wCB9A], a
    ld a, $60
    ld [wCBAA], a
    ld a, $70
    ld [wCBD3], a
    ld a, $63
    call QueueSoundEffect
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 12 of the `rst $00` table in ScriptCommand16_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wFrameCounterLo, wC8F1
; writes: wC8F1
; points at: wScriptStep
ScriptCommand16_Run_Case0C::
Jump_073_72D6:: ; address name
    ld a, [wFrameCounterLo]
    and a, $03
    ret nz
    ld a, [wC8F1]
    inc a
    ld [wC8F1], a
    cp a, $48
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ld de, $0001
    call TestFlagBit
    jr c, Jump_073_72F9
    ld hl, $0058
    call StoreHLInWC924_B73b
    ret

Jump_073_72F9::
    ld hl, $005E
    call StoreHLInWC924_B73b
    ret

; entry 11 of the `rst $00` table in ScriptCommand16_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC8F0
; writes: wC8F0, wC8EF
; points at: wScriptStep
ScriptCommand16_Run_Case0B::
Jump_073_7300:: ; address name
    call Func_073_736B
    ld a, [wC8F0]
    dec a
    ld [wC8F0], a
    cp a, $70
    ret nz
    ld a, $02
    ld [wC8EF], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in ScriptCommand16_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wCB9B, wScriptStep
ScriptCommand16_Run_Case07::
Jump_073_7317:: ; address name
    ld de, wCB9B
    call Func_073_7A5D
    ret nc
    ld hl, $0055
    call StoreHLInWC924_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in ScriptCommand16_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wCBAB, wScriptStep
ScriptCommand16_Run_Case04::
Jump_073_7329:: ; address name
    ld de, wCBAB
    call Func_073_7A5D
    ret nc
    ld hl, $0054
    call StoreHLInWC924_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand16_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wCB9B, wScriptStep
ScriptCommand16_Run_Case01::
Jump_073_733B:: ; address name
    ld de, wCB9B
    call Func_073_7A5D
    ret nc
    ld hl, $0053
    call StoreHLInWC924_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. ScriptCommand5F_Run_Case09)
; reads: wScriptParam0
; writes: wCBCF
; points at: wCB9C, wCBAC, wScriptStep
Func_073_734D::
    ld hl, wCB9C
    call SetBit2AtHL_B73
    ld hl, wCBAC
    call SetBit2AtHL_B73
    ld a, $80
    ld [wCBCF], a
    call Func_073_736B
    ld a, [wScriptParam0]
    or a, a
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; 3 call sites from 3 routines (e.g. ScriptCommand16_Run_Case0E, ScriptCommand16_Run_Case0B, Func_073_734D)
; reads: wScriptParam0, wCB9A, wCBAA, wCBD3
; writes: wCB9A, wCBAA, wCBD3
; points at: wScriptParam0
Func_073_736B::
    ld a, [wScriptParam0]
    and a, $3F
    ld hl, $7526
    add_a_to_hl
    ld a, [hl]
    ld c, a
    ld a, [wScriptParam0]
    and a, $40
    jr z, Jump_073_7386
    ld a, c
    xor a, $FF
    inc a
    ld c, a

Jump_073_7386::
    ld a, [wCB9A]
    add a, c
    ld [wCB9A], a
    ld a, [wCBAA]
    add a, c
    ld [wCBAA], a
    ld a, [wCBD3]
    add a, c
    ld [wCBD3], a
    ld hl, wScriptParam0
    inc [hl]
    ret

; implements script command type 15; reached through ScriptCommand15 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand15)
; reads: wScriptStep
ScriptCommand15_Run::
Func_073_73A0:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand15_Run_Case00
    dw ScriptCommand15_Run_Case01
    dw ScriptCommand15_Run_Case02
    dw ScriptCommand15_Run_Case02
    dw ScriptCommand15_Run_Case01
    dw ScriptCommand15_Run_Case01
    dw ScriptCommand15_Run_Case02
    dw ScriptCommand15_Run_Case02
    dw ScriptCommand15_Run_Case01
    dw ScriptCommand15_Run_Case09
    dw ScriptCommand15_Run_Case0A

; entry 10 of the `rst $00` table in ScriptCommand15_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wC92C
; writes: wC929, wC92A, wC928, wCBAA, wCB9A, wScriptStartRequest
; points at: wScriptParam0
ScriptCommand15_Run_Case0A::
Jump_073_73BA:: ; address name
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_073_73F9
    ld a, $01
    ld [wC929], a
    ld a, $82
    ld [wC92A], a
    ld a, $50
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, $02
    ld [wC929], a
    ld a, $81
    ld [wC92A], a
    ld a, $50
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $E0
    ld [wCBAA], a
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_073_73F9::
    ld a, $01
    ld [wC929], a
    ld a, $81
    ld [wC92A], a
    ld a, $50
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $E0
    ld [wCB9A], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 9 of the `rst $00` table in ScriptCommand15_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, hPlayerX, wCBAA
; writes: wCBD3, wScriptParam0, wC928, wC929, wCBCF, wCBD4, wScriptParam1, hPlayerX, ...
; points at: wCBD4, hFF8C, wCBAC, wScriptStep
ScriptCommand15_Run_Case09::
Jump_073_741E:: ; address name
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_073_7429
    ld a, $65
    call QueueSoundEffect

Jump_073_7429::
    ld a, [wScriptParam0]
    ld hl, $749A
    add_a_to_hl
    ld a, [hl]
    ld [wCBD3], a
    ld a, [wScriptParam0]
    push af
    srl a
    ld [wScriptParam0], a
    ld de, wCBD4
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    pop af
    ld [wScriptParam0], a
    ldh a, [hPlayerX]
    cp a, $00
    jr nz, Jump_073_746A
    ld hl, hFF8C
    call ClearBit2AtHL_Bank73
    ld hl, wCBAC
    call ClearBit2AtHL_Bank73
    jr Jump_073_7476

Jump_073_746A::
    dec a
    dec a
    ldh [hPlayerX], a
    ld a, [wCBAA]
    inc a
    inc a
    ld [wCBAA], a

Jump_073_7476::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $40
    ret nz
    xor a, a
    ld [wCBCF], a
    ld a, $68
    ld [wCBD3], a
    ld a, $30
    ld [wCBD4], a
    ld hl, wScriptStep
    inc [hl]
    xor a, a
    ld [wScriptParam0], a
    ld [wScriptParam1], a
    ret
    db $21, $22, $23, $23, $24, $25, $26, $27, $28, $29, $2A, $2A, $2B, $2C, $2D, $2E
    db $2F, $30, $30, $31, $32, $33, $34, $35, $35, $36, $37, $38, $39, $39, $3A, $3B
    db $3C, $3C, $3D, $3E, $3E, $3F, $40, $40, $41, $42, $42, $43, $44, $44, $45, $46
    db $46, $47, $48, $48, $49, $4A, $4A, $4B, $4C, $4C, $4D, $4E, $4E, $4F, $50, $50

; entry 2 of the `rst $00` table in ScriptCommand15_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wCBAA, hPlayerX, wC8F0, wCBD3
; writes: wCBAA, hPlayerX, wC8F0, wCBD3, wScriptParam0
; points at: wScriptStep
ScriptCommand15_Run_Case02::
Jump_073_74DA:: ; address name
    ld a, [wScriptParam0]
    ld hl, $7526
    add_a_to_hl
    ld a, [hl]
    xor a, $FF
    inc a
    ld c, a
    jr Jump_073_74F9

; entry 1 of the `rst $00` table in ScriptCommand15_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wCBAA, hPlayerX, wC8F0, wCBD3
; writes: wCBAA, hPlayerX, wC8F0, wCBD3, wScriptParam0
; points at: wScriptStep
ScriptCommand15_Run_Case01::
Jump_073_74EC:: ; address name
    ld a, [wScriptParam0]
    ld hl, $7526
    add_a_to_hl
    ld a, [hl]
    ld c, a

Jump_073_74F9::
    ld a, [wCBAA]
    add a, c
    ld [wCBAA], a
    ldh a, [hPlayerX]
    add a, c
    ldh [hPlayerX], a
    ld a, [wC8F0]
    add a, c
    ld [wC8F0], a
    ld a, [wCBD3]
    add a, c
    ld [wCBD3], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $40
    ret nz
    ld hl, wScriptStep
    inc [hl]
    xor a, a
    ld [wScriptParam0], a
    ret
    db $01, $00, $01, $00, $01, $01, $00, $FF, $01, $00, $00, $FF, $00, $FF, $FF, $00
    db $01, $00, $00, $00, $01, $01, $FF, $00, $00, $FF, $00, $00, $00, $FF, $01, $00
    db $01, $00, $01, $00, $00, $01, $01, $01, $00, $00, $FF, $00, $00, $00, $FF, $01
    db $FF, $00, $00, $01, $FF, $FF, $FF, $00, $00, $00, $FF, $00, $00, $FF, $FF, $00

; entry 0 of the `rst $00` table in ScriptCommand15_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC92C
; writes: wC928, wC8EF
; points at: hFF8C, wCBAC, wScriptStep
ScriptCommand15_Run_Case00::
Jump_073_7566:: ; address name
    ld a, $10
    ld [wC928], a
    farcall Func_05F_6ABF
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $01
    ld [wC8EF], a
    ld hl, hFF8C
    call SetBit2AtHL_B73
    ld hl, wCBAC
    call SetBit2AtHL_B73
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 17; reached through ScriptCommand17 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand17)
; reads: wScriptStep, hPlayerX, hPlayerY
; writes: wCBD3, wCBD4, wCBCF, wScriptStartRequest
; points at: wScriptStep, wCBD3, wCBD4
ScriptCommand17_Run::
Func_073_758C:: ; address name
    ld a, [wScriptStep]
    or a, a
    jr nz, Jump_073_75A6
    ldh a, [hPlayerX]
    ld [wCBD3], a
    ldh a, [hPlayerY]
    ld [wCBD4], a
    ld a, $80
    ld [wCBCF], a
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_073_75A6::
    ldh a, [hPlayerX]
    cp a, $30
    jr nz, Jump_073_75B2
    ld hl, wCBD3
    inc [hl]
    jr Jump_073_75CC

Jump_073_75B2::
    cp a, $50
    jr nz, Jump_073_75BC
    ld hl, wCBD3
    dec [hl]
    jr Jump_073_75CC

Jump_073_75BC::
    ldh a, [hPlayerY]
    cp a, $20
    jr nz, Jump_073_75C8
    ld hl, wCBD4
    inc [hl]
    jr Jump_073_75CC

Jump_073_75C8::
    ld hl, wCBD4
    dec [hl]

Jump_073_75CC::
    ld de, wCBD4
    call Func_073_7A5D
    ret nc
    xor a, a
    ld [wCBCF], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 14; reached through ScriptCommand14 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand14)
; reads: wScriptStep
ScriptCommand14_Run::
Func_073_75DD:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand14_Run_Case00
    dw ScriptCommand14_Run_Case01
    dw ScriptCommand14_Run_Case02
    dw ScriptCommand14_Run_Case03

; entry 3 of the `rst $00` table in ScriptCommand14_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStartRequest
ScriptCommand14_Run_Case03::
Jump_073_75E9:: ; address name
    ld b, $3C
    call StepWC921Counter_Bank73
    ret nc
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in ScriptCommand14_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX, wC8F0, wScriptParam0
; writes: hPlayerX, wC8F0, wCBCF, wC928, wC929, wScriptParam0, wCBD4
; points at: wCBD4, wScriptStep
ScriptCommand14_Run_Case02::
Jump_073_75F5:: ; address name
    ldh a, [hPlayerX]
    cp a, $00
    jr z, Jump_073_760B
    dec a
    dec a
    ldh [hPlayerX], a
    ld a, [wC8F0]
    cp a, $00
    jr z, Jump_073_760B
    dec a
    dec a
    ld [wC8F0], a

Jump_073_760B::
    ld a, $80
    ld [wCBCF], a
    ld de, wCBD4
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    ld a, $50
    ld [wCBD4], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand14_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCBAA
; writes: wCBAA
; points at: wScriptStep
ScriptCommand14_Run_Case01::
Jump_073_7639:: ; address name
    ld a, [wCBAA]
    dec a
    dec a
    ld [wCBAA], a
    cp a, $30
    ret nz
    ld a, $63
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand14_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCBAA
; writes: wCBAA
; points at: wScriptStep
ScriptCommand14_Run_Case00::
Jump_073_764E:: ; address name
    ld a, [wCBAA]
    inc a
    ld [wCBAA], a
    cp a, $40
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 13; reached through ScriptCommand13 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand13)
; reads: wScriptStep
ScriptCommand13_Run::
Func_073_765D:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand13_Run_Case00
    dw ScriptCommand13_Run_Case01
    dw ScriptCommand13_Run_Case02
    dw ScriptCommand13_Run_Case03
    dw ScriptCommand13_Run_Case02
    dw ScriptCommand13_Run_Case05
    dw ScriptCommand13_Run_Case02
    dw ScriptCommand13_Run_Case07
    dw ScriptCommand13_Run_Case02
    dw ScriptCommand13_Run_Case05
    dw ScriptCommand13_Run_Case02
    dw ScriptCommand13_Run_Case07
    dw ScriptCommand13_Run_Case02
    dw ScriptCommand13_Run_Case0D
    dw ScriptCommandCB_Run_Case01
    dw ScriptCommand13_Run_Case0F
    dw ScriptCommand13_Run_Case10

; entry 16 of the `rst $00` table in ScriptCommand13_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC92C
; writes: wC929, wC92A, wC928, wScriptStartRequest
ScriptCommand13_Run_Case10::
Jump_073_7683:: ; address name
    ld a, $01
    ld [wC929], a
    ld a, $82
    ld [wC92A], a
    ld a, $E0
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, $02
    ld [wC929], a
    ld a, $82
    ld [wC92A], a
    ld a, $E0
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 15 of the `rst $00` table in ScriptCommand13_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCBAA
; writes: wC92A, wC928, wC929, wCBCF
; points at: wCBD4, wScriptStep
ScriptCommand13_Run_Case0F::
Jump_073_76B8:: ; address name
    ld a, [wCBAA]
    cp a, $40
    jr z, Jump_073_76CB
    ld a, $83
    ld [wC92A], a
    ld a, $40
    ld [wC928], a
    jr Jump_073_76D5

Jump_073_76CB::
    ld a, $82
    ld [wC92A], a
    ld a, $E0
    ld [wC928], a

Jump_073_76D5::
    ld a, $02
    ld [wC929], a
    farcall Func_05F_6B54
    ld a, $01
    ld [wC929], a
    ld a, $82
    ld [wC92A], a
    ld a, $40
    ld [wC928], a
    farcall Func_05F_6B54
    ld hl, wCBD4
    inc [hl]
    ld de, wCBD4
    call Func_073_7A5D
    ret nc
    xor a, a
    ld [wCBCF], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 13 of the `rst $00` table in ScriptCommand13_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wCB8B
ScriptCommand13_Run_Case0D::
Jump_073_7709:: ; address name
    ld de, wCB8B
    ld hl, $0039
    call Func_073_7A7F
    ret

; entry 7 of the `rst $00` table in ScriptCommand13_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wC928, wC929, wScriptParam0
; points at: wCBD3, wCBD4, wScriptStep
ScriptCommand13_Run_Case07::
Jump_073_7713:: ; address name
    ld hl, wCBD3
    inc [hl]
    jr Jump_073_771D

; entry 5 of the `rst $00` table in ScriptCommand13_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wC928, wC929, wScriptParam0
; points at: wCBD3, wCBD4, wScriptStep
ScriptCommand13_Run_Case05::
Jump_073_7719:: ; address name
    ld hl, wCBD3
    dec [hl]

Jump_073_771D::
    ld de, wCBD4
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in ScriptCommand13_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wCBA6
; points at: wCBD3, wCBD4, wScriptStep
ScriptCommand13_Run_Case03::
Jump_073_7741:: ; address name
    ld hl, wCBD3
    dec [hl]
    ld hl, wCBD4
    dec [hl]
    ld de, wCBD4
    call Func_073_7A5D
    ret nc
    ld a, $03
    ld [wCBA6], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in ScriptCommand13_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand13_Run_Case02::
Jump_073_775A:: ; address name
    ld b, $1E
    call StepWC921Counter_Bank73
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand13_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCB9A, wC92C
; writes: wC929, wC92A, wC928, wCBA6
; points at: wScriptStep
ScriptCommand13_Run_Case01::
Jump_073_7765:: ; address name
    ld a, [wCB9A]
    cp a, $30
    jr z, Jump_073_7781
    ld a, $01
    ld [wC929], a
    ld a, $01
    ld [wC92A], a
    ld a, $30
    ld [wC928], a
    farcall Func_05F_6B54

Jump_073_7781::
    ld a, $02
    ld [wC929], a
    ld a, $00
    ld [wC92A], a
    ld a, $40
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $01
    ld [wCBA6], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand13_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wCBAA, wCB9A, wScriptParam0
; points at: wScriptParam0, wScriptStep
ScriptCommand13_Run_Case00::
Jump_073_77A5:: ; address name
    ld hl, wScriptParam0
    inc [hl]
    ld a, [wScriptParam0]
    cp a, $3C
    jr nz, Jump_073_77B6
    ld a, $50
    ld [wCBAA], a
    ret

Jump_073_77B6::
    cp a, $78
    jr nz, Jump_073_77C0
    ld a, $20
    ld [wCB9A], a
    ret

Jump_073_77C0::
    cp a, $B4
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 12; reached through ScriptCommand12 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand12)
; reads: wScriptStep
ScriptCommand12_Run::
Func_073_77CC:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand12_Run_Case00
    dw ScriptCommand12_Run_Case01
    dw ScriptCommand12_Run_Case02
    dw ScriptCommand12_Run_Case03
    dw ScriptCommand12_Run_Case04
    dw ScriptCommand12_Run_Case05

; entry 5 of the `rst $00` table in ScriptCommand12_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1
; writes: wScriptStartRequest
ScriptCommand12_Run_Case05::
Jump_073_77DC:: ; address name
    call Func_073_79CE
    ld a, [wScriptParam1]
    or a, a
    ret nz
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 4 of the `rst $00` table in ScriptCommand12_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCB9B, wC924, wC92C, wCBAB
; writes: wC92A, wC928, wC929, wC924, wScriptParam0
; points at: wScriptStep
ScriptCommand12_Run_Case04::
Jump_073_77EA:: ; address name
    call Func_073_79CE
    ld a, [wCB9B]
    cp a, $30
    jr z, Jump_073_7800
    ld a, $82
    ld [wC92A], a
    ld a, $30
    ld [wC928], a
    jr Jump_073_780A

Jump_073_7800::
    ld a, $83
    ld [wC92A], a
    ld a, $E0
    ld [wC928], a

Jump_073_780A::
    ld a, $01
    ld [wC929], a
    farcall Func_05F_6B54
    ld a, [wC924]
    or a, a
    jr nz, Jump_073_783B
    ld a, $02
    ld [wC929], a
    ld a, $83
    ld [wC92A], a
    ld a, $20
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $01
    ld [wC924], a
    ret

Jump_073_783B::
    ld a, [wCBAB]
    cp a, $30
    jr z, Jump_073_7858
    ld a, $02
    ld [wC929], a
    ld a, $82
    ld [wC92A], a
    ld a, $30
    ld [wC928], a
    farcall Func_05F_6B54
    ret

Jump_073_7858::
    ld a, $02
    ld [wC929], a
    ld a, $83
    ld [wC92A], a
    ld a, $E0
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in ScriptCommand12_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC92C
; writes: wC929, wC92A, wC928
; points at: wScriptStep
ScriptCommand12_Run_Case03::
Jump_073_787B:: ; address name
    call Func_073_79CE
    ld a, $02
    ld [wC929], a
    ld a, $83
    ld [wC92A], a
    ld a, $20
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, $01
    ld [wC929], a
    ld a, $83
    ld [wC92A], a
    ld a, $20
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in ScriptCommand12_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam1, wC924
; points at: wScriptStep
ScriptCommand12_Run_Case02::
Jump_073_78B2:: ; address name
    call Func_073_78F5
    call Func_073_79B8
    ld b, $A0
    call StepWC921Counter_Bank73
    ret nc
    ld a, $40
    ld [wScriptParam1], a
    xor a, a
    ld [wC924], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand12_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wC924, wC925
; points at: wScriptStep
ScriptCommand12_Run_Case01::
Jump_073_78CC:: ; address name
    call Func_073_78F5
    call Func_073_79B8
    ld b, $80
    call StepWC921Counter_Bank73
    ret nc
    ld a, $81
    ld [wC924], a
    ld a, $80
    ld [wC925], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand12_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wC924, wC925
; points at: wScriptStep
ScriptCommand12_Run_Case00::
Jump_073_78E7:: ; address name
    ld a, $01
    ld [wC924], a
    xor a, a
    ld [wC925], a
    ld hl, wScriptStep
    inc [hl]
    ret

; 2 call sites from 2 routines (e.g. ScriptCommand12_Run_Case02, ScriptCommand12_Run_Case01)
; reads: wC924, wC92C, wC925
; writes: wC92A, wC928, wC929, wC924, wC925
Func_073_78F5::
    ld b, $00
    ld a, [wC924]
    bit 7, a
    jr z, Jump_073_7900
    ld b, $80

Jump_073_7900::
    and a, $03
    jr nz, Jump_073_7911
    ld a, b
    or a, $01
    ld [wC92A], a
    ld a, $50
    ld [wC928], a
    jr Jump_073_793C

Jump_073_7911::
    dec a
    jr nz, Jump_073_7921
    ld a, b
    or a, $00
    ld [wC92A], a
    ld a, $50
    ld [wC928], a
    jr Jump_073_793C

Jump_073_7921::
    dec a
    jr nz, Jump_073_7931
    ld a, b
    or a, $03
    ld [wC92A], a
    ld a, $30
    ld [wC928], a
    jr Jump_073_793C

Jump_073_7931::
    ld a, b
    or a, $02
    ld [wC92A], a
    ld a, $30
    ld [wC928], a

Jump_073_793C::
    ld a, $01
    ld [wC929], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    jr z, Jump_073_7956
    ld a, [wC924]
    inc a
    and a, $83
    ld [wC924], a

Jump_073_7956::
    ld b, $00
    ld a, [wC925]
    bit 7, a
    jr z, Jump_073_7961
    ld b, $80

Jump_073_7961::
    and a, $03
    jr nz, Jump_073_7972
    ld a, b
    or a, $01
    ld [wC92A], a
    ld a, $50
    ld [wC928], a
    jr Jump_073_799D

Jump_073_7972::
    dec a
    jr nz, Jump_073_7982
    ld a, b
    or a, $00
    ld [wC92A], a
    ld a, $50
    ld [wC928], a
    jr Jump_073_799D

Jump_073_7982::
    dec a
    jr nz, Jump_073_7992
    ld a, b
    or a, $03
    ld [wC92A], a
    ld a, $30
    ld [wC928], a
    jr Jump_073_799D

Jump_073_7992::
    ld a, b
    or a, $02
    ld [wC92A], a
    ld a, $30
    ld [wC928], a

Jump_073_799D::
    ld a, $02
    ld [wC929], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    jr z, Jump_073_79B7
    ld a, [wC925]
    inc a
    and a, $83
    ld [wC925], a

Jump_073_79B7::
    ret

; 2 call sites from 2 routines (e.g. ScriptCommand12_Run_Case02, ScriptCommand12_Run_Case01)
; reads: wC925
; writes: wCB86
Func_073_79B8::
    ld a, [wC925]
    and a, $03
    ld hl, $79CA
    add_a_to_hl
    ld a, [hl]
    ld [wCB86], a
    ret
    db $01, $00, $03, $02

; 3 call sites from 3 routines (e.g. ScriptCommand12_Run_Case05, ScriptCommand12_Run_Case04, ScriptCommand12_Run_Case03)
; reads: wFrameCounterLo, wScriptParam1, wScriptParam0
; writes: wScriptParam0, wCB86
; points at: wScriptParam1
Func_073_79CE::
    ld a, [wFrameCounterLo]
    and a, $08
    jr nz, Jump_073_79D9
    ld hl, wScriptParam1
    dec [hl]

Jump_073_79D9::
    ld a, [wScriptParam1]
    swap a
    and a, $0F
    ld c, a
    ld a, [wScriptParam0]
    add a, c
    ld [wScriptParam0], a
    swap a
    and a, $03
    ld c, a
    ld a, $03
    sub a, c
    ld [wCB86], a
    ret

; implements script command type 11; reached through ScriptCommand11 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand11)
; reads: wScriptStep
ScriptCommand11_Run::
Func_073_79F4:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand11_Run_Case00
    dw ScriptCommand11_Run_Case01

; entry 1 of the `rst $00` table in ScriptCommand11_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wCBCF, wScriptStartRequest
; points at: wCBD4
ScriptCommand11_Run_Case01::
Jump_073_79FC:: ; address name
    ld hl, wCBD4
    inc [hl]
    ld de, wCBD4
    call Func_073_7A5D
    ret nc
    xor a, a
    ld [wCBCF], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 0 of the `rst $00` table in ScriptCommand11_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wCBD3, wCBD4, wCBCF
; points at: wScriptStep
ScriptCommand11_Run_Case00::
Jump_073_7A11:: ; address name
    ld a, $40
    ld [wCBD3], a
    ld a, $30
    ld [wCBD4], a
    ld a, $80
    ld [wCBCF], a
    ld b, $3C
    call StepWC921Counter_Bank73
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; wC921 += 1; if it now equals B it is reset to 0 and carry is set, else carry is clear; returns A = 0 either way (the same 18 bytes appear in 3 banks)
; 19 call sites from 19 routines (e.g. ScriptCommandCC_Run_Case01, ScriptCommand60_Run_Case03, ScriptCommand51_Run_Case00, ScriptCommand50_Run_Case00, ...)
; reads: wScriptParam0
; writes: wScriptParam0
StepWC921Counter_Bank73::
Func_073_7A2B:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, b
    jr z, Jump_073_7A37
    sub a, a
    ret

Jump_073_7A37::
    xor a, a
    ld [wScriptParam0], a
    scf
    ret

; [HL] |= $02; clobbers A (the same 5 bytes appear in 4 banks)
; 2 call sites from 2 routines (e.g. ScriptCommand47_Run_Case00, ScriptCommand2C_Run_Case05)
SetBit1AtHL_Bank73::
Func_073_7A3D:: ; address name
    ld a, [hl]
    or a, $02
    ld [hl], a
    ret

; [HL] &= $FD; clobbers A (the same 5 bytes appear in 4 banks)
; no direct call (reached through a table, a jump or a vector)
ClearBit1AtHL_Bank73:: ; heuristic: follows a terminator; C0
Func_073_7A42:: ; address name
    ld a, [hl]
    and a, $FD
    ld [hl], a
    ret

; sets bit 2 of the byte at [HL]; only A is clobbered
; 17 call sites from 13 routines (e.g. ScriptCommandC8_Run, ScriptCommandCB_Run_Case08, ScriptCommandC1_Run_Case02, ScriptCommandC0_Run_Case00, ...)
SetBit2AtHL_B73::
Func_073_7A47:: ; address name
    ld a, [hl]
    or a, $04
    ld [hl], a
    ret

; [HL] &= $FB; clobbers A (the same 5 bytes appear in 4 banks)
; 11 call sites from 9 routines (e.g. ScriptCommandCB_Run_Case09, ScriptCommandC9_Run_Case01, ScriptCommandC1_Run_Case02, ScriptCommandC0_Run_Case03, ...)
ClearBit2AtHL_Bank73::
Func_073_7A4C:: ; address name
    ld a, [hl]
    and a, $FB
    ld [hl], a
    ret

; 4 call sites from 4 routines (e.g. ScriptCommand16_Run_Case16, ScriptCommand16_Run_Case15, ScriptCommand16_Run_Case13, ScriptCommand16_Run_Case12)
; reads: wScriptParam0
Func_073_7A51::
    ld a, [wScriptParam0]
    and a, $1F
    ret nz
    ld a, [de]
    inc a
    and a, $03
    ld [de], a
    ret

; 13 call sites from 13 routines (e.g. ScriptCommand17_Run, ScriptCommand19_Run, ScriptCommand1A_Run, ScriptCommand60_Run_Case04, ...)
; reads: wScriptParam0
; writes: wC928, wC929, wScriptParam0
Func_073_7A5D::
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    inc a
    inc a
    ld [wScriptParam0], a
    cp a, $20
    jr z, Jump_073_7A79
    sub a, a
    ret

Jump_073_7A79::
    xor a, a
    ld [wScriptParam0], a
    scf
    ret

; 3 call sites from 3 routines (e.g. ScriptCommand16_Run_Case13, ScriptCommand16_Run_Case11, ScriptCommand13_Run_Case0D)
; reads: wScriptParam0
; writes: wC928, wC929, wScriptParam0
; points at: wScriptStep
Func_073_7A7F::
    push hl
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    pop hl
    cp a, $20
    ret nz
    call StoreHLInWC924_B73b
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; HL is stored in wC924 (low) and wC925 (high); then wC926 = 0
; 25 call sites from 22 routines (e.g. Func_073_52F5, ScriptCommandC5_Run_Case08, ScriptCommandC5_Run_Case05, ScriptCommandC5_Run_Case02, ...)
; writes: wC924, wC925, wC926
StoreHLInWC924_B73b::
Func_073_7AA5:: ; address name
    ld a, l
    ld [wC924], a
    ld a, h
    ld [wC925], a
    xor a, a
    ld [wC926], a
    ret

; 7 call sites from 7 routines (e.g. ScriptCommandC5_Run_Case09, ScriptCommand2D_Run_Case07, ScriptCommand2B_Run_Case09, ScriptCommand2B_Run_Case08, ...)
; reads: wC926
; writes: wC928
Func_073_7AB2::
    ld [wC928], a
    farcall Func_05F_6936
    ld a, [wC926]
    cp a, $FF
    jr z, Jump_073_7AC4
    sub a, a
    ret

Jump_073_7AC4::
    scf
    ret

; entry 1 of the `rst $00` table in ScriptCommandCB_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommandCB_Run_Case01::
Jump_073_7AC6:: ; address name
    xor a, a
    call Func_073_7AB2
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in ScriptCommandC5_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStartRequest
ScriptCommandC5_Run_Case09::
Jump_073_7AD0:: ; address name
    xor a, a
    call Func_073_7AB2
    ret nc
    ld a, $80
    ld [wScriptStartRequest], a
    ret
    ds $525, $00
