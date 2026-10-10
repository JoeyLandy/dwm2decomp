SECTION "Bank 3A", ROMX[$4000], BANK[$3A]
    db $3A

; reads the effect flags in wDAD2. First, when the low two bits of wBattleTarget are 3 and wBattleActionId is $85-$88, it returns unless wDAD2 bit 0 or bit 6 is set. Then it tests bits 7, 6, 5, 4, 3, 2 in that order and selects one of six tables (Data_03A_40CC, Data_03A_4294, Data_03A_445C, Data_03A_47EC, Data_03A_486C; bit 4 has its own branch) indexed by wBattleActionId. An entry of $FF returns; other entries go on to Jump_03A_48EC or the effect code, which is not read (E-0057)
; 15 call sites from 13 routines (e.g. Func_032_4ADC_Case05, Func_032_5820_Case03, ResolveStep0EEffect_Case00, ResolveStep0EEffect_Case03_Case00, ...)
; reads: wBattleTarget, wBattleActionId, wDAD2, wDABF, wCFF2, wBattleActor, wD868, wD801
; writes: wBattleActor, wD803, wD802, wDAF1, wC952, wD868, wD801, wDAB5, ...
; points at: wD804, wD805, wDAB3, wDAD2
SelectEffectByWDAD2Flags::
Func_03A_4001:: ; address name
    ld a, [wBattleTarget]
    and a, $03
    cp a, $03
    jr nz, Jump_03A_4019
    ld a, [wBattleActionId]
    cp a, $85
    ret c
    cp a, $89
    ret nc
    ld a, [wDAD2]
    and a, $41
    ret z

Jump_03A_4019::
    ld a, [wDAD2]
    or a, a
    ret z
    bit 7, a
    jr nz, Jump_03A_406E
    bit 6, a
    jr nz, Jump_03A_4073
    bit 5, a
    jr nz, Jump_03A_407B
    bit 4, a
    jr nz, Jump_03A_404D
    bit 3, a
    jr nz, Jump_03A_4042
    bit 2, a
    jr nz, Jump_03A_4037
    ret

Jump_03A_4037::
    ld a, [wBattleTarget]
    ld [wBattleActor], a
    ld hl, Data_03A_47EC
    jr Jump_03A_407E

Jump_03A_4042::
    ld a, [wBattleTarget]
    ld [wBattleActor], a
    ld hl, Data_03A_486C
    jr Jump_03A_407E

Jump_03A_404D::
    bit 0, a
    ret z
    srl a
    and a, $07
    cp a, $00
    jr z, Jump_03A_4062
    cp a, $01
    jr z, Jump_03A_405D
    ret

Jump_03A_405D::
    ld a, $14
    jp Jump_03A_48EC

Jump_03A_4062::
    call TargetOnLocalSide_Bank3A
    ld a, $02
    jp c, Jump_03A_40B3
    ld a, $03
    jr Jump_03A_40B3

Jump_03A_406E::
    ld hl, Data_03A_40CC
    jr Jump_03A_407E

Jump_03A_4073::
    bit 0, a
    ret z
    ld hl, Data_03A_4294
    jr Jump_03A_407E

Jump_03A_407B::
    ld hl, Data_03A_445C

Jump_03A_407E::
    ld a, [wBattleActionId]
    push af
    ld c, a
    ld b, $00
    add hl, bc
    add hl, bc
    pop af
    cp a, $6C
    jr z, Jump_03A_40A2
    ld a, [wDABF]
    bit 0, a
    jr nz, Jump_03A_40A2
    ld a, [wCFF2]
    cp a, $80
    jr z, Jump_03A_40A2
    call ActorOnLocalSide_Bank3A
    jr nc, Jump_03A_40AA
    inc hl
    jr Jump_03A_40AA

Jump_03A_40A2::
    call TargetOnLocalSide_Bank3A
    jr c, Jump_03A_40AA
    inc hl
    jr Jump_03A_40AA

Jump_03A_40AA::
    ld a, [hl]
    cp a, $FF
    ret z
    bit 7, a
    jp z, Jump_03A_48EC

Jump_03A_40B3::
    and a, $7F
    ld [wD803], a
    ld a, $00
    ld [wD802], a
    xor a, a
    ld hl, wD804
    ld bc, $0004
    call FillBytes
    xor a, a
    ld [wDAF1], a
    ret

Data_03A_40CC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $FF, $FF, $00, $FF, $01, $FF, $02, $FF, $03, $FF, $04, $FF, $05, $FF, $06
    db $FF, $07, $FF, $08, $FF, $09, $FF, $0A, $FF, $0B, $FF, $0F, $FF, $10, $FF, $11
    db $FF, $0C, $FF, $0D, $FF, $0E
    ds $52, $FF
    INCBIN "dwm2-cobi-us.gbc", $0E8144, $64
    ds $22, $FF
    db $84, $84, $84, $84, $84, $84, $85, $85, $2B, $2B, $85, $85
    ds $19, $FF
    db $30
    ds $12, $FF
    db $31, $FF, $84, $84
    ds $2C, $FF
    db $85, $85
    ds $33, $FF
    db $30, $FF, $FF, $FF, $FF, $FF, $33, $FF, $34, $FF, $35, $FF, $36, $FF, $37, $FF
    db $38, $FF, $FF, $FF, $30, $FF, $1D, $FF, $2A, $FF, $FF, $85, $85, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $3B, $FF

Data_03A_4294:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0E8294, $124
    ds $1A, $FF
    db $14, $FF, $FF, $FF, $32, $32
    ds $10, $FF
    INCBIN "dwm2-cobi-us.gbc", $0E83E8, $74

Data_03A_445C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $BF, $FF
    db $15, $FF, $15, $FF, $15
    ds $16, $FF
    db $8D, $83, $FF, $FF, $8D, $83, $8D, $83
    ds $2AE, $FF

Data_03A_47EC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $FF, $14, $FF, $14, $FF, $14, $FF, $14, $FF, $14, $FF, $14, $FF, $14, $FF
    db $14, $FF, $14, $FF, $14, $FF, $14
    ds $2D, $FF
    db $12, $FF, $FF, $FF, $82, $FF, $82, $FF, $82, $FF, $82
    ds $31, $FF

Data_03A_486C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $32, $FF
    db $2C, $FF, $2C, $FF, $2C, $FF, $2C, $FF, $15, $FF, $32, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $09, $FF, $0F, $FF, $0E, $FF, $02
    ds $31, $FF

Jump_03A_48EC::
    push af
    xor a, a
    ld [wC952], a
    ld a, [wBattleActionId]
    cp a, $D7
    jr z, Jump_03A_48FA
    jr Jump_03A_48FF

Jump_03A_48FA::
    ld a, $01
    ld [wC952], a

Jump_03A_48FF::
    pop af
    ld b, a
    call SelectEffectByWDAD2Flags_Sub03
    call SelectEffectByWDAD2Flags_Sub01
    ld a, b
    jr nc, Jump_03A_492E
    cp a, $2B
    jr z, Jump_03A_492E
    cp a, $32
    jr z, Jump_03A_492E
    cp a, $13
    jr z, Jump_03A_4917
    ret

Jump_03A_4917::
    ld a, [wBattleActionId]
    cp a, $32
    jr z, Jump_03A_4921
    cp a, $77
    ret nz

Jump_03A_4921::
    ld a, [wDAD2]
    cp a, $41
    ret nz
    ld a, [wBattleActor]
    ld [wD868], a
    ld a, b

Jump_03A_492E::
    ld [wD801], a
    ld [wDAB5], a
    ld b, a
    call SelectEffectByWDAD2Flags_Sub02
    jr z, Jump_03A_4962
    ld a, b
    cp a, $09
    jr nz, Jump_03A_494A
    ld a, [wBattleActionId]
    cp a, $48
    ld a, b
    jr nz, Jump_03A_494A
    xor a, a
    jr Jump_03A_4962

Jump_03A_494A::
    cp a, $0D
    jr nz, Jump_03A_4959
    ld hl, wDAD2
    bit 1, [hl]
    jr z, Jump_03A_4959
    ld a, $00
    jr Jump_03A_4962

Jump_03A_4959::
    ld hl, Data_03A_49AF
    add_a_to_hl
    ld a, [hl]

Jump_03A_4962::
    ld [wDAB9], a
    cp a, $00
    jr nz, Jump_03A_4970
    ld a, [wD868]
    call CarryUnlessWDA63SlotEmpty
    ret c

Jump_03A_4970::
    xor a, a
    ld [wD804], a
    ld a, $FF
    ld hl, wD805
    ld bc, $0003
    call FillBytes
    ld a, $01
    ld [wD802], a
    ld a, $01
    ld [wD800], a
    ld a, $01
    ld [wDAAA], a
    ld a, $00
    ld [wDAB3], a
    ld hl, wDAB3
    ld a, l
    ld [wCB75], a
    ld a, h
    ld [wCB76], a
    farcall TickWCB75Sequence
    call Func_03A_4A3A
    ld a, [wD801]
    ld c, a
    call LoadEffectOBJPaletteC
    ret

Data_03A_49AF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $01, $01, $01, $02, $02, $01, $02, $01, $01, $01, $02, $01, $02
    db $02, $01, $00, $00, $00, $00, $00, $00, $00, $00, $01, $02, $01, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $01, $02, $01, $01, $01, $00, $00, $01, $00
    db $00, $00, $01, $01, $00, $00, $00, $00, $01, $01, $01, $01

; only called from SelectEffectByWDAD2Flags (E-0047)
; 1 call site from 1 routine (e.g. SelectEffectByWDAD2Flags)
; reads: wC58A, wC57F, wD868
SelectEffectByWDAD2Flags_Sub01::
Func_03A_49EB:: ; address name
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_03A_4A00
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_03A_4A00
    ld a, [wD868]
    cp a, $04
    ccf
    ret

Jump_03A_4A00::
    ld a, [wD868]
    cp a, $04
    ret

; only called from SelectEffectByWDAD2Flags (E-0047)
; 1 call site from 1 routine (e.g. SelectEffectByWDAD2Flags)
; reads: wDAD2, wBattleActionId
SelectEffectByWDAD2Flags_Sub02::
Func_03A_4A06:: ; address name
    ld a, [wDAD2]
    bit 3, a
    ret nz
    ld a, b
    cp a, $1D
    ret nz
    ld a, [wBattleActionId]
    cp a, $65
    ret nz
    ld a, $02
    ret

; only called from SelectEffectByWDAD2Flags (E-0047)
; 1 call site from 1 routine (e.g. SelectEffectByWDAD2Flags)
; reads: wDAD2, wBattleActionId, wBattleTarget, wBattleActor
; writes: wD868
SelectEffectByWDAD2Flags_Sub03::
Func_03A_4A19:: ; address name
    ld a, [wDAD2]
    bit 3, a
    jr nz, Jump_03A_4A33
    ld a, [wBattleActionId]
    cp a, $3A
    jr z, Jump_03A_4A2C
    ld a, [wBattleTarget]
    jr Jump_03A_4A2F

Jump_03A_4A2C::
    ld a, [wBattleActor]

Jump_03A_4A2F::
    ld [wD868], a
    ret

Jump_03A_4A33::
    ld a, [wBattleTarget]
    ld [wD868], a
    ret

; 9 call sites from 5 routines (e.g. SelectEffectByWDAD2Flags, Func_03A_4ADB, DrawHexByteAtBGMap8A_Sub01, DrawEffectSpriteForWD801Range_Sub01, ...)
; reads: wDAB9, wD890, wC58A, wC57F, wD868, wD805
; writes: wD804
; points at: wD805
Func_03A_4A3A::
    ld a, [wDAB9]
    cp a, $00
    jr z, Jump_03A_4A4F
    cp a, $01
    jr z, Jump_03A_4A79
    cp a, $02
    jr z, Jump_03A_4A7F
    ld a, $00
    ld [wD804], a
    ret

Jump_03A_4A4F::
    ld a, [wD890]
    ld b, a
    ld a, b
    cp a, $03
    jr z, Jump_03A_4A60
    cp a, $02
    jr z, Jump_03A_4A64
    ld b, $05
    jr Jump_03A_4A66

Jump_03A_4A60::
    ld b, $00
    jr Jump_03A_4A66

Jump_03A_4A64::
    ld b, $03

Jump_03A_4A66::
    ld a, [wD868]
    and a, $03
    add a, b
    ld hl, Data_03A_4AD5
    add_a_to_hl
    ld a, [hl]
    ld [wD804], a
    ret

Jump_03A_4A79::
    ld a, $50
    ld [wD804], a
    ret

Jump_03A_4A7F::
    ld c, $04
    ld a, [wD890]
    ld b, a
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_03A_4A95
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_03A_4A95
    ld c, $00

Jump_03A_4A95::
    ld e, $00
    ld a, b
    cp a, $03
    jr z, Jump_03A_4AA4
    cp a, $02
    jr z, Jump_03A_4AA8
    ld d, $05
    jr Jump_03A_4A66

Jump_03A_4AA4::
    ld d, $00
    jr Jump_03A_4AAA

Jump_03A_4AA8::
    ld d, $03

Jump_03A_4AAA::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_03A_4ACA
    ld a, e
    ld hl, wD805
    add_a_to_hl
    push hl
    ld a, c
    and a, $03
    add a, d
    ld hl, Data_03A_4AD5
    add_a_to_hl
    ld a, [hl]
    pop hl
    ld [hl], a
    inc e

Jump_03A_4ACA::
    inc c
    dec b
    jr nz, Jump_03A_4AAA
    ld a, [wD805]
    ld [wD804], a
    ret

Data_03A_4AD5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $20, $50, $80, $38, $68, $50

; 4 call sites from 4 routines (e.g. GameMode4_Update, RunBattleActions, RunBattleStep4, GameMode7_Update)
; reads: wD802, wD800, wD801, wDAD2, wC58A, wDAB3, wDAAA, wDAB9, ...
; writes: wD800, wDAD3, wD804, wD806, wDAAA, wDAF1, wD807, wD802, ...
; points at: wD805, wDAB3, wDAF1
Func_03A_4ADB::
    ld a, [wD802]
    cp a, $00
    jp z, Jump_03A_4C14
    ld a, [wD800]
    cp a, $01
    jr nz, Jump_03A_4B04
    ld a, [wD801]
    ld c, a
    call DecompressGraphicsAToTiles0
    ld a, $02
    ld [wD800], a
    ld a, [wDAD2]
    srl a
    and a, $44
    ld [wDAD3], a
    call SelectEffectByWDAD3Flags
    ret

Jump_03A_4B04::
    ld a, [wD800]
    cp a, $02
    jp nz, Jump_03A_4B87
    ld a, [wC58A]
    or a, a
    jr nz, Jump_03A_4B18
    farcall TickWCB75Sequence

Jump_03A_4B18::
    call AdvanceWD804By4InMode3
    ld a, [wDAB3]
    or a, a
    jr z, Jump_03A_4B2B
    ld a, [wDAAA]
    or a, a
    jr z, Jump_03A_4B2B
    call DrawEffectSpriteForWD801Range
    ret

Jump_03A_4B2B::
    ld a, [wDAB9]
    cp a, $02
    jr nz, Jump_03A_4B74
    ld a, [wD806]
    cp a, $FF
    jr z, Jump_03A_4B53
    ld a, [wD806]
    ld [wD804], a
    ld a, $FF
    ld [wD806], a
    xor a, a
    ld [wDAAA], a
    ld a, $03
    ld [wD800], a
    ld a, $08
    ld [wDAF1], a
    ret

Jump_03A_4B53::
    ld a, [wD807]
    cp a, $FF
    jr z, Jump_03A_4B74
    ld a, [wD807]
    ld [wD804], a
    ld a, $FF
    ld [wD807], a
    xor a, a
    ld [wDAAA], a
    ld a, $03
    ld [wD800], a
    ld a, $08
    ld [wDAF1], a
    ret

Jump_03A_4B74::
    ld a, [wC952]
    or a, a
    jr nz, Jump_03A_4BB5
    xor a, a
    ld [wD800], a
    ld [wDAAA], a
    ld a, $FF
    ld [wD802], a
    ret

Jump_03A_4B87::
    ld hl, wDAF1
    dec [hl]
    ld a, [hl]
    or a, a
    ret nz
    xor a, a
    ld [wDAF1], a
    ld a, $02
    ld [wD800], a
    ld a, $01
    ld [wDAAA], a
    ld a, $00
    ld [wDAB3], a
    farcall TickWCB75Sequence
    ld a, [wDAD2]
    srl a
    and a, $44
    ld [wDAD3], a
    call SelectEffectByWDAD3Flags
    ret

Jump_03A_4BB5::
    xor a, a
    ld [wC952], a
    ld a, [wBattleActionId]
    sub a, $D7
    sla a
    ld hl, Data_03A_4C12
    add_a_to_hl
    ld a, [hl+]
    ld [wD801], a
    ld [wDAB5], a
    ld a, [hl]
    ld [wDAB9], a
    xor a, a
    ld [wD804], a
    ld a, $FF
    ld hl, wD805
    ld bc, $0003
    call FillBytes
    ld a, $01
    ld [wD802], a
    ld a, $01
    ld [wD800], a
    ld a, $01
    ld [wDAAA], a
    ld a, $00
    ld [wDAB3], a
    ld hl, wDAB3
    ld a, l
    ld [wCB75], a
    ld a, h
    ld [wCB76], a
    farcall TickWCB75Sequence
    call Func_03A_4A3A
    ld a, [wD801]
    ld c, a
    call LoadEffectOBJPaletteC
    ret

Data_03A_4C12:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $22, $00

Jump_03A_4C14::
    call RunWD803EffectEvery5Frames
    call Func_03A_5536
    ld a, [wD802]
    cp a, $FF
    ret nz
    ld a, $7F
    ld [wC526], a
    ret

; every fifth frame (wDAF1) runs the effect routine for wD803 (jump table of fourteen) (E-0124)
; 1 call site from 1 routine (e.g. Func_03A_4ADB)
; reads: wDAF1, wD803
; writes: wDAF1
RunWD803EffectEvery5Frames::
Func_03A_4C26:: ; address name
    ld a, [wDAF1]
    inc a
    cp a, $05
    ld [wDAF1], a
    ret c
    xor a, a
    ld [wDAF1], a
    ld a, [wD803]
    rst $00
    dw RunWD803EffectEvery5Frames_Case00
    dw RunWD803EffectEvery5Frames_Case00
    dw RunWD803EffectEvery5Frames_Case02
    dw RunWD803EffectEvery5Frames_Case03
    dw RunWD803EffectEvery5Frames_Case04
    dw RunWD803EffectEvery5Frames_Case05
    dw RunWD803EffectEvery5Frames_Case06
    dw RunWD803EffectEvery5Frames_Case07
    dw RunWD803EffectEvery5Frames_Case08
    dw RunWD803EffectEvery5Frames_Case09
    dw RunWD803EffectEvery5Frames_Case0A
    dw RunWD803EffectEvery5Frames_Case0B
    dw RunWD803EffectEvery5Frames_Case0C
    dw RunWD803EffectEvery5Frames_Case0D

; entry 0 of the `rst $00` table in RunWD803EffectEvery5Frames
; no direct call (reached through a table, a jump or a vector)
; writes: wD802, wD804
RunWD803EffectEvery5Frames_Case00::
Jump_03A_4C54:: ; address name
    ld a, $FF
    ld [wD802], a
    xor a, a
    ld [wD804], a
    ret

; entry 2 of the `rst $00` table in RunWD803EffectEvery5Frames
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wC58A, wC57F, wD804
; writes: wD802, wD804, wD805
RunWD803EffectEvery5Frames_Case02::
Jump_03A_4C5E:: ; address name
    ld a, [wBattleTarget]
    and a, $03
    cp a, $03
    jp z, RunWD803EffectEvery5Frames_Table2_Case04
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_03A_4C7F
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_03A_4C7F
    ld a, [wBattleTarget]
    cp a, $04
    jr nc, RunWD803EffectEvery5Frames_Table2_Case04
    jr Jump_03A_4C86

Jump_03A_4C7F::
    ld a, [wBattleTarget]
    cp a, $04
    jr c, RunWD803EffectEvery5Frames_Table2_Case04

Jump_03A_4C86::
    ld a, [wBattleTarget]
    call CarryUnlessWDA63SlotEmpty
    jr c, RunWD803EffectEvery5Frames_Table2_Case04
    ld a, [wD804]
    rst $00
    dw RunWD803EffectEvery5Frames_Table2_Case00
    dw RunWD803EffectEvery5Frames_Table2_Case01
    dw RunWD803EffectEvery5Frames_Table2_Case00
    dw RunWD803EffectEvery5Frames_Table2_Case01
    dw RunWD803EffectEvery5Frames_Table2_Case04

; entry 0 of the `rst $00` table in RunWD803EffectEvery5Frames
; no direct call (reached through a table, a jump or a vector)
; writes: wD805
; points at: wD804
RunWD803EffectEvery5Frames_Table2_Case00::
Jump_03A_4C9C:: ; address name
    ld a, $06
    ld [wD805], a
    call EffectPositionIndexForTarget
    ld hl, Data_03A_4D52
    call ReadWordTableEntry_Bank3A
    ld de, vBGMap0
    add hl, de
    ld e, l
    ld d, h
    ld a, $03
    ld hl, Data_03A_4D5C
    call ReadWordTableEntry_Bank3A
    ld c, $06
    call CopyVRAMRectToBuffer
    ld hl, wD804
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunWD803EffectEvery5Frames
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wD805
; points at: wD804
RunWD803EffectEvery5Frames_Table2_Case01::
Jump_03A_4CC2:: ; address name
    ld a, $06
    ld [wD805], a
    call EffectPositionIndexForTarget
    ld hl, Data_03A_4D52
    call ReadWordTableEntry_Bank3A
    ld de, vBGMap0
    add hl, de
    ld e, l
    ld d, h
    ld a, [wBattleTarget]
    and a, $03
    ld hl, Data_03A_4D5C
    call ReadWordTableEntry_Bank3A
    ld c, $06
    call CopyVRAMRectToBuffer
    ld hl, wD804
    inc [hl]
    ret

; entry 4 of the `rst $00` table in RunWD803EffectEvery5Frames
; no direct call (reached through a table, a jump or a vector)
; writes: wD802, wD804, wD805
RunWD803EffectEvery5Frames_Table2_Case04::
Jump_03A_4CEB:: ; address name
    ld a, $FF
    ld [wD802], a
    xor a, a
    ld [wD804], a
    xor a, a
    ld [wD805], a
    ret

; A = a 0-4 position index from wD890 (side count) and the target's slot (E-0124)
; 2 call sites from 2 routines (e.g. RunWD803EffectEvery5Frames_Table2_Case01, RunWD803EffectEvery5Frames_Table2_Case00)
; reads: wD890, wBattleTarget
EffectPositionIndexForTarget::
Func_03A_4CF9:: ; address name
    ld a, [wD890]
    cp a, $01
    jr z, Jump_03A_4D28
    cp a, $02
    jr z, Jump_03A_4D17
    ld a, [wBattleTarget]
    and a, $03
    cp a, $01
    jr z, Jump_03A_4D28
    jr c, Jump_03A_4D13
    ld a, $04
    jr Jump_03A_4D2A

