; ROM bank $02: field mode: map play, field states, field menus
; The annotated listing of this bank is build/listing/bank02.asm.

SECTION "Bank 02", ROMX
    db $02

; Sets up the fade timing after StartPaletteFade stored wFadeState. Fading out (bit 7 clear):
; wFadeLevel = 0 and the delay per step = wFadeState / 4. Fading in (bit 7 set): wFadeLevel = $20,
; the delay = (~wFadeState) / 4, and all 32 colours of the BG and OBJ palettes are set to one
; starting colour (the word at StartPaletteFade_WhiteColourAddress, or 0 when wFadeMode bit 7 is
; set) so the fade in starts from a flat screen. (C1, E-0357)
StartPaletteFade_SetUpTiming::
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
    ld de, StartPaletteFade_WhiteColourAddress
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

SECTION "Bank 02 StepCGBFade", ROMX

; One CGB fade step, far-called by StepFade_CGB: while wFadeDelayCounter is non-zero it only counts
; it down. Otherwise wFadeLevel moves by 5: fading out (wFadeState bit 7 clear) it rises to at most
; $1F and WriteAllFadedPalettesFloor writes all 16 palettes; fading in (bit 7 set) it falls to at
; least 0 and WriteAllFadedPalettesAdd writes them. The counter is reloaded from wFadeDelay, and
; wFadeState becomes 0 when the level reaches $1F (out) or 0 (in). (C1, E-0374)
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

SECTION "Bank 02 WriteAllFadedPalettesFloor", ROMX

; Writes the eight BG palettes of wBGPaletteBuffer (rBGPI = $80: palette 0, auto-increment;
; WriteFadedPaletteFloorToBGPD eight times) and then the eight OBJ palettes of wOBJPaletteBuffer
; (rOBPI = $80; WriteFadedPaletteFloorToOBPD) to CGB palette memory, every colour faded by
; FadeColorComponentFloor. StepCGBFade calls it while fading out. (C1, E-0374)
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

SECTION "Bank 02 WriteFadedPaletteFloorToOBPD", ROMX

; One OBJ palette: calls WriteFadedColorFloorToOBPD three times and falls into it for the fourth
; colour, so HL advances 8 bytes and four faded colours go to rOBPD. (C1, E-0374)
; four colours (one palette) from HL through WriteFadedColorFloorToOBPD (E-0076)
WriteFadedPaletteFloorToOBPD::
    call WriteFadedColorFloorToOBPD
    call WriteFadedColorFloorToOBPD
    call WriteFadedColorFloorToOBPD

; Reads one RGB555 colour word at HL (HL += 2), passes red, green and blue through
; FadeColorComponentFloor (DE starts at 0, the faded word collects in DE) and writes it to rOBPD,
; low byte first, after WaitForVRAMAccess with interrupts off. Its first load of wFadeLevel into D
; is overwritten at once. (C1, E-0374)
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

SECTION "Bank 02 WriteFadedPaletteFloorToBGPD", ROMX

; One BG palette: calls WriteFadedColorFloorToBGPD three times and falls into it for the fourth
; colour, so HL advances 8 bytes and four faded colours go to rBGPD. (C1, E-0374)
; four colours (one palette) from HL through WriteFadedColorFloorToBGPD (E-0076)
WriteFadedPaletteFloorToBGPD::
    call WriteFadedColorFloorToBGPD
    call WriteFadedColorFloorToBGPD
    call WriteFadedColorFloorToBGPD

; Reads one RGB555 colour word at HL (HL += 2), passes red, green and blue through
; FadeColorComponentFloor (DE starts at 0, the faded word collects in DE) and writes it to rBGPD,
; low byte first, after WaitForVRAMAccess with interrupts off. (C1, E-0374)
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

SECTION "Bank 02 FadeColorComponentFloor", ROMX

; Fades the 5-bit component in the low bits of C (bits 5-7 of C are kept): with wFadeMode bit 7
; clear it becomes max(component, wFadeLevel), with bit 7 set max(component - wFadeLevel, 0). Then
; B:C:D:E is rotated right 5 bits through carry, bringing the next component down into C while the
; result collects at the top of D:E; the callers make three calls and one more 1-bit rotate, leaving
; the faded colour in DE. A, B, C, D and E change; StepCGBFade uses this form while fading out. (C2,
; E-0374)
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

SECTION "Bank 02 WriteAllFadedPalettesAdd", ROMX

; Writes the eight BG palettes of wBGPaletteBuffer (rBGPI = $80; WriteFadedPaletteAddToBGPD eight
; times) and then the eight OBJ palettes of wOBJPaletteBuffer (rOBPI = $80;
; WriteFadedPaletteAddToOBPD) to CGB palette memory, every colour faded by FadeColorComponentAdd.
; StepCGBFade calls it while fading in. (C1, E-0374)
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

SECTION "Bank 02 WriteFadedPaletteAddToOBPD", ROMX

; One OBJ palette: calls WriteFadedColorAddToOBPD three times and falls into it for the fourth
; colour, so HL advances 8 bytes and four faded colours go to rOBPD. (C1, E-0374)
; four colours (one palette) from HL through WriteFadedColorAddToOBPD (E-0076)
WriteFadedPaletteAddToOBPD::
    call WriteFadedColorAddToOBPD
    call WriteFadedColorAddToOBPD
    call WriteFadedColorAddToOBPD

; Reads one RGB555 colour word at HL (HL += 2), passes red, green and blue through
; FadeColorComponentAdd (DE starts at 0, the faded word collects in DE) and writes it to rOBPD, low
; byte first, after WaitForVRAMAccess with interrupts off. Its first load of wFadeLevel into D is
; overwritten at once. (C1, E-0374)
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

SECTION "Bank 02 WriteFadedPaletteAddToBGPD", ROMX

; One BG palette: calls WriteFadedColorAddToBGPD three times and falls into it for the fourth
; colour, so HL advances 8 bytes and four faded colours go to rBGPD. (C1, E-0374)
; four colours (one palette) from HL through WriteFadedColorAddToBGPD (E-0076)
WriteFadedPaletteAddToBGPD::
    call WriteFadedColorAddToBGPD
    call WriteFadedColorAddToBGPD
    call WriteFadedColorAddToBGPD

; Reads one RGB555 colour word at HL (HL += 2), passes red, green and blue through
; FadeColorComponentAdd (DE starts at 0, the faded word collects in DE) and writes it to rBGPD, low
; byte first, after WaitForVRAMAccess with interrupts off. (C1, E-0374)
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

SECTION "Bank 02 FadeColorComponentAdd", ROMX

; Fades the 5-bit component in the low bits of C (bits 5-7 of C are kept): with wFadeMode bit 7
; clear it becomes min(component + wFadeLevel, $1F), with bit 7 set max(component - wFadeLevel, 0).
; Then B:C:D:E is rotated right 5 bits through carry, bringing the next component down into C while
; the result collects at the top of D:E; the callers make three calls and one more 1-bit rotate,
; leaving the faded colour in DE. StepCGBFade uses this form while fading in. (C2, E-0374)
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

SECTION "Bank 02 CopyBGPalettesToBuffer", ROMX

; On CGB (wIsCGB non-zero) copies B palettes (8 bytes each, 8 * B taken as a byte) from HL to
; wBGPaletteBuffer + 8 * C; HL and DE end past the copy, B = 0. It does not set
; wBGPaletteUploadRequest. Nothing in src/ calls it or points to it. (C2, E-0374)
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

SECTION "Bank 02 CopyOBJPalettesToBuffer", ROMX

; On CGB (wIsCGB non-zero) copies B palettes (8 bytes each, 8 * B taken as a byte) from HL to
; wOBJPaletteBuffer + 8 * C; HL and DE end past the copy, B = 0. It does not set
; wOBJPaletteUploadRequest. Nothing in src/ calls it or points to it. (C2, E-0374)
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

SECTION "Bank 02 LoadPalette0FromData_Bank02", ROMX

; On CGB copies the 8-byte palette LoadPalette0FromData_Bank02_Data into palette 0 of
; wBGPaletteBuffer and of wOBJPaletteBuffer (CopyBytesDEToHL_Bank00) and sets
; wBGPaletteUploadRequest and wOBJPaletteUploadRequest to $7F; on other hardware it returns at once.
; The start-up code in bank 0 far-calls it on CGB after clearing rVBK, rSVBK and rRP. (C2, E-0374)
; on CGB copies the 8-byte palette LoadPalette0FromData_Bank02_Data into wBGPaletteBuffer and
; wOBJPaletteBuffer and sets the upload requests wBGPaletteUploadRequest and
; wOBJPaletteUploadRequest = $7F (E-0117) (E-0344: the address in its name dropped or read as the
; label there; was LoadPalette0FromData_Bank02)
LoadPalette0FromData_Bank02::
    ld a, [wIsCGB]
    or a
    ret z
    ld hl, wBGPaletteBuffer
    ld de, LoadPalette0FromData_Bank02_Data
    ld bc, $0008
    call CopyBytesDEToHL_Bank00
    ld a, $7f
    ld [wBGPaletteUploadRequest], a
    ld hl, wOBJPaletteBuffer
    ld de, LoadPalette0FromData_Bank02_Data
    ld bc, $0008
    call CopyBytesDEToHL_Bank00
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    ret

SECTION "Bank 02 LoadPalette0FromData_Bank02_Data", ROMX

; Four little-endian RGB555 colours, $7C00 (pure blue), $7FFF (white), $01E0 (a mid green) and $0000
; (black): one CGB palette. LoadPalette0FromData_Bank02 copies it to wBGPaletteBuffer and to
; wOBJPaletteBuffer and sets wBGPaletteUploadRequest and wOBJPaletteUploadRequest to $7F, only when
; wIsCGB is non-zero. (C1, E-0381)
LoadPalette0FromData_Bank02_Data::
    db $00, $7c, $ff, $7f, $e0, $01, $00, $00

; CGB step of the warp effect's palette animation, called by WarpEffect_FadePalette: returns at once
; unless wIsCGB is set; runs one palette upload step (RunScreenStateStepEveryOtherFrame), then
; copies wDMGPaletteBGP into wDMGPaletteBytes when it has changed and goes on to
; WarpEffect_FadePalette_SyncCGB_OBP0 for wDMGPaletteOBP0. (C1, E-0369)
WarpEffect_FadePalette_SyncCGB::
    ld a, [wIsCGB]
    or a
    ret z
    call RunScreenStateStepEveryOtherFrame
    ld hl, wDMGPaletteBytes
    ld a, [wDMGPaletteBGP]
    cp [hl]
    jp z, WarpEffect_FadePalette_SyncCGB_OBP0
    ld a, [wDMGPaletteBGP]
    ld [wDMGPaletteBytes], a
    jp WarpEffect_FadePalette_SyncCGB_OBP0

SECTION "Bank 02 RunScreenStateStepEveryOtherFrame", ROMX

; Adds 1 to wScreenStep and, on odd values only, unless wScreenState is $FF, runs one upload step of
; the warp-effect palette animation picked by wScreenState: 0
; RunScreenStateStepEveryOtherFrame_UploadBGPal01, 1
; RunScreenStateStepEveryOtherFrame_UploadBGPal23, 2
; RunScreenStateStepEveryOtherFrame_UploadBGPal45, 3 AnimateFieldMenuPalette67. Each uploads two BG
; palettes of frame wScreenCounter from wWorkBuf (precomputed by
; WarpEffect_Cover_BuildBrightPalettes) and moves to the next state; the last moves to the next
; frame, and after 8 frames sets wScreenState to $FF. WarpEffect_FadePalette_SyncCGB calls it. (C1,
; E-0374)
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
    dw RunScreenStateStepEveryOtherFrame_UploadBGPal01
    dw RunScreenStateStepEveryOtherFrame_UploadBGPal23
    dw RunScreenStateStepEveryOtherFrame_UploadBGPal45
    dw AnimateFieldMenuPalette67

; Uploads BG palettes 0-1 (8 colours) for frame wScreenCounter of a palette animation: from wWorkBuf
; + wScreenCounter * $40, starting at palette index 0 (rBGPI = $80). (C1, E-0357)
RunScreenStateStepEveryOtherFrame_UploadBGPal01::
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

; Writes 16 bytes (8 colours) from HL to the palette data register DE, each pair after waiting for
; VRAM access, then moves to the next upload step (wScreenState + 1). (C1, E-0357)
RunScreenStateStepEveryOtherFrame_UploadColors::
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

SECTION "Bank 02 RunScreenStateStepEveryOtherFrame_UploadBGPal23", ROMX

; Uploads BG palettes 2-3 for the current animation frame: from wWorkBuf + $10 + wScreenCounter *
; $40, starting at palette index $10. (C1, E-0357)
RunScreenStateStepEveryOtherFrame_UploadBGPal23::
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
    jp RunScreenStateStepEveryOtherFrame_UploadColors

SECTION "Bank 02 RunScreenStateStepEveryOtherFrame_UploadBGPal45", ROMX

; Uploads BG palettes 4-5 for the current animation frame: from wWorkBuf + $20 + wScreenCounter *
; $40, starting at palette index $20. (C1, E-0357)
RunScreenStateStepEveryOtherFrame_UploadBGPal45::
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
    jp RunScreenStateStepEveryOtherFrame_UploadColors

SECTION "Bank 02 AnimateFieldMenuPalette67", ROMX

; Uploads BG palettes 6-7 for the current animation frame (wWorkBuf + $30, index $30), then moves to
; the next frame; after 8 frames the animation stops (wScreenState = $FF). (C1, E-0357)
AnimateFieldMenuPalette67::
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
    call RunScreenStateStepEveryOtherFrame_UploadColors
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

SECTION "Bank 02 WarpEffect_Cover_BuildBrightPalettes", ROMX

; Called by WarpEffect_Cover (warp effect step 1): precomputes the 8 frames of the warp effect's
; palette animation into wWorkBuf, 64 bytes per frame: for each frame (wScreenCounter 0-7) it
; brightens all eight palettes of wBGPaletteBuffer by that frame's step (BrightenFieldMenuColors, 16
; bytes at a time), then resets wScreenCounter to 0. (C2, E-0369; probed E-0374)
WarpEffect_Cover_BuildBrightPalettes::
    ld hl, wBGPaletteBuffer
    ld de, wWorkBuf
    ld c, $04

.loop:
    push bc
    push hl
    push de
    call BrightenFieldMenuColors
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

SECTION "Bank 02 BrightenFieldMenuColors", ROMX

; Brightens colours for frame wScreenCounter of the warp-effect palette animation
; (WarpEffect_Cover_BuildBrightPalettes calls it four times per frame): for each colour from
; wScreenSubStep up to 8 (eight colours, 16 bytes, when it starts at 0) it reads the word at HL,
; splits it into blue, green and red (wTextCounter2, wTextCounter3, wTextCounter4), adds
; BrightenFieldMenuColors_Data[wScreenCounter] (4, 8, ... $20 for frames 0-7) to each, caps each at
; 31 and stores the word at DE. wScreenSubStep ends 0; HL and DE end past the colours. (C2, E-0374)
BrightenFieldMenuColors::
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
    ld hl, BrightenFieldMenuColors_Data
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
    jr c, BrightenFieldMenuColors
    xor a
    ld [wScreenSubStep], a
    ret

SECTION "Bank 02 BrightenFieldMenuColors_Data", ROMX

; Nine amounts, $04, $08, ... $24 in steps of 4, indexed by the frame number wScreenCounter.
; BrightenFieldMenuColors adds the amount to each 5-bit blue, green and red part of the colours of
; the warp effect palette and caps each part at 31. wScreenCounter wraps to 0 after 7 in the caller,
; so this reader uses only $04-$20 and never reaches the last byte $24. (C1, E-0381)
BrightenFieldMenuColors_Data::
    db $04, $08, $0c, $10, $14, $18, $1c, $20, $24

; Copies wDMGPaletteOBP0 into wDMGPaletteBytes + 1 when it has changed. (C2, E-0357; probed E-0374)
WarpEffect_FadePalette_SyncCGB_OBP0::
    ld hl, wDMGPaletteBytes + $1
    ld a, [wDMGPaletteOBP0]
    cp [hl]
    jp z, WarpEffect_FadePalette_SyncCGB_Done
    ld a, [wDMGPaletteOBP0]
    ld [wDMGPaletteBytes + $1], a
    jp WarpEffect_FadePalette_SyncCGB_Done

SECTION "Bank 02 WriteCGBObjPaletteFromDMGShadesDMGPaletteOBP0", ROMX

; Writes four colours to rOBPD (at the current rOBPI, which it does not set), one for each 2-bit
; shade of wDMGPaletteOBP0 (bits 0-1, 2-3, 4-5, 6-7): the colour word at HL +
; WriteCGBObjPaletteFromDMGShadesDMGPaletteOBP0_Data[shade] (offsets 2, 4, 0, 6), each written after
; WaitForVRAMAccess with interrupts off. HL ends 8 bytes on. Nothing in src/ calls it or points to
; it. (C1, E-0374)
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

SECTION "Bank 02 WarpEffect_FadePalette_SyncCGB_Done", ROMX

; The end of WarpEffect_FadePalette_SyncCGB_OBP0 (both of its paths jump here): returns. (C2,
; E-0369; probed E-0374)
WarpEffect_FadePalette_SyncCGB_Done::
    ret

SECTION "Bank 02 WriteCGBObjPaletteFromDMGShadesDMGPaletteOBP0_Data", ROMX

; Four byte offsets, $02, $04, $00, $06, indexed by a 2-bit DMG shade (0-3): the byte offset of the
; colour in the four-colour source palette at HL that stands for that shade (shade 0 takes colour 1,
; shade 1 colour 2, shade 2 colour 0, shade 3 colour 3).
; WriteCGBObjPaletteFromDMGShadesDMGPaletteOBP0 takes each of the four 2-bit fields of
; wDMGPaletteOBP0 in turn, adds the offset to HL and writes that colour word to rOBPD. (C1, E-0381)
WriteCGBObjPaletteFromDMGShadesDMGPaletteOBP0_Data::
    db $02, $04, $00, $06

