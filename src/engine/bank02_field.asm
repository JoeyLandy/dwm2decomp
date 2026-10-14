; ROM bank $02: field mode: map play, field states, field menus
; The annotated listing of this bank is build/listing/bank02.asm.

SECTION "Bank 02", ROMX[$4000], BANK[$02]
    db $02

; called from StartPaletteFade: branches on b; sets wFadeLevel to 0; copies wFadeState to
; wFadeDelay; copies wFadeState to wFadeDelayCounter; sets wFadeLevel to $20; branches on wFadeMode;
; sets wFadeDelay; sets wFadeDelayCounter; sets rBGPI to $80; copies E to rBGPD; copies D to rBGPD;
; sets rOBPI to $80; then 2 more steps (see the code) (E-0347)
; why: a helper of StartPaletteFade; StartPaletteFade: A = level (bit 7 set selects the second form)
; (E-0352)
StartPaletteFade_WriteFadeLevelAndFadeDelayEtc::
    ld a, [wFadeState]
    ld b, a
    bit 7, b
    jr nz, .set_fade_level_to_20
    ld a, $00
    ld [wFadeLevel], a
    ld a, [wFadeState]
    srl a
    srl a
    ld [wFadeDelay], a
    ld [wFadeDelayCounter], a
    ret

.set_fade_level_to_20:
    ld a, $20
    ld [wFadeLevel], a
    ld a, [wFadeMode]
    bit 7, a
    jr nz, .read_fade_state
    ld de, StartPaletteFade_WriteFadeLevelAndFadeDelayEtc_Data
    jr .read_fade_state2

.read_fade_state:
    ld de, $0000

.read_fade_state2:
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

.loop:
    di
    call WaitForVRAMAccess
    ld a, e
    ldh [rBGPD], a
    ld a, d
    ldh [rBGPD], a
    ei
    dec b
    jr nz, .loop
    di
    call WaitForVRAMAccess
    ld a, $80
    ldh [rOBPI], a
    ei
    ld b, $20

.loop2:
    di
    call WaitForVRAMAccess
    ld a, e
    ldh [rOBPD], a
    ld a, d
    ldh [rOBPD], a
    ei
    dec b
    jr nz, .loop2
    ret

; one CGB fade step: counts wFadeDelayCounter down and, when it reaches 0, reloads it from
; wFadeDelay and moves wFadeLevel by 5. With wFadeState bit 7 clear (fading out) the level rises to
; at most $1F and WriteAllFadedPalettesFloor writes the palettes; with bit 7 set (fading in) it
; falls to at least 0 and WriteAllFadedPalettesAdd writes them. wFadeState = 0 when the level
; reaches $1F or 0 (E-0077)
StepCGBFade::
    ld a, [wFadeState]
    bit 7, a
    jr nz, .check_fade_delay_counter
    ld a, [wFadeDelayCounter]
    or a
    jr z, .read_fade_level
    dec a
    ld [wFadeDelayCounter], a
    ret

.read_fade_level:
    ld a, [wFadeLevel]
    add $05
    cp $1f
    jr c, .set_fade_level
    ld a, $1f

.set_fade_level:
    ld [wFadeLevel], a
    call WriteAllFadedPalettesFloor
    ld a, [wFadeDelay]
    ld [wFadeDelayCounter], a
    ld a, [wFadeLevel]
    cp $1f
    jr z, .clear_fade_state
    ret

.check_fade_delay_counter:
    ld a, [wFadeDelayCounter]
    or a
    jr z, .read_fade_level2
    dec a
    ld [wFadeDelayCounter], a
    ret

.read_fade_level2:
    ld a, [wFadeLevel]
    sub $05
    bit 7, a
    jr z, .set_fade_level2
    xor a

.set_fade_level2:
    ld [wFadeLevel], a
    call WriteAllFadedPalettesAdd
    ld a, [wFadeDelay]
    ld [wFadeDelayCounter], a
    ld a, [wFadeLevel]
    or a
    jr z, .clear_fade_state
    ret

.clear_fade_state:
    xor a
    ld [wFadeState], a
    ret

; rBGPI = $80 (palette 0, auto-increment), the 8 BG palettes from wBGPaletteBuffer through
; WriteFadedPaletteFloorToBGPD; then rOBPI = $80 and the 8 OBJ palettes from wOBJPaletteBuffer
; through WriteFadedPaletteFloorToOBPD (E-0076)
WriteAllFadedPalettesFloor::
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
WriteFadedPaletteFloorToOBPD::
    call WriteFadedColorFloorToOBPD
    call WriteFadedColorFloorToOBPD
    call WriteFadedColorFloorToOBPD

; reads one RGB555 colour word at HL (HL += 2), passes its three components through
; FadeColorComponentFloor and writes the result to rOBPD (low byte first, after WaitForVRAMAccess);
; its load of wFadeLevel into D is overwritten at once (E-0076)
WriteFadedColorFloorToOBPD::
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
WriteFadedPaletteFloorToBGPD::
    call WriteFadedColorFloorToBGPD
    call WriteFadedColorFloorToBGPD
    call WriteFadedColorFloorToBGPD

; reads one RGB555 colour word at HL (HL += 2), passes its three components through
; FadeColorComponentFloor and writes the result to rBGPD (low byte first, after WaitForVRAMAccess)
; (E-0076)
WriteFadedColorFloorToBGPD::
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

; the 5-bit component in C's low bits becomes max(component, wFadeLevel) when wFadeMode bit 7 is
; clear (lighten toward the level) or max(component - wFadeLevel, 0) when it is set (darken); then
; B:C:D:E is rotated right 5 bits so the next component comes down and the result collects in D:E
; (E-0076)
FadeColorComponentFloor::
    push de
    ld a, [wFadeMode]
    bit 7, a
    jr nz, .read_fade_level
    ld a, c
    and $1f
    ld d, a
    ld a, [wFadeLevel]
    cp d
    jr nc, .skip
    ld a, d
    jr .skip

.read_fade_level:
    ld a, [wFadeLevel]
    ld d, a
    ld a, c
    and $1f
    sub d
    jr nc, .skip
    xor a

.skip:
    ld e, a
    ld a, c
    and $e0
    or e
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

; rBGPI = $80, the 8 BG palettes from wBGPaletteBuffer through WriteFadedPaletteAddToBGPD; then
; rOBPI = $80 and the 8 OBJ palettes from wOBJPaletteBuffer through WriteFadedPaletteAddToOBPD
; (E-0076)
WriteAllFadedPalettesAdd::
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
WriteFadedPaletteAddToOBPD::
    call WriteFadedColorAddToOBPD
    call WriteFadedColorAddToOBPD
    call WriteFadedColorAddToOBPD

; reads one RGB555 colour word at HL (HL += 2), passes its three components through
; FadeColorComponentAdd and writes the result to rOBPD (low byte first, after WaitForVRAMAccess);
; its load of wFadeLevel into D is overwritten at once (E-0076)
WriteFadedColorAddToOBPD::
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
WriteFadedPaletteAddToBGPD::
    call WriteFadedColorAddToBGPD
    call WriteFadedColorAddToBGPD
    call WriteFadedColorAddToBGPD

; reads one RGB555 colour word at HL (HL += 2), passes its three components through
; FadeColorComponentAdd and writes the result to rBGPD (low byte first, after WaitForVRAMAccess)
; (E-0076)
WriteFadedColorAddToBGPD::
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

; the 5-bit component in C's low bits becomes min(component + wFadeLevel, $1F) when wFadeMode bit 7
; is clear (lighten) or max(component - wFadeLevel, 0) when it is set (darken); then B:C:D:E is
; rotated right 5 bits so the next component comes down and the result collects in D:E (E-0076)
FadeColorComponentAdd::
    push de
    ld a, [wFadeMode]
    bit 7, a
    jr nz, .read_fade_level
    ld a, c
    and $1f
    ld d, a
    ld a, [wFadeLevel]
    add d
    cp $1f
    jr c, .skip
    ld a, $1f
    jr .skip

.read_fade_level:
    ld a, [wFadeLevel]
    ld d, a
    ld a, c
    and $1f
    sub d
    jr nc, .skip
    xor a

.skip:
    ld e, a
    ld a, c
    and $e0
    or e
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
CopyBGPalettesToBuffer::
    ld a, [wIsCGB]
    or a
    ret z
    ld a, b
    add a
    add a
    add a
    ld b, a
    ld a, c
    add a
    add a
    add a
    ld de, wBGPaletteBuffer
    add e
    ld e, a
    jr nc, .loop
    inc d

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ret

; on CGB: copies B palettes (8 bytes each) from HL to wOBJPaletteBuffer + 8 * C (E-0124)
CopyOBJPalettesToBuffer::
    ld a, [wIsCGB]
    or a
    ret z
    ld a, b
    add a
    add a
    add a
    ld b, a
    ld a, c
    add a
    add a
    add a
    ld de, wOBJPaletteBuffer
    add e
    ld e, a
    jr nc, .loop
    inc d

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ret

; on CGB copies the 8-byte palette LoadPalette0FromData_2_Data into wBGPaletteBuffer and
; wOBJPaletteBuffer and sets the upload requests wBGPaletteUploadRequest and
; wOBJPaletteUploadRequest = $7F (E-0117) (E-0344: the address in its name dropped or read as the
; label there; was LoadPalette0FromData_2)
LoadPalette0FromData_2::
    ld a, [wIsCGB]
    or a
    ret z
    ld hl, wBGPaletteBuffer
    ld de, LoadPalette0FromData_2_Data
    ld bc, $0008
    call CopyBytesDEToHL_Bank00
    ld a, $7f
    ld [wBGPaletteUploadRequest], a
    ld hl, wOBJPaletteBuffer
    ld de, LoadPalette0FromData_2_Data
    ld bc, $0008
    call CopyBytesDEToHL_Bank00
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    ret

; data read by LoadPalette0FromData (8 bytes) (E-0347)
LoadPalette0FromData_2_Data::
    db $00, $7c, $ff, $7f, $e0, $01, $00, $00

; called from RunMenuStateMenuState_WriteSubMenuCursorAndSTATSplitEnableEtc: returns if wIsCGB is 0;
; calls RunScreenStateStepEveryOtherFrame; may continue in
; RunMenuStateMenuState_WriteTextCounter2AndTextCounter3Etc_Data_CheckDMGPaletteOBP0; copies
; wDMGPaletteBGP to wDMGPaletteBytes; continues in
; RunMenuStateMenuState_WriteTextCounter2AndTextCounter3Etc_Data_CheckDMGPaletteOBP0 (E-0347)
; why: a helper of RunMenuStateMenuState_WriteSubMenuCursorAndSTATSplitEnableEtc, in step 4 of
; RunMenuStateMenuState (when wMenuState = 4); RunMenuStateMenuState: runs the routine for
; wMenuState & $0F (jump table) (E-0352, E-0122)
RunMenuStateMenuState_RunScreenStateStepEveryOtherFrame::
    ld a, [wIsCGB]
    or a
    ret z
    call RunScreenStateStepEveryOtherFrame
    ld hl, wDMGPaletteBytes
    ld a, [wDMGPaletteBGP]
    cp [hl]
    jp z, RunMenuStateMenuState_WriteTextCounter2AndTextCounter3Etc_Data_CheckDMGPaletteOBP0
    ld a, [wDMGPaletteBGP]
    ld [wDMGPaletteBytes], a
    jp RunMenuStateMenuState_WriteTextCounter2AndTextCounter3Etc_Data_CheckDMGPaletteOBP0

; wScreenStep += 1; on odd values, unless wScreenState is $FF, runs the step for wScreenState (jump
; table) (E-0122)
RunScreenStateStepEveryOtherFrame::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    bit 0, a
    jr nz, .check_screen_state
    ret

.check_screen_state:
    ld a, [wScreenState]
    cp $ff
    ret z
    jumptable
    dw RunScreenStateStepEveryOtherFrame_WriteScreenState
    dw RunScreenStateStepEveryOtherFrame_WriteScreenState_3
    dw RunScreenStateStepEveryOtherFrame_WriteScreenState_4
    dw RunScreenStateStepEveryOtherFrame_WriteScreenCounterAndScreenSubStepEtc

; step 0 of RunScreenStateStepEveryOtherFrame: changes HL, DE and A (E-0347)
; why: step 0 of RunScreenStateStepEveryOtherFrame; RunScreenStateStepEveryOtherFrame: wScreenStep
; += 1 (E-0352, E-0122)
RunScreenStateStepEveryOtherFrame_WriteScreenState::
    ld hl, wWorkBuf
    ld a, [wScreenCounter]
    swap a
    ld d, a
    and $f0
    ld e, a
    ld a, d
    and $0f
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

; called from RunScreenStateStepEveryOtherFrame_WriteScreenCounterAndScreenSubStepEtc: branches on
; rSTAT; increments wScreenState (E-0347)
; why: a helper of RunScreenStateStepEveryOtherFrame_WriteScreenCounterAndScreenSubStepEtc, in step
; 3 of RunScreenStateStepEveryOtherFrame; RunScreenStateStepEveryOtherFrame: wScreenStep += 1
; (E-0352, E-0122)
RunScreenStateStepEveryOtherFrame_WriteScreenState_2::
    di

.loop:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop
    ld a, [hli]
    ld [de], a
    ld a, [hli]
    ld [de], a

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ld a, [hli]
    ld [de], a
    ld a, [hli]
    ld [de], a

.loop3:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop3
    ld a, [hli]
    ld [de], a
    ld a, [hli]
    ld [de], a

.loop4:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop4
    ld a, [hli]
    ld [de], a
    ld a, [hli]
    ld [de], a

.loop5:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop5
    ld a, [hli]
    ld [de], a
    ld a, [hli]
    ld [de], a

.loop6:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop6
    ld a, [hli]
    ld [de], a
    ld a, [hli]
    ld [de], a

.loop7:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop7
    ld a, [hli]
    ld [de], a
    ld a, [hli]
    ld [de], a

.loop8:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop8
    ld a, [hli]
    ld [de], a
    ld a, [hli]
    ld [de], a
    ei
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; step 1 of RunScreenStateStepEveryOtherFrame: changes HL, DE and A; continues in
; RunScreenStateStepEveryOtherFrame_WriteScreenState_2 (E-0347)
; why: step 1 of RunScreenStateStepEveryOtherFrame; RunScreenStateStepEveryOtherFrame: wScreenStep
; += 1 (E-0352, E-0122)
RunScreenStateStepEveryOtherFrame_WriteScreenState_3::
    ld hl, wWorkBuf + $10
    ld a, [wScreenCounter]
    swap a
    ld d, a
    and $f0
    ld e, a
    ld a, d
    and $0f
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
    jp RunScreenStateStepEveryOtherFrame_WriteScreenState_2

; step 2 of RunScreenStateStepEveryOtherFrame: changes HL, DE and A; continues in
; RunScreenStateStepEveryOtherFrame_WriteScreenState_2 (E-0347)
; why: step 2 of RunScreenStateStepEveryOtherFrame; RunScreenStateStepEveryOtherFrame: wScreenStep
; += 1 (E-0352, E-0122)
RunScreenStateStepEveryOtherFrame_WriteScreenState_4::
    ld hl, wWorkBuf + $20
    ld a, [wScreenCounter]
    swap a
    ld d, a
    and $f0
    ld e, a
    ld a, d
    and $0f
    ld d, a
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld de, rBGPI
    ld a, $a0
    ld [de], a
    inc de
    jp RunScreenStateStepEveryOtherFrame_WriteScreenState_2

; step 3 of RunScreenStateStepEveryOtherFrame: calls
; RunScreenStateStepEveryOtherFrame_WriteScreenState_2; increments wScreenCounter; branches on
; wScreenCounter; sets wScreenSubStep to 0; sets wScreenCounter to 0; sets wScreenState to $ff; sets
; wScreenSubStep to 0; sets wScreenState to 0 (E-0347)
; why: step 3 of RunScreenStateStepEveryOtherFrame; RunScreenStateStepEveryOtherFrame: wScreenStep
; += 1 (E-0352, E-0122)
RunScreenStateStepEveryOtherFrame_WriteScreenCounterAndScreenSubStepEtc::
    ld hl, wWorkBuf + $30
    ld a, [wScreenCounter]
    swap a
    ld d, a
    and $f0
    ld e, a
    ld a, d
    and $0f
    ld d, a
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld de, rBGPI
    ld a, $b0
    ld [de], a
    inc de
    call RunScreenStateStepEveryOtherFrame_WriteScreenState_2
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    cp $08
    jr c, .clear_screen_sub_step
    xor a
    ld [wScreenSubStep], a
    ld [wScreenCounter], a
    ld a, $ff
    ld [wScreenState], a
    ret

.clear_screen_sub_step:
    xor a
    ld [wScreenSubStep], a
    ld [wScreenState], a
    ret

; called from RunMenuStateMenuState_QueueSoundEffect: calls
; RunMenuStateMenuState_WriteTextCounter2AndTextCounter3Etc; increments wScreenCounter; branches on
; wScreenCounter; sets wScreenCounter to 0 (E-0347)
; why: a helper of RunMenuStateMenuState_QueueSoundEffect, in step 1 of RunMenuStateMenuState (when
; wMenuState = 1); RunMenuStateMenuState: runs the routine for wMenuState & $0F (jump table)
; (E-0352, E-0122)
RunMenuStateMenuState_WriteScreenCounter::
    ld hl, wBGPaletteBuffer
    ld de, wWorkBuf
    ld c, $04

.loop:
    push bc
    push hl
    push de
    call RunMenuStateMenuState_WriteTextCounter2AndTextCounter3Etc
    pop de
    pop hl
    pop bc
    ld a, $10
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, $10
    add_a_to_hl
    dec c
    jr nz, .loop
    ld c, $04
    ld hl, wBGPaletteBuffer
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    cp $08
    jr c, .loop
    xor a
    ld [wScreenCounter], a
    ret

; Copies B to wTextCounter2; copies B & $1f to wTextCounter3; copies C & $1f to wTextCounter4;
; increments wScreenSubStep; may continue in
; RunMenuStateMenuState_WriteTextCounter2AndTextCounter3Etc; sets wScreenSubStep to 0 (E-0347)
; why: part of RunMenuStateMenuState; RunMenuStateMenuState: runs the routine for wMenuState & $0F
; (jump table) (E-0352, E-0122)
RunMenuStateMenuState_WriteTextCounter2AndTextCounter3Etc::
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
    and $1f
    ld [wTextCounter3], a
    pop bc
    ld a, c
    and $1f
    ld [wTextCounter4], a
    push hl
    ld hl, RunMenuStateMenuState_WriteTextCounter2AndTextCounter3Etc_Data
    ld a, [wScreenCounter]
    add_a_to_hl
    ld b, [hl]
    ld hl, wTextCounter2
    ld c, $03

.loop:
    ld a, [hl]
    add b
    cp $20
    jr c, .skip
    ld a, $1f

.skip:
    ld [hli], a
    dec c
    jr nz, .loop
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
    or c
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
    cp $08
    jr c, RunMenuStateMenuState_WriteTextCounter2AndTextCounter3Etc
    xor a
    ld [wScreenSubStep], a
    ret

; data read by RunMenuStateMenuState (9 bytes) (E-0347)
RunMenuStateMenuState_WriteTextCounter2AndTextCounter3Etc_Data::
    db $04, $08, $0c, $10, $14, $18, $1c, $20, $24

; Changes HL and A; may continue in WriteCGBObjPaletteFromDMGShadesDMGPaletteOBP0_Return; continues
; in WriteCGBObjPaletteFromDMGShadesDMGPaletteOBP0_Return (E-0347)
; why: part of RunMenuStateMenuState_WriteTextCounter2AndTextCounter3Etc_Data, in part of
; RunMenuStateMenuState_WriteTextCounter2AndTextCounter3Etc, in part of RunMenuStateMenuState;
; RunMenuStateMenuState: runs the routine for wMenuState & $0F (jump table) (E-0352, E-0122)
RunMenuStateMenuState_WriteTextCounter2AndTextCounter3Etc_Data_CheckDMGPaletteOBP0::
    ld hl, wDMGPaletteBytes + $1
    ld a, [wDMGPaletteOBP0]
    cp [hl]
    jp z, WriteCGBObjPaletteFromDMGShadesDMGPaletteOBP0_Return
    ld a, [wDMGPaletteOBP0]
    ld [wDMGPaletteBytes + $1], a
    jp WriteCGBObjPaletteFromDMGShadesDMGPaletteOBP0_Return

; writes four colours of the palette at HL to rOBPD, each chosen by a 2-bit shade of wDMGPaletteOBP0
; through WriteCGBObjPaletteFromDMGShadesDMGPaletteOBP0_Data; HL += 8 (E-0129)
WriteCGBObjPaletteFromDMGShadesDMGPaletteOBP0::
    push hl
    ld a, [wDMGPaletteOBP0]
    and $03
    ld de, WriteCGBObjPaletteFromDMGShadesDMGPaletteOBP0_Data
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    add_a_to_hl
    di
    call WaitForVRAMAccess
    ld a, [hli]
    ldh [rOBPD], a
    ld a, [hl]
    ldh [rOBPD], a
    ei
    pop hl
    push hl
    ld a, [wDMGPaletteOBP0]
    srl a
    srl a
    and $03
    ld de, WriteCGBObjPaletteFromDMGShadesDMGPaletteOBP0_Data
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [de]
    add_a_to_hl
    di
    call WaitForVRAMAccess
    ld a, [hli]
    ldh [rOBPD], a
    ld a, [hl]
    ldh [rOBPD], a
    ei
    pop hl
    push hl
    ld a, [wDMGPaletteOBP0]
    swap a
    and $03
    ld de, WriteCGBObjPaletteFromDMGShadesDMGPaletteOBP0_Data
    add e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    ld a, [de]
    add_a_to_hl
    di
    call WaitForVRAMAccess
    ld a, [hli]
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
    and $03
    ld de, WriteCGBObjPaletteFromDMGShadesDMGPaletteOBP0_Data
    add e
    ld e, a
    jr nc, .skip4
    inc d

.skip4:
    ld a, [de]
    add_a_to_hl
    di
    call WaitForVRAMAccess
    ld a, [hli]
    ldh [rOBPD], a
    ld a, [hl]
    ldh [rOBPD], a
    ei
    pop hl
    ld a, l
    add $08
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ret

; Returns at once (E-0347)
; why: part of WriteCGBObjPaletteFromDMGShadesDMGPaletteOBP0;
; WriteCGBObjPaletteFromDMGShadesDMGPaletteOBP0: writes four colours of the palette at HL to rOBPD,
; each chosen by a 2-bit shade of wDMGPaletteOBP0 through ... (E-0352, E-0129)
WriteCGBObjPaletteFromDMGShadesDMGPaletteOBP0_Return::
    ret

; data read by WriteCGBObjPaletteFromDMGShadesDMGPaletteOBP0 (4 bytes) (E-0347)
WriteCGBObjPaletteFromDMGShadesDMGPaletteOBP0_Data::
    db $02, $04, $00, $06

; start-up for wGameMode = 1; forcing this mode on the emulator shows: water map with the player
; sprite (E-0029)
GameMode1_Init::
    call ClearSTATInterruptSources
    xor a
    ldh [rIF], a
    ldh a, [hMapId]
    cp $38
    jr nz, .check_save_state_flag
    ldh a, [hMapScreenX]
    ld c, a
    ldh a, [hMapScreenY]
    or c
    call z, InitSoundHardware

.check_save_state_flag:
    ld a, [wSaveStateFlag]
    or a
    call nz, InitSoundHardware
    call GameMode1_Init_ReadMapTypeAndMapIdEtc
    call LoadSGBBorderForSetA
    ld b, $46
    ld de, Tiles1Gfx
    ld hl, vTiles1
    call DecompressToVRAM
    ld hl, GameMode1_Init_Data1
    ld a, [hl]
    ld [wSGBPaletteSet], a
    ld hl, GameMode1_Init_Data2
    ld a, [hl]
    ld [wSGBAttrFile], a
    farcall SendSGBPaletteSetPacket
    call InitFieldScreen
    xor a
    ld [wFieldTransitionStep], a
    ld a, [wFieldInitStage]
    or a
    jr nz, .clear_field_init_stage
    call InitSoundHardware
    call RestartMapMusic

.clear_field_init_stage:
    xor a
    ld [wFieldInitStage], a
    ld a, $03
    ld [wLCDCShadow], a
    ld a, $03
    jp ClearSGBPacketBuffer_CheckLinkMode

; enters the field: loads the map header, resets scroll and timers, reorders the party, loads names
; and sprites, finds triggers, draws the map screen and places objects (E-0129)
InitFieldScreen::
    ld a, $0f
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
    xor a
    ld [wFrameCounterLo], a
    ld [wFrameCounterHi], a
    ld a, $00
    ld [wSTATSplitEnable], a
    di
    call WaitForVRAMAccess
    ld a, $40
    ldh [rSTAT], a
    xor a
    ldh [rIF], a
    ei
    call MoveIncapacitatedPartyMembersBack
    call MoveIncapacitatedPartyMembersBack
    farcall SetupTownObjectsForMap
    farcall RefreshKeyWorldObjectsOnEntry
    call WritePlayerNameWithFlag0SuffixToTextBuf0
    ld a, [wMapType]
    bit 7, a
    jr nz, .call_load_record_list_name_tiles
    ldh a, [hMapId]
    cp $14
    jr z, .call_load_player_and_follower_sprite_graphics

.call_load_record_list_name_tiles:
    call LoadRecordListNameTiles

.call_load_player_and_follower_sprite_graphics:
    farcall LoadPlayerAndFollowerSpriteGraphics
    farcall FindTriggerEntryForCurrentScreen
    farcall FindTriggerEntryForCurrentScreen_ScreenTriggers
    xor a
    ld [wFieldActionRequest], a
    ld a, [wFieldReturnPhase]
    or a
    jr nz, .call_restore_screen_buffer_from_bg_map1
    call LoadMapScreen
    farcall LoadMapObjectsForScreen
    farcall SetupMap0BMonsterObjects
    farcall ClearPendingFieldEventWhenFieldIdle
    jr .call_draw_full_screen_buffer_to_bg_map

.call_restore_screen_buffer_from_bg_map1:
    call RestoreScreenBufferFromBGMap1
    farcall SetupMap0BMonsterObjects

.call_draw_full_screen_buffer_to_bg_map:
    ld hl, vBGMap0
    call DrawFullScreenBufferToBGMap
    xor a
    ld [wObject5], a
    farcall PlaceSpecialMapObjectsOnEntry
    xor a
    ld [wTextWindowState], a
    ld [wTextWindowStep], a
    ld [wPartyWindowFlags], a
    ld [wPartyWindowTimer], a
    ld a, [wFieldInitFlag]
    bit 7, a
    jr z, .check_field_init_stage
    and $7f
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    xor a
    ld [wFieldInitFlag], a

.check_field_init_stage:
    ld a, [wFieldInitStage]
    or a
    jr nz, .call_send_sgb_field_palette_set
    call RestartMapMusic

.call_send_sgb_field_palette_set:
    call SendSGBFieldPaletteSet
    call RunFieldReturnPhase
    xor a
    ldh [hFieldDrawFlags], a
    ld a, [wIsCGB]
    or a
    ret z
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    ret

; copies the player name to wTextBuf0 with a terminator, then a two-tile suffix ($58 $87 when story
; flag 0 is set, else $87 $60) (E-0124)
WritePlayerNameWithFlag0SuffixToTextBuf0::
    ld hl, wPlayerName
    ld de, wTextBuf0
    ld bc, $000a
    call CopyBytes
    ld a, $f0
    ld [wTextBuf0 + $a], a
    ld de, EVENT_NEVER_SET
    call TestFlagBit
    jp nc, .set_text_buf0_to_87
    ld a, $58
    ld [wTextBuf0 + $c], a
    ld a, $87
    ld [wTextBuf0 + $d], a
    ld a, $f0
    ld [wTextBuf0 + $e], a
    ret

.set_text_buf0_to_87:
    ld a, $87
    ld [wTextBuf0 + $c], a
    ld a, $60
    ld [wTextBuf0 + $d], a
    ld a, $f0
    ld [wTextBuf0 + $e], a
    ret

; runs the routine for wFieldReturnPhase & 3 (jump table; phase 3 reuses phase 0) (E-0122)
RunFieldReturnPhase::
    ld a, [wFieldReturnPhase]
    and $03
    jumptable
    dw RunFieldReturnPhase_WriteFieldReturnPhaseAndMenuStateEtc
    dw RunFieldReturnPhase_OpenFieldMenuOnA
    dw RunFieldReturnPhase_ResetLeadRecordFields55And5B
    dw RunFieldReturnPhase_WriteFieldReturnPhaseAndMenuStateEtc

