SECTION "Bank 69", ROMX[$4000], BANK[$69]
    db $69

; 4 call sites from 4 routines (e.g. Func_002_4628, Func_002_5BD7, Func_00C_433D, Func_015_570C)
; reads: wCC44, hFF90, hFF8F, hFF92, wCC38, hFFD0, wC190
; writes: wCB7D, wC527, hFFD0, hFFCA, hFFCB, hFFC8, hFFC6, hFFC7, ...
; points at: wCB7F
Func_069_4001::
    xor a, a
    ld [wCB7D], a
    ld a, [wCC44]
    bit 7, a
    jr z, Jump_069_401E
    farcall Func_004_4025
    farcall Func_004_4008
    ld a, $7F
    ld [wC527], a
    ret

Jump_069_401E::
    ldh a, [hFF90]
    cp a, $2F
    jr nz, Jump_069_404C
    ldh a, [hFF8F]
    or a, a
    jr nz, Jump_069_404C
    ldh a, [hFF92]
    cp a, $01
    jr nz, Jump_069_404C
    ld de, $0056
    call TestFlagBit
    jr nc, Jump_069_404C
    ld de, $0058
    call TestFlagBit
    jr c, Jump_069_404C
    ld a, [wCC38]
    bit 3, a
    jr z, Jump_069_404C
    ld hl, Data_069_7E1E
    jp Jump_069_40F4

Jump_069_404C::
    ldh a, [hFF90]
    ld l, a
    ld h, $00
    add hl, hl
    ld a, l
    add a, $74
    ld l, a
    ld a, h
    adc a, $41
    ld h, a
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld a, [wC190]
    sla a
    ld c, a
    ldh a, [hFF92]
    call Multiply8
    ldh a, [hFF8F]
    sla a
    add_a_to_hl
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    or a, e
    jr nz, Jump_069_407C
    jp Jump_069_4168

Jump_069_407C::
    ld a, [hl]
    ld d, a
    ld l, e
    ld h, d

Jump_069_4080::
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    cp a, $FF
    jr nz, Jump_069_40E5
    ld a, e
    cp a, $FF
    jr nz, Jump_069_4094

Jump_069_408D::
    xor a, a
    ld [wCB7D], a
    jp Jump_069_4168

Jump_069_4094::
    cp a, $FE
    jr z, Jump_069_40EE
    cp a, $FD
    jr z, Jump_069_40D2
    cp a, $FC
    jr z, Jump_069_40BC
    cp a, $FB
    jr z, Jump_069_40A6
    jr Jump_069_408D

Jump_069_40A6::
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    call TestFlagBit
    jr nc, Jump_069_40B8
    ld a, [hl+]
    inc hl
    add_a_to_hl
    jr Jump_069_4080

Jump_069_40B8::
    inc hl
    inc hl
    jr Jump_069_4080

Jump_069_40BC::
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    call TestFlagBit
    jr nc, Jump_069_40C9
    inc hl
    inc hl
    jr Jump_069_4080

Jump_069_40C9::
    ld a, [hl+]
    inc hl
    add_a_to_hl
    jr Jump_069_4080

Jump_069_40D2::
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    call TestFlagBit
    jr nc, Jump_069_40E1
    inc hl
    inc hl
    inc hl
    inc hl
    jr Jump_069_4080

Jump_069_40E1::
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a

Jump_069_40E5::
    call TestFlagBit
    jr nc, Jump_069_40EE
    inc hl
    inc hl
    jr Jump_069_4080

Jump_069_40EE::
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld l, e
    ld h, d

Jump_069_40F4::
    ld a, [hl+]
    ld [wCB7D], a
    ld b, a
    ld de, wCB7F

Jump_069_40FC::
    push bc
    ld a, b
    ldh [hFFD0], a
    xor a, a
    ldh [hFFCA], a
    ld a, [hl+]
    ldh [hFFCB], a
    ld a, [hl+]
    ldh [hFFC8], a
    inc de
    ld [de], a
    inc de
    ld a, [hl+]
    ldh [hFFC6], a
    ld [de], a
    inc de
    ld a, [hl+]
    ldh [hFFC7], a
    ld [de], a
    inc de
    push de
    ld a, e
    sub a, $04
    ld e, a
    ld a, d
    sbc a, $00
    ld d, a
    ld a, [hl+]
    ld [de], a
    pop de
    ld a, [hl]
    ld [de], a
    push de
    ld a, $07
    add a, e
    ld e, a
    jr nc, Jump_069_412C
    inc d

