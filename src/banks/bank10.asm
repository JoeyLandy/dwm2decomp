SECTION "Bank 10", ROMX[$4000], BANK[$10]
    db $10

; one frame of the event-script engine: FetchScriptCommand, then ExecuteScriptCommand
; 1 call site from 1 routine (e.g. Func_002_4AE0)
RunEventScriptFrame::
Func_010_4001:: ; address name
    call FetchScriptCommand
    call ExecuteScriptCommand
    ret

; does nothing during a fade or unless wScriptStartRequest bit 7 is set (then it clears that bit and sets wScriptRunning); reads the opcode at wScriptPointer (through ReadWordFromDataBank when wScriptInDataBank is set) and jumps through a 13-entry opcode table; $FF ends the script (wScriptRunning, wScriptCommandType and wScriptInDataBank cleared, wModeState = 0, or 5 when wCC44 bit 7 is set); the opcode handlers set wScriptCommandType and its parameters and advance wScriptPointer
; 5 call sites from 5 routines (e.g. RunEventScriptFrame, Func_002_4745, Func_002_6CD4, Func_007_6ADC, ...)
; reads: wFadeState, wScriptStartRequest, wScriptPointerLo, wScriptPointerHi, wScriptInDataBank, wCC44
; writes: wScriptStartRequest, wScriptRunning, wScriptCommandType, wScriptInDataBank, wModeState
FetchScriptCommand::
Func_010_4008:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, [wScriptStartRequest]
    bit 7, a
    ret z
    and a, $7F
    ld [wScriptStartRequest], a
    ld a, $01
    ld [wScriptRunning], a

Jump_010_401D::
    ld a, [wScriptPointerLo]
    ld l, a
    ld a, [wScriptPointerHi]
    ld h, a
    ld a, [wScriptInDataBank]
    and a, a
    jr z, Jump_010_4032
    call ReadWordFromDataBank
    ld a, b
    inc hl
    jr Jump_010_4033

Jump_010_4032::
    ld a, [hl+]

Jump_010_4033::
    cp a, $FF
    jr nz, Jump_010_4054
    xor a, a
    ld [wScriptRunning], a
    ld [wScriptCommandType], a
    ld [wScriptInDataBank], a
    ld a, [wCC44]
    bit 7, a
    jr nz, Jump_010_404E
    ld a, $00
    ld [wModeState], a
    ret

Jump_010_404E::
    ld a, $05
    ld [wModeState], a
    ret

Jump_010_4054::
    push hl
    rst $00
    dw Jump_010_42B3
    dw Jump_010_42E8
    dw Jump_010_42EF
    dw Jump_010_430F
    dw Jump_010_4326
    dw Jump_010_4343
    dw Jump_010_4367
    dw Jump_010_43C9
    db $00, $00, $00, $00, $EA, $43
    dw Func_010_43FD
    dw Func_010_4414
    dw Func_010_442E
    dw Func_010_4445
    dw Func_010_445D
    db $00, $00
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4490
    dw Func_010_44CA
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_44FB
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_450D
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4248
    dw Func_010_4252
    dw Func_010_4248
    dw Func_010_426E
    dw Func_010_4248
    dw Func_010_4248
    dw Func_010_4297
    dw Func_010_4248
    dw Func_010_4248
    dw Func_010_4248
    dw Func_010_4248
    dw Func_010_4248
    dw Func_010_4248
    dw Func_010_4248
    dw Func_010_4248
    dw Func_010_4248
    dw Func_010_4248
    dw Func_010_4248
    dw Func_010_4248
    dw Func_010_4248
    dw Func_010_4248
    dw Func_010_4248
    dw Func_010_4248
    db $00, $00
    dw Func_010_4248
    dw Func_010_4248
    dw Func_010_4248
    dw Func_010_4248
    dw Func_010_4248
    dw Func_010_4248
    dw Func_010_4248
    dw Func_010_4248
    dw Func_010_4248
    dw Func_010_4248
    ds $3C, $00
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    ds $20, $00
    dw Func_010_451F
    dw Func_010_4529
    dw Func_010_4533
    dw Func_010_453D
    db $94, $46, $47, $45, $51, $45, $7E, $46
    dw Func_010_455B
    dw Func_010_4565
    dw Func_010_4637
    dw Func_010_456F
    dw Func_010_4579
    dw Func_010_4583
    dw Func_010_458D
    dw Func_010_4597
    dw Func_010_45A1
    dw Func_010_45AB
    dw Func_010_45B5
    dw Func_010_45BF
    dw Func_010_45C9
    dw Func_010_45D3
    dw Func_010_4619
    dw Func_010_4623
    dw Func_010_462D

; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType
Func_010_4248:: ; heuristic: target of a pointer table; C0
    pop hl
    dec hl
    ld a, [hl+]
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType, wScriptStep, wC924, wC925, wC926, wScriptPointerLo, wScriptPointerHi
Func_010_4252:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $81
    ld [wScriptCommandType], a
    xor a, a
    ld [wScriptStep], a
    ld [wC924], a
    ld [wC925], a
    ld [wC926], a
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC195, hFF8C
; writes: wScriptCommandType, wScriptParam1
Func_010_426E:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $83
    ld [wScriptCommandType], a
    call StartEventScript
    ld a, [wC195]
    and a, $03
    dec a
    jr nz, Jump_010_4291
    ldh a, [hFF8C]
    bit 3, a
    jr nz, Jump_010_428B
    ld a, $01
    ld [wScriptParam1], a
    ret

Jump_010_428B::
    ld a, $03
    ld [wScriptParam1], a
    ret

Jump_010_4291::
    ld a, $02
    ld [wScriptParam1], a
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType, wScriptStep, wC924, wC925, wC926, wScriptPointerLo, wScriptPointerHi
Func_010_4297:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $86
    ld [wScriptCommandType], a
    xor a, a
    ld [wScriptStep], a
    ld [wC924], a
    ld [wC925], a
    ld [wC926], a
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    ret

