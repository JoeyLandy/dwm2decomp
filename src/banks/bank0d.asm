SECTION "Bank 0D", ROMX[$4000], BANK[$0D]
    db $0D

; ld de, this bank's string table / BeginStringDisplay
; 3 call sites from 3 routines (e.g. ShowString_Bank0D, Func_001_4AD4, Func_00D_5A5C)
BeginStringDisplay_Bank0D::
Func_00D_4001:: ; address name
    ld de, Data_00D_4016
    call BeginStringDisplay
    ret
    db $11, $16, $40, $CD, $FE, $25, $C9

; Func_00D_4001 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
; 3 call sites from 2 routines (e.g. Func_00D_67A3, Func_00D_66ED)
ShowString_Bank0D::
Func_00D_400F:: ; address name
    call BeginStringDisplay_Bank0D
    call RunStringDisplayToEnd
    ret

Data_00D_4016:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_00D_4018

Data_00D_4018:: ; heuristic: target of a monotone pointer table; C0
    dw Data_00D_4078
    dw Data_00D_4078
    dw Data_00D_40B8
    dw Data_00D_40EB
    dw Data_00D_410E
    dw Data_00D_412D
    dw Data_00D_414D
    dw Data_00D_414D
    dw Data_00D_418C
    dw Data_00D_41B2
    dw Data_00D_41D8
    dw Data_00D_4221
    dw Data_00D_423F
    dw Data_00D_423F
    dw Data_00D_423F
    dw Data_00D_423F
    dw Data_00D_42A0
    dw Data_00D_42A0
    dw Data_00D_42E2
    dw Data_00D_4303
    dw Data_00D_4325
    dw Data_00D_4348
    dw Data_00D_436C
    dw Data_00D_4388
    dw Data_00D_43AC
    dw Data_00D_43CF
    dw Data_00D_43F4
    dw Data_00D_4417
    dw Data_00D_443F
    dw Data_00D_4459
    dw Data_00D_447B
    dw Data_00D_449D
    dw Data_00D_44BE
    dw Data_00D_44E6
    dw Data_00D_44FE
    dw Data_00D_4521
    dw Data_00D_452A
    dw Func_00D_4599
    dw Func_00D_4599
    dw Func_00D_4599
    dw Func_00D_4599
    dw Func_00D_45A1
    dw Func_00D_45A8
    dw Func_00D_45B1
    db $BB, $45, $C3, $45, $CB, $45, $D1, $45

Data_00D_4078:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Welcome to the", $F1
    db "Key Shop.", $FA, $F7
    db $EF, $EE, "Do you need any", $EF, $EE, "keys appraised?", $F0

Data_00D_40B8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Okay. Come back if", $F1
    db "you find any Magic", $FA, $F7
    db $EF, $EE, "Keys.", $EF, $EE, $F7
    db $F0

Data_00D_40EB:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Don't come if", $F1
    db "you have no keys.", $F7
    db $F0

Data_00D_410E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Which key should", $F1
    db "I appraise?", $F7
    db $F0

Data_00D_412D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Appraisal will", $F1
    db "cost ", $F9, "0G. OK?", $F0

Data_00D_414D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hah? I'm not", $F1
    db "appraising any", $FA, $F7
    db $EF, $EE, "key if you don't", $EF, $EE, "pay my fee.", $F7
    db $F0

Data_00D_418C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Which Magic Key", $F1
    db "should I appraise?", $F0

Data_00D_41B2:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " That key's been", $F1
    db "appraised already.", $F7
    db $F0

Data_00D_41D8:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You have no more", $F1
    db "Magic Keys that", $FA, $F7
    db $EF, $EE, "need appraisal, it", $EF, $EE, "seems to me.", $F7
    db $F0

Data_00D_4221:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Should I save", $F1
    db "the results?", $F0

Data_00D_423F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Let's see the", $F1
    db "Magic Key, then.", $FA, $F7
    db $EF, $EE, $A4, "Hmmm", $A4, " Hah?", $EF, $EE, "Oh, right", $A4, $FA, $F7
    db $EF, $EE, "I got it! This is", $EF, $EE, "the ", $F9, "0!"
    db $E5, $00, $E4, $D4, $F7, $E9, $FF, $F0

Data_00D_42A0:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Ah, you have", $F1
    db "some TinyMedals?", $FA, $F7
    db $EF, $EE, "Let me relieve you", $EF, $EE, "of them.", $F7
    db $F0

Data_00D_42E2:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ", $A4, "But, I can't", $F1
    db "take this many.", $F7
    db $F0

Data_00D_4303:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I have ", $F9, "0 of", $F1
    db "your TinyMedals.", $F7
    db $F0

Data_00D_4325:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I hope you'll", $F1
    db "find many medals!", $F7
    db $F0

Data_00D_4348:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Want to trade", $F1
    db "medals for prizes?", $F0

Data_00D_436C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Which prize do", $F1
    db "you want?", $F0

Data_00D_4388:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'll trade for", $F1
    db $F9, "0 TinyMedals. OK?", $F0

Data_00D_43AC:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " That requires", $F1
    db "more TinyMedals.", $F7
    db $F0

Data_00D_43CF:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You don't have", $F1
    db "any room for that.", $F7
    db $F0

Data_00D_43F4:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Your key ring is", $F1
    db "already full.", $F7
    db $F0

Data_00D_4417:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You have no more", $F1
    db "room for monsters.", $F7
    db $F0

Data_00D_443F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Fine, we shall", $F1
    db "trade.", $F7
    db $F0

Data_00D_4459:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'll send the egg", $F1
    db "to the farm.", $F7
    db $F0

Data_00D_447B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You can't take", $F1
    db "any more items.", $F7
    db $F0

Data_00D_449D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You can't hold any", $F1
    db "more keys.", $F7
    db $F0

Data_00D_44BE:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You have no more", $F1
    db "room for monsters.", $F7
    db $F0

Data_00D_44E6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Leads to another", $F1
    db "world.", $F0

Data_00D_44FE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tames a monster by", $F1
    db "a great amount.", $F0

Data_00D_4521:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0's egg.", $F0

Data_00D_452A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " At minimum, you", $F1
    db "must have three", $FA, $F7
    db $EF, $EE, "TinyMedals if you", $EF, $EE, "want me to trade.", $FA, $F7
    db $EF, $EE, "I hope you'll find", $EF, $EE, "many medals!", $F7
    db $F0

; no direct call (reached through a table, a jump or a vector)
; reads: hFFFA
Func_00D_4599:: ; heuristic: target of a pointer table; C0
    ld d, $28
    scf
    jr z, Jump_00D_45B6
    dec [hl]
    dec h
    db $F0

; no direct call (reached through a table, a jump or a vector)
Func_00D_45A1:: ; heuristic: target of a pointer table; C0
    ld d, $24
    daa
    inc c
    inc h
    scf
    db $F0

; no direct call (reached through a table, a jump or a vector)
Func_00D_45A8:: ; heuristic: target of a pointer table; C0
    ld de, $3532
    ld sp, $280B
    jr z, Jump_00D_45E7
    db $F0

; no direct call (reached through a table, a jump or a vector)
; reads: hFFFA
Func_00D_45B1:: ; heuristic: target of a pointer table; C0
    inc e
    ld l, $3C
    dec c
    dec [hl]

Jump_00D_45B6::
    inc h
    ld a, [hl+]
    ld [hl-], a
    ld sp, $18F0
    ld h, $37
    ld [hl-], a
    ld a, [hl+]
    ld [hl-], a
    ld sp, $1CF0
    jr z, Jump_00D_45FB
    add hl, sp
    inc h
    ld sp, $F037
    dec c
    inc h
    dec [hl]
    ld h, $2E
    ldh a, [hFFFA]
    add a, b
    rst $10
    rst $00
    dw Jump_00D_45F6
    dw Jump_00D_4635
    dw Jump_00D_46B6
    dw Jump_00D_46C2
    dw Jump_00D_470F
    dw Jump_00D_4710
    dw Jump_00D_45F5
    dw Jump_00D_45F5
    dw Jump_00D_45F5

Jump_00D_45E7::
    push af
    ld b, l
    push af
    ld b, l
    push af
    ld b, l
    push af
    ld b, l
    ld b, c
    ld c, e
    push af
    ld b, l
    ld e, l
    ld c, e

Jump_00D_45F5::
    ret

Jump_00D_45F6::
    ld hl, wD780
    db $01, $6F

Jump_00D_45FB::
    nop
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    db $20

; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: wD7F0, wC920, wC919
; points at: wC364, wBGMapShadow, wD1CC, wD000, wD780
Func_00D_4602:: ; heuristic: target of a pointer table; C0
    ld sp, hl
    ld hl, wC364
    ld de, wBGMapShadow
    ld bc, $0104
    call Func_00D_4E7B
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_00D_4621
    ld hl, wD1CC
    ld de, wD000
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank0D

Jump_00D_4621::
    ld a, $06
    ld [wD7F0], a
    xor a, a
    ld hl, wD780
    inc [hl]
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_4635::
    ld a, [wD781]
    rst $00
    dw Func_00D_463F
    dw Jump_00D_4650
    dw Jump_00D_4692

; 1 call site from 1 routine (e.g. Func_00D_4B98)
; reads: wD781
; writes: wD781
Func_00D_463F::
    ld hl, Data_00D_4F81
    ld de, Data_00D_4F9F
    call Func_00D_4F3D
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_00D_4650::
    ld de, Data_00D_4FBD
    ld hl, wC370
    ld bc, $0803
    call CopyRectTo20ByteRows_Bank0D
    ld a, [wC617]
    ld [wC8C0], a
    ld a, [wC618]
    ld [wC8C1], a
    ld a, [wC619]
    ld [wC8C2], a
    call Number24ToPackedBCD
    farcall Func_015_6676
    ld hl, wC386
    ld de, wD7F3
    ld c, $00

Jump_00D_467F::
    ld a, [de]
    add a, $E0
    ld [hl+], a
    inc de
    inc c
    ld a, c
    cp a, $05
    jr c, Jump_00D_467F
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_00D_4692::
    ld de, Data_00D_4FD5
    ld hl, wC364
    ld bc, $0B07
    call CopyRectTo20ByteRows_Bank0D
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140B
    ld de, $01CC
    call Func_00D_4E05
    xor a, a
    ld [wD781], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

Jump_00D_46B6::
    ld a, $01
    ld [wC89D], a
    farcall Func_015_6478
    ret

Jump_00D_46C2::
    ld a, [wD786]
    and a, a
    jr z, Jump_00D_46CA
    jr Jump_00D_46D0

Jump_00D_46CA::
    xor a, a
    ld [wD7BD], a
    jr Jump_00D_46D5

Jump_00D_46D0::
    ld a, $01
    ld [wD7BD], a

Jump_00D_46D5::
    farcall Func_01D_6026
    ld a, [wD7B9]
    and a, a
    jr z, Jump_00D_46FB
    xor a, a
    ld [wD7FA], a
    ld a, [wD780]
    inc a
    inc a
    ld [wD780], a
    ld a, $70
    ldh [hFFBA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_46FB::
    ld a, $01
    ld [wD7FA], a
    ld a, $02
    ld [wD780], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_470F::
    ret

Jump_00D_4710::
    ld a, [wD781]
    rst $00
    dw Func_00D_473A
    dw Func_00D_473A
    dw Func_00D_473A
    dw Func_00D_473A
    dw Func_00D_473A
    dw Func_00D_473A
    dw Func_00D_4741
    dw Func_00D_473A
    dw Func_00D_473A
    dw Func_00D_473A
    dw Func_00D_473A
    dw Func_00D_473A
    dw Func_00D_47F7
    dw Func_00D_473A
    dw Func_00D_473A
    dw Func_00D_4869
    dw Func_00D_491A
    dw Func_00D_4952
    db $88, $49

; no direct call (reached through a table, a jump or a vector)
Func_00D_473A:: ; heuristic: target of a pointer table; C0
    farcall Func_015_40FA
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD7F9, wD781, wD7AB, wD7BD
; writes: wD7F9, wD7FA, wD781, wC8C0, wC8C1, wC8C2, wC920, wC919
; points at: wD7F4, wC130, wC52D
Func_00D_4741:: ; heuristic: target of a pointer table; C0
    ld a, $02
    ld [wD7F9], a
    farcall Func_01D_66B6
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_00D_4766
    cp a, $FC
    jr z, Jump_00D_4766
    cp a, $FD
    jr z, Jump_00D_476F
    cp a, $FE
    jr z, Jump_00D_4770
    cp a, $FF
    jr z, Jump_00D_478A
    ret

Jump_00D_4766::
    ld a, [wD781]
    sub a, $04
    ld [wD781], a
    ret

Jump_00D_476F::
    ret

Jump_00D_4770::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld a, $01
    ld [wD7FA], a
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ret

Jump_00D_478A::
    xor a, a
    ld [wD7FA], a
    ld a, [wD781]
    add a, $04
    ld [wD781], a
    ld a, [wD7AB]
    ld b, $BC
    ld hl, Data_00D_5097
    call StoreBAtWordTableEntry_Bank0D
    ld a, [wD7BD]
    and a, a
    jr z, Jump_00D_47E0
    call Func_00D_4CF4
    ld a, l
    ld [wC8C0], a
    ld a, h
    ld [wC8C1], a
    xor a, a
    ld [wC8C2], a
    call Number24ToPackedBCD
    farcall Func_015_6676
    ld b, $04
    ld hl, wD7F4

Jump_00D_47C4::
    ld a, [hl]
    cp a, $E3
    jr nz, Jump_00D_47CF
    dec b
    inc hl
    ld a, b
    and a, a
    jr nz, Jump_00D_47C4

Jump_00D_47CF::
    ld de, wC130

Jump_00D_47D2::
    ld a, b
    and a, a
    jr z, Jump_00D_47DD
    ld a, [hl]
    ld [de], a
    inc de
    inc hl
    dec b
    jr Jump_00D_47D2

Jump_00D_47DD::
    ld a, $F0
    ld [de], a

Jump_00D_47E0::
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5, wD7AD, wD781
; writes: wD7F5, wD7B2, wD7B3, wD780, wD781, wD782, wD7FA, wC920, ...
Func_00D_47F7:: ; heuristic: target of a pointer table; C0
    xor a, a
    ld [wD7F5], a
    call Func_00D_4D24
    ld a, [wD7F5]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_00D_480C
    cp a, $FF
    jr z, Jump_00D_4822
    ret

Jump_00D_480C::
    ld a, $02
    ld [wD7FA], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_4822::
    ld a, [wD7AD]
    and a, a
    jp nz, Jump_00D_4852
    ld a, $05
    ld [wD7B2], a
    ld a, $0C
    ld [wD7B3], a
    ld a, $0D
    ld [wD780], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld [wD7FA], a
    farcall Func_01E_7745
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_4852::
    ld a, $01
    ld [wD7FA], a
    ld a, [wD781]
    add a, $03
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD7BD, wD7F1, wD781, wD7F5, wD7F6
; writes: wD7F1, wD7F2, wD7F3, wD781, wD782, wD7FA, wC920, wC919, ...
Func_00D_4869:: ; heuristic: target of a pointer table; C0
    ld a, [wD7BD]
    and a, a
    jr nz, Jump_00D_4894
    ld a, $14
    ld [wD7F1], a
    xor a, a
    ld [wD7F2], a
    ld [wD7F3], a
    farcall Func_01C_440F
    ld a, [wD7F1]
    and a, a
    jr nz, Jump_00D_48AF
    ld a, [wD781]
    add a, $03
    ld [wD781], a
    xor a, a
    ld [wD782], a
    ret

Jump_00D_4894::
    call Func_00D_4CF4
    ld a, l
    ld [wD7F1], a
    ld a, h
    ld [wD7F2], a
    xor a, a
    ld [wD7F3], a
    farcall Func_01C_440F
    ld a, [wD7F1]
    and a, a
    jr z, Jump_00D_48C5

Jump_00D_48AF::
    ld a, $01
    ld [wD7FA], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_48C5::
    farcall SetWD7F5ToWD789Cell4
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, $0E
    call SRAMRecordAddress
    ld a, [hl]
    and a, a
    jr z, Jump_00D_48E9
    xor a, a
    jr Jump_00D_48EB

Jump_00D_48E9::
    ld a, $01

Jump_00D_48EB::
    ld [hl], a
    xor a, a
    ld [rRAMG2], a
    call Func_00D_4CF4
    ld a, l
    ld [wD7F1], a
    ld a, h
    ld [wD7F2], a
    xor a, a
    ld [wD7F3], a
    farcall Func_015_683C
    xor a, a
    ld [wD7FA], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_00D_4BDE)
; reads: wD7B0, wD781
; writes: wD7F1, wD7F2, wD781
; points at: wC3BB, wC462, wC463
Func_00D_491A:: ; heuristic: target of a pointer table; C0
    ld de, Data_00D_5022
    ld hl, wC3BB
    ld bc, $0D09
    call CopyRectTo20ByteRows_Bank0D
    farcall Func_01E_71E1
    ld a, [wD7B0]
    cp a, $02
    jr c, Jump_00D_494A
    ld hl, wC462
    call StoreC5BEC6AtHLStride2_Bank0D
    ld hl, wC463
    ld a, h
    ld [wD7F1], a
    ld a, l
    ld [wD7F2], a
    farcall Func_01E_759A

Jump_00D_494A::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wD7F1, wD7F2, wD781, wC920, wC919
Func_00D_4952:: ; heuristic: target of a pointer table; C0
    ld de, Data_01F_4990
    ld hl, vTiles1 + $4E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, $01
    ld [wD7F1], a
    ld [wD7F2], a
    farcall Func_01D_6320
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    ld a, $07
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret
    db $FA, $82, $D7, $C7
    dw Func_00D_499A
    dw Func_00D_49A2
    dw Func_00D_4A03
    dw Func_00D_4A3F
    dw Func_00D_4A69
    dw Func_00D_4ABF
    dw Func_00D_4ACF

