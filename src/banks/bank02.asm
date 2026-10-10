SECTION "Bank 02", ROMX[$4000], BANK[$02]
    db $02

; only called from StartPaletteFade (E-0047)
; 1 call site from 1 routine (e.g. StartPaletteFade)
; reads: wFadeState, wC56D
; writes: wFadeLevel, wFadeDelay, wFadeDelayCounter, rBGPI, rBGPD, rOBPI, rOBPD
StartPaletteFade_Sub01::
Func_002_4001:: ; address name
    ld a, [wFadeState]
    ld b, a
    bit 7, b
    jr nz, Jump_002_401C
    ld a, $00
    ld [wFadeLevel], a
    ld a, [wFadeState]
    srl a
    srl a
    ld [wFadeDelay], a
    ld [wFadeDelayCounter], a
    ret

Jump_002_401C::
    ld a, $20
    ld [wFadeLevel], a
    ld a, [wC56D]
    bit 7, a
    jr nz, Jump_002_402D
    ld de, Data_002_7FFF
    jr Jump_002_4030

Jump_002_402D::
    ld de, $0000

Jump_002_4030::
    ld a, [wFadeState]
    cpl
    srl a
    srl a
    ld [wFadeDelay], a
    ld [wFadeDelayCounter], a
    di
    call WaitForVRAMAccess
    ld a, $80
    ldh [rBGPI], a
    ei
    ld b, $20

Jump_002_4049::
    di
    call WaitForVRAMAccess
    ld a, e
    ldh [rBGPD], a
    ld a, d
    ldh [rBGPD], a
    ei
    dec b
    jr nz, Jump_002_4049
    di
    call WaitForVRAMAccess
    ld a, $80
    ldh [rOBPI], a
    ei
    ld b, $20

Jump_002_4062::
    di
    call WaitForVRAMAccess
    ld a, e
    ldh [rOBPD], a
    ld a, d
    ldh [rOBPD], a
    ei
    dec b
    jr nz, Jump_002_4062
    ret

; one CGB fade step: counts wFadeDelayCounter down and, when it reaches 0, reloads it from wFadeDelay and moves wFadeLevel by 5. With wFadeState bit 7 clear (fading out) the level rises to at most $1F and WriteAllFadedPalettesFloor writes the palettes; with bit 7 set (fading in) it falls to at least 0 and WriteAllFadedPalettesAdd writes them. wFadeState = 0 when the level reaches $1F or 0 (E-0077)
; 1 call site from 1 routine (e.g. Func_000_10AB)
; reads: wFadeState, wFadeDelayCounter, wFadeLevel, wFadeDelay
; writes: wFadeDelayCounter, wFadeLevel, wFadeState
StepCGBFade::
Func_002_4071:: ; address name
    ld a, [wFadeState]
    bit 7, a
    jr nz, Jump_002_40A2
    ld a, [wFadeDelayCounter]
    or a, a
    jr z, Jump_002_4083
    dec a
    ld [wFadeDelayCounter], a
    ret

Jump_002_4083::
    ld a, [wFadeLevel]
    add a, $05
    cp a, $1F
    jr c, Jump_002_408E
    ld a, $1F

Jump_002_408E::
    ld [wFadeLevel], a
    call WriteAllFadedPalettesFloor
    ld a, [wFadeDelay]
    ld [wFadeDelayCounter], a
    ld a, [wFadeLevel]
    cp a, $1F
    jr z, Jump_002_40CA
    ret

Jump_002_40A2::
    ld a, [wFadeDelayCounter]
    or a, a
    jr z, Jump_002_40AD
    dec a
    ld [wFadeDelayCounter], a
    ret

Jump_002_40AD::
    ld a, [wFadeLevel]
    sub a, $05
    bit 7, a
    jr z, Jump_002_40B7
    xor a, a

Jump_002_40B7::
    ld [wFadeLevel], a
    call WriteAllFadedPalettesAdd
    ld a, [wFadeDelay]
    ld [wFadeDelayCounter], a
    ld a, [wFadeLevel]
    or a, a
    jr z, Jump_002_40CA
    ret

Jump_002_40CA::
    xor a, a
    ld [wFadeState], a
    ret

; rBGPI = $80 (palette 0, auto-increment), the 8 BG palettes from wC49F through WriteFadedPaletteFloorToBGPD; then rOBPI = $80 and the 8 OBJ palettes from wC4DF through WriteFadedPaletteFloorToOBPD (E-0076)
; 1 call site from 1 routine (e.g. StepCGBFade)
; writes: rBGPI, rOBPI
; points at: wBGPaletteBuffer, wOBJPaletteBuffer
WriteAllFadedPalettesFloor::
Func_002_40CF:: ; address name
    di
    call WaitForVRAMAccess
    ld a, $80
    ldh [rBGPI], a
    ei
    ld hl, wBGPaletteBuffer
    call WriteFadedPaletteFloorToBGPD
    call WriteFadedPaletteFloorToBGPD
    call WriteFadedPaletteFloorToBGPD
    call WriteFadedPaletteFloorToBGPD
    call WriteFadedPaletteFloorToBGPD
    call WriteFadedPaletteFloorToBGPD
    call WriteFadedPaletteFloorToBGPD
    call WriteFadedPaletteFloorToBGPD
    di
    call WaitForVRAMAccess
    ld a, $80
    ldh [rOBPI], a
    ei
    ld hl, wOBJPaletteBuffer
    call WriteFadedPaletteFloorToOBPD
    call WriteFadedPaletteFloorToOBPD
    call WriteFadedPaletteFloorToOBPD
    call WriteFadedPaletteFloorToOBPD
    call WriteFadedPaletteFloorToOBPD
    call WriteFadedPaletteFloorToOBPD
    call WriteFadedPaletteFloorToOBPD
    call WriteFadedPaletteFloorToOBPD
    ret

; four colours (one palette) from HL through WriteFadedColorFloorToOBPD (E-0076)
; 8 call sites from 1 routine (e.g. WriteAllFadedPalettesFloor)
; reads: wFadeLevel
; writes: rOBPD
WriteFadedPaletteFloorToOBPD::
Func_002_4118:: ; address name
    call WriteFadedColorFloorToOBPD
    call WriteFadedColorFloorToOBPD
    call WriteFadedColorFloorToOBPD

; reads one RGB555 colour word at HL (HL += 2), passes its three components through FadeColorComponentFloor and writes the result to rOBPD (low byte first, after WaitForVRAMAccess); its load of wC572 into D is overwritten at once (E-0076)
; 3 call sites from 1 routine (e.g. WriteFadedPaletteFloorToOBPD)
; reads: wFadeLevel
; writes: rOBPD
WriteFadedColorFloorToOBPD::
Func_002_4121:: ; address name
    ld a, [wFadeLevel]
    ld d, a
    ld c, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld de, $0000
    call FadeColorComponentFloor
    call FadeColorComponentFloor
    call FadeColorComponentFloor
    rr b
    rr c
    rr d
    rr e
    di
    call WaitForVRAMAccess
    ld a, e
    ldh [rOBPD], a
    ld a, d
    ldh [rOBPD], a
    ei
    ret

; four colours (one palette) from HL through WriteFadedColorFloorToBGPD (E-0076)
; 8 call sites from 1 routine (e.g. WriteAllFadedPalettesFloor)
; writes: rBGPD
WriteFadedPaletteFloorToBGPD::
Func_002_4149:: ; address name
    call WriteFadedColorFloorToBGPD
    call WriteFadedColorFloorToBGPD
    call WriteFadedColorFloorToBGPD

; reads one RGB555 colour word at HL (HL += 2), passes its three components through FadeColorComponentFloor and writes the result to rBGPD (low byte first, after WaitForVRAMAccess) (E-0076)
; 3 call sites from 1 routine (e.g. WriteFadedPaletteFloorToBGPD)
; writes: rBGPD
WriteFadedColorFloorToBGPD::
Func_002_4152:: ; address name
    ld c, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld de, $0000
    call FadeColorComponentFloor
    call FadeColorComponentFloor
    call FadeColorComponentFloor
    rr b
    rr c
    rr d
    rr e
    di
    call WaitForVRAMAccess
    ld a, e
    ldh [rBGPD], a
    ld a, d
    ldh [rBGPD], a
    ei
    ret

; the 5-bit component in C's low bits becomes max(component, wC572) when wC56D bit 7 is clear (lighten toward the level) or max(component - wC572, 0) when it is set (darken); then B:C:D:E is rotated right 5 bits so the next component comes down and the result collects in D:E (E-0076)
; 6 call sites from 2 routines (e.g. WriteFadedColorFloorToOBPD, WriteFadedColorFloorToBGPD)
; reads: wC56D, wFadeLevel
FadeColorComponentFloor::
Func_002_4176:: ; address name
    push de
    ld a, [wC56D]
    bit 7, a
    jr nz, Jump_002_418B
    ld a, c
    and a, $1F
    ld d, a
    ld a, [wFadeLevel]
    cp a, d
    jr nc, Jump_002_4196
    ld a, d
    jr Jump_002_4196

Jump_002_418B::
    ld a, [wFadeLevel]
    ld d, a
    ld a, c
    and a, $1F
    sub a, d
    jr nc, Jump_002_4196
    xor a, a

Jump_002_4196::
    ld e, a
    ld a, c
    and a, $E0
    or a, e
    ld c, a
    pop de
    rr b
    rr c
    rr d
    rr e
    rr b
    rr c
    rr d
    rr e
    rr b
    rr c
    rr d
    rr e
    rr b
    rr c
    rr d
    rr e
    rr b
    rr c
    rr d
    rr e
    ret

; rBGPI = $80, the 8 BG palettes from wC49F through WriteFadedPaletteAddToBGPD; then rOBPI = $80 and the 8 OBJ palettes from wC4DF through WriteFadedPaletteAddToOBPD (E-0076)
; 1 call site from 1 routine (e.g. StepCGBFade)
; writes: rBGPI, rOBPI
; points at: wBGPaletteBuffer, wOBJPaletteBuffer
WriteAllFadedPalettesAdd::
Func_002_41C6:: ; address name
    di
    call WaitForVRAMAccess
    ld a, $80
    ldh [rBGPI], a
    ei
    ld hl, wBGPaletteBuffer
    call WriteFadedPaletteAddToBGPD
    call WriteFadedPaletteAddToBGPD
    call WriteFadedPaletteAddToBGPD
    call WriteFadedPaletteAddToBGPD
    call WriteFadedPaletteAddToBGPD
    call WriteFadedPaletteAddToBGPD
    call WriteFadedPaletteAddToBGPD
    call WriteFadedPaletteAddToBGPD
    di
    call WaitForVRAMAccess
    ld a, $80
    ldh [rOBPI], a
    ei
    ld hl, wOBJPaletteBuffer
    call WriteFadedPaletteAddToOBPD
    call WriteFadedPaletteAddToOBPD
    call WriteFadedPaletteAddToOBPD
    call WriteFadedPaletteAddToOBPD
    call WriteFadedPaletteAddToOBPD
    call WriteFadedPaletteAddToOBPD
    call WriteFadedPaletteAddToOBPD
    call WriteFadedPaletteAddToOBPD
    ret

; four colours (one palette) from HL through WriteFadedColorAddToOBPD (E-0076)
; 8 call sites from 1 routine (e.g. WriteAllFadedPalettesAdd)
; reads: wFadeLevel
; writes: rOBPD
WriteFadedPaletteAddToOBPD::
Func_002_420F:: ; address name
    call WriteFadedColorAddToOBPD
    call WriteFadedColorAddToOBPD
    call WriteFadedColorAddToOBPD

; reads one RGB555 colour word at HL (HL += 2), passes its three components through FadeColorComponentAdd and writes the result to rOBPD (low byte first, after WaitForVRAMAccess); its load of wC572 into D is overwritten at once (E-0076)
; 3 call sites from 1 routine (e.g. WriteFadedPaletteAddToOBPD)
; reads: wFadeLevel
; writes: rOBPD
WriteFadedColorAddToOBPD::
Func_002_4218:: ; address name
    ld a, [wFadeLevel]
    ld d, a
    ld c, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld de, $0000
    call FadeColorComponentAdd
    call FadeColorComponentAdd
    call FadeColorComponentAdd
    rr b
    rr c
    rr d
    rr e
    di
    call WaitForVRAMAccess
    ld a, e
    ldh [rOBPD], a
    ld a, d
    ldh [rOBPD], a
    ei
    ret

; four colours (one palette) from HL through WriteFadedColorAddToBGPD (E-0076)
; 8 call sites from 1 routine (e.g. WriteAllFadedPalettesAdd)
; writes: rBGPD
WriteFadedPaletteAddToBGPD::
Func_002_4240:: ; address name
    call WriteFadedColorAddToBGPD
    call WriteFadedColorAddToBGPD
    call WriteFadedColorAddToBGPD

; reads one RGB555 colour word at HL (HL += 2), passes its three components through FadeColorComponentAdd and writes the result to rBGPD (low byte first, after WaitForVRAMAccess) (E-0076)
; 3 call sites from 1 routine (e.g. WriteFadedPaletteAddToBGPD)
; writes: rBGPD
WriteFadedColorAddToBGPD::
Func_002_4249:: ; address name
    ld c, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld de, $0000
    call FadeColorComponentAdd
    call FadeColorComponentAdd
    call FadeColorComponentAdd
    rr b
    rr c
    rr d
    rr e
    di
    call WaitForVRAMAccess
    ld a, e
    ldh [rBGPD], a
    ld a, d
    ldh [rBGPD], a
    ei
    ret

; the 5-bit component in C's low bits becomes min(component + wC572, $1F) when wC56D bit 7 is clear (lighten) or max(component - wC572, 0) when it is set (darken); then B:C:D:E is rotated right 5 bits so the next component comes down and the result collects in D:E (E-0076)
; 6 call sites from 2 routines (e.g. WriteFadedColorAddToOBPD, WriteFadedColorAddToBGPD)
; reads: wC56D, wFadeLevel
FadeColorComponentAdd::
Func_002_426D:: ; address name
    push de
    ld a, [wC56D]
    bit 7, a
    jr nz, Jump_002_4285
    ld a, c
    and a, $1F
    ld d, a
    ld a, [wFadeLevel]
    add a, d
    cp a, $1F
    jr c, Jump_002_4290
    ld a, $1F
    jr Jump_002_4290

Jump_002_4285::
    ld a, [wFadeLevel]
    ld d, a
    ld a, c
    and a, $1F
    sub a, d
    jr nc, Jump_002_4290
    xor a, a

Jump_002_4290::
    ld e, a
    ld a, c
    and a, $E0
    or a, e
    ld c, a
    pop de
    rr b
    rr c
    rr d
    rr e
    rr b
    rr c
    rr d
    rr e
    rr b
    rr c
    rr d
    rr e
    rr b
    rr c
    rr d
    rr e
    rr b
    rr c
    rr d
    rr e
    ret

; on CGB: copies B palettes (8 bytes each) from HL to wBGPaletteBuffer + 8 * C (E-0124)
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; points at: wBGPaletteBuffer
CopyBGPalettesToBuffer:: ; heuristic: follows a terminator; C0
Func_002_42C0:: ; address name
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, b
    add a, a
    add a, a
    add a, a
    ld b, a
    ld a, c
    add a, a
    add a, a
    add a, a
    ld de, wBGPaletteBuffer
    add a, e
    ld e, a
    jr nc, Jump_002_42D6
    inc d

Jump_002_42D6::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_002_42D6
    ret

; on CGB: copies B palettes (8 bytes each) from HL to wOBJPaletteBuffer + 8 * C (E-0124)
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; points at: wOBJPaletteBuffer
CopyOBJPalettesToBuffer:: ; heuristic: follows a terminator; C0
Func_002_42DD:: ; address name
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, b
    add a, a
    add a, a
    add a, a
    ld b, a
    ld a, c
    add a, a
    add a, a
    add a, a
    ld de, wOBJPaletteBuffer
    add a, e
    ld e, a
    jr nc, Jump_002_42F3
    inc d

Jump_002_42F3::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_002_42F3
    ret

; on CGB copies the 8-byte palette Data_002_4322 into wBGPaletteBuffer and wOBJPaletteBuffer and sets the upload requests wC526 and wC527 = $7F (E-0117)
; 1 call site from 1 routine (e.g. Func_000_0150)
; reads: wIsCGB
; writes: wC526, wC527
; points at: wBGPaletteBuffer, wOBJPaletteBuffer
LoadPalette0FromData4322::
Func_002_42FA:: ; address name
    ld a, [wIsCGB]
    or a, a
    ret z
    ld hl, wBGPaletteBuffer
    ld de, Data_002_4322
    ld bc, $0008
    call CopyBytesDEToHL_Bank00
    ld a, $7F
    ld [wC526], a
    ld hl, wOBJPaletteBuffer
    ld de, Data_002_4322
    ld bc, $0008
    call CopyBytesDEToHL_Bank00
    ld a, $7F
    ld [wC527], a
    ret

Data_002_4322:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $7C, $FF, $7F, $E0, $01, $00, $00

; only called from RunWC46BMenuState_Case04 (E-0047)
; 2 call sites from 1 routine (e.g. RunWC46BMenuState_Case04)
; reads: wIsCGB, wC5E9, wC5EA
; writes: wD040, wD041
; points at: wD040, wD041
RunWC46BMenuState_Case04_Sub01::
Func_002_432A:: ; address name
    ld a, [wIsCGB]
    or a, a
    ret z
    call RunWD780StepEveryOtherFrame
    ld hl, wD040
    ld a, [wC5E9]
    cp a, [hl]
    jp z, Jump_002_4519
    ld a, [wC5E9]
    ld [wD040], a
    jp Jump_002_4519

; wD781 += 1; on odd values, unless wD780 is $FF, runs the step for wD780 (jump table) (E-0122)
; 1 call site from 1 routine (e.g. RunWC46BMenuState_Case04_Sub01)
; reads: wD781, wD780
; writes: wD781
RunWD780StepEveryOtherFrame::
Func_002_4345:: ; address name
    ld a, [wD781]
    inc a
    ld [wD781], a
    bit 0, a
    jr nz, Jump_002_4351
    ret

Jump_002_4351::
    ld a, [wD780]
    cp a, $FF
    ret z
    rst $00
    dw RunWD780StepEveryOtherFrame_Case00
    dw RunWD780StepEveryOtherFrame_Case01
    dw RunWD780StepEveryOtherFrame_Case02
    dw RunWD780StepEveryOtherFrame_Case03

; entry 0 of the `rst $00` table in RunWD780StepEveryOtherFrame
; no direct call (reached through a table, a jump or a vector)
; reads: wD783, rSTAT, wD780
; writes: wD780
; points at: wD09D
RunWD780StepEveryOtherFrame_Case00::
Jump_002_4360:: ; address name
    ld hl, wD09D
    ld a, [wD783]
    swap a
    ld d, a
    and a, $F0
    ld e, a
    ld a, d
    and a, $0F
    ld d, a
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld de, rBGPI
    ld a, $80
    ld [de], a
    inc de

; only called from RunWD780StepEveryOtherFrame_Case03 (E-0047)
; 1 call site from 1 routine (e.g. RunWD780StepEveryOtherFrame_Case03)
; reads: rSTAT, wD780
; writes: wD780
RunWD780StepEveryOtherFrame_Case03_Sub01::
Func_002_4380:: ; address name
    di

Jump_002_4381::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_002_4381
    ld a, [hl+]
    ld [de], a
    ld a, [hl+]
    ld [de], a

Jump_002_438B::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_002_438B
    ld a, [hl+]
    ld [de], a
    ld a, [hl+]
    ld [de], a

Jump_002_4395::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_002_4395
    ld a, [hl+]
    ld [de], a
    ld a, [hl+]
    ld [de], a

Jump_002_439F::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_002_439F
    ld a, [hl+]
    ld [de], a
    ld a, [hl+]
    ld [de], a

Jump_002_43A9::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_002_43A9
    ld a, [hl+]
    ld [de], a
    ld a, [hl+]
    ld [de], a

Jump_002_43B3::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_002_43B3
    ld a, [hl+]
    ld [de], a
    ld a, [hl+]
    ld [de], a

Jump_002_43BD::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_002_43BD
    ld a, [hl+]
    ld [de], a
    ld a, [hl+]
    ld [de], a

Jump_002_43C7::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_002_43C7
    ld a, [hl+]
    ld [de], a
    ld a, [hl+]
    ld [de], a
    ei
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

; entry 1 of the `rst $00` table in RunWD780StepEveryOtherFrame
; no direct call (reached through a table, a jump or a vector)
; reads: wD783, rSTAT, wD780
; writes: wD780
; points at: wD0AD
RunWD780StepEveryOtherFrame_Case01::
Jump_002_43DA:: ; address name
    ld hl, wD0AD
    ld a, [wD783]
    swap a
    ld d, a
    and a, $F0
    ld e, a
    ld a, d
    and a, $0F
    ld d, a
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld de, rBGPI
    ld a, $90
    ld [de], a
    inc de
    jp RunWD780StepEveryOtherFrame_Case03_Sub01

; entry 2 of the `rst $00` table in RunWD780StepEveryOtherFrame
; no direct call (reached through a table, a jump or a vector)
; reads: wD783, rSTAT, wD780
; writes: wD780
; points at: wD0BD
RunWD780StepEveryOtherFrame_Case02::
Jump_002_43FD:: ; address name
    ld hl, wD0BD
    ld a, [wD783]
    swap a
    ld d, a
    and a, $F0
    ld e, a
    ld a, d
    and a, $0F
    ld d, a
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld de, rBGPI
    ld a, $A0
    ld [de], a
    inc de
    jp RunWD780StepEveryOtherFrame_Case03_Sub01

; entry 3 of the `rst $00` table in RunWD780StepEveryOtherFrame
; no direct call (reached through a table, a jump or a vector)
; reads: wD783
; writes: wD783, wD782, wD780
; points at: wD0CD
RunWD780StepEveryOtherFrame_Case03::
Jump_002_4420:: ; address name
    ld hl, wD0CD
    ld a, [wD783]
    swap a
    ld d, a
    and a, $F0
    ld e, a
    ld a, d
    and a, $0F
    ld d, a
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld de, rBGPI
    ld a, $B0
    ld [de], a
    inc de
    call RunWD780StepEveryOtherFrame_Case03_Sub01
    ld a, [wD783]
    inc a
    ld [wD783], a
    cp a, $08
    jr c, Jump_002_445B
    xor a, a
    ld [wD782], a
    ld [wD783], a
    ld a, $FF
    ld [wD780], a
    ret

Jump_002_445B::
    xor a, a
    ld [wD782], a
    ld [wD780], a
    ret

; only called from RunWC46BMenuState_Case01 (E-0047)
; 1 call site from 1 routine (e.g. RunWC46BMenuState_Case01)
; reads: wD783
; writes: wD783
; points at: wBGPaletteBuffer, wD09D
RunWC46BMenuState_Case01_Sub01::
Func_002_4463:: ; address name
    ld hl, wBGPaletteBuffer
    ld de, wD09D
    ld c, $04

Jump_002_446B::
    push bc
    push hl
    push de
    call RunWC46BMenuState_Case01_Sub01_Sub01
    pop de
    pop hl
    pop bc
    ld a, $10
    add a, e
    ld e, a
    jr nc, Jump_002_447B
    inc d

Jump_002_447B::
    ld a, $10
    add_a_to_hl
    dec c
    jr nz, Jump_002_446B
    ld c, $04
    ld hl, wBGPaletteBuffer
    ld a, [wD783]
    inc a
    ld [wD783], a
    cp a, $08
    jr c, Jump_002_446B
    xor a, a
    ld [wD783], a
    ret

; only called from RunWC46BMenuState_Case01_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. RunWC46BMenuState_Case01_Sub01)
; reads: wD783, wD7C4, wD7C5, wD7C6, wD782
; writes: wD7C4, wD7C5, wD7C6, wD782
; points at: wD7C4
RunWC46BMenuState_Case01_Sub01_Sub01::
Func_002_449A:: ; address name
    ld c, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld a, b
    srl a
    srl a
    ld [wD7C4], a
    push bc
    sla c
    rl b
    sla c
    rl b
    sla c
    rl b
    ld a, b
    and a, $1F
    ld [wD7C5], a
    pop bc
    ld a, c
    and a, $1F
    ld [wD7C6], a
    push hl
    ld hl, Data_002_4510
    ld a, [wD783]
    add_a_to_hl
    ld b, [hl]
    ld hl, wD7C4
    ld c, $03

Jump_002_44D2::
    ld a, [hl]
    add a, b
    cp a, $20
    jr c, Jump_002_44DA
    ld a, $1F

Jump_002_44DA::
    ld [hl+], a
    dec c
    jr nz, Jump_002_44D2
    pop hl
    ld a, [wD7C4]
    ld b, a
    ld a, [wD7C5]
    sla a
    sla a
    sla a
    ld c, a
    sla c
    rl b
    sla c
    rl b
    ld a, [wD7C6]
    or a, c
    ld c, a
    ld a, c
    ld [de], a
    inc de
    ld a, b
    ld [de], a
    inc de
    ld a, [wD782]
    inc a
    ld [wD782], a
    cp a, $08
    jr c, RunWC46BMenuState_Case01_Sub01_Sub01
    xor a, a
    ld [wD782], a
    ret

Data_002_4510:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $04, $08, $0C, $10, $14, $18, $1C, $20, $24

Jump_002_4519::
    ld hl, wD041
    ld a, [wC5EA]
    cp a, [hl]
    jp z, Jump_002_45C1
    ld a, [wC5EA]
    ld [wD041], a
    jp Jump_002_45C1

; no direct call (reached through a table, a jump or a vector)
; reads: wC5EA
; writes: rOBPD
Func_002_452C:: ; heuristic: follows a terminator; C0
    push hl
    ld a, [wC5EA]
    and a, $03
    ld de, Data_002_45C2
    add a, e
    ld e, a
    jr nc, Jump_002_453A
    inc d

Jump_002_453A::
    ld a, [de]
    add_a_to_hl
    di
    call WaitForVRAMAccess
    ld a, [hl+]
    ldh [rOBPD], a
    ld a, [hl]
    ldh [rOBPD], a
    ei
    pop hl
    push hl
    ld a, [wC5EA]
    srl a
    srl a
    and a, $03
    ld de, Data_002_45C2
    add a, e
    ld e, a
    jr nc, Jump_002_455E
    inc d

Jump_002_455E::
    ld a, [de]
    add_a_to_hl
    di
    call WaitForVRAMAccess
    ld a, [hl+]
    ldh [rOBPD], a
    ld a, [hl]
    ldh [rOBPD], a
    ei
    pop hl
    push hl
    ld a, [wC5EA]
    swap a
    and a, $03
    ld de, Data_002_45C2
    add a, e
    ld e, a
    jr nc, Jump_002_4580
    inc d

