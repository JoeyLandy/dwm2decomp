; ROM bank $32: battle action steps and resolve steps
; The annotated listing of this bank is build/listing/bank32.asm.

SECTION "Bank 32", ROMX[$4000], BANK[$32]
    db $32

; One tick of the animation sequence record at wSequencePtrLo and wSequencePtrHi (bytes: 0 started
; flag, 2 list number, 3 frame index, 4 frame code, 5 frame timer). When byte 0 is non-zero it runs
; the frame timer (CountDownSequencePtrLoFrameTimer); when it is zero it sets byte 0 to 1, clears
; the frame index (byte 3) and loads frame 0 (TickSequencePtrLoSequence_LoadFrame). Called by
; GameMode4_Update and GameMode7_Update (link modes, every frame while wEffectAnimState is 2),
; RunBattleEffectAnimation, SelectEffectByEffectFlags_StartAnimation and the debug effect viewer;
; the starters point wSequencePtrLo and wSequencePtrHi at wEffectAnimId and set that byte to 0
; first, so the first tick starts the sequence. (C2, E-0380)
; for the sequence at wSequencePtrLo: runs the frame timer (CountDownSequencePtrLoFrameTimer) when
; started, otherwise marks it started, clears byte 4 and loads the first frame
; (TickSequencePtrLoSequence_LoadFrame) (E-0124)
TickSequencePtrLoSequence::
    ld a, [wSequencePtrLo]
    ld l, a
    ld a, [wSequencePtrHi]
    ld h, a
    ld a, [hl]
    or a
    jr z, .skip
    call CountDownSequencePtrLoFrameTimer
    jr .return

.skip:
    inc [hl]
    inc hl
    inc hl
    inc hl
    ld [hl], $00
    call TickSequencePtrLoSequence_LoadFrame

.return:
    ret

; Frame timer of the sequence record at wSequencePtrLo and wSequencePtrHi (byte 5): $FF holds the
; frame (returns at once), 0 advances to the next frame
; (CountDownSequencePtrLoFrameTimer_NextFrame), any other value is counted down by one. Called only
; by TickSequencePtrLoSequence while byte 0 is non-zero. (C2, E-0380)
; counts down byte 5 of the wSequencePtrLo sequence ($FF = hold); at zero advances byte 3 (E-0124)
CountDownSequencePtrLoFrameTimer::
    ld a, [wSequencePtrLo]
    add $05
    ld l, a
    ld a, [wSequencePtrHi]
    adc $00
    ld h, a
    ld a, [hl]
    cp $ff
    ret z
    or a
    jr z, CountDownSequencePtrLoFrameTimer_NextFrame
    dec a
    ld [hld], a
    ret

; Advances the frame index (byte 3) of the sequence at wSequencePtrLo and falls into
; TickSequencePtrLoSequence_LoadFrame to load that frame. Reached when the frame timer (byte 5)
; reaches 0 in CountDownSequencePtrLoFrameTimer and for the frame codes $FE and $FD. (C2, E-0372;
; probed E-0380)
CountDownSequencePtrLoFrameTimer_NextFrame::
    ld a, [wSequencePtrLo]
    add $03
    ld l, a
    ld a, [wSequencePtrHi]
    adc $00
    ld h, a
    inc [hl]

; Reads the sequence's current frame word into BC (LookupSequencePtrLoFrameWord): $FFFF ends the
; sequence (byte 0 cleared); low byte $FE moves the frame index (byte 3) back by B and advances
; (CountDownSequencePtrLoFrameTimer_NextFrame); $FD just advances; any other word is stored in bytes
; 4-5 (C, then B, the count that CountDownSequencePtrLoFrameTimer counts down). (C2, E-0372; probed
; E-0380)
TickSequencePtrLoSequence_LoadFrame::
    call LookupSequencePtrLoFrameWord
    ld a, b
    and c
    cp $ff
    jr nz, .skip
    ld a, [wSequencePtrLo]
    ld l, a
    ld a, [wSequencePtrHi]
    ld h, a
    ld [hl], $00
    ret

.skip:
    ld a, c
    cp $f8
    jr c, .read_sequence_ptr_lo
    cp $fe
    jr nz, .cp_FD
    ld a, [wSequencePtrLo]
    add $03
    ld l, a
    ld a, [wSequencePtrHi]
    adc $00
    ld h, a
    ld a, [hl]
    sub b
    ld [hl], a
    jr CountDownSequencePtrLoFrameTimer_NextFrame

.cp_FD:
    cp $fd
    jr nz, .read_sequence_ptr_lo
    jr CountDownSequencePtrLoFrameTimer_NextFrame

.read_sequence_ptr_lo:
    ld a, [wSequencePtrLo]
    add $04
    ld l, a
    ld a, [wSequencePtrHi]
    adc $00
    ld h, a
    ld a, c
    ld [hli], a
    ld [hl], b
    ret

; Returns BC = the current frame word of the sequence record at wSequencePtrLo and wSequencePtrHi: C
; = its first byte (the frame code) and B = its second byte (the timer, or the step-back count for
; $FE). It reads the list pointer from SequenceFrameTable at 2 * byte 2 of the record, then the word
; at 2 * byte 3 (the frame index) of that list; both doublings are done in 8 bits, so a byte above
; $7F wraps. Called only by TickSequencePtrLoSequence_LoadFrame. (C2, E-0380)
; BC = word ([seq + 3]) of the table SequenceFrameTable[[seq + 2]] (E-0124)
LookupSequencePtrLoFrameWord::
    ld a, [wSequencePtrLo]
    ld c, a
    ld a, [wSequencePtrHi]
    ld b, a
    inc bc
    inc bc
    ld a, [bc]
    add a
    ld hl, SequenceFrameTable
    add_a_to_hl
    deref_hl
    inc bc
    ld a, [bc]
    add a
    add_a_to_hl
    ld a, [hli]
    ld b, [hl]
    ld c, a
    ret

; LookupSequencePtrLoFrameWord reads the word at $40A6 + 2 * [seq + 2], then the word at 2 * [seq +
; 3] of that list; TickSequencePtrLoSequence_LoadFrame ends the sequence at $FFFF, steps back B
; entries when the low byte is $FE, and otherwise stores the word at seq + 4 (frame, then the timer
; CountDownSequencePtrLoFrameTimer counts down); 60 lists from $411E to $4ADC, each ending with
; $FFFF (E-0240, C1)
; record: frame list of this sequence
SequenceFrameTable::
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

; list for entry $00 of SequenceFrameTable; it runs to the next list (E-0199)
; record: frame, timer
SequenceFrames000::
    db $00, $05 ; id 0
    db $01, $05 ; id 1
    db $02, $05 ; id 2
    db $03, $05 ; id 3
    db $04, $02 ; id 4
    db $05, $02 ; id 5
    db $06, $02 ; id 6
    db $07, $02 ; id 7
    db $1f, $02 ; id 8
    db $ff, $ff ; id 9

; list for entry $01 of SequenceFrameTable; it runs to the next list (E-0199)
SequenceFrames001::
    db $00, $04 ; id 0
    db $01, $04 ; id 1
    db $02, $04 ; id 2
    db $03, $04 ; id 3
    db $04, $02 ; id 4
    db $05, $02 ; id 5
    db $06, $02 ; id 6
    db $07, $02 ; id 7
    db $1f, $08 ; id 8
    db $08, $03 ; id 9
    db $09, $03 ; id 10
    db $0a, $03 ; id 11
    db $0b, $03 ; id 12
    db $0c, $03 ; id 13
    db $09, $03 ; id 14
    db $0a, $03 ; id 15
    db $0b, $02 ; id 16
    db $0c, $02 ; id 17
    db $0d, $02 ; id 18
    db $0e, $02 ; id 19
    db $1f, $02 ; id 20
    db $ff, $ff ; id 21

; list for entry $02 of SequenceFrameTable; it runs to the next list (E-0199)
SequenceFrames002::
    db $08, $02 ; id 0
    db $09, $05 ; id 1
    db $0a, $05 ; id 2
    db $0b, $05 ; id 3
    db $0c, $02 ; id 4
    db $0d, $02 ; id 5
    db $0e, $02 ; id 6
    db $0f, $02 ; id 7
    db $1f, $08 ; id 8
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
    db $1f, $02 ; id 23
    db $ff, $ff ; id 24

; list for entry $03 of SequenceFrameTable; it runs to the next list (E-0199)
SequenceFrames003::
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
    db $0a, $03 ; id 10
    db $0b, $03 ; id 11
    db $0c, $03 ; id 12
    db $0d, $03 ; id 13
    db $1f, $02 ; id 14
    db $ff, $ff ; id 15

; list for entry $04 of SequenceFrameTable; it runs to the next list (E-0199)
; record: frame, timer
SequenceFrames004::
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
    db $0a, $03 ; id 10
    db $0b, $03 ; id 11
    db $0c, $03 ; id 12
    db $0d, $03 ; id 13
    db $1f, $02 ; id 14
    db $ff, $ff ; id 15

; list for entry $05 of SequenceFrameTable; it runs to the next list (E-0199)
SequenceFrames005::
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
    db $0a, $05 ; id 30
    db $1f, $02 ; id 31
    db $ff, $ff ; id 32

; list for entry $06 of SequenceFrameTable; it runs to the next list (E-0199)
SequenceFrames006::
    db $00, $04 ; id 0
    db $01, $02 ; id 1
    db $02, $04 ; id 2
    db $03, $04 ; id 3
    db $04, $02 ; id 4
    db $00, $02 ; id 5
    db $01, $02 ; id 6
    db $02, $02 ; id 7
    db $01, $02 ; id 8
    db $1f, $02 ; id 9
    db $ff, $ff ; id 10

; list for entry $07 of SequenceFrameTable; it runs to the next list (E-0199)
SequenceFrames007::
    db $00, $02 ; id 0
    db $01, $02 ; id 1
    db $02, $02 ; id 2
    db $1f, $10 ; id 3
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
    db $1f, $02 ; id 16
    db $ff, $ff ; id 17

; list for entry $08 of SequenceFrameTable; it runs to the next list (E-0199)
; record: frame, timer
SequenceFrames008::
    db $00, $02 ; id 0
    db $01, $02 ; id 1
    db $02, $02 ; id 2
    db $03, $02 ; id 3
    db $1f, $10 ; id 4
    db $04, $05 ; id 5
    db $05, $05 ; id 6
    db $06, $05 ; id 7
    db $07, $02 ; id 8
    db $08, $02 ; id 9
    db $0e, $02 ; id 10
    db $09, $02 ; id 11
    db $0f, $02 ; id 12
    db $0e, $02 ; id 13
    db $10, $02 ; id 14
    db $0b, $02 ; id 15
    db $11, $02 ; id 16
    db $0c, $02 ; id 17
    db $10, $02 ; id 18
    db $0b, $02 ; id 19
    db $11, $02 ; id 20
    db $0c, $02 ; id 21
    db $12, $02 ; id 22
    db $0d, $02 ; id 23
    db $13, $02 ; id 24
    db $08, $02 ; id 25
    db $0e, $02 ; id 26
    db $09, $02 ; id 27
    db $0f, $02 ; id 28
    db $0a, $02 ; id 29
    db $10, $02 ; id 30
    db $0b, $02 ; id 31
    db $06, $02 ; id 32
    db $1f, $02 ; id 33
    db $ff, $ff ; id 34

; list for entry $09 of SequenceFrameTable; it runs to the next list (E-0199)
SequenceFrames009::
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
    db $0a, $02 ; id 10
    db $0b, $02 ; id 11
    db $0c, $02 ; id 12
    db $1f, $02 ; id 13
    db $ff, $ff ; id 14

; list for entry $0A of SequenceFrameTable; it runs to the next list (E-0199)
SequenceFrames00A::
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
    db $0a, $05 ; id 10
    db $0b, $04 ; id 11
    db $0c, $05 ; id 12
    db $1f, $02 ; id 13
    db $ff, $ff ; id 14

; list for entry $0B of SequenceFrameTable; it runs to the next list (E-0199)
SequenceFrames00B::
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
    db $0a, $03 ; id 10
    db $0b, $03 ; id 11
    db $0c, $03 ; id 12
    db $0d, $03 ; id 13
    db $0e, $03 ; id 14
    db $0b, $03 ; id 15
    db $0c, $03 ; id 16
    db $0d, $03 ; id 17
    db $0e, $03 ; id 18
    db $0f, $03 ; id 19
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
    db $1a, $03 ; id 30
    db $1f, $03 ; id 31
    db $ff, $ff ; id 32

; list for entry $0C of SequenceFrameTable; it runs to the next list (E-0199)
; record: frame, timer
SequenceFrames00C::
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
    db $0a, $03 ; id 10
    db $0b, $03 ; id 11
    db $0c, $03 ; id 12
    db $0d, $03 ; id 13
    db $0e, $03 ; id 14
    db $0f, $03 ; id 15
    db $10, $03 ; id 16
    db $11, $03 ; id 17
    db $12, $03 ; id 18
    db $1f, $02 ; id 19
    db $ff, $ff ; id 20

; list for entry $0D of SequenceFrameTable; it runs to the next list (E-0199)
SequenceFrames00D::
    db $00, $05 ; id 0
    db $01, $04 ; id 1
    db $02, $04 ; id 2
    db $03, $03 ; id 3
    db $04, $02 ; id 4
    db $03, $02 ; id 5
    db $04, $03 ; id 6
    db $03, $03 ; id 7
    db $04, $0f ; id 8
    db $1f, $03 ; id 9
    db $04, $03 ; id 10
    db $1f, $03 ; id 11
    db $04, $02 ; id 12
    db $1f, $02 ; id 13
    db $ff, $ff ; id 14

; list for entry $0E of SequenceFrameTable; it runs to the next list (E-0199)
SequenceFrames00E::
    db $06, $03 ; id 0
    db $07, $03 ; id 1
    db $08, $02 ; id 2
    db $09, $02 ; id 3
    db $0a, $01 ; id 4
    db $0b, $01 ; id 5
    db $0c, $01 ; id 6
    db $1f, $08 ; id 7
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
    db $1f, $02 ; id 29
    db $ff, $ff ; id 30

; list for entry $0F of SequenceFrameTable; it runs to the next list (E-0199)
SequenceFrames00F::
    db $00, $04 ; id 0
    db $01, $03 ; id 1
    db $1f, $08 ; id 2
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
    db $1f, $02 ; id 14
    db $ff, $ff ; id 15

; list for entry $10 of SequenceFrameTable; it runs to the next list (E-0199)
; record: frame, timer
SequenceFrames010::
    db $00, $04 ; id 0
    db $01, $03 ; id 1
    db $02, $02 ; id 2
    db $1f, $08 ; id 3
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
    db $1f, $02 ; id 21
    db $ff, $ff ; id 22

; list for entry $11 of SequenceFrameTable; it runs to the next list (E-0199)
SequenceFrames011::
    db $00, $03 ; id 0
    db $01, $03 ; id 1
    db $02, $02 ; id 2
    db $03, $03 ; id 3
    db $02, $01 ; id 4
    db $0f, $02 ; id 5
    db $04, $03 ; id 6
    db $05, $03 ; id 7
    db $06, $03 ; id 8
    db $07, $02 ; id 9
    db $08, $02 ; id 10
    db $09, $02 ; id 11
    db $0a, $01 ; id 12
    db $0b, $01 ; id 13
    db $0c, $01 ; id 14
    db $0d, $01 ; id 15
    db $06, $03 ; id 16
    db $07, $02 ; id 17
    db $0a, $01 ; id 18
    db $0b, $01 ; id 19
    db $0c, $01 ; id 20
    db $0d, $01 ; id 21
    db $08, $03 ; id 22
    db $09, $02 ; id 23
    db $0a, $01 ; id 24
    db $0b, $01 ; id 25
    db $0c, $01 ; id 26
    db $0d, $01 ; id 27
    db $0e, $01 ; id 28
    db $04, $02 ; id 29
    db $1f, $02 ; id 30
    db $ff, $ff ; id 31

; list for entry $12 of SequenceFrameTable; it runs to the next list (E-0199)
SequenceFrames012::
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
    db $0a, $04 ; id 10
    db $1f, $02 ; id 11
    db $ff, $ff ; id 12

; list for entry $13 of SequenceFrameTable; it runs to the next list (E-0199)
SequenceFrames013::
    db $00, $04 ; id 0
    db $01, $03 ; id 1
    db $02, $04 ; id 2
    db $03, $03 ; id 3
    db $04, $02 ; id 4
    db $05, $01 ; id 5
    db $06, $01 ; id 6
    db $07, $01 ; id 7
    db $1f, $01 ; id 8
    db $ff, $ff ; id 9

; list for entry $14 of SequenceFrameTable; it runs to the next list (E-0199)
; record: frame, timer
SequenceFrames014::
    db $00, $0a ; id 0
    db $01, $08 ; id 1
    db $02, $07 ; id 2
    db $03, $06 ; id 3
    db $04, $05 ; id 4
    db $05, $05 ; id 5
    db $06, $05 ; id 6
    db $07, $05 ; id 7
    db $08, $04 ; id 8
    db $09, $04 ; id 9
    db $0a, $04 ; id 10
    db $1f, $02 ; id 11
    db $ff, $ff ; id 12

; list for entry $15 of SequenceFrameTable; it runs to the next list (E-0199)
SequenceFrames015::
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
    db $1f, $02 ; id 10
    db $ff, $ff ; id 11

; list for entry $16 of SequenceFrameTable; it runs to the next list (E-0199)
SequenceFrames016::
    db $00, $06 ; id 0
    db $01, $06 ; id 1
    db $02, $06 ; id 2
    db $03, $06 ; id 3
    db $04, $08 ; id 4
    db $05, $08 ; id 5
    db $06, $04 ; id 6
    db $08, $04 ; id 7
    db $08, $04 ; id 8
    db $1f, $02 ; id 9
    db $ff, $ff ; id 10

; list for entry $17 of SequenceFrameTable; it runs to the next list (E-0199)
SequenceFrames017::
    db $00, $06 ; id 0
    db $01, $06 ; id 1
    db $02, $06 ; id 2
    db $03, $06 ; id 3
    db $04, $06 ; id 4
    db $05, $06 ; id 5
    db $1f, $02 ; id 6
    db $ff, $ff ; id 7

; list for entry $18 of SequenceFrameTable; it runs to the next list (E-0199)
; record: frame, timer
SequenceFrames018::
    db $00, $0a ; id 0
    db $01, $06 ; id 1
    db $02, $06 ; id 2
    db $03, $06 ; id 3
    db $04, $06 ; id 4
    db $05, $06 ; id 5
    db $1f, $02 ; id 6
    db $ff, $ff ; id 7

; list for entry $19 of SequenceFrameTable; it runs to the next list (E-0199)
SequenceFrames019::
    db $00, $04 ; id 0
    db $1f, $04 ; id 1
    db $00, $04 ; id 2
    db $1f, $04 ; id 3
    db $00, $04 ; id 4
    db $1f, $04 ; id 5
    db $00, $04 ; id 6
    db $1f, $04 ; id 7
    db $00, $04 ; id 8
    db $1f, $04 ; id 9
    db $00, $04 ; id 10
    db $1f, $0f ; id 11
    db $1f, $02 ; id 12
    db $ff, $ff ; id 13

; list for entry $1A of SequenceFrameTable; it runs to the next list (E-0199)
SequenceFrames01A::
    db $00, $03 ; id 0
    db $01, $03 ; id 1
    db $02, $03 ; id 2
    db $1f, $08 ; id 3
    db $03, $02 ; id 4
    db $04, $02 ; id 5
    db $05, $02 ; id 6
    db $06, $02 ; id 7
    db $07, $02 ; id 8
    db $08, $02 ; id 9
    db $09, $02 ; id 10
    db $0a, $02 ; id 11
    db $0b, $02 ; id 12
    db $0c, $02 ; id 13
    db $0d, $02 ; id 14
    db $0e, $02 ; id 15
    db $0f, $02 ; id 16
    db $10, $02 ; id 17
    db $11, $02 ; id 18
    db $12, $02 ; id 19
    db $1f, $02 ; id 20
    db $ff, $ff ; id 21

; list for entry $1B of SequenceFrameTable; it runs to the next list (E-0199)
SequenceFrames01B::
    db $00, $04 ; id 0
    db $01, $04 ; id 1
    db $02, $04 ; id 2
    db $03, $04 ; id 3
    db $04, $05 ; id 4
    db $05, $04 ; id 5
    db $06, $04 ; id 6
    db $07, $04 ; id 7
    db $1f, $02 ; id 8
    db $ff, $ff ; id 9

; list for entry $1C of SequenceFrameTable; it runs to the next list (E-0199)
; record: frame, timer
SequenceFrames01C::
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
    db $0a, $02 ; id 10
    db $0b, $03 ; id 11
    db $0c, $05 ; id 12
    db $0d, $04 ; id 13
    db $0e, $03 ; id 14
    db $0f, $03 ; id 15
    db $0e, $04 ; id 16
    db $0d, $04 ; id 17
    db $0e, $03 ; id 18
    db $0b, $03 ; id 19
    db $13, $04 ; id 20
    db $0b, $04 ; id 21
    db $0c, $05 ; id 22
    db $0d, $04 ; id 23
    db $0e, $03 ; id 24
    db $0f, $04 ; id 25
    db $0e, $03 ; id 26
    db $10, $04 ; id 27
    db $11, $04 ; id 28
    db $12, $04 ; id 29
    db $1f, $02 ; id 30
    db $ff, $ff ; id 31

; list for entry $1D of SequenceFrameTable; it runs to the next list (E-0199)
SequenceFrames01D::
    db $00, $03 ; id 0
    db $01, $04 ; id 1
    db $02, $04 ; id 2
    db $03, $03 ; id 3
    db $04, $05 ; id 4
    db $05, $03 ; id 5
    db $1f, $02 ; id 6
    db $ff, $ff ; id 7

; list for entry $1E of SequenceFrameTable; it runs to the next list (E-0199)
SequenceFrames01E::
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
    db $1f, $08 ; id 11
    db $07, $03 ; id 12
    db $08, $02 ; id 13
    db $09, $04 ; id 14
    db $0a, $04 ; id 15
    db $0b, $04 ; id 16
    db $0c, $04 ; id 17
    db $0d, $04 ; id 18
    db $0e, $03 ; id 19
    db $0f, $03 ; id 20
    db $10, $03 ; id 21
    db $11, $03 ; id 22
    db $12, $03 ; id 23
    db $13, $03 ; id 24
    db $1f, $02 ; id 25
    db $ff, $ff ; id 26

; list for entry $1F of SequenceFrameTable; it runs to the next list (E-0199)
SequenceFrames01F::
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
    db $0a, $03 ; id 10
    db $0b, $04 ; id 11
    db $0c, $03 ; id 12
    db $0d, $03 ; id 13
    db $0e, $03 ; id 14
    db $0f, $02 ; id 15
    db $10, $02 ; id 16
    db $0c, $02 ; id 17
    db $0d, $02 ; id 18
    db $0e, $02 ; id 19
    db $0f, $02 ; id 20
    db $10, $02 ; id 21
    db $0d, $02 ; id 22
    db $0e, $02 ; id 23
    db $0f, $02 ; id 24
    db $10, $02 ; id 25
    db $0a, $01 ; id 26
    db $1f, $02 ; id 27
    db $ff, $ff ; id 28

; list for entry $20 of SequenceFrameTable; it runs to the next list (E-0199)
; record: frame, timer
SequenceFrames020::
    db $00, $03 ; id 0
    db $01, $04 ; id 1
    db $02, $04 ; id 2
    db $03, $03 ; id 3
    db $04, $05 ; id 4
    db $05, $03 ; id 5
    db $06, $03 ; id 6
    db $1f, $08 ; id 7
    db $07, $02 ; id 8
    db $08, $02 ; id 9
    db $09, $02 ; id 10
    db $0a, $02 ; id 11
    db $0b, $02 ; id 12
    db $0c, $02 ; id 13
    db $0d, $02 ; id 14
    db $0e, $02 ; id 15
    db $0f, $02 ; id 16
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
    db $1f, $02 ; id 27
    db $ff, $ff ; id 28

; list for entry $21 of SequenceFrameTable; it runs to the next list (E-0199)
SequenceFrames021::
    db $00, $03 ; id 0
    db $01, $04 ; id 1
    db $02, $04 ; id 2
    db $03, $03 ; id 3
    db $04, $05 ; id 4
    db $05, $03 ; id 5
    db $06, $03 ; id 6
    db $1f, $08 ; id 7
    db $07, $05 ; id 8
    db $08, $04 ; id 9
    db $09, $03 ; id 10
    db $0a, $03 ; id 11
    db $0b, $03 ; id 12
    db $0a, $04 ; id 13
    db $0b, $08 ; id 14
    db $1f, $03 ; id 15
    db $0b, $02 ; id 16
    db $1f, $02 ; id 17
    db $0b, $01 ; id 18
    db $1f, $01 ; id 19
    db $0b, $01 ; id 20
    db $1f, $01 ; id 21
    db $0b, $01 ; id 22
    db $1f, $01 ; id 23
    db $0b, $01 ; id 24
    db $1f, $02 ; id 25
    db $ff, $ff ; id 26

