SECTION "Bank 39", ROMX[$4000], BANK[$39]
    db $39

; wBattleActionId = wBattleActionChoice[2 * actor]; with mode = wDA53[actor], the entry at Data_039_41AC + 4 * mode holds two per-action routine tables, the second used for actors in slots 4-7 when wC58A is 0 or 2, the first otherwise; calls the routine for the action (JumpToWordAtHL), which writes a slot number to wBattleTargetChoice[2 * actor] (E-0061)
; 8 call sites from 7 routines (e.g. ChooseTargetForActor, Func_032_4D99, Func_032_4ADC_Case01_Case02, Func_032_5820_Case00, ...)
; reads: wBattleActor, wC58A
; writes: wBattleActionId
; points at: wBattleActionChoice, wDA53
ChooseActionTarget::
Func_039_4001:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleActionChoice
    add a, a
    add_a_to_hl
    ld a, [hl]
    ld [wBattleActionId], a
    ld c, a
    ld b, $00
    ld a, [wBattleActor]
    ld hl, wDA53
    add_a_to_hl
    ld a, [hl]
    ld hl, Data_039_41AC
    add a, a
    add a, a
    add_a_to_hl
    ld a, [wC58A]
    or a, a
    jr z, Jump_039_4037
    cp a, $02
    jr z, Jump_039_4037
    xor a, a
    jr Jump_039_403D

Jump_039_4037::
    ld a, [wBattleActor]
    and a, $04
    rrca

Jump_039_403D::
    add_a_to_hl
    deref_hl
    add hl, bc
    add hl, bc
    call JumpToWordAtHL
    ret

; target = a present slot of the opposite three (slots 4-6 for actors 0-3, 0-2 for 4-7): the first present one, then each later present one replaces it when wC5E7 bit 7 is set after AdvanceRandom, so the last is favoured; $FF when none is present (E-0061)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wC5E7
; points at: wBattleTargetChoice
TargetRandomFoe:: ; heuristic: follows a terminator; C0
Func_039_404B:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    jp Jump_039_417C

; target = the slot in wDA2D[2 * actor] when that slot is present, else TargetRandomFoe (E-0061)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wC5E7
; points at: wDA2D, wBattleTargetChoice
TargetSavedSlotOrRandomFoe:: ; heuristic: follows a terminator; C0
Func_039_4055:: ; address name
    ld a, [wBattleActor]
    add a, a
    ld hl, wDA2D
    add_a_to_hl
    ld a, [hl]
    ld c, a
    call CarryUnlessWDA63SlotEmpty
    jr nc, Jump_039_406A
    jr TargetRandomFoe

Jump_039_406A::
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld [hl], c
    ret

; target = the first present slot of the opposite three; base + 3 when none is present (E-0061)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wBattleTargetChoice
TargetFirstFoe:: ; heuristic: follows a terminator; C0
Func_039_4078:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_039_4082::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr nc, Jump_039_408C
    inc c
    dec b
    jr nz, Jump_039_4082

Jump_039_408C::
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld [hl], c
    ret
    db $FA, $A4, $D8, $E6, $04, $C3, $7C, $41

; target = the first present slot of the actor's own three (the actor included); base + 3 when none is present (E-0061)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wBattleTargetChoice
TargetFirstAlly:: ; heuristic: target of a pointer table; C0
Func_039_40A2:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03

Jump_039_40AA::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr nc, Jump_039_40B4
    inc c
    dec b
    jr nz, Jump_039_40AA

Jump_039_40B4::
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld [hl], c
    ret

; target = one of the actor's own three slots by coin flips (wC5E7 bit 7), the later ones favoured; presence is not checked (E-0061)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wC5E7
; points at: wBattleTargetChoice
TargetRandomAllySlot:: ; heuristic: target of a pointer table; C0
Func_039_40C2:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03
    ld d, c

Jump_039_40CB::
    call AdvanceRandom
    ld a, [wC5E7]
    bit 7, a
    jr z, Jump_039_40D6
    ld d, c

Jump_039_40D6::
    inc c
    dec b
    jr nz, Jump_039_40CB
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld [hl], d
    ret
    INCBIN "dwm2-cobi-us.gbc", $0E40E8, $43

; target = wBattleActor; the per-action entry used most often (334 table entries) (E-0061)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wBattleTargetChoice
TargetSelf:: ; heuristic: target of a pointer table; C0
Func_039_412B:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld a, [wBattleActor]
    ld [hl], a
    ret

; target = wBattleActor & 4, slot 0 or 4 of the actor's side; presence is not checked (E-0061)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wBattleTargetChoice
TargetOwnSideFirstSlot:: ; heuristic: target of a pointer table; C0
Func_039_413C:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld a, [wBattleActor]
    and a, $04
    ld [hl], a
    ret

; target = a random slot (wC5E7 & 7 after AdvanceRandom) that is not the actor, is present and is not slot 3 or 7; retries until one is found (E-0061)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wC5E7
; points at: wBattleTargetChoice
TargetRandomOtherSlot:: ; heuristic: target of a pointer table; C0
Func_039_414F:: ; address name
    ld a, [wBattleActor]
    ld e, a

Jump_039_4153::
    call AdvanceRandom
    ld a, [wC5E7]
    and a, $07
    cp a, e
    jr z, Jump_039_4153
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_4153
    and a, $03
    cp a, $03
    jr z, Jump_039_4153
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld a, [wC5E7]
    and a, $07
    ld [hl], a
    ret

Jump_039_417C::
    ld c, a
    ld b, $03
    ld d, $FF

Jump_039_4181::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_419A
    ld a, d
    cp a, $FF
    jr nz, Jump_039_418F
    ld d, c
    jr Jump_039_419A

Jump_039_418F::
    call AdvanceRandom
    ld a, [wC5E7]
    bit 7, a
    jr z, Jump_039_419A
    ld d, c

Jump_039_419A::
    inc c
    dec b
    jr nz, Jump_039_4181
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld [hl], d
    ret