Jump_002_4580::
    ld a, [de]
    add_a_to_hl
    di
    call WaitForVRAMAccess
    ld a, [hl+]
    ldh [rOBPD], a
    ld a, [hl]
    ldh [rOBPD], a
    ei
    pop hl
    push hl
    ld a, [wC5EA]
    swap a
    srl a
    srl a
    and a, $03
    ld de, Data_002_45C2
    add a, e
    ld e, a
    jr nc, Jump_002_45A6
    inc d

Jump_002_45A6::
    ld a, [de]
    add_a_to_hl
    di
    call WaitForVRAMAccess
    ld a, [hl+]
    ldh [rOBPD], a
    ld a, [hl]
    ldh [rOBPD], a
    ei
    pop hl
    ld a, l
    add a, $08
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ret

Jump_002_45C1::
    ret

Data_002_45C2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $02, $04, $00, $06

; start-up for wGameMode = 1; forcing this mode on the emulator shows: water map with the player sprite (E-0029)
; 1 call site from 1 routine (e.g. RunGameModeInit_Case01)
; reads: hMapId, hMapScreenX, hMapScreenY, wC88D, wC5E0
; writes: rIF, wC51F, wC520, wC8C5, wC5E0, wC5EC
GameMode1_Init::
Func_002_45C6:: ; address name
    call ClearSTATInterruptSources
    xor a, a
    ldh [rIF], a
    ldh a, [hMapId]
    cp a, $38
    jr nz, Jump_002_45DB
    ldh a, [hMapScreenX]
    ld c, a
    ldh a, [hMapScreenY]
    or a, c
    call z, InitSoundHardware

Jump_002_45DB::
    ld a, [wC88D]
    or a, a
    call nz, InitSoundHardware
    call GameMode1_Init_Sub01
    call Func_000_13E5
    ld b, $46
    ld de, Data_046_4001
    ld hl, vTiles1
    call DecompressToVRAM
    ld hl, Data_002_4AD6
    ld a, [hl]
    ld [wC51F], a
    ld hl, Data_002_4AD7
    ld a, [hl]
    ld [wC520], a
    farcall SendSGBPaletteSetPacket
    call Func_002_4628
    xor a, a
    ld [wC8C5], a
    ld a, [wC5E0]
    or a, a
    jr nz, Jump_002_461A
    call InitSoundHardware
    call RestartMapMusic

Jump_002_461A::
    xor a, a
    ld [wC5E0], a
    ld a, $03
    ld [wC5EC], a
    ld a, $03
    jp Jump_000_077A

; 4 call sites from 4 routines (e.g. GameMode1_Init, FieldModeStateDispatch_Case04, ExitPauseMenuToField, EnterGameMode1WithDefaultPalettes)
; reads: wCC44, hMapId, wC8C7, wC927, wC5E0, wIsCGB
; writes: hFF8D, hScrollY, hScrollX, hFFA0, hFF9F, rLYC, wFrameCounterLo, wFrameCounterHi, ...
Func_002_4628::
    ld a, $0F
    ldh [hFF8D], a
    call Func_000_1C0C
    ld a, $00
    ldh [hScrollY], a
    ld a, $00
    ldh [hScrollX], a
    ld a, $80
    ldh [hFFA0], a
    ld a, $07
    ldh [hFF9F], a
    ld a, $67
    ldh [rLYC], a
    xor a, a
    ld [wFrameCounterLo], a
    ld [wFrameCounterHi], a
    ld a, $00
    ld [wC5E1], a
    di
    call WaitForVRAMAccess
    ld a, $40
    ldh [rSTAT], a
    xor a, a
    ldh [rIF], a
    ei
    call Func_002_5E85
    call Func_002_5E85
    farcall Func_060_639D
    farcall Func_060_62F9
    call WritePlayerNameWithFlag0SuffixToWC130
    ld a, [wCC44]
    bit 7, a
    jr nz, Jump_002_467D
    ldh a, [hMapId]
    cp a, $14
    jr z, Jump_002_4680

Jump_002_467D::
    call LoadRecordListNameTiles

Jump_002_4680::
    farcall Func_004_4AA8
    farcall Func_012_70A4
    farcall Func_012_710A
    xor a, a
    ld [wC468], a
    ld a, [wC8C7]
    or a, a
    jr nz, Jump_002_46B3
    call LoadMapScreen
    farcall Func_069_4001
    farcall Func_085_5B53
    farcall ClearWC935WhenFieldIdle
    jr Jump_002_46BC

Jump_002_46B3::
    call RestoreScreenBufferFromBGMap1
    farcall Func_085_5B53

Jump_002_46BC::
    ld hl, vBGMap0
    call DrawFullScreenBufferToBGMap
    xor a, a
    ld [wCBCF], a
    farcall Func_012_6A6A
    xor a, a
    ld [wC8CB], a
    ld [wC8CC], a
    ld [wC8CD], a
    ld [wC8CE], a
    ld a, [wC927]
    bit 7, a
    jr z, Jump_002_46EE
    and a, $7F
    ldh [hFFC6], a
    farcall RunFieldCommandHFFC6
    xor a, a
    ld [wC927], a

Jump_002_46EE::
    ld a, [wC5E0]
    or a, a
    jr nz, Jump_002_46F7
    call RestartMapMusic

Jump_002_46F7::
    call Func_002_5F9B
    call RunWC8C7Phase
    xor a, a
    ldh [hFF8D], a
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, $7F
    ld [wC527], a
    ret

; copies the player name to wC130 with a terminator, then a two-tile suffix ($58 $87 when story flag 0 is set, else $87 $60) (E-0124)
; 10 call sites from 10 routines (e.g. Func_002_4628, ScriptCommandF6_Run_Case08, ScriptCommandF7_Run_Case23, ScriptCommandF7_Run_Case23_Sub01, ...)
; writes: wC13A, wC13C, wC13D, wC13E
; points at: wC60C, wC130
WritePlayerNameWithFlag0SuffixToWC130::
Func_002_470B:: ; address name
    ld hl, wC60C
    ld de, wC130
    ld bc, $000A
    call CopyBytes
    ld a, $F0
    ld [wC13A], a
    ld de, $0000
    call TestFlagBit
    jp nc, Jump_002_4735
    ld a, $58
    ld [wC13C], a
    ld a, $87
    ld [wC13D], a
    ld a, $F0
    ld [wC13E], a
    ret

Jump_002_4735::
    ld a, $87
    ld [wC13C], a
    ld a, $60
    ld [wC13D], a
    ld a, $F0
    ld [wC13E], a
    ret

; runs the routine for wC8C7 & 3 (jump table; phase 3 reuses phase 0) (E-0122)
; 1 call site from 1 routine (e.g. Func_002_4628)
; reads: wC8C7
RunWC8C7Phase::
Func_002_4745:: ; address name
    ld a, [wC8C7]
    and a, $03
    rst $00
    dw RunWC8C7Phase_Case00
    dw RunWC8C7Phase_Case01
    dw RunWC8C7Phase_Case02
    dw RunWC8C7Phase_Case00

; entry 0 of the `rst $00` table in RunWC8C7Phase
; no direct call (reached through a table, a jump or a vector)
; reads: wModeState, wScriptRunning, wSGBActive, wC5E0, wCC44
; writes: wC8C7, wC46B, wC46C, wModeState
RunWC8C7Phase_Case00::
Jump_002_4753:: ; address name
    xor a, a
    ld [wC8C7], a
    ld a, [wModeState]
    cp a, $06
    jr nz, Jump_002_4768
    ld a, $05
    ld [wC46B], a
    xor a, a
    ld [wC46C], a
    ret

Jump_002_4768::
    xor a, a
    ld [wModeState], a
    ld a, [wScriptRunning]
    or a, a
    jr z, Jump_002_4779
    ld a, $01
    ld [wModeState], a
    jr Jump_002_4786

Jump_002_4779::
    ld a, [wCC44]
    bit 7, a
    jp z, Jump_002_4786
    ld a, $05
    ld [wModeState], a

Jump_002_4786::
    ld a, [wSGBActive]
    or a, a
    jr z, Jump_002_4792
    ld a, [wC5E0]
    cp a, $02
    ret z

Jump_002_4792::
    ld a, $FC
    call StartPaletteFade
    ret

; entry 2 of the `rst $00` table in RunWC8C7Phase
; no direct call (reached through a table, a jump or a vector)
; reads: wCFC5, wD092, wModeState, wScriptRunning, wSGBActive, wC5E0, wCC44, hFF8C, ...
; writes: wC8C7, wC46B, wC46C, wModeState, hMapId, hMapScreenX, hMapScreenY, hPlayerFacing, ...
RunWC8C7Phase_Case02::
Jump_002_4798:: ; address name
    ld a, [wCFC5]
    cp a, $05
    jp z, Jump_002_48AE
    ld a, [wD092]
    or a, a
    jr z, RunWC8C7Phase_Case00
    cp a, $03
    jp z, Jump_002_4846
    cp a, $02
    jr nz, Jump_002_47B6
    ld a, [wCFC5]
    cp a, $04
    jr nz, RunWC8C7Phase_Case00

Jump_002_47B6::
    ld a, [wCFC5]
    cp a, $04
    jp z, Jump_002_4846
    cp a, $06
    jr z, Jump_002_47C6
    cp a, $07
    jr nz, Jump_002_47CB

Jump_002_47C6::
    call ResetLeadRecordFields55And5B
    jr RunWC8C7Phase_Case00

Jump_002_47CB::
    xor a, a
    ld [wC8C7], a
    ld a, $05
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a, a
    ldh [hMapScreenY], a
    ld c, $03
    push bc
    ld de, $0025
    call TestFlagBit
    pop bc
    jr nc, Jump_002_47E8
    ld c, $02

Jump_002_47E8::
    ld a, c
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld [wC8F4], a
    ld [wC8F9], a
    ld a, $50
    ldh [hPlayerX], a
    ld [wC8F0], a
    ld [wC8F5], a
    ld [wC8FA], a
    ld a, $30
    ldh [hPlayerY], a
    ld [wC8F1], a
    ld [wC8F6], a
    ld [wC8FB], a
    ldh a, [hFF8C]
    and a, $F7
    ldh [hFF8C], a
    xor a, a
    ldh [hFF93], a
    ld a, [wCC44]
    bit 7, a
    jr z, Jump_002_4824
    farcall SaveWCD07RecordToSRAMSlotWCC42

Jump_002_4824::
    xor a, a
    ld [wCC44], a
    farcall PlayMapMusic
    xor a, a
    ld [wC917], a
    ld a, $05
    ld [wC916], a
    farcall DispatchTalkEvent
    farcall FetchScriptCommand
    jp Func_002_4628

Jump_002_4846::
    farcall FullyHealParty
    xor a, a
    ld [wC8C7], a
    ld a, $04
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a, a
    ldh [hMapScreenY], a
    ld a, $02
    ldh [hPlayerFacing], a
    ldh [hPlayerFacing], a
    ld [wC8F4], a
    ld [wC8F9], a
    ld a, $40
    ldh [hPlayerX], a
    ld [wC8F0], a
    ld [wC8F5], a
    ld [wC8FA], a
    ld a, $30
    ldh [hPlayerY], a
    ld [wC8F1], a
    ld [wC8F6], a
    ld [wC8FB], a
    ld a, $01
    ld [wC917], a
    ld a, $65
    ld [wC916], a
    ld a, [wC91C]
    ld [wScriptStartRequest], a
    ld a, [wC91D]
    ld [wScriptPointerLo], a
    ld a, [wC91E]
    ld [wScriptPointerHi], a
    ld a, $02
    ldh [hFFB9], a
    ld a, $F7
    ld [wScriptCommandType], a
    ld a, $01
    ld [wScriptInDataBank], a
    jp Func_002_4628

Jump_002_48AE::
    farcall FullyHealParty
    call Func_002_5E82
    call LoadRecordListNameTiles
    farcall Func_004_4AA8
    jp RunWC8C7Phase_Case00

; entry 1 of the `rst $00` table in RunWC8C7Phase
; no direct call (reached through a table, a jump or a vector)
; reads: wDataBankSave, wCC44, wC833, wJoypadPressed
; writes: wC8C7, wC5E0, wModeState, wC833, wC914, wDataBankSave, wC46B, wC46C, ...
RunWC8C7Phase_Case01::
Jump_002_48C3:: ; address name
    xor a, a
    ld [wC8C7], a
    call RunWC8C7Phase_Case01_Sub01
    ld a, [wDataBankSave]
    cp a, $40
    jr nz, Jump_002_48D9
    push af
    xor a, a
    ld [wC5E0], a
    pop af
    jr Jump_002_48EF

Jump_002_48D9::
    or a, a
    jr nz, Jump_002_48EF
    ld a, [wJoypadPressed]
    set 0, a
    ld [wJoypadPressed], a
    ld a, $01
    ldh [hFFCE], a
    farcall Func_002_64E5
    ret

Jump_002_48EF::
    and a, $BF
    push af
    xor a, a
    ld [wModeState], a
    ld a, [wCC44]
    bit 7, a
    jr z, Jump_002_4902
    ld a, $05
    ld [wModeState], a

Jump_002_4902::
    pop af
    bit 7, a
    jr z, Jump_002_4945
    and a, $7F
    ld [wC833], a
    ld a, $80
    ld [wC914], a
    xor a, a
    ld [wDataBankSave], a
    ld a, [wC833]
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
    bit 7, a
    jr z, Jump_002_4938
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    cp a, $01
    jr z, Jump_002_4938
    ld de, $0020
    call SetFlagBit

Jump_002_4938::
    ld a, $06
    ld [wModeState], a
    xor a, a
    ld [wC46B], a
    ld [wC46C], a
    ret

Jump_002_4945::
    or a, a
    ret z
    dec a
    jr nz, Jump_002_495E
    xor a, a
    ld [wDataBankSave], a
    ld a, $19
    ld [wC916], a
    xor a, a
    ld [wC917], a
    farcall DispatchTalkEvent
    ret

Jump_002_495E::
    dec a
    jr nz, Jump_002_497E
    call ResetFollowersToPlayer
    ld a, $02
    call QueueMusic
    ld a, $67
    call QueueSoundEffect
    ld a, $08
    ld [wC916], a
    xor a, a
    ld [wC917], a
    farcall DispatchTalkEvent
    ret

Jump_002_497E::
    dec a
    jr nz, Jump_002_499E
    call ResetFollowersToPlayer
    ld a, $02
    call QueueMusic
    ld a, $67
    call QueueSoundEffect
    ld a, $06
    ld [wC916], a
    xor a, a
    ld [wC917], a
    farcall DispatchTalkEvent
    ret

Jump_002_499E::
    dec a
    jr nz, Jump_002_49BE
    call ResetFollowersToPlayer
    ld a, $02
    call QueueMusic
    ld a, $67
    call QueueSoundEffect
    ld a, $07
    ld [wC916], a
    xor a, a
    ld [wC917], a
    farcall DispatchTalkEvent
    ret

Jump_002_49BE::
    dec a
    jr nz, Jump_002_49D2
    ld a, $39
    ld [wC916], a
    ld a, $02
    ld [wC917], a
    farcall DispatchTalkEvent
    ret

Jump_002_49D2::
    dec a
    jr nz, Jump_002_49E6
    ld a, $6A
    ld [wC916], a
    ld a, $03
    ld [wC917], a
    farcall DispatchTalkEvent
    ret

Jump_002_49E6::
    dec a
    jr nz, Jump_002_49FA
    ld a, $A1
    ld [wC916], a
    ld a, $04
    ld [wC917], a
    farcall DispatchTalkEvent
    ret

Jump_002_49FA::
    dec a
    jr nz, Jump_002_4A0E
    ld a, $AA
    ld [wC916], a
    ld a, $04
    ld [wC917], a
    farcall DispatchTalkEvent
    ret

Jump_002_4A0E::
    dec a
    jr nz, Jump_002_4A1C
    xor a, a
    ld [wDataBankSave], a
    farcall RunWC8C7Phase_Case01_Sub02
    ret

Jump_002_4A1C::
    ld a, $09
    ld [wC916], a
    xor a, a
    ld [wC917], a
    farcall DispatchTalkEvent
    ret

; hPlayerFacing and the three follower directions = 0, every follower position = hPlayerX/hPlayerY, wDataBankSave = 0 (E-0117)
; 3 call sites from 1 routine (e.g. RunWC8C7Phase_Case01)
; reads: hPlayerX, hPlayerY
; writes: hPlayerFacing, wFollowerRecords, wC8F4, wC8F9, wC8F0, wC8F5, wC8FA, wC8F1, ...
ResetFollowersToPlayer::
Func_002_4A2C:: ; address name
    xor a, a
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld [wC8F4], a
    ld [wC8F9], a
    ldh a, [hPlayerX]
    ld [wC8F0], a
    ld [wC8F5], a
    ld [wC8FA], a
    ldh a, [hPlayerY]
    ld [wC8F1], a
    ld [wC8F6], a
    ld [wC8FB], a
    xor a, a
    ld [wDataBankSave], a
    ret

; for the lead record wC6FE: field $55 = 0, field $5B = $0001, then far-calls Func_004_4AA8 (E-0122)
; 1 call site from 1 routine (e.g. RunWC8C7Phase_Case02)
; reads: wC6FE
; writes: rRAMG
ResetLeadRecordFields55And5B::
Func_002_4A53:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC6FE]
    ld c, $55
    call SRAMRecordAddress
    ld [hl], $00
    ld a, [wC6FE]
    ld c, $5B
    call SRAMRecordAddress
    ld [hl], $01
    inc hl
    ld [hl], $00
    xor a, a
    ld [rRAMG], a
    farcall Func_004_4AA8
    ret

; only called from RunWC8C7Phase_Case01 (E-0047)
; 1 call site from 1 routine (e.g. RunWC8C7Phase_Case01)
; reads: wCC44, hMapId, hMapScreenX, hMapScreenY, wCECE, wCF8B
; writes: wCBCF, wCF8B, hFFC6
RunWC8C7Phase_Case01_Sub01::
Func_002_4A7A:: ; address name
    ld a, [wCC44]
    bit 7, a
    ret nz
    ldh a, [hMapId]
    cp a, $00
    ret nz
    ldh a, [hMapScreenX]
    or a, a
    ret nz
    ldh a, [hMapScreenY]
    cp a, $03
    ret nz
    ld a, [wCECE]
    cp a, $01
    ret nz
    ld a, [wCF8B]
    cp a, $FF
    jr z, Jump_002_4AA1
    ld a, $80
    ld [wCBCF], a
    ret

Jump_002_4AA1::
    xor a, a
    ld [wCF8B], a
    ld a, $15
    ldh [hFFC6], a
    farcall RunFieldCommandHFFC6
    ld a, $80
    ld [wCBCF], a
    ret

; only called from GameMode1_Init (E-0047)
; 1 call site from 1 routine (e.g. GameMode1_Init)
; reads: wCC44, hMapId, hMapScreenX, hMapScreenY
GameMode1_Init_Sub01::
Func_002_4AB5:: ; address name
    ld a, [wCC44]
    bit 7, a
    jr nz, Jump_002_4AC5
    ldh a, [hMapId]
    cp a, $20
    jr nc, Jump_002_4AC5

Jump_002_4AC2::
    ld a, $02
    ret

Jump_002_4AC5::
    cp a, $38
    jr nz, Jump_002_4AD3
    ldh a, [hMapScreenX]
    or a, a
    jr nz, Jump_002_4AD3
    ldh a, [hMapScreenY]
    or a, a
    jr z, Jump_002_4AC2

Jump_002_4AD3::
    ld a, $04
    ret

Data_002_4AD6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00

Data_002_4AD7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00

; per-frame routine for wGameMode = 1
; 1 call site from 1 routine (e.g. RunGameModeUpdate_Case01)
; reads: wC5E0, wModeState, wC5E9, wC5EA, wC5EB, wSGBActive
; writes: wJoypadHeld, wJoypadHeldPrev, wJoypadPressed, wJoypadPressedRepeat, wJoypadRepeatTimer, wC565, wC5E0
; points at: wC5E9, wD040, wOBJPaletteBuffer, wC4FF
GameMode1_Update::
Func_002_4AD8:: ; address name
    ld a, [wC5E0]
    cp a, $02
    jp z, Jump_002_5FF7

; advances the play time, then runs the routine for wModeState & $0F (nine states) (E-0122)
; 1 call site from 1 routine (e.g. Func_002_5F9B)
; reads: wModeState
FieldModeStateDispatch::
Func_002_4AE0:: ; address name
    call IncrementPlayTime
    ld a, [wModeState]
    and a, $0F
    rst $00
    dw FieldModeStateDispatch_Case00
    dw FieldModeStateDispatch_Case01
    dw FieldModeStateDispatch_Case02
    dw FieldModeStateDispatch_Case03
    dw FieldModeStateDispatch_Case04
    dw FieldModeStateDispatch_Case05
    dw FieldModeStateDispatch_Case06
    dw FieldModeStateDispatch_Case07
    dw FieldModeStateDispatch_Case08

; entry 0 of the `rst $00` table in FieldModeStateDispatch
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState, wJoypadPressed, hFFC6
; writes: hFFCE
FieldModeStateDispatch_Case00::
Jump_002_4AFB:: ; address name
    ld a, [wFadeState]
    or a, a
    jp nz, Jump_002_4B44
    ld a, [wJoypadPressed]
    bit 2, a
    jr z, Jump_002_4B13
    farcall FieldModeStateDispatch_Shared04
    ldh a, [hFFC6]
    or a, a
    ret nz

Jump_002_4B13::
    farcall FieldModeStateDispatch_Case00_Sub02
    call FieldModeStateDispatch_Case00_Sub01
    call UpdatePlayerMovement
    call RunWC468ActionIfBit7
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_002_4B44
    call CheckInteractionInFront
    farcall FieldModeStateDispatch_Shared02
    farcall FieldModeStateDispatch_Shared03
    call FieldModeStateDispatch_Shared01
    xor a, a
    ldh [hFFCE], a
    farcall Func_002_64E5

Jump_002_4B44::
    farcall DrawFieldSprites
    farcall FieldStateCommonUpdate
    farcall RunFunc722AAnd6EB7
    call RunFieldEventWC90D
    call CallF072B4WhenWCE9DIs59
    ret

; entry 1 of the `rst $00` table in FieldModeStateDispatch
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptCommandType
FieldModeStateDispatch_Case01::
Jump_002_4B5D:: ; address name
    farcall RunEventScriptFrame
    farcall Func_002_69D0
    ld a, [wScriptCommandType]
    cp a, $05
    jr z, Jump_002_4B76
    cp a, $83
    jr z, Jump_002_4B76
    jr Jump_002_4B7C

Jump_002_4B76::
    call UpdatePlayerMovement
    call RunWC468ActionIfBit7

Jump_002_4B7C::
    farcall DrawFieldSprites
    farcall FieldStateCommonUpdate
    farcall RunFunc722AAnd6EB7
    call RunFieldEventWC90D
    call CallF072B4WhenWCE9DIs59
    ret

; entry 2 of the `rst $00` table in FieldModeStateDispatch
; no direct call (reached through a table, a jump or a vector)
FieldModeStateDispatch_Case02::
Jump_002_4B95:: ; address name
    call FieldModeStateDispatch_Case02_Sub01
    farcall DrawFieldSprites
    farcall FieldStateCommonUpdate
    farcall RunFunc722AAnd6EB7
    call RunFieldEventWC90D
    call CallF072B4WhenWCE9DIs59
    ret

; entry 3 of the `rst $00` table in FieldModeStateDispatch
; no direct call (reached through a table, a jump or a vector)
FieldModeStateDispatch_Case03::
Jump_002_4BB1:: ; address name
    farcall RunWC904Step
    farcall DrawFieldSprites
    farcall FieldStateCommonUpdate
    farcall RunFunc722AAnd6EB7
    call RunFieldEventWC90D
    ret

; entry 4 of the `rst $00` table in FieldModeStateDispatch
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState, wC8C5, wC8CA, wCD0D, wCD0E, wCC44
; writes: wC8FE, wCC44, wMapWidthScreens, wMapHeightScreens, wGameMode, wC5E0, wModeState, wC8C7
; points at: wModeChangeRequest, wC5E0
FieldModeStateDispatch_Case04::
Jump_002_4BCD:: ; address name
    farcall DrawFieldSprites
    farcall AdvanceHFF99AndRunHFF8BMode
    farcall RunFunc722AAnd6EB7
    call RunFieldEventWC90D
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, [wC8C5]
    and a, $7F
    jp nz, Jump_002_4C18
    ld a, $FF
    ld [wC8FE], a
    farcall FieldModeStateDispatch_Case04_Sub02
    ld a, [wC8CA]
    cp a, $F0
    jr nz, Jump_002_4C14
    push af
    ld a, $80
    ld [wCC44], a
    ld a, [wCD0D]
    ld [wMapWidthScreens], a
    ld a, [wCD0E]
    ld [wMapHeightScreens], a
    pop af

Jump_002_4C14::
    call FieldModeStateDispatch_Case04_Sub01
    ret

Jump_002_4C18::
    ld a, [wC8C5]
    bit 7, a
    jr z, Jump_002_4C3F
    ld a, $01
    ld [wGameMode], a
    ld hl, wModeChangeRequest
    inc [hl]
    xor a, a
    ld [wC5E0], a
    ld a, [wCC44]
    bit 7, a
    jr nz, Jump_002_4C39
    ld a, $00
    ld [wModeState], a
    ret

Jump_002_4C39::
    ld a, $05
    ld [wModeState], a
    ret

Jump_002_4C3F::
    ld hl, wC5E0
    inc [hl]
    call PlayMapMusic
    xor a, a
    ld [wC8C7], a
    call Func_002_4628
    ret

; only called from FieldModeStateDispatch_Case04 (E-0047)
; 1 call site from 1 routine (e.g. FieldModeStateDispatch_Case04)
; reads: wC8C6, wC957, hFF8C, wC936, wC8C8, wC8C9, hPlayerFacing, hPlayerX, ...
; writes: hPlayerFacing, wC957, wCC44, hFF8C, hMapId, hMapScreenX, hMapScreenY, hPlayerX, ...
; points at: wC8C5
FieldModeStateDispatch_Case04_Sub01::
Func_002_4C4E:: ; address name
    ld a, [wC8C6]
    or a, a
    jr z, Jump_002_4C57
    dec a
    ldh [hPlayerFacing], a

Jump_002_4C57::
    ld a, [wC957]
    or a, a
    jr z, Jump_002_4C82
    xor a, a
    ld [wC957], a
    ld de, $0025
    call TestFlagBit
    jr nc, Jump_002_4C6D
    ld a, $02
    ldh [hPlayerFacing], a

Jump_002_4C6D::
    xor a, a
    ld [wCC44], a
    ldh a, [hFF8C]
    and a, $B7
    ldh [hFF8C], a
    ld a, $05
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a, a
    ldh [hMapScreenY], a

