SECTION "Bank 02", ROMX[$4000], BANK[$02]
    db $02

; only called from StartPaletteFade (E-0047)
; 1 call site from 1 routine (e.g. StartPaletteFade)
; reads: wFadeState, wFadeMode
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
    ld a, [wFadeMode]
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
; 1 call site from 1 routine (e.g. AdjustColorChannelForFade)
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
; reads: wFadeMode, wFadeLevel
FadeColorComponentFloor::
Func_002_4176:: ; address name
    push de
    ld a, [wFadeMode]
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
; reads: wFadeMode, wFadeLevel
FadeColorComponentAdd::
Func_002_426D:: ; address name
    push de
    ld a, [wFadeMode]
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
; 1 call site from 1 routine (e.g. BootAndMainLoop)
; reads: wIsCGB
; writes: wBGPaletteUploadRequest, wOBJPaletteUploadRequest
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
    ld [wBGPaletteUploadRequest], a
    ld hl, wOBJPaletteBuffer
    ld de, Data_002_4322
    ld bc, $0008
    call CopyBytesDEToHL_Bank00
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ret

; address loaded by LoadPalette0FromData4322
Data_002_4322:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $7C, $FF, $7F, $E0, $01, $00, $00

; only called from RunMenuStateMenuState_Case04 (E-0047)
; 2 call sites from 1 routine (e.g. RunMenuStateMenuState_Case04)
; reads: wIsCGB, wDMGPaletteBGP, wDMGPaletteOBP0
; writes: wDMGPaletteBytes
; points at: wDMGPaletteBytes
RunMenuStateMenuState_Case04_Sub01::
Func_002_432A:: ; address name
    ld a, [wIsCGB]
    or a, a
    ret z
    call RunScreenStateStepEveryOtherFrame
    ld hl, wDMGPaletteBytes
    ld a, [wDMGPaletteBGP]
    cp a, [hl]
    jp z, Jump_002_4519
    ld a, [wDMGPaletteBGP]
    ld [wDMGPaletteBytes], a
    jp Jump_002_4519

; wD781 += 1; on odd values, unless wD780 is $FF, runs the step for wD780 (jump table) (E-0122)
; 1 call site from 1 routine (e.g. RunMenuStateMenuState_Case04_Sub01)
; reads: wScreenStep, wScreenState
; writes: wScreenStep
RunScreenStateStepEveryOtherFrame::
Func_002_4345:: ; address name
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    bit 0, a
    jr nz, Jump_002_4351
    ret

Jump_002_4351::
    ld a, [wScreenState]
    cp a, $FF
    ret z
    rst $00
    dw RunScreenStateStepEveryOtherFrame_Case00
    dw RunScreenStateStepEveryOtherFrame_Case01
    dw RunScreenStateStepEveryOtherFrame_Case02
    dw RunScreenStateStepEveryOtherFrame_Case03

; entry 0 of the `rst $00` table in RunScreenStateStepEveryOtherFrame
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenCounter, rSTAT, wScreenState
; writes: wScreenState
; points at: wWorkBuf
RunScreenStateStepEveryOtherFrame_Case00::
Jump_002_4360:: ; address name
    ld hl, wWorkBuf
    ld a, [wScreenCounter]
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

; only called from RunScreenStateStepEveryOtherFrame_Case03 (E-0047)
; 1 call site from 1 routine (e.g. RunScreenStateStepEveryOtherFrame_Case03)
; reads: rSTAT, wScreenState
; writes: wScreenState
RunScreenStateStepEveryOtherFrame_Case03_Sub01::
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
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; entry 1 of the `rst $00` table in RunScreenStateStepEveryOtherFrame
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenCounter, rSTAT, wScreenState
; writes: wScreenState
RunScreenStateStepEveryOtherFrame_Case01::
Jump_002_43DA:: ; address name
    ld hl, wWorkBuf + $10
    ld a, [wScreenCounter]
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
    jp RunScreenStateStepEveryOtherFrame_Case03_Sub01

; entry 2 of the `rst $00` table in RunScreenStateStepEveryOtherFrame
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenCounter, rSTAT, wScreenState
; writes: wScreenState
RunScreenStateStepEveryOtherFrame_Case02::
Jump_002_43FD:: ; address name
    ld hl, wWorkBuf + $20
    ld a, [wScreenCounter]
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
    jp RunScreenStateStepEveryOtherFrame_Case03_Sub01

; entry 3 of the `rst $00` table in RunScreenStateStepEveryOtherFrame
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenCounter
; writes: wScreenCounter, wScreenSubStep, wScreenState
RunScreenStateStepEveryOtherFrame_Case03::
Jump_002_4420:: ; address name
    ld hl, wWorkBuf + $30
    ld a, [wScreenCounter]
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
    call RunScreenStateStepEveryOtherFrame_Case03_Sub01
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    cp a, $08
    jr c, Jump_002_445B
    xor a, a
    ld [wScreenSubStep], a
    ld [wScreenCounter], a
    ld a, $FF
    ld [wScreenState], a
    ret

Jump_002_445B::
    xor a, a
    ld [wScreenSubStep], a
    ld [wScreenState], a
    ret

; only called from RunMenuStateMenuState_Case01 (E-0047)
; 1 call site from 1 routine (e.g. RunMenuStateMenuState_Case01)
; reads: wScreenCounter
; writes: wScreenCounter
; points at: wBGPaletteBuffer, wWorkBuf
RunMenuStateMenuState_Case01_Sub01::
Func_002_4463:: ; address name
    ld hl, wBGPaletteBuffer
    ld de, wWorkBuf
    ld c, $04

Jump_002_446B::
    push bc
    push hl
    push de
    call RunMenuStateMenuState_Case01_Sub01_Sub01
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
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    cp a, $08
    jr c, Jump_002_446B
    xor a, a
    ld [wScreenCounter], a
    ret

; only called from RunMenuStateMenuState_Case01_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. RunMenuStateMenuState_Case01_Sub01)
; reads: wScreenCounter, wTextCounter2, wTextCounter3, wTextCounter4, wScreenSubStep
; writes: wTextCounter2, wTextCounter3, wTextCounter4, wScreenSubStep
; points at: wTextCounter2
RunMenuStateMenuState_Case01_Sub01_Sub01::
Func_002_449A:: ; address name
    ld c, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld a, b
    srl a
    srl a
    ld [wTextCounter2], a
    push bc
    sla c
    rl b
    sla c
    rl b
    sla c
    rl b
    ld a, b
    and a, $1F
    ld [wTextCounter3], a
    pop bc
    ld a, c
    and a, $1F
    ld [wTextCounter4], a
    push hl
    ld hl, Data_002_4510
    ld a, [wScreenCounter]
    add_a_to_hl
    ld b, [hl]
    ld hl, wTextCounter2
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
    ld a, [wTextCounter2]
    ld b, a
    ld a, [wTextCounter3]
    sla a
    sla a
    sla a
    ld c, a
    sla c
    rl b
    sla c
    rl b
    ld a, [wTextCounter4]
    or a, c
    ld c, a
    ld a, c
    ld [de], a
    inc de
    ld a, b
    ld [de], a
    inc de
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    cp a, $08
    jr c, RunMenuStateMenuState_Case01_Sub01_Sub01
    xor a, a
    ld [wScreenSubStep], a
    ret

; address loaded by RunMenuStateMenuState_Case01_Sub01_Sub01
Data_002_4510:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $04, $08, $0C, $10, $14, $18, $1C, $20, $24

Jump_002_4519::
    ld hl, wDMGPaletteBytes + $1
    ld a, [wDMGPaletteOBP0]
    cp a, [hl]
    jp z, Jump_002_45C1
    ld a, [wDMGPaletteOBP0]
    ld [wDMGPaletteBytes + $1], a
    jp Jump_002_45C1

; writes four colours of the palette at HL to rOBPD, each chosen by a 2-bit shade of wC5EA through Data_002_45C2; HL += 8 (E-0129)
; no direct call (reached through a table, a jump or a vector)
; reads: wDMGPaletteOBP0
; writes: rOBPD
WriteCGBObjPaletteFromDMGShadesDMGPaletteOBP0:: ; heuristic: follows a terminator; C0
Func_002_452C:: ; address name
    push hl
    ld a, [wDMGPaletteOBP0]
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
    ld a, [wDMGPaletteOBP0]
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
    ld a, [wDMGPaletteOBP0]
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
    ld a, [wDMGPaletteOBP0]
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

; address loaded by WriteCGBObjPaletteFromDMGShadesDMGPaletteOBP0
Data_002_45C2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $02, $04, $00, $06

; start-up for wGameMode = 1; forcing this mode on the emulator shows: water map with the player sprite (E-0029)
; 1 call site from 1 routine (e.g. RunGameModeInit_Case01)
; reads: hMapId, hMapScreenX, hMapScreenY, wSaveStateFlag, wFieldInitStage
; writes: rIF, wSGBPaletteSet, wSGBAttrFile, wFieldTransitionStep, wFieldInitStage, wLCDCShadow
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
    ld a, [wSaveStateFlag]
    or a, a
    call nz, InitSoundHardware
    call GameMode1_Init_Sub01
    call LoadSGBBorderForSetA
    ld b, $46
    ld de, Data_046_4001
    ld hl, vTiles1
    call DecompressToVRAM
    ld hl, Data_002_4AD6
    ld a, [hl]
    ld [wSGBPaletteSet], a
    ld hl, Data_002_4AD7
    ld a, [hl]
    ld [wSGBAttrFile], a
    farcall SendSGBPaletteSetPacket
    call InitFieldScreen
    xor a, a
    ld [wFieldTransitionStep], a
    ld a, [wFieldInitStage]
    or a, a
    jr nz, Jump_002_461A
    call InitSoundHardware
    call RestartMapMusic

Jump_002_461A::
    xor a, a
    ld [wFieldInitStage], a
    ld a, $03
    ld [wLCDCShadow], a
    ld a, $03
    jp Jump_000_077A

; enters the field: loads the map header, resets scroll and timers, reorders the party, loads names and sprites, finds triggers, draws the map screen and places objects (E-0129)
; 4 call sites from 4 routines (e.g. GameMode1_Init, FieldModeStateDispatch_Case04, ExitPauseMenuToField, EnterGameMode1WithDefaultPalettes)
; reads: wMapType, hMapId, wFieldReturnPhase, wFieldInitFlag, wFieldInitStage, wIsCGB
; writes: hFieldDrawFlags, hScrollY, hScrollX, hWindowY, hWindowX, rLYC, wFrameCounterLo, wFrameCounterHi, ...
InitFieldScreen::
Func_002_4628:: ; address name
    ld a, $0F
    ldh [hFieldDrawFlags], a
    call LoadMapHeader
    ld a, $00
    ldh [hScrollY], a
    ld a, $00
    ldh [hScrollX], a
    ld a, $80
    ldh [hWindowY], a
    ld a, $07
    ldh [hWindowX], a
    ld a, $67
    ldh [rLYC], a
    xor a, a
    ld [wFrameCounterLo], a
    ld [wFrameCounterHi], a
    ld a, $00
    ld [wSTATSplitEnable], a
    di
    call WaitForVRAMAccess
    ld a, $40
    ldh [rSTAT], a
    xor a, a
    ldh [rIF], a
    ei
    call MoveIncapacitatedPartyMembersBack
    call MoveIncapacitatedPartyMembersBack
    farcall SetupTownObjectsForMap
    farcall RefreshKeyWorldObjectsOnEntry
    call WritePlayerNameWithFlag0SuffixToTextBuf0
    ld a, [wMapType]
    bit 7, a
    jr nz, Jump_002_467D
    ldh a, [hMapId]
    cp a, $14
    jr z, Jump_002_4680

Jump_002_467D::
    call LoadRecordListNameTiles

Jump_002_4680::
    farcall LoadPlayerAndFollowerSpriteGraphics
    farcall FindTriggerEntryForCurrentScreen
    farcall FindTriggerEntryForCurrentScreen_ScreenTriggers
    xor a, a
    ld [wFieldActionRequest], a
    ld a, [wFieldReturnPhase]
    or a, a
    jr nz, Jump_002_46B3
    call LoadMapScreen
    farcall LoadMapObjectsForScreen
    farcall SetupMap0BMonsterObjects
    farcall ClearPendingFieldEventWhenFieldIdle
    jr Jump_002_46BC

Jump_002_46B3::
    call RestoreScreenBufferFromBGMap1
    farcall SetupMap0BMonsterObjects

Jump_002_46BC::
    ld hl, vBGMap0
    call DrawFullScreenBufferToBGMap
    xor a, a
    ld [wObject5], a
    farcall PlaceSpecialMapObjectsOnEntry
    xor a, a
    ld [wTextWindowState], a
    ld [wTextWindowStep], a
    ld [wPartyWindowFlags], a
    ld [wPartyWindowTimer], a
    ld a, [wFieldInitFlag]
    bit 7, a
    jr z, Jump_002_46EE
    and a, $7F
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    xor a, a
    ld [wFieldInitFlag], a

Jump_002_46EE::
    ld a, [wFieldInitStage]
    or a, a
    jr nz, Jump_002_46F7
    call RestartMapMusic

Jump_002_46F7::
    call SendSGBFieldPaletteSet
    call RunFieldReturnPhase
    xor a, a
    ldh [hFieldDrawFlags], a
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ret

; copies the player name to wC130 with a terminator, then a two-tile suffix ($58 $87 when story flag 0 is set, else $87 $60) (E-0124)
; 10 call sites from 10 routines (e.g. InitFieldScreen, LibraryMenu_Case08, ArenaMenu_Case23, ArenaMenu_Case23_Sub01, ...)
; writes: wTextBuf0
; points at: wPlayerName, wTextBuf0
WritePlayerNameWithFlag0SuffixToTextBuf0::
Func_002_470B:: ; address name
    ld hl, wPlayerName
    ld de, wTextBuf0
    ld bc, $000A
    call CopyBytes
    ld a, $F0
    ld [wTextBuf0 + $A], a
    ld de, $0000
    call TestFlagBit
    jp nc, Jump_002_4735
    ld a, $58
    ld [wTextBuf0 + $C], a
    ld a, $87
    ld [wTextBuf0 + $D], a
    ld a, $F0
    ld [wTextBuf0 + $E], a
    ret

Jump_002_4735::
    ld a, $87
    ld [wTextBuf0 + $C], a
    ld a, $60
    ld [wTextBuf0 + $D], a
    ld a, $F0
    ld [wTextBuf0 + $E], a
    ret

; runs the routine for wC8C7 & 3 (jump table; phase 3 reuses phase 0) (E-0122)
; 1 call site from 1 routine (e.g. InitFieldScreen)
; reads: wFieldReturnPhase
RunFieldReturnPhase::
Func_002_4745:: ; address name
    ld a, [wFieldReturnPhase]
    and a, $03
    rst $00
    dw RunFieldReturnPhase_Case00
    dw RunFieldReturnPhase_Case01
    dw RunFieldReturnPhase_Case02
    dw RunFieldReturnPhase_Case00

; entry 0 of the `rst $00` table in RunFieldReturnPhase
; no direct call (reached through a table, a jump or a vector)
; reads: wModeState, wScriptRunning, wSGBActive, wFieldInitStage, wMapType
; writes: wFieldReturnPhase, wMenuState, wMenuSubState, wModeState
RunFieldReturnPhase_Case00::
Jump_002_4753:: ; address name
    xor a, a
    ld [wFieldReturnPhase], a
    ld a, [wModeState]
    cp a, $06
    jr nz, Jump_002_4768
    ld a, $05
    ld [wMenuState], a
    xor a, a
    ld [wMenuSubState], a
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
    ld a, [wMapType]
    bit 7, a
    jp z, Jump_002_4786
    ld a, $05
    ld [wModeState], a

Jump_002_4786::
    ld a, [wSGBActive]
    or a, a
    jr z, Jump_002_4792
    ld a, [wFieldInitStage]
    cp a, $02
    ret z

Jump_002_4792::
    ld a, $FC
    call StartPaletteFade
    ret

; entry 2 of the `rst $00` table in RunFieldReturnPhase
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleKind, wBattleScene, wModeState, wScriptRunning, wSGBActive, wFieldInitStage, wMapType, hPlayerStateFlags, ...
; writes: wFieldReturnPhase, wMenuState, wMenuSubState, wModeState, hMapId, hMapScreenX, hMapScreenY, hPlayerFacing, ...
RunFieldReturnPhase_Case02::
Jump_002_4798:: ; address name
    ld a, [wBattleKind]
    cp a, $05
    jp z, Jump_002_48AE
    ld a, [wBattleScene]
    or a, a
    jr z, RunFieldReturnPhase_Case00
    cp a, $03
    jp z, Jump_002_4846
    cp a, $02
    jr nz, Jump_002_47B6
    ld a, [wBattleKind]
    cp a, $04
    jr nz, RunFieldReturnPhase_Case00

Jump_002_47B6::
    ld a, [wBattleKind]
    cp a, $04
    jp z, Jump_002_4846
    cp a, $06
    jr z, Jump_002_47C6
    cp a, $07
    jr nz, Jump_002_47CB

Jump_002_47C6::
    call ResetLeadRecordFields55And5B
    jr RunFieldReturnPhase_Case00

Jump_002_47CB::
    xor a, a
    ld [wFieldReturnPhase], a
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
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $A], a
    ld a, $50
    ldh [hPlayerX], a
    ld [wFollowerRecords + $1], a
    ld [wFollowerRecords + $6], a
    ld [wFollowerRecords + $B], a
    ld a, $30
    ldh [hPlayerY], a
    ld [wFollowerRecords + $2], a
    ld [wFollowerRecords + $7], a
    ld [wFollowerRecords + $C], a
    ldh a, [hPlayerStateFlags]
    and a, $F7
    ldh [hPlayerStateFlags], a
    xor a, a
    ldh [hPlayerSpriteOverride], a
    ld a, [wMapType]
    bit 7, a
    jr z, Jump_002_4824
    farcall SaveKeyWorldFlagsRecordToSRAMSlotKeyWorldSlot

Jump_002_4824::
    xor a, a
    ld [wMapType], a
    farcall PlayMapMusic
    xor a, a
    ld [wTalkEventIndex], a
    ld a, $05
    ld [wTalkEventGroup], a
    farcall DispatchTalkEvent
    farcall FetchScriptCommand
    jp InitFieldScreen

Jump_002_4846::
    farcall FullyHealParty
    xor a, a
    ld [wFieldReturnPhase], a
    ld a, $04
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a, a
    ldh [hMapScreenY], a
    ld a, $02
    ldh [hPlayerFacing], a
    ldh [hPlayerFacing], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $A], a
    ld a, $40
    ldh [hPlayerX], a
    ld [wFollowerRecords + $1], a
    ld [wFollowerRecords + $6], a
    ld [wFollowerRecords + $B], a
    ld a, $30
    ldh [hPlayerY], a
    ld [wFollowerRecords + $2], a
    ld [wFollowerRecords + $7], a
    ld [wFollowerRecords + $C], a
    ld a, $01
    ld [wTalkEventIndex], a
    ld a, $65
    ld [wTalkEventGroup], a
    ld a, [wScriptReturnBank]
    ld [wScriptStartRequest], a
    ld a, [wScriptReturnLo]
    ld [wScriptPointerLo], a
    ld a, [wScriptReturnHi]
    ld [wScriptPointerHi], a
    ld a, $02
    ldh [hSpriteWindowClipMode], a
    ld a, $F7
    ld [wScriptCommandType], a
    ld a, $01
    ld [wScriptInDataBank], a
    jp InitFieldScreen

Jump_002_48AE::
    farcall FullyHealParty
    call RunFunc5E85Twice
    call LoadRecordListNameTiles
    farcall LoadPlayerAndFollowerSpriteGraphics
    jp RunFieldReturnPhase_Case00

; entry 1 of the `rst $00` table in RunFieldReturnPhase
; no direct call (reached through a table, a jump or a vector)
; reads: wDataBankSave, wMapType, wCurrentKeyIndex, wJoypadPressed
; writes: wFieldReturnPhase, wFieldInitStage, wModeState, wCurrentKeyIndex, wMapToggleFlag, wDataBankSave, wMenuState, wMenuSubState, ...
RunFieldReturnPhase_Case01::
Jump_002_48C3:: ; address name
    xor a, a
    ld [wFieldReturnPhase], a
    call RunFieldReturnPhase_Case01_Sub01
    ld a, [wDataBankSave]
    cp a, $40
    jr nz, Jump_002_48D9
    push af
    xor a, a
    ld [wFieldInitStage], a
    pop af
    jr Jump_002_48EF