; list for entry $22 of SequenceFrameTable; it runs to the next list (E-0199)
SequenceFrames022::
    db $00, $06 ; id 0
    db $01, $05 ; id 1
    db $02, $05 ; id 2
    db $03, $03 ; id 3
    db $04, $04 ; id 4
    db $05, $03 ; id 5
    db $1f, $02 ; id 6
    db $ff, $ff ; id 7

; list for entry $23 of SequenceFrameTable; it runs to the next list (E-0199)
SequenceFrames023::
    db $00, $03 ; id 0
    db $01, $04 ; id 1
    db $02, $04 ; id 2
    db $03, $03 ; id 3
    db $04, $05 ; id 4
    db $05, $03 ; id 5
    db $06, $02 ; id 6
    db $1f, $02 ; id 7
    db $ff, $ff ; id 8

; list for entry $24 of SequenceFrameTable; it runs to the next list (E-0199)
; record: frame, timer
SequenceFrames024::
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
    db $1f, $02 ; id 21
    db $ff, $ff ; id 22

; list for entry $25 of SequenceFrameTable; it runs to the next list (E-0199)
SequenceFrames025::
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
    db $1f, $02 ; id 11
    db $08, $02 ; id 12
    db $1f, $02 ; id 13
    db $07, $01 ; id 14
    db $1f, $01 ; id 15
    db $08, $01 ; id 16
    db $1f, $01 ; id 17
    db $07, $01 ; id 18
    db $1f, $01 ; id 19
    db $08, $01 ; id 20
    db $1f, $01 ; id 21
    db $1f, $02 ; id 22
    db $ff, $ff ; id 23

; list for entry $26 of SequenceFrameTable; it runs to the next list (E-0199)
SequenceFrames026::
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
    db $0a, $02 ; id 18
    db $0b, $02 ; id 19
    db $0a, $01 ; id 20
    db $0b, $01 ; id 21
    db $0a, $01 ; id 22
    db $1f, $01 ; id 23
    db $0b, $01 ; id 24
    db $1f, $01 ; id 25
    db $0a, $01 ; id 26
    db $1f, $01 ; id 27
    db $0b, $01 ; id 28
    db $1f, $02 ; id 29
    db $ff, $ff ; id 30

; list for entry $27 of SequenceFrameTable; it runs to the next list (E-0199)
SequenceFrames027::
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
    db $0a, $03 ; id 10
    db $0b, $02 ; id 11
    db $0c, $02 ; id 12
    db $0d, $02 ; id 13
    db $0b, $02 ; id 14
    db $0c, $02 ; id 15
    db $0d, $02 ; id 16
    db $0b, $02 ; id 17
    db $0c, $02 ; id 18
    db $0d, $02 ; id 19
    db $0b, $02 ; id 20
    db $0c, $02 ; id 21
    db $0d, $02 ; id 22
    db $0b, $02 ; id 23
    db $0c, $02 ; id 24
    db $0d, $02 ; id 25
    db $0b, $02 ; id 26
    db $0c, $02 ; id 27
    db $0d, $02 ; id 28
    db $1f, $02 ; id 29
    db $ff, $ff ; id 30

; list for entry $28 of SequenceFrameTable; it runs to the next list (E-0199)
; record: frame, timer
SequenceFrames028::
    db $00, $03 ; id 0
    db $1f, $01 ; id 1
    db $01, $03 ; id 2
    db $1f, $01 ; id 3
    db $02, $03 ; id 4
    db $1f, $01 ; id 5
    db $03, $03 ; id 6
    db $1f, $01 ; id 7
    db $04, $03 ; id 8
    db $05, $03 ; id 9
    db $04, $03 ; id 10
    db $05, $03 ; id 11
    db $04, $03 ; id 12
    db $05, $03 ; id 13
    db $04, $03 ; id 14
    db $05, $03 ; id 15
    db $1f, $02 ; id 16
    db $ff, $ff ; id 17

; list for entry $29 of SequenceFrameTable; it runs to the next list (E-0199)
SequenceFrames029::
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
    db $0b, $04 ; id 22
    db $11, $04 ; id 23
    db $0c, $04 ; id 24
    db $12, $04 ; id 25
    db $0d, $04 ; id 26
    db $13, $04 ; id 27
    db $07, $03 ; id 28
    db $1f, $02 ; id 29
    db $ff, $ff ; id 30

; list for entry $2A of SequenceFrameTable; it runs to the next list (E-0199)
SequenceFrames02A::
    db $00, $04 ; id 0
    db $01, $05 ; id 1
    db $02, $04 ; id 2
    db $03, $03 ; id 3
    db $04, $03 ; id 4
    db $05, $03 ; id 5
    db $06, $03 ; id 6
    db $07, $03 ; id 7
    db $08, $03 ; id 8
    db $1f, $08 ; id 9
    db $09, $02 ; id 10
    db $0a, $02 ; id 11
    db $0b, $02 ; id 12
    db $0c, $02 ; id 13
    db $0d, $02 ; id 14
    db $0e, $02 ; id 15
    db $0f, $02 ; id 16
    db $10, $02 ; id 17
    db $11, $02 ; id 18
    db $12, $02 ; id 19
    db $13, $02 ; id 20
    db $14, $02 ; id 21
    db $0b, $02 ; id 22
    db $0c, $02 ; id 23
    db $0d, $02 ; id 24
    db $0e, $02 ; id 25
    db $0f, $02 ; id 26
    db $15, $02 ; id 27
    db $16, $02 ; id 28
    db $17, $02 ; id 29
    db $1f, $02 ; id 30
    db $ff, $ff ; id 31

; list for entry $2B of SequenceFrameTable; it runs to the next list (E-0199)
SequenceFrames02B::
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
    db $1f, $02 ; id 13
    db $ff, $ff ; id 14

; list for entry $2C of SequenceFrameTable; it runs to the next list (E-0199)
; record: frame, timer
SequenceFrames02C::
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
    db $1f, $02 ; id 10
    db $ff, $ff ; id 11

; list for entry $2D of SequenceFrameTable; it runs to the next list (E-0199)
SequenceFrames02D::
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
    db $0a, $03 ; id 11
    db $0b, $03 ; id 12
    db $ff, $ff ; id 13

; list for entry $2E of SequenceFrameTable; it runs to the next list (E-0199)
SequenceFrames02E::
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
    db $0a, $02 ; id 14
    db $16, $02 ; id 15
    db $0b, $02 ; id 16
    db $17, $02 ; id 17
    db $0c, $02 ; id 18
    db $18, $02 ; id 19
    db $0d, $02 ; id 20
    db $19, $02 ; id 21
    db $0e, $02 ; id 22
    db $1a, $02 ; id 23
    db $0f, $02 ; id 24
    db $1b, $02 ; id 25
    db $10, $02 ; id 26
    db $11, $02 ; id 27
    db $ff, $ff ; id 28

; list for entry $2F of SequenceFrameTable; it runs to the next list (E-0199)
SequenceFrames02F::
    db $00, $04 ; id 0
    db $01, $05 ; id 1
    db $02, $05 ; id 2
    db $03, $04 ; id 3
    db $04, $06 ; id 4
    db $05, $04 ; id 5
    db $06, $04 ; id 6
    db $1f, $0a ; id 7
    db $07, $03 ; id 8
    db $08, $02 ; id 9
    db $09, $05 ; id 10
    db $0a, $05 ; id 11
    db $0b, $05 ; id 12
    db $0c, $06 ; id 13
    db $0d, $06 ; id 14
    db $0e, $05 ; id 15
    db $0f, $04 ; id 16
    db $0c, $04 ; id 17
    db $0d, $04 ; id 18
    db $0e, $04 ; id 19
    db $0f, $03 ; id 20
    db $0c, $03 ; id 21
    db $0d, $03 ; id 22
    db $0e, $03 ; id 23
    db $10, $02 ; id 24
    db $0f, $02 ; id 25
    db $11, $02 ; id 26
    db $10, $02 ; id 27
    db $11, $02 ; id 28
    db $ff, $ff ; id 29

; list for entry $30 of SequenceFrameTable; it runs to the next list (E-0199)
; record: frame, timer
SequenceFrames030::
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
    db $0a, $03 ; id 16
    db $1f, $02 ; id 17
    db $ff, $ff ; id 18

; list for entry $31 of SequenceFrameTable; it runs to the next list (E-0199)
SequenceFrames031::
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
    db $0a, $04 ; id 10
    db $0b, $01 ; id 11
    db $0c, $04 ; id 12
    db $0d, $01 ; id 13
    db $0e, $04 ; id 14
    db $0f, $03 ; id 15
    db $0e, $04 ; id 16
    db $0f, $03 ; id 17
    db $1f, $02 ; id 18
    db $ff, $ff ; id 19

; list for entry $32 of SequenceFrameTable; it runs to the next list (E-0199)
SequenceFrames032::
    db $00, $05 ; id 0
    db $01, $05 ; id 1
    db $02, $05 ; id 2
    db $03, $05 ; id 3
    db $04, $05 ; id 4
    db $05, $05 ; id 5
    db $06, $05 ; id 6
    db $07, $05 ; id 7
    db $1f, $02 ; id 8
    db $ff, $ff ; id 9

; list for entry $33 of SequenceFrameTable; it runs to the next list (E-0199)
SequenceFrames033::
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
    db $0a, $03 ; id 10
    db $0b, $03 ; id 11
    db $0b, $03 ; id 12
    db $0c, $03 ; id 13
    db $0d, $03 ; id 14
    db $0e, $03 ; id 15
    db $0f, $03 ; id 16
    db $13, $03 ; id 17
    db $10, $03 ; id 18
    db $14, $03 ; id 19
    db $11, $03 ; id 20
    db $15, $03 ; id 21
    db $12, $03 ; id 22
    db $0f, $03 ; id 23
    db $13, $02 ; id 24
    db $10, $02 ; id 25
    db $14, $02 ; id 26
    db $11, $02 ; id 27
    db $15, $02 ; id 28
    db $12, $02 ; id 29
    db $13, $02 ; id 30
    db $0f, $02 ; id 31
    db $0e, $03 ; id 32
    db $ff, $ff ; id 33

; list for entry $34 of SequenceFrameTable; it runs to the next list (E-0199)
; record: frame, timer
SequenceFrames034::
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
    db $0a, $04 ; id 10
    db $0b, $04 ; id 11
    db $0c, $03 ; id 12
    db $0d, $03 ; id 13
    db $0c, $03 ; id 14
    db $0e, $04 ; id 15
    db $0f, $03 ; id 16
    db $10, $02 ; id 17
    db $11, $04 ; id 18
    db $12, $04 ; id 19
    db $13, $04 ; id 20
    db $14, $1d ; id 21
    db $1f, $03 ; id 22
    db $14, $03 ; id 23
    db $1f, $03 ; id 24
    db $14, $03 ; id 25
    db $1f, $02 ; id 26
    db $14, $02 ; id 27
    db $1f, $01 ; id 28
    db $14, $01 ; id 29
    db $1f, $01 ; id 30
    db $14, $01 ; id 31
    db $ff, $ff ; id 32

; list for entry $35 of SequenceFrameTable; it runs to the next list (E-0199)
SequenceFrames035::
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
    db $0a, $04 ; id 10
    db $0b, $05 ; id 11
    db $0c, $06 ; id 12
    db $0d, $03 ; id 13
    db $0e, $04 ; id 14
    db $0f, $04 ; id 15
    db $10, $04 ; id 16
    db $11, $04 ; id 17
    db $12, $04 ; id 18
    db $13, $04 ; id 19
    db $14, $04 ; id 20
    db $15, $04 ; id 21
    db $16, $04 ; id 22
    db $17, $03 ; id 23
    db $ff, $ff ; id 24

; list for entry $36 of SequenceFrameTable; it runs to the next list (E-0199)
SequenceFrames036::
    db $00, $03 ; id 0
    db $01, $03 ; id 1
    db $02, $03 ; id 2
    db $03, $03 ; id 3
    db $04, $02 ; id 4
    db $05, $03 ; id 5
    db $06, $04 ; id 6
    db $1f, $08 ; id 7
    db $07, $04 ; id 8
    db $08, $04 ; id 9
    db $09, $04 ; id 10
    db $0a, $04 ; id 11
    db $0b, $04 ; id 12
    db $0c, $04 ; id 13
    db $0d, $04 ; id 14
    db $0e, $04 ; id 15
    db $0f, $04 ; id 16
    db $10, $04 ; id 17
    db $11, $04 ; id 18
    db $12, $03 ; id 19
    db $13, $03 ; id 20
    db $12, $03 ; id 21
    db $13, $03 ; id 22
    db $12, $03 ; id 23
    db $13, $03 ; id 24
    db $11, $02 ; id 25
    db $0f, $02 ; id 26
    db $0e, $02 ; id 27
    db $0c, $02 ; id 28
    db $0b, $02 ; id 29
    db $0a, $02 ; id 30
    db $ff, $ff ; id 31

; list for entry $37 of SequenceFrameTable; it runs to the next list (E-0199)
SequenceFrames037::
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
    db $0a, $04 ; id 11
    db $0b, $04 ; id 12
    db $0c, $04 ; id 13
    db $0d, $04 ; id 14
    db $0e, $04 ; id 15
    db $0f, $04 ; id 16
    db $ff, $ff ; id 17

; list for entry $38 of SequenceFrameTable; it runs to the next list (E-0199)
; record: frame, timer
SequenceFrames038::
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
    db $0a, $03 ; id 12
    db $0b, $03 ; id 13
    db $0c, $03 ; id 14
    db $0d, $03 ; id 15
    db $10, $03 ; id 16
    db $11, $03 ; id 17
    db $0e, $03 ; id 18
    db $0f, $03 ; id 19
    db $10, $03 ; id 20
    db $11, $03 ; id 21
    db $0c, $02 ; id 22
    db $0d, $02 ; id 23
    db $12, $01 ; id 24
    db $1f, $01 ; id 25
    db $13, $01 ; id 26
    db $1f, $01 ; id 27
    db $14, $01 ; id 28
    db $1f, $01 ; id 29
    db $15, $01 ; id 30
    db $ff, $ff ; id 31

; list for entry $39 of SequenceFrameTable; it runs to the next list (E-0199)
SequenceFrames039::
    db $00, $05 ; id 0
    db $01, $06 ; id 1
    db $02, $05 ; id 2
    db $03, $04 ; id 3
    db $04, $04 ; id 4
    db $05, $04 ; id 5
    db $06, $04 ; id 6
    db $07, $04 ; id 7
    db $08, $04 ; id 8
    db $1f, $0a ; id 9
    db $09, $03 ; id 10
    db $0a, $03 ; id 11
    db $0b, $03 ; id 12
    db $0c, $03 ; id 13
    db $0d, $03 ; id 14
    db $0e, $03 ; id 15
    db $ff, $ff ; id 16

; list for entry $3A of SequenceFrameTable; it runs to the next list (E-0199)
SequenceFrames03A::
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
    db $0a, $03 ; id 17
    db $17, $03 ; id 18
    db $0b, $03 ; id 19
    db $18, $03 ; id 20
    db $0c, $03 ; id 21
    db $19, $03 ; id 22
    db $0d, $03 ; id 23
    db $1a, $03 ; id 24
    db $0e, $03 ; id 25
    db $0f, $03 ; id 26
    db $ff, $ff ; id 27

; list for entry $3B of SequenceFrameTable; it runs to the next list (E-0199)
SequenceFrames03B::
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
    db $0a, $02 ; id 10
    db $ff, $ff ; id 11

