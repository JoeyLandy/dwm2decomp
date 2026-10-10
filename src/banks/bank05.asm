SECTION "Bank 05", ROMX[$4000], BANK[$05]
    db $05

; A = battle slot: HL = the word for that slot at wBattleATK; A = its low byte (E-0064)
; 12 call sites from 11 routines (e.g. Func_005_6985, Func_005_544F, Func_005_50E3, Func_005_65C1, ...)
; points at: wBattleATK
GetBattleATK_Bank05:: ; heuristic: follows a terminator; C0
Func_005_4001:: ; address name
    ld hl, wBattleATK
    jr Jump_005_402E

; A = battle slot: HL = the word for that slot at wBattleDEF; A = its low byte (E-0064)
; 18 call sites from 15 routines (e.g. Func_005_443B, Func_005_6B20, Func_005_6985, Func_005_6CC2, ...)
; points at: wBattleDEF
GetBattleDEF_Bank05::
Func_005_4006:: ; address name
    ld hl, wBattleDEF
    jr Jump_005_402E

; A = battle slot: HL = the word for that slot at wBattleMaxHP; A = its low byte (E-0064)
; 19 call sites from 14 routines (e.g. Func_005_64DF, Func_005_5317, Func_005_6B9E, Func_005_6556, ...)
; points at: wBattleMaxHP
GetBattleMaxHP_Bank05::
Func_005_400B:: ; address name
    ld hl, wBattleMaxHP
    jr Jump_005_402E

; A = battle slot: HL = the word for that slot at wBattleMaxMP; A = its low byte (E-0064)
; 12 call sites from 7 routines (e.g. Func_005_558B, Func_005_544F, Func_005_6FFD, Func_005_6741, ...)
; points at: wBattleMaxMP
GetBattleMaxMP_Bank05::
Func_005_4010:: ; address name
    ld hl, wBattleMaxMP
    jr Jump_005_402E

; A = battle slot: HL = the word for that slot at wBattleHP; A = its low byte (E-0064)
; 25 call sites from 21 routines (e.g. Func_005_6494, Func_005_4C5D, Func_005_64DF, Func_005_5317, ...)
; points at: wBattleHP
GetBattleHP_Bank05::
Func_005_4015:: ; address name
    ld hl, wBattleHP
    jr Jump_005_402E

; A = battle slot: HL = the word for that slot at wBattleMP; A = its low byte (E-0064)
; 9 call sites from 9 routines (e.g. Func_005_5500, Func_005_558B, Func_005_6FFD, Func_005_62E1, ...)
; points at: wBattleMP
GetBattleMP_Bank05::
Func_005_401A:: ; address name
    ld hl, wBattleMP
    jr Jump_005_402E

; A = battle slot: HL = the word for that slot at wBattleAGL; A = its low byte (E-0064)
; 10 call sites from 8 routines (e.g. Func_005_4461, Func_005_6B5F, Func_005_6DFF, Func_005_4B97, ...)
; points at: wBattleAGL
GetBattleAGL_Bank05::
Func_005_401F:: ; address name
    ld hl, wBattleAGL
    jr Jump_005_402E

; A = the byte at wDA53 + A; clobbers HL (the same 10 bytes appear in 4 banks)
; 6 call sites from 5 routines (e.g. Func_005_6556, Func_005_667F, Func_005_67B2, Func_005_6820, ...)
; points at: wDA53
ReadWDA53Indexed_Bank05_4024:: ; heuristic: follows a terminator; C0
Func_005_4024:: ; address name
    ld hl, wDA53
    add_a_to_hl
    ld a, [hl]
    ret

Jump_005_402E::
    add a, a
    add_a_to_hl
    deref_hl
    ret

; HL += 2 * A (A is doubled in 8 bits first, so it wraps above $7F); clobbers A (the same 7 bytes appear in 11 banks)
; no direct call (reached through a table, a jump or a vector)
AddDoubleAToHL_Bank05:: ; heuristic: follows a terminator; C0
Func_005_4038:: ; address name
    add a, a
    add_a_to_hl
    ret

; carry set when wBattleActor < 4 (slots 0-3); when wC58A = 1 and wC57F bit 1 is set the test is reversed (carry set when wBattleActor >= 4). Which side is local is inferred from the reversal, not checked (E-0064) (the same 27 bytes appear in 11 banks)
; no direct call (reached through a table, a jump or a vector)
; reads: wC58A, wC57F, wBattleActor
ActorOnLocalSide_Bank05:: ; heuristic: follows a terminator; C0
Func_005_403F:: ; address name
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_005_4054
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_005_4054
    ld a, [wBattleActor]
    cp a, $04
    ccf
    ret

Jump_005_4054::
    ld a, [wBattleActor]
    cp a, $04
    ret

; carry set when wBattleTarget < 4 (slots 0-3); when wC58A = 1 and wC57F bit 1 is set the test is reversed (carry set when wBattleTarget >= 4) (E-0064) (the same 27 bytes appear in 11 banks)
; no direct call (reached through a table, a jump or a vector)
; reads: wC58A, wC57F, wBattleTarget
TargetOnLocalSide_Bank05:: ; heuristic: follows a terminator; C0
Func_005_405A:: ; address name
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_005_406F
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_005_406F
    ld a, [wBattleTarget]
    cp a, $04
    ccf
    ret

Jump_005_406F::
    ld a, [wBattleTarget]
    cp a, $04
    ret
    INCBIN "dwm2-cobi-us.gbc", $014075, $CA

; cost = wRecordBufferData (byte 0 of the skill record): C = $FF (can pay) when the cost is 0, when the cost is $FF and the actor's MP (wBattleMP word) is non-zero, or when MP >= cost; C = 0 otherwise. Agrees with CheckSkillMPCost that equal MP and cost is enough (E-0063)
; 35 call sites from 35 routines (e.g. Func_005_708C, Func_005_70C9, Func_005_7109, Func_005_715F, ...)
; reads: wBattleActor, wRecordBufferData
; points at: wBattleMP
ActorCanPayMPCost_Bank05::
Func_005_413F:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleMP
    add a, a
    add_a_to_hl
    ld a, [wRecordBufferData]
    or a, a
    jr z, Jump_005_4166
    cp a, $FF
    jr nz, Jump_005_415B
    ld a, [hl+]
    or a, [hl]
    jr nz, Jump_005_4166
    jr Jump_005_4163

Jump_005_415B::
    ld c, a
    ld a, [hl+]
    sub a, c
    ld a, [hl]
    sbc a, $00
    jr nc, Jump_005_4166

Jump_005_4163::
    ld c, $00
    ret

Jump_005_4166::
    ld c, $FF
    ret

; C = 0 when bit 6 of wCFF3 (skill record buffer) is set and the actor's status byte 1 (wD80D) bit 0 is set, else $FF (compare refusal code 3 of CheckSkillMPCost) (E-0071)
; 5 call sites from 5 routines (e.g. Func_005_708C, Func_005_70C9, Func_005_7109, Func_005_715F, ...)
; reads: wCFF3, wBattleActor
; points at: wD80D
SkillPassesStatus1Bit0Check::
Func_005_4169:: ; address name
    ld a, [wCFF3]
    bit 6, a
    jr z, Jump_005_4180
    ld a, [wBattleActor]
    ld hl, wD80D
    call AddAx9ToHL
    bit 0, [hl]
    jr z, Jump_005_4180
    ld c, $00
    ret

Jump_005_4180::
    ld c, $FF
    ret

; 4 call sites from 4 routines (e.g. Func_005_74F9, Func_005_7812, Func_005_7879, Func_005_7AA4)
; reads: wCFF3, wBattleActor
; points at: wD80D
Func_005_4183:: ; heuristic: follows a terminator; C0
    ld a, [wCFF3]
    bit 4, a
    jr z, Jump_005_419B
    ld a, [wBattleActor]
    ld hl, wD80D
    call AddAx9ToHL
    bit 7, [hl]
    jp z, Jump_005_419B
    ld c, $00
    ret

Jump_005_419B::
    ld c, $FF
    ret

; 5 call sites from 5 routines (e.g. Func_005_78EC, Func_005_7946, Func_005_7975, Func_005_7996, ...)
; reads: wCFF3, wBattleActor
; points at: wD80D
Func_005_419E:: ; heuristic: follows a terminator; C0
    ld a, [wCFF3]
    bit 5, a
    jr z, Jump_005_41B6
    ld a, [wBattleActor]
    ld hl, wD80D
    call AddAx9ToHL
    bit 6, [hl]
    jp z, Jump_005_41B6
    ld c, $00
    ret

Jump_005_41B6::
    ld c, $FF
    ret