; Start-up for game mode 1, the field (RunGameModeInit_Field far-calls it): clears the STAT
; interrupt sources and rIF; resets the sound hardware on map $38 at screen (0, 0) and when
; wSaveStateFlag is set; loads the Super Game Boy border set returned by
; GameMode1_Init_PickSGBBorderSet (LoadSGBBorderForSetA), decompresses LetterFrameIconDigitTiles to
; vTiles1, sends the SGB palette set and attribute file from GameMode1_Init_Data1/Data2 (both 0) and
; builds the field (InitFieldScreen). It clears wFieldTransitionStep; when wFieldInitStage is 0 it
; also resets the sound and restarts the map music. Then it clears wFieldInitStage, sets wLCDCShadow
; = 3 and finishes with ResumeAfterModeChange (A = 3). (C1, E-0374)
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
    call GameMode1_Init_PickSGBBorderSet
    call LoadSGBBorderForSetA
    ld b, BANK(LetterFrameIconDigitTiles)
    ld de, LetterFrameIconDigitTiles
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
    jp ResumeAfterModeChange

SECTION "Bank 02 InitFieldScreen", ROMX

; Enters the field on the current map: sets hFieldDrawFlags $0F, loads the map header, resets the
; scroll, the window (hWindowY $80, hWindowX 7), rLYC ($67), the frame counter and the STAT split,
; moves fallen party members back (MoveIncapacitatedPartyMembersBack twice), sets up town and
; key-world objects, writes the name of the player to wTextBuf0, loads the name tiles (except on map
; $14 outside a key world), the player and follower sprites and the screen triggers, and clears
; wFieldActionRequest. With wFieldReturnPhase 0 it loads the map screen and its objects; otherwise
; it restores the saved screen (RestoreScreenBufferFromBGMap1). It draws the screen buffer to
; vBGMap0, places special objects, clears the text and party window state, runs the field command in
; wFieldInitFlag when bit 7 is set, restarts the map music when wFieldInitStage is 0, sends the SGB
; palettes (SendSGBFieldPaletteSet), runs the entry phase (RunFieldReturnPhase), clears
; hFieldDrawFlags and on CGB requests an OBJ palette upload. (C1, E-0374)
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

SECTION "Bank 02 WritePlayerNameWithFlag0SuffixToTextBuf0", ROMX

; Copies the 10-byte name of the player (wPlayerName) to wTextBuf0 with $F0 at wTextBuf0 + $A, then
; writes three bytes at + $C: $58 $87 $F0 when story flag 0 (EVENT_NEVER_SET) is set, else $87 $60
; $F0; byte + $B is not written. InitFieldScreen calls it, and menus in banks $0C, $14, $15, $1C and
; $1E far-call it before showing the name. (C2, E-0374)
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

SECTION "Bank 02 RunFieldReturnPhase", ROMX

; The field entry phase at the end of InitFieldScreen, by wFieldReturnPhase & 3: 0 and 3
; RunFieldReturnPhase_Phase0 (picks the field state and starts the fade in), 1
; RunFieldReturnPhase_RunReturnAction (runs the return action in wDataBankSave, such as opening the
; field menu or a talk event), 2 RunFieldReturnPhase_AfterBattle (heals, relocates or resets the
; lead after a battle, by wBattleKind and wBattleScene). (C1, E-0374)
; what the field does as it is entered (InitFieldScreen), by wFieldReturnPhase & 3: phases 0 and 3
; set the field and menu state, 1 opens the field menu on A, 2 resets fields $55 and $5B of the lead
; record (E-0354; was: runs the routine for wFieldReturnPhase & 3 (jump table; phase 3 reuses phase
; 0) (E-0122))
RunFieldReturnPhase::
    ld a, [wFieldReturnPhase]
    and $03
    jumptable
    dw RunFieldReturnPhase_Phase0
    dw RunFieldReturnPhase_RunReturnAction
    dw RunFieldReturnPhase_AfterBattle
    dw RunFieldReturnPhase_Phase0

; Field entry phase 0 (also the end of phase 2): clears the phase; coming from the field menu
; (wModeState 6) it reopens the menu at state 5; otherwise it picks the field state (1 when a script
; is running, 5 on a key-world map, else 0) and starts the fade in ($FC), unless the SGB is still
; setting up the field. (C1, E-0357)
RunFieldReturnPhase_Phase0::
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

SECTION "Bank 02 RunFieldReturnPhase_AfterBattle", ROMX

; Field entry phase 2, after a battle. Battle kind 5 fully heals the party, moves fallen members to
; the back, reloads the name tiles and sprites and continues normally. Scene 3, or kind 4 (also for
; scene 2), fully heals the party and returns the player to map 4, screen (1, 0), resuming the
; script saved before the battle (wScriptReturn). Kinds 6 and 7 reset the lead's record fields. Any
; other scene and kind sends the player to map 5, screen (1, 0) at ($50, $30) facing down (or up
; after EVENT_THANKS_FOR_COMING_BY_025), saving a key world first, then play the map music and run
; talk event group 5. (C1, E-0357)
RunFieldReturnPhase_AfterBattle::
    ld a, [wBattleKind]
    cp $05
    jp z, .call_fully_heal_party2
    ld a, [wBattleScene]
    or a
    jr z, RunFieldReturnPhase_Phase0
    cp $03
    jp z, .call_fully_heal_party
    cp $02
    jr nz, .check_battle_kind
    ld a, [wBattleKind]
    cp $04
    jr nz, RunFieldReturnPhase_Phase0

.check_battle_kind:
    ld a, [wBattleKind]
    cp $04
    jp z, .call_fully_heal_party
    cp $06
    jr z, .call_revive_lead_monster_at_one_hp
    cp $07
    jr nz, .clear_field_return_phase

.call_revive_lead_monster_at_one_hp:
    call ReviveLeadMonsterAtOneHP
    jr RunFieldReturnPhase_Phase0

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
    jp RunFieldReturnPhase_Phase0

SECTION "Bank 02 RunFieldReturnPhase_RunReturnAction", ROMX

; Field entry phase 1: runs the return action stored in wDataBankSave. 0 opens the field menu (as if
; A were pressed); $40 restarts the field set-up; with bit 7 set it is a key-world return: the key
; index goes to wCurrentKeyIndex, EVENT_COBI_HERO_WHILE_YOURE is set when byte 3 of the key's 4-byte
; entry (from $C707) has bit 7 set and its byte 0 is not 1, and the field menu opens at state 6.
; Values 1-9 start a talk event (group $19; groups 8, 6 or 7 after resetting the followers with
; music 2 and sound $67; group $39, $6A, $A1 or $AA; or RunFieldReturnPhase_AfterLogTwig), others
; group 9. (C1, E-0357)
RunFieldReturnPhase_RunReturnAction::
    xor a
    ld [wFieldReturnPhase], a
    call RunFieldReturnPhase_RunReturnAction_ShowGiftEgg
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
    farcall RunFieldReturnPhase_AfterLogTwig
    ret

.set_talk_event_group_to_09:
    ld a, $09
    ld [wTalkEventGroup], a
    xor a
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    ret

SECTION "Bank 02 ResetFollowersToPlayer", ROMX

; Sets hPlayerFacing and the three follower directions to 0 (down), puts every follower on
; hPlayerX/hPlayerY (their targets are kept) and clears wDataBankSave.
; RunFieldReturnPhase_RunReturnAction calls it before talk event groups 8, 6 and 7. (C2, E-0374)
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

SECTION "Bank 02 ReviveLeadMonsterAtOneHP", ROMX

; With SRAM enabled (the bank already mapped), sets MON_STATUS of the lead record (wPartyList, used
; as the record number) to 0 and the MON_HP word to 1, disables SRAM and reloads the player and
; follower sprites (LoadPlayerAndFollowerSpriteGraphics). RunFieldReturnPhase_AfterBattle calls it
; after battle kinds 6 and 7, so the lead monster is no longer marked dead (MON_STATUS bit 7) and
; has 1 HP. (C1, E-0374)
; for the lead record wPartyList: field $55 = 0, field $5B = $0001, then far-calls
; LoadPlayerAndFollowerSpriteGraphics (E-0122)
ReviveLeadMonsterAtOneHP::
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

SECTION "Bank 02 RunFieldReturnPhase_RunReturnAction_ShowGiftEgg", ROMX

; On map 0 at screen (0, 3), outside a key world, when wGiftRecord is 1: places script object 5,
; running field command $15 once first (when wCounterPtr0Lo is $FF). (C1, E-0357)
RunFieldReturnPhase_RunReturnAction_ShowGiftEgg::
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

SECTION "Bank 02 GameMode1_Init_PickSGBBorderSet", ROMX

; Returns A = the Super Game Boy border set that GameMode1_Init passes to LoadSGBBorderForSetA: 2 on
; maps below $20 outside a key world (wMapType bit 7 clear) and on map $38 at screen (0, 0),
; otherwise 4 (always 4 in a key world). (C2, E-0374)
GameMode1_Init_PickSGBBorderSet::
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

SECTION "Bank 02 GameMode1_Init_Data1", ROMX

; One byte, $00: the Super Game Boy palette set number. GameMode1_Init copies it to wSGBPaletteSet
; before it calls SendSGBPaletteSetPacket. (C1, E-0381)
GameMode1_Init_Data1::
    db $00

; One byte, $00: the Super Game Boy attribute file number. GameMode1_Init copies it to wSGBAttrFile
; before it calls SendSGBPaletteSetPacket. (C1, E-0381)
GameMode1_Init_Data2::
    db $00

; Per-frame routine of game mode 1, the field (RunGameModeUpdate_Field far-calls it): while
; wFieldInitStage is 2 it jumps to GameMode1_Update_FinishFieldSetup instead; otherwise it falls
; into FieldModeStateDispatch. (C1, E-0374)
; per-frame routine for wGameMode = 1
GameMode1_Update::
    ld a, [wFieldInitStage]
    cp $02
    jp z, GameMode1_Update_FinishFieldSetup

; Advances the play time (IncrementPlayTime), then runs the field state wModeState & $0F: 0
; FieldState_WalkATalks, 1 FieldState_RunScript, 2 FieldState_Still, 3 FieldState_BattleTransition,
; 4 FieldState_MapTransition, 5 FieldState_WalkAMenu, 6 FieldState_FieldMenu, 7
; FieldState_StepChecks, 8 FieldState_WorldMap; values 9-15 have no entry (as read).
; GameMode1_Update falls into it and GameMode1_Update_FinishFieldSetup calls it once. (C1, E-0374)
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

; Field state 0, walking outside a key world. Unless a fade runs (wFadeState): Select may open the
; world map (TryOpenWorldMap; returns when hTemp0 is set); then the step triggers, the Down-held
; talk spots (FieldState_WalkATalks_TalkAtSpotOnDown), the player movement and the field action run;
; a newly pressed A checks in turn the tile ahead (CheckInteractionInFront), the trigger cell, map
; interactions and special tiles (CheckTileInFrontOnA) before OpenFieldMenuOnA (hTemp8 = 0). Every
; frame ends with the field sprites, FieldStateCommonUpdate, the trigger marker, the field event
; (RunFieldEventFieldEventKind) and FarClearRollCounterWhenGM2TimerMinutesIs59. (C1, E-0374)
; field state 0: walking on a map; Select may open the world map (TryOpenWorldMap), A checks for
; someone or something in front (CheckInteractionInFront) (E-0339)
FieldState_WalkATalks::
    ld a, [wFadeState]
    or a
    jp nz, .call_draw_field_sprites
    ld a, [wJoypadPressed]
    bit 2, a
    jr z, .call_field_state_walk_a_talks_run_step
    farcall TryOpenWorldMap
    ldh a, [hTemp0]
    or a
    ret nz

.call_field_state_walk_a_talks_run_step:
    farcall FieldState_WalkATalks_RunStepTriggers
    call FieldState_WalkATalks_TalkAtSpotOnDown
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

SECTION "Bank 02 FieldState_RunScript", ROMX

; Field state 1, a script is running (RunFieldReturnPhase_Phase0 picks it when wScriptRunning is
; set): runs one frame of the event script (RunEventScriptFrame) and the text window
; (StepTextWindowOpenClose); when wScriptCommandType is $05 or $83 it also moves the player
; (UpdatePlayerMovement, RunFieldActionRequestActionIfBit7). Then the field sprites,
; FieldStateCommonUpdate, the trigger marker, the field event and
; FarClearRollCounterWhenGM2TimerMinutesIs59. (C1, E-0374)
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

SECTION "Bank 02 FieldState_Still", ROMX

; Field state 2: runs FieldState_Still_ChoosePage, then the field sprites, FieldStateCommonUpdate,
; the trigger marker, the field event and FarClearRollCounterWhenGM2TimerMinutesIs59, with no player
; movement. (C1, E-0374)
; field state 2: draws the field sprites and runs the common update without player input (E-0339)
FieldState_Still::
    call FieldState_Still_ChoosePage
    farcall DrawFieldSprites
    farcall FieldStateCommonUpdate
    farcall RunDrawTriggerMarkerSprite
    call RunFieldEventFieldEventKind
    call FarClearRollCounterWhenGM2TimerMinutesIs59
    ret

SECTION "Bank 02 FieldState_BattleTransition", ROMX

; Field state 3: runs one step of the battle transition (RunBattleTransitionStep), then the field
; sprites, FieldStateCommonUpdate, the trigger marker and the field event (no timer check). (C1,
; E-0374)
; field state 3: runs a step of the battle transition (E-0339)
FieldState_BattleTransition::
    farcall RunBattleTransitionStep
    farcall DrawFieldSprites
    farcall FieldStateCommonUpdate
    farcall RunDrawTriggerMarkerSprite
    call RunFieldEventFieldEventKind
    ret

SECTION "Bank 02 FieldState_MapTransition", ROMX

; Field state 4, a map change: draws the field sprites, advances the player animation, the trigger
; marker and the field event, and returns while a fade runs. At step 0 (wFieldTransitionStep & $7F)
; it sets wTriggerKind $FF, runs FieldState_MapTransition_AfterWarp, takes the key-world size
; (wMapType $80, wKeyWorldWidth/Height) when wWarpDestFacing is $F0, and places the player
; (FieldState_MapTransition_PlacePlayer, which advances the step). At later steps: with bit 7 set it
; restarts game mode 1 (wGameMode 1, wModeChangeRequest + 1, wFieldInitStage 0) in field state 0, or
; 5 in a key world; otherwise it adds 1 to wFieldInitStage, plays the map music, clears
; wFieldReturnPhase and rebuilds the field (InitFieldScreen). (C1, E-0374)
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
    farcall FieldState_MapTransition_AfterWarp
    ld a, [wWarpDestFacing]
    cp $f0
    jr nz, .call_field_state_map_transition_place_player
    push af
    ld a, $80
    ld [wMapType], a
    ld a, [wKeyWorldWidth]
    ld [wMapWidthScreens], a
    ld a, [wKeyWorldHeight]
    ld [wMapHeightScreens], a
    pop af

.call_field_state_map_transition_place_player:
    call FieldState_MapTransition_PlacePlayer
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

SECTION "Bank 02 FieldState_MapTransition_PlacePlayer", ROMX

; Field transition: places the player after a warp. A non-zero wFieldTransitionKind first sets
; hPlayerFacing to the kind - 1. A return warp (wReturnWarpFlag, cleared here) goes to map 5, screen
; (1, 0) with wMapType 0, facing up when EVENT_THANKS_FOR_COMING_BY_025 is set. The position comes
; from the saved player state when wSavedPositionValid is set (restoring the followers too and
; clearing that flag), otherwise from the warp destination (wWarpDestX/Y) with the followers on the
; player. Then the next transition step (wFieldTransitionStep + 1); on the warp-destination path,
; arriving on map 5 outside a key world also clears the map type, hPlayerSpriteOverride and
; wWorldMapByFieldSkill. (C2, E-0369; probed E-0374)
FieldState_MapTransition_PlacePlayer::
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

SECTION "Bank 02 FieldState_WalkAMenu", ROMX

; Field state 5, walking in a key world (RunFieldReturnPhase_Phase0 picks it when wMapType bit 7 is
; set). Unless a fade runs: Select may open the world map; then movement and the field action; a
; newly pressed A checks the exit spot (FieldState_WalkAMenu_CheckAButtonExit), the trigger cell,
; the key-world item (FieldState_WalkAMenu_CheckKeyWorldItemOnA), map interactions and special tiles
; before OpenFieldMenuOnA (hTemp8 = 0); there is no talk check. It ends with the field sprites,
; FieldStateCommonUpdate, the trigger marker, the field event and
; FarClearRollCounterWhenGM2TimerMinutesIs59. (C1, E-0374)
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
    call FieldState_WalkAMenu_CheckAButtonExit
    farcall CheckTriggerCellOnA
    farcall FieldState_WalkAMenu_CheckKeyWorldItemOnA
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

SECTION "Bank 02 FieldState_FieldMenu", ROMX

; Field state 6: runs WarpEffect (the field menu and warp effects, as earlier readings name it),
; then FieldStateCommonUpdate only while wMenuSubState is 0. RunFieldReturnPhase_Phase0 reopens it
; at wMenuState 5, and RunFieldReturnPhase_RunReturnAction enters it after a key-world return. (C1,
; E-0374)
; field state 6: runs the field menu (WarpEffect) (E-0339)
FieldState_FieldMenu::
    farcall WarpEffect
    ld a, [wMenuSubState]
    or a
    jr nz, .return
    farcall FieldStateCommonUpdate

.return:
    ret

SECTION "Bank 02 FieldState_StepChecks", ROMX

; Field state 7, after a step: runs FieldState_StepChecks_HarmfulFloor, FieldStateCommonUpdate and
; DrawTriggerMarkerSprite; while wModeState is still 7 it returns there. Otherwise it clears
; wScriptRunning, ticks the random encounter counter, checks step triggers
; (CheckStepTriggerAndDispatchTalk) and warps (CheckWarpsAtPlayerPosition) and clears
; wFieldStepFlags. (C1, E-0374)
; field state 7: after a step: the trigger marker, the random encounter counter, step triggers and
; warps (E-0339)
FieldState_StepChecks::
    farcall FieldState_StepChecks_HarmfulFloor
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

SECTION "Bank 02 FieldState_WorldMap", ROMX

; Field state 8, the world map: runs RunWorldMapState and
; FarClearRollCounterWhenGM2TimerMinutesIs59. An earlier emulator run saw Select on map $30 switch
; to this state and show the Water region of the world map. (C1, E-0374)
; field state 8: the world map (RunWorldMapState) (C2 from E-0339: Select on map $30 switches to
; this state and the world map shows the Water region)
FieldState_WorldMap::
    farcall RunWorldMapState
    call FarClearRollCounterWhenGM2TimerMinutesIs59
    ret