; step 0 of RunFieldReturnPhase: sets wFieldReturnPhase to 0; branches on wModeState; sets
; wMenuState to 5; sets wMenuSubState to 0; sets wModeState to 0; branches on wScriptRunning; sets
; wModeState to 1; branches on wMapType; sets wModeState to 5; branches on wSGBActive; returns if
; wFieldInitStage is $02; calls StartPaletteFade (E-0347)
; why: step 0 of RunFieldReturnPhase (when wFieldReturnPhase = 0); RunFieldReturnPhase: runs the
; routine for wFieldReturnPhase & 3 (jump table (E-0352, E-0122)
RunFieldReturnPhase_WriteFieldReturnPhaseAndMenuStateEtc::
    xor a
    ld [wFieldReturnPhase], a
    ld a, [wModeState]
    cp $06
    jr nz, .clear_mode_state
    ld a, $05
    ld [wMenuState], a
    xor a
    ld [wMenuSubState], a
    ret

.clear_mode_state:
    xor a
    ld [wModeState], a
    ld a, [wScriptRunning]
    or a
    jr z, .check_map_type
    ld a, $01
    ld [wModeState], a
    jr .check_sgb_active

.check_map_type:
    ld a, [wMapType]
    bit 7, a
    jp z, .check_sgb_active
    ld a, $05
    ld [wModeState], a

.check_sgb_active:
    ld a, [wSGBActive]
    or a
    jr z, .call_start_palette_fade
    ld a, [wFieldInitStage]
    cp $02
    ret z

.call_start_palette_fade:
    ld a, $fc
    call StartPaletteFade
    ret

; step 2 of RunFieldReturnPhase: branches on wBattleKind; may continue in
; RunFieldReturnPhase_WriteFieldReturnPhaseAndMenuStateEtc; branches on wBattleScene; may continue
; in RunFieldReturnPhase_WriteFieldReturnPhaseAndMenuStateEtc; branches on wBattleKind; calls
; ResetLeadRecordFields55And5B; continues in
; RunFieldReturnPhase_WriteFieldReturnPhaseAndMenuStateEtc; sets wFieldReturnPhase to 0; sets hMapId
; to 5; sets hMapScreenX to 1; sets hMapScreenY to 0; checks EVENT_THANKS_FOR_COMING_BY_025; then 37
; more steps (see the code) (E-0347)
; why: step 2 of RunFieldReturnPhase (when wFieldReturnPhase = 2); RunFieldReturnPhase: runs the
; routine for wFieldReturnPhase & 3 (jump table (E-0352, E-0122)
RunFieldReturnPhase_ResetLeadRecordFields55And5B::
    ld a, [wBattleKind]
    cp $05
    jp z, .call_fully_heal_party2
    ld a, [wBattleScene]
    or a
    jr z, RunFieldReturnPhase_WriteFieldReturnPhaseAndMenuStateEtc
    cp $03
    jp z, .call_fully_heal_party
    cp $02
    jr nz, .check_battle_kind
    ld a, [wBattleKind]
    cp $04
    jr nz, RunFieldReturnPhase_WriteFieldReturnPhaseAndMenuStateEtc

.check_battle_kind:
    ld a, [wBattleKind]
    cp $04
    jp z, .call_fully_heal_party
    cp $06
    jr z, .call_reset_lead_record_fields55_and5_b
    cp $07
    jr nz, .clear_field_return_phase

.call_reset_lead_record_fields55_and5_b:
    call ResetLeadRecordFields55And5B
    jr RunFieldReturnPhase_WriteFieldReturnPhaseAndMenuStateEtc

.clear_field_return_phase:
    xor a
    ld [wFieldReturnPhase], a
    ld a, $05
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a
    ldh [hMapScreenY], a
    ld c, $03
    push bc
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    pop bc
    jr nc, .set_player_facing
    ld c, $02

.set_player_facing:
    ld a, c
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $a], a
    ld a, $50
    ldh [hPlayerX], a
    ld [wFollowerRecords + $1], a
    ld [wFollowerRecords + $6], a
    ld [wFollowerRecords + $b], a
    ld a, $30
    ldh [hPlayerY], a
    ld [wFollowerRecords + $2], a
    ld [wFollowerRecords + $7], a
    ld [wFollowerRecords + $c], a
    ldh a, [hPlayerStateFlags]
    and $f7
    ldh [hPlayerStateFlags], a
    xor a
    ldh [hPlayerSpriteOverride], a
    ld a, [wMapType]
    bit 7, a
    jr z, .clear_map_type
    farcall SaveKeyWorldFlagsRecordToSRAMSlotKeyWorldSlot

.clear_map_type:
    xor a
    ld [wMapType], a
    farcall PlayMapMusic
    xor a
    ld [wTalkEventIndex], a
    ld a, $05
    ld [wTalkEventGroup], a
    farcall DispatchTalkEvent
    farcall FetchScriptCommand
    jp InitFieldScreen

.call_fully_heal_party:
    farcall FullyHealParty
    xor a
    ld [wFieldReturnPhase], a
    ld a, $04
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a
    ldh [hMapScreenY], a
    ld a, $02
    ldh [hPlayerFacing], a
    ldh [hPlayerFacing], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $a], a
    ld a, $40
    ldh [hPlayerX], a
    ld [wFollowerRecords + $1], a
    ld [wFollowerRecords + $6], a
    ld [wFollowerRecords + $b], a
    ld a, $30
    ldh [hPlayerY], a
    ld [wFollowerRecords + $2], a
    ld [wFollowerRecords + $7], a
    ld [wFollowerRecords + $c], a
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
    ld a, $f7
    ld [wScriptCommandType], a
    ld a, $01
    ld [wScriptInDataBank], a
    jp InitFieldScreen

.call_fully_heal_party2:
    farcall FullyHealParty
    call RunMoveIncapacitatedPartyMembersBackTwice
    call LoadRecordListNameTiles
    farcall LoadPlayerAndFollowerSpriteGraphics
    jp RunFieldReturnPhase_WriteFieldReturnPhaseAndMenuStateEtc

; step 1 of RunFieldReturnPhase: sets wFieldReturnPhase to 0; calls RunFieldReturnPhase_WaitMapType;
; branches on wDataBankSave; sets wFieldInitStage to 0; sets wJoypadPressed; sets hTemp8 to 1; calls
; OpenFieldMenuOnA; sets wModeState to 0; branches on wMapType; sets wModeState to 5; sets
; wCurrentKeyIndex; sets wMapToggleFlag to $80; then 46 more steps (see the code) (E-0347)
; why: step 1 of RunFieldReturnPhase (when wFieldReturnPhase = 1); RunFieldReturnPhase: runs the
; routine for wFieldReturnPhase & 3 (jump table (E-0352, E-0122)
RunFieldReturnPhase_OpenFieldMenuOnA::
    xor a
    ld [wFieldReturnPhase], a
    call RunFieldReturnPhase_WaitMapType
    ld a, [wDataBankSave]
    cp $40
    jr nz, .skip
    push af
    xor a
    ld [wFieldInitStage], a
    pop af
    jr .skip2

.skip:
    or a
    jr nz, .skip2
    ld a, [wJoypadPressed]
    set 0, a
    ld [wJoypadPressed], a
    ld a, $01
    ldh [hTemp8], a
    farcall OpenFieldMenuOnA
    ret

.skip2:
    and $bf
    push af
    xor a
    ld [wModeState], a
    ld a, [wMapType]
    bit 7, a
    jr z, .restore
    ld a, $05
    ld [wModeState], a

.restore:
    pop af
    bit 7, a
    jr z, .skip3
    and $7f
    ld [wCurrentKeyIndex], a
    ld a, $80
    ld [wMapToggleFlag], a
    xor a
    ld [wDataBankSave], a
    ld a, [wCurrentKeyIndex]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add $0a
    ld l, a
    ld a, h
    adc $c7
    ld h, a
    ld a, [hl]
    bit 7, a
    jr z, .set_mode_state_to_06
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    cp $01
    jr z, .set_mode_state_to_06
    ld de, EVENT_COBI_HERO_WHILE_YOURE
    call SetFlagBit

.set_mode_state_to_06:
    ld a, $06
    ld [wModeState], a
    xor a
    ld [wMenuState], a
    ld [wMenuSubState], a
    ret

.skip3:
    or a
    ret z
    dec a
    jr nz, .skip4
    xor a
    ld [wDataBankSave], a
    ld a, $19
    ld [wTalkEventGroup], a
    xor a
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    ret

.skip4:
    dec a
    jr nz, .skip5
    call ResetFollowersToPlayer
    ld a, $02
    call QueueMusic
    ld a, $67
    call QueueSoundEffect
    ld a, $08
    ld [wTalkEventGroup], a
    xor a
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    ret

.skip5:
    dec a
    jr nz, .skip6
    call ResetFollowersToPlayer
    ld a, $02
    call QueueMusic
    ld a, $67
    call QueueSoundEffect
    ld a, $06
    ld [wTalkEventGroup], a
    xor a
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    ret

.skip6:
    dec a
    jr nz, .skip7
    call ResetFollowersToPlayer
    ld a, $02
    call QueueMusic
    ld a, $67
    call QueueSoundEffect
    ld a, $07
    ld [wTalkEventGroup], a
    xor a
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    ret

.skip7:
    dec a
    jr nz, .skip8
    ld a, $39
    ld [wTalkEventGroup], a
    ld a, $02
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    ret

.skip8:
    dec a
    jr nz, .skip9
    ld a, $6a
    ld [wTalkEventGroup], a
    ld a, $03
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    ret

.skip9:
    dec a
    jr nz, .skip10
    ld a, $a1
    ld [wTalkEventGroup], a
    ld a, $04
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    ret

.skip10:
    dec a
    jr nz, .skip11
    ld a, $aa
    ld [wTalkEventGroup], a
    ld a, $04
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    ret

.skip11:
    dec a
    jr nz, .set_talk_event_group_to_09
    xor a
    ld [wDataBankSave], a
    farcall RunFieldReturnPhase_WriteSpriteWindowClipModeAndTemp0Etc
    ret

.set_talk_event_group_to_09:
    ld a, $09
    ld [wTalkEventGroup], a
    xor a
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    ret

; hPlayerFacing and the three follower directions = 0, every follower position = hPlayerX/hPlayerY,
; wDataBankSave = 0 (E-0117)
ResetFollowersToPlayer::
    xor a
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $a], a
    ldh a, [hPlayerX]
    ld [wFollowerRecords + $1], a
    ld [wFollowerRecords + $6], a
    ld [wFollowerRecords + $b], a
    ldh a, [hPlayerY]
    ld [wFollowerRecords + $2], a
    ld [wFollowerRecords + $7], a
    ld [wFollowerRecords + $c], a
    xor a
    ld [wDataBankSave], a
    ret

; for the lead record wPartyList: field $55 = 0, field $5B = $0001, then far-calls
; LoadPlayerAndFollowerSpriteGraphics (E-0122)
ResetLeadRecordFields55And5B::
    ld a, $0a
    ld [rRAMG], a
    ld a, [wPartyList]
    ld c, MON_STATUS
    call SRAMRecordAddress
    ld [hl], $00
    ld a, [wPartyList]
    ld c, MON_HP
    call SRAMRecordAddress
    ld [hl], $01
    inc hl
    ld [hl], $00
    xor a
    ld [rRAMG], a
    farcall LoadPlayerAndFollowerSpriteGraphics
    ret

; called from RunFieldReturnPhase_OpenFieldMenuOnA: returns if bit 7 of wMapType is set; returns
; unless hMapId is $00; returns unless hMapScreenX is 0; returns unless hMapScreenY is $03; returns
; unless wGiftRecord is $01; branches on wCounterPtr0Lo; sets wObject5 to $80; sets wCounterPtr0Lo
; to 0; sets hTemp0 to $15; calls RunFieldCommandTemp0; sets wObject5 to $80 (E-0347)
; why: a helper of RunFieldReturnPhase_OpenFieldMenuOnA, in step 1 of RunFieldReturnPhase (when
; wFieldReturnPhase = 1); RunFieldReturnPhase: runs the routine for wFieldReturnPhase & 3 (jump
; table (E-0352, E-0122)
RunFieldReturnPhase_WaitMapType::
    ld a, [wMapType]
    bit 7, a
    ret nz
    ldh a, [hMapId]
    cp $00
    ret nz
    ldh a, [hMapScreenX]
    or a
    ret nz
    ldh a, [hMapScreenY]
    cp $03
    ret nz
    ld a, [wGiftRecord]
    cp $01
    ret nz
    ld a, [wCounterPtr0Lo]
    cp $ff
    jr z, .clear_counter_ptr0_lo
    ld a, $80
    ld [wObject5], a
    ret

.clear_counter_ptr0_lo:
    xor a
    ld [wCounterPtr0Lo], a
    ld a, $15
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $80
    ld [wObject5], a
    ret

; called from GameMode1_Init: changes A; branches on wMapType; branches on hMapId; branches on $02;
; branches on hMapScreenX; branches on hMapScreenY (E-0347)
; why: a helper of GameMode1_Init; GameMode1_Init: start-up for wGameMode = 1 (E-0352, E-0029)
GameMode1_Init_ReadMapTypeAndMapIdEtc::
    ld a, [wMapType]
    bit 7, a
    jr nz, .cp_38
    ldh a, [hMapId]
    cp $20
    jr nc, .cp_38

.loop:
    ld a, $02
    ret

.cp_38:
    cp $38
    jr nz, .return_04
    ldh a, [hMapScreenX]
    or a
    jr nz, .return_04
    ldh a, [hMapScreenY]
    or a
    jr z, .loop

.return_04:
    ld a, $04
    ret

; data read by GameMode1_Init (1 byte) (E-0347)
GameMode1_Init_Data1::
    db $00

GameMode1_Init_Data2::
    db $00

; per-frame routine for wGameMode = 1 (E-0029)
GameMode1_Update::
    ld a, [wFieldInitStage]
    cp $02
    jp z, SendSGBFieldPaletteSet_ClearJoypadHeld

; advances the play time, then runs the routine for wModeState & $0F (nine states) (E-0122)
FieldModeStateDispatch::
    call IncrementPlayTime
    ld a, [wModeState]
    and $0f
    jumptable
    dw FieldState_WalkATalks
    dw FieldState_RunScript
    dw FieldState_Still
    dw FieldState_BattleTransition
    dw FieldState_MapTransition
    dw FieldState_WalkAMenu
    dw FieldState_FieldMenu
    dw FieldState_StepChecks
    dw FieldState_WorldMap

; field state 0: walking on a map; Select may open the world map (TryOpenWorldMap), A checks for
; someone or something in front (CheckInteractionInFront) (E-0339)
FieldState_WalkATalks::
    ld a, [wFadeState]
    or a
    jp nz, .call_draw_field_sprites
    ld a, [wJoypadPressed]
    bit 2, a
    jr z, .call_field_state_walk_a_talks_wait_text
    farcall TryOpenWorldMap
    ldh a, [hTemp0]
    or a
    ret nz

.call_field_state_walk_a_talks_wait_text:
    farcall FieldState_WalkATalks_WaitTextWindowState
    call FieldState_WalkATalks_WaitFadeState
    call UpdatePlayerMovement
    call RunFieldActionRequestActionIfBit7
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .call_draw_field_sprites
    call CheckInteractionInFront
    farcall CheckTriggerCellOnA
    farcall CheckMapInteractionOnA
    call CheckTileInFrontOnA
    xor a
    ldh [hTemp8], a
    farcall OpenFieldMenuOnA

.call_draw_field_sprites:
    farcall DrawFieldSprites
    farcall FieldStateCommonUpdate
    farcall RunDrawTriggerMarkerSprite
    call RunFieldEventFieldEventKind
    call FarClearRollCounterWhenGM2TimerMinutesIs59
    ret

; field state 1: runs a frame of the event script and the text window, moving the player only for
; some script commands (E-0339)
FieldState_RunScript::
    farcall RunEventScriptFrame
    farcall StepTextWindowOpenClose
    ld a, [wScriptCommandType]
    cp $05
    jr z, .call_update_player_movement
    cp $83
    jr z, .call_update_player_movement
    jr .call_draw_field_sprites

.call_update_player_movement:
    call UpdatePlayerMovement
    call RunFieldActionRequestActionIfBit7

.call_draw_field_sprites:
    farcall DrawFieldSprites
    farcall FieldStateCommonUpdate
    farcall RunDrawTriggerMarkerSprite
    call RunFieldEventFieldEventKind
    call FarClearRollCounterWhenGM2TimerMinutesIs59
    ret

; field state 2: draws the field sprites and runs the common update without player input (E-0339)
FieldState_Still::
    call FieldState_Still_ClearBit1OfPlayerAndObjectFlags
    farcall DrawFieldSprites
    farcall FieldStateCommonUpdate
    farcall RunDrawTriggerMarkerSprite
    call RunFieldEventFieldEventKind
    call FarClearRollCounterWhenGM2TimerMinutesIs59
    ret

; field state 3: runs a step of the battle transition (E-0339)
FieldState_BattleTransition::
    farcall RunBattleTransitionStep
    farcall DrawFieldSprites
    farcall FieldStateCommonUpdate
    farcall RunDrawTriggerMarkerSprite
    call RunFieldEventFieldEventKind
    ret

; field state 4: a map or screen transition: warps, the key-world floor and the transition steps
; (wFieldTransitionStep) (E-0339)
FieldState_MapTransition::
    farcall DrawFieldSprites
    farcall AdvancePlayerAnimCounterAndRunPlayerSpriteMode
    farcall RunDrawTriggerMarkerSprite
    call RunFieldEventFieldEventKind
    ld a, [wFadeState]
    or a
    ret nz
    ld a, [wFieldTransitionStep]
    and $7f
    jp nz, .check_field_transition_step
    ld a, $ff
    ld [wTriggerKind], a
    farcall FieldState_MapTransition_WriteScreenTriggerCountAndWarpPendingEtc
    ld a, [wWarpDestFacing]
    cp $f0
    jr nz, .call_field_state_map_transition_test_flag_bit
    push af
    ld a, $80
    ld [wMapType], a
    ld a, [wKeyWorldWidth]
    ld [wMapWidthScreens], a
    ld a, [wKeyWorldHeight]
    ld [wMapHeightScreens], a
    pop af

.call_field_state_map_transition_test_flag_bit:
    call FieldState_MapTransition_TestFlagBit
    ret

.check_field_transition_step:
    ld a, [wFieldTransitionStep]
    bit 7, a
    jr z, .call_play_map_music
    ld a, $01
    ld [wGameMode], a
    ld hl, wModeChangeRequest
    inc [hl]
    xor a
    ld [wFieldInitStage], a
    ld a, [wMapType]
    bit 7, a
    jr nz, .set_mode_state_to_05
    ld a, $00
    ld [wModeState], a
    ret

.set_mode_state_to_05:
    ld a, $05
    ld [wModeState], a
    ret

.call_play_map_music:
    ld hl, wFieldInitStage
    inc [hl]
    call PlayMapMusic
    xor a
    ld [wFieldReturnPhase], a
    call InitFieldScreen
    ret

; called from FieldState_MapTransition: branches on wFieldTransitionKind; copies
; wFieldTransitionKind-1 to hPlayerFacing; branches on wReturnWarpFlag; sets wReturnWarpFlag to 0;
; checks EVENT_THANKS_FOR_COMING_BY_025; sets hPlayerFacing to 2; sets wMapType to 0; copies
; hPlayerStateFlags & $b7 to hPlayerStateFlags; sets hMapId to 5; sets hMapScreenX to 1; sets
; hMapScreenY to 0; branches on wSavedPositionValid; then 17 more steps (see the code) (E-0347)
; why: a helper of FieldState_MapTransition; FieldState_MapTransition: field state 4: a map or
; screen transition: warps, the key-world floor and the transition steps (wFieldTransitionStep)
; (E-0352, E-0339)
FieldState_MapTransition_TestFlagBit::
    ld a, [wFieldTransitionKind]
    or a
    jr z, .check_return_warp_flag
    dec a
    ldh [hPlayerFacing], a

.check_return_warp_flag:
    ld a, [wReturnWarpFlag]
    or a
    jr z, .check_saved_position_valid
    xor a
    ld [wReturnWarpFlag], a
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr nc, .clear_map_type
    ld a, $02
    ldh [hPlayerFacing], a

.clear_map_type:
    xor a
    ld [wMapType], a
    ldh a, [hPlayerStateFlags]
    and $b7
    ldh [hPlayerStateFlags], a
    ld a, $05
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a
    ldh [hMapScreenY], a

.check_saved_position_valid:
    ld a, [wSavedPositionValid]
    or a
    jr nz, .read_saved_player_state
    ld a, [wWarpDestX]
    ldh [hPlayerX], a
    ld a, [wWarpDestY]
    ldh [hPlayerY], a
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $a], a
    ldh a, [hPlayerX]
    ld [wFollowerRecords + $1], a
    ld [wFollowerRecords + $6], a
    ld [wFollowerRecords + $b], a
    ldh a, [hPlayerY]
    ld [wFollowerRecords + $2], a
    ld [wFollowerRecords + $7], a
    ld [wFollowerRecords + $c], a
    ldh a, [hPlayerStateFlags]
    and $f9
    ldh [hPlayerStateFlags], a
    ld hl, wFieldTransitionStep
    inc [hl]
    ld a, [wMapType]
    bit 7, a
    ret nz
    ldh a, [hMapId]
    cp $05
    ret nz
    ldh a, [hPlayerStateFlags]
    and $f7
    ldh [hPlayerStateFlags], a
    xor a
    ld [wMapType], a
    xor a
    ldh [hPlayerSpriteOverride], a
    xor a
    ld [wWorldMapByFieldSkill], a
    ret

.read_saved_player_state:
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
    ld a, [wSavedPlayerState + $a]
    ld [wFollowerRecords + $a], a
    ld a, [wSavedPlayerState + $b]
    ld [wFollowerRecords + $b], a
    ld a, [wSavedPlayerState + $c]
    ld [wFollowerRecords + $c], a
    xor a
    ld [wSavedPositionValid], a
    ld hl, wFieldTransitionStep
    inc [hl]
    ret

; field state 5: walking where A opens the field menu (OpenFieldMenuOnA) instead of talking (E-0339)
FieldState_WalkAMenu::
    ld a, [wFadeState]
    or a
    jr nz, .call_draw_field_sprites
    ld a, [wJoypadPressed]
    bit 2, a
    jr z, .call_update_player_movement
    farcall TryOpenWorldMap
    ldh a, [hTemp0]
    or a
    ret nz

.call_update_player_movement:
    call UpdatePlayerMovement
    call RunFieldActionRequestActionIfBit7
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .call_draw_field_sprites
    call FieldState_WalkAMenu_WaitFadeState
    farcall CheckTriggerCellOnA
    farcall FieldState_WalkAMenu_WaitTextWindowState
    farcall CheckMapInteractionOnA
    call CheckTileInFrontOnA
    xor a
    ldh [hTemp8], a
    farcall OpenFieldMenuOnA

.call_draw_field_sprites:
    farcall DrawFieldSprites
    farcall FieldStateCommonUpdate
    farcall RunDrawTriggerMarkerSprite
    call RunFieldEventFieldEventKind
    call FarClearRollCounterWhenGM2TimerMinutesIs59
    ret

; field state 6: runs the field menu (RunMenuStateMenuState) (E-0339)
FieldState_FieldMenu::
    farcall RunMenuStateMenuState
    ld a, [wMenuSubState]
    or a
    jr nz, .return
    farcall FieldStateCommonUpdate

.return:
    ret

; field state 7: after a step: the trigger marker, the random encounter counter, step triggers and
; warps (E-0339)
FieldState_StepChecks::
    farcall FieldState_StepChecks_WriteMenuStateAndRAMGEtc
    farcall FieldStateCommonUpdate
    farcall DrawTriggerMarkerSprite
    ld a, [wModeState]
    cp $07
    ret z
    xor a
    ld [wScriptRunning], a
    farcall TickRandomEncounterCounter
    farcall CheckStepTriggerAndDispatchTalk
    farcall CheckWarpsAtPlayerPosition
    xor a
    ld [wFieldStepFlags], a
    ret

; field state 8: the world map (RunWorldMapState) (C2 from E-0339: Select on map $30 switches to
; this state and the world map shows the Water region)
FieldState_WorldMap::
    farcall RunWorldMapState
    call FarClearRollCounterWhenGM2TimerMinutesIs59
    ret

; when wGM2TimerMinutes = $3B and wGM2TimerSeconds = wGM2TimerFrames = 0, far-calls
; ClearRollCounterWhenGM2TimerMinutesIs59 (E-0122) (E-0344: the address in its name dropped or read
; as the label there; was FarClearRollCounterWhenGM2TimerMinutesIs59; shortened from
; CallF0ClearRollCounterWhenGM2TimerMinutesIs59WhenGM2TimerMinutesIs59)
FarClearRollCounterWhenGM2TimerMinutesIs59::
    ld a, [wGM2TimerMinutes]
    cp $3b
    ret nz
    ld a, [wGM2TimerSeconds]
    and a
    ret nz
    ld a, [wGM2TimerFrames]
    and a
    ret nz
    farcall ClearRollCounterWhenGM2TimerMinutesIs59
    ret

; A in field states 0 and 5, when the map has special tiles (wMapSpriteKind) and nothing blocks
; input: finds the tile in front of the player (TileBlockedAtPixel); a kind in the high nibble,
; allowed once story flag $1F is set, may run TryHeaderTileTalkEvent; a kind in the low nibble needs
; MapSpriteKindUnlocked, then CheckTallTileInFront (E-0339; was CheckTileInFrontOnA)
CheckTileInFrontOnA::
    ld a, [wMapSpriteKind]
    or a
    ret z
    ld a, [wFadeState]
    or a
    ret nz
    ld a, [wTextWindowState]
    and $03
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
    or a
    jr z, .skip
    dec a
    jr z, .skip2
    dec a
    jr z, .skip3
    ld a, b
    or a
    ret z
    sub $10
    ld b, a
    jr .call_tile_blocked_at_pixel

.skip:
    ld a, c
    cp $80
    ret z
    add $10
    ld c, a
    jr .call_tile_blocked_at_pixel

.skip2:
    ld a, b
    cp $90
    ret z
    add $10
    ld b, a
    jr .call_tile_blocked_at_pixel

.skip3:
    ld a, c
    or a
    ret z
    sub $10
    ld c, a

.call_tile_blocked_at_pixel:
    call TileBlockedAtPixel
    ld a, [wMapSpriteKind]
    and $f0
    jr z, .check_map_sprite_kind
    swap a
    call TestFlag1FAsBool
    or a
    jr z, .check_map_sprite_kind
    ld [wTileActionKind], a
    call TryHeaderTileTalkEvent
    or a
    ret nz

.check_map_sprite_kind:
    ld a, [wMapSpriteKind]
    and $0f
    ret z
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr nz, .call_check_tall_tile_in_front
    call MapSpriteKindUnlocked
    or a
    ret z
    ld [wTileActionKind], a

.call_check_tall_tile_in_front:
    call CheckTallTileInFront
    ret

; A = 1 if story flag $1F is set, else 0 (E-0122)
TestFlag1FAsBool::
    ld de, EVENT_SCENE_MERMAID_KINGDOM
    call TestFlagBit
    jr c, .return_01
    xor a
    ret

.return_01:
    ld a, $01
    ret

; A = 1 when the story flag for wMapSpriteKind's low nibble is set: kind 1 needs
; EVENT_SCENE_RIVAL_DEFEATED ($1E?), other kinds EVENT_SCENE_SHIELD2 (E-0339; was
; MapSpriteKindUnlocked)
MapSpriteKindUnlocked::
    ld a, [wMapSpriteKind]
    and $0f
    cp $01
    jr nz, .call_test_flag_bit
    ld de, EVENT_SCENE_RIVAL_DEFEATED
    call TestFlagBit
    jr c, .return_01
    jr .return_0

.call_test_flag_bit:
    ld de, EVENT_SCENE_SHIELD2
    call TestFlagBit
    jr c, .return_01

.return_0:
    xor a
    ret

.return_01:
    ld a, $01
    ret

; unless player state bit 3 is set: when the tile under the point equals wMapEventTile, runs talk
; event group 2, index 0 (DispatchTalkEvent) and clears the joypad (E-0339; was
; TryHeaderTileTalkEvent)
TryHeaderTileTalkEvent::
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr z, .read_map_event_tile

.loop:
    xor a
    ret

.read_map_event_tile:
    ld a, [wMapEventTile]
    ld c, a
    ld a, [wTilesUnderPoint]
    cp c
    jr nz, .loop
    ld a, $02
    ld [wTalkEventGroup], a
    xor a
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    xor a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ld a, [wPartyWindowFlags]
    bit 7, a
    jr z, .return_01
    farcall RedrawScreenBufferIfPartyWindowFlagsBit7

.return_01:
    ld a, $01
    ret

; compares the four tiles under the point (wTilesUnderPoint) with wMapTallTileMin, unless player
; state bit 3 is set (E-0339; was CheckTallTileInFront)
CheckTallTileInFront::
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr nz, .skip
    ld de, wTilesUnderPoint
    ld b, $04

.loop:
    ld a, [de]
    inc de
    ld c, a
    ld a, [wMapTallTileMin]
    cp c
    jr c, .next
    jr .set_talk_event_group_to_01

.next:
    dec b
    jr nz, .loop
    ret

.set_talk_event_group_to_01:
    ld a, $01
    ld [wTalkEventGroup], a
    xor a
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    xor a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ld a, [wPartyWindowFlags]
    bit 7, a
    ret z
    farcall RedrawScreenBufferIfPartyWindowFlagsBit7
    ret

.skip:
    ld de, wTilesUnderPoint
    ld b, $04

.loop2:
    ld a, [de]
    inc de
    ld c, a
    ld a, [wMaxBlockingTile]
    cp c
    jr c, .next2
    jr .return

.next2:
    dec b
    jr nz, .loop2
    jr .set_talk_event_group_to_012

.return:
    ret

.set_talk_event_group_to_012:
    ld a, $01
    ld [wTalkEventGroup], a
    xor a
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    xor a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ld a, [wPartyWindowFlags]
    bit 7, a
    ret z
    farcall RedrawScreenBufferIfPartyWindowFlagsBit7
    ret

; called from FieldState_WalkAMenu: returns unless wFadeState is 0; returns if bit 7 of
; wFieldActionRequest is set; returns if bit 0 of hPlayerStateFlags is set; returns unless bit 0 of
; wJoypadPressed is set; dispatches on wMapType & $07 (E-0347)
; why: a helper of FieldState_WalkAMenu; FieldState_WalkAMenu: field state 5: walking where A opens
; the field menu (OpenFieldMenuOnA) instead of talking (E-0352, E-0339)
FieldState_WalkAMenu_WaitFadeState::
    ld a, [wFadeState]
    or a
    ret nz
    ld a, [wTextWindowState]
    and $03
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
    and $07
    jumptable
    dw FieldState_WalkAMenu_Return
    dw FieldState_WalkAMenu_Return
    dw FieldState_WalkAMenu_Return
    dw FieldState_WalkAMenu_WriteFieldReturnPhaseAndGameModeEtc
    dw FieldState_WalkAMenu_Return
    dw FieldState_WalkAMenu_Return
    dw FieldState_WalkAMenu_Return
    dw FieldState_WalkAMenu_SaveKeyWorldFlagsRecordToSRAMSlotKeyWorldSlot

; step 0 of FieldState_WalkAMenu_WaitFadeState: returns at once (E-0347)
; why: step 0 of FieldState_WalkAMenu_WaitFadeState (when wMapType = 0), in a helper of
; FieldState_WalkAMenu; FieldState_WalkAMenu: field state 5: walking where A opens the field menu
; (OpenFieldMenuOnA) instead of talking (E-0352, E-0339)
FieldState_WalkAMenu_Return::
    ret

; step 3 of FieldState_WalkAMenu_WaitFadeState: branches on the byte at wKeyWorldFloorInfo + $1;
; returns unless the byte at wKeyWorldFloorInfo + $1 is $01; returns unless hPlayerFacing is $02;
; returns unless hMapScreenY is $01; returns unless hPlayerX is $80; returns unless hPlayerY is $10;
; continues in
; FieldState_WalkAMenu_SaveKeyWorldFlagsRecordToSRAMSlotKeyWorldSlot_CallSaveKeyWorldFlagsRecordToSRAMSlotKeyWorl
; (E-0347)
; why: step 3 of FieldState_WalkAMenu_WaitFadeState (when wMapType = 3), in a helper of
; FieldState_WalkAMenu; FieldState_WalkAMenu: field state 5: walking where A opens the field menu
; (OpenFieldMenuOnA) instead of talking (E-0352, E-0339)
FieldState_WalkAMenu_WriteFieldReturnPhaseAndGameModeEtc::
    ld a, [wKeyWorldFloor]
    add a
    add a
    ld hl, wKeyWorldFloorInfo + $1
    add_a_to_hl
    ld a, [hl]
    cp $06
    jr z, .return
    cp $01
    ret nz
    ldh a, [hPlayerFacing]
    cp $02
    ret nz
    ldh a, [hMapScreenY]
    cp $01
    ret nz
    ldh a, [hPlayerX]
    cp $80
    ret nz
    ldh a, [hPlayerY]
    cp $10
    ret nz
    jr FieldState_WalkAMenu_SaveKeyWorldFlagsRecordToSRAMSlotKeyWorldSlot_CallSaveKeyWorldFlagsRecordToSRAMSlotKeyWorl

.return:
    ret