Data_039_41AC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0E41AC, $7E
    dw TargetFirstAlly
    dw TargetSelf
    dw TargetSelf
    dw TargetFirstAlly
    dw TargetFirstAlly
    INCBIN "dwm2-cobi-us.gbc", $0E4234, $96
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    db $4B, $40, $4B, $40, $4B, $40, $78, $40, $4B, $40, $78, $40, $4B, $40, $78, $40
    db $4B, $40, $2B, $41, $2B, $41, $2B, $41, $E8, $40
    dw TargetFirstAlly
    dw TargetSelf
    dw TargetFirstAlly
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    ds $10, $00
    db $4B, $40, $2B, $41, $2B, $41, $00, $00, $00, $00, $00, $00, $78, $40, $A2, $40
    db $78, $40, $78, $40, $A2, $40, $78, $40, $78, $40, $2B, $41, $2B, $41, $78, $40
    db $78, $40, $3C, $41, $A2, $40, $78, $40, $00, $00, $2B, $41, $E8, $40, $4B, $40
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    INCBIN "dwm2-cobi-us.gbc", $0E4358, $9C
    dw TargetSelf
    dw TargetSelf
    dw TargetFirstAlly
    dw TargetFirstAlly
    INCBIN "dwm2-cobi-us.gbc", $0E43FC, $96
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    db $4B, $40, $4B, $40, $4B, $40, $78, $40, $4B, $40, $78, $40, $4B, $40, $78, $40
    db $4B, $40, $2B, $41, $2B, $41, $2B, $41, $E8, $40
    dw TargetFirstAlly
    dw TargetSelf
    dw TargetFirstAlly
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    ds $10, $00
    db $4B, $40, $2B, $41, $2B, $41, $4B, $40, $2B, $41, $00, $00, $78, $40, $A2, $40
    db $78, $40, $78, $40, $A2, $40, $78, $40, $78, $40, $2B, $41, $2B, $41, $78, $40
    db $78, $40, $3C, $41, $A2, $40, $78, $40, $00, $00, $2B, $41, $E8, $40, $4B, $40
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    db $4B, $40, $2B, $41, $3C, $41, $A2, $40, $78, $40, $4B, $40, $4B, $40, $4B, $40
    db $4B, $40, $78, $40, $78, $40, $4B, $40, $4B, $40, $78, $40, $A2, $40, $78, $40
    db $2B, $41, $A2, $40, $78, $40, $4B, $40, $2B, $41, $78, $40
    dw TargetSelf
    dw TargetSelf
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $91, $66
    db $78, $40, $78, $40
    dw ChooseTarget_Heal_6C75
    dw ChooseTarget_Heal_6C75
    dw ChooseTarget_Heal_6C75
    dw TargetFirstAlly
    dw TargetFirstAlly
    dw ChooseTarget_MPass
    dw ChooseTarget_MPass
    dw ChooseTarget_MPass
    dw TargetRandomAllySlot
    dw TargetRandomAllySlot
    dw TargetOwnSideFirstSlot
    dw ChooseTarget_Antidote_6AFD
    dw TargetFirstAlly
    dw TargetFirstAlly
    dw TargetFirstAlly
    dw ChooseTarget_Upper_6B0A
    dw TargetFirstAlly
    dw ChooseTarget_Sap_6BB0
    db $78, $40, $5D, $6B, $A2, $40, $B6, $6B, $78, $40, $9A, $40, $78, $40, $91, $66
    db $78, $40, $2B, $41, $4B, $40, $78, $40, $78, $40
    dw TargetFirstAlly
    dw TargetSelf
    dw TargetSelf
    dw TargetFirstAlly
    dw TargetFirstAlly
    db $4B, $40, $2B, $41, $2B, $41, $91, $66, $78, $40, $78, $40, $78, $40, $78, $40
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $91, $66, $78, $40
    db $78, $40, $78, $40, $91, $66, $78, $40, $4B, $40, $4B, $40
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    db $4B, $40, $78, $40, $78, $40
    dw TargetFoeWeightedBySlotOrder
    dw TargetSelf
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetRandomOtherSlot
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $4B, $40, $4B, $40, $78, $40
    db $78, $40, $78, $40, $3C, $41, $A2, $40, $2B, $41, $78, $40, $78, $40, $78, $40
    db $A2, $40, $4B, $40, $78, $40, $78, $40
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    db $78, $40, $91, $66, $78, $40, $4B, $40, $78, $40
    dw TargetFoeWeightedBySlotOrder
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    db $E8, $40
    dw TargetFirstAlly
    dw TargetSelf
    dw TargetFirstAlly
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    ds $10, $00
    db $4B, $40, $2B, $41, $2B, $41, $00, $00, $00, $00, $00, $00, $78, $40, $A2, $40
    db $78, $40, $78, $40, $A2, $40, $78, $40, $78, $40, $2B, $41, $2B, $41, $78, $40
    db $78, $40, $3C, $41, $A2, $40, $78, $40, $00, $00, $2B, $41, $E8, $40, $4B, $40
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    db $55, $40, $2B, $41, $3C, $41, $A2, $40, $78, $40
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    db $78, $40, $78, $40, $91, $66, $91, $66, $78, $40, $A2, $40, $78, $40, $2B, $41
    db $A2, $40, $78, $40, $91, $66, $2B, $41, $78, $40
    dw TargetSelf
    dw TargetSelf
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $91, $66
    db $78, $40, $78, $40
    dw ChooseTarget_Heal_6C75
    dw ChooseTarget_Heal_6C75
    dw ChooseTarget_Heal_6C75
    dw TargetFirstAlly
    dw TargetFirstAlly
    dw ChooseTarget_MPass
    dw ChooseTarget_MPass
    dw ChooseTarget_MPass
    dw TargetRandomAllySlot
    dw TargetRandomAllySlot
    dw TargetOwnSideFirstSlot
    dw ChooseTarget_Antidote_6AFD
    dw TargetFirstAlly
    dw TargetFirstAlly
    dw TargetFirstAlly
    dw ChooseTarget_Upper_6B0A
    dw TargetFirstAlly
    dw ChooseTarget_Sap_6BB0
    db $78, $40, $5D, $6B, $A2, $40, $B6, $6B, $78, $40, $9A, $40, $78, $40, $91, $66
    db $78, $40, $2B, $41, $4B, $40, $78, $40, $00, $00, $00, $00
    dw TargetSelf
    dw TargetSelf
    dw TargetFirstAlly
    dw TargetFirstAlly
    db $4B, $40, $2B, $41, $2B, $41, $91, $66, $78, $40, $78, $40, $78, $40, $78, $40
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $91, $66, $78, $40
    db $78, $40, $78, $40, $91, $66, $78, $40, $4B, $40, $4B, $40
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    db $4B, $40, $78, $40, $78, $40
    dw TargetFoeWeightedBySlotOrder
    dw TargetSelf
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetRandomOtherSlot
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $4B, $40, $4B, $40, $78, $40
    db $78, $40, $78, $40, $3C, $41, $A2, $40, $2B, $41, $78, $40, $78, $40, $78, $40
    db $A2, $40, $4B, $40, $78, $40, $78, $40
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    db $78, $40, $91, $66, $78, $40, $4B, $40, $78, $40
    dw TargetFoeWeightedBySlotOrder
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    db $E8, $40
    dw TargetFirstAlly
    dw TargetSelf
    dw TargetFirstAlly
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    ds $10, $00
    db $4B, $40, $2B, $41, $2B, $41, $4B, $40, $2B, $41, $00, $00, $78, $40, $A2, $40
    db $78, $40, $78, $40, $A2, $40, $78, $40, $78, $40, $2B, $41, $2B, $41, $78, $40
    db $78, $40, $3C, $41, $A2, $40, $78, $40, $00, $00, $2B, $41, $E8, $40, $4B, $40
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetFoeWeightedBySlotOrder
    dw TargetSelf
    dw TargetOwnSideFirstSlot
    dw TargetFirstAlly
    db $78, $40
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    db $78, $40, $78, $40, $91, $66, $91, $66, $78, $40, $A2, $40, $78, $40, $2B, $41
    db $A2, $40, $78, $40, $91, $66, $2B, $41, $78, $40
    dw TargetSelf
    dw TargetSelf
    dw ChooseTarget_SquallHit
    dw ChooseTarget_Blaze
    dw ChooseTarget_Blaze
    dw ChooseTarget_Blaze
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $03, $5E
    db $78, $40, $78, $40
    dw ChooseTarget_Heal
    dw ChooseTarget_Heal
    dw ChooseTarget_Heal
    dw TargetFirstAlly
    dw TargetFirstAlly
    db $E8, $40, $E8, $40, $E8, $40
    dw ChooseTarget_Vivify
    dw ChooseTarget_Vivify
    dw TargetOwnSideFirstSlot
    dw ChooseTarget_Antidote
    dw TargetFirstAlly
    dw TargetFirstAlly
    dw TargetFirstAlly
    dw ChooseTarget_Upper
    dw TargetFirstAlly
    dw ChooseTarget_Sap
    db $78, $40, $6B, $59, $A2, $40, $11, $59, $78, $40, $D8, $57, $78, $40, $ED, $60
    db $78, $40, $2B, $41, $4B, $61, $78, $40, $78, $40
    dw TargetFirstAlly
    dw TargetSelf
    dw TargetSelf
    dw TargetFirstAlly
    dw TargetFirstAlly
    dw ChooseTarget_Transform
    dw TargetSelf
    dw TargetSelf
    dw ChooseTarget_MegaMagic
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40
    db $78, $40, $78, $40, $A5, $63, $78, $40, $78, $40, $78, $40, $5C, $65, $78, $40
    db $4B, $40, $4B, $40
    dw ChooseTarget_FireSlash
    dw ChooseTarget_VacuSlash
    dw ChooseTarget_BoltSlash
    dw ChooseTarget_IceSlash
    dw ChooseTarget_SlimeBlow
    dw ChooseTarget_DrakSlash
    dw ChooseTarget_BeastCut
    dw ChooseTarget_BirdBlow
    dw ChooseTarget_BugBlow
    dw ChooseTarget_Shears
    dw ChooseTarget_DevilCut
    dw ChooseTarget_ZombieCut
    dw ChooseTarget_CleanCut
    dw ChooseTarget_AquaCut
    dw ChooseTarget_MetalCut
    dw ChooseTarget_PoisonHit
    dw ChooseTarget_Paralyze
    dw ChooseTarget_NapAttack
    dw ChooseTarget_SquallHit
    dw ChooseTarget_SquallHit
    db $4B, $40, $78, $40, $78, $40
    dw ChooseTarget_GigaSlash
    dw TargetSelf
    dw ChooseTarget_SquallHit
    dw ChooseTarget_SquallHit
    dw ChooseTarget_SquallHit
    dw TargetRandomOtherSlot
    dw ChooseTarget_SquallHit
    dw ChooseTarget_SquallHit
    dw ChooseTarget_Ramming
    dw ChooseTarget_Ramming
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $F9, $5B, $F9, $5B, $78, $40
    db $78, $40, $78, $40, $3C, $41, $A2, $40, $2B, $41, $78, $40, $78, $40, $78, $40
    db $A2, $40, $CB, $59, $78, $40, $78, $40
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw ChooseTarget_LushLicks
    dw ChooseTarget_SickLick
    dw ChooseTarget_LegSweep
    db $78, $40, $67, $5D, $78, $40, $4B, $40, $78, $40
    dw ChooseTarget_MouthShut
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw ChooseTarget_Cover
    dw TargetFirstAlly
    dw TargetSelf
    dw TargetFirstAlly
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    ds $10, $00
    db $4B, $40, $2B, $41, $2B, $41, $00, $00, $00, $00, $00, $00, $78, $40, $A2, $40
    db $78, $40, $78, $40, $A2, $40, $78, $40, $78, $40, $2B, $41, $2B, $41, $78, $40
    db $78, $40, $3C, $41, $A2, $40, $78, $40, $00, $00, $2B, $41, $E8, $40, $4B, $40
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    db $55, $40, $2B, $41, $3C, $41, $A2, $40, $78, $40
    dw ChooseTarget_Blaze
    dw ChooseTarget_SquallHit
    dw ChooseTarget_SquallHit
    dw ChooseTarget_SquallHit
    db $78, $40, $78, $40, $90, $53, $90, $53, $78, $40, $A2, $40, $78, $40, $2B, $41
    db $A2, $40, $78, $40, $0E, $5F, $2B, $41, $78, $40
    dw TargetSelf
    dw TargetSelf
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $91, $66
    db $78, $40, $78, $40
    dw ChooseTarget_Heal_67AD
    dw ChooseTarget_Heal_67AD
    dw ChooseTarget_Heal_67AD
    dw TargetFirstAlly
    dw TargetFirstAlly
    db $E8, $40, $E8, $40, $E8, $40
    dw ChooseTarget_Vivify_6998
    dw ChooseTarget_Vivify_6998
    dw TargetOwnSideFirstSlot
    dw ChooseTarget_Antidote_699B
    dw TargetFirstAlly
    dw TargetFirstAlly
    dw TargetFirstAlly
    dw ChooseTarget_Upper_69A1
    dw TargetFirstAlly
    dw ChooseTarget_Sap_69A4
    db $78, $40, $AA, $69, $A2, $40, $A7, $69, $78, $40, $9E, $69, $78, $40, $91, $66
    db $78, $40, $2B, $41, $13, $6A, $78, $40, $00, $00, $00, $00
    dw TargetSelf
    dw TargetSelf
    dw TargetFirstAlly
    dw TargetFirstAlly
    dw ChooseTarget_Transform_6A04
    dw TargetSelf
    dw TargetSelf
    dw TargetFoeWeightedBySlotOrder
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40
    db $78, $40, $78, $40, $91, $66, $78, $40, $78, $40, $78, $40, $91, $66, $78, $40
    db $4B, $40, $4B, $40
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw ChooseTarget_SlimeBlow_69E9
    dw ChooseTarget_DrakSlash_69C5
    dw ChooseTarget_BeastCut_69CB
    dw ChooseTarget_BirdBlow_69D1
    dw ChooseTarget_BugBlow_69EF
    dw ChooseTarget_Shears_69F5
    dw ChooseTarget_DevilCut_69D7
    dw ChooseTarget_ZombieCut_69DD
    dw ChooseTarget_CleanCut_69E3
    dw TargetFoeWeightedBySlotOrder
    dw ChooseTarget_MetalCut_69C2
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    db $4B, $40, $78, $40, $78, $40
    dw TargetFoeWeightedBySlotOrder
    dw TargetSelf
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetRandomOtherSlot
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $BF, $69, $BF, $69, $78, $40
    db $78, $40, $78, $40, $3C, $41, $A2, $40, $2B, $41, $78, $40, $78, $40, $78, $40
    db $A2, $40, $AD, $69, $78, $40, $78, $40
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetFoeWeightedBySlotOrder
    dw ChooseTarget_SickLick_69B6
    dw ChooseTarget_LegSweep_69B9
    db $78, $40, $91, $66, $78, $40, $4B, $40, $78, $40
    dw ChooseTarget_MouthShut_69B3
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw ChooseTarget_Cover_69B0
    dw TargetFirstAlly
    dw TargetSelf
    dw TargetFirstAlly
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    ds $10, $00
    db $4B, $40
    dw TargetSelf
    dw TargetSelf
    dw TargetFoeWeightedBySlotOrder
    dw TargetSelf
    db $00, $00, $78, $40, $A2, $40, $78, $40, $78, $40, $A2, $40, $78, $40, $78, $40
    db $2B, $41, $2B, $41, $78, $40, $78, $40, $3C, $41, $A2, $40, $78, $40, $00, $00
    db $2B, $41, $E8, $40, $4B, $40
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetFoeWeightedBySlotOrder
    dw TargetSelf
    dw TargetOwnSideFirstSlot
    dw TargetFirstAlly
    db $78, $40
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    db $78, $40, $78, $40, $91, $66, $91, $66, $78, $40, $A2, $40, $78, $40, $2B, $41
    db $A2, $40, $78, $40, $91, $66, $2B, $41, $78, $40
    dw TargetSelf
    dw TargetSelf
    dw ChooseTarget_SquallHit
    dw ChooseTarget_Blaze
    dw ChooseTarget_Blaze
    dw ChooseTarget_Blaze
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $03, $5E
    db $78, $40, $78, $40
    dw ChooseTarget_Heal
    dw ChooseTarget_Heal
    dw ChooseTarget_Heal
    dw TargetFirstAlly
    dw TargetFirstAlly
    db $E8, $40, $E8, $40, $E8, $40
    dw ChooseTarget_Vivify
    dw ChooseTarget_Vivify
    dw TargetOwnSideFirstSlot
    dw ChooseTarget_Antidote
    dw TargetFirstAlly
    dw TargetFirstAlly
    dw TargetFirstAlly
    dw ChooseTarget_Upper
    dw TargetFirstAlly
    dw ChooseTarget_Sap
    db $78, $40, $6B, $59, $A2, $40, $11, $59, $78, $40, $D8, $57, $78, $40, $ED, $60
    db $78, $40, $2B, $41, $4B, $61, $78, $40, $78, $40
    dw TargetFirstAlly
    dw TargetSelf
    dw TargetSelf
    dw TargetFirstAlly
    dw TargetFirstAlly
    dw ChooseTarget_Transform
    dw TargetSelf
    dw TargetSelf
    dw ChooseTarget_MegaMagic
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40
    db $78, $40, $78, $40, $A5, $63, $78, $40, $78, $40, $78, $40, $5C, $65, $78, $40
    db $4B, $40, $4B, $40
    dw ChooseTarget_FireSlash
    dw ChooseTarget_VacuSlash
    dw ChooseTarget_BoltSlash
    dw ChooseTarget_IceSlash
    dw ChooseTarget_SlimeBlow
    dw ChooseTarget_DrakSlash
    dw ChooseTarget_BeastCut
    dw ChooseTarget_BirdBlow
    dw ChooseTarget_BugBlow
    dw ChooseTarget_Shears
    dw ChooseTarget_DevilCut
    dw ChooseTarget_ZombieCut
    dw ChooseTarget_CleanCut
    dw ChooseTarget_AquaCut
    dw ChooseTarget_MetalCut
    dw ChooseTarget_PoisonHit
    dw ChooseTarget_Paralyze
    dw ChooseTarget_NapAttack
    dw ChooseTarget_SquallHit
    dw ChooseTarget_SquallHit
    db $4B, $40, $78, $40, $78, $40
    dw ChooseTarget_GigaSlash
    dw TargetSelf
    dw ChooseTarget_SquallHit
    dw ChooseTarget_SquallHit
    dw ChooseTarget_SquallHit
    dw TargetRandomOtherSlot
    dw ChooseTarget_SquallHit
    dw ChooseTarget_SquallHit
    dw ChooseTarget_Ramming
    dw ChooseTarget_Ramming
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $F9, $5B, $F9, $5B, $78, $40
    db $78, $40, $78, $40, $3C, $41, $A2, $40, $2B, $41, $78, $40, $78, $40, $78, $40
    db $A2, $40, $CB, $59, $78, $40, $78, $40
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw ChooseTarget_LushLicks
    dw ChooseTarget_SickLick
    dw ChooseTarget_LegSweep
    db $78, $40, $67, $5D, $78, $40, $4B, $40, $78, $40
    dw ChooseTarget_MouthShut
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw ChooseTarget_Cover
    dw TargetFirstAlly
    dw TargetSelf
    dw TargetFirstAlly
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    ds $10, $00
    db $4B, $40, $2B, $41, $2B, $41, $00, $00, $00, $00, $00, $00, $78, $40, $A2, $40
    db $78, $40, $78, $40, $A2, $40, $78, $40, $78, $40, $2B, $41, $2B, $41, $78, $40
    db $78, $40, $3C, $41, $A2, $40, $78, $40, $00, $00, $2B, $41, $E8, $40, $4B, $40
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    db $55, $40, $2B, $41, $3C, $41, $A2, $40, $78, $40
    dw ChooseTarget_Blaze
    dw ChooseTarget_SquallHit
    dw ChooseTarget_SquallHit
    dw ChooseTarget_SquallHit
    db $78, $40, $78, $40, $90, $53, $90, $53, $78, $40, $A2, $40, $78, $40, $2B, $41
    db $A2, $40, $78, $40, $90, $53, $2B, $41, $78, $40
    dw TargetSelf
    dw TargetSelf
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $91, $66
    db $78, $40, $78, $40
    dw ChooseTarget_Heal_67AD
    dw ChooseTarget_Heal_67AD
    dw ChooseTarget_Heal_67AD
    dw TargetFirstAlly
    dw TargetFirstAlly
    db $E8, $40, $E8, $40, $E8, $40
    dw ChooseTarget_Vivify_6998
    dw ChooseTarget_Vivify_6998
    dw TargetOwnSideFirstSlot
    dw ChooseTarget_Antidote_699B
    dw TargetFirstAlly
    dw TargetFirstAlly
    dw TargetFirstAlly
    dw ChooseTarget_Upper_69A1
    dw TargetFirstAlly
    dw ChooseTarget_Sap_69A4
    db $78, $40, $AA, $69, $A2, $40, $A7, $69, $78, $40, $9E, $69, $78, $40, $91, $66
    db $78, $40, $2B, $41, $13, $6A, $78, $40, $00, $00, $00, $00
    dw TargetSelf
    dw TargetSelf
    dw TargetFirstAlly
    dw TargetFirstAlly
    dw ChooseTarget_Transform_6A04
    dw TargetSelf
    dw TargetSelf
    dw TargetFoeWeightedBySlotOrder
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40
    db $78, $40, $78, $40, $91, $66, $78, $40, $78, $40, $78, $40, $91, $66, $78, $40
    db $4B, $40, $4B, $40
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw ChooseTarget_SlimeBlow_69E9
    dw ChooseTarget_DrakSlash_69C5
    dw ChooseTarget_BeastCut_69CB
    dw ChooseTarget_BirdBlow_69D1
    dw ChooseTarget_BugBlow_69EF
    dw ChooseTarget_Shears_69F5
    dw ChooseTarget_DevilCut_69D7
    dw ChooseTarget_ZombieCut_69DD
    dw ChooseTarget_CleanCut_69E3
    dw TargetFoeWeightedBySlotOrder
    dw ChooseTarget_MetalCut_69C2
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    db $4B, $40, $78, $40, $78, $40
    dw TargetFoeWeightedBySlotOrder
    dw TargetSelf
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetRandomOtherSlot
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $BF, $69, $BF, $69, $78, $40
    db $78, $40, $78, $40, $3C, $41, $A2, $40, $2B, $41, $78, $40, $78, $40, $78, $40
    db $A2, $40, $AD, $69, $78, $40, $78, $40
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetFoeWeightedBySlotOrder
    dw ChooseTarget_SickLick_69B6
    dw ChooseTarget_LegSweep_69B9
    db $78, $40, $91, $66, $78, $40, $4B, $40, $78, $40
    dw ChooseTarget_MouthShut_69B3
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw ChooseTarget_Cover_69B0
    dw TargetFirstAlly
    dw TargetSelf
    dw TargetFirstAlly
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    ds $10, $00
    db $4B, $40
    dw TargetSelf
    dw TargetSelf
    dw TargetFoeWeightedBySlotOrder
    dw TargetSelf
    db $00, $00, $78, $40, $A2, $40, $78, $40, $78, $40, $A2, $40, $78, $40, $78, $40
    db $2B, $41, $2B, $41, $78, $40, $78, $40, $3C, $41, $A2, $40, $78, $40, $00, $00
    db $2B, $41, $E8, $40, $4B, $40
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetFoeWeightedBySlotOrder
    dw TargetSelf
    dw TargetOwnSideFirstSlot
    dw TargetFirstAlly
    db $78, $40
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    dw TargetFoeWeightedBySlotOrder
    db $78, $40, $78, $40, $91, $66, $91, $66, $78, $40, $A2, $40, $78, $40, $2B, $41
    db $A2, $40, $78, $40, $91, $66, $2B, $41, $78, $40
    dw TargetSelf
    dw TargetSelf
    dw ChooseTarget_SquallHit_543C
    dw ChooseTarget_Blaze
    dw ChooseTarget_Blaze
    dw ChooseTarget_Blaze
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $03, $5E
    db $78, $40, $78, $40
    dw ChooseTarget_Heal_5593
    dw ChooseTarget_Heal_5593
    dw ChooseTarget_Heal_5593
    dw TargetFirstAlly
    dw TargetFirstAlly
    db $E8, $40, $E8, $40, $E8, $40
    dw ChooseTarget_Vivify
    dw ChooseTarget_Vivify
    dw TargetOwnSideFirstSlot
    dw ChooseTarget_Antidote
    dw TargetFirstAlly
    dw TargetFirstAlly
    dw TargetFirstAlly
    dw ChooseTarget_Upper
    dw TargetFirstAlly
    dw ChooseTarget_Sap
    db $78, $40, $6B, $59, $A2, $40, $11, $59, $78, $40, $D8, $57, $78, $40, $ED, $60
    db $78, $40, $2B, $41, $4B, $61, $78, $40, $78, $40
    dw TargetFirstAlly
    dw TargetSelf
    dw TargetSelf
    dw TargetFirstAlly
    dw TargetFirstAlly
    dw ChooseTarget_Transform
    dw TargetSelf
    dw TargetSelf
    dw ChooseTarget_MegaMagic
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40
    db $78, $40, $78, $40, $A5, $63, $78, $40, $78, $40, $78, $40, $5C, $65, $78, $40
    db $4B, $40, $4B, $40
    dw ChooseTarget_FireSlash
    dw ChooseTarget_VacuSlash
    dw ChooseTarget_BoltSlash
    dw ChooseTarget_IceSlash
    dw ChooseTarget_SlimeBlow
    dw ChooseTarget_DrakSlash
    dw ChooseTarget_BeastCut
    dw ChooseTarget_BirdBlow
    dw ChooseTarget_BugBlow
    dw ChooseTarget_Shears
    dw ChooseTarget_DevilCut
    dw ChooseTarget_ZombieCut
    dw ChooseTarget_CleanCut
    dw ChooseTarget_AquaCut
    dw ChooseTarget_MetalCut
    dw ChooseTarget_PoisonHit
    dw ChooseTarget_Paralyze
    dw ChooseTarget_NapAttack
    dw ChooseTarget_SquallHit_543C
    dw ChooseTarget_SquallHit_543C
    db $4B, $40, $78, $40, $78, $40
    dw ChooseTarget_GigaSlash
    dw TargetSelf
    dw ChooseTarget_SquallHit_543C
    dw ChooseTarget_SquallHit_543C
    dw ChooseTarget_SquallHit_543C
    dw TargetRandomOtherSlot
    dw ChooseTarget_SquallHit_543C
    dw ChooseTarget_SquallHit_543C
    dw ChooseTarget_Ramming
    dw ChooseTarget_Ramming
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $F9, $5B, $F9, $5B, $78, $40
    db $78, $40, $78, $40, $3C, $41, $A2, $40, $2B, $41, $78, $40, $78, $40, $78, $40
    db $A2, $40, $CB, $59, $78, $40, $78, $40
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw ChooseTarget_LushLicks
    dw ChooseTarget_SickLick
    dw ChooseTarget_LegSweep
    db $78, $40, $67, $5D, $78, $40, $4B, $40, $78, $40
    dw ChooseTarget_MouthShut
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw ChooseTarget_Cover
    dw TargetFirstAlly
    dw TargetSelf
    dw TargetFirstAlly
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    ds $10, $00
    db $4B, $40, $2B, $41, $2B, $41, $00, $00, $00, $00, $00, $00, $78, $40, $A2, $40
    db $78, $40, $78, $40, $A2, $40, $78, $40, $78, $40, $2B, $41, $2B, $41, $78, $40
    db $78, $40, $3C, $41, $A2, $40, $78, $40, $00, $00, $2B, $41, $E8, $40, $4B, $40
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    db $55, $40, $2B, $41, $3C, $41, $A2, $40, $78, $40
    dw ChooseTarget_Blaze
    dw ChooseTarget_SquallHit_543C
    dw ChooseTarget_SquallHit_543C
    dw ChooseTarget_SquallHit_543C
    db $78, $40, $78, $40, $3C, $54, $3C, $54, $78, $40, $A2, $40, $78, $40, $2B, $41
    db $A2, $40, $78, $40, $0E, $5F, $2B, $41, $78, $40
    dw TargetSelf
    dw TargetSelf
    dw ChooseTarget_SquallHit_66C5
    dw ChooseTarget_Blaze_6A0A
    dw ChooseTarget_Blaze_6A0A
    dw ChooseTarget_Blaze_6A0A
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $07, $6A
    db $78, $40, $78, $40
    dw ChooseTarget_Heal_68B0
    dw ChooseTarget_Heal_68B0
    dw ChooseTarget_Heal_68B0
    dw TargetFirstAlly
    dw TargetFirstAlly
    db $E8, $40, $E8, $40, $E8, $40
    dw ChooseTarget_Vivify_6998
    dw ChooseTarget_Vivify_6998
    dw TargetOwnSideFirstSlot
    dw ChooseTarget_Antidote_699B
    dw TargetFirstAlly
    dw TargetFirstAlly
    dw TargetFirstAlly
    dw ChooseTarget_Upper_69A1
    dw TargetFirstAlly
    dw ChooseTarget_Sap_69A4
    db $78, $40, $AA, $69, $A2, $40, $A7, $69, $78, $40, $9E, $69, $78, $40, $10, $6A
    db $78, $40, $2B, $41, $13, $6A, $78, $40, $00, $00
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetFirstAlly
    dw TargetFirstAlly
    dw ChooseTarget_Transform_6A04
    dw TargetSelf
    dw TargetSelf
    dw ChooseTarget_MegaMagic_6AFA
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40
    db $78, $40, $78, $40, $22, $6A, $78, $40, $78, $40, $78, $40, $99, $6A, $78, $40
    db $4B, $40, $4B, $40
    dw ChooseTarget_FireSlash_6A16
    dw ChooseTarget_VacuSlash_6A1C
    dw ChooseTarget_BoltSlash_6A19
    dw ChooseTarget_IceSlash_6A1F
    dw ChooseTarget_SlimeBlow_69E9
    dw ChooseTarget_DrakSlash_69C5
    dw ChooseTarget_BeastCut_69CB
    dw ChooseTarget_BirdBlow_69D1
    dw ChooseTarget_BugBlow_69EF
    dw ChooseTarget_Shears_69F5
    dw ChooseTarget_DevilCut_69D7
    dw ChooseTarget_ZombieCut_69DD
    dw ChooseTarget_CleanCut_69E3
    dw ChooseTarget_AquaCut_6A96
    dw ChooseTarget_MetalCut_69C2
    dw ChooseTarget_PoisonHit_69FB
    dw ChooseTarget_Paralyze_69FE
    dw ChooseTarget_NapAttack_69BC
    dw ChooseTarget_SquallHit_66C5
    dw ChooseTarget_SquallHit_66C5
    db $4B, $40, $78, $40, $78, $40
    dw ChooseTarget_GigaSlash_6A25
    dw TargetSelf
    dw ChooseTarget_SquallHit_66C5
    dw ChooseTarget_SquallHit_66C5
    dw ChooseTarget_SquallHit_66C5
    dw TargetRandomOtherSlot
    dw ChooseTarget_SquallHit_66C5
    dw ChooseTarget_Berserker
    dw ChooseTarget_Berserker
    dw ChooseTarget_SquallHit_66C5
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $BF, $69, $BF, $69, $78, $40
    db $78, $40, $78, $40, $3C, $41, $A2, $40, $2B, $41, $78, $40, $78, $40, $78, $40
    db $A2, $40, $AD, $69, $78, $40, $78, $40
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw ChooseTarget_LushLicks_6A01
    dw ChooseTarget_SickLick_69B6
    dw ChooseTarget_LegSweep_69B9
    db $78, $40, $01, $6A, $78, $40, $4B, $40, $78, $40
    dw ChooseTarget_MouthShut_69B3
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw ChooseTarget_Cover_69B0
    dw TargetFirstAlly
    dw TargetSelf
    dw TargetFirstAlly
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    ds $10, $00
    db $4B, $40
    dw TargetSelf
    dw TargetSelf
    dw ChooseTarget_PanicAll
    dw TargetSelf
    db $00, $00, $78, $40, $A2, $40, $78, $40, $78, $40, $A2, $40, $78, $40, $78, $40
    db $2B, $41, $2B, $41, $78, $40, $78, $40, $3C, $41, $A2, $40, $78, $40, $00, $00
    db $2B, $41, $E8, $40, $4B, $40
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw TargetSelf
    dw ChooseTarget_SquallHit_66C5
    dw TargetSelf
    dw TargetOwnSideFirstSlot
    dw TargetFirstAlly
    db $78, $40
    dw ChooseTarget_Blaze_6A0A
    dw ChooseTarget_SquallHit_66C5
    dw ChooseTarget_SquallHit_66C5
    dw ChooseTarget_SquallHit_66C5
    db $78, $40, $78, $40, $C5, $66, $C5, $66, $78, $40, $A2, $40, $78, $40, $2B, $41
    db $A2, $40, $78, $40, $0A, $6A, $2B, $41, $78, $40, $2B, $41, $2B, $41

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 0 (no name), 98 SquallHit, 99 BiAttack, 105 PsycheUp, 106 HighJump, 107 EvilSlash, 109 TwinSlash, 110 Berserker, $D2, $D3 ...; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wBattleTarget, wBattleDamageLo, wD873
; writes: wBattleTarget, wBattleDamageLo, wD873
; points at: wBattleDamageLo, wBattleTargetChoice
ChooseTarget_SquallHit:: ; heuristic: target of a pointer table; C0
Func_039_5390:: ; address name
    ld hl, wBattleDamageLo
    ld bc, $0008
    xor a, a
    call FillBytes
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld [wBattleTarget], a
    ld c, a
    ld b, $03

Jump_039_53A7::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_53B2
    call SlotStatus4Bits23
    jr z, Jump_039_53BC

Jump_039_53B2::
    inc c
    dec b
    jr nz, Jump_039_53A7
    call EstimateAndPickWeakestTarget
    jp Jump_039_542B

Jump_039_53BC::
    ld b, $03
    ld a, [wBattleTarget]
    ld c, a

Jump_039_53C2::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_53CD
    call AnySlotStatusMaskSet
    jr z, Jump_039_53D7

Jump_039_53CD::
    inc c
    dec b
    jr nz, Jump_039_53C2
    call EstimateThreeTargets
    jp Jump_039_542B

Jump_039_53D7::
    ld b, $03
    ld a, [wBattleTarget]
    ld c, a

Jump_039_53DD::
    push bc
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_540D
    call AnySlotStatusMaskSet
    jr nz, Jump_039_540D
    call ComputeDamageEstimateForAction
    ld a, c
    call GetBattleHP_Bank39
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wD873]
    ld b, a
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    jr nc, Jump_039_5403
    ld hl, $0000

Jump_039_5403::
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    jr Jump_039_5415

Jump_039_540D::
    ld a, $FF
    ld [wBattleDamageLo], a
    ld [wD873], a

Jump_039_5415::
    pop bc
    call MultiplyDamageBy50IfWD8A7Bit0
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wD873]
    ld h, a
    call StoreHLToWD874SlotC
    inc c
    dec b
    jr nz, Jump_039_53DD
    call PickWeakestEstimatedTarget

Jump_039_542B::
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld a, [wBattleTarget]
    ld [hl], a
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 0 (no name), 98 SquallHit, 99 BiAttack, 105 PsycheUp, 106 HighJump, 107 EvilSlash, 109 TwinSlash, 110 Berserker, $D2, $D3 ...; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wBattleTarget, wBattleDamageLo, wD873
; writes: wBattleTarget, wBattleDamageLo, wD873
; points at: wBattleDamageLo, wBattleTargetChoice
ChooseTarget_SquallHit_543C:: ; heuristic: target of a pointer table; C0
Func_039_543C:: ; address name
    ld hl, wBattleDamageLo
    ld bc, $0008
    xor a, a
    call FillBytes
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld [wBattleTarget], a
    ld c, a
    ld b, $03

Jump_039_5453::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_545E
    call SlotStatus4Bits23
    jr z, Jump_039_5468

Jump_039_545E::
    inc c
    dec b
    jr nz, Jump_039_5453
    call EstimateAndPickWeakestTarget
    jp Jump_039_5503

Jump_039_5468::
    ld b, $03
    ld a, [wBattleTarget]
    ld c, a

