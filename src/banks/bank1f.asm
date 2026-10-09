SECTION "Bank 1F", ROMX[$4000], BANK[$1F]
    db $1F, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

Data_01F_4010:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $07C010, $D0

Data_01F_40E0:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $F8, $FF, $84, $FF, $82, $FF, $82, $FF, $82, $FF, $84, $FF, $F8, $FF, $00
    db $FF, $FE, $FF, $80, $FF, $80, $FF, $FC, $FF, $80, $FF, $80, $FF, $FE, $FF, $00
    db $FF, $FE, $FF, $80, $FF, $80, $FF, $FC, $FF, $80, $FF, $80, $FF, $80, $FF, $00

Data_01F_4110:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $3C, $FF, $42, $FF, $80, $FF, $9E, $FF, $82, $FF, $42, $FF, $3C, $FF, $00

Data_01F_4120:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $82, $FF, $82, $FF, $82, $FF, $FE, $FF, $82, $FF, $82, $FF, $82, $FF, $00

Data_01F_4130:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $7C, $FF, $10, $FF, $10, $FF, $10, $FF, $10, $FF, $10, $FF, $7C, $FF, $00
    db $FF, $7E, $FF, $08, $FF, $08, $FF, $08, $FF, $88, $FF, $88, $FF, $70, $FF, $00
    db $FF, $84, $FF, $88, $FF, $90, $FF, $B0, $FF, $C8, $FF, $84, $FF, $82, $FF, $00

Data_01F_4160:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $80, $FF, $80, $FF, $80, $FF, $80, $FF, $80, $FF, $80, $FF, $FE, $FF, $00

Data_01F_4170:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $82, $FF, $C6, $FF, $AA, $FF, $92, $FF, $82, $FF, $82, $FF, $82, $FF, $00

Data_01F_4180:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $82, $FF, $C2, $FF, $A2, $FF, $92, $FF, $8A, $FF, $86, $FF, $82, $FF, $00

Data_01F_4190:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $38, $FF, $44, $FF, $82, $FF, $82, $FF, $82, $FF, $44, $FF, $38, $FF, $00

Data_01F_41A0:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $FC, $FF, $82, $FF, $82, $FF, $FC, $FF, $80, $FF, $80, $FF, $80, $FF, $00
    db $FF, $38, $FF, $44, $FF, $82, $FF, $82, $FF, $8A, $FF, $44, $FF, $3A, $FF, $00
    db $FF, $FC, $FF, $82, $FF, $82, $FF, $FC, $FF, $88, $FF, $84, $FF, $82, $FF, $00

Data_01F_41D0:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $78, $FF, $84, $FF, $80, $FF, $7C, $FF, $02, $FF, $82, $FF, $7C, $FF, $00
    db $FF, $FE, $FF, $10, $FF, $10, $FF, $10, $FF, $10, $FF, $10, $FF, $10, $FF, $00
    db $FF, $82, $FF, $82, $FF, $82, $FF, $82, $FF, $82, $FF, $82, $FF, $7C, $FF, $00
    db $FF, $82, $FF, $82, $FF, $44, $FF, $44, $FF, $28, $FF, $28, $FF, $10, $FF, $00

Data_01F_4210:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $82, $FF, $92, $FF, $AA, $FF, $AA, $FF, $C6, $FF, $C6, $FF, $82, $FF, $00
    db $FF, $C6, $FF, $44, $FF, $28, $FF, $10, $FF, $28, $FF, $44, $FF, $C6, $FF, $00

Data_01F_4230:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $82, $FF, $44, $FF, $28, $FF, $10, $FF, $10, $FF, $10, $FF, $10, $FF, $00
    db $FF, $FE, $FF, $04, $FF, $08, $FF, $10, $FF, $20, $FF, $40, $FF, $FE, $FF, $00

Data_01F_4250:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $00, $FF, $78, $FF, $04, $FF, $7C, $FF, $84, $FF, $7E, $FF, $00

Data_01F_4260:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $80, $FF, $80, $FF, $80, $FF, $F8, $FF, $84, $FF, $84, $FF, $F8, $FF, $00
    db $FF, $00, $FF, $00, $FF, $78, $FF, $84, $FF, $80, $FF, $84, $FF, $78, $FF, $00

Data_01F_4280:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $04, $FF, $04, $FF, $04, $FF, $7C, $FF, $84, $FF, $84, $FF, $7C, $FF, $00

Data_01F_4290:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $00, $FF, $78, $FF, $84, $FF, $FC, $FF, $80, $FF, $7C, $FF, $00
    db $FF, $18, $FF, $24, $FF, $20, $FF, $FC, $FF, $20, $FF, $20, $FF, $20, $FF, $00
    db $FF, $00, $FF, $00, $FF, $7C, $FF, $84, $FF, $84, $FF, $7C, $FF, $04, $FF, $F8
    db $FF, $80, $FF, $80, $FF, $80, $FF, $F8, $FF, $84, $FF, $84, $FF, $84, $FF, $00

Data_01F_42D0:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $10, $FF, $00, $FF, $10, $FF, $10, $FF, $10, $FF, $10, $FF, $00
    db $FF, $00, $FF, $10, $FF, $00, $FF, $10, $FF, $10, $FF, $10, $FF, $10, $FF, $60
    db $FF, $80, $FF, $80, $FF, $8C, $FF, $B0, $FF, $C0, $FF, $B0, $FF, $8C, $FF, $00

