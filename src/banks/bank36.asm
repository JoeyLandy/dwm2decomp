SECTION "Bank 36", ROMX[$4000], BANK[$36]
    db $36

; jumps through a 16-entry table indexed by wBattleResolveStep (wCFCB): one step of resolving a battle action; the steps advance wBattleResolveStep and use wBattleSubStep (wCFCC) and wBattleSubStep2 (wCFCD) for nested state
; 2 call sites from 2 routines (e.g. RunBattleActions_Case01, RunBattleStep4_Case01)
; reads: wBattleResolveStep
RunBattleResolveStep::
Func_036_4001:: ; address name
    ld a, [wBattleResolveStep]
    rst $00
    dw ResolveStepBegin
    dw ResolveStepTargetAndSubEffects
    dw ResolveStepCallEffect82
    dw ResolveStepFlagBit7Effect
    dw ResolveStepEffectChecks
    dw ResolveStepChanceRoll
    dw ResolveStepActionEffect
    dw ResolveStepComputeDamage
    dw ResolveStepSoundWaitAndMessage
    dw ResolveStepMessage13AndSound
    dw ResolveStepDamageMessage
    dw ResolveStepBranchOnAction
    dw ResolveStepApplyDamage
    dw ResolveStepDefeat
    dw ResolveStep0ECallEffect
    dw ResolveStepAdvanceSubPhase

; resolve step $00: advances wBattleResolveStep and clears wBattleSubStep. When wDABD is zero, wCFF3 bit 7 is set, the target is present and bit 5 of the target's wD854 byte is set, it farcalls RunBattleResolveStep_Case00_Sub01 (not read), stores the result in wC971 when it is not $FF, shows message $33 and returns; otherwise it clears that bit and continues into ResolveStepTargetAndSubEffects (E-0053)
; no direct call (reached through a table, a jump or a vector)
; reads: wDABD, wCFF3, wBattleTarget, wBattleSubStep
; writes: wBattleSubStep, wC971
; points at: wBattleResolveStep, wD854
ResolveStepBegin::
Jump_036_4025:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    xor a, a
    ld [wBattleSubStep], a
    ld a, [wDABD]
    or a, a
    jr nz, Jump_036_4069
    ld a, [wCFF3]
    bit 7, a
    jr z, Jump_036_4069
    ld a, [wBattleTarget]
    call CheckSlotStatusBlockWide_Bank36
    jr c, Jump_036_4069
    ld a, [wBattleTarget]
    ld hl, wD854
    add a, a
    add_a_to_hl
    bit 5, [hl]
    jr z, Jump_036_4069
    farcall ResolveStepBegin_Sub01
    ld a, c
    cp a, $FF
    jr z, Jump_036_4069
    ld [wC971], a
    ld d, $33
    farcall ShowBattleTextCategory0
    ret

Jump_036_4069::
    ld a, [wBattleTarget]
    ld hl, wD854
    add a, a
    add_a_to_hl
    res 5, [hl]

; resolve step $01: dispatches on wBattleSubStep to two cases. Case 0 (RunBattleResolveStep_Table2_Case00) may redirect wBattleTarget and shows message $CB, then selects one of four sub-effects by wCFF3 bits 7, 4 and 6 (RunBattleResolveStep_Table2_Case00_Sub01-Sub04, not read); case 1 (36:4127) follows (E-0053)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleSubStep
ResolveStepTargetAndSubEffects::
Jump_036_4077:: ; address name
    ld a, [wBattleSubStep]
    rst $00
    dw RunBattleResolveStep_Table2_Case00
    dw RunBattleResolveStep_Table2_Case01

; entry 0 of the `rst $00` table in RunBattleResolveStep
; no direct call (reached through a table, a jump or a vector)
; reads: wDABD, wCFF2, wCFF3, wBattleTarget, wBattleActor, wDAC0
; writes: wC981, wDAB2, wBattleTarget, wBattleSubStep, wDABE, wDAC0
; points at: wD80A, wBattleTargetChoice, wBattleSubStep, wBattleResolveStep, wD80E
RunBattleResolveStep_Table2_Case00::
Jump_036_407F:: ; address name
    xor a, a
    ld [wC981], a
    ld a, [wDABD]
    or a, a
    jp nz, Jump_036_411F
    ld a, [wCFF2]
    cp a, $40
    jp z, RunBattleResolveStep_Table2_Case01
    and a, $F0
    cp a, $20
    jp z, RunBattleResolveStep_Table2_Case01
    ld a, [wCFF3]
    bit 4, a
    jr z, Jump_036_40ED
    ld a, [wBattleTarget]
    and a, $04
    ld c, a
    rrca
    rrca
    and a, $01
    ld hl, wD80A
    add_a_to_hl
    bit 6, [hl]
    jr z, Jump_036_40ED
    ld a, l
    add a, $5A
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl]
    rrca
    rrca
    and a, $03
    or a, c
    ld c, a
    call CheckSlotStatusBlockWide_Bank36
    jr c, Jump_036_40ED
    ld a, $01
    ld [wDAB2], a
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld [hl], c
    ld a, c
    ld [wBattleTarget], a
    ld d, $CB
    farcall ShowBattleText
    ld hl, wBattleSubStep
    inc [hl]
    ret

Jump_036_40ED::
    ld hl, wBattleSubStep
    inc [hl]
    ld a, [wCFF3]
    bit 7, a
    jr nz, Jump_036_4102
    bit 4, a
    jr nz, Jump_036_4109
    bit 6, a
    jr nz, Jump_036_4110
    jr Jump_036_4117

Jump_036_4102::
    call RunBattleResolveStep_Table2_Case00_Sub01
    jr c, Jump_036_411E
    jr Jump_036_411C

Jump_036_4109::
    call RunBattleResolveStep_Table2_Case00_Sub02
    jr c, Jump_036_411E
    jr Jump_036_411C

Jump_036_4110::
    call RunBattleResolveStep_Table2_Case00_Sub03
    jr c, Jump_036_411E
    jr Jump_036_411C

Jump_036_4117::
    call RunBattleResolveStep_Table2_Case00_Sub04
    jr c, Jump_036_411E

Jump_036_411C::
    jr RunBattleResolveStep_Table2_Case01

Jump_036_411E::
    ret

Jump_036_411F::
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wBattleResolveStep
    inc [hl]

; entry 1 of the `rst $00` table in RunBattleResolveStep
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wCFF3, wDAC0
; writes: wBattleSubStep, wDABE, wDAC0
; points at: wBattleResolveStep, wD80E
RunBattleResolveStep_Table2_Case01::
Jump_036_4127:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    xor a, a
    ld [wBattleSubStep], a
    ld a, [wBattleTarget]
    ld hl, wD80E
    call AddAx9ToHL
    bit 3, [hl]
    ret z
    ld a, [wCFF3]
    bit 3, a
    ret z
    res 3, [hl]
    ld d, $E9
    call TargetOnLocalSide_Bank36
    jr c, Jump_036_414B
    inc d

Jump_036_414B::
    farcall ShowBattleText
    ld a, $03
    ld [wDABE], a
    ld a, [wDAC0]
    res 4, a
    ld [wDAC0], a
    call SetSubPhase2AndRestartResolve
    ret

; only called from RunBattleResolveStep_Table2_Case00 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleResolveStep_Table2_Case00)
; reads: wBattleTarget, wCFF5, wBattleActionId, wBattleActor
; writes: wDAD1, wBattleTarget
; points at: wD812, wD854, wD810, wBattleTargetChoice, wDABF
RunBattleResolveStep_Table2_Case00_Sub01::
Func_036_4162:: ; address name
    ld a, [wBattleTarget]
    call SlotHasStatus3Or4Bits_Bank36
    jr z, Jump_036_4191
    ld a, [wCFF5]
    bit 5, a
    jr z, Jump_036_4191
    ld a, [wBattleActionId]
    cp a, $4E
    jr z, Jump_036_4189
    cp a, $4F
    jr z, Jump_036_4189
    ld a, $84
    call QueueSoundEffect
    call SetSubPhase2AndRestartResolve
    ld d, $68
    jp Jump_036_4317

Jump_036_4189::
    call SetSubPhase2AndRestartResolve
    ld d, $69
    jp Jump_036_4317

Jump_036_4191::
    call Func_036_42D3
    jp nc, Jump_036_4317
    ld a, [wBattleActionId]
    cp a, $4E
    jr z, Jump_036_41A2
    cp a, $4F
    jr nz, Jump_036_41AF

Jump_036_41A2::
    ld a, [wBattleActor]
    ld hl, wD812
    call AddAx9ToHL
    bit 0, [hl]
    jr z, Jump_036_421B

Jump_036_41AF::
    ld a, [wBattleTarget]
    call CheckSlotStatusBlockWide_Bank36
    jr c, Jump_036_421B
    ld a, [wBattleTarget]
    ld hl, wD854
    call AddDoubleAToHL_Bank36
    bit 5, [hl]
    jr nz, Jump_036_41D1
    ld a, [wBattleTarget]
    ld hl, wD812
    call AddAx9ToHL
    bit 5, [hl]
    jr z, Jump_036_421B

Jump_036_41D1::
    call RunBattleResolveStep_Table2_Case00_Sub01_Sub01
    jr c, Jump_036_4211
    push af
    ld a, [wBattleActionId]
    cp a, $CC
    jr nz, Jump_036_41EB
    ld a, [wBattleActor]
    ld hl, wD810
    call AddAx9ToHL
    ld a, [hl]
    and a, $F3
    ld [hl], a

Jump_036_41EB::
    pop af
    push af
    ld d, $C8
    farcall ShowBattleText
    ld a, [wBattleTarget]
    ld [wDAD1], a
    pop af
    ld [wBattleTarget], a
    ld b, a
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    call AddDoubleAToHL_Bank36
    ld [hl], b
    ld hl, wDABF
    set 0, [hl]
    scf
    ret

Jump_036_4211::
    ld d, $C9
    farcall ShowBattleText
    scf
    ret

Jump_036_421B::
    xor a, a
    ret

; only called from RunBattleResolveStep_Table2_Case00 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleResolveStep_Table2_Case00)
; reads: wBattleTarget, wBattleActor
; writes: wDABE, wC981
; points at: wD80E
RunBattleResolveStep_Table2_Case00_Sub02::
Func_036_421D:: ; address name
    call Func_036_42D3
    jp nc, Jump_036_4317
    ld a, [wBattleTarget]
    ld hl, wD80E
    call AddAx9ToHL
    bit 6, [hl]
    jr z, Jump_036_4253
    res 6, [hl]
    ld a, $02
    ld [wDABE], a
    ld d, $C7
    farcall ShowBattleText
    ld a, $01
    ld [wC981], a
    ld a, [wBattleActor]
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_036_4255
    ld d, $01
    call Func_036_4EB1
    scf
    ret

Jump_036_4253::
    xor a, a
    ret

Jump_036_4255::
    call SetSubPhase2AndRestartResolve
    scf
    ret

; only called from RunBattleResolveStep_Table2_Case00 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleResolveStep_Table2_Case00)
; reads: wBattleTarget, wCFF5, wBattleActor
; writes: wDABE, wC981
; points at: wD80E
RunBattleResolveStep_Table2_Case00_Sub03::
Func_036_425A:: ; address name
    call Func_036_42D3
    jp nc, Jump_036_4317
    ld a, [wBattleTarget]
    ld hl, wD80E
    call AddAx9ToHL
    ld a, [hl]
    and a, $22
    jr z, Jump_036_42A3
    ld a, [wCFF5]
    bit 7, a
    jr z, Jump_036_42A3
    bit 1, [hl]
    jr nz, Jump_036_4280
    res 5, [hl]
    ld a, $01
    ld [wDABE], a

Jump_036_4280::
    call TargetOnLocalSide_Bank36
    ld d, $C5
    jr c, Jump_036_4289
    ld d, $C6

Jump_036_4289::
    farcall ShowBattleText
    ld a, $01
    ld [wC981], a
    ld a, [wBattleActor]
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_036_42A5
    ld d, $04
    call Func_036_4EB1
    scf
    ret

Jump_036_42A3::
    xor a, a
    ret

Jump_036_42A5::
    call SetSubPhase2AndRestartResolve
    scf
    ret

; only called from RunBattleResolveStep_Table2_Case00 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleResolveStep_Table2_Case00)
; reads: wBattleTarget, wCFF5
RunBattleResolveStep_Table2_Case00_Sub04::
Func_036_42AA:: ; address name
    ld a, [wBattleTarget]
    call SlotHasStatus3Or4Bits_Bank36
    jr z, Jump_036_42CB
    ld a, [wCFF5]
    bit 5, a
    jr z, Jump_036_42CB
    ld a, $84
    call QueueSoundEffect
    ld d, $68
    farcall ShowBattleText
    call SetSubPhase2AndRestartResolve
    scf
    ret

Jump_036_42CB::
    call Func_036_42D3
    jp nc, Jump_036_4317
    xor a, a
    ret

; 4 call sites from 4 routines (e.g. RunBattleResolveStep_Table2_Case00_Sub04, RunBattleResolveStep_Table2_Case00_Sub03, RunBattleResolveStep_Table2_Case00_Sub02, RunBattleResolveStep_Table2_Case00_Sub01)
; reads: wBattleTarget, wCFF4, wBattleActor
; writes: wDAD1, wBattleTarget, wC981
; points at: wD812, wBattleTargetChoice, wDABF
Func_036_42D3::
    ld a, [wBattleTarget]
    ld hl, wD812
    call AddAx9ToHL
    bit 4, [hl]
    jr z, Jump_036_4315
    ld a, [wCFF4]
    bit 0, a
    jr z, Jump_036_4315
    inc hl
    ld a, [hl]
    swap a
    and a, $0F
    ld c, a
    call CheckSlotStatusBlockWide_Bank36
    jr c, Jump_036_4315
    ld a, [wBattleTarget]
    ld [wDAD1], a
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    call AddDoubleAToHL_Bank36
    ld [hl], c
    ld a, c
    ld [wBattleTarget], a
    ld a, $01
    ld [wC981], a
    ld hl, wDABF
    set 1, [hl]
    ld d, $CA
    xor a, a
    ret

Jump_036_4315::
    scf
    ret

Jump_036_4317::
    farcall ShowBattleText
    scf
    ret

; resolve step $02: advances wBattleResolveStep; when wDABD is non-zero and wDAB2 is zero and ActionIs91AndStatusBit6Set is not set, it stores $82 in wDAD2 and farcalls 3A:4001. When wDABD is zero or wDAB2 is non-zero it continues as ResolveStepFlagBit7Effect; when ActionIs91AndStatusBit6Set is set it returns (E-0050)
; no direct call (reached through a table, a jump or a vector)
; reads: wDABD, wDAB2, wBattleTarget, wCFF4, wBattleActionId, wBattleActor, wDAC0, wCFF3, ...
; writes: wDAD2, wDAC0
; points at: wBattleResolveStep, wD854, wD810, wD811, wD80F, wD80D, wBattleStatus, wBattleAGL
ResolveStepCallEffect82::
Jump_036_431F:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wDABD]
    or a, a
    jr z, ResolveStepFlagBit7Effect
    ld a, [wDAB2]
    or a, a
    jr nz, ResolveStepFlagBit7Effect
    call ActionIs91AndStatusBit6Set
    ret z
    ld a, $82
    ld [wDAD2], a
    farcall SelectEffectByWDAD2Flags
    ret

; Z set when wBattleActionId = $91 and bit 6 of the actor's status byte 3 (wD80F + 9 * actor) is set; Z clear otherwise (A is $40 or 0 for $91, the comparison result otherwise). Used by RunBattleResolveStep_Case02 (E-0050)
; 1 call site from 1 routine (e.g. ResolveStepCallEffect82)
; reads: wBattleActionId, wBattleActor
; points at: wD80F
ActionIs91AndStatusBit6Set::
Func_036_433F:: ; address name
    ld a, [wBattleActionId]
    cp a, $91
    jr z, Jump_036_4347
    ret

Jump_036_4347::
    ld a, [wBattleActor]
    ld hl, wD80F
    call AddAx9ToHL
    ld a, [hl]
    and a, $40
    xor a, $40
    ret

; resolve step $03: advances wBattleResolveStep. When wBattleTarget is present (Func_036_7F3C does not set carry), wCFF4 bit 6 is set, and the target's wD854 byte has bit 7 set, it farcalls 3A:6EE5 with D = $35, calls Func_036_4FD1 and queues sound $84; otherwise it goes on to case 4 (E-0050)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wCFF4, wBattleActionId, wBattleActor, wDAC0, wCFF3, wC5E7
; writes: wDAC0
; points at: wBattleResolveStep, wD854, wD810, wD811, wD80F, wD80D, wBattleStatus, wBattleAGL
ResolveStepFlagBit7Effect::
Jump_036_4356:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wBattleTarget]
    call CheckSlotStatusBlockWide_Bank36
    jr c, ResolveStepEffectChecks
    ld a, [wCFF4]
    bit 6, a
    jr z, ResolveStepEffectChecks
    ld a, [wBattleTarget]
    ld hl, wD854
    add a, a
    add_a_to_hl
    bit 7, [hl]
    jr z, ResolveStepEffectChecks
    ld d, $35
    farcall ShowBattleTextCategory0
    call SetSubPhase2AndRestartResolve
    ld a, $84
    call QueueSoundEffect
    ret

; resolve step $04: runs RunBattleResolveStep_Case04_Sub01 (returns on action $35) and, when the target is present, advances the step. Then it selects one of several effects from wCFF4 bits 1, 6 and wCFF3 bits 7 and 0 and the status bytes of the actor and target: messages $66, $68 and $D2 (with sound $84) and calls to RunBattleResolveStep_Case04_Sub03 when the roll is below a threshold. The threshold for the roll comes from the actor's AGL minus the target's AGL, in bands of $320, $258, $190, $C8 and $64 (values $80 down to $01); the roll is AdvanceRandom's wC5E7 (E-0054)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wCFF4, wBattleActionId, wBattleActor, wDAC0, wCFF3, wC5E7
; writes: wDAC0
; points at: wBattleResolveStep, wD810, wD811, wD80F, wD80D, wD854, wBattleStatus, wBattleAGL
ResolveStepEffectChecks::
Jump_036_438A:: ; address name
    call ResolveStepEffectChecks_Sub01
    jr z, Jump_036_439B
    ld a, [wBattleTarget]
    call CarryUnlessWDA63SlotEmpty
    jr nc, Jump_036_439B
    call SetSubPhase3AndRestartResolve
    ret

Jump_036_439B::
    ld hl, wBattleResolveStep
    inc [hl]
    call ResolveStepEffectChecks_Sub02
    ret z
    ld a, [wCFF4]
    bit 1, a
    jr z, Jump_036_43D8
    ld a, [wBattleActionId]
    cp a, $CC
    jr nz, Jump_036_43BF
    ld a, [wBattleActor]
    ld hl, wD810
    call AddAx9ToHL
    ld a, [hl]
    and a, $0C
    jr z, Jump_036_43D8

Jump_036_43BF::
    ld a, [wBattleTarget]
    ld hl, wD811
    call AddAx9ToHL
    ld a, [hl]
    and a, $C0
    jr z, Jump_036_43D8
    ld d, $66
    farcall ShowBattleText
    jp Jump_036_4543

Jump_036_43D8::
    ld a, [wCFF3]
    bit 7, a
    jr z, Jump_036_4431
    ld a, [wBattleTarget]
    ld hl, wD810
    call AddAx9ToHL
    ld a, [hl]
    and a, $0C
    jr z, Jump_036_4416
    cp a, $0C
    jr nz, Jump_036_4406
    ld a, [wBattleActionId]
    cp a, $CC
    jr nz, Jump_036_4406
    ld a, [wBattleActor]
    ld hl, wD810
    call AddAx9ToHL
    ld a, [hl]
    and a, $0C
    jr z, Jump_036_4416

Jump_036_4406::
    ld a, $84
    call QueueSoundEffect
    ld d, $68
    farcall ShowBattleText
    jp Jump_036_4543

Jump_036_4416::
    ld a, [wBattleTarget]
    ld hl, wD80F
    call AddAx9ToHL
    ld a, [hl]
    and a, $C0
    jr z, Jump_036_4431
    cp a, $C0
    jr nz, Jump_036_4406
    ld a, [wBattleActionId]
    cp a, $CC
    jr z, Jump_036_4431
    jr Jump_036_4406

Jump_036_4431::
    ld a, [wCFF3]
    bit 0, a
    jr z, Jump_036_447F
    ld a, [wBattleActor]
    ld hl, wD80D
    call AddAx9ToHL
    bit 1, [hl]
    jr z, Jump_036_4451
    call AdvanceRandom
    ld a, [wC5E7]
    cp a, $A0
    jr nc, Jump_036_4451
    jr Jump_036_4469

Jump_036_4451::
    ld a, [wBattleActor]
    ld hl, wD811
    call AddAx9ToHL
    ld a, [hl]
    and a, $03
    jr z, Jump_036_447F
    call AdvanceRandom
    ld a, [wC5E7]
    cp a, $60
    jr nc, Jump_036_447F

Jump_036_4469::
    ld a, [wBattleActor]
    ld hl, wD854
    add a, a
    add_a_to_hl
    bit 2, [hl]
    jr nz, Jump_036_447F
    call ResolveStepEffectChecks_Sub03
    jp Jump_036_4543

Jump_036_447F::
    ld a, [wCFF4]
    bit 6, a
    jp z, Jump_036_4542
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    and a, $D0
    jp nz, Jump_036_4542
    ld bc, $0004
    add hl, bc
    ld a, [hl]
    and a, $03
    jp nz, Jump_036_4542
    inc hl
    ld a, [hl]
    and a, $30
    jp nz, Jump_036_4542
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    and a, $03
    jp nz, Jump_036_4542
    call AdvanceRandom
    ld a, [wBattleTarget]
    ld hl, wD811
    call AddAx9ToHL
    ld a, [hl]
    and a, $0C
    jr z, Jump_036_44C8
    ld a, [wC5E7]
    and a, $01
    jr z, Jump_036_4533

Jump_036_44C8::
    ld a, [wBattleActor]
    ld hl, wBattleAGL
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld a, [wBattleTarget]
    ld hl, wBattleAGL
    call ReadBattleWordFromArray
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    jr c, Jump_036_452B
    or a, l
    jr z, Jump_036_452B
    ld bc, $0320
    call CompareHLToBC
    jr nc, Jump_036_4517
    ld bc, $0258
    call CompareHLToBC
    jr nc, Jump_036_451B
    ld bc, $0190
    call CompareHLToBC
    jr nc, Jump_036_451F
    ld bc, $00C8
    call CompareHLToBC
    jr nc, Jump_036_4523
    ld bc, $0064
    call CompareHLToBC
    jr nc, Jump_036_4527
    ld b, $02
    jr Jump_036_452D

Jump_036_4517::
    ld b, $80
    jr Jump_036_452D

Jump_036_451B::
    ld b, $20
    jr Jump_036_452D

Jump_036_451F::
    ld b, $10
    jr Jump_036_452D

Jump_036_4523::
    ld b, $08
    jr Jump_036_452D

Jump_036_4527::
    ld b, $04
    jr Jump_036_452D

Jump_036_452B::
    ld b, $01

Jump_036_452D::
    ld a, [wC5E7]
    cp a, b
    jr nc, Jump_036_4542

Jump_036_4533::
    ld d, $D2
    farcall ShowBattleText
    ld a, $84
    call QueueSoundEffect
    jr Jump_036_4543

Jump_036_4542::
    ret

Jump_036_4543::
    ld a, [wDAC0]
    res 4, a
    ld [wDAC0], a
    call SetSubPhase2AndRestartResolve
    ret

; only called from ResolveStepEffectChecks (E-0047)
; 1 call site from 1 routine (e.g. ResolveStepEffectChecks)
; reads: wBattleActionId
ResolveStepEffectChecks_Sub01::
Func_036_454F:: ; address name
    ld a, [wBattleActionId]
    cp a, $35
    ret z
    cp a, $16
    ret z
    cp a, $17
    ret z
    cp a, $18
    ret z
    cp a, $1B
    ret z
    cp a, $1C
    ret z
    cp a, $1D
    ret z
    cp a, $1E
    ret z
    cp a, $1F
    ret z
    cp a, $20
    ret z
    cp a, $7B
    ret z
    cp a, $98
    ret z
    cp a, $9A
    ret z
    cp a, $9D
    ret z
    cp a, $BB
    ret z
    cp a, $CE
    ret

; only called from ResolveStepEffectChecks (E-0047)
; 1 call site from 1 routine (e.g. ResolveStepEffectChecks)
; reads: wBattleActionId
ResolveStepEffectChecks_Sub02::
Func_036_4582:: ; address name
    ld a, [wBattleActionId]
    cp a, $6A
    ret z
    cp a, $A0
    ret z
    cp a, $A1
    ret

; resolve step $05: advances wBattleResolveStep. With wCFF4 bits 3-4 both clear it continues into case 6. Bit 4 with the actor's status byte 1 bit 2 set continues into case 6. With wCFF4 bit 3 set and wD854 bit 0 (target) and status byte 1 bit 3 (actor) both clear, it rolls RollWC5E7BelowChance: on success it sets bit 7 of the actor's status byte 2 (wD80E), calls Func_036_7E6C, shows message $9C (carry) or $9D through 3A:7193, queues sound $83 and advances the step again; on failure, or when bit 3 is clear, it clears that bit (E-0052)
; no direct call (reached through a table, a jump or a vector)
; reads: wCFF4, wBattleActor
; points at: wBattleResolveStep, wD80D, wD854, wD80E
ResolveStepChanceRoll::
Jump_036_458E:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wCFF4]
    and a, $18
    jr z, ResolveStepActionEffect
    bit 4, a
    jr z, Jump_036_45AA
    ld a, [wBattleActor]
    ld hl, wD80D
    call AddAx9ToHL
    bit 2, [hl]
    jr nz, ResolveStepActionEffect

Jump_036_45AA::
    ld a, [wCFF4]
    bit 3, a
    jr z, Jump_036_45F7
    ld a, [wBattleActor]
    ld hl, wD854
    call AddDoubleAToHL_Bank36
    bit 0, [hl]
    jr nz, Jump_036_45D3
    ld a, [wBattleActor]
    ld hl, wD80D
    call AddAx9ToHL
    bit 3, [hl]
    jr nz, Jump_036_45D3
    call AdvanceRandom
    call RollWC5E7BelowChance
    jr nc, Jump_036_45F7

Jump_036_45D3::
    ld a, [wBattleActor]
    ld hl, wD80E
    call AddAx9ToHL
    set 7, [hl]
    call ActorOnLocalSide_Bank36
    ld d, $9C
    jr c, Jump_036_45E7
    ld d, $9D

Jump_036_45E7::
    farcall ShowBattleText
    ld a, $83
    call QueueSoundEffect
    ld hl, wBattleResolveStep
    inc [hl]
    ret

Jump_036_45F7::
    ld a, [wBattleActor]
    ld hl, wD80E
    call AddAx9ToHL
    res 7, [hl]
    ret

; resolve step $06: advances wBattleResolveStep, then calls DispatchActionEffectTable for wBattleActionId (E-0053)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleResolveStep
ResolveStepActionEffect::
Jump_036_4603:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    call DispatchActionEffectTable
    ret

; resolve step $07: waits for the sound channels in wDC20 when the actor's wD80E bit 7 is set; advances the step; then works on the damage in wBattleDamageLo/Hi and wD873: doubles it for several status bits (wD80D bit 2, wD810 bits 0 and 4 with wCFF3 and wCFF4), rerolls it from the actor's ATK through Func_036_4930 when wCFF4 bit 3 and wD80E bit 7 are set, adds half again for wD854 bit 6, and halves or doubles it on the target's wD813 and wD812 bits (E-0054)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wSoundChannelSlots, wCFF4, wBattleDamageLo, wD873, wBattleTarget, wCFF3, wBattleActionId
; writes: wBattleDamageLo, wD873
; points at: wD80E, wDC20, wBattleResolveStep, wD80D, wD854, wD813, wD812, wD810
ResolveStepComputeDamage::
Jump_036_460B:: ; address name
    ld a, [wBattleActor]
    ld hl, wD80E
    call AddAx9ToHL
    bit 7, [hl]
    jr z, Jump_036_4622
    ld a, [wSoundChannelSlots]
    ld hl, wDC20
    and a, [hl]
    cp a, $FF
    ret nz

Jump_036_4622::
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wCFF4]
    bit 4, a
    jr z, Jump_036_464D
    ld a, [wBattleActor]
    ld hl, wD80D
    call AddAx9ToHL
    bit 2, [hl]
    jr z, Jump_036_464D
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wD873]
    ld h, a
    add hl, hl
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    jr Jump_036_46C7

Jump_036_464D::
    ld a, [wCFF4]
    bit 3, a
    jr z, Jump_036_4679
    ld a, [wBattleActor]
    ld hl, wD80E
    call AddAx9ToHL
    bit 7, [hl]
    jr z, Jump_036_4679
    res 7, [hl]
    call ResolveStepComputeDamage_Sub02
    ld a, [wBattleActor]
    call GetBattleATK
    call Func_036_4930
    ld a, e
    ld [wBattleDamageLo], a
    ld a, d
    ld [wD873], a
    jr Jump_036_46EB

Jump_036_4679::
    ld a, [wCFF4]
    bit 5, a
    jr z, Jump_036_46A0
    ld a, [wBattleActor]
    ld hl, wD810
    call AddAx9ToHL
    bit 0, [hl]
    jr z, Jump_036_46A0
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wD873]
    ld h, a
    add hl, hl
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    jr Jump_036_46C7

Jump_036_46A0::
    ld a, [wCFF3]
    bit 1, a
    jr z, Jump_036_46C7
    ld a, [wBattleActor]
    ld hl, wD810
    call AddAx9ToHL
    bit 4, [hl]
    jr z, Jump_036_46C7
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wD873]
    ld h, a
    call ResolveStepComputeDamage_Sub01
    ld a, e
    ld [wBattleDamageLo], a
    ld a, d
    ld [wD873], a

Jump_036_46C7::
    ld a, [wBattleActor]
    ld hl, wD854
    call AddDoubleAToHL_Bank36
    bit 6, [hl]
    jr z, Jump_036_46EB
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wD873]
    ld h, a
    ld c, l
    ld b, h
    srl b
    rr c
    add hl, bc
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a

Jump_036_46EB::
    ld a, [wBattleTarget]
    ld hl, wD813
    call AddAx9ToHL
    ld a, [hl]
    and a, $07
    jr z, Jump_036_4742
    and a, $03
    ld c, a
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wD873]
    ld h, a
    jr nz, Jump_036_4713
    ld a, [wCFF3]
    bit 7, a
    jr z, Jump_036_4742

Jump_036_470D::
    srl h
    rr l
    jr Jump_036_4723

Jump_036_4713::
    ld a, [wCFF4]
    bit 7, a
    jr z, Jump_036_4742
    bit 0, c
    jr nz, Jump_036_470D
    ld a, $0A
    call DivideHLByA

Jump_036_4723::
    ld a, [wBattleTarget]
    ld de, wD854
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_036_472F
    inc d

Jump_036_472F::
    ld a, [de]
    bit 1, a
    jr z, Jump_036_4738
    srl h
    rr l

Jump_036_4738::
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    jr Jump_036_4742

Jump_036_4742::
    ld a, [wBattleTarget]
    ld hl, wD812
    call AddAx9ToHL
    bit 2, [hl]
    jr z, Jump_036_4775
    ld a, [wCFF3]
    bit 7, a
    jr z, Jump_036_4775
    ld a, [wBattleActionId]
    cp a, $6F
    jr z, Jump_036_4775
    cp a, $70
    jr z, Jump_036_4775
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wD873]
    ld h, a
    sla l
    rl h
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a

Jump_036_4775::
    ret

; resolve step $08: for action $CD it returns while the sound channels in wDC20 are busy (wSoundChannelSlots and wDC20 not both $FF). Otherwise it advances the step twice, updates bit 4 or 6 of wDAC0 from wBattleDamageLo/Hi and wD873 when wDAC0 bit 5 is set, and for action $CF rewinds the step while wDAC0 bit 4 is set and wDABA is zero. It then stores $40 or $41 in wDAD2, farcalls 3A:4001 and 3A:5762 (E-0053)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActionId, wSoundChannelSlots, wDAC0, wBattleDamageLo, wD873, wDABA
; writes: wDAC0, wDAD2, wDAD3
; points at: wDC20, wBattleResolveStep
ResolveStepSoundWaitAndMessage::
Jump_036_4776:: ; address name
    ld a, [wBattleActionId]
    cp a, $CD
    jr nz, Jump_036_4787
    ld a, [wSoundChannelSlots]
    ld hl, wDC20
    and a, [hl]
    cp a, $FF
    ret nz

Jump_036_4787::
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wDAC0]
    ld b, a
    bit 5, a
    jr z, Jump_036_47B1
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wD873]
    ld h, a
    ld a, h
    or a, l
    jr z, Jump_036_47A9
    set 4, b
    res 6, b
    jr Jump_036_47AD

Jump_036_47A9::
    res 4, b
    set 6, b

Jump_036_47AD::
    ld a, b
    ld [wDAC0], a

Jump_036_47B1::
    ld a, [wBattleActionId]
    cp a, $CF
    jr nz, Jump_036_47C7
    ld a, [wDAC0]
    bit 4, a
    ret z
    ld hl, wBattleResolveStep
    dec [hl]
    ld a, [wDABA]
    or a, a
    ret nz

Jump_036_47C7::
    ld b, $40
    ld a, [wDAC0]
    bit 4, a
    jr z, Jump_036_47D6
    bit 6, a
    jr nz, Jump_036_47D6
    set 0, b

Jump_036_47D6::
    ld a, b
    ld [wDAD2], a
    farcall SelectEffectByWDAD2Flags
    ld a, [wDAC0]
    and a, $10
    or a, $20
    ld [wDAD3], a
    farcall SelectEffectByWDAD3Flags
    ret

; resolve step $09: advances wBattleResolveStep, stores $13 in wDAD2, farcalls 3A:4001 and queues sound effect $85 (E-0053)
; no direct call (reached through a table, a jump or a vector)
; writes: wDAD2
; points at: wBattleResolveStep
ResolveStepMessage13AndSound::
Jump_036_47F1:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, $13
    ld [wDAD2], a
    farcall SelectEffectByWDAD2Flags
    ld a, $85
    call QueueSoundEffect
    ret