; no direct call (reached through a table, a jump or a vector)
; writes: wD7FA
Func_00D_499A:: ; heuristic: target of a pointer table; C0
    xor a, a
    ld [wD7FA], a
    call Func_00D_4B30
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: hFFC6, hFFC7
; writes: wD7FA, rRAMG2
Func_00D_49A2:: ; heuristic: target of a pointer table; C0
    call Func_00D_4B18
    ld c, $00
    ld de, $0000

Jump_00D_49AA::
    push hl
    push bc
    push de
    ld a, c
    ld de, Data_00D_49FD
    add a, e
    ld e, a
    jr nc, Jump_00D_49B6
    inc d

Jump_00D_49B6::
    ld a, [de]
    ld c, a
    ld a, [hl]
    call LoadSRAMRecordWord
    pop de
    ldh a, [hFFC6]
    add a, e
    ld e, a
    ldh a, [hFFC7]
    adc a, d
    ld d, a
    pop bc
    pop hl
    inc c
    ld a, c
    cp a, $06
    jr c, Jump_00D_49AA
    ld l, e
    ld h, d
    ld a, $06
    call DivideHLByA
    ld a, h
    and a, a
    jr z, Jump_00D_49DC

Jump_00D_49D8::
    ld a, $03
    jr Jump_00D_49F2

Jump_00D_49DC::
    ld a, l
    cp a, $C9
    jr nc, Jump_00D_49D8
    cp a, $65
    jr nc, Jump_00D_49EC
    cp a, $33
    jr nc, Jump_00D_49F0
    xor a, a
    jr Jump_00D_49F2

Jump_00D_49EC::
    ld a, $02
    jr Jump_00D_49F2

Jump_00D_49F0::
    ld a, $01

Jump_00D_49F2::
    ld [wD7FA], a
    xor a, a
    ld [rRAMG2], a
    call Func_00D_4B30
    ret

Data_00D_49FD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $5D, $61, $63, $65, $67, $69

; no direct call (reached through a table, a jump or a vector)
; writes: wD7FA, rRAMG2
Func_00D_4A03:: ; heuristic: target of a pointer table; C0
    call Func_00D_4B18
    ld a, [hl]
    ld c, $3C
    call SRAMRecordAddress
    ld c, $00
    ld b, $00

Jump_00D_4A10::
    ld a, [hl+]
    and a, a
    jr z, Jump_00D_4A19
    cp a, $FF
    jr z, Jump_00D_4A19
    inc b

Jump_00D_4A19::
    inc c
    ld a, c
    cp a, $19
    jr c, Jump_00D_4A10
    ld a, b
    cp a, $06
    jr c, Jump_00D_4A31
    cp a, $0B
    jr c, Jump_00D_4A35
    cp a, $10
    jr c, Jump_00D_4A3A
    ld a, $03
    jp Jump_00D_49F2

Jump_00D_4A31::
    xor a, a
    jp Jump_00D_49F2

Jump_00D_4A35::
    ld a, $01
    jp Jump_00D_49F2

Jump_00D_4A3A::
    ld a, $02
    jp Jump_00D_49F2

; no direct call (reached through a table, a jump or a vector)
; reads: hFFC6
; writes: wD7FA, rRAMG2
Func_00D_4A3F:: ; heuristic: target of a pointer table; C0
    call Func_00D_4B18
    ld a, [hl]
    ld c, $57
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    cp a, $29
    jr c, Jump_00D_4A5B
    cp a, $3D
    jr c, Jump_00D_4A5F
    cp a, $51
    jr c, Jump_00D_4A64
    ld a, $03
    jp Jump_00D_49F2

Jump_00D_4A5B::
    xor a, a
    jp Jump_00D_49F2

Jump_00D_4A5F::
    ld a, $01
    jp Jump_00D_49F2

Jump_00D_4A64::
    ld a, $02
    jp Jump_00D_49F2

; no direct call (reached through a table, a jump or a vector)
; reads: hFFC6, hFFC7
; writes: wD7FA, rRAMG2
Func_00D_4A69:: ; heuristic: target of a pointer table; C0
    call Func_00D_4B18
    ld b, $00
    push hl
    push bc
    ld a, [hl]
    ld c, $6F
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    ld e, a
    pop bc
    pop hl
    push hl
    push de
    push bc
    ld a, [hl]
    ld c, $72
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    cp a, e
    jr c, Jump_00D_4A96
    jr nz, Jump_00D_4A8D
    jr Jump_00D_4A96

Jump_00D_4A8D::
    pop bc
    pop de
    ldh a, [hFFC6]
    ld e, a
    ld b, $01
    push de
    push bc

Jump_00D_4A96::
    pop bc
    pop de
    pop hl
    push hl
    push de
    push bc
    ld a, [hl]
    ld c, $70
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    cp a, e
    jr c, Jump_00D_4AB8
    jr nz, Jump_00D_4AAB
    jr Jump_00D_4AB8

Jump_00D_4AAB::
    pop bc
    pop de
    ldh a, [hFFC6]
    ld e, a
    ldh a, [hFFC7]
    ld d, a
    ld b, $02
    pop hl
    jr Jump_00D_4ABB

Jump_00D_4AB8::
    pop bc
    pop de
    pop hl

Jump_00D_4ABB::
    ld a, b
    jp Jump_00D_49F2

; no direct call (reached through a table, a jump or a vector)
; reads: hFFC6
; writes: wD7FA, rRAMG2
Func_00D_4ABF:: ; heuristic: target of a pointer table; C0
    call Func_00D_4B18
    ld a, [hl]
    ld c, $0E
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    and a, $01
    jp Jump_00D_49F2

; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5, wD7F6
; writes: wD7F1, wD7F2, wD7F3, rRAMG2, rRAMB, wD782, wD781, wC920, ...
Func_00D_4ACF:: ; heuristic: target of a pointer table; C0
    ld a, $14
    ld [wD7F1], a
    xor a, a
    ld [wD7F2], a
    ld [wD7F3], a
    farcall Func_015_683C
    farcall SetWD7F5ToWD789Cell4
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, $6E
    call SRAMRecordAddress
    ld a, $02
    ld [hl], a
    xor a, a
    ld [rRAMG2], a
    xor a, a
    ld [wD782], a
    ld a, $10
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; 5 call sites from 5 routines (e.g. Func_00D_4ABF, Func_00D_4A69, Func_00D_4A3F, Func_00D_4A03, ...)
; reads: wD7F5, wD7F6
; writes: rRAMG2, rRAMB
Func_00D_4B18::
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    farcall SetWD7F5ToWD789Cell4
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ret

; 2 call sites from 2 routines (e.g. Func_00D_49A2, Func_00D_499A)
; reads: wD782
; writes: wD782, wC920, wC919
Func_00D_4B30::
    ld a, [wD782]
    inc a
    ld [wD782], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD781, wD780
; writes: wD781, wD782, wD780
Func_00D_4B41:: ; heuristic: follows a terminator; C0
    farcall Func_01E_4069
    ld a, [wD781]
    cp a, $0A
    ret nz
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, [wD780]
    inc a
    inc a
    ld [wD780], a
    ret
    db $FA, $81, $D7, $C7
    dw Func_00D_4B73
    dw Func_00D_4B98
    dw Func_00D_4BA5
    dw Func_00D_4BDE
    dw Func_00D_4BE1
    dw Func_00D_4BF4
    dw Func_00D_4C17
    dw Func_00D_4C36
    dw Func_00D_4C9C

; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wC526, wD781
; points at: wC49F
Func_00D_4B73:: ; heuristic: target of a pointer table; C0
    ld hl, vTiles2
    ld de, Data_049_4418
    ld b, $49
    call DecompressToVRAM
    ld hl, wC49F
    ld de, Data_049_46DC
    ld b, $49
    ld c, $40
    call CopyFromBankWaitVRAM
    ld a, $7F
    ld [wC526], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; no direct call (reached through a table, a jump or a vector)
Func_00D_4B98:: ; heuristic: target of a pointer table; C0
    ld hl, Data_00D_509F
    ld de, Data_00D_50AF
    call Func_00D_4F3D
    call Func_00D_463F
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
; points at: wC52D
Func_00D_4BA5:: ; heuristic: target of a pointer table; C0
    ld hl, vTiles1 + $400
    ld bc, $0301
    call FillTilesBxC
    ld hl, vTiles1 + $470
    ld bc, $0501
    call FillTilesBxC
    ld hl, vTiles1 + $500
    ld bc, $0F01
    call FillTilesBxC
    ld hl, vTiles1 + $700
    ld bc, $0D01
    call FillTilesBxC
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD7F5, wD781
Func_00D_4BDE:: ; heuristic: target of a pointer table; C0
    call Func_00D_491A

; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD7F5, wD781
Func_00D_4BE1:: ; heuristic: target of a pointer table; C0
    ld a, $01
    ld [wD7F5], a
    farcall Func_01D_6088
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD7F1, wD7F2, wD781
Func_00D_4BF4:: ; heuristic: target of a pointer table; C0
    ld de, Data_01F_4990
    ld hl, vTiles1 + $4E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, $01
    ld [wD7F1], a
    ld [wD7F2], a
    farcall Func_01D_6320
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD7AB, wD781
; writes: wD781
; points at: wC410
Func_00D_4C17:: ; heuristic: target of a pointer table; C0
    ld a, [wD7AB]
    ld b, $BC
    ld hl, Data_00D_5097
    call StoreBAtWordTableEntry_Bank0D
    ld de, Data_00D_50BD
    ld hl, wC410
    ld bc, $0805
    call CopyRectTo20ByteRows_Bank0D
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD7BD, wD781
; writes: wC8C0, wC8C1, wC8C2, wStringIndex, wStringCategory, wD781
; points at: wD7F4, wC130, wC52D
Func_00D_4C36:: ; heuristic: target of a pointer table; C0
    ld a, [wD7BD]
    and a, a
    jr z, Jump_00D_4C78
    call Func_00D_4CF4
    ld a, l
    ld [wC8C0], a
    ld a, h
    ld [wC8C1], a
    xor a, a
    ld [wC8C2], a
    call Number24ToPackedBCD
    farcall Func_015_6676
    ld b, $04
    ld hl, wD7F4

Jump_00D_4C59::
    ld a, [hl]
    cp a, $E3
    jr nz, Jump_00D_4C64
    dec b
    inc hl
    ld a, b
    and a, a
    jr nz, Jump_00D_4C59

Jump_00D_4C64::
    ld de, wC130

Jump_00D_4C67::
    ld a, b
    and a, a
    jr z, Jump_00D_4C71
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr Jump_00D_4C67

Jump_00D_4C71::
    ld a, $F0
    ld [de], a
    ld a, $08
    jr Jump_00D_4C7A

Jump_00D_4C78::
    ld a, $03

Jump_00D_4C7A::
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    farcall ShowString_BankF2
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD7B2, wD7B3
; writes: wC527, hFFBA, wD782, wD780, wD781, wC920, wC919
; points at: wC52D
Func_00D_4C9C:: ; heuristic: target of a pointer table; C0
    farcall Func_004_4AA8
    ld a, $7F
    ld [wC527], a
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    call BGMapAddressAtScroll_Bank0D
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call Func_00D_4E05
    farcall Func_01E_7763
    ld a, $70
    ldh [hFFBA], a
    xor a, a
    ld [wD782], a
    ld a, [wD7B2]
    ld [wD780], a
    ld a, [wD7B3]
    ld [wD781], a
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; 4 call sites from 3 routines (e.g. Func_00D_4C36, Func_00D_4869, Func_00D_4741)
; reads: wD7F5, wD7F6, hFFC6
; writes: rRAMG2, rRAMB
Func_00D_4CF4::
    farcall SetWD7F5ToWD789Cell4
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, $6D
    call LoadSRAMRecordByte
    xor a, a
    ld [rRAMG2], a
    ldh a, [hFFC6]
    ld c, $14
    call Multiply8
    ld a, $14
    add_a_to_hl
    ret

; 5 call sites from 4 routines (e.g. Func_00D_47F7, Func_01B_6814, Func_024_4117, Func_033_562A)
; reads: wC563, wC562, wD7AD
; writes: wD7F5, wD7AD
Func_00D_4D24::
    ld a, [wC563]
    bit 6, a
    jr nz, Jump_00D_4D44
    bit 7, a
    jr nz, Jump_00D_4D62
    ld a, [wC562]
    bit 0, a
    jp nz, Jump_00D_4D72
    bit 1, a
    jp nz, Jump_00D_4D80
    call Func_00D_4D86
    xor a, a
    ld [wD7F5], a
    ret

Jump_00D_4D44::
    call Func_00D_4DA4
    ld a, [wD7AD]
    and a, a
    jr nz, Jump_00D_4D51
    ld a, $01
    jr Jump_00D_4D52

Jump_00D_4D51::
    dec a

Jump_00D_4D52::
    ld [wD7AD], a
    ld a, $69
    call StoreWC60B
    call Func_00D_4DA0
    xor a, a
    ld [wD7F5], a
    ret

Jump_00D_4D62::
    call Func_00D_4DA4
    ld a, [wD7AD]
    cp a, $01
    jr c, Jump_00D_4D6F
    xor a, a
    jr Jump_00D_4D52

Jump_00D_4D6F::
    inc a
    jr Jump_00D_4D52

Jump_00D_4D72::
    ld a, $69
    call StoreWC60B
    call Func_00D_4DA8
    ld a, $FF
    ld [wD7F5], a
    ret

Jump_00D_4D80::
    ld a, $FE
    ld [wD7F5], a
    ret

; 1 call site from 1 routine (e.g. Func_00D_4D24)
; reads: wC564, wD7AE, wD7AD
; writes: wD7AE
Func_00D_4D86::
    ld a, [wC564]
    cp a, $14
    jr c, Func_00D_4DA0
    ld a, [wD7AE]
    inc a
    ld [wD7AE], a
    cp a, $10
    jr c, Func_00D_4DA0
    cp a, $18
    jr c, Func_00D_4DA4
    xor a, a
    ld [wD7AE], a

; 1 call site from 1 routine (e.g. Func_00D_4D24)
; reads: wD7AD
Func_00D_4DA0::
    ld b, $BB
    jr Jump_00D_4DAA

; 2 call sites from 1 routine (e.g. Func_00D_4D24)
; reads: wD7AD
Func_00D_4DA4::
    ld b, $C3
    jr Jump_00D_4DAA

; 1 call site from 1 routine (e.g. Func_00D_4D24)
; reads: wD7AD
Func_00D_4DA8::
    ld b, $BC

Jump_00D_4DAA::
    ld a, [wD7AD]
    add a, a
    ld hl, Func_00D_4DC7
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank0D
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: rSVBK
Func_00D_4DC7:: ; heuristic: follows a terminator; C0
    dec l
    ld bc, $016D

; Copies a rectangle of B bytes by C rows from [DE] to [HL], rows 20 ($14) bytes apart; on CGB it then zero-fills the same-shaped rectangle at HL + $0E68 with rSVBK = 2 and restores rSVBK = 0 (the same 58 bytes appear in 8 banks)
; 20 call sites from 15 routines (e.g. Func_00D_7352, Func_00D_71BD, Func_00D_6509, Func_00D_69B3, ...)
; reads: wIsCGB
; writes: rSVBK
CopyRectTo20ByteRows_Bank0D::
Func_00D_4DCB:: ; address name
    push hl
    push bc

Jump_00D_4DCD::
    push bc
    push hl

Jump_00D_4DCF::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_00D_4DCF
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_00D_4DCD
    pop bc
    pop hl
    ld a, [wIsCGB]
    and a, a
    ret z
    ld a, l
    add a, $68
    ld l, a
    ld a, h
    adc a, $0E
    ld h, a
    ld a, $02
    ldh [rSVBK], a

Jump_00D_4DF1::
    push bc
    push hl

Jump_00D_4DF3::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_00D_4DF3
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_00D_4DF1
    xor a, a
    ldh [rSVBK], a
    ret

; 30 call sites from 24 routines (e.g. Func_00D_5C00, Func_00D_5800, Func_00D_74FC, Func_00D_7352, ...)
; reads: wC554, wC555, wIsCGB
; writes: wC554, wC555, rVBK, rSVBK
; points at: wBGMapShadow, wD000
Func_00D_4E05:: ; heuristic: follows a terminator; C0
    push de
    push bc
    push hl
    ld hl, wBGMapShadow
    add hl, de
    ld e, l
    ld d, h
    pop hl
    push hl
    call Func_000_18A5
    pop hl
    push hl
    ld a, l
    add a, $C1
    ld [wC554], a
    ld a, h
    adc a, $01
    ld [wC555], a
    ld a, [wC554]
    cp a, $61
    jr nz, Jump_00D_4E39
    ld a, [wC555]
    cp a, $9B
    jr nz, Jump_00D_4E39
    ld a, $C1
    ld [wC554], a
    ld a, $99
    ld [wC555], a

Jump_00D_4E39::
    pop hl
    pop bc
    pop de
    ld a, [wIsCGB]
    and a, a
    ret z
    ld a, $01
    ldh [rVBK], a
    ld a, $02
    ldh [rSVBK], a
    push hl
    ld hl, wD000
    add hl, de
    ld e, l
    ld d, h
    pop hl
    call Func_000_18A5
    xor a, a
    ldh [rSVBK], a
    ldh [rVBK], a
    ret

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX, hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
; 35 call sites from 29 routines (e.g. Func_00D_4DA8, Func_00D_5CD9, Func_00D_4EA4, Func_00D_5C00, ...)
; reads: hScrollY, hScrollX
BGMapAddressAtScroll_Bank0D::
Func_00D_4E5A:: ; address name
    ld hl, vBGMap0
    ldh a, [hScrollY]
    and a, $F8
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ldh a, [hScrollX]
    srl a
    srl a
    srl a
    add_a_to_hl
    ret