Jump_002_48D9::
    or a, a
    jr nz, Jump_002_48EF
    ld a, [wJoypadPressed]
    set 0, a
    ld [wJoypadPressed], a
    ld a, $01
    ldh [hTemp8], a
    farcall OpenFieldMenuOnA
    ret

Jump_002_48EF::
    and a, $BF
    push af
    xor a, a
    ld [wModeState], a
    ld a, [wMapType]
    bit 7, a
    jr z, Jump_002_4902
    ld a, $05
    ld [wModeState], a

Jump_002_4902::
    pop af
    bit 7, a
    jr z, Jump_002_4945
    and a, $7F
    ld [wCurrentKeyIndex], a
    ld a, $80
    ld [wMapToggleFlag], a
    xor a, a
    ld [wDataBankSave], a
    ld a, [wCurrentKeyIndex]
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
    ld [wMenuState], a
    ld [wMenuSubState], a
    ret

Jump_002_4945::
    or a, a
    ret z
    dec a
    jr nz, Jump_002_495E
    xor a, a
    ld [wDataBankSave], a
    ld a, $19
    ld [wTalkEventGroup], a
    xor a, a
    ld [wTalkEventIndex], a
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
    ld [wTalkEventGroup], a
    xor a, a
    ld [wTalkEventIndex], a
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
    ld [wTalkEventGroup], a
    xor a, a
    ld [wTalkEventIndex], a
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
    ld [wTalkEventGroup], a
    xor a, a
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    ret

Jump_002_49BE::
    dec a
    jr nz, Jump_002_49D2
    ld a, $39
    ld [wTalkEventGroup], a
    ld a, $02
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    ret

Jump_002_49D2::
    dec a
    jr nz, Jump_002_49E6
    ld a, $6A
    ld [wTalkEventGroup], a
    ld a, $03
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    ret

Jump_002_49E6::
    dec a
    jr nz, Jump_002_49FA
    ld a, $A1
    ld [wTalkEventGroup], a
    ld a, $04
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    ret

Jump_002_49FA::
    dec a
    jr nz, Jump_002_4A0E
    ld a, $AA
    ld [wTalkEventGroup], a
    ld a, $04
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    ret

Jump_002_4A0E::
    dec a
    jr nz, Jump_002_4A1C
    xor a, a
    ld [wDataBankSave], a
    farcall RunFieldReturnPhase_Case01_Sub02
    ret

Jump_002_4A1C::
    ld a, $09
    ld [wTalkEventGroup], a
    xor a, a
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    ret

; hPlayerFacing and the three follower directions = 0, every follower position = hPlayerX/hPlayerY, wDataBankSave = 0 (E-0117)
; 3 call sites from 1 routine (e.g. RunFieldReturnPhase_Case01)
; reads: hPlayerX, hPlayerY
; writes: hPlayerFacing, wFollowerRecords, wDataBankSave
ResetFollowersToPlayer::
Func_002_4A2C:: ; address name
    xor a, a
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $A], a
    ldh a, [hPlayerX]
    ld [wFollowerRecords + $1], a
    ld [wFollowerRecords + $6], a
    ld [wFollowerRecords + $B], a
    ldh a, [hPlayerY]
    ld [wFollowerRecords + $2], a
    ld [wFollowerRecords + $7], a
    ld [wFollowerRecords + $C], a
    xor a, a
    ld [wDataBankSave], a
    ret

; for the lead record wC6FE: field $55 = 0, field $5B = $0001, then far-calls Func_004_4AA8 (E-0122)
; 1 call site from 1 routine (e.g. RunFieldReturnPhase_Case02)
; reads: wPartyList
; writes: rRAMG
ResetLeadRecordFields55And5B::
Func_002_4A53:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, [wPartyList]
    ld c, $55
    call SRAMRecordAddress
    ld [hl], $00
    ld a, [wPartyList]
    ld c, $5B
    call SRAMRecordAddress
    ld [hl], $01
    inc hl
    ld [hl], $00
    xor a, a
    ld [rRAMG], a
    farcall LoadPlayerAndFollowerSpriteGraphics
    ret

; only called from RunFieldReturnPhase_Case01 (E-0047)
; 1 call site from 1 routine (e.g. RunFieldReturnPhase_Case01)
; reads: wMapType, hMapId, hMapScreenX, hMapScreenY, wGM2Mode, wCounterPtr0Lo
; writes: wObject5, wCounterPtr0Lo, hTemp0
RunFieldReturnPhase_Case01_Sub01::
Func_002_4A7A:: ; address name
    ld a, [wMapType]
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
    ld a, [wGM2Mode]
    cp a, $01
    ret nz
    ld a, [wCounterPtr0Lo]
    cp a, $FF
    jr z, Jump_002_4AA1
    ld a, $80
    ld [wObject5], a
    ret

Jump_002_4AA1::
    xor a, a
    ld [wCounterPtr0Lo], a
    ld a, $15
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $80
    ld [wObject5], a
    ret

; only called from GameMode1_Init (E-0047)
; 1 call site from 1 routine (e.g. GameMode1_Init)
; reads: wMapType, hMapId, hMapScreenX, hMapScreenY
GameMode1_Init_Sub01::
Func_002_4AB5:: ; address name
    ld a, [wMapType]
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

; address loaded by GameMode1_Init
Data_002_4AD6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00

; address loaded by GameMode1_Init
Data_002_4AD7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00

; per-frame routine for wGameMode = 1
; 1 call site from 1 routine (e.g. RunGameModeUpdate_Case01)
; reads: wFieldInitStage, wModeState, wDMGPaletteBGP, wDMGPaletteOBP0, wDMGPaletteOBP1, wSGBActive
; writes: wJoypadHeld, wJoypadHeldPrev, wJoypadPressed, wJoypadPressedRepeat, wJoypadRepeatTimer, wFieldFrameFlag, wFieldInitStage
; points at: wDMGPaletteBGP, wDMGPaletteBytes, wOBJPaletteBuffer
GameMode1_Update::
Func_002_4AD8:: ; address name
    ld a, [wFieldInitStage]
    cp a, $02
    jp z, Jump_002_5FF7

; advances the play time, then runs the routine for wModeState & $0F (nine states) (E-0122)
; 1 call site from 1 routine (e.g. SendSGBFieldPaletteSet)
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
; reads: wFadeState, wJoypadPressed, hTemp0
; writes: hTemp8
FieldModeStateDispatch_Case00::
Jump_002_4AFB:: ; address name
    ld a, [wFadeState]
    or a, a
    jp nz, Jump_002_4B44
    ld a, [wJoypadPressed]
    bit 2, a
    jr z, Jump_002_4B13
    farcall FieldModeStateDispatch_Shared04
    ldh a, [hTemp0]
    or a, a
    ret nz

Jump_002_4B13::
    farcall FieldModeStateDispatch_Case00_Sub02
    call FieldModeStateDispatch_Case00_Sub01
    call UpdatePlayerMovement
    call RunFieldActionRequestActionIfBit7
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_002_4B44
    call CheckInteractionInFront
    farcall FieldModeStateDispatch_Shared02
    farcall FieldModeStateDispatch_Shared03
    call FieldModeStateDispatch_Shared01
    xor a, a
    ldh [hTemp8], a
    farcall OpenFieldMenuOnA

Jump_002_4B44::
    farcall DrawFieldSprites
    farcall FieldStateCommonUpdate
    farcall RunFunc722AAnd6EB7
    call RunFieldEventFieldEventKind
    call CallF072B4WhenGM2TimerMinutesIs59
    ret

; entry 1 of the `rst $00` table in FieldModeStateDispatch
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptCommandType
FieldModeStateDispatch_Case01::
Jump_002_4B5D:: ; address name
    farcall RunEventScriptFrame
    farcall StepTextWindowOpenClose
    ld a, [wScriptCommandType]
    cp a, $05
    jr z, Jump_002_4B76
    cp a, $83
    jr z, Jump_002_4B76
    jr Jump_002_4B7C

Jump_002_4B76::
    call UpdatePlayerMovement
    call RunFieldActionRequestActionIfBit7

Jump_002_4B7C::
    farcall DrawFieldSprites
    farcall FieldStateCommonUpdate
    farcall RunFunc722AAnd6EB7
    call RunFieldEventFieldEventKind
    call CallF072B4WhenGM2TimerMinutesIs59
    ret

; entry 2 of the `rst $00` table in FieldModeStateDispatch
; no direct call (reached through a table, a jump or a vector)
FieldModeStateDispatch_Case02::
Jump_002_4B95:: ; address name
    call FieldModeStateDispatch_Case02_Sub01
    farcall DrawFieldSprites
    farcall FieldStateCommonUpdate
    farcall RunFunc722AAnd6EB7
    call RunFieldEventFieldEventKind
    call CallF072B4WhenGM2TimerMinutesIs59
    ret

; entry 3 of the `rst $00` table in FieldModeStateDispatch
; no direct call (reached through a table, a jump or a vector)
FieldModeStateDispatch_Case03::
Jump_002_4BB1:: ; address name
    farcall RunBattleTransitionStep
    farcall DrawFieldSprites
    farcall FieldStateCommonUpdate
    farcall RunFunc722AAnd6EB7
    call RunFieldEventFieldEventKind
    ret

; entry 4 of the `rst $00` table in FieldModeStateDispatch
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState, wFieldTransitionStep, wWarpDestFacing, wKeyWorldWidth, wKeyWorldHeight, wMapType
; writes: wTriggerKind, wMapType, wMapWidthScreens, wMapHeightScreens, wGameMode, wFieldInitStage, wModeState, wFieldReturnPhase
; points at: wModeChangeRequest, wFieldInitStage
FieldModeStateDispatch_Case04::
Jump_002_4BCD:: ; address name
    farcall DrawFieldSprites
    farcall AdvancePlayerAnimCounterAndRunPlayerSpriteMode
    farcall RunFunc722AAnd6EB7
    call RunFieldEventFieldEventKind
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, [wFieldTransitionStep]
    and a, $7F
    jp nz, Jump_002_4C18
    ld a, $FF
    ld [wTriggerKind], a
    farcall FieldModeStateDispatch_Case04_Sub02
    ld a, [wWarpDestFacing]
    cp a, $F0
    jr nz, Jump_002_4C14
    push af
    ld a, $80
    ld [wMapType], a
    ld a, [wKeyWorldWidth]
    ld [wMapWidthScreens], a
    ld a, [wKeyWorldHeight]
    ld [wMapHeightScreens], a
    pop af

Jump_002_4C14::
    call FieldModeStateDispatch_Case04_Sub01
    ret

Jump_002_4C18::
    ld a, [wFieldTransitionStep]
    bit 7, a
    jr z, Jump_002_4C3F
    ld a, $01
    ld [wGameMode], a
    ld hl, wModeChangeRequest
    inc [hl]
    xor a, a
    ld [wFieldInitStage], a
    ld a, [wMapType]
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
    ld hl, wFieldInitStage
    inc [hl]
    call PlayMapMusic
    xor a, a
    ld [wFieldReturnPhase], a
    call InitFieldScreen
    ret

; only called from FieldModeStateDispatch_Case04 (E-0047)
; 1 call site from 1 routine (e.g. FieldModeStateDispatch_Case04)
; reads: wFieldTransitionKind, wReturnWarpFlag, hPlayerStateFlags, wSavedPositionValid, wWarpDestX, wWarpDestY, hPlayerFacing, hPlayerX, ...
; writes: hPlayerFacing, wReturnWarpFlag, wMapType, hPlayerStateFlags, hMapId, hMapScreenX, hMapScreenY, hPlayerX, ...
; points at: wFieldTransitionStep
FieldModeStateDispatch_Case04_Sub01::
Func_002_4C4E:: ; address name
    ld a, [wFieldTransitionKind]
    or a, a
    jr z, Jump_002_4C57
    dec a
    ldh [hPlayerFacing], a

Jump_002_4C57::
    ld a, [wReturnWarpFlag]
    or a, a
    jr z, Jump_002_4C82
    xor a, a
    ld [wReturnWarpFlag], a
    ld de, $0025
    call TestFlagBit
    jr nc, Jump_002_4C6D
    ld a, $02
    ldh [hPlayerFacing], a

Jump_002_4C6D::
    xor a, a
    ld [wMapType], a
    ldh a, [hPlayerStateFlags]
    and a, $B7
    ldh [hPlayerStateFlags], a
    ld a, $05
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a, a
    ldh [hMapScreenY], a

Jump_002_4C82::
    ld a, [wSavedPositionValid]
    or a, a
    jr nz, Jump_002_4CDA
    ld a, [wWarpDestX]
    ldh [hPlayerX], a
    ld a, [wWarpDestY]
    ldh [hPlayerY], a
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $A], a
    ldh a, [hPlayerX]
    ld [wFollowerRecords + $1], a
    ld [wFollowerRecords + $6], a
    ld [wFollowerRecords + $B], a
    ldh a, [hPlayerY]
    ld [wFollowerRecords + $2], a
    ld [wFollowerRecords + $7], a
    ld [wFollowerRecords + $C], a
    ldh a, [hPlayerStateFlags]
    and a, $F9
    ldh [hPlayerStateFlags], a
    ld hl, wFieldTransitionStep
    inc [hl]
    ld a, [wMapType]
    bit 7, a
    ret nz
    ldh a, [hMapId]
    cp a, $05
    ret nz
    ldh a, [hPlayerStateFlags]
    and a, $F7
    ldh [hPlayerStateFlags], a
    xor a, a
    ld [wMapType], a
    xor a, a
    ldh [hPlayerSpriteOverride], a
    xor a, a
    ld [wGameMode2Byte50], a
    ret

Jump_002_4CDA::
    ld a, [wSavedPlayerState + $1]
    ldh [hPlayerX], a
    ld a, [wSavedPlayerState + $2]
    ldh [hPlayerY], a
    ld a, [wSavedPlayerState + $3]
    ldh [hPlayerFacing], a
    ld a, [wSavedPlayerState + $4]
    ld [wFollowerRecords], a
    ld a, [wSavedPlayerState + $5]
    ld [wFollowerRecords + $1], a
    ld a, [wSavedPlayerState + $6]
    ld [wFollowerRecords + $2], a
    ld a, [wSavedPlayerState + $7]
    ld [wFollowerRecords + $5], a
    ld a, [wSavedPlayerState + $8]
    ld [wFollowerRecords + $6], a
    ld a, [wSavedPlayerState + $9]
    ld [wFollowerRecords + $7], a
    ld a, [wSavedPlayerState + $A]
    ld [wFollowerRecords + $A], a
    ld a, [wSavedPlayerState + $B]
    ld [wFollowerRecords + $B], a
    ld a, [wSavedPlayerState + $C]
    ld [wFollowerRecords + $C], a
    xor a, a
    ld [wSavedPositionValid], a
    ld hl, wFieldTransitionStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in FieldModeStateDispatch
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState, wJoypadPressed, hTemp0
; writes: hTemp8
FieldModeStateDispatch_Case05::
Jump_002_4D28:: ; address name
    ld a, [wFadeState]
    or a, a
    jr nz, Jump_002_4D6D
    ld a, [wJoypadPressed]
    bit 2, a
    jr z, Jump_002_4D3F
    farcall FieldModeStateDispatch_Shared04
    ldh a, [hTemp0]
    or a, a
    ret nz

Jump_002_4D3F::
    call UpdatePlayerMovement
    call RunFieldActionRequestActionIfBit7
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_002_4D6D
    call FieldModeStateDispatch_Case05_Sub01
    farcall FieldModeStateDispatch_Shared02
    farcall FieldModeStateDispatch_Case05_Sub02
    farcall FieldModeStateDispatch_Shared03
    call FieldModeStateDispatch_Shared01
    xor a, a
    ldh [hTemp8], a
    farcall OpenFieldMenuOnA

Jump_002_4D6D::
    farcall DrawFieldSprites
    farcall FieldStateCommonUpdate
    farcall RunFunc722AAnd6EB7
    call RunFieldEventFieldEventKind
    call CallF072B4WhenGM2TimerMinutesIs59
    ret

; entry 6 of the `rst $00` table in FieldModeStateDispatch
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuSubState
FieldModeStateDispatch_Case06::
Jump_002_4D86:: ; address name
    farcall RunMenuStateMenuState
    ld a, [wMenuSubState]
    or a, a
    jr nz, Jump_002_4D98
    farcall FieldStateCommonUpdate

Jump_002_4D98::
    ret

; entry 7 of the `rst $00` table in FieldModeStateDispatch
; no direct call (reached through a table, a jump or a vector)
; reads: wModeState
; writes: wScriptRunning, wFieldStepFlags
FieldModeStateDispatch_Case07::
Jump_002_4D99:: ; address name
    farcall FieldModeStateDispatch_Case07_Sub01
    farcall FieldStateCommonUpdate
    farcall DrawTriggerMarkerSprite
    ld a, [wModeState]
    cp a, $07
    ret z
    xor a, a
    ld [wScriptRunning], a
    farcall TickRandomEncounterCounter
    farcall CheckStepTriggerAndDispatchTalk
    farcall CheckWarpsAtPlayerPosition
    xor a, a
    ld [wFieldStepFlags], a
    ret

; entry 8 of the `rst $00` table in FieldModeStateDispatch
; no direct call (reached through a table, a jump or a vector)
FieldModeStateDispatch_Case08::
Jump_002_4DCC:: ; address name
    farcall RunGameMode2State
    call CallF072B4WhenGM2TimerMinutesIs59
    ret

; when wCE9D = $3B and wCE9C = wCE9B = 0, far-calls Func_0F0_72B4 (E-0122)
; 5 call sites from 5 routines (e.g. FieldModeStateDispatch_Case08, FieldModeStateDispatch_Case05, FieldModeStateDispatch_Case02, FieldModeStateDispatch_Case01, ...)
; reads: wGM2TimerMinutes, wGM2TimerSeconds, wGM2TimerFrames
CallF072B4WhenGM2TimerMinutesIs59::
Func_002_4DD6:: ; address name
    ld a, [wGM2TimerMinutes]
    cp a, $3B
    ret nz
    ld a, [wGM2TimerSeconds]
    and a, a
    ret nz
    ld a, [wGM2TimerFrames]
    and a, a
    ret nz
    farcall ClearRollCounterWhenGM2TimerMinutesIs59
    ret

; only called from routines of FieldModeStateDispatch (E-0098)
; 2 call sites from 2 routines (e.g. FieldModeStateDispatch_Case05, FieldModeStateDispatch_Case00)
; reads: wMapSpriteKind, wFadeState, wTextWindowState, wFieldActionRequest, hPlayerStateFlags, wJoypadPressed, hPlayerX, hPlayerY, ...
; writes: wFieldStateByte34
FieldModeStateDispatch_Shared01::
Func_002_4DED:: ; address name
    ld a, [wMapSpriteKind]
    or a, a
    ret z
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, [wTextWindowState]
    and a, $03
    ret nz
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    ldh a, [hPlayerStateFlags]
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
    ld a, [wMapSpriteKind]
    and a, $F0
    jr z, Jump_002_4E59
    swap a
    call TestFlag1FAsBool
    or a, a
    jr z, Jump_002_4E59
    ld [wFieldStateByte34], a
    call FieldModeStateDispatch_Shared01_Sub02
    or a, a
    ret nz

Jump_002_4E59::
    ld a, [wMapSpriteKind]
    and a, $0F
    ret z
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr nz, Jump_002_4E6D
    call FieldModeStateDispatch_Shared01_Sub01
    or a, a
    ret z
    ld [wFieldStateByte34], a

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
; reads: wMapSpriteKind
FieldModeStateDispatch_Shared01_Sub01::
Func_002_4E7E:: ; address name
    ld a, [wMapSpriteKind]
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
; reads: hPlayerStateFlags, wMapHeaderByte11, wTilesUnderPoint, wPartyWindowFlags
; writes: wTalkEventGroup, wTalkEventIndex, wJoypadHeld, wJoypadPressed
FieldModeStateDispatch_Shared01_Sub02::
Func_002_4E9E:: ; address name
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr z, Jump_002_4EA6

Jump_002_4EA4::
    xor a, a
    ret

Jump_002_4EA6::
    ld a, [wMapHeaderByte11]
    ld c, a
    ld a, [wTilesUnderPoint]
    cp a, c
    jr nz, Jump_002_4EA4
    ld a, $02
    ld [wTalkEventGroup], a
    xor a, a
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    xor a, a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ld a, [wPartyWindowFlags]
    bit 7, a
    jr z, Jump_002_4ED3
    farcall RedrawScreenBufferIfPartyWindowFlagsBit7