Jump_069_412C::
    ld a, [hl+]
    ld [de], a
    pop de
    inc de
    ld a, [hl]
    ld [de], a
    push de
    ld a, $07
    add a, e
    ld e, a
    jr nc, Jump_069_413A
    inc d

Jump_069_413A::
    ld a, [hl+]
    ld [de], a
    pop de
    inc de
    ld a, [hl+]
    ldh [hFFC9], a
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ldh a, [hFFD0]
    and a, $03
    ld [de], a
    xor a, a
    inc de
    ld [de], a
    inc de
    inc de
    inc de
    ld [de], a
    inc de
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    push hl
    push de
    farcall Func_004_431F
    pop de
    pop hl
    pop bc
    dec b
    jr nz, Jump_069_40FC

Jump_069_4168::
    farcall Func_004_4008
    ld a, $7F
    ld [wC527], a
    ret
    dw Data_069_63B2
    db $22, $67
    dw Data_069_6945
    db $4B, $7E
    dw Data_069_6AFB
    db $32, $6C
    dw Data_069_6D2D
    db $3B, $6E
    dw Data_069_6E8B
    db $B8, $6E
    dw Data_069_6EEB
    db $13, $6F
    dw Data_069_6F46
    db $B1, $6F
    dw Data_069_701F
    db $52, $70
    dw Data_069_7087
    db $B4, $70
    dw Data_069_7104
    db $5C, $71
    dw Data_069_716E
    db $96, $71
    dw Data_069_71EA
    db $12, $72
    dw Data_069_730F
    db $20, $74
    dw Data_069_756A
    db $4B, $7E
    dw Data_069_76E4
    db $08, $77
    dw Data_069_7E4B
    db $4B, $7E
    dw Data_069_7E4B
    db $22, $78, $7D, $78, $A5, $78, $C2, $78, $B9, $79, $91, $7A, $4B, $7E, $5E, $7B
    db $4B, $7E, $AB, $7B, $F9, $7B, $4B, $7E, $4C, $7C, $DC, $7C, $31, $7D, $9D, $5D
    dw Data_069_5E57
    db $BD, $5E
    dw Data_069_5F73
    db $26, $60
    dw Data_069_604E
    db $4B, $7E
    dw Data_069_6080
    db $A8, $60
    dw Data_069_60F0
    db $5C, $61
    dw Data_069_6196
    db $EC, $61
    dw Data_069_627F
    db $4B, $7E
    dw Data_069_7E4B
    dw Data_069_629C
    dw Data_069_62C0
    dw Data_069_636E
    dw Data_069_6386
    dw Data_069_639E
    dw Data_069_7E4B
    dw Data_069_7E4B
    dw Data_069_7E4B
    dw Data_069_7E4B
    dw Data_069_50F0
    db $D4, $51
    dw Data_069_52C6
    db $F3, $52
    dw Data_069_53FF
    db $20, $54
    dw Data_069_5436
    db $28, $55
    dw Data_069_5576
    db $93, $55
    dw Data_069_5616
    db $7C, $56
    dw Data_069_568E
    db $4B, $7E
    dw Data_069_56A2
    db $2B, $57
    dw Data_069_57E1
    db $10, $58
    dw Data_069_58CA
    db $AB, $59
    dw Data_069_5A06
    db $85, $5A
    dw Data_069_5BA8
    db $01, $5C
    dw Data_069_5CD8
    db $4B, $7E
    dw Data_069_7E4B
    db $4B, $7E
    dw Data_069_7E4B
    db $4B, $7E
    dw Data_069_7E4B
    db $4B, $7E
    dw Data_069_7E4B
    db $4B, $7E
    dw Data_069_7E4B
    db $4B, $7E
    dw Data_069_7E4B
    db $4B, $7E
    dw Data_069_7E4B
    db $4B, $7E, $F3, $49, $A8, $4A, $4B, $7E, $4B, $7E, $4B, $7E
    dw Data_069_4ABA
    db $DF, $4A, $05, $4B
    dw Data_069_4BBB
    db $F5, $4B, $4B, $7E
    dw Data_069_4C60
    db $83, $4D, $A5, $4D
    dw Data_069_4DE8
    db $4B, $7E, $4B, $7E
    dw Data_069_7E4B
    db $4B, $7E, $42, $4E
    dw Data_069_7E4B
    db $4B, $7E, $4B, $7E
    dw Data_069_7E4B
    db $56, $4E, $4B, $7E
    dw Data_069_7E4B
    db $99, $4E, $4B, $7E, $BD, $4E, $89, $4F, $9D, $4F, $CD, $4F, $4B, $7E, $4B, $7E
    db $E1, $4F, $65, $50, $83, $50, $4B, $7E, $4B, $7E, $4B, $7E, $4B, $7E, $A5, $50
    db $4B, $7E, $4B, $7E, $4B, $7E, $4B, $7E, $4B, $7E, $AF, $49, $4B, $7E, $D2, $49
    db $4B, $7E, $4B, $7E, $4B, $7E, $4B, $7E, $4B, $7E
    dw Data_069_47AA
    dw Data_069_48B6
    dw Data_069_493A
    dw Data_069_4957
    dw Data_069_7E4B
    dw Data_069_7E4B
    dw Data_069_7E4B
    dw Data_069_7E4B
    db $1D, $47, $4B, $7E, $4B, $7E, $4B, $7E, $4B, $7E, $7B, $47, $4B, $7E, $4B, $7E
    dw Data_069_453D
    dw Data_069_45E8
    dw Data_069_463D
    dw Data_069_46AB
    dw Data_069_46FE
    dw Data_069_7E4B
    dw Data_069_7E4B
    dw Data_069_7E4B
    dw Data_069_7E4B
    dw Data_069_7E4B
    dw Data_069_7E4B
    dw Data_069_7E4B
    dw Data_069_7E4B
    dw Data_069_7E4B
    dw Data_069_7E4B
    dw Data_069_7E4B
    INCBIN "dwm2-cobi-us.gbc", $1A4306, $237