; 6 call sites from 5 routines (e.g. Func_00D_4ED5, Func_00D_4602, Func_00D_74FC, Func_00D_63F6, ...)
Func_00D_4E7B:: ; heuristic: follows a terminator; C0
    ld a, [de]
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Func_00D_4E7B
    ret

; With rSVBK = 2, copies BC bytes from [DE] to [HL], each ANDed with $07; then rSVBK = 0 (the same 18 bytes appear in 7 banks)
; 6 call sites from 5 routines (e.g. Func_00D_4ED5, Func_00D_4602, Func_00D_74FC, Func_00D_63F6, ...)
; writes: rSVBK
CopyLow3BitsToWRAMBank2_Bank0D:: ; heuristic: follows a terminator; C0
Func_00D_4E84:: ; address name
    ld a, $02
    ldh [rSVBK], a

Jump_00D_4E88::
    ld a, [de]
    and a, $07
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_00D_4E88
    xor a, a
    ldh [rSVBK], a
    ret

; HL = table of 16-bit addresses, A = index: stores B at the address in entry A; keeps BC; clobbers A, DE, HL (the same 14 bytes appear in 8 banks)
; 9 call sites from 9 routines (e.g. Func_00D_5800, Func_00D_4F29, Func_00D_67F7, Func_00D_66CE, ...)
StoreBAtWordTableEntry_Bank0D:: ; heuristic: follows a terminator; C0
Func_00D_4E96:: ; address name
    push bc
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop bc
    ld a, b
    ld [de], a
    ret

; 2 call sites from 2 routines (e.g. Func_00D_5800, Func_00D_6E88)
Func_00D_4EA4:: ; heuristic: follows a terminator; C0
    push de
    call BGMapAddressAtScroll_Bank0D
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, $C5
    ld [hl], a
    ei
    inc hl
    inc hl
    di
    call WaitForVRAMAccess
    ld a, $BE
    ld [hl], a
    ei
    inc hl
    inc hl
    di
    call WaitForVRAMAccess
    ld a, $C6
    ld [hl], a
    ei
    ret

; [HL] = $C5, [HL+2] = $BE, [HL+4] = $C6; HL ends at HL+4; clobbers A (the same 14 bytes appear in 8 banks)
; 4 call sites from 4 routines (e.g. Func_00D_5800, Func_00D_6E88, Func_00D_5A05, Func_00D_491A)
StoreC5BEC6AtHLStride2_Bank0D:: ; heuristic: follows a terminator; C0
Func_00D_4EC7:: ; address name
    ld a, $C5
    ld [hl], a
    inc hl
    inc hl
    ld a, $BE
    ld [hl], a
    inc hl
    inc hl
    ld a, $C6
    ld [hl], a
    ret

; 4 call sites from 4 routines (e.g. Func_00D_720E, Func_00D_5BDF, Func_00D_6509, Func_00D_517A)
; reads: wD7F1, wD7F2, wIsCGB
; points at: wBGMapShadow, wD000
Func_00D_4ED5:: ; heuristic: follows a terminator; C0
    push bc
    push hl
    push de
    ld de, wBGMapShadow
    add hl, de
    pop de
    push de
    push hl
    ld hl, wBGMapShadow
    add hl, de
    ld e, l
    ld d, h
    pop hl
    ld a, [wD7F1]
    ld b, a
    ld a, [wD7F2]
    ld c, a
    call Func_00D_4E7B
    pop de
    pop hl
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_00D_4F16
    push hl
    push de
    ld de, wD000
    add hl, de
    pop de
    push de
    push hl
    ld hl, wD000
    add hl, de
    ld e, l
    ld d, h
    pop hl
    ld a, [wD7F1]
    ld b, a
    ld a, [wD7F2]
    ld c, a
    call CopyLow3BitsToWRAMBank2_Bank0D
    pop de
    pop hl

Jump_00D_4F16::
    pop bc
    ld a, $14
    add_a_to_hl
    ld a, $14
    add a, e
    ld e, a
    jr nc, Jump_00D_4F25
    inc d

Jump_00D_4F25::
    dec c
    jr nz, Func_00D_4ED5
    ret

; 2 call sites from 2 routines (e.g. Func_00D_69E8, Func_00D_5AE3)
Func_00D_4F29::
    ld a, c
    ld b, a
    ld c, $00

Jump_00D_4F2D::
    ld a, c
    push bc
    ld b, $C3
    push hl
    call StoreBAtWordTableEntry_Bank0D
    pop hl
    pop bc
    inc c
    ld a, c
    cp a, b
    jr c, Jump_00D_4F2D
    ret

; 3 call sites from 3 routines (e.g. Func_00D_7637, Func_00D_4B98, Func_00D_463F)
; reads: wD785
; writes: wD785, wD784
Func_00D_4F3D::
    push hl
    push de
    ld a, [wD785]
    add a, a
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    jp z, Jump_00D_4F77
    ld e, a
    inc hl
    ld h, [hl]
    ld l, e
    pop de
    push de
    push hl
    ld a, [wD785]
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_00D_4F5E
    inc d

Jump_00D_4F5E::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld d, a
    ld e, l
    pop hl
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    pop de
    pop hl
    ld a, [wD785]
    inc a
    ld [wD785], a
    jr Func_00D_4F3D

Jump_00D_4F77::
    pop de
    pop hl
    xor a, a
    ld [wD785], a
    ld [wD784], a
    ret

Data_00D_4F81:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $40, $8A, $50, $8A, $60, $8A, $70, $8A, $80, $8A, $90, $8A, $A0, $8A, $B0, $8A
    db $C0, $8A, $D0, $8A, $E0, $8A, $F0, $8A, $E0, $8E, $F0, $8E, $FF, $FF

Data_00D_4F9F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $F0, $40, $A0, $43, $50, $42, $00, $43, $90, $43, $80, $43, $90, $42, $C0, $40
    db $70, $43, $C0, $43, $D0, $42, $10, $49, $10, $49, $10, $49, $FF, $FF

Data_00D_4FBD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $BF, $C3, $C3, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_00D_4FD5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $034FD5, $4D

Data_00D_5022:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $035022, $75

Data_00D_5097:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $D0, $C3, $F8, $C3, $20, $C4, $48, $C4

Data_00D_509F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $97, $10, $97, $20, $97, $30, $97, $40, $97, $50, $97, $60, $97, $FF, $FF

Data_00D_50AF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $30, $41, $20, $43, $A0, $42, $30, $43, $90, $41, $50, $41, $FF, $FF

Data_00D_50BD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $C3, $70, $71, $72, $73, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $74, $75, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; 1 call site from 1 routine (e.g. Func_010_6621)
; reads: wD788
Func_00D_50E5::
    ld a, [wD788]
    rst $00
    dw Func_00D_50F1
    dw Func_00D_50F8
    dw Func_00D_50F1
    dw Func_00D_50F1

; no direct call (reached through a table, a jump or a vector)
Func_00D_50F1:: ; heuristic: target of a pointer table; C0
    farcall Func_015_4001
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD788
; writes: wD784, wD785, wD780, wD781, wC46B, wD788, wC52D, wC52E, ...
Func_00D_50F8:: ; heuristic: target of a pointer table; C0
    call Func_000_222B
    ld de, Data_01F_4910
    ld hl, vTiles1 + $700
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4910
    ld hl, vTiles1 + $710
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4910
    ld hl, vTiles1 + $720
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    xor a, a
    ld [wD784], a
    ld [wD785], a
    ld [wD780], a
    ld [wD781], a
    ld [wC46B], a
    ld a, [wD788]
    inc a
    ld [wD788], a
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_010_661A)
; reads: wD780
Func_00D_5159::
    ld a, [wD780]
    rst $00
    dw Jump_00D_516B
    dw Jump_00D_5172
    dw Jump_00D_51E2
    dw Jump_00D_5221
    dw Jump_00D_52A7
    dw Jump_00D_52AB
    dw Jump_00D_530F

Jump_00D_516B::
    ld hl, $45D1
    ld b, $0D
    rst $10
    ret

Jump_00D_5172::
    ld a, [wD781]
    rst $00
    dw Func_00D_517A
    dw Jump_00D_51B6

; 1 call site from 1 routine (e.g. Func_00D_5342)
; reads: wD781
; writes: wD781
Func_00D_517A::
    ld de, Data_01F_4210
    ld hl, vTiles1 + $700
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4120
    ld hl, vTiles1 + $710
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4190
    ld hl, vTiles1 + $720
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4330
    ld hl, vTiles1 + $730
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_00D_51B6::
    ld de, Data_00D_550A
    ld hl, wC412
    ld bc, $0605
    call CopyRectTo20ByteRows_Bank0D
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    ld a, $6C
    call StoreWC60B
    xor a, a
    ld [wD7FA], a
    ld [wD781], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

Jump_00D_51E2::
    farcall Func_01D_6540
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_00D_51F6
    cp a, $FF
    jr z, Jump_00D_5205
    ret

Jump_00D_51F6::
    ld a, $01
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_5205::
    ld a, [wD7FA]
    cp a, $01
    jr z, Jump_00D_51F6
    ld a, [wD780]
    inc a
    ld [wD780], a
    xor a, a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_5221::
    ld a, [wD781]
    rst $00
    dw Jump_00D_522B
    dw Func_00D_525F
    dw Jump_00D_5280

Jump_00D_522B::
    ld de, Data_00D_552E
    ld hl, wC364
    ld bc, $0809
    call CopyRectTo20ByteRows_Bank0D
    ld c, $05
    ld hl, $027A
    ld de, $00AE
    xor a, a
    ld [wD7F1], a
    ld a, $06
    ld [wD7F2], a
    call Func_00D_4ED5
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; 1 call site from 1 routine (e.g. Func_00D_5342)
; reads: wD781
; writes: wC52D, wC52E, wC52F, wC530, wD781
Func_00D_525F::
    ld hl, vTiles1 + $500
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0F01
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_00D_5280::
    call Func_000_222B
    ld de, Data_00D_5576
    ld hl, wC364
    ld bc, $0809
    call CopyRectTo20ByteRows_Bank0D
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    xor a, a
    ld [wD781], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

Jump_00D_52A7::
    call Func_00D_5412
    ret

Jump_00D_52AB::
    ld a, [wD786]
    ld hl, wC6FE
    add_a_to_hl
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    push hl
    ld a, [hl]
    ld c, $0E
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    and a, $01
    ld [wD7F2], a
    pop hl
    push hl
    ld a, [hl]
    ld c, $0D
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    and a, $1F
    ld [wD7F3], a
    pop hl
    push hl
    ld a, [hl]
    ld c, $0B
    call LoadSRAMRecordWord
    ldh a, [hFFC6]
    ld [wD7F4], a
    ldh a, [hFFC7]
    ld [wD7F5], a
    pop hl
    ld a, [hl]
    ld [wD7B4], a
    ld a, $03
    ld [wD7F1], a
    ld [rRAMG2], a
    farcall Func_014_5CA8
    ld a, [wD7F5]
    cp a, $FF
    ret nz
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

Jump_00D_530F::
    ld a, [wD781]
    rst $00
    dw Func_00D_531D
    dw Func_00D_5342
    dw Func_00D_534E
    dw Func_00D_53A4
    dw Func_00D_53BB

; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wC526, wD781
; points at: wC49F
Func_00D_531D:: ; heuristic: target of a pointer table; C0
    ld hl, vTiles2
    ld de, Data_049_4832
    ld b, $49
    call DecompressToVRAM
    ld hl, wC49F
    ld de, Data_049_4AC5
    ld b, $49
    ld c, $40
    call CopyFromBankWaitVRAM
    ld a, $7F
    ld [wC526], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wD781
Func_00D_5342:: ; heuristic: target of a pointer table; C0
    call Func_00D_517A
    call Func_00D_525F
    ld a, $02
    ld [wD781], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD786, wD781
; writes: rRAMG2, rRAMB, wC52D, wC52E, wC52F, wC530, wD781
; points at: wC6FE, wC8CF
Func_00D_534E:: ; heuristic: target of a pointer table; C0
    ld a, [wD786]
    ld hl, wC6FE
    add_a_to_hl
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, $01
    call SRAMRecordAddress
    ld de, wC8CF
    ld c, $00

Jump_00D_536D::
    ld a, [de]
    cp a, $F0
    jr z, Jump_00D_537C
    ld [hl+], a
    inc de
    inc c
    ld a, c
    cp a, $0A
    jr c, Jump_00D_536D
    jr Jump_00D_537F

Jump_00D_537C::
    ld a, $F0
    ld [hl], a

Jump_00D_537F::
    xor a, a
    ld [rRAMG2], a
    call Func_000_222B
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wStringCategory, wStringIndex, wD781
Func_00D_53A4:: ; heuristic: target of a pointer table; C0
    xor a, a
    ld [wStringCategory], a
    ld a, $23
    ld [wStringIndex], a
    farcall ShowString_BankF2
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC527, hFFBA, wD782, wD781, wD780, wC52D, wC52E, wC52F, ...
Func_00D_53BB:: ; heuristic: target of a pointer table; C0
    farcall Func_004_4AA8
    ld a, $7F
    ld [wC527], a
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    call BGMapAddressAtScroll_Bank0D
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call Func_00D_4E05
    ld a, $70
    ldh [hFFBA], a
    xor a, a
    ld [wD782], a
    ld [wD781], a
    ld a, $04
    ld [wD780], a
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_00D_525F)
; reads: wC563, wC562, wD780, wC6FD, wD786
; writes: wD7FA, wD780, wD7AB, wD7AD, wD7AF, wC920, wC919, wCFA8, ...
Func_00D_5412::
    ld a, [wC563]
    bit 6, a
    jr nz, Jump_00D_542E
    bit 7, a
    jr nz, Jump_00D_5460
    ld a, [wC562]
    bit 0, a
    jp nz, Jump_00D_5479
    bit 1, a
    jp nz, Jump_00D_54A6
    call Func_00D_54C1
    ret

Jump_00D_542E::
    call Func_00D_54DF
    ld a, [wC6FD]
    cp a, $02
    jr c, Jump_00D_543E
    ld a, [wD786]
    and a, a
    jr nz, Jump_00D_5449

Jump_00D_543E::
    ld a, [wC6FD]
    dec a
    ld [wD786], a
    call Func_00D_54C1
    ret

Jump_00D_5449::
    dec a

Jump_00D_544A::
    ld [wD786], a
    xor a, a
    ld [wD7AB], a
    ld [wD7AD], a
    ld [wD7AF], a
    call Func_00D_54DB
    ld a, $69
    call StoreWC60B
    ret

Jump_00D_5460::
    call Func_00D_54DF
    ld a, [wC6FD]
    dec a
    ld b, a
    ld a, [wD786]
    cp a, b
    jr c, Jump_00D_5476
    xor a, a
    ld [wD786], a
    call Func_00D_54C1
    ret

Jump_00D_5476::
    inc a
    jr Jump_00D_544A

Jump_00D_5479::
    ld a, $69
    call StoreWC60B
    call Func_00D_54E3
    xor a, a
    ld [wD7FA], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    xor a, a
    ld [wD7AB], a
    ld [wD7AD], a
    ld [wD7AF], a
    ld [wCFA8], a
    ld [wCFA9], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_54A6::
    ld a, $01
    ld [wD7FA], a
    ld [wD780], a
    ld [wD7AB], a
    ld [wD7AD], a
    ld [wD7AF], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; 3 call sites from 1 routine (e.g. Func_00D_5412)
; reads: wC564, wD787, wD786
; writes: wD787
Func_00D_54C1::
    ld a, [wC564]
    cp a, $14
    jr c, Func_00D_54DB
    ld a, [wD787]
    inc a
    ld [wD787], a
    cp a, $10
    jr c, Func_00D_54DB
    cp a, $18
    jr c, Func_00D_54DF
    xor a, a
    ld [wD787], a

; 1 call site from 1 routine (e.g. Func_00D_5412)
; reads: wD786
Func_00D_54DB::
    ld b, $BB
    jr Jump_00D_54E5

; 2 call sites from 1 routine (e.g. Func_00D_5412)
; reads: wD786
Func_00D_54DF::
    ld b, $C3
    jr Jump_00D_54E5

; 1 call site from 1 routine (e.g. Func_00D_5412)
; reads: wD786
Func_00D_54E3::
    ld b, $BC

Jump_00D_54E5::
    ld a, [wD786]
    sla a
    ld hl, Data_00D_5504
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    push de
    call BGMapAddressAtScroll_Bank0D
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

Data_00D_5504:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $61, $00, $A1, $00, $E1, $00

Data_00D_550A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $CE, $CF, $DF, $B7, $B6, $C3, $C3, $C3
    db $C3, $B7, $B6, $C3, $A5, $F3, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B5, $A1, $C3
    db $C9, $C3, $F1, $C3

Data_00D_552E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $03552E, $48

Data_00D_5576:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $035576, $48

; 1 call site from 1 routine (e.g. Func_010_6628)
; reads: wD780
Func_00D_55BE::
    ld a, [wD780]
    rst $00
    dw Jump_00D_55CA
    dw Jump_00D_5633
    dw Jump_00D_56A9
    dw Jump_00D_5722

Jump_00D_55CA::
    ld hl, wD780
    ld bc, $006F

Jump_00D_55D0::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_00D_55D0
    ld hl, wC364
    ld de, wBGMapShadow
    ld bc, $0104
    call Func_00D_4E7B
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_00D_55F5
    ld hl, wD1CC
    ld de, wD000
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank0D

Jump_00D_55F5::
    ld a, $07
    ld [wD7F0], a
    ld a, $70
    ldh [hFFBA], a
    ld de, Data_01F_4AD0
    ld hl, vTiles1 + $4A0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4180
    ld hl, vTiles2 + $760
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4330
    ld hl, vTiles2 + $770
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, wD780
    inc [hl]
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_5633::
    ld a, [wD781]
    rst $00
    dw Jump_00D_563B
    dw Jump_00D_567D

