SECTION "Bank 5F", ROMX[$4000], BANK[$5F]
    INCBIN "dwm2-cobi-us.gbc", $17C000, $2308

; LZSS-compressed asset: 275 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05F_6308:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $17E308, $113

; LZSS-compressed asset: 274 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05F_641B:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $17E41B, $112

; LZSS-compressed asset: 292 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05F_652D:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $17E52D, $124

; LZSS-compressed asset: 250 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05F_6651:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $17E651, $FA

; LZSS-compressed asset: 131 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05F_674B:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $17E74B, $83

; LZSS-compressed asset: 128 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05F_67CE:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $17E7CE, $80

; LZSS-compressed asset: 122 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05F_684E:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $17E84E, $7A

; LZSS-compressed asset: 110 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05F_68C8:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $17E8C8, $6E

; wMessageState ($FF = idle) steps a message: 0 opens the message window (unless wMessageGroup bit 7) at the bottom, or at the top when hPlayerY >= $48, with sound $69; 1 waits for the window, then ShowMessageFromWC924 starts the text; 2 waits until wC52B bit 0 clears (text done), then closes the window (unless wMessageGroup bit 6); 3 waits for the close. When wC928 is 0, state 0 also calls Func_004_4470 and state 3 ClearBit1OfPlayerAndObjectFlags (probably freezing and releasing the player and objects). The steps after state 3 are not read (E-0079)
; 6 call sites from 6 routines (e.g. RunMessageBoxCarryWhenIdle_Bank5F, RunMessageBoxFar_Bank0F, RunMessageBoxFar_Bank12, ScriptCommand16_Run_Case17, ...)
; reads: wMessageState
RunMessageBox::
Func_05F_6936:: ; address name
    ld a, [wMessageState]
    cp a, $FF
    jr nz, Jump_05F_693E
    ret

Jump_05F_693E::
    rst $00
    dw RunMessageBox_Case00
    dw RunMessageBox_Case01
    dw RunMessageBox_Case02
    dw RunMessageBox_Case03

; entry 0 of the `rst $00` table in RunMessageBox
; no direct call (reached through a table, a jump or a vector)
; reads: wC928, wMessageGroup, hPlayerY
; writes: wC8CB, wC8CC, hFFB9
; points at: wMessageState
RunMessageBox_Case00::
Jump_05F_6947:: ; address name
    ld a, [wC928]
    or a, a
    jr nz, Jump_05F_6953
    farcall Func_004_4470

Jump_05F_6953::
    ld a, [wMessageGroup]
    bit 7, a
    jr nz, Jump_05F_6988
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
    jr c, Jump_05F_6988
    ld a, $81
    ld [wC8CB], a
    ld a, $01
    ldh [hFFB9], a

Jump_05F_6988::
    ld hl, wMessageState
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunMessageBox
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageGroup, wC8CB
; points at: wMessageState
RunMessageBox_Case01::
Jump_05F_698D:: ; address name
    ld a, [wMessageGroup]
    bit 7, a
    jr nz, Jump_05F_699A
    ld a, [wC8CB]
    and a, $03
    ret nz

Jump_05F_699A::
    call ShowMessageFromWC924
    ld hl, wMessageState
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunMessageBox
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wMessageGroup, hPlayerY
; writes: wC8CB, wC8CC, hFFB9
; points at: wMessageState
RunMessageBox_Case02::
Jump_05F_69A2:: ; address name
    ld a, [wC52B]
    bit 0, a
    ret nz
    ld a, [wMessageGroup]
    bit 6, a
    jr nz, Jump_05F_69CD
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
    jr c, Jump_05F_69CD
    ld a, $82
    ld [wC8CB], a

Jump_05F_69CD::
    ld hl, wMessageState
    inc [hl]
    ret

; entry 3 of the `rst $00` table in RunMessageBox
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageGroup, wC8CB, wC928
; writes: wMessageState
RunMessageBox_Case03::
Jump_05F_69D2:: ; address name
    ld a, [wMessageGroup]
    bit 6, a
    jr nz, Jump_05F_69E1
    ld a, [wC8CB]
    and a, $03
    jr z, Jump_05F_69E1
    ret

Jump_05F_69E1::
    ld a, [wC928]
    or a, a
    jr nz, Jump_05F_69ED
    farcall ClearBit1OfPlayerAndObjectFlags

Jump_05F_69ED::
    ld a, $FF
    ld [wMessageState], a
    ret

; HL = wMessageIndex/wMessageGroup, then ShowMessageHL (E-0079)
; 1 call site from 1 routine (e.g. RunMessageBox_Case01)
; reads: wMessageIndex, wMessageGroup, wCC44
; writes: wStringIndex, wStringCategory
ShowMessageFromWC924::
Func_05F_69F3:: ; address name
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a

; L = string index (wStringIndex, category 0), H & $3F = message group, which selects one of 12 table entries (rst $00); when wCC44 has bit 7 set and is not $80 another path is taken (not read) (E-0079)
; 1 call site from 1 routine (e.g. ScriptCommand0A_Run_Case02)
; reads: wCC44
; writes: wStringIndex, wStringCategory
ShowMessageHL::
Func_05F_69FB:: ; address name
    ld a, [wCC44]
    cp a, $80
    jr z, Jump_05F_6A07
    bit 7, a
    jp nz, Jump_05F_6A85

Jump_05F_6A07::
    ld a, h
    and a, $3F
    ld h, a
    ld a, l
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    ld a, h
    rst $00
    dw ShowMessageHL_Case00
    dw ShowMessageHL_Case01
    dw ShowMessageHL_Case02
    dw ShowMessageHL_Case03
    dw ShowMessageHL_Case04
    dw ShowMessageHL_Case05
    dw ShowMessageHL_Case06
    dw ShowMessageHL_Case06
    dw ShowMessageHL_Case08
    dw ShowMessageHL_Case09
    dw ShowMessageHL_Case09
    dw ShowMessageHL_Case0B
    dw ShowMessageHL_Case0C
    dw ShowMessageHL_Case0D

; entry 0 of the `rst $00` table in ShowMessageHL
; no direct call (reached through a table, a jump or a vector)
ShowMessageHL_Case00::
Jump_05F_6A31:: ; address name
    farcall BeginStringDisplay_Bank28
    ret

; entry 1 of the `rst $00` table in ShowMessageHL
; no direct call (reached through a table, a jump or a vector)
ShowMessageHL_Case01::
Jump_05F_6A38:: ; address name
    farcall BeginStringDisplay_Bank29
    ret

; entry 2 of the `rst $00` table in ShowMessageHL
; no direct call (reached through a table, a jump or a vector)
ShowMessageHL_Case02::
Jump_05F_6A3F:: ; address name
    farcall BeginStringDisplay_Bank2A
    ret

; entry 3 of the `rst $00` table in ShowMessageHL
; no direct call (reached through a table, a jump or a vector)
ShowMessageHL_Case03::
Jump_05F_6A46:: ; address name
    farcall BeginStringDisplay_Bank2B
    ret

; entry 4 of the `rst $00` table in ShowMessageHL
; no direct call (reached through a table, a jump or a vector)
ShowMessageHL_Case04::
Jump_05F_6A4D:: ; address name
    farcall BeginStringDisplay_Bank2C
    ret

; entry 5 of the `rst $00` table in ShowMessageHL
; no direct call (reached through a table, a jump or a vector)
ShowMessageHL_Case05::
Jump_05F_6A54:: ; address name
    farcall BeginStringDisplay_Bank2D
    ret

; entry 6 of the `rst $00` table in ShowMessageHL
; no direct call (reached through a table, a jump or a vector)
ShowMessageHL_Case06::
Jump_05F_6A5B:: ; address name
    farcall BeginStringDisplay_Bank2E
    ret

; entry 8 of the `rst $00` table in ShowMessageHL
; no direct call (reached through a table, a jump or a vector)
ShowMessageHL_Case08::
Jump_05F_6A62:: ; address name
    farcall BeginStringDisplay_Bank7C
    ret

; entry 9 of the `rst $00` table in ShowMessageHL
; no direct call (reached through a table, a jump or a vector)
ShowMessageHL_Case09::
Jump_05F_6A69:: ; address name
    farcall BeginStringDisplay_Bank80
    ret

; entry 11 of the `rst $00` table in ShowMessageHL
; no direct call (reached through a table, a jump or a vector)
ShowMessageHL_Case0B::
Jump_05F_6A70:: ; address name
    farcall BeginStringDisplay_Bank82
    ret

; entry 12 of the `rst $00` table in ShowMessageHL
; no direct call (reached through a table, a jump or a vector)
ShowMessageHL_Case0C::
Jump_05F_6A77:: ; address name
    farcall BeginStringDisplay_Bank86
    ret

; entry 13 of the `rst $00` table in ShowMessageHL
; no direct call (reached through a table, a jump or a vector)
ShowMessageHL_Case0D::
Jump_05F_6A7E:: ; address name
    farcall BeginStringDisplay_Bank89
    ret

Jump_05F_6A85::
    ld a, l
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank28
    ret

; sets bit 2 of hFF8C (moving) and hPlayerFacing = 0; calls Func_05F_6B43 with the coordinate; then hPlayerY += 1; when it equals wC928 bit 2 is cleared and wC92C = 1, else wC92C = 0 (E-0071)
; 11 call sites from 9 routines (e.g. ScriptCommand5E_Run_Case23, ScriptCommand40_Run_Case06, ScriptCommand40_Run_Case04, ScriptCommand39_Run_Case21, ...)
; reads: hFF8C, hPlayerY, wC928
; writes: hFF8C, hPlayerFacing, hPlayerY, wStepArrived
StepPlayerDownTowardWC928::
Func_05F_6A94:: ; address name
    ldh a, [hFF8C]
    or a, $04
    ldh [hFF8C], a
    xor a, a
    ldh [hPlayerFacing], a
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank5F
    ld a, [wC928]
    ld c, a
    ldh a, [hPlayerY]
    inc a
    ldh [hPlayerY], a
    cp a, c
    jr z, Jump_05F_6AB3
    xor a, a
    ld [wStepArrived], a
    ret