Jump_010_42B3::
    pop hl
    ld a, [wScriptInDataBank]
    and a, a
    jr z, Jump_010_42CE
    ld a, $01
    ld [wScriptCommandType], a
    call ReadWordFromDataBank
    ld a, b
    ld [wScriptParam0], a
    ld a, c
    ld [wScriptParam1], a
    inc hl
    inc hl
    jr Jump_010_42DB

Jump_010_42CE::
    ld a, $01
    ld [wScriptCommandType], a
    ld a, [hl+]
    ld [wScriptParam0], a
    ld a, [hl+]
    ld [wScriptParam1], a

Jump_010_42DB::
    xor a, a
    ld [wScriptStep], a
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    ret

Jump_010_42E8::
    ld a, $02
    ld [wScriptCommandType], a
    jr Jump_010_42F4

Jump_010_42EF::
    ld a, $03
    ld [wScriptCommandType], a

Jump_010_42F4::
    pop hl
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    swap a
    or a, c
    ld [wScriptParam0], a
    ld a, [hl+]
    ld [wScriptParam1], a
    xor a, a
    ld [wScriptStep], a
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    ret

Jump_010_430F::
    pop hl
    ld a, $04
    ld [wScriptCommandType], a
    ld a, [hl+]
    ld [wScriptParam0], a
    ld a, [hl+]
    ld [wScriptParam1], a
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    ret

Jump_010_4326::
    pop hl
    ld a, $05
    ld [wScriptCommandType], a
    ld a, [hl+]
    ld [wScriptParam0], a
    ld a, [hl+]
    ld [wScriptParam1], a
    xor a, a
    ld [wScriptStep], a
    ldh [hFF9A], a
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    ret

Jump_010_4343::
    pop hl
    ld a, $06
    ld [wScriptCommandType], a
    ld a, [hl+]
    ld [wScriptParam0], a
    ld a, [hl+]
    ld [wScriptParam1], a
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    ret

; 2 call sites from 1 routine (e.g. Func_010_435A)
; reads: rSTAT
Func_010_435A::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Func_010_435A
    ld a, [hl+]
    ld [de], a
    inc de
    dec c
    jr nz, Func_010_435A
    ret

Jump_010_4367::
    push bc
    push de
    ld hl, wC89E
    ld de, vTiles1 + $6E0
    ld c, $10
    call Func_010_435A
    ld hl, wC8AE
    ld de, vTiles1 + $6F0
    ld c, $10
    call Func_010_435A
    pop de
    pop bc
    pop hl
    ld a, [wScriptInDataBank]
    and a, a
    jr z, Jump_010_43A6
    ld a, [wC552]
    or a, a
    jr nz, Jump_010_43A3
    call ReadWordFromDataBank
    inc hl
    ld a, b
    add a, l
    ld l, a
    jr nc, Jump_010_4398
    inc h

Jump_010_4398::
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    jp Jump_010_401D

Jump_010_43A3::
    inc hl
    jr Jump_010_4398

Jump_010_43A6::
    ld a, [wC552]
    or a, a
    jr nz, Jump_010_43BD
    ld a, [hl+]
    add_a_to_hl
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    jp Jump_010_401D

Jump_010_43BD::
    inc hl
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    jp Jump_010_401D

Jump_010_43C9::
    pop hl
    ld a, [wScriptInDataBank]
    and a, a
    jr z, Jump_010_43DF
    call ReadWordFromDataBank
    ld a, b
    ld [wScriptPointerLo], a
    ld a, c
    ld [wScriptPointerHi], a
    inc hl
    jp Jump_010_401D

Jump_010_43DF::
    ld a, [hl+]
    ld [wScriptPointerLo], a
    ld a, [hl]
    ld [wScriptPointerHi], a
    jp Jump_010_401D
    db $E1, $2A, $5F, $2A, $57, $7D, $EA, $1A, $C9, $7C, $EA, $1B, $C9, $CD, $45, $18
    db $C3, $1D, $40

; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType, wScriptParam1, wScriptParam0, wScriptPointerLo, wScriptPointerHi
Func_010_43FD:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $0C
    ld [wScriptCommandType], a
    ld a, [hl+]
    ld [wScriptParam1], a
    xor a, a
    ld [wScriptParam0], a
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wScriptPointerLo, wScriptPointerHi, wScriptInDataBank, wCC44
; writes: wScriptPointerLo, wScriptPointerHi, wScriptRunning, wScriptCommandType, wScriptInDataBank, wModeState
; points at: wCB8B
Func_010_4414:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, [hl+]
    swap a
    ld de, wCB8B
    add a, e
    ld e, a
    jr nc, Jump_010_4420
    inc d

Jump_010_4420::
    ld a, $E0
    ld [de], a
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    jp Jump_010_401D

; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType, wScriptParam0, wScriptStep, wScriptPointerLo, wScriptPointerHi
Func_010_442E:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $0E
    ld [wScriptCommandType], a
    ld a, [hl+]
    ld [wScriptParam0], a
    xor a, a
    ld [wScriptStep], a
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wScriptPointerLo, wScriptPointerHi, wScriptInDataBank, wCC44
; writes: hFFC6, hFFC7, wScriptPointerLo, wScriptPointerHi, wScriptRunning, wScriptCommandType, wScriptInDataBank, wModeState
Func_010_4445:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, [hl+]
    ldh [hFFC6], a
    ld a, [hl+]
    ldh [hFFC7], a
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    farcall Func_012_7EC2
    jp Jump_010_401D

; no direct call (reached through a table, a jump or a vector)
; reads: wScriptPointerLo, wScriptPointerHi, wScriptInDataBank, wCC44
; writes: wScriptPointerLo, wScriptPointerHi, wScriptRunning, wScriptCommandType, wScriptInDataBank, wModeState
Func_010_445D:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, [hl+]
    push af
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    pop af
    cp a, $FF
    jr z, Jump_010_447D
    cp a, $60
    jr c, Jump_010_4477
    call QueueSoundEffect
    jp Jump_010_401D