Jump_03A_4D13::
    ld a, $03
    jr Jump_03A_4D2A

Jump_03A_4D17::
    ld a, [wBattleTarget]
    and a, $03
    cp a, $01
    jr z, Jump_03A_4D24
    ld a, $01
    jr Jump_03A_4D2A

Jump_03A_4D24::
    ld a, $02
    jr Jump_03A_4D2A

Jump_03A_4D28::
    ld a, $00

Jump_03A_4D2A::
    ret

; copies rows of wD805 bytes from VRAM at HL (WaitForVRAMAccess, interrupts off per byte) to DE, C rows, the destination rows 32 bytes apart (the source-row step is not read) (E-0113)
; 4 call sites from 4 routines (e.g. RunWD803EffectEvery5Frames_Table2_Case01, RunWD803EffectEvery5Frames_Table2_Case00, Func_03A_50D9_Case01, Func_03A_50D9_Case00)
; reads: wD805
CopyVRAMRectToBuffer::
Func_03A_4D2B:: ; address name
    push de
    ld a, [wD805]
    ld b, a

Jump_03A_4D30::
    di
    call WaitForVRAMAccess
    ld a, [hl+]
    ld [de], a
    ei
    inc de
    dec b
    jr nz, Jump_03A_4D30
    pop de
    dec c
    ret z
    ld a, $20
    add a, e
    ld e, a
    jr nc, Jump_03A_4D45
    inc d

Jump_03A_4D45::
    jr CopyVRAMRectToBuffer

; HL = table of words, A = index: HL = the word at HL + 2 * A (A is doubled in 8 bits, so it wraps above $7F); A = its low byte (E-0065) (the same 11 bytes appear in 2 banks)
; 8 call sites from 4 routines (e.g. RunWD803EffectEvery5Frames_Table2_Case01, RunWD803EffectEvery5Frames_Table2_Case00, Func_03A_50D9_Case01, Func_03A_50D9_Case00)
ReadWordTableEntry_Bank3A::
Func_03A_4D47:: ; address name
    add a, a
    add a, l
    ld l, a
    ld a, $00
    adc a, h
    ld h, a
    deref_hl
    ret

Data_03A_4D52:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $E7, $00, $E4, $00, $EA, $00, $E1, $00, $ED, $00

Data_03A_4D5C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0E8D5C, $74
    ds $24, $C3

; entry 3 of the `rst $00` table in RunWD803EffectEvery5Frames
; no direct call (reached through a table, a jump or a vector)
; reads: wD804
RunWD803EffectEvery5Frames_Case03::
Jump_03A_4DF4:: ; address name
    ld a, [wD804]
    rst $00
    dw RunWD803EffectEvery5Frames_Case03_Case00
    dw RunWD803EffectEvery5Frames_Case03_Case01
    dw RunWD803EffectEvery5Frames_Case03_Case00
    dw RunWD803EffectEvery5Frames_Case03_Case03

; entry 0 of the `rst $00` table in RunWD803EffectEvery5Frames_Case03
; no direct call (reached through a table, a jump or a vector)
; writes: hScrollY, hScrollX
; points at: wD804
RunWD803EffectEvery5Frames_Case03_Case00::
Jump_03A_4E00:: ; address name
    ld a, $02
    ldh [hScrollY], a
    ld a, $00
    ldh [hScrollX], a
    ld hl, wD804
    inc [hl]
    ret

; hScrollY = 0, hScrollX = 1, then wD804 += 1 (E-0116)
; no direct call (reached through a table, a jump or a vector)
; writes: hScrollY, hScrollX
; points at: wD804
SetScroll0_1AndIncWD804:: ; heuristic: follows a terminator; C0
Func_03A_4E0D:: ; address name
    ld a, $00
    ldh [hScrollY], a
    ld a, $01
    ldh [hScrollX], a
    ld hl, wD804
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunWD803EffectEvery5Frames_Case03
; no direct call (reached through a table, a jump or a vector)
; writes: hScrollY, hScrollX
; points at: wD804
RunWD803EffectEvery5Frames_Case03_Case01::
Jump_03A_4E1A:: ; address name
    xor a, a
    ldh [hScrollY], a
    xor a, a
    ldh [hScrollX], a
    ld hl, wD804
    inc [hl]
    ret

; entry 3 of the `rst $00` table in RunWD803EffectEvery5Frames_Case03
; no direct call (reached through a table, a jump or a vector)
; writes: wD802, hScrollY, hScrollX, wD804
RunWD803EffectEvery5Frames_Case03_Case03::
Jump_03A_4E25:: ; address name
    ld a, $FF
    ld [wD802], a
    xor a, a
    ldh [hScrollY], a
    xor a, a
    ldh [hScrollX], a
    xor a, a
    ld [wD804], a
    ret

; entry 4 of the `rst $00` table in RunWD803EffectEvery5Frames
; no direct call (reached through a table, a jump or a vector)
; reads: wD804
RunWD803EffectEvery5Frames_Case04::
Jump_03A_4E35:: ; address name
    ld a, [wD804]
    rst $00
    dw RunWD803EffectEvery5Frames_Case04_Case00
    dw SetWC5E9PatternAndIncWD804
    dw RunWD803EffectEvery5Frames_Case04_Case00
    dw SetWC5E9PatternAndIncWD804
    dw RunWD803EffectEvery5Frames_Case04_Case00
    dw SetWC5E9PatternAndIncWD804
    dw RunWD803EffectEvery5Frames_Case04_Case06

; entry 0 of the `rst $00` table in RunWD803EffectEvery5Frames_Case04
; no direct call (reached through a table, a jump or a vector)
; points at: wC5E9, wD804
RunWD803EffectEvery5Frames_Case04_Case00::
Jump_03A_4E47:: ; address name
    ld hl, wC5E9
    ld [hl], $00
    inc hl
    ld [hl], $00
    inc hl
    ld [hl], $00
    ld hl, wD804
    inc [hl]
    ret

; wC5E9-wC5EB = $D2, $D2, $E2; wD804 += 1 (E-0074)
; 1 call site from 1 routine (e.g. RunWD803EffectEvery5Frames_Case04_Case06)
; points at: wC5E9, wD804
SetWC5E9PatternAndIncWD804::
Func_03A_4E57:: ; address name
    ld hl, wC5E9
    ld [hl], $D2
    inc hl
    ld [hl], $D2
    inc hl
    ld [hl], $E2
    ld hl, wD804
    inc [hl]
    ret

; entry 6 of the `rst $00` table in RunWD803EffectEvery5Frames_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wD802, wD804
RunWD803EffectEvery5Frames_Case04_Case06::
Jump_03A_4E67:: ; address name
    call SetWC5E9PatternAndIncWD804
    ld a, $FF
    ld [wD802], a
    xor a, a
    ld [wD804], a
    ret

; entry 5 of the `rst $00` table in RunWD803EffectEvery5Frames
; no direct call (reached through a table, a jump or a vector)
; reads: wD804
RunWD803EffectEvery5Frames_Case05::
Jump_03A_4E74:: ; address name
    ld a, [wD804]
    rst $00
    dw RunWD803EffectEvery5Frames_Case05_Case00
    dw RunWD803EffectEvery5Frames_Case05_Case01
    dw RunWD803EffectEvery5Frames_Case05_Case02
    dw RunWD803EffectEvery5Frames_Case05_Case03

; entry 0 of the `rst $00` table in RunWD803EffectEvery5Frames_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wD807
; writes: wD806, wD807
; points at: wD804
RunWD803EffectEvery5Frames_Case05_Case00::
Jump_03A_4E80:: ; address name
    call RunWD803EffectEvery5Frames_Shared01
    ld a, [wD807]
    cp a, $04
    ret c
    xor a, a
    ld [wD806], a
    xor a, a
    ld [wD807], a
    ld hl, wD804
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunWD803EffectEvery5Frames_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wD805
; writes: wD805
; points at: wD805, wD804
RunWD803EffectEvery5Frames_Case05_Case01::
Jump_03A_4E96:: ; address name
    ld hl, wD805
    inc [hl]
    ld a, [wD805]
    cp a, $0A
    ret nz
    ld hl, wD804
    inc [hl]
    xor a, a
    ld [wD805], a
    ret

; entry 2 of the `rst $00` table in RunWD803EffectEvery5Frames_Case05
; no direct call (reached through a table, a jump or a vector)
; points at: wC5E9, wD804
RunWD803EffectEvery5Frames_Case05_Case02::
Jump_03A_4EA9:: ; address name
    ld hl, wC5E9
    ld [hl], $D2
    inc hl
    ld [hl], $D2
    inc hl
    ld [hl], $E2
    ld hl, wD804
    inc [hl]
    ret

; entry 3 of the `rst $00` table in RunWD803EffectEvery5Frames_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wD802, wD804
RunWD803EffectEvery5Frames_Case05_Case03::
Jump_03A_4EB9:: ; address name
    ld a, $FF
    ld [wD802], a
    xor a, a
    ld [wD804], a
    ret

; only called from routines of RunWD803EffectEvery5Frames (E-0098)
; 2 call sites from 2 routines (e.g. RunWD803EffectEvery5Frames_Case05_Case00, RunWD803EffectEvery5Frames_Case07_Case00)
; points at: wD807, wC5E9
RunWD803EffectEvery5Frames_Shared01::
Func_03A_4EC3:: ; address name
    ld hl, wD807
    inc [hl]
    ld b, $03
    ld c, $00
    ld hl, wC5E9

Jump_03A_4ECE::
    ld a, [hl]
    and a, $03
    add a, $01
    cp a, $04
    jr c, Jump_03A_4ED9
    ld a, $03

Jump_03A_4ED9::
    or a, c
    ld c, a
    ld a, [hl]
    and a, $0C
    add a, $04
    cp a, $0D
    jr c, Jump_03A_4EE6
    ld a, $0C

Jump_03A_4EE6::
    or a, c
    ld c, a
    ld a, [hl]
    and a, $30
    add a, $10
    cp a, $31
    jr c, Jump_03A_4EF3
    ld a, $30

Jump_03A_4EF3::
    or a, c
    ld c, a
    ld a, [hl]
    and a, $C0
    add a, $40
    cp a, $C1
    jr c, Jump_03A_4F00
    ld a, $C0

Jump_03A_4F00::
    or a, c
    ld [hl+], a
    dec b
    jr nz, Jump_03A_4ECE
    ret

; entry 6 of the `rst $00` table in RunWD803EffectEvery5Frames
; no direct call (reached through a table, a jump or a vector)
; reads: wD804
RunWD803EffectEvery5Frames_Case06::
Jump_03A_4F06:: ; address name
    ld a, [wD804]
    rst $00
    dw RunWD803EffectEvery5Frames_Case06_Case00
    dw RunWD803EffectEvery5Frames_Case06_Case00
    dw RunWD803EffectEvery5Frames_Case06_Case00
    dw RunWD803EffectEvery5Frames_Case06_Case00
    dw RunWD803EffectEvery5Frames_Case06_Case00
    dw RunWD803EffectEvery5Frames_Case06_Case00
    dw RunWD803EffectEvery5Frames_Case06_Case00
    dw RunWD803EffectEvery5Frames_Case06_Case00
    dw RunWD803EffectEvery5Frames_Case06_Case00
    dw RunWD803EffectEvery5Frames_Case06_Case00
    dw RunWD803EffectEvery5Frames_Case06_Case00
    dw RunWD803EffectEvery5Frames_Case06_Case00
    dw RunWD803EffectEvery5Frames_Case06_Case0C

; entry 0 of the `rst $00` table in RunWD803EffectEvery5Frames_Case06
; no direct call (reached through a table, a jump or a vector)
; points at: wC5E9, wD804
RunWD803EffectEvery5Frames_Case06_Case00::
Jump_03A_4F24:: ; address name
    ld hl, wC5E9
    ld a, [hl]
    xor a, $FF
    ld [hl+], a
    ld a, [hl]
    xor a, $FF
    ld [hl+], a
    ld a, [hl]
    xor a, $FF
    ld [hl], a
    ld hl, wD804
    inc [hl]
    ret

; entry 12 of the `rst $00` table in RunWD803EffectEvery5Frames_Case06
; no direct call (reached through a table, a jump or a vector)
; writes: wD802, wD804
RunWD803EffectEvery5Frames_Case06_Case0C::
Jump_03A_4F38:: ; address name
    ld a, $FF
    ld [wD802], a
    xor a, a
    ld [wD804], a
    ret

; entry 7 of the `rst $00` table in RunWD803EffectEvery5Frames
; no direct call (reached through a table, a jump or a vector)
; reads: wD804
RunWD803EffectEvery5Frames_Case07::
Jump_03A_4F42:: ; address name
    ld a, [wD804]
    rst $00
    dw RunWD803EffectEvery5Frames_Case07_Case00
    dw RunWD803EffectEvery5Frames_Case07_Case01
    dw RunWD803EffectEvery5Frames_Case07_Case02
    dw RunWD803EffectEvery5Frames_Case07_Case00
    dw RunWD803EffectEvery5Frames_Case07_Case01
    dw RunWD803EffectEvery5Frames_Case07_Case02
    dw RunWD803EffectEvery5Frames_Case07_Case06

; entry 0 of the `rst $00` table in RunWD803EffectEvery5Frames_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wD807
; writes: wD806, wD807
; points at: wD804
RunWD803EffectEvery5Frames_Case07_Case00::
Jump_03A_4F54:: ; address name
    call RunWD803EffectEvery5Frames_Shared01
    ld a, [wD807]
    cp a, $04
    ret c
    xor a, a
    ld [wD806], a
    xor a, a
    ld [wD807], a
    ld hl, wD804
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunWD803EffectEvery5Frames_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wD805
; writes: wD805
; points at: wD805, wD804
RunWD803EffectEvery5Frames_Case07_Case01::
Jump_03A_4F6A:: ; address name
    ld hl, wD805
    inc [hl]
    ld a, [wD805]
    cp a, $05
    ret nz
    ld hl, wD804
    inc [hl]
    xor a, a
    ld [wD805], a
    ret

; entry 2 of the `rst $00` table in RunWD803EffectEvery5Frames_Case07
; no direct call (reached through a table, a jump or a vector)
; points at: wC5E9, wD804
RunWD803EffectEvery5Frames_Case07_Case02::
Jump_03A_4F7D:: ; address name
    ld hl, wC5E9
    ld [hl], $D2
    inc hl
    ld [hl], $D2
    inc hl
    ld [hl], $E2
    ld hl, wD804
    inc [hl]
    ret

; entry 6 of the `rst $00` table in RunWD803EffectEvery5Frames_Case07
; no direct call (reached through a table, a jump or a vector)
; writes: wD802, wD804
RunWD803EffectEvery5Frames_Case07_Case06::
Jump_03A_4F8D:: ; address name
    ld a, $FF
    ld [wD802], a
    xor a, a
    ld [wD804], a
    ret

; entry 8 of the `rst $00` table in RunWD803EffectEvery5Frames
; no direct call (reached through a table, a jump or a vector)
; reads: wD804
; writes: wD802, wD804, wD805
RunWD803EffectEvery5Frames_Case08::
Jump_03A_4F97:: ; address name
    ld a, [wD804]
    or a, a
    call z, RunWD803EffectEvery5Frames_Case08_Sub01
    call RunWD805Step
    ld a, [wD804]
    or a, a
    ret z
    ld a, $FF
    ld [wD802], a
    xor a, a
    ld [wD804], a
    xor a, a
    ld [wD805], a
    ret

; only called from RunWD803EffectEvery5Frames_Case08 (E-0047)
; 1 call site from 1 routine (e.g. RunWD803EffectEvery5Frames_Case08)
; reads: wD804, wD805
RunWD803EffectEvery5Frames_Case08_Sub01::
Func_03A_4FB4:: ; address name
    ld a, [wD804]
    or a, a
    ret nz
    ld a, [wD805]
    rst $00
    dw Func_03A_4FB4_Case00
    dw Func_03A_4FB4_Case01
    dw Func_03A_4FB4_Case02
    dw Func_03A_4FB4_Case01
    dw Func_03A_4FB4_Case00
    dw Func_03A_4FB4_Case01
    dw Func_03A_4FB4_Case02
    dw Func_03A_4FB4_Case01
    dw Func_03A_4FB4_Case00
    dw Func_03A_4FB4_Case01
    dw Func_03A_4FB4_Case02
    dw Func_03A_4FB4_Case00
    dw Func_03A_4FB4_Case01
    dw Func_03A_4FB4_Case02
    dw Func_03A_4FB4_Case01
    dw Func_03A_4FB4_Case00
    dw Func_03A_4FB4_Case01
    dw Func_03A_4FB4_Case02
    dw Func_03A_4FB4_Case01
    dw Func_03A_4FB4_Case00
    dw Func_03A_4FB4_Case01
    dw Func_03A_4FB4_Case02
    dw Func_03A_4FB4_Case01
    dw Func_03A_4FB4_Case00
    dw Func_03A_4FB4_Case01
    dw Func_03A_4FB4_Case02
    dw Func_03A_4FB4_Case1A

; entry 0 of the `rst $00` table in Func_03A_4FB4
; no direct call (reached through a table, a jump or a vector)
; writes: hScrollY, hScrollX
; points at: wD805
Func_03A_4FB4_Case00::
Jump_03A_4FF3:: ; address name
    ld a, $04
    ldh [hScrollY], a
    ld a, $00
    ldh [hScrollX], a
    ld hl, wD805
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_03A_4FB4
; no direct call (reached through a table, a jump or a vector)
; writes: hScrollY, hScrollX
; points at: wD805
Func_03A_4FB4_Case02::
Jump_03A_5000:: ; address name
    ld a, $00
    ldh [hScrollY], a
    ld a, $03
    ldh [hScrollX], a
    ld hl, wD805
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_03A_4FB4
; no direct call (reached through a table, a jump or a vector)
; writes: hScrollY, hScrollX
; points at: wD805
Func_03A_4FB4_Case01::
Jump_03A_500D:: ; address name
    xor a, a
    ldh [hScrollY], a
    xor a, a
    ldh [hScrollX], a
    ld hl, wD805
    inc [hl]
    ret

; entry 26 of the `rst $00` table in Func_03A_4FB4
; no direct call (reached through a table, a jump or a vector)
; writes: wD804, hScrollY, hScrollX, wD805
Func_03A_4FB4_Case1A::
Jump_03A_5018:: ; address name
    ld a, $01
    ld [wD804], a
    xor a, a
    ldh [hScrollY], a
    xor a, a
    ldh [hScrollX], a
    xor a, a
    ld [wD805], a
    ret

; runs the routine for wD805 (jump table) (E-0124)
; 1 call site from 1 routine (e.g. RunWD803EffectEvery5Frames_Case08)
; reads: wD805
RunWD805Step::
Func_03A_5028:: ; address name
    ld a, [wD805]
    rst $00
    dw RunWD805Step_Case00
    dw RunWD805Step_Case00
    dw RunWD805Step_Case00
    dw RunWD805Step_Case00
    dw RunWD805Step_Case00
    dw RunWD805Step_Case00
    dw RunWD805Step_Case00
    dw RunWD805Step_Case00
    dw RunWD805Step_Case00
    dw RunWD805Step_Case09
    dw RunWD805Step_Case00
    dw RunWD805Step_Case09
    dw RunWD805Step_Case00
    dw RunWD805Step_Case09
    dw RunWD805Step_Case00
    dw RunWD805Step_Case09
    dw RunWD805Step_Case00
    dw RunWD805Step_Case09
    dw RunWD805Step_Case00
    dw RunWD805Step_Case09
    dw RunWD805Step_Case00
    dw RunWD805Step_Case09
    dw RunWD805Step_Case00
    dw RunWD805Step_Case09
    dw RunWD805Step_Case00
    dw RunWD805Step_Case09
    dw RunWD805Step_Case00

; entry 9 of the `rst $00` table in RunWD805Step
; no direct call (reached through a table, a jump or a vector)
; points at: wC5E9
RunWD805Step_Case09::
Jump_03A_5062:: ; address name
    ld hl, wC5E9
    ld [hl], $00
    inc hl
    ld [hl], $00
    inc hl
    ld [hl], $00
    ret

; entry 0 of the `rst $00` table in RunWD805Step
; no direct call (reached through a table, a jump or a vector)
; points at: wC5E9
RunWD805Step_Case00::
Jump_03A_506E:: ; address name
    ld hl, wC5E9
    ld [hl], $D2
    inc hl
    ld [hl], $D2
    inc hl
    ld [hl], $E2
    ret

; entry 9 of the `rst $00` table in RunWD803EffectEvery5Frames
; no direct call (reached through a table, a jump or a vector)
; reads: wD807
; points at: wD807
RunWD803EffectEvery5Frames_Case09::
Jump_03A_507A:: ; address name
    ld a, [wD807]
    or a, a
    jr nz, Jump_03A_5085
    ld hl, wD807
    inc [hl]
    ret

Jump_03A_5085::
    ld hl, wD807
    inc [hl]
    ret

; entry 10 of the `rst $00` table in RunWD803EffectEvery5Frames
; no direct call (reached through a table, a jump or a vector)
; reads: wD804
RunWD803EffectEvery5Frames_Case0A::
Jump_03A_508A:: ; address name
    ld a, [wD804]
    rst $00
    dw RunWD803EffectEvery5Frames_Case0A_Case00
    dw RunWD803EffectEvery5Frames_Case0A_Case01
    dw RunWD803EffectEvery5Frames_Case0A_Case02
    dw RunWD803EffectEvery5Frames_Case0A_Case03

; entry 0 of the `rst $00` table in RunWD803EffectEvery5Frames_Case0A
; no direct call (reached through a table, a jump or a vector)
; reads: wD807
; writes: wD806, wD807
; points at: wD804
RunWD803EffectEvery5Frames_Case0A_Case00::
Jump_03A_5096:: ; address name
    call RunWD803EffectEvery5Frames_Case0A_Case00_Sub01
    ld a, [wD807]
    cp a, $04
    ret c
    xor a, a
    ld [wD806], a
    xor a, a
    ld [wD807], a
    ld hl, wD804
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunWD803EffectEvery5Frames_Case0A
; no direct call (reached through a table, a jump or a vector)
; reads: wD805
; writes: wD805
; points at: wD805, wD804
RunWD803EffectEvery5Frames_Case0A_Case01::
Jump_03A_50AC:: ; address name
    ld hl, wD805
    inc [hl]
    ld a, [wD805]
    cp a, $0A
    ret nz
    ld hl, wD804
    inc [hl]
    xor a, a
    ld [wD805], a
    ret

; entry 2 of the `rst $00` table in RunWD803EffectEvery5Frames_Case0A
; no direct call (reached through a table, a jump or a vector)
; points at: wC5E9, wD804
RunWD803EffectEvery5Frames_Case0A_Case02::
Jump_03A_50BF:: ; address name
    ld hl, wC5E9
    ld [hl], $D2
    inc hl
    ld [hl], $D2
    inc hl
    ld [hl], $E2
    ld hl, wD804
    inc [hl]
    ret

; entry 3 of the `rst $00` table in RunWD803EffectEvery5Frames_Case0A
; no direct call (reached through a table, a jump or a vector)
; writes: wD802, wD804
RunWD803EffectEvery5Frames_Case0A_Case03::
Jump_03A_50CF:: ; address name
    ld a, $FF
    ld [wD802], a
    xor a, a
    ld [wD804], a
    ret

