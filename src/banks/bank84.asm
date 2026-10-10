SECTION "Bank 84", ROMX[$4000], BANK[$84]
    db $84

; only called from DebugAutomap_Update_Sub01_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_Sub01)
; reads: wCD0C, hFFCE, hFFCF
; writes: wCC46, hFFCE, hFFCF, hFFC6
; points at: wCD8B, wCDAC
DebugAutomap_Update_Sub01_Sub01_Sub0C::
Func_084_4001:: ; address name
    xor a, a
    ld [wCC46], a
    ld a, [wCD0C]
    add a, a
    ld hl, Data_084_4CCB
    add_a_to_hl
    ld a, [hl+]
    ldh [hFFCE], a
    ld a, [hl]
    ldh [hFFCF], a
    ldh a, [hFFCE]
    add a, $01
    ldh [hFFCE], a
    ldh a, [hFFCF]
    adc a, $00
    ldh [hFFCF], a
    ld hl, wCD8B
    ld de, wCDAC

Jump_084_4029::
    ld a, [hl]
    cp a, $FF
    ret z
    push hl
    push de
    dec hl
    dec hl
    ld a, [hl]
    ldh [hFFC6], a
    call RunDebugAutomapCaseHFFC6
    ldh a, [hFFCE]
    ld l, a
    ldh a, [hFFCF]
    ld h, a
    ld a, $10
    add_a_to_hl
    ld a, l
    ldh [hFFCE], a
    ld a, h
    ldh [hFFCF], a
    pop de
    pop hl
    ld a, $04
    add_a_to_hl
    ld a, $10
    add a, e
    ld e, a
    jr nc, Jump_084_405A
    inc d

Jump_084_405A::
    jr Jump_084_4029

; debug automap: runs the routine for hFFC6 (jump table of seven) (E-0122)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_Sub01_Sub0C)
; reads: hFFC6
RunDebugAutomapCaseHFFC6::
Func_084_405C:: ; address name
    ldh a, [hFFC6]
    rst $00
    dw RunDebugAutomapCaseHFFC6_Case00
    dw RunDebugAutomapCaseHFFC6_Case01
    dw RunDebugAutomapCaseHFFC6_Case02
    dw RunDebugAutomapCaseHFFC6_Case03
    dw RunDebugAutomapCaseHFFC6_Case04
    dw RunDebugAutomapCaseHFFC6_Case05
    dw RunDebugAutomapCaseHFFC6_Case06

; entry 0 of the `rst $00` table in RunDebugAutomapCaseHFFC6
; no direct call (reached through a table, a jump or a vector)
RunDebugAutomapCaseHFFC6_Case00::
Jump_084_406D:: ; address name
    ret

; entry 6 of the `rst $00` table in RunDebugAutomapCaseHFFC6
; no direct call (reached through a table, a jump or a vector)
RunDebugAutomapCaseHFFC6_Case06::
Jump_084_406E:: ; address name
    ld a, $54
    ld [de], a
    ret

; entry 1 of the `rst $00` table in RunDebugAutomapCaseHFFC6
; no direct call (reached through a table, a jump or a vector)
; reads: wCD0B, hFFCE, hFFCF
RunDebugAutomapCaseHFFC6_Case01::
Jump_084_4072:: ; address name
    ld hl, Data_084_41AE
    ld a, [wCD0B]
    add_a_to_hl
    ld a, [hl]
    ld [de], a
    inc de
    inc de
    ldh a, [hFFCE]
    ld l, a
    ldh a, [hFFCF]
    ld h, a
    inc hl
    ld b, $0E

Jump_084_408A::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_084_408A
    ret

; entry 2 of the `rst $00` table in RunDebugAutomapCaseHFFC6
; no direct call (reached through a table, a jump or a vector)
; reads: wCD0B, wCD04, hFFCE, hFFCF
RunDebugAutomapCaseHFFC6_Case02::
Jump_084_4091:: ; address name
    ld hl, Data_084_41B8
    ld a, [wCD0B]
    add_a_to_hl
    ld a, [hl]
    add a, $20
    ld [de], a
    call NextRandomSeed
    ld a, [wCD04]
    srl a
    and a, $01
    jr z, Jump_084_40B0
    ld a, [de]
    or a, $80
    ld [de], a

Jump_084_40B0::
    inc de
    inc de
    ldh a, [hFFCE]
    ld l, a
    ldh a, [hFFCF]
    ld h, a
    inc hl
    ld b, $0E

Jump_084_40BB::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_084_40BB
    ret

; entry 3 of the `rst $00` table in RunDebugAutomapCaseHFFC6
; no direct call (reached through a table, a jump or a vector)
; reads: wCD0B, wCD04, hFFCE, hFFCF
RunDebugAutomapCaseHFFC6_Case03::
Jump_084_40C2:: ; address name
    ld hl, Data_084_41B8
    ld a, [wCD0B]
    add_a_to_hl
    ld a, [hl]
    add a, $40
    ld [de], a
    call NextRandomSeed
    ld a, [wCD04]
    srl a
    and a, $01
    jr z, Jump_084_40E1
    ld a, [de]
    or a, $80
    ld [de], a