Jump_002_4ED3::
    ld a, $01
    ret

; only called from FieldModeStateDispatch_Shared01 (E-0047)
; 1 call site from 1 routine (e.g. FieldModeStateDispatch_Shared01)
; reads: hPlayerStateFlags, wMapTallTileMin, wPartyWindowFlags, wMaxBlockingTile
; writes: wTalkEventGroup, wTalkEventIndex, wJoypadHeld, wJoypadPressed
; points at: wTilesUnderPoint
FieldModeStateDispatch_Shared01_Sub03::
Func_002_4ED6:: ; address name
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr nz, Jump_002_4F13
    ld de, wTilesUnderPoint
    ld b, $04

Jump_002_4EE1::
    ld a, [de]
    inc de
    ld c, a
    ld a, [wMapTallTileMin]
    cp a, c
    jr c, Jump_002_4EEC
    jr Jump_002_4EF0

Jump_002_4EEC::
    dec b
    jr nz, Jump_002_4EE1
    ret

Jump_002_4EF0::
    ld a, $01
    ld [wTalkEventGroup], a
    xor a, a
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    xor a, a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ld a, [wPartyWindowFlags]
    bit 7, a
    ret z
    farcall RedrawScreenBufferIfPartyWindowFlagsBit7
    ret

Jump_002_4F13::
    ld de, wTilesUnderPoint
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
    ld [wTalkEventGroup], a
    xor a, a
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    xor a, a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ld a, [wPartyWindowFlags]
    bit 7, a
    ret z
    farcall RedrawScreenBufferIfPartyWindowFlagsBit7
    ret

; only called from FieldModeStateDispatch_Case05 (E-0047)
; 1 call site from 1 routine (e.g. FieldModeStateDispatch_Case05)
; reads: wFadeState, wTextWindowState, wFieldActionRequest, hPlayerStateFlags, wJoypadPressed, wMapType
FieldModeStateDispatch_Case05_Sub01::
Func_002_4F4C:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, [wTextWindowState]
    and a, $03
    ret nz
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    ldh a, [hPlayerStateFlags]
    bit 0, a
    ret nz
    ld a, [wJoypadPressed]
    bit 0, a
    ret z
    ld a, [wMapType]
    and a, $07
    rst $00
    dw FieldModeStateDispatch_Case05_Sub01_Case00
    dw FieldModeStateDispatch_Case05_Sub01_Case00
    dw FieldModeStateDispatch_Case05_Sub01_Case00
    dw FieldModeStateDispatch_Case05_Sub01_Case03
    dw FieldModeStateDispatch_Case05_Sub01_Case00
    dw FieldModeStateDispatch_Case05_Sub01_Case00
    dw FieldModeStateDispatch_Case05_Sub01_Case00
    dw FieldModeStateDispatch_Case05_Sub01_Case07

; entry 0 of the `rst $00` table in Func_002_4F4C
; no direct call (reached through a table, a jump or a vector)
FieldModeStateDispatch_Case05_Sub01_Case00::
Jump_002_4F7E:: ; address name
    ret

; entry 3 of the `rst $00` table in Func_002_4F4C
; no direct call (reached through a table, a jump or a vector)
; reads: wKeyWorldFloor, hPlayerFacing, hMapScreenY, hPlayerX, hPlayerY
; writes: wFieldReturnPhase, wGameMode, wModeState, wGameMode2State, wJoypadHeld, wJoypadPressed
FieldModeStateDispatch_Case05_Sub01_Case03::
Jump_002_4F7F:: ; address name
    ld a, [wKeyWorldFloor]
    add a, a
    add a, a
    ld hl, wKeyWorldFloorInfo + $1
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
; writes: wFieldReturnPhase, wGameMode, wModeState, wGameMode2State, wJoypadHeld, wJoypadPressed
FieldModeStateDispatch_Case05_Sub01_Case07::
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
    farcall SaveKeyWorldFlagsRecordToSRAMSlotKeyWorldSlot
    call RedrawScreenBufferIfPartyWindowFlagsBit7
    call SaveScreenBufferToBGMap1
    ld a, $01
    ld [wFieldReturnPhase], a
    ld a, $69
    call QueueSoundEffect
    ld a, $02
    ld [wGameMode], a
    ld a, $0B
    ld [wModeState], a
    xor a, a
    ld [wGameMode2State], a
    xor a, a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ret

; when A is newly pressed and no fade, load or move is in progress: finds the position one step ahead of the player (hPlayerX or hPlayerY +/- 16 chosen by hPlayerFacing), looks it up with Func_002_59CD, and compares the result with the four ids at wC910 to pick an interaction
; 1 call site from 1 routine (e.g. FieldModeStateDispatch_Case00)
; reads: wMapHeaderByte7, wFadeState, wTextWindowState, wFieldActionRequest, hPlayerStateFlags, wJoypadPressed, hPlayerX, hPlayerY, ...
; writes: wFieldReturnPhase, wGameMode, wModeState, wGameMode2State, wJoypadHeld, wJoypadPressed
; points at: wTilesUnderPoint
CheckInteractionInFront::
Func_002_4FE8:: ; address name
    ld a, [wMapHeaderByte7]
    or a, a
    ret z
    ld de, $0002
    call TestFlagBit
    ret nc
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, [wTextWindowState]
    and a, $03
    ret nz
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    ldh a, [hPlayerStateFlags]
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
    ld de, wTilesUnderPoint
    ld b, $04

Jump_002_503F::
    ld a, [de]
    inc de
    ld c, a
    ld a, [wMapHeaderByte7]
    cp a, c
    jr nz, Jump_002_504A
    jr Jump_002_504E

Jump_002_504A::
    dec b
    jr nz, Jump_002_503F
    ret

Jump_002_504E::
    call RedrawScreenBufferIfPartyWindowFlagsBit7
    call SaveScreenBufferToBGMap1
    ld a, $01
    ld [wFieldReturnPhase], a
    ld a, $69
    call QueueSoundEffect
    ld a, $02
    ld [wGameMode], a
    ld a, $0B
    ld [wModeState], a
    xor a, a
    ld [wGameMode2State], a
    xor a, a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ret

; unless a fade runs or bit 7 of wC468 is set, runs the field event for wC90D & $0F (jump table of sixteen) (E-0124)
; 7 call sites from 7 routines (e.g. FieldModeStateDispatch_Case05, FieldModeStateDispatch_Case04, FieldModeStateDispatch_Case03, FieldModeStateDispatch_Case02, ...)
; reads: wFadeState, wFieldActionRequest, wFieldEventKind
RunFieldEventFieldEventKind::
Func_002_5074:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    ld a, [wFieldEventKind]
    and a, $0F
    rst $00
    dw RunFieldEventFieldEventKind_Case00
    dw AnimateTilesByRotatingVTiles2
    dw AnimateTilesByRotatingVTiles2
    dw RunFieldEventFieldEventKind_Case03
    dw RunFieldEventFieldEventKind_Case04
    dw RunFieldEventFieldEventKind_Case05
    dw RunFieldEventFieldEventKind_Case06
    dw RunFieldEventFieldEventKind_Case07
    dw RunFieldEventFieldEventKind_Case08
    dw RunFieldEventFieldEventKind_Case09
    dw RunFieldEventFieldEventKind_Case0A
    dw RunFieldEventFieldEventKind_Case0B
    dw RunFieldEventFieldEventKind_Case0C
    dw RunFieldEventFieldEventKind_Case0D
    dw RunFieldEventFieldEventKind_Case0E
    dw RunFieldEventFieldEventKind_Case0F

; entry 12 of the `rst $00` table in RunFieldEventFieldEventKind
; no direct call (reached through a table, a jump or a vector)
RunFieldEventFieldEventKind_Case0C::
Jump_002_50A5:: ; address name
    call RunFieldEventFieldEventKind_Case0C_Sub01
    ret

; entry 8 of the `rst $00` table in RunFieldEventFieldEventKind
; no direct call (reached through a table, a jump or a vector)
RunFieldEventFieldEventKind_Case08::
Jump_002_50A9:: ; address name
    call RunFieldEventFieldEventKind_Case08_Sub01
    ret

; entry 0 of the `rst $00` table in RunFieldEventFieldEventKind
; no direct call (reached through a table, a jump or a vector)
RunFieldEventFieldEventKind_Case00::
Jump_002_50AD:: ; address name
    ret

; every 8 frames rotates each byte pair of the first 16 tile rows at vTiles2 left by one bit (tile animation) (E-0124)
; 1 call site from 1 routine (e.g. RunFieldEventFieldEventKind_Case05)
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

; entry 13 of the `rst $00` table in RunFieldEventFieldEventKind
; no direct call (reached through a table, a jump or a vector)
; reads: wFrameCounterLo
RunFieldEventFieldEventKind_Case0D::
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

; entry 14 of the `rst $00` table in RunFieldEventFieldEventKind
; no direct call (reached through a table, a jump or a vector)
; reads: wFrameCounterLo
RunFieldEventFieldEventKind_Case0E::
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

; entry 3 of the `rst $00` table in RunFieldEventFieldEventKind
; no direct call (reached through a table, a jump or a vector)
; reads: wFrameCounterLo
RunFieldEventFieldEventKind_Case03::
Jump_002_5119:: ; address name
    ld a, [wFrameCounterLo]
    and a, $0F
    ret nz
    ld de, vTiles2 + $300
    ld hl, vTiles2 + $320
    jp Jump_002_51AD

; entry 4 of the `rst $00` table in RunFieldEventFieldEventKind
; no direct call (reached through a table, a jump or a vector)
; reads: wFrameCounterLo
RunFieldEventFieldEventKind_Case04::
Jump_002_5128:: ; address name
    ld a, [wFrameCounterLo]
    and a, $03
    ret nz
    ld de, vTiles2 + $280
    ld hl, vTiles2 + $2C0
    jr Jump_002_5176

; entry 5 of the `rst $00` table in RunFieldEventFieldEventKind
; no direct call (reached through a table, a jump or a vector)
; reads: wFrameCounterLo
RunFieldEventFieldEventKind_Case05::
Jump_002_5136:: ; address name
    call AnimateTilesByRotatingVTiles2
    ld a, [wFrameCounterLo]
    and a, $03
    ret nz
    ld de, vTiles2 + $140
    ld hl, vTiles2 + $180
    jr Jump_002_5176

; entry 9 of the `rst $00` table in RunFieldEventFieldEventKind
; no direct call (reached through a table, a jump or a vector)
; reads: wFrameCounterLo
RunFieldEventFieldEventKind_Case09::
Jump_002_5147:: ; address name
    ld a, [wFrameCounterLo]
    and a, $03
    ret nz
    ld de, vTiles2 + $280
    ld hl, vTiles2 + $2C0
    jr Jump_002_5176

; entry 10 of the `rst $00` table in RunFieldEventFieldEventKind
; no direct call (reached through a table, a jump or a vector)
; reads: wFrameCounterLo
RunFieldEventFieldEventKind_Case0A::
Jump_002_5155:: ; address name
    ld a, [wFrameCounterLo]
    and a, $03
    ret nz
    ld de, vTiles2 + $480
    ld hl, vTiles2 + $4C0
    jr Jump_002_5176

; entry 15 of the `rst $00` table in RunFieldEventFieldEventKind
; no direct call (reached through a table, a jump or a vector)
; reads: hMapScreenX, wFrameCounterLo
RunFieldEventFieldEventKind_Case0F::
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

; entry 6 of the `rst $00` table in RunFieldEventFieldEventKind
; no direct call (reached through a table, a jump or a vector)
; reads: wFrameCounterLo
RunFieldEventFieldEventKind_Case06::
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

; address loaded by RunFieldEventFieldEventKind_Case06
Data_002_5205:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C0, $91, $E0, $91, $D0, $91, $F0, $91, $20, $92, $60, $92, $30, $92, $70, $92
    db $20, $93, $40, $93, $30, $93, $50, $93, $80, $93, $A0, $93, $90, $93, $B0, $93
    db $20, $94, $40, $94, $30, $94, $50, $94, $80, $94, $A0, $94, $90, $94, $B0, $94

; entry 7 of the `rst $00` table in RunFieldEventFieldEventKind
; no direct call (reached through a table, a jump or a vector)
; reads: wFrameCounterLo
RunFieldEventFieldEventKind_Case07::
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

; address loaded by RunFieldEventFieldEventKind_Case07
Data_002_5254:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $30, $93, $50, $93, $40, $93, $60, $93, $20, $94, $40, $94, $30, $94, $50, $94
    db $C0, $94, $E0, $94, $D0, $94, $F0, $94, $60, $95, $80, $95, $70, $95, $90, $95
    db $20, $96, $60, $96, $30, $96, $70, $96, $A0, $96, $E0, $96, $B0, $96, $F0, $96

; entry 11 of the `rst $00` table in RunFieldEventFieldEventKind
; no direct call (reached through a table, a jump or a vector)
; reads: hMapScreenY, wFrameCounterLo
RunFieldEventFieldEventKind_Case0B::
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

; address loaded by RunFieldEventFieldEventKind_Case0B
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

; only called from RunFieldEventFieldEventKind_Case08 (E-0047)
; 1 call site from 1 routine (e.g. RunFieldEventFieldEventKind_Case08)
; reads: wScriptCommandType, wSavedPositionValid, wMenuSubState, wMenuState
; writes: wMenuSubState, wMenuState, hTemp0, wBGPaletteUploadRequest
; points at: wBGPaletteBuffer, wBGPaletteCopy
RunFieldEventFieldEventKind_Case08_Sub01::
Func_002_52D8:: ; address name
    ld a, [wScriptCommandType]
    cp a, $ED
    ret z
    ld a, [wSavedPositionValid]
    and a, a
    ret nz
    ld a, [wMenuSubState]
    bit 7, a
    jr nz, Jump_002_52FC
    ld a, $80
    ld [wMenuSubState], a
    ld hl, wBGPaletteBuffer
    ld de, wBGPaletteCopy
    ld bc, $0040
    call CopyBytes
    ret

Jump_002_52FC::
    ld a, [wMenuState]
    inc a
    ld [wMenuState], a
    and a, $07
    dec a
    ret nz
    ld a, [wMenuState]
    srl a
    srl a
    srl a
    cp a, $08
    jr nz, Jump_002_5321
    ld a, [wMenuSubState]
    inc a
    and a, $81
    ld [wMenuSubState], a
    xor a, a
    ld [wMenuState], a

Jump_002_5321::
    ldh [hTemp0], a
    ld hl, wBGPaletteCopy + $8
    ld de, wBGPaletteBuffer + $8
    call RunFieldEventFieldEventKind_Case08_Sub01_Sub01
    ld hl, wBGPaletteCopy + $10
    ld de, wBGPaletteBuffer + $10
    ld hl, wBGPaletteCopy + $18
    ld de, wBGPaletteBuffer + $18
    call RunFieldEventFieldEventKind_Case08_Sub01_Sub01
    ld hl, wBGPaletteCopy + $20
    ld de, wBGPaletteBuffer + $20
    call RunFieldEventFieldEventKind_Case08_Sub01_Sub01
    ld a, $7F
    ld [wBGPaletteUploadRequest], a
    ret

; only called from RunFieldEventFieldEventKind_Case08_Sub01 (E-0047)
; 3 call sites from 1 routine (e.g. RunFieldEventFieldEventKind_Case08_Sub01)
; reads: hTemp0, wMenuSubState, wTextCounter2, wTextCounter3, wTextCounter4
; writes: wTextCounter2, wTextCounter3, wTextCounter4
; points at: wTextCounter2
RunFieldEventFieldEventKind_Case08_Sub01_Sub01::
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
    ld [wTextCounter2], a
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
    ld [wTextCounter3], a
    pop bc
    ld a, c
    and a, $1F
    ld [wTextCounter4], a
    push hl
    ld hl, Data_002_53C5
    ldh a, [hTemp0]
    add_a_to_hl
    ld a, [wMenuSubState]
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
    ld hl, wTextCounter2
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
    ld a, [wTextCounter2]
    ld b, a
    ld a, [wTextCounter3]
    sla a
    sla a
    sla a
    ld c, a
    sla c
    rl b
    sla c
    rl b
    ld a, [wTextCounter4]
    or a, c
    ld c, a
    ld a, c
    ld [de], a
    inc de
    ld a, b
    ld [de], a
    inc de
    ret

; address loaded by RunFieldEventFieldEventKind_Case08_Sub01_Sub01
Data_002_53C5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $FC, $F8, $F4, $F0, $EC, $E8, $E4, $E4, $E8, $EC, $F0, $F4, $F8, $FC, $00

; only called from RunFieldEventFieldEventKind_Case0C (E-0047)
; 1 call site from 1 routine (e.g. RunFieldEventFieldEventKind_Case0C)
; reads: wFieldEventTimer, wKeyRandomLo, wFieldEventArg, wFrameCounterLo, hScrollX, wKeyRandomHi
; writes: wFieldEventTimer, hScrollX
RunFieldEventFieldEventKind_Case0C_Sub01::
Func_002_53D5:: ; address name
    ld a, [wFieldEventTimer]
    bit 7, a
    jr nz, Jump_002_53F0
    and a, $7F
    ld c, a
    ld a, [wKeyRandomLo]
    and a, $7F
    cp a, c
    jr nz, Jump_002_53EC
    ld a, $80
    ld [wFieldEventTimer], a

Jump_002_53EC::
    xor a, a
    ldh [hScrollX], a
    ret

Jump_002_53F0::
    ld a, [wFieldEventArg]
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
    ld a, [wFieldEventTimer]
    inc a
    ld [wFieldEventTimer], a
    cp a, $BC
    ret nz
    ld a, [wKeyRandomHi]
    and a, $7F
    ld [wFieldEventTimer], a
    ret

; does nothing during a fade or while the map is loading; reads the D-pad (wJoypadHeld, wJoypadPressed), sets the facing hPlayerFacing and the move timer hFF9A, and starts or continues a step when the tile ahead is free (checks through Func_002_59CD, Func_002_5A51 and Func_002_5AB6)
; 12 call sites from 12 routines (e.g. FieldModeStateDispatch_Case05, FieldModeStateDispatch_Case01, FieldModeStateDispatch_Case00, SceneMedicineGiven_Case01, ...)
; reads: wFadeState, hPlayerTurnDelay, hPlayerStateFlags, wFieldActionRequest, wJoypadPressed, hPlayerFacing, hPlayerX, wScriptRunning, ...
; writes: hPlayerTurnDelay, hPlayerFacing, hPlayerStateFlags, hPlayerStepDXLo, hPlayerStepDXHi, hMapScreenX, wFieldActionRequest, wScreenScrollDir, ...
; points at: hSndNoteTimer, hMapScreenX, hMapScreenY, hFF80, hFFF8
UpdatePlayerMovement::
Func_002_541B:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ldh a, [hPlayerTurnDelay]
    or a, a
    jr z, Jump_002_542C
    dec a
    ldh [hPlayerTurnDelay], a
    call RedrawScreenBufferIfPartyWindowFlagsBit7
    ret

Jump_002_542C::
    ldh a, [hPlayerStateFlags]
    bit 0, a
    jp nz, UpdatePlayerMovement_Sub01
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    ldh a, [hPlayerStateFlags]
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
    ldh [hPlayerTurnDelay], a
    call RedrawScreenBufferIfPartyWindowFlagsBit7
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
    ldh a, [hPlayerStateFlags]
    or a, $05
    ldh [hPlayerStateFlags], a
    ld hl, $FFF0
    ld a, l
    ldh [hPlayerStepDXLo], a
    ld a, h
    ldh [hPlayerStepDXHi], a
    call SetFollowerTargetsFromLeader
    call UpdatePlayerMovement_Sub01
    ret

Jump_002_54A0::
    ldh a, [hPlayerStateFlags]
    or a, $05
    ldh [hPlayerStateFlags], a
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
    ld [wFieldActionRequest], a
    ld a, $01
    ld [wScreenScrollDir], a
    ld hl, $0090
    ld a, l
    ldh [hPlayerStepDXLo], a
    ld a, h
    ldh [hPlayerStepDXHi], a
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
    ldh [hPlayerTurnDelay], a
    call RedrawScreenBufferIfPartyWindowFlagsBit7
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
    ldh a, [hPlayerStateFlags]
    or a, $05
    ldh [hPlayerStateFlags], a
    ld hl, $0010
    ld a, l
    ldh [hPlayerStepDXLo], a
    ld a, h
    ldh [hPlayerStepDXHi], a
    call SetFollowerTargetsFromLeader
    call UpdatePlayerMovement_Sub01
    ret