Jump_002_4C82::
    ld a, [wC936]
    or a, a
    jr nz, Jump_002_4CDA
    ld a, [wC8C8]
    ldh [hPlayerX], a
    ld a, [wC8C9]
    ldh [hPlayerY], a
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords], a
    ld [wC8F4], a
    ld [wC8F9], a
    ldh a, [hPlayerX]
    ld [wC8F0], a
    ld [wC8F5], a
    ld [wC8FA], a
    ldh a, [hPlayerY]
    ld [wC8F1], a
    ld [wC8F6], a
    ld [wC8FB], a
    ldh a, [hFF8C]
    and a, $F9
    ldh [hFF8C], a
    ld hl, wC8C5
    inc [hl]
    ld a, [wCC44]
    bit 7, a
    ret nz
    ldh a, [hMapId]
    cp a, $05
    ret nz
    ldh a, [hFF8C]
    and a, $F7
    ldh [hFF8C], a
    xor a, a
    ld [wCC44], a
    xor a, a
    ldh [hFF93], a
    xor a, a
    ld [wC950], a
    ret

Jump_002_4CDA::
    ld a, [wC938]
    ldh [hPlayerX], a
    ld a, [wC939]
    ldh [hPlayerY], a
    ld a, [wC93A]
    ldh [hPlayerFacing], a
    ld a, [wC93B]
    ld [wFollowerRecords], a
    ld a, [wC93C]
    ld [wC8F0], a
    ld a, [wC93D]
    ld [wC8F1], a
    ld a, [wC93E]
    ld [wC8F4], a
    ld a, [wC93F]
    ld [wC8F5], a
    ld a, [wC940]
    ld [wC8F6], a
    ld a, [wC941]
    ld [wC8F9], a
    ld a, [wC942]
    ld [wC8FA], a
    ld a, [wC943]
    ld [wC8FB], a
    xor a, a
    ld [wC936], a
    ld hl, wC8C5
    inc [hl]
    ret

; entry 5 of the `rst $00` table in FieldModeStateDispatch
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState, wJoypadPressed, hFFC6
; writes: hFFCE
FieldModeStateDispatch_Case05::
Jump_002_4D28:: ; address name
    ld a, [wFadeState]
    or a, a
    jr nz, Jump_002_4D6D
    ld a, [wJoypadPressed]
    bit 2, a
    jr z, Jump_002_4D3F
    farcall FieldModeStateDispatch_Shared04
    ldh a, [hFFC6]
    or a, a
    ret nz

Jump_002_4D3F::
    call UpdatePlayerMovement
    call RunWC468ActionIfBit7
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_002_4D6D
    call FieldModeStateDispatch_Case05_Sub01
    farcall FieldModeStateDispatch_Shared02
    farcall FieldModeStateDispatch_Case05_Sub02
    farcall FieldModeStateDispatch_Shared03
    call FieldModeStateDispatch_Shared01
    xor a, a
    ldh [hFFCE], a
    farcall Func_002_64E5

Jump_002_4D6D::
    farcall DrawFieldSprites
    farcall FieldStateCommonUpdate
    farcall RunFunc722AAnd6EB7
    call RunFieldEventWC90D
    call CallF072B4WhenWCE9DIs59
    ret

; entry 6 of the `rst $00` table in FieldModeStateDispatch
; no direct call (reached through a table, a jump or a vector)
; reads: wC46C
FieldModeStateDispatch_Case06::
Jump_002_4D86:: ; address name
    farcall RunWC46BMenuState
    ld a, [wC46C]
    or a, a
    jr nz, Jump_002_4D98
    farcall FieldStateCommonUpdate

Jump_002_4D98::
    ret

; entry 7 of the `rst $00` table in FieldModeStateDispatch
; no direct call (reached through a table, a jump or a vector)
; reads: wModeState
; writes: wScriptRunning, wC8BF
FieldModeStateDispatch_Case07::
Jump_002_4D99:: ; address name
    farcall FieldModeStateDispatch_Case07_Sub01
    farcall FieldStateCommonUpdate
    farcall Func_012_722A
    ld a, [wModeState]
    cp a, $07
    ret z
    xor a, a
    ld [wScriptRunning], a
    farcall Func_00A_43EC
    farcall CheckStepTriggerAndDispatchTalk
    farcall Func_011_4130
    xor a, a
    ld [wC8BF], a
    ret

; entry 8 of the `rst $00` table in FieldModeStateDispatch
; no direct call (reached through a table, a jump or a vector)
FieldModeStateDispatch_Case08::
Jump_002_4DCC:: ; address name
    farcall RunWC5DDState
    call CallF072B4WhenWCE9DIs59
    ret

; when wCE9D = $3B and wCE9C = wCE9B = 0, far-calls Func_0F0_72B4 (E-0122)
; 5 call sites from 5 routines (e.g. FieldModeStateDispatch_Case08, FieldModeStateDispatch_Case05, FieldModeStateDispatch_Case02, FieldModeStateDispatch_Case01, ...)
; reads: wCE9D, wCE9C, wCE9B
CallF072B4WhenWCE9DIs59::
Func_002_4DD6:: ; address name
    ld a, [wCE9D]
    cp a, $3B
    ret nz
    ld a, [wCE9C]
    and a, a
    ret nz
    ld a, [wCE9B]
    and a, a
    ret nz
    farcall ClearWCEC2WhenWCE9DIs59
    ret

; only called from routines of FieldModeStateDispatch (E-0098)
; 2 call sites from 2 routines (e.g. FieldModeStateDispatch_Case05, FieldModeStateDispatch_Case00)
; reads: wC195, wFadeState, wC8CB, wC468, hFF8C, wJoypadPressed, hPlayerX, hPlayerY, ...
; writes: wC934
FieldModeStateDispatch_Shared01::
Func_002_4DED:: ; address name
    ld a, [wC195]
    or a, a
    ret z
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, [wC8CB]
    and a, $03
    ret nz
    ld a, [wC468]
    bit 7, a
    ret nz
    ldh a, [hFF8C]
    bit 0, a
    ret nz
    ld a, [wJoypadPressed]
    bit 0, a
    ret z
    ldh a, [hPlayerX]
    ld b, a
    ldh a, [hPlayerY]
    ld c, a
    ldh a, [hPlayerFacing]
    or a, a
    jr z, Jump_002_4E27
    dec a
    jr z, Jump_002_4E30
    dec a
    jr z, Jump_002_4E39
    ld a, b
    or a, a
    ret z
    sub a, $10
    ld b, a
    jr Jump_002_4E3F

Jump_002_4E27::
    ld a, c
    cp a, $80
    ret z
    add a, $10
    ld c, a
    jr Jump_002_4E3F

Jump_002_4E30::
    ld a, b
    cp a, $90
    ret z
    add a, $10
    ld b, a
    jr Jump_002_4E3F

Jump_002_4E39::
    ld a, c
    or a, a
    ret z
    sub a, $10
    ld c, a

Jump_002_4E3F::
    call TileBlockedAtPixel
    ld a, [wC195]
    and a, $F0
    jr z, Jump_002_4E59
    swap a
    call TestFlag1FAsBool
    or a, a
    jr z, Jump_002_4E59
    ld [wC934], a
    call FieldModeStateDispatch_Shared01_Sub02
    or a, a
    ret nz

Jump_002_4E59::
    ld a, [wC195]
    and a, $0F
    ret z
    ldh a, [hFF8C]
    bit 3, a
    jr nz, Jump_002_4E6D
    call FieldModeStateDispatch_Shared01_Sub01
    or a, a
    ret z
    ld [wC934], a

Jump_002_4E6D::
    call FieldModeStateDispatch_Shared01_Sub03
    ret

; A = 1 if story flag $1F is set, else 0 (E-0122)
; 1 call site from 1 routine (e.g. FieldModeStateDispatch_Shared01)
TestFlag1FAsBool::
Func_002_4E71:: ; address name
    ld de, $001F
    call TestFlagBit
    jr c, Jump_002_4E7B
    xor a, a
    ret

Jump_002_4E7B::
    ld a, $01
    ret

; only called from FieldModeStateDispatch_Shared01 (E-0047)
; 1 call site from 1 routine (e.g. FieldModeStateDispatch_Shared01)
; reads: wC195
FieldModeStateDispatch_Shared01_Sub01::
Func_002_4E7E:: ; address name
    ld a, [wC195]
    and a, $0F
    cp a, $01
    jr nz, Jump_002_4E91
    ld de, $001D
    call TestFlagBit
    jr c, Jump_002_4E9B
    jr Jump_002_4E99

Jump_002_4E91::
    ld de, $001E
    call TestFlagBit
    jr c, Jump_002_4E9B

Jump_002_4E99::
    xor a, a
    ret

Jump_002_4E9B::
    ld a, $01
    ret

; only called from FieldModeStateDispatch_Shared01 (E-0047)
; 1 call site from 1 routine (e.g. FieldModeStateDispatch_Shared01)
; reads: hFF8C, wC197, wC910, wC8CD
; writes: wC916, wC917, wJoypadHeld, wJoypadPressed
FieldModeStateDispatch_Shared01_Sub02::
Func_002_4E9E:: ; address name
    ldh a, [hFF8C]
    bit 3, a
    jr z, Jump_002_4EA6

Jump_002_4EA4::
    xor a, a
    ret

Jump_002_4EA6::
    ld a, [wC197]
    ld c, a
    ld a, [wC910]
    cp a, c
    jr nz, Jump_002_4EA4
    ld a, $02
    ld [wC916], a
    xor a, a
    ld [wC917], a
    farcall DispatchTalkEvent
    xor a, a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ld a, [wC8CD]
    bit 7, a
    jr z, Jump_002_4ED3
    farcall RedrawScreenBufferIfWC8CDBit7

Jump_002_4ED3::
    ld a, $01
    ret

; only called from FieldModeStateDispatch_Shared01 (E-0047)
; 1 call site from 1 routine (e.g. FieldModeStateDispatch_Shared01)
; reads: hFF8C, wC196, wC8CD, wMaxBlockingTile
; writes: wC916, wC917, wJoypadHeld, wJoypadPressed
; points at: wC910
FieldModeStateDispatch_Shared01_Sub03::
Func_002_4ED6:: ; address name
    ldh a, [hFF8C]
    bit 3, a
    jr nz, Jump_002_4F13
    ld de, wC910
    ld b, $04

Jump_002_4EE1::
    ld a, [de]
    inc de
    ld c, a
    ld a, [wC196]
    cp a, c
    jr c, Jump_002_4EEC
    jr Jump_002_4EF0

Jump_002_4EEC::
    dec b
    jr nz, Jump_002_4EE1
    ret

Jump_002_4EF0::
    ld a, $01
    ld [wC916], a
    xor a, a
    ld [wC917], a
    farcall DispatchTalkEvent
    xor a, a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ld a, [wC8CD]
    bit 7, a
    ret z
    farcall RedrawScreenBufferIfWC8CDBit7
    ret

Jump_002_4F13::
    ld de, wC910
    ld b, $04

Jump_002_4F18::
    ld a, [de]
    inc de
    ld c, a
    ld a, [wMaxBlockingTile]
    cp a, c
    jr c, Jump_002_4F23
    jr Jump_002_4F28

Jump_002_4F23::
    dec b
    jr nz, Jump_002_4F18
    jr Jump_002_4F29

Jump_002_4F28::
    ret

Jump_002_4F29::
    ld a, $01
    ld [wC916], a
    xor a, a
    ld [wC917], a
    farcall DispatchTalkEvent
    xor a, a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ld a, [wC8CD]
    bit 7, a
    ret z
    farcall RedrawScreenBufferIfWC8CDBit7
    ret

; only called from FieldModeStateDispatch_Case05 (E-0047)
; 1 call site from 1 routine (e.g. FieldModeStateDispatch_Case05)
; reads: wFadeState, wC8CB, wC468, hFF8C, wJoypadPressed, wCC44
FieldModeStateDispatch_Case05_Sub01::
Func_002_4F4C:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, [wC8CB]
    and a, $03
    ret nz
    ld a, [wC468]
    bit 7, a
    ret nz
    ldh a, [hFF8C]
    bit 0, a
    ret nz
    ld a, [wJoypadPressed]
    bit 0, a
    ret z
    ld a, [wCC44]
    and a, $07
    rst $00
    dw Func_002_4F4C_Case00
    dw Func_002_4F4C_Case00
    dw Func_002_4F4C_Case00
    dw Func_002_4F4C_Case03
    dw Func_002_4F4C_Case00
    dw Func_002_4F4C_Case00
    dw Func_002_4F4C_Case00
    dw Func_002_4F4C_Case07

; entry 0 of the `rst $00` table in Func_002_4F4C
; no direct call (reached through a table, a jump or a vector)
Func_002_4F4C_Case00::
Jump_002_4F7E:: ; address name
    ret

; entry 3 of the `rst $00` table in Func_002_4F4C
; no direct call (reached through a table, a jump or a vector)
; reads: wCC45, hPlayerFacing, hMapScreenY, hPlayerX, hPlayerY
; writes: wC8C7, wGameMode, wModeState, wC5DD, wJoypadHeld, wJoypadPressed
; points at: wCD89
Func_002_4F4C_Case03::
Jump_002_4F7F:: ; address name
    ld a, [wCC45]
    add a, a
    add a, a
    ld hl, wCD89
    add_a_to_hl
    ld a, [hl]
    cp a, $06
    jr z, Jump_002_4FAA
    cp a, $01
    ret nz
    ldh a, [hPlayerFacing]
    cp a, $02
    ret nz
    ldh a, [hMapScreenY]
    cp a, $01
    ret nz
    ldh a, [hPlayerX]
    cp a, $80
    ret nz
    ldh a, [hPlayerY]
    cp a, $10
    ret nz
    jr Jump_002_4FBC

Jump_002_4FAA::
    ret

; entry 7 of the `rst $00` table in Func_002_4F4C
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerFacing, hPlayerX, hPlayerY
; writes: wC8C7, wGameMode, wModeState, wC5DD, wJoypadHeld, wJoypadPressed
Func_002_4F4C_Case07::
Jump_002_4FAB:: ; address name
    ldh a, [hPlayerFacing]
    cp a, $02
    ret nz
    ldh a, [hPlayerX]
    cp a, $40
    ret nz
    ldh a, [hPlayerY]
    cp a, $40
    ret nz
    jr Jump_002_4FBC

Jump_002_4FBC::
    farcall SaveWCD07RecordToSRAMSlotWCC42
    call RedrawScreenBufferIfWC8CDBit7
    call SaveScreenBufferToBGMap1
    ld a, $01
    ld [wC8C7], a
    ld a, $69
    call QueueSoundEffect
    ld a, $02
    ld [wGameMode], a
    ld a, $0B
    ld [wModeState], a
    xor a, a
    ld [wC5DD], a
    xor a, a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ret

; when A is newly pressed and no fade, load or move is in progress: finds the position one step ahead of the player (hPlayerX or hPlayerY +/- 16 chosen by hPlayerFacing), looks it up with Func_002_59CD, and compares the result with the four ids at wC910 to pick an interaction
; 1 call site from 1 routine (e.g. FieldModeStateDispatch_Case00)
; reads: wC193, wFadeState, wC8CB, wC468, hFF8C, wJoypadPressed, hPlayerX, hPlayerY, ...
; writes: wC8C7, wGameMode, wModeState, wC5DD, wJoypadHeld, wJoypadPressed
; points at: wC910
CheckInteractionInFront::
Func_002_4FE8:: ; address name
    ld a, [wC193]
    or a, a
    ret z
    ld de, $0002
    call TestFlagBit
    ret nc
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, [wC8CB]
    and a, $03
    ret nz
    ld a, [wC468]
    bit 7, a
    ret nz
    ldh a, [hFF8C]
    bit 0, a
    ret nz
    ld a, [wJoypadPressed]
    bit 0, a
    ret z
    ldh a, [hPlayerX]
    ld b, a
    ldh a, [hPlayerY]
    ld c, a
    ldh a, [hPlayerFacing]
    or a, a
    jr z, Jump_002_5027
    dec a
    jr z, Jump_002_502D
    dec a
    jr z, Jump_002_5033
    ld a, b
    sub a, $10
    ld b, a
    jr Jump_002_5037

Jump_002_5027::
    ld a, c
    add a, $10
    ld c, a
    jr Jump_002_5037

Jump_002_502D::
    ld a, b
    add a, $10
    ld b, a
    jr Jump_002_5037

Jump_002_5033::
    ld a, c
    sub a, $10
    ld c, a

Jump_002_5037::
    call TileBlockedAtPixel
    ld de, wC910
    ld b, $04

Jump_002_503F::
    ld a, [de]
    inc de
    ld c, a
    ld a, [wC193]
    cp a, c
    jr nz, Jump_002_504A
    jr Jump_002_504E

Jump_002_504A::
    dec b
    jr nz, Jump_002_503F
    ret

Jump_002_504E::
    call RedrawScreenBufferIfWC8CDBit7
    call SaveScreenBufferToBGMap1
    ld a, $01
    ld [wC8C7], a
    ld a, $69
    call QueueSoundEffect
    ld a, $02
    ld [wGameMode], a
    ld a, $0B
    ld [wModeState], a
    xor a, a
    ld [wC5DD], a
    xor a, a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ret

; unless a fade runs or bit 7 of wC468 is set, runs the field event for wC90D & $0F (jump table of sixteen) (E-0124)
; 7 call sites from 7 routines (e.g. FieldModeStateDispatch_Case05, FieldModeStateDispatch_Case04, FieldModeStateDispatch_Case03, FieldModeStateDispatch_Case02, ...)
; reads: wFadeState, wC468, wC90D
RunFieldEventWC90D::
Func_002_5074:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, [wC468]
    bit 7, a
    ret nz
    ld a, [wC90D]
    and a, $0F
    rst $00
    dw RunFieldEventWC90D_Case00
    dw AnimateTilesByRotatingVTiles2
    dw AnimateTilesByRotatingVTiles2
    dw RunFieldEventWC90D_Case03
    dw RunFieldEventWC90D_Case04
    dw RunFieldEventWC90D_Case05
    dw RunFieldEventWC90D_Case06
    dw RunFieldEventWC90D_Case07
    dw RunFieldEventWC90D_Case08
    dw RunFieldEventWC90D_Case09
    dw RunFieldEventWC90D_Case0A
    dw RunFieldEventWC90D_Case0B
    dw RunFieldEventWC90D_Case0C
    dw RunFieldEventWC90D_Case0D
    dw RunFieldEventWC90D_Case0E
    dw RunFieldEventWC90D_Case0F

; entry 12 of the `rst $00` table in RunFieldEventWC90D
; no direct call (reached through a table, a jump or a vector)
RunFieldEventWC90D_Case0C::
Jump_002_50A5:: ; address name
    call RunFieldEventWC90D_Case0C_Sub01
    ret

; entry 8 of the `rst $00` table in RunFieldEventWC90D
; no direct call (reached through a table, a jump or a vector)
RunFieldEventWC90D_Case08::
Jump_002_50A9:: ; address name
    call RunFieldEventWC90D_Case08_Sub01
    ret

; entry 0 of the `rst $00` table in RunFieldEventWC90D
; no direct call (reached through a table, a jump or a vector)
RunFieldEventWC90D_Case00::
Jump_002_50AD:: ; address name
    ret

; every 8 frames rotates each byte pair of the first 16 tile rows at vTiles2 left by one bit (tile animation) (E-0124)
; 1 call site from 1 routine (e.g. RunFieldEventWC90D_Case05)
; reads: wFrameCounterLo, rSTAT
AnimateTilesByRotatingVTiles2::
Func_002_50AE:: ; address name
    ld a, [wFrameCounterLo]
    and a, $07
    ret nz
    ld hl, vTiles2
    ld b, $10

Jump_002_50B9::
    di
    call WaitForVRAMAccess
    ld a, [hl+]
    ld c, [hl]
    ei
    dec hl
    rlca
    rlc c
    push af
    di

Jump_002_50C6::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_002_50C6
    pop af
    ld [hl+], a
    ld [hl], c
    ei
    inc hl
    dec b
    jr nz, Jump_002_50B9
    ret

; entry 13 of the `rst $00` table in RunFieldEventWC90D
; no direct call (reached through a table, a jump or a vector)
; reads: wFrameCounterLo
RunFieldEventWC90D_Case0D::
Jump_002_50D5:: ; address name
    ld a, [wFrameCounterLo]
    and a, $07
    ret nz
    ld hl, vTiles2 + $A0
    ld b, $20

Jump_002_50E0::
    di
    call WaitForVRAMAccess
    ld a, [hl]
    ei
    rlca
    call WriteVRAMByteInc
    dec b
    jr nz, Jump_002_50E0
    ret

; entry 14 of the `rst $00` table in RunFieldEventWC90D
; no direct call (reached through a table, a jump or a vector)
; reads: wFrameCounterLo
RunFieldEventWC90D_Case0E::
Jump_002_50EE:: ; address name
    ld a, [wFrameCounterLo]
    and a, $07
    ret nz
    ld hl, vTiles2
    ld b, $30

Jump_002_50F9::
    di
    call WaitForVRAMAccess
    ld a, [hl]
    ei
    rlca
    call WriteVRAMByteInc
    dec b
    jr nz, Jump_002_50F9
    ld hl, vTiles2 + $30
    ld b, $30

Jump_002_510B::
    di
    call WaitForVRAMAccess
    ld a, [hl]
    ei
    rlca
    call WriteVRAMByteInc
    dec b
    jr nz, Jump_002_510B
    ret

; entry 3 of the `rst $00` table in RunFieldEventWC90D
; no direct call (reached through a table, a jump or a vector)
; reads: wFrameCounterLo
RunFieldEventWC90D_Case03::
Jump_002_5119:: ; address name
    ld a, [wFrameCounterLo]
    and a, $0F
    ret nz
    ld de, vTiles2 + $300
    ld hl, vTiles2 + $320
    jp Jump_002_51AD

; entry 4 of the `rst $00` table in RunFieldEventWC90D
; no direct call (reached through a table, a jump or a vector)
; reads: wFrameCounterLo
RunFieldEventWC90D_Case04::
Jump_002_5128:: ; address name
    ld a, [wFrameCounterLo]
    and a, $03
    ret nz
    ld de, vTiles2 + $280
    ld hl, vTiles2 + $2C0
    jr Jump_002_5176

; entry 5 of the `rst $00` table in RunFieldEventWC90D
; no direct call (reached through a table, a jump or a vector)
; reads: wFrameCounterLo
RunFieldEventWC90D_Case05::
Jump_002_5136:: ; address name
    call AnimateTilesByRotatingVTiles2
    ld a, [wFrameCounterLo]
    and a, $03
    ret nz
    ld de, vTiles2 + $140
    ld hl, vTiles2 + $180
    jr Jump_002_5176

; entry 9 of the `rst $00` table in RunFieldEventWC90D
; no direct call (reached through a table, a jump or a vector)
; reads: wFrameCounterLo
RunFieldEventWC90D_Case09::
Jump_002_5147:: ; address name
    ld a, [wFrameCounterLo]
    and a, $03
    ret nz
    ld de, vTiles2 + $280
    ld hl, vTiles2 + $2C0
    jr Jump_002_5176

; entry 10 of the `rst $00` table in RunFieldEventWC90D
; no direct call (reached through a table, a jump or a vector)
; reads: wFrameCounterLo
RunFieldEventWC90D_Case0A::
Jump_002_5155:: ; address name
    ld a, [wFrameCounterLo]
    and a, $03
    ret nz
    ld de, vTiles2 + $480
    ld hl, vTiles2 + $4C0
    jr Jump_002_5176

; entry 15 of the `rst $00` table in RunFieldEventWC90D
; no direct call (reached through a table, a jump or a vector)
; reads: hMapScreenX, wFrameCounterLo
RunFieldEventWC90D_Case0F::
Jump_002_5163:: ; address name
    ldh a, [hMapScreenX]
    cp a, $01
    ret z
    ld a, [wFrameCounterLo]
    and a, $03
    ret nz
    ld de, vTiles2
    ld hl, vTiles2 + $40
    jr Jump_002_5176

Jump_002_5176::
    ld a, [wFrameCounterLo]
    srl a
    srl a
    and a, $03
    swap a
    push af
    add_a_to_hl
    pop af
    add a, e
    ld e, a
    jr nc, Jump_002_518D
    inc d

Jump_002_518D::
    ld b, $10

Jump_002_518F::
    di
    call WaitForVRAMAccess
    ld a, [de]
    ld c, a
    ei
    di
    call WaitForVRAMAccess
    ld a, [hl]
    ei
    push af
    di
    call WaitForVRAMAccess
    pop af
    ld [de], a
    ei
    ld a, c
    call WriteVRAMByteInc
    inc de
    dec b
    jr nz, Jump_002_518F
    ret

Jump_002_51AD::
    ld a, [wFrameCounterLo]
    and a, $10
    push af
    add_a_to_hl
    pop af
    add a, e
    ld e, a
    jr nc, Jump_002_51BE
    inc d

Jump_002_51BE::
    ld b, $10

Jump_002_51C0::
    di
    call WaitForVRAMAccess
    ld a, [de]
    ld c, a
    ei
    di
    call WaitForVRAMAccess
    ld a, [hl]
    ei
    push af
    di
    call WaitForVRAMAccess
    ei
    pop af
    ld [de], a
    ld a, c
    call WriteVRAMByteInc
    inc de
    dec b
    jr nz, Jump_002_51C0
    ret

; entry 6 of the `rst $00` table in RunFieldEventWC90D
; no direct call (reached through a table, a jump or a vector)
; reads: wFrameCounterLo
RunFieldEventWC90D_Case06::
Jump_002_51DE:: ; address name
    ld de, $0043
    call TestFlagBit
    ret c
    ld a, [wFrameCounterLo]
    and a, $1F
    cp a, $0C
    ret nc
    sla a
    sla a
    ld hl, Data_002_5205
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl+]
    ld c, a
    ld a, [hl]
    ld h, a
    ld l, c
    jp Jump_002_52B8

Data_002_5205:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C0, $91, $E0, $91, $D0, $91, $F0, $91, $20, $92, $60, $92, $30, $92, $70, $92
    db $20, $93, $40, $93, $30, $93, $50, $93, $80, $93, $A0, $93, $90, $93, $B0, $93
    db $20, $94, $40, $94, $30, $94, $50, $94, $80, $94, $A0, $94, $90, $94, $B0, $94

; entry 7 of the `rst $00` table in RunFieldEventWC90D
; no direct call (reached through a table, a jump or a vector)
; reads: wFrameCounterLo
RunFieldEventWC90D_Case07::
Jump_002_5235:: ; address name
    ld a, [wFrameCounterLo]
    and a, $1F
    cp a, $0C
    ret nc
    sla a
    sla a
    ld hl, Data_002_5254
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl+]
    ld c, a
    ld a, [hl]
    ld h, a
    ld l, c
    jr Jump_002_52B8

Data_002_5254:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $30, $93, $50, $93, $40, $93, $60, $93, $20, $94, $40, $94, $30, $94, $50, $94
    db $C0, $94, $E0, $94, $D0, $94, $F0, $94, $60, $95, $80, $95, $70, $95, $90, $95
    db $20, $96, $60, $96, $30, $96, $70, $96, $A0, $96, $E0, $96, $B0, $96, $F0, $96