Jump_084_40E1::
    inc de
    inc de
    ldh a, [hFFCE]
    ld l, a
    ldh a, [hFFCF]
    ld h, a
    inc hl
    ld b, $0E

Jump_084_40EC::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_084_40EC
    ret

; entry 4 of the `rst $00` table in RunDebugAutomapCaseHFFC6
; no direct call (reached through a table, a jump or a vector)
; reads: hFFCE, hFFCF, wCC46, wCD0B, wCD04
; writes: hFFC6
RunDebugAutomapCaseHFFC6_Case04::
Jump_084_40F3:: ; address name
    ldh a, [hFFCE]
    ld l, a
    ldh a, [hFFCF]
    ld h, a
    inc hl
    ld a, [hl+]
    ld [de], a
    ldh [hFFC6], a
    push hl
    inc de
    ld a, [wCC46]
    ld [de], a
    inc de
    ld a, [wCD0B]
    add a, a
    add a, a
    ld hl, Data_084_41CA
    add_a_to_hl
    call NextRandomSeed
    ld a, [wCD04]
    and a, $03
    add_a_to_hl
    ld a, [hl]
    ld [de], a
    pop hl
    inc de
    push de
    ld b, $0D

Jump_084_4126::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_084_4126
    pop de
    inc de
    ld a, [de]
    cp a, $FF
    jr z, Jump_084_4150
    call NextRandomSeed
    ld a, [wCD04]
    and a, $07
    inc de
    inc de
    ld [de], a
    inc de
    inc de
    ld a, [de]
    cp a, $FF
    jr z, Jump_084_4150
    call NextRandomSeed
    ld a, [wCD04]
    and a, $07
    inc de
    inc de
    ld [de], a

Jump_084_4150::
    ld a, $01
    call RunDebugAutomapCaseHFFC6_Shared01
    ret

; entry 5 of the `rst $00` table in RunDebugAutomapCaseHFFC6
; no direct call (reached through a table, a jump or a vector)
; reads: hFFCE, hFFCF, wCC46, wCD04
; writes: hFFC6
RunDebugAutomapCaseHFFC6_Case05::
Jump_084_4156:: ; address name
    ldh a, [hFFCE]
    ld l, a
    ldh a, [hFFCF]
    ld h, a
    inc hl
    ld a, [hl+]
    ld [de], a
    ldh [hFFC6], a
    push hl
    inc de
    ld a, [wCC46]
    ld [de], a
    inc de
    call NextRandomSeed
    ld a, [wCD04]
    and a, $07
    ld hl, Data_084_41C2
    add_a_to_hl
    ld a, [hl]
    ld [de], a
    pop hl
    inc de
    push de
    ld b, $0D

Jump_084_417F::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_084_417F
    pop de
    inc de
    ld a, [de]
    cp a, $FF
    jr z, Jump_084_41A9
    call NextRandomSeed
    ld a, [wCD04]
    and a, $07
    inc de
    inc de
    ld [de], a
    inc de
    inc de
    ld a, [de]
    cp a, $FF
    jr z, Jump_084_41A9
    call NextRandomSeed
    ld a, [wCD04]
    and a, $07
    inc de
    inc de
    ld [de], a

Jump_084_41A9::
    xor a, a
    call RunDebugAutomapCaseHFFC6_Shared01
    ret

Data_084_41AE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $03, $01, $00, $00, $04, $05, $02, $00

Data_084_41B8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $06, $03, $01, $07, $08, $04, $05, $02, $09

Data_084_41C2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $05, $06, $07, $08, $09, $05, $07, $09

Data_084_41CA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $0B, $00, $0B, $00, $02, $00, $02, $02, $03, $0B, $02, $02, $04, $02, $04
    db $01, $01, $01, $01, $01, $03, $01, $03, $00, $04, $00, $04, $01, $04, $01, $04
    db $01, $03, $0B, $01, $00, $0B, $00, $0B

; only called from routines of RunDebugAutomapCaseHFFC6 (E-0098)
; 2 call sites from 2 routines (e.g. RunDebugAutomapCaseHFFC6_Case05, RunDebugAutomapCaseHFFC6_Case04)
; reads: wCC46, hFFC8, hFFCA, hFFC6, hFFC9
; writes: hFFC8, hFFC9, wCC46
; points at: wCE2C
RunDebugAutomapCaseHFFC6_Shared01::
Func_084_41F2:: ; address name
    push af
    ld a, [wCC46]
    add a, a
    ld hl, wCE2C
    add_a_to_hl
    pop af
    or a, a
    jr nz, Jump_084_4241
    ld a, $A0
    ldh [hFFC8], a
    call NextRandomSeed
    and a, $03
    add a, a
    add a, a
    add a, a
    ld c, a
    ldh a, [hFFC8]
    add a, c
    ldh [hFFC8], a
    ld c, $05
    call RandomBelowC
    ld c, a
    ldh a, [hFFC8]
    add a, c
    ldh [hFFC8], a
    ld [hl+], a
    ldh a, [hFFC8]
    ld e, a
    ld d, $00
    sla e
    rl d
    call RunDebugAutomapCaseHFFC6_Shared01_Sub02
    ldh a, [hFFCA]
    swap a
    or a, $0F
    ld [hl+], a
    ld a, $0F
    ldh [hFFC9], a
    ld a, [wCC46]
    inc a
    ld [wCC46], a
    jr Jump_084_427D

