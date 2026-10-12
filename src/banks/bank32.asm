SECTION "Bank 32", ROMX[$4000], BANK[$32]
    db $32

; for the sequence at wCB75: runs the frame timer (Func_032_401C) when started, otherwise marks it started, clears byte 4 and loads the first frame (Func_032_403F) (E-0124)
; 8 call sites from 6 routines (e.g. GameMode4_Update, SelectEffectByEffectFlags, RunBattleEffectAnimation, DrawHexByteAtBGMap8A_Sub01, ...)
; reads: wSequencePtrLo, wSequencePtrHi
TickSequencePtrLoSequence::
Func_032_4001:: ; address name
    ld a, [wSequencePtrLo]
    ld l, a
    ld a, [wSequencePtrHi]
    ld h, a
    ld a, [hl]
    or a, a
    jr z, Jump_032_4012
    call CountDownSequencePtrLoFrameTimer
    jr Jump_032_401B

Jump_032_4012::
    inc [hl]
    inc hl
    inc hl
    inc hl
    ld [hl], $00
    call TickSequencePtrLoSequence_Sub01

Jump_032_401B::
    ret

; counts down byte 5 of the wCB75 sequence ($FF = hold); at zero advances byte 3 (E-0124)
; 1 call site from 1 routine (e.g. TickSequencePtrLoSequence)
; reads: wSequencePtrLo, wSequencePtrHi
CountDownSequencePtrLoFrameTimer::
Func_032_401C:: ; address name
    ld a, [wSequencePtrLo]
    add a, $05
    ld l, a
    ld a, [wSequencePtrHi]
    adc a, $00
    ld h, a
    ld a, [hl]
    cp a, $FF
    ret z
    or a, a
    jr z, Jump_032_4032
    dec a
    ld [hl-], a
    ret

Jump_032_4032::
    ld a, [wSequencePtrLo]
    add a, $03
    ld l, a
    ld a, [wSequencePtrHi]
    adc a, $00
    ld h, a
    inc [hl]

; only called from TickSequencePtrLoSequence (E-0047)
; 1 call site from 1 routine (e.g. TickSequencePtrLoSequence)
; reads: wSequencePtrLo, wSequencePtrHi
TickSequencePtrLoSequence_Sub01::
Func_032_403F:: ; address name
    call LookupSequencePtrLoFrameWord
    ld a, b
    and a, c
    cp a, $FF
    jr nz, Jump_032_4053
    ld a, [wSequencePtrLo]
    ld l, a
    ld a, [wSequencePtrHi]
    ld h, a
    ld [hl], $00
    ret

Jump_032_4053::
    ld a, c
    cp a, $F8
    jr c, Jump_032_4073
    cp a, $FE
    jr nz, Jump_032_406D
    ld a, [wSequencePtrLo]
    add a, $03
    ld l, a
    ld a, [wSequencePtrHi]
    adc a, $00
    ld h, a
    ld a, [hl]
    sub a, b
    ld [hl], a
    jr Jump_032_4032

Jump_032_406D::
    cp a, $FD
    jr nz, Jump_032_4073
    jr Jump_032_4032

Jump_032_4073::
    ld a, [wSequencePtrLo]
    add a, $04
    ld l, a
    ld a, [wSequencePtrHi]
    adc a, $00
    ld h, a
    ld a, c
    ld [hl+], a
    ld [hl], b
    ret

; BC = word ([seq + 3]) of the table Data_032_40A6[[seq + 2]] (E-0124)
; 1 call site from 1 routine (e.g. TickSequencePtrLoSequence_Sub01)
; reads: wSequencePtrLo, wSequencePtrHi
LookupSequencePtrLoFrameWord::
Func_032_4083:: ; address name
    ld a, [wSequencePtrLo]
    ld c, a
    ld a, [wSequencePtrHi]
    ld b, a
    inc bc
    inc bc
    ld a, [bc]
    add a, a
    ld hl, SequenceFrameTable
    add_a_to_hl
    deref_hl
    inc bc
    ld a, [bc]
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ret

; E-0240 (C1: LookupSequencePtrLoFrameWord reads the word at $40A6 + 2 * [seq + 2], then the word at 2 * [seq + 3] of that list; TickSequencePtrLoSequence_Sub01 ends the sequence at $FFFF, steps back B entries when the low byte is $FE, and otherwise stores the word at seq + 4 (frame, then the timer CountDownSequencePtrLoFrameTimer counts down); 60 lists from $411E to $4ADC, each ending with $FFFF).
; record: frame list of this sequence
SequenceFrameTable::
Data_032_40A6:: ; address name
    dw SequenceFrames000 ; id 0
    dw SequenceFrames001 ; id 1
    dw SequenceFrames002 ; id 2
    dw SequenceFrames003 ; id 3
    dw SequenceFrames004 ; id 4
    dw SequenceFrames005 ; id 5
    dw SequenceFrames006 ; id 6
    dw SequenceFrames007 ; id 7
    dw SequenceFrames008 ; id 8
    dw SequenceFrames009 ; id 9
    dw SequenceFrames00A ; id 10
    dw SequenceFrames00B ; id 11
    dw SequenceFrames00C ; id 12
    dw SequenceFrames00D ; id 13
    dw SequenceFrames00E ; id 14
    dw SequenceFrames00F ; id 15
    dw SequenceFrames010 ; id 16
    dw SequenceFrames011 ; id 17
    dw SequenceFrames012 ; id 18
    dw SequenceFrames013 ; id 19
    dw SequenceFrames014 ; id 20
    dw SequenceFrames015 ; id 21
    dw SequenceFrames016 ; id 22
    dw SequenceFrames017 ; id 23
    dw SequenceFrames018 ; id 24
    dw SequenceFrames019 ; id 25
    dw SequenceFrames01A ; id 26
    dw SequenceFrames01B ; id 27
    dw SequenceFrames01C ; id 28
    dw SequenceFrames01D ; id 29
    dw SequenceFrames01E ; id 30
    dw SequenceFrames01F ; id 31
    dw SequenceFrames020 ; id 32
    dw SequenceFrames021 ; id 33
    dw SequenceFrames022 ; id 34
    dw SequenceFrames023 ; id 35
    dw SequenceFrames024 ; id 36
    dw SequenceFrames025 ; id 37
    dw SequenceFrames026 ; id 38
    dw SequenceFrames027 ; id 39
    dw SequenceFrames028 ; id 40
    dw SequenceFrames029 ; id 41
    dw SequenceFrames02A ; id 42
    dw SequenceFrames02B ; id 43
    dw SequenceFrames02C ; id 44
    dw SequenceFrames02D ; id 45
    dw SequenceFrames02E ; id 46
    dw SequenceFrames02F ; id 47
    dw SequenceFrames030 ; id 48
    dw SequenceFrames031 ; id 49
    dw SequenceFrames032 ; id 50
    dw SequenceFrames033 ; id 51
    dw SequenceFrames034 ; id 52
    dw SequenceFrames035 ; id 53
    dw SequenceFrames036 ; id 54
    dw SequenceFrames037 ; id 55
    dw SequenceFrames038 ; id 56
    dw SequenceFrames039 ; id 57
    dw SequenceFrames03A ; id 58
    dw SequenceFrames03B ; id 59