; step 7 of FieldState_WalkAMenu_WaitFadeState: returns unless hPlayerFacing is $02; returns unless
; hPlayerX is $40; returns unless hPlayerY is $40; continues in
; FieldState_WalkAMenu_SaveKeyWorldFlagsRecordToSRAMSlotKeyWorldSlot_CallSaveKeyWorldFlagsRecordToSRAMSlotKeyWorl
; (E-0347)
; why: step 7 of FieldState_WalkAMenu_WaitFadeState (when wMapType = 7), in a helper of
; FieldState_WalkAMenu; FieldState_WalkAMenu: field state 5: walking where A opens the field menu
; (OpenFieldMenuOnA) instead of talking (E-0352, E-0339)
FieldState_WalkAMenu_SaveKeyWorldFlagsRecordToSRAMSlotKeyWorldSlot::
    ldh a, [hPlayerFacing]
    cp $02
    ret nz
    ldh a, [hPlayerX]
    cp $40
    ret nz
    ldh a, [hPlayerY]
    cp $40
    ret nz
    jr FieldState_WalkAMenu_SaveKeyWorldFlagsRecordToSRAMSlotKeyWorldSlot_CallSaveKeyWorldFlagsRecordToSRAMSlotKeyWorl

; Calls SaveKeyWorldFlagsRecordToSRAMSlotKeyWorldSlot; calls
; RedrawScreenBufferIfPartyWindowFlagsBit7; calls SaveScreenBufferToBGMap1; sets wFieldReturnPhase
; to 1; plays sound $69; sets wGameMode to 2; sets wModeState to $0b; sets wWorldMapState to 0; sets
; wJoypadHeld to 0; sets wJoypadPressed to 0 (E-0347)
; why: part of FieldState_WalkAMenu_SaveKeyWorldFlagsRecordToSRAMSlotKeyWorldSlot, in step 7 of
; FieldState_WalkAMenu_WaitFadeState (when wMapType = 7), in a helper of FieldState_WalkAMenu;
; FieldState_WalkAMenu: field state 5: walking where A opens the field menu (OpenFieldMenuOnA)
; instead of talking (E-0352, E-0339)
FieldState_WalkAMenu_SaveKeyWorldFlagsRecordToSRAMSlotKeyWorldSlot_CallSaveKeyWorldFlagsRecordToSRAMSlotKeyWorl::
    farcall SaveKeyWorldFlagsRecordToSRAMSlotKeyWorldSlot
    call RedrawScreenBufferIfPartyWindowFlagsBit7
    call SaveScreenBufferToBGMap1
    ld a, $01
    ld [wFieldReturnPhase], a
    ld a, $69
    call QueueSoundEffect
    ld a, $02
    ld [wGameMode], a
    ld a, $0b
    ld [wModeState], a
    xor a
    ld [wWorldMapState], a
    xor a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ret

; when A is newly pressed and no fade, load or move is in progress: finds the position one step
; ahead of the player (hPlayerX or hPlayerY +/- 16 chosen by hPlayerFacing), looks it up with
; TileBlockedAtPixel, and compares the result with the four ids at wTilesUnderPoint to pick an
; interaction (E-0030)
CheckInteractionInFront::
    ld a, [wMapHeaderByte7]
    or a
    ret z
    ld de, EVENT_SCENE_LONG_FACES_002
    call TestFlagBit
    ret nc
    ld a, [wFadeState]
    or a
    ret nz
    ld a, [wTextWindowState]
    and $03
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
    or a
    jr z, .skip
    dec a
    jr z, .skip2
    dec a
    jr z, .skip3
    ld a, b
    sub $10
    ld b, a
    jr .call_tile_blocked_at_pixel

.skip:
    ld a, c
    add $10
    ld c, a
    jr .call_tile_blocked_at_pixel

.skip2:
    ld a, b
    add $10
    ld b, a
    jr .call_tile_blocked_at_pixel

.skip3:
    ld a, c
    sub $10
    ld c, a

.call_tile_blocked_at_pixel:
    call TileBlockedAtPixel
    ld de, wTilesUnderPoint
    ld b, $04

.loop:
    ld a, [de]
    inc de
    ld c, a
    ld a, [wMapHeaderByte7]
    cp c
    jr nz, .next
    jr .call_redraw_screen_buffer_if_party_window

.next:
    dec b
    jr nz, .loop
    ret

.call_redraw_screen_buffer_if_party_window:
    call RedrawScreenBufferIfPartyWindowFlagsBit7
    call SaveScreenBufferToBGMap1
    ld a, $01
    ld [wFieldReturnPhase], a
    ld a, $69
    call QueueSoundEffect
    ld a, $02
    ld [wGameMode], a
    ld a, $0b
    ld [wModeState], a
    xor a
    ld [wWorldMapState], a
    xor a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ret

; unless a fade runs or bit 7 of wFieldActionRequest is set, runs the field event for
; wFieldEventKind & $0F (jump table of sixteen) (E-0124)
RunFieldEventFieldEventKind::
    ld a, [wFadeState]
    or a
    ret nz
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    ld a, [wFieldEventKind]
    and $0f
    jumptable
    dw RunFieldEventFieldEventKind_Return
    dw AnimateTilesByRotatingVTiles2
    dw AnimateTilesByRotatingVTiles2
    dw RunFieldEventFieldEventKind_WaitFrameCounterLo
    dw RunFieldEventFieldEventKind_WaitFrameCounterLo_2
    dw RunFieldEventFieldEventKind_AnimateTilesByRotatingVTiles2
    dw RunFieldEventFieldEventKind_TestFlagBit
    dw RunFieldEventFieldEventKind_ReadFrameCounterLo
    dw RunFieldEventFieldEventKind_ToRunFieldEventFieldEventKind_CopyBytes
    dw RunFieldEventFieldEventKind_WaitFrameCounterLo_3
    dw RunFieldEventFieldEventKind_WaitFrameCounterLo_4
    dw RunFieldEventFieldEventKind_WaitMapScreenY
    dw RunFieldEventFieldEventKind_WriteFieldEventTimerAndScrollX
    dw RunFieldEventFieldEventKind_WriteVRAMByteInc
    dw RunFieldEventFieldEventKind_WriteVRAMByteInc_2
    dw RunFieldEventFieldEventKind_WaitMapScreenX

; step 12 of RunFieldEventFieldEventKind: calls
; RunFieldEventFieldEventKind_WriteFieldEventTimerAndScrollX_2 (E-0347)
; why: step 12 of RunFieldEventFieldEventKind (when wFieldEventKind = 12);
; RunFieldEventFieldEventKind: unless a fade runs or bit 7 of wFieldActionRequest is set, runs the
; field event for wFieldEventKind & $0F (jump table of sixteen) (E-0352, E-0124)
RunFieldEventFieldEventKind_WriteFieldEventTimerAndScrollX::
    call RunFieldEventFieldEventKind_WriteFieldEventTimerAndScrollX_2
    ret

; step 8 of RunFieldEventFieldEventKind: calls RunFieldEventFieldEventKind_CopyBytes (E-0347)
; why: step 8 of RunFieldEventFieldEventKind (when wFieldEventKind = 8);
; RunFieldEventFieldEventKind: unless a fade runs or bit 7 of wFieldActionRequest is set, runs the
; field event for wFieldEventKind & $0F (jump table of sixteen) (E-0352, E-0124)
RunFieldEventFieldEventKind_ToRunFieldEventFieldEventKind_CopyBytes::
    call RunFieldEventFieldEventKind_CopyBytes
    ret

; step 0 of RunFieldEventFieldEventKind: returns at once (E-0347)
; why: step 0 of RunFieldEventFieldEventKind (when wFieldEventKind = 0);
; RunFieldEventFieldEventKind: unless a fade runs or bit 7 of wFieldActionRequest is set, runs the
; field event for wFieldEventKind & $0F (jump table of sixteen) (E-0352, E-0124)
RunFieldEventFieldEventKind_Return::
    ret

; every 8 frames rotates each byte pair of the first 16 tile rows at vTiles2 left by one bit (tile
; animation) (E-0124)
AnimateTilesByRotatingVTiles2::
    ld a, [wFrameCounterLo]
    and $07
    ret nz
    ld hl, vTiles2
    ld b, $10

.loop:
    di
    call WaitForVRAMAccess
    ld a, [hli]
    ld c, [hl]
    ei
    dec hl
    rlca
    rlc c
    push af
    di

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    pop af
    ld [hli], a
    ld [hl], c
    ei
    inc hl
    dec b
    jr nz, .loop
    ret

; step 13 of RunFieldEventFieldEventKind: may return early; calls WriteVRAMByteInc (E-0347)
; why: step 13 of RunFieldEventFieldEventKind (when wFieldEventKind = 13);
; RunFieldEventFieldEventKind: unless a fade runs or bit 7 of wFieldActionRequest is set, runs the
; field event for wFieldEventKind & $0F (jump table of sixteen) (E-0352, E-0124)
RunFieldEventFieldEventKind_WriteVRAMByteInc::
    ld a, [wFrameCounterLo]
    and $07
    ret nz
    ld hl, vTiles2 + $a0
    ld b, $20

.loop:
    di
    call WaitForVRAMAccess
    ld a, [hl]
    ei
    rlca
    call WriteVRAMByteInc
    dec b
    jr nz, .loop
    ret

; step 14 of RunFieldEventFieldEventKind: may return early; calls WriteVRAMByteInc (E-0347)
; why: step 14 of RunFieldEventFieldEventKind (when wFieldEventKind = 14);
; RunFieldEventFieldEventKind: unless a fade runs or bit 7 of wFieldActionRequest is set, runs the
; field event for wFieldEventKind & $0F (jump table of sixteen) (E-0352, E-0124)
RunFieldEventFieldEventKind_WriteVRAMByteInc_2::
    ld a, [wFrameCounterLo]
    and $07
    ret nz
    ld hl, vTiles2
    ld b, $30

.loop:
    di
    call WaitForVRAMAccess
    ld a, [hl]
    ei
    rlca
    call WriteVRAMByteInc
    dec b
    jr nz, .loop
    ld hl, vTiles2 + $30
    ld b, $30

.loop2:
    di
    call WaitForVRAMAccess
    ld a, [hl]
    ei
    rlca
    call WriteVRAMByteInc
    dec b
    jr nz, .loop2
    ret

; step 3 of RunFieldEventFieldEventKind: changes HL, DE and A; may return early; continues in
; RunFieldEventFieldEventKind_WaitMapScreenX_CheckFrameCounterLo (E-0347)
; why: step 3 of RunFieldEventFieldEventKind (when wFieldEventKind = 3);
; RunFieldEventFieldEventKind: unless a fade runs or bit 7 of wFieldActionRequest is set, runs the
; field event for wFieldEventKind & $0F (jump table of sixteen) (E-0352, E-0124)
RunFieldEventFieldEventKind_WaitFrameCounterLo::
    ld a, [wFrameCounterLo]
    and $0f
    ret nz
    ld de, vTiles2 + $300
    ld hl, vTiles2 + $320
    jp RunFieldEventFieldEventKind_WaitMapScreenX_CheckFrameCounterLo

; step 4 of RunFieldEventFieldEventKind: changes HL, DE and A; may return early; continues in
; RunFieldEventFieldEventKind_WaitMapScreenX_ReadFrameCounterLo (E-0347)
; why: step 4 of RunFieldEventFieldEventKind (when wFieldEventKind = 4);
; RunFieldEventFieldEventKind: unless a fade runs or bit 7 of wFieldActionRequest is set, runs the
; field event for wFieldEventKind & $0F (jump table of sixteen) (E-0352, E-0124)
RunFieldEventFieldEventKind_WaitFrameCounterLo_2::
    ld a, [wFrameCounterLo]
    and $03
    ret nz
    ld de, vTiles2 + $280
    ld hl, vTiles2 + $2c0
    jr RunFieldEventFieldEventKind_WaitMapScreenX_ReadFrameCounterLo

; step 5 of RunFieldEventFieldEventKind: calls AnimateTilesByRotatingVTiles2; may return early;
; continues in RunFieldEventFieldEventKind_WaitMapScreenX_ReadFrameCounterLo (E-0347)
; why: step 5 of RunFieldEventFieldEventKind (when wFieldEventKind = 5);
; RunFieldEventFieldEventKind: unless a fade runs or bit 7 of wFieldActionRequest is set, runs the
; field event for wFieldEventKind & $0F (jump table of sixteen) (E-0352, E-0124)
RunFieldEventFieldEventKind_AnimateTilesByRotatingVTiles2::
    call AnimateTilesByRotatingVTiles2
    ld a, [wFrameCounterLo]
    and $03
    ret nz
    ld de, vTiles2 + $140
    ld hl, vTiles2 + $180
    jr RunFieldEventFieldEventKind_WaitMapScreenX_ReadFrameCounterLo

; step 9 of RunFieldEventFieldEventKind: changes HL, DE and A; may return early; continues in
; RunFieldEventFieldEventKind_WaitMapScreenX_ReadFrameCounterLo (E-0347)
; why: step 9 of RunFieldEventFieldEventKind (when wFieldEventKind = 9);
; RunFieldEventFieldEventKind: unless a fade runs or bit 7 of wFieldActionRequest is set, runs the
; field event for wFieldEventKind & $0F (jump table of sixteen) (E-0352, E-0124)
RunFieldEventFieldEventKind_WaitFrameCounterLo_3::
    ld a, [wFrameCounterLo]
    and $03
    ret nz
    ld de, vTiles2 + $280
    ld hl, vTiles2 + $2c0
    jr RunFieldEventFieldEventKind_WaitMapScreenX_ReadFrameCounterLo

; step 10 of RunFieldEventFieldEventKind: changes HL, DE and A; may return early; continues in
; RunFieldEventFieldEventKind_WaitMapScreenX_ReadFrameCounterLo (E-0347)
; why: step 10 of RunFieldEventFieldEventKind (when wFieldEventKind = 10);
; RunFieldEventFieldEventKind: unless a fade runs or bit 7 of wFieldActionRequest is set, runs the
; field event for wFieldEventKind & $0F (jump table of sixteen) (E-0352, E-0124)
RunFieldEventFieldEventKind_WaitFrameCounterLo_4::
    ld a, [wFrameCounterLo]
    and $03
    ret nz
    ld de, vTiles2 + $480
    ld hl, vTiles2 + $4c0
    jr RunFieldEventFieldEventKind_WaitMapScreenX_ReadFrameCounterLo

; step 15 of RunFieldEventFieldEventKind: returns if hMapScreenX is $01; returns unless hMapScreenX
; is $01; continues in RunFieldEventFieldEventKind_WaitMapScreenX_ReadFrameCounterLo (E-0347)
; why: step 15 of RunFieldEventFieldEventKind (when wFieldEventKind = 15);
; RunFieldEventFieldEventKind: unless a fade runs or bit 7 of wFieldActionRequest is set, runs the
; field event for wFieldEventKind & $0F (jump table of sixteen) (E-0352, E-0124)
RunFieldEventFieldEventKind_WaitMapScreenX::
    ldh a, [hMapScreenX]
    cp $01
    ret z
    ld a, [wFrameCounterLo]
    and $03
    ret nz
    ld de, vTiles2
    ld hl, vTiles2 + $40
    jr RunFieldEventFieldEventKind_WaitMapScreenX_ReadFrameCounterLo

; Calls WriteVRAMByteInc (E-0347)
; why: part of RunFieldEventFieldEventKind_WaitMapScreenX, in step 15 of RunFieldEventFieldEventKind
; (when wFieldEventKind = 15); RunFieldEventFieldEventKind: unless a fade runs or bit 7 of
; wFieldActionRequest is set, runs the field event for wFieldEventKind & $0F (jump table of sixteen)
; (E-0352, E-0124)
RunFieldEventFieldEventKind_WaitMapScreenX_ReadFrameCounterLo::
    ld a, [wFrameCounterLo]
    srl a
    srl a
    and $03
    swap a
    push af
    add_a_to_hl
    pop af
    add e
    ld e, a
    jr nc, .call_wait_for_vram_access
    inc d

.call_wait_for_vram_access:
    ld b, $10

.loop:
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
    jr nz, .loop
    ret

; Calls WriteVRAMByteInc (E-0347)
; why: part of RunFieldEventFieldEventKind_WaitMapScreenX, in step 15 of RunFieldEventFieldEventKind
; (when wFieldEventKind = 15); RunFieldEventFieldEventKind: unless a fade runs or bit 7 of
; wFieldActionRequest is set, runs the field event for wFieldEventKind & $0F (jump table of sixteen)
; (E-0352, E-0124)
RunFieldEventFieldEventKind_WaitMapScreenX_CheckFrameCounterLo::
    ld a, [wFrameCounterLo]
    and $10
    push af
    add_a_to_hl
    pop af
    add e
    ld e, a
    jr nc, .call_wait_for_vram_access
    inc d

.call_wait_for_vram_access:
    ld b, $10

.loop:
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
    jr nz, .loop
    ret

; step 6 of RunFieldEventFieldEventKind: checks EVENT_SCENE_MONSTER_INSPECTION; may return early;
; returns if wFrameCounterLo & $1f is at least $0c; continues in
; RunFieldEventFieldEventKind_WaitMapScreenY_Data_CallWaitForVRAMAccess (E-0347)
; why: step 6 of RunFieldEventFieldEventKind (when wFieldEventKind = 6);
; RunFieldEventFieldEventKind: unless a fade runs or bit 7 of wFieldActionRequest is set, runs the
; field event for wFieldEventKind & $0F (jump table of sixteen) (E-0352, E-0124)
RunFieldEventFieldEventKind_TestFlagBit::
    ld de, EVENT_SCENE_MONSTER_INSPECTION
    call TestFlagBit
    ret c
    ld a, [wFrameCounterLo]
    and $1f
    cp $0c
    ret nc
    sla a
    sla a
    ld hl, RunFieldEventFieldEventKind_TestFlagBit_Data
    add_a_to_hl
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    ld a, [hli]
    ld c, a
    ld a, [hl]
    ld h, a
    ld l, c
    jp RunFieldEventFieldEventKind_WaitMapScreenY_Data_CallWaitForVRAMAccess

; data read by RunFieldEventFieldEventKind (48 bytes) (E-0347)
RunFieldEventFieldEventKind_TestFlagBit_Data::
    db $c0, $91, $e0, $91, $d0, $91, $f0, $91, $20, $92, $60, $92, $30, $92, $70, $92
    db $20, $93, $40, $93, $30, $93, $50, $93, $80, $93, $a0, $93, $90, $93, $b0, $93
    db $20, $94, $40, $94, $30, $94, $50, $94, $80, $94, $a0, $94, $90, $94, $b0, $94

; step 7 of RunFieldEventFieldEventKind: returns if wFrameCounterLo & $1f is at least $0c; continues
; in RunFieldEventFieldEventKind_WaitMapScreenY_Data_CallWaitForVRAMAccess (E-0347)
; why: step 7 of RunFieldEventFieldEventKind (when wFieldEventKind = 7);
; RunFieldEventFieldEventKind: unless a fade runs or bit 7 of wFieldActionRequest is set, runs the
; field event for wFieldEventKind & $0F (jump table of sixteen) (E-0352, E-0124)
RunFieldEventFieldEventKind_ReadFrameCounterLo::
    ld a, [wFrameCounterLo]
    and $1f
    cp $0c
    ret nc
    sla a
    sla a
    ld hl, RunFieldEventFieldEventKind_ReadFrameCounterLo_Data
    add_a_to_hl
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    ld a, [hli]
    ld c, a
    ld a, [hl]
    ld h, a
    ld l, c
    jr RunFieldEventFieldEventKind_WaitMapScreenY_Data_CallWaitForVRAMAccess

; data read by RunFieldEventFieldEventKind (48 bytes) (E-0347)
RunFieldEventFieldEventKind_ReadFrameCounterLo_Data::
    db $30, $93, $50, $93, $40, $93, $60, $93, $20, $94, $40, $94, $30, $94, $50, $94
    db $c0, $94, $e0, $94, $d0, $94, $f0, $94, $60, $95, $80, $95, $70, $95, $90, $95
    db $20, $96, $60, $96, $30, $96, $70, $96, $a0, $96, $e0, $96, $b0, $96, $f0, $96

; step 11 of RunFieldEventFieldEventKind: returns unless hMapScreenY is 0; returns if
; wFrameCounterLo & $3f is at least $04; continues in
; RunFieldEventFieldEventKind_WaitMapScreenY_Data_CallWaitForVRAMAccess (E-0347)
; why: step 11 of RunFieldEventFieldEventKind (when wFieldEventKind = 11);
; RunFieldEventFieldEventKind: unless a fade runs or bit 7 of wFieldActionRequest is set, runs the
; field event for wFieldEventKind & $0F (jump table of sixteen) (E-0352, E-0124)
RunFieldEventFieldEventKind_WaitMapScreenY::
    ldh a, [hMapScreenY]
    or a
    ret nz
    ld a, [wFrameCounterLo]
    and $3f
    cp $04
    ret nc
    sla a
    sla a
    ld hl, RunFieldEventFieldEventKind_WaitMapScreenY_Data
    add_a_to_hl
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    ld a, [hli]
    ld c, a
    ld a, [hl]
    ld h, a
    ld l, c
    jp RunFieldEventFieldEventKind_WaitMapScreenY_Data_CallWaitForVRAMAccess

; data read by RunFieldEventFieldEventKind (16 bytes) (E-0347)
RunFieldEventFieldEventKind_WaitMapScreenY_Data::
    db $e0, $94, $00, $95, $f0, $94, $10, $95, $40, $95, $60, $95, $50, $95, $70, $95

; Calls WriteVRAMByteInc (E-0347)
; why: part of RunFieldEventFieldEventKind_WaitMapScreenY_Data, in part of
; RunFieldEventFieldEventKind_WaitMapScreenY, in step 11 of RunFieldEventFieldEventKind (when
; wFieldEventKind = 11); RunFieldEventFieldEventKind: unless a fade runs or bit 7 of
; wFieldActionRequest is set, runs the field event for wFieldEventKind & $0F (jump table of sixteen)
; (E-0352, E-0124)
RunFieldEventFieldEventKind_WaitMapScreenY_Data_CallWaitForVRAMAccess::
    ld b, $10

.loop:
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
    jr nz, .loop
    ret

; called from RunFieldEventFieldEventKind_ToRunFieldEventFieldEventKind_CopyBytes: returns if
; wScriptCommandType is $ed; returns unless wSavedPositionValid is 0; branches on wMenuSubState;
; sets wMenuSubState to $80; calls CopyBytes; increments wMenuState; may return early; branches on
; wMenuState; copies wMenuSubState & $81 to wMenuSubState; sets wMenuState to 0; sets hTemp0 to 0;
; calls RunFieldEventFieldEventKind_WriteTextCounter2AndTextCounter3Etc; then 1 more step (see the
; code) (E-0347)
; why: a helper of RunFieldEventFieldEventKind_ToRunFieldEventFieldEventKind_CopyBytes, in step 8 of
; RunFieldEventFieldEventKind (when wFieldEventKind = 8); RunFieldEventFieldEventKind: unless a fade
; runs or bit 7 of wFieldActionRequest is set, runs the field event for wFieldEventKind & $0F (jump
; table of sixteen) (E-0352, E-0124)
RunFieldEventFieldEventKind_CopyBytes::
    ld a, [wScriptCommandType]
    cp $ed
    ret z
    ld a, [wSavedPositionValid]
    and a
    ret nz
    ld a, [wMenuSubState]
    bit 7, a
    jr nz, .check_menu_state
    ld a, $80
    ld [wMenuSubState], a
    ld hl, wBGPaletteBuffer
    ld de, wBGPaletteCopy
    ld bc, $0040
    call CopyBytes
    ret

.check_menu_state:
    ld a, [wMenuState]
    inc a
    ld [wMenuState], a
    and $07
    dec a
    ret nz
    ld a, [wMenuState]
    srl a
    srl a
    srl a
    cp $08
    jr nz, .set_temp0
    ld a, [wMenuSubState]
    inc a
    and $81
    ld [wMenuSubState], a
    xor a
    ld [wMenuState], a

.set_temp0:
    ldh [hTemp0], a
    ld hl, wBGPaletteCopy + $8
    ld de, wBGPaletteBuffer + $8
    call RunFieldEventFieldEventKind_WriteTextCounter2AndTextCounter3Etc
    ld hl, wBGPaletteCopy + $10
    ld de, wBGPaletteBuffer + $10
    ld hl, wBGPaletteCopy + $18
    ld de, wBGPaletteBuffer + $18
    call RunFieldEventFieldEventKind_WriteTextCounter2AndTextCounter3Etc
    ld hl, wBGPaletteCopy + $20
    ld de, wBGPaletteBuffer + $20
    call RunFieldEventFieldEventKind_WriteTextCounter2AndTextCounter3Etc
    ld a, $7f
    ld [wBGPaletteUploadRequest], a
    ret

; Copies B to wTextCounter2; copies B & $1f to wTextCounter3; copies C & $1f to wTextCounter4;
; branches on wMenuSubState; branches on C (E-0347)
; why: part of RunFieldEventFieldEventKind; RunFieldEventFieldEventKind: unless a fade runs or bit 7
; of wFieldActionRequest is set, runs the field event for wFieldEventKind & $0F (jump table of
; sixteen) (E-0352, E-0124)
RunFieldEventFieldEventKind_WriteTextCounter2AndTextCounter3Etc::
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
    and $1f
    ld [wTextCounter3], a
    pop bc
    ld a, c
    and $1f
    ld [wTextCounter4], a
    push hl
    ld hl, RunFieldEventFieldEventKind_WriteTextCounter2AndTextCounter3Etc_Data
    ldh a, [hTemp0]
    add_a_to_hl
    ld a, [wMenuSubState]
    bit 0, a
    jr z, .skip
    ld a, $08
    add l
    ld l, a
    jr nc, .skip
    inc h

.skip:
    ld a, [hl]
    ld b, a
    ld hl, wTextCounter2
    ld c, $00

.loop:
    ld a, [hl]
    add b
    bit 7, a
    jr z, .skip2
    xor a

.skip2:
    ld [hli], a
    inc c
    ld a, c
    cp $03
    jr c, .loop
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
    or c
    ld c, a
    ld a, c
    ld [de], a
    inc de
    ld a, b
    ld [de], a
    inc de
    ret

; data read by RunFieldEventFieldEventKind (16 bytes) (E-0347)
RunFieldEventFieldEventKind_WriteTextCounter2AndTextCounter3Etc_Data::
    db $00, $fc, $f8, $f4, $f0, $ec, $e8, $e4, $e4, $e8, $ec, $f0, $f4, $f8, $fc, $00

; called from RunFieldEventFieldEventKind_WriteFieldEventTimerAndScrollX: branches on
; wFieldEventTimer; branches on wKeyRandomLo & $7f; sets wFieldEventTimer to $80; sets hScrollX to
; 0; branches on wFieldEventArg; branches on wFrameCounterLo & $03; sets hScrollX; increments
; wFieldEventTimer; returns unless wFieldEventTimer is $bc; copies wKeyRandomHi & $7f to
; wFieldEventTimer (E-0347)
; why: a helper of RunFieldEventFieldEventKind_WriteFieldEventTimerAndScrollX, in step 12 of
; RunFieldEventFieldEventKind (when wFieldEventKind = 12); RunFieldEventFieldEventKind: unless a
; fade runs or bit 7 of wFieldActionRequest is set, runs the field event for wFieldEventKind & $0F
; (jump table of sixteen) (E-0352, E-0124)
RunFieldEventFieldEventKind_WriteFieldEventTimerAndScrollX_2::
    ld a, [wFieldEventTimer]
    bit 7, a
    jr nz, .check_field_event_arg
    and $7f
    ld c, a
    ld a, [wKeyRandomLo]
    and $7f
    cp c
    jr nz, .loop
    ld a, $80
    ld [wFieldEventTimer], a

.loop:
    xor a
    ldh [hScrollX], a
    ret

.check_field_event_arg:
    ld a, [wFieldEventArg]
    or a
    jr nz, .loop
    ld a, [wFrameCounterLo]
    and $03
    bit 0, a
    jr nz, .check_field_event_timer
    dec a
    sla a
    ld c, a
    ldh a, [hScrollX]
    add c
    ldh [hScrollX], a

.check_field_event_timer:
    ld a, [wFieldEventTimer]
    inc a
    ld [wFieldEventTimer], a
    cp $bc
    ret nz
    ld a, [wKeyRandomHi]
    and $7f
    ld [wFieldEventTimer], a
    ret

; does nothing during a fade or while the map is loading; reads the D-pad (wJoypadHeld,
; wJoypadPressed), sets the facing hPlayerFacing and the move timer hPlayerTurnDelay, and starts or
; continues a step when the tile ahead is free (checks through TileBlockedAtPixel,
; FindSpriteSlotAtTile and UpdatePlayerMovement_ReadTriggerKindAndMapTypeEtc) (E-0030)
UpdatePlayerMovement::
    ld a, [wFadeState]
    or a
    ret nz
    ldh a, [hPlayerTurnDelay]
    or a
    jr z, .check_player_state_flags
    dec a
    ldh [hPlayerTurnDelay], a
    call RedrawScreenBufferIfPartyWindowFlagsBit7
    ret

.check_player_state_flags:
    ldh a, [hPlayerStateFlags]
    bit 0, a
    jp nz, UpdatePlayerMovement_RedrawScreenBufferIfPartyWindowFlagsBit7
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    ldh a, [hPlayerStateFlags]
    bit 6, a
    jp nz, .check_joypad_pressed2
    ld a, [wJoypadPressed]
    bit 5, a
    jr z, .check_joypad_held
    ldh a, [hPlayerFacing]
    cp $03
    jr z, .set_player_facing_to_03

.loop:
    ld a, $03
    ldh [hPlayerFacing], a
    ld a, $04
    ldh [hPlayerTurnDelay], a
    call RedrawScreenBufferIfPartyWindowFlagsBit7
    ret

.check_joypad_held:
    ld a, [wJoypadHeld]
    bit 5, a
    jr z, .check_joypad_pressed

.set_player_facing_to_03:
    ld a, $03
    ldh [hPlayerFacing], a
    ldh a, [hPlayerX]
    or a
    jr z, .check_player_state_flags3
    ld a, [wScriptRunning]
    or a
    jr nz, .check_player_state_flags2
    ldh a, [hPlayerX]
    sub $10
    ld b, a
    ldh a, [hPlayerY]
    ld c, a
    call TileBlockedAtPixel
    cp $01
    jr z, .loop
    call FindSpriteSlotAtTile
    or a
    jr nz, .loop
    call UpdatePlayerMovement_ReadTriggerKindAndMapTypeEtc
    or a
    jr nz, .loop

.check_player_state_flags2:
    ldh a, [hPlayerStateFlags]
    or $05
    ldh [hPlayerStateFlags], a
    ld hl, -16
    ld a, l
    ldh [hPlayerStepDXLo], a
    ld a, h
    ldh [hPlayerStepDXHi], a
    call SetFollowerTargetsFromLeader
    call UpdatePlayerMovement_RedrawScreenBufferIfPartyWindowFlagsBit7
    ret

.check_player_state_flags3:
    ldh a, [hPlayerStateFlags]
    or $05
    ldh [hPlayerStateFlags], a
    ld hl, hMapScreenX
    dec [hl]
    farcall CheckWarpAtPlayer
    bit 0, c
    jr nz, .loop
    ldh a, [hMapScreenX]
    cp $ff
    jr nz, .set_field_action_request_to_80
    ld a, [wMapWidthScreens]
    dec a
    ldh [hMapScreenX], a