Jump_084_4241::
    xor a, a
    ldh [hFFC8], a
    ld c, $09
    call RandomBelowC
    sla a
    sla a
    sla a
    ld c, a
    ldh a, [hFFC8]
    add a, c
    ldh [hFFC8], a
    ld c, $08
    call RandomBelowC
    ld c, a
    ldh a, [hFFC8]
    add a, c
    ldh [hFFC8], a
    ld [hl+], a
    ldh a, [hFFC8]
    ld e, a
    ld d, $00
    sla e
    rl d
    call RunDebugAutomapCaseHFFC6_Shared01_Sub02
    ldh a, [hFFCA]
    swap a
    ld c, a
    ldh a, [hFFC9]
    or a, c
    ld [hl+], a
    ld a, [wCC46]
    inc a
    ld [wCC46], a

Jump_084_427D::
    ldh a, [hFFC6]
    dec a
    dec a
    ld b, a

Jump_084_4282::
    push bc
    ldh a, [hFFCA]
    and a, $0F
    swap a
    ld de, Data_084_42C7
    add a, e
    ld e, a
    jr nc, Jump_084_4291
    inc d

Jump_084_4291::
    ld c, $0A
    call RandomBelowC
    add a, e
    ld e, a
    jr nc, Jump_084_429B
    inc d

Jump_084_429B::
    ld a, [de]
    ld b, a
    ld c, $08
    call RandomBelowC
    add a, b
    ld [hl+], a
    ld e, a
    ld d, $00
    sla e
    rl d
    ldh a, [hFFCA]
    ldh [hFFC9], a
    call RunDebugAutomapCaseHFFC6_Shared01_Sub01
    ldh a, [hFFC9]
    ld c, a
    ldh a, [hFFCA]
    swap a
    or a, c
    ld [hl+], a
    ld a, [wCC46]
    inc a
    ld [wCC46], a
    pop bc
    dec b
    jr nz, Jump_084_4282
    ret

Data_084_42C7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $2102C7, $60

; only called from RunDebugAutomapCaseHFFC6_Shared01 (E-0047)
; 1 call site from 1 routine (e.g. RunDebugAutomapCaseHFFC6_Shared01)
; reads: hFFC9
; writes: hFFCA
RunDebugAutomapCaseHFFC6_Shared01_Sub01::
Func_084_4327:: ; address name
    push hl
    ld a, e
    add a, $01
    ld e, a
    ld a, d
    adc a, $40
    ld d, a
    ld a, $72
    ld b, a
    call ReadByteInBank
    ld l, c
    inc de
    call ReadByteInBank
    ld h, c

Jump_084_433C::
    call NextRandomSeed
    and a, $03
    jr z, Jump_084_433C
    push hl
    dec a
    add_a_to_hl
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    call ReadByteInBank
    pop hl
    ldh a, [hFFC9]
    cp a, c
    jr z, Jump_084_433C
    ld a, c
    ldh [hFFCA], a
    pop hl
    ret

; only called from RunDebugAutomapCaseHFFC6_Shared01 (E-0047)
; 2 call sites from 1 routine (e.g. RunDebugAutomapCaseHFFC6_Shared01)
; reads: hFFC9
; writes: hFFC9, hFFCA
RunDebugAutomapCaseHFFC6_Shared01_Sub02::
Func_084_435C:: ; address name
    push hl
    ld a, e
    add a, $01
    ld e, a
    ld a, d
    adc a, $40
    ld d, a
    ld a, $72
    ld b, a
    call ReadByteInBank
    ld a, c
    ld l, a
    inc de
    call ReadByteInBank
    ld a, c
    ld h, a
    push hl

Jump_084_4374::
    call NextRandomSeed
    and a, $03
    jr z, Jump_084_4374
    dec a
    add_a_to_hl
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    call ReadByteInBank
    ld a, c
    ldh [hFFC9], a
    pop hl

Jump_084_438C::
    call NextRandomSeed
    and a, $03
    jr z, Jump_084_438C
    push hl
    dec a
    add_a_to_hl
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    call ReadByteInBank
    pop hl
    ldh a, [hFFC9]
    cp a, c
    jr z, Jump_084_438C
    ld a, c
    ldh [hFFCA], a
    pop hl
    ret

; repeats NextRandomSeed until wCD04 & $0F is below C (C must be 1-16); returns A = that value (E-0077)
; 5 call sites from 1 routine (e.g. RunDebugAutomapCaseHFFC6_Shared01)
; reads: wCD04
RandomBelowC::
Func_084_43AC:: ; address name
    call NextRandomSeed
    ld a, [wCD04]
    and a, $0F
    cp a, c
    jr nc, RandomBelowC
    ret