Jump_002_5538::
    ldh a, [hPlayerStateFlags]
    or a, $05
    ldh [hPlayerStateFlags], a
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
    ld [wFieldActionRequest], a
    ld a, $02
    ld [wScreenScrollDir], a
    ld hl, $FF70
    ld a, l
    ldh [hPlayerStepDXLo], a
    ld a, h
    ldh [hPlayerStepDXHi], a
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
    ldh [hPlayerTurnDelay], a
    call RedrawScreenBufferIfPartyWindowFlagsBit7
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
    ldh a, [hPlayerStateFlags]
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
    ldh a, [hPlayerStateFlags]
    or a, $05
    ldh [hPlayerStateFlags], a
    ld hl, $0010
    ldh a, [hPlayerStateFlags]
    bit 6, a
    jr z, Jump_002_55DD
    ld hl, $0008

Jump_002_55DD::
    ld a, l
    ldh [hPlayerStepDYLo], a
    ld a, h
    ldh [hPlayerStepDYHi], a
    call SetFollowerTargetsFromLeader
    call UpdatePlayerMovement_Sub01
    ret

Jump_002_55EA::
    ldh a, [hPlayerStateFlags]
    or a, $05
    ldh [hPlayerStateFlags], a
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
    ld [wFieldActionRequest], a
    ld a, $08
    ld [wScreenScrollDir], a
    ld hl, $FF80
    ld a, l
    ldh [hPlayerStepDYLo], a
    ld a, h
    ldh [hPlayerStepDYHi], a
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
    ldh [hPlayerTurnDelay], a
    call RedrawScreenBufferIfPartyWindowFlagsBit7
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
    ldh a, [hPlayerStateFlags]
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
    ldh a, [hPlayerStateFlags]
    or a, $05
    ldh [hPlayerStateFlags], a
    ld hl, hSndNoteTimer
    ldh a, [hPlayerStateFlags]
    bit 6, a
    jr z, Jump_002_5697
    ld hl, $FFF8

Jump_002_5697::
    ld a, l
    ldh [hPlayerStepDYLo], a
    ld a, h
    ldh [hPlayerStepDYHi], a
    call SetFollowerTargetsFromLeader
    call UpdatePlayerMovement_Sub01
    ret

Jump_002_56A4::
    ldh a, [hPlayerStateFlags]
    or a, $05
    ldh [hPlayerStateFlags], a
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
    ld [wFieldActionRequest], a
    ld a, $04
    ld [wScreenScrollDir], a
    ld hl, $0080
    ld a, l
    ldh [hPlayerStepDYLo], a
    ld a, h
    ldh [hPlayerStepDYHi], a
    call UpdatePlayerMovement_Sub01
    ret

; only called from UpdatePlayerMovement (E-0047)
; 8 call sites from 1 routine (e.g. UpdatePlayerMovement)
; reads: hPlayerStepDXLo, hPlayerStepDXHi, hPlayerStepDYLo, hPlayerStepDYHi, hPlayerStateFlags, wFieldActionRequest, hPlayerY, wFollowerRecords, ...
; writes: hPlayerStateFlags, wStepTriggerFlag, hPlayerStepDYLo, hPlayerStepDYHi, wMapToggleRequest, hPlayerY, wFollowerRecords, hPlayerStepDXLo, ...
; points at: hPlayerY, hPlayerX
UpdatePlayerMovement_Sub01::
Func_002_56DC:: ; address name
    call RedrawScreenBufferIfPartyWindowFlagsBit7
    ldh a, [hPlayerStepDXLo]
    ld l, a
    ldh a, [hPlayerStepDXHi]
    ld h, a
    ld a, h
    or a, l
    jr nz, Jump_002_5700
    ldh a, [hPlayerStepDYLo]
    ld l, a
    ldh a, [hPlayerStepDYHi]
    ld h, a
    ld a, h
    or a, l
    jr nz, Jump_002_5700
    ldh a, [hPlayerStateFlags]
    and a, $FE
    ldh [hPlayerStateFlags], a
    xor a, a
    ld [wStepTriggerFlag], a
    jp Jump_002_58BF

Jump_002_5700::
    ldh a, [hPlayerStepDXLo]
    ld l, a
    ldh a, [hPlayerStepDXHi]
    ld h, a
    bit 7, h
    jr nz, Jump_002_5729
    ld a, h
    or a, l
    jr nz, Jump_002_5784
    ldh a, [hPlayerStepDYLo]
    ld l, a
    ldh a, [hPlayerStepDYHi]
    ld h, a
    bit 7, h
    jp nz, Jump_002_57E0
    ld a, h
    or a, l
    jp nz, Jump_002_583A
    ldh a, [hPlayerStateFlags]
    and a, $FA
    ldh [hPlayerStateFlags], a
    xor a, a
    ld [wStepTriggerFlag], a
    ret

Jump_002_5729::
    ld a, [wFieldActionRequest]
    bit 7, a
    jr nz, Jump_002_5747
    call StepFollowersTowardTargets
    ldh a, [hPlayerStepDXLo]
    ld l, a
    ldh a, [hPlayerStepDXHi]
    ld h, a
    inc hl
    ld a, l
    ldh [hPlayerStepDXLo], a
    ld a, h
    ldh [hPlayerStepDXHi], a
    ld hl, hPlayerX
    dec [hl]
    jp Jump_002_5892

Jump_002_5747::
    call UpdatePlayerMovement_Sub01_Sub01
    ldh a, [hPlayerStepDXLo]
    ld l, a
    ldh a, [hPlayerStepDXHi]
    ld h, a
    ld a, $08
    add_a_to_hl
    ld a, l
    ldh [hPlayerStepDXLo], a
    ld a, h
    ldh [hPlayerStepDXHi], a
    ldh a, [hPlayerX]
    sub a, $08
    ldh [hPlayerX], a
    ld a, [wFollowerRecords + $1]
    sub a, $08
    ld [wFollowerRecords + $1], a
    ld a, [wFollowerRecords + $6]
    sub a, $08
    ld [wFollowerRecords + $6], a
    ld a, [wFollowerRecords + $B]
    sub a, $08
    ld [wFollowerRecords + $B], a
    call SetFollowerTargetsFromLeader
    call StepFollowersTowardTargets
    jp Jump_002_5892

Jump_002_5784::
    ld a, [wFieldActionRequest]
    bit 7, a
    jr nz, Jump_002_57A2
    call StepFollowersTowardTargets
    ldh a, [hPlayerStepDXLo]
    ld l, a
    ldh a, [hPlayerStepDXHi]
    ld h, a
    dec hl
    ld a, l
    ldh [hPlayerStepDXLo], a
    ld a, h
    ldh [hPlayerStepDXHi], a
    ld hl, hPlayerX
    inc [hl]
    jp Jump_002_5892

Jump_002_57A2::
    call UpdatePlayerMovement_Sub01_Sub01
    ldh a, [hPlayerStepDXLo]
    ld l, a
    ldh a, [hPlayerStepDXHi]
    ld h, a
    ld a, l
    sub a, $08
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld a, l
    ldh [hPlayerStepDXLo], a
    ld a, h
    ldh [hPlayerStepDXHi], a
    ldh a, [hPlayerX]
    add a, $08
    ldh [hPlayerX], a
    ld a, [wFollowerRecords + $1]
    add a, $08
    ld [wFollowerRecords + $1], a
    ld a, [wFollowerRecords + $6]
    add a, $08
    ld [wFollowerRecords + $6], a
    ld a, [wFollowerRecords + $B]
    add a, $08
    ld [wFollowerRecords + $B], a
    call SetFollowerTargetsFromLeader
    call StepFollowersTowardTargets
    jp Jump_002_5892

Jump_002_57E0::
    ld a, [wFieldActionRequest]
    bit 7, a
    jr nz, Jump_002_57FE
    call StepFollowersTowardTargets
    ldh a, [hPlayerStepDYLo]
    ld l, a
    ldh a, [hPlayerStepDYHi]
    ld h, a
    inc hl
    ld a, l
    ldh [hPlayerStepDYLo], a
    ld a, h
    ldh [hPlayerStepDYHi], a
    ld hl, hPlayerY
    dec [hl]
    jp Jump_002_5892

Jump_002_57FE::
    call UpdatePlayerMovement_Sub01_Sub01
    ldh a, [hPlayerStepDYLo]
    ld l, a
    ldh a, [hPlayerStepDYHi]
    ld h, a
    ld a, $08
    add_a_to_hl
    ld a, l
    ldh [hPlayerStepDYLo], a
    ld a, h
    ldh [hPlayerStepDYHi], a
    ldh a, [hPlayerY]
    sub a, $08
    ldh [hPlayerY], a
    ld a, [wFollowerRecords + $2]
    sub a, $08
    ld [wFollowerRecords + $2], a
    ld a, [wFollowerRecords + $7]
    sub a, $08
    ld [wFollowerRecords + $7], a
    ld a, [wFollowerRecords + $C]
    sub a, $08
    ld [wFollowerRecords + $C], a
    call SetFollowerTargetsFromLeader
    call StepFollowersTowardTargets
    jr Jump_002_5892

Jump_002_583A::
    ld a, [wFieldActionRequest]
    bit 7, a
    jr nz, Jump_002_5857
    call StepFollowersTowardTargets
    ldh a, [hPlayerStepDYLo]
    ld l, a
    ldh a, [hPlayerStepDYHi]
    ld h, a
    dec hl
    ld a, l
    ldh [hPlayerStepDYLo], a
    ld a, h
    ldh [hPlayerStepDYHi], a
    ld hl, hPlayerY
    inc [hl]
    jr Jump_002_5892

Jump_002_5857::
    call UpdatePlayerMovement_Sub01_Sub01
    ldh a, [hPlayerStepDYLo]
    ld l, a
    ldh a, [hPlayerStepDYHi]
    ld h, a
    ld a, l
    sub a, $08
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld a, l
    ldh [hPlayerStepDYLo], a
    ld a, h
    ldh [hPlayerStepDYHi], a
    ldh a, [hPlayerY]
    add a, $08
    ldh [hPlayerY], a
    ld a, [wFollowerRecords + $2]
    add a, $08
    ld [wFollowerRecords + $2], a
    ld a, [wFollowerRecords + $7]
    add a, $08
    ld [wFollowerRecords + $7], a
    ld a, [wFollowerRecords + $C]
    add a, $08
    ld [wFollowerRecords + $C], a
    call SetFollowerTargetsFromLeader
    call StepFollowersTowardTargets

Jump_002_5892::
    ldh a, [hPlayerStepDXLo]
    ld l, a
    ldh a, [hPlayerStepDXHi]
    ld h, a
    ld a, h
    or a, l
    ret nz
    ldh a, [hPlayerStepDYLo]
    ld l, a
    ldh a, [hPlayerStepDYHi]
    ld h, a
    ld a, h
    or a, l
    ret nz
    ld a, $01
    ld [wMapToggleRequest], a
    ldh a, [hPlayerStateFlags]
    bit 6, a
    jr z, Jump_002_58B1
    and a, $7F

Jump_002_58B1::
    and a, $BA
    ldh [hPlayerStateFlags], a
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    xor a, a
    ld [wStepTriggerFlag], a

Jump_002_58BF::
    farcall UpdatePlayerMovement_Sub01_Sub02
    farcall AdvanceStepCounterAndUpdateStoredRecords
    farcall RunPeriodicFieldEventChecks
    farcall UpdatePlayerMovement_Sub01_Sub03
    farcall TickRandomEncounterCounter
    farcall CheckStepTriggerAndDispatchTalk
    farcall CheckWarpsAtPlayerPosition
    farcall RunPlayerMoveTypeMapMoveType
    farcall EnterStatusEffectFieldState
    farcall CountDownTalkCountdownThenDispatchTalkEvent
    ret

; only called from UpdatePlayerMovement_Sub01 (E-0047)
; 4 call sites from 1 routine (e.g. UpdatePlayerMovement_Sub01)
; reads: wFollowerDelay, hPlayerFacing, hPlayerX, hPlayerY
; writes: wFollowerRecords
UpdatePlayerMovement_Sub01_Sub01::
Func_002_58FC:: ; address name
    ld a, [wFollowerDelay]
    or a, a
    ret z
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $A], a
    ldh a, [hPlayerX]
    ld [wFollowerRecords + $1], a
    ld [wFollowerRecords + $6], a
    ld [wFollowerRecords + $B], a
    ldh a, [hPlayerY]
    ld [wFollowerRecords + $2], a
    ld [wFollowerRecords + $7], a
    ld [wFollowerRecords + $C], a
    ret

; the three 5-byte follower records at wFollowerRecords hold direction, X, Y, target X, target Y: record 0's target = hPlayerX/hPlayerY, record 1's target = record 0's position, record 2's target = record 1's position (E-0093)
; 12 call sites from 6 routines (e.g. UpdatePlayerMovement, UpdatePlayerMovement_Sub01, UpdateFollowersOnStep_Bank0F, ScriptStepMoveFollowersToLeader, ...)
; reads: hPlayerX, hPlayerY, wFollowerRecords
; writes: wFollowerRecords
SetFollowerTargetsFromLeader::
Func_002_5923:: ; address name
    ldh a, [hPlayerX]
    ld [wFollowerRecords + $3], a
    ldh a, [hPlayerY]
    ld [wFollowerRecords + $4], a
    ld a, [wFollowerRecords + $1]
    ld [wFollowerRecords + $8], a
    ld a, [wFollowerRecords + $2]
    ld [wFollowerRecords + $9], a
    ld a, [wFollowerRecords + $6]
    ld [wFollowerRecords + $D], a
    ld a, [wFollowerRecords + $7]
    ld [wFollowerRecords + $E], a
    ret

; unless wC94D is non-zero, moves each of the three follower records one pixel toward its target (four pixels when wC468 bit 7 is set), X first and then Y, storing the direction moved in byte 0 (1 = X increasing, 3 = X decreasing; Y directions not read to the end) (E-0093)
; 12 call sites from 5 routines (e.g. UpdatePlayerMovement_Sub01, UpdateFollowersOnStep_Bank0F, ScriptStepMoveFollowersToLeader, UpdateFollowersOnStep_Bank12, ...)
; reads: wFollowerDelay, wFieldActionRequest
; points at: wFollowerRecords
StepFollowersTowardTargets::
Func_002_5946:: ; address name
    ld a, [wFollowerDelay]
    or a, a
    ret nz
    ld b, $03
    ld hl, wFollowerRecords
    ld de, wFollowerRecords + $3

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
    ld a, [wFieldActionRequest]
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
    ld a, [wFieldActionRequest]
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
    ld a, [wFieldActionRequest]
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
    ld a, [wFieldActionRequest]
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
; reads: hPlayerStateFlags, wMaxBlockingTile, wMapTallTileMin
; writes: wTilesUnderPoint
; points at: wTilesUnderPoint
TileBlockedAtPixel::
Func_002_59CD:: ; address name
    push bc
    push de
    ldh a, [hPlayerStateFlags]
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
    ld [wTilesUnderPoint], a
    ld a, [hl-]
    ld [wTilesUnderPoint + $1], a
    ld a, $14
    add_a_to_hl
    ld a, [hl+]
    ld [wTilesUnderPoint + $2], a
    ld a, [hl]
    ld [wTilesUnderPoint + $3], a
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr nz, Jump_002_5A35
    ld de, wTilesUnderPoint
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
    ld de, wTilesUnderPoint
    ld b, $02

Jump_002_5A3A::
    ld a, [de]
    inc de
    ld c, a
    ld a, [wMapTallTileMin]
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
; reads: wSpriteSlotCount, hTemp1, hTemp0
; writes: hTemp0, hTemp1
FindSpriteSlotAtTile::
Func_002_5A51:: ; address name
    ld a, [wSpriteSlotCount]
    or a, a
    ret z
    push bc
    ld a, c
    swap a
    and a, $0F
    ldh [hTemp0], a
    ld a, b
    swap a
    and a, $0F
    ldh [hTemp1], a
    ld a, [wSpriteSlotCount]
    ld b, a
    ld c, $01
    ld hl, wSpriteSlots + $B

Jump_002_5A6E::
    push hl
    push bc
    ld a, [hl]
    swap a
    and a, $0F
    ld c, a
    ldh a, [hTemp1]
    cp a, c
    jr z, Jump_002_5A88
    ld a, [hl]
    add a, $0F
    swap a
    and a, $0F
    ld c, a
    ldh a, [hTemp1]
    cp a, c
    jr nz, Jump_002_5AA1

Jump_002_5A88::
    inc hl
    ld a, [hl]
    swap a
    and a, $0F
    ld c, a
    ldh a, [hTemp0]
    cp a, c
    jr z, Jump_002_5AB1
    ld a, [hl]
    add a, $0F
    swap a
    and a, $0F
    ld c, a
    ldh a, [hTemp0]
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
; reads: wTriggerKind, wMapType, wTriggerCell
UpdatePlayerMovement_Sub02::
Func_002_5AB6:: ; address name
    push bc
    ld a, [wTriggerKind]
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
    ld a, [wMapType]
    bit 7, a
    jr nz, Jump_002_5AEE

Jump_002_5AD8::
    ld a, [wTriggerCell]
    swap a
    and a, $0F
    cp a, b
    jr nz, Jump_002_5AC2
    ld a, [wTriggerCell]
    and a, $0F
    cp a, c
    jr nz, Jump_002_5AC2
    ld a, $01
    pop bc
    ret

Jump_002_5AEE::
    cp a, $85
    jr z, Jump_002_5AD8
    ld a, [wTriggerCell]
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

; address loaded by UpdatePlayerMovement_Sub02
Data_002_5B0A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $02, $01, $07, $02, $01, $02, $04, $02, $06, $03, $03, $04, $05, $04, $07
    db $05, $01, $05, $03, $06, $05, $07, $02, $07, $04, $07, $07, $08, $01, $08, $06

; only called from FieldModeStateDispatch_Case00 (E-0047)
; 1 call site from 1 routine (e.g. FieldModeStateDispatch_Case00)
; reads: wFadeState, hPlayerStateFlags, wJoypadHeld, hMapScreenX, hMapScreenY, hMapId, hPlayerX, hPlayerY
; writes: wTalkEventGroup, wTalkEventIndex, wJoypadHeld, wJoypadPressed
FieldModeStateDispatch_Case00_Sub01::
Func_002_5B2A:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ldh a, [hPlayerStateFlags]
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
    ld [wTalkEventGroup], a
    xor a, a
    ld [wTalkEventIndex], a
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

; address loaded by FieldModeStateDispatch_Case00_Sub01
Data_002_5B89:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $11, $70, $70, $01, $11, $70, $20, $01, $10, $70, $50, $1A, $10, $70, $70
    db $85, $10, $50, $60, $FF

; clears wC8CE; if bit 7 of wC8CD is set, draws the full screen buffer to the BG map at the scroll position and clears wC8CD and wC8CE (E-0121)
; 15 call sites from 9 routines (e.g. CheckInteractionInFront, UpdatePlayerMovement, UpdatePlayerMovement_Sub01, FieldModeStateDispatch_Case05_Sub01_Case07, ...)
; reads: wPartyWindowFlags, hScrollY, hScrollX
; writes: wPartyWindowTimer, wPartyWindowFlags
RedrawScreenBufferIfPartyWindowFlagsBit7::
Func_002_5B9E:: ; address name
    xor a, a
    ld [wPartyWindowTimer], a
    ld a, [wPartyWindowFlags]
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
    ld [wPartyWindowFlags], a
    ld [wPartyWindowTimer], a
    ret

; if bit 7 of wC468 is set, runs the routine for wC468 & 3 (jump table) (E-0122)
; 12 call sites from 12 routines (e.g. FieldModeStateDispatch_Case05, FieldModeStateDispatch_Case01, FieldModeStateDispatch_Case00, SceneMedicineGiven_Case01, ...)
; reads: wFieldActionRequest
RunFieldActionRequestActionIfBit7::
Func_002_5BD7:: ; address name
    ld a, [wFieldActionRequest]
    bit 7, a
    ret z
    and a, $03
    rst $00
    dw RunFieldActionRequestActionIfBit7_Case00
    dw RunFieldActionRequestActionIfBit7_Case01
    dw RunFieldActionRequestActionIfBit7_Case02
    dw RunFieldActionRequestActionIfBit7_Case03