; entry 11 of the `rst $00` table in RunFieldEventWC90D
; no direct call (reached through a table, a jump or a vector)
; reads: hMapScreenY, wFrameCounterLo
RunFieldEventWC90D_Case0B::
Jump_002_5284:: ; address name
    ldh a, [hMapScreenY]
    or a, a
    ret nz
    ld a, [wFrameCounterLo]
    and a, $3F
    cp a, $04
    ret nc
    sla a
    sla a
    ld hl, Data_002_52A8
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl+]
    ld c, a
    ld a, [hl]
    ld h, a
    ld l, c
    jp Jump_002_52B8

Data_002_52A8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $E0, $94, $00, $95, $F0, $94, $10, $95, $40, $95, $60, $95, $50, $95, $70, $95

Jump_002_52B8::
    ld b, $10

Jump_002_52BA::
    di
    call WaitForVRAMAccess
    ld a, [de]
    ld c, a
    ei
    di
    call WaitForVRAMAccess
    ld a, [hl]
    ei
    push af
    di
    call WaitForVRAMAccess
    ei
    pop af
    ld [de], a
    ld a, c
    call WriteVRAMByteInc
    inc de
    dec b
    jr nz, Jump_002_52BA
    ret

; only called from RunFieldEventWC90D_Case08 (E-0047)
; 1 call site from 1 routine (e.g. RunFieldEventWC90D_Case08)
; reads: wScriptCommandType, wC936, wC46C, wC46B
; writes: wC46C, wC46B, hFFC6, wC526
; points at: wBGPaletteBuffer, wC0F0, wC0F8, wC4A7, wC100, wC4AF, wC108, wC4B7, ...
RunFieldEventWC90D_Case08_Sub01::
Func_002_52D8:: ; address name
    ld a, [wScriptCommandType]
    cp a, $ED
    ret z
    ld a, [wC936]
    and a, a
    ret nz
    ld a, [wC46C]
    bit 7, a
    jr nz, Jump_002_52FC
    ld a, $80
    ld [wC46C], a
    ld hl, wBGPaletteBuffer
    ld de, wC0F0
    ld bc, $0040
    call CopyBytes
    ret

Jump_002_52FC::
    ld a, [wC46B]
    inc a
    ld [wC46B], a
    and a, $07
    dec a
    ret nz
    ld a, [wC46B]
    srl a
    srl a
    srl a
    cp a, $08
    jr nz, Jump_002_5321
    ld a, [wC46C]
    inc a
    and a, $81
    ld [wC46C], a
    xor a, a
    ld [wC46B], a

Jump_002_5321::
    ldh [hFFC6], a
    ld hl, wC0F8
    ld de, wC4A7
    call RunFieldEventWC90D_Case08_Sub01_Sub01
    ld hl, wC100
    ld de, wC4AF
    ld hl, wC108
    ld de, wC4B7
    call RunFieldEventWC90D_Case08_Sub01_Sub01
    ld hl, wC110
    ld de, wC4BF
    call RunFieldEventWC90D_Case08_Sub01_Sub01
    ld a, $7F
    ld [wC526], a
    ret

; only called from RunFieldEventWC90D_Case08_Sub01 (E-0047)
; 3 call sites from 1 routine (e.g. RunFieldEventWC90D_Case08_Sub01)
; reads: hFFC6, wC46C, wD7C4, wD7C5, wD7C6
; writes: wD7C4, wD7C5, wD7C6
; points at: wD7C4
RunFieldEventWC90D_Case08_Sub01_Sub01::
Func_002_534A:: ; address name
    ld a, [hl]
    ld c, a
    inc hl
    ld a, [hl]
    ld b, a
    inc hl
    push bc
    ld a, b
    srl a
    srl a
    ld [wD7C4], a
    pop bc
    push bc
    sla c
    rl b
    sla c
    rl b
    sla c
    rl b
    ld a, b
    and a, $1F
    ld [wD7C5], a
    pop bc
    ld a, c
    and a, $1F
    ld [wD7C6], a
    push hl
    ld hl, Data_002_53C5
    ldh a, [hFFC6]
    add_a_to_hl
    ld a, [wC46C]
    bit 0, a
    jr z, Jump_002_538D
    ld a, $08
    add a, l
    ld l, a
    jr nc, Jump_002_538D
    inc h

Jump_002_538D::
    ld a, [hl]
    ld b, a
    ld hl, wD7C4
    ld c, $00

Jump_002_5394::
    ld a, [hl]
    add a, b
    bit 7, a
    jr z, Jump_002_539B
    xor a, a

Jump_002_539B::
    ld [hl+], a
    inc c
    ld a, c
    cp a, $03
    jr c, Jump_002_5394
    pop hl
    ld a, [wD7C4]
    ld b, a
    ld a, [wD7C5]
    sla a
    sla a
    sla a
    ld c, a
    sla c
    rl b
    sla c
    rl b
    ld a, [wD7C6]
    or a, c
    ld c, a
    ld a, c
    ld [de], a
    inc de
    ld a, b
    ld [de], a
    inc de
    ret

Data_002_53C5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $FC, $F8, $F4, $F0, $EC, $E8, $E4, $E4, $E8, $EC, $F0, $F4, $F8, $FC, $00

; only called from RunFieldEventWC90D_Case0C (E-0047)
; 1 call site from 1 routine (e.g. RunFieldEventWC90D_Case0C)
; reads: wC90E, wCD03, wC90F, wFrameCounterLo, hScrollX, wCD04
; writes: wC90E, hScrollX
RunFieldEventWC90D_Case0C_Sub01::
Func_002_53D5:: ; address name
    ld a, [wC90E]
    bit 7, a
    jr nz, Jump_002_53F0
    and a, $7F
    ld c, a
    ld a, [wCD03]
    and a, $7F
    cp a, c
    jr nz, Jump_002_53EC
    ld a, $80
    ld [wC90E], a

Jump_002_53EC::
    xor a, a
    ldh [hScrollX], a
    ret

Jump_002_53F0::
    ld a, [wC90F]
    or a, a
    jr nz, Jump_002_53EC
    ld a, [wFrameCounterLo]
    and a, $03
    bit 0, a
    jr nz, Jump_002_5408
    dec a
    sla a
    ld c, a
    ldh a, [hScrollX]
    add a, c
    ldh [hScrollX], a

Jump_002_5408::
    ld a, [wC90E]
    inc a
    ld [wC90E], a
    cp a, $BC
    ret nz
    ld a, [wCD04]
    and a, $7F
    ld [wC90E], a
    ret

; does nothing during a fade or while the map is loading; reads the D-pad (wJoypadHeld, wJoypadPressed), sets the facing hPlayerFacing and the move timer hFF9A, and starts or continues a step when the tile ahead is free (checks through Func_002_59CD, Func_002_5A51 and Func_002_5AB6)
; 12 call sites from 12 routines (e.g. FieldModeStateDispatch_Case05, FieldModeStateDispatch_Case01, FieldModeStateDispatch_Case00, ScriptCommand49_Run_Case01, ...)
; reads: wFadeState, hFF9A, hFF8C, wC468, wJoypadPressed, hPlayerFacing, hPlayerX, wScriptRunning, ...
; writes: hFF9A, hPlayerFacing, hFF8C, hFF9B, hFF9C, hMapScreenX, wC468, wC46A, ...
; points at: hFFF0, hMapScreenX, hMapScreenY, hFF80, hFFF8
UpdatePlayerMovement::
Func_002_541B:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ldh a, [hFF9A]
    or a, a
    jr z, Jump_002_542C
    dec a
    ldh [hFF9A], a
    call RedrawScreenBufferIfWC8CDBit7
    ret

Jump_002_542C::
    ldh a, [hFF8C]
    bit 0, a
    jp nz, UpdatePlayerMovement_Sub01
    ld a, [wC468]
    bit 7, a
    ret nz
    ldh a, [hFF8C]
    bit 6, a
    jp nz, Jump_002_556F
    ld a, [wJoypadPressed]
    bit 5, a
    jr z, Jump_002_5459
    ldh a, [hPlayerFacing]
    cp a, $03
    jr z, Jump_002_5460

Jump_002_544D::
    ld a, $03
    ldh [hPlayerFacing], a
    ld a, $04
    ldh [hFF9A], a
    call RedrawScreenBufferIfWC8CDBit7
    ret

Jump_002_5459::
    ld a, [wJoypadHeld]
    bit 5, a
    jr z, Jump_002_54D7

Jump_002_5460::
    ld a, $03
    ldh [hPlayerFacing], a
    ldh a, [hPlayerX]
    or a, a
    jr z, Jump_002_54A0
    ld a, [wScriptRunning]
    or a, a
    jr nz, Jump_002_548A
    ldh a, [hPlayerX]
    sub a, $10
    ld b, a
    ldh a, [hPlayerY]
    ld c, a
    call TileBlockedAtPixel
    cp a, $01
    jr z, Jump_002_544D
    call FindSpriteSlotAtTile
    or a, a
    jr nz, Jump_002_544D
    call UpdatePlayerMovement_Sub02
    or a, a
    jr nz, Jump_002_544D

Jump_002_548A::
    ldh a, [hFF8C]
    or a, $05
    ldh [hFF8C], a
    ld hl, hFFF0
    ld a, l
    ldh [hFF9B], a
    ld a, h
    ldh [hFF9C], a
    call SetFollowerTargetsFromLeader
    call UpdatePlayerMovement_Sub01
    ret

Jump_002_54A0::
    ldh a, [hFF8C]
    or a, $05
    ldh [hFF8C], a
    ld hl, hMapScreenX
    dec [hl]
    farcall CheckWarpAtPlayer
    bit 0, c
    jr nz, Jump_002_544D
    ldh a, [hMapScreenX]
    cp a, $FF
    jr nz, Jump_002_54C0
    ld a, [wMapWidthScreens]
    dec a
    ldh [hMapScreenX], a

Jump_002_54C0::
    ld a, $80
    ld [wC468], a
    ld a, $01
    ld [wC46A], a
    ld hl, $0090
    ld a, l
    ldh [hFF9B], a
    ld a, h
    ldh [hFF9C], a
    call UpdatePlayerMovement_Sub01
    ret

Jump_002_54D7::
    ld a, [wJoypadPressed]
    bit 4, a
    jr z, Jump_002_54F0
    ldh a, [hPlayerFacing]
    cp a, $01
    jr z, Jump_002_54F7

Jump_002_54E4::
    ld a, $01
    ldh [hPlayerFacing], a
    ld a, $04
    ldh [hFF9A], a
    call RedrawScreenBufferIfWC8CDBit7
    ret

Jump_002_54F0::
    ld a, [wJoypadHeld]
    bit 4, a
    jr z, Jump_002_556F

Jump_002_54F7::
    ld a, $01
    ldh [hPlayerFacing], a
    ldh a, [hPlayerX]
    cp a, $90
    jr z, Jump_002_5538
    ld a, [wScriptRunning]
    or a, a
    jr nz, Jump_002_5522
    ldh a, [hPlayerX]
    add a, $11
    ld b, a
    ldh a, [hPlayerY]
    ld c, a
    call TileBlockedAtPixel
    cp a, $01
    jr z, Jump_002_54E4
    call FindSpriteSlotAtTile
    or a, a
    jr nz, Jump_002_54E4
    call UpdatePlayerMovement_Sub02
    or a, a
    jr nz, Jump_002_54E4

Jump_002_5522::
    ldh a, [hFF8C]
    or a, $05
    ldh [hFF8C], a
    ld hl, $0010
    ld a, l
    ldh [hFF9B], a
    ld a, h
    ldh [hFF9C], a
    call SetFollowerTargetsFromLeader
    call UpdatePlayerMovement_Sub01
    ret

Jump_002_5538::
    ldh a, [hFF8C]
    or a, $05
    ldh [hFF8C], a
    ld hl, hMapScreenX
    inc [hl]
    farcall CheckWarpAtPlayer
    bit 0, c
    jr nz, Jump_002_54E4
    ld a, [wMapWidthScreens]
    ld c, a
    ldh a, [hMapScreenX]
    cp a, c
    jr nz, Jump_002_5558
    xor a, a
    ldh [hMapScreenX], a

Jump_002_5558::
    ld a, $80
    ld [wC468], a
    ld a, $02
    ld [wC46A], a
    ld hl, rSVBK
    ld a, l
    ldh [hFF9B], a
    ld a, h
    ldh [hFF9C], a
    call UpdatePlayerMovement_Sub01
    ret

Jump_002_556F::
    ld a, [wJoypadPressed]
    bit 7, a
    jr z, Jump_002_5588
    ldh a, [hPlayerFacing]
    cp a, $00
    jr z, Jump_002_5590

Jump_002_557C::
    ld a, $00
    ldh [hPlayerFacing], a
    ld a, $04
    ldh [hFF9A], a
    call RedrawScreenBufferIfWC8CDBit7
    ret

Jump_002_5588::
    ld a, [wJoypadHeld]
    bit 7, a
    jp z, Jump_002_562C

Jump_002_5590::
    ld a, $00
    ldh [hPlayerFacing], a
    farcall CheckWarpAtPlayer
    bit 0, c
    jr nz, Jump_002_557C
    ldh a, [hPlayerY]
    cp a, $80
    jr z, Jump_002_55EA
    ldh a, [hFF8C]
    bit 6, a
    jr nz, Jump_002_55CB
    ld a, [wScriptRunning]
    or a, a
    jr nz, Jump_002_55CB
    ldh a, [hPlayerX]
    ld b, a
    ldh a, [hPlayerY]
    add a, $11
    ld c, a
    call TileBlockedAtPixel
    cp a, $01
    jr z, Jump_002_557C
    call FindSpriteSlotAtTile
    or a, a
    jr nz, Jump_002_557C
    call UpdatePlayerMovement_Sub02
    or a, a
    jr nz, Jump_002_557C

Jump_002_55CB::
    ldh a, [hFF8C]
    or a, $05
    ldh [hFF8C], a
    ld hl, $0010
    ldh a, [hFF8C]
    bit 6, a
    jr z, Jump_002_55DD
    ld hl, $0008

Jump_002_55DD::
    ld a, l
    ldh [hFF9D], a
    ld a, h
    ldh [hFF9E], a
    call SetFollowerTargetsFromLeader
    call UpdatePlayerMovement_Sub01
    ret

Jump_002_55EA::
    ldh a, [hFF8C]
    or a, $05
    ldh [hFF8C], a
    ld hl, hMapScreenY
    inc [hl]
    farcall CheckWarpAtPlayer
    bit 0, c
    jp nz, Jump_002_557C
    farcall WarpToLinkedMapForCurrentMap
    bit 0, c
    jp nz, Jump_002_557C
    ld a, [wMapHeightScreens]
    ld c, a
    ldh a, [hMapScreenY]
    cp a, c
    jr nz, Jump_002_5616
    xor a, a
    ldh [hMapScreenY], a

Jump_002_5616::
    ld a, $80
    ld [wC468], a
    ld a, $08
    ld [wC46A], a
    ld hl, hFF80
    ld a, l
    ldh [hFF9D], a
    ld a, h
    ldh [hFF9E], a
    call UpdatePlayerMovement_Sub01

Jump_002_562C::
    ld a, [wJoypadPressed]
    bit 6, a
    jr z, Jump_002_5645
    ldh a, [hPlayerFacing]
    cp a, $02
    jr z, Jump_002_564B

Jump_002_5639::
    ld a, $02
    ldh [hPlayerFacing], a
    ld a, $04
    ldh [hFF9A], a
    call RedrawScreenBufferIfWC8CDBit7
    ret

Jump_002_5645::
    ld a, [wJoypadHeld]
    bit 6, a
    ret z

Jump_002_564B::
    ld a, $02
    ldh [hPlayerFacing], a
    ldh a, [hPlayerY]
    or a, a
    jr z, Jump_002_56A4
    farcall CheckWarpAtPlayer
    bit 0, c
    jr nz, Jump_002_5639
    ldh a, [hFF8C]
    bit 6, a
    jr nz, Jump_002_5685
    ld a, [wScriptRunning]
    or a, a
    jr nz, Jump_002_5685
    ldh a, [hPlayerX]
    ld b, a
    ldh a, [hPlayerY]
    sub a, $10
    ld c, a
    call TileBlockedAtPixel
    cp a, $01
    jr z, Jump_002_5639
    call FindSpriteSlotAtTile
    or a, a
    jr nz, Jump_002_5639
    call UpdatePlayerMovement_Sub02
    or a, a
    jr nz, Jump_002_5639

Jump_002_5685::
    ldh a, [hFF8C]
    or a, $05
    ldh [hFF8C], a
    ld hl, hFFF0
    ldh a, [hFF8C]
    bit 6, a
    jr z, Jump_002_5697
    ld hl, hFFF8

Jump_002_5697::
    ld a, l
    ldh [hFF9D], a
    ld a, h
    ldh [hFF9E], a
    call SetFollowerTargetsFromLeader
    call UpdatePlayerMovement_Sub01
    ret

Jump_002_56A4::
    ldh a, [hFF8C]
    or a, $05
    ldh [hFF8C], a
    ld hl, hMapScreenY
    dec [hl]
    farcall CheckWarpAtPlayer
    bit 0, c
    jp nz, Jump_002_5639
    ldh a, [hMapScreenY]
    cp a, $FF
    jr nz, Jump_002_56C5
    ld a, [wMapHeightScreens]
    dec a
    ldh [hMapScreenY], a

Jump_002_56C5::
    ld a, $80
    ld [wC468], a
    ld a, $04
    ld [wC46A], a
    ld hl, $0080
    ld a, l
    ldh [hFF9D], a
    ld a, h
    ldh [hFF9E], a
    call UpdatePlayerMovement_Sub01
    ret

; only called from UpdatePlayerMovement (E-0047)
; 8 call sites from 1 routine (e.g. UpdatePlayerMovement)
; reads: hFF9B, hFF9C, hFF9D, hFF9E, hFF8C, wC468, hPlayerY, wC8F1, ...
; writes: hFF8C, wC918, hFF9D, hFF9E, wC955, hPlayerY, wC8F1, wC8F6, ...
; points at: hPlayerY, hPlayerX
UpdatePlayerMovement_Sub01::
Func_002_56DC:: ; address name
    call RedrawScreenBufferIfWC8CDBit7
    ldh a, [hFF9B]
    ld l, a
    ldh a, [hFF9C]
    ld h, a
    ld a, h
    or a, l
    jr nz, Jump_002_5700
    ldh a, [hFF9D]
    ld l, a
    ldh a, [hFF9E]
    ld h, a
    ld a, h
    or a, l
    jr nz, Jump_002_5700
    ldh a, [hFF8C]
    and a, $FE
    ldh [hFF8C], a
    xor a, a
    ld [wC918], a
    jp Jump_002_58BF

Jump_002_5700::
    ldh a, [hFF9B]
    ld l, a
    ldh a, [hFF9C]
    ld h, a
    bit 7, h
    jr nz, Jump_002_5729
    ld a, h
    or a, l
    jr nz, Jump_002_5784
    ldh a, [hFF9D]
    ld l, a
    ldh a, [hFF9E]
    ld h, a
    bit 7, h
    jp nz, Jump_002_57E0
    ld a, h
    or a, l
    jp nz, Jump_002_583A
    ldh a, [hFF8C]
    and a, $FA
    ldh [hFF8C], a
    xor a, a
    ld [wC918], a
    ret

Jump_002_5729::
    ld a, [wC468]
    bit 7, a
    jr nz, Jump_002_5747
    call StepFollowersTowardTargets
    ldh a, [hFF9B]
    ld l, a
    ldh a, [hFF9C]
    ld h, a
    inc hl
    ld a, l
    ldh [hFF9B], a
    ld a, h
    ldh [hFF9C], a
    ld hl, hPlayerX
    dec [hl]
    jp Jump_002_5892

Jump_002_5747::
    call UpdatePlayerMovement_Sub01_Sub01
    ldh a, [hFF9B]
    ld l, a
    ldh a, [hFF9C]
    ld h, a
    ld a, $08
    add_a_to_hl
    ld a, l
    ldh [hFF9B], a
    ld a, h
    ldh [hFF9C], a
    ldh a, [hPlayerX]
    sub a, $08
    ldh [hPlayerX], a
    ld a, [wC8F0]
    sub a, $08
    ld [wC8F0], a
    ld a, [wC8F5]
    sub a, $08
    ld [wC8F5], a
    ld a, [wC8FA]
    sub a, $08
    ld [wC8FA], a
    call SetFollowerTargetsFromLeader
    call StepFollowersTowardTargets
    jp Jump_002_5892

Jump_002_5784::
    ld a, [wC468]
    bit 7, a
    jr nz, Jump_002_57A2
    call StepFollowersTowardTargets
    ldh a, [hFF9B]
    ld l, a
    ldh a, [hFF9C]
    ld h, a
    dec hl
    ld a, l
    ldh [hFF9B], a
    ld a, h
    ldh [hFF9C], a
    ld hl, hPlayerX
    inc [hl]
    jp Jump_002_5892

Jump_002_57A2::
    call UpdatePlayerMovement_Sub01_Sub01
    ldh a, [hFF9B]
    ld l, a
    ldh a, [hFF9C]
    ld h, a
    ld a, l
    sub a, $08
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld a, l
    ldh [hFF9B], a
    ld a, h
    ldh [hFF9C], a
    ldh a, [hPlayerX]
    add a, $08
    ldh [hPlayerX], a
    ld a, [wC8F0]
    add a, $08
    ld [wC8F0], a
    ld a, [wC8F5]
    add a, $08
    ld [wC8F5], a
    ld a, [wC8FA]
    add a, $08
    ld [wC8FA], a
    call SetFollowerTargetsFromLeader
    call StepFollowersTowardTargets
    jp Jump_002_5892

Jump_002_57E0::
    ld a, [wC468]
    bit 7, a
    jr nz, Jump_002_57FE
    call StepFollowersTowardTargets
    ldh a, [hFF9D]
    ld l, a
    ldh a, [hFF9E]
    ld h, a
    inc hl
    ld a, l
    ldh [hFF9D], a
    ld a, h
    ldh [hFF9E], a
    ld hl, hPlayerY
    dec [hl]
    jp Jump_002_5892

Jump_002_57FE::
    call UpdatePlayerMovement_Sub01_Sub01
    ldh a, [hFF9D]
    ld l, a
    ldh a, [hFF9E]
    ld h, a
    ld a, $08
    add_a_to_hl
    ld a, l
    ldh [hFF9D], a
    ld a, h
    ldh [hFF9E], a
    ldh a, [hPlayerY]
    sub a, $08
    ldh [hPlayerY], a
    ld a, [wC8F1]
    sub a, $08
    ld [wC8F1], a
    ld a, [wC8F6]
    sub a, $08
    ld [wC8F6], a
    ld a, [wC8FB]
    sub a, $08
    ld [wC8FB], a
    call SetFollowerTargetsFromLeader
    call StepFollowersTowardTargets
    jr Jump_002_5892

Jump_002_583A::
    ld a, [wC468]
    bit 7, a
    jr nz, Jump_002_5857
    call StepFollowersTowardTargets
    ldh a, [hFF9D]
    ld l, a
    ldh a, [hFF9E]
    ld h, a
    dec hl
    ld a, l
    ldh [hFF9D], a
    ld a, h
    ldh [hFF9E], a
    ld hl, hPlayerY
    inc [hl]
    jr Jump_002_5892

Jump_002_5857::
    call UpdatePlayerMovement_Sub01_Sub01
    ldh a, [hFF9D]
    ld l, a
    ldh a, [hFF9E]
    ld h, a
    ld a, l
    sub a, $08
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld a, l
    ldh [hFF9D], a
    ld a, h
    ldh [hFF9E], a
    ldh a, [hPlayerY]
    add a, $08
    ldh [hPlayerY], a
    ld a, [wC8F1]
    add a, $08
    ld [wC8F1], a
    ld a, [wC8F6]
    add a, $08
    ld [wC8F6], a
    ld a, [wC8FB]
    add a, $08
    ld [wC8FB], a
    call SetFollowerTargetsFromLeader
    call StepFollowersTowardTargets

Jump_002_5892::
    ldh a, [hFF9B]
    ld l, a
    ldh a, [hFF9C]
    ld h, a
    ld a, h
    or a, l
    ret nz
    ldh a, [hFF9D]
    ld l, a
    ldh a, [hFF9E]
    ld h, a
    ld a, h
    or a, l
    ret nz
    ld a, $01
    ld [wC955], a
    ldh a, [hFF8C]
    bit 6, a
    jr z, Jump_002_58B1
    and a, $7F

Jump_002_58B1::
    and a, $BA
    ldh [hFF8C], a
    ld a, [wC468]
    bit 7, a
    ret nz
    xor a, a
    ld [wC918], a

Jump_002_58BF::
    farcall UpdatePlayerMovement_Sub01_Sub02
    farcall Func_00A_561E
    farcall Func_012_75E0
    farcall UpdatePlayerMovement_Sub01_Sub03
    farcall Func_00A_43EC
    farcall CheckStepTriggerAndDispatchTalk
    farcall Func_011_4130
    farcall RunPlayerMoveTypeWC194
    farcall Func_00A_42BC
    farcall CountDownWD069ThenDispatchTalkEvent
    ret

; only called from UpdatePlayerMovement_Sub01 (E-0047)
; 4 call sites from 1 routine (e.g. UpdatePlayerMovement_Sub01)
; reads: wC94D, hPlayerFacing, hPlayerX, hPlayerY
; writes: wFollowerRecords, wC8F4, wC8F9, wC8F0, wC8F5, wC8FA, wC8F1, wC8F6, ...
UpdatePlayerMovement_Sub01_Sub01::
Func_002_58FC:: ; address name
    ld a, [wC94D]
    or a, a
    ret z
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords], a
    ld [wC8F4], a
    ld [wC8F9], a
    ldh a, [hPlayerX]
    ld [wC8F0], a
    ld [wC8F5], a
    ld [wC8FA], a
    ldh a, [hPlayerY]
    ld [wC8F1], a
    ld [wC8F6], a
    ld [wC8FB], a
    ret

; the three 5-byte follower records at wFollowerRecords hold direction, X, Y, target X, target Y: record 0's target = hPlayerX/hPlayerY, record 1's target = record 0's position, record 2's target = record 1's position (E-0093)
; 12 call sites from 6 routines (e.g. UpdatePlayerMovement, UpdatePlayerMovement_Sub01, UpdateFollowersOnStep_Bank0F, ScriptStepMoveFollowersToLeader, ...)
; reads: hPlayerX, hPlayerY, wC8F0, wC8F1, wC8F5, wC8F6
; writes: wC8F2, wC8F3, wC8F7, wC8F8, wC8FC, wC8FD
SetFollowerTargetsFromLeader::
Func_002_5923:: ; address name
    ldh a, [hPlayerX]
    ld [wC8F2], a
    ldh a, [hPlayerY]
    ld [wC8F3], a
    ld a, [wC8F0]
    ld [wC8F7], a
    ld a, [wC8F1]
    ld [wC8F8], a
    ld a, [wC8F5]
    ld [wC8FC], a
    ld a, [wC8F6]
    ld [wC8FD], a
    ret