.set_field_action_request_to_80:
    ld a, $80
    ld [wFieldActionRequest], a
    ld a, $01
    ld [wScreenScrollDir], a
    ld hl, $0090
    ld a, l
    ldh [hPlayerStepDXLo], a
    ld a, h
    ldh [hPlayerStepDXHi], a
    call UpdatePlayerMovement_RedrawScreenBufferIfPartyWindowFlagsBit7
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    bit 4, a
    jr z, .check_joypad_held2
    ldh a, [hPlayerFacing]
    cp $01
    jr z, .set_player_facing_to_01

.loop2:
    ld a, $01
    ldh [hPlayerFacing], a
    ld a, $04
    ldh [hPlayerTurnDelay], a
    call RedrawScreenBufferIfPartyWindowFlagsBit7
    ret

.check_joypad_held2:
    ld a, [wJoypadHeld]
    bit 4, a
    jr z, .check_joypad_pressed2

.set_player_facing_to_01:
    ld a, $01
    ldh [hPlayerFacing], a
    ldh a, [hPlayerX]
    cp $90
    jr z, .check_player_state_flags5
    ld a, [wScriptRunning]
    or a
    jr nz, .check_player_state_flags4
    ldh a, [hPlayerX]
    add $11
    ld b, a
    ldh a, [hPlayerY]
    ld c, a
    call TileBlockedAtPixel
    cp $01
    jr z, .loop2
    call FindSpriteSlotAtTile
    or a
    jr nz, .loop2
    call UpdatePlayerMovement_ReadTriggerKindAndMapTypeEtc
    or a
    jr nz, .loop2

.check_player_state_flags4:
    ldh a, [hPlayerStateFlags]
    or $05
    ldh [hPlayerStateFlags], a
    ld hl, $0010
    ld a, l
    ldh [hPlayerStepDXLo], a
    ld a, h
    ldh [hPlayerStepDXHi], a
    call SetFollowerTargetsFromLeader
    call UpdatePlayerMovement_RedrawScreenBufferIfPartyWindowFlagsBit7
    ret

.check_player_state_flags5:
    ldh a, [hPlayerStateFlags]
    or $05
    ldh [hPlayerStateFlags], a
    ld hl, hMapScreenX
    inc [hl]
    farcall CheckWarpAtPlayer
    bit 0, c
    jr nz, .loop2
    ld a, [wMapWidthScreens]
    ld c, a
    ldh a, [hMapScreenX]
    cp c
    jr nz, .set_field_action_request_to_802
    xor a
    ldh [hMapScreenX], a

.set_field_action_request_to_802:
    ld a, $80
    ld [wFieldActionRequest], a
    ld a, $02
    ld [wScreenScrollDir], a
    ld hl, -144
    ld a, l
    ldh [hPlayerStepDXLo], a
    ld a, h
    ldh [hPlayerStepDXHi], a
    call UpdatePlayerMovement_RedrawScreenBufferIfPartyWindowFlagsBit7
    ret

.check_joypad_pressed2:
    ld a, [wJoypadPressed]
    bit 7, a
    jr z, .check_joypad_held3
    ldh a, [hPlayerFacing]
    cp $00
    jr z, .set_player_facing_to_00

.loop3:
    ld a, $00
    ldh [hPlayerFacing], a
    ld a, $04
    ldh [hPlayerTurnDelay], a
    call RedrawScreenBufferIfPartyWindowFlagsBit7
    ret

.check_joypad_held3:
    ld a, [wJoypadHeld]
    bit 7, a
    jp z, .check_joypad_pressed3

.set_player_facing_to_00:
    ld a, $00
    ldh [hPlayerFacing], a
    farcall CheckWarpAtPlayer
    bit 0, c
    jr nz, .loop3
    ldh a, [hPlayerY]
    cp $80
    jr z, .check_player_state_flags7
    ldh a, [hPlayerStateFlags]
    bit 6, a
    jr nz, .check_player_state_flags6
    ld a, [wScriptRunning]
    or a
    jr nz, .check_player_state_flags6
    ldh a, [hPlayerX]
    ld b, a
    ldh a, [hPlayerY]
    add $11
    ld c, a
    call TileBlockedAtPixel
    cp $01
    jr z, .loop3
    call FindSpriteSlotAtTile
    or a
    jr nz, .loop3
    call UpdatePlayerMovement_ReadTriggerKindAndMapTypeEtc
    or a
    jr nz, .loop3

.check_player_state_flags6:
    ldh a, [hPlayerStateFlags]
    or $05
    ldh [hPlayerStateFlags], a
    ld hl, $0010
    ldh a, [hPlayerStateFlags]
    bit 6, a
    jr z, .set_player_step_dy_lo
    ld hl, $0008

.set_player_step_dy_lo:
    ld a, l
    ldh [hPlayerStepDYLo], a
    ld a, h
    ldh [hPlayerStepDYHi], a
    call SetFollowerTargetsFromLeader
    call UpdatePlayerMovement_RedrawScreenBufferIfPartyWindowFlagsBit7
    ret

.check_player_state_flags7:
    ldh a, [hPlayerStateFlags]
    or $05
    ldh [hPlayerStateFlags], a
    ld hl, hMapScreenY
    inc [hl]
    farcall CheckWarpAtPlayer
    bit 0, c
    jp nz, .loop3
    farcall WarpToLinkedMapForCurrentMap
    bit 0, c
    jp nz, .loop3
    ld a, [wMapHeightScreens]
    ld c, a
    ldh a, [hMapScreenY]
    cp c
    jr nz, .set_field_action_request_to_803
    xor a
    ldh [hMapScreenY], a

.set_field_action_request_to_803:
    ld a, $80
    ld [wFieldActionRequest], a
    ld a, $08
    ld [wScreenScrollDir], a
    ld hl, -128
    ld a, l
    ldh [hPlayerStepDYLo], a
    ld a, h
    ldh [hPlayerStepDYHi], a
    call UpdatePlayerMovement_RedrawScreenBufferIfPartyWindowFlagsBit7

.check_joypad_pressed3:
    ld a, [wJoypadPressed]
    bit 6, a
    jr z, .check_joypad_held4
    ldh a, [hPlayerFacing]
    cp $02
    jr z, .set_player_facing_to_02

.loop4:
    ld a, $02
    ldh [hPlayerFacing], a
    ld a, $04
    ldh [hPlayerTurnDelay], a
    call RedrawScreenBufferIfPartyWindowFlagsBit7
    ret

.check_joypad_held4:
    ld a, [wJoypadHeld]
    bit 6, a
    ret z

.set_player_facing_to_02:
    ld a, $02
    ldh [hPlayerFacing], a
    ldh a, [hPlayerY]
    or a
    jr z, .check_player_state_flags9
    farcall CheckWarpAtPlayer
    bit 0, c
    jr nz, .loop4
    ldh a, [hPlayerStateFlags]
    bit 6, a
    jr nz, .check_player_state_flags8
    ld a, [wScriptRunning]
    or a
    jr nz, .check_player_state_flags8
    ldh a, [hPlayerX]
    ld b, a
    ldh a, [hPlayerY]
    sub $10
    ld c, a
    call TileBlockedAtPixel
    cp $01
    jr z, .loop4
    call FindSpriteSlotAtTile
    or a
    jr nz, .loop4
    call UpdatePlayerMovement_ReadTriggerKindAndMapTypeEtc
    or a
    jr nz, .loop4

.check_player_state_flags8:
    ldh a, [hPlayerStateFlags]
    or $05
    ldh [hPlayerStateFlags], a
    ld hl, hSndNoteTimer
    ldh a, [hPlayerStateFlags]
    bit 6, a
    jr z, .set_player_step_dy_lo2
    ld hl, -8

.set_player_step_dy_lo2:
    ld a, l
    ldh [hPlayerStepDYLo], a
    ld a, h
    ldh [hPlayerStepDYHi], a
    call SetFollowerTargetsFromLeader
    call UpdatePlayerMovement_RedrawScreenBufferIfPartyWindowFlagsBit7
    ret

.check_player_state_flags9:
    ldh a, [hPlayerStateFlags]
    or $05
    ldh [hPlayerStateFlags], a
    ld hl, hMapScreenY
    dec [hl]
    farcall CheckWarpAtPlayer
    bit 0, c
    jp nz, .loop4
    ldh a, [hMapScreenY]
    cp $ff
    jr nz, .set_field_action_request_to_804
    ld a, [wMapHeightScreens]
    dec a
    ldh [hMapScreenY], a

.set_field_action_request_to_804:
    ld a, $80
    ld [wFieldActionRequest], a
    ld a, $04
    ld [wScreenScrollDir], a
    ld hl, $0080
    ld a, l
    ldh [hPlayerStepDYLo], a
    ld a, h
    ldh [hPlayerStepDYHi], a
    call UpdatePlayerMovement_RedrawScreenBufferIfPartyWindowFlagsBit7
    ret

; called from UpdatePlayerMovement: calls RedrawScreenBufferIfPartyWindowFlagsBit7; copies
; hPlayerStateFlags & $fe to hPlayerStateFlags; sets wStepTriggerFlag to 0; branches on h; copies
; hPlayerStateFlags & $fa to hPlayerStateFlags; sets wStepTriggerFlag to 0; branches on
; wFieldActionRequest; calls StepFollowersTowardTargets; copies L to hPlayerStepDXLo; copies H to
; hPlayerStepDXHi; decrements hPlayerX; calls UpdatePlayerMovement_WaitFollowerDelay; then 54 more
; steps (see the code) (E-0347)
; why: a helper of UpdatePlayerMovement; UpdatePlayerMovement: does nothing during a fade or while
; the map is loading (E-0352)
UpdatePlayerMovement_RedrawScreenBufferIfPartyWindowFlagsBit7::
    call RedrawScreenBufferIfPartyWindowFlagsBit7
    ldh a, [hPlayerStepDXLo]
    ld l, a
    ldh a, [hPlayerStepDXHi]
    ld h, a
    ld a, h
    or l
    jr nz, .read_player_step_dx_lo
    ldh a, [hPlayerStepDYLo]
    ld l, a
    ldh a, [hPlayerStepDYHi]
    ld h, a
    ld a, h
    or l
    jr nz, .read_player_step_dx_lo
    ldh a, [hPlayerStateFlags]
    and $fe
    ldh [hPlayerStateFlags], a
    xor a
    ld [wStepTriggerFlag], a
    jp .call_update_player_movement_test_flag_bit

.read_player_step_dx_lo:
    ldh a, [hPlayerStepDXLo]
    ld l, a
    ldh a, [hPlayerStepDXHi]
    ld h, a
    bit 7, h
    jr nz, .check_field_action_request
    ld a, h
    or l
    jr nz, .check_field_action_request2
    ldh a, [hPlayerStepDYLo]
    ld l, a
    ldh a, [hPlayerStepDYHi]
    ld h, a
    bit 7, h
    jp nz, .check_field_action_request3
    ld a, h
    or l
    jp nz, .check_field_action_request4
    ldh a, [hPlayerStateFlags]
    and $fa
    ldh [hPlayerStateFlags], a
    xor a
    ld [wStepTriggerFlag], a
    ret

.check_field_action_request:
    ld a, [wFieldActionRequest]
    bit 7, a
    jr nz, .call_update_player_movement_wait_follower
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
    jp .read_player_step_dx_lo2

.call_update_player_movement_wait_follower:
    call UpdatePlayerMovement_WaitFollowerDelay
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
    sub $08
    ldh [hPlayerX], a
    ld a, [wFollowerRecords + $1]
    sub $08
    ld [wFollowerRecords + $1], a
    ld a, [wFollowerRecords + $6]
    sub $08
    ld [wFollowerRecords + $6], a
    ld a, [wFollowerRecords + $b]
    sub $08
    ld [wFollowerRecords + $b], a
    call SetFollowerTargetsFromLeader
    call StepFollowersTowardTargets
    jp .read_player_step_dx_lo2

.check_field_action_request2:
    ld a, [wFieldActionRequest]
    bit 7, a
    jr nz, .call_update_player_movement_wait_follower2
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
    jp .read_player_step_dx_lo2

.call_update_player_movement_wait_follower2:
    call UpdatePlayerMovement_WaitFollowerDelay
    ldh a, [hPlayerStepDXLo]
    ld l, a
    ldh a, [hPlayerStepDXHi]
    ld h, a
    ld a, l
    sub $08
    ld l, a
    ld a, h
    sbc $00
    ld h, a
    ld a, l
    ldh [hPlayerStepDXLo], a
    ld a, h
    ldh [hPlayerStepDXHi], a
    ldh a, [hPlayerX]
    add $08
    ldh [hPlayerX], a
    ld a, [wFollowerRecords + $1]
    add $08
    ld [wFollowerRecords + $1], a
    ld a, [wFollowerRecords + $6]
    add $08
    ld [wFollowerRecords + $6], a
    ld a, [wFollowerRecords + $b]
    add $08
    ld [wFollowerRecords + $b], a
    call SetFollowerTargetsFromLeader
    call StepFollowersTowardTargets
    jp .read_player_step_dx_lo2

.check_field_action_request3:
    ld a, [wFieldActionRequest]
    bit 7, a
    jr nz, .call_update_player_movement_wait_follower3
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
    jp .read_player_step_dx_lo2

.call_update_player_movement_wait_follower3:
    call UpdatePlayerMovement_WaitFollowerDelay
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
    sub $08
    ldh [hPlayerY], a
    ld a, [wFollowerRecords + $2]
    sub $08
    ld [wFollowerRecords + $2], a
    ld a, [wFollowerRecords + $7]
    sub $08
    ld [wFollowerRecords + $7], a
    ld a, [wFollowerRecords + $c]
    sub $08
    ld [wFollowerRecords + $c], a
    call SetFollowerTargetsFromLeader
    call StepFollowersTowardTargets
    jr .read_player_step_dx_lo2

.check_field_action_request4:
    ld a, [wFieldActionRequest]
    bit 7, a
    jr nz, .call_update_player_movement_wait_follower4
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
    jr .read_player_step_dx_lo2

.call_update_player_movement_wait_follower4:
    call UpdatePlayerMovement_WaitFollowerDelay
    ldh a, [hPlayerStepDYLo]
    ld l, a
    ldh a, [hPlayerStepDYHi]
    ld h, a
    ld a, l
    sub $08
    ld l, a
    ld a, h
    sbc $00
    ld h, a
    ld a, l
    ldh [hPlayerStepDYLo], a
    ld a, h
    ldh [hPlayerStepDYHi], a
    ldh a, [hPlayerY]
    add $08
    ldh [hPlayerY], a
    ld a, [wFollowerRecords + $2]
    add $08
    ld [wFollowerRecords + $2], a
    ld a, [wFollowerRecords + $7]
    add $08
    ld [wFollowerRecords + $7], a
    ld a, [wFollowerRecords + $c]
    add $08
    ld [wFollowerRecords + $c], a
    call SetFollowerTargetsFromLeader
    call StepFollowersTowardTargets

.read_player_step_dx_lo2:
    ldh a, [hPlayerStepDXLo]
    ld l, a
    ldh a, [hPlayerStepDXHi]
    ld h, a
    ld a, h
    or l
    ret nz
    ldh a, [hPlayerStepDYLo]
    ld l, a
    ldh a, [hPlayerStepDYHi]
    ld h, a
    ld a, h
    or l
    ret nz
    ld a, $01
    ld [wMapToggleRequest], a
    ldh a, [hPlayerStateFlags]
    bit 6, a
    jr z, .set_player_state_flags
    and $7f

.set_player_state_flags:
    and $ba
    ldh [hPlayerStateFlags], a
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    xor a
    ld [wStepTriggerFlag], a

.call_update_player_movement_test_flag_bit:
    farcall UpdatePlayerMovement_TestFlagBit
    farcall AdvanceStepCounterAndUpdateStoredRecords
    farcall RunPeriodicFieldEventChecks
    farcall UpdatePlayerMovement_WaitPlayerSpriteOverride
    farcall TickRandomEncounterCounter
    farcall CheckStepTriggerAndDispatchTalk
    farcall CheckWarpsAtPlayerPosition
    farcall RunPlayerMoveTypeMapMoveType
    farcall EnterStatusEffectFieldState
    farcall CountDownTalkCountdownThenDispatchTalkEvent
    ret

; Returns if wFollowerDelay is 0; copies hPlayerFacing to wFollowerRecords (E-0347)
; why: part of UpdatePlayerMovement; UpdatePlayerMovement: does nothing during a fade or while the
; map is loading (E-0352)
UpdatePlayerMovement_WaitFollowerDelay::
    ld a, [wFollowerDelay]
    or a
    ret z
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $a], a
    ldh a, [hPlayerX]
    ld [wFollowerRecords + $1], a
    ld [wFollowerRecords + $6], a
    ld [wFollowerRecords + $b], a
    ldh a, [hPlayerY]
    ld [wFollowerRecords + $2], a
    ld [wFollowerRecords + $7], a
    ld [wFollowerRecords + $c], a
    ret

; the three 5-byte follower records at wFollowerRecords hold direction, X, Y, target X, target Y:
; record 0's target = hPlayerX/hPlayerY, record 1's target = record 0's position, record 2's target
; = record 1's position (E-0093)
SetFollowerTargetsFromLeader::
    ldh a, [hPlayerX]
    ld [wFollowerRecords + $3], a
    ldh a, [hPlayerY]
    ld [wFollowerRecords + $4], a
    ld a, [wFollowerRecords + $1]
    ld [wFollowerRecords + $8], a
    ld a, [wFollowerRecords + $2]
    ld [wFollowerRecords + $9], a
    ld a, [wFollowerRecords + $6]
    ld [wFollowerRecords + $d], a
    ld a, [wFollowerRecords + $7]
    ld [wFollowerRecords + $e], a
    ret

; unless wFollowerDelay is non-zero, moves each of the three follower records one pixel toward its
; target (four pixels when wFieldActionRequest bit 7 is set), X first and then Y, storing the
; direction moved in byte 0 (1 = X increasing, 3 = X decreasing; Y directions not read to the end)
; (E-0093)
; code: returns unless wFollowerDelay is 0; branches on the byte at wFollowerRecords + $3; branches
; on c; branches on the byte at wFollowerRecords + $3; branches on c; sets wFollowerRecords to 2;
; branches on c; sets wFollowerRecords to 0; branches on c (E-0347)
StepFollowersTowardTargets::
    ld a, [wFollowerDelay]
    or a
    ret nz
    ld b, $03
    ld hl, wFollowerRecords
    ld de, wFollowerRecords + $3

.loop:
    push hl
    push de
    inc hl
    ld a, [hld]
    ld c, a
    ld a, [de]
    cp c
    jr z, .next
    jr nc, .skip2
    ld a, $03
    ld [hli], a
    ld a, c
    dec a
    push af
    ld a, [wFieldActionRequest]
    ld c, a
    pop af
    bit 7, c
    jr z, .skip
    sub $03

.skip:
    ld [hl], a
    jr .restore

.skip2:
    ld a, $01
    ld [hli], a
    ld a, c
    inc a
    push af
    ld a, [wFieldActionRequest]
    ld c, a
    pop af
    bit 7, c
    jr z, .skip3
    add $03

.skip3:
    ld [hl], a
    jr .restore

.next:
    inc hl
    inc hl
    ld a, [hl]
    ld c, a
    inc de
    ld a, [de]
    cp c
    jr z, .restore
    jr nc, .skip5
    ld a, c
    dec a
    push af
    ld a, [wFieldActionRequest]
    ld c, a
    pop af
    bit 7, c
    jr z, .skip4
    sub $03

.skip4:
    ld [hl], a
    dec hl
    dec hl
    ld [hl], $02
    jr .restore

.skip5:
    ld a, c
    inc a
    push af
    ld a, [wFieldActionRequest]
    ld c, a
    pop af
    bit 7, c
    jr z, .skip6
    add $03

.skip6:
    ld [hl], a
    dec hl
    dec hl
    ld [hl], $00

.restore:
    pop de
    pop hl
    ld a, $05
    add_a_to_hl
    ld a, $05
    add e
    ld e, a
    jr nc, .next2
    inc d

.next2:
    dec b
    jr nz, .loop
    ret

; B = X, C = Y in pixels: copies the four tile ids of the 2 x 2 block at tile (X / 8, Y / 8) of
; wScreenTileBuffer (rows of 20) to wTilesUnderPoint-wTilesUnderPoint + $3; returns A = 1 when any
; of them is at most wMaxBlockingTile, else A = 0 (a different pair of comparisons with
; wMapTallTileMin runs when hPlayerStateFlags bit 3 is set) (E-0030)
TileBlockedAtPixel::
    push bc
    push de
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr nz, .skip

.skip:
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
    add $98
    ld l, a
    ld a, h
    adc $c1
    ld h, a
    ld a, [hli]
    ld [wTilesUnderPoint], a
    ld a, [hld]
    ld [wTilesUnderPoint + $1], a
    ld a, $14
    add_a_to_hl
    ld a, [hli]
    ld [wTilesUnderPoint + $2], a
    ld a, [hl]
    ld [wTilesUnderPoint + $3], a
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr nz, .skip3
    ld de, wTilesUnderPoint
    ld b, $04

.loop:
    ld a, [de]
    inc de
    ld c, a
    ld a, [wMaxBlockingTile]
    cp c
    jr c, .next
    jr .skip2

.next:
    dec b
    jr nz, .loop
    xor a
    pop de
    pop bc
    ret

.skip2:
    ld a, $01
    pop de
    pop bc
    ret

.skip3:
    ld de, wTilesUnderPoint
    ld b, $02

.loop2:
    ld a, [de]
    inc de
    ld c, a
    ld a, [wMapTallTileMin]
    cp c
    jr nc, .next2
    jr .skip4

.next2:
    dec b
    jr nz, .loop2
    xor a
    pop de
    pop bc
    ret

.skip4:
    ld a, $01
    pop de
    pop bc
    ret

; B = X, C = Y in pixels: returns A = the 1-based number of the first slot of wSpriteSlots (from
; wSpriteSlots + $B, count wSpriteSlotCount) whose X and Y bytes, or those plus 15, lie in the same
; 16-pixel cell as (B, C); A = 0 when none does (E-0351)
FindSpriteSlotAtTile::
    ld a, [wSpriteSlotCount]
    or a
    ret z
    push bc
    ld a, c
    swap a
    and $0f
    ldh [hTemp0], a
    ld a, b
    swap a
    and $0f
    ldh [hTemp1], a
    ld a, [wSpriteSlotCount]
    ld b, a
    ld c, $01
    ld hl, wSpriteSlots + $b

.loop:
    push hl
    push bc
    ld a, [hl]
    swap a
    and $0f
    ld c, a
    ldh a, [hTemp1]
    cp c
    jr z, .next
    ld a, [hl]
    add $0f
    swap a
    and $0f
    ld c, a
    ldh a, [hTemp1]
    cp c
    jr nz, .restore

.next:
    inc hl
    ld a, [hl]
    swap a
    and $0f
    ld c, a
    ldh a, [hTemp0]
    cp c
    jr z, .restore2
    ld a, [hl]
    add $0f
    swap a
    and $0f
    ld c, a
    ldh a, [hTemp0]
    cp c
    jr z, .restore2

.restore:
    pop bc
    inc c
    pop hl
    ld a, $10
    add_a_to_hl
    dec b
    jr nz, .loop
    xor a
    pop bc
    ret

.restore2:
    pop bc
    pop hl
    ld a, c
    pop bc
    ret

; called from UpdatePlayerMovement: takes BC; changes HL, BC and A; branches on wTriggerKind;
; branches on wMapType; branches on wTriggerCell & $0f; branches on $01; branches on the byte at
; UpdatePlayerMovement_ReadTriggerKindAndMapTypeEtc_Data (E-0347)
; why: a helper of UpdatePlayerMovement; UpdatePlayerMovement: does nothing during a fade or while
; the map is loading (E-0352)
UpdatePlayerMovement_ReadTriggerKindAndMapTypeEtc::
    push bc
    ld a, [wTriggerKind]
    cp $02
    jr z, .skip
    cp $03
    jr z, .skip

.loop:
    xor a
    pop bc
    ret

.skip:
    ld a, b
    swap a
    and $0f
    ld b, a
    ld a, c
    swap a
    and $0f
    ld c, a
    ld a, [wMapType]
    bit 7, a
    jr nz, .cp_85

.loop2:
    ld a, [wTriggerCell]
    swap a
    and $0f
    cp b
    jr nz, .loop
    ld a, [wTriggerCell]
    and $0f
    cp c
    jr nz, .loop
    ld a, $01
    pop bc
    ret

.cp_85:
    cp $85
    jr z, .loop2
    ld a, [wTriggerCell]
    add a
    ld hl, UpdatePlayerMovement_ReadTriggerKindAndMapTypeEtc_Data
    add_a_to_hl
    ld a, [hli]
    cp b
    jr nz, .loop
    ld a, [hl]
    cp c
    jr nz, .loop
    ld a, $01
    pop bc
    ret

; data read by UpdatePlayerMovement (32 bytes) (E-0347)
UpdatePlayerMovement_ReadTriggerKindAndMapTypeEtc_Data::
    db $01, $02, $01, $07, $02, $01, $02, $04, $02, $06, $03, $03, $04, $05, $04, $07
    db $05, $01, $05, $03, $06, $05, $07, $02, $07, $04, $07, $07, $08, $01, $08, $06

; called from FieldState_WalkATalks: returns unless wFadeState is 0; returns if bit 0 of
; hPlayerStateFlags is set; returns unless bit 7 of wJoypadHeld is set; branches on the byte at
; FieldState_WalkATalks_WaitFadeState_Data; branches on hPlayerX; branches on hPlayerY; sets
; wTalkEventGroup; sets wTalkEventIndex to 0; calls DispatchTalkEvent; sets wJoypadHeld to 0; sets
; wJoypadPressed to 0 (E-0347)
; why: a helper of FieldState_WalkATalks; FieldState_WalkATalks: field state 0: walking on a map
; (E-0352, E-0339)
FieldState_WalkATalks_WaitFadeState::
    ld a, [wFadeState]
    or a
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
    or d
    ld d, a
    ldh a, [hMapId]
    ld e, a
    ld hl, FieldState_WalkATalks_WaitFadeState_Data
    ld b, $00

.skip:
    push hl
    ld a, [hli]
    cp $ff
    jr nz, .skip2
    pop hl
    ret

.skip2:
    cp e
    jr nz, .restore
    ld a, [hli]
    cp d
    jr nz, .restore
    ld a, [hli]
    ld c, a
    ldh a, [hPlayerX]
    cp c
    jr nz, .restore
    ld a, [hl]
    ld c, a
    ldh a, [hPlayerY]
    cp c
    jr nz, .restore
    ld a, b
    add $10
    ld [wTalkEventGroup], a
    xor a
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    xor a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    pop hl
    ret

.restore:
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    inc b
    jr .skip

; data read by FieldState_WalkATalks_WaitFadeState (21 bytes) (E-0347)
FieldState_WalkATalks_WaitFadeState_Data::
    db $01, $11, $70, $70, $01, $11, $70, $20, $01, $10, $70, $50, $1a, $10, $70, $70
    db $85, $10, $50, $60, $ff

; clears wPartyWindowTimer; if bit 7 of wPartyWindowFlags is set, draws the full screen buffer to
; the BG map at the scroll position and clears wPartyWindowFlags and wPartyWindowTimer (E-0121)
RedrawScreenBufferIfPartyWindowFlagsBit7::
    xor a
    ld [wPartyWindowTimer], a
    ld a, [wPartyWindowFlags]
    bit 7, a
    ret z
    ld hl, vBGMap0
    ldh a, [hScrollY]
    and $f8
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, h
    and $9b
    ld h, a
    ldh a, [hScrollX]
    srl a
    srl a
    srl a
    add_a_to_hl
    call DrawFullScreenBufferToBGMap
    xor a
    ld [wPartyWindowFlags], a
    ld [wPartyWindowTimer], a
    ret

; if bit 7 of wFieldActionRequest is set, runs the routine for wFieldActionRequest & 3 (jump table)
; (E-0122)
RunFieldActionRequestActionIfBit7::
    ld a, [wFieldActionRequest]
    bit 7, a
    ret z
    and $03
    jumptable
    dw RunFieldActionRequestActionIfBit7_LoadMapScreenAndStep
    dw RunFieldActionRequestActionIfBit7_WriteScrollXAndScrollY
    dw RunFieldActionRequestActionIfBit7_FindTriggerEntryForCurrentScreen
    dw RunFieldActionRequestActionIfBit7_AdvanceStepCounterAndUpdateStoredRecords

; step 0 of RunFieldActionRequestActionIfBit7: calls LoadMapScreen; sets wFieldActionStep to 0;
; increments wFieldActionRequest (E-0347)
; why: step 0 of RunFieldActionRequestActionIfBit7; RunFieldActionRequestActionIfBit7: if bit 7 of
; wFieldActionRequest is set, runs the routine for wFieldActionRequest & 3 (jump table) (E-0352,
; E-0122)
RunFieldActionRequestActionIfBit7_LoadMapScreenAndStep::
    call LoadMapScreen
    xor a
    ld [wFieldActionStep], a
    ld hl, wFieldActionRequest
    inc [hl]
    ret

; step 3 of RunFieldActionRequestActionIfBit7: sets wStepTriggerFlag to 0; calls
; AdvanceStepCounterAndUpdateStoredRecords; calls RunPeriodicFieldEventChecks; calls
; TickRandomEncounterCounter; calls CheckWarpsAtPlayerPosition; calls RunPlayerMoveTypeMapMoveType;
; calls EnterStatusEffectFieldState; calls CountDownTalkCountdownThenDispatchTalkEvent; sets
; wFieldActionRequest to 0 (E-0347)
; why: step 3 of RunFieldActionRequestActionIfBit7; RunFieldActionRequestActionIfBit7: if bit 7 of
; wFieldActionRequest is set, runs the routine for wFieldActionRequest & 3 (jump table) (E-0352,
; E-0122)
RunFieldActionRequestActionIfBit7_AdvanceStepCounterAndUpdateStoredRecords::
    xor a
    ld [wStepTriggerFlag], a
    farcall AdvanceStepCounterAndUpdateStoredRecords
    farcall RunPeriodicFieldEventChecks
    farcall TickRandomEncounterCounter
    farcall CheckWarpsAtPlayerPosition
    farcall RunPlayerMoveTypeMapMoveType
    farcall EnterStatusEffectFieldState
    farcall CountDownTalkCountdownThenDispatchTalkEvent
    xor a
    ld [wFieldActionRequest], a
    ret