; entry 0 of the `rst $00` table in RunFieldActionRequestActionIfBit7
; no direct call (reached through a table, a jump or a vector)
; writes: wFieldActionStep
; points at: wFieldActionRequest
RunFieldActionRequestActionIfBit7_Case00::
Jump_002_5BE8:: ; address name
    call LoadMapScreen
    xor a, a
    ld [wFieldActionStep], a
    ld hl, wFieldActionRequest
    inc [hl]
    ret

; entry 3 of the `rst $00` table in RunFieldActionRequestActionIfBit7
; no direct call (reached through a table, a jump or a vector)
; writes: wStepTriggerFlag, wFieldActionRequest
RunFieldActionRequestActionIfBit7_Case03::
Jump_002_5BF4:: ; address name
    xor a, a
    ld [wStepTriggerFlag], a
    farcall AdvanceStepCounterAndUpdateStoredRecords
    farcall RunPeriodicFieldEventChecks
    farcall TickRandomEncounterCounter
    farcall CheckWarpsAtPlayerPosition
    farcall RunPlayerMoveTypeMapMoveType
    farcall EnterStatusEffectFieldState
    farcall CountDownTalkCountdownThenDispatchTalkEvent
    xor a, a
    ld [wFieldActionRequest], a
    ret

; entry 2 of the `rst $00` table in RunFieldActionRequestActionIfBit7
; no direct call (reached through a table, a jump or a vector)
; reads: wPendingFieldEvent
; writes: wPendingFieldEvent, wObject5
; points at: wFieldActionRequest
RunFieldActionRequestActionIfBit7_Case02::
Jump_002_5C27:: ; address name
    ld hl, wFieldActionRequest
    inc [hl]
    farcall FindTriggerEntryForCurrentScreen
    farcall FindTriggerEntryForCurrentScreen_ScreenTriggers
    farcall LoadMapObjectsForScreen
    ld a, [wPendingFieldEvent]
    bit 7, a
    jr z, Jump_002_5C4E
    bit 6, a
    jr nz, Jump_002_5C4E
    xor a, a
    ld [wPendingFieldEvent], a
    jr Jump_002_5C54

Jump_002_5C4E::
    farcall ClearPendingFieldEventWhenFieldIdle

Jump_002_5C54::
    xor a, a
    ld [wObject5], a
    farcall PlaceSpecialMapObjectsOnEntry
    ret

; entry 1 of the `rst $00` table in RunFieldActionRequestActionIfBit7
; no direct call (reached through a table, a jump or a vector)
; reads: hScrollY, hScrollX, wScreenScrollDir, wFieldActionStep
; writes: hScrollX, hScrollY
; points at: wScreenTileBuffer, wFieldActionStep, wFieldActionRequest
RunFieldActionRequestActionIfBit7_Case01::
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
    ld a, [wScreenScrollDir]
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
    ld a, [wFieldActionStep]
    add_a_to_hl
    call RunFieldActionRequestActionIfBit7_Case01_Sub01
    ldh a, [hScrollX]
    add a, $08
    ldh [hScrollX], a
    ld hl, wFieldActionStep
    inc [hl]
    ld a, [wFieldActionStep]
    cp a, $14
    jr nc, Jump_002_5CB8
    call ComputeSpriteScrollOffsets
    ret

Jump_002_5CB8::
    ldh a, [hScrollX]
    and a, $F8
    ldh [hScrollX], a
    farcall MarkVisitedMapScreenInVisitedScreens
    ld hl, wFieldActionRequest
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
    ld a, [wFieldActionStep]
    ld c, a
    ld a, $13
    sub a, c
    add_a_to_hl
    call RunFieldActionRequestActionIfBit7_Case01_Sub01
    ldh a, [hScrollX]
    sub a, $08
    ldh [hScrollX], a
    ld hl, wFieldActionStep
    inc [hl]
    ld a, [wFieldActionStep]
    cp a, $14
    jr nc, Jump_002_5D01
    call ComputeSpriteScrollOffsets
    ret

Jump_002_5D01::
    ldh a, [hScrollX]
    and a, $F8
    ldh [hScrollX], a
    farcall MarkVisitedMapScreenInVisitedScreens
    ld hl, wFieldActionRequest
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
    ld a, [wFieldActionStep]
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
    call RunFieldActionRequestActionIfBit7_Case01_Sub02
    ldh a, [hScrollY]
    add a, $08
    ldh [hScrollY], a
    ld hl, wFieldActionStep
    inc [hl]
    ld a, [wFieldActionStep]
    cp a, $12
    jr nc, Jump_002_5D54
    call ComputeSpriteScrollOffsets
    ret

Jump_002_5D54::
    ldh a, [hScrollY]
    and a, $F8
    ldh [hScrollY], a
    farcall MarkVisitedMapScreenInVisitedScreens
    ld hl, wFieldActionRequest
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
    ld a, [wFieldActionStep]
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
    call RunFieldActionRequestActionIfBit7_Case01_Sub02
    ldh a, [hScrollY]
    sub a, $08
    ldh [hScrollY], a
    ld hl, wFieldActionStep
    inc [hl]
    ld a, [wFieldActionStep]
    cp a, $12
    jr nc, Jump_002_5DB4
    call ComputeSpriteScrollOffsets
    ret

Jump_002_5DB4::
    ldh a, [hScrollY]
    and a, $F8
    ldh [hScrollY], a
    farcall MarkVisitedMapScreenInVisitedScreens
    ld hl, wFieldActionRequest
    inc [hl]
    call ComputeSpriteScrollOffsets

Jump_002_5DC7::
    ret

; only called from RunFieldActionRequestActionIfBit7_Case01 (E-0047)
; 2 call sites from 1 routine (e.g. RunFieldActionRequestActionIfBit7_Case01)
; reads: wIsCGB, hTemp0
; writes: wBGWriteDestLo, wBGWriteDestHi, wBGWriteVertical, wBGWriteCount, wAttrWriteDestLo, wAttrWriteDestHi, wAttrWriteVertical, wAttrWriteCount, ...
; points at: wBGWriteData, wAttrWriteData
RunFieldActionRequestActionIfBit7_Case01_Sub01::
Func_002_5DC8:: ; address name
    ld a, e
    ld [wBGWriteDestLo], a
    ld a, d
    ld [wBGWriteDestHi], a
    ld a, $01
    ld [wBGWriteVertical], a
    ld a, $12
    ld [wBGWriteCount], a
    push hl
    push de
    ld b, $12
    ld de, wBGWriteData

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
    ld [wAttrWriteDestLo], a
    ld a, d
    ld [wAttrWriteDestHi], a
    ld a, $01
    ld [wAttrWriteVertical], a
    ld a, $12
    ld [wAttrWriteCount], a
    ld de, $0E68
    add hl, de
    ld b, $12
    ld de, wAttrWriteData

Jump_002_5E10::
    ld a, $02
    ldh [rSVBK], a
    ld a, [hl]
    ldh [hTemp0], a
    ld a, $00
    ldh [rSVBK], a
    ldh a, [hTemp0]
    and a, $07
    ld [de], a
    ld a, $14
    add_a_to_hl
    inc de
    dec b
    jr nz, Jump_002_5E10
    ret

; only called from RunFieldActionRequestActionIfBit7_Case01 (E-0047)
; 2 call sites from 1 routine (e.g. RunFieldActionRequestActionIfBit7_Case01)
; reads: wIsCGB, hTemp0
; writes: wBGWriteDestLo, wBGWriteDestHi, wBGWriteVertical, wBGWriteCount, wAttrWriteDestLo, wAttrWriteDestHi, wAttrWriteVertical, wAttrWriteCount, ...
; points at: wBGWriteData, wAttrWriteData
RunFieldActionRequestActionIfBit7_Case01_Sub02::
Func_002_5E2C:: ; address name
    ld a, e
    ld [wBGWriteDestLo], a
    ld a, d
    ld [wBGWriteDestHi], a
    xor a, a
    ld [wBGWriteVertical], a
    ld a, $14
    ld [wBGWriteCount], a
    push hl
    push de
    ld b, $14
    ld de, wBGWriteData

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
    ld [wAttrWriteDestLo], a
    ld a, d
    ld [wAttrWriteDestHi], a
    ld a, $00
    ld [wAttrWriteVertical], a
    ld a, $14
    ld [wAttrWriteCount], a
    ld de, $0E68
    add hl, de
    ld b, $14
    ld de, wAttrWriteData

Jump_002_5E6C::
    ld a, $02
    ldh [rSVBK], a
    ld a, [hl+]
    ldh [hTemp0], a
    ld a, $00
    ldh [rSVBK], a
    ldh a, [hTemp0]
    and a, $07
    ld [de], a
    ld [de], a
    inc de
    dec b
    jr nz, Jump_002_5E6C
    ret

; calls Func_002_5E85 and falls into it, running it twice (E-0126)
; 4 call sites from 4 routines (e.g. RunFieldReturnPhase_Case02, RefreshRecordListAndNameTiles, PriestMenu_Case02_Case10, RefreshRecordListAndNameTiles_BankF1)
; reads: wPartyCount, wPartyList, hTemp0
; writes: rRAMG, wPartyList
RunFunc5E85Twice::
Func_002_5E82:: ; address name
    call MoveIncapacitatedPartyMembersBack

; reorders the party list so a member with bit 7 of field $55 set moves behind one without it (second/third and first/second pairs) (E-0127)
; 23 call sites from 12 routines (e.g. InitFieldScreen, RunFunc5E85Twice, SceneThreeItems_Case22, ScriptCommand9B_Run_Case05, ...)
; reads: wPartyCount, wPartyList, hTemp0
; writes: rRAMG, wPartyList
MoveIncapacitatedPartyMembersBack::
Func_002_5E85:: ; address name
    ld a, [wPartyCount]
    dec a
    ret z
    dec a
    jr nz, Jump_002_5E8F
    jr Jump_002_5EBA

Jump_002_5E8F::
    ld a, $0A
    ld [rRAMG], a
    ld c, $55
    ld a, [wPartyList + $1]
    call LoadSRAMRecordByte
    bit 7, a
    jr z, Jump_002_5EBA
    ld c, $55
    ld a, [wPartyList + $2]
    call LoadSRAMRecordByte
    bit 7, a
    jr nz, Jump_002_5EBA
    ld a, [wPartyList + $1]
    ld c, a
    ld a, [wPartyList + $2]
    ld [wPartyList + $1], a
    ld a, c
    ld [wPartyList + $2], a

Jump_002_5EBA::
    ld a, $0A
    ld [rRAMG], a
    ld c, $55
    ld a, [wPartyList]
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    bit 7, a
    jr z, Jump_002_5EE9
    ld c, $55
    ld a, [wPartyList + $1]
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    bit 7, a
    jr nz, Jump_002_5EE9
    ld a, [wPartyList]
    ld c, a
    ld a, [wPartyList + $1]
    ld [wPartyList], a
    ld a, c
    ld [wPartyList + $1], a

Jump_002_5EE9::
    xor a, a
    ld [rRAMG], a
    ret

; copies the first $168 bytes (20 x 18) of wScreenTileBuffer to vBGMap1 with WriteVRAMByteInc; on CGB also copies the $168 attribute bytes at wD000 to wD2D0 (rSVBK = 2); saves wSpriteSlotCount in wCB7E. RestoreScreenBufferFromBGMap1 undoes it (E-0066)
; 23 call sites from 21 routines (e.g. CheckInteractionInFront, FieldModeStateDispatch_Case05_Sub01_Case07, OpenFieldMenuOnA, TickRandomEncounterCounter, ...)
; reads: wIsCGB, wSpriteSlotCount
; writes: rSVBK, wScreenSavedFlag
; points at: wScreenTileBuffer, wScreenAttrBuffer, wSavedScreenAttrs
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
    ld hl, wScreenAttrBuffer
    ld de, wSavedScreenAttrs
    ld bc, $0168
    call CopyBytes
    ld a, $00
    ldh [rSVBK], a

Jump_002_5F1B::
    ld a, [wSpriteSlotCount]
    ld [wScreenSavedFlag], a
    ret

; copies $168 bytes from vBGMap1 back to wScreenTileBuffer (WaitForVRAMAccess, interrupts off per byte); on CGB copies wD2D0 back to wD000 (rSVBK = 2); restores wSpriteSlotCount from wCB7E (E-0066)
; 7 call sites from 7 routines (e.g. InitFieldScreen, ScriptCommand82_Run_Case0A_Case08, SceneWatchOut_Case0F, SceneWatchOut_Case0D, ...)
; reads: wIsCGB, wScreenSavedFlag
; writes: rSVBK, wSpriteSlotCount
; points at: wScreenTileBuffer, wSavedScreenAttrs, wScreenAttrBuffer
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
    ld hl, wSavedScreenAttrs
    ld de, wScreenAttrBuffer
    ld bc, $0168
    call CopyBytes
    ld a, $00
    ldh [rSVBK], a

Jump_002_5F52::
    ld a, [wScreenSavedFlag]
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

; on the Super Game Boy sends PAL_SET for wC51F and loads the object palettes; wC5E0 1 becomes 2. The following entry clears the joypad state and runs the field mode states (E-0129)
; 3 call sites from 3 routines (e.g. InitFieldScreen, GameMode6_Init, GameMode8_Init)
; reads: wSGBActive, wSGBPaletteSet, wSGBAttrFile, wFieldInitStage
; writes: wSGBPaletteNum0Lo, wSGBPaletteNum0Hi, wSGBPaletteNum1Lo, wSGBPaletteNum1Hi, wSGBPaletteNum2Lo, wSGBPaletteNum2Hi, wSGBPaletteNum3Lo, wSGBPaletteNum3Hi, ...
SendSGBFieldPaletteSet::
Func_002_5F9B:: ; address name
    ld a, [wSGBActive]
    or a, a
    jr z, Jump_002_5FEB
    ld a, [wSGBPaletteSet]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    ld [wSGBPaletteNum0Lo], a
    ld a, h
    ld [wSGBPaletteNum0Hi], a
    inc hl
    ld a, l
    ld [wSGBPaletteNum1Lo], a
    ld a, h
    ld [wSGBPaletteNum1Hi], a
    inc hl
    ld a, l
    ld [wSGBPaletteNum2Lo], a
    ld a, h
    ld [wSGBPaletteNum2Hi], a
    inc hl
    ld a, l
    ld [wSGBPaletteNum3Lo], a
    ld a, h
    ld [wSGBPaletteNum3Hi], a
    ld a, $B1
    ld [wSGBPacketBuffer], a
    ld a, [wSGBAttrFile]
    ld [wSGBPacketBuffer + $1], a
    ld a, $FF
    ld [wSGBPacketIndex], a
    farcall_b SendSGBPacketSet
    call SpinDelay
    farcall LoadSGBObjectPalettesFromPointers

Jump_002_5FEB::
    ld a, [wFieldInitStage]
    cp a, $01
    ret nz
    ld a, $02
    ld [wFieldInitStage], a
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
    ld [wFieldFrameFlag], a
    call FieldModeStateDispatch
    xor a, a
    ld [wFieldInitStage], a
    ld hl, wDMGPaletteBGP
    ld a, $D2
    ld [hl+], a
    ld a, $D2
    ld [hl+], a
    ld a, $E2
    ld [hl], a
    ld hl, wDMGPaletteBytes
    ld a, [wDMGPaletteBGP]
    ld [hl+], a
    ld a, [wDMGPaletteOBP0]
    ld [hl+], a
    ld a, [wDMGPaletteOBP1]
    ld [hl], a
    call ResetFadeFromDMGPaletteBGP
    ld a, [wSGBActive]
    or a, a
    jr z, Jump_002_6045
    ld hl, wOBJPaletteBuffer
    ld de, wOBJPaletteBuffer + $20
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
; 11 call sites from 11 routines (e.g. GameMode1_Init, InitFieldScreen, StepStringDisplayUntilDone_Sub01_Sub02_Case09, RunMenuStateMenuState_Case05, ...)
; reads: wMapType, wKeyWorldFloor, hPlayerStateFlags, wCurrentMusic, hMapId
; writes: wCurrentMusic
RestartMapMusic::
Func_002_604B:: ; address name
    ld a, $FF
    ld [wCurrentMusic], a

; chooses the music for the current map (by wCC44 and hMapId, with story-flag cases) and queues it unless it is already wC608 (E-0122)
; 9 call sites from 9 routines (e.g. FieldModeStateDispatch_Case04, RunFieldReturnPhase_Case02, SceneThreeItems_Case28, SceneCheerYuna_Case0A, ...)
; reads: wMapType, wKeyWorldFloor, hPlayerStateFlags, wCurrentMusic, hMapId
PlayMapMusic::
Func_002_6050:: ; address name
    ld a, [wMapType]
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
    ld a, [wKeyWorldFloor]
    add a, a
    add a, a
    ld hl, wKeyWorldFloorInfo + $1
    add_a_to_hl
    ld a, [hl]
    cp a, $06
    jr nz, Jump_002_6089

Jump_002_607F::
    ld c, $2B
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr nz, Jump_002_6089
    ld c, $35

Jump_002_6089::
    ld a, [wCurrentMusic]
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
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw PlayMapMusic_Case20
    dw PlayMapMusic_Case21
    dw PlayMapMusic_Case21
    dw PlayMapMusic_Case21
    dw PlayMapMusic_Case21
    dw PlayMapMusic_Case21
    dw PlayMapMusic_Case21
    dw $0000 ; unused index (E-0207)
    dw PlayMapMusic_Case20
    dw PlayMapMusic_Case20
    dw PlayMapMusic_Case21
    dw PlayMapMusic_Case2B
    dw $0000 ; unused index (E-0207)
    dw PlayMapMusic_Case21
    dw PlayMapMusic_Case21
    dw PlayMapMusic_Case20
    dw MapMusicByPlayerStateFlagsBit3
    dw PlayMapMusic_Case21
    dw PlayMapMusic_Case21
    dw PlayMapMusic_Case21
    dw PlayMapMusic_Case21
    dw PlayMapMusic_Case2B
    dw MapMusicByPlayerStateFlagsBit3
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case38
    dw PlayMapMusic_Case39
    dw PlayMapMusic_Case2B
    dw PlayMapMusic_Case3B
    dw PlayMapMusic_Case21
    dw PlayMapMusic_Case21
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case21
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case20
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
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
    dw PlayMapMusic_Case2B
    dw PlayMapMusic_Case2B
    dw PlayMapMusic_Case2B
    dw PlayMapMusic_Case2B
    dw PlayMapMusic_Case2B
    dw MapMusicByFlag23
    dw MapMusicByFlag23
    dw MapMusicByFlag23
    dw MapMusicByFlag23
    dw MapMusicByFlag23
    dw PlayMapMusic_Case37
    dw MapMusicByFlag23
    dw MapMusicByFlag23
    dw MapMusicByFlag23
    dw MapMusicByFlag23
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case37
    dw MapMusicByFlag23_631A
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw PlayMapMusic_Case20
    dw PlayMapMusic_Case21
    dw PlayMapMusic_Case21
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case20
    dw PlayMapMusic_Case21
    dw PlayMapMusic_Case21
    dw PlayMapMusic_Case20
    dw PlayMapMusic_Case20
    dw PlayMapMusic_Case21
    dw PlayMapMusic_Case21
    dw PlayMapMusic_Case21
    dw PlayMapMusic_Case21
    dw PlayMapMusic_Case20
    dw PlayMapMusic_Case2B
    dw PlayMapMusic_Case2B
    dw PlayMapMusic_Case2B
    dw PlayMapMusic_Case2B
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case21
    dw PlayMapMusic_Case20
    dw PlayMapMusic_Case2B
    dw PlayMapMusic_Case2B
    dw PlayMapMusic_Case2B
    dw PlayMapMusic_Case2B
    dw PlayMapMusic_Case2B
    dw PlayMapMusic_Case2B
    dw PlayMapMusic_Case2B
    dw PlayMapMusic_Case20
    dw PlayMapMusic_Case20
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case9B
    dw $0000 ; unused index (E-0207)
    dw PlayMapMusic_Case20
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw MapMusicByFlag25
    dw PlayMapMusic_CaseA1
    dw PlayMapMusic_CaseA1
    dw PlayMapMusic_CaseA1
    dw MapMusicByFlag25
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw PlayMapMusic_Case20
    dw PlayMapMusic_Case21
    dw PlayMapMusic_Case20
    dw PlayMapMusic_Case21
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case20
    dw PlayMapMusic_Case20
    dw PlayMapMusic_Case21
    dw PlayMapMusic_Case20
    dw PlayMapMusic_Case2B
    dw PlayMapMusic_Case2B
    dw PlayMapMusic_Case2B
    dw PlayMapMusic_Case2B
    dw $0000 ; unused index (E-0207)
    dw PlayMapMusic_Case20
    dw PlayMapMusic_Case21
    dw PlayMapMusic_Case21
    dw PlayMapMusic_Case20
    dw PlayMapMusic_Case21
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case20
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw PlayMapMusic_Case20
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case37
    dw $0000 ; unused index (E-0207)
    dw PlayMapMusic_Case20
    dw PlayMapMusic_Case20
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case37
    dw $0000 ; unused index (E-0207)
    dw PlayMapMusic_Case20
    dw PlayMapMusic_Case20
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case37
    dw PlayMapMusic_Case37
    dw $0000 ; unused index (E-0207)
    dw PlayMapMusic_Case20
    db $00, $00