; Fight sub-phase 0 (RunBattleActions_StatusCheckStep calls it once per frame): wBattleResolveStep
; picks the step of the checks made for each action. 0 RunBattleActions_StatusChecks_StartAction
; (take the next actor of wActionQueue and apply its statuses), 1
; RunBattleActions_StatusChecks_CheckAction (action, MP cost, target), 2
; RunBattleActions_StatusChecks_PersonalityText, 3 RunBattleActions_StatusChecks_ShowActionText, 4
; RunBattleActions_StatusChecks_BreakFree, 5 RunBattleActions_StatusChecks_SelectEffect, 6
; RunBattleActions_StatusChecks_ShatterChecks, 7 CheckLinkRuleViolation, 8 pays the MP of the action
; and moves wBattleSubPhase on, 9 RunBattleActions_StatusChecks_DroppedDead. Each step adds 1 to
; wBattleResolveStep itself; the curse step of StartAction sets step 9 when the cursed actor has no
; HP left. (C1, E-0380)
; by wBattleResolveStep: per-action status checks with their battle texts ('0 woke up!', 'SealPray
; was broken!', 'G was shattered!', '0 dropped dead!') and the link rule check
RunBattleActions_StatusChecks::
    ld a, [wBattleResolveStep]
    jumptable
    dw RunBattleActions_StatusChecks_StartAction
    dw RunBattleActions_StatusChecks_CheckAction
    dw RunBattleActions_StatusChecks_PersonalityText
    dw RunBattleActions_StatusChecks_ShowActionText
    dw RunBattleActions_StatusChecks_BreakFree
    dw RunBattleActions_StatusChecks_SelectEffect
    dw RunBattleActions_StatusChecks_ShatterChecks
    dw CheckLinkRuleViolation
    dw RunBattleActions_StatusChecks_PayActionMP
    dw RunBattleActions_StatusChecks_DroppedDead

; Step 0 of RunBattleActions_StatusChecks: wBattleSubStep picks 0
; RunBattleActions_StatusChecks_StartAction_Begin (reset the effect state and take the next actor),
; 1 RunBattleActions_StatusChecks_StartAction_Statuses (ironized, airborne and high-jump actors,
; status recovery messages), 2 RunBattleActions_StatusChecks_StartAction_Curse (the roll of a cursed
; actor), 3 RunBattleActions_StatusChecks_StartAction_Confused (a confused actor picks a random
; action), 4 RunBattleActions_StatusChecks_StartAction_Finish (go on to resolve step 1) and 5
; RunBattleActions_StatusChecks_StartAction_AllDone (the queue is used up). (C1, E-0380)
; by its step: resets the effect state, shows a category-0 battle text, rolls the status tick effect
; and picks a random action when the actor is not controlled
RunBattleActions_StatusChecks_StartAction::
    ld a, [wBattleSubStep]
    jumptable
    dw RunBattleActions_StatusChecks_StartAction_Begin
    dw RunBattleActions_StatusChecks_StartAction_Statuses
    dw RunBattleActions_StatusChecks_StartAction_Curse
    dw RunBattleActions_StatusChecks_StartAction_Confused
    dw RunBattleActions_StatusChecks_StartAction_Finish
    dw RunBattleActions_StatusChecks_StartAction_AllDone

; Starting the next action, step 0: resets the effect state; a follow-up goes to step 4; at the end
; of the queue (nine done or $FF) step 5; an item turn ($10) goes to sub-phase 8; otherwise takes
; the queued slot as the actor and, when it is present and not done (mark 3), goes on to step 1,
; else moves the queue on. (C1, E-0357)
RunBattleActions_StatusChecks_StartAction_Begin::
    call ResetEffectStateForAction
    ld a, [wFollowUpAction]
    or a
    jr z, .check_action_queue_pos
    ld a, $04
    ld [wBattleSubStep], a
    jr .return

.check_action_queue_pos:
    ld a, [wActionQueuePos]
    cp $09
    jr z, .set_battle_sub_step_to_05
    ld hl, wActionQueue
    call ReadByteAtHLPlusA
    cp $ff
    jr z, .set_battle_sub_step_to_05
    cp $10
    jr nz, .set_battle_actor
    ld a, $08
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    xor a
    ld [wBattleSubStep], a
    jr .return

.set_battle_sub_step_to_05:
    ld a, $05
    ld [wBattleSubStep], a
    jr .return

.set_battle_actor:
    ld [wBattleActor], a
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .done
    ld a, [wBattleActor]
    ld hl, wSlotMarks
    add_a_to_hl
    ld a, [hl]
    cp $03
    jr z, .done
    ld hl, wBattleSubStep
    inc [hl]
    jr RunBattleActions_StatusChecks_StartAction_Statuses

.done:
    ld hl, wActionQueuePos
    inc [hl]

.return:
    ret

; Starting the next action, step 1 (wBattleSubStep 1 of RunBattleActions_StatusChecks_StartAction).
; An actor with the BSTAT5_IRONIZED bits (status 5 bits 6-7) shows battle text $15
; (ShowBattleTextCategory0) and is skipped (wBattleSubStep = 0, wActionQueuePos += 1). One with
; status 3 bits 6-7 (the BSTAT3_AIRBORNE field) is given action $CD on itself (the actor at
; wBattleTargetChoice + 2 * actor, $CD in the action byte before it) and sub-step 3. One with status
; 4 bits 2-3 (BSTAT4_HIGH_JUMP) and wBattleStatus bits 6-7 is given action $CA (BSTAT0_PARALYZED
; set) or $CB on itself and sub-step 4. Otherwise ShowActorStatusRecoveryMessage: with carry (no
; message) it goes on at once to the curse step (wBattleSubStep += 1,
; RunBattleActions_StatusChecks_StartAction_Curse); without carry the actor is skipped as above
; unless wBattleSubStep is 4. (C1, E-0372)
RunBattleActions_StatusChecks_StartAction_Statuses::
    ld a, [wBattleActor]
    ld hl, wBattleStatus5
    call AddAx9ToHL
    ld a, [hld]
    and $c0
    jr z, .next
    ld d, $15
    farcall ShowBattleTextCategory0
    jr .clear_battle_sub_step

.next:
    dec hl
    ld a, [hli]
    and $c0
    jr z, .skip
    ld a, [wBattleActor]
    push af
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    pop af
    ld [hld], a
    ld [hl], $cd
    ld a, $03
    ld [wBattleSubStep], a
    jr .return

.skip:
    ld a, [hld]
    and $0c
    jr z, .call_show_actor_status_recovery_message
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    and $c0
    jr z, .call_show_actor_status_recovery_message
    ld a, $ca
    bit 6, [hl]
    jr nz, .read_battle_actor
    ld a, $cb

.read_battle_actor:
    push af
    ld a, [wBattleActor]
    push af
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    pop af
    ld [hld], a
    pop af
    ld [hl], a
    ld a, $04
    ld [wBattleSubStep], a
    jr .return

.call_show_actor_status_recovery_message:
    call ShowActorStatusRecoveryMessage
    jr nc, .check_battle_sub_step
    ld hl, wBattleSubStep
    inc [hl]
    jr RunBattleActions_StatusChecks_StartAction_Curse

.check_battle_sub_step:
    ld a, [wBattleSubStep]
    cp $04
    jr z, .return

.clear_battle_sub_step:
    xor a
    ld [wBattleSubStep], a
    ld hl, wActionQueuePos
    inc [hl]

.return:
    ret

; Starting the next action, step 2: wBattleSubStep += 1 first. When the actor has BSTAT0_CURSED and
; RollStatusTickEffect returns carry, reads its HP (GetBattleHP_Bank32): at 0 HP goes to resolve
; step 9 (wBattleResolveStep = 9, wBattleSubStep = 0), otherwise returns. Without the curse or the
; tick it runs step 3 at once (jumps to RunBattleActions_StatusChecks_StartAction_Confused). (C1,
; E-0372)
RunBattleActions_StatusChecks_StartAction_Curse::
    ld hl, wBattleSubStep
    inc [hl]
    ld a, [wBattleActor]
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit BSTAT0_CURSED, [hl]
    jr z, RunBattleActions_StatusChecks_StartAction_Confused
    call RollStatusTickEffect
    jr nc, RunBattleActions_StatusChecks_StartAction_Confused
    ld a, [wBattleActor]
    call GetBattleHP_Bank32
    ld a, h
    or l
    ret nz
    ld a, $09
    ld [wBattleResolveStep], a
    xor a
    ld [wBattleSubStep], a
    ret

; Starting the next action, step 3: a confused actor picks a random action
; (PickRandomActionWhenUncontrolled) with battle text $14. (C1, E-0357)
RunBattleActions_StatusChecks_StartAction_Confused::
    ld hl, wBattleSubStep
    inc [hl]
    ld a, [wBattleActor]
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit BSTAT0_CONFUSED, [hl]
    jr z, RunBattleActions_StatusChecks_StartAction_Finish
    call PickRandomActionWhenUncontrolled
    ld d, $14
    farcall ShowBattleTextCategory0
    ret

; Starting the next action, step 4 (also step 3's end when the actor is not confused, and step 0's
; target for a follow-up action): resolve step 1 (RunBattleActions_StatusChecks_CheckAction) with
; wBattleSubStep 0. (C2, E-0372; probed E-0380)
RunBattleActions_StatusChecks_StartAction_Finish::
    ld hl, wBattleResolveStep
    inc [hl]
    xor a
    ld [wBattleSubStep], a
    ret

; Starting the next action, step 5 (the action queue is used up): wBattleSubPhase 9
; (RunBattleActions_WearOffAndDefeat in RunBattleActions' table), with wBattleResolveStep and
; wBattleSubStep 0. (C2, E-0372; probed E-0380)
RunBattleActions_StatusChecks_StartAction_AllDone::
    ld a, $09
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    xor a
    ld [wBattleSubStep], a
    ret

; Shows the message of a status that costs the actor (wBattleActor) its action, using D as the
; battle text index of ShowBattleTextCategory0. Looks in order at BSTAT0_PARALYZED (text $17,
; 'paralyzed!'), BSTAT0_ASLEEP (RollSleepWakeUp: still asleep gives text $13, 'asleep.'; waking up
; shows its own text) and bits 2, 0, 1, 3, 4, 5 of status byte 3 (texts $1A, $16, $18, $19, $1B,
; $1C: cannot get back up, frozen solid, dancing along, shivering, cowering in fear, vacant and
; lost). After a message or a wake-up it clears bits 0-5 of status byte 3
; (ClearActorStatus3Bits0To5) and returns carry clear with A = 0; carry set means there was nothing
; to say. Only caller: RunBattleActions_StatusChecks_StartAction_Statuses, which gives up the action
; (wActionQueuePos += 1) when carry is clear. (C1, E-0380)
; shows battle text $16-$1C for the first set status bit of the actor (status 6/7, byte 3 bits 0-5)
; and clears status 3 bits 0-5; carry when none (E-0127)
ShowActorStatusRecoveryMessage::
    ld a, [wBattleActor]
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit BSTAT0_PARALYZED, [hl]
    jr z, .skip
    ld d, $17
    jr .call_show_battle_text_category0

.skip:
    bit 7, [hl]
    jr z, .skip2
    call RollSleepWakeUp
    jr c, .call_show_battle_text_category0
    jr .call_clear_actor_status3_bits0_to5

.skip2:
    ld bc, $0003
    add hl, bc
    bit 2, [hl]
    jr z, .skip3
    ld d, $1a
    jr .call_show_battle_text_category0

.skip3:
    bit 0, [hl]
    jr z, .skip4
    ld d, $16
    jr .call_show_battle_text_category0

.skip4:
    bit 1, [hl]
    jr z, .skip5
    ld d, $18
    jr .call_show_battle_text_category0

.skip5:
    bit 3, [hl]
    jr z, .skip6
    ld d, $19
    jr .call_show_battle_text_category0

.skip6:
    bit 4, [hl]
    jr z, .skip7
    ld d, $1b
    jr .call_show_battle_text_category0

.skip7:
    bit 5, [hl]
    jr z, .set_carry
    ld d, $1c
    jr .call_show_battle_text_category0

.set_carry:
    scf
    jr .return

.call_show_battle_text_category0:
    farcall ShowBattleTextCategory0

.call_clear_actor_status3_bits0_to5:
    call ClearActorStatus3Bits0To5
    xor a

.return:
    ret

; The roll made for a cursed actor (BSTAT0_CURSED) at the start of each of its actions, called by
; RunBattleActions_StatusChecks_StartAction_Curse. After AdvanceRandom nothing happens (carry clear,
; A = 0) unless wRandomLo is below $40; then wRandomHi picks: below $40 battle text $0F (cursed and
; cannot move: wActionQueuePos += 1, status byte 3 cleared, wBattleSubStep = 0); $40-$7F
; ActorLosesSixthOfMaxHP (HP floored at 0, wLevelUpGains bit 0, text $10) unless the damage is 0;
; $80-$BF ActorLosesSixthOfMaxMP (bit 1, text $11) unless the damage is 0; above that
; BSTAT0_CONFUSED is set (bit 2, text $12). Returns carry set after a message and carry clear when
; there was none. (C1, E-0380)
; a random roll: 3/4 of the time nothing; otherwise clears status 3 (text $0F), loses a sixth of max
; HP (text $10) or of max MP, or does something else (E-0128)
RollStatusTickEffect::
    call AdvanceRandom
    ld a, [wRandomLo]
    cp $40
    jr nc, .loop
    ld a, [wRandomHi]
    cp $40
    jr c, .call_clear_actor_status3
    cp $80
    jr c, .call_actor_loses_sixth_of_max_hp
    cp $c0
    jr c, .call_actor_loses_sixth_of_max_mp
    jr .read_battle_actor

.loop:
    xor a
    ret

.call_clear_actor_status3:
    ld hl, wActionQueuePos
    inc [hl]
    call ClearActorStatus3
    ld d, $0f
    call ShowBattleTextCategory0Entry
    xor a
    ld [wBattleSubStep], a
    jr ShowBattleTextCategory0Entry_ReturnCarry

.call_actor_loses_sixth_of_max_hp:
    call ActorLosesSixthOfMaxHP
    jr nc, .read_battle_damage_lo
    xor a
    ld [de], a
    dec de
    ld [de], a

.read_battle_damage_lo:
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    ld a, h
    or l
    jr z, .loop
    ld a, [wBattleActor]
    call SetBit0OfLevelUpGainsIndexed_Bank32
    ld d, $10
    call ShowBattleTextCategory0Entry
    ld a, [wBattleActor]
    call GetBattleHP_Bank32
    ld a, h
    or l
    jr nz, ShowBattleTextCategory0Entry_ReturnCarry
    jr ShowBattleTextCategory0Entry_ReturnCarry

.call_actor_loses_sixth_of_max_mp:
    call ActorLosesSixthOfMaxMP
    ld a, b
    or c
    jr z, .loop
    ld a, [wBattleActor]
    call SetBit1OfLevelUpGainsIndexed_Bank32
    ld d, $11
    call ShowBattleTextCategory0Entry
    jr ShowBattleTextCategory0Entry_ReturnCarry

.read_battle_actor:
    ld a, [wBattleActor]
    ld hl, wBattleStatus
    call AddAx9ToHL
    set BSTAT0_CONFUSED, [hl]
    ld a, [wBattleActor]
    call SetBit2OfLevelUpGainsIndexed_Bank32
    ld d, $12
    call ShowBattleTextCategory0Entry
    jr ShowBattleTextCategory0Entry_ReturnCarry

; D = battle text index: far-calls ShowBattleTextCategory0 (bank $3A) and returns. Called only by
; RollStatusTickEffect, for the texts $0F-$12. (C1, E-0380)
; far-calls ShowBattleTextCategory0 and returns; the next entry returns carry (E-0126)
ShowBattleTextCategory0Entry::
    farcall ShowBattleTextCategory0
    ret

; Returns carry. (C2, E-0357; probed E-0380)
ShowBattleTextCategory0Entry_ReturnCarry::
    scf
    ret

; The actor loses a sixth of its max HP: wBattleDamage = max HP / 6, subtracted from its HP with no
; floor. (C2, E-0357; probed E-0380)
; damage = the actor's max HP / 6 (wBattleDamageLo/Hi) is subtracted from the actor's HP without a
; floor: HP 10 with max HP 120 becomes $FFF6 (executed, test SixthOfMaxHPWithoutFloor); whether
; callers keep HP above the damage is not read (E-0121, E-0154)
ActorLosesSixthOfMaxHP::
    ld a, [wBattleActor]
    ld hl, wBattleHP
    add a
    add_a_to_hl
    push hl
    ld a, l
    add $10
    ld l, a
    ld a, h
    adc $00
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
    sub l
    ld [de], a
    inc de
    ld a, [de]
    sbc h
    ld [de], a
    ret

; The actor (wBattleActor) loses a sixth of its maximum MP: damage = max MP / 6 (0 when the maximum
; is 0) is stored in wBattleDamageLo and wBattleDamageHi and returned in BC, and is subtracted from
; the MP word of the actor, which is floored at 0. Called by RollStatusTickEffect, which stops
; quietly when BC is 0. (C2, E-0380)
; damage = the actor's max MP / 6 (0 when max MP is 0), subtracted from its MP and floored at 0
; (E-0125)
ActorLosesSixthOfMaxMP::
    ld a, [wBattleActor]
    call GetBattleMaxMP_Bank32
    ld a, h
    or l
    jr nz, .call_divide_hl_by_a
    ld bc, $0000
    jr .set_battle_damage_lo

.call_divide_hl_by_a:
    ld a, $06
    call DivideHLByA
    push hl
    ld a, [wBattleActor]
    ld hl, wBattleMP
    add a
    call ReadByteAtHLPlusA
    pop bc
    sub c
    ld [hli], a
    ld a, [hl]
    sbc b
    ld [hl], a
    jr nc, .set_battle_damage_lo
    xor a
    ld [hld], a
    ld [hl], a

.set_battle_damage_lo:
    ld a, c
    ld [wBattleDamageLo], a
    ld a, b
    ld [wBattleDamageHi], a
    ret

; Sets status byte 3 of the actor (wBattleStatus3 + 9 * wBattleActor) to 0. Called by
; RollStatusTickEffect. (C2, E-0380)
; the actor's status byte 3 (wBattleStatus3 + 9 * actor) = 0 (E-0115)
ClearActorStatus3::
    ld a, [wBattleActor]
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld [hl], $00
    ret

; A confused actor picks a random action (called only by
; RunBattleActions_StatusChecks_StartAction_Confused, which then shows text $14). AdvanceRandom
; first. An actor with status byte 3 & $C0 or status byte 4 & $0C gets action $C9. Otherwise
; wRandomLo picks: below $80 action $C0, below $C0 action $C1, else a table entry chosen by
; wRandomHi modulo the table count: PickRandomActionWhenUncontrolled_Data1 ($C2, $C3, $C5) in link
; battles (wLinkMode 1) and for slots 0-3, PickRandomActionWhenUncontrolled_Data2 ($C2-$C8 with $C6
; twice) for a foe outside a link battle; an entry $C8 becomes $C7 when wBattleKind is 2 or more.
; The action goes to wBattleActionId and the action byte of the actor in wBattleActionChoice,
; ChooseActionTarget picks the target and wBattleTarget is set from wBattleTargetChoice. (C1,
; E-0380)
; for an actor with status bits $C0 or $0C forces action $C9; otherwise picks action $C0, $C1 or a
; table action (PickRandomActionWhenUncontrolled_Data1 or 4E20) at random and stores it (E-0128)
PickRandomActionWhenUncontrolled::
    call AdvanceRandom
    ld a, [wBattleActor]
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hli]
    and $c0
    jr nz, .skip
    ld a, [hl]
    and $0c
    jr z, .check_random_lo

.skip:
    ld a, $c9
    jr .set_battle_action_id2

.check_random_lo:
    ld a, [wRandomLo]
    cp $80
    jr c, .skip3
    cp $c0
    jr c, .set_battle_action_id
    ld a, [wLinkMode]
    cp $01
    jr z, .read_random_hi
    ld a, [wBattleActor]
    cp $04
    jr c, .read_random_hi
    ld hl, PickRandomActionWhenUncontrolled_Data2
    jr .read_random_hi2

.read_random_hi:
    ld hl, PickRandomActionWhenUncontrolled_Data1

.read_random_hi2:
    ld a, [wRandomHi]
    ld b, a
    ld a, [hli]
    call DivideBByA
    call ReadByteAtHLPlusA
    cp $c8
    jr nz, .set_battle_action_id2
    ld a, [wBattleKind]
    cp $02
    jr c, .skip2
    ld a, $c7
    jr .set_battle_action_id2

.skip2:
    ld a, [hl]
    jr .set_battle_action_id2

.skip3:
    ld a, $c0
    jr .set_battle_action_id2

.set_battle_action_id:
    ld a, $c1

.set_battle_action_id2:
    ld b, a
    ld [wBattleActionId], a
    ld a, [wBattleActor]
    ld hl, wBattleActionChoice
    add a
    add_a_to_hl
    ld [hl], b
    farcall ChooseActionTarget
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a
    call ReadByteAtHLPlusA
    ld [wBattleTarget], a
    ret

; A count byte 3 followed by three action ids, $C2, $C3 and $C5. PickRandomActionWhenUncontrolled
; uses it when wLinkMode is 1 or the actor slot is below 4 (and wRandomLo is $C0 or more): it
; divides wRandomHi by the count, takes the remainder as the index and uses that action. (C1,
; E-0381)
PickRandomActionWhenUncontrolled_Data1::
    db $03, $c2, $c3, $c5

; A count byte 8 followed by eight action ids, $C2, $C3, $C4, $C5, $C6, $C7, $C8 and $C6.
; PickRandomActionWhenUncontrolled uses it for actor slots 4 and up when wLinkMode is not 1 (and
; wRandomLo is $C0 or more): wRandomHi divided by the count gives the index by its remainder. A pick
; of $C8 becomes $C7 when wBattleKind is 2 or more. (C1, E-0381)
PickRandomActionWhenUncontrolled_Data2::
    db $08, $c2, $c3, $c4, $c5, $c6, $c7, $c8, $c6

; Called as an action starts (RunBattleActions_StatusChecks_StartAction_Begin): wEffectFlags = 0,
; wDefeatStep = 0, wEffectId = $FF (no effect) and wBattleSubStep = 0; and, unless wFollowUpAction
; is non-zero, also wMultiHitCount = 0, wRedirectFlags = 0, wOriginalTarget = $FF and
; wActionRepeatFlag = 0, so a follow-up action keeps the multi-hit, redirect and original target
; state. (C2, E-0380)
; wEffectFlags = 0, wDefeatStep = 0, wEffectId = $FF, wBattleSubStep = 0; unless wFollowUpAction is
; set, also wMultiHitCount = 0, wRedirectFlags = 0, wOriginalTarget = $FF, wActionRepeatFlag = 0
; (E-0120)
ResetEffectStateForAction::
    xor a
    ld [wEffectFlags], a
    xor a
    ld [wDefeatStep], a
    ld a, $ff
    ld [wEffectId], a
    xor a
    ld [wBattleSubStep], a
    ld a, [wFollowUpAction]
    or a
    ret nz
    xor a
    ld [wMultiHitCount], a
    xor a
    ld [wRedirectFlags], a
    ld a, $ff
    ld [wOriginalTarget], a
    xor a
    ld [wActionRepeatFlag], a
    ret

; The sleep check: rolls against the sleep counter (status bits 2-3: 1 below $E0, 2 below $A0, 3
; below $60; none: always below $FF) to keep sleeping (counting the counter down, text $13, carry);
; otherwise wakes: clears the sleep bits, marks the level-up gain bit 2, clears status 3 bits 6-7 or
; 4 bits 2-3, sets the action to $BF and shows battle text $82 ('<name> woke up!') with the actor as
; target. (C1, E-0357)
RollSleepWakeUp::
    ld a, [hl]
    and $0c
    jr z, .check_random_lo
    cp $04
    jr z, .skip2
    cp $08
    jr z, .skip
    ld b, $60
    jr .check_random_lo2

.skip:
    ld b, $a0
    jr .check_random_lo2

.skip2:
    ld b, $e0
    jr .check_random_lo2

.check_random_lo:
    ld b, $ff

.check_random_lo2:
    ld a, [wRandomLo]
    cp b
    jr z, .skip5
    jr c, .skip5
    ld a, [hl]
    and $f3
    ld b, a
    ld a, [hl]
    and $0c
    dec a
    push bc
    push af
    pop bc
    bit 5, c
    pop bc
    jr nz, .skip3
    and $0c
    jr .skip4

.skip3:
    xor a

.skip4:
    or b
    ld [hl], a
    ld d, $13
    scf
    ret

.skip5:
    ld a, [hl]
    and $73
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
    ld a, [hli]
    and $c0
    jr nz, .next
    ld a, [hl]
    and $0c
    jr z, RollSleepWakeUp_ShowWokeUp
    ld a, [hl]
    and $f3
    ld [hl], a
    jr .read_battle_actor

.next:
    dec hl
    ld a, [hl]
    and $3f
    ld [hl], a

.read_battle_actor:
    ld a, [wBattleActor]
    ld hl, wBattleActionChoice
    add a

; Tail of RollSleepWakeUp, reached by falling through with A = 2 * wBattleActor and HL =
; wBattleActionChoice: sets the actor's action byte to $BF and jumps to the end of RollSleepWakeUp
; (wBattleTarget restored from wLoadSlot, carry clear) without the 'woke up!' text $82.
; RollSleepWakeUp comes here when the waking actor had status 3 bits 6-7 or status 4 bits 2-3 set
; (it clears them first); with neither it shows text $82 instead and does not set $BF. (C2, E-0372;
; probed E-0380)
RollSleepWakeUp_SetWakingAction::
    add_a_to_hl
    ld [hl], $bf
    jr RollSleepWakeUp_RestoreTarget

; On RollSleepWakeUp's wake path, when the actor had neither BSTAT3_AIRBORNE bits nor
; BSTAT4_HIGH_JUMP bits set: shows battle text $82 ('0 woke up!', with the actor as wBattleTarget)
; and falls into RollSleepWakeUp_RestoreTarget. (C1, E-0372)
RollSleepWakeUp_ShowWokeUp::
    ld d, $82 ; battle text '0 woke up!'
    farcall ShowBattleText

; The end of RollSleepWakeUp's wake path: puts wBattleTarget back from wLoadSlot and returns carry
; clear (the actor is awake). (C2, E-0372; probed E-0380)
RollSleepWakeUp_RestoreTarget::
    ld a, [wLoadSlot]
    ld [wBattleTarget], a
    scf
    ccf
    ret

; Keeps only bits 7-6 of status byte 3 of the actor (wBattleStatus3 + 9 * wBattleActor), clearing
; bits 0-5. Called by ShowActorStatusRecoveryMessage after a message. (C2, E-0380)
; keeps only bits 7-6 of the actor's status byte 3 (E-0115)
ClearActorStatus3Bits0To5::
    ld a, [wBattleActor]
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hl]
    and $c0
    ld [hl], a
    ret

; Step 1 of RunBattleActions_StatusChecks: wBattleSubStep picks 0
; RunBattleActions_StatusChecks_CheckAction_CheckMP (does the actor have the MP for its action; an
; action $D0-$E3 goes to the pair check instead), 1
; RunBattleActions_StatusChecks_CheckAction_FoeDupes, 2
; RunBattleActions_StatusChecks_CheckAction_Target, 3
; RunBattleActions_StatusChecks_CheckAction_SealPray and 4
; RunBattleActions_StatusChecks_CheckAction_MPAgain. (C1, E-0380)
; by its step: whether the actor's action is $D0-$E3, whether the queued action matches, and the
; skill's MP cost
RunBattleActions_StatusChecks_CheckAction::
    ld a, [wBattleSubStep]
    jumptable
    dw RunBattleActions_StatusChecks_CheckAction_CheckMP
    dw RunBattleActions_StatusChecks_CheckAction_FoeDupes
    dw RunBattleActions_StatusChecks_CheckAction_Target
    dw RunBattleActions_StatusChecks_CheckAction_SealPray
    dw RunBattleActions_StatusChecks_CheckAction_MPAgain

; Not a table: these ten bytes are SM83 code (CD 4C 51 38 49 7A FE 07 CA 4E), written as five dw by
; the generator. They decode to call $514C (CheckFormationPartnersCanAct), jr c to $4F4E (the ld hl,
; wBattleSubStep / inc [hl] / ret tail), ld a, d, cp $07 and jp z to $4F4E, whose last operand byte
; $4F is the first byte of ApplyActionResultAndMarkFormation.
; RunBattleActions_StatusChecks_CheckAction_CheckMP reaches it with jr nz when ActorActionIsD0ToE3
; returns non-zero. (C1, E-0381)
RunBattleActions_StatusChecks_CheckAction_Skip::
    dw $4ccd
    dw $3851
    dw BattleActions_ZeroPadding
    dw $07fe
    dw RollSleepWakeUp_SetWakingAction

; Refusal of a two-monster action ($D0-$E3): A = D = the reason from CheckFormationPartnersCanAct,
; reached by falling through from RunBattleActions_StatusChecks_CheckAction_Skip. The dw lines of
; that label are really code: call CheckFormationPartnersCanAct, jr c, ld a, d, cp 7 and jp z, which
; add 1 to wBattleSubStep and skip this routine when the pair can act or the reason is 7. Reasons
; 1-6 call ShowActionRefusedMessage and CheckActionD0ToE3OrSpecial pays the MP unless the reason is
; 1; reason 0 (a monster of the pair is blocked by a status, or the partner has acted) shows
; ShowSpecialActionMessage. Then SetSubPhase7AndResetSteps ends the action and the formation partner
; of the actor (ActorFormationSlotToTemp0) gets wSlotMarks 3 unless it has status byte 3 bits 6-7 or
; byte 4 bits 2-3 (SlotHasStatus3Or4Bits_Bank32). (C1, E-0380)
; for C & 7 non-zero runs ShowActionRefusedMessage (and CheckActionD0ToE3OrSpecial unless the result
; is 1), else shows the special action message; then sets sub-phase 7 and marks the formation slot
; unless it has status 3/4 bits (E-0126)
ApplyActionResultAndMarkFormation::
    ld c, a
    and $07
    jr z, .call_show_special_action_message
    push de
    farcall ShowActionRefusedMessage
    pop af
    cp $01
    call nz, CheckActionD0ToE3OrSpecial
    call SetSubPhase7AndResetSteps
    farcall ActorFormationSlotToTemp0
    ldh a, [hTemp0]
    call SlotHasStatus3Or4Bits_Bank32
    ret nz
    farcall RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3
    ret

.call_show_special_action_message:
    farcall ShowSpecialActionMessage
    call SetSubPhase7AndResetSteps
    farcall ActorFormationSlotToTemp0
    ldh a, [hTemp0]
    call SlotHasStatus3Or4Bits_Bank32
    ret nz
    farcall RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3
    ret
    db $21, $cc, $cf, $34, $c9

; Checking the action, step 0: for a skill (not $D0-$E3, $BF or $C9-$CF) checks the MP cost; with
; too little MP a player-controlled actor (or AI mode below 2) shows the 'not enough MP' line and
; ends the action, while an AI actor of mode 2 and up (not Berserker, not confused) chooses again
; (AIChooseActionForActor); otherwise goes on. (C1, E-0357)
RunBattleActions_StatusChecks_CheckAction_CheckMP::
    farcall ActorActionIsD0ToE3
    ldh a, [hTemp0]
    or a
    jr nz, RunBattleActions_StatusChecks_CheckAction_Skip
    call LoadActorChosenActionRecord
    call ActionIsSpecialBFOrC9ToCF
    jp nc, .done
    call CheckSkillMPCost
    jr c, .read_battle_actor
    ld a, [wBattleActor]
    ld hl, wSideControl
    add_a_to_hl
    bit 7, [hl]
    jr z, .loop
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank32
    cp $02
    jr nc, .check_battle_action_id

.loop:
    ld a, d
    cp $07
    jp z, .done
    push de
    farcall ShowActionRefusedMessage
    pop af
    cp $01
    call nz, CheckActionD0ToE3OrSpecial
    call SetSubPhase7AndResetSteps
    ret

.read_battle_actor:
    ld a, [wBattleActor]
    ld hl, wSideControl
    add_a_to_hl
    bit 7, [hl]
    jr z, .done
    ld a, [wBattleActor]
    ld hl, wActorActionBytes
    call ReadByteAtHLPlusA
    or a
    jr nz, .done
    ld a, [wRecordBufferData + $5]
    bit 2, a
    jr nz, .done
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank32
    cp $03
    jr c, .done

.check_battle_action_id:
    ld a, [wBattleActionId]
    cp SKILL_BERSERKER
    jr z, .done
    ld a, [wBattleActor]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    and $10
    jr nz, .done
    farcall AIChooseActionForActor
    call LoadActorChosenActionRecord
    ld a, [wBattleActor]
    ld hl, wBattleActionChoice
    add a
    call ReadByteAtHLPlusA
    ld [wBattleActionId], a
    inc hl
    ld [hl], $ff
    call CheckSkillMPCost
    jr nc, .loop

.done:
    ld hl, wBattleSubStep
    inc [hl]
    ret

; Checking the action, step 1: outside link mode 1 (wLinkMode), for a foe actor (wBattleActor 4 or
; more) when wActionQueuePos is non-zero: if an earlier wActionQueue entry that is a foe (4 or more,
; not $10) with wSlotMarks 3 or $FE chose the same action as wBattleActionId, and that action is in
; FoeNoRepeatSkills, the actor loses its action (action 0, target $FF) and its record is reloaded
; (LoadActorChosenActionRecord). Then wBattleSubStep += 1. (C2, E-0372; probed E-0380)
RunBattleActions_StatusChecks_CheckAction_FoeDupes::
    ld a, [wLinkMode]
    cp $01
    jr z, .done
    ld a, [wBattleActor]
    cp $04
    jr c, .done
    ld a, [wActionQueuePos]
    or a
    jr z, .done
    ld b, a
    ld hl, wActionQueue

.loop:
    ld a, [hl]
    cp $10
    jr z, .next
    cp $04
    jr c, .next
    push hl
    ld hl, wSlotMarks
    call ReadByteAtHLPlusA
    pop hl
    cp $03
    jr z, .skip
    cp $fe
    jr nz, .next