Jump_05F_6AB3::
    ldh a, [hFF8C]
    and a, $FB
    ldh [hFF8C], a
    ld a, $01
    ld [wStepArrived], a
    ret

; sets bit 2 of hFF8C (moving) and hPlayerFacing = 1; calls Func_05F_6B43 with the coordinate; then hPlayerX += 1; when it equals wC928 bit 2 is cleared and wC92C = 1, else wC92C = 0 (E-0071)
; 7 call sites from 6 routines (e.g. ScriptCommand5E_Run_Case23, ScriptCommand49_Run_Case03, ScriptCommand39_Run_Case21, Func_00F_7E1E, ...)
; reads: hFF8C, hPlayerX, wC928
; writes: hFF8C, hPlayerFacing, hPlayerX, wStepArrived
StepPlayerRightTowardWC928::
Func_05F_6ABF:: ; address name
    ldh a, [hFF8C]
    or a, $04
    ldh [hFF8C], a
    ld a, $01
    ldh [hPlayerFacing], a
    ldh a, [hPlayerX]
    call UpdateFollowersOnStep_Bank5F
    ld a, [wC928]
    ld c, a
    ldh a, [hPlayerX]
    inc a
    ldh [hPlayerX], a
    cp a, c
    jr z, Jump_05F_6ADF
    xor a, a
    ld [wStepArrived], a
    ret

Jump_05F_6ADF::
    ldh a, [hFF8C]
    and a, $FB
    ldh [hFF8C], a
    ld a, $01
    ld [wStepArrived], a
    ret

; sets bit 2 of hFF8C (moving) and hPlayerFacing = 2; calls Func_05F_6B43 with the coordinate; then hPlayerY -= 1; when it equals wC928 bit 2 is cleared and wC92C = 1, else wC92C = 0 (E-0071)
; 15 call sites from 12 routines (e.g. ScriptCommand5E_Run_Case02, ScriptCommand49_Run_Case03, ScriptCommand49_Run_Case02, ScriptCommand49_Run_Case00, ...)
; reads: hFF8C, hPlayerY, wC928
; writes: hFF8C, hPlayerFacing, hPlayerY, wStepArrived
StepPlayerUpTowardWC928::
Func_05F_6AEB:: ; address name
    ldh a, [hFF8C]
    or a, $04
    ldh [hFF8C], a
    ld a, $02
    ldh [hPlayerFacing], a
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank5F
    ld a, [wC928]
    ld c, a
    ldh a, [hPlayerY]
    dec a
    ldh [hPlayerY], a
    cp a, c
    jr z, Jump_05F_6B0B
    xor a, a
    ld [wStepArrived], a
    ret

Jump_05F_6B0B::
    ldh a, [hFF8C]
    and a, $FB
    ldh [hFF8C], a
    ld a, $01
    ld [wStepArrived], a
    ret

; sets bit 2 of hFF8C (moving) and hPlayerFacing = 3; calls Func_05F_6B43 with the coordinate; then hPlayerX -= 1; when it equals wC928 bit 2 is cleared and wC92C = 1, else wC92C = 0 (E-0071)
; 16 call sites from 13 routines (e.g. ScriptCommand5F_Run_Case14, ScriptCommand5E_Run_Case02, ScriptCommand49_Run_Case02, ScriptCommand49_Run_Case00, ...)
; reads: hFF8C, hPlayerX, wC928
; writes: hFF8C, hPlayerFacing, hPlayerX, wStepArrived
StepPlayerLeftTowardWC928::
Func_05F_6B17:: ; address name
    ldh a, [hFF8C]
    or a, $04
    ldh [hFF8C], a
    ld a, $03
    ldh [hPlayerFacing], a
    ldh a, [hPlayerX]
    call UpdateFollowersOnStep_Bank5F
    ld a, [wC928]
    ld c, a
    ldh a, [hPlayerX]
    dec a
    ldh [hPlayerX], a
    cp a, c
    jr z, Jump_05F_6B37
    xor a, a
    ld [wStepArrived], a
    ret

Jump_05F_6B37::
    ldh a, [hFF8C]
    and a, $FB
    ldh [hFF8C], a
    ld a, $01
    ld [wStepArrived], a
    ret

; A = the player's moving coordinate: when A & $0F = 0 (a 16-pixel tile boundary) far-calls SetFollowerTargetsFromLeader; then always far-calls StepFollowersTowardTargets (E-0093) (the same 17 bytes appear in 3 banks)
; 5 call sites from 5 routines (e.g. StepPlayerLeftTowardWC928, StepPlayerRightTowardWC928, StepPlayerDownTowardWC928, StepPlayerUpTowardWC928, ...)
UpdateFollowersOnStep_Bank5F::
Func_05F_6B43:: ; address name
    and a, $0F
    jr nz, Jump_05F_6B4D
    farcall SetFollowerTargetsFromLeader

Jump_05F_6B4D::
    farcall StepFollowersTowardTargets
    ret

; wC929 = object number (16-byte entries): sets bit 2 of wCB8C + 16n, stores direction wC92A & 3 at wCB86 + 16n and moves the object one pixel, two when wC92A bit 7 is set: direction 0 adds the step to Y (wCB8B + 16n), 1 adds it to X (wCB8A + 16n), 2 subtracts it from Y, 3 from X. When the moved coordinate equals wC928 it clears bit 2 and sets wC92C = 1, else wC92C = 0 (E-0061)
; 145 call sites from 78 routines (e.g. ScriptCommandC7_Run_Case01, ScriptCommand5F_Run_Case17, Func_00F_4774, Func_00F_47F5, ...)
; reads: wC929, wC92A, wC928
; writes: wStepArrived
; points at: wCB8C
StepObjectTowardCoord::
Func_05F_6B54:: ; address name
    ld a, [wC929]
    swap a
    ld hl, wCB8C
    add_a_to_hl
    ld a, [hl]
    or a, $04
    ld [hl], a
    push hl
    push hl
    dec hl
    dec hl
    dec hl
    dec hl
    dec hl
    dec hl
    ld a, [wC92A]
    ld b, a
    and a, $03
    jr nz, Jump_05F_6B83
    ld [hl], $00
    pop hl
    dec hl
    ld a, [hl]
    inc a
    bit 7, b
    jr z, Jump_05F_6B80
    inc a

Jump_05F_6B80::
    ld [hl], a
    jr Jump_05F_6BB3

Jump_05F_6B83::
    dec a
    jr nz, Jump_05F_6B95
    ld [hl], $01
    pop hl
    dec hl
    dec hl
    ld a, [hl]
    inc a
    bit 7, b
    jr z, Jump_05F_6B92
    inc a

Jump_05F_6B92::
    ld [hl], a
    jr Jump_05F_6BB3

Jump_05F_6B95::
    dec a
    jr nz, Jump_05F_6BA6
    ld [hl], $02
    pop hl
    dec hl
    ld a, [hl]
    dec a
    bit 7, b
    jr z, Jump_05F_6BA3
    dec a

Jump_05F_6BA3::
    ld [hl], a
    jr Jump_05F_6BB3

Jump_05F_6BA6::
    ld [hl], $03
    pop hl
    dec hl
    dec hl
    ld a, [hl]
    dec a
    bit 7, b
    jr z, Jump_05F_6BB2
    dec a

Jump_05F_6BB2::
    ld [hl], a

Jump_05F_6BB3::
    push af
    ld a, [wC928]
    ld c, a
    pop af
    cp a, c
    jr z, Jump_05F_6BC2
    xor a, a
    ld [wStepArrived], a
    pop hl
    ret

Jump_05F_6BC2::
    pop hl
    ld a, [hl]
    and a, $FB
    ld [hl], a
    ld a, $01
    ld [wStepArrived], a
    ret

; the byte at the address in wC928/wC929 += the byte at Func_05F_6BE8 + wC921 / 2
; 66 call sites from 54 routines (e.g. Func_05F_7363_Case0F, Func_05F_7363_Case0D, Func_05F_7363_Case0B, Func_05F_7363_Case08, ...)
; reads: wC928, wC929, wScriptParam0
AddStepDeltaToPointedByte::
Func_05F_6BCD:: ; address name
    ld a, [wC928]
    ld e, a
    ld a, [wC929]
    ld d, a
    ld a, [wScriptParam0]
    srl a
    ld hl, Data_05F_6BE8
    add_a_to_hl
    ld a, [hl]
    ld c, a
    ld a, [de]
    add a, c
    ld [de], a
    ret

Data_05F_6BE8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FE, $FF, $FF, $00, $FF, $00, $FF, $00, $00, $01, $00, $01, $00, $01, $01, $02

; 20 call sites from 19 routines (e.g. ScriptCommand5E_Run_Case00, ScriptCommand4E_Run_Case04, ScriptCommand4A_Run_Case08, ScriptCommand66_Run_Case08, ...)
; reads: wScriptParam0, hFFC6, hFFC7
; writes: wScriptParam0, hFFC6
; points at: wCB8B
Func_05F_6BF8::
    ld a, [wScriptParam0]
    cp a, $1E
    jr nc, Jump_05F_6C05
    bit 3, a
    jr z, Jump_05F_6C15
    jr Jump_05F_6C26

Jump_05F_6C05::
    cp a, $3C
    jr nc, Jump_05F_6C0F
    bit 2, a
    jr z, Jump_05F_6C15
    jr Jump_05F_6C26

Jump_05F_6C0F::
    bit 1, a
    jr z, Jump_05F_6C15
    jr Jump_05F_6C26

Jump_05F_6C15::
    ldh a, [hFFC6]
    swap a
    ld hl, wCB8B
    add_a_to_hl
    ldh a, [hFFC7]
    ld [hl], a
    jr Jump_05F_6C34