; when bit 3 is set in wD80A or wD80B (either side), C = 0 if the skill wRecordBuffer is $84 or wCFF3 bit 6 is set; otherwise C = $FF (compare refusal code 4 of CheckSkillMPCost, which tests only the actor's side) (E-0071)
; 6 call sites from 6 routines (e.g. Func_005_708C, Func_005_70C9, Func_005_7109, Func_005_715F, ...)
; reads: wRecordBuffer, wCFF3
; points at: wD80A
SkillPassesSideFlagBit3Check::
Func_005_41B9:: ; address name
    ld hl, wD80A
    ld a, [hl+]
    or a, [hl]
    and a, $08
    jr z, Jump_005_41D3
    ld a, [wRecordBuffer]
    cp a, $84
    jr z, Jump_005_41D0
    ld a, [wCFF3]
    bit 6, a
    jr z, Jump_005_41D3

Jump_005_41D0::
    ld c, $00
    ret

Jump_005_41D3::
    ld c, $FF
    ret

; when bit 7 of wCFF6 (in the skill record buffer) is set and the skill wRecordBuffer is the queued action (QueuedActionMatches), C = 0; otherwise C = $FF (E-0071)
; 20 call sites from 20 routines (e.g. Func_005_708C, Func_005_70C9, Func_005_7109, Func_005_715F, ...)
; reads: wCFF6, wRecordBuffer
SkillPassesRepeatCheck::
Func_005_41D6:: ; address name
    ld a, [wCFF6]
    bit 7, a
    jr z, Jump_005_41E8
    ld a, [wRecordBuffer]
    call QueuedActionMatches
    jr nz, Jump_005_41E8
    ld c, $00
    ret

Jump_005_41E8::
    ld c, $FF
    ret

; 4 call sites from 4 routines (e.g. Func_005_708C, Func_005_70C9, Func_005_7109, Func_005_7261)
; reads: wBattleActor
; points at: wD80E
Func_005_41EB::
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld b, $03
    ld hl, wD80E
    ld e, $22
    call AnySlotLacksStatusMask
    ret

; C = $FF when one of the actor's three opposite slots is present with status byte 5 (wD811) & $C0 clear (AnySlotLacksStatusMask), else 0 (E-0071)
; 23 call sites from 23 routines (e.g. Func_005_708C, Func_005_70C9, Func_005_7109, Func_005_74D1, ...)
; reads: wBattleActor
; points at: wD811
AnyFoeLacksStatus5Bits67::
Func_005_41FD:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld b, $03
    ld hl, wD811
    ld e, $C0
    call AnySlotLacksStatusMask
    ret

; C = $FF when one of the actor's three opposite slots is present with status byte 2 (wD80E) bit 3 clear (AnySlotLacksStatusMask), else 0 (E-0071)
; 5 call sites from 5 routines (e.g. Func_005_708C, Func_005_74D1, CheckSkillUsableElseResetWDA6E, Func_005_770A, ...)
; reads: wBattleActor
; points at: wD80E
AnyFoeLacksStatus2Bit3::
Func_005_420F:: ; address name
    ld hl, wD80E
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld b, $03
    ld e, $08
    call AnySlotLacksStatusMask
    ret

; C = $FF when one of the actor's three opposite slots is present with status byte 3 (wD80F) & $C0 and byte 4 (wD810) & $0C both clear, else 0 (E-0071)
; 11 call sites from 11 routines (e.g. Func_005_7080, Func_005_7512, CheckSkillUsableElseResetWDA6E, Func_005_774F, ...)
; reads: wBattleActor
; points at: wD80F, wD810
AnyFoeLacksStatus3And4Bits::
Func_005_4221:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_422B::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_423E
    ld a, c
    ld hl, wD80F
    call AddAx9ToHL
    ld a, [hl]
    and a, $C0
    and a, a
    jr z, Jump_005_4244

Jump_005_423E::
    inc c
    dec b
    jr nz, Jump_005_422B
    jr Jump_005_4253

Jump_005_4244::
    ld a, c
    ld hl, wD810
    call AddAx9ToHL
    ld a, [hl]
    and a, $0C
    and a, a
    jr z, Jump_005_4256
    jr Jump_005_423E

Jump_005_4253::
    ld c, $00
    ret

Jump_005_4256::
    ld c, $FF
    ret

; 4 call sites from 4 routines (e.g. Func_005_7322, Func_005_78A8, Func_005_7A6C, Func_005_7CF3)
; reads: wBattleActor
; points at: wBattleMP
Func_005_4259:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_4263::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_427C
    ld hl, wBattleMP
    ld a, c
    swap a
    add_a_to_hl
    ld a, [hl+]
    and a, a
    jr nz, Jump_005_4283
    ld a, [hl+]
    and a, a
    jr nz, Jump_005_4283

Jump_005_427C::
    inc c
    dec b
    jr nz, Jump_005_4263
    ld c, $00
    ret

Jump_005_4283::
    ld c, $FF
    ret

; 1 call site from 1 routine (e.g. Func_005_72F7)
; reads: wBattleActor, wRecordBuffer, wCFED, hFFC6
; writes: wRecordBuffer, wCFED, wD868, wD869, wD86A, wD86B
; points at: wD988, hFFC6
Func_005_4286:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    call ReadWDA53Indexed_Bank05
    cp a, $02
    jp c, Jump_005_4319
    ld a, [wRecordBuffer]
    ld l, a
    ld a, [wCFED]
    ld h, a
    push hl
    ld b, $03
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld e, a

Jump_005_42A4::
    ld a, e
    ld hl, wD988
    swap a
    add_a_to_hl
    ld a, e
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_42F4
    ld c, $00

Jump_005_42B7::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_005_42F4
    ld [wRecordBuffer], a
    xor a, a
    ld [wCFED], a
    ld a, $07
    ld [wD868], a
    ld a, $01
    ld [wD869], a
    push hl
    push bc
    push de
    ld hl, hFFC6
    ld a, l
    ld [wD86A], a
    ld a, h
    ld [wD86B], a
    farcall LoadSkillRecordPart
    pop de
    pop bc
    pop hl
    ldh a, [hFFC6]
    bit 0, a
    jr nz, Jump_005_430D
    inc c
    inc hl
    inc hl
    ld a, c
    cp a, $08
    jr c, Jump_005_42B7
    jr Jump_005_42FD

Jump_005_42F4::
    ld a, $08
    sub a, c
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_005_42FD
    inc h

Jump_005_42FD::
    inc e
    dec b
    jr nz, Jump_005_42A4
    pop hl
    ld a, l
    ld [wRecordBuffer], a
    ld a, h
    ld [wCFED], a
    ld c, $00
    ret

Jump_005_430D::
    pop hl
    ld a, l
    ld [wRecordBuffer], a
    ld a, h
    ld [wCFED], a
    ld c, $FF
    ret

Jump_005_4319::
    ld c, $01
    ret

; C = $FF when one of the actor's three opposite slots is present with status byte 0 (wBattleStatus) bit 6 clear (AnySlotLacksStatusMask), else 0 (E-0071)
; 16 call sites from 16 routines (e.g. Func_005_7109, Func_005_71BE, Func_005_72F7, Func_005_7345, ...)
; reads: wBattleActor
; points at: wBattleStatus
AnyFoeLacksStatus0Bit6:: ; heuristic: follows a terminator; C0
Func_005_431C:: ; address name
    ld hl, wBattleStatus
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld b, $03
    ld e, $40
    call AnySlotLacksStatusMask
    ret

; 4 call sites from 4 routines (e.g. Func_005_7345, Func_005_73D7, Func_005_7449, Func_005_7A6C)
; reads: wBattleActor, wRecordBuffer
; writes: wRecordBuffer
; points at: wD80D
Func_005_432E:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    call ReadWDA53Indexed_Bank05
    cp a, $02
    jr c, Jump_005_4370
    ld a, [wRecordBuffer]
    push af
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld d, $40

Jump_005_4348::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_435E
    ld a, c
    ld hl, wD80D
    call AddAx9ToHL
    bit 0, [hl]
    jr nz, Jump_005_435E
    call Func_005_6C02
    jr nz, Jump_005_4369

Jump_005_435E::
    inc c
    dec b
    jr nz, Jump_005_4348
    pop af
    ld [wRecordBuffer], a
    ld c, $00
    ret

Jump_005_4369::
    pop af
    ld [wRecordBuffer], a
    ld c, $FF
    ret

Jump_005_4370::
    ld c, $01
    ret

; 2 call sites from 2 routines (e.g. Func_005_7410, Func_005_7CF3)
; reads: wBattleActor, wRecordBuffer
; writes: wRecordBuffer
Func_005_4373:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    call ReadWDA53Indexed_Bank05
    cp a, $02
    jr c, Jump_005_43AA
    ld a, [wRecordBuffer]
    push af
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld d, $10

Jump_005_438D::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_4398
    call Func_005_6C02
    jr nz, Jump_005_43A3

Jump_005_4398::
    inc c
    dec b
    jr nz, Jump_005_438D
    pop af
    ld [wRecordBuffer], a
    ld c, $00
    ret

Jump_005_43A3::
    pop af
    ld [wRecordBuffer], a
    ld c, $FF
    ret

Jump_005_43AA::
    ld c, $01
    ret

; 1 call site from 1 routine (e.g. Func_005_7B84)
; reads: wBattleActor, wRecordBuffer
; writes: wRecordBuffer
; points at: wD80D
Func_005_43AD:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    call ReadWDA53Indexed_Bank05
    cp a, $02
    jr c, Jump_005_43EF
    ld a, [wRecordBuffer]
    push af
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld d, $20

Jump_005_43C7::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_43DD
    ld a, c
    ld hl, wD80D
    call AddAx9ToHL
    bit 6, [hl]
    jr nz, Jump_005_43DD
    call Func_005_6C02
    jr nz, Jump_005_43E8

Jump_005_43DD::
    inc c
    dec b
    jr nz, Jump_005_43C7
    pop af
    ld [wRecordBuffer], a
    ld c, $00
    ret

Jump_005_43E8::
    pop af
    ld [wRecordBuffer], a
    ld c, $FF
    ret

Jump_005_43EF::
    ld c, $01
    ret

; 11 call sites from 11 routines (e.g. Func_005_708C, Func_005_70C9, Func_005_7109, Func_005_74D1, ...)
; reads: wCFEF, wBattleActor
; points at: wDA72
Func_005_43F2::
    ld a, [wCFEF]
    or a, a
    jr z, Jump_005_4438
    dec a
    ld hl, Data_005_6F6B
    add a, a
    add_a_to_hl
    ld d, [hl]
    inc hl
    ld e, [hl]
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld hl, wDA72
    add a, a
    add a, c
    add a, a
    add a, c
    add a, d
    add a, l
    ld l, a
    jr nc, Jump_005_441C
    inc h

Jump_005_441C::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_4429
    call Func_005_6C86
    cp a, $03
    jr nz, Jump_005_4438

Jump_005_4429::
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc c
    dec b
    jr nz, Jump_005_441C
    ld c, $00
    ret

Jump_005_4438::
    ld c, $FF
    ret

; 3 call sites from 3 routines (e.g. Func_005_7786, Func_0E2_4001, Func_0E2_5F0A)
; reads: wBattleActor
Func_005_443B::
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_4445::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_4457
    call GetBattleDEF_Bank05
    ld a, h
    or a, a
    jr nz, Jump_005_445E
    ld a, l
    cp a, $02
    jr nc, Jump_005_445E

Jump_005_4457::
    inc c
    dec b
    jr nz, Jump_005_4445
    ld c, $00
    ret

Jump_005_445E::
    ld c, $FF
    ret

; 1 call site from 1 routine (e.g. Func_005_76A3)
; reads: wBattleActor
Func_005_4461:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_446B::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_447D
    call GetBattleAGL_Bank05
    ld a, h
    or a, a
    jr nz, Jump_005_4484
    ld a, l
    cp a, $02
    jr nc, Jump_005_4484

Jump_005_447D::
    inc c
    dec b
    jr nz, Jump_005_446B
    ld c, $00
    ret

Jump_005_4484::
    ld c, $FF
    ret

; 1 call site from 1 routine (e.g. Func_005_74F9)
; reads: wBattleActor
; points at: wD80E
Func_005_4487:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld hl, wD80E
    ld e, $40
    ld b, $03
    call AnySlotLacksStatusMask
    ret

; 3 call sites from 3 routines (e.g. Func_005_7370, Func_005_78CC, Func_005_7CF3)
; reads: wBattleActor
; points at: wBattleStatus
Func_005_4499:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld b, $03
    ld hl, wBattleStatus
    ld e, $10
    call AnySlotLacksStatusMask
    ret

; 1 call site from 1 routine (e.g. Func_005_7860)
; reads: wBattleActor
; points at: wBattleStatus
Func_005_44AB:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld hl, wBattleStatus
    ld e, $02
    ld b, $03
    call AnySlotLacksStatusMask
    ret

; 2 call sites from 2 routines (e.g. Func_005_763E, Func_005_7847)
; reads: wBattleActor
; points at: wBattleStatus
Func_005_44BD:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld b, $03
    ld hl, wBattleStatus
    ld e, $03
    call AnySlotLacksStatusMask
    ret

; 7 call sites from 7 routines (e.g. Func_005_7686, Func_005_72DE, Func_005_77F9, Func_005_7D5B, ...)
; reads: wBattleActor
; points at: wBattleStatus
Func_005_44CF::
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld b, $03
    ld e, $CC
    ld hl, wBattleStatus
    call AnySlotLacksStatusMask
    ret

; 1 call site from 1 routine (e.g. Func_005_7CC2)
; reads: wBattleActor, wRecordBuffer
; writes: wRecordBuffer
; points at: wD80D
Func_005_44E1:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    call ReadWDA53Indexed_Bank05
    cp a, $02
    jr c, Jump_005_4524
    ld a, [wRecordBuffer]
    push af
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld d, $08

Jump_005_44FB::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_4512
    ld a, c
    ld hl, wD80D
    call AddAx9ToHL
    ld a, [hl]
    and a, $C1
    jr nz, Jump_005_4512
    call Func_005_6C02
    jr nz, Jump_005_451D

Jump_005_4512::
    inc c
    dec b
    jr nz, Jump_005_44FB
    pop af
    ld [wRecordBuffer], a
    ld c, $00
    ret

Jump_005_451D::
    pop af
    ld [wRecordBuffer], a
    ld c, $FF
    ret

Jump_005_4524::
    ld c, $01
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wD811
Func_005_4527:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld b, $03
    ld hl, wD811
    ld e, $03
    call AnySlotLacksStatusMask
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wD811, wD80D
Func_005_4539:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_4543::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_4561
    ld a, c
    ld hl, wD811
    call AddAx9ToHL
    ld a, [hl]
    and a, $01
    jr nz, Jump_005_4561
    ld a, c
    ld hl, wD80D
    call AddAx9ToHL
    ld a, [hl]
    and a, $02
    jr z, Jump_005_4568

Jump_005_4561::
    inc c
    dec b
    jr nz, Jump_005_4543
    ld c, $00
    ret

Jump_005_4568::
    ld c, $FF
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wD811, wD80D
Func_005_456B:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_4575::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_4593
    ld a, c
    ld hl, wD811
    call AddAx9ToHL
    ld a, [hl]
    and a, $02
    jr nz, Jump_005_4593
    ld a, c
    ld hl, wD80D
    call AddAx9ToHL
    ld a, [hl]
    and a, $02
    jr z, Jump_005_459A

Jump_005_4593::
    inc c
    dec b
    jr nz, Jump_005_4575
    ld c, $00
    ret

Jump_005_459A::
    ld c, $FF
    ret

; 6 call sites from 6 routines (e.g. Func_005_72BE, Func_005_79C5, Func_005_79E5, Func_005_7C12, ...)
; reads: wBattleActor
; points at: wD811, wD80D
Func_005_459D:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_45A7::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_45C5
    ld a, c
    ld hl, wD811
    call AddAx9ToHL
    ld a, [hl]
    and a, $03
    jr nz, Jump_005_45C5
    ld a, c
    ld hl, wD80D
    call AddAx9ToHL
    ld a, [hl]
    and a, $02
    jr z, Jump_005_45CC

Jump_005_45C5::
    inc c
    dec b
    jr nz, Jump_005_45A7
    ld c, $00
    ret

Jump_005_45CC::
    ld c, $FF
    ret

; 2 call sites from 2 routines (e.g. Func_005_7345, Func_005_7449)
; reads: wBattleActor
; points at: wD80D
Func_005_45CF:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld hl, wD80D
    ld b, $03
    ld e, $01
    call AnySlotLacksStatusMask
    ret

; 3 call sites from 3 routines (e.g. Func_005_7410, Func_005_7BBE, Func_005_7CF3)
; reads: wBattleActor
; points at: wD80D
Func_005_45E1:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld hl, wD80D
    ld b, $03
    ld e, $80
    call AnySlotLacksStatusMask
    ret

; 1 call site from 1 routine (e.g. Func_005_7B84)
; reads: wBattleActor
; points at: wD80D
Func_005_45F3:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld hl, wD80D
    ld b, $03
    ld e, $40
    call AnySlotLacksStatusMask
    ret

; C = $FF when at least one of the actor's three opposite slots passes CheckSlotStatusBlock (present and none of its blocking status bits set); C = 0 when all three are absent or blocked (E-0066)
; 22 call sites from 22 routines (e.g. Func_005_7686, Func_005_7236, Func_005_727A, Func_005_7293, ...)
; reads: wBattleActor
AnyFoeNotBlocked::
Func_005_4605:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_460F::
    ld a, c
    call CheckSlotStatusBlock
    jr nc, Jump_005_461C
    inc c
    dec b
    jr nz, Jump_005_460F
    ld c, $00
    ret

Jump_005_461C::
    ld c, $FF
    ret

; 1 call site from 1 routine (e.g. Func_005_7B40)
; reads: wBattleActor
; points at: wD8A7, wD80F
Func_005_461F:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld hl, wD8A7
    add a, l
    ld l, a
    jr nc, Jump_005_4631
    inc h

Jump_005_4631::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_4659
    bit 4, [hl]
    jr nz, Jump_005_4659
    push hl
    ld a, c
    ld hl, wD80F
    call AddAx9ToHL
    ld a, [hl]
    pop hl
    and a, $C0
    and a, a
    jr nz, Jump_005_4659
    push hl
    ld a, c
    ld hl, wD80F
    call AddAx9ToHL
    ld a, [hl]
    pop hl
    and a, $0C
    and a, a
    jr z, Jump_005_4661

Jump_005_4659::
    inc hl
    inc c
    dec b
    jr nz, Jump_005_4631
    ld c, $00
    ret

Jump_005_4661::
    ld c, $FF
    ret

; 6 call sites from 6 routines (e.g. Func_005_7AD8, Func_005_7B11, Func_005_7B5C, Func_0E2_432D, ...)
; reads: wBattleActor
; points at: wD80F
Func_005_4664::
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld b, $03
    ld hl, wD80F
    ld e, $FF
    call AnySlotLacksStatusMask
    ret

; 7 call sites from 7 routines (e.g. Func_005_7109, Func_0E2_411C, Func_0E2_41E0, Func_0E2_4567, ...)
; reads: wBattleActor
; points at: wD80E
Func_005_4676::
    ld a, [wBattleActor]
    call ReadWDA53Indexed_Bank05
    cp a, $02
    jr c, Jump_005_46B1
    call Func_005_702D
    jr z, Jump_005_46AE
    cp a, $03
    jr nz, Jump_005_46AE
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_4693::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_46A5
    ld a, c
    ld hl, wD80E
    call AddAx9ToHL
    ld a, [hl]
    and a, $22
    jr nz, Jump_005_46AB

Jump_005_46A5::
    inc c
    dec b
    jr nz, Jump_005_4693
    jr Jump_005_46AE

Jump_005_46AB::
    ld c, $00
    ret

Jump_005_46AE::
    ld c, $FF
    ret

Jump_005_46B1::
    ld c, $01
    ret

; 1 call site from 1 routine (e.g. Func_0E2_4B6B)
; reads: wBattleActor
; points at: wD80E
Func_005_46B4:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    call ReadWDA53Indexed_Bank05
    cp a, $02
    jr c, Jump_005_46F0
    call Func_005_702D
    jr z, Jump_005_46ED
    cp a, $03
    jr nz, Jump_005_46ED
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_46D1::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_46E4
    ld a, c
    ld hl, wD80E
    call AddAx9ToHL
    ld a, [hl]
    and a, $40
    and a, a
    jr nz, Jump_005_46EA

Jump_005_46E4::
    inc c
    dec b
    jr nz, Jump_005_46D1
    jr Jump_005_46ED

Jump_005_46EA::
    ld c, $00
    ret

Jump_005_46ED::
    ld c, $FF
    ret

Jump_005_46F0::
    ld c, $01
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wD810
Func_005_46F3:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    ld hl, wD810
    call AddAx9ToHL
    ld a, [hl]
    and a, $03
    jr z, Jump_005_4704
    ld c, $00
    ret

Jump_005_4704::
    ld c, $FF
    ret

; C = 0 when the actor's status byte 4 (wD810 + 9 * actor) & $C0 is set, else C = $FF (E-0071)
; 17 call sites from 17 routines (e.g. Func_005_7187, Func_005_74B5, Func_005_772B, Func_005_774F, ...)
; reads: wBattleActor
; points at: wD810
ActorLacksStatus4Bits67::
Func_005_4707:: ; address name
    ld a, [wBattleActor]
    ld hl, wD810
    call AddAx9ToHL
    ld a, [hl]
    and a, $C0
    jr z, Jump_005_4718
    ld c, $00
    ret

Jump_005_4718::
    ld c, $FF
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wD80D
Func_005_471B:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    ld hl, wD80D
    call AddAx9ToHL
    bit 2, [hl]
    jr z, Jump_005_472B
    ld c, $00
    ret

Jump_005_472B::
    ld c, $FF
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wD80D
Func_005_472E:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    ld hl, wD80D
    call AddAx9ToHL
    bit 3, [hl]
    jr z, Jump_005_473E
    ld c, $00
    ret

Jump_005_473E::
    ld c, $FF
    ret

; 1 call site from 1 routine (e.g. Func_005_72F7)
; reads: wBattleActor
; points at: wD80E
Func_005_4741:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    ld hl, wD80E
    call AddAx9ToHL
    bit 0, [hl]
    jr z, Jump_005_4751
    ld c, $00
    ret

Jump_005_4751::
    ld c, $FF
    ret

; 1 call site from 1 routine (e.g. Func_005_7C82)
; reads: wBattleActor
; points at: wD80E
Func_005_4754:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    ld hl, wD80E
    call AddAx9ToHL
    bit 6, [hl]
    jr z, Jump_005_4764
    ld c, $00
    ret

Jump_005_4764::
    ld c, $FF
    ret

; 2 call sites from 2 routines (e.g. Func_005_7CA2, Func_005_7CF3)
; reads: wBattleActor
; points at: wD80E
Func_005_4767:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    ld b, $03
    ld e, $40
    ld hl, wD80E
    call AnySlotLacksStatusMask
    ret

; 11 call sites from 11 routines (e.g. Func_005_7187, Func_005_7786, Func_005_77E0, Func_0E2_4279, ...)
; reads: wBattleActor
; points at: wBattleStatus
Func_005_4777::
    ld a, [wBattleActor]
    ld e, a
    and a, $04
    ld c, a
    ld b, $03
    ld d, $00

Jump_005_4782::
    ld a, c
    cp a, e
    jr z, Jump_005_4797
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_4797
    inc d
    ld a, c
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit 6, [hl]
    jr z, Jump_005_47A2

Jump_005_4797::
    inc c
    dec b
    jr nz, Jump_005_4782
    ld a, d
    or a, a
    jr z, Jump_005_47A2
    ld c, $00
    ret

Jump_005_47A2::
    ld c, $FF
    ret

; 1 call site from 1 routine (e.g. Func_005_71DE)
; reads: wBattleActor
; points at: wBattleStatus
Func_005_47A5:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    ld b, $03
    ld hl, wBattleStatus
    ld e, $03
    call Func_005_6FBD
    ret

; 1 call site from 1 routine (e.g. Func_005_720A)
; reads: wBattleActor
; points at: wBattleStatus
Func_005_47B5:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    ld b, $03
    ld hl, wBattleStatus
    ld e, $CC
    call Func_005_6FBD
    ret

; 1 call site from 1 routine (e.g. Func_005_71F4)
; reads: wBattleActor
; points at: wBattleStatus
Func_005_47C5:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    ld b, $03
    ld hl, wBattleStatus
    ld e, $10
    call Func_005_6FBD
    ret

; 1 call site from 1 routine (e.g. Func_005_7220)
; reads: wBattleActor
; points at: wBattleStatus
Func_005_47D5:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    ld b, $03
    ld hl, wBattleStatus
    ld e, $20
    call Func_005_6FBD
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wDA76
Func_005_47E5:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04

Jump_005_47EA::
    ld c, a
    ld b, $03
    ld hl, wDA76
    call ReadByteAtHLPlus4APlus3C_Bank05

Jump_005_47F3::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_4800
    ld a, [hl]
    and a, $3C
    cp a, $3C
    jr nz, Jump_005_480F

Jump_005_4800::
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc c
    dec b
    jr nz, Jump_005_47F3
    ld c, $00
    ret

Jump_005_480F::
    ld c, $FF
    ret

; 1 call site from 1 routine (e.g. Func_005_7AA4)
; reads: wBattleActor
; points at: wDA76
Func_005_4812:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    jp Jump_005_47EA

; 1 call site from 1 routine (e.g. Func_005_7524)
Func_005_481C::
    ld e, $00
    call Func_005_6FD9
    ret

; 1 call site from 1 routine (e.g. Func_005_753A)
Func_005_4822::
    ld e, $01
    call Func_005_6FD9
    ret

; 1 call site from 1 routine (e.g. Func_005_7550)
Func_005_4828::
    ld e, $02
    call Func_005_6FD9
    ret

; 1 call site from 1 routine (e.g. Func_005_7566)
Func_005_482E::
    ld e, $03
    call Func_005_6FD9
    ret

; 1 call site from 1 routine (e.g. Func_005_757C)
Func_005_4834::
    ld e, $05
    call Func_005_6FD9
    ret

; 1 call site from 1 routine (e.g. Func_005_7592)
Func_005_483A::
    ld e, $04
    call Func_005_6FD9
    ret

; 1 call site from 1 routine (e.g. Func_005_75A8)
Func_005_4840::
    ld e, $06
    call Func_005_6FD9
    ret

; 1 call site from 1 routine (e.g. Func_005_75BE)
Func_005_4846::
    ld e, $07
    call Func_005_6FD9
    ret

; 1 call site from 1 routine (e.g. Func_005_75D4)
Func_005_484C::
    ld e, $08
    call Func_005_6FD9
    ret

; 1 call site from 1 routine (e.g. Func_005_75EA)
Func_005_4852::
    ld e, $09
    call Func_005_6FD9
    ret

; 1 call site from 1 routine (e.g. Func_005_7600)
; reads: wBattleActor
; points at: wD8A7
Func_005_4858:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_4862::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_4874
    ld hl, wD8A7
    add_a_to_hl
    bit 0, [hl]
    jr nz, Jump_005_487A

Jump_005_4874::
    inc c
    dec b
    jr nz, Jump_005_4862
    jr Jump_005_487D

Jump_005_487A::
    ld c, $00
    ret

Jump_005_487D::
    ld c, $FF
    ret

; 1 call site from 1 routine (e.g. Func_005_7A3E)
; reads: wBattleActor
; points at: wDA74, wD80D
Func_005_4880:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_488A::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_48BF
    ld hl, wDA74
    call ReadByteAtHLPlus4APlus3C_Bank05
    and a, $30
    cp a, $30
    jr z, Jump_005_48BF
    ld a, c
    call GetBattleDEF_Bank05
    ld a, h
    jr nz, Jump_005_48C6
    ld a, l
    cp a, $02
    jr nc, Jump_005_48C6
    ld a, c
    call GetBattleAGL_Bank05
    ld a, h
    jr nz, Jump_005_48C6
    ld a, l
    cp a, $02
    jr nc, Jump_005_48C6
    ld a, c
    ld hl, wD80D
    call AddAx9ToHL
    bit 1, [hl]
    jr z, Jump_005_48C6

Jump_005_48BF::
    inc c
    dec b
    jr nz, Jump_005_488A
    ld c, $00
    ret

Jump_005_48C6::
    ld c, $FF
    ret

; 3 call sites from 3 routines (e.g. Func_005_72BE, Func_005_79C5, Func_005_79E5)
; reads: wBattleActor
; points at: wD80D, wDA73
Func_005_48C9::
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_48D3::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_48FA
    ld a, c
    ld hl, wD80D
    call AddAx9ToHL
    bit 1, [hl]
    jr nz, Jump_005_48FA
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    and a, $03
    jr nz, Jump_005_48FA
    ld a, c
    ld hl, wDA73
    call ReadByteAtHLPlus4APlus3C_Bank05
    and a, $03
    cp a, $03
    jr nz, Jump_005_4901

Jump_005_48FA::
    inc c
    dec b
    jr nz, Jump_005_48D3
    ld c, $00
    ret

Jump_005_4901::
    ld c, $FF
    ret

; 1 call site from 1 routine (e.g. Func_005_7345)
; reads: wRecordBuffer, wBattleActor
; writes: wRecordBuffer
; points at: wD80D, wDA74
Func_005_4904:: ; heuristic: follows a terminator; C0
    ld a, [wRecordBuffer]
    push af
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld d, $40

Jump_005_4914::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_4937
    ld a, c
    ld hl, wD80D
    call AddAx9ToHL
    bit 0, [hl]
    jr nz, Jump_005_4937
    call Func_005_6C02
    jr z, Jump_005_4937
    ld a, c
    ld hl, wDA74
    call ReadByteAtHLPlus4APlus3C_Bank05
    and a, $03
    cp a, $03
    jr nz, Jump_005_4942

Jump_005_4937::
    inc c
    dec b
    jr nz, Jump_005_4914
    pop af
    ld [wRecordBuffer], a
    ld c, $00
    ret

Jump_005_4942::
    pop af
    ld [wRecordBuffer], a
    ld c, $FF
    ret

; 2 call sites from 2 routines (e.g. Func_005_7322, Func_005_78A8)
; reads: wBattleActor
; points at: wDA74
Func_005_4949:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_4953::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_496D
    call GetBattleMP_Bank05
    ld a, h
    or a, l
    jr z, Jump_005_496D
    ld a, c
    ld hl, wDA74
    call ReadByteAtHLPlus4APlus3C_Bank05
    and a, $0C
    cp a, $0C
    jr nz, Jump_005_4974

Jump_005_496D::
    inc c
    dec b
    jr nz, Jump_005_4953
    ld c, $00
    ret

Jump_005_4974::
    ld c, $FF
    ret

; 1 call site from 1 routine (e.g. Func_005_724F)
; reads: wBattleActor
; points at: wDA75
Func_005_4977::
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_4981::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_49A0
    call GetBattleDEF_Bank05
    ld a, h
    or a, a
    jr nz, Jump_005_4993
    ld a, l
    cp a, $02
    jr c, Jump_005_49A0

Jump_005_4993::
    ld a, c
    ld hl, wDA75
    call ReadByteAtHLPlus4APlus3C_Bank05
    and a, $30
    cp a, $30
    jr nz, Jump_005_49A7

Jump_005_49A0::
    inc c
    dec b
    jr nz, Jump_005_4981
    ld c, $00
    ret

Jump_005_49A7::
    ld c, $FF
    ret

; 1 call site from 1 routine (e.g. Func_005_7293)
; reads: wBattleActor
; points at: wDA75
Func_005_49AA:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_49B4::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_49D3
    call GetBattleAGL_Bank05
    ld a, h
    or a, a
    jr nz, Jump_005_49C6
    ld a, l
    cp a, $02
    jr c, Jump_005_49D3

Jump_005_49C6::
    ld a, c
    ld hl, wDA75
    call ReadByteAtHLPlus4APlus3C_Bank05
    and a, $0C
    cp a, $0C
    jr nz, Jump_005_49DA

Jump_005_49D3::
    inc c
    dec b
    jr nz, Jump_005_49B4
    ld c, $00
    ret

Jump_005_49DA::
    ld c, $FF
    ret

; 3 call sites from 3 routines (e.g. Func_005_763E, Func_005_7847, Func_005_7860)
; reads: wBattleActor
; points at: wBattleStatus, wDA76
Func_005_49DD::
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_49E7::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_4A06
    ld a, c
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    and a, $03
    jr nz, Jump_005_4A06
    ld a, c
    ld hl, wDA76
    call ReadByteAtHLPlus4APlus3C_Bank05
    and a, $03
    cp a, $03
    jr nz, Jump_005_4A0D

Jump_005_4A06::
    inc c
    dec b
    jr nz, Jump_005_49E7
    ld c, $00
    ret

Jump_005_4A0D::
    ld c, $FF
    ret

; 2 call sites from 2 routines (e.g. Func_005_765B, Func_005_7824)
; reads: wBattleActor
; points at: wBattleStatus, wDA77
Func_005_4A10:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_4A1A::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_4A39
    ld a, c
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    and a, $40
    jr nz, Jump_005_4A39
    ld a, c
    ld hl, wDA77
    call ReadByteAtHLPlus4APlus3C_Bank05
    and a, $C0
    cp a, $C0
    jr nz, Jump_005_4A40

Jump_005_4A39::
    inc c
    dec b
    jr nz, Jump_005_4A1A
    ld c, $00
    ret

Jump_005_4A40::
    ld c, $FF
    ret

; 1 call site from 1 routine (e.g. Func_005_7879)
; reads: wBattleActor
; points at: wBattleStatus, wDA77
Func_005_4A43:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_4A4D::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_4A6C
    ld a, c
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    and a, $20
    jr nz, Jump_005_4A6C
    ld a, c
    ld hl, wDA77
    call ReadByteAtHLPlus4APlus3C_Bank05
    and a, $30
    cp a, $30
    jr nz, Jump_005_4A73

Jump_005_4A6C::
    inc c
    dec b
    jr nz, Jump_005_4A4D
    ld c, $00
    ret

Jump_005_4A73::
    ld c, $FF
    ret

; 1 call site from 1 routine (e.g. Func_005_7B84)
; reads: wRecordBuffer, wBattleActor
; writes: wRecordBuffer
; points at: wD80D, wDA77
Func_005_4A76:: ; heuristic: follows a terminator; C0
    ld a, [wRecordBuffer]
    push af
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld d, $20

Jump_005_4A86::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_4AA9
    ld a, c
    ld hl, wD80D
    call AddAx9ToHL
    bit 6, [hl]
    jr nz, Jump_005_4AA9
    call Func_005_6C02
    jr z, Jump_005_4AA9
    ld a, c
    ld hl, wDA77
    call ReadByteAtHLPlus4APlus3C_Bank05
    and a, $03
    cp a, $03
    jr nz, Jump_005_4AB4

Jump_005_4AA9::
    inc c
    dec b
    jr nz, Jump_005_4A86
    pop af
    ld [wRecordBuffer], a
    ld c, $00
    ret

Jump_005_4AB4::
    pop af
    ld [wRecordBuffer], a
    ld c, $FF
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wRecordBuffer, wBattleActor
; writes: wRecordBuffer
; points at: wD80D, wDA78
Func_005_4ABB:: ; heuristic: follows a terminator; C0
    ld a, [wRecordBuffer]
    push af
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld d, $10

Jump_005_4ACB::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_4AEE
    ld a, c
    ld hl, wD80D
    call AddAx9ToHL
    bit 7, [hl]
    jr nz, Jump_005_4AEE
    call Func_005_6C02
    jr z, Jump_005_4AEE
    ld a, c
    ld hl, wDA78
    call ReadByteAtHLPlus4APlus3C_Bank05
    and a, $C0
    cp a, $C0
    jr nz, Jump_005_4AF9

Jump_005_4AEE::
    inc c
    dec b
    jr nz, Jump_005_4ACB
    pop af
    ld [wRecordBuffer], a
    ld c, $00
    ret

Jump_005_4AF9::
    pop af
    ld [wRecordBuffer], a
    ld c, $FF
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wBattleSlotOut
Func_005_4B00:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld b, $03

Jump_005_4B10::
    ld a, [hl+]
    cp a, $01
    jr z, Jump_005_4B3A
    dec b
    jr nz, Jump_005_4B10
    ld b, $03

Jump_005_4B1A::
    push bc
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_4B31
    call GetBattleMaxHP_Bank05
    push hl
    ld a, c
    call GetBattleHP_Bank05
    add hl, hl
    add hl, hl
    pop bc
    call CompareHLToBC
    jr c, Jump_005_4B39

Jump_005_4B31::
    pop bc
    inc c
    dec b
    jr nz, Jump_005_4B1A
    ld c, $00
    ret

Jump_005_4B39::
    pop bc

Jump_005_4B3A::
    ld c, $FF
    ret

; 5 call sites from 5 routines (e.g. Func_005_76E2, Func_0E2_4001, Func_0E2_4279, Func_0E2_4B6B, ...)
; reads: wBattleActor
Func_005_4B3D::
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld e, $00

Jump_005_4B49::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_4B50
    inc e

Jump_005_4B50::
    inc c
    dec b
    jr nz, Jump_005_4B49
    ld a, e
    cp a, $02
    jr nc, Jump_005_4B5C
    ld c, $00
    ret

Jump_005_4B5C::
    ld c, $FF
    ret

; 1 call site from 1 routine (e.g. Func_005_7A91)
; reads: wBattleActor
; points at: wBattleSlotOut
Func_005_4B5F:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    or a, $03
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld a, [hl]
    or a, a
    jr z, Jump_005_4B74
    jr Jump_005_4B77

Jump_005_4B74::
    ld c, $00
    ret

Jump_005_4B77::
    ld c, $FF
    ret

; 4 call sites from 4 routines (e.g. Func_005_71AC, Func_005_71BE, Func_005_7946, Func_005_7DA8)
; reads: wBattleActor
; points at: wBattleSlotOut
Func_005_4B7A:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld b, $03

Jump_005_4B89::
    ld a, [hl+]
    cp a, $01
    jr z, Jump_005_4B94
    dec b
    jr nz, Jump_005_4B89
    ld c, $00
    ret

Jump_005_4B94::
    ld c, $FF
    ret

; 4 call sites from 4 routines (e.g. Func_005_76A3, Func_0E2_4536, Func_0E2_4567, Func_0E2_545D)
; reads: wBattleActor
Func_005_4B97:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    call GetBattleAGL_Bank05
    ld b, h
    ld c, l
    ld a, $1F
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    push hl
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld de, $0000

Jump_005_4BB7::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_4BCE
    call GetBattleAGL_Bank05
    ld a, h
    cp a, d
    jr z, Jump_005_4BC8
    jr c, Jump_005_4BCE
    jr Jump_005_4BCC

Jump_005_4BC8::
    ld a, l
    cp a, e
    jr c, Jump_005_4BCE

Jump_005_4BCC::
    ld d, h
    ld e, l

Jump_005_4BCE::
    inc c
    dec b
    jr nz, Jump_005_4BB7
    pop hl
    ld b, d
    ld c, e
    call CompareHLToBC
    jp c, Jump_005_4BDE
    ld c, $00
    ret

Jump_005_4BDE::
    ld c, $FF
    ret

; 5 call sites from 5 routines (e.g. Func_0E2_4279, Func_0E2_432D, Func_0E2_5B3D, Func_0E2_6249, ...)
; reads: wBattleActor
Func_005_4BE1:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03
    ld d, $00

Jump_005_4BEB::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_4BF8
    call Func_005_6B9E
    jr c, Jump_005_4BFF
    jr z, Jump_005_4BFF

Jump_005_4BF8::
    inc c
    dec b
    jr nz, Jump_005_4BEB
    ld c, $00
    ret

Jump_005_4BFF::
    ld c, $FF
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
Func_005_4C02:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03
    ld d, $00

Jump_005_4C0C::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_4C19
    call Func_005_6FFD
    jr c, Jump_005_4C20
    jr z, Jump_005_4C20

Jump_005_4C19::
    inc c
    dec b
    jr nz, Jump_005_4C0C
    ld c, $00
    ret

Jump_005_4C20::
    ld c, $FF
    ret

; 1 call site from 1 routine (e.g. Func_005_7236)
; reads: wBattleActor
Func_005_4C23:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03

Jump_005_4C2B::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_4C36
    call Func_005_6B20
    jr c, Jump_005_4C3D

Jump_005_4C36::
    inc c
    dec b
    jr nz, Jump_005_4C2B
    ld c, $00
    ret

Jump_005_4C3D::
    ld c, $FF
    ret

; 1 call site from 1 routine (e.g. Func_005_727A)
; reads: wBattleActor
Func_005_4C40:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03

Jump_005_4C48::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_4C53
    call Func_005_6B5F
    jr c, Jump_005_4C5A

Jump_005_4C53::
    inc c
    dec b
    jr nz, Jump_005_4C48
    ld c, $00
    ret

Jump_005_4C5A::
    ld c, $FF
    ret

; 32 call sites from 32 routines (e.g. Func_005_772B, Func_005_7397, Func_005_7BEE, Func_0E2_4001, ...)
; reads: wBattleActor
; points at: wD2C1
Func_005_4C5D::
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld e, $00

Jump_005_4C69::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_4C71
    inc e
    ld d, c

Jump_005_4C71::
    inc c
    dec b
    jr nz, Jump_005_4C69
    ld a, e
    cp a, $02
    jr nc, Jump_005_4C99
    ld a, d
    call GetBattleHP_Bank05
    push hl
    ld hl, wD2C1
    ld a, d
    and a, $03
    sla a
    add_a_to_hl
    ld a, [hl+]
    ld c, a
    ld a, [hl]
    ld b, a
    pop hl
    call CompareHLToBC
    jr nc, Jump_005_4C99
    ld c, $00
    ret

Jump_005_4C99::
    ld c, $FF
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC58A, wBattleActor, hFFC6
; writes: hFFC6, wSpeciesIdLo, wSpeciesIdHi
; points at: wBattleMonsterId, hFFC6
Func_005_4C9C:: ; heuristic: follows a terminator; C0
    ld a, [wC58A]
    or a, a
    jr nz, Jump_005_4CE2
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    xor a, a
    ldh [hFFC6], a

Jump_005_4CAF::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_4CD6
    ld hl, wBattleMonsterId
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    push bc
    farcall TestSpeciesFlag
    ld a, c
    pop bc
    or a, a
    jr nz, Jump_005_4CD6
    ld hl, hFFC6
    inc [hl]

Jump_005_4CD6::
    inc c
    dec b
    jr nz, Jump_005_4CAF
    ldh a, [hFFC6]
    or a, a
    jr z, Jump_005_4CE2
    ld c, $00
    ret

Jump_005_4CE2::
    ld c, $FF
    ret

; 3 call sites from 3 routines (e.g. Func_0E2_4001, Func_0E2_4F30, Func_0E2_4FE1)
; reads: wBattleActor
; points at: wD812
Func_005_4CE5::
    ld a, [wBattleActor]
    call ReadWDA53Indexed_Bank05
    cp a, $03
    jr c, Jump_005_4D17
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_4CF9::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_4D0B
    ld a, c
    ld hl, wD812
    call AddAx9ToHL
    inc hl
    bit 2, [hl]
    jr nz, Jump_005_4D11

Jump_005_4D0B::
    inc c
    dec b
    jr nz, Jump_005_4CF9
    jr Jump_005_4D14

Jump_005_4D11::
    ld c, $00
    ret

Jump_005_4D14::
    ld c, $FF
    ret

Jump_005_4D17::
    ld c, $01
    ret

; 2 call sites from 2 routines (e.g. Func_005_72AC, Func_0E2_4A08)
; reads: wBattleActor
; points at: wD80D
Func_005_4D1A:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03

Jump_005_4D22::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_4D3C
    ld a, c
    ld hl, wD80D
    call AddAx9ToHL
    ld a, [hl]
    and a, $0C
    jr nz, Jump_005_4D3C
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    and a, $03
    jr z, Jump_005_4D43

Jump_005_4D3C::
    inc c
    dec b
    jr nz, Jump_005_4D22
    ld c, $00
    ret

Jump_005_4D43::
    ld c, $FF
    ret

; 1 call site from 1 routine (e.g. Func_005_7449)
; reads: wBattleActor
; points at: wD814
Func_005_4D46:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    ld b, $03
    ld e, $40
    ld hl, wD814
    call AnySlotLacksStatusMask
    ret

; 1 call site from 1 routine (e.g. Func_005_7996)
; reads: wBattleActor
; points at: wD811
Func_005_4D56:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    ld hl, wD811
    call AddAx9ToHL
    ld a, [hl]
    and a, $0C
    jr z, Jump_005_4D67
    ld c, $00
    ret

Jump_005_4D67::
    ld c, $FF
    ret

; 1 call site from 1 routine (e.g. Func_005_7A27)
; reads: wBattleActor
; points at: wBattleStatus
Func_005_4D6A:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03

Jump_005_4D72::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_4D9B
    ld a, c
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl+]
    or a, a
    jr nz, Jump_005_4DA2
    ld a, [hl+]
    and a, $C3
    jr nz, Jump_005_4DA2
    inc hl
    inc hl
    inc hl
    ld a, [hl+]
    and a, $03
    jr nz, Jump_005_4DA2
    ld a, [hl+]
    and a, $80
    jr nz, Jump_005_4DA2
    inc hl
    ld a, [hl]
    and a, $80
    jr nz, Jump_005_4DA2

Jump_005_4D9B::
    inc c
    dec b
    jr nz, Jump_005_4D72
    ld c, $00
    ret

Jump_005_4DA2::
    ld c, $FF
    ret

; 1 call site from 1 routine (e.g. Func_005_7A55)
; reads: wBattleActor
; points at: wD80D, wBattleSlotOut
Func_005_4DA5:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_4DAF::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_4DD8
    ld a, c
    ld hl, wD80D
    call AddAx9ToHL
    ld a, [hl+]
    and a, $3C
    jr nz, Jump_005_4DF2
    ld a, [hl+]
    and a, $6F
    jr nz, Jump_005_4DF2
    inc hl
    inc hl
    ld a, [hl+]
    and a, $CC
    jr nz, Jump_005_4DF2
    ld a, [hl+]
    and a, $40
    jr nz, Jump_005_4DF2
    inc hl
    ld a, [hl]
    and a, $40
    jr nz, Jump_005_4DF2

Jump_005_4DD8::
    inc c
    dec b
    jr nz, Jump_005_4DAF
    ld a, [wBattleActor]
    and a, $04
    or a, $03
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld a, [hl]
    or a, a
    jr z, Jump_005_4DF2
    ld c, $00
    ret

Jump_005_4DF2::
    ld c, $FF
    ret

; 4 call sites from 4 routines (e.g. Func_005_7109, Func_005_71BE, Func_005_7946, Func_005_7DA8)
; reads: wBattleActor
; points at: wC984
Func_005_4DF5::
    ld a, [wBattleActor]
    rrca
    rrca
    and a, $01
    ld hl, wC984
    add_a_to_hl
    ld a, [hl]
    cp a, $01
    jr nz, Jump_005_4E0C
    ld c, $00
    ret

Jump_005_4E0C::
    ld c, $FF
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wCFC5
Func_005_4E0F:: ; heuristic: follows a terminator; C0
    ld a, [wCFC5]
    cp a, $04
    jr z, Jump_005_4E1A
    cp a, $05
    jr nz, Jump_005_4E1D

Jump_005_4E1A::
    ld c, $00
    ret

Jump_005_4E1D::
    ld c, $FF
    ret

; 1 call site from 1 routine (e.g. Func_0E2_61E0)
; reads: wQueuedActionId
Func_005_4E20:: ; heuristic: follows a terminator; C0
    ld a, [wQueuedActionId]
    and a, a
    jr z, Jump_005_4E45
    cp a, $3D
    jr z, Jump_005_4E42
    cp a, $3E
    jr z, Jump_005_4E42
    cp a, $3F
    jr z, Jump_005_4E42
    cp a, $43
    jr z, Jump_005_4E42
    cp a, $47
    jr z, Jump_005_4E42
    cp a, $66
    jr z, Jump_005_4E42
    cp a, $67
    jr nz, Jump_005_4E45

Jump_005_4E42::
    ld c, $00
    ret

Jump_005_4E45::
    ld c, $FF
    ret

; 12 call sites from 12 routines (e.g. Func_005_557E, Func_0E2_40BF, Func_0E2_411C, Func_0E2_4AB6, ...)
; reads: wBattleActor
; points at: wD2C1
Func_005_4E48::
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld hl, wD2C1

Jump_005_4E55::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_4E70
    push hl
    push bc
    call Func_005_4E7C
    pop bc
    ld d, h
    ld e, l
    pop hl
    inc hl
    ld a, [hl]
    cp a, d
    jr c, Jump_005_4E70
    dec hl
    ld a, [hl+]
    cp a, e
    jr c, Jump_005_4E70
    jr Jump_005_4E76

Jump_005_4E70::
    inc c
    dec b
    jr nz, Jump_005_4E55
    jr Jump_005_4E79

Jump_005_4E76::
    ld c, $00
    ret

Jump_005_4E79::
    ld c, $FF
    ret

; 1 call site from 1 routine (e.g. Func_005_4E48)
; reads: wRecordBuffer, wCFF7, wCFF9, wCFF8, wCFFA, wBattleActor, wC58A
; points at: wD8B7
Func_005_4E7C::
    ld a, [wRecordBuffer]
    cp a, $48
    jr z, Jump_005_4EBD
    cp a, $49
    jr z, Jump_005_4F01
    cp a, $4A
    jp z, Jump_005_4F44
    cp a, $4E
    jp z, Jump_005_4F9C
    cp a, $4F
    jp z, Jump_005_4FCB
    cp a, $50
    jp z, Jump_005_5010
    cp a, $51
    jp z, Jump_005_5010
    cp a, $52
    jp z, Jump_005_5010
    cp a, $53
    jp z, Jump_005_5010
    ld a, [wCFF7]
    ld l, a
    ld a, [wCFF9]
    add a, l
    ld l, a
    ld a, [wCFF8]
    ld h, a
    ld a, [wCFFA]
    adc a, h
    ld h, a
    ret

Jump_005_4EBD::
    ld a, [wBattleActor]
    ld hl, wD8B7
    add_a_to_hl
    ld l, [hl]
    ld h, $00
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_005_4ED9
    ld a, [wBattleActor]
    cp a, $04
    jr nc, Jump_005_4EE4

Jump_005_4ED9::
    ld a, l
    add a, $0A
    add hl, hl
    add_a_to_hl
    jr Jump_005_4EEC

Jump_005_4EE4::
    ld a, l
    srl a
    add a, l
    ld l, a
    jr nc, Jump_005_4EEC
    inc h

Jump_005_4EEC::
    ld a, $73
    call Func_005_5029
    ld a, h
    or a, a
    jr nz, Jump_005_4EFB
    ld a, l
    cp a, $B4
    jp c, Jump_005_4FF9

Jump_005_4EFB::
    ld hl, $00B4
    jp Jump_005_4FF9

Jump_005_4F01::
    ld a, [wBattleActor]
    ld hl, wD8B7
    add_a_to_hl
    ld l, [hl]
    ld h, $00
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_005_4F1D
    ld a, [wBattleActor]
    cp a, $04
    jr nc, Jump_005_4F27

Jump_005_4F1D::
    ld a, $1E
    add hl, hl
    add_a_to_hl
    jr Jump_005_4F2F

Jump_005_4F27::
    ld a, l
    srl a
    add a, l
    ld l, a
    jr nc, Jump_005_4F2F
    inc h

Jump_005_4F2F::
    ld a, $6E
    call Func_005_5029
    ld a, h
    or a, a
    jr nz, Jump_005_4F3E
    ld a, l
    cp a, $96
    jp c, Jump_005_4FF9

Jump_005_4F3E::
    ld hl, $0096
    jp Jump_005_4FF9

Jump_005_4F44::
    ld a, [wBattleActor]
    ld hl, wD8B7
    add_a_to_hl
    ld l, [hl]
    ld h, $00
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_005_4F60
    ld a, [wBattleActor]
    cp a, $04
    jr nc, Jump_005_4F6A

Jump_005_4F60::
    ld a, $14
    add hl, hl
    add_a_to_hl
    jr Jump_005_4F72

Jump_005_4F6A::
    ld a, l
    srl a
    add a, l
    ld l, a
    jr nc, Jump_005_4F72
    inc h