; resolve step $0A: advances wBattleResolveStep and, for the actor or target side chosen by wDAC0 bit 4, stores wDAC2 or wDAC3 in wC0A0 and calls Func_036_4991 / Func_036_4A38; the first fight showed the battle text 'took N damage!' (bank $2F, category 1, index 53) at this step
; no direct call (reached through a table, a jump or a vector)
; reads: wDAC0, wDAC2, wBattleActionId, wC0A0, hFFC6, wBattleActor, wBattleTarget, wDAC3, ...
; writes: wC0A0, wBattleActor
; points at: wBattleResolveStep, wC0A0, wBattleMonsterId
ResolveStepDamageMessage::
Jump_036_4806:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wDAC0]
    bit 7, a
    jr z, Jump_036_484E
    bit 4, a
    jr z, Jump_036_4825
    ld a, [wDAC2]
    ld [wC0A0], a
    ld a, [wDAC0]
    bit 3, a
    call nz, ResolveStepDamageMessage_Sub03
    jr Jump_036_4833

Jump_036_4825::
    ld a, [wDAC3]
    ld [wC0A0], a
    ld a, [wDAC1]
    bit 3, a
    call nz, ResolveStepDamageMessage_Sub04

Jump_036_4833::
    ld a, [wBattleActionId]
    cp a, $DC
    jr z, Jump_036_484E
    cp a, $D7
    jr nz, Jump_036_4844
    farcall ResolveStepDamageMessage_Sub01

Jump_036_4844::
    ld a, [wC0A0]
    ld d, a
    farcall ShowBattleText

Jump_036_484E::
    call Func_036_4961
    ld a, [wDAC0]
    bit 4, a
    jr nz, Jump_036_4859
    ret

Jump_036_4859::
    ld a, [wBattleActionId]
    cp a, $3A
    jr z, Jump_036_4879
    cp a, $3B
    jr z, Jump_036_4890
    cp a, $B8
    jr z, Jump_036_4890
    cp a, $32
    jr z, Jump_036_48AE
    cp a, $77
    jr z, Jump_036_48AE
    cp a, $DC
    jr z, Jump_036_48B5
    cp a, $DF
    jr z, Jump_036_48A3
    ret

Jump_036_4879::
    ld a, [wBattleTarget]
    add a, a
    ld de, wBattleMonsterId
    add a, e
    ld e, a
    jr nc, Jump_036_4885
    inc d

Jump_036_4885::
    ld a, [wBattleActor]
    ld b, a
    call Func_036_4E26
    call ResolveStepDamageMessage_Sub05
    ret

Jump_036_4890::
    ld de, wC0A0
    ld a, $60
    ld [de], a
    inc de
    ld a, $01
    ld [de], a
    dec de
    ld a, [wBattleActor]
    ld b, a
    call Func_036_4E26
    ret

Jump_036_48A3::
    farcall Func_0A3_414F
    ldh a, [hFFC6]
    call SetBit1OfWD095Indexed_Bank36

Jump_036_48AE::
    ld a, [wBattleActor]
    call SetBit1OfWD095Indexed_Bank36
    ret

Jump_036_48B5::
    ld a, [wBattleActor]
    push af
    farcall Func_0A3_414F
    ldh a, [hFFC6]
    ld [wBattleActor], a
    call ResolveStepDamageMessage_Sub02
    pop af
    ld [wBattleActor], a

; only called from ResolveStepDamageMessage (E-0047)
; 1 call site from 1 routine (e.g. ResolveStepDamageMessage)
; reads: wBattleActor
; points at: wC0A0
ResolveStepDamageMessage_Sub02::
Func_036_48CB:: ; address name
    ld de, wC0A0
    ld a, $61
    ld [de], a
    inc de
    ld a, $01
    ld [de], a
    dec de
    ld a, [wBattleActor]
    ld b, a
    call Func_036_4E26
    ret

; resolve step $0B: wBattleActionId $82 jumps to 36:4A9D; $83, $84 and $B3 jump to 36:4B16; any other action advances wBattleResolveStep and returns (E-0050)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActionId, wBattleSubStep, wSoundChannelSlots, wBattleSubPhase, wDAC0, wDAC3, wDAC2
; writes: wBattleResolveStep, wBattleSubStep
; points at: wBattleResolveStep, wDC20, wBattleSubPhase
ResolveStepBranchOnAction::
Jump_036_48DE:: ; address name
    ld a, [wBattleActionId]
    cp a, $82
    jp z, Jump_036_4A9D
    cp a, $83
    jp z, Jump_036_4B16
    cp a, $84
    jp z, Jump_036_4B16
    cp a, $B3
    jp z, Jump_036_4B16
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; resolve step $0C: farcalls ApplyDamageToTarget
; no direct call (reached through a table, a jump or a vector)
ResolveStepApplyDamage::
Jump_036_48FA:: ; address name
    farcall ApplyDamageToTarget
    ret

; resolve step $0D: runs the defeat sequence Func_032_5A3A (RunDefeatSequence); the first fight showed 'was defeated!' (category 1, index 139) at this step
; no direct call (reached through a table, a jump or a vector)
ResolveStepDefeat::
Jump_036_4901:: ; address name
    farcall RunDefeatSequence
    ret

; resolve step $0E: farcalls ResolveStep0EEffect in bank $32 (E-0053)
; no direct call (reached through a table, a jump or a vector)
ResolveStep0ECallEffect::
Jump_036_4908:: ; address name
    farcall ResolveStep0EEffect
    ret

; resolve step $0F: increments wBattleSubPhase and sets wBattleResolveStep to 0 (E-0050)
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleResolveStep
; points at: wBattleSubPhase
ResolveStepAdvanceSubPhase::
Jump_036_490F:: ; address name
    ld hl, wBattleSubPhase
    inc [hl]
    xor a, a
    ld [wBattleResolveStep], a
    ret

; farcalls RunBattleResolveStep_Case05_Sub01_Sub01 (not read) and returns the comparison of wC5E7 with hFFC6 (taken as 4 when hFFC6 is 3): carry set when wC5E7 is below that value (E-0052)
; 1 call site from 1 routine (e.g. ResolveStepChanceRoll)
; reads: hFFC6, wC5E7
RollWC5E7BelowChance::
Func_036_4918:: ; address name
    push bc
    push hl
    farcall RollWC5E7BelowChance_Sub01
    pop hl
    pop bc
    ldh a, [hFFC6]
    ld b, a
    cp a, $03
    jr nz, Jump_036_492B
    ld b, $04

Jump_036_492B::
    ld a, [wC5E7]
    cp a, b
    ret

; 3 call sites from 3 routines (e.g. ResolveStepComputeDamage, ActionEffect_Massacre, ActionEffect_EvilSlash)
Func_036_4930::
    push hl
    ld bc, $0014
    call DivideHLByBC
    ld e, l
    ld d, h
    pop bc
    push bc
    add hl, bc
    ld c, l
    ld b, h
    pop hl
    ld a, e
    cpl
    add a, $01
    ld e, a
    ld a, d
    cpl
    adc a, $00
    ld d, a
    add hl, de
    call RandomInRange
    ret

; only called from ResolveStepComputeDamage (E-0047)
; 1 call site from 1 routine (e.g. ResolveStepComputeDamage)
ResolveStepComputeDamage_Sub01::
Func_036_494E:: ; address name
    ld c, l
    ld b, h
    srl b
    rr c
    sla l
    rl h
    push hl
    add hl, bc
    ld c, l
    ld b, h
    pop hl
    call RandomInRange
    ret

; 2 call sites from 2 routines (e.g. ResolveStepDamageMessage_Sub04, ResolveStepDamageMessage)
; reads: wDAC0, wDABD, wDABF, wDAD1, wBattleActor
; writes: wBattleTarget, wDAD1
; points at: wBattleTargetChoice
Func_036_4961::
    ld a, [wDAC0]
    bit 4, a
    ret nz
    ld a, [wDABD]
    or a, a
    ret nz
    call SetSubPhase3AndRestartResolve
    ld a, [wDABF]
    or a, a
    ret z
    ld a, [wDAD1]
    cp a, $FF
    ret z
    ld [wBattleTarget], a
    ld b, a
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld [hl], b
    ld a, $FF
    ld [wDAD1], a
    ret

; only called from ResolveStepDamageMessage (E-0047)
; 1 call site from 1 routine (e.g. ResolveStepDamageMessage)
; reads: wBattleActionId, wDABF, wDAC2
; writes: wC0A0
; points at: wC0A0, wBattleDamageLo
ResolveStepDamageMessage_Sub03::
Func_036_4991:: ; address name
    ld a, [wBattleActionId]
    cp a, $6C
    jr nz, Jump_036_49A1

Jump_036_4998::
    call TargetOnLocalSide_Bank36
    ret nc
    ld hl, wC0A0
    inc [hl]
    ret

Jump_036_49A1::
    ld a, [wDABF]
    bit 0, a
    jr nz, Jump_036_4998
    call ActorOnLocalSide_Bank36
    ret c
    ld a, [wBattleActionId]
    cp a, $34
    jr z, Jump_036_49FC
    cp a, $AD
    jr z, Jump_036_49FC
    cp a, $78
    jr z, Jump_036_49FC
    cp a, $13
    jr z, Jump_036_4A01
    cp a, $14
    jr z, Jump_036_4A01
    cp a, $15
    jr z, Jump_036_4A13
    cp a, $2B
    jr z, Jump_036_4A23
    cp a, $2C
    jr z, Jump_036_4A23
    cp a, $79
    jr z, Jump_036_4A01
    cp a, $80
    jr z, Jump_036_4A07
    cp a, $92
    jr z, Jump_036_4A0D
    cp a, $B5
    jr z, Jump_036_4A29
    cp a, $BA
    jr z, Jump_036_4A32
    cp a, $BF
    jr z, Jump_036_49FC
    cp a, $C0
    jr z, Jump_036_49FC
    cp a, $C9
    jr z, Jump_036_49FC
    cp a, $CA
    jr z, Jump_036_49FC
    cp a, $CB
    jr z, Jump_036_49FC

Jump_036_49F7::
    ld hl, wC0A0
    inc [hl]
    ret

Jump_036_49FC::
    ld hl, wC0A0
    dec [hl]
    ret

Jump_036_4A01::
    ld a, $8A
    ld [wC0A0], a
    ret

Jump_036_4A07::
    ld a, $56
    ld [wC0A0], a
    ret

Jump_036_4A0D::
    ld a, $63
    ld [wC0A0], a
    ret

Jump_036_4A13::
    ld hl, wBattleDamageLo
    ld a, [hl+]
    sub a, $E8
    ld a, [hl]
    sbc a, $03
    jr z, Jump_036_4A01
    ld hl, wC0A0
    inc [hl]
    ret

Jump_036_4A23::
    ld a, $CD
    ld [wC0A0], a
    ret

Jump_036_4A29::
    ld a, [wDAC2]
    cp a, $73
    jr z, Jump_036_49F7
    jr Jump_036_49FC

Jump_036_4A32::
    ld a, $78
    ld [wC0A0], a
    ret

; only called from ResolveStepDamageMessage (E-0047)
; 1 call site from 1 routine (e.g. ResolveStepDamageMessage)
; reads: wBattleActionId
; writes: wC0A0
; points at: wC0A0
ResolveStepDamageMessage_Sub04::
Func_036_4A38:: ; address name
    call ActorOnLocalSide_Bank36
    ret c
    ld a, [wBattleActionId]
    cp a, $72
    jr z, Jump_036_4A74
    cp a, $73
    jr z, Jump_036_4A74
    cp a, $74
    jr z, Jump_036_4A74
    cp a, $75
    jr z, Jump_036_4A7A
    cp a, $7E
    jr z, Jump_036_4A80
    cp a, $7F
    jr z, Jump_036_4A86
    cp a, $80
    jr z, Jump_036_4A8C
    cp a, $8B
    jr z, Jump_036_4A8C
    cp a, $8C
    jr z, Jump_036_4A8C
    cp a, $8F
    jr z, Jump_036_4A92
    cp a, $AA
    jr z, Jump_036_4A92
    cp a, $C0
    jr z, Jump_036_4A98
    ld hl, wC0A0
    inc [hl]
    ret

Jump_036_4A74::
    ld a, $6A
    ld [wC0A0], a
    ret

Jump_036_4A7A::
    ld a, $6B
    ld [wC0A0], a
    ret

Jump_036_4A80::
    ld a, $6C
    ld [wC0A0], a
    ret

Jump_036_4A86::
    ld a, $6D
    ld [wC0A0], a
    ret

Jump_036_4A8C::
    ld a, $6E
    ld [wC0A0], a
    ret

Jump_036_4A92::
    ld a, $71
    ld [wC0A0], a
    ret

Jump_036_4A98::
    ld hl, wC0A0
    dec [hl]
    ret

Jump_036_4A9D::
    ld a, [wSoundChannelSlots]
    ld hl, wDC20
    and a, [hl]
    cp a, $FF
    ret nz
    ld a, [wBattleSubStep]
    or a, a
    jr z, Jump_036_4AE5
    ld hl, wBattleSubPhase
    inc [hl]
    xor a, a
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleSubStep], a
    call ResolveStepDamageMessage_Sub04_Sub02
    ld a, [wBattleSubPhase]
    cp a, $05
    ret z
    ld a, [wDAC0]
    bit 4, a
    ld a, $99
    call nz, QueueSoundEffect
    ld a, [wDAC3]
    ld d, a
    ld a, [wDAC0]
    bit 4, a
    jr z, Jump_036_4AE1
    ld a, [wDAC2]
    ld d, a
    farcall ShowBattleText

Jump_036_4AE1::
    call Func_036_4961
    ret

Jump_036_4AE5::
    call ResolveStepDamageMessage_Sub04_Sub01
    ld a, [wDAC0]
    bit 4, a
    ld a, $87
    call nz, QueueSoundEffect
    ld a, [wDAC0]
    bit 4, a
    jr z, Jump_036_4B06
    ld a, [wDAC2]
    ld d, a
    call ActorOnLocalSide_Bank36
    jr c, Jump_036_4B0A
    ld d, $CD
    jr Jump_036_4B0A

Jump_036_4B06::
    ld a, [wDAC3]
    ld d, a

Jump_036_4B0A::
    farcall ShowBattleText
    ld a, $01
    ld [wBattleSubStep], a
    ret

Jump_036_4B16::
    ld a, [wBattleSubStep]
    rst $00
    dw Func_036_4A38_Case00
    dw Func_036_4A38_Case01
    dw Func_036_4A38_Case02
    dw Func_036_4A38_Case03
    dw Func_036_4A38_Case04
    dw Func_036_4A38_Case05

; entry 0 of the `rst $00` table in Func_036_4A38
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; points at: wBattleSubStep, wD80E
Func_036_4A38_Case00::
Jump_036_4B26:: ; address name
    ld hl, wBattleSubStep
    inc [hl]
    ld a, [wBattleTarget]
    ld hl, wD80E
    call AddAx9ToHL
    bit 6, [hl]
    ret z
    res 6, [hl]
    ld d, $80
    farcall ShowBattleText
    ret

; entry 1 of the `rst $00` table in Func_036_4A38
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleStatResultLo, wBattleStatResultHi
; writes: wD868
; points at: wBattleSubStep, wD80D, wDAD8, wBattleMaxHP, wBattleHP, wBattleMaxMP, wBattleMP, wBattleATK, ...
Func_036_4A38_Case01::
Jump_036_4B41:: ; address name
    ld hl, wBattleSubStep
    inc [hl]
    ld hl, wBattleSubStep
    inc [hl]
    ld a, [wBattleTarget]
    ld hl, wD80D
    call AddAx9ToHL
    ld a, [hl]
    and a, $30
    jp z, Jump_036_4CCF
    ld a, [hl]
    and a, $CF
    ld [hl], a
    ld hl, wBattleSubStep
    dec [hl]
    ld d, $5F
    farcall ShowBattleText
    push hl
    farcall Func_0A3_4A02
    ld a, [wBattleTarget]
    ld hl, wDAD8
    add_a_to_hl
    ld a, [hl]
    and a, $F8
    ld [hl], a
    pop hl
    ld a, $01
    ld [wD868], a
    ld a, [wBattleTarget]
    ld c, a
    farcall Func_019_434D
    call Func_036_4D0C
    ld a, [wBattleTarget]
    ld c, a
    farcall GetBaseHP
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleStatResultHi]
    ld b, a
    ld a, [wBattleTarget]
    ld hl, wBattleMaxHP
    call AddDoubleAToHL_Bank36
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [wBattleTarget]
    call GetBattleHP
    call CompareHLToBC
    jr c, Jump_036_4BCC
    ld a, [wBattleTarget]
    call SetBit0OfWD095Indexed_Bank36
    ld a, [wBattleTarget]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank36
    ld [hl], c
    inc hl
    ld [hl], b

Jump_036_4BCC::
    ld a, [wBattleTarget]
    ld c, a
    farcall GetBaseMP
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleStatResultHi]
    ld b, a
    ld a, [wBattleTarget]
    ld hl, wBattleMaxMP
    call AddDoubleAToHL_Bank36
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [wBattleTarget]
    call GetBattleMP
    call CompareHLToBC
    jr c, Jump_036_4C07
    ld a, [wBattleTarget]
    call SetBit1OfWD095Indexed_Bank36
    ld a, [wBattleTarget]
    ld hl, wBattleMP
    call AddDoubleAToHL_Bank36
    ld [hl], c
    inc hl
    ld [hl], b

Jump_036_4C07::
    ld a, [wBattleTarget]
    ld c, a
    farcall GetBaseATK
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleStatResultHi]
    ld b, a
    ld a, [wBattleTarget]
    ld hl, wBattleATK
    call AddDoubleAToHL_Bank36
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [wBattleTarget]
    ld c, a
    farcall GetBaseINT
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleStatResultHi]
    ld b, a
    ld a, [wBattleTarget]
    ld hl, wBattleINT
    call AddDoubleAToHL_Bank36
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [wBattleTarget]
    ld c, a
    farcall Func_019_4298
    ld a, [wBattleTarget]
    ld c, a
    farcall Func_03B_4199
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleTarget]
    ld hl, wD8B7
    add_a_to_hl
    ld [hl], c
    ld a, [wBattleTarget]
    ld c, a
    farcall Func_03B_41D3
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleTarget]
    ld hl, wSlotPersonalityHi
    add_a_to_hl
    ld [hl], c
    ld a, [wBattleTarget]
    ld c, a
    farcall Func_03B_420D
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleTarget]
    ld hl, wSlotPersonalityMid
    add_a_to_hl
    ld [hl], c
    ld a, [wBattleTarget]
    ld c, a
    farcall Func_03B_4247
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleTarget]
    ld hl, wSlotPersonalityLo
    add_a_to_hl
    ld [hl], c
    ld a, [wBattleTarget]
    ld c, a
    farcall Func_03B_4281
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleTarget]
    ld hl, wD980
    add_a_to_hl
    ld [hl], c

Jump_036_4CCF::
    ld a, [wBattleTarget]
    ld c, a
    farcall GetBaseAGL
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleStatResultHi]
    ld b, a
    ld a, [wBattleTarget]
    ld hl, wBattleAGL
    call AddDoubleAToHL_Bank36
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [wBattleTarget]
    ld c, a
    farcall GetBaseDEF
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleStatResultHi]
    ld b, a
    ld a, [wBattleTarget]
    ld hl, wBattleDEF
    call AddDoubleAToHL_Bank36
    ld [hl], c
    inc hl
    ld [hl], b
    ret

; 1 call site from 1 routine (e.g. Func_036_4A38_Case01)
; reads: wBattleTarget
; writes: wD868, wD869, wD86A, wD86B
; points at: wDA72
Func_036_4D0C::
    ld a, [wBattleTarget]
    ld b, a
    and a, $03
    cp a, $03
    ret z
    ld a, b
    ld e, $31
    call BattlerRecordFieldAddress
    ld a, l
    ld [wD868], a
    ld a, h
    ld [wD869], a
    ld a, [wBattleTarget]
    ld de, wDA72
    ld b, a
    add a, a
    add a, b
    add a, a
    add a, b
    add a, e
    ld e, a
    jr nc, Jump_036_4D33
    inc d

Jump_036_4D33::
    ld a, e
    ld [wD86A], a
    ld a, d
    ld [wD86B], a
    farcall Func_019_44B9
    ret

; entry 2 of the `rst $00` table in Func_036_4A38
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wC58A
; points at: wBattleSubStep, wBattleMonsterId, wDA5B, wDAD4
Func_036_4A38_Case02::
Jump_036_4D42:: ; address name
    ld hl, wBattleSubStep
    inc [hl]
    ld a, [wBattleTarget]
    ld b, a
    add a, a
    ld de, wBattleMonsterId
    add a, e
    ld e, a
    jr nc, Jump_036_4D53
    inc d

Jump_036_4D53::
    call Func_036_4E26
    ld a, [wBattleTarget]
    ld hl, wDA5B
    add_a_to_hl
    ld [hl], $03
    ld a, [wC58A]
    cp a, $01
    ret z
    ld a, [wBattleTarget]
    cp a, $04
    ret c
    and a, $03
    cp a, $03
    ret z
    ld hl, wDAD4
    add_a_to_hl
    ld [hl], $FF
    ret

; entry 3 of the `rst $00` table in Func_036_4A38
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; points at: wBattleSubStep, wBattleSlotOut, wDA5B, wBattleStatus, wD80A
Func_036_4A38_Case03::
Jump_036_4D7F:: ; address name
    ld hl, wBattleSubStep
    inc [hl]
    ld a, [wBattleTarget]
    and a, $03
    cp a, $03
    ret nz
    ld a, [wBattleTarget]
    call CarryUnlessWDA63SlotEmpty
    ret c
    ld d, $7F
    farcall ShowBattleText
    ld a, [wBattleTarget]
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld [hl], $FF
    ld a, [wBattleTarget]
    ld hl, wDA5B
    add_a_to_hl
    ld [hl], $FF
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ld a, [wBattleTarget]
    and a, $04
    rrca
    rrca
    and a, $01
    ld hl, wD80A
    res 2, [hl]
    ret

; entry 4 of the `rst $00` table in Func_036_4A38
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wQueuedActionId, wDAAD
; points at: wBattleSubStep, wD814
Func_036_4A38_Case04::
Jump_036_4DD6:: ; address name
    ld hl, wBattleSubStep
    inc [hl]
    ld a, [wBattleTarget]
    ld hl, wD814
    call AddAx9ToHL
    bit 4, [hl]
    ret z
    res 4, [hl]
    ld a, $FF
    ld [wQueuedActionId], a
    ld a, $FF
    ld [wDAAD], a
    ret

; entry 5 of the `rst $00` table in Func_036_4A38
; no direct call (reached through a table, a jump or a vector)
; reads: wD80A, wD80B, wBattleActionId
; writes: wBattleResolveStep, wBattleSubStep, wD80A, wD80B
; points at: wBattleSubPhase
Func_036_4A38_Case05::
Jump_036_4DF3:: ; address name
    ld hl, wBattleSubPhase
    inc [hl]
    xor a, a
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleSubStep], a
    ld a, [wD80A]
    and a, $93
    ld [wD80A], a
    ld a, [wD80B]
    and a, $93
    ld [wD80B], a
    ld a, [wBattleActionId]
    cp a, $83
    ret z
    ld a, [wD80A]
    or a, $08
    ld [wD80A], a
    ld a, [wD80B]
    or a, $08
    ld [wD80B], a
    ret

; 5 call sites from 4 routines (e.g. ResolveStepDamageMessage_Sub02, ResolveStepDamageMessage, Func_036_4A38_Case02, ActionEffect_Vivify)
; reads: wC58A, wC57F, wIsCGB, wD890, wC985, wC984
; writes: wC526, hFFC6
Func_036_4E26::
    ld a, [wC58A]
    cp a, $01
    ld a, b
    jr nz, Jump_036_4E3C
    ld a, [wC57F]
    bit 1, a
    ld a, b
    jr z, Jump_036_4E3C
    cp a, $03
    jr nc, Jump_036_4EB0
    jr Jump_036_4E46

Jump_036_4E3C::
    cp a, $04
    jr c, Jump_036_4EB0
    cp a, $07
    jr z, Jump_036_4EB0
    sub a, $04

Jump_036_4E46::
    push de
    push af
    ld bc, $0240
    call Multiply8By16
    ld bc, vTiles2 + $140
    add hl, bc
    pop af
    pop de
    sla a
    add a, $01
    ld c, a
    push bc
    ld a, [de]
    ld b, a
    inc de
    ld a, [de]
    ld d, a
    ld e, b
    push de
    call LoadMonsterPicture
    pop de
    pop bc
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, $7F
    ld [wC526], a
    ld a, c
    ldh [hFFC6], a
    ld a, [wC58A]
    cp a, $01
    ld a, [wD890]
    jr nz, Jump_036_4E8A
    ld a, [wC57F]
    bit 1, a
    ld a, [wC985]
    jr z, Jump_036_4E8A
    ld a, [wC984]

Jump_036_4E8A::
    cp a, $01
    jr z, Jump_036_4E97
    cp a, $03
    jr z, Jump_036_4E9C
    ld hl, vBGMap0 + $E4
    jr Jump_036_4E9F

Jump_036_4E97::
    ld hl, vBGMap0 + $E7
    jr Jump_036_4E9F

Jump_036_4E9C::
    ld hl, vBGMap0 + $E1

Jump_036_4E9F::
    ld a, c
    sub a, $01
    srl a
    ld b, a
    add a, a
    add a, b
    add a, a
    add_a_to_hl
    call LoadMonsterPictureAttributes

Jump_036_4EB0::
    ret

; 2 call sites from 2 routines (e.g. RunBattleResolveStep_Table2_Case00_Sub03, RunBattleResolveStep_Table2_Case00_Sub02)
; reads: wBattleActor, wBattleTarget, wDABA, wDABD
; writes: wBattleActor, wBattleTarget, wDABD
; points at: wDAC9, wBattleActionChoice
Func_036_4EB1::
    push de
    ld hl, wDAC9
    ld a, [wBattleActor]
    ld [hl+], a
    ld a, [wBattleTarget]
    ld [hl+], a
    ld a, [wDABA]
    ld [hl+], a
    ld a, [wBattleActor]
    ld de, wBattleActionChoice
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_036_4ECD
    inc d

Jump_036_4ECD::
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    ld a, [wBattleTarget]
    ld bc, wBattleActionChoice
    add a, a
    add a, c
    ld c, a
    jr nc, Jump_036_4EDE
    inc b

Jump_036_4EDE::
    ld a, [bc]
    ld [hl+], a
    inc bc
    ld a, [bc]
    ld [hl+], a
    ld a, [wBattleActor]
    ld [bc], a
    dec bc
    dec de
    ld a, [de]
    ld [bc], a
    ld a, [wBattleActor]
    ld l, a
    ld a, [wBattleTarget]
    ld h, a
    ld a, h
    ld [wBattleActor], a
    ld a, l
    ld [wBattleTarget], a
    pop de
    bit 0, d
    jr nz, Jump_036_4F06
    bit 2, d
    jr nz, Jump_036_4F06
    jr Jump_036_4F06

Jump_036_4F06::
    ld a, [wDABD]
    or a, d
    ld [wDABD], a
    ret

; the same 10 bytes as SetSubPhase3AndRestartResolve (36:5009)
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleSubPhase, wBattleResolveStep
SetSubPhase3AndRestartResolve_Bank36:: ; heuristic: follows a terminator; C0
Func_036_4F0E:: ; address name
    ld a, $03
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    ret

; only called from RunBattleResolveStep_Table2_Case00_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleResolveStep_Table2_Case00_Sub01)
; reads: wBattleTarget, wC971, wC5E7
; points at: wD854, wD86D
RunBattleResolveStep_Table2_Case00_Sub01_Sub01::
Func_036_4F18:: ; address name
    ld a, [wBattleTarget]
    ld hl, wD854
    add a, a
    add_a_to_hl
    bit 5, [hl]
    jr z, Jump_036_4F2E
    ld a, [wC971]
    scf
    ccf
    ret

Jump_036_4F2E::
    call AdvanceRandom
    ld a, [wC5E7]
    cp a, $33
    jp c, Jump_036_4FBA
    cp a, $66
    jr c, Jump_036_4F80
    ld a, $FF
    ld hl, wD86D
    ld bc, $0003
    call FillBytes
    ld a, [wBattleTarget]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld e, $00

Jump_036_4F54::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_036_4F65
    ld a, e
    ld hl, wD86D
    add_a_to_hl
    ld [hl], c
    inc e

Jump_036_4F65::
    inc c
    dec b
    jr nz, Jump_036_4F54

; 1 call site from 1 routine (e.g. Func_036_4F69)
; points at: wD86D
Func_036_4F69::
    ld hl, $0000
    ld b, $00
    dec e
    ld c, e
    call RandomInRange
    ld a, e
    ld hl, wD86D
    add_a_to_hl
    ld a, [hl]
    scf
    ccf
    ret

Jump_036_4F80::
    ld a, $FF
    ld hl, wD86D
    ld bc, $0003
    call FillBytes
    ld a, [wBattleTarget]
    ld d, a
    ld a, [wBattleTarget]
    and a, $04
    ld c, a
    ld b, $03
    ld e, $00

Jump_036_4F99::
    ld a, c
    cp a, d
    jr z, Jump_036_4FAE
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_036_4FAE
    ld a, e
    ld hl, wD86D
    add_a_to_hl
    ld [hl], c
    inc e

Jump_036_4FAE::
    inc c
    dec b
    jr nz, Jump_036_4F99
    ld a, e
    or a, a
    jr z, Jump_036_4FBA
    call Func_036_4F69
    ret

Jump_036_4FBA::
    scf
    ret

; only called from ResolveStepEffectChecks (E-0047)
; 1 call site from 1 routine (e.g. ResolveStepEffectChecks)
ResolveStepEffectChecks_Sub03::
Func_036_4FBC:: ; address name
    ld a, $84
    call QueueSoundEffect
    call ActorOnLocalSide_Bank36
    ld d, $D0
    jr c, Jump_036_4FCA
    ld d, $D1

Jump_036_4FCA::
    farcall ShowBattleText
    ret

; for action $CC clears bits 0-1 of the actor's wD810 byte when bits 2-3 equal 4; for an action in $D0-$E3 it farcalls Func_0A3_413F first. Then it sets wBattleSubPhase to 2 and clears wBattleResolveStep (E-0055)
; 8 call sites from 7 routines (e.g. ResolveStepEffectChecks, ResolveStepFlagBit7Effect, RunBattleResolveStep_Table2_Case01, RunBattleResolveStep_Table2_Case00_Sub04, ...)
; reads: wBattleActionId, wBattleActor
; writes: wBattleSubPhase, wBattleResolveStep
; points at: wD810
SetSubPhase2AndRestartResolve::
Func_036_4FD1:: ; address name
    ld a, [wBattleActionId]
    cp a, $CC
    jr z, Jump_036_4FF3
    ld a, [wBattleActionId]
    cp a, $D0
    jr c, Jump_036_4FE9
    cp a, $E4
    jr nc, Jump_036_4FE9
    farcall Func_0A3_413F

Jump_036_4FE9::
    ld a, $02
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    ret

Jump_036_4FF3::
    ld a, [wBattleActor]
    ld hl, wD810
    call AddAx9ToHL
    ld a, [hl]
    and a, $0C
    cp a, $04
    jr nz, Jump_036_4FE9
    ld a, [hl]
    and a, $F3
    ld [hl], a
    jr Jump_036_4FE9

; sets wBattleSubPhase to 3 and clears wBattleResolveStep (E-0055)
; 2 call sites from 2 routines (e.g. Func_036_4961, ResolveStepEffectChecks)
; writes: wBattleSubPhase, wBattleResolveStep
SetSubPhase3AndRestartResolve::
Func_036_5009:: ; address name
    ld a, $03
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    ret

; AdvanceRandom, then BC = the target's DEF (wBattleDEF) / 2 and falls into ComputeBasicDamage with HL = the actor's ATK (E-0064)
; 14 call sites from 13 routines (e.g. Func_036_5522, Func_036_6098, Func_036_5533, Func_036_5544, ...)
; reads: wBattleTarget, wBattleActor
; writes: wBattleDamageLo, wD873
; points at: wBattleDEF
ComputeAttackDamage::
Func_036_5013:: ; address name
    call AdvanceRandom
    ld a, [wBattleTarget]
    ld hl, wBattleDEF
    call AddDoubleAToHL_Bank36
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    call ShiftBCRight1

; the damage formula: HL = the acting slot's value from the array at wD8FF (Func_036_7E2E), BC = the value to compare with, set by the caller. If HL <= BC the damage is RandomInRange(0, 1). Otherwise, with half = (HL - BC) / 2: when HL / 16 >= half the damage is RandomInRange(0, HL / 16); else it is half + RandomInRange(-(half / 16), half / 16) + RandomInRange(-1, 1). The 16-bit result goes to wBattleDamageLo/Hi. The divisors are 16, not 4: ShiftHLRight4 falls through two more shifts (corrected in E-0064)
; 2 call sites from 1 routine (e.g. ActionEffect_ActionD7_Sub01)
; reads: wBattleActor
; writes: wBattleDamageLo, wD873
ComputeBasicDamage::
Func_036_5025:: ; address name
    ld a, [wBattleActor]
    call GetBattleATK
    call CompareHLToBC
    jr z, Jump_036_504E
    jr c, Jump_036_504E
    ld a, l
    sub a, c
    ld e, a
    ld a, h
    sbc a, b
    ld d, a
    srl d
    rr e
    push hl
    push bc
    ld b, d
    ld c, e
    call ShiftHLRight4
    call CompareHLToBC
    pop bc
    pop hl
    jr z, Jump_036_5059
    jr nc, Jump_036_5059
    jr Jump_036_5066

Jump_036_504E::
    ld hl, $0000
    ld bc, $0001
    call RandomInRange
    jr Jump_036_508B

Jump_036_5059::
    call ShiftHLRight4
    ld c, l
    ld b, h
    ld hl, $0000
    call RandomInRange
    jr Jump_036_508B

Jump_036_5066::
    ld l, e
    ld h, d
    push hl
    call ShiftHLRight4
    ld c, l
    ld b, h
    ld a, l
    cpl
    add a, $01
    ld l, a
    ld a, h
    cpl
    adc a, $00
    ld h, a
    call RandomInRange
    pop hl
    add hl, de
    push hl
    ld hl, $FFFF
    ld bc, $0001
    call RandomInRange
    pop hl
    add hl, de
    ld e, l
    ld d, h