Jump_05F_6C26::
    ldh a, [hFFC6]
    swap a
    ld hl, wCB8B
    add_a_to_hl
    ld [hl], $E0

Jump_05F_6C34::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $78
    jr z, Jump_05F_6C43
    xor a, a
    ldh [hFFC6], a
    ret

Jump_05F_6C43::
    ldh a, [hFFC6]
    swap a
    ld hl, wCB8B
    add_a_to_hl
    ld [hl], $E0
    xor a, a
    ld [wScriptParam0], a
    ld a, $01
    ldh [hFFC6], a
    ret

; StartPaletteFade with A = $0F, wModeState = 4, wC8C5 = 0, wScriptParam0 = 0, then wScriptStep += 1 (E-0061)
; 51 call sites from 48 routines (e.g. Func_00F_4FA1, ScriptCommand5E_Run_Case0B, ScriptCommand58_Run_Case1E, ScriptCommand4B_Run_Case11, ...)
; writes: wModeState, wC8C5, wScriptParam0
; points at: wScriptStep
ScriptStartFadeAndAdvanceStep::
Func_05F_6C5A:: ; address name
    ld a, $0F
    call StartPaletteFade
    ld a, $04
    ld [wModeState], a
    xor a, a
    ld [wC8C5], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; wModeState = 3, wC904 = 0, wC8C7 = 2, far-calls SaveScreenBufferToBGMap1, then Func_00A_476E (E-0078)
; 5 call sites from 5 routines (e.g. ScriptCommand9A_Run, ScriptCommand96_Run_Case04, ScriptCommand85_Run_Case01, ScriptCommand9E_Run_Case01, ...)
; writes: wModeState, wC904, wC8C7
SetModeState3AndSaveScreen::
Func_05F_6C71:: ; address name
    ld a, $03
    ld [wModeState], a
    xor a, a
    ld [wC904], a
    ld a, $02
    ld [wC8C7], a
    farcall SaveScreenBufferToBGMap1
    farcall Func_00A_476E
    ret

; stores wC928 in the first wInventory slot that is $00 or $FF (no bound check), then sets bit 6 of wC836; HL kept (E-0071)
; 17 call sites from 16 routines (e.g. ScriptCommand32_Run_Case00, ScriptCommand84_Run_Case08, ScriptCommand86_Run_Case02, ScriptCommand81_Run_Case02, ...)
; reads: wC928, wC836
; writes: wC836
; points at: wInventory
AppendItemWC928ToInventory::
Func_05F_6C8C:: ; address name
    push hl
    ld hl, wInventory

Jump_05F_6C90::
    ld a, [hl]
    or a, a
    jr z, Jump_05F_6C9B
    cp a, $FF
    jr z, Jump_05F_6C9B
    inc hl
    jr Jump_05F_6C90

Jump_05F_6C9B::
    ld a, [wC928]
    ld [hl], a
    pop hl
    ld a, [wC836]
    set 6, a
    ld [wC836], a
    ret

; 5 call sites from 4 routines (e.g. Func_004_58C2_Case13, Func_004_612B_Case18, Func_013_49D5_Case6F, Func_073_4FD2)
; reads: wC6FD, hFFC6
; writes: rRAMG, wStepArrived
; points at: wC6FE
Func_05F_6CA9::
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC6FD]
    or a, a
    jr z, Jump_05F_6CC8
    ld b, a
    ld hl, wC6FE

Jump_05F_6CB8::
    ld a, [hl]
    ld c, $55
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    bit 7, a
    jr nz, Jump_05F_6CD1
    inc hl
    dec b
    jr nz, Jump_05F_6CB8

Jump_05F_6CC8::
    xor a, a
    ld [wStepArrived], a
    xor a, a
    ld [rRAMG], a
    ret

Jump_05F_6CD1::
    ld a, $01
    ld [wStepArrived], a
    xor a, a
    ld [rRAMG], a
    ret

; 1 call site from 1 routine (e.g. Func_073_4FD2)
; reads: wC6FD, hFFC6
; writes: rRAMG, wStepArrived
; points at: wC6FE
Func_05F_6CDB::
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC6FD]
    or a, a
    jr z, Jump_05F_6CFA
    ld b, a
    ld hl, wC6FE

Jump_05F_6CEA::
    ld a, [hl]
    ld c, $55
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    bit 2, a
    jr nz, Jump_05F_6D03
    inc hl
    dec b
    jr nz, Jump_05F_6CEA

Jump_05F_6CFA::
    xor a, a
    ld [wStepArrived], a
    xor a, a
    ld [rRAMG], a
    ret

Jump_05F_6D03::
    ld a, $01
    ld [wStepArrived], a
    xor a, a
    ld [rRAMG], a
    ret

; 1 call site from 1 routine (e.g. Func_073_4FD2)
; reads: wC6FD, hFFC6
; writes: rRAMG, wStepArrived
; points at: wC6FE
Func_05F_6D0D::
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC6FD]
    or a, a
    jr z, Jump_05F_6D2C
    ld b, a
    ld hl, wC6FE

Jump_05F_6D1C::
    ld a, [hl]
    ld c, $55
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    bit 0, a
    jr nz, Jump_05F_6D35
    inc hl
    dec b
    jr nz, Jump_05F_6D1C

Jump_05F_6D2C::
    xor a, a
    ld [wStepArrived], a
    xor a, a
    ld [rRAMG], a
    ret

Jump_05F_6D35::
    ld a, $01
    ld [wStepArrived], a
    xor a, a
    ld [rRAMG], a
    ret

; 3 call sites from 3 routines (e.g. ScriptCommand3D_Run_Case03, ScriptCommand3C_Run_Case0D, ScriptCommand3A_Run_Case0A)
; reads: hFF8D, hFFC6
; writes: hFF8D, wD7F1, wD7F2, wC527
; points at: wC6FE
Func_05F_6D3F::
    farcall Func_012_7D95
    ldh a, [hFF8D]
    or a, $0E
    ldh [hFF8D], a
    ldh a, [hFFC6]
    ld hl, wC6FE
    add_a_to_hl
    ld a, [hl]
    ld [wD7F1], a
    xor a, a
    ld [wD7F2], a
    farcall Func_014_7E96
    call LoadRecordListNameTiles
    farcall Func_004_4AA8
    ld a, $7F
    ld [wC527], a
    ldh a, [hFF8D]
    and a, $F1
    ldh [hFF8D], a
    ret

; 7 call sites from 7 routines (e.g. Msg01F0_Case33, Msg01F0_Case42, Talk08D1_TheEvaluatorSaidI, ScriptCommand2A_Run_Case02, ...)
; reads: wD7F5, wC7C7
; writes: wD7F1, wD7F2, wD7F5
Func_05F_6D78::
    ld a, $FF
    ld [wD7F1], a
    ld a, $01
    ld [wD7F2], a
    farcall Func_014_7E96
    ld a, [wD7F5]
    cp a, $FF
    ret z
    ld a, [wC7C7]
    and a, $03
    ld hl, Data_05F_6DA8
    add_a_to_hl
    ld a, [hl]
    ld c, a
    ld a, [wD7F5]
    cp a, c
    ret c
    ld a, $FF
    ld [wD7F5], a
    ret

Data_05F_6DA8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0A, $14, $1E, $1E

; 10 call sites from 8 routines (e.g. Talk075F_KiralFetchMeMy, ScriptCommand58_Run_Case2B, ScriptCommand4B_Run_Case16, ScriptCommand39_Run_Case31, ...)
; reads: hFFC6
; points at: wKeyList
Func_05F_6DAC::
    ldh a, [hFFC6]
    ld c, a
    ld hl, wKeyList

Jump_05F_6DB2::
    push hl
    ld a, [hl]
    cp a, $FE
    jr z, Jump_05F_6DCF
    cp a, $FF
    jr nz, Jump_05F_6DBE
    pop hl
    ret

Jump_05F_6DBE::
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    bit 7, a
    jr z, Jump_05F_6DCF
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    and a, $3F
    cp a, c
    jr z, Jump_05F_6DD6

Jump_05F_6DCF::
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    jr Jump_05F_6DB2

Jump_05F_6DD6::
    set 6, a
    ld [hl], a
    pop hl
    ret

; HL = the BG map entry at the scroll origin ((hScrollY & $F8) * 4 + $9800, rows wrapped by & $9B, + hScrollX / 8), then DrawFullScreenBufferToBGMap (E-0093)
; 23 call sites from 23 routines (e.g. ScriptCommand5F_Run_Case29, ScriptCommand5E_Run_Case02, ScriptCommand43_Run_Case0A, ScriptCommand42_Run_Case08, ...)
; reads: hScrollY, hScrollX
DrawFullScreenBufferAtScroll::
Func_05F_6DDB:: ; address name
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
    jr nc, Jump_05F_6E03
    inc d

Jump_05F_6E03::
    ld l, e
    ld h, d
    call DrawFullScreenBufferToBGMap
    ret

; 9 call sites from 9 routines (e.g. ScriptCommand5E_Run_Case0D, ScriptCommand58_Run_Case00, ScriptCommand41_Run_Case00, ScriptCommand43_Run_Case00, ...)
; reads: hScrollY, hScrollX
Func_05F_6E09::
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
    push de
    ldh a, [hScrollX]
    sub a, $08
    call Func_05F_6E35
    pop de
    ldh a, [hScrollX]
    add a, $A0
    call Func_05F_6E35
    ret

; 2 call sites from 1 routine (e.g. Func_05F_6E09)
Func_05F_6E35::
    srl a
    srl a
    srl a
    add a, e
    ld e, a
    jr nc, Jump_05F_6E40
    inc d

Jump_05F_6E40::
    ld l, e
    ld h, d
    ld b, $12

Jump_05F_6E44::
    ld a, $C4
    call WriteVRAMByte
    ld a, $20
    add_a_to_hl
    ld a, h
    and a, $9B
    ld h, a
    dec b
    jr nz, Jump_05F_6E44
    ret