Jump_005_4F72::
    ld a, $6E
    push bc
    call Func_005_5029
    pop bc
    push hl
    call SlotFamilyBelowWater
    pop hl
    jr z, Jump_005_4F8E
    ld a, h
    or a, a
    jr nz, Jump_005_4F89
    ld a, l
    cp a, $B4
    jr c, Jump_005_4FF9

Jump_005_4F89::
    ld hl, $00B4
    jr Jump_005_4FF9

Jump_005_4F8E::
    ld a, h
    or a, a
    jr nz, Jump_005_4F97
    ld a, l
    cp a, $DC
    jr c, Jump_005_4FF9

Jump_005_4F97::
    ld hl, $00DC
    jr Jump_005_4FF9

Jump_005_4F9C::
    ld a, [wBattleActor]
    ld hl, wD8B7
    add_a_to_hl
    ld l, [hl]
    ld h, $00
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_005_4FB8
    ld a, [wBattleActor]
    cp a, $04
    jr nc, Jump_005_4FC0

Jump_005_4FB8::
    add hl, hl
    add_a_to_hl
    jr Jump_005_4FC8

Jump_005_4FC0::
    ld a, l
    srl a
    add a, l
    ld l, a
    jr nc, Jump_005_4FC8
    inc h

Jump_005_4FC8::
    add hl, hl
    jr Jump_005_4FF9

Jump_005_4FCB::
    ld a, [wBattleActor]
    ld hl, wD8B7
    add_a_to_hl
    ld l, [hl]
    ld h, $00
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_005_4FE7
    ld a, [wBattleActor]
    cp a, $04
    jr nc, Jump_005_4FEF

Jump_005_4FE7::
    add hl, hl
    add_a_to_hl
    jr Jump_005_4FF7

Jump_005_4FEF::
    ld a, l
    srl a
    add a, l
    ld l, a
    jr nc, Jump_005_4FF7
    inc h

Jump_005_4FF7::
    add hl, hl
    add hl, hl

Jump_005_4FF9::
    ld a, c
    cp a, $03
    ld c, $00
    jr z, Jump_005_5028
    cp a, $02
    ld c, $32
    jr z, Jump_005_5028
    cp a, $01
    ld c, $55
    jr z, Jump_005_5028
    ld c, $64
    jr Jump_005_5028

Jump_005_5010::
    deref_hl
    ld a, c
    cp a, $03
    ld c, $1E
    jr z, Jump_005_5028
    cp a, $02
    ld c, $4B
    jr z, Jump_005_5028
    cp a, $01
    ld c, $73
    jr z, Jump_005_5028
    ld c, $82

Jump_005_5028::
    ld a, c

; 3 call sites from 1 routine (e.g. Func_005_4E7C)
Func_005_5029::
    ld b, h
    ld c, l
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    ret

; C = battle slot: loads the slot's species record (LoadSpeciesRecord); A = its family; carry set when the family is below 9 (Slime to Material), clear for Water (9) and Boss (10) (E-0069)
; 1 call site from 1 routine (e.g. Func_005_4E7C)
; reads: wSpeciesRecord
; writes: wSpeciesIdLo, wSpeciesIdHi
; points at: wBattleMonsterId
SlotFamilyBelowWater::
Func_005_5034:: ; address name
    ld a, c
    add a, a
    ld hl, wBattleMonsterId
    add_a_to_hl
    ld a, [hl+]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wSpeciesRecord]
    cp a, $09
    ret

; 14 call sites from 14 routines (e.g. Func_0E2_40BF, Func_0E2_411C, Func_0E2_47AB, Func_0E2_4A08, ...)
; reads: wCFEF, wBattleActor, hFFC6, hFFC7
; writes: hFFC6, hFFC7
; points at: wDA72
Func_005_5052::
    ld a, [wCFEF]
    or a, a
    jr z, Jump_005_50B4
    dec a
    ld hl, Data_005_6F6B
    add a, a
    add_a_to_hl
    ld d, [hl]
    inc hl
    ld e, [hl]
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld hl, wDA72
    add a, a
    add a, c
    add a, a
    add a, c
    add a, d
    add_a_to_hl
    xor a, a
    ldh [hFFC6], a
    ldh [hFFC7], a

Jump_005_5081::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_5095
    ldh a, [hFFC6]
    inc a
    ldh [hFFC6], a
    call Func_005_6C86
    ld d, a
    ldh a, [hFFC7]
    add a, d
    ldh [hFFC7], a

Jump_005_5095::
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc c
    dec b
    jr nz, Jump_005_5081
    ldh a, [hFFC7]
    or a, a
    jr z, Jump_005_50B1
    ld b, a
    ldh a, [hFFC6]
    call DivideBByA
    ld a, b
    cp a, $02
    jr nc, Jump_005_50B4

Jump_005_50B1::
    ld c, $00
    ret

Jump_005_50B4::
    ld c, $FF
    ret

; 4 call sites from 4 routines (e.g. Func_0E2_4536, Func_0E2_4567, Func_0E2_4721, Func_0E2_545D)
; reads: wBattleActor
Func_005_50B7:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    call ReadWDA53Indexed_Bank05
    cp a, $02
    jr c, Jump_005_50E0
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    call Func_005_6DFF
    push hl
    ld a, [wBattleActor]
    and a, $04
    call Func_005_6DFF
    pop bc
    call CompareHLToBC
    jr nc, Jump_005_50DD
    ld c, $00
    ret

Jump_005_50DD::
    ld c, $FF
    ret

Jump_005_50E0::
    ld c, $01
    ret

; 7 call sites from 7 routines (e.g. Func_0E2_449C, Func_0E2_5426, Func_0E2_54C4, Func_0E2_5529, ...)
; reads: wBattleActor, hFFC7, hFFC8, hFFC6, hFFCA, hFFCB, hFFC9
; writes: hFFC6, hFFC7, hFFC8, hFFC9, hFFCA, hFFCB
; points at: hFFC6, hFFC9
Func_005_50E3:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    call ReadWDA53Indexed_Bank05
    cp a, $02
    jp c, Jump_005_517A
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    xor a, a
    ldh [hFFC6], a
    ldh [hFFC7], a
    ldh [hFFC8], a

Jump_005_50FF::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_5117
    ld hl, hFFC6
    inc [hl]
    ld a, c
    call GetBattleDEF_Bank05
    ldh a, [hFFC7]
    add a, l
    ldh [hFFC7], a
    ldh a, [hFFC8]
    adc a, h
    ldh [hFFC8], a

Jump_005_5117::
    inc c
    dec b
    jr nz, Jump_005_50FF
    ldh a, [hFFC7]
    ld l, a
    ldh a, [hFFC8]
    ld h, a
    ldh a, [hFFC6]
    call DivideHLByA
    ld a, l
    ldh [hFFC7], a
    ld a, h
    ldh [hFFC8], a
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03
    xor a, a
    ldh [hFFC9], a
    ldh [hFFCA], a
    ldh [hFFCB], a

Jump_005_513B::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_5152
    call GetBattleATK_Bank05
    ldh a, [hFFCA]
    add a, l
    ldh [hFFCA], a
    ldh a, [hFFCB]
    adc a, h
    ldh [hFFCB], a
    ld hl, hFFC9
    inc [hl]

Jump_005_5152::
    inc c
    dec b
    jr nz, Jump_005_513B
    ldh a, [hFFCA]
    ld l, a
    ldh a, [hFFCB]
    ld h, a
    ldh a, [hFFC9]
    call DivideHLByA
    sla l
    rl h
    push hl
    ldh a, [hFFC7]
    ld l, a
    ldh a, [hFFC8]
    ld h, a
    pop bc
    call CompareHLToBC
    jr c, Jump_005_5177
    jr z, Jump_005_5177
    ld c, $00
    ret

Jump_005_5177::
    ld c, $FF
    ret

Jump_005_517A::
    ld c, $01
    ret

; 7 call sites from 7 routines (e.g. Func_0E2_449C, Func_0E2_493F, Func_0E2_54C4, Func_0E2_5529, ...)
; reads: wBattleActor, hFFC6, hFFC7
; writes: hFFC6, hFFC7
Func_005_517D:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    call ReadWDA53Indexed_Bank05
    cp a, $02
    jr c, Jump_005_51E7
    ld a, [wBattleActor]
    call GetBattleATK_Bank05
    add hl, hl
    push hl
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    xor a, a
    ldh [hFFC6], a
    ldh [hFFC7], a

Jump_005_519E::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr nc, Jump_005_51AA
    inc c
    dec b
    jr nz, Jump_005_519E
    jr Jump_005_51E0

Jump_005_51AA::
    call GetBattleDEF_Bank05
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    inc c
    dec b
    jr z, Jump_005_51D2

Jump_005_51B7::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_51CE
    call GetBattleDEF_Bank05
    ldh a, [hFFC6]
    sub a, l
    ldh a, [hFFC7]
    sbc a, h
    jr nc, Jump_005_51CE
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a

Jump_005_51CE::
    inc c
    dec b
    jr nz, Jump_005_51B7

Jump_005_51D2::
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    pop bc
    call CompareHLToBC
    jr c, Jump_005_51E4
    jr Jump_005_51E1

Jump_005_51E0::
    pop bc

Jump_005_51E1::
    ld c, $00
    ret

Jump_005_51E4::
    ld c, $FF
    ret

Jump_005_51E7::
    ld c, $01
    ret

; 1 call site from 1 routine (e.g. Func_0E2_4619)
; reads: wBattleActor, hFFC6, hFFC7
Func_005_51EA:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    call ReadWDA53Indexed_Bank05
    cp a, $02
    jr c, Jump_005_5225
    call Func_005_6CC2
    ld a, [wBattleActor]
    call GetBattleATK_Bank05
    ldh a, [hFFC6]
    ld c, a
    ldh a, [hFFC7]
    ld b, a
    sla c
    rl b
    call CompareHLToBC
    jr c, Jump_005_5210
    jr z, Jump_005_5210
    jr Jump_005_5222

Jump_005_5210::
    sra b
    rr c
    sra b
    rr c
    call CompareHLToBC
    jr nc, Jump_005_521F
    jr Jump_005_5222

Jump_005_521F::
    ld c, $00
    ret

Jump_005_5222::
    ld c, $FF
    ret

Jump_005_5225::
    ld c, $01
    ret

; 1 call site from 1 routine (e.g. Func_0E2_4619)
; reads: wBattleActor, hFFC6, hFFC7
Func_005_5228:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    call ReadWDA53Indexed_Bank05
    cp a, $02
    jr c, Jump_005_5272
    call Func_005_6CC2
    ld a, [wBattleActor]
    and a, $04
    ld e, a
    ld d, $03

Jump_005_523D::
    ld a, e
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_5266
    call GetBattleATK_Bank05
    ldh a, [hFFC6]
    ld c, a
    ldh a, [hFFC7]
    ld b, a
    sla c
    rl b
    call CompareHLToBC
    jr c, Jump_005_5259
    jr z, Jump_005_5259
    jr Jump_005_5266

Jump_005_5259::
    sra b
    rr c
    sra b
    rr c
    call CompareHLToBC
    jr nc, Jump_005_526C

Jump_005_5266::
    inc e
    dec d
    jr nz, Jump_005_523D
    jr Jump_005_526F

Jump_005_526C::
    ld c, $00
    ret

Jump_005_526F::
    ld c, $FF
    ret

Jump_005_5272::
    ld c, $01
    ret

; 3 call sites from 3 routines (e.g. Func_0E2_4674, Func_0E2_5BC4, Func_0E2_5C25)
; reads: wBattleActor, hFFC7, hFFC8, hFFC6, hFFCA, hFFCB, hFFC9
; writes: hFFC6, hFFC7, hFFC8, hFFC9, hFFCA, hFFCB
; points at: hFFC6, hFFC9
Func_005_5275:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    call ReadWDA53Indexed_Bank05
    cp a, $02
    jp c, Jump_005_5314
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    xor a, a
    ldh [hFFC6], a
    ldh [hFFC7], a
    ldh [hFFC8], a

Jump_005_5291::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_52AE
    call Func_005_6D07
    jr nz, Jump_005_52AE
    ld hl, hFFC6
    inc [hl]
    ld a, c
    call GetBattleATK_Bank05
    ldh a, [hFFC7]
    add a, l
    ldh [hFFC7], a
    ldh a, [hFFC8]
    adc a, h
    ldh [hFFC8], a

Jump_005_52AE::
    inc c
    dec b
    jr nz, Jump_005_5291
    ldh a, [hFFC7]
    ld l, a
    ldh a, [hFFC8]
    ld h, a
    ldh a, [hFFC6]
    or a, a
    jr z, Jump_005_5311
    call DivideHLByA
    ld a, l
    ldh [hFFC7], a
    ld a, h
    ldh [hFFC8], a
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03
    xor a, a
    ldh [hFFC9], a
    ldh [hFFCA], a
    ldh [hFFCB], a

Jump_005_52D5::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_52EC
    call GetBattleDEF_Bank05
    ldh a, [hFFCA]
    add a, l
    ldh [hFFCA], a
    ldh a, [hFFCB]
    adc a, h
    ldh [hFFCB], a
    ld hl, hFFC9
    inc [hl]

Jump_005_52EC::
    inc c
    dec b
    jr nz, Jump_005_52D5
    ldh a, [hFFCA]
    ld l, a
    ldh a, [hFFCB]
    ld h, a
    ldh a, [hFFC9]
    call DivideHLByA
    sla l
    rl h
    push hl
    ldh a, [hFFC7]
    ld l, a
    ldh a, [hFFC8]
    ld h, a
    pop bc
    call CompareHLToBC
    jr c, Jump_005_5311
    jr z, Jump_005_5311
    ld c, $00
    ret

Jump_005_5311::
    ld c, $FF
    ret

Jump_005_5314::
    ld c, $01
    ret

; 8 call sites from 8 routines (e.g. Func_0E2_656D, Func_0E2_65B8, Func_0E2_661A, Func_0E2_6634, ...)
; reads: hFFC6
Func_005_5317::
    ldh a, [hFFC6]
    call GetBattleMaxHP_Bank05
    add hl, hl
    ld a, $03
    call DivideHLByA
    push hl
    ldh a, [hFFC6]
    call GetBattleHP_Bank05
    pop bc
    push hl
    call CompareHLToBC
    jr nc, Jump_005_537F
    ldh a, [hFFC6]
    call GetBattleMaxHP_Bank05
    srl h
    rr l
    push hl
    pop bc
    pop hl
    push hl
    call CompareHLToBC
    jr nc, Jump_005_5383
    ldh a, [hFFC6]
    call GetBattleMaxHP_Bank05
    ld a, $03
    call DivideHLByA
    push hl
    pop bc
    pop hl
    push hl
    call CompareHLToBC
    jr nc, Jump_005_5387
    ldh a, [hFFC6]
    call GetBattleMaxHP_Bank05
    srl h
    rr l
    srl h
    rr l
    push hl
    pop bc
    pop hl
    push hl
    call CompareHLToBC
    jr nc, Jump_005_538B
    ldh a, [hFFC6]
    call GetBattleMaxHP_Bank05
    ld a, $0A
    call DivideHLByA
    push hl
    pop bc
    pop hl
    push hl
    call CompareHLToBC
    jr nc, Jump_005_538F
    jr Jump_005_5393

Jump_005_537F::
    pop hl
    ld c, $00
    ret

Jump_005_5383::
    pop hl
    ld c, $01
    ret

Jump_005_5387::
    pop hl
    ld c, $02
    ret

Jump_005_538B::
    pop hl
    ld c, $03
    ret

Jump_005_538F::
    pop hl
    ld c, $04
    ret

Jump_005_5393::
    pop hl
    ld c, $05
    ret

; 11 call sites from 11 routines (e.g. Func_005_77C7, Func_005_7C69, Func_005_7CF3, Func_0E2_432D, ...)
; reads: wBattleActor
Func_005_5397:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    call Func_005_6BF8
    jr nz, Jump_005_53A2
    ld c, $00
    ret

Jump_005_53A2::
    ld c, $FF
    ret

; 3 call sites from 3 routines (e.g. Func_0E2_438D, Func_0E2_5B3D, Func_0E2_6387)
; reads: wBattleActor
Func_005_53A5:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03
    ld d, $00

Jump_005_53AF::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_53BB
    call Func_005_6BF8
    jr nz, Jump_005_53BB
    inc d

Jump_005_53BB::
    inc c
    dec b
    jr nz, Jump_005_53AF
    ld a, d
    cp a, $02
    jr c, Jump_005_53C7
    ld c, $00
    ret

Jump_005_53C7::
    ld c, $FF
    ret

; 14 call sites from 14 routines (e.g. Func_005_772B, Func_0E2_4001, Func_0E2_4E71, Func_0E2_4F30, ...)
; reads: wBattleActor
; points at: wD80D
Func_005_53CA::
    ld a, [wBattleActor]
    ld hl, wD80D
    call AddAx9ToHL
    ld a, [hl]
    and a, $0C
    jr nz, Jump_005_53E0
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    and a, $03
    jr z, Jump_005_53E3

Jump_005_53E0::
    ld c, $00
    ret

Jump_005_53E3::
    ld c, $FF
    ret

; 3 call sites from 3 routines (e.g. Func_005_7AA4, Func_005_7CF3, Func_0E2_4B6B)
; reads: wBattleActor
; points at: wD810
Func_005_53E6:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    ld hl, wD810
    call AddAx9ToHL
    ld a, [hl]
    and a, $30
    jr z, Jump_005_53F7
    ld c, $00
    ret

Jump_005_53F7::
    ld c, $FF
    ret

; 7 call sites from 7 routines (e.g. Func_0E2_48FD, Func_0E2_4984, Func_0E2_60A6, Func_0E2_618D, ...)
; reads: wBattleActor
; points at: wD80D, wD989
Func_005_53FA:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    call ReadWDA53Indexed_Bank05
    cp a, $02
    jr c, Jump_005_544C
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_540E::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_5440
    ld a, c
    ld hl, wD80D
    call AddAx9ToHL
    bit 7, [hl]
    jr nz, Jump_005_5440
    ld hl, wD989
    swap a
    add_a_to_hl
    ld d, $08

Jump_005_542B::
    ld a, [hl+]
    cp a, $42
    jr z, Jump_005_5446
    cp a, $43
    jr z, Jump_005_5446
    cp a, $46
    jr z, Jump_005_5446
    cp a, $47
    jr z, Jump_005_5446
    inc hl
    dec d
    jr nz, Jump_005_542B

Jump_005_5440::
    inc c
    dec b
    jr nz, Jump_005_540E
    jr Jump_005_5449

Jump_005_5446::
    ld c, $00
    ret

Jump_005_5449::
    ld c, $FF
    ret

Jump_005_544C::
    ld c, $01
    ret

; 1 call site from 1 routine (e.g. Func_0E2_493F)
; reads: wBattleActor, hFFC6, hFFC7, hFFC8, hFFC9, hFFCA, hFFCB, hFFCC, ...
; writes: hFFC6, hFFC7, hFFC8, hFFC9, hFFCA, hFFCB, hFFCC, hFFCD, ...
; points at: hFFCE
Func_005_544F:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    call ReadWDA53Indexed_Bank05
    cp a, $02
    jp c, Jump_005_54FA
    ld a, [wBattleActor]
    call GetBattleMaxHP_Bank05
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    ld a, [wBattleActor]
    call GetBattleMaxMP_Bank05
    ld a, l
    ldh [hFFC8], a
    ld a, h
    ldh [hFFC9], a
    ld a, [wBattleActor]
    call GetBattleATK_Bank05
    ld a, l
    ldh [hFFCA], a
    ld a, h
    ldh [hFFCB], a
    ld a, [wBattleActor]
    call GetBattleDEF_Bank05
    ld a, l
    ldh [hFFCC], a
    ld a, h
    ldh [hFFCD], a
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld e, a
    ld d, $03

Jump_005_5494::
    xor a, a
    ldh [hFFCE], a
    ld a, e
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_54EE
    call GetBattleMaxHP_Bank05
    ldh a, [hFFC6]
    ld c, a
    ldh a, [hFFC7]
    ld b, a
    call CompareHLToBC
    jr nc, Jump_005_54AF
    ld hl, hFFCE
    inc [hl]

Jump_005_54AF::
    ld a, e
    call GetBattleMaxMP_Bank05
    ldh a, [hFFC8]
    ld c, a
    ldh a, [hFFC9]
    ld b, a
    call CompareHLToBC
    jr nc, Jump_005_54C2
    ld hl, hFFCE
    inc [hl]

Jump_005_54C2::
    ld a, e
    call GetBattleATK_Bank05
    ldh a, [hFFCA]
    ld c, a
    ldh a, [hFFCB]
    ld b, a
    call CompareHLToBC
    jr nc, Jump_005_54D5
    ld hl, hFFCE
    inc [hl]

Jump_005_54D5::
    ld a, e
    call GetBattleDEF_Bank05
    ldh a, [hFFCC]
    ld c, a
    ldh a, [hFFCD]
    ld b, a
    call CompareHLToBC
    jr nc, Jump_005_54E8
    ld hl, hFFCE
    inc [hl]

Jump_005_54E8::
    ldh a, [hFFCE]
    cp a, $03
    jr nc, Jump_005_54F4

Jump_005_54EE::
    inc e
    dec d
    jr nz, Jump_005_5494
    jr Jump_005_54F7

Jump_005_54F4::
    ld c, $00
    ret

Jump_005_54F7::
    ld c, $FF
    ret

Jump_005_54FA::
    ld c, $01
    ret

; C = 0
; 73 call sites from 73 routines (e.g. Func_005_7187, Func_005_7DDC, Func_0E2_4001, Func_0E2_40BF, ...)
SetCToZero::
Func_005_54FD:: ; address name
    ld c, $00
    ret

; 2 call sites from 2 routines (e.g. Func_0E2_60D7, Func_0E2_61E0)
; reads: wBattleActor
; points at: wD989, wBattleMP, wD8B7, wBattleHP
Func_005_5500:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    call ReadWDA53Indexed_Bank05
    cp a, $02
    jr c, Jump_005_557B
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld a, c
    swap a
    ld hl, wD989
    add a, l
    ld l, a
    jr nc, Jump_005_551F
    inc h

Jump_005_551F::
    ld d, $08

Jump_005_5521::
    ld a, [hl+]
    cp a, $3D
    jr z, Jump_005_5530
    inc hl
    dec d
    jr nz, Jump_005_5521

Jump_005_552A::
    inc c
    dec b
    jr nz, Jump_005_551F
    jr Jump_005_5578

Jump_005_5530::
    ld a, c
    ld hl, wBattleMP
    call GetBattleMP_Bank05
    add hl, hl
    push hl
    ld a, c
    ld hl, wD8B7
    add_a_to_hl
    ld a, [hl]
    ld e, a
    ld d, $00
    sla e
    rl d
    pop hl
    add hl, de
    push bc
    push hl
    ld a, [wBattleActor]
    sla a
    ld hl, wBattleHP
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld b, [hl]
    ld c, e
    pop hl
    call CompareHLToBC
    jr nc, Jump_005_5574
    pop bc
    ld a, c
    inc a
    sla a
    ld hl, wD989
    add_a_to_hl
    jr Jump_005_552A

Jump_005_5574::
    pop bc
    ld c, $00
    ret

Jump_005_5578::
    ld c, $FF
    ret

Jump_005_557B::
    ld c, $01
    ret

; 11 call sites from 11 routines (e.g. Func_0E2_40BF, Func_0E2_411C, Func_0E2_4AB6, Func_0E2_4B6B, ...)
Func_005_557E::
    call Func_005_4E48
    ld a, c
    and a, a
    jr z, Jump_005_5588
    ld c, $00
    ret

Jump_005_5588::
    ld c, $FF
    ret

; 3 call sites from 3 routines (e.g. Func_005_78A8, Func_005_7322, Func_0E2_478E)
; reads: wBattleActor
Func_005_558B:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    call GetBattleMaxMP_Bank05
    ld b, h
    ld c, l
    add hl, hl
    add hl, bc
    push hl
    ld a, [wBattleActor]
    call GetBattleMP_Bank05
    add hl, hl
    add hl, hl
    pop bc
    call CompareHLToBC
    jr c, Jump_005_55A7
    ld c, $00
    ret

Jump_005_55A7::
    ld c, $FF
    ret

; 1 call site from 1 routine (e.g. Func_005_73D7)
; reads: wBattleActor
; points at: wD80E
Func_005_55AA:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    ld hl, wD80E
    call AddAx9ToHL
    ld a, [hl]
    and a, $22
    jr z, Jump_005_55BB
    ld c, $00
    ret

Jump_005_55BB::
    ld c, $FF
    ret

; 2 call sites from 2 routines (e.g. Func_0E2_6822, Func_0E2_6843)
; reads: wC58A, wBattleActor
; points at: wD044, wD057
Func_005_55BE::
    ld a, [wC58A]
    and a, a
    jr z, Jump_005_55F0
    cp a, $02
    jr z, Jump_005_55F0
    ld hl, wD044
    bit 7, [hl]
    jr z, Jump_005_55F0
    bit 6, [hl]
    jr z, Jump_005_55F0
    inc hl
    bit 6, [hl]
    jr z, Jump_005_55ED
    ld a, [wBattleActor]
    ld hl, wD057
    and a, $04
    srl a
    srl a
    add_a_to_hl
    bit 6, [hl]
    jr z, Jump_005_55F0

Jump_005_55ED::
    ld c, $00
    ret

Jump_005_55F0::
    ld c, $FF
    ret

; 2 call sites from 2 routines (e.g. Func_005_73D7, Func_0E2_6854)
; reads: wC58A, wBattleActor
; points at: wD044, wD057
Func_005_55F3:: ; heuristic: follows a terminator; C0
    ld a, [wC58A]
    and a, a
    jr z, Jump_005_5625
    cp a, $02
    jr z, Jump_005_5625
    ld hl, wD044
    bit 7, [hl]
    jr z, Jump_005_5625
    bit 5, [hl]
    jr z, Jump_005_5625
    inc hl
    bit 5, [hl]
    jr z, Jump_005_5622
    ld a, [wBattleActor]
    ld hl, wD057
    and a, $04
    srl a
    srl a
    add_a_to_hl
    bit 5, [hl]
    jr z, Jump_005_5625

Jump_005_5622::
    ld c, $00
    ret

Jump_005_5625::
    ld c, $FF
    ret

; 1 call site from 1 routine (e.g. Func_0E2_6865)
; reads: wC58A, wBattleActor
; points at: wD044, wD057
Func_005_5628:: ; heuristic: follows a terminator; C0
    ld a, [wC58A]
    and a, a
    jr z, Jump_005_565A
    cp a, $02
    jr z, Jump_005_565A
    ld hl, wD044
    bit 7, [hl]
    jr z, Jump_005_565A
    bit 4, [hl]
    jr z, Jump_005_565A
    inc hl
    bit 4, [hl]
    jr z, Jump_005_5657
    ld a, [wBattleActor]
    ld hl, wD057
    and a, $04
    srl a
    srl a
    add_a_to_hl
    bit 4, [hl]
    jr z, Jump_005_565A

Jump_005_5657::
    ld c, $00
    ret

Jump_005_565A::
    ld c, $FF
    ret

; 1 call site from 1 routine (e.g. Func_0E2_6876)
; reads: wC58A, wBattleActor
; points at: wD044, wD057
Func_005_565D:: ; heuristic: follows a terminator; C0
    ld a, [wC58A]
    and a, a
    jr z, Jump_005_568F
    cp a, $02
    jr z, Jump_005_568F
    ld hl, wD044
    bit 7, [hl]
    jr z, Jump_005_568F
    bit 3, [hl]
    jr z, Jump_005_568F
    inc hl
    bit 3, [hl]
    jr z, Jump_005_568C
    ld a, [wBattleActor]
    ld hl, wD057
    and a, $04
    srl a
    srl a
    add_a_to_hl
    bit 3, [hl]
    jr z, Jump_005_568F

Jump_005_568C::
    ld c, $00
    ret

Jump_005_568F::
    ld c, $FF
    ret

; 1 call site from 1 routine (e.g. Func_0E2_6887)
; reads: wC58A, wBattleActor
; points at: wD044, wD057
Func_005_5692:: ; heuristic: follows a terminator; C0
    ld a, [wC58A]
    and a, a
    jr z, Jump_005_56C4
    cp a, $02
    jr z, Jump_005_56C4
    ld hl, wD044
    bit 7, [hl]
    jr z, Jump_005_56C4
    bit 2, [hl]
    jr z, Jump_005_56C4
    inc hl
    bit 2, [hl]
    jr z, Jump_005_56C1
    ld a, [wBattleActor]
    ld hl, wD057
    and a, $04
    srl a
    srl a
    add_a_to_hl
    bit 2, [hl]
    jr z, Jump_005_56C4

Jump_005_56C1::
    ld c, $00
    ret

Jump_005_56C4::
    ld c, $FF
    ret

; 1 call site from 1 routine (e.g. Func_0E2_6898)
; reads: wC58A, wBattleActor
; points at: wD044, wD057
Func_005_56C7:: ; heuristic: follows a terminator; C0
    ld a, [wC58A]
    and a, a
    jr z, Jump_005_56F9
    cp a, $02
    jr z, Jump_005_56F9
    ld hl, wD044
    bit 7, [hl]
    jr z, Jump_005_56F9
    bit 1, [hl]
    jr z, Jump_005_56F9
    inc hl
    bit 1, [hl]
    jr z, Jump_005_56F6
    ld a, [wBattleActor]
    ld hl, wD057
    and a, $04
    srl a
    srl a
    add_a_to_hl
    bit 1, [hl]
    jr z, Jump_005_56F9

Jump_005_56F6::
    ld c, $00
    ret

Jump_005_56F9::
    ld c, $FF
    ret

; 1 call site from 1 routine (e.g. Func_0E2_4A08)
; reads: wC58A, wBattleActor
; points at: wD044, wD057
Func_005_56FC:: ; heuristic: follows a terminator; C0
    ld a, [wC58A]
    and a, a
    jr z, Jump_005_572E
    cp a, $02
    jr z, Jump_005_572E
    ld hl, wD044
    bit 7, [hl]
    jr z, Jump_005_572E
    bit 0, [hl]
    jr z, Jump_005_572E
    inc hl
    bit 0, [hl]
    jr z, Jump_005_572B
    ld a, [wBattleActor]
    ld hl, wD057
    and a, $04
    srl a
    srl a
    add_a_to_hl
    bit 0, [hl]
    jr z, Jump_005_572E

Jump_005_572B::
    ld c, $00
    ret

Jump_005_572E::
    ld c, $FF
    ret