Data_069_453D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A453D, $AB

Data_069_45E8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A45E8, $55

Data_069_463D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A463D, $6E

Data_069_46AB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A46AB, $53

Data_069_46FE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A46FE, $AC

Data_069_47AA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A47AA, $10C

Data_069_48B6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A48B6, $84

Data_069_493A:: ; heuristic: target of a monotone pointer table; C0
    db $3C, $49, $FE, $FF, $40, $49, $02, $85, $01, $37, $00, $00, $50, $40, $05, $00
    db $50, $0F, $86, $01, $38, $00, $00, $30, $20, $06, $03, $60, $10

Data_069_4957:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A4957, $163

Data_069_4ABA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A4ABA, $101

Data_069_4BBB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A4BBB, $A5

Data_069_4C60:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A4C60, $188

Data_069_4DE8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A4DE8, $B3
    ds $10, $00
    INCBIN "dwm2-cobi-us.gbc", $1A4EAB, $245

Data_069_50F0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A50F0, $1D6

Data_069_52C6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A52C6, $139

Data_069_53FF:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $03, $54, $8A, $00, $09, $54, $FF, $FF, $02, $85, $01, $0E, $00, $00
    db $70, $30, $05, $00, $50, $48, $86, $01, $03, $00, $00, $30, $50, $06, $03, $60
    db $49, $26, $54, $00, $00, $00, $00, $FE, $FF, $2A, $54, $01, $85, $01, $2E, $00
    db $00, $50, $30, $05, $00, $50, $1C

Data_069_5436:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A5436, $140

Data_069_5576:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A5576, $A0

Data_069_5616:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $36, $56
    ds $12, $00
    INCBIN "dwm2-cobi-us.gbc", $1A562E, $60

Data_069_568E:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $92, $56, $FE, $FF, $96, $56, $01, $85, $01, $16, $00, $00, $50, $50
    db $05, $03, $50, $41

Data_069_56A2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A56A2, $13F

Data_069_57E1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A57E1, $E9

Data_069_58CA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A58CA, $13C