.skip:
    push hl
    ld a, [hl]
    ld hl, wBattleActionChoice
    add a
    add_a_to_hl
    ld a, [wBattleActionId]
    cp [hl]
    pop hl
    jr z, .read_battle_action_id

.next:
    inc hl
    dec b
    jr nz, .loop
    jr .done

.read_battle_action_id:
    ld a, [wBattleActionId]
    ld c, a
    push hl
    ld hl, FoeNoRepeatSkills

.skip2:
    ld a, [hli]
    cp $ff
    jr z, .restore
    cp c
    jr z, .read_battle_actor
    jr .skip2

.restore:
    pop hl
    jr .next

.read_battle_actor:
    pop hl
    ld a, [wBattleActor]
    ld hl, wBattleActionChoice
    add a
    add_a_to_hl
    ld [hl], $00
    inc hl
    ld [hl], $ff
    call LoadActorChosenActionRecord

.done:
    ld hl, wBattleSubStep
    inc [hl]
    ret

; 62 skill ids ending in $FF, from SKILL_FIREBAL to SKILL_WARCRY (among them SKILL_BEAT,
; SKILL_SLEEPALL, SKILL_FIREAIR, SKILL_CALLHELP, SKILL_GIGASLASH and
; SKILL_KODANCE).RunBattleActions_StatusChecks_CheckAction_FoeDupes scans it for wBattleActionId: an
; action on this list that an earlier foe in the queue already chose is taken from the next foe.
; (C1, E-0372)
FoeNoRepeatSkills::
    db $04, $05, $06, $07, $08, $09, $0a, $0b, $0c, $0d, $0e, $0f, $10, $11, $12, $13
    db $14, $15, $19, $1a, $26, $28, $2a, $2c, $2e, $2f, $30, $33, $3d, $3e, $3f, $40
    db $41, $42, $43, $44, $45, $46, $47, $49, $4a, $4b, $4d, $4e, $4f, $64, $65, $66
    db $67, $6b, $6c, $6d, $6f, $70, $71, $72, $73, $74, $79, $7a, $8e, $90, $ff

; Checking the action, step 2: picks the target: an unset target, an AI actor of mode 2 and up, or a
; group or kind-4 skill chooses it (ChooseActionTarget); then wBattleTarget is the actor's target
; choice. (C1, E-0357)
RunBattleActions_StatusChecks_CheckAction_Target::
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a
    call ReadByteAtHLPlusA
    cp $ff
    jr z, .call_choose_action_target
    ld a, [wBattleActor]
    ld hl, wSideControl
    add_a_to_hl
    bit 7, [hl]
    jr nz, .read_battle_actor
    ld a, [wRecordBufferData + $4]
    and $0f
    cp $01
    jr z, .read_battle_actor2

.read_battle_actor:
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank32
    cp $02
    jr nc, .call_choose_action_target
    ld a, [wRecordBufferData + $4]
    and $0f
    cp $02
    jr z, .call_choose_action_target
    cp $04
    jr z, .call_choose_action_target
    jr .read_battle_actor2

.call_choose_action_target:
    farcall ChooseActionTarget

.read_battle_actor2:
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a
    call ReadByteAtHLPlusA
    ld [wBattleTarget], a
    ld hl, wBattleSubStep
    inc [hl]
    ret

; Checking the action, step 3: first moves on (wBattleResolveStep += 1, wBattleSubStep = 0). When
; wBattleActionId matches wQueuedActionId or its pair (QueuedActionMatches), the action that
; RunBattleActions_StatusChecks_ShatterChecks_Detect stores when it breaks a BSTAT8_SEAL_PRAY,
; builds action message 2 (ShowActionRefusedMessage), runs CheckActionD0ToE3OrSpecial when
; wRecordBufferData is non-zero and ends the action (SetSubPhase7AndResetSteps). (C1, E-0372)
RunBattleActions_StatusChecks_CheckAction_SealPray::
    ld hl, wBattleResolveStep
    inc [hl]
    xor a
    ld [wBattleSubStep], a
    ld a, [wBattleActionId]
    call QueuedActionMatches
    ret nz
    ld d, $02
    farcall ShowActionRefusedMessage
    ld a, [wRecordBufferData]
    or a
    call nz, CheckActionD0ToE3OrSpecial
    call SetSubPhase7AndResetSteps
    ret

; Checking the action, step 4: runs CheckSkillMPCost again. When the actor can pay (carry), or
; cannot with D = 7, goes back two sub-steps (wBattleSubStep -= 2). Otherwise calls
; CheckActionD0ToE3OrSpecial unless D = 1 and ends the action (SetSubPhase7AndResetSteps); unlike
; step 0 it builds no message itself. (C2, E-0372; probed E-0380)
RunBattleActions_StatusChecks_CheckAction_MPAgain::
    call CheckSkillMPCost
    jr c, .skip
    ld a, d
    cp $07
    jr z, .skip
    cp $01
    call nz, CheckActionD0ToE3OrSpecial
    call SetSubPhase7AndResetSteps
    ret

.skip:
    ld hl, wBattleSubStep
    dec [hl]
    ld hl, wBattleSubStep
    dec [hl]
    ret

; Called from the pair block RunBattleActions_StatusChecks_CheckAction_Skip when the chosen action
; of the actor is $D0-$E3 (ActorActionIsD0ToE3). Checks the actor and its formation partner
; (ActorFormationSlotToTemp0) against the skill each has saved in wSavedActionChoices: the skill
; record is loaded, hTemp2 = its cost, and the slot must pass CheckSlotStatusBlockWide_Bank32 and
; CheckSkillMPCost (the partner must also not have wSlotMarks 3). hTemp1 bit 0 = the actor failed,
; bit 1 = the partner failed. Carry set when both pass (D is then clobbered by LoadSkillRecord);
; otherwise carry clear, A = 0 and D = the reason of the first failure, the actor before the partner
; (0 for a status block or mark 3, else the D of CheckSkillMPCost). wBattleActor is restored and the
; chosen action record of the actor is reloaded (LoadActorChosenActionRecord) either way. (C2,
; E-0380)
; for the actor and its formation partner checks status blocks and MP costs of their stored actions
; (wSavedActionChoices) and returns flags in hTemp1 (E-0129)
CheckFormationPartnersCanAct::
    xor a
    ldh [hTemp1], a
    ld a, [wBattleActor]
    add a
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
    jr nc, .call_check_skill_mp_cost
    ld d, $00
    jr .set_temp1_to_01

.call_check_skill_mp_cost:
    call CheckSkillMPCost
    jr c, .read_battle_actor

.set_temp1_to_01:
    ld a, $01
    ldh [hTemp1], a

.read_battle_actor:
    push de
    ld a, [wBattleActor]
    push af
    farcall ActorFormationSlotToTemp0
    ldh a, [hTemp0]
    ld [wBattleActor], a
    add a
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
    jr c, .skip
    ld a, [wBattleActor]
    ld hl, wSlotMarks
    add_a_to_hl
    ld a, [hl]
    cp $03
    jr nz, .call_check_skill_mp_cost2

.skip:
    ld d, $00
    jr .check_temp1

.call_check_skill_mp_cost2:
    call CheckSkillMPCost
    jr c, .set_battle_actor

.check_temp1:
    ldh a, [hTemp1]
    or $02
    ldh [hTemp1], a

.set_battle_actor:
    pop af
    ld [wBattleActor], a
    ldh a, [hTemp1]
    or a
    jr z, .call_load_actor_chosen_action_record3
    bit 0, a
    jr z, .check_bit1
    pop de
    jr .call_load_actor_chosen_action_record2

.check_bit1:
    bit 1, a
    jr z, .call_load_actor_chosen_action_record
    ld a, d
    pop de
    ld d, a
    jr .call_load_actor_chosen_action_record2

.call_load_actor_chosen_action_record:
    pop de

.call_load_actor_chosen_action_record2:
    push de
    call LoadActorChosenActionRecord
    pop de
    xor a
    ret

.call_load_actor_chosen_action_record3:
    call LoadActorChosenActionRecord
    pop de
    scf
    ret

; Can the actor (wBattleActor) use the action in wBattleActionId? Out: carry set = yes, D unchanged;
; carry clear with A = 0 and D = the reason: 1 not enough MP, 2 the action matches wQueuedActionId
; (QueuedActionMatches), 3-7 from the seal checks below. The cost is byte 0 of the record in
; wRecordBufferData, copied to hTemp2, except for actions $D0-$E3 where the hTemp2 left by the
; caller is used; for the MP test cost 0 passes, cost $FF passes unless MP is 0, otherwise the
; 16-bit MP minus the cost must not be negative. Then record byte 5 (wRecordBufferData + 5) bit 6,
; else bit 4, else bit 5 picks CheckActorStatusAndFoeTargets, CheckActorStatusBit7AndFoeBit6 or
; CheckActorStatusBit6, which must pass. Last, an actor with wSlotAIMode 2 or more is refused with D
; = 7 for a skill with record byte 5 bit 3 when every present slot of the other side has
; BSTAT2_AQUA_WALL. MP is not changed. (C2, E-0380)
; for a skill action (wBattleActionId outside $D0-$E3) the cost is byte 0 of the record in
; wRecordBufferData, copied to hTemp2. The actor's MP minus the cost is computed in HL; a negative
; result returns with D = 1 (not enough MP) and carry clear. Equal MP and cost succeeds (D = 0,
; carry set). The MP is not written here (E-0048)
CheckSkillMPCost::
    ld a, [wBattleActionId]
    cp ACTION_D0
    jr c, .read_record_buffer_data
    cp $e4
    jr nc, .read_record_buffer_data
    jr .read_battle_actor

.read_record_buffer_data:
    ld a, [wRecordBufferData]
    ldh [hTemp2], a

.read_battle_actor:
    ld a, [wBattleActor]
    call GetBattleMP_Bank32
    ldh a, [hTemp2]
    or a
    jr z, .read_battle_action_id
    ld a, h
    or l
    jp z, .skip2
    ldh a, [hTemp2]
    cp $ff
    jr z, .read_battle_action_id
    ld c, a
    ld a, l
    sub c
    ld l, a
    ld a, h
    sbc $00
    ld h, a
    bit 7, h
    jr nz, .skip2

.read_battle_action_id:
    ld a, [wBattleActionId]
    call QueuedActionMatches
    jr z, .done
    ld a, [wRecordBufferData + $5]
    bit 6, a
    jr z, .check_bit4
    call CheckActorStatusAndFoeTargets
    jr nc, .return_0
    jr .read_battle_actor2

.check_bit4:
    bit 4, a
    jr z, .check_bit5
    call CheckActorStatusBit7AndFoeBit6
    jr nc, .return_0
    jr .read_battle_actor2

.check_bit5:
    bit 5, a
    jr z, .read_battle_actor2
    call CheckActorStatusBit6
    jr nc, .return_0
    jr .read_battle_actor2

.read_battle_actor2:
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank32
    cp $02
    jr c, .return_carry
    ld a, [wRecordBufferData + $5]
    bit 3, a
    jr z, .return_carry
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03
    ld hl, wBattleStatus2
    call AddAx9ToHL

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .skip
    bit 3, [hl]
    jr z, .return_carry

.skip:
    ld a, l
    add $09
    ld l, a
    ld a, h
    adc $00
    ld h, a
    inc c
    dec b
    jr nz, .loop
    ld d, $07
    jr .return_0

.return_carry:
    scf
    ret

.skip2:
    ld d, $01
    jr .return_0

.done:
    ld d, $02

.return_0:
    xor a
    ret

; Seal check of CheckSkillMPCost for a skill with record byte 5 bit 6. Carry set = allowed; carry
; clear with A = 0 and D = 3 when the actor has BSTAT1_SPELLS_SEALED, D = 4 when bit 3 of the side
; flags of the actor is set (wSideFlags0 for slots 0-3, wSideFlags1 for 4-7), or D = 7 for an actor
; with wSlotAIMode 2 or more and record byte 4 = $12 when every present slot of the other side has
; status byte 2 bit 1 or 5 ($22: BSTAT2_BOUNCE or BSTAT2_MAGIC_BACK). (C2, E-0380)
; returns carry set when the action may proceed, clear when refused. Refused with D = 3 when bit 0
; of the actor's status byte 1 (wBattleStatus1 + 9 * actor) is set; with D = 4 when bit 3 of the
; side flag (wSideFlags0 for slots 0-3, wSideFlags1 for 4-7) is set. Otherwise, when
; wSlotAIMode[actor] >= 2 and wRecordBufferData + $4 = $12, the three opposite slots are scanned: an
; absent slot is skipped, a present slot without bit 1 or 5 of its status byte 2 allows the action,
; and if every present one has them the refusal is D = 7 (E-0049)
CheckActorStatusAndFoeTargets::
    ld a, [wBattleActor]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit BSTAT1_SPELLS_SEALED, [hl]
    jr nz, .skip3
    ld hl, wSideFlags0
    ld a, [wBattleActor]
    cp $04
    jr c, .skip
    ld hl, wSideFlags1

.skip:
    bit 3, [hl]
    jp nz, .done
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank32
    cp $02
    jr c, .return_carry
    ld a, [wRecordBufferData + $4]
    cp $12
    jr nz, .return_carry
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03
    ld hl, wBattleStatus2
    call AddAx9ToHL

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .skip2
    ld a, [hl]
    and $22
    jr z, .return_carry

.skip2:
    ld a, l
    add $09
    ld l, a
    ld a, h
    adc $00
    ld h, a
    inc c
    dec b
    jr nz, .loop
    ld d, $07
    jr .return_0

.skip3:
    ld d, $03
    jr .return_0

.done:
    ld d, $04

.return_0:
    xor a
    ret

.return_carry:
    scf
    ret

; Seal check of CheckSkillMPCost for a skill with record byte 5 bit 4. Carry set = allowed; carry
; clear with A = 0 and D = 5 when the actor has BSTAT1_BREATH_SEALED; for an actor with wSlotAIMode
; 2 or more D = 7 when every present slot of the other side has BSTAT2_WIND_GUARD (status byte 2 bit
; 6). (C2, E-0380)
; carry set = may proceed, clear = refused. Refused with D = 5 when bit 7 of the actor's status byte
; 1 (wBattleStatus1 + 9 * actor) is set; otherwise when wSlotAIMode[actor] >= 2 the three opposite
; slots are scanned for a present slot whose status byte 2 (wBattleStatus2 + 9 * slot) has bit 6
; clear (allowed), and if every present one has bit 6 set the refusal is D = 7 (E-0049)
CheckActorStatusBit7AndFoeBit6::
    ld a, [wBattleActor]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit BSTAT1_BREATH_SEALED, [hl]
    jr nz, .done
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank32
    cp $02
    jr c, .return_carry
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03
    ld hl, wBattleStatus2
    call AddAx9ToHL

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .skip
    bit 6, [hl]
    jr z, .return_carry

.skip:
    ld a, l
    add $09
    ld l, a
    ld a, h
    adc $00
    ld h, a
    inc c
    dec b
    jr nz, .loop
    ld d, $07
    jr .return_0

.done:
    ld d, $05

.return_0:
    xor a
    ret

.return_carry:
    scf
    ret

; Seal check of CheckSkillMPCost for a skill with record byte 5 bit 5. Carry set = allowed; carry
; clear with A = 0 and D = 6 when the actor has BSTAT1_DANCE_SEALED (bit 6 of status byte 1). (C2,
; E-0380)
; carry set = may proceed; clear with D = 6 when bit 6 of the actor's status byte 1 (wBattleStatus1
; + 9 * actor) is set (E-0049)
CheckActorStatusBit6::
    ld a, [wBattleActor]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit BSTAT1_DANCE_SEALED, [hl]
    jr nz, .done
    jr .return_carry

.done:
    ld d, $06
    xor a
    ret

.return_carry:
    scf
    ret

; Tests wBattleActionId: A = 0 and carry clear when it is $BF or $C9-$CF (actions that cost no MP
; and are not skills), otherwise carry set (A = the id). (C2, E-0380)
; A = 0 for action $BF or $C9-$CF, otherwise carry (E-0124)
ActionIsSpecialBFOrC9ToCF::
    ld a, [wBattleActionId]
    cp ACTION_BF
    jr z, .return_0
    cp ACTION_C9
    jr z, .return_0
    cp ACTION_CA
    jr z, .return_0
    cp ACTION_CB
    jr z, .return_0
    cp ACTION_CC
    jr z, .return_0
    cp ACTION_CD
    jr z, .return_0
    cp ACTION_CE
    jr z, .return_0
    cp ACTION_CF
    jr z, .return_0
    scf
    ret

.return_0:
    xor a
    ret

; Pays the MP of the action in wBattleActionId: an action $D0-$E3 goes to PayActorMPCost_CpD6 (both
; monsters of the pair pay), a special action ($BF, $C9-$CF) returns with nothing paid, and any
; other action falls into PayActorMPCost. (C2, E-0380)
; actions $D0-$E3 continue at PayActorMPCost_CpD6; otherwise returns unless
; ActionIsSpecialBFOrC9ToCF (E-0126)
CheckActionD0ToE3OrSpecial::
    ld a, [wBattleActionId]
    cp ACTION_D0
    jr c, .call_action_is_special_bf_or_c9_to_cf
    cp $e4
    jr nc, .call_action_is_special_bf_or_c9_to_cf
    jr PayActorMPCost_CpD6

.call_action_is_special_bf_or_c9_to_cf:
    call ActionIsSpecialBFOrC9ToCF
    ret nc

; Subtracts the cost (byte 0 of wRecordBufferData) from the MP word of the actor (wBattleActor) with
; no floor (MP 3 minus 5 gives $FFFE) and sets bit 1 of wLevelUpGains[actor], which asks
; RedrawChangedSlotPanels to redraw the MP digits. A cost of 0 returns at once; the cost $FF takes
; all MP: the old MP word goes to wAllMPSpentLo and wAllMPSpentHi and MP becomes 0. (C2, E-0380)
; subtracts the skill's MP cost (wRecordBufferData) from the actor's MP; cost $FF takes all MP and
; saves it in wAllMPSpentLo; marks the MP digits for redraw (E-0128)
PayActorMPCost::
    ld a, [wBattleActor]
    ld hl, wBattleMP
    add a
    add_a_to_hl
    ld a, [wRecordBufferData]
    or a
    ret z
    cp $ff
    jr z, .set_all_mp_spent_lo
    ld c, a
    ld a, [hl]
    sub c
    ld [hli], a
    ld a, [hl]
    sbc $00
    ld [hl], a
    jr .read_battle_actor

.set_all_mp_spent_lo:
    ld a, [hli]
    ld [wAllMPSpentLo], a
    ld a, [hl]
    ld [wAllMPSpentHi], a
    xor a
    ld [hld], a
    ld [hl], a

.read_battle_actor:
    ld a, [wBattleActor]
    call SetBit1OfLevelUpGainsIndexed_Bank32
    ret

; Pays the MP of a two-monster action: actions $D6 and $D9 take all MP from both the actor and its
; formation partner; others charge each its saved skill's cost; then reloads the actor's action
; record. (C2, E-0357; probed E-0380)
PayActorMPCost_CpD6::
    cp $d6
    jr z, .set_record_buffer_data_to_FF
    cp $d9
    jr z, .set_record_buffer_data_to_FF
    ld a, [wBattleActor]
    ld hl, wSavedActionChoices
    add a
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
    add a
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

.set_record_buffer_data_to_FF:
    ld a, $ff
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

; wBattleSubPhase = 7 (RunBattleActions_MarkActorDone), wBattleResolveStep = 0 and wBattleSubStep =
; 0: ends the current action. Used when an action is refused or shattered. (C2, E-0380)
; wBattleSubPhase = 7, wBattleResolveStep = 0, wBattleSubStep = 0 (E-0115)
SetSubPhase7AndResetSteps::
    ld a, $07
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    xor a
    ld [wBattleSubStep], a
    ret

; Status checks, step 2: by the actor's personality act (bits 6, 4, 2) shows battle text $34, $32 or
; $30. (C1, E-0357)
RunBattleActions_StatusChecks_PersonalityText::
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wBattleActor]
    ld hl, wPersonalityActs
    add a
    call ReadByteAtHLPlusA
    and $54
    ret z
    bit 6, a
    jr nz, .call_show_battle_text_category0
    bit 2, a
    jr nz, .skip
    ld d, $32
    jr .call_show_battle_text_category02

.skip:
    ld d, $30
    jr .call_show_battle_text_category02

.call_show_battle_text_category0:
    ld d, $34

.call_show_battle_text_category02:
    farcall ShowBattleTextCategory0
    ret

; Status checks, step 3: shows the action's battle text, selects its effect and, in battle kinds 4-5
; outside a link, remembers a foe's skill below $B0 (not $AB or $AC) for learning
; (wLearnSkillState). (C1, E-0357)
RunBattleActions_StatusChecks_ShowActionText::
    ld hl, wBattleResolveStep
    inc [hl]
    farcall ShowActionBattleTextFromActionBattleTextTable
    ld a, $80
    ld [wEffectFlags2], a
    farcall SelectEffectByEffectFlags2Flags
    ld a, [wLinkMode]
    or a
    ret nz
    ld a, [wBattleKind]
    cp $04
    ret c
    cp $06
    ret nc
    ld a, [wBattleActor]
    cp $04
    ret c
    ld a, [wBattleActionId]
    or a
    ret z
    cp $ab
    ret z
    cp $ac
    ret z
    cp $b0
    ret nc
    ld [wLearnSkillState], a
    ret

; Status checks, step 4: an actor held by status 3 (bits 6-7 = 1) breaks free only when it is not
; paralyzed and has body flag bit 4, otherwise loses the turn (sub-phase on, resolve step 6);
; otherwise by personality act bits 0-1 shows battle text $2F, or $2E for a skill with record byte 6
; bit 3. (C1, E-0357)
RunBattleActions_StatusChecks_BreakFree::
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wBattleActor]
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hl]
    and $c0
    cp $40
    jr nz, .read_battle_actor
    ld a, [wBattleActor]
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit BSTAT0_PARALYZED, [hl]
    jr nz, .skip2
    ld a, [wBattleActor]
    ld de, wSlotBodyFlags
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    bit 4, a
    jr nz, .next

.skip2:
    ld hl, wBattleSubPhase
    inc [hl]
    ld a, $06
    ld [wBattleResolveStep], a
    ret

.next:
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    and $3f
    ld [hl], a
    call SetSubPhase7AndResetSteps
    ret

.read_battle_actor:
    ld a, [wBattleActor]
    ld hl, wPersonalityActs
    add a
    call ReadByteAtHLPlusA
    and $03
    ret z
    bit 0, a
    jr nz, .check_record_buffer_data
    ld d, $2f
    jr .call_show_battle_text_category0

.check_record_buffer_data:
    ld a, [wRecordBufferData + $6]
    bit 3, a
    ret z
    ld d, $2e

.call_show_battle_text_category0:
    farcall ShowBattleTextCategory0
    ret

; Status checks, step 5: once the sound channels are free goes on and, unless the action is $CD,
; selects its effect (flags $80). (C2, E-0357; probed E-0380)
RunBattleActions_StatusChecks_SelectEffect::
    ld a, [wSoundChannelSlots]
    ld hl, wSoundChannel1
    and [hl]
    cp $ff
    ret nz
    ld hl, wBattleResolveStep
    inc [hl]
    xor a
    ld [wBattleSubStep], a
    call CompareActionIdWithCD
    ret z
    ld a, $80
    ld [wEffectFlags], a
    farcall SelectEffectByEffectFlags
    ret

; Compares wBattleActionId with $CD (carry when below, Z when equal). Called only by
; RunBattleActions_StatusChecks_SelectEffect. (C2, E-0380)
; compares wBattleActionId with $CD: carry when below, Z when equal (E-0115)
CompareActionIdWithCD::
    ld a, [wBattleActionId]
    cp ACTION_CD
    ret

; Step 6 of RunBattleActions_StatusChecks: wBattleSubStep picks 0
; RunBattleActions_StatusChecks_ShatterChecks_Detect, 1
; RunBattleActions_StatusChecks_ShowGWasShattered ('shattered!'), 2
; RunBattleActions_StatusChecks_ShowSealPrayBroken ('SealPray was broken!') and 3
; RunBattleActions_StatusChecks_ShatterChecks_End (pay the MP and end the action). (C1, E-0380)
; by its step: 'G was shattered!' and 'SealPray was broken!', then CheckActionD0ToE3OrSpecial
RunBattleActions_StatusChecks_ShatterChecks::
    ld a, [wBattleSubStep]
    jumptable
    dw RunBattleActions_StatusChecks_ShatterChecks_Detect
    dw RunBattleActions_StatusChecks_ShowGWasShattered
    dw RunBattleActions_StatusChecks_ShowSealPrayBroken
    dw RunBattleActions_StatusChecks_ShatterChecks_End