; only called from RunWD803EffectEvery5Frames_Case0A_Case00 (E-0047)
; 1 call site from 1 routine (e.g. RunWD803EffectEvery5Frames_Case0A_Case00)
; points at: wD807, wC5E9
RunWD803EffectEvery5Frames_Case0A_Case00_Sub01::
Func_03A_50D9:: ; address name
    ld hl, wD807
    inc [hl]
    ld b, $03
    ld c, $00
    ld hl, wC5E9

Jump_03A_50E4::
    ld a, [hl]
    and a, $03
    cp a, $00
    jr z, Jump_03A_50ED
    sub a, $01

Jump_03A_50ED::
    or a, c
    ld c, a
    ld a, [hl]
    and a, $0C
    cp a, $00
    jr z, Jump_03A_50F8
    sub a, $04

Jump_03A_50F8::
    or a, c
    ld c, a
    ld a, [hl]
    and a, $30
    cp a, $00
    jr z, Jump_03A_5103
    sub a, $10

Jump_03A_5103::
    or a, c
    ld c, a
    ld a, [hl]
    and a, $C0
    cp a, $00
    jr z, Jump_03A_510E
    sub a, $40

Jump_03A_510E::
    or a, c
    ld [hl+], a
    dec b
    jr nz, Jump_03A_50E4
    ret

; entry 11 of the `rst $00` table in RunWD803EffectEvery5Frames
; no direct call (reached through a table, a jump or a vector)
; reads: wD804
RunWD803EffectEvery5Frames_Case0B::
Jump_03A_5114:: ; address name
    ld a, [wD804]
    rst $00
    dw RunWD803EffectEvery5Frames_Case04_Case00
    dw SetWC5E9PatternAndIncWD804
    dw RunWD803EffectEvery5Frames_Case04_Case00
    dw SetWC5E9PatternAndIncWD804
    dw RunWD803EffectEvery5Frames_Case04_Case00
    dw SetWC5E9PatternAndIncWD804
    dw RunWD803EffectEvery5Frames_Case04_Case00
    dw SetWC5E9PatternAndIncWD804
    dw RunWD803EffectEvery5Frames_Case04_Case00
    dw SetWC5E9PatternAndIncWD804
    dw RunWD803EffectEvery5Frames_Case04_Case00
    dw SetWC5E9PatternAndIncWD804
    dw RunWD803EffectEvery5Frames_Case04_Case00
    dw SetWC5E9PatternAndIncWD804
    dw RunWD803EffectEvery5Frames_Case04_Case00
    dw SetWC5E9PatternAndIncWD804
    dw RunWD803EffectEvery5Frames_Case04_Case06

; entry 12 of the `rst $00` table in RunWD803EffectEvery5Frames
; no direct call (reached through a table, a jump or a vector)
; reads: wD804
RunWD803EffectEvery5Frames_Case0C::
Jump_03A_513A:: ; address name
    ld a, [wD804]
    rst $00
    dw RunWD803EffectEvery5Frames_Case0C_Case00
    dw RunWD803EffectEvery5Frames_Case0C_Case01
    dw RunWD803EffectEvery5Frames_Case0C_Case02
    dw RunWD803EffectEvery5Frames_Case0C_Case01
    dw RunWD803EffectEvery5Frames_Case0C_Case04
    dw RunWD803EffectEvery5Frames_Case0C_Case01
    dw RunWD803EffectEvery5Frames_Case0C_Case06
    dw RunWD803EffectEvery5Frames_Case0C_Case01
    dw RunWD803EffectEvery5Frames_Case0C_Case08
    dw RunWD803EffectEvery5Frames_Case0C_Case01
    dw RunWD803EffectEvery5Frames_Case0C_Case0A
    dw RunWD803EffectEvery5Frames_Case0C_Case01
    dw RunWD803EffectEvery5Frames_Case0C_Case0C
    dw RunWD803EffectEvery5Frames_Case0C_Case01
    dw RunWD803EffectEvery5Frames_Case0C_Case0E
    dw RunWD803EffectEvery5Frames_Case0C_Case01
    dw RunWD803EffectEvery5Frames_Case0C_Case0C
    dw RunWD803EffectEvery5Frames_Case0C_Case01
    dw RunWD803EffectEvery5Frames_Case0C_Case0E
    dw RunWD803EffectEvery5Frames_Case0C_Case01
    dw RunWD803EffectEvery5Frames_Case0C_Case0C
    dw RunWD803EffectEvery5Frames_Case0C_Case01
    dw RunWD803EffectEvery5Frames_Case0C_Case0E
    dw RunWD803EffectEvery5Frames_Case0C_Case01
    dw RunWD803EffectEvery5Frames_Case0C_Case0C
    dw RunWD803EffectEvery5Frames_Case0C_Case01
    dw RunWD803EffectEvery5Frames_Case0C_Case0E
    dw RunWD803EffectEvery5Frames_Case0C_Case1B

; entry 1 of the `rst $00` table in RunWD803EffectEvery5Frames_Case0C
; no direct call (reached through a table, a jump or a vector)
; writes: hScrollX, hScrollY
; points at: wD804
RunWD803EffectEvery5Frames_Case0C_Case01::
Jump_03A_5176:: ; address name
    xor a, a
    ldh [hScrollX], a
    ldh [hScrollY], a
    ld hl, wD804
    inc [hl]
    ret

; entry 0 of the `rst $00` table in RunWD803EffectEvery5Frames_Case0C
; no direct call (reached through a table, a jump or a vector)
; writes: hScrollX
; points at: wD804
RunWD803EffectEvery5Frames_Case0C_Case00::
Jump_03A_5180:: ; address name
    ld a, $FE
    ldh [hScrollX], a
    ld hl, wD804
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunWD803EffectEvery5Frames_Case0C
; no direct call (reached through a table, a jump or a vector)
; writes: hScrollX
; points at: wD804
RunWD803EffectEvery5Frames_Case0C_Case02::
Jump_03A_5189:: ; address name
    ld a, $02
    ldh [hScrollX], a
    ld hl, wD804
    inc [hl]
    ret

; entry 4 of the `rst $00` table in RunWD803EffectEvery5Frames_Case0C
; no direct call (reached through a table, a jump or a vector)
; writes: hScrollX
; points at: wD804
RunWD803EffectEvery5Frames_Case0C_Case04::
Jump_03A_5192:: ; address name
    ld a, $FC
    ldh [hScrollX], a
    ld hl, wD804
    inc [hl]
    ret

; entry 6 of the `rst $00` table in RunWD803EffectEvery5Frames_Case0C
; no direct call (reached through a table, a jump or a vector)
; writes: hScrollX
; points at: wD804
RunWD803EffectEvery5Frames_Case0C_Case06::
Jump_03A_519B:: ; address name
    ld a, $04
    ldh [hScrollX], a
    ld hl, wD804
    inc [hl]
    ret

; entry 8 of the `rst $00` table in RunWD803EffectEvery5Frames_Case0C
; no direct call (reached through a table, a jump or a vector)
; writes: hScrollX
; points at: wD804
RunWD803EffectEvery5Frames_Case0C_Case08::
Jump_03A_51A4:: ; address name
    ld a, $F8
    ldh [hScrollX], a
    ld hl, wD804
    inc [hl]
    ret

; entry 10 of the `rst $00` table in RunWD803EffectEvery5Frames_Case0C
; no direct call (reached through a table, a jump or a vector)
; writes: hScrollX
; points at: wD804
RunWD803EffectEvery5Frames_Case0C_Case0A::
Jump_03A_51AD:: ; address name
    ld a, $08
    ldh [hScrollX], a
    ld hl, wD804
    inc [hl]
    ret

; entry 12 of the `rst $00` table in RunWD803EffectEvery5Frames_Case0C
; no direct call (reached through a table, a jump or a vector)
; writes: hScrollX, hScrollY
; points at: wD804
RunWD803EffectEvery5Frames_Case0C_Case0C::
Jump_03A_51B6:: ; address name
    ld a, $F8
    ldh [hScrollX], a
    ld a, $02
    ldh [hScrollY], a
    ld hl, wD804
    inc [hl]
    ret

; entry 14 of the `rst $00` table in RunWD803EffectEvery5Frames_Case0C
; no direct call (reached through a table, a jump or a vector)
; writes: hScrollX, hScrollY
; points at: wD804
RunWD803EffectEvery5Frames_Case0C_Case0E::
Jump_03A_51C3:: ; address name
    ld a, $08
    ldh [hScrollX], a
    ld a, $02
    ldh [hScrollY], a
    ld hl, wD804
    inc [hl]
    ret

; entry 27 of the `rst $00` table in RunWD803EffectEvery5Frames_Case0C
; no direct call (reached through a table, a jump or a vector)
; writes: hScrollX, hScrollY, wD802, wD804
RunWD803EffectEvery5Frames_Case0C_Case1B::
Jump_03A_51D0:: ; address name
    xor a, a
    ldh [hScrollX], a
    ldh [hScrollY], a
    ld a, $FF
    ld [wD802], a
    xor a, a
    ld [wD804], a
    ret

; entry 13 of the `rst $00` table in RunWD803EffectEvery5Frames
; no direct call (reached through a table, a jump or a vector)
; reads: wC57F, wC58A, wBattleActor, wD804
; writes: wD802, wD804, wD805
RunWD803EffectEvery5Frames_Case0D::
Jump_03A_51DF:: ; address name
    ld a, [wC57F]
    ld b, a
    ld a, [wC58A]
    ld c, a
    ld a, [wBattleActor]
    cp a, $07
    jr nc, Func_03A_50D9_Case04
    cp a, $03
    jr z, Func_03A_50D9_Case04
    dec c
    jr nz, Jump_03A_51FB
    cp a, $04
    jr nc, Func_03A_50D9_Case04
    jr Jump_03A_51FF

Jump_03A_51FB::
    cp a, $04
    jr c, Func_03A_50D9_Case04

Jump_03A_51FF::
    ld a, [wBattleActor]
    call CarryUnlessWDA63SlotEmpty
    jr c, Func_03A_50D9_Case04
    ld a, [wD804]
    rst $00
    dw Func_03A_50D9_Case00
    dw Func_03A_50D9_Case01
    dw Func_03A_50D9_Case00
    dw Func_03A_50D9_Case01
    dw Func_03A_50D9_Case04

; entry 0 of the `rst $00` table in Func_03A_50D9
; no direct call (reached through a table, a jump or a vector)
; writes: wD805
; points at: wD804
Func_03A_50D9_Case00::
Jump_03A_5215:: ; address name
    ld a, $06
    ld [wD805], a
    call EffectPositionIndexForActor
    ld hl, Data_03A_4D52
    call ReadWordTableEntry_Bank3A
    ld de, vBGMap0
    add hl, de
    ld e, l
    ld d, h
    ld a, $03
    ld hl, Data_03A_4D5C
    call ReadWordTableEntry_Bank3A
    ld c, $06
    call CopyVRAMRectToBuffer
    ld hl, wD804
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_03A_50D9
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; writes: wD805
; points at: wD804
Func_03A_50D9_Case01::
Jump_03A_523B:: ; address name
    ld a, $06
    ld [wD805], a
    call EffectPositionIndexForActor
    ld hl, Data_03A_4D52
    call ReadWordTableEntry_Bank3A
    ld de, vBGMap0
    add hl, de
    ld e, l
    ld d, h
    ld a, [wBattleActor]
    and a, $03
    ld hl, Data_03A_4D5C
    call ReadWordTableEntry_Bank3A
    ld c, $06
    call CopyVRAMRectToBuffer
    ld hl, wD804
    inc [hl]
    ret

; entry 4 of the `rst $00` table in Func_03A_50D9
; no direct call (reached through a table, a jump or a vector)
; writes: wD802, wD804, wD805
Func_03A_50D9_Case04::
Jump_03A_5264:: ; address name
    ld a, $FF
    ld [wD802], a
    xor a, a
    ld [wD804], a
    xor a, a
    ld [wD805], a
    ret

; A = a 0-4 position index from wD890 (side count) and the actor's slot (E-0124)
; 2 call sites from 2 routines (e.g. Func_03A_50D9_Case01, Func_03A_50D9_Case00)
; reads: wD890, wBattleActor
EffectPositionIndexForActor::
Func_03A_5272:: ; address name
    ld a, [wD890]
    cp a, $01
    jr z, Jump_03A_52A1
    cp a, $02
    jr z, Jump_03A_5290
    ld a, [wBattleActor]
    and a, $03
    cp a, $01
    jr z, Jump_03A_52A1
    jr c, Jump_03A_528C
    ld a, $04
    jr Jump_03A_52A3

Jump_03A_528C::
    ld a, $03
    jr Jump_03A_52A3

Jump_03A_5290::
    ld a, [wBattleActor]
    and a, $03
    cp a, $01
    jr z, Jump_03A_529D
    ld a, $01
    jr Jump_03A_52A3

Jump_03A_529D::
    ld a, $02
    jr Jump_03A_52A3

Jump_03A_52A1::
    ld a, $00

Jump_03A_52A3::
    ret

; A = entry: decompresses the stream named by the 3-byte far pointer at Data_03A_52B9 + 3 * A to vTiles0 (DecompressToVRAM) (E-0118)
; 2 call sites from 2 routines (e.g. Func_03A_4ADB, RunWC5FDState_E0_Case0A_Sub01)
DecompressGraphicsAToTiles0::
Func_03A_52A4:: ; address name
    ld c, a
    ld b, $00
    ld hl, Data_03A_52B9
    add hl, bc
    add hl, bc
    add hl, bc
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld b, [hl]
    ld hl, vTiles0
    call DecompressToVRAM
    ret

Data_03A_52B9:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0E92B9, $B4

; when wDAB9 is 3: wD804 += 4, and once it reaches $D0 wDAAA = 0 (E-0119)
; 2 call sites from 2 routines (e.g. Func_03A_4ADB, RunWC5FDState_E0_Case0A_Sub01)
; reads: wDAB9, wD804
; writes: wD804, wDAAA
AdvanceWD804By4InMode3::
Func_03A_536D:: ; address name
    ld a, [wDAB9]
    cp a, $03
    ret nz
    ld a, [wD804]
    add a, $04
    ld [wD804], a
    cp a, $D0
    ret c
    xor a, a
    ld [wDAAA], a
    ret

; draws the effect sprite from bank $3E, $3F, $3D, $3B or $92 by wD801 (< $0E, $20, $2D, $33, or more) (E-0124)
; 2 call sites from 2 routines (e.g. Func_03A_4ADB, RunWC5FDState_E0_Case0A_Sub01)
; reads: wD801
DrawEffectSpriteForWD801Range::
Func_03A_5383:: ; address name
    ld a, [wD801]
    cp a, $0E
    jr c, Jump_03A_539D
    cp a, $20
    jr c, Jump_03A_53A4
    cp a, $2D
    jr c, Jump_03A_53AB
    cp a, $33
    jr c, Jump_03A_53B2
    farcall DrawEffectSpriteAtWD804_Bank92
    ret

Jump_03A_539D::
    farcall DrawEffectSpriteAtWD804_Bank3E
    ret

Jump_03A_53A4::
    farcall DrawEffectSpriteForWD801Range_Sub02
    ret

Jump_03A_53AB::
    farcall DrawEffectSpriteForWD801Range_Sub01
    ret

Jump_03A_53B2::
    farcall DrawEffectSpriteAtWD804_Bank3B
    ret

; only called from DrawSkillByte0AndRun502BAnd53B9 (E-0047)
; 1 call site from 1 routine (e.g. DrawSkillByte0AndRun502BAnd53B9)
; reads: wC5F9, wD868, wD869, wD86A, wD86B
; writes: wD868, wD869, wD86A, wD86B
DrawSkillByte0AndRun502BAnd53B9_Sub01::
Func_03A_53B9:: ; address name
    ld hl, vBGMap0 + $1CE
    ld a, l
    ld [wD868], a
    ld a, h
    ld [wD869], a
    ld hl, vBGMap0 + $1D2
    ld a, l
    ld [wD86A], a
    ld a, h
    ld [wD86B], a
    ld hl, Data_03A_40CC
    call DrawSkillByte0AndRun502BAnd53B9_Sub01_Sub01
    ld hl, vBGMap0 + $1EE
    ld a, l
    ld [wD868], a
    ld a, h
    ld [wD869], a
    ld hl, vBGMap0 + $1F2
    ld a, l
    ld [wD86A], a
    ld a, h
    ld [wD86B], a
    ld hl, Data_03A_4294
    call DrawSkillByte0AndRun502BAnd53B9_Sub01_Sub01
    ld hl, vBGMap0 + $20E
    ld a, l
    ld [wD868], a
    ld a, h
    ld [wD869], a
    ld hl, vBGMap0 + $212
    ld a, l
    ld [wD86A], a
    ld a, h
    ld [wD86B], a
    ld hl, Data_03A_445C

; only called from DrawSkillByte0AndRun502BAnd53B9_Sub01 (E-0047)
; 2 call sites from 1 routine (e.g. DrawSkillByte0AndRun502BAnd53B9_Sub01)
; reads: wC5F9, wD868, wD869, wD86A, wD86B
DrawSkillByte0AndRun502BAnd53B9_Sub01_Sub01::
Func_03A_540A:: ; address name
    ld a, [wC5F9]
    ld c, a
    ld b, $00
    add hl, bc
    add hl, bc
    inc hl
    ld a, [hl]
    cp a, $FF
    jr z, Jump_03A_5451
    push hl
    push af
    and a, $0F
    cp a, $0A
    jr nc, Jump_03A_5424
    add a, $E0
    jr Jump_03A_5426

Jump_03A_5424::
    sub a, $02

Jump_03A_5426::
    ld b, a
    ld a, [wD868]
    ld l, a
    ld a, [wD869]
    ld h, a
    ld a, b
    call WriteVRAMByte
    pop af
    swap a
    and a, $0F
    cp a, $0A
    jr nc, Jump_03A_5440
    add a, $E0
    jr Jump_03A_5442

Jump_03A_5440::
    sub a, $02

Jump_03A_5442::
    ld b, a
    ld a, [wD868]
    ld l, a
    ld a, [wD869]
    ld h, a
    dec hl
    ld a, b
    call WriteVRAMByte
    pop hl

Jump_03A_5451::
    dec hl
    ld a, [hl]
    cp a, $FF
    jr z, Jump_03A_548E
    push af
    and a, $0F
    cp a, $0A
    jr nc, Jump_03A_5462
    add a, $E0
    jr Jump_03A_5464

Jump_03A_5462::
    sub a, $02

Jump_03A_5464::
    ld b, a
    ld a, [wD86A]
    ld l, a
    ld a, [wD86B]
    ld h, a
    ld a, b
    call WriteVRAMByte
    pop af
    swap a
    and a, $0F
    cp a, $0A
    jr nc, Jump_03A_547E
    add a, $E0
    jr Jump_03A_5480

Jump_03A_547E::
    sub a, $02

Jump_03A_5480::
    ld b, a
    ld a, [wD86A]
    ld l, a
    ld a, [wD86B]
    ld h, a
    dec hl
    ld a, b
    call WriteVRAMByte

Jump_03A_548E::
    ret

; only called from DrawHexByteAtBGMap8A (E-0047)
; 1 call site from 1 routine (e.g. DrawHexByteAtBGMap8A)
; reads: wC5FE, wD801
; writes: wD801, wDAB5, wDAB9, wD804, wD802, wD800, wDAAA, wDAB3, ...
; points at: wD805, wDAB3
DrawHexByteAtBGMap8A_Sub01::
Func_03A_548F:: ; address name
    ld a, [wC5FE]
    ld [wD801], a
    ld [wDAB5], a
    ld a, $01
    ld [wDAB9], a
    xor a, a
    ld [wD804], a
    ld a, $FF
    ld hl, wD805
    ld bc, $0003
    call FillBytes
    ld a, $01
    ld [wD802], a
    ld a, $01
    ld [wD800], a
    ld a, $01
    ld [wDAAA], a
    ld a, $00
    ld [wDAB3], a
    ld hl, wDAB3
    ld a, l
    ld [wCB75], a
    ld a, h
    ld [wCB76], a
    farcall TickWCB75Sequence
    call Func_03A_4A3A
    ld a, [wD801]
    ld c, a
    call LoadEffectOBJPaletteC
    ret

; only called from RunWC5FDState_E0_Case0A (E-0047)
; 1 call site from 1 routine (e.g. RunWC5FDState_E0_Case0A)
; reads: wD800, wD801, wDAB3, wDAAA
; writes: wD800, wDAAA, wD802
RunWC5FDState_E0_Case0A_Sub01::
Func_03A_54DC:: ; address name
    ld a, [wD800]
    cp a, $01
    jr nz, Jump_03A_54F0
    ld a, [wD801]
    ld c, a
    call DecompressGraphicsAToTiles0
    ld a, $02
    ld [wD800], a
    ret

Jump_03A_54F0::
    farcall TickWCB75Sequence
    call AdvanceWD804By4InMode3
    ld a, [wDAB3]
    or a, a
    jr z, Jump_03A_5509
    ld a, [wDAAA]
    or a, a
    jr z, Jump_03A_5509
    call DrawEffectSpriteForWD801Range
    ret

Jump_03A_5509::
    xor a, a
    ld [wD800], a
    ld [wDAAA], a
    ld a, $FF
    ld [wD802], a
    ret

; on CGB copies palette C (8 bytes) from Data_03A_7D9A to wOBJPaletteBuffer and sets wC527 = $80 (E-0124)
; 3 call sites from 3 routines (e.g. SelectEffectByWDAD2Flags, Func_03A_4ADB, DrawHexByteAtBGMap8A_Sub01)
; reads: wIsCGB
; writes: wC527
; points at: wOBJPaletteBuffer
LoadEffectOBJPaletteC::
Func_03A_5516:: ; address name
    ld a, [wIsCGB]
    or a, a
    ret z
    ld l, c
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    ld bc, Data_03A_7D9A
    add hl, bc
    ld b, $08
    ld de, wOBJPaletteBuffer

Jump_03A_552A::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_03A_552A
    ld a, $80
    ld [wC527], a
    ret

; 1 call site from 1 routine (e.g. Func_03A_4ADB)
; reads: wIsCGB, wC5E9, rSTAT, wC5EA
; writes: rBGPI, wD040, rOBPI, wD041
; points at: wD040, wBGPaletteBuffer, wD041, wOBJPaletteBuffer
Func_03A_5536::
    ld a, [wIsCGB]
    or a, a
    ret z
    ld hl, wD040
    ld a, [wC5E9]
    cp a, [hl]
    jp z, Jump_03A_564C
    ld c, $69

Jump_03A_5547::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_5547
    ld a, $80
    ldh [rBGPI], a
    ld hl, wBGPaletteBuffer
    call Func_03A_55BB

Jump_03A_5557::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_5557
    ld a, $88
    ldh [rBGPI], a
    call Func_03A_55BB

Jump_03A_5564::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_5564
    ld a, $90
    ldh [rBGPI], a
    call Func_03A_55BB