; only called from ScriptCommand2C_Run_Case06 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommand2C_Run_Case06)
; reads: wC92D
ScriptCommand2C_Run_Case06_Sub01::
Func_05F_6E58:: ; address name
    ld a, [wC92D]
    rst $00
    dw Func_05F_6E58_Case00
    dw Func_05F_6E58_Case00
    dw Func_05F_6E58_Case02
    dw Func_05F_6E58_Case00
    dw Func_05F_6E58_Case00
    dw Func_05F_6E58_Case05
    dw Func_05F_6E58_Case00
    dw Func_05F_6E58_Case00
    dw Func_05F_6E58_Case08
    dw Func_05F_6E58_Case00
    dw Func_05F_6E58_Case00
    dw Func_05F_6E58_Case0B
    dw Func_05F_6E58_Case0C
    dw Func_05F_6E58_Case00
    dw Func_05F_6E58_Case00
    dw Func_05F_6E58_Case00
    dw Func_05F_6E58_Case10

; entry 11 of the `rst $00` table in Func_05F_6E58
; no direct call (reached through a table, a jump or a vector)
; writes: hPlayerFacing, wFollowerRecords, wC8F4, wC8F9
; points at: wC92D
Func_05F_6E58_Case0B::
Jump_05F_6E7E:: ; address name
    xor a, a
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld [wC8F4], a
    ld [wC8F9], a
    ld hl, wC92D
    inc [hl]
    ret

; entry 8 of the `rst $00` table in Func_05F_6E58
; no direct call (reached through a table, a jump or a vector)
; reads: hFF8C, wScriptParam0
; writes: hPlayerFacing, wFollowerRecords, wC8F4, wC8F9, hFF8C, wScriptParam0
; points at: wC92D
Func_05F_6E58_Case08::
Jump_05F_6E8F:: ; address name
    ld a, $02
    jr Jump_05F_6E99

; entry 5 of the `rst $00` table in Func_05F_6E58
; no direct call (reached through a table, a jump or a vector)
; reads: hFF8C, wScriptParam0
; writes: hPlayerFacing, wFollowerRecords, wC8F4, wC8F9, hFF8C, wScriptParam0
; points at: wC92D
Func_05F_6E58_Case05::
Jump_05F_6E93:: ; address name
    ld a, $01
    jr Jump_05F_6E99

; entry 2 of the `rst $00` table in Func_05F_6E58
; no direct call (reached through a table, a jump or a vector)
; reads: hFF8C, wScriptParam0
; writes: hPlayerFacing, wFollowerRecords, wC8F4, wC8F9, hFF8C, wScriptParam0
; points at: wC92D
Func_05F_6E58_Case02::
Jump_05F_6E97:: ; address name
    ld a, $03

Jump_05F_6E99::
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld [wC8F4], a
    ld [wC8F9], a
    ldh a, [hFF8C]
    and a, $FD
    ldh [hFF8C], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $40
    ret nz
    ldh a, [hFF8C]
    or a, $02
    ldh [hFF8C], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wC92D
    inc [hl]
    ret

; only called from ScriptCommand2D_Run_Case05 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommand2D_Run_Case05)
; reads: wC92D
ScriptCommand2D_Run_Case05_Sub01::
Func_05F_6EC3:: ; address name
    ld a, [wC92D]
    rst $00
    dw Func_05F_6E58_Case00
    dw Func_05F_6E58_Case00
    dw Func_05F_6EC3_Case02
    dw Func_05F_6EC3_Case03
    dw Func_05F_6EC3_Case04
    dw Func_05F_6E58_Case00
    dw Func_05F_6E58_Case00
    dw Func_05F_6EC3_Case07
    dw Func_05F_6E58_Case00
    dw Func_05F_6E58_Case0C
    dw Func_05F_6EC3_Case07
    dw Func_05F_6E58_Case00
    dw Func_05F_6E58_Case00
    dw Func_05F_6E58_Case10

; entry 16 of the `rst $00` table in Func_05F_6E58
; no direct call (reached through a table, a jump or a vector)
; reads: hFF8C
; writes: hFF8C
; points at: wScriptStep
Func_05F_6E58_Case10::
Jump_05F_6EE3:: ; address name
    ldh a, [hFF8C]
    and a, $FD
    ldh [hFF8C], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 12 of the `rst $00` table in Func_05F_6E58
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wC928, wC929, wScriptParam0
; points at: hPlayerY, wC8F1, wC8F6, wC8FB, wC92D
Func_05F_6E58_Case0C::
Jump_05F_6EEE:: ; address name
    ld de, hPlayerY
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld de, wC8F1
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld de, wC8F6
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld de, wC8FB
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
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wC92D
    inc [hl]
    ret

; entry 7 of the `rst $00` table in Func_05F_6EC3
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, hPlayerFacing
; writes: wScriptParam0, hPlayerFacing, wFollowerRecords, wC8F4, wC8F9
; points at: wC92D
Func_05F_6EC3_Case07::
Jump_05F_6F46:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and a, $03
    ret nz
    ldh a, [hPlayerFacing]
    inc a
    and a, $03
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld [wC8F4], a
    ld [wC8F9], a
    or a, a
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wC92D
    inc [hl]
    ret

; entry 4 of the `rst $00` table in Func_05F_6EC3
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, hPlayerFacing, wC8FA, wC8F5, wC8FB, wC8F6, hFF8C
; writes: hPlayerFacing, wFollowerRecords, wC8FA, wC8F5, wC8FB, wC8F6, wScriptParam0, hFF8C
; points at: wC8F0, hPlayerX, wC92D, wScriptParam0
Func_05F_6EC3_Case04::
Jump_05F_6F6B:: ; address name
    ld a, [wScriptParam0]
    and a, $07
    jr nz, Jump_05F_6F8C
    ldh a, [hPlayerFacing]
    dec a
    and a, $03
    ldh [hPlayerFacing], a
    bit 0, a
    jr z, Jump_05F_6F81
    inc a
    inc a
    and a, $03

Jump_05F_6F81::
    ld [wFollowerRecords], a
    ld hl, wC8F0
    dec [hl]
    ld hl, hPlayerX
    inc [hl]

Jump_05F_6F8C::
    ld a, [wScriptParam0]
    and a, $03
    jr nz, Jump_05F_6FDC
    ld a, [wScriptParam0]
    srl a
    srl a
    ld c, a
    ld a, $1F
    sub a, c
    sla a
    ld hl, Data_05F_7092
    add_a_to_hl
    ld a, [hl+]
    ld c, a
    ld a, [wC8FA]
    add a, c
    ld [wC8FA], a
    ld a, [wC8F5]
    sub a, c
    ld [wC8F5], a
    ld a, [hl]
    ld c, a
    ld a, [wC8FB]
    add a, c
    ld [wC8FB], a
    ld a, [wC8F6]
    sub a, c
    ld [wC8F6], a
    ld a, [wScriptParam0]
    srl a
    srl a
    cp a, $1F
    jr nz, Jump_05F_6FDC
    xor a, a
    ld [wScriptParam0], a
    ld hl, wC92D
    inc [hl]
    ret

Jump_05F_6FDC::
    ldh a, [hFF8C]
    or a, $02
    ldh [hFF8C], a
    ld hl, wScriptParam0
    inc [hl]
    ret

; entry 3 of the `rst $00` table in Func_05F_6EC3
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wC928, wC929, wScriptParam0
; points at: wC8F6, wC8FB, wC92D
Func_05F_6EC3_Case03::
Jump_05F_6FE7:: ; address name
    ld de, wC8F6
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld de, wC8FB
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte

; entry 0 of the `rst $00` table in Func_05F_6E58
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wScriptParam0
; points at: wC92D
Func_05F_6E58_Case00::
Jump_05F_7009:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wC92D
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_05F_6EC3
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, hPlayerFacing
; writes: hPlayerFacing, wFollowerRecords
; points at: wC8F0, hPlayerX
Func_05F_6EC3_Case02::
Jump_05F_701C:: ; address name
    ld a, [wScriptParam0]
    and a, $07
    jr nz, Jump_05F_703D
    ldh a, [hPlayerFacing]
    inc a
    and a, $03
    ldh [hPlayerFacing], a
    bit 0, a
    jr z, Jump_05F_7032
    inc a
    inc a
    and a, $03

Jump_05F_7032::
    ld [wFollowerRecords], a
    ld hl, wC8F0
    inc [hl]
    ld hl, hPlayerX
    dec [hl]

Jump_05F_703D::
    ld hl, Data_05F_7092
    call Func_05F_7044
    ret

; 1 call site from 1 routine (e.g. Func_05F_6EC3_Case02)
; reads: wScriptParam0, wC8F5, wC8FA, wC8F6, wC8FB
; writes: wC8F5, wC8FA, wC8F6, wC8FB, wScriptParam0
; points at: wC92D, wScriptParam0
Func_05F_7044::
    ld a, [wScriptParam0]
    and a, $03
    jr nz, Jump_05F_708D
    ld a, [wScriptParam0]
    srl a
    srl a
    sla a
    add_a_to_hl
    ld a, [hl+]
    ld c, a
    ld a, [wC8F5]
    add a, c
    ld [wC8F5], a
    ld a, [wC8FA]
    sub a, c
    ld [wC8FA], a
    ld a, [hl]
    ld c, a
    ld a, [wC8F6]
    add a, c
    ld [wC8F6], a
    ld a, [wC8FB]
    sub a, c
    ld [wC8FB], a
    ld a, [wScriptParam0]
    srl a
    srl a
    cp a, $1F
    jr nz, Jump_05F_708D
    xor a, a
    ld [wScriptParam0], a
    ld hl, wC92D
    inc [hl]
    ret

Jump_05F_708D::
    ld hl, wScriptParam0
    inc [hl]
    ret