Jump_039_546E::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_547E
    call AnySlotStatusMaskSet
    jr z, Jump_039_5488
    call TestSlotStatus2Bit3OrStatus5Bits67
    jr z, Jump_039_5488

Jump_039_547E::
    inc c
    dec b
    jr nz, Jump_039_546E
    call EstimateThreeTargets
    jp Jump_039_5503

Jump_039_5488::
    ld b, $03
    ld a, [wBattleTarget]
    ld c, a

Jump_039_548E::
    ld a, c
    call AnySlotStatusMaskSet
    jr nz, Jump_039_549F
    call TestSlotStatus2Bit3OrStatus5Bits67
    jr nz, Jump_039_549F
    ld a, c
    call CheckSlotStatusBlock
    jr nc, Jump_039_54A9

Jump_039_549F::
    inc c
    dec b
    jr nz, Jump_039_548E
    call EstimateThreeTargets
    jp Jump_039_5503

Jump_039_54A9::
    ld b, $03
    ld a, [wBattleTarget]
    ld c, a

Jump_039_54AF::
    push bc
    ld a, c
    call CheckSlotStatusBlock
    jr c, Jump_039_54E5
    call AnySlotStatusMaskSet
    jr nz, Jump_039_54E5
    call TestSlotStatus2Bit3OrStatus5Bits67
    jr nz, Jump_039_54E5
    ld a, c
    call ComputeDamageEstimateForAction
    ld a, c
    call GetBattleHP_Bank39
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wD873]
    ld b, a
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    jr nc, Jump_039_54DB
    ld hl, $0000

Jump_039_54DB::
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    jr Jump_039_54ED

Jump_039_54E5::
    ld a, $FF
    ld [wBattleDamageLo], a
    ld [wD873], a

Jump_039_54ED::
    pop bc
    call MultiplyDamageBy50IfWD8A7Bit0
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wD873]
    ld h, a
    call StoreHLToWD874SlotC
    inc c
    dec b
    jr nz, Jump_039_54AF
    call PickWeakestEstimatedTarget

Jump_039_5503::
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld a, [wBattleTarget]
    ld [hl], a
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 22 Heal, 23 HealMore, 24 HealAll; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wD86B, wD86C
; writes: wD86B, wD86C
; points at: wD87D, wD874, wBattleHP
ChooseTarget_Heal:: ; heuristic: target of a pointer table; C0
Func_039_5514:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld e, a
    ld d, $03

Jump_039_551C::
    ld a, e
    ld [wD86B], a
    ld a, d
    ld [wD86C], a
    ld a, e
    call CarryUnlessWDA63SlotEmpty
    jr nc, Jump_039_5532
    ld bc, $0000
    ld hl, $0000
    jr Jump_039_5553

Jump_039_5532::
    ld a, e
    ld hl, wBattleHP
    add a, a
    add_a_to_hl
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, e
    call GetBattleMaxHP_Bank39
    call CompareHLToBC
    jr nz, Jump_039_5550
    ld bc, $0001
    ld hl, $0000
    jr Jump_039_5553

Jump_039_5550::
    call DivideHLByBC

Jump_039_5553::
    push hl
    ld a, [wD86B]
    ld e, a
    ld a, [wD86C]
    ld d, a
    ld a, $03
    sub a, d
    ld hl, wD87D
    add a, a
    add_a_to_hl
    ld [hl], c
    inc hl
    ld [hl], b
    pop bc
    ld a, [wD86B]
    ld e, a
    ld a, [wD86C]
    ld d, a
    ld a, $03
    sub a, d
    ld hl, wD874
    add a, a
    add_a_to_hl
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [wD86B]
    ld e, a
    ld a, [wD86C]
    ld d, a
    inc e
    dec d
    jr nz, Jump_039_551C
    call ChooseTarget_Heal_Sub01
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 22 Heal, 23 HealMore, 24 HealAll; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC6, hFFC7, hFFC8, wD86B, wD86C, wD868, wD87D, ...
; writes: wD868, wD86B, wD86C, hFFC6, hFFC7, hFFC8, wD87D, wD87E, ...
; points at: hFFC6, wD868, wD8A7, wBattleMaxHP, wBattleTargetChoice, wD87D, wD874, wBattleHP
ChooseTarget_Heal_5593:: ; heuristic: target of a pointer table; C0
Func_039_5593:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld e, a
    ld d, $03
    xor a, a
    ld [wD868], a
    ld b, d
    ld c, e
    xor a, a
    ld hl, hFFC6
    ld [hl+], a
    ld [hl+], a
    ld [hl], a

Jump_039_55A8::
    ld a, c
    ld [wD86B], a
    ld a, b
    ld [wD86C], a
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_55E4
    ld hl, wD868
    inc [hl]
    ld a, c
    call GetBattleMaxHP_Bank39
    ld a, c
    ld de, wD8A7
    add a, e
    ld e, a
    jr nc, Jump_039_55C7
    inc d

Jump_039_55C7::
    ld a, [de]
    bit 0, a
    jr z, Jump_039_55D3
    ld a, $1E
    call Multiply8By16
    jr Jump_039_55D5

Jump_039_55D3::
    ld e, $00

Jump_039_55D5::
    ldh a, [hFFC6]
    add a, l
    ldh [hFFC6], a
    ldh a, [hFFC7]
    adc a, h
    ldh [hFFC7], a
    ldh a, [hFFC8]
    adc a, e
    ldh [hFFC8], a

Jump_039_55E4::
    ld a, [wD86B]
    ld c, a
    ld a, [wD86C]
    ld b, a
    inc c
    dec b
    jr nz, Jump_039_55A8
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ldh a, [hFFC8]
    ld e, a
    ld a, [wD868]
    call Divide24ByA
    ld a, [wD868]
    call Divide24ByA
    ld a, l
    ld [wD87D], a
    ld a, h
    ld [wD87E], a
    ld a, [wBattleActor]
    and a, $04
    ld e, a
    ld d, $03
    ld a, $FF
    ld [wD86A], a

Jump_039_561A::
    ld a, e
    ld [wD868], a
    ld a, d
    ld [wD869], a
    ld a, e
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_566D
    ld a, e
    ld hl, wBattleMaxHP
    add a, a
    add_a_to_hl
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, e
    call GetBattleHP_Bank39
    call CompareHLToBC
    jr z, Jump_039_566D
    ld a, [wD87D]
    ld c, a
    ld a, [wD87E]
    ld b, a
    call CompareHLToBC
    jr z, Jump_039_565D
    jr nc, Jump_039_566D
    ld a, l
    ld [wD87D], a
    ld a, h
    ld [wD87E], a
    ld a, [wD868]
    ld [wD86A], a
    jr Jump_039_566D

Jump_039_565D::
    call AdvanceRandom
    ld a, [wC5E7]
    bit 7, a
    jr z, Jump_039_566D
    ld a, [wD868]
    ld [wD86A], a

Jump_039_566D::
    ld a, [wD868]
    ld e, a
    ld a, [wD869]
    ld d, a
    inc e
    dec d
    jr nz, Jump_039_561A
    ld a, [wD86A]
    cp a, $FF
    jr z, Jump_039_5691
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld a, [wD86A]
    ld [hl], a
    ret

Jump_039_5691::
    ld a, [wBattleActor]
    and a, $04
    ld e, a
    ld d, $03
    jp Jump_039_551C

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 30 Vivify, 31 Revive; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC6, wC5E7
; writes: hFFC6, hFFC7, hFFC8, hFFC9
; points at: wBattleSlotOut, hFFC7, hFFC6, wBattleTargetChoice
ChooseTarget_Vivify:: ; heuristic: target of a pointer table; C0
Func_039_569C:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03
    xor a, a
    ldh [hFFC6], a
    ld a, $FF
    ldh [hFFC7], a
    ldh [hFFC8], a
    ldh [hFFC9], a

Jump_039_56AF::
    ld a, c
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld a, [hl]
    cp a, $01
    jr nz, Jump_039_56CD
    ld a, c
    and a, $03
    ld hl, hFFC7
    add_a_to_hl
    ld [hl], c
    ld hl, hFFC6
    inc [hl]

Jump_039_56CD::
    inc c
    dec b
    jr nz, Jump_039_56AF
    ldh a, [hFFC6]
    or a, a
    jr nz, Jump_039_56DC
    ld a, [wBattleActor]
    ld c, a
    jr Jump_039_5708

Jump_039_56DC::
    ld hl, hFFC7
    ld b, $02
    ld a, [hl+]
    cp a, $FF
    jr nz, Jump_039_56F0
    ld b, $01
    ld a, [hl+]
    cp a, $FF
    jr nz, Jump_039_56F0
    ld c, [hl]
    jr Jump_039_5708

Jump_039_56F0::
    ld c, a
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_039_5704
    push af
    call AdvanceRandom
    ld a, [wC5E7]
    ld e, a
    pop af
    bit 0, e
    jr z, Jump_039_5704
    ld c, a

Jump_039_5704::
    ld a, c
    dec b
    jr nz, Jump_039_56F0

Jump_039_5708::
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld [hl], c
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 33 Antidote; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wC5E7, hFFC6
; writes: hFFC7, hFFC8, hFFC9, hFFC6
; points at: hFFC7, wBattleStatus, wBattleTargetChoice
ChooseTarget_Antidote:: ; heuristic: target of a pointer table; C0
Func_039_5716:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03
    xor a, a
    ldh [hFFC7], a
    ldh [hFFC8], a
    ldh [hFFC9], a
    ld de, hFFC7

Jump_039_5728::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_5738
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    and a, $03
    ld [de], a

Jump_039_5738::
    inc de
    inc c
    dec b
    jr nz, Jump_039_5728
    ld hl, hFFC7
    ld bc, $0300
    ld d, $00

Jump_039_5745::
    bit 1, [hl]
    jr z, Jump_039_574D
    ld a, c
    ldh [hFFC6], a
    inc d

Jump_039_574D::
    inc c
    inc hl
    dec b
    jr nz, Jump_039_5745
    ld a, d
    or a, a
    jr z, Jump_039_576C
    cp a, $01
    jr z, Jump_039_57C1
    cp a, $03
    jr z, Jump_039_57B3
    call AdvanceRandom
    ld a, [wC5E7]
    bit 7, a
    jr z, Jump_039_57C1
    ld d, $02
    jr Jump_039_57A2

Jump_039_576C::
    ld hl, hFFC7
    ld bc, $0300
    ld d, $00

Jump_039_5774::
    bit 0, [hl]
    jr z, Jump_039_577C
    ld a, c
    ldh [hFFC6], a
    inc d

Jump_039_577C::
    inc hl
    inc c
    dec b
    jr nz, Jump_039_5774
    ld a, d
    or a, a
    jr nz, Jump_039_578E
    ld a, [wBattleActor]
    and a, $03
    ldh [hFFC6], a
    jr Jump_039_57C1

Jump_039_578E::
    cp a, $01
    jr z, Jump_039_57C1
    cp a, $03
    jr z, Jump_039_57B3
    call AdvanceRandom
    ld a, [wC5E7]
    bit 7, a
    jr z, Jump_039_57C1
    ld d, $01

Jump_039_57A2::
    ld hl, hFFC7
    ld c, $00

Jump_039_57A7::
    ld a, [hl+]
    and a, d
    jr nz, Jump_039_57AE
    inc c
    jr Jump_039_57A7

Jump_039_57AE::
    ld a, c
    ldh [hFFC6], a
    jr Jump_039_57C1

Jump_039_57B3::
    call AdvanceRandom
    ld a, [wC5E7]
    ld b, a
    ld a, $03
    call DivideBByA
    ldh [hFFC6], a

Jump_039_57C1::
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ldh a, [hFFC6]
    ld c, a
    ld a, [wBattleActor]
    and a, $04
    or a, c
    ld [hl], a
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 45 TwinHits; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7, hFFC8, hFFC6, wC5E7
; writes: hFFC6, hFFC7, hFFC8
; points at: wBattleStatus, wBattleTargetChoice
ChooseTarget_TwinHits:: ; heuristic: follows a terminator; C0
Func_039_57D8:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [hFFC6], a
    xor a, a
    ldh [hFFC7], a
    ldh [hFFC8], a

Jump_039_57E9::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_5831
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl+]
    bit 6, a
    jr nz, Jump_039_5831
    bit 2, [hl]
    jr nz, Jump_039_5831
    ld a, c
    call GetBattleATK_Bank39
    push bc
    ldh a, [hFFC7]
    ld c, a
    ldh a, [hFFC8]
    ld b, a
    call CompareHLToBC
    pop bc
    jr z, Jump_039_581C
    jr c, Jump_039_5831
    ld a, c
    ldh [hFFC6], a
    ld a, l
    ldh [hFFC7], a
    ld a, h
    ldh [hFFC8], a
    jr Jump_039_5831

Jump_039_581C::
    push hl
    call AdvanceRandom
    pop hl
    ld a, [wC5E7]
    bit 7, a
    jr z, Jump_039_5831
    ld a, c
    ldh [hFFC6], a
    ld a, l
    ldh [hFFC7], a
    ld a, h
    ldh [hFFC8], a

Jump_039_5831::
    inc c
    dec b
    jr nz, Jump_039_57E9
    ldh a, [hFFC6]
    cp a, $FF
    jr nz, Jump_039_5840
    ld a, [wBattleActor]
    ldh [hFFC6], a

Jump_039_5840::
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ldh a, [hFFC6]
    ld c, a
    ld a, [wBattleActor]
    and a, $04
    or a, c
    ld [hl], a
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 37 Upper; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7, hFFC8, hFFC6
; writes: hFFC6, hFFC7, hFFC8
; points at: wBattleTargetChoice
ChooseTarget_Upper:: ; heuristic: target of a pointer table; C0
Func_039_5857:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [hFFC6], a
    ldh [hFFC7], a
    ldh [hFFC8], a

Jump_039_5867::
    push bc
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_5891
    call GetBattleDEF_Bank39
    push hl
    call BuffCapOfBaseDEF
    pop bc
    call CompareHLToBC
    jr nc, Jump_039_5891
    ldh a, [hFFC7]
    ld l, a
    ldh a, [hFFC8]
    ld h, a
    call CompareHLToBC
    jr c, Jump_039_5891
    ld a, c
    ldh [hFFC7], a
    ld a, b
    ldh [hFFC8], a
    pop bc
    push bc
    ld a, c
    ldh [hFFC6], a

Jump_039_5891::
    pop bc
    inc c
    dec b
    jr nz, Jump_039_5867
    ldh a, [hFFC6]
    cp a, $FF
    jr nz, Jump_039_58A1
    ld a, [wBattleActor]
    and a, $03

Jump_039_58A1::
    ld c, a
    ld a, [wBattleActor]
    and a, $04
    or a, c
    ld c, a
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld [hl], c
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 39 Sap; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9
; points at: wD80E, wDA75
ChooseTarget_Sap:: ; heuristic: target of a pointer table; C0
Func_039_58B7:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hFFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [hFFC6], a
    ldh [hFFC7], a
    ldh [hFFC8], a
    ldh [hFFC9], a

Jump_039_58CD::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_5909
    ldh [hFFC8], a
    ld hl, wD80E
    call AddAx9ToHL
    bit 1, [hl]
    jr nz, Jump_039_5909
    ld a, c
    ldh [hFFC9], a
    call GetBattleDEF_Bank39
    ld a, h
    or a, a
    jr nz, Jump_039_58EE
    ld a, l
    cp a, $02
    jr c, Jump_039_5909

Jump_039_58EE::
    ld a, c
    ld hl, wDA75
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $30
    swap a
    cp a, $03
    jr z, Jump_039_5909
    ld e, a
    ldh a, [hFFC7]
    cp a, e
    jr c, Jump_039_5909
    ld a, e
    ldh [hFFC7], a
    ld a, c
    ldh [hFFC6], a

Jump_039_5909::
    inc c
    dec b
    jr nz, Jump_039_58CD
    call SetActorTargetFromHRAMChoice
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 43 Slow; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9
; points at: wD80E, wDA75
ChooseTarget_Slow:: ; heuristic: follows a terminator; C0
Func_039_5911:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hFFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [hFFC6], a
    ldh [hFFC7], a
    ldh [hFFC8], a
    ldh [hFFC9], a

Jump_039_5927::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_5963
    ldh [hFFC8], a
    ld hl, wD80E
    call AddAx9ToHL
    bit 1, [hl]
    jr nz, Jump_039_5963
    ld a, c
    ldh [hFFC9], a
    call GetBattleAGL_Bank39
    ld a, h
    or a, a
    jr nz, Jump_039_5948
    ld a, l
    cp a, $02
    jr c, Jump_039_5963

Jump_039_5948::
    ld a, c
    ld hl, wDA75
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $30
    swap a
    cp a, $03
    jr z, Jump_039_5963
    ld e, a
    ldh a, [hFFC7]
    cp a, e
    jr c, Jump_039_5963
    ld a, e
    ldh [hFFC7], a
    ld a, c
    ldh [hFFC6], a

Jump_039_5963::
    inc c
    dec b
    jr nz, Jump_039_5927
    call SetActorTargetFromHRAMChoice
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 41 Speed; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7, hFFC8, hFFC6
; writes: hFFC6, hFFC7, hFFC8
; points at: wBattleTargetChoice
ChooseTarget_Speed:: ; heuristic: follows a terminator; C0
Func_039_596B:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [hFFC6], a
    ldh [hFFC7], a
    ldh [hFFC8], a

Jump_039_597B::
    push bc
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_59A5
    call GetBattleAGL_Bank39
    push hl
    call BuffCapOfBaseAGL
    pop bc
    call CompareHLToBC
    jr nc, Jump_039_59A5
    ldh a, [hFFC7]
    ld l, a
    ldh a, [hFFC8]
    ld h, a
    call CompareHLToBC
    jr c, Jump_039_59A5
    ld a, c
    ldh [hFFC7], a
    ld a, b
    ldh [hFFC8], a
    pop bc
    push bc
    ld a, c
    ldh [hFFC6], a

Jump_039_59A5::
    pop bc
    inc c
    dec b
    jr nz, Jump_039_597B
    ldh a, [hFFC6]
    cp a, $FF
    jr nz, Jump_039_59B5
    ld a, [wBattleActor]
    and a, $03

Jump_039_59B5::
    ld c, a
    ld a, [wBattleActor]
    and a, $04
    or a, c
    ld c, a
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld [hl], c
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 130 UltraDown; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9
; points at: wDA74
ChooseTarget_UltraDown:: ; heuristic: follows a terminator; C0
Func_039_59CB:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hFFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [hFFC6], a
    ldh [hFFC7], a
    ldh [hFFC8], a
    ldh [hFFC9], a

Jump_039_59E1::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_5A1F
    ldh [hFFC8], a
    call GetBattleDEF_Bank39
    ld a, h
    or a, a
    jr nz, Jump_039_5A02
    ld a, l
    cp a, $02
    jr nc, Jump_039_5A02
    ld a, c
    call GetBattleAGL_Bank39
    ld a, h
    or a, a
    jr nz, Jump_039_5A02
    ld a, l
    cp a, $02
    jr c, Jump_039_5A1F

Jump_039_5A02::
    ld a, c
    ldh [hFFC9], a
    ld hl, wDA74
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $30
    swap a
    cp a, $03
    jr z, Jump_039_5A1F
    ld e, a
    ldh a, [hFFC7]
    cp a, e
    jr c, Jump_039_5A1F
    ld a, e
    ldh [hFFC7], a
    ld a, c
    ldh [hFFC6], a