Data_01F_4300:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $10, $FF, $10, $FF, $10, $FF, $10, $FF, $10, $FF, $10, $FF, $10, $FF, $00

Data_01F_4310:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $00, $FF, $EC, $FF, $92, $FF, $92, $FF, $92, $FF, $92, $FF, $00

Data_01F_4320:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $00, $FF, $F8, $FF, $84, $FF, $84, $FF, $84, $FF, $84, $FF, $00

Data_01F_4330:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $00, $FF, $78, $FF, $84, $FF, $84, $FF, $84, $FF, $78, $FF, $00

Data_01F_4340:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $00, $FF, $F8, $FF, $84, $FF, $84, $FF, $F8, $FF, $80, $FF, $80
    db $FF, $00, $FF, $00, $FF, $7C, $FF, $84, $FF, $84, $FF, $7C, $FF, $04, $FF, $04
    db $FF, $00, $FF, $00, $FF, $9C, $FF, $A0, $FF, $C0, $FF, $80, $FF, $80, $FF, $00

Data_01F_4370:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $07C370, $50

Data_01F_43C0:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $07C3C0, $90

Data_01F_4450:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $82, $FF, $82, $FF, $02, $FF, $3E, $FF, $42, $FF, $42, $FF, $3E, $FF, $00
    db $FF, $00, $FF, $20, $FF, $A8, $FF, $72, $FF, $70, $FF, $A8, $FF, $22, $FF, $00
    db $FF, $70, $FF, $20, $FF, $20, $FF, $20, $FF, $20, $FF, $20, $FF, $70, $FF, $00

Data_01F_4480:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $07C480, $80

Data_01F_4500:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00

Data_01F_4510:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $07C510, $270

Data_01F_4780:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $07C780, $160

Data_01F_48E0:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $05, $FF, $05, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00

Data_01F_48F0:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $02, $FF, $05, $FF, $02, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $30, $FF, $48, $FF, $48, $FF, $30

Data_01F_4910:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $07C910, $80

Data_01F_4990:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $07C990, $B0

Data_01F_4A40:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $18, $FF, $18, $FF, $00, $FF, $00, $FF, $18, $FF, $18, $FF, $00
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $92, $FF, $00

Data_01F_4A60:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $80, $FF, $80, $FF, $80, $FF, $8A, $FF, $8A, $FF, $84, $FF, $F4

Data_01F_4A70:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $E0, $FF, $80, $FF, $80, $FF, $EA, $FF, $84, $FF, $84, $FF, $EA

Data_01F_4A80:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $1E, $FF, $06, $FF, $0A, $FF, $72, $FF, $90, $FF, $90, $FF, $60

Data_01F_4A90:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $38, $FF, $44, $FF, $44, $FF, $38, $FF, $10, $FF, $7C, $FF, $10

Data_01F_4AA0:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $10, $FF, $38, $FF, $7C, $FF, $FE, $FF, $38, $FF, $38, $FF, $38
    db $FF, $00, $FF, $6C, $FF, $6C, $FF, $24, $FF, $48, $FF, $00, $FF, $00, $FF, $00
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $60, $FF, $60, $FF, $20, $FF, $40

Data_01F_4AD0:: ; heuristic: argument of a bank-switching copy helper; C0
    db $FF, $00, $FF, $10, $FF, $10, $FF, $FE, $FF, $7C, $FF, $38, $FF, $7C, $FF, $C6

Data_01F_4AE0:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $07CAE0, $C0
    ds $40E, $00

Data_01F_4FAE:: ; heuristic: argument of a bank-switching copy helper; C0
    ds $62, $00
    db $FF, $82, $FF, $C2, $FF, $A2, $FF, $92, $FF, $8A, $FF, $86, $FF, $82, $FF, $00
    db $FF, $00, $FF, $00, $FF, $78, $FF, $84, $FF, $84, $FF, $84, $FF, $78, $FF, $00
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00

; 25 call sites from 10 routines (e.g. Func_000_0150, Func_000_05E2, Func_000_06A8, Func_000_0705, ...)
; reads: wC524, wC47C
; points at: wC47F
Func_01F_5040::
    ld a, [wC524]
    or a, a
    ret z
    ld a, [wC47C]
    cp a, $FF
    jr nz, Jump_01F_5051
    ld hl, wC47F
    jr Jump_01F_505E

Jump_01F_5051::
    ld l, a
    ld h, $00
    add hl, hl
    ld de, Data_01F_5094
    add hl, de
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    pop hl

Jump_01F_505E::
    ld a, [hl]
    and a, $07
    ret z
    ld b, a
    ld c, $00

Jump_01F_5065::
    push bc
    ld a, $00
    ldh [c], a
    ld a, $30
    ldh [c], a
    ld b, $10

Jump_01F_506E::
    ld e, $08
    ld a, [hl+]
    ld d, a

Jump_01F_5072::
    bit 0, d
    ld a, $10
    jr nz, Jump_01F_507A
    ld a, $20

Jump_01F_507A::
    ldh [c], a
    ld a, $30
    ldh [c], a
    rr d
    dec e
    jr nz, Jump_01F_5072
    dec b
    jr nz, Jump_01F_506E
    ld a, $20
    ldh [c], a
    ld a, $30
    ldh [c], a
    pop bc
    dec b
    ret z
    call SpinDelay
    jr Jump_01F_5065