Jump_036_508B::
    ld a, e
    ld [wBattleDamageLo], a
    ld a, d
    ld [wD873], a
    ret

; only called from ActionEffect_ActionD1 (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_ActionD1)
ActionEffect_ActionD1_Sub01:: ; heuristic: follows a terminator; C0
Func_036_5094:: ; address name
    call Func_036_6159
    ld a, $00
    call Func_036_621C
    ret

; only called from ActionEffect_ActionD2 (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_ActionD2)
ActionEffect_ActionD2_Sub01:: ; heuristic: follows a terminator; C0
Func_036_509D:: ; address name
    call Func_036_5A6C
    call GetTargetSpeciesFamily
    cp a, $00
    jr z, Jump_036_50AE
    cp a, $08
    jr z, Jump_036_50AE
    cp a, $09
    ret nz

Jump_036_50AE::
    call Func_036_6451
    ret

; only called from ActionEffect_ActionD3 (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_ActionD3)
ActionEffect_ActionD3_Sub01:: ; heuristic: follows a terminator; C0
Func_036_50B2:: ; address name
    call Func_036_5A6C
    call GetTargetSpeciesFamily
    cp a, $01
    jr z, Jump_036_50C3
    cp a, $03
    jr z, Jump_036_50C3
    cp a, $06
    ret nz

Jump_036_50C3::
    call Func_036_6451
    ret

; only called from ActionEffect_ActionD4 (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_ActionD4)
ActionEffect_ActionD4_Sub01:: ; heuristic: follows a terminator; C0
Func_036_50C7:: ; address name
    call Func_036_5A6C
    call GetTargetSpeciesFamily
    cp a, $02
    jr z, Jump_036_50D8
    cp a, $05
    jr z, Jump_036_50D8
    cp a, $04
    ret nz

Jump_036_50D8::
    call Func_036_6451
    ret

; only called from ActionEffect_ActionD7 (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_ActionD7)
; reads: wBattleActor, wBattleDamageLo, wD873, hFFC6
; writes: wBattleActor, wBattleDamageLo, wD873
ActionEffect_ActionD7_Sub01:: ; heuristic: follows a terminator; C0
Func_036_50DC:: ; address name
    ld a, [wBattleActor]
    push af
    call AdvanceRandom
    ld bc, $0000
    call ComputeBasicDamage
    ld a, [wBattleDamageLo]
    ld e, a
    ld a, [wD873]
    ld d, a
    push de
    farcall Func_0A3_414F
    ldh a, [hFFC6]
    ld [wBattleActor], a
    call AdvanceRandom
    ld bc, $0000
    call ComputeBasicDamage
    pop de
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wD873]
    ld h, a
    add hl, de
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    pop af
    ld [wBattleActor], a
    ret

; only called from ActionEffect_ActionD8 (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_ActionD8)
; reads: wBattleActor, wBattleDamageLo, wD873, hFFC6
; writes: wBattleActor, wBattleDamageLo, wD873
ActionEffect_ActionD8_Sub01:: ; heuristic: follows a terminator; C0
Func_036_511D:: ; address name
    ld a, [wBattleActor]
    push af
    call ComputeAttackDamage
    ld a, [wBattleDamageLo]
    ld e, a
    ld a, [wD873]
    ld d, a
    push de
    farcall Func_0A3_414F
    ldh a, [hFFC6]
    ld [wBattleActor], a
    call ComputeAttackDamage
    pop de
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wD873]
    ld h, a
    add hl, de
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    pop af
    ld [wBattleActor], a
    ret
    INCBIN "dwm2-cobi-us.gbc", $0D9152, $7F

; only called from ActionEffect_Blaze (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Blaze)
ActionEffect_Blaze_Sub01::
Func_036_51D1:: ; address name
    call Func_036_6159
    call Func_036_61A6
    swap a
    and a, $03
    call Func_036_621C
    ret

; only called from ActionEffect_Firebal (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Firebal)
ActionEffect_Firebal_Sub01::
Func_036_51DF:: ; address name
    call Func_036_6159
    call Func_036_61A6
    rrca
    rrca
    and a, $03
    call Func_036_621C
    ret

; only called from ActionEffect_Bang (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Bang)
ActionEffect_Bang_Sub01::
Func_036_51ED:: ; address name
    call Func_036_6159
    call Func_036_61A6
    and a, $03
    call Func_036_621C
    ret

; only called from ActionEffect_Infernos (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Infernos)
ActionEffect_Infernos_Sub01::
Func_036_51F9:: ; address name
    call Func_036_6159

; 2 call sites from 2 routines (e.g. ActionEffect_Vacuum_Sub01, ActionEffect_WindBeast_Sub01)
Func_036_51FC::
    call Func_036_61AB
    rlca
    rlca
    and a, $03
    call Func_036_621C
    ret

; 2 call sites from 2 routines (e.g. ActionEffect_ActionD0, ActionEffect_Bolt)
Func_036_5207::
    call Func_036_6159

; only called from ActionEffect_Lightning_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Lightning_Sub01)
ActionEffect_Lightning_Sub01_Sub01::
Func_036_520A:: ; address name
    call Func_036_61AB
    swap a
    and a, $03
    call Func_036_621C
    ret

; only called from ActionEffect_IceBolt (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_IceBolt)
ActionEffect_IceBolt_Sub01::
Func_036_5215:: ; address name
    call Func_036_6159
    call Func_036_61AB
    rrca
    rrca
    and a, $03
    call Func_036_621C
    ret

; 2 call sites from 2 routines (e.g. ActionEffect_ActionDA, ActionEffect_Heal)
; reads: wBattleActionId, wBattleDamageLo, wD873, wBattleTarget, wBattleActor, wC58A
; writes: wBattleDamageLo, wD873
; points at: wBattleHP, wBattleMaxHP, wDAFA
Func_036_5223::
    ld a, [wBattleActionId]
    cp a, $18
    jp z, Jump_036_52CC
    cp a, $1A
    jp z, Jump_036_52CC
    cp a, $20
    jr z, Jump_036_5251
    cp a, $B1
    jr z, Jump_036_5251
    cp a, $7B
    jr z, Jump_036_5251
    cp a, $CF
    jr z, Jump_036_528B
    cp a, $DA
    jr z, Jump_036_5251

Jump_036_5244::
    call Func_036_6159
    ld a, [wBattleDamageLo]
    ld e, a
    ld a, [wD873]
    ld d, a
    jr Jump_036_5265

Jump_036_5251::
    ld a, [wBattleTarget]
    ld hl, wBattleMaxHP
    call AddDoubleAToHL_Bank36
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld a, e
    ld [wBattleDamageLo], a
    ld a, d
    ld [wD873], a

Jump_036_5265::
    ld a, [wBattleTarget]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank36
    push hl
    deref_hl
    ld a, l
    add a, e
    ld c, a
    ld a, h
    adc a, d
    ld b, a
    ld a, [wBattleTarget]
    call GetBattleMaxHP
    call CompareHLToBC
    jr nc, Jump_036_5285
    ld b, h
    ld c, l

Jump_036_5285::
    pop hl
    ld a, c
    ld [hl+], a
    ld [hl], b
    scf
    ret

Jump_036_528B::
    ld a, [wBattleTarget]
    ld hl, wBattleMaxHP
    call AddDoubleAToHL_Bank36
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld a, e
    ld [wBattleDamageLo], a
    ld a, d
    ld [wD873], a
    ld a, [wBattleActor]
    ld hl, wDAFA
    add_a_to_hl
    ld a, [hl]
    or a, a
    jr z, Jump_036_5265
    push af
    call Func_036_640D
    ld a, [wBattleDamageLo]
    ld e, a
    ld a, [wD873]
    ld d, a
    pop af
    dec a
    jr z, Jump_036_5265
    sra d
    rr e
    ld a, e
    ld [wBattleDamageLo], a
    ld a, d
    ld [wD873], a
    jr Jump_036_5265

Jump_036_52CC::
    ld a, [wC58A]
    cp a, $01
    jp z, Jump_036_5251
    ld a, [wBattleActor]
    bit 2, a
    jp z, Jump_036_5251
    jp Jump_036_5244

; only called from ActionEffect_MPass (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_MPass)
; reads: wBattleActionId, wBattleTarget
; writes: wBattleDamageLo, wD873
; points at: wBattleMP
ActionEffect_MPass_Sub01::
Func_036_52DF:: ; address name
    ld a, [wBattleActionId]
    cp a, $1B
    jr z, Jump_036_52EF
    cp a, $1C
    jr z, Jump_036_52F4
    ld de, $0050
    jr Jump_036_52F7

Jump_036_52EF::
    ld de, $000F
    jr Jump_036_52F7

Jump_036_52F4::
    ld de, $001E

Jump_036_52F7::
    ld a, e
    ld [wBattleDamageLo], a
    ld a, d
    ld [wD873], a
    ld a, [wBattleTarget]
    ld hl, wBattleMP
    call AddDoubleAToHL_Bank36
    push hl
    deref_hl
    ld a, l
    add a, e
    ld c, a
    ld a, h
    adc a, d
    ld b, a
    ld a, [wBattleTarget]
    call GetBattleMaxMP
    call CompareHLToBC
    jr nc, Jump_036_531F
    ld b, h
    ld c, l

Jump_036_531F::
    pop hl
    ld a, c
    ld [hl+], a
    ld [hl], b
    scf
    ret
    db $37, $3F, $C9

; only called from ActionEffect_BigBang (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_BigBang)
ActionEffect_BigBang_Sub01::
Func_036_5328:: ; address name
    call Func_036_6159
    call Func_036_61A6
    swap a
    and a, $03
    call Func_036_6232
    ret

; only called from ActionEffect_FireAir (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_FireAir)
ActionEffect_FireAir_Sub01::
Func_036_5336:: ; address name
    call Func_036_6159
    call Func_036_61BA
    swap a
    and a, $03
    call Func_036_6232
    ret

; only called from ActionEffect_FrigidAir (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_FrigidAir)
ActionEffect_FrigidAir_Sub01::
Func_036_5344:: ; address name
    call Func_036_6159
    call Func_036_61BA
    rrca
    rrca
    and a, $03
    call Func_036_6232
    ret

; only called from ActionEffect_RockThrow (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_RockThrow)
ActionEffect_RockThrow_Sub01::
Func_036_5352:: ; address name
    call Func_036_6159
    call Func_036_61C4
    swap a
    and a, $03
    call Func_036_621C
    ret

; 2 call sites from 2 routines (e.g. ActionEffect_ActionDD, ActionEffect_Upper)
; reads: wBattleTarget, wBattleActionId, wBattleDamageLo, wD873
; writes: wBattleDamageLo, wD873
; points at: wBattleDEF
Func_036_5360::
    ld a, [wBattleTarget]
    call Func_036_6521
    jr nc, Jump_036_53C4
    jr z, Jump_036_53C4
    ld a, [wBattleTarget]
    call Func_036_6634
    ld a, [wBattleActionId]
    cp a, $25
    jr z, Jump_036_5380
    ld l, c
    ld h, b
    call Func_036_64DB
    ld c, l
    ld b, h
    jr Jump_036_5383

Jump_036_5380::
    call ShiftBCRight1

Jump_036_5383::
    ld a, c
    ld [wBattleDamageLo], a
    ld a, b
    ld [wD873], a
    ld a, [wBattleTarget]
    ld hl, wBattleDEF
    call AddDoubleAToHL_Bank36
    ld a, [hl]
    add a, c
    ld [hl+], a
    ld a, [hl]
    adc a, b
    ld [hl], a
    ld a, [wBattleTarget]
    push hl
    call Func_036_6521
    pop hl
    jr c, Jump_036_53C2
    ld a, [hl-]
    ld e, [hl]
    ld d, a
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld a, e
    sub a, c
    ld e, a
    ld a, d
    sbc a, b
    ld d, a
    ld a, [wBattleDamageLo]
    sub a, e
    ld e, a
    ld a, [wD873]
    sbc a, d
    ld d, a
    ld a, e
    ld [wBattleDamageLo], a
    ld a, d
    ld [wD873], a

Jump_036_53C2::
    scf
    ret

Jump_036_53C4::
    xor a, a
    ret

; 2 call sites from 2 routines (e.g. ActionEffect_LushLicks, ActionEffect_Sap)
; reads: wBattleActionId
; writes: wD86A
Func_036_53C6::
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61B5
    swap a
    and a, $03
    ld [wD86A], a
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_53DC
    scf
    ret

Jump_036_53DC::
    and a, $03
    ld b, a
    ld a, [wBattleActionId]
    cp a, $8C
    ld a, b
    jr z, Jump_036_53EB
    call Func_036_61D6
    ret

Jump_036_53EB::
    call Func_036_620F
    ret

; only called from ActionEffect_UltraDown_Sub02 (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_UltraDown_Sub02)
; reads: wBattleTarget, wBattleActionId
; writes: wBattleDamageLo, wD873
; points at: wBattleDEF
ActionEffect_UltraDown_Sub02_Sub01::
Func_036_53EF:: ; address name
    ld a, [wBattleTarget]
    call GetBattleDEF
    ld b, h
    ld c, l
    ld hl, $0001
    call CompareHLToBC
    jr c, Jump_036_5401
    xor a, a
    ret

Jump_036_5401::
    ld a, [wBattleTarget]
    call Func_036_6634
    ld a, [wBattleActionId]
    cp a, $27
    jr z, Jump_036_5417
    ld l, c
    ld h, b
    call Func_036_64DB
    ld c, l
    ld b, h
    jr Jump_036_541A

Jump_036_5417::
    call ShiftBCRight1

Jump_036_541A::
    ld a, [wBattleTarget]
    ld hl, wBattleDEF
    call AddDoubleAToHL_Bank36
    push hl
    ld a, [hl+]
    ld h, [hl]
    or a, h
    pop hl
    jr z, Jump_036_543F
    ld a, c
    ld [wBattleDamageLo], a
    ld a, b
    ld [wD873], a
    ld a, [hl]
    sub a, c
    ld [hl+], a
    ld a, [hl]
    sbc a, b
    ld [hl], a
    jr nc, Jump_036_543D
    xor a, a
    ld [hl-], a
    ld [hl], a

Jump_036_543D::
    scf
    ret

Jump_036_543F::
    xor a, a
    ret

; 2 call sites from 2 routines (e.g. ActionEffect_ActionDD, ActionEffect_Speed)
; reads: wBattleTarget, wBattleActionId, wBattleDamageLo, wD873
; writes: wBattleDamageLo, wD873
; points at: wBattleAGL
Func_036_5441::
    ld a, [wBattleTarget]
    call Func_036_6558
    jr nc, Jump_036_54A5
    ld a, [wBattleTarget]
    call Func_036_6646
    ld a, [wBattleActionId]
    cp a, $29
    jr z, Jump_036_545F
    ld l, c
    ld h, b
    call Func_036_64DB
    ld c, l
    ld b, h
    jr Jump_036_5462

Jump_036_545F::
    call ShiftBCRight1

Jump_036_5462::
    ld a, c
    ld [wBattleDamageLo], a
    ld a, b
    ld [wD873], a
    ld a, [wBattleTarget]
    ld hl, wBattleAGL
    call AddDoubleAToHL_Bank36
    ld a, [hl]
    add a, c
    ld [hl+], a
    ld a, [hl]
    adc a, b
    ld [hl], a
    ld a, [wBattleTarget]
    push hl
    call Func_036_6558
    pop hl
    jr c, Jump_036_54A3
    dec hl
    ld a, [hl+]
    sub a, c
    ld e, a
    ld a, [hl]
    sbc a, b
    ld d, a
    ld a, b
    ld [hl-], a
    ld [hl], c
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wD873]
    ld b, a
    ld a, c
    sub a, e
    ld e, a
    ld a, b
    sbc a, d
    ld d, a
    ld a, e
    ld [wBattleDamageLo], a
    ld a, d
    ld [wD873], a

Jump_036_54A3::
    scf
    ret

Jump_036_54A5::
    xor a, a
    ret

; no direct call (reached through a table, a jump or a vector)
Func_036_54A7:: ; heuristic: follows a terminator; C0
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61B5
    rrca
    rrca
    and a, $03
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_54BA
    scf
    ret

Jump_036_54BA::
    call Func_036_61D6
    ret

; only called from ResolveStepDamageMessage_Sub04_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. ResolveStepDamageMessage_Sub04_Sub01)
; reads: wBattleTarget, wBattleActionId
; writes: wBattleDamageLo, wD873
; points at: wBattleAGL
ResolveStepDamageMessage_Sub04_Sub01_Sub01::
Func_036_54BE:: ; address name
    ld a, [wBattleTarget]
    call Func_036_6646
    ld a, [wBattleActionId]
    cp a, $2B
    jr z, Jump_036_54D4
    ld l, c
    ld h, b
    call Func_036_64DB
    ld c, l
    ld b, h
    jr Jump_036_54D7

Jump_036_54D4::
    call ShiftBCRight1

Jump_036_54D7::
    ld a, [wBattleTarget]
    ld hl, wBattleAGL
    call AddDoubleAToHL_Bank36
    push hl
    ld d, $00
    deref_hl
    call CompareHLToBC
    jr nz, Jump_036_54ED
    ld d, $01

Jump_036_54ED::
    push bc
    ld bc, $0002
    call CompareHLToBC
    pop bc
    pop hl
    jr c, Jump_036_5520
    ld a, c
    sub a, d
    ld c, a
    ld a, b
    sbc a, $00
    ld b, a
    ld a, c
    ld [wBattleDamageLo], a
    ld a, b
    ld [wD873], a
    ld a, [hl]
    ld e, a
    sub a, c
    ld [hl+], a
    ld a, [hl]
    ld d, a
    sbc a, b
    ld [hl], a
    jr nc, Jump_036_551E
    xor a, a
    ld [hl-], a
    ld [hl], $01
    dec de
    ld a, e
    ld [wBattleDamageLo], a
    ld a, d
    ld [wD873], a

Jump_036_551E::
    scf
    ret

Jump_036_5520::
    xor a, a
    ret

; no direct call (reached through a table, a jump or a vector)
Func_036_5522:: ; heuristic: follows a terminator; C0
    call ComputeAttackDamage
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61A6
    swap a
    and a, $03
    call Func_036_6248
    ret

; no direct call (reached through a table, a jump or a vector)
Func_036_5533:: ; heuristic: follows a terminator; C0
    call ComputeAttackDamage
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61AB
    rlca
    rlca
    and a, $03
    call Func_036_6248
    ret

; no direct call (reached through a table, a jump or a vector)
Func_036_5544:: ; heuristic: follows a terminator; C0
    call ComputeAttackDamage
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61AB
    swap a
    and a, $03
    call Func_036_6248
    ret

; no direct call (reached through a table, a jump or a vector)
Func_036_5555:: ; heuristic: follows a terminator; C0
    call ComputeAttackDamage
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61AB
    rrca
    rrca
    and a, $03
    call Func_036_6248
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleActor
; writes: wBattleDamageLo, wD873
; points at: wBattleDEF
Func_036_5566:: ; heuristic: follows a terminator; C0
    call GetTargetSpeciesFamily
    cp a, $00
    jp nz, ComputeAttackDamage
    jp Func_036_66E0

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleActor
; writes: wBattleDamageLo, wD873
; points at: wBattleDEF
Func_036_5571:: ; heuristic: follows a terminator; C0
    call GetTargetSpeciesFamily
    cp a, $01
    jp nz, ComputeAttackDamage
    jp Func_036_66E0

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleActor
; writes: wBattleDamageLo, wD873
; points at: wBattleDEF
Func_036_557C:: ; heuristic: follows a terminator; C0
    call GetTargetSpeciesFamily
    cp a, $02
    jp nz, ComputeAttackDamage
    jp Func_036_66E0

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleActor
; writes: wBattleDamageLo, wD873
; points at: wBattleDEF
Func_036_5587:: ; heuristic: follows a terminator; C0
    call GetTargetSpeciesFamily
    cp a, $03
    jp nz, ComputeAttackDamage
    jp Func_036_66E0

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleActor
; writes: wBattleDamageLo, wD873
; points at: wBattleDEF
Func_036_5592:: ; heuristic: follows a terminator; C0
    call GetTargetSpeciesFamily
    cp a, $05
    jp nz, ComputeAttackDamage
    jp Func_036_66E0

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleActor
; writes: wBattleDamageLo, wD873
; points at: wBattleDEF
Func_036_559D:: ; heuristic: follows a terminator; C0
    call GetTargetSpeciesFamily
    cp a, $04
    jp nz, ComputeAttackDamage
    jp Func_036_66E0

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleActor
; writes: wBattleDamageLo, wD873
; points at: wBattleDEF
Func_036_55A8:: ; heuristic: follows a terminator; C0
    call GetTargetSpeciesFamily
    cp a, $06
    jp nz, ComputeAttackDamage
    jp Func_036_66E0

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleActor
; writes: wBattleDamageLo, wD873
; points at: wBattleDEF
Func_036_55B3:: ; heuristic: follows a terminator; C0
    call GetTargetSpeciesFamily
    cp a, $07
    jp nz, ComputeAttackDamage
    jp Func_036_66E0

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleActor
; writes: wBattleDamageLo, wD873
; points at: wBattleDEF
Func_036_55BE:: ; heuristic: follows a terminator; C0
    call GetTargetSpeciesFamily
    cp a, $08
    jp nz, ComputeAttackDamage
    jp Func_036_66E0

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleActor
; writes: wBattleDamageLo, wD873
; points at: wBattleDEF
Func_036_55C9:: ; heuristic: follows a terminator; C0
    call GetTargetSpeciesFamily
    cp a, $09
    jp nz, ComputeAttackDamage
    jp Func_036_66E0

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleDamageLo, wD873
; writes: wBattleDamageLo, wD873
; points at: wD8A7
Func_036_55D4:: ; heuristic: follows a terminator; C0
    call ComputeAttackDamage
    ld a, [wBattleTarget]
    ld hl, wD8A7
    add_a_to_hl
    bit 0, [hl]
    jr z, Jump_036_55FA
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wD873]
    ld h, a
    call Func_036_6465
    inc hl
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a

Jump_036_55FA::
    ret

; 2 call sites from 2 routines (e.g. ResolveStepDamageMessage_Sub04_Sub02, ActionEffect_Radiant)
; reads: wBattleActionId
Func_036_55FB::
    ld a, [wBattleActionId]
    cp a, $82
    jr z, Jump_036_5611
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61AB
    and a, $03
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_5613

Jump_036_5611::
    scf
    ret

Jump_036_5613::
    and a, $03
    ld b, a
    ld a, [wBattleActionId]
    cp a, $7E
    ld a, b
    jr z, Jump_036_5622
    call Func_036_61D6
    ret

Jump_036_5622::
    call Func_036_61F9
    ret

; only called from ActionEffect_RobMagic (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_RobMagic)
; writes: wD86A
ActionEffect_RobMagic_Sub01:: ; heuristic: follows a terminator; C0
Func_036_5626:: ; address name
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61B0
    rrca
    rrca
    and a, $03
    ld [wD86A], a
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_563C
    scf
    ret

Jump_036_563C::
    call Func_036_61D6
    ret

; only called from ActionEffect_RobMagic (E-0047)
; 2 call sites from 1 routine (e.g. ActionEffect_RobMagic)
; reads: wBattleActor
; points at: wBattleMP, wD8F0
ActionEffect_RobMagic_Sub02:: ; heuristic: follows a terminator; C0
Func_036_5640:: ; address name
    call Func_036_5671
    ld a, [wBattleActor]
    ld hl, wBattleMP
    call AddDoubleAToHL_Bank36
    push hl
    deref_hl
    add hl, bc
    ld b, h
    ld c, l
    pop hl
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld a, [wBattleActor]
    call ActionEffect_RobMagic_Sub02_Sub01
    jr nc, Jump_036_5670
    ld a, [wBattleActor]
    ld bc, wD8F0
    add a, a
    add a, c
    ld c, a
    jr nc, Jump_036_566B
    inc b

Jump_036_566B::
    ld a, [bc]
    ld [hl-], a
    dec bc
    ld a, [bc]
    ld [hl], a

Jump_036_5670::
    ret

; 2 call sites from 2 routines (e.g. ActionEffect_RobMagic_Sub02, Func_036_746B)
; reads: wBattleTarget, wBattleActionId, wC982, wC983, wBattleActor
; writes: wBattleDamageLo, wD873
; points at: wBattleMP, wD8B7
Func_036_5671::
    ld a, [wBattleTarget]
    ld hl, wBattleMP
    call AddDoubleAToHL_Bank36
    push hl
    ld a, [wBattleActionId]
    cp a, $DF
    jr nz, Jump_036_568C
    ld a, [wC982]
    ld c, a
    ld a, [wC983]
    ld b, a
    jr Jump_036_56AE

Jump_036_568C::
    deref_hl
    or a, h
    jr z, Jump_036_56B8
    ld a, [wBattleActor]
    ld de, wD8B7
    add a, e
    ld e, a
    jr nc, Jump_036_569D
    inc d

Jump_036_569D::
    ld a, [de]
    srl a
    srl a
    add a, $05
    ld c, a
    ld b, $00
    call CompareHLToBC
    jr nc, Jump_036_56AE
    ld b, h
    ld c, l

Jump_036_56AE::
    ld a, c
    ld [wBattleDamageLo], a
    ld a, b
    ld [wD873], a
    jr Jump_036_56C3

Jump_036_56B8::
    ld bc, $0000
    ld a, c
    ld [wBattleDamageLo], a
    ld a, b
    ld [wD873], a

Jump_036_56C3::
    pop hl
    ld a, [hl]
    sub a, c
    ld [hl+], a
    ld a, [hl]
    sbc a, b
    ld [hl], a
    ret

; only called from ActionEffect_StopSpell (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_StopSpell)
ActionEffect_StopSpell_Sub01:: ; heuristic: follows a terminator; C0
Func_036_56CB:: ; address name
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61B0
    and a, $03
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_56DC
    scf
    ret

Jump_036_56DC::
    call Func_036_61D6
    ret

; only called from ActionEffect_PanicAll (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_PanicAll)
; reads: wBattleActionId
ActionEffect_PanicAll_Sub01:: ; heuristic: follows a terminator; C0
Func_036_56E0:: ; address name
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61B5
    rlca
    rlca
    and a, $03
    push af
    ld a, [wBattleActionId]
    cp a, $E1
    jr nz, Jump_036_56F5
    pop af
    xor a, a
    push af

Jump_036_56F5::
    pop af
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_56FF
    scf
    ret

Jump_036_56FF::
    call Func_036_620F
    ret

; only called from ActionEffect_Transform (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Transform)
; reads: wBattleTarget, wBattleActor, wC58A, wCFF1
; writes: wD868, wD869, wD86A, wD86B, wRecordBuffer, wCFED
; points at: wD8A7, wBattleHP, wBattleMaxHP, wBattleMP, wBattleMaxMP, wBattleATK, wBattleDEF, wBattleAGL, ...
ActionEffect_Transform_Sub01:: ; heuristic: follows a terminator; C0
Func_036_5703:: ; address name
    ld a, [wBattleTarget]
    call ActionEffect_Transform_Sub01_Sub06
    ld a, [wBattleActor]
    ld hl, wD8A7
    add_a_to_hl
    ld [hl], c
    ld a, [wBattleTarget]
    call ActionEffect_Transform_Sub01_Sub01
    ld a, [wBattleActor]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank36
    push hl
    deref_hl
    call CompareHLToBC
    pop hl
    jr c, Jump_036_5737
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld a, [wBattleActor]
    call SetBit0OfWD095Indexed_Bank36

Jump_036_5737::
    ld a, [wBattleActor]
    ld hl, wBattleMaxHP
    call AddDoubleAToHL_Bank36
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld a, [wBattleTarget]
    call ActionEffect_Transform_Sub01_Sub02
    ld a, [wBattleActor]
    ld hl, wBattleMP
    call AddDoubleAToHL_Bank36
    push hl
    deref_hl
    call CompareHLToBC
    pop hl
    jr c, Jump_036_5765
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld a, [wBattleActor]
    call SetBit1OfWD095Indexed_Bank36

Jump_036_5765::
    ld a, [wBattleActor]
    ld hl, wBattleMaxMP
    call AddDoubleAToHL_Bank36
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld a, [wBattleActor]
    ld hl, wBattleATK
    call AddDoubleAToHL_Bank36
    ld a, [wBattleTarget]
    call ActionEffect_Transform_Sub01_Sub03
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld a, [wBattleActor]
    ld hl, wBattleDEF
    call AddDoubleAToHL_Bank36
    ld a, [wBattleTarget]
    call Func_036_6634
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld a, [wBattleActor]
    ld hl, wBattleAGL
    call AddDoubleAToHL_Bank36
    ld a, [wBattleTarget]
    call Func_036_6646
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld a, [wBattleTarget]
    call ActionEffect_Transform_Sub01_Sub04
    ld a, [wBattleActor]
    ld de, wDA72
    ld b, a
    add a, a
    add a, b
    add a, a
    add a, b
    add a, e
    ld e, a
    jr nc, Jump_036_57BD
    inc d

Jump_036_57BD::
    ld a, l
    ld [wD868], a
    ld a, h
    ld [wD869], a
    ld a, e
    ld [wD86A], a
    ld a, d
    ld [wD86B], a
    farcall Func_019_44B9
    ld a, [wBattleTarget]
    call ActionEffect_Transform_Sub01_Sub05
    ld a, [wBattleActor]
    ld de, wD988
    swap a
    add a, e
    ld e, a
    jr nc, Jump_036_57E6
    inc d

Jump_036_57E6::
    ld c, $00

Jump_036_57E8::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_036_584D
    cp a, $C8
    jr z, Jump_036_584D
    push af
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_036_5822
    ld a, [wBattleTarget]
    cp a, $04
    jr nc, Jump_036_5811
    pop af
    cp a, $34
    jr nz, Jump_036_5809
    ld a, $AD
    jr Jump_036_5823

Jump_036_5809::
    cp a, $35
    jr nz, Jump_036_5823
    ld a, $AE
    jr Jump_036_5823

Jump_036_5811::
    pop af
    cp a, $AD
    jr nz, Jump_036_581A
    ld a, $34
    jr Jump_036_5823

Jump_036_581A::
    cp a, $AE
    jr nz, Jump_036_5823
    ld a, $35
    jr Jump_036_5823

Jump_036_5822::
    pop af

Jump_036_5823::
    push af
    push hl
    push de
    push bc
    ld [wRecordBuffer], a
    xor a, a
    ld [wCFED], a
    farcall LoadSkillRecord
    pop bc
    pop de
    pop hl
    ld a, [wCFF1]
    swap a
    and a, $0F
    ld [de], a
    inc de
    pop af
    ld [de], a
    inc hl
    inc de
    inc c
    dec b
    jr nz, Jump_036_57E8
    ld a, c
    cp a, $08
    jr z, Jump_036_585B

Jump_036_584D::
    ld a, $00
    ld [de], a
    inc de
    ld a, $FF
    ld [de], a
    inc de
    inc c
    ld a, c
    cp a, $08
    jr nz, Jump_036_584D

Jump_036_585B::
    ret
    INCBIN "dwm2-cobi-us.gbc", $0D985C, $69

; only called from ActionEffect_WindBeast (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_WindBeast)
; reads: wBattleActor, wC58A, wBattleDamageLo, wD873
; writes: wBattleDamageLo, wD873
; points at: wD8B7
ActionEffect_WindBeast_Sub01::
Func_036_58C5:: ; address name
    ld a, [wBattleActor]
    ld hl, wD8B7
    add_a_to_hl
    ld l, [hl]
    ld h, $00
    ld b, h
    ld c, l
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_036_58E8
    ld a, [wBattleActor]
    cp a, $04
    jr c, Jump_036_58E8
    call ShiftBCRight1
    jr Jump_036_58ED

Jump_036_58E8::
    add hl, bc
    add hl, bc
    ld bc, $000A

Jump_036_58ED::
    add hl, bc
    ld bc, $00B4
    call CompareHLToBC
    jr c, Jump_036_58F9
    ld hl, $00B4

Jump_036_58F9::
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    call Func_036_64D4
    call ShiftHLRight1
    ld b, h
    ld c, l
    ld a, l
    cpl
    add a, $01
    ld l, a
    ld a, h
    cpl
    adc a, $00
    ld h, a
    call RandomInRange
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wD873]
    ld h, a
    add hl, de
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_51FC
    ret

; only called from ActionEffect_Vacuum (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Vacuum)
; reads: wBattleActor, wC58A, wBattleDamageLo, wD873
; writes: wBattleDamageLo, wD873
; points at: wD8B7
ActionEffect_Vacuum_Sub01::
Func_036_592E:: ; address name
    ld a, [wBattleActor]
    ld hl, wD8B7
    add_a_to_hl
    ld l, [hl]
    ld h, $00
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_036_594E
    cp a, $04
    jr c, Jump_036_594E
    ld b, h
    ld c, l
    call ShiftBCRight1
    jr Jump_036_5952

Jump_036_594E::
    add hl, hl
    ld bc, $001E

Jump_036_5952::
    add hl, bc
    ld bc, $0096
    call CompareHLToBC
    jr c, Jump_036_595E
    ld hl, $0096

Jump_036_595E::
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    call Func_036_64CD
    call ShiftHLRight2
    ld b, h
    ld c, l
    ld a, l
    cpl
    add a, $01
    ld l, a
    ld a, h
    cpl
    adc a, $00
    ld h, a
    call RandomInRange
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wD873]
    ld h, a
    add hl, de
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_51FC
    ret

; only called from ActionEffect_Lightning (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Lightning)
; reads: wBattleActor, wC58A, wBattleDamageLo, wD873
; writes: wBattleDamageLo, wD873
; points at: wD8B7
ActionEffect_Lightning_Sub01::
Func_036_5993:: ; address name
    ld a, [wBattleActor]
    ld hl, wD8B7
    add_a_to_hl
    ld l, [hl]
    ld h, $00
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_036_59B6
    ld a, [wBattleActor]
    cp a, $04
    jr c, Jump_036_59B6
    ld b, h
    ld c, l
    call ShiftBCRight1
    jr Jump_036_59BA

Jump_036_59B6::
    add hl, hl
    ld bc, $0014

Jump_036_59BA::
    add hl, bc
    push hl
    call GetTargetSpeciesFamily
    cp a, $09
    jr z, Jump_036_59C8
    ld bc, $00B4
    jr Jump_036_59CB

Jump_036_59C8::
    ld bc, $00DC

Jump_036_59CB::
    pop hl
    call CompareHLToBC
    jr c, Jump_036_59D3
    ld l, c
    ld h, b