; 3 call sites from 3 routines (e.g. LoadMapScreen, ScriptCommand0A_Run_Case04, ScriptCommand74_Run)
; reads: hMapId, hMapScreenX, hMapScreenY
; writes: hFFC6
Func_084_43B8::
    ld hl, Data_084_4461

Jump_084_43BB::
    push hl
    ld a, [hl+]
    cp a, $FF
    jr nz, Jump_084_43C3
    pop hl
    ret

Jump_084_43C3::
    ld c, a
    ldh a, [hMapId]
    cp a, c
    jr nz, Jump_084_43E8
    ld a, [hl+]
    ld c, a
    ldh a, [hMapScreenX]
    cp a, c
    jr nz, Jump_084_43E8
    ld a, [hl+]
    ld c, a
    ldh a, [hMapScreenY]
    cp a, c
    jr nz, Jump_084_43E8
    ld a, [hl+]
    ldh [hFFC6], a
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    call TestFlagBit
    jr nc, Jump_084_43E8
    pop hl
    push hl
    call Func_084_43F2

Jump_084_43E8::
    pop hl
    ld a, $08
    add_a_to_hl
    jr Jump_084_43BB

; 1 call site from 1 routine (e.g. Func_084_43B8)
; reads: hFFC6, wIsCGB
; writes: rSVBK
Func_084_43F2::
    ldh a, [hFFC6]
    cp a, $FF
    jr z, Jump_084_4412
    ld a, $06
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld a, e
    add a, $98
    ld e, a
    ld a, d
    adc a, $C1
    ld d, a
    ldh a, [hFFC6]
    ld [de], a
    inc a
    inc de
    ld [de], a
    ret

Jump_084_4412::
    ld a, $06
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    push de
    ld a, e
    add a, $98
    ld e, a
    ld a, d
    adc a, $C1
    ld d, a
    ld a, $40
    ld [de], a
    inc a
    inc de
    ld [de], a
    ld a, $13
    add a, e
    ld e, a
    jr nc, Jump_084_4433
    inc d

Jump_084_4433::
    ld a, $50
    ld [de], a
    inc a
    inc de
    ld [de], a
    pop de
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, $02
    ldh [rSVBK], a
    ld a, e
    add a, $00
    ld e, a
    ld a, d
    adc a, $D0
    ld d, a
    ld a, $05
    ld [de], a
    inc de
    ld [de], a
    ld a, $13
    add a, e
    ld e, a
    jr nc, Jump_084_4457
    inc d

Jump_084_4457::
    ld a, $05
    ld [de], a
    inc de
    ld [de], a
    ld a, $00
    ldh [rSVBK], a
    ret

Data_084_4461:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $210461, $361

; only called from ItemUsable_LogTwig (E-0047)
; 1 call site from 1 routine (e.g. ItemUsable_LogTwig)
; reads: hFF8C, wCC44, hMapId, hMapScreenX, hMapScreenY, hPlayerX, hPlayerY, wC88E, ...
; writes: hFFD0, wC83B, wC83C, wC83D, wC83E, wC88E, wC88F, wC890, ...
; points at: wCD7B, wCD8B
ItemUsable_LogTwig_Sub01::
Func_084_47C2:: ; address name
    xor a, a
    ldh [hFFD0], a
    ldh a, [hFF8C]
    bit 3, a
    ret nz
    ld a, [wCC44]
    bit 7, a
    jp nz, Jump_084_48A9
    ldh a, [hMapId]
    cp a, $20
    ret c
    push af
    call ItemUsable_LogTwig_Sub01_Sub01
    or a, a
    jr z, Jump_084_47E0
    pop af
    ret

Jump_084_47E0::
    pop af
    ld e, a
    ld hl, Data_084_49A1
    ldh a, [hMapScreenX]
    swap a
    ld c, a
    ldh a, [hMapScreenY]
    or a, c
    ld c, a
    ldh a, [hPlayerX]
    and a, $F0
    ld b, a
    ldh a, [hPlayerY]
    and a, $F0
    swap a
    or a, b
    ld b, a

Jump_084_47FB::
    push hl
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_084_481D
    cp a, e
    jr nz, Jump_084_4814
    ld a, [hl+]
    cp a, c
    jr nz, Jump_084_4814
    ld a, [hl+]
    cp a, b
    jr z, Jump_084_481B
    ld a, [hl]
    cp a, $FF
    jr z, Jump_084_4814
    cp a, b
    jr z, Jump_084_481B

Jump_084_4814::
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    jr Jump_084_47FB

Jump_084_481B::
    pop hl
    ret

Jump_084_481D::
    pop hl
    ldh a, [hMapId]
    ld d, a
    ld e, $00
    ld hl, Data_084_4887

Jump_084_4826::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_084_4870
    cp a, d
    jr z, Jump_084_4834
    inc e
    inc hl
    inc hl
    inc hl
    jr Jump_084_4826