SECTION "Bank 02 FarClearRollCounterWhenGM2TimerMinutesIs59", ROMX

; Called every frame by field states 0, 1, 2, 5 and 8: when the timer block reads wGM2TimerMinutes
; $3B (59), wGM2TimerSeconds 0 and wGM2TimerFrames 0 it far-calls
; ClearRollCounterWhenGM2TimerMinutesIs59, which repeats the check, clears wGiftCount and falls into
; ApplyGiftEffectByItem (the effect of the pending gift wPendingGiftItem); otherwise it returns at
; once. (C2, E-0374)
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

SECTION "Bank 02 CheckTileInFrontOnA", ROMX

; A-button check for special tiles in field states 0 and 5. Returns unless wMapSpriteKind is
; non-zero, no fade or text window runs, no field action is pending (wFieldActionRequest bit 7), no
; step is in progress (hPlayerStateFlags bit 0) and A is newly pressed. It reads the tiles 16 pixels
; ahead by hPlayerFacing (0 down, 1 right, 2 up, 3 left; it returns at the screen edge) with
; TileBlockedAtPixel. With a high nibble in wMapSpriteKind and EVENT_SCENE_MERMAID_KINGDOM set
; (TestFlag1FAsBool) it sets wTileActionKind to 1 and tries TryHeaderTileTalkEvent, returning when
; that ran. Then, when the low nibble is non-zero, it needs MapSpriteKindUnlocked (wTileActionKind =
; 1) unless hPlayerStateFlags bit 3 is set, and runs CheckTallTileInFront. (C1, E-0374)
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

SECTION "Bank 02 TestFlag1FAsBool", ROMX

; Returns A = 1 when EVENT_SCENE_MERMAID_KINGDOM (story flag $1F) is set, else A = 0 (TestFlagBit;
; DE, B and C change). CheckTileInFrontOnA uses it for the high-nibble special tiles. (C2, E-0374)
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

SECTION "Bank 02 MapSpriteKindUnlocked", ROMX

; Returns A = 1 when the story flag for the low nibble of wMapSpriteKind is set: kind 1 needs
; EVENT_SCENE_RIVAL_DEFEATED (flag $1D), any other kind EVENT_SCENE_SHIELD2 (flag $1E); else A = 0.
; CheckTileInFrontOnA calls it before CheckTallTileInFront. (C2, E-0374)
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

SECTION "Bank 02 TryHeaderTileTalkEvent", ROMX

; Unless hPlayerStateFlags bit 3 is set: when the first tile of wTilesUnderPoint (top left of the
; block ahead, from TileBlockedAtPixel) equals wMapEventTile, starts talk event group 2, index 0
; (DispatchTalkEvent), clears wJoypadHeld and wJoypadPressed, redraws the screen when the party
; window is shown (wPartyWindowFlags bit 7) and returns A = 1; otherwise A = 0. (C1, E-0374)
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

SECTION "Bank 02 CheckTallTileInFront", ROMX

; Called by CheckTileInFrontOnA with wTilesUnderPoint holding the 2 x 2 tiles ahead. With
; hPlayerStateFlags bit 3 clear it starts talk event group 1, index 0 (DispatchTalkEvent) when any
; of the four is at most wMapTallTileMin; with bit 3 set it starts that event only when all four are
; above wMaxBlockingTile. After the event it clears wJoypadHeld and wJoypadPressed and redraws the
; screen when wPartyWindowFlags bit 7 is set. (C1, E-0374)
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

SECTION "Bank 02 FieldState_WalkAMenu_CheckAButtonExit", ROMX

; Field state 5's A button: when no fade, text, pending action or step is in progress and A is
; pressed, runs the check for the map type (wMapType & 7): key-world maps 3 and 7 can be left from
; here. (C1, E-0357)
FieldState_WalkAMenu_CheckAButtonExit::
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
    dw FieldState_WalkAMenu_NoExit
    dw FieldState_WalkAMenu_NoExit
    dw FieldState_WalkAMenu_NoExit
    dw FieldState_WalkAMenu_CheckKeyWorldExit
    dw FieldState_WalkAMenu_NoExit
    dw FieldState_WalkAMenu_NoExit
    dw FieldState_WalkAMenu_NoExit
    dw FieldState_WalkAMenu_CheckExitFacingUp

; Map types without an A-button exit: returns. (C2, E-0357; probed E-0374)
FieldState_WalkAMenu_NoExit::
    ret

SECTION "Bank 02 FieldState_WalkAMenu_CheckKeyWorldExit", ROMX

; A-button exit check on a key-world floor (map type 3): only on floors whose info byte is 1, facing
; up at screen row 1, position ($80, $10) (the exit spot); type 6 floors never. (C1, E-0357)
FieldState_WalkAMenu_CheckKeyWorldExit::
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
    jr FieldState_WalkAMenu_LeaveKeyWorld

.return:
    ret

SECTION "Bank 02 FieldState_WalkAMenu_CheckExitFacingUp", ROMX

; A-button exit check on map type 7: facing up at position ($40, $40). (C1, E-0357)
FieldState_WalkAMenu_CheckExitFacingUp::
    ldh a, [hPlayerFacing]
    cp $02
    ret nz
    ldh a, [hPlayerX]
    cp $40
    ret nz
    ldh a, [hPlayerY]
    cp $40
    ret nz
    jr FieldState_WalkAMenu_LeaveKeyWorld

SECTION "Bank 02 FieldState_WalkAMenu_LeaveKeyWorld", ROMX

; Leaves the key world from field state 5 (FieldState_WalkAMenu_CheckKeyWorldExit and
; FieldState_WalkAMenu_CheckExitFacingUp jump here at their exit spots): saves the key world record
; (SaveKeyWorldFlagsRecordToSRAMSlotKeyWorldSlot), redraws and saves the screen, sets
; wFieldReturnPhase to 1, queues sound $69, switches to game mode 2 (the pause menu) with wModeState
; $0B (the plan page, 3, with bit 3 set, which PauseMenu_State4_BuildPlanPage reads as going
; straight to a step chosen by the story), and clears wWorldMapState and the joypad. (C1, E-0369)
FieldState_WalkAMenu_LeaveKeyWorld::
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

SECTION "Bank 02 CheckInteractionInFront", ROMX

; A-button check in field state 0: returns unless wMapHeaderByte7 is non-zero,
; EVENT_SCENE_LONG_FACES_002 is set, no fade, text window, field action or step is in progress and A
; is newly pressed. It reads the 2 x 2 tiles 16 pixels ahead (by hPlayerFacing, with no edge check)
; with TileBlockedAtPixel; when one equals wMapHeaderByte7 it redraws and saves the screen
; (SaveScreenBufferToBGMap1), sets wFieldReturnPhase to 1, queues sound $69, switches to game mode 2
; with wModeState $0B and clears wWorldMapState and the joypad, the same steps as
; FieldState_WalkAMenu_LeaveKeyWorld without saving a key world. (C1, E-0374)
; when A is newly pressed and no fade, load or move is in progress: finds the position one step
; ahead of the player (hPlayerX or hPlayerY +/- 16 chosen by hPlayerFacing), looks it up with
; TileBlockedAtPixel, and compares the result with the four ids at wTilesUnderPoint to pick an
; interaction
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

SECTION "Bank 02 RunFieldEventFieldEventKind", ROMX

; Every field frame (and far-called from bank $E0): unless a fade runs or a field action is pending
; (wFieldActionRequest bit 7), runs the map animation for wFieldEventKind & $0F: 0
; RunFieldEventFieldEventKind_None, 1 and 2 AnimateTilesByRotatingVTiles2, 3, 4, 5, 9, 10 and 15 the
; _AnimateTiles cases, 6 _SwapTilePairs, 7 _SwapTilePairs7, 8 _PaletteCycle, 11 _SwapTilePairsRow0,
; 12 _ScrollShake, 13 _RotateTile, 14 _RotateTiles. (C1, E-0374)
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
    dw RunFieldEventFieldEventKind_None
    dw AnimateTilesByRotatingVTiles2
    dw AnimateTilesByRotatingVTiles2
    dw RunFieldEventFieldEventKind_AnimateTiles3
    dw RunFieldEventFieldEventKind_AnimateTiles4
    dw RunFieldEventFieldEventKind_AnimateTiles5
    dw RunFieldEventFieldEventKind_SwapTilePairs
    dw RunFieldEventFieldEventKind_SwapTilePairs7
    dw RunFieldEventFieldEventKind_PaletteCycle
    dw RunFieldEventFieldEventKind_AnimateTiles9
    dw RunFieldEventFieldEventKind_AnimateTiles10
    dw RunFieldEventFieldEventKind_SwapTilePairsRow0
    dw RunFieldEventFieldEventKind_ScrollShake
    dw RunFieldEventFieldEventKind_RotateTile
    dw RunFieldEventFieldEventKind_RotateTiles
    dw RunFieldEventFieldEventKind_AnimateTiles15

; Field event 12: scroll shake (RunFieldEventFieldEventKind_ScrollShakeSteps). (C2, E-0357; probed
; E-0374)
RunFieldEventFieldEventKind_ScrollShake::
    call RunFieldEventFieldEventKind_ScrollShakeSteps
    ret

SECTION "Bank 02 RunFieldEventFieldEventKind_PaletteCycle", ROMX

; Field event 8: palette cycling (RunFieldEventFieldEventKind_PaletteCycleSteps). (C2, E-0369;
; probed E-0374)
RunFieldEventFieldEventKind_PaletteCycle::
    call RunFieldEventFieldEventKind_PaletteCycleSteps
    ret

SECTION "Bank 02 RunFieldEventFieldEventKind_None", ROMX

; Field event 0: none. (C2, E-0357; probed E-0374)
RunFieldEventFieldEventKind_None::
    ret

SECTION "Bank 02 AnimateTilesByRotatingVTiles2", ROMX

; Field events 1 and 2, and the first part of field event 5
; (RunFieldEventFieldEventKind_AnimateTiles5): every 8 frames (wFrameCounterLo & 7 = 0) rotates each
; of the first 32 bytes of vTiles2 (two tiles) left by one bit, a byte pair at a time, reading and
; writing with interrupts off after waiting for VRAM access. (C1, E-0374)
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

SECTION "Bank 02 RunFieldEventFieldEventKind_RotateTile", ROMX

; Field event 13: every 8 frames rotates the 32 bytes at vTiles2 + $A0 left by one bit (an animated
; tile). (C1, E-0357)
RunFieldEventFieldEventKind_RotateTile::
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

SECTION "Bank 02 RunFieldEventFieldEventKind_RotateTiles", ROMX

; Field event 14: every 8 frames rotates the 96 bytes at vTiles2 and vTiles2 + $30 left by one bit
; (animated tiles). (C1, E-0357)
RunFieldEventFieldEventKind_RotateTiles::
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

SECTION "Bank 02 RunFieldEventFieldEventKind_AnimateTiles3", ROMX

; Field event 3: every 16 frames swaps animated tile frames between vTiles2 + $300 and + $320. (C1,
; E-0357)
RunFieldEventFieldEventKind_AnimateTiles3::
    ld a, [wFrameCounterLo]
    and $0f
    ret nz
    ld de, vTiles2 + $300
    ld hl, vTiles2 + $320
    jp RunFieldEventFieldEventKind_CycleTwoFrames

SECTION "Bank 02 RunFieldEventFieldEventKind_AnimateTiles4", ROMX

; Field event 4: every 4 frames cycles the animated tile at vTiles2 + $280 through the four frames
; at + $2C0. (C1, E-0357)
RunFieldEventFieldEventKind_AnimateTiles4::
    ld a, [wFrameCounterLo]
    and $03
    ret nz
    ld de, vTiles2 + $280
    ld hl, vTiles2 + $2c0
    jr RunFieldEventFieldEventKind_CycleFourFrames

SECTION "Bank 02 RunFieldEventFieldEventKind_AnimateTiles5", ROMX

; Field event 5: rotates the first tiles (AnimateTilesByRotatingVTiles2) and every 4 frames cycles
; the tile at vTiles2 + $140 through the frames at + $180. (C1, E-0357)
RunFieldEventFieldEventKind_AnimateTiles5::
    call AnimateTilesByRotatingVTiles2
    ld a, [wFrameCounterLo]
    and $03
    ret nz
    ld de, vTiles2 + $140
    ld hl, vTiles2 + $180
    jr RunFieldEventFieldEventKind_CycleFourFrames

SECTION "Bank 02 RunFieldEventFieldEventKind_AnimateTiles9", ROMX

; Field event 9: every 4 frames cycles the animated tile at vTiles2 + $280 through the frames at +
; $2C0. (C1, E-0357)
RunFieldEventFieldEventKind_AnimateTiles9::
    ld a, [wFrameCounterLo]
    and $03
    ret nz
    ld de, vTiles2 + $280
    ld hl, vTiles2 + $2c0
    jr RunFieldEventFieldEventKind_CycleFourFrames

SECTION "Bank 02 RunFieldEventFieldEventKind_AnimateTiles10", ROMX

; Field event 10: every 4 frames cycles the animated tile at vTiles2 + $480 through the frames at +
; $4C0. (C1, E-0357)
RunFieldEventFieldEventKind_AnimateTiles10::
    ld a, [wFrameCounterLo]
    and $03
    ret nz
    ld de, vTiles2 + $480
    ld hl, vTiles2 + $4c0
    jr RunFieldEventFieldEventKind_CycleFourFrames

SECTION "Bank 02 RunFieldEventFieldEventKind_AnimateTiles15", ROMX

; Field event 15: except at screen X 1, every 4 frames cycles the tile at vTiles2 through the frames
; at + $40. (C1, E-0357)
RunFieldEventFieldEventKind_AnimateTiles15::
    ldh a, [hMapScreenX]
    cp $01
    ret z
    ld a, [wFrameCounterLo]
    and $03
    ret nz
    ld de, vTiles2
    ld hl, vTiles2 + $40
    jr RunFieldEventFieldEventKind_CycleFourFrames

SECTION "Bank 02 RunFieldEventFieldEventKind_CycleFourFrames", ROMX

; Tile animation by swapping: frame (wFrameCounterLo / 4) & 3 picks a 16-byte frame at HL + frame *
; 16, which is exchanged with the 16-byte tile at DE + frame * 16 in VRAM. (C1, E-0357)
RunFieldEventFieldEventKind_CycleFourFrames::
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

SECTION "Bank 02 RunFieldEventFieldEventKind_CycleTwoFrames", ROMX

; Two-frame tile animation: bit 4 of the frame counter picks which 16-byte halves of DE and HL are
; exchanged. (C1, E-0357)
RunFieldEventFieldEventKind_CycleTwoFrames::
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

SECTION "Bank 02 RunFieldEventFieldEventKind_SwapTilePairs", ROMX

; Field event 6: until EVENT_SCENE_MONSTER_INSPECTION is set, in the first 12 of every 32 frames
; swaps one tile pair from the 4-byte entries of RunFieldEventFieldEventKind_SwapTilePairs_Data.
; (C1, E-0357)
RunFieldEventFieldEventKind_SwapTilePairs::
    ld de, EVENT_SCENE_MONSTER_INSPECTION
    call TestFlagBit
    ret c
    ld a, [wFrameCounterLo]
    and $1f
    cp $0c
    ret nc
    sla a
    sla a
    ld hl, RunFieldEventFieldEventKind_SwapTilePairs_Data
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
    jp RunFieldEventFieldEventKind_ExchangeTiles

SECTION "Bank 02 RunFieldEventFieldEventKind_SwapTilePairs_Data", ROMX

; Twelve four-byte entries, each two little-endian VRAM tile addresses (vTiles2 + 16 * tile number):
; tiles $1C/$1E, $1D/$1F, $22/$26, $23/$27, $32/$34, $33/$35, $38/$3A, $39/$3B, $42/$44, $43/$45,
; $48/$4A, $49/$4B. RunFieldEventFieldEventKind_SwapTilePairs picks entry (wFrameCounterLo & $1F)
; while that is below 12, and RunFieldEventFieldEventKind_ExchangeTiles swaps the 16 bytes of the
; two tiles; the routine does nothing once EVENT_SCENE_MONSTER_INSPECTION is set. (C1, E-0381)
RunFieldEventFieldEventKind_SwapTilePairs_Data::
    db $c0, $91, $e0, $91, $d0, $91, $f0, $91, $20, $92, $60, $92, $30, $92, $70, $92
    db $20, $93, $40, $93, $30, $93, $50, $93, $80, $93, $a0, $93, $90, $93, $b0, $93
    db $20, $94, $40, $94, $30, $94, $50, $94, $80, $94, $a0, $94, $90, $94, $b0, $94

; Field event 7: in the first 12 of every 32 frames swaps one tile pair from
; RunFieldEventFieldEventKind_ReadFrameCounterLo_Data. (C1, E-0357)
RunFieldEventFieldEventKind_SwapTilePairs7::
    ld a, [wFrameCounterLo]
    and $1f
    cp $0c
    ret nc
    sla a
    sla a
    ld hl, RunFieldEventFieldEventKind_SwapTilePairs7_Data
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
    jr RunFieldEventFieldEventKind_ExchangeTiles

SECTION "Bank 02 RunFieldEventFieldEventKind_SwapTilePairs7_Data", ROMX

; Twelve four-byte entries of two little-endian VRAM tile addresses (vTiles2 + 16 * tile number):
; tiles $33/$35, $34/$36, $42/$44, $43/$45, $4C/$4E, $4D/$4F, $56/$58, $57/$59, $62/$66, $63/$67,
; $6A/$6E, $6B/$6F. RunFieldEventFieldEventKind_SwapTilePairs7 picks entry (wFrameCounterLo & $1F)
; while that is below 12 and jumps to RunFieldEventFieldEventKind_ExchangeTiles to swap the two
; tiles. (C1, E-0381)
RunFieldEventFieldEventKind_SwapTilePairs7_Data::
    db $30, $93, $50, $93, $40, $93, $60, $93, $20, $94, $40, $94, $30, $94, $50, $94
    db $c0, $94, $e0, $94, $d0, $94, $f0, $94, $60, $95, $80, $95, $70, $95, $90, $95
    db $20, $96, $60, $96, $30, $96, $70, $96, $a0, $96, $e0, $96, $b0, $96, $f0, $96