Jump_039_5A1F::
    inc c
    dec b
    jr nz, Jump_039_59E1
    call SetActorTargetFromHRAMChoice
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 151 Cover; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFCA, hFFC7, hFFC8
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9, hFFCA, hFFCB
ChooseTarget_Cover:: ; heuristic: target of a pointer table; C0
Func_039_5A27:: ; address name
    ld a, [wBattleActor]
    ld e, a
    and a, $04
    ldh [hFFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [hFFC6], a
    ldh [hFFC7], a
    ldh [hFFC8], a
    ldh [hFFC9], a
    ldh [hFFCA], a
    ldh [hFFCB], a

Jump_039_5A40::
    push bc
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_5A7B
    ldh [hFFC9], a
    cp a, e
    jr z, Jump_039_5A7B
    ldh [hFFCA], a
    call GetBattleMaxHP_Bank39
    push hl
    ld a, c
    call GetBattleHP_Bank39
    add hl, hl
    ld c, l
    ld b, h
    add hl, hl
    add hl, hl
    add hl, bc
    pop bc
    call CompareHLToBC
    jr nc, Jump_039_5A7B
    ldh a, [hFFCA]
    ldh [hFFCB], a
    ldh a, [hFFC7]
    ld c, a
    ldh a, [hFFC8]
    ld b, a
    call CompareHLToBC
    jr nc, Jump_039_5A7B
    ld a, l
    ldh [hFFC7], a
    ld a, h
    ldh [hFFC8], a
    ldh a, [hFFCA]
    ldh [hFFC6], a

Jump_039_5A7B::
    pop bc
    inc c
    dec b
    jr nz, Jump_039_5A40
    call ChooseTarget_Cover_Sub01
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 147 MouthShut; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9, hFFCA
; points at: wD80D, wDA78
ChooseTarget_MouthShut:: ; heuristic: target of a pointer table; C0
Func_039_5A84:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hFFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [hFFC6], a
    ldh [hFFC7], a
    ldh [hFFC8], a
    ldh [hFFC9], a
    ldh [hFFCA], a

Jump_039_5A9C::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_5AD3
    ldh [hFFC8], a
    call ChooseTarget_MouthShut_Sub01
    jr z, Jump_039_5AD3
    ld a, c
    ldh [hFFC9], a
    ld hl, wD80D
    call AddAx9ToHL
    bit 7, [hl]
    jr nz, Jump_039_5AD3
    ld a, c
    ldh [hFFCA], a
    ld hl, wDA78
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $C0
    rlca
    rlca
    cp a, $03
    jr z, Jump_039_5AD3
    ld e, a
    ldh a, [hFFC7]
    cp a, e
    jr c, Jump_039_5AD3
    ld a, e
    ldh [hFFC7], a
    ld a, c
    ldh [hFFC6], a

Jump_039_5AD3::
    inc c
    dec b
    jr nz, Jump_039_5A9C
    call SetActorTargetFromHRAMChoice4
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 140 SickLick; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9, hFFCA
; points at: wBattleStatus, wDA77
ChooseTarget_SickLick:: ; heuristic: target of a pointer table; C0
Func_039_5ADB:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hFFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [hFFC6], a
    ldh [hFFC7], a
    ldh [hFFC8], a
    ldh [hFFC9], a
    ldh [hFFCA], a

Jump_039_5AF3::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_5B38
    ldh [hFFC8], a
    call GetBattleDEF_Bank39
    ld a, h
    or a, a
    jr nz, Jump_039_5B07
    ld a, l
    cp a, $02
    jr c, Jump_039_5B38

Jump_039_5B07::
    ld a, c
    ldh [hFFC9], a
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl+]
    and a, $CC
    jr nz, Jump_039_5B38
    inc hl
    inc hl
    ld a, [hl]
    or a, a
    jr nz, Jump_039_5B38
    ld a, c
    ldh [hFFCA], a
    ld hl, wDA77
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $0C
    rrca
    rrca
    cp a, $03
    jr z, Jump_039_5B38
    ld e, a
    ldh a, [hFFC7]
    cp a, e
    jr c, Jump_039_5B38
    ld a, e
    ldh [hFFC7], a
    ld a, c
    ldh [hFFC6], a

Jump_039_5B38::
    inc c
    dec b
    jr nz, Jump_039_5AF3
    call SetActorTargetFromHRAMChoice4
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 141 LegSweep; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9, hFFCA
; points at: wD8A7, wBattleStatus, wDA77
ChooseTarget_LegSweep:: ; heuristic: target of a pointer table; C0
Func_039_5B40:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hFFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [hFFC6], a
    ldh [hFFC7], a
    ldh [hFFC8], a
    ldh [hFFC9], a
    ldh [hFFCA], a

Jump_039_5B58::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_5B9D
    ldh [hFFC8], a
    ld hl, wD8A7
    add_a_to_hl
    bit 4, [hl]
    jr nz, Jump_039_5B9D
    ld a, c
    ldh [hFFC9], a
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl+]
    and a, $DC
    jr nz, Jump_039_5B9D
    inc hl
    inc hl
    ld a, [hl]
    or a, a
    jr nz, Jump_039_5B9D
    ld a, c
    ldh [hFFCA], a
    ld hl, wDA77
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $0C
    rrca
    rrca
    cp a, $03
    jr z, Jump_039_5B9D
    ld e, a
    ldh a, [hFFC7]
    cp a, e
    jr c, Jump_039_5B9D
    ld a, e
    ldh [hFFC7], a
    ld a, c
    ldh [hFFC6], a

Jump_039_5B9D::
    inc c
    dec b
    jr nz, Jump_039_5B58
    call SetActorTargetFromHRAMChoice4
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 97 NapAttack; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9
; points at: wBattleStatus, wDA74
ChooseTarget_NapAttack:: ; heuristic: target of a pointer table; C0
Func_039_5BA5:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hFFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [hFFC6], a
    ldh [hFFC7], a
    ldh [hFFC8], a
    ldh [hFFC9], a

Jump_039_5BBB::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_5BF1
    ldh [hFFC8], a
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl+]
    and a, $CC
    jr nz, Jump_039_5BF1
    inc hl
    inc hl
    ld a, [hl]
    or a, a
    jr nz, Jump_039_5BF1
    ld a, c
    ldh [hFFC9], a
    ld hl, wDA74
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $C0
    rlca
    rlca
    cp a, $03
    jr z, Jump_039_5BF1
    ld e, a
    ldh a, [hFFC7]
    cp a, e
    jr c, Jump_039_5BF1
    ld a, e
    ldh [hFFC7], a
    ld a, c
    ldh [hFFC6], a

Jump_039_5BF1::
    inc c
    dec b
    jr nz, Jump_039_5BBB
    call SetActorTargetFromHRAMChoice
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 118 OddDance, 119 RobDance; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9
; points at: wDA74
ChooseTarget_OddDance:: ; heuristic: follows a terminator; C0
Func_039_5BF9:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hFFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [hFFC6], a
    ldh [hFFC7], a
    ldh [hFFC8], a
    ldh [hFFC9], a

Jump_039_5C0F::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_5C3B
    ldh [hFFC8], a
    call GetBattleMP_Bank39
    ld a, h
    or a, l
    jr z, Jump_039_5C3B
    ld a, c
    ldh [hFFC9], a
    ld hl, wDA74
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $0C
    rrca
    rrca
    cp a, $03
    jr z, Jump_039_5C3B
    ld e, a
    ldh a, [hFFC7]
    cp a, e
    jr c, Jump_039_5C3B
    ld a, e
    ldh [hFFC7], a
    ld a, c
    ldh [hFFC6], a

Jump_039_5C3B::
    inc c
    dec b
    jr nz, Jump_039_5C0F
    call SetActorTargetFromHRAMChoice
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 94 MetalCut; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7, hFFC8, hFFC9
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9
; points at: wD8A7
ChooseTarget_MetalCut:: ; heuristic: target of a pointer table; C0
Func_039_5C43:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hFFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [hFFC6], a
    ldh [hFFC7], a
    ldh [hFFC8], a
    ldh [hFFC9], a

Jump_039_5C59::
    push bc
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_5C8E
    ldh [hFFC9], a
    ld hl, wD8A7
    add_a_to_hl
    bit 0, [hl]
    jr z, Jump_039_5C8E
    ld a, c
    call GetBattleHP_Bank39
    push hl
    ld a, c
    call GetBattleDEF_Bank39
    pop bc
    add hl, bc
    ldh a, [hFFC7]
    ld c, a
    ldh a, [hFFC8]
    ld b, a
    call CompareHLToBC
    jr c, Jump_039_5C8E
    ld a, l
    ldh [hFFC7], a
    ld a, h
    ldh [hFFC8], a
    ldh a, [hFFC9]
    ldh [hFFC6], a

Jump_039_5C8E::
    pop bc
    inc c
    dec b
    jr nz, Jump_039_5C59
    call SetActorTargetFromHFFC6OrHFFC9
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 85 DrakSlash; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
ChooseTarget_DrakSlash:: ; heuristic: target of a pointer table; C0
Func_039_5C97:: ; address name
    ld d, $01
    call TargetWeakestFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 86 BeastCut; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
ChooseTarget_BeastCut:: ; heuristic: target of a pointer table; C0
Func_039_5C9D:: ; address name
    ld d, $02
    call TargetWeakestFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 87 BirdBlow; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
ChooseTarget_BirdBlow:: ; heuristic: target of a pointer table; C0
Func_039_5CA3:: ; address name
    ld d, $03
    call TargetWeakestFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 90 DevilCut; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
ChooseTarget_DevilCut:: ; heuristic: target of a pointer table; C0
Func_039_5CA9:: ; address name
    ld d, $06
    call TargetWeakestFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 91 ZombieCut; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
ChooseTarget_ZombieCut:: ; heuristic: target of a pointer table; C0
Func_039_5CAF:: ; address name
    ld d, $07
    call TargetWeakestFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 92 CleanCut; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
ChooseTarget_CleanCut:: ; heuristic: target of a pointer table; C0
Func_039_5CB5:: ; address name
    ld d, $08
    call TargetWeakestFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 84 SlimeBlow; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
ChooseTarget_SlimeBlow:: ; heuristic: target of a pointer table; C0
Func_039_5CBB:: ; address name
    ld d, $00
    call TargetWeakestFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 88 BugBlow; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
ChooseTarget_BugBlow:: ; heuristic: target of a pointer table; C0
Func_039_5CC1:: ; address name
    ld d, $05
    call TargetWeakestFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 89 Shears; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
ChooseTarget_Shears:: ; heuristic: target of a pointer table; C0
Func_039_5CC7:: ; address name
    ld d, $04
    call TargetWeakestFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 95 PoisonHit; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9
; points at: wBattleStatus, wDA76
ChooseTarget_PoisonHit:: ; heuristic: target of a pointer table; C0
Func_039_5CCD:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hFFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [hFFC6], a
    ldh [hFFC7], a
    ldh [hFFC8], a
    ldh [hFFC9], a

Jump_039_5CE3::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_5D11
    ldh [hFFC8], a
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    and a, $03
    jr nz, Jump_039_5D11
    ld a, c
    ldh [hFFC9], a
    ld hl, wDA76
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $03
    cp a, $03
    jr z, Jump_039_5D11
    ld e, a
    ldh a, [hFFC7]
    cp a, e
    jr c, Jump_039_5D11
    ld a, e
    ldh [hFFC7], a
    ld a, c
    ldh [hFFC6], a

Jump_039_5D11::
    inc c
    dec b
    jr nz, Jump_039_5CE3
    call SetActorTargetFromHRAMChoice
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 96 Paralyze; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9
; points at: wBattleStatus, wDA77
ChooseTarget_Paralyze:: ; heuristic: target of a pointer table; C0
Func_039_5D19:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hFFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [hFFC6], a
    ldh [hFFC7], a
    ldh [hFFC8], a
    ldh [hFFC9], a

Jump_039_5D2F::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_5D5F
    ldh [hFFC8], a
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    and a, $CC
    jr nz, Jump_039_5D5F
    ld a, c
    ldh [hFFC9], a
    ld hl, wDA77
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $C0
    rlca
    rlca
    cp a, $03
    jr z, Jump_039_5D5F
    ld e, a
    ldh a, [hFFC7]
    cp a, e
    jr c, Jump_039_5D5F
    ld a, e
    ldh [hFFC7], a
    ld a, c
    ldh [hFFC6], a

Jump_039_5D5F::
    inc c
    dec b
    jr nz, Jump_039_5D2F
    call SetActorTargetFromHRAMChoice
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 139 LushLicks, 143 Ahhh; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9
; points at: wBattleStatus, wDA77
ChooseTarget_LushLicks:: ; heuristic: target of a pointer table; C0
Func_039_5D67:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hFFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [hFFC6], a
    ldh [hFFC7], a
    ldh [hFFC8], a
    ldh [hFFC9], a

Jump_039_5D7D::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_5DB3
    ldh [hFFC8], a
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl+]
    and a, $DC
    jr nz, Jump_039_5DB3
    inc hl
    inc hl
    ld a, [hl]
    or a, a
    jr nz, Jump_039_5DB3
    ld a, c
    ldh [hFFC9], a
    ld hl, wDA77
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $0C
    rrca
    rrca
    cp a, $03
    jr z, Jump_039_5DB3
    ld e, a
    ldh a, [hFFC7]
    cp a, e
    jr c, Jump_039_5DB3
    ld a, e
    ldh [hFFC7], a
    ld a, c
    ldh [hFFC6], a

Jump_039_5DB3::
    inc c
    dec b
    jr nz, Jump_039_5D7D
    call SetActorTargetFromHRAMChoice
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 58 Transform; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7, hFFC8, hFFC9
; writes: hFFD0, hFFC6, hFFC9, hFFC7, hFFC8
ChooseTarget_Transform:: ; heuristic: target of a pointer table; C0
Func_039_5DBB:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hFFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [hFFC6], a
    ldh [hFFC9], a
    xor a, a
    ldh [hFFC7], a
    ldh [hFFC8], a

Jump_039_5DD2::
    push bc
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_5DFA
    ldh [hFFC9], a
    call GetBattleMaxHP_Bank39
    push hl
    ld a, c
    call GetBattleMaxMP_Bank39
    pop bc
    add hl, bc
    ldh a, [hFFC7]
    ld c, a
    ldh a, [hFFC8]
    ld b, a
    call CompareHLToBC
    jr c, Jump_039_5DFA
    ld a, l
    ldh [hFFC7], a
    ld a, h
    ldh [hFFC8], a
    ldh a, [hFFC9]
    ldh [hFFC6], a

Jump_039_5DFA::
    pop bc
    inc c
    dec b
    jr nz, Jump_039_5DD2
    call SetActorTargetFromHFFC6OrHFFC9
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 19 Beat; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7, hFFC8, hFFD0, hFFC9, hFFCA, hFFC6
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9, hFFCA, hFFCB
; points at: wD80E, wDA74, hFFC8, wBattleTargetChoice
ChooseTarget_Beat:: ; heuristic: follows a terminator; C0
Func_039_5E03:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hFFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [hFFC6], a
    ldh [hFFC7], a
    ldh [hFFC8], a
    xor a, a
    ldh [hFFC9], a
    ldh [hFFCA], a
    ld a, $FF
    ldh [hFFCB], a

Jump_039_5E20::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_5E53
    ld hl, wD80E
    ldh [hFFCB], a
    call AddAx9ToHL
    bit 1, [hl]
    jr nz, Jump_039_5E53
    ld a, c
    ld hl, wDA74
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $30
    swap a
    cp a, $03
    jr z, Jump_039_5E53
    ld e, a
    ldh a, [hFFC7]
    cp a, e
    jr z, Jump_039_5E4F
    jr c, Jump_039_5E53
    ld a, e
    ldh [hFFC7], a
    xor a, a
    ldh [hFFC8], a

Jump_039_5E4F::
    ld hl, hFFC8
    inc [hl]

Jump_039_5E53::
    inc c
    dec b
    jr nz, Jump_039_5E20
    ldh a, [hFFC8]
    or a, a
    jr z, Jump_039_5EAC
    cp a, $01
    jr z, Jump_039_5ED8
    ldh a, [hFFD0]
    ld c, a
    ld b, $03

Jump_039_5E65::
    push bc
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_5EA5
    ld hl, wD80E
    call AddAx9ToHL
    bit 1, [hl]
    jr nz, Jump_039_5EA5
    ld a, c
    ld hl, wDA74
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $30
    swap a
    cp a, $03
    jr z, Jump_039_5EA5
    ld e, a
    ldh a, [hFFC7]
    cp a, e
    jr nz, Jump_039_5EA5
    ld a, c
    call GetBattleHP_Bank39
    ldh a, [hFFC9]
    ld c, a
    ldh a, [hFFCA]
    ld b, a
    call CompareHLToBCFastZero
    jr c, Jump_039_5EA5
    ld a, l
    ldh [hFFC9], a
    ld a, h
    ldh [hFFCA], a
    pop bc
    push bc
    ld a, c
    ldh [hFFC6], a

Jump_039_5EA5::
    pop bc
    inc c
    dec b
    jr nz, Jump_039_5E65
    jr Jump_039_5EFA

Jump_039_5EAC::
    ldh a, [hFFD0]
    ld c, a
    ld b, $03

Jump_039_5EB1::
    push bc
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_5ED1
    ldh [hFFCB], a
    call GetBattleHP_Bank39
    ldh a, [hFFC9]
    ld c, a
    ldh a, [hFFCA]
    ld b, a
    call CompareHLToBCFastZero
    jr c, Jump_039_5ED1
    ld a, l
    ldh [hFFC9], a
    ld a, h
    ldh [hFFCA], a
    ld a, c
    ldh [hFFC6], a

Jump_039_5ED1::
    pop bc
    inc c
    dec b
    jr nz, Jump_039_5EB1
    jr Jump_039_5EFA

Jump_039_5ED8::
    ldh a, [hFFD0]
    ld c, a
    ld b, $03
    ldh a, [hFFC7]
    ld e, a

Jump_039_5EE0::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_5EF3
    ld hl, wDA74
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $30
    swap a
    cp a, e
    jr z, Jump_039_5EF7

Jump_039_5EF3::
    inc c
    dec b
    jr nz, Jump_039_5EE0

Jump_039_5EF7::
    ld a, c
    ldh [hFFC6], a

Jump_039_5EFA::
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ldh a, [hFFD0]
    ld e, a
    ldh a, [hFFC6]
    or a, e
    ld [hl], a
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 1 Blaze, 2 Blazemore, 3 Blazemost, $D1, $DF; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActionId, wC58A, wBattleActor, hFFCC, hFFC7, hFFC9, hFFC8, hFFCB, ...
; writes: wRecordBuffer, wCFED, wD869, wD86A, wD86B, wD868, hFFD0, hFFC6, ...
; points at: hFFCE, wD80E, wDA72, wBattleTargetChoice
ChooseTarget_Blaze:: ; heuristic: target of a pointer table; C0
Func_039_5F0E:: ; address name
    ld a, [wBattleActionId]
    ld [wRecordBuffer], a
    xor a, a
    ld [wCFED], a
    ld a, $02
    ld [wD869], a
    ld hl, hFFCE
    ld a, l
    ld [wD86A], a
    ld a, h
    ld [wD86B], a
    ld e, $09
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_039_5F3A
    ld a, [wBattleActor]
    and a, $04
    jr z, Jump_039_5F3A
    ld e, $0D

Jump_039_5F3A::
    ld a, e
    ld [wD868], a
    farcall LoadSkillRecordPart
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hFFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [hFFC6], a
    ldh [hFFC7], a
    ldh [hFFC8], a
    ldh [hFFC9], a
    ldh [hFFCA], a
    ldh [hFFCB], a
    ld [wD874], a
    ld [wD875], a
    xor a, a
    ld [wBattleDamageLo], a
    ld [wD873], a

Jump_039_5F6B::
    push bc
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jp c, Jump_039_5FF2
    ldh [hFFC9], a
    ld hl, wD80E
    call AddAx9ToHL
    ld a, [hl]
    and a, $22
    jr nz, Jump_039_5FF2
    ld a, c
    ldh [hFFCA], a
    ld hl, wDA72
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $30
    swap a
    cp a, $03
    jr z, Jump_039_5FF2
    ldh [hFFCC], a
    push bc
    call ChooseTarget_Blaze_Sub01
    pop bc
    push hl
    ld a, c
    call GetBattleHP_Bank39
    pop bc
    call CompareHLToBC
    jr c, Jump_039_5FD9
    ldh a, [hFFCC]
    ld e, a
    ldh a, [hFFC7]
    cp a, e
    jr z, Jump_039_5FBE
    jr c, Jump_039_5FF2
    ld a, e
    ldh [hFFC7], a
    ldh a, [hFFC9]
    ldh [hFFCB], a
    ld a, l
    ld [wD874], a
    ld a, h
    ld [wD875], a
    jr Jump_039_5FF2

Jump_039_5FBE::
    ld a, [wD874]
    ld c, a
    ld a, [wD875]
    ld b, a
    call CompareHLToBC
    jr nc, Jump_039_5FF2
    ld a, l
    ld [wD874], a
    ld a, h
    ld [wD875], a
    ldh a, [hFFC9]
    ldh [hFFCB], a
    jr Jump_039_5FF2

Jump_039_5FD9::
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wD873]
    ld b, a
    call CompareHLToBCFastZero
    jr c, Jump_039_5FF2
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    ldh a, [hFFC9]
    ldh [hFFC8], a

Jump_039_5FF2::
    pop bc
    inc c
    dec b
    jp nz, Jump_039_5F6B
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ldh a, [hFFC8]
    cp a, $FF
    jr nz, Jump_039_6012
    ldh a, [hFFCB]
    cp a, $FF
    jr nz, Jump_039_6012
    ldh a, [hFFC9]

Jump_039_6012::
    ld [hl], a
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 111 Ramming, 112 Kamikaze; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFCA, hFFC9, hFFC6, hFFD0, hFFC7, hFFC8
; writes: hFFD0, hFFC6, hFFC9, hFFCA, hFFC7, hFFC8
; points at: wD812, wDA75, wD813
ChooseTarget_Ramming:: ; heuristic: target of a pointer table; C0
Func_039_6014:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hFFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [hFFC6], a
    ldh [hFFC9], a
    ldh [hFFCA], a
    xor a, a
    ldh [hFFC7], a
    ldh [hFFC8], a

Jump_039_602D::
    push bc
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_6079
    ldh [hFFC9], a
    ld hl, wD812
    call AddAx9ToHL
    ld a, [hl+]
    and a, $20
    jr nz, Jump_039_6079
    and a, $05
    jr nz, Jump_039_6079
    ld a, c
    ld hl, wDA75
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $03
    cp a, $03
    jr z, Jump_039_6079
    ld e, a
    ldh a, [hFFCA]
    cp a, e
    jr z, Jump_039_6060
    jr nc, Jump_039_6079
    ld a, c
    call GetBattleHP_Bank39
    jr Jump_039_606F