; step 2 of RunFieldActionRequestActionIfBit7: increments wFieldActionRequest; calls
; FindTriggerEntryForCurrentScreen; calls FindTriggerEntryForCurrentScreen_ScreenTriggers; calls
; LoadMapObjectsForScreen; branches on wPendingFieldEvent; sets wPendingFieldEvent to 0; calls
; ClearPendingFieldEventWhenFieldIdle; sets wObject5 to 0; calls PlaceSpecialMapObjectsOnEntry
; (E-0347)
; why: step 2 of RunFieldActionRequestActionIfBit7; RunFieldActionRequestActionIfBit7: if bit 7 of
; wFieldActionRequest is set, runs the routine for wFieldActionRequest & 3 (jump table) (E-0352,
; E-0122)
RunFieldActionRequestActionIfBit7_FindTriggerEntryForCurrentScreen::
    ld hl, wFieldActionRequest
    inc [hl]
    farcall FindTriggerEntryForCurrentScreen
    farcall FindTriggerEntryForCurrentScreen_ScreenTriggers
    farcall LoadMapObjectsForScreen
    ld a, [wPendingFieldEvent]
    bit 7, a
    jr z, .call_clear_pending_field_event_when_field
    bit 6, a
    jr nz, .call_clear_pending_field_event_when_field
    xor a
    ld [wPendingFieldEvent], a
    jr .clear_object5

.call_clear_pending_field_event_when_field:
    farcall ClearPendingFieldEventWhenFieldIdle

.clear_object5:
    xor a
    ld [wObject5], a
    farcall PlaceSpecialMapObjectsOnEntry
    ret

; step 1 of RunFieldActionRequestActionIfBit7: branches on wScreenScrollDir; calls
; RunFieldActionRequestActionIfBit7_WriteBGWriteDestLoAndBGWriteDestHiEtc; sets hScrollX; advances
; wFieldActionStep; branches on wFieldActionStep; calls ComputeSpriteScrollOffsets; copies hScrollX
; & $f8 to hScrollX; calls MarkVisitedMapScreenInVisitedScreens; increments wFieldActionRequest;
; calls ComputeSpriteScrollOffsets; calls
; RunFieldActionRequestActionIfBit7_WriteBGWriteDestLoAndBGWriteDestHiEtc; sets hScrollX; then 26
; more steps (see the code) (E-0347)
; why: step 1 of RunFieldActionRequestActionIfBit7; RunFieldActionRequestActionIfBit7: if bit 7 of
; wFieldActionRequest is set, runs the routine for wFieldActionRequest & 3 (jump table) (E-0352,
; E-0122)
RunFieldActionRequestActionIfBit7_WriteScrollXAndScrollY::
    ldh a, [hScrollY]
    and $f8
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add $00
    ld e, a
    ld a, d
    adc $98
    ld d, a
    ldh a, [hScrollX]
    srl a
    srl a
    srl a
    add e
    ld e, a
    jr nc, .check_screen_scroll_dir
    inc d

.check_screen_scroll_dir:
    ld a, [wScreenScrollDir]
    bit 1, a
    jr z, .check_bit0
    ld a, e
    add $14
    and $1f
    ld c, a
    ld a, e
    and $e0
    or c
    ld e, a
    ld hl, wScreenTileBuffer
    ld a, [wFieldActionStep]
    add_a_to_hl
    call RunFieldActionRequestActionIfBit7_WriteBGWriteDestLoAndBGWriteDestHiEtc
    ldh a, [hScrollX]
    add $08
    ldh [hScrollX], a
    ld hl, wFieldActionStep
    inc [hl]
    ld a, [wFieldActionStep]
    cp $14
    jr nc, .check_scroll_x
    call ComputeSpriteScrollOffsets
    ret

.check_scroll_x:
    ldh a, [hScrollX]
    and $f8
    ldh [hScrollX], a
    farcall MarkVisitedMapScreenInVisitedScreens
    ld hl, wFieldActionRequest
    inc [hl]
    call ComputeSpriteScrollOffsets
    ret

.check_bit0:
    bit 0, a
    jr z, .check_bit3
    ld a, e
    dec a
    and $1f
    ld c, a
    ld a, e
    and $e0
    or c
    ld e, a
    ld hl, wScreenTileBuffer
    ld a, [wFieldActionStep]
    ld c, a
    ld a, $13
    sub c
    add_a_to_hl
    call RunFieldActionRequestActionIfBit7_WriteBGWriteDestLoAndBGWriteDestHiEtc
    ldh a, [hScrollX]
    sub $08
    ldh [hScrollX], a
    ld hl, wFieldActionStep
    inc [hl]
    ld a, [wFieldActionStep]
    cp $14
    jr nc, .check_scroll_x2
    call ComputeSpriteScrollOffsets
    ret

.check_scroll_x2:
    ldh a, [hScrollX]
    and $f8
    ldh [hScrollX], a
    farcall MarkVisitedMapScreenInVisitedScreens
    ld hl, wFieldActionRequest
    inc [hl]
    call ComputeSpriteScrollOffsets
    ret

.check_bit3:
    bit 3, a
    jr z, .check_bit2
    ld a, e
    add $40
    ld e, a
    ld a, d
    adc $02
    ld d, a
    ld a, d
    and $9b
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
    add $98
    ld l, a
    ld a, h
    adc $c1
    ld h, a
    call RunFieldActionRequestActionIfBit7_SetBGWriteDestLo
    ldh a, [hScrollY]
    add $08
    ldh [hScrollY], a
    ld hl, wFieldActionStep
    inc [hl]
    ld a, [wFieldActionStep]
    cp $12
    jr nc, .check_scroll_y
    call ComputeSpriteScrollOffsets
    ret

.check_scroll_y:
    ldh a, [hScrollY]
    and $f8
    ldh [hScrollY], a
    farcall MarkVisitedMapScreenInVisitedScreens
    ld hl, wFieldActionRequest
    inc [hl]
    call ComputeSpriteScrollOffsets
    ret

.check_bit2:
    bit 2, a
    jr z, .return
    ld a, e
    sub $20
    ld e, a
    ld a, d
    sbc $00
    ld d, a
    ld a, d
    cp $97
    jr nz, .read_field_action_step
    ld a, e
    add $00
    ld e, a
    ld a, d
    adc $04
    ld d, a

.read_field_action_step:
    ld a, [wFieldActionStep]
    ld c, a
    ld a, $11
    sub c
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add_a_to_hl
    add hl, hl
    add hl, hl
    ld a, l
    add $98
    ld l, a
    ld a, h
    adc $c1
    ld h, a
    call RunFieldActionRequestActionIfBit7_SetBGWriteDestLo
    ldh a, [hScrollY]
    sub $08
    ldh [hScrollY], a
    ld hl, wFieldActionStep
    inc [hl]
    ld a, [wFieldActionStep]
    cp $12
    jr nc, .check_scroll_y2
    call ComputeSpriteScrollOffsets
    ret

.check_scroll_y2:
    ldh a, [hScrollY]
    and $f8
    ldh [hScrollY], a
    farcall MarkVisitedMapScreenInVisitedScreens
    ld hl, wFieldActionRequest
    inc [hl]
    call ComputeSpriteScrollOffsets

.return:
    ret

; called from RunFieldActionRequestActionIfBit7_WriteScrollXAndScrollY: copies E to wBGWriteDestLo;
; copies D to wBGWriteDestHi; sets wBGWriteVertical to 1; sets wBGWriteCount to $12; returns if
; wIsCGB is 0; copies E to wAttrWriteDestLo; copies D to wAttrWriteDestHi; sets wAttrWriteVertical
; to 1; sets wAttrWriteCount to $12; sets rSVBK to 2; sets hTemp0; sets rSVBK to 0; then 1 more step
; (see the code) (E-0347)
; why: a helper of RunFieldActionRequestActionIfBit7_WriteScrollXAndScrollY, in step 1 of
; RunFieldActionRequestActionIfBit7; RunFieldActionRequestActionIfBit7: if bit 7 of
; wFieldActionRequest is set, runs the routine for wFieldActionRequest & 3 (jump table) (E-0352,
; E-0122)
RunFieldActionRequestActionIfBit7_WriteBGWriteDestLoAndBGWriteDestHiEtc::
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

.loop:
    ld a, [hl]
    ld [de], a
    ld a, $14
    add_a_to_hl
    inc de
    dec b
    jr nz, .loop
    pop de
    pop hl
    ld a, [wIsCGB]
    or a
    ret z
    ld a, e
    ld [wAttrWriteDestLo], a
    ld a, d
    ld [wAttrWriteDestHi], a
    ld a, $01
    ld [wAttrWriteVertical], a
    ld a, $12
    ld [wAttrWriteCount], a
    ld de, $0e68
    add hl, de
    ld b, $12
    ld de, wAttrWriteData

.loop2:
    ld a, $02
    ldh [rSVBK], a
    ld a, [hl]
    ldh [hTemp0], a
    ld a, $00
    ldh [rSVBK], a
    ldh a, [hTemp0]
    and $07
    ld [de], a
    ld a, $14
    add_a_to_hl
    inc de
    dec b
    jr nz, .loop2
    ret

; called from RunFieldActionRequestActionIfBit7_WriteScrollXAndScrollY: copies E to wBGWriteDestLo;
; copies D to wBGWriteDestHi; sets wBGWriteVertical to 0; sets wBGWriteCount to $14; returns if
; wIsCGB is 0; copies E to wAttrWriteDestLo; copies D to wAttrWriteDestHi; sets wAttrWriteVertical
; to 0; sets wAttrWriteCount to $14; sets rSVBK to 2; sets hTemp0; sets rSVBK to 0; then 1 more step
; (see the code) (E-0347)
; why: a helper of RunFieldActionRequestActionIfBit7_WriteScrollXAndScrollY, in step 1 of
; RunFieldActionRequestActionIfBit7; RunFieldActionRequestActionIfBit7: if bit 7 of
; wFieldActionRequest is set, runs the routine for wFieldActionRequest & 3 (jump table) (E-0352,
; E-0122)
RunFieldActionRequestActionIfBit7_SetBGWriteDestLo::
    ld a, e
    ld [wBGWriteDestLo], a
    ld a, d
    ld [wBGWriteDestHi], a
    xor a
    ld [wBGWriteVertical], a
    ld a, $14
    ld [wBGWriteCount], a
    push hl
    push de
    ld b, $14
    ld de, wBGWriteData

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    pop de
    pop hl
    ld a, [wIsCGB]
    or a
    ret z
    ld a, e
    ld [wAttrWriteDestLo], a
    ld a, d
    ld [wAttrWriteDestHi], a
    ld a, $00
    ld [wAttrWriteVertical], a
    ld a, $14
    ld [wAttrWriteCount], a
    ld de, $0e68
    add hl, de
    ld b, $14
    ld de, wAttrWriteData

.loop2:
    ld a, $02
    ldh [rSVBK], a
    ld a, [hli]
    ldh [hTemp0], a
    ld a, $00
    ldh [rSVBK], a
    ldh a, [hTemp0]
    and $07
    ld [de], a
    ld [de], a
    inc de
    dec b
    jr nz, .loop2
    ret

; calls MoveIncapacitatedPartyMembersBack and falls into it, running it twice (E-0126)
RunMoveIncapacitatedPartyMembersBackTwice::
    call MoveIncapacitatedPartyMembersBack

; reorders the party list so a member with bit 7 of field $55 set moves behind one without it
; (second/third and first/second pairs) (E-0127)
MoveIncapacitatedPartyMembersBack::
    ld a, [wPartyCount]
    dec a
    ret z
    dec a
    jr nz, .skip
    jr .skip2

.skip:
    ld a, $0a
    ld [rRAMG], a
    ld c, MON_STATUS
    ld a, [wPartyList + $1]
    call LoadSRAMRecordByte
    bit 7, a
    jr z, .skip2
    ld c, MON_STATUS
    ld a, [wPartyList + $2]
    call LoadSRAMRecordByte
    bit 7, a
    jr nz, .skip2
    ld a, [wPartyList + $1]
    ld c, a
    ld a, [wPartyList + $2]
    ld [wPartyList + $1], a
    ld a, c
    ld [wPartyList + $2], a

.skip2:
    ld a, $0a
    ld [rRAMG], a
    ld c, MON_STATUS
    ld a, [wPartyList]
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    bit 7, a
    jr z, .done
    ld c, MON_STATUS
    ld a, [wPartyList + $1]
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    bit 7, a
    jr nz, .done
    ld a, [wPartyList]
    ld c, a
    ld a, [wPartyList + $1]
    ld [wPartyList], a
    ld a, c
    ld [wPartyList + $1], a

.done:
    xor a
    ld [rRAMG], a
    ret

; copies the first $168 bytes (20 x 18) of wScreenTileBuffer to vBGMap1 with WriteVRAMByteInc; on
; CGB also copies the $168 attribute bytes at wScreenAttrBuffer to wSavedScreenAttrs (rSVBK = 2);
; saves wSpriteSlotCount in wScreenSavedFlag. RestoreScreenBufferFromBGMap1 undoes it (E-0066)
SaveScreenBufferToBGMap1::
    ld de, wScreenTileBuffer
    ld hl, vBGMap1
    ld bc, $0168

.loop:
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ld a, [wIsCGB]
    or a
    jr z, .read_sprite_slot_count
    ld a, $02
    ldh [rSVBK], a
    ld hl, wScreenAttrBuffer
    ld de, wSavedScreenAttrs
    ld bc, $0168
    call CopyBytes
    ld a, $00
    ldh [rSVBK], a

.read_sprite_slot_count:
    ld a, [wSpriteSlotCount]
    ld [wScreenSavedFlag], a
    ret

; copies $168 bytes from vBGMap1 back to wScreenTileBuffer (WaitForVRAMAccess, interrupts off per
; byte); on CGB copies wSavedScreenAttrs back to wScreenAttrBuffer (rSVBK = 2); restores
; wSpriteSlotCount from wScreenSavedFlag (E-0066)
RestoreScreenBufferFromBGMap1::
    ld hl, vBGMap1
    ld de, wScreenTileBuffer
    ld bc, $0168

.loop:
    di
    call WaitForVRAMAccess
    ld a, [hli]
    ld [de], a
    ei
    inc de
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ld a, [wIsCGB]
    or a
    jr z, .read_screen_saved_flag
    ld a, $02
    ldh [rSVBK], a
    ld hl, wSavedScreenAttrs
    ld de, wScreenAttrBuffer
    ld bc, $0168
    call CopyBytes
    ld a, $00
    ldh [rSVBK], a

.read_screen_saved_flag:
    ld a, [wScreenSavedFlag]
    ld [wSpriteSlotCount], a
    ret

; counts frames wPlayFrames (0-59), seconds wPlaySeconds (0-59), minutes wPlayMinutes (0-59) and a
; 16-bit hour count wPlayHoursLo/wPlayHoursHi; stops at 999:59:59 ($03E7 hours) (E-0030)
IncrementPlayTime::
    ld a, [wPlayHoursLo]
    ld l, a
    ld a, [wPlayHoursHi]
    ld h, a
    ld bc, $03e7
    ld a, l
    sub c
    ld l, a
    ld a, h
    sbc b
    ld h, a
    ld a, h
    or l
    or a
    jr nz, .skip
    ld a, [wPlayMinutes]
    cp $3b
    ret z

.skip:
    ld hl, wPlayFrames
    ld a, [hl]
    inc a
    ld [hl], a
    cp $3c
    ret c
    ld [hl], $00
    inc hl
    ld a, [hl]
    inc a
    ld [hl], a
    cp $3c
    ret c
    ld [hl], $00
    inc hl
    ld a, [hl]
    inc a
    ld [hl], a
    cp $3c
    ret c
    ld [hl], $00
    inc hl
    ld a, [hli]
    ld b, [hl]
    ld c, a
    inc bc
    ld a, b
    ld [hld], a
    ld [hl], c
    ret

; on the Super Game Boy sends PAL_SET for wSGBPaletteSet and loads the object palettes;
; wFieldInitStage 1 becomes 2. The following entry clears the joypad state and runs the field mode
; states (E-0129)
SendSGBFieldPaletteSet::
    ld a, [wSGBActive]
    or a
    jr z, .check_field_init_stage
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
    ld a, $b1
    ld [wSGBPacketBuffer], a
    ld a, [wSGBAttrFile]
    ld [wSGBPacketBuffer + $1], a
    ld a, $ff
    ld [wSGBPacketIndex], a
    farcall_b SendSGBPacketSet
    call SpinDelay
    farcall LoadSGBObjectPalettesFromPointers

.check_field_init_stage:
    ld a, [wFieldInitStage]
    cp $01
    ret nz
    ld a, $02
    ld [wFieldInitStage], a
    ret

; Sets wJoypadHeld to 0; sets wJoypadHeldPrev to 0; sets wJoypadPressed to 0; sets
; wJoypadPressedRepeat to 0; sets wJoypadRepeatTimer to 0; sets wFieldFrameFlag to 0; calls
; FieldModeStateDispatch; sets wFieldInitStage to 0; calls ResetFadeFromDMGPaletteBGP; branches on
; wSGBActive; calls StartPaletteFade (E-0347)
; why: part of SendSGBFieldPaletteSet; SendSGBFieldPaletteSet: on the Super Game Boy sends PAL_SET
; for wSGBPaletteSet and loads the object palettes (E-0352, E-0129)
SendSGBFieldPaletteSet_ClearJoypadHeld::
    xor a
    ld [wJoypadHeld], a
    ld [wJoypadHeldPrev], a
    xor a
    ld [wJoypadPressed], a
    ld [wJoypadPressedRepeat], a
    xor a
    ld [wJoypadRepeatTimer], a
    ld [wFieldFrameFlag], a
    call FieldModeStateDispatch
    xor a
    ld [wFieldInitStage], a
    ld hl, wDMGPaletteBGP
    ld a, $d2
    ld [hli], a
    ld a, $d2
    ld [hli], a
    ld a, $e2
    ld [hl], a
    ld hl, wDMGPaletteBytes
    ld a, [wDMGPaletteBGP]
    ld [hli], a
    ld a, [wDMGPaletteOBP0]
    ld [hli], a
    ld a, [wDMGPaletteOBP1]
    ld [hl], a
    call ResetFadeFromDMGPaletteBGP
    ld a, [wSGBActive]
    or a
    jr z, .call_start_palette_fade
    ld hl, wOBJPaletteBuffer
    ld de, wOBJPaletteBuffer + $20
    ld b, $20

.loop:
    ld a, [de]
    inc de
    ld [hli], a
    dec b
    jr nz, .loop

.call_start_palette_fade:
    ld a, $fd
    call StartPaletteFade
    ret

; wCurrentMusic = $FF (no current music), then falls into PlayMapMusic so the map's music always
; restarts (E-0122)
RestartMapMusic::
    ld a, $ff
    ld [wCurrentMusic], a

; chooses the music for the current map (by wMapType and hMapId, with story-flag cases) and queues
; it unless it is already wCurrentMusic (E-0122)
PlayMapMusic::
    ld a, [wMapType]
    bit 7, a
    jr z, PlayMapMusic_ReadMapId
    ld c, $22
    cp $86
    jr z, PlayMapMusic_CheckCurrentMusic
    ld c, $25
    cp $85
    jr z, PlayMapMusic_CheckCurrentMusic
    ld c, $19
    cp $84
    jr z, PlayMapMusic_CheckCurrentMusic
    cp $83
    jr nz, .check_player_state_flags
    ld a, [wKeyWorldFloor]
    add a
    add a
    ld hl, wKeyWorldFloorInfo + $1
    add_a_to_hl
    ld a, [hl]
    cp $06
    jr nz, PlayMapMusic_CheckCurrentMusic

.check_player_state_flags:
    ld c, $2b
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr nz, PlayMapMusic_CheckCurrentMusic
    ld c, $35

; Returns if wCurrentMusic is c; calls QueueMusic (E-0347)
; why: part of PlayMapMusic; PlayMapMusic: chooses the music for the current map (by wMapType and
; hMapId, with story-flag cases) and queues it unless it is already wCurrentMusic (E-0352, E-0122)
PlayMapMusic_CheckCurrentMusic::
    ld a, [wCurrentMusic]
    cp c
    ret z
    ld a, c
    call QueueMusic
    ret

; Returns if wSoundEffectRequest is c; calls QueueSoundEffect (E-0347)
; why: part of PlayMapMusic; PlayMapMusic: chooses the music for the current map (by wMapType and
; hMapId, with story-flag cases) and queues it unless it is already wCurrentMusic (E-0352, E-0122)
PlayMapMusic_CheckSoundEffectRequest::
    ld a, [wSoundEffectRequest]
    cp c
    ret z
    ld a, c
    call QueueSoundEffect
    ret

; Dispatches on hMapId (E-0347)
; why: part of PlayMapMusic; PlayMapMusic: chooses the music for the current map (by wMapType and
; hMapId, with story-flag cases) and queues it unless it is already wCurrentMusic (E-0352, E-0122)
PlayMapMusic_ReadMapId::
    ldh a, [hMapId]
    jumptable
    dw PlayMapMusic_ReadCurrentMusic
    dw PlayMapMusic_TestFlagBit
    dw PlayMapMusic_ReadCurrentMusic
    dw PlayMapMusic_ReadCurrentMusic
    dw PlayMapMusic_TestFlagBit_3
    dw PlayMapMusic_TestFlagBit_2
    dw PlayMapMusic_ReadCurrentMusic
    dw PlayMapMusic_ReadCurrentMusic
    dw PlayMapMusic_ReadCurrentMusic
    dw PlayMapMusic_ReadCurrentMusic
    dw PlayMapMusic_ReadCurrentMusic
    dw PlayMapMusic_ReadCurrentMusic
    dw PlayMapMusic_ReadCurrentMusic
    dw PlayMapMusic_ReadCurrentMusic_2
    dw PlayMapMusic_ReadCurrentMusic
    dw PlayMapMusic_ReadCurrentMusic
    dw PlayMapMusic_ReadCurrentMusic
    dw PlayMapMusic_ReadCurrentMusic
    dw PlayMapMusic_ReadCurrentMusic
    dw PlayMapMusic_ReadCurrentMusic
    dw PlayMapMusic_ReadCurrentMusic_2
    dw PlayMapMusic_ReadCurrentMusic
    dw PlayMapMusic_ReadCurrentMusic
    dw PlayMapMusic_ReadCurrentMusic
    dw PlayMapMusic_TestFlagBit_3
    dw PlayMapMusic_ReadCurrentMusic
    dw PlayMapMusic_ReadCurrentMusic
    dw PlayMapMusic_ReadCurrentMusic
    dw PlayMapMusic_Return
    dw PlayMapMusic_ReadSoundEffectRequest
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw PlayMapMusic_ReadCurrentMusic_4
    dw PlayMapMusic_ReadCurrentMusic_3
    dw PlayMapMusic_ReadCurrentMusic_3
    dw PlayMapMusic_ReadCurrentMusic_3
    dw PlayMapMusic_ReadCurrentMusic_3
    dw PlayMapMusic_ReadCurrentMusic_3
    dw PlayMapMusic_ReadCurrentMusic_3
    dw $0000 ; unused index (E-0207)
    dw PlayMapMusic_ReadCurrentMusic_4
    dw PlayMapMusic_ReadCurrentMusic_4
    dw PlayMapMusic_ReadCurrentMusic_3
    dw PlayMapMusic_ReadCurrentMusic_6
    dw $0000 ; unused index (E-0207)
    dw PlayMapMusic_ReadCurrentMusic_3
    dw PlayMapMusic_ReadCurrentMusic_3
    dw PlayMapMusic_ReadCurrentMusic_4
    dw MapMusicByPlayerStateFlagsBit3
    dw PlayMapMusic_ReadCurrentMusic_3
    dw PlayMapMusic_ReadCurrentMusic_3
    dw PlayMapMusic_ReadCurrentMusic_3
    dw PlayMapMusic_ReadCurrentMusic_3
    dw PlayMapMusic_ReadCurrentMusic_6
    dw MapMusicByPlayerStateFlagsBit3
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_InitSoundHardware
    dw PlayMapMusic_TestFlagBit_4
    dw PlayMapMusic_ReadCurrentMusic_6
    dw PlayMapMusic_TestFlagBit_5
    dw PlayMapMusic_ReadCurrentMusic_3
    dw PlayMapMusic_ReadCurrentMusic_3
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_3
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_4
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw MapMusicByFlag23_2
    dw MapMusicByFlag23_2
    dw MapMusicByFlag23
    dw MapMusicByFlag23
    dw MapMusicByFlag23
    dw MapMusicByScreenAndFlags87And8A
    dw MapMusicByFlag23_2
    dw MapMusicByFlag23
    dw MapMusicByFlag23
    dw MapMusicByFlag23
    dw MapMusicByFlag23_2
    dw PlayMapMusic_ReadCurrentMusic_6
    dw PlayMapMusic_ReadCurrentMusic_6
    dw PlayMapMusic_ReadCurrentMusic_6
    dw PlayMapMusic_ReadCurrentMusic_6
    dw PlayMapMusic_ReadCurrentMusic_6
    dw MapMusicByFlag23
    dw MapMusicByFlag23
    dw MapMusicByFlag23
    dw MapMusicByFlag23
    dw MapMusicByFlag23
    dw PlayMapMusic_ReadCurrentMusic_7
    dw MapMusicByFlag23
    dw MapMusicByFlag23
    dw MapMusicByFlag23
    dw MapMusicByFlag23
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_7
    dw MapMusicByFlag23_2
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw PlayMapMusic_ReadCurrentMusic_4
    dw PlayMapMusic_ReadCurrentMusic_3
    dw PlayMapMusic_ReadCurrentMusic_3
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_4
    dw PlayMapMusic_ReadCurrentMusic_3
    dw PlayMapMusic_ReadCurrentMusic_3
    dw PlayMapMusic_ReadCurrentMusic_4
    dw PlayMapMusic_ReadCurrentMusic_4
    dw PlayMapMusic_ReadCurrentMusic_3
    dw PlayMapMusic_ReadCurrentMusic_3
    dw PlayMapMusic_ReadCurrentMusic_3
    dw PlayMapMusic_ReadCurrentMusic_3
    dw PlayMapMusic_ReadCurrentMusic_4
    dw PlayMapMusic_ReadCurrentMusic_6
    dw PlayMapMusic_ReadCurrentMusic_6
    dw PlayMapMusic_ReadCurrentMusic_6
    dw PlayMapMusic_ReadCurrentMusic_6
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_3
    dw PlayMapMusic_ReadCurrentMusic_4
    dw PlayMapMusic_ReadCurrentMusic_6
    dw PlayMapMusic_ReadCurrentMusic_6
    dw PlayMapMusic_ReadCurrentMusic_6
    dw PlayMapMusic_ReadCurrentMusic_6
    dw PlayMapMusic_ReadCurrentMusic_6
    dw PlayMapMusic_ReadCurrentMusic_6
    dw PlayMapMusic_ReadCurrentMusic_6
    dw PlayMapMusic_ReadCurrentMusic_4
    dw PlayMapMusic_ReadCurrentMusic_4
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_TestFlagBit_6
    dw $0000 ; unused index (E-0207)
    dw PlayMapMusic_ReadCurrentMusic_4
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw MapMusicByFlag25
    dw PlayMapMusic_ReadCurrentMusic_5
    dw PlayMapMusic_ReadCurrentMusic_5
    dw PlayMapMusic_ReadCurrentMusic_5
    dw MapMusicByFlag25
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw PlayMapMusic_ReadCurrentMusic_4
    dw PlayMapMusic_ReadCurrentMusic_3
    dw PlayMapMusic_ReadCurrentMusic_4
    dw PlayMapMusic_ReadCurrentMusic_3
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_4
    dw PlayMapMusic_ReadCurrentMusic_4
    dw PlayMapMusic_ReadCurrentMusic_3
    dw PlayMapMusic_ReadCurrentMusic_4
    dw PlayMapMusic_ReadCurrentMusic_6
    dw PlayMapMusic_ReadCurrentMusic_6
    dw PlayMapMusic_ReadCurrentMusic_6
    dw PlayMapMusic_ReadCurrentMusic_6
    dw $0000 ; unused index (E-0207)
    dw PlayMapMusic_ReadCurrentMusic_4
    dw PlayMapMusic_ReadCurrentMusic_3
    dw PlayMapMusic_ReadCurrentMusic_3
    dw PlayMapMusic_ReadCurrentMusic_4
    dw PlayMapMusic_ReadCurrentMusic_3
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_4
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw PlayMapMusic_ReadCurrentMusic_4
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_7
    dw $0000 ; unused index (E-0207)
    dw PlayMapMusic_ReadCurrentMusic_4
    dw PlayMapMusic_ReadCurrentMusic_4
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_7
    dw $0000 ; unused index (E-0207)
    dw PlayMapMusic_ReadCurrentMusic_4
    dw PlayMapMusic_ReadCurrentMusic_4
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_7
    dw PlayMapMusic_ReadCurrentMusic_7
    dw $0000 ; unused index (E-0207)
    dw PlayMapMusic_ReadCurrentMusic_4
    db $00, $00

; step 0 of PlayMapMusic: changes C; continues in PlayMapMusic_CheckCurrentMusic (E-0347)
; why: step 0 of PlayMapMusic; PlayMapMusic: chooses the music for the current map (by wMapType and
; hMapId, with story-flag cases) and queues it unless it is already wCurrentMusic (E-0352, E-0122)
PlayMapMusic_ReadCurrentMusic::
    ld c, $16
    jp PlayMapMusic_CheckCurrentMusic

; step 1 of PlayMapMusic: may continue in PlayMapMusic_ReadCurrentMusic; branches on hMapScreenX;
; may continue in PlayMapMusic_ReadCurrentMusic; checks EVENT_THANKS_FOR_COMING_BY; may continue in
; PlayMapMusic_ReadCurrentMusic; checks EVENT_SCENE_WARUBOU_SMELLS; may continue in
; PlayMapMusic_ReadCurrentMusic; continues in PlayMapMusic_CheckCurrentMusic (E-0347)
; why: step 1 of PlayMapMusic; PlayMapMusic: chooses the music for the current map (by wMapType and
; hMapId, with story-flag cases) and queues it unless it is already wCurrentMusic (E-0352, E-0122)
PlayMapMusic_TestFlagBit::
    ldh a, [hMapScreenY]
    cp $02
    jr nz, PlayMapMusic_ReadCurrentMusic
    ldh a, [hMapScreenX]
    or a
    jr z, .call_test_flag_bit
    cp $02
    jr nz, PlayMapMusic_ReadCurrentMusic

.call_test_flag_bit:
    ld de, EVENT_THANKS_FOR_COMING_BY
    call TestFlagBit
    jr nc, PlayMapMusic_ReadCurrentMusic
    ld de, EVENT_SCENE_WARUBOU_SMELLS
    call TestFlagBit
    jr c, PlayMapMusic_ReadCurrentMusic
    ld c, $28
    jp PlayMapMusic_CheckCurrentMusic