; Field event 11: on screen row 0, in the first 4 of every 64 frames swaps one tile pair from
; RunFieldEventFieldEventKind_WaitMapScreenY_Data. (C1, E-0357)
RunFieldEventFieldEventKind_SwapTilePairsRow0::
    ldh a, [hMapScreenY]
    or a
    ret nz
    ld a, [wFrameCounterLo]
    and $3f
    cp $04
    ret nc
    sla a
    sla a
    ld hl, RunFieldEventFieldEventKind_SwapTilePairsRow0_Data
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
    jp RunFieldEventFieldEventKind_ExchangeTiles

SECTION "Bank 02 RunFieldEventFieldEventKind_SwapTilePairsRow0_Data", ROMX

; Four four-byte entries of two little-endian VRAM tile addresses (vTiles2 + 16 * tile number):
; tiles $4E/$50, $4F/$51, $54/$56, $55/$57. RunFieldEventFieldEventKind_SwapTilePairsRow0 picks
; entry (wFrameCounterLo & $3F) while that is below 4, and only while hMapScreenY is 0, then
; RunFieldEventFieldEventKind_ExchangeTiles swaps the two tiles. (C1, E-0381)
RunFieldEventFieldEventKind_SwapTilePairsRow0_Data::
    db $e0, $94, $00, $95, $f0, $94, $10, $95, $40, $95, $60, $95, $50, $95, $70, $95

; Exchanges 16 bytes between VRAM tiles DE and HL, waiting for VRAM access around each byte. (C1,
; E-0357)
RunFieldEventFieldEventKind_ExchangeTiles::
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

SECTION "Bank 02 RunFieldEventFieldEventKind_PaletteCycleSteps", ROMX

; Field event 8, palette cycling: skipped while script command $ED runs (wScriptCommandType) or a
; saved position is pending (wSavedPositionValid). On the first call (wMenuSubState bit 7 clear) it
; sets wMenuSubState to $80 and saves the 64 bytes of wBGPaletteBuffer to wBGPaletteCopy.
; Afterwards, every 8 calls it steps a 16-step cycle (wMenuState / 8 counts 0-7, then wMenuSubState
; bit 0 picks the second half), recomputes the first colour of BG palettes 1, 3 and 4 from the saved
; copy (RunFieldEventFieldEventKind_ShiftColourPair) and sets wBGPaletteUploadRequest to $7F. The
; addresses for palette 2 are loaded but replaced before any call, so palette 2 is not changed (as
; read). (C2, E-0369; probed E-0374)
RunFieldEventFieldEventKind_PaletteCycleSteps::
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
    call RunFieldEventFieldEventKind_ShiftColourPair
    ld hl, wBGPaletteCopy + $10
    ld de, wBGPaletteBuffer + $10
    ld hl, wBGPaletteCopy + $18
    ld de, wBGPaletteBuffer + $18
    call RunFieldEventFieldEventKind_ShiftColourPair
    ld hl, wBGPaletteCopy + $20
    ld de, wBGPaletteBuffer + $20
    call RunFieldEventFieldEventKind_ShiftColourPair
    ld a, $7f
    ld [wBGPaletteUploadRequest], a
    ret

SECTION "Bank 02 RunFieldEventFieldEventKind_ShiftColourPair", ROMX

; Shifts one colour (a word) for the palette cycle: reads the word at HL (HL += 2), splits it into
; blue, green and red (wTextCounter2, wTextCounter3, wTextCounter4), adds the signed entry hTemp0 of
; RunFieldEventFieldEventKind_ShiftColourPair_Data (0 to -28; the second half of the table when
; wMenuSubState bit 0 is set) to each, floors each at 0 and stores the word at DE (DE += 2). (C2,
; E-0374)
RunFieldEventFieldEventKind_ShiftColourPair::
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
    ld hl, RunFieldEventFieldEventKind_ShiftColourPair_Data
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

SECTION "Bank 02 RunFieldEventFieldEventKind_ShiftColourPair_Data", ROMX

; Sixteen signed bytes in two halves of eight: 0, -4, -8, -12, -16, -20, -24, -28, then -28, -24,
; -20, -16, -12, -8, -4, 0. RunFieldEventFieldEventKind_ShiftColourPair adds entry hTemp0 (0-7),
; plus 8 when bit 0 of wMenuSubState is set, to each 5-bit blue, green and red part of a colour word
; and floors each part at 0, so the palette cycle of field event 8 darkens the colours and then
; restores them. (C1, E-0381)
RunFieldEventFieldEventKind_ShiftColourPair_Data::
    db $00, $fc, $f8, $f4, $f0, $ec, $e8, $e4, $e4, $e8, $ec, $f0, $f4, $f8, $fc, $00

; Field event 12, the scroll shake: waits until the key world's random value matches the event
; timer, then for $3C steps shakes hScrollX by -2/0/+2 every other frame; afterwards picks a new
; random wait. hScrollX is held at 0 while waiting. (C2, E-0357; probed E-0374)
RunFieldEventFieldEventKind_ScrollShakeSteps::
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

SECTION "Bank 02 UpdatePlayerMovement", ROMX

; Moves the player from the D-pad in field states 0, 1 and 5 and in scenes. Returns during a fade;
; counts hPlayerTurnDelay down (with RedrawScreenBufferIfPartyWindowFlagsBit7) while it is set;
; continues a step in progress (hPlayerStateFlags bit 0) with UpdatePlayerMovement_AdvanceStep;
; returns while a field action is pending. Directions are tried in the order Left, Right, Down, Up
; (Left and Right are skipped when hPlayerStateFlags bit 6 is set). A newly pressed direction other
; than the facing only turns the player (hPlayerFacing, hPlayerTurnDelay = 4). Otherwise, at the
; screen edge it moves hMapScreenX/Y (wrapping by wMapWidthScreens/wMapHeightScreens), checks
; CheckWarpAtPlayer (and WarpToLinkedMapForCurrentMap going down) and starts a screen scroll
; (wFieldActionRequest $80, wScreenScrollDir 1 left, 2 right, 8 down, 4 up); inside the screen it
; checks the tile ahead (TileBlockedAtPixel), sprites (FindSpriteSlotAtTile) and the trigger
; (UpdatePlayerMovement_IsTriggerAtCell), skipped while wScriptRunning is set (and for Up and Down
; while bit 6 is set), and starts a 16-pixel step (8 with bit 6, vertical only) by setting
; hPlayerStateFlags bits 0 and 2, the step word and the follower targets
; (SetFollowerTargetsFromLeader). Up and Down also check CheckWarpAtPlayer before stepping. (C1,
; E-0374)
; does nothing during a fade or while the map is loading; reads the D-pad (wJoypadHeld,
; wJoypadPressed), sets the facing hPlayerFacing and the move timer hPlayerTurnDelay, and starts or
; continues a step when the tile ahead is free (checks through TileBlockedAtPixel,
; FindSpriteSlotAtTile and UpdatePlayerMovement_IsTriggerAtCell)
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
    jp nz, UpdatePlayerMovement_AdvanceStep
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
    call UpdatePlayerMovement_IsTriggerAtCell
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
    call UpdatePlayerMovement_AdvanceStep
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
    call UpdatePlayerMovement_AdvanceStep
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
    call UpdatePlayerMovement_IsTriggerAtCell
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
    call UpdatePlayerMovement_AdvanceStep
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
    call UpdatePlayerMovement_AdvanceStep
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
    call UpdatePlayerMovement_IsTriggerAtCell
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
    call UpdatePlayerMovement_AdvanceStep
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
    call UpdatePlayerMovement_AdvanceStep

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
    call UpdatePlayerMovement_IsTriggerAtCell
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
    call UpdatePlayerMovement_AdvanceStep
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
    call UpdatePlayerMovement_AdvanceStep
    ret

SECTION "Bank 02 UpdatePlayerMovement_AdvanceStep", ROMX

; Called by UpdatePlayerMovement during a step: first redraws the screen buffer when
; wPartyWindowFlags bit 7 is set (RedrawScreenBufferIfPartyWindowFlagsBit7). It moves the player one
; pixel (or 8, with the followers, during a field action: wFieldActionRequest bit 7) toward the end
; of the current step, kept in the words hPlayerStepDXLo/Hi and hPlayerStepDYLo/Hi, and steps the
; followers. When the step finishes it sets wMapToggleRequest, clears the walking flags of
; hPlayerStateFlags and, unless a field action runs, clears wStepTriggerFlag and runs the per-step
; routines: UpdatePlayerMovement_HeldItemRegen, AdvanceStepCounterAndUpdateStoredRecords,
; RunPeriodicFieldEventChecks, UpdatePlayerMovement_WaitPlayerSpriteOverride,
; TickRandomEncounterCounter, CheckStepTriggerAndDispatchTalk, CheckWarpsAtPlayerPosition,
; RunPlayerMoveTypeMapMoveType, EnterStatusEffectFieldState and
; CountDownTalkCountdownThenDispatchTalkEvent. With no step left on entry it clears bit 0 of
; hPlayerStateFlags and wStepTriggerFlag and runs the same routines. (C1, E-0369)
UpdatePlayerMovement_AdvanceStep::
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
    jp .call_update_player_movement_held_item_regen

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
    jr nz, .call_update_player_movement_advance_step_snap
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

.call_update_player_movement_advance_step_snap:
    call UpdatePlayerMovement_AdvanceStep_SnapFollowers
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
    jr nz, .call_update_player_movement_advance_step_snap2
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

.call_update_player_movement_advance_step_snap2:
    call UpdatePlayerMovement_AdvanceStep_SnapFollowers
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
    jr nz, .call_update_player_movement_advance_step_snap3
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

.call_update_player_movement_advance_step_snap3:
    call UpdatePlayerMovement_AdvanceStep_SnapFollowers
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
    jr nz, .call_update_player_movement_advance_step_snap4
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

.call_update_player_movement_advance_step_snap4:
    call UpdatePlayerMovement_AdvanceStep_SnapFollowers
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

.call_update_player_movement_held_item_regen:
    farcall UpdatePlayerMovement_HeldItemRegen
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

SECTION "Bank 02 UpdatePlayerMovement_AdvanceStep_SnapFollowers", ROMX

; Puts all three followers on the player's position and facing while wFollowerDelay is set. (C2,
; E-0357; probed E-0374)
UpdatePlayerMovement_AdvanceStep_SnapFollowers::
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

SECTION "Bank 02 SetFollowerTargetsFromLeader", ROMX

; Capture targets for all three five-byte follower records: follower 1 gets player X/Y, follower 2
; gets follower 1 current X/Y, and follower 3 gets follower 2 current X/Y. Only target bytes 3/4 in
; each record are written; direction and position remain unchanged. The targets are a snapshot of
; positions before the subsequent step, not targets recursively copied from the leader. (C2, E-0361;
; probed E-0374)
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

SECTION "Bank 02 StepFollowersTowardTargets", ROMX

; Return immediately when wFollowerDelay is nonzero; this body does not decrement it. Otherwise
; process all three five-byte records independently: if X differs from target X, move X toward it
; and leave Y unchanged; only when X already matches, move Y toward target Y. Use unsigned
; comparisons and byte addition/subtraction: move one pixel, or four when field-action request bit 7
; is set. Directions are right 1, left 3, down 0 and up 2. Targets and matched-record directions are
; preserved. Four-pixel steps can overshoot or wrap; there is no clamp. (C2, E-0361; probed E-0374)
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

SECTION "Bank 02 TileBlockedAtPixel", ROMX

; B = X, C = Y in pixels: copies the 2 x 2 tiles at tile (X / 8, Y / 8) of wScreenTileBuffer (rows
; of 20) to wTilesUnderPoint (top left, top right, bottom left, bottom right). With
; hPlayerStateFlags bit 3 clear it returns A = 1 when any of the four is at most wMaxBlockingTile,
; else A = 0; with bit 3 set only the top two count, and A = 1 when one of them is above
; wMapTallTileMin. BC and DE are kept. UpdatePlayerMovement uses it before a step, and
; CheckTileInFrontOnA and CheckInteractionInFront to read the tiles ahead. (C2, E-0374)
; B = X, C = Y in pixels: copies the four tile ids of the 2 x 2 block at tile (X / 8, Y / 8) of
; wScreenTileBuffer (rows of 20) to wTilesUnderPoint-wTilesUnderPoint + $3; returns A = 1 when any
; of them is at most wMaxBlockingTile, else A = 0 (a different pair of comparisons with
; wMapTallTileMin runs when hPlayerStateFlags bit 3 is set)
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

SECTION "Bank 02 FindSpriteSlotAtTile", ROMX

; B = X, C = Y in pixels: returns A = the 1-based number of the first of the wSpriteSlotCount sprite
; slots (16 bytes each, X and Y at wSpriteSlots + $B and + $C) whose X or X + 15 lies in the same
; 16-pixel column as B and whose Y or Y + 15 lies in the same 16-pixel row as C; A = 0 when none
; does or there are no slots. BC is kept; hTemp0 and hTemp1 hold the cell. UpdatePlayerMovement
; treats a match as blocking the step. (C2, E-0374)
; B = X, C = Y in pixels: returns A = the 1-based number of the first slot of wSpriteSlots (from
; wSpriteSlots + $B, count wSpriteSlotCount) whose X and Y bytes, or those plus 15, lie in the same
; 16-pixel cell as (B, C); A = 0 when none does
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

SECTION "Bank 02 UpdatePlayerMovement_IsTriggerAtCell", ROMX

; B = X, C = Y in pixels: returns A = 1 when the current trigger (wTriggerKind 2 or 3) lies in the
; 16-pixel cell (B / 16, C / 16): outside a key world and on map type $85 the cell is wTriggerCell
; (high nibble X, low nibble Y); on other key-world map types it is the X, Y pair at entry
; wTriggerCell of UpdatePlayerMovement_IsTriggerAtCell_Data. Otherwise A = 0; BC is kept.
; UpdatePlayerMovement treats a match as blocking the step. (C2, E-0374)
UpdatePlayerMovement_IsTriggerAtCell::
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
    ld hl, UpdatePlayerMovement_IsTriggerAtCell_Data
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

SECTION "Bank 02 UpdatePlayerMovement_IsTriggerAtCell_Data", ROMX

; Sixteen (X, Y) byte pairs of 16-pixel cell coordinates, sorted by X: (1,2), (1,7), (2,1), (2,4),
; (2,6), (3,3), (4,5), (4,7), (5,1), (5,3), (6,5), (7,2), (7,4), (7,7), (8,1), (8,6).
; UpdatePlayerMovement_IsTriggerAtCell indexes it by wTriggerCell (times 2) on key-world maps other
; than map type $85, and returns 1 when the pair equals the cell (B / 16, C / 16) it is asked about
; and wTriggerKind is 2 or 3. (C1, E-0381)
UpdatePlayerMovement_IsTriggerAtCell_Data::
    db $01, $02, $01, $07, $02, $01, $02, $04, $02, $06, $03, $03, $04, $05, $04, $07
    db $05, $01, $05, $03, $06, $05, $07, $02, $07, $04, $07, $07, $08, $01, $08, $06

; Field state 0's Down-held check: at a spot listed in FieldState_WalkATalks_TalkAtSpotOnDown_Data
; (map, screen, X, Y; ends with $FF) it starts talk event group $10 + the entry's index and clears
; the joypad. (C1, E-0357)
FieldState_WalkATalks_TalkAtSpotOnDown::
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
    ld hl, FieldState_WalkATalks_TalkAtSpotOnDown_Data
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

SECTION "Bank 02 FieldState_WalkATalks_TalkAtSpotOnDown_Data", ROMX

; Five four-byte entries then an $FF end marker: hMapId, a screen byte (hMapScreenX * 16 +
; hMapScreenY), hPlayerX and hPlayerY of the spot. They are $01/$11/$70/$70, $01/$11/$70/$20,
; $01/$10/$70/$50, $1A/$10/$70/$70 and $85/$10/$50/$60. FieldState_WalkATalks_TalkAtSpotOnDown walks
; the list while Down is held and, on a full match, sets wTalkEventGroup to $10 plus the entry index
; and runs DispatchTalkEvent. (C1, E-0381)
FieldState_WalkATalks_TalkAtSpotOnDown_Data::
    db $01, $11, $70, $70, $01, $11, $70, $20, $01, $10, $70, $50, $1a, $10, $70, $70
    db $85, $10, $50, $60, $ff

; Clears wPartyWindowTimer; when the party window is shown (wPartyWindowFlags bit 7) it redraws the
; whole screen buffer (DrawFullScreenBufferToBGMap) at the BG map position of the scroll (vBGMap0 +
; (hScrollY & $F8) * 4 + hScrollX / 8, kept inside the map) and clears wPartyWindowFlags and
; wPartyWindowTimer. Movement, talk events and screen saves call it first so the party window is
; removed. (C1, E-0374)
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

SECTION "Bank 02 RunFieldActionRequestActionIfBit7", ROMX

; When a field action is requested (wFieldActionRequest bit 7, which UpdatePlayerMovement sets for a
; screen scroll) runs its step wFieldActionRequest & 3: 0
; RunFieldActionRequestActionIfBit7_LoadScreen, 1 RunFieldActionRequestActionIfBit7_ScrollScreen, 2
; RunFieldActionRequestActionIfBit7_EnterScreen, 3 RunFieldActionRequestActionIfBit7_StepChecks;
; each step adds 1 to wFieldActionRequest when done and the last clears it. (C1, E-0374)
; if bit 7 of wFieldActionRequest is set, runs the routine for wFieldActionRequest & 3 (jump table)
; (E-0122)
RunFieldActionRequestActionIfBit7::
    ld a, [wFieldActionRequest]
    bit 7, a
    ret z
    and $03
    jumptable
    dw RunFieldActionRequestActionIfBit7_LoadScreen
    dw RunFieldActionRequestActionIfBit7_ScrollScreen
    dw RunFieldActionRequestActionIfBit7_EnterScreen
    dw RunFieldActionRequestActionIfBit7_StepChecks

; Field action step 0: loads the new screen (LoadMapScreen) and moves to the scroll step. (C1,
; E-0357)
RunFieldActionRequestActionIfBit7_LoadScreen::
    call LoadMapScreen
    xor a
    ld [wFieldActionStep], a
    ld hl, wFieldActionRequest
    inc [hl]
    ret