Jump_00D_563B::
    ld de, Data_00D_4FBD
    ld hl, wC370
    ld bc, $0803
    call CopyRectTo20ByteRows_Bank0D
    ld a, [wC617]
    ld [wC8C0], a
    ld a, [wC618]
    ld [wC8C1], a
    ld a, [wC619]
    ld [wC8C2], a
    call Number24ToPackedBCD
    farcall Func_015_6676
    ld hl, wC386
    ld de, wD7F3
    ld c, $00

Jump_00D_566A::
    ld a, [de]
    add a, $E0
    ld [hl+], a
    inc de
    inc c
    ld a, c
    cp a, $05
    jr c, Jump_00D_566A
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_00D_567D::
    ld de, Data_00D_6189
    ld hl, wC412
    ld bc, $0605
    call CopyRectTo20ByteRows_Bank0D
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    ld a, $6C
    call StoreWC60B
    xor a, a
    ld [wD7FA], a
    ld [wD781], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

Jump_00D_56A9::
    farcall Func_01D_6540
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_00D_56BD
    cp a, $FF
    jr z, Jump_00D_56CC
    ret

Jump_00D_56BD::
    ld a, $02
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_56CC::
    ld a, [wD7FA]
    cp a, $01
    jr z, Jump_00D_56BD
    call Func_00D_5702
    cp a, $FF
    jr nz, Jump_00D_56E9
    ld a, $01
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_56E9::
    xor a, a
    ld [wD7FA], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    xor a, a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_00D_55BE)
Func_00D_5702::
    ld c, $00

Jump_00D_5704::
    ld a, c
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $C7
    ld h, a
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_00D_5720
    inc c
    ld a, c
    cp a, $20
    jr c, Jump_00D_5704
    ld a, $FF
    ret

Jump_00D_5720::
    xor a, a
    ret

Jump_00D_5722::
    ld a, [wD781]
    rst $00
    dw Jump_00D_5766
    dw Jump_00D_5789
    dw Func_00D_57F5
    dw Func_00D_585C
    dw Func_00D_5872
    dw Func_00D_5891
    dw Func_00D_5AB4
    dw Func_00D_595C
    dw Func_00D_5AE3
    dw Func_00D_5A3C
    dw Func_00D_5A4A
    dw Func_00D_5A5C
    dw Func_00D_5AB4
    dw Func_00D_5B06
    dw Func_00D_5B4A
    dw Func_00D_5BBF
    dw Func_00D_5BDF
    dw Func_00D_5C17
    dw Func_00D_574C

; no direct call (reached through a table, a jump or a vector)
; writes: wC527, wD7FA, wC920, wC919
Func_00D_574C:: ; heuristic: target of a pointer table; C0
    farcall Func_004_4AA8
    ld a, $7F
    ld [wC527], a
    ld a, $01
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_5766::
    ld de, Data_00D_61A7
    ld hl, wC3B8
    ld bc, $1009
    call CopyRectTo20ByteRows_Bank0D
    call Func_00D_60C3
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_00D_5789::
    ld hl, vTiles2 + $700
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0601
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ld hl, vTiles1 + $240
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0C01
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ld hl, vTiles1 + $500
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0C01
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ld hl, vTiles1 + $6E0
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1201
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; no direct call (reached through a table, a jump or a vector)
; points at: wC3CE
Func_00D_57F5:: ; heuristic: target of a pointer table; C0
    ld de, Data_00D_6237
    ld hl, wC3CE
    ld bc, $0D07
    db $CD, $CB

; no direct call (reached through a table, a jump or a vector)
; reads: wD7B0, wD7AB, wD781
; writes: wD7F5, wD7F1, wD7F2, wD781
; points at: wC462, wC463
Func_00D_5800:: ; heuristic: target of a pointer table; C0
    ld c, l
    xor a, a
    ld [wD7F5], a
    call Func_00D_5C87
    ld a, [wD7B0]
    cp a, $02
    jr c, Jump_00D_583D
    ld de, $018E
    call Func_00D_4EA4
    ld hl, wC462
    call StoreC5BEC6AtHLStride2_Bank0D
    ld de, $018F
    ld a, d
    ld [wD7F1], a
    ld a, e
    ld [wD7F2], a
    farcall Func_01E_7564
    ld hl, wC463
    ld a, h
    ld [wD7F1], a
    ld a, l
    ld [wD7F2], a
    farcall Func_01E_759A

Jump_00D_583D::
    ld a, [wD7AB]
    ld b, $BB
    ld hl, Data_00D_62B0
    call StoreBAtWordTableEntry_Bank0D
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD7F5, wD781
Func_00D_585C:: ; heuristic: target of a pointer table; C0
    xor a, a
    ld [wD7F5], a
    call Func_00D_5DED
    xor a, a
    ld [wD7F5], a
    call Func_00D_5D26
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD7AB, wD781
; writes: wD781
Func_00D_5872:: ; heuristic: target of a pointer table; C0
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    ld a, [wD7AB]
    ld b, $C3
    ld hl, Data_00D_62B0
    call StoreBAtWordTableEntry_Bank0D
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC563, wD7F9, wD7F5, wD7F6, wD7AB, wD781
; writes: wD7F9, wD7FA, wC52D, wC52E, wC52F, wC530, wC920, wC919, ...
; points at: wC130
Func_00D_5891:: ; heuristic: target of a pointer table; C0
    ld a, [wC563]
    bit 2, a
    jr nz, Jump_00D_58B9
    ld a, $03
    ld [wD7F9], a
    farcall Func_01D_66B6
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_00D_58C0
    cp a, $FC
    jr z, Jump_00D_58C0
    cp a, $FE
    jr z, Jump_00D_58C9
    cp a, $FF
    jr z, Jump_00D_58D8
    ret

Jump_00D_58B9::
    farcall Func_0F2_633B
    ret

Jump_00D_58C0::
    ld a, [wD781]
    sub a, $04
    ld [wD781], a
    ret

Jump_00D_58C9::
    ld a, $02
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_58D8::
    farcall SetWD7F5ToWD789Cell4
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $C7
    ld h, a
    ld a, [hl]
    cp a, $FE
    jr z, Jump_00D_591E
    ld a, $01
    ld [wD7FA], a
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_591E::
    ld a, [wD7AB]
    ld b, $BC
    ld hl, Data_00D_62B0
    call StoreBAtWordTableEntry_Bank0D
    ld de, wC130
    ld a, $01
    call Func_00D_6120
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wD7FA], a
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD7F9, wD7FA, wD7F1, wD781
; writes: wD7F1, wD7F2, wD7F3, wD7FA, wC920, wC919, wD781, wD782, ...
Func_00D_595C:: ; heuristic: target of a pointer table; C0
    farcall Func_01D_6540
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_00D_5970
    cp a, $FF
    jr z, Jump_00D_599F
    ret

Jump_00D_5970::
    call Func_00D_5A05
    ld a, $02
    ld [wD7FA], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_599F::
    ld a, [wD7FA]
    cp a, $01
    jr z, Jump_00D_5970
    xor a, a
    call Func_00D_6120
    ld a, l
    ld [wD7F1], a
    ld a, h
    ld [wD7F2], a
    xor a, a
    ld [wD7F3], a
    farcall Func_01C_440F
    ld a, [wD7F1]
    cp a, $FF
    jr nz, Jump_00D_59D2
    ld a, $01
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_59D2::
    call Func_00D_5A05
    xor a, a
    ld [wD7FA], a
    ld a, [wD781]
    inc a
    inc a
    ld [wD781], a
    xor a, a
    ld [wD782], a
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; 2 call sites from 1 routine (e.g. Func_00D_595C)
; reads: wD7B0
; writes: wD7F1, wD7F2
; points at: wC412, wC462, wC463
Func_00D_5A05::
    ld de, Data_00D_6292
    ld hl, wC412
    ld bc, $0605
    call CopyRectTo20ByteRows_Bank0D
    ld a, [wD7B0]
    cp a, $02
    jr c, Jump_00D_5A2F
    ld hl, wC462
    call StoreC5BEC6AtHLStride2_Bank0D
    ld hl, wC463
    ld a, h
    ld [wD7F1], a
    ld a, l
    ld [wD7F2], a
    farcall Func_01E_759A

Jump_00D_5A2F::
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
Func_00D_5A3C:: ; heuristic: target of a pointer table; C0
    farcall Func_015_645F
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wStringCategory, wD781
Func_00D_5A4A:: ; heuristic: target of a pointer table; C0
    farcall Func_015_6B00
    xor a, a
    ld [wStringCategory], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD782, wC52B, wD781
; writes: wC52D, wC52E, wC52F, wC530, wD782, wD781, wC920, wC919, ...
Func_00D_5A5C:: ; heuristic: target of a pointer table; C0
    call Func_00D_615E
    ld a, [wD782]
    cp a, $02
    jr z, Jump_00D_5A87
    cp a, $03
    jr z, Jump_00D_5A9A
    farcall Func_015_642D
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ret

Jump_00D_5A87::
    ld a, $0B
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank0D
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_00D_5A9A::
    ld a, [wC52B]
    and a, a
    ret nz
    xor a, a
    ld [wD782], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD7FA, wD782, wD781
; points at: wC412
Func_00D_5AB4:: ; heuristic: target of a pointer table; C0
    call Func_00D_615E
    ld de, Data_00D_6189
    ld hl, wC412
    ld bc, $0605
    call CopyRectTo20ByteRows_Bank0D
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    ld a, $6C
    call StoreWC60B
    xor a, a
    ld [wD7FA], a
    ld [wD782], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wD781, wC920, wC919
Func_00D_5AE3:: ; heuristic: target of a pointer table; C0
    ld c, $04
    ld hl, Data_00D_62B0
    call Func_00D_4F29
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    ld a, $05
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD7F9, wD7FA, wD781
; writes: wD7FA, wD781, wD782, wC920, wC919
Func_00D_5B06:: ; heuristic: target of a pointer table; C0
    farcall Func_01D_6540
    ld a, [wD7F9]
    cp a, $FE
    jr z, Jump_00D_5B1B
    cp a, $FF
    jr z, Jump_00D_5B27
    call Func_00D_615E
    ret

Jump_00D_5B1B::
    call Func_00D_5C47
    ld a, [wD781]
    add a, $05
    ld [wD781], a
    ret

Jump_00D_5B27::
    ld a, [wD7FA]
    cp a, $01
    jr z, Jump_00D_5B1B
    call Func_00D_615E
    xor a, a
    ld [wD7FA], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wD782], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD782, wC8C3, wD781, wD7F5, wD7F6
; writes: wD7FA, wD782, wD781, wC920, wC968, wC919, wC8C3, wC8C4, ...
Func_00D_5B4A:: ; heuristic: target of a pointer table; C0
    call Func_00D_615E
    ld a, [wD782]
    and a, a
    jr z, Jump_00D_5B7C
    farcall Func_002_7347
    ld a, [wC8C3]
    bit 7, a
    ret z
    xor a, a
    ld [wD7FA], a
    ld [wD782], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $01
    ld [wC968], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_5B7C::
    xor a, a
    ld [wC8C3], a
    ld [wC8C4], a
    farcall SetWD7F5ToWD789Cell4
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $C7
    ld h, a
    xor a, a
    ld [hl], a
    xor a, a
    call Func_00D_6120
    ld a, l
    ld [wD7F1], a
    ld a, h
    ld [wD7F2], a
    xor a, a
    ld [wD7F3], a
    farcall Func_015_683C
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5, wD7F6, wD781
; writes: wD781
; points at: wC130
Func_00D_5BBF:: ; heuristic: target of a pointer table; C0
    call Func_00D_5C47
    farcall SetWD7F5ToWD789Cell4
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld de, wC130
    call Func_000_2458
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC527, wD7F1, wD7F2
Func_00D_5BDF:: ; heuristic: target of a pointer table; C0
    farcall Func_004_4AA8
    ld a, $7F
    ld [wC527], a
    ld c, $0D
    ld hl, $01CC
    ld de, $0000
    xor a, a
    ld [wD7F1], a
    ld a, $14
    ld [wD7F2], a
    call Func_00D_4ED5
    db $CD, $3B

; no direct call (reached through a table, a jump or a vector)
; writes: wC920, wC919
Func_00D_5C00:: ; heuristic: target of a pointer table; C0
    ld d, [hl]
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wD7FA, wD780, wD781, wD782, wC920, wC919
Func_00D_5C17:: ; heuristic: target of a pointer table; C0
    call Func_00D_5C60
    cp a, $FF
    jr nz, Jump_00D_5C38
    xor a, a
    ld [wD7FA], a
    ld a, $03
    ld [wD780], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_5C38::
    ld a, $01
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; 2 call sites from 2 routines (e.g. Func_00D_5BBF, Func_00D_5B06)
; points at: wC3B0, wC3C4
Func_00D_5C47::
    ld a, $C3
    ld hl, wC3B0
    ld [hl+], a
    ld [hl], a
    ld hl, wC3C4
    ld [hl+], a
    ld [hl], a
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    ret

; 1 call site from 1 routine (e.g. Func_00D_5C17)
; points at: wC707
Func_00D_5C60::
    ld hl, wC707
    ld c, $00
    ld b, $00

Jump_00D_5C67::
    push hl
    ld a, [hl]
    cp a, $FE
    jr z, Jump_00D_5C83
    cp a, $FF
    jr z, Jump_00D_5C72
    inc b

Jump_00D_5C72::
    pop hl
    ld a, l
    add a, $04
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc c
    ld a, c
    cp a, $20
    jr c, Jump_00D_5C67
    xor a, a
    ret

Jump_00D_5C83::
    pop hl
    ld a, $FF
    ret

; 3 call sites from 3 routines (e.g. Func_00D_5800, Func_00D_6668, Func_01B_53CE)
; reads: wD7A9, wD7AF, wD7AB
; writes: wD7B0, wD7AF, wD7B1, wD7AB
Func_00D_5C87::
    ld a, [wD7A9]
    ld l, a
    ld h, $00
    ld a, $04
    call DivideHLByA
    push af
    and a, a
    jr z, Jump_00D_5C97
    inc l

Jump_00D_5C97::
    ld a, l
    ld [wD7B0], a
    ld a, [wD7AF]
    inc a
    cp a, l
    jr c, Jump_00D_5CD2
    pop af
    push af
    and a, a
    jr nz, Jump_00D_5CB7
    ld a, [wD7AF]
    inc a
    cp a, l
    jr z, Jump_00D_5CD2
    ld a, [wD7AF]
    dec a
    ld [wD7AF], a
    jr Jump_00D_5CD2

Jump_00D_5CB7::
    pop af
    dec a
    ld [wD7B1], a
    ld b, a
    ld a, [wD7AB]
    cp a, b
    jr c, Jump_00D_5CD8
    jr z, Jump_00D_5CD8
    push bc
    push hl
    call Func_00D_5CD9
    pop hl
    pop bc
    ld a, b
    ld [wD7AB], a
    jr Jump_00D_5CD8

Jump_00D_5CD2::
    pop af
    ld a, $03
    ld [wD7B1], a

Jump_00D_5CD8::
    ret

; 1 call site from 1 routine (e.g. Func_00D_5C87)
; reads: wD7F5, wD7AB
Func_00D_5CD9::
    ld b, $C3
    ld a, [wD7F5]
    and a, a
    jr z, Jump_00D_5CEF
    cp a, $01
    jr z, Jump_00D_5CEA
    ld hl, Data_00D_5D1E
    jr Jump_00D_5CF2

Jump_00D_5CEA::
    ld hl, Data_00D_5D16
    jr Jump_00D_5CF2

Jump_00D_5CEF::
    ld hl, Data_00D_5D0E

Jump_00D_5CF2::
    ld a, [wD7AB]
    sla a
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    push de
    call BGMapAddressAtScroll_Bank0D
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

Data_00D_5D0E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A6, $00, $C6, $00, $E6, $00, $06, $01

Data_00D_5D16:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A4, $00, $C4, $00, $E4, $00, $04, $01

Data_00D_5D1E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A2, $00, $C2, $00, $E2, $00, $02, $01

; 2 call sites from 2 routines (e.g. Func_00D_585C, Func_01B_53CE)
; reads: wD7F5, wD7AF, wD7B1, wD7A9, wD7B0
; points at: wD789, wC707
Func_00D_5D26::
    ld a, [wD7F5]
    and a, a
    jr nz, Jump_00D_5D31
    ld de, Data_00D_5DDD
    jr Jump_00D_5D34

Jump_00D_5D31::
    ld de, Data_00D_5DE5

Jump_00D_5D34::
    ld b, $04

Jump_00D_5D36::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, $C3
    ld [hl], a
    inc de
    dec b
    jr nz, Jump_00D_5D36
    ld hl, wD789
    ld a, [wD7AF]
    sla a
    sla a
    add_a_to_hl
    ld a, [hl]
    ld c, $00

Jump_00D_5D54::
    ld a, [wD7B1]
    cp a, $03
    jr c, Jump_00D_5D60
    ld a, [wD7A9]
    jr Jump_00D_5D6F

Jump_00D_5D60::
    ld a, [wD7B0]
    cp a, $01
    jr nz, Jump_00D_5D6C
    ld a, [wD7A9]
    jr Jump_00D_5D6F

Jump_00D_5D6C::
    ld a, [wD7A9]

Jump_00D_5D6F::
    ld b, a
    ld a, [wD7AF]
    sla a
    sla a
    add a, c
    cp a, b
    jp nc, Jump_00D_5DDC
    push hl
    push bc
    ld a, [hl]
    ld l, a
    ld h, $00
    sla l
    rl h
    sla l
    rl h
    ld de, wC707
    add hl, de
    ld e, l
    ld d, h
    ld a, [de]
    cp a, $FE
    jr z, Jump_00D_5DCC
    cp a, $FF
    jr z, Jump_00D_5DCC
    bit 6, a
    jr z, Jump_00D_5DA1
    ld b, $CA
    jr Jump_00D_5DA3

Jump_00D_5DA1::
    ld b, $C3