Jump_039_6060::
    ld a, c
    call GetBattleHP_Bank39
    ldh a, [hFFC7]
    ld c, a
    ldh a, [hFFC8]
    ld b, a
    call CompareHLToBC
    jr c, Jump_039_6079

Jump_039_606F::
    ld a, l
    ldh [hFFC7], a
    ld a, h
    ldh [hFFC8], a
    ldh a, [hFFC9]
    ldh [hFFC6], a

Jump_039_6079::
    pop bc
    inc c
    dec b
    jr nz, Jump_039_602D
    ldh a, [hFFC6]
    cp a, $FF
    jp nz, Jump_039_60E9
    ldh a, [hFFD0]
    ld c, a
    ld b, $03

Jump_039_608A::
    push bc
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_60B6
    ldh [hFFC9], a
    ld hl, wD813
    call AddAx9ToHL
    bit 0, [hl]
    jr nz, Jump_039_60B6
    ld a, c
    call GetBattleHP_Bank39
    ldh a, [hFFC7]
    ld c, a
    ldh a, [hFFC8]
    ld b, a
    call CompareHLToBC
    jr c, Jump_039_60B6
    ld a, l
    ldh [hFFC7], a
    ld a, h
    ldh [hFFC8], a
    ldh a, [hFFC9]
    ldh [hFFC6], a

Jump_039_60B6::
    pop bc
    inc c
    dec b
    jr nz, Jump_039_608A
    ldh a, [hFFC6]
    cp a, $FF
    jr nz, Jump_039_60E9
    ldh a, [hFFD0]
    ld c, a
    ld b, $03

Jump_039_60C6::
    push bc
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_60E4
    ldh [hFFC9], a
    call GetBattleHP_Bank39
    ldh a, [hFFC7]
    ld c, a
    ldh a, [hFFC8]
    ld b, a
    jr c, Jump_039_60E4
    ld a, l
    ldh [hFFC7], a
    ld a, h
    ldh [hFFC8], a
    ldh a, [hFFC9]
    ldh [hFFC6], a

Jump_039_60E4::
    pop bc
    inc c
    dec b
    jr nz, Jump_039_60C6

Jump_039_60E9::
    call SetActorTargetFromHFFC6OrHFFC9
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 47 Sleep; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9, hFFCA
; points at: wBattleStatus, wDA74
ChooseTarget_Sleep:: ; heuristic: follows a terminator; C0
Func_039_60ED:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hFFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [hFFC6], a
    ldh [hFFC7], a
    ldh [hFFC8], a
    ldh [hFFC9], a
    ldh [hFFCA], a

Jump_039_6105::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_6143
    ldh [hFFC8], a
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl+]
    and a, $CC
    jr nz, Jump_039_6143
    inc hl
    inc hl
    ld a, [hl-]
    or a, a
    jr nz, Jump_039_6143
    ld a, c
    ldh [hFFC9], a
    ld a, [hl]
    and a, $22
    jr nz, Jump_039_6143
    ld a, c
    ldh [hFFCA], a
    ld hl, wDA74
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $C0
    rlca
    rlca
    cp a, $03
    jr z, Jump_039_6143
    ld e, a
    ldh a, [hFFC7]
    cp a, e
    jr c, Jump_039_6143
    ld a, e
    ldh [hFFC7], a
    ld a, c
    ldh [hFFC6], a

Jump_039_6143::
    inc c
    dec b
    jr nz, Jump_039_6105
    call SetActorTargetFromHRAMChoice4
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 50 RobMagic; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9
; points at: wD80E, wDA74
ChooseTarget_RobMagic:: ; heuristic: follows a terminator; C0
Func_039_614B:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hFFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [hFFC6], a
    ldh [hFFC7], a
    ldh [hFFC8], a
    ldh [hFFC9], a

Jump_039_6161::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_6199
    ldh [hFFC8], a
    call GetBattleMP_Bank39
    ld a, h
    or a, l
    jr z, Jump_039_6199
    ld a, c
    ldh [hFFC9], a
    ld hl, wD80E
    call AddAx9ToHL
    ld a, [hl]
    and a, $22
    jr nz, Jump_039_6199
    ld a, c
    ld hl, wDA74
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $0C
    rrca
    rrca
    cp a, $03
    jr z, Jump_039_6199
    ld e, a
    ldh a, [hFFC7]
    cp a, e
    jr c, Jump_039_6199
    ld a, e
    ldh [hFFC7], a
    ld a, c
    ldh [hFFC6], a

Jump_039_6199::
    inc c
    dec b
    jr nz, Jump_039_6161
    call SetActorTargetFromHRAMChoice
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 80 FireSlash; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7, wBattleDamageLo, wD873
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9, wBattleDamageLo, wD873
; points at: wD80F, wDA72
ChooseTarget_FireSlash:: ; heuristic: target of a pointer table; C0
Func_039_61A1:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hFFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [hFFC6], a
    ldh [hFFC7], a
    ldh [hFFC8], a
    ldh [hFFC9], a
    ld [wBattleDamageLo], a
    ld [wD873], a

Jump_039_61BD::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_621A
    ldh [hFFC8], a
    ld hl, wD80F
    call AddAx9ToHL
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_039_621A
    ld a, [hl]
    and a, $0C
    jr nz, Jump_039_621A
    ld a, c
    ldh [hFFC9], a
    ld hl, wDA72
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $30
    swap a
    ld e, a
    ldh a, [hFFC7]
    cp a, e
    jr z, Jump_039_61F5
    jr c, Jump_039_621A
    ld a, $FF
    ld [wBattleDamageLo], a
    ld [wD873], a
    ld a, e
    ldh [hFFC7], a

Jump_039_61F5::
    push bc
    ld a, c
    call GetBattleHP_Bank39
    push hl
    ld a, c
    call GetBattleDEF_Bank39
    pop bc
    add hl, bc
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wD873]
    ld b, a
    call CompareHLToBC
    pop bc
    jr nc, Jump_039_621A
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    ld a, c
    ldh [hFFC6], a

Jump_039_621A::
    inc c
    dec b
    jr nz, Jump_039_61BD
    call SetActorTargetFromHRAMChoice
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 82 BoltSlash; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7, wBattleDamageLo, wD873
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9, wBattleDamageLo, wD873
; points at: wD80F, wDA73
ChooseTarget_BoltSlash:: ; heuristic: target of a pointer table; C0
Func_039_6222:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hFFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [hFFC6], a
    ldh [hFFC7], a
    ldh [hFFC8], a
    ldh [hFFC9], a
    ld [wBattleDamageLo], a
    ld [wD873], a

Jump_039_623E::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_629B
    ldh [hFFC8], a
    ld hl, wD80F
    call AddAx9ToHL
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_039_629B
    ld a, [hl]
    and a, $0C
    jr nz, Jump_039_629B
    ld a, c
    ldh [hFFC9], a
    ld hl, wDA73
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $30
    swap a
    ld e, a
    ldh a, [hFFC7]
    cp a, e
    jr z, Jump_039_6276
    jr c, Jump_039_629B
    ld a, $FF
    ld [wBattleDamageLo], a
    ld [wD873], a
    ld a, e
    ldh [hFFC7], a

Jump_039_6276::
    push bc
    ld a, c
    call GetBattleHP_Bank39
    push hl
    ld a, c
    call GetBattleDEF_Bank39
    pop bc
    add hl, bc
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wD873]
    ld b, a
    call CompareHLToBC
    pop bc
    jr nc, Jump_039_629B
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    ld a, c
    ldh [hFFC6], a

Jump_039_629B::
    inc c
    dec b
    jr nz, Jump_039_623E
    call SetActorTargetFromHRAMChoice
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 81 VacuSlash; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7, wBattleDamageLo, wD873
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9, wBattleDamageLo, wD873
; points at: wD80F, wDA73
ChooseTarget_VacuSlash:: ; heuristic: target of a pointer table; C0
Func_039_62A3:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hFFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [hFFC6], a
    ldh [hFFC7], a
    ldh [hFFC8], a
    ldh [hFFC9], a
    ld [wBattleDamageLo], a
    ld [wD873], a

Jump_039_62BF::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_631C
    ldh [hFFC8], a
    ld hl, wD80F
    call AddAx9ToHL
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_039_631C
    ld a, [hl]
    and a, $0C
    jr nz, Jump_039_631C
    ld a, c
    ldh [hFFC9], a
    ld hl, wDA73
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $C0
    rlca
    rlca
    ld e, a
    ldh a, [hFFC7]
    cp a, e
    jr z, Jump_039_62F7
    jr c, Jump_039_631C
    ld a, $FF
    ld [wBattleDamageLo], a
    ld [wD873], a
    ld a, e
    ldh [hFFC7], a

Jump_039_62F7::
    push bc
    ld a, c
    call GetBattleHP_Bank39
    push hl
    ld a, c
    call GetBattleDEF_Bank39
    pop bc
    add hl, bc
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wD873]
    ld b, a
    call CompareHLToBC
    pop bc
    jr nc, Jump_039_631C
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    ld a, c
    ldh [hFFC6], a

Jump_039_631C::
    inc c
    dec b
    jr nz, Jump_039_62BF
    call SetActorTargetFromHRAMChoice
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 83 IceSlash; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7, wBattleDamageLo, wD873
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9, wBattleDamageLo, wD873
; points at: wD80F, wDA73
ChooseTarget_IceSlash:: ; heuristic: target of a pointer table; C0
Func_039_6324:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hFFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [hFFC6], a
    ldh [hFFC7], a
    ldh [hFFC8], a
    ldh [hFFC9], a
    ld [wBattleDamageLo], a
    ld [wD873], a

Jump_039_6340::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_639D
    ldh [hFFC8], a
    ld hl, wD80F
    call AddAx9ToHL
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_039_639D
    ld a, [hl]
    and a, $0C
    jr nz, Jump_039_639D
    ld a, c
    ldh [hFFC9], a
    ld hl, wDA73
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $0C
    rrca
    rrca
    ld e, a
    ldh a, [hFFC7]
    cp a, e
    jr z, Jump_039_6378
    jr c, Jump_039_639D
    ld a, $FF
    ld [wBattleDamageLo], a
    ld [wD873], a
    ld a, e
    ldh [hFFC7], a

Jump_039_6378::
    push bc
    ld a, c
    call GetBattleHP_Bank39
    push hl
    ld a, c
    call GetBattleDEF_Bank39
    pop bc
    add hl, bc
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wD873]
    ld b, a
    call CompareHLToBC
    pop bc
    jr nc, Jump_039_639D
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    ld a, c
    ldh [hFFC6], a

Jump_039_639D::
    inc c
    dec b
    jr nz, Jump_039_6340
    call SetActorTargetFromHRAMChoice
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 72 WindBeast; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7, wBattleDamageLo, wD873
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9, wBattleDamageLo, wD873
; points at: wDA73
ChooseTarget_WindBeast:: ; heuristic: follows a terminator; C0
Func_039_63A5:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hFFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [hFFC6], a
    ldh [hFFC7], a
    ldh [hFFC8], a
    ldh [hFFC9], a
    ld [wBattleDamageLo], a
    ld [wD873], a

Jump_039_63C1::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_640E
    ldh [hFFC8], a
    ld a, c
    ldh [hFFC9], a
    ld hl, wDA73
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $C0
    rlca
    rlca
    ld e, a
    ldh a, [hFFC7]
    cp a, e
    jr z, Jump_039_63E9
    jr c, Jump_039_640E
    ld a, $FF
    ld [wBattleDamageLo], a
    ld [wD873], a
    ld a, e
    ldh [hFFC7], a

Jump_039_63E9::
    push bc
    ld a, c
    call GetBattleHP_Bank39
    push hl
    ld a, c
    call GetBattleDEF_Bank39
    pop bc
    add hl, bc
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wD873]
    ld b, a
    call CompareHLToBC
    pop bc
    jr nc, Jump_039_640E
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    ld a, c
    ldh [hFFC6], a

Jump_039_640E::
    inc c
    dec b
    jr nz, Jump_039_63C1
    call SetActorTargetFromHRAMChoice
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 103 GigaSlash; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wBattleTarget, hFFC7, wBattleDamageLo, wD873
; writes: wBattleTarget, hFFD0, hFFC6, hFFC7, hFFC8, hFFC9, wBattleDamageLo, wD873
; points at: wBattleTargetChoice, wDA78
ChooseTarget_GigaSlash:: ; heuristic: target of a pointer table; C0
Func_039_6416:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld [wBattleTarget], a
    ldh [hFFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [hFFC6], a
    ldh [hFFC7], a
    ldh [hFFC8], a
    ldh [hFFC9], a
    ld [wBattleDamageLo], a
    ld [wD873], a

Jump_039_6435::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_6440
    call SlotStatus4Bits23
    jr z, Jump_039_644A

Jump_039_6440::
    inc c
    dec b
    jr nz, Jump_039_6435
    call EstimateAndPickWeakestTarget
    jp Jump_039_64CA

Jump_039_644A::
    ld b, $03
    ld a, [wBattleTarget]
    ld c, a

Jump_039_6450::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_6460
    call AnySlotStatusMaskSet
    jr z, Jump_039_646A
    call TestSlotStatus2Bit3OrStatus5Bits67
    jr z, Jump_039_646A

Jump_039_6460::
    inc c
    dec b
    jr nz, Jump_039_6450
    call EstimateThreeTargets
    jp Jump_039_64CA

Jump_039_646A::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_64C2
    call TestSlotStatus2Bit3OrStatus5Bits67
    jr nz, Jump_039_64C2
    ld a, c
    call AnySlotStatusMaskSet
    jr nz, Jump_039_64C2
    ldh [hFFC8], a
    ld a, c
    ldh [hFFC9], a
    ld hl, wDA78
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $0C
    rrca
    rrca
    ld e, a
    ldh a, [hFFC7]
    cp a, e
    jr z, Jump_039_649D
    jr c, Jump_039_64C2
    ld a, $FF
    ld [wBattleDamageLo], a
    ld [wD873], a
    ld a, e
    ldh [hFFC7], a

Jump_039_649D::
    push bc
    ld a, c
    call GetBattleHP_Bank39
    push hl
    ld a, c
    call GetBattleDEF_Bank39
    pop bc
    add hl, bc
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wD873]
    ld b, a
    call CompareHLToBC
    pop bc
    jr nc, Jump_039_64C2
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    ld a, c
    ldh [hFFC6], a

Jump_039_64C2::
    inc c
    dec b
    jr nz, Jump_039_646A
    call SetActorTargetFromHRAMChoice
    ret

Jump_039_64CA::
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld a, [wBattleTarget]
    ld [hl], a
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 93 AquaCut; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7, wBattleDamageLo, wD873
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9, wBattleDamageLo, wD873
; points at: wD80F, wDA72
ChooseTarget_AquaCut:: ; heuristic: target of a pointer table; C0
Func_039_64DB:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hFFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [hFFC6], a
    ldh [hFFC7], a
    ldh [hFFC8], a
    ldh [hFFC9], a
    ld [wBattleDamageLo], a
    ld [wD873], a

Jump_039_64F7::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_6554
    ldh [hFFC8], a
    ld hl, wD80F
    call AddAx9ToHL
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_039_6554
    ld a, [hl]
    and a, $0C
    jr nz, Jump_039_6554
    ld a, c
    ldh [hFFC9], a
    ld hl, wDA72
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $C0
    rlca
    rlca
    ld e, a
    ldh a, [hFFC7]
    cp a, e
    jr z, Jump_039_652F
    jr c, Jump_039_6554
    ld a, $FF
    ld [wBattleDamageLo], a
    ld [wD873], a
    ld a, e
    ldh [hFFC7], a

Jump_039_652F::
    push bc
    ld a, c
    call GetBattleHP_Bank39
    push hl
    ld a, c
    call GetBattleDEF_Bank39
    pop bc
    add hl, bc
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wD873]
    ld b, a
    call CompareHLToBC
    pop bc
    jr nc, Jump_039_6554
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    ld a, c
    ldh [hFFC6], a

Jump_039_6554::
    inc c
    dec b
    jr nz, Jump_039_64F7
    call SetActorTargetFromHRAMChoice
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 76 Watershot; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7, wBattleDamageLo, wD873
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9, wBattleDamageLo, wD873
; points at: wDA72
ChooseTarget_Watershot:: ; heuristic: follows a terminator; C0
Func_039_655C:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hFFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [hFFC6], a
    ldh [hFFC7], a
    ldh [hFFC8], a
    ldh [hFFC9], a
    ld [wBattleDamageLo], a
    ld [wD873], a

Jump_039_6578::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_65C5
    ldh [hFFC8], a
    ld a, c
    ldh [hFFC9], a
    ld hl, wDA72
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $C0
    rlca
    rlca
    ld e, a
    ldh a, [hFFC7]
    cp a, e
    jr z, Jump_039_65A0
    jr c, Jump_039_65C5
    ld a, $FF
    ld [wBattleDamageLo], a
    ld [wD873], a
    ld a, e
    ldh [hFFC7], a

Jump_039_65A0::
    push bc
    ld a, c
    call GetBattleHP_Bank39
    push hl
    ld a, c
    call GetBattleDEF_Bank39
    pop bc
    add hl, bc
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wD873]
    ld b, a
    call CompareHLToBC
    pop bc
    jr nc, Jump_039_65C5
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    ld a, c
    ldh [hFFC6], a

Jump_039_65C5::
    inc c
    dec b
    jr nz, Jump_039_6578
    call SetActorTargetFromHRAMChoice
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 61 MegaMagic; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFCC, hFFC7, hFFC9, hFFC8, hFFCB, wD874, wD875, ...
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9, hFFCA, hFFCB, wD874, ...
; points at: wDA76, wBattleTargetChoice
ChooseTarget_MegaMagic:: ; heuristic: target of a pointer table; C0
Func_039_65CD:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hFFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [hFFC6], a
    ldh [hFFC7], a
    ldh [hFFC8], a
    ldh [hFFC9], a
    ldh [hFFCA], a
    ldh [hFFCB], a
    ld [wD874], a
    ld [wD875], a
    xor a, a
    ld [wBattleDamageLo], a
    ld [wD873], a

Jump_039_65F4::
    push bc
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jp c, Jump_039_666F
    ldh [hFFC9], a
    ld hl, wDA76
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $C0
    rrca
    rrca
    swap a
    cp a, $03
    jr z, Jump_039_666F
    ldh [hFFCC], a
    push bc
    call ChooseTarget_MegaMagic_Sub01
    pop bc
    push hl
    ld a, c
    call GetBattleHP_Bank39
    pop bc
    call CompareHLToBC
    jr c, Jump_039_6656
    ldh a, [hFFCC]
    ld e, a
    ldh a, [hFFC7]
    cp a, e
    jr z, Jump_039_663B
    jr c, Jump_039_666F
    ld a, e
    ldh [hFFC7], a
    ldh a, [hFFC9]
    ldh [hFFCB], a
    ld a, l
    ld [wD874], a
    ld a, h
    ld [wD875], a
    jr Jump_039_666F

Jump_039_663B::
    ld a, [wD874]
    ld c, a
    ld a, [wD875]
    ld b, a
    call CompareHLToBC
    jr nc, Jump_039_666F
    ld a, l
    ld [wD874], a
    ld a, h
    ld [wD875], a
    ldh a, [hFFC9]
    ldh [hFFCB], a
    jr Jump_039_666F

Jump_039_6656::
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wD873]
    ld b, a
    call CompareHLToBCFastZero
    jr c, Jump_039_666F
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    ldh a, [hFFC9]
    ldh [hFFC8], a

Jump_039_666F::
    pop bc
    inc c
    dec b
    jp nz, Jump_039_65F4
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ldh a, [hFFC8]
    cp a, $FF
    jr nz, Jump_039_668F
    ldh a, [hFFCB]
    cp a, $FF
    jr nz, Jump_039_668F
    ldh a, [hFFC9]

Jump_039_668F::
    ld [hl], a
    ret

; after AdvanceRandom, lists the present opposite slots in slot order (count in hFFC6, slots in hFFC7-hFFC9, unused entries $FF) and lets PickWeightedTargetCandidate choose (E-0061)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; writes: hFFC6, hFFC7, hFFC8, hFFC9
; points at: hFFC6, hFFC7
TargetFoeWeightedBySlotOrder:: ; heuristic: target of a pointer table; C0
Func_039_6691:: ; address name
    call AdvanceRandom
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    xor a, a
    ldh [hFFC6], a
    ld a, $FF
    ldh [hFFC7], a
    ldh [hFFC8], a
    ldh [hFFC9], a

Jump_039_66A9::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_66BD
    ld hl, hFFC6
    ld a, [hl]
    inc [hl]
    ld hl, hFFC7
    add_a_to_hl
    ld [hl], c