Data_01F_5094:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $07D094, $17A

; 1 call site from 1 routine (e.g. Func_001_4AD4)
Func_01F_520E::
    ld de, Data_01F_5223
    call Func_000_25C9
    ret
    db $11, $23, $52, $CD, $FE, $25, $C9, $CD, $0E, $52, $CD, $11, $26, $C9

Data_01F_5223:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_01F_5225

Data_01F_5225:: ; heuristic: target of a monotone pointer table; C0
    dw Data_01F_52A5
    dw Data_01F_52A5
    dw Data_01F_52E3
    dw Data_01F_5303
    dw Data_01F_5327
    dw Data_01F_534B
    dw Data_01F_536D
    dw Data_01F_5394
    dw Data_01F_53B8
    dw Data_01F_53DA
    dw Data_01F_53F9
    dw Data_01F_5410
    dw Data_01F_5433
    dw Data_01F_5455
    dw Data_01F_5475
    dw Data_01F_5498
    dw Data_01F_54B5
    dw Data_01F_54D7
    dw Data_01F_54F7
    dw Data_01F_5519
    dw Data_01F_5540
    dw Data_01F_5540
    dw Data_01F_5561
    dw Data_01F_5582
    dw Data_01F_55A7
    dw Data_01F_55CA
    dw Data_01F_55ED
    dw Data_01F_5610
    dw Data_01F_5627
    dw Data_01F_5644
    dw Data_01F_5664
    dw Data_01F_5664
    dw Data_01F_5664
    dw Data_01F_5664
    dw Data_01F_5696
    dw Data_01F_56B6
    dw Data_01F_56DA
    dw Data_01F_56FD
    dw Data_01F_571F
    dw Data_01F_5740
    dw Data_01F_5764
    dw Data_01F_5786
    dw Data_01F_57A5
    dw Data_01F_57BC
    dw Data_01F_57DD
    dw Data_01F_57FF
    dw Data_01F_581F
    dw Data_01F_5842
    dw Data_01F_5864
    dw Data_01F_5886
    dw Data_01F_58A6
    dw Data_01F_58C8
    dw Data_01F_58EF
    dw Data_01F_58EF
    dw Data_01F_5910
    dw Data_01F_5931
    dw Data_01F_5956
    dw Data_01F_5979
    dw Data_01F_599C
    dw Data_01F_59BD
    dw Data_01F_59D4
    dw Data_01F_59F2
    dw Data_01F_5A3A
    dw Data_01F_5A3A

Data_01F_52A5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Is your", $F1
    db "adventure done?", $FA, $F7
    db $EF, $EE, "Or do you need", $EF, $EE, "something?", $F7
    db $F0

Data_01F_52E3:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Which one's", $F1
    db "staying here?", $F0

Data_01F_5303:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " So this one", $F1
    db "is staying here?", $F0

Data_01F_5327:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Check up on", $F1
    db "the others too.", $F7
    db $F0

Data_01F_534B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Do you need", $F1
    db "anything else?", $F0

Data_01F_536D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " No, you can't", $F1
    db "go off all alone.", $F7
    db $F0

Data_01F_5394:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Switch with", $F1
    db "one on the farm?", $F0

Data_01F_53B8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " What'll you", $F1
    db "switch it with?", $F0

Data_01F_53DA:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " So you'll", $F1
    db "take this one?", $F0

Data_01F_53F9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " I switched", $F1
    db $F9, "0.", $F7
    db $F0

Data_01F_5410:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " The farm has", $F1
    db "no more room.", $F7
    db $F0

Data_01F_5433:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " What'll you", $F1
    db "switch it with?", $F0

Data_01F_5455:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Which one", $F1
    db "will you take?", $F0

Data_01F_5475:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Is this the", $F1
    db "one you'll take?", $F0

Data_01F_5498:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " It's eager", $F1
    db "to go, ", $F9, "0.", $F7
    db $F0

Data_01F_54B5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " You haven't", $F1
    db "left any here.", $F7
    db $F0

Data_01F_54D7:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " You can't", $F1
    db "take any more.", $F7
    db $F0

Data_01F_54F7:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " What do you", $F1
    db "want to check?", $F0

Data_01F_5519:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " We don't have", $F1
    db "any of your eggs.", $F7
    db $F0

Data_01F_5540:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Which one", $F1
    db "will you check?", $F0

Data_01F_5561:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Which egg", $F1
    db "will you check?", $F0

Data_01F_5582:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " What  do you", $F1
    db "want to release?", $F0

Data_01F_55A7:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Which one", $F1
    db "will you release?", $F0

Data_01F_55CA:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Which egg", $F1
    db "will you release?", $F0

Data_01F_55ED:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " It'll be gone", $F1
    db "forever. Sure?", $F0

Data_01F_5610:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The egg was", $F1
    db "released.", $F7
    db $F0

Data_01F_5627:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 was released", $F1
    db "in the wild.", $F0

Data_01F_5644:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " Come back", $F1
    db "anytime, sis!", $F7
    db $F0

Data_01F_5664:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Hi, big", $F1
    db "brother!", $FA, $F7
    db $EF, $EE, "Do you need", $EF, $EE, "anything?", $F0

Data_01F_5696:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Which one's", $F1
    db "staying here?", $F0

