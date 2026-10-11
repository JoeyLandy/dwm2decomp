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
; reads: wStepPtrLo, wMessageGroup, hPlayerY
; writes: wTextWindowState, wTextWindowStep, hSpriteWindowClipMode
; points at: wMessageState
RunMessageBox_Case00::
Jump_05F_6947:: ; address name
    ld a, [wStepPtrLo]
    or a, a
    jr nz, Jump_05F_6953
    farcall SetBit1OfPlayerAndObjectFlags

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
    ld [wTextWindowState], a
    ld a, $00
    ld [wTextWindowStep], a
    ld a, $02
    ldh [hSpriteWindowClipMode], a
    ldh a, [hPlayerY]
    cp a, $48
    jr c, Jump_05F_6988
    ld a, $81
    ld [wTextWindowState], a
    ld a, $01
    ldh [hSpriteWindowClipMode], a

Jump_05F_6988::
    ld hl, wMessageState
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunMessageBox
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageGroup, wTextWindowState
; points at: wMessageState
RunMessageBox_Case01::
Jump_05F_698D:: ; address name
    ld a, [wMessageGroup]
    bit 7, a
    jr nz, Jump_05F_699A
    ld a, [wTextWindowState]
    and a, $03
    ret nz

Jump_05F_699A::
    call ShowMessageFromWC924
    ld hl, wMessageState
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunMessageBox
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wMessageGroup, hPlayerY
; writes: wTextWindowState, wTextWindowStep, hSpriteWindowClipMode
; points at: wMessageState
RunMessageBox_Case02::
Jump_05F_69A2:: ; address name
    ld a, [wTextFlags]
    bit 0, a
    ret nz
    ld a, [wMessageGroup]
    bit 6, a
    jr nz, Jump_05F_69CD
    ld a, $69
    call QueueSoundEffect
    ld a, $02
    ld [wTextWindowState], a
    ld a, $00
    ld [wTextWindowStep], a
    ld a, $00
    ldh [hSpriteWindowClipMode], a
    ldh a, [hPlayerY]
    cp a, $48
    jr c, Jump_05F_69CD
    ld a, $82
    ld [wTextWindowState], a

Jump_05F_69CD::
    ld hl, wMessageState
    inc [hl]
    ret

; entry 3 of the `rst $00` table in RunMessageBox
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageGroup, wTextWindowState, wStepPtrLo
; writes: wMessageState
RunMessageBox_Case03::
Jump_05F_69D2:: ; address name
    ld a, [wMessageGroup]
    bit 6, a
    jr nz, Jump_05F_69E1
    ld a, [wTextWindowState]
    and a, $03
    jr z, Jump_05F_69E1
    ret

Jump_05F_69E1::
    ld a, [wStepPtrLo]
    or a, a
    jr nz, Jump_05F_69ED
    farcall ClearBit1OfPlayerAndObjectFlags

Jump_05F_69ED::
    ld a, $FF
    ld [wMessageState], a
    ret

; HL = wMessageIndex/wMessageGroup, then ShowMessageHL (E-0079)
; 1 call site from 1 routine (e.g. RunMessageBox_Case01)
; reads: wMessageIndex, wMessageGroup, wMapType
; writes: wStringIndex, wStringCategory
ShowMessageFromWC924::
Func_05F_69F3:: ; address name
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a

; L = string index (wStringIndex, category 0), H & $3F = message group, which selects one of 12 table entries (rst $00); when wCC44 has bit 7 set and is not $80 another path is taken (not read) (E-0079)
; 1 call site from 1 routine (e.g. ScriptCommand0A_Run_Case02)
; reads: wMapType
; writes: wStringIndex, wStringCategory
ShowMessageHL::
Func_05F_69FB:: ; address name
    ld a, [wMapType]
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
; reads: hPlayerStateFlags, hPlayerY, wStepPtrLo
; writes: hPlayerStateFlags, hPlayerFacing, hPlayerY, wStepArrived
StepPlayerDownTowardWC928::
Func_05F_6A94:: ; address name
    ldh a, [hPlayerStateFlags]
    or a, $04
    ldh [hPlayerStateFlags], a
    xor a, a
    ldh [hPlayerFacing], a
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank5F
    ld a, [wStepPtrLo]
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
    ldh a, [hPlayerStateFlags]
    and a, $FB
    ldh [hPlayerStateFlags], a
    ld a, $01
    ld [wStepArrived], a
    ret

; sets bit 2 of hFF8C (moving) and hPlayerFacing = 1; calls Func_05F_6B43 with the coordinate; then hPlayerX += 1; when it equals wC928 bit 2 is cleared and wC92C = 1, else wC92C = 0 (E-0071)
; 7 call sites from 6 routines (e.g. ScriptCommand5E_Run_Case23, ScriptCommand49_Run_Case03, ScriptCommand39_Run_Case21, ScriptCommand6A_Run_Shared01, ...)
; reads: hPlayerStateFlags, hPlayerX, wStepPtrLo
; writes: hPlayerStateFlags, hPlayerFacing, hPlayerX, wStepArrived
StepPlayerRightTowardWC928::
Func_05F_6ABF:: ; address name
    ldh a, [hPlayerStateFlags]
    or a, $04
    ldh [hPlayerStateFlags], a
    ld a, $01
    ldh [hPlayerFacing], a
    ldh a, [hPlayerX]
    call UpdateFollowersOnStep_Bank5F
    ld a, [wStepPtrLo]
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
    ldh a, [hPlayerStateFlags]
    and a, $FB
    ldh [hPlayerStateFlags], a
    ld a, $01
    ld [wStepArrived], a
    ret

; sets bit 2 of hFF8C (moving) and hPlayerFacing = 2; calls Func_05F_6B43 with the coordinate; then hPlayerY -= 1; when it equals wC928 bit 2 is cleared and wC92C = 1, else wC92C = 0 (E-0071)
; 15 call sites from 12 routines (e.g. ScriptCommand5E_Run_Case02, ScriptCommand49_Run_Case03, ScriptCommand49_Run_Case02, ScriptCommand49_Run_Case00, ...)
; reads: hPlayerStateFlags, hPlayerY, wStepPtrLo
; writes: hPlayerStateFlags, hPlayerFacing, hPlayerY, wStepArrived
StepPlayerUpTowardWC928::
Func_05F_6AEB:: ; address name
    ldh a, [hPlayerStateFlags]
    or a, $04
    ldh [hPlayerStateFlags], a
    ld a, $02
    ldh [hPlayerFacing], a
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank5F
    ld a, [wStepPtrLo]
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
    ldh a, [hPlayerStateFlags]
    and a, $FB
    ldh [hPlayerStateFlags], a
    ld a, $01
    ld [wStepArrived], a
    ret