Data_069_5A06:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A5A06, $1A2

Data_069_5BA8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A5BA8, $130

Data_069_5CD8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A5CD8, $C5
    ds $2E, $00
    db $1D, $5E
    ds $2A, $00
    db $37, $5E
    ds $24, $00
    db $FB, $FF, $22, $00, $02, $00, $FF, $FF, $F4, $00, $2B, $5E, $FF, $FF, $01, $85
    db $00, $53, $01, $00, $50, $50, $05, $00, $50, $6C, $FC, $FF, $76, $00, $02, $00
    db $FF, $FF, $FB, $FF, $70, $00, $02, $00, $FF, $FF, $FE, $FF, $4B, $5E, $01, $85
    db $01, $55, $00, $02, $40, $40, $05, $00, $50, $46

Data_069_5E57:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A5E57, $11C

Data_069_5F73:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A5F73, $DB

Data_069_604E:: ; heuristic: target of a monotone pointer table; C0
    ds $1E, $00
    db $6E, $60, $78, $00, $74, $60, $FF, $FF, $01, $85, $00, $4F, $01, $00, $40, $30
    db $05, $03, $50, $34

Data_069_6080:: ; heuristic: target of a monotone pointer table; C0
    db $86, $60, $00, $00, $98, $60, $71, $00, $8C, $60, $FF, $FF, $01, $85, $01, $44
    db $00, $00, $70, $10, $05, $00, $50, $47, $FE, $FF, $9C, $60, $01, $85, $01, $56
    db $00, $00, $70, $60, $05, $00, $50, $4D
    ds $1C, $00
    db $C8, $60, $00, $00, $7B, $00, $CE, $60, $FF, $FF, $03, $85, $01, $03, $00, $00
    db $50, $A0, $05, $02, $50, $00, $86, $01, $28, $00, $00, $50, $B0, $06, $02, $60
    db $00, $87, $01, $29, $00, $00, $50, $C0, $07, $02, $70, $00

Data_069_60F0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A60F0, $A6

Data_069_6196:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A6196, $E9

Data_069_627F:: ; heuristic: target of a monotone pointer table; C0
    db $81, $62, $FE, $FF, $85, $62, $02, $85, $01, $0A, $00, $00, $70, $10, $05, $00
    db $50, $14, $86, $01, $12, $00, $00, $40, $10, $06, $00, $60, $6D

Data_069_629C:: ; heuristic: target of a monotone pointer table; C0
    db $A0, $62, $00, $00, $7A, $00, $A8, $62, $FE, $FF, $B4, $62, $01, $85, $01, $58
    db $00, $00, $E0, $18, $05, $00, $50, $00, $01, $85, $01, $58, $00, $00, $48, $18
    db $05, $00, $50, $00

Data_069_62C0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A62C0, $AE

Data_069_636E:: ; heuristic: target of a monotone pointer table; C0
    db $74, $63, $00, $00, $00, $00, $72, $00, $7A, $63, $FF, $FF, $01, $85, $01, $44
    db $00, $00, $80, $60, $05, $00, $50, $48

Data_069_6386:: ; heuristic: target of a monotone pointer table; C0
    db $8C, $63, $00, $00, $00, $00, $73, $00, $92, $63, $FF, $FF, $01, $85, $01, $44
    db $00, $00, $60, $30, $05, $00, $50, $49

Data_069_639E:: ; heuristic: target of a monotone pointer table; C0
    db $A0, $63, $75, $00, $A6, $63, $FF, $FF, $01, $85, $00, $06, $01, $00, $60, $20
    db $05, $00, $50, $4A

Data_069_63B2:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $00, $00, $00, $00
    dw Data_069_63CA
    dw Data_069_641B
    dw Data_069_647D
    dw Data_069_64AB
    dw Data_069_65AF
    dw Data_069_662F
    dw Data_069_663F
    dw Data_069_66BD

Data_069_63CA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A63CA, $51

Data_069_641B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A641B, $62

Data_069_647D:: ; heuristic: target of a monotone pointer table; C0
    db $FC, $FF, $24, $00, $04, $00, $FE, $FF, $9F, $64, $FC, $FF, $03, $00, $04, $00
    db $02, $00, $93, $64, $FF, $FF, $01, $85, $00, $0A, $00, $00, $80, $40, $05, $00
    db $50, $08, $01, $85, $00, $F0, $00, $00, $80, $30, $05, $00, $50, $98