Jump_03A_5571::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_5571
    ld a, $98
    ldh [rBGPI], a
    call Func_03A_55BB

Jump_03A_557E::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_557E
    ld a, $A0
    ldh [rBGPI], a
    call Func_03A_55BB

Jump_03A_558B::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_558B
    ld a, $A8
    ldh [rBGPI], a
    call Func_03A_55BB

Jump_03A_5598::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_5598
    ld a, $B0
    ldh [rBGPI], a
    call Func_03A_55BB

Jump_03A_55A5::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_55A5
    ld a, $B8
    ldh [rBGPI], a
    call Func_03A_55BB
    ld a, [wC5E9]
    ld [wD040], a
    jp Jump_03A_564C

; 8 call sites from 1 routine (e.g. Func_03A_5536)
; reads: wC5E9, rSTAT
Func_03A_55BB::
    push hl
    ld a, [wC5E9]
    and a, $03
    ld de, Data_03A_575E
    add a, e
    ld e, a
    jr nc, Jump_03A_55C9
    inc d

Jump_03A_55C9::
    ld a, [de]
    add a, l
    ld l, a
    jr nc, Jump_03A_55CF
    inc h

Jump_03A_55CF::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_55CF
    ld a, [hl+]
    ldh [c], a
    ld a, [hl]
    ldh [c], a
    pop hl
    push hl
    ld a, [wC5E9]
    srl a
    srl a
    and a, $03
    ld de, Data_03A_575E
    add a, e
    ld e, a
    jr nc, Jump_03A_55EC
    inc d

Jump_03A_55EC::
    ld a, [de]
    add a, l
    ld l, a
    jr nc, Jump_03A_55F2
    inc h

Jump_03A_55F2::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_55F2
    ld a, [hl+]
    ldh [c], a
    ld a, [hl]
    ldh [c], a
    pop hl
    push hl
    ld a, [wC5E9]
    swap a
    and a, $03
    ld de, Data_03A_575E
    add a, e
    ld e, a
    jr nc, Jump_03A_560D
    inc d

Jump_03A_560D::
    ld a, [de]
    add a, l
    ld l, a
    jr nc, Jump_03A_5613
    inc h

Jump_03A_5613::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_5613
    ld a, [hl+]
    ldh [c], a
    ld a, [hl]
    ldh [c], a
    pop hl
    push hl
    ld a, [wC5E9]
    swap a
    srl a
    srl a
    and a, $03
    ld de, Data_03A_575E
    add a, e
    ld e, a
    jr nc, Jump_03A_5632
    inc d

Jump_03A_5632::
    ld a, [de]
    add a, l
    ld l, a
    jr nc, Jump_03A_5638
    inc h

Jump_03A_5638::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_5638
    ld a, [hl+]
    ldh [c], a
    ld a, [hl]
    ldh [c], a
    pop hl
    ld a, l
    add a, $08
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ret

Jump_03A_564C::
    ld hl, wD041
    ld a, [wC5EA]
    cp a, [hl]
    jp z, Jump_03A_575D
    ld c, $6B

Jump_03A_5658::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_5658
    ld a, $80
    ldh [rOBPI], a
    ld hl, wOBJPaletteBuffer
    call Func_03A_56CC

Jump_03A_5668::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_5668
    ld a, $88
    ldh [rOBPI], a
    call Func_03A_56CC

Jump_03A_5675::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_5675
    ld a, $90
    ldh [rOBPI], a
    call Func_03A_56CC

Jump_03A_5682::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_5682
    ld a, $98
    ldh [rOBPI], a
    call Func_03A_56CC

Jump_03A_568F::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_568F
    ld a, $A0
    ldh [rOBPI], a
    call Func_03A_56CC

Jump_03A_569C::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_569C
    ld a, $A8
    ldh [rOBPI], a
    call Func_03A_56CC

Jump_03A_56A9::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_56A9
    ld a, $B0
    ldh [rOBPI], a
    call Func_03A_56CC

Jump_03A_56B6::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_56B6
    ld a, $B8
    ldh [rOBPI], a
    call Func_03A_56CC
    ld a, [wC5EA]
    ld [wD041], a
    jp Jump_03A_575D

; 8 call sites from 1 routine (e.g. Func_03A_55BB)
; reads: wC5EA, rSTAT
Func_03A_56CC::
    push hl
    ld a, [wC5EA]
    and a, $03
    ld de, Data_03A_575E
    add a, e
    ld e, a
    jr nc, Jump_03A_56DA
    inc d

Jump_03A_56DA::
    ld a, [de]
    add a, l
    ld l, a
    jr nc, Jump_03A_56E0
    inc h

Jump_03A_56E0::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_56E0
    ld a, [hl+]
    ldh [c], a
    ld a, [hl]
    ldh [c], a
    pop hl
    push hl
    ld a, [wC5EA]
    srl a
    srl a
    and a, $03
    ld de, Data_03A_575E
    add a, e
    ld e, a
    jr nc, Jump_03A_56FD
    inc d

Jump_03A_56FD::
    ld a, [de]
    add a, l
    ld l, a
    jr nc, Jump_03A_5703
    inc h

Jump_03A_5703::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_5703
    ld a, [hl+]
    ldh [c], a
    ld a, [hl]
    ldh [c], a
    pop hl
    push hl
    ld a, [wC5EA]
    swap a
    and a, $03
    ld de, Data_03A_575E
    add a, e
    ld e, a
    jr nc, Jump_03A_571E
    inc d

Jump_03A_571E::
    ld a, [de]
    add a, l
    ld l, a
    jr nc, Jump_03A_5724
    inc h

Jump_03A_5724::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_5724
    ld a, [hl+]
    ldh [c], a
    ld a, [hl]
    ldh [c], a
    pop hl
    push hl
    ld a, [wC5EA]
    swap a
    srl a
    srl a
    and a, $03
    ld de, Data_03A_575E
    add a, e
    ld e, a
    jr nc, Jump_03A_5743
    inc d

Jump_03A_5743::
    ld a, [de]
    add a, l
    ld l, a
    jr nc, Jump_03A_5749
    inc h

Jump_03A_5749::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_5749
    ld a, [hl+]
    ldh [c], a
    ld a, [hl]
    ldh [c], a
    pop hl
    ld a, l
    add a, $08
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ret

Jump_03A_575D::
    ret

Data_03A_575E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $02, $04, $00, $06

; reads the effect flags in wDAD3 and tests bits 7, 6, 5, 3, 2, 0 in that order. Bits 0 and 2 set wBattleActor to wBattleTarget and select a table (Data_03A_60B7 or Data_03A_6107) for the display; bits 7, 6, 5 and 3 go to routines not read (E-0057)
; 15 call sites from 12 routines (e.g. Func_03A_4ADB, Func_032_4ADC_Case03, Func_032_5820_Case02, ResolveStep0EEffect_Case00, ...)
; reads: wDAD3, wBattleTarget, wBattleActionId
; writes: wBattleActor
SelectEffectByWDAD3Flags::
Func_03A_5762:: ; address name
    ld a, [wDAD3]
    or a, a
    ret z
    bit 7, a
    jr nz, Jump_03A_5796
    bit 6, a
    jr nz, Jump_03A_579B
    bit 5, a
    jr nz, Jump_03A_57A0
    bit 3, a
    jr nz, Jump_03A_57B1
    bit 2, a
    jr nz, Jump_03A_578B
    bit 0, a
    jr nz, Jump_03A_5780
    ret

Jump_03A_5780::
    ld a, [wBattleTarget]
    ld [wBattleActor], a
    ld hl, Data_03A_60B7
    jr Jump_03A_57B4

Jump_03A_578B::
    ld a, [wBattleTarget]
    ld [wBattleActor], a
    ld hl, Data_03A_6107
    jr Jump_03A_57B4

Jump_03A_5796::
    ld hl, Data_03A_57F7
    jr Jump_03A_57B4

Jump_03A_579B::
    ld hl, Data_03A_59BF
    jr Jump_03A_57B4

Jump_03A_57A0::
    ld b, a
    call SelectEffectByWDAD3Flags_Sub01
    ret nz
    ld hl, Data_03A_5B87
    bit 4, b
    jr nz, Jump_03A_57B4
    ld hl, Data_03A_5D4F
    jr Jump_03A_57B4

Jump_03A_57B1::
    ld hl, Data_03A_5F17

Jump_03A_57B4::
    ld a, [wBattleActionId]
    ld c, a
    ld b, $00
    add hl, bc
    add hl, bc
    call ActorOnLocalSide_Bank3A
    jr nc, Jump_03A_57C2
    inc hl

Jump_03A_57C2::
    ld a, [hl]
    cp a, $FF
    ret z
    call QueueSoundEffect
    ret

; only called from SelectEffectByWDAD3Flags (E-0047)
; 1 call site from 1 routine (e.g. SelectEffectByWDAD3Flags)
; reads: wBattleActionId, wDAC0
; points at: wBattleDamageLo
SelectEffectByWDAD3Flags_Sub01::
Func_03A_57CA:: ; address name
    bit 4, a
    ret z
    ld a, [wBattleActionId]
    cp a, $15
    jr z, Jump_03A_57E2
    cp a, $20
    jr z, Jump_03A_57F1
    cp a, $7B
    jr z, Jump_03A_57F1
    cp a, $D6
    jr z, Jump_03A_57E2
    xor a, a
    ret

Jump_03A_57E2::
    ld hl, wBattleDamageLo
    ld a, [hl+]
    sub a, $E8
    ld a, [hl]
    sbc a, $03
    ld a, $81
    call QueueSoundEffect
    ret

Jump_03A_57F1::
    ld a, [wDAC0]
    bit 6, a
    ret

Data_03A_57F7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $80, $7C
    ds $78, $7A
    INCBIN "dwm2-cobi-us.gbc", $0E9871, $BE
    ds $1C, $FF
    db $80, $7C, $FF, $FF, $FF, $FF, $7A, $FF, $7A
    ds $15, $FF
    INCBIN "dwm2-cobi-us.gbc", $0E9969, $56

Data_03A_59BF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $FF, $FF, $89, $FF, $8B, $FF, $8B, $FF, $8D, $FF, $8D, $FF, $8F, $FF, $90
    db $FF, $D9, $FF, $91, $FF, $93, $FF, $93, $FF, $94, $FF, $97, $FF, $97, $FF, $98
    db $FF, $95, $FF, $95, $FF, $96
    ds $55, $FF
    INCBIN "dwm2-cobi-us.gbc", $0E9A3A, $61
    ds $2A, $FF
    db $B0, $B0
    ds $1B, $FF
    db $B6
    ds $12, $FF
    db $DC, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $BA
    ds $5E, $FF
    db $BC, $FF, $BD, $FF, $BF, $FF, $C1, $FF, $C3, $FF, $C5, $FF, $FF, $FF, $99, $FF
    db $99, $FF, $C7
    ds $12, $FF
    db $CB, $FF

Data_03A_5B87:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $26, $81
    db $B1, $B1, $B1, $B1, $B1, $B1
    ds $10, $85
    db $FF, $FF, $FF, $FF, $85, $85, $85, $85, $85, $85, $85, $85, $85, $85, $86, $86
    db $86, $86, $87, $87, $87, $87, $86, $86, $86, $86, $87, $87, $87, $87, $86, $86
    db $99, $99, $88, $88, $88, $88, $86, $FF, $86, $87, $87, $87, $FF, $88, $FF, $FF
    db $9B, $9B, $9B, $9B, $FF, $FF, $FF, $FF, $9A, $9A, $9A, $9A, $FF, $FF
    ds $56, $81
    db $FF, $FF
    ds $10, $81
    db $88, $88, $88, $88, $88, $88, $88, $88, $88, $88, $87, $87, $86, $87, $88, $88
    db $B1, $B1, $88, $88, $85, $85, $85, $85, $FF, $FF, $88, $99, $81, $81, $FF, $FF
    db $85, $85, $87, $87
    ds $10, $FF
    db $88, $88, $88, $88, $81, $81, $81, $81, $88, $88, $81, $81, $7A, $7A, $87, $87
    db $87, $87, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $9B, $9B, $85, $85, $FF, $FF, $FF, $FF, $85, $85
    ds $14, $FF
    INCBIN "dwm2-cobi-us.gbc", $0E9CDB, $4C
    ds $14, $81
    db $85, $85, $FF, $FF, $9A, $9A, $86, $86, $FF, $FF, $86, $87, $FF, $FF, $88, $88
    db $FF, $FF, $FF, $FF

Data_03A_5D4F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $84, $84
    ds $9E, $FF
    ds $30, $84
    db $FF, $FF
    ds $10, $84
    ds $72, $FF
    db $84, $84
    ds $1C, $FF
    db $84, $84, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $84, $84
    db $84, $84, $84, $84, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $82, $82
    db $FF, $FF, $FF, $FF, $FF, $FF, $84, $84, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $84, $84, $84, $84, $84, $84, $84, $84, $FF, $FF, $84, $84, $84, $84
    ds $16, $FF

Data_03A_5F17:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $BE, $FF
    db $88, $88, $88, $88, $88, $88
    ds $16, $FF
    db $81, $81, $FF, $FF, $81, $81, $81, $81
    ds $BE, $FF

Data_03A_60B7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $FF
    ds $18, $85
    ds $2A, $FF
    db $87, $FF, $86, $FF, $81, $FF, $81, $FF, $81, $FF, $81, $FF

Data_03A_6107:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $32, $FF
    db $85, $FF, $85, $FF, $85, $FF, $85, $FF, $88, $88, $85, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $93, $FF, $97, $FF, $96, $FF, $96, $FF

; battle fight step 3: returns while a message is being drawn; in link mode calls Func_03A_4ADB; otherwise one of 6 sub-steps by wBattleSubPhase, which execute the chosen actions through RunBattleResolveStep
; 2 call sites from 2 routines (e.g. BattleFight_Step3, RunBattlePhaseWhenTextIdle_A0_Case01_Case03)
; reads: wC52B, wD802, wC58A, wBattleSubPhase
RunBattleActions::
Func_03A_6157:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    call RedrawChangedSlotPanels
    ld a, [wD802]
    cp a, $FF
    jr z, Jump_03A_6172
    ld a, [wC58A]
    or a, a
    ret nz
    farcall Func_03A_4ADB
    ret

Jump_03A_6172::
    ld a, [wBattleSubPhase]
    rst $00
    dw RunBattleActions_Case00
    dw RunBattleActions_Case01
    dw RunBattleActions_Case02
    dw RunBattleActions_Case03
    dw RunActionSpecificPostStep
    dw RunBattleActions_Case05
    dw RunBattleActions_Case06
    dw RunBattleActions_Case07
    dw RunBattleActions_Case08
    dw RunBattleActions_Case09
    dw RunBattleActions_Case0A

; entry 0 of the `rst $00` table in RunBattleActions
; no direct call (reached through a table, a jump or a vector)
RunBattleActions_Case00::
Jump_03A_618C:: ; address name
    farcall RunBattleActions_Case00_Sub01
    ret

; entry 1 of the `rst $00` table in RunBattleActions
; no direct call (reached through a table, a jump or a vector)
RunBattleActions_Case01::
Jump_03A_6193:: ; address name
    farcall RunBattleResolveStep
    ret

; entry 2 of the `rst $00` table in RunBattleActions
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActionId
; writes: wRecordBuffer, wCFED
RunBattleActions_Case02::
Jump_03A_619A:: ; address name
    ld a, [wBattleActionId]
    ld [wRecordBuffer], a
    xor a, a
    ld [wCFED], a
    farcall LoadSkillRecord
    call RunBattleResolveStep_69AA
    ret

; entry 3 of the `rst $00` table in RunBattleActions
; no direct call (reached through a table, a jump or a vector)
; reads: wCFF2, wBattleActionId, wBattleActor, wDAB2
; writes: wBattleTarget, wBattleSubPhase, wBattleResolveStep
; points at: wBattleSubPhase, wD812, wBattleTargetChoice
RunBattleActions_Case03::
Jump_03A_61AE:: ; address name
    ld a, [wCFF2]
    cp a, $80
    jr z, Jump_03A_61CB
    and a, $0F
    cp a, $02
    jr z, Jump_03A_61CB
    cp a, $04
    jr z, Jump_03A_61D7
    ld a, [wBattleActionId]
    cp a, $63
    jr z, Jump_03A_61F4
    ld hl, wBattleSubPhase
    inc [hl]
    ret

Jump_03A_61CB::
    ld a, [wDAB2]
    or a, a
    jp z, RunBattleStep4_Case03_Sub01
    ld hl, wBattleSubPhase
    inc [hl]
    ret

Jump_03A_61D7::
    ld a, [wBattleActionId]
    cp a, $64
    jr z, Jump_03A_61F4
    ld a, [wBattleActor]
    ld hl, wD812
    call AddAx9ToHL
    bit 0, [hl]
    jr nz, Jump_03A_61F0
    ld hl, wBattleSubPhase
    inc [hl]
    ret

Jump_03A_61F0::
    call RollRepeatCountForAction
    ret

Jump_03A_61F4::
    call Func_03A_6846
    ret

; after an action: actions $4E/$4F with wDABA clear the actor's wD812 bit 0 (text $81); $B9 clears it (text $86); $D6 stores the actor in wC982; $15 and $D6 jump to resolve step $0E; otherwise wBattleSubPhase += 1 (E-0127)
; 1 call site from 1 routine (e.g. RunBattleStep4_Case04)
; reads: wBattleActionId, wBattleActor, wDABA
; writes: wC982, wC983, wBattleSubPhase, wBattleResolveStep, wBattleSubStep
; points at: wBattleSubPhase, wCFCF, wD812
RunActionSpecificPostStep::
Func_03A_61F8:: ; address name
    ld a, [wBattleActionId]
    cp a, $4E
    jr z, Jump_03A_6211
    cp a, $4F
    jr z, Jump_03A_6211
    cp a, $B9
    jr z, Jump_03A_6230
    cp a, $15
    jr z, Jump_03A_624F
    cp a, $D6
    jr z, Jump_03A_6245
    jr Jump_03A_6264

Jump_03A_6211::
    ld a, [wDABA]
    or a, a
    jr z, Jump_03A_6264
    ld a, [wBattleActor]
    ld hl, wD812
    call AddAx9ToHL
    bit 0, [hl]
    jr z, Jump_03A_6264
    res 0, [hl]
    ld d, $81
    farcall ShowBattleText
    jr Jump_03A_6264

Jump_03A_6230::
    ld a, [wBattleActor]
    ld hl, wD812
    call AddAx9ToHL
    res 0, [hl]
    ld d, $86
    farcall ShowBattleText
    jr Jump_03A_6264

Jump_03A_6245::
    ld a, [wBattleActor]
    ld [wC982], a
    xor a, a
    ld [wC983], a

Jump_03A_624F::
    ld a, $01
    ld [wBattleSubPhase], a
    ld a, $0E
    ld [wBattleResolveStep], a
    ld a, $00
    ld [wBattleSubStep], a
    ld hl, wCFCF
    set 0, [hl]
    ret

Jump_03A_6264::
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 5 of the `rst $00` table in RunBattleActions
; no direct call (reached through a table, a jump or a vector)
; reads: wDAB2, wBattleTarget, wBattleActor, wCFF5, wD89E
; writes: wDAB2, wC970, wBattleSubPhase, wBattleResolveStep, wDABD, wDABE, wCFCF, wBattleStep, ...
; points at: wD812, wBattleStep, wBattleSubPhase, wD810, wBattlePhase, wD895, wDA5B, wBattleActionChoice
RunBattleActions_Case05::
Jump_03A_6269:: ; address name
    ld a, [wDAB2]
    or a, a
    jr z, Jump_03A_629F
    xor a, a
    ld [wDAB2], a
    ld a, $01
    ld [wC970], a
    ld a, [wBattleTarget]
    call CheckSlotStatusBlockWide_Bank3A
    jr c, Jump_03A_629F
    ld hl, wD812
    call AddAx9ToHL
    bit 1, [hl]
    jr z, Jump_03A_629F
    ld hl, wBattleStep
    inc [hl]
    xor a, a
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    ld d, $7E
    farcall ShowBattleText
    ret

Jump_03A_629F::
    ld hl, wBattleSubPhase
    inc [hl]

; entry 6 of the `rst $00` table in RunBattleActions
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wCFF5, wD89E
; writes: wDABD, wDABE, wCFCF, wBattleStep, wBattleSubPhase, wBattleResolveStep, wD89E, wBattleSubStep, ...
; points at: wD810, wBattleSubPhase, wBattlePhase, wD895, wDA5B, wBattleActionChoice
RunBattleActions_Case06::
Jump_03A_62A3:: ; address name
    ld a, [wBattleActor]
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_03A_62FC
    ld hl, wD810
    call AddAx9ToHL
    bit 6, [hl]
    jr z, Jump_03A_62FC
    res 6, [hl]
    ld a, [wCFF5]
    bit 4, a
    jr z, Jump_03A_62FC
    call CheckActionBDOrRun63B2And63D2
    jr nc, Jump_03A_62C5
    jr Jump_03A_62FC

Jump_03A_62C5::
    xor a, a
    ld [wDAD2], a
    ld a, $FF
    ld [wD802], a
    xor a, a
    ld [wDABA], a
    xor a, a
    ld [wDABF], a
    xor a, a
    ld [wDABD], a
    ld a, $FF
    ld [wDAD1], a
    xor a, a
    ld [wBattleSubPhase], a
    ld a, $01
    ld [wBattleResolveStep], a
    ld a, $04
    ld [wBattleSubStep], a
    xor a, a
    ld [wDABA], a
    farcall ChooseTargetForActor
    ld a, d
    ld [wBattleTarget], a
    ret

Jump_03A_62FC::
    ld hl, wBattleSubPhase
    inc [hl]

; entry 7 of the `rst $00` table in RunBattleActions
; no direct call (reached through a table, a jump or a vector)
; reads: wD89E, wBattleActor
; writes: wDABD, wDABE, wCFCF, wBattleStep, wBattleSubPhase, wBattleResolveStep, wD89E, wBattleSubStep
; points at: wBattlePhase, wD895, wDA5B, wBattleActionChoice, wD810
RunBattleActions_Case07::
Jump_03A_6300:: ; address name
    xor a, a
    ld [wDABD], a
    xor a, a
    ld [wDABE], a
    xor a, a
    ld [wCFCF], a
    call CheckActionBDOrRun63B2And63D2
    jr nc, Jump_03A_6322
    ld hl, wBattlePhase
    inc [hl]
    xor a, a
    ld [wBattleStep], a
    xor a, a
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    ret

Jump_03A_6322::
    ld a, [wD89E]
    ld hl, wD895
    add_a_to_hl
    ld a, [hl]
    cp a, $10
    jr z, Jump_03A_635F
    ld a, [wBattleActor]
    ld hl, wDA5B
    add_a_to_hl
    ld [hl], $03
    push hl
    ld a, [wBattleActor]
    ld hl, wBattleActionChoice
    add a, a
    add_a_to_hl
    ld a, [hl]
    cp a, $CC
    jr nz, Jump_03A_635E
    ld a, [wBattleActor]
    ld hl, wD810
    call AddAx9ToHL
    ld a, [hl]
    and a, $F3
    ld [hl], a

Jump_03A_635E::
    pop hl