Data_05F_7092:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FE, $00, $FF, $00, $FE, $FF, $FF, $FF, $FF, $FF, $FF, $FE, $00, $FF, $00, $FE
    db $00, $FE, $00, $FF, $01, $FE, $01, $FF, $01, $FF, $02, $FF, $01, $00, $02, $00
    db $02, $00, $01, $00, $02, $01, $01, $01, $01, $01, $01, $02, $00, $01, $00, $02
    db $00, $02, $00, $01, $FF, $02, $FF, $01, $FF, $01, $FE, $01, $FF, $00, $FE, $00

; 2 call sites from 2 routines (e.g. ScriptCommand46_Run_Case0F, ScriptCommand1F_Run_Case07)
; reads: wC92D
Func_05F_70D2::
    ld a, [wC92D]
    rst $00
    dw Func_05F_70D2_Case00
    dw Func_05F_70D2_Case01
    dw Func_05F_70D2_Case02
    dw Func_05F_70D2_Case03
    dw Func_05F_70D2_Case04
    dw Func_05F_70D2_Case05
    dw Func_05F_70D2_Case06
    dw Func_05F_70D2_Case07

; entry 7 of the `rst $00` table in Func_05F_70D2
; no direct call (reached through a table, a jump or a vector)
; reads: wC8F0, wScriptParam0, wC8F6, wC8FA, hPlayerX, hFF8C
; writes: wFollowerRecords, wC8F0, wC8F4, wC8F6, wC8F9, wC8FA, hPlayerFacing, hFF8C, ...
; points at: wScriptParam0, wScriptStep
Func_05F_70D2_Case07::
Jump_05F_70E6:: ; address name
    ld a, $01
    ld [wFollowerRecords], a
    ld a, [wC8F0]
    inc a
    ld [wC8F0], a
    ld a, [wScriptParam0]
    and a, $01
    jr nz, Jump_05F_7105
    ld a, $02
    ld [wC8F4], a
    ld a, [wC8F6]
    dec a
    ld [wC8F6], a

Jump_05F_7105::
    ld hl, wScriptParam0
    inc [hl]
    ld a, $03
    ld [wC8F9], a
    ld a, [wC8FA]
    dec a
    ld [wC8FA], a
    ldh a, [hPlayerX]
    ld c, a
    ld a, [wC8FA]
    cp a, c
    ret nz
    xor a, a
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld [wC8F4], a
    ld [wC8F9], a
    ldh a, [hFF8C]
    and a, $FB
    ldh [hFF8C], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in Func_05F_70D2
; no direct call (reached through a table, a jump or a vector)
; reads: wCBD4, wScriptParam0, hFF8C
; writes: wC928, wC929, wCBD4, wScriptParam0, wCBCF, hFF8C, hPlayerFacing
; points at: wCBD4, wC92D
Func_05F_70D2_Case06::
Jump_05F_7138:: ; address name
    ld de, wCBD4
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld a, [wCBD4]
    inc a
    ld [wCBD4], a
    ld a, [wScriptParam0]
    inc a
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    xor a, a
    ld [wCBCF], a
    ldh a, [hFF8C]
    and a, $FD
    ldh [hFF8C], a
    ld a, $02
    ldh [hPlayerFacing], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wC92D
    inc [hl]
    ret

; entry 5 of the `rst $00` table in Func_05F_70D2
; no direct call (reached through a table, a jump or a vector)
; reads: hFF8C, wScriptParam0
; writes: hFF8C, wFollowerRecords, wC8F4, wC8F9, wScriptParam0
; points at: wC92D
Func_05F_70D2_Case05::
Jump_05F_7172:: ; address name
    ldh a, [hFF8C]
    or a, $02
    ldh [hFF8C], a
    xor a, a
    ld [wFollowerRecords], a
    ld [wC8F4], a
    ld [wC8F9], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $3C
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wC92D
    inc [hl]
    ret

; entry 4 of the `rst $00` table in Func_05F_70D2
; no direct call (reached through a table, a jump or a vector)
; reads: wC931, wC932, hPlayerY, wFrameCounterLo, hPlayerX
; writes: wC931, wC932, wScriptParam0
; points at: wC92D, wFollowerRecords, wC92E
Func_05F_70D2_Case04::
Jump_05F_7195:: ; address name
    ld a, [wC931]
    ld l, a
    ld a, [wC932]
    ld h, a
    dec hl
    ld a, l
    ld [wC931], a
    ld a, h
    ld [wC932], a
    ld a, l
    or a, h
    jr nz, Jump_05F_71B2
    xor a, a
    ld [wScriptParam0], a
    ld hl, wC92D
    inc [hl]

Jump_05F_71B2::
    ld b, $03
    ld hl, wFollowerRecords
    ld de, wC92E

Jump_05F_71BA::
    push hl
    push de
    ld a, [de]
    or a, a
    jr nz, Jump_05F_71D4
    xor a, a
    ld [hl], a
    inc hl
    inc hl
    ld a, [hl]
    inc a
    ld [hl], a
    ld c, a
    ldh a, [hPlayerY]
    add a, $10
    cp a, c
    jr nz, Jump_05F_7231
    ld a, $01
    ld [de], a
    jr Jump_05F_7231

Jump_05F_71D4::
    dec a
    jr nz, Jump_05F_71F4
    ld a, [wFrameCounterLo]
    srl a
    srl a
    srl a
    and a, $03
    ld [hl], a
    inc hl
    ld a, [hl]
    inc a
    ld [hl], a
    ld c, a
    ldh a, [hPlayerX]
    add a, $20
    cp a, c
    jr nz, Jump_05F_7231
    ld a, $02
    ld [de], a
    jr Jump_05F_7231

Jump_05F_71F4::
    dec a
    jr nz, Jump_05F_720A
    ld a, $02
    ld [hl], a
    inc hl
    inc hl
    ld a, [hl]
    dec a
    ld [hl], a
    ld c, a
    ldh a, [hPlayerY]
    cp a, c
    jr nz, Jump_05F_7231
    ld a, $03
    ld [de], a
    jr Jump_05F_7231

Jump_05F_720A::
    ld a, $03
    ld [hl], a
    inc hl
    ld a, [hl]
    dec a
    ld [hl], a
    ld c, a
    ldh a, [hPlayerX]
    sub a, $20
    cp a, c
    jr nz, Jump_05F_721B
    xor a, a
    ld [de], a

Jump_05F_721B::
    ldh a, [hPlayerX]
    sub a, $20
    ld c, a
    ld a, [hl]
    sub a, c
    ld de, Data_05F_7240
    add a, e
    ld e, a
    jr nc, Jump_05F_722A
    inc d

Jump_05F_722A::
    ld a, [de]
    ld c, a
    ldh a, [hPlayerY]
    sub a, c
    inc hl
    ld [hl], a

Jump_05F_7231::
    pop de
    inc de
    pop hl
    ld a, $05
    add_a_to_hl
    dec b
    jp nz, Jump_05F_71BA
    ret

Data_05F_7240:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $11, $00
    db $01, $05, $08, $0A, $0C, $0D, $0E, $0E, $0F, $0F, $10, $10, $10, $11, $11, $11
    db $11, $10, $10, $10, $0F, $0F, $0E, $0E, $0D, $0C, $0A, $08, $05, $01
    ds $11, $00

; entry 3 of the `rst $00` table in Func_05F_70D2
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, hFF8C
; writes: wScriptParam0, hFF8C, wC92E, wC92F, wC930, wC931, wC932
; points at: wC92D
Func_05F_70D2_Case03::
Jump_05F_7280:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $78
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ldh a, [hFF8C]
    or a, $04
    ldh [hFF8C], a
    ld a, $00
    ld [wC92E], a
    ld a, $01
    ld [wC92F], a
    ld a, $03
    ld [wC930], a
    ld hl, $0320
    ld a, l
    ld [wC931], a
    ld a, h
    ld [wC932], a
    ld hl, wC92D
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_05F_70D2
; no direct call (reached through a table, a jump or a vector)
; reads: wCBD4, wScriptParam0
; writes: wCBCF, wC928, wC929, wCBD4, wScriptParam0
; points at: wCBD4, wC92D
Func_05F_70D2_Case02::
Jump_05F_72B3:: ; address name
    ld a, $80
    ld [wCBCF], a
    ld de, wCBD4
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld a, [wCBD4]
    dec a
    ld [wCBD4], a
    ld a, [wScriptParam0]
    inc a
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wC92D
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_05F_70D2
; no direct call (reached through a table, a jump or a vector)
; reads: wC8F0, wScriptParam0, wC8F6, wC8FA, hPlayerX, hFF8C
; writes: wFollowerRecords, wC8F0, wC8F4, wC8F6, wC8F9, wC8FA, hPlayerFacing, hFFC6, ...
; points at: wScriptParam0, wC92D
Func_05F_70D2_Case01::
Jump_05F_72E4:: ; address name
    ld a, $03
    ld [wFollowerRecords], a
    ld a, [wC8F0]
    dec a
    ld [wC8F0], a
    ld a, [wScriptParam0]
    and a, $01
    jr nz, Jump_05F_7303
    ld a, $00
    ld [wC8F4], a
    ld a, [wC8F6]
    inc a
    ld [wC8F6], a

Jump_05F_7303::
    ld hl, wScriptParam0
    inc [hl]
    ld a, $01
    ld [wC8F9], a
    ld a, [wC8FA]
    inc a
    ld [wC8FA], a
    ldh a, [hPlayerX]
    ld c, a
    ld a, [wC8FA]
    sub a, c
    cp a, $20
    ret nz
    xor a, a
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    inc a
    ld [wC8F4], a
    ld a, $03
    ld [wC8F9], a
    ld a, $0B
    ldh [hFFC6], a
    farcall Func_012_6B98
    ldh a, [hFF8C]
    or a, $02
    ldh [hFF8C], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wC92D
    inc [hl]
    ret

; entry 0 of the `rst $00` table in Func_05F_70D2
; no direct call (reached through a table, a jump or a vector)
; reads: hFF8C, hPlayerX, wScriptParam0
; writes: hFF8C, wScriptParam0
; points at: wC92D
Func_05F_70D2_Case00::
Jump_05F_7345:: ; address name
    ldh a, [hFF8C]
    or a, $04
    ldh [hFF8C], a
    ldh a, [hPlayerX]
    call UpdateFollowersOnStep_Bank5F
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $3C
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wC92D
    inc [hl]
    ret

