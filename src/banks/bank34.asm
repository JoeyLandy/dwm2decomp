SECTION "Bank 34", ROMX[$4000], BANK[$34]
    db $34

; 20 call sites from 20 routines (e.g. Func_001_4F80, Func_001_6C48, Func_007_6975, Func_00D_6B55, ...)
; points at: wSkillId
Func_034_4001::
    ld de, wSkillId
    call Func_034_4040
    ret

; 2 call sites from 2 routines (e.g. Func_00A_5071, Func_085_5B53)
; reads: wCFE7, wCFE6, hFFC6
Func_034_4008::
    ld a, [wCFE7]
    cp a, $02
    jr c, Jump_034_401D
    ld a, [wCFE6]
    cp a, $50
    jr c, Jump_034_401D
    farcall Func_0A2_4001
    ret

Jump_034_401D::
    push de
    push bc
    ld a, [wCFE6]
    ld c, a
    ld a, [wCFE7]
    ld b, a
    ld a, $1A
    call Multiply8By16
    ld a, l
    add a, $75
    ld l, a
    ld a, h
    adc a, $40
    ld h, a
    pop bc
    ld b, $00
    add hl, bc
    ldh a, [hFFC6]
    ld b, a
    pop de
    call Func_034_406E
    ret

; 1 call site from 1 routine (e.g. Func_034_4001)
; reads: wCFE7, wCFE6
Func_034_4040::
    ld a, [wCFE7]
    cp a, $02
    jr c, Jump_034_4055
    ld a, [wCFE6]
    cp a, $50
    jr c, Jump_034_4055
    farcall Func_0A2_402D
    ret

Jump_034_4055::
    push de
    ld a, [wCFE6]
    ld c, a
    ld a, [wCFE7]
    ld b, a
    ld a, $1A
    call Multiply8By16
    ld a, l
    add a, $75
    ld l, a
    ld a, h
    adc a, $40
    ld h, a
    pop de
    ld b, $1A

; 1 call site from 1 routine (e.g. Func_034_4008)
Func_034_406E::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Func_034_406E
    ret
    db $00, $00, $FF, $FF, $FF, $FF
    ds $14, $00
    INCBIN "dwm2-cobi-us.gbc", $0D008F, $3C06
    ds $36B, $00