; unless wC94D is non-zero, moves each of the three follower records one pixel toward its target (four pixels when wC468 bit 7 is set), X first and then Y, storing the direction moved in byte 0 (1 = X increasing, 3 = X decreasing; Y directions not read to the end) (E-0093)
; 12 call sites from 5 routines (e.g. UpdatePlayerMovement_Sub01, UpdateFollowersOnStep_Bank0F, ScriptStepMoveFollowersToLeader, UpdateFollowersOnStep_Bank12, ...)
; reads: wC94D, wC468
; points at: wFollowerRecords, wC8F2
StepFollowersTowardTargets::
Func_002_5946:: ; address name
    ld a, [wC94D]
    or a, a
    ret nz
    ld b, $03
    ld hl, wFollowerRecords
    ld de, wC8F2

Jump_002_5953::
    push hl
    push de
    inc hl
    ld a, [hl-]
    ld c, a
    ld a, [de]
    cp a, c
    jr z, Jump_002_5986
    jr nc, Jump_002_5972
    ld a, $03
    ld [hl+], a
    ld a, c
    dec a
    push af
    ld a, [wC468]
    ld c, a
    pop af
    bit 7, c
    jr z, Jump_002_596F
    sub a, $03

Jump_002_596F::
    ld [hl], a
    jr Jump_002_59B9

Jump_002_5972::
    ld a, $01
    ld [hl+], a
    ld a, c
    inc a
    push af
    ld a, [wC468]
    ld c, a
    pop af
    bit 7, c
    jr z, Jump_002_5983
    add a, $03

Jump_002_5983::
    ld [hl], a
    jr Jump_002_59B9

Jump_002_5986::
    inc hl
    inc hl
    ld a, [hl]
    ld c, a
    inc de
    ld a, [de]
    cp a, c
    jr z, Jump_002_59B9
    jr nc, Jump_002_59A6
    ld a, c
    dec a
    push af
    ld a, [wC468]
    ld c, a
    pop af
    bit 7, c
    jr z, Jump_002_599F
    sub a, $03

Jump_002_599F::
    ld [hl], a
    dec hl
    dec hl
    ld [hl], $02
    jr Jump_002_59B9

Jump_002_59A6::
    ld a, c
    inc a
    push af
    ld a, [wC468]
    ld c, a
    pop af
    bit 7, c
    jr z, Jump_002_59B4
    add a, $03

Jump_002_59B4::
    ld [hl], a
    dec hl
    dec hl
    ld [hl], $00

Jump_002_59B9::
    pop de
    pop hl
    ld a, $05
    add_a_to_hl
    ld a, $05
    add a, e
    ld e, a
    jr nc, Jump_002_59C9
    inc d

Jump_002_59C9::
    dec b
    jr nz, Jump_002_5953
    ret

; B = X, C = Y in pixels: copies the four tile ids of the 2 x 2 block at tile (X / 8, Y / 8) of wScreenTileBuffer (rows of 20) to wC910-wC913; returns A = 1 when any of them is at most wC192, else A = 0 (a different pair of comparisons with wC196 runs when hFF8C bit 3 is set)
; 6 call sites from 3 routines (e.g. FieldModeStateDispatch_Shared01, CheckInteractionInFront, UpdatePlayerMovement)
; reads: hFF8C, wMaxBlockingTile, wC196
; writes: wC910, wC911, wC912, wC913
; points at: wC910
TileBlockedAtPixel::
Func_002_59CD:: ; address name
    push bc
    push de
    ldh a, [hFF8C]
    bit 3, a
    jr nz, Jump_002_59D5

Jump_002_59D5::
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
    ld a, l
    add a, $98
    ld l, a
    ld a, h
    adc a, $C1
    ld h, a
    ld a, [hl+]
    ld [wC910], a
    ld a, [hl-]
    ld [wC911], a
    ld a, $14
    add_a_to_hl
    ld a, [hl+]
    ld [wC912], a
    ld a, [hl]
    ld [wC913], a
    ldh a, [hFF8C]
    bit 3, a
    jr nz, Jump_002_5A35
    ld de, wC910
    ld b, $04

Jump_002_5A1E::
    ld a, [de]
    inc de
    ld c, a
    ld a, [wMaxBlockingTile]
    cp a, c
    jr c, Jump_002_5A29
    jr Jump_002_5A30

Jump_002_5A29::
    dec b
    jr nz, Jump_002_5A1E
    xor a, a
    pop de
    pop bc
    ret

Jump_002_5A30::
    ld a, $01
    pop de
    pop bc
    ret

Jump_002_5A35::
    ld de, wC910
    ld b, $02

Jump_002_5A3A::
    ld a, [de]
    inc de
    ld c, a
    ld a, [wC196]
    cp a, c
    jr nc, Jump_002_5A45
    jr Jump_002_5A4C

Jump_002_5A45::
    dec b
    jr nz, Jump_002_5A3A
    xor a, a
    pop de
    pop bc
    ret

Jump_002_5A4C::
    ld a, $01
    pop de
    pop bc
    ret

; B = X, C = Y in pixels: returns A = the 1-based number of the first slot of wSpriteSlots (from wCB8A, count wSpriteSlotCount) whose X and Y bytes, or those plus 15, lie in the same 16-pixel cell as (B, C); A = 0 when none does
; 4 call sites from 1 routine (e.g. UpdatePlayerMovement)
; reads: wSpriteSlotCount, hFFC7, hFFC6
; writes: hFFC6, hFFC7
; points at: wCB8A
FindSpriteSlotAtTile::
Func_002_5A51:: ; address name
    ld a, [wSpriteSlotCount]
    or a, a
    ret z
    push bc
    ld a, c
    swap a
    and a, $0F
    ldh [hFFC6], a
    ld a, b
    swap a
    and a, $0F
    ldh [hFFC7], a
    ld a, [wSpriteSlotCount]
    ld b, a
    ld c, $01
    ld hl, wCB8A

Jump_002_5A6E::
    push hl
    push bc
    ld a, [hl]
    swap a
    and a, $0F
    ld c, a
    ldh a, [hFFC7]
    cp a, c
    jr z, Jump_002_5A88
    ld a, [hl]
    add a, $0F
    swap a
    and a, $0F
    ld c, a
    ldh a, [hFFC7]
    cp a, c
    jr nz, Jump_002_5AA1

Jump_002_5A88::
    inc hl
    ld a, [hl]
    swap a
    and a, $0F
    ld c, a
    ldh a, [hFFC6]
    cp a, c
    jr z, Jump_002_5AB1
    ld a, [hl]
    add a, $0F
    swap a
    and a, $0F
    ld c, a
    ldh a, [hFFC6]
    cp a, c
    jr z, Jump_002_5AB1

Jump_002_5AA1::
    pop bc
    inc c
    pop hl
    ld a, $10
    add_a_to_hl
    dec b
    jr nz, Jump_002_5A6E
    xor a, a
    pop bc
    ret

Jump_002_5AB1::
    pop bc
    pop hl
    ld a, c
    pop bc
    ret

; only called from UpdatePlayerMovement (E-0047)
; 4 call sites from 1 routine (e.g. UpdatePlayerMovement)
; reads: wC8FE, wCC44, wC8FF
UpdatePlayerMovement_Sub02::
Func_002_5AB6:: ; address name
    push bc
    ld a, [wC8FE]
    cp a, $02
    jr z, Jump_002_5AC5
    cp a, $03
    jr z, Jump_002_5AC5

Jump_002_5AC2::
    xor a, a
    pop bc
    ret

Jump_002_5AC5::
    ld a, b
    swap a
    and a, $0F
    ld b, a
    ld a, c
    swap a
    and a, $0F
    ld c, a
    ld a, [wCC44]
    bit 7, a
    jr nz, Jump_002_5AEE

Jump_002_5AD8::
    ld a, [wC8FF]
    swap a
    and a, $0F
    cp a, b
    jr nz, Jump_002_5AC2
    ld a, [wC8FF]
    and a, $0F
    cp a, c
    jr nz, Jump_002_5AC2
    ld a, $01
    pop bc
    ret

Jump_002_5AEE::
    cp a, $85
    jr z, Jump_002_5AD8
    ld a, [wC8FF]
    add a, a
    ld hl, Data_002_5B0A
    add_a_to_hl
    ld a, [hl+]
    cp a, b
    jr nz, Jump_002_5AC2
    ld a, [hl]
    cp a, c
    jr nz, Jump_002_5AC2
    ld a, $01
    pop bc
    ret

Data_002_5B0A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $02, $01, $07, $02, $01, $02, $04, $02, $06, $03, $03, $04, $05, $04, $07
    db $05, $01, $05, $03, $06, $05, $07, $02, $07, $04, $07, $07, $08, $01, $08, $06

; only called from FieldModeStateDispatch_Case00 (E-0047)
; 1 call site from 1 routine (e.g. FieldModeStateDispatch_Case00)
; reads: wFadeState, hFF8C, wJoypadHeld, hMapScreenX, hMapScreenY, hMapId, hPlayerX, hPlayerY
; writes: wC916, wC917, wJoypadHeld, wJoypadPressed
FieldModeStateDispatch_Case00_Sub01::
Func_002_5B2A:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ldh a, [hFF8C]
    bit 0, a
    ret nz
    ld a, [wJoypadHeld]
    bit 7, a
    ret z
    ldh a, [hMapScreenX]
    swap a
    ld d, a
    ldh a, [hMapScreenY]
    or a, d
    ld d, a
    ldh a, [hMapId]
    ld e, a
    ld hl, Data_002_5B89
    ld b, $00

Jump_002_5B4B::
    push hl
    ld a, [hl+]
    cp a, $FF
    jr nz, Jump_002_5B53
    pop hl
    ret

Jump_002_5B53::
    cp a, e
    jr nz, Jump_002_5B81
    ld a, [hl+]
    cp a, d
    jr nz, Jump_002_5B81
    ld a, [hl+]
    ld c, a
    ldh a, [hPlayerX]
    cp a, c
    jr nz, Jump_002_5B81
    ld a, [hl]
    ld c, a
    ldh a, [hPlayerY]
    cp a, c
    jr nz, Jump_002_5B81
    ld a, b
    add a, $10
    ld [wC916], a
    xor a, a
    ld [wC917], a
    farcall DispatchTalkEvent
    xor a, a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    pop hl
    ret

Jump_002_5B81::
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    inc b
    jr Jump_002_5B4B

Data_002_5B89:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $11, $70, $70, $01, $11, $70, $20, $01, $10, $70, $50, $1A, $10, $70, $70
    db $85, $10, $50, $60, $FF

; clears wC8CE; if bit 7 of wC8CD is set, draws the full screen buffer to the BG map at the scroll position and clears wC8CD and wC8CE (E-0121)
; 15 call sites from 9 routines (e.g. CheckInteractionInFront, UpdatePlayerMovement, UpdatePlayerMovement_Sub01, Func_002_4F4C_Case07, ...)
; reads: wC8CD, hScrollY, hScrollX
; writes: wC8CE, wC8CD
RedrawScreenBufferIfWC8CDBit7::
Func_002_5B9E:: ; address name
    xor a, a
    ld [wC8CE], a
    ld a, [wC8CD]
    bit 7, a
    ret z
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
    ld a, h
    and a, $9B
    ld h, a
    ldh a, [hScrollX]
    srl a
    srl a
    srl a
    add_a_to_hl
    call DrawFullScreenBufferToBGMap
    xor a, a
    ld [wC8CD], a
    ld [wC8CE], a
    ret

; if bit 7 of wC468 is set, runs the routine for wC468 & 3 (jump table) (E-0122)
; 12 call sites from 12 routines (e.g. FieldModeStateDispatch_Case05, FieldModeStateDispatch_Case01, FieldModeStateDispatch_Case00, ScriptCommand49_Run_Case01, ...)
; reads: wC468
RunWC468ActionIfBit7::
Func_002_5BD7:: ; address name
    ld a, [wC468]
    bit 7, a
    ret z
    and a, $03
    rst $00
    dw RunWC468ActionIfBit7_Case00
    dw RunWC468ActionIfBit7_Case01
    dw RunWC468ActionIfBit7_Case02
    dw RunWC468ActionIfBit7_Case03

; entry 0 of the `rst $00` table in RunWC468ActionIfBit7
; no direct call (reached through a table, a jump or a vector)
; writes: wC469
; points at: wC468
RunWC468ActionIfBit7_Case00::
Jump_002_5BE8:: ; address name
    call LoadMapScreen
    xor a, a
    ld [wC469], a
    ld hl, wC468
    inc [hl]
    ret

; entry 3 of the `rst $00` table in RunWC468ActionIfBit7
; no direct call (reached through a table, a jump or a vector)
; writes: wC918, wC468
RunWC468ActionIfBit7_Case03::
Jump_002_5BF4:: ; address name
    xor a, a
    ld [wC918], a
    farcall Func_00A_561E
    farcall Func_012_75E0
    farcall Func_00A_43EC
    farcall Func_011_4130
    farcall RunPlayerMoveTypeWC194
    farcall Func_00A_42BC
    farcall CountDownWD069ThenDispatchTalkEvent
    xor a, a
    ld [wC468], a
    ret

; entry 2 of the `rst $00` table in RunWC468ActionIfBit7
; no direct call (reached through a table, a jump or a vector)
; reads: wC935
; writes: wC935, wCBCF
; points at: wC468
RunWC468ActionIfBit7_Case02::
Jump_002_5C27:: ; address name
    ld hl, wC468
    inc [hl]
    farcall Func_012_70A4
    farcall Func_012_710A
    farcall Func_069_4001
    ld a, [wC935]
    bit 7, a
    jr z, Jump_002_5C4E
    bit 6, a
    jr nz, Jump_002_5C4E
    xor a, a
    ld [wC935], a
    jr Jump_002_5C54

Jump_002_5C4E::
    farcall ClearWC935WhenFieldIdle

Jump_002_5C54::
    xor a, a
    ld [wCBCF], a
    farcall Func_012_6A6A
    ret

; entry 1 of the `rst $00` table in RunWC468ActionIfBit7
; no direct call (reached through a table, a jump or a vector)
; reads: hScrollY, hScrollX, wC46A, wC469
; writes: hScrollX, hScrollY
; points at: wScreenTileBuffer, wC469, wC468
RunWC468ActionIfBit7_Case01::
Jump_002_5C5F:: ; address name
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
    jr nc, Jump_002_5C83
    inc d

Jump_002_5C83::
    ld a, [wC46A]
    bit 1, a
    jr z, Jump_002_5CCC
    ld a, e
    add a, $14
    and a, $1F
    ld c, a
    ld a, e
    and a, $E0
    or a, c
    ld e, a
    ld hl, wScreenTileBuffer
    ld a, [wC469]
    add_a_to_hl
    call RunWC468ActionIfBit7_Case01_Sub01
    ldh a, [hScrollX]
    add a, $08
    ldh [hScrollX], a
    ld hl, wC469
    inc [hl]
    ld a, [wC469]
    cp a, $14
    jr nc, Jump_002_5CB8
    call ComputeSpriteScrollOffsets
    ret

Jump_002_5CB8::
    ldh a, [hScrollX]
    and a, $F8
    ldh [hScrollX], a
    farcall MarkVisitedMapScreenInWCE93
    ld hl, wC468
    inc [hl]
    call ComputeSpriteScrollOffsets
    ret

Jump_002_5CCC::
    bit 0, a
    jr z, Jump_002_5D15
    ld a, e
    dec a
    and a, $1F
    ld c, a
    ld a, e
    and a, $E0
    or a, c
    ld e, a
    ld hl, wScreenTileBuffer
    ld a, [wC469]
    ld c, a
    ld a, $13
    sub a, c
    add_a_to_hl
    call RunWC468ActionIfBit7_Case01_Sub01
    ldh a, [hScrollX]
    sub a, $08
    ldh [hScrollX], a
    ld hl, wC469
    inc [hl]
    ld a, [wC469]
    cp a, $14
    jr nc, Jump_002_5D01
    call ComputeSpriteScrollOffsets
    ret

Jump_002_5D01::
    ldh a, [hScrollX]
    and a, $F8
    ldh [hScrollX], a
    farcall MarkVisitedMapScreenInWCE93
    ld hl, wC468
    inc [hl]
    call ComputeSpriteScrollOffsets
    ret

Jump_002_5D15::
    bit 3, a
    jr z, Jump_002_5D68
    ld a, e
    add a, $40
    ld e, a
    ld a, d
    adc a, $02
    ld d, a
    ld a, d
    and a, $9B
    ld d, a
    ld a, [wC469]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add_a_to_hl
    add hl, hl
    add hl, hl
    ld a, l
    add a, $98
    ld l, a
    ld a, h
    adc a, $C1
    ld h, a
    call RunWC468ActionIfBit7_Case01_Sub02
    ldh a, [hScrollY]
    add a, $08
    ldh [hScrollY], a
    ld hl, wC469
    inc [hl]
    ld a, [wC469]
    cp a, $12
    jr nc, Jump_002_5D54
    call ComputeSpriteScrollOffsets
    ret

Jump_002_5D54::
    ldh a, [hScrollY]
    and a, $F8
    ldh [hScrollY], a
    farcall MarkVisitedMapScreenInWCE93
    ld hl, wC468
    inc [hl]
    call ComputeSpriteScrollOffsets
    ret

Jump_002_5D68::
    bit 2, a
    jr z, Jump_002_5DC7
    ld a, e
    sub a, $20
    ld e, a
    ld a, d
    sbc a, $00
    ld d, a
    ld a, d
    cp a, $97
    jr nz, Jump_002_5D81
    ld a, e
    add a, $00
    ld e, a
    ld a, d
    adc a, $04
    ld d, a

Jump_002_5D81::
    ld a, [wC469]
    ld c, a
    ld a, $11
    sub a, c
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add_a_to_hl
    add hl, hl
    add hl, hl
    ld a, l
    add a, $98
    ld l, a
    ld a, h
    adc a, $C1
    ld h, a
    call RunWC468ActionIfBit7_Case01_Sub02
    ldh a, [hScrollY]
    sub a, $08
    ldh [hScrollY], a
    ld hl, wC469
    inc [hl]
    ld a, [wC469]
    cp a, $12
    jr nc, Jump_002_5DB4
    call ComputeSpriteScrollOffsets
    ret

Jump_002_5DB4::
    ldh a, [hScrollY]
    and a, $F8
    ldh [hScrollY], a
    farcall MarkVisitedMapScreenInWCE93
    ld hl, wC468
    inc [hl]
    call ComputeSpriteScrollOffsets

Jump_002_5DC7::
    ret

; only called from RunWC468ActionIfBit7_Case01 (E-0047)
; 2 call sites from 1 routine (e.g. RunWC468ActionIfBit7_Case01)
; reads: wIsCGB, hFFC6
; writes: wC0C0, wC0C1, wC0C2, wC0C3, wC0D8, wC0D9, wC0DA, wC0DB, ...
; points at: wC0C4, wC0DC
RunWC468ActionIfBit7_Case01_Sub01::
Func_002_5DC8:: ; address name
    ld a, e
    ld [wC0C0], a
    ld a, d
    ld [wC0C1], a
    ld a, $01
    ld [wC0C2], a
    ld a, $12
    ld [wC0C3], a
    push hl
    push de
    ld b, $12
    ld de, wC0C4

Jump_002_5DE1::
    ld a, [hl]
    ld [de], a
    ld a, $14
    add_a_to_hl
    inc de
    dec b
    jr nz, Jump_002_5DE1
    pop de
    pop hl
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, e
    ld [wC0D8], a
    ld a, d
    ld [wC0D9], a
    ld a, $01
    ld [wC0DA], a
    ld a, $12
    ld [wC0DB], a
    ld de, $0E68
    add hl, de
    ld b, $12
    ld de, wC0DC

Jump_002_5E10::
    ld a, $02
    ldh [rSVBK], a
    ld a, [hl]
    ldh [hFFC6], a
    ld a, $00
    ldh [rSVBK], a
    ldh a, [hFFC6]
    and a, $07
    ld [de], a
    ld a, $14
    add_a_to_hl
    inc de
    dec b
    jr nz, Jump_002_5E10
    ret

; only called from RunWC468ActionIfBit7_Case01 (E-0047)
; 2 call sites from 1 routine (e.g. RunWC468ActionIfBit7_Case01)
; reads: wIsCGB, hFFC6
; writes: wC0C0, wC0C1, wC0C2, wC0C3, wC0D8, wC0D9, wC0DA, wC0DB, ...
; points at: wC0C4, wC0DC
RunWC468ActionIfBit7_Case01_Sub02::
Func_002_5E2C:: ; address name
    ld a, e
    ld [wC0C0], a
    ld a, d
    ld [wC0C1], a
    xor a, a
    ld [wC0C2], a
    ld a, $14
    ld [wC0C3], a
    push hl
    push de
    ld b, $14
    ld de, wC0C4

Jump_002_5E44::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_002_5E44
    pop de
    pop hl
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, e
    ld [wC0D8], a
    ld a, d
    ld [wC0D9], a
    ld a, $00
    ld [wC0DA], a
    ld a, $14
    ld [wC0DB], a
    ld de, $0E68
    add hl, de
    ld b, $14
    ld de, wC0DC

Jump_002_5E6C::
    ld a, $02
    ldh [rSVBK], a
    ld a, [hl+]
    ldh [hFFC6], a
    ld a, $00
    ldh [rSVBK], a
    ldh a, [hFFC6]
    and a, $07
    ld [de], a
    ld [de], a
    inc de
    dec b
    jr nz, Jump_002_5E6C
    ret

; 4 call sites from 4 routines (e.g. RunWC8C7Phase_Case02, RefreshRecordListAndNameTiles, ScriptCommandF8_Run_Case02_Case10, RefreshRecordListAndNameTiles_BankF1)
; reads: wC6FD, wC6FE, hFFC6, wC6FF, wC700
; writes: rRAMG, wC6FE, wC6FF, wC700
Func_002_5E82::
    call Func_002_5E85

; 19 call sites from 10 routines (e.g. Func_002_4628, Func_002_5E82, ScriptCommand58_Run_Case22, ScriptCommand9B_Run_Case05, ...)
; reads: wC6FD, wC6FE, hFFC6, wC6FF, wC700
; writes: rRAMG, wC6FE, wC6FF, wC700
Func_002_5E85::
    ld a, [wC6FD]
    dec a
    ret z
    dec a
    jr nz, Jump_002_5E8F
    jr Jump_002_5EBA

Jump_002_5E8F::
    ld a, $0A
    ld [rRAMG], a
    ld c, $55
    ld a, [wC6FF]
    call LoadSRAMRecordByte
    bit 7, a
    jr z, Jump_002_5EBA
    ld c, $55
    ld a, [wC700]
    call LoadSRAMRecordByte
    bit 7, a
    jr nz, Jump_002_5EBA
    ld a, [wC6FF]
    ld c, a
    ld a, [wC700]
    ld [wC6FF], a
    ld a, c
    ld [wC700], a

Jump_002_5EBA::
    ld a, $0A
    ld [rRAMG], a
    ld c, $55
    ld a, [wC6FE]
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    bit 7, a
    jr z, Jump_002_5EE9
    ld c, $55
    ld a, [wC6FF]
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    bit 7, a
    jr nz, Jump_002_5EE9
    ld a, [wC6FE]
    ld c, a
    ld a, [wC6FF]
    ld [wC6FE], a
    ld a, c
    ld [wC6FF], a

Jump_002_5EE9::
    xor a, a
    ld [rRAMG], a
    ret

; copies the first $168 bytes (20 x 18) of wScreenTileBuffer to vBGMap1 with WriteVRAMByteInc; on CGB also copies the $168 attribute bytes at wD000 to wD2D0 (rSVBK = 2); saves wSpriteSlotCount in wCB7E. RestoreScreenBufferFromBGMap1 undoes it (E-0066)
; 22 call sites from 20 routines (e.g. CheckInteractionInFront, Func_002_4F4C_Case07, Func_002_64E5, Func_00A_43EC, ...)
; reads: wIsCGB, wSpriteSlotCount
; writes: rSVBK, wCB7E
; points at: wScreenTileBuffer, wD000, wD2D0
SaveScreenBufferToBGMap1::
Func_002_5EEE:: ; address name
    ld de, wScreenTileBuffer
    ld hl, vBGMap1
    ld bc, $0168

Jump_002_5EF7::
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_002_5EF7
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_002_5F1B
    ld a, $02
    ldh [rSVBK], a
    ld hl, wD000
    ld de, wD2D0
    ld bc, $0168
    call CopyBytes
    ld a, $00
    ldh [rSVBK], a

Jump_002_5F1B::
    ld a, [wSpriteSlotCount]
    ld [wCB7E], a
    ret

; copies $168 bytes from vBGMap1 back to wScreenTileBuffer (WaitForVRAMAccess, interrupts off per byte); on CGB copies wD2D0 back to wD000 (rSVBK = 2); restores wSpriteSlotCount from wCB7E (E-0066)
; 7 call sites from 7 routines (e.g. Func_002_4628, ScriptCommand82_Run_Case0A_Case08, ScriptCommand2A_Run_Case0F, ScriptCommand2A_Run_Case0D, ...)
; reads: wIsCGB, wCB7E
; writes: rSVBK, wSpriteSlotCount
; points at: wScreenTileBuffer, wD2D0, wD000
RestoreScreenBufferFromBGMap1::
Func_002_5F22:: ; address name
    ld hl, vBGMap1
    ld de, wScreenTileBuffer
    ld bc, $0168

Jump_002_5F2B::
    di
    call WaitForVRAMAccess
    ld a, [hl+]
    ld [de], a
    ei
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_002_5F2B
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_002_5F52
    ld a, $02
    ldh [rSVBK], a
    ld hl, wD2D0
    ld de, wD000
    ld bc, $0168
    call CopyBytes
    ld a, $00
    ldh [rSVBK], a

Jump_002_5F52::
    ld a, [wCB7E]
    ld [wSpriteSlotCount], a
    ret

; counts frames wC82D (0-59), seconds wC82E (0-59), minutes wC82F (0-59) and a 16-bit hour count wC830/wC831; stops at 999:59:59 ($03E7 hours)
; 1 call site from 1 routine (e.g. FieldModeStateDispatch)
; reads: wPlayHoursLo, wPlayHoursHi, wPlayMinutes
; points at: wPlayFrames
IncrementPlayTime::
Func_002_5F59:: ; address name
    ld a, [wPlayHoursLo]
    ld l, a
    ld a, [wPlayHoursHi]
    ld h, a
    ld bc, $03E7
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    ld a, h
    or a, l
    or a, a
    jr nz, Jump_002_5F75
    ld a, [wPlayMinutes]
    cp a, $3B
    ret z