Data_069_64AB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A64AB, $104

Data_069_65AF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A65AF, $80

Data_069_662F:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $FF, $33, $66, $01, $86, $00, $91, $00, $00, $30, $30, $06, $01, $60, $04

Data_069_663F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A663F, $7E

Data_069_66BD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A66BD, $6D
    dw Data_069_675A
    dw Data_069_676A
    dw Data_069_679D
    dw Data_069_67BA
    dw Data_069_67D2
    dw Data_069_6822
    dw Data_069_6867
    dw Data_069_6908
    db $FE, $FF, $3E, $67, $01, $85, $01, $11, $00, $00, $20, $60, $05, $01, $50, $80
    db $FE, $FF, $4E, $67, $01, $85, $01, $1A, $00, $00, $80, $40, $05, $01, $50, $DA

Data_069_675A:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $FF, $5E, $67, $01, $85, $01, $19, $00, $00, $20, $60, $05, $01, $50, $22

Data_069_676A:: ; heuristic: target of a monotone pointer table; C0
    db $FC, $FF, $17, $01, $02, $00, $FF, $FF, $07, $01, $7A, $67, $FE, $FF, $91, $67
    db $02, $85, $01, $10, $00, $00, $50, $20, $05, $00, $50, $20, $86, $01, $18, $00
    db $00, $70, $70, $06, $03, $60, $21, $01, $85, $01, $10, $00, $00, $50, $20, $05
    db $00, $50, $20

Data_069_679D:: ; heuristic: target of a monotone pointer table; C0
    db $22, $00, $A3, $67, $FF, $FF, $02, $85, $01, $15, $00, $00, $50, $60, $05, $02
    db $50, $B7, $86, $01, $12, $00, $00, $50, $70, $06, $02, $60, $B8

Data_069_67BA:: ; heuristic: target of a monotone pointer table; C0
    db $FB, $FF, $02, $00, $02, $00, $FF, $FF, $FE, $FF, $C6, $67, $01, $85, $01, $1A
    db $00, $00, $40, $60, $05, $00, $50, $EA

Data_069_67D2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A67D2, $50

Data_069_6822:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A6822, $45

Data_069_6867:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A6867, $A1

Data_069_6908:: ; heuristic: target of a monotone pointer table; C0
    db $FC, $FF, $25, $00, $04, $00, $FE, $FF, $2E, $69, $FC, $FF, $24, $00, $02, $00
    db $FF, $FF, $21, $00, $22, $69, $FE, $FF, $2E, $69, $01, $85, $01, $1B, $00, $02
    db $40, $40, $05, $01, $50, $14, $02, $85, $01, $1A, $00, $00, $30, $60, $05, $00
    db $50, $1E, $86, $01, $10, $00, $00, $20, $40, $06, $01, $60, $EB

Data_069_6945:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A6945, $1B6

Data_069_6AFB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A6AFB, $232

Data_069_6D2D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A6D2D, $15E

Data_069_6E8B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A6E8B, $60

Data_069_6EEB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A6EEB, $5B

Data_069_6F46:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A6F46, $D9

Data_069_701F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A701F, $68

Data_069_7087:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A7087, $7D

Data_069_7104:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A7104, $6A

Data_069_716E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A716E, $7C

Data_069_71EA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A71EA, $125

Data_069_730F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A730F, $25B

Data_069_756A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A756A, $17A

Data_069_76E4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A76E4, $515
    ds $12, $00
    INCBIN "dwm2-cobi-us.gbc", $1A7C0B, $213

Data_069_7E1E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $04, $85, $01, $22, $00, $00, $60, $30, $05, $03, $50, $2B, $86, $01, $4D, $00
    db $00, $10, $10, $06, $02, $60, $25, $86, $01, $4D, $00, $02, $20, $40, $06, $01
    db $60, $26, $86, $01, $4D, $00, $00, $80, $20, $06, $03, $60, $2D

Data_069_7E4B:: ; heuristic: target of a monotone pointer table; C0
    ds $1B5, $00