Data_01F_56B6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " So this one", $F1
    db "is staying here?", $F0

Data_01F_56DA:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Say bye to", $F1
    db $F9, "0 for a while.", $F7
    db $F0

Data_01F_56FD:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Do you need", $F1
    db "anything else?", $F0

Data_01F_571F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " You'll be", $F1
    db "left all alone!", $F7
    db $F0

Data_01F_5740:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Switch with", $F1
    db "one on the farm?", $F0

Data_01F_5764:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " What'll you", $F1
    db "switch it with?", $F0

Data_01F_5786:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " So you'll", $F1
    db "take this one?", $F0

Data_01F_57A5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " I switched", $F1
    db $F9, "0.", $F7
    db $F0

Data_01F_57BC:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " The farm is", $F1
    db "out of room.", $F7
    db $F0

Data_01F_57DD:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " What'll you", $F1
    db "switch it with?", $F0

Data_01F_57FF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Which one", $F1
    db "will you take?", $F0

Data_01F_581F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Is this the", $F1
    db "one you'll take?", $F0

Data_01F_5842:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " ", $F9, "0, it", $F1
    db "really missed you.", $F7
    db $F0

Data_01F_5864:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " You haven't", $F1
    db "left any here.", $F7
    db $F0

Data_01F_5886:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " You can't", $F1
    db "take any more.", $F7
    db $F0

Data_01F_58A6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " What do you", $F1
    db "want to check?", $F0

Data_01F_58C8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " We don't have", $F1
    db "any of your eggs.", $F7
    db $F0

Data_01F_58EF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Which one", $F1
    db "will you check?", $F0

Data_01F_5910:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Which egg", $F1
    db "will you check?", $F0

Data_01F_5931:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " What  do you", $F1
    db "want to release?", $F0

Data_01F_5956:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Which one", $F1
    db "will you release?", $F0

Data_01F_5979:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Which egg", $F1
    db "will you release?", $F0

Data_01F_599C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " It'll be gone", $F1
    db "forever. OK?", $F0

Data_01F_59BD:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The egg was", $F1
    db "releas"

Data_01F_59CF:: ; heuristic: bank from RAM variable $D7FE; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ed.", $F7
    db $F0

Data_01F_59D4:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 was released", $F1
    db "in the wild.", $F7
    db $F0

Data_01F_59F2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Please tell", $F1
    db "me about your", $FA, $F7
    db $EF, $EE, "adventure next", $EF, $EE, "time, big brother!", $F7
    db $F0

Data_01F_5A3A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $07DA3A, $13C

Data_01F_5B76:: ; heuristic: bank from RAM variable $D7FE; C0
    db $5B, $E8, $EA, $05, $C0, $07, $3B, $5A, $07, $77, $5B, $EA, $15, $C0, $E8, $E4
    db $04, $00, $07, $62, $5B, $E8, $07, $84, $5B, $EA, $16, $C0, $E8, $07, $62, $5B
    db $E8, $EA, $17, $C0, $E8, $E4, $0A, $0C, $0E, $1A, $00, $EA, $06, $C0, $07, $97
    db $5B, $07

Data_01F_5BA8:: ; heuristic: bank from RAM variable $D7FE; C0
    INCBIN "dwm2-cobi-us.gbc", $07DBA8, $6D

; 8 call sites from 8 routines (e.g. Func_014_4BE3, Func_015_4182, Func_015_5A67, Func_015_60BF, ...)
; reads: wD7AF, wD7B1, wD7A9, wD781, wD7B0
; writes: rRAMG2, rRAMB, wC8D9, wD781
; points at: wD789
Func_01F_5C15::
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld hl, wD789
    ld a, [wD7AF]
    ld b, a
    add a, a
    add a, a
    add a, b
    add a, l
    ld l, a
    jr nc, Jump_01F_5C2D
    inc h

Jump_01F_5C2D::
    ld c, $00

Jump_01F_5C2F::
    ld a, [wD7B1]
    cp a, $04
    jr c, Jump_01F_5C3B
    ld a, [wD7A9]
    jr Jump_01F_5C4A

Jump_01F_5C3B::
    ld a, [wD7B0]
    cp a, $01
    jr nz, Jump_01F_5C47
    ld a, [wD7A9]
    jr Jump_01F_5C4A

Jump_01F_5C47::
    ld a, [wD7A9]

Jump_01F_5C4A::
    ld b, a
    ld a, [wD7AF]
    push bc
    ld c, a
    add a, a
    add a, a
    add a, c
    pop bc
    add a, c
    cp a, b
    jr nc, Jump_01F_5C90
    push hl
    push bc
    ld a, [hl]
    ld c, $01
    call Func_000_1FA4
    ld a, $F0
    ld [wC8D9], a
    pop bc
    push bc
    ld a, c
    cp a, $04
    jr nz, Jump_01F_5C71
    call Func_01F_5CA6
    jr Jump_01F_5C81

Jump_01F_5C71::
    ld a, c
    add a, a
    ld hl, Data_01F_5C9C
    add a, l
    ld l, a
    jr nc, Jump_01F_5C7B
    inc h

Jump_01F_5C7B::
    ld e, [hl]
    inc hl
    ld d, [hl]
    call Func_000_21A1

Jump_01F_5C81::
    pop bc
    pop hl
    inc hl
    inc c
    ld a, [wD7A9]
    cp a, c
    jr z, Jump_01F_5C90
    ld a, c
    cp a, $05
    jr c, Jump_01F_5C2F