Jump_03A_635F::
    ld a, [wD89E]
    inc a
    ld [wD89E], a
    cp a, $09
    jr nc, Jump_03A_6390
    ld a, [wD89E]
    ld hl, wD895
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    jr z, Jump_03A_6390
    cp a, $10
    jr z, Jump_03A_6383
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_03A_635F

Jump_03A_6383::
    xor a, a
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleSubStep], a
    ret

Jump_03A_6390::
    ld a, $09
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    ret

; returns A = 0 for action $BD while wDABA & $7F is non-zero; otherwise runs Func_03A_63B2 and, without carry, Func_03A_63D2 (E-0122)
; 5 call sites from 5 routines (e.g. RunBattleActions_Case07, RunBattleActions_Case06, RunBattleActions_Case09_Case03, RunBattleResolveStep_69AA_Case08, ...)
; reads: wBattleActionId, wDABA
CheckActionBDOrRun63B2And63D2::
Func_03A_639A:: ; address name
    ld a, [wBattleActionId]
    cp a, $BD
    jr nz, Jump_03A_63AA
    ld a, [wDABA]
    and a, $7F
    jr z, Jump_03A_63AA
    xor a, a
    ret

Jump_03A_63AA::
    call CheckActionBDOrRun63B2And63D2_Sub01
    ret c
    call CheckActionBDOrRun63B2And63D2_Sub02
    ret

; only called from CheckActionBDOrRun63B2And63D2 (E-0047)
; 1 call site from 1 routine (e.g. CheckActionBDOrRun63B2And63D2)
; reads: wC58A, wC57F
CheckActionBDOrRun63B2And63D2_Sub01::
Func_03A_63B2:: ; address name
    ld c, $00
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_03A_63C4
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_03A_63C4
    ld c, $04

Jump_03A_63C4::
    call SlotPresentWithStatus0Bit6
    ret nc
    inc c
    call SlotPresentWithStatus0Bit6
    ret nc
    inc c
    call SlotPresentWithStatus0Bit6
    ret

; only called from CheckActionBDOrRun63B2And63D2 (E-0047)
; 1 call site from 1 routine (e.g. CheckActionBDOrRun63B2And63D2)
; reads: wC58A, wC57F
CheckActionBDOrRun63B2And63D2_Sub02::
Func_03A_63D2:: ; address name
    ld c, $04
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_03A_63E6
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_03A_63C4
    ld c, $00
    jr Jump_03A_63C4

Jump_03A_63E6::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    ret nc
    inc c
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    ret nc
    inc c
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    ret

; C = slot: carry set when the slot is present and its status byte 0 bit 6 is set, else carry clear (E-0118)
; 3 call sites from 1 routine (e.g. CheckActionBDOrRun63B2And63D2_Sub01)
; points at: wBattleStatus
SlotPresentWithStatus0Bit6::
Func_03A_63F7:: ; address name
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    ret c
    ld a, c
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit 6, [hl]
    ret z
    scf
    ret

; entry 8 of the `rst $00` table in RunBattleActions
; no direct call (reached through a table, a jump or a vector)
RunBattleActions_Case08::
Jump_03A_6408:: ; address name
    farcall RunBattleActions_Case08_Sub01
    ret

; entry 9 of the `rst $00` table in RunBattleActions
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleResolveStep
RunBattleActions_Case09::
Jump_03A_640F:: ; address name
    ld a, [wBattleResolveStep]
    rst $00
    dw RunBattleActions_Case09_Case00
    dw RunBattleActions_Case09_Case01
    dw RunBattleActions_Case09_Case02
    dw RunBattleActions_Case09_Case03
    dw RunBattleActions_Case09_Case04
    dw RunBattleActions_Case09_Case05
    dw RunBattleActions_Case09_Case06

; entry 0 of the `rst $00` table in RunBattleActions_Case09
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleActor, wBattleResolveStep
; points at: wBattleResolveStep, wD80A, wD864, wBattleStatus
RunBattleActions_Case09_Case00::
Jump_03A_6421:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wD80A
    ld a, [hl]
    and a, $AF
    ld [hl+], a
    ld a, [hl]
    and a, $AF
    ld [hl], a
    ld hl, wD864
    ld a, [hl]
    and a, $03
    ld [hl+], a
    ld a, [hl]
    and a, $03
    ld [hl], a
    ld b, $09
    ld hl, wBattleStatus

Jump_03A_6440::
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    rrca
    and a, $55
    ld [hl+], a
    ld a, [hl]
    and a, $30
    jr z, Jump_03A_6458
    ld a, [hl]
    and a, $CF
    ld e, a
    ld a, [hl]
    rrca
    and a, $10
    or a, e
    ld [hl], a

Jump_03A_6458::
    inc hl
    ld a, [hl]
    and a, $C0
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld a, [hl]
    and a, $03
    jr z, Jump_03A_646E
    ld a, [hl]
    and a, $FC
    ld e, a
    ld a, [hl]
    rrca
    and a, $01
    or a, e
    ld [hl], a

Jump_03A_646E::
    inc hl
    dec b
    jr nz, Jump_03A_6440
    xor a, a
    ld [wBattleActor], a
    call CarryUnlessWDA63SlotEmpty
    ret nc
    ld a, $04
    ld [wBattleResolveStep], a
    ret

; entry 1 of the `rst $00` table in RunBattleActions_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; writes: wBattleResolveStep
; points at: wBattleResolveStep, wD811
RunBattleActions_Case09_Case01::
Jump_03A_6480:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wBattleActor]
    ld hl, wD811
    call AddAx9ToHL
    ld a, [hl]
    and a, $3F
    ld d, a
    ld a, [hl]
    and a, $C0
    jr z, Jump_03A_64AE
    push hl
    push de
    sub a, $40
    jr nz, Jump_03A_64A5
    ld d, $84
    farcall ShowBattleText
    xor a, a

Jump_03A_64A5::
    pop de
    pop hl
    or a, d
    ld [hl], a
    ld a, $04
    ld [wBattleResolveStep], a

Jump_03A_64AE::
    ret

; entry 2 of the `rst $00` table in RunBattleActions_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wD868, wD871
; writes: wD868, wBattleTarget
; points at: wBattleResolveStep, wBattleStatus
RunBattleActions_Case09_Case02::
Jump_03A_64AF:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wBattleActor]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    and a, $03
    ret z
    bit 0, a
    jr nz, Jump_03A_64D1
    ld b, $06
    ld a, $89
    ld [wD868], a
    jr Jump_03A_64D8

Jump_03A_64D1::
    ld b, $10
    ld a, $88
    ld [wD868], a

Jump_03A_64D8::
    ld a, [wBattleActor]
    ld [wBattleTarget], a
    call RunBattleActions_Case09_Case02_Sub01
    call RunBattleActions_Case09_Case02_Sub02
    ld a, [wD868]
    ld d, a
    farcall ShowBattleText
    ld a, [wD871]
    or a, a
    ret z
    ld hl, wBattleResolveStep
    dec [hl]
    ret

; only called from RunBattleActions_Case09_Case02 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleActions_Case09_Case02)
; reads: wBattleActor
; writes: wBattleDamageLo, wD873
RunBattleActions_Case09_Case02_Sub01::
Func_03A_64F8:: ; address name
    push bc
    ld a, [wBattleActor]
    call GetBattleMaxHP_Bank3A
    ld a, b
    call DivideHLByA
    ld a, h
    or a, l
    jr nz, Jump_03A_650A
    ld hl, $0001

Jump_03A_650A::
    pop bc
    ld a, b
    cp a, $06
    jr z, Jump_03A_651E
    ld a, h
    or a, a
    jr nz, Jump_03A_6519
    ld a, l
    cp a, $32
    jr c, Jump_03A_652A

Jump_03A_6519::
    ld hl, $0032
    jr Jump_03A_652A

Jump_03A_651E::
    ld a, h
    or a, a
    jr nz, Jump_03A_6527
    ld a, l
    cp a, $96
    jr c, Jump_03A_652A

Jump_03A_6527::
    ld hl, $0096

Jump_03A_652A::
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    ret

; only called from RunBattleActions_Case09_Case02 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleActions_Case09_Case02)
; reads: wBattleActor, wBattleDamageLo, wD873, wD868
; writes: wD871, wD868, wDABE
; points at: wBattleHP
RunBattleActions_Case09_Case02_Sub02::
Func_03A_6533:: ; address name
    xor a, a
    ld [wD871], a
    ld a, [wBattleActor]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank3A
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wD873]
    ld b, a
    ld a, e
    sub a, c
    ld e, a
    ld a, d
    sbc a, b
    ld d, a
    jr c, Jump_03A_655A
    ld a, d
    ld [hl-], a
    ld [hl], e
    or a, e
    jr nz, Jump_03A_657D
    inc hl

Jump_03A_655A::
    ld a, [hl-]
    ld b, a
    ld c, [hl]
    xor a, a
    ld [hl+], a
    ld [hl], a
    ld a, [wBattleActor]
    call SetBit2OfWD095Indexed_Bank3A
    ld a, [wD868]
    push af
    farcall DefeatTarget
    pop af
    ld [wD868], a
    xor a, a
    ld [wDABE], a
    ld a, $01
    ld [wD871], a

Jump_03A_657D::
    ld a, [wBattleActor]
    call SetBit0OfWD095Indexed_Bank3A
    ret

; entry 3 of the `rst $00` table in RunBattleActions_Case09
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleSubPhase, wBattleResolveStep
; points at: wBattleResolveStep
RunBattleActions_Case09_Case03::
Jump_03A_6584:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    farcall BlankTargetMonsterPicture
    ld d, $90
    farcall ShowBattleText
    call CheckActionBDOrRun63B2And63D2
    ret nc
    ld a, $0A
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    ret

; entry 4 of the `rst $00` table in RunBattleActions_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: wC58A, wD043, wD04B
; writes: wBattleResolveStep, wStringIndex, wStringCategory, wBattleStep, wBattleSubPhase
; points at: wBattleActor, wDA5B, wD891, wBattleResolveStep, wC130
RunBattleActions_Case09_Case04::
Jump_03A_65A4:: ; address name
    ld hl, wBattleActor
    inc [hl]
    ld a, [hl]
    cp a, $08
    jr z, Jump_03A_65B8
    call CarryUnlessWDA63SlotEmpty
    jr c, RunBattleActions_Case09_Case04
    ld a, $01
    ld [wBattleResolveStep], a
    ret

Jump_03A_65B8::
    ld hl, wDA5B
    ld bc, $0008
    ld a, $FF
    call FillBytes
    ld b, $03
    ld c, $00
    ld d, $00
    call SetWDA5BForPresentSlots
    ld b, $01
    ld d, $01
    call SetWDA5BForPresentSlots
    ld b, $03
    ld c, $04
    ld d, $00
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_03A_65E2
    ld d, $01

Jump_03A_65E2::
    call SetWDA5BForPresentSlots
    ld b, $01
    ld d, $01
    call SetWDA5BForPresentSlots
    ld hl, wD891
    ld a, [hl]
    cp a, $FF
    jr z, Jump_03A_65F5
    inc [hl]

Jump_03A_65F5::
    ld a, [wC58A]
    or a, a
    jr z, Jump_03A_6631
    cp a, $02
    jr z, Jump_03A_6631
    ld a, [wD043]
    or a, a
    jr z, Jump_03A_6631
    ld a, [wD04B]
    bit 7, a
    jr z, Jump_03A_6631
    res 7, a
    sub a, [hl]
    jr nc, Jump_03A_6619
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, $62
    jr Jump_03A_663E

Jump_03A_6619::
    inc a
    ld c, a
    ld b, $00
    ld hl, wC130
    call RunBattleActions_Case09_Case04_Sub01
    ld hl, wC130
    ld a, [hl]
    cp a, $01
    ld a, $61
    jr nz, Jump_03A_662F
    ld a, $88

Jump_03A_662F::
    jr Jump_03A_663E

Jump_03A_6631::
    xor a, a
    ld [wBattleStep], a
    xor a, a
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    ret

Jump_03A_663E::
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; C = first slot, B = count, D = value: wDA5B[slot] = D for every present slot in the range (CarryUnlessWDA63SlotEmpty) (E-0113)
; 4 call sites from 1 routine (e.g. RunBattleActions_Case09_Case04)
; points at: wDA5B
SetWDA5BForPresentSlots::
Func_03A_6650:: ; address name
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_03A_6660
    ld a, c
    ld hl, wDA5B
    add_a_to_hl
    ld [hl], d

Jump_03A_6660::
    inc c
    dec b
    jr nz, SetWDA5BForPresentSlots
    ret

; entry 5 of the `rst $00` table in RunBattleActions_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B
; writes: wBattleStep, wBattleSubPhase, wBattleResolveStep
RunBattleActions_Case09_Case05::
Jump_03A_6665:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    xor a, a
    ld [wBattleStep], a
    xor a, a
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    ret

; entry 6 of the `rst $00` table in RunBattleActions_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B
; writes: wBattlePhase, wBattleStep, wBattleSubPhase, wBattleResolveStep, wD092
RunBattleActions_Case09_Case06::
Jump_03A_6677:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    ld a, $02
    ld [wBattlePhase], a
    ld a, $08
    ld [wBattleStep], a
    xor a, a
    ld [wBattleSubPhase], a
    ld [wBattleResolveStep], a
    ld a, $80
    ld [wD092], a
    ld a, $42
    call QueueMusic
    ret

; entry 10 of the `rst $00` table in RunBattleActions
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleStep, wBattleSubPhase, wBattleResolveStep
; points at: wBattlePhase
RunBattleActions_Case0A::
Jump_03A_6698:: ; address name
    ld hl, wBattlePhase
    inc [hl]
    xor a, a
    ld [wBattleStep], a
    xor a, a
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    ret

; for each shown slot redraws the HP, MP and status parts flagged in bits 0-2 of wD095[slot] and clears the flags (E-0127)
; 2 call sites from 2 routines (e.g. RunBattleActions, RunBattleStep4)
; reads: wC58A, wC57F, wD88F
; points at: wD095
RedrawChangedSlotPanels::
Func_03A_66A9:: ; address name
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_03A_66B7
    ld a, [wC57F]
    bit 1, a
    jr nz, Jump_03A_66BF

Jump_03A_66B7::
    ld a, [wD88F]
    ld b, a
    ld c, $00
    jr Jump_03A_66C5

Jump_03A_66BF::
    ld a, [wD88F]
    ld b, a
    ld c, $04

Jump_03A_66C5::
    push bc
    ld a, c
    ld hl, wD095
    add_a_to_hl
    bit 0, [hl]
    jr z, Jump_03A_66E3
    push hl
    farcall DrawSlotHPDigits
    farcall CopySlotPanelPart7AC8ToVRAM
    pop hl
    res 0, [hl]

Jump_03A_66E3::
    bit 1, [hl]
    jr z, Jump_03A_66F7
    push hl
    farcall DrawSlotMPDigits
    farcall CopySlotPanelPart7ACEToVRAM
    pop hl
    res 1, [hl]

Jump_03A_66F7::
    bit 2, [hl]
    jr z, Jump_03A_670B
    push hl
    farcall DrawSlotStatusMarks
    farcall CopySlotPanelRowToVRAM
    pop hl
    res 2, [hl]

Jump_03A_670B::
    pop bc
    inc c
    dec b
    jr nz, Jump_03A_66C5
    ret

; only called from RunBattleStep4_Case03 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleStep4_Case03)
; reads: wBattleActor
; writes: wBattleTarget, wBattleSubPhase, wBattleResolveStep
; points at: wBattleTargetChoice
RunBattleStep4_Case03_Sub01::
Func_03A_6711:: ; address name
    call RunBattleStep4_Case03_Sub01_Sub01
    ret z
    ld a, c
    ld [wBattleTarget], a
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld [hl], c
    ld a, $01
    ld [wBattleSubPhase], a
    ld a, $00
    ld [wBattleResolveStep], a
    ret

; only called from RunBattleStep4_Case03_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleStep4_Case03_Sub01)
; reads: wDABA, wBattleActionId, wBattleActor
; writes: wDABA, wC982, wC983, wBattleSubPhase, wBattleResolveStep, wBattleSubStep
; points at: wBattleSubPhase, wCFCF
RunBattleStep4_Case03_Sub01_Sub01::
Func_03A_6731:: ; address name
    ld a, [wDABA]
    bit 7, a
    jr nz, Jump_03A_6743
    call RunBattleStep4_Case03_Sub01_Sub01_Sub01
    ld a, [wDABA]
    or a, $80
    ld [wDABA], a

Jump_03A_6743::
    call RunBattleStep4_Case03_Sub01_Sub01_Sub02
    ld a, [wDABA]
    and a, $7F
    ret nz
    ld a, [wBattleActionId]
    cp a, $15
    jr z, Jump_03A_676F
    cp a, $20
    jr z, Jump_03A_676F
    cp a, $7B
    jr z, Jump_03A_676F
    cp a, $D6
    jr z, Jump_03A_6765
    ld hl, wBattleSubPhase
    inc [hl]
    jr Jump_03A_6783

Jump_03A_6765::
    ld a, [wBattleActor]
    ld [wC982], a
    xor a, a
    ld [wC983], a

Jump_03A_676F::
    ld a, $01
    ld [wBattleSubPhase], a
    ld a, $0E
    ld [wBattleResolveStep], a
    ld a, $00
    ld [wBattleSubStep], a
    ld hl, wCFCF
    set 0, [hl]

Jump_03A_6783::
    xor a, a
    ret

; only called from RunBattleStep4_Case03_Sub01_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleStep4_Case03_Sub01_Sub01)
; reads: wCFF2, wBattleTarget, wBattleActionId
; points at: wDABA
RunBattleStep4_Case03_Sub01_Sub01_Sub01::
Func_03A_6785:: ; address name
    ld b, $04
    ld a, [wCFF2]
    cp a, $80
    jr nz, Jump_03A_6790
    ld b, $08

Jump_03A_6790::
    ld a, [wBattleTarget]
    and a, $04
    ld c, a

Jump_03A_6796::
    ld a, [wBattleTarget]
    cp a, c
    jr z, Jump_03A_67B9
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr nc, Jump_03A_67B9
    jr z, Jump_03A_67BD
    ld a, [wBattleActionId]
    cp a, $20
    jr z, Jump_03A_67B9
    cp a, $7B
    jr z, Jump_03A_67B9
    cp a, $CE
    jr z, Jump_03A_67B9
    cp a, $BB
    jr z, Jump_03A_67B9
    jr Jump_03A_67BD

Jump_03A_67B9::
    ld hl, wDABA
    inc [hl]

Jump_03A_67BD::
    inc c
    dec b
    ld a, [wCFF2]
    cp a, $80
    jr nz, Jump_03A_67D3
    ld a, b
    cp a, $04
    jr nz, Jump_03A_67D3
    ld a, [wBattleTarget]
    and a, $04
    xor a, $04
    ld c, a

Jump_03A_67D3::
    ld a, b
    or a, a
    jr nz, Jump_03A_6796
    ret

; only called from RunBattleStep4_Case03_Sub01_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleStep4_Case03_Sub01_Sub01)
; reads: wBattleTarget, wCFF2, wBattleActionId
; points at: wDABA
RunBattleStep4_Case03_Sub01_Sub01_Sub02::
Func_03A_67D8:: ; address name
    ld a, [wBattleTarget]
    inc a
    ld c, a
    ld hl, wDABA
    dec [hl]
    ld a, [hl]
    and a, $7F
    ret z

Jump_03A_67E5::
    ld a, [wCFF2]
    cp a, $80
    jr nz, Jump_03A_67FB
    ld a, c
    and a, $03
    jr nz, Jump_03A_67FB
    ld a, [wBattleTarget]
    and a, $04
    xor a, $04
    ld c, a
    jr nz, Jump_03A_67FB

Jump_03A_67FB::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    ret nc
    jr z, Jump_03A_6811
    ld a, [wBattleActionId]
    cp a, $20
    ret z
    cp a, $7B
    ret z
    cp a, $CE
    ret z
    cp a, $BB
    ret z

Jump_03A_6811::
    inc c
    jr Jump_03A_67E5

; unless bit 7 of wDABA is set, rolls 1-4 (1-3 for foes outside link battles; doubled for action other than $4E) into wDABA with bit 7 set (E-0126)
; 2 call sites from 2 routines (e.g. RunBattleStep4_Case03, RunBattleActions_Case03)
; reads: wDABA, wC58A, wBattleActor, wBattleActionId, wBattleTarget
; writes: wDABA, wBattleTarget, wBattleSubPhase, wBattleResolveStep
; points at: wDABA, wDAD8, wBattleSubPhase
RollRepeatCountForAction::
Func_03A_6814:: ; address name
    ld a, [wDABA]
    bit 7, a
    jp nz, Jump_03A_6877
    ld hl, $0001
    ld bc, $0004
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_03A_6832
    ld a, [wBattleActor]
    cp a, $04
    jr c, Jump_03A_6832
    ld c, $03

Jump_03A_6832::
    ld a, [wBattleActionId]
    cp a, $4E
    jr z, Jump_03A_683B
    sla c

Jump_03A_683B::
    call RandomInRange
    ld a, e
    or a, $80
    ld [wDABA], a
    jr Jump_03A_688F

; 2 call sites from 2 routines (e.g. RunBattleStep4_Case03, RunBattleActions_Case03)
; reads: wBattleActor, wDABA, wBattleActionId, wBattleTarget
; writes: wDABA, wBattleSubPhase, wBattleResolveStep, wBattleTarget
; points at: wBattleSubPhase, wDAD8, wDABA
Func_03A_6846::
    ld a, [wBattleActor]
    call CarryUnlessWDA63SlotEmpty
    jr nc, Jump_03A_6855
    ld a, $80
    ld [wDABA], a
    jr Jump_03A_68A4

Jump_03A_6855::
    ld a, [wDABA]
    bit 7, a
    jp nz, Jump_03A_6877
    ld a, [wBattleActionId]
    cp a, $63
    ld a, $81
    jr z, Jump_03A_6868
    ld a, $83

Jump_03A_6868::
    ld [wDABA], a
    jr nz, Jump_03A_68A9
    ld a, [wBattleTarget]
    call CarryUnlessWDA63SlotEmpty
    jr nc, Jump_03A_6899
    jr Jump_03A_68A4

Jump_03A_6877::
    ld hl, wDABA
    dec [hl]
    ld a, [hl]
    and a, $7F
    jr z, Jump_03A_68A4
    ld a, [wBattleActionId]
    cp a, $63
    jr nz, Jump_03A_68A9
    ld a, [wBattleTarget]
    call CarryUnlessWDA63SlotEmpty
    jr nc, Jump_03A_6899

Jump_03A_688F::
    farcall ChooseTargetForActor
    ld a, d
    ld [wBattleTarget], a

Jump_03A_6899::
    ld a, $01
    ld [wBattleSubPhase], a
    ld a, $01
    ld [wBattleResolveStep], a
    ret

Jump_03A_68A4::
    ld hl, wBattleSubPhase
    inc [hl]
    ret

Jump_03A_68A9::
    ld a, [wBattleActor]
    ld hl, wDAD8
    add_a_to_hl
    push hl
    ld a, [hl]
    push af
    or a, $80
    ld [hl], a
    farcall ChooseTargetForActor
    ld a, d
    ld [wBattleTarget], a
    pop af
    pop hl
    ld [hl], a
    jr Jump_03A_6899