SECTION "Bank 02 RunFieldActionRequestActionIfBit7_StepChecks", ROMX

; Field action step 3 (after a screen scroll): runs the per-step checks (step counter, periodic
; events, encounters, warps, movement type, status effects, talk countdown) and ends the action.
; (C1, E-0357)
RunFieldActionRequestActionIfBit7_StepChecks::
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

SECTION "Bank 02 RunFieldActionRequestActionIfBit7_EnterScreen", ROMX

; Field action step 2: finds the new screen's triggers and objects
; (FindTriggerEntryForCurrentScreen, LoadMapObjectsForScreen), handles a pending field event and
; places special map objects. (C1, E-0357)
RunFieldActionRequestActionIfBit7_EnterScreen::
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

SECTION "Bank 02 RunFieldActionRequestActionIfBit7_ScrollScreen", ROMX

; Field action step 1, the screen scroll: each frame draws the next column (20 steps, scrolling 8
; pixels left or right) or row (18 steps, up or down) of the new screen from wScreenTileBuffer into
; the BG map, in the direction of wScreenScrollDir; at the end it aligns the scroll, marks the
; screen visited (MarkVisitedMapScreenInVisitedScreens) and moves to the next step. (C2, E-0357;
; probed E-0374)
RunFieldActionRequestActionIfBit7_ScrollScreen::
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
    call QueueBGMapColumn
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
    call QueueBGMapColumn
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
    call QueueBGMapRow_Bank02
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
    call QueueBGMapRow_Bank02
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

SECTION "Bank 02 QueueBGMapColumn", ROMX

; Queues one BG map column (18 tiles) for the VBlank writer: destination DE, the tiles taken every
; 20 bytes from HL in the screen buffer into wBGWriteData; on CGB also the column's palette numbers
; (attribute low 3 bits) from the attribute copy in WRAM bank 2 into wAttrWriteData. (C2, E-0357;
; probed E-0374)
QueueBGMapColumn::
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

SECTION "Bank 02 QueueBGMapRow_Bank02", ROMX

; Queues one BG map row (20 tiles) for the VBlank writer: destination DE, the tiles from HL into
; wBGWriteData; on CGB also the row's palette numbers from the attribute copy in WRAM bank 2. (C2,
; E-0357; probed E-0374)
; the same 86 bytes as QueueBGMapRow (QueueBGMapRow) (E-0367)
QueueBGMapRow_Bank02::
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

SECTION "Bank 02 RunMoveIncapacitatedPartyMembersBackTwice", ROMX

; Calls MoveIncapacitatedPartyMembersBack and falls into it, so the pass runs twice and fallen
; members (MON_STATUS bit 7) end behind the living ones in a party of three. (C2, E-0374)
; calls MoveIncapacitatedPartyMembersBack and falls into it, running it twice (E-0126)
RunMoveIncapacitatedPartyMembersBackTwice::
    call MoveIncapacitatedPartyMembersBack

; One pass that moves fallen party members back: with three members it swaps wPartyList entries 2
; and 3 when the second has MON_STATUS bit 7 set (dead) and the third not, then, with two or more,
; swaps entries 1 and 2 the same way; a party of one is left alone. It enables SRAM (rRAMG = $0A,
; the bank already mapped) to read the records and disables it at the end. (C2, E-0374)
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

SECTION "Bank 02 SaveScreenBufferToBGMap1", ROMX

; Copies the 20 x 18 screen buffer ($168 bytes from wScreenTileBuffer) to vBGMap1 with
; WriteVRAMByteInc; on CGB also copies the $168 attribute bytes of wScreenAttrBuffer to
; wSavedScreenAttrs with WRAM bank 2 mapped (rSVBK = 0 after); stores wSpriteSlotCount in
; wScreenSavedFlag. RestoreScreenBufferFromBGMap1 undoes it; the field saves the screen this way
; before menus, battles and talk scenes. (C1, E-0374)
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

SECTION "Bank 02 RestoreScreenBufferFromBGMap1", ROMX

; Copies the $168 bytes saved at vBGMap1 back to wScreenTileBuffer (WaitForVRAMAccess, interrupts
; off per byte); on CGB copies wSavedScreenAttrs back to wScreenAttrBuffer with WRAM bank 2 mapped
; (rSVBK = 0 after); restores wSpriteSlotCount from wScreenSavedFlag. InitFieldScreen uses it when
; wFieldReturnPhase is non-zero, and scenes in banks $73 and $85 far-call it. (C1, E-0374)
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

SECTION "Bank 02 IncrementPlayTime", ROMX

; Called each field frame by FieldModeStateDispatch: counts wPlayFrames, wPlaySeconds and
; wPlayMinutes from 0 to 59, carrying into the 16-bit hours wPlayHoursLo/wPlayHoursHi. It stops
; counting once the hours are 999 ($03E7) and the minutes 59, so the clock stops at 999:59:00. (C2,
; E-0374)
; counts frames wPlayFrames (0-59), seconds wPlaySeconds (0-59), minutes wPlayMinutes (0-59) and a
; 16-bit hour count wPlayHoursLo/wPlayHoursHi; stops at 999:59:59 ($03E7 hours)
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

SECTION "Bank 02 SendSGBFieldPaletteSet", ROMX

; On the Super Game Boy (wSGBActive) sets wSGBPaletteNum0-3 to 4 * wSGBPaletteSet + 0, 1, 2 and 3,
; puts $B1 and wSGBAttrFile in wSGBPacketBuffer, sets wSGBPacketIndex $FF, far-calls
; SendSGBPacketSet, waits (SpinDelay) and loads the object palettes
; (LoadSGBObjectPalettesFromPointers). In every case wFieldInitStage 1 becomes 2, which makes
; GameMode1_Update finish the field set-up next frame. (C2, E-0374)
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

SECTION "Bank 02 GameMode1_Update_FinishFieldSetup", ROMX

; The end of the field's set-up, reached from GameMode1_Update when wFieldInitStage is 2: clears the
; joypad state and wFieldFrameFlag, runs the first frame of the field state
; (FieldModeStateDispatch), clears wFieldInitStage, sets the default DMG palettes (BGP $D2, OBP0
; $D2, OBP1 $E2) and their fade copies (wDMGPaletteBytes, ResetFadeFromDMGPaletteBGP), on the SGB
; copies the 32 bytes at wOBJPaletteBuffer + $20 to wOBJPaletteBuffer, then starts palette fade $FD.
; (C1, E-0369)
GameMode1_Update_FinishFieldSetup::
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

SECTION "Bank 02 RestartMapMusic", ROMX

; Sets wCurrentMusic to $FF and falls into PlayMapMusic, so the music of the map is queued even when
; it is already playing. (C1, E-0374)
; wCurrentMusic = $FF (no current music), then falls into PlayMapMusic so the map's music always
; restarts (E-0122)
RestartMapMusic::
    ld a, $ff
    ld [wCurrentMusic], a

; Queues the music for the current map unless it is already wCurrentMusic (PlayMapMusic_QueueIfNew).
; Outside a key world it uses the hMapId table (PlayMapMusic_ByMapId). On key-world map types: $86
; music $22, $85 $25, $84 $19, $83 $19 unless the floor info byte (wKeyWorldFloorInfo + 1 + 4 *
; wKeyWorldFloor) is 6; otherwise $2B when hPlayerStateFlags bit 3 is set, else $35. (C1, E-0374)
; chooses the music for the current map (by wMapType and hMapId, with story-flag cases) and queues
; it unless it is already wCurrentMusic (E-0122)
PlayMapMusic::
    ld a, [wMapType]
    bit 7, a
    jr z, PlayMapMusic_ByMapId
    ld c, $22
    cp $86
    jr z, PlayMapMusic_QueueIfNew
    ld c, $25
    cp $85
    jr z, PlayMapMusic_QueueIfNew
    ld c, $19
    cp $84
    jr z, PlayMapMusic_QueueIfNew
    cp $83
    jr nz, .check_player_state_flags
    ld a, [wKeyWorldFloor]
    add a
    add a
    ld hl, wKeyWorldFloorInfo + $1
    add_a_to_hl
    ld a, [hl]
    cp $06
    jr nz, PlayMapMusic_QueueIfNew

.check_player_state_flags:
    ld c, $2b
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr nz, PlayMapMusic_QueueIfNew
    ld c, $35

; Queues music C unless it is already playing (wCurrentMusic). (C2, E-0357; probed E-0374)
PlayMapMusic_QueueIfNew::
    ld a, [wCurrentMusic]
    cp c
    ret z
    ld a, c
    call QueueMusic
    ret

SECTION "Bank 02 PlayMapMusic_QueueSoundIfNew", ROMX

; Queues sound effect C unless it is already requested. (C2, E-0357; probed E-0374)
PlayMapMusic_QueueSoundIfNew::
    ld a, [wSoundEffectRequest]
    cp c
    ret z
    ld a, c
    call QueueSoundEffect
    ret

SECTION "Bank 02 PlayMapMusic_ByMapId", ROMX

; Chooses the field music by map: a 227-entry jump table indexed by hMapId. Most entries pick one
; song; some check the screen or story flags first (the PlayMapMusic_Map01 cases), and a few entries
; are 0 (maps that are never looked up). (C1, E-0357)
PlayMapMusic_ByMapId::
    ldh a, [hMapId]
    jumptable
    dw PlayMapMusic_Music16
    dw PlayMapMusic_Map01
    dw PlayMapMusic_Music16
    dw PlayMapMusic_Music16
    dw PlayMapMusic_Map04
    dw PlayMapMusic_Map05
    dw PlayMapMusic_Music16
    dw PlayMapMusic_Music16
    dw PlayMapMusic_Music16
    dw PlayMapMusic_Music16
    dw PlayMapMusic_Music16
    dw PlayMapMusic_Music16
    dw PlayMapMusic_Music16
    dw PlayMapMusic_Music0C
    dw PlayMapMusic_Music16
    dw PlayMapMusic_Music16
    dw PlayMapMusic_Music16
    dw PlayMapMusic_Music16
    dw PlayMapMusic_Music16
    dw PlayMapMusic_Music16
    dw PlayMapMusic_Music0C
    dw PlayMapMusic_Music16
    dw PlayMapMusic_Music16
    dw PlayMapMusic_Music16
    dw PlayMapMusic_Map04
    dw PlayMapMusic_Music16
    dw PlayMapMusic_Music16
    dw PlayMapMusic_Music16
    dw PlayMapMusic_Map1C
    dw PlayMapMusic_Map1D
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw PlayMapMusic_Music1C
    dw PlayMapMusic_Music19
    dw PlayMapMusic_Music19
    dw PlayMapMusic_Music19
    dw PlayMapMusic_Music19
    dw PlayMapMusic_Music19
    dw PlayMapMusic_Music19
    dw $0000 ; unused index (E-0207)
    dw PlayMapMusic_Music1C
    dw PlayMapMusic_Music1C
    dw PlayMapMusic_Music19
    dw PlayMapMusic_Music25
    dw $0000 ; unused index (E-0207)
    dw PlayMapMusic_Music19
    dw PlayMapMusic_Music19
    dw PlayMapMusic_Music1C
    dw MapMusicByPlayerStateFlagsBit3
    dw PlayMapMusic_Music19
    dw PlayMapMusic_Music19
    dw PlayMapMusic_Music19
    dw PlayMapMusic_Music19
    dw PlayMapMusic_Music25
    dw MapMusicByPlayerStateFlagsBit3
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Map38
    dw PlayMapMusic_Map39
    dw PlayMapMusic_Music25
    dw PlayMapMusic_Map3B
    dw PlayMapMusic_Music19
    dw PlayMapMusic_Music19
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music19
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music1C
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw MapMusicByFlag23Music1C
    dw MapMusicByFlag23Music1C
    dw MapMusicByFlag23
    dw MapMusicByFlag23
    dw MapMusicByFlag23
    dw MapMusicByScreenAndFlags87And8A
    dw MapMusicByFlag23Music1C
    dw MapMusicByFlag23
    dw MapMusicByFlag23
    dw MapMusicByFlag23
    dw MapMusicByFlag23Music1C
    dw PlayMapMusic_Music25
    dw PlayMapMusic_Music25
    dw PlayMapMusic_Music25
    dw PlayMapMusic_Music25
    dw PlayMapMusic_Music25
    dw MapMusicByFlag23
    dw MapMusicByFlag23
    dw MapMusicByFlag23
    dw MapMusicByFlag23
    dw MapMusicByFlag23
    dw PlayMapMusic_Music22
    dw MapMusicByFlag23
    dw MapMusicByFlag23
    dw MapMusicByFlag23
    dw MapMusicByFlag23
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music22
    dw MapMusicByFlag23Music1C
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw PlayMapMusic_Music1C
    dw PlayMapMusic_Music19
    dw PlayMapMusic_Music19
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music1C
    dw PlayMapMusic_Music19
    dw PlayMapMusic_Music19
    dw PlayMapMusic_Music1C
    dw PlayMapMusic_Music1C
    dw PlayMapMusic_Music19
    dw PlayMapMusic_Music19
    dw PlayMapMusic_Music19
    dw PlayMapMusic_Music19
    dw PlayMapMusic_Music1C
    dw PlayMapMusic_Music25
    dw PlayMapMusic_Music25
    dw PlayMapMusic_Music25
    dw PlayMapMusic_Music25
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music19
    dw PlayMapMusic_Music1C
    dw PlayMapMusic_Music25
    dw PlayMapMusic_Music25
    dw PlayMapMusic_Music25
    dw PlayMapMusic_Music25
    dw PlayMapMusic_Music25
    dw PlayMapMusic_Music25
    dw PlayMapMusic_Music25
    dw PlayMapMusic_Music1C
    dw PlayMapMusic_Music1C
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Map9B
    dw $0000 ; unused index (E-0207)
    dw PlayMapMusic_Music1C
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw MapMusicByFlag25
    dw PlayMapMusic_MusicCC
    dw PlayMapMusic_MusicCC
    dw PlayMapMusic_MusicCC
    dw MapMusicByFlag25
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw PlayMapMusic_Music1C
    dw PlayMapMusic_Music19
    dw PlayMapMusic_Music1C
    dw PlayMapMusic_Music19
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music1C
    dw PlayMapMusic_Music1C
    dw PlayMapMusic_Music19
    dw PlayMapMusic_Music1C
    dw PlayMapMusic_Music25
    dw PlayMapMusic_Music25
    dw PlayMapMusic_Music25
    dw PlayMapMusic_Music25
    dw $0000 ; unused index (E-0207)
    dw PlayMapMusic_Music1C
    dw PlayMapMusic_Music19
    dw PlayMapMusic_Music19
    dw PlayMapMusic_Music1C
    dw PlayMapMusic_Music19
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music1C
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw PlayMapMusic_Music1C
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music22
    dw $0000 ; unused index (E-0207)
    dw PlayMapMusic_Music1C
    dw PlayMapMusic_Music1C
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music22
    dw $0000 ; unused index (E-0207)
    dw PlayMapMusic_Music1C
    dw PlayMapMusic_Music1C
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music22
    dw PlayMapMusic_Music22
    dw $0000 ; unused index (E-0207)
    dw PlayMapMusic_Music1C
    db $00, $00

; Map music $16 (the default for most town and outdoor maps in the table). (C2, E-0357; probed
; E-0374)
PlayMapMusic_Music16::
    ld c, $16
    jp PlayMapMusic_QueueIfNew

SECTION "Bank 02 PlayMapMusic_Map01", ROMX

; Map 1's music: on screen row 2 at screen X 0 or 2, after EVENT_THANKS_FOR_COMING_BY and before
; EVENT_SCENE_WARUBOU_SMELLS, music $28; otherwise $16. (C2, E-0357; probed E-0374)
PlayMapMusic_Map01::
    ldh a, [hMapScreenY]
    cp $02
    jr nz, PlayMapMusic_Music16
    ldh a, [hMapScreenX]
    or a
    jr z, .call_test_flag_bit
    cp $02
    jr nz, PlayMapMusic_Music16

.call_test_flag_bit:
    ld de, EVENT_THANKS_FOR_COMING_BY
    call TestFlagBit
    jr nc, PlayMapMusic_Music16
    ld de, EVENT_SCENE_WARUBOU_SMELLS
    call TestFlagBit
    jr c, PlayMapMusic_Music16
    ld c, $28
    jp PlayMapMusic_QueueIfNew

SECTION "Bank 02 PlayMapMusic_Map05", ROMX

; Map 5's music: at screen X 0, after EVENT_SCENE_WARUBOU_SMELLS, music $28 until the three-item
; scene is under way (EVENT_SCENE_WARUBOU_FOOD2_00C set, then 0C2 set and 0C3 clear also give $28);
; otherwise $16. (C2, E-0357; probed E-0374)
PlayMapMusic_Map05::
    ldh a, [hMapScreenX]
    or a
    jr nz, PlayMapMusic_Music16
    ld de, EVENT_SCENE_WARUBOU_SMELLS
    call TestFlagBit
    jr nc, PlayMapMusic_Music16
    ld de, EVENT_SCENE_WARUBOU_FOOD2_00C
    call TestFlagBit
    jr nc, .skip
    ld de, EVENT_SCENE_THREE_ITEMS_0C2
    call TestFlagBit
    jr nc, PlayMapMusic_Music16
    ld de, EVENT_SCENE_THREE_ITEMS_0C3
    call TestFlagBit
    jr c, PlayMapMusic_Music16

.skip:
    ld c, $28
    jp PlayMapMusic_QueueIfNew

SECTION "Bank 02 PlayMapMusic_Music0C", ROMX

; Map music $0C (maps $0D and $14). (C2, E-0357; probed E-0374)
PlayMapMusic_Music0C::
    ld c, $0c
    jp PlayMapMusic_QueueIfNew

SECTION "Bank 02 PlayMapMusic_Map04", ROMX

; Maps 4 and $18: after EVENT_MAP_04_OBJECT_REMOVED_0CC and before EVENT_SCENE_TERRY_BATTLE_038,
; music $CF; otherwise $16. (C2, E-0357; probed E-0374)
PlayMapMusic_Map04::
    ld de, EVENT_MAP_04_OBJECT_REMOVED_0CC
    call TestFlagBit
    jr nc, PlayMapMusic_Music16
    ld de, EVENT_SCENE_TERRY_BATTLE_038
    call TestFlagBit
    jr c, PlayMapMusic_Music16
    ld c, $cf
    jp PlayMapMusic_QueueIfNew