Jump_01F_5C90::
    xor a, a
    ld [rRAMG2], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Data_01F_5C9C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $8D, $50, $8D, $A0, $8D, $00, $8F, $40, $8A

; 1 call site from 1 routine (e.g. Func_01F_5C15)
; reads: wD784, wD785
; writes: wD784, wD785
; points at: wC8CF
Func_01F_5CA6::
    xor a, a
    ld [wD784], a
    ld [wD785], a
    ld hl, wC8CF

Jump_01F_5CB0::
    ld a, [wD784]
    push hl
    add a, l
    ld l, a
    jr nc, Jump_01F_5CB9
    inc h

Jump_01F_5CB9::
    ld a, [hl]
    cp a, $F0
    jp z, Jump_01F_5CEF
    cp a, $8D
    jr z, Jump_01F_5CCF
    cp a, $8E
    jr z, Jump_01F_5CCF
    call Func_01F_5CF8
    call CopyFromBankWaitVRAM
    jr Jump_01F_5CDE

Jump_01F_5CCF::
    push af
    ld a, [wD785]
    dec a
    ld [wD785], a
    pop af
    call Func_01F_5CF8
    call OrFromBankWaitVRAM

Jump_01F_5CDE::
    pop hl
    ld a, [wD785]
    inc a
    ld [wD785], a
    ld a, [wD784]
    inc a
    ld [wD784], a
    jr Jump_01F_5CB0

Jump_01F_5CEF::
    pop hl
    xor a, a
    ld [wD785], a
    ld [wD784], a
    ret

; 2 call sites from 1 routine (e.g. Func_01F_5CA6)
; reads: wD785
Func_01F_5CF8::
    swap a
    ld d, a
    and a, $F0
    ld e, a
    ld a, d
    and a, $0F
    ld d, a
    ld hl, Data_01F_4010
    add hl, de
    ld e, l
    ld d, h
    push de
    ld hl, Data_01F_5D20
    ld a, [wD785]
    sla a
    add a, l
    ld l, a
    jr nc, Jump_01F_5D16
    inc h

Jump_01F_5D16::
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    pop de
    ld b, $1F
    ld c, $10
    ret

Data_01F_5D20:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $40, $8A, $50, $8A, $60, $8A, $E0, $8C, $F0, $8C

; 25 call sites from 15 routines (e.g. Func_01F_73EC, Func_01F_74E3, Func_01F_753A, Func_01F_7591, ...)
; reads: wD7F6, rSTAT, wIsCGB, wD7F7
; writes: rVBK
; points at: wD7F1
Func_01F_5D2A::
    ld hl, wD7F1
    ld d, [hl]
    inc hl
    ld e, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld c, [hl]
    inc hl
    ld a, [hl]
    ld h, a
    ld a, [wD7F6]
    ld l, a

Jump_01F_5D3B::
    push hl
    push bc

Jump_01F_5D3D::
    di

Jump_01F_5D3E::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_01F_5D3E
    ld a, [de]
    ld [hl+], a
    ei
    ld a, l
    and a, $1F
    jr nz, Jump_01F_5D54
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

Jump_01F_5D54::
    inc de
    dec b
    jr nz, Jump_01F_5D3D
    pop bc
    pop hl
    push hl
    push bc
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_01F_5D89
    ld a, [wD7F7]
    and a, a
    jr nz, Jump_01F_5D89
    ld a, $01
    ldh [rVBK], a

Jump_01F_5D6C::
    di

Jump_01F_5D6D::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_01F_5D6D
    xor a, a
    ld [hl+], a
    ei
    ld a, l
    and a, $1F
    jr nz, Jump_01F_5D83
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

Jump_01F_5D83::
    dec b
    jr nz, Jump_01F_5D6C
    xor a, a
    ldh [rVBK], a

Jump_01F_5D89::
    pop bc
    pop hl
    ld a, $20
    add a, l
    ld l, a
    jr nc, Jump_01F_5D92
    inc h

Jump_01F_5D92::
    ld a, h
    and a, $9B
    ld h, a
    dec c
    jr nz, Jump_01F_5D3B
    ret

; 10 call sites from 10 routines (e.g. Func_01F_7494, Func_00C_5177, Func_014_5CA8, Func_014_631C, ...)
; reads: wD7F1, wD7F2, wD7F3, wD7F4, wD7F5, wD7F6, rSTAT, wIsCGB, ...
; writes: rVBK
Func_01F_5D9A::
    ld a, [wD7F1]
    ld d, a
    ld a, [wD7F2]
    ld e, a
    ld a, [wD7F3]
    ld b, a
    ld a, [wD7F4]
    ld c, a
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a

Jump_01F_5DB2::
    push hl
    push bc

Jump_01F_5DB4::
    di

Jump_01F_5DB5::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_01F_5DB5
    ld a, [de]
    ld [hl+], a
    ei
    ld a, l
    and a, $1F
    jr nz, Jump_01F_5DCB
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

Jump_01F_5DCB::
    dec b
    jr nz, Jump_01F_5DB4
    pop bc
    pop hl
    push hl
    push bc
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_01F_5DFF
    ld a, [wD7F7]
    and a, a
    jr nz, Jump_01F_5DFF
    ld a, $01
    ldh [rVBK], a