; sets bit 2 of hFF8C (moving) and hPlayerFacing = 3; calls Func_05F_6B43 with the coordinate; then hPlayerX -= 1; when it equals wC928 bit 2 is cleared and wC92C = 1, else wC92C = 0 (E-0071)
; 16 call sites from 13 routines (e.g. ScriptCommand5F_Run_Case14, ScriptCommand5E_Run_Case02, ScriptCommand49_Run_Case02, ScriptCommand49_Run_Case00, ...)
; reads: hPlayerStateFlags, hPlayerX, wStepPtrLo
; writes: hPlayerStateFlags, hPlayerFacing, hPlayerX, wStepArrived
StepPlayerLeftTowardWC928::
Func_05F_6B17:: ; address name
    ldh a, [hPlayerStateFlags]
    or a, $04
    ldh [hPlayerStateFlags], a
    ld a, $03
    ldh [hPlayerFacing], a
    ldh a, [hPlayerX]
    call UpdateFollowersOnStep_Bank5F
    ld a, [wStepPtrLo]
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
    ldh a, [hPlayerStateFlags]
    and a, $FB
    ldh [hPlayerStateFlags], a
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
; 145 call sites from 78 routines (e.g. ScriptCommandC7_Run_Case01, ScriptCommand5F_Run_Case17, ScriptStepMoveObjects2And3To81B0, ScriptStepMoveObjects2And3To0340, ...)
; reads: wStepPtrHi, wStepTarget, wStepPtrLo
; writes: wStepArrived
StepObjectTowardCoord::
Func_05F_6B54:: ; address name
    ld a, [wStepPtrHi]
    swap a
    ld hl, wSpriteSlots + $D
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
    ld a, [wStepTarget]
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
    ld a, [wStepPtrLo]
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
; 66 call sites from 54 routines (e.g. RunWC92DStep_7363_Case0F, RunWC92DStep_7363_Case0D, RunWC92DStep_7363_Case0B, RunWC92DStep_7363_Case08, ...)
; reads: wStepPtrLo, wStepPtrHi, wScriptParam0
AddStepDeltaToPointedByte::
Func_05F_6BCD:: ; address name
    ld a, [wStepPtrLo]
    ld e, a
    ld a, [wStepPtrHi]
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

; for $78 frames blinks object hFFC6 by alternating byte wCB8B[16 * obj] between hFFC7 and $E0 (hidden) at a slowing rate; hFFC6 = 1 when done (E-0127)
; 20 call sites from 19 routines (e.g. ScriptCommand5E_Run_Case00, ScriptCommand4E_Run_Case04, ScriptCommand4A_Run_Case08, ScriptCommand66_Run_Case08, ...)
; reads: wScriptParam0, hTemp0, hTemp1
; writes: wScriptParam0, hTemp0
ScriptStepBlinkObjectHFFC6::
Func_05F_6BF8:: ; address name
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
    ldh a, [hTemp0]
    swap a
    ld hl, wSpriteSlots + $C
    add_a_to_hl
    ldh a, [hTemp1]
    ld [hl], a
    jr Jump_05F_6C34

Jump_05F_6C26::
    ldh a, [hTemp0]
    swap a
    ld hl, wSpriteSlots + $C
    add_a_to_hl
    ld [hl], $E0

Jump_05F_6C34::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $78
    jr z, Jump_05F_6C43
    xor a, a
    ldh [hTemp0], a
    ret

Jump_05F_6C43::
    ldh a, [hTemp0]
    swap a
    ld hl, wSpriteSlots + $C
    add_a_to_hl
    ld [hl], $E0
    xor a, a
    ld [wScriptParam0], a
    ld a, $01
    ldh [hTemp0], a
    ret

; StartPaletteFade with A = $0F, wModeState = 4, wC8C5 = 0, wScriptParam0 = 0, then wScriptStep += 1 (E-0061)
; 52 call sites from 49 routines (e.g. ScriptCommand5E_Run_Shared01, ScriptCommand5E_Run_Case0B, ScriptCommand58_Run_Case1E, ScriptCommand4B_Run_Case11, ...)
; writes: wModeState, wFieldTransitionStep, wScriptParam0
; points at: wScriptStep
ScriptStartFadeAndAdvanceStep::
Func_05F_6C5A:: ; address name
    ld a, $0F
    call StartPaletteFade
    ld a, $04
    ld [wModeState], a
    xor a, a
    ld [wFieldTransitionStep], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; wModeState = 3, wC904 = 0, wC8C7 = 2, far-calls SaveScreenBufferToBGMap1, then Func_00A_476E (E-0078)
; 5 call sites from 5 routines (e.g. ScriptCommand9A_Run, ScriptCommand96_Run_Case04, ScriptCommand85_Run_Case01, ScriptCommand9E_Run_Case01, ...)
; writes: wModeState, wBattleTransitionStep, wFieldReturnPhase
SetModeState3AndSaveScreen::
Func_05F_6C71:: ; address name
    ld a, $03
    ld [wModeState], a
    xor a, a
    ld [wBattleTransitionStep], a
    ld a, $02
    ld [wFieldReturnPhase], a
    farcall SaveScreenBufferToBGMap1
    farcall PickRandomWC902FromTable478F
    ret

; stores wC928 in the first wInventory slot that is $00 or $FF (no bound check), then sets bit 6 of wC836; HL kept (E-0071)
; 17 call sites from 16 routines (e.g. ScriptCommand32_Run_Case00, ScriptCommand84_Run_Case08, ScriptCommand86_Run_Case02, ScriptCommand81_Run_Case02, ...)
; reads: wStepPtrLo, wGameFlags836
; writes: wGameFlags836
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
    ld a, [wStepPtrLo]
    ld [hl], a
    pop hl
    ld a, [wGameFlags836]
    set 6, a
    ld [wGameFlags836], a
    ret

; wStepArrived = 1 when a party record has bit 7 of field $55 set, else 0 (E-0124)
; 5 call sites from 4 routines (e.g. Func_004_58C2_Case13, Func_004_612B_Case18, DispatchTalkEvent_Case04_Case6F, ScriptCommand82_Run_Shared05)
; reads: wPartyCount, hTemp0
; writes: rRAMG, wStepArrived
; points at: wPartyList
SetWStepArrivedIfPartyHasField55Bit7::
Func_05F_6CA9:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, [wPartyCount]
    or a, a
    jr z, Jump_05F_6CC8
    ld b, a
    ld hl, wPartyList