Jump_084_4834::
    ld a, [wC88E]
    ld [wC83B], a
    or a, a
    jr z, Jump_084_4866
    ld a, [wC88F]
    ld [wC83C], a
    ld a, [wC890]
    ld [wC83D], a
    ld a, [wC891]
    ld [wC83E], a
    ld a, [wC891]
    bit 7, a
    jr nz, Jump_084_4866
    cp a, e
    jr nz, Jump_084_4866
    ld a, [wC88F]
    cp a, b
    jr nz, Jump_084_4870
    ld a, [wC890]
    cp a, c
    jr nz, Jump_084_4870
    ret

Jump_084_4866::
    inc hl
    ld a, [hl]
    cp a, b
    jr nz, Jump_084_4870
    inc hl
    cp a, c
    jr nz, Jump_084_4870
    ret

Jump_084_4870::
    ld a, $01
    ld [wC88E], a
    ld a, b
    ld [wC88F], a
    ld a, c
    ld [wC890], a
    ld a, e
    inc a
    ld [wC891], a
    ld a, $01
    ldh [hFFD0], a
    ret

Data_084_4887:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $20, $44, $00, $30, $44, $76, $48, $44, $B4, $70, $44, $B4, $A0, $44, $10, $A8
    db $44, $00, $B0, $44, $01, $B8, $44, $44, $C8, $44, $01, $D1, $44, $00, $DA, $44
    db $00, $FF

Jump_084_48A9::
    cp a, $80
    ret nz
    call ItemUsable_LogTwig_Sub01_Sub01
    or a, a
    ret nz
    ldh a, [hMapScreenX]
    swap a
    ld c, a
    ldh a, [hMapScreenY]
    or a, c
    ld c, a
    ldh a, [hPlayerX]
    cp a, $40
    jr nz, Jump_084_48E4
    ldh a, [hPlayerY]
    cp a, $40
    jr nz, Jump_084_48E4
    ld hl, wCD7B

Jump_084_48C9::
    push hl
    ld a, [hl]
    cp a, $FF
    jr z, Jump_084_48E3
    dec hl
    dec hl
    dec hl
    ld a, [hl+]
    cp a, c
    jp z, Jump_084_499F
    ld a, [hl]
    cp a, c
    jp z, Jump_084_499F
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    jr Jump_084_48C9

Jump_084_48E3::
    pop hl

Jump_084_48E4::
    ldh a, [hPlayerY]
    cp a, $40
    jr nz, Jump_084_491A
    ld hl, wCD8B

Jump_084_48ED::
    push hl
    ld a, [hl]
    cp a, $FF
    jr z, Jump_084_4919
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    cp a, c
    jr nz, Jump_084_4912
    ldh a, [hPlayerX]
    cp a, $40
    jp z, Jump_084_499F
    inc hl
    ld a, [hl]
    cp a, $04
    jr z, Jump_084_4912
    cp a, $05
    jr z, Jump_084_4912
    ldh a, [hPlayerX]
    cp a, $50
    jp z, Jump_084_499F

Jump_084_4912::
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    jr Jump_084_48ED

Jump_084_4919::
    pop hl

Jump_084_491A::
    ld a, [wC88E]
    ld [wC83B], a
    or a, a
    jr z, Jump_084_495F
    ld a, [wC88F]
    ld [wC83C], a
    ld a, [wC890]
    ld [wC83D], a
    ld a, [wC891]
    ld [wC83E], a
    ld a, [wC891]
    bit 7, a
    jr z, Jump_084_495F
    and a, $7F
    ld b, a
    ld a, [wCC42]
    cp a, b
    jr nz, Jump_084_495F
    ldh a, [hPlayerX]
    and a, $F0
    ld b, a
    ldh a, [hPlayerY]
    and a, $F0
    swap a
    or a, b
    ld b, a
    ld a, [wC88F]
    cp a, b
    jr nz, Jump_084_4978
    ld a, [wC890]
    cp a, c
    jr nz, Jump_084_4978
    ret

Jump_084_495F::
    ld a, [wCD08]
    cp a, c
    jr nz, Jump_084_4978
    ld a, [wCD09]
    ld b, a
    ldh a, [hPlayerX]
    cp a, b
    jr nz, Jump_084_4978
    ld a, [wCD0A]
    ld b, a
    ldh a, [hPlayerY]
    cp a, b
    jr nz, Jump_084_4978
    ret

Jump_084_4978::
    ldh a, [hPlayerX]
    and a, $F0
    ld b, a
    ldh a, [hPlayerY]
    and a, $F0
    swap a
    or a, b
    ld b, a
    ld a, $01
    ld [wC88E], a
    ld a, b
    ld [wC88F], a
    ld a, c
    ld [wC890], a
    ld a, [wCC42]
    or a, $80
    ld [wC891], a
    ld a, $01
    ldh [hFFD0], a
    ret

Jump_084_499F::
    pop hl
    ret

Data_084_49A1:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $2109A1, $C9