Jump_010_4477::
    call QueueMusic
    jp Jump_010_401D

Jump_010_447D::
    farcall Func_002_604B
    jp Jump_010_401D

; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType
Func_010_4486:: ; heuristic: target of a pointer table; C0
    pop hl
    dec hl
    ld a, [hl+]
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerFacing
; writes: wC8EF, wScriptCommandType, wC924, wC925, wC926
Func_010_4490:: ; heuristic: target of a pointer table; C0
    pop hl
    ldh a, [hPlayerFacing]
    inc a
    inc a
    and a, $03
    ld [wC8EF], a
    ld a, $1C
    ld [wScriptCommandType], a
    call StartEventScript
    ld de, $0000
    call TestFlagBit
    jr c, Jump_010_44BA
    ld hl, $0088
    ld a, l
    ld [wC924], a
    ld a, h
    ld [wC925], a
    xor a, a
    ld [wC926], a
    ret

Jump_010_44BA::
    ld hl, $0087
    ld a, l
    ld [wC924], a
    ld a, h
    ld [wC925], a
    xor a, a
    ld [wC926], a
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType, wC924, wC925, wC926
Func_010_44CA:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $1D
    ld [wScriptCommandType], a
    call StartEventScript
    ld de, $0000
    call TestFlagBit
    jr c, Jump_010_44EB
    ld hl, $4097
    ld a, l
    ld [wC924], a
    ld a, h
    ld [wC925], a
    xor a, a
    ld [wC926], a
    ret

Jump_010_44EB::
    ld hl, $408D
    ld a, l
    ld [wC924], a
    ld a, h
    ld [wC925], a
    xor a, a
    ld [wC926], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wCC38
; writes: wCC38, wScriptCommandType
Func_010_44FB:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, [wCC38]
    set 2, a
    ld [wCC38], a
    ld a, $23
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1
; writes: wScriptCommandType, wScriptParam1
Func_010_450D:: ; heuristic: target of a pointer table; C0
    pop hl
    dec hl
    ld a, [hl+]
    ld [wScriptCommandType], a
    ld a, [wScriptParam1]
    push af
    call StartEventScript
    pop af
    ld [wScriptParam1], a
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType
Func_010_451F:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $E0
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType
Func_010_4529:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $E1
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType
Func_010_4533:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $E2
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType
Func_010_453D:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $E3
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType
Func_010_4547:: ; heuristic: follows a terminator; C0
    pop hl
    ld a, $E5
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType
Func_010_4551:: ; heuristic: follows a terminator; C0
    pop hl
    ld a, $E6
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType
Func_010_455B:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $E8
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType
Func_010_4565:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $E9
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType
Func_010_456F:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $EB
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType
Func_010_4579:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $EC
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType
Func_010_4583:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $ED
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType
Func_010_458D:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $EE
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType
Func_010_4597:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $EF
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType
Func_010_45A1:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $F0
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType
Func_010_45AB:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $F1
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType
Func_010_45B5:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $F2
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType
Func_010_45BF:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $F3
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType
Func_010_45C9:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $F4
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wScriptInDataBank, wD7FB, wScriptParam0
; writes: wScriptCommandType, wScriptParam0, wScriptParam1, wScriptStep, wScriptPointerLo, wScriptPointerHi
Func_010_45D3:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, [wScriptInDataBank]
    and a, a
    jr z, Jump_010_45EE
    ld a, $01
    ld [wScriptCommandType], a
    call ReadWordFromDataBank
    ld a, b
    ld [wScriptParam0], a
    ld a, c
    ld [wScriptParam1], a
    inc hl
    inc hl
    jr Jump_010_45FB

Jump_010_45EE::
    ld a, $01
    ld [wScriptCommandType], a
    ld a, [hl+]
    ld [wScriptParam0], a
    ld a, [hl+]
    ld [wScriptParam1], a

Jump_010_45FB::
    push hl
    ld a, [wD7FB]
    add a, a
    add a, a
    add a, a
    add a, a
    ld b, a
    ld a, [wScriptParam0]
    add a, b
    ld [wScriptParam0], a
    pop hl
    xor a, a
    ld [wScriptStep], a
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType
Func_010_4619:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $F6
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType
Func_010_4623:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $F7
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType
Func_010_462D:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $F8
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wScriptInDataBank, wScriptParam0
; writes: wScriptCommandType, wScriptParam0, wScriptParam1, wScriptStep, wScriptPointerLo, wScriptPointerHi
Func_010_4637:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, [wScriptInDataBank]
    and a, a
    jr z, Jump_010_4652
    ld a, $01
    ld [wScriptCommandType], a
    call ReadWordFromDataBank
    ld a, b
    ld [wScriptParam0], a
    ld a, c
    ld [wScriptParam1], a
    inc hl
    inc hl
    jr Jump_010_465F

Jump_010_4652::
    ld a, $01
    ld [wScriptCommandType], a
    ld a, [hl+]
    ld [wScriptParam0], a
    ld a, [hl+]
    ld [wScriptParam1], a

Jump_010_465F::
    push hl
    ld de, $0000
    call TestFlagBit
    jr c, Jump_010_4670
    ld a, [wScriptParam0]
    add a, $20
    ld [wScriptParam0], a

Jump_010_4670::
    pop hl
    xor a, a
    ld [wScriptStep], a
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    ret
    INCBIN "dwm2-cobi-us.gbc", $04067E, $4F