Jump_00D_5DA3::
    ld a, [wD7F5]
    and a, a
    jr nz, Jump_00D_5DAE
    ld de, Data_00D_5DDD
    jr Jump_00D_5DB8

Jump_00D_5DAE::
    ld de, Data_00D_5DE5
    ld a, b
    cp a, $C3
    jr z, Jump_00D_5DB8
    ld b, $70

Jump_00D_5DB8::
    ld a, c
    sla a
    add a, e
    ld e, a
    jr nc, Jump_00D_5DC0
    inc d

Jump_00D_5DC0::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei

Jump_00D_5DCC::
    pop bc
    pop hl
    inc hl
    inc c
    ld a, [wD7A9]
    cp a, c
    jr z, Jump_00D_5DDC
    ld a, c
    cp a, $04
    jp c, Jump_00D_5D54

Jump_00D_5DDC::
    ret

Data_00D_5DDD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $CD, $C3, $F5, $C3, $1D, $C4, $45, $C4

Data_00D_5DE5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C9, $C3, $F1, $C3, $19, $C4, $41, $C4

; 2 call sites from 2 routines (e.g. Func_00D_585C, Func_01B_53CE)
; reads: wD7AF, wD7B1, wD7A9, wDataBank, wD7B0
; writes: wDataBank, wC8DC
; points at: wD789, wC707, wC8CF
Func_00D_5DED::
    ld hl, wD789
    ld a, [wD7AF]
    sla a
    sla a
    add_a_to_hl
    ld c, $00

Jump_00D_5DFE::
    ld a, [wD7B1]
    cp a, $03
    jr c, Jump_00D_5E0A
    ld a, [wD7A9]
    jr Jump_00D_5E19

Jump_00D_5E0A::
    ld a, [wD7B0]
    cp a, $01
    jr nz, Jump_00D_5E16
    ld a, [wD7A9]
    jr Jump_00D_5E19

Jump_00D_5E16::
    ld a, [wD7A9]

Jump_00D_5E19::
    ld b, a
    ld a, [wD7AF]
    sla a
    sla a
    add a, c
    cp a, b
    jp nc, Jump_00D_5ED5
    push hl
    push bc
    ld a, [hl]
    sla a
    sla a
    ld de, wC707
    add a, e
    ld e, a
    jr nc, Jump_00D_5E35
    inc d

Jump_00D_5E35::
    ld a, [de]
    cp a, $FE
    jr nz, Jump_00D_5E60
    ld hl, wC8CF
    ld a, $16
    ld [hl+], a
    ld a, $24
    ld [hl+], a
    ld a, $2A
    ld [hl+], a
    ld a, $2C
    ld [hl+], a
    ld a, $26
    ld [hl+], a
    ld a, $90
    ld [hl+], a
    ld a, $14
    ld [hl+], a
    ld a, $28
    ld [hl+], a
    ld a, $3C
    ld [hl+], a
    ld a, $5B
    ld [hl+], a
    ld a, $F0
    ld [hl], a
    jr Jump_00D_5EC0

Jump_00D_5E60::
    inc de
    inc de
    inc de
    ld a, [de]
    bit 7, a
    jr z, Jump_00D_5EB2
    dec de
    dec de
    dec de
    ld a, [de]
    and a, $3F
    ld l, a
    ld h, $00
    push hl
    ld a, [wDataBank]
    push af
    ld a, $09
    ld [wDataBank], a
    ld hl, Data_009_4016
    ld a, $0C
    add_a_to_hl
    call ReadWordFromDataBank
    ld a, b
    ld e, a
    ld a, c
    ld b, a
    ld a, e
    ld c, a
    pop af
    pop hl
    push af
    sla l
    rl h
    add hl, bc
    call ReadWordFromDataBank
    ld a, b
    ld e, a
    ld a, c
    ld d, a
    pop af
    ld [wDataBank], a
    ld hl, wC8CF
    ld b, $09
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, $F0
    ld [wC8DC], a
    jr Jump_00D_5EC0

Jump_00D_5EB2::
    ld a, [hl]
    ld de, wC8CF
    call Func_000_2458
    ld a, $5B
    ld [de], a
    inc de
    ld a, $F0
    ld [de], a

Jump_00D_5EC0::
    pop bc
    push bc
    call Func_00D_5ED6
    pop bc
    pop hl
    inc hl
    inc c
    ld a, [wD7A9]
    cp a, c
    jr z, Jump_00D_5ED5
    ld a, c
    cp a, $04
    jp c, Jump_00D_5DFE

Jump_00D_5ED5::
    ret

; 2 call sites from 2 routines (e.g. Func_00D_5DED, Func_00D_6E0E)
; reads: wD784, wD785
; writes: wD784, wD785
; points at: wC8CF
Func_00D_5ED6::
    xor a, a
    ld [wD784], a
    ld [wD785], a
    ld hl, wC8CF

Jump_00D_5EE0::
    ld a, [wD784]
    push hl
    add_a_to_hl
    ld a, [hl]
    cp a, $F0
    jp z, Jump_00D_5F23
    cp a, $8D
    jr z, Jump_00D_5F01
    cp a, $8E
    jr z, Jump_00D_5F01
    push bc
    call Func_00D_5F2C
    call CopyFromBankWaitVRAM
    pop bc
    jr Jump_00D_5F12

Jump_00D_5F01::
    push af
    ld a, [wD785]
    dec a
    ld [wD785], a
    pop af
    push bc
    call Func_00D_5F2C
    call OrFromBankWaitVRAM
    pop bc

Jump_00D_5F12::
    pop hl
    ld a, [wD785]
    inc a
    ld [wD785], a
    ld a, [wD784]
    inc a
    ld [wD784], a
    jr Jump_00D_5EE0

Jump_00D_5F23::
    pop hl
    xor a, a
    ld [wD785], a
    ld [wD784], a
    ret

; 2 call sites from 1 routine (e.g. Func_00D_5ED6)
; reads: wD7F5, wD785
Func_00D_5F2C::
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
    ld hl, $4010
    add hl, de
    ld e, l
    ld d, h
    push de
    ld a, [wD7F5]
    and a, a
    jr z, Jump_00D_5F63
    cp a, $01
    jr z, Jump_00D_5F5E
    cp a, $02
    jr z, Jump_00D_5F59
    ld de, Data_00D_60A9
    jr Jump_00D_5F66

Jump_00D_5F59::
    ld de, Data_00D_6041
    jr Jump_00D_5F66

Jump_00D_5F5E::
    ld de, Data_00D_5FF1
    jr Jump_00D_5F66

Jump_00D_5F63::
    ld de, Data_00D_5F89

Jump_00D_5F66::
    ld a, c
    sla a
    add a, e
    ld e, a
    jr nc, Jump_00D_5F6E
    inc d

Jump_00D_5F6E::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, [wD785]
    sla a
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld h, d
    ld l, e
    pop de
    ld b, $1F
    ld c, $10
    ret

Data_00D_5F89:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $035F89, $68

Data_00D_5FF1:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $035FF1, $50

Data_00D_6041:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $036041, $68

Data_00D_60A9:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $AB, $60, $00, $96, $10, $96, $20, $96, $30, $96, $40, $96, $50, $96, $60, $96
    db $70, $96, $80, $96, $90, $96, $A0, $96, $B0, $96

; 2 call sites from 2 routines (e.g. Func_00D_574C, Func_01B_53CE)
; writes: wD7A9
; points at: wD789, wC707
Func_00D_60C3::
    ld hl, wD789
    ld b, $20

Jump_00D_60C8::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_00D_60C8
    xor a, a
    ld [wD7A9], a
    ld de, wC707
    ld hl, wD789
    ld b, $00
    ld c, $00

Jump_00D_60DB::
    ld a, [de]
    cp a, $FF
    jr z, Jump_00D_60E3
    inc c
    ld a, b
    ld [hl+], a

Jump_00D_60E3::
    ld a, $04
    add a, e
    ld e, a
    jr nc, Jump_00D_60EA
    inc d

Jump_00D_60EA::
    inc b
    ld a, b
    cp a, $20
    jr c, Jump_00D_60DB
    ld a, c
    ld [wD7A9], a
    ret

; 2 call sites from 1 routine (e.g. Func_00D_6120)
; reads: wD7AF, wD7AB
; points at: wD789, wC707
Func_00D_60F5:: ; heuristic: follows a terminator; C0
    ld hl, wD789
    ld a, [wD7AF]
    add a, a
    add a, a
    add_a_to_hl
    ld a, [wD7AB]
    add_a_to_hl
    ld a, [hl]
    ld hl, wC707
    add a, a
    add a, a
    add_a_to_hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    inc a
    ld c, $0A
    call Multiply8
    ret

; 3 call sites from 3 routines (e.g. Func_00D_5B4A, Func_00D_595C, Func_00D_5891)
; writes: wC8C0, wC8C1, wC8C2
; points at: wD7F1
Func_00D_6120:: ; heuristic: follows a terminator; C0
    and a, a
    jr nz, Jump_00D_6127
    call Func_00D_60F5
    ret

Jump_00D_6127::
    call Func_00D_60F5
    push de
    ld a, l
    ld [wC8C0], a
    ld a, h
    ld [wC8C1], a
    xor a, a
    ld [wC8C2], a
    call Number24ToPackedBCD
    farcall Func_015_6676
    pop de
    ld hl, wD7F1
    ld c, $07

Jump_00D_6146::
    ld a, [hl]
    cp a, $E3
    jr nz, Jump_00D_6154
    inc hl
    dec c
    jr nz, Jump_00D_6146
    xor a, a
    ld [de], a
    inc de
    jr Jump_00D_615A

Jump_00D_6154::
    ld a, [hl+]
    ld [de], a
    inc de
    dec c
    jr nz, Jump_00D_6154

Jump_00D_615A::
    ld a, $F0
    ld [de], a
    ret

; 5 call sites from 4 routines (e.g. Func_00D_5B4A, Func_00D_5B06, Func_00D_5A5C, Func_00D_5AB4)
; reads: wD781
; writes: rRAMG2, rRAMB
; points at: sBB0F
Func_00D_615E:: ; heuristic: follows a terminator; C0
    ld a, $0A
    ld [rRAMG2], a
    ld a, $01
    ld [rRAMB], a
    ld hl, sBB0F
    ld de, $022B
    add hl, de
    ld a, [hl]
    and a, a
    jr nz, Jump_00D_617B

Jump_00D_6173::
    xor a, a
    ld [rRAMB], a
    ld [rRAMG2], a
    ret

Jump_00D_617B::
    ld a, [wD781]
    cp a, $0B
    jr c, Jump_00D_6173
    farcall Func_015_6403
    ret

Data_00D_6189:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $CE, $CF, $DF, $B7, $B6, $C3, $C3, $C3
    db $C3, $B7, $B6, $C3, $76, $77, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B5

Data_00D_61A7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0361A7, $90

Data_00D_6237:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $036237, $5B

Data_00D_6292:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C3, $C3, $C3, $C3, $C3, $B7, $AB, $AC, $EE, $EF, $FC, $B7, $C3, $C3, $C3, $C3
    db $C3, $B7, $71, $72, $73, $74, $75, $B7, $B4, $B4, $B4, $B4, $B4, $B5

Data_00D_62B0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0362B0, $60

; 1 call site from 1 routine (e.g. Func_010_662F)
; reads: wD780
Func_00D_6310::
    ld a, [wD780]
    rst $00
    dw Jump_00D_643A
    dw Jump_00D_6384
    dw Jump_00D_6320
    dw Jump_00D_649C
    dw Jump_00D_656D
    dw Jump_00D_65D0

Jump_00D_6320::
    ld a, [wC839]
    and a, a
    jr nz, Jump_00D_6345
    ld a, [wC838]
    and a, a
    jr z, Jump_00D_6336
    cp a, $01
    jr z, Jump_00D_6336
    cp a, $02
    jr z, Jump_00D_6336
    jr Jump_00D_6345

Jump_00D_6336::
    ld a, $01
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_6345::
    ld a, [wC838]
    ld l, a
    ld a, [wC839]
    ld h, a
    call HLToDecimalDigits
    farcall Func_015_68DC
    ld hl, wC130
    ld de, wC8C0
    ld a, [de]
    cp a, $E3
    jr z, Jump_00D_6362
    ld [hl+], a

Jump_00D_6362::
    inc de
    ld a, [de]
    cp a, $E3
    jr z, Jump_00D_6369
    ld [hl+], a

Jump_00D_6369::
    inc de
    ld a, [de]
    ld [hl+], a
    ld a, $F0
    ld [hl], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    xor a, a
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_6384::
    call Func_00D_6DD0
    push af
    ld a, [wC838]
    ld l, a
    ld a, [wC839]
    ld h, a
    pop af
    cp a, $FF
    jr nz, Jump_00D_6397
    jr Jump_00D_63CB

Jump_00D_6397::
    push af
    add_a_to_hl
    ld a, h
    cp a, $03
    jr c, Jump_00D_63CF
    jr nz, Jump_00D_63A9
    ld a, l
    cp a, $E8
    jr c, Jump_00D_63CF

Jump_00D_63A9::
    ld a, l
    sub a, $E7
    ld l, a
    ld a, h
    sbc a, $03
    ld h, a
    pop af
    ld b, a
    ld a, l
    sub a, b
    ld b, a
    and a, a
    jr z, Jump_00D_63C1
    ld hl, wC61D
    ld c, $00
    call Func_00D_63F6

Jump_00D_63C1::
    ld a, $03
    ld [wC839], a
    ld a, $E7
    ld [wC838], a

Jump_00D_63CB::
    ld a, $01
    jr Jump_00D_63E2

Jump_00D_63CF::
    pop af
    ld b, a
    ld a, l
    ld [wC838], a
    ld a, h
    ld [wC839], a
    ld hl, wC61D
    ld c, $00
    call Func_00D_63F6
    xor a, a

Jump_00D_63E2::
    ld [wD7FA], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; 2 call sites from 1 routine (e.g. Func_00D_6310)
; points at: wC61D, wC61E
Func_00D_63F6::
    push hl
    push bc
    ld a, [hl]
    cp a, $2C
    jr nz, Jump_00D_640D
    xor a, a
    ld [hl], a
    pop bc
    pop hl
    push hl
    push bc
    dec b
    ld a, b
    and a, a
    jr nz, Jump_00D_640D
    pop hl
    pop bc
    jr Jump_00D_6416
    db $C9

Jump_00D_640D::
    pop bc
    pop hl
    inc hl
    inc c
    ld a, c
    cp a, $18
    jr c, Func_00D_63F6

Jump_00D_6416::
    ld hl, wC61D
    ld de, wC61E
    ld b, $17

Jump_00D_641E::
    ld a, [hl]
    and a, a
    jr z, Jump_00D_6428
    inc hl
    inc de
    dec b
    jr nz, Jump_00D_641E
    ret

Jump_00D_6428::
    ld a, [de]
    and a, a
    jr nz, Jump_00D_6431
    inc de
    dec b
    jr nz, Jump_00D_6428
    ret

Jump_00D_6431::
    ld a, [de]
    ld [hl+], a
    xor a, a
    ld [de], a
    inc de
    dec b
    jr nz, Jump_00D_641E
    ret

Jump_00D_643A::
    ld hl, wD780
    ld bc, $006F

Jump_00D_6440::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_00D_6440
    ld hl, wC364
    ld de, wBGMapShadow
    ld bc, $0104
    call Func_00D_4E7B
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_00D_6465
    ld hl, wD1CC
    ld de, wD000
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank0D

Jump_00D_6465::
    ld a, $07
    ld [wD7F0], a
    ld a, $70
    ldh [hFFBA], a
    xor a, a
    call Func_00D_6DD0
    cp a, $FF
    jr z, Jump_00D_6488
    xor a, a
    ld [wD7FA], a
    ld hl, wD780
    inc [hl]
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_6488::
    ld a, $01
    ld [wD7FA], a
    ld a, $02
    ld [wD780], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_649C::
    ld a, [wD781]
    rst $00
    dw Jump_00D_64A6
    dw Func_00D_6509
    dw Jump_00D_6541

Jump_00D_64A6::
    ld de, Data_01F_4170
    ld hl, vTiles1 + $2D0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4280
    ld hl, vTiles1 + $2E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4250
    ld hl, vTiles1 + $2F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4300
    ld hl, vTiles1 + $7C0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4A40
    ld hl, vTiles1 + $7D0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4180
    ld hl, vTiles2 + $760
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4330
    ld hl, vTiles2 + $770
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; 1 call site from 1 routine (e.g. Func_00D_6AA2)
; reads: wC838, wC839, wD781
; writes: wD781
; points at: wC36D, wC388, wC8C0
Func_00D_6509::
    ld de, Data_00D_6EB7
    ld hl, wC36D
    ld bc, $0B03
    call CopyRectTo20ByteRows_Bank0D
    ld a, [wC838]
    ld l, a
    ld a, [wC839]
    ld h, a
    call HLToDecimalDigits
    farcall Func_015_68DC
    ld hl, wC388
    ld de, wC8C0
    ld c, $00

Jump_00D_652E::
    ld a, [de]
    add a, $E0
    ld [hl+], a
    inc de
    inc c
    ld a, c
    cp a, $03
    jr c, Jump_00D_652E
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_00D_6541::
    ld de, Data_00D_6189
    ld hl, wC412
    ld bc, $0605
    call CopyRectTo20ByteRows_Bank0D
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    ld a, $6C
    call StoreWC60B
    xor a, a
    ld [wD7FA], a
    ld [wD781], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

Jump_00D_656D::
    farcall Func_01D_6540
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_00D_6581
    cp a, $FF
    jr z, Jump_00D_6590
    ret