; Shatter checks, step 0: loads the actor's chosen action and target into wBattleActionId and
; wBattleTarget. For a skill with wRecordBufferData + 8 bit 7 aimed at a slot with BSTAT8_SEAL_PRAY,
; or one with wRecordBufferData + 4 low nibble 2 or SKILL_IRONIZE while any present slot of the
; target's side has it, clears that bit, moves wQueuedActionId to wSealPrayState, puts the action in
; wQueuedActionId and goes to the next sub-step. Otherwise the next resolve step (wBattleResolveStep
; += 1, wBattleSubStep = 0). (C2, E-0372; probed E-0380)
RunBattleActions_StatusChecks_ShatterChecks_Detect::
    ld a, [wBattleActor]
    ld hl, wBattleActionChoice
    add a
    call ReadByteAtHLPlusA
    ld [wBattleActionId], a
    inc hl
    ld a, [hl]
    ld [wBattleTarget], a
    ld a, [wRecordBufferData + $8]
    bit 7, a
    jr z, .skip2
    ld a, [wRecordBufferData + $4]
    and $0f
    cp $02
    jr z, .check_battle_target
    ld a, [wBattleActionId]
    cp SKILL_IRONIZE
    jr z, .check_battle_target
    ld a, [wBattleTarget]
    ld hl, wBattleStatus8
    call AddAx9ToHL
    bit BSTAT8_SEAL_PRAY, [hl]
    jr nz, .skip3
    jr .skip2

.check_battle_target:
    ld a, [wBattleTarget]
    and $04
    ld c, a
    ld b, $03
    ld hl, wBattleStatus8
    call AddAx9ToHL

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .skip
    bit 4, [hl]
    jr nz, .skip3

.skip:
    ld a, l
    add $09
    ld l, a
    ld a, h
    adc $00
    ld h, a
    inc c
    dec b
    jr nz, .loop

.skip2:
    ld hl, wBattleResolveStep
    inc [hl]
    xor a
    ld [wBattleSubStep], a
    ret

.skip3:
    res 4, [hl]
    ld hl, wQueuedActionId
    ld a, [hli]
    ld [hld], a
    ld a, [wBattleActionId]
    ld [hl], a
    ld hl, wBattleSubStep
    inc [hl]
    ret

; Shatter checks, step 1: battle text $B0 ('... was shattered!'). (C1, E-0357)
RunBattleActions_StatusChecks_ShowGWasShattered::
    ld hl, wBattleSubStep
    inc [hl]
    ld d, $b0 ; battle text 'G was shattered!'
    farcall ShowBattleText
    ret

; Shatter checks, step 2: when a SealPray was set, battle text $92 ('SealPray was broken!') and
; clears it. (C1, E-0357)
RunBattleActions_StatusChecks_ShowSealPrayBroken::
    ld hl, wBattleSubStep
    inc [hl]
    ld a, [wSealPrayState]
    cp $ff
    ret z
    ld d, $92 ; battle text 'SealPray was broken!'
    farcall ShowBattleText
    ld a, $ff
    ld [wSealPrayState], a
    ret

; Shatter checks, step 3: CheckActionD0ToE3OrSpecial (actions $D0-$E3 go on to PayActorMPCost_CpD6),
; then ends the action (SetSubPhase7AndResetSteps). (C2, E-0372; probed E-0380)
RunBattleActions_StatusChecks_ShatterChecks_End::
    call CheckActionD0ToE3OrSpecial
    call SetSubPhase7AndResetSteps
    ret

; Step 7 of RunBattleActions_StatusChecks (also called by
; RunBattleStep4_ResolveSkill_CheckLinkRules): adds 1 to wBattleResolveStep, then returns unless
; wLinkMode is 1, wLinkRules is non-zero, wMultiHitCount is 0, the action is not special
; (ActionIsSpecialBFOrC9ToCF) and bit 7 of wLinkRules + 1 is set.
; CheckLinkRuleViolation_Data[wBattleActionId] gives the rule bits of the action (0 = none), masked
; with wLinkRules + 1. A bit missing from wLinkRules + 2 is a violation at once; a bit present is
; allowed once: the first use is recorded in wLinkRuleFlags (actor in slots 0-3) or wLinkRuleState
; (slots 4-7) and a second use is a violation. A violation queues music 2, picks the message for the
; side that broke the rule (text $63 with wBattleScene 5 for the local side, $64 with 4 otherwise:
; 'You broke a battle rule!' / 'Your opponent broke a rule!'), shows it and ends the battle phase
; (wBattlePhase 2, wBattleStep 9). (C1, E-0380)
; in link battles with rules on: an action forbidden by the wLinkRules + $1/wLinkRules + $2 rules
; (CheckLinkRuleViolation_Data) ends the battle with music 2 and a message for the side that broke
; it (E-0128)
CheckLinkRuleViolation::
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wLinkMode]
    or a
    ret z
    cp $02
    ret z
    ld a, [wLinkRules]
    or a
    ret z
    ld a, [wMultiHitCount]
    or a
    ret nz
    call ActionIsSpecialBFOrC9ToCF
    ret nc
    ld a, [wLinkRules + $1]
    bit 7, a
    ret z
    ld b, a
    ld a, [wBattleActionId]
    ld hl, CheckLinkRuleViolation_Data
    add_a_to_hl
    ld a, [hl]
    or a
    ret z
    and b
    ret z
    ld c, a
    ld a, [wLinkRules + $2]
    and c
    jr z, .call_queue_music
    ld hl, wLinkRuleFlags
    ld a, [wBattleActor]
    cp $04
    jr c, .skip
    ld hl, wLinkRuleState

.skip:
    ld a, c
    and [hl]
    jr nz, .call_queue_music
    ld a, c
    or [hl]
    ld [hl], a
    ret

.call_queue_music:
    ld a, $02
    call QueueMusic
    ld a, [wLinkRole]
    rlca
    and $04
    ld b, a
    ld a, [wBattleActor]
    and $04
    cp b
    jr nz, .set_battle_scene_to_04
    ld a, $05
    ld [wBattleScene], a
    ld a, $63
    jr .set_string_index

.set_battle_scene_to_04:
    ld a, $04
    ld [wBattleScene], a
    ld a, $64

.set_string_index:
    ld [wStringIndex], a ; 'Your opponent broke a rule! You'
    xor a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ld a, $02
    ld [wBattlePhase], a
    ld a, $09
    ld [wBattleStep], a
    xor a
    ld [wBattleSubPhase], a
    ld [wBattleResolveStep], a
    ld a, [wDataBankSave]
    ld [wDataBank], a
    xor a
    ld [wDataBankSave], a
    ret

; A table of 232 ($E8) rule-mask bytes, one per battle action id $00 to $E7. A value is a bit mask
; of link-battle rule groups, 0 meaning no rule applies: $00 for id 0; $40 for ids $01-$15; $10 for
; $16-$24; $20 for $25-$3C; $01 for $3D; $02 for $3E-$3F; $08 for $40-$47; $02 for $48-$70; $08 for
; $71-$74; $04 for $76-$7D; and mostly $20, $10, $08 or $04 up to $A1, then 0 except $02 at $AA and
; $20 at $AD-$AE. CheckLinkRuleViolation indexes it by wBattleActionId and ANDs the byte with
; wLinkRules + 1 and then wLinkRules + 2 to decide whether the action breaks the rules. (C1, E-0381)
CheckLinkRuleViolation_Data::
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

; Step 8 of RunBattleActions_StatusChecks: pays the MP of the action through
; CheckActionD0ToE3OrSpecial (any action, not only a two-monster one) unless bit 4 of the
; wPersonalityActs byte of the actor is set (the act RunBattleActions_StatusChecks_PersonalityText
; answers with text $32); then wBattleSubPhase += 1 and wBattleResolveStep and wBattleSubStep are
; cleared. (C2, E-0380)
RunBattleActions_StatusChecks_PayActionMP::
    ld a, [wBattleActor]
    ld hl, wPersonalityActs
    call AddDoubleAToHL_Bank32
    bit 4, [hl]
    call z, CheckActionD0ToE3OrSpecial
    ld hl, wBattleSubPhase
    inc [hl]
    xor a
    ld [wBattleResolveStep], a
    xor a
    ld [wBattleSubStep], a
    ret

; Step 9 of RunBattleActions_StatusChecks: wBattleSubStep picks 0
; RunBattleActions_StatusChecks_ShowHeroDroppedDead (defeat the actor and show the message) and 1
; RunBattleActions_StatusChecks_DroppedDead_AnyLeft (go on to the next phase when its side has
; nobody left that can act). (C1, E-0380)
; by its step: '0 dropped dead!', then the next actor
RunBattleActions_StatusChecks_DroppedDead::
    ld a, [wBattleSubStep]
    jumptable
    dw RunBattleActions_StatusChecks_ShowHeroDroppedDead
    dw RunBattleActions_StatusChecks_DroppedDead_AnyLeft

; Dropped dead, step 0: after the text defeats the actor, blanks its picture and shows '<name>
; dropped dead!' (text $8A, $8D for a foe). (C1, E-0357)
RunBattleActions_StatusChecks_ShowHeroDroppedDead::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, [wBattleActor]
    ld [wBattleTarget], a
    call DefeatTarget
    call BlankTargetMonsterPicture
    call LoadBattleActor
    ld d, $8a
    cp $04
    jr c, .call_show_battle_text
    ld d, $8d ; battle text '0 dropped dead!'

.call_show_battle_text:
    farcall ShowBattleText
    ld hl, wBattleSubStep
    inc [hl]
    ret

; Dropped dead, step 1: after the text, when the actor's side has nobody left that can act goes to
; the next battle phase; otherwise resolve step 7. (C2, E-0357; probed E-0380)
RunBattleActions_StatusChecks_DroppedDead_AnyLeft::
    ld a, [wTextFlags]
    or a
    ret nz
    call LoadBattleActor
    and $04
    ld c, a
    ld b, $03

.loop:
    call SlotCStatusCheckOrBattleSlotOut
    jr nc, .clear_battle_sub_step
    inc c
    dec b
    jr nz, .loop
    ld hl, wBattlePhase
    inc [hl]
    xor a
    ld [wBattleStep], a
    jr .return

.clear_battle_sub_step:
    xor a
    ld [wBattleSubStep], a
    ld a, $07
    ld [wBattleResolveStep], a

.return:
    ret

; A = wBattleActor. Called by RunBattleActions_StatusChecks_ShowHeroDroppedDead and
; RunBattleActions_StatusChecks_DroppedDead_AnyLeft. (C2, E-0380)
; A = wBattleActor (E-0115)
LoadBattleActor::
    ld a, [wBattleActor]
    ret

; C = slot: in a link battle (wLinkMode 1) or for a slot below 4 it returns the carry of
; CheckSlotStatusBlock for slot C (absent or blocked by a status); otherwise the carry of
; CarryUnlessBattleSlotOutSlotEmpty (set when the foe slot is absent; its statuses are not looked
; at). Called by RunBattleActions_StatusChecks_DroppedDead_AnyLeft. (C2, E-0380)
; in link battles or for slots 0-3 checks slot C's status block; otherwise carry unless the
; wBattleSlotOut slot is empty (E-0122)
SlotCStatusCheckOrBattleSlotOut::
    ld a, [wLinkMode]
    cp $01
    jr z, .call_check_slot_status_block
    ld a, c
    cp $04
    jr c, .call_check_slot_status_block
    call CarryUnlessBattleSlotOutSlotEmpty
    ret

.call_check_slot_status_block:
    ld a, c
    call CheckSlotStatusBlock
    ret

; HL += A (the sum carries into H), then A = the byte at HL. Used throughout bank $32 to read
; per-slot or per-entry bytes. (C2, E-0380)
; HL += A, then A = the byte at HL
ReadByteAtHLPlusA::
    add_a_to_hl
    ld a, [hl]
    ret

; wBattleActionId and the first byte of wRecordBuffer = the action the actor (wBattleActor) chose
; (the byte at wBattleActionChoice + 2 * actor), wRecordBuffer + 1 = 0, then far-calls
; LoadSkillRecord, which fills wRecordBufferData with the 17-byte skill record. A, B, C, D, E and HL
; change. (C2, E-0380)
; wBattleActionId = wRecordBuffer = the actor's chosen action (wBattleActionChoice), wRecordBuffer +
; $1 = 0, then far-calls LoadSkillRecord (E-0118)
LoadActorChosenActionRecord::
    ld a, [wBattleActor]
    ld hl, wBattleActionChoice
    add a
    call ReadByteAtHLPlusA
    ld [wBattleActionId], a
    ld [wRecordBuffer], a
    ld a, $00
    ld [wRecordBuffer + $1], a
    farcall LoadSkillRecord
    ret

; Fight step 4, sub-phase 0 (RunBattleStep4_SkillChecks calls it once per frame): wBattleResolveStep
; picks 0 RunBattleStep4_SaveAndStart, 1 RunBattleStep4_ResolveSkill_CheckMP, 2
; RunBattleStep4_ResolveSkill_ShowActionText, 3 RunBattleStep4_ResolveSkill_SelectEffect, 4
; RunBattleStep4_ResolveSkill_ShatterChecks, 5 RunBattleStep4_ResolveSkill_EndAfterShatter, 6
; RunBattleStep4_ResolveSkill_CheckLinkRules and 7 pays the MP of the action and moves
; wBattleSubPhase on. (C1, E-0380)
; by wBattleResolveStep: checks the skill's MP cost (CheckSkillMPCost), shows its battle text,
; selects the effect by its flags and checks the link rules
RunBattleStep4_ResolveSkill::
    ld a, [wBattleResolveStep]
    jumptable
    dw RunBattleStep4_SaveAndStart
    dw RunBattleStep4_ResolveSkill_CheckMP
    dw RunBattleStep4_ResolveSkill_ShowActionText
    dw RunBattleStep4_ResolveSkill_SelectEffect
    dw RunBattleStep4_ResolveSkill_ShatterChecks
    dw RunBattleStep4_ResolveSkill_EndAfterShatter
    dw RunBattleStep4_ResolveSkill_CheckLinkRules
    dw RunBattleStep4_ResolveSkill_PayActionMP

; Fight step 4, resolve step 0: saves the actor, target, hits, both choices and the target's mark,
; then makes the target act in turn (a follow-up, mark 2) with the same action and chooses its
; target. (C1, E-0357)
RunBattleStep4_SaveAndStart::
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wSavedActorTarget
    ld a, [wBattleActor]
    ld [hli], a
    ld a, [wBattleTarget]
    ld [hli], a
    ld a, [wMultiHitCount]
    ld [hli], a
    ld a, [wBattleActor]
    ld de, wBattleActionChoice
    add a
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld [hli], a
    inc de
    ld [hli], a
    ld a, [wBattleTarget]
    ld de, wBattleActionChoice
    add a
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [de]
    ld [hli], a
    inc de
    ld [hli], a
    ld a, [wBattleTarget]
    ld de, wSlotMarks
    add e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    ld a, [de]
    ld [hl], a
    ld a, $01
    ld [wFollowUpAction], a
    xor a
    ld [wMultiHitCount], a
    ld a, [wBattleTarget]
    ld [wBattleActor], a
    ld a, [wBattleActor]
    ld hl, wBattleActionChoice
    call AddDoubleAToHL_Bank32
    ld a, [wBattleActionId]
    ld [hli], a
    ld [hl], $ff
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

; Fight step 4, resolve step 1: checks the MP cost; with too little builds the message, pays a
; two-monster action's MP if needed and goes to resolve step 5. (C1, E-0357)
RunBattleStep4_ResolveSkill_CheckMP::
    ld hl, wBattleResolveStep
    inc [hl]
    call CheckSkillMPCost
    jr c, .return
    ld a, d
    and $07
    jr z, .return
    cp $07
    jr z, .return
    push de
    farcall ShowActionRefusedMessage
    pop af
    cp $01
    jr z, .set_battle_resolve_step_to_05
    call CheckActionD0ToE3OrSpecial

.set_battle_resolve_step_to_05:
    ld a, $05
    ld [wBattleResolveStep], a

.return:
    ret

; Fight step 4, resolve step 2: unless an attack was inhaled, shows the action's battle text and
; selects its effect. (C1, E-0357)
RunBattleStep4_ResolveSkill_ShowActionText::
    ld a, [wAttackInhaled]
    bit 0, a
    jr nz, .done
    farcall ShowActionBattleTextFromActionBattleTextTable
    ld a, $80
    ld [wEffectFlags2], a
    farcall SelectEffectByEffectFlags2Flags

.done:
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; Fight step 4, resolve step 3: once the sound channels are free selects the effect (flags $80) and
; goes on. (C2, E-0357; probed E-0380)
RunBattleStep4_ResolveSkill_SelectEffect::
    ld a, [wSoundChannelSlots]
    ld hl, wSoundChannel1
    and [hl]
    cp $ff
    ret nz
    ld a, $80
    ld [wEffectFlags], a
    farcall SelectEffectByEffectFlags
    ld hl, wBattleResolveStep
    inc [hl]
    xor a
    ld [wBattleSubStep], a
    ret

; Fight step 4, resolve step 4: wBattleSubStep picks 0
; RunBattleStep4_ResolveSkill_ShatterChecks_Detect, 1 RunBattleStep4_ResolveSkill_ShowGWasShattered
; ('shattered!'), 2 RunBattleStep4_ResolveSkill_ShowSealPrayWasBroken ('SealPray was broken!') and 3
; RunBattleStep4_ResolveSkill_ShatterChecks_Done (resolve step 5). (C1, E-0380)
; by its step: 'G was shattered!' and 'SealPray was broken!'
RunBattleStep4_ResolveSkill_ShatterChecks::
    ld a, [wBattleSubStep]
    jumptable
    dw RunBattleStep4_ResolveSkill_ShatterChecks_Detect
    dw RunBattleStep4_ResolveSkill_ShowGWasShattered
    dw RunBattleStep4_ResolveSkill_ShowSealPrayWasBroken
    dw RunBattleStep4_ResolveSkill_ShatterChecks_Done

; Fight step 4's shatter checks, step 0: as the main shatter check, without the Ironize case; with
; no SealPray skips two resolve steps. (C2, E-0357; probed E-0380)
RunBattleStep4_ResolveSkill_ShatterChecks_Detect::
    ld a, [wBattleActor]
    ld hl, wBattleActionChoice
    add a
    call ReadByteAtHLPlusA
    ld [wBattleActionId], a
    inc hl
    ld a, [hl]
    ld [wBattleTarget], a
    ld a, [wRecordBufferData + $8]
    bit 7, a
    jr z, .skip2
    ld a, [wRecordBufferData + $4]
    and $0f
    cp $02
    jr z, .check_battle_target
    ld a, [wBattleTarget]
    ld hl, wBattleStatus8
    call AddAx9ToHL
    bit BSTAT8_SEAL_PRAY, [hl]
    jr nz, .skip3
    jr .skip2

.check_battle_target:
    ld a, [wBattleTarget]
    and $04
    ld c, a
    ld b, $03
    ld hl, wBattleStatus8
    call AddAx9ToHL

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .skip
    bit 4, [hl]
    jr nz, .skip3

.skip:
    ld a, l
    add $09
    ld l, a
    ld a, h
    adc $00
    ld h, a
    inc c
    dec b
    jr nz, .loop

.skip2:
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wBattleResolveStep
    inc [hl]
    xor a
    ld [wBattleSubStep], a
    ret

.skip3:
    res 4, [hl]
    ld hl, wQueuedActionId
    ld a, [hli]
    ld [hld], a
    ld a, [wBattleActionId]
    ld [hl], a
    ld hl, wBattleSubStep
    inc [hl]
    ret

; Fight step 4's shatter checks, step 1: battle text $B0. (C1, E-0357)
RunBattleStep4_ResolveSkill_ShowGWasShattered::
    ld hl, wBattleSubStep
    inc [hl]
    ld d, $b0 ; battle text 'G was shattered!'
    farcall ShowBattleText
    ret

; Fight step 4's shatter checks, step 2: battle text $92 when a SealPray was set, and clears it.
; (C1, E-0357)
RunBattleStep4_ResolveSkill_ShowSealPrayWasBroken::
    ld hl, wBattleSubStep
    inc [hl]
    ld a, [wSealPrayState]
    cp $ff
    ret z
    ld d, $92 ; battle text 'SealPray was broken!'
    farcall ShowBattleText
    ld a, $ff
    ld [wSealPrayState], a
    ret

; Fight step 4's shatter checks, step 3: resolve step 5
; (RunBattleStep4_ResolveSkill_EndAfterShatter) with wBattleSubStep 0. (C2, E-0372; probed E-0380)
RunBattleStep4_ResolveSkill_ShatterChecks_Done::
    ld hl, wBattleResolveStep
    inc [hl]
    xor a
    ld [wBattleSubStep], a
    ret

; Fight step 4, resolve step 5, reached only after a target's BSTAT8_SEAL_PRAY shattered the skill
; (the shatter checks' steps 1-3; without one, step 4 skips to step 6): wBattleSubPhase 5
; (RunBattleStep4_RestoreSaved) and wBattleResolveStep 0, skipping sub-phases 1-4. (C2, E-0372;
; probed E-0380)
RunBattleStep4_ResolveSkill_EndAfterShatter::
    ld a, $05
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    ret

; Fight step 4, resolve step 6: the link rule check (CheckLinkRuleViolation). (C1, E-0357)
RunBattleStep4_ResolveSkill_CheckLinkRules::
    call CheckLinkRuleViolation
    ret

; Fight step 4, resolve step 7: pays the MP of the action through CheckActionD0ToE3OrSpecial (any
; action, not only a two-monster one); then wBattleSubPhase += 1 and wBattleResolveStep and
; wBattleSubStep are cleared. (C2, E-0380)
RunBattleStep4_ResolveSkill_PayActionMP::
    call CheckActionD0ToE3OrSpecial
    ld hl, wBattleSubPhase
    inc [hl]
    xor a
    ld [wBattleResolveStep], a
    xor a
    ld [wBattleSubStep], a
    ret

; Resolve step $0C (ResolveStepApplyDamage). It adds 2 to wBattleResolveStep, clears wBattleSubStep
; and, unless the top two bits of wResolveMsgArg are 00 (then it returns at once, with no HP change
; and no wLevelUpGains change), sets bits 0, 1 and 2 of the wLevelUpGains entry of wBattleTarget.
; When the top bits are not 00 and not 01 it first subtracts the 16-bit damage
; wBattleDamageLo/wBattleDamageHi from wBattleHP[wBattleTarget]; if the damage is equal to or above
; the HP the HP becomes 0, wBattleResolveStep goes back by 1 (so the next resolve step is the
; defeat, RunDefeatSequence) and wBattleSubStep2 is cleared. (C2, E-0380)
; target slot wBattleTarget (wBattleTarget): when wResolveMsgArg's top two bits are not 00 and not
; 01, wBattleHP[target] -= the 16-bit damage in wBattleDamageLo/wBattleDamageHi and is clamped at 0
; (a result below zero also decrements wBattleResolveStep and clears wBattleSubStep2); then sets
; bits 0, 1 and 2 of the target's wLevelUpGains flags
ApplyDamageToTarget::
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wBattleResolveStep
    inc [hl]
    xor a
    ld [wBattleSubStep], a
    ld a, [wResolveMsgArg]
    and $c0
    cp $00
    jr z, .return
    cp $40
    jr z, .read_battle_target
    ld a, [wBattleTarget]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank32
    ld a, [hli]
    ld d, [hl]
    ld e, a
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wBattleDamageHi]
    ld b, a
    ld a, e
    sub c
    ld e, a
    ld a, d
    sbc b
    ld d, a
    jr c, .skip
    ld a, d
    ld [hld], a
    ld [hl], e
    or e
    jr nz, .read_battle_target
    inc hl

.skip:
    xor a
    ld [hld], a
    ld [hl], a
    ld hl, wBattleResolveStep
    dec [hl]
    xor a
    ld [wBattleSubStep2], a

.read_battle_target:
    ld a, [wBattleTarget]
    call SetBit0OfLevelUpGainsIndexed_Bank32
    ld a, [wBattleTarget]
    call SetBit1OfLevelUpGainsIndexed_Bank32
    ld a, [wBattleTarget]
    call SetBit2OfLevelUpGainsIndexed_Bank32
    ret

.return:
    ret

; Resolve step $0D (ResolveStepDefeat). ApplyDamageToTarget only leaves this step to run when it
; took the HP of the target to 0. Runs one case of wBattleSubStep2 per call: 0
; RunDefeatSequence_Defeat, 1 RunDefeatSequence_BlankPicture, 2 RunDefeatSequence_ShowDefeatText,
; which also moves wBattleResolveStep on and clears wBattleSubStep2. (C1, E-0380)
; three sub-steps by wBattleSubStep2: 0 lowers a counter (wSlotMarks + target by 5) and calls
; DefeatTarget, 1 runs BlankTargetMonsterPicture, 2 advances wBattleResolveStep, sets bit 2 of the
; target's wLevelUpGains flags and starts the defeat message (ShowBattleText)
RunDefeatSequence::
    ld a, [wBattleSubStep2]
    jumptable
    dw RunDefeatSequence_Defeat
    dw RunDefeatSequence_BlankPicture
    dw RunDefeatSequence_ShowDefeatText