; step 5 of PlayMapMusic: may continue in PlayMapMusic_ReadCurrentMusic; checks
; EVENT_SCENE_WARUBOU_SMELLS; may continue in PlayMapMusic_ReadCurrentMusic; checks
; EVENT_SCENE_WARUBOU_FOOD2_00C; checks EVENT_SCENE_THREE_ITEMS_0C2; may continue in
; PlayMapMusic_ReadCurrentMusic; checks EVENT_SCENE_THREE_ITEMS_0C3; may continue in
; PlayMapMusic_ReadCurrentMusic; continues in PlayMapMusic_CheckCurrentMusic (E-0347)
; why: step 5 of PlayMapMusic; PlayMapMusic: chooses the music for the current map (by wMapType and
; hMapId, with story-flag cases) and queues it unless it is already wCurrentMusic (E-0352, E-0122)
PlayMapMusic_TestFlagBit_2::
    ldh a, [hMapScreenX]
    or a
    jr nz, PlayMapMusic_ReadCurrentMusic
    ld de, EVENT_SCENE_WARUBOU_SMELLS
    call TestFlagBit
    jr nc, PlayMapMusic_ReadCurrentMusic
    ld de, EVENT_SCENE_WARUBOU_FOOD2_00C
    call TestFlagBit
    jr nc, .skip
    ld de, EVENT_SCENE_THREE_ITEMS_0C2
    call TestFlagBit
    jr nc, PlayMapMusic_ReadCurrentMusic
    ld de, EVENT_SCENE_THREE_ITEMS_0C3
    call TestFlagBit
    jr c, PlayMapMusic_ReadCurrentMusic

.skip:
    ld c, $28
    jp PlayMapMusic_CheckCurrentMusic

; step 13 of PlayMapMusic: changes C; continues in PlayMapMusic_CheckCurrentMusic (E-0347)
; why: step 13 of PlayMapMusic; PlayMapMusic: chooses the music for the current map (by wMapType and
; hMapId, with story-flag cases) and queues it unless it is already wCurrentMusic (E-0352, E-0122)
PlayMapMusic_ReadCurrentMusic_2::
    ld c, $0c
    jp PlayMapMusic_CheckCurrentMusic

; step 4 of PlayMapMusic: checks EVENT_MAP_04_OBJECT_REMOVED_0CC; may continue in
; PlayMapMusic_ReadCurrentMusic; checks EVENT_SCENE_TERRY_BATTLE_038; may continue in
; PlayMapMusic_ReadCurrentMusic; continues in PlayMapMusic_CheckCurrentMusic (E-0347)
; why: step 4 of PlayMapMusic; PlayMapMusic: chooses the music for the current map (by wMapType and
; hMapId, with story-flag cases) and queues it unless it is already wCurrentMusic (E-0352, E-0122)
PlayMapMusic_TestFlagBit_3::
    ld de, EVENT_MAP_04_OBJECT_REMOVED_0CC
    call TestFlagBit
    jr nc, PlayMapMusic_ReadCurrentMusic
    ld de, EVENT_SCENE_TERRY_BATTLE_038
    call TestFlagBit
    jr c, PlayMapMusic_ReadCurrentMusic
    ld c, $cf
    jp PlayMapMusic_CheckCurrentMusic

; step 29 of PlayMapMusic: changes C; continues in PlayMapMusic_CheckSoundEffectRequest (E-0347)
; why: step 29 of PlayMapMusic; PlayMapMusic: chooses the music for the current map (by wMapType and
; hMapId, with story-flag cases) and queues it unless it is already wCurrentMusic (E-0352, E-0122)
PlayMapMusic_ReadSoundEffectRequest::
    ld c, $76
    jp PlayMapMusic_CheckSoundEffectRequest

; step 28 of PlayMapMusic: returns at once (E-0347)
; why: step 28 of PlayMapMusic; PlayMapMusic: chooses the music for the current map (by wMapType and
; hMapId, with story-flag cases) and queues it unless it is already wCurrentMusic (E-0352, E-0122)
PlayMapMusic_Return::
    ret

; step 33 of PlayMapMusic: changes C; continues in PlayMapMusic_CheckCurrentMusic (E-0347)
; why: step 33 of PlayMapMusic; PlayMapMusic: chooses the music for the current map (by wMapType and
; hMapId, with story-flag cases) and queues it unless it is already wCurrentMusic (E-0352, E-0122)
PlayMapMusic_ReadCurrentMusic_3::
    ld c, $19
    jp PlayMapMusic_CheckCurrentMusic

; map music case: if story flag $23 is set uses music $1C, else $2E (E-0122)
MapMusicByFlag23::
    ld de, EVENT_SCENE_SHIELD2_023
    call TestFlagBit
    jr c, PlayMapMusic_ReadCurrentMusic_3
    ld c, $2e
    jp PlayMapMusic_CheckCurrentMusic

; map music case: on hMapScreenY 0, without flag $87, or with flag $8A uses the flag-$23 case;
; otherwise music $28 (E-0122)
MapMusicByScreenAndFlags87And8A::
    ldh a, [hMapScreenY]
    or a
    jr z, MapMusicByFlag23
    ld de, EVENT_SCENE_REPORT_TO_KING
    call TestFlagBit
    jr nc, MapMusicByFlag23
    ld de, EVENT_SCENE_WALL_EXIT
    call TestFlagBit
    jr c, MapMusicByFlag23
    ld c, $28
    jp PlayMapMusic_CheckCurrentMusic

; step 32 of PlayMapMusic: changes C; continues in PlayMapMusic_CheckCurrentMusic (E-0347)
; why: step 32 of PlayMapMusic; PlayMapMusic: chooses the music for the current map (by wMapType and
; hMapId, with story-flag cases) and queues it unless it is already wCurrentMusic (E-0352, E-0122)
PlayMapMusic_ReadCurrentMusic_4::
    ld c, $1c
    jp PlayMapMusic_CheckCurrentMusic

; map music case: music $2B when bit 3 of hPlayerStateFlags is set, else $1C (E-0122)
MapMusicByPlayerStateFlagsBit3::
    ld c, $1c
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jp z, PlayMapMusic_CheckCurrentMusic
    ld c, $2b
    jp PlayMapMusic_CheckCurrentMusic

; map music case: if story flag $23 is set uses music $1C, else $2E (E-0122) (E-0344: the address in
; its name dropped or read as the label there; was MapMusicByFlag23_2)
MapMusicByFlag23_2::
    ld de, EVENT_SCENE_SHIELD2_023
    call TestFlagBit
    jr c, PlayMapMusic_ReadCurrentMusic_4
    ld c, $2e
    jp PlayMapMusic_CheckCurrentMusic

; map music case: if story flag $25 is set uses music $1C, else $1F (E-0122)
MapMusicByFlag25::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, PlayMapMusic_ReadCurrentMusic_4
    ld c, $1f
    jp PlayMapMusic_CheckCurrentMusic

; step 161 of PlayMapMusic: changes C; continues in PlayMapMusic_CheckCurrentMusic (E-0347)
; why: step 161 of PlayMapMusic; PlayMapMusic: chooses the music for the current map (by wMapType
; and hMapId, with story-flag cases) and queues it unless it is already wCurrentMusic (E-0352,
; E-0122)
PlayMapMusic_ReadCurrentMusic_5::
    ld c, $cc
    jp PlayMapMusic_CheckCurrentMusic

; step 43 of PlayMapMusic: changes C; continues in PlayMapMusic_CheckCurrentMusic (E-0347)
; why: step 43 of PlayMapMusic; PlayMapMusic: chooses the music for the current map (by wMapType and
; hMapId, with story-flag cases) and queues it unless it is already wCurrentMusic (E-0352, E-0122)
PlayMapMusic_ReadCurrentMusic_6::
    ld c, $25
    jp PlayMapMusic_CheckCurrentMusic

; step 56 of PlayMapMusic: may continue in PlayMapMusic_ReadCurrentMusic_6; calls InitSoundHardware
; (E-0347)
; why: step 56 of PlayMapMusic; PlayMapMusic: chooses the music for the current map (by wMapType and
; hMapId, with story-flag cases) and queues it unless it is already wCurrentMusic (E-0352, E-0122)
PlayMapMusic_InitSoundHardware::
    ldh a, [hMapScreenX]
    or a
    jr nz, PlayMapMusic_ReadCurrentMusic_6
    ldh a, [hMapScreenY]
    or a
    jr nz, PlayMapMusic_ReadCurrentMusic_6
    call InitSoundHardware
    ret

; step 57 of PlayMapMusic: may continue in PlayMapMusic_ReadCurrentMusic_6; checks
; EVENT_SCENE_CREW_FOLLOWS; may continue in PlayMapMusic_ReadCurrentMusic_6; continues in
; PlayMapMusic_CheckCurrentMusic (E-0347)
; why: step 57 of PlayMapMusic; PlayMapMusic: chooses the music for the current map (by wMapType and
; hMapId, with story-flag cases) and queues it unless it is already wCurrentMusic (E-0352, E-0122)
PlayMapMusic_TestFlagBit_4::
    ldh a, [hMapScreenX]
    cp $01
    jr nz, PlayMapMusic_ReadCurrentMusic_6
    ldh a, [hMapScreenY]
    cp $01
    jr nz, PlayMapMusic_ReadCurrentMusic_6
    ld de, EVENT_SCENE_CREW_FOLLOWS
    call TestFlagBit
    jr c, PlayMapMusic_ReadCurrentMusic_6
    ld c, $28
    jp PlayMapMusic_CheckCurrentMusic

; step 59 of PlayMapMusic: checks EVENT_SCENE_MERMAID_KINGDOM_022; may continue in
; PlayMapMusic_ReadCurrentMusic_6; continues in PlayMapMusic_CheckCurrentMusic (E-0347)
; why: step 59 of PlayMapMusic; PlayMapMusic: chooses the music for the current map (by wMapType and
; hMapId, with story-flag cases) and queues it unless it is already wCurrentMusic (E-0352, E-0122)
PlayMapMusic_TestFlagBit_5::
    ld de, EVENT_SCENE_MERMAID_KINGDOM_022
    call TestFlagBit
    jr c, PlayMapMusic_ReadCurrentMusic_6
    ld c, $28
    jp PlayMapMusic_CheckCurrentMusic

; step 55 of PlayMapMusic: changes C; continues in PlayMapMusic_CheckCurrentMusic (E-0347)
; why: step 55 of PlayMapMusic; PlayMapMusic: chooses the music for the current map (by wMapType and
; hMapId, with story-flag cases) and queues it unless it is already wCurrentMusic (E-0352, E-0122)
PlayMapMusic_ReadCurrentMusic_7::
    ld c, $22
    jp PlayMapMusic_CheckCurrentMusic

; step 155 of PlayMapMusic: may continue in PlayMapMusic_ReadCurrentMusic_7; checks
; EVENT_SCENE_THREE_ITEMS_0C2; may continue in PlayMapMusic_ReadCurrentMusic_7; checks
; EVENT_SCENE_THREE_ITEMS_0C3; may continue in PlayMapMusic_ReadCurrentMusic_7; continues in
; PlayMapMusic_CheckCurrentMusic (E-0347)
; why: step 155 of PlayMapMusic; PlayMapMusic: chooses the music for the current map (by wMapType
; and hMapId, with story-flag cases) and queues it unless it is already wCurrentMusic (E-0352,
; E-0122)
PlayMapMusic_TestFlagBit_6::
    ldh a, [hMapScreenY]
    or a
    jr nz, PlayMapMusic_ReadCurrentMusic_7
    ld de, EVENT_SCENE_THREE_ITEMS_0C2
    call TestFlagBit
    jr nc, PlayMapMusic_ReadCurrentMusic_7
    ld de, EVENT_SCENE_THREE_ITEMS_0C3
    call TestFlagBit
    jr c, PlayMapMusic_ReadCurrentMusic_7
    ld c, $28
    jp PlayMapMusic_CheckCurrentMusic

; called from FieldState_Still: calls FieldState_Still_WriteMenuSubState; branches on
; wJoypadPressed; sets wFieldReturnPhase to 0; calls ClearBit1OfPlayerAndObjectFlags; sets
; hSpriteWindowClipMode to 0; calls FieldState_Still_WritePartyWindowFlagsAndPartyWindowTimer;
; branches on wMapType; sets wModeState to 0; sets wModeState to 5; branches on $05; plays sound
; $69; sets wGameMode to 2; then 11 more steps (see the code) (E-0347)
; why: a helper of FieldState_Still; FieldState_Still: field state 2: draws the field sprites and
; runs the common update without player input (E-0352, E-0339)
FieldState_Still_ClearBit1OfPlayerAndObjectFlags::
    call FieldState_Still_WriteMenuSubState
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, .check_bit0
    xor a
    ld [wFieldReturnPhase], a
    farcall ClearBit1OfPlayerAndObjectFlags
    xor a
    ldh [hSpriteWindowClipMode], a
    call FieldState_Still_WritePartyWindowFlagsAndPartyWindowTimer
    ld a, [wMapType]
    bit 7, a
    jr nz, .set_mode_state_to_05
    xor a
    ld [wModeState], a
    ret

.set_mode_state_to_05:
    ld a, $05
    ld [wModeState], a
    ret

.check_bit0:
    bit 0, a
    jr z, .check_bit5
    ld a, $69
    call QueueSoundEffect
    ld a, $02
    ld [wGameMode], a
    ld a, [wMenuState]
    ld [wModeState], a
    xor a
    ld [wWorldMapState], a
    ret

.check_bit5:
    bit 5, a
    jr z, .check_bit4
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuState]
    xor $01
    ld [wMenuState], a
    ret

.check_bit4:
    bit 4, a
    jr z, .check_bit6
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuState]
    xor $01
    ld [wMenuState], a
    ret

.check_bit6:
    bit 6, a
    jr z, .check_bit7
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuState]
    xor $02
    ld [wMenuState], a
    ret

.check_bit7:
    bit 7, a
    jr z, .return
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuState]
    xor $02
    ld [wMenuState], a

.return:
    ret

; Branches on wMenuState; increments wMenuSubState; branches on wMenuSubState+1; calls
; WriteVRAMByte; branches on B (E-0347)
; why: part of FieldState_Still; FieldState_Still: field state 2: draws the field sprites and runs
; the common update without player input (E-0352, E-0339)
FieldState_Still_WriteMenuSubState::
    ldh a, [hScrollY]
    and $f8
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add $00
    ld e, a
    ld a, d
    adc $98
    ld d, a
    ldh a, [hScrollX]
    srl a
    srl a
    srl a
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld l, e
    ld h, d
    ld b, $00
    ld de, FieldState_Still_WriteMenuSubState_Data

.loop:
    push hl
    ld a, [de]
    inc de
    ld c, a
    add l
    ld l, a
    and $1f
    cp c
    jr nc, .skip2
    ld a, l
    sub $20
    ld l, a
    ld a, h
    sbc $00
    ld h, a

.skip2:
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
    add e
    ld l, a
    ld a, h
    adc $00
    ld h, a
    pop de
    ld a, h
    and $9b
    ld h, a
    ld c, $c3
    ld a, [wMenuState]
    cp b
    jr nz, .call_write_vram_byte
    ld c, $bc
    bit 7, a
    jr nz, .call_write_vram_byte
    ld c, $bb
    ld a, [wMenuSubState]
    inc a
    ld [wMenuSubState], a
    bit 3, a
    jr z, .call_write_vram_byte
    ld c, $c3

.call_write_vram_byte:
    ld a, c
    call WriteVRAMByte
    pop hl
    inc b
    ld a, b
    cp $04
    jr nz, .loop
    ret

; data read by FieldState_Still_WriteMenuSubState (8 bytes) (E-0347)
FieldState_Still_WriteMenuSubState_Data::
    db $01, $01, $06, $01, $01, $03, $06, $03

; Calls DrawFullScreenBufferToBGMap; sets wPartyWindowFlags to 0; sets wPartyWindowTimer to 0
; (E-0347)
; why: part of FieldState_Still; FieldState_Still: field state 2: draws the field sprites and runs
; the common update without player input (E-0352, E-0339)
FieldState_Still_WritePartyWindowFlagsAndPartyWindowTimer::
    ldh a, [hScrollY]
    and $f8
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add $00
    ld e, a
    ld a, d
    adc $98
    ld d, a
    ldh a, [hScrollX]
    srl a
    srl a
    srl a
    add e
    ld e, a
    jr nc, .call_draw_full_screen_buffer_to_bg_map
    inc d

.call_draw_full_screen_buffer_to_bg_map:
    ld l, e
    ld h, d
    call DrawFullScreenBufferToBGMap
    xor a
    ld [wPartyWindowFlags], a
    xor a
    ld [wPartyWindowTimer], a
    ret

; in the field, when A is pressed and nothing blocks it: saves the screen, sets the object flags and
; draws the field menu windows (OpenFieldMenuOnA_TileRect, 6642) (E-0130)
OpenFieldMenuOnA::
    ld a, [wFadeState]
    or a
    ret nz
    ld de, EVENT_SCENE_LONG_FACES_002
    call TestFlagBit
    ret nc
    ld a, [wTextWindowState]
    and $03
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

.loop:
    ld a, [de]
    inc de
    ld [hli], a
    dec b
    jr nz, .loop
    ld a, [wIsCGB]
    or a
    jr z, .skip
    ld hl, wWindowAttrBuffer
    ld de, wScreenAttrBuffer
    ld a, $02
    ldh [rSVBK], a
    ld b, $64

.loop2:
    ld a, [de]
    inc de
    and $07
    ld [hli], a
    dec b
    jr nz, .loop2
    ld a, $00
    ldh [rSVBK], a

.skip:
    ld de, OpenFieldMenuOnA_TileRect
    ld hl, wWindowTileBuffer
    lb bc, $0c, $05
    call CopyRectToScreenBufferAndClearAttributes
    ld de, OpenFieldMenuOnA_TileRect_2
    ld hl, wWindowTileBuffer + $c
    lb bc, $08, $03
    call CopyRectToScreenBufferAndClearAttributes
    ldh a, [hScrollY]
    and $f8
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add $00
    ld e, a
    ld a, d
    adc $98
    ld d, a
    ldh a, [hScrollX]
    srl a
    srl a
    srl a
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld l, e
    ld h, d
    push hl
    lb bc, $14, $05
    call CopyScreenRectToBGMapSetTextCursorLo
    ld a, $b3
    ld [wPartyWindowTimer], a
    call ShowIdlePartyStatusWindow
    pop hl
    ld a, $2e
    add_a_to_hl
    ld a, l
    and $1f
    cp $0e
    jr nc, .call_draw_gold_digits_at_hl_wrapped
    ld a, l
    sub $20
    ld l, a
    ld a, h
    sbc $00
    ld h, a

.call_draw_gold_digits_at_hl_wrapped:
    call DrawGoldDigitsAtHLWrapped
    ld a, $69
    call QueueSoundEffect
    ld a, $02
    ld [wModeState], a
    ldh a, [hTemp8]
    or a
    ret nz
    xor a
    ld [wMenuState], a
    ret

; copies a B x C rectangle from DE to HL (20-byte rows); on CGB clears the matching attribute rows
; in WRAM bank 2 (E-0127) (E-0344: the address in its name dropped or read as the label there; was
; CopyRectToScreenBufferAndClearAttributes)
CopyRectToScreenBufferAndClearAttributes::
    push hl
    push bc

.loop:
    push hl
    push bc

.loop2:
    ld a, [de]
    inc de
    ld [hli], a
    dec b
    jr nz, .loop2
    pop bc
    pop hl
    ld a, l
    add $14
    ld l, a
    ld a, h
    adc $00
    ld h, a
    dec c
    jr nz, .loop
    pop bc
    pop hl
    ld a, [wIsCGB]
    or a
    ret z
    ld a, l
    add $68
    ld l, a
    ld a, h
    adc $0e
    ld h, a
    ld a, $02
    ldh [rSVBK], a

.loop3:
    push hl
    push bc

.loop4:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop4
    pop bc
    pop hl
    ld a, l
    add $14
    ld l, a
    ld a, h
    adc $00
    ld h, a
    dec c
    jr nz, .loop3
    ld a, $00
    ldh [rSVBK], a
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 12 x 5 tiles, one row per line
OpenFieldMenuOnA_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $a4, $a5, $a6, $a7, $c3, $a4, $a8, $a9, $ec, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $aa, $ab, $a4, $ac, $c3, $ad, $ac, $ae, $a5, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

; record: 8 x 3 tiles, one row per line
OpenFieldMenuOnA_TileRect_2::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $bf, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 2

; writes the gold as up to five decimal digit tiles without leading zeros at HL in VRAM, wrapping at
; the row end (E-0128)
DrawGoldDigitsAtHLWrapped::
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
    jr .skip2

.loop:
    ld a, [de]
    srl a
    srl a
    srl a
    srl a
    or a
    jr nz, .call_write_vram_byte
    bit 0, c
    jr z, .next

.call_write_vram_byte:
    add $e0
    call WriteVRAMByte
    ld c, $01

.next:
    inc hl
    ld a, l
    and $1f
    jr nz, .skip
    ld a, l
    sub $20
    ld l, a
    ld a, h
    sbc $00
    ld h, a

.skip:
    ld a, b
    dec a
    jr nz, .skip2
    ld c, $01

.skip2:
    ld a, [de]
    dec de
    and $0f
    jr nz, .call_write_vram_byte2
    bit 0, c
    jr z, .next2

.call_write_vram_byte2:
    add $e0
    call WriteVRAMByte
    ld c, $01

.next2:
    inc hl
    ld a, l
    and $1f
    jr nz, .next3
    ld a, l
    sub $20
    ld l, a
    ld a, h
    sbc $00
    ld h, a

.next3:
    dec b
    jr nz, .loop
    ret

; in the field, after $B4 idle frames: saves the bottom of the screen and shows the party status
; window (level, HP, MP) (E-0130)
ShowIdlePartyStatusWindow::
    ld de, EVENT_SCENE_LONG_FACES_002
    call TestFlagBit
    ret nc
    ld a, [wTextWindowState]
    and $03
    ret nz
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    ld a, [wPartyCount]
    or a
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
    cp $b4
    ret nz
    xor a
    ld [wPartyWindowTimer], a
    ld a, [wPartyCount]
    dec a
    or $80
    ld [wPartyWindowFlags], a
    ld a, $03
    ldh [hSpriteWindowClipMode], a
    ld hl, wWindowTileBuffer + $64
    ld de, wScreenTileBuffer
    ld a, e
    add $f0
    ld e, a
    ld a, d
    adc $00
    ld d, a
    push de
    ld b, $78

.loop:
    ld a, [de]
    inc de
    ld [hli], a
    dec b
    jr nz, .loop
    pop de
    ld a, [wIsCGB]
    or a
    jr z, .check_party_window_flags
    ld hl, wWindowAttrBuffer + $64
    ld a, e
    add $68
    ld e, a
    ld a, d
    adc $0e
    ld d, a
    ld a, $02
    ldh [rSVBK], a
    ld b, $78

.loop2:
    ld a, [de]
    inc de
    and $07
    ld [hli], a
    dec b
    jr nz, .loop2
    ld a, $00
    ldh [rSVBK], a

.check_party_window_flags:
    ld a, [wPartyWindowFlags]
    and $03
    jr z, .skip
    dec a
    jr z, .skip2
    dec a
    jr z, .skip3
    ret

.skip:
    ld de, ShowIdlePartyStatusWindow_TileRect
    ld hl, wWindowTileBuffer + $64
    lb bc, $07, $06
    call CopyRectToScreenBufferAndClearAttributes_2
    jr .call_build_party_status_window_rows

.skip2:
    ld de, ShowIdlePartyStatusWindow_TileRect_2
    ld hl, wWindowTileBuffer + $64
    lb bc, $0d, $06
    call CopyRectToScreenBufferAndClearAttributes_2
    jr .call_build_party_status_window_rows

.skip3:
    ld de, ShowIdlePartyStatusWindow_TileRect_3
    ld hl, wWindowTileBuffer + $64
    lb bc, $13, $06
    call CopyRectToScreenBufferAndClearAttributes_2

.call_build_party_status_window_rows:
    call BuildPartyStatusWindowRows
    call DrawBottomWindowWindowTileBufferRow5AtScroll
    farcall LoadTilesForPartyRecords
    ret

; for each party member writes level (field $56), HP (field $5B) and MP (field $5F) into the status
; window at wWindowTileBuffer + $64 (offsets BuildPartyStatusWindowRows_Data) (E-0130)
BuildPartyStatusWindowRows::
    ld a, $0a
    ld [rRAMG], a
    ld a, [wPartyWindowFlags]
    and $03
    inc a
    ld b, a
    ld hl, BuildPartyStatusWindowRows_Data
    ld de, wPartyList

.loop:
    push bc
    push de
    ld a, [de]
    ldh [hTemp5], a
    ld c, MON_LEVEL
    call LoadSRAMRecordByte
    push hl
    ldh a, [hTemp0]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    pop hl
    ld a, [hli]
    ld de, wWindowTileBuffer + $64
    add e
    ld e, a
    jr nc, .call_write_two_digit_tiles_from_digits1
    inc d

.call_write_two_digit_tiles_from_digits1:
    call WriteTwoDigitTilesFromDigits1
    ldh a, [hTemp5]
    ld c, MON_HP
    call LoadSRAMRecordWord
    push hl
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    call HLToDecimalDigits
    pop hl
    ld a, [hli]
    ld de, wWindowTileBuffer + $64
    add e
    ld e, a
    jr nc, .call_write_decimal_digit_tiles
    inc d

.call_write_decimal_digit_tiles:
    call WriteDecimalDigitTiles
    ldh a, [hTemp5]
    ld c, MON_MP
    call LoadSRAMRecordWord
    push hl
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    call HLToDecimalDigits
    pop hl
    ld a, [hli]
    ld de, wWindowTileBuffer + $64
    add e
    ld e, a
    jr nc, .call_write_decimal_digit_tiles2
    inc d

.call_write_decimal_digit_tiles2:
    call WriteDecimalDigitTiles
    ld a, [hli]
    ld de, wWindowTileBuffer + $64
    add e
    ld e, a
    jr nc, .read_temp5
    inc d

.read_temp5:
    ldh a, [hTemp5]
    ld c, MON_STATUS
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    bit 7, a
    jr z, .check_bit2
    ld a, $c2
    ld [de], a
    jr .restore

.check_bit2:
    bit 2, a
    jr z, .check_temp0
    ld a, $c1
    ld [de], a

.check_temp0:
    ldh a, [hTemp0]
    bit 0, a
    jr z, .restore
    ld a, e
    sub $14
    ld e, a
    ld a, d
    sbc $00
    ld d, a
    ld a, $c0
    ld [de], a

.restore:
    pop de
    inc de
    pop bc
    dec b
    jp nz, .loop
    xor a
    ld [rRAMG], a
    ret

; data read by BuildPartyStatusWindowRows (12 bytes) (E-0347)
BuildPartyStatusWindowRows_Data::
    db $54, $2b, $3f, $51, $5a, $31, $45, $57, $60, $37, $4b, $5d

; draws the 20 x 6 window wWindowTileBuffer + $64 at the scroll position + $180 (and its CGB
; attributes from wWindowAttrBuffer + $64) (E-0127) (E-0340: the address in its name read as its RAM
; name; was DrawBottomWindowWindowTileBufferRow5AtScroll)
DrawBottomWindowWindowTileBufferRow5AtScroll::
    ldh a, [hScrollY]
    and $f8
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add $00
    ld e, a
    ld a, d
    adc $98
    ld d, a
    ld a, d
    and $9b
    ld d, a
    ldh a, [hScrollX]
    srl a
    srl a
    srl a
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, e
    add $80
    ld e, a
    ld a, d
    adc $01
    ld d, a
    ld a, d
    and $9b
    ld d, a
    ld l, e
    ld h, d
    push hl
    ld de, wWindowTileBuffer + $64
    lb bc, $14, $06
    xor a
    call CopyRectFromBankToBGMapWrapped
    pop hl
    ld a, [wIsCGB]
    or a
    ret z
    ld a, $01
    ldh [rVBK], a
    ld a, $02
    ldh [rSVBK], a
    ld de, wWindowAttrBuffer + $64
    lb bc, $14, $06
    xor a
    call CopyRectFromBankToBGMapWrapped
    ld a, $00
    ldh [rSVBK], a
    ld a, $00
    ldh [rVBK], a
    ret

; copies a B x C rectangle from DE to HL (20-byte rows); on CGB clears the matching attribute rows
; in WRAM bank 2 (E-0127) (E-0344: the address in its name dropped or read as the label there; was
; CopyRectToScreenBufferAndClearAttributes_2)
CopyRectToScreenBufferAndClearAttributes_2::
    push hl
    push bc

.loop:
    push hl
    push bc

.loop2:
    ld a, [de]
    inc de
    ld [hli], a
    dec b
    jr nz, .loop2
    pop bc
    pop hl
    ld a, l
    add $14
    ld l, a
    ld a, h
    adc $00
    ld h, a
    dec c
    jr nz, .loop
    pop bc
    pop hl
    ld a, l
    add $68
    ld l, a
    ld a, h
    adc $0e
    ld h, a
    ld a, [wIsCGB]
    or a
    ret z
    ld a, $02
    ldh [rSVBK], a

.loop3:
    push hl
    push bc

.loop4:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop4
    pop bc
    pop hl
    ld a, l
    add $14
    ld l, a
    ld a, h
    adc $00
    ld h, a
    dec c
    jr nz, .loop3
    ld a, $00
    ldh [rSVBK], a
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 7 x 6 tiles, one row per line
ShowIdlePartyStatusWindow_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $d0, $d1, $d2, $d3, $d4, $b7 ; id 1
    db $b6, $c7, $eb, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $ec, $c3, $c3, $c3, $b7 ; id 3
    db $b6, $c3, $ea, $ed, $c3, $c3, $b7 ; id 4
    db $b3, $b4, $b4, $b4, $b4, $b4, $b5 ; id 5

; record: 13 x 6 tiles, one row per line
ShowIdlePartyStatusWindow_TileRect_2::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $d0, $d1, $d2, $d3, $d4, $c3, $d5, $d6, $d7, $d8, $d9, $b7 ; id 1
    db $b6, $c7, $eb, $c3, $c3, $c3, $c3, $c8, $eb, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $ec, $c3, $c3, $c3, $c3, $c3, $ec, $c3, $c3, $c3, $b7 ; id 3
    db $b6, $c3, $ea, $ed, $c3, $c3, $c3, $c3, $ea, $ed, $c3, $c3, $b7 ; id 4
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 5

; record: 19 x 6 tiles, one row per line
ShowIdlePartyStatusWindow_TileRect_3::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $d0, $d1, $d2, $d3, $d4, $c3, $d5, $d6, $d7, $d8, $d9, $c3, $da, $db, $dc, $dd, $de, $b7 ; id 1
    db $b6, $c7, $eb, $c3, $c3, $c3, $c3, $c8, $eb, $c3, $c3, $c3, $c3, $c9, $eb, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $ec, $c3, $c3, $c3, $c3, $c3, $ec, $c3, $c3, $c3, $c3, $c3, $ec, $c3, $c3, $c3, $b7 ; id 3
    db $b6, $c3, $ea, $ed, $c3, $c3, $c3, $c3, $ea, $ed, $c3, $c3, $c3, $c3, $ea, $ed, $c3, $c3, $b7 ; id 4
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 5

; while wTextWindowState & 3 is set: copies the text window rows to or from wWindowTileBuffer (with
; CGB attributes) and redraws them at the scroll position (E-0130)
StepTextWindowOpenClose::
    ld a, [wTextWindowState]
    and $03
    ret z
    ld hl, wWindowTileBuffer
    ld de, wScreenTileBuffer
    ld a, [wTextWindowState]
    bit 7, a
    jr nz, .skip
    ld a, e
    add $04
    ld e, a
    ld a, d
    adc $01
    ld d, a