; HL = script address: clears wC921-wC926 (parameters and step) and stores HL in wScriptPointer; the script is run by RunEventScriptFrame (28 call sites)
; 28 call sites from 28 routines (e.g. Func_010_462D, Func_010_4623, Func_010_4619, Func_010_45C9, ...)
; writes: wScriptParam0, wScriptParam1, wScriptStep, wC924, wC925, wC926, wScriptPointerLo, wScriptPointerHi
StartEventScript::
Func_010_46CD:: ; address name
    xor a, a
    ld [wScriptParam0], a
    ld [wScriptParam1], a
    ld [wScriptStep], a
    ld [wC924], a
    ld [wC925], a
    ld [wC926], a
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    ret

; does nothing during a fade or while wScriptCommandType is 0; otherwise jumps through ScriptCommandHandlers[wScriptCommandType - 1] to run one frame of the current command
; 1 call site from 1 routine (e.g. RunEventScriptFrame)
; reads: wFadeState, wScriptCommandType
ExecuteScriptCommand::
Func_010_46E9:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, [wScriptCommandType]
    or a, a
    ret z
    dec a
    rst $00

; E-0038 (C1: ExecuteScriptCommand indexes it with wScriptCommandType - 1; command types are set by the fetch handlers of FetchScriptCommand; a zero word is an unused type; all 248 words are code pointers inside the bank and the table ends where the next bytes stop being pointers).
; record: handler that runs one frame of script command type (index + 1)
ScriptCommandHandlers::
Data_010_46F5:: ; heuristic: start of a structured table; C0
    dw Func_010_4A1B ; entry 0
    dw Func_010_49E7 ; entry 1
    dw Func_010_49E1 ; entry 2
    dw Func_010_49DA ; entry 3
    dw Func_010_49D3 ; entry 4
    dw Func_010_49CC ; entry 5
    dw $0000 ; entry 6
    dw $0000 ; entry 7
    dw Func_010_49F5 ; entry 8
    dw Func_010_49EE ; entry 9
    dw $0000 ; entry 10
    dw Func_010_4BCD ; entry 11
    dw $0000 ; entry 12
    dw Func_010_4BD4 ; entry 13
    dw $0000 ; entry 14
    dw $0000 ; entry 15
    dw Func_010_4BDB ; entry 16
    dw Func_010_4BE2 ; entry 17
    dw Func_010_4BE9 ; entry 18
    dw Func_010_4BF0 ; entry 19
    dw Func_010_4BF7 ; entry 20
    dw Func_010_4BFE ; entry 21
    dw Func_010_4C05 ; entry 22
    dw Func_010_4C0C ; entry 23
    dw Func_010_4C13 ; entry 24
    dw Func_010_4C1A ; entry 25
    dw Func_010_4C21 ; entry 26
    dw Func_010_4C28 ; entry 27
    dw Func_010_4C2F ; entry 28
    dw Func_010_4C36 ; entry 29
    dw Func_010_4C3D ; entry 30
    dw Func_010_4C44 ; entry 31
    dw Func_010_4C4B ; entry 32
    dw Func_010_4C52 ; entry 33
    dw Func_010_4C59 ; entry 34
    dw Func_010_4C60 ; entry 35
    dw Func_010_4C67 ; entry 36
    dw Func_010_4C6E ; entry 37
    dw Func_010_4C75 ; entry 38
    dw Func_010_4C7C ; entry 39
    dw Func_010_4C83 ; entry 40
    dw Func_010_4C8A ; entry 41
    dw Func_010_4C91 ; entry 42
    dw Func_010_4C98 ; entry 43
    dw Func_010_4C9F ; entry 44
    dw Func_010_4CA6 ; entry 45
    dw Func_010_4CAD ; entry 46
    dw Func_010_4CB4 ; entry 47
    dw Func_010_4CBB ; entry 48
    dw Func_010_4CC2 ; entry 49
    dw Func_010_4CC9 ; entry 50
    dw Func_010_4CD0 ; entry 51
    dw Func_010_4CD7 ; entry 52
    dw Func_010_4CDE ; entry 53
    dw Func_010_4CE5 ; entry 54
    dw Func_010_4CEC ; entry 55
    dw Func_010_4CF3 ; entry 56
    dw Func_010_4CFA ; entry 57
    dw Func_010_4D01 ; entry 58
    dw Func_010_4D08 ; entry 59
    dw Func_010_4D0F ; entry 60
    dw Func_010_4D16 ; entry 61
    dw Func_010_4D1D ; entry 62
    dw Func_010_4D24 ; entry 63
    dw Func_010_4D2B ; entry 64
    dw Func_010_4D32 ; entry 65
    dw Func_010_4D39 ; entry 66
    dw Func_010_4D40 ; entry 67
    dw Func_010_4D47 ; entry 68
    dw Func_010_4D4E ; entry 69
    dw Func_010_4D55 ; entry 70
    dw Func_010_4D5C ; entry 71
    dw Func_010_4D63 ; entry 72
    dw Func_010_4D6A ; entry 73
    dw Func_010_4D71 ; entry 74
    dw Func_010_4D78 ; entry 75
    dw Func_010_4D7F ; entry 76
    dw Func_010_4D86 ; entry 77
    dw Func_010_4D8D ; entry 78
    dw Func_010_4D94 ; entry 79
    dw Func_010_4D9B ; entry 80
    dw Func_010_4DA2 ; entry 81
    dw Func_010_4DA9 ; entry 82
    dw Func_010_4DB0 ; entry 83
    dw Func_010_4DB7 ; entry 84
    dw Func_010_4DBE ; entry 85
    dw Func_010_4DC5 ; entry 86
    dw Func_010_4DCC ; entry 87
    dw Func_010_4DD3 ; entry 88
    dw Func_010_4DDA ; entry 89
    dw Func_010_4DE1 ; entry 90
    dw Func_010_4DE8 ; entry 91
    dw Func_010_4DEF ; entry 92
    dw Func_010_4DF6 ; entry 93
    dw Func_010_4DFD ; entry 94
    dw Func_010_4E04 ; entry 95
    dw Func_010_4E0B ; entry 96
    dw Func_010_4E12 ; entry 97
    dw Func_010_4E19 ; entry 98
    dw Func_010_4E20 ; entry 99
    dw Func_010_4E27 ; entry 100
    dw Func_010_4E2E ; entry 101
    dw Func_010_4E35 ; entry 102
    dw Func_010_4E3C ; entry 103
    dw Func_010_4E43 ; entry 104
    dw Func_010_4E4A ; entry 105
    dw Func_010_4E51 ; entry 106
    dw Func_010_4E58 ; entry 107
    dw Func_010_4E5F ; entry 108
    dw Func_010_4E66 ; entry 109
    dw Func_010_4E6D ; entry 110
    dw Func_010_4E74 ; entry 111
    dw Func_010_4E7B ; entry 112
    dw Func_010_4E82 ; entry 113
    dw Func_010_4E89 ; entry 114
    dw Func_010_4E90 ; entry 115
    dw Func_010_4E97 ; entry 116
    dw Func_010_4E9E ; entry 117
    dw Func_010_4EA5 ; entry 118
    dw Func_010_4EAC ; entry 119
    dw Func_010_4EB3 ; entry 120
    dw Func_010_4EBA ; entry 121
    dw Func_010_4EC1 ; entry 122
    dw Func_010_4EC8 ; entry 123
    dw Func_010_4ECF ; entry 124
    dw Func_010_4ED6 ; entry 125
    dw Func_010_4EDD ; entry 126
    dw Func_010_4986 ; entry 127
    dw Func_010_498D ; entry 128
    dw Func_010_499B ; entry 129
    dw Func_010_49A2 ; entry 130
    dw Func_010_49A9 ; entry 131
    dw Func_010_49B0 ; entry 132
    dw Func_010_4994 ; entry 133
    dw Func_010_49B7 ; entry 134
    dw Func_010_49BE ; entry 135
    dw Func_010_49C5 ; entry 136
    dw Func_010_497F ; entry 137
    dw Func_010_4955 ; entry 138
    dw Func_010_494E ; entry 139
    dw Func_010_4947 ; entry 140
    dw Func_010_4978 ; entry 141
    dw Func_010_495C ; entry 142
    dw Func_010_4924 ; entry 143
    dw Func_010_492B ; entry 144
    dw Func_010_4932 ; entry 145
    dw Func_010_4939 ; entry 146
    dw Func_010_4940 ; entry 147
    dw Func_010_4916 ; entry 148
    dw Func_010_491D ; entry 149
    dw $0000 ; entry 150
    dw Func_010_490F ; entry 151
    dw Func_010_4908 ; entry 152
    dw Func_010_4901 ; entry 153
    dw Func_010_48FA ; entry 154
    dw Func_010_48F3 ; entry 155
    dw Func_010_48EC ; entry 156
    dw Func_010_48E5 ; entry 157
    dw Func_010_4963 ; entry 158
    dw Func_010_496A ; entry 159
    dw Func_010_4971 ; entry 160
    dw $0000 ; entry 161
    dw $0000 ; entry 162
    dw $0000 ; entry 163
    dw $0000 ; entry 164
    dw $0000 ; entry 165
    dw $0000 ; entry 166
    dw $0000 ; entry 167
    dw $0000 ; entry 168
    dw $0000 ; entry 169
    dw $0000 ; entry 170
    dw $0000 ; entry 171
    dw $0000 ; entry 172
    dw $0000 ; entry 173
    dw $0000 ; entry 174
    dw $0000 ; entry 175
    dw $0000 ; entry 176
    dw $0000 ; entry 177
    dw $0000 ; entry 178
    dw $0000 ; entry 179
    dw $0000 ; entry 180
    dw $0000 ; entry 181
    dw $0000 ; entry 182
    dw $0000 ; entry 183
    dw $0000 ; entry 184
    dw $0000 ; entry 185
    dw $0000 ; entry 186
    dw $0000 ; entry 187
    dw $0000 ; entry 188
    dw $0000 ; entry 189
    dw $0000 ; entry 190
    dw Func_010_4EE4 ; entry 191
    dw Func_010_4EEB ; entry 192
    dw Func_010_4EF2 ; entry 193
    dw Func_010_4EF9 ; entry 194
    dw Func_010_4F07 ; entry 195
    dw Func_010_4F0E ; entry 196
    dw Func_010_4F00 ; entry 197
    dw Func_010_4F15 ; entry 198
    dw Func_010_4F1C ; entry 199
    dw Func_010_4F23 ; entry 200
    dw Func_010_4F2A ; entry 201
    dw Func_010_4F31 ; entry 202
    dw Func_010_4F38 ; entry 203
    dw Func_010_4F3F ; entry 204
    dw Func_010_4F46 ; entry 205
    dw Func_010_4F4D ; entry 206
    dw $0000 ; entry 207
    dw $0000 ; entry 208
    dw $0000 ; entry 209
    dw $0000 ; entry 210
    dw $0000 ; entry 211
    dw $0000 ; entry 212
    dw $0000 ; entry 213
    dw $0000 ; entry 214
    dw $0000 ; entry 215
    dw $0000 ; entry 216
    dw $0000 ; entry 217
    dw $0000 ; entry 218
    dw $0000 ; entry 219
    dw $0000 ; entry 220
    dw $0000 ; entry 221
    dw $0000 ; entry 222
    dw Func_010_65BF ; entry 223
    dw Func_010_65C6 ; entry 224
    dw Func_010_65CD ; entry 225
    dw Func_010_65D4 ; entry 226
    dw $0000 ; entry 227
    dw Func_010_65DB ; entry 228
    dw Func_010_65E2 ; entry 229
    dw $0000 ; entry 230
    dw Func_010_65E9 ; entry 231
    dw Func_010_65F0 ; entry 232
    dw Func_010_4A1B ; entry 233
    dw Func_010_65F7 ; entry 234
    dw Func_010_65FE ; entry 235
    dw Func_010_6605 ; entry 236
    dw Func_010_660C ; entry 237
    dw Func_010_6613 ; entry 238
    dw Func_010_661A ; entry 239
    dw Func_010_6621 ; entry 240
    dw Func_010_6628 ; entry 241
    dw Func_010_662F ; entry 242
    dw Func_010_6636 ; entry 243
    dw Func_010_4A1B ; entry 244
    dw Func_010_6644 ; entry 245
    dw Func_010_664B ; entry 246
    dw Func_010_6652 ; entry 247