Jump_002_5F75::
    ld hl, wPlayFrames
    ld a, [hl]
    inc a
    ld [hl], a
    cp a, $3C
    ret c
    ld [hl], $00
    inc hl
    ld a, [hl]
    inc a
    ld [hl], a
    cp a, $3C
    ret c
    ld [hl], $00
    inc hl
    ld a, [hl]
    inc a
    ld [hl], a
    cp a, $3C
    ret c
    ld [hl], $00
    inc hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    inc bc
    ld a, b
    ld [hl-], a
    ld [hl], c
    ret

; 3 call sites from 3 routines (e.g. Func_002_4628, GameMode6_Init, GameMode8_Init)
; reads: wSGBActive, wC51F, wC520, wC5E0
; writes: wC577, wC578, wC579, wC57A, wC57B, wC57C, wC57D, wC57E, ...
Func_002_5F9B::
    ld a, [wSGBActive]
    or a, a
    jr z, Jump_002_5FEB
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
    farcall LoadSGBObjectPalettesFromPointers

Jump_002_5FEB::
    ld a, [wC5E0]
    cp a, $01
    ret nz
    ld a, $02
    ld [wC5E0], a
    ret

Jump_002_5FF7::
    xor a, a
    ld [wJoypadHeld], a
    ld [wJoypadHeldPrev], a
    xor a, a
    ld [wJoypadPressed], a
    ld [wJoypadPressedRepeat], a
    xor a, a
    ld [wJoypadRepeatTimer], a
    ld [wC565], a
    call FieldModeStateDispatch
    xor a, a
    ld [wC5E0], a
    ld hl, wC5E9
    ld a, $D2
    ld [hl+], a
    ld a, $D2
    ld [hl+], a
    ld a, $E2
    ld [hl], a
    ld hl, wD040
    ld a, [wC5E9]
    ld [hl+], a
    ld a, [wC5EA]
    ld [hl+], a
    ld a, [wC5EB]
    ld [hl], a
    call ResetFadeFromWC5E9
    ld a, [wSGBActive]
    or a, a
    jr z, Jump_002_6045
    ld hl, wOBJPaletteBuffer
    ld de, wC4FF
    ld b, $20

Jump_002_603F::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_002_603F

Jump_002_6045::
    ld a, $FD
    call StartPaletteFade
    ret

; wC608 = $FF (no current music), then falls into PlayMapMusic so the map's music always restarts (E-0122)
; 10 call sites from 10 routines (e.g. GameMode1_Init, Func_002_4628, Func_000_2950_Case09, RunWC46BMenuState_Case05, ...)
; reads: wCC44, wCC45, hFF8C, wC608, hMapId
; writes: wC608
; points at: wCD89
RestartMapMusic::
Func_002_604B:: ; address name
    ld a, $FF
    ld [wC608], a

; chooses the music for the current map (by wCC44 and hMapId, with story-flag cases) and queues it unless it is already wC608 (E-0122)
; 9 call sites from 9 routines (e.g. FieldModeStateDispatch_Case04, RunWC8C7Phase_Case02, ScriptCommand58_Run_Case28, ScriptCommand46_Run_Case0A, ...)
; reads: wCC44, wCC45, hFF8C, wC608, hMapId
; points at: wCD89
PlayMapMusic::
Func_002_6050:: ; address name
    ld a, [wCC44]
    bit 7, a
    jr z, Jump_002_609D
    ld c, $22
    cp a, $86
    jr z, Jump_002_6089
    ld c, $25
    cp a, $85
    jr z, Jump_002_6089
    ld c, $19
    cp a, $84
    jr z, Jump_002_6089
    cp a, $83
    jr nz, Jump_002_607F
    ld a, [wCC45]
    add a, a
    add a, a
    ld hl, wCD89
    add_a_to_hl
    ld a, [hl]
    cp a, $06
    jr nz, Jump_002_6089

Jump_002_607F::
    ld c, $2B
    ldh a, [hFF8C]
    bit 3, a
    jr nz, Jump_002_6089
    ld c, $35

Jump_002_6089::
    ld a, [wC608]
    cp a, c
    ret z
    ld a, c
    call QueueMusic
    ret

Jump_002_6093::
    ld a, [wSoundEffectRequest]
    cp a, c
    ret z
    ld a, c
    call QueueSoundEffect
    ret

Jump_002_609D::
    ldh a, [hMapId]
    rst $00
    dw PlayMapMusic_Case00
    dw PlayMapMusic_Case01
    dw PlayMapMusic_Case00
    dw PlayMapMusic_Case00
    dw PlayMapMusic_Case04
    dw PlayMapMusic_Case05
    dw PlayMapMusic_Case00
    dw PlayMapMusic_Case00
    dw PlayMapMusic_Case00
    dw PlayMapMusic_Case00
    dw PlayMapMusic_Case00
    dw PlayMapMusic_Case00
    dw PlayMapMusic_Case00
    dw PlayMapMusic_Case0D
    dw PlayMapMusic_Case00
    dw PlayMapMusic_Case00
    dw PlayMapMusic_Case00
    dw PlayMapMusic_Case00
    dw PlayMapMusic_Case00
    dw PlayMapMusic_Case00
    dw PlayMapMusic_Case0D
    dw PlayMapMusic_Case00
    dw PlayMapMusic_Case00
    dw PlayMapMusic_Case00
    dw PlayMapMusic_Case04
    dw PlayMapMusic_Case00
    dw PlayMapMusic_Case00
    dw PlayMapMusic_Case00
    dw PlayMapMusic_Case1C
    dw PlayMapMusic_Case1D
    INCBIN "dwm2-cobi-us.gbc", $00A0DC, $54
    dw MapMusicByFlag23_631A
    dw MapMusicByFlag23_631A
    dw MapMusicByFlag23
    dw MapMusicByFlag23
    dw MapMusicByFlag23
    dw MapMusicByScreenAndFlags87And8A
    dw MapMusicByFlag23_631A
    dw MapMusicByFlag23
    dw MapMusicByFlag23
    dw MapMusicByFlag23
    dw MapMusicByFlag23_631A
    db $39, $63, $39, $63, $39, $63, $39, $63, $39, $63
    dw MapMusicByFlag23
    dw MapMusicByFlag23
    dw MapMusicByFlag23
    dw MapMusicByFlag23
    dw MapMusicByFlag23
    db $72, $63
    dw MapMusicByFlag23
    dw MapMusicByFlag23
    dw MapMusicByFlag23
    dw MapMusicByFlag23
    INCBIN "dwm2-cobi-us.gbc", $00A164, $104

; entry 0 of the `rst $00` table in PlayMapMusic
; no direct call (reached through a table, a jump or a vector)
; reads: wC608
PlayMapMusic_Case00::
Jump_002_6268:: ; address name
    ld c, $16
    jp Jump_002_6089

; entry 1 of the `rst $00` table in PlayMapMusic
; no direct call (reached through a table, a jump or a vector)
; reads: hMapScreenY, hMapScreenX, wC608
PlayMapMusic_Case01::
Jump_002_626D:: ; address name
    ldh a, [hMapScreenY]
    cp a, $02
    jr nz, PlayMapMusic_Case00
    ldh a, [hMapScreenX]
    or a, a
    jr z, Jump_002_627C
    cp a, $02
    jr nz, PlayMapMusic_Case00

Jump_002_627C::
    ld de, $0007
    call TestFlagBit
    jr nc, PlayMapMusic_Case00
    ld de, $000A
    call TestFlagBit
    jr c, PlayMapMusic_Case00
    ld c, $28
    jp Jump_002_6089

; entry 5 of the `rst $00` table in PlayMapMusic
; no direct call (reached through a table, a jump or a vector)
; reads: hMapScreenX, wC608
PlayMapMusic_Case05::
Jump_002_6291:: ; address name
    ldh a, [hMapScreenX]
    or a, a
    jr nz, PlayMapMusic_Case00
    ld de, $000A
    call TestFlagBit
    jr nc, PlayMapMusic_Case00
    ld de, $000C
    call TestFlagBit
    jr nc, Jump_002_62B6
    ld de, $00C2
    call TestFlagBit
    jr nc, PlayMapMusic_Case00
    ld de, $00C3
    call TestFlagBit
    jr c, PlayMapMusic_Case00

Jump_002_62B6::
    ld c, $28
    jp Jump_002_6089

; entry 13 of the `rst $00` table in PlayMapMusic
; no direct call (reached through a table, a jump or a vector)
; reads: wC608
PlayMapMusic_Case0D::
Jump_002_62BB:: ; address name
    ld c, $0C
    jp Jump_002_6089

; entry 4 of the `rst $00` table in PlayMapMusic
; no direct call (reached through a table, a jump or a vector)
; reads: wC608
PlayMapMusic_Case04::
Jump_002_62C0:: ; address name
    ld de, $00CC
    call TestFlagBit
    jr nc, PlayMapMusic_Case00
    ld de, $0038
    call TestFlagBit
    jr c, PlayMapMusic_Case00
    ld c, $CF
    jp Jump_002_6089

; entry 29 of the `rst $00` table in PlayMapMusic
; no direct call (reached through a table, a jump or a vector)
; reads: wSoundEffectRequest
PlayMapMusic_Case1D::
Jump_002_62D5:: ; address name
    ld c, $76
    jp Jump_002_6093

; entry 28 of the `rst $00` table in PlayMapMusic
; no direct call (reached through a table, a jump or a vector)
PlayMapMusic_Case1C::
Jump_002_62DA:: ; address name
    ret

Jump_002_62DB::
    ld c, $19
    jp Jump_002_6089