Jump_01F_5DE2::
    di

Jump_01F_5DE3::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_01F_5DE3
    xor a, a
    ld [hl+], a
    ei
    ld a, l
    and a, $1F
    jr nz, Jump_01F_5DF9
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

Jump_01F_5DF9::
    dec b
    jr nz, Jump_01F_5DE2
    xor a, a
    ldh [rVBK], a

Jump_01F_5DFF::
    pop bc
    pop hl
    ld a, $20
    add a, l
    ld l, a
    jr nc, Jump_01F_5E08
    inc h

Jump_01F_5E08::
    ld a, h
    and a, $9B
    ld h, a
    dec c
    ld a, c
    and a, a
    jr nz, Jump_01F_5DB2
    ret

Data_01F_5E12:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C3

Data_01F_5E13:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $07DE13, $1D5

Data_01F_5FE8:: ; heuristic: bank from RAM variable $D7FE; C0
    INCBIN "dwm2-cobi-us.gbc", $07DFE8, $52

Data_01F_603A:: ; heuristic: bank from RAM variable $D7FE; C0
    INCBIN "dwm2-cobi-us.gbc", $07E03A, $49

Data_01F_6083:: ; heuristic: bank from RAM variable $D7FE; C0
    INCBIN "dwm2-cobi-us.gbc", $07E083, $42C

Data_01F_64AF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $07E4AF, $6C

Data_01F_651B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $24, $C3

Data_01F_653F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $38, $C3
    INCBIN "dwm2-cobi-us.gbc", $07E577, $41

Data_01F_65B8:: ; heuristic: bank from RAM variable $D7FE; C0
    INCBIN "dwm2-cobi-us.gbc", $07E5B8, $73

Data_01F_662B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $07E62B, $B4

Data_01F_66DF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $07E6DF, $470

Data_01F_6B4F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $07EB4F, $D8

Data_01F_6C27:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $38, $C3

Data_01F_6C5F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $07EC5F, $D8

Data_01F_6D37:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $38, $C3

Data_01F_6D6F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $07ED6F, $D8

Data_01F_6E47:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $7C, $C3, $C3, $C3
    db $C3, $C3, $C3, $6E, $7E, $C3, $C3, $C3, $C3, $C3, $C3, $6F, $7E, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $7D
    ds $1B, $C3
    INCBIN "dwm2-cobi-us.gbc", $07EE87, $1B1
    ds $12, $B1
    db $B2, $B6, $C3, $C3, $C3, $C3, $06, $35, $3B, $28, $39, $C3, $13, $24, $30, $28
    db $C3, $C3, $C3, $C3, $B7, $B8
    ds $12, $B9
    db $BA, $B6, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $0B, $0C, $0D, $0E, $C3
    db $0F, $10, $11, $12, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $13, $14, $15, $16, $17, $18, $19, $1A, $1B, $1C, $1D, $1E, $1F, $C3
    db $20, $21, $22, $23, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $24, $25, $26, $27, $28, $29, $2A, $2B, $2C, $2D, $2E, $2F, $30, $C3
    db $31, $32, $33, $34, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $35, $36, $37, $38, $39, $3A, $3B, $3C, $3D, $3E, $3F, $40, $41, $C3
    db $42, $43, $44, $45, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $46, $47, $48, $49, $4A, $4B, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $06, $13, $05, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B3
    ds $12, $B4
    db $B5, $B0
    ds $12, $B1
    db $B2, $B6, $5C, $5D, $5E, $5F, $60, $61, $62, $63, $64, $65, $66, $67, $68, $69
    db $6A, $6B, $6C, $6D, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $6E, $6F, $70, $71, $72, $73, $74, $75, $76, $77, $78, $79, $7A, $7B
    db $7C, $7D, $7E, $7F, $B7, $B3
    ds $12, $B4
    db $B5, $B0
    ds $12, $B1
    db $B2, $B6, $5C, $5D, $5E, $5F, $60, $61, $62, $63, $64, $65, $66, $67, $68, $69
    db $6A, $6B, $6C, $6D, $B7, $B3
    ds $12, $B4
    INCBIN "dwm2-cobi-us.gbc", $07F1EE, $187

; 2 call sites from 2 routines (e.g. Func_037_5344, Func_0F1_5285)
Func_01F_7375::
    ld c, $00

Jump_01F_7377::
    push bc
    ld a, c
    ld de, Data_01F_73BC
    add a, e
    ld e, a
    jr nc, Jump_01F_7381
    inc d

Jump_01F_7381::
    ld a, [de]
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
    ld hl, Data_01F_4010
    add hl, de
    ld e, l
    ld d, h
    push de
    ld a, c
    sla a
    ld de, Data_01F_73CC
    add a, e
    ld e, a
    jr nc, Jump_01F_73A7
    inc d

Jump_01F_73A7::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    pop de
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    pop bc
    inc c
    ld a, c
    cp a, $10
    jr c, Jump_01F_7377
    ret

Data_01F_73BC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A3, $54, $44, $11, $16, $19, $48, $24, $A6, $12, $31, $29, $32, $18, $14, $25

Data_01F_73CC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $D0, $8E, $E0, $8E, $F0, $8E, $50, $8F, $60, $8F, $70, $8F, $D0, $8F, $E0, $8F
    db $F0, $8F, $00, $97, $10, $97, $20, $97, $30, $97, $40, $97, $50, $97, $60, $97