Jump_039_66BD::
    inc c
    dec b
    jr nz, Jump_039_66A9
    call PickWeightedTargetCandidate
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 0 (no name), 98 SquallHit, 99 BiAttack, 105 PsycheUp, 106 HighJump, 107 EvilSlash, 109 TwinSlash, 112 Kamikaze, $CC, $D2 ...; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wBattleDamageLo, wD873, wD874, wD875, hFFC7, hFFC8, wD876, ...
; writes: hFFC6, hFFC7, hFFC8, hFFC9, wBattleDamageLo, wD873, wD874, wD875, ...
; points at: hFFC6, hFFC7, wBattleDamageLo
ChooseTarget_SquallHit_66C5:: ; heuristic: target of a pointer table; C0
Func_039_66C5:: ; address name
    call AdvanceRandom
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    xor a, a
    ldh [hFFC6], a
    ld a, $FF
    ldh [hFFC7], a
    ldh [hFFC8], a
    ldh [hFFC9], a
    ld [wBattleDamageLo], a
    ld [wD873], a
    ld [wD874], a
    ld [wD875], a
    ld [wD876], a
    ld [wD877], a

Jump_039_66EF::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_6722
    ld hl, hFFC6
    ld e, [hl]
    ld a, e
    ld hl, hFFC7
    add_a_to_hl
    ld [hl], c
    ld a, e
    ld hl, wBattleDamageLo
    add a, a
    add_a_to_hl
    push hl
    ld a, e
    call GetBattleHP_Bank39
    push hl
    ld a, e
    call GetBattleDEF_Bank39
    pop de
    add hl, de
    sra h
    rr l
    ld d, h
    ld a, l
    pop hl
    ld [hl+], a
    ld [hl], d

Jump_039_6722::
    inc c
    dec b
    jr nz, Jump_039_66EF
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wD873]
    ld h, a
    ld a, [wD874]
    ld c, a
    ld a, [wD875]
    ld b, a
    call CompareHLToBC
    jr z, Jump_039_6757
    jr c, Jump_039_6757
    ld a, l
    ld [wD874], a
    ld a, h
    ld [wD875], a
    ld a, c
    ld [wBattleDamageLo], a
    ld a, b
    ld [wD873], a
    ldh a, [hFFC7]
    push af
    ldh a, [hFFC8]
    ldh [hFFC7], a
    pop af
    ldh [hFFC8], a

Jump_039_6757::
    ld a, [wD874]
    ld l, a
    ld a, [wD875]
    ld h, a
    ld a, [wD876]
    ld c, a
    ld a, [wD877]
    ld b, a
    call CompareHLToBC
    jr z, Jump_039_6788
    jr c, Jump_039_6788
    ld a, l
    ld [wD876], a
    ld a, h
    ld [wD877], a
    ld a, c
    ld [wD874], a
    ld a, b
    ld [wD875], a
    ldh a, [hFFC8]
    push af
    ldh a, [hFFC9]
    ldh [hFFC8], a
    pop af
    ldh [hFFC9], a

Jump_039_6788::
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wD873]
    ld h, a
    ld a, [wD874]
    ld c, a
    ld a, [wD875]
    ld b, a
    call CompareHLToBC
    jr z, Jump_039_67A9
    jr c, Jump_039_67A9
    ldh a, [hFFC7]
    push af
    ldh a, [hFFC8]
    ldh [hFFC7], a
    pop af
    ldh [hFFC8], a

Jump_039_67A9::
    call PickWeightedTargetCandidate
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 22 Heal, 23 HealMore, 24 HealAll; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFCB, hFFCC, hFFC7, hFFC8, hFFC6, hFFC9, hFFCA
; writes: wD09D, wD09E, wD09F, wD0A0, wD0A1, wD0A2, wD0A3, wD0A4, ...
; points at: wD09D, hFFC7, wBattleTargetChoice
ChooseTarget_Heal_67AD:: ; heuristic: target of a pointer table; C0
Func_039_67AD:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld e, a
    ld d, $03
    push de
    xor a, a
    ld [wD09D], a
    ld [wD09E], a
    ld [wD09F], a
    ld [wD0A0], a
    ld [wD0A1], a
    ld [wD0A2], a
    ld [wD0A3], a
    ld [wD0A4], a
    ld [wD0A5], a
    ld [wD0A6], a
    ld [wD0A7], a
    ld [wD0A8], a

Jump_039_67DB::
    ld a, e
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_680E
    call GetBattleHP_Bank39
    push hl
    ld a, e
    call GetBattleMaxHP_Bank39
    pop bc
    call CompareHLToBC
    jr z, Jump_039_680E
    push de
    call DivideHLByBC
    pop de
    push de
    ld a, e
    and a, $03
    ld de, wD09D
    add a, a
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_039_6802
    inc d

Jump_039_6802::
    ld a, l
    ld [de], a
    inc de
    ld a, h
    ld [de], a
    inc de
    ld a, c
    ld [de], a
    inc de
    ld a, b
    ld [de], a
    pop de

Jump_039_680E::
    inc e
    dec d
    jr nz, Jump_039_67DB
    pop de
    ld a, $FF
    ldh [hFFC6], a
    xor a, a
    ldh [hFFC7], a
    ldh [hFFC8], a
    ldh [hFFC9], a
    ldh [hFFCA], a

Jump_039_6820::
    ld a, e
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_6895
    ld hl, hFFC7
    ld a, [hl+]
    or a, [hl]
    inc hl
    or a, [hl]
    inc hl
    or a, [hl]
    jr z, Jump_039_687A
    ld a, e
    and a, $03
    ld hl, wD09D
    add a, a
    add a, a
    add_a_to_hl
    ld a, l
    ldh [hFFCB], a
    ld a, h
    ldh [hFFCC], a
    ld a, [hl+]
    or a, [hl]
    inc hl
    or a, [hl]
    inc hl
    or a, [hl]
    jr z, Jump_039_6895
    ldh a, [hFFCB]
    ld l, a
    ldh a, [hFFCC]
    ld h, a
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ldh a, [hFFC7]
    ld l, a
    ldh a, [hFFC8]
    ld h, a
    call CompareHLToBC
    jr z, Jump_039_6864
    jr nc, Jump_039_6895
    jr Jump_039_687A

Jump_039_6864::
    ldh a, [hFFCB]
    ld l, a
    ldh a, [hFFCC]
    ld h, a
    inc hl
    inc hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ldh a, [hFFC9]
    ld l, a
    ldh a, [hFFCA]
    ld h, a
    call CompareHLToBC
    jr nc, Jump_039_6895

Jump_039_687A::
    ld a, e
    ldh [hFFC6], a
    and a, $03
    ld hl, wD09D
    add a, a
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ldh [hFFC7], a
    ld a, [hl+]
    ldh [hFFC8], a
    ld a, [hl+]
    ldh [hFFC9], a
    ld a, [hl]
    ldh [hFFCA], a

Jump_039_6895::
    inc e
    dec d
    jr nz, Jump_039_6820
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ldh a, [hFFC6]
    cp a, $FF
    jr nz, Jump_039_68AE
    ld a, [wBattleActor]

Jump_039_68AE::
    ld [hl], a
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 22 Heal, 23 HealMore, 24 HealAll; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFCA, hFFCB, hFFC6, wD876, wD877, wD874, wD875, ...
; writes: hFFC6, hFFCA, hFFCB, hFFC7, hFFC8, hFFC9, wBattleDamageLo, wD873, ...
; points at: hFFC6, wBattleDamageLo, hFFC7, wBattleTargetChoice, wD09D
ChooseTarget_Heal_68B0:: ; heuristic: target of a pointer table; C0
Func_039_68B0:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld e, a
    ld d, $03
    push de
    xor a, a
    ldh [hFFC6], a
    ldh [hFFCA], a
    ldh [hFFCB], a
    ld a, $FF
    ldh [hFFC7], a
    ldh [hFFC8], a
    ldh [hFFC9], a
    ld [wBattleDamageLo], a
    ld [wD873], a
    ld [wD874], a
    ld [wD875], a
    ld [wD876], a
    ld [wD877], a

Jump_039_68DA::
    ld a, e
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_68F1
    call GetBattleMaxHP_Bank39
    ldh a, [hFFCA]
    add a, l
    ldh [hFFCA], a
    ldh a, [hFFCB]
    adc a, h
    ldh [hFFCB], a
    ld hl, hFFC6
    inc [hl]

Jump_039_68F1::
    inc e
    dec d
    jr nz, Jump_039_68DA
    ldh a, [hFFCA]
    ld l, a
    ldh a, [hFFCB]
    ld h, a
    ldh a, [hFFC6]
    call DivideHLByA
    ld a, l
    ldh [hFFCA], a
    ld a, h
    ldh [hFFCB], a
    xor a, a
    ldh [hFFC6], a
    pop de

Jump_039_690A::
    ld a, e
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_693C
    call GetBattleHP_Bank39
    ldh a, [hFFCA]
    ld c, a
    ldh a, [hFFCB]
    ld b, a
    call CompareHLToBC
    jr nc, Jump_039_693C
    ldh a, [hFFC6]
    ld bc, wBattleDamageLo
    add a, a
    add a, c
    ld c, a
    jr nc, Jump_039_6929
    inc b

Jump_039_6929::
    ld a, l
    ld [bc], a
    inc bc
    ld a, h
    ld [bc], a
    ld hl, hFFC6
    ld a, [hl]
    inc [hl]
    ld hl, hFFC7
    add_a_to_hl
    ld [hl], e

Jump_039_693C::
    inc e
    dec d
    jr nz, Jump_039_690A
    ldh a, [hFFC6]
    or a, a
    jp z, ChooseTarget_Heal_67AD
    cp a, $01
    jr z, Jump_039_6988
    cp a, $02
    jr z, Jump_039_696F
    ld a, [wD876]
    ld l, a
    ld a, [wD877]
    ld h, a
    ld a, [wD874]
    ld c, a
    ld a, [wD875]
    ld b, a
    call CompareHLToBC
    jr nc, Jump_039_696F
    ld a, l
    ld [wD874], a
    ld a, h
    ld [wD875], a
    ldh a, [hFFC9]
    ldh [hFFC8], a

Jump_039_696F::
    ld a, [wD874]
    ld l, a
    ld a, [wD875]
    ld h, a
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wD873]
    ld b, a
    call CompareHLToBC
    jr nc, Jump_039_6988
    ldh a, [hFFC8]
    ldh [hFFC7], a

Jump_039_6988::
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ldh a, [hFFC7]
    ld [hl], a
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 30 Vivify, 31 Revive; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC6, wC5E7
; writes: hFFC6, hFFC7, hFFC8, hFFC9
; points at: wBattleSlotOut, hFFC7, hFFC6, wBattleTargetChoice
ChooseTarget_Vivify_6998:: ; heuristic: target of a pointer table; C0
Func_039_6998:: ; address name
    jp ChooseTarget_Vivify

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 33 Antidote; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wC5E7, hFFC6
; writes: hFFC7, hFFC8, hFFC9, hFFC6
; points at: hFFC7, wBattleStatus, wBattleTargetChoice
ChooseTarget_Antidote_699B:: ; heuristic: target of a pointer table; C0
Func_039_699B:: ; address name
    jp ChooseTarget_Antidote

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 45 TwinHits; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7, hFFC8, hFFC6, wC5E7
; writes: hFFC6, hFFC7, hFFC8
; points at: wBattleStatus, wBattleTargetChoice
ChooseTarget_TwinHits_699E:: ; heuristic: follows a terminator; C0
Func_039_699E:: ; address name
    jp ChooseTarget_TwinHits

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 37 Upper; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7, hFFC8, hFFC6
; writes: hFFC6, hFFC7, hFFC8
; points at: wBattleTargetChoice
ChooseTarget_Upper_69A1:: ; heuristic: target of a pointer table; C0
Func_039_69A1:: ; address name
    jp ChooseTarget_Upper

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 39 Sap; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9
; points at: wD80E, wDA75
ChooseTarget_Sap_69A4:: ; heuristic: target of a pointer table; C0
Func_039_69A4:: ; address name
    jp ChooseTarget_Sap

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 43 Slow; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9
; points at: wD80E, wDA75
ChooseTarget_Slow_69A7:: ; heuristic: follows a terminator; C0
Func_039_69A7:: ; address name
    jp ChooseTarget_Slow

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 41 Speed; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7, hFFC8, hFFC6
; writes: hFFC6, hFFC7, hFFC8
; points at: wBattleTargetChoice
ChooseTarget_Speed_69AA:: ; heuristic: follows a terminator; C0
Func_039_69AA:: ; address name
    jp ChooseTarget_Speed

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 130 UltraDown; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9
; points at: wDA74
ChooseTarget_UltraDown_69AD:: ; heuristic: follows a terminator; C0
Func_039_69AD:: ; address name
    jp ChooseTarget_UltraDown

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 151 Cover; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFCA, hFFC7, hFFC8
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9, hFFCA, hFFCB
ChooseTarget_Cover_69B0:: ; heuristic: target of a pointer table; C0
Func_039_69B0:: ; address name
    jp ChooseTarget_Cover

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 147 MouthShut; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9, hFFCA
; points at: wD80D, wDA78
ChooseTarget_MouthShut_69B3:: ; heuristic: target of a pointer table; C0
Func_039_69B3:: ; address name
    jp ChooseTarget_MouthShut

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 140 SickLick; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9, hFFCA
; points at: wBattleStatus, wDA77
ChooseTarget_SickLick_69B6:: ; heuristic: target of a pointer table; C0
Func_039_69B6:: ; address name
    jp ChooseTarget_SickLick

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 141 LegSweep; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9, hFFCA
; points at: wD8A7, wBattleStatus, wDA77
ChooseTarget_LegSweep_69B9:: ; heuristic: target of a pointer table; C0
Func_039_69B9:: ; address name
    jp ChooseTarget_LegSweep

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 97 NapAttack; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9
; points at: wBattleStatus, wDA74
ChooseTarget_NapAttack_69BC:: ; heuristic: target of a pointer table; C0
Func_039_69BC:: ; address name
    jp ChooseTarget_NapAttack

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 118 OddDance, 119 RobDance; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9
; points at: wDA74
ChooseTarget_OddDance_69BF:: ; heuristic: follows a terminator; C0
Func_039_69BF:: ; address name
    jp ChooseTarget_OddDance

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 94 MetalCut; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7, hFFC8, hFFC9
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9
; points at: wD8A7
ChooseTarget_MetalCut_69C2:: ; heuristic: target of a pointer table; C0
Func_039_69C2:: ; address name
    jp ChooseTarget_MetalCut

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 85 DrakSlash; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
ChooseTarget_DrakSlash_69C5:: ; heuristic: target of a pointer table; C0
Func_039_69C5:: ; address name
    ld d, $01
    call TargetRandomFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 86 BeastCut; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
ChooseTarget_BeastCut_69CB:: ; heuristic: target of a pointer table; C0
Func_039_69CB:: ; address name
    ld d, $02
    call TargetRandomFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 87 BirdBlow; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
ChooseTarget_BirdBlow_69D1:: ; heuristic: target of a pointer table; C0
Func_039_69D1:: ; address name
    ld d, $03
    call TargetRandomFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 90 DevilCut; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
ChooseTarget_DevilCut_69D7:: ; heuristic: target of a pointer table; C0
Func_039_69D7:: ; address name
    ld d, $06
    call TargetRandomFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 91 ZombieCut; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
ChooseTarget_ZombieCut_69DD:: ; heuristic: target of a pointer table; C0
Func_039_69DD:: ; address name
    ld d, $07
    call TargetRandomFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 92 CleanCut; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
ChooseTarget_CleanCut_69E3:: ; heuristic: target of a pointer table; C0
Func_039_69E3:: ; address name
    ld d, $08
    call TargetRandomFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 84 SlimeBlow; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
ChooseTarget_SlimeBlow_69E9:: ; heuristic: target of a pointer table; C0
Func_039_69E9:: ; address name
    ld d, $00
    call TargetRandomFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 88 BugBlow; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
ChooseTarget_BugBlow_69EF:: ; heuristic: target of a pointer table; C0
Func_039_69EF:: ; address name
    ld d, $05
    call TargetRandomFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 89 Shears; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
ChooseTarget_Shears_69F5:: ; heuristic: target of a pointer table; C0
Func_039_69F5:: ; address name
    ld d, $04
    call TargetRandomFoeOfFamilyD
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 95 PoisonHit; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9
; points at: wBattleStatus, wDA76
ChooseTarget_PoisonHit_69FB:: ; heuristic: target of a pointer table; C0
Func_039_69FB:: ; address name
    jp ChooseTarget_PoisonHit

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 96 Paralyze; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9
; points at: wBattleStatus, wDA77
ChooseTarget_Paralyze_69FE:: ; heuristic: target of a pointer table; C0
Func_039_69FE:: ; address name
    jp ChooseTarget_Paralyze

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 139 LushLicks, 143 Ahhh; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9
; points at: wBattleStatus, wDA77
ChooseTarget_LushLicks_6A01:: ; heuristic: target of a pointer table; C0
Func_039_6A01:: ; address name
    jp ChooseTarget_LushLicks

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 58 Transform; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7, hFFC8, hFFC9
; writes: hFFD0, hFFC6, hFFC9, hFFC7, hFFC8
ChooseTarget_Transform_6A04:: ; heuristic: target of a pointer table; C0
Func_039_6A04:: ; address name
    jp ChooseTarget_Transform

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 19 Beat; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7, hFFC8, hFFD0, hFFC9, hFFCA, hFFC6
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9, hFFCA, hFFCB
; points at: wD80E, wDA74, hFFC8, wBattleTargetChoice
ChooseTarget_Beat_6A07:: ; heuristic: follows a terminator; C0
Func_039_6A07:: ; address name
    jp ChooseTarget_Beat

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 1 Blaze, 2 Blazemore, 3 Blazemost, $D1, $DF; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActionId, wC58A, wBattleActor, hFFCC, hFFC7, hFFC9, hFFC8, hFFCB, ...
; writes: wRecordBuffer, wCFED, wD869, wD86A, wD86B, wD868, hFFD0, hFFC6, ...
; points at: hFFCE, wD80E, wDA72, wBattleTargetChoice
ChooseTarget_Blaze_6A0A:: ; heuristic: target of a pointer table; C0
Func_039_6A0A:: ; address name
    jp ChooseTarget_Blaze

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 110 Berserker, 111 Ramming; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFCA, hFFC9, hFFC6, hFFD0, hFFC7, hFFC8
; writes: hFFD0, hFFC6, hFFC9, hFFCA, hFFC7, hFFC8
; points at: wD812, wDA75, wD813
ChooseTarget_Berserker:: ; heuristic: target of a pointer table; C0
Func_039_6A0D:: ; address name
    jp ChooseTarget_Ramming

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 47 Sleep; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9, hFFCA
; points at: wBattleStatus, wDA74
ChooseTarget_Sleep_6A10:: ; heuristic: follows a terminator; C0
Func_039_6A10:: ; address name
    jp ChooseTarget_Sleep

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 50 RobMagic; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9
; points at: wD80E, wDA74
ChooseTarget_RobMagic_6A13:: ; heuristic: follows a terminator; C0
Func_039_6A13:: ; address name
    jp ChooseTarget_RobMagic

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 80 FireSlash; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7, wBattleDamageLo, wD873
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9, wBattleDamageLo, wD873
; points at: wD80F, wDA72
ChooseTarget_FireSlash_6A16:: ; heuristic: target of a pointer table; C0
Func_039_6A16:: ; address name
    jp ChooseTarget_FireSlash

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 82 BoltSlash; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7, wBattleDamageLo, wD873
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9, wBattleDamageLo, wD873
; points at: wD80F, wDA73
ChooseTarget_BoltSlash_6A19:: ; heuristic: target of a pointer table; C0
Func_039_6A19:: ; address name
    jp ChooseTarget_BoltSlash

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 81 VacuSlash; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7, wBattleDamageLo, wD873
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9, wBattleDamageLo, wD873
; points at: wD80F, wDA73
ChooseTarget_VacuSlash_6A1C:: ; heuristic: target of a pointer table; C0
Func_039_6A1C:: ; address name
    jp ChooseTarget_VacuSlash

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 83 IceSlash; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7, wBattleDamageLo, wD873
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9, wBattleDamageLo, wD873
; points at: wD80F, wDA73
ChooseTarget_IceSlash_6A1F:: ; heuristic: target of a pointer table; C0
Func_039_6A1F:: ; address name
    jp ChooseTarget_IceSlash

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 72 WindBeast; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7, wBattleDamageLo, wD873
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9, wBattleDamageLo, wD873
; points at: wDA73
ChooseTarget_WindBeast_6A22:: ; heuristic: follows a terminator; C0
Func_039_6A22:: ; address name
    jp ChooseTarget_WindBeast

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 103 GigaSlash; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7, wBattleDamageLo, wD873
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9, wBattleDamageLo, wD873
; points at: wDA78
ChooseTarget_GigaSlash_6A25:: ; heuristic: target of a pointer table; C0
Func_039_6A25:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hFFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [hFFC6], a
    ldh [hFFC7], a
    ldh [hFFC8], a
    ldh [hFFC9], a
    ld [wBattleDamageLo], a
    ld [wD873], a

Jump_039_6A41::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_6A8E
    ldh [hFFC8], a
    ld a, c
    ldh [hFFC9], a
    ld hl, wDA78
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $0C
    rrca
    rrca
    ld e, a
    ldh a, [hFFC7]
    cp a, e
    jr z, Jump_039_6A69
    jr c, Jump_039_6A8E
    ld a, $FF
    ld [wBattleDamageLo], a
    ld [wD873], a
    ld a, e
    ldh [hFFC7], a