; no direct call (reached through a table, a jump or a vector)
Func_010_48E5:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_012_59AC
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_48EC:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_012_4001
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_48F3:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_012_4013
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_48FA:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_012_550E
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4901:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_012_4030
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4908:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_012_4064
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_490F:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_012_4210
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4916:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_012_44DB
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_491D:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_012_43DA
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4924:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_012_4F1E
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_492B:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_012_4EF9
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4932:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_012_4ECE
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4939:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_012_4E55
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4940:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_012_4E4B
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4947:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_012_4A1E
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_494E:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_012_4A9A
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4955:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_012_4C07
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_495C:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_012_4965
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4963:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_012_4919
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_496A:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_012_4FEA
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4971:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_012_50B3
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4978:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_012_50E5
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_497F:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_012_51F4
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4986:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_012_63A1
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_498D:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_012_630E
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4994:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_012_6211
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_499B:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_4001
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_49A2:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_012_5CE5
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_49A9:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_012_5A2F
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_49B0:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_012_5854
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_49B7:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_012_5728
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_49BE:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_012_55E8
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_49C5:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_012_5534
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_49CC:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_05F_78CE
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_49D3:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_05F_787C
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_49DA:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_05F_785C
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_49E1:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_05F_77D8

; no direct call (reached through a table, a jump or a vector)
Func_010_49E7:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_05F_77D8
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_49EE:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_05F_7969
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wScriptStep
Func_010_49F5:: ; code pointer of the table ScriptCommandHandlers; C0
    ld a, [wScriptStep]
    rst $00
    dw Jump_010_4A27
    dw Jump_010_4A67
    dw Jump_010_4A84
    dw Jump_010_4A01