Jump_00D_6581::
    ld a, $01
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_6590::
    ld a, [wD7FA]
    cp a, $01
    jr z, Jump_00D_6581
    ld c, $05
    ld hl, $027A
    ld de, $00AE
    xor a, a
    ld [wD7F1], a
    ld a, $06
    ld [wD7F2], a
    call Func_00D_4ED5
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    xor a, a
    ld [wD7FA], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    xor a, a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_65D0::
    ld a, [wD781]
    rst $00
    dw Jump_00D_65F2
    dw Jump_00D_6615
    dw Func_00D_6668
    dw Func_00D_66BB
    dw Func_00D_66CE
    dw Func_00D_66ED
    db $A3, $67
    dw Func_00D_67F7
    dw Func_00D_68FD
    dw Func_00D_6929
    dw Func_00D_69E8
    dw Func_00D_6A0B
    dw Func_00D_6A1F
    dw Func_00D_6AA2
    dw Func_00D_6AEC

Jump_00D_65F2::
    ld de, Data_00D_6ED8
    ld hl, wC3B7
    ld bc, $1109
    call CopyRectTo20ByteRows_Bank0D
    call Func_00D_6DF2
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_00D_6615::
    ld hl, vTiles1 + $240
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0901
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ld hl, vTiles1 + $500
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0F01
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ld hl, vTiles1 + $700
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0C01
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD7AF, wD7B0, wD7AB, wD781, wC837
; writes: wD7F5, wD781
; points at: wC3CC
Func_00D_6668:: ; heuristic: target of a pointer table; C0
    ld a, [wD7AF]
    and a, a
    jr nz, Jump_00D_6678
    ld de, Data_00D_6F71
    jr Jump_00D_6681

Jump_00D_6673::
    ld de, Data_00D_7043
    jr Jump_00D_6681

Jump_00D_6678::
    ld a, [wC837]
    and a, a
    jr nz, Jump_00D_6673
    ld de, Data_00D_6FDA

Jump_00D_6681::
    ld hl, wC3CC
    ld bc, $0F07
    call CopyRectTo20ByteRows_Bank0D
    ld a, $01
    ld [wD7F5], a
    call Func_00D_5C87
    ld a, [wD7B0]
    cp a, $02
    jr c, Jump_00D_669C
    call Func_00D_6E88

Jump_00D_669C::
    ld a, [wD7AB]
    ld b, $BB
    ld hl, Data_00D_7106
    call StoreBAtWordTableEntry_Bank0D
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD7F5, wD781
Func_00D_66BB:: ; heuristic: target of a pointer table; C0
    ld a, $01
    ld [wD7F5], a
    call Func_00D_6E0E
    call Func_00D_6D3E
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD7AB, wD781
; writes: wD781
Func_00D_66CE:: ; heuristic: target of a pointer table; C0
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    ld a, [wD7AB]
    ld b, $C3
    ld hl, Data_00D_7106
    call StoreBAtWordTableEntry_Bank0D
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5, wD7F6, wD781
; writes: wD7FA, wStringIndex, wStringCategory, wC52D, wC52E, wC52F, wC530, wD781, ...
; points at: wC130
Func_00D_66ED:: ; heuristic: target of a pointer table; C0
    ld b, $BB
    call Func_00D_6DA7
    farcall SetWD7F5ToWD789Cell4
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    cp a, $01
    jr c, Jump_00D_6707
    ld a, $01

Jump_00D_6707::
    ld [wD7FA], a
    cp a, $01
    jr z, Jump_00D_6744
    add a, $22
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    farcall ShowString_Bank0D
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_6744::
    ld a, [hl]
    add a, $28
    ld l, a
    ld h, $00
    sla l
    rl h
    push hl
    ld hl, Data_00D_4016
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    pop hl
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld hl, wC130
    ld c, $00

Jump_00D_6761::
    ld a, [de]
    cp a, $F0
    jr z, Jump_00D_676A
    ld [hl+], a
    inc de
    jr Jump_00D_6761

Jump_00D_676A::
    ld a, $F0
    ld [hl], a
    ld a, $23
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    farcall ShowString_Bank0D
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC563, wC52B, wD781
; writes: wD781, wC920, wC919, wD7BD
Func_00D_67A3:: ; heuristic: follows a terminator; C0
    ld b, $BB
    call Func_00D_6DA7
    ld a, [wC563]
    bit 6, a
    jr nz, Jump_00D_67E4
    bit 7, a
    jr nz, Jump_00D_67E8
    bit 4, a
    jr nz, Jump_00D_67EC
    bit 5, a
    jr nz, Jump_00D_67F0
    bit 1, a
    jr nz, Jump_00D_67CB
    bit 0, a
    jr nz, Jump_00D_67CB
    ld a, [wC52B]
    bit 0, a
    ret nz
    jr Jump_00D_67CE

Jump_00D_67CB::
    call ShowString_Bank0D

Jump_00D_67CE::
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ld b, $BB
    call Func_00D_6DA7
    ret

Jump_00D_67E4::
    ld a, $01
    jr Jump_00D_67F2

Jump_00D_67E8::
    ld a, $02
    jr Jump_00D_67F2

Jump_00D_67EC::
    ld a, $03
    jr Jump_00D_67F2

Jump_00D_67F0::
    ld a, $04

Jump_00D_67F2::
    ld [wD7BD], a
    jr Jump_00D_67CE

; no direct call (reached through a table, a jump or a vector)
; reads: wD7BD, wD7F9, wD781, wD7AB, wD7F5, wD7F6, wC8C1, wC8C2
; writes: wC563, wD7F9, wD7FA, wD781, wC52D, wC52E, wC52F, wC530, ...
; points at: wC130
Func_00D_67F7:: ; heuristic: target of a pointer table; C0
    ld a, [wD7BD]
    and a, a
    jr z, Jump_00D_6827
    cp a, $01
    jr z, Jump_00D_6822
    cp a, $02
    jr z, Jump_00D_681B
    cp a, $03
    jr z, Jump_00D_6814
    cp a, $04
    jr z, Jump_00D_680D

Jump_00D_680D::
    ld a, $20
    ld [wC563], a
    jr Jump_00D_6827

Jump_00D_6814::
    ld a, $10
    ld [wC563], a
    jr Jump_00D_6827

Jump_00D_681B::
    ld a, $80
    ld [wC563], a
    jr Jump_00D_6827

Jump_00D_6822::
    ld a, $40
    ld [wC563], a

Jump_00D_6827::
    ld a, $04
    ld [wD7F9], a
    farcall Func_01D_66B6
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_00D_684C
    cp a, $FC
    jr z, Jump_00D_684C
    cp a, $FD
    jr z, Jump_00D_6867
    cp a, $FE
    jr z, Jump_00D_6882
    cp a, $FF
    jr z, Jump_00D_6891
    ret

Jump_00D_684C::
    xor a, a
    ld [wD7BD], a
    ld a, [wD781]
    sub a, $06
    ld [wD781], a
    ld a, $01
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_6867::
    xor a, a
    ld [wD7BD], a
    ld a, [wD781]
    sub a, $02
    ld [wD781], a
    ld a, $01
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_6882::
    ld a, $02
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_6891::
    xor a, a
    ld [wD7FA], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld a, [wD7AB]
    ld b, $BC
    ld hl, Data_00D_7106
    call StoreBAtWordTableEntry_Bank0D
    farcall SetWD7F5ToWD789Cell4
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld de, Data_00D_710E
    add a, e
    ld e, a
    jr nc, Jump_00D_68BE
    inc d

Jump_00D_68BE::
    ld a, [de]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    farcall Func_015_68DC
    ld hl, wC130
    ld a, [wC8C1]
    cp a, $E3
    jr z, Jump_00D_68D6
    ld [hl+], a

Jump_00D_68D6::
    ld a, [wC8C2]
    ld [hl+], a
    ld a, $F0
    ld [hl], a
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD7FA, wD782, wD781
; points at: wC412
Func_00D_68FD:: ; heuristic: target of a pointer table; C0
    ld de, Data_00D_6189
    ld hl, wC412
    ld bc, $0605
    call CopyRectTo20ByteRows_Bank0D
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    ld a, $6C
    call StoreWC60B
    xor a, a
    ld [wD7FA], a
    ld [wD782], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD7F9, wD7FA, wD7F5, wD7F6, wC839, wC838, wD781
; writes: wD7FA, wD781, wC920, wC919, wD782
Func_00D_6929:: ; heuristic: target of a pointer table; C0
    farcall Func_01D_6540
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_00D_693D
    cp a, $FF
    jr z, Jump_00D_6956
    ret

Jump_00D_693D::
    call Func_00D_69B3
    ld a, $01
    ld [wD7FA], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_6956::
    ld a, [wD7FA]
    cp a, $01
    jr z, Jump_00D_693D
    farcall SetWD7F5ToWD789Cell4
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld de, Data_00D_710E
    add a, e
    ld e, a
    jr nc, Jump_00D_6974
    inc d

Jump_00D_6974::
    ld a, [de]
    ld b, a
    ld a, [wC839]
    and a, a
    jr nz, Jump_00D_6999
    ld a, [wC838]
    cp a, b
    jr nc, Jump_00D_6999
    ld a, $02
    ld [wD7FA], a
    ld a, [wD781]
    inc a
    inc a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_6999::
    xor a, a
    ld [wD7FA], a
    ld a, [wD781]
    add a, $03
    ld [wD781], a
    xor a, a
    ld [wD782], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; 2 call sites from 2 routines (e.g. Func_00D_6A0B, Func_00D_6929)
; reads: wD7AF, wC837
; points at: wC412
Func_00D_69B3::
    ld a, [wD7AF]
    and a, a
    jr nz, Jump_00D_69C3
    ld de, Data_00D_70AC
    jr Jump_00D_69CC

Jump_00D_69BE::
    ld de, Data_00D_70CA
    jr Jump_00D_69CC

Jump_00D_69C3::
    ld a, [wC837]
    and a, a
    jr nz, Jump_00D_69BE
    ld de, Data_00D_70E8

Jump_00D_69CC::
    ld hl, wC412
    ld bc, $0605
    call CopyRectTo20ByteRows_Bank0D
    call Func_00D_6D3E
    call Func_00D_6E88
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wD781, wC920, wC919
Func_00D_69E8:: ; heuristic: target of a pointer table; C0
    ld c, $04
    ld hl, Data_00D_7106
    call Func_00D_4F29
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    ld a, $05
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781, wC920, wC919
Func_00D_6A0B:: ; heuristic: target of a pointer table; C0
    call Func_00D_69B3
    ld a, [wD781]
    dec a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5, wD7F6, wD781
; writes: wD7FA, wD781, wC920, wC919
Func_00D_6A1F:: ; heuristic: target of a pointer table; C0
    farcall SetWD7F5ToWD789Cell4
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    and a, a
    jr z, Jump_00D_6A63
    call Func_00D_6CCC
    cp a, $FF
    jr nz, Jump_00D_6A4E
    ld a, $03
    ld [wD7FA], a
    ld a, [wD781]
    dec a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_6A4E::
    xor a, a
    ld [wD7FA], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_6A63::
    call Func_00D_6D09
    cp a, $FF
    jr nz, Jump_00D_6A4E
    ld a, $01
    ld [wD7FA], a
    ld a, [wD781]
    dec a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: hFFC6, wD781
; writes: wD7FA, wD781, wC920, wC919
Func_00D_6A80:: ; heuristic: follows a terminator; C0
    farcall Func_012_691F
    ldh a, [hFFC6]
    bit 7, a
    jr z, Jump_00D_6A4E
    ld a, $02
    ld [wD7FA], a
    ld a, [wD781]
    dec a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5, wD7F6, wC838, wC839
; writes: wC839, wC838, wD7FA, wC920, wC919
Func_00D_6AA2:: ; heuristic: target of a pointer table; C0
    farcall SetWD7F5ToWD789Cell4
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    push hl
    ld de, Data_00D_710E
    add a, e
    ld e, a
    jr nc, Jump_00D_6ABA
    inc d

Jump_00D_6ABA::
    ld a, [de]
    ld b, a
    ld a, [wC838]
    ld l, a
    ld a, [wC839]
    ld h, a
    ld a, l
    sub a, b
    ld l, a
    ld a, h
    sbc a, $00
    ld [wC839], a
    ld a, l
    ld [wC838], a
    call Func_00D_6509
    pop hl
    ld a, [hl]
    cp a, $01
    jr nc, Jump_00D_6ADD
    xor a, a
    jr Jump_00D_6ADF

Jump_00D_6ADD::
    ld a, $01

Jump_00D_6ADF::
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5, wD7F6, wD781
; writes: wD7FA, wD781, wC920, wC919
Func_00D_6AEC:: ; heuristic: target of a pointer table; C0
    farcall SetWD7F5ToWD789Cell4
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    push af
    and a, a
    jr z, Jump_00D_6B07
    call Func_00D_6CCC
    call Func_00D_6B55
    jr Jump_00D_6B15

Jump_00D_6B07::
    call Func_00D_6D09
    ld a, $1E
    ld [hl], a
    jr Jump_00D_6B15
    db $21, $9A, $68, $06, $12, $D7

Jump_00D_6B15::
    pop af
    and a, a
    jr z, Jump_00D_6B3A
    call Func_00D_6CCC
    cp a, $FF
    jr nz, Jump_00D_6B24
    ld a, $03
    jr Jump_00D_6B25

Jump_00D_6B24::
    xor a, a

Jump_00D_6B25::
    ld [wD7FA], a
    ld a, [wD781]
    sub a, $03
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_6B3A::
    call Func_00D_6D09
    cp a, $FF
    jr nz, Jump_00D_6B24
    ld a, $01
    jr Jump_00D_6B25

; no direct call (reached through a table, a jump or a vector)
; reads: hFFC6, wD781
; writes: wD7FA, wD781, wC920, wC919
Func_00D_6B45:: ; heuristic: follows a terminator; C0
    farcall Func_012_691F
    ldh a, [hFFC6]
    bit 7, a
    jr z, Jump_00D_6B24
    ld a, $02
    jr Jump_00D_6B25

; 1 call site from 1 routine (e.g. Func_00D_6AEC)
; reads: wD7F5, wD7F6, wCFEC, wCFED, wD008, wCADE, wD010, wD011, ...
; writes: wCFE6, wCFE7, wD006, wD007, wCADB, wCADC, rRAMG2, rRAMB
; points at: wC986, wC60C, wD01A
Func_00D_6B55::
    push hl
    ld hl, wC986
    ld b, $A5

Jump_00D_6B5B::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_00D_6B5B
    pop hl
    push hl
    farcall SetWD7F5ToWD789Cell4
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld hl, $0179
    add_a_to_hl
    ld a, l
    ld [wCFE6], a
    ld a, h
    ld [wCFE7], a
    farcall Func_034_4001
    ld a, [wCFEC]
    ld [wD006], a
    ld a, [wCFED]
    ld [wD007], a
    farcall Func_035_4001
    farcall Func_016_5AAF
    ld hl, wC986
    ld a, $01
    ld [hl+], a
    call Func_00D_6CBA
    ld a, [wCFEC]
    ld [hl+], a
    ld [wCADB], a
    ld a, [wCFED]
    ld [hl+], a
    ld [wCADC], a
    ld a, [wD008]
    ld [hl+], a
    push hl
    farcall Func_00E_61C1
    pop hl
    ld a, [wCADE]
    ld [hl+], a
    ld de, wC60C
    ld c, $00

Jump_00D_6BCB::
    ld a, [de]
    cp a, $F0
    jr z, Jump_00D_6BDA
    ld [hl+], a
    inc c
    inc de
    ld a, c
    cp a, $0A
    jr c, Jump_00D_6BCB
    jr Jump_00D_6BED

Jump_00D_6BDA::
    ld a, $F0
    ld [hl+], a
    inc c
    ld a, c
    cp a, $0A
    jr z, Jump_00D_6BED
    ld a, $0A
    sub a, c
    ld b, a

Jump_00D_6BE7::
    ld a, $F0
    ld [hl+], a
    dec b
    jr nz, Jump_00D_6BE7

Jump_00D_6BED::
    xor a, a
    ld [hl+], a
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    call Func_00D_6CBE
    xor a, a
    ld [hl+], a
    call Func_00D_6CBE
    xor a, a
    ld [hl+], a
    ld b, $08

Jump_00D_6C01::
    ld a, $FF
    ld [hl+], a
    dec b
    jr nz, Jump_00D_6C01
    push hl
    ld b, $19

Jump_00D_6C0A::
    ld a, $FF
    ld [hl+], a
    dec b
    jr nz, Jump_00D_6C0A
    pop hl
    ld a, [wD010]
    ld [hl+], a
    ld a, [wD011]
    ld [hl+], a
    ld a, [wD012]
    ld [hl+], a
    ld a, $16
    add_a_to_hl
    xor a, a
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, [wD00E]
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld a, [wCFF6]
    ld [hl+], a
    ld a, [wCFF7]
    ld [hl+], a
    ld a, [wCFF6]
    ld [hl+], a
    ld a, [wCFF7]
    ld [hl+], a
    ld a, [wCFF8]
    ld [hl+], a
    ld a, [wCFF9]
    ld [hl+], a
    ld a, [wCFF8]
    ld [hl+], a
    ld a, [wCFF9]
    ld [hl+], a
    ld a, [wCFFA]
    ld [hl+], a
    ld a, [wCFFB]
    ld [hl+], a
    ld a, [wCFFC]
    ld [hl+], a
    ld a, [wCFFD]
    ld [hl+], a
    ld a, [wCFFE]
    ld [hl+], a
    ld a, [wCFFF]
    ld [hl+], a
    ld a, [wD000]
    ld [hl+], a
    ld a, [wD001]
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, [wD002]
    ld [hl+], a
    ld a, [wD003]
    ld [hl+], a
    ld a, [wD005]
    ld [hl+], a
    ld a, [wD004]
    ld [hl+], a
    ld de, wD01A
    ld b, $1B

Jump_00D_6C8E::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_00D_6C8E
    call Func_00D_6CBE
    xor a, a
    ld [hl+], a
    call Func_00D_6CBE
    xor a, a
    ld [hl+], a
    xor a, a
    ld [hl+], a
    pop hl
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld de, wC986
    ld b, $A5