; 3 call sites from 3 routines (e.g. Func_0E2_4A08, Func_0E2_4AB6, Func_0E2_6822)
; reads: wC58A, wD891
; points at: wD04B
Func_005_5731::
    ld a, [wC58A]
    and a, a
    jr z, Jump_005_5755
    cp a, $02
    jr z, Jump_005_5755
    ld hl, wD04B
    bit 7, [hl]
    jr z, Jump_005_5755
    ld a, [hl]
    and a, $7F
    ld b, a
    ld a, [wD891]
    sub a, b
    bit 7, a
    jr nz, Jump_005_5752
    cp a, $04
    jr nc, Jump_005_5755

Jump_005_5752::
    ld c, $00
    ret

Jump_005_5755::
    ld c, $FF
    ret

; 8 call sites from 8 routines (e.g. Func_0E2_411C, Func_0E2_49B5, Func_0E2_4A08, Func_0E2_4AB6, ...)
; reads: wBattleActor
Func_005_5758:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    ld e, a
    and a, $04
    ld c, a
    ld b, $03

Jump_005_5761::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr nc, Jump_005_576D
    ld a, c
    cp a, e
    jr z, Jump_005_577C
    jr Jump_005_5771

Jump_005_576D::
    ld a, c
    cp a, e
    jr nz, Jump_005_577C

Jump_005_5771::
    inc c
    dec b
    jr nz, Jump_005_5761
    call FewerThanTwoFoesPresent
    ret
    db $0E, $00, $C9

Jump_005_577C::
    ld c, $FF
    ret

; counts the present slots among the actor's three opposite slots: C = $FF when fewer than two are present, C = 0 for two or three; E = the count (E-0066)
; 21 call sites from 21 routines (e.g. Func_005_5758, Func_0E2_40BF, Func_0E2_411C, Func_0E2_41E0, ...)
; reads: wBattleActor
FewerThanTwoFoesPresent::
Func_005_577F:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld e, $00

Jump_005_578B::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_5792
    inc e

Jump_005_5792::
    inc c
    dec b
    jr nz, Jump_005_578B
    ld a, e
    cp a, $02
    jr c, Jump_005_579E
    ld c, $00
    ret

Jump_005_579E::
    ld c, $FF
    ret

; 7 call sites from 7 routines (e.g. Func_0E2_47CE, Func_0E2_48CF, Func_0E2_491E, Func_0E2_5DBC, ...)
; reads: wBattleActor
Func_005_57A1:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    call ReadWDA53Indexed_Bank05
    cp a, $02
    jr c, Jump_005_57CC
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_57B5::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_57C0
    call Func_005_6D1A
    jr nz, Jump_005_57C6

Jump_005_57C0::
    inc c
    dec b
    jr nz, Jump_005_57B5
    jr Jump_005_57C9

Jump_005_57C6::
    ld c, $00
    ret

Jump_005_57C9::
    ld c, $FF
    ret

Jump_005_57CC::
    ld c, $01
    ret

; 11 call sites from 11 routines (e.g. Func_0E2_411C, Func_0E2_4AB6, Func_0E2_4B6B, Func_0E2_4CA1, ...)
; reads: wBattleActor
; points at: wD812
Func_005_57CF::
    ld a, [wBattleActor]
    call ReadWDA53Indexed_Bank05
    cp a, $03
    jr c, Jump_005_5800
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_57E3::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_57F4
    ld a, c
    ld hl, wD812
    call AddAx9ToHL
    bit 3, [hl]
    jr nz, Jump_005_57FA

Jump_005_57F4::
    inc c
    dec b
    jr nz, Jump_005_57E3
    jr Jump_005_57FD

Jump_005_57FA::
    ld c, $00
    ret

Jump_005_57FD::
    ld c, $FF
    ret

Jump_005_5800::
    ld c, $01
    ret

; 1 call site from 1 routine (e.g. Func_0E2_4279)
; reads: wBattleActor
; points at: wDA75
Func_005_5803:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    call GetBattleMaxHP_Bank05
    ld a, $0A
    call DivideHLByA
    push hl
    ld a, [wBattleActor]
    call GetBattleHP_Bank05
    pop bc
    call CompareHLToBC
    jr c, Jump_005_581D
    jr Jump_005_585A

Jump_005_581D::
    ld a, [wBattleActor]
    ld e, a
    and a, $04
    ld c, a
    ld b, $03

Jump_005_5826::
    ld a, c
    cp a, e
    jr z, Jump_005_5830
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr nc, Jump_005_5836

Jump_005_5830::
    inc c
    dec b
    jr nz, Jump_005_5826
    jr Jump_005_585A

Jump_005_5836::
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_5840::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_5853
    ld a, c
    ld hl, wDA75
    call ReadByteAtHLPlus4APlus3C_Bank05
    and a, $03
    cp a, $02
    jr nc, Jump_005_585A

Jump_005_5853::
    inc c
    dec b
    jr nz, Jump_005_5840
    ld c, $00
    ret

Jump_005_585A::
    ld c, $FF
    ret

; 4 call sites from 4 routines (e.g. Func_0E2_4674, Func_0E2_5BC4, Func_0E2_5C25, Func_0E2_6773)
; reads: wBattleActor, hFFC6, hFFC7
; writes: hFFC6, hFFC7
Func_005_585D:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld e, $00
    xor a, a
    ldh [hFFC6], a
    ldh [hFFC7], a

Jump_005_586E::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_5882
    call GetBattleATK_Bank05
    ldh a, [hFFC6]
    add a, l
    ldh [hFFC6], a
    ldh a, [hFFC7]
    adc a, h
    ldh [hFFC7], a
    inc e

Jump_005_5882::
    inc c
    dec b
    jr nz, Jump_005_586E
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ld a, e
    call DivideHLByA
    add hl, hl
    push hl
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03
    ld e, $00
    xor a, a
    ldh [hFFC6], a
    ldh [hFFC7], a

Jump_005_58A1::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_58B5
    call GetBattleDEF_Bank05
    ldh a, [hFFC6]
    add a, l
    ldh [hFFC6], a
    ldh a, [hFFC7]
    adc a, h
    ldh [hFFC7], a
    inc e

Jump_005_58B5::
    inc c
    dec b
    jr nz, Jump_005_58A1
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ld a, e
    call DivideHLByA
    ld c, l
    ld b, h
    pop hl
    call CompareHLToBC
    jr c, Jump_005_5916
    jr z, Jump_005_5916
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    push hl
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03
    ld e, $00
    xor a, a
    ldh [hFFC6], a
    ldh [hFFC7], a

Jump_005_58E3::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_58F7
    call GetBattleMaxHP_Bank05
    ldh a, [hFFC6]
    add a, l
    ldh [hFFC6], a
    ldh a, [hFFC7]
    adc a, h
    ldh [hFFC7], a
    inc e

Jump_005_58F7::
    inc c
    dec b
    jr nz, Jump_005_58E3
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ld a, e
    srl h
    rr l
    call DivideHLByA
    ld c, l
    ld b, h
    pop hl
    call CompareHLToBC
    jr c, Jump_005_5916
    jr z, Jump_005_5916
    ld c, $00
    ret

Jump_005_5916::
    ld c, $FF
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wD989, wD80D
Func_005_5919:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    call ReadWDA53Indexed_Bank05
    cp a, $03
    jp c, Jump_005_59BA
    ld a, [wBattleActor]
    ld e, a
    and a, $04
    ld c, a
    ld b, $03
    ld d, $00

Jump_005_592F::
    ld a, c
    cp a, e
    jr z, Jump_005_595C
    call CarryUnlessWDA63SlotEmpty
    jr nc, Jump_005_595C
    jr z, Jump_005_595C
    inc d
    inc c
    dec b
    jr nz, Jump_005_592F
    ld a, d
    cp a, $01
    jr nz, Jump_005_59B7
    ld a, [wBattleActor]
    ld e, a
    and a, $04
    ld c, a
    ld b, $03
    ld d, $00
    ld l, $00

Jump_005_5951::
    ld a, c
    cp a, e
    jr z, Jump_005_595C
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_595C
    inc d
    ld l, c

Jump_005_595C::
    inc c
    dec b
    jr nz, Jump_005_5951
    ld a, d
    cp a, $01
    jr nz, Jump_005_59B7
    ld e, l
    ld a, l
    call GetBattleMP_Bank05
    ld a, h
    and a, a
    jr nz, Jump_005_59B7
    ld a, l
    cp a, $14
    jr c, Jump_005_5977
    jr z, Jump_005_5977
    jr Jump_005_59B7

Jump_005_5977::
    ld a, e
    swap a
    ld hl, wD989
    add_a_to_hl
    ld b, $08

Jump_005_5984::
    ld a, [hl+]
    cp a, $A0
    jr z, Jump_005_59B4
    inc hl
    dec b
    jr nz, Jump_005_5984
    ld a, e
    ld hl, wD80D
    call AddAx9ToHL
    bit 0, [hl]
    jr nz, Jump_005_59B7
    ld a, e
    swap a
    ld hl, wD989
    add_a_to_hl
    ld b, $08

Jump_005_59A5::
    ld a, [hl+]
    cp a, $1E
    jr z, Jump_005_59B4
    cp a, $1F
    jr z, Jump_005_59B4
    inc hl
    dec b
    jr nz, Jump_005_59A5
    jr Jump_005_59B7

Jump_005_59B4::
    ld c, $00
    ret

Jump_005_59B7::
    ld c, $FF
    ret

Jump_005_59BA::
    ld c, $01
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wD80D, wD989
Func_005_59BD:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    call ReadWDA53Indexed_Bank05
    cp a, $03
    jr c, Jump_005_5A30
    ld a, [wBattleActor]
    ld e, a
    and a, $04
    ld c, a
    ld b, $03

Jump_005_59D0::
    ld a, c
    cp a, e
    jr z, Jump_005_59D9
    call CheckSlotStatusBlock
    jr nc, Jump_005_59DF

Jump_005_59D9::
    inc c
    dec b
    jr nz, Jump_005_59D0
    jr Jump_005_5A2D

Jump_005_59DF::
    ld a, c
    ld hl, wD80D
    call AddAx9ToHL
    bit 6, [hl]
    jr nz, Jump_005_59D9
    ld a, c
    swap a
    ld hl, wD989
    add_a_to_hl
    ld d, $08

Jump_005_59F7::
    ld a, [hl+]
    cp a, $16
    jr z, Jump_005_5A12
    cp a, $17
    jr z, Jump_005_5A12
    cp a, $18
    jr z, Jump_005_5A12
    cp a, $19
    jr z, Jump_005_5A12
    cp a, $1A
    jr z, Jump_005_5A12
    inc hl
    dec d
    jr nz, Jump_005_59F7
    jr Jump_005_5A2D

Jump_005_5A12::
    ld hl, Func_005_5A33
    sub a, $16
    add_a_to_hl
    ld a, [hl]
    ld d, a
    ld a, c
    call GetBattleMP_Bank05
    ld a, h
    and a, a
    jr nz, Jump_005_59D9
    ld a, l
    cp a, d
    jr nc, Jump_005_59D9
    ld c, $00
    ret

Jump_005_5A2D::
    ld c, $FF
    ret

Jump_005_5A30::
    ld c, $01
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wD80D
Func_005_5A33:: ; heuristic: follows a terminator; C0
    ld [bc], a
    dec b
    rlca
    ld [de], a
    inc h
    ld a, [wBattleActor]
    call ReadWDA53Indexed_Bank05
    cp a, $03
    jr c, Jump_005_5A70
    ld a, [wBattleActor]
    ld e, a
    and a, $04
    ld c, a
    ld b, $03

Jump_005_5A4B::
    ld a, c
    cp a, e
    jr z, Jump_005_5A54
    call CheckSlotStatusBlock
    jr nc, Jump_005_5A5A

Jump_005_5A54::
    inc c
    dec b
    jr nz, Jump_005_5A4B
    jr Jump_005_5A6D

Jump_005_5A5A::
    ld a, c
    ld hl, wD80D
    call AddAx9ToHL
    bit 6, [hl]
    jr nz, Jump_005_5A54
    call Func_005_6D1A
    jr z, Jump_005_5A54
    ld c, $00
    ret

Jump_005_5A6D::
    ld c, $FF
    ret

Jump_005_5A70::
    ld c, $01
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wD989
Func_005_5A73:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    call ReadWDA53Indexed_Bank05
    cp a, $03
    jr c, Jump_005_5AF5
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03

Jump_005_5A85::
    ld a, [wBattleActor]
    ld e, a
    ld a, c
    cp a, e
    jr z, Jump_005_5A92
    call CheckSlotStatusBlock
    jr nc, Jump_005_5A98

Jump_005_5A92::
    inc c
    dec b
    jr nz, Jump_005_5A85
    jr Jump_005_5AF2

Jump_005_5A98::
    ld a, c
    swap a
    ld hl, wD989
    add_a_to_hl
    ld d, $08

Jump_005_5AA5::
    ld a, [hl+]
    ld e, $00
    cp a, $4D
    jr z, Jump_005_5ACB
    inc e
    cp a, $3D
    jr z, Jump_005_5ACB
    inc e
    cp a, $3E
    jr z, Jump_005_5ACB
    inc e
    cp a, $3F
    jr z, Jump_005_5ACB
    inc e
    cp a, $66
    jr z, Jump_005_5ACB
    inc e
    cp a, $67
    jr z, Jump_005_5ACB

Jump_005_5AC5::
    inc hl
    dec d
    jr nz, Jump_005_5AA5
    jr Jump_005_5AF2

Jump_005_5ACB::
    push hl
    push bc
    ld hl, Func_005_5AF8
    ld a, e
    add_a_to_hl
    ld a, [hl]
    push de
    ld d, a
    ld a, c
    call GetBattleMP_Bank05
    ld a, h
    and a, a
    jr nz, Jump_005_5AEA
    ld a, l
    cp a, d
    jr nc, Jump_005_5AEA
    pop de
    pop bc
    pop hl
    jr Jump_005_5AEF

Jump_005_5AEA::
    pop de
    pop bc
    pop hl
    jr Jump_005_5AC5

Jump_005_5AEF::
    ld c, $00
    ret

Jump_005_5AF2::
    ld c, $FF
    ret

Jump_005_5AF5::
    ld c, $01
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wD80D, wD989
Func_005_5AF8:: ; heuristic: follows a terminator; C0
    rrca
    ld bc, $191E
    inc d
    inc d
    ld a, [wBattleActor]
    call ReadWDA53Indexed_Bank05
    cp a, $03
    jr c, Jump_005_5B54
    ld a, [wBattleActor]
    ld e, a
    and a, $04
    ld c, a
    ld b, $03

Jump_005_5B11::
    ld a, c
    cp a, e
    jr z, Jump_005_5B1A
    call CheckSlotStatusBlock
    jr nc, Jump_005_5B20

Jump_005_5B1A::
    inc c
    dec b
    jr nz, Jump_005_5B11
    jr Jump_005_5B51

Jump_005_5B20::
    ld a, c
    ld hl, wD80D
    call AddAx9ToHL
    bit 7, [hl]
    jr nz, Jump_005_5B1A
    ld hl, wD989
    swap a
    add_a_to_hl
    ld d, $08

Jump_005_5B37::
    ld a, [hl+]
    cp a, $42
    jr z, Jump_005_5B4E
    cp a, $43
    jr z, Jump_005_5B4E
    cp a, $46
    jr z, Jump_005_5B4E
    cp a, $47
    jr z, Jump_005_5B4E
    inc hl
    dec d
    jr nz, Jump_005_5B37
    jr Jump_005_5B1A

Jump_005_5B4E::
    ld c, $00
    ret

Jump_005_5B51::
    ld c, $FF
    ret

Jump_005_5B54::
    ld c, $01
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wD80D, wD989
Func_005_5B57:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    call ReadWDA53Indexed_Bank05
    cp a, $03
    jr c, Jump_005_5BB9
    ld a, [wBattleActor]
    ld e, a
    and a, $04
    ld c, a
    ld b, $03

Jump_005_5B6A::
    ld a, c
    cp a, e
    jr z, Jump_005_5B73
    call CheckSlotStatusBlock
    jr nc, Jump_005_5B79

Jump_005_5B73::
    inc c
    dec b
    jr nz, Jump_005_5B6A
    jr Jump_005_5BB6

Jump_005_5B79::
    ld a, c
    ld hl, wD80D
    call AddAx9ToHL
    bit 6, [hl]
    jr z, Jump_005_5B73
    ld hl, wD989
    swap a
    add_a_to_hl
    ld d, $08

Jump_005_5B90::
    ld a, [hl+]
    cp a, $78
    jr z, Jump_005_5BB3
    cp a, $79
    jr z, Jump_005_5BB3
    cp a, $7A
    jr z, Jump_005_5BB3
    cp a, $7B
    jr z, Jump_005_5BB3
    cp a, $7C
    jr z, Jump_005_5BB3
    cp a, $7D
    jr z, Jump_005_5BB3
    cp a, $92
    jr z, Jump_005_5BB3
    inc hl
    dec d
    jr nz, Jump_005_5B90
    jr Jump_005_5B73

Jump_005_5BB3::
    ld c, $00
    ret

Jump_005_5BB6::
    ld c, $FF
    ret

Jump_005_5BB9::
    ld c, $01
    ret

; 1 call site from 1 routine (e.g. Func_0E2_4984)
; reads: wBattleActor, hFFC6, hFFC7, hFFC8, hFFC9, hFFCA, hFFCB, hFFCC, ...
; writes: hFFC6, hFFC7, hFFC8, hFFC9, hFFCA, hFFCB, hFFCC, hFFCD, ...
Func_005_5BBC::
    ld a, [wBattleActor]
    call GetBattleMaxHP_Bank05
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    ld a, [wBattleActor]
    call GetBattleMaxMP_Bank05
    ld a, l
    ldh [hFFC8], a
    ld a, h
    ldh [hFFC9], a
    ld a, [wBattleActor]
    call GetBattleATK_Bank05
    ld a, l
    ldh [hFFCA], a
    ld a, h
    ldh [hFFCB], a
    ld a, [wBattleActor]
    call GetBattleDEF_Bank05
    ld a, l
    ldh [hFFCC], a
    ld a, h
    ldh [hFFCD], a
    ld a, [wBattleActor]
    call GetBattleAGL_Bank05
    ld a, l
    ldh [hFFCE], a
    ld a, h
    ldh [hFFCF], a
    ld e, $00
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ld bc, $03E7
    call CompareHLToBC
    jr c, Jump_005_5C09
    inc e

Jump_005_5C09::
    ldh a, [hFFC8]
    ld l, a
    ldh a, [hFFC9]
    ld h, a
    ld bc, $012C
    call CompareHLToBC
    jr c, Jump_005_5C18
    inc e

Jump_005_5C18::
    ldh a, [hFFCA]
    ld l, a
    ldh a, [hFFCB]
    ld h, a
    ld bc, $012C
    call CompareHLToBC
    jr c, Jump_005_5C27
    inc e

Jump_005_5C27::
    ldh a, [hFFCC]
    ld l, a
    ldh a, [hFFCD]
    ld h, a
    ld bc, $00C8
    call CompareHLToBC
    jr c, Jump_005_5C36
    inc e

Jump_005_5C36::
    ldh a, [hFFCE]
    ld l, a
    ldh a, [hFFCF]
    ld h, a
    ld bc, $011E
    call CompareHLToBC
    jr c, Jump_005_5C45
    inc e

Jump_005_5C45::
    ld a, e
    cp a, $03
    jr c, Jump_005_5C4D
    ld c, $00
    ret

Jump_005_5C4D::
    ld c, $FF
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wD989
Func_005_5C50:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    swap a
    ld hl, wD989
    add_a_to_hl
    ld b, $08

Jump_005_5C5F::
    ld a, [hl+]
    cp a, $83
    jr z, Jump_005_5C89
    inc hl
    dec b
    jr nz, Jump_005_5C5F
    ld a, [wBattleActor]
    and a, $04
    and a, $04
    ld c, a
    ld b, $03

Jump_005_5C72::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_5C80
    call Func_005_6E30
    ld a, d
    cp a, $01
    jr nc, Jump_005_5C86

Jump_005_5C80::
    inc c
    dec b
    jr nz, Jump_005_5C72
    jr Jump_005_5C89

Jump_005_5C86::
    ld c, $00
    ret

Jump_005_5C89::
    ld c, $FF
    ret

; 2 call sites from 2 routines (e.g. Func_0E2_51F6, Func_0E2_526D)
; reads: wBattleActor
; points at: wD2C1
Func_005_5C8C:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_5C96::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_5CC1
    and a, $03
    ld hl, wD2C1
    sla a
    add_a_to_hl
    push bc
    ld a, [hl+]
    ld c, a
    ld a, [hl]
    ld h, a
    ld l, c
    call Func_005_701B
    pop bc
    push bc
    push hl
    ld a, c
    call GetBattleHP_Bank05
    ld c, l
    ld b, h
    pop hl
    call CompareHLToBC
    jr nc, Jump_005_5CC7
    pop bc

Jump_005_5CC1::
    inc c
    dec b
    jr nz, Jump_005_5C96
    jr Jump_005_5CCB

Jump_005_5CC7::
    pop bc
    ld c, $00
    ret

Jump_005_5CCB::
    ld c, $FF
    ret

; 4 call sites from 4 routines (e.g. Func_005_7109, Func_005_70C9, Func_005_7824, Func_0E2_4AB6)
; reads: wCFC5
Func_005_5CCE::
    ld a, [wCFC5]
    cp a, $02
    jr z, Jump_005_5CDB
    cp a, $03
    jr z, Jump_005_5CDB
    jr Jump_005_5CDE

Jump_005_5CDB::
    ld c, $00
    ret

Jump_005_5CDE::
    ld c, $FF
    ret

; 1 call site from 1 routine (e.g. Func_0E2_4A08)
; reads: wC58A
Func_005_5CE1:: ; heuristic: follows a terminator; C0
    ld a, [wC58A]
    and a, a
    jr z, Jump_005_5CEE
    cp a, $02
    jr z, Jump_005_5CEE
    ld c, $00
    ret

Jump_005_5CEE::
    ld c, $FF
    ret

; 2 call sites from 2 routines (e.g. Func_0E2_5AE6, Func_0E2_67D5)
; reads: wBattleActor, wC984, wC985
Func_005_5CF1:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    cp a, $04
    jr nc, Jump_005_5CFD
    ld a, [wC984]
    jr Jump_005_5D00

Jump_005_5CFD::
    ld a, [wC985]

Jump_005_5D00::
    cp a, $01
    jr z, Jump_005_5D1D
    ld a, [wBattleActor]
    ld e, a
    and a, $04
    ld c, a
    ld b, $03

Jump_005_5D0D::
    ld a, c
    cp a, e
    jr z, Jump_005_5D16
    call CarryUnlessWDA63SlotEmpty
    jr nc, Jump_005_5D1D

Jump_005_5D16::
    inc c
    dec b
    jr nz, Jump_005_5D0D
    ld c, $00
    ret

Jump_005_5D1D::
    ld c, $FF
    ret

; 2 call sites from 2 routines (e.g. Func_005_7410, Func_0E2_6249)
; reads: wBattleActor
; points at: wD80E
Func_005_5D20:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03
    ld hl, wD80E
    ld e, $04
    call AnySlotLacksStatusMask
    ret

; 2 call sites from 2 routines (e.g. Func_0E2_4B6B, Func_0E2_5E46)
; reads: wBattleActor
; points at: wD80E
Func_005_5D31:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    and a, $04
    ld c, a
    ld b, $03
    ld hl, wD80E
    ld e, $04
    call AnySlotLacksStatusMask
    ret

; 2 call sites from 2 routines (e.g. Func_0E2_4C49, Func_0E2_4E71)
; reads: wBattleActor
Func_005_5D44:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    call ReadWDA53Indexed_Bank05
    cp a, $03
    jr c, Jump_005_5D86
    ld a, [wBattleActor]
    call GetBattleHP_Bank05
    ld c, l
    ld b, h
    sra h
    rr l
    add hl, bc
    ld d, h
    ld e, l
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_5D67::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_5D7A
    call GetBattleHP_Bank05
    ld a, l
    sub a, e
    ld l, a
    ld a, h
    sbc a, d
    ld h, a
    bit 7, h
    jr z, Jump_005_5D80

Jump_005_5D7A::
    inc c
    dec b
    jr nz, Jump_005_5D67
    jr Jump_005_5D83

Jump_005_5D80::
    ld c, $00
    ret

Jump_005_5D83::
    ld c, $FF
    ret

Jump_005_5D86::
    ld c, $01
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC58A, hFF8C
Func_005_5D89:: ; heuristic: follows a terminator; C0
    ld a, [wC58A]
    or a, a
    jr nz, Jump_005_5D98
    ldh a, [hFF8C]
    bit 3, a
    jr z, Jump_005_5D98
    ld c, $00
    ret

Jump_005_5D98::
    ld c, $FF
    ret

; 3 call sites from 3 routines (e.g. Func_005_7671, Func_005_72DE, Func_005_77F9)
; reads: wBattleActor
; points at: wBattleStatus, wDA74
Func_005_5D9B:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_5DA5::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_5DC3
    ld a, c
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit 7, [hl]
    jr nz, Jump_005_5DC3
    ld a, c
    ld hl, wDA74
    call ReadByteAtHLPlus4APlus3C_Bank05
    and a, $C0
    cp a, $C0
    jr nz, Jump_005_5DCA

Jump_005_5DC3::
    inc c
    dec b
    jr nz, Jump_005_5DA5
    ld c, $00
    ret

Jump_005_5DCA::
    ld c, $FF
    ret

; 3 call sites from 3 routines (e.g. Func_005_791F, Func_005_7AD8, Func_005_7B11)
; reads: wBattleActor
; points at: wD80F, wDA77
Func_005_5DCD:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_5DD7::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_5DF5
    ld a, c
    ld hl, wD80F
    call AddAx9ToHL
    ld a, [hl]
    and a, a
    jr nz, Jump_005_5DF5
    ld a, c
    ld hl, wDA77
    call ReadByteAtHLPlus4APlus3C_Bank05
    and a, $0C
    cp a, $0C
    jr nz, Jump_005_5DFC

Jump_005_5DF5::
    inc c
    dec b
    jr nz, Jump_005_5DD7
    ld c, $00
    ret

Jump_005_5DFC::
    ld c, $FF
    ret

; 1 call site from 1 routine (e.g. Func_005_7A0D)
; reads: wBattleActor
; points at: wDA74, wD814
Func_005_5DFF:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld de, wDA74
    add a, a
    add a, c
    add a, a
    add a, c
    add a, e
    ld e, a
    jr nc, Jump_005_5E15
    inc d

Jump_005_5E15::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_5E2D
    ld a, c
    ld hl, wD814
    call AddAx9ToHL
    bit 7, [hl]
    jr nz, Jump_005_5E2D
    ld a, [de]
    and a, $30
    cp a, $30
    jr nz, Jump_005_5E3C

Jump_005_5E2D::
    ld a, e
    add a, $07
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    inc c
    dec b
    jr nz, Jump_005_5E15
    ld c, $00
    ret

Jump_005_5E3C::
    ld c, $FF
    ret

; 5 call sites from 5 routines (e.g. Func_005_76A3, Func_005_7BEE, Func_005_7C45, Func_005_7D5B, ...)
; reads: wD891
Func_005_5E3F:: ; heuristic: follows a terminator; C0
    ld a, [wD891]
    and a, a
    jr nz, Jump_005_5E48
    ld c, $00
    ret

Jump_005_5E48::
    ld c, $FF
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wD810, wD80F
Func_005_5E4B:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld hl, wD810
    ld e, $0C
    call AnySlotLacksStatusMask
    ld a, c
    or a, a
    ret z
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld hl, wD80F
    ld e, $C0
    call AnySlotLacksStatusMask
    ret

; 1 call site from 1 routine (e.g. Func_005_7370)
; reads: wBattleActor
; points at: wBattleStatus, wDA75
Func_005_5E6F:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_5E79::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_5E97
    ld a, c
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit 4, [hl]
    jr nz, Jump_005_5E97
    ld a, c
    ld hl, wDA75
    call ReadByteAtHLPlus4APlus3C_Bank05
    and a, $C0
    cp a, $C0
    jr nz, Jump_005_5E9E

Jump_005_5E97::
    inc c
    dec b
    jr nz, Jump_005_5E79
    ld c, $00
    ret

Jump_005_5E9E::
    ld c, $FF
    ret

; 1 call site from 1 routine (e.g. Func_0E2_5529)
; reads: wBattleActor
; points at: wBattleStatus
Func_005_5EA1:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_5EAB::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_5EC4
    ld a, c
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_005_5ECB
    inc hl
    inc hl
    ld a, [hl]
    and a, $3F
    jr nz, Jump_005_5ECB

Jump_005_5EC4::
    inc c
    dec b
    jr nz, Jump_005_5EAB
    ld c, $FF
    ret

Jump_005_5ECB::
    ld c, $00
    ret

; 1 call site from 1 routine (e.g. Func_0E2_67F9)
; reads: wBattleActor, wD2CC
; points at: wDA5B
Func_005_5ECE::
    ld a, [wBattleActor]
    call ReadWDA53Indexed_Bank05
    cp a, $04
    jr c, Jump_005_5F10
    ld a, [wD2CC]
    or a, a
    jr z, Jump_005_5F0A
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld de, wDA5B
    add a, e
    ld e, a
    jr nc, Jump_005_5EED
    inc d

Jump_005_5EED::
    ld c, a
    ld b, $03

Jump_005_5EF0::
    ld a, c
    call CheckSlotStatusBlock
    jr c, Jump_005_5F05
    ld a, [de]
    cp a, $02
    jr nz, Jump_005_5F05
    call Func_005_5F13
    jr nz, Jump_005_5F05
    call WDA77EntryHasBits2And3_Bank05_5F2A
    jr nz, Jump_005_5F0D

Jump_005_5F05::
    inc de
    inc c
    dec b
    jr nz, Jump_005_5EF0

Jump_005_5F0A::
    ld c, $FF
    ret

Jump_005_5F0D::
    ld c, $00
    ret

Jump_005_5F10::
    ld c, $01
    ret

; 1 call site from 1 routine (e.g. Func_005_5ECE)
; points at: wBattleActionChoice
Func_005_5F13::
    ld a, c
    ld hl, wBattleActionChoice
    add a, a
    add_a_to_hl
    ld a, [hl]
    cp a, $9C
    ret z
    cp a, $33
    ret z
    cp a, $92
    ret z
    cp a, $93
    ret