; battle fight step 4: the same prologue as RunBattleActions, then its own sub-steps (not seen in the first battle)
; 2 call sites from 2 routines (e.g. BattleFight_Step4, RunBattlePhaseWhenTextIdle_A0_Case01_Case04)
; reads: wC52B, wD802, wC58A, wBattleSubPhase
RunBattleStep4::
Func_03A_68C9:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    call RedrawChangedSlotPanels
    ld a, [wD802]
    cp a, $FF
    jr z, Jump_03A_68E4
    ld a, [wC58A]
    or a, a
    ret nz
    farcall Func_03A_4ADB
    ret

Jump_03A_68E4::
    ld a, [wBattleSubPhase]
    rst $00
    dw RunBattleStep4_Case00
    dw RunBattleStep4_Case01
    dw RunBattleStep4_Case02
    dw RunBattleStep4_Case03
    dw RunBattleStep4_Case04
    dw RunBattleStep4_Case05

; entry 0 of the `rst $00` table in RunBattleStep4
; no direct call (reached through a table, a jump or a vector)
RunBattleStep4_Case00::
Jump_03A_68F4:: ; address name
    farcall RunBattleStep4_Case00_Sub01
    ret

; entry 1 of the `rst $00` table in RunBattleStep4
; no direct call (reached through a table, a jump or a vector)
RunBattleStep4_Case01::
Jump_03A_68FB:: ; address name
    farcall RunBattleResolveStep
    ret

; entry 2 of the `rst $00` table in RunBattleStep4
; no direct call (reached through a table, a jump or a vector)
RunBattleStep4_Case02::
Jump_03A_6902:: ; address name
    call RunBattleResolveStep_69AA
    ret

; entry 3 of the `rst $00` table in RunBattleStep4
; no direct call (reached through a table, a jump or a vector)
; reads: wCFF2, wBattleActionId, wBattleActor
; points at: wBattleSubPhase, wD812
RunBattleStep4_Case03::
Jump_03A_6906:: ; address name
    ld a, [wCFF2]
    and a, $0F
    cp a, $02
    jr z, Jump_03A_691F
    cp a, $04
    jr z, Jump_03A_6923
    ld a, [wBattleActionId]
    cp a, $63
    jr z, Jump_03A_6940
    ld hl, wBattleSubPhase
    inc [hl]
    ret

Jump_03A_691F::
    call RunBattleStep4_Case03_Sub01
    ret

Jump_03A_6923::
    ld a, [wBattleActionId]
    cp a, $64
    jr z, Jump_03A_6940
    ld a, [wBattleActor]
    ld hl, wD812
    call AddAx9ToHL
    bit 0, [hl]
    jr nz, Jump_03A_693C
    ld hl, wBattleSubPhase
    inc [hl]
    ret

Jump_03A_693C::
    call RollRepeatCountForAction
    ret

Jump_03A_6940::
    call Func_03A_6846
    ret

; entry 4 of the `rst $00` table in RunBattleStep4
; no direct call (reached through a table, a jump or a vector)
RunBattleStep4_Case04::
Jump_03A_6944:: ; address name
    call RunActionSpecificPostStep
    ret

; entry 5 of the `rst $00` table in RunBattleStep4
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wBattleTarget, wC970
; writes: wBattleActor, wBattleTarget, wDABA, wDABD, wBattleSubPhase, wBattleResolveStep, wBattleSubStep, wC970
; points at: wDAC9, wBattleActionChoice, wDA5B, wBattleStep
RunBattleStep4_Case05::
Jump_03A_6948:: ; address name
    ld hl, wDAC9
    ld a, [hl+]
    ld [wBattleActor], a
    ld a, [hl+]
    ld [wBattleTarget], a
    ld a, [hl+]
    ld [wDABA], a
    ld a, [wBattleActor]
    ld de, wBattleActionChoice
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_03A_6963
    inc d

Jump_03A_6963::
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    ld a, [wBattleTarget]
    ld de, wBattleActionChoice
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_03A_6974
    inc d

Jump_03A_6974::
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    ld a, [wBattleTarget]
    ld de, wDA5B
    add a, e
    ld e, a
    jr nc, Jump_03A_6984
    inc d

Jump_03A_6984::
    ld a, [hl]
    ld [de], a
    xor a, a
    ld [wDABD], a
    ld hl, wBattleStep
    dec [hl]
    ld a, $03
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleSubStep], a
    ld a, [wC970]
    or a, a
    ret z
    xor a, a
    ld [wC970], a
    ld a, $06
    ld [wBattleSubPhase], a
    ret

; runs the routine for wBattleResolveStep (jump table of ten) (E-0122)
; 2 call sites from 2 routines (e.g. RunBattleStep4_Case02, RunBattleActions_Case02)
; reads: wBattleResolveStep
RunBattleResolveStep_69AA::
Func_03A_69AA:: ; address name
    ld a, [wBattleResolveStep]
    rst $00
    dw RunBattleResolveStep_69AA_Case00
    dw RunBattleResolveStep_69AA_Case01
    dw RunBattleResolveStep_69AA_Case02
    dw RunBattleResolveStep_69AA_Case03
    dw RunBattleResolveStep_69AA_Case04
    dw RunBattleResolveStep_69AA_Case05
    dw RunBattleResolveStep_69AA_Case06
    dw RunBattleResolveStep_69AA_Case07
    dw RunBattleResolveStep_69AA_Case08
    dw RunBattleResolveStep_69AA_Case09

; entry 0 of the `rst $00` table in RunBattleResolveStep_69AA
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wCFF5, wDABD, wDAC0, wBattleDamageLo, wD873, wRecordBufferData, wCFF3, ...
; writes: wBattleDamageLo, wD873, wD868, wDAD2, wBattleSubStep, wBattleTarget, wBattleActor
; points at: wBattleResolveStep, wD80E, wBattleMP, wBattleStatus, wDA5B, wD813, wD854, wBattleActor
RunBattleResolveStep_69AA_Case00::
Jump_03A_69C2:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wBattleTarget]
    ld hl, wD80E
    call AddAx9ToHL
    bit 0, [hl]
    jp z, RunBattleResolveStep_69AA_Case01
    ld a, [wBattleTarget]
    call CarryUnlessWDA63SlotEmpty
    jp c, RunBattleResolveStep_69AA_Case01
    ld a, [wCFF5]
    bit 0, a
    jr z, RunBattleResolveStep_69AA_Case01
    ld a, [wDABD]
    bit 2, a
    jr z, Jump_03A_69F2
    ld a, [wDAC0]
    bit 4, a
    jr z, RunBattleResolveStep_69AA_Case01

Jump_03A_69F2::
    ld a, [wBattleTarget]
    call GetBattleMaxMP_Bank3A
    push hl
    ld a, [wBattleTarget]
    call GetBattleMP_Bank3A
    pop bc
    call CompareHLToBC
    jr z, RunBattleResolveStep_69AA_Case01
    ld a, [wBattleDamageLo]
    ld e, a
    ld a, [wD873]
    ld d, a
    push de
    ld a, [wRecordBufferData]
    ld e, a
    ld d, $00
    ld a, e
    ld [wBattleDamageLo], a
    ld a, d
    ld [wD873], a
    add hl, de
    call CompareHLToBC
    jr c, Jump_03A_6A3A
    jr z, Jump_03A_6A3A
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    ld a, e
    sub a, l
    ld e, a
    ld a, d
    sbc a, h
    ld d, a
    ld a, e
    ld [wBattleDamageLo], a
    ld a, d
    ld [wD873], a
    ld h, b
    ld l, c

Jump_03A_6A3A::
    push hl
    ld a, [wBattleTarget]
    ld hl, wBattleMP
    call AddDoubleAToHL_Bank3A
    pop bc
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [wBattleTarget]
    call SetBit1OfWD095Indexed_Bank3A
    ld d, $40
    farcall ShowBattleText
    pop de
    ld a, e
    ld [wBattleDamageLo], a
    ld a, d
    ld [wD873], a
    ret

; entry 1 of the `rst $00` table in RunBattleResolveStep_69AA
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wCFF5, wDAC0, wDABD, wCFF3, wBattleActor, wBattleDamageLo, wD873, ...
; writes: wD868, wBattleDamageLo, wD873, wDAD2, wBattleSubStep, wBattleTarget, wBattleActor
; points at: wBattleResolveStep, wBattleStatus, wDA5B, wD813, wD854, wBattleActor
RunBattleResolveStep_69AA_Case01::
Jump_03A_6A60:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wBattleTarget]
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_03A_6AB6
    ld a, [wCFF5]
    bit 3, a
    jr z, Jump_03A_6AB6
    ld a, [wDAC0]
    bit 4, a
    jr z, Jump_03A_6AB6
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    and a, $90
    jr z, Jump_03A_6AB6
    push hl
    call AdvanceRandom
    call RollRandomBelowTargetThreshold
    pop hl
    jr nc, Jump_03A_6AB6
    bit 7, [hl]
    jr z, RunBattleResolveStep_69AA_Case02
    ld a, [hl]
    and a, $73
    ld [hl], a
    ld a, [wBattleTarget]
    ld hl, wDA5B
    add_a_to_hl
    ld [hl], $03
    ld a, [wBattleTarget]
    call SetBit2OfWD095Indexed_Bank3A
    ld d, $82
    farcall ShowBattleText
    ret

Jump_03A_6AB6::
    ld hl, wBattleResolveStep
    inc [hl]
    jr RunBattleResolveStep_69AA_Case03

; entry 2 of the `rst $00` table in RunBattleResolveStep_69AA
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wDABD, wCFF3, wBattleActor, wDAC0, wBattleDamageLo, wD873, wDAD2, ...
; writes: wD868, wBattleDamageLo, wD873, wDAD2, wBattleSubStep, wBattleTarget, wBattleActor
; points at: wBattleResolveStep, wBattleStatus, wDA5B, wD813, wD854, wBattleActor
RunBattleResolveStep_69AA_Case02::
Jump_03A_6ABC:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    bit 4, [hl]
    jr z, RunBattleResolveStep_69AA_Case03
    res 4, [hl]
    ld a, [wBattleTarget]
    ld hl, wDA5B
    add_a_to_hl
    ld [hl], $03
    ld a, [wBattleTarget]
    call SetBit2OfWD095Indexed_Bank3A
    ld d, $83
    farcall ShowBattleText
    ret

; entry 3 of the `rst $00` table in RunBattleResolveStep_69AA
; no direct call (reached through a table, a jump or a vector)
; reads: wDABD, wBattleTarget, wCFF3, wBattleActor, wDAC0, wBattleDamageLo, wD873, wDAD2, ...
; writes: wD868, wBattleDamageLo, wD873, wDAD2, wBattleSubStep, wBattleTarget, wBattleActor
; points at: wBattleResolveStep, wD813, wD854, wBattleActor
RunBattleResolveStep_69AA_Case03::
Jump_03A_6AEC:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    call CheckActionBDOrRun63B2And63D2
    jr nc, RunBattleResolveStep_69AA_Case04
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in RunBattleResolveStep_69AA
; no direct call (reached through a table, a jump or a vector)
; reads: wDABD, wBattleTarget, wCFF3, wBattleActor, wDAC0, wBattleDamageLo, wD873, wDAD2, ...
; writes: wD868, wBattleDamageLo, wD873, wDAD2, wBattleSubStep, wBattleTarget, wBattleActor
; points at: wD813, wD854, wBattleActor, wBattleResolveStep
RunBattleResolveStep_69AA_Case04::
Jump_03A_6AFE:: ; address name
    ld a, [wDABD]
    or a, a
    jp nz, Jump_03A_6BE8
    ld a, [wBattleTarget]
    ld hl, wD813
    call AddAx9ToHL
    bit 2, [hl]
    jp z, Jump_03A_6BE8
    ld a, [wCFF3]
    bit 7, a
    jp z, Jump_03A_6BE8
    ld a, [wBattleActor]
    call CarryUnlessWDA63SlotEmpty
    jp c, Jump_03A_6BE8
    ld a, [wBattleTarget]
    call CheckSlotStatusBlock
    jp c, Jump_03A_6BE8
    ld a, [wDAC0]
    bit 4, a
    jp z, Jump_03A_6BE8
    ld a, [wBattleTarget]
    ld hl, wD854
    call AddDoubleAToHL_Bank3A
    ld a, [hl]
    and a, $08
    ld [wD868], a
    push hl
    ld a, [wBattleTarget]
    ld hl, wD813
    call AddAx9ToHL
    bit 3, [hl]
    jr z, Jump_03A_6B66
    pop hl
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wD873]
    ld h, a
    add hl, hl
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    jr Jump_03A_6B7B

Jump_03A_6B66::
    pop hl
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wD873]
    ld h, a
    srl h
    rr l
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a

Jump_03A_6B7B::
    ld a, h
    or a, l
    jr z, Jump_03A_6B86
    ld a, $11
    ld [wDAD2], a
    jr Jump_03A_6B8B

Jump_03A_6B86::
    ld a, $10
    ld [wDAD2], a

Jump_03A_6B8B::
    ld hl, wBattleActor
    ld a, [hl+]
    push af
    ld a, [hl-]
    ld [hl+], a
    pop af
    ld [hl], a
    ld a, [wDAD2]
    bit 0, a
    jr z, Jump_03A_6BB9
    ld a, [wD868]
    or a, a
    jr z, Jump_03A_6BAB
    ld d, $31
    farcall ShowBattleTextCategory0
    jr Jump_03A_6BCF

Jump_03A_6BAB::
    call AdvanceRandom
    ld a, [wC5E7]
    and a, $01
    jr nz, Jump_03A_6BB9
    ld d, $7C
    jr Jump_03A_6BBB

Jump_03A_6BB9::
    ld d, $7D

Jump_03A_6BBB::
    farcall ShowBattleText
    ld a, [wDAD2]
    bit 0, a
    jr z, Jump_03A_6BD8
    ld a, [wC5E7]
    and a, $01
    jr nz, Jump_03A_6BD8

Jump_03A_6BCF::
    ld hl, wBattleResolveStep
    inc [hl]
    xor a, a
    ld [wBattleSubStep], a
    ret

Jump_03A_6BD8::
    ld a, [wBattleActor]
    ld l, a
    ld a, [wBattleTarget]
    ld h, a
    ld a, l
    ld [wBattleTarget], a
    ld a, h
    ld [wBattleActor], a

Jump_03A_6BE8::
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in RunBattleResolveStep_69AA
; no direct call (reached through a table, a jump or a vector)
RunBattleResolveStep_69AA_Case05::
Jump_03A_6BF1:: ; address name
    farcall RunBattleSubStep_6662
    ret

; entry 6 of the `rst $00` table in RunBattleResolveStep_69AA
; no direct call (reached through a table, a jump or a vector)
; reads: wDAD1, wBattleActor, wBattleStep, wDABD, wBattleTarget, wDABE
; writes: wBattleTarget, wDAD1, wDABD, wBattleActor, wDABA
; points at: wBattleResolveStep, wBattleTargetChoice, wDAC9, wBattleActionChoice
RunBattleResolveStep_69AA_Case06::
Jump_03A_6BF8:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wDAD1]
    cp a, $FF
    jr z, Jump_03A_6C17
    ld [wBattleTarget], a
    ld b, a
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    call AddDoubleAToHL_Bank3A
    ld [hl], b
    ld a, $FF
    ld [wDAD1], a
    ret

Jump_03A_6C17::
    ld a, [wBattleStep]
    cp a, $04
    jr z, RunBattleResolveStep_69AA_Case07
    ld a, [wDABD]
    or a, a
    jr z, RunBattleResolveStep_69AA_Case07
    xor a, a
    ld [wDABD], a
    ld hl, wDAC9
    ld a, [hl+]
    ld [wBattleActor], a
    ld a, [hl+]
    ld [wBattleTarget], a
    ld a, [hl+]
    ld [wDABA], a
    ld a, [wBattleActor]
    ld de, wBattleActionChoice
    call RunBattleResolveStep_69AA_Case06_Sub01
    ld a, [wBattleTarget]
    ld de, wBattleActionChoice

; only called from RunBattleResolveStep_69AA_Case06 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleResolveStep_69AA_Case06)
RunBattleResolveStep_69AA_Case06_Sub01::
Func_03A_6C46:: ; address name
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_03A_6C4C
    inc d

Jump_03A_6C4C::
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    ret

; entry 7 of the `rst $00` table in RunBattleResolveStep_69AA
; no direct call (reached through a table, a jump or a vector)
; reads: wDABE
; points at: wBattleResolveStep
RunBattleResolveStep_69AA_Case07::
Jump_03A_6C52:: ; address name
    ld a, [wDABE]
    or a, a
    call nz, RunWDABEMinus1Step
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 8 of the `rst $00` table in RunBattleResolveStep_69AA
; no direct call (reached through a table, a jump or a vector)
; writes: wDABA, wBattleSubPhase, wBattleResolveStep
; points at: wBattleResolveStep
RunBattleResolveStep_69AA_Case08::
Jump_03A_6C5E:: ; address name
    call CheckActionBDOrRun63B2And63D2
    jr c, Jump_03A_6C68
    ld hl, wBattleResolveStep
    inc [hl]
    ret

Jump_03A_6C68::
    xor a, a
    ld [wDABA], a
    ld a, $04
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    ret

; entry 9 of the `rst $00` table in RunBattleResolveStep_69AA
; no direct call (reached through a table, a jump or a vector)
RunBattleResolveStep_69AA_Case09::
Jump_03A_6C76:: ; address name
    call RunBattleResolveStep_69AA_Case09_Sub01
    ret

; carry when wC5E7 is below $40 (a foe target outside link battles) or $80 (otherwise) (E-0122)
; 1 call site from 1 routine (e.g. RunBattleResolveStep_69AA_Case01)
; reads: wC58A, wBattleTarget, wC5E7
RollRandomBelowTargetThreshold::
Func_03A_6C7A:: ; address name
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_03A_6C8C
    ld a, [wBattleTarget]
    cp a, $04
    jr c, Jump_03A_6C8C
    ld b, $40
    jr Jump_03A_6C8E

Jump_03A_6C8C::
    ld b, $80

Jump_03A_6C8E::
    ld a, [wC5E7]
    cp a, b
    ret

; runs the routine for wDABE - 1 (jump table of ten) (E-0122)
; 1 call site from 1 routine (e.g. RunBattleResolveStep_69AA_Case07)
; reads: wDABE
RunWDABEMinus1Step::
Func_03A_6C93:: ; address name
    ld a, [wDABE]
    dec a
    rst $00
    dw RunWDABEMinus1Step_Case00
    dw RunWDABEMinus1Step_Case01
    dw RunWDABEMinus1Step_Case02
    dw RunWDABEMinus1Step_Case03
    dw RunWDABEMinus1Step_Case03
    dw RunWDABEMinus1Step_Case03
    dw RunWDABEMinus1Step_Case03
    dw RunWDABEMinus1Step_Case03
    dw RunWDABEMinus1Step_Case08
    dw RunWDABEMinus1Step_Case03

; entry 0 of the `rst $00` table in RunWDABEMinus1Step
; no direct call (reached through a table, a jump or a vector)
; writes: wDABE
RunWDABEMinus1Step_Case00::
Jump_03A_6CAC:: ; address name
    call TargetOnLocalSide_Bank3A
    ld d, $85
    jr c, Jump_03A_6CC9
    ld d, $E8
    jr Jump_03A_6CC9

; entry 1 of the `rst $00` table in RunWDABEMinus1Step
; no direct call (reached through a table, a jump or a vector)
; writes: wDABE
RunWDABEMinus1Step_Case01::
Jump_03A_6CB7:: ; address name
    call TargetOnLocalSide_Bank3A
    ld d, $80
    jr c, Jump_03A_6CC9
    ld d, $E7
    jr Jump_03A_6CC9

; entry 2 of the `rst $00` table in RunWDABEMinus1Step
; no direct call (reached through a table, a jump or a vector)
; writes: wDABE
RunWDABEMinus1Step_Case02::
Jump_03A_6CC2:: ; address name
    ld d, $AC
    jr Jump_03A_6CC9

; entry 3 of the `rst $00` table in RunWDABEMinus1Step
; no direct call (reached through a table, a jump or a vector)
RunWDABEMinus1Step_Case03::
Jump_03A_6CC6:: ; address name
    ret

; entry 8 of the `rst $00` table in RunWDABEMinus1Step
; no direct call (reached through a table, a jump or a vector)
; writes: wDABE
RunWDABEMinus1Step_Case08::
Jump_03A_6CC7:: ; address name
    ld d, $7F

Jump_03A_6CC9::
    farcall ShowBattleText
    xor a, a
    ld [wDABE], a
    ret

; only called from RunBattleResolveStep_69AA_Case09 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleResolveStep_69AA_Case09)
; reads: wBattleStep, wDABD, wBattleTarget, wCFF5, wBattleActionId, wBattleActor, wC981, wDAC0
; writes: wBattleSubPhase, wBattleResolveStep, wBattleSubStep, wC981, wDABD
; points at: wD812, wBattleStep, wBattleSubPhase
RunBattleResolveStep_69AA_Case09_Sub01::
Func_03A_6CD4:: ; address name
    ld a, [wBattleStep]
    cp a, $04
    jr z, Jump_03A_6D45
    ld a, [wDABD]
    or a, a
    jr nz, Jump_03A_6D39
    ld a, [wBattleTarget]
    call CheckSlotStatusBlockWide_Bank3A
    jr c, Jump_03A_6D45
    ld hl, wD812
    call AddAx9ToHL
    bit 3, [hl]
    jr z, Jump_03A_6D45
    ld a, [wCFF5]
    bit 2, a
    jr z, Jump_03A_6D3D
    ld a, [wBattleActionId]
    cp a, $6C
    jr nz, Jump_03A_6D11
    ld a, [wBattleActor]
    and a, $04
    ld l, a
    ld a, [wBattleTarget]
    and a, $04
    add a, l
    and a, $04
    jr z, Jump_03A_6D45

Jump_03A_6D11::
    ld a, [wC981]
    cp a, $01
    jr z, Jump_03A_6D45
    ld a, [wDAC0]
    bit 4, a
    jr z, Jump_03A_6D45
    ld d, $7A
    farcall ShowBattleText
    ld hl, wBattleStep
    inc [hl]
    xor a, a
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleSubStep], a
    xor a, a
    ret

Jump_03A_6D39::
    xor a, a
    ld [wDABD], a

Jump_03A_6D3D::
    ld d, $7B
    farcall ShowBattleText

Jump_03A_6D45::
    xor a, a
    ld [wC981], a
    ld hl, wBattleSubPhase
    inc [hl]
    xor a, a
    ld [wBattleResolveStep], a
    scf
    ret

; removes the first byte equal to C from the 8-byte queue at wD895, shifting later bytes down and filling with $FF (E-0124)
; no direct call (reached through a table, a jump or a vector)
; points at: wD895
RemoveCFromWD895Queue_3A:: ; heuristic: follows a terminator; C0
Func_03A_6D53:: ; address name
    ld hl, wD895
    ld b, $08
    ld d, $00