Jump_010_4A01::
    ld a, [wC8CB]
    and a, $03
    ret nz
    farcall Func_004_449F
    xor a, a
    ld [wScriptCommandType], a
    xor a, a
    ld [wScriptRunning], a
    ld a, $00
    ld [wModeState], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wScriptStep
Func_010_4A1B:: ; code pointer of the table ScriptCommandHandlers; C0
    ld a, [wScriptStep]
    rst $00
    dw Jump_010_4A27
    dw Jump_010_4A67
    dw Jump_010_4A84
    dw Jump_010_4AB3

Jump_010_4A27::
    ld a, [wScriptParam1]
    bit 7, a
    jr nz, Jump_010_4A62
    farcall Func_004_4470
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
    jr c, Jump_010_4A62
    ld a, $81
    ld [wC8CB], a
    ld a, $01
    ldh [hFFB9], a

Jump_010_4A62::
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_010_4A67::
    ld a, [wScriptParam1]
    bit 7, a
    jr nz, Jump_010_4A74
    ld a, [wC8CB]
    and a, $03
    ret nz

Jump_010_4A74::
    ld a, [wScriptParam0]
    ld l, a
    ld a, [wScriptParam1]
    ld h, a
    call Func_010_4AD0
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_010_4A84::
    ld a, [wC52B]
    bit 0, a
    ret nz
    ld a, [wScriptParam1]
    bit 6, a
    jr nz, Jump_010_4AAE
    ld a, $69
    call QueueSoundEffect
    xor a, a
    ldh [hFFB9], a
    ld a, $02
    ld [wC8CB], a
    ld a, $00
    ld [wC8CC], a
    ldh a, [hPlayerY]
    cp a, $48
    jr c, Jump_010_4AAE
    ld a, $82
    ld [wC8CB], a

Jump_010_4AAE::
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_010_4AB3::
    ld a, [wScriptParam1]
    bit 6, a
    jr nz, Jump_010_4AC6
    ld a, [wC8CB]
    and a, $03
    ret nz
    farcall Func_004_449F

Jump_010_4AC6::
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4A1B)
; reads: wD7F0, wCC44
; writes: wStringIndex, wStringCategory
Func_010_4AD0::
    ld a, h
    and a, $3F
    ld h, a
    push hl
    ld a, [wD7F0]
    and a, a
    jr z, Jump_010_4B20
    dec a
    ld c, a
    sla a
    add a, c
    ld de, Data_010_4AFF
    add a, e
    ld e, a
    jr nc, Jump_010_4AE8
    inc d

Jump_010_4AE8::
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    inc de
    ld a, [de]
    ld d, a
    pop hl
    ld a, l
    ld [wStringIndex], a
    ld a, $00
    ld [wStringCategory], a
    ld l, c
    ld h, b
    ld b, d
    rst $10
    ret

Data_010_4AFF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $40, $F0, $01, $40, $F0, $0E, $52, $1F, $01, $40, $1D, $86, $4C, $1B, $D0
    db $43, $F2, $01, $40, $0D, $01, $40, $0E, $01, $40, $0B, $90, $64, $33, $10, $5D
    db $24

Jump_010_4B20::
    pop hl
    ld a, [wCC44]
    cp a, $80
    jr z, Jump_010_4B2D
    bit 7, a
    jp nz, Jump_010_4BA7