; C = index: Z set when bits 2 and 3 are both set in the byte at wDA77 + 7 * C (7-byte entries); A = that byte & $0C; HL points at it (E-0065) (the same 19 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. Func_005_5ECE)
; points at: wDA77
WDA77EntryHasBits2And3_Bank05_5F2A::
Func_005_5F2A:: ; address name
    ld a, c
    ld hl, wDA77
    add a, a
    add a, c
    add a, a
    add a, c
    add_a_to_hl
    ld a, [hl]
    and a, $0C
    cp a, $0C
    ret

; 2 call sites from 2 routines (e.g. Func_0E2_45FE, Func_0E2_4619)
; reads: wBattleActor, wD2CC
; points at: wD80D, wDA5B
Func_005_5F3D:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    call ReadWDA53Indexed_Bank05
    cp a, $04
    jr c, Jump_005_5F8A
    ld a, [wD2CC]
    or a, a
    jr z, Jump_005_5F84
    ld a, [wBattleActor]
    ld d, a
    and a, $04
    ld c, a
    ld b, $03

Jump_005_5F56::
    ld a, c
    cp a, d
    jr z, Jump_005_5F80
    ld a, c
    call CheckSlotStatusBlock
    jr c, Jump_005_5F80
    ld a, c
    ld hl, wD80D
    call AddAx9ToHL
    bit 2, [hl]
    jr nz, Jump_005_5F80
    ld a, c
    ld hl, wDA5B
    add_a_to_hl
    ld a, [hl]
    cp a, $03
    jr nc, Jump_005_5F80
    push de
    call Func_005_5F8D
    pop de
    jr nc, Jump_005_5F87

Jump_005_5F80::
    inc c
    dec b
    jr nz, Jump_005_5F56

Jump_005_5F84::
    ld c, $FF
    ret

Jump_005_5F87::
    ld c, $00
    ret

Jump_005_5F8A::
    ld c, $01
    ret

; 1 call site from 1 routine (e.g. Func_005_5F3D)
; points at: wD989, wBattleMP
Func_005_5F8D::
    ld a, c
    ld hl, wD989
    swap a
    add_a_to_hl
    ld e, $08

Jump_005_5F9A::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_005_5FAB
    cp a, $63
    jr z, Jump_005_5FAD
    cp a, $64
    jr z, Jump_005_5FB1

Jump_005_5FA7::
    inc hl
    dec e
    jr nz, Jump_005_5F9A

Jump_005_5FAB::
    scf
    ret

Jump_005_5FAD::
    ld d, $03
    jr Jump_005_5FB3

Jump_005_5FB1::
    ld d, $06

Jump_005_5FB3::
    push hl
    ld a, c
    ld hl, wBattleMP
    add a, a
    add_a_to_hl
    ld a, [hl+]
    sub a, d
    ld a, [hl]
    sbc a, $00
    pop hl
    jr c, Jump_005_5FA7
    ret

; 1 call site from 1 routine (e.g. Func_0E2_67F9)
; reads: wBattleActor, wD2CC
; points at: wDA5B
Func_005_5FC7::
    ld a, [wBattleActor]
    call ReadWDA53Indexed_Bank05
    cp a, $04
    jr c, Jump_005_600B
    ld a, [wD2CC]
    or a, a
    jr z, Jump_005_6005
    ld a, [wBattleActor]
    ld d, a
    and a, $04
    ld c, a
    ld b, $03

Jump_005_5FE0::
    ld a, c
    cp a, d
    jr z, Jump_005_6001
    call CheckSlotStatusBlock
    jr c, Jump_005_6001
    ld a, c
    ld hl, wDA5B
    add_a_to_hl
    ld a, [hl]
    cp a, $03
    jr nc, Jump_005_6001
    call Func_005_600E
    jr c, Jump_005_6001
    call WDA77EntryHasBits2And3_Bank05
    jr nz, Jump_005_6008

Jump_005_6001::
    inc c
    dec b
    jr nz, Jump_005_5FE0

Jump_005_6005::
    ld c, $FF
    ret

Jump_005_6008::
    ld c, $00
    ret

Jump_005_600B::
    ld c, $01
    ret

; 1 call site from 1 routine (e.g. Func_005_5FC7)
; points at: wBattleMP, wD989
Func_005_600E::
    ld a, c
    ld hl, wBattleMP
    add a, a
    add_a_to_hl
    ld a, [hl+]
    sub a, $03
    ld a, [hl]
    sbc a, $00
    ret c
    ld a, c
    ld hl, wD989
    swap a
    add_a_to_hl
    ld e, $08

Jump_005_602C::
    ld a, [hl+]
    cp a, $6B
    jr z, Jump_005_6037
    inc hl
    dec e
    jr nz, Jump_005_602C
    dec e
    ret

Jump_005_6037::
    xor a, a
    ret

; C = index: Z set when bits 2 and 3 are both set in the byte at wDA77 + 7 * C (7-byte entries); A = that byte & $0C; HL points at it (E-0065) (the same 19 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. Func_005_5FC7)
; points at: wDA77
WDA77EntryHasBits2And3_Bank05::
Func_005_6039:: ; address name
    ld a, c
    ld hl, wDA77
    add a, a
    add a, c
    add a, a
    add a, c
    add_a_to_hl
    ld a, [hl]
    and a, $0C
    cp a, $0C
    ret

; 2 call sites from 2 routines (e.g. Func_0E2_51DB, Func_0E2_51F6)
; reads: wBattleActor
; points at: wBattleHP, wBattleMaxHP, wSlotPersonalityLo
Func_005_604C:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    call ReadWDA53Indexed_Bank05
    cp a, $04
    jr c, Jump_005_60B7
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_6060::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_6087
    ld a, c
    ld hl, wBattleHP
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    sla e
    rl d
    ld a, c
    ld hl, wBattleMaxHP
    add a, a
    add_a_to_hl
    ld a, [hl+]
    sub a, e
    ld a, [hl]
    sbc a, d
    jr nc, Jump_005_608D

Jump_005_6087::
    inc c
    dec b
    jr nz, Jump_005_6060
    jr Jump_005_60B1

Jump_005_608D::
    ld a, c
    and a, $04
    ld c, a
    ld b, $03

Jump_005_6093::
    ld a, c
    call CheckSlotStatusBlock
    jr c, Jump_005_60AD
    ld hl, wSlotPersonalityLo
    add_a_to_hl
    ld a, [hl]
    cp a, $C0
    jr c, Jump_005_60AD
    push bc
    call Func_005_60BA
    pop bc
    jr nc, Jump_005_60B4

Jump_005_60AD::
    inc c
    dec b
    jr nz, Jump_005_6093

Jump_005_60B1::
    ld c, $FF
    ret

Jump_005_60B4::
    ld c, $00
    ret

Jump_005_60B7::
    ld c, $01
    ret

; 1 call site from 1 routine (e.g. Func_005_604C)
; reads: wQueuedActionId
; points at: wBattleTargetChoice, wBattleMP
Func_005_60BA::
    ld a, c
    ld hl, wBattleTargetChoice
    swap a
    add_a_to_hl
    ld b, $08

Jump_005_60C7::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_005_60ED
    ld e, a
    cp a, $16
    jr c, Jump_005_60E9
    ld d, $1B
    cp a, $1B
    jr c, Jump_005_60EF
    ld d, $05
    cp a, $7B
    jr z, Jump_005_60FA
    ld d, $06
    cp a, $7C
    jr z, Jump_005_60FA
    ld d, $07
    cp a, $A1
    jr z, Jump_005_6101

Jump_005_60E9::
    inc hl
    dec b
    jr nz, Jump_005_60C7

Jump_005_60ED::
    scf
    ret

Jump_005_60EF::
    push hl
    call Func_005_6127
    pop hl
    jr nz, Jump_005_60E9
    ld a, e
    sub a, d
    jr Jump_005_6102

Jump_005_60FA::
    push hl
    call Func_005_6141
    pop hl
    jr nz, Jump_005_60E9

Jump_005_6101::
    ld a, d

Jump_005_6102::
    ld d, a
    ld a, [wQueuedActionId]
    cp a, e
    jr z, Jump_005_60E9
    ld a, d
    push hl
    ld hl, Data_005_614B
    add_a_to_hl
    ld d, [hl]
    ld a, c
    ld hl, wBattleMP
    add a, a
    add_a_to_hl
    ld a, [hl+]
    sub a, d
    ld a, [hl]
    sbc a, $00
    pop hl
    jr c, Jump_005_60E9
    ret

; 1 call site from 1 routine (e.g. Func_005_60BA)
; points at: wD80D, wD80A
Func_005_6127::
    ld a, c
    ld hl, wD80D
    call AddAx9ToHL
    bit 0, [hl]
    ret nz
    ld a, c
    rrca
    rrca
    and a, $01
    ld hl, wD80A
    add_a_to_hl
    bit 3, [hl]
    ret

; 1 call site from 1 routine (e.g. Func_005_60BA)
; points at: wD80D
Func_005_6141::
    ld a, c
    ld hl, wD80D
    call AddAx9ToHL
    bit 6, [hl]
    ret

Data_005_614B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $02, $05, $07, $12, $24, $01, $0C, $1C

; 3 call sites from 3 routines (e.g. Func_0E2_41C5, Func_0E2_41E0, Func_0E2_59E5)
; reads: wBattleActor
; points at: wD80E, wDA74
Func_005_6153::
    ld a, [wBattleActor]
    call ReadWDA53Indexed_Bank05
    cp a, $04
    jr c, Jump_005_6195
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_6167::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_618B
    ld a, c
    ld hl, wD80E
    call AddAx9ToHL
    ld a, [hl]
    and a, $2A
    jr nz, Jump_005_618B
    ld a, c
    ld hl, wDA74
    add a, a
    add a, c
    add a, a
    add a, c
    add_a_to_hl
    ld a, [hl]
    and a, $30
    jr z, Jump_005_6192

Jump_005_618B::
    inc c
    dec b
    jr nz, Jump_005_6167
    ld c, $FF
    ret

Jump_005_6192::
    ld c, $00
    ret

Jump_005_6195::
    ld c, $01
    ret

; 7 call sites from 7 routines (e.g. Func_005_76A3, Func_005_7397, Func_005_7BEE, Func_005_7C45, ...)
; reads: wBattleActor, wD2CC
Func_005_6198:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    call ReadWDA53Indexed_Bank05
    cp a, $03
    jr c, Jump_005_61AE
    ld a, [wD2CC]
    or a, a
    jr nz, Jump_005_61AB
    ld c, $FF
    ret

Jump_005_61AB::
    ld c, $00
    ret

Jump_005_61AE::
    ld c, $01
    ret

; 1 call site from 1 routine (e.g. Func_005_7CC2)
; reads: wBattleActor
; points at: wD80E
Func_005_61B1:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    ld hl, wD80E
    call AddAx9ToHL
    bit 3, [hl]
    jr nz, Jump_005_61C1
    ld c, $FF
    ret

Jump_005_61C1::
    ld c, $00
    ret
    INCBIN "dwm2-cobi-us.gbc", $0161C4, $65

; 1 call site from 1 routine (e.g. Func_005_7879)
; reads: wBattleActor
; points at: wBattleStatus
Func_005_6229::
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld hl, wBattleStatus
    ld e, $20
    ld b, $03
    call AnySlotLacksStatusMask
    ret

; 1 call site from 1 routine (e.g. Func_005_7AA4)
; reads: wBattleActor, wRecordBuffer
; writes: wRecordBuffer
; points at: wD988
Func_005_623B:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    swap a
    ld hl, wD988
    add_a_to_hl
    ld b, $08
    ld a, [wRecordBuffer]
    push af
    ld d, $02

Jump_005_6250::
    inc hl
    ld a, [hl+]
    ld [wRecordBuffer], a
    call Func_005_6C02
    jr nz, Jump_005_6264
    dec b
    jr nz, Jump_005_6250
    pop af
    ld [wRecordBuffer], a
    ld c, $00
    ret

Jump_005_6264::
    pop af
    ld [wRecordBuffer], a
    ld c, $FF
    ret

; 3 call sites from 3 routines (e.g. Func_005_715F, Func_005_7975, Func_005_7DC2)
; reads: wBattleActor
Func_005_626B::
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03

Jump_005_6273::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr nc, Jump_005_627F

Jump_005_6279::
    inc c
    dec b
    jr nz, Jump_005_6273
    jr Jump_005_6292

Jump_005_627F::
    push bc
    ld a, c
    call Func_005_6298
    push hl
    ld a, c
    call GetBattleHP_Bank05
    pop bc
    call CompareHLToBC
    pop bc
    jr c, Jump_005_6295
    jr Jump_005_6279

Jump_005_6292::
    ld c, $00
    ret

Jump_005_6295::
    ld c, $FF
    ret

; 1 call site from 1 routine (e.g. Func_005_626B)
; reads: wRecordBuffer
Func_005_6298::
    push bc
    call GetBattleMaxHP_Bank05
    ld a, [wRecordBuffer]
    cp a, $16
    jr z, Jump_005_62BB
    cp a, $17
    jr z, Jump_005_62CC
    cp a, $18
    jr z, Jump_005_62D9
    cp a, $19
    jr z, Jump_005_62CC
    cp a, $1A
    jr z, Jump_005_62D9
    cp a, $7C
    jr z, Jump_005_62CC
    cp a, $A1
    jr z, Jump_005_62CC

Jump_005_62BB::
    push hl
    ld a, $0A
    call DivideHLByA
    ld b, h
    ld c, l
    pop hl
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    pop bc
    ret

Jump_005_62CC::
    srl h
    rr l
    ld b, h
    ld c, l
    srl h
    rr l
    add hl, bc
    pop bc
    ret

Jump_005_62D9::
    ld a, $03
    call DivideHLByA
    add hl, hl
    pop bc
    ret

; 1 call site from 1 routine (e.g. Func_005_7187)
; reads: wBattleActor
Func_005_62E1:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    ld e, a
    and a, $04
    ld c, a
    ld b, $03

Jump_005_62EA::
    ld a, c
    cp a, e
    jr z, Jump_005_62F3
    call CarryUnlessWDA63SlotEmpty
    jr nc, Jump_005_62F9

Jump_005_62F3::
    inc c
    dec b
    jr nz, Jump_005_62EA
    jr Jump_005_630C

Jump_005_62F9::
    push bc
    ld a, c
    call GetBattleMP_Bank05
    push hl
    ld a, c
    call GetBattleMaxMP_Bank05
    pop bc
    call CompareHLToBC
    pop bc
    jr c, Jump_005_630F
    jr Jump_005_62F3

Jump_005_630C::
    ld c, $00
    ret

Jump_005_630F::
    ld c, $FF
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: hFFC6
Func_005_6312:: ; heuristic: follows a terminator; C0
    ldh a, [hFFC6]
    call GetBattleMaxMP_Bank05
    add hl, hl
    ld a, $03
    call DivideHLByA
    push hl
    ldh a, [hFFC6]
    call GetBattleMP_Bank05
    pop bc
    push hl
    call CompareHLToBC
    jr nc, Jump_005_637A
    ldh a, [hFFC6]
    call GetBattleMaxMP_Bank05
    srl h
    rr l
    push hl
    pop bc
    pop hl
    push hl
    call CompareHLToBC
    jr nc, Jump_005_637E
    ldh a, [hFFC6]
    call GetBattleMaxMP_Bank05
    ld a, $03
    call DivideHLByA
    push hl
    pop bc
    pop hl
    push hl
    call CompareHLToBC
    jr nc, Jump_005_6382
    ldh a, [hFFC6]
    call GetBattleMaxMP_Bank05
    srl h
    rr l
    srl h
    rr l
    push hl
    pop bc
    pop hl
    push hl
    call CompareHLToBC
    jr nc, Jump_005_6386
    ldh a, [hFFC6]
    call GetBattleMaxMP_Bank05
    ld a, $0A
    call DivideHLByA
    push hl
    pop bc
    pop hl
    push hl
    call CompareHLToBC
    jr nc, Jump_005_638A
    jr Jump_005_638E

Jump_005_637A::
    pop hl
    ld c, $00
    ret

Jump_005_637E::
    pop hl
    ld c, $01
    ret

Jump_005_6382::
    pop hl
    ld c, $02
    ret

Jump_005_6386::
    pop hl
    ld c, $03
    ret

Jump_005_638A::
    pop hl
    ld c, $04
    ret

Jump_005_638E::
    pop hl
    ld c, $05
    ret

; 1 call site from 1 routine (e.g. Func_0E2_4A08)
; reads: wBattleActor
Func_005_6392:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    call ReadWDA53Indexed_Bank05
    cp a, $03
    jr c, Jump_005_63CF
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_63A6::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr nc, Jump_005_63B2

Jump_005_63AC::
    inc c
    dec b
    jr nz, Jump_005_63A6
    jr Jump_005_63C9

Jump_005_63B2::
    push bc
    ld a, c
    call GetBattleHP_Bank05
    push hl
    ld a, c
    call GetBattleDEF_Bank05
    pop bc
    add hl, bc
    ld bc, $0578
    call CompareHLToBC
    pop bc
    jr nc, Jump_005_63CC
    jr Jump_005_63AC

Jump_005_63C9::
    ld c, $00
    ret

Jump_005_63CC::
    ld c, $FF
    ret

Jump_005_63CF::
    ld c, $01
    ret

; 3 call sites from 3 routines (e.g. Func_005_7BBE, Func_005_7C82, Func_005_7CA2)
; reads: wRecordBuffer, wBattleActor
; writes: wRecordBuffer
; points at: wD80D
Func_005_63D2:: ; heuristic: follows a terminator; C0
    ld a, [wRecordBuffer]
    push af
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld d, $10

Jump_005_63E2::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_63F8
    ld a, c
    ld hl, wD80D
    call AddAx9ToHL
    bit 7, [hl]
    jr nz, Jump_005_63F8
    call Func_005_640A
    jr nz, Jump_005_6403

Jump_005_63F8::
    inc c
    dec b
    jr nz, Jump_005_63E2
    pop af
    ld [wRecordBuffer], a
    ld c, $00
    ret

Jump_005_6403::
    pop af
    ld [wRecordBuffer], a
    ld c, $FF
    ret

; 1 call site from 1 routine (e.g. Func_005_63D2)
; reads: hFFC6
; writes: wD868, wD869, wD86A, wD86B, wRecordBuffer
; points at: hFFC6, wD989
Func_005_640A::
    push bc
    ld a, $05
    ld [wD868], a
    ld a, $01
    ld [wD869], a
    ld hl, hFFC6
    ld a, l
    ld [wD86A], a
    ld a, h
    ld [wD86B], a
    ld a, c
    ld hl, wD989
    swap a
    add_a_to_hl
    ld b, $08
    ld c, d

Jump_005_642E::
    ld a, [hl]
    cp a, $89
    jr z, Jump_005_6449
    cp a, $9D
    jr z, Jump_005_6449
    push bc
    push hl
    ld [wRecordBuffer], a
    farcall LoadSkillRecordPart
    pop hl
    pop bc
    ldh a, [hFFC6]
    and a, c
    jr nz, Jump_005_644F

Jump_005_6449::
    inc hl
    inc hl
    dec b
    jr nz, Jump_005_642E
    xor a, a

Jump_005_644F::
    ld d, c
    pop bc
    ret

; 10 call sites from 10 routines (e.g. Func_005_7397, Func_005_791F, Func_005_7BE6, Func_005_7C69, ...)
; reads: wBattleActor, wC984, wC985
Func_005_6452:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    cp a, $04
    jr nc, Jump_005_645E
    ld a, [wC984]
    jr Jump_005_6461

Jump_005_645E::
    ld a, [wC985]

Jump_005_6461::
    cp a, $01
    jr z, Jump_005_647B
    ld a, [wBattleActor]
    ld e, a
    and a, $04
    ld c, a
    ld b, $03

Jump_005_646E::
    ld a, c
    cp a, e
    jr z, Jump_005_6477
    call CarryUnlessWDA63SlotEmpty
    jr nc, Jump_005_647E

Jump_005_6477::
    inc c
    dec b
    jr nz, Jump_005_646E

Jump_005_647B::
    ld c, $00
    ret

Jump_005_647E::
    ld c, $FF
    ret

; 5 call sites from 5 routines (e.g. Func_005_74B5, Func_0E2_4001, Func_0E2_4F30, Func_0E2_4FE1, ...)
; reads: wC58A, wCFC5
Func_005_6481::
    ld a, [wC58A]
    or a, a
    jr nz, Jump_005_6491
    ld a, [wCFC5]
    cp a, $02
    jr nc, Jump_005_6491
    ld c, $00
    ret

Jump_005_6491::
    ld c, $FF
    ret

; 4 call sites from 4 routines (e.g. Func_0E2_4001, Func_0E2_4F30, Func_0E2_4FE1, Func_0E2_511C)
; reads: wBattleActor
; points at: wD2C1
Func_005_6494::
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_649E::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_64C1
    push bc
    ld a, c
    and a, $03
    ld hl, wD2C1
    add a, a
    add_a_to_hl
    deref_hl
    add hl, hl
    add hl, hl
    push hl
    call GetBattleHP_Bank05
    pop bc
    call CompareHLToBC
    pop bc
    jr c, Jump_005_64C6

Jump_005_64C1::
    dec b
    jr nz, Jump_005_649E
    jr Jump_005_64C9

Jump_005_64C6::
    ld c, $00
    ret

Jump_005_64C9::
    ld c, $FF
    ret

; 3 call sites from 3 routines (e.g. Func_0E2_4001, Func_0E2_4CE6, Func_0E2_511C)
; reads: wC58A, wBattleActor
Func_005_64CC::
    ld a, [wC58A]
    or a, a
    jr nz, Jump_005_64DC
    ld a, [wBattleActor]
    cp a, $04
    jr c, Jump_005_64DC
    ld c, $00
    ret

Jump_005_64DC::
    ld c, $FF
    ret

; 1 call site from 1 routine (e.g. Func_005_7D95)
; reads: wBattleActor
Func_005_64DF:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    call GetBattleMaxHP_Bank05
    ld a, $03
    call DivideHLByA
    add hl, hl
    push hl
    ld a, [wBattleActor]
    call GetBattleHP_Bank05
    pop bc
    call CompareHLToBC
    jr c, Jump_005_64FB
    ld c, $00
    ret

Jump_005_64FB::
    ld c, $FF
    ret

; 21 call sites from 21 routines (e.g. Func_0E2_411C, Func_0E2_41E0, Func_0E2_4279, Func_0E2_449C, ...)
; reads: wBattleActor, wCFEF, hFFC6
; writes: hFFC6, hFFC7
; points at: wDA72
Func_005_64FE:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    call ReadWDA53Indexed_Bank05
    cp a, $02
    jr c, Jump_005_6553
    ld a, [wCFEF]
    or a, a
    jr z, Jump_005_6550
    dec a
    ld hl, Data_005_6F6B
    add a, a
    add_a_to_hl
    ld d, [hl]
    inc hl
    ld e, [hl]
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld hl, wDA72
    add a, a
    add a, c
    add a, a
    add a, c
    add a, d
    add_a_to_hl
    xor a, a
    ldh [hFFC6], a
    ldh [hFFC7], a

Jump_005_6537::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_6549
    ldh a, [hFFC6]
    inc a
    ldh [hFFC6], a
    call Func_005_6C86
    cp a, $03
    jr z, Jump_005_654D

Jump_005_6549::
    inc c
    dec b
    jr nz, Jump_005_6537

Jump_005_654D::
    ld c, $00
    ret

Jump_005_6550::
    ld c, $FF
    ret

Jump_005_6553::
    ld c, $01
    ret

; 5 call sites from 5 routines (e.g. Func_0E2_4310, Func_0E2_438D, Func_0E2_5B3D, Func_0E2_6303, ...)
; reads: wBattleActor
; points at: wD988
Func_005_6556:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    call ReadWDA53Indexed_Bank05_4024
    cp a, $03
    jr c, Jump_005_65A9
    ld a, [wBattleActor]
    ld hl, wD988
    swap a
    add_a_to_hl
    ld b, $08
    call Func_005_65AC
    jr nz, Jump_005_65A9
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03
    ld e, $00

Jump_005_657E::
    push bc
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_6599
    ld a, c
    call GetBattleMaxHP_Bank05
    srl h
    rr l
    push hl
    ld a, c
    call GetBattleHP_Bank05
    pop bc
    call CompareHLToBC
    jr nc, Jump_005_6599
    inc e

Jump_005_6599::
    pop bc
    inc c
    dec b
    jr nz, Jump_005_657E
    ld a, e
    cp a, $02
    jr c, Jump_005_65A6
    ld c, $00
    ret

Jump_005_65A6::
    ld c, $FF
    ret

Jump_005_65A9::
    ld c, $01
    ret

; 1 call site from 1 routine (e.g. Func_005_6556)
Func_005_65AC::
    inc hl
    ld a, [hl+]
    cp a, $19
    ret z
    cp a, $1A
    ret z
    cp a, $7C
    ret z
    cp a, $A1
    ret z
    dec b
    jr nz, Func_005_65AC
    ld a, $01
    or a, a
    ret

; 1 call site from 1 routine (e.g. Func_0E2_678C)
; reads: wBattleActor, hFFC6, hFFC7
; writes: hFFC6, hFFC7
Func_005_65C1:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03
    ld e, $00
    xor a, a
    ldh [hFFC6], a
    ldh [hFFC7], a

Jump_005_65D0::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_65E4
    call GetBattleATK_Bank05
    ldh a, [hFFC6]
    add a, l
    ldh [hFFC6], a
    ldh a, [hFFC7]
    adc a, h
    ldh [hFFC7], a
    inc e

Jump_005_65E4::
    inc c
    dec b
    jr nz, Jump_005_65D0
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ld a, e
    call DivideHLByA
    add hl, hl
    push hl
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld e, $00
    xor a, a
    ldh [hFFC6], a
    ldh [hFFC7], a

Jump_005_6605::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_6619
    call GetBattleDEF_Bank05
    ldh a, [hFFC6]
    add a, l
    ldh [hFFC6], a
    ldh a, [hFFC7]
    adc a, h
    ldh [hFFC7], a
    inc e

Jump_005_6619::
    inc c
    dec b
    jr nz, Jump_005_6605
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ld a, e
    call DivideHLByA
    ld c, l
    ld b, h
    pop hl
    call CompareHLToBC
    jr c, Jump_005_667C
    jr z, Jump_005_667C
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    push hl
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld e, $00
    xor a, a
    ldh [hFFC6], a
    ldh [hFFC7], a

Jump_005_6649::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_665D
    call GetBattleHP_Bank05
    ldh a, [hFFC6]
    add a, l
    ldh [hFFC6], a
    ldh a, [hFFC7]
    adc a, h
    ldh [hFFC7], a
    inc e

Jump_005_665D::
    inc c
    dec b
    jr nz, Jump_005_6649
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ld a, e
    srl h
    rr l
    call DivideHLByA
    ld c, l
    ld b, h
    pop hl
    call CompareHLToBC
    jr c, Jump_005_667C
    jr z, Jump_005_667C
    ld c, $00
    ret

Jump_005_667C::
    ld c, $FF
    ret

; 4 call sites from 4 routines (e.g. Func_0E2_43C8, Func_0E2_43E9, Func_0E2_5AE6, Func_0E2_6350)
; reads: wBattleActor, hFFC6, hFFC7, hFFC8, hFFC9, hFFCA
; writes: hFFC6, hFFC7, hFFC8, hFFC9, hFFCA
; points at: wD988
Func_005_667F:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    call ReadWDA53Indexed_Bank05_4024
    cp a, $04
    jp c, Jump_005_671D
    ld a, [wBattleActor]
    ld hl, wD988
    swap a
    add_a_to_hl
    ld b, $08
    call Func_005_6720
    jr nz, Jump_005_671D
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03
    ld d, $00
    xor a, a
    ldh [hFFC6], a
    ldh [hFFC7], a
    ldh [hFFC8], a

Jump_005_66AF::
    push bc
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr nc, Jump_005_66BB
    jr z, Jump_005_66BB
    call Func_005_6741

Jump_005_66BB::
    pop bc
    inc c
    dec b
    jr nz, Jump_005_66AF
    ld a, d
    or a, a
    jr z, Jump_005_6717
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ldh a, [hFFC8]
    ld e, a
    ld a, d
    call Divide24ByA
    ld a, l
    ldh [hFFC9], a
    ld a, h
    ldh [hFFCA], a
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03
    ld d, $00
    xor a, a
    ldh [hFFC6], a
    ldh [hFFC7], a
    ldh [hFFC8], a

Jump_005_66E8::
    push bc
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_66F2
    call Func_005_6741

Jump_005_66F2::
    pop bc
    inc c
    dec b
    jr nz, Jump_005_66E8
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ldh a, [hFFC8]
    ld e, a
    ld a, d
    call Divide24ByA
    srl h
    rr l
    srl h
    rr l
    ldh a, [hFFC9]
    ld c, a
    ldh a, [hFFCA]
    ld b, a
    call Func_000_3E80
    jr c, Jump_005_671A

Jump_005_6717::
    ld c, $00
    ret

Jump_005_671A::
    ld c, $FF
    ret

Jump_005_671D::
    ld c, $01
    ret

; 1 call site from 1 routine (e.g. Func_005_667F)
Func_005_6720::
    inc hl
    ld a, [hl+]
    cp a, $16
    ret z
    cp a, $17
    ret z
    cp a, $18
    ret z
    cp a, $19
    ret z
    cp a, $1A
    ret z
    cp a, $7C
    ret z
    cp a, $9F
    ret z
    cp a, $A1
    ret z
    dec b
    jr nz, Func_005_6720
    ld a, $01
    or a, a
    ret

; 2 call sites from 1 routine (e.g. Func_005_667F)
; reads: hFFC6, hFFC7, hFFC8
; writes: hFFC6, hFFC7, hFFC8
Func_005_6741::
    push de
    ld a, c
    call GetBattleMaxHP_Bank05
    push hl
    ld a, c
    call GetBattleMaxMP_Bank05
    pop de
    add hl, de
    push hl
    ld a, c
    call GetBattleATK_Bank05
    pop de
    add hl, de
    push hl
    ld a, c
    call GetBattleDEF_Bank05
    pop de
    add hl, de
    pop de
    ldh a, [hFFC6]
    add a, l
    ldh [hFFC6], a
    ldh a, [hFFC7]
    adc a, h
    ldh [hFFC7], a
    ldh a, [hFFC8]
    adc a, $00
    ldh [hFFC8], a
    inc d
    ret

; 1 call site from 1 routine (e.g. Func_0E2_526D)
; reads: wBattleActor
; points at: wD2C1
Func_005_676E:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_6778::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_67A6
    push bc
    ld a, c
    and a, $03
    add a, a
    ld hl, wD2C1
    add_a_to_hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld a, $78
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    pop bc
    push bc
    push hl
    ld a, c
    call GetBattleHP_Bank05
    pop bc
    call CompareHLToBC
    pop bc
    jr c, Jump_005_67AC