Jump_05F_6CB8::
    ld a, [hl]
    ld c, $55
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
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

; only called from ScriptCommand82_Run_Shared05 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommand82_Run_Shared05)
; reads: wPartyCount, hTemp0
; writes: rRAMG, wStepArrived
; points at: wPartyList
ScriptCommand82_Run_Shared05_Sub01::
Func_05F_6CDB:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, [wPartyCount]
    or a, a
    jr z, Jump_05F_6CFA
    ld b, a
    ld hl, wPartyList

Jump_05F_6CEA::
    ld a, [hl]
    ld c, $55
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
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

; only called from ScriptCommand82_Run_Shared05 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommand82_Run_Shared05)
; reads: wPartyCount, hTemp0
; writes: rRAMG, wStepArrived
; points at: wPartyList
ScriptCommand82_Run_Shared05_Sub02::
Func_05F_6D0D:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, [wPartyCount]
    or a, a
    jr z, Jump_05F_6D2C
    ld b, a
    ld hl, wPartyList

Jump_05F_6D1C::
    ld a, [hl]
    ld c, $55
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
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

; with hFF8D bits 1-3 set: wD7F1 = wC6FE[hFFC6] (bank 0 record), far-calls Func_014_7E96, LoadRecordListNameTiles and Func_004_4AA8, wC527 = $7F, then clears hFF8D bits 1-3 (E-0121)
; 3 call sites from 3 routines (e.g. ScriptCommand3D_Run_Case03, ScriptCommand3C_Run_Case0D, ScriptCommand3A_Run_Case0A)
; reads: hFieldDrawFlags, hTemp0
; writes: hFieldDrawFlags, wArg1, wArg2, wOBJPaletteUploadRequest
; points at: wPartyList
LoadListedRecordNameTilesForHFFC6::
Func_05F_6D3F:: ; address name
    farcall FindPartyIndexOfSpeciesHFFC6
    ldh a, [hFieldDrawFlags]
    or a, $0E
    ldh [hFieldDrawFlags], a
    ldh a, [hTemp0]
    ld hl, wPartyList
    add_a_to_hl
    ld a, [hl]
    ld [wArg1], a
    xor a, a
    ld [wArg2], a
    farcall DeleteSRAMRecordAndCompact
    call LoadRecordListNameTiles
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ldh a, [hFieldDrawFlags]
    and a, $F1
    ldh [hFieldDrawFlags], a
    ret

; for record $FF in bank 1 (Func_014_7E96): if wD7F5 is not $FF and is >= Data_05F_6DA8[wC7C7 & 3], sets wD7F5 = $FF (E-0121)
; 7 call sites from 7 routines (e.g. DispatchTalkEvent_Case01_Case33, DispatchTalkEvent_Case01_Case42, Talk08D1_TheEvaluatorSaidI, ScriptCommand2A_Run_Case02, ...)
; reads: wArg5, wFarmLevel
; writes: wArg1, wArg2, wArg5
ClearWD7F5IfAtOrAboveLimitForWC7C7::
Func_05F_6D78:: ; address name
    ld a, $FF
    ld [wArg1], a
    ld a, $01
    ld [wArg2], a
    farcall DeleteSRAMRecordAndCompact
    ld a, [wArg5]
    cp a, $FF
    ret z
    ld a, [wFarmLevel]
    and a, $03
    ld hl, Data_05F_6DA8
    add_a_to_hl
    ld a, [hl]
    ld c, a
    ld a, [wArg5]
    cp a, c
    ret c
    ld a, $FF
    ld [wArg5], a
    ret

Data_05F_6DA8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0A, $14, $1E, $1E

; sets bit 6 of the first used key entry (byte 3 bit 7) whose kind (byte 0 & $3F) equals hFFC6 (E-0125)
; 10 call sites from 8 routines (e.g. Talk075F_KiralFetchMeMy, ScriptCommand58_Run_Case2B, ScriptCommand4B_Run_Case16, ScriptCommand39_Run_Case31, ...)
; reads: hTemp0
; points at: wKeyList
MarkKeyEntryKindHFFC6Bit6::
Func_05F_6DAC:: ; address name
    ldh a, [hTemp0]
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

; DE = the BG map row at hScrollY (& $F8); calls Func_05F_6E35 for the columns at hScrollX - 8 and hScrollX + $A0, just off the left and right edges (E-0121)
; 9 call sites from 9 routines (e.g. ScriptCommand5E_Run_Case0D, ScriptCommand58_Run_Case00, ScriptCommand41_Run_Case00, ScriptCommand43_Run_Case00, ...)
; reads: hScrollY, hScrollX
RedrawColumnsBesideScreen::
Func_05F_6E09:: ; address name
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
    call RedrawColumnsBesideScreen_Sub01
    pop de
    ldh a, [hScrollX]
    add a, $A0
    call RedrawColumnsBesideScreen_Sub01
    ret

; only called from RedrawColumnsBesideScreen (E-0047)
; 2 call sites from 1 routine (e.g. RedrawColumnsBesideScreen)
RedrawColumnsBesideScreen_Sub01::
Func_05F_6E35:: ; address name
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
; reads: wScriptSubStep
ScriptCommand2C_Run_Case06_Sub01::
Func_05F_6E58:: ; address name
    ld a, [wScriptSubStep]
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
; writes: hPlayerFacing, wFollowerRecords
; points at: wScriptSubStep
Func_05F_6E58_Case0B::
Jump_05F_6E7E:: ; address name
    xor a, a
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $A], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; entry 8 of the `rst $00` table in Func_05F_6E58
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerStateFlags, wScriptParam0
; writes: hPlayerFacing, wFollowerRecords, hPlayerStateFlags, wScriptParam0
; points at: wScriptSubStep
Func_05F_6E58_Case08::
Jump_05F_6E8F:: ; address name
    ld a, $02
    jr Jump_05F_6E99

; entry 5 of the `rst $00` table in Func_05F_6E58
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerStateFlags, wScriptParam0
; writes: hPlayerFacing, wFollowerRecords, hPlayerStateFlags, wScriptParam0
; points at: wScriptSubStep
Func_05F_6E58_Case05::
Jump_05F_6E93:: ; address name
    ld a, $01
    jr Jump_05F_6E99