SECTION "Bank 02 PlayMapMusic_Map1D", ROMX

; Map $1D: requests sound $76 (unless already requested) instead of music. (C2, E-0357; probed
; E-0374)
PlayMapMusic_Map1D::
    ld c, $76
    jp PlayMapMusic_QueueSoundIfNew

SECTION "Bank 02 PlayMapMusic_Map1C", ROMX

; Map $1C: leaves the music unchanged. (C2, E-0357; probed E-0374)
PlayMapMusic_Map1C::
    ret

SECTION "Bank 02 PlayMapMusic_Music19", ROMX

; Map music $19. (C2, E-0357; probed E-0374)
PlayMapMusic_Music19::
    ld c, $19
    jp PlayMapMusic_QueueIfNew

SECTION "Bank 02 MapMusicByFlag23", ROMX

; PlayMapMusic_ByMapId case for maps $4A-$4C, $4F-$51, $58-$5C and $5E-$61: when
; EVENT_SCENE_SHIELD2_023 is set it jumps to PlayMapMusic_Music19 (music $19), otherwise music $2E;
; either way the id is queued (QueueMusic) only when it is not already wCurrentMusic
; (PlayMapMusic_QueueIfNew). The earlier note said $1C for the set case; the jump goes to the $19
; case. (C2, E-0374)
; map music case: if story flag $23 is set uses music $1C, else $2E (E-0122)
MapMusicByFlag23::
    ld de, EVENT_SCENE_SHIELD2_023
    call TestFlagBit
    jr c, PlayMapMusic_Music19
    ld c, $2e
    jp PlayMapMusic_QueueIfNew

SECTION "Bank 02 MapMusicByScreenAndFlags87And8A", ROMX

; PlayMapMusic_ByMapId case for map $4D: on screen row 0 (hMapScreenY = 0), or before
; EVENT_SCENE_REPORT_TO_KING, or once EVENT_SCENE_WALL_EXIT is set, it uses the MapMusicByFlag23
; case ($19 or $2E); otherwise (a lower screen between the two flags) music $28, queued unless
; already current. (C2, E-0374)
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
    jp PlayMapMusic_QueueIfNew

SECTION "Bank 02 PlayMapMusic_Music1C", ROMX

; Map music $1C. (C2, E-0357; probed E-0374)
PlayMapMusic_Music1C::
    ld c, $1c
    jp PlayMapMusic_QueueIfNew

SECTION "Bank 02 MapMusicByPlayerStateFlagsBit3", ROMX

; PlayMapMusic_ByMapId case for maps $30 and $36: music $2B when bit 3 of hPlayerStateFlags is set,
; else $1C, queued unless already wCurrentMusic. What bit 3 marks here is not established. (C2,
; E-0374)
; map music case: music $2B when bit 3 of hPlayerStateFlags is set, else $1C (E-0122)
MapMusicByPlayerStateFlagsBit3::
    ld c, $1c
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jp z, PlayMapMusic_QueueIfNew
    ld c, $2b
    jp PlayMapMusic_QueueIfNew

SECTION "Bank 02 MapMusicByFlag23Music1C", ROMX

; PlayMapMusic_ByMapId case for maps $48, $49, $4E, $52 and $68: when EVENT_SCENE_SHIELD2_023 is set
; it jumps to PlayMapMusic_Music1C (music $1C), otherwise music $2E; queued unless already
; wCurrentMusic. It differs from MapMusicByFlag23 only in the set case ($1C there $19). (C2, E-0374)
; map music case: if story flag $23 is set uses music $1C, else $2E (E-0122) (E-0344: the address in
; its name dropped or read as the label there; was MapMusicByFlag23Music1C)
MapMusicByFlag23Music1C::
    ld de, EVENT_SCENE_SHIELD2_023
    call TestFlagBit
    jr c, PlayMapMusic_Music1C
    ld c, $2e
    jp PlayMapMusic_QueueIfNew

SECTION "Bank 02 MapMusicByFlag25", ROMX

; PlayMapMusic_ByMapId case for maps $A0 and $A4: music $1C once EVENT_THANKS_FOR_COMING_BY_025 is
; set, else $1F; queued unless already wCurrentMusic. (C2, E-0374)
; map music case: if story flag $25 is set uses music $1C, else $1F (E-0122)
MapMusicByFlag25::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, PlayMapMusic_Music1C
    ld c, $1f
    jp PlayMapMusic_QueueIfNew

SECTION "Bank 02 PlayMapMusic_MusicCC", ROMX

; Map music $CC. (C2, E-0357; probed E-0374)
PlayMapMusic_MusicCC::
    ld c, $cc
    jp PlayMapMusic_QueueIfNew

SECTION "Bank 02 PlayMapMusic_Music25", ROMX

; Map music $25. (C2, E-0357; probed E-0374)
PlayMapMusic_Music25::
    ld c, $25
    jp PlayMapMusic_QueueIfNew

SECTION "Bank 02 PlayMapMusic_Map38", ROMX

; At screen (0, 0) of its map, silences the sound (InitSoundHardware) instead of playing music;
; elsewhere music $25. (C1, E-0357)
PlayMapMusic_Map38::
    ldh a, [hMapScreenX]
    or a
    jr nz, PlayMapMusic_Music25
    ldh a, [hMapScreenY]
    or a
    jr nz, PlayMapMusic_Music25
    call InitSoundHardware
    ret

SECTION "Bank 02 PlayMapMusic_Map39", ROMX

; At screen (1, 1) of its map, before EVENT_SCENE_CREW_FOLLOWS, music $28; otherwise $25. (C2,
; E-0357; probed E-0374)
PlayMapMusic_Map39::
    ldh a, [hMapScreenX]
    cp $01
    jr nz, PlayMapMusic_Music25
    ldh a, [hMapScreenY]
    cp $01
    jr nz, PlayMapMusic_Music25
    ld de, EVENT_SCENE_CREW_FOLLOWS
    call TestFlagBit
    jr c, PlayMapMusic_Music25
    ld c, $28
    jp PlayMapMusic_QueueIfNew

SECTION "Bank 02 PlayMapMusic_Map3B", ROMX

; Before EVENT_SCENE_MERMAID_KINGDOM_022, music $28; afterwards $25. (C2, E-0357; probed E-0374)
PlayMapMusic_Map3B::
    ld de, EVENT_SCENE_MERMAID_KINGDOM_022
    call TestFlagBit
    jr c, PlayMapMusic_Music25
    ld c, $28
    jp PlayMapMusic_QueueIfNew

SECTION "Bank 02 PlayMapMusic_Music22", ROMX

; Map music $22. (C2, E-0357; probed E-0374)
PlayMapMusic_Music22::
    ld c, $22
    jp PlayMapMusic_QueueIfNew

SECTION "Bank 02 PlayMapMusic_Map9B", ROMX

; On screen row 0 while the three-item scene is under way (EVENT_SCENE_THREE_ITEMS_0C2 set, 0C3
; clear), music $28; otherwise $22. (C2, E-0357; probed E-0374)
PlayMapMusic_Map9B::
    ldh a, [hMapScreenY]
    or a
    jr nz, PlayMapMusic_Music22
    ld de, EVENT_SCENE_THREE_ITEMS_0C2
    call TestFlagBit
    jr nc, PlayMapMusic_Music22
    ld de, EVENT_SCENE_THREE_ITEMS_0C3
    call TestFlagBit
    jr c, PlayMapMusic_Music22
    ld c, $28
    jp PlayMapMusic_QueueIfNew

SECTION "Bank 02 FieldState_Still_ChoosePage", ROMX

; Field state 2, the field menu's choice of page: B closes it (back to field state 0, or 5 in a key
; world); A opens the chosen page in game mode 2 (wModeState = wMenuState, sound $69); Left/Right
; and Up/Down move in the 2 x 2 grid (wMenuState xor 1 or xor 2). The cursor is drawn each frame
; first. (C1, E-0357)
FieldState_Still_ChoosePage::
    call FieldState_Still_ChoosePage_DrawCursor
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, .check_bit0
    xor a
    ld [wFieldReturnPhase], a
    farcall ResumeFieldAnimation
    xor a
    ldh [hSpriteWindowClipMode], a
    call FieldState_Still_CloseWindow
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

SECTION "Bank 02 FieldState_Still_ChoosePage_DrawCursor", ROMX

; Draws the field menu's four cursor positions into BG map 0 relative to the scroll position
; (hScrollY, hScrollX), from four (column, row) byte pairs in the table after this routine: position
; wMenuState gets cursor tile $BB, blanked to $C3 while bit 3 of the frame count in wMenuSubState is
; set (wMenuSubState += 1 each call), the others tile $C3. A $BC branch tests wMenuState bit 7 only
; after wMenuState has matched a position number 0-3, so it is never taken. (C1, E-0369)
FieldState_Still_ChoosePage_DrawCursor::
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
    ld de, FieldState_Still_ChoosePage_DrawCursor_Data

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

SECTION "Bank 02 FieldState_Still_ChoosePage_DrawCursor_Data", ROMX

; Four (column, row) byte pairs in tiles, (1,1), (6,1), (1,3) and (6,3), indexed by the cursor
; position 0-3 (wMenuState): a 2 by 2 arrangement. FieldState_Still_ChoosePage_DrawCursor adds them
; to the BG map 0 address of the current scroll position and writes cursor tile $BB (blinking to
; $C3) at the selected position and tile $C3 at the other three. (C1, E-0381)
FieldState_Still_ChoosePage_DrawCursor_Data::
    db $01, $01, $06, $01, $01, $03, $06, $03