Jump_03A_6D5A::
    bit 0, d
    jr nz, Jump_03A_6D64
    ld a, [hl]
    cp a, c
    jr nz, Jump_03A_6D71
    ld d, $01

Jump_03A_6D64::
    inc hl
    ld a, [hl]
    ld [hl], $FF
    dec hl
    ld [hl], a
    inc hl
    dec b
    jr nz, Jump_03A_6D5A
    ld [hl], $FF
    ret

Jump_03A_6D71::
    inc hl
    dec b
    jr nz, Jump_03A_6D5A
    ret

; D = Data_03A_6DAA[wBattleActionId]; returns at once when it is $FF; for action $CF first runs Func_03A_6D91; then ShowBattleText (E-0118)
; 2 call sites from 2 routines (e.g. Func_032_4ADC_Case03, Func_032_5820_Case02)
; reads: wBattleActionId
; writes: wStringIndex, wStringCategory
ShowActionBattleTextFrom6DAA::
Func_03A_6D76:: ; address name
    ld a, [wBattleActionId]
    ld hl, Data_03A_6DAA
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    ret z
    ld d, a
    ld a, [wBattleActionId]
    cp a, $CF
    call z, ShowActionBattleTextFrom6DAA_Sub01
    jp ShowBattleText

; only called from ShowActionBattleTextFrom6DAA (E-0047)
; 1 call site from 1 routine (e.g. ShowActionBattleTextFrom6DAA)
; reads: wC5E7
; writes: wC96F
ShowActionBattleTextFrom6DAA_Sub01::
Func_03A_6D91:: ; address name
    call AdvanceRandom
    ld a, [wC5E7]
    cp a, $80
    jr c, Jump_03A_6DA2
    xor a, a
    ld [wC96F], a
    ld d, $91
    ret

Jump_03A_6DA2::
    ld a, $01
    ld [wC96F], a
    ld d, $D6
    ret

Data_03A_6DAA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00
    ds $3C, $01
    INCBIN "dwm2-cobi-us.gbc", $0EADE7, $AB

; D = Data_03A_6EA5[wBattleActionId]; returns at once when it is $FF, otherwise ShowBattleText (E-0116)
; 2 call sites from 2 routines (e.g. Func_03B_42F4_Case00, Func_03B_42F4_Case01)
; reads: wBattleActionId
; writes: wStringIndex, wStringCategory
ShowActionBattleText::
Func_03A_6E92:: ; address name
    ld a, [wBattleActionId]
    ld hl, Data_03A_6EA5
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    ret z
    ld d, a
    jp ShowBattleText

Data_03A_6EA5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $9F, $9F, $A2, $9F, $9F, $9F, $9F, $9F, $9F, $9F, $A1, $9F, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $94, $94, $94, $94, $94, $97, $99
    db $FF, $FF, $A5, $9B, $A4, $A3, $A6, $A7
    ds $10, $FF
    db $97, $FF, $FF, $FF, $0D, $A9, $28, $D6

; D = message index. The same as ShowBattleText, but it stores 0 in wStringCategory: the entry at Data_03A_6F06 + 2 * D is called first when non-zero, then BeginStringDisplay_Bank2F shows category 0 (E-0056)
; 22 call sites from 14 routines (e.g. RunBattleResolveStep_43C4_Case01, Func_032_4ADC_Case00_Case01, Func_032_4ADC_Case00_Case03, ShowActorStatusRecoveryMessage, ...)
; writes: wStringIndex, wStringCategory
ShowBattleTextCategory0::
Func_03A_6EE5:: ; address name
    push de
    ld hl, Data_03A_6F06
    ld c, d
    ld b, $00
    add hl, bc
    add hl, bc
    ld a, [hl+]
    or a, [hl]
    jr z, Jump_03A_6EF6
    dec hl
    call JumpToWordAtHL

Jump_03A_6EF6::
    pop af
    ld [wStringIndex], a
    ld a, $00
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ret

Data_03A_6F06:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_03A_7106
    dw Data_03A_7106
    dw Data_03A_7107
    dw Data_03A_7108
    dw Data_03A_7108
    dw Data_03A_7109
    dw Data_03A_710A
    dw Data_03A_710B
    dw Data_03A_710C
    dw Data_03A_710C
    INCBIN "dwm2-cobi-us.gbc", $0EAF1A, $F0
    ds $FC, $00

Data_03A_7106:: ; heuristic: target of a monotone pointer table; C0
    db $C9

Data_03A_7107:: ; heuristic: target of a monotone pointer table; C0
    db $C9

Data_03A_7108:: ; heuristic: target of a monotone pointer table; C0
    db $C9

Data_03A_7109:: ; heuristic: target of a monotone pointer table; C0
    db $C9

Data_03A_710A:: ; heuristic: target of a monotone pointer table; C0
    db $C9

Data_03A_710B:: ; heuristic: target of a monotone pointer table; C0
    db $C9

Data_03A_710C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EB10C, $87

; D = message index. If the 16-bit entry at Data_03A_71B4 + 2 * D is non-zero it is called first through Func_000_000B (a per-message routine, not read). Then it stores D in wStringIndex, 1 in wStringCategory and farcalls BeginStringDisplay_Bank2F: the battle text of bank $2F, category 1 (E-0056)
; 66 call sites from 56 routines (e.g. Func_032_4ADC_Case01_Case09, Func_032_4ADC_Case06_Case01, Func_032_4ADC_Case06_Case02, Func_032_4ADC_Case09_Case00, ...)
; writes: wStringIndex, wStringCategory
ShowBattleText::
Func_03A_7193:: ; address name
    push de
    ld hl, Data_03A_71B4
    ld c, d
    ld b, $00
    add hl, bc
    add hl, bc
    ld a, [hl+]
    or a, [hl]
    jr z, Jump_03A_71A4
    dec hl
    call JumpToWordAtHL

Jump_03A_71A4::
    pop af
    ld [wStringIndex], a
    ld a, $01
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ret

Data_03A_71B4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0EB1B4, $1C2
    dw Data_03A_73B4
    db $B4, $73
    dw Data_03A_73CB
    db $CB, $73
    dw Data_03A_73CB
    db $B8, $73
    dw Data_03A_73E0
    db $E0, $73
    dw Data_03A_73E0
    db $E0, $73
    dw Data_03A_74F7
    db $F7, $74
    dw Data_03A_74F7
    db $F7, $74
    dw Data_03A_74F7
    db $F7, $74
    dw Data_03A_74F7
    db $FE, $74
    dw Data_03A_74F7
    db $F7, $74
    dw Data_03A_74F7
    db $F7, $74
    dw Data_03A_74F7
    db $F7, $74
    dw Data_03A_74F7
    db $F7, $74, $00, $00, $00, $00, $BB, $74, $BB, $74, $00, $00

Data_03A_73B4:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $EE, $78, $C9, $FA, $A5, $D8, $FE, $03, $38, $0B, $CD, $E3, $7A, $78, $FE
    db $01, $20, $03, $CD, $27, $79, $C9

Data_03A_73CB:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $EE, $78, $CD, $1A, $79, $C9, $CD, $EE, $78, $CD, $34, $79, $C9, $CD, $27
    db $79, $CD, $4E, $79, $C9

Data_03A_73E0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EB3E0, $117

Data_03A_74F7:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $EE, $78, $CD, $08, $79, $C9, $CD, $41, $79, $CD, $EE, $78, $CD, $08, $79
    db $C9

; 4 call sites from 4 routines (e.g. ApplyActionResultAndMarkFormation, Func_032_4ADC_Case01_Case00, Func_032_4ADC_Case01_Case03, Func_032_5820_Case01)
; reads: wBattleActionId, wBattleActor, wC982
; writes: wC982, wD86C, wStringIndex, wStringCategory
; points at: wBattleTargetChoice, wC150
Func_03A_7508::
    push de
    ld a, [wBattleActionId]
    cp a, $D0
    jr nc, Jump_03A_7532
    xor a, a
    ld [wC982], a
    call CopyActorNameToWC130
    call CopyActionSkillNameToWC140
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld a, [hl]
    ld hl, wC150
    ld [wD86C], a
    call CopySlotNameToHL
    jr Jump_03A_753D

Jump_03A_7532::
    ld a, $01
    ld [wC982], a
    call CopyActorNameToWC130
    call CopyMappedSlotNameToWC140

Jump_03A_753D::
    pop de
    ld a, d
    cp a, $03
    jp z, Jump_03A_7570
    cp a, $04
    jp z, Jump_03A_7594
    cp a, $05
    jp z, Jump_03A_7580
    cp a, $06
    jp z, Jump_03A_7584
    ld a, [wBattleActionId]
    ld hl, Data_03A_7603
    add_a_to_hl
    ld a, [hl]
    ld hl, Data_03A_76E7
    dec d
    jr z, Jump_03A_7568
    ld hl, Data_03A_76FE

Jump_03A_7568::
    add_a_to_hl
    ld a, [hl]
    jr Jump_03A_75A4

Jump_03A_7570::
    ld a, [wC982]
    bit 0, a
    jr nz, Jump_03A_757B
    ld a, $49
    jr Jump_03A_75A4

Jump_03A_757B::
    ld hl, Data_03A_75C7
    jr Jump_03A_75B7

Jump_03A_7580::
    ld a, $4A
    jr Jump_03A_75A4

Jump_03A_7584::
    ld a, [wC982]
    bit 0, a
    jr nz, Jump_03A_758F
    ld a, $4B
    jr Jump_03A_75A4

Jump_03A_758F::
    ld hl, Data_03A_75DB
    jr Jump_03A_75B7

Jump_03A_7594::
    ld a, [wC982]
    bit 0, a
    jr nz, Jump_03A_759F
    ld a, $4C
    jr Jump_03A_75A4

Jump_03A_759F::
    ld hl, Data_03A_75EF
    jr Jump_03A_75B7

Jump_03A_75A4::
    cp a, $FF
    jr z, Jump_03A_75B6
    ld [wStringIndex], a
    ld a, $00
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F

Jump_03A_75B6::
    ret

Jump_03A_75B7::
    ld a, [wBattleActionId]
    sub a, $D0
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_03A_75A4
    ret

Data_03A_75C7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $6C, $6E, $FF, $FF, $FF, $FF, $70, $FF, $80, $72, $FF, $FF, $76, $FF, $FF, $78
    db $FF, $81, $FF, $FF

Data_03A_75DB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $74, $75, $FF, $FF, $82, $83
    db $FF, $7A, $FF, $FF

Data_03A_75EF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $6D, $6F, $FF, $FF, $FF, $FF, $71, $FF, $84, $73, $FF, $FF, $77, $FF, $FF, $79
    db $FF, $85, $FF, $FF

Data_03A_7603:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $3D, $00
    db $04, $04, $04, $01, $01, $01, $01, $01, $01, $01, $01, $04, $04, $11, $03, $10
    db $11, $06, $07
    ds $18, $03
    db $13, $08, $05, $03, $03, $03, $03, $03, $03, $01, $01, $01, $01, $09, $02, $02
    db $02, $02, $02, $02, $02, $02, $04, $04, $04, $04, $04, $04, $04, $03, $03, $03
    db $03, $12, $03, $03, $03, $03, $03, $03, $03, $04, $03, $0B, $03, $03, $03, $03
    db $03, $04, $04, $0D, $0F, $0A, $03, $03, $0C, $0E
    ds $2E, $00
    db $14, $14, $15, $15, $15, $15, $15, $15, $15, $16, $15, $15, $14, $15, $15, $15
    db $15, $15, $15, $15

Data_03A_76E7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $36, $37, $38, $46, $47, $39, $3A, $3B, $3C, $3D, $3E, $3F, $40, $41, $42, $43
    db $44, $45, $48, $FF, $69, $6A, $6B

Data_03A_76FE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $4D, $4F, $56, $4E, $50, $55, $51, $52, $54, $5F, $5A, $58, $5B, $59, $5C, $FF
    db $4D, $4E, $57, $53, $FF, $FF, $FF

; CopyActorNameToWC130 and CopyMappedSlotNameToWC140, then shows string Data_03A_7738[wBattleActionId - $D0] of category 0 (BeginStringDisplay_Bank2F); used for the $D0+ special actions (E-0118)
; 1 call site from 1 routine (e.g. ApplyActionResultAndMarkFormation)
; reads: wBattleActionId
; writes: wStringIndex, wStringCategory
ShowSpecialActionMessage::
Func_03A_7715:: ; address name
    call CopyActorNameToWC130
    call CopyMappedSlotNameToWC140
    ld a, [wBattleActionId]
    sub a, $D0
    ld hl, Data_03A_7738
    add_a_to_hl
    ld a, [hl]
    ld [wStringIndex], a
    ld a, $00
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ret

Data_03A_7738:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $66, $66, $67, $67, $67, $67, $67, $67, $67, $68, $67, $67, $66, $67, $67, $67
    db $67, $67, $67, $67

; only called from Call774CWithWD890 (E-0047)
; 1 call site from 1 routine (e.g. Call774CWithWD890)
; reads: hFFC6, wBattleTarget, wBattleStatResultLo
; writes: wBattleStatResultLo
; points at: wC0A0, wC0A8, wC130
Call774CWithWD890_Sub01::
Func_03A_774C:: ; address name
    ldh a, [hFFC6]
    ld b, a
    ld a, b
    cp a, $01
    jr z, Jump_03A_77CF
    xor a, a
    ld [wBattleStatResultLo], a
    ld a, [wBattleTarget]
    bit 2, a
    ld hl, wC0A0
    jr z, Jump_03A_7765
    ld hl, wC0A8

Jump_03A_7765::
    ld a, b
    sub a, $01
    ld e, a
    ld d, $01

Jump_03A_776B::
    ld a, b
    sub a, d
    ld c, a
    push hl
    push de
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a

Jump_03A_7774::
    ld a, e
    cp a, [hl]
    inc hl
    jr nz, Jump_03A_7784
    ld a, d
    cp a, [hl]
    jr nz, Jump_03A_7784
    ld a, [wBattleStatResultLo]
    inc a
    ld [wBattleStatResultLo], a

Jump_03A_7784::
    inc hl
    dec c
    jr nz, Jump_03A_7774
    pop de
    pop hl
    inc d
    inc hl
    inc hl
    dec e
    jr nz, Jump_03A_776B
    ld a, b
    dec b
    ld c, b
    call Multiply8
    srl h
    rr l
    ld a, [wBattleStatResultLo]
    cp a, l
    jr z, Jump_03A_77BE
    ld hl, wC130
    ld [hl], $16
    inc hl
    ld [hl], $32
    inc hl
    ld [hl], $31
    inc hl
    ld [hl], $36
    inc hl
    ld [hl], $37
    inc hl
    ld [hl], $28
    inc hl
    ld [hl], $35
    inc hl
    ld [hl], $36
    inc hl
    ld [hl], $F0
    ret

Jump_03A_77BE::
    call CopyTargetNameToWC130
    jr Jump_03A_77CB

; E = 1: copies the target's name to wC130; otherwise the target side's name followed by the word 'monsters' (E-0122)
; no direct call (reached through a table, a jump or a vector)
CopyTargetOrSideNameToWC130_77C3:: ; heuristic: follows a terminator; C0
Func_03A_77C3:: ; address name
    ld a, e
    cp a, $01
    jr z, Jump_03A_77CF
    call CopyTargetSideNameToWC130

Jump_03A_77CB::
    call WriteMonstersWordToWC130
    ret

Jump_03A_77CF::
    call CopyTargetNameToWC130
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: hFFC6, wBattleTarget, wBattleStatResultLo
; writes: wBattleStatResultLo
; points at: wC0A0, wC0A8, wC130
Func_03A_77D3:: ; heuristic: follows a terminator; C0
    ldh a, [hFFC6]
    ld b, a
    ld a, b
    cp a, $01
    jr z, Jump_03A_7856
    xor a, a
    ld [wBattleStatResultLo], a
    ld a, [wBattleTarget]
    bit 2, a
    ld hl, wC0A0
    jr z, Jump_03A_77EC
    ld hl, wC0A8

Jump_03A_77EC::
    ld a, b
    sub a, $01
    ld e, a
    ld d, $01

Jump_03A_77F2::
    ld a, b
    sub a, d
    ld c, a
    push hl
    push de
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a

Jump_03A_77FB::
    ld a, e
    cp a, [hl]
    inc hl
    jr nz, Jump_03A_780B
    ld a, d
    cp a, [hl]
    jr nz, Jump_03A_780B
    ld a, [wBattleStatResultLo]
    inc a
    ld [wBattleStatResultLo], a

Jump_03A_780B::
    inc hl
    dec c
    jr nz, Jump_03A_77FB
    pop de
    pop hl
    inc d
    inc hl
    inc hl
    dec e
    jr nz, Jump_03A_77F2
    ld a, b
    dec b
    ld c, b
    call Multiply8
    srl h
    rr l
    ld a, [wBattleStatResultLo]
    cp a, l
    jr z, Jump_03A_7845
    ld hl, wC130
    ld [hl], $16
    inc hl
    ld [hl], $32
    inc hl
    ld [hl], $31
    inc hl
    ld [hl], $36
    inc hl
    ld [hl], $37
    inc hl
    ld [hl], $28
    inc hl
    ld [hl], $35
    inc hl
    ld [hl], $36
    inc hl
    ld [hl], $F0
    ret

Jump_03A_7845::
    call CopyTargetNameToWC130
    jr Jump_03A_7852

; E = 1: copies the target's name to wC130; otherwise the target side's name followed by the word 'monsters' (E-0122)
; no direct call (reached through a table, a jump or a vector)
CopyTargetOrSideNameToWC130_784A:: ; heuristic: follows a terminator; C0
Func_03A_784A:: ; address name
    ld a, e
    cp a, $01
    jr z, Jump_03A_7856
    call CopyTargetSideNameToWC130

Jump_03A_7852::
    call WriteMonstersWordToWC130
    ret

Jump_03A_7856::
    call CopyTargetNameToWC130
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: hFFC6, wBattleTarget, wBattleStatResultLo
; writes: wBattleStatResultLo
; points at: wC0A0, wC0A8, wC130
Func_03A_785A:: ; heuristic: follows a terminator; C0
    ldh a, [hFFC6]
    ld b, a
    ld a, b
    cp a, $01
    jp z, Jump_03A_78EA
    xor a, a
    ld [wBattleStatResultLo], a
    ld a, [wBattleTarget]
    bit 2, a
    ld hl, wC0A0
    jr z, Jump_03A_7874
    ld hl, wC0A8

Jump_03A_7874::
    ld a, b
    sub a, $01
    ld e, a
    ld d, $01

Jump_03A_787A::
    ld a, b
    sub a, d
    ld c, a
    push hl
    push de
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a

Jump_03A_7883::
    ld a, e
    cp a, [hl]
    inc hl
    jr nz, Jump_03A_7893
    ld a, d
    cp a, [hl]
    jr nz, Jump_03A_7893
    ld a, [wBattleStatResultLo]
    inc a
    ld [wBattleStatResultLo], a

Jump_03A_7893::
    inc hl
    dec c
    jr nz, Jump_03A_7883
    pop de
    pop hl
    inc d
    inc hl
    inc hl
    dec e
    jr nz, Jump_03A_787A
    ld a, b
    dec b
    ld c, b
    call Multiply8
    srl h
    rr l
    ld a, [wBattleStatResultLo]
    cp a, l
    jr z, Jump_03A_78D9
    ld hl, wC130
    ld [hl], $1D
    inc hl
    ld [hl], $2B
    inc hl
    ld [hl], $28
    inc hl
    ld [hl], $90
    inc hl
    ld [hl], $30
    inc hl
    ld [hl], $32
    inc hl
    ld [hl], $31
    inc hl
    ld [hl], $36
    inc hl
    ld [hl], $37
    inc hl
    ld [hl], $28
    inc hl
    ld [hl], $35
    inc hl
    ld [hl], $36
    inc hl
    ld [hl], $F0
    ret

Jump_03A_78D9::
    call CopyTargetNameToWC130
    jr Jump_03A_78E6

; E = 1: copies the target's name to wC130; otherwise the target side's name followed by the word 'monsters' (E-0122)
; no direct call (reached through a table, a jump or a vector)
CopyTargetOrSideNameToWC130_78DE:: ; heuristic: follows a terminator; C0
Func_03A_78DE:: ; address name
    ld a, e
    cp a, $01
    jr z, Jump_03A_78EA
    call CopyTargetSideNameToWC130

Jump_03A_78E6::
    call WriteMonstersWordToWC130
    ret

Jump_03A_78EA::
    call CopyTargetNameToWC130
    ret

; wD86C = wBattleActor, then CopySlotNameToHL with HL = wC130 (E-0113)
; 3 call sites from 2 routines (e.g. Func_03A_7508, ShowSpecialActionMessage)
; reads: wBattleActor
; writes: wD86C
; points at: wC130
CopyActorNameToWC130::
Func_03A_78EE:: ; address name
    ld a, [wBattleActor]
    ld hl, wC130
    ld [wD86C], a
    call CopySlotNameToHL
    ret

; wD86C = wBattleActor, then CopySlotNameToHL with HL = wC140 (E-0116)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; writes: wD86C
; points at: wC140
CopyActorNameToWC140:: ; heuristic: follows a terminator; C0
Func_03A_78FB:: ; address name
    ld a, [wBattleActor]
    ld hl, wC140
    ld [wD86C], a
    call CopySlotNameToHL
    ret

; far-calls Func_0A3_414F (which maps the actor to a slot in hFFC6), then copies that slot's name to wC140 (CopySlotNameToHL) (E-0113)
; 2 call sites from 2 routines (e.g. Func_03A_7508, ShowSpecialActionMessage)
; reads: hFFC6
; writes: wD86C
; points at: wC140
CopyMappedSlotNameToWC140::
Func_03A_7908:: ; address name
    farcall ActorFormationSlotToHFFC6
    ldh a, [hFFC6]
    ld hl, wC140
    ld [wD86C], a
    call CopySlotNameToHL
    ret

; copies string wBattleActionId of category 4 (skill names) to wC140 (CopyStringHLToDE) (E-0116)
; 1 call site from 1 routine (e.g. Func_03A_7508)
; reads: wBattleActionId
; points at: wC140
CopyActionSkillNameToWC140::
Func_03A_791A:: ; address name
    ld a, [wBattleActionId]
    ld l, a
    ld h, $04
    ld de, wC140
    call CopyStringHLToDE
    ret

; wD86C = wBattleTarget, then CopySlotNameToHL with HL = wC130 (E-0077)
; 6 call sites from 6 routines (e.g. Call774CWithWD890_Sub01, CopyTargetOrSideNameToWC130_77C3, Func_03A_77D3, CopyTargetOrSideNameToWC130_784A, ...)
; reads: wBattleTarget
; writes: wD86C
; points at: wC130
CopyTargetNameToWC130::
Func_03A_7927:: ; address name
    ld a, [wBattleTarget]
    ld hl, wC130
    ld [wD86C], a
    call CopySlotNameToHL
    ret

; wD86C = wBattleTarget, then CopySlotNameToHL with HL = wC140 (E-0116)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wD86C
; points at: wC140
CopyTargetNameToWC140:: ; heuristic: follows a terminator; C0
Func_03A_7934:: ; address name
    ld a, [wBattleTarget]
    ld hl, wC140
    ld [wD86C], a
    call CopySlotNameToHL
    ret