; entry 0 of the `rst $00` table in PlayMapMusic
; no direct call (reached through a table, a jump or a vector)
; reads: wCurrentMusic
PlayMapMusic_Case00::
Jump_002_6268:: ; address name
    ld c, $16
    jp Jump_002_6089

; entry 1 of the `rst $00` table in PlayMapMusic
; no direct call (reached through a table, a jump or a vector)
; reads: hMapScreenY, hMapScreenX, wCurrentMusic
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
; reads: hMapScreenX, wCurrentMusic
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
; reads: wCurrentMusic
PlayMapMusic_Case0D::
Jump_002_62BB:: ; address name
    ld c, $0C
    jp Jump_002_6089

; entry 4 of the `rst $00` table in PlayMapMusic
; no direct call (reached through a table, a jump or a vector)
; reads: wCurrentMusic
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

; entry 33 of the `rst $00` table in PlayMapMusic
; no direct call (reached through a table, a jump or a vector)
; reads: wCurrentMusic
PlayMapMusic_Case21::
Jump_002_62DB:: ; address name
    ld c, $19
    jp Jump_002_6089

; map music case: if story flag $23 is set uses music $1C, else $2E (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wCurrentMusic
MapMusicByFlag23::
Jump_002_62E0:: ; address name
    ld de, $0023
    call TestFlagBit
    jr c, PlayMapMusic_Case21
    ld c, $2E
    jp Jump_002_6089

; map music case: on hMapScreenY 0, without flag $87, or with flag $8A uses the flag-$23 case; otherwise music $28 (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: hMapScreenY, wCurrentMusic
MapMusicByScreenAndFlags87And8A::
Jump_002_62ED:: ; address name
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

; entry 32 of the `rst $00` table in PlayMapMusic
; no direct call (reached through a table, a jump or a vector)
; reads: wCurrentMusic
PlayMapMusic_Case20::
Jump_002_6307:: ; address name
    ld c, $1C
    jp Jump_002_6089

; map music case: music $2B when bit 3 of hFF8C is set, else $1C (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerStateFlags, wCurrentMusic
MapMusicByPlayerStateFlagsBit3::
Jump_002_630C:: ; address name
    ld c, $1C
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jp z, Jump_002_6089
    ld c, $2B
    jp Jump_002_6089

; map music case: if story flag $23 is set uses music $1C, else $2E (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wCurrentMusic
MapMusicByFlag23_631A::
Jump_002_631A:: ; address name
    ld de, $0023
    call TestFlagBit
    jr c, PlayMapMusic_Case20
    ld c, $2E
    jp Jump_002_6089

; map music case: if story flag $25 is set uses music $1C, else $1F (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wCurrentMusic
MapMusicByFlag25::
Jump_002_6327:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, PlayMapMusic_Case20
    ld c, $1F
    jp Jump_002_6089

; entry 161 of the `rst $00` table in PlayMapMusic
; no direct call (reached through a table, a jump or a vector)
; reads: wCurrentMusic
PlayMapMusic_CaseA1::
Jump_002_6334:: ; address name
    ld c, $CC
    jp Jump_002_6089

; entry 43 of the `rst $00` table in PlayMapMusic
; no direct call (reached through a table, a jump or a vector)
; reads: wCurrentMusic
PlayMapMusic_Case2B::
Jump_002_6339:: ; address name
    ld c, $25
    jp Jump_002_6089

; entry 56 of the `rst $00` table in PlayMapMusic
; no direct call (reached through a table, a jump or a vector)
; reads: hMapScreenX, hMapScreenY, wCurrentMusic
PlayMapMusic_Case38::
Jump_002_633E:: ; address name
    ldh a, [hMapScreenX]
    or a, a
    jr nz, PlayMapMusic_Case2B
    ldh a, [hMapScreenY]
    or a, a
    jr nz, PlayMapMusic_Case2B
    call InitSoundHardware
    ret

; entry 57 of the `rst $00` table in PlayMapMusic
; no direct call (reached through a table, a jump or a vector)
; reads: hMapScreenX, hMapScreenY, wCurrentMusic
PlayMapMusic_Case39::
Jump_002_634C:: ; address name
    ldh a, [hMapScreenX]
    cp a, $01
    jr nz, PlayMapMusic_Case2B
    ldh a, [hMapScreenY]
    cp a, $01
    jr nz, PlayMapMusic_Case2B
    ld de, $007C
    call TestFlagBit
    jr c, PlayMapMusic_Case2B
    ld c, $28
    jp Jump_002_6089

; entry 59 of the `rst $00` table in PlayMapMusic
; no direct call (reached through a table, a jump or a vector)
; reads: wCurrentMusic
PlayMapMusic_Case3B::
Jump_002_6365:: ; address name
    ld de, $0022
    call TestFlagBit
    jr c, PlayMapMusic_Case2B
    ld c, $28
    jp Jump_002_6089

; entry 55 of the `rst $00` table in PlayMapMusic
; no direct call (reached through a table, a jump or a vector)
; reads: wCurrentMusic
PlayMapMusic_Case37::
Jump_002_6372:: ; address name
    ld c, $22
    jp Jump_002_6089

; entry 155 of the `rst $00` table in PlayMapMusic
; no direct call (reached through a table, a jump or a vector)
; reads: hMapScreenY, wCurrentMusic
PlayMapMusic_Case9B::
Jump_002_6377:: ; address name
    ldh a, [hMapScreenY]
    or a, a
    jr nz, PlayMapMusic_Case37
    ld de, $00C2
    call TestFlagBit
    jr nc, PlayMapMusic_Case37
    ld de, $00C3
    call TestFlagBit
    jr c, PlayMapMusic_Case37
    ld c, $28
    jp Jump_002_6089

; only called from FieldModeStateDispatch_Case02 (E-0047)
; 1 call site from 1 routine (e.g. FieldModeStateDispatch_Case02)
; reads: wJoypadPressed, wMapType, wMenuState
; writes: wFieldReturnPhase, hSpriteWindowClipMode, wModeState, wGameMode, wGameMode2State, wMenuState
FieldModeStateDispatch_Case02_Sub01::
Func_002_6391:: ; address name
    call FieldModeStateDispatch_Case02_Sub01_Sub01
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, Jump_002_63BD
    xor a, a
    ld [wFieldReturnPhase], a
    farcall ClearBit1OfPlayerAndObjectFlags
    xor a, a
    ldh [hSpriteWindowClipMode], a
    call FieldModeStateDispatch_Case02_Sub01_Sub02
    ld a, [wMapType]
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
    ld a, [wMenuState]
    ld [wModeState], a
    xor a, a
    ld [wGameMode2State], a
    ret

Jump_002_63D6::
    bit 5, a
    jr z, Jump_002_63E8
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuState]
    xor a, $01
    ld [wMenuState], a
    ret

Jump_002_63E8::
    bit 4, a
    jr z, Jump_002_63FA
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuState]
    xor a, $01
    ld [wMenuState], a
    ret

Jump_002_63FA::
    bit 6, a
    jr z, Jump_002_640C
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuState]
    xor a, $02
    ld [wMenuState], a
    ret

Jump_002_640C::
    bit 7, a
    jr z, Jump_002_641D
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuState]
    xor a, $02
    ld [wMenuState], a

Jump_002_641D::
    ret

; only called from FieldModeStateDispatch_Case02_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. FieldModeStateDispatch_Case02_Sub01)
; reads: hScrollY, hScrollX, wMenuState, wMenuSubState
; writes: wMenuSubState
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
    ld a, [wMenuState]
    cp a, b
    jr nz, Jump_002_649F
    ld c, $BC
    bit 7, a
    jr nz, Jump_002_649F
    ld c, $BB
    ld a, [wMenuSubState]
    inc a
    ld [wMenuSubState], a
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

; address loaded by FieldModeStateDispatch_Case02_Sub01_Sub01
Data_002_64AB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $01, $06, $01, $01, $03, $06, $03

; only called from FieldModeStateDispatch_Case02_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. FieldModeStateDispatch_Case02_Sub01)
; reads: hScrollY, hScrollX
; writes: wPartyWindowFlags, wPartyWindowTimer
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
    ld [wPartyWindowFlags], a
    xor a, a
    ld [wPartyWindowTimer], a
    ret

; in the field, when A is pressed and nothing blocks it: saves the screen, sets the object flags and draws the field menu windows (Data_002_6606, 6642) (E-0130)
; 3 call sites from 3 routines (e.g. RunFieldReturnPhase_Case01, FieldModeStateDispatch_Case00, FieldModeStateDispatch_Case05)
; reads: wFadeState, wTextWindowState, wFieldActionRequest, hPlayerStateFlags, wJoypadPressed, wIsCGB, hScrollY, hScrollX, ...
; writes: hSpriteWindowClipMode, wFieldReturnPhase, rSVBK, wPartyWindowTimer, wModeState, wMenuState
; points at: wWindowTileBuffer, wScreenTileBuffer, wWindowAttrBuffer, wScreenAttrBuffer
OpenFieldMenuOnA::
Func_002_64E5:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ld de, $0002
    call TestFlagBit
    ret nc
    ld a, [wTextWindowState]
    and a, $03
    ret nz
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    ldh a, [hPlayerStateFlags]
    bit 0, a
    ret nz
    ld a, [wJoypadPressed]
    bit 0, a
    ret z
    ld a, $03
    ldh [hSpriteWindowClipMode], a
    ld a, $01
    ld [wFieldReturnPhase], a
    farcall SaveScreenBufferToBGMap1
    farcall SetBit1OfPlayerAndObjectFlags
    ld hl, wWindowTileBuffer
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
    ld hl, wWindowAttrBuffer
    ld de, wScreenAttrBuffer
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
    ld de, TileRect_02_6606
    ld hl, wWindowTileBuffer
    ld bc, $0C05
    call CopyRectToScreenBufferAndClearAttributes_65C3
    ld de, TileRect_02_6642
    ld hl, wWindowTileBuffer + $C
    ld bc, $0803
    call CopyRectToScreenBufferAndClearAttributes_65C3
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
    call CopyScreenRectToBGMapSetTextCursorLo
    ld a, $B3
    ld [wPartyWindowTimer], a
    call ShowIdlePartyStatusWindow
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
    call DrawGoldDigitsAtHLWrapped
    ld a, $69
    call QueueSoundEffect
    ld a, $02
    ld [wModeState], a
    ldh a, [hTemp8]
    or a, a
    ret nz
    xor a, a
    ld [wMenuState], a
    ret

; copies a B x C rectangle from DE to HL (20-byte rows); on CGB clears the matching attribute rows in WRAM bank 2 (E-0127)
; 2 call sites from 1 routine (e.g. OpenFieldMenuOnA)
; reads: wIsCGB
; writes: rSVBK
CopyRectToScreenBufferAndClearAttributes_65C3::
Func_002_65C3:: ; address name
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

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 12 x 5 tiles, one row per line
TileRect_02_6606::
Data_002_6606:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $A4, $A5, $A6, $A7, $C3, $A4, $A8, $A9, $EC, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $AA, $AB, $A4, $AC, $C3, $AD, $AC, $AE, $A5, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 4

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 3 tiles, one row per line
TileRect_02_6642::
Data_002_6642:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $BF, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 2

; writes the gold as up to five decimal digit tiles without leading zeros at HL in VRAM, wrapping at the row end (E-0128)
; 1 call site from 1 routine (e.g. OpenFieldMenuOnA)
; reads: wGoldLo, wGoldMid, wGoldHi
; writes: wDigits
; points at: hTemp2
DrawGoldDigitsAtHLWrapped::
Func_002_665A:: ; address name
    push hl
    ld a, [wGoldLo]
    ld l, a
    ld a, [wGoldMid]
    ld h, a
    ld a, l
    ld [wDigits], a
    ld a, h
    ld [wDigits + $1], a
    ld a, [wGoldHi]
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    pop hl
    ld c, $00
    ld b, $03
    ld de, hTemp2
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

; in the field, after $B4 idle frames: saves the bottom of the screen and shows the party status window (level, HP, MP) (E-0130)
; 1 call site from 1 routine (e.g. OpenFieldMenuOnA)
; reads: wTextWindowState, wFieldActionRequest, wPartyCount, hPlayerStateFlags, wPartyWindowFlags, wPartyWindowTimer, wIsCGB
; writes: wPartyWindowTimer, wPartyWindowFlags, hSpriteWindowClipMode, rSVBK
; points at: wScreenTileBuffer
ShowIdlePartyStatusWindow::
Func_002_66CC:: ; address name
    ld de, $0002
    call TestFlagBit
    ret nc
    ld a, [wTextWindowState]
    and a, $03
    ret nz
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    ld a, [wPartyCount]
    or a, a
    ret z
    ldh a, [hPlayerStateFlags]
    bit 0, a
    ret nz
    ld a, [wPartyWindowFlags]
    bit 7, a
    ret nz
    ld a, [wPartyWindowTimer]
    inc a
    ld [wPartyWindowTimer], a
    cp a, $B4
    ret nz
    xor a, a
    ld [wPartyWindowTimer], a
    ld a, [wPartyCount]
    dec a
    or a, $80
    ld [wPartyWindowFlags], a
    ld a, $03
    ldh [hSpriteWindowClipMode], a
    ld hl, wWindowTileBuffer + $64
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
    ld hl, wWindowAttrBuffer + $64
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
    ld a, [wPartyWindowFlags]
    and a, $03
    jr z, Jump_002_6753
    dec a
    jr z, Jump_002_6761
    dec a
    jr z, Jump_002_676F
    ret

Jump_002_6753::
    ld de, TileRect_02_68E6
    ld hl, wWindowTileBuffer + $64
    ld bc, $0706
    call CopyRectToScreenBufferAndClearAttributes_68A3
    jr Jump_002_677B

Jump_002_6761::
    ld de, TileRect_02_6910
    ld hl, wWindowTileBuffer + $64
    ld bc, $0D06
    call CopyRectToScreenBufferAndClearAttributes_68A3
    jr Jump_002_677B

Jump_002_676F::
    ld de, TileRect_02_695E
    ld hl, wWindowTileBuffer + $64
    ld bc, $1306
    call CopyRectToScreenBufferAndClearAttributes_68A3

Jump_002_677B::
    call BuildPartyStatusWindowRows
    call DrawBottomWindowWC364AtScroll
    farcall LoadTilesForPartyRecords
    ret

; for each party member writes level (field $56), HP (field $5B) and MP (field $5F) into the status window at wC364 (offsets Data_002_6835) (E-0130)
; 1 call site from 1 routine (e.g. ShowIdlePartyStatusWindow)
; reads: wPartyWindowFlags, hTemp0, hTemp5, hTemp1
; writes: rRAMG, hTemp5
; points at: wPartyList
BuildPartyStatusWindowRows::
Func_002_6788:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, [wPartyWindowFlags]
    and a, $03
    inc a
    ld b, a
    ld hl, Data_002_6835
    ld de, wPartyList

Jump_002_679A::
    push bc
    push de
    ld a, [de]
    ldh [hTemp5], a
    ld c, $56
    call LoadSRAMRecordByte
    push hl
    ldh a, [hTemp0]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    pop hl
    ld a, [hl+]
    ld de, wWindowTileBuffer + $64
    add a, e
    ld e, a
    jr nc, Jump_002_67B7
    inc d

Jump_002_67B7::
    call WriteTwoDigitTilesFromWC8C1
    ldh a, [hTemp5]
    ld c, $5B
    call LoadSRAMRecordWord
    push hl
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    call HLToDecimalDigits
    pop hl
    ld a, [hl+]
    ld de, wWindowTileBuffer + $64
    add a, e
    ld e, a
    jr nc, Jump_002_67D5
    inc d

Jump_002_67D5::
    call WriteDecimalDigitTiles
    ldh a, [hTemp5]
    ld c, $5F
    call LoadSRAMRecordWord
    push hl
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    call HLToDecimalDigits
    pop hl
    ld a, [hl+]
    ld de, wWindowTileBuffer + $64
    add a, e
    ld e, a
    jr nc, Jump_002_67F3
    inc d

Jump_002_67F3::
    call WriteDecimalDigitTiles
    ld a, [hl+]
    ld de, wWindowTileBuffer + $64
    add a, e
    ld e, a
    jr nc, Jump_002_67FF
    inc d

Jump_002_67FF::
    ldh a, [hTemp5]
    ld c, $55
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
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
    ldh a, [hTemp0]
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

; address loaded by BuildPartyStatusWindowRows
Data_002_6835:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $54, $2B, $3F, $51, $5A, $31, $45, $57, $60, $37, $4B, $5D

; draws the 20 x 6 window wC364 at the scroll position + $180 (and its CGB attributes from wD1CC) (E-0127)
; 1 call site from 1 routine (e.g. ShowIdlePartyStatusWindow)
; reads: hScrollY, hScrollX, wIsCGB
; writes: rVBK, rSVBK
DrawBottomWindowWC364AtScroll::
Func_002_6841:: ; address name
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
    ld de, wWindowTileBuffer + $64
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
    ld de, wWindowAttrBuffer + $64
    ld bc, $1406
    xor a, a
    call CopyRectFromBankToBGMapWrapped
    ld a, $00
    ldh [rSVBK], a
    ld a, $00
    ldh [rVBK], a
    ret

; copies a B x C rectangle from DE to HL (20-byte rows); on CGB clears the matching attribute rows in WRAM bank 2 (E-0127)
; 3 call sites from 1 routine (e.g. ShowIdlePartyStatusWindow)
; reads: wIsCGB
; writes: rSVBK
CopyRectToScreenBufferAndClearAttributes_68A3::
Func_002_68A3:: ; address name
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

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 7 x 6 tiles, one row per line
TileRect_02_68E6::
Data_002_68E6:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $D0, $D1, $D2, $D3, $D4, $B7 ; id 1
    db $B6, $C7, $EB, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $EC, $C3, $C3, $C3, $B7 ; id 3
    db $B6, $C3, $EA, $ED, $C3, $C3, $B7 ; id 4
    db $B3, $B4, $B4, $B4, $B4, $B4, $B5 ; id 5

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 13 x 6 tiles, one row per line
TileRect_02_6910::
Data_002_6910:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $D0, $D1, $D2, $D3, $D4, $C3, $D5, $D6, $D7, $D8, $D9, $B7 ; id 1
    db $B6, $C7, $EB, $C3, $C3, $C3, $C3, $C8, $EB, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $EC, $C3, $C3, $C3, $C3, $C3, $EC, $C3, $C3, $C3, $B7 ; id 3
    db $B6, $C3, $EA, $ED, $C3, $C3, $C3, $C3, $EA, $ED, $C3, $C3, $B7 ; id 4
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 5

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 19 x 6 tiles, one row per line
TileRect_02_695E::
Data_002_695E:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $D0, $D1, $D2, $D3, $D4, $C3, $D5, $D6, $D7, $D8, $D9, $C3, $DA, $DB, $DC, $DD, $DE, $B7 ; id 1
    db $B6, $C7, $EB, $C3, $C3, $C3, $C3, $C8, $EB, $C3, $C3, $C3, $C3, $C9, $EB, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $EC, $C3, $C3, $C3, $C3, $C3, $EC, $C3, $C3, $C3, $C3, $C3, $EC, $C3, $C3, $C3, $B7 ; id 3
    db $B6, $C3, $EA, $ED, $C3, $C3, $C3, $C3, $EA, $ED, $C3, $C3, $C3, $C3, $EA, $ED, $C3, $C3, $B7 ; id 4
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 5