Jump_036_59D3::
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    call Func_036_64CD
    call ShiftHLRight2
    ld b, h
    ld c, l
    ld a, l
    cpl
    add a, $01
    ld l, a
    ld a, h
    cpl
    adc a, $00
    ld h, a
    call RandomInRange
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wD873]
    ld h, a
    add hl, de
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    call HLToWD814EntryOfWD8A5_Bank36
    call ActionEffect_Lightning_Sub01_Sub01
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActionId, wC58A, wBattleActor, wCFFB, wCFFC, wCFFD, wBattleDamageLo, wD873, ...
; writes: wRecordBuffer, wCFED, wD86A, wBattleDamageLo, wD873
Func_036_5A08:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActionId]
    ld [wRecordBuffer], a
    xor a, a
    ld [wCFED], a
    farcall LoadSkillRecord
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_036_5A33
    ld a, [wBattleActor]
    cp a, $04
    jr c, Jump_036_5A33
    ld a, [wCFFB]
    ld l, a
    ld a, [wCFFC]
    ld h, a
    ld a, [wCFFD]
    jr Jump_036_5A3E

Jump_036_5A33::
    ld a, [wCFF7]
    ld l, a
    ld a, [wCFF8]
    ld h, a
    ld a, [wCFF9]

Jump_036_5A3E::
    ld [wD86A], a
    call Func_036_618F
    call GetTargetSpeciesFamily
    cp a, $07
    jr nz, Jump_036_5A5E
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wD873]
    ld h, a
    call Func_036_646C
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a

Jump_036_5A5E::
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61AB
    rlca
    rlca
    and a, $03
    call Func_036_6232
    ret

; 4 call sites from 4 routines (e.g. ActionEffect_ActionD2_Sub01, ActionEffect_ActionD3_Sub01, ActionEffect_ActionD4_Sub01, ActionEffect_ActionD5)
Func_036_5A6C::
    call Func_036_6159
    call Func_036_61C4
    rrca
    rrca
    and a, $03
    call Func_036_621C
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wBattleDamageLo, wD873
Func_036_5A7A:: ; heuristic: follows a terminator; C0
    ld a, [wBattleTarget]
    call GetBattleHP
    call ScaleHLTo80Percent_Bank36
    inc hl
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61B5
    and a, $03
    call Func_036_621C
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wC58A, wCFC5, wBattleTarget, wBattleDamageLo, wD873
; writes: wBattleDamageLo, wD873
Func_036_5A98:: ; heuristic: follows a terminator; C0
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61B5
    and a, $03
    call Func_036_61D6
    jr nc, Jump_036_5AF5
    ld a, [wBattleActor]
    call GetBattleHP
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    deref_hl
    ld a, h
    or a, a
    jr nz, Jump_036_5ABF
    ld a, l
    cp a, $01
    jr z, Jump_036_5AEB

Jump_036_5ABF::
    ld a, [wC58A]
    or a, a
    jr nz, Jump_036_5AD8
    ld a, [wCFC5]
    or a, a
    jr z, Jump_036_5ACF
    cp a, $01
    jr nz, Jump_036_5AD8

Jump_036_5ACF::
    ld a, [wBattleTarget]
    call GetBattleHP
    dec hl
    jr Jump_036_5AE4

Jump_036_5AD8::
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wD873]
    ld h, a
    dec hl
    call ShiftHLRight1

Jump_036_5AE4::
    ld a, h
    or a, l
    jr nz, Jump_036_5AEB
    ld hl, $0001

Jump_036_5AEB::
    scf
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    ret

Jump_036_5AF5::
    ld hl, $0000
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    xor a, a
    ret

; only called from ActionEffect_Curse (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Curse)
ActionEffect_Curse_Sub01:: ; heuristic: follows a terminator; C0
Func_036_5B02:: ; address name
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61BF
    swap a
    and a, $03
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_5B15
    scf
    ret

Jump_036_5B15::
    call Func_036_620F
    ret

; 2 call sites from 2 routines (e.g. ActionEffect_UltraDown, ActionEffect_Beat)
; reads: wBattleActionId, wD86A
; writes: wD86A
Func_036_5B19:: ; heuristic: follows a terminator; C0
    call Func_036_6141
    jp z, Jump_036_613D
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61B0
    swap a
    and a, $03
    ld [wD86A], a
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_5B35
    scf
    ret

Jump_036_5B35::
    ld a, [wBattleActionId]
    cp a, $13
    jr c, Jump_036_5B4F
    cp a, $14
    jr z, Jump_036_5B4F
    cp a, $79
    jr z, Jump_036_5B4F
    cp a, $82
    jr z, Jump_036_5B56
    ld a, [wD86A]
    call Func_036_61D6
    ret

Jump_036_5B4F::
    ld a, [wD86A]
    call Func_036_620F
    ret

Jump_036_5B56::
    ld a, [wD86A]
    call Func_036_61F9
    ret

; 5 call sites from 5 routines (e.g. ActionEffect_LegSweep_Sub01, ActionEffect_WarCry, ActionEffect_Ahhh, ActionEffect_LushLicks, ...)
; reads: wBattleActionId
Func_036_5B5D:: ; heuristic: follows a terminator; C0
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61BF
    rrca
    rrca
    and a, $03
    ld b, a
    ld a, [wBattleActionId]
    cp a, $7A
    jr z, Jump_036_5B7D
    cp a, $8E
    jr z, Jump_036_5B7D
    cp a, $90
    jr z, Jump_036_5B7D
    ld a, b
    call Func_036_61D6
    jr Jump_036_5B8A

Jump_036_5B7D::
    ld a, b
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_5B87
    scf
    ret

Jump_036_5B87::
    call Func_036_620F

Jump_036_5B8A::
    ret

; only called from ActionEffect_UltraDown (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_UltraDown)
; reads: wBattleTarget
; points at: wBattleDEF, wBattleAGL, wD80D
ActionEffect_UltraDown_Sub01:: ; heuristic: follows a terminator; C0
Func_036_5B8B:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleDEF
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_036_5BC2
    ld a, [wBattleTarget]
    ld hl, wBattleAGL
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_036_5BC2
    ld a, [wBattleTarget]
    ld hl, wD80D
    call AddAx9ToHL
    bit 1, [hl]
    jr z, Jump_036_5BC2
    xor a, a
    ret

Jump_036_5BC2::
    scf
    ret

; only called from ActionEffect_TatsuCall (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_TatsuCall)
; reads: wD871, wRecordBuffer, wCFED, wCFF5, wCFF6, wCFF7, wCFF8, wCFF9, ...
; writes: wMonsterId, wCFE7, wSpeciesIdLo, wSpeciesIdHi, wD868, wD869, wD86A, wD86B
; points at: wBattleStatus, wBattleSlotOut, wDAAE, wBattleMonsterId, wD8B7, wBattleHP, wBattleMaxHP, wBattleMP, ...
ActionEffect_TatsuCall_Sub01:: ; heuristic: follows a terminator; C0
Func_036_5BC4:: ; address name
    ld a, [wD871]
    ld hl, wBattleStatus
    call AddAx9ToHL
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ld a, [wD871]
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld [hl], $00
    ld a, [wD871]
    srl a
    srl a
    and a, $01
    ld hl, wDAAE
    add a, a
    add_a_to_hl
    deref_hl
    ld a, l
    ld [wMonsterId], a
    ld a, h
    ld [wCFE7], a
    farcall LoadMonsterRecord
    ld a, [wRecordBuffer]
    ld c, a
    ld a, [wCFED]
    ld b, a
    ld hl, wBattleMonsterId
    call StoreBCAtWordEntryWD871
    ld a, [wCFF5]
    ld c, a
    ld hl, wD8B7
    call ActionEffect_TatsuCall_Sub01_Sub02
    ld a, [wCFF6]
    ld c, a
    ld a, [wCFF7]
    ld b, a
    ld hl, wBattleHP
    call StoreBCAtWordEntryWD871
    ld a, [wCFF6]
    ld c, a
    ld a, [wCFF7]
    ld b, a
    ld hl, wBattleMaxHP
    call StoreBCAtWordEntryWD871
    ld a, [wCFF8]
    ld c, a
    ld a, [wCFF9]
    ld b, a
    ld hl, wBattleMP
    call StoreBCAtWordEntryWD871
    ld a, [wCFF8]
    ld c, a
    ld a, [wCFF9]
    ld b, a
    ld hl, wBattleMaxMP
    call StoreBCAtWordEntryWD871
    ld a, [wCFFA]
    ld c, a
    ld a, [wCFFB]
    ld b, a
    ld hl, wBattleATK
    call StoreBCAtWordEntryWD871
    ld a, [wCFFC]
    ld c, a
    ld a, [wCFFD]
    ld b, a
    ld hl, wBattleDEF
    call StoreBCAtWordEntryWD871
    ld a, [wCFFE]
    ld c, a
    ld a, [wCFFF]
    ld b, a
    ld hl, wBattleAGL
    call StoreBCAtWordEntryWD871
    ld a, [wD000]
    ld c, a
    ld a, [wD001]
    ld b, a
    ld hl, wBattleINT
    call StoreBCAtWordEntryWD871
    ld bc, $03E7
    ld hl, wD93F
    call StoreBCAtWordEntryWD871
    ld a, [wD002]
    ld c, a
    ld hl, wSlotPersonalityHi
    call ActionEffect_TatsuCall_Sub01_Sub02
    ld a, [wD003]
    ld c, a
    ld hl, wSlotPersonalityLo
    call ActionEffect_TatsuCall_Sub01_Sub02
    ld a, [wD004]
    ld c, a
    ld hl, wSlotPersonalityMid
    call ActionEffect_TatsuCall_Sub01_Sub02
    ld a, [wD005]
    ld c, a
    ld hl, wD980
    call ActionEffect_TatsuCall_Sub01_Sub02
    ld c, $00
    ld hl, wD8A7
    call ActionEffect_TatsuCall_Sub01_Sub02
    ld c, $00
    ld hl, wD8AF
    call ActionEffect_TatsuCall_Sub01_Sub02
    ld a, [wD871]
    ld c, a
    farcall Func_019_4298
    ld a, [wRecordBuffer]
    ld l, a
    ld a, [wCFED]
    ld h, a
    ld a, l
    ld [wSpeciesIdLo], a
    ld a, h
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld hl, wD01A
    ld a, l
    ld [wD868], a
    ld a, h
    ld [wD869], a
    ld a, [wD871]
    ld c, a
    add a, a
    add a, c
    add a, a
    add a, c
    ld de, wDA72
    add a, e
    ld e, a
    jr nc, Jump_036_5D0B
    inc d

Jump_036_5D0B::
    ld a, e
    ld [wD86A], a
    ld a, d
    ld [wD86B], a
    farcall Func_019_44B9
    ld hl, wRecordBufferData
    ld de, wC0A0
    ld bc, $0004
    call CopyBytes
    ld hl, wC0A0
    call ActionEffect_TatsuCall_Sub01_Sub01
    ret

; only called from ActionEffect_TatsuCall_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_TatsuCall_Sub01)
; reads: wD871, wCFF1
; writes: wRecordBuffer, wD868, wCFED, wD869, wD86A, wD86B
; points at: wD989, wCFF1
ActionEffect_TatsuCall_Sub01_Sub01::
Func_036_5D2C:: ; address name
    ld b, $04
    ld a, [wD871]
    ld de, wD989
    swap a
    add a, e
    ld e, a
    jr nc, Jump_036_5D3B
    inc d

Jump_036_5D3B::
    ld a, [hl]
    cp a, $FF
    ret z
    push hl
    push bc
    ld a, [hl]
    ld [de], a
    dec de
    push de
    ld [wRecordBuffer], a
    ld a, $03
    ld [wD868], a
    xor a, a
    ld [wCFED], a
    ld a, $01
    ld [wD869], a
    ld hl, wCFF1
    ld a, l
    ld [wD86A], a
    ld a, h
    ld [wD86B], a
    farcall LoadSkillRecordPart
    ld a, [wCFF1]
    swap a
    and a, $0F
    pop de
    ld [de], a
    inc de
    inc de
    inc de
    pop bc
    pop hl
    inc hl
    dec b
    jr nz, Jump_036_5D3B
    ret

; only called from ActionEffect_TatsuCall_Sub01 (E-0047)
; 7 call sites from 1 routine (e.g. ActionEffect_TatsuCall_Sub01)
; reads: wD871
ActionEffect_TatsuCall_Sub01_Sub02::
Func_036_5D7A:: ; address name
    ld a, [wD871]
    add_a_to_hl
    ld [hl], c
    ret

; HL = table: stores BC (low byte first) at HL + 2 * wD871 (E-0073)
; 10 call sites from 1 routine (e.g. ActionEffect_TatsuCall_Sub01)
; reads: wD871
StoreBCAtWordEntryWD871::
Func_036_5D84:: ; address name
    ld a, [wD871]
    add a, a
    add_a_to_hl
    ld [hl], c
    inc hl
    ld [hl], b
    ret

; only called from ActionEffect_LegSweep (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_LegSweep)
; reads: wBattleTarget
; points at: wD8A7
ActionEffect_LegSweep_Sub01:: ; heuristic: follows a terminator; C0
Func_036_5D91:: ; address name
    ld a, [wBattleTarget]
    ld hl, wD8A7
    add_a_to_hl
    bit 4, [hl]
    ret nz
    call Func_036_5B5D
    ret

; only called from ActionEffect_DanceShut (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_DanceShut)
ActionEffect_DanceShut_Sub01:: ; heuristic: follows a terminator; C0
Func_036_5DA3:: ; address name
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61BF
    and a, $03
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_5DB4
    scf
    ret

Jump_036_5DB4::
    call Func_036_61D6
    ret

; only called from ActionEffect_MouthShut (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_MouthShut)
ActionEffect_MouthShut_Sub01:: ; heuristic: follows a terminator; C0
Func_036_5DB8:: ; address name
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61C4
    rlca
    rlca
    and a, $03
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_5DCB
    scf
    ret

Jump_036_5DCB::
    call Func_036_61D6
    ret

; only called from ActionEffect_CallHelp (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_CallHelp)
; reads: wBattleActor, wC58A
; writes: wBattleDamageLo, wD873
; points at: wD8B7
ActionEffect_CallHelp_Sub01:: ; heuristic: follows a terminator; C0
Func_036_5DCF:: ; address name
    ld a, [wBattleActor]
    ld hl, wD8B7
    add_a_to_hl
    ld l, [hl]
    ld h, $00
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_036_5DF4
    ld a, [wBattleActor]
    cp a, $04
    jr c, Jump_036_5DF4
    push hl
    srl h
    rr l
    pop bc
    add hl, bc
    jr Jump_036_5DF5

Jump_036_5DF4::
    add hl, hl

Jump_036_5DF5::
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61C4
    swap a
    and a, $03
    call Func_036_621C
    ret
    INCBIN "dwm2-cobi-us.gbc", $0D9E0B, $CD

; only called from ActionEffect_Sacrifice (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Sacrifice)
; reads: wBattleActionId
ActionEffect_Sacrifice_Sub01::
Func_036_5ED8:: ; address name
    call Func_036_6141
    jp z, Jump_036_613D
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61B5
    and a, $03
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_5EEF
    scf
    ret

Jump_036_5EEF::
    push af
    ld a, [wBattleActionId]
    cp a, $D6
    jr z, Jump_036_5EFC
    pop af
    call ActionEffect_Sacrifice_Sub01_Sub01
    ret

Jump_036_5EFC::
    pop af
    call Func_036_6346
    ret

; 2 call sites from 2 routines (e.g. ResolveStep0EEffect_Case00_Sub02, ActionEffect_Sleep)
; reads: wBattleActionId, wD86A
; writes: wD86A
Func_036_5F01::
    call Func_036_6159
    call Func_036_61B0
    rlca
    rlca
    and a, $03
    ld [wD86A], a
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_5F17
    scf
    ret

Jump_036_5F17::
    ld a, [wBattleActionId]
    cp a, $2F
    ld a, [wD86A]
    jp z, Func_036_61D6
    jp Func_036_620F

; only called from ActionEffect_BeDragon (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_BeDragon)
; reads: wBattleActionId, wCFF6, wCFF7, wBattleActor, wCFF8, wCFF9, wCFFA, wCFFB, ...
; writes: wMonsterId, wCFE7, wSpeciesIdLo, wSpeciesIdHi, wD868, wD869, wD86A, wD86B
; points at: wBattleMaxHP, wBattleHP, wBattleMaxMP, wBattleMP, wBattleATK, wBattleDEF, wBattleAGL, wBattleINT, ...
ActionEffect_BeDragon_Sub02:: ; heuristic: follows a terminator; C0
Func_036_5F25:: ; address name
    ld hl, $0082
    ld a, [wBattleActionId]
    cp a, $DC
    jr nz, Jump_036_5F32
    ld hl, $0262

Jump_036_5F32::
    ld a, l
    ld [wMonsterId], a
    ld a, h
    ld [wCFE7], a
    farcall LoadMonsterRecord
    ld a, [wCFF6]
    ld c, a
    ld a, [wCFF7]
    ld b, a
    ld hl, wBattleMaxHP
    call StoreBCAtActorWordEntry
    ld a, [wBattleActor]
    ld hl, wBattleHP
    call ActionEffect_BeDragon_Sub02_Sub02
    ld a, [wCFF8]
    ld c, a
    ld a, [wCFF9]
    ld b, a
    ld hl, wBattleMaxMP
    call StoreBCAtActorWordEntry
    ld a, [wBattleActor]
    ld hl, wBattleMP
    call ActionEffect_BeDragon_Sub02_Sub02
    ld a, [wCFFA]
    ld c, a
    ld a, [wCFFB]
    ld b, a
    ld hl, wBattleATK
    call StoreBCAtActorWordEntry
    ld a, [wCFFC]
    ld c, a
    ld a, [wCFFD]
    ld b, a
    ld hl, wBattleDEF
    call StoreBCAtActorWordEntry
    ld a, [wCFFE]
    ld c, a
    ld a, [wCFFF]
    ld b, a
    ld hl, wBattleAGL
    call StoreBCAtActorWordEntry
    ld a, [wD000]
    ld c, a
    ld a, [wD001]
    ld b, a
    ld hl, wBattleINT
    call StoreBCAtActorWordEntry
    ld a, [wRecordBuffer]
    ld l, a
    ld a, [wCFED]
    ld h, a
    ld a, l
    ld [wSpeciesIdLo], a
    ld a, h
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wBattleActor]
    ld c, a
    farcall Func_019_4298
    ld hl, wD01A
    ld a, l
    ld [wD868], a
    ld a, h
    ld [wD869], a
    ld a, [wBattleActor]
    ld c, a
    add a, a
    add a, c
    add a, a
    add a, c
    ld de, wDA72
    add a, e
    ld e, a
    jr nc, Jump_036_5FE1
    inc d

Jump_036_5FE1::
    ld a, e
    ld [wD86A], a
    ld a, d
    ld [wD86B], a
    farcall Func_019_44B9
    ld hl, wRecordBufferData
    ld de, wC0A0
    ld bc, $0004
    call CopyBytes
    call ActionEffect_BeDragon_Sub02_Sub01
    ld a, [wBattleActor]
    ld hl, wD8A7
    add_a_to_hl
    ld [hl], $00
    ld a, [wBattleActor]
    call SetBit0OfWD095Indexed_Bank36
    ld a, [wBattleActor]
    call SetBit1OfWD095Indexed_Bank36
    ret

; only called from ActionEffect_BeDragon_Sub02 (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_BeDragon_Sub02)
; reads: wBattleActor, wCFF1
; writes: wRecordBuffer, wD868, wCFED, wD869, wD86A, wD86B
; points at: wC0A0, wD989, wCFF1
ActionEffect_BeDragon_Sub02_Sub01::
Func_036_6018:: ; address name
    ld hl, wC0A0
    ld b, $04
    ld a, [wBattleActor]
    ld de, wD989
    swap a
    add a, e
    ld e, a
    jr nc, Jump_036_602A
    inc d

Jump_036_602A::
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_036_6034
    call ActionEffect_BeDragon_Sub02_Sub01_Sub01
    jr Jump_036_606A

Jump_036_6034::
    push hl
    push bc
    ld a, [hl]
    ld [de], a
    dec de
    push de
    ld [wRecordBuffer], a
    ld a, $03
    ld [wD868], a
    xor a, a
    ld [wCFED], a
    ld a, $01
    ld [wD869], a
    ld hl, wCFF1
    ld a, l
    ld [wD86A], a
    ld a, h
    ld [wD86B], a
    farcall LoadSkillRecordPart
    ld a, [wCFF1]
    swap a
    and a, $0F
    pop de
    pop bc
    pop hl
    ld [de], a
    inc de
    inc de
    inc de

Jump_036_606A::
    inc hl
    dec b
    jr nz, Jump_036_602A
    call ActionEffect_BeDragon_Sub02_Sub01_Sub01
    call ActionEffect_BeDragon_Sub02_Sub01_Sub01
    call ActionEffect_BeDragon_Sub02_Sub01_Sub01

; only called from ActionEffect_BeDragon_Sub02_Sub01 (E-0047)
; 4 call sites from 1 routine (e.g. ActionEffect_BeDragon_Sub02_Sub01)
ActionEffect_BeDragon_Sub02_Sub01_Sub01::
Func_036_6077:: ; address name
    ld a, $FF
    ld [de], a
    dec de
    xor a, a
    ld [de], a
    inc de
    inc de
    inc de
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
Func_036_6081:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    add_a_to_hl
    ld [hl], c
    ret

; HL = table: stores BC (low byte first) at HL + 2 * wBattleActor; HL ends on the high byte (E-0077)
; 6 call sites from 1 routine (e.g. ActionEffect_BeDragon_Sub02)
; reads: wBattleActor
StoreBCAtActorWordEntry::
Func_036_608B:: ; address name
    ld a, [wBattleActor]
    add a, a
    add_a_to_hl
    ld [hl], c
    inc hl
    ld [hl], b
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wBattleATK
Func_036_6098:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    ld hl, wBattleATK
    call AddDoubleAToHL_Bank36
    push hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    push bc
    ld a, $00
    ld [hl-], a
    ld [hl], $C8
    call ComputeAttackDamage
    pop bc
    pop hl
    ld a, c
    ld [hl+], a
    ld [hl], b
    ret

; only called from ActionEffect_Watershot (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Watershot)
; reads: wBattleActionId
ActionEffect_Watershot_Sub01:: ; heuristic: follows a terminator; C0
Func_036_60B4:: ; address name
    call Func_036_6159
    call Func_036_61A6
    swap a
    rrca
    rrca
    and a, $03
    ld b, a
    ld a, [wBattleActionId]
    cp a, $4C
    ld a, b
    jr z, Jump_036_60CD
    call Func_036_6232
    ret

Jump_036_60CD::
    call Func_036_621C
    ret

; 3 call sites from 3 routines (e.g. ActionEffect_PoisonGas, ResolveStep0EEffect_Case00, Func_03B_4D1C)
Func_036_60D1::
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61BA
    and a, $03
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_60E2
    scf
    ret

Jump_036_60E2::
    call Func_036_620F
    ld e, $00
    ret c
    ld e, $01
    ret

; 2 call sites from 2 routines (e.g. ActionEffect_PalsyAir, ResolveStep0EEffect_Case00)
Func_036_60EB::
    call Func_036_6141
    jp z, Jump_036_613D
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61BF
    rlca
    rlca
    and a, $03
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_6104
    scf
    ret

Jump_036_6104::
    call Func_036_620F
    ld e, $00
    ret c
    ld e, $01
    ret

; only called from ResolveStep0EEffect_Case00 (E-0047)
; 1 call site from 1 routine (e.g. ResolveStep0EEffect_Case00)
ResolveStep0EEffect_Case00_Sub02::
Func_036_610D:: ; address name
    call Func_036_5F01
    ld e, $00
    ret c
    ld e, $01
    ret

; only called from ActionEffect_Geyser (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Geyser)
ActionEffect_Geyser_Sub01:: ; heuristic: follows a terminator; C0
Func_036_6116:: ; address name
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61A6
    swap a
    rrca
    rrca
    and a, $03
    call Func_036_61D6
    ret

; only called from ActionEffect_EerieLite (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_EerieLite)
ActionEffect_EerieLite_Sub01:: ; heuristic: follows a terminator; C0
Func_036_6126:: ; address name
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61B0
    swap a
    and a, $03
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_6139
    scf
    ret

Jump_036_6139::
    call Func_036_61D6
    ret

Jump_036_613D::
    xor a, a
    ld e, $01
    ret

; 3 call sites from 3 routines (e.g. Func_036_60EB, Func_036_5B19, ActionEffect_Sacrifice_Sub01)
; reads: wCFC5, wBattleActor
Func_036_6141::
    ld a, [wCFC5]
    cp a, $02
    jr z, Jump_036_614C
    cp a, $03
    jr nz, Jump_036_6155

Jump_036_614C::
    ld a, [wBattleActor]
    cp a, $04
    jr nc, Jump_036_6155
    xor a, a
    ret

Jump_036_6155::
    ld a, $01
    or a, a
    ret

; 15 call sites from 15 routines (e.g. Func_036_5F01, ActionEffect_ActionD1_Sub01, ActionEffect_Watershot_Sub01, Func_036_5A6C, ...)
; reads: wC58A, wBattleActor, wCFFB, wCFFC, wCFFD, wBattleTarget, wCFF7, wCFF8, ...
; writes: wD86A
; points at: wD814
Func_036_6159::
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_036_6174
    ld a, [wBattleActor]
    bit 2, a
    jr z, Jump_036_6174
    ld a, [wCFFB]
    ld l, a
    ld a, [wCFFC]
    ld h, a
    ld a, [wCFFD]
    jr Jump_036_617F

Jump_036_6174::
    ld a, [wCFF7]
    ld l, a
    ld a, [wCFF8]
    ld h, a
    ld a, [wCFF9]

Jump_036_617F::
    ld [wD86A], a
    call Func_036_618F

; HL = wD814 + 9 * [wD8A5] (AddAx9ToHL); A = [wD8A5] (the same 10 bytes appear in 2 banks)
; 27 call sites from 27 routines (e.g. Func_036_55FB, Func_036_60D1, Func_036_60EB, ActionEffect_Geyser_Sub01, ...)
; reads: wBattleTarget
; points at: wD814
HLToWD814EntryOfWD8A5_Bank36::
Func_036_6185:: ; address name
    ld a, [wBattleTarget]
    ld hl, wD814
    call AddAx9ToHL
    ret

; 2 call sites from 2 routines (e.g. Func_036_6159, Func_036_5A08)
; reads: wD86A
; writes: wBattleDamageLo, wD873
Func_036_618F::
    push hl
    ld a, [wD86A]
    ld c, a
    ld b, $00
    add hl, bc
    ld c, l
    ld b, h
    pop hl
    call RandomInRange
    ld a, e
    ld [wBattleDamageLo], a
    ld a, d
    ld [wD873], a
    ret

; 7 call sites from 7 routines (e.g. ActionEffect_Geyser_Sub01, Func_036_5522, ActionEffect_Watershot_Sub01, ActionEffect_BigBang_Sub01, ...)
; reads: wBattleTarget
; points at: wDA72
Func_036_61A6::
    ld de, wDA72
    jr Jump_036_61C7

; 8 call sites from 8 routines (e.g. Func_036_55FB, Func_036_5533, Func_036_5544, Func_036_5555, ...)
; reads: wBattleTarget
; points at: wDA73
Func_036_61AB::
    ld de, wDA73
    jr Jump_036_61C7

; 5 call sites from 5 routines (e.g. Func_036_5F01, ActionEffect_RobMagic_Sub01, ActionEffect_EerieLite_Sub01, ActionEffect_StopSpell_Sub01, ...)
; reads: wBattleTarget
; points at: wDA74
Func_036_61B0::
    ld de, wDA74
    jr Jump_036_61C7

; 6 call sites from 6 routines (e.g. Func_036_5A7A, ActionEffect_PanicAll_Sub01, Func_036_5A98, Func_036_53C6, ...)
; reads: wBattleTarget
; points at: wDA75
Func_036_61B5::
    ld de, wDA75
    jr Jump_036_61C7

; 3 call sites from 3 routines (e.g. Func_036_60D1, ActionEffect_FrigidAir_Sub01, ActionEffect_FireAir_Sub01)
; reads: wBattleTarget
; points at: wDA76
Func_036_61BA::
    ld de, wDA76
    jr Jump_036_61C7

; 4 call sites from 4 routines (e.g. Func_036_60EB, ActionEffect_Curse_Sub01, Func_036_5B5D, ActionEffect_DanceShut_Sub01)
; reads: wBattleTarget
; points at: wDA77
Func_036_61BF::
    ld de, wDA77
    jr Jump_036_61C7

; 4 call sites from 4 routines (e.g. Func_036_5A6C, ActionEffect_MouthShut_Sub01, ActionEffect_CallHelp_Sub01, ActionEffect_RockThrow_Sub01)
; reads: wBattleTarget
; points at: wDA78
Func_036_61C4::
    ld de, wDA78

Jump_036_61C7::
    ld a, [wBattleTarget]
    ld b, a
    add a, a
    add a, b
    add a, a
    add a, b
    add a, e
    ld e, a
    jr nc, Jump_036_61D4
    inc d

Jump_036_61D4::
    ld a, [de]
    ret

; 12 call sites from 12 routines (e.g. Func_036_55FB, ActionEffect_Geyser_Sub01, ActionEffect_RobMagic_Sub01, ActionEffect_EerieLite_Sub01, ...)
Func_036_61D6::
    bit 6, [hl]
    jr z, Jump_036_61DF
    call Func_036_629B
    jr Jump_036_61EB

Jump_036_61DF::
    bit 7, [hl]
    jr z, Jump_036_61E8
    call Func_036_628E
    jr Jump_036_61EB

Jump_036_61E8::
    call Func_036_6278

Jump_036_61EB::
    ret

; only called from ActionEffect_Sacrifice_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Sacrifice_Sub01)
ActionEffect_Sacrifice_Sub01_Sub01:: ; heuristic: follows a terminator; C0
Func_036_61EC:: ; address name
    bit 6, [hl]
    jr z, Jump_036_61F5
    call Func_036_6278
    jr Jump_036_61F8

Jump_036_61F5::
    call Func_036_628E

Jump_036_61F8::
    ret

; 2 call sites from 2 routines (e.g. Func_036_55FB, Func_036_5B19)
Func_036_61F9::
    bit 6, [hl]
    jr z, Jump_036_6202
    call Func_036_62B1
    jr Jump_036_620E

Jump_036_6202::
    bit 7, [hl]
    jr z, Jump_036_620B
    call Func_036_628E
    jr Jump_036_620E

Jump_036_620B::
    call Func_036_629B

Jump_036_620E::
    ret

; 7 call sites from 7 routines (e.g. Func_036_60D1, Func_036_60EB, ActionEffect_PanicAll_Sub01, ActionEffect_Curse_Sub01, ...)
Func_036_620F::
    bit 7, [hl]
    jr z, Jump_036_6218
    call Func_036_6278
    jr Jump_036_621B

Jump_036_6218::
    call Func_036_62B1

Jump_036_621B::
    ret

; 12 call sites from 12 routines (e.g. ActionEffect_ActionD1_Sub01, ActionEffect_Watershot_Sub01, Func_036_5A6C, Func_036_5A7A, ...)
Func_036_621C:: ; heuristic: follows a terminator; C0
    bit 6, [hl]
    jr z, Jump_036_6225
    call Func_036_62EF
    jr Jump_036_6231

Jump_036_6225::
    bit 7, [hl]
    jr z, Jump_036_622E
    call Func_036_6302
    jr Jump_036_6231

Jump_036_622E::
    call Func_036_62DC

Jump_036_6231::
    ret

; 5 call sites from 5 routines (e.g. ActionEffect_Watershot_Sub01, ActionEffect_FrigidAir_Sub01, ActionEffect_FireAir_Sub01, ActionEffect_BigBang_Sub01, ...)
Func_036_6232:: ; heuristic: follows a terminator; C0
    bit 6, [hl]
    jr z, Jump_036_623B
    call Func_036_6319
    jr Jump_036_6247

Jump_036_623B::
    bit 7, [hl]
    jr z, Jump_036_6244
    call Func_036_6302
    jr Jump_036_6247

Jump_036_6244::
    call Func_036_62EF

Jump_036_6247::
    ret

; 4 call sites from 4 routines (e.g. Func_036_5522, Func_036_5533, Func_036_5544, Func_036_5555)
Func_036_6248::
    bit 6, [hl]
    jr z, Jump_036_6251
    call Func_036_62DC
    jr Jump_036_6254

Jump_036_6251::
    call Func_036_6302

Jump_036_6254::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_036_6255:: ; heuristic: follows a terminator; C0
    bit 7, [hl]
    jr z, Jump_036_625E
    call Func_036_62DC
    jr Jump_036_6261

Jump_036_625E::
    call Func_036_6319

Jump_036_6261::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_036_6262:: ; heuristic: follows a terminator; C0
    bit 6, [hl]
    jr z, Jump_036_626B
    call Func_036_629B
    jr Jump_036_6277

Jump_036_626B::
    bit 7, [hl]
    jr z, Jump_036_6274
    call Func_036_6346
    jr Jump_036_6277

Jump_036_6274::
    call Func_036_6330

Jump_036_6277::
    ret

; 3 call sites from 3 routines (e.g. Func_036_61D6, Func_036_620F, ActionEffect_Sacrifice_Sub01_Sub01)
; reads: wC5E7
Func_036_6278::
    and a, a
    jr nz, Jump_036_627D
    scf
    ret

Jump_036_627D::
    cp a, $01
    jr nz, Jump_036_6284
    jp Jump_036_636A

Jump_036_6284::
    cp a, $02
    jr nz, Jump_036_628B
    jp Jump_036_637C

Jump_036_628B::
    scf
    ccf
    ret

; 3 call sites from 3 routines (e.g. Func_036_61D6, Func_036_61F9, ActionEffect_Sacrifice_Sub01_Sub01)
; reads: wC5E7
Func_036_628E::
    cp a, $02
    jr nc, Jump_036_6293
    ret

Jump_036_6293::
    jr nz, Jump_036_6298
    jp Jump_036_6373

Jump_036_6298::
    scf
    ccf
    ret

; 3 call sites from 3 routines (e.g. Func_036_61D6, Func_036_61F9, Func_036_6262)
; reads: wC5E7
Func_036_629B::
    and a, a
    jr nz, Jump_036_62A0
    scf
    ret