.skip:
    push hl
    push de
    ld b, $64

.loop:
    ld a, [de]
    inc de
    ld [hli], a
    dec b
    jr nz, .loop
    pop de
    pop hl
    ld a, [wIsCGB]
    or a
    jr z, .check_scroll_y
    ld a, e
    add $68
    ld e, a
    ld a, d
    adc $0e
    ld d, a
    ld a, l
    add $68
    ld l, a
    ld a, h
    adc $0e
    ld h, a
    ld a, $02
    ldh [rSVBK], a
    ld b, $64

.loop2:
    ld a, [de]
    inc de
    and $07
    ld [hli], a
    dec b
    jr nz, .loop2
    ld a, $00
    ldh [rSVBK], a

.check_scroll_y:
    ldh a, [hScrollY]
    and $f8
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add $00
    ld e, a
    ld a, d
    adc $98
    ld d, a
    ld a, d
    and $9b
    ld d, a
    ldh a, [hScrollX]
    srl a
    srl a
    srl a
    add e
    ld e, a
    jr nc, .check_text_window_state
    inc d

.check_text_window_state:
    ld a, [wTextWindowState]
    bit 7, a
    jr nz, .check_text_window_step
    ld a, e
    add $a0
    ld e, a
    ld a, d
    adc $01
    ld d, a
    ld a, d
    and $9b
    ld d, a

.check_text_window_step:
    ld hl, wTextWindowStep
    inc [hl]
    ld a, [wTextWindowStep]
    and $01
    dec a
    ret nz
    ld a, [wTextWindowStep]
    srl a
    and $03
    jumptable
    dw StepTextWindowOpenClose_CopyRowsToScreenBufferAndClearAttributes
    dw StepTextWindowOpenClose_CopyRowsToScreenBufferAndClearAttributes_2
    dw StepTextWindowOpenClose_CopyRowsToScreenBufferAndClearAttributes_SetTextWindowState
    dw StepTextWindowOpenClose_CopyRowsToScreenBufferAndClearAttributes_SetTextWindowState

; step 0 of StepTextWindowOpenClose: branches on wTextWindowState; calls
; CopyRowsToScreenBufferAndClearAttributes; calls CopyScreenRectToBGMapSetTextCursorLo; calls
; CopyRowsToScreenBufferAndClearAttributes; calls CopyScreenRectToBGMapSetTextCursorLo (E-0347)
; why: step 0 of StepTextWindowOpenClose; StepTextWindowOpenClose: while wTextWindowState & 3 is
; set: copies the text window rows to or from wWindowTileBuffer (with CGB attributes) and redraws
; them at the ... (E-0352, E-0130)
StepTextWindowOpenClose_CopyRowsToScreenBufferAndClearAttributes::
    ld a, [wTextWindowState]
    bit 0, a
    jr z, .skip
    push de
    ld hl, wWindowTileBuffer + $28
    ld de, StepTextWindowOpenClose_CopyRowsToScreenBufferAndClearAttributes_Data1
    ld b, $01
    call CopyRowsToScreenBufferAndClearAttributes
    pop de
    ld l, e
    ld h, d
    lb bc, $14, $05
    call CopyScreenRectToBGMapSetTextCursorLo
    ret

.skip:
    push de
    ld hl, wWindowTileBuffer + $14
    ld de, StepTextWindowOpenClose_CopyRowsToScreenBufferAndClearAttributes_Data2
    ld b, $03
    call CopyRowsToScreenBufferAndClearAttributes
    pop de
    ld l, e
    ld h, d
    lb bc, $14, $05
    call CopyScreenRectToBGMapSetTextCursorLo
    ret

; step 1 of StepTextWindowOpenClose: branches on wTextWindowState; calls
; CopyRowsToScreenBufferAndClearAttributes; calls CopyScreenRectToBGMapSetTextCursorLo; calls
; CopyRowsToScreenBufferAndClearAttributes; calls CopyScreenRectToBGMapSetTextCursorLo (E-0347)
; why: step 1 of StepTextWindowOpenClose; StepTextWindowOpenClose: while wTextWindowState & 3 is
; set: copies the text window rows to or from wWindowTileBuffer (with CGB attributes) and redraws
; them at the ... (E-0352, E-0130)
StepTextWindowOpenClose_CopyRowsToScreenBufferAndClearAttributes_2::
    ld a, [wTextWindowState]
    bit 0, a
    jr z, .skip
    push de
    ld hl, wWindowTileBuffer + $14
    ld de, StepTextWindowOpenClose_CopyRowsToScreenBufferAndClearAttributes_Data2
    ld b, $03
    call CopyRowsToScreenBufferAndClearAttributes
    pop de
    ld l, e
    ld h, d
    lb bc, $14, $05
    call CopyScreenRectToBGMapSetTextCursorLo
    ret

.skip:
    push de
    ld hl, wWindowTileBuffer + $28
    ld de, StepTextWindowOpenClose_CopyRowsToScreenBufferAndClearAttributes_Data1
    ld b, $01
    call CopyRowsToScreenBufferAndClearAttributes
    pop de
    ld l, e
    ld h, d
    lb bc, $14, $05
    call CopyScreenRectToBGMapSetTextCursorLo
    ret

; step 2 of StepTextWindowOpenClose: branches on wTextWindowState; calls
; CopyRowsToScreenBufferAndClearAttributes; calls CopyScreenRectToBGMapSetTextCursorLo; copies
; wTextWindowState & $80 to wTextWindowState; sets wTextWindowStep to 0; calls
; CopyScreenRectToBGMapSetTextCursorLo; copies wTextWindowState & $80 to wTextWindowState; sets
; wTextWindowStep to 0 (E-0347)
; why: step 2 of StepTextWindowOpenClose; StepTextWindowOpenClose: while wTextWindowState & 3 is
; set: copies the text window rows to or from wWindowTileBuffer (with CGB attributes) and redraws
; them at the ... (E-0352, E-0130)
StepTextWindowOpenClose_CopyRowsToScreenBufferAndClearAttributes_SetTextWindowState::
    ld a, [wTextWindowState]
    bit 0, a
    jr z, .skip
    push de
    ld hl, wWindowTileBuffer
    ld de, StepTextWindowOpenClose_CopyRowsToScreenBufferAndClearAttributes_Data
    ld b, $05
    call CopyRowsToScreenBufferAndClearAttributes
    pop de
    ld l, e
    ld h, d
    lb bc, $14, $05
    call CopyScreenRectToBGMapSetTextCursorLo
    ld a, [wTextWindowState]
    and $80
    ld [wTextWindowState], a
    xor a
    ld [wTextWindowStep], a
    ret

.skip:
    ld l, e
    ld h, d
    lb bc, $14, $05
    call CopyScreenRectToBGMapSetTextCursorLo
    ld a, [wTextWindowState]
    and $80
    ld [wTextWindowState], a
    xor a
    ld [wTextWindowStep], a
    ret

; copies a rectangle of the screen buffer wWindowTileBuffer to the BG map
; (CopyRectFromBankToBGMapWrapped) and sets wTextCursorLo = HL + $21 (wrapped in the map); on CGB
; also copies the attributes from wWindowAttrBuffer in VRAM bank 1 (E-0121)
CopyScreenRectToBGMapSetTextCursorLo::
    push bc
    push hl
    ld de, wWindowTileBuffer
    xor a
    call CopyRectFromBankToBGMapWrapped
    pop hl
    push hl
    ld a, h
    and $9c
    push af
    ld a, $21
    add_a_to_hl
    ld a, h
    and $03
    ld h, a
    pop af
    or h
    ld h, a
    ld a, l
    ld [wTextCursorLo], a
    ld a, h
    ld [wTextCursorHi], a
    pop hl
    pop bc
    ld a, [wIsCGB]
    or a
    ret z
    ld a, $01
    ldh [rVBK], a
    ld a, $02
    ldh [rSVBK], a
    ld de, wWindowAttrBuffer
    xor a
    call CopyRectFromBankToBGMapWrapped
    ld a, $00
    ldh [rVBK], a
    ld a, $00
    ldh [rSVBK], a
    ret

; copies B rows of 20 bytes from DE to HL; on CGB also clears the matching attribute rows in WRAM
; bank 2 (HL + $E68) (E-0125)
CopyRowsToScreenBufferAndClearAttributes::
    push hl
    push bc

.loop:
    ld c, $14

.loop2:
    ld a, [de]
    inc de
    ld [hli], a
    dec c
    jr nz, .loop2
    dec b
    jr nz, .loop
    pop bc
    pop hl
    ld a, l
    add $68
    ld l, a
    ld a, h
    adc $0e
    ld h, a
    ld a, [wIsCGB]
    or a
    ret z
    ld a, $02
    ldh [rSVBK], a

.loop3:
    ld c, $14

.loop4:
    xor a
    ld [hli], a
    dec c
    jr nz, .loop4
    dec b
    jr nz, .loop3
    ld a, $00
    ldh [rSVBK], a
    ret

; data read by StepTextWindowOpenClose_CopyRowsToScreenBufferAndClearAttributes (2 bytes) (E-0347)
StepTextWindowOpenClose_CopyRowsToScreenBufferAndClearAttributes_Data1::
    db $b6
    ds $12, $c3
    db $b7

StepTextWindowOpenClose_CopyRowsToScreenBufferAndClearAttributes_Data2::
    db $b0
    ds $12, $b1
    db $b2, $b6
    ds $12, $c3
    db $b7, $b3
    ds $12, $b4
    db $b5

StepTextWindowOpenClose_CopyRowsToScreenBufferAndClearAttributes_Data::
    db $b0
    ds $12, $b1
    db $b2, $b6, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8a, $8b, $8c, $8d
    db $8e, $8f, $90, $91, $b7, $b6
    ds $12, $c3
    db $b7, $b6, $92, $93, $94, $95, $96, $97, $98, $99, $9a, $9b, $9c, $9d, $9e, $9f
    db $a0, $a1, $a2, $a3, $b7, $b3
    ds $12, $b4
    db $b5

; runs the routine for wMenuState & $0F (jump table) (E-0122)
RunMenuStateMenuState::
    ld a, [wMenuState]
    or a
    jr nz, .check_menu_state

.check_menu_state:
    ld a, [wMenuState]
    and $0f
    jumptable
    dw RunMenuStateMenuState_QueueMusic
    dw RunMenuStateMenuState_QueueSoundEffect
    dw RunMenuStateMenuState_WriteMenuSubStateAndMenuSelectedMemberEtc
    dw RunMenuStateMenuState_WriteMenuSubStateAndMenuCursorEtc
    dw RunMenuStateMenuState_WriteSubMenuCursorAndSTATSplitEnableEtc
    dw RunMenuStateMenuState_InitSoundHardware
    dw RunMenuStateMenuState_Return
    dw RunMenuStateMenuState_Return
    dw RunMenuStateMenuState_Return

; step 6 of RunMenuStateMenuState: returns at once (E-0347)
; why: step 6 of RunMenuStateMenuState (when wMenuState = 6); RunMenuStateMenuState: runs the
; routine for wMenuState & $0F (jump table) (E-0352, E-0122)
RunMenuStateMenuState_Return::
    ret

; step 0 of RunMenuStateMenuState: plays music $02; calls InitSoundHardware; advances wMenuState;
; branches on wMapToggleFlag; sets wMenuSubState to 0; sets wMenuCursor to 0; plays sound $78; sets
; wMenuSubState to 0; sets wMenuCursor to $3b (E-0347)
; why: step 0 of RunMenuStateMenuState (when wMenuState = 0); RunMenuStateMenuState: runs the
; routine for wMenuState & $0F (jump table) (E-0352, E-0122)
RunMenuStateMenuState_QueueMusic::
    ld a, $02
    call QueueMusic
    call InitSoundHardware
    ld hl, wMenuState
    inc [hl]
    ld a, [wMapToggleFlag]
    bit 7, a
    jr z, .clear_menu_sub_state
    xor a
    ld [wMenuSubState], a
    ld [wMenuCursor], a
    ld a, $78
    call QueueSoundEffect
    ret

.clear_menu_sub_state:
    xor a
    ld [wMenuSubState], a
    ld a, $3b
    ld [wMenuCursor], a
    ret

; step 1 of RunMenuStateMenuState: increments wMenuCursor; returns if wMenuCursor is below $3c;
; plays sound $61; calls RunMenuStateMenuState_ReadScrollYAndScrollX; sets wMenuSubState to 0; sets
; wMenuSelectedMember to 0; sets wMenuCursor to 0; sets wSubMenuCursor to 0; sets wSubMenuCursor2 to
; 0; sets wMenuOption to 0; sets wMenuOption2 to 0; advances wMenuState; then 5 more steps (see the
; code) (E-0347)
; why: step 1 of RunMenuStateMenuState (when wMenuState = 1); RunMenuStateMenuState: runs the
; routine for wMenuState & $0F (jump table) (E-0352, E-0122)
RunMenuStateMenuState_QueueSoundEffect::
    ld a, [wMenuCursor]
    inc a
    ld [wMenuCursor], a
    cp $3c
    ret c
    ld a, $61
    call QueueSoundEffect
    call RunMenuStateMenuState_ReadScrollYAndScrollX
    xor a
    ld [wMenuSubState], a
    ld [wMenuSelectedMember], a
    ld [wMenuCursor], a
    ld [wSubMenuCursor], a
    ld [wSubMenuCursor2], a
    ld [wMenuOption], a
    ld [wMenuOption2], a
    ld hl, wBGPaletteCopy
    ld b, $90

.loop:
    ldh a, [hScrollX]
    ld [hli], a
    dec b
    jr nz, .loop
    ld hl, wMenuState
    inc [hl]
    ld a, $1e
    ld [wMenuSelectedMember], a
    xor a
    ld [wScreenState], a
    ld [wScreenSubStep], a
    call RunMenuStateMenuState_WriteScreenCounter
    xor a
    ld [wScreenState], a
    ret

; called from RunMenuStateMenuState_QueueSoundEffect: calls WriteVRAMByte (E-0347)
; why: a helper of RunMenuStateMenuState_QueueSoundEffect, in step 1 of RunMenuStateMenuState (when
; wMenuState = 1); RunMenuStateMenuState: runs the routine for wMenuState & $0F (jump table)
; (E-0352, E-0122)
RunMenuStateMenuState_ReadScrollYAndScrollX::
    ldh a, [hScrollY]
    and $f8
    ld l, a
    ld h, $00
    sla l
    rl h
    sla l
    rl h
    ld a, l
    add $00
    ld l, a
    ld a, h
    adc $98
    ld h, a
    ld a, h
    and $9b
    ld h, a
    ldh a, [hScrollX]
    srl a
    srl a
    srl a
    add $14
    and $1f
    add_a_to_hl
    ld c, $12

.loop:
    push hl
    ld b, $0c

.loop2:
    ld a, $c4
    call WriteVRAMByte
    ld a, l
    push af
    and $e0
    ld l, a
    pop af
    inc a
    and $1f
    or l
    ld l, a
    dec b
    jr nz, .loop2
    pop hl
    ld a, $20
    add_a_to_hl
    ld a, h
    and $9b
    ld h, a
    dec c
    jr nz, .loop
    ret

; step 2 of RunMenuStateMenuState: copies wMenuSelectedMember & $01 to wMenuSubState; decrements
; wMenuSelectedMember; may return early; advances wMenuState; sets wMenuCursor to 1; sets rLYC to 2;
; sets wSTATSplitEnable to 2 (E-0347)
; why: step 2 of RunMenuStateMenuState (when wMenuState = 2); RunMenuStateMenuState: runs the
; routine for wMenuState & $0F (jump table) (E-0352, E-0122)
RunMenuStateMenuState_WriteMenuSubStateAndMenuSelectedMemberEtc::
    ld a, [wMenuSelectedMember]
    and $01
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

; step 3 of RunMenuStateMenuState: sets wMenuSubState to 1; may continue in
; RunMenuStateMenuState_WriteMenuSubStateAndMenuCursorEtc_ReadMenuCursor; sets wMenuCursor; may
; continue in RunMenuStateMenuState_WriteMenuSubStateAndMenuCursorEtc_ReadMenuCursor; advances
; wMenuState; sets wSubMenuCursor to 0 (E-0347)
; why: step 3 of RunMenuStateMenuState (when wMenuState = 3); RunMenuStateMenuState: runs the
; routine for wMenuState & $0F (jump table) (E-0352, E-0122)
RunMenuStateMenuState_WriteMenuSubStateAndMenuCursorEtc::
    ld a, $01
    ld [wMenuSubState], a
    ld a, [wFrameCounterLo]
    and $07
    jr nz, RunMenuStateMenuState_WriteMenuSubStateAndMenuCursorEtc_ReadMenuCursor
    ld a, [wMenuCursor]
    swap a
    and $0f
    inc a
    ld b, a
    ld a, [wMenuCursor]
    add b
    ld [wMenuCursor], a
    cp $38
    jr c, RunMenuStateMenuState_WriteMenuSubStateAndMenuCursorEtc_ReadMenuCursor
    ld hl, wMenuState
    inc [hl]
    xor a
    ld [wSubMenuCursor], a

; Copies wMenuCursor to hTemp0; branches on wFrameCounterLo & $03; sets hTemp1 to $24; branches on
; $24; sets hTemp1 to $48; branches on $48; sets hTemp1 to $6c; sets hTemp1 to $90; branches on e;
; branches on hTemp1 (E-0347)
; why: part of RunMenuStateMenuState_WriteMenuSubStateAndMenuCursorEtc, in step 3 of
; RunMenuStateMenuState (when wMenuState = 3); RunMenuStateMenuState: runs the routine for
; wMenuState & $0F (jump table) (E-0352, E-0122)
RunMenuStateMenuState_WriteMenuSubStateAndMenuCursorEtc_ReadMenuCursor::
    ld a, [wMenuCursor]
    ldh [hTemp0], a
    ld a, [wFrameCounterLo]
    rra
    rra
    and $0f
    ld e, a
    ld d, $00
    ld a, [wFrameCounterLo]
    and $03
    cp $00
    jr nz, .cp_01
    ld bc, wBGPaletteCopy
    ld a, $24
    ldh [hTemp1], a
    jr .loop

.cp_01:
    cp $01
    jr nz, .cp_02
    ld bc, wBGPaletteCopy + $24
    ld a, $48
    ldh [hTemp1], a
    jr .loop

.cp_02:
    cp $02
    jr nz, .set_temp1_to_90
    ld bc, wTextBuf0 + $8
    ld a, $6c
    ldh [hTemp1], a
    jr .loop

.set_temp1_to_90:
    ld bc, wTextBuf2 + $c
    ld a, $90
    ldh [hTemp1], a

.loop:
    inc e
    ld a, e
    and $0f
    ld e, a
    ld hl, RunMenuStateMenuState_WriteMenuSubStateAndMenuCursorEtc_Data
    add hl, de
    push bc
    ld c, [hl]
    ldh a, [hTemp0]
    call Multiply8
    pop bc
    bit 3, e
    jr z, .read_scroll_x
    ldh a, [hScrollX]
    sub h
    jr .skip

.read_scroll_x:
    ldh a, [hScrollX]
    add h

.skip:
    ld [bc], a
    inc bc
    ld [bc], a
    inc bc
    ldh a, [hTemp1]
    cp c
    jr nz, .loop
    ret

; data read by RunMenuStateMenuState (16 bytes) (E-0347)
RunMenuStateMenuState_WriteMenuSubStateAndMenuCursorEtc_Data::
    db $00, $60, $b6, $ec, $ff, $ec, $b6, $60, $00, $60, $b6, $ec, $ff, $ec, $b6, $60

; step 4 of RunMenuStateMenuState: increments wSubMenuCursor; branches on wSubMenuCursor; calls
; RunMenuStateMenuState_RunScreenStateStepEveryOtherFrame; advances wMenuState; sets
; wSTATSplitEnable to 0; copies the byte at
; RunMenuStateMenuState_WriteSubMenuCursorAndSTATSplitEnableEtc_Data to wDMGPaletteBGP; calls
; RunMenuStateMenuState_RunScreenStateStepEveryOtherFrame; continues in
; RunMenuStateMenuState_WriteMenuSubStateAndMenuCursorEtc_ReadMenuCursor (E-0347)
; why: step 4 of RunMenuStateMenuState (when wMenuState = 4); RunMenuStateMenuState: runs the
; routine for wMenuState & $0F (jump table) (E-0352, E-0122)
RunMenuStateMenuState_WriteSubMenuCursorAndSTATSplitEnableEtc::
    ld a, [wFrameCounterLo]
    and $0f
    jr nz, .read_sub_menu_cursor
    ld a, [wSubMenuCursor]
    inc a
    ld [wSubMenuCursor], a
    cp $04
    jr nz, .read_sub_menu_cursor
    call RunMenuStateMenuState_RunScreenStateStepEveryOtherFrame
    ld hl, wMenuState
    inc [hl]
    xor a
    ld [wSTATSplitEnable], a

.read_sub_menu_cursor:
    ld a, [wSubMenuCursor]
    ld hl, RunMenuStateMenuState_WriteSubMenuCursorAndSTATSplitEnableEtc_Data
    add_a_to_hl
    ld a, [hl]
    ld [wDMGPaletteBGP], a
    call RunMenuStateMenuState_RunScreenStateStepEveryOtherFrame
    jp RunMenuStateMenuState_WriteMenuSubStateAndMenuCursorEtc_ReadMenuCursor

; data read by RunMenuStateMenuState (5 bytes) (E-0347)
RunMenuStateMenuState_WriteSubMenuCursorAndSTATSplitEnableEtc_Data::
    db $d2, $81, $40, $00, $00

; step 5 of RunMenuStateMenuState: calls InitSoundHardware; calls RestartMapMusic; sets wScreenState
; to 0; sets wScreenCounter to 0; sets wScreenStep to 0; branches on wMapToggleFlag; branches on
; wWarpDestFacing; sets wMapType to $80; copies wKeyWorldWidth to wMapWidthScreens; copies
; wKeyWorldHeight to wMapHeightScreens; sets hPlayerFacing to 0; copies wWarpDestX to hPlayerX; then
; 62 more steps (see the code) (E-0347)
; why: step 5 of RunMenuStateMenuState (when wMenuState = 5); RunMenuStateMenuState: runs the
; routine for wMenuState & $0F (jump table) (E-0352, E-0122)
RunMenuStateMenuState_InitSoundHardware::
    call InitSoundHardware
    farcall RestartMapMusic
    xor a
    ld [wScreenState], a
    ld [wScreenCounter], a
    ld [wScreenStep], a
    ld a, [wMapToggleFlag]
    bit 7, a
    jr nz, .check_map_type
    ld a, [wWarpDestFacing]
    cp $f0
    jr nz, .cp_FF
    push af
    ld a, $80
    ld [wMapType], a
    ld a, [wKeyWorldWidth]
    ld [wMapWidthScreens], a
    ld a, [wKeyWorldHeight]
    ld [wMapHeightScreens], a
    pop af

.cp_FF:
    cp $ff
    jr z, .clear_player_facing
    ld a, $00
    ldh [hPlayerFacing], a

.clear_player_facing:
    xor a
    ldh [hPlayerFacing], a
    ld a, [wWarpDestX]
    ldh [hPlayerX], a
    ld a, [wWarpDestY]
    ldh [hPlayerY], a
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $a], a
    ldh a, [hPlayerX]
    ld [wFollowerRecords + $1], a
    ld [wFollowerRecords + $6], a
    ld [wFollowerRecords + $b], a
    ldh a, [hPlayerY]
    ld [wFollowerRecords + $2], a
    ld [wFollowerRecords + $7], a
    ld [wFollowerRecords + $c], a
    ld a, [wMapType]
    bit 7, a
    jr nz, .set_game_mode_to_01
    ld a, $01
    ld [wGameMode], a
    ld a, $00
    ld [wModeState], a
    ld hl, wModeChangeRequest
    inc [hl]
    ret

.set_game_mode_to_01:
    ld a, $01
    ld [wGameMode], a
    ld a, $05
    ld [wModeState], a
    ld hl, wModeChangeRequest
    inc [hl]
    farcall RunMenuStateMenuState_ReadKeyWorldFloor
    ret

.check_map_type:
    ld a, [wMapType]
    bit 7, a
    jr z, .read_current_key_index
    farcall SaveKeyWorldFlagsRecordToSRAMSlotKeyWorldSlot

.read_current_key_index:
    ld a, [wCurrentKeyIndex]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add $0a
    ld l, a
    ld a, h
    adc $c7
    ld h, a
    ld a, [hl]
    dec hl
    dec hl
    dec hl
    bit 7, a
    jp z, .skip
    push hl
    ld a, $01
    ld [wGameMode], a
    ld a, $00
    ld [wModeState], a
    ld hl, wModeChangeRequest
    inc [hl]
    pop hl
    ld a, [hl]
    and $3f
    push af
    add a
    add a
    add a
    ld hl, KeyListMapDestinationTable
    add_a_to_hl
    ld a, [hli]
    ldh [hMapId], a
    ld a, [hli]
    ldh [hMapScreenX], a
    ld a, [hli]
    ldh [hMapScreenY], a
    ld a, [hli]
    ldh [hPlayerX], a
    ld a, [hl]
    ldh [hPlayerY], a
    xor a
    ld [wWorldMapByFieldSkill], a
    xor a
    ld [wMapType], a
    ld a, $80
    ld [wKeyWorldRefresh], a
    xor a
    ld [wScreenTriggerCount], a
    ld de, EVENT_SCENE_WIZSTONE
    call TestFlagBit
    jr nc, .call_test_flag_bit
    ld de, EVENT_KIRAL_FETCH_ME_MY_167
    call SetFlagBit

.call_test_flag_bit:
    ld de, EVENT_MILAYOU_HOW_DO_I_KNOW
    call TestFlagBit
    jr nc, .restore
    ld de, EVENT_MILAYOU_IEBEEN
    call SetFlagBit

.restore:
    pop af
    cp $01
    jp nz, .clear_player_facing2
    ld a, $1a
    ld [wTalkEventGroup], a
    xor a
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    farcall FetchScriptCommand
    jp .clear_player_facing2

.skip:
    ld a, [hl]
    bit 7, a
    jr nz, .set_key_world_slot
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    ld [wPartyStrength], a
    farcall RunMenuStateMenuState_FindSRAMSlotMarkerIndex
    farcall SaveKeyWorldFlagsRecordToSRAMSlotKeyWorldSlot
    jr .set_key_world_refresh_to_80

.set_key_world_slot:
    and $3f
    ld [wKeyWorldSlot], a
    farcall LoadKeyWorldFlagsRecordFromSRAMSlotKeyWorldSlot

.set_key_world_refresh_to_80:
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
    and $0f
    ldh [hMapScreenX], a
    ld a, [wKeyWorldGoalScreen]
    and $0f
    ldh [hMapScreenY], a
    ld a, [wKeyWorldGoalPos]
    ldh [hPlayerX], a
    ld a, [wKeyWorldGoalPos2]
    ldh [hPlayerY], a
    xor a
    ld [wWorldMapByFieldSkill], a
    ld a, $80
    ld [wMapType], a
    farcall MarkVisitedMapScreenInVisitedScreens
    ld a, $87
    ld [wMapType], a
    ld a, $01
    ld [wMapWidthScreens], a
    ld [wMapHeightScreens], a
    xor a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $40
    ldh [hPlayerX], a
    ldh [hPlayerY], a

.clear_player_facing2:
    xor a
    ldh [hPlayerFacing], a
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $a], a
    ldh a, [hPlayerX]
    ld [wFollowerRecords + $1], a
    ld [wFollowerRecords + $6], a
    ld [wFollowerRecords + $b], a
    ldh a, [hPlayerY]
    ld [wFollowerRecords + $2], a
    ld [wFollowerRecords + $7], a
    ld [wFollowerRecords + $c], a
    xor a
    ldh [hPlayerSpriteOverride], a
    ret

; the code after RunMenuStateMenuState_InitSoundHardware.read_current_key_index takes the key list
; byte & $3F as the index, sets game mode 1 and loads hMapId, hMapScreenX, hMapScreenY, hPlayerX and
; hPlayerY from the 8-byte record at $7006 + 8 * index; 13 records (E-0237, C1)
; record: map number, screen X, screen Y, player X, player Y; three bytes not read
KeyListMapDestinationTable::
    db $00, $00, $00, $00, $00 ; id 0: hMapId, hMapScreenX, hMapScreenY, hPlayerX, hPlayerY
    db $00, $00, $00 ; not read
    db $05, $01, $00, $50, $30 ; id 1: hMapId, hMapScreenX, hMapScreenY, hPlayerX, hPlayerY
    db $00, $00, $00 ; not read
    db $29, $00, $00, $40, $40 ; id 2: hMapId, hMapScreenX, hMapScreenY, hPlayerX, hPlayerY
    db $00, $00, $00 ; not read
    db $45, $00, $00, $40, $40 ; id 3: hMapId, hMapScreenX, hMapScreenY, hPlayerX, hPlayerY
    db $00, $00, $00 ; not read
    db $68, $00, $00, $40, $40 ; id 4: hMapId, hMapScreenX, hMapScreenY, hPlayerX, hPlayerY
    db $00, $00, $00 ; not read
    db $9d, $00, $00, $40, $40 ; id 5: hMapId, hMapScreenX, hMapScreenY, hPlayerX, hPlayerY
    db $00, $00, $00 ; not read
    db $a4, $00, $00, $40, $40 ; id 6: hMapId, hMapScreenX, hMapScreenY, hPlayerX, hPlayerY
    db $00, $00, $00 ; not read
    db $af, $00, $00, $40, $40 ; id 7: hMapId, hMapScreenX, hMapScreenY, hPlayerX, hPlayerY
    db $00, $00, $00 ; not read
    db $b2, $00, $00, $40, $40 ; id 8: hMapId, hMapScreenX, hMapScreenY, hPlayerX, hPlayerY
    db $00, $00, $00 ; not read
    db $c5, $00, $00, $40, $40 ; id 9: hMapId, hMapScreenX, hMapScreenY, hPlayerX, hPlayerY
    db $00, $00, $00 ; not read
    db $d0, $00, $00, $40, $40 ; id 10: hMapId, hMapScreenX, hMapScreenY, hPlayerX, hPlayerY
    db $00, $00, $00 ; not read
    db $d9, $00, $00, $40, $40 ; id 11: hMapId, hMapScreenX, hMapScreenY, hPlayerX, hPlayerY
    db $00, $00, $00 ; not read
    db $e2, $00, $00, $40, $40 ; id 12: hMapId, hMapScreenX, hMapScreenY, hPlayerX, hPlayerY
    db $00, $00, $00 ; not read

; with SRAM bank 1 selected: hTemp0 = 1 when sSaveSignature is not the signature $55 (no save);
; otherwise 2 when VerifySaveBank1Checksum or VerifySaveBank3Checksum returns non-zero (damaged
; save), else 0 (valid); then disables SRAM (E-0109)
CheckSaveData::
    ld a, $0a
    ld [rRAMG], a
    ld a, $01
    ld [rRAMB], a
    ld a, [sSaveSignature]
    cp $55
    jr z, .call_verify_save_bank1_checksum
    ld a, $01
    jr .set_temp0