; map music case: if story flag $23 is set uses music $1C, else $2E (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wC608
MapMusicByFlag23:: ; heuristic: target of a pointer table; C0
Func_002_62E0:: ; address name
    ld de, $0023
    call TestFlagBit
    jr c, Jump_002_62DB
    ld c, $2E
    jp Jump_002_6089

; map music case: on hMapScreenY 0, without flag $87, or with flag $8A uses the flag-$23 case; otherwise music $28 (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: hMapScreenY, wC608
MapMusicByScreenAndFlags87And8A:: ; heuristic: target of a pointer table; C0
Func_002_62ED:: ; address name
    ldh a, [hMapScreenY]
    or a, a
    jr z, MapMusicByFlag23
    ld de, $0087
    call TestFlagBit
    jr nc, MapMusicByFlag23
    ld de, $008A
    call TestFlagBit
    jr c, MapMusicByFlag23
    ld c, $28
    jp Jump_002_6089

Jump_002_6307::
    ld c, $1C
    jp Jump_002_6089

; map music case: music $2B when bit 3 of hFF8C is set, else $1C (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: hFF8C, wC608
MapMusicByHFF8CBit3:: ; heuristic: follows a terminator; C0
Func_002_630C:: ; address name
    ld c, $1C
    ldh a, [hFF8C]
    bit 3, a
    jp z, Jump_002_6089
    ld c, $2B
    jp Jump_002_6089

; map music case: if story flag $23 is set uses music $1C, else $2E (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wC608
MapMusicByFlag23_631A:: ; heuristic: target of a pointer table; C0
Func_002_631A:: ; address name
    ld de, $0023
    call TestFlagBit
    jr c, Jump_002_6307
    ld c, $2E
    jp Jump_002_6089

; map music case: if story flag $25 is set uses music $1C, else $1F (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wC608
MapMusicByFlag25:: ; heuristic: follows a terminator; C0
Func_002_6327:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_002_6307
    ld c, $1F
    jp Jump_002_6089
    INCBIN "dwm2-cobi-us.gbc", $00A334, $5D

; only called from FieldModeStateDispatch_Case02 (E-0047)
; 1 call site from 1 routine (e.g. FieldModeStateDispatch_Case02)
; reads: wJoypadPressed, wCC44, wC46B
; writes: wC8C7, hFFB9, wModeState, wGameMode, wC5DD, wC46B
FieldModeStateDispatch_Case02_Sub01::
Func_002_6391:: ; address name
    call FieldModeStateDispatch_Case02_Sub01_Sub01
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, Jump_002_63BD
    xor a, a
    ld [wC8C7], a
    farcall ClearBit1OfPlayerAndObjectFlags
    xor a, a
    ldh [hFFB9], a
    call FieldModeStateDispatch_Case02_Sub01_Sub02
    ld a, [wCC44]
    bit 7, a
    jr nz, Jump_002_63B7
    xor a, a
    ld [wModeState], a
    ret

Jump_002_63B7::
    ld a, $05
    ld [wModeState], a
    ret

Jump_002_63BD::
    bit 0, a
    jr z, Jump_002_63D6
    ld a, $69
    call QueueSoundEffect
    ld a, $02
    ld [wGameMode], a
    ld a, [wC46B]
    ld [wModeState], a
    xor a, a
    ld [wC5DD], a
    ret

Jump_002_63D6::
    bit 5, a
    jr z, Jump_002_63E8
    ld a, $69
    call QueueSoundEffect
    ld a, [wC46B]
    xor a, $01
    ld [wC46B], a
    ret

Jump_002_63E8::
    bit 4, a
    jr z, Jump_002_63FA
    ld a, $69
    call QueueSoundEffect
    ld a, [wC46B]
    xor a, $01
    ld [wC46B], a
    ret

Jump_002_63FA::
    bit 6, a
    jr z, Jump_002_640C
    ld a, $69
    call QueueSoundEffect
    ld a, [wC46B]
    xor a, $02
    ld [wC46B], a
    ret

Jump_002_640C::
    bit 7, a
    jr z, Jump_002_641D
    ld a, $69
    call QueueSoundEffect
    ld a, [wC46B]
    xor a, $02
    ld [wC46B], a

Jump_002_641D::
    ret

; only called from FieldModeStateDispatch_Case02_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. FieldModeStateDispatch_Case02_Sub01)
; reads: hScrollY, hScrollX, wC46B, wC46C
; writes: wC46C
FieldModeStateDispatch_Case02_Sub01_Sub01::
Func_002_641E:: ; address name
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
    jr nc, Jump_002_6442
    inc d

Jump_002_6442::
    ld l, e
    ld h, d
    ld b, $00
    ld de, Data_002_64AB

Jump_002_6449::
    push hl
    ld a, [de]
    inc de
    ld c, a
    add a, l
    ld l, a
    and a, $1F
    cp a, c
    jr nc, Jump_002_645C
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

Jump_002_645C::
    ld a, [de]
    inc de
    push de
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
    sla e
    rl d
    ld a, l
    add a, e
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    pop de
    ld a, h
    and a, $9B
    ld h, a
    ld c, $C3
    ld a, [wC46B]
    cp a, b
    jr nz, Jump_002_649F
    ld c, $BC
    bit 7, a
    jr nz, Jump_002_649F
    ld c, $BB
    ld a, [wC46C]
    inc a
    ld [wC46C], a
    bit 3, a
    jr z, Jump_002_649F
    ld c, $C3

Jump_002_649F::
    ld a, c
    call WriteVRAMByte
    pop hl
    inc b
    ld a, b
    cp a, $04
    jr nz, Jump_002_6449
    ret

Data_002_64AB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $01, $06, $01, $01, $03, $06, $03

; only called from FieldModeStateDispatch_Case02_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. FieldModeStateDispatch_Case02_Sub01)
; reads: hScrollY, hScrollX
; writes: wC8CD, wC8CE
FieldModeStateDispatch_Case02_Sub01_Sub02::
Func_002_64B3:: ; address name
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
    jr nc, Jump_002_64D7
    inc d

Jump_002_64D7::
    ld l, e
    ld h, d
    call DrawFullScreenBufferToBGMap
    xor a, a
    ld [wC8CD], a
    xor a, a
    ld [wC8CE], a
    ret

; 3 call sites from 3 routines (e.g. RunWC8C7Phase_Case01, FieldModeStateDispatch_Case00, FieldModeStateDispatch_Case05)
; reads: wFadeState, wC8CB, wC468, hFF8C, wJoypadPressed, wIsCGB, hScrollY, hScrollX, ...
; writes: hFFB9, wC8C7, rSVBK, wC8CE, wModeState, wC46B
; points at: wC300, wScreenTileBuffer, wD168, wD000, wC30C
Func_002_64E5::
    ld a, [wFadeState]
    or a, a
    ret nz
    ld de, $0002
    call TestFlagBit
    ret nc
    ld a, [wC8CB]
    and a, $03
    ret nz
    ld a, [wC468]
    bit 7, a
    ret nz
    ldh a, [hFF8C]
    bit 0, a
    ret nz
    ld a, [wJoypadPressed]
    bit 0, a
    ret z
    ld a, $03
    ldh [hFFB9], a
    ld a, $01
    ld [wC8C7], a
    farcall SaveScreenBufferToBGMap1
    farcall SetBit1OfPlayerAndObjectFlags
    ld hl, wC300
    ld de, wScreenTileBuffer
    ld b, $64

Jump_002_6525::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_002_6525
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_002_6549
    ld hl, wD168
    ld de, wD000
    ld a, $02
    ldh [rSVBK], a
    ld b, $64

Jump_002_653D::
    ld a, [de]
    inc de
    and a, $07
    ld [hl+], a
    dec b
    jr nz, Jump_002_653D
    ld a, $00
    ldh [rSVBK], a

Jump_002_6549::
    ld de, Data_002_6606
    ld hl, wC300
    ld bc, $0C05
    call Func_002_65C3
    ld de, Data_002_6642
    ld hl, wC30C
    ld bc, $0803
    call Func_002_65C3
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
    jr nc, Jump_002_6585
    inc d

Jump_002_6585::
    ld l, e
    ld h, d
    push hl
    ld bc, $1405
    call CopyScreenRectToBGMapSetWC554
    ld a, $B3
    ld [wC8CE], a
    call Func_002_66CC
    pop hl
    ld a, $2E
    add_a_to_hl
    ld a, l
    and a, $1F
    cp a, $0E
    jr nc, Jump_002_65AD
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

Jump_002_65AD::
    call Func_002_665A
    ld a, $69
    call QueueSoundEffect
    ld a, $02
    ld [wModeState], a
    ldh a, [hFFCE]
    or a, a
    ret nz
    xor a, a
    ld [wC46B], a
    ret

; 2 call sites from 1 routine (e.g. Func_002_64E5)
; reads: wIsCGB
; writes: rSVBK
Func_002_65C3::
    push hl
    push bc

Jump_002_65C5::
    push hl
    push bc

Jump_002_65C7::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_002_65C7
    pop bc
    pop hl
    ld a, l
    add a, $14
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec c
    jr nz, Jump_002_65C5
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

Jump_002_65ED::
    push hl
    push bc

Jump_002_65EF::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_002_65EF
    pop bc
    pop hl
    ld a, l
    add a, $14
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec c
    jr nz, Jump_002_65ED
    ld a, $00
    ldh [rSVBK], a
    ret

Data_002_6606:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $A4, $A5
    db $A6, $A7, $C3, $A4, $A8, $A9, $EC, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $B7, $B6, $C3, $AA, $AB, $A4, $AC, $C3, $AD, $AC, $AE, $A5, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_002_6642:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $BF, $C3, $C3, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; 1 call site from 1 routine (e.g. Func_002_64E5)
; reads: wGoldLo, wGoldMid, wGoldHi
; writes: wC8C0, wC8C1, wC8C2
; points at: hFFC8
Func_002_665A::
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
    jr Jump_002_66A9

Jump_002_667E::
    ld a, [de]
    srl a
    srl a
    srl a
    srl a
    or a, a
    jr nz, Jump_002_668E
    bit 0, c
    jr z, Jump_002_6695

Jump_002_668E::
    add a, $E0
    call WriteVRAMByte
    ld c, $01

Jump_002_6695::
    inc hl
    ld a, l
    and a, $1F
    jr nz, Jump_002_66A3
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

Jump_002_66A3::
    ld a, b
    dec a
    jr nz, Jump_002_66A9
    ld c, $01

Jump_002_66A9::
    ld a, [de]
    dec de
    and a, $0F
    jr nz, Jump_002_66B3
    bit 0, c
    jr z, Jump_002_66BA

Jump_002_66B3::
    add a, $E0
    call WriteVRAMByte
    ld c, $01

Jump_002_66BA::
    inc hl
    ld a, l
    and a, $1F
    jr nz, Jump_002_66C8
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

Jump_002_66C8::
    dec b
    jr nz, Jump_002_667E
    ret

; 1 call site from 1 routine (e.g. Func_002_64E5)
; reads: wC8CB, wC468, wC6FD, hFF8C, wC8CD, wC8CE, wIsCGB
; writes: wC8CE, wC8CD, hFFB9, rSVBK
; points at: wC364, wScreenTileBuffer, wD1CC
Func_002_66CC::
    ld de, $0002
    call TestFlagBit
    ret nc
    ld a, [wC8CB]
    and a, $03
    ret nz
    ld a, [wC468]
    bit 7, a
    ret nz
    ld a, [wC6FD]
    or a, a
    ret z
    ldh a, [hFF8C]
    bit 0, a
    ret nz
    ld a, [wC8CD]
    bit 7, a
    ret nz
    ld a, [wC8CE]
    inc a
    ld [wC8CE], a
    cp a, $B4
    ret nz
    xor a, a
    ld [wC8CE], a
    ld a, [wC6FD]
    dec a
    or a, $80
    ld [wC8CD], a
    ld a, $03
    ldh [hFFB9], a
    ld hl, wC364
    ld de, wScreenTileBuffer
    ld a, e
    add a, $F0
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    push de
    ld b, $78

Jump_002_671B::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_002_671B
    pop de
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_002_6745
    ld hl, wD1CC
    ld a, e
    add a, $68
    ld e, a
    ld a, d
    adc a, $0E
    ld d, a
    ld a, $02
    ldh [rSVBK], a
    ld b, $78

Jump_002_6739::
    ld a, [de]
    inc de
    and a, $07
    ld [hl+], a
    dec b
    jr nz, Jump_002_6739
    ld a, $00
    ldh [rSVBK], a

Jump_002_6745::
    ld a, [wC8CD]
    and a, $03
    jr z, Jump_002_6753
    dec a
    jr z, Jump_002_6761
    dec a
    jr z, Jump_002_676F
    ret

Jump_002_6753::
    ld de, Data_002_68E6
    ld hl, wC364
    ld bc, $0706
    call Func_002_68A3
    jr Jump_002_677B

Jump_002_6761::
    ld de, Data_002_6910
    ld hl, wC364
    ld bc, $0D06
    call Func_002_68A3
    jr Jump_002_677B

Jump_002_676F::
    ld de, Data_002_695E
    ld hl, wC364
    ld bc, $1306
    call Func_002_68A3

Jump_002_677B::
    call Func_002_6788
    call Func_002_6841
    farcall LoadTilesForPartyRecords
    ret

; 1 call site from 1 routine (e.g. Func_002_66CC)
; reads: wC8CD, hFFC6, hFFCB, hFFC7
; writes: rRAMG, hFFCB
; points at: wC6FE, wC364
Func_002_6788::
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC8CD]
    and a, $03
    inc a
    ld b, a
    ld hl, Data_002_6835
    ld de, wC6FE

Jump_002_679A::
    push bc
    push de
    ld a, [de]
    ldh [hFFCB], a
    ld c, $56
    call LoadSRAMRecordByte
    push hl
    ldh a, [hFFC6]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    pop hl
    ld a, [hl+]
    ld de, wC364
    add a, e
    ld e, a
    jr nc, Jump_002_67B7
    inc d

Jump_002_67B7::
    call WriteTwoDigitTilesFromWC8C1
    ldh a, [hFFCB]
    ld c, $5B
    call LoadSRAMRecordWord
    push hl
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    call HLToDecimalDigits
    pop hl
    ld a, [hl+]
    ld de, wC364
    add a, e
    ld e, a
    jr nc, Jump_002_67D5
    inc d

Jump_002_67D5::
    call WriteDecimalDigitTiles
    ldh a, [hFFCB]
    ld c, $5F
    call LoadSRAMRecordWord
    push hl
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    call HLToDecimalDigits
    pop hl
    ld a, [hl+]
    ld de, wC364
    add a, e
    ld e, a
    jr nc, Jump_002_67F3
    inc d

Jump_002_67F3::
    call WriteDecimalDigitTiles
    ld a, [hl+]
    ld de, wC364
    add a, e
    ld e, a
    jr nc, Jump_002_67FF
    inc d

Jump_002_67FF::
    ldh a, [hFFCB]
    ld c, $55
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    bit 7, a
    jr z, Jump_002_6811
    ld a, $C2
    ld [de], a
    jr Jump_002_6829

Jump_002_6811::
    bit 2, a
    jr z, Jump_002_6818
    ld a, $C1
    ld [de], a

Jump_002_6818::
    ldh a, [hFFC6]
    bit 0, a
    jr z, Jump_002_6829
    ld a, e
    sub a, $14
    ld e, a
    ld a, d
    sbc a, $00
    ld d, a
    ld a, $C0
    ld [de], a

Jump_002_6829::
    pop de
    inc de
    pop bc
    dec b
    jp nz, Jump_002_679A
    xor a, a
    ld [rRAMG], a
    ret

Data_002_6835:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $54, $2B, $3F, $51, $5A, $31, $45, $57, $60, $37, $4B, $5D

; 1 call site from 1 routine (e.g. Func_002_66CC)
; reads: hScrollY, hScrollX, wIsCGB
; writes: rVBK, rSVBK
; points at: wC364, wD1CC
Func_002_6841::
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
    jr nc, Jump_002_6869
    inc d

Jump_002_6869::
    ld a, e
    add a, $80
    ld e, a
    ld a, d
    adc a, $01
    ld d, a
    ld a, d
    and a, $9B
    ld d, a
    ld l, e
    ld h, d
    push hl
    ld de, wC364
    ld bc, $1406
    xor a, a
    call CopyRectFromBankToBGMapWrapped
    pop hl
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, $01
    ldh [rVBK], a
    ld a, $02
    ldh [rSVBK], a
    ld de, wD1CC
    ld bc, $1406
    xor a, a
    call CopyRectFromBankToBGMapWrapped
    ld a, $00
    ldh [rSVBK], a
    ld a, $00
    ldh [rVBK], a
    ret

; 3 call sites from 1 routine (e.g. Func_002_66CC)
; reads: wIsCGB
; writes: rSVBK
Func_002_68A3::
    push hl
    push bc

Jump_002_68A5::
    push hl
    push bc

Jump_002_68A7::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_002_68A7
    pop bc
    pop hl
    ld a, l
    add a, $14
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec c
    jr nz, Jump_002_68A5
    pop bc
    pop hl
    ld a, l
    add a, $68
    ld l, a
    ld a, h
    adc a, $0E
    ld h, a
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, $02
    ldh [rSVBK], a

Jump_002_68CD::
    push hl
    push bc

Jump_002_68CF::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_002_68CF
    pop bc
    pop hl
    ld a, l
    add a, $14
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec c
    jr nz, Jump_002_68CD
    ld a, $00
    ldh [rSVBK], a
    ret

Data_002_68E6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $D0, $D1, $D2, $D3, $D4, $B7, $B6, $C7
    db $EB, $C3, $C3, $C3, $B7, $B6, $C3, $EC, $C3, $C3, $C3, $B7, $B6, $C3, $EA, $ED
    db $C3, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B4, $B5

Data_002_6910:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $00A910, $4E

Data_002_695E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0
    ds $11, $B1
    INCBIN "dwm2-cobi-us.gbc", $00A970, $4E
    ds $11, $B4
    db $B5

; 9 call sites from 9 routines (e.g. FieldModeStateDispatch_Case01, GameMode5_Init_Case02, GameMode5_Init_Case03, GameMode5_Init_Case06, ...)
; reads: wC8CB, wIsCGB, hScrollY, hScrollX, wC8CC
; writes: rSVBK
; points at: wC300, wScreenTileBuffer, wC8CC
Func_002_69D0::
    ld a, [wC8CB]
    and a, $03
    ret z
    ld hl, wC300
    ld de, wScreenTileBuffer
    ld a, [wC8CB]
    bit 7, a
    jr nz, Jump_002_69EB
    ld a, e
    add a, $04
    ld e, a
    ld a, d
    adc a, $01
    ld d, a

Jump_002_69EB::
    push hl
    push de
    ld b, $64

Jump_002_69EF::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_002_69EF
    pop de
    pop hl
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_002_6A1F
    ld a, e
    add a, $68
    ld e, a
    ld a, d
    adc a, $0E
    ld d, a
    ld a, l
    add a, $68
    ld l, a
    ld a, h
    adc a, $0E
    ld h, a
    ld a, $02
    ldh [rSVBK], a
    ld b, $64

Jump_002_6A13::
    ld a, [de]
    inc de
    and a, $07
    ld [hl+], a
    dec b
    jr nz, Jump_002_6A13
    ld a, $00
    ldh [rSVBK], a

Jump_002_6A1F::
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
    jr nc, Jump_002_6A47
    inc d

Jump_002_6A47::
    ld a, [wC8CB]
    bit 7, a
    jr nz, Jump_002_6A5A
    ld a, e
    add a, $A0
    ld e, a
    ld a, d
    adc a, $01
    ld d, a
    ld a, d
    and a, $9B
    ld d, a

Jump_002_6A5A::
    ld hl, wC8CC
    inc [hl]
    ld a, [wC8CC]
    and a, $01
    dec a
    ret nz
    ld a, [wC8CC]
    srl a
    and a, $03
    rst $00
    dw Func_002_69D0_Case00
    dw Func_002_69D0_Case01
    dw Func_002_69D0_Case02
    dw Func_002_69D0_Case02

; entry 0 of the `rst $00` table in Func_002_69D0
; no direct call (reached through a table, a jump or a vector)
; reads: wC8CB
; points at: wC328, wC314
Func_002_69D0_Case00::
Jump_002_6A75:: ; address name
    ld a, [wC8CB]
    bit 0, a
    jr z, Jump_002_6A92
    push de
    ld hl, wC328
    ld de, Data_002_6B8C
    ld b, $01
    call CopyRowsToScreenBufferAndClearAttributes
    pop de
    ld l, e
    ld h, d
    ld bc, $1405
    call CopyScreenRectToBGMapSetWC554
    ret

Jump_002_6A92::
    push de
    ld hl, wC314
    ld de, Data_002_6BA0
    ld b, $03
    call CopyRowsToScreenBufferAndClearAttributes
    pop de
    ld l, e
    ld h, d
    ld bc, $1405
    call CopyScreenRectToBGMapSetWC554
    ret

; entry 1 of the `rst $00` table in Func_002_69D0
; no direct call (reached through a table, a jump or a vector)
; reads: wC8CB
; points at: wC314, wC328
Func_002_69D0_Case01::
Jump_002_6AA8:: ; address name
    ld a, [wC8CB]
    bit 0, a
    jr z, Jump_002_6AC5
    push de
    ld hl, wC314
    ld de, Data_002_6BA0
    ld b, $03
    call CopyRowsToScreenBufferAndClearAttributes
    pop de
    ld l, e
    ld h, d
    ld bc, $1405
    call CopyScreenRectToBGMapSetWC554
    ret

Jump_002_6AC5::
    push de
    ld hl, wC328
    ld de, Data_002_6B8C
    ld b, $01
    call CopyRowsToScreenBufferAndClearAttributes
    pop de
    ld l, e
    ld h, d
    ld bc, $1405
    call CopyScreenRectToBGMapSetWC554
    ret

; entry 2 of the `rst $00` table in Func_002_69D0
; no direct call (reached through a table, a jump or a vector)
; reads: wC8CB
; writes: wC8CB, wC8CC
; points at: wC300
Func_002_69D0_Case02::
Jump_002_6ADB:: ; address name
    ld a, [wC8CB]
    bit 0, a
    jr z, Jump_002_6B04
    push de
    ld hl, wC300
    ld de, Data_002_6BDC
    ld b, $05
    call CopyRowsToScreenBufferAndClearAttributes
    pop de
    ld l, e
    ld h, d
    ld bc, $1405
    call CopyScreenRectToBGMapSetWC554
    ld a, [wC8CB]
    and a, $80
    ld [wC8CB], a
    xor a, a
    ld [wC8CC], a
    ret

Jump_002_6B04::
    ld l, e
    ld h, d
    ld bc, $1405
    call CopyScreenRectToBGMapSetWC554
    ld a, [wC8CB]
    and a, $80
    ld [wC8CB], a
    xor a, a
    ld [wC8CC], a
    ret

; copies a rectangle of the screen buffer wC300 to the BG map (CopyRectFromBankToBGMapWrapped) and sets wC554 = HL + $21 (wrapped in the map); on CGB also copies the attributes from wD168 in VRAM bank 1 (E-0121)
; 7 call sites from 4 routines (e.g. Func_002_64E5, Func_002_69D0_Case02, Func_002_69D0_Case01, Func_002_69D0_Case00)
; reads: wIsCGB
; writes: wC554, wC555, rVBK, rSVBK
; points at: wC300, wD168
CopyScreenRectToBGMapSetWC554::
Func_002_6B19:: ; address name
    push bc
    push hl
    ld de, wC300
    xor a, a
    call CopyRectFromBankToBGMapWrapped
    pop hl
    push hl
    ld a, h
    and a, $9C
    push af
    ld a, $21
    add_a_to_hl
    ld a, h
    and a, $03
    ld h, a
    pop af
    or a, h
    ld h, a
    ld a, l
    ld [wC554], a
    ld a, h
    ld [wC555], a
    pop hl
    pop bc
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, $01
    ldh [rVBK], a
    ld a, $02
    ldh [rSVBK], a
    ld de, wD168
    xor a, a
    call CopyRectFromBankToBGMapWrapped
    ld a, $00
    ldh [rVBK], a
    ld a, $00
    ldh [rSVBK], a
    ret

; copies B rows of 20 bytes from DE to HL; on CGB also clears the matching attribute rows in WRAM bank 2 (HL + $E68) (E-0125)
; 5 call sites from 3 routines (e.g. Func_002_69D0_Case02, Func_002_69D0_Case01, Func_002_69D0_Case00)
; reads: wIsCGB
; writes: rSVBK
CopyRowsToScreenBufferAndClearAttributes::
Func_002_6B5D:: ; address name
    push hl
    push bc

Jump_002_6B5F::
    ld c, $14

Jump_002_6B61::
    ld a, [de]
    inc de
    ld [hl+], a
    dec c
    jr nz, Jump_002_6B61
    dec b
    jr nz, Jump_002_6B5F
    pop bc
    pop hl
    ld a, l
    add a, $68
    ld l, a
    ld a, h
    adc a, $0E
    ld h, a
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, $02
    ldh [rSVBK], a

Jump_002_6B7D::
    ld c, $14

Jump_002_6B7F::
    xor a, a
    ld [hl+], a
    dec c
    jr nz, Jump_002_6B7F
    dec b
    jr nz, Jump_002_6B7D
    ld a, $00
    ldh [rSVBK], a
    ret

Data_002_6B8C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B6
    ds $12, $C3
    db $B7

Data_002_6BA0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0
    ds $12, $B1
    db $B2, $B6
    ds $12, $C3
    db $B7, $B3
    ds $12, $B4
    db $B5

Data_002_6BDC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0
    ds $12, $B1
    db $B2, $B6, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8A, $8B, $8C, $8D
    db $8E, $8F, $90, $91, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $92, $93, $94, $95, $96, $97, $98, $99, $9A, $9B, $9C, $9D, $9E, $9F
    db $A0, $A1, $A2, $A3, $B7, $B3
    ds $12, $B4
    db $B5

; runs the routine for wC46B & $0F (jump table) (E-0122)
; 1 call site from 1 routine (e.g. FieldModeStateDispatch_Case06)
; reads: wC46B
RunWC46BMenuState::
Func_002_6C40:: ; address name
    ld a, [wC46B]
    or a, a
    jr nz, Jump_002_6C46

Jump_002_6C46::
    ld a, [wC46B]
    and a, $0F
    rst $00
    dw RunWC46BMenuState_Case00
    dw RunWC46BMenuState_Case01
    dw RunWC46BMenuState_Case02
    dw RunWC46BMenuState_Case03
    dw RunWC46BMenuState_Case04
    dw RunWC46BMenuState_Case05
    dw RunWC46BMenuState_Case06
    dw RunWC46BMenuState_Case06
    dw RunWC46BMenuState_Case06

; entry 6 of the `rst $00` table in RunWC46BMenuState
; no direct call (reached through a table, a jump or a vector)
RunWC46BMenuState_Case06::
Jump_002_6C5E:: ; address name
    ret

; entry 0 of the `rst $00` table in RunWC46BMenuState
; no direct call (reached through a table, a jump or a vector)
; reads: wC914
; writes: wC46C, wC46E
; points at: wC46B
RunWC46BMenuState_Case00::
Jump_002_6C5F:: ; address name
    ld a, $02
    call QueueMusic
    call InitSoundHardware
    ld hl, wC46B
    inc [hl]
    ld a, [wC914]
    bit 7, a
    jr z, Jump_002_6C7F
    xor a, a
    ld [wC46C], a
    ld [wC46E], a
    ld a, $78
    call QueueSoundEffect
    ret

Jump_002_6C7F::
    xor a, a
    ld [wC46C], a
    ld a, $3B
    ld [wC46E], a
    ret

; entry 1 of the `rst $00` table in RunWC46BMenuState
; no direct call (reached through a table, a jump or a vector)
; reads: wC46E, hScrollX
; writes: wC46E, wC46C, wC46D, wC46F, wC470, wC471, wC472, wD780, ...
; points at: wC0F0, wC46B
RunWC46BMenuState_Case01::
Jump_002_6C89:: ; address name
    ld a, [wC46E]
    inc a
    ld [wC46E], a
    cp a, $3C
    ret c
    ld a, $61
    call QueueSoundEffect
    call RunWC46BMenuState_Case01_Sub02
    xor a, a
    ld [wC46C], a
    ld [wC46D], a
    ld [wC46E], a
    ld [wC46F], a
    ld [wC470], a
    ld [wC471], a
    ld [wC472], a
    ld hl, wC0F0
    ld b, $90

Jump_002_6CB6::
    ldh a, [hScrollX]
    ld [hl+], a
    dec b
    jr nz, Jump_002_6CB6
    ld hl, wC46B
    inc [hl]
    ld a, $1E
    ld [wC46D], a
    xor a, a
    ld [wD780], a
    ld [wD782], a
    call RunWC46BMenuState_Case01_Sub01
    xor a, a
    ld [wD780], a
    ret

; only called from RunWC46BMenuState_Case01 (E-0047)
; 1 call site from 1 routine (e.g. RunWC46BMenuState_Case01)
; reads: hScrollY, hScrollX
RunWC46BMenuState_Case01_Sub02::
Func_002_6CD4:: ; address name
    ldh a, [hScrollY]
    and a, $F8
    ld l, a
    ld h, $00
    sla l
    rl h
    sla l
    rl h
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $98
    ld h, a
    ld a, h
    and a, $9B
    ld h, a
    ldh a, [hScrollX]
    srl a
    srl a
    srl a
    add a, $14
    and a, $1F
    add_a_to_hl
    ld c, $12

Jump_002_6D02::
    push hl
    ld b, $0C

Jump_002_6D05::
    ld a, $C4
    call WriteVRAMByte
    ld a, l
    push af
    and a, $E0
    ld l, a
    pop af
    inc a
    and a, $1F
    or a, l
    ld l, a
    dec b
    jr nz, Jump_002_6D05
    pop hl
    ld a, $20
    add_a_to_hl
    ld a, h
    and a, $9B
    ld h, a
    dec c
    jr nz, Jump_002_6D02
    ret

; entry 2 of the `rst $00` table in RunWC46BMenuState
; no direct call (reached through a table, a jump or a vector)
; reads: wC46D
; writes: wC46C, wC46D, wC46E, rLYC, wC5E1
; points at: wC46B
RunWC46BMenuState_Case02::
Jump_002_6D28:: ; address name
    ld a, [wC46D]
    and a, $01
    ld [wC46C], a
    ld a, [wC46D]
    dec a
    ld [wC46D], a
    ret nz
    ld hl, wC46B
    inc [hl]
    ld a, $01
    ld [wC46E], a
    di
    ld a, $02
    ldh [rLYC], a
    ld a, $02
    ld [wC5E1], a
    ei
    ret

; entry 3 of the `rst $00` table in RunWC46BMenuState
; no direct call (reached through a table, a jump or a vector)
; reads: wFrameCounterLo, wC46E, hFFC6, hScrollX, hFFC7
; writes: wC46C, wC46E, wC46F, hFFC6, hFFC7
; points at: wC46B, wC0F0, wC114, wC138, wC15C
RunWC46BMenuState_Case03::
Jump_002_6D4D:: ; address name
    ld a, $01
    ld [wC46C], a
    ld a, [wFrameCounterLo]
    and a, $07
    jr nz, Jump_002_6D75
    ld a, [wC46E]
    swap a
    and a, $0F
    inc a
    ld b, a
    ld a, [wC46E]
    add a, b
    ld [wC46E], a
    cp a, $38
    jr c, Jump_002_6D75
    ld hl, wC46B
    inc [hl]
    xor a, a
    ld [wC46F], a

Jump_002_6D75::
    ld a, [wC46E]
    ldh [hFFC6], a
    ld a, [wFrameCounterLo]
    rra
    rra
    and a, $0F
    ld e, a
    ld d, $00
    ld a, [wFrameCounterLo]
    and a, $03
    cp a, $00
    jr nz, Jump_002_6D96
    ld bc, wC0F0
    ld a, $24
    ldh [hFFC7], a
    jr Jump_002_6DB7

Jump_002_6D96::
    cp a, $01
    jr nz, Jump_002_6DA3
    ld bc, wC114
    ld a, $48
    ldh [hFFC7], a
    jr Jump_002_6DB7

Jump_002_6DA3::
    cp a, $02
    jr nz, Jump_002_6DB0
    ld bc, wC138
    ld a, $6C
    ldh [hFFC7], a
    jr Jump_002_6DB7

Jump_002_6DB0::
    ld bc, wC15C
    ld a, $90
    ldh [hFFC7], a

Jump_002_6DB7::
    inc e
    ld a, e
    and a, $0F
    ld e, a
    ld hl, Data_002_6DDE
    add hl, de
    push bc
    ld c, [hl]
    ldh a, [hFFC6]
    call Multiply8
    pop bc
    bit 3, e
    jr z, Jump_002_6DD1
    ldh a, [hScrollX]
    sub a, h
    jr Jump_002_6DD4

Jump_002_6DD1::
    ldh a, [hScrollX]
    add a, h

Jump_002_6DD4::
    ld [bc], a
    inc bc
    ld [bc], a
    inc bc
    ldh a, [hFFC7]
    cp a, c
    jr nz, Jump_002_6DB7
    ret

Data_002_6DDE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $60, $B6, $EC, $FF, $EC, $B6, $60, $00, $60, $B6, $EC, $FF, $EC, $B6, $60

; entry 4 of the `rst $00` table in RunWC46BMenuState
; no direct call (reached through a table, a jump or a vector)
; reads: wFrameCounterLo, wC46F, wC46E, hFFC6, hScrollX, hFFC7
; writes: wC46F, wC5E1, wC5E9, hFFC6, hFFC7
; points at: wC46B, wC0F0, wC114, wC138, wC15C
RunWC46BMenuState_Case04::
Jump_002_6DEE:: ; address name
    ld a, [wFrameCounterLo]
    and a, $0F
    jr nz, Jump_002_6E0B
    ld a, [wC46F]
    inc a
    ld [wC46F], a
    cp a, $04
    jr nz, Jump_002_6E0B
    call RunWC46BMenuState_Case04_Sub01
    ld hl, wC46B
    inc [hl]
    xor a, a
    ld [wC5E1], a

Jump_002_6E0B::
    ld a, [wC46F]
    ld hl, Data_002_6E20
    add_a_to_hl
    ld a, [hl]
    ld [wC5E9], a
    call RunWC46BMenuState_Case04_Sub01
    jp Jump_002_6D75

Data_002_6E20:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $D2, $81, $40, $00, $00

; entry 5 of the `rst $00` table in RunWC46BMenuState
; no direct call (reached through a table, a jump or a vector)
; reads: wC914, wC8CA, wCD0D, wCD0E, wC8C8, wC8C9, hPlayerFacing, hPlayerX, ...
; writes: wD780, wD783, wD781, wCC44, wMapWidthScreens, wMapHeightScreens, hPlayerFacing, hPlayerX, ...
; points at: wModeChangeRequest
RunWC46BMenuState_Case05::
Jump_002_6E25:: ; address name
    call InitSoundHardware
    farcall RestartMapMusic
    xor a, a
    ld [wD780], a
    ld [wD783], a
    ld [wD781], a
    ld a, [wC914]
    bit 7, a
    jr nz, Jump_002_6EBA
    ld a, [wC8CA]
    cp a, $F0
    jr nz, Jump_002_6E59
    push af
    ld a, $80
    ld [wCC44], a
    ld a, [wCD0D]
    ld [wMapWidthScreens], a
    ld a, [wCD0E]
    ld [wMapHeightScreens], a
    pop af

Jump_002_6E59::
    cp a, $FF
    jr z, Jump_002_6E61
    ld a, $00
    ldh [hPlayerFacing], a

Jump_002_6E61::
    xor a, a
    ldh [hPlayerFacing], a
    ld a, [wC8C8]
    ldh [hPlayerX], a
    ld a, [wC8C9]
    ldh [hPlayerY], a
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords], a
    ld [wC8F4], a
    ld [wC8F9], a
    ldh a, [hPlayerX]
    ld [wC8F0], a
    ld [wC8F5], a
    ld [wC8FA], a
    ldh a, [hPlayerY]
    ld [wC8F1], a
    ld [wC8F6], a
    ld [wC8FB], a
    ld a, [wCC44]
    bit 7, a
    jr nz, Jump_002_6EA5
    ld a, $01
    ld [wGameMode], a
    ld a, $00
    ld [wModeState], a
    ld hl, wModeChangeRequest
    inc [hl]
    ret

Jump_002_6EA5::
    ld a, $01
    ld [wGameMode], a
    ld a, $05
    ld [wModeState], a
    ld hl, wModeChangeRequest
    inc [hl]
    farcall RunWC46BMenuState_Case05_Sub02
    ret

Jump_002_6EBA::
    ld a, [wCC44]
    bit 7, a
    jr z, Jump_002_6EC7
    farcall SaveWCD07RecordToSRAMSlotWCC42

Jump_002_6EC7::
    ld a, [wC833]
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
    jp z, Jump_002_6F59
    push hl
    ld a, $01
    ld [wGameMode], a
    ld a, $00
    ld [wModeState], a
    ld hl, wModeChangeRequest
    inc [hl]
    pop hl
    ld a, [hl]
    and a, $3F
    push af
    add a, a
    add a, a
    add a, a
    ld hl, Data_002_7006
    add_a_to_hl
    ld a, [hl+]
    ldh [hMapId], a
    ld a, [hl+]
    ldh [hMapScreenX], a
    ld a, [hl+]
    ldh [hMapScreenY], a
    ld a, [hl+]
    ldh [hPlayerX], a
    ld a, [hl]
    ldh [hPlayerY], a
    xor a, a
    ld [wC950], a
    xor a, a
    ld [wCC44], a
    ld a, $80
    ld [wC893], a
    xor a, a
    ld [wCCE9], a
    ld de, $0165
    call TestFlagBit
    jr nc, Jump_002_6F2D
    ld de, $0167
    call SetFlagBit

Jump_002_6F2D::
    ld de, $01C4
    call TestFlagBit
    jr nc, Jump_002_6F3B
    ld de, $01C5
    call SetFlagBit

Jump_002_6F3B::
    pop af
    cp a, $01
    jp nz, Jump_002_6FDE
    ld a, $1A
    ld [wC916], a
    xor a, a
    ld [wC917], a
    farcall DispatchTalkEvent
    farcall FetchScriptCommand
    jp Jump_002_6FDE

Jump_002_6F59::
    ld a, [hl]
    bit 7, a
    jr nz, Jump_002_6F73
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    ld [wCD05], a
    farcall RunWC46BMenuState_Case05_Sub01
    farcall SaveWCD07RecordToSRAMSlotWCC42
    jr Jump_002_6F7E

Jump_002_6F73::
    and a, $3F
    ld [wCC42], a
    farcall LoadWCD07RecordFromSRAMSlotWCC42

Jump_002_6F7E::
    ld a, $80
    ld [wC893], a
    ld a, $01
    ld [wGameMode], a
    ld a, $05
    ld [wModeState], a
    ld hl, wModeChangeRequest
    inc [hl]
    ld a, [wCD0D]
    ld [wMapWidthScreens], a
    ld a, [wCD0E]
    ld [wMapHeightScreens], a
    ld a, [wCD08]
    swap a
    and a, $0F
    ldh [hMapScreenX], a
    ld a, [wCD08]
    and a, $0F
    ldh [hMapScreenY], a
    ld a, [wCD09]
    ldh [hPlayerX], a
    ld a, [wCD0A]
    ldh [hPlayerY], a
    xor a, a
    ld [wC950], a
    ld a, $80
    ld [wCC44], a
    farcall MarkVisitedMapScreenInWCE93
    ld a, $87
    ld [wCC44], a
    ld a, $01
    ld [wMapWidthScreens], a
    ld [wMapHeightScreens], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $40
    ldh [hPlayerX], a
    ldh [hPlayerY], a

Jump_002_6FDE::
    xor a, a
    ldh [hPlayerFacing], a
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords], a
    ld [wC8F4], a
    ld [wC8F9], a
    ldh a, [hPlayerX]
    ld [wC8F0], a
    ld [wC8F5], a
    ld [wC8FA], a
    ldh a, [hPlayerY]
    ld [wC8F1], a
    ld [wC8F6], a
    ld [wC8FB], a
    xor a, a
    ldh [hFF93], a
    ret

Data_002_7006:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $00B006, $68

; with SRAM bank 1 selected: hFFC6 = 1 when sBB00 is not the signature $55 (no save); otherwise 2 when VerifySaveBank1Checksum or VerifySaveBank3Checksum returns non-zero (damaged save), else 0 (valid); then disables SRAM (E-0109)
; 4 call sites from 4 routines (e.g. DebugBattleSetup_Update_Sub01, GameMode5_Init_Case01, Func_015_6B00, Func_016_75EE)
; reads: sBB00
; writes: rRAMG, rRAMB, hFFC6
CheckSaveData::
Func_002_706E:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, $01
    ld [rRAMB], a
    ld a, [sBB00]
    cp a, $55
    jr z, Jump_002_7083
    ld a, $01
    jr Jump_002_7098

Jump_002_7083::
    call VerifySaveBank1Checksum
    or a, a
    jr z, Jump_002_708D
    ld a, $02
    jr Jump_002_7098

Jump_002_708D::
    call VerifySaveBank3Checksum
    or a, a
    jr z, Jump_002_7097
    ld a, $02
    jr Jump_002_7098

Jump_002_7097::
    xor a, a

Jump_002_7098::
    ldh [hFFC6], a
    xor a, a
    ld [rRAMG], a
    ld [rRAMB], a
    ret

; sums the SRAM bank-1 bytes from sA06F into the word DE (the loop adds several bytes per pass; the comparison at the end is not read) and returns A non-zero on a mismatch, as CheckSaveData uses it (E-0109)
; 1 call site from 1 routine (e.g. CheckSaveData)
; writes: rRAMB
; points at: sA06F, sBA73
VerifySaveBank1Checksum::
Func_002_70A2:: ; address name
    ld a, $01
    ld [rRAMB], a
    ld hl, sA06F
    ld bc, $029A
    ld de, $0000

Jump_002_70B0::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_70B6
    inc d

Jump_002_70B6::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_70BC
    inc d

Jump_002_70BC::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_70C2
    inc d

Jump_002_70C2::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_70C8
    inc d

Jump_002_70C8::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_70CE
    inc d

Jump_002_70CE::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_70D4
    inc d

Jump_002_70D4::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_70DA
    inc d

Jump_002_70DA::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_70E0
    inc d

Jump_002_70E0::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_70E6
    inc d

Jump_002_70E6::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_70EC
    inc d

Jump_002_70EC::
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_002_70B0
    ld a, e
    xor a, $FF
    ld e, a
    ld a, d
    xor a, $FF
    ld d, a
    ld a, e
    add a, $21
    ld e, a
    ld a, d
    adc a, $43
    ld d, a
    ld hl, sBA73
    ld a, [hl+]
    cp a, e
    jr nz, Jump_002_710E
    ld a, [hl]
    cp a, d
    jr nz, Jump_002_710E
    xor a, a
    ret

Jump_002_710E::
    ld a, $01
    ret

; sums the SRAM bank-3 bytes from sA000 into the word DE (comparison not read) and returns A non-zero on a mismatch, as CheckSaveData uses it (E-0109)
; 1 call site from 1 routine (e.g. CheckSaveData)
; writes: rRAMB
; points at: sA000
VerifySaveBank3Checksum::
Func_002_7111:: ; address name
    ld a, $03
    ld [rRAMB], a
    ld hl, sA000
    ld bc, $0333
    ld de, $0000

Jump_002_711F::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_7125
    inc d

Jump_002_7125::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_712B
    inc d

Jump_002_712B::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_7131
    inc d

Jump_002_7131::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_7137
    inc d

Jump_002_7137::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_713D
    inc d

Jump_002_713D::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_7143
    inc d

Jump_002_7143::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_7149
    inc d

Jump_002_7149::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_714F
    inc d

Jump_002_714F::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_7155
    inc d

Jump_002_7155::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_715B
    inc d

Jump_002_715B::
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_002_711F
    ld a, e
    xor a, $FF
    ld e, a
    ld a, d
    xor a, $FF
    ld d, a
    ld a, e
    add a, $34
    ld e, a
    ld a, d
    adc a, $12
    ld d, a
    ld a, [hl+]
    cp a, e
    jr nz, Jump_002_717A
    ld a, [hl]
    cp a, d
    jr nz, Jump_002_717A
    xor a, a
    ret

Jump_002_717A::
    ld a, $01
    ret