; E-0199 (derived: list for entry $00 of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames000::
Data_032_411E:: ; address name
    db $00, $05 ; id 0
    db $01, $05 ; id 1
    db $02, $05 ; id 2
    db $03, $05 ; id 3
    db $04, $02 ; id 4
    db $05, $02 ; id 5
    db $06, $02 ; id 6
    db $07, $02 ; id 7
    db $1F, $02 ; id 8
    db $FF, $FF ; id 9

; E-0199 (derived: list for entry $01 of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames001::
Data_032_4132:: ; address name
    db $00, $04 ; id 0
    db $01, $04 ; id 1
    db $02, $04 ; id 2
    db $03, $04 ; id 3
    db $04, $02 ; id 4
    db $05, $02 ; id 5
    db $06, $02 ; id 6
    db $07, $02 ; id 7
    db $1F, $08 ; id 8
    db $08, $03 ; id 9
    db $09, $03 ; id 10
    db $0A, $03 ; id 11
    db $0B, $03 ; id 12
    db $0C, $03 ; id 13
    db $09, $03 ; id 14
    db $0A, $03 ; id 15
    db $0B, $02 ; id 16
    db $0C, $02 ; id 17
    db $0D, $02 ; id 18
    db $0E, $02 ; id 19
    db $1F, $02 ; id 20
    db $FF, $FF ; id 21

; E-0199 (derived: list for entry $02 of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames002::
Data_032_415E:: ; address name
    db $08, $02 ; id 0
    db $09, $05 ; id 1
    db $0A, $05 ; id 2
    db $0B, $05 ; id 3
    db $0C, $02 ; id 4
    db $0D, $02 ; id 5
    db $0E, $02 ; id 6
    db $0F, $02 ; id 7
    db $1F, $08 ; id 8
    db $00, $01 ; id 9
    db $01, $01 ; id 10
    db $02, $01 ; id 11
    db $03, $01 ; id 12
    db $04, $03 ; id 13
    db $05, $03 ; id 14
    db $06, $03 ; id 15
    db $07, $03 ; id 16
    db $04, $03 ; id 17
    db $05, $03 ; id 18
    db $06, $03 ; id 19
    db $07, $03 ; id 20
    db $02, $02 ; id 21
    db $00, $02 ; id 22
    db $1F, $02 ; id 23
    db $FF, $FF ; id 24

; E-0199 (derived: list for entry $03 of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames003::
Data_032_4190:: ; address name
    db $00, $03 ; id 0
    db $01, $03 ; id 1
    db $02, $03 ; id 2
    db $03, $03 ; id 3
    db $04, $03 ; id 4
    db $05, $03 ; id 5
    db $06, $03 ; id 6
    db $07, $03 ; id 7
    db $08, $03 ; id 8
    db $09, $03 ; id 9
    db $0A, $03 ; id 10
    db $0B, $03 ; id 11
    db $0C, $03 ; id 12
    db $0D, $03 ; id 13
    db $1F, $02 ; id 14
    db $FF, $FF ; id 15

; E-0199 (derived: list for entry $04 of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames004::
Data_032_41B0:: ; address name
    db $00, $03 ; id 0
    db $01, $03 ; id 1
    db $02, $03 ; id 2
    db $03, $03 ; id 3
    db $04, $03 ; id 4
    db $05, $03 ; id 5
    db $06, $03 ; id 6
    db $07, $03 ; id 7
    db $08, $03 ; id 8
    db $09, $03 ; id 9
    db $0A, $03 ; id 10
    db $0B, $03 ; id 11
    db $0C, $03 ; id 12
    db $0D, $03 ; id 13
    db $1F, $02 ; id 14
    db $FF, $FF ; id 15

; E-0199 (derived: list for entry $05 of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames005::
Data_032_41D0:: ; address name
    db $00, $04 ; id 0
    db $01, $03 ; id 1
    db $02, $02 ; id 2
    db $03, $04 ; id 3
    db $04, $05 ; id 4
    db $05, $03 ; id 5
    db $06, $04 ; id 6
    db $07, $03 ; id 7
    db $08, $04 ; id 8
    db $04, $03 ; id 9
    db $05, $04 ; id 10
    db $06, $03 ; id 11
    db $07, $04 ; id 12
    db $08, $03 ; id 13
    db $04, $04 ; id 14
    db $05, $03 ; id 15
    db $06, $04 ; id 16
    db $07, $03 ; id 17
    db $08, $04 ; id 18
    db $04, $03 ; id 19
    db $05, $04 ; id 20
    db $06, $03 ; id 21
    db $07, $04 ; id 22
    db $08, $03 ; id 23
    db $04, $03 ; id 24
    db $05, $04 ; id 25
    db $06, $03 ; id 26
    db $07, $04 ; id 27
    db $08, $03 ; id 28
    db $09, $04 ; id 29
    db $0A, $05 ; id 30
    db $1F, $02 ; id 31
    db $FF, $FF ; id 32

; E-0199 (derived: list for entry $06 of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames006::
Data_032_4212:: ; address name
    db $00, $04 ; id 0
    db $01, $02 ; id 1
    db $02, $04 ; id 2
    db $03, $04 ; id 3
    db $04, $02 ; id 4
    db $00, $02 ; id 5
    db $01, $02 ; id 6
    db $02, $02 ; id 7
    db $01, $02 ; id 8
    db $1F, $02 ; id 9
    db $FF, $FF ; id 10

; E-0199 (derived: list for entry $07 of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames007::
Data_032_4228:: ; address name
    db $00, $02 ; id 0
    db $01, $02 ; id 1
    db $02, $02 ; id 2
    db $1F, $10 ; id 3
    db $03, $04 ; id 4
    db $04, $02 ; id 5
    db $05, $04 ; id 6
    db $06, $02 ; id 7
    db $07, $04 ; id 8
    db $08, $02 ; id 9
    db $03, $03 ; id 10
    db $04, $02 ; id 11
    db $05, $03 ; id 12
    db $06, $02 ; id 13
    db $07, $04 ; id 14
    db $08, $02 ; id 15
    db $1F, $02 ; id 16
    db $FF, $FF ; id 17

; E-0199 (derived: list for entry $08 of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames008::
Data_032_424C:: ; address name
    db $00, $02 ; id 0
    db $01, $02 ; id 1
    db $02, $02 ; id 2
    db $03, $02 ; id 3
    db $1F, $10 ; id 4
    db $04, $05 ; id 5
    db $05, $05 ; id 6
    db $06, $05 ; id 7
    db $07, $02 ; id 8
    db $08, $02 ; id 9
    db $0E, $02 ; id 10
    db $09, $02 ; id 11
    db $0F, $02 ; id 12
    db $0E, $02 ; id 13
    db $10, $02 ; id 14
    db $0B, $02 ; id 15
    db $11, $02 ; id 16
    db $0C, $02 ; id 17
    db $10, $02 ; id 18
    db $0B, $02 ; id 19
    db $11, $02 ; id 20
    db $0C, $02 ; id 21
    db $12, $02 ; id 22
    db $0D, $02 ; id 23
    db $13, $02 ; id 24
    db $08, $02 ; id 25
    db $0E, $02 ; id 26
    db $09, $02 ; id 27
    db $0F, $02 ; id 28
    db $0A, $02 ; id 29
    db $10, $02 ; id 30
    db $0B, $02 ; id 31
    db $06, $02 ; id 32
    db $1F, $02 ; id 33
    db $FF, $FF ; id 34

; E-0199 (derived: list for entry $09 of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames009::
Data_032_4292:: ; address name
    db $00, $02 ; id 0
    db $01, $02 ; id 1
    db $02, $02 ; id 2
    db $03, $02 ; id 3
    db $04, $02 ; id 4
    db $05, $02 ; id 5
    db $06, $02 ; id 6
    db $07, $02 ; id 7
    db $08, $02 ; id 8
    db $09, $02 ; id 9
    db $0A, $02 ; id 10
    db $0B, $02 ; id 11
    db $0C, $02 ; id 12
    db $1F, $02 ; id 13
    db $FF, $FF ; id 14

; E-0199 (derived: list for entry $0A of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames00A::
Data_032_42B0:: ; address name
    db $00, $03 ; id 0
    db $01, $03 ; id 1
    db $02, $04 ; id 2
    db $03, $04 ; id 3
    db $04, $05 ; id 4
    db $05, $04 ; id 5
    db $06, $05 ; id 6
    db $07, $04 ; id 7
    db $08, $05 ; id 8
    db $09, $04 ; id 9
    db $0A, $05 ; id 10
    db $0B, $04 ; id 11
    db $0C, $05 ; id 12
    db $1F, $02 ; id 13
    db $FF, $FF ; id 14

; E-0199 (derived: list for entry $0B of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames00B::
Data_032_42CE:: ; address name
    db $00, $03 ; id 0
    db $01, $03 ; id 1
    db $02, $03 ; id 2
    db $03, $03 ; id 3
    db $04, $03 ; id 4
    db $05, $03 ; id 5
    db $06, $03 ; id 6
    db $07, $03 ; id 7
    db $08, $03 ; id 8
    db $09, $03 ; id 9
    db $0A, $03 ; id 10
    db $0B, $03 ; id 11
    db $0C, $03 ; id 12
    db $0D, $03 ; id 13
    db $0E, $03 ; id 14
    db $0B, $03 ; id 15
    db $0C, $03 ; id 16
    db $0D, $03 ; id 17
    db $0E, $03 ; id 18
    db $0F, $03 ; id 19
    db $10, $03 ; id 20
    db $11, $03 ; id 21
    db $12, $03 ; id 22
    db $13, $03 ; id 23
    db $14, $03 ; id 24
    db $15, $03 ; id 25
    db $16, $03 ; id 26
    db $17, $03 ; id 27
    db $18, $03 ; id 28
    db $19, $03 ; id 29
    db $1A, $03 ; id 30
    db $1F, $03 ; id 31
    db $FF, $FF ; id 32

; E-0199 (derived: list for entry $0C of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames00C::
Data_032_4310:: ; address name
    db $00, $03 ; id 0
    db $01, $03 ; id 1
    db $02, $03 ; id 2
    db $03, $03 ; id 3
    db $04, $03 ; id 4
    db $05, $03 ; id 5
    db $06, $03 ; id 6
    db $07, $03 ; id 7
    db $08, $03 ; id 8
    db $09, $03 ; id 9
    db $0A, $03 ; id 10
    db $0B, $03 ; id 11
    db $0C, $03 ; id 12
    db $0D, $03 ; id 13
    db $0E, $03 ; id 14
    db $0F, $03 ; id 15
    db $10, $03 ; id 16
    db $11, $03 ; id 17
    db $12, $03 ; id 18
    db $1F, $02 ; id 19
    db $FF, $FF ; id 20

; E-0199 (derived: list for entry $0D of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames00D::
Data_032_433A:: ; address name
    db $00, $05 ; id 0
    db $01, $04 ; id 1
    db $02, $04 ; id 2
    db $03, $03 ; id 3
    db $04, $02 ; id 4
    db $03, $02 ; id 5
    db $04, $03 ; id 6
    db $03, $03 ; id 7
    db $04, $0F ; id 8
    db $1F, $03 ; id 9
    db $04, $03 ; id 10
    db $1F, $03 ; id 11
    db $04, $02 ; id 12
    db $1F, $02 ; id 13
    db $FF, $FF ; id 14

; E-0199 (derived: list for entry $0E of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames00E::
Data_032_4358:: ; address name
    db $06, $03 ; id 0
    db $07, $03 ; id 1
    db $08, $02 ; id 2
    db $09, $02 ; id 3
    db $0A, $01 ; id 4
    db $0B, $01 ; id 5
    db $0C, $01 ; id 6
    db $1F, $08 ; id 7
    db $01, $02 ; id 8
    db $02, $02 ; id 9
    db $03, $02 ; id 10
    db $04, $02 ; id 11
    db $01, $02 ; id 12
    db $02, $02 ; id 13
    db $03, $02 ; id 14
    db $04, $02 ; id 15
    db $01, $02 ; id 16
    db $02, $02 ; id 17
    db $03, $02 ; id 18
    db $04, $02 ; id 19
    db $01, $02 ; id 20
    db $02, $02 ; id 21
    db $03, $02 ; id 22
    db $04, $02 ; id 23
    db $01, $02 ; id 24
    db $02, $02 ; id 25
    db $03, $02 ; id 26
    db $04, $02 ; id 27
    db $05, $01 ; id 28
    db $1F, $02 ; id 29
    db $FF, $FF ; id 30

; E-0199 (derived: list for entry $0F of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames00F::
Data_032_4396:: ; address name
    db $00, $04 ; id 0
    db $01, $03 ; id 1
    db $1F, $08 ; id 2
    db $02, $05 ; id 3
    db $03, $04 ; id 4
    db $04, $03 ; id 5
    db $05, $03 ; id 6
    db $06, $02 ; id 7
    db $07, $02 ; id 8
    db $04, $02 ; id 9
    db $05, $02 ; id 10
    db $06, $02 ; id 11
    db $07, $02 ; id 12
    db $02, $02 ; id 13
    db $1F, $02 ; id 14
    db $FF, $FF ; id 15

; E-0199 (derived: list for entry $10 of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames010::
Data_032_43B6:: ; address name
    db $00, $04 ; id 0
    db $01, $03 ; id 1
    db $02, $02 ; id 2
    db $1F, $08 ; id 3
    db $03, $05 ; id 4
    db $04, $04 ; id 5
    db $05, $03 ; id 6
    db $06, $03 ; id 7
    db $07, $02 ; id 8
    db $08, $02 ; id 9
    db $09, $02 ; id 10
    db $05, $02 ; id 11
    db $06, $02 ; id 12
    db $07, $02 ; id 13
    db $08, $02 ; id 14
    db $09, $02 ; id 15
    db $06, $02 ; id 16
    db $07, $02 ; id 17
    db $08, $02 ; id 18
    db $09, $02 ; id 19
    db $04, $01 ; id 20
    db $1F, $02 ; id 21
    db $FF, $FF ; id 22

; E-0199 (derived: list for entry $11 of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames011::
Data_032_43E4:: ; address name
    db $00, $03 ; id 0
    db $01, $03 ; id 1
    db $02, $02 ; id 2
    db $03, $03 ; id 3
    db $02, $01 ; id 4
    db $0F, $02 ; id 5
    db $04, $03 ; id 6
    db $05, $03 ; id 7
    db $06, $03 ; id 8
    db $07, $02 ; id 9
    db $08, $02 ; id 10
    db $09, $02 ; id 11
    db $0A, $01 ; id 12
    db $0B, $01 ; id 13
    db $0C, $01 ; id 14
    db $0D, $01 ; id 15
    db $06, $03 ; id 16
    db $07, $02 ; id 17
    db $0A, $01 ; id 18
    db $0B, $01 ; id 19
    db $0C, $01 ; id 20
    db $0D, $01 ; id 21
    db $08, $03 ; id 22
    db $09, $02 ; id 23
    db $0A, $01 ; id 24
    db $0B, $01 ; id 25
    db $0C, $01 ; id 26
    db $0D, $01 ; id 27
    db $0E, $01 ; id 28
    db $04, $02 ; id 29
    db $1F, $02 ; id 30
    db $FF, $FF ; id 31

; E-0199 (derived: list for entry $12 of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames012::
Data_032_4424:: ; address name
    db $00, $04 ; id 0
    db $01, $04 ; id 1
    db $02, $04 ; id 2
    db $03, $04 ; id 3
    db $04, $04 ; id 4
    db $05, $04 ; id 5
    db $06, $04 ; id 6
    db $07, $04 ; id 7
    db $08, $04 ; id 8
    db $09, $04 ; id 9
    db $0A, $04 ; id 10
    db $1F, $02 ; id 11
    db $FF, $FF ; id 12

; E-0199 (derived: list for entry $13 of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames013::
Data_032_443E:: ; address name
    db $00, $04 ; id 0
    db $01, $03 ; id 1
    db $02, $04 ; id 2
    db $03, $03 ; id 3
    db $04, $02 ; id 4
    db $05, $01 ; id 5
    db $06, $01 ; id 6
    db $07, $01 ; id 7
    db $1F, $01 ; id 8
    db $FF, $FF ; id 9

; E-0199 (derived: list for entry $14 of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames014::
Data_032_4452:: ; address name
    db $00, $0A ; id 0
    db $01, $08 ; id 1
    db $02, $07 ; id 2
    db $03, $06 ; id 3
    db $04, $05 ; id 4
    db $05, $05 ; id 5
    db $06, $05 ; id 6
    db $07, $05 ; id 7
    db $08, $04 ; id 8
    db $09, $04 ; id 9
    db $0A, $04 ; id 10
    db $1F, $02 ; id 11
    db $FF, $FF ; id 12

; E-0199 (derived: list for entry $15 of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames015::
Data_032_446C:: ; address name
    db $00, $08 ; id 0
    db $01, $06 ; id 1
    db $02, $08 ; id 2
    db $03, $06 ; id 3
    db $04, $08 ; id 4
    db $05, $08 ; id 5
    db $06, $08 ; id 6
    db $07, $08 ; id 7
    db $08, $04 ; id 8
    db $09, $04 ; id 9
    db $1F, $02 ; id 10
    db $FF, $FF ; id 11

; E-0199 (derived: list for entry $16 of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames016::
Data_032_4484:: ; address name
    db $00, $06 ; id 0
    db $01, $06 ; id 1
    db $02, $06 ; id 2
    db $03, $06 ; id 3
    db $04, $08 ; id 4
    db $05, $08 ; id 5
    db $06, $04 ; id 6
    db $08, $04 ; id 7
    db $08, $04 ; id 8
    db $1F, $02 ; id 9
    db $FF, $FF ; id 10

; E-0199 (derived: list for entry $17 of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames017::
Data_032_449A:: ; address name
    db $00, $06 ; id 0
    db $01, $06 ; id 1
    db $02, $06 ; id 2
    db $03, $06 ; id 3
    db $04, $06 ; id 4
    db $05, $06 ; id 5
    db $1F, $02 ; id 6
    db $FF, $FF ; id 7

; E-0199 (derived: list for entry $18 of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames018::
Data_032_44AA:: ; address name
    db $00, $0A ; id 0
    db $01, $06 ; id 1
    db $02, $06 ; id 2
    db $03, $06 ; id 3
    db $04, $06 ; id 4
    db $05, $06 ; id 5
    db $1F, $02 ; id 6
    db $FF, $FF ; id 7

; E-0199 (derived: list for entry $19 of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames019::
Data_032_44BA:: ; address name
    db $00, $04 ; id 0
    db $1F, $04 ; id 1
    db $00, $04 ; id 2
    db $1F, $04 ; id 3
    db $00, $04 ; id 4
    db $1F, $04 ; id 5
    db $00, $04 ; id 6
    db $1F, $04 ; id 7
    db $00, $04 ; id 8
    db $1F, $04 ; id 9
    db $00, $04 ; id 10
    db $1F, $0F ; id 11
    db $1F, $02 ; id 12
    db $FF, $FF ; id 13

; E-0199 (derived: list for entry $1A of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames01A::
Data_032_44D6:: ; address name
    db $00, $03 ; id 0
    db $01, $03 ; id 1
    db $02, $03 ; id 2
    db $1F, $08 ; id 3
    db $03, $02 ; id 4
    db $04, $02 ; id 5
    db $05, $02 ; id 6
    db $06, $02 ; id 7
    db $07, $02 ; id 8
    db $08, $02 ; id 9
    db $09, $02 ; id 10
    db $0A, $02 ; id 11
    db $0B, $02 ; id 12
    db $0C, $02 ; id 13
    db $0D, $02 ; id 14
    db $0E, $02 ; id 15
    db $0F, $02 ; id 16
    db $10, $02 ; id 17
    db $11, $02 ; id 18
    db $12, $02 ; id 19
    db $1F, $02 ; id 20
    db $FF, $FF ; id 21

; E-0199 (derived: list for entry $1B of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames01B::
Data_032_4502:: ; address name
    db $00, $04 ; id 0
    db $01, $04 ; id 1
    db $02, $04 ; id 2
    db $03, $04 ; id 3
    db $04, $05 ; id 4
    db $05, $04 ; id 5
    db $06, $04 ; id 6
    db $07, $04 ; id 7
    db $1F, $02 ; id 8
    db $FF, $FF ; id 9

; E-0199 (derived: list for entry $1C of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames01C::
Data_032_4516:: ; address name
    db $00, $02 ; id 0
    db $01, $02 ; id 1
    db $02, $02 ; id 2
    db $03, $02 ; id 3
    db $04, $02 ; id 4
    db $05, $02 ; id 5
    db $06, $02 ; id 6
    db $07, $02 ; id 7
    db $08, $02 ; id 8
    db $09, $02 ; id 9
    db $0A, $02 ; id 10
    db $0B, $03 ; id 11
    db $0C, $05 ; id 12
    db $0D, $04 ; id 13
    db $0E, $03 ; id 14
    db $0F, $03 ; id 15
    db $0E, $04 ; id 16
    db $0D, $04 ; id 17
    db $0E, $03 ; id 18
    db $0B, $03 ; id 19
    db $13, $04 ; id 20
    db $0B, $04 ; id 21
    db $0C, $05 ; id 22
    db $0D, $04 ; id 23
    db $0E, $03 ; id 24
    db $0F, $04 ; id 25
    db $0E, $03 ; id 26
    db $10, $04 ; id 27
    db $11, $04 ; id 28
    db $12, $04 ; id 29
    db $1F, $02 ; id 30
    db $FF, $FF ; id 31

; E-0199 (derived: list for entry $1D of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames01D::
Data_032_4556:: ; address name
    db $00, $03 ; id 0
    db $01, $04 ; id 1
    db $02, $04 ; id 2
    db $03, $03 ; id 3
    db $04, $05 ; id 4
    db $05, $03 ; id 5
    db $1F, $02 ; id 6
    db $FF, $FF ; id 7

; E-0199 (derived: list for entry $1E of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames01E::
Data_032_4566:: ; address name
    db $00, $03 ; id 0
    db $01, $04 ; id 1
    db $02, $04 ; id 2
    db $03, $03 ; id 3
    db $00, $03 ; id 4
    db $01, $04 ; id 5
    db $02, $04 ; id 6
    db $03, $03 ; id 7
    db $04, $05 ; id 8
    db $05, $03 ; id 9
    db $06, $03 ; id 10
    db $1F, $08 ; id 11
    db $07, $03 ; id 12
    db $08, $02 ; id 13
    db $09, $04 ; id 14
    db $0A, $04 ; id 15
    db $0B, $04 ; id 16
    db $0C, $04 ; id 17
    db $0D, $04 ; id 18
    db $0E, $03 ; id 19
    db $0F, $03 ; id 20
    db $10, $03 ; id 21
    db $11, $03 ; id 22
    db $12, $03 ; id 23
    db $13, $03 ; id 24
    db $1F, $02 ; id 25
    db $FF, $FF ; id 26

; E-0199 (derived: list for entry $1F of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames01F::
Data_032_459C:: ; address name
    db $00, $03 ; id 0
    db $01, $04 ; id 1
    db $02, $04 ; id 2
    db $03, $03 ; id 3
    db $04, $05 ; id 4
    db $05, $02 ; id 5
    db $06, $02 ; id 6
    db $07, $02 ; id 7
    db $08, $02 ; id 8
    db $09, $02 ; id 9
    db $0A, $03 ; id 10
    db $0B, $04 ; id 11
    db $0C, $03 ; id 12
    db $0D, $03 ; id 13
    db $0E, $03 ; id 14
    db $0F, $02 ; id 15
    db $10, $02 ; id 16
    db $0C, $02 ; id 17
    db $0D, $02 ; id 18
    db $0E, $02 ; id 19
    db $0F, $02 ; id 20
    db $10, $02 ; id 21
    db $0D, $02 ; id 22
    db $0E, $02 ; id 23
    db $0F, $02 ; id 24
    db $10, $02 ; id 25
    db $0A, $01 ; id 26
    db $1F, $02 ; id 27
    db $FF, $FF ; id 28

; E-0199 (derived: list for entry $20 of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames020::
Data_032_45D6:: ; address name
    db $00, $03 ; id 0
    db $01, $04 ; id 1
    db $02, $04 ; id 2
    db $03, $03 ; id 3
    db $04, $05 ; id 4
    db $05, $03 ; id 5
    db $06, $03 ; id 6
    db $1F, $08 ; id 7
    db $07, $02 ; id 8
    db $08, $02 ; id 9
    db $09, $02 ; id 10
    db $0A, $02 ; id 11
    db $0B, $02 ; id 12
    db $0C, $02 ; id 13
    db $0D, $02 ; id 14
    db $0E, $02 ; id 15
    db $0F, $02 ; id 16
    db $10, $02 ; id 17
    db $11, $02 ; id 18
    db $12, $02 ; id 19
    db $13, $02 ; id 20
    db $14, $02 ; id 21
    db $15, $02 ; id 22
    db $16, $02 ; id 23
    db $17, $02 ; id 24
    db $18, $02 ; id 25
    db $19, $02 ; id 26
    db $1F, $02 ; id 27
    db $FF, $FF ; id 28

; E-0199 (derived: list for entry $21 of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames021::
Data_032_4610:: ; address name
    db $00, $03 ; id 0
    db $01, $04 ; id 1
    db $02, $04 ; id 2
    db $03, $03 ; id 3
    db $04, $05 ; id 4
    db $05, $03 ; id 5
    db $06, $03 ; id 6
    db $1F, $08 ; id 7
    db $07, $05 ; id 8
    db $08, $04 ; id 9
    db $09, $03 ; id 10
    db $0A, $03 ; id 11
    db $0B, $03 ; id 12
    db $0A, $04 ; id 13
    db $0B, $08 ; id 14
    db $1F, $03 ; id 15
    db $0B, $02 ; id 16
    db $1F, $02 ; id 17
    db $0B, $01 ; id 18
    db $1F, $01 ; id 19
    db $0B, $01 ; id 20
    db $1F, $01 ; id 21
    db $0B, $01 ; id 22
    db $1F, $01 ; id 23
    db $0B, $01 ; id 24
    db $1F, $02 ; id 25
    db $FF, $FF ; id 26

; E-0199 (derived: list for entry $22 of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames022::
Data_032_4646:: ; address name
    db $00, $06 ; id 0
    db $01, $05 ; id 1
    db $02, $05 ; id 2
    db $03, $03 ; id 3
    db $04, $04 ; id 4
    db $05, $03 ; id 5
    db $1F, $02 ; id 6
    db $FF, $FF ; id 7

; E-0199 (derived: list for entry $23 of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames023::
Data_032_4656:: ; address name
    db $00, $03 ; id 0
    db $01, $04 ; id 1
    db $02, $04 ; id 2
    db $03, $03 ; id 3
    db $04, $05 ; id 4
    db $05, $03 ; id 5
    db $06, $02 ; id 6
    db $1F, $02 ; id 7
    db $FF, $FF ; id 8

; E-0199 (derived: list for entry $24 of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames024::
Data_032_4668:: ; address name
    db $00, $06 ; id 0
    db $01, $05 ; id 1
    db $02, $05 ; id 2
    db $03, $05 ; id 3
    db $04, $03 ; id 4
    db $05, $03 ; id 5
    db $06, $08 ; id 6
    db $07, $03 ; id 7
    db $06, $03 ; id 8
    db $07, $03 ; id 9
    db $06, $03 ; id 10
    db $07, $02 ; id 11
    db $06, $02 ; id 12
    db $07, $02 ; id 13
    db $06, $02 ; id 14
    db $07, $01 ; id 15
    db $06, $01 ; id 16
    db $07, $01 ; id 17
    db $06, $01 ; id 18
    db $07, $01 ; id 19
    db $06, $01 ; id 20
    db $1F, $02 ; id 21
    db $FF, $FF ; id 22

; E-0199 (derived: list for entry $25 of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames025::
Data_032_4696:: ; address name
    db $00, $05 ; id 0
    db $01, $04 ; id 1
    db $02, $04 ; id 2
    db $03, $04 ; id 3
    db $04, $03 ; id 4
    db $05, $03 ; id 5
    db $06, $03 ; id 6
    db $05, $02 ; id 7
    db $07, $02 ; id 8
    db $08, $02 ; id 9
    db $07, $02 ; id 10
    db $1F, $02 ; id 11
    db $08, $02 ; id 12
    db $1F, $02 ; id 13
    db $07, $01 ; id 14
    db $1F, $01 ; id 15
    db $08, $01 ; id 16
    db $1F, $01 ; id 17
    db $07, $01 ; id 18
    db $1F, $01 ; id 19
    db $08, $01 ; id 20
    db $1F, $01 ; id 21
    db $1F, $02 ; id 22
    db $FF, $FF ; id 23

; E-0199 (derived: list for entry $26 of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames026::
Data_032_46C6:: ; address name
    db $00, $04 ; id 0
    db $01, $05 ; id 1
    db $02, $05 ; id 2
    db $03, $04 ; id 3
    db $04, $04 ; id 4
    db $05, $06 ; id 5
    db $06, $04 ; id 6
    db $07, $04 ; id 7
    db $08, $03 ; id 8
    db $07, $02 ; id 9
    db $08, $02 ; id 10
    db $06, $02 ; id 11
    db $08, $03 ; id 12
    db $09, $03 ; id 13
    db $08, $02 ; id 14
    db $09, $02 ; id 15
    db $08, $02 ; id 16
    db $09, $02 ; id 17
    db $0A, $02 ; id 18
    db $0B, $02 ; id 19
    db $0A, $01 ; id 20
    db $0B, $01 ; id 21
    db $0A, $01 ; id 22
    db $1F, $01 ; id 23
    db $0B, $01 ; id 24
    db $1F, $01 ; id 25
    db $0A, $01 ; id 26
    db $1F, $01 ; id 27
    db $0B, $01 ; id 28
    db $1F, $02 ; id 29
    db $FF, $FF ; id 30

; E-0199 (derived: list for entry $27 of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames027::
Data_032_4704:: ; address name
    db $00, $01 ; id 0
    db $01, $01 ; id 1
    db $02, $01 ; id 2
    db $03, $02 ; id 3
    db $04, $03 ; id 4
    db $05, $03 ; id 5
    db $06, $03 ; id 6
    db $07, $03 ; id 7
    db $08, $03 ; id 8
    db $09, $03 ; id 9
    db $0A, $03 ; id 10
    db $0B, $02 ; id 11
    db $0C, $02 ; id 12
    db $0D, $02 ; id 13
    db $0B, $02 ; id 14
    db $0C, $02 ; id 15
    db $0D, $02 ; id 16
    db $0B, $02 ; id 17
    db $0C, $02 ; id 18
    db $0D, $02 ; id 19
    db $0B, $02 ; id 20
    db $0C, $02 ; id 21
    db $0D, $02 ; id 22
    db $0B, $02 ; id 23
    db $0C, $02 ; id 24
    db $0D, $02 ; id 25
    db $0B, $02 ; id 26
    db $0C, $02 ; id 27
    db $0D, $02 ; id 28
    db $1F, $02 ; id 29
    db $FF, $FF ; id 30

; E-0199 (derived: list for entry $28 of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames028::
Data_032_4742:: ; address name
    db $00, $03 ; id 0
    db $1F, $01 ; id 1
    db $01, $03 ; id 2
    db $1F, $01 ; id 3
    db $02, $03 ; id 4
    db $1F, $01 ; id 5
    db $03, $03 ; id 6
    db $1F, $01 ; id 7
    db $04, $03 ; id 8
    db $05, $03 ; id 9
    db $04, $03 ; id 10
    db $05, $03 ; id 11
    db $04, $03 ; id 12
    db $05, $03 ; id 13
    db $04, $03 ; id 14
    db $05, $03 ; id 15
    db $1F, $02 ; id 16
    db $FF, $FF ; id 17

; E-0199 (derived: list for entry $29 of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames029::
Data_032_4766:: ; address name
    db $00, $04 ; id 0
    db $01, $04 ; id 1
    db $00, $03 ; id 2
    db $01, $03 ; id 3
    db $02, $04 ; id 4
    db $01, $04 ; id 5
    db $02, $03 ; id 6
    db $01, $03 ; id 7
    db $03, $04 ; id 8
    db $02, $04 ; id 9
    db $03, $03 ; id 10
    db $02, $03 ; id 11
    db $04, $04 ; id 12
    db $03, $04 ; id 13
    db $04, $03 ; id 14
    db $03, $03 ; id 15
    db $05, $04 ; id 16
    db $04, $03 ; id 17
    db $06, $03 ; id 18
    db $05, $04 ; id 19
    db $07, $04 ; id 20
    db $10, $04 ; id 21
    db $0B, $04 ; id 22
    db $11, $04 ; id 23
    db $0C, $04 ; id 24
    db $12, $04 ; id 25
    db $0D, $04 ; id 26
    db $13, $04 ; id 27
    db $07, $03 ; id 28
    db $1F, $02 ; id 29
    db $FF, $FF ; id 30

; E-0199 (derived: list for entry $2A of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames02A::
Data_032_47A4:: ; address name
    db $00, $04 ; id 0
    db $01, $05 ; id 1
    db $02, $04 ; id 2
    db $03, $03 ; id 3
    db $04, $03 ; id 4
    db $05, $03 ; id 5
    db $06, $03 ; id 6
    db $07, $03 ; id 7
    db $08, $03 ; id 8
    db $1F, $08 ; id 9
    db $09, $02 ; id 10
    db $0A, $02 ; id 11
    db $0B, $02 ; id 12
    db $0C, $02 ; id 13
    db $0D, $02 ; id 14
    db $0E, $02 ; id 15
    db $0F, $02 ; id 16
    db $10, $02 ; id 17
    db $11, $02 ; id 18
    db $12, $02 ; id 19
    db $13, $02 ; id 20
    db $14, $02 ; id 21
    db $0B, $02 ; id 22
    db $0C, $02 ; id 23
    db $0D, $02 ; id 24
    db $0E, $02 ; id 25
    db $0F, $02 ; id 26
    db $15, $02 ; id 27
    db $16, $02 ; id 28
    db $17, $02 ; id 29
    db $1F, $02 ; id 30
    db $FF, $FF ; id 31

; E-0199 (derived: list for entry $2B of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames02B::
Data_032_47E4:: ; address name
    db $00, $04 ; id 0
    db $01, $04 ; id 1
    db $02, $04 ; id 2
    db $03, $02 ; id 3
    db $04, $02 ; id 4
    db $05, $02 ; id 5
    db $06, $02 ; id 6
    db $07, $02 ; id 7
    db $08, $02 ; id 8
    db $05, $02 ; id 9
    db $06, $02 ; id 10
    db $07, $02 ; id 11
    db $08, $02 ; id 12
    db $1F, $02 ; id 13
    db $FF, $FF ; id 14

; E-0199 (derived: list for entry $2C of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames02C::
Data_032_4802:: ; address name
    db $00, $04 ; id 0
    db $01, $03 ; id 1
    db $02, $06 ; id 2
    db $03, $06 ; id 3
    db $04, $06 ; id 4
    db $05, $06 ; id 5
    db $06, $06 ; id 6
    db $07, $06 ; id 7
    db $08, $06 ; id 8
    db $09, $06 ; id 9
    db $1F, $02 ; id 10
    db $FF, $FF ; id 11

; E-0199 (derived: list for entry $2D of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames02D::
Data_032_481A:: ; address name
    db $00, $03 ; id 0
    db $01, $04 ; id 1
    db $02, $04 ; id 2
    db $03, $03 ; id 3
    db $04, $03 ; id 4
    db $05, $04 ; id 5
    db $06, $04 ; id 6
    db $07, $03 ; id 7
    db $08, $03 ; id 8
    db $07, $03 ; id 9
    db $09, $04 ; id 10
    db $0A, $03 ; id 11
    db $0B, $03 ; id 12
    db $FF, $FF ; id 13

; E-0199 (derived: list for entry $2E of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames02E::
Data_032_4836:: ; address name
    db $00, $03 ; id 0
    db $01, $04 ; id 1
    db $02, $05 ; id 2
    db $03, $05 ; id 3
    db $04, $05 ; id 4
    db $05, $04 ; id 5
    db $06, $03 ; id 6
    db $12, $03 ; id 7
    db $07, $02 ; id 8
    db $13, $02 ; id 9
    db $08, $02 ; id 10
    db $14, $02 ; id 11
    db $09, $02 ; id 12
    db $15, $02 ; id 13
    db $0A, $02 ; id 14
    db $16, $02 ; id 15
    db $0B, $02 ; id 16
    db $17, $02 ; id 17
    db $0C, $02 ; id 18
    db $18, $02 ; id 19
    db $0D, $02 ; id 20
    db $19, $02 ; id 21
    db $0E, $02 ; id 22
    db $1A, $02 ; id 23
    db $0F, $02 ; id 24
    db $1B, $02 ; id 25
    db $10, $02 ; id 26
    db $11, $02 ; id 27
    db $FF, $FF ; id 28

; E-0199 (derived: list for entry $2F of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames02F::
Data_032_4870:: ; address name
    db $00, $04 ; id 0
    db $01, $05 ; id 1
    db $02, $05 ; id 2
    db $03, $04 ; id 3
    db $04, $06 ; id 4
    db $05, $04 ; id 5
    db $06, $04 ; id 6
    db $1F, $0A ; id 7
    db $07, $03 ; id 8
    db $08, $02 ; id 9
    db $09, $05 ; id 10
    db $0A, $05 ; id 11
    db $0B, $05 ; id 12
    db $0C, $06 ; id 13
    db $0D, $06 ; id 14
    db $0E, $05 ; id 15
    db $0F, $04 ; id 16
    db $0C, $04 ; id 17
    db $0D, $04 ; id 18
    db $0E, $04 ; id 19
    db $0F, $03 ; id 20
    db $0C, $03 ; id 21
    db $0D, $03 ; id 22
    db $0E, $03 ; id 23
    db $10, $02 ; id 24
    db $0F, $02 ; id 25
    db $11, $02 ; id 26
    db $10, $02 ; id 27
    db $11, $02 ; id 28
    db $FF, $FF ; id 29

; E-0199 (derived: list for entry $30 of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames030::
Data_032_48AC:: ; address name
    db $00, $03 ; id 0
    db $01, $02 ; id 1
    db $02, $02 ; id 2
    db $03, $05 ; id 3
    db $04, $05 ; id 4
    db $05, $06 ; id 5
    db $06, $06 ; id 6
    db $07, $05 ; id 7
    db $08, $05 ; id 8
    db $09, $05 ; id 9
    db $07, $04 ; id 10
    db $08, $04 ; id 11
    db $09, $04 ; id 12
    db $07, $04 ; id 13
    db $08, $04 ; id 14
    db $09, $04 ; id 15
    db $0A, $03 ; id 16
    db $1F, $02 ; id 17
    db $FF, $FF ; id 18

; E-0199 (derived: list for entry $31 of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames031::
Data_032_48D2:: ; address name
    db $00, $04 ; id 0
    db $01, $01 ; id 1
    db $02, $04 ; id 2
    db $03, $01 ; id 3
    db $04, $04 ; id 4
    db $05, $01 ; id 5
    db $06, $04 ; id 6
    db $07, $01 ; id 7
    db $08, $04 ; id 8
    db $09, $01 ; id 9
    db $0A, $04 ; id 10
    db $0B, $01 ; id 11
    db $0C, $04 ; id 12
    db $0D, $01 ; id 13
    db $0E, $04 ; id 14
    db $0F, $03 ; id 15
    db $0E, $04 ; id 16
    db $0F, $03 ; id 17
    db $1F, $02 ; id 18
    db $FF, $FF ; id 19

; E-0199 (derived: list for entry $32 of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames032::
Data_032_48FA:: ; address name
    db $00, $05 ; id 0
    db $01, $05 ; id 1
    db $02, $05 ; id 2
    db $03, $05 ; id 3
    db $04, $05 ; id 4
    db $05, $05 ; id 5
    db $06, $05 ; id 6
    db $07, $05 ; id 7
    db $1F, $02 ; id 8
    db $FF, $FF ; id 9

; E-0199 (derived: list for entry $33 of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames033::
Data_032_490E:: ; address name
    db $00, $03 ; id 0
    db $01, $03 ; id 1
    db $02, $03 ; id 2
    db $03, $03 ; id 3
    db $04, $03 ; id 4
    db $05, $03 ; id 5
    db $06, $03 ; id 6
    db $07, $03 ; id 7
    db $08, $03 ; id 8
    db $09, $03 ; id 9
    db $0A, $03 ; id 10
    db $0B, $03 ; id 11
    db $0B, $03 ; id 12
    db $0C, $03 ; id 13
    db $0D, $03 ; id 14
    db $0E, $03 ; id 15
    db $0F, $03 ; id 16
    db $13, $03 ; id 17
    db $10, $03 ; id 18
    db $14, $03 ; id 19
    db $11, $03 ; id 20
    db $15, $03 ; id 21
    db $12, $03 ; id 22
    db $0F, $03 ; id 23
    db $13, $02 ; id 24
    db $10, $02 ; id 25
    db $14, $02 ; id 26
    db $11, $02 ; id 27
    db $15, $02 ; id 28
    db $12, $02 ; id 29
    db $13, $02 ; id 30
    db $0F, $02 ; id 31
    db $0E, $03 ; id 32
    db $FF, $FF ; id 33

; E-0199 (derived: list for entry $34 of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames034::
Data_032_4952:: ; address name
    db $00, $04 ; id 0
    db $01, $04 ; id 1
    db $02, $04 ; id 2
    db $03, $04 ; id 3
    db $04, $04 ; id 4
    db $05, $04 ; id 5
    db $06, $04 ; id 6
    db $07, $04 ; id 7
    db $08, $04 ; id 8
    db $09, $04 ; id 9
    db $0A, $04 ; id 10
    db $0B, $04 ; id 11
    db $0C, $03 ; id 12
    db $0D, $03 ; id 13
    db $0C, $03 ; id 14
    db $0E, $04 ; id 15
    db $0F, $03 ; id 16
    db $10, $02 ; id 17
    db $11, $04 ; id 18
    db $12, $04 ; id 19
    db $13, $04 ; id 20
    db $14, $1D ; id 21
    db $1F, $03 ; id 22
    db $14, $03 ; id 23
    db $1F, $03 ; id 24
    db $14, $03 ; id 25
    db $1F, $02 ; id 26
    db $14, $02 ; id 27
    db $1F, $01 ; id 28
    db $14, $01 ; id 29
    db $1F, $01 ; id 30
    db $14, $01 ; id 31
    db $FF, $FF ; id 32

; E-0199 (derived: list for entry $35 of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames035::
Data_032_4994:: ; address name
    db $00, $03 ; id 0
    db $01, $04 ; id 1
    db $02, $05 ; id 2
    db $03, $04 ; id 3
    db $04, $03 ; id 4
    db $05, $04 ; id 5
    db $06, $05 ; id 6
    db $07, $04 ; id 7
    db $08, $03 ; id 8
    db $09, $03 ; id 9
    db $0A, $04 ; id 10
    db $0B, $05 ; id 11
    db $0C, $06 ; id 12
    db $0D, $03 ; id 13
    db $0E, $04 ; id 14
    db $0F, $04 ; id 15
    db $10, $04 ; id 16
    db $11, $04 ; id 17
    db $12, $04 ; id 18
    db $13, $04 ; id 19
    db $14, $04 ; id 20
    db $15, $04 ; id 21
    db $16, $04 ; id 22
    db $17, $03 ; id 23
    db $FF, $FF ; id 24

; E-0199 (derived: list for entry $36 of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames036::
Data_032_49C6:: ; address name
    db $00, $03 ; id 0
    db $01, $03 ; id 1
    db $02, $03 ; id 2
    db $03, $03 ; id 3
    db $04, $02 ; id 4
    db $05, $03 ; id 5
    db $06, $04 ; id 6
    db $1F, $08 ; id 7
    db $07, $04 ; id 8
    db $08, $04 ; id 9
    db $09, $04 ; id 10
    db $0A, $04 ; id 11
    db $0B, $04 ; id 12
    db $0C, $04 ; id 13
    db $0D, $04 ; id 14
    db $0E, $04 ; id 15
    db $0F, $04 ; id 16
    db $10, $04 ; id 17
    db $11, $04 ; id 18
    db $12, $03 ; id 19
    db $13, $03 ; id 20
    db $12, $03 ; id 21
    db $13, $03 ; id 22
    db $12, $03 ; id 23
    db $13, $03 ; id 24
    db $11, $02 ; id 25
    db $0F, $02 ; id 26
    db $0E, $02 ; id 27
    db $0C, $02 ; id 28
    db $0B, $02 ; id 29
    db $0A, $02 ; id 30
    db $FF, $FF ; id 31

; E-0199 (derived: list for entry $37 of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames037::
Data_032_4A06:: ; address name
    db $00, $06 ; id 0
    db $01, $05 ; id 1
    db $02, $05 ; id 2
    db $03, $04 ; id 3
    db $04, $02 ; id 4
    db $05, $03 ; id 5
    db $04, $03 ; id 6
    db $06, $04 ; id 7
    db $07, $06 ; id 8
    db $08, $05 ; id 9
    db $09, $04 ; id 10
    db $0A, $04 ; id 11
    db $0B, $04 ; id 12
    db $0C, $04 ; id 13
    db $0D, $04 ; id 14
    db $0E, $04 ; id 15
    db $0F, $04 ; id 16
    db $FF, $FF ; id 17

; E-0199 (derived: list for entry $38 of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames038::
Data_032_4A2A:: ; address name
    db $00, $04 ; id 0
    db $01, $04 ; id 1
    db $02, $03 ; id 2
    db $03, $04 ; id 3
    db $04, $04 ; id 4
    db $05, $03 ; id 5
    db $06, $03 ; id 6
    db $07, $02 ; id 7
    db $08, $02 ; id 8
    db $07, $03 ; id 9
    db $08, $03 ; id 10
    db $09, $03 ; id 11
    db $0A, $03 ; id 12
    db $0B, $03 ; id 13
    db $0C, $03 ; id 14
    db $0D, $03 ; id 15
    db $10, $03 ; id 16
    db $11, $03 ; id 17
    db $0E, $03 ; id 18
    db $0F, $03 ; id 19
    db $10, $03 ; id 20
    db $11, $03 ; id 21
    db $0C, $02 ; id 22
    db $0D, $02 ; id 23
    db $12, $01 ; id 24
    db $1F, $01 ; id 25
    db $13, $01 ; id 26
    db $1F, $01 ; id 27
    db $14, $01 ; id 28
    db $1F, $01 ; id 29
    db $15, $01 ; id 30
    db $FF, $FF ; id 31

; E-0199 (derived: list for entry $39 of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames039::
Data_032_4A6A:: ; address name
    db $00, $05 ; id 0
    db $01, $06 ; id 1
    db $02, $05 ; id 2
    db $03, $04 ; id 3
    db $04, $04 ; id 4
    db $05, $04 ; id 5
    db $06, $04 ; id 6
    db $07, $04 ; id 7
    db $08, $04 ; id 8
    db $1F, $0A ; id 9
    db $09, $03 ; id 10
    db $0A, $03 ; id 11
    db $0B, $03 ; id 12
    db $0C, $03 ; id 13
    db $0D, $03 ; id 14
    db $0E, $03 ; id 15
    db $FF, $FF ; id 16

; E-0199 (derived: list for entry $3A of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames03A::
Data_032_4A8C:: ; address name
    db $00, $03 ; id 0
    db $01, $03 ; id 1
    db $02, $03 ; id 2
    db $03, $03 ; id 3
    db $10, $03 ; id 4
    db $04, $03 ; id 5
    db $11, $03 ; id 6
    db $05, $03 ; id 7
    db $12, $03 ; id 8
    db $06, $03 ; id 9
    db $13, $03 ; id 10
    db $07, $03 ; id 11
    db $14, $03 ; id 12
    db $08, $03 ; id 13
    db $15, $03 ; id 14
    db $09, $03 ; id 15
    db $16, $03 ; id 16
    db $0A, $03 ; id 17
    db $17, $03 ; id 18
    db $0B, $03 ; id 19
    db $18, $03 ; id 20
    db $0C, $03 ; id 21
    db $19, $03 ; id 22
    db $0D, $03 ; id 23
    db $1A, $03 ; id 24
    db $0E, $03 ; id 25
    db $0F, $03 ; id 26
    db $FF, $FF ; id 27

; E-0199 (derived: list for entry $3B of SequenceFrameTable; it runs to the next list)
; record: frame, timer
SequenceFrames03B::
Data_032_4AC4:: ; address name
    db $00, $02 ; id 0
    db $01, $02 ; id 1
    db $02, $02 ; id 2
    db $03, $02 ; id 3
    db $04, $02 ; id 4
    db $05, $02 ; id 5
    db $06, $02 ; id 6
    db $07, $02 ; id 7
    db $08, $02 ; id 8
    db $09, $02 ; id 9
    db $0A, $02 ; id 10
    db $FF, $FF ; id 11

; only called from RunBattleActions_Case00 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleActions_Case00)
; reads: wBattleResolveStep
RunBattleActions_Case00_Sub01::
Func_032_4ADC:: ; address name
    ld a, [wBattleResolveStep]
    rst $00
    dw Func_032_4ADC_Case00
    dw Func_032_4ADC_Case01
    dw Func_032_4ADC_Case02
    dw Func_032_4ADC_Case03
    dw Func_032_4ADC_Case04
    dw Func_032_4ADC_Case05
    dw Func_032_4ADC_Case06
    dw CheckLinkRuleViolation
    dw Func_032_4ADC_Case08
    dw Func_032_4ADC_Case09

; entry 0 of the `rst $00` table in Func_032_4ADC
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleSubStep
Func_032_4ADC_Case00::
Jump_032_4AF4:: ; address name
    ld a, [wBattleSubStep]
    rst $00
    dw Func_032_4ADC_Case00_Case00
    dw Func_032_4ADC_Case00_Case01
    dw Func_032_4ADC_Case00_Case02
    dw Func_032_4ADC_Case00_Case03
    dw Func_032_4ADC_Case00_Case04
    dw Func_032_4ADC_Case00_Case05

; entry 0 of the `rst $00` table in Func_032_4ADC_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wFollowUpAction, wActionQueuePos, wBattleActor, wBattleSubStep
; writes: wBattleSubStep, wBattleSubPhase, wBattleResolveStep, wBattleActor
; points at: wActionQueue, wSlotMarks, wBattleSubStep, wBattleStatus5, wActionQueuePos, wBattleTargetChoice, wBattleStatus, wBattleResolveStep
Func_032_4ADC_Case00_Case00::
Jump_032_4B04:: ; address name
    call ResetEffectStateForAction
    ld a, [wFollowUpAction]
    or a, a
    jr z, Jump_032_4B14
    ld a, $04
    ld [wBattleSubStep], a
    jr Jump_032_4B61

Jump_032_4B14::
    ld a, [wActionQueuePos]
    cp a, $09
    jr z, Jump_032_4B38
    ld hl, wActionQueue
    call ReadByteAtHLPlusA
    cp a, $FF
    jr z, Jump_032_4B38
    cp a, $10
    jr nz, Jump_032_4B3F
    ld a, $08
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleSubStep], a
    jr Jump_032_4B61

Jump_032_4B38::
    ld a, $05
    ld [wBattleSubStep], a
    jr Jump_032_4B61

Jump_032_4B3F::
    ld [wBattleActor], a
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, Jump_032_4B5D
    ld a, [wBattleActor]
    ld hl, wSlotMarks
    add_a_to_hl
    ld a, [hl]
    cp a, $03
    jr z, Jump_032_4B5D
    ld hl, wBattleSubStep
    inc [hl]
    jr Func_032_4ADC_Case00_Case01

Jump_032_4B5D::
    ld hl, wActionQueuePos
    inc [hl]

Jump_032_4B61::
    ret

; entry 1 of the `rst $00` table in Func_032_4ADC_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wBattleSubStep
; writes: wBattleSubStep, wBattleResolveStep
; points at: wBattleStatus5, wActionQueuePos, wBattleTargetChoice, wBattleSubStep, wBattleStatus, wBattleResolveStep
Func_032_4ADC_Case00_Case01::
Jump_032_4B62:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus5
    call AddAx9ToHL
    ld a, [hl-]
    and a, $C0
    jr z, Jump_032_4B7A
    ld d, $15
    farcall ShowBattleTextCategory0
    jr Jump_032_4BD8

Jump_032_4B7A::
    dec hl
    ld a, [hl+]
    and a, $C0
    jr z, Jump_032_4B98
    ld a, [wBattleActor]
    push af
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    pop af
    ld [hl-], a
    ld [hl], $CD
    ld a, $03
    ld [wBattleSubStep], a
    jr Jump_032_4BE0

Jump_032_4B98::
    ld a, [hl-]
    and a, $0C
    jr z, Jump_032_4BC6
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    and a, $C0
    jr z, Jump_032_4BC6
    ld a, $CA
    bit 6, [hl]
    jr nz, Jump_032_4BAD
    ld a, $CB

Jump_032_4BAD::
    push af
    ld a, [wBattleActor]
    push af
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    pop af
    ld [hl-], a
    pop af
    ld [hl], a
    ld a, $04
    ld [wBattleSubStep], a
    jr Jump_032_4BE0

Jump_032_4BC6::
    call ShowActorStatusRecoveryMessage
    jr nc, Jump_032_4BD1
    ld hl, wBattleSubStep
    inc [hl]
    jr Func_032_4ADC_Case00_Case02

Jump_032_4BD1::
    ld a, [wBattleSubStep]
    cp a, $04
    jr z, Jump_032_4BE0

Jump_032_4BD8::
    xor a, a
    ld [wBattleSubStep], a
    ld hl, wActionQueuePos
    inc [hl]

Jump_032_4BE0::
    ret

; entry 2 of the `rst $00` table in Func_032_4ADC_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; writes: wBattleResolveStep, wBattleSubStep
; points at: wBattleSubStep, wBattleStatus, wBattleResolveStep
Func_032_4ADC_Case00_Case02::
Jump_032_4BE1:: ; address name
    ld hl, wBattleSubStep
    inc [hl]
    ld a, [wBattleActor]
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit 5, [hl]
    jr z, Func_032_4ADC_Case00_Case03
    call RollStatusTickEffect
    jr nc, Func_032_4ADC_Case00_Case03
    ld a, [wBattleActor]
    call GetBattleHP_Bank32
    ld a, h
    or a, l
    ret nz
    ld a, $09
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleSubStep], a
    ret

; entry 3 of the `rst $00` table in Func_032_4ADC_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; writes: wBattleSubStep
; points at: wBattleSubStep, wBattleStatus, wBattleResolveStep
Func_032_4ADC_Case00_Case03::
Jump_032_4C0A:: ; address name
    ld hl, wBattleSubStep
    inc [hl]
    ld a, [wBattleActor]
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit 4, [hl]
    jr z, Func_032_4ADC_Case00_Case04
    call PickRandomActionWhenUncontrolled
    ld d, $14
    farcall ShowBattleTextCategory0
    ret

; entry 4 of the `rst $00` table in Func_032_4ADC_Case00
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleSubStep
; points at: wBattleResolveStep
Func_032_4ADC_Case00_Case04::
Jump_032_4C27:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    xor a, a
    ld [wBattleSubStep], a
    ret

; entry 5 of the `rst $00` table in Func_032_4ADC_Case00
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleSubPhase, wBattleResolveStep, wBattleSubStep
Func_032_4ADC_Case00_Case05::
Jump_032_4C30:: ; address name
    ld a, $09
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleSubStep], a
    ret

; shows battle text $16-$1C for the first set status bit of the actor (status 6/7, byte 3 bits 0-5) and clears status 3 bits 0-5; carry when none (E-0127)
; 1 call site from 1 routine (e.g. Func_032_4ADC_Case00_Case01)
; reads: wBattleActor
; points at: wBattleStatus
ShowActorStatusRecoveryMessage::
Func_032_4C3E:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit 6, [hl]
    jr z, Jump_032_4C4F
    ld d, $17
    jr Jump_032_4C91

Jump_032_4C4F::
    bit 7, [hl]
    jr z, Jump_032_4C5A
    call ShowActorStatusRecoveryMessage_Sub01
    jr c, Jump_032_4C91
    jr Jump_032_4C97

Jump_032_4C5A::
    ld bc, $0003
    add hl, bc
    bit 2, [hl]
    jr z, Jump_032_4C66
    ld d, $1A
    jr Jump_032_4C91

Jump_032_4C66::
    bit 0, [hl]
    jr z, Jump_032_4C6E
    ld d, $16
    jr Jump_032_4C91

Jump_032_4C6E::
    bit 1, [hl]
    jr z, Jump_032_4C76
    ld d, $18
    jr Jump_032_4C91

Jump_032_4C76::
    bit 3, [hl]
    jr z, Jump_032_4C7E
    ld d, $19
    jr Jump_032_4C91

Jump_032_4C7E::
    bit 4, [hl]
    jr z, Jump_032_4C86
    ld d, $1B
    jr Jump_032_4C91

Jump_032_4C86::
    bit 5, [hl]
    jr z, Jump_032_4C8E
    ld d, $1C
    jr Jump_032_4C91

Jump_032_4C8E::
    scf
    jr Jump_032_4C9B

Jump_032_4C91::
    farcall ShowBattleTextCategory0

Jump_032_4C97::
    call ClearActorStatus3Bits0To5
    xor a, a

Jump_032_4C9B::
    ret

; a random roll: 3/4 of the time nothing; otherwise clears status 3 (text $0F), loses a sixth of max HP (text $10) or of max MP, or does something else (E-0128)
; 1 call site from 1 routine (e.g. Func_032_4ADC_Case00_Case02)
; reads: wRandomLo, wRandomHi, wBattleActor, wBattleDamageLo, wBattleDamageHi
; writes: wBattleSubStep
; points at: wBattleStatus, wActionQueuePos
RollStatusTickEffect::
Func_032_4C9C:: ; address name
    call AdvanceRandom
    ld a, [wRandomLo]
    cp a, $40
    jr nc, Jump_032_4CB7
    ld a, [wRandomHi]
    cp a, $40
    jr c, Jump_032_4CB9
    cp a, $80
    jr c, Jump_032_4CCB
    cp a, $C0
    jr c, Jump_032_4CF7
    jr Jump_032_4D0B

Jump_032_4CB7::
    xor a, a
    ret

Jump_032_4CB9::
    ld hl, wActionQueuePos
    inc [hl]
    call ClearActorStatus3
    ld d, $0F
    call ShowBattleTextCategory0Entry
    xor a, a
    ld [wBattleSubStep], a
    jr Jump_032_4D2A

Jump_032_4CCB::
    call ActorLosesSixthOfMaxHP
    jr nc, Jump_032_4CD4
    xor a, a
    ld [de], a
    dec de
    ld [de], a

Jump_032_4CD4::
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    ld a, h
    or a, l
    jr z, Jump_032_4CB7
    ld a, [wBattleActor]
    call SetBit0OfLevelUpGainsIndexed_Bank32
    ld d, $10
    call ShowBattleTextCategory0Entry
    ld a, [wBattleActor]
    call GetBattleHP_Bank32
    ld a, h
    or a, l
    jr nz, Jump_032_4D2A
    jr Jump_032_4D2A

Jump_032_4CF7::
    call ActorLosesSixthOfMaxMP
    ld a, b
    or a, c
    jr z, Jump_032_4CB7
    ld a, [wBattleActor]
    call SetBit1OfLevelUpGainsIndexed_Bank32
    ld d, $11
    call ShowBattleTextCategory0Entry
    jr Jump_032_4D2A

Jump_032_4D0B::
    ld a, [wBattleActor]
    ld hl, wBattleStatus
    call AddAx9ToHL
    set 4, [hl]
    ld a, [wBattleActor]
    call SetBit2OfLevelUpGainsIndexed_Bank32
    ld d, $12
    call ShowBattleTextCategory0Entry
    jr Jump_032_4D2A

; far-calls ShowBattleTextCategory0 and returns; the next entry returns carry (E-0126)
; 4 call sites from 1 routine (e.g. RollStatusTickEffect)
ShowBattleTextCategory0Entry::
Func_032_4D23:: ; address name
    farcall ShowBattleTextCategory0
    ret

Jump_032_4D2A::
    scf
    ret

; damage = the actor's max HP / 6 (wBattleDamageLo/Hi) is subtracted from the actor's HP without a floor: HP 10 with max HP 120 becomes $FFF6 (executed, test SixthOfMaxHPWithoutFloor); whether callers keep HP above the damage is not read (E-0121, E-0154)
; 1 call site from 1 routine (e.g. RollStatusTickEffect)
; reads: wBattleActor
; writes: wBattleDamageLo, wBattleDamageHi
; points at: wBattleHP
ActorLosesSixthOfMaxHP::
Func_032_4D2C:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleHP
    add a, a
    add_a_to_hl
    push hl
    ld a, l
    add a, $10
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    deref_hl
    ld a, $06
    call DivideHLByA
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    pop de
    ld a, [de]
    sub a, l
    ld [de], a
    inc de
    ld a, [de]
    sbc a, h
    ld [de], a
    ret

; damage = the actor's max MP / 6 (0 when max MP is 0), subtracted from its MP and floored at 0 (E-0125)
; 1 call site from 1 routine (e.g. RollStatusTickEffect)
; reads: wBattleActor
; writes: wBattleDamageLo, wBattleDamageHi
; points at: wBattleMP
ActorLosesSixthOfMaxMP::
Func_032_4D5A:: ; address name
    ld a, [wBattleActor]
    call GetBattleMaxMP_Bank32
    ld a, h
    or a, l
    jr nz, Jump_032_4D69
    ld bc, $0000
    jr Jump_032_4D84

Jump_032_4D69::
    ld a, $06
    call DivideHLByA
    push hl
    ld a, [wBattleActor]
    ld hl, wBattleMP
    add a, a
    call ReadByteAtHLPlusA
    pop bc
    sub a, c
    ld [hl+], a
    ld a, [hl]
    sbc a, b
    ld [hl], a
    jr nc, Jump_032_4D84
    xor a, a
    ld [hl-], a
    ld [hl], a

Jump_032_4D84::
    ld a, c
    ld [wBattleDamageLo], a
    ld a, b
    ld [wBattleDamageHi], a
    ret

; the actor's status byte 3 (wD80F + 9 * actor) = 0 (E-0115)
; 1 call site from 1 routine (e.g. RollStatusTickEffect)
; reads: wBattleActor
; points at: wBattleStatus3
ClearActorStatus3::
Func_032_4D8D:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld [hl], $00
    ret

; for an actor with status bits $C0 or $0C forces action $C9; otherwise picks action $C0, $C1 or a table action (Data_032_4E1C or 4E20) at random and stores it (E-0128)
; 1 call site from 1 routine (e.g. Func_032_4ADC_Case00_Case03)
; reads: wBattleActor, wRandomLo, wLinkMode, wRandomHi, wBattleKind
; writes: wBattleActionId, wBattleTarget
; points at: wBattleStatus3, wBattleActionChoice, wBattleTargetChoice
PickRandomActionWhenUncontrolled::
Func_032_4D99:: ; address name
    call AdvanceRandom
    ld a, [wBattleActor]
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_032_4DAF
    ld a, [hl]
    and a, $0C
    jr z, Jump_032_4DB3

Jump_032_4DAF::
    ld a, $C9
    jr Jump_032_4DF7

Jump_032_4DB3::
    ld a, [wRandomLo]
    cp a, $80
    jr c, Jump_032_4DF1
    cp a, $C0
    jr c, Jump_032_4DF5
    ld a, [wLinkMode]
    cp a, $01
    jr z, Jump_032_4DD1
    ld a, [wBattleActor]
    cp a, $04
    jr c, Jump_032_4DD1
    ld hl, Data_032_4E20
    jr Jump_032_4DD4

Jump_032_4DD1::
    ld hl, Data_032_4E1C

Jump_032_4DD4::
    ld a, [wRandomHi]
    ld b, a
    ld a, [hl+]
    call DivideBByA
    call ReadByteAtHLPlusA
    cp a, $C8
    jr nz, Jump_032_4DF7
    ld a, [wBattleKind]
    cp a, $02
    jr c, Jump_032_4DEE
    ld a, $C7
    jr Jump_032_4DF7

Jump_032_4DEE::
    ld a, [hl]
    jr Jump_032_4DF7

Jump_032_4DF1::
    ld a, $C0
    jr Jump_032_4DF7

Jump_032_4DF5::
    ld a, $C1

Jump_032_4DF7::
    ld b, a
    ld [wBattleActionId], a
    ld a, [wBattleActor]
    ld hl, wBattleActionChoice
    add a, a
    add_a_to_hl
    ld [hl], b
    farcall ChooseActionTarget
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    call ReadByteAtHLPlusA
    ld [wBattleTarget], a
    ret

; address loaded by PickRandomActionWhenUncontrolled
Data_032_4E1C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $03, $C2, $C3, $C5

; address loaded by PickRandomActionWhenUncontrolled
Data_032_4E20:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $08, $C2, $C3, $C4, $C5, $C6, $C7, $C8, $C6

; wDAD2 = 0, wDABE = 0, wD802 = $FF, wBattleSubStep = 0; unless wDABD is set, also wDABA = 0, wDABF = 0, wDAD1 = $FF, wC970 = 0 (E-0120)
; 1 call site from 1 routine (e.g. Func_032_4ADC_Case00_Case00)
; reads: wFollowUpAction
; writes: wEffectFlags, wDefeatStep, wEffectId, wBattleSubStep, wDefeatFlagsBA, wDefeatByteBF, wDefeatByteD1, wActionRepeatFlag
ResetEffectStateForAction::
Func_032_4E29:: ; address name
    xor a, a
    ld [wEffectFlags], a
    xor a, a
    ld [wDefeatStep], a
    ld a, $FF
    ld [wEffectId], a
    xor a, a
    ld [wBattleSubStep], a
    ld a, [wFollowUpAction]
    or a, a
    ret nz
    xor a, a
    ld [wDefeatFlagsBA], a
    xor a, a
    ld [wDefeatByteBF], a
    ld a, $FF
    ld [wDefeatByteD1], a
    xor a, a
    ld [wActionRepeatFlag], a
    ret

; only called from ShowActorStatusRecoveryMessage (E-0047)
; 1 call site from 1 routine (e.g. ShowActorStatusRecoveryMessage)
; reads: wRandomLo, wBattleActor, wBattleTarget, wLoadSlot
; writes: wLoadSlot, wBattleTarget
; points at: wBattleStatus3, wBattleActionChoice
ShowActorStatusRecoveryMessage_Sub01::
Func_032_4E51:: ; address name
    ld a, [hl]
    and a, $0C
    jr z, Jump_032_4E6A
    cp a, $04
    jr z, Jump_032_4E66
    cp a, $08
    jr z, Jump_032_4E62
    ld b, $60
    jr Jump_032_4E6C

Jump_032_4E62::
    ld b, $A0
    jr Jump_032_4E6C

Jump_032_4E66::
    ld b, $E0
    jr Jump_032_4E6C

Jump_032_4E6A::
    ld b, $FF

Jump_032_4E6C::
    ld a, [wRandomLo]
    cp a, b
    jr z, Jump_032_4E8F
    jr c, Jump_032_4E8F
    ld a, [hl]
    and a, $F3
    ld b, a
    ld a, [hl]
    and a, $0C
    dec a
    push bc
    push af
    pop bc
    bit 5, c
    pop bc
    jr nz, Jump_032_4E88
    and a, $0C
    jr Jump_032_4E89

Jump_032_4E88::
    xor a, a

Jump_032_4E89::
    or a, b
    ld [hl], a
    ld d, $13
    scf
    ret

Jump_032_4E8F::
    ld a, [hl]
    and a, $73
    ld [hl], a
    ld a, [wBattleActor]
    call SetBit2OfLevelUpGainsIndexed_Bank32
    ld a, [wBattleTarget]
    ld [wLoadSlot], a
    ld a, [wBattleActor]
    ld [wBattleTarget], a
    ld a, [wBattleActor]
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_032_4EBE
    ld a, [hl]
    and a, $0C
    jr z, Jump_032_4ED3
    ld a, [hl]
    and a, $F3
    ld [hl], a
    jr Jump_032_4EC3

Jump_032_4EBE::
    dec hl
    ld a, [hl]
    and a, $3F
    ld [hl], a

Jump_032_4EC3::
    ld a, [wBattleActor]
    ld hl, wBattleActionChoice
    add a, a

; entry 9 of the `rst $00` table in Func_032_4ADC_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wLoadSlot
; writes: wBattleTarget
Func_032_4ADC_Case01_Case09::
Jump_032_4ECA:: ; address name
    add_a_to_hl
    ld [hl], $BF
    jr Jump_032_4EDB

Jump_032_4ED3::
    ld d, $82
    farcall ShowBattleText

Jump_032_4EDB::
    ld a, [wLoadSlot]
    ld [wBattleTarget], a
    scf
    ccf
    ret

; keeps only bits 7-6 of the actor's status byte 3 (E-0115)
; 1 call site from 1 routine (e.g. ShowActorStatusRecoveryMessage)
; reads: wBattleActor
; points at: wBattleStatus3
ClearActorStatus3Bits0To5::
Func_032_4EE4:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hl]
    and a, $C0
    ld [hl], a
    ret

; entry 1 of the `rst $00` table in Func_032_4ADC
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleSubStep
Func_032_4ADC_Case01::
Jump_032_4EF2:: ; address name
    ld a, [wBattleSubStep]
    rst $00
    dw Func_032_4ADC_Case01_Case00
    dw Func_032_4ADC_Case01_Case01
    dw Func_032_4ADC_Case01_Case02
    dw Func_032_4ADC_Case01_Case03
    dw Func_032_4ADC_Case01_Case04

Jump_032_4F00::
    dw $4CCD
    dw $3851
    dw Func_032_4ADC_Case01_Case07
    dw $07FE
    dw Func_032_4ADC_Case01_Case09

; for C & 7 non-zero runs Func_03A_7508 (and Func_032_5386 unless the result is 1), else shows the special action message; then sets sub-phase 7 and marks the formation slot unless it has status 3/4 bits (E-0126)
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0
ApplyActionResultAndMarkFormation:: ; heuristic: follows a terminator; C0
Func_032_4F0A:: ; address name
    ld c, a
    and a, $07
    jr z, Jump_032_4F32
    push de
    farcall BuildActionMessageNames
    pop af
    cp a, $01
    call nz, CheckActionD0ToE3OrSpecial
    call SetSubPhase7AndResetSteps
    farcall ActorFormationSlotToTemp0
    ldh a, [hTemp0]
    call SlotHasStatus3Or4Bits_Bank32
    ret nz
    farcall RunA3414FAndMarkWDA5B3
    ret

Jump_032_4F32::
    farcall ShowSpecialActionMessage
    call SetSubPhase7AndResetSteps
    farcall ActorFormationSlotToTemp0
    ldh a, [hTemp0]
    call SlotHasStatus3Or4Bits_Bank32
    ret nz
    farcall RunA3414FAndMarkWDA5B3
    ret
    db $21, $CC, $CF, $34, $C9

; entry 0 of the `rst $00` table in Func_032_4ADC_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0, wBattleActor, wBattleActionId, wRecordBufferData
; writes: wBattleActionId
; points at: wSideControl, wBattleSubStep, wBattleStatus, wBattleActionChoice, wResolveBytesE0
Func_032_4ADC_Case01_Case00::
Jump_032_4F53:: ; address name
    farcall ActorActionIsD0ToE3
    ldh a, [hTemp0]
    or a, a
    jr nz, Jump_032_4F00
    call LoadActorChosenActionRecord
    call ActionIsSpecialBFOrC9ToCF
    jp nc, Jump_032_4FFB
    call CheckSkillMPCost
    jr c, Jump_032_4F9C
    ld a, [wBattleActor]
    ld hl, wSideControl
    add_a_to_hl
    bit 7, [hl]
    jr z, Jump_032_4F85
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank32
    cp a, $02
    jr nc, Jump_032_4FC8

Jump_032_4F85::
    ld a, d
    cp a, $07
    jp z, Jump_032_4FFB
    push de
    farcall BuildActionMessageNames
    pop af
    cp a, $01
    call nz, CheckActionD0ToE3OrSpecial
    call SetSubPhase7AndResetSteps
    ret

Jump_032_4F9C::
    ld a, [wBattleActor]
    ld hl, wSideControl
    add_a_to_hl
    bit 7, [hl]
    jr z, Jump_032_4FFB
    ld a, [wBattleActor]
    ld hl, wResolveBytesE0
    call ReadByteAtHLPlusA
    or a, a
    jr nz, Jump_032_4FFB
    ld a, [wRecordBufferData + $5]
    bit 2, a
    jr nz, Jump_032_4FFB
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank32
    cp a, $03
    jr c, Jump_032_4FFB

Jump_032_4FC8::
    ld a, [wBattleActionId]
    cp a, $6E
    jr z, Jump_032_4FFB
    ld a, [wBattleActor]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    and a, $10
    jr nz, Jump_032_4FFB
    farcall AIChooseActionForActor
    call LoadActorChosenActionRecord
    ld a, [wBattleActor]
    ld hl, wBattleActionChoice
    add a, a
    call ReadByteAtHLPlusA
    ld [wBattleActionId], a
    inc hl
    ld [hl], $FF
    call CheckSkillMPCost
    jr nc, Jump_032_4F85

Jump_032_4FFB::
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_032_4ADC_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wBattleActor, wActionQueuePos, wBattleActionId
; points at: wActionQueue, wSlotMarks, wBattleActionChoice, wBattleSubStep
Func_032_4ADC_Case01_Case01::
Jump_032_5000:: ; address name
    ld a, [wLinkMode]
    cp a, $01
    jr z, Jump_032_5073
    ld a, [wBattleActor]
    cp a, $04
    jr c, Jump_032_5073
    ld a, [wActionQueuePos]
    or a, a
    jr z, Jump_032_5073
    ld b, a
    ld hl, wActionQueue

Jump_032_5018::
    ld a, [hl]
    cp a, $10
    jr z, Jump_032_5043
    cp a, $04
    jr c, Jump_032_5043
    push hl
    ld hl, wSlotMarks
    call ReadByteAtHLPlusA
    pop hl
    cp a, $03
    jr z, Jump_032_5031
    cp a, $FE
    jr nz, Jump_032_5043

Jump_032_5031::
    push hl
    ld a, [hl]
    ld hl, wBattleActionChoice
    add a, a
    add_a_to_hl
    ld a, [wBattleActionId]
    cp a, [hl]
    pop hl
    jr z, Jump_032_5049

Jump_032_5043::
    inc hl
    dec b
    jr nz, Jump_032_5018
    jr Jump_032_5073

Jump_032_5049::
    ld a, [wBattleActionId]
    ld c, a
    push hl
    ld hl, Data_032_5078

Jump_032_5051::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_032_505B
    cp a, c
    jr z, Jump_032_505E
    jr Jump_032_5051

Jump_032_505B::
    pop hl
    jr Jump_032_5043

Jump_032_505E::
    pop hl
    ld a, [wBattleActor]
    ld hl, wBattleActionChoice
    add a, a
    add_a_to_hl
    ld [hl], $00
    inc hl
    ld [hl], $FF
    call LoadActorChosenActionRecord

Jump_032_5073::
    ld hl, wBattleSubStep
    inc [hl]
    ret

; address loaded by Func_032_4ADC_Case01_Case01
Data_032_5078:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $04, $05, $06, $07, $08, $09, $0A, $0B, $0C, $0D, $0E, $0F, $10, $11, $12, $13
    db $14, $15, $19, $1A, $26, $28, $2A, $2C, $2E, $2F, $30, $33, $3D, $3E, $3F, $40
    db $41, $42, $43, $44, $45, $46, $47, $49, $4A, $4B, $4D, $4E, $4F, $64, $65, $66
    db $67, $6B, $6C, $6D, $6F, $70, $71, $72, $73, $74, $79, $7A, $8E, $90, $FF

; entry 2 of the `rst $00` table in Func_032_4ADC_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wRecordBufferData
; writes: wBattleTarget
; points at: wBattleTargetChoice, wSideControl, wBattleSubStep
Func_032_4ADC_Case01_Case02::
Jump_032_50B7:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    call ReadByteAtHLPlusA
    cp a, $FF
    jr z, Jump_032_50F6
    ld a, [wBattleActor]
    ld hl, wSideControl
    add_a_to_hl
    bit 7, [hl]
    jr nz, Jump_032_50DD
    ld a, [wRecordBufferData + $4]
    and a, $0F
    cp a, $01
    jr z, Jump_032_50FC

Jump_032_50DD::
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank32
    cp a, $02
    jr nc, Jump_032_50F6
    ld a, [wRecordBufferData + $4]
    and a, $0F
    cp a, $02
    jr z, Jump_032_50F6
    cp a, $04
    jr z, Jump_032_50F6
    jr Jump_032_50FC

Jump_032_50F6::
    farcall ChooseActionTarget

Jump_032_50FC::
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    call ReadByteAtHLPlusA
    ld [wBattleTarget], a
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in Func_032_4ADC_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActionId, wRecordBufferData
; writes: wBattleSubStep
; points at: wBattleResolveStep
Func_032_4ADC_Case01_Case03::
Jump_032_510E:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    xor a, a
    ld [wBattleSubStep], a
    ld a, [wBattleActionId]
    call QueuedActionMatches
    ret nz
    ld d, $02
    farcall BuildActionMessageNames
    ld a, [wRecordBufferData]
    or a, a
    call nz, CheckActionD0ToE3OrSpecial
    call SetSubPhase7AndResetSteps
    ret

; entry 4 of the `rst $00` table in Func_032_4ADC_Case01
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleSubStep
Func_032_4ADC_Case01_Case04::
Jump_032_5130:: ; address name
    call CheckSkillMPCost
    jr c, Jump_032_5143
    ld a, d
    cp a, $07
    jr z, Jump_032_5143
    cp a, $01
    call nz, CheckActionD0ToE3OrSpecial
    call SetSubPhase7AndResetSteps
    ret

Jump_032_5143::
    ld hl, wBattleSubStep
    dec [hl]
    ld hl, wBattleSubStep
    dec [hl]
    ret

; for the actor and its formation partner checks status blocks and MP costs of their stored actions (wDA2C) and returns flags in hFFC7 (E-0129)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wRecordBufferData, hTemp0, hTemp1
; writes: hTemp1, wRecordBuffer, hTemp2, wBattleActor
; points at: wSavedActionChoices, wSlotMarks
CheckFormationPartnersCanAct:: ; heuristic: follows a terminator; C0
Func_032_514C:: ; address name
    xor a, a
    ldh [hTemp1], a
    ld a, [wBattleActor]
    add a, a
    ld hl, wSavedActionChoices
    call ReadByteAtHLPlusA
    ld [wRecordBuffer], a
    ld a, $00
    ld [wRecordBuffer + $1], a
    farcall LoadSkillRecord
    ld a, [wRecordBufferData]
    ldh [hTemp2], a
    ld a, [wBattleActor]
    call CheckSlotStatusBlockWide_Bank32
    jr nc, Jump_032_5178
    ld d, $00
    jr Jump_032_517D

Jump_032_5178::
    call CheckSkillMPCost
    jr c, Jump_032_5181

Jump_032_517D::
    ld a, $01
    ldh [hTemp1], a

Jump_032_5181::
    push de
    ld a, [wBattleActor]
    push af
    farcall ActorFormationSlotToTemp0
    ldh a, [hTemp0]
    ld [wBattleActor], a
    add a, a
    ld hl, wSavedActionChoices
    call ReadByteAtHLPlusA
    ld [wRecordBuffer], a
    ld a, $00
    ld [wRecordBuffer + $1], a
    farcall LoadSkillRecord
    ld a, [wRecordBufferData]
    ldh [hTemp2], a
    ld a, [wBattleActor]
    call CheckSlotStatusBlockWide_Bank32
    jr c, Jump_032_51C3
    ld a, [wBattleActor]
    ld hl, wSlotMarks
    add_a_to_hl
    ld a, [hl]
    cp a, $03
    jr nz, Jump_032_51C7

Jump_032_51C3::
    ld d, $00
    jr Jump_032_51CC

Jump_032_51C7::
    call CheckSkillMPCost
    jr c, Jump_032_51D2

Jump_032_51CC::
    ldh a, [hTemp1]
    or a, $02
    ldh [hTemp1], a

Jump_032_51D2::
    pop af
    ld [wBattleActor], a
    ldh a, [hTemp1]
    or a, a
    jr z, Jump_032_51F3
    bit 0, a
    jr z, Jump_032_51E2
    pop de
    jr Jump_032_51EC

Jump_032_51E2::
    bit 1, a
    jr z, Jump_032_51EB
    ld a, d
    pop de
    ld d, a
    jr Jump_032_51EC

Jump_032_51EB::
    pop de

Jump_032_51EC::
    push de
    call LoadActorChosenActionRecord
    pop de
    xor a, a
    ret

Jump_032_51F3::
    call LoadActorChosenActionRecord
    pop de
    scf
    ret

; for a skill action (wBattleActionId outside $D0-$E3) the cost is byte 0 of the record in wRecordBufferData, copied to hFFC8. The actor's MP minus the cost is computed in HL; a negative result returns with D = 1 (not enough MP) and carry clear. Equal MP and cost succeeds (D = 0, carry set). The MP is not written here (E-0048)
; 6 call sites from 4 routines (e.g. Func_032_5820_Case01, Func_032_4ADC_Case01_Case04, Func_032_4ADC_Case01_Case00, CheckFormationPartnersCanAct)
; reads: wBattleActionId, wBattleActor, hTemp2, wRecordBufferData
; writes: hTemp2
; points at: wBattleStatus2
CheckSkillMPCost::
Func_032_51F9:: ; address name
    ld a, [wBattleActionId]
    cp a, $D0
    jr c, Jump_032_5206
    cp a, $E4
    jr nc, Jump_032_5206
    jr Jump_032_520B

Jump_032_5206::
    ld a, [wRecordBufferData]
    ldh [hTemp2], a

Jump_032_520B::
    ld a, [wBattleActor]
    call GetBattleMP_Bank32
    ldh a, [hTemp2]
    or a, a
    jr z, Jump_032_522D
    ld a, h
    or a, l
    jp z, Jump_032_5296
    ldh a, [hTemp2]
    cp a, $FF
    jr z, Jump_032_522D
    ld c, a
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    bit 7, h
    jr nz, Jump_032_5296

Jump_032_522D::
    ld a, [wBattleActionId]
    call QueuedActionMatches
    jr z, Jump_032_529A
    ld a, [wRecordBufferData + $5]
    bit 6, a
    jr z, Jump_032_5243
    call CheckActorStatusAndFoeTargets
    jr nc, Jump_032_529C
    jr Jump_032_5259

Jump_032_5243::
    bit 4, a
    jr z, Jump_032_524E
    call CheckActorStatusBit7AndFoeBit6
    jr nc, Jump_032_529C
    jr Jump_032_5259

Jump_032_524E::
    bit 5, a
    jr z, Jump_032_5259
    call CheckActorStatusBit6
    jr nc, Jump_032_529C
    jr Jump_032_5259

Jump_032_5259::
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank32
    cp a, $02
    jr c, Jump_032_5294
    ld a, [wRecordBufferData + $5]
    bit 3, a
    jr z, Jump_032_5294
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld hl, wBattleStatus2
    call AddAx9ToHL

Jump_032_527A::
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, Jump_032_5284
    bit 3, [hl]
    jr z, Jump_032_5294

Jump_032_5284::
    ld a, l
    add a, $09
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc c
    dec b
    jr nz, Jump_032_527A
    ld d, $07
    jr Jump_032_529C

Jump_032_5294::
    scf
    ret

Jump_032_5296::
    ld d, $01
    jr Jump_032_529C

Jump_032_529A::
    ld d, $02

Jump_032_529C::
    xor a, a
    ret

; returns carry set when the action may proceed, clear when refused. Refused with D = 3 when bit 0 of the actor's status byte 1 (wD80D + 9 * actor) is set; with D = 4 when bit 3 of the side flag (wD80A for slots 0-3, wD80B for 4-7) is set. Otherwise, when wDA53[actor] >= 2 and wCFF2 = $12, the three opposite slots are scanned: an absent slot is skipped, a present slot without bit 1 or 5 of its status byte 2 allows the action, and if every present one has them the refusal is D = 7 (E-0049)
; 1 call site from 1 routine (e.g. CheckSkillMPCost)
; reads: wBattleActor, wRecordBufferData
; points at: wBattleStatus1, wSideFlags0, wSideFlags1, wBattleStatus2
CheckActorStatusAndFoeTargets::
Func_032_529E:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit 0, [hl]
    jr nz, Jump_032_52F9
    ld hl, wSideFlags0
    ld a, [wBattleActor]
    cp a, $04
    jr c, Jump_032_52B8
    ld hl, wSideFlags1

Jump_032_52B8::
    bit 3, [hl]
    jp nz, Jump_032_52FD
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank32
    cp a, $02
    jr c, Jump_032_5301
    ld a, [wRecordBufferData + $4]
    cp a, $12
    jr nz, Jump_032_5301
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld hl, wBattleStatus2
    call AddAx9ToHL

Jump_032_52DE::
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, Jump_032_52E9
    ld a, [hl]
    and a, $22
    jr z, Jump_032_5301

Jump_032_52E9::
    ld a, l
    add a, $09
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc c
    dec b
    jr nz, Jump_032_52DE
    ld d, $07
    jr Jump_032_52FF

Jump_032_52F9::
    ld d, $03
    jr Jump_032_52FF

Jump_032_52FD::
    ld d, $04

Jump_032_52FF::
    xor a, a
    ret

Jump_032_5301::
    scf
    ret

; carry set = may proceed, clear = refused. Refused with D = 5 when bit 7 of the actor's status byte 1 (wD80D + 9 * actor) is set; otherwise when wDA53[actor] >= 2 the three opposite slots are scanned for a present slot whose status byte 2 (wD80E + 9 * slot) has bit 6 clear (allowed), and if every present one has bit 6 set the refusal is D = 7 (E-0049)
; 1 call site from 1 routine (e.g. CheckSkillMPCost)
; reads: wBattleActor
; points at: wBattleStatus1, wBattleStatus2
CheckActorStatusBit7AndFoeBit6::
Func_032_5303:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit 7, [hl]
    jr nz, Jump_032_5344
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank32
    cp a, $02
    jr c, Jump_032_5348
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld hl, wBattleStatus2
    call AddAx9ToHL

Jump_032_532A::
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, Jump_032_5334
    bit 6, [hl]
    jr z, Jump_032_5348

Jump_032_5334::
    ld a, l
    add a, $09
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc c
    dec b
    jr nz, Jump_032_532A
    ld d, $07
    jr Jump_032_5346

Jump_032_5344::
    ld d, $05

Jump_032_5346::
    xor a, a
    ret

Jump_032_5348::
    scf
    ret

; carry set = may proceed; clear with D = 6 when bit 6 of the actor's status byte 1 (wD80D + 9 * actor) is set (E-0049)
; 1 call site from 1 routine (e.g. CheckSkillMPCost)
; reads: wBattleActor
; points at: wBattleStatus1
CheckActorStatusBit6::
Func_032_534A:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit 6, [hl]
    jr nz, Jump_032_5359
    jr Jump_032_535D

Jump_032_5359::
    ld d, $06
    xor a, a
    ret

Jump_032_535D::
    scf
    ret

; A = 0 for action $BF or $C9-$CF, otherwise carry (E-0124)
; 3 call sites from 3 routines (e.g. CheckActionD0ToE3OrSpecial, CheckLinkRuleViolation, Func_032_4ADC_Case01_Case00)
; reads: wBattleActionId
ActionIsSpecialBFOrC9ToCF::
Func_032_535F:: ; address name
    ld a, [wBattleActionId]
    cp a, $BF
    jr z, Jump_032_5384
    cp a, $C9
    jr z, Jump_032_5384
    cp a, $CA
    jr z, Jump_032_5384
    cp a, $CB
    jr z, Jump_032_5384
    cp a, $CC
    jr z, Jump_032_5384
    cp a, $CD
    jr z, Jump_032_5384
    cp a, $CE
    jr z, Jump_032_5384
    cp a, $CF
    jr z, Jump_032_5384
    scf
    ret

Jump_032_5384::
    xor a, a
    ret

; actions $D0-$E3 continue at Jump_032_53C8; otherwise returns unless ActionIsSpecialBFOrC9ToCF (E-0126)
; 8 call sites from 8 routines (e.g. Func_032_5820_Case07, Func_032_5820_Case01, Func_032_4ADC_Case08, Func_032_4ADC_Case01_Case04, ...)
; reads: wBattleActionId, wBattleActor, hTemp0, wRecordBufferData
; writes: wRecordBuffer, wBattleActor, wRecordBufferData, wAllMPSpentLo, wAllMPSpentHi
; points at: wSavedActionChoices, wBattleMP
CheckActionD0ToE3OrSpecial::
Func_032_5386:: ; address name
    ld a, [wBattleActionId]
    cp a, $D0
    jr c, Jump_032_5393
    cp a, $E4
    jr nc, Jump_032_5393
    jr Jump_032_53C8

Jump_032_5393::
    call ActionIsSpecialBFOrC9ToCF
    ret nc

; subtracts the skill's MP cost (wRecordBufferData) from the actor's MP; cost $FF takes all MP and saves it in wD866; marks the MP digits for redraw (E-0128)
; 4 call sites from 1 routine (e.g. PayActorMPCost)
; reads: wBattleActor, wRecordBufferData
; writes: wAllMPSpentLo, wAllMPSpentHi
; points at: wBattleMP
PayActorMPCost::
Func_032_5397:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleMP
    add a, a
    add_a_to_hl
    ld a, [wRecordBufferData]
    or a, a
    ret z
    cp a, $FF
    jr z, Jump_032_53B6
    ld c, a
    ld a, [hl]
    sub a, c
    ld [hl+], a
    ld a, [hl]
    sbc a, $00
    ld [hl], a
    jr Jump_032_53C1

Jump_032_53B6::
    ld a, [hl+]
    ld [wAllMPSpentLo], a
    ld a, [hl]
    ld [wAllMPSpentHi], a
    xor a, a
    ld [hl-], a
    ld [hl], a

Jump_032_53C1::
    ld a, [wBattleActor]
    call SetBit1OfLevelUpGainsIndexed_Bank32
    ret

Jump_032_53C8::
    cp a, $D6
    jr z, Jump_032_541A
    cp a, $D9
    jr z, Jump_032_541A
    ld a, [wBattleActor]
    ld hl, wSavedActionChoices
    add a, a
    call ReadByteAtHLPlusA
    ld [wRecordBuffer], a
    ld a, $00
    ld [wRecordBuffer + $1], a
    farcall LoadSkillRecord
    call PayActorMPCost
    ld a, [wBattleActor]
    push af
    farcall ActorFormationSlotToTemp0
    ldh a, [hTemp0]
    ld [wBattleActor], a
    ld hl, wSavedActionChoices
    add a, a
    call ReadByteAtHLPlusA
    ld [wRecordBuffer], a
    ld a, $00
    ld [wRecordBuffer + $1], a
    farcall LoadSkillRecord
    call PayActorMPCost
    pop af
    ld [wBattleActor], a
    call LoadActorChosenActionRecord
    ret

Jump_032_541A::
    ld a, $FF
    ld [wRecordBufferData], a
    call PayActorMPCost
    ld a, [wBattleActor]
    push af
    farcall ActorFormationSlotToTemp0
    ldh a, [hTemp0]
    ld [wBattleActor], a
    call PayActorMPCost
    pop af
    ld [wBattleActor], a
    call LoadActorChosenActionRecord
    ret

; wBattleSubPhase = 7, wBattleResolveStep = 0, wBattleSubStep = 0 (E-0115)
; 7 call sites from 6 routines (e.g. Func_032_4ADC_Case04, Func_032_4ADC_Case01_Case04, Func_032_4ADC_Case01_Case03, Func_032_4ADC_Case01_Case00, ...)
; writes: wBattleSubPhase, wBattleResolveStep, wBattleSubStep
SetSubPhase7AndResetSteps::
Func_032_543C:: ; address name
    ld a, $07
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleSubStep], a
    ret

; entry 2 of the `rst $00` table in Func_032_4ADC
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wBattleResolveStep, wSlotFlags854
Func_032_4ADC_Case02::
Jump_032_544A:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wBattleActor]
    ld hl, wSlotFlags854
    add a, a
    call ReadByteAtHLPlusA
    and a, $54
    ret z
    bit 6, a
    jr nz, Jump_032_546B
    bit 2, a
    jr nz, Jump_032_5467
    ld d, $32
    jr Jump_032_546D

Jump_032_5467::
    ld d, $30
    jr Jump_032_546D

Jump_032_546B::
    ld d, $34

Jump_032_546D::
    farcall ShowBattleTextCategory0
    ret

; entry 3 of the `rst $00` table in Func_032_4ADC
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wBattleKind, wBattleActor, wBattleActionId
; writes: wEffectFlags2, wBattleByte93
; points at: wBattleResolveStep
Func_032_4ADC_Case03::
Jump_032_5474:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    farcall ShowActionBattleTextFrom6DAA
    ld a, $80
    ld [wEffectFlags2], a
    farcall SelectEffectByEffectFlags2Flags
    ld a, [wLinkMode]
    or a, a
    ret nz
    ld a, [wBattleKind]
    cp a, $04
    ret c
    cp a, $06
    ret nc
    ld a, [wBattleActor]
    cp a, $04
    ret c
    ld a, [wBattleActionId]
    or a, a
    ret z
    cp a, $AB
    ret z
    cp a, $AC
    ret z
    cp a, $B0
    ret nc
    ld [wBattleByte93], a
    ret

; entry 4 of the `rst $00` table in Func_032_4ADC
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wRecordBufferData
; writes: wBattleResolveStep
; points at: wBattleResolveStep, wBattleStatus3, wBattleStatus, wSlotDamageFlags, wBattleSubPhase, wSlotFlags854
Func_032_4ADC_Case04::
Jump_032_54AF:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wBattleActor]
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hl]
    and a, $C0
    cp a, $40
    jr nz, Jump_032_54F5
    ld a, [wBattleActor]
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit 6, [hl]
    jr nz, Jump_032_54E0
    ld a, [wBattleActor]
    ld de, wSlotDamageFlags
    add a, e
    ld e, a
    jr nc, Jump_032_54DB
    inc d

Jump_032_54DB::
    ld a, [de]
    bit 4, a
    jr nz, Jump_032_54EA

Jump_032_54E0::
    ld hl, wBattleSubPhase
    inc [hl]
    ld a, $06
    ld [wBattleResolveStep], a
    ret

Jump_032_54EA::
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    and a, $3F
    ld [hl], a
    call SetSubPhase7AndResetSteps
    ret

Jump_032_54F5::
    ld a, [wBattleActor]
    ld hl, wSlotFlags854
    add a, a
    call ReadByteAtHLPlusA
    and a, $03
    ret z
    bit 0, a
    jr nz, Jump_032_550A
    ld d, $2F
    jr Jump_032_5512

Jump_032_550A::
    ld a, [wRecordBufferData + $6]
    bit 3, a
    ret z
    ld d, $2E

Jump_032_5512::
    farcall ShowBattleTextCategory0
    ret

; entry 5 of the `rst $00` table in Func_032_4ADC
; no direct call (reached through a table, a jump or a vector)
; reads: wSoundChannelSlots
; writes: wBattleSubStep, wEffectFlags
; points at: wSoundChannel1, wBattleResolveStep
Func_032_4ADC_Case05::
Jump_032_5519:: ; address name
    ld a, [wSoundChannelSlots]
    ld hl, wSoundChannel1
    and a, [hl]
    cp a, $FF
    ret nz
    ld hl, wBattleResolveStep
    inc [hl]
    xor a, a
    ld [wBattleSubStep], a
    call CompareActionIdWithCD
    ret z
    ld a, $80
    ld [wEffectFlags], a
    farcall SelectEffectByEffectFlags
    ret

; compares wBattleActionId with $CD: carry when below, Z when equal (E-0115)
; 1 call site from 1 routine (e.g. Func_032_4ADC_Case05)
; reads: wBattleActionId
CompareActionIdWithCD::
Func_032_553B:: ; address name
    ld a, [wBattleActionId]
    cp a, $CD
    ret

; entry 6 of the `rst $00` table in Func_032_4ADC
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleSubStep
Func_032_4ADC_Case06::
Jump_032_5541:: ; address name
    ld a, [wBattleSubStep]
    rst $00
    dw Func_032_4ADC_Case06_Case00
    dw Func_032_4ADC_Case06_Case01
    dw Func_032_4ADC_Case06_Case02
    dw Func_032_4ADC_Case06_Case03

; entry 0 of the `rst $00` table in Func_032_4ADC_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wRecordBufferData, wBattleActionId, wBattleTarget
; writes: wBattleActionId, wBattleTarget, wBattleSubStep
; points at: wBattleActionChoice, wBattleStatus8, wBattleResolveStep, wQueuedActionId, wBattleSubStep
Func_032_4ADC_Case06_Case00::
Jump_032_554D:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleActionChoice
    add a, a
    call ReadByteAtHLPlusA
    ld [wBattleActionId], a
    inc hl
    ld a, [hl]
    ld [wBattleTarget], a
    ld a, [wRecordBufferData + $8]
    bit 7, a
    jr z, Jump_032_55A9
    ld a, [wRecordBufferData + $4]
    and a, $0F
    cp a, $02
    jr z, Jump_032_5585
    ld a, [wBattleActionId]
    cp a, $35
    jr z, Jump_032_5585
    ld a, [wBattleTarget]
    ld hl, wBattleStatus8
    call AddAx9ToHL
    bit 4, [hl]
    jr nz, Jump_032_55B2
    jr Jump_032_55A9

Jump_032_5585::
    ld a, [wBattleTarget]
    and a, $04
    ld c, a
    ld b, $03
    ld hl, wBattleStatus8
    call AddAx9ToHL

Jump_032_5593::
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, Jump_032_559D
    bit 4, [hl]
    jr nz, Jump_032_55B2

Jump_032_559D::
    ld a, l
    add a, $09
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc c
    dec b
    jr nz, Jump_032_5593

Jump_032_55A9::
    ld hl, wBattleResolveStep
    inc [hl]
    xor a, a
    ld [wBattleSubStep], a
    ret

Jump_032_55B2::
    res 4, [hl]
    ld hl, wQueuedActionId
    ld a, [hl+]
    ld [hl-], a
    ld a, [wBattleActionId]
    ld [hl], a
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_032_4ADC_Case06
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleSubStep
Func_032_4ADC_Case06_Case01::
Jump_032_55C2:: ; address name
    ld hl, wBattleSubStep
    inc [hl]
    ld d, $B0
    farcall ShowBattleText
    ret

; entry 2 of the `rst $00` table in Func_032_4ADC_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleByteAD
; writes: wBattleByteAD
; points at: wBattleSubStep
Func_032_4ADC_Case06_Case02::
Jump_032_55CF:: ; address name
    ld hl, wBattleSubStep
    inc [hl]
    ld a, [wBattleByteAD]
    cp a, $FF
    ret z
    ld d, $92
    farcall ShowBattleText
    ld a, $FF
    ld [wBattleByteAD], a
    ret

; entry 3 of the `rst $00` table in Func_032_4ADC_Case06
; no direct call (reached through a table, a jump or a vector)
Func_032_4ADC_Case06_Case03::
Jump_032_55E7:: ; address name
    call CheckActionD0ToE3OrSpecial
    call SetSubPhase7AndResetSteps
    ret

; in link battles with rules on: an action forbidden by the wD044/wD045 rules (Data_032_5688) ends the battle with music 2 and a message for the side that broke it (E-0128)
; 1 call site from 1 routine (e.g. Func_032_5820_Case06)
; reads: wLinkMode, wLinkRules, wDefeatFlagsBA, wBattleActionId, wBattleActor, wLinkRole, wDataBankSave
; writes: wBattleScene, wStringIndex, wStringCategory, wBattlePhase, wBattleStep, wBattleSubPhase, wBattleResolveStep, wDataBank, ...
; points at: wBattleResolveStep, wLinkRuleWork57, wBattleInitByte58
CheckLinkRuleViolation::
Func_032_55EE:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wLinkMode]
    or a, a
    ret z
    cp a, $02
    ret z
    ld a, [wLinkRules]
    or a, a
    ret z
    ld a, [wDefeatFlagsBA]
    or a, a
    ret nz
    call ActionIsSpecialBFOrC9ToCF
    ret nc
    ld a, [wLinkRules + $1]
    bit 7, a
    ret z
    ld b, a
    ld a, [wBattleActionId]
    ld hl, Data_032_5688
    add_a_to_hl
    ld a, [hl]
    or a, a
    ret z
    and a, b
    ret z
    ld c, a
    ld a, [wLinkRules + $2]
    and a, c
    jr z, Jump_032_563B
    ld hl, wLinkRuleWork57
    ld a, [wBattleActor]
    cp a, $04
    jr c, Jump_032_5633
    ld hl, wBattleInitByte58

Jump_032_5633::
    ld a, c
    and a, [hl]
    jr nz, Jump_032_563B
    ld a, c
    or a, [hl]
    ld [hl], a
    ret

Jump_032_563B::
    ld a, $02
    call QueueMusic
    ld a, [wLinkRole]
    rlca
    and a, $04
    ld b, a
    ld a, [wBattleActor]
    and a, $04
    cp a, b
    jr nz, Jump_032_5658
    ld a, $05
    ld [wBattleScene], a
    ld a, $63
    jr Jump_032_565F

Jump_032_5658::
    ld a, $04
    ld [wBattleScene], a
    ld a, $64

Jump_032_565F::
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ld a, $02
    ld [wBattlePhase], a
    ld a, $09
    ld [wBattleStep], a
    xor a, a
    ld [wBattleSubPhase], a
    ld [wBattleResolveStep], a
    ld a, [wDataBankSave]
    ld [wDataBank], a
    xor a, a
    ld [wDataBankSave], a
    ret

; address loaded by CheckLinkRuleViolation
Data_032_5688:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00
    ds $15, $40
    db $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10
    ds $18, $20
    db $01, $02, $02, $08, $08, $08, $08, $08, $08, $08, $08
    ds $29, $02
    db $08, $08, $08, $08, $20, $04, $04, $04, $04, $04, $04, $04, $04, $20, $20, $20
    db $10, $20, $20, $20, $20, $20, $20, $20, $08, $20, $20, $20, $20, $20, $20, $20
    db $20, $04, $08, $10, $20, $10, $20, $20, $20, $20, $20, $20, $08, $20, $10, $10
    db $10, $00, $00, $00, $00, $00, $00, $00, $00, $02, $00, $00, $20, $20
    ds $39, $00

; entry 8 of the `rst $00` table in Func_032_4ADC
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; writes: wBattleResolveStep, wBattleSubStep
; points at: wSlotFlags854, wBattleSubPhase
Func_032_4ADC_Case08::
Jump_032_5770:: ; address name
    ld a, [wBattleActor]
    ld hl, wSlotFlags854
    call AddDoubleAToHL_Bank32
    bit 4, [hl]
    call z, CheckActionD0ToE3OrSpecial
    ld hl, wBattleSubPhase
    inc [hl]
    xor a, a
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleSubStep], a
    ret

; entry 9 of the `rst $00` table in Func_032_4ADC
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleSubStep
Func_032_4ADC_Case09::
Jump_032_578B:: ; address name
    ld a, [wBattleSubStep]
    rst $00
    dw Func_032_4ADC_Case09_Case00
    dw Func_032_4ADC_Case09_Case01

; entry 0 of the `rst $00` table in Func_032_4ADC_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wBattleActor
; writes: wBattleTarget
; points at: wBattleSubStep
Func_032_4ADC_Case09_Case00::
Jump_032_5793:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, [wBattleActor]
    ld [wBattleTarget], a
    call DefeatTarget
    call BlankTargetMonsterPicture
    call LoadBattleActor
    ld d, $8A
    cp a, $04
    jr c, Jump_032_57AF
    ld d, $8D

Jump_032_57AF::
    farcall ShowBattleText
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_032_4ADC_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wBattleStep, wBattleSubStep, wBattleResolveStep
; points at: wBattlePhase
Func_032_4ADC_Case09_Case01::
Jump_032_57BA:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    call LoadBattleActor
    and a, $04
    ld c, a
    ld b, $03

Jump_032_57C7::
    call SlotCStatusCheckOrBattleSlotOut
    jr nc, Jump_032_57DA
    inc c
    dec b
    jr nz, Jump_032_57C7
    ld hl, wBattlePhase
    inc [hl]
    xor a, a
    ld [wBattleStep], a
    jr Jump_032_57E3

Jump_032_57DA::
    xor a, a
    ld [wBattleSubStep], a
    ld a, $07
    ld [wBattleResolveStep], a

Jump_032_57E3::
    ret

; A = wBattleActor (E-0115)
; 2 call sites from 2 routines (e.g. Func_032_4ADC_Case09_Case01, Func_032_4ADC_Case09_Case00)
; reads: wBattleActor
LoadBattleActor::
Func_032_57E4:: ; address name
    ld a, [wBattleActor]
    ret

; in link battles or for slots 0-3 checks slot C's status block; otherwise carry unless the wDA63 slot is empty (E-0122)
; 1 call site from 1 routine (e.g. Func_032_4ADC_Case09_Case01)
; reads: wLinkMode
SlotCStatusCheckOrBattleSlotOut::
Func_032_57E8:: ; address name
    ld a, [wLinkMode]
    cp a, $01
    jr z, Jump_032_57F8
    ld a, c
    cp a, $04
    jr c, Jump_032_57F8
    call CarryUnlessBattleSlotOutSlotEmpty
    ret

Jump_032_57F8::
    ld a, c
    call CheckSlotStatusBlock
    ret

; HL += A, then A = the byte at HL
; 18 call sites from 13 routines (e.g. PayActorMPCost, LoadActorChosenActionRecord, Func_032_4ADC_Case04, Func_032_4ADC_Case02, ...)
ReadByteAtHLPlusA::
Func_032_57FD:: ; address name
    add_a_to_hl
    ld a, [hl]
    ret

; wBattleActionId = wRecordBuffer = the actor's chosen action (wBattleActionChoice), wCFED = 0, then far-calls LoadSkillRecord (E-0118)
; 7 call sites from 4 routines (e.g. PayActorMPCost, Func_032_4ADC_Case01_Case01, Func_032_4ADC_Case01_Case00, CheckFormationPartnersCanAct)
; reads: wBattleActor
; writes: wBattleActionId, wRecordBuffer
; points at: wBattleActionChoice
LoadActorChosenActionRecord::
Func_032_5804:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleActionChoice
    add a, a
    call ReadByteAtHLPlusA
    ld [wBattleActionId], a
    ld [wRecordBuffer], a
    ld a, $00
    ld [wRecordBuffer + $1], a
    farcall LoadSkillRecord
    ret

; only called from RunBattleStep4_Case00 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleStep4_Case00)
; reads: wBattleResolveStep
RunBattleStep4_Case00_Sub01::
Func_032_5820:: ; address name
    ld a, [wBattleResolveStep]
    rst $00
    dw Func_032_5820_Case00
    dw Func_032_5820_Case01
    dw Func_032_5820_Case02
    dw Func_032_5820_Case03
    dw Func_032_5820_Case04
    dw Func_032_5820_Case05
    dw Func_032_5820_Case06
    dw Func_032_5820_Case07

; entry 0 of the `rst $00` table in Func_032_5820
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wBattleTarget, wDefeatFlagsBA, wBattleActionId
; writes: wFollowUpAction, wDefeatFlagsBA, wBattleActor, wBattleTarget
; points at: wBattleResolveStep, wSavedActorTarget, wBattleActionChoice, wSlotMarks, wBattleTargetChoice
Func_032_5820_Case00::
Jump_032_5834:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wSavedActorTarget
    ld a, [wBattleActor]
    ld [hl+], a
    ld a, [wBattleTarget]
    ld [hl+], a
    ld a, [wDefeatFlagsBA]
    ld [hl+], a
    ld a, [wBattleActor]
    ld de, wBattleActionChoice
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_032_5853
    inc d

Jump_032_5853::
    ld a, [de]
    ld [hl+], a
    inc de
    ld [hl+], a
    ld a, [wBattleTarget]
    ld de, wBattleActionChoice
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_032_5863
    inc d

Jump_032_5863::
    ld a, [de]
    ld [hl+], a
    inc de
    ld [hl+], a
    ld a, [wBattleTarget]
    ld de, wSlotMarks
    add a, e
    ld e, a
    jr nc, Jump_032_5872
    inc d

Jump_032_5872::
    ld a, [de]
    ld [hl], a
    ld a, $01
    ld [wFollowUpAction], a
    xor a, a
    ld [wDefeatFlagsBA], a
    ld a, [wBattleTarget]
    ld [wBattleActor], a
    ld a, [wBattleActor]
    ld hl, wBattleActionChoice
    call AddDoubleAToHL_Bank32
    ld a, [wBattleActionId]
    ld [hl+], a
    ld [hl], $FF
    ld a, [wBattleActor]
    ld hl, wSlotMarks
    add_a_to_hl
    ld [hl], $02
    farcall ChooseActionTarget
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    call AddDoubleAToHL_Bank32
    ld a, [hl]
    ld [wBattleTarget], a
    ret

; entry 1 of the `rst $00` table in Func_032_5820
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleResolveStep
; points at: wBattleResolveStep
Func_032_5820_Case01::
Jump_032_58B3:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    call CheckSkillMPCost
    jr c, Jump_032_58D9
    ld a, d
    and a, $07
    jr z, Jump_032_58D9
    cp a, $07
    jr z, Jump_032_58D9
    push de
    farcall BuildActionMessageNames
    pop af
    cp a, $01
    jr z, Jump_032_58D4
    call CheckActionD0ToE3OrSpecial

Jump_032_58D4::
    ld a, $05
    ld [wBattleResolveStep], a

Jump_032_58D9::
    ret

; entry 2 of the `rst $00` table in Func_032_5820
; no direct call (reached through a table, a jump or a vector)
; reads: wResolveFlagB2
; writes: wEffectFlags2
; points at: wBattleResolveStep
Func_032_5820_Case02::
Jump_032_58DA:: ; address name
    ld a, [wResolveFlagB2]
    bit 0, a
    jr nz, Jump_032_58F2
    farcall ShowActionBattleTextFrom6DAA
    ld a, $80
    ld [wEffectFlags2], a
    farcall SelectEffectByEffectFlags2Flags

Jump_032_58F2::
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in Func_032_5820
; no direct call (reached through a table, a jump or a vector)
; reads: wSoundChannelSlots
; writes: wEffectFlags, wBattleSubStep
; points at: wSoundChannel1, wBattleResolveStep
Func_032_5820_Case03::
Jump_032_58F7:: ; address name
    ld a, [wSoundChannelSlots]
    ld hl, wSoundChannel1
    and a, [hl]
    cp a, $FF
    ret nz
    ld a, $80
    ld [wEffectFlags], a
    farcall SelectEffectByEffectFlags
    ld hl, wBattleResolveStep
    inc [hl]
    xor a, a
    ld [wBattleSubStep], a
    ret

; entry 4 of the `rst $00` table in Func_032_5820
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleSubStep
Func_032_5820_Case04::
Jump_032_5915:: ; address name
    ld a, [wBattleSubStep]
    rst $00
    dw Func_032_5820_Case04_Case00
    dw Func_032_5820_Case04_Case01
    dw Func_032_5820_Case04_Case02
    dw Func_032_5820_Case04_Case03

; entry 0 of the `rst $00` table in Func_032_5820_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wRecordBufferData, wBattleTarget, wBattleActionId
; writes: wBattleActionId, wBattleTarget, wBattleSubStep
; points at: wBattleActionChoice, wBattleStatus8, wBattleResolveStep, wQueuedActionId, wBattleSubStep
Func_032_5820_Case04_Case00::
Jump_032_5921:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleActionChoice
    add a, a
    call ReadByteAtHLPlusA
    ld [wBattleActionId], a
    inc hl
    ld a, [hl]
    ld [wBattleTarget], a
    ld a, [wRecordBufferData + $8]
    bit 7, a
    jr z, Jump_032_5976
    ld a, [wRecordBufferData + $4]
    and a, $0F
    cp a, $02
    jr z, Jump_032_5952
    ld a, [wBattleTarget]
    ld hl, wBattleStatus8
    call AddAx9ToHL
    bit 4, [hl]
    jr nz, Jump_032_5983
    jr Jump_032_5976

Jump_032_5952::
    ld a, [wBattleTarget]
    and a, $04
    ld c, a
    ld b, $03
    ld hl, wBattleStatus8
    call AddAx9ToHL

Jump_032_5960::
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, Jump_032_596A
    bit 4, [hl]
    jr nz, Jump_032_5983

Jump_032_596A::
    ld a, l
    add a, $09
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc c
    dec b
    jr nz, Jump_032_5960

Jump_032_5976::
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wBattleResolveStep
    inc [hl]
    xor a, a
    ld [wBattleSubStep], a
    ret

Jump_032_5983::
    res 4, [hl]
    ld hl, wQueuedActionId
    ld a, [hl+]
    ld [hl-], a
    ld a, [wBattleActionId]
    ld [hl], a
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_032_5820_Case04
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleSubStep
Func_032_5820_Case04_Case01::
Jump_032_5993:: ; address name
    ld hl, wBattleSubStep
    inc [hl]
    ld d, $B0
    farcall ShowBattleText
    ret

; entry 2 of the `rst $00` table in Func_032_5820_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleByteAD
; writes: wBattleByteAD
; points at: wBattleSubStep
Func_032_5820_Case04_Case02::
Jump_032_59A0:: ; address name
    ld hl, wBattleSubStep
    inc [hl]
    ld a, [wBattleByteAD]
    cp a, $FF
    ret z
    ld d, $92
    farcall ShowBattleText
    ld a, $FF
    ld [wBattleByteAD], a
    ret

; entry 3 of the `rst $00` table in Func_032_5820_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleSubStep
; points at: wBattleResolveStep
Func_032_5820_Case04_Case03::
Jump_032_59B8:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    xor a, a
    ld [wBattleSubStep], a
    ret

; entry 5 of the `rst $00` table in Func_032_5820
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleSubPhase, wBattleResolveStep
Func_032_5820_Case05::
Jump_032_59C1:: ; address name
    ld a, $05
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    ret

; entry 6 of the `rst $00` table in Func_032_5820
; no direct call (reached through a table, a jump or a vector)
Func_032_5820_Case06::
Jump_032_59CB:: ; address name
    call CheckLinkRuleViolation
    ret

; entry 7 of the `rst $00` table in Func_032_5820
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleResolveStep, wBattleSubStep
; points at: wBattleSubPhase
Func_032_5820_Case07::
Jump_032_59CF:: ; address name
    call CheckActionD0ToE3OrSpecial
    ld hl, wBattleSubPhase
    inc [hl]
    xor a, a
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleSubStep], a
    ret

; target slot wBattleTarget (wD8A5): when wDAC1's top two bits are not 00 and not 01, wBattleHP[target] -= the 16-bit damage in wD872/wD873 and is clamped at 0 (a result below zero also decrements wCFCB and clears wCFCD); then sets bits 0, 1 and 2 of the target's wD095 flags
; 1 call site from 1 routine (e.g. ResolveStepApplyDamage)
; reads: wResolveMsgArg, wBattleTarget, wBattleDamageLo, wBattleDamageHi
; writes: wBattleSubStep, wBattleSubStep2
; points at: wBattleResolveStep, wBattleHP
ApplyDamageToTarget::
Func_032_59DF:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wBattleResolveStep
    inc [hl]
    xor a, a
    ld [wBattleSubStep], a
    ld a, [wResolveMsgArg]
    and a, $C0
    cp a, $00
    jr z, Jump_032_5A39
    cp a, $40
    jr z, Jump_032_5A26
    ld a, [wBattleTarget]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank32
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wBattleDamageHi]
    ld b, a
    ld a, e
    sub a, c
    ld e, a
    ld a, d
    sbc a, b
    ld d, a
    jr c, Jump_032_5A1B
    ld a, d
    ld [hl-], a
    ld [hl], e
    or a, e
    jr nz, Jump_032_5A26
    inc hl

Jump_032_5A1B::
    xor a, a
    ld [hl-], a
    ld [hl], a
    ld hl, wBattleResolveStep
    dec [hl]
    xor a, a
    ld [wBattleSubStep2], a

Jump_032_5A26::
    ld a, [wBattleTarget]
    call SetBit0OfLevelUpGainsIndexed_Bank32
    ld a, [wBattleTarget]
    call SetBit1OfLevelUpGainsIndexed_Bank32
    ld a, [wBattleTarget]
    call SetBit2OfLevelUpGainsIndexed_Bank32
    ret

Jump_032_5A39::
    ret

; three sub-steps by wBattleSubStep2: 0 lowers a counter (wDA5B + target by 5) and calls DefeatTarget, 1 runs Func_032_5AB3, 2 advances wBattleResolveStep, sets bit 2 of the target's wD095 flags and starts the defeat message (Func_03A_7193)
; 1 call site from 1 routine (e.g. ResolveStepDefeat)
; reads: wBattleSubStep2
RunDefeatSequence::
Func_032_5A3A:: ; address name
    ld a, [wBattleSubStep2]
    rst $00
    dw RunDefeatSequence_Case00
    dw RunDefeatSequence_Case01
    dw RunDefeatSequence_Case02

; entry 0 of the `rst $00` table in RunDefeatSequence
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; points at: wBattleSubStep2, wSlotMarks
RunDefeatSequence_Case00::
Jump_032_5A44:: ; address name
    ld hl, wBattleSubStep2
    inc [hl]
    ld a, [wBattleTarget]
    ld hl, wSlotMarks
    add_a_to_hl
    ld a, [hl]
    add a, $FB
    ld [hl], a
    call DefeatTarget
    ret

; entry 1 of the `rst $00` table in RunDefeatSequence
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleSubStep2
RunDefeatSequence_Case01::
Jump_032_5A5B:: ; address name
    call BlankTargetMonsterPicture
    ld hl, wBattleSubStep2
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunDefeatSequence
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleActionId
; writes: wBattleSubStep2
; points at: wBattleResolveStep
RunDefeatSequence_Case02::
Jump_032_5A63:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    xor a, a
    ld [wBattleSubStep2], a
    ld a, [wBattleTarget]
    call SetBit2OfLevelUpGainsIndexed_Bank32
    call RunDefeatSequence_Case02_Sub01
    ret z
    ld a, [wBattleActionId]
    cp a, $91
    jr nz, Jump_032_5A86
    ld d, $8A
    call ActorOnLocalSide_Bank32
    jr c, Jump_032_5A84
    inc d

Jump_032_5A84::
    jr Jump_032_5A8E

Jump_032_5A86::
    ld d, $8B
    call TargetOnLocalSide_Bank32
    jr nc, Jump_032_5A8E
    dec d

Jump_032_5A8E::
    farcall ShowBattleText
    ret

; only called from RunDefeatSequence_Case02 (E-0047)
; 1 call site from 1 routine (e.g. RunDefeatSequence_Case02)
; reads: wBattleActionId
; points at: wBattleDamageLo
RunDefeatSequence_Case02_Sub01::
Func_032_5A95:: ; address name
    ld a, [wBattleActionId]
    cp a, $13
    ret z
    cp a, $14
    ret z
    cp a, $15
    jr z, Jump_032_5AA9
    cp a, $79
    cp a, $D6
    jr z, Jump_032_5AA9
    ret

Jump_032_5AA9::
    ld hl, wBattleDamageLo
    ld a, [hl+]
    sub a, $E8
    ld a, [hl]
    sbc a, $03
    ret

; for the target's picture slot fills $24 tiles at vTiles2 + $140, $380 or $5C0 with the pattern $FF, $00 (E-0127)
; 11 call sites from 11 routines (e.g. RunBattleSubStep2_6764_Case01, Func_032_4ADC_Case09_Case00, RunDefeatSequence_Case01, RunBattleSubStep2_66F1_Case01, ...)
; reads: wLinkMode, wLinkRole, wBattleTarget, rSTAT
BlankTargetMonsterPicture::
Func_032_5AB3:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_032_5AD4
    cp a, $02
    jr z, Jump_032_5AD4
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_032_5AD4
    ld a, [wBattleTarget]
    bit 2, a
    ret nz
    and a, $03
    cp a, $03
    ret z
    ld a, [wBattleTarget]
    jr Jump_032_5AE4

Jump_032_5AD4::
    ld a, [wBattleTarget]
    bit 2, a
    ret z
    and a, $03
    cp a, $03
    ret z
    ld a, [wBattleTarget]
    sub a, $04

Jump_032_5AE4::
    cp a, $02
    jr z, Jump_032_5AF6
    cp a, $01
    jr z, Jump_032_5AF1
    ld hl, vTiles2 + $140
    jr Jump_032_5AF9

Jump_032_5AF1::
    ld hl, vTiles2 + $380
    jr Jump_032_5AF9

Jump_032_5AF6::
    ld hl, vTiles2 + $5C0

Jump_032_5AF9::
    ld c, $24

Jump_032_5AFB::
    ld b, $08

Jump_032_5AFD::
    di

Jump_032_5AFE::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_032_5AFE
    ld a, $FF
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ei
    dec b
    jr nz, Jump_032_5AFD
    dec c
    jr nz, Jump_032_5AFB
    ret

; target slot wBattleTarget: re-derives its stats (Func_032_5C3F, Func_032_5B94, Func_032_5BE8 clear 'buff' bits), sets wBattleSlotOut[target] = 1, wBattleHP[target] = 0 and clears the target's 9-byte status record (wD80C + 9 * slot)
; 9 call sites from 9 routines (e.g. RunBattleSubStep2_6764_Case00, Func_032_4ADC_Case09_Case00, RunDefeatSequence_Case00, RunBattleSubStep2_66F1_Case00, ...)
; reads: wBattleTarget, wLinkMode
; writes: wDisplaySlot, wDefeatStep
; points at: wBattleStatus6, wBattleSlotOut, wBattleHP, wBattleStatus, wSideFlags0
DefeatTarget::
Func_032_5B12:: ; address name
    call RecomputeTargetMaxHPAndMP
    ld a, [wBattleTarget]
    ld hl, wBattleStatus6
    call AddAx9ToHL
    ld a, [hl]
    and a, $C0
    jr z, Jump_032_5B2A
    ld a, [hl]
    and a, $3F
    ld [hl], a
    call ResetTargetAGLAndDEFToBase

Jump_032_5B2A::
    call DefeatTarget_Sub01
    ld a, [wBattleTarget]
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld [hl], $01
    ld a, [wBattleTarget]
    ld hl, wBattleHP
    add a, a
    add_a_to_hl
    xor a, a
    ld [hl+], a
    ld [hl], a
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
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_032_5B66
    cp a, $02
    jr nz, Jump_032_5B93

Jump_032_5B66::
    ld a, [wBattleTarget]
    cp a, $03
    jr z, Jump_032_5B78
    jr c, Jump_032_5B8D
    cp a, $07
    jr z, Jump_032_5B78
    ld [wDisplaySlot], a
    jr Jump_032_5B93

Jump_032_5B78::
    ld a, [wBattleTarget]
    and a, $04
    rrca
    rrca
    and a, $01
    ld hl, wSideFlags0
    res 2, [hl]
    ld a, $09
    ld [wDefeatStep], a
    jr Jump_032_5B93

Jump_032_5B8D::
    ld a, [wBattleTarget]
    call SetBit2OfLevelUpGainsIndexed_Bank32

Jump_032_5B93::
    ret

; only called from DefeatTarget (E-0047)
; 1 call site from 1 routine (e.g. DefeatTarget)
; reads: wRecordBufferData, wDefeatByteBF, wDefeatByteD1, wBattleTarget, wDefeatFlagsBA
; writes: wDefeatFlagsBA
; points at: wBattleStatus6
DefeatTarget_Sub01::
Func_032_5B94:: ; address name
    ld a, [wRecordBufferData + $4]
    and a, $0F
    cp a, $02
    jr nz, Jump_032_5BC3
    ld a, [wDefeatByteBF]
    bit 1, a
    jr z, Jump_032_5BC3
    ld a, [wDefeatByteD1]
    cp a, $FF
    jr z, Jump_032_5BC3
    ld c, a
    ld a, [wBattleTarget]
    cp a, c
    jr c, Jump_032_5BC3
    jr z, Jump_032_5BC3
    ld a, [wDefeatFlagsBA]
    bit 7, a
    jr z, Jump_032_5BC3
    cp a, $81
    jr z, Jump_032_5BC3
    dec a
    ld [wDefeatFlagsBA], a

Jump_032_5BC3::
    ld a, [wBattleTarget]
    ld e, a
    and a, $04
    ld c, a
    ld b, $04

Jump_032_5BCC::
    ld a, c
    ld hl, wBattleStatus6
    call AddAx9ToHL
    bit 4, [hl]
    jr z, Jump_032_5BE3
    inc hl
    ld a, [hl]
    swap a
    and a, $0F
    cp a, e
    jr nz, Jump_032_5BE3
    dec hl
    res 4, [hl]

Jump_032_5BE3::
    inc c
    dec b
    jr nz, Jump_032_5BCC
    ret

; sets the target's battle AGL and DEF to their base values (GetBaseAGL, GetBaseDEF), preserving wBattleStatResult and all registers (E-0121)
; 2 call sites from 2 routines (e.g. RunBattlePhaseWhenTextIdle_A0_Case02_Case04_Sub01, DefeatTarget)
; reads: wBattleStatResultLo, wBattleStatResultHi, wBattleTarget
; writes: wBattleStatResultLo, wBattleStatResultHi
; points at: wBattleAGL, wBattleDEF
ResetTargetAGLAndDEFToBase::
Func_032_5BE8:: ; address name
    push af
    push bc
    push de
    push hl
    ld a, [wBattleStatResultLo]
    ld l, a
    ld a, [wBattleStatResultHi]
    ld h, a
    push hl
    ld a, [wBattleTarget]
    ld c, a
    farcall GetBaseAGL
    ld a, [wBattleTarget]
    ld hl, wBattleAGL
    add a, a
    add_a_to_hl
    ld a, [wBattleStatResultLo]
    ld [hl+], a
    ld a, [wBattleStatResultHi]
    ld [hl], a
    ld a, [wBattleTarget]
    ld c, a
    farcall GetBaseDEF
    ld a, [wBattleTarget]
    ld hl, wBattleDEF
    add a, a
    add_a_to_hl
    ld a, [wBattleStatResultLo]
    ld [hl+], a
    ld a, [wBattleStatResultHi]
    ld [hl], a
    pop hl
    ld a, l
    ld [wBattleStatResultLo], a
    ld a, h
    ld [wBattleStatResultHi], a
    pop hl
    pop de
    pop bc
    pop af
    ret

; when bits 4-5 of the target's status byte (wD80D + 9 * slot) are set: stores GetBaseHP and GetBaseMP of the target in wBattleMaxHP and wBattleMaxMP and lowers the current values to the new maximum
; 2 call sites from 2 routines (e.g. RunBattlePhaseWhenTextIdle_A0_Case02_Case04_Sub01, DefeatTarget)
; reads: wBattleTarget, wBattleStatResultLo, wBattleStatResultHi
; writes: wBattleArg0, wBattleArg1, wBattleArg2, wBattleArg3
; points at: wBattleStatus1, wBattleMaxHP, wBattleHP, wBattleMaxMP, wBattleMP, wBattleATK, wBattleINT, wBattleLevel, ...
RecomputeTargetMaxHPAndMP::
Func_032_5C3F:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    ld a, [hl]
    and a, $30
    ret z
    and a, $20
    call nz, RecomputeTargetMaxHPAndMP_Sub01
    ld a, $01
    ld [wBattleArg0], a
    ld a, [wBattleTarget]
    ld c, a
    farcall LoadSlotSkillsFromBattlerRecord
    ld a, [wBattleTarget]
    ld c, a
    farcall GetBaseHP
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleStatResultHi]
    ld b, a
    ld a, [wBattleTarget]
    ld hl, wBattleMaxHP
    call AddDoubleAToHL_Bank32
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [wBattleTarget]
    call GetBattleHP_Bank32
    call CompareHLToBC
    jr c, Jump_032_5C95
    ld a, [wBattleTarget]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank32
    ld [hl], c
    inc hl
    ld [hl], b

Jump_032_5C95::
    ld a, [wBattleTarget]
    ld c, a
    farcall GetBaseMP
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleStatResultHi]
    ld b, a
    ld a, [wBattleTarget]
    ld hl, wBattleMaxMP
    call AddDoubleAToHL_Bank32
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [wBattleTarget]
    call GetBattleMP_Bank32
    call CompareHLToBC
    jr c, Jump_032_5CCA
    ld a, [wBattleTarget]
    ld hl, wBattleMP
    call AddDoubleAToHL_Bank32
    ld [hl], c
    inc hl
    ld [hl], b

Jump_032_5CCA::
    ld a, [wBattleTarget]
    ld c, a
    farcall GetBaseATK
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleStatResultHi]
    ld b, a
    ld a, [wBattleTarget]
    ld hl, wBattleATK
    call AddDoubleAToHL_Bank32
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
    call AddDoubleAToHL_Bank32
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [wBattleTarget]
    ld c, a
    farcall SetSlotAIModeFromINT
    ld a, [wBattleTarget]
    ld c, a
    farcall SlotField17OrMonsterCFF5
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleTarget]
    ld hl, wBattleLevel
    add_a_to_hl
    ld [hl], c
    ld a, [wBattleTarget]
    ld c, a
    farcall SlotField2DOrMonsterD002
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleTarget]
    ld hl, wSlotPersonalityHi
    add_a_to_hl
    ld [hl], c
    ld a, [wBattleTarget]
    ld c, a
    farcall SlotField30OrMonsterD004
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleTarget]
    ld hl, wSlotPersonalityMid
    add_a_to_hl
    ld [hl], c
    ld a, [wBattleTarget]
    ld c, a
    farcall SlotField2EOrMonsterD003
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleTarget]
    ld hl, wSlotPersonalityLo
    add_a_to_hl
    ld [hl], c
    ld a, [wBattleTarget]
    ld c, a
    farcall SlotField2FOrMonsterD005
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleTarget]
    ld hl, wSlotTrait
    add_a_to_hl
    ld [hl], c
    ld a, [wBattleTarget]
    ld c, a
    farcall GetBaseAGL
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleStatResultHi]
    ld b, a
    ld a, [wBattleTarget]
    ld hl, wBattleAGL
    call AddDoubleAToHL_Bank32
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
    call AddDoubleAToHL_Bank32
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [wBattleTarget]
    ld c, a
    farcall SlotSpeciesNibblesD00AD00B
    ld a, [wBattleTarget]
    ld hl, wSlotDamageFlags
    add_a_to_hl
    ld [hl], c
    ld a, [wBattleTarget]
    ld b, a
    and a, $03
    cp a, $03
    ret z
    ld a, b
    ld e, $31
    call BattlerRecordFieldAddress
    ld a, l
    ld [wBattleArg0], a
    ld a, h
    ld [wBattleArg1], a
    ld a, [wBattleTarget]
    ld de, wSlotResistances
    ld b, a
    add a, a
    add a, b
    add a, a
    add a, b
    add a, e
    ld e, a
    jr nc, Jump_032_5E0B
    inc d

Jump_032_5E0B::
    ld a, e
    ld [wBattleArg2], a
    ld a, d
    ld [wBattleArg3], a
    farcall LoadBattleArg0PointersThenRun44C9
    ret

; only called from RecomputeTargetMaxHPAndMP (E-0047)
; 1 call site from 1 routine (e.g. RecomputeTargetMaxHPAndMP)
; reads: wBattleTarget, wLinkMode
; points at: wSlotNameBytes
RecomputeTargetMaxHPAndMP_Sub01::
Func_032_5E1A:: ; address name
    ld a, [wBattleTarget]
    ld c, a

; only called from ActionEffect_BeDragon (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_BeDragon)
; reads: wLinkMode
; points at: wSlotNameBytes
ActionEffect_BeDragon_Sub01::
Func_032_5E1E:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_032_5E27
    cp a, $02
    ret nz

Jump_032_5E27::
    ld a, c
    cp a, $04
    ret c
    and a, $03
    cp a, $03
    ret z
    ld hl, wSlotNameBytes
    add_a_to_hl
    ld [hl], $FF
    ret

; only called from RunBattlePhaseWhenTextIdle_A0_Case02_Case04 (E-0047)
; 1 call site from 1 routine (e.g. RunBattlePhaseWhenTextIdle_A0_Case02_Case04)
; reads: wBattleTarget
; writes: wSideFlags0, wSideFlags1, wBattleTarget
; points at: wBattleStatus6, wBattleStatus, wBattleSlotOut, wSlotMarks
RunBattlePhaseWhenTextIdle_A0_Case02_Case04_Sub01::
Func_032_5E3B:: ; address name
    xor a, a
    ld [wSideFlags0], a
    ld [wSideFlags1], a
    ld c, $00

Jump_032_5E44::
    push bc
    ld a, c
    ld [wBattleTarget], a
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, Jump_032_5E79
    call RecomputeTargetMaxHPAndMP
    ld a, [wBattleTarget]
    ld hl, wBattleStatus6
    call AddAx9ToHL
    ld a, [hl]
    and a, $C0
    jr z, Jump_032_5E66
    ld a, [hl]
    and a, $3F
    ld [hl], a
    call ResetTargetAGLAndDEFToBase

Jump_032_5E66::
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

Jump_032_5E79::
    pop bc
    inc c
    ld a, c
    cp a, $02
    jr nz, Jump_032_5E44
    ld a, $03
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld [hl], $FF
    ld a, $03
    ld hl, wSlotMarks
    add_a_to_hl
    ld [hl], $FF
    ld a, $03
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
    ret

; resolve step $0E runs this through wBattleSubStep (wCFCC): ten cases, 0-9. Case 0 branches on wBattleActionId: $15 and $20 to Func_032_5F20, $3B to Func_032_5F3B, $5F to Func_032_5F63, $60 to Func_032_5FAE, $61 to Func_032_5FF8, $6D to Func_032_5F35; the other actions and cases 1-9 are not yet read (E-0051)
; 1 call site from 1 routine (e.g. ResolveStep0ECallEffect)
; reads: wBattleSubStep
ResolveStep0EEffect::
Func_032_5EAB:: ; address name
    ld a, [wBattleSubStep]
    rst $00
    dw ResolveStep0EEffect_Case00
    dw ResolveStep0EEffect_Case01
    dw ResolveStep0EEffect_Case02
    dw ResolveStep0EEffect_Case03
    dw ResolveStep0EEffect_Case04
    dw ResolveStep0EEffect_Case05
    dw ResolveStep0EEffect_Case06
    dw ResolveStep0EEffect_Case06
    dw ResolveStep0EEffect_Case06
    dw ResolveStep0EEffect_Case09

; entry 0 of the `rst $00` table in ResolveStep0EEffect
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActionId, wBattleActor, hTemp0, wBattleScreenFlags, wBattleTarget
; writes: wBattleSubStep2, wEffectSubStep, wBattleActor, wBattleSubPhase, wBattleResolveStep, wBattleSubStep, wSavedActorSlot, wSavedActorByte, ...
; points at: wBattleSubStep, wBattleStatus
ResolveStep0EEffect_Case00::
Jump_032_5EC3:: ; address name
    xor a, a
    ld [wBattleSubStep2], a
    xor a, a
    ld [wEffectSubStep], a
    ld a, [wBattleActionId]
    cp a, $15
    jr z, Jump_032_5F20
    cp a, $20
    jr z, Jump_032_5F20
    cp a, $3B
    jr z, Jump_032_5F3B
    cp a, $5F
    jp z, Jump_032_5F63
    cp a, $60
    jp z, Jump_032_5FAE
    cp a, $61
    jp z, Jump_032_5FF8
    cp a, $6D
    jr z, Jump_032_5F35
    cp a, $6F
    jr z, Jump_032_5F0A
    cp a, $70
    jr z, Jump_032_5F10
    cp a, $7B
    jr z, Jump_032_5F20
    cp a, $B8
    jr z, Jump_032_5F3B
    cp a, $D6
    jr z, Jump_032_5F16
    cp a, $DC
    jr z, Jump_032_5F4B

Jump_032_5F05::
    ld hl, wBattleSubStep
    inc [hl]
    ret

Jump_032_5F0A::
    ld a, $03
    ld [wBattleSubStep], a
    ret

Jump_032_5F10::
    ld a, $04
    ld [wBattleSubStep], a
    ret

Jump_032_5F16::
    ld a, [wBattleActor]
    ld [wSavedActorSlot], a
    xor a, a
    ld [wSavedActorByte], a

Jump_032_5F20::
    ld a, [wBattleScreenFlags]
    bit 0, a
    jr z, Jump_032_5F05
    ld a, [wBattleScreenFlags]
    and a, $FE
    ld [wBattleScreenFlags], a
    ld a, $05
    ld [wBattleSubStep], a
    ret

Jump_032_5F35::
    ld a, $09
    ld [wBattleSubStep], a
    ret

Jump_032_5F3B::
    call ResolveStep0EEffect_Case00_Sub01
    xor a, a
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleSubStep], a
    ret

Jump_032_5F4B::
    ld a, [wBattleActor]
    push af
    farcall ActorFormationSlotToTemp0
    ldh a, [hTemp0]
    ld [wBattleActor], a
    call ResolveStep0EEffect_Case00_Sub01
    pop af
    ld [wBattleActor], a
    jr Jump_032_5F3B

Jump_032_5F63::
    ld a, [wBattleTarget]
    call CarryUnlessBattleSlotOutSlotEmpty
    jp c, SetBattleSubStep1
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    and a, $03
    jp nz, SetBattleSubStep1
    push hl
    farcall RollTargetSlotResistancesByte4Bits01ChanceToE
    pop hl
    ld a, e
    or a, a
    jp nz, SetBattleSubStep1
    set 0, [hl]
    ld a, [wBattleTarget]
    call SetBit2OfLevelUpGainsIndexed_Bank32
    ld a, $20
    ld [wEffectFlags], a
    farcall SelectEffectByEffectFlags
    ld a, $08
    ld [wEffectFlags2], a
    farcall SelectEffectByEffectFlags2Flags
    ld a, $75
    ld [wEffectSubStep], a
    jp SetBattleSubStep1

Jump_032_5FAE::
    ld a, [wBattleTarget]
    call CarryUnlessBattleSlotOutSlotEmpty
    jp c, SetBattleSubStep1
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit 6, [hl]
    jp nz, SetBattleSubStep1
    push hl
    farcall RollTargetSlotResistancesByte5Bits67ChanceToE
    pop hl
    ld a, e
    or a, a
    jp nz, SetBattleSubStep1
    set 6, [hl]
    ld a, [wBattleTarget]
    call SetBit2OfLevelUpGainsIndexed_Bank32
    ld a, $20
    ld [wEffectFlags], a
    farcall SelectEffectByEffectFlags
    ld a, $08
    ld [wEffectFlags2], a
    farcall SelectEffectByEffectFlags2Flags
    ld a, $76
    ld [wEffectSubStep], a
    jp SetBattleSubStep1

Jump_032_5FF8::
    ld a, [wBattleTarget]
    call CarryUnlessBattleSlotOutSlotEmpty
    jp c, SetBattleSubStep1
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit 7, [hl]
    jp nz, SetBattleSubStep1
    push hl
    farcall ResolveStep0EEffect_Case00_Sub02
    pop hl
    ld a, e
    or a, a
    jp nz, SetBattleSubStep1
    ld a, [hl]
    or a, $8C
    ld [hl], a
    ld a, [wBattleTarget]
    call SetBit2OfLevelUpGainsIndexed_Bank32
    ld a, $20
    ld [wEffectFlags], a
    farcall SelectEffectByEffectFlags
    ld a, $08
    ld [wEffectFlags2], a
    farcall SelectEffectByEffectFlags2Flags
    call TargetOnLocalSide_Bank32
    ld a, $74
    jr c, Jump_032_6044
    dec a

Jump_032_6044::
    ld [wEffectSubStep], a
    jp SetBattleSubStep1

; only called from ResolveStep0EEffect_Case00 (E-0047)
; 2 call sites from 1 routine (e.g. ResolveStep0EEffect_Case00)
; reads: wBattleActor, wRandomLo
; points at: wBattleActionChoice
ResolveStep0EEffect_Case00_Sub01::
Func_032_604A:: ; address name
    call AdvanceRandom
    ld a, [wBattleActor]
    ld hl, wBattleActionChoice
    call AddDoubleAToHL_Bank32
    push hl
    ld a, [wRandomLo]
    and a, $03
    ld hl, Data_032_6094
    add_a_to_hl
    ld a, [hl]
    pop hl
    ld [hl+], a
    ld c, a
    push hl
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld b, a
    ld a, c
    cp a, $00
    jr nz, Jump_032_6090
    ld a, [wRandomLo]
    and a, $03
    add a, b

Jump_032_607C::
    ld b, a
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, Jump_032_6090
    ld a, b
    and a, $03
    jr nz, Jump_032_608C
    ld a, b
    or a, $03
    jr Jump_032_607C

Jump_032_608C::
    ld a, b
    dec a
    jr Jump_032_607C

Jump_032_6090::
    pop hl
    ld a, b
    ld [hl], a
    ret

; address loaded by ResolveStep0EEffect_Case00_Sub01
Data_032_6094:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $00

; entry 1 of the `rst $00` table in ResolveStep0EEffect
; no direct call (reached through a table, a jump or a vector)
; reads: wEffectSubStep
; writes: wBattleSubStep
; points at: wBattleSubStep, wBattleResolveStep
ResolveStep0EEffect_Case01::
Jump_032_6099:: ; address name
    ld a, [wEffectSubStep]
    or a, a
    jr z, ResolveStep0EEffect_Case02
    ld d, a
    farcall ShowBattleText
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in ResolveStep0EEffect
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleSubStep
; points at: wBattleResolveStep
ResolveStep0EEffect_Case02::
Jump_032_60AB:: ; address name
    xor a, a
    ld [wBattleSubStep], a
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in ResolveStep0EEffect
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleSubStep2
ResolveStep0EEffect_Case03::
Jump_032_60B4:: ; address name
    ld a, [wBattleSubStep2]
    rst $00
    dw ResolveStep0EEffect_Case03_Case00
    dw ResolveStep0EEffect_Case03_Case01
    dw ResolveStep0EEffect_Case03_Case02
    dw SetBattleSubStep1

; entry 0 of the `rst $00` table in ResolveStep0EEffect_Case03
; no direct call (reached through a table, a jump or a vector)
; writes: wEffectFlags, wEffectFlags2
; points at: wBattleSubStep2
ResolveStep0EEffect_Case03_Case00::
Jump_032_60C0:: ; address name
    ld hl, wBattleSubStep2
    inc [hl]
    call SkipTurnIfActorAbsent
    ret c
    ld a, $20
    ld [wEffectFlags], a
    farcall SelectEffectByEffectFlags
    ld a, $08
    ld [wEffectFlags2], a
    farcall SelectEffectByEffectFlags2Flags
    ret

; entry 1 of the `rst $00` table in ResolveStep0EEffect_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wBattleTarget, wBattleDamageLo, wBattleDamageHi, wEffectTemp0, wEffectTemp1, wTemp0, wLoadSlot
; writes: wEffectTemp0, wEffectTemp1, wEffectSubStep, wTemp0, wLoadSlot, wBattleTarget, wBattleDamageLo, wBattleDamageHi
; points at: wBattleSubStep2, wBattleHP, wTemp0
ResolveStep0EEffect_Case03_Case01::
Jump_032_60DF:: ; address name
    ld hl, wBattleSubStep2
    inc [hl]
    ld hl, wBattleSubStep2
    inc [hl]
    ld a, [wBattleActor]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank32
    push hl
    deref_hl
    push hl
    call ScaleHLTo80Percent_Bank32
    inc hl
    ld a, l
    ld [wEffectTemp0], a
    ld a, h
    ld [wEffectTemp1], a
    pop bc
    ld a, c
    sub a, l
    ld c, a
    ld a, b
    sbc a, h
    ld b, a
    jr c, Jump_032_610F
    or a, c
    jr z, Jump_032_610F
    jr Jump_032_6112

Jump_032_610F::
    ld bc, $0000

Jump_032_6112::
    pop hl
    ld a, c
    ld [hl+], a
    ld [hl], b
    or a, b
    jr nz, Jump_032_6121
    ld hl, wBattleSubStep2
    dec [hl]
    xor a, a
    ld [wEffectSubStep], a

Jump_032_6121::
    ld a, $35
    ld [wTemp0], a
    call ActorOnLocalSide_Bank32
    jr nc, Jump_032_612F
    ld hl, wTemp0
    inc [hl]

Jump_032_612F::
    ld a, [wBattleTarget]
    ld [wLoadSlot], a
    ld a, [wBattleActor]
    ld [wBattleTarget], a
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    push hl
    ld a, [wEffectTemp0]
    ld l, a
    ld a, [wEffectTemp1]
    ld h, a
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    ld a, [wTemp0]
    ld d, a
    farcall ShowBattleText
    pop hl
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    ld a, [wLoadSlot]
    ld [wBattleTarget], a
    ld a, [wBattleActor]
    call SetBit0OfLevelUpGainsIndexed_Bank32
    ret

; entry 2 of the `rst $00` table in ResolveStep0EEffect_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleActor, wLoadSlot
; writes: wLoadSlot, wBattleTarget
ResolveStep0EEffect_Case03_Case02::
Jump_032_6174:: ; address name
    ld a, [wBattleTarget]
    ld [wLoadSlot], a
    ld a, [wBattleActor]
    ld [wBattleTarget], a
    call RunEffectSubStep_618A
    ld a, [wLoadSlot]
    ld [wBattleTarget], a
    ret

; runs the routine for wCFCE (jump table of three) (E-0122)
; 1 call site from 1 routine (e.g. ResolveStep0EEffect_Case03_Case02)
; reads: wEffectSubStep
RunEffectSubStep_618A::
Func_032_618A:: ; address name
    ld a, [wEffectSubStep]
    rst $00
    dw RunEffectSubStep_618A_Case00
    dw RunEffectSubStep_618A_Case01
    dw RunEffectSubStep_618A_Case02

; entry 0 of the `rst $00` table in RunEffectSubStep_618A
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; points at: wEffectSubStep, wSlotMarks
RunEffectSubStep_618A_Case00::
Jump_032_6194:: ; address name
    ld hl, wEffectSubStep
    inc [hl]
    ld a, [wBattleTarget]
    ld hl, wSlotMarks
    add_a_to_hl
    ld [hl], $FE
    call DefeatTarget
    ret

; entry 1 of the `rst $00` table in RunEffectSubStep_618A
; no direct call (reached through a table, a jump or a vector)
; points at: wEffectSubStep
RunEffectSubStep_618A_Case01::
Jump_032_61A9:: ; address name
    call BlankTargetMonsterPicture
    ld hl, wEffectSubStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunEffectSubStep_618A
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wTemp0
; writes: wTemp0, wEffectSubStep
; points at: wBattleSubStep2
RunEffectSubStep_618A_Case02::
Jump_032_61B1:: ; address name
    ld a, [wBattleTarget]
    call SetBit2OfLevelUpGainsIndexed_Bank32
    ld a, $90
    ld [wTemp0], a
    call ActorOnLocalSide_Bank32
    jr c, Jump_032_61C6
    ld a, $8D
    ld [wTemp0], a

Jump_032_61C6::
    ld a, [wTemp0]
    ld d, a
    farcall ShowBattleText
    ld hl, wBattleSubStep2
    inc [hl]
    xor a, a
    ld [wEffectSubStep], a
    ret

; wBattleSubStep2 = 0, wBattleSubStep = 1 (E-0071)
; 3 call sites from 3 routines (e.g. SkipTurnIfActorAbsent, ResolveStep0EEffect_Case04_Case03, ResolveStep0EEffect_Case09_Case03)
; writes: wBattleSubStep2, wBattleSubStep
SetBattleSubStep1::
Func_032_61D9:: ; address name
    xor a, a
    ld [wBattleSubStep2], a
    ld a, $01
    ld [wBattleSubStep], a
    ret

; entry 4 of the `rst $00` table in ResolveStep0EEffect
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleSubStep2
ResolveStep0EEffect_Case04::
Jump_032_61E3:: ; address name
    ld a, [wBattleSubStep2]
    rst $00
    dw ResolveStep0EEffect_Case04_Case00
    dw ResolveStep0EEffect_Case04_Case01
    dw ResolveStep0EEffect_Case04_Case02
    dw ResolveStep0EEffect_Case04_Case03

; entry 0 of the `rst $00` table in ResolveStep0EEffect_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wEffectFlags, wEffectFlags2
; points at: wBattleSubStep2
ResolveStep0EEffect_Case04_Case00::
Jump_032_61EF:: ; address name
    call SkipTurnIfActorAbsent
    ret c
    ld a, $20
    ld [wEffectFlags], a
    farcall SelectEffectByEffectFlags
    ld a, $08
    ld [wEffectFlags2], a
    farcall SelectEffectByEffectFlags2Flags
    ld hl, wBattleSubStep2
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ResolveStep0EEffect_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wBattleTarget, wLoadSlot
; writes: wEffectSubStep, wLoadSlot, wBattleTarget
; points at: wBattleSubStep2, wBattleHP
ResolveStep0EEffect_Case04_Case01::
Jump_032_620E:: ; address name
    ld hl, wBattleSubStep2
    inc [hl]
    ld hl, wBattleSubStep2
    inc [hl]
    ld a, [wBattleActor]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank32
    push hl
    deref_hl
    ld a, h
    or a, a
    jr nz, Jump_032_6231
    ld a, l
    cp a, $01
    jr nz, Jump_032_6231
    ld bc, $0000
    jr Jump_032_6234

Jump_032_6231::
    ld bc, $0001

Jump_032_6234::
    pop hl
    ld a, c
    ld [hl+], a
    ld [hl], b
    or a, b
    jr nz, Jump_032_6245
    ld hl, wBattleSubStep2
    dec [hl]
    xor a, a
    ld [wEffectSubStep], a
    jr Jump_032_625F

Jump_032_6245::
    ld a, [wBattleTarget]
    ld [wLoadSlot], a
    ld a, [wBattleActor]
    ld [wBattleTarget], a
    ld d, $38
    farcall ShowBattleText
    ld a, [wLoadSlot]
    ld [wBattleTarget], a

Jump_032_625F::
    ld a, [wBattleActor]
    call SetBit0OfLevelUpGainsIndexed_Bank32
    ret

; entry 2 of the `rst $00` table in ResolveStep0EEffect_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleActor, wLoadSlot
; writes: wLoadSlot, wBattleTarget
ResolveStep0EEffect_Case04_Case02::
Jump_032_6266:: ; address name
    ld a, [wBattleTarget]
    ld [wLoadSlot], a
    ld a, [wBattleActor]
    ld [wBattleTarget], a
    call ResolveStep0EEffect_Case04_Case02_Sub01
    ld a, [wLoadSlot]
    ld [wBattleTarget], a
    ret

; only called from ResolveStep0EEffect_Case04_Case02 (E-0047)
; 1 call site from 1 routine (e.g. ResolveStep0EEffect_Case04_Case02)
; reads: wEffectSubStep
ResolveStep0EEffect_Case04_Case02_Sub01::
Func_032_627C:: ; address name
    ld a, [wEffectSubStep]
    rst $00
    dw Func_032_627C_Case00
    dw Func_032_627C_Case01
    dw Func_032_627C_Case02

; entry 0 of the `rst $00` table in Func_032_627C
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; points at: wEffectSubStep, wSlotMarks
Func_032_627C_Case00::
Jump_032_6286:: ; address name
    ld hl, wEffectSubStep
    inc [hl]
    ld a, [wBattleTarget]
    ld hl, wSlotMarks
    add_a_to_hl
    ld [hl], $FE
    call DefeatTarget
    ret

; entry 1 of the `rst $00` table in Func_032_627C
; no direct call (reached through a table, a jump or a vector)
; points at: wEffectSubStep
Func_032_627C_Case01::
Jump_032_629B:: ; address name
    call BlankTargetMonsterPicture
    ld hl, wEffectSubStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_032_627C
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wTemp0
; writes: wTemp0, wEffectSubStep
; points at: wBattleSubStep2
Func_032_627C_Case02::
Jump_032_62A3:: ; address name
    ld a, [wBattleTarget]
    call SetBit2OfLevelUpGainsIndexed_Bank32
    ld a, $90
    ld [wTemp0], a
    call ActorOnLocalSide_Bank32
    jr c, Jump_032_62B8
    ld a, $8D
    ld [wTemp0], a

Jump_032_62B8::
    ld a, [wTemp0]
    ld d, a
    farcall ShowBattleText
    ld hl, wBattleSubStep2
    inc [hl]
    xor a, a
    ld [wEffectSubStep], a
    ret

; entry 3 of the `rst $00` table in ResolveStep0EEffect_Case04
; no direct call (reached through a table, a jump or a vector)
ResolveStep0EEffect_Case04_Case03::
Jump_032_62CB:: ; address name
    call SetBattleSubStep1
    ret

; entry 5 of the `rst $00` table in ResolveStep0EEffect
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActionId, wSavedActorByte, hTemp0, wBattleSubStep2
; writes: wSavedActorByte, wBattleActor
ResolveStep0EEffect_Case05::
Jump_032_62CF:: ; address name
    ld a, [wBattleActionId]
    cp a, $D6
    jr nz, Jump_032_62F1
    ld a, [wSavedActorByte]
    bit 0, a
    jr z, Jump_032_62F1
    bit 7, a
    jr nz, Jump_032_62F1
    set 7, a
    ld [wSavedActorByte], a
    farcall ActorFormationSlotToTemp0
    ldh a, [hTemp0]
    ld [wBattleActor], a

Jump_032_62F1::
    ld a, [wBattleSubStep2]
    rst $00
    dw Func_032_627C_Table2_Case00
    dw Func_032_627C_Table2_Case01
    dw Func_032_627C_Table2_Case02
    dw Func_032_627C_Table2_Case03

; entry 0 of the `rst $00` table in Func_032_627C
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wBattleActionId, wSavedActorByte, wSavedActorSlot
; writes: wBattleActor, wBattleSubPhase, wBattleResolveStep, wBattleSubStep2, wSavedActorByte, wEffectSubStep
; points at: wBattleSubStep2
Func_032_627C_Table2_Case00::
Jump_032_62FD:: ; address name
    ld hl, wBattleSubStep2
    inc [hl]
    ld a, [wBattleActor]
    call CarryUnlessBattleSlotOutSlotEmpty
    jp c, Func_032_627C_Table2_Case03
    ret

; entry 1 of the `rst $00` table in Func_032_627C
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wRandomLo, wBattleDamageLo, wBattleDamageHi, wBattleTarget, wLoadSlot
; writes: wBattleDamageLo, wBattleDamageHi, wEffectSubStep, wLoadSlot, wBattleTarget
; points at: wBattleSubStep2, wBattleHP
Func_032_627C_Table2_Case01::
Jump_032_630B:: ; address name
    ld hl, wBattleSubStep2
    inc [hl]
    ld hl, wBattleSubStep2
    inc [hl]
    ld a, [wBattleActor]
    call SetBit0OfLevelUpGainsIndexed_Bank32
    call AdvanceRandom
    ld a, [wRandomLo]
    and a, $01
    jr z, Jump_032_6366
    ld a, [wBattleActor]
    call GetBattleHP_Bank32
    push hl
    ld a, $64
    call DivideHLByA
    ld a, h
    or a, l
    jr nz, Jump_032_6336
    ld hl, $0001

Jump_032_6336::
    pop bc
    ld a, c
    sub a, l
    ld c, a
    ld a, b
    sbc a, h
    ld b, a
    or a, c
    jr nz, Jump_032_6342
    jr Jump_032_6366

Jump_032_6342::
    ld a, c
    ld [wBattleDamageLo], a
    ld a, b
    ld [wBattleDamageHi], a
    ld a, [wBattleTarget]
    ld [wLoadSlot], a
    ld a, [wBattleActor]
    ld [wBattleTarget], a
    ld d, $38
    farcall ShowBattleText
    ld a, [wLoadSlot]
    ld [wBattleTarget], a
    jr Jump_032_637D

Jump_032_6366::
    ld a, [wBattleActor]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank32
    xor a, a
    ld [hl+], a
    ld [hl], a
    ld hl, $03E8
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a

Jump_032_637D::
    ld a, [wBattleActor]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank32
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wBattleDamageHi]
    ld b, a
    ld a, e
    sub a, c
    ld e, a
    ld a, d
    sbc a, b
    ld d, a
    jr c, Jump_032_63A0
    ld a, d
    ld [hl-], a
    ld [hl], e
    or a, e
    jr nz, Jump_032_63AB
    inc hl

Jump_032_63A0::
    xor a, a
    ld [hl-], a
    ld [hl], a
    ld hl, wBattleSubStep2
    dec [hl]
    xor a, a
    ld [wEffectSubStep], a

Jump_032_63AB::
    ret

; entry 2 of the `rst $00` table in Func_032_627C
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleActor, wLoadSlot
; writes: wLoadSlot, wBattleTarget
Func_032_627C_Table2_Case02::
Jump_032_63AC:: ; address name
    ld a, [wBattleTarget]
    ld [wLoadSlot], a
    ld a, [wBattleActor]
    ld [wBattleTarget], a
    call RunEffectSubStep_63C2
    ld a, [wLoadSlot]
    ld [wBattleTarget], a
    ret

; runs the routine for wCFCE (jump table of three) (E-0122)
; 1 call site from 1 routine (e.g. Func_032_627C_Table2_Case02)
; reads: wEffectSubStep
RunEffectSubStep_63C2::
Func_032_63C2:: ; address name
    ld a, [wEffectSubStep]
    rst $00
    dw RunEffectSubStep_63C2_Case00
    dw RunEffectSubStep_63C2_Case01
    dw RunEffectSubStep_63C2_Case02

; entry 0 of the `rst $00` table in RunEffectSubStep_63C2
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; points at: wEffectSubStep, wSlotMarks
RunEffectSubStep_63C2_Case00::
Jump_032_63CC:: ; address name
    ld hl, wEffectSubStep
    inc [hl]
    ld a, [wBattleTarget]
    ld hl, wSlotMarks
    add_a_to_hl
    ld [hl], $FE
    call DefeatTarget
    ret

; entry 1 of the `rst $00` table in RunEffectSubStep_63C2
; no direct call (reached through a table, a jump or a vector)
; points at: wEffectSubStep
RunEffectSubStep_63C2_Case01::
Jump_032_63E1:: ; address name
    call BlankTargetMonsterPicture
    ld hl, wEffectSubStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunEffectSubStep_63C2
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleActionId, wSavedActorByte, wSavedActorSlot
; writes: wEffectSubStep, wBattleActor, wBattleSubPhase, wBattleResolveStep, wBattleSubStep2, wSavedActorByte
RunEffectSubStep_63C2_Case02::
Jump_032_63E9:: ; address name
    ld a, [wBattleTarget]
    call SetBit2OfLevelUpGainsIndexed_Bank32
    ld a, [wBattleActionId]
    cp a, $7B
    ld d, $8C
    jr z, Jump_032_6401
    ld d, $90
    call ActorOnLocalSide_Bank32
    jr c, Jump_032_6401
    ld d, $8D

Jump_032_6401::
    farcall ShowBattleText
    xor a, a
    ld [wEffectSubStep], a

; entry 3 of the `rst $00` table in Func_032_627C
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActionId, wSavedActorByte, wSavedActorSlot
; writes: wBattleActor, wBattleSubPhase, wBattleResolveStep, wBattleSubStep2, wSavedActorByte, wEffectSubStep
Func_032_627C_Table2_Case03::
Jump_032_640B:: ; address name
    ld a, [wBattleActionId]
    cp a, $D6
    jr nz, Jump_032_642E
    ld a, [wSavedActorByte]
    bit 0, a
    jr z, Jump_032_6421
    ld a, [wSavedActorSlot]
    ld [wBattleActor], a
    jr Jump_032_642E

Jump_032_6421::
    inc a
    ld [wSavedActorByte], a
    xor a, a
    ld [wBattleSubStep2], a
    xor a, a
    ld [wEffectSubStep], a
    ret

Jump_032_642E::
    ld a, $06
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleSubStep2], a
    ret

; entry 6 of the `rst $00` table in ResolveStep0EEffect
; no direct call (reached through a table, a jump or a vector)
ResolveStep0EEffect_Case06::
Jump_032_643C:: ; address name
    ret

; entry 9 of the `rst $00` table in ResolveStep0EEffect
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleSubStep2
ResolveStep0EEffect_Case09::
Jump_032_643D:: ; address name
    ld a, [wBattleSubStep2]
    rst $00
    dw ResolveStep0EEffect_Case09_Case00
    dw ResolveStep0EEffect_Case09_Case01
    dw ResolveStep0EEffect_Case09_Case02
    dw ResolveStep0EEffect_Case09_Case03

; entry 0 of the `rst $00` table in ResolveStep0EEffect_Case09
; no direct call (reached through a table, a jump or a vector)
; writes: wEffectFlags, wEffectFlags2
; points at: wBattleSubStep2
ResolveStep0EEffect_Case09_Case00::
Jump_032_6449:: ; address name
    ld hl, wBattleSubStep2
    inc [hl]
    call SkipTurnIfActorAbsent
    ret c
    ld a, $20
    ld [wEffectFlags], a
    farcall SelectEffectByEffectFlags
    ld a, $08
    ld [wEffectFlags2], a
    farcall SelectEffectByEffectFlags2Flags
    ret

; entry 1 of the `rst $00` table in ResolveStep0EEffect_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wBattleDamageLo, wBattleDamageHi, wBattleTarget, wEffectTemp0, wEffectTemp1, wTemp0, wLoadSlot
; writes: wEffectTemp0, wEffectTemp1, wEffectSubStep, wTemp0, wLoadSlot, wBattleTarget, wBattleDamageLo, wBattleDamageHi
; points at: wBattleSubStep2, wBattleHP, wTemp0
ResolveStep0EEffect_Case09_Case01::
Jump_032_6468:: ; address name
    ld hl, wBattleSubStep2
    inc [hl]
    ld hl, wBattleSubStep2
    inc [hl]
    ld a, [wBattleActor]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank32
    push hl
    deref_hl
    push hl
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    srl h
    rr l
    srl h
    rr l
    ld a, l
    ld [wEffectTemp0], a
    ld a, h
    ld [wEffectTemp1], a
    ld a, l
    or a, h
    jr nz, Jump_032_64A5
    ld hl, $0001
    ld a, l
    ld [wEffectTemp0], a
    ld a, h
    ld [wEffectTemp1], a

Jump_032_64A5::
    pop bc
    ld a, c
    sub a, l
    ld c, a
    ld a, b
    sbc a, h
    ld b, a
    jr c, Jump_032_64B3
    or a, c
    jr z, Jump_032_64B3
    jr Jump_032_64B6

Jump_032_64B3::
    ld bc, $0000

Jump_032_64B6::
    pop hl
    ld a, c
    ld [hl+], a
    ld [hl], b
    or a, c
    jr nz, Jump_032_64C5
    ld hl, wBattleSubStep2
    dec [hl]
    xor a, a
    ld [wEffectSubStep], a

Jump_032_64C5::
    ld a, $35
    ld [wTemp0], a
    call ActorOnLocalSide_Bank32
    jr nc, Jump_032_64D3
    ld hl, wTemp0
    inc [hl]

Jump_032_64D3::
    ld a, [wBattleTarget]
    ld [wLoadSlot], a
    ld a, [wBattleActor]
    ld [wBattleTarget], a
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    push hl
    ld a, [wEffectTemp0]
    ld l, a
    ld a, [wEffectTemp1]
    ld h, a
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    ld a, [wTemp0]
    ld d, a
    farcall ShowBattleText
    pop hl
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    ld a, [wLoadSlot]
    ld [wBattleTarget], a
    ld a, [wBattleActor]
    call SetBit0OfLevelUpGainsIndexed_Bank32
    ret

; entry 2 of the `rst $00` table in ResolveStep0EEffect_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleActor, wLoadSlot
; writes: wLoadSlot, wBattleTarget
ResolveStep0EEffect_Case09_Case02::
Jump_032_6518:: ; address name
    ld a, [wBattleTarget]
    ld [wLoadSlot], a
    ld a, [wBattleActor]
    ld [wBattleTarget], a
    call RunEffectSubStep_652E
    ld a, [wLoadSlot]
    ld [wBattleTarget], a
    ret

; runs the routine for wCFCE (jump table of three) (E-0122)
; 1 call site from 1 routine (e.g. ResolveStep0EEffect_Case09_Case02)
; reads: wEffectSubStep
RunEffectSubStep_652E::
Func_032_652E:: ; address name
    ld a, [wEffectSubStep]
    rst $00
    dw RunEffectSubStep_652E_Case00
    dw RunEffectSubStep_652E_Case01
    dw RunEffectSubStep_652E_Case02

; entry 0 of the `rst $00` table in RunEffectSubStep_652E
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; points at: wEffectSubStep, wSlotMarks
RunEffectSubStep_652E_Case00::
Jump_032_6538:: ; address name
    ld hl, wEffectSubStep
    inc [hl]
    ld a, [wBattleTarget]
    ld hl, wSlotMarks
    add_a_to_hl
    ld [hl], $FE
    call DefeatTarget
    ret

; entry 1 of the `rst $00` table in RunEffectSubStep_652E
; no direct call (reached through a table, a jump or a vector)
; points at: wEffectSubStep
RunEffectSubStep_652E_Case01::
Jump_032_654D:: ; address name
    call BlankTargetMonsterPicture
    ld hl, wEffectSubStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunEffectSubStep_652E
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wTemp0
; writes: wTemp0, wEffectSubStep
; points at: wBattleSubStep2
RunEffectSubStep_652E_Case02::
Jump_032_6555:: ; address name
    ld a, [wBattleTarget]
    call SetBit2OfLevelUpGainsIndexed_Bank32
    ld a, $90
    ld [wTemp0], a
    call ActorOnLocalSide_Bank32
    jr c, Jump_032_656A
    ld a, $8D
    ld [wTemp0], a

Jump_032_656A::
    ld a, [wTemp0]
    ld d, a
    farcall ShowBattleText
    ld hl, wBattleSubStep2
    inc [hl]
    xor a, a
    ld [wEffectSubStep], a
    ret

; entry 3 of the `rst $00` table in ResolveStep0EEffect_Case09
; no direct call (reached through a table, a jump or a vector)
ResolveStep0EEffect_Case09_Case03::
Jump_032_657D:: ; address name
    call SetBattleSubStep1
    ret

; only called from ActionEffect_Surge (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Surge)
; reads: wBattleTarget, wBattleStatResultLo, wBattleStatResultHi
; points at: wBattleStatus, wBattleAGL, wBattleDEF
ActionEffect_Surge_Sub01::
Func_032_6581:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    and a, $D0
    call nz, SetTargetSlotMarksTo3
    xor a, a
    ld [hl+], a
    ld a, [wBattleTarget]
    call SetBit2OfLevelUpGainsIndexed_Bank32
    ld a, [hl]
    and a, $3C
    ld [hl+], a
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    and a, $FC
    ld [hl], a
    inc hl
    push hl
    inc hl
    inc hl
    res 7, [hl]
    pop hl
    bit 7, [hl]
    ret z
    res 7, [hl]
    ld a, [wBattleTarget]
    ld c, a
    farcall GetBaseAGL
    ld a, [wBattleTarget]
    ld hl, wBattleAGL
    add a, a
    add_a_to_hl
    push hl
    deref_hl
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleStatResultHi]
    ld b, a
    call CompareHLToBC
    pop hl
    jr nc, Jump_032_65DF
    ld a, [wBattleStatResultLo]
    ld [hl+], a
    ld a, [wBattleStatResultHi]
    ld [hl], a

Jump_032_65DF::
    ld a, [wBattleTarget]
    ld c, a
    farcall GetBaseDEF
    ld a, [wBattleTarget]
    ld hl, wBattleDEF
    add a, a
    add_a_to_hl
    push hl
    deref_hl
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleStatResultHi]
    ld b, a
    call CompareHLToBC
    pop hl
    ret nc
    ld a, [wBattleStatResultLo]
    ld [hl+], a
    ld a, [wBattleStatResultHi]
    ld [hl], a
    ret

; wDA5B[wBattleTarget] = 3; BC, HL kept (E-0118)
; 3 call sites from 2 routines (e.g. ActionEffect_Surge_Sub01, ActionEffect_DeMagic_Sub01)
; reads: wBattleTarget
; points at: wSlotMarks
SetTargetSlotMarksTo3::
Func_032_660F:: ; address name
    push hl
    push bc
    ld a, [wBattleTarget]
    ld hl, wSlotMarks
    add_a_to_hl
    ld [hl], $03
    pop bc
    pop hl
    ret
    db $C9

; only called from ActionEffect_DeMagic (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_DeMagic)
; reads: wBattleTarget
; points at: wBattleStatus
ActionEffect_DeMagic_Sub01::
Func_032_6622:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    and a, $90
    call nz, SetTargetSlotMarksTo3
    ld a, [hl]
    and a, $63
    ld [hl], a
    ld a, [wBattleTarget]
    call SetBit2OfLevelUpGainsIndexed_Bank32
    inc hl
    ld a, [hl]
    and a, $30
    ld [hl], a
    inc hl
    xor a, a
    ld [hl+], a
    ld a, [hl]
    and a, $F7
    ld [hl+], a
    ld a, [hl]
    and a, $FF
    ld [hl+], a
    ld a, [hl]
    and a, $C0
    call nz, SetTargetSlotMarksTo3
    ld a, [hl]
    and a, $33
    ld [hl+], a
    ld a, [hl]
    and a, $37
    ld [hl+], a
    ld a, [hl]
    and a, $FB
    ld [hl+], a
    ld a, [hl]
    and a, $3F
    ld [hl], a
    ret

; runs the routine for wBattleSubStep (jump table of three) (E-0122)
; 1 call site from 1 routine (e.g. RunBattleResolveStep_69AA_Case05)
; reads: wBattleSubStep
RunBattleSubStep_6662::
Func_032_6662:: ; address name
    ld a, [wBattleSubStep]
    rst $00
    dw RunBattleSubStep_6662_Case00
    dw RunBattleSubStep_6662_Case01
    dw RunBattleSubStep_6662_Case02

; entry 0 of the `rst $00` table in RunBattleSubStep_6662
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleSubStep
RunBattleSubStep_6662_Case00::
Jump_032_666C:: ; address name
    ld hl, wBattleSubStep
    inc [hl]
    farcall SelectEffectByEffectFlags
    farcall SelectEffectByEffectFlags2Flags
    ret

; entry 1 of the `rst $00` table in RunBattleSubStep_6662
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleDamageLo, wBattleDamageHi, wBattleActor
; writes: wBattleSubStep2, wBattleTarget, wBattleActor, wBattleSubStep
; points at: wBattleHP, wBattleSubStep, wBattleResolveStep
RunBattleSubStep_6662_Case01::
Jump_032_667D:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank32
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wBattleDamageHi]
    ld b, a
    ld a, e
    sub a, c
    ld e, a
    ld a, d
    sbc a, b
    ld d, a
    jr c, Jump_032_66A0
    ld a, d
    ld [hl-], a
    ld [hl], e
    or a, e
    jr nz, Jump_032_66AD
    inc hl

Jump_032_66A0::
    xor a, a
    ld [hl-], a
    ld [hl], a
    ld hl, wBattleSubStep
    inc [hl]
    xor a, a
    ld [wBattleSubStep2], a
    jr Jump_032_66B5

Jump_032_66AD::
    xor a, a
    ld [wBattleSubStep], a
    ld hl, wBattleResolveStep
    inc [hl]

Jump_032_66B5::
    ld a, [wBattleTarget]
    call SetBit0OfLevelUpGainsIndexed_Bank32
    call ActorOnLocalSide_Bank32
    ld d, $35
    jr c, Jump_032_66C4
    ld d, $36

Jump_032_66C4::
    farcall ShowBattleText
    ld a, [wBattleActor]
    ld l, a
    ld a, [wBattleTarget]
    ld h, a
    ld a, l
    ld [wBattleTarget], a
    ld a, h
    ld [wBattleActor], a
    ret

; entry 2 of the `rst $00` table in RunBattleSubStep_6662
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleActor, wLoadSlot
; writes: wLoadSlot, wBattleTarget
RunBattleSubStep_6662_Case02::
Jump_032_66DB:: ; address name
    ld a, [wBattleTarget]
    ld [wLoadSlot], a
    ld a, [wBattleActor]
    ld [wBattleTarget], a
    call RunBattleSubStep2_66F1
    ld a, [wLoadSlot]
    ld [wBattleTarget], a
    ret

; runs the routine for wBattleSubStep2 (jump table of three) (E-0122)
; 1 call site from 1 routine (e.g. RunBattleSubStep_6662_Case02)
; reads: wBattleSubStep2
RunBattleSubStep2_66F1::
Func_032_66F1:: ; address name
    ld a, [wBattleSubStep2]
    rst $00
    dw RunBattleSubStep2_66F1_Case00
    dw RunBattleSubStep2_66F1_Case01
    dw RunBattleSubStep2_66F1_Case02

; entry 0 of the `rst $00` table in RunBattleSubStep2_66F1
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; points at: wBattleSubStep2, wSlotMarks
RunBattleSubStep2_66F1_Case00::
Jump_032_66FB:: ; address name
    ld hl, wBattleSubStep2
    inc [hl]
    ld a, [wBattleTarget]
    ld hl, wSlotMarks
    add_a_to_hl
    ld [hl], $FE
    call DefeatTarget
    ret

; entry 1 of the `rst $00` table in RunBattleSubStep2_66F1
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleSubStep2
RunBattleSubStep2_66F1_Case01::
Jump_032_6710:: ; address name
    call BlankTargetMonsterPicture
    ld hl, wBattleSubStep2
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunBattleSubStep2_66F1
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wTemp0
; writes: wTemp0, wBattleSubStep2, wBattleSubStep, wDefeatFlagsBA
; points at: wBattleResolveStep
RunBattleSubStep2_66F1_Case02::
Jump_032_6718:: ; address name
    ld a, [wBattleTarget]
    call SetBit2OfLevelUpGainsIndexed_Bank32
    ld a, $8A
    ld [wTemp0], a
    call ActorOnLocalSide_Bank32
    jr c, Jump_032_672D
    ld a, $8B
    ld [wTemp0], a

Jump_032_672D::
    ld a, [wTemp0]
    ld d, a
    farcall ShowBattleText
    xor a, a
    ld [wBattleSubStep2], a
    xor a, a
    ld [wBattleSubStep], a
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, $81
    ld [wDefeatFlagsBA], a
    ret

; when the actor's slot is absent (CarryUnlessBattleSlotOutSlotEmpty) runs SetBattleSubStep1 and returns carry set; otherwise returns carry clear (E-0115)
; 3 call sites from 3 routines (e.g. ResolveStep0EEffect_Case03_Case00, ResolveStep0EEffect_Case04_Case00, ResolveStep0EEffect_Case09_Case00)
; reads: wBattleActor
SkipTurnIfActorAbsent::
Func_032_6749:: ; address name
    ld a, [wBattleActor]
    call CarryUnlessBattleSlotOutSlotEmpty
    ret nc
    call SetBattleSubStep1
    scf
    ret

; HL = HL * 8 / 10 (24-bit intermediate; Multiply8By16 then Divide24ByA), A = the remainder; DE kept (E-0067) (the same 15 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. ResolveStep0EEffect_Case03_Case01)
ScaleHLTo80Percent_Bank32::
Func_032_6755:: ; address name
    push de
    ld b, h
    ld c, l
    ld a, $08
    call Multiply8By16
    ld a, $0A
    call Divide24ByA
    pop de
    ret

; runs the routine for wBattleSubStep2 (jump table of three) (E-0122)
; 1 call site from 1 routine (e.g. Func_03B_42F4_Case09)
; reads: wBattleSubStep2
RunBattleSubStep2_6764::
Func_032_6764:: ; address name
    ld a, [wBattleSubStep2]
    rst $00
    dw RunBattleSubStep2_6764_Case00
    dw RunBattleSubStep2_6764_Case01
    dw RunBattleSubStep2_6764_Case02

; entry 0 of the `rst $00` table in RunBattleSubStep2_6764
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; points at: wBattleSubStep2, wSlotMarks
RunBattleSubStep2_6764_Case00::
Jump_032_676E:: ; address name
    ld hl, wBattleSubStep2
    inc [hl]
    ld a, [wBattleTarget]
    ld hl, wSlotMarks
    add_a_to_hl
    ld a, [hl]
    add a, $FB
    ld [hl], a
    call DefeatTarget
    ret

; entry 1 of the `rst $00` table in RunBattleSubStep2_6764
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleSubStep2
RunBattleSubStep2_6764_Case01::
Jump_032_6785:: ; address name
    call BlankTargetMonsterPicture
    ld hl, wBattleSubStep2
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunBattleSubStep2_6764
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wBattleSubStep2
; points at: wBattleResolveStep
RunBattleSubStep2_6764_Case02::
Jump_032_678D:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    xor a, a
    ld [wBattleSubStep2], a
    ld a, [wBattleTarget]
    call SetBit2OfLevelUpGainsIndexed_Bank32
    ld d, $8B
    call TargetOnLocalSide_Bank32
    jr nc, Jump_032_67A3
    dec d

Jump_032_67A3::
    farcall ShowBattleText
    ret

; only called from ResolveStepDamageMessage (E-0047)
; 1 call site from 1 routine (e.g. ResolveStepDamageMessage)
; reads: wBattleTarget, wBattleDamageLo, wBattleDamageHi
; writes: wBattleDamageLo, wBattleDamageHi
; points at: wBattleStatus7
ResolveStepDamageMessage_Sub01::
Func_032_67AA:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleStatus7
    call AddAx9ToHL
    ld a, [hl]
    push af
    and a, $F0
    ld [hl], a
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    pop af
    bit 0, a
    jr z, Jump_032_67CF
    add hl, hl
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    ret

Jump_032_67CF::
    bit 1, a
    jr z, Jump_032_67E2
    ld e, l
    ld d, h
    add hl, hl
    add hl, hl
    add hl, de
    add hl, hl
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    ret

Jump_032_67E2::
    bit 2, a
    ret z
    add hl, hl
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    ret
    db $21, $FF, $D8, $18, $28, $21, $0F, $D9, $18, $23, $21, $CF, $D8, $18, $1E

; A = battle slot: HL = the word for that slot at wBattleMaxMP; A = its low byte (E-0064)
; 1 call site from 1 routine (e.g. ActorLosesSixthOfMaxMP)
; points at: wBattleMaxMP
GetBattleMaxMP_Bank32::
Func_032_67FE:: ; address name
    ld hl, wBattleMaxMP
    jr Jump_032_681C

; A = battle slot: HL = the word for that slot at wBattleHP; A = its low byte (E-0064)
; 4 call sites from 4 routines (e.g. RecomputeTargetMaxHPAndMP, Func_032_4ADC_Case00_Case02, RollStatusTickEffect, Func_032_627C_Table2_Case01)
; points at: wBattleHP
GetBattleHP_Bank32::
Func_032_6803:: ; address name
    ld hl, wBattleHP
    jr Jump_032_681C

; A = battle slot: HL = the word for that slot at wBattleMP; A = its low byte (E-0064)
; 2 call sites from 2 routines (e.g. RecomputeTargetMaxHPAndMP, CheckSkillMPCost)
; points at: wBattleMP
GetBattleMP_Bank32::
Func_032_6808:: ; address name
    ld hl, wBattleMP
    jr Jump_032_681C
    db $21, $1F, $D9, $18, $0A

; A = the byte at wDA53 + A; clobbers HL (the same 10 bytes appear in 5 banks)
; 6 call sites from 5 routines (e.g. CheckSkillMPCost, CheckActorStatusAndFoeTargets, CheckActorStatusBit7AndFoeBit6, Func_032_4ADC_Case01_Case02, ...)
; points at: wSlotAIMode
ReadSlotAIModeIndexed_Bank32::
Func_032_6812:: ; address name
    ld hl, wSlotAIMode
    add_a_to_hl
    ld a, [hl]
    ret

Jump_032_681C::
    add a, a
    add_a_to_hl
    deref_hl
    ret

; HL += 2 * A (A is doubled in 8 bits first, so it wraps above $7F); clobbers A (the same 7 bytes appear in 12 banks)
; 19 call sites from 10 routines (e.g. RecomputeTargetMaxHPAndMP, Func_032_5820_Case00, Func_032_4ADC_Case08, RunBattleSubStep_6662_Case01, ...)
AddDoubleAToHL_Bank32::
Func_032_6826:: ; address name
    add a, a
    add_a_to_hl
    ret

; carry set when wBattleActor < 4 (slots 0-3); when wC58A = 1 and wC57F bit 1 is set the test is reversed (carry set when wBattleActor >= 4). Which side is local is inferred from the reversal, not checked (E-0064) (the same 27 bytes appear in 12 banks)
; 9 call sites from 9 routines (e.g. RunBattleSubStep_6662_Case01, RunDefeatSequence_Case02, RunBattleSubStep2_66F1_Case02, ResolveStep0EEffect_Case03_Case01, ...)
; reads: wLinkMode, wLinkRole, wBattleActor
ActorOnLocalSide_Bank32::
Func_032_682D:: ; address name
    ld a, [wLinkMode]
    cp a, $01
    jr nz, Jump_032_6842
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_032_6842
    ld a, [wBattleActor]
    cp a, $04
    ccf
    ret

Jump_032_6842::
    ld a, [wBattleActor]
    cp a, $04
    ret

; carry set when wBattleTarget < 4 (slots 0-3); when wC58A = 1 and wC57F bit 1 is set the test is reversed (carry set when wBattleTarget >= 4) (E-0064) (the same 27 bytes appear in 12 banks)
; 3 call sites from 3 routines (e.g. RunBattleSubStep2_6764_Case02, ResolveStep0EEffect_Case00, RunDefeatSequence_Case02)
; reads: wLinkMode, wLinkRole, wBattleTarget
TargetOnLocalSide_Bank32::
Func_032_6848:: ; address name
    ld a, [wLinkMode]
    cp a, $01
    jr nz, Jump_032_685D
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_032_685D
    ld a, [wBattleTarget]
    cp a, $04
    ccf
    ret

Jump_032_685D::
    ld a, [wBattleTarget]
    cp a, $04
    ret

; no direct call (reached through a table, a jump or a vector)
; points at: wBattleStatus
ClearBattleStatusBitsWithMaskD_Bank32:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:4075; C0
Func_032_6863:: ; address name
    ld a, d
    ld hl, Data_032_6878
    add_a_to_hl
    ld d, [hl]
    ld a, e
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, d
    and a, [hl]
    ld [hl], a
    ret

; address loaded by ClearBattleStatusBitsWithMaskD_Bank32
Data_032_6878:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $DF, $FE, $00, $FD, $73, $EF, $BF

; Sets bit 0 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 12 banks)
; 7 call sites from 7 routines (e.g. RunBattleSubStep_6662_Case01, RollStatusTickEffect, ApplyDamageToTarget, ResolveStep0EEffect_Case03_Case01, ...)
; points at: wLevelUpGains
SetBit0OfLevelUpGainsIndexed_Bank32::
Func_032_687F:: ; address name
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 0, [hl]
    pop hl
    ret

; Sets bit 1 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 12 banks)
; 3 call sites from 3 routines (e.g. PayActorMPCost, RollStatusTickEffect, ApplyDamageToTarget)
; points at: wLevelUpGains
SetBit1OfLevelUpGainsIndexed_Bank32::
Func_032_688C:: ; address name
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 1, [hl]
    pop hl
    ret

; Sets bit 2 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 12 banks)
; 16 call sites from 14 routines (e.g. ActionEffect_Surge_Sub01, ActionEffect_DeMagic_Sub01, DefeatTarget, RunBattleSubStep2_6764_Case02, ...)
; points at: wLevelUpGains
SetBit2OfLevelUpGainsIndexed_Bank32::
Func_032_6899:: ; address name
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 2, [hl]
    pop hl
    ret

; A = slot 0-7: returns A = 9 * g(wD968[A]) + 3 * g(wD970[A]) + g(wD978[A]) with g(v) = 0 for v >= $C0, 1 for v >= $40, else 2 (the same index PersonalityIndexOfRecord builds from a save record; E-0031); HL and BC are kept (the same 87 bytes appear in 13 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wSlotPersonalityHi, wSlotPersonalityMid, wSlotPersonalityLo
PersonalityIndexOfSlot_Bank32:: ; heuristic: follows a terminator; C0
Func_032_68A6:: ; address name
    push hl
    push bc
    ld c, a
    ld b, $00
    ld hl, wSlotPersonalityHi
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_032_68C2
    ld l, $09
    cp a, $40
    jr nc, Jump_032_68C2
    ld l, $12

Jump_032_68C2::
    ld a, l
    add a, b
    ld b, a
    ld a, c
    ld hl, wSlotPersonalityMid
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_032_68DD
    ld l, $03
    cp a, $40
    jr nc, Jump_032_68DD
    ld l, $06

Jump_032_68DD::
    ld a, l
    add a, b
    ld b, a
    ld a, c
    ld hl, wSlotPersonalityLo
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_032_68F8
    ld l, $01
    cp a, $40
    jr nc, Jump_032_68F8
    ld l, $02

Jump_032_68F8::
    ld a, l
    add a, b
    pop bc
    pop hl
    ret

; A = slot: carry set when CheckSlotStatusBlock sets it, or when status byte 3 & $C0 or byte 4 & $0C is set (wD80F + 9 * A); otherwise carry clear; A, BC, HL kept (E-0067) (the same 31 bytes appear in 12 banks)
; 2 call sites from 1 routine (e.g. CheckFormationPartnersCanAct)
; points at: wBattleStatus3
CheckSlotStatusBlockWide_Bank32::
Func_032_68FD:: ; address name
    call CheckSlotStatusBlock
    ret c
    push hl
    push bc
    ld c, a
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_032_6917
    ld a, [hl]
    and a, $0C
    jr nz, Jump_032_6917
    xor a, a
    jr Jump_032_6918

Jump_032_6917::
    scf

Jump_032_6918::
    ld a, c
    pop bc
    pop hl
    ret

; A = slot: with HL = wD80F + 9 * A (status byte 3 of wBattleStatus), A = byte 3 & $C0, or byte 4 & $0C when that is zero; Z set when both are clear; HL kept (E-0067) (the same 17 bytes appear in 13 banks)
; 2 call sites from 1 routine (e.g. ApplyActionResultAndMarkFormation)
; points at: wBattleStatus3
SlotHasStatus3Or4Bits_Bank32::
Func_032_691C:: ; address name
    push hl
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_032_692B
    ld a, [hl]
    and a, $0C

Jump_032_692B::
    pop hl
    ret
    ds $111C, $00

; entry 7 of the `rst $00` table in Func_032_4ADC_Case01
; no direct call (reached through a table, a jump or a vector)
Func_032_4ADC_Case01_Case07::
Jump_032_7A49:: ; address name
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