; only called from ItemUsable_LogTwig_Sub01 (E-0047)
; 2 call sites from 1 routine (e.g. ItemUsable_LogTwig_Sub01)
; reads: wC8FE, hPlayerX, hPlayerY, wC8FF
ItemUsable_LogTwig_Sub01_Sub01::
Func_084_4A6A:: ; address name
    ld a, [wC8FE]
    cp a, $FF
    jr z, Jump_084_4A87
    ldh a, [hPlayerX]
    and a, $F0
    ld c, a
    ldh a, [hPlayerY]
    swap a
    and a, $0F
    or a, c
    ld c, a
    ld a, [wC8FF]
    cp a, c
    jr nz, Jump_084_4A87
    ld a, $01
    ret

Jump_084_4A87::
    xor a, a
    ret

; only called from RunWC8C7Phase_Case01 (E-0047)
; 1 call site from 1 routine (e.g. RunWC8C7Phase_Case01)
; reads: wCC44, hMapId, hMapScreenX, hMapScreenY, wC83B, wC83E, wC83D, wC83C, ...
; writes: hFFB9, hFFC6, rSVBK
RunWC8C7Phase_Case01_Sub02::
Func_084_4A89:: ; address name
    xor a, a
    ldh [hFFB9], a
    ld a, [wCC44]
    bit 7, a
    jr nz, Jump_084_4AFE
    ldh a, [hMapId]
    ld c, a
    ld hl, Data_084_4ADC
    ld b, $00

Jump_084_4A9B::
    ld a, [hl]
    cp a, c
    jr z, Jump_084_4AA5
    inc b
    inc hl
    inc hl
    inc hl
    jr Jump_084_4A9B

Jump_084_4AA5::
    ld a, b
    ldh [hFFC6], a
    ldh a, [hMapScreenX]
    swap a
    ld c, a
    ldh a, [hMapScreenY]
    or a, c
    ld c, a
    ld a, [wC83B]
    or a, a
    jr z, Jump_084_4ACE
    ld a, [wC83E]
    dec a
    cp a, b
    jr nz, Jump_084_4ACE
    ld a, [wC83D]
    cp a, c
    jp nz, Jump_084_4B46
    ld a, [wC83C]
    ld c, a
    call RunWC8C7Phase_Case01_Sub02_Sub01
    jr Jump_084_4B46

Jump_084_4ACE::
    inc hl
    inc hl
    ld a, [hl]
    cp a, c
    jr nz, Jump_084_4B46
    dec hl
    ld a, [hl]
    ld c, a
    call RunWC8C7Phase_Case01_Sub02_Sub01
    jr Jump_084_4B46

Data_084_4ADC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $20, $44, $00, $30, $44, $76, $48, $44, $B4, $70, $44, $B4, $A0, $44, $10, $A8
    db $44, $00, $B0, $44, $01, $B8, $44, $44, $C8, $44, $01, $D1, $44, $00, $DA, $44
    db $00, $FF

Jump_084_4AFE::
    ldh a, [hMapScreenX]
    swap a
    ld c, a
    ldh a, [hMapScreenY]
    or a, c
    ld c, a
    ld a, [wC83B]
    or a, a
    jr z, Jump_084_4B2C
    ld a, [wC83E]
    bit 7, a
    jr z, Jump_084_4B2C
    and a, $7F
    ld b, a
    ld a, [wCC42]
    cp a, b
    jr nz, Jump_084_4B2C
    ld a, [wC83D]
    cp a, c
    jr nz, Jump_084_4B46
    ld a, [wC83C]
    ld c, a
    call RunWC8C7Phase_Case01_Sub02_Sub01
    jr Jump_084_4B46

Jump_084_4B2C::
    ld a, [wCD08]
    cp a, c
    jr nz, Jump_084_4B46
    ld a, [wCD09]
    and a, $F0
    ld c, a
    ld a, [wCD0A]
    and a, $F0
    swap a
    or a, c
    ld c, a
    call RunWC8C7Phase_Case01_Sub02_Sub01
    jr Jump_084_4B46

Jump_084_4B46::
    ld a, [wC88F]
    and a, $0F
    ld l, a
    ld e, a
    ld h, $00
    ld d, $00
    sla l
    rl h
    sla l
    rl h
    add hl, de
    sla l
    rl h
    sla l
    rl h
    sla l
    rl h
    ld a, [wC88F]
    and a, $F0
    swap a
    add a, a
    add_a_to_hl
    push hl
    ld a, l
    add a, $98
    ld l, a
    ld a, h
    adc a, $C1
    ld h, a
    ld [hl], $46
    inc hl
    ld [hl], $47
    ld a, $13
    add_a_to_hl
    ld [hl], $56
    inc hl
    ld [hl], $57
    pop hl
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_084_4BD6
    ld c, $05
    ld a, [wCC44]
    bit 7, a
    jr nz, Jump_084_4BB9
    ld c, $03
    ldh a, [hFFC6]
    cp a, $04
    jr z, Jump_084_4BB9
    cp a, $0A
    jr z, Jump_084_4BB9
    ld c, $05
    cp a, $05
    jr z, Jump_084_4BB9
    cp a, $06
    jr z, Jump_084_4BB9
    cp a, $07
    jr z, Jump_084_4BB9
    ld c, $01