; 4 call sites from 4 routines (e.g. ScriptCommand5E_Run_Case0C, ScriptCommand4B_Run_Case12, ScriptCommand39_Run_Case2D, ScriptCommand27_Run_Case1F)
; reads: wC92D
Func_05F_7363::
    ld a, [wC92D]
    rst $00
    dw Func_05F_7363_Case00
    dw Func_05F_7363_Case01
    dw Func_05F_7363_Case02
    dw Func_05F_7363_Case03
    dw Func_05F_7363_Case04
    dw Func_05F_7363_Case05
    dw Func_05F_7363_Case06
    dw Func_05F_7363_Case07
    dw Func_05F_7363_Case08
    dw Func_05F_7363_Case09
    dw Func_05F_7363_Case0A
    dw Func_05F_7363_Case0B
    dw Func_05F_7363_Case0C
    dw Func_05F_7363_Case0D
    dw Func_05F_7363_Case0E
    dw Func_05F_7363_Case0F
    dw Func_05F_7363_Case09
    dw Func_05F_7363_Case11

; entry 17 of the `rst $00` table in Func_05F_7363
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
Func_05F_7363_Case11::
Jump_05F_738B:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC552
; points at: wC92D
Func_05F_7390:: ; heuristic: follows a terminator; C0
    ld a, [wC552]
    or a, a
    jr nz, Jump_05F_739E
    ld a, $06
    ld hl, wC92D
    inc [hl]
    jr Jump_05F_73A4

Jump_05F_739E::
    ld a, $07
    ld hl, wC92D
    dec [hl]

Jump_05F_73A4::
    call Func_05F_7761
    ret

; no direct call (reached through a table, a jump or a vector)
; points at: wC92D
Func_05F_73A8:: ; heuristic: follows a terminator; C0
    ld a, $05
    call Func_05F_7761
    ld hl, wC92D
    inc [hl]
    ret

; entry 15 of the `rst $00` table in Func_05F_7363
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wCB86, wC933
; writes: wC928, wC929, wCB86, wScriptParam0, hFFC6, wCB81, wC6FD
; points at: wCB8B, wCB8A, wC92D
Func_05F_7363_Case0F::
Jump_05F_73B2:: ; address name
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_05F_73BD
    ld a, $65
    call QueueSoundEffect

Jump_05F_73BD::
    ld de, wCB8B
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    call AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    and a, $01
    jr nz, Jump_05F_73D6
    ld hl, wCB8A
    inc [hl]

Jump_05F_73D6::
    ld a, [wScriptParam0]
    and a, $01
    jr nz, Jump_05F_73E6
    ld a, [wCB86]
    inc a
    and a, $03
    ld [wCB86], a

Jump_05F_73E6::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    jr z, Jump_05F_7402
    farcall Func_012_6B22
    ld a, $01
    ldh [hFFC6], a
    farcall Func_012_6B33
    ret

Jump_05F_7402::
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
    ld a, $04
    call Func_05F_7761
    ld a, [wC933]
    ld [wC6FD], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wC92D
    inc [hl]
    ret

; entry 14 of the `rst $00` table in Func_05F_7363
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0
; points at: wC92D
Func_05F_7363_Case0E::
Jump_05F_742F:: ; address name
    xor a, a
    call RunMessageBoxCarryWhenIdle_Bank5F
    ret nc
    xor a, a
    ld [wScriptParam0], a
    ld hl, wC92D
    inc [hl]
    ret

; entry 13 of the `rst $00` table in Func_05F_7363
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: hFFC6, wC928, wC929, wScriptParam0
; points at: wCB8B, wC92D
Func_05F_7363_Case0D::
Jump_05F_743D:: ; address name
    farcall Func_012_6B22
    ld a, $01
    ldh [hFFC6], a
    farcall Func_012_6B33
    ld de, wCB8B
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    call AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    ld a, $03
    call Func_05F_7761
    ld hl, wC92D
    inc [hl]
    ret

; entry 12 of the `rst $00` table in Func_05F_7363
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1, wScriptParam0
; writes: hFFC6, wScriptParam1, wScriptParam0, wCBCF, wCBD4
; points at: wC92D
Func_05F_7363_Case0C::
Jump_05F_746F:: ; address name
    farcall Func_012_6B22
    ld a, $01
    ldh [hFFC6], a
    farcall Func_012_6B33
    ld a, [wScriptParam1]
    add a, $01
    ld [wScriptParam1], a
    sra a
    sra a
    sra a
    sra a
    ld c, a
    ld a, [wScriptParam0]
    add a, c
    ld [wScriptParam0], a
    cp a, $18
    jr c, Jump_05F_74A5
    xor a, a
    ld [wScriptParam0], a
    xor a, a
    ld [wCBCF], a
    jr Jump_05F_74AA

Jump_05F_74A5::
    ld a, $80
    ld [wCBCF], a

Jump_05F_74AA::
    ld a, [wScriptParam1]
    sra a
    sra a
    sra a
    sra a
    cp a, $30
    ret c
    xor a, a
    ld [wCBCF], a
    ld a, $30
    ld [wCBD4], a
    xor a, a
    ld [wScriptParam0], a
    ld [wScriptParam1], a
    ld hl, wC92D
    inc [hl]
    ret

; entry 11 of the `rst $00` table in Func_05F_7363
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: hFFC6, wC928, wC929, wScriptParam0, wScriptParam1
; points at: wCBD4, wC92D
Func_05F_7363_Case0B::
Jump_05F_74CD:: ; address name
    farcall Func_012_6B22
    ld a, $01
    ldh [hFFC6], a
    farcall Func_012_6B33
    ld de, wCBD4
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    call AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    bit 0, a
    jr nz, Jump_05F_74F6
    ld hl, wCBD4
    inc [hl]

Jump_05F_74F6::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld [wScriptParam1], a
    ld hl, wC92D
    inc [hl]
    ret

; entry 10 of the `rst $00` table in Func_05F_7363
; no direct call (reached through a table, a jump or a vector)
; reads: wC5E7, wScriptParam0
; writes: wCBD3, wScriptParam0
; points at: wC92D
Func_05F_7363_Case0A::
Jump_05F_750C:: ; address name
    call NextTableByte
    ld a, [wC5E7]
    and a, $03
    jr z, Func_05F_7363_Case0A
    dec a
    dec a
    add a, $40
    ld [wCBD3], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $B4
    ret nz
    ld a, $40
    ld [wCBD3], a
    ld a, $72
    call QueueSoundEffect
    xor a, a
    ld [wScriptParam0], a
    ld hl, wC92D
    inc [hl]
    ret

; entry 9 of the `rst $00` table in Func_05F_7363
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wC92D
; points at: wC92D
Func_05F_7363_Case09::
Jump_05F_753A:: ; address name
    xor a, a
    call RunMessageBoxCarryWhenIdle_Bank5F
    ret nc
    xor a, a
    ld [wScriptParam0], a
    ld hl, wC92D
    inc [hl]
    ld de, $00D1
    call TestFlagBit
    ret nc
    ld a, $11
    ld [wC92D], a
    ret

; entry 8 of the `rst $00` table in Func_05F_7363
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: hFFC6, wC928, wC929, wScriptParam0
; points at: wCBD4, wCBD3, wC92D
Func_05F_7363_Case08::
Jump_05F_7554:: ; address name
    farcall Func_012_6B22
    ld a, $01
    ldh [hFFC6], a
    farcall Func_012_6B33
    ld de, wCBD4
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    call AddStepDeltaToPointedByte
    ld hl, wCBD3
    dec [hl]
    ld hl, wCBD4
    inc [hl]
    ld a, [wScriptParam0]
    inc a
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    ld a, $02
    call Func_05F_7761
    xor a, a
    ld [wScriptParam0], a
    ld hl, wC92D
    inc [hl]
    ret

; entry 7 of the `rst $00` table in Func_05F_7363
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wCB8A
; writes: hFFC6, wC928, wC929, wScriptParam0, wCB8A
; points at: wCB8B, wC92D
Func_05F_7363_Case07::
Jump_05F_7593:: ; address name
    farcall Func_012_6B22
    ld a, $01
    ldh [hFFC6], a
    farcall Func_012_6B33
    ld de, wCB8B
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    call AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and a, $01
    jr nz, Jump_05F_75C3
    ld a, [wCB8A]
    dec a
    ld [wCB8A], a

Jump_05F_75C3::
    ld a, [wScriptParam0]
    cp a, $20
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wC92D
    inc [hl]
    ret

; entry 6 of the `rst $00` table in Func_05F_7363
; no direct call (reached through a table, a jump or a vector)
; writes: wCB81
; points at: wC92D
Func_05F_7363_Case06::
Jump_05F_75D2:: ; address name
    xor a, a
    call RunMessageBoxCarryWhenIdle_Bank5F
    ret nc
    ld de, Data_07D_41E1
    ld b, $7D
    ld hl, vTiles0 + $500
    call DecompressToVRAM
    ld a, $02
    ld [wCB81], a
    ld hl, wC92D
    inc [hl]
    ret

; entry 5 of the `rst $00` table in Func_05F_7363
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wC928, wC929, wScriptParam0
; points at: wCBD4, wC92D
Func_05F_7363_Case05::
Jump_05F_75EC:: ; address name
    ld de, wCBD4
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    call AddStepDeltaToPointedByte
    ld hl, wCBD4
    dec [hl]
    ld a, [wScriptParam0]
    inc a
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    ld a, $01
    call Func_05F_7761
    xor a, a
    ld [wScriptParam0], a
    ld hl, wC92D
    inc [hl]
    ret