; entry 2 of the `rst $00` table in Func_05F_6E58
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerStateFlags, wScriptParam0
; writes: hPlayerFacing, wFollowerRecords, hPlayerStateFlags, wScriptParam0
; points at: wScriptSubStep
Func_05F_6E58_Case02::
Jump_05F_6E97:: ; address name
    ld a, $03

Jump_05F_6E99::
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $A], a
    ldh a, [hPlayerStateFlags]
    and a, $FD
    ldh [hPlayerStateFlags], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $40
    ret nz
    ldh a, [hPlayerStateFlags]
    or a, $02
    ldh [hPlayerStateFlags], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; only called from ScriptCommand2D_Run_Case05 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommand2D_Run_Case05)
; reads: wScriptSubStep
ScriptCommand2D_Run_Case05_Sub01::
Func_05F_6EC3:: ; address name
    ld a, [wScriptSubStep]
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
; reads: hPlayerStateFlags
; writes: hPlayerStateFlags
; points at: wScriptStep
Func_05F_6E58_Case10::
Jump_05F_6EE3:: ; address name
    ldh a, [hPlayerStateFlags]
    and a, $FD
    ldh [hPlayerStateFlags], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 12 of the `rst $00` table in Func_05F_6E58
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wStepPtrLo, wStepPtrHi, wScriptParam0
; points at: hPlayerY, wScriptSubStep
Func_05F_6E58_Case0C::
Jump_05F_6EEE:: ; address name
    ld de, hPlayerY
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld de, wFollowerRecords + $2
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld de, wFollowerRecords + $7
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld de, wFollowerRecords + $C
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    inc a
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in Func_05F_6EC3
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, hPlayerFacing
; writes: wScriptParam0, hPlayerFacing, wFollowerRecords
; points at: wScriptSubStep
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
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $A], a
    or a, a
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in Func_05F_6EC3
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, hPlayerFacing, wFollowerRecords, hPlayerStateFlags
; writes: hPlayerFacing, wFollowerRecords, wScriptParam0, hPlayerStateFlags
; points at: hPlayerX, wScriptSubStep, wScriptParam0
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
    ld hl, wFollowerRecords + $1
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
    ld a, [wFollowerRecords + $B]
    add a, c
    ld [wFollowerRecords + $B], a
    ld a, [wFollowerRecords + $6]
    sub a, c
    ld [wFollowerRecords + $6], a
    ld a, [hl]
    ld c, a
    ld a, [wFollowerRecords + $C]
    add a, c
    ld [wFollowerRecords + $C], a
    ld a, [wFollowerRecords + $7]
    sub a, c
    ld [wFollowerRecords + $7], a
    ld a, [wScriptParam0]
    srl a
    srl a
    cp a, $1F
    jr nz, Jump_05F_6FDC
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

Jump_05F_6FDC::
    ldh a, [hPlayerStateFlags]
    or a, $02
    ldh [hPlayerStateFlags], a
    ld hl, wScriptParam0
    inc [hl]
    ret

; entry 3 of the `rst $00` table in Func_05F_6EC3
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wStepPtrLo, wStepPtrHi, wScriptParam0
; points at: wScriptSubStep
Func_05F_6EC3_Case03::
Jump_05F_6FE7:: ; address name
    ld de, wFollowerRecords + $7
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld de, wFollowerRecords + $C
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte

; entry 0 of the `rst $00` table in Func_05F_6E58
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wScriptParam0
; points at: wScriptSubStep
Func_05F_6E58_Case00::
Jump_05F_7009:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_05F_6EC3
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, hPlayerFacing
; writes: hPlayerFacing, wFollowerRecords
; points at: hPlayerX
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
    ld hl, wFollowerRecords + $1
    inc [hl]
    ld hl, hPlayerX
    dec [hl]

Jump_05F_703D::
    ld hl, Data_05F_7092
    call ScriptStepMoveTwoObjectsByTable
    ret

; every fourth step moves wC8F5/wC8F6 and wC8FA/wC8FB in opposite directions by the table at HL; after 32 steps advances wC92D (E-0125)
; 1 call site from 1 routine (e.g. Func_05F_6EC3_Case02)
; reads: wScriptParam0, wFollowerRecords
; writes: wFollowerRecords, wScriptParam0
; points at: wScriptSubStep, wScriptParam0
ScriptStepMoveTwoObjectsByTable::
Func_05F_7044:: ; address name
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
    ld a, [wFollowerRecords + $6]
    add a, c
    ld [wFollowerRecords + $6], a
    ld a, [wFollowerRecords + $B]
    sub a, c
    ld [wFollowerRecords + $B], a
    ld a, [hl]
    ld c, a
    ld a, [wFollowerRecords + $7]
    add a, c
    ld [wFollowerRecords + $7], a
    ld a, [wFollowerRecords + $C]
    sub a, c
    ld [wFollowerRecords + $C], a
    ld a, [wScriptParam0]
    srl a
    srl a
    cp a, $1F
    jr nz, Jump_05F_708D
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
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

; runs the routine for wC92D (jump table of eight) (E-0122)
; 2 call sites from 2 routines (e.g. ScriptCommand46_Run_Case0F, ScriptCommand1F_Run_Case07)
; reads: wScriptSubStep
RunWC92DStep::
Func_05F_70D2:: ; address name
    ld a, [wScriptSubStep]
    rst $00
    dw RunWC92DStep_Case00
    dw RunWC92DStep_Case01
    dw RunWC92DStep_Case02
    dw RunWC92DStep_Case03
    dw RunWC92DStep_Case04
    dw RunWC92DStep_Case05
    dw RunWC92DStep_Case06
    dw RunWC92DStep_Case07

; entry 7 of the `rst $00` table in RunWC92DStep
; no direct call (reached through a table, a jump or a vector)
; reads: wFollowerRecords, wScriptParam0, hPlayerX, hPlayerStateFlags
; writes: wFollowerRecords, hPlayerFacing, hPlayerStateFlags, wScriptParam0
; points at: wScriptParam0, wScriptStep
RunWC92DStep_Case07::
Jump_05F_70E6:: ; address name
    ld a, $01
    ld [wFollowerRecords], a
    ld a, [wFollowerRecords + $1]
    inc a
    ld [wFollowerRecords + $1], a
    ld a, [wScriptParam0]
    and a, $01
    jr nz, Jump_05F_7105
    ld a, $02
    ld [wFollowerRecords + $5], a
    ld a, [wFollowerRecords + $7]
    dec a
    ld [wFollowerRecords + $7], a