; The defeat, sub-step 0: lowers the target's mark by 5 and defeats it (DefeatTarget). (C2, E-0357;
; probed E-0380)
RunDefeatSequence_Defeat::
    ld hl, wBattleSubStep2
    inc [hl]
    ld a, [wBattleTarget]
    ld hl, wSlotMarks
    add_a_to_hl
    ld a, [hl]
    add $fb
    ld [hl], a
    call DefeatTarget
    ret

; The defeat, sub-step 1: blanks the target's picture. (C1, E-0357)
RunDefeatSequence_BlankPicture::
    call BlankTargetMonsterPicture
    ld hl, wBattleSubStep2
    inc [hl]
    ret

; The defeat, sub-step 2: marks the target's level-up gains (bit 2) and, unless the action took it
; out by itself (below), shows the defeat line: text $8A/$8B by side, for Geyser by the actor's
; side. (C1, E-0357)
RunDefeatSequence_ShowDefeatText::
    ld hl, wBattleResolveStep
    inc [hl]
    xor a
    ld [wBattleSubStep2], a
    ld a, [wBattleTarget]
    call SetBit2OfLevelUpGainsIndexed_Bank32
    call RunDefeatSequence_ShowDefeatText_CheckAction
    ret z
    ld a, [wBattleActionId]
    cp SKILL_GEYSER
    jr nz, .call_target_on_local_side_bank32
    ld d, $8a
    call ActorOnLocalSide_Bank32
    jr c, .skip
    inc d

.skip:
    jr .call_show_battle_text

.call_target_on_local_side_bank32:
    ld d, $8b
    call TargetOnLocalSide_Bank32
    jr nc, .call_show_battle_text
    dec d

.call_show_battle_text:
    farcall ShowBattleText
    ret

; Decides whether the defeat text of RunDefeatSequence_ShowDefeatText is shown: Z set (no text) for
; SKILL_BEAT and SKILL_DEFEAT; for SKILL_SACRIFICE and ACTION_D6 it subtracts 1000 from the damage
; word wBattleDamageLo/wBattleDamageHi by subtracting $E8 from the low byte and then $03 with borrow
; from the high byte, and only the high-byte result sets Z, so Z is set for every damage from 1000
; to 1255 and carry is set below 1000; every other action, SKILL_KODANCE included (its compare is
; overwritten by the next one), returns NZ. (C2, E-0380)
RunDefeatSequence_ShowDefeatText_CheckAction::
    ld a, [wBattleActionId]
    cp SKILL_BEAT
    ret z
    cp SKILL_DEFEAT
    ret z
    cp SKILL_SACRIFICE
    jr z, .skip
    cp SKILL_KODANCE
    cp ACTION_D6
    jr z, .skip
    ret

.skip:
    ld hl, wBattleDamageLo
    ld a, [hli]
    sub $e8
    ld a, [hl]
    sbc $03
    ret

; Overwrites the battle picture of the target with a flat pattern: it picks a picture 0, 1 or 2 and
; fills the 36 tiles ($24) at vTiles2 + $140, + $380 or + $5C0 with the byte pair $FF, $00, writing
; each pair while rSTAT bit 1 is clear (interrupts off). The foe slots 4-6 (picture = slot - 4) are
; drawn when wLinkMode is 0 or 2 or wLinkRole bit 1 is clear; with wLinkMode 1 and wLinkRole bit 1
; set the sides are reversed and only slots 0-2 (picture = slot) are drawn; slots 3 and 7 and the
; slots of the other side return without drawing. The defeat sequences
; (RunDefeatSequence_BlankPicture and the copies for the effects) call it once the target has been
; defeated. (C1, E-0380)
; for the target's picture slot fills $24 tiles at vTiles2 + $140, $380 or $5C0 with the pattern
; $FF, $00 (E-0127)
BlankTargetMonsterPicture::
    ld a, [wLinkMode]
    or a
    jr z, .check_battle_target
    cp $02
    jr z, .check_battle_target
    ld a, [wLinkRole]
    bit 1, a
    jr z, .check_battle_target
    ld a, [wBattleTarget]
    bit 2, a
    ret nz
    and $03
    cp $03
    ret z
    ld a, [wBattleTarget]
    jr .cp_02

.check_battle_target:
    ld a, [wBattleTarget]
    bit 2, a
    ret z
    and $03
    cp $03
    ret z
    ld a, [wBattleTarget]
    sub $04

.cp_02:
    cp $02
    jr z, .skip2
    cp $01
    jr z, .skip
    ld hl, vTiles2 + $140
    jr .skip3

.skip:
    ld hl, vTiles2 + $380
    jr .skip3

.skip2:
    ld hl, vTiles2 + $5c0

.skip3:
    ld c, $24

.loop:
    ld b, $08

.loop2:
    di

.loop3:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop3
    ld a, $ff
    ld [hli], a
    ld a, $00
    ld [hli], a
    ei
    dec b
    jr nz, .loop2
    dec c
    jr nz, .loop
    ret

; Takes the monster in slot wBattleTarget out of the fight. It first calls RecomputeTargetMaxHPAndMP
; (which does nothing unless bit 4 or 5 of status byte 1 is set), clears bits 6-7 of status byte 6
; with AGL and DEF back to base (ResetTargetAGLAndDEFToBase) when one was set, and runs
; DefeatTarget_AdjustHitsAndGuards; then wBattleSlotOut[slot] = 1, wBattleHP[slot] = 0 and the
; 9-byte status record of the slot is zeroed. With wLinkMode 0 or 2: slots 0-2 get bit 2 of
; wLevelUpGains, slots 4-6 are stored in wDisplaySlot, and slots 3 and 7 clear bit 2 of wSideFlags0
; and set wDefeatStep to 9; with wLinkMode 1 it stops after clearing the slot. (C2, E-0380)
; target slot wBattleTarget: re-derives its stats (RecomputeTargetMaxHPAndMP,
; DefeatTarget_AdjustHitsAndGuards, ResetTargetAGLAndDEFToBase clear 'buff' bits), sets
; wBattleSlotOut[target] = 1, wBattleHP[target] = 0 and clears the target's 9-byte status record
; (wBattleStatus + 9 * slot)
DefeatTarget::
    call RecomputeTargetMaxHPAndMP
    ld a, [wBattleTarget]
    ld hl, wBattleStatus6
    call AddAx9ToHL
    ld a, [hl]
    and $c0
    jr z, .call_defeat_target_adjust_hits_and_guards
    ld a, [hl]
    and $3f
    ld [hl], a
    call ResetTargetAGLAndDEFToBase

.call_defeat_target_adjust_hits_and_guards:
    call DefeatTarget_AdjustHitsAndGuards
    ld a, [wBattleTarget]
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld [hl], $01
    ld a, [wBattleTarget]
    ld hl, wBattleHP
    add a
    add_a_to_hl
    xor a
    ld [hli], a
    ld [hl], a
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    xor a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hl], a
    ld a, [wLinkMode]
    or a
    jr z, .check_battle_target
    cp $02
    jr nz, .return

.check_battle_target:
    ld a, [wBattleTarget]
    cp $03
    jr z, .check_battle_target2
    jr c, .read_battle_target
    cp $07
    jr z, .check_battle_target2
    ld [wDisplaySlot], a
    jr .return

.check_battle_target2:
    ld a, [wBattleTarget]
    and $04
    rrca
    rrca
    and $01
    ld hl, wSideFlags0
    res 2, [hl]
    ld a, $09
    ld [wDefeatStep], a
    jr .return

.read_battle_target:
    ld a, [wBattleTarget]
    call SetBit2OfLevelUpGainsIndexed_Bank32

.return:
    ret

; Part of DefeatTarget: when the skill targets a whole side (wRecordBufferData + $4 low nibble 2),
; an ally guard moved the attack (wRedirectFlags bit 1, wOriginalTarget not $FF), the defeated
; wBattleTarget is a higher slot than wOriginalTarget, and wMultiHitCount has bit 7 set and is not
; $81, counts one hit fewer. Then, for the four slots of the target's side, clears BSTAT6_GUARDED of
; any slot whose guarding slot (the wBattleStatus7 high nibble) is the defeated target. (C2, E-0372;
; probed E-0380)
DefeatTarget_AdjustHitsAndGuards::
    ld a, [wRecordBufferData + $4]
    and $0f
    cp $02
    jr nz, .read_battle_target
    ld a, [wRedirectFlags]
    bit 1, a
    jr z, .read_battle_target
    ld a, [wOriginalTarget]
    cp $ff
    jr z, .read_battle_target
    ld c, a
    ld a, [wBattleTarget]
    cp c
    jr c, .read_battle_target
    jr z, .read_battle_target
    ld a, [wMultiHitCount]
    bit 7, a
    jr z, .read_battle_target
    cp $81
    jr z, .read_battle_target
    dec a
    ld [wMultiHitCount], a

.read_battle_target:
    ld a, [wBattleTarget]
    ld e, a
    and $04
    ld c, a
    ld b, $04

.loop:
    ld a, c
    ld hl, wBattleStatus6
    call AddAx9ToHL
    bit BSTAT6_GUARDED, [hl]
    jr z, .next
    inc hl
    ld a, [hl]
    swap a
    and $0f
    cp e
    jr nz, .next
    dec hl
    res 4, [hl]

.next:
    inc c
    dec b
    jr nz, .loop
    ret

; Sets wBattleAGL and wBattleDEF of the slot wBattleTarget back to the base values of its battler
; record (GetBaseAGL, GetBaseDEF); the other stats are not touched. All registers and the word
; wBattleStatResultLo/wBattleStatResultHi are kept. DefeatTarget and RestoreTransformedStats call it
; after clearing bits 6-7 of status byte 6 (BSTAT6_STATS_RAISED, BSTAT6_STATS_LOWERED). (C2, E-0380)
; sets the target's battle AGL and DEF to their base values (GetBaseAGL, GetBaseDEF), preserving
; wBattleStatResult and all registers (E-0121)
ResetTargetAGLAndDEFToBase::
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
    add a
    add_a_to_hl
    ld a, [wBattleStatResultLo]
    ld [hli], a
    ld a, [wBattleStatResultHi]
    ld [hl], a
    ld a, [wBattleTarget]
    ld c, a
    farcall GetBaseDEF
    ld a, [wBattleTarget]
    ld hl, wBattleDEF
    add a
    add_a_to_hl
    ld a, [wBattleStatResultLo]
    ld [hli], a
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

; Does nothing unless bit 4 or 5 of status byte 1 of wBattleTarget is set (BSTAT1_DRAGON_FORM,
; BSTAT1_TRANSFORMED). Otherwise it rebuilds the slot from its battler record: with bit 5 it first
; resets the foe name byte (RecomputeTargetMaxHPAndMP_TargetSlot); it reloads the skill list
; (LoadSlotSkillsFromBattlerRecord); stores the base maximum HP, maximum MP, ATK, INT, AGL and DEF,
; the level, the three personality bytes, the trait, the AI mode from INT (SetSlotAIModeFromINT) and
; wSlotBodyFlags; lowers HP and MP that exceed the new maximum to it; and, except for slots 3 and 7,
; repacks the 27 resistances of the record into wSlotResistances. It leaves wBattleArg0 to
; wBattleArg3 changed. DefeatTarget and RestoreTransformedStats use it to undo a transformation.
; (C2, E-0380)
; when bits 4-5 of the target's status byte (wBattleStatus1 + 9 * slot) are set: stores GetBaseHP
; and GetBaseMP of the target in wBattleMaxHP and wBattleMaxMP and lowers the current values to the
; new maximum
RecomputeTargetMaxHPAndMP::
    ld a, [wBattleTarget]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    ld a, [hl]
    and $30
    ret z
    and $20
    call nz, RecomputeTargetMaxHPAndMP_TargetSlot
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
    jr c, .read_battle_target
    ld a, [wBattleTarget]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank32
    ld [hl], c
    inc hl
    ld [hl], b

.read_battle_target:
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
    jr c, .read_battle_target2
    ld a, [wBattleTarget]
    ld hl, wBattleMP
    call AddDoubleAToHL_Bank32
    ld [hl], c
    inc hl
    ld [hl], b

.read_battle_target2:
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
    ld hl, wSlotBodyFlags
    add_a_to_hl
    ld [hl], c
    ld a, [wBattleTarget]
    ld b, a
    and $03
    cp $03
    ret z
    ld a, b
    ld e, BATTLER_RESISTANCES
    call BattlerRecordFieldAddress
    ld a, l
    ld [wBattleArg0], a
    ld a, h
    ld [wBattleArg1], a
    ld a, [wBattleTarget]
    ld de, wSlotResistances
    ld b, a
    add a
    add b
    add a
    add b
    add e
    ld e, a
    jr nc, .set_battle_arg2
    inc d

.set_battle_arg2:
    ld a, e
    ld [wBattleArg2], a
    ld a, d
    ld [wBattleArg3], a
    farcall PackResistancesFromBattleArgs
    ret

; C = the target slot (into the name-byte reset below). (C2, E-0357; probed E-0380)
RecomputeTargetMaxHPAndMP_TargetSlot::
    ld a, [wBattleTarget]
    ld c, a

; C = slot: only when wLinkMode is 0 or 2 and C is a foe slot 4-6, sets its wSlotNameBytes entry (C
; & 3) to $FF, so CopySlotNameToHL_HighSlot names it by its species again. Reached by falling from
; RecomputeTargetMaxHPAndMP_TargetSlot (C = wBattleTarget) and far-called by ActionEffect_BeDragon
; (C = wBattleActor). (C2, E-0372; probed E-0380)
ResetFoeSlotNameToSpecies::
    ld a, [wLinkMode]
    or a
    jr z, .skip
    cp $02
    ret nz

.skip:
    ld a, c
    cp $04
    ret c
    and $03
    cp $03
    ret z
    ld hl, wSlotNameBytes
    add_a_to_hl
    ld [hl], $ff
    ret

; Clears wSideFlags0 and wSideFlags1, then for slots 0 and 1, but only those still in the fight
; (wBattleSlotOut clear), runs RecomputeTargetMaxHPAndMP, restores AGL and DEF when status byte 6
; has bit 6 or 7 set (ResetTargetAGLAndDEFToBase) and zeroes the 9-byte status record; an absent
; slot keeps its record and slot 2 is not visited. Then slot 3 is marked absent: wBattleSlotOut[3] =
; $FF, wSlotMarks[3] = $FF and its status record is zeroed. wBattleTarget is left at 1. It is
; far-called from RunBattlePhaseWhenTextIdle_A0_SyncLink_CountRound, which counts the round up first
; and redraws the slot panels afterwards. (C2, E-0380)
RestoreTransformedStats::
    xor a
    ld [wSideFlags0], a
    ld [wSideFlags1], a
    ld c, $00

.loop:
    push bc
    ld a, c
    ld [wBattleTarget], a
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .restore
    call RecomputeTargetMaxHPAndMP
    ld a, [wBattleTarget]
    ld hl, wBattleStatus6
    call AddAx9ToHL
    ld a, [hl]
    and $c0
    jr z, .read_battle_target
    ld a, [hl]
    and $3f
    ld [hl], a
    call ResetTargetAGLAndDEFToBase

.read_battle_target:
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    xor a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hl], a

.restore:
    pop bc
    inc c
    ld a, c
    cp $02
    jr nz, .loop
    ld a, $03
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld [hl], $ff
    ld a, $03
    ld hl, wSlotMarks
    add_a_to_hl
    ld [hl], $ff
    ld a, $03
    ld hl, wBattleStatus
    call AddAx9ToHL
    xor a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hl], a
    ret

; Resolve step $0E (ResolveStep0ECallEffect): the effect of the action, run by wBattleSubStep: 0
; ResolveStep0EEffect_Start chooses the path from wBattleActionId, 1 ResolveStep0EEffect_ShowMessage
; shows the effect message wEffectSubStep, 2 ResolveStep0EEffect_Finish moves wBattleResolveStep on,
; 3 ResolveStep0EEffect_Recoil (SKILL_RAMMING), 4 ResolveStep0EEffect_Brutalize (SKILL_KAMIKAZE), 5
; ResolveStep0EEffect_Sacrifice (SKILL_SACRIFICE, SKILL_FAREWELL, SKILL_LIFEDANCE and ACTION_D6),
; 6-8 ResolveStep0EEffect_DoNothing, 9 ResolveStep0EEffect_QuarterRecoil (SKILL_TWINSLASH).
; ResolveStep0EEffect_Start never sets 6, 7 or 8. (C1, E-0380)
; resolve step $0E runs this through wBattleSubStep (wBattleSubStep): ten cases, 0-9. Case 0
; branches on wBattleActionId: $15 and $20 to ResolveStep0EEffect_Start.check_battle_screen_flags,
; $3B to ResolveStep0EEffect_Start.call_resolve_step0_e_effect_advance_random, $5F to
; ResolveStep0EEffect_Start.read_battle_target, $60 to
; ResolveStep0EEffect_Start.read_battle_target2, $61 to
; ResolveStep0EEffect_Start.read_battle_target3, $6D to
; ResolveStep0EEffect_Start.set_battle_sub_step_to_09; the other actions and cases 1-9 are not yet
; read (E-0051)
ResolveStep0EEffect::
    ld a, [wBattleSubStep]
    jumptable
    dw ResolveStep0EEffect_Start
    dw ResolveStep0EEffect_ShowMessage
    dw ResolveStep0EEffect_Finish
    dw ResolveStep0EEffect_Recoil
    dw ResolveStep0EEffect_Brutalize
    dw ResolveStep0EEffect_Sacrifice
    dw ResolveStep0EEffect_DoNothing
    dw ResolveStep0EEffect_DoNothing
    dw ResolveStep0EEffect_DoNothing
    dw ResolveStep0EEffect_QuarterRecoil

; Resolve step $0E, sub-step 0: by the skill: Sacrifice, Farewell and LifeDance (and action $D6,
; saving the actor) go to sub-step 5 when screen flag bit 0 is set; BeDragon and a HighJump variant
; roll and restart the action (action $DC for the formation partner too); PoisonHit, Paralyze and
; NapAttack add their status; TwinSlash goes to sub-step 9, Ramming to 3, Kamikaze to 4; others on.
; (C2, E-0357; probed E-0380)
ResolveStep0EEffect_Start::
    xor a
    ld [wBattleSubStep2], a
    xor a
    ld [wEffectSubStep], a
    ld a, [wBattleActionId]
    cp SKILL_SACRIFICE
    jr z, .check_battle_screen_flags
    cp SKILL_FAREWELL
    jr z, .check_battle_screen_flags
    cp SKILL_BEDRAGON
    jr z, .call_resolve_step0_e_effect_start_pick_random
    cp SKILL_POISONHIT
    jp z, .read_battle_target
    cp SKILL_PARALYZE
    jp z, .read_battle_target2
    cp SKILL_NAPATTACK
    jp z, .read_battle_target3
    cp SKILL_TWINSLASH
    jr z, .set_battle_sub_step_to_09
    cp SKILL_RAMMING
    jr z, .set_battle_sub_step_to_03
    cp SKILL_KAMIKAZE
    jr z, .set_battle_sub_step_to_04
    cp SKILL_LIFEDANCE
    jr z, .check_battle_screen_flags
    cp ACTION_B8
    jr z, .call_resolve_step0_e_effect_start_pick_random
    cp ACTION_D6
    jr z, .read_battle_actor
    cp ACTION_DC
    jr z, .read_battle_actor2

.loop:
    ld hl, wBattleSubStep
    inc [hl]
    ret

.set_battle_sub_step_to_03:
    ld a, $03
    ld [wBattleSubStep], a
    ret

.set_battle_sub_step_to_04:
    ld a, $04
    ld [wBattleSubStep], a
    ret

.read_battle_actor:
    ld a, [wBattleActor]
    ld [wSavedActorSlot], a
    xor a
    ld [wSavedActorByte], a

.check_battle_screen_flags:
    ld a, [wBattleScreenFlags]
    bit 0, a
    jr z, .loop
    ld a, [wBattleScreenFlags]
    and $fe
    ld [wBattleScreenFlags], a
    ld a, $05
    ld [wBattleSubStep], a
    ret

.set_battle_sub_step_to_09:
    ld a, $09
    ld [wBattleSubStep], a
    ret

.call_resolve_step0_e_effect_start_pick_random:
    call ResolveStep0EEffect_Start_PickRandomAttack
    xor a
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    xor a
    ld [wBattleSubStep], a
    ret

.read_battle_actor2:
    ld a, [wBattleActor]
    push af
    farcall ActorFormationSlotToTemp0
    ldh a, [hTemp0]
    ld [wBattleActor], a
    call ResolveStep0EEffect_Start_PickRandomAttack
    pop af
    ld [wBattleActor], a
    jr .call_resolve_step0_e_effect_start_pick_random

.read_battle_target:
    ld a, [wBattleTarget]
    call CarryUnlessBattleSlotOutSlotEmpty
    jp c, SetBattleSubStep1
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    and $03
    jp nz, SetBattleSubStep1
    push hl
    farcall RollVsPoisonGasResistance
    pop hl
    ld a, e
    or a
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

.read_battle_target2:
    ld a, [wBattleTarget]
    call CarryUnlessBattleSlotOutSlotEmpty
    jp c, SetBattleSubStep1
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit BSTAT0_PARALYZED, [hl]
    jp nz, SetBattleSubStep1
    push hl
    farcall RollVsPalsyAirResistance
    pop hl
    ld a, e
    or a
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

.read_battle_target3:
    ld a, [wBattleTarget]
    call CarryUnlessBattleSlotOutSlotEmpty
    jp c, SetBattleSubStep1
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit BSTAT0_ASLEEP, [hl]
    jp nz, SetBattleSubStep1
    push hl
    farcall ResolveStep0EEffect_RollVsSleepResistance
    pop hl
    ld a, e
    or a
    jp nz, SetBattleSubStep1
    ld a, [hl]
    or $8c
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
    jr c, .set_effect_sub_step
    dec a

.set_effect_sub_step:
    ld [wEffectSubStep], a
    jp SetBattleSubStep1

; Advances the random number and writes a new command for wBattleActor in wBattleActionChoice: the
; action is entry wRandomLo & 3 of the table after the routine, which holds only zeros
; (ACTION_FIGHT); for action 0 the target is slot (wRandomLo & 3) of the other side, moving down to
; the nearest present slot (CarryUnlessBattleSlotOutSlotEmpty) and wrapping from the side's first
; slot to its fourth; a nonzero action would get the other side's first slot.
; ResolveStep0EEffect_Start uses it for SKILL_BEDRAGON, ACTION_B8 and ACTION_DC (for the formation
; partner too) before restarting the action. (C2, E-0372; probed E-0380)
ResolveStep0EEffect_Start_PickRandomAttack::
    call AdvanceRandom
    ld a, [wBattleActor]
    ld hl, wBattleActionChoice
    call AddDoubleAToHL_Bank32
    push hl
    ld a, [wRandomLo]
    and $03
    ld hl, ResolveStep0EEffect_Start_PickRandomAttack_Data
    add_a_to_hl
    ld a, [hl]
    pop hl
    ld [hli], a
    ld c, a
    push hl
    ld a, [wBattleActor]
    and $04
    xor $04
    ld b, a
    ld a, c
    cp $00
    jr nz, .restore
    ld a, [wRandomLo]
    and $03
    add b

.call_carry_unless_battle_slot_out_slot_empty:
    ld b, a
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, .restore
    ld a, b
    and $03
    jr nz, .skip
    ld a, b
    or $03
    jr .call_carry_unless_battle_slot_out_slot_empty

.skip:
    ld a, b
    dec a
    jr .call_carry_unless_battle_slot_out_slot_empty

.restore:
    pop hl
    ld a, b
    ld [hl], a
    ret

; Five bytes, all $00 (ACTION_FIGHT). ResolveStep0EEffect_Start_PickRandomAttack indexes it by
; wRandomLo masked with 3 (entries 0 to 3) to pick the action id it stores in wBattleActionChoice
; for wBattleActor, so every pick is the plain attack; the fifth byte is not reached by that index.
; (C1, E-0381)
ResolveStep0EEffect_Start_PickRandomAttack_Data::
    db $00, $00, $00, $00, $00

; Resolve step $0E, sub-step 1: shows the effect's message (wEffectSubStep) when there is one, then
; sub-step 2. (C1, E-0357)
ResolveStep0EEffect_ShowMessage::
    ld a, [wEffectSubStep]
    or a
    jr z, ResolveStep0EEffect_Finish
    ld d, a
    farcall ShowBattleText
    ld hl, wBattleSubStep
    inc [hl]
    ret