; entry 4 of the `rst $00` table in Func_05F_7363
; no direct call (reached through a table, a jump or a vector)
; reads: wC6FD
; writes: wCBCF, wC933, wC6FD
; points at: wC92D
Func_05F_7363_Case04::
Jump_05F_7617:: ; address name
    xor a, a
    call RunMessageBoxCarryWhenIdle_Bank5F
    ret nc
    ld a, $80
    ld [wCBCF], a
    ld a, [wC6FD]
    ld [wC933], a
    ld a, $01
    ld [wC6FD], a
    ld hl, wC92D
    inc [hl]
    ret

; entry 3 of the `rst $00` table in Func_05F_7363
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wScriptParam0, hFF8D, wC527
; points at: wC92D
Func_05F_7363_Case03::
Jump_05F_7631:: ; address name
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_05F_7646
    inc a
    ld [wScriptParam0], a
    ld a, $0E
    ldh [hFF8D], a
    farcall Func_012_64F8
    ret

Jump_05F_7646::
    farcall Func_002_5E85
    farcall Func_002_5E85
    call LoadRecordListNameTiles
    farcall Func_004_4AA8
    ld a, $7F
    ld [wC527], a
    xor a, a
    ldh [hFF8D], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wC92D
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_05F_7363
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wIsCGB
; writes: wC526, wScriptParam0
; points at: wC5E9, wC0F0, wBGPaletteBuffer, wC92D
Func_05F_7363_Case02::
Jump_05F_766C:: ; address name
    ld a, [wScriptParam0]
    srl a
    srl a
    and a, $01
    jr z, Jump_05F_7697
    ld hl, wC5E9
    ld a, $D2
    ld [hl+], a
    ld a, $D2
    ld [hl+], a
    ld a, $E2
    ld [hl], a
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_05F_76BE
    ld hl, wC0F0
    ld de, wBGPaletteBuffer
    ld bc, $0040
    call CopyBytes
    jr Jump_05F_76B9

Jump_05F_7697::
    ld hl, wC5E9
    ld a, $2D
    ld [hl+], a
    ld a, $2D
    ld [hl+], a
    ld a, $1D
    ld [hl], a
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_05F_76BE
    ld b, $40
    ld hl, wC0F0
    ld de, wBGPaletteBuffer

Jump_05F_76B1::
    ld a, [hl+]
    xor a, $FF
    ld [de], a
    inc de
    dec b
    jr nz, Jump_05F_76B1

Jump_05F_76B9::
    ld a, $7F
    ld [wC526], a

Jump_05F_76BE::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $1E
    ret nz
    ld a, $00
    call Func_05F_7761
    xor a, a
    ld [wScriptParam0], a
    ld hl, wC92D
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_05F_7363
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: hPlayerFacing, wCB86
; points at: wBGPaletteBuffer, wC0F0, wC92D
Func_05F_7363_Case01::
Jump_05F_76D6:: ; address name
    ld a, $03
    ldh [hPlayerFacing], a
    ld a, $01
    ld [wCB86], a
    xor a, a
    call RunMessageBoxCarryWhenIdle_Bank5F
    ret nc
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_05F_76F6
    ld hl, wBGPaletteBuffer
    ld de, wC0F0
    ld bc, $0040
    call CopyBytes

Jump_05F_76F6::
    ld a, $7A
    call QueueSoundEffect
    ld hl, wC92D
    inc [hl]
    ret

; entry 0 of the `rst $00` table in Func_05F_7363
; no direct call (reached through a table, a jump or a vector)
; writes: hFFC6, wC92E, wCBD3, wCBD4
; points at: wC92D
Func_05F_7363_Case00::
Jump_05F_7700:: ; address name
    ld a, $01
    ldh [hFFC6], a
    farcall Func_012_6AD9
    ld de, $0021
    call TestFlagBit
    jr c, Jump_05F_771D
    ld a, $00
    ld [wC92E], a
    ld a, $03
    ldh [hFFC6], a
    jr Jump_05F_774C

Jump_05F_771D::
    ld de, $0022
    call TestFlagBit
    jr c, Jump_05F_7730
    ld a, $01
    ld [wC92E], a
    ld a, $08
    ldh [hFFC6], a
    jr Jump_05F_774C

Jump_05F_7730::
    ld de, $0023
    call TestFlagBit
    jr c, Jump_05F_7743
    ld a, $02
    ld [wC92E], a
    ld a, $0A
    ldh [hFFC6], a
    jr Jump_05F_774C

Jump_05F_7743::
    ld a, $03
    ld [wC92E], a
    ld a, $0F
    ldh [hFFC6], a

Jump_05F_774C::
    farcall Func_012_6B98
    ld a, $50
    ld [wCBD3], a
    ld a, $30
    ld [wCBD4], a
    ld hl, wC92D
    inc [hl]
    ret

; 7 call sites from 7 routines (e.g. Func_05F_7363_Case0F, Func_05F_7363_Case0D, Func_05F_7363_Case08, Func_05F_7363_Case05, ...)
; reads: wC92E
; writes: wMessageIndex, wMessageGroup, wMessageState
Func_05F_7761::
    sla a
    ld de, Data_05F_7787
    add a, e
    ld e, a
    jr nc, Jump_05F_776B
    inc d

Jump_05F_776B::
    ld a, [wC92E]
    swap a
    add a, e
    ld e, a
    jr nc, Jump_05F_7775
    inc d

Jump_05F_7775::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    xor a, a
    ld [wMessageState], a
    ret

Data_05F_7787:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $26, $01, $27, $01, $28, $01, $29, $01, $2A, $01, $00, $00, $00, $00, $00, $00
    db $A8, $02, $A9, $02, $AA, $02, $AB, $02, $AC, $02, $00, $00, $00, $00, $00, $00
    db $A8, $02, $E9, $02, $AA, $02, $AB, $02, $EC, $02, $00, $00, $00, $00, $00, $00
    db $34, $05, $35, $05, $36, $05, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

; wC928 = A, RunMessageBox, then carry set when wMessageState = $FF (idle), else A = 0 and carry clear (E-0079)
; 5 call sites from 5 routines (e.g. Func_05F_7363_Case0E, Func_05F_7363_Case09, Func_05F_7363_Case06, Func_05F_7363_Case04, ...)
; reads: wMessageState
; writes: wC928
RunMessageBoxCarryWhenIdle_Bank5F::
Func_05F_77C7:: ; address name
    ld [wC928], a
    call RunMessageBox
    ld a, [wMessageState]
    cp a, $FF
    jr z, Jump_05F_77D6
    sub a, a
    ret

Jump_05F_77D6::
    scf
    ret

; script commands 02 and 03 (and 05 through Func_05F_787C): wScriptParam0 low nibble is an object number (16-byte entries from wCB7F), its high nibble a direction 0-3; sets bit 2 of the object's flag byte and moves the object's position by one unit in that direction
; 2 call sites from 2 routines (e.g. ScriptCommand03, ScriptCommand02)
; reads: wScriptParam0, wScriptStep, wScriptParam1
; writes: wScriptStep, wScriptParam1, wScriptCommandType, wScriptStartRequest
ScriptStepObject::
Func_05F_77D8:: ; address name
    ld c, $10
    ld a, [wScriptParam0]
    and a, $0F
    call Multiply8
    ld a, l
    add a, $7F
    ld l, a
    ld a, h
    adc a, $CB
    ld h, a
    push hl
    ld a, $0D
    add_a_to_hl
    ld a, [hl]
    or a, $04
    ld [hl], a
    dec hl
    dec hl
    ld a, [wScriptParam0]
    swap a
    and a, $0F
    jr z, Jump_05F_7809
    dec a
    jr z, Jump_05F_780F
    dec a
    jr z, Jump_05F_7814
    jr Jump_05F_781A

Jump_05F_7809::
    inc hl
    ld a, [hl]
    inc a
    ld [hl], a
    jr Jump_05F_781F

Jump_05F_780F::
    ld a, [hl]
    inc a
    ld [hl], a
    jr Jump_05F_781F

Jump_05F_7814::
    inc hl
    ld a, [hl]
    dec a
    ld [hl], a
    jr Jump_05F_781F

Jump_05F_781A::
    ld a, [hl]
    dec a
    ld [hl], a
    jr Jump_05F_781F

Jump_05F_781F::
    pop hl
    ld a, $07
    add_a_to_hl
    ld a, [wScriptParam0]
    swap a
    and a, $0F
    ld [hl], a
    ld a, [wScriptStep]
    inc a
    cp a, $10
    jr z, Jump_05F_783B
    ld [wScriptStep], a
    ret

Jump_05F_783B::
    xor a, a
    ld [wScriptStep], a
    ld a, [wScriptParam1]
    dec a
    ld [wScriptParam1], a
    ret nz
    ld a, $06
    add_a_to_hl
    ld a, [hl]
    and a, $FB
    ld [hl], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; script command 04: wScriptParam0/1 is a 16-bit counter that falls by one each frame; at zero it clears wScriptCommandType and sets wScriptStartRequest = $80 so the next script byte is fetched (the opening's waits of 30, 60 and 90 frames showed the counter at 29, 59 and 89)
; 1 call site from 1 routine (e.g. ScriptCommand04)
; reads: wScriptParam0, wScriptParam1
; writes: wScriptParam0, wScriptParam1, wScriptCommandType, wScriptStartRequest
ScriptWaitFrames::
Func_05F_785C:: ; address name
    ld a, [wScriptParam0]
    ld l, a
    ld a, [wScriptParam1]
    ld h, a
    dec hl
    ld a, l
    ld [wScriptParam0], a
    ld a, h
    ld [wScriptParam1], a
    ld a, l
    or a, a
    ret nz
    cp a, h
    ret nz
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 05; reached through ScriptCommand05 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand05)
; reads: wC468, hFF8C, wScriptParam1, wScriptParam0, wJoypadHeld
; writes: wJoypadHeld, wJoypadPressed, wScriptStartRequest, wScriptParam1
ScriptCommand05_Run::
Func_05F_787C:: ; address name
    xor a, a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ld a, [wC468]
    bit 7, a
    ret nz
    ldh a, [hFF8C]
    bit 0, a
    ret nz
    ld a, [wScriptParam1]
    or a, a
    jr nz, Jump_05F_789A
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_05F_789A::
    dec a
    ld [wScriptParam1], a
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_05F_78AD
    ld a, [wJoypadHeld]
    set 7, a
    ld [wJoypadHeld], a
    ret