Jump_039_6A69::
    push bc
    ld a, c
    call GetBattleHP_Bank39
    push hl
    ld a, c
    call GetBattleDEF_Bank39
    pop bc
    add hl, bc
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wD873]
    ld b, a
    call CompareHLToBC
    pop bc
    jr nc, Jump_039_6A8E
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    ld a, c
    ldh [hFFC6], a

Jump_039_6A8E::
    inc c
    dec b
    jr nz, Jump_039_6A41
    call SetActorTargetFromHRAMChoice
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 93 AquaCut; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7, wBattleDamageLo, wD873
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9, wBattleDamageLo, wD873
; points at: wD80F, wDA72
ChooseTarget_AquaCut_6A96:: ; heuristic: target of a pointer table; C0
Func_039_6A96:: ; address name
    jp ChooseTarget_AquaCut

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 76 Watershot; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7, wBattleDamageLo, wD873
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9, wBattleDamageLo, wD873
; points at: wDA72
ChooseTarget_Watershot_6A99:: ; heuristic: follows a terminator; C0
Func_039_6A99:: ; address name
    jp ChooseTarget_Watershot

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 173 PanicAll; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9, hFFCA
; points at: wBattleStatus, wDA75
ChooseTarget_PanicAll:: ; heuristic: target of a pointer table; C0
Func_039_6A9C:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hFFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [hFFC6], a
    ldh [hFFC7], a
    ldh [hFFC8], a
    ldh [hFFC9], a
    ldh [hFFCA], a

Jump_039_6AB4::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_6AF2
    ldh [hFFC8], a
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl+]
    and a, $CC
    jr nz, Jump_039_6AF2
    inc hl
    inc hl
    ld a, [hl-]
    or a, a
    jr nz, Jump_039_6AF2
    ld a, c
    ldh [hFFC9], a
    ld a, [hl]
    and a, $22
    jr nz, Jump_039_6AF2
    ld a, c
    ldh [hFFCA], a
    ld hl, wDA75
    call ReadByteAtHLPlus4APlus3C_Bank39
    and a, $C0
    rlca
    rlca
    cp a, $03
    jr z, Jump_039_6AF2
    ld e, a
    ldh a, [hFFC7]
    cp a, e
    jr c, Jump_039_6AF2
    ld a, e
    ldh [hFFC7], a
    ld a, c
    ldh [hFFC6], a

Jump_039_6AF2::
    inc c
    dec b
    jr nz, Jump_039_6AB4
    call SetActorTargetFromHRAMChoice4
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 61 MegaMagic; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFCC, hFFC7, hFFC9, hFFC8, hFFCB, wD874, wD875, ...
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9, hFFCA, hFFCB, wD874, ...
; points at: wDA76, wBattleTargetChoice
ChooseTarget_MegaMagic_6AFA:: ; heuristic: target of a pointer table; C0
Func_039_6AFA:: ; address name
    jp ChooseTarget_MegaMagic

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 33 Antidote; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC6, hFFC7, wC5E7, hFFC8
; writes: hFFC6, hFFC7, hFFC8, hFFC9
; points at: wBattleStatus, hFFC6, hFFC7, wBattleTargetChoice
ChooseTarget_Antidote_6AFD:: ; heuristic: target of a pointer table; C0
Func_039_6AFD:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld hl, wBattleStatus
    ld d, $03
    jp Jump_039_6BE3

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 37 Upper; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC6, hFFC7, wC5E7, hFFC8
; writes: hFFC6, hFFC7, hFFC8, hFFC9
; points at: hFFC6, hFFC7, wBattleTargetChoice
ChooseTarget_Upper_6B0A:: ; heuristic: target of a pointer table; C0
Func_039_6B0A:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03
    xor a, a
    ldh [hFFC6], a
    ld a, $FF
    ldh [hFFC7], a
    ldh [hFFC8], a
    ldh [hFFC9], a

Jump_039_6B1D::
    push bc
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_6B41
    call GetBattleDEF_Bank39
    push hl
    call BuffCapOfBaseDEF
    pop bc
    call CompareHLToBC
    jr z, Jump_039_6B41
    ld hl, hFFC6
    ld a, [hl]
    inc [hl]
    ld hl, hFFC7
    add_a_to_hl
    pop bc
    ld [hl], c
    push bc

Jump_039_6B41::
    pop bc
    inc c
    dec b
    jr nz, Jump_039_6B1D
    ldh a, [hFFC6]
    or a, a
    jp nz, PickWeightedTargetCandidate
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld a, [wBattleActor]
    ld [hl], a
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 41 Speed; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC6, hFFC7, wC5E7, hFFC8
; writes: hFFC6, hFFC7, hFFC8, hFFC9
; points at: hFFC6, hFFC7, wBattleTargetChoice
ChooseTarget_Speed_6B5D:: ; heuristic: follows a terminator; C0
Func_039_6B5D:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03
    xor a, a
    ldh [hFFC6], a
    ld a, $FF
    ldh [hFFC7], a
    ldh [hFFC8], a
    ldh [hFFC9], a

Jump_039_6B70::
    push bc
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_6B94
    call GetBattleAGL_Bank39
    push hl
    call BuffCapOfBaseAGL
    pop bc
    call CompareHLToBC
    jr z, Jump_039_6B94
    ld hl, hFFC6
    ld a, [hl]
    inc [hl]
    ld hl, hFFC7
    add_a_to_hl
    pop bc
    ld [hl], c
    push bc

Jump_039_6B94::
    pop bc
    inc c
    dec b
    jr nz, Jump_039_6B70
    ldh a, [hFFC6]
    or a, a
    jp nz, PickWeightedTargetCandidate
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld a, [wBattleActor]
    ld [hl], a
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 39 Sap; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC6
; writes: hFFC6, hFFC7, hFFC8, hFFC9
; points at: hFFC6, hFFC7
ChooseTarget_Sap_6BB0:: ; heuristic: target of a pointer table; C0
Func_039_6BB0:: ; address name
    ld de, GetBattleDEF_Bank39
    jp Jump_039_6C30
    db $11, $03, $72, $C3, $30, $6C, $FA, $A4, $D8, $E6, $04, $21, $0C, $D8, $16, $10
    db $C3, $E3, $6B, $FA, $A4, $D8, $E6, $04, $21, $0C, $D8, $16, $40, $C3, $E3, $6B
    db $FA, $A4, $D8, $E6, $04, $21, $0C, $D8, $16, $20, $C3, $E3, $6B

Jump_039_6BE3::
    ld c, a
    ld b, $03
    call AddAx9ToHL
    xor a, a
    ldh [hFFC6], a
    ld a, $FF
    ldh [hFFC7], a
    ldh [hFFC8], a
    ldh [hFFC9], a

Jump_039_6BF4::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_6C0E
    ld a, [hl]
    and a, d
    jr z, Jump_039_6C0E
    push hl
    ld hl, hFFC6
    ld a, [hl]
    inc [hl]
    ld hl, hFFC7
    add_a_to_hl
    ld [hl], c
    pop hl

Jump_039_6C0E::
    ld a, $09
    add_a_to_hl
    inc c
    dec b
    jr nz, Jump_039_6BF4
    ldh a, [hFFC6]
    or a, a
    jp nz, PickWeightedTargetCandidate
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld a, [wBattleActor]
    ld [hl], a
    ret

Jump_039_6C30::
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    xor a, a
    ldh [hFFC6], a
    ld a, $FF
    ldh [hFFC7], a
    ldh [hFFC8], a
    ldh [hFFC9], a

Jump_039_6C45::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_6C67
    ld h, d
    ld l, e
    call JumpToHL
    ld a, h
    or a, a
    jr nz, Jump_039_6C59
    ld a, l
    cp a, $02
    jr c, Jump_039_6C67

Jump_039_6C59::
    ld hl, hFFC6
    ld a, [hl]
    inc [hl]
    ld hl, hFFC7
    add_a_to_hl
    ld [hl], c

Jump_039_6C67::
    inc c
    dec b
    jr nz, Jump_039_6C45
    ldh a, [hFFC6]
    or a, a
    jp z, TargetFoeWeightedBySlotOrder
    call PickWeightedTargetCandidate
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 22 Heal, 23 HealMore, 24 HealAll; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7, hFFC8, hFFC9, hFFCA, wC5E7, hFFC6
; writes: hFFC6, hFFC7, hFFC8, hFFC9, hFFCA
; points at: wBattleTargetChoice
ChooseTarget_Heal_6C75:: ; heuristic: target of a pointer table; C0
Func_039_6C75:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [hFFC6], a
    xor a, a
    ldh [hFFC7], a
    ldh [hFFC8], a
    ldh [hFFC9], a
    ldh [hFFCA], a

Jump_039_6C8A::
    push bc
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_6CD4
    call GetBattleHP_Bank39
    push hl
    ld a, c
    call GetBattleMaxHP_Bank39
    pop bc
    call DivideHLByBC
    ldh a, [hFFC7]
    sub a, l
    ld e, a
    ldh a, [hFFC8]
    sbc a, h
    ld d, a
    jr c, Jump_039_6CC3
    ld a, d
    or a, e
    jr nz, Jump_039_6CD4
    ldh a, [hFFC9]
    sub a, c
    ld e, a
    ldh a, [hFFCA]
    sbc a, b
    ld d, a
    jr c, Jump_039_6CC3
    ld a, d
    or a, e
    jr nz, Jump_039_6CD4
    call AdvanceRandom
    ld a, [wC5E7]
    bit 7, a
    jr z, Jump_039_6CD4

Jump_039_6CC3::
    ld a, l
    ldh [hFFC7], a
    ld a, h
    ldh [hFFC8], a
    ld a, c
    ldh [hFFC9], a
    ld a, b
    ldh [hFFCA], a
    pop bc
    ld a, c
    ldh [hFFC6], a
    push bc

Jump_039_6CD4::
    pop bc
    inc c
    dec b
    jr nz, Jump_039_6C8A
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ldh a, [hFFC6]
    ld [hl], a
    ret

; per-action target routine of ChooseActionTarget (the five mode tables of Data_039_41AC, 228 entries each, indexed by action id) for action(s) 27 MPass, 28 MPassmore, 29 MPassmost; writes the target to wBattleTargetChoice; the selection rule is not interpreted (E-0086)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hFFC7, hFFC8, hFFC9, hFFCA, wC5E7, hFFC6
; writes: hFFC6, hFFC7, hFFC8, hFFC9, hFFCA
; points at: wBattleTargetChoice
ChooseTarget_MPass:: ; heuristic: target of a pointer table; C0
Func_039_6CE9:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [hFFC6], a
    xor a, a
    ldh [hFFC7], a
    ldh [hFFC8], a
    ldh [hFFC9], a
    ldh [hFFCA], a

Jump_039_6CFE::
    push bc
    ld a, [wBattleActor]
    cp a, c
    jr z, Jump_039_6D4E
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_6D4E
    call GetBattleMP_Bank39
    push hl
    ld a, c
    call GetBattleMaxMP_Bank39
    pop bc
    call DivideHLByBC
    ldh a, [hFFC7]
    sub a, l
    ld e, a
    ldh a, [hFFC8]
    sbc a, h
    ld d, a
    jr c, Jump_039_6D3D
    ld a, d
    or a, e
    jr nz, Jump_039_6D4E
    ldh a, [hFFC9]
    sub a, c
    ld e, a
    ldh a, [hFFCA]
    sbc a, b
    ld d, a
    jr c, Jump_039_6D3D
    ld a, d
    or a, e
    jr nz, Jump_039_6D4E
    call AdvanceRandom
    ld a, [wC5E7]
    bit 7, a
    jr z, Jump_039_6D4E

Jump_039_6D3D::
    ld a, l
    ldh [hFFC7], a
    ld a, h
    ldh [hFFC8], a
    ld a, c
    ldh [hFFC9], a
    ld a, b
    ldh [hFFCA], a
    pop bc
    ld a, c
    ldh [hFFC6], a
    push bc

Jump_039_6D4E::
    pop bc
    inc c
    dec b
    jr nz, Jump_039_6CFE
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ldh a, [hFFC6]
    cp a, $FF
    jr nz, Jump_039_6D68
    ld a, [wBattleActor]

Jump_039_6D68::
    ld [hl], a
    ret

; A = slot: A = its status byte 4 (wD810) & $0C; Z set when both bits are clear (E-0116)
; 3 call sites from 3 routines (e.g. ChooseTarget_SquallHit_543C, ChooseTarget_GigaSlash, ChooseTarget_SquallHit)
; points at: wD810
SlotStatus4Bits23::
Func_039_6D6A:: ; address name
    ld hl, wD810
    call AddAx9ToHL
    ld a, [hl]
    and a, $0C
    ret

; wD87F = 0, hFFC7 = 0, stores HP + DEF of three slots from the target in wD874 and falls into PickWeakestEstimatedTarget (E-0126)
; 3 call sites from 3 routines (e.g. ChooseTarget_SquallHit_543C, ChooseTarget_GigaSlash, ChooseTarget_SquallHit)
; reads: wBattleTarget, wD874, wD875, hFFC6, wC5E7
; writes: wD87F, hFFC7, hFFC6
; points at: wD874, wBattleTarget
EstimateAndPickWeakestTarget::
Func_039_6D74:: ; address name
    ld a, $00
    ld [wD87F], a
    xor a, a
    ldh [hFFC7], a
    ld b, $03
    ld a, [wBattleTarget]
    ld c, a

Jump_039_6D82::
    call StoreSlotHPPlusDEFToWD874
    inc c
    dec b
    jr nz, Jump_039_6D82

; picks the smallest of the three wD874 estimates (ties broken randomly) and adds its index to wBattleTarget (E-0125)
; 3 call sites from 3 routines (e.g. EstimateThreeTargets, ChooseTarget_SquallHit_543C, ChooseTarget_SquallHit)
; reads: wD874, wD875, hFFC6, wC5E7
; writes: hFFC6
; points at: wD874, wBattleTarget
PickWeakestEstimatedTarget::
Func_039_6D89:: ; address name
    xor a, a
    ldh [hFFC6], a
    ld a, [wD874]
    ld c, a
    ld a, [wD875]
    ld b, a
    ld de, $0201

Jump_039_6D97::
    ld a, e
    ld hl, wD874
    add a, a
    add_a_to_hl
    deref_hl
    call CompareHLToBC
    jr z, Jump_039_6DB2
    jr nc, Jump_039_6DBC

Jump_039_6DAB::
    ld b, h
    ld c, l
    ld a, e
    ldh [hFFC6], a
    jr Jump_039_6DBC

Jump_039_6DB2::
    call AdvanceRandom
    ld a, [wC5E7]
    bit 1, a
    jr z, Jump_039_6DAB

Jump_039_6DBC::
    inc e
    dec d
    jr nz, Jump_039_6D97
    ld hl, wBattleTarget
    ldh a, [hFFC6]
    add a, [hl]
    ld [hl], a
    ret

; slot C: stores HP + DEF (DEF halved when hFFC7 is set and bit 2 of its wD812 byte is set) in wD874[C & 3], or $FFFF when empty (E-0124)
; 2 call sites from 2 routines (e.g. EstimateAndPickWeakestTarget, EstimateThreeTargets)
; reads: hFFC7
; points at: wD812, wD874
StoreSlotHPPlusDEFToWD874::
Func_039_6DC8:: ; address name
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, StoreFFFFToWD874SlotC
    call GetBattleHP_Bank39
    push hl
    ld a, c
    call GetBattleDEF_Bank39
    ldh a, [hFFC7]
    or a, a
    jr z, Jump_039_6DED
    push hl
    ld a, c
    ld hl, wD812
    call AddAx9ToHL
    ld a, [hl]
    pop hl
    bit 2, a
    jr z, Jump_039_6DED
    srl h
    rr l

Jump_039_6DED::
    pop de
    add hl, de
    jr StoreHLToWD874SlotC

; HL = $FFFF, then falls into StoreHLToWD874SlotC (E-0122)
; 1 call site from 1 routine (e.g. EstimateThreeTargets)
; points at: wD874
StoreFFFFToWD874SlotC::
Func_039_6DF1:: ; address name
    ld hl, $FFFF

; stores HL in the word wD874[C & 3] (E-0122)
; 2 call sites from 2 routines (e.g. ChooseTarget_SquallHit_543C, ChooseTarget_SquallHit)
; points at: wD874
StoreHLToWD874SlotC::
Func_039_6DF4:: ; address name
    ld a, c
    and a, $03
    add a, a
    ld de, wD874
    add a, e
    ld e, a
    jr nc, Jump_039_6E00
    inc d

Jump_039_6E00::
    ld a, l
    ld [de], a
    inc de
    ld a, h
    ld [de], a
    ret

; A = slot: NZ when its status byte 0 & $40, byte 3 & $C0, byte 4 & $0C, byte 6 & $20 or byte 7 & $07 is set (A = that masked value), Z when none is (E-0096)
; 7 call sites from 3 routines (e.g. ChooseTarget_SquallHit_543C, ChooseTarget_GigaSlash, ChooseTarget_SquallHit)
; points at: wBattleStatus
AnySlotStatusMaskSet::
Func_039_6E06:: ; address name
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl+]
    and a, $40
    jr nz, Jump_039_6E26
    inc hl
    inc hl
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_039_6E26
    ld a, [hl+]
    and a, $0C
    jr nz, Jump_039_6E26
    inc hl
    ld a, [hl+]
    and a, $20
    jr nz, Jump_039_6E26
    ld a, [hl]
    and a, $07

Jump_039_6E26::
    ret

; fills the damage for wBattleActionId: the effect handler for 0 or ids from $48 (except $66), Func_01A_408F for low ids and $66, or the actor's ATK for $6B and $6C (E-0124)
; 2 call sites from 2 routines (e.g. ChooseTarget_SquallHit_543C, ChooseTarget_SquallHit)
; reads: wBattleActionId, wBattleActor
; writes: wBattleDamageLo, wD873
ComputeDamageEstimateForAction::
Func_039_6E27:: ; address name
    push bc
    ld a, [wBattleActionId]
    cp a, $00
    jr z, Jump_039_6E3F
    cp a, $48
    jr c, Jump_039_6E47
    cp a, $66
    jr z, Jump_039_6E47
    cp a, $6B
    jr z, Jump_039_6E4F
    cp a, $6C
    jr z, Jump_039_6E4F

Jump_039_6E3F::
    farcall RunEffectHandlerForActionId
    jr Jump_039_6E5F

Jump_039_6E47::
    farcall ComputeDamageEstimateForAction_Sub01
    jr Jump_039_6E5F

Jump_039_6E4F::
    ld a, [wBattleActor]
    call GetBattleATK_Bank39
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    jr Jump_039_6E5F

Jump_039_6E5F::
    pop bc
    ret

; if bit 0 of wD8A7[C] is set, the damage word (wBattleDamageLo, wD873) = damage * 50 (Multiply8By16); registers preserved (E-0121)
; 2 call sites from 2 routines (e.g. ChooseTarget_SquallHit_543C, ChooseTarget_SquallHit)
; reads: wBattleDamageLo, wD873
; writes: wBattleDamageLo, wD873
; points at: wD8A7
MultiplyDamageBy50IfWD8A7Bit0::
Func_039_6E61:: ; address name
    ld a, c
    ld hl, wD8A7
    add_a_to_hl
    bit 0, [hl]
    ret z
    push af
    push bc
    push de
    push hl
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wD873]
    ld b, a
    ld a, $32
    call Multiply8By16
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    pop hl
    pop de
    pop bc
    pop af
    ret

; hFFC7 = 1; for three slots from the target stores HP + DEF in wD874, or $FFFF for slots with wD80F status bits $C0 or $0C; then Func_039_6D89 (E-0124)
; 4 call sites from 3 routines (e.g. ChooseTarget_SquallHit_543C, ChooseTarget_GigaSlash, ChooseTarget_SquallHit)
; reads: wBattleTarget
; writes: hFFC7
; points at: wD80F
EstimateThreeTargets::
Func_039_6E8B:: ; address name
    ld a, $01
    ldh [hFFC7], a
    ld b, $03
    ld a, [wBattleTarget]
    ld c, a

Jump_039_6E95::
    ld a, c
    ld hl, wD80F
    call AddAx9ToHL
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_039_6EAB
    ld a, [hl]
    and a, $0C
    jr nz, Jump_039_6EAB
    call StoreSlotHPPlusDEFToWD874
    jr Jump_039_6EAE

Jump_039_6EAB::
    call StoreFFFFToWD874SlotC

Jump_039_6EAE::
    inc c
    dec b
    jr nz, Jump_039_6E95
    call PickWeakestEstimatedTarget
    ret

; only called from ChooseTarget_Heal (E-0047)
; 1 call site from 1 routine (e.g. ChooseTarget_Heal)
; reads: hFFC7, hFFC6, hFFC8, wBattleActor, wBattleTarget
; writes: hFFC6, hFFC7, hFFC8, wBattleTarget
; points at: wD874, wD87D, hFFC7, wBattleTargetChoice
ChooseTarget_Heal_Sub01::
Func_039_6EB6:: ; address name
    ld a, $00
    ldh [hFFC6], a
    ld a, $01
    ldh [hFFC7], a
    ld a, $02
    ldh [hFFC8], a