; 2 call sites from 2 routines (e.g. Func_037_542C, Func_0F1_5344)
; reads: wD782, wCA36, wCA37, wIsCGB, wD781
; writes: wD7F5, wD7F6, wD7F1, wD7F2, wD7F3, wD7F4, wD7F7, wD782, ...
Func_01F_73EC::
    ld a, [wD782]
    and a, a
    jp nz, Jump_01F_7436
    call Func_01F_77AB
    ld de, $0161
    add hl, de
    ld a, h
    ld [wD7F5], a
    ld a, l
    ld [wD7F6], a
    ld de, Data_01F_651B
    ld a, d
    ld [wD7F1], a
    ld a, e
    ld [wD7F2], a
    ld a, $06
    ld [wD7F3], a
    ld a, $06
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_01F_5D2A
    ld a, [wCA36]
    ld e, a
    ld a, [wCA37]
    ld d, a
    ld hl, vTiles2 + $200
    ld c, $01
    call Func_000_1FE3
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_01F_7436::
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_01F_745C
    ld a, [wCA36]
    ld e, a
    ld a, [wCA37]
    ld d, a
    push de
    ld a, $7F
    ld [wC526], a
    call Func_000_0829
    ld a, $01
    ldh [hFFC6], a
    call Func_01F_77AB
    ld de, $0161
    add hl, de
    pop de
    call Func_000_2090

Jump_01F_745C::
    call Func_01F_77AB
    ld de, $0161
    add hl, de
    ld a, h
    ld [wD7F5], a
    ld a, l
    ld [wD7F6], a
    ld de, Data_01F_64AF
    ld a, d
    ld [wD7F1], a
    ld a, e
    ld [wD7F2], a
    ld a, $06
    ld [wD7F3], a
    ld a, $06
    ld [wD7F4], a
    ld a, $01
    ld [wD7F7], a
    call Func_01F_5D2A
    xor a, a
    ld [wD782], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; 2 call sites from 2 routines (e.g. Func_037_5344, Func_0F1_5285)
; writes: wD7F5, wD7F6, wD7F1, wD7F2, wD7F3, wD7F4, wD7F7
Func_01F_7494::
    call Func_01F_77AB
    ld a, h
    ld [wD7F5], a
    ld a, l
    ld [wD7F6], a
    ld de, Data_01F_5E12
    ld a, d
    ld [wD7F1], a
    ld a, e
    ld [wD7F2], a
    ld a, $20
    ld [wD7F3], a
    ld a, $20
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_01F_5D9A
    ld de, Data_01F_4250
    ld hl, vTiles1 + $7E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4A70
    ld hl, vTiles1 + $7F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4AD0
    ld hl, vTiles2 + $6F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ret

; 2 call sites from 2 routines (e.g. Func_037_542C, Func_0F1_5344)
; writes: wD7F5, wD7F6, wD7F1, wD7F2, wD7F3, wD7F4, wD7F7
Func_01F_74E3::
    call Func_01F_77AB
    ld de, $0068
    add hl, de
    ld a, h
    ld [wD7F5], a
    ld a, l
    ld [wD7F6], a
    ld de, Data_01F_662B
    ld a, d
    ld [wD7F1], a
    ld a, e
    ld [wD7F2], a
    ld a, $0C
    ld [wD7F3], a
    ld a, $0F
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_01F_5D2A
    call Func_01F_77AB
    ld de, $0160
    add hl, de
    ld a, h
    ld [wD7F5], a
    ld a, l
    ld [wD7F6], a
    ld de, Data_01F_653F
    ld a, d
    ld [wD7F1], a
    ld a, e
    ld [wD7F2], a
    ld a, $08
    ld [wD7F3], a
    ld a, $07
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_01F_5D2A
    ret

; 2 call sites from 2 routines (e.g. Func_037_542C, Func_0F1_5344)
; writes: wD7F5, wD7F6, wD7F1, wD7F2, wD7F3, wD7F4, wD7F7
Func_01F_753A::
    call Func_01F_77AB
    ld de, $0008
    add hl, de
    ld a, h
    ld [wD7F5], a
    ld a, l
    ld [wD7F6], a
    ld de, Data_01F_6B4F
    ld a, d
    ld [wD7F1], a
    ld a, e
    ld [wD7F2], a
    ld a, $0C
    ld [wD7F3], a
    ld a, $12
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_01F_5D2A
    call Func_01F_77AB
    ld de, $0160
    add hl, de
    ld a, h
    ld [wD7F5], a
    ld a, l
    ld [wD7F6], a
    ld de, Data_01F_6C27
    ld a, d
    ld [wD7F1], a
    ld a, e
    ld [wD7F2], a
    ld a, $08
    ld [wD7F3], a
    ld a, $07
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_01F_5D2A
    ret