Jump_084_4BB9::
    ld a, $02
    ldh [rSVBK], a
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $D0
    ld h, a
    ld a, c
    ld [hl+], a
    ld [hl], a
    ld a, $13
    add_a_to_hl
    ld a, c
    ld [hl+], a
    ld [hl], a
    ld a, $00
    ldh [rSVBK], a

Jump_084_4BD6::
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
    ld a, d
    and a, $9B
    ld d, a
    ldh a, [hScrollX]
    srl a
    srl a
    srl a
    add a, e
    ld e, a
    jr nc, Jump_084_4BFE
    inc d

Jump_084_4BFE::
    ld l, e
    ld h, d
    call DrawFullScreenBufferToBGMap
    ret

; only called from RunWC8C7Phase_Case01_Sub02 (E-0047)
; 4 call sites from 1 routine (e.g. RunWC8C7Phase_Case01_Sub02)
; reads: wIsCGB, wCC44
; writes: rSVBK
RunWC8C7Phase_Case01_Sub02_Sub01::
Func_084_4C04:: ; address name
    ld a, c
    and a, $0F
    ld l, a
    ld e, a
    ld h, $00
    ld d, $00
    sla l
    rl h
    sla l
    rl h
    add hl, de
    sla l
    rl h
    sla l
    rl h
    sla l
    rl h
    ld a, c
    and a, $F0
    swap a
    add a, a
    add_a_to_hl
    push hl
    ld a, l
    add a, $98
    ld l, a
    ld a, h
    adc a, $C1
    ld h, a
    ld [hl], $40
    inc hl
    ld [hl], $41
    ld a, $13
    add_a_to_hl
    ld [hl], $50
    inc hl
    ld [hl], $51
    pop hl
    ld a, [wIsCGB]
    or a, a
    ret z
    ld c, $01
    ld a, [wCC44]
    bit 7, a
    jr nz, Jump_084_4C61
    ld a, b
    ld de, Data_084_4C7F
    add a, e
    ld e, a
    jr nc, Jump_084_4C5F
    inc d

Jump_084_4C5F::
    ld a, [de]
    ld c, a

Jump_084_4C61::
    ld a, $02
    ldh [rSVBK], a
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $D0
    ld h, a
    ld a, c
    ld [hl+], a
    ld [hl], a
    ld a, $13
    add_a_to_hl
    ld a, c
    ld [hl+], a
    ld [hl], a
    ld a, $00
    ldh [rSVBK], a
    ret

Data_084_4C7F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $01, $03, $02, $02

; 1 call site from 1 routine (e.g. Func_012_69B0)
; reads: wC88E, hFFC6, wC891
; writes: wC88E
Func_084_4C84::
    ld a, [wC88E]
    or a, a
    ret z
    ldh a, [hFFC6]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add a, $0A
    ld l, a
    ld a, h
    adc a, $C7
    ld h, a
    ld a, [hl]
    dec hl
    dec hl
    dec hl
    bit 7, a
    jr z, Jump_084_4CB1
    ld a, [hl]
    ld c, a
    ld a, [wC891]
    bit 7, a
    ret nz
    dec a
    cp a, c
    ret nz
    ld a, $00
    ld [wC88E], a
    ret

Jump_084_4CB1::
    ld a, [hl]
    cp a, $FF
    ret z
    bit 7, a
    ret z
    and a, $3F
    ld c, a
    ld a, [wC891]
    bit 7, a
    ret z
    and a, $7F
    cp a, c
    ret nz
    ld a, $00
    ld [wC88E], a
    ret

Data_084_4CCB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_084_4D2B
    dw Data_084_4D5D
    dw Data_084_4D8F
    dw Data_084_4DC1
    dw Data_084_4DF3
    dw Data_084_4E35
    dw Data_084_4E77
    dw Data_084_4EB9
    dw Data_084_4EFB
    dw Data_084_4F3D
    dw Data_084_4F7F
    dw Data_084_4FC1
    dw Data_084_5003
    dw Data_084_5045
    dw Data_084_5087
    dw Data_084_50C9
    dw Data_084_510B
    dw Data_084_515D
    dw Data_084_51AF
    dw Data_084_5201
    dw Data_084_5253
    dw Data_084_52A5
    dw Data_084_52F7
    dw Data_084_5349
    dw Data_084_539B
    dw Data_084_53ED
    dw Data_084_543F
    dw Data_084_5491
    dw Data_084_54E3
    dw Data_084_5545
    dw Data_084_55A7
    dw Data_084_5609
    dw Data_084_566B
    dw Data_084_56DD
    dw Data_084_574F
    dw Data_084_57C1
    dw Data_084_5833
    dw Data_084_58A5
    dw Data_084_5917
    dw Data_084_5989
    dw Data_084_59FB
    dw Data_084_5A7D
    dw Data_084_5AFF
    dw Data_084_5B81
    dw Data_084_5C03
    dw Data_084_5C85
    dw Data_084_5D07
    dw Data_084_5D89

; LZSS-compressed asset: 709 bytes expand to 771 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_084_4D2B:: ; heuristic: target of a monotone pointer table; C0
    db $03, $03, $0A, $9E, $E0, $C2, $00, $00, $00, $00, $0A, $9E, $E0, $C2, $00, $00
    db $00, $05, $03, $03, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00
    db $00, $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $FF