; with SRAM enabled, steps by wC8C3: on the first call (0) sets it to 1 and runs CopySaveBlocksToSRAM and three more save routines; on the second runs Func_002_71B2; afterwards sets bit 7 of wC8C3 (finished); disables SRAM each time (E-0109)
; 9 call sites from 9 routines (e.g. DebugBattleSetup_Update_Sub01, GameMode5_Init_Case02, GameMode5_Init_Case03, GameMode5_Init_Case04, ...)
; reads: wC8C3
; writes: rRAMG, wC8C3, rRAMB
RunSaveSteps::
Func_002_717D:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC8C3]
    or a, a
    jr nz, Jump_002_719A
    inc a
    ld [wC8C3], a
    call CopySaveBlocksToSRAM
    call RunSaveSteps_Sub01
    call Func_002_71ED
    call RunSaveSteps_Sub02
    jr Jump_002_71AA

Jump_002_719A::
    dec a
    jr nz, Jump_002_71A2
    call ScanBank1RecordStepWC8C4
    jr Jump_002_71AA

Jump_002_71A2::
    ld a, [wC8C3]
    or a, $80
    ld [wC8C3], a

Jump_002_71AA::
    xor a, a
    ld [rRAMG], a
    ld [rRAMB], a
    ret

; runs Func_01D_7492 for SRAM bank 1 record wC8C4 ($A06F + $6F * index); when wD7F5 is $FF advances wC8C4 and, after record 30, increments wC8C3 (E-0121)
; 2 call sites from 2 routines (e.g. RunSaveSteps, RunBank1RecordScanSteps)
; reads: wC8C4, wD7F5
; writes: wD7F1, wD7F3, wD7F4, wD7F2, wC8C4
; points at: wC8C3
ScanBank1RecordStepWC8C4::
Func_002_71B2:: ; address name
    ld a, [wC8C4]
    ld [wD7F1], a
    ld c, $6F
    call Multiply8
    ld a, l
    add a, $6F
    ld l, a
    ld a, h
    adc a, $A0
    ld h, a
    ld a, l
    ld [wD7F3], a
    ld a, h
    ld [wD7F4], a
    ld a, $01
    ld [wD7F2], a
    farcall Func_01D_7492
    ld a, [wD7F5]
    cp a, $FF
    ret nz
    ld a, [wC8C4]
    inc a
    ld [wC8C4], a
    cp a, $1E
    ret nz
    ld hl, wC8C3
    inc [hl]
    ret

; 2 call sites from 2 routines (e.g. RunSaveSteps, RunBank1RecordScanSteps)
; writes: rRAMB
; points at: sAD71, sB356, sA000
Func_002_71ED::
    ld hl, sAD71
    ld de, sB356
    ld bc, $0309

Jump_002_71F6::
    push bc
    ld a, $01
    ld [rRAMB], a
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    ld b, a
    xor a, a
    ld [rRAMB], a
    ld a, c
    ld [de], a
    inc de
    ld a, b
    ld [de], a
    inc de
    ld a, $01
    ld [rRAMB], a
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    ld b, a
    xor a, a
    ld [rRAMB], a
    ld a, c
    ld [de], a
    inc de
    ld a, b
    ld [de], a
    inc de
    pop bc
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_002_71F6
    ld b, $6F

Jump_002_7225::
    ld a, $01
    ld [rRAMB], a
    ld a, [hl+]
    ld c, a
    xor a, a
    ld [rRAMB], a
    ld a, c
    ld [de], a
    inc de
    dec b
    jr nz, Jump_002_7225
    ld a, $01
    ld [rRAMB], a
    ld de, sA000
    ld b, $6F

Jump_002_7240::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_002_7240
    ret

; only called from RunSaveSteps (E-0047)
; 1 call site from 1 routine (e.g. RunSaveSteps)
; writes: rRAMB
; points at: sA000
RunSaveSteps_Sub01::
Func_002_7247:: ; address name
    ld hl, sA000
    ld bc, $0333

Jump_002_724D::
    push bc
    ld a, $03
    ld [rRAMB], a
    ld a, [hl+]
    ld c, a
    ld a, [hl-]
    ld b, a
    ld a, $02
    ld [rRAMB], a
    ld a, c
    ld [hl+], a
    ld a, b
    ld [hl+], a
    ld a, $03
    ld [rRAMB], a
    ld a, [hl+]
    ld c, a
    ld a, [hl-]
    ld b, a
    ld a, $02
    ld [rRAMB], a
    ld a, c
    ld [hl+], a
    ld a, b
    ld [hl+], a
    ld a, $03
    ld [rRAMB], a
    ld a, [hl+]
    ld c, a
    ld a, [hl-]
    ld b, a
    ld a, $02
    ld [rRAMB], a
    ld a, c
    ld [hl+], a
    ld a, b
    ld [hl+], a
    ld a, $03
    ld [rRAMB], a
    ld a, [hl+]
    ld c, a
    ld a, [hl-]
    ld b, a
    ld a, $02
    ld [rRAMB], a
    ld a, c
    ld [hl+], a
    ld a, b
    ld [hl+], a
    ld a, $03
    ld [rRAMB], a
    ld a, [hl+]
    ld c, a
    ld a, [hl-]
    ld b, a
    ld a, $02
    ld [rRAMB], a
    ld a, c
    ld [hl+], a
    ld a, b
    ld [hl+], a
    pop bc
    dec bc
    ld a, b
    or a, c
    jp nz, Jump_002_724D
    ret

; with SRAM bank 1 selected, walks the list at Data_002_75F7 (word address, word length; a zero address ends it) and copies each WRAM block to SRAM from sBB01 onward (the copy loop is not read to its end) (E-0109)
; 1 call site from 1 routine (e.g. RunSaveSteps)
; reads: hFFC6, hFFC7
; writes: rRAMB, hFFC6, hFFC7, wC88D
; points at: sBB01
CopySaveBlocksToSRAM::
Func_002_72B0:: ; address name
    ld a, $01
    ld [rRAMB], a
    ld hl, Data_002_75F7
    ld de, sBB01

Jump_002_72BB::
    push hl
    ld a, [hl+]
    ldh [hFFC6], a
    ld a, [hl+]
    ldh [hFFC7], a
    ld a, [hl+]
    ld c, a
    ld a, [hl]
    ld b, a
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ld a, l
    or a, h
    jr nz, Jump_002_72D7
    pop hl
    ld a, $80
    ld [wC88D], a
    ret

Jump_002_72D7::
    ld a, [de]
    ld [hl+], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_002_72D7
    pop hl
    ld a, $04
    add_a_to_hl
    jr Jump_002_72BB

; only called from RunSaveSteps (E-0047)
; 1 call site from 1 routine (e.g. RunSaveSteps)
; reads: sBEF3
; writes: rSVBK, rRAMB
; points at: sBEC0, wCE9B
RunSaveSteps_Sub02::
Func_002_72E9:: ; address name
    xor a, a
    ldh [rSVBK], a
    ld a, $01
    ld [rRAMB], a
    ld hl, sBEC0
    ld a, [sBEF3]
    cp a, $01
    jr z, Jump_002_72FF
    and a, a
    jr z, Jump_002_72FF
    ret

Jump_002_72FF::
    ld bc, $00D8
    ld de, wCE9B

Jump_002_7305::
    ld a, [hl+]
    ld [de], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_002_7305
    ret

; when wCECE is 0 or 1, copies the $D8 bytes at wCE9B to sBEC0 in SRAM bank 1 (E-0124)
; 1 call site from 1 routine (e.g. RunSaveGameSteps_7347)
; reads: wCECE
; writes: rRAMB, rSVBK
; points at: wCE9B, sBEC0
SaveWCE9BBlockToSRAMBank1::
Func_002_730E:: ; address name
    ld hl, wCE9B
    ld bc, $00D8
    ld de, sBEC0
    ld a, $01
    ld [rRAMB], a
    xor a, a
    ldh [rSVBK], a
    ld a, [wCECE]
    cp a, $01
    jr z, Jump_002_732A
    and a, a
    jr z, Jump_002_732A
    ret

Jump_002_732A::
    ld a, [hl+]
    ld [de], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_002_732A
    ret

; with SRAM enabled: on the first step (wC8C3 = 0) copies the save blocks with their checksum and continues with the next save stage (E-0122)
; 9 call sites from 9 routines (e.g. GameMode5_Update_Case02, RunWD06AState_6C12_Case08_Case04_Sub01, RunWD780StateWhenNotFading_1B_Case01_Case22, GameMode6_Init, ...)
; reads: wC8C3
; writes: rRAMG, wC8C3, rRAMB
RunSaveGameSteps::
Func_002_7333:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC8C3]
    or a, a
    jr nz, Jump_002_7364
    inc a
    ld [wC8C3], a
    call CopySaveBlocksToSRAMWithSum
    jr Jump_002_7359

; with SRAM enabled runs one save stage per call (sprites snapshot and blocks, then records, then the final stage marked by bit 7 of wC8C3) (E-0124)
; 3 call sites from 3 routines (e.g. RunWC0A4Screen_Case02, ScriptCommandF2_Run_Case03_Case0E, ScriptCommandED_Run_Case04_Case36)
; reads: wC8C3
; writes: rRAMG, wC8C3, rRAMB
RunSaveGameSteps_7347::
Func_002_7347:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC8C3]
    or a, a
    jr nz, Jump_002_7364
    inc a
    ld [wC8C3], a
    call SnapshotSpritesForSave

Jump_002_7359::
    call RunSaveGameSteps_7347_Sub01
    call Func_002_741B
    call SaveWCE9BBlockToSRAMBank1
    jr Jump_002_7377

Jump_002_7364::
    dec a
    jr nz, Jump_002_736C
    call SaveStepCopyBank1RecordWC8C4
    jr Jump_002_7377

Jump_002_736C::
    call Func_002_737F
    ld a, [wC8C3]
    or a, $80
    ld [wC8C3], a

Jump_002_7377::
    xor a, a
    ld [rRAMG], a
    ld [rRAMB], a
    ret

; 2 call sites from 2 routines (e.g. RunSaveGameSteps_7347, RunBattlePhaseWhenTextIdle_A0_Case03_Case01_Sub01)
; writes: rRAMB
; points at: sA06F, sBA73
Func_002_737F::
    ld a, $01
    ld [rRAMB], a
    ld hl, sA06F
    ld bc, $029A
    ld de, $0000

Jump_002_738D::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_7393
    inc d

Jump_002_7393::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_7399
    inc d

Jump_002_7399::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_739F
    inc d

Jump_002_739F::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_73A5
    inc d

Jump_002_73A5::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_73AB
    inc d

Jump_002_73AB::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_73B1
    inc d

Jump_002_73B1::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_73B7
    inc d

Jump_002_73B7::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_73BD
    inc d

Jump_002_73BD::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_73C3
    inc d

Jump_002_73C3::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_73C9
    inc d

Jump_002_73C9::
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_002_738D
    ld a, e
    xor a, $FF
    ld e, a
    ld a, d
    xor a, $FF
    ld d, a
    ld a, e
    add a, $21
    ld e, a
    ld a, d
    adc a, $43
    ld d, a
    ld hl, sBA73
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl], a
    ret

; copies SRAM bank-1 record wC8C4 ($6F bytes at sA06F + $6F * n) through Func_01D_6E39, then wC8C4 += 1; after 30 records wC8C3 += 1 (the next save step) (E-0120)
; 2 call sites from 2 routines (e.g. RunSaveGameSteps_7347, RunBattlePhaseWhenTextIdle_A0_Case03_Case01_Sub01)
; reads: wC8C4
; writes: wD7F1, wD7F3, wD7F4, wD7F2, wC8C4
; points at: wC8C3
SaveStepCopyBank1RecordWC8C4::
Func_002_73E6:: ; address name
    ld a, [wC8C4]
    ld [wD7F1], a
    ld c, $6F
    call Multiply8
    ld a, l
    add a, $6F
    ld l, a
    ld a, h
    adc a, $A0
    ld h, a
    ld a, l
    ld [wD7F3], a
    ld a, h
    ld [wD7F4], a
    ld a, $01
    ld [wD7F2], a
    farcall Func_01D_6E39
    ld a, [wC8C4]
    inc a
    ld [wC8C4], a
    cp a, $1E
    ret nz
    ld hl, wC8C3
    inc [hl]
    ret

; 2 call sites from 2 routines (e.g. RunSaveGameSteps_7347, RunBattlePhaseWhenTextIdle_A0_Case03_Case01_Sub01)
; writes: rRAMB
; points at: sB356, sAD71, sA000
Func_002_741B::
    ld hl, sB356
    ld de, sAD71
    ld bc, $0309

Jump_002_7424::
    push bc
    xor a, a
    ld [rRAMB], a
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    ld b, a
    ld a, $01
    ld [rRAMB], a
    ld a, c
    ld [de], a
    inc de
    ld a, b
    ld [de], a
    inc de
    xor a, a
    ld [rRAMB], a
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    ld b, a
    ld a, $01
    ld [rRAMB], a
    ld a, c
    ld [de], a
    inc de
    ld a, b
    ld [de], a
    inc de
    pop bc
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_002_7424
    ld b, $6F

Jump_002_7453::
    xor a, a
    ld [rRAMB], a
    ld a, [hl+]
    ld c, a
    ld a, $01
    ld [rRAMB], a
    ld a, c
    ld [de], a
    inc de
    dec b
    jr nz, Jump_002_7453
    ld hl, sA000
    ld b, $6F

Jump_002_7469::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_002_7469
    ret

; fills the $2000 bytes of SRAM banks 2 and 3 with $FF (E-0117)
; 1 call site from 1 routine (e.g. RunSaveGameSteps_7347_Sub01)
; writes: rRAMB
; points at: sA000
ClearSRAMBanks2And3::
Func_002_7470:: ; address name
    ld a, $02
    ld [rRAMB], a
    ld hl, sA000
    ld bc, $2000
    ld a, $FF
    call FillBytes
    ld a, $03
    ld [rRAMB], a
    ld hl, sA000
    ld bc, $2000
    ld a, $FF
    call FillBytes
    ret

; only called from RunSaveGameSteps_7347 (E-0047)
; 1 call site from 1 routine (e.g. RunSaveGameSteps_7347)
; reads: wC94E, wCC44
; writes: rRAMG, rRAMB
; points at: sA000
RunSaveGameSteps_7347_Sub01::
Func_002_7491:: ; address name
    ld a, [wC94E]
    or a, a
    jr z, Jump_002_749A
    call ClearSRAMBanks2And3

Jump_002_749A::
    ld a, [wCC44]
    bit 7, a
    jr z, Jump_002_74AC
    farcall SaveWCD07RecordToSRAMSlotWCC42
    ld a, $0A
    ld [rRAMG], a

Jump_002_74AC::
    ld hl, sA000
    ld bc, $0333
    ld de, $0000

Jump_002_74B5::
    push bc
    ld a, $02
    ld [rRAMB], a
    ld a, [hl+]
    ld c, a
    ld a, [hl-]
    ld b, a
    ld a, $03
    ld [rRAMB], a
    ld a, c
    ld [hl+], a
    add a, e
    ld e, a
    jr nc, Jump_002_74CB
    inc d

Jump_002_74CB::
    ld a, b
    ld [hl+], a
    add a, e
    ld e, a
    jr nc, Jump_002_74D2
    inc d

Jump_002_74D2::
    ld a, $02
    ld [rRAMB], a
    ld a, [hl+]
    ld c, a
    ld a, [hl-]
    ld b, a
    ld a, $03
    ld [rRAMB], a
    ld a, c
    ld [hl+], a
    add a, e
    ld e, a
    jr nc, Jump_002_74E7
    inc d

Jump_002_74E7::
    ld a, b
    ld [hl+], a
    add a, e
    ld e, a
    jr nc, Jump_002_74EE
    inc d

Jump_002_74EE::
    ld a, $02
    ld [rRAMB], a
    ld a, [hl+]
    ld c, a
    ld a, [hl-]
    ld b, a
    ld a, $03
    ld [rRAMB], a
    ld a, c
    ld [hl+], a
    add a, e
    ld e, a
    jr nc, Jump_002_7503
    inc d

Jump_002_7503::
    ld a, b
    ld [hl+], a
    add a, e
    ld e, a
    jr nc, Jump_002_750A
    inc d

Jump_002_750A::
    ld a, $02
    ld [rRAMB], a
    ld a, [hl+]
    ld c, a
    ld a, [hl-]
    ld b, a
    ld a, $03
    ld [rRAMB], a
    ld a, c
    ld [hl+], a
    add a, e
    ld e, a
    jr nc, Jump_002_751F
    inc d

Jump_002_751F::
    ld a, b
    ld [hl+], a
    add a, e
    ld e, a
    jr nc, Jump_002_7526
    inc d

Jump_002_7526::
    ld a, $02
    ld [rRAMB], a
    ld a, [hl+]
    ld c, a
    ld a, [hl-]
    ld b, a
    ld a, $03
    ld [rRAMB], a
    ld a, c
    ld [hl+], a
    add a, e
    ld e, a
    jr nc, Jump_002_753B
    inc d

Jump_002_753B::
    ld a, b
    ld [hl+], a
    add a, e
    ld e, a
    jr nc, Jump_002_7542
    inc d

Jump_002_7542::
    pop bc
    dec bc
    ld a, b
    or a, c
    jp nz, Jump_002_74B5
    ld a, e
    xor a, $FF
    ld e, a
    ld a, d
    xor a, $FF
    ld d, a
    ld a, e
    add a, $34
    ld e, a
    ld a, d
    adc a, $12
    ld d, a
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl], a
    ret

; wC83A = wCB7E and the $50 bytes of wSpriteSlots go to wC83B; then clears bit 1 of five object flag bytes at wC848, wC858, wC868, wC878 and wC888 (E-0109)
; 1 call site from 1 routine (e.g. RunSaveGameSteps_7347)
; reads: wCB7E, wC848, wC858, wC868, wC878, wC888, hFFC6, hFFC7, ...
; writes: wC83A, wC848, wC858, wC868, wC878, wC888, rRAMB, hFFC8, ...
; points at: wSpriteSlots, wC83B, sBB01
SnapshotSpritesForSave::
Func_002_755E:: ; address name
    ld a, [wCB7E]
    ld [wC83A], a
    ld hl, wSpriteSlots
    ld de, wC83B
    ld bc, $0050
    call CopyBytes
    ld a, [wC848]
    and a, $FD
    ld [wC848], a
    ld a, [wC858]
    and a, $FD
    ld [wC858], a
    ld a, [wC868]
    and a, $FD
    ld [wC868], a
    ld a, [wC878]
    and a, $FD
    ld [wC878], a
    ld a, [wC888]
    and a, $FD
    ld [wC888], a

; the same walk of Data_002_75F7 into SRAM from sBB01, also clearing the running sum in hFFC8/hFFC9 (accumulation not read to its end) (E-0109)
; 1 call site from 1 routine (e.g. RunSaveGameSteps)
; reads: hFFC6, hFFC7, hFFC8, hFFC9
; writes: rRAMB, hFFC8, hFFC9, hFFC6, hFFC7, sBB00, sBF98, sBF99
; points at: sBB01
CopySaveBlocksToSRAMWithSum::
Func_002_7598:: ; address name
    ld a, $01
    ld [rRAMB], a
    ld hl, Data_002_75F7
    ld de, sBB01
    xor a, a
    ldh [hFFC8], a
    ldh [hFFC9], a

Jump_002_75A8::
    push hl
    ld a, [hl+]
    ldh [hFFC6], a
    ld a, [hl+]
    ldh [hFFC7], a
    ld a, [hl+]
    ld c, a
    ld a, [hl]
    ld b, a
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ld a, l
    or a, h
    jr nz, Jump_002_75DA
    pop hl
    ld a, $55
    ld [sBB00], a
    ldh a, [hFFC8]
    ld l, a
    ldh a, [hFFC9]
    ld h, a
    ld a, l
    add a, $53
    ld l, a
    ld a, h
    adc a, $97
    ld h, a
    ld a, l
    ld [sBF98], a
    ld a, h
    ld [sBF99], a
    ret

Jump_002_75DA::
    ldh a, [hFFC8]
    add a, [hl]
    ldh [hFFC8], a
    ldh a, [hFFC9]
    adc a, $00
    ldh [hFFC9], a
    ld a, [hl+]
    ld [de], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_002_75DA
    pop hl
    ld a, $04
    add_a_to_hl
    jr Jump_002_75A8

Data_002_75F7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $8A, $FF, $0E, $00, $0C, $C6, $91, $02, $D7, $CB, $6B, $00, $42, $CC, $B5, $00
    db $00, $00, $00, $00

; 1 call site from 1 routine (e.g. Func_033_5215_Table2_Case05_Case0C)
; reads: sBB00, hFFC8, hFFC9, sBF98, sBF99
; writes: rRAMG, rRAMB, hFFC8, hFFC9
; points at: sBB01, hFF8A, wC60C, wCBD7, wCC42
Func_002_760B::
    ld a, $0A
    ld [rRAMG], a
    ld a, $01
    ld [rRAMB], a
    xor a, a
    ldh [hFFC8], a
    ldh [hFFC9], a
    ld a, [sBB00]
    cp a, $55
    jr nz, Jump_002_766D
    ld hl, sBB01
    ld de, hFF8A
    ld bc, $000E
    call CopyBytesWithChecksum_Bank02_7674
    ld de, wC60C
    ld bc, $0291
    call CopyBytesWithChecksum_Bank02_7674
    ld de, wCBD7
    ld bc, $006B
    call CopyBytesWithChecksum_Bank02_7674
    ld de, wCC42
    ld bc, $00B5
    call CopyBytesWithChecksum_Bank02_7674
    ldh a, [hFFC8]
    ld l, a
    ldh a, [hFFC9]
    ld h, a
    ld a, l
    add a, $53
    ld l, a
    ld a, h
    adc a, $97
    ld h, a
    ld a, [sBF98]
    ld c, a
    ld a, [sBF99]
    ld b, a
    ld a, c
    sub a, l
    ld c, a
    ld a, b
    sbc a, h
    ld b, a
    ld a, b
    or a, c
    jr z, Jump_002_766D
    xor a, a
    ld [rRAMG], a
    ret

Jump_002_766D::
    xor a, a
    ld [rRAMG], a
    ld c, $FF
    ret

; HL = source, DE = destination, BC = count: copies BC bytes and adds each one to the 16-bit sum in hFFC8/hFFC9; clobbers A, BC = 0 (E-0065) (the same 20 bytes appear in 2 banks)
; 4 call sites from 1 routine (e.g. Func_002_760B)
; reads: hFFC8, hFFC9
; writes: hFFC8, hFFC9
CopyBytesWithChecksum_Bank02_7674::
Func_002_7674:: ; address name
    ldh a, [hFFC8]
    add a, [hl]
    ldh [hFFC8], a
    ldh a, [hFFC9]
    adc a, $00
    ldh [hFFC9], a
    ld a, [hl+]
    ld [de], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, CopyBytesWithChecksum_Bank02_7674
    ret

; SRAM bank 1: copies hFF8A ($0E bytes), wC60C ($291), wCBD7 ($6B) and wCC42 ($B5) to sBB01 onward while summing them; stores sum + $9753 at sBF98 and $55 at sBB00 (E-0121)
; 2 call sites from 2 routines (e.g. Func_033_5215_Table2_Case05_Case0C, RunBattlePhaseWhenTextIdle_A0_Case03_Case01)
; reads: hFFC8, hFFC9
; writes: rRAMG, rRAMB, hFFC8, hFFC9, sBF98, sBF99, sBB00
; points at: sBB01, hFF8A, wC60C, wCBD7, wCC42
SaveGameToSRAMWithChecksum::
Func_002_7688:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, $01
    ld [rRAMB], a
    xor a, a
    ldh [hFFC8], a
    ldh [hFFC9], a
    ld de, sBB01
    ld hl, hFF8A
    ld bc, $000E
    call CopyBytesWithChecksum_Bank02
    ld hl, wC60C
    ld bc, $0291
    call CopyBytesWithChecksum_Bank02
    ld hl, wCBD7
    ld bc, $006B
    call CopyBytesWithChecksum_Bank02
    ld hl, wCC42
    ld bc, $00B5
    call CopyBytesWithChecksum_Bank02
    ldh a, [hFFC8]
    ld l, a
    ldh a, [hFFC9]
    ld h, a
    ld a, l
    add a, $53
    ld l, a
    ld a, h
    adc a, $97
    ld h, a
    ld a, l
    ld [sBF98], a
    ld a, h
    ld [sBF99], a
    ld a, $55
    ld [sBB00], a
    xor a, a
    ld [rRAMG], a
    ret

; HL = source, DE = destination, BC = count: copies BC bytes and adds each one to the 16-bit sum in hFFC8/hFFC9; clobbers A, BC = 0 (E-0065) (the same 20 bytes appear in 2 banks)
; 4 call sites from 1 routine (e.g. SaveGameToSRAMWithChecksum)
; reads: hFFC8, hFFC9
; writes: hFFC8, hFFC9
CopyBytesWithChecksum_Bank02::
Func_002_76DE:: ; address name
    ldh a, [hFFC8]
    add a, [hl]
    ldh [hFFC8], a
    ldh a, [hFFC9]
    adc a, $00
    ldh [hFFC9], a
    ld a, [hl+]
    ld [de], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, CopyBytesWithChecksum_Bank02
    ret

; with SRAM enabled: first call runs Func_002_71ED, then scans bank-1 records; after stage 2 sets wC8C3 = $80 (E-0124)
; no direct call (reached through a table, a jump or a vector)
; reads: wC8C3
; writes: rRAMG, wC8C3
RunBank1RecordScanSteps:: ; heuristic: follows a terminator; C0
Func_002_76F2:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC8C3]
    or a, a
    jr nz, Jump_002_7704
    inc a
    ld [wC8C3], a
    call Func_002_71ED

Jump_002_7704::
    call ScanBank1RecordStepWC8C4
    ld a, [wC8C3]
    cp a, $02
    jr nz, Jump_002_7713
    ld a, $80
    ld [wC8C3], a

Jump_002_7713::
    xor a, a
    ld [rRAMG], a
    ret

; only called from RunBattlePhaseWhenTextIdle_A0_Case03_Case01 (E-0047)
; 1 call site from 1 routine (e.g. RunBattlePhaseWhenTextIdle_A0_Case03_Case01)
; reads: wC8C3
; writes: rRAMG, wC8C3
RunBattlePhaseWhenTextIdle_A0_Case03_Case01_Sub01::
Func_002_7718:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC8C3]
    or a, a
    jr nz, Jump_002_772A
    inc a
    ld [wC8C3], a
    call Func_002_741B

Jump_002_772A::
    call SaveStepCopyBank1RecordWC8C4
    ld a, [wC8C3]
    cp a, $02
    jr nz, Jump_002_7741
    ld a, $0A
    ld [rRAMG], a
    call Func_002_737F
    ld a, $80
    ld [wC8C3], a

Jump_002_7741::
    xor a, a
    ld [rRAMG], a
    ret
    ds $8B9, $00

Data_002_7FFF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00