Jump_005_67A6::
    inc c
    dec b
    jr nz, Jump_005_6778
    jr Jump_005_67AF

Jump_005_67AC::
    ld c, $00
    ret

Jump_005_67AF::
    ld c, $FF
    ret

; 1 call site from 1 routine (e.g. Func_0E2_56C6)
; reads: wBattleActor
; points at: wD2C1
Func_005_67B2:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    call ReadWDA53Indexed_Bank05_4024
    cp a, $02
    jr c, Jump_005_681D
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld e, $00
    ld d, $00

Jump_005_67CA::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_67D2
    ld e, c
    inc d

Jump_005_67D2::
    inc c
    dec b
    jr nz, Jump_005_67CA
    ld a, d
    cp a, $02
    jr c, Jump_005_681A
    ld a, [wBattleActor]
    call GetBattleAGL_Bank05
    ld a, e
    push de
    push hl
    call GetBattleAGL_Bank05
    ld a, $78
    ld b, h
    ld c, l
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    pop bc
    call CompareHLToBC
    pop de
    jr nc, Jump_005_681A
    ld a, e
    and a, $03
    add a, a
    ld hl, wD2C1
    add_a_to_hl
    deref_hl
    add hl, hl
    push hl
    ld a, e
    call GetBattleHP_Bank05
    pop bc
    call CompareHLToBC
    jr c, Jump_005_6817
    jr nz, Jump_005_681A

Jump_005_6817::
    ld c, $00
    ret

Jump_005_681A::
    ld c, $FF
    ret

Jump_005_681D::
    ld c, $01
    ret

; 1 call site from 1 routine (e.g. Func_0E2_57A9)
; reads: wBattleActor, wCFEF
; points at: wDA72
Func_005_6820:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    call ReadWDA53Indexed_Bank05_4024
    cp a, $02
    jr c, Jump_005_6899
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld e, $00
    ld d, $00

Jump_005_6838::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_6840
    ld e, c
    inc d

Jump_005_6840::
    inc c
    dec b
    jr nz, Jump_005_6838
    ld a, d
    cp a, $02
    jr c, Jump_005_6896
    ld c, e
    ld a, [wCFEF]
    or a, a
    jr z, Jump_005_6896
    push de
    dec a
    ld hl, Data_005_6F6B
    add a, a
    add_a_to_hl
    ld d, [hl]
    inc hl
    ld e, [hl]
    ld a, c
    ld b, $03
    ld hl, wDA72
    add a, a
    add a, c
    add a, a
    add a, c
    add a, d
    add_a_to_hl
    call Func_005_6C86
    cp a, $02
    pop de
    jr nc, Jump_005_6896
    ld a, e
    call GetBattleHP_Bank05
    push hl
    ld a, [wBattleActor]
    call GetBattleHP_Bank05
    ld a, $3C
    ld b, h
    ld c, l
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    pop bc
    call CompareHLToBC
    jr nc, Jump_005_6896
    ld c, $00
    ret

Jump_005_6896::
    ld c, $FF
    ret

Jump_005_6899::
    ld c, $01
    ret

; 1 call site from 1 routine (e.g. Func_0E2_5856)
; reads: wBattleActor, wC58A, wCFC5, wD2CC, wCFEF
; points at: wDA5B, wDA72
Func_005_689C:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    call ReadWDA53Indexed_Bank05_4024
    cp a, $03
    jp c, Jump_005_696F
    ld a, [wC58A]
    or a, a
    jp nz, Jump_005_696C
    ld a, [wCFC5]
    cp a, $02
    jp nc, Jump_005_696C
    ld a, [wD2CC]
    or a, a
    jp z, Jump_005_696C
    ld a, [wBattleActor]
    ld e, a
    and a, $04
    ld c, a
    ld b, $03

Jump_005_68C6::
    ld a, c
    cp a, e
    jr z, Jump_005_68F5
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_68F5
    ld a, c
    call ReadWDA53Indexed_Bank05_4024
    cp a, $03
    jr c, Jump_005_68F5
    push de
    call Func_005_7058
    pop de
    jr nz, Jump_005_68F5
    ld a, c
    push de
    call CheckSlotStatusBlock
    pop de
    jr c, Jump_005_68F5
    ld a, c
    ld hl, wDA5B
    add_a_to_hl
    ld a, [hl]
    cp a, $03
    jr c, Jump_005_68FB

Jump_005_68F5::
    inc c
    dec b
    jr nz, Jump_005_68C6
    jr Jump_005_696C

Jump_005_68FB::
    ld a, [wBattleActor]
    call GetBattleHP_Bank05
    srl h
    rr l
    push hl
    ld a, [wBattleActor]
    call GetBattleHP_Bank05
    pop bc
    call CompareHLToBC
    jr nc, Jump_005_696C
    ld de, $0064
    add hl, de
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_6920::
    push hl
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    pop hl
    jr c, Jump_005_6963
    push bc
    push hl
    push hl
    ld a, c
    call GetBattleHP_Bank05
    pop bc
    call CompareHLToBC
    pop hl
    pop bc
    jr c, Jump_005_6963
    ld a, [wCFEF]
    or a, a
    jr z, Jump_005_696C
    push bc
    push hl
    dec a
    ld hl, Data_005_6F6B
    add a, a
    add_a_to_hl
    ld d, [hl]
    inc hl
    ld e, [hl]
    ld a, c
    ld hl, wDA72
    add a, a
    add a, c
    add a, a
    add a, c
    add a, d
    add_a_to_hl
    call Func_005_6C86
    pop hl
    pop bc
    cp a, $02
    jr c, Jump_005_6969

Jump_005_6963::
    inc c
    dec b
    jr nz, Jump_005_6920
    jr Jump_005_696C

Jump_005_6969::
    ld c, $00
    ret

Jump_005_696C::
    ld c, $FF
    ret

Jump_005_696F::
    ld c, $01
    ret

; 8 call sites from 8 routines (e.g. Func_005_772B, Func_0E2_4001, Func_0E2_4F30, Func_0E2_4FE1, ...)
; reads: wBattleActor
; points at: wD810
Func_005_6972::
    ld a, [wBattleActor]
    ld hl, wD810
    call AddAx9ToHL
    and a, $03
    jr z, Jump_005_6982
    ld c, $00
    ret

Jump_005_6982::
    ld c, $FF
    ret

; 1 call site from 1 routine (e.g. Func_005_76CE)
; reads: wBattleActor, hFFCA, hFFCB, hFFC9
; writes: hFFC9, hFFCA, hFFCB
; points at: hFFC9
Func_005_6985:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    xor a, a
    ldh [hFFC9], a
    ldh [hFFCA], a
    ldh [hFFCB], a

Jump_005_6996::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_69AD
    call GetBattleDEF_Bank05
    ldh a, [hFFCA]
    add a, l
    ldh [hFFCA], a
    ldh a, [hFFCB]
    adc a, h
    ldh [hFFCB], a
    ld hl, hFFC9
    inc [hl]

Jump_005_69AD::
    inc c
    dec b
    jr nz, Jump_005_6996
    ldh a, [hFFCA]
    ld l, a
    ldh a, [hFFCB]
    ld h, a
    ldh a, [hFFC9]
    call DivideHLByA
    push hl
    ld a, [wBattleActor]
    call GetBattleATK_Bank05
    ld d, h
    ld e, l
    srl d
    rr e
    srl d
    rr e
    add hl, de
    pop bc
    call CompareHLToBC
    jr nc, Jump_005_69D7
    ld c, $00
    ret

Jump_005_69D7::
    ld c, $FF
    ret

; 14 call sites from 14 routines (e.g. Func_0E2_4001, Func_0E2_4F30, Func_0E2_4FE1, Func_0E2_511C, ...)
; reads: wBattleActor
; points at: wD80E
Func_005_69DA::
    ld a, [wBattleActor]
    ld hl, wD80E
    call AddAx9ToHL
    ld a, [hl+]
    and a, $02
    jr nz, Jump_005_69EF
    inc hl
    inc hl
    ld a, [hl]
    and a, $03
    jr z, Jump_005_69F2

Jump_005_69EF::
    ld c, $00
    ret

Jump_005_69F2::
    ld c, $FF
    ret

; 20 call sites from 20 routines (e.g. Func_0E2_41E0, Func_0E2_449C, Func_0E2_4567, Func_0E2_4674, ...)
; reads: wC58A, wBattleActor, wCFEF, hFFC6, hFFC7
; writes: hFFC6, hFFC7
; points at: wDA72
Func_005_69F5:: ; heuristic: follows a terminator; C0
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_005_6A03
    ld a, [wBattleActor]
    cp a, $04
    jr nc, Jump_005_6A68

Jump_005_6A03::
    ld a, [wCFEF]
    or a, a
    jr z, Jump_005_6A65
    dec a
    ld hl, Data_005_6F6B
    add a, a
    add_a_to_hl
    ld d, [hl]
    inc hl
    ld e, [hl]
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld hl, wDA72
    add a, a
    add a, c
    add a, a
    add a, c
    add a, d
    add_a_to_hl
    xor a, a
    ldh [hFFC6], a
    ldh [hFFC7], a

Jump_005_6A32::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_6A46
    ldh a, [hFFC6]
    inc a
    ldh [hFFC6], a
    call Func_005_6C86
    ld d, a
    ldh a, [hFFC7]
    add a, d
    ldh [hFFC7], a

Jump_005_6A46::
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc c
    dec b
    jr nz, Jump_005_6A32
    ldh a, [hFFC7]
    or a, a
    jr z, Jump_005_6A62
    ld b, a
    ldh a, [hFFC6]
    call DivideBByA
    ld a, b
    cp a, $02
    jr nc, Jump_005_6A65

Jump_005_6A62::
    ld c, $00
    ret

Jump_005_6A65::
    ld c, $FF
    ret

Jump_005_6A68::
    ld c, $01
    ret

; 20 call sites from 20 routines (e.g. Func_0E2_41E0, Func_0E2_449C, Func_0E2_4567, Func_0E2_4674, ...)
; reads: wC58A, wBattleActor, wCFEF, hFFC6, hFFC7
; writes: hFFC6, hFFC7
; points at: wDA72
Func_005_6A6B:: ; heuristic: follows a terminator; C0
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_005_6AE5
    ld a, [wBattleActor]
    cp a, $04
    jr c, Jump_005_6AE5
    call ReadWDA53Indexed_Bank05
    cp a, $03
    jr c, Jump_005_6AE5
    ld a, [wCFEF]
    or a, a
    jr z, Jump_005_6AE2
    dec a
    ld hl, Data_005_6F6B
    add a, a
    add_a_to_hl
    ld d, [hl]
    inc hl
    ld e, [hl]
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld hl, wDA72
    add a, a
    add a, c
    add a, a
    add a, c
    add a, d
    add_a_to_hl
    xor a, a
    ldh [hFFC6], a
    ldh [hFFC7], a

Jump_005_6AAF::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_6AC3
    ldh a, [hFFC6]
    inc a
    ldh [hFFC6], a
    call Func_005_6C86
    ld d, a
    ldh a, [hFFC7]
    add a, d
    ldh [hFFC7], a

Jump_005_6AC3::
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc c
    dec b
    jr nz, Jump_005_6AAF
    ldh a, [hFFC7]
    or a, a
    jr z, Jump_005_6ADF
    ld b, a
    ldh a, [hFFC6]
    call DivideBByA
    ld a, b
    cp a, $02
    jr nc, Jump_005_6AE2

Jump_005_6ADF::
    ld c, $00
    ret

Jump_005_6AE2::
    ld c, $FF
    ret

Jump_005_6AE5::
    ld c, $01
    ret

; wDA6E = wDA6F = 0 and wDA70 = wDA71 = $FF
; 108 call sites from 108 routines (e.g. Func_005_7080, Func_005_708C, Func_005_70C9, Func_005_7109, ...)
; writes: wDA6E, wDA6F, wDA70, wDA71
ResetWDA6E::
Func_005_6AE8:: ; address name
    xor a, a
    ld [wDA6E], a
    ld [wDA6F], a
    ld a, $FF
    ld [wDA70], a
    ld [wDA71], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wDA6E, wDA6F
; writes: wDA6E, wDA6F
Func_005_6AF8:: ; heuristic: follows a terminator; C0
    ld a, [wDA6E]
    add a, c
    ld [wDA6E], a
    ld a, [wDA6F]
    adc a, b
    ld [wDA6F], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wDA70, wDA71
; writes: wDA70, wDA71
Func_005_6B07:: ; heuristic: follows a terminator; C0
    ld a, [wDA70]
    add a, c
    ld [wDA70], a
    ld a, [wDA71]
    adc a, b
    ld [wDA71], a
    ret

; A = the byte at wDA53 + A; clobbers HL (the same 10 bytes appear in 4 banks)
; 35 call sites from 35 routines (e.g. Func_005_4CE5, Func_005_5500, Func_005_6A6B, Func_005_64FE, ...)
; points at: wDA53
ReadWDA53Indexed_Bank05::
Func_005_6B16:: ; address name
    ld hl, wDA53
    add_a_to_hl
    ld a, [hl]
    ret

; 1 call site from 1 routine (e.g. Func_005_4C23)
; reads: wBattleStatResultLo, wBattleStatResultHi, wC58A
Func_005_6B20:: ; heuristic: follows a terminator; C0
    call GetBattleDEF_Bank05
    ld a, l
    sub a, $E7
    ld a, h
    sbc a, $03
    jr nc, Jump_005_6B5B
    push hl
    push bc
    farcall GetBaseDEF
    pop bc
    pop hl
    inc hl
    ld a, [wBattleStatResultLo]
    ld e, a
    ld a, [wBattleStatResultHi]
    ld d, a
    sla e
    rl d
    ld a, [wC58A]
    or a, a
    jr z, Jump_005_6B4C
    cp a, $02
    jr nz, Jump_005_6B51

Jump_005_6B4C::
    ld a, c
    cp a, $04
    jr nc, Jump_005_6B55

Jump_005_6B51::
    sla e
    rl d

Jump_005_6B55::
    ld a, e
    sub a, l
    ld a, d
    sbc a, h
    jr nc, Jump_005_6B5D

Jump_005_6B5B::
    xor a, a
    ret

Jump_005_6B5D::
    scf
    ret

; 1 call site from 1 routine (e.g. Func_005_4C40)
; reads: wBattleStatResultLo, wBattleStatResultHi, wC58A
Func_005_6B5F:: ; heuristic: follows a terminator; C0
    call GetBattleAGL_Bank05
    ld a, l
    sub a, $E7
    ld a, h
    sbc a, $03
    jr nc, Jump_005_6B9A
    push hl
    push bc
    farcall GetBaseAGL
    pop bc
    pop hl
    inc hl
    ld a, [wBattleStatResultLo]
    ld e, a
    ld a, [wBattleStatResultHi]
    ld d, a
    sla e
    rl d
    ld a, [wC58A]
    or a, a
    jr z, Jump_005_6B8B
    cp a, $02
    jr nz, Jump_005_6B90

Jump_005_6B8B::
    ld a, c
    cp a, $04
    jr nc, Jump_005_6B94

Jump_005_6B90::
    sla e
    rl d

Jump_005_6B94::
    ld a, e
    sub a, l
    ld a, d
    sbc a, h
    jr nc, Jump_005_6B9C

Jump_005_6B9A::
    xor a, a
    ret

Jump_005_6B9C::
    scf
    ret

; 1 call site from 1 routine (e.g. Func_005_4BE1)
Func_005_6B9E:: ; heuristic: follows a terminator; C0
    push bc
    ld a, c
    call GetBattleMaxHP_Bank05
    ld c, l
    ld b, h
    add hl, hl
    add hl, bc
    sra h
    rr l
    sra h
    rr l
    pop bc
    push bc
    push hl
    ld a, c
    call GetBattleHP_Bank05
    pop bc
    call CompareHLToBC
    pop bc
    ret

; no direct call (reached through a table, a jump or a vector)
Func_005_6BBC:: ; heuristic: follows a terminator; C0
    push bc
    push af
    call GetBattleMaxHP_Bank05
    pop af
    push hl
    ld a, c
    call GetBattleHP_Bank05
    add hl, hl
    pop bc
    call CompareHLToBC
    pop bc
    ret

; no direct call (reached through a table, a jump or a vector)
Func_005_6BCE:: ; heuristic: follows a terminator; C0
    push bc
    push af
    call GetBattleMaxHP_Bank05
    pop af
    push hl
    ld a, c
    call GetBattleHP_Bank05
    add hl, hl
    add hl, hl
    pop bc
    call CompareHLToBC
    pop bc
    ret

; no direct call (reached through a table, a jump or a vector)
Func_005_6BE1:: ; heuristic: follows a terminator; C0
    push bc
    push af
    call GetBattleMaxHP_Bank05
    pop af
    push hl
    ld a, c
    call GetBattleHP_Bank05
    add hl, hl
    ld b, h
    ld c, l
    add hl, hl
    add hl, hl
    add hl, bc
    pop bc
    call CompareHLToBC
    pop bc
    ret

; 2 call sites from 2 routines (e.g. Func_005_5397, Func_005_53A5)
Func_005_6BF8::
    call GetBattleHP_Bank05
    ld a, h
    or a, a
    ret nz
    ld a, l
    cp a, $01
    ret

; 8 call sites from 8 routines (e.g. Func_005_432E, Func_005_4373, Func_005_44E1, Func_005_43AD, ...)
; reads: hFFC6
; writes: wD868, wD869, wD86A, wD86B, wRecordBuffer
; points at: hFFC6, wD989
Func_005_6C02:: ; heuristic: follows a terminator; C0
    push bc
    ld a, $05
    ld [wD868], a
    ld a, $01
    ld [wD869], a
    ld hl, hFFC6
    ld a, l
    ld [wD86A], a
    ld a, h
    ld [wD86B], a
    ld a, c
    ld hl, wD989
    swap a
    add_a_to_hl
    ld b, $08
    ld c, d

Jump_005_6C26::
    push bc
    push hl
    ld a, [hl]
    ld [wRecordBuffer], a
    farcall LoadSkillRecordPart
    pop hl
    pop bc
    ldh a, [hFFC6]
    and a, c
    jr nz, Jump_005_6C3F
    inc hl
    inc hl
    dec b
    jr nz, Jump_005_6C26
    xor a, a

Jump_005_6C3F::
    ld d, c
    pop bc
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: hFFC6
; writes: wD868, wD869, wD86A, wD86B, wRecordBuffer
; points at: hFFC6, wD989
Func_005_6C42:: ; heuristic: follows a terminator; C0
    push bc
    ld a, $01
    ld [wD868], a
    ld a, $01
    ld [wD869], a
    ld hl, hFFC6
    ld a, l
    ld [wD86A], a
    ld a, h
    ld [wD86B], a
    ld a, c
    ld hl, wD989
    swap a
    add_a_to_hl
    ld bc, $0800

Jump_005_6C66::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_005_6C7E
    push bc
    push hl
    ld [wRecordBuffer], a
    farcall LoadSkillRecordPart
    pop hl
    pop bc
    ldh a, [hFFC6]
    or a, a
    jr nz, Jump_005_6C7E
    inc c

Jump_005_6C7E::
    inc hl
    dec b
    jr nz, Jump_005_6C66
    ld a, c
    or a, a
    pop bc
    ret

; 8 call sites from 8 routines (e.g. Func_005_43F2, Func_005_69F5, Func_005_5052, Func_005_6A6B, ...)
Func_005_6C86::
    ld a, e
    or a, a
    jr z, Jump_005_6C97
    cp a, $01
    jr z, Jump_005_6C9A
    cp a, $02
    jr z, Jump_005_6C9F
    ld a, [hl]
    rlca
    rlca
    jr Jump_005_6CA2

Jump_005_6C97::
    ld a, [hl]
    jr Jump_005_6CA2

Jump_005_6C9A::
    ld a, [hl]
    rrca
    rrca
    jr Jump_005_6CA2

Jump_005_6C9F::
    ld a, [hl]
    swap a

Jump_005_6CA2::
    and a, $03
    ret

; A = battle slot: A = the family (byte 0 of the species record) of the monster id in wBattleMonsterId[slot] (LoadSpeciesFamily); BC kept (E-0069)
; 1 call site from 1 routine (e.g. Func_005_6FD9)
; reads: wSpeciesRecord
; writes: wSpeciesIdLo, wSpeciesIdHi
; points at: wBattleMonsterId
GetSlotSpeciesFamily:: ; heuristic: follows a terminator; C0
Func_005_6CA5:: ; address name
    ld hl, wBattleMonsterId
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    push bc
    farcall LoadSpeciesFamily
    pop bc
    ld a, [wSpeciesRecord]
    ret

; 2 call sites from 2 routines (e.g. Func_005_51EA, Func_005_5228)
; reads: wBattleActor, hFFC6, hFFC7
; writes: hFFC6, hFFC7
Func_005_6CC2:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    xor a, a
    ldh [hFFC6], a
    ldh [hFFC7], a

Jump_005_6CD1::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr nc, Jump_005_6CDD
    inc c
    dec b
    jr nz, Jump_005_6CD1
    jr Jump_005_6D06

Jump_005_6CDD::
    ld a, c
    call GetBattleDEF_Bank05
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    inc c
    dec b
    jr z, Jump_005_6D06

Jump_005_6CEB::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_6D02
    call GetBattleDEF_Bank05
    ldh a, [hFFC6]
    sub a, l
    ldh a, [hFFC7]
    sbc a, h
    jr c, Jump_005_6D02
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a

Jump_005_6D02::
    inc c
    dec b
    jr nz, Jump_005_6CEB

Jump_005_6D06::
    ret

; 1 call site from 1 routine (e.g. Func_005_5275)
; points at: wD80D
Func_005_6D07:: ; heuristic: follows a terminator; C0
    ld a, c
    ld hl, wD80D
    call AddAx9ToHL
    bit 1, [hl]
    jr nz, Jump_005_6D19
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    and a, $03

Jump_005_6D19::
    ret

; 2 call sites from 2 routines (e.g. Func_005_57A1, Func_005_5A33)
; points at: wD989
Func_005_6D1A::
    ld hl, wD989
    swap a
    add_a_to_hl
    push bc
    ld bc, $0800

Jump_005_6D28::
    ld a, [hl+]
    cp a, $03
    jr z, Jump_005_6D4B
    cp a, $06
    jr z, Jump_005_6D4B
    cp a, $09
    jr z, Jump_005_6D4B
    cp a, $0C
    jr z, Jump_005_6D4B
    cp a, $0F
    jr z, Jump_005_6D4B
    cp a, $12
    jr z, Jump_005_6D4B
    cp a, $13
    jr z, Jump_005_6D4B
    cp a, $14
    jr z, Jump_005_6D4B
    jr Jump_005_6D4C

Jump_005_6D4B::
    inc c

Jump_005_6D4C::
    inc hl
    dec b
    jr nz, Jump_005_6D28
    ld a, c
    or a, a
    pop bc
    ret

; no direct call (reached through a table, a jump or a vector)
; points at: wD989
Func_005_6D54:: ; heuristic: follows a terminator; C0
    ld hl, wD989
    swap a
    add_a_to_hl
    push bc
    ld bc, $0800

Jump_005_6D62::
    ld a, [hl+]
    cp a, $03
    jr z, Jump_005_6D95
    cp a, $06
    jr z, Jump_005_6D95
    cp a, $09
    jr z, Jump_005_6D95
    cp a, $0C
    jr z, Jump_005_6D95
    cp a, $0F
    jr z, Jump_005_6D95
    cp a, $12
    jr z, Jump_005_6D95
    cp a, $13
    jr z, Jump_005_6D95
    cp a, $14
    jr z, Jump_005_6D95
    cp a, $15
    jr z, Jump_005_6D95
    cp a, $3D
    jr z, Jump_005_6D95
    cp a, $3E
    jr z, Jump_005_6D95
    cp a, $3F
    jr z, Jump_005_6D95
    jr Jump_005_6D96

Jump_005_6D95::
    inc c

Jump_005_6D96::
    inc hl
    dec b
    jr nz, Jump_005_6D62
    ld a, c
    or a, a
    pop bc
    ret

; no direct call (reached through a table, a jump or a vector)
; points at: wD989
Func_005_6D9E:: ; heuristic: follows a terminator; C0
    ld hl, wD989
    swap a
    add_a_to_hl
    push bc
    ld bc, $0800

Jump_005_6DAC::
    ld a, [hl+]
    or a, a
    jr z, Jump_005_6DD1
    cp a, $FF
    jr z, Jump_005_6DD1
    cp a, $16
    jr c, Jump_005_6DD1
    cp a, $25
    jr c, Jump_005_6DD0
    cp a, $7B
    jr c, Jump_005_6DD1
    cp a, $7D
    jr c, Jump_005_6DD0
    cp a, $81
    jr z, Jump_005_6DD0
    cp a, $9F
    jr c, Jump_005_6DD1
    cp a, $A1
    jr nc, Jump_005_6DD1

Jump_005_6DD0::
    inc c

Jump_005_6DD1::
    inc hl
    dec b
    jr nz, Jump_005_6DAC
    ld a, c
    pop bc
    or a, a
    ret

; no direct call (reached through a table, a jump or a vector)
; points at: wD989
Func_005_6DD9:: ; heuristic: follows a terminator; C0
    push bc
    ld hl, wD989
    swap a
    add_a_to_hl
    ld bc, $0800

Jump_005_6DE7::
    ld a, [hl+]
    cp a, $16
    jr c, Jump_005_6DF9
    cp a, $1B
    jr c, Jump_005_6DF8
    cp a, $1E
    jr c, Jump_005_6DF9
    cp a, $21
    jr nc, Jump_005_6DF9

Jump_005_6DF8::
    inc c

Jump_005_6DF9::
    dec b
    jr nz, Jump_005_6DE7
    ld a, c
    pop bc
    ret

; 2 call sites from 1 routine (e.g. Func_005_50B7)
; reads: hFFC7, hFFC8, hFFC6
; writes: hFFC6, hFFC7, hFFC8
; points at: hFFC6
Func_005_6DFF::
    ld c, a
    ld b, $03
    xor a, a
    ldh [hFFC6], a
    ldh [hFFC7], a
    ldh [hFFC8], a

Jump_005_6E09::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_6E20
    call GetBattleAGL_Bank05
    ldh a, [hFFC7]
    add a, l
    ldh [hFFC7], a
    ldh a, [hFFC8]
    adc a, h
    ldh [hFFC8], a
    ld hl, hFFC6
    inc [hl]

Jump_005_6E20::
    inc c
    dec b
    jr nz, Jump_005_6E09
    ldh a, [hFFC7]
    ld l, a
    ldh a, [hFFC8]
    ld h, a
    ldh a, [hFFC6]
    call DivideHLByA
    ret

; 1 call site from 1 routine (e.g. Func_005_5C50)
; points at: wD80D
Func_005_6E30:: ; heuristic: follows a terminator; C0
    ld a, c
    ld d, $00
    ld hl, wD80D
    call AddAx9ToHL
    bit 2, [hl]
    call nz, Func_005_6E89
    bit 3, [hl]
    call nz, Func_005_6E89
    bit 4, [hl]
    call nz, Func_005_6E89
    bit 5, [hl]
    call nz, Func_005_6E89
    inc hl
    bit 0, [hl]
    call nz, Func_005_6E89
    bit 1, [hl]
    call nz, Func_005_6E89
    bit 2, [hl]
    call nz, Func_005_6E89
    bit 3, [hl]
    call nz, Func_005_6E89
    bit 5, [hl]
    call nz, Func_005_6E89
    bit 6, [hl]
    call nz, Func_005_6E89
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    and a, $0C
    call nz, Func_005_6E89
    ld a, [hl]
    and a, $C0
    call nz, Func_005_6E89
    inc hl
    bit 6, [hl]
    call nz, Func_005_6E89
    inc hl
    inc hl
    bit 6, [hl]
    call nz, Func_005_6E89
    ret

; 14 call sites from 1 routine (e.g. Func_005_6E30)
Func_005_6E89::
    inc d
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: hFFC8
; writes: wD868, wD869, wD86A, wD86B, wRecordBuffer
; points at: wD989
Func_005_6E8B:: ; heuristic: follows a terminator; C0
    push bc
    ld de, $0000
    ld hl, wD989
    swap a
    add_a_to_hl
    ld a, $05
    ld [wD868], a
    ld a, $01
    ld [wD869], a
    ld a, $C8
    ld [wD86A], a
    ld a, $FF
    ld [wD86B], a
    ld b, $08

Jump_005_6EAF::
    push bc
    ld a, [hl+]
    ld [wRecordBuffer], a
    cp a, $FF
    jr z, Jump_005_6ECA
    push de
    push hl
    farcall LoadSkillRecordPart
    pop hl
    pop de
    inc d
    ldh a, [hFFC8]
    bit 6, [hl]
    jr z, Jump_005_6ECA
    inc e

Jump_005_6ECA::
    pop bc
    inc hl
    dec b
    jr nz, Jump_005_6EAF
    pop bc
    ret

; no direct call (reached through a table, a jump or a vector)
; points at: wD989
Func_005_6ED1:: ; heuristic: follows a terminator; C0
    push bc
    ld a, c
    ld hl, wD989
    swap a
    add_a_to_hl
    ld bc, $0800

Jump_005_6EE0::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_005_6EF9
    or a, a
    jr z, Jump_005_6EF9
    cp a, $16
    jr c, Jump_005_6EF8
    cp a, $2E
    jr c, Jump_005_6EF9
    cp a, $31
    jr z, Jump_005_6EF9
    cp a, $35
    jr nc, Jump_005_6EF9

Jump_005_6EF8::
    inc c

Jump_005_6EF9::
    inc hl
    dec b
    jr nz, Jump_005_6EE0
    ld a, c
    pop bc
    or a, a
    ret

; no direct call (reached through a table, a jump or a vector)
; points at: wD989
Func_005_6F01:: ; heuristic: follows a terminator; C0
    push bc
    ld hl, wD989
    swap a
    add_a_to_hl
    ld bc, $0800

Jump_005_6F0F::
    ld a, [hl+]
    cp a, $40
    jr c, Jump_005_6F19
    cp a, $48
    jr nc, Jump_005_6F19
    inc c

Jump_005_6F19::
    inc hl
    dec b
    jr nz, Jump_005_6F0F
    ld a, c
    or a, a
    pop bc
    ret

; no direct call (reached through a table, a jump or a vector)
; points at: wD989
Func_005_6F21:: ; heuristic: follows a terminator; C0
    push bc
    ld hl, wD989
    swap a
    add_a_to_hl
    ld bc, $0800