Jump_05F_7105::
    ld hl, wScriptParam0
    inc [hl]
    ld a, $03
    ld [wFollowerRecords + $A], a
    ld a, [wFollowerRecords + $B]
    dec a
    ld [wFollowerRecords + $B], a
    ldh a, [hPlayerX]
    ld c, a
    ld a, [wFollowerRecords + $B]
    cp a, c
    ret nz
    xor a, a
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $A], a
    ldh a, [hPlayerStateFlags]
    and a, $FB
    ldh [hPlayerStateFlags], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in RunWC92DStep
; no direct call (reached through a table, a jump or a vector)
; reads: wObject5, wScriptParam0, hPlayerStateFlags
; writes: wStepPtrLo, wStepPtrHi, wObject5, wScriptParam0, hPlayerStateFlags, hPlayerFacing
; points at: wScriptSubStep
RunWC92DStep_Case06::
Jump_05F_7138:: ; address name
    ld de, wObject5 + $5
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wObject5 + $5]
    inc a
    ld [wObject5 + $5], a
    ld a, [wScriptParam0]
    inc a
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    xor a, a
    ld [wObject5], a
    ldh a, [hPlayerStateFlags]
    and a, $FD
    ldh [hPlayerStateFlags], a
    ld a, $02
    ldh [hPlayerFacing], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in RunWC92DStep
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerStateFlags, wScriptParam0
; writes: hPlayerStateFlags, wFollowerRecords, wScriptParam0
; points at: wScriptSubStep
RunWC92DStep_Case05::
Jump_05F_7172:: ; address name
    ldh a, [hPlayerStateFlags]
    or a, $02
    ldh [hPlayerStateFlags], a
    xor a, a
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $A], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $3C
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in RunWC92DStep
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptTemp2, wScriptTemp3, hPlayerY, wFrameCounterLo, hPlayerX
; writes: wScriptTemp2, wScriptTemp3, wScriptParam0
; points at: wScriptSubStep, wFollowerRecords, wScriptMsgSelect
RunWC92DStep_Case04::
Jump_05F_7195:: ; address name
    ld a, [wScriptTemp2]
    ld l, a
    ld a, [wScriptTemp3]
    ld h, a
    dec hl
    ld a, l
    ld [wScriptTemp2], a
    ld a, h
    ld [wScriptTemp3], a
    ld a, l
    or a, h
    jr nz, Jump_05F_71B2
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]

Jump_05F_71B2::
    ld b, $03
    ld hl, wFollowerRecords
    ld de, wScriptMsgSelect

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

; entry 3 of the `rst $00` table in RunWC92DStep
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, hPlayerStateFlags
; writes: wScriptParam0, hPlayerStateFlags, wScriptMsgSelect, wScriptTemp0, wScriptTemp1, wScriptTemp2, wScriptTemp3
; points at: wScriptSubStep
RunWC92DStep_Case03::
Jump_05F_7280:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $78
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ldh a, [hPlayerStateFlags]
    or a, $04
    ldh [hPlayerStateFlags], a
    ld a, $00
    ld [wScriptMsgSelect], a
    ld a, $01
    ld [wScriptTemp0], a
    ld a, $03
    ld [wScriptTemp1], a
    ld hl, $0320
    ld a, l
    ld [wScriptTemp2], a
    ld a, h
    ld [wScriptTemp3], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunWC92DStep
; no direct call (reached through a table, a jump or a vector)
; reads: wObject5, wScriptParam0
; writes: wObject5, wStepPtrLo, wStepPtrHi, wScriptParam0
; points at: wScriptSubStep
RunWC92DStep_Case02::
Jump_05F_72B3:: ; address name
    ld a, $80
    ld [wObject5], a
    ld de, wObject5 + $5
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wObject5 + $5]
    dec a
    ld [wObject5 + $5], a
    ld a, [wScriptParam0]
    inc a
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunWC92DStep
; no direct call (reached through a table, a jump or a vector)
; reads: wFollowerRecords, wScriptParam0, hPlayerX, hPlayerStateFlags
; writes: wFollowerRecords, hPlayerFacing, hTemp0, hPlayerStateFlags, wScriptParam0
; points at: wScriptParam0, wScriptSubStep
RunWC92DStep_Case01::
Jump_05F_72E4:: ; address name
    ld a, $03
    ld [wFollowerRecords], a
    ld a, [wFollowerRecords + $1]
    dec a
    ld [wFollowerRecords + $1], a
    ld a, [wScriptParam0]
    and a, $01
    jr nz, Jump_05F_7303
    ld a, $00
    ld [wFollowerRecords + $5], a
    ld a, [wFollowerRecords + $7]
    inc a
    ld [wFollowerRecords + $7], a

Jump_05F_7303::
    ld hl, wScriptParam0
    inc [hl]
    ld a, $01
    ld [wFollowerRecords + $A], a
    ld a, [wFollowerRecords + $B]
    inc a
    ld [wFollowerRecords + $B], a
    ldh a, [hPlayerX]
    ld c, a
    ld a, [wFollowerRecords + $B]
    sub a, c
    cp a, $20
    ret nz
    xor a, a
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    inc a
    ld [wFollowerRecords + $5], a
    ld a, $03
    ld [wFollowerRecords + $A], a
    ld a, $0B
    ldh [hTemp0], a
    farcall RunFieldCommandHFFC6
    ldh a, [hPlayerStateFlags]
    or a, $02
    ldh [hPlayerStateFlags], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in RunWC92DStep
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerStateFlags, hPlayerX, wScriptParam0
; writes: hPlayerStateFlags, wScriptParam0
; points at: wScriptSubStep
RunWC92DStep_Case00::
Jump_05F_7345:: ; address name
    ldh a, [hPlayerStateFlags]
    or a, $04
    ldh [hPlayerStateFlags], a
    ldh a, [hPlayerX]
    call UpdateFollowersOnStep_Bank5F
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $3C
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; runs the routine for wC92D (jump table of eighteen) (E-0124)
; 4 call sites from 4 routines (e.g. ScriptCommand5E_Run_Case0C, ScriptCommand4B_Run_Case12, ScriptCommand39_Run_Case2D, ScriptCommand27_Run_Case1F)
; reads: wScriptSubStep
RunWC92DStep_7363::
Func_05F_7363:: ; address name
    ld a, [wScriptSubStep]
    rst $00
    dw RunWC92DStep_7363_Case00
    dw RunWC92DStep_7363_Case01
    dw RunWC92DStep_7363_Case02
    dw RunWC92DStep_7363_Case03
    dw RunWC92DStep_7363_Case04
    dw RunWC92DStep_7363_Case05
    dw RunWC92DStep_7363_Case06
    dw RunWC92DStep_7363_Case07
    dw RunWC92DStep_7363_Case08
    dw RunWC92DStep_7363_Case09
    dw RunWC92DStep_7363_Case0A
    dw RunWC92DStep_7363_Case0B
    dw RunWC92DStep_7363_Case0C
    dw RunWC92DStep_7363_Case0D
    dw RunWC92DStep_7363_Case0E
    dw RunWC92DStep_7363_Case0F
    dw RunWC92DStep_7363_Case09
    dw RunWC92DStep_7363_Case11