; while wC8CB & 3 is set: copies the text window rows to or from wC300 (with CGB attributes) and redraws them at the scroll position (E-0130)
; 10 call sites from 10 routines (e.g. FieldModeStateDispatch_Case01, GameMode5_Init_Case02, GameMode5_Init_Case03, GameMode5_Init_Case06, ...)
; reads: wTextWindowState, wIsCGB, hScrollY, hScrollX, wTextWindowStep
; writes: rSVBK
; points at: wWindowTileBuffer, wScreenTileBuffer, wTextWindowStep
StepTextWindowOpenClose::
Func_002_69D0:: ; address name
    ld a, [wTextWindowState]
    and a, $03
    ret z
    ld hl, wWindowTileBuffer
    ld de, wScreenTileBuffer
    ld a, [wTextWindowState]
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
    ld a, [wTextWindowState]
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
    ld hl, wTextWindowStep
    inc [hl]
    ld a, [wTextWindowStep]
    and a, $01
    dec a
    ret nz
    ld a, [wTextWindowStep]
    srl a
    and a, $03
    rst $00
    dw StepTextWindowOpenClose_Case00
    dw StepTextWindowOpenClose_Case01
    dw StepTextWindowOpenClose_Case02
    dw StepTextWindowOpenClose_Case02

; entry 0 of the `rst $00` table in StepTextWindowOpenClose
; no direct call (reached through a table, a jump or a vector)
; reads: wTextWindowState
StepTextWindowOpenClose_Case00::
Jump_002_6A75:: ; address name
    ld a, [wTextWindowState]
    bit 0, a
    jr z, Jump_002_6A92
    push de
    ld hl, wWindowTileBuffer + $28
    ld de, Data_002_6B8C
    ld b, $01
    call CopyRowsToScreenBufferAndClearAttributes
    pop de
    ld l, e
    ld h, d
    ld bc, $1405
    call CopyScreenRectToBGMapSetTextCursorLo
    ret

Jump_002_6A92::
    push de
    ld hl, wWindowTileBuffer + $14
    ld de, Data_002_6BA0
    ld b, $03
    call CopyRowsToScreenBufferAndClearAttributes
    pop de
    ld l, e
    ld h, d
    ld bc, $1405
    call CopyScreenRectToBGMapSetTextCursorLo
    ret

; entry 1 of the `rst $00` table in StepTextWindowOpenClose
; no direct call (reached through a table, a jump or a vector)
; reads: wTextWindowState
StepTextWindowOpenClose_Case01::
Jump_002_6AA8:: ; address name
    ld a, [wTextWindowState]
    bit 0, a
    jr z, Jump_002_6AC5
    push de
    ld hl, wWindowTileBuffer + $14
    ld de, Data_002_6BA0
    ld b, $03
    call CopyRowsToScreenBufferAndClearAttributes
    pop de
    ld l, e
    ld h, d
    ld bc, $1405
    call CopyScreenRectToBGMapSetTextCursorLo
    ret

Jump_002_6AC5::
    push de
    ld hl, wWindowTileBuffer + $28
    ld de, Data_002_6B8C
    ld b, $01
    call CopyRowsToScreenBufferAndClearAttributes
    pop de
    ld l, e
    ld h, d
    ld bc, $1405
    call CopyScreenRectToBGMapSetTextCursorLo
    ret

; entry 2 of the `rst $00` table in StepTextWindowOpenClose
; no direct call (reached through a table, a jump or a vector)
; reads: wTextWindowState
; writes: wTextWindowState, wTextWindowStep
; points at: wWindowTileBuffer
StepTextWindowOpenClose_Case02::
Jump_002_6ADB:: ; address name
    ld a, [wTextWindowState]
    bit 0, a
    jr z, Jump_002_6B04
    push de
    ld hl, wWindowTileBuffer
    ld de, Data_002_6BDC
    ld b, $05
    call CopyRowsToScreenBufferAndClearAttributes
    pop de
    ld l, e
    ld h, d
    ld bc, $1405
    call CopyScreenRectToBGMapSetTextCursorLo
    ld a, [wTextWindowState]
    and a, $80
    ld [wTextWindowState], a
    xor a, a
    ld [wTextWindowStep], a
    ret

Jump_002_6B04::
    ld l, e
    ld h, d
    ld bc, $1405
    call CopyScreenRectToBGMapSetTextCursorLo
    ld a, [wTextWindowState]
    and a, $80
    ld [wTextWindowState], a
    xor a, a
    ld [wTextWindowStep], a
    ret

; copies a rectangle of the screen buffer wC300 to the BG map (CopyRectFromBankToBGMapWrapped) and sets wC554 = HL + $21 (wrapped in the map); on CGB also copies the attributes from wD168 in VRAM bank 1 (E-0121)
; 7 call sites from 4 routines (e.g. StepTextWindowOpenClose_Case02, StepTextWindowOpenClose_Case01, StepTextWindowOpenClose_Case00, OpenFieldMenuOnA)
; reads: wIsCGB
; writes: wTextCursorLo, wTextCursorHi, rVBK, rSVBK
; points at: wWindowTileBuffer, wWindowAttrBuffer
CopyScreenRectToBGMapSetTextCursorLo::
Func_002_6B19:: ; address name
    push bc
    push hl
    ld de, wWindowTileBuffer
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
    ld [wTextCursorLo], a
    ld a, h
    ld [wTextCursorHi], a
    pop hl
    pop bc
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, $01
    ldh [rVBK], a
    ld a, $02
    ldh [rSVBK], a
    ld de, wWindowAttrBuffer
    xor a, a
    call CopyRectFromBankToBGMapWrapped
    ld a, $00
    ldh [rVBK], a
    ld a, $00
    ldh [rSVBK], a
    ret

; copies B rows of 20 bytes from DE to HL; on CGB also clears the matching attribute rows in WRAM bank 2 (HL + $E68) (E-0125)
; 5 call sites from 3 routines (e.g. StepTextWindowOpenClose_Case02, StepTextWindowOpenClose_Case01, StepTextWindowOpenClose_Case00)
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

; address loaded by StepTextWindowOpenClose_Case00, StepTextWindowOpenClose_Case01
Data_002_6B8C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B6
    ds $12, $C3
    db $B7

; address loaded by StepTextWindowOpenClose_Case00, StepTextWindowOpenClose_Case01
Data_002_6BA0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0
    ds $12, $B1
    db $B2, $B6
    ds $12, $C3
    db $B7, $B3
    ds $12, $B4
    db $B5

; address loaded by StepTextWindowOpenClose_Case02
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
; reads: wMenuState
RunMenuStateMenuState::
Func_002_6C40:: ; address name
    ld a, [wMenuState]
    or a, a
    jr nz, Jump_002_6C46

Jump_002_6C46::
    ld a, [wMenuState]
    and a, $0F
    rst $00
    dw RunMenuStateMenuState_Case00
    dw RunMenuStateMenuState_Case01
    dw RunMenuStateMenuState_Case02
    dw RunMenuStateMenuState_Case03
    dw RunMenuStateMenuState_Case04
    dw RunMenuStateMenuState_Case05
    dw RunMenuStateMenuState_Case06
    dw RunMenuStateMenuState_Case06
    dw RunMenuStateMenuState_Case06

; entry 6 of the `rst $00` table in RunMenuStateMenuState
; no direct call (reached through a table, a jump or a vector)
RunMenuStateMenuState_Case06::
Jump_002_6C5E:: ; address name
    ret

; entry 0 of the `rst $00` table in RunMenuStateMenuState
; no direct call (reached through a table, a jump or a vector)
; reads: wMapToggleFlag
; writes: wMenuSubState, wMenuCursor
; points at: wMenuState
RunMenuStateMenuState_Case00::
Jump_002_6C5F:: ; address name
    ld a, $02
    call QueueMusic
    call InitSoundHardware
    ld hl, wMenuState
    inc [hl]
    ld a, [wMapToggleFlag]
    bit 7, a
    jr z, Jump_002_6C7F
    xor a, a
    ld [wMenuSubState], a
    ld [wMenuCursor], a
    ld a, $78
    call QueueSoundEffect
    ret

Jump_002_6C7F::
    xor a, a
    ld [wMenuSubState], a
    ld a, $3B
    ld [wMenuCursor], a
    ret

; entry 1 of the `rst $00` table in RunMenuStateMenuState
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuCursor, hScrollX
; writes: wMenuCursor, wMenuSubState, wMenuSelectedMember, wSubMenuCursor, wSubMenuCursor2, wMenuOption, wMenuOption2, wScreenState, ...
; points at: wBGPaletteCopy, wMenuState
RunMenuStateMenuState_Case01::
Jump_002_6C89:: ; address name
    ld a, [wMenuCursor]
    inc a
    ld [wMenuCursor], a
    cp a, $3C
    ret c
    ld a, $61
    call QueueSoundEffect
    call RunMenuStateMenuState_Case01_Sub02
    xor a, a
    ld [wMenuSubState], a
    ld [wMenuSelectedMember], a
    ld [wMenuCursor], a
    ld [wSubMenuCursor], a
    ld [wSubMenuCursor2], a
    ld [wMenuOption], a
    ld [wMenuOption2], a
    ld hl, wBGPaletteCopy
    ld b, $90

Jump_002_6CB6::
    ldh a, [hScrollX]
    ld [hl+], a
    dec b
    jr nz, Jump_002_6CB6
    ld hl, wMenuState
    inc [hl]
    ld a, $1E
    ld [wMenuSelectedMember], a
    xor a, a
    ld [wScreenState], a
    ld [wScreenSubStep], a
    call RunMenuStateMenuState_Case01_Sub01
    xor a, a
    ld [wScreenState], a
    ret

; only called from RunMenuStateMenuState_Case01 (E-0047)
; 1 call site from 1 routine (e.g. RunMenuStateMenuState_Case01)
; reads: hScrollY, hScrollX
RunMenuStateMenuState_Case01_Sub02::
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

; entry 2 of the `rst $00` table in RunMenuStateMenuState
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuSelectedMember
; writes: wMenuSubState, wMenuSelectedMember, wMenuCursor, rLYC, wSTATSplitEnable
; points at: wMenuState
RunMenuStateMenuState_Case02::
Jump_002_6D28:: ; address name
    ld a, [wMenuSelectedMember]
    and a, $01
    ld [wMenuSubState], a
    ld a, [wMenuSelectedMember]
    dec a
    ld [wMenuSelectedMember], a
    ret nz
    ld hl, wMenuState
    inc [hl]
    ld a, $01
    ld [wMenuCursor], a
    di
    ld a, $02
    ldh [rLYC], a
    ld a, $02
    ld [wSTATSplitEnable], a
    ei
    ret

; entry 3 of the `rst $00` table in RunMenuStateMenuState
; no direct call (reached through a table, a jump or a vector)
; reads: wFrameCounterLo, wMenuCursor, hTemp0, hScrollX, hTemp1
; writes: wMenuSubState, wMenuCursor, wSubMenuCursor, hTemp0, hTemp1
; points at: wMenuState, wBGPaletteCopy
RunMenuStateMenuState_Case03::
Jump_002_6D4D:: ; address name
    ld a, $01
    ld [wMenuSubState], a
    ld a, [wFrameCounterLo]
    and a, $07
    jr nz, Jump_002_6D75
    ld a, [wMenuCursor]
    swap a
    and a, $0F
    inc a
    ld b, a
    ld a, [wMenuCursor]
    add a, b
    ld [wMenuCursor], a
    cp a, $38
    jr c, Jump_002_6D75
    ld hl, wMenuState
    inc [hl]
    xor a, a
    ld [wSubMenuCursor], a

Jump_002_6D75::
    ld a, [wMenuCursor]
    ldh [hTemp0], a
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
    ld bc, wBGPaletteCopy
    ld a, $24
    ldh [hTemp1], a
    jr Jump_002_6DB7

Jump_002_6D96::
    cp a, $01
    jr nz, Jump_002_6DA3
    ld bc, wBGPaletteCopy + $24
    ld a, $48
    ldh [hTemp1], a
    jr Jump_002_6DB7

Jump_002_6DA3::
    cp a, $02
    jr nz, Jump_002_6DB0
    ld bc, wTextBuf0 + $8
    ld a, $6C
    ldh [hTemp1], a
    jr Jump_002_6DB7

Jump_002_6DB0::
    ld bc, wTextBuf2 + $C
    ld a, $90
    ldh [hTemp1], a

Jump_002_6DB7::
    inc e
    ld a, e
    and a, $0F
    ld e, a
    ld hl, Data_002_6DDE
    add hl, de
    push bc
    ld c, [hl]
    ldh a, [hTemp0]
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
    ldh a, [hTemp1]
    cp a, c
    jr nz, Jump_002_6DB7
    ret

; address loaded by RunMenuStateMenuState_Case03
Data_002_6DDE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $60, $B6, $EC, $FF, $EC, $B6, $60, $00, $60, $B6, $EC, $FF, $EC, $B6, $60

; entry 4 of the `rst $00` table in RunMenuStateMenuState
; no direct call (reached through a table, a jump or a vector)
; reads: wFrameCounterLo, wSubMenuCursor, wMenuCursor, hTemp0, hScrollX, hTemp1
; writes: wSubMenuCursor, wSTATSplitEnable, wDMGPaletteBGP, hTemp0, hTemp1
; points at: wMenuState, wBGPaletteCopy
RunMenuStateMenuState_Case04::
Jump_002_6DEE:: ; address name
    ld a, [wFrameCounterLo]
    and a, $0F
    jr nz, Jump_002_6E0B
    ld a, [wSubMenuCursor]
    inc a
    ld [wSubMenuCursor], a
    cp a, $04
    jr nz, Jump_002_6E0B
    call RunMenuStateMenuState_Case04_Sub01
    ld hl, wMenuState
    inc [hl]
    xor a, a
    ld [wSTATSplitEnable], a

Jump_002_6E0B::
    ld a, [wSubMenuCursor]
    ld hl, Data_002_6E20
    add_a_to_hl
    ld a, [hl]
    ld [wDMGPaletteBGP], a
    call RunMenuStateMenuState_Case04_Sub01
    jp Jump_002_6D75

; address loaded by RunMenuStateMenuState_Case04
Data_002_6E20:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $D2, $81, $40, $00, $00

; entry 5 of the `rst $00` table in RunMenuStateMenuState
; no direct call (reached through a table, a jump or a vector)
; reads: wMapToggleFlag, wWarpDestFacing, wKeyWorldWidth, wKeyWorldHeight, wWarpDestX, wWarpDestY, hPlayerFacing, hPlayerX, ...
; writes: wScreenState, wScreenCounter, wScreenStep, wMapType, wMapWidthScreens, wMapHeightScreens, hPlayerFacing, hPlayerX, ...
; points at: wModeChangeRequest
RunMenuStateMenuState_Case05::
Jump_002_6E25:: ; address name
    call InitSoundHardware
    farcall RestartMapMusic
    xor a, a
    ld [wScreenState], a
    ld [wScreenCounter], a
    ld [wScreenStep], a
    ld a, [wMapToggleFlag]
    bit 7, a
    jr nz, Jump_002_6EBA
    ld a, [wWarpDestFacing]
    cp a, $F0
    jr nz, Jump_002_6E59
    push af
    ld a, $80
    ld [wMapType], a
    ld a, [wKeyWorldWidth]
    ld [wMapWidthScreens], a
    ld a, [wKeyWorldHeight]
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
    ld a, [wWarpDestX]
    ldh [hPlayerX], a
    ld a, [wWarpDestY]
    ldh [hPlayerY], a
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $A], a
    ldh a, [hPlayerX]
    ld [wFollowerRecords + $1], a
    ld [wFollowerRecords + $6], a
    ld [wFollowerRecords + $B], a
    ldh a, [hPlayerY]
    ld [wFollowerRecords + $2], a
    ld [wFollowerRecords + $7], a
    ld [wFollowerRecords + $C], a
    ld a, [wMapType]
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
    farcall RunMenuStateMenuState_Case05_Sub02
    ret

Jump_002_6EBA::
    ld a, [wMapType]
    bit 7, a
    jr z, Jump_002_6EC7
    farcall SaveKeyWorldFlagsRecordToSRAMSlotKeyWorldSlot

Jump_002_6EC7::
    ld a, [wCurrentKeyIndex]
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
    ld hl, KeyListMapDestinationTable
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
    ld [wGameMode2Byte50], a
    xor a, a
    ld [wMapType], a
    ld a, $80
    ld [wKeyWorldRefresh], a
    xor a, a
    ld [wScreenTriggerCount], a
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
    ld [wTalkEventGroup], a
    xor a, a
    ld [wTalkEventIndex], a
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
    ld [wPartyStrength], a
    farcall RunMenuStateMenuState_Case05_Sub01
    farcall SaveKeyWorldFlagsRecordToSRAMSlotKeyWorldSlot
    jr Jump_002_6F7E

Jump_002_6F73::
    and a, $3F
    ld [wKeyWorldSlot], a
    farcall LoadKeyWorldFlagsRecordFromSRAMSlotKeyWorldSlot

Jump_002_6F7E::
    ld a, $80
    ld [wKeyWorldRefresh], a
    ld a, $01
    ld [wGameMode], a
    ld a, $05
    ld [wModeState], a
    ld hl, wModeChangeRequest
    inc [hl]
    ld a, [wKeyWorldWidth]
    ld [wMapWidthScreens], a
    ld a, [wKeyWorldHeight]
    ld [wMapHeightScreens], a
    ld a, [wKeyWorldGoalScreen]
    swap a
    and a, $0F
    ldh [hMapScreenX], a
    ld a, [wKeyWorldGoalScreen]
    and a, $0F
    ldh [hMapScreenY], a
    ld a, [wKeyWorldGoalPos]
    ldh [hPlayerX], a
    ld a, [wKeyWorldGoalPos2]
    ldh [hPlayerY], a
    xor a, a
    ld [wGameMode2Byte50], a
    ld a, $80
    ld [wMapType], a
    farcall MarkVisitedMapScreenInVisitedScreens
    ld a, $87
    ld [wMapType], a
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
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $A], a
    ldh a, [hPlayerX]
    ld [wFollowerRecords + $1], a
    ld [wFollowerRecords + $6], a
    ld [wFollowerRecords + $B], a
    ldh a, [hPlayerY]
    ld [wFollowerRecords + $2], a
    ld [wFollowerRecords + $7], a
    ld [wFollowerRecords + $C], a
    xor a, a
    ldh [hPlayerSpriteOverride], a
    ret

; E-0237 (C1: the code after Jump_002_6EC7 takes the key list byte & $3F as the index, sets game mode 1 and loads hMapId, hMapScreenX, hMapScreenY, hPlayerX and hPlayerY from the 8-byte record at $7006 + 8 * index; 13 records).
; record: map number, screen X, screen Y, player X, player Y; three bytes not read
KeyListMapDestinationTable::
Data_002_7006:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00 ; id 0
    db $05, $01, $00, $50, $30, $00, $00, $00 ; id 1
    db $29, $00, $00, $40, $40, $00, $00, $00 ; id 2
    db $45, $00, $00, $40, $40, $00, $00, $00 ; id 3
    db $68, $00, $00, $40, $40, $00, $00, $00 ; id 4
    db $9D, $00, $00, $40, $40, $00, $00, $00 ; id 5
    db $A4, $00, $00, $40, $40, $00, $00, $00 ; id 6
    db $AF, $00, $00, $40, $40, $00, $00, $00 ; id 7
    db $B2, $00, $00, $40, $40, $00, $00, $00 ; id 8
    db $C5, $00, $00, $40, $40, $00, $00, $00 ; id 9
    db $D0, $00, $00, $40, $40, $00, $00, $00 ; id 10
    db $D9, $00, $00, $40, $40, $00, $00, $00 ; id 11
    db $E2, $00, $00, $40, $40, $00, $00, $00 ; id 12

; with SRAM bank 1 selected: hFFC6 = 1 when sBB00 is not the signature $55 (no save); otherwise 2 when VerifySaveBank1Checksum or VerifySaveBank3Checksum returns non-zero (damaged save), else 0 (valid); then disables SRAM (E-0109)
; 4 call sites from 4 routines (e.g. DebugBattleSetup_Update_Sub01, GameMode5_Init_Case01, ShowSaveFileInfoWindow, LoadSaveFileSummary)
; reads: sSaveSignature
; writes: rRAMG, rRAMB, hTemp0
CheckSaveData::
Func_002_706E:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, $01
    ld [rRAMB], a
    ld a, [sSaveSignature]
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
    ldh [hTemp0], a
    xor a, a
    ld [rRAMG], a
    ld [rRAMB], a
    ret