; 2 call sites from 2 routines (e.g. Func_037_542C, Func_0F1_5344)
; writes: wC52D, wC52E, wC52F, wC530, wD7F5, wD7F6, wD7F1, wD7F2, ...
Func_01F_7591::
    ld hl, vTiles2 + $200
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1504
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    call Func_01F_77AB
    ld de, $0008
    add hl, de
    ld a, h
    ld [wD7F5], a
    ld a, l
    ld [wD7F6], a
    ld de, Data_01F_6C5F
    ld a, d
    ld [wD7F1], a
    ld a, e
    ld [wD7F2], a
    ld a, $0C
    ld [wD7F3], a
    ld a, $12
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_01F_5D2A
    call Func_01F_77AB
    ld de, $0160
    add hl, de
    ld a, h
    ld [wD7F5], a
    ld a, l
    ld [wD7F6], a
    ld de, Data_01F_6D37
    ld a, d
    ld [wD7F1], a
    ld a, e
    ld [wD7F2], a
    ld a, $08
    ld [wD7F3], a
    ld a, $07
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_01F_5D2A
    ret

; 2 call sites from 2 routines (e.g. Func_037_542C, Func_0F1_5344)
; reads: wCA5F
; writes: wC52D, wC52E, wC52F, wC530, wC529, wC528
; points at: wCA2B
Func_01F_7601::
    ld a, [wCA5F]
    cp a, $FF
    jr z, Jump_01F_760D
    and a, a
    jr z, Jump_01F_760D
    jr Jump_01F_764E

Jump_01F_760D::
    ld hl, vTiles2 + $200
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1504
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ld hl, vTiles2 + $200
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0901
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld a, $08
    ld [wC528], a
    ld a, $0E
    ld [wC529], a
    farcall Func_008_402B
    jr Jump_01F_769E

Jump_01F_764E::
    ld hl, vTiles2 + $200
    ld c, $34
    ld b, $08

Jump_01F_7655::
    push bc
    push hl
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0901
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld hl, wCA2B
    ld a, c
    add a, l
    ld l, a
    jr nc, Jump_01F_7673
    inc h

Jump_01F_7673::
    ld a, [hl]
    and a, a
    jr z, Jump_01F_767D
    cp a, $FF
    jr z, Jump_01F_767D
    jr Jump_01F_7682

Jump_01F_767D::
    call FillTilesFromRequest
    jr Jump_01F_7690

Jump_01F_7682::
    ld [wC529], a
    ld a, $04
    ld [wC528], a
    farcall Func_008_402B

Jump_01F_7690::
    pop hl
    ld a, l
    add a, $90
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    pop bc
    inc c
    dec b
    jr nz, Jump_01F_7655

Jump_01F_769E::
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

; 2 call sites from 2 routines (e.g. Func_037_542C, Func_0F1_5344)
; writes: wD7F5, wD7F6, wD7F1, wD7F2, wD7F3, wD7F4, wD7F7, wC52D, ...
Func_01F_76B5::
    call Func_01F_77AB
    ld de, $0160
    add hl, de
    ld a, h
    ld [wD7F5], a
    ld a, l
    ld [wD7F6], a
    ld de, Data_01F_6E47
    ld a, d
    ld [wD7F1], a
    ld a, e
    ld [wD7F2], a
    ld a, $08
    ld [wD7F3], a
    ld a, $07
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_01F_5D2A
    ld hl, vTiles2 + $6C0
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0201
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    call Func_01F_77AB
    ld de, $0008
    add hl, de
    ld a, h
    ld [wD7F5], a
    ld a, l
    ld [wD7F6], a
    ld de, Data_01F_6D6F
    ld a, d
    ld [wD7F1], a
    ld a, e
    ld [wD7F2], a
    ld a, $0C
    ld [wD7F3], a
    ld a, $12
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_01F_5D2A
    ld hl, vTiles2 + $200
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0805
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
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

; 2 call sites from 2 routines (e.g. Func_037_542C, Func_0F1_5344)
; writes: wD7F5, wD7F6, wD7F1, wD7F2, wD7F3, wD7F4, wD7F7
Func_01F_7754::
    call Func_01F_77AB
    ld de, $0008
    add hl, de
    ld a, h
    ld [wD7F5], a
    ld a, l
    ld [wD7F6], a
    ld de, Data_01F_5E13
    ld a, d
    ld [wD7F1], a
    ld a, e
    ld [wD7F2], a
    ld a, $0C
    ld [wD7F3], a
    ld a, $03
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_01F_5D2A
    call Func_01F_77AB
    ld de, $0160
    add hl, de
    ld a, h
    ld [wD7F5], a
    ld a, l
    ld [wD7F6], a
    ld de, Data_01F_66DF
    ld a, d
    ld [wD7F1], a
    ld a, e
    ld [wD7F2], a
    ld a, $08
    ld [wD7F3], a
    ld a, $07
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_01F_5D2A
    ret

; 14 call sites from 7 routines (e.g. Func_01F_7494, Func_01F_73EC, Func_01F_74E3, Func_01F_753A, ...)
; reads: hFFA5, hFFA1
Func_01F_77AB::
    ldh a, [hFFA5]
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
    ldh a, [hFFA1]
    srl a
    srl a
    srl a
    add a, e
    ld e, a
    jr nc, Jump_01F_77CF
    inc d

Jump_01F_77CF::
    ld a, e
    ld l, a
    ld a, d
    ld h, a
    ret
    INCBIN "dwm2-cobi-us.gbc", $07F7D4, $C6

Data_01F_789A:: ; heuristic: argument of a bank-switching copy helper; C0
    db $C0, $F6, $07, $7C, $78, $F6, $00, $03, $C0, $F6, $07, $93, $78, $00, $00, $00

Data_01F_78AA:: ; heuristic: argument of a bank-switching copy helper; C0
    ds $756, $00