; Resolve step $0E, sub-step 2 (also sub-step 1 when wEffectSubStep is 0, no message): the next
; resolve step, with wBattleSubStep 0. (C2, E-0372; probed E-0380)
ResolveStep0EEffect_Finish::
    xor a
    ld [wBattleSubStep], a
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; Sub-step 3 of ResolveStep0EEffect, started for SKILL_RAMMING; runs the case of wBattleSubStep2: 0
; ResolveStep0EEffect_Recoil_Start, 1 ResolveStep0EEffect_Recoil_LoseHP (the actor loses most of its
; HP), 2 ResolveStep0EEffect_Recoil_DefeatActor, 3 SetBattleSubStep1. (C1, E-0380)
; skips an absent actor, scales HL to 80 percent (ScaleHLTo80Percent_Bank32), then the effect
; sub-step (renamed from ResolveStep0EEffect_Scale80Percent from its E-0357 note, E-0367)
ResolveStep0EEffect_Recoil::
    ld a, [wBattleSubStep2]
    jumptable
    dw ResolveStep0EEffect_Recoil_Start
    dw ResolveStep0EEffect_Recoil_LoseHP
    dw ResolveStep0EEffect_Recoil_DefeatActor
    dw SetBattleSubStep1

; The recoil effect, sub-step 0: skips an absent actor; otherwise selects the effect (flags $20,
; then flags2 $08). (C2, E-0357; probed E-0380)
ResolveStep0EEffect_Recoil_Start::
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

; The recoil effect, sub-step 1: the actor loses four fifths of its HP plus one (shown as the
; damage, text $35/$36 by side); at 0 HP it falls (sub-step 2). (C1, E-0357)
ResolveStep0EEffect_Recoil_LoseHP::
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
    sub l
    ld c, a
    ld a, b
    sbc h
    ld b, a
    jr c, .skip
    or c
    jr z, .skip
    jr .restore

.skip:
    ld bc, $0000

.restore:
    pop hl
    ld a, c
    ld [hli], a
    ld [hl], b
    or b
    jr nz, .set_temp0_to_35
    ld hl, wBattleSubStep2
    dec [hl]
    xor a
    ld [wEffectSubStep], a

.set_temp0_to_35:
    ld a, $35
    ld [wTemp0], a
    call ActorOnLocalSide_Bank32
    jr nc, .read_battle_target
    ld hl, wTemp0
    inc [hl]

.read_battle_target:
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

; The recoil effect, sub-step 2: the actor's defeat (RecoilEffect_DefeatSteps) with the actor as
; target. (C1, E-0357)
ResolveStep0EEffect_Recoil_DefeatActor::
    ld a, [wBattleTarget]
    ld [wLoadSlot], a
    ld a, [wBattleActor]
    ld [wBattleTarget], a
    call RecoilEffect_DefeatSteps
    ld a, [wLoadSlot]
    ld [wBattleTarget], a
    ret

; The defeat steps of the actor in the recoil effect: runs the case of wEffectSubStep, 0
; RecoilEffect_DefeatSteps_Defeat, 1 RecoilEffect_DefeatSteps_BlankPicture, 2
; RecoilEffect_DefeatSteps_ShowDefeatText, which also adds 1 to wBattleSubStep2. Called by
; ResolveStep0EEffect_Recoil_DefeatActor with the actor as wBattleTarget. (C1, E-0380)
; the sub-steps of an effect that defeats a target: defeats it, blanks its picture and marks the
; slot in wLevelUpGains (E-0354; was: runs the routine for wEffectSubStep (jump table of three)
; (E-0122) (E-0344: the address in its name dropped or read as the label there; was
; RecoilEffect_DefeatSteps))
RecoilEffect_DefeatSteps::
    ld a, [wEffectSubStep]
    jumptable
    dw RecoilEffect_DefeatSteps_Defeat
    dw RecoilEffect_DefeatSteps_BlankPicture
    dw RecoilEffect_DefeatSteps_ShowDefeatText

; A defeat, step 0: marks the target $FE and defeats it (DefeatTarget). (C2, E-0357; probed E-0380)
RecoilEffect_DefeatSteps_Defeat::
    ld hl, wEffectSubStep
    inc [hl]
    ld a, [wBattleTarget]
    ld hl, wSlotMarks
    add_a_to_hl
    ld [hl], $fe
    call DefeatTarget
    ret

; A defeat, step 1: blanks the target's picture. (C1, E-0357)
RecoilEffect_DefeatSteps_BlankPicture::
    call BlankTargetMonsterPicture
    ld hl, wEffectSubStep
    inc [hl]
    ret

; A defeat, step 2: marks its level-up gains (bit 2) and shows text $90 ($8D for a foe actor); then
; the next sub-step. (C1, E-0357)
RecoilEffect_DefeatSteps_ShowDefeatText::
    ld a, [wBattleTarget]
    call SetBit2OfLevelUpGainsIndexed_Bank32
    ld a, $90
    ld [wTemp0], a
    call ActorOnLocalSide_Bank32
    jr c, .read_temp0
    ld a, $8d
    ld [wTemp0], a

.read_temp0:
    ld a, [wTemp0]
    ld d, a
    farcall ShowBattleText
    ld hl, wBattleSubStep2
    inc [hl]
    xor a
    ld [wEffectSubStep], a
    ret

; Sets wBattleSubStep2 to 0 and wBattleSubStep to 1, which sends the effect of resolve step $0E back
; to ResolveStep0EEffect_ShowMessage (then ResolveStep0EEffect_Finish). The status cases of
; ResolveStep0EEffect_Start jump here when they have no effect, SkipTurnIfActorAbsent calls it, and
; it is the last entry of the jump tables of ResolveStep0EEffect_Recoil. (C2, E-0380)
; wBattleSubStep2 = 0, wBattleSubStep = 1 (E-0071)
SetBattleSubStep1::
    xor a
    ld [wBattleSubStep2], a
    ld a, $01
    ld [wBattleSubStep], a
    ret

; Sub-step 4 of ResolveStep0EEffect, started for SKILL_KAMIKAZE; runs the case of wBattleSubStep2: 0
; ResolveStep0EEffect_Brutalize_Start, 1 ResolveStep0EEffect_Brutalize_LeaveOneHP (the actor is left
; with 1 HP and '0 was brutalized!' is shown with the actor as target; an actor with exactly 1 HP
; drops to 0 instead and goes on to case 2), 2 ResolveStep0EEffect_Brutalize_DefeatActor, 3
; ResolveStep0EEffect_Brutalize_Finish. (C1, E-0380)
; by its step: skips an absent actor and shows '0 was brutalized!' on the target
ResolveStep0EEffect_Brutalize::
    ld a, [wBattleSubStep2]
    jumptable
    dw ResolveStep0EEffect_Brutalize_Start
    dw ResolveStep0EEffect_Brutalize_LeaveOneHP
    dw ResolveStep0EEffect_Brutalize_DefeatActor
    dw ResolveStep0EEffect_Brutalize_Finish

; The Brutalize effect, sub-step 0: skips an absent actor; otherwise selects the effect. (C2,
; E-0357; probed E-0380)
ResolveStep0EEffect_Brutalize_Start::
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

; The Brutalize effect, sub-step 1: leaves the actor at 1 HP (0 when it had exactly 1, which defeats
; it) with battle text $38. (C1, E-0357)
ResolveStep0EEffect_Brutalize_LeaveOneHP::
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
    or a
    jr nz, .skip
    ld a, l
    cp $01
    jr nz, .skip
    ld bc, $0000
    jr .restore

.skip:
    ld bc, $0001

.restore:
    pop hl
    ld a, c
    ld [hli], a
    ld [hl], b
    or b
    jr nz, .read_battle_target
    ld hl, wBattleSubStep2
    dec [hl]
    xor a
    ld [wEffectSubStep], a
    jr .read_battle_actor

.read_battle_target:
    ld a, [wBattleTarget]
    ld [wLoadSlot], a
    ld a, [wBattleActor]
    ld [wBattleTarget], a
    ld d, $38 ; battle text '0 was brutalized!'
    farcall ShowBattleText
    ld a, [wLoadSlot]
    ld [wBattleTarget], a

.read_battle_actor:
    ld a, [wBattleActor]
    call SetBit0OfLevelUpGainsIndexed_Bank32
    ret

; The Brutalize effect, sub-step 2: defeats the actor (ResolveStep0EEffect_Brutalize_DefeatTarget
; with wBattleActor as wBattleTarget), keeping the target in wLoadSlot and restoring it; the
; defeat's last step advances wBattleSubStep2. (C1, E-0372)
ResolveStep0EEffect_Brutalize_DefeatActor::
    ld a, [wBattleTarget]
    ld [wLoadSlot], a
    ld a, [wBattleActor]
    ld [wBattleTarget], a
    call ResolveStep0EEffect_Brutalize_DefeatTarget
    ld a, [wLoadSlot]
    ld [wBattleTarget], a
    ret

; The defeat steps of the actor in the Brutalize effect: runs the case of wEffectSubStep, 0
; ResolveStep0EEffect_Brutalize_DefeatTarget_Defeat, 1
; ResolveStep0EEffect_Brutalize_DefeatTarget_Blank, 2
; ResolveStep0EEffect_Brutalize_DefeatTarget_Message, which sets bit 2 of wLevelUpGains for the
; target, shows text $90 or $8D and adds 1 to wBattleSubStep2. Called by
; ResolveStep0EEffect_Brutalize_DefeatActor. (C1, E-0380)
; defeats the target, blanks its picture and sets bit 2 of its level-up gains entry ('0 was
; brutalized!')
ResolveStep0EEffect_Brutalize_DefeatTarget::
    ld a, [wEffectSubStep]
    jumptable
    dw ResolveStep0EEffect_Brutalize_DefeatTarget_Defeat
    dw ResolveStep0EEffect_Brutalize_DefeatTarget_Blank
    dw ResolveStep0EEffect_Brutalize_DefeatTarget_Message

; The Brutalize defeat, step 0: marks the slot $FE and defeats it. (C2, E-0357; probed E-0380)
ResolveStep0EEffect_Brutalize_DefeatTarget_Defeat::
    ld hl, wEffectSubStep
    inc [hl]
    ld a, [wBattleTarget]
    ld hl, wSlotMarks
    add_a_to_hl
    ld [hl], $fe
    call DefeatTarget
    ret

; The Brutalize defeat, step 1: blanks the picture. (C1, E-0357)
ResolveStep0EEffect_Brutalize_DefeatTarget_Blank::
    call BlankTargetMonsterPicture
    ld hl, wEffectSubStep
    inc [hl]
    ret

; The Brutalize defeat, step 2 (wEffectSubStep 2 of ResolveStep0EEffect_Brutalize_DefeatTarget):
; sets bit 2 of the target's level-up gains entry, shows battle text $90 when the actor is on the
; local side (ActorOnLocalSide_Bank32 carry), else $8D, then wBattleSubStep2 += 1 and wEffectSubStep
; = 0. (C1, E-0372)
ResolveStep0EEffect_Brutalize_DefeatTarget_Message::
    ld a, [wBattleTarget]
    call SetBit2OfLevelUpGainsIndexed_Bank32
    ld a, $90
    ld [wTemp0], a
    call ActorOnLocalSide_Bank32
    jr c, .read_temp0
    ld a, $8d
    ld [wTemp0], a

.read_temp0:
    ld a, [wTemp0]
    ld d, a
    farcall ShowBattleText
    ld hl, wBattleSubStep2
    inc [hl]
    xor a
    ld [wEffectSubStep], a
    ret

; The Brutalize effect, sub-step 3: back to resolve sub-step 1. (C2, E-0357; probed E-0380)
ResolveStep0EEffect_Brutalize_Finish::
    call SetBattleSubStep1
    ret

; Resolve step $0E, sub-step 5 (Sacrifice, Farewell, LifeDance and action $D6): for $D6 switches to
; the formation partner once; then by sub-step: the actor check, the cost, the defeat and the end.
; (C1, E-0357)
ResolveStep0EEffect_Sacrifice::
    ld a, [wBattleActionId]
    cp ACTION_D6
    jr nz, .read_battle_sub_step2
    ld a, [wSavedActorByte]
    bit 0, a
    jr z, .read_battle_sub_step2
    bit 7, a
    jr nz, .read_battle_sub_step2
    set 7, a
    ld [wSavedActorByte], a
    farcall ActorFormationSlotToTemp0
    ldh a, [hTemp0]
    ld [wBattleActor], a

.read_battle_sub_step2:
    ld a, [wBattleSubStep2]
    jumptable
    dw ResolveStep0EEffect_Sacrifice_CheckActor
    dw ResolveStep0EEffect_Sacrifice_LoseHP
    dw ResolveStep0EEffect_Sacrifice_DefeatActor
    dw ResolveStep0EEffect_Sacrifice_End

; The sacrifice, step 0: next step; an absent actor (CarryUnlessBattleSlotOutSlotEmpty) goes
; straight to the end (ResolveStep0EEffect_Sacrifice_End). (C2, E-0372; probed E-0380)
ResolveStep0EEffect_Sacrifice_CheckActor::
    ld hl, wBattleSubStep2
    inc [hl]
    ld a, [wBattleActor]
    call CarryUnlessBattleSlotOutSlotEmpty
    jp c, ResolveStep0EEffect_Sacrifice_End
    ret

; The sacrifice, step 1: marks the actor's level-up gains bit 0; half the time (wRandomLo bit 0) the
; actor loses all but 1% of its HP (at least 1 kept) with battle text $38 ('0 was brutalized!', the
; actor as target), otherwise, or when that would take nothing, its HP becomes 0 with damage 1000.
; At 0 HP the next step defeats the actor (step 2), otherwise step 3 ends. (C1, E-0372)
ResolveStep0EEffect_Sacrifice_LoseHP::
    ld hl, wBattleSubStep2
    inc [hl]
    ld hl, wBattleSubStep2
    inc [hl]
    ld a, [wBattleActor]
    call SetBit0OfLevelUpGainsIndexed_Bank32
    call AdvanceRandom
    ld a, [wRandomLo]
    and $01
    jr z, .read_battle_actor
    ld a, [wBattleActor]
    call GetBattleHP_Bank32
    push hl
    ld a, $64
    call DivideHLByA
    ld a, h
    or l
    jr nz, .restore
    ld hl, $0001

.restore:
    pop bc
    ld a, c
    sub l
    ld c, a
    ld a, b
    sbc h
    ld b, a
    or c
    jr nz, .set_battle_damage_lo
    jr .read_battle_actor

.set_battle_damage_lo:
    ld a, c
    ld [wBattleDamageLo], a
    ld a, b
    ld [wBattleDamageHi], a
    ld a, [wBattleTarget]
    ld [wLoadSlot], a
    ld a, [wBattleActor]
    ld [wBattleTarget], a
    ld d, $38 ; battle text '0 was brutalized!'
    farcall ShowBattleText
    ld a, [wLoadSlot]
    ld [wBattleTarget], a
    jr .read_battle_actor2

.read_battle_actor:
    ld a, [wBattleActor]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank32
    xor a
    ld [hli], a
    ld [hl], a
    ld hl, $03e8
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a

.read_battle_actor2:
    ld a, [wBattleActor]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank32
    ld a, [hli]
    ld d, [hl]
    ld e, a
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wBattleDamageHi]
    ld b, a
    ld a, e
    sub c
    ld e, a
    ld a, d
    sbc b
    ld d, a
    jr c, .skip
    ld a, d
    ld [hld], a
    ld [hl], e
    or e
    jr nz, .return
    inc hl

.skip:
    xor a
    ld [hld], a
    ld [hl], a
    ld hl, wBattleSubStep2
    dec [hl]
    xor a
    ld [wEffectSubStep], a

.return:
    ret

; The sacrifice, step 2: the actor's defeat with the actor as target. (C1, E-0357)
ResolveStep0EEffect_Sacrifice_DefeatActor::
    ld a, [wBattleTarget]
    ld [wLoadSlot], a
    ld a, [wBattleActor]
    ld [wBattleTarget], a
    call SacrificeEffect_DefeatSteps
    ld a, [wLoadSlot]
    ld [wBattleTarget], a
    ret

; The defeat steps of the actor in the Sacrifice effect: runs the case of wEffectSubStep, 0
; SacrificeEffect_DefeatSteps_Defeat, 1 SacrificeEffect_DefeatSteps_BlankPicture, 2
; SacrificeEffect_DefeatSteps_ShowHeroDroppedDead, which shows text $8C for SKILL_LIFEDANCE (else
; $90, or $8D for a foe) and then continues into ResolveStep0EEffect_Sacrifice_End. Called by
; ResolveStep0EEffect_Sacrifice_DefeatActor. (C1, E-0380)
; runs the routine for wEffectSubStep (jump table of three) (E-0122) (E-0344: the address in its
; name dropped or read as the label there; was SacrificeEffect_DefeatSteps)
SacrificeEffect_DefeatSteps::
    ld a, [wEffectSubStep]
    jumptable
    dw SacrificeEffect_DefeatSteps_Defeat
    dw SacrificeEffect_DefeatSteps_BlankPicture
    dw SacrificeEffect_DefeatSteps_ShowHeroDroppedDead

; The sacrifice's defeat, step 0: marks the slot $FE and defeats it. (C2, E-0357; probed E-0380)
SacrificeEffect_DefeatSteps_Defeat::
    ld hl, wEffectSubStep
    inc [hl]
    ld a, [wBattleTarget]
    ld hl, wSlotMarks
    add_a_to_hl
    ld [hl], $fe
    call DefeatTarget
    ret

; The sacrifice's defeat, step 1: blanks the picture. (C1, E-0357)
SacrificeEffect_DefeatSteps_BlankPicture::
    call BlankTargetMonsterPicture
    ld hl, wEffectSubStep
    inc [hl]
    ret

; The sacrifice's defeat, step 2: marks the level-up gains and shows text $8C for LifeDance, else
; $90 ($8D for a foe). (C1, E-0357)
SacrificeEffect_DefeatSteps_ShowHeroDroppedDead::
    ld a, [wBattleTarget]
    call SetBit2OfLevelUpGainsIndexed_Bank32
    ld a, [wBattleActionId]
    cp SKILL_LIFEDANCE
    ld d, $8c
    jr z, .call_show_battle_text
    ld d, $90
    call ActorOnLocalSide_Bank32
    jr c, .call_show_battle_text
    ld d, $8d ; battle text '0 dropped dead!'

.call_show_battle_text:
    farcall ShowBattleText
    xor a
    ld [wEffectSubStep], a

; The sacrifice, step 3 (also reached from step 0 for an absent actor and by falling from
; RunEffectSubStep_2_ShowHeroDroppedDead): for ACTION_D6 the first pass sets wSavedActorByte bit 0
; and restarts the steps (the next pass runs for the formation partner), and the second restores
; wBattleActor from wSavedActorSlot; then, and for every other action, wBattleSubPhase 6 with
; wBattleResolveStep and wBattleSubStep2 0. (C2, E-0372; probed E-0380)
ResolveStep0EEffect_Sacrifice_End::
    ld a, [wBattleActionId]
    cp ACTION_D6
    jr nz, .set_battle_sub_phase_to_06
    ld a, [wSavedActorByte]
    bit 0, a
    jr z, .set_saved_actor_byte
    ld a, [wSavedActorSlot]
    ld [wBattleActor], a
    jr .set_battle_sub_phase_to_06

.set_saved_actor_byte:
    inc a
    ld [wSavedActorByte], a
    xor a
    ld [wBattleSubStep2], a
    xor a
    ld [wEffectSubStep], a
    ret

.set_battle_sub_phase_to_06:
    ld a, $06
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    xor a
    ld [wBattleSubStep2], a
    ret

; Resolve step $0E, sub-steps 6, 7 and 8: a bare ret, so nothing advances; ResolveStep0EEffect_Start
; sets only sub-steps 1, 3, 4, 5 and 9, and no write of 6-8 was found in the routines read here.
; (C2, E-0372; probed E-0380)
ResolveStep0EEffect_DoNothing::
    ret

; Sub-step 9 of ResolveStep0EEffect, started for SKILL_TWINSLASH; runs the case of wBattleSubStep2:
; 0 ResolveStep0EEffect_QuarterRecoil_Start, 1 ResolveStep0EEffect_QuarterRecoil_LoseHP (the actor
; loses a quarter of the damage dealt, at least 1), 2 ResolveStep0EEffect_QuarterRecoil_DefeatActor,
; 3 ResolveStep0EEffect_QuarterRecoil_Finish. (C1, E-0380)
; skips an absent actor, computes damage on the target and selects the effect by the effect flags
; (SelectEffectByEffectFlags, SelectEffectByEffectFlags2Flags) (renamed from
; ResolveStep0EEffect_DamageAndSelectEffect from its E-0357 note, E-0367)
ResolveStep0EEffect_QuarterRecoil::
    ld a, [wBattleSubStep2]
    jumptable
    dw ResolveStep0EEffect_QuarterRecoil_Start
    dw ResolveStep0EEffect_QuarterRecoil_LoseHP
    dw ResolveStep0EEffect_QuarterRecoil_DefeatActor
    dw ResolveStep0EEffect_QuarterRecoil_Finish

; The quarter-recoil effect, sub-step 0: skips an absent actor; otherwise selects the effect. (C2,
; E-0357; probed E-0380)
ResolveStep0EEffect_QuarterRecoil_Start::
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

; The quarter-recoil effect, sub-step 1: the actor loses a quarter of the damage dealt (at least 1)
; with text $35/$36 by side; at 0 HP it falls. (C1, E-0357)
ResolveStep0EEffect_QuarterRecoil_LoseHP::
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
    or h
    jr nz, .restore
    ld hl, $0001
    ld a, l
    ld [wEffectTemp0], a
    ld a, h
    ld [wEffectTemp1], a

.restore:
    pop bc
    ld a, c
    sub l
    ld c, a
    ld a, b
    sbc h
    ld b, a
    jr c, .skip
    or c
    jr z, .skip
    jr .restore2

.skip:
    ld bc, $0000

.restore2:
    pop hl
    ld a, c
    ld [hli], a
    ld [hl], b
    or c
    jr nz, .set_temp0_to_35
    ld hl, wBattleSubStep2
    dec [hl]
    xor a
    ld [wEffectSubStep], a

.set_temp0_to_35:
    ld a, $35
    ld [wTemp0], a
    call ActorOnLocalSide_Bank32
    jr nc, .read_battle_target
    ld hl, wTemp0
    inc [hl]

.read_battle_target:
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

; The quarter-recoil effect, sub-step 2: the actor's defeat with the actor as target. (C1, E-0357)
ResolveStep0EEffect_QuarterRecoil_DefeatActor::
    ld a, [wBattleTarget]
    ld [wLoadSlot], a
    ld a, [wBattleActor]
    ld [wBattleTarget], a
    call QuarterRecoilEffect_DefeatSteps
    ld a, [wLoadSlot]
    ld [wBattleTarget], a
    ret

; The defeat steps of the actor in the quarter-recoil effect: runs the case of wEffectSubStep, 0
; QuarterRecoilEffect_DefeatSteps_Defeat, 1 QuarterRecoilEffect_DefeatSteps_BlankPicture, 2
; QuarterRecoilEffect_DefeatSteps_ShowDefeatText, which also adds 1 to wBattleSubStep2. Called by
; ResolveStep0EEffect_QuarterRecoil_DefeatActor. (C1, E-0380)
; runs the routine for wEffectSubStep (jump table of three) (E-0122) (E-0344: the address in its
; name dropped or read as the label there; was QuarterRecoilEffect_DefeatSteps)
QuarterRecoilEffect_DefeatSteps::
    ld a, [wEffectSubStep]
    jumptable
    dw QuarterRecoilEffect_DefeatSteps_Defeat
    dw QuarterRecoilEffect_DefeatSteps_BlankPicture
    dw QuarterRecoilEffect_DefeatSteps_ShowDefeatText

; A defeat, step 0: marks the slot $FE and defeats it. (C2, E-0357; probed E-0380)
QuarterRecoilEffect_DefeatSteps_Defeat::
    ld hl, wEffectSubStep
    inc [hl]
    ld a, [wBattleTarget]
    ld hl, wSlotMarks
    add_a_to_hl
    ld [hl], $fe
    call DefeatTarget
    ret

; A defeat, step 1: blanks the picture. (C1, E-0357)
QuarterRecoilEffect_DefeatSteps_BlankPicture::
    call BlankTargetMonsterPicture
    ld hl, wEffectSubStep
    inc [hl]
    ret

; A defeat, step 2: marks the level-up gains and shows text $90 ($8D for a foe); then the next
; sub-step. (C1, E-0357)
QuarterRecoilEffect_DefeatSteps_ShowDefeatText::
    ld a, [wBattleTarget]
    call SetBit2OfLevelUpGainsIndexed_Bank32
    ld a, $90
    ld [wTemp0], a
    call ActorOnLocalSide_Bank32
    jr c, .read_temp0
    ld a, $8d
    ld [wTemp0], a

.read_temp0:
    ld a, [wTemp0]
    ld d, a
    farcall ShowBattleText
    ld hl, wBattleSubStep2
    inc [hl]
    xor a
    ld [wEffectSubStep], a
    ret