.call_verify_save_bank1_checksum:
    call VerifySaveBank1Checksum
    or a
    jr z, .call_verify_save_bank3_checksum
    ld a, $02
    jr .set_temp0

.call_verify_save_bank3_checksum:
    call VerifySaveBank3Checksum
    or a
    jr z, .clear_temp0
    ld a, $02
    jr .set_temp0

.clear_temp0:
    xor a

.set_temp0:
    ldh [hTemp0], a
    xor a
    ld [rRAMG], a
    ld [rRAMB], a
    ret

; sums the $29A * 10 bytes of SRAM bank 1 from sBank1Records ($A06F) into the word DE, then returns
; A = 0 when sBank1Checksum ($BA73, little-endian) equals (~DE + $4321) & $FFFF and A = 1 otherwise,
; as CheckSaveData uses it (C2 from E-0323: after a save the stored word equals that value, and a
; fresh power-on offers CONTINUE)
VerifySaveBank1Checksum::
    ld a, $01
    ld [rRAMB], a
    ld hl, sBank1Records
    ld bc, $029a
    ld de, $0000

.loop:
    ld a, [hli]
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [hli]
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [hli]
    add e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    ld a, [hli]
    add e
    ld e, a
    jr nc, .skip4
    inc d

.skip4:
    ld a, [hli]
    add e
    ld e, a
    jr nc, .skip5
    inc d

.skip5:
    ld a, [hli]
    add e
    ld e, a
    jr nc, .skip6
    inc d

.skip6:
    ld a, [hli]
    add e
    ld e, a
    jr nc, .skip7
    inc d

.skip7:
    ld a, [hli]
    add e
    ld e, a
    jr nc, .skip8
    inc d

.skip8:
    ld a, [hli]
    add e
    ld e, a
    jr nc, .skip9
    inc d

.skip9:
    ld a, [hli]
    add e
    ld e, a
    jr nc, .next
    inc d

.next:
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ld a, e
    xor $ff
    ld e, a
    ld a, d
    xor $ff
    ld d, a
    ld a, e
    add $21
    ld e, a
    ld a, d
    adc $43
    ld d, a
    ld hl, sBank1Checksum
    ld a, [hli]
    cp e
    jr nz, .return_01
    ld a, [hl]
    cp d
    jr nz, .return_01
    xor a
    ret

.return_01:
    ld a, $01
    ret

; sums the $333 * 10 = $1FFE bytes of SRAM bank 3 from sRecords ($A000) into the word DE, then
; returns A = 0 when the little-endian word right after them ($BFFE) equals (~DE + $1234) & $FFFF
; and A = 1 otherwise, as CheckSaveData uses it (C2 from E-0323, as VerifySaveBank1Checksum)
VerifySaveBank3Checksum::
    ld a, $03
    ld [rRAMB], a
    ld hl, sRecords
    ld bc, $0333
    ld de, $0000

.loop:
    ld a, [hli]
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [hli]
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [hli]
    add e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    ld a, [hli]
    add e
    ld e, a
    jr nc, .skip4
    inc d

.skip4:
    ld a, [hli]
    add e
    ld e, a
    jr nc, .skip5
    inc d

.skip5:
    ld a, [hli]
    add e
    ld e, a
    jr nc, .skip6
    inc d

.skip6:
    ld a, [hli]
    add e
    ld e, a
    jr nc, .skip7
    inc d

.skip7:
    ld a, [hli]
    add e
    ld e, a
    jr nc, .skip8
    inc d

.skip8:
    ld a, [hli]
    add e
    ld e, a
    jr nc, .skip9
    inc d

.skip9:
    ld a, [hli]
    add e
    ld e, a
    jr nc, .next
    inc d

.next:
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ld a, e
    xor $ff
    ld e, a
    ld a, d
    xor $ff
    ld d, a
    ld a, e
    add $34
    ld e, a
    ld a, d
    adc $12
    ld d, a
    ld a, [hli]
    cp e
    jr nz, .return_01
    ld a, [hl]
    cp d
    jr nz, .return_01
    xor a
    ret

.return_01:
    ld a, $01
    ret

; with SRAM enabled, steps by wSaveStep: on the first call (0) sets it to 1 and runs
; CopySaveBlocksToSRAM and three more save routines; on the second runs
; ScanBank1RecordStepSaveRecordIndex; afterwards sets bit 7 of wSaveStep (finished); disables SRAM
; each time (E-0109)
RunSaveSteps::
    ld a, $0a
    ld [rRAMG], a
    ld a, [wSaveStep]
    or a
    jr nz, .skip
    inc a
    ld [wSaveStep], a
    call CopySaveBlocksToSRAM
    call RunSaveSteps_WriteRAMB
    call RestoreRecordsFromSRAMBank1Backup
    call RunSaveSteps_WriteSVBKAndRAMB
    jr .skip2

.skip:
    dec a
    jr nz, .check_save_step
    call ScanBank1RecordStepSaveRecordIndex
    jr .skip2

.check_save_step:
    ld a, [wSaveStep]
    or $80
    ld [wSaveStep], a

.skip2:
    xor a
    ld [rRAMG], a
    ld [rRAMB], a
    ret

; runs UnpackRecordFromBank1Slot for SRAM bank 1 record wSaveRecordIndex ($A06F + $6F * index); when
; wArg5 is $FF advances wSaveRecordIndex and, after record 30, increments wSaveStep (E-0121)
ScanBank1RecordStepSaveRecordIndex::
    ld a, [wSaveRecordIndex]
    ld [wArg1], a
    ld c, $6f
    call Multiply8
    ld a, l
    add $6f
    ld l, a
    ld a, h
    adc $a0
    ld h, a
    ld a, l
    ld [wArg3], a
    ld a, h
    ld [wArg4], a
    ld a, $01
    ld [wArg2], a
    farcall UnpackRecordFromBank1Slot
    ld a, [wArg5]
    cp $ff
    ret nz
    ld a, [wSaveRecordIndex]
    inc a
    ld [wSaveRecordIndex], a
    cp $1e
    ret nz
    ld hl, wSaveStep
    inc [hl]
    ret

; copies the record backup at sRecordBackup (SRAM bank 1) back to sCompactRecords in bank 0 and to
; sRecords in bank 1; counterpart of BackupRecordsToSRAMBank1 (E-0128)
RestoreRecordsFromSRAMBank1Backup::
    ld hl, sRecordBackup
    ld de, sCompactRecords
    ld bc, $0309

.loop:
    push bc
    ld a, $01
    ld [rRAMB], a
    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld b, a
    xor a
    ld [rRAMB], a
    ld a, c
    ld [de], a
    inc de
    ld a, b
    ld [de], a
    inc de
    ld a, $01
    ld [rRAMB], a
    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld b, a
    xor a
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
    or c
    jr nz, .loop
    ld b, $6f

.loop2:
    ld a, $01
    ld [rRAMB], a
    ld a, [hli]
    ld c, a
    xor a
    ld [rRAMB], a
    ld a, c
    ld [de], a
    inc de
    dec b
    jr nz, .loop2
    ld a, $01
    ld [rRAMB], a
    ld de, sRecords
    ld b, $6f

.loop3:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop3
    ret

; called from RunSaveSteps: sets rRAMB to 3; sets rRAMB to 2; sets rRAMB to 3; sets rRAMB to 2; sets
; rRAMB to 3; sets rRAMB to 2; sets rRAMB to 3; sets rRAMB to 2; sets rRAMB to 3; sets rRAMB to 2
; (E-0347)
; why: a helper of RunSaveSteps; RunSaveSteps: with SRAM enabled, steps by wSaveStep: on the first
; call (0) sets it to 1 and runs CopySaveBlocksToSRAM and three more save routines (E-0352, E-0109)
RunSaveSteps_WriteRAMB::
    ld hl, sRecords
    ld bc, $0333

.loop:
    push bc
    ld a, $03
    ld [rRAMB], a
    ld a, [hli]
    ld c, a
    ld a, [hld]
    ld b, a
    ld a, $02
    ld [rRAMB], a
    ld a, c
    ld [hli], a
    ld a, b
    ld [hli], a
    ld a, $03
    ld [rRAMB], a
    ld a, [hli]
    ld c, a
    ld a, [hld]
    ld b, a
    ld a, $02
    ld [rRAMB], a
    ld a, c
    ld [hli], a
    ld a, b
    ld [hli], a
    ld a, $03
    ld [rRAMB], a
    ld a, [hli]
    ld c, a
    ld a, [hld]
    ld b, a
    ld a, $02
    ld [rRAMB], a
    ld a, c
    ld [hli], a
    ld a, b
    ld [hli], a
    ld a, $03
    ld [rRAMB], a
    ld a, [hli]
    ld c, a
    ld a, [hld]
    ld b, a
    ld a, $02
    ld [rRAMB], a
    ld a, c
    ld [hli], a
    ld a, b
    ld [hli], a
    ld a, $03
    ld [rRAMB], a
    ld a, [hli]
    ld c, a
    ld a, [hld]
    ld b, a
    ld a, $02
    ld [rRAMB], a
    ld a, c
    ld [hli], a
    ld a, b
    ld [hli], a
    pop bc
    dec bc
    ld a, b
    or c
    jp nz, .loop
    ret

; with SRAM bank 1 selected, walks the list at CopySaveBlocksToSRAM_Data (word address, word length;
; a zero address ends it) and copies each WRAM block to SRAM from sSaveData onward (the copy loop is
; not read to its end) (E-0109)
; code: sets rRAMB to 1; copies the byte at CopySaveBlocksToSRAM_Data to hTemp0; copies the byte at
; CopySaveBlocksToSRAM_Data to hTemp1; sets wSaveStateFlag to $80 (E-0347)
CopySaveBlocksToSRAM::
    ld a, $01
    ld [rRAMB], a
    ld hl, CopySaveBlocksToSRAM_Data
    ld de, sSaveData

.set_temp0:
    push hl
    ld a, [hli]
    ldh [hTemp0], a
    ld a, [hli]
    ldh [hTemp1], a
    ld a, [hli]
    ld c, a
    ld a, [hl]
    ld b, a
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    ld a, l
    or h
    jr nz, .loop
    pop hl
    ld a, $80
    ld [wSaveStateFlag], a
    ret

.loop:
    ld a, [de]
    ld [hli], a
    inc de
    dec bc
    ld a, b
    or c
    jr nz, .loop
    pop hl
    ld a, $04
    add_a_to_hl
    jr .set_temp0

; called from RunSaveSteps: sets rSVBK to 0; sets rRAMB to 1; branches on sSavedGM2Mode (E-0347)
; why: a helper of RunSaveSteps; RunSaveSteps: with SRAM enabled, steps by wSaveStep: on the first
; call (0) sets it to 1 and runs CopySaveBlocksToSRAM and three more save routines (E-0352, E-0109)
RunSaveSteps_WriteSVBKAndRAMB::
    xor a
    ldh [rSVBK], a
    ld a, $01
    ld [rRAMB], a
    ld hl, sSavedTimerBlock
    ld a, [sSavedGM2Mode]
    cp $01
    jr z, .skip
    and a
    jr z, .skip
    ret

.skip:
    ld bc, $00d8
    ld de, wGM2TimerFrames

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ret

; when wGiftRecord is 0 or 1, copies the $D8 bytes at wGM2TimerFrames to sSavedTimerBlock in SRAM
; bank 1 (E-0124)
SaveGM2TimerFramesBlockToSRAMBank1::
    ld hl, wGM2TimerFrames
    ld bc, $00d8
    ld de, sSavedTimerBlock
    ld a, $01
    ld [rRAMB], a
    xor a
    ldh [rSVBK], a
    ld a, [wGiftRecord]
    cp $01
    jr z, .loop
    and a
    jr z, .loop
    ret

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ret

; with SRAM enabled: on the first step (wSaveStep = 0) copies the save blocks with their checksum
; and continues with the next save stage (E-0122)
RunSaveGameSteps::
    ld a, $0a
    ld [rRAMG], a
    ld a, [wSaveStep]
    or a
    jr nz, RunSaveGameSteps_2_Skip
    inc a
    ld [wSaveStep], a
    call CopySaveBlocksToSRAMWithSum
    jr RunSaveGameSteps_2_CallRunSaveGameSteps_2_ClearSRAMBanks2And3

; with SRAM enabled runs one save stage per call (sprites snapshot and blocks, then records, then
; the final stage marked by bit 7 of wSaveStep) (E-0124) (E-0344: the address in its name dropped or
; read as the label there; was RunSaveGameSteps_2)
RunSaveGameSteps_2::
    ld a, $0a
    ld [rRAMG], a
    ld a, [wSaveStep]
    or a
    jr nz, RunSaveGameSteps_2_Skip
    inc a
    ld [wSaveStep], a
    call SnapshotSpritesForSave

; Calls RunSaveGameSteps_2_ClearSRAMBanks2And3; calls BackupRecordsToSRAMBank1; calls
; SaveGM2TimerFramesBlockToSRAMBank1; continues in RunSaveGameSteps_2_Skip2 (E-0347)
; why: part of RunSaveGameSteps_2; RunSaveGameSteps_2: with SRAM enabled runs one save stage per
; call (sprites snapshot and blocks, then records, then the final stage marked by bit 7 of ...
; (E-0352, E-0124, E-0344)
RunSaveGameSteps_2_CallRunSaveGameSteps_2_ClearSRAMBanks2And3::
    call RunSaveGameSteps_2_ClearSRAMBanks2And3
    call BackupRecordsToSRAMBank1
    call SaveGM2TimerFramesBlockToSRAMBank1
    jr RunSaveGameSteps_2_Skip2

; Calls SaveStepCopyBank1RecordSaveRecordIndex; continues in RunSaveGameSteps_2_Skip2; calls
; ComputeSRAMBank1RecordChecksum; sets wSaveStep (E-0347)
; why: part of RunSaveGameSteps_2; RunSaveGameSteps_2: with SRAM enabled runs one save stage per
; call (sprites snapshot and blocks, then records, then the final stage marked by bit 7 of ...
; (E-0352, E-0124, E-0344)
RunSaveGameSteps_2_Skip::
    dec a
    jr nz, .call_compute_sram_bank1_record_checksum
    call SaveStepCopyBank1RecordSaveRecordIndex
    jr RunSaveGameSteps_2_Skip2

.call_compute_sram_bank1_record_checksum:
    call ComputeSRAMBank1RecordChecksum
    ld a, [wSaveStep]
    or $80
    ld [wSaveStep], a

; Sets rRAMG to 0; sets rRAMB to 0 (E-0347)
; why: part of RunSaveGameSteps_2; RunSaveGameSteps_2: with SRAM enabled runs one save stage per
; call (sprites snapshot and blocks, then records, then the final stage marked by bit 7 of ...
; (E-0352, E-0124, E-0344)
RunSaveGameSteps_2_Skip2::
    xor a
    ld [rRAMG], a
    ld [rRAMB], a
    ret

; sums $29A * 10 bytes from sBank1Records in SRAM bank 1 and stores (~sum + $4321) & $FFFF,
; little-endian, at sBank1Checksum (C2 from E-0323: recomputed from the cartridge RAM after a save
; it equals the stored word, 0 before)
ComputeSRAMBank1RecordChecksum::
    ld a, $01
    ld [rRAMB], a
    ld hl, sBank1Records
    ld bc, $029a
    ld de, $0000

.loop:
    ld a, [hli]
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [hli]
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [hli]
    add e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    ld a, [hli]
    add e
    ld e, a
    jr nc, .skip4
    inc d

.skip4:
    ld a, [hli]
    add e
    ld e, a
    jr nc, .skip5
    inc d

.skip5:
    ld a, [hli]
    add e
    ld e, a
    jr nc, .skip6
    inc d

.skip6:
    ld a, [hli]
    add e
    ld e, a
    jr nc, .skip7
    inc d

.skip7:
    ld a, [hli]
    add e
    ld e, a
    jr nc, .skip8
    inc d

.skip8:
    ld a, [hli]
    add e
    ld e, a
    jr nc, .skip9
    inc d

.skip9:
    ld a, [hli]
    add e
    ld e, a
    jr nc, .next
    inc d

.next:
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ld a, e
    xor $ff
    ld e, a
    ld a, d
    xor $ff
    ld d, a
    ld a, e
    add $21
    ld e, a
    ld a, d
    adc $43
    ld d, a
    ld hl, sBank1Checksum
    ld a, e
    ld [hli], a
    ld a, d
    ld [hl], a
    ret

; copies SRAM bank-1 record wSaveRecordIndex ($6F bytes at sBank1Records + $6F * n) through
; PackRecordFieldsToBank1Slot, then wSaveRecordIndex += 1; after 30 records wSaveStep += 1 (the next
; save step) (E-0120)
SaveStepCopyBank1RecordSaveRecordIndex::
    ld a, [wSaveRecordIndex]
    ld [wArg1], a
    ld c, $6f
    call Multiply8
    ld a, l
    add $6f
    ld l, a
    ld a, h
    adc $a0
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
    cp $1e
    ret nz
    ld hl, wSaveStep
    inc [hl]
    ret

; copies the SRAM bank-0 records from sCompactRecords (and the bank-1 record at sRecords) to the
; backup area at sRecordBackup in SRAM bank 1 (E-0127)
BackupRecordsToSRAMBank1::
    ld hl, sCompactRecords
    ld de, sRecordBackup
    ld bc, $0309

.loop:
    push bc
    xor a
    ld [rRAMB], a
    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld b, a
    ld a, $01
    ld [rRAMB], a
    ld a, c
    ld [de], a
    inc de
    ld a, b
    ld [de], a
    inc de
    xor a
    ld [rRAMB], a
    ld a, [hli]
    ld c, a
    ld a, [hli]
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
    or c
    jr nz, .loop
    ld b, $6f

.loop2:
    xor a
    ld [rRAMB], a
    ld a, [hli]
    ld c, a
    ld a, $01
    ld [rRAMB], a
    ld a, c
    ld [de], a
    inc de
    dec b
    jr nz, .loop2
    ld hl, sRecords
    ld b, $6f

.loop3:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop3
    ret

; fills the $2000 bytes of SRAM banks 2 and 3 with $FF (E-0117)
ClearSRAMBanks2And3::
    ld a, $02
    ld [rRAMB], a
    ld hl, sRecords
    ld bc, $2000
    ld a, $ff
    call FillBytes
    ld a, $03
    ld [rRAMB], a
    ld hl, sRecords
    ld bc, $2000
    ld a, $ff
    call FillBytes
    ret

; called from RunSaveGameSteps_2: branches on wSaveClearFlag; calls ClearSRAMBanks2And3; branches on
; wMapType; calls SaveKeyWorldFlagsRecordToSRAMSlotKeyWorldSlot; sets rRAMG to $0a; sets rRAMB to 2;
; sets rRAMB to 3; sets rRAMB to 2; sets rRAMB to 3; sets rRAMB to 2; sets rRAMB to 3; sets rRAMB to
; 2; then 3 more steps (see the code) (E-0347)
; why: a helper of RunSaveGameSteps_2; RunSaveGameSteps_2: with SRAM enabled runs one save stage per
; call (sprites snapshot and blocks, then records, then the final stage marked by bit 7 of ...
; (E-0352, E-0124, E-0344)
RunSaveGameSteps_2_ClearSRAMBanks2And3::
    ld a, [wSaveClearFlag]
    or a
    jr z, .check_map_type
    call ClearSRAMBanks2And3

.check_map_type:
    ld a, [wMapType]
    bit 7, a
    jr z, .skip
    farcall SaveKeyWorldFlagsRecordToSRAMSlotKeyWorldSlot
    ld a, $0a
    ld [rRAMG], a

.skip:
    ld hl, sRecords
    ld bc, $0333
    ld de, $0000

.loop:
    push bc
    ld a, $02
    ld [rRAMB], a
    ld a, [hli]
    ld c, a
    ld a, [hld]
    ld b, a
    ld a, $03
    ld [rRAMB], a
    ld a, c
    ld [hli], a
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, b
    ld [hli], a
    add e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    ld a, $02
    ld [rRAMB], a
    ld a, [hli]
    ld c, a
    ld a, [hld]
    ld b, a
    ld a, $03
    ld [rRAMB], a
    ld a, c
    ld [hli], a
    add e
    ld e, a
    jr nc, .skip4
    inc d

.skip4:
    ld a, b
    ld [hli], a
    add e
    ld e, a
    jr nc, .skip5
    inc d

.skip5:
    ld a, $02
    ld [rRAMB], a
    ld a, [hli]
    ld c, a
    ld a, [hld]
    ld b, a
    ld a, $03
    ld [rRAMB], a
    ld a, c
    ld [hli], a
    add e
    ld e, a
    jr nc, .skip6
    inc d

.skip6:
    ld a, b
    ld [hli], a
    add e
    ld e, a
    jr nc, .skip7
    inc d

.skip7:
    ld a, $02
    ld [rRAMB], a
    ld a, [hli]
    ld c, a
    ld a, [hld]
    ld b, a
    ld a, $03
    ld [rRAMB], a
    ld a, c
    ld [hli], a
    add e
    ld e, a
    jr nc, .skip8
    inc d

.skip8:
    ld a, b
    ld [hli], a
    add e
    ld e, a
    jr nc, .skip9
    inc d

.skip9:
    ld a, $02
    ld [rRAMB], a
    ld a, [hli]
    ld c, a
    ld a, [hld]
    ld b, a
    ld a, $03
    ld [rRAMB], a
    ld a, c
    ld [hli], a
    add e
    ld e, a
    jr nc, .skip10
    inc d

.skip10:
    ld a, b
    ld [hli], a
    add e
    ld e, a
    jr nc, .restore
    inc d

.restore:
    pop bc
    dec bc
    ld a, b
    or c
    jp nz, .loop
    ld a, e
    xor $ff
    ld e, a
    ld a, d
    xor $ff
    ld d, a
    ld a, e
    add $34
    ld e, a
    ld a, d
    adc $12
    ld d, a
    ld a, e
    ld [hli], a
    ld a, d
    ld [hl], a
    ret

; wSpriteSnapshotCount = wScreenSavedFlag and the $50 bytes of wSpriteSlots go to wSpriteSnapshot;
; then clears bit 1 of five object flag bytes at wSnapshotSlot1, wSnapshotSlot2, wSnapshotSlot3,
; wSnapshotSlot4 and wSnapshotSlot5 (E-0109)
SnapshotSpritesForSave::
    ld a, [wScreenSavedFlag]
    ld [wSpriteSnapshotCount], a
    ld hl, wSpriteSlots
    ld de, wSpriteSnapshot
    ld bc, $0050
    call CopyBytes
    ld a, [wSnapshotSlot1]
    and $fd
    ld [wSnapshotSlot1], a
    ld a, [wSnapshotSlot2]
    and $fd
    ld [wSnapshotSlot2], a
    ld a, [wSnapshotSlot3]
    and $fd
    ld [wSnapshotSlot3], a
    ld a, [wSnapshotSlot4]
    and $fd
    ld [wSnapshotSlot4], a
    ld a, [wSnapshotSlot5]
    and $fd
    ld [wSnapshotSlot5], a

; the same walk of CopySaveBlocksToSRAM_Data into SRAM from sSaveData, also clearing the running sum
; in hTemp2/hTemp3 (accumulation not read to its end) (E-0109)
; code: sets rRAMB to 1; sets hTemp2 to 0; sets hTemp3 to 0; copies the byte at
; CopySaveBlocksToSRAM_Data to hTemp0; copies the byte at CopySaveBlocksToSRAM_Data to hTemp1; sets
; sSaveSignature to $55; copies L to sSaveChecksumLo; copies H to sSaveChecksumHi; sets hTemp2; sets
; hTemp3 (E-0347)
CopySaveBlocksToSRAMWithSum::
    ld a, $01
    ld [rRAMB], a
    ld hl, CopySaveBlocksToSRAM_Data
    ld de, sSaveData
    xor a
    ldh [hTemp2], a
    ldh [hTemp3], a

.set_temp0:
    push hl
    ld a, [hli]
    ldh [hTemp0], a
    ld a, [hli]
    ldh [hTemp1], a
    ld a, [hli]
    ld c, a
    ld a, [hl]
    ld b, a
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    ld a, l
    or h
    jr nz, .loop
    pop hl
    ld a, $55
    ld [sSaveSignature], a
    ldh a, [hTemp2]
    ld l, a
    ldh a, [hTemp3]
    ld h, a
    ld a, l
    add $53
    ld l, a
    ld a, h
    adc $97
    ld h, a
    ld a, l
    ld [sSaveChecksumLo], a
    ld a, h
    ld [sSaveChecksumHi], a
    ret

.loop:
    ldh a, [hTemp2]
    add [hl]
    ldh [hTemp2], a
    ldh a, [hTemp3]
    adc $00
    ldh [hTemp3], a
    ld a, [hli]
    ld [de], a
    inc de
    dec bc
    ld a, b
    or c
    jr nz, .loop
    pop hl
    ld a, $04
    add_a_to_hl
    jr .set_temp0

; data read by CopySaveBlocksToSRAM (20 bytes) (E-0347)
CopySaveBlocksToSRAM_Data::
    db $8a, $ff, $0e, $00, $0c, $c6, $91, $02, $d7, $cb, $6b, $00, $42, $cc, $b5, $00
    db $00, $00, $00, $00

; SRAM bank 1: C = $FF when sSaveSignature is not $55 or the checksum of the four saved blocks plus
; $9753 differs from sSaveChecksumLo; otherwise loads them and returns with C unchanged (E-0127)
VerifySaveChecksum::
    ld a, $0a
    ld [rRAMG], a
    ld a, $01
    ld [rRAMB], a
    xor a
    ldh [hTemp2], a
    ldh [hTemp3], a
    ld a, [sSaveSignature]
    cp $55
    jr nz, .skip
    ld hl, sSaveData
    ld de, hPlayerSpriteVariant
    ld bc, $000e
    call CopyBytesWithChecksum_Bank02_2
    ld de, wPlayerName
    ld bc, $0291
    call CopyBytesWithChecksum_Bank02_2
    ld de, wStoryFlags
    ld bc, $006b
    call CopyBytesWithChecksum_Bank02_2
    ld de, wKeyWorldSlot
    ld bc, $00b5
    call CopyBytesWithChecksum_Bank02_2
    ldh a, [hTemp2]
    ld l, a
    ldh a, [hTemp3]
    ld h, a
    ld a, l
    add $53
    ld l, a
    ld a, h
    adc $97
    ld h, a
    ld a, [sSaveChecksumLo]
    ld c, a
    ld a, [sSaveChecksumHi]
    ld b, a
    ld a, c
    sub l
    ld c, a
    ld a, b
    sbc h
    ld b, a
    ld a, b
    or c
    jr z, .skip
    xor a
    ld [rRAMG], a
    ret

.skip:
    xor a
    ld [rRAMG], a
    ld c, $ff
    ret

; HL = source, DE = destination, BC = count: copies BC bytes and adds each one to the 16-bit sum in
; hTemp2/hTemp3; clobbers A, BC = 0 (E-0065) (the same 20 bytes appear in 2 banks)
CopyBytesWithChecksum_Bank02_2::
    ldh a, [hTemp2]
    add [hl]
    ldh [hTemp2], a
    ldh a, [hTemp3]
    adc $00
    ldh [hTemp3], a
    ld a, [hli]
    ld [de], a
    inc de
    dec bc
    ld a, b
    or c
    jr nz, CopyBytesWithChecksum_Bank02_2
    ret

; SRAM bank 1: copies hPlayerSpriteVariant ($0E bytes), wPlayerName ($291), wStoryFlags ($6B) and
; wKeyWorldSlot ($B5) to sSaveData onward while summing them; stores sum + $9753 at sSaveChecksumLo
; and $55 at sSaveSignature (E-0121)
SaveGameToSRAMWithChecksum::
    ld a, $0a
    ld [rRAMG], a
    ld a, $01
    ld [rRAMB], a
    xor a
    ldh [hTemp2], a
    ldh [hTemp3], a
    ld de, sSaveData
    ld hl, hPlayerSpriteVariant
    ld bc, $000e
    call CopyBytesWithChecksum_Bank02
    ld hl, wPlayerName
    ld bc, $0291
    call CopyBytesWithChecksum_Bank02
    ld hl, wStoryFlags
    ld bc, $006b
    call CopyBytesWithChecksum_Bank02
    ld hl, wKeyWorldSlot
    ld bc, $00b5
    call CopyBytesWithChecksum_Bank02
    ldh a, [hTemp2]
    ld l, a
    ldh a, [hTemp3]
    ld h, a
    ld a, l
    add $53
    ld l, a
    ld a, h
    adc $97
    ld h, a
    ld a, l
    ld [sSaveChecksumLo], a
    ld a, h
    ld [sSaveChecksumHi], a
    ld a, $55
    ld [sSaveSignature], a
    xor a
    ld [rRAMG], a
    ret

; HL = source, DE = destination, BC = count: copies BC bytes and adds each one to the 16-bit sum in
; hTemp2/hTemp3; clobbers A, BC = 0 (E-0065) (the same 20 bytes appear in 2 banks)
CopyBytesWithChecksum_Bank02::
    ldh a, [hTemp2]
    add [hl]
    ldh [hTemp2], a
    ldh a, [hTemp3]
    adc $00
    ldh [hTemp3], a
    ld a, [hli]
    ld [de], a
    inc de
    dec bc
    ld a, b
    or c
    jr nz, CopyBytesWithChecksum_Bank02
    ret

; with SRAM enabled: first call runs RestoreRecordsFromSRAMBank1Backup, then scans bank-1 records;
; after stage 2 sets wSaveStep = $80 (E-0124)
RunBank1RecordScanSteps::
    ld a, $0a
    ld [rRAMG], a
    ld a, [wSaveStep]
    or a
    jr nz, .call_scan_bank1_record_step_save_record_index
    inc a
    ld [wSaveStep], a
    call RestoreRecordsFromSRAMBank1Backup

.call_scan_bank1_record_step_save_record_index:
    call ScanBank1RecordStepSaveRecordIndex
    ld a, [wSaveStep]
    cp $02
    jr nz, .done
    ld a, $80
    ld [wSaveStep], a

.done:
    xor a
    ld [rRAMG], a
    ret

; enables SRAM; on the first step backs up the records to SRAM bank 1 (BackupRecordsToSRAMBank1),
; then runs SaveStepCopyBank1RecordSaveRecordIndex until wSaveStep reaches 2 (E-0289)
RunBackupAndSaveSteps::
    ld a, $0a
    ld [rRAMG], a
    ld a, [wSaveStep]
    or a
    jr nz, .call_save_step_copy_bank1_record_save_record
    inc a
    ld [wSaveStep], a
    call BackupRecordsToSRAMBank1

.call_save_step_copy_bank1_record_save_record:
    call SaveStepCopyBank1RecordSaveRecordIndex
    ld a, [wSaveStep]
    cp $02
    jr nz, .done
    ld a, $0a
    ld [rRAMG], a
    call ComputeSRAMBank1RecordChecksum
    ld a, $80
    ld [wSaveStep], a

.done:
    xor a
    ld [rRAMG], a
    ret
    ds $8b9, $00

; data read by StartPaletteFade (1 byte) (E-0347)
StartPaletteFade_WriteFadeLevelAndFadeDelayEtc_Data::
    db $00