; entry 17 of the `rst $00` table in RunWC92DStep_7363
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
RunWC92DStep_7363_Case11::
Jump_05F_738B:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ret

; starts message 6 and advances wC92D when wC552 is 0, otherwise message 7 and steps wC92D back (E-0126)
; no direct call (reached through a table, a jump or a vector)
; reads: wTextYesNoResult
; points at: wScriptSubStep
StartChoiceMessageByWC552:: ; heuristic: follows a terminator; C0
Func_05F_7390:: ; address name
    ld a, [wTextYesNoResult]
    or a, a
    jr nz, Jump_05F_739E
    ld a, $06
    ld hl, wScriptSubStep
    inc [hl]
    jr Jump_05F_73A4

Jump_05F_739E::
    ld a, $07
    ld hl, wScriptSubStep
    dec [hl]

Jump_05F_73A4::
    call StartMessageFromTable7787
    ret

; starts message 5 from Data_05F_7787 and advances wC92D (E-0126)
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptSubStep
StartMessage5AndAdvanceWC92D:: ; heuristic: follows a terminator; C0
Func_05F_73A8:: ; address name
    ld a, $05
    call StartMessageFromTable7787
    ld hl, wScriptSubStep
    inc [hl]
    ret

; entry 15 of the `rst $00` table in RunWC92DStep_7363
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wSpriteSlots, wScriptTemp4
; writes: wStepPtrLo, wStepPtrHi, wSpriteSlots, wScriptParam0, hTemp0, wPartyCount
; points at: wScriptSubStep
RunWC92DStep_7363_Case0F::
Jump_05F_73B2:: ; address name
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_05F_73BD
    ld a, $65
    call QueueSoundEffect

Jump_05F_73BD::
    ld de, wSpriteSlots + $C
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    call AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    and a, $01
    jr nz, Jump_05F_73D6
    ld hl, wSpriteSlots + $B
    inc [hl]

Jump_05F_73D6::
    ld a, [wScriptParam0]
    and a, $01
    jr nz, Jump_05F_73E6
    ld a, [wSpriteSlots + $7]
    inc a
    and a, $03
    ld [wSpriteSlots + $7], a

Jump_05F_73E6::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    jr z, Jump_05F_7402
    farcall CycleWC949Down
    ld a, $01
    ldh [hTemp0], a
    farcall DrawAnimatedMetaSprite1B
    ret

Jump_05F_7402::
    ld a, $72
    call QueueSoundEffect
    ld de, Data_07D_7AD4
    ld b, $7D
    ld hl, vTiles0 + $500
    call DecompressToVRAM
    ld a, $49
    ld [wSpriteSlots + $2], a
    xor a, a
    ld [wSpriteSlots + $7], a
    ld a, $04
    call StartMessageFromTable7787
    ld a, [wScriptTemp4]
    ld [wPartyCount], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; entry 14 of the `rst $00` table in RunWC92DStep_7363
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0
; points at: wScriptSubStep
RunWC92DStep_7363_Case0E::
Jump_05F_742F:: ; address name
    xor a, a
    call RunMessageBoxCarryWhenIdle_Bank5F
    ret nc
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; entry 13 of the `rst $00` table in RunWC92DStep_7363
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: hTemp0, wStepPtrLo, wStepPtrHi, wScriptParam0
; points at: wScriptSubStep
RunWC92DStep_7363_Case0D::
Jump_05F_743D:: ; address name
    farcall CycleWC949Down
    ld a, $01
    ldh [hTemp0], a
    farcall DrawAnimatedMetaSprite1B
    ld de, wSpriteSlots + $C
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    call AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    ld a, $03
    call StartMessageFromTable7787
    ld hl, wScriptSubStep
    inc [hl]
    ret

; entry 12 of the `rst $00` table in RunWC92DStep_7363
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1, wScriptParam0
; writes: hTemp0, wScriptParam1, wScriptParam0, wObject5
; points at: wScriptSubStep
RunWC92DStep_7363_Case0C::
Jump_05F_746F:: ; address name
    farcall CycleWC949Down
    ld a, $01
    ldh [hTemp0], a
    farcall DrawAnimatedMetaSprite1B
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
    ld [wObject5], a
    jr Jump_05F_74AA

Jump_05F_74A5::
    ld a, $80
    ld [wObject5], a

Jump_05F_74AA::
    ld a, [wScriptParam1]
    sra a
    sra a
    sra a
    sra a
    cp a, $30
    ret c
    xor a, a
    ld [wObject5], a
    ld a, $30
    ld [wObject5 + $5], a
    xor a, a
    ld [wScriptParam0], a
    ld [wScriptParam1], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; entry 11 of the `rst $00` table in RunWC92DStep_7363
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: hTemp0, wStepPtrLo, wStepPtrHi, wScriptParam0, wScriptParam1
; points at: wScriptSubStep
RunWC92DStep_7363_Case0B::
Jump_05F_74CD:: ; address name
    farcall CycleWC949Down
    ld a, $01
    ldh [hTemp0], a
    farcall DrawAnimatedMetaSprite1B
    ld de, wObject5 + $5
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    call AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    bit 0, a
    jr nz, Jump_05F_74F6
    ld hl, wObject5 + $5
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
    ld hl, wScriptSubStep
    inc [hl]
    ret