Jump_00D_6CAF::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_00D_6CAF
    xor a, a
    ld [rRAMG2], a
    ret

; 1 call site from 1 routine (e.g. Func_00D_6B55)
Func_00D_6CBA::
    ld b, $0A
    jr Jump_00D_6CC5

; 4 call sites from 1 routine (e.g. Func_00D_6B55)
Func_00D_6CBE::
    ld a, $98
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld b, $07

Jump_00D_6CC5::
    ld a, $F0
    ld [hl+], a
    dec b
    jr nz, Jump_00D_6CC5
    ret

; 3 call sites from 2 routines (e.g. Func_00D_6AEC, Func_00D_6A1F)
; reads: wC7C7
; writes: rRAMG2, rRAMB
; points at: sA000
Func_00D_6CCC::
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld hl, sA000
    ld c, $00
    ld a, [wC7C7]
    ld de, Data_00D_6D06
    add a, e
    ld e, a
    jr nc, Jump_00D_6CE5
    inc d

Jump_00D_6CE5::
    ld a, [de]
    ld b, a

Jump_00D_6CE7::
    push hl
    ld a, [hl]
    and a, a
    jr z, Jump_00D_6D00
    cp a, $FF
    jr z, Jump_00D_6D00
    pop hl
    ld a, $A5
    add_a_to_hl
    inc c
    ld a, c
    cp a, b
    jr c, Jump_00D_6CE7
    ld a, $FF
    ret

Jump_00D_6D00::
    pop hl
    xor a, a
    ld [rRAMG2], a
    ret

Data_00D_6D06:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0A, $14, $1E

; 3 call sites from 2 routines (e.g. Func_00D_6AEC, Func_00D_6A1F)
; points at: wC61D
Func_00D_6D09::
    ld hl, wC61D
    ld c, $00

Jump_00D_6D0E::
    ld a, [hl]
    and a, a
    jr z, Jump_00D_6D20
    cp a, $FF
    jr z, Jump_00D_6D20
    inc hl
    inc c
    ld a, c
    cp a, $18
    jr c, Jump_00D_6D0E
    ld a, $FF
    ret

Jump_00D_6D20::
    xor a, a
    ret

; no direct call (reached through a table, a jump or a vector)
; points at: wC707
Func_00D_6D22:: ; heuristic: follows a terminator; C0
    ld hl, wC707
    ld c, $00

Jump_00D_6D27::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_00D_6D3C
    ld a, $04
    add_a_to_hl
    inc c
    ld a, c
    cp a, $0C
    jr c, Jump_00D_6D27
    ld a, $FF
    ret

Jump_00D_6D3C::
    xor a, a
    ret

; 2 call sites from 2 routines (e.g. Func_00D_69B3, Func_00D_66BB)
; reads: wD7AF, wC837, wC8C1, wC8C2
Func_00D_6D3E::
    ld a, [wD7AF]
    add a, a
    add a, a
    ld de, Data_00D_710E
    add a, e
    ld e, a
    jr nc, Jump_00D_6D4B
    inc d

Jump_00D_6D4B::
    ld a, [wD7AF]
    and a, a
    jr z, Jump_00D_6D60
    ld a, [wC837]
    and a, a
    jr nz, Jump_00D_6D64
    ld a, [wD7AF]
    ld b, a
    ld a, $03
    sub a, b
    jr Jump_00D_6D66

Jump_00D_6D60::
    ld a, $04
    jr Jump_00D_6D66

Jump_00D_6D64::
    ld a, $03

Jump_00D_6D66::
    ld b, a
    ld c, $00

Jump_00D_6D69::
    push de
    push bc
    ld a, [de]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    farcall Func_015_68DC
    ld de, Data_00D_6D9F
    pop bc
    push bc
    ld a, c
    sla a
    add a, e
    ld e, a
    jr nc, Jump_00D_6D85
    inc d

Jump_00D_6D85::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, [wC8C1]
    add a, $E0
    ld [hl+], a
    ld a, [wC8C2]
    add a, $E0
    ld [hl], a
    pop bc
    pop de
    inc de
    inc c
    ld a, c
    cp a, b
    jr c, Jump_00D_6D69
    ret

Data_00D_6D9F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $D7, $C3, $FF, $C3, $27, $C4, $4F, $C4

; 3 call sites from 2 routines (e.g. Func_00D_66ED, Func_00D_67A3)
; reads: wD7AB
Func_00D_6DA7::
    push bc
    ld a, [wD7AB]
    sla a
    ld hl, Data_00D_6DC8
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    push de
    call BGMapAddressAtScroll_Bank0D
    pop de
    add hl, de
    pop bc
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

Data_00D_6DC8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A4, $00, $E4, $00, $24, $01, $64, $01

; 2 call sites from 2 routines (e.g. Func_00D_6310, Func_00D_63F6)
; points at: wC61D
Func_00D_6DD0::
    ld hl, wC61D
    ld c, $00
    ld b, $00

Jump_00D_6DD7::
    push hl
    push bc
    ld a, [hl]
    cp a, $2C
    jr nz, Jump_00D_6DE1
    pop bc
    inc b
    push bc

Jump_00D_6DE1::
    pop bc
    pop hl
    inc hl
    inc c
    ld a, c
    cp a, $18
    jr c, Jump_00D_6DD7
    ld a, b
    and a, a
    jr z, Jump_00D_6DEF
    ret

Jump_00D_6DEF::
    ld a, $FF
    ret

; 1 call site from 1 routine (e.g. Func_00D_6509)
; reads: wC837
; writes: wD7A9
; points at: wD789
Func_00D_6DF2::
    ld a, [wC837]
    and a, a
    jr nz, Jump_00D_6DFC
    ld b, $06
    jr Jump_00D_6DFE

Jump_00D_6DFC::
    ld b, $07

Jump_00D_6DFE::
    ld hl, wD789
    ld c, $00

Jump_00D_6E03::
    ld a, c
    ld [hl+], a
    inc c
    ld a, c
    cp a, b
    jr c, Jump_00D_6E03
    ld [wD7A9], a
    ret

; 1 call site from 1 routine (e.g. Func_00D_66BB)
; reads: wD7AF, wD7B1, wD7A9, wD7B0
; points at: wD789, wC8CF
Func_00D_6E0E::
    ld hl, wD789
    ld a, [wD7AF]
    sla a
    sla a
    add_a_to_hl
    ld c, $00

Jump_00D_6E1F::
    ld a, [wD7B1]
    cp a, $03
    jr c, Jump_00D_6E2B
    ld a, [wD7A9]
    jr Jump_00D_6E3A

Jump_00D_6E2B::
    ld a, [wD7B0]
    cp a, $01
    jr nz, Jump_00D_6E37
    ld a, [wD7A9]
    jr Jump_00D_6E3A

Jump_00D_6E37::
    ld a, [wD7A9]

Jump_00D_6E3A::
    ld b, a
    ld a, [wD7AF]
    sla a
    sla a
    add a, c
    cp a, b
    jp nc, Jump_00D_6E87
    push hl
    push bc
    ld a, [hl]
    add a, $28
    ld l, a
    ld h, $00
    sla l
    rl h
    push hl
    ld hl, Data_00D_4016
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    pop hl
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld hl, wC8CF
    ld c, $00

Jump_00D_6E66::
    ld a, [de]
    cp a, $F0
    jr z, Jump_00D_6E6F
    ld [hl+], a
    inc de
    jr Jump_00D_6E66

Jump_00D_6E6F::
    ld a, $F0
    ld [hl], a
    pop bc
    push bc
    call Func_00D_5ED6
    pop bc
    pop hl
    inc hl
    inc c
    ld a, [wD7A9]
    cp a, c
    jr z, Jump_00D_6E87
    ld a, c
    cp a, $04
    jp c, Jump_00D_6E1F

Jump_00D_6E87::
    ret

; 2 call sites from 2 routines (e.g. Func_00D_69B3, Func_00D_6668)
; writes: wD7F1, wD7F2
; points at: wC462, wC463
Func_00D_6E88::
    ld de, $018E
    call Func_00D_4EA4
    ld hl, wC462
    call StoreC5BEC6AtHLStride2_Bank0D
    ld de, $018F
    ld a, d
    ld [wD7F1], a
    ld a, e
    ld [wD7F2], a
    farcall Func_01E_7564
    ld hl, wC463
    ld a, h
    ld [wD7F1], a
    ld a, l
    ld [wD7F2], a
    farcall Func_01E_759A
    ret

Data_00D_6EB7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $AD, $CF, $AE, $AF
    db $FC, $FD, $C3, $C3, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4
    db $B5

Data_00D_6ED8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $036ED8, $99

Data_00D_6F71:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C3, $A4, $A5, $A6, $A7, $A8, $A9, $AA, $AB, $AC, $FD
    ds $14, $C3
    db $D0, $D1, $D2, $D3, $D4, $D5, $D6, $D7, $D8, $FD
    ds $14, $C3
    db $F0, $F1, $F2, $F3, $F4, $F5, $F6, $F7, $F8, $FD
    ds $14, $C3
    db $D9, $DA, $DB, $DC, $DD, $DE, $F9, $FA, $FB, $FD, $C3, $C3, $C3, $C3

Data_00D_6FDA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C3, $A4, $A5, $A6, $A7, $A8, $A9, $AA, $AB, $AC, $FD
    ds $14, $C3
    db $D0, $D1, $D2, $D3, $D4, $D5, $D6, $D7, $D8, $FD
    ds $14, $C3
    db $F0, $F1, $F2, $F3, $F4, $F5, $F6, $F7, $F8
    ds $15, $C3
    db $D9, $DA, $DB, $DC, $DD, $DE, $F9, $FA, $FB, $C3, $C3, $C3, $C3, $C3

Data_00D_7043:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C3, $A4, $A5, $A6, $A7, $A8, $A9, $AA, $AB, $AC, $FD
    ds $14, $C3
    db $D0, $D1, $D2, $D3, $D4, $D5, $D6, $D7, $D8, $FD
    ds $14, $C3
    db $F0, $F1, $F2, $F3, $F4, $F5, $F6, $F7, $F8, $FD
    ds $14, $C3
    db $D9, $DA, $DB, $DC, $DD, $DE, $F9, $FA, $FB, $C3, $C3, $C3, $C3, $C3

Data_00D_70AC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C3, $C3, $C3, $C3, $C3, $B7, $FD, $C3, $C3, $C3, $C3, $B7, $C3, $C3, $C3, $C3
    db $C3, $B7, $FD, $C3, $C3, $C3, $C3, $B7, $B4, $B4, $B4, $B4, $B4, $B5

Data_00D_70CA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C3, $C3, $C3, $C3, $C3, $B7, $FD, $C3, $C3, $C3, $C3, $B7, $C3, $C3, $C3, $C3
    db $C3, $B7, $C3, $C3, $C3, $C3, $C3, $B7, $B4, $B4, $B4, $B4, $B4, $B5

Data_00D_70E8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C3, $C3, $C3, $C3, $C3, $B7, $C3, $C3, $C3, $C3, $C3, $B7, $C3, $C3, $C3, $C3
    db $C3, $B7, $C3, $C3, $C3, $C3, $C3, $B7, $B4, $B4, $B4, $B4, $B4, $B5

Data_00D_7106:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $CC, $C3, $F4, $C3, $1C, $C4, $44, $C4

Data_00D_710E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $03, $03, $04, $04, $05, $05, $0A

; 1 call site from 1 routine (e.g. Func_010_663D)
Func_00D_7115::
    farcall Func_01E_4001
    ret

; 1 call site from 1 routine (e.g. Func_010_6636)
; reads: wD780
Func_00D_711C::
    ld a, [wD780]
    rst $00
    dw Jump_00D_7144
    dw Jump_00D_7158
    dw Jump_00D_7158
    dw Jump_00D_7158
    dw Jump_00D_7159
    dw Jump_00D_7158
    dw Jump_00D_7158
    dw Jump_00D_7158
    dw Jump_00D_7158
    dw Jump_00D_7158
    dw Jump_00D_7158
    dw Jump_00D_7158
    dw Jump_00D_755C
    dw Jump_00D_7158
    dw Jump_00D_7158
    dw Jump_00D_7158
    dw Jump_00D_7158
    dw Jump_00D_7578

Jump_00D_7144::
    farcall Func_01E_4069
    ld a, $08
    ld [wD7F0], a
    ld a, [wD780]
    add a, $03
    ld [wD780], a
    ret

Jump_00D_7158::
    ret

Jump_00D_7159::
    ld a, [wD781]
    rst $00
    dw Func_00D_7195
    dw Func_00D_7195
    dw Func_00D_7195
    dw Func_00D_7195
    dw Func_00D_71BD
    dw Func_00D_7195
    dw Func_00D_7195
    dw Func_00D_7195
    dw Func_00D_7195
    dw Func_00D_71FF
    dw Func_00D_7195
    dw Func_00D_7195
    dw Func_00D_719C
    dw Func_00D_7195
    dw Func_00D_7195
    dw Func_00D_720E
    dw Func_00D_7195
    dw Func_00D_722A
    dw Func_00D_72D0
    dw Func_00D_72F4
    dw Func_00D_7329
    dw Func_00D_7352
    dw Func_00D_73AF
    dw Func_00D_73F1
    dw Func_00D_74AD
    dw Func_00D_74BB
    dw Func_00D_74F1
    dw Func_00D_74FC

; no direct call (reached through a table, a jump or a vector)
Func_00D_7195:: ; heuristic: target of a pointer table; C0
    farcall Func_015_40FA
    ret

; no direct call (reached through a table, a jump or a vector)
Func_00D_719C:: ; heuristic: target of a pointer table; C0
    farcall Func_015_40FA
    ld de, Data_01F_4510
    ld hl, vTiles1 + $6E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4450
    ld hl, vTiles1 + $6F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5, wD7F6, wD781
; writes: wD7F1, wD7F2, wD7F3, wD781
; points at: wC36C, wC386
Func_00D_71BD:: ; heuristic: target of a pointer table; C0
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld b, a
    push af
    ld a, $C7
    ld [wD7F1], a
    call Func_00D_7812
    ld de, Data_00D_785E
    ld hl, wC36C
    ld bc, $0C05
    call CopyRectTo20ByteRows_Bank0D
    pop af
    ld [wD7F1], a
    ld hl, wC386
    ld a, l
    ld [wD7F2], a
    ld a, h
    ld [wD7F3], a
    farcall Func_015_688D
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wD7FA, wC920, wC919
Func_00D_71FF:: ; heuristic: target of a pointer table; C0
    ld a, $01
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_00D_72D0)
; reads: wD781
; writes: wD7F1, wD7F2, wD781
Func_00D_720E:: ; heuristic: target of a pointer table; C0
    ld c, $05
    ld hl, $0278
    ld de, $00AC
    xor a, a
    ld [wD7F1], a
    ld a, $08
    ld [wD7F2], a
    call Func_00D_4ED5
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5, wD7F6, hFFC6, wD781, wC6FD, wC6FE, wD7AB, wD7AF
; writes: rRAMG2, rRAMB, wD7FA, wD781, wC920, wC919, wD7B4, wD7B5, ...
Func_00D_722A:: ; heuristic: target of a pointer table; C0
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    push hl
    ld a, [hl]
    ld c, $56
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    cp a, $0A
    jr nc, Jump_00D_726A
    pop hl
    ld a, $02
    ld [wD7FA], a
    xor a, a
    ld [rRAMG2], a
    ld a, [wD781]
    dec a
    dec a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_726A::
    pop hl
    ld a, [wC6FD]
    cp a, $02
    jr nc, Jump_00D_7295
    ld a, [hl]
    ld b, a
    ld a, [wC6FE]
    cp a, b
    jr nz, Jump_00D_7295
    ld a, $01
    ld [wD7FA], a
    xor a, a
    ld [rRAMG2], a
    ld a, [wD781]
    dec a
    dec a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_7295::
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld [wD7B4], a
    ld a, [wD7AB]
    ld [wD7B5], a
    ld a, [wD7AF]
    ld [wD7B6], a
    xor a, a
    ld [rRAMG2], a
    xor a, a
    ld [wD7FA], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wD782], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD782
; writes: wD782
Func_00D_72D0:: ; heuristic: target of a pointer table; C0
    ld a, [wD782]
    and a, a
    jr nz, Jump_00D_72E0
    call Func_00D_7839
    farcall Func_015_6EA5
    ret

Jump_00D_72E0::
    xor a, a
    ld [wD782], a
    call Func_00D_720E
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD7FB, wD781
; writes: wD781
; points at: wCA2B, wC994, wCA39
Func_00D_72F4:: ; heuristic: target of a pointer table; C0
    call Func_00D_7839
    ld a, [wD7FB]
    sla a
    ld de, Data_00D_78D6
    add a, e

; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
; points at: wCA2B, wC994, wCA39
Func_00D_7300:: ; heuristic: target of a pointer table; C0
    ld e, a

; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
; points at: wCA2B, wC994, wCA39
Func_00D_7301:: ; heuristic: target of a pointer table; C0
    jr nc, Jump_00D_7304
    inc d

Jump_00D_7304::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld de, wCA2B
    ld b, $A5

Jump_00D_730E::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_00D_730E
    ld hl, wC994
    ld a, [hl]
    and a, $01
    inc a
    and a, $01
    ld hl, wCA39
    ld [hl], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5, wD781
; writes: wD7F1, wD781, wC920, wC919, wD782
Func_00D_7329:: ; heuristic: target of a pointer table; C0
    ld a, $01
    ld [wD7F1], a
    farcall Func_00E_5688
    ld a, [wD7F5]
    cp a, $FF
    ret nz
    ld a, [wD781]
    inc a
    ld [wD781], a
    call Func_00D_76D0
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    xor a, a
    ld [wD782], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD7FA, wD781