; sums the SRAM bank-1 bytes from sA06F into the word DE (the loop adds several bytes per pass; the comparison at the end is not read) and returns A non-zero on a mismatch, as CheckSaveData uses it (E-0109)
; 1 call site from 1 routine (e.g. CheckSaveData)
; writes: rRAMB
; points at: sBank1Records, sBank1Checksum
VerifySaveBank1Checksum::
Func_002_70A2:: ; address name
    ld a, $01
    ld [rRAMB], a
    ld hl, sBank1Records
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
    ld hl, sBank1Checksum
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
; points at: sRecords
VerifySaveBank3Checksum::
Func_002_7111:: ; address name
    ld a, $03
    ld [rRAMB], a
    ld hl, sRecords
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
; reads: wSaveStep
; writes: rRAMG, wSaveStep, rRAMB
RunSaveSteps::
Func_002_717D:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, [wSaveStep]
    or a, a
    jr nz, Jump_002_719A
    inc a
    ld [wSaveStep], a
    call CopySaveBlocksToSRAM
    call RunSaveSteps_Sub01
    call RestoreRecordsFromSRAMBank1Backup
    call RunSaveSteps_Sub02
    jr Jump_002_71AA

Jump_002_719A::
    dec a
    jr nz, Jump_002_71A2
    call ScanBank1RecordStepSaveRecordIndex
    jr Jump_002_71AA

Jump_002_71A2::
    ld a, [wSaveStep]
    or a, $80
    ld [wSaveStep], a

Jump_002_71AA::
    xor a, a
    ld [rRAMG], a
    ld [rRAMB], a
    ret

; runs Func_01D_7492 for SRAM bank 1 record wC8C4 ($A06F + $6F * index); when wD7F5 is $FF advances wC8C4 and, after record 30, increments wC8C3 (E-0121)
; 2 call sites from 2 routines (e.g. RunSaveSteps, RunBank1RecordScanSteps)
; reads: wSaveRecordIndex, wArg5
; writes: wArg1, wArg3, wArg4, wArg2, wSaveRecordIndex
; points at: wSaveStep
ScanBank1RecordStepSaveRecordIndex::
Func_002_71B2:: ; address name
    ld a, [wSaveRecordIndex]
    ld [wArg1], a
    ld c, $6F
    call Multiply8
    ld a, l
    add a, $6F
    ld l, a
    ld a, h
    adc a, $A0
    ld h, a
    ld a, l
    ld [wArg3], a
    ld a, h
    ld [wArg4], a
    ld a, $01
    ld [wArg2], a
    farcall UnpackRecordFromBank1Slot
    ld a, [wArg5]
    cp a, $FF
    ret nz
    ld a, [wSaveRecordIndex]
    inc a
    ld [wSaveRecordIndex], a
    cp a, $1E
    ret nz
    ld hl, wSaveStep
    inc [hl]
    ret

; copies the record backup at sAD71 (SRAM bank 1) back to sB356 in bank 0 and to sA000 in bank 1; counterpart of BackupRecordsToSRAMBank1 (E-0128)
; 2 call sites from 2 routines (e.g. RunSaveSteps, RunBank1RecordScanSteps)
; writes: rRAMB
; points at: sRecordBackup, sCompactRecords, sRecords
RestoreRecordsFromSRAMBank1Backup::
Func_002_71ED:: ; address name
    ld hl, sRecordBackup
    ld de, sCompactRecords
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
    ld de, sRecords
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
; points at: sRecords
RunSaveSteps_Sub01::
Func_002_7247:: ; address name
    ld hl, sRecords
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
; reads: hTemp0, hTemp1
; writes: rRAMB, hTemp0, hTemp1, wSaveStateFlag
; points at: sSaveData
CopySaveBlocksToSRAM::
Func_002_72B0:: ; address name
    ld a, $01
    ld [rRAMB], a
    ld hl, Data_002_75F7
    ld de, sSaveData

Jump_002_72BB::
    push hl
    ld a, [hl+]
    ldh [hTemp0], a
    ld a, [hl+]
    ldh [hTemp1], a
    ld a, [hl+]
    ld c, a
    ld a, [hl]
    ld b, a
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    ld a, l
    or a, h
    jr nz, Jump_002_72D7
    pop hl
    ld a, $80
    ld [wSaveStateFlag], a
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
; reads: sSavedGM2Mode
; writes: rSVBK, rRAMB
; points at: sSavedCE9BBlock, wGM2TimerFrames
RunSaveSteps_Sub02::
Func_002_72E9:: ; address name
    xor a, a
    ldh [rSVBK], a
    ld a, $01
    ld [rRAMB], a
    ld hl, sSavedCE9BBlock
    ld a, [sSavedGM2Mode]
    cp a, $01
    jr z, Jump_002_72FF
    and a, a
    jr z, Jump_002_72FF
    ret

Jump_002_72FF::
    ld bc, $00D8
    ld de, wGM2TimerFrames

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
; reads: wGM2Mode
; writes: rRAMB, rSVBK
; points at: wGM2TimerFrames, sSavedCE9BBlock
SaveGM2TimerFramesBlockToSRAMBank1::
Func_002_730E:: ; address name
    ld hl, wGM2TimerFrames
    ld bc, $00D8
    ld de, sSavedCE9BBlock
    ld a, $01
    ld [rRAMB], a
    xor a, a
    ldh [rSVBK], a
    ld a, [wGM2Mode]
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
; 9 call sites from 9 routines (e.g. GameMode5_Update_Case02, RunLinkScreenState_6C12_Case08_Case04_Sub01, RunScreenStateWhenNotFading_1B_Case01_Case22, GameMode6_Init, ...)
; reads: wSaveStep
; writes: rRAMG, wSaveStep, rRAMB
RunSaveGameSteps::
Func_002_7333:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, [wSaveStep]
    or a, a
    jr nz, Jump_002_7364
    inc a
    ld [wSaveStep], a
    call CopySaveBlocksToSRAMWithSum
    jr Jump_002_7359

; with SRAM enabled runs one save stage per call (sprites snapshot and blocks, then records, then the final stage marked by bit 7 of wC8C3) (E-0124)
; 3 call sites from 3 routines (e.g. RunPauseMenuScreen_Case02, KeyAppraisalMenu_Case03_Case0E, BreedMenu_Case04_Case36)
; reads: wSaveStep
; writes: rRAMG, wSaveStep, rRAMB
RunSaveGameSteps_7347::
Func_002_7347:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, [wSaveStep]
    or a, a
    jr nz, Jump_002_7364
    inc a
    ld [wSaveStep], a
    call SnapshotSpritesForSave

Jump_002_7359::
    call RunSaveGameSteps_7347_Sub01
    call BackupRecordsToSRAMBank1
    call SaveGM2TimerFramesBlockToSRAMBank1
    jr Jump_002_7377

Jump_002_7364::
    dec a
    jr nz, Jump_002_736C
    call SaveStepCopyBank1RecordSaveRecordIndex
    jr Jump_002_7377

Jump_002_736C::
    call ComputeSRAMBank1RecordChecksum
    ld a, [wSaveStep]
    or a, $80
    ld [wSaveStep], a

Jump_002_7377::
    xor a, a
    ld [rRAMG], a
    ld [rRAMB], a
    ret

; sums $29A * 10 bytes from sA06F in SRAM bank 1 and stores the complement plus $4321 at sBA73 (E-0129)
; 2 call sites from 2 routines (e.g. RunSaveGameSteps_7347, RunBattlePhaseWhenTextIdle_A0_Case03_Case01_Sub01)
; writes: rRAMB
; points at: sBank1Records, sBank1Checksum
ComputeSRAMBank1RecordChecksum::
Func_002_737F:: ; address name
    ld a, $01
    ld [rRAMB], a
    ld hl, sBank1Records
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
    ld hl, sBank1Checksum
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl], a
    ret

; copies SRAM bank-1 record wC8C4 ($6F bytes at sA06F + $6F * n) through Func_01D_6E39, then wC8C4 += 1; after 30 records wC8C3 += 1 (the next save step) (E-0120)
; 2 call sites from 2 routines (e.g. RunSaveGameSteps_7347, RunBattlePhaseWhenTextIdle_A0_Case03_Case01_Sub01)
; reads: wSaveRecordIndex
; writes: wArg1, wArg3, wArg4, wArg2, wSaveRecordIndex
; points at: wSaveStep
SaveStepCopyBank1RecordSaveRecordIndex::
Func_002_73E6:: ; address name
    ld a, [wSaveRecordIndex]
    ld [wArg1], a
    ld c, $6F
    call Multiply8
    ld a, l
    add a, $6F
    ld l, a
    ld a, h
    adc a, $A0
    ld h, a
    ld a, l
    ld [wArg3], a
    ld a, h
    ld [wArg4], a
    ld a, $01
    ld [wArg2], a
    farcall PackRecordFieldsToBank1Slot
    ld a, [wSaveRecordIndex]
    inc a
    ld [wSaveRecordIndex], a
    cp a, $1E
    ret nz
    ld hl, wSaveStep
    inc [hl]
    ret

; copies the SRAM bank-0 records from sB356 (and the bank-1 record at sA000) to the backup area at sAD71 in SRAM bank 1 (E-0127)
; 2 call sites from 2 routines (e.g. RunSaveGameSteps_7347, RunBattlePhaseWhenTextIdle_A0_Case03_Case01_Sub01)
; writes: rRAMB
; points at: sCompactRecords, sRecordBackup, sRecords
BackupRecordsToSRAMBank1::
Func_002_741B:: ; address name
    ld hl, sCompactRecords
    ld de, sRecordBackup
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
    ld hl, sRecords
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
; points at: sRecords
ClearSRAMBanks2And3::
Func_002_7470:: ; address name
    ld a, $02
    ld [rRAMB], a
    ld hl, sRecords
    ld bc, $2000
    ld a, $FF
    call FillBytes
    ld a, $03
    ld [rRAMB], a
    ld hl, sRecords
    ld bc, $2000
    ld a, $FF
    call FillBytes
    ret

; only called from RunSaveGameSteps_7347 (E-0047)
; 1 call site from 1 routine (e.g. RunSaveGameSteps_7347)
; reads: wSaveByte4E, wMapType
; writes: rRAMG, rRAMB
; points at: sRecords
RunSaveGameSteps_7347_Sub01::
Func_002_7491:: ; address name
    ld a, [wSaveByte4E]
    or a, a
    jr z, Jump_002_749A
    call ClearSRAMBanks2And3

Jump_002_749A::
    ld a, [wMapType]
    bit 7, a
    jr z, Jump_002_74AC
    farcall SaveKeyWorldFlagsRecordToSRAMSlotKeyWorldSlot
    ld a, $0A
    ld [rRAMG], a

Jump_002_74AC::
    ld hl, sRecords
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
; reads: wScreenSavedFlag, wSnapshotSlot1, wSnapshotSlot2, wSnapshotSlot3, wSnapshotSlot4, wSnapshotSlot5, hTemp0, hTemp1, ...
; writes: wSpriteSnapshotCount, wSnapshotSlot1, wSnapshotSlot2, wSnapshotSlot3, wSnapshotSlot4, wSnapshotSlot5, rRAMB, hTemp2, ...
; points at: wSpriteSlots, wSpriteSnapshot, sSaveData
SnapshotSpritesForSave::
Func_002_755E:: ; address name
    ld a, [wScreenSavedFlag]
    ld [wSpriteSnapshotCount], a
    ld hl, wSpriteSlots
    ld de, wSpriteSnapshot
    ld bc, $0050
    call CopyBytes
    ld a, [wSnapshotSlot1]
    and a, $FD
    ld [wSnapshotSlot1], a
    ld a, [wSnapshotSlot2]
    and a, $FD
    ld [wSnapshotSlot2], a
    ld a, [wSnapshotSlot3]
    and a, $FD
    ld [wSnapshotSlot3], a
    ld a, [wSnapshotSlot4]
    and a, $FD
    ld [wSnapshotSlot4], a
    ld a, [wSnapshotSlot5]
    and a, $FD
    ld [wSnapshotSlot5], a

; the same walk of Data_002_75F7 into SRAM from sBB01, also clearing the running sum in hFFC8/hFFC9 (accumulation not read to its end) (E-0109)
; 1 call site from 1 routine (e.g. RunSaveGameSteps)
; reads: hTemp0, hTemp1, hTemp2, hTemp3
; writes: rRAMB, hTemp2, hTemp3, hTemp0, hTemp1, sSaveSignature, sSaveChecksumLo, sSaveChecksumHi
; points at: sSaveData
CopySaveBlocksToSRAMWithSum::
Func_002_7598:: ; address name
    ld a, $01
    ld [rRAMB], a
    ld hl, Data_002_75F7
    ld de, sSaveData
    xor a, a
    ldh [hTemp2], a
    ldh [hTemp3], a

Jump_002_75A8::
    push hl
    ld a, [hl+]
    ldh [hTemp0], a
    ld a, [hl+]
    ldh [hTemp1], a
    ld a, [hl+]
    ld c, a
    ld a, [hl]
    ld b, a
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    ld a, l
    or a, h
    jr nz, Jump_002_75DA
    pop hl
    ld a, $55
    ld [sSaveSignature], a
    ldh a, [hTemp2]
    ld l, a
    ldh a, [hTemp3]
    ld h, a
    ld a, l
    add a, $53
    ld l, a
    ld a, h
    adc a, $97
    ld h, a
    ld a, l
    ld [sSaveChecksumLo], a
    ld a, h
    ld [sSaveChecksumHi], a
    ret

Jump_002_75DA::
    ldh a, [hTemp2]
    add a, [hl]
    ldh [hTemp2], a
    ldh a, [hTemp3]
    adc a, $00
    ldh [hTemp3], a
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

; address loaded by CopySaveBlocksToSRAM, CopySaveBlocksToSRAMWithSum
Data_002_75F7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $8A, $FF, $0E, $00, $0C, $C6, $91, $02, $D7, $CB, $6B, $00, $42, $CC, $B5, $00
    db $00, $00, $00, $00

; SRAM bank 1: C = $FF when sBB00 is not $55 or the checksum of the four saved blocks plus $9753 differs from sBF98; otherwise loads them and returns with C unchanged (E-0127)
; 1 call site from 1 routine (e.g. RunLinkExchangeState_450D_Case01_Sub01_Table2_Case05_Case0C)
; reads: sSaveSignature, hTemp2, hTemp3, sSaveChecksumLo, sSaveChecksumHi
; writes: rRAMG, rRAMB, hTemp2, hTemp3
; points at: sSaveData, hPlayerSpriteVariant, wPlayerName, wStoryFlags, wKeyWorldSlot
VerifySaveChecksum::
Func_002_760B:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, $01
    ld [rRAMB], a
    xor a, a
    ldh [hTemp2], a
    ldh [hTemp3], a
    ld a, [sSaveSignature]
    cp a, $55
    jr nz, Jump_002_766D
    ld hl, sSaveData
    ld de, hPlayerSpriteVariant
    ld bc, $000E
    call CopyBytesWithChecksum_Bank02_7674
    ld de, wPlayerName
    ld bc, $0291
    call CopyBytesWithChecksum_Bank02_7674
    ld de, wStoryFlags
    ld bc, $006B
    call CopyBytesWithChecksum_Bank02_7674
    ld de, wKeyWorldSlot
    ld bc, $00B5
    call CopyBytesWithChecksum_Bank02_7674
    ldh a, [hTemp2]
    ld l, a
    ldh a, [hTemp3]
    ld h, a
    ld a, l
    add a, $53
    ld l, a
    ld a, h
    adc a, $97
    ld h, a
    ld a, [sSaveChecksumLo]
    ld c, a
    ld a, [sSaveChecksumHi]
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
; 4 call sites from 1 routine (e.g. VerifySaveChecksum)
; reads: hTemp2, hTemp3
; writes: hTemp2, hTemp3
CopyBytesWithChecksum_Bank02_7674::
Func_002_7674:: ; address name
    ldh a, [hTemp2]
    add a, [hl]
    ldh [hTemp2], a
    ldh a, [hTemp3]
    adc a, $00
    ldh [hTemp3], a
    ld a, [hl+]
    ld [de], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, CopyBytesWithChecksum_Bank02_7674
    ret

; SRAM bank 1: copies hFF8A ($0E bytes), wC60C ($291), wCBD7 ($6B) and wCC42 ($B5) to sBB01 onward while summing them; stores sum + $9753 at sBF98 and $55 at sBB00 (E-0121)
; 2 call sites from 2 routines (e.g. RunLinkExchangeState_450D_Case01_Sub01_Table2_Case05_Case0C, RunBattlePhaseWhenTextIdle_A0_Case03_Case01)
; reads: hTemp2, hTemp3
; writes: rRAMG, rRAMB, hTemp2, hTemp3, sSaveChecksumLo, sSaveChecksumHi, sSaveSignature
; points at: sSaveData, hPlayerSpriteVariant, wPlayerName, wStoryFlags, wKeyWorldSlot
SaveGameToSRAMWithChecksum::
Func_002_7688:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, $01
    ld [rRAMB], a
    xor a, a
    ldh [hTemp2], a
    ldh [hTemp3], a
    ld de, sSaveData
    ld hl, hPlayerSpriteVariant
    ld bc, $000E
    call CopyBytesWithChecksum_Bank02
    ld hl, wPlayerName
    ld bc, $0291
    call CopyBytesWithChecksum_Bank02
    ld hl, wStoryFlags
    ld bc, $006B
    call CopyBytesWithChecksum_Bank02
    ld hl, wKeyWorldSlot
    ld bc, $00B5
    call CopyBytesWithChecksum_Bank02
    ldh a, [hTemp2]
    ld l, a
    ldh a, [hTemp3]
    ld h, a
    ld a, l
    add a, $53
    ld l, a
    ld a, h
    adc a, $97
    ld h, a
    ld a, l
    ld [sSaveChecksumLo], a
    ld a, h
    ld [sSaveChecksumHi], a
    ld a, $55
    ld [sSaveSignature], a
    xor a, a
    ld [rRAMG], a
    ret

; HL = source, DE = destination, BC = count: copies BC bytes and adds each one to the 16-bit sum in hFFC8/hFFC9; clobbers A, BC = 0 (E-0065) (the same 20 bytes appear in 2 banks)
; 4 call sites from 1 routine (e.g. SaveGameToSRAMWithChecksum)
; reads: hTemp2, hTemp3
; writes: hTemp2, hTemp3
CopyBytesWithChecksum_Bank02::
Func_002_76DE:: ; address name
    ldh a, [hTemp2]
    add a, [hl]
    ldh [hTemp2], a
    ldh a, [hTemp3]
    adc a, $00
    ldh [hTemp3], a
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
; reads: wSaveStep
; writes: rRAMG, wSaveStep
RunBank1RecordScanSteps:: ; heuristic: follows a terminator; C0
Func_002_76F2:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, [wSaveStep]
    or a, a
    jr nz, Jump_002_7704
    inc a
    ld [wSaveStep], a
    call RestoreRecordsFromSRAMBank1Backup

Jump_002_7704::
    call ScanBank1RecordStepSaveRecordIndex
    ld a, [wSaveStep]
    cp a, $02
    jr nz, Jump_002_7713
    ld a, $80
    ld [wSaveStep], a

Jump_002_7713::
    xor a, a
    ld [rRAMG], a
    ret

; only called from RunBattlePhaseWhenTextIdle_A0_Case03_Case01 (E-0047)
; 1 call site from 1 routine (e.g. RunBattlePhaseWhenTextIdle_A0_Case03_Case01)
; reads: wSaveStep
; writes: rRAMG, wSaveStep
RunBattlePhaseWhenTextIdle_A0_Case03_Case01_Sub01::
Func_002_7718:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, [wSaveStep]
    or a, a
    jr nz, Jump_002_772A
    inc a
    ld [wSaveStep], a
    call BackupRecordsToSRAMBank1

Jump_002_772A::
    call SaveStepCopyBank1RecordSaveRecordIndex
    ld a, [wSaveStep]
    cp a, $02
    jr nz, Jump_002_7741
    ld a, $0A
    ld [rRAMG], a
    call ComputeSRAMBank1RecordChecksum
    ld a, $80
    ld [wSaveStep], a

Jump_002_7741::
    xor a, a
    ld [rRAMG], a
    ret
    ds $8B9, $00

; address loaded by StartPaletteFade_Sub01
Data_002_7FFF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00