Jump_039_6EC2::
    ldh a, [hFFC7]
    ld hl, wD874
    add a, a
    add_a_to_hl
    ld c, [hl]
    inc hl
    ld b, [hl]
    ldh a, [hFFC6]
    ld hl, wD874
    add a, a
    add_a_to_hl
    deref_hl
    call CompareHLToBC
    jr c, Jump_039_6F06
    jr nz, Jump_039_6F0A
    ldh a, [hFFC7]
    ld hl, wD87D
    add a, a
    add_a_to_hl
    ld c, [hl]
    inc hl
    ld b, [hl]
    ldh a, [hFFC6]
    ld hl, wD87D
    add a, a
    add_a_to_hl
    deref_hl
    call CompareHLToBC
    jr nc, Jump_039_6F0A

Jump_039_6F06::
    ldh a, [hFFC7]
    ldh [hFFC6], a

Jump_039_6F0A::
    ld hl, hFFC7
    inc [hl]
    ldh a, [hFFC8]
    dec a
    ldh [hFFC8], a
    jr nz, Jump_039_6EC2
    ldh a, [hFFC6]
    ld c, a
    ld a, [wBattleActor]
    and a, $04
    or a, c
    ld [wBattleTarget], a
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld a, [wBattleTarget]
    ld [hl], a
    ret

; HL = 999 when the base DEF doubled (quadrupled for allies or link battles) reaches 999, otherwise the base DEF times that factor (E-0124)
; 2 call sites from 2 routines (e.g. ChooseTarget_Upper, ChooseTarget_Upper_6B0A)
; reads: wBattleStatResultLo, wBattleStatResultHi, wC58A, wBattleActor
BuffCapOfBaseDEF::
Func_039_6F32:: ; address name
    farcall GetBaseDEF
    ld a, [wBattleStatResultLo]
    ld l, a
    ld a, [wBattleStatResultHi]
    ld h, a
    ld bc, $03E7
    call CompareHLToBC
    jr nc, Jump_039_6F65
    add hl, hl
    call CompareHLToBC
    jr nc, Jump_039_6F62
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_039_6F5C
    ld a, [wBattleActor]
    and a, $04
    jr nz, Jump_039_6F65

Jump_039_6F5C::
    add hl, hl
    call CompareHLToBC
    jr c, Jump_039_6F65

Jump_039_6F62::
    ld hl, $03E7

Jump_039_6F65::
    ret

; HL = 999 when the base AGL doubled (quadrupled for allies or link battles) reaches 999, otherwise the base AGL times that factor (E-0124)
; 2 call sites from 2 routines (e.g. ChooseTarget_Speed_6B5D, ChooseTarget_Speed)
; reads: wBattleStatResultLo, wBattleStatResultHi, wC58A, wBattleActor
BuffCapOfBaseAGL:: ; heuristic: follows a terminator; C0
Func_039_6F66:: ; address name
    farcall GetBaseAGL
    ld a, [wBattleStatResultLo]
    ld l, a
    ld a, [wBattleStatResultHi]
    ld h, a
    ld bc, $03E7
    call CompareHLToBC
    jr nc, Jump_039_6F99
    add hl, hl
    call CompareHLToBC
    jr nc, Jump_039_6F96
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_039_6F90
    ld a, [wBattleActor]
    and a, $04
    jr nz, Jump_039_6F99

Jump_039_6F90::
    add hl, hl
    call CompareHLToBC
    jr c, Jump_039_6F99

Jump_039_6F96::
    ld hl, $03E7

Jump_039_6F99::
    ret

; only called from ChooseTarget_MouthShut (E-0047)
; 1 call site from 1 routine (e.g. ChooseTarget_MouthShut)
; points at: wD989
ChooseTarget_MouthShut_Sub01::
Func_039_6F9A:: ; address name
    push bc
    ld hl, wD989
    swap a
    add_a_to_hl
    ld bc, $0800

Jump_039_6FA8::
    ld a, [hl+]
    cp a, $40
    jr c, Jump_039_6FC0
    cp a, $48
    jr c, Jump_039_6FBF
    cp a, $70
    jr c, Jump_039_6FC0
    cp a, $76
    jr c, Jump_039_6FBF
    cp a, $89
    jr z, Jump_039_6FBF
    jr Jump_039_6FC0

Jump_039_6FBF::
    inc c

Jump_039_6FC0::
    inc hl
    dec b
    jr nz, Jump_039_6FA8
    ld a, c
    or a, a
    pop bc
    ret

; wBattleTargetChoice[2 * actor] = (hFFC6, or hFFC9 when hFFC6 is $FF) | hFFD0 (the two-choice form of SetActorTargetFromHRAMChoice) (E-0078)
; 5 call sites from 5 routines (e.g. TargetRandomFoeOfFamilyD, ChooseTarget_Ramming, ChooseTarget_MetalCut, TargetWeakestFoeOfFamilyD, ...)
; reads: wBattleActor, hFFC6, hFFC9, hFFD0
; points at: wBattleTargetChoice
SetActorTargetFromHFFC6OrHFFC9::
Func_039_6FC8:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ldh a, [hFFC6]
    cp a, $FF
    jr nz, Jump_039_6FDC
    ldh a, [hFFC9]

Jump_039_6FDC::
    ld e, a
    ldh a, [hFFD0]
    or a, e
    ld [hl], a
    ret

; HL = wBattleTargetChoice + 2 * wBattleActor; A = hFFC6, or hFFC9 when hFFC6 is $FF, or hFFC8 when both are $FF; stores A | hFFD0 at HL. What the bytes mean is not known (E-0060)
; 18 call sites from 18 routines (e.g. ChooseTarget_GigaSlash_6A25, ChooseTarget_LushLicks, ChooseTarget_GigaSlash, ChooseTarget_NapAttack, ...)
; reads: wBattleActor, hFFC6, hFFC9, hFFC8, hFFD0
; points at: wBattleTargetChoice
SetActorTargetFromHRAMChoice::
Func_039_6FE2:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ldh a, [hFFC6]
    cp a, $FF
    jr nz, Jump_039_6FFC
    ldh a, [hFFC9]
    cp a, $FF
    jr nz, Jump_039_6FFC
    ldh a, [hFFC8]

Jump_039_6FFC::
    ld e, a
    ldh a, [hFFD0]
    or a, e
    ld [hl], a
    ret

; wBattleTargetChoice[2 * actor] = (the first of hFFC6, hFFCA, hFFC9 that is not $FF, else hFFC8) | hFFD0 (the four-choice form of SetActorTargetFromHRAMChoice) (E-0096)
; 5 call sites from 5 routines (e.g. ChooseTarget_PanicAll, ChooseTarget_MouthShut, ChooseTarget_LegSweep, ChooseTarget_SickLick, ...)
; reads: wBattleActor, hFFC6, hFFCA, hFFC9, hFFC8, hFFD0
; points at: wBattleTargetChoice
SetActorTargetFromHRAMChoice4::
Func_039_7002:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ldh a, [hFFC6]
    cp a, $FF
    jr nz, Jump_039_7022
    ldh a, [hFFCA]
    cp a, $FF
    jr nz, Jump_039_7022
    ldh a, [hFFC9]
    cp a, $FF
    jr nz, Jump_039_7022
    ldh a, [hFFC8]

Jump_039_7022::
    ld e, a
    ldh a, [hFFD0]
    or a, e
    ld [hl], a
    ret

; only called from ChooseTarget_Cover (E-0047)
; 1 call site from 1 routine (e.g. ChooseTarget_Cover)
; reads: wBattleActor, hFFC6, hFFCB, hFFCA, hFFC9, hFFD0
; points at: wBattleTargetChoice
ChooseTarget_Cover_Sub01::
Func_039_7028:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ldh a, [hFFC6]
    cp a, $FF
    jr nz, Jump_039_7048
    ldh a, [hFFCB]
    cp a, $FF
    jr nz, Jump_039_7048
    ldh a, [hFFCA]
    cp a, $FF
    jr nz, Jump_039_7048
    ldh a, [hFFC9]

Jump_039_7048::
    ld e, a
    ldh a, [hFFD0]
    or a, e
    ld [hl], a
    ret

; hFFC6 = candidate count, hFFC7-hFFC9 = candidates in priority order: target = the first for one; with two the first when wC5E7 < $AB (171/256), else the second; with three the first when wC5E7 < $80, the second when < $D5, else the third (128, 85 and 43 of 256). Writes wBattleTargetChoice[2 * actor]; with no candidates it stores hFFC7 ($FF) (E-0061)
; 3 call sites from 3 routines (e.g. ChooseTarget_SquallHit_66C5, ChooseTarget_Sap_6BB0, TargetFoeWeightedBySlotOrder)
; reads: hFFC6, hFFC7, wBattleActor, wC5E7, hFFC8
; points at: wBattleTargetChoice, hFFC7
PickWeightedTargetCandidate::
Func_039_704E:: ; address name
    ldh a, [hFFC6]
    cp a, $03
    jr z, Jump_039_7069
    cp a, $02
    jr z, Jump_039_705C
    ldh a, [hFFC7]
    jr Jump_039_7084

Jump_039_705C::
    ld a, [wC5E7]
    cp a, $AB
    ldh a, [hFFC7]
    jr c, Jump_039_7084
    ldh a, [hFFC8]
    jr Jump_039_7084

Jump_039_7069::
    ld a, [wC5E7]
    cp a, $80
    ld b, $00
    jr c, Jump_039_707A
    cp a, $D5
    ld b, $01
    jr c, Jump_039_707A
    ld b, $02

Jump_039_707A::
    ld a, b
    ld hl, hFFC7
    add_a_to_hl
    ld a, [hl]

Jump_039_7084::
    ld b, a
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld [hl], b
    ret

; D = family: among the actor's present opposite slots whose species family (LoadSpeciesFamily) is D, targets the one with the smallest HP + DEF; when none matches, the last present foe (hFFC9) is used (SetActorTargetFromHFFC6OrHFFC9). Used by the family-slaying moves' target routines (E-0096)
; 9 call sites from 9 routines (e.g. ChooseTarget_CleanCut, ChooseTarget_ZombieCut, ChooseTarget_DevilCut, ChooseTarget_Shears, ...)
; reads: wBattleActor, wSpeciesRecord, hFFC7, hFFC8, hFFC9
; writes: hFFD0, hFFC6, hFFC7, hFFC8, hFFC9, wSpeciesIdLo, wSpeciesIdHi
; points at: wBattleMonsterId
TargetWeakestFoeOfFamilyD::
Func_039_7093:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hFFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [hFFC6], a
    ldh [hFFC7], a
    ldh [hFFC8], a
    ldh [hFFC9], a

Jump_039_70A9::
    ld a, c
    push bc
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_70F4
    ldh [hFFC9], a
    ld hl, wBattleMonsterId
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    push de
    push bc
    farcall LoadSpeciesFamily
    pop bc
    pop de
    ld a, [wSpeciesRecord]
    cp a, d
    jr nz, Jump_039_70F4
    ld a, c
    call GetBattleHP_Bank39
    push hl
    ld a, c
    call GetBattleDEF_Bank39
    pop bc
    add hl, bc
    ldh a, [hFFC7]
    ld c, a
    ldh a, [hFFC8]
    ld b, a
    call CompareHLToBC
    jr nc, Jump_039_70F4
    ld a, l
    ldh [hFFC7], a
    ld a, h
    ldh [hFFC8], a
    ldh a, [hFFC9]
    ldh [hFFC6], a

Jump_039_70F4::
    pop bc
    inc c
    dec b
    jr nz, Jump_039_70A9
    call SetActorTargetFromHFFC6OrHFFC9
    ret

; D = family: picks among the actor's present opposite slots whose species family is D, using AdvanceRandom when more than one matches (the choice rule is not read to the end); falls back to the last present foe; used by ChooseTarget routines of family-slaying moves (CleanCut, ZombieCut, DevilCut, Shears, ...) (E-0096)
; 9 call sites from 9 routines (e.g. ChooseTarget_CleanCut_69E3, ChooseTarget_ZombieCut_69DD, ChooseTarget_DevilCut_69D7, ChooseTarget_Shears_69F5, ...)
; reads: wBattleActor, wSpeciesRecord, hFFC6, wC5E7, hFFC9
; writes: hFFD0, hFFC6, hFFC9, wSpeciesIdLo, wSpeciesIdHi
; points at: wBattleMonsterId
TargetRandomFoeOfFamilyD::
Func_039_70FD:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ldh [hFFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [hFFC6], a
    ldh [hFFC9], a

Jump_039_710F::
    ld a, c
    push bc
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_039_714C
    ldh [hFFC9], a
    ld hl, wBattleMonsterId
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    push de
    farcall LoadSpeciesFamily
    pop de
    ld a, [wSpeciesRecord]
    cp a, d
    jr nz, Jump_039_714C
    ldh a, [hFFC6]
    cp a, $FF
    jr z, Jump_039_7148
    call AdvanceRandom
    ld a, [wC5E7]
    and a, $01
    jr z, Jump_039_714C

Jump_039_7148::
    ldh a, [hFFC9]
    ldh [hFFC6], a

Jump_039_714C::
    pop bc
    inc c
    dec b
    jr nz, Jump_039_710F
    call SetActorTargetFromHFFC6OrHFFC9
    ret

; only called from ChooseTarget_Blaze (E-0047)
; 1 call site from 1 routine (e.g. ChooseTarget_Blaze)
; reads: hFFCE, hFFCF
ChooseTarget_Blaze_Sub01::
Func_039_7155:: ; address name
    push af
    ldh a, [hFFCE]
    ld l, a
    ldh a, [hFFCF]
    ld h, a
    pop af
    or a, a
    jr z, Jump_039_716D
    cp a, $01
    jr z, Jump_039_716F
    cp a, $02
    jr z, Jump_039_717B
    ld hl, $0000
    jr Jump_039_717F

Jump_039_716D::
    jr Jump_039_717F

Jump_039_716F::
    ld a, $55
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    jr Jump_039_717F

Jump_039_717B::
    sra h
    rr l

Jump_039_717F::
    ret

; only called from ChooseTarget_MegaMagic (E-0047)
; 1 call site from 1 routine (e.g. ChooseTarget_MegaMagic)
; reads: wBattleActor
; points at: wD8B7
ChooseTarget_MegaMagic_Sub01::
Func_039_7180:: ; address name
    push af
    ld a, [wBattleActor]
    call GetBattleMP_Bank39
    push hl
    ld a, [wBattleActor]
    ld hl, wD8B7
    add_a_to_hl
    ld a, [hl]
    pop hl
    add a, a
    add_a_to_hl
    ld a, $5A
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    pop af
    or a, a
    jr z, Jump_039_71B6
    cp a, $01
    jr z, Jump_039_71B8
    cp a, $02
    jr z, Jump_039_71C4
    ld hl, $0000
    jr Jump_039_71C8

Jump_039_71B6::
    jr Jump_039_71C8

Jump_039_71B8::
    ld a, $55
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    jr Jump_039_71C8

Jump_039_71C4::
    sra h
    rr l

Jump_039_71C8::
    ret

; A = [HL + 4 * A + 3 * C], the offset computed in 8 bits; clobbers HL (the same 11 bytes appear in 2 banks)
; 29 call sites from 27 routines (e.g. ChooseTarget_PanicAll, ChooseTarget_GigaSlash_6A25, ChooseTarget_MouthShut, ChooseTarget_LegSweep, ...)
ReadByteAtHLPlus4APlus3C_Bank39::
Func_039_71C9:: ; address name
    add a, a
    add a, c
    add a, a
    add a, c
    add_a_to_hl
    ld a, [hl]
    ret

; C = slot: NZ when its status byte 2 bit 3 is set; otherwise A = status byte 5 & $C0 (Z when clear) (E-0118)
; 5 call sites from 2 routines (e.g. ChooseTarget_SquallHit_543C, ChooseTarget_GigaSlash)
; points at: wD80E
TestSlotStatus2Bit3OrStatus5Bits67::
Func_039_71D4:: ; address name
    ld a, c
    ld hl, wD80E
    call AddAx9ToHL
    bit 3, [hl]
    ret nz
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    and a, $C0
    ret

; A = battle slot: HL = the word for that slot at wBattleATK; A = its low byte (the bank-$39 copy of GetBattleATK) (E-0060)
; 2 call sites from 2 routines (e.g. ComputeDamageEstimateForAction, ChooseTarget_TwinHits)
; points at: wBattleATK
GetBattleATK_Bank39::
Func_039_71E5:: ; address name
    ld hl, wBattleATK
    jr Jump_039_7212

; A = battle slot: HL = the word for that slot at wBattleDEF; A = its low byte (E-0060)
; 18 call sites from 18 routines (e.g. ChooseTarget_GigaSlash_6A25, ChooseTarget_SquallHit_66C5, StoreSlotHPPlusDEFToWD874, ChooseTarget_SickLick, ...)
; points at: wBattleDEF
GetBattleDEF_Bank39::
Func_039_71EA:: ; address name
    ld hl, wBattleDEF
    jr Jump_039_7212

; A = battle slot: HL = the word for that slot at wBattleMaxHP; A = its low byte (E-0060)
; 7 call sites from 7 routines (e.g. ChooseTarget_Heal_68B0, ChooseTarget_Heal_5593, ChooseTarget_Heal, ChooseTarget_Heal_67AD, ...)
; points at: wBattleMaxHP
GetBattleMaxHP_Bank39::
Func_039_71EF:: ; address name
    ld hl, wBattleMaxHP
    jr Jump_039_7212

; A = battle slot: HL = the word for that slot at wBattleMaxMP; A = its low byte (E-0060)
; 2 call sites from 2 routines (e.g. ChooseTarget_Transform, ChooseTarget_MPass)
; points at: wBattleMaxMP
GetBattleMaxMP_Bank39::
Func_039_71F4:: ; address name
    ld hl, wBattleMaxMP
    jr Jump_039_7212

; A = battle slot: HL = the word for that slot at wBattleHP; A = its low byte (E-0060)
; 28 call sites from 24 routines (e.g. ChooseTarget_GigaSlash_6A25, ChooseTarget_Heal_68B0, ChooseTarget_SquallHit_66C5, ChooseTarget_Heal_5593, ...)
; points at: wBattleHP
GetBattleHP_Bank39::
Func_039_71F9:: ; address name
    ld hl, wBattleHP
    jr Jump_039_7212

; A = battle slot: HL = the word for that slot at wBattleMP; A = its low byte (E-0060)
; 4 call sites from 4 routines (e.g. ChooseTarget_MegaMagic_Sub01, ChooseTarget_MPass, ChooseTarget_OddDance, ChooseTarget_RobMagic)
; points at: wBattleMP
GetBattleMP_Bank39::
Func_039_71FE:: ; address name
    ld hl, wBattleMP
    jr Jump_039_7212

; A = battle slot: HL = the word for that slot at wBattleAGL; A = its low byte (E-0060)
; 4 call sites from 4 routines (e.g. ChooseTarget_Speed_6B5D, ChooseTarget_Slow, ChooseTarget_Speed, ChooseTarget_UltraDown)
; points at: wBattleAGL
GetBattleAGL_Bank39::
Func_039_7203:: ; address name
    ld hl, wBattleAGL
    jr Jump_039_7212

; A = the byte at wDA53 + A; clobbers HL (the same 10 bytes appear in 4 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wDA53
ReadWDA53Indexed_Bank39:: ; heuristic: follows a terminator; C0
Func_039_7208:: ; address name
    ld hl, wDA53
    add_a_to_hl
    ld a, [hl]
    ret

Jump_039_7212::
    add a, a
    add_a_to_hl
    deref_hl
    ret

; HL += 2 * A (A is doubled in 8 bits first, so it wraps above $7F); clobbers A (the same 7 bytes appear in 10 banks)
; no direct call (reached through a table, a jump or a vector)
AddDoubleAToHL_Bank39:: ; heuristic: follows a terminator; C0
Func_039_721C:: ; address name
    add a, a
    add_a_to_hl
    ret

; carry set when wBattleActor < 4 (slots 0-3); when wC58A = 1 and wC57F bit 1 is set the test is reversed (carry set when wBattleActor >= 4). Which side is local is inferred from the reversal, not checked (E-0064) (the same 27 bytes appear in 10 banks)
; no direct call (reached through a table, a jump or a vector)
; reads: wC58A, wC57F, wBattleActor
ActorOnLocalSide_Bank39:: ; heuristic: follows a terminator; C0
Func_039_7223:: ; address name
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_039_7238
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_039_7238
    ld a, [wBattleActor]
    cp a, $04
    ccf
    ret

Jump_039_7238::
    ld a, [wBattleActor]
    cp a, $04
    ret

; carry set when wBattleTarget < 4 (slots 0-3); when wC58A = 1 and wC57F bit 1 is set the test is reversed (carry set when wBattleTarget >= 4) (E-0064) (the same 27 bytes appear in 10 banks)
; no direct call (reached through a table, a jump or a vector)
; reads: wC58A, wC57F, wBattleTarget
TargetOnLocalSide_Bank39:: ; heuristic: follows a terminator; C0
Func_039_723E:: ; address name
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_039_7253
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_039_7253
    ld a, [wBattleTarget]
    cp a, $04
    ccf
    ret

Jump_039_7253::
    ld a, [wBattleTarget]
    cp a, $04
    ret
    INCBIN "dwm2-cobi-us.gbc", $0E7259, $CA
    ds $CDD, $00