; entry 10 of the `rst $00` table in RunWC92DStep_7363
; no direct call (reached through a table, a jump or a vector)
; reads: wRandomLo, wScriptParam0
; writes: wObject5, wScriptParam0
; points at: wScriptSubStep
RunWC92DStep_7363_Case0A::
Jump_05F_750C:: ; address name
    call NextTableByte
    ld a, [wRandomLo]
    and a, $03
    jr z, RunWC92DStep_7363_Case0A
    dec a
    dec a
    add a, $40
    ld [wObject5 + $4], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $B4
    ret nz
    ld a, $40
    ld [wObject5 + $4], a
    ld a, $72
    call QueueSoundEffect
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in RunWC92DStep_7363
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptSubStep
; points at: wScriptSubStep
RunWC92DStep_7363_Case09::
Jump_05F_753A:: ; address name
    xor a, a
    call RunMessageBoxCarryWhenIdle_Bank5F
    ret nc
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ld de, $00D1
    call TestFlagBit
    ret nc
    ld a, $11
    ld [wScriptSubStep], a
    ret

; entry 8 of the `rst $00` table in RunWC92DStep_7363
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: hTemp0, wStepPtrLo, wStepPtrHi, wScriptParam0
; points at: wScriptSubStep
RunWC92DStep_7363_Case08::
Jump_05F_7554:: ; address name
    farcall CycleWC949Down
    ld a, $01
    ldh [hTemp0], a
    farcall DrawAnimatedMetaSprite1B
    ld de, wObject5 + $5
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    call AddStepDeltaToPointedByte
    ld hl, wObject5 + $4
    dec [hl]
    ld hl, wObject5 + $5
    inc [hl]
    ld a, [wScriptParam0]
    inc a
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    ld a, $02
    call StartMessageFromTable7787
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in RunWC92DStep_7363
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wSpriteSlots
; writes: hTemp0, wStepPtrLo, wStepPtrHi, wScriptParam0, wSpriteSlots
; points at: wScriptSubStep
RunWC92DStep_7363_Case07::
Jump_05F_7593:: ; address name
    farcall CycleWC949Down
    ld a, $01
    ldh [hTemp0], a
    farcall DrawAnimatedMetaSprite1B
    ld de, wSpriteSlots + $C
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    call AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and a, $01
    jr nz, Jump_05F_75C3
    ld a, [wSpriteSlots + $B]
    dec a
    ld [wSpriteSlots + $B], a

Jump_05F_75C3::
    ld a, [wScriptParam0]
    cp a, $20
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in RunWC92DStep_7363
; no direct call (reached through a table, a jump or a vector)
; writes: wSpriteSlots
; points at: wScriptSubStep
RunWC92DStep_7363_Case06::
Jump_05F_75D2:: ; address name
    xor a, a
    call RunMessageBoxCarryWhenIdle_Bank5F
    ret nc
    ld de, Data_07D_41E1
    ld b, $7D
    ld hl, vTiles0 + $500
    call DecompressToVRAM
    ld a, $02
    ld [wSpriteSlots + $2], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in RunWC92DStep_7363
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wStepPtrLo, wStepPtrHi, wScriptParam0
; points at: wScriptSubStep
RunWC92DStep_7363_Case05::
Jump_05F_75EC:: ; address name
    ld de, wObject5 + $5
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    call AddStepDeltaToPointedByte
    ld hl, wObject5 + $5
    dec [hl]
    ld a, [wScriptParam0]
    inc a
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    ld a, $01
    call StartMessageFromTable7787
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in RunWC92DStep_7363
; no direct call (reached through a table, a jump or a vector)
; reads: wPartyCount
; writes: wObject5, wScriptTemp4, wPartyCount
; points at: wScriptSubStep
RunWC92DStep_7363_Case04::
Jump_05F_7617:: ; address name
    xor a, a
    call RunMessageBoxCarryWhenIdle_Bank5F
    ret nc
    ld a, $80
    ld [wObject5], a
    ld a, [wPartyCount]
    ld [wScriptTemp4], a
    ld a, $01
    ld [wPartyCount], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in RunWC92DStep_7363
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wScriptParam0, hFieldDrawFlags, wOBJPaletteUploadRequest
; points at: wScriptSubStep
RunWC92DStep_7363_Case03::
Jump_05F_7631:: ; address name
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_05F_7646
    inc a
    ld [wScriptParam0], a
    ld a, $0E
    ldh [hFieldDrawFlags], a
    farcall FullyHealParty
    ret

Jump_05F_7646::
    farcall MoveIncapacitatedPartyMembersBack
    farcall MoveIncapacitatedPartyMembersBack
    call LoadRecordListNameTiles
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    xor a, a
    ldh [hFieldDrawFlags], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunWC92DStep_7363
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wIsCGB
; writes: wBGPaletteUploadRequest, wScriptParam0
; points at: wDMGPaletteBGP, wBGPaletteCopy, wBGPaletteBuffer, wScriptSubStep
RunWC92DStep_7363_Case02::
Jump_05F_766C:: ; address name
    ld a, [wScriptParam0]
    srl a
    srl a
    and a, $01
    jr z, Jump_05F_7697
    ld hl, wDMGPaletteBGP
    ld a, $D2
    ld [hl+], a
    ld a, $D2
    ld [hl+], a
    ld a, $E2
    ld [hl], a
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_05F_76BE
    ld hl, wBGPaletteCopy
    ld de, wBGPaletteBuffer
    ld bc, $0040
    call CopyBytes
    jr Jump_05F_76B9

Jump_05F_7697::
    ld hl, wDMGPaletteBGP
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
    ld hl, wBGPaletteCopy
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
    ld [wBGPaletteUploadRequest], a

Jump_05F_76BE::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $1E
    ret nz
    ld a, $00
    call StartMessageFromTable7787
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunWC92DStep_7363
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: hPlayerFacing, wSpriteSlots
; points at: wBGPaletteBuffer, wBGPaletteCopy, wScriptSubStep
RunWC92DStep_7363_Case01::
Jump_05F_76D6:: ; address name
    ld a, $03
    ldh [hPlayerFacing], a
    ld a, $01
    ld [wSpriteSlots + $7], a
    xor a, a
    call RunMessageBoxCarryWhenIdle_Bank5F
    ret nc
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_05F_76F6
    ld hl, wBGPaletteBuffer
    ld de, wBGPaletteCopy
    ld bc, $0040
    call CopyBytes

Jump_05F_76F6::
    ld a, $7A
    call QueueSoundEffect
    ld hl, wScriptSubStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in RunWC92DStep_7363
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0, wScriptMsgSelect, wObject5
; points at: wScriptSubStep
RunWC92DStep_7363_Case00::
Jump_05F_7700:: ; address name
    ld a, $01
    ldh [hTemp0], a
    farcall LoadSpriteGraphics7E5595ToTiles0
    ld de, $0021
    call TestFlagBit
    jr c, Jump_05F_771D
    ld a, $00
    ld [wScriptMsgSelect], a
    ld a, $03
    ldh [hTemp0], a
    jr Jump_05F_774C