Jump_005_6F2F::
    ld a, [hl+]
    or a, a
    jr z, Jump_005_6F58
    cp a, $FF
    jr z, Jump_005_6F58
    cp a, $16
    jr c, Jump_005_6F57
    cp a, $40
    jr c, Jump_005_6F58
    cp a, $68
    jr c, Jump_005_6F57
    cp a, $6A
    jr c, Jump_005_6F58
    cp a, $71
    jr c, Jump_005_6F57
    cp a, $8B
    jr c, Jump_005_6F58
    cp a, $94
    jr c, Jump_005_6F57
    cp a, $AA
    jr nz, Jump_005_6F58

Jump_005_6F57::
    inc c

Jump_005_6F58::
    inc hl
    dec b
    jr nz, Jump_005_6F2F
    ld a, c
    or a, a
    pop bc
    ret

; A = [HL + 4 * A + 3 * C], the offset computed in 8 bits; clobbers HL (the same 11 bytes appear in 2 banks)
; 16 call sites from 16 routines (e.g. Func_005_5803, Func_005_5D9B, Func_005_47E5, Func_005_5DCD, ...)
ReadByteAtHLPlus4APlus3C_Bank05::
Func_005_6F60:: ; address name
    add a, a
    add a, c
    add a, a
    add a, c
    add_a_to_hl
    ld a, [hl]
    ret

Data_005_6F6B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $02, $00, $01, $00, $00, $01, $03, $01, $02, $01, $01, $01, $00, $02, $03
    db $02, $02, $02, $01, $02, $00, $03, $03, $03, $02, $03, $01, $03, $00, $04, $03
    db $04, $02, $04, $01, $04, $00, $05, $03, $05, $02, $05, $01, $05, $00, $06, $03
    db $06, $02, $06, $01, $00, $03

; A = first slot, B = slot count, HL = a status field (wBattleStatus + n), E = mask: C = $FF when some present slot in the range has (HL + 9 * slot) & E clear; C = 0 when every slot is absent or has a masked bit set (E-0071)
; 21 call sites from 20 routines (e.g. AnyFoeLacksStatus2Bit3, AnyFoeLacksStatus5Bits67, Func_005_41EB, Func_005_4D46, ...)
AnySlotLacksStatusMask::
Func_005_6FA1:: ; address name
    ld c, a

Jump_005_6FA2::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_6FB3
    push hl
    ld a, c
    call AddAx9ToHL
    ld a, [hl]
    pop hl
    and a, e
    and a, a
    jr z, Jump_005_6FBA

Jump_005_6FB3::
    inc c
    dec b
    jr nz, Jump_005_6FA2
    ld c, $00
    ret

Jump_005_6FBA::
    ld c, $FF
    ret

; 4 call sites from 4 routines (e.g. Func_005_47A5, Func_005_47B5, Func_005_47C5, Func_005_47D5)
Func_005_6FBD:: ; heuristic: follows a terminator; C0
    ld c, a

Jump_005_6FBE::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_6FCF
    push hl
    ld a, c
    call AddAx9ToHL
    ld a, [hl]
    pop hl
    and a, e
    and a, a
    jr nz, Jump_005_6FD6

Jump_005_6FCF::
    inc c
    dec b
    jr nz, Jump_005_6FBE
    ld c, $00
    ret

Jump_005_6FD6::
    ld c, $FF
    ret

; 10 call sites from 10 routines (e.g. Func_005_481C, Func_005_4822, Func_005_4828, Func_005_482E, ...)
; reads: wBattleActor
Func_005_6FD9:: ; heuristic: follows a terminator; C0
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_6FE3::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_005_6FF1
    push de
    call GetSlotSpeciesFamily
    pop de
    cp a, e
    jr z, Jump_005_6FF7

Jump_005_6FF1::
    inc c
    dec b
    jr nz, Jump_005_6FE3
    jr Jump_005_6FFA

Jump_005_6FF7::
    ld c, $00
    ret

Jump_005_6FFA::
    ld c, $FF
    ret

; 1 call site from 1 routine (e.g. Func_005_4C02)
Func_005_6FFD:: ; heuristic: follows a terminator; C0
    push bc
    ld a, c
    call GetBattleMaxMP_Bank05
    ld c, l
    ld b, h
    add hl, hl
    add hl, bc
    sra h
    rr l
    sra h
    rr l
    pop bc
    push bc
    push hl
    ld a, c
    call GetBattleMP_Bank05
    pop bc
    call CompareHLToBC
    pop bc
    ret

; 1 call site from 1 routine (e.g. Func_005_5C8C)
Func_005_701B:: ; heuristic: follows a terminator; C0
    push de
    push bc
    ld a, $05
    call DivideHLByA
    sla l
    rl h
    sla l
    rl h
    pop bc
    pop de
    ret

; 2 call sites from 2 routines (e.g. Func_005_4676, Func_005_46B4)
; reads: wCFEF
Func_005_702D::
    ld a, [wCFEF]
    or a, a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wDA72
Func_005_7032:: ; heuristic: follows a terminator; C0
    dec a
    ld hl, Data_005_6F6B
    add a, a
    add_a_to_hl
    ld d, [hl]
    inc hl
    ld e, [hl]
    ld a, [wBattleActor]
    ld hl, wDA72
    add a, a
    add a, c
    add a, a
    add a, c
    add a, d
    add_a_to_hl
    call Func_005_6C86
    ld e, a
    ld a, $01
    or a, a
    ld a, e
    ret

; 1 call site from 1 routine (e.g. Func_005_689C)
; points at: wD989
Func_005_7058:: ; heuristic: follows a terminator; C0
    ld e, $00
    ld d, c
    ld hl, wD989
    add hl, de
    ld e, $08

Jump_005_7061::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_005_707A
    cp a, $16
    jr c, Jump_005_7076
    cp a, $1B
    jr c, Jump_005_707E
    cp a, $7C
    jr z, Jump_005_707E
    cp a, $A1
    jr z, Jump_005_707E

Jump_005_7076::
    inc hl
    dec b
    jr nz, Jump_005_7061

Jump_005_707A::
    ld a, $01
    or a, a
    ret

Jump_005_707E::
    xor a, a
    ret

; 1 call site from 1 routine (e.g. Func_0E2_4001)
Func_005_7080::
    call AnyFoeLacksStatus3And4Bits
    ld a, c
    and a, a
    jr z, Jump_005_7088
    ret

Jump_005_7088::
    call ResetWDA6E
    ret

; 2 call sites from 2 routines (e.g. Func_0E2_40BF, Func_0E2_411C)
Func_005_708C:: ; heuristic: follows a terminator; C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, Jump_005_70C5
    call SkillPassesStatus1Bit0Check
    ld a, c
    and a, a
    jr z, Jump_005_70C5
    call SkillPassesSideFlagBit3Check
    ld a, c
    and a, a
    jr z, Jump_005_70C5
    call SkillPassesRepeatCheck
    ld a, c
    and a, a
    jr z, Jump_005_70C5
    call Func_005_41EB
    ld a, c
    and a, a
    jr z, Jump_005_70C5
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr z, Jump_005_70C5
    call AnyFoeLacksStatus2Bit3
    ld a, c
    and a, a
    jr z, Jump_005_70C5
    call Func_005_43F2
    ld a, c
    and a, a
    jr z, Jump_005_70C5
    ret

Jump_005_70C5::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_41E0)
Func_005_70C9:: ; heuristic: follows a terminator; C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, Jump_005_7105
    call SkillPassesStatus1Bit0Check
    ld a, c
    and a, a
    jr z, Jump_005_7105
    call SkillPassesSideFlagBit3Check
    ld a, c
    and a, a
    jr z, Jump_005_7105
    call SkillPassesRepeatCheck
    ld a, c
    and a, a
    jr z, Jump_005_7105
    call Func_005_41EB
    ld a, c
    and a, a
    jr z, Jump_005_7105
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr z, Jump_005_7105
    call Func_005_43F2
    ld a, c
    and a, a
    jr z, Jump_005_7105
    farcall Func_005_5CCE
    ld a, c
    and a, a
    jr z, Jump_005_7105
    ret

Jump_005_7105::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_4279)
Func_005_7109:: ; heuristic: follows a terminator; C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, Jump_005_715B
    call SkillPassesStatus1Bit0Check
    ld a, c
    and a, a
    jr z, Jump_005_715B
    call SkillPassesSideFlagBit3Check
    ld a, c
    and a, a
    jr z, Jump_005_715B
    call SkillPassesRepeatCheck
    ld a, c
    and a, a
    jr z, Jump_005_715B
    call Func_005_41EB
    ld a, c
    and a, a
    jr z, Jump_005_715B
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr z, Jump_005_715B
    call AnyFoeLacksStatus0Bit6
    ld a, c
    and a, a
    jr z, Jump_005_715B
    call Func_005_43F2
    ld a, c
    and a, a
    jr z, Jump_005_715B
    call Func_005_4676
    ld a, c
    cp a, $01
    jr z, Jump_005_714C
    and a, a
    jr z, Jump_005_715B

Jump_005_714C::
    call Func_005_4DF5
    ld a, c
    and a, a
    jr z, Jump_005_715B
    call Func_005_5CCE
    ld a, c
    and a, a
    jr z, Jump_005_715B
    ret

Jump_005_715B::
    call ResetWDA6E
    ret

; 2 call sites from 2 routines (e.g. Func_0E2_4310, Func_0E2_438D)
Func_005_715F:: ; heuristic: follows a terminator; C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, Jump_005_7183
    call SkillPassesStatus1Bit0Check
    ld a, c
    and a, a
    jr z, Jump_005_7183
    call SkillPassesSideFlagBit3Check
    ld a, c
    and a, a
    jr z, Jump_005_7183
    call SkillPassesRepeatCheck
    ld a, c
    and a, a
    jr z, Jump_005_7183
    call Func_005_626B
    ld a, c
    and a, a
    jr z, Jump_005_7183
    ret

Jump_005_7183::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_43BE)
Func_005_7187:: ; heuristic: follows a terminator; C0
    ld a, c
    and a, a
    jr z, Jump_005_71A8
    call ActorLacksStatus4Bits67
    ld a, c
    and a, a
    jr z, Jump_005_71A8
    call Func_005_4777
    ld a, c
    and a, a
    jr z, Jump_005_71A8
    call SetCToZero
    ld a, c
    and a, a
    jr z, Jump_005_71A8
    call Func_005_62E1
    ld a, c
    and a, a
    jr z, Jump_005_71A8
    ret

Jump_005_71A8::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_43C8)
Func_005_71AC:: ; heuristic: follows a terminator; C0
    call CheckSkillUsableStatusElseResetWDA6E
    ld a, c
    and a, a
    ret z
    call Func_005_4B7A
    ld a, c
    and a, a
    jr z, Jump_005_71BA
    ret

Jump_005_71BA::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_43E9)
Func_005_71BE:: ; heuristic: follows a terminator; C0
    call CheckSkillUsableStatusElseResetWDA6E
    ld a, c
    and a, a
    ret z
    call AnyFoeLacksStatus0Bit6
    ld a, c
    and a, a
    jr z, Jump_005_71DA
    call Func_005_4B7A
    ld a, c
    and a, a
    jr z, Jump_005_71DA
    call Func_005_4DF5
    ld a, c
    and a, a
    jr z, Jump_005_71DA
    ret

Jump_005_71DA::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_4420)
Func_005_71DE:: ; heuristic: follows a terminator; C0
    call CheckSkillUsableStatusElseResetWDA6E
    ld a, c
    and a, a
    ret z
    call Func_005_47A5
    ld a, c
    and a, a
    jr z, Jump_005_71EE
    ld c, $FF
    ret

Jump_005_71EE::
    call ResetWDA6E
    ld c, $00
    ret

; 1 call site from 1 routine (e.g. Func_0E2_4433)
Func_005_71F4:: ; heuristic: follows a terminator; C0
    call CheckSkillUsableStatusElseResetWDA6E
    ld a, c
    and a, a
    ret z
    call Func_005_47C5
    ld a, c
    and a, a
    jr z, Jump_005_7204
    ld c, $FF
    ret

Jump_005_7204::
    call ResetWDA6E
    ld c, $00
    ret

; 1 call site from 1 routine (e.g. Func_0E2_4446)
Func_005_720A:: ; heuristic: follows a terminator; C0
    call CheckSkillUsableStatusElseResetWDA6E
    ld a, c
    and a, a
    ret z
    call Func_005_47B5
    ld a, c
    and a, a
    jr z, Jump_005_721A
    ld c, $FF
    ret

Jump_005_721A::
    call ResetWDA6E
    ld c, $00
    ret

; 1 call site from 1 routine (e.g. Func_0E2_4459)
Func_005_7220:: ; heuristic: follows a terminator; C0
    call CheckSkillUsableStatusElseResetWDA6E
    ld a, c
    and a, a
    ret z
    call Func_005_47D5
    ld a, c
    and a, a
    jr z, Jump_005_7230
    ld c, $FF
    ret

Jump_005_7230::
    call ResetWDA6E
    ld c, $00
    ret

; 1 call site from 1 routine (e.g. Func_0E2_446C)
Func_005_7236:: ; heuristic: follows a terminator; C0
    call CheckSkillUsableStatusElseResetWDA6E
    ld a, c
    and a, a
    ret z
    call AnyFoeNotBlocked
    ld a, c
    and a, a
    jr z, Jump_005_724B
    call Func_005_4C23
    ld a, c
    and a, a
    jr z, Jump_005_724B
    ret

Jump_005_724B::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_449C)
Func_005_724F:: ; heuristic: follows a terminator; C0
    call Func_005_7261
    ld a, c
    and a, a
    ret z
    call Func_005_4977
    ld a, c
    and a, a
    jr z, Jump_005_725D
    ret

Jump_005_725D::
    call ResetWDA6E
    ret

; 6 call sites from 6 routines (e.g. Func_005_724F, Func_005_7293, Func_005_72BE, Func_005_72DE, ...)
Func_005_7261::
    call CheckSkillUsableStatusElseResetWDA6E
    ld a, c
    and a, a
    ret z
    call Func_005_41EB
    ld a, c
    and a, a
    jr z, Jump_005_7276
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr z, Jump_005_7276
    ret

Jump_005_7276::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_4536)
Func_005_727A:: ; heuristic: follows a terminator; C0
    call CheckSkillUsableStatusElseResetWDA6E
    ld a, c
    and a, a
    ret z
    call AnyFoeNotBlocked
    ld a, c
    and a, a
    jr z, Jump_005_728F
    call Func_005_4C40
    ld a, c
    and a, a
    jr z, Jump_005_728F
    ret

Jump_005_728F::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_4567)
Func_005_7293:: ; heuristic: follows a terminator; C0
    call Func_005_7261
    ld a, c
    and a, a
    ret z
    call AnyFoeNotBlocked
    ld a, c
    and a, a
    jr z, Jump_005_72A8
    call Func_005_49AA
    ld a, c
    and a, a
    jr z, Jump_005_72A8
    ret

Jump_005_72A8::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_4619)
Func_005_72AC:: ; heuristic: follows a terminator; C0
    call CheckSkillUsableStatusElseResetWDA6E
    ld a, c
    and a, a
    ret z
    call Func_005_4D1A
    ld a, c
    and a, a
    jr z, Jump_005_72BA
    ret

Jump_005_72BA::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_4674)
Func_005_72BE:: ; heuristic: follows a terminator; C0
    call Func_005_7261
    ld a, c
    and a, a
    ret z
    call Func_005_459D
    ld a, c
    and a, a
    jr z, Jump_005_72DA
    call AnyFoeNotBlocked
    ld a, c
    and a, a
    jr z, Jump_005_72DA
    call Func_005_48C9
    ld a, c
    and a, a
    jr z, Jump_005_72DA
    ret

Jump_005_72DA::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_4721)
Func_005_72DE:: ; heuristic: follows a terminator; C0
    call Func_005_7261
    ld a, c
    and a, a
    ret z
    call Func_005_44CF
    ld a, c
    and a, a
    jr z, Jump_005_72F3
    call Func_005_5D9B
    ld a, c
    and a, a
    jr z, Jump_005_72F3
    ret

Jump_005_72F3::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_478E)
Func_005_72F7:: ; heuristic: follows a terminator; C0
    call CheckSkillUsableStatusElseResetWDA6E
    ld a, c
    and a, a
    ret z
    call Func_005_4286
    ld a, c
    cp a, $01
    jr z, Jump_005_7308
    and a, a
    jr z, Jump_005_731E

Jump_005_7308::
    call AnyFoeLacksStatus0Bit6
    ld a, c
    and a, a
    jr z, Jump_005_731E
    call ActorLacksStatus4Bits67
    ld a, c
    and a, a
    jr z, Jump_005_731E
    call Func_005_4741
    ld a, c
    and a, a
    jr z, Jump_005_731E
    ret

Jump_005_731E::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_47AB)
Func_005_7322:: ; heuristic: follows a terminator; C0
    call CheckSkillUsableStatusElseResetWDA6E
    ld a, c
    and a, a
    ret z
    call Func_005_4259
    ld a, c
    and a, a
    jr z, Jump_005_7341
    call Func_005_4949
    ld a, c
    and a, a
    jr z, Jump_005_7341
    farcall Func_005_558B
    ld a, c
    and a, a
    jr z, Jump_005_7341
    ret

Jump_005_7341::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_47CE)
Func_005_7345:: ; heuristic: follows a terminator; C0
    call Func_005_7261
    ld a, c
    and a, a
    ret z
    call AnyFoeLacksStatus0Bit6
    ld a, c
    and a, a
    jr z, Jump_005_736C
    call Func_005_432E
    ld a, c
    cp a, $01
    jr z, Jump_005_735D
    and a, a
    jr z, Jump_005_736C

Jump_005_735D::
    call Func_005_45CF
    ld a, c
    and a, a
    jr z, Jump_005_736C
    call Func_005_4904
    ld a, c
    and a, a
    jr z, Jump_005_736C
    ret

Jump_005_736C::
    call ResetWDA6E
    ret

; 2 call sites from 2 routines (e.g. Func_0E2_4855, Func_0E2_6473)
Func_005_7370:: ; heuristic: follows a terminator; C0
    call Func_005_7261
    ld a, c
    and a, a
    ret z
    call AnyFoeLacksStatus0Bit6
    ld a, c
    and a, a
    jr z, Jump_005_7393
    call Func_005_43F2
    ld a, c
    and a, a
    jr z, Jump_005_7393
    call Func_005_4499
    ld a, c
    and a, a
    jr z, Jump_005_7393
    call Func_005_5E6F
    ld a, c
    and a, a
    jr z, Jump_005_7393
    ret

Jump_005_7393::
    call ResetWDA6E
    ret

; 2 call sites from 2 routines (e.g. Func_0E2_48AE, Func_0E2_648D)
Func_005_7397:: ; heuristic: follows a terminator; C0
    call CheckSkillUsableStatusElseResetWDA6E
    ld a, c
    and a, a
    ret z
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr z, Jump_005_73D3
    call AnyFoeLacksStatus0Bit6
    ld a, c
    and a, a
    jr z, Jump_005_73D3
    call AnyFoeNotBlocked
    ld a, c
    and a, a
    jr z, Jump_005_73D3
    call ActorLacksStatus4Bits67
    ld a, c
    and a, a
    jr z, Jump_005_73D3
    call Func_005_4C5D
    ld a, c
    and a, a
    jr z, Jump_005_73D3
    call Func_005_6198
    ld a, c
    cp a, $01
    jr z, Jump_005_73CB
    and a, a
    jr z, Jump_005_73D3

Jump_005_73CB::
    call Func_005_6452
    ld a, c
    and a, a
    jr z, Jump_005_73D3
    ret

Jump_005_73D3::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_48CF)
Func_005_73D7:: ; heuristic: follows a terminator; C0
    call CheckSkillUsableStatusElseResetWDA6E
    ld a, c
    and a, a
    ret z
    call AnyFoeLacksStatus0Bit6
    ld a, c
    and a, a
    jr z, Jump_005_740C
    call Func_005_432E
    ld a, c
    cp a, $01
    jr z, Jump_005_73EF
    and a, a
    jr z, Jump_005_740C

Jump_005_73EF::
    call AnyFoeNotBlocked
    ld a, c
    and a, a
    jr z, Jump_005_740C
    call ActorLacksStatus4Bits67
    ld a, c
    and a, a
    jr z, Jump_005_740C
    call Func_005_55AA
    ld a, c
    and a, a
    jr z, Jump_005_740C
    call Func_005_55F3
    ld a, c
    and a, a
    jr z, Jump_005_740C
    ret

Jump_005_740C::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_48FD)
Func_005_7410:: ; heuristic: follows a terminator; C0
    call CheckSkillUsableStatusElseResetWDA6E
    ld a, c
    and a, a
    ret z
    call AnyFoeLacksStatus0Bit6
    ld a, c
    and a, a
    jr z, Jump_005_7445
    call Func_005_4373
    ld a, c
    cp a, $01
    jr z, Jump_005_7428
    and a, a
    jr z, Jump_005_7445

Jump_005_7428::
    call Func_005_45E1
    ld a, c
    and a, a
    jr z, Jump_005_7445
    call AnyFoeNotBlocked
    ld a, c
    and a, a
    jr z, Jump_005_7445
    call ActorLacksStatus4Bits67
    ld a, c
    and a, a
    jr z, Jump_005_7445
    call Func_005_5D20
    ld a, c
    and a, a
    jr z, Jump_005_7445
    ret

Jump_005_7445::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_491E)
Func_005_7449:: ; heuristic: follows a terminator; C0
    call CheckSkillUsableStatusElseResetWDA6E
    ld a, c
    and a, a
    ret z
    call AnyFoeLacksStatus0Bit6
    ld a, c
    and a, a
    jr z, Jump_005_747E
    call Func_005_432E
    ld a, c
    cp a, $01
    jr z, Jump_005_7461
    and a, a
    jr z, Jump_005_747E

Jump_005_7461::
    call Func_005_45CF
    ld a, c
    and a, a
    jr z, Jump_005_747E
    call AnyFoeNotBlocked
    ld a, c
    and a, a
    jr z, Jump_005_747E
    call ActorLacksStatus4Bits67
    ld a, c
    and a, a
    jr z, Jump_005_747E
    call Func_005_4D46
    ld a, c
    and a, a
    jr z, Jump_005_747E
    ret

Jump_005_747E::
    call ResetWDA6E
    ret

; 2 call sites from 2 routines (e.g. Func_0E2_493F, Func_0E2_4984)
Func_005_7482:: ; heuristic: follows a terminator; C0
    call CheckSkillUsableStatusElseResetWDA6E
    ld a, c
    and a, a
    ret z
    call ActorLacksStatus4Bits67
    ld a, c
    and a, a
    jr z, Jump_005_7490
    ret

Jump_005_7490::
    call ResetWDA6E
    ret

; runs ActorCanPayMPCost_Bank05, SkillPassesStatus1Bit0Check, SkillPassesSideFlagBit3Check and SkillPassesRepeatCheck in turn; at the first that returns C = 0 it calls ResetWDA6E (E-0071)
; 18 call sites from 18 routines (e.g. Func_005_71AC, Func_005_71BE, Func_005_71DE, Func_005_71F4, ...)
CheckSkillUsableStatusElseResetWDA6E::
Func_005_7494:: ; address name
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, Jump_005_74B1
    call SkillPassesStatus1Bit0Check
    ld a, c
    and a, a
    jr z, Jump_005_74B1
    call SkillPassesSideFlagBit3Check
    ld a, c
    and a, a
    jr z, Jump_005_74B1
    call SkillPassesRepeatCheck
    ld a, c
    and a, a
    jr z, Jump_005_74B1
    ret

Jump_005_74B1::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_4A08)
Func_005_74B5:: ; heuristic: follows a terminator; C0
    call Func_005_74D1
    ld a, c
    and a, a
    ret z
    call ActorLacksStatus4Bits67
    ld a, c
    and a, a
    jr z, Jump_005_74CD
    farcall Func_005_6481
    ld a, c
    and a, a
    jr z, Jump_005_74CD
    ret

Jump_005_74CD::
    call ResetWDA6E
    ret

; 6 call sites from 6 routines (e.g. Func_005_74B5, Func_005_74F9, Func_005_7512, Func_0E2_4AB6, ...)
Func_005_74D1::
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, Jump_005_74F5
    call SkillPassesRepeatCheck
    ld a, c
    and a, a
    jr z, Jump_005_74F5
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr z, Jump_005_74F5
    call AnyFoeLacksStatus2Bit3
    ld a, c
    and a, a
    jr z, Jump_005_74F5
    call Func_005_43F2
    ld a, c
    and a, a
    jr z, Jump_005_74F5
    ret

Jump_005_74F5::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_4B6B)
Func_005_74F9:: ; heuristic: follows a terminator; C0
    call Func_005_74D1
    ld a, c
    and a, a
    ret z
    call Func_005_4183
    ld a, c
    and a, a
    jr z, Jump_005_750E
    call Func_005_4487
    ld a, c
    and a, a
    jr z, Jump_005_750E
    ret

Jump_005_750E::
    call ResetWDA6E
    ret

; 6 call sites from 6 routines (e.g. Func_0E2_4CE6, Func_0E2_4D7B, Func_0E2_4DEC, Func_0E2_4E71, ...)
Func_005_7512:: ; heuristic: follows a terminator; C0
    call Func_005_74D1
    ld a, c
    and a, a
    ret z
    call AnyFoeLacksStatus3And4Bits
    ld a, c
    and a, a
    jr z, Jump_005_7520
    ret

Jump_005_7520::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_4FE1)
Func_005_7524:: ; heuristic: follows a terminator; C0
    call CheckSkillUsableElseResetWDA6E
    ld a, c
    and a, a
    ret z
    call Func_005_481C
    ld a, c
    and a, a
    jr nz, Jump_005_7534
    ld c, $FF
    ret

Jump_005_7534::
    call ResetWDA6E
    ld c, $00
    ret

; 1 call site from 1 routine (e.g. Func_0E2_5068)
Func_005_753A:: ; heuristic: follows a terminator; C0
    call CheckSkillUsableElseResetWDA6E
    ld a, c
    and a, a
    ret z
    call Func_005_4822
    ld a, c
    and a, a
    jr nz, Jump_005_754A
    ld c, $FF
    ret

Jump_005_754A::
    call ResetWDA6E
    ld c, $00
    ret

; 1 call site from 1 routine (e.g. Func_0E2_507A)
Func_005_7550:: ; heuristic: follows a terminator; C0
    call CheckSkillUsableElseResetWDA6E
    ld a, c
    and a, a
    ret z
    call Func_005_4828
    ld a, c
    and a, a
    jr nz, Jump_005_7560
    ld c, $FF
    ret

Jump_005_7560::
    call ResetWDA6E
    ld c, $00
    ret

; 1 call site from 1 routine (e.g. Func_0E2_508C)
Func_005_7566:: ; heuristic: follows a terminator; C0
    call CheckSkillUsableElseResetWDA6E
    ld a, c
    and a, a
    ret z
    call Func_005_482E
    ld a, c
    and a, a
    jr nz, Jump_005_7576
    ld c, $FF
    ret

Jump_005_7576::
    call ResetWDA6E
    ld c, $00
    ret

; 1 call site from 1 routine (e.g. Func_0E2_509E)
Func_005_757C:: ; heuristic: follows a terminator; C0
    call CheckSkillUsableElseResetWDA6E
    ld a, c
    and a, a
    ret z
    call Func_005_4834
    ld a, c
    and a, a
    jr nz, Jump_005_758C
    ld c, $FF
    ret

Jump_005_758C::
    call ResetWDA6E
    ld c, $00
    ret

; 1 call site from 1 routine (e.g. Func_0E2_50B0)
Func_005_7592:: ; heuristic: follows a terminator; C0
    call CheckSkillUsableElseResetWDA6E
    ld a, c
    and a, a
    ret z
    call Func_005_483A
    ld a, c
    and a, a
    jr nz, Jump_005_75A2
    ld c, $FF
    ret

Jump_005_75A2::
    call ResetWDA6E
    ld c, $00
    ret

; 1 call site from 1 routine (e.g. Func_0E2_50C2)
Func_005_75A8:: ; heuristic: follows a terminator; C0
    call CheckSkillUsableElseResetWDA6E
    ld a, c
    and a, a
    ret z
    call Func_005_4840
    ld a, c
    and a, a
    jr nz, Jump_005_75B8
    ld c, $FF
    ret

Jump_005_75B8::
    call ResetWDA6E
    ld c, $00
    ret

; 1 call site from 1 routine (e.g. Func_0E2_50D4)
Func_005_75BE:: ; heuristic: follows a terminator; C0
    call CheckSkillUsableElseResetWDA6E
    ld a, c
    and a, a
    ret z
    call Func_005_4846
    ld a, c
    and a, a
    jr nz, Jump_005_75CE
    ld c, $FF
    ret

Jump_005_75CE::
    call ResetWDA6E
    ld c, $00
    ret

; 1 call site from 1 routine (e.g. Func_0E2_50E6)
Func_005_75D4:: ; heuristic: follows a terminator; C0
    call CheckSkillUsableElseResetWDA6E
    ld a, c
    and a, a
    ret z
    call Func_005_484C
    ld a, c
    and a, a
    jr nz, Jump_005_75E4
    ld c, $FF
    ret

Jump_005_75E4::
    call ResetWDA6E
    ld c, $00
    ret

; 1 call site from 1 routine (e.g. Func_0E2_50F8)
Func_005_75EA:: ; heuristic: follows a terminator; C0
    call CheckSkillUsableElseResetWDA6E
    ld a, c
    and a, a
    ret z
    call Func_005_4852
    ld a, c
    and a, a
    jr nz, Jump_005_75FA
    ld c, $FF
    ret

Jump_005_75FA::
    call ResetWDA6E
    ld c, $00
    ret

; 1 call site from 1 routine (e.g. Func_0E2_510A)
Func_005_7600:: ; heuristic: follows a terminator; C0
    call CheckSkillUsableElseResetWDA6E
    ld a, c
    and a, a
    ret z
    call Func_005_4858
    ld a, c
    and a, a
    jr nz, Jump_005_7610
    ld c, $FF
    ret

Jump_005_7610::
    call ResetWDA6E
    ld c, $00
    ret