Jump_036_62A0::
    cp a, $01
    jr nz, Jump_036_62A7
    jp Jump_036_6373

Jump_036_62A7::
    cp a, $02
    jr nz, Jump_036_62AE
    jp Jump_036_6385

Jump_036_62AE::
    scf
    ccf
    ret

; 2 call sites from 2 routines (e.g. Func_036_61F9, Func_036_620F)
; reads: wC58A, wBattleTarget, wC5E7
Func_036_62B1::
    push af
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_036_62C4
    ld a, [wBattleTarget]
    cp a, $04
    jr nc, Jump_036_62C4
    pop af
    jp Jump_036_6353

Jump_036_62C4::
    pop af
    and a, a
    jr nz, Jump_036_62CB
    jp Jump_036_6373

Jump_036_62CB::
    cp a, $01
    jr nz, Jump_036_62D2
    jp Jump_036_637C

Jump_036_62D2::
    cp a, $02
    jr nz, Jump_036_62D9
    jp Jump_036_6397

Jump_036_62D9::
    scf
    ccf
    ret

; 3 call sites from 3 routines (e.g. Func_036_621C, Func_036_6248, Func_036_6255)
; reads: wBattleDamageLo, wD873
; writes: wBattleDamageLo, wD873
Func_036_62DC:: ; heuristic: follows a terminator; C0
    and a, a
    ret z
    cp a, $01
    jr nz, Jump_036_62E5
    jp Jump_036_63D1

Jump_036_62E5::
    cp a, $02
    jr nz, Jump_036_62EC
    jp Jump_036_63F9

Jump_036_62EC::
    jp Jump_036_6449

; 2 call sites from 2 routines (e.g. Func_036_621C, Func_036_6232)
; reads: wBattleDamageLo, wD873
; writes: wBattleDamageLo, wD873
Func_036_62EF::
    and a, a
    ret z
    cp a, $01
    jr nz, Jump_036_62F8
    jp Jump_036_63E5

Jump_036_62F8::
    cp a, $02
    jr nz, Jump_036_62FF
    jp Func_036_640D

Jump_036_62FF::
    jp Jump_036_6449

; 3 call sites from 3 routines (e.g. Func_036_621C, Func_036_6248, Func_036_6232)
; reads: wBattleDamageLo, wD873
; writes: wBattleDamageLo, wD873
Func_036_6302::
    and a, a
    jr nz, Jump_036_6308
    jp Jump_036_63A9

Jump_036_6308::
    cp a, $01
    jr nz, Jump_036_630F
    jp Jump_036_63BD

Jump_036_630F::
    cp a, $02
    jr nz, Jump_036_6316
    jp Jump_036_63E5

Jump_036_6316::
    jp Jump_036_6421

; 2 call sites from 2 routines (e.g. Func_036_6255, Func_036_6232)
; reads: wBattleDamageLo, wD873
; writes: wBattleDamageLo, wD873
Func_036_6319:: ; heuristic: follows a terminator; C0
    and a, a
    jr nz, Jump_036_631F
    jp Jump_036_63E5

Jump_036_631F::
    cp a, $01
    jr nz, Jump_036_6326
    jp Jump_036_63F9

Jump_036_6326::
    cp a, $02
    jr nz, Jump_036_632D
    jp Jump_036_6435

Jump_036_632D::
    jp Jump_036_6449

; 1 call site from 1 routine (e.g. Func_036_6262)
; reads: wC5E7
Func_036_6330:: ; heuristic: follows a terminator; C0
    and a, a
    jr nz, Jump_036_6335
    scf
    ret

Jump_036_6335::
    cp a, $01
    jr nz, Jump_036_633C
    jp Jump_036_6373

Jump_036_633C::
    cp a, $02
    jr nz, Jump_036_6343
    jp Jump_036_637C

Jump_036_6343::
    jp Jump_036_6397

; 2 call sites from 2 routines (e.g. Func_036_6262, ActionEffect_Sacrifice_Sub01)
; reads: wC5E7
Func_036_6346::
    cp a, $02
    jr nc, Jump_036_634B
    ret

Jump_036_634B::
    jr nz, Jump_036_6350
    jp Jump_036_6373

Jump_036_6350::
    jp Jump_036_6385

Jump_036_6353::
    and a, a
    jr nz, Jump_036_6359
    jp Jump_036_637C

Jump_036_6359::
    cp a, $01
    jr nz, Jump_036_6360
    jp Jump_036_638E

Jump_036_6360::
    cp a, $02
    jr nz, Jump_036_6367
    jp Jump_036_63A0

Jump_036_6367::
    scf
    ccf
    ret

Jump_036_636A::
    call AdvanceRandom
    ld a, [wC5E7]
    cp a, $D8
    ret

Jump_036_6373::
    call AdvanceRandom
    ld a, [wC5E7]
    cp a, $BF
    ret

Jump_036_637C::
    call AdvanceRandom
    ld a, [wC5E7]
    cp a, $7F
    ret

Jump_036_6385::
    call AdvanceRandom
    ld a, [wC5E7]
    cp a, $66
    ret

Jump_036_638E::
    call AdvanceRandom
    ld a, [wC5E7]
    cp a, $4C
    ret

Jump_036_6397::
    call AdvanceRandom
    ld a, [wC5E7]
    cp a, $3F
    ret

Jump_036_63A0::
    call AdvanceRandom
    ld a, [wC5E7]
    cp a, $26
    ret

Jump_036_63A9::
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wD873]
    ld h, a
    call Func_036_646C
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    ret

Jump_036_63BD::
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wD873]
    ld h, a
    call Func_036_6477
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    ret

Jump_036_63D1::
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wD873]
    ld h, a
    call Func_036_6494
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    ret

Jump_036_63E5::
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wD873]
    ld h, a
    call Func_036_64B2
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    ret

Jump_036_63F9::
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wD873]
    ld h, a
    call ShiftHLRight1
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    ret

; 1 call site from 1 routine (e.g. Func_036_5223)
; reads: wBattleDamageLo, wD873
; writes: wBattleDamageLo, wD873
Func_036_640D::
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wD873]
    ld h, a
    call Func_036_64CD
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    ret

Jump_036_6421::
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wD873]
    ld h, a
    call Func_036_64D4
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    ret

Jump_036_6435::
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wD873]
    ld h, a
    call ShiftHLRight2
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    ret

Jump_036_6449::
    xor a, a
    ld [wBattleDamageLo], a
    ld [wD873], a
    ret

; 3 call sites from 3 routines (e.g. ActionEffect_ActionD2_Sub01, ActionEffect_ActionD3_Sub01, ActionEffect_ActionD4_Sub01)
; reads: wBattleDamageLo, wD873
; writes: wBattleDamageLo, wD873
Func_036_6451::
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wD873]
    ld h, a
    call Func_036_6465
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    ret

; 3 call sites from 3 routines (e.g. Func_036_6451, Func_036_55D4, ActionEffect_PsycheUp)
Func_036_6465::
    ld b, h
    ld c, l
    call ShiftHLRight1
    add hl, bc
    ret

; 2 call sites from 2 routines (e.g. Func_036_6346, Func_036_5A08)
Func_036_646C::
    ld b, h
    ld c, l
    call Func_036_6507
    add hl, bc
    call Func_036_6507
    add hl, bc
    ret

; 1 call site from 1 routine (e.g. Func_036_6346)
Func_036_6477::
    ld b, h
    ld c, l
    call Func_036_6503
    add hl, bc
    call Func_036_6507
    add hl, bc
    ret

; no direct call (reached through a table, a jump or a vector)
Func_036_6482:: ; heuristic: follows a terminator; C0
    call ShiftHLRight1
    ld b, h
    ld c, l
    call ShiftBCRight1
    add hl, bc
    call ShiftBCRight1
    add hl, bc
    call Func_036_6507
    add hl, bc
    ret

; 1 call site from 1 routine (e.g. Func_036_6346)
Func_036_6494::
    push de
    ld b, h
    ld c, l
    ld a, $55
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    pop de
    ret

; HL = HL * 8 / 10 (24-bit intermediate; Multiply8By16 then Divide24ByA), A = the remainder; DE kept (E-0067) (the same 15 bytes appear in 2 banks)
; 3 call sites from 3 routines (e.g. Func_036_64CD, ActionEffect_Geyser_Sub03, Func_036_5A7A)
ScaleHLTo80Percent_Bank36::
Func_036_64A3:: ; address name
    push de
    ld b, h
    ld c, l
    ld a, $08
    call Multiply8By16
    ld a, $0A
    call Divide24ByA
    pop de
    ret

; 1 call site from 1 routine (e.g. Func_036_6346)
Func_036_64B2::
    push bc
    call ShiftHLRight1
    ld b, h
    ld c, l
    call ShiftBCRight1
    add hl, bc
    pop bc
    ret

; 2 call sites from 2 routines (e.g. ActionEffect_Geyser_Sub02, Func_036_64D4)
Func_036_64BE::
    push de
    ld b, h
    ld c, l
    ld a, $06
    call Multiply8By16
    ld a, $0A
    call Divide24ByA
    pop de
    ret

; 3 call sites from 3 routines (e.g. Func_036_640D, ActionEffect_Lightning_Sub01, ActionEffect_Vacuum_Sub01)
Func_036_64CD::
    call ScaleHLTo80Percent_Bank36
    call ShiftHLRight1
    ret

; 2 call sites from 2 routines (e.g. Func_036_640D, ActionEffect_WindBeast_Sub01)
Func_036_64D4::
    call Func_036_64BE
    call ShiftHLRight1
    ret

; 4 call sites from 4 routines (e.g. ResolveStepDamageMessage_Sub04_Sub01_Sub01, Func_036_5441, Func_036_5360, ActionEffect_UltraDown_Sub02_Sub01)
Func_036_64DB::
    ld bc, $0003
    call DivideHLByBC
    ret

; only called from ActionEffect_Geyser (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Geyser)
ActionEffect_Geyser_Sub02:: ; heuristic: follows a terminator; C0
Func_036_64E2:: ; address name
    call Func_036_64BE
    call ShiftHLRight1
    call ShiftHLRight1
    ret

; only called from ActionEffect_Geyser (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Geyser)
ActionEffect_Geyser_Sub03:: ; heuristic: follows a terminator; C0
Func_036_64EC:: ; address name
    call ScaleHLTo80Percent_Bank36
    call ShiftHLRight1
    call ShiftHLRight1
    call ShiftHLRight1
    call ShiftHLRight1
    ret

; 1 call site from 1 routine (e.g. Func_036_6558)
Func_036_64FC:: ; heuristic: follows a terminator; C0
    call AddDoubleAToHL_Bank36
    deref_hl
    ret

; 1 call site from 1 routine (e.g. Func_036_6477)
Func_036_6503::
    srl b
    rr c

; 4 call sites from 3 routines (e.g. Func_036_646C, Func_036_6477, Func_036_6482)
Func_036_6507::
    srl b
    rr c

; BC >>= 1 (unsigned) (E-0064)
; 11 call sites from 10 routines (e.g. ResolveStepDamageMessage_Sub04_Sub01_Sub01, Func_036_64B2, ComputeAttackDamage, Func_036_6482, ...)
ShiftBCRight1::
Func_036_650B:: ; address name
    srl b
    rr c
    ret

; HL >>= 4 (unsigned): two shifts, then falls through ShiftHLRight2 (E-0064)
; 3 call sites from 1 routine (e.g. ComputeBasicDamage)
ShiftHLRight4:: ; heuristic: follows a terminator; C0
Func_036_6510:: ; address name
    srl h
    rr l
    srl h
    rr l

; HL >>= 2 (unsigned): one shift, then falls through ShiftHLRight1 (E-0064)
; 3 call sites from 3 routines (e.g. Func_036_640D, ActionEffect_Lightning_Sub01, ActionEffect_Vacuum_Sub01)
ShiftHLRight2::
Func_036_6518:: ; address name
    srl h
    rr l

; HL >>= 1 (unsigned) (E-0064)
; 15 call sites from 11 routines (e.g. Func_036_7D13, ActionEffect_Geyser_Sub02, Func_036_6346, Func_036_64B2, ...)
ShiftHLRight1::
Func_036_651C:: ; address name
    srl h
    rr l
    ret

; 2 call sites from 1 routine (e.g. Func_036_5360)
; reads: wD868, wC58A
; writes: wD868
Func_036_6521:: ; heuristic: follows a terminator; C0
    ld [wD868], a
    call GetBattleDEF
    ld bc, $03E7
    call CompareHLToBC
    jr nc, Jump_036_6554
    push hl
    ld a, [wD868]
    call Func_036_6634
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_036_6544
    ld a, [wD868]
    cp a, $04
    jr nc, Jump_036_6548

Jump_036_6544::
    sla c
    rl b

Jump_036_6548::
    sla c
    rl b
    pop hl
    call CompareHLToBC
    jr nc, Jump_036_6554

Jump_036_6552::
    scf
    ret

Jump_036_6554::
    jr z, Jump_036_6552
    xor a, a
    ret

; 2 call sites from 1 routine (e.g. Func_036_5441)
; reads: wD868, wC58A
; writes: wD868
; points at: wBattleAGL
Func_036_6558:: ; heuristic: follows a terminator; C0
    ld [wD868], a
    ld hl, wBattleAGL
    call Func_036_64FC
    ld bc, $03E7
    call CompareHLToBC
    jr z, Jump_036_6590
    jr nc, Jump_036_6590
    push hl
    ld a, [wD868]
    call Func_036_6646
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_036_6544
    ld a, [wD868]
    cp a, $04
    jr nc, Jump_036_6584
    sla c
    rl b

Jump_036_6584::
    sla c
    rl b
    pop hl
    call CompareHLToBC
    jr nc, Jump_036_6590

Jump_036_658E::
    scf
    ret

Jump_036_6590::
    jr z, Jump_036_658E
    xor a, a
    ret

; loads the species record of wBattleTarget's monster id (TargetMonsterIdAddress, LoadSpeciesRecord); A = its family (E-0069)
; 15 call sites from 15 routines (e.g. ActionEffect_ActionD2_Sub01, ActionEffect_ActionD3_Sub01, Func_036_5566, ActionEffect_ActionD4_Sub01, ...)
; reads: wSpeciesRecord
; writes: wSpeciesIdLo, wSpeciesIdHi
GetTargetSpeciesFamily::
Func_036_6594:: ; address name
    call TargetMonsterIdAddress
    ld a, [hl+]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wSpeciesRecord]
    ret

; HL = wBattleMonsterId + 2 * wBattleTarget, the target's monster id word (E-0069)
; 1 call site from 1 routine (e.g. GetTargetSpeciesFamily)
; reads: wBattleTarget
; points at: wBattleMonsterId
TargetMonsterIdAddress::
Func_036_65A9:: ; address name
    ld a, [wBattleTarget]
    add a, a
    ld hl, wBattleMonsterId
    add_a_to_hl
    ret

; 16 call sites from 16 routines (e.g. Func_036_55FB, Func_036_60D1, Func_036_60EB, Func_036_5F01, ...)
; reads: wBattleActor
; points at: wD854
Func_036_65B6::
    cp a, $03
    ret z
    push bc
    push hl
    ld b, a
    ld a, [wBattleActor]
    ld hl, wD854
    add a, a
    add_a_to_hl
    ld a, [hl]
    and a, $04
    jr nz, Jump_036_65D1
    ld a, b
    pop hl
    pop bc
    ret

Jump_036_65D1::
    ld a, $04
    pop hl
    pop bc
    ret

; only called from ActionEffect_RobMagic_Sub02 (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_RobMagic_Sub02)
ActionEffect_RobMagic_Sub02_Sub01:: ; heuristic: follows a terminator; C0
Func_036_65D6:: ; address name
    push hl
    push bc
    ld b, a
    call GetBattleMP
    push hl
    ld a, b
    call GetBattleMaxMP
    pop bc
    call CompareHLToBC
    pop bc
    pop hl
    ret

; only called from ActionEffect_Transform_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Transform_Sub01)
; reads: wBattleStatResultLo, wBattleStatResultHi
ActionEffect_Transform_Sub01_Sub01:: ; heuristic: follows a terminator; C0
Func_036_65E8:: ; address name
    push hl
    ld c, a
    farcall GetBaseHP
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleStatResultHi]
    ld b, a
    ld hl, $03E7
    call CompareHLToBC
    jr nc, Jump_036_6603
    ld bc, $03E7

Jump_036_6603::
    pop hl
    ret

; only called from ActionEffect_Transform_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Transform_Sub01)
; reads: wBattleStatResultLo, wBattleStatResultHi
ActionEffect_Transform_Sub01_Sub02:: ; heuristic: follows a terminator; C0
Func_036_6605:: ; address name
    push hl
    ld c, a
    farcall GetBaseMP
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleStatResultHi]
    ld b, a
    ld hl, $03E7
    call CompareHLToBC
    jr nc, Jump_036_6620
    ld bc, $03E7

Jump_036_6620::
    pop hl
    ret

; only called from ActionEffect_Transform_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Transform_Sub01)
; reads: wBattleStatResultLo, wBattleStatResultHi
ActionEffect_Transform_Sub01_Sub03::
Func_036_6622:: ; address name
    push hl
    ld c, a
    farcall GetBaseATK
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleStatResultHi]
    ld b, a
    pop hl
    ret

; 4 call sites from 4 routines (e.g. Func_036_6521, ActionEffect_Transform_Sub01, Func_036_5360, ActionEffect_UltraDown_Sub02_Sub01)
; reads: wBattleStatResultLo, wBattleStatResultHi
Func_036_6634::
    push hl
    ld c, a
    farcall GetBaseDEF
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleStatResultHi]
    ld b, a
    pop hl
    ret

; 4 call sites from 4 routines (e.g. ResolveStepDamageMessage_Sub04_Sub01_Sub01, Func_036_6558, ActionEffect_Transform_Sub01, Func_036_5441)
; reads: wBattleStatResultLo, wBattleStatResultHi
Func_036_6646::
    push hl
    ld c, a
    farcall GetBaseAGL
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleStatResultHi]
    ld b, a
    pop hl
    ret

; only called from ActionEffect_Transform_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Transform_Sub01)
; reads: wRecordBuffer, wCFED
; writes: wMonsterId, wCFE7, wSpeciesIdLo, wSpeciesIdHi
; points at: wDAAE, wD01A
ActionEffect_Transform_Sub01_Sub04:: ; heuristic: follows a terminator; C0
Func_036_6658:: ; address name
    ld b, a
    and a, $03
    cp a, $03
    jr z, Jump_036_6667
    ld a, b
    ld e, $31
    call BattlerRecordFieldAddress
    jr Jump_036_669D

Jump_036_6667::
    ld a, b
    srl a
    srl a
    and a, $01
    ld hl, wDAAE
    add a, a
    add_a_to_hl
    deref_hl
    ld a, l
    ld [wMonsterId], a
    ld a, h
    ld [wCFE7], a
    farcall LoadMonsterRecord
    ld a, [wRecordBuffer]
    ld [wSpeciesIdLo], a
    ld a, [wCFED]
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld hl, wD01A

Jump_036_669D::
    ret

; only called from ActionEffect_Transform_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Transform_Sub01)
; writes: wMonsterId, wCFE7
; points at: wDAAE, wRecordBufferData
ActionEffect_Transform_Sub01_Sub05:: ; heuristic: follows a terminator; C0
Func_036_669E:: ; address name
    ld b, a
    and a, $03
    cp a, $03
    jr z, Jump_036_66AF
    ld a, b
    ld e, $0E
    call BattlerRecordFieldAddress
    ld b, $08
    jr Jump_036_66D5

Jump_036_66AF::
    ld a, b
    srl a
    srl a
    and a, $01
    ld hl, wDAAE
    add a, a
    add_a_to_hl
    deref_hl
    ld a, l
    ld [wMonsterId], a
    ld a, h
    ld [wCFE7], a
    farcall LoadMonsterRecord
    ld hl, wRecordBufferData
    ld b, $04

Jump_036_66D5::
    ret

; only called from ActionEffect_Transform_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Transform_Sub01)
ActionEffect_Transform_Sub01_Sub06:: ; heuristic: follows a terminator; C0
Func_036_66D6:: ; address name
    push hl
    ld c, a
    farcall Func_03B_42BB
    pop hl
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; points at: wBattleDEF
Func_036_66E0:: ; heuristic: follows a terminator; C0
    ld a, [wBattleTarget]
    add a, a
    ld hl, wBattleDEF
    add_a_to_hl
    push hl
    ld a, [hl+]
    ld c, a
    ld b, [hl]
    push bc
    srl b
    rr c
    ld [hl], b
    dec hl
    ld [hl], c
    call ComputeAttackDamage
    pop bc
    pop hl
    ld a, c
    ld [hl+], a
    ld [hl], b
    ret

; only called from ActionEffect_BeDragon_Sub02 (E-0047)
; 2 call sites from 1 routine (e.g. ActionEffect_BeDragon_Sub02)
ActionEffect_BeDragon_Sub02_Sub02::
Func_036_6701:: ; address name
    add a, a
    add_a_to_hl
    push hl
    deref_hl
    call CompareHLToBC
    jr nc, Jump_036_6712
    ld b, h
    ld c, l

Jump_036_6712::
    pop hl
    ld [hl], c
    inc hl
    ld [hl], b
    ret

; jumps to the routine whose 16-bit address is at 36:6726 + 2 * wBattleActionId (the same JumpToHL idiom as CallInBank). The table has 240 entries (ids 0-239) and ends at $6906, where the first effect routine starts; the routines are named ActionEffect_<skill> after the skills that use them (E-0053, E-0084)
; 1 call site from 1 routine (e.g. ResolveStepActionEffect)
; reads: wBattleActionId
DispatchActionEffectTable::
Func_036_6717:: ; address name
    ld a, [wBattleActionId]
    ld c, a
    ld b, $00
    ld hl, $6726
    add hl, bc
    add hl, bc
    call JumpToWordAtHL
    ret
    db $75, $6B
    dw ActionEffect_Blaze
    dw ActionEffect_Blaze
    dw ActionEffect_Blaze
    dw ActionEffect_Firebal
    dw ActionEffect_Firebal
    dw ActionEffect_Firebal
    dw ActionEffect_Bang
    dw ActionEffect_Bang
    dw ActionEffect_Bang
    dw ActionEffect_Infernos
    dw ActionEffect_Infernos
    dw ActionEffect_Infernos
    dw ActionEffect_Bolt
    dw ActionEffect_Bolt
    dw ActionEffect_Bolt
    dw ActionEffect_IceBolt
    dw ActionEffect_IceBolt
    dw ActionEffect_IceBolt
    dw ActionEffect_Beat
    dw ActionEffect_Beat
    dw ActionEffect_Sacrifice
    dw ActionEffect_Heal
    dw ActionEffect_Heal
    dw ActionEffect_Heal
    dw ActionEffect_Heal
    dw ActionEffect_Heal
    dw ActionEffect_MPass
    dw ActionEffect_MPass
    dw ActionEffect_MPass
    dw ActionEffect_Vivify
    dw ActionEffect_Revive
    dw ActionEffect_Farewell
    dw ActionEffect_Antidote
    dw ActionEffect_DeChaos
    dw ActionEffect_NumbOff
    dw ActionEffect_CurseOff
    dw ActionEffect_Upper
    dw ActionEffect_Upper
    dw ActionEffect_Sap
    dw ActionEffect_Sap
    db $13, $6E, $13, $6E, $3A, $6E, $3A, $6E, $5B, $6E, $75, $6E, $A8, $6E, $A8, $6E
    db $E2, $6E, $FC, $6E, $96, $6F, $C1, $6F, $F1, $6F, $3D, $70, $3D, $70, $79, $70
    db $AE, $70, $CC, $70, $0F, $71, $4F, $71, $96, $71
    dw ActionEffect_BigBang
    dw ActionEffect_Bolt
    dw ActionEffect_FireAir
    dw ActionEffect_FireAir
    dw ActionEffect_FireAir
    dw ActionEffect_FireAir
    dw ActionEffect_FrigidAir
    dw ActionEffect_FrigidAir
    dw ActionEffect_FrigidAir
    dw ActionEffect_FrigidAir
    dw ActionEffect_WindBeast
    dw ActionEffect_Vacuum
    dw ActionEffect_Lightning
    dw ActionEffect_RockThrow
    dw ActionEffect_Watershot
    dw ActionEffect_Watershot
    dw ActionEffect_CallHelp
    dw ActionEffect_CallHelp
    dw Data_036_721A
    dw Data_036_7220
    dw Data_036_7226
    dw Data_036_722C
    dw Data_036_7232
    dw Data_036_7238
    dw Data_036_723E
    dw Data_036_7244
    dw Data_036_724A
    dw Data_036_7250
    dw Data_036_7256
    dw Data_036_725C
    dw Data_036_7262
    dw Data_036_7268
    db $6E
    dw $7472
    dw $7472
    dw $7472
    dw Func_036_7872
    db $72, $91, $72, $91, $72, $97, $72, $C4, $72, $CA, $72, $D0, $72, $E0, $72
    dw ActionEffect_HighJump
    dw ActionEffect_EvilSlash
    dw ActionEffect_Massacre
    dw ActionEffect_TwinSlash
    dw ActionEffect_Berserker
    db $B7, $73, $BD, $73, $A8, $6E
    dw ActionEffect_PalsyAir
    dw ActionEffect_PoisonGas
    dw ActionEffect_PoisonGas
    dw ActionEffect_Curse
    dw ActionEffect_OddDance
    db $FC, $6E, $C1, $6F
    dw ActionEffect_Beat
    dw ActionEffect_LureDance
    dw ActionEffect_LifeDance
    dw ActionEffect_Heal
    dw ActionEffect_SideStep
    dw ActionEffect_SandStorm
    dw ActionEffect_Radiant
    dw ActionEffect_EerieLite
    dw ActionEffect_Surge
    dw ActionEffect_UltraDown
    dw ActionEffect_DeMagic
    dw ActionEffect_DeMagic
    dw ActionEffect_TatsuCall
    dw ActionEffect_TatsuCall
    dw ActionEffect_TatsuCall
    dw ActionEffect_TatsuCall
    dw ActionEffect_SuckAir
    dw ActionEffect_Focus
    dw ActionEffect_LushLicks
    dw ActionEffect_LushLicks
    dw ActionEffect_LegSweep
    dw ActionEffect_LegSweep
    dw ActionEffect_Ahhh
    dw ActionEffect_WarCry
    dw ActionEffect_Geyser
    dw ActionEffect_DanceShut
    dw ActionEffect_MouthShut
    dw ActionEffect_StrongD
    dw ActionEffect_Dodge
    dw ActionEffect_StrongD
    dw ActionEffect_Cover
    dw ActionEffect_Cover
    dw ActionEffect_TailWind
    dw ActionEffect_TailWind
    dw ActionEffect_AquaWall
    dw ActionEffect_SealPray
    dw ActionEffect_SuckAll
    dw ActionEffect_Imitate
    db $3F, $79, $4F, $79, $9B, $79, $EC, $79, $EC, $79, $EC, $79, $EC, $79, $EC, $79
    db $EC, $79, $EC, $79, $EC, $79, $ED, $79, $A5, $7B, $06, $7A, $C1, $6F, $F1, $6F
    db $74, $6B
    dw ActionEffect_ActionB0
    dw ActionEffect_Heal
    dw ActionEffect_ActionB0
    dw ActionEffect_DeMagic
    dw ActionEffect_ActionB4
    dw ActionEffect_ActionB5
    dw ActionEffect_ActionB6
    db $A5, $7B, $0F, $71, $EE, $7A
    dw ActionEffect_ActionBA
    dw ActionEffect_Revive
    dw ActionEffect_ActionBC
    dw ActionEffect_ActionBD
    db $74, $6B
    dw ActionEffect_ActionBF
    dw ActionEffect_ActionC0
    dw ActionEffect_ActionC1
    dw ActionEffect_ActionC2
    db $A5, $7B, $A5, $7B
    dw ActionEffect_ActionC5
    dw ActionEffect_ActionC6
    dw ActionEffect_ActionC6
    dw ActionEffect_ActionC8
    dw ActionEffect_ActionC9
    dw ActionEffect_ActionC9
    dw ActionEffect_ActionBF
    dw ActionEffect_ActionCC
    dw ActionEffect_ActionCD
    dw ActionEffect_ActionCE
    dw ActionEffect_ActionCF
    dw ActionEffect_ActionD0
    dw ActionEffect_ActionD1
    dw ActionEffect_ActionD2
    dw ActionEffect_ActionD3
    dw ActionEffect_ActionD4
    dw ActionEffect_ActionD5
    dw ActionEffect_ActionD6
    dw ActionEffect_ActionD7
    dw ActionEffect_ActionD8
    db $6F, $69
    dw ActionEffect_ActionDA
    dw ActionEffect_ActionDB
    dw ActionEffect_ActionDC
    dw ActionEffect_ActionDD
    dw ActionEffect_ActionDE
    dw ActionEffect_ActionDF
    dw ActionEffect_ActionE0
    dw ActionEffect_ActionE1
    dw ActionEffect_ActionE2
    dw ActionEffect_ActionE3
    db $74
    dw Func_036_746B
    dw Func_036_746B
    dw Func_036_746B
    dw Func_036_746B
    dw Func_036_746B
    dw Func_036_746B
    dw Func_036_746B
    dw Func_036_746B
    dw Func_036_746B
    dw Func_036_746B
    dw Func_036_746B
    db $6B

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $D0; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: sB535
ActionEffect_ActionD0:: ; heuristic: target of a pointer table; C0
Func_036_6906:: ; address name
    call Func_036_5207
    farcall Func_0A3_413F
    jp Jump_036_7C7D

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $D1; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: sB535
ActionEffect_ActionD1:: ; heuristic: target of a pointer table; C0
Func_036_6912:: ; address name
    call ActionEffect_ActionD1_Sub01
    farcall Func_0A3_413F
    jp Jump_036_7C7D

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $D2; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: wD035
ActionEffect_ActionD2:: ; heuristic: target of a pointer table; C0
Func_036_691E:: ; address name
    call ActionEffect_ActionD2_Sub01
    farcall Func_0A3_413F
    jp ResolveStepComputeDamage_Sub02

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $D3; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: wD035
ActionEffect_ActionD3:: ; heuristic: target of a pointer table; C0
Func_036_692A:: ; address name
    call ActionEffect_ActionD3_Sub01
    farcall Func_0A3_413F
    jp ResolveStepComputeDamage_Sub02

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $D4; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: wD035
ActionEffect_ActionD4:: ; heuristic: target of a pointer table; C0
Func_036_6936:: ; address name
    call ActionEffect_ActionD4_Sub01
    farcall Func_0A3_413F
    jp ResolveStepComputeDamage_Sub02

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $D5; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: wD035
ActionEffect_ActionD5:: ; heuristic: target of a pointer table; C0
Func_036_6942:: ; address name
    call Func_036_5A6C
    farcall Func_0A3_413F
    jp ResolveStepComputeDamage_Sub02

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $D6; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wC5E7, wBattleTarget
; writes: wBattleDamageLo, wD873, wDAC2, wDAC3, wDAC0, wDAC1
; points at: sB535, wBattleHP, sB58F
ActionEffect_ActionD6:: ; heuristic: target of a pointer table; C0
Func_036_694E:: ; address name
    farcall Func_0A3_413F
    jp ActionEffect_Sacrifice

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $D7; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: wD035
ActionEffect_ActionD7:: ; heuristic: target of a pointer table; C0
Func_036_6957:: ; address name
    farcall Func_0A3_413F
    call ActionEffect_ActionD7_Sub01
    jp ResolveStepComputeDamage_Sub02

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $D8; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: wD035
ActionEffect_ActionD8:: ; heuristic: target of a pointer table; C0
Func_036_6963:: ; address name
    farcall Func_0A3_413F
    call ActionEffect_ActionD8_Sub01
    jp ResolveStepComputeDamage_Sub02
    db $CD, $52, $51, $21, $3F, $41, $06, $A3, $D7, $C3, $85, $7C

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $DA; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, hFFC6
; writes: hFFC6, wDAC2, wDAC0, wDAC1, wDAC3
; points at: wBattleHP, wBattleMaxHP, wBattleMP, wBattleMaxMP
ActionEffect_ActionDA:: ; heuristic: target of a pointer table; C0
Func_036_697B:: ; address name
    farcall Func_0A3_413F
    xor a, a
    ldh [hFFC6], a
    call ClearDamageAndReadTargetStatus0_Bank36
    or a, a
    jr z, Jump_036_6990
    ld [hl], $00
    ld a, $01
    ldh [hFFC6], a

Jump_036_6990::
    ld a, [wBattleTarget]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank36
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld a, [wBattleTarget]
    ld hl, wBattleMaxHP
    call AddDoubleAToHL_Bank36
    deref_hl
    call CompareHLToBC
    jr z, Jump_036_69B4
    call Func_036_5223
    ld a, $01
    ldh [hFFC6], a

Jump_036_69B4::
    ld a, [wBattleTarget]
    ld hl, wBattleMP
    call AddDoubleAToHL_Bank36
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    dec hl
    ld e, l
    ld d, h
    ld a, [wBattleTarget]
    ld hl, wBattleMaxMP
    call AddDoubleAToHL_Bank36
    deref_hl
    call CompareHLToBC
    jr z, Jump_036_69DD
    ld a, l
    ld [de], a
    inc de
    ld a, h
    ld [de], a
    ld a, $01
    ldh [hFFC6], a

Jump_036_69DD::
    ldh a, [hFFC6]
    or a, a
    jr z, Jump_036_69EA
    ld l, $37
    ld bc, $4090
    jp Jump_036_7CA3

Jump_036_69EA::
    jp Jump_036_7CB0

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $DB; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wC5E7, wBattleActionId, wDAD3, wDAD2, hFFC6, hFFC7
; writes: wBattleActionId, hFFC6, hFFC7, wDAD2, wDAD3, wDAC2, wDAC0, wDAC1
ActionEffect_ActionDB:: ; heuristic: target of a pointer table; C0
Func_036_69ED:: ; address name
    farcall Func_0A3_413F
    call ClearDamageAndReadTargetStatus0_Bank36
    call AdvanceRandom
    ld a, [wC5E7]
    sra a
    sra a
    and a, $03
    sla a
    sla a
    ld de, $6A59
    add a, e
    ld e, a
    jr nc, Jump_036_6A0E
    inc d