; LZSS-compressed asset: 763 bytes expand to 771 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_084_4D5D:: ; heuristic: target of a monotone pointer table; C0
    db $03, $03, $A6, $09, $6A, $C8, $00, $00, $00, $00, $A6, $09, $6A, $C8, $00, $00
    db $00, $04, $03, $03, $01, $2C, $00, $00, $FF, $FF, $FF, $FF, $00, $00, $00, $00
    db $00, $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $FF

; LZSS-compressed asset: 763 bytes expand to 771 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_084_4D8F:: ; heuristic: target of a monotone pointer table; C0
    db $03, $03, $B1, $8E, $08, $C6, $00, $00, $00, $00, $00, $8E, $08, $C6, $00, $00
    db $00, $04, $03, $03, $01, $2C, $00, $00, $FF, $FF, $FF, $FF, $00, $00, $00, $00
    db $00, $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $FF

; LZSS-compressed asset: 517 bytes expand to 515 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_084_4DC1:: ; heuristic: target of a monotone pointer table; C0
    db $03, $02, $69, $E5, $0A, $00, $BB, $92, $C9, $7B, $00, $00, $00, $00, $00, $00
    db $00, $05, $03, $03, $00, $2C, $00, $00, $01, $2A, $00, $00, $00, $00, $00, $00
    db $00, $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $FF

; LZSS-compressed asset: 772 bytes expand to 772 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_084_4DF3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $210DF3, $42

Data_084_4E35:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $210E35, $42

; LZSS-compressed asset: 727 bytes expand to 772 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_084_4E77:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $210E77, $42

; LZSS-compressed asset: 768 bytes expand to 772 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_084_4EB9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $210EB9, $42

Data_084_4EFB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $210EFB, $42

; LZSS-compressed asset: 729 bytes expand to 772 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_084_4F3D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $210F3D, $42

; LZSS-compressed asset: 252 bytes expand to 260 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_084_4F7F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $210F7F, $42

Data_084_4FC1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $210FC1, $42

; LZSS-compressed asset: 519 bytes expand to 516 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_084_5003:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $211003, $42

; LZSS-compressed asset: 256 bytes expand to 260 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_084_5045:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $211045, $42

; LZSS-compressed asset: 261 bytes expand to 260 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_084_5087:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $211087, $42

; LZSS-compressed asset: 516 bytes expand to 516 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_084_50C9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2110C9, $42

; LZSS-compressed asset: 520 bytes expand to 517 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_084_510B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21110B, $52

; LZSS-compressed asset: 520 bytes expand to 517 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_084_515D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21115D, $52

; LZSS-compressed asset: 758 bytes expand to 773 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_084_51AF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2111AF, $52

; LZSS-compressed asset: 718 bytes expand to 773 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_084_5201:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $211201, $52

Data_084_5253:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $211253, $52

Data_084_52A5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2112A5, $52

; LZSS-compressed asset: 741 bytes expand to 773 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_084_52F7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2112F7, $52

; LZSS-compressed asset: 761 bytes expand to 773 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_084_5349:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $211349, $52

Data_084_539B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21139B, $52

; LZSS-compressed asset: 644 bytes expand to 773 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_084_53ED:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2113ED, $52

; LZSS-compressed asset: 261 bytes expand to 261 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_084_543F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21143F, $52

Data_084_5491:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $211491, $52

; LZSS-compressed asset: 261 bytes expand to 262 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_084_54E3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2114E3, $62

; LZSS-compressed asset: 252 bytes expand to 262 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_084_5545:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $211545, $62

Data_084_55A7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2115A7, $62

; LZSS-compressed asset: 261 bytes expand to 262 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_084_5609:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $211609, $62

; LZSS-compressed asset: 526 bytes expand to 775 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_084_566B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21166B, $72

; LZSS-compressed asset: 764 bytes expand to 775 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_084_56DD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2116DD, $72

Data_084_574F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21174F, $72

; LZSS-compressed asset: 727 bytes expand to 775 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_084_57C1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2117C1, $72

; LZSS-compressed asset: 766 bytes expand to 775 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_084_5833:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $211833, $72

Data_084_58A5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2118A5, $72

; LZSS-compressed asset: 755 bytes expand to 775 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_084_5917:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $211917, $72

; LZSS-compressed asset: 776 bytes expand to 775 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_084_5989:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $211989, $72

Data_084_59FB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2119FB, $82

; LZSS-compressed asset: 774 bytes expand to 776 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_084_5A7D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $211A7D, $82

; LZSS-compressed asset: 252 bytes expand to 264 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_084_5AFF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $211AFF, $82

Data_084_5B81:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $211B81, $82

; LZSS-compressed asset: 254 bytes expand to 264 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_084_5C03:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $211C03, $82

; LZSS-compressed asset: 244 bytes expand to 264 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_084_5C85:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $211C85, $82

Data_084_5D07:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $211D07, $82

; LZSS-compressed asset: 252 bytes expand to 264 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_084_5D89:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $211D89, $82
    ds $21F5, $00