Jump_010_4B2D::
    ld a, l
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    ld a, h
    rst $00
    dw Jump_010_4B53
    dw Jump_010_4B5A
    dw Jump_010_4B61
    dw Jump_010_4B68
    dw Jump_010_4B6F
    dw Jump_010_4B76
    dw Jump_010_4B7D
    dw Jump_010_4B7D
    dw Jump_010_4B84
    dw Jump_010_4B8B
    dw Jump_010_4B8B
    dw Jump_010_4B92
    dw Jump_010_4B99
    dw Jump_010_4BA0

Jump_010_4B53::
    farcall BeginStringDisplay_Bank28
    ret

Jump_010_4B5A::
    farcall Func_029_4001
    ret

Jump_010_4B61::
    farcall Func_02A_4001
    ret

Jump_010_4B68::
    farcall Func_02B_4001
    ret

Jump_010_4B6F::
    farcall Func_02C_4001
    ret

Jump_010_4B76::
    farcall Func_02D_4001
    ret

Jump_010_4B7D::
    farcall Func_02E_4001
    ret

Jump_010_4B84::
    farcall Func_07C_4001
    ret

Jump_010_4B8B::
    farcall Func_080_4001
    ret

Jump_010_4B92::
    farcall Func_082_4001
    ret

Jump_010_4B99::
    farcall BeginStringDisplay_Bank86
    ret

Jump_010_4BA0::
    farcall Func_089_4001
    ret

Jump_010_4BA7::
    ld a, h
    or a, a
    jr nz, Jump_010_4BBE
    ld a, l
    cp a, $20
    jr c, Jump_010_4BBE
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    farcall Func_083_4001
    ret

Jump_010_4BBE::
    ld a, l
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank8A
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4BCD:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_05F_7907
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4BD4:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_05F_7AB2
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4BDB:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_79F4
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4BE2:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_77CC
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4BE9:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_765D
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4BF0:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_75DD
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4BF7:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_73A0
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4BFE:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_7024
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4C05:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_758C
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4C0C:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_085_567B
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4C13:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_6F5B
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4C1A:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_6F14
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4C21:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_085_4617
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4C28:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_00F_7A2D
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4C2F:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_00F_786F
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4C36:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_6E5F
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4C3D:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_00F_772E
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4C44:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_6F7C
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4C4B:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_6EE7
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4C52:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_085_55F5
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4C59:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_00F_7625
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4C60:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_085_546F
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4C67:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_6EBA
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4C6E:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_6E17
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4C75:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_00F_72D9
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4C7C:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_00F_7271
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4C83:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_00F_70EC
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4C8A:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_085_4047
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4C91:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_6B98
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4C98:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_6B5B
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4C9F:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_6AFF
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4CA6:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_6AEF
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4CAD:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_6ABE
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4CB4:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_6A91
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4CBB:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_085_5421
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4CC2:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_00F_7093
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4CC9:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_6969
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4CD0:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_6941
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4CD7:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_679F
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4CDE:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_00F_7049
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4CE5:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_00F_6F65
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4CEC:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_00F_6D2B
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4CF3:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_00F_67BA
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4CFA:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_65B0
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4D01:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_00F_67BA
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4D08:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_630F
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4D0F:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_61A7
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4D16:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_6126
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4D1D:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_60FE
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4D24:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_00F_6681
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4D2B:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_00F_60E6
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4D32:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_00F_64F3
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4D39:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_00F_631F
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4D40:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_6079
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4D47:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_00F_6277
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4D4E:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_00F_5F06
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4D55:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_6038
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4D5C:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_00F_5D9D
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4D63:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_00F_5C3B
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4D6A:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_00F_59E6
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4D71:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_00F_57EA
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4D78:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_5FBC
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4D7F:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_085_4207
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4D86:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_00F_56CD
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4D8D:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_5F39
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4D94:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_5EB3
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4D9B:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_5DDD
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4DA2:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_5DAF
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4DA9:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_5C5F
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4DB0:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_5AE4
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4DB7:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_5AD6
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4DBE:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_5ABB
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4DC5:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_5A16
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4DCC:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_00F_5404
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4DD3:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_5987
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4DDA:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_5987
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4DE1:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_085_5248
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4DE8:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_5919
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4DEF:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_58FE
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4DF6:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_00F_4595
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4DFD:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_00F_40E9
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4E04:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_587A
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4E0B:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_5761
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4E12:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_00F_409A
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4E19:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_572F
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4E20:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_571D
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4E27:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_085_5065
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4E2E:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_00F_5AF3
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4E35:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_5D71
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4E3C:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_5A57
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4E43:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_085_532C
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4E4A:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_00F_7D97
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4E51:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_00F_7D62
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4E58:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_085_4D8D
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4E5F:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_085_4C24
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4E66:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_085_4B0F
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4E6D:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_085_4AEE
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4E74:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_085_4A6D
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4E7B:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_085_494D
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4E82:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_085_48A0
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4E89:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_085_505A
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4E90:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_085_4858
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4E97:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_00F_7CFB
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4E9E:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_00F_7CA5
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4EA5:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_00F_7AC6
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4EAC:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_085_4717
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4EB3:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_085_4DA6
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4EBA:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_085_46E4
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4EC1:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_085_49FA
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4EC8:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_085_4A2B
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4ECF:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_085_4755
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4ED6:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_085_481C
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4EDD:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_085_479B
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4EE4:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_568E
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4EEB:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_55C5
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4EF2:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_085_4F14
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4EF9:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_55A4
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4F00:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_5577
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4F07:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_085_50F2
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4F0E:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_5449
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4F15:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_00F_4001
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4F1C:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_541D
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4F23:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_53AB
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4F2A:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_5378
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4F31:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_51BD
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4F38:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_073_5546
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4F3F:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_085_501A
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4F46:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_085_403D
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4F4D:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_085_4001
    ret
    INCBIN "dwm2-cobi-us.gbc", $040F54, $3EA

Data_010_533E:: ; heuristic: bank from RAM variable $D7FE; C0
    db $00, $0D, $42, $E7, $59, $66, $FF