; The quarter-recoil effect, sub-step 3: back to resolve sub-step 1. (C2, E-0357; probed E-0380)
ResolveStep0EEffect_QuarterRecoil_Finish::
    call SetBattleSubStep1
    ret

; Far-called by ActionEffect_Surge: marks the target done (SetTargetSlotMarksTo3) when it was
; asleep, paralyzed or confused (status 0 and $D0), clears status byte 0 and marks its level-up
; gains bit 2; clears BSTAT1_SPELLS_SEALED, BSTAT1_BLINDED, BSTAT1_DANCE_SEALED,
; BSTAT1_BREATH_SEALED, BSTAT5_RADIANT_BLIND, BSTAT5_SANDSTORM_BLIND and BSTAT8_EERIE_LITE; when
; BSTAT6_STATS_LOWERED was set clears it and raises wBattleAGL and wBattleDEF to their base values
; (GetBaseAGL, GetBaseDEF, CompareHLToBC) when below. (C2, E-0372; probed E-0380)
ActionEffect_Surge_CureTarget::
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    and $d0
    call nz, SetTargetSlotMarksTo3
    xor a
    ld [hli], a
    ld a, [wBattleTarget]
    call SetBit2OfLevelUpGainsIndexed_Bank32
    ld a, [hl]
    and $3c
    ld [hli], a
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    and $fc
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
    add a
    add_a_to_hl
    push hl
    deref_hl
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleStatResultHi]
    ld b, a
    call CompareHLToBC
    pop hl
    jr nc, .read_battle_target
    ld a, [wBattleStatResultLo]
    ld [hli], a
    ld a, [wBattleStatResultHi]
    ld [hl], a

.read_battle_target:
    ld a, [wBattleTarget]
    ld c, a
    farcall GetBaseDEF
    ld a, [wBattleTarget]
    ld hl, wBattleDEF
    add a
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
    ld [hli], a
    ld a, [wBattleStatResultHi]
    ld [hl], a
    ret

; Sets wSlotMarks[wBattleTarget] to 3 and keeps BC, DE and HL (A is not kept).
; ActionEffect_Surge_CureTarget and ActionEffect_DeMagic_ClearTargetStatus call it for a target that
; has a status they are about to remove. (C2, E-0380)
; wSlotMarks[wBattleTarget] = 3; BC, HL kept (E-0118)
SetTargetSlotMarksTo3::
    push hl
    push bc
    ld a, [wBattleTarget]
    ld hl, wSlotMarks
    add_a_to_hl
    ld [hl], $03
    pop bc
    pop hl
    ret
    db $c9

; Far-called by ActionEffect_DeMagic: marks the target done (SetTargetSlotMarksTo3) when it was
; asleep or confused, or ironized (BSTAT5_IRONIZED bits), and marks its level-up gains bit 2. It
; keeps only status 0 bits 0, 1, 5 and 6 (poison, bad poison, curse, paralysis) and
; BSTAT1_DRAGON_FORM and BSTAT1_TRANSFORMED; clears status byte 2, BSTAT3_SHIVERING, status 5 bits
; 2-3 and 6-7 (the BSTAT5_SIDE_STEP and BSTAT5_IRONIZED fields), BSTAT6_IMITATE, BSTAT6_STATS_RAISED
; and BSTAT6_STATS_LOWERED (without restoring stats), BSTAT7_COUNTER, BSTAT8_MAGIC_WALL and
; BSTAT8_EERIE_LITE. (C2, E-0372; probed E-0380)
ActionEffect_DeMagic_ClearTargetStatus::
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    and $90
    call nz, SetTargetSlotMarksTo3
    ld a, [hl]
    and $63
    ld [hl], a
    ld a, [wBattleTarget]
    call SetBit2OfLevelUpGainsIndexed_Bank32
    inc hl
    ld a, [hl]
    and $30
    ld [hl], a
    inc hl
    xor a
    ld [hli], a
    ld a, [hl]
    and $f7
    ld [hli], a
    ld a, [hl]
    and $ff
    ld [hli], a
    ld a, [hl]
    and $c0
    call nz, SetTargetSlotMarksTo3
    ld a, [hl]
    and $33
    ld [hli], a
    ld a, [hl]
    and $37
    ld [hli], a
    ld a, [hl]
    and $fb
    ld [hli], a
    ld a, [hl]
    and $3f
    ld [hl], a
    ret

; Resolve step 5 of an action (RunActionResolveStep_EffectSubSteps): runs the case of
; wBattleSubStep, 0 RunBattleSubStep_SelectEffect, 1 RunBattleSubStep_DealDamage, 2
; RunBattleSubStep_DefeatDamagedSlot. (C1, E-0380)
; the sub-steps of an action's battle effect: selects the effect by its effect flags and runs it
; (E-0354; was: runs the routine for wBattleSubStep (jump table of three) (E-0122) (E-0344: the
; address in its name dropped or read as the label there; was RunBattleSubStep))
RunBattleSubStep::
    ld a, [wBattleSubStep]
    jumptable
    dw RunBattleSubStep_SelectEffect
    dw RunBattleSubStep_DealDamage
    dw RunBattleSubStep_DefeatDamagedSlot

; The effect, sub-step 0: selects the effect by both effect flag bytes. (C2, E-0357; probed E-0380)
RunBattleSubStep_SelectEffect::
    ld hl, wBattleSubStep
    inc [hl]
    farcall SelectEffectByEffectFlags
    farcall SelectEffectByEffectFlags2Flags
    ret

; The effect, sub-step 1: takes the damage from the target's HP (to 0 at most), marks its level-up
; gains (bit 0) and shows text $35 ($36 for a foe actor), swapping actor and target for the message;
; at 0 HP the next sub-step defeats it, otherwise the next resolve step. (C1, E-0357)
RunBattleSubStep_DealDamage::
    ld a, [wBattleTarget]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank32
    ld a, [hli]
    ld d, [hl]
    ld e, a
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wBattleDamageHi]
    ld b, a
    ld a, e
    sub c
    ld e, a
    ld a, d
    sbc b
    ld d, a
    jr c, .skip
    ld a, d
    ld [hld], a
    ld [hl], e
    or e
    jr nz, .clear_battle_sub_step
    inc hl

.skip:
    xor a
    ld [hld], a
    ld [hl], a
    ld hl, wBattleSubStep
    inc [hl]
    xor a
    ld [wBattleSubStep2], a
    jr .read_battle_target

.clear_battle_sub_step:
    xor a
    ld [wBattleSubStep], a
    ld hl, wBattleResolveStep
    inc [hl]

.read_battle_target:
    ld a, [wBattleTarget]
    call SetBit0OfLevelUpGainsIndexed_Bank32
    call ActorOnLocalSide_Bank32
    ld d, $35
    jr c, .call_show_battle_text
    ld d, $36 ; battle text '0 took G damage!'

.call_show_battle_text:
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

; The effect, sub-step 2 (after RunBattleSubStep_DealDamage left the damaged slot at 0 HP):
; RunBattleSubStep_DealDamage swapped wBattleActor and wBattleTarget after its message, so the slot
; now in wBattleActor is the one that took the damage; runs RunBattleSubStep_DefeatSteps with it as
; wBattleTarget, keeping the target in wLoadSlot and restoring it. (C1, E-0372)
RunBattleSubStep_DefeatDamagedSlot::
    ld a, [wBattleTarget]
    ld [wLoadSlot], a
    ld a, [wBattleActor]
    ld [wBattleTarget], a
    call RunBattleSubStep_DefeatSteps
    ld a, [wLoadSlot]
    ld [wBattleTarget], a
    ret

; The defeat steps after RunBattleSubStep_DealDamage took a slot to 0 HP: runs the case of
; wBattleSubStep2, 0 RunBattleSubStep_DefeatSteps_Defeat, 1
; RunBattleSubStep_DefeatSteps_BlankPicture, 2 RunBattleSubStep_DefeatSteps_ShowDefeatText, which
; then moves wBattleResolveStep on and sets wMultiHitCount to $81. Called by
; RunBattleSubStep_DefeatDamagedSlot. (C1, E-0380)
; runs the routine for wBattleSubStep2 (jump table of three) (E-0122) (E-0344: the address in its
; name dropped or read as the label there; was RunBattleSubStep_DefeatSteps)
RunBattleSubStep_DefeatSteps::
    ld a, [wBattleSubStep2]
    jumptable
    dw RunBattleSubStep_DefeatSteps_Defeat
    dw RunBattleSubStep_DefeatSteps_BlankPicture
    dw RunBattleSubStep_DefeatSteps_ShowDefeatText

; The effect's defeat, step 0: marks the slot $FE and defeats it. (C2, E-0357; probed E-0380)
RunBattleSubStep_DefeatSteps_Defeat::
    ld hl, wBattleSubStep2
    inc [hl]
    ld a, [wBattleTarget]
    ld hl, wSlotMarks
    add_a_to_hl
    ld [hl], $fe
    call DefeatTarget
    ret

; The effect's defeat, step 1: blanks the picture. (C1, E-0357)
RunBattleSubStep_DefeatSteps_BlankPicture::
    call BlankTargetMonsterPicture
    ld hl, wBattleSubStep2
    inc [hl]
    ret

; The effect's defeat, step 2: marks the level-up gains and shows text $8A ($8B for a foe actor),
; then the next resolve step with the hits ended ($81). (C1, E-0357)
RunBattleSubStep_DefeatSteps_ShowDefeatText::
    ld a, [wBattleTarget]
    call SetBit2OfLevelUpGainsIndexed_Bank32
    ld a, $8a
    ld [wTemp0], a
    call ActorOnLocalSide_Bank32
    jr c, .read_temp0
    ld a, $8b
    ld [wTemp0], a

.read_temp0:
    ld a, [wTemp0]
    ld d, a
    farcall ShowBattleText
    xor a
    ld [wBattleSubStep2], a
    xor a
    ld [wBattleSubStep], a
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, $81
    ld [wMultiHitCount], a
    ret

; When wBattleSlotOut[wBattleActor] is non-zero (the actor is not in the fight; carry set by
; CarryUnlessBattleSlotOutSlotEmpty) it runs SetBattleSubStep1 and returns carry set so that the
; caller can return; for a present actor it returns carry clear and changes nothing.
; ResolveStep0EEffect_Recoil_Start, ResolveStep0EEffect_Brutalize_Start and
; ResolveStep0EEffect_QuarterRecoil_Start call it. (C2, E-0380)
; when the actor's slot is absent (CarryUnlessBattleSlotOutSlotEmpty) runs SetBattleSubStep1 and
; returns carry set; otherwise returns carry clear (E-0115)
SkipTurnIfActorAbsent::
    ld a, [wBattleActor]
    call CarryUnlessBattleSlotOutSlotEmpty
    ret nc
    call SetBattleSubStep1
    scf
    ret

; HL = HL * 8 / 10, computed with a 24-bit product (Multiply8By16) and Divide24ByA; A = the
; remainder; DE is kept and BC is not. Used by ResolveStep0EEffect_Recoil_LoseHP. (C2, E-0380)
; HL = HL * 8 / 10 (24-bit intermediate; Multiply8By16 then Divide24ByA), A = the remainder; DE kept
; (E-0067) (the same 15 bytes appear in 2 banks)
ScaleHLTo80Percent_Bank32::
    push de
    ld b, h
    ld c, l
    ld a, $08
    call Multiply8By16
    ld a, $0a
    call Divide24ByA
    pop de
    ret

; The defeat steps of an item use: runs the case of wBattleSubStep2, 0
; UseItemDefeat_RunSteps_Defeat, 1 UseItemDefeat_RunSteps_BlankPicture, 2
; UseItemDefeat_RunSteps_ShowDefeatText, which moves wBattleResolveStep on and shows text $8A or $8B
; by the side of the target. Called by far call from RunBattleActions_UseItem_DefeatTarget (item use
; step 9). (C1, E-0380)
; runs the routine for wBattleSubStep2 (jump table of three) (E-0122) (E-0344: the address in its
; name dropped or read as the label there; was UseItemDefeat_RunSteps)
UseItemDefeat_RunSteps::
    ld a, [wBattleSubStep2]
    jumptable
    dw UseItemDefeat_RunSteps_Defeat
    dw UseItemDefeat_RunSteps_BlankPicture
    dw UseItemDefeat_RunSteps_ShowDefeatText

; Another defeat, step 0: lowers the target's mark by 5 and defeats it. (C2, E-0357; probed E-0380)
UseItemDefeat_RunSteps_Defeat::
    ld hl, wBattleSubStep2
    inc [hl]
    ld a, [wBattleTarget]
    ld hl, wSlotMarks
    add_a_to_hl
    ld a, [hl]
    add $fb
    ld [hl], a
    call DefeatTarget
    ret

; Another defeat, step 1: blanks the picture. (C1, E-0357)
UseItemDefeat_RunSteps_BlankPicture::
    call BlankTargetMonsterPicture
    ld hl, wBattleSubStep2
    inc [hl]
    ret

; Another defeat, step 2: marks the level-up gains and shows text $8A/$8B by the target's side; then
; the next resolve step. (C1, E-0357)
UseItemDefeat_RunSteps_ShowDefeatText::
    ld hl, wBattleResolveStep
    inc [hl]
    xor a
    ld [wBattleSubStep2], a
    ld a, [wBattleTarget]
    call SetBit2OfLevelUpGainsIndexed_Bank32
    ld d, $8b
    call TargetOnLocalSide_Bank32
    jr nc, .call_show_battle_text
    dec d

.call_show_battle_text:
    farcall ShowBattleText
    ret

; Looks at bits 0-3 of status byte 7 of wBattleTarget, clears them (bits 4-7 stay) and then applies
; only the first one found to the damage word wBattleDamageLo/wBattleDamageHi: bit 0 doubles it,
; else bit 1 multiplies it by 10, else bit 2 doubles it; bit 3 is cleared with no effect, and the
; 16-bit result wraps. A and HL are clobbered, DE too in the case of the multiplication by 10.
; ResolveStepDamageMessage far-calls it for ACTION_D7. (C2, E-0380)
ApplyDamageModifiers::
    ld a, [wBattleTarget]
    ld hl, wBattleStatus7
    call AddAx9ToHL
    ld a, [hl]
    push af
    and $f0
    ld [hl], a
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    pop af
    bit 0, a
    jr z, .check_bit1
    add hl, hl
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    ret

.check_bit1:
    bit 1, a
    jr z, .check_bit2
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

.check_bit2:
    bit 2, a
    ret z
    add hl, hl
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    ret
    db $21, $ff, $d8, $18, $28, $21, $0f, $d9, $18, $23, $21, $cf, $d8, $18, $1e

; A = battle slot: HL = the word wBattleMaxMP[slot], A = its low byte (the shared tail
; GetBattleStatWord_Bank32 does the indexing). (C2, E-0380)
; A = battle slot: HL = the word for that slot at wBattleMaxMP; A = its low byte (E-0064)
GetBattleMaxMP_Bank32::
    ld hl, wBattleMaxMP
    jr GetBattleStatWord_Bank32

; A = battle slot: HL = the word wBattleHP[slot], A = its low byte (the shared tail
; GetBattleStatWord_Bank32 does the indexing). (C2, E-0380)
; A = battle slot: HL = the word for that slot at wBattleHP; A = its low byte (E-0064)
GetBattleHP_Bank32::
    ld hl, wBattleHP
    jr GetBattleStatWord_Bank32

; A = battle slot: HL = the word wBattleMP[slot], A = its low byte (the shared tail
; GetBattleStatWord_Bank32 does the indexing). (C2, E-0380)
; A = battle slot: HL = the word for that slot at wBattleMP; A = its low byte (E-0064)
GetBattleMP_Bank32::
    ld hl, wBattleMP
    jr GetBattleStatWord_Bank32
    db $21, $1f, $d9, $18, $0a

; A = battle slot: A = wSlotAIMode[slot]; HL is left pointing at that byte. (C2, E-0380)
; A = the byte at wSlotAIMode + A; clobbers HL (the same 10 bytes appear in 5 banks)
ReadSlotAIModeIndexed_Bank32::
    ld hl, wSlotAIMode
    add_a_to_hl
    ld a, [hl]
    ret

; The shared tail of GetBattleMaxMP_Bank32, GetBattleHP_Bank32 and GetBattleMP_Bank32 (and of two
; unlabeled ld hl / jr loaders in the db bytes beside them): HL = a per-slot word table, A = slot:
; returns HL = the word at HL + 2 * A (A doubled in 8 bits) and A = its low byte (deref_hl). (C2,
; E-0372; probed E-0380)
GetBattleStatWord_Bank32::
    add a
    add_a_to_hl
    deref_hl
    ret

; HL += 2 * A, where A is doubled in 8 bits first (so $90 adds $20); A is clobbered and BC and DE
; are kept. Used to index the per-slot word arrays such as wBattleHP. (C2, E-0380)
; HL += 2 * A (A is doubled in 8 bits first, so it wraps above $7F); clobbers A (the same 7 bytes
; appear in 12 banks)
AddDoubleAToHL_Bank32::
    add a
    add_a_to_hl
    ret

; Carry set when wBattleActor is a slot of the local side: slots 0-3, or slots 4-7 when wLinkMode is
; 1 and wLinkRole bit 1 is set (the sides are reversed on that Game Boy); carry clear otherwise. A =
; wBattleActor on return. Which side is local is inferred from the reversal, nothing else is
; checked. (C2, E-0380)
; carry set when wBattleActor < 4 (slots 0-3); when wLinkMode = 1 and wLinkRole bit 1 is set the
; test is reversed (carry set when wBattleActor >= 4). Which side is local is inferred from the
; reversal, not checked (E-0064) (the same 27 bytes appear in 12 banks)
ActorOnLocalSide_Bank32::
    ld a, [wLinkMode]
    cp $01
    jr nz, .check_battle_actor
    ld a, [wLinkRole]
    bit 1, a
    jr z, .check_battle_actor
    ld a, [wBattleActor]
    cp $04
    ccf
    ret

.check_battle_actor:
    ld a, [wBattleActor]
    cp $04
    ret

; Carry set when wBattleTarget is a slot of the local side: slots 0-3, or slots 4-7 when wLinkMode
; is 1 and wLinkRole bit 1 is set (the sides are reversed on that Game Boy); carry clear otherwise.
; A = wBattleTarget on return. (C2, E-0380)
; carry set when wBattleTarget < 4 (slots 0-3); when wLinkMode = 1 and wLinkRole bit 1 is set the
; test is reversed (carry set when wBattleTarget >= 4) (E-0064) (the same 27 bytes appear in 12
; banks)
TargetOnLocalSide_Bank32::
    ld a, [wLinkMode]
    cp $01
    jr nz, .check_battle_target
    ld a, [wLinkRole]
    bit 1, a
    jr z, .check_battle_target
    ld a, [wBattleTarget]
    cp $04
    ccf
    ret

.check_battle_target:
    ld a, [wBattleTarget]
    cp $04
    ret

; ANDs status byte 0 of slot E with entry D of ClearBattleStatusBitsWithMaskD_Bank32_Data. (C2,
; E-0357; probed E-0380)
ClearBattleStatusBitsWithMaskD_Bank32::
    ld a, d
    ld hl, ClearBattleStatusBitsWithMaskD_Bank32_Data
    add_a_to_hl
    ld d, [hl]
    ld a, e
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, d
    and [hl]
    ld [hl], a
    ret

; Seven AND masks for the first status byte of a battler (BSTAT0_*): $DF clears bit 5
; (BSTAT0_CURSED), $FE bit 0 (BSTAT0_POISONED), $00 all bits, $FD bit 1 (BSTAT0_BADLY_POISONED), $73
; bits 2, 3 and 7 (the sleep counter and BSTAT0_ASLEEP), $EF bit 4 (BSTAT0_CONFUSED) and $BF bit 6
; (BSTAT0_PARALYZED). ClearBattleStatusBitsWithMaskD_Bank32 indexes it by D (0 to 6) and ANDs the
; mask into the wBattleStatus byte of slot E (9 bytes per slot). The same 7 bytes are in several
; battle banks. (C1, E-0381)
ClearBattleStatusBitsWithMaskD_Bank32_Data::
    db $df, $fe, $00, $fd, $73, $ef, $bf

; A = battle slot: sets bit 0 of wLevelUpGains[slot]; HL is kept, A is clobbered. (C2, E-0380)
; Sets bit 0 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks)
SetBit0OfLevelUpGainsIndexed_Bank32::
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 0, [hl]
    pop hl
    ret

; A = battle slot: sets bit 1 of wLevelUpGains[slot]; HL is kept, A is clobbered. (C2, E-0380)
; Sets bit 1 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks)
SetBit1OfLevelUpGainsIndexed_Bank32::
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 1, [hl]
    pop hl
    ret

; A = battle slot: sets bit 2 of wLevelUpGains[slot]; HL is kept, A is clobbered. (C2, E-0380)
; Sets bit 2 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks)
SetBit2OfLevelUpGainsIndexed_Bank32::
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 2, [hl]
    pop hl
    ret

; A = battle slot 0-7: returns A = 9 * g(wSlotPersonalityHi[slot]) + 3 *
; g(wSlotPersonalityMid[slot]) + g(wSlotPersonalityLo[slot]), a number from 0 to 26, with g(v) = 0
; for v at or above $C0, 1 for $40 to $BF and 2 below $40. BC and HL are kept. No caller of this
; copy exists in src/. (C2, E-0380)
; A = slot 0-7: returns A = 9 * g(wSlotPersonalityHi[A]) + 3 * g(wSlotPersonalityMid[A]) +
; g(wSlotPersonalityLo[A]) with g(v) = 0 for v >= $C0, 1 for v >= $40, else 2 (the same index
; PersonalityIndexOfRecord builds from a save record; E-0031); HL and BC are kept (the same 87 bytes
; appear in 13 banks)
PersonalityIndexOfSlot_Bank32::
    push hl
    push bc
    ld c, a
    ld b, $00
    ld hl, wSlotPersonalityHi
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp $c0
    jr nc, .skip
    ld l, $09
    cp $40
    jr nc, .skip
    ld l, $12

.skip:
    ld a, l
    add b
    ld b, a
    ld a, c
    ld hl, wSlotPersonalityMid
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp $c0
    jr nc, .skip2
    ld l, $03
    cp $40
    jr nc, .skip2
    ld l, $06

.skip2:
    ld a, l
    add b
    ld b, a
    ld a, c
    ld hl, wSlotPersonalityLo
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp $c0
    jr nc, .skip3
    ld l, $01
    cp $40
    jr nc, .skip3
    ld l, $02

.skip3:
    ld a, l
    add b
    pop bc
    pop hl
    ret

; A = battle slot: carry set when CheckSlotStatusBlock sets it (absent slot, status byte 0 AND $D0,
; byte 3 AND $3F, byte 5 AND $C0 or bit 3 of byte 8), or when byte 3 AND $C0 or byte 4 AND $0C is
; non-zero, so any bit of byte 3 counts; carry clear otherwise. A, BC and HL are kept. (C2, E-0380)
; A = slot: carry set when CheckSlotStatusBlock sets it, or when status byte 3 & $C0 or byte 4 & $0C
; is set (wBattleStatus3 + 9 * A); otherwise carry clear; A, BC, HL kept (E-0067) (the same 31 bytes
; appear in 12 banks)
CheckSlotStatusBlockWide_Bank32::
    call CheckSlotStatusBlock
    ret c
    push hl
    push bc
    ld c, a
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hli]
    and $c0
    jr nz, .set_carry
    ld a, [hl]
    and $0c
    jr nz, .set_carry
    xor a
    jr .skip

.set_carry:
    scf

.skip:
    ld a, c
    pop bc
    pop hl
    ret

; A = battle slot: returns A = status byte 3 AND $C0 of that slot, or, when that is 0, status byte 4
; AND $0C; Z set when both are 0. HL is kept. (C2, E-0380)
; A = slot: with HL = wBattleStatus3 + 9 * A (status byte 3 of wBattleStatus), A = byte 3 & $C0, or
; byte 4 & $0C when that is zero; Z set when both are clear; HL kept (E-0067) (the same 17 bytes
; appear in 13 banks)
SlotHasStatus3Or4Bits_Bank32::
    push hl
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hli]
    and $c0
    jr nz, .done
    ld a, [hl]
    and $0c

.done:
    pop hl
    ret
    ds $111c, $00

; The first of 1463 zero bytes ($00, nop) at the end of bank $32, up to $7FFF: running it changes no
; register and no flag. Its only mention in the source is a dw inside
; RunBattleActions_StatusChecks_CheckAction_Skip, which
; RunBattleActions_StatusChecks_CheckAction_CheckMP jumps into and runs as code (the bytes decode as
; a call to CheckFormationPartnersCanAct, jr c, ld a,d, cp 7 and jp z), so that dw is probably the
; jr offset $49 and ld a,d ($7A), not a pointer, and nothing is known to jump here. (C2, E-0380)
; a run of nop instructions reached as case 7
BattleActions_ZeroPadding::
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