Jump_036_6A0E::
    ld a, [de]
    inc de
    ld c, a
    ld a, [hl]
    or a, c
    ld [hl], a
    ld a, [wBattleActionId]
    push af
    push de
    ld a, [de]
    cp a, $FF
    jr z, Jump_036_6A4B
    ld [wBattleActionId], a
    ld a, [wDAD3]
    ldh [hFFC6], a
    ld a, [wDAD2]
    ldh [hFFC7], a
    ld a, $41
    ld [wDAD2], a
    ld a, $30
    ld [wDAD3], a
    farcall SelectEffectByWDAD2Flags
    farcall SelectEffectByWDAD3Flags
    ldh a, [hFFC6]
    ld [wDAD3], a
    ldh a, [hFFC7]
    ld [wDAD2], a

Jump_036_6A4B::
    pop de
    inc de
    pop af
    ld [wBattleActionId], a
    ld a, [de]
    ld l, a
    ld bc, $4090
    jp Jump_036_7CA3

; no direct call (reached through a table, a jump or a vector)
; reads: wC5E7, wBattleTarget
; writes: wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1
Func_036_6A59:: ; heuristic: follows a terminator; C0
    ld [bc], a
    cpl
    ld [hl], a
    nop
    jr nz, Jump_036_6A93
    reti
    db $00, $40, $2F, $76, $00, $10, $34, $42, $00

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $DC; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC6, wBattleActionId
; writes: wBattleActor, wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1
; points at: wDAD8, wD80D
ActionEffect_ActionDC:: ; heuristic: target of a pointer table; C0
Func_036_6A69:: ; address name
    ld a, [wBattleActor]
    push af
    farcall Func_0A3_414F
    ldh a, [hFFC6]
    ld [wBattleActor], a
    call ActionEffect_BeDragon
    pop af
    ld [wBattleActor], a
    jp ActionEffect_BeDragon

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $DD; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wC5E7
; writes: wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1
; points at: wD80D
ActionEffect_ActionDD:: ; heuristic: target of a pointer table; C0
Func_036_6A82:: ; address name
    farcall Func_0A3_413F
    ld a, [wBattleTarget]
    ld hl, wD80D
    call AddAx9ToHL
    set 2, [hl]

Jump_036_6A93::
    push hl
    call AdvanceRandom
    pop hl
    ld a, $04
    add_a_to_hl
    ld a, [wC5E7]
    and a, $04
    add a, $04
    ld b, a
    ld a, [hl]
    and a, $F3
    or a, b
    ld [hl], a
    call Func_036_5360
    jr nc, Jump_036_6AB7
    ld a, [wBattleTarget]
    call Func_036_7D45

Jump_036_6AB7::
    call Func_036_5441
    jr nc, Jump_036_6AC2
    ld a, [wBattleTarget]
    call Func_036_7D45

Jump_036_6AC2::
    ld l, $93
    ld bc, $0090
    jp ClearDamageAndStoreWDAC0_Bank36

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $DE; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1
; points at: wD80D
ActionEffect_ActionDE:: ; heuristic: target of a pointer table; C0
Func_036_6ACA:: ; address name
    farcall Func_0A3_413F
    ld a, [wBattleTarget]
    ld hl, wD80D
    call AddAx9ToHL
    set 0, [hl]
    set 6, [hl]
    set 7, [hl]
    ld l, $9E
    ld bc, $0090
    jp ClearDamageAndStoreWDAC0_Bank36

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $DF; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleActionId, wBattleActor, hFFC6, wC982, wC983, wDAD1, wDABD
; writes: wC982, wC983, wBattleActor, wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1, ...
; points at: wBattleMP, wBattleMaxMP, wBattleTargetChoice
ActionEffect_ActionDF:: ; heuristic: target of a pointer table; C0
Func_036_6AE7:: ; address name
    farcall Func_0A3_413F
    jp ActionEffect_RobMagic

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $E0; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC6, wBattleActionId, wDAD1, wDABD
; writes: wBattleActor, wBattleTarget, wDAD1, wBattleSubPhase, wBattleResolveStep, wDAC0, wDAC1
; points at: wD813, wBattleTargetChoice
ActionEffect_ActionE0:: ; heuristic: target of a pointer table; C0
Func_036_6AF0:: ; address name
    farcall Func_0A3_413F
    ld a, [wBattleActor]
    push af
    farcall Func_0A3_414F
    ldh a, [hFFC6]
    ld [wBattleActor], a
    call ActionEffect_StrongD
    pop af
    ld [wBattleActor], a
    jp ActionEffect_StrongD

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $E1; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1, wDAC3
; points at: wBattleStatus
ActionEffect_ActionE1:: ; heuristic: target of a pointer table; C0
Func_036_6B0F:: ; address name
    farcall Func_0A3_413F
    jp ActionEffect_PanicAll

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $E2; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC6, wDAD1, wDABD
; writes: hFFC6, wBattleTarget, wDAD1, wBattleSubPhase, wBattleResolveStep, wDAC0, wDAC1
; points at: wD813, hFFC6, wBattleTargetChoice
ActionEffect_ActionE2:: ; heuristic: target of a pointer table; C0
Func_036_6B18:: ; address name
    farcall Func_0A3_413F
    ld a, [wBattleActor]
    and a, $04
    ldh [hFFC6], a
    ld b, $04

Jump_036_6B27::
    ldh a, [hFFC6]
    ld c, a
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_036_6B38
    ld a, c
    ld hl, wD813
    call AddAx9ToHL
    set 1, [hl]

Jump_036_6B38::
    ld hl, hFFC6
    inc [hl]
    dec b
    jr nz, Jump_036_6B27
    jp Jump_036_7CD3

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $E3; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC6, wDAD1, wDABD
; writes: hFFC6, wBattleTarget, wDAD1, wBattleSubPhase, wBattleResolveStep, wDAC0, wDAC1
; points at: wD80D, hFFC6, wBattleTargetChoice
ActionEffect_ActionE3:: ; heuristic: target of a pointer table; C0
Func_036_6B42:: ; address name
    farcall Func_0A3_413F
    ld a, [wBattleActor]
    and a, $04
    ldh [hFFC6], a
    ld b, $03

Jump_036_6B51::
    ldh a, [hFFC6]
    ld c, a
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_036_6B6A
    ldh a, [hFFC6]
    ld hl, wD80D
    call AddAx9ToHL
    set 3, [hl]
    inc hl
    inc hl
    inc hl
    res 6, [hl]
    set 7, [hl]

Jump_036_6B6A::
    ld hl, hFFC6
    inc [hl]
    dec b
    jr nz, Jump_036_6B51
    jp Jump_036_7CD3
    db $C9

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 0 (no name); ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; 1 call site from 1 routine (e.g. ActionEffect_ActionC2)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: wD035
ActionEffect_Action00::
Func_036_6B75:: ; address name
    call ComputeAttackDamage
    jp ResolveStepComputeDamage_Sub02

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 1 Blaze, 2 Blazemore, 3 Blazemost; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: sB535
ActionEffect_Blaze:: ; heuristic: target of a pointer table; C0
Func_036_6B7B:: ; address name
    call ActionEffect_Blaze_Sub01
    jp Jump_036_7C7D

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 4 Firebal, 5 Firebane, 6 Firebolt; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: sB535
ActionEffect_Firebal:: ; heuristic: target of a pointer table; C0
Func_036_6B81:: ; address name
    call ActionEffect_Firebal_Sub01
    jp Jump_036_7C7D

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 7 Bang, 8 Boom, 9 Explodet; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: sB535
ActionEffect_Bang:: ; heuristic: target of a pointer table; C0
Func_036_6B87:: ; address name
    call ActionEffect_Bang_Sub01
    jp Jump_036_7C7D

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 10 Infernos, 11 Infermore, 12 Infermost; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: sB535
ActionEffect_Infernos:: ; heuristic: target of a pointer table; C0
Func_036_6B8D:: ; address name
    call ActionEffect_Infernos_Sub01
    jp Jump_036_7C7D

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 13 Bolt, 14 Zap, 15 Thordain, 63 Hellblast; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: sB535
ActionEffect_Bolt:: ; heuristic: target of a pointer table; C0
Func_036_6B93:: ; address name
    call Func_036_5207
    jp Jump_036_7C7D

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 16 IceBolt, 17 SnowStorm, 18 Blizzard; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: sB535
ActionEffect_IceBolt:: ; heuristic: target of a pointer table; C0
Func_036_6B99:: ; address name
    call ActionEffect_IceBolt_Sub01
    jp Jump_036_7C7D

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 19 Beat, 20 Defeat, 121 K.O.Dance; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wBattleDamageLo, wD873, wDAC2, wDAC3, wDAC0, wDAC1
; points at: wBattleHP, sB58E
ActionEffect_Beat:: ; heuristic: target of a pointer table; C0
Func_036_6B9F:: ; address name
    call Func_036_5B19
    jr nc, Jump_036_6BC4
    ld a, [wBattleTarget]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank36
    xor a, a
    ld [hl+], a
    ld [hl], a
    ld hl, $03E8
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    ld hl, sB58E
    ld bc, vTiles0 + $A8
    jp Jump_036_7C8B

Jump_036_6BC4::
    jp Jump_036_7CB7

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 21 Sacrifice; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wC5E7, wBattleTarget
; writes: wBattleDamageLo, wD873, wDAC2, wDAC3, wDAC0, wDAC1
; points at: sB535, wBattleHP, sB58F
ActionEffect_Sacrifice:: ; heuristic: target of a pointer table; C0
Func_036_6BC7:: ; address name
    call ActionEffect_Sacrifice_Sub01
    jr nc, Jump_036_6C21
    call AdvanceRandom
    ld a, [wC5E7]
    and a, $01
    jr z, Jump_036_6C01
    ld a, [wBattleTarget]
    call GetBattleHP
    push hl
    ld a, $64
    call DivideHLByA
    ld a, h
    or a, l
    jr nz, Jump_036_6BE9
    ld hl, $0001

Jump_036_6BE9::
    pop bc
    ld a, c
    sub a, l
    ld c, a
    ld a, b
    sbc a, h
    ld b, a
    or a, c
    jr nz, Jump_036_6BF6
    ld bc, $0001

Jump_036_6BF6::
    ld a, c
    ld [wBattleDamageLo], a
    ld a, b
    ld [wD873], a
    jp Jump_036_7C7D

Jump_036_6C01::
    ld a, [wBattleTarget]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank36
    xor a, a
    ld [hl+], a
    ld [hl], a
    ld hl, $03E8
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    ld hl, sB58F
    ld bc, vTiles0 + $A8
    jp Jump_036_7C8B

Jump_036_6C21::
    jp Jump_036_7CB7

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 22 Heal, 23 HealMore, 24 HealAll, 25 HealUs, 26 HealUsAll, 124 Hustle, $B1; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; 2 call sites from 2 routines (e.g. ActionEffect_LoveRain, ActionEffect_Farewell)
; reads: wBattleTarget, wDAD1, wBattleActor, wDABD
; writes: wDAC3, wDAC0, wDAC1, wBattleTarget, wDAD1, wBattleSubPhase, wBattleResolveStep, wDAC2
; points at: wBattleTargetChoice, wBattleHP, wBattleMaxHP
ActionEffect_Heal:: ; heuristic: target of a pointer table; C0
Func_036_6C24:: ; address name
    ld a, [wBattleTarget]
    call CarryUnlessWDA63SlotEmpty
    jr nc, Jump_036_6C30
    jr z, Jump_036_6C5B
    jr Jump_036_6C58

Jump_036_6C30::
    ld a, [wBattleTarget]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank36
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld a, [wBattleTarget]
    ld hl, wBattleMaxHP
    call AddDoubleAToHL_Bank36
    deref_hl
    call CompareHLToBC
    jr z, Jump_036_6C58
    call Func_036_5223
    ld l, $37
    ld bc, $4090
    jp Jump_036_7CA3

Jump_036_6C58::
    jp Jump_036_7CB0

Jump_036_6C5B::
    jp Jump_036_7CD3

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 27 MPass, 28 MPassmore, 29 MPassmost; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wDAD1, wBattleActor, wDABD
; writes: wDAC3, wDAC0, wDAC1, wBattleTarget, wDAD1, wBattleSubPhase, wBattleResolveStep, wDAC2
; points at: wBattleTargetChoice, wBattleMP, wBattleMaxMP
ActionEffect_MPass:: ; heuristic: target of a pointer table; C0
Func_036_6C5E:: ; address name
    ld a, [wBattleTarget]
    call CarryUnlessWDA63SlotEmpty
    jr nc, Jump_036_6C6A
    jr z, Jump_036_6C97
    jr Jump_036_6C94

Jump_036_6C6A::
    ld a, [wBattleTarget]
    ld hl, wBattleMP
    call AddDoubleAToHL_Bank36
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld a, [wBattleTarget]
    ld hl, wBattleMaxMP
    call AddDoubleAToHL_Bank36
    deref_hl
    call CompareHLToBC
    jr z, Jump_036_6C94
    call ActionEffect_MPass_Sub01
    jr nc, Jump_036_6C94
    ld l, $C3
    ld bc, $4090
    jp Jump_036_7CA3

Jump_036_6C94::
    jp Jump_036_7CB0

Jump_036_6C97::
    jp Jump_036_7CD3

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 30 Vivify; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wC5E7, wDAD1, wBattleActor, wDABD
; writes: wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1, wDAC3, wBattleTarget, wDAD1, ...
; points at: wBattleMaxHP, wBattleHP, wBattleMonsterId, wBattleTargetChoice
ActionEffect_Vivify:: ; heuristic: target of a pointer table; C0
Func_036_6C9A:: ; address name
    ld a, [wBattleTarget]
    call CarryUnlessWDA63SlotEmpty
    jp nc, Jump_036_6D1A
    jp z, Jump_036_6D1D
    call AdvanceRandom
    ld a, [wC5E7]
    and a, $01
    jr z, Jump_036_6CED
    ld a, [wBattleTarget]
    ld b, a
    ld hl, wBattleMaxHP
    call AddDoubleAToHL_Bank36
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    srl d
    rr e

Jump_036_6CC1::
    ld a, b
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank36
    ld a, e
    ld [hl+], a
    ld [hl], d
    call TargetOnLocalSide_Bank36
    jr c, Jump_036_6CE2
    ld a, [wBattleTarget]
    ld b, a
    add a, a
    ld de, wBattleMonsterId
    add a, e
    ld e, a
    jr nc, Jump_036_6CDD
    inc d

Jump_036_6CDD::
    call Func_036_4E26
    jr Jump_036_6CE2

Jump_036_6CE2::
    call ActionEffect_Vivify_Sub01
    ld l, $50
    ld bc, $4090
    jp ClearDamageAndStoreWDAC0_Bank36

Jump_036_6CED::
    ld h, $67
    ld bc, $0080
    jp Jump_036_7CBC

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 31 Revive, $BB; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wDAD1, wBattleActor, wDABD
; writes: wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1, wBattleTarget, wDAD1, wBattleSubPhase, ...
; points at: wBattleMaxHP, wBattleHP, wBattleMonsterId, wBattleTargetChoice
ActionEffect_Revive:: ; heuristic: target of a pointer table; C0
Func_036_6CF5:: ; address name
    ld a, [wBattleTarget]
    and a, $03
    cp a, $03
    jr z, Jump_036_6D1D
    ld a, [wBattleTarget]
    call CarryUnlessWDA63SlotEmpty
    jp nc, Jump_036_6D1A
    jp z, Jump_036_6D1D

; 3 call sites from 3 routines (e.g. ActionEffect_Imitate, ActionEffect_Farewell, Func_03B_4C7D)
; reads: wBattleTarget
; writes: wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1
; points at: wBattleMaxHP, wBattleHP, wBattleMonsterId
Func_036_6D0A::
    ld a, [wBattleTarget]
    ld b, a
    ld hl, wBattleMaxHP
    call AddDoubleAToHL_Bank36
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    jp Jump_036_6CC1

Jump_036_6D1A::
    jp Jump_036_7CB0

Jump_036_6D1D::
    jp Jump_036_7CD3

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 32 Farewell; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; 1 call site from 1 routine (e.g. ActionEffect_LifeDance)
; reads: wBattleTarget, wDAD1, wBattleActor, wDABD
; writes: wBattleTarget, wDAD1, wBattleSubPhase, wBattleResolveStep, wDAC0, wDAC1
; points at: wBattleActor, wDAC0, wBattleTargetChoice
ActionEffect_Farewell:: ; heuristic: target of a pointer table; C0
Func_036_6D20:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleActor
    cp a, [hl]
    jr z, Jump_036_6D1D
    ld a, [wBattleTarget]
    and a, $03
    cp a, $03
    jr z, Jump_036_6D1D
    ld a, [wBattleTarget]
    call CarryUnlessWDA63SlotEmpty
    jr nc, Jump_036_6D45
    jr z, Jump_036_6D1D
    call Func_036_6D0A
    ld hl, wDAC0
    set 6, [hl]
    ret

Jump_036_6D45::
    call ActionEffect_Heal
    ld hl, wDAC0
    res 6, [hl]
    ret

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 33 Antidote; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1, wDAC3
ActionEffect_Antidote:: ; heuristic: target of a pointer table; C0
Func_036_6D4E:: ; address name
    call ClearDamageAndReadTargetStatus0_Bank36
    and a, $03
    jr z, Jump_036_6D61
    ld a, [hl]
    and a, $FC
    ld [hl], a
    ld l, $4E
    ld bc, $4090
    jp ClearDamageAndStoreWDAC0_Bank36

Jump_036_6D61::
    jp Jump_036_7CB0

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 34 DeChaos; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1, wDAC3
; points at: wDA5B
ActionEffect_DeChaos:: ; heuristic: target of a pointer table; C0
Func_036_6D64:: ; address name
    call ClearDamageAndReadTargetStatus0_Bank36
    and a, $10
    jr z, Jump_036_6D84
    ld a, [hl]
    and a, $EF
    ld [hl], a
    ld a, [wBattleTarget]
    ld hl, wDA5B
    add_a_to_hl
    ld [hl], $03
    ld l, $83
    ld bc, $4090
    jp ClearDamageAndStoreWDAC0_Bank36

Jump_036_6D84::
    jp Jump_036_7CB0

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 35 NumbOff; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wDAC3, wDAC0, wDAC1
; points at: wDA5B
ActionEffect_NumbOff:: ; heuristic: target of a pointer table; C0
Func_036_6D87:: ; address name
    call ClearDamageAndReadTargetStatus0_Bank36
    and a, $CC
    jr z, Jump_036_6DB2
    push hl
    bit 6, [hl]
    jr z, Jump_036_6D97
    ld l, $4F
    jr Jump_036_6D99

Jump_036_6D97::
    ld l, $82

Jump_036_6D99::
    ld bc, $4090
    call ClearDamageAndStoreWDAC0_Bank36
    pop hl
    ld a, [hl]
    and a, $33
    ld [hl], a
    ld a, [wBattleTarget]
    ld hl, wDA5B
    add_a_to_hl
    ld [hl], $03
    ret

Jump_036_6DB2::
    jp Jump_036_7CB0

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 36 CurseOff; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1, wDAC3
ActionEffect_CurseOff:: ; heuristic: target of a pointer table; C0
Func_036_6DB5:: ; address name
    call ClearDamageAndReadTargetStatus0_Bank36
    and a, $20
    jr z, Jump_036_6DC8
    ld a, [hl]
    and a, $DF
    ld [hl], a
    ld l, $51
    ld bc, $4090
    jp ClearDamageAndStoreWDAC0_Bank36

Jump_036_6DC8::
    jp Jump_036_7CB0

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 37 Upper, 38 Increase; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleDamageLo, wD873
; writes: wDAC2, wDAC0, wDAC1, wDAC3
ActionEffect_Upper:: ; heuristic: target of a pointer table; C0
Func_036_6DCB:: ; address name
    call Func_036_5360
    jr nc, Jump_036_6DEA
    ld a, [wBattleTarget]
    call Func_036_7D45
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wD873]
    ld h, a
    ld a, l
    or a, h
    jr z, Jump_036_6DEA
    ld l, $45
    ld bc, $0090
    jp Jump_036_7CA3

Jump_036_6DEA::
    ld h, $CC
    ld bc, $0084
    jp Jump_036_7CBC

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 39 Sap, 40 Defense; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wDAC2, wDAC0, wDAC1, wDAC3
ActionEffect_Sap:: ; heuristic: target of a pointer table; C0
Func_036_6DF2:: ; address name
    call Func_036_53C6
    jp nc, Jump_036_7CB7

; only called from ActionEffect_UltraDown (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_UltraDown)
; reads: wBattleTarget
; writes: wDAC2, wDAC0, wDAC1, wDAC3
ActionEffect_UltraDown_Sub02::
Func_036_6DF8:: ; address name
    call ActionEffect_UltraDown_Sub02_Sub01
    jr nc, Jump_036_6E0B
    ld a, [wBattleTarget]
    call Func_036_7D50
    ld l, $39
    ld bc, $0098
    jp Jump_036_7CA3

Jump_036_6E0B::
    ld h, $CC
    ld bc, $0084
    jp Jump_036_7CBC

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 41 Speed, 42 SpeedUp; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleDamageLo, wD873
; writes: wDAC2, wDAC0, wDAC1, wDAC3
ActionEffect_Speed:: ; heuristic: follows a terminator; C0
Func_036_6E13:: ; address name
    call Func_036_5441
    jr nc, Jump_036_6E32
    ld a, [wBattleTarget]
    call Func_036_7D45
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wD873]
    ld h, a
    ld a, l
    or a, h
    jr z, Jump_036_6E32
    ld l, $49
    ld bc, $0090
    jp Jump_036_7CA3

Jump_036_6E32::
    ld h, $CC
    ld bc, $0084
    jp Jump_036_7CBC
    db $CD, $A7, $54, $D2, $B7, $7C

; only called from ResolveStepDamageMessage_Sub04 (E-0047)
; 1 call site from 1 routine (e.g. ResolveStepDamageMessage_Sub04)
; reads: wBattleTarget
; writes: wDAC2, wDAC0, wDAC1, wDAC3
ResolveStepDamageMessage_Sub04_Sub01::
Func_036_6E40:: ; address name
    call ResolveStepDamageMessage_Sub04_Sub01_Sub01
    jr nc, Jump_036_6E53
    ld a, [wBattleTarget]
    call Func_036_7D50
    ld l, $48
    ld bc, $0098
    jp Jump_036_7CA3

Jump_036_6E53::
    ld h, $CC
    ld bc, $0084
    jp Jump_036_7CBC

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 45 TwinHits; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wDAD1, wBattleActor, wDABD
; writes: wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1, wBattleTarget, wDAD1, wBattleSubPhase, ...
; points at: wD80D, wBattleTargetChoice
ActionEffect_TwinHits:: ; heuristic: follows a terminator; C0
Func_036_6E5B:: ; address name
    ld a, [wBattleTarget]
    ld hl, wD80D
    call AddAx9ToHL
    bit 2, [hl]
    jr nz, Jump_036_6E72
    set 2, [hl]
    ld l, $43
    ld bc, $0090
    jp ClearDamageAndStoreWDAC0_Bank36

Jump_036_6E72::
    jp Jump_036_7CD3

; only called from ResolveStepDamageMessage_Sub04 (E-0047)
; 1 call site from 1 routine (e.g. ResolveStepDamageMessage_Sub04)
; reads: wBattleTarget, wDAC0, wDAD1, wBattleActor, wDABD
; writes: wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1, wDAC3, wBattleTarget, wDAD1, ...
; points at: wD80D, wBattleTargetChoice
ResolveStepDamageMessage_Sub04_Sub02::
Func_036_6E75:: ; address name
    ld a, [wBattleTarget]
    ld hl, wD80D
    call AddAx9ToHL
    bit 1, [hl]
    jr nz, Jump_036_6E9A
    call Func_036_55FB
    jr nc, Jump_036_6EA5
    ld a, [wBattleTarget]
    ld hl, wD80D
    call AddAx9ToHL
    set 1, [hl]
    ld l, $4A
    ld bc, $0090
    jp ClearDamageAndStoreWDAC0_Bank36

Jump_036_6E9A::
    ld a, [wDAC0]
    and a, $EF
    ld [wDAC0], a
    jp Jump_036_7CD3

Jump_036_6EA5::
    jp Jump_036_7CB7

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 47 Sleep, 48 SleepAll, 113 SleepAir; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleActionId
; writes: wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1, wDAC3
; points at: wBattleStatus
ActionEffect_Sleep:: ; heuristic: follows a terminator; C0
Func_036_6EA8:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    and a, $8C
    jr nz, Jump_036_6EDA
    push hl
    call Func_036_5F01
    pop hl
    jr nc, Jump_036_6EC9
    ld a, [hl]
    or a, $8C
    ld [hl], a
    ld l, $73
    ld bc, $4098
    jp ClearDamageAndStoreWDAC0_Bank36

Jump_036_6EC9::
    ld a, [wBattleActionId]
    cp a, $71
    ld h, $B5
    jr z, Jump_036_6ED4
    ld h, $CE

Jump_036_6ED4::
    ld bc, $0080
    jp Jump_036_7CBC

Jump_036_6EDA::
    ld h, $D4
    ld bc, $0080
    jp Jump_036_7CBC

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 49 TakeMagic; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wDAD1, wDABD
; writes: wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1, wBattleTarget, wDAD1, wBattleSubPhase, ...
; points at: wD80E, wBattleTargetChoice
ActionEffect_TakeMagic:: ; heuristic: follows a terminator; C0
Func_036_6EE2:: ; address name
    ld a, [wBattleActor]
    ld hl, wD80E
    call AddAx9ToHL
    bit 0, [hl]
    jr nz, Jump_036_6EF9
    set 0, [hl]
    ld l, $3F
    ld bc, $0090
    jp ClearDamageAndStoreWDAC0_Bank36

Jump_036_6EF9::
    jp Jump_036_7CD3

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 50 RobMagic, 119 RobDance; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleActionId, wBattleActor, hFFC6, wC982, wC983, wDAD1, wDABD
; writes: wC982, wC983, wBattleActor, wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1, ...
; points at: wBattleMP, wBattleMaxMP, wBattleTargetChoice
ActionEffect_RobMagic:: ; heuristic: follows a terminator; C0
Func_036_6EFC:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleMP
    call AddDoubleAToHL_Bank36
    ld a, [hl+]
    or a, [hl]
    jp z, Jump_036_6F93
    ld a, [wBattleActionId]
    cp a, $DF
    jr z, Jump_036_6F2D
    ld a, [wBattleActor]
    call GetBattleMP
    ld a, [wBattleActor]
    ld de, wBattleMaxMP
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_036_6F23
    inc d

Jump_036_6F23::
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    call CompareHLToBC
    jr nc, Jump_036_6F93

Jump_036_6F2D::
    call ActionEffect_RobMagic_Sub01
    jr nc, Jump_036_6F93
    ld a, [wBattleTarget]
    ld hl, wBattleMP
    call AddDoubleAToHL_Bank36
    ld a, [hl+]
    ld c, a
    ld a, [hl]
    ld b, a
    sra b
    rr c
    ld a, c
    ld [wC982], a
    ld a, b
    ld [wC983], a
    call ActionEffect_RobMagic_Sub02
    ld a, [wBattleActionId]
    cp a, $DF
    jr nz, Jump_036_6F8B
    farcall Func_0A3_414F
    ld a, [wBattleActor]
    push af
    ldh a, [hFFC6]
    ld [wBattleActor], a
    call ActionEffect_RobMagic_Sub02
    pop af
    ld [wBattleActor], a
    ld a, [wBattleTarget]
    ld hl, wBattleMP
    call AddDoubleAToHL_Bank36
    xor a, a
    ld [hl+], a
    ld [hl], a
    ld a, [wC982]
    ld c, a
    ld a, [wC983]
    ld b, a
    sla c
    rl b
    ld a, c
    ld [wBattleDamageLo], a
    ld a, b
    ld [wD873], a

Jump_036_6F8B::
    ld l, $3D
    ld bc, $4098
    jp Jump_036_7CA3

Jump_036_6F93::
    jp Jump_036_7CD3

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 51 StopSpell; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wDAD1, wBattleActor, wDABD
; writes: wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1, wDAC3, wBattleTarget, wDAD1, ...
; points at: wD80D, wBattleTargetChoice
ActionEffect_StopSpell:: ; heuristic: follows a terminator; C0
Func_036_6F96:: ; address name
    ld a, [wBattleTarget]
    ld hl, wD80D
    call AddAx9ToHL
    bit 0, [hl]
    jr nz, Jump_036_6FBB
    call ActionEffect_StopSpell_Sub01
    jr nc, Jump_036_6FBE
    ld a, [wBattleTarget]
    ld hl, wD80D
    call AddAx9ToHL
    set 0, [hl]
    ld l, $3B
    ld bc, $4098
    jp ClearDamageAndStoreWDAC0_Bank36

Jump_036_6FBB::
    jp Jump_036_7CD3

Jump_036_6FBE::
    jp Jump_036_7CB7

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 52 PanicAll, 120 PaniDance, 173 PanicAll; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1, wDAC3
; points at: wBattleStatus
ActionEffect_PanicAll:: ; heuristic: follows a terminator; C0
Func_036_6FC1:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit 4, [hl]
    jr nz, Jump_036_6FE6
    call ActionEffect_PanicAll_Sub01
    jr nc, Jump_036_6FEE
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    set 4, [hl]
    ld l, $42
    ld bc, $4098
    jp ClearDamageAndStoreWDAC0_Bank36

Jump_036_6FE6::
    ld h, $CF
    ld bc, $0084
    jp Jump_036_7CBC

Jump_036_6FEE::
    jp Jump_036_7CB7

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 53 Ironize, 174 Ironize; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wC58A, wBattleTarget
; writes: wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1
; points at: wD811
ActionEffect_Ironize:: ; heuristic: follows a terminator; C0
Func_036_6FF1:: ; address name
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_036_700D
    ld a, [wBattleTarget]
    cp a, $04
    jr c, Jump_036_700D
    ld hl, wD811
    call AddAx9ToHL
    ld b, $01
    ld a, [wBattleTarget]
    ld c, a
    jr Jump_036_701B

Jump_036_700D::
    ld b, $04
    ld a, [wBattleTarget]
    and a, $04
    ld c, a
    ld hl, wD811
    call AddAx9ToHL

Jump_036_701B::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_036_7025
    ld a, [hl]
    or a, $C0
    ld [hl], a

Jump_036_7025::
    ld a, $09
    add_a_to_hl
    inc c
    dec b
    jr nz, Jump_036_701B
    farcall ActionEffect_Ironize_Sub01
    ld l, d
    ld bc, $0090
    jp ClearDamageAndStoreWDAC0_Bank36

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 54 MagicBack, 55 Bounce; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wBattleActionId
; writes: wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1, wDAC3
; points at: wD80E
ActionEffect_MagicBack:: ; heuristic: follows a terminator; C0
Func_036_703D:: ; address name
    ld a, [wBattleActor]
    ld hl, wD80E
    call AddAx9ToHL
    ld a, [wBattleActionId]
    cp a, $37
    jr z, Jump_036_705F
    bit 5, [hl]
    jr nz, Jump_036_7071
    ld a, [hl]
    and a, $DD
    or a, $20
    ld [hl], a
    ld l, $4B
    ld bc, $0090
    jp ClearDamageAndStoreWDAC0_Bank36

Jump_036_705F::
    bit 1, [hl]
    jr nz, Jump_036_7071
    ld a, [hl]
    and a, $DD
    or a, $02
    ld [hl], a
    ld l, $4C
    ld bc, $0090
    jp ClearDamageAndStoreWDAC0_Bank36

Jump_036_7071::
    ld h, $CC
    ld bc, $0084
    jp Jump_036_7CBC

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 56 Barrier; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wDAD1, wBattleActor, wDABD
; writes: wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1, wBattleTarget, wDAD1, wBattleSubPhase, ...
; points at: wD80E, wBattleTargetChoice
ActionEffect_Barrier:: ; heuristic: follows a terminator; C0
Func_036_7079:: ; address name
    ld a, [wBattleTarget]
    and a, $04
    ld c, a
    ld b, $04
    ld d, $00

Jump_036_7083::
    ld a, c
    ld hl, wD80E
    call AddAx9ToHL
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_036_7099
    bit 2, [hl]
    jr nz, Jump_036_709B
    inc d
    set 2, [hl]
    jr Jump_036_709B

Jump_036_7099::
    res 2, [hl]

Jump_036_709B::
    inc c
    dec b
    jr nz, Jump_036_7083
    ld a, d
    or a, a
    jr z, Jump_036_70AB
    ld l, $4D
    ld bc, $0090
    jp ClearDamageAndStoreWDAC0_Bank36

Jump_036_70AB::
    jp Jump_036_7CD3

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 57 MagicWall; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wDAD1, wDABD
; writes: wBattleTarget, wDAD1, wBattleSubPhase, wBattleResolveStep, wDAC0, wDAC1
; points at: wD814, wBattleTargetChoice
ActionEffect_MagicWall:: ; heuristic: follows a terminator; C0
Func_036_70AE:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03

Jump_036_70B6::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_036_70C5
    ld a, c
    ld hl, wD814
    call AddAx9ToHL
    set 6, [hl]

Jump_036_70C5::
    inc c
    dec b
    jr nz, Jump_036_70B6
    jp Jump_036_7CD3

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 58 Transform; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wDAD8, wD80D
ActionEffect_Transform:: ; heuristic: follows a terminator; C0
Func_036_70CC:: ; address name
    ld l, $52
    ld bc, $4090
    call ClearDamageAndStoreWDAC0_Bank36
    call ActionEffect_Transform_Sub01
    ld a, [wBattleActor]
    ld hl, wDAD8
    add_a_to_hl
    ld a, [hl]
    and a, $F8
    ld [hl], a
    ld a, [wBattleActor]
    ld hl, wD80D
    call AddAx9ToHL
    set 5, [hl]
    res 4, [hl]
    ret