Jump_05F_78AD::
    dec a
    jr nz, Jump_05F_78B9
    ld a, [wJoypadHeld]
    set 4, a
    ld [wJoypadHeld], a
    ret

Jump_05F_78B9::
    dec a
    jr nz, Jump_05F_78C5
    ld a, [wJoypadHeld]
    set 6, a
    ld [wJoypadHeld], a
    ret

Jump_05F_78C5::
    ld a, [wJoypadHeld]
    set 5, a
    ld [wJoypadHeld], a
    ret

; script command 06: wScriptParam0 picks the target (0 = the player's hPlayerFacing, 1-n = the first byte of the n-th 5-byte record at wC8EF, bit 7 set = byte 7 of the 16-byte object entry numbered by the low bits); wScriptParam1 is stored there; then wScriptStartRequest = $80 so the next script byte is fetched (the opening used it with parameters 129/130 and 2/1)
; 1 call site from 1 routine (e.g. ScriptCommand06)
; reads: wScriptParam0, wScriptParam1
; writes: wScriptStartRequest
; points at: hPlayerFacing, wFollowerRecords
ScriptSetDirection::
Func_05F_78CE:: ; address name
    ld a, [wScriptParam0]
    bit 7, a
    jr nz, Jump_05F_78EE
    or a, a
    jr nz, Jump_05F_78DD
    ld hl, hPlayerFacing
    jr Jump_05F_78FD

Jump_05F_78DD::
    dec a
    ld c, a
    sla a
    sla a
    add a, c
    ld hl, wFollowerRecords
    add_a_to_hl
    jr Jump_05F_78FD

Jump_05F_78EE::
    and a, $7F
    ld c, $10
    call Multiply8
    ld a, l
    add a, $86
    ld l, a
    ld a, h
    adc a, $CB
    ld h, a

Jump_05F_78FD::
    ld a, [wScriptParam1]
    ld [hl], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; script command 0C: for 32 frames adds the per-frame step from the table at Data_05F_7959 (indexed by wScriptParam0 / 2) to a Y coordinate chosen by wScriptParam1 (0 = hPlayerY, 1-n = the n-th 5-byte record from wC8F1, bit 7 = an object entry's byte at wCB8B + 16 * number), counting wScriptParam0 up; at $20 it ends the command
; 1 call site from 1 routine (e.g. ScriptCommand0C)
; reads: wScriptParam1, wScriptParam0
; writes: wScriptParam0, wScriptCommandType, wScriptStartRequest
; points at: hPlayerY, wC8F1, wCB8B
ScriptSlideObjectY::
Func_05F_7907:: ; address name
    ld a, [wScriptParam1]
    bit 7, a
    jr nz, Jump_05F_7927
    or a, a
    jr nz, Jump_05F_7916
    ld de, hPlayerY
    jr Jump_05F_7933

Jump_05F_7916::
    dec a
    ld c, a
    sla a
    sla a
    add a, c
    ld de, wC8F1
    add a, e
    ld e, a
    jr nc, Jump_05F_7925
    inc d

Jump_05F_7925::
    jr Jump_05F_7933

Jump_05F_7927::
    and a, $7F
    swap a
    ld de, wCB8B
    add a, e
    ld e, a
    jr nc, Jump_05F_7933
    inc d

Jump_05F_7933::
    ld a, [wScriptParam0]
    srl a
    ld hl, Data_05F_7959
    add_a_to_hl
    ld a, [hl]
    ld c, a
    ld a, [de]
    add a, c
    ld [de], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Data_05F_7959:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FE, $FF, $FF, $00, $FF, $00, $FF, $00, $00, $01, $00, $01, $00, $01, $01, $02

; implements script command type 0A; reached through ScriptCommand0A in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand0A)
; reads: wScriptStep
ScriptCommand0A_Run::
Func_05F_7969:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand0A_Run_Case00
    dw ScriptCommand0A_Run_Case01
    dw ScriptCommand0A_Run_Case02
    dw ScriptCommand0A_Run_Case03
    dw ScriptCommand0A_Run_Case04

; entry 0 of the `rst $00` table in ScriptCommand0A_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wScriptParam1, wMessageIndex, wMessageGroup, wC634, wC836, hFFC6
; writes: wScriptParam0, wScriptParam1, wC836
; points at: wC152, wScriptStep, wScriptParam0, wInventory
ScriptCommand0A_Run_Case00::
Jump_05F_7977:: ; address name
    ld a, [wScriptParam0]
    cp a, $03
    jr z, Jump_05F_7987
    ld a, [wScriptParam1]
    ld de, wC152
    call CopyItemNameToDE

Jump_05F_7987::
    ld hl, wScriptStep
    inc [hl]
    ld a, [wScriptParam0]
    push af
    ld c, a
    add a, a
    add a, c
    add a, $A0
    ld [wScriptParam0], a
    ld a, [wMessageIndex]
    ld e, a
    ld a, [wMessageGroup]
    ld d, a
    call TestFlagBit
    jr nc, Jump_05F_79AE
    pop af
    ld hl, wScriptParam0
    inc [hl]
    xor a, a
    ld [wScriptParam1], a
    ret

Jump_05F_79AE::
    pop af
    cp a, $03
    jr z, Jump_05F_79F5
    ld a, [wC634]
    cp a, $FF
    jr z, Jump_05F_79BE
    cp a, $00
    jr nz, Jump_05F_79E8

Jump_05F_79BE::
    ld hl, wInventory

Jump_05F_79C1::
    ld a, [hl]
    or a, a
    jr z, Jump_05F_79CC
    cp a, $FF
    jr z, Jump_05F_79CC
    inc hl
    jr Jump_05F_79C1

Jump_05F_79CC::
    ld a, [wScriptParam1]
    ld [hl], a
    ld a, [wC836]
    set 6, a
    ld [wC836], a

Jump_05F_79D8::
    ld a, [wMessageIndex]
    ld e, a
    ld a, [wMessageGroup]
    ld d, a
    call SetFlagBit
    xor a, a
    ld [wScriptParam1], a
    ret

Jump_05F_79E8::
    ld a, [wScriptParam0]
    inc a
    inc a
    ld [wScriptParam0], a
    xor a, a
    ld [wScriptParam1], a
    ret

Jump_05F_79F5::
    farcall Func_012_689A
    ldh a, [hFFC6]
    or a, a
    jr z, Jump_05F_79E8
    jr Jump_05F_79D8

; entry 1 of the `rst $00` table in ScriptCommand0A_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1, hPlayerY
; writes: wC8CB, wC8CC, hFFB9
; points at: wScriptStep
ScriptCommand0A_Run_Case01::
Jump_05F_7A02:: ; address name
    ld a, [wScriptParam1]
    bit 7, a
    jr nz, Jump_05F_7A3D
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
    jr c, Jump_05F_7A3D
    ld a, $81
    ld [wC8CB], a
    ld a, $01
    ldh [hFFB9], a

Jump_05F_7A3D::
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in ScriptCommand0A_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1, wC8CB, wScriptParam0
; points at: wScriptStep
ScriptCommand0A_Run_Case02::
Jump_05F_7A42:: ; address name
    ld a, [wScriptParam1]
    bit 7, a
    jr nz, Jump_05F_7A4F
    ld a, [wC8CB]
    and a, $03
    ret nz

Jump_05F_7A4F::
    ld a, [wScriptParam0]
    ld l, a
    ld h, $00
    call ShowMessageHL
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in ScriptCommand0A_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wScriptParam1, hPlayerY
; writes: hFFB9, wC8CB, wC8CC
; points at: wScriptStep
ScriptCommand0A_Run_Case03::
Jump_05F_7A5D:: ; address name
    ld a, [wC52B]
    bit 0, a
    ret nz
    ld a, [wScriptParam1]
    bit 6, a
    jr nz, Jump_05F_7A87
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
    jr c, Jump_05F_7A87
    ld a, $82
    ld [wC8CB], a

Jump_05F_7A87::
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in ScriptCommand0A_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC8CB
; writes: wScriptCommandType, wScriptRunning, wModeState
ScriptCommand0A_Run_Case04::
Jump_05F_7A8C:: ; address name
    ld a, [wC8CB]
    and a, $03
    ret nz
    farcall Func_084_43B8
    farcall DrawFullScreenBufferAtScroll
    farcall ClearBit1OfPlayerAndObjectFlags
    xor a, a
    ld [wScriptCommandType], a
    xor a, a
    ld [wScriptRunning], a
    ld a, $00
    ld [wModeState], a
    ret

; implements script command type 0E; reached through ScriptCommand0E in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand0E)
; reads: wScriptStep, wScriptParam0
; writes: hFFC6, wScriptCommandType, wScriptStartRequest
; points at: wScriptStep
ScriptCommand0E_Run::
Func_05F_7AB2:: ; address name
    ld a, [wScriptStep]
    or a, a
    jr nz, Jump_05F_7AC8
    ld a, [wScriptParam0]
    ldh [hFFC6], a
    farcall Func_00A_47A4
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_05F_7AC8::
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ld a, [wScriptParam0]
    rst $00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case1E
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00
    dw ScriptCommand0E_Run_Case00

; entry 30 of the `rst $00` table in ScriptCommand0E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wSpriteSlotCount
ScriptCommand0E_Run_Case1E::
Jump_05F_7B3B:: ; address name
    xor a, a
    ld [wSpriteSlotCount], a
    ret

; entry 0 of the `rst $00` table in ScriptCommand0E_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand0E_Run_Case00::
Jump_05F_7B40:: ; address name
    ret
    ds $4BF, $00