; runs ActorCanPayMPCost_Bank05, SkillPassesRepeatCheck, AnyFoeLacksStatus5Bits67, AnyFoeLacksStatus2Bit3 and AnyFoeLacksStatus3And4Bits in turn; at the first that returns C = 0 it calls ResetWDA6E; returns with nothing changed when all pass (E-0071)
; 19 call sites from 19 routines (e.g. Func_005_7524, Func_005_763E, Func_005_753A, Func_005_7686, ...)
CheckSkillUsableElseResetWDA6E::
Func_005_7616:: ; address name
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, Jump_005_763A
    call SkillPassesRepeatCheck
    ld a, c
    and a, a
    jr z, Jump_005_763A
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr z, Jump_005_763A
    call AnyFoeLacksStatus2Bit3
    ld a, c
    and a, a
    jr z, Jump_005_763A
    call AnyFoeLacksStatus3And4Bits
    ld a, c
    and a, a
    jr z, Jump_005_763A
    ret

Jump_005_763A::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_511C)
Func_005_763E:: ; heuristic: follows a terminator; C0
    call CheckSkillUsableElseResetWDA6E
    ld a, c
    and a, a
    ret z
    call Func_005_44BD
    ld a, c
    and a, a
    jr z, Jump_005_7655
    call Func_005_49DD
    ld a, c
    and a, a
    jr z, Jump_005_7655
    ld c, $FF
    ret

Jump_005_7655::
    call ResetWDA6E
    ld c, $00
    ret

; 1 call site from 1 routine (e.g. Func_0E2_51B7)
Func_005_765B:: ; heuristic: follows a terminator; C0
    call Func_005_7686
    ld a, c
    and a, a
    ret z
    call Func_005_4A10
    ld a, c
    and a, a
    jr z, Jump_005_766B
    ld c, $FF
    ret

Jump_005_766B::
    call ResetWDA6E
    ld c, $00
    ret

; 1 call site from 1 routine (e.g. Func_0E2_51C9)
Func_005_7671:: ; heuristic: follows a terminator; C0
    call Func_005_7686
    ld a, c
    and a, a
    ret z
    call Func_005_5D9B
    ld a, c
    jr z, Jump_005_7680
    ld c, $FF
    ret

Jump_005_7680::
    call ResetWDA6E
    ld c, $00
    ret

; 2 call sites from 2 routines (e.g. Func_005_765B, Func_005_7671)
Func_005_7686::
    call CheckSkillUsableElseResetWDA6E
    ld a, c
    and a, a
    ret z
    call Func_005_44CF
    ld a, c
    and a, a
    jr z, Jump_005_769D
    call AnyFoeNotBlocked
    ld a, c
    and a, a
    jr z, Jump_005_769D
    ld c, $FF
    ret

Jump_005_769D::
    call ResetWDA6E
    ld c, $00
    ret

; 1 call site from 1 routine (e.g. Func_0E2_51F6)
Func_005_76A3:: ; heuristic: follows a terminator; C0
    call CheckSkillUsableElseResetWDA6E
    ld a, c
    and a, a
    ret z
    call Func_005_4461
    ld a, c
    and a, a
    jr z, Jump_005_76CA
    call Func_005_4B97
    ld a, c
    and a, a
    jr z, Jump_005_76CA
    call Func_005_5E3F
    ld a, c
    and a, a
    jr z, Jump_005_76CA
    call Func_005_6198
    ld a, c
    cp a, $01
    jr z, Jump_005_76C9
    and a, a
    jr z, Jump_005_76CA

Jump_005_76C9::
    ret

Jump_005_76CA::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_526D)
Func_005_76CE:: ; heuristic: follows a terminator; C0
    call CheckSkillUsableElseResetWDA6E
    ld a, c
    and a, a
    ret z
    call Func_005_6985
    ld a, c
    and a, a
    jr z, Jump_005_76DC
    ret

Jump_005_76DC::
    call ResetWDA6E
    ld c, $00
    ret

; 1 call site from 1 routine (e.g. Func_0E2_530E)
Func_005_76E2:: ; heuristic: follows a terminator; C0
    call CheckSkillUsableElseResetWDA6E
    ld a, c
    and a, a
    ret z
    call Func_005_4B3D
    ld a, c
    and a, a
    jr z, Jump_005_76F2
    ld c, $FF
    ret

Jump_005_76F2::
    call ResetWDA6E
    ld c, $00
    ret

; 1 call site from 1 routine (e.g. Func_0E2_5385)
Func_005_76F8:: ; heuristic: follows a terminator; C0
    call Func_005_770A
    ld a, c
    and a, a
    ret z
    call Func_005_43F2
    ld a, c
    and a, a
    jr z, Jump_005_7706
    ret

Jump_005_7706::
    call ResetWDA6E
    ret

; 3 call sites from 3 routines (e.g. Func_005_76F8, Func_005_7777, Func_005_7812)
Func_005_770A::
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, Jump_005_7727
    call SkillPassesRepeatCheck
    ld a, c
    and a, a
    jr z, Jump_005_7727
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr z, Jump_005_7727
    call AnyFoeLacksStatus2Bit3
    ld a, c
    and a, a
    jr z, Jump_005_7727
    ret

Jump_005_7727::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_5426)
Func_005_772B:: ; heuristic: follows a terminator; C0
    call ActorLacksStatus4Bits67
    ld a, c
    and a, a
    jr z, Jump_005_774B
    call Func_005_4C5D
    ld a, c
    and a, a
    jr z, Jump_005_774B
    call Func_005_53CA
    ld a, c
    and a, a
    jr z, Jump_005_774B
    farcall Func_005_6972
    ld a, c
    and a, a
    jr z, Jump_005_774B
    ret

Jump_005_774B::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_545D)
Func_005_774F:: ; heuristic: follows a terminator; C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, Jump_005_7773
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr z, Jump_005_7773
    call AnyFoeLacksStatus2Bit3
    ld a, c
    and a, a
    jr z, Jump_005_7773
    call AnyFoeLacksStatus3And4Bits
    ld a, c
    and a, a
    jr z, Jump_005_7773
    call ActorLacksStatus4Bits67
    ld a, c
    and a, a
    jr z, Jump_005_7773
    ret

Jump_005_7773::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_54C4)
Func_005_7777:: ; heuristic: follows a terminator; C0
    call Func_005_770A
    call ActorLacksStatus4Bits67
    ld a, c
    and a, a
    jr z, Jump_005_7782
    ret

Jump_005_7782::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_561B)
Func_005_7786:: ; heuristic: follows a terminator; C0
    call Func_005_779F
    ld a, c
    and a, a
    ret z
    call Func_005_443B
    ld a, c
    and a, a
    jr z, Jump_005_779B
    call Func_005_4777
    ld a, c
    and a, a
    jr z, Jump_005_779B
    ret

Jump_005_779B::
    call ResetWDA6E
    ret

; 3 call sites from 3 routines (e.g. Func_005_7786, Func_005_77C7, Func_0E2_56C6)
Func_005_779F::
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, Jump_005_77C3
    call SkillPassesRepeatCheck
    ld a, c
    and a, a
    jr z, Jump_005_77C3
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr z, Jump_005_77C3
    call AnyFoeLacksStatus3And4Bits
    ld a, c
    and a, a
    jr z, Jump_005_77C3
    call ActorLacksStatus4Bits67
    ld a, c
    and a, a
    jr z, Jump_005_77C3
    ret

Jump_005_77C3::
    call ResetWDA6E
    ret

; 2 call sites from 2 routines (e.g. Func_005_77E0, Func_0E2_57A9)
Func_005_77C7:: ; heuristic: follows a terminator; C0
    call Func_005_779F
    ld a, c
    and a, a
    ret z
    call Func_005_43F2
    ld a, c
    and a, a
    jr z, Jump_005_77DC
    call Func_005_5397
    ld a, c
    and a, a
    jr z, Jump_005_77DC
    ret

Jump_005_77DC::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_5856)
Func_005_77E0:: ; heuristic: follows a terminator; C0
    call Func_005_77C7
    ld a, c
    and a, a
    ret z
    call AnyFoeNotBlocked
    ld a, c
    and a, a
    jr z, Jump_005_77F5
    call Func_005_4777
    ld a, c
    and a, a
    jr z, Jump_005_77F5
    ret

Jump_005_77F5::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_5876)
Func_005_77F9:: ; heuristic: follows a terminator; C0
    call Func_005_7812
    ld a, c
    and a, a
    ret z
    call Func_005_44CF
    ld a, c
    and a, a
    jr z, Jump_005_780E
    call Func_005_5D9B
    ld a, c
    and a, a
    jr z, Jump_005_780E
    ret

Jump_005_780E::
    call ResetWDA6E
    ret

; 4 call sites from 4 routines (e.g. Func_005_77F9, Func_005_7824, Func_005_7847, Func_005_7860)
Func_005_7812::
    call Func_005_770A
    ld a, c
    and a, a
    ret z
    call Func_005_4183
    ld a, c
    and a, a
    jr z, Jump_005_7820
    ret

Jump_005_7820::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_58DF)
Func_005_7824:: ; heuristic: follows a terminator; C0
    call Func_005_7812
    ld a, c
    and a, a
    ret z
    call AnyFoeLacksStatus0Bit6
    ld a, c
    and a, a
    jr z, Jump_005_7843
    call Func_005_4A10
    ld a, c
    and a, a
    jr z, Jump_005_7843
    farcall Func_005_5CCE
    ld a, c
    and a, a
    jr z, Jump_005_7843
    ret

Jump_005_7843::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_58EA)
Func_005_7847:: ; heuristic: follows a terminator; C0
    call Func_005_7812
    ld a, c
    and a, a
    ret z
    call Func_005_44BD
    ld a, c
    and a, a
    jr z, Jump_005_785C
    call Func_005_49DD
    ld a, c
    and a, a
    jr z, Jump_005_785C
    ret

Jump_005_785C::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_58F5)
Func_005_7860:: ; heuristic: follows a terminator; C0
    call Func_005_7812
    ld a, c
    and a, a
    ret z
    call Func_005_44AB
    ld a, c
    and a, a
    jr z, Jump_005_7875
    call Func_005_49DD
    ld a, c
    and a, a
    jr z, Jump_005_7875
    ret

Jump_005_7875::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_5900)
Func_005_7879:: ; heuristic: follows a terminator; C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, Jump_005_78A4
    call Func_005_4183
    ld a, c
    and a, a
    jr z, Jump_005_78A4
    call SkillPassesRepeatCheck
    ld a, c
    and a, a
    jr z, Jump_005_78A4
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr z, Jump_005_78A4
    call Func_005_4A43
    ld a, c
    and a, a
    jr z, Jump_005_78A4
    call Func_005_6229
    ld a, c
    and a, a
    jr z, Jump_005_78A4
    ret

Jump_005_78A4::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_591F)
Func_005_78A8:: ; heuristic: follows a terminator; C0
    call Func_005_78EC
    ld a, c
    and a, a
    ret z
    call Func_005_4259
    ld a, c
    and a, a
    jr z, Jump_005_78C6
    call Func_005_4949
    ld a, c
    and a, a
    jr z, Jump_005_78C6
    call Func_005_558B
    ld a, c
    and a, a
    jr z, Jump_005_78C6
    ld c, $FF
    ret

Jump_005_78C6::
    call ResetWDA6E
    ld c, $00
    ret

; 1 call site from 1 routine (e.g. Func_0E2_5970)
Func_005_78CC:: ; heuristic: follows a terminator; C0
    call Func_005_78EC
    ld a, c
    and a, a
    ret z
    call Func_005_43F2
    ld a, c
    and a, a
    jr z, Jump_005_78E8
    call Func_005_4499
    ld a, c
    and a, a
    jr z, Jump_005_78E8
    call AnyFoeNotBlocked
    ld a, c
    and a, a
    jr z, Jump_005_78E8
    ret

Jump_005_78E8::
    call ResetWDA6E
    ret

; 4 call sites from 4 routines (e.g. Func_005_78A8, Func_005_790D, Func_005_78CC, Func_005_791F)
Func_005_78EC::
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, Jump_005_7909
    call Func_005_419E
    ld a, c
    and a, a
    jr z, Jump_005_7909
    call SkillPassesRepeatCheck
    ld a, c
    and a, a
    jr z, Jump_005_7909
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr z, Jump_005_7909
    ret

Jump_005_7909::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_59E5)
Func_005_790D:: ; heuristic: follows a terminator; C0
    call Func_005_78EC
    ld a, c
    and a, a
    ret z
    call Func_005_43F2
    ld a, c
    and a, a
    jr z, Jump_005_791B
    ret

Jump_005_791B::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_5A72)
Func_005_791F:: ; heuristic: follows a terminator; C0
    call Func_005_78EC
    ld a, c
    and a, a
    ret z
    call AnyFoeLacksStatus3And4Bits
    ld a, c
    and a, a
    jr z, Jump_005_7942
    call AnyFoeNotBlocked
    ld a, c
    and a, a
    jr z, Jump_005_7942
    call Func_005_5DCD
    ld a, c
    and a, a
    jr z, Jump_005_7942
    call Func_005_6452
    ld a, c
    and a, a
    jr z, Jump_005_7942
    ret

Jump_005_7942::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_5AE6)
Func_005_7946:: ; heuristic: follows a terminator; C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, Jump_005_7971
    call Func_005_419E
    ld a, c
    and a, a
    jr z, Jump_005_7971
    call SkillPassesRepeatCheck
    ld a, c
    and a, a
    jr z, Jump_005_7971
    call AnyFoeLacksStatus0Bit6
    ld a, c
    and a, a
    jr z, Jump_005_7971
    call Func_005_4B7A
    ld a, c
    and a, a
    jr z, Jump_005_7971
    call Func_005_4DF5
    ld a, c
    and a, a
    jr z, Jump_005_7971
    ret

Jump_005_7971::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_5B3D)
Func_005_7975:: ; heuristic: follows a terminator; C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, Jump_005_7992
    call Func_005_419E
    ld a, c
    and a, a
    jr z, Jump_005_7992
    call SkillPassesRepeatCheck
    ld a, c
    and a, a
    jr z, Jump_005_7992
    call Func_005_626B
    ld a, c
    and a, a
    jr z, Jump_005_7992
    ret

Jump_005_7992::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_5BC4)
Func_005_7996:: ; heuristic: follows a terminator; C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, Jump_005_79C1
    call Func_005_419E
    ld a, c
    and a, a
    jr z, Jump_005_79C1
    call SkillPassesRepeatCheck
    ld a, c
    and a, a
    jr z, Jump_005_79C1
    call AnyFoeNotBlocked
    ld a, c
    and a, a
    jr z, Jump_005_79C1
    call ActorLacksStatus4Bits67
    ld a, c
    and a, a
    jr z, Jump_005_79C1
    call Func_005_4D56
    ld a, c
    and a, a
    jr z, Jump_005_79C1
    ret

Jump_005_79C1::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_5C25)
Func_005_79C5:: ; heuristic: follows a terminator; C0
    call CheckSkillUsableElseResetWDA6E
    ld a, c
    and a, a
    ret z
    call Func_005_459D
    ld a, c
    and a, a
    jr z, Jump_005_79E1
    call AnyFoeNotBlocked
    ld a, c
    and a, a
    jr z, Jump_005_79E1
    call Func_005_48C9
    ld a, c
    and a, a
    jr z, Jump_005_79E1
    ret

Jump_005_79E1::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_5CC2)
Func_005_79E5:: ; heuristic: follows a terminator; C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, Jump_005_7A09
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr z, Jump_005_7A09
    call Func_005_459D
    ld a, c
    and a, a
    jr z, Jump_005_7A09
    call AnyFoeNotBlocked
    ld a, c
    and a, a
    jr z, Jump_005_7A09
    call Func_005_48C9
    ld a, c
    and a, a
    jr z, Jump_005_7A09
    ret

Jump_005_7A09::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_5CCE)
Func_005_7A0D:: ; heuristic: follows a terminator; C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, Jump_005_7A23
    call Func_005_43F2
    ld a, c
    and a, a
    jr z, Jump_005_7A23
    call Func_005_5DFF
    ld a, c
    and a, a
    jr z, Jump_005_7A23
    ret

Jump_005_7A23::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_5D3D)
Func_005_7A27:: ; heuristic: follows a terminator; C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, Jump_005_7A38
    call Func_005_4D6A
    ld a, c
    and a, a
    jr z, Jump_005_7A38
    ld c, $FF
    ret

Jump_005_7A38::
    call ResetWDA6E
    ld c, $00
    ret

; 1 call site from 1 routine (e.g. Func_0E2_5D60)
Func_005_7A3E:: ; heuristic: follows a terminator; C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, Jump_005_7A4F
    call Func_005_4880
    ld a, c
    and a, a
    jr z, Jump_005_7A4F
    ld c, $FF
    ret

Jump_005_7A4F::
    call ResetWDA6E
    ld c, $00
    ret

; 1 call site from 1 routine (e.g. Func_0E2_5D83)
Func_005_7A55:: ; heuristic: follows a terminator; C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, Jump_005_7A66
    call Func_005_4DA5
    ld a, c
    and a, a
    jr z, Jump_005_7A66
    ld c, $FF
    ret

Jump_005_7A66::
    call ResetWDA6E
    ld c, $00
    ret

; 1 call site from 1 routine (e.g. Func_0E2_5DBC)
Func_005_7A6C:: ; heuristic: follows a terminator; C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, Jump_005_7A8D
    call SkillPassesSideFlagBit3Check
    ld a, c
    and a, a
    jr z, Jump_005_7A8D
    call Func_005_432E
    ld a, c
    cp a, $01
    jr z, Jump_005_7A85
    and a, a
    jr z, Jump_005_7A8D

Jump_005_7A85::
    call Func_005_4259
    ld a, c
    and a, a
    jr z, Jump_005_7A8D
    ret

Jump_005_7A8D::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_5DED)
Func_005_7A91:: ; heuristic: follows a terminator; C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, Jump_005_7AA0
    call Func_005_4B5F
    ld a, c
    and a, a
    jr z, Jump_005_7AA0
    ret

Jump_005_7AA0::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_5E46)
Func_005_7AA4:: ; heuristic: follows a terminator; C0
    call Func_005_4183
    ld a, c
    and a, a
    jr z, Jump_005_7AC8
    call ActorLacksStatus4Bits67
    ld a, c
    and a, a
    jr z, Jump_005_7AC8
    call Func_005_4812
    ld a, c
    and a, a
    jr z, Jump_005_7AC8
    call Func_005_53E6
    ld a, c
    and a, a
    jr z, Jump_005_7AC8
    call Func_005_623B
    ld a, c
    and a, a
    jr z, Jump_005_7AC8
    ret

Jump_005_7AC8::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_5E83)
Func_005_7ACC:: ; heuristic: follows a terminator; C0
    call ActorLacksStatus4Bits67
    ld a, c
    and a, a
    jr z, Jump_005_7AD4
    ret

Jump_005_7AD4::
    call ResetWDA6E
    ret

; 3 call sites from 3 routines (e.g. Func_005_7B40, Func_0E2_5EC0, Func_0E2_5FE8)
Func_005_7AD8:: ; heuristic: follows a terminator; C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, Jump_005_7B0D
    call SkillPassesRepeatCheck
    ld a, c
    and a, a
    jr z, Jump_005_7B0D
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr z, Jump_005_7B0D
    call AnyFoeLacksStatus3And4Bits
    ld a, c
    and a, a
    jr z, Jump_005_7B0D
    call Func_005_4664
    ld a, c
    and a, a
    jr z, Jump_005_7B0D
    call Func_005_5DCD
    ld a, c
    and a, a
    jr z, Jump_005_7B0D
    farcall Func_005_6452
    ld a, c
    and a, a
    jr z, Jump_005_7B0D
    ret

Jump_005_7B0D::
    call ResetWDA6E
    ret

; 2 call sites from 2 routines (e.g. Func_0E2_5F0A, Func_0E2_6401)
Func_005_7B11:: ; heuristic: follows a terminator; C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, Jump_005_7B3C
    call SkillPassesRepeatCheck
    ld a, c
    and a, a
    jr z, Jump_005_7B3C
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr z, Jump_005_7B3C
    call AnyFoeLacksStatus3And4Bits
    ld a, c
    and a, a
    jr z, Jump_005_7B3C
    call Func_005_4664
    ld a, c
    and a, a
    jr z, Jump_005_7B3C
    call Func_005_5DCD
    ld a, c
    and a, a
    jr z, Jump_005_7B3C
    ret

Jump_005_7B3C::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_5F94)
Func_005_7B40:: ; heuristic: follows a terminator; C0
    call Func_005_7AD8
    ld a, c
    and a, a
    ret z
    call Func_005_461F
    ld a, c
    and a, a
    jr z, Jump_005_7B58
    farcall Func_005_6452
    ld a, c
    and a, a
    jr z, Jump_005_7B58
    ret

Jump_005_7B58::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_6044)
Func_005_7B5C:: ; heuristic: follows a terminator; C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, Jump_005_7B80
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr z, Jump_005_7B80
    call AnyFoeLacksStatus3And4Bits
    ld a, c
    and a, a
    jr z, Jump_005_7B80
    call Func_005_43F2
    ld a, c
    and a, a
    jr z, Jump_005_7B80
    call Func_005_4664
    ld a, c
    and a, a
    jr z, Jump_005_7B80
    ret

Jump_005_7B80::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_6089)
Func_005_7B84:: ; heuristic: follows a terminator; C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, Jump_005_7BBA
    call Func_005_419E
    ld a, c
    and a, a
    jr z, Jump_005_7BBA
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr z, Jump_005_7BBA
    call AnyFoeLacksStatus3And4Bits
    ld a, c
    and a, a
    jr z, Jump_005_7BBA
    call Func_005_43AD
    ld a, c
    cp a, $01
    jr z, Jump_005_7BAB
    and a, a
    jr z, Jump_005_7BBA

Jump_005_7BAB::
    call Func_005_45F3
    ld a, c
    and a, a
    jr z, Jump_005_7BBA
    call Func_005_4A76
    ld a, c
    and a, a
    jr z, Jump_005_7BBA
    ret

Jump_005_7BBA::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_60A6)
Func_005_7BBE:: ; heuristic: follows a terminator; C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, Jump_005_7BE2
    call SkillPassesRepeatCheck
    ld a, c
    and a, a
    jr z, Jump_005_7BE2
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr z, Jump_005_7BE2
    call Func_005_45E1
    ld a, c
    and a, a
    jr z, Jump_005_7BE2
    call Func_005_63D2
    ld a, c
    and a, a
    jr z, Jump_005_7BE2
    ret

Jump_005_7BE2::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_60D7)
; writes: wDA6E, wDA6F, wDA70, wDA71
Func_005_7BE6:: ; heuristic: follows a terminator; C0
    call Func_005_6452
    ld a, c
    and a, a
    jp z, ResetWDA6E

; 1 call site from 1 routine (e.g. Func_005_7C12)
Func_005_7BEE::
    call Func_005_7C24
    ld a, c
    and a, a
    ret z
    call Func_005_4C5D
    ld a, c
    and a, a
    jr z, Jump_005_7C0E
    call Func_005_6198
    ld a, c
    cp a, $01
    jr z, Jump_005_7C06
    and a, a
    jr z, Jump_005_7C0E

Jump_005_7C06::
    call Func_005_5E3F
    ld a, c
    and a, a
    jr z, Jump_005_7C0E
    ret

Jump_005_7C0E::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_6112)
Func_005_7C12:: ; heuristic: follows a terminator; C0
    call Func_005_7BEE
    ld a, c
    and a, a
    ret z
    call Func_005_459D
    ld a, c
    and a, a
    jr z, Jump_005_7C20
    ret

Jump_005_7C20::
    call ResetWDA6E
    ret

; 4 call sites from 4 routines (e.g. Func_005_7BEE, Func_005_7C45, Func_005_7C82, Func_005_7CA2)
Func_005_7C24::
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, Jump_005_7C41
    call SkillPassesRepeatCheck
    ld a, c
    and a, a
    jr z, Jump_005_7C41
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr z, Jump_005_7C41
    call AnyFoeLacksStatus0Bit6
    ld a, c
    and a, a
    jr z, Jump_005_7C41
    ret

Jump_005_7C41::
    call ResetWDA6E
    ret

; 2 call sites from 2 routines (e.g. Func_005_7C69, Func_0E2_6139)
Func_005_7C45:: ; heuristic: follows a terminator; C0
    call Func_005_7C24
    ld a, c
    and a, a
    ret z
    call AnyFoeNotBlocked
    ld a, c
    and a, a
    jr z, Jump_005_7C65
    call Func_005_6198
    ld a, c
    cp a, $01
    jr z, Jump_005_7C5D
    and a, a
    jr z, Jump_005_7C65

Jump_005_7C5D::
    call Func_005_5E3F
    ld a, c
    and a, a
    jr z, Jump_005_7C65
    ret

Jump_005_7C65::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_6160)
Func_005_7C69:: ; heuristic: follows a terminator; C0
    call Func_005_7C45
    ld a, c
    and a, a
    ret z
    call Func_005_6452
    ld a, c
    and a, a
    jr z, Jump_005_7C7E
    call Func_005_5397
    ld a, c
    and a, a
    jr z, Jump_005_7C7E
    ret

Jump_005_7C7E::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_618D)
Func_005_7C82:: ; heuristic: follows a terminator; C0
    call Func_005_7C24
    ld a, c
    and a, a
    ret z
    call AnyFoeNotBlocked
    ld a, c
    and a, a
    jr z, Jump_005_7C9E
    call Func_005_4754
    ld a, c
    and a, a
    jr z, Jump_005_7C9E
    call Func_005_63D2
    ld a, c
    and a, a
    jr z, Jump_005_7C9E
    ret

Jump_005_7C9E::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_61C2)
Func_005_7CA2:: ; heuristic: follows a terminator; C0
    call Func_005_7C24
    ld a, c
    and a, a
    ret z
    call AnyFoeNotBlocked
    ld a, c
    and a, a
    jr z, Jump_005_7CBE
    call Func_005_4767
    ld a, c
    and a, a
    jr z, Jump_005_7CBE
    call Func_005_63D2
    ld a, c
    and a, a
    jr z, Jump_005_7CBE
    ret

Jump_005_7CBE::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_61CD)
Func_005_7CC2:: ; heuristic: follows a terminator; C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, Jump_005_7CE3
    call AnyFoeLacksStatus0Bit6
    ld a, c
    and a, a
    jr z, Jump_005_7CE3
    call Func_005_44E1
    ld a, c
    cp a, $01
    jr z, Jump_005_7CDB
    and a, a
    jr z, Jump_005_7CE3

Jump_005_7CDB::
    call Func_005_61B1
    ld a, c
    and a, a
    jr z, Jump_005_7CE3
    ret

Jump_005_7CE3::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_61E0)
Func_005_7CE7:: ; heuristic: follows a terminator; C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, Jump_005_7CEF
    ret

Jump_005_7CEF::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_6249)
Func_005_7CF3:: ; heuristic: follows a terminator; C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, Jump_005_7D57
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr z, Jump_005_7D57
    call AnyFoeLacksStatus3And4Bits
    ld a, c
    and a, a
    jr z, Jump_005_7D57
    call Func_005_4259
    ld a, c
    and a, a
    jr z, Jump_005_7D57
    call AnyFoeLacksStatus0Bit6
    ld a, c
    and a, a
    jr z, Jump_005_7D57
    call Func_005_4373
    ld a, c
    cp a, $01
    jr z, Jump_005_7D21
    and a, a
    jr z, Jump_005_7D57

Jump_005_7D21::
    call Func_005_4499
    ld a, c
    and a, a
    jr z, Jump_005_7D57
    call Func_005_45E1
    ld a, c
    and a, a
    jr z, Jump_005_7D57
    call Func_005_4767
    ld a, c
    and a, a
    jr z, Jump_005_7D57
    call Func_005_5397
    ld a, c
    and a, a
    jr z, Jump_005_7D57
    call Func_005_6198
    ld a, c
    cp a, $01
    jr z, Jump_005_7D48
    and a, a
    jr z, Jump_005_7D57

Jump_005_7D48::
    call Func_005_53E6
    ld a, c
    and a, a
    jr z, Jump_005_7D57
    call Func_005_6452
    ld a, c
    and a, a
    jr z, Jump_005_7D57
    ret

Jump_005_7D57::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_62A4)
Func_005_7D5B:: ; heuristic: follows a terminator; C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, Jump_005_7D91
    call SkillPassesRepeatCheck
    ld a, c
    and a, a
    jr z, Jump_005_7D91
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr z, Jump_005_7D91
    call Func_005_44CF
    ld a, c
    and a, a
    jr z, Jump_005_7D91
    call AnyFoeNotBlocked
    ld a, c
    and a, a
    jr z, Jump_005_7D91
    call Func_005_6198
    ld a, c
    cp a, $01
    jr z, Jump_005_7D89
    and a, a
    jr z, Jump_005_7D91

Jump_005_7D89::
    call Func_005_5E3F
    ld a, c
    and a, a
    jr z, Jump_005_7D91
    ret

Jump_005_7D91::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_6303)
Func_005_7D95:: ; heuristic: follows a terminator; C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, Jump_005_7DA4
    call Func_005_64DF
    ld a, c
    and a, a
    jr z, Jump_005_7DA4
    ret

Jump_005_7DA4::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_6350)
Func_005_7DA8:: ; heuristic: follows a terminator; C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, Jump_005_7DBE
    call Func_005_4B7A
    ld a, c
    and a, a
    jr z, Jump_005_7DBE
    call Func_005_4DF5
    ld a, c
    and a, a
    jr z, Jump_005_7DBE
    ret

Jump_005_7DBE::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_6387)
Func_005_7DC2:: ; heuristic: follows a terminator; C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, Jump_005_7DD8
    call SkillPassesRepeatCheck
    ld a, c
    and a, a
    jr z, Jump_005_7DD8
    call Func_005_626B
    ld a, c
    and a, a
    jr z, Jump_005_7DD8
    ret

Jump_005_7DD8::
    call ResetWDA6E
    ret

; 2 call sites from 2 routines (e.g. Func_0E2_63FA, Func_0E2_641E)
Func_005_7DDC:: ; heuristic: follows a terminator; C0
    call SetCToZero
    ld a, c
    and a, a
    jr z, Jump_005_7DE4
    ret

Jump_005_7DE4::
    call ResetWDA6E
    ret

; 1 call site from 1 routine (e.g. Func_0E2_6425)
Func_005_7DE8:: ; heuristic: follows a terminator; C0
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr z, Jump_005_7E10
    call Func_005_44CF
    ld a, c
    and a, a
    jr z, Jump_005_7E10
    call AnyFoeNotBlocked
    ld a, c
    and a, a
    jr z, Jump_005_7E10
    call Func_005_6198
    ld a, c
    cp a, $01
    jr z, Jump_005_7E08
    and a, a
    jr z, Jump_005_7E10

Jump_005_7E08::
    call Func_005_5E3F
    ld a, c
    and a, a
    jr z, Jump_005_7E10
    ret

Jump_005_7E10::
    call ResetWDA6E
    ret
    ds $1EC, $00