; wD86C = wBattleTarget, then CopySlotNameToHL with HL = wC150 (E-0116)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wD86C
; points at: wC150
CopyTargetNameToWC150:: ; heuristic: follows a terminator; C0
Func_03A_7941:: ; address name
    ld a, [wBattleTarget]
    ld hl, wC150
    ld [wD86C], a
    call CopySlotNameToHL
    ret
    db $21, $40, $C1, $FA, $72, $D8, $4F, $FA, $73, $D8, $47, $CD, $84, $2F, $C9

; wD86C = wBattleTarget & 4 (the first slot of the target's side), then CopySlotNameToHL with HL = wC130 (E-0113)
; 3 call sites from 3 routines (e.g. CopyTargetOrSideNameToWC130_77C3, CopyTargetOrSideNameToWC130_784A, CopyTargetOrSideNameToWC130_78DE)
; reads: wBattleTarget
; writes: wD86C
; points at: wC130
CopyTargetSideNameToWC130::
Func_03A_795D:: ; address name
    ld a, [wBattleTarget]
    and a, $04
    ld hl, wC130
    ld [wD86C], a
    call CopySlotNameToHL
    ret

; copies the name at wC60C (5 glyphs, CopyFiveGlyphsPlusMarks) to wC130 (E-0116)
; no direct call (reached through a table, a jump or a vector)
; points at: wC60C, wC130
CopyWC60CNameToWC130:: ; heuristic: follows a terminator; C0
Func_03A_796C:: ; address name
    ld de, wC60C
    ld hl, wC130
    call CopyFiveGlyphsPlusMarks
    ret

; copies the name at wC60C (5 glyphs) to wC140 (E-0116)
; no direct call (reached through a table, a jump or a vector)
; points at: wC60C, wC140
CopyWC60CNameToWC140:: ; heuristic: follows a terminator; C0
Func_03A_7976:: ; address name
    ld de, wC60C
    ld hl, wC140
    call CopyFiveGlyphsPlusMarks
    ret

; copies string wBattleActionId of category 5 (item names) to wC150 (CopyStringHLToDE) (E-0116)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActionId
; points at: wC150
CopyActionItemNameToWC150:: ; heuristic: follows a terminator; C0
Func_03A_7980:: ; address name
    ld a, [wBattleActionId]
    ld l, a
    ld h, $05
    ld de, wC150
    call CopyStringHLToDE
    ret

; wD86C = wBattleActor & 4 (the first slot of the actor's side), then CopySlotNameToHL with HL = wC130 (E-0116)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; writes: wD86C
; points at: wC130
CopyActorSideNameToWC130:: ; heuristic: follows a terminator; C0
Func_03A_798D:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld hl, wC130
    ld [wD86C], a
    call CopySlotNameToHL
    ret

; A = battle slot: slots 0-2 go to CopyBattlerNameToHL; other slots take paths that check slot 3/7, wC58A and wDAD4 (not fully read) (E-0077)
; 10 call sites from 10 routines (e.g. RunBattleSetup_Shared06_Sub01, Func_03A_7508, CopyActorNameToWC130, CopyMappedSlotNameToWC140, ...)
; reads: wC58A, wD86C
; writes: wD869
; points at: wDAD4
CopySlotNameToHL::
Func_03A_799C:: ; address name
    cp a, $03
    jr nc, Jump_03A_79BB

; A = battle slot (0-2 or 4-6): copies the name at offset 0 of the slot's battler record (5 glyphs, CopyFiveGlyphsPlusMarks) to HL and leaves HL on the $F0 terminator; BC kept (E-0077)
; 1 call site from 1 routine (e.g. CopyBattlerNameToHL_Sub01)
CopyBattlerNameToHL::
Func_03A_79A0:: ; address name
    push hl
    push bc
    ld e, $00
    call BattlerRecordFieldAddress
    ld e, l
    ld d, h
    pop bc
    pop hl
    push hl
    call CopyFiveGlyphsPlusMarks
    pop hl

Jump_03A_79B0::
    ld a, [hl]
    cp a, $F0
    ret z
    inc hl
    jr Jump_03A_79B0

Jump_03A_79B7::
    ld a, b
    pop bc
    jr CopyBattlerNameToHL

Jump_03A_79BB::
    push bc
    ld b, a
    and a, $03
    cp a, $03
    ld a, b
    pop bc
    jr z, Jump_03A_79E4
    push bc
    ld b, a
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_03A_79B7
    push hl
    ld a, b
    and a, $03
    ld hl, wDAD4
    add_a_to_hl
    ld a, [hl]
    pop hl
    cp a, $FF
    jr nz, Jump_03A_79E1
    ld a, b

Jump_03A_79E1::
    pop bc
    jr nz, Jump_03A_7A10

Jump_03A_79E4::
    push af
    call CopyBattlerNameToHL_Sub01
    pop af
    call CopyBattlerNameToHL_Sub02
    ret

; only called from CopyBattlerNameToHL (E-0047)
; 1 call site from 1 routine (e.g. CopyBattlerNameToHL)
; writes: wD87C, wD87A, wD87B
; points at: wBattleMonsterId
CopyBattlerNameToHL_Sub01::
Func_03A_79ED:: ; address name
    ld [wD87C], a
    push hl
    ld hl, wBattleMonsterId
    add a, a
    add_a_to_hl
    push bc
    ld a, [hl+]
    ld c, a
    ld a, [hl]
    add a, $02
    ld h, a
    ld l, c
    pop bc
    pop de
    ld a, e
    ld [wD87A], a
    ld a, d
    ld [wD87B], a
    call CopyStringHLToDE
    ret

Jump_03A_7A10::
    call CopyBattlerNameToHL
    ld a, $47
    ld [hl+], a
    ld [hl], $F0
    push hl
    ld hl, wDAD4
    ld a, [wD86C]
    and a, $03
    cp a, $01
    jr z, Jump_03A_7A33
    cp a, $02
    jr z, Jump_03A_7A3D
    ld a, [hl+]
    cp a, [hl]
    jr z, Jump_03A_7A59
    inc hl
    cp a, [hl]
    jr z, Jump_03A_7A59
    jr Jump_03A_7A68

Jump_03A_7A33::
    ld a, [hl+]
    cp a, [hl]
    jr z, Jump_03A_7A5E
    ld a, [hl+]
    cp a, [hl]
    jr z, Jump_03A_7A59
    jr Jump_03A_7A68

Jump_03A_7A3D::
    ld d, $00
    inc hl
    inc hl
    ld a, [hl-]
    dec hl
    cp a, [hl]
    jr nz, Jump_03A_7A47
    inc d

Jump_03A_7A47::
    inc hl
    cp a, [hl]
    jr nz, Jump_03A_7A4C
    inc d

Jump_03A_7A4C::
    ld a, d
    or a, a
    jr z, Jump_03A_7A68
    cp a, $01
    jr z, Jump_03A_7A5E
    pop hl
    ld a, $0C
    jr Jump_03A_7A61

Jump_03A_7A59::
    pop hl
    ld a, $0A
    jr Jump_03A_7A61

Jump_03A_7A5E::
    pop hl
    ld a, $0B

Jump_03A_7A61::
    ld [wD869], a
    ld [hl+], a
    ld [hl], $F0
    ret

Jump_03A_7A68::
    pop hl
    xor a, a
    ld [wD869], a
    ret

; only called from CopyBattlerNameToHL (E-0047)
; 1 call site from 1 routine (e.g. CopyBattlerNameToHL)
; reads: wD87C, wC0A0, wD87A, wD87B
; writes: wC0A0
; points at: wBattleMonsterId, wC0A0
CopyBattlerNameToHL_Sub02::
Func_03A_7A6E:: ; address name
    call Func_03A_7AE3
    inc b
    ld c, $04
    xor a, a
    ld [wC0A0], a
    ld a, [wD87C]
    add a, a
    ld hl, wBattleMonsterId
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld e, a

Jump_03A_7A87::
    ld a, c
    add a, a
    ld hl, wBattleMonsterId
    add_a_to_hl
    ld a, [hl+]
    cp a, e
    jr nz, Jump_03A_7AA4
    ld a, [hl]
    cp a, d
    jr nz, Jump_03A_7AA4
    ld a, [wD87C]
    cp a, c
    jp z, Jump_03A_7AA9
    ld hl, wC0A0
    inc [hl]

Jump_03A_7AA4::
    inc c
    dec b
    jr nz, Jump_03A_7A87
    ret

Jump_03A_7AA9::
    ld a, [wC0A0]
    or a, a
    jr nz, Jump_03A_7AC7
    inc c

Jump_03A_7AB0::
    ld a, c
    add a, a
    ld hl, wBattleMonsterId
    add_a_to_hl
    ld a, [hl+]
    cp a, e
    jr nz, Jump_03A_7AC2
    ld a, [hl]
    cp a, d
    jr z, Jump_03A_7AC7

Jump_03A_7AC2::
    inc c
    dec b
    jr nz, Jump_03A_7AB0
    ret

Jump_03A_7AC7::
    ld a, [wD87A]
    ld l, a
    ld a, [wD87B]
    ld h, a
    ld a, [wC0A0]
    add a, $0A
    push af

Jump_03A_7AD5::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_03A_7ADD
    inc hl
    jr Jump_03A_7AD5

Jump_03A_7ADD::
    pop af
    ld [hl+], a
    ld a, $F0
    ld [hl], a
    ret

; 6 call sites from 5 routines (e.g. ActionEffect_Ironize_Sub01, CopyBattlerNameToHL_Sub02, Func_03B_4711, ApplyTargetWD93FReduction, ...)
; reads: wC58A, wC57F
; points at: wC0A0, wBattleMonsterId, wC0A8
Func_03A_7AE3::
    xor a, a
    ld hl, wC0A0
    ld bc, $0010
    call FillBytes
    ld de, $0000
    ld c, $00
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_03A_7B02
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_03A_7B02
    ld c, $04

Jump_03A_7B02::
    ld b, $03

Jump_03A_7B04::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_03A_7B26
    ld a, e
    add a, a
    ld hl, wC0A0
    add_a_to_hl
    push de
    ld a, c
    add a, a
    ld de, wBattleMonsterId
    add a, e
    ld e, a
    jr nc, Jump_03A_7B1F
    inc d

Jump_03A_7B1F::
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    pop de
    inc e

Jump_03A_7B26::
    inc c
    dec b
    jr nz, Jump_03A_7B04
    ld c, $04
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_03A_7B3C
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_03A_7B3C
    ld c, $00

Jump_03A_7B3C::
    ld b, $03

Jump_03A_7B3E::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_03A_7B60
    ld a, d
    add a, a
    ld hl, wC0A8
    add_a_to_hl
    push de
    ld a, c
    add a, a
    ld de, wBattleMonsterId
    add a, e
    ld e, a
    jr nc, Jump_03A_7B59
    inc d

Jump_03A_7B59::
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl], a
    pop de
    inc d

Jump_03A_7B60::
    inc c
    dec b
    jr nz, Jump_03A_7B3E
    ld b, d
    ret

; only called from ActionEffect_Ironize (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Ironize)
; reads: wC58A, wBattleTarget
ActionEffect_Ironize_Sub01::
Func_03A_7B66:: ; address name
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_03A_7B77
    ld a, [wBattleTarget]
    cp a, $04
    jr c, Jump_03A_7B77

Jump_03A_7B74::
    ld d, $47
    ret

Jump_03A_7B77::
    call Func_03A_7AE3
    ld a, e
    cp a, $01
    jr z, Jump_03A_7B74
    ld d, $46
    ret

; writes the glyphs of 'Monsters' (decoded with the charmap) and $F0 to wC130 (E-0113)
; 3 call sites from 3 routines (e.g. CopyTargetOrSideNameToWC130_77C3, CopyTargetOrSideNameToWC130_784A, CopyTargetOrSideNameToWC130_78DE)
; points at: wC130
WriteMonstersWordToWC130::
Func_03A_7B82:: ; address name
    ld hl, wC130
    ld [hl], $16
    inc hl
    ld [hl], $32
    inc hl
    ld [hl], $31
    inc hl
    ld [hl], $36
    inc hl
    ld [hl], $37
    inc hl
    ld [hl], $28
    inc hl
    ld [hl], $35
    inc hl
    ld [hl], $36
    inc hl
    ld [hl], $F0
    ret

; only called from routines of RunBattleSetup (E-0098)
; 3 call sites from 3 routines (e.g. RunBattleSetup_Case01_Case0C, RunBattleSetup_Case01_Case1C, RunBattleSetup_Case02_Case0C)
; reads: wC58A, wD869, wD86D, wD86E, wD86F, wC52D, wC52E, wC52F, ...
; writes: wD86C, wStringCategory, wStringIndex, wC52D, wC52E, wC52F, wC530
; points at: wD86D, wC130
RunBattleSetup_Shared06::
Func_03A_7BA0:: ; address name
    ld a, $FF
    ld hl, wD86D
    ld bc, $0003
    call FillBytes
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_03A_7BB6
    ld c, $04
    jr Jump_03A_7BC0

Jump_03A_7BB6::
    ld a, [wC57F]
    sla a
    and a, $04
    xor a, $04
    ld c, a

Jump_03A_7BC0::
    ld b, $03
    ld e, $00

Jump_03A_7BC4::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr z, Jump_03A_7BDC
    jr nc, Jump_03A_7BD2
    ld a, [wD869]
    or a, a
    jr z, Jump_03A_7BDC

Jump_03A_7BD2::
    ld a, e
    ld hl, wD86D
    add_a_to_hl
    ld [hl], c

Jump_03A_7BDC::
    inc e
    inc c
    dec b
    jr nz, Jump_03A_7BC4
    ld a, [wD86D]
    ld hl, vTiles1 + $6D0
    call RunBattleSetup_Shared06_Sub01
    ld hl, vTiles1 + $770
    ld a, [wD86E]
    call RunBattleSetup_Shared06_Sub01
    ld hl, vTiles2 + $10
    ld a, [wD86F]

; only called from RunBattleSetup_Shared06 (E-0047)
; 2 call sites from 1 routine (e.g. RunBattleSetup_Shared06)
; reads: wC52D, wC52E, wC52F, wC530
; writes: wD86C, wStringCategory, wStringIndex, wC52D, wC52E, wC52F, wC530
; points at: wC130
RunBattleSetup_Shared06_Sub01::
Func_03A_7BF9:: ; address name
    cp a, $FF
    jr z, Jump_03A_7C14
    push hl
    ld hl, wC130
    ld [wD86C], a
    call CopySlotNameToHL
    ld a, $08
    ld [wStringCategory], a
    ld a, $05
    ld [wStringIndex], a
    pop hl
    jr Jump_03A_7C1E

Jump_03A_7C14::
    ld a, $02
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a

Jump_03A_7C1E::
    ld de, $0A01
    ld a, [wC52D]
    ld c, a
    ld a, [wC52E]
    ld b, a
    push bc
    ld a, [wC52F]
    ld c, a
    ld a, [wC530]
    ld b, a
    push bc
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld a, e
    ld [wC52F], a
    ld a, d
    ld [wC530], a
    farcall ShowString_Bank08
    pop de
    pop hl
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld a, e
    ld [wC52F], a
    ld a, d
    ld [wC530], a
    ret
    db $21, $FF, $D8, $18, $28, $21, $0F, $D9, $18, $23

; A = battle slot: HL = the word for that slot at wBattleMaxHP; A = its low byte (E-0064)
; 1 call site from 1 routine (e.g. RunBattleActions_Case09_Case02_Sub01)
; points at: wBattleMaxHP
GetBattleMaxHP_Bank3A::
Func_03A_7C66:: ; address name
    ld hl, wBattleMaxHP
    jr Jump_03A_7C89

; A = battle slot: HL = the word for that slot at wBattleMaxMP; A = its low byte (E-0064)
; 1 call site from 1 routine (e.g. RunBattleResolveStep_69AA_Case00)
; points at: wBattleMaxMP
GetBattleMaxMP_Bank3A::
Func_03A_7C6B:: ; address name
    ld hl, wBattleMaxMP
    jr Jump_03A_7C89
    db $21, $BF, $D8, $18, $14

; A = battle slot: HL = the word for that slot at wBattleMP; A = its low byte (E-0064)
; 1 call site from 1 routine (e.g. RunBattleResolveStep_69AA_Case00)
; points at: wBattleMP
GetBattleMP_Bank3A::
Func_03A_7C75:: ; address name
    ld hl, wBattleMP
    jr Jump_03A_7C89
    db $21, $1F, $D9, $18, $0A, $21, $53, $DA, $85, $6F, $30, $01, $24, $7E, $C9

Jump_03A_7C89::
    add a, a
    add_a_to_hl
    deref_hl
    ret

; HL += 2 * A (A is doubled in 8 bits first, so it wraps above $7F); clobbers A (the same 7 bytes appear in 10 banks)
; 4 call sites from 4 routines (e.g. RunBattleActions_Case09_Case02_Sub02, RunBattleResolveStep_69AA_Case06, RunBattleResolveStep_69AA_Case04, RunBattleResolveStep_69AA_Case00)
AddDoubleAToHL_Bank3A::
Func_03A_7C93:: ; address name
    add a, a
    add_a_to_hl
    ret

; carry set when wBattleActor < 4 (slots 0-3); when wC58A = 1 and wC57F bit 1 is set the test is reversed (carry set when wBattleActor >= 4). Which side is local is inferred from the reversal, not checked (E-0064) (the same 27 bytes appear in 10 banks)
; 2 call sites from 2 routines (e.g. SelectEffectByWDAD3Flags, SelectEffectByWDAD2Flags)
; reads: wC58A, wC57F, wBattleActor
ActorOnLocalSide_Bank3A::
Func_03A_7C9A:: ; address name
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_03A_7CAF
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_03A_7CAF
    ld a, [wBattleActor]
    cp a, $04
    ccf
    ret

Jump_03A_7CAF::
    ld a, [wBattleActor]
    cp a, $04
    ret

; carry set when wBattleTarget < 4 (slots 0-3); when wC58A = 1 and wC57F bit 1 is set the test is reversed (carry set when wBattleTarget >= 4) (E-0064) (the same 27 bytes appear in 10 banks)
; 4 call sites from 3 routines (e.g. SelectEffectByWDAD2Flags, RunWDABEMinus1Step_Case01, RunWDABEMinus1Step_Case00)
; reads: wC58A, wC57F, wBattleTarget
TargetOnLocalSide_Bank3A::
Func_03A_7CB5:: ; address name
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_03A_7CCA
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_03A_7CCA
    ld a, [wBattleTarget]
    cp a, $04
    ccf
    ret

Jump_03A_7CCA::
    ld a, [wBattleTarget]
    cp a, $04
    ret
    db $7A, $21, $E5, $7C, $85, $6F, $30, $01, $24, $56, $7B, $21, $0C, $D8, $CD, $25
    db $3F, $7A, $A6, $77, $C9, $DF, $FE, $00, $FD, $73, $EF, $BF

; Sets bit 0 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 4 banks)
; 1 call site from 1 routine (e.g. RunBattleActions_Case09_Case02_Sub02)
; points at: wD095
SetBit0OfWD095Indexed_Bank3A::
Func_03A_7CEC:: ; address name
    push hl
    ld hl, wD095
    add_a_to_hl
    set 0, [hl]
    pop hl
    ret

; Sets bit 1 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 4 banks)
; 1 call site from 1 routine (e.g. RunBattleResolveStep_69AA_Case00)
; points at: wD095
SetBit1OfWD095Indexed_Bank3A::
Func_03A_7CF9:: ; address name
    push hl
    ld hl, wD095
    add_a_to_hl
    set 1, [hl]
    pop hl
    ret

; Sets bit 2 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 4 banks)
; 3 call sites from 3 routines (e.g. RunBattleActions_Case09_Case02_Sub02, RunBattleResolveStep_69AA_Case02, RunBattleResolveStep_69AA_Case01)
; points at: wD095
SetBit2OfWD095Indexed_Bank3A::
Func_03A_7D06:: ; address name
    push hl
    ld hl, wD095
    add_a_to_hl
    set 2, [hl]
    pop hl
    ret

; A = slot 0-7: returns A = 9 * g(wD968[A]) + 3 * g(wD970[A]) + g(wD978[A]) with g(v) = 0 for v >= $C0, 1 for v >= $40, else 2 (the same index PersonalityIndexOfRecord builds from a save record; E-0031); HL and BC are kept (the same 87 bytes appear in 7 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wSlotPersonalityHi, wSlotPersonalityMid, wSlotPersonalityLo
PersonalityIndexOfSlot_Bank3A:: ; heuristic: follows a terminator; C0
Func_03A_7D13:: ; address name
    push hl
    push bc
    ld c, a
    ld b, $00
    ld hl, wSlotPersonalityHi
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_03A_7D2F
    ld l, $09
    cp a, $40
    jr nc, Jump_03A_7D2F
    ld l, $12

Jump_03A_7D2F::
    ld a, l
    add a, b
    ld b, a
    ld a, c
    ld hl, wSlotPersonalityMid
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_03A_7D4A
    ld l, $03
    cp a, $40
    jr nc, Jump_03A_7D4A
    ld l, $06

Jump_03A_7D4A::
    ld a, l
    add a, b
    ld b, a
    ld a, c
    ld hl, wSlotPersonalityLo
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_03A_7D65
    ld l, $01
    cp a, $40
    jr nc, Jump_03A_7D65
    ld l, $02

Jump_03A_7D65::
    ld a, l
    add a, b
    pop bc
    pop hl
    ret

; A = slot: carry set when CheckSlotStatusBlock sets it, or when status byte 3 & $C0 or byte 4 & $0C is set (wD80F + 9 * A); otherwise carry clear; A, BC, HL kept (E-0067) (the same 31 bytes appear in 7 banks)
; 2 call sites from 2 routines (e.g. RunBattleActions_Case05, RunBattleResolveStep_69AA_Case09_Sub01)
; points at: wD80F
CheckSlotStatusBlockWide_Bank3A::
Func_03A_7D6A:: ; address name
    call CheckSlotStatusBlock
    ret c
    push hl
    push bc
    ld c, a
    ld hl, wD80F
    call AddAx9ToHL
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_03A_7D84
    ld a, [hl]
    and a, $0C
    jr nz, Jump_03A_7D84
    xor a, a
    jr Jump_03A_7D85

Jump_03A_7D84::
    scf

Jump_03A_7D85::
    ld a, c
    pop bc
    pop hl
    ret

; A = slot: with HL = wD80F + 9 * A (status byte 3 of wBattleStatus), A = byte 3 & $C0, or byte 4 & $0C when that is zero; Z set when both are clear; HL kept (E-0067) (the same 17 bytes appear in 8 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wD80F
SlotHasStatus3Or4Bits_Bank3A:: ; heuristic: follows a terminator; C0
Func_03A_7D89:: ; address name
    push hl
    ld hl, wD80F
    call AddAx9ToHL
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_03A_7D98
    ld a, [hl]
    and a, $0C

Jump_03A_7D98::
    pop hl
    ret

Data_03A_7D9A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0EBD9A, $1DF
    ds $87, $00