Jump_05F_771D::
    ld de, $0022
    call TestFlagBit
    jr c, Jump_05F_7730
    ld a, $01
    ld [wScriptMsgSelect], a
    ld a, $08
    ldh [hTemp0], a
    jr Jump_05F_774C

Jump_05F_7730::
    ld de, $0023
    call TestFlagBit
    jr c, Jump_05F_7743
    ld a, $02
    ld [wScriptMsgSelect], a
    ld a, $0A
    ldh [hTemp0], a
    jr Jump_05F_774C

Jump_05F_7743::
    ld a, $03
    ld [wScriptMsgSelect], a
    ld a, $0F
    ldh [hTemp0], a

Jump_05F_774C::
    farcall RunFieldCommandHFFC6
    ld a, $50
    ld [wObject5 + $4], a
    ld a, $30
    ld [wObject5 + $5], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; starts the message whose index and group are at Data_05F_7787 + 2 * A + 16 * wC92E (wMessageState = 0) (E-0124)
; 7 call sites from 7 routines (e.g. RunWC92DStep_7363_Case0F, RunWC92DStep_7363_Case0D, RunWC92DStep_7363_Case08, RunWC92DStep_7363_Case05, ...)
; reads: wScriptMsgSelect
; writes: wMessageIndex, wMessageGroup, wMessageState
StartMessageFromTable7787::
Func_05F_7761:: ; address name
    sla a
    ld de, Data_05F_7787
    add a, e
    ld e, a
    jr nc, Jump_05F_776B
    inc d

Jump_05F_776B::
    ld a, [wScriptMsgSelect]
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
; 5 call sites from 5 routines (e.g. RunWC92DStep_7363_Case0E, RunWC92DStep_7363_Case09, RunWC92DStep_7363_Case06, RunWC92DStep_7363_Case04, ...)
; reads: wMessageState
; writes: wStepPtrLo
RunMessageBoxCarryWhenIdle_Bank5F::
Func_05F_77C7:: ; address name
    ld [wStepPtrLo], a
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
; reads: wFieldActionRequest, hPlayerStateFlags, wScriptParam1, wScriptParam0, wJoypadHeld
; writes: wJoypadHeld, wJoypadPressed, wScriptStartRequest, wScriptParam1
ScriptCommand05_Run::
Func_05F_787C:: ; address name
    xor a, a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    ldh a, [hPlayerStateFlags]
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
; points at: hPlayerY
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
    ld de, wFollowerRecords + $2
    add a, e
    ld e, a
    jr nc, Jump_05F_7925
    inc d

Jump_05F_7925::
    jr Jump_05F_7933

Jump_05F_7927::
    and a, $7F
    swap a
    ld de, wSpriteSlots + $C
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
; reads: wScriptParam0, wScriptParam1, wMessageIndex, wMessageGroup, wInventory, wGameFlags836, hTemp0
; writes: wScriptParam0, wScriptParam1, wGameFlags836
; points at: wScriptStep, wScriptParam0, wInventory
ScriptCommand0A_Run_Case00::
Jump_05F_7977:: ; address name
    ld a, [wScriptParam0]
    cp a, $03
    jr z, Jump_05F_7987
    ld a, [wScriptParam1]
    ld de, wTextBuf2 + $2
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
    ld a, [wInventory + $17]
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
    ld a, [wGameFlags836]
    set 6, a
    ld [wGameFlags836], a

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
    farcall GenerateNewKeyEntry
    ldh a, [hTemp0]
    or a, a
    jr z, Jump_05F_79E8
    jr Jump_05F_79D8

; entry 1 of the `rst $00` table in ScriptCommand0A_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1, hPlayerY
; writes: wTextWindowState, wTextWindowStep, hSpriteWindowClipMode
; points at: wScriptStep
ScriptCommand0A_Run_Case01::
Jump_05F_7A02:: ; address name
    ld a, [wScriptParam1]
    bit 7, a
    jr nz, Jump_05F_7A3D
    farcall SetBit1OfPlayerAndObjectFlags
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    call FillTilesFromRequest
    ld a, $69
    call QueueSoundEffect
    ld a, $01
    ld [wTextWindowState], a
    ld a, $00
    ld [wTextWindowStep], a
    ld a, $02
    ldh [hSpriteWindowClipMode], a
    ldh a, [hPlayerY]
    cp a, $48
    jr c, Jump_05F_7A3D
    ld a, $81
    ld [wTextWindowState], a
    ld a, $01
    ldh [hSpriteWindowClipMode], a

Jump_05F_7A3D::
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in ScriptCommand0A_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1, wTextWindowState, wScriptParam0
; points at: wScriptStep
ScriptCommand0A_Run_Case02::
Jump_05F_7A42:: ; address name
    ld a, [wScriptParam1]
    bit 7, a
    jr nz, Jump_05F_7A4F
    ld a, [wTextWindowState]
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
; reads: wTextFlags, wScriptParam1, hPlayerY
; writes: hSpriteWindowClipMode, wTextWindowState, wTextWindowStep
; points at: wScriptStep
ScriptCommand0A_Run_Case03::
Jump_05F_7A5D:: ; address name
    ld a, [wTextFlags]
    bit 0, a
    ret nz
    ld a, [wScriptParam1]
    bit 6, a
    jr nz, Jump_05F_7A87
    ld a, $69
    call QueueSoundEffect
    xor a, a
    ldh [hSpriteWindowClipMode], a
    ld a, $02
    ld [wTextWindowState], a
    ld a, $00
    ld [wTextWindowStep], a
    ldh a, [hPlayerY]
    cp a, $48
    jr c, Jump_05F_7A87
    ld a, $82
    ld [wTextWindowState], a

Jump_05F_7A87::
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in ScriptCommand0A_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wTextWindowState
; writes: wScriptCommandType, wScriptRunning, wModeState
ScriptCommand0A_Run_Case04::
Jump_05F_7A8C:: ; address name
    ld a, [wTextWindowState]
    and a, $03
    ret nz
    farcall ApplyMapScreenFlagEvents
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
; writes: hTemp0, wScriptCommandType, wScriptStartRequest
; points at: wScriptStep
ScriptCommand0E_Run::
Func_05F_7AB2:: ; address name
    ld a, [wScriptStep]
    or a, a
    jr nz, Jump_05F_7AC8
    ld a, [wScriptParam0]
    ldh [hTemp0], a
    farcall StartScriptedEncounterHFFC6
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