; points at: wC412
Func_00D_7352:: ; heuristic: target of a pointer table; C0
    ld a, $6C
    call StoreWC60B
    ld de, Data_01F_4230
    ld hl, vTiles2 + $700
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4290
    ld hl, vTiles2 + $710
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4370
    ld hl, vTiles2 + $720
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4180
    ld hl, vTiles2 + $760
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    xor a, a
    ld [wD7FA], a
    ld de, Data_00D_78B8
    ld hl, wC412
    ld bc, $0605
    call CopyRectTo20ByteRows_Bank0D
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD7F9, wD7FA, wD781
; writes: wD781, wD782, wD7FA, wC920, wC919
Func_00D_73AF:: ; heuristic: target of a pointer table; C0
    farcall Func_01D_6540
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_00D_73C3
    cp a, $FF
    jr z, Jump_00D_73D2
    ret

Jump_00D_73C3::
    ld a, $01
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_73D2::
    ld a, [wD7FA]
    cp a, $01
    jr z, Jump_00D_73C3
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wD782], a
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD782, wD781, wD7B4, wD7F6, wD7F7, wD7FB
; writes: wD7FA, wD782, wD781, wC920, wC919, wD7F1, wD7F2, rRAMG2, ...
; points at: wCAD0, wCADB, wC7FC, wD7E0
Func_00D_73F1:: ; heuristic: target of a pointer table; C0
    ld a, [wD782]
    and a, a
    jr z, Jump_00D_740F
    xor a, a
    ld [wD7FA], a
    ld [wD782], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_740F::
    ld a, [wD7B4]
    ld [wD7F1], a
    xor a, a
    ld [wD7F2], a
    farcall Func_014_7E96
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [wD7F6]
    ld l, a
    ld a, [wD7F7]
    ld h, a
    ld de, wCAD0
    ld b, $A5

Jump_00D_7435::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_00D_7435
    xor a, a
    ld [rRAMG2], a
    xor a, a
    ld [wC8C3], a
    ld [wC8C4], a
    farcall Func_004_4AA8
    ld a, $7F
    ld [wC527], a
    ld hl, wCADB
    ld a, [hl+]
    ld [wD7F1], a
    ld a, [hl]
    ld [wD7F2], a
    ld de, wC7FC
    ld a, e
    ld [wD7F3], a
    ld a, d
    ld [wD7F4], a
    farcall Func_015_68F3
    ld hl, wD7E0
    ld b, $07

Jump_00D_7472::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_00D_7472
    ld a, [wD7FB]
    sla a
    ld hl, Data_00D_7499
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    call SetFlagBit
    farcall Func_015_6E64
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Data_00D_7499:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0E, $01, $18, $01, $1A, $01, $25, $01, $29, $01, $32, $00, $33, $00, $34, $00
    db $35, $00, $36, $00

; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
Func_00D_74AD:: ; heuristic: target of a pointer table; C0
    farcall Func_00C_6FCB
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC919, wC91A, wC91B, wD781
; writes: wC91C, wC91D, wC91E, wC917, wC916, wD7FD, hFFB9, wD781
Func_00D_74BB:: ; heuristic: target of a pointer table; C0
    ld a, [wC919]
    ld [wC91C], a
    ld a, [wC91A]
    ld [wC91D], a
    ld a, [wC91B]
    ld [wC91E], a
    xor a, a
    ld [wC917], a
    ld a, $20
    ld [wC916], a
    farcall Func_013_405C
    xor a, a
    ld [wD7FD], a
    xor a, a
    ldh [hFFB9], a
    farcall Func_004_449F
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
Func_00D_74F1:: ; heuristic: target of a pointer table; C0
    call Func_00D_77C2
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: hFFBA, wC920, wC919
; points at: wC364, wBGMapShadow, wC300, wC29C, wD1CC, wD000, wD168, wD104
Func_00D_74FC:: ; heuristic: target of a pointer table; C0
    ld hl, wC364
    ld de, wBGMapShadow
    ld bc, $0104
    call Func_00D_4E7B
    ld hl, wC300
    ld de, wC29C
    ld bc, $0064
    call Func_00D_4E7B
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_00D_7532
    ld hl, wD1CC
    ld de, wD000
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank0D
    ld hl, wD168
    ld de, wD104
    ld bc, $0064
    call CopyLow3BitsToWRAMBank2_Bank0D

Jump_00D_7532::
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    call BGMapAddressAtScroll_Bank0D
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call Func_00D_4E05
    ld a, $70
    ldh [hFFBA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_755C::
    farcall Func_01E_4069
    ld a, [wD781]
    cp a, $0A
    ret nz
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, [wD780]
    add a, $05
    ld [wD780], a
    ret

Jump_00D_7578::
    ld a, [wD781]
    rst $00
    dw Func_00D_7597
    dw Func_00D_7637
    dw Func_00D_7590
    dw Func_00D_7590
    dw Func_00D_7590
    dw Func_00D_71BD
    db $62, $76, $AF, $76, $90, $75, $90, $75

; no direct call (reached through a table, a jump or a vector)
Func_00D_7590:: ; heuristic: target of a pointer table; C0
    farcall Func_015_40FA
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD7FB, wD781
; writes: wC526, wD781
; points at: wC49F
Func_00D_7597:: ; heuristic: target of a pointer table; C0
    ld a, [wD7FB]
    ld b, a
    sla a
    add a, b
    push af
    ld hl, Data_00D_75D7
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl]
    ld b, a
    ld hl, vTiles2
    call DecompressToVRAM
    pop af
    ld hl, Data_00D_7607
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl]
    ld b, a
    ld hl, wC49F
    ld c, $40
    call CopyFromBankWaitVRAM
    ld a, $7F
    ld [wC526], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Data_00D_75D7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $82, $6B, $48, $A9, $49, $48, $82, $6B, $48, $A9, $49, $48, $82, $6B, $48, $A9
    db $49, $48, $A9, $49, $48, $A9, $49, $48, $82, $6B, $48, $82, $6B, $48, $82, $6B
    db $48, $82, $6B, $48, $82, $6B, $48, $82, $6B, $48, $82, $6B, $48, $82, $6B, $48

Data_00D_7607:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $34, $6F, $48, $87, $4C, $48, $34, $6F, $48, $87, $4C, $48, $34, $6F, $48, $87
    db $4C, $48, $87, $4C, $48, $87, $4C, $48, $34, $6F, $48, $34, $6F, $48, $34, $6F
    db $48, $34, $6F, $48, $34, $6F, $48, $34, $6F, $48, $34, $6F, $48, $34, $6F, $48

; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
Func_00D_7637:: ; heuristic: target of a pointer table; C0
    ld hl, Data_00D_789A
    ld de, Data_00D_78AA
    call Func_00D_4F3D
    ld de, Data_01F_4510
    ld hl, vTiles1 + $6E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4450
    ld hl, vTiles1 + $6F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret
    INCBIN "dwm2-cobi-us.gbc", $037662, $6E

; 1 call site from 1 routine (e.g. Func_00D_7329)
; reads: wD7F6, wD7F7, wD7F5, wCB3D
; writes: wD7F1, wD006, wD7F2, wD007, wD7F3, wD7F4, wD7FA
; points at: wC7FC, wC8CF, wC130, wC8C0
Func_00D_76D0::
    ld a, [wD7F6]
    ld [wD7F1], a
    ld [wD006], a
    ld a, [wD7F7]
    ld [wD7F2], a
    ld [wD007], a
    ld de, $75C5
    ld a, e
    ld [wD7F3], a
    ld a, d
    ld [wD7F4], a
    farcall Func_015_68FA
    ld a, [wD7F5]
    cp a, $FF
    jr z, Jump_00D_7737
    ld a, [wD7F6]
    ld [wD7F1], a
    ld a, [wD7F7]
    ld [wD7F2], a
    ld hl, wC7FC
    ld a, l
    ld [wD7F3], a
    ld a, h
    ld [wD7F4], a
    farcall Func_015_68FA
    cp a, $FF
    jr z, Jump_00D_7737
    ld a, [wD7F6]
    ld [wD006], a
    ld a, [wD7F7]
    ld [wD007], a
    farcall Func_016_5A7E
    ld a, c
    and a, a
    jr nz, Jump_00D_7737
    ld a, $01
    ld [wD7FA], a
    ret

Jump_00D_7737::
    xor a, a
    ld [wD7FA], a
    ld a, [wD7F6]
    ld l, a
    ld a, [wD7F7]
    ld h, a
    call CopyMonsterNameToBuffer_B0D
    ld hl, wC8CF
    ld de, wC130
    ld b, $10

Jump_00D_774E::
    ld a, [hl+]
    cp a, $F0
    jr z, Jump_00D_7758
    ld [de], a
    inc de
    dec b
    jr nz, Jump_00D_774E

Jump_00D_7758::
    ld a, $90
    ld [de], a
    inc de
    ld a, $A2
    ld [de], a
    inc de
    push de
    ld a, [wCB3D]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    farcall Func_015_68DC
    pop de
    ld hl, wC8C0
    ld b, $03

Jump_00D_7776::
    ld a, [hl]
    cp a, $E3
    jr nz, Jump_00D_7782
    inc hl
    dec b
    ld a, b
    cp a, $01
    jr nz, Jump_00D_7776

Jump_00D_7782::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_00D_7782
    ld a, $F0
    ld [de], a
    ret

; HL = string number; copies 16 bytes of that string of StringTable_MonsterNames (bank $08, via wDataBank) to wC8CF; wDataBank is restored
; 1 call site from 1 routine (e.g. Func_00D_76D0)
; reads: wDataBank
; writes: wDataBank
; points at: wC8CF
CopyMonsterNameToBuffer_B0D::
Func_00D_778C:: ; address name
    push hl
    ld a, [wDataBank]
    push af
    ld a, $08
    ld [wDataBank], a
    ld hl, StringDatabase
    ld a, $04
    add_a_to_hl
    call ReadWordFromDataBank
    ld e, b
    ld b, c
    ld c, e
    pop af
    pop hl
    push af
    sla l
    rl h
    add hl, bc
    call ReadWordFromDataBank
    ld e, b
    ld d, c
    pop af
    ld [wDataBank], a
    ld hl, wC8CF
    ld b, $08
    ld c, $10
    call CopyFromBankWaitVRAM
    ret

; 1 call site from 1 routine (e.g. Func_00D_74F1)
; reads: wC938, wC939, wC93A, wC93B, wC93C, wC93D, wC93E, wC93F, ...
; writes: hFF8E, hFF91, hFF98, wC8EF, wC8F0, wC8F1, wC8F4, wC8F5, ...
Func_00D_77C2::
    ld a, [wC938]
    ldh [hFF8E], a
    ld a, [wC939]
    ldh [hFF91], a
    ld a, [wC93A]
    ldh [hFF98], a
    ld a, [wC93B]
    ld [wC8EF], a
    ld a, [wC93C]
    ld [wC8F0], a
    ld a, [wC93D]
    ld [wC8F1], a
    ld a, [wC93E]
    ld [wC8F4], a
    ld a, [wC93F]
    ld [wC8F5], a
    ld a, [wC940]
    ld [wC8F6], a
    ld a, [wC941]
    ld [wC8F9], a
    ld a, [wC942]
    ld [wC8FA], a
    ld a, [wC943]
    ld [wC8FB], a
    ld a, [wC937]
    ld [wCB86], a
    xor a, a
    ld [wC936], a
    ret

; 1 call site from 1 routine (e.g. Func_00D_71BD)
; reads: hFFC6, wD7F1
; writes: rRAMG2, rRAMB, wD09D, wD09E
Func_00D_7812::
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, b
    ld c, $0D
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    and a, $0F
    ld [wD09D], a
    ld a, [wD7F1]
    ld [wD09E], a
    farcall Func_016_7A48
    xor a, a
    ld [rRAMG2], a
    ret

; 2 call sites from 2 routines (e.g. Func_00D_72F4, Func_00D_72D0)
; reads: wD7B4
; writes: rRAMG2, rRAMB
; points at: sA000, wC986
Func_00D_7839::
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [wD7B4]
    ld c, $A5
    call Multiply8
    ld de, sA000
    add hl, de
    ld de, wC986
    ld b, $A5

Jump_00D_7853::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_00D_7853
    xor a, a
    ld [rRAMG2], a
    ret

Data_00D_785E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $F8, $F9, $FA
    db $FB, $FC, $C3, $EA, $ED, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $B7, $B6, $C7, $A7, $A8, $A9, $AA, $AB, $AC, $AD, $AE, $AF, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_00D_789A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $97, $10, $97, $20, $97, $30, $97, $40, $97, $50, $97, $60, $97, $FF, $FF

Data_00D_78AA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $30, $41, $20, $43, $A0, $42, $30, $43, $90, $41, $50, $41, $FF, $FF

Data_00D_78B8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $70, $71, $72, $B7, $B6, $C3, $C3, $C3
    db $C3, $B7, $B6, $C3, $76, $73, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B5

Data_00D_78D6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_00D_78F6
    dw Data_00D_799B
    dw Data_00D_7A40
    dw Data_00D_7AE5
    dw Data_00D_7B8A
    dw Data_00D_7C2F
    dw Data_00D_7CD4
    dw Data_00D_7D79
    dw Data_00D_7E1E
    dw Data_00D_7EC3
    db $F6, $78, $F6, $78, $F6, $78, $F6, $78, $F6, $78, $F6, $78

Data_00D_78F6:: ; heuristic: target of a monotone pointer table; C0
    db $01, $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $4A, $00, $02, $00, $98
    db $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00, $FF, $FF, $FF, $FF, $98, $98
    db $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00, $98, $98, $98, $F0, $F0, $F0, $F0
    db $F0, $F0, $F0, $00, $25, $36, $61
    ds $1F, $00
    db $12, $23, $00, $00
    dw Func_00D_5800
    dw Func_00D_5800
    dw Func_00D_5C00
    dw Func_00D_5C00
    INCBIN "dwm2-cobi-us.gbc", $037958, $43

Data_00D_799B:: ; heuristic: target of a monotone pointer table; C0
    db $01, $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $1E, $01, $08, $00, $98
    db $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00, $FF, $FF, $FF, $FF, $98, $98
    db $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00, $98, $98, $98, $F0, $F0, $F0, $F0
    db $F0, $F0, $F0, $00, $07, $0D, $6B, $6F
    ds $1E, $00
    INCBIN "dwm2-cobi-us.gbc", $0379F1, $4F

Data_00D_7A40:: ; heuristic: target of a monotone pointer table; C0
    db $01, $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $BC, $00, $05, $00, $98
    db $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00, $FF, $FF, $FF, $FF, $98, $98
    db $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00, $98, $98, $98, $F0, $F0, $F0, $F0
    db $F0, $F0, $F0, $00, $13, $33, $6D
    ds $1F, $00
    INCBIN "dwm2-cobi-us.gbc", $037A96, $4F

Data_00D_7AE5:: ; heuristic: target of a monotone pointer table; C0
    db $01, $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $92, $00, $04, $00, $98
    db $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00, $FF, $FF, $FF, $FF, $98, $98
    db $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00, $98, $98, $98, $F0, $F0, $F0, $F0
    db $F0, $F0, $F0, $00, $19, $2F, $3C, $9B
    ds $1E, $00
    INCBIN "dwm2-cobi-us.gbc", $037B3B, $4F

Data_00D_7B8A:: ; heuristic: target of a monotone pointer table; C0
    db $01, $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $5E, $00, $02, $00, $98
    db $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00, $FF, $FF, $FF, $FF, $98, $98
    db $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00, $98, $98, $98, $F0, $F0, $F0, $F0
    db $F0, $F0, $F0, $00, $20, $34, $63, $90
    ds $1E, $00
    INCBIN "dwm2-cobi-us.gbc", $037BE0, $4F

Data_00D_7C2F:: ; heuristic: target of a monotone pointer table; C0
    db $01, $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $80, $00, $03, $00, $98
    db $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00, $FF, $FF, $FF, $FF, $98, $98
    db $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00, $98, $98, $98, $F0, $F0, $F0, $F0
    db $F0, $F0, $F0, $00, $79, $7B, $92
    ds $1F, $00
    INCBIN "dwm2-cobi-us.gbc", $037C85, $4F

Data_00D_7CD4:: ; heuristic: target of a monotone pointer table; C0
    db $01, $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $0D, $01, $07, $00, $98
    db $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00, $FF, $FF, $FF, $FF, $98, $98
    db $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00, $98, $98, $98, $F0, $F0, $F0, $F0
    db $F0, $F0, $F0, $00, $3A, $3B, $A0
    ds $1F, $00
    db $35, $35, $00, $00
    dw Func_00D_7300
    dw Func_00D_7301
    dw $4601
    dw Func_00D_4602
    INCBIN "dwm2-cobi-us.gbc", $037D36, $43

Data_00D_7D79:: ; heuristic: target of a monotone pointer table; C0
    db $01, $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $33, $00, $01, $00, $98
    db $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00, $FF, $FF, $FF, $FF, $98, $98
    db $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00, $98, $98, $98, $F0, $F0, $F0, $F0
    db $F0, $F0, $F0, $00, $19, $82, $9C
    ds $1F, $00
    INCBIN "dwm2-cobi-us.gbc", $037DCF, $4F

Data_00D_7E1E:: ; heuristic: target of a monotone pointer table; C0
    db $01, $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $0A, $01, $07, $00, $98
    db $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00, $FF, $FF, $FF, $FF, $98, $98
    db $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00, $98, $98, $98, $F0, $F0, $F0, $F0
    db $F0, $F0, $F0, $00, $50, $51, $52
    ds $1F, $00
    INCBIN "dwm2-cobi-us.gbc", $037E74, $4F

Data_00D_7EC3:: ; heuristic: target of a monotone pointer table; C0
    db $01, $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $33, $01, $08, $00, $98
    db $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00, $FF, $FF, $FF, $FF, $98, $98
    db $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00, $98, $98, $98, $F0, $F0, $F0, $F0
    db $F0, $F0, $F0, $00, $6F, $81, $91
    ds $1F, $00
    INCBIN "dwm2-cobi-us.gbc", $037F19, $4D
    ds $9A, $00