Data_010_5345:: ; heuristic: bank from RAM variable $D7FE; C0
    db $00, $0E, $42, $E7, $59, $66, $FF

Data_010_534C:: ; heuristic: bank from RAM variable $D7FE; C0
    db $00, $89, $4D, $E7, $59, $66, $FF

Data_010_5353:: ; heuristic: bank from RAM variable $D7FE; C0
    db $0A, $03, $01, $00, $1C, $41, $E7, $B5, $67, $FF, $00, $1D, $41, $E7, $B5, $67
    db $FF

Data_010_5364:: ; heuristic: bank from RAM variable $D7FE; C0
    INCBIN "dwm2-cobi-us.gbc", $041364, $2E7

Data_010_564B:: ; heuristic: bank from RAM variable $D7FE; C0
    INCBIN "dwm2-cobi-us.gbc", $04164B, $1A2

Data_010_57ED:: ; heuristic: bank from RAM variable $D7FE; C0
    INCBIN "dwm2-cobi-us.gbc", $0417ED, $1D4

Data_010_59C1:: ; heuristic: bank from RAM variable $D7FE; C0
    INCBIN "dwm2-cobi-us.gbc", $0419C1, $1CB

Data_010_5B8C:: ; heuristic: bank from RAM variable $D7FE; C0
    db $00, $09, $48, $E7, $07, $67, $FF, $FF, $00, $BB, $41, $E7, $0B, $69, $FF, $00
    db $18, $48, $06, $04, $00, $1A, $88, $FF, $00, $19, $88, $FF, $00, $20, $48, $E7
    db $D4, $77, $FF

Data_010_5BAF:: ; heuristic: bank from RAM variable $D7FE; C0
    INCBIN "dwm2-cobi-us.gbc", $041BAF, $1B9

Data_010_5D68:: ; heuristic: bank from RAM variable $D7FE; C0
    INCBIN "dwm2-cobi-us.gbc", $041D68, $48

Data_010_5DB0:: ; heuristic: bank from RAM variable $D7FE; C0
    db $00, $31, $43, $E7, $59, $66, $FF

Data_010_5DB7:: ; heuristic: bank from RAM variable $D7FE; C0
    db $00, $32, $43, $E7, $07, $67, $FF

Data_010_5DBE:: ; heuristic: bank from RAM variable $D7FE; C0
    INCBIN "dwm2-cobi-us.gbc", $041DBE, $D0

Data_010_5E8E:: ; heuristic: bank from RAM variable $D7FE; C0
    INCBIN "dwm2-cobi-us.gbc", $041E8E, $7D

Data_010_5F0B:: ; heuristic: bank from RAM variable $D7FE; C0
    INCBIN "dwm2-cobi-us.gbc", $041F0B, $F8

Data_010_6003:: ; heuristic: bank from RAM variable $D7FE; C0
    db $00, $BB, $41, $E7, $0B, $69, $FF, $00, $12, $04, $00, $E6, $0D, $50, $0A, $A4
    db $00, $FF, $00, $1D, $04, $01, $00, $01, $01, $05, $80, $03, $FF, $00, $26, $44
    db $06, $04, $00, $28, $84, $FF, $00, $27, $84, $FF, $00, $26, $44, $06, $04, $00
    db $28, $84, $FF, $00, $29, $84, $FF, $00, $2E, $44, $E7, $D4, $77, $FF

Data_010_6041:: ; heuristic: bank from RAM variable $D7FE; C0
    db $00, $2D, $44, $E7, $07, $67, $FF

Data_010_6048:: ; heuristic: bank from RAM variable $D7FE; C0
    db $00, $32, $44, $E7, $0B, $69, $FF, $00, $33, $04, $51, $0D, $05, $0A, $A8, $00
    db $FF, $00, $33, $04, $0D, $05, $0A, $A8, $00, $FF, $00, $39, $44, $06, $04, $00
    db $3B, $84, $FF, $00, $3A, $84, $FF, $00, $47, $44, $06, $04, $00, $49, $84, $FF
    db $00, $48, $84, $FF

Data_010_607C:: ; heuristic: bank from RAM variable $D7FE; C0
    INCBIN "dwm2-cobi-us.gbc", $04207C, $2FF

Data_010_637B:: ; heuristic: bank from RAM variable $D7FE; C0
    INCBIN "dwm2-cobi-us.gbc", $04237B, $C3

Data_010_643E:: ; heuristic: bank from RAM variable $D7FE; C0
    INCBIN "dwm2-cobi-us.gbc", $04243E, $16C

Data_010_65AA:: ; heuristic: bank from RAM variable $D7FE; C0
    db $00, $24, $41, $E7, $0B, $69, $FF, $00, $28, $41, $E7, $0B, $69, $FF, $00, $27
    db $41, $E7, $D4, $77, $FF

; no direct call (reached through a table, a jump or a vector)
Func_010_65BF:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_01C_4075
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_65C6:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_01C_4001
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_65CD:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_01C_4696
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_65D4:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_01C_4605
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_65DB:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_01C_6CEF
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_65E2:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_01C_6CEB
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_65E9:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_01E_4069
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_65F0:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_01E_4001
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_65F7:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_014_40CC
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_65FE:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_014_4001
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_6605:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_015_40FA
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_660C:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_015_4001
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_6613:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_00D_45D1
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_661A:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_00D_5159
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_6621:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_00D_50E5
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_6628:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_00D_55BE
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_662F:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_00D_6310
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_6636:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_00D_711C
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_663D:: ; heuristic: follows a terminator; C0
    farcall Func_00D_7115
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_6644:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_00C_4001
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_664B:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_00C_659F
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_6652:: ; code pointer of the table ScriptCommandHandlers; C0
    farcall Func_024_60DB
    ret
    INCBIN "dwm2-cobi-us.gbc", $042659, $2CF
    ds $16D8, $00