; only called from ResolveStepDamageMessage (E-0047)
; 1 call site from 1 routine (e.g. ResolveStepDamageMessage)
; reads: wC58A, wBattleActor, wBattleTarget
; points at: wDAD4
ResolveStepDamageMessage_Sub05::
Func_036_70F4:: ; address name
    ld a, [wC58A]
    cp a, $01
    ret z
    ld a, [wBattleActor]
    cp a, $04
    ret c
    and a, $03
    ld hl, wDAD4
    add_a_to_hl
    ld a, [wBattleTarget]
    ld [hl], a
    ret

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 59 BeDragon, $B8; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; 1 call site from 1 routine (e.g. ActionEffect_ActionDC)
; reads: wBattleActor, wBattleActionId
; writes: wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1
; points at: wDAD8, wD80D
ActionEffect_BeDragon:: ; heuristic: follows a terminator; C0
Func_036_710F:: ; address name
    call ActionEffect_BeDragon_Sub02
    ld a, [wBattleActor]
    ld hl, wDAD8
    add_a_to_hl
    ld a, [hl]
    and a, $F8
    ld [hl], a
    ld a, [wBattleActor]
    ld hl, wD80D
    call AddAx9ToHL
    set 4, [hl]
    res 5, [hl]
    ld a, [wBattleActor]
    ld c, a
    farcall ActionEffect_BeDragon_Sub01
    ld a, [wBattleActionId]
    cp a, $DC
    jr z, Jump_036_7147
    ld l, $44
    ld bc, $4090
    jp ClearDamageAndStoreWDAC0_Bank36

Jump_036_7147::
    ld l, $F7
    ld bc, $4090
    jp ClearDamageAndStoreWDAC0_Bank36

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 60 Chance; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; writes: wBattleActionId, wRecordBuffer, wCFED, wBattleTarget, wBattleSubPhase, wBattleResolveStep
; points at: wBattleActionChoice, wBattleTargetChoice
ActionEffect_Chance:: ; heuristic: follows a terminator; C0
Func_036_714F:: ; address name
    farcall ActionEffect_Chance_Sub01
    ld a, [wBattleActor]
    ld hl, wBattleActionChoice
    add a, a
    add_a_to_hl
    ld a, c
    ld [hl], a
    ld [wBattleActionId], a
    ld [wRecordBuffer], a
    ld a, $00
    ld [wCFED], a
    farcall LoadSkillRecord
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld [hl], $FF
    farcall Func_030_4102
    ld a, d
    ld [wBattleTarget], a
    xor a, a
    ld [wBattleSubPhase], a
    ld a, $03
    ld [wBattleResolveStep], a
    ret
    db $FA, $66, $D8, $6F, $FA, $67, $D8, $67, $7D, $B4, $CA, $B7, $7C, $CD, $5C, $58
    db $C3, $7D, $7C

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 62 BigBang; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: sB535
ActionEffect_BigBang:: ; heuristic: target of a pointer table; C0
Func_036_71A9:: ; address name
    call ActionEffect_BigBang_Sub01
    jp Jump_036_7C7D

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 64 FireAir, 65 BlazeAir, 66 Scorching, 67 WhiteFire; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: sB535
ActionEffect_FireAir:: ; heuristic: target of a pointer table; C0
Func_036_71AF:: ; address name
    call ActionEffect_FireAir_Sub01
    call Func_036_7D13
    jp Jump_036_7C7D

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 68 FrigidAir, 69 IceAir, 70 IceStorm, 71 WhiteAir; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: sB535
ActionEffect_FrigidAir:: ; heuristic: target of a pointer table; C0
Func_036_71B8:: ; address name
    call ActionEffect_FrigidAir_Sub01
    call Func_036_7D13
    jp Jump_036_7C7D

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 72 WindBeast; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: sB535
ActionEffect_WindBeast:: ; heuristic: target of a pointer table; C0
Func_036_71C1:: ; address name
    call ActionEffect_WindBeast_Sub01
    jp Jump_036_7C7D

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 73 Vacuum; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: sB535
ActionEffect_Vacuum:: ; heuristic: target of a pointer table; C0
Func_036_71C7:: ; address name
    call ActionEffect_Vacuum_Sub01
    jp Jump_036_7C7D

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 74 Lightning; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: sB535
ActionEffect_Lightning:: ; heuristic: target of a pointer table; C0
Func_036_71CD:: ; address name
    call ActionEffect_Lightning_Sub01
    jp Jump_036_7C7D

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 75 RockThrow; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: sB535
ActionEffect_RockThrow:: ; heuristic: target of a pointer table; C0
Func_036_71D3:: ; address name
    call ActionEffect_RockThrow_Sub01
    jp Jump_036_7C7D

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 76 Watershot, 77 Tidalwave; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: sB535
ActionEffect_Watershot:: ; heuristic: target of a pointer table; C0
Func_036_71D9:: ; address name
    call ActionEffect_Watershot_Sub01
    jp Jump_036_7C7D

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 78 CallHelp, 79 YellHelp; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wC5E7
; writes: wBattleSubPhase, wBattleResolveStep, wDAC3, wDAC0, wDAC1, wDAC2
; points at: wD812, wD035
ActionEffect_CallHelp:: ; heuristic: target of a pointer table; C0
Func_036_71DF:: ; address name
    ld a, [wBattleActor]
    ld hl, wD812
    call AddAx9ToHL
    bit 0, [hl]
    jr nz, Jump_036_7214
    push hl
    call AdvanceRandom
    pop hl
    ld a, [wC5E7]
    cp a, $80
    jr c, Jump_036_720C
    set 0, [hl]
    ld d, $53
    farcall ShowBattleText
    ld a, $03
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    ret

Jump_036_720C::
    ld h, $69
    ld bc, $0080
    jp Jump_036_7CBC

Jump_036_7214::
    call ActionEffect_CallHelp_Sub01
    jp ResolveStepComputeDamage_Sub02

Data_036_721A:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $22, $55, $C3, $85, $7C

Data_036_7220:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $33, $55, $C3, $85, $7C

Data_036_7226:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $44, $55, $C3, $85, $7C

Data_036_722C:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $55, $55, $C3, $85, $7C

Data_036_7232:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $66, $55, $C3, $85, $7C

Data_036_7238:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $71, $55, $C3, $85, $7C

Data_036_723E:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $7C, $55, $C3, $85, $7C

Data_036_7244:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $87, $55, $C3, $85, $7C

Data_036_724A:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $92, $55, $C3, $85, $7C

Data_036_7250:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $9D, $55, $C3, $85, $7C

Data_036_7256:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $A8, $55, $C3, $85, $7C

Data_036_725C:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $B3, $55, $C3, $85, $7C

Data_036_7262:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $BE, $55, $C3, $85, $7C

Data_036_7268:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0DB268, $78

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 105 PsycheUp; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; 1 call site from 1 routine (e.g. ActionEffect_TwinSlash)
; reads: wBattleDamageLo, wD873
; writes: wBattleDamageLo, wD873, wDAC2, wDAC3, wDAC0, wDAC1
; points at: wD035
ActionEffect_PsycheUp::
Func_036_72E0:: ; address name
    call ComputeAttackDamage
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wD873]
    ld h, a
    call Func_036_6465
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    jp ResolveStepComputeDamage_Sub02

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 106 HighJump; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wDAD1, wDABD, wBattleDamageLo, wD873
; writes: wBattleTarget, wDAD1, wBattleSubPhase, wBattleResolveStep, wDAC0, wDAC1, wBattleDamageLo, wD873, ...
; points at: wD810, wBattleTargetChoice, wD035
ActionEffect_HighJump:: ; heuristic: target of a pointer table; C0
Func_036_72F9:: ; address name
    ld a, [wBattleActor]
    ld hl, wD810
    call AddAx9ToHL
    ld a, [hl]
    and a, $0C
    jr nz, Jump_036_730E
    ld a, [hl]
    or a, $0C
    ld [hl], a
    jp Jump_036_7CD3

Jump_036_730E::
    ld a, [hl]
    and a, $F3
    ld [hl], a
    jr ActionEffect_PsycheUp

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 107 EvilSlash; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wC5E7, wBattleActor
; writes: wBattleDamageLo, wD873, wDAC2, wDAC3, wDAC0, wDAC1
; points at: wD80E, wD235
ActionEffect_EvilSlash:: ; heuristic: target of a pointer table; C0
Func_036_7314:: ; address name
    ld a, [wBattleTarget]
    call CheckSlotStatusBlock
    jr c, Jump_036_7326
    call AdvanceRandom
    ld a, [wC5E7]
    cp a, $A0
    jr c, Jump_036_734B

Jump_036_7326::
    ld a, [wBattleActor]
    ld hl, wD80E
    call AddAx9ToHL
    res 7, [hl]
    ld a, [wBattleActor]
    call GetBattleATK
    call Func_036_4930
    ld a, e
    ld [wBattleDamageLo], a
    ld a, d
    ld [wD873], a
    ld hl, wD235
    ld bc, vTiles0 + $A8
    jp Jump_036_7C8B

Jump_036_734B::
    ld h, $D2
    ld bc, $0080
    jp Jump_036_7CBC

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 108 Massacre; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; writes: wBattleDamageLo, wD873, wDAC2, wDAC3, wDAC0, wDAC1
; points at: wD80E, sB535
ActionEffect_Massacre:: ; heuristic: target of a pointer table; C0
Func_036_7353:: ; address name
    ld a, [wBattleActor]
    ld hl, wD80E
    call AddAx9ToHL
    res 7, [hl]
    ld a, [wBattleActor]
    call GetBattleATK
    call Func_036_4930
    ld a, e
    ld [wBattleDamageLo], a
    ld a, d
    ld [wD873], a
    ld hl, sB535
    ld bc, vTiles0 + $A8
    jp Jump_036_7C8B

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 109 TwinSlash; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wD80E
ActionEffect_TwinSlash:: ; heuristic: target of a pointer table; C0
Func_036_7378:: ; address name
    ld a, [wBattleActor]
    ld hl, wD80E
    call AddAx9ToHL
    res 7, [hl]
    call ActionEffect_PsycheUp
    ret

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 110 Berserker; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wBattleDamageLo, wD873
; writes: wBattleDamageLo, wD873, wDAC2, wDAC3, wDAC0, wDAC1
; points at: wD812, wD80E, wD035
ActionEffect_Berserker:: ; heuristic: target of a pointer table; C0
Func_036_7387:: ; address name
    ld a, [wBattleActor]
    ld hl, wD812
    call AddAx9ToHL
    set 2, [hl]
    ld a, [wBattleActor]
    ld hl, wD80E
    call AddAx9ToHL
    res 7, [hl]
    call ComputeAttackDamage
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wD873]
    ld h, a
    sla l
    rl h
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    jp ResolveStepComputeDamage_Sub02
    db $CD, $7A, $5A, $C3, $85, $7C, $CD, $98, $5A, $C3, $7D, $7C

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 114 PalsyAir; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wDAD1, wBattleActor, wDABD
; writes: wDAC3, wDAC0, wDAC1, wBattleDamageLo, wD873, wDAC2, wBattleTarget, wDAD1, ...
; points at: wBattleStatus, wBattleTargetChoice
ActionEffect_PalsyAir:: ; heuristic: target of a pointer table; C0
Func_036_73C3:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit 6, [hl]
    jr nz, Jump_036_73E9
    push hl
    call Func_036_60EB
    pop hl
    jr c, Jump_036_73DF
    ld h, $B5
    ld bc, $0888
    jp Jump_036_7CBC

Jump_036_73DF::
    set 6, [hl]
    ld l, $76
    ld bc, $4090
    jp ClearDamageAndStoreWDAC0_Bank36

Jump_036_73E9::
    jp Jump_036_7CD3

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 115 PoisonGas, 116 PoisonAir; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleActionId, wDAD1, wBattleActor, wDABD
; writes: wDAC3, wDAC0, wDAC1, wBattleDamageLo, wD873, wDAC2, wBattleTarget, wDAD1, ...
; points at: wBattleStatus, wBattleTargetChoice
ActionEffect_PoisonGas:: ; heuristic: target of a pointer table; C0
Func_036_73EC:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [wBattleActionId]
    cp a, $74
    jr z, Jump_036_7403
    ld a, [hl]
    and a, $03
    jr nz, Jump_036_7431
    jr Jump_036_7407

Jump_036_7403::
    bit 1, [hl]
    jr nz, Jump_036_7431

Jump_036_7407::
    push hl
    call Func_036_60D1
    pop hl
    jr c, Jump_036_7416
    ld h, $B5
    ld bc, $0888
    jp Jump_036_7CBC

Jump_036_7416::
    ld a, [wBattleActionId]
    cp a, $74
    jr z, Jump_036_7425
    set 0, [hl]
    res 1, [hl]
    ld l, $75
    jr Jump_036_742B

Jump_036_7425::
    set 1, [hl]
    res 0, [hl]
    ld l, $77

Jump_036_742B::
    ld bc, $4090
    jp ClearDamageAndStoreWDAC0_Bank36

Jump_036_7431::
    jp Jump_036_7CD3

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 117 Curse; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wDAD1, wBattleActor, wDABD
; writes: wDAC3, wDAC0, wDAC1, wBattleDamageLo, wD873, wDAC2, wBattleTarget, wDAD1, ...
; points at: wBattleStatus, wBattleTargetChoice
ActionEffect_Curse:: ; heuristic: target of a pointer table; C0
Func_036_7434:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit 5, [hl]
    jr nz, Jump_036_745A
    push hl
    call ActionEffect_Curse_Sub01
    pop hl
    jr c, Jump_036_7450
    ld h, $B5
    ld bc, $0888
    jp Jump_036_7CBC

Jump_036_7450::
    set 5, [hl]
    ld l, $D9
    ld bc, $4090
    jp ClearDamageAndStoreWDAC0_Bank36

Jump_036_745A::
    jp Jump_036_7CD3

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 118 OddDance; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wDAD1, wBattleActor, wDABD
; writes: wBattleTarget, wDAD1, wBattleSubPhase, wBattleResolveStep, wDAC0, wDAC1
; points at: wBattleMP, wBattleTargetChoice
ActionEffect_OddDance:: ; heuristic: target of a pointer table; C0
Func_036_745D:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleMP
    call AddDoubleAToHL_Bank36
    ld a, [hl+]
    or a, [hl]
    jr z, Jump_036_747B
    db $CD

; no direct call (reached through a table, a jump or a vector)
; writes: wDAC2, wDAC0, wDAC1, wDAC3
Func_036_746B:: ; heuristic: target of a pointer table; C0
    ld h, $56
    jp nc, Jump_036_7CB7
    call Func_036_5671
    ld l, $57
    ld bc, $4090
    jp Jump_036_7CA3

Jump_036_747B::
    jp Jump_036_7CD3

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 122 LureDance; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wDAD1, wBattleActor, wDABD
; writes: wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1, wDAC3, wBattleTarget, wDAD1, ...
; points at: wBattleTargetChoice
ActionEffect_LureDance:: ; heuristic: target of a pointer table; C0
Func_036_747E:: ; address name
    call Func_036_7D5B
    bit 1, [hl]
    jr nz, Jump_036_749D
    call Func_036_5B5D
    jr nc, Jump_036_749A
    call Func_036_7D5B
    set 1, [hl]
    call Func_036_7D65
    ld l, $58
    ld bc, $0090
    jp ClearDamageAndStoreWDAC0_Bank36

Jump_036_749A::
    jp Jump_036_7CB7

Jump_036_749D::
    jp Jump_036_7CD3

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 123 LifeDance; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wDABA, wC5E7
; writes: wBattleSubPhase, wBattleResolveStep, wBattleSubStep
; points at: wCFCF
ActionEffect_LifeDance:: ; heuristic: target of a pointer table; C0
Func_036_74A0:: ; address name
    ld a, [wDABA]
    or a, a
    jr nz, Jump_036_74CD
    call AdvanceRandom
    ld a, [wC5E7]
    and a, $01
    jr nz, Jump_036_74CD
    ld d, $CC
    farcall ShowBattleText
    ld a, $01
    ld [wBattleSubPhase], a
    ld a, $0E
    ld [wBattleResolveStep], a
    ld a, $00
    ld [wBattleSubStep], a
    ld hl, wCFCF
    set 0, [hl]
    ret

Jump_036_74CD::
    call ActionEffect_Farewell
    ret

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 125 SideStep; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wC5E7, wDAD1, wDABD
; writes: wBattleTarget, wDAD1, wBattleSubPhase, wBattleResolveStep, wDAC0, wDAC1
; points at: wD811, wBattleTargetChoice
ActionEffect_SideStep:: ; heuristic: target of a pointer table; C0
Func_036_74D1:: ; address name
    call AdvanceRandom
    ld a, [wBattleActor]
    ld hl, wD811
    call AddAx9ToHL
    ld a, [hl]
    and a, $0C
    jr nz, Jump_036_74EF
    ld a, [wC5E7]
    and a, $04
    add a, $04
    ld b, a
    ld a, [hl]
    and a, $F3
    or a, b
    ld [hl], a

Jump_036_74EF::
    jp Jump_036_7CD3

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 126 SandStorm; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleActionId, wDAD1, wBattleActor, wDABD
; writes: wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1, wDAC3, wBattleTarget, wDAD1, ...
; points at: wD811, wD80D, wBattleTargetChoice
ActionEffect_SandStorm:: ; heuristic: target of a pointer table; C0
Func_036_74F2:: ; address name
    ld d, $02
    jr Jump_036_74F8

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 127 Radiant; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleActionId, wDAD1, wBattleActor, wDABD
; writes: wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1, wDAC3, wBattleTarget, wDAD1, ...
; points at: wD811, wD80D, wBattleTargetChoice
ActionEffect_Radiant:: ; heuristic: target of a pointer table; C0
Func_036_74F6:: ; address name
    ld d, $01

Jump_036_74F8::
    ld a, [wBattleTarget]
    ld hl, wD811
    call AddAx9ToHL
    ld a, [hl]
    and a, d
    jr nz, Jump_036_7539
    ld a, [wBattleTarget]
    ld hl, wD80D
    call AddAx9ToHL
    bit 1, [hl]
    jr nz, Jump_036_7539
    push de
    call Func_036_55FB
    pop de
    jr nc, Jump_036_7531
    ld a, [wBattleTarget]
    ld hl, wD811
    call AddAx9ToHL
    ld a, [hl]
    or a, d
    ld [hl], a
    ld a, [wBattleActionId]
    sub a, $2A
    ld l, a
    ld bc, $0090
    jp ClearDamageAndStoreWDAC0_Bank36

Jump_036_7531::
    ld h, $B5
    ld bc, $0888
    jp Jump_036_7CBC

Jump_036_7539::
    jp Jump_036_7CD3

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 128 EerieLite; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1, wDAC3
; points at: wD814
ActionEffect_EerieLite:: ; heuristic: target of a pointer table; C0
Func_036_753C:: ; address name
    ld a, [wBattleTarget]
    ld hl, wD814
    call AddAx9ToHL
    bit 7, [hl]
    jr nz, Jump_036_7569
    call ActionEffect_EerieLite_Sub01
    jr nc, Jump_036_7561
    ld a, [wBattleTarget]
    ld hl, wD814
    call AddAx9ToHL
    set 7, [hl]
    ld l, $D5
    ld bc, $0098
    jp ClearDamageAndStoreWDAC0_Bank36

Jump_036_7561::
    ld h, $B5
    ld bc, $0888
    jp Jump_036_7CBC

Jump_036_7569::
    ld h, $CC
    ld bc, $0084
    jp Jump_036_7CBC

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 129 Surge; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1
ActionEffect_Surge:: ; heuristic: target of a pointer table; C0
Func_036_7571:: ; address name
    farcall ActionEffect_Surge_Sub01
    ld l, $60
    ld bc, $0090
    jp ClearDamageAndStoreWDAC0_Bank36

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 130 UltraDown; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleSubStep, wDAC3, wDAC0, wDAC1
ActionEffect_UltraDown:: ; heuristic: target of a pointer table; C0
Func_036_757F:: ; address name
    call Func_036_5B19
    jr nc, Jump_036_7591
    call ActionEffect_UltraDown_Sub01
    jr nc, Jump_036_7591
    call ActionEffect_UltraDown_Sub02
    xor a, a
    ld [wBattleSubStep], a
    ret

Jump_036_7591::
    ld h, $B5
    ld bc, $0080
    jp Jump_036_7CBC

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 131 DeMagic, 132 ThickFog, $B3; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleSubStep, wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1
ActionEffect_DeMagic:: ; heuristic: target of a pointer table; C0
Func_036_7599:: ; address name
    farcall ActionEffect_DeMagic_Sub01
    xor a, a
    ld [wBattleSubStep], a
    ld l, $5E
    ld bc, $0090
    jp ClearDamageAndStoreWDAC0_Bank36

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 133 TatsuCall, 134 DiagoCall, 135 SamsiCall, 136 BazooCall; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wC5E7, wBattleActionId, wD871
; writes: wD871, wBattleTarget, wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1, wDAC3
; points at: wD80A, wD854, wDAAE
ActionEffect_TatsuCall:: ; heuristic: target of a pointer table; C0
Func_036_75AB:: ; address name
    ld a, [wBattleActor]
    rrca
    rrca
    and a, $01
    ld hl, wD80A
    add_a_to_hl
    bit 2, [hl]
    jr nz, Jump_036_761F
    push hl
    ld a, [wBattleActor]
    ld hl, wD854
    add a, a
    add_a_to_hl
    ld a, [hl]
    pop hl
    and a, $04
    jr nz, Jump_036_75DD
    call AdvanceRandom
    ld a, $C0
    ld b, a
    ld a, [wC5E7]
    cp a, b
    jr nc, Jump_036_7617

Jump_036_75DD::
    set 2, [hl]
    ld a, [wBattleActor]
    and a, $04
    or a, $03
    ld [wD871], a
    ld a, [wBattleActionId]
    sub a, $07
    ld c, a
    ld b, $00
    ld a, [wD871]
    srl a
    srl a
    and a, $01
    add a, a
    ld hl, wDAAE
    add_a_to_hl
    ld [hl], c
    inc hl
    ld [hl], b
    call ActionEffect_TatsuCall_Sub01
    ld a, [wD871]
    ld [wBattleTarget], a
    ld l, $61
    ld bc, $0090
    jp ClearDamageAndStoreWDAC0_Bank36

Jump_036_7617::
    ld h, $72
    ld bc, $0080
    jp Jump_036_7CBC

Jump_036_761F::
    ld h, $CC
    ld bc, $0084
    jp Jump_036_7CBC

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 137 SuckAir; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wDAD1, wDABD
; writes: wBattleTarget, wDAD1, wBattleSubPhase, wBattleResolveStep, wDAC0, wDAC1
; points at: wD810, wBattleTargetChoice
ActionEffect_SuckAir:: ; heuristic: target of a pointer table; C0
Func_036_7627:: ; address name
    ld a, [wBattleActor]
    ld hl, wD810
    call AddAx9ToHL
    ld a, [hl]
    or a, $30
    ld [hl], a
    jp Jump_036_7CD3

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 138 Focus; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wDAD1, wDABD
; writes: wBattleTarget, wDAD1, wBattleSubPhase, wBattleResolveStep, wDAC0, wDAC1
; points at: wD810, wBattleTargetChoice
ActionEffect_Focus:: ; heuristic: target of a pointer table; C0
Func_036_7637:: ; address name
    ld a, [wBattleActor]
    ld hl, wD810
    call AddAx9ToHL
    set 7, [hl]
    jp Jump_036_7CD3

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 139 LushLicks, 140 SickLick; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActionId, wBattleTarget, wDAD1, wBattleActor, wDABD
; writes: wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1, wDAC3, wBattleTarget, wDAD1, ...
; points at: wBattleDEF, wBattleTargetChoice
ActionEffect_LushLicks:: ; heuristic: target of a pointer table; C0
Func_036_7645:: ; address name
    call Func_036_7D5B
    bit 3, [hl]
    jr nz, Jump_036_7694
    ld a, [wBattleActionId]
    cp a, $8C
    jr z, Jump_036_7658
    call Func_036_5B5D
    jr Jump_036_765B

Jump_036_7658::
    call Func_036_53C6

Jump_036_765B::
    jr nc, Jump_036_768C
    call Func_036_7D5B
    set 3, [hl]
    call Func_036_7D65
    ld a, [wBattleActionId]
    cp a, $8B
    jr z, Jump_036_7680
    ld a, [wBattleTarget]
    ld hl, wBattleDEF
    call AddDoubleAToHL_Bank36
    ld a, $01
    ld [hl+], a
    ld [hl], $00
    ld a, [wBattleTarget]
    call Func_036_7D50

Jump_036_7680::
    ld a, [wBattleActionId]
    sub a, $31
    ld l, a
    ld bc, $0090
    jp ClearDamageAndStoreWDAC0_Bank36

Jump_036_768C::
    ld h, $71
    ld bc, $0888
    jp Jump_036_7CBC

Jump_036_7694::
    jp Jump_036_7CD3

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 141 LegSweep, 142 BigTrip; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wDAD1, wBattleActor, wDABD
; writes: wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1, wDAC3, wBattleTarget, wDAD1, ...
; points at: wD8A7, wBattleTargetChoice
ActionEffect_LegSweep:: ; heuristic: target of a pointer table; C0
Func_036_7697:: ; address name
    call Func_036_7D5B
    bit 2, [hl]
    jp nz, Jump_036_7CD3
    call ActionEffect_LegSweep_Sub01
    jr nc, Jump_036_76B4
    call Func_036_7D5B
    set 2, [hl]
    call Func_036_7D65
    ld l, $5D
    ld bc, $0090
    jp ClearDamageAndStoreWDAC0_Bank36

Jump_036_76B4::
    ld a, [wBattleTarget]
    ld hl, wD8A7
    add_a_to_hl
    bit 4, [hl]
    ld h, $70
    jr z, Jump_036_76C7
    ld h, $68

Jump_036_76C7::
    ld bc, $0080
    jp Jump_036_7CBC

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 143 Ahhh; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wDAD1, wBattleActor, wDABD
; writes: wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1, wDAC3, wBattleTarget, wDAD1, ...
; points at: wBattleTargetChoice
ActionEffect_Ahhh:: ; heuristic: target of a pointer table; C0
Func_036_76CD:: ; address name
    call Func_036_7D5B
    bit 5, [hl]
    jr nz, Jump_036_76F1
    call Func_036_5B5D
    jr nc, Jump_036_76E9
    call Func_036_7D5B
    set 5, [hl]
    call Func_036_7D65
    ld l, $59
    ld bc, $0090
    jp ClearDamageAndStoreWDAC0_Bank36

Jump_036_76E9::
    ld h, $B5
    ld bc, $0888
    jp Jump_036_7CBC

Jump_036_76F1::
    jp Jump_036_7CD3

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 144 WarCry; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wDAD1, wBattleActor, wDABD
; writes: wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1, wDAC3, wBattleTarget, wDAD1, ...
; points at: wBattleTargetChoice
ActionEffect_WarCry:: ; heuristic: target of a pointer table; C0
Func_036_76F4:: ; address name
    call Func_036_7D5B
    bit 4, [hl]
    jr nz, Jump_036_7718
    call Func_036_5B5D
    jr nc, Jump_036_7710
    call Func_036_7D5B
    set 4, [hl]
    call Func_036_7D65
    ld l, $5C
    ld bc, $0090
    jp ClearDamageAndStoreWDAC0_Bank36

Jump_036_7710::
    ld h, $6B
    ld bc, $0080
    jp Jump_036_7CBC

Jump_036_7718::
    jp Jump_036_7CD3

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 145 Geyser; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wBattleTarget, wC5E7
; writes: wBattleSubPhase, wBattleResolveStep, wDAC3, wDAC0, wDAC1, wBattleTarget, wBattleDamageLo, wD873, ...
; points at: wD80F, wD854, wBattleStatus, wD0AD
ActionEffect_Geyser:: ; heuristic: target of a pointer table; C0
Func_036_771B:: ; address name
    ld a, [wBattleActor]
    ld hl, wD80F
    call AddAx9ToHL
    ld a, [hl]
    and a, $C0
    cp a, $40
    jr z, Jump_036_775E
    call ActionEffect_Geyser_Sub01
    jr nc, Jump_036_7756
    ld a, [wBattleTarget]
    ld hl, wD80F
    call AddAx9ToHL
    ld a, [hl]
    ld a, $40
    ld [hl], a
    ld a, [wBattleTarget]
    add a, a
    ld hl, wD854
    add_a_to_hl
    ld [hl], $00
    ld d, $DD
    farcall ShowBattleText
    jp Func_036_7CC9

Jump_036_7756::
    ld h, $6E
    ld bc, $0080
    jp Jump_036_7CBC

Jump_036_775E::
    ld a, [hl]
    and a, $3F
    ld [hl], a
    ld a, [wBattleActor]
    ld [wBattleTarget], a
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit 6, [hl]
    jr nz, Jump_036_7780
    bit 7, [hl]
    jr nz, Jump_036_7780
    call AdvanceRandom
    ld a, [wC5E7]
    and a, $01
    jr z, Jump_036_77AD

Jump_036_7780::
    ld a, [wBattleActor]
    call GetBattleMaxHP
    push hl
    call ActionEffect_Geyser_Sub02
    ld c, l
    ld b, h
    pop hl
    push bc
    call ActionEffect_Geyser_Sub03
    pop bc
    call RandomInRange
    ld a, d
    or a, e
    jr nz, Jump_036_779C
    ld de, $0001

Jump_036_779C::
    ld a, e
    ld [wBattleDamageLo], a
    ld a, d
    ld [wD873], a
    ld hl, wD0AD
    ld bc, vTiles1 + $A8
    jp Jump_036_7C8B

Jump_036_77AD::
    ld h, $AF
    ld bc, $0080
    jp Jump_036_7CBC

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 146 DanceShut; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wDAD1, wBattleActor, wDABD
; writes: wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1, wDAC3, wBattleTarget, wDAD1, ...
; points at: wD80D, wBattleTargetChoice
ActionEffect_DanceShut:: ; heuristic: target of a pointer table; C0
Func_036_77B5:: ; address name
    ld a, [wBattleTarget]
    ld hl, wD80D
    call AddAx9ToHL
    bit 6, [hl]
    jp nz, Jump_036_7CD3
    call ActionEffect_DanceShut_Sub01
    jr nc, Jump_036_77DB
    ld a, [wBattleTarget]
    ld hl, wD80D
    call AddAx9ToHL
    set 6, [hl]
    ld l, $DE
    ld bc, $4098
    jp ClearDamageAndStoreWDAC0_Bank36

Jump_036_77DB::
    jp Jump_036_7CB7

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 147 MouthShut; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wDAD1, wBattleActor, wDABD
; writes: wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1, wDAC3, wBattleTarget, wDAD1, ...
; points at: wD80D, wBattleTargetChoice
ActionEffect_MouthShut:: ; heuristic: target of a pointer table; C0
Func_036_77DE:: ; address name
    ld a, [wBattleTarget]
    ld hl, wD80D
    call AddAx9ToHL
    bit 7, [hl]
    jr nz, Jump_036_7806
    call ActionEffect_MouthShut_Sub01
    jr nc, Jump_036_7803
    ld a, [wBattleTarget]
    ld hl, wD80D
    call AddAx9ToHL
    set 7, [hl]
    ld l, $64
    ld bc, $4098
    jp ClearDamageAndStoreWDAC0_Bank36

Jump_036_7803::
    jp Jump_036_7CB7

Jump_036_7806::
    jp Jump_036_7CD3

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 148 StrongD, 150 BladeD; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; 1 call site from 1 routine (e.g. ActionEffect_ActionE0)
; reads: wBattleActor, wBattleActionId, wDAD1, wDABD
; writes: wBattleTarget, wDAD1, wBattleSubPhase, wBattleResolveStep, wDAC0, wDAC1
; points at: wD813, wBattleTargetChoice
ActionEffect_StrongD:: ; heuristic: target of a pointer table; C0
Func_036_7809:: ; address name
    ld a, [wBattleActor]
    ld hl, wD813
    call AddAx9ToHL
    ld a, [wBattleActionId]
    cp a, $96
    jr z, Jump_036_782D
    cp a, $E0
    jr nz, Jump_036_7825
    ld a, [hl]
    and a, $F0
    or a, $0C
    ld [hl], a
    jr Jump_036_7833

Jump_036_7825::
    ld a, [hl]
    and a, $F0
    or a, $02
    ld [hl], a
    jr Jump_036_7833

Jump_036_782D::
    ld a, [hl]
    and a, $F0
    or a, $04
    ld [hl], a

Jump_036_7833::
    jp Jump_036_7CD3

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 149 Dodge; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wDAD1, wDABD
; writes: wBattleTarget, wDAD1, wBattleSubPhase, wBattleResolveStep, wDAC0, wDAC1
; points at: wD812, wBattleTargetChoice
ActionEffect_Dodge:: ; heuristic: target of a pointer table; C0
Func_036_7836:: ; address name
    ld a, [wBattleActor]
    ld hl, wD812
    call AddAx9ToHL
    set 5, [hl]
    jp Jump_036_7CD3

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 151 Cover, 152 Guardian; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleActionId, wBattleActor, wDAD1, wDABD
; writes: wBattleTarget, wDAD1, wBattleSubPhase, wBattleResolveStep, wDAC0, wDAC1
; points at: wD80A, wBattleActor, wD812, wBattleTargetChoice
ActionEffect_Cover:: ; heuristic: target of a pointer table; C0
Func_036_7844:: ; address name
    ld a, [wBattleTarget]
    rrca
    rrca
    and a, $01
    ld hl, wD80A
    add a, l
    ld l, a

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActionId, wBattleTarget, wBattleActor, wDAD1, wDABD
; writes: wBattleTarget, wDAD1, wBattleSubPhase, wBattleResolveStep, wDAC0, wDAC1
; points at: wBattleActor, wD812, wBattleTargetChoice
Func_036_7850:: ; heuristic: target of a pointer table; C0
    jr nc, Jump_036_7853
    inc h

Jump_036_7853::
    bit 4, [hl]
    jp nz, Jump_036_7CD3
    ld a, [wBattleActionId]
    cp a, $98
    jr z, Jump_036_7867
    ld a, [wBattleTarget]
    ld c, a
    ld b, $01
    jr Jump_036_7871

Jump_036_7867::
    set 4, [hl]
    ld a, [wBattleTarget]
    and a, $04
    ld c, a
    ld b, $03

Jump_036_7871::
    ld a, c

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wDAD1, wDABD
; writes: wBattleTarget, wDAD1, wBattleSubPhase, wBattleResolveStep, wDAC0, wDAC1
; points at: wBattleActor, wD812, wBattleTargetChoice
Func_036_7872:: ; heuristic: target of a pointer table; C0
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_036_7894
    ld a, c
    ld hl, wBattleActor
    cp a, [hl]
    jr z, Jump_036_7894
    ld hl, wD812
    call AddAx9ToHL
    bit 4, [hl]
    jr nz, Jump_036_7894
    set 4, [hl]
    inc hl
    ld a, [wBattleActor]
    and a, $0F
    swap a
    or a, [hl]
    ld [hl], a