; Redraws the whole screen buffer at the scroll position (closing the field menu's window) and
; clears the party window flags. (C1, E-0357)
FieldState_Still_CloseWindow::
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

SECTION "Bank 02 OpenFieldMenuOnA", ROMX

; Opens the field menu when A is newly pressed (wJoypadPressed bit 0) and nothing blocks it: returns
; at once while wFadeState is non-zero, before EVENT_SCENE_LONG_FACES_002, while a text window opens
; or closes (wTextWindowState & 3), while a field action is requested (wFieldActionRequest bit 7) or
; a step is in progress (hPlayerStateFlags bit 0). Otherwise: hSpriteWindowClipMode = 3,
; wFieldReturnPhase = 1, saves the screen (SaveScreenBufferToBGMap1), sets bit 1 of the player and
; object flags, copies the top 5 rows of wScreenTileBuffer (and on CGB their attributes & 7) into
; wWindowTileBuffer, draws the 12 x 5 page box (OpenFieldMenuOnA_TileRect) and the 8 x 3 gold box
; (OpenFieldMenuOnA_TileRect_2, column 12) over them, copies the 20 x 5 rows to the BG map at the
; scroll position (CopyScreenRectToBGMapSetTextCursorLo), shows the party window at once
; (wPartyWindowTimer = $B3, then ShowIdlePartyStatusWindow), draws the gold at row 1 column 14
; (DrawGoldDigitsAtHLWrapped), plays sound $69 and sets wModeState = 2 (FieldState_Still, whose page
; choice is FieldState_Still_ChoosePage). wMenuState is cleared only when hTemp8 is 0;
; RunFieldReturnPhase_RunReturnAction calls it with hTemp8 = 1 and A forced, to reopen the menu on
; its old page. (C1, E-0374)
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
    farcall FreezeFieldAnimation
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
    call OpenFieldMenuOnA_CopyRect
    ld de, OpenFieldMenuOnA_TileRect_2
    ld hl, wWindowTileBuffer + $c
    lb bc, $08, $03
    call OpenFieldMenuOnA_CopyRect
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

SECTION "Bank 02 OpenFieldMenuOnA_CopyRect", ROMX

; DE = source, HL = destination, B = width, C = rows: copies the B x C rectangle into rows 20 bytes
; apart at HL (its only caller, OpenFieldMenuOnA, passes wWindowTileBuffer, not the screen buffer)
; and returns with HL, B and C unchanged on DMG; on CGB it then zeroes the same rectangle at HL +
; $E68 in WRAM bank 2 (wWindowAttrBuffer for that caller), returning HL C rows past HL + $E68, C = 0
; and rSVBK = 0. DE ends past the source. (C2, E-0374)
; copies a B x C rectangle from DE to HL (20-byte rows); on CGB clears the matching attribute rows
; in WRAM bank 2 (E-0127) (E-0344: the address in its name dropped or read as the label there; was
; OpenFieldMenuOnA_CopyRect)
OpenFieldMenuOnA_CopyRect::
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

SECTION "Bank 02 OpenFieldMenuOnA_TileRect", ROMX

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

; HL = BG map address: converts the 24-bit gold (wGoldHi:wGoldMid:wGoldLo, through wDigits) to
; packed BCD (Number24ToPackedBCD, digits in hTemp2..hTemp0) and writes its five low digits as tiles
; $E0 + digit with WriteVRAMByte, skipping leading zeros but still moving HL past them (so the
; number is right-aligned in five cells; the ones digit is always drawn). HL wraps to the start of
; its 32-tile row at the row end. The sixth (hundred-thousands) digit is never drawn. (C1, E-0374)
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

SECTION "Bank 02 ShowIdlePartyStatusWindow", ROMX

; Shows the party window below the field menu. Returns unless EVENT_SCENE_LONG_FACES_002 is set, no
; text window is opening or closing, wFieldActionRequest bit 7 is clear, wPartyCount is not 0,
; hPlayerStateFlags bit 0 is clear and the window is not already up (wPartyWindowFlags bit 7); then
; counts wPartyWindowTimer up and acts only when it reaches $B4: timer = 0, wPartyWindowFlags = $80
; | (wPartyCount - 1), hSpriteWindowClipMode = 3, copies screen rows 12-17 (and CGB attributes & 7)
; into wWindowTileBuffer + $64, draws the 7, 13 or 19-wide frame for 1, 2 or 3 members
; (ShowIdlePartyStatusWindow_TileRect, _2, _3), fills in the rows (BuildPartyStatusWindowRows),
; draws them (ShowIdlePartyStatusWindow_Draw) and loads the party tiles (LoadTilesForPartyRecords).
; Its only caller, OpenFieldMenuOnA, sets the timer to $B3 first, so it shows at once; the earlier
; note (after $B4 idle frames) is not supported by any caller in src/. (C1, E-0374)
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
    call ShowIdlePartyStatusWindow_CopyRect
    jr .call_build_party_status_window_rows

.skip2:
    ld de, ShowIdlePartyStatusWindow_TileRect_2
    ld hl, wWindowTileBuffer + $64
    lb bc, $0d, $06
    call ShowIdlePartyStatusWindow_CopyRect
    jr .call_build_party_status_window_rows

.skip3:
    ld de, ShowIdlePartyStatusWindow_TileRect_3
    ld hl, wWindowTileBuffer + $64
    lb bc, $13, $06
    call ShowIdlePartyStatusWindow_CopyRect

.call_build_party_status_window_rows:
    call BuildPartyStatusWindowRows
    call ShowIdlePartyStatusWindow_Draw
    farcall LoadTilesForPartyRecords
    ret

SECTION "Bank 02 BuildPartyStatusWindowRows", ROMX

; Enables SRAM (rRAMG = $0A, bank as mapped) and, for the first (wPartyWindowFlags & 3) + 1 entries
; of wPartyList, writes into wWindowTileBuffer + $64 at the four offsets of
; BuildPartyStatusWindowRows_Data per member: MON_LEVEL as two digit tiles
; (WriteTwoDigitTilesFromDigits1), MON_HP and MON_MP as three (WriteDecimalDigitTiles), and a status
; mark at the fourth offset: $C2 when MON_STATUS bit 7 is set; otherwise $C1 there when bit 2 is set
; and $C0 in the cell one row up when bit 0 is set. Disables SRAM at the end. (C2, E-0374)
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

SECTION "Bank 02 BuildPartyStatusWindowRows_Data", ROMX

; Three groups of four byte offsets into wWindowTileBuffer + $64 (rows of 20 tiles), one group per
; party member: level, HP, MP and status mark. Member 0 uses $54, $2B, $3F, $51, member 1 uses $5A,
; $31, $45, $57 and member 2 uses $60, $37, $4B, $5D, which puts the three members in columns 1, 7
; and 13 and the HP, MP and level on rows 2, 3 and 4. BuildPartyStatusWindowRows reads the group of
; each of the first (wPartyWindowFlags & 3) + 1 entries of wPartyList. (C1, E-0381)
BuildPartyStatusWindowRows_Data::
    db $54, $2b, $3f, $51, $5a, $31, $45, $57, $60, $37, $4b, $5d

; Draws the party window: copies the 20 x 6 tiles at wWindowTileBuffer + $64 to the BG map 12 rows
; below the scroll position (CopyRectFromBankToBGMapWrapped, wrapping inside $9800-$9BFF), and on
; CGB the matching attributes from wWindowAttrBuffer + $64 (WRAM bank 2) into VRAM bank 1; leaves
; rSVBK and rVBK at 0. (C1, E-0374)
; draws the 20 x 6 window wWindowTileBuffer + $64 at the scroll position + $180 (and its CGB
; attributes from wWindowAttrBuffer + $64) (E-0127) (E-0340: the address in its name read as its RAM
; name; was ShowIdlePartyStatusWindow_Draw)
ShowIdlePartyStatusWindow_Draw::
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

SECTION "Bank 02 ShowIdlePartyStatusWindow_CopyRect", ROMX

; The same copy as OpenFieldMenuOnA_CopyRect for ShowIdlePartyStatusWindow (destination
; wWindowTileBuffer + $64): B x C rectangle from DE into 20-byte rows at HL; it adds $E68 to HL
; before testing wIsCGB, so on DMG it returns HL + $E68 with B and C kept, and on CGB zeroes the
; rectangle at HL + $E68 in WRAM bank 2 and returns HL C rows past that, C = 0, rSVBK = 0. (C2,
; E-0374)
; copies a B x C rectangle from DE to HL (20-byte rows); on CGB clears the matching attribute rows
; in WRAM bank 2 (E-0127) (E-0344: the address in its name dropped or read as the label there; was
; ShowIdlePartyStatusWindow_CopyRect)
ShowIdlePartyStatusWindow_CopyRect::
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

SECTION "Bank 02 ShowIdlePartyStatusWindow_TileRect", ROMX

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

; Animates a text window opening or closing while wTextWindowState & 3 is not 0 (bit 0 set =
; opening, bit 7 = the top window, else rows 13-17). Each call refreshes wWindowTileBuffer from the
; 5 window rows of wScreenTileBuffer (and CGB attributes & 7), computes their BG map address from
; the scroll, and increments wTextWindowStep; on odd values it runs stage (step / 2) & 3:
; StepTextWindowOpenClose_CopyRow, _CopyRows, then _CopyAllRows (also for 3), which draw one middle
; row, then the three-row frame, then the whole window (closing: the frame, the middle row, then the
; plain screen), redraw 20 x 5 at the BG map and finally leave only bit 7 of wTextWindowState with
; wTextWindowStep = 0. (C1, E-0374)
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
    dw StepTextWindowOpenClose_CopyRow
    dw StepTextWindowOpenClose_CopyRows
    dw StepTextWindowOpenClose_CopyAllRows
    dw StepTextWindowOpenClose_CopyAllRows

; Text window step 0: opening, copies the window's bottom row (from StepTextWindowOpenClose_Data1)
; into the buffer; closing, restores three rows from StepTextWindowOpenClose_Data2; then redraws the
; 20 x 5 window area. (C1, E-0357)
StepTextWindowOpenClose_CopyRow::
    ld a, [wTextWindowState]
    bit 0, a
    jr z, .skip
    push de
    ld hl, wWindowTileBuffer + $28
    ld de, StepTextWindowOpenClose_CopyRow_Data1
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
    ld de, StepTextWindowOpenClose_CopyRow_Data2
    ld b, $03
    call CopyRowsToScreenBufferAndClearAttributes
    pop de
    ld l, e
    ld h, d
    lb bc, $14, $05
    call CopyScreenRectToBGMapSetTextCursorLo
    ret

SECTION "Bank 02 StepTextWindowOpenClose_CopyRows", ROMX

; Text window step 1: the middle rows (opening) or the bottom row (closing), then redraws the window
; area. (C1, E-0357)
StepTextWindowOpenClose_CopyRows::
    ld a, [wTextWindowState]
    bit 0, a
    jr z, .skip
    push de
    ld hl, wWindowTileBuffer + $14
    ld de, StepTextWindowOpenClose_CopyRow_Data2
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
    ld de, StepTextWindowOpenClose_CopyRow_Data1
    ld b, $01
    call CopyRowsToScreenBufferAndClearAttributes
    pop de
    ld l, e
    ld h, d
    lb bc, $14, $05
    call CopyScreenRectToBGMapSetTextCursorLo
    ret

SECTION "Bank 02 StepTextWindowOpenClose_CopyAllRows", ROMX

; Text window step 2: opening, copies all five rows of the window
; (StepTextWindowOpenClose_CopyAllRows_Data); closing, just redraws; then ends the open/close
; (wTextWindowState keeps only bit 7, step 0). (C1, E-0357)
StepTextWindowOpenClose_CopyAllRows::
    ld a, [wTextWindowState]
    bit 0, a
    jr z, .skip
    push de
    ld hl, wWindowTileBuffer
    ld de, StepTextWindowOpenClose_CopyAllRows_Data
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

SECTION "Bank 02 CopyScreenRectToBGMapSetTextCursorLo", ROMX

; HL = BG map address, B = width, C = rows: copies that rectangle of wWindowTileBuffer (rows 20
; bytes apart) to the BG map with CopyRectFromBankToBGMapWrapped, sets wTextCursorLo/Hi = HL + $21
; (one row down, one column in, kept inside the same 1 KB map), and on CGB copies the rectangle of
; wWindowAttrBuffer (WRAM bank 2) into VRAM bank 1; HL and BC are kept. (C1, E-0374)
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

SECTION "Bank 02 CopyRowsToScreenBufferAndClearAttributes", ROMX

; B = rows, DE = source, HL = destination: copies B rows of 20 bytes from DE to HL (its callers, the
; StepTextWindowOpenClose stages, pass rows of wWindowTileBuffer) and returns HL + $E68 with B and C
; kept on DMG; on CGB it then zeroes the B rows at HL + $E68 in WRAM bank 2 (wWindowAttrBuffer),
; returning B = 0, C = 0 and rSVBK = 0. (C2, E-0374)
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

SECTION "Bank 02 StepTextWindowOpenClose_CopyRow_Data1", ROMX

; One 20-tile window row: $B6, eighteen tiles $C3, $B7 (left edge, blank inside, right edge).
; StepTextWindowOpenClose_CopyRow (opening) and StepTextWindowOpenClose_CopyRows (closing) copy it
; with CopyRowsToScreenBufferAndClearAttributes into row 2 of wWindowTileBuffer (+ $28), the middle
; row of the 20 by 5 text window; it is the first frame of the opening animation and the last of the
; closing one. (C1, E-0381)
StepTextWindowOpenClose_CopyRow_Data1::
    db $b6
    ds $12, $c3
    db $b7

; Three 20-tile rows of the text window: $B0, eighteen $B1, $B2; then $B6, eighteen $C3, $B7; then
; $B3, eighteen $B4, $B5 (a box with corner and edge tiles around a blank inside).
; StepTextWindowOpenClose_CopyRows (opening) and StepTextWindowOpenClose_CopyRow (closing) copy them
; into rows 1-3 of wWindowTileBuffer (+ $14) with CopyRowsToScreenBufferAndClearAttributes. (C1,
; E-0381)
StepTextWindowOpenClose_CopyRow_Data2::
    db $b0
    ds $12, $b1
    db $b2, $b6
    ds $12, $c3
    db $b7, $b3
    ds $12, $b4
    db $b5

; The five 20-tile rows of the finished text window: a top edge ($B0, eighteen $B1, $B2); a text row
; ($B6, tiles $80-$91, $B7); a blank row ($B6, eighteen $C3, $B7); a second text row ($B6, tiles
; $92-$A3, $B7); a bottom edge ($B3, eighteen $B4, $B5). StepTextWindowOpenClose_CopyAllRows copies
; them to the start of wWindowTileBuffer when the window opens, then redraws the 20 by 5 area. (C1,
; E-0381)
StepTextWindowOpenClose_CopyAllRows_Data::
    db $b0
    ds $12, $b1
    db $b2, $b6, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8a, $8b, $8c, $8d
    db $8e, $8f, $90, $91, $b7, $b6
    ds $12, $c3
    db $b7, $b6, $92, $93, $94, $95, $96, $97, $98, $99, $9a, $9b, $9c, $9d, $9e, $9f
    db $a0, $a1, $a2, $a3, $b7, $b3
    ds $12, $b4
    db $b5

; Field state 6 (FieldState_FieldMenu far-calls it): runs the warp effect step chosen by wMenuState
; & $0F: 0 WarpEffect_PlayMusic (queues music 2, silences the sound, waits or plays sound $78), 1
; WarpEffect_Cover (sound $61, covers the off-screen columns, fills the line scroll table), 2
; WarpEffect_StartWave (turns on the STAT wave), 3 WarpEffect_GrowWave, 4 WarpEffect_FadePalette, 5
; WarpEffect_Warp (restarts the map music and moves the player), 6-8 WarpEffect_Idle. The earlier
; note (the field menu, menu music, closing it) does not match the steps. The opening test of
; wMenuState does nothing (both paths reach the same label). (C1, E-0374)
; the field menu (field state 6): by wMenuState & $0F it plays the menu's music and sounds, sets the
; cursor and sub-state of the open menu, and closes it (InitSoundHardware); states 6-8 return at
; once (E-0354; was: runs the routine for wMenuState & $0F (jump table) (E-0122)) (renamed from
; RunMenuStateMenuState from its E-0357 note, E-0367)
WarpEffect::
    ld a, [wMenuState]
    or a
    jr nz, .check_menu_state

.check_menu_state:
    ld a, [wMenuState]
    and $0f
    jumptable
    dw WarpEffect_PlayMusic
    dw WarpEffect_Cover
    dw WarpEffect_StartWave
    dw WarpEffect_GrowWave
    dw WarpEffect_FadePalette
    dw WarpEffect_Warp
    dw WarpEffect_Idle
    dw WarpEffect_Idle
    dw WarpEffect_Idle

; Warp effect steps 6, 7 and 8 (wMenuState & $0F in WarpEffect): returns at once and does nothing.
; (C2, E-0369; probed E-0374)
WarpEffect_Idle::
    ret

SECTION "Bank 02 WarpEffect_PlayMusic", ROMX

; Field state 6, the warp effect, step 0: queues music 2 and silences the channels; in a key world
; (wMapToggleFlag bit 7) it plays sound $78 at once, otherwise it waits $3B frames. (C1, E-0357)
WarpEffect_PlayMusic::
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

SECTION "Bank 02 WarpEffect_Cover", ROMX

; Warp effect step 1: after the wait, plays sound $61, covers the 12 columns right of the screen
; with tile $C4, fills the per-line scroll table (wBGPaletteCopy, $90 lines) with hScrollX,
; precomputes the brightened palettes and starts a $1E-frame countdown. (C1, E-0357)
WarpEffect_Cover::
    ld a, [wMenuCursor]
    inc a
    ld [wMenuCursor], a
    cp $3c
    ret c
    ld a, $61
    call QueueSoundEffect
    call WarpEffect_CoverColumns
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
    call WarpEffect_Cover_BuildBrightPalettes
    xor a
    ld [wScreenState], a
    ret

SECTION "Bank 02 WarpEffect_CoverColumns", ROMX

; Covers the 12 BG map columns to the right of the visible screen (18 rows) with tile $C4, wrapping
; inside each row. (C1, E-0357)
WarpEffect_CoverColumns::
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

SECTION "Bank 02 WarpEffect_StartWave", ROMX

; Warp effect step 2: counts down $1E frames, then turns on the horizontal wave (STAT split 2 from
; line 2). (C1, E-0357)
WarpEffect_StartWave::
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

SECTION "Bank 02 WarpEffect_GrowWave", ROMX

; Warp effect step 3: every 8 frames increases the wave amplitude (wMenuCursor) until it reaches
; $38, then goes to step 4. (C2, E-0357; probed E-0374)
WarpEffect_GrowWave::
    ld a, $01
    ld [wMenuSubState], a
    ld a, [wFrameCounterLo]
    and $07
    jr nz, WarpEffect_FillScrollTable
    ld a, [wMenuCursor]
    swap a
    and $0f
    inc a
    ld b, a
    ld a, [wMenuCursor]
    add b
    ld [wMenuCursor], a
    cp $38
    jr c, WarpEffect_FillScrollTable
    ld hl, wMenuState
    inc [hl]
    xor a
    ld [wSubMenuCursor], a

; Fills part of the per-line X scroll table each frame: with e = (wFrameCounterLo / 4) & $0F and a
; start chosen by wFrameCounterLo & 3 (wBGPaletteCopy, wBGPaletteCopy + $24, wTextBuf0 + 8,
; wTextBuf2 + $0C, that is $C0F0, $C114, $C138, $C15C), it writes 26 pairs of equal bytes (52
; lines), advancing e (mod 16) before each pair: hScrollX plus the high byte of wMenuCursor *
; WarpEffect_FillScrollTable_Data[e], or minus it when bit 3 of e is set, giving the wave. The four
; ranges overlap by 16 bytes and the last one ends at $C18F, past the $90 lines WarpEffect_Cover
; fills. The earlier note (a quarter of the table, amplitude * entry) is corrected here. (C2,
; E-0374)
WarpEffect_FillScrollTable::
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
    ld hl, WarpEffect_FillScrollTable_Data
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

SECTION "Bank 02 WarpEffect_FillScrollTable_Data", ROMX

; Sixteen unsigned wave magnitudes, $00, $60, $B6, $EC, $FF, $EC, $B6, $60 repeated twice (the shape
; of a sine half-wave scaled to $FF), indexed by e, which starts at (wFrameCounterLo / 4) & $0F and
; advances by 1 (mod 16) before each pair of lines. WarpEffect_FillScrollTable multiplies the entry
; by wMenuCursor with Multiply8 and adds the high byte of the product to hScrollX when bit 3 of e is
; clear, or subtracts it when it is set, for each pair of lines it writes to the line scroll table.
; (C1, E-0381)
WarpEffect_FillScrollTable_Data::
    db $00, $60, $b6, $ec, $ff, $ec, $b6, $60, $00, $60, $b6, $ec, $ff, $ec, $b6, $60

; Warp effect step 4: every 16 frames steps the DMG palette through WarpEffect_FadePalette_Data (a
; fade) with the matching CGB palette step; after 4 steps the wave is turned off and step 5 follows.
; (C1, E-0357)
WarpEffect_FadePalette::
    ld a, [wFrameCounterLo]
    and $0f
    jr nz, .read_sub_menu_cursor
    ld a, [wSubMenuCursor]
    inc a
    ld [wSubMenuCursor], a
    cp $04
    jr nz, .read_sub_menu_cursor
    call WarpEffect_FadePalette_SyncCGB
    ld hl, wMenuState
    inc [hl]
    xor a
    ld [wSTATSplitEnable], a

.read_sub_menu_cursor:
    ld a, [wSubMenuCursor]
    ld hl, WarpEffect_FadePalette_Data
    add_a_to_hl
    ld a, [hl]
    ld [wDMGPaletteBGP], a
    call WarpEffect_FadePalette_SyncCGB
    jp WarpEffect_FillScrollTable

SECTION "Bank 02 WarpEffect_FadePalette_Data", ROMX

; Five DMG palette bytes, $D2, $81, $40, $00, $00, indexed by wSubMenuCursor (0-4).
; WarpEffect_FadePalette stores the entry in wDMGPaletteBGP every frame, so wDMGPaletteBGP steps
; through those values and ends at $00 (all four colours on shade 0); wSubMenuCursor goes up by 1
; every 16 frames and the warp effect moves to its next step when it reaches 4. (C1, E-0381)
WarpEffect_FadePalette_Data::
    db $d2, $81, $40, $00, $00

; Warp effect step 5, the warp itself: silences and restarts the map music, then moves the player. A
; normal warp goes to wWarpDestX/Y on the current map (a key world when wWarpDestFacing is $F0) and
; enters the field. In a key world (wMapToggleFlag bit 7) it saves the key world and uses the key
; list entry of wCurrentKeyIndex: a key marked as leaving (bit 7 of its byte 3) returns the player
; to the destination in KeyListMapDestinationTable (setting two story flags when their condition
; flags are set, and running talk event $1A for destination 1); otherwise it enters the key world,
; from a free SRAM slot or the slot already saved, at its goal screen and position. (C1, E-0357)
WarpEffect_Warp::
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
    farcall WarpEffect_Warp_MarkExitVisited
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
    farcall WarpEffect_Warp_StartNewKeyWorld
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

SECTION "Bank 02 KeyListMapDestinationTable", ROMX

; the code after WarpEffect_Warp.read_current_key_index takes the key list byte & $3F as the index,
; sets game mode 1 and loads hMapId, hMapScreenX, hMapScreenY, hPlayerX and hPlayerY from the 8-byte
; record at $7006 + 8 * index; 13 records (E-0237, C1)
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

; Checks whether a save exists: enables SRAM bank 1 and sets hTemp0 = 1 when sSaveSignature is not
; $55 (no save); otherwise 2 when VerifySaveBank1Checksum or VerifySaveBank3Checksum returns A not 0
; (damaged), else 0 (valid). Then disables SRAM (rRAMG = 0, rRAMB = 0). (C2, E-0374)
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

SECTION "Bank 02 VerifySaveBank1Checksum", ROMX

; Selects SRAM bank 1 (SRAM already enabled), sums the $29A * 10 = $1A04 bytes from sBank1Records
; ($A06F) into the word DE, then returns A = 0 when sBank1Checksum ($BA73, little-endian) equals
; (~sum + $4321) & $FFFF and A = 1 otherwise; DE = that expected value. CheckSaveData uses it (C2
; from E-0323: after a save the stored word equals that value, and a fresh power-on offers
; CONTINUE). (C2, E-0374)
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

SECTION "Bank 02 VerifySaveBank3Checksum", ROMX

; Selects SRAM bank 3, sums the $333 * 10 = $1FFE bytes from $A000 (sRecords) into DE, then returns
; A = 0 when the little-endian word right after them ($BFFE) equals (~sum + $1234) & $FFFF and A = 1
; otherwise; leaves bank 3 mapped. CheckSaveData uses it (C2 from E-0323, as
; VerifySaveBank1Checksum). (C2, E-0374)
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

SECTION "Bank 02 RunLoadGameSteps", ROMX

; Loads the saved game a stage per call, by wSaveStep, with SRAM enabled: 0 sets it to 1 and loads
; the saved WRAM blocks (LoadSaveBlocksFromSRAM), restores SRAM bank 2 from bank 3
; (RestoreSRAMBank2FromBank3), the records from their bank-1 backup
; (RestoreRecordsFromSRAMBank1Backup) and the game-mode-2 timer block (LoadGM2TimerBlockFromSRAM); 1
; unpacks one saved record per call (UnpackNextSavedRecord, which moves wSaveStep to 2 after record
; 30); any other value sets bit 7 of wSaveStep (finished). Each call ends with rRAMG = 0 and rRAMB =
; 0. It only reads the save. (C2, E-0374; probed E-0384)
; with SRAM enabled, steps by wSaveStep: on the first call (0) sets it to 1, loads the saved WRAM
; blocks (LoadSaveBlocksFromSRAM), restores SRAM bank 2 from its bank-3 copy, the records from their
; bank-1 backup (RestoreRecordsFromSRAMBank1Backup) and the game-mode-2 timer block; while it is 1
; unpacks one saved record per call (UnpackNextSavedRecord, which moves it on after record 30); then
; sets bit 7 of wSaveStep (finished); disables SRAM each time. It only reads the save (renamed from
; RunSaveSteps, E-0366)
RunLoadGameSteps::
    ld a, $0a
    ld [rRAMG], a
    ld a, [wSaveStep]
    or a
    jr nz, .skip
    inc a
    ld [wSaveStep], a
    call LoadSaveBlocksFromSRAM
    call RestoreSRAMBank2FromBank3
    call RestoreRecordsFromSRAMBank1Backup
    call LoadGM2TimerBlockFromSRAM
    jr .skip2

.skip:
    dec a
    jr nz, .check_save_step
    call UnpackNextSavedRecord
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

SECTION "Bank 02 UnpackNextSavedRecord", ROMX

; Unpacks one saved record: calls UnpackRecordFromBank1Slot with wArg1 = wSaveRecordIndex, wArg2 = 1
; (SRAM bank 1) and wArg3/wArg4 = sBank1Records + $6F * index (its compact slot). Only when wArg5 is
; $FF afterwards does it advance wSaveRecordIndex, and when that reaches 30 ($1E) it increments
; wSaveStep. (C2, E-0374; probed E-0384)
; unpacks SRAM bank 1 record wSaveRecordIndex ($A06F + $6F * index) with UnpackRecordFromBank1Slot;
; when wArg5 is $FF advances wSaveRecordIndex and, after record 30, increments wSaveStep (renamed
; from ScanBank1RecordStepSaveRecordIndex, E-0366)
UnpackNextSavedRecord::
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

SECTION "Bank 02 RestoreRecordsFromSRAMBank1Backup", ROMX

; Copies the record backup back: the first $C93 bytes at sRecordBackup (SRAM bank 1) to
; sCompactRecords in bank 0 (switching rRAMB per pair of bytes), then the next $6F bytes to sRecords
; in bank 1 (the bank-1 record); leaves bank 1 mapped. The counterpart of BackupRecordsToSRAMBank1;
; the backup ends right before sBank1Checksum. (C2, E-0374)
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

SECTION "Bank 02 RestoreSRAMBank2FromBank3", ROMX

; Restores SRAM bank 2 (where the key-world slots are saved) from its backup in bank 3: $1FFE bytes
; from $A000, 10 bytes per pass. (C2, E-0357; probed E-0374)
; copies $1FFE bytes from SRAM bank 3 back to bank 2 at $A000 (the key-world slots and their saved
; copy, E-0366)
RestoreSRAMBank2FromBank3::
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

SECTION "Bank 02 LoadSaveBlocksFromSRAM", ROMX

; Loads the saved WRAM blocks: with SRAM bank 1 mapped, walks LoadSaveBlocksFromSRAM_Data (word
; address, word length; address 0 ends it) and copies each block from sSaveData onward into WRAM
; (SRAM to WRAM, despite the name); then wSaveStateFlag = $80. (C2, E-0357; probed E-0374)
; with SRAM bank 1 mapped, walks LoadSaveBlocksFromSRAM_Data (word address, word length; a zero
; address ends it) and copies each block from sSaveData onward into WRAM, then sets wSaveStateFlag
; to $80 (renamed from CopySaveBlocksToSRAM: the copy goes from SRAM to WRAM, E-0366)
LoadSaveBlocksFromSRAM::
    ld a, $01
    ld [rRAMB], a
    ld hl, LoadSaveBlocksFromSRAM_Data
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

SECTION "Bank 02 LoadGM2TimerBlockFromSRAM", ROMX

; Restores the game-mode-2 timer block ($D8 bytes at sSavedTimerBlock in SRAM bank 1) into
; wGM2TimerFrames when sSavedGM2Mode is 0 or 1. (C2, E-0357; probed E-0374)
; when sSavedGM2Mode is 0 or 1 copies the $D8 bytes at sSavedTimerBlock (SRAM bank 1) to
; wGM2TimerFrames; the counterpart of the save routine that writes them (E-0366)
LoadGM2TimerBlockFromSRAM::
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

SECTION "Bank 02 SaveGM2TimerFramesBlockToSRAMBank1", ROMX

; When wGiftRecord (MON_STATE of the gift Egg record, inside the block) is 0 or 1, copies the $D8
; bytes from wGM2TimerFrames to sSavedTimerBlock in SRAM bank 1 (rSVBK = 0 first); otherwise copies
; nothing. The counterpart of LoadGM2TimerBlockFromSRAM, which tests the saved copy (sSavedGM2Mode).
; (C2, E-0374)
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

SECTION "Bank 02 RunSaveGameSteps", ROMX

; Saves the game a stage per call, by wSaveStep, with SRAM enabled: 0 sets it to 1, saves the WRAM
; blocks with their checksum (CopySaveBlocksToSRAMWithSum) and runs RunSaveGameSteps_FirstStage
; (bank 2 backup, record backup, timer block); 1 packs one record per call into bank 1
; (PackNextSavedRecord, which moves wSaveStep to 2 after 30 records); any later value writes the
; bank-1 checksum and sets wSaveStep bit 7 (RunSaveGameSteps_CopyRecordOrFinish). SRAM is closed
; after each call. Used by the link and priest screens; RunSaveGameSteps_2 is the same with a sprite
; snapshot. (C2, E-0374; probed E-0384)
; with SRAM enabled: on the first step (wSaveStep = 0) copies the save blocks with their checksum
; and continues with the next save stage (E-0122)
RunSaveGameSteps::
    ld a, $0a
    ld [rRAMG], a
    ld a, [wSaveStep]
    or a
    jr nz, RunSaveGameSteps_CopyRecordOrFinish
    inc a
    ld [wSaveStep], a
    call CopySaveBlocksToSRAMWithSum
    jr RunSaveGameSteps_FirstStage

SECTION "Bank 02 RunSaveGameSteps_2", ROMX

; As RunSaveGameSteps, except that stage 0 runs SnapshotSpritesForSave (which saves the sprite slots
; into wSpriteSnapshot and then falls into CopySaveBlocksToSRAMWithSum) before
; RunSaveGameSteps_FirstStage. Called once per frame by the pause menu save
; (RunPauseMenuScreen_Save) and by banks $0D and $15 until wSaveStep bit 7 is set. (C2, E-0374;
; probed E-0384)
; with SRAM enabled runs one save stage per call (sprites snapshot and blocks, then records, then
; the final stage marked by bit 7 of wSaveStep) (E-0124) (E-0344: the address in its name dropped or
; read as the label there; was RunSaveGameSteps_2)
RunSaveGameSteps_2::
    ld a, $0a
    ld [rRAMG], a
    ld a, [wSaveStep]
    or a
    jr nz, RunSaveGameSteps_CopyRecordOrFinish
    inc a
    ld [wSaveStep], a
    call SnapshotSpritesForSave

; Save stage 0, shared by RunSaveGameSteps (jumps here after CopySaveBlocksToSRAMWithSum) and
; RunSaveGameSteps_2 (falls in after SnapshotSpritesForSave), both having set wSaveStep = 1: backs
; up SRAM bank 2 into bank 3 (RunSaveGameSteps_FirstStage_BackupBank2), backs up the monster records
; into bank 1 (BackupRecordsToSRAMBank1) and saves the timer block
; (SaveGM2TimerFramesBlockToSRAMBank1), then closes SRAM (RunSaveGameSteps_CloseSRAM). (C2, E-0369;
; probed E-0374)
RunSaveGameSteps_FirstStage::
    call RunSaveGameSteps_FirstStage_BackupBank2
    call BackupRecordsToSRAMBank1
    call SaveGM2TimerFramesBlockToSRAMBank1
    jr RunSaveGameSteps_CloseSRAM

SECTION "Bank 02 RunSaveGameSteps_CopyRecordOrFinish", ROMX

; Save stages after the first, for both RunSaveGameSteps and RunSaveGameSteps_2 (A = wSaveStep, not
; 0): stage 1 copies one bank-1 record per call (PackNextSavedRecord, which moves wSaveStep to 2
; after 30 records); any later value writes the bank-1 checksum (ComputeSRAMBank1RecordChecksum) and
; sets wSaveStep bit 7 (the save is done). Then falls into RunSaveGameSteps_CloseSRAM. (C2, E-0369;
; probed E-0384)
RunSaveGameSteps_CopyRecordOrFinish::
    dec a
    jr nz, .call_compute_sram_bank1_record_checksum
    call PackNextSavedRecord
    jr RunSaveGameSteps_CloseSRAM

.call_compute_sram_bank1_record_checksum:
    call ComputeSRAMBank1RecordChecksum
    ld a, [wSaveStep]
    or $80
    ld [wSaveStep], a

; Closes SRAM (rRAMG = 0, bank 0). (C2, E-0357; probed E-0374)
RunSaveGameSteps_CloseSRAM::
    xor a
    ld [rRAMG], a
    ld [rRAMB], a
    ret

SECTION "Bank 02 ComputeSRAMBank1RecordChecksum", ROMX

; Selects SRAM bank 1, sums the $29A * 10 = $1A04 bytes from sBank1Records and stores (~sum + $4321)
; & $FFFF, little-endian, at sBank1Checksum (C2 from E-0323: recomputed from the cartridge RAM after
; a save it equals the stored word, 0 before). (C2, E-0374)
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

SECTION "Bank 02 PackNextSavedRecord", ROMX

; Packs one record for the save: calls PackRecordFieldsToBank1Slot with wArg1 = wSaveRecordIndex,
; wArg2 = 1 (SRAM bank 1) and wArg3/wArg4 = sBank1Records + $6F * index (the compact slot), then
; increments wSaveRecordIndex and, when it reaches 30 ($1E), wSaveStep. The counterpart of
; UnpackNextSavedRecord. (C2, E-0374; probed E-0384)
; copies SRAM bank-1 record wSaveRecordIndex ($6F bytes at sBank1Records + $6F * n) through
; PackRecordFieldsToBank1Slot, then wSaveRecordIndex += 1; after 30 records wSaveStep += 1 (the next
; save step) (E-0120)
PackNextSavedRecord::
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

SECTION "Bank 02 BackupRecordsToSRAMBank1", ROMX

; Backs up the records into SRAM bank 1: the $C93 bytes from sCompactRecords (bank 0, switching
; rRAMB per pair of bytes) and then the $6F bytes at sRecords in bank 1 (the bank-1 record) go to
; sRecordBackup onward ($AD71-$BA72); leaves bank 1 mapped. RestoreRecordsFromSRAMBank1Backup undoes
; it. (C2, E-0374)
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

SECTION "Bank 02 ClearSRAMBanks2And3", ROMX

; Fills the $2000 bytes of SRAM bank 2 and then bank 3 with $FF (FillBytes); leaves bank 3 mapped.
; (C2, E-0374)
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

SECTION "Bank 02 RunSaveGameSteps_FirstStage_BackupBank2", ROMX

; Backs up SRAM bank 2 (the key-world slots): clears banks 2 and 3 first when wSaveClearFlag is set,
; saves the current key world when in one, then copies $1FFE bytes from $A000 in bank 2 to bank 3
; and stores (~sum + $1234) of those bytes in the last word ($BFFE) as a checksum. (C2, E-0357;
; probed E-0374)
RunSaveGameSteps_FirstStage_BackupBank2::
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

SECTION "Bank 02 SnapshotSpritesForSave", ROMX

; Copies wScreenSavedFlag to wSpriteSnapshotCount and the $50 bytes of wSpriteSlots to
; wSpriteSnapshot, clears bit 1 of the five snapshot object flag bytes
; (wSnapshotSlot1-wSnapshotSlot5, byte $D of each 16-byte slot), and then falls into
; CopySaveBlocksToSRAMWithSum, so the snapshot (inside the wPlayerName block) is saved with the
; blocks and their checksum. (C2, E-0374)
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

; Saves the WRAM blocks: the same walk of LoadSaveBlocksFromSRAM_Data, copying each block from WRAM
; to sSaveData onward while summing its bytes; then writes the signature $55 and the sum + $9753 as
; the checksum (sSaveChecksumLo/Hi). (C2, E-0357; probed E-0374)
; the save's counterpart of LoadSaveBlocksFromSRAM: copies each block of LoadSaveBlocksFromSRAM_Data
; from WRAM to sSaveData onward while summing its bytes, then writes the signature $55 to
; sSaveSignature and the sum + $9753 to sSaveChecksumLo/Hi (E-0109, E-0366)
CopySaveBlocksToSRAMWithSum::
    ld a, $01
    ld [rRAMB], a
    ld hl, LoadSaveBlocksFromSRAM_Data
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

SECTION "Bank 02 LoadSaveBlocksFromSRAM_Data", ROMX

; Five four-byte entries (address word, length word, both little-endian): $FF8A length $000E (14
; bytes of high RAM), $C60C length $0291 (starting at wPlayerName), $CBD7 length $006B (starting at
; wStoryFlags), $CC42 length $00B5 (starting at wKeyWorldSlot) and an all-zero end entry.
; LoadSaveBlocksFromSRAM copies each block in turn from sSaveData onward (SRAM bank 1) into RAM, and
; CopySaveBlocksToSRAMWithSum walks the same list the other way while adding up the bytes. (C1,
; E-0381)
LoadSaveBlocksFromSRAM_Data::
    db $8a, $ff, $0e, $00, $0c, $c6, $91, $02, $d7, $cb, $6b, $00, $42, $cc, $b5, $00
    db $00, $00, $00, $00

; Reloads the saved blocks: enables SRAM bank 1 and, when sSaveSignature is $55, copies the four
; blocks at sSaveData back into hPlayerSpriteVariant ($0E bytes), wPlayerName ($291), wStoryFlags
; ($6B) and wKeyWorldSlot ($B5) while summing them (CopyBytesWithChecksum_Bank02_2). It returns C =
; $FF when there is no signature (nothing loaded) or when sum + $9753 equals sSaveChecksumLo/Hi; on
; a mismatch the blocks stay loaded and BC = stored - computed. Disables SRAM (rRAMG = 0). The
; earlier note had the two C cases reversed. Its only caller
; (RunLinkSession6Exchange_FightInfo_Save) ignores C, keeps the gold across it and then saves. (C2,
; E-0374)
; SRAM bank 1: C = $FF when sSaveSignature is not $55 or the checksum of the four saved blocks plus
; $9753 differs from sSaveChecksumLo; otherwise loads them and returns with C unchanged (E-0127)
ReloadSaveBlocksWithChecksum::
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

SECTION "Bank 02 CopyBytesWithChecksum_Bank02_2", ROMX

; The second copy in this bank of CopyBytesWithChecksum_Bank02 (same 20 bytes), used only by
; ReloadSaveBlocksWithChecksum to read the four save blocks back from SRAM bank 1: HL = source, DE =
; destination, BC = count; copies BC bytes, adding each to the 16-bit sum in hTemp2 (low) and hTemp3
; (high); returns BC = 0, A = 0, HL and DE past the copied bytes. (C2, E-0369; probed E-0374)
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

SECTION "Bank 02 SaveGameToSRAMWithChecksum", ROMX

; Enables SRAM bank 1 and copies hPlayerSpriteVariant ($0E bytes), wPlayerName ($291), wStoryFlags
; ($6B) and wKeyWorldSlot ($B5) to sSaveData onward while summing them
; (CopyBytesWithChecksum_Bank02), stores sum + $9753 at sSaveChecksumLo/Hi and $55 at
; sSaveSignature, then disables SRAM. The same result as CopySaveBlocksToSRAMWithSum with the block
; list written out. Callers: the link fight info save and the battle results save. (C2, E-0374)
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

SECTION "Bank 02 CopyBytesWithChecksum_Bank02", ROMX

; HL = source, DE = destination, BC = count (not 0): copies BC bytes and adds each one to the 16-bit
; sum in hTemp2 (low) and hTemp3 (high); returns BC = 0, A = 0, HL and DE past the copied bytes.
; Used by SaveGameToSRAMWithChecksum; CopyBytesWithChecksum_Bank02_2 is the same 20 bytes. (C2,
; E-0374)
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

SECTION "Bank 02 RunRestoreAndUnpackRecordsSteps", ROMX

; With SRAM enabled: on the first call (wSaveStep = 0) sets wSaveStep = 1 and restores the records
; from their bank-1 backup (RestoreRecordsFromSRAMBank1Backup); every call then unpacks one saved
; record (UnpackNextSavedRecord), and once wSaveStep is 2 sets it to $80 (done); disables SRAM. No
; caller names it in src/. (C2, E-0374; probed E-0384)
; with SRAM enabled: first call runs RestoreRecordsFromSRAMBank1Backup, then scans bank-1 records;
; after stage 2 sets wSaveStep = $80 (E-0124)
RunRestoreAndUnpackRecordsSteps::
    ld a, $0a
    ld [rRAMG], a
    ld a, [wSaveStep]
    or a
    jr nz, .call_unpack_next_saved_record
    inc a
    ld [wSaveStep], a
    call RestoreRecordsFromSRAMBank1Backup

.call_unpack_next_saved_record:
    call UnpackNextSavedRecord
    ld a, [wSaveStep]
    cp $02
    jr nz, .done
    ld a, $80
    ld [wSaveStep], a

.done:
    xor a
    ld [rRAMG], a
    ret

SECTION "Bank 02 RunBackupAndSaveSteps", ROMX

; With SRAM enabled: on the first call (wSaveStep = 0) sets wSaveStep = 1 and backs up the records
; (BackupRecordsToSRAMBank1); every call then packs one record (PackNextSavedRecord), and once
; wSaveStep reaches 2 it writes the bank-1 checksum (ComputeSRAMBank1RecordChecksum) and sets
; wSaveStep = $80; disables SRAM. The battle results save calls it each frame until bit 7, then
; SaveGameToSRAMWithChecksum. (C2, E-0374; probed E-0384)
; enables SRAM; on the first step backs up the records to SRAM bank 1 (BackupRecordsToSRAMBank1),
; then runs PackNextSavedRecord until wSaveStep reaches 2
RunBackupAndSaveSteps::
    ld a, $0a
    ld [rRAMG], a
    ld a, [wSaveStep]
    or a
    jr nz, .call_pack_next_saved_record
    inc a
    ld [wSaveStep], a
    call BackupRecordsToSRAMBank1

.call_pack_next_saved_record:
    call PackNextSavedRecord
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

; The byte stored here, $00, is never read. StartPaletteFade_SetUpTiming loads the ADDRESS of this
; label into DE (the label sits at $7FFF, the last address of the bank) and writes DE as the colour
; word to all 32 BG and 32 OBJ palette entries, so the address itself serves as the RGB555 colour
; $7FFF (white) for a fade in; when bit 7 of wFadeMode is set DE is 0 (black) instead. (C1, E-0381)
StartPaletteFade_WhiteColourAddress::
    db $00