Jump_036_7894::
    inc c
    dec b
    jr nz, Jump_036_7871
    jp Jump_036_7CD3

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 153 TailWind, 154 StormWind; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActionId, wBattleTarget, wDAD1, wBattleActor, wDABD
; writes: wBattleTarget, wDAD1, wBattleSubPhase, wBattleResolveStep, wDAC0, wDAC1
; points at: wD80E, wBattleTargetChoice, wD80A
ActionEffect_TailWind:: ; heuristic: target of a pointer table; C0
Func_036_789B:: ; address name
    ld a, [wBattleActionId]
    cp a, $9A
    jr z, Jump_036_78AF
    ld a, [wBattleTarget]
    ld hl, wD80E
    call AddAx9ToHL
    set 6, [hl]
    jr Jump_036_78DB

Jump_036_78AF::
    ld a, [wBattleTarget]
    and a, $04
    ld c, a
    ld b, $03

Jump_036_78B7::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_036_78C6
    ld a, c
    ld hl, wD80E
    call AddAx9ToHL
    set 6, [hl]

Jump_036_78C6::
    inc c
    dec b
    jr nz, Jump_036_78B7
    ld a, [wBattleTarget]
    rra
    rra
    and a, $01
    ld hl, wD80A
    add_a_to_hl
    set 5, [hl]

Jump_036_78DB::
    jp Jump_036_7CD3

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 155 AquaWall; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wDAD1, wDABD
; writes: wBattleTarget, wDAD1, wBattleSubPhase, wBattleResolveStep, wDAC0, wDAC1
; points at: wD80E, wBattleTargetChoice
ActionEffect_AquaWall:: ; heuristic: target of a pointer table; C0
Func_036_78DE:: ; address name
    ld a, [wBattleActor]
    ld hl, wD80E
    call AddAx9ToHL
    set 3, [hl]
    jp Jump_036_7CD3

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 156 SealPray; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wDAD1, wDABD
; writes: wBattleTarget, wDAD1, wBattleSubPhase, wBattleResolveStep, wDAC0, wDAC1
; points at: wD814, wBattleTargetChoice
ActionEffect_SealPray:: ; heuristic: target of a pointer table; C0
Func_036_78EC:: ; address name
    ld a, [wBattleActor]
    ld hl, wD814
    call AddAx9ToHL
    set 4, [hl]
    jp Jump_036_7CD3

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 157 SuckAll; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wDAD1, wDABD
; writes: wBattleTarget, wDAD1, wBattleSubPhase, wBattleResolveStep, wDAC0, wDAC1
; points at: wD80A, wD864, wD812, wBattleTargetChoice
ActionEffect_SuckAll:: ; heuristic: target of a pointer table; C0
Func_036_78FA:: ; address name
    ld a, [wBattleActor]
    rrca
    rrca
    and a, $01
    ld b, a
    ld hl, wD80A
    add_a_to_hl
    bit 6, [hl]
    jp nz, Jump_036_7CD3
    set 6, [hl]
    ld a, b
    ld hl, wD864
    add_a_to_hl
    ld a, [wBattleActor]
    and a, $03
    rla
    rla
    or a, [hl]
    ld [hl], a
    ld a, [wBattleActor]
    ld hl, wD812
    call AddAx9ToHL
    set 1, [hl]
    jp Jump_036_7CD3

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 158 Imitate; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wDAD1, wDABD
; writes: wBattleTarget, wDAD1, wBattleSubPhase, wBattleResolveStep, wDAC0, wDAC1
; points at: wD812, wBattleTargetChoice
ActionEffect_Imitate:: ; heuristic: target of a pointer table; C0
Func_036_7931:: ; address name
    ld a, [wBattleActor]
    ld hl, wD812
    call AddAx9ToHL
    set 3, [hl]
    jp Jump_036_7CD3
    db $CD, $86, $5E, $30, $08, $2E, $37, $01, $90, $40, $C3, $A3, $7C, $C3, $B0, $7C
    db $FA, $A4, $D8, $21, $11, $D8, $CD, $25, $3F, $7E, $E6, $10, $20, $09, $7E, $E6
    db $CF, $F6, $20, $77, $C3, $03, $7D

Jump_036_7966::
    ld a, [wDABA]
    or a, a
    jr nz, Jump_036_7981
    call AdvanceRandom
    ld a, [wC5E7]
    cp a, $80
    jr c, Jump_036_7981
    ld d, $72
    farcall ShowBattleText
    jp Func_036_7D03

Jump_036_7981::
    ld a, [wBattleTarget]
    call CarryUnlessWDA63SlotEmpty
    jr nc, Jump_036_7998
    jr z, Jump_036_7998
    ld a, [wBattleTarget]
    and a, $03
    cp a, $03
    jr z, Jump_036_7998
    call Func_036_6D0A
    ret

Jump_036_7998::
    jp Jump_036_7CD3

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 161 LoveRain; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wC5E7, wC96F
; writes: wBattleSubPhase, wBattleResolveStep
; points at: wD814, wDAFA
ActionEffect_LoveRain:: ; heuristic: follows a terminator; C0
Func_036_799B:: ; address name
    ld a, [wBattleActor]
    ld hl, wD814
    call AddAx9ToHL
    ld a, [hl]
    and a, $01
    jr nz, Jump_036_79CF
    push hl
    call AdvanceRandom
    ld a, [wC5E7]
    and a, $0F
    ld hl, $79DC
    add_a_to_hl
    ld a, [hl]
    push af
    ld a, [wBattleActor]
    ld hl, wDAFA
    add_a_to_hl
    pop af
    ld [hl], a
    pop hl
    set 1, [hl]
    jp Func_036_7D03

Jump_036_79CF::
    ld a, [wC96F]
    or a, a
    jr z, Jump_036_79D9
    call ActionEffect_Heal
    ret

Jump_036_79D9::
    jp Func_036_7D03
    db $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $01, $01, $02, $02, $02, $02
    db $C9, $CD, $13, $50, $FA, $72, $D8, $6F, $FA, $73, $D8, $67, $CD, $1C, $65, $7D
    db $EA, $72, $D8, $7C, $EA, $73, $D8, $C3, $7D, $7C, $FA, $A4, $D8, $21, $13, $D8
    db $CD, $25, $3F, $7E, $E6, $F0, $F6, $01, $77, $C3, $D3, $7C

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $B0, $B2; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wC58A, wBattleActor, wBattleTarget, wBattleActionId, wDAD1, wDABD
; writes: wBattleTarget, wDAD1, wBattleSubPhase, wBattleResolveStep, wDAC0, wDAC1
; points at: wBattleHP, wBattleSlotOut, wD94F, wBattleTargetChoice
ActionEffect_ActionB0:: ; heuristic: target of a pointer table; C0
Func_036_7A18:: ; address name
    ld a, [wC58A]
    or a, a
    jp nz, Jump_036_7CD3
    ld a, [wBattleActor]
    cp a, $04
    jp nc, Jump_036_7CD3
    ld a, [wBattleTarget]
    cp a, $04
    jr c, Jump_036_7A7A
    ld a, [wBattleTarget]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank36
    xor a, a
    ld [hl+], a
    ld [hl], a
    ld a, [wBattleTarget]
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld [hl], $FF
    ld a, [wBattleTarget]
    and a, $03
    ld hl, wD94F
    ld b, a
    add a, a
    add a, b
    add_a_to_hl
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    farcall Func_032_5AB3
    ld a, [wBattleActionId]
    cp a, $B2
    ld d, $8F
    jr z, Jump_036_7A85
    ld d, $D8
    farcall ShowBattleText
    ld a, $82
    call QueueSoundEffect
    jp Jump_036_7CD3

Jump_036_7A7A::
    ld a, [wBattleActionId]
    cp a, $B2
    ld d, $8F
    jr z, Jump_036_7A85
    ld d, $5C

Jump_036_7A85::
    farcall ShowBattleText
    jp Jump_036_7CD3

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $B4; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wDAD1, wDABD
; writes: wBattleTarget, wDAD1, wBattleSubPhase, wBattleResolveStep, wDAC0, wDAC1
; points at: wD80D, wBattleTargetChoice
ActionEffect_ActionB4:: ; heuristic: target of a pointer table; C0
Func_036_7A8E:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03

Jump_036_7A96::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_036_7AA5
    ld a, c
    ld hl, wD80D
    call AddAx9ToHL
    set 3, [hl]

Jump_036_7AA5::
    inc c
    dec b
    jr nz, Jump_036_7A96
    jp Jump_036_7CD3

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $B5; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1, wDAC3
; points at: wBattleStatus
ActionEffect_ActionB5:: ; heuristic: target of a pointer table; C0
Func_036_7AAC:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    and a, $8C
    jr nz, Jump_036_7ACD
    ld a, [hl]
    or a, $8C
    ld [hl], a
    call TargetOnLocalSide_Bank36
    ld l, $73
    jr nc, Jump_036_7AC7
    ld l, $74

Jump_036_7AC7::
    ld bc, $4090
    jp ClearDamageAndStoreWDAC0_Bank36

Jump_036_7ACD::
    ld h, $D4
    ld bc, $0080
    jp Jump_036_7CBC

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $B6; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wDAD1, wBattleActor, wDABD
; writes: wDAC2, wDAC0, wDAC1, wBattleTarget, wDAD1, wBattleSubPhase, wBattleResolveStep
; points at: wBattleMP, wBattleTargetChoice
ActionEffect_ActionB6:: ; heuristic: target of a pointer table; C0
Func_036_7AD5:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleMP
    call AddDoubleAToHL_Bank36
    ld a, [hl+]
    or a, [hl]
    jp z, Jump_036_7CD3
    xor a, a
    ld [hl-], a
    ld [hl], a
    ld l, $DF
    ld bc, $4090
    jp Jump_036_7CA3
    db $CD, $98, $60, $C3, $85, $7C

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $BA; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wDAD1, wBattleActor, wDABD
; writes: wDAC2, wDAC0, wDAC1, wBattleTarget, wDAD1, wBattleSubPhase, wBattleResolveStep
; points at: wBattleTargetChoice
ActionEffect_ActionBA:: ; heuristic: target of a pointer table; C0
Func_036_7AF4:: ; address name
    call Func_036_7D5B
    bit 0, [hl]
    jp nz, Jump_036_7CD3
    set 0, [hl]
    call Func_036_7D65
    ld l, $78
    ld bc, $0098
    jp Jump_036_7CA3

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $BC; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wDAD1, wBattleActor, wDABD
; writes: wDAC2, wDAC0, wDAC1, wBattleTarget, wDAD1, wBattleSubPhase, wBattleResolveStep
; points at: wBattleMP, wBattleMaxMP, wBattleTargetChoice
ActionEffect_ActionBC:: ; heuristic: target of a pointer table; C0
Func_036_7B09:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleMP
    call AddDoubleAToHL_Bank36
    push hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld a, [wBattleTarget]
    ld hl, wBattleMaxMP
    call AddDoubleAToHL_Bank36
    deref_hl
    call CompareHLToBC
    pop bc
    jp z, Jump_036_7CD3
    ld a, l
    ld [bc], a
    inc bc
    ld a, h
    ld [bc], a
    ld l, $C3
    ld bc, $4090
    jp Jump_036_7CA3

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $BD; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1
; points at: wBattleHP
ActionEffect_ActionBD:: ; heuristic: target of a pointer table; C0
Func_036_7B36:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank36
    ld c, l
    ld b, h
    ld a, [hl+]
    cp a, $01
    jr nz, Jump_036_7B5C
    ld a, [hl]
    or a, a
    jr nz, Jump_036_7B5C
    ld hl, $0001
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    ld l, $35
    ld bc, vTiles1 + $A8
    jr Jump_036_7B68

Jump_036_7B5C::
    ld a, $01
    ld [bc], a
    inc bc
    ld a, $00
    ld [bc], a
    ld l, $38
    ld bc, $4090

Jump_036_7B68::
    jp Jump_036_7CA3

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $C0; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wC5E7
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: wD136
ActionEffect_ActionC0:: ; heuristic: target of a pointer table; C0
Func_036_7B6B:: ; address name
    call AdvanceRandom
    ld a, [wC5E7]
    cp a, $40
    jr c, Jump_036_7B81
    call ComputeAttackDamage
    ld hl, wD136
    ld bc, vTiles0 + $A8
    jp Jump_036_7C8B

Jump_036_7B81::
    ld h, $D1
    ld bc, $0888
    jp Jump_036_7CBC

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $C1; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wC5E7
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: wD035
ActionEffect_ActionC1:: ; heuristic: target of a pointer table; C0
Func_036_7B89:: ; address name
    call AdvanceRandom
    ld a, [wC5E7]
    cp a, $C0
    jr c, Jump_036_7B99
    call ComputeAttackDamage
    jp ResolveStepComputeDamage_Sub02

Jump_036_7B99::
    ld h, $D0
    ld bc, $0888
    jp Jump_036_7CBC

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $C2; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
ActionEffect_ActionC2:: ; heuristic: target of a pointer table; C0
Func_036_7BA1:: ; address name
    call ActionEffect_Action00
    ret
    db $C3, $D3, $7C

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $C5; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wDAD1, wDABD
; writes: wBattleTarget, wDAD1, wBattleSubPhase, wBattleResolveStep, wDAC0, wDAC1
; points at: wD80F, wBattleTargetChoice
ActionEffect_ActionC5:: ; heuristic: target of a pointer table; C0
Func_036_7BA8:: ; address name
    ld a, [wBattleActor]
    ld hl, wD80F
    call AddAx9ToHL
    set 2, [hl]
    jp Jump_036_7CD3

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $C6, $C7; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; writes: wDAC2, wDAC0, wDAC1
; points at: wBattleStatus
ActionEffect_ActionC6:: ; heuristic: target of a pointer table; C0
Func_036_7BB6:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus
    call AddAx9ToHL
    set 6, [hl]
    ld l, $76
    ld bc, $4090
    jp Jump_036_7CA3

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $C8; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wDAD1, wBattleActor, wDABD
; writes: wBattleTarget, wDAD1, wBattleSubPhase, wBattleResolveStep, wDAC0, wDAC1
; points at: wBattleSlotOut, wD94F, wBattleTargetChoice
ActionEffect_ActionC8:: ; heuristic: target of a pointer table; C0
Func_036_7BC9:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld [hl], $FF
    call TargetOnLocalSide_Bank36
    jr c, Jump_036_7BF5
    ld a, [wBattleTarget]
    and a, $03
    ld hl, wD94F
    ld b, a
    add a, a
    add a, b
    add_a_to_hl
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    farcall Func_032_5AB3

Jump_036_7BF5::
    jp Jump_036_7CD3

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $C9, $CA; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; writes: wBattleDamageLo, wD873, wDAC2, wDAC3, wDAC0, wDAC1
; points at: wD80F, sAF36
ActionEffect_ActionC9:: ; heuristic: target of a pointer table; C0
Func_036_7BF8:: ; address name
    ld a, [wBattleActor]
    ld hl, wD80F
    call AddAx9ToHL
    ld a, [hl]
    and a, $3F
    ld [hl+], a
    ld a, [hl]
    and a, $F3
    ld [hl], a
    ld a, [wBattleActor]
    call GetBattleHP
    ld a, $0A
    call DivideHLByA
    ld a, h
    or a, l
    jr nz, Jump_036_7C1B
    ld hl, $0001

Jump_036_7C1B::
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    ld hl, sAF36
    ld bc, vTiles0 + $A8
    jp Jump_036_7C8B

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $BF, $CB; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; writes: wBattleDamageLo, wD873, wDAC2, wDAC3, wDAC0, wDAC1
; points at: wD80F, wBattleStatus, sAFAF, sAF36
ActionEffect_ActionBF:: ; heuristic: target of a pointer table; C0
Func_036_7C2C:: ; address name
    ld a, [wBattleActor]
    ld hl, wD80F
    call AddAx9ToHL
    ld a, [hl]
    and a, $3F
    ld [hl+], a
    ld a, [hl]
    and a, $F3
    ld [hl], a
    ld a, [wBattleActor]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    and a, $0C
    jr nz, ActionEffect_ActionC9
    ld hl, $0000
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    ld hl, sAFAF
    ld bc, $0080
    jp Jump_036_7C8B

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $CC; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wBattleDamageLo, wD873
; writes: wBattleDamageLo, wD873, wDAC2, wDAC3, wDAC0, wDAC1
; points at: wD810, wD035
ActionEffect_ActionCC:: ; heuristic: target of a pointer table; C0
Func_036_7C5F:: ; address name
    ld a, [wBattleActor]
    ld hl, wD810
    call AddAx9ToHL
    jp Jump_036_730E

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $CD; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wC5E7
; writes: wBattleTarget, wBattleDamageLo, wD873, wDAC2, wDAC3, wDAC0, wDAC1
; points at: wD80F, wBattleStatus, wD0AD
ActionEffect_ActionCD:: ; heuristic: target of a pointer table; C0
Func_036_7C6B:: ; address name
    ld a, [wBattleActor]
    ld hl, wD80F
    call AddAx9ToHL
    jp Jump_036_775E

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $CE; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wDABA, wC5E7, wBattleTarget, wDAD1, wBattleActor, wDABD
; writes: wBattleSubPhase, wBattleResolveStep, wBattleTarget, wDAD1, wDAC0, wDAC1
; points at: wBattleTargetChoice
ActionEffect_ActionCE:: ; heuristic: target of a pointer table; C0
Func_036_7C77:: ; address name
    jp Jump_036_7966

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $CF; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wC96F
; writes: wBattleSubPhase, wBattleResolveStep
ActionEffect_ActionCF:: ; heuristic: target of a pointer table; C0
Func_036_7C7A:: ; address name
    jp Jump_036_79CF

Jump_036_7C7D::
    ld hl, sB535
    ld bc, vTiles0 + $A8
    jr Jump_036_7C8B

; only called from ResolveStepComputeDamage (E-0047)
; 1 call site from 1 routine (e.g. ResolveStepComputeDamage)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: wD035
ResolveStepComputeDamage_Sub02::
Func_036_7C85:: ; address name
    ld hl, wD035
    ld bc, vTiles1 + $A8

Jump_036_7C8B::
    ld a, l
    ld [wDAC2], a
    ld a, h
    ld [wDAC3], a
    ld a, c
    ld [wDAC0], a
    ld a, b
    ld [wDAC1], a
    ret

; clears wBattleDamageLo/wD873 (the damage word), then wDAC2 = L, wDAC0 = C, wDAC1 = B (E-0073)
; 2 call sites from 2 routines (e.g. ActionEffect_Transform, ActionEffect_NumbOff)
; writes: wBattleDamageLo, wD873, wDAC2, wDAC0, wDAC1
ClearDamageAndStoreWDAC0_Bank36::
Func_036_7C9C:: ; address name
    xor a, a
    ld [wBattleDamageLo], a
    ld [wD873], a

Jump_036_7CA3::
    ld a, l
    ld [wDAC2], a
    ld a, c
    ld [wDAC0], a
    ld a, b
    ld [wDAC1], a
    ret

Jump_036_7CB0::
    ld h, $CC
    ld bc, $0080
    jr Jump_036_7CBC

Jump_036_7CB7::
    ld h, $B5
    ld bc, $0080

Jump_036_7CBC::
    ld a, h
    ld [wDAC3], a

Jump_036_7CC0::
    ld a, c
    ld [wDAC0], a
    ld a, b
    ld [wDAC1], a
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wBattleSubPhase, wBattleResolveStep
Func_036_7CC9:: ; heuristic: follows a terminator; C0
    ld a, $02
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    ret

Jump_036_7CD3::
    ld a, [wDAD1]
    cp a, $FF
    jr z, Jump_036_7CF3
    push hl
    ld [wBattleTarget], a
    push af
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    pop af
    ld [hl], a
    ld a, $FF
    ld [wDAD1], a
    pop hl

Jump_036_7CF3::
    ld a, [wDABD]
    or a, a
    jr nz, Jump_036_7D0D
    ld a, $03
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wBattleSubPhase, wBattleResolveStep
Func_036_7D03:: ; heuristic: follows a terminator; C0
    ld a, $07
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    ret

Jump_036_7D0D::
    ld bc, $0000
    jp Jump_036_7CC0

; 2 call sites from 2 routines (e.g. ActionEffect_FrigidAir, ActionEffect_FireAir)
; reads: wBattleTarget, wBattleDamageLo, wD873
; writes: wBattleDamageLo, wD873
; points at: wD80E
Func_036_7D13:: ; heuristic: follows a terminator; C0
    ld a, [wBattleTarget]
    ld hl, wD80E
    call AddAx9ToHL
    bit 2, [hl]
    ret z
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wD873]
    ld h, a
    call ShiftHLRight1
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    ret

; the same 18 bytes as ClearDamageAndReadTargetStatus0 (3B:4F03)
; 6 call sites from 6 routines (e.g. ActionEffect_ActionDB, ActionEffect_ActionDA, ActionEffect_CurseOff, ActionEffect_NumbOff, ...)
; reads: wBattleTarget
; writes: wBattleDamageLo, wD873
; points at: wBattleStatus
ClearDamageAndReadTargetStatus0_Bank36:: ; heuristic: follows a terminator; C0
Func_036_7D33:: ; address name
    xor a, a
    ld [wBattleDamageLo], a
    ld [wD873], a
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    ret

; 4 call sites from 3 routines (e.g. ActionEffect_ActionDD, ActionEffect_Upper, ActionEffect_Speed)
; points at: wD812
Func_036_7D45:: ; heuristic: follows a terminator; C0
    push hl
    ld hl, wD812
    call AddAx9ToHL
    set 6, [hl]
    pop hl
    ret

; 3 call sites from 3 routines (e.g. ResolveStepDamageMessage_Sub04_Sub01, ActionEffect_LushLicks, ActionEffect_UltraDown_Sub02)
; points at: wD812
Func_036_7D50::
    push hl
    ld hl, wD812
    call AddAx9ToHL
    set 7, [hl]
    pop hl
    ret

; 11 call sites from 6 routines (e.g. ActionEffect_ActionBA, ActionEffect_WarCry, ActionEffect_Ahhh, ActionEffect_LegSweep, ...)
; reads: wBattleTarget
; points at: wD80F
Func_036_7D5B:: ; heuristic: follows a terminator; C0
    ld a, [wBattleTarget]
    ld hl, wD80F
    call AddAx9ToHL
    ret

; 6 call sites from 6 routines (e.g. ActionEffect_ActionBA, ActionEffect_WarCry, ActionEffect_Ahhh, ActionEffect_LegSweep, ...)
; reads: wBattleTarget
; points at: wD811
Func_036_7D65:: ; heuristic: follows a terminator; C0
    ld a, [wBattleTarget]
    ld hl, wD811
    call AddAx9ToHL
    ld a, [hl]
    and a, $F3
    ld [hl], a
    inc hl
    inc hl
    ld a, [hl]
    and a, $F8
    ld [hl], a
    ret

; only called from ActionEffect_Vivify (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Vivify)
; reads: wBattleTarget
; points at: wBattleSlotOut, wBattleStatus, wDA5B
ActionEffect_Vivify_Sub01:: ; heuristic: follows a terminator; C0
Func_036_7D79:: ; address name
    ld a, [wBattleTarget]
    ld b, a
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld [hl], $00
    ld a, b
    ld hl, wBattleStatus
    call AddAx9ToHL
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ld a, [wBattleTarget]
    ld hl, wDA5B
    add_a_to_hl
    ld [hl], $03
    ret

; no direct call (reached through a table, a jump or a vector)
; points at: wD895
Func_036_7DA6:: ; heuristic: follows a terminator; C0
    ld hl, wD895
    ld b, $08
    ld d, $00

Jump_036_7DAD::
    bit 0, d
    jr nz, Jump_036_7DB7
    ld a, [hl]
    cp a, c
    jr nz, Jump_036_7DC4
    ld d, $01

Jump_036_7DB7::
    inc hl
    ld a, [hl]
    ld [hl], $FF
    dec hl
    ld [hl], a
    inc hl
    dec b
    jr nz, Jump_036_7DAD
    ld [hl], $FF
    ret

Jump_036_7DC4::
    inc hl
    dec b
    jr nz, Jump_036_7DAD
    ret

; 1 call site from 1 routine (e.g. Func_039_6E27)
; reads: wBattleActionId
Func_036_7DC9:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActionId]
    or a, a
    jr z, Jump_036_7DD1
    sub a, $47

Jump_036_7DD1::
    ld hl, $7DDE
    add a, a
    add_a_to_hl
    call JumpToWordAtHL
    ret
    db $13, $50, $C5, $58, $2E, $59, $93, $59, $52, $53, $B4, $60, $B4, $60, $CF, $5D
    db $CF, $5D, $22, $55, $33, $55, $44, $55, $55, $55, $66, $55, $71, $55, $7C, $55
    db $87, $55, $92, $55, $9D, $55, $A8, $55, $B3, $55, $BE, $55, $C9, $55, $D4
    dw Func_000_1355
    dw Func_000_1350
    dw Func_000_1350
    dw Func_036_7850
    db $72, $0B, $5E, $0B, $5E, $13, $50, $13, $50, $6C, $5A, $13, $50, $E0, $72, $13
    db $50, $13, $50, $13, $50, $E0, $72, $13, $50

; A = battle slot: HL = the word for that slot in the array at wD8FF (Func_036_7E5B)
; 4 call sites from 4 routines (e.g. ResolveStepComputeDamage, ComputeBasicDamage, ActionEffect_Massacre, ActionEffect_EvilSlash)
; points at: wBattleATK
GetBattleATK::
Func_036_7E2E:: ; address name
    ld hl, wBattleATK
    jr ReadBattleWordFromArray

; A = battle slot: HL = the word for that slot in the array at wD90F (Func_036_7E5B)
; 2 call sites from 2 routines (e.g. Func_036_6521, ActionEffect_UltraDown_Sub02_Sub01)
; points at: wBattleDEF
GetBattleDEF::
Func_036_7E33:: ; address name
    ld hl, wBattleDEF
    jr ReadBattleWordFromArray

; A = battle slot: HL = the word for that slot in the array at wBattleMaxHP (Func_036_7E5B)
; 2 call sites from 2 routines (e.g. Func_036_5223, ActionEffect_Geyser)
; points at: wBattleMaxHP
GetBattleMaxHP::
Func_036_7E38:: ; address name
    ld hl, wBattleMaxHP
    jr ReadBattleWordFromArray

; A = battle slot: HL = the word for that slot in the array at wBattleMaxMP (Func_036_7E5B)
; 2 call sites from 2 routines (e.g. ActionEffect_RobMagic_Sub02_Sub01, ActionEffect_MPass_Sub01)
; points at: wBattleMaxMP
GetBattleMaxMP::
Func_036_7E3D:: ; address name
    ld hl, wBattleMaxMP
    jr ReadBattleWordFromArray

; A = battle slot: HL = the word for that slot in the array at wBattleHP (Func_036_7E5B)
; 6 call sites from 5 routines (e.g. Func_036_4A38_Case01, Func_036_5A7A, Func_036_5A98, ActionEffect_ActionC9, ...)
; points at: wBattleHP
GetBattleHP::
Func_036_7E42:: ; address name
    ld hl, wBattleHP
    jr ReadBattleWordFromArray

; A = battle slot: HL = the word for that slot in the array at wBattleMP (Func_036_7E5B)
; 3 call sites from 3 routines (e.g. Func_036_4A38_Case01, ActionEffect_RobMagic_Sub02_Sub01, ActionEffect_RobMagic)
; points at: wBattleMP
GetBattleMP::
Func_036_7E47:: ; address name
    ld hl, wBattleMP
    jr ReadBattleWordFromArray
    db $21, $1F, $D9, $18, $0A, $21, $53, $DA, $85, $6F, $30, $01, $24, $7E, $C9

; HL = array base, A = slot: HL = the 16-bit word at HL + 2 * A
; 1 call site from 1 routine (e.g. ResolveStepEffectChecks)
ReadBattleWordFromArray::
Func_036_7E5B:: ; address name
    add a, a
    add_a_to_hl
    deref_hl
    ret

; HL += 2 * A (A is doubled in 8 bits first, so it wraps above $7F); clobbers A (the same 7 bytes appear in 11 banks)
; 56 call sites from 31 routines (e.g. ResolveStepDamageMessage_Sub04_Sub01_Sub01, ResolveStepComputeDamage, ResolveStepChanceRoll, Func_036_42D3, ...)
AddDoubleAToHL_Bank36::
Func_036_7E65:: ; address name
    add a, a
    add_a_to_hl
    ret

; carry set when wBattleActor < 4 (slots 0-3); when wC58A = 1 and wC57F bit 1 is set the test is reversed (carry set when wBattleActor >= 4). Which side is local is inferred from the reversal, not checked (E-0064) (the same 27 bytes appear in 11 banks)
; 5 call sites from 4 routines (e.g. ResolveStepDamageMessage_Sub04, ResolveStepDamageMessage_Sub03, ResolveStepChanceRoll, ResolveStepEffectChecks_Sub03)
; reads: wC58A, wC57F, wBattleActor
ActorOnLocalSide_Bank36::
Func_036_7E6C:: ; address name
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_036_7E81
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_036_7E81
    ld a, [wBattleActor]
    cp a, $04
    ccf
    ret

Jump_036_7E81::
    ld a, [wBattleActor]
    cp a, $04
    ret

; carry set when wBattleTarget < 4 (slots 0-3); when wC58A = 1 and wC57F bit 1 is set the test is reversed (carry set when wBattleTarget >= 4) (E-0064) (the same 27 bytes appear in 11 banks)
; 6 call sites from 6 routines (e.g. ResolveStepDamageMessage_Sub03, RunBattleResolveStep_Table2_Case01, RunBattleResolveStep_Table2_Case00_Sub03, ActionEffect_Vivify, ...)
; reads: wC58A, wC57F, wBattleTarget
TargetOnLocalSide_Bank36::
Func_036_7E87:: ; address name
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_036_7E9C
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_036_7E9C
    ld a, [wBattleTarget]
    cp a, $04
    ccf
    ret

Jump_036_7E9C::
    ld a, [wBattleTarget]
    cp a, $04
    ret
    db $7A, $21, $B7, $7E, $85, $6F, $30, $01, $24, $56, $7B, $21, $0C, $D8, $CD, $25
    db $3F, $7A, $A6, $77, $C9, $DF, $FE, $00, $FD, $73, $EF, $BF

; Sets bit 0 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 4 banks)
; 3 call sites from 3 routines (e.g. Func_036_4A38_Case01, ActionEffect_BeDragon_Sub02, ActionEffect_Transform_Sub01)
; points at: wD095
SetBit0OfWD095Indexed_Bank36::
Func_036_7EBE:: ; address name
    push hl
    ld hl, wD095
    add_a_to_hl
    set 0, [hl]
    pop hl
    ret

; Sets bit 1 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 4 banks)
; 5 call sites from 4 routines (e.g. ResolveStepDamageMessage, Func_036_4A38_Case01, ActionEffect_BeDragon_Sub02, ActionEffect_Transform_Sub01)
; points at: wD095
SetBit1OfWD095Indexed_Bank36::
Func_036_7ECB:: ; address name
    push hl
    ld hl, wD095
    add_a_to_hl
    set 1, [hl]
    pop hl
    ret

; Sets bit 2 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 4 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wD095
SetBit2OfWD095Indexed_Bank36:: ; heuristic: follows a terminator; C0
Func_036_7ED8:: ; address name
    push hl
    ld hl, wD095
    add_a_to_hl
    set 2, [hl]
    pop hl
    ret

; A = slot 0-7: returns A = 9 * g(wD968[A]) + 3 * g(wD970[A]) + g(wD978[A]) with g(v) = 0 for v >= $C0, 1 for v >= $40, else 2 (the same index PersonalityIndexOfRecord builds from a save record; E-0031); HL and BC are kept (the same 87 bytes appear in 7 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wSlotPersonalityHi, wSlotPersonalityMid, wSlotPersonalityLo
PersonalityIndexOfSlot_Bank36:: ; heuristic: follows a terminator; C0
Func_036_7EE5:: ; address name
    push hl
    push bc
    ld c, a
    ld b, $00
    ld hl, wSlotPersonalityHi
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_036_7F01
    ld l, $09
    cp a, $40
    jr nc, Jump_036_7F01
    ld l, $12

Jump_036_7F01::
    ld a, l
    add a, b
    ld b, a
    ld a, c
    ld hl, wSlotPersonalityMid
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_036_7F1C
    ld l, $03
    cp a, $40
    jr nc, Jump_036_7F1C
    ld l, $06

Jump_036_7F1C::
    ld a, l
    add a, b
    ld b, a
    ld a, c
    ld hl, wSlotPersonalityLo
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_036_7F37
    ld l, $01
    cp a, $40
    jr nc, Jump_036_7F37
    ld l, $02

Jump_036_7F37::
    ld a, l
    add a, b
    pop bc
    pop hl
    ret

; A = slot: carry set when CheckSlotStatusBlock sets it, or when status byte 3 & $C0 or byte 4 & $0C is set (wD80F + 9 * A); otherwise carry clear; A, BC, HL kept (E-0067) (the same 31 bytes appear in 7 banks)
; 5 call sites from 5 routines (e.g. ResolveStepFlagBit7Effect, ResolveStepBegin, RunBattleResolveStep_Table2_Case00, Func_036_42D3, ...)
; points at: wD80F
CheckSlotStatusBlockWide_Bank36::
Func_036_7F3C:: ; address name
    call CheckSlotStatusBlock
    ret c
    push hl
    push bc
    ld c, a
    ld hl, wD80F
    call AddAx9ToHL
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_036_7F56
    ld a, [hl]
    and a, $0C
    jr nz, Jump_036_7F56
    xor a, a
    jr Jump_036_7F57

Jump_036_7F56::
    scf

Jump_036_7F57::
    ld a, c
    pop bc
    pop hl
    ret

; A = slot: with HL = wD80F + 9 * A (status byte 3 of wBattleStatus), A = byte 3 & $C0, or byte 4 & $0C when that is zero; Z set when both are clear; HL kept (E-0067) (the same 17 bytes appear in 8 banks)
; 2 call sites from 2 routines (e.g. RunBattleResolveStep_Table2_Case00_Sub04, RunBattleResolveStep_Table2_Case00_Sub01)
; points at: wD80F
SlotHasStatus3Or4Bits_Bank36::
Func_036_7F5B:: ; address name
    push hl
    ld hl, wD80F
    call AddAx9ToHL
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_036_7F6A
    ld a, [hl]
    and a, $0C

Jump_036_7F6A::
    pop hl
    ret
    ds $94, $00
