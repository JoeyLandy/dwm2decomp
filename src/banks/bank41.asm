SECTION "Bank 41", ROMX[$4000], BANK[$41]
    db $41

; E-0018. Sound ids 28-48.
; record: channel-state slot offset (added to $DC00); copied to slot byte +2 (meaning unverified); track stream (stored at slot +3/+4, with this bank at +5)
SoundRecords_Bank41::
Data_041_4001:: ; address name
    db $40, $00 ; id 28
    dw Data_041_4055
    db $60, $01 ; id 29
    dw Data_041_4269
    db $80, $02 ; id 30
    dw Data_041_4477
    db $40, $00 ; id 31
    dw Data_041_4677
    db $60, $01 ; id 32
    dw Data_041_47B1
    db $80, $02 ; id 33
    dw Data_041_48F9
    db $40, $00 ; id 34
    dw Data_041_4A63
    db $60, $01 ; id 35
    dw Data_041_4F1D
    db $80, $02 ; id 36
    dw Data_041_53B1
    db $40, $00 ; id 37
    dw Data_041_59F3
    db $60, $01 ; id 38
    dw Data_041_5E83
    db $80, $02 ; id 39
    dw Data_041_6009
    db $40, $00 ; id 40
    dw Data_041_633D
    db $60, $01 ; id 41
    dw Data_041_66A7
    db $80, $02 ; id 42
    dw Data_041_6A07
    db $40, $00 ; id 43
    dw Data_041_6E2D
    db $60, $01 ; id 44
    dw Data_041_7267
    db $80, $02 ; id 45
    dw Data_041_7645
    db $40, $00 ; id 46
    dw Data_041_788B
    db $60, $01 ; id 47
    dw Data_041_7C65
    db $80, $02 ; id 48
    dw Data_041_7E97

; sound track, 264 events after the header (E-0019: grammar C2, meaning C0)
Data_041_4055:: ; heuristic: track stream of a sound record; C0
    db $02, $02, $09, $00 ; header: param=2 byte1=$02 volume=$09 byte3=$00
    db $A3, $26 ; mod $26
    db $C1, $50 ; env $50
    db $1F, $07 ; rest-note $1F dur 7
    db $A2, $02 ; duty2 $02
    db $A0, $03 ; volume $03
    db $35, $07 ; note F3 dur 7
    db $FD, $F3 ; label 3
    db $C1, $50 ; env $50
    db $A2, $02 ; duty2 $02
    db $A0, $03 ; volume $03
    db $37, $07 ; note G3 dur 7
    db $1F, $07 ; rest-note $1F dur 7
    db $A2, $01 ; duty2 $01
    db $A0, $0B ; volume $0B
    db $22, $07 ; note D2 dur 7
    db $A0, $03 ; volume $03
    db $22, $07 ; note D2 dur 7
    db $A0, $09 ; volume $09
    db $22, $1C ; note D2 dur 28
    db $A0, $03 ; volume $03
    db $22, $0E ; note D2 dur 14
    db $A0, $0B ; volume $0B
    db $20, $07 ; note C2 dur 7
    db $A0, $03 ; volume $03
    db $20, $07 ; note C2 dur 7
    db $A0, $09 ; volume $09
    db $20, $1C ; note C2 dur 28
    db $A0, $03 ; volume $03
    db $20, $0E ; note C2 dur 14
    db $A0, $0B ; volume $0B
    db $1A, $07 ; note A#1 dur 7
    db $A0, $03 ; volume $03
    db $1A, $07 ; note A#1 dur 7
    db $A0, $09 ; volume $09
    db $1A, $0E ; note A#1 dur 14
    db $A0, $03 ; volume $03
    db $1A, $0E ; note A#1 dur 14
    db $C3, $48 ; env $48
    db $A0, $0E ; volume $0E
    db $25, $0E ; note F2 dur 14
    db $23, $0E ; note D#2 dur 14
    db $22, $0E ; note D2 dur 14
    db $20, $0E ; note C2 dur 14
    db $1A, $0E ; note A#1 dur 14
    db $20, $0E ; note C2 dur 14
    db $21, $0E ; note C#2 dur 14
    db $22, $0E ; note D2 dur 14
    db $A0, $0C ; volume $0C
    db $23, $1C ; note D#2 dur 28
    db $20, $1C ; note C2 dur 28
    db $A0, $0B ; volume $0B
    db $19, $07 ; note A1 dur 7
    db $C1, $70 ; env $70
    db $A0, $04 ; volume $04
    db $19, $07 ; note A1 dur 7
    db $A2, $01 ; duty2 $01
    db $C1, $10 ; env $10
    db $FD, $F0 ; label 0
    db $A0, $09 ; volume $09
    db $19, $02 ; note A1 dur 2
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $19, $04 ; note A1 dur 4
    db $B1, $F0 ; repeat $F0
    db $A0, $0A ; volume $0A
    db $1A, $04 ; note A#1 dur 4
    db $A0, $03 ; volume $03
    db $19, $03 ; note A1 dur 3
    db $1A, $07 ; note A#1 dur 7
    db $A0, $0A ; volume $0A
    db $1A, $02 ; note A#1 dur 2
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $1A, $04 ; note A#1 dur 4
    db $A0, $0B ; volume $0B
    db $1A, $02 ; note A#1 dur 2
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $1A, $04 ; note A#1 dur 4
    db $A0, $0C ; volume $0C
    db $1B, $04 ; note B1 dur 4
    db $A0, $03 ; volume $03
    db $1A, $03 ; note A#1 dur 3
    db $1B, $07 ; note B1 dur 7
    db $A0, $0B ; volume $0B
    db $1B, $02 ; note B1 dur 2
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $1B, $04 ; note B1 dur 4
    db $A0, $0A ; volume $0A
    db $1B, $02 ; note B1 dur 2
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $1B, $04 ; note B1 dur 4
    db $C1, $30 ; env $30
    db $A0, $0C ; volume $0C
    db $20, $07 ; note C2 dur 7
    db $A0, $03 ; volume $03
    db $1B, $07 ; note B1 dur 7
    db $A0, $05 ; volume $05
    db $20, $0E ; note C2 dur 14
    db $A2, $02 ; duty2 $02
    db $A0, $06 ; volume $06
    db $35, $07 ; note F3 dur 7
    db $1F, $07 ; rest-note $1F dur 7
    db $A2, $00 ; duty2 $00
    db $C1, $50 ; env $50
    db $A0, $0B ; volume $0B
    db $23, $07 ; note D#2 dur 7
    db $A0, $03 ; volume $03
    db $23, $07 ; note D#2 dur 7
    db $A0, $09 ; volume $09
    db $23, $1C ; note D#2 dur 28
    db $A0, $03 ; volume $03
    db $23, $07 ; note D#2 dur 7
    db $1F, $07 ; rest-note $1F dur 7
    db $A0, $0B ; volume $0B
    db $23, $07 ; note D#2 dur 7
    db $A0, $03 ; volume $03
    db $23, $07 ; note D#2 dur 7
    db $A0, $09 ; volume $09
    db $23, $1C ; note D#2 dur 28
    db $A0, $03 ; volume $03
    db $23, $07 ; note D#2 dur 7
    db $1F, $07 ; rest-note $1F dur 7
    db $A0, $0B ; volume $0B
    db $23, $07 ; note D#2 dur 7
    db $A0, $03 ; volume $03
    db $23, $07 ; note D#2 dur 7
    db $A0, $09 ; volume $09
    db $23, $15 ; note D#2 dur 21
    db $A0, $03 ; volume $03
    db $23, $07 ; note D#2 dur 7
    db $A2, $01 ; duty2 $01
    db $C3, $48 ; env $48
    db $A0, $0D ; volume $0D
    db $23, $0E ; note D#2 dur 14
    db $22, $0E ; note D2 dur 14
    db $A0, $0E ; volume $0E
    db $21, $0E ; note C#2 dur 14
    db $20, $0E ; note C2 dur 14
    db $C3, $58 ; env $58
    db $A0, $0E ; volume $0E
    db $19, $0E ; note A1 dur 14
    db $1A, $0E ; note A#1 dur 14
    db $20, $0E ; note C2 dur 14
    db $23, $0E ; note D#2 dur 14
    db $A0, $03 ; volume $03
    db $23, $0E ; note D#2 dur 14
    db $A2, $01 ; duty2 $01
    db $C1, $50 ; env $50
    db $A0, $08 ; volume $08
    db $23, $07 ; note D#2 dur 7
    db $A0, $03 ; volume $03
    db $23, $07 ; note D#2 dur 7
    db $A0, $08 ; volume $08
    db $23, $15 ; note D#2 dur 21
    db $A0, $03 ; volume $03
    db $23, $07 ; note D#2 dur 7
    db $C0, $FE ; env $FE
    db $A2, $02 ; duty2 $02
    db $A0, $08 ; volume $08
    db $22, $0C ; note D2 dur 12
    db $C1, $20 ; env $20
    db $A0, $03 ; volume $03
    db $22, $10 ; note D2 dur 16
    db $C0, $FE ; env $FE
    db $A0, $09 ; volume $09
    db $23, $0C ; note D#2 dur 12
    db $C1, $20 ; env $20
    db $A0, $03 ; volume $03
    db $22, $02 ; note D2 dur 2
    db $23, $0E ; note D#2 dur 14
    db $C0, $FE ; env $FE
    db $A0, $0A ; volume $0A
    db $24, $0C ; note E2 dur 12
    db $C1, $20 ; env $20
    db $A0, $03 ; volume $03
    db $23, $02 ; note D#2 dur 2
    db $24, $0E ; note E2 dur 14
    db $A2, $01 ; duty2 $01
    db $C3, $68 ; env $68
    db $A0, $0A ; volume $0A
    db $25, $0E ; note F2 dur 14
    db $28, $0E ; note G#2 dur 14
    db $C3, $48 ; env $48
    db $A0, $0B ; volume $0B
    db $FD, $F0 ; label 0
    db $27, $07 ; note G2 dur 7
    db $2A, $07 ; note A#2 dur 7
    db $B7, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $26, $07 ; note F#2 dur 7
    db $29, $07 ; note A2 dur 7
    db $26, $07 ; note F#2 dur 7
    db $29, $07 ; note A2 dur 7
    db $30, $07 ; note C3 dur 7
    db $29, $07 ; note A2 dur 7
    db $26, $07 ; note F#2 dur 7
    db $29, $07 ; note A2 dur 7
    db $B1, $F0 ; repeat $F0
    db $A0, $0C ; volume $0C
    db $FD, $F0 ; label 0
    db $22, $07 ; note D2 dur 7
    db $27, $07 ; note G2 dur 7
    db $2A, $07 ; note A#2 dur 7
    db $27, $07 ; note G2 dur 7
    db $B1, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $22, $07 ; note D2 dur 7
    db $26, $07 ; note F#2 dur 7
    db $2A, $07 ; note A#2 dur 7
    db $26, $07 ; note F#2 dur 7
    db $B1, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $22, $07 ; note D2 dur 7
    db $25, $07 ; note F2 dur 7
    db $2A, $07 ; note A#2 dur 7
    db $25, $07 ; note F2 dur 7
    db $B1, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $22, $07 ; note D2 dur 7
    db $27, $07 ; note G2 dur 7
    db $2A, $07 ; note A#2 dur 7
    db $27, $07 ; note G2 dur 7
    db $B1, $F0 ; repeat $F0
    db $A0, $0B ; volume $0B
    db $FD, $F0 ; label 0
    db $22, $07 ; note D2 dur 7
    db $27, $07 ; note G2 dur 7
    db $2A, $07 ; note A#2 dur 7
    db $27, $07 ; note G2 dur 7
    db $B1, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $23, $07 ; note D#2 dur 7
    db $27, $07 ; note G2 dur 7
    db $2A, $07 ; note A#2 dur 7
    db $27, $07 ; note G2 dur 7
    db $B1, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $20, $07 ; note C2 dur 7
    db $23, $07 ; note D#2 dur 7
    db $27, $07 ; note G2 dur 7
    db $23, $07 ; note D#2 dur 7
    db $B3, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $20, $07 ; note C2 dur 7
    db $26, $07 ; note F#2 dur 7
    db $2A, $07 ; note A#2 dur 7
    db $26, $07 ; note F#2 dur 7
    db $B3, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $20, $07 ; note C2 dur 7
    db $23, $07 ; note D#2 dur 7
    db $29, $07 ; note A2 dur 7
    db $23, $07 ; note D#2 dur 7
    db $B2, $F0 ; repeat $F0
    db $A0, $08 ; volume $08
    db $20, $0A ; note C2 dur 10
    db $C1, $20 ; env $20
    db $A0, $03 ; volume $03
    db $20, $12 ; note C2 dur 18
    db $B0, $F3 ; jump $F3
    db $FF, $FF ; end

; sound track, 261 events after the header (E-0019: grammar C2, meaning C0)
Data_041_4269:: ; heuristic: track stream of a sound record; C0
    db $02, $00, $09, $00 ; header: param=2 byte1=$00 volume=$09 byte3=$00
    db $FD, $F3 ; label 3
    db $A0, $0E ; volume $0E
    db $A3, $08 ; mod $08
    db $C3, $48 ; env $48
    db $A2, $02 ; duty2 $02
    db $35, $07 ; note F3 dur 7
    db $37, $07 ; note G3 dur 7
    db $A0, $0A ; volume $0A
    db $C0, $FE ; env $FE
    db $A3, $FE ; mod $FE
    db $42, $1C ; note D4 dur 28
    db $C1, $3F ; env $3F
    db $A3, $01 ; mod $01
    db $A0, $08 ; volume $08
    db $42, $0E ; note D4 dur 14
    db $A3, $08 ; mod $08
    db $C3, $48 ; env $48
    db $A0, $0E ; volume $0E
    db $35, $07 ; note F3 dur 7
    db $37, $07 ; note G3 dur 7
    db $A0, $0A ; volume $0A
    db $C0, $FE ; env $FE
    db $A3, $FE ; mod $FE
    db $40, $1C ; note C4 dur 28
    db $C1, $3F ; env $3F
    db $A3, $01 ; mod $01
    db $A0, $08 ; volume $08
    db $40, $0E ; note C4 dur 14
    db $A3, $08 ; mod $08
    db $C3, $48 ; env $48
    db $A0, $0E ; volume $0E
    db $35, $07 ; note F3 dur 7
    db $37, $07 ; note G3 dur 7
    db $A0, $0A ; volume $0A
    db $C0, $FE ; env $FE
    db $A3, $FE ; mod $FE
    db $3A, $1C ; note A#3 dur 28
    db $C1, $3F ; env $3F
    db $A3, $01 ; mod $01
    db $A0, $08 ; volume $08
    db $3A, $0E ; note A#3 dur 14
    db $A3, $08 ; mod $08
    db $C3, $48 ; env $48
    db $A0, $0E ; volume $0E
    db $39, $07 ; note A3 dur 7
    db $3A, $07 ; note A#3 dur 7
    db $39, $0E ; note A3 dur 14
    db $37, $0E ; note G3 dur 14
    db $35, $0E ; note F3 dur 14
    db $33, $0E ; note D#3 dur 14
    db $32, $0E ; note D3 dur 14
    db $33, $0E ; note D#3 dur 14
    db $A0, $0F ; volume $0F
    db $34, $0E ; note E3 dur 14
    db $35, $0E ; note F3 dur 14
    db $A0, $0D ; volume $0D
    db $C3, $68 ; env $68
    db $37, $2A ; note G3 dur 42
    db $A0, $0C ; volume $0C
    db $35, $07 ; note F3 dur 7
    db $33, $07 ; note D#3 dur 7
    db $A0, $0B ; volume $0B
    db $30, $07 ; note C3 dur 7
    db $C1, $70 ; env $70
    db $A0, $03 ; volume $03
    db $30, $07 ; note C3 dur 7
    db $A2, $01 ; duty2 $01
    db $C1, $10 ; env $10
    db $A0, $08 ; volume $08
    db $20, $02 ; note C2 dur 2
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $20, $04 ; note C2 dur 4
    db $A0, $09 ; volume $09
    db $20, $02 ; note C2 dur 2
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $20, $04 ; note C2 dur 4
    db $A0, $0A ; volume $0A
    db $21, $04 ; note C#2 dur 4
    db $A0, $03 ; volume $03
    db $20, $03 ; note C2 dur 3
    db $21, $07 ; note C#2 dur 7
    db $FD, $F0 ; label 0
    db $A0, $0B ; volume $0B
    db $21, $02 ; note C#2 dur 2
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $21, $04 ; note C#2 dur 4
    db $B1, $F0 ; repeat $F0
    db $A0, $0C ; volume $0C
    db $22, $04 ; note D2 dur 4
    db $A0, $03 ; volume $03
    db $21, $03 ; note C#2 dur 3
    db $22, $07 ; note D2 dur 7
    db $FD, $F0 ; label 0
    db $A0, $0A ; volume $0A
    db $22, $02 ; note D2 dur 2
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $22, $04 ; note D2 dur 4
    db $B1, $F0 ; repeat $F0
    db $A0, $09 ; volume $09
    db $23, $07 ; note D#2 dur 7
    db $A0, $03 ; volume $03
    db $23, $07 ; note D#2 dur 7
    db $A2, $02 ; duty2 $02
    db $C3, $48 ; env $48
    db $A0, $0E ; volume $0E
    db $33, $07 ; note D#3 dur 7
    db $35, $07 ; note F3 dur 7
    db $C3, $7F ; env $7F
    db $A3, $FE ; mod $FE
    db $40, $1C ; note C4 dur 28
    db $C1, $3F ; env $3F
    db $A3, $08 ; mod $08
    db $A0, $06 ; volume $06
    db $40, $0E ; note C4 dur 14
    db $C3, $48 ; env $48
    db $A0, $0E ; volume $0E
    db $33, $07 ; note D#3 dur 7
    db $35, $07 ; note F3 dur 7
    db $A3, $FE ; mod $FE
    db $3A, $1C ; note A#3 dur 28
    db $C1, $3F ; env $3F
    db $A3, $08 ; mod $08
    db $A3, $01 ; mod $01
    db $A0, $08 ; volume $08
    db $3A, $0E ; note A#3 dur 14
    db $A3, $08 ; mod $08
    db $C3, $48 ; env $48
    db $A0, $0E ; volume $0E
    db $33, $07 ; note D#3 dur 7
    db $35, $07 ; note F3 dur 7
    db $C3, $7F ; env $7F
    db $A3, $FE ; mod $FE
    db $39, $1C ; note A3 dur 28
    db $C1, $3F ; env $3F
    db $A3, $01 ; mod $01
    db $A0, $08 ; volume $08
    db $39, $0E ; note A3 dur 14
    db $A3, $08 ; mod $08
    db $C3, $48 ; env $48
    db $A0, $0E ; volume $0E
    db $37, $07 ; note G3 dur 7
    db $39, $07 ; note A3 dur 7
    db $37, $0E ; note G3 dur 14
    db $36, $0E ; note F#3 dur 14
    db $35, $0E ; note F3 dur 14
    db $33, $0E ; note D#3 dur 14
    db $30, $0E ; note C3 dur 14
    db $32, $0E ; note D3 dur 14
    db $33, $0E ; note D#3 dur 14
    db $37, $0E ; note G3 dur 14
    db $35, $23 ; note F3 dur 35
    db $33, $07 ; note D#3 dur 7
    db $32, $07 ; note D3 dur 7
    db $30, $07 ; note C3 dur 7
    db $C0, $FE ; env $FE
    db $A0, $09 ; volume $09
    db $2A, $0C ; note A#2 dur 12
    db $C1, $30 ; env $30
    db $A0, $03 ; volume $03
    db $2A, $10 ; note A#2 dur 16
    db $C0, $FE ; env $FE
    db $A0, $0A ; volume $0A
    db $30, $0C ; note C3 dur 12
    db $C1, $30 ; env $30
    db $A0, $03 ; volume $03
    db $2A, $02 ; note A#2 dur 2
    db $30, $0E ; note C3 dur 14
    db $C0, $FE ; env $FE
    db $A0, $0B ; volume $0B
    db $31, $0C ; note C#3 dur 12
    db $C1, $30 ; env $30
    db $A0, $03 ; volume $03
    db $30, $02 ; note C3 dur 2
    db $31, $0E ; note C#3 dur 14
    db $C0, $FE ; env $FE
    db $A0, $0C ; volume $0C
    db $32, $0C ; note D3 dur 12
    db $C1, $30 ; env $30
    db $A0, $03 ; volume $03
    db $31, $02 ; note C#3 dur 2
    db $32, $0E ; note D3 dur 14
    db $A2, $00 ; duty2 $00
    db $C3, $78 ; env $78
    db $A3, $0A ; mod $0A
    db $A0, $0F ; volume $0F
    db $37, $46 ; note G3 dur 70
    db $C3, $68 ; env $68
    db $33, $0E ; note D#3 dur 14
    db $37, $0E ; note G3 dur 14
    db $3A, $0E ; note A#3 dur 14
    db $A3, $FE ; mod $FE
    db $39, $1C ; note A3 dur 28
    db $42, $1C ; note D4 dur 28
    db $40, $1C ; note C4 dur 28
    db $39, $15 ; note A3 dur 21
    db $C1, $7F ; env $7F
    db $A0, $08 ; volume $08
    db $39, $07 ; note A3 dur 7
    db $A3, $0A ; mod $0A
    db $C4, $58 ; env $58
    db $A0, $0F ; volume $0F
    db $37, $07 ; note G3 dur 7
    db $39, $07 ; note A3 dur 7
    db $C3, $48 ; env $48
    db $3A, $07 ; note A#3 dur 7
    db $A0, $05 ; volume $05
    db $39, $07 ; note A3 dur 7
    db $3A, $0E ; note A#3 dur 14
    db $A0, $0F ; volume $0F
    db $37, $0E ; note G3 dur 14
    db $C3, $78 ; env $78
    db $A3, $FE ; mod $FE
    db $42, $2A ; note D4 dur 42
    db $A3, $0A ; mod $0A
    db $C1, $7F ; env $7F
    db $A0, $08 ; volume $08
    db $42, $0E ; note D4 dur 14
    db $C4, $68 ; env $68
    db $A0, $0F ; volume $0F
    db $37, $07 ; note G3 dur 7
    db $39, $07 ; note A3 dur 7
    db $C4, $48 ; env $48
    db $3A, $07 ; note A#3 dur 7
    db $C1, $7F ; env $7F
    db $A0, $07 ; volume $07
    db $39, $07 ; note A3 dur 7
    db $3A, $0E ; note A#3 dur 14
    db $C3, $38 ; env $38
    db $A0, $0F ; volume $0F
    db $37, $0E ; note G3 dur 14
    db $C3, $78 ; env $78
    db $A3, $FE ; mod $FE
    db $47, $2A ; note G4 dur 42
    db $C1, $7F ; env $7F
    db $A0, $08 ; volume $08
    db $47, $2A ; note G4 dur 42
    db $A3, $0A ; mod $0A
    db $A2, $00 ; duty2 $00
    db $C3, $78 ; env $78
    db $A0, $0F ; volume $0F
    db $27, $1C ; note G2 dur 28
    db $29, $1C ; note A2 dur 28
    db $2A, $1C ; note A#2 dur 28
    db $32, $1C ; note D3 dur 28
    db $30, $1C ; note C3 dur 28
    db $27, $1C ; note G2 dur 28
    db $29, $1C ; note A2 dur 28
    db $C0, $FE ; env $FE
    db $A0, $0C ; volume $0C
    db $A3, $00 ; mod $00
    db $2A, $70 ; note A#2 dur 112
    db $29, $46 ; note A2 dur 70
    db $C1, $7F ; env $7F
    db $A0, $08 ; volume $08
    db $29, $1C ; note A2 dur 28
    db $B0, $F3 ; jump $F3
    db $FF, $FF ; end

; sound track, 254 events after the header (E-0019: grammar C2, meaning C0)
Data_041_4477:: ; heuristic: track stream of a sound record; C0
    db $02, $70, $02, $08 ; header: param=2 byte1=$70 volume=$02 byte3=$08
    db $1F, $0E ; rest-note $1F dur 14
    db $FD, $F3 ; label 3
    db $A1, $08 ; duty $08
    db $A2, $70 ; duty2 $70
    db $A0, $02 ; volume $02
    db $1A, $0E ; note A#1 dur 14
    db $25, $0E ; note F2 dur 14
    db $2A, $15 ; note A#2 dur 21
    db $A0, $04 ; volume $04
    db $2A, $07 ; note A#2 dur 7
    db $A0, $02 ; volume $02
    db $19, $0E ; note A1 dur 14
    db $25, $0E ; note F2 dur 14
    db $29, $15 ; note A2 dur 21
    db $A0, $04 ; volume $04
    db $29, $07 ; note A2 dur 7
    db $A0, $02 ; volume $02
    db $17, $0E ; note G1 dur 14
    db $22, $0E ; note D2 dur 14
    db $27, $15 ; note G2 dur 21
    db $A0, $04 ; volume $04
    db $27, $07 ; note G2 dur 7
    db $A0, $02 ; volume $02
    db $15, $0E ; note F1 dur 14
    db $25, $0E ; note F2 dur 14
    db $29, $15 ; note A2 dur 21
    db $A0, $04 ; volume $04
    db $29, $0E ; note A2 dur 14
    db $A1, $02 ; duty $02
    db $A0, $06 ; volume $06
    db $42, $0E ; note D4 dur 14
    db $43, $07 ; note D#4 dur 7
    db $A2, $40 ; duty2 $40
    db $A1, $0B ; duty $0B
    db $A0, $02 ; volume $02
    db $1A, $15 ; note A#1 dur 21
    db $A0, $04 ; volume $04
    db $1A, $07 ; note A#1 dur 7
    db $A0, $02 ; volume $02
    db $1A, $15 ; note A#1 dur 21
    db $A0, $04 ; volume $04
    db $1A, $07 ; note A#1 dur 7
    db $A0, $02 ; volume $02
    db $1A, $15 ; note A#1 dur 21
    db $A0, $04 ; volume $04
    db $1A, $07 ; note A#1 dur 7
    db $A1, $0A ; duty $0A
    db $A2, $FF ; duty2 $FF
    db $A0, $02 ; volume $02
    db $15, $07 ; note F1 dur 7
    db $A0, $04 ; volume $04
    db $15, $07 ; note F1 dur 7
    db $A1, $08 ; duty $08
    db $A2, $10 ; duty2 $10
    db $A0, $02 ; volume $02
    db $25, $03 ; note F2 dur 3
    db $A0, $04 ; volume $04
    db $25, $04 ; note F2 dur 4
    db $A0, $02 ; volume $02
    db $25, $03 ; note F2 dur 3
    db $A0, $04 ; volume $04
    db $25, $04 ; note F2 dur 4
    db $A0, $02 ; volume $02
    db $25, $07 ; note F2 dur 7
    db $A0, $04 ; volume $04
    db $25, $07 ; note F2 dur 7
    db $A0, $02 ; volume $02
    db $25, $03 ; note F2 dur 3
    db $A0, $04 ; volume $04
    db $25, $04 ; note F2 dur 4
    db $A0, $02 ; volume $02
    db $25, $03 ; note F2 dur 3
    db $A0, $04 ; volume $04
    db $25, $04 ; note F2 dur 4
    db $A0, $02 ; volume $02
    db $25, $07 ; note F2 dur 7
    db $A0, $04 ; volume $04
    db $25, $07 ; note F2 dur 7
    db $A0, $02 ; volume $02
    db $25, $03 ; note F2 dur 3
    db $A0, $04 ; volume $04
    db $25, $04 ; note F2 dur 4
    db $A0, $02 ; volume $02
    db $25, $03 ; note F2 dur 3
    db $A0, $04 ; volume $04
    db $25, $04 ; note F2 dur 4
    db $A0, $02 ; volume $02
    db $25, $07 ; note F2 dur 7
    db $A0, $04 ; volume $04
    db $25, $15 ; note F2 dur 21
    db $A1, $08 ; duty $08
    db $A2, $70 ; duty2 $70
    db $A0, $02 ; volume $02
    db $20, $0E ; note C2 dur 14
    db $27, $0E ; note G2 dur 14
    db $30, $15 ; note C3 dur 21
    db $A0, $04 ; volume $04
    db $30, $07 ; note C3 dur 7
    db $A0, $02 ; volume $02
    db $20, $0E ; note C2 dur 14
    db $27, $0E ; note G2 dur 14
    db $30, $15 ; note C3 dur 21
    db $A0, $04 ; volume $04
    db $30, $07 ; note C3 dur 7
    db $A0, $02 ; volume $02
    db $15, $0E ; note F1 dur 14
    db $20, $0E ; note C2 dur 14
    db $25, $15 ; note F2 dur 21
    db $A0, $04 ; volume $04
    db $25, $07 ; note F2 dur 7
    db $A0, $02 ; volume $02
    db $15, $0E ; note F1 dur 14
    db $20, $0E ; note C2 dur 14
    db $29, $15 ; note A2 dur 21
    db $A0, $04 ; volume $04
    db $29, $07 ; note A2 dur 7
    db $A0, $02 ; volume $02
    db $20, $0E ; note C2 dur 14
    db $27, $0E ; note G2 dur 14
    db $2A, $15 ; note A#2 dur 21
    db $A0, $04 ; volume $04
    db $2A, $07 ; note A#2 dur 7
    db $A0, $02 ; volume $02
    db $15, $0E ; note F1 dur 14
    db $20, $0E ; note C2 dur 14
    db $29, $15 ; note A2 dur 21
    db $A0, $04 ; volume $04
    db $29, $07 ; note A2 dur 7
    db $A2, $18 ; duty2 $18
    db $A1, $0B ; duty $0B
    db $FD, $F0 ; label 0
    db $A0, $02 ; volume $02
    db $1A, $07 ; note A#1 dur 7
    db $A0, $04 ; volume $04
    db $1A, $07 ; note A#1 dur 7
    db $A0, $02 ; volume $02
    db $15, $07 ; note F1 dur 7
    db $A0, $04 ; volume $04
    db $15, $07 ; note F1 dur 7
    db $B3, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $A0, $02 ; volume $02
    db $13, $07 ; note D#1 dur 7
    db $A0, $04 ; volume $04
    db $13, $07 ; note D#1 dur 7
    db $A0, $02 ; volume $02
    db $1A, $07 ; note A#1 dur 7
    db $A0, $04 ; volume $04
    db $1A, $07 ; note A#1 dur 7
    db $B3, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $A0, $02 ; volume $02
    db $12, $07 ; note D1 dur 7
    db $A0, $04 ; volume $04
    db $12, $07 ; note D1 dur 7
    db $A0, $02 ; volume $02
    db $19, $07 ; note A1 dur 7
    db $A0, $04 ; volume $04
    db $19, $07 ; note A1 dur 7
    db $B3, $F0 ; repeat $F0
    db $A2, $60 ; duty2 $60
    db $A1, $0A ; duty $0A
    db $A0, $02 ; volume $02
    db $17, $0E ; note G1 dur 14
    db $A1, $03 ; duty $03
    db $27, $0E ; note G2 dur 14
    db $A0, $04 ; volume $04
    db $27, $0E ; note G2 dur 14
    db $A0, $02 ; volume $02
    db $27, $0E ; note G2 dur 14
    db $A1, $0A ; duty $0A
    db $16, $0E ; note F#1 dur 14
    db $A1, $03 ; duty $03
    db $26, $0E ; note F#2 dur 14
    db $A0, $04 ; volume $04
    db $26, $0E ; note F#2 dur 14
    db $A0, $02 ; volume $02
    db $26, $0E ; note F#2 dur 14
    db $A1, $0A ; duty $0A
    db $15, $0E ; note F1 dur 14
    db $A1, $03 ; duty $03
    db $25, $0E ; note F2 dur 14
    db $A0, $04 ; volume $04
    db $25, $0E ; note F2 dur 14
    db $A0, $02 ; volume $02
    db $25, $0E ; note F2 dur 14
    db $A1, $0A ; duty $0A
    db $14, $0E ; note E1 dur 14
    db $A1, $03 ; duty $03
    db $24, $0E ; note E2 dur 14
    db $A0, $04 ; volume $04
    db $24, $0E ; note E2 dur 14
    db $A0, $02 ; volume $02
    db $24, $0E ; note E2 dur 14
    db $A1, $0B ; duty $0B
    db $13, $0E ; note D#1 dur 14
    db $A1, $03 ; duty $03
    db $23, $0E ; note D#2 dur 14
    db $A0, $04 ; volume $04
    db $23, $0E ; note D#2 dur 14
    db $A0, $02 ; volume $02
    db $23, $0E ; note D#2 dur 14
    db $A1, $0B ; duty $0B
    db $10, $0E ; note C1 dur 14
    db $A1, $03 ; duty $03
    db $20, $0E ; note C2 dur 14
    db $A0, $04 ; volume $04
    db $20, $0E ; note C2 dur 14
    db $A0, $02 ; volume $02
    db $20, $0E ; note C2 dur 14
    db $A1, $0B ; duty $0B
    db $FD, $F0 ; label 0
    db $19, $0C ; note A1 dur 12
    db $A0, $04 ; volume $04
    db $19, $02 ; note A1 dur 2
    db $A0, $02 ; volume $02
    db $19, $0E ; note A1 dur 14
    db $A0, $04 ; volume $04
    db $19, $0E ; note A1 dur 14
    db $A0, $02 ; volume $02
    db $19, $0C ; note A1 dur 12
    db $A0, $04 ; volume $04
    db $19, $02 ; note A1 dur 2
    db $A0, $02 ; volume $02
    db $B1, $F0 ; repeat $F0
    db $12, $0E ; note D1 dur 14
    db $22, $0E ; note D2 dur 14
    db $A0, $04 ; volume $04
    db $22, $0E ; note D2 dur 14
    db $A0, $02 ; volume $02
    db $22, $0E ; note D2 dur 14
    db $12, $0E ; note D1 dur 14
    db $22, $0E ; note D2 dur 14
    db $A0, $04 ; volume $04
    db $22, $0E ; note D2 dur 14
    db $A0, $02 ; volume $02
    db $22, $0E ; note D2 dur 14
    db $15, $0E ; note F1 dur 14
    db $25, $0E ; note F2 dur 14
    db $A0, $04 ; volume $04
    db $25, $0E ; note F2 dur 14
    db $A0, $02 ; volume $02
    db $25, $0E ; note F2 dur 14
    db $15, $0E ; note F1 dur 14
    db $A2, $40 ; duty2 $40
    db $25, $0A ; note F2 dur 10
    db $A0, $04 ; volume $04
    db $25, $04 ; note F2 dur 4
    db $A0, $02 ; volume $02
    db $25, $0C ; note F2 dur 12
    db $A0, $04 ; volume $04
    db $25, $10 ; note F2 dur 16
    db $B0, $F3 ; jump $F3
    db $FF, $FF ; end

; sound track, 155 events after the header (E-0019: grammar C2, meaning C0)
Data_041_4677:: ; heuristic: track stream of a sound record; C0
    db $07, $00, $09, $00 ; header: param=7 byte1=$00 volume=$09 byte3=$00
    db $FD, $F3 ; label 3
    db $AF, $07 ; param $07
    db $A3, $08 ; mod $08
    db $C3, $7F ; env $7F
    db $A0, $0A ; volume $0A
    db $26, $5E ; note F#2 dur 94
    db $C1, $7F ; env $7F
    db $A0, $04 ; volume $04
    db $26, $02 ; note F#2 dur 2
    db $C3, $7F ; env $7F
    db $A0, $0A ; volume $0A
    db $27, $40 ; note G2 dur 64
    db $28, $1E ; note G#2 dur 30
    db $C1, $7F ; env $7F
    db $A0, $04 ; volume $04
    db $28, $02 ; note G#2 dur 2
    db $C3, $7F ; env $7F
    db $A0, $0A ; volume $0A
    db $30, $40 ; note C3 dur 64
    db $2A, $20 ; note A#2 dur 32
    db $C3, $7F ; env $7F
    db $29, $20 ; note A2 dur 32
    db $28, $38 ; note G#2 dur 56
    db $C1, $7F ; env $7F
    db $A0, $04 ; volume $04
    db $28, $08 ; note G#2 dur 8
    db $C3, $7F ; env $7F
    db $A0, $0A ; volume $0A
    db $27, $5C ; note G2 dur 92
    db $C1, $7F ; env $7F
    db $A0, $06 ; volume $06
    db $27, $04 ; note G2 dur 4
    db $C3, $7F ; env $7F
    db $A0, $0A ; volume $0A
    db $26, $58 ; note F#2 dur 88
    db $C1, $7F ; env $7F
    db $A0, $04 ; volume $04
    db $26, $08 ; note F#2 dur 8
    db $C3, $7F ; env $7F
    db $A0, $0A ; volume $0A
    db $25, $5C ; note F2 dur 92
    db $C1, $7F ; env $7F
    db $A0, $04 ; volume $04
    db $25, $04 ; note F2 dur 4
    db $C3, $7F ; env $7F
    db $A0, $0A ; volume $0A
    db $24, $18 ; note E2 dur 24
    db $A0, $04 ; volume $04
    db $24, $08 ; note E2 dur 8
    db $A0, $0A ; volume $0A
    db $23, $18 ; note D#2 dur 24
    db $A0, $04 ; volume $04
    db $23, $08 ; note D#2 dur 8
    db $A0, $0A ; volume $0A
    db $22, $18 ; note D2 dur 24
    db $A0, $04 ; volume $04
    db $22, $08 ; note D2 dur 8
    db $A0, $0A ; volume $0A
    db $1B, $A7 ; note B1 dur 167
    db $A3, $00 ; mod $00
    db $C1, $7F ; env $7F
    db $A0, $05 ; volume $05
    db $1B, $37 ; note B1 dur 55
    db $A3, $08 ; mod $08
    db $C3, $7F ; env $7F
    db $A0, $09 ; volume $09
    db $30, $5C ; note C3 dur 92
    db $C1, $7F ; env $7F
    db $A0, $04 ; volume $04
    db $30, $04 ; note C3 dur 4
    db $C3, $7F ; env $7F
    db $A0, $09 ; volume $09
    db $2A, $5C ; note A#2 dur 92
    db $C1, $7F ; env $7F
    db $A0, $05 ; volume $05
    db $2A, $04 ; note A#2 dur 4
    db $C3, $7F ; env $7F
    db $A0, $09 ; volume $09
    db $2A, $5C ; note A#2 dur 92
    db $C1, $7F ; env $7F
    db $A0, $04 ; volume $04
    db $2A, $04 ; note A#2 dur 4
    db $C3, $7F ; env $7F
    db $A0, $09 ; volume $09
    db $2B, $40 ; note B2 dur 64
    db $A3, $00 ; mod $00
    db $C1, $7F ; env $7F
    db $A0, $04 ; volume $04
    db $2B, $20 ; note B2 dur 32
    db $A3, $08 ; mod $08
    db $C3, $7F ; env $7F
    db $A0, $0B ; volume $0B
    db $24, $5C ; note E2 dur 92
    db $C1, $7F ; env $7F
    db $A0, $04 ; volume $04
    db $24, $04 ; note E2 dur 4
    db $C3, $7F ; env $7F
    db $A0, $0B ; volume $0B
    db $22, $40 ; note D2 dur 64
    db $C1, $7F ; env $7F
    db $A3, $00 ; mod $00
    db $A0, $04 ; volume $04
    db $22, $20 ; note D2 dur 32
    db $A3, $FE ; mod $FE
    db $C0, $FE ; env $FE
    db $A0, $07 ; volume $07
    db $36, $20 ; note F#3 dur 32
    db $34, $22 ; note E3 dur 34
    db $33, $24 ; note D#3 dur 36
    db $31, $25 ; note C#3 dur 37
    db $30, $26 ; note C3 dur 38
    db $2A, $20 ; note A#2 dur 32
    db $C1, $7F ; env $7F
    db $A0, $04 ; volume $04
    db $2A, $08 ; note A#2 dur 8
    db $AF, $01 ; param $01
    db $C1, $7F ; env $7F
    db $A0, $03 ; volume $03
    db $2A, $37 ; note A#2 dur 55
    db $A0, $01 ; volume $01
    db $33, $6E ; note D#3 dur 110
    db $A3, $03 ; mod $03
    db $C3, $78 ; env $78
    db $A0, $08 ; volume $08
    db $32, $A2 ; note D3 dur 162
    db $A0, $0B ; volume $0B
    db $31, $94 ; note C#3 dur 148
    db $30, $89 ; note C3 dur 137
    db $C1, $7F ; env $7F
    db $A0, $07 ; volume $07
    db $30, $0B ; note C3 dur 11
    db $C3, $7F ; env $7F
    db $A0, $0B ; volume $0B
    db $2B, $19 ; note B2 dur 25
    db $31, $1B ; note C#3 dur 27
    db $2B, $1A ; note B2 dur 26
    db $31, $1B ; note C#3 dur 27
    db $2B, $1A ; note B2 dur 26
    db $31, $1B ; note C#3 dur 27
    db $2A, $1C ; note A#2 dur 28
    db $30, $1C ; note C3 dur 28
    db $2A, $1C ; note A#2 dur 28
    db $30, $1C ; note C3 dur 28
    db $2A, $1C ; note A#2 dur 28
    db $30, $1C ; note C3 dur 28
    db $A0, $0A ; volume $0A
    db $C3, $75 ; env $75
    db $31, $A0 ; note C#3 dur 160
    db $A3, $00 ; mod $00
    db $C1, $7F ; env $7F
    db $A0, $05 ; volume $05
    db $31, $BA ; note C#3 dur 186
    db $1F, $0C ; rest-note $1F dur 12
    db $B0, $F3 ; jump $F3
    db $FF, $FF ; end

; sound track, 162 events after the header (E-0019: grammar C2, meaning C0)
Data_041_47B1:: ; heuristic: track stream of a sound record; C0
    db $07, $01, $09, $00 ; header: param=7 byte1=$01 volume=$09 byte3=$00
    db $FD, $F3 ; label 3
    db $AF, $07 ; param $07
    db $A3, $0A ; mod $0A
    db $C3, $7F ; env $7F
    db $A0, $0C ; volume $0C
    db $32, $20 ; note D3 dur 32
    db $30, $30 ; note C3 dur 48
    db $C5, $78 ; env $78
    db $A0, $08 ; volume $08
    db $2B, $10 ; note B2 dur 16
    db $C3, $7F ; env $7F
    db $A0, $0C ; volume $0C
    db $32, $10 ; note D3 dur 16
    db $30, $10 ; note C3 dur 16
    db $2B, $10 ; note B2 dur 16
    db $30, $10 ; note C3 dur 16
    db $34, $10 ; note E3 dur 16
    db $C5, $70 ; env $70
    db $A0, $08 ; volume $08
    db $32, $10 ; note D3 dur 16
    db $C3, $7F ; env $7F
    db $A0, $0C ; volume $0C
    db $37, $10 ; note G3 dur 16
    db $35, $0B ; note F3 dur 11
    db $A0, $06 ; volume $06
    db $35, $05 ; note F3 dur 5
    db $A0, $0C ; volume $0C
    db $35, $10 ; note F3 dur 16
    db $34, $0B ; note E3 dur 11
    db $A0, $06 ; volume $06
    db $34, $05 ; note E3 dur 5
    db $A0, $0C ; volume $0C
    db $34, $10 ; note E3 dur 16
    db $32, $0A ; note D3 dur 10
    db $A0, $06 ; volume $06
    db $32, $06 ; note D3 dur 6
    db $C0, $FE ; env $FE
    db $A0, $08 ; volume $08
    db $34, $40 ; note E3 dur 64
    db $C0, $FE ; env $FE
    db $A0, $08 ; volume $08
    db $32, $18 ; note D3 dur 24
    db $C1, $6F ; env $6F
    db $A3, $00 ; mod $00
    db $A0, $06 ; volume $06
    db $32, $08 ; note D3 dur 8
    db $C3, $7F ; env $7F
    db $A3, $0A ; mod $0A
    db $A0, $0C ; volume $0C
    db $32, $10 ; note D3 dur 16
    db $30, $10 ; note C3 dur 16
    db $2B, $10 ; note B2 dur 16
    db $30, $10 ; note C3 dur 16
    db $32, $10 ; note D3 dur 16
    db $A0, $0A ; volume $0A
    db $30, $10 ; note C3 dur 16
    db $A0, $0C ; volume $0C
    db $32, $10 ; note D3 dur 16
    db $30, $10 ; note C3 dur 16
    db $2B, $10 ; note B2 dur 16
    db $30, $10 ; note C3 dur 16
    db $32, $10 ; note D3 dur 16
    db $A0, $0A ; volume $0A
    db $30, $10 ; note C3 dur 16
    db $A0, $0C ; volume $0C
    db $2B, $10 ; note B2 dur 16
    db $29, $10 ; note A2 dur 16
    db $28, $10 ; note G#2 dur 16
    db $29, $10 ; note A2 dur 16
    db $2B, $10 ; note B2 dur 16
    db $A0, $0A ; volume $0A
    db $29, $10 ; note A2 dur 16
    db $A0, $0C ; volume $0C
    db $2B, $10 ; note B2 dur 16
    db $29, $0B ; note A2 dur 11
    db $A0, $06 ; volume $06
    db $29, $05 ; note A2 dur 5
    db $A0, $0C ; volume $0C
    db $29, $10 ; note A2 dur 16
    db $27, $0B ; note G2 dur 11
    db $A0, $06 ; volume $06
    db $27, $05 ; note G2 dur 5
    db $C3, $58 ; env $58
    db $A0, $0C ; volume $0C
    db $27, $10 ; note G2 dur 16
    db $25, $10 ; note F2 dur 16
    db $A0, $08 ; volume $08
    db $C0, $FE ; env $FE
    db $A3, $00 ; mod $00
    db $24, $A7 ; note E2 dur 167
    db $C1, $7F ; env $7F
    db $A3, $00 ; mod $00
    db $A0, $04 ; volume $04
    db $24, $37 ; note E2 dur 55
    db $A3, $0B ; mod $0B
    db $C3, $7F ; env $7F
    db $A0, $0C ; volume $0C
    db $34, $20 ; note E3 dur 32
    db $3A, $20 ; note A#3 dur 32
    db $38, $20 ; note G#3 dur 32
    db $A3, $FE ; mod $FE
    db $42, $50 ; note D4 dur 80
    db $C1, $7F ; env $7F
    db $A0, $09 ; volume $09
    db $42, $10 ; note D4 dur 16
    db $C3, $7F ; env $7F
    db $A3, $0B ; mod $0B
    db $A0, $0C ; volume $0C
    db $31, $60 ; note C#3 dur 96
    db $C3, $7F ; env $7F
    db $A0, $0C ; volume $0C
    db $32, $50 ; note D3 dur 80
    db $A3, $00 ; mod $00
    db $C1, $7F ; env $7F
    db $A0, $08 ; volume $08
    db $32, $10 ; note D3 dur 16
    db $A3, $0D ; mod $0D
    db $C3, $7F ; env $7F
    db $A0, $0C ; volume $0C
    db $2A, $20 ; note A#2 dur 32
    db $34, $20 ; note E3 dur 32
    db $32, $20 ; note D3 dur 32
    db $A3, $FE ; mod $FE
    db $C0, $FE ; env $FE
    db $A0, $0A ; volume $0A
    db $38, $50 ; note G#3 dur 80
    db $C1, $7F ; env $7F
    db $A0, $08 ; volume $08
    db $38, $10 ; note G#3 dur 16
    db $C0, $FE ; env $FE
    db $A3, $FE ; mod $FE
    db $A0, $0A ; volume $0A
    db $39, $20 ; note A3 dur 32
    db $37, $22 ; note G3 dur 34
    db $36, $24 ; note F#3 dur 36
    db $34, $25 ; note E3 dur 37
    db $33, $26 ; note D#3 dur 38
    db $C0, $FE ; env $FE
    db $A0, $08 ; volume $08
    db $31, $20 ; note C#3 dur 32
    db $C1, $7F ; env $7F
    db $A0, $06 ; volume $06
    db $31, $08 ; note C#3 dur 8
    db $AF, $01 ; param $01
    db $A0, $08 ; volume $08
    db $C0, $FE ; env $FE
    db $A3, $05 ; mod $05
    db $33, $A5 ; note D#3 dur 165
    db $34, $A2 ; note E3 dur 162
    db $35, $94 ; note F3 dur 148
    db $36, $94 ; note F#3 dur 148
    db $37, $9E ; note G3 dur 158
    db $38, $A7 ; note G#3 dur 167
    db $A3, $00 ; mod $00
    db $39, $A0 ; note A3 dur 160
    db $A3, $00 ; mod $00
    db $C1, $7F ; env $7F
    db $A0, $05 ; volume $05
    db $39, $BA ; note A3 dur 186
    db $1F, $0D ; rest-note $1F dur 13
    db $B0, $F3 ; jump $F3
    db $FF, $FF ; end

; sound track, 179 events after the header (E-0019: grammar C2, meaning C0)
Data_041_48F9:: ; heuristic: track stream of a sound record; C0
    db $07, $FF, $02, $0F ; header: param=7 byte1=$FF volume=$02 byte3=$0F
    db $FD, $F3 ; label 3
    db $AF, $07 ; param $07
    db $A3, $0C ; mod $0C
    db $A0, $02 ; volume $02
    db $33, $5E ; note D#3 dur 94
    db $A0, $04 ; volume $04
    db $33, $02 ; note D#3 dur 2
    db $A0, $02 ; volume $02
    db $34, $40 ; note E3 dur 64
    db $35, $1E ; note F3 dur 30
    db $A0, $04 ; volume $04
    db $35, $02 ; note F3 dur 2
    db $A0, $02 ; volume $02
    db $38, $40 ; note G#3 dur 64
    db $37, $20 ; note G3 dur 32
    db $36, $20 ; note F#3 dur 32
    db $A0, $02 ; volume $02
    db $35, $30 ; note F3 dur 48
    db $A0, $04 ; volume $04
    db $35, $10 ; note F3 dur 16
    db $A0, $02 ; volume $02
    db $34, $50 ; note E3 dur 80
    db $A0, $04 ; volume $04
    db $34, $10 ; note E3 dur 16
    db $A0, $02 ; volume $02
    db $33, $50 ; note D#3 dur 80
    db $A0, $04 ; volume $04
    db $33, $10 ; note D#3 dur 16
    db $A0, $02 ; volume $02
    db $32, $50 ; note D3 dur 80
    db $A0, $04 ; volume $04
    db $32, $10 ; note D3 dur 16
    db $A0, $02 ; volume $02
    db $31, $18 ; note C#3 dur 24
    db $A0, $04 ; volume $04
    db $31, $08 ; note C#3 dur 8
    db $A0, $02 ; volume $02
    db $30, $18 ; note C3 dur 24
    db $A0, $04 ; volume $04
    db $30, $08 ; note C3 dur 8
    db $A0, $02 ; volume $02
    db $2B, $18 ; note B2 dur 24
    db $A0, $04 ; volume $04
    db $2B, $08 ; note B2 dur 8
    db $A0, $02 ; volume $02
    db $29, $22 ; note A2 dur 34
    db $26, $24 ; note F#2 dur 36
    db $27, $25 ; note G2 dur 37
    db $A0, $02 ; volume $02
    db $28, $46 ; note G#2 dur 70
    db $A0, $04 ; volume $04
    db $28, $16 ; note G#2 dur 22
    db $A2, $20 ; duty2 $20
    db $A0, $06 ; volume $06
    db $28, $17 ; note G#2 dur 23
    db $A2, $FF ; duty2 $FF
    db $A0, $02 ; volume $02
    db $36, $50 ; note F#3 dur 80
    db $A0, $04 ; volume $04
    db $36, $10 ; note F#3 dur 16
    db $A0, $02 ; volume $02
    db $34, $20 ; note E3 dur 32
    db $36, $20 ; note F#3 dur 32
    db $A0, $02 ; volume $02
    db $37, $18 ; note G3 dur 24
    db $A0, $04 ; volume $04
    db $37, $08 ; note G3 dur 8
    db $A0, $02 ; volume $02
    db $38, $20 ; note G#3 dur 32
    db $36, $20 ; note F#3 dur 32
    db $35, $20 ; note F3 dur 32
    db $36, $20 ; note F#3 dur 32
    db $38, $20 ; note G#3 dur 32
    db $A0, $02 ; volume $02
    db $39, $18 ; note A3 dur 24
    db $A0, $04 ; volume $04
    db $39, $08 ; note A3 dur 8
    db $A0, $02 ; volume $02
    db $30, $50 ; note C3 dur 80
    db $A0, $04 ; volume $04
    db $30, $10 ; note C3 dur 16
    db $A0, $02 ; volume $02
    db $2A, $20 ; note A#2 dur 32
    db $30, $20 ; note C3 dur 32
    db $A0, $02 ; volume $02
    db $32, $1C ; note D3 dur 28
    db $A0, $04 ; volume $04
    db $32, $04 ; note D3 dur 4
    db $A0, $02 ; volume $02
    db $33, $20 ; note D#3 dur 32
    db $34, $22 ; note E3 dur 34
    db $36, $24 ; note F#3 dur 36
    db $37, $25 ; note G3 dur 37
    db $38, $46 ; note G#3 dur 70
    db $A0, $04 ; volume $04
    db $38, $08 ; note G#3 dur 8
    db $AF, $01 ; param $01
    db $FD, $F0 ; label 0
    db $A0, $02 ; volume $02
    db $39, $1C ; note A3 dur 28
    db $A0, $04 ; volume $04
    db $39, $1B ; note A3 dur 27
    db $B2, $F0 ; repeat $F0
    db $A0, $02 ; volume $02
    db $39, $1C ; note A3 dur 28
    db $A0, $04 ; volume $04
    db $39, $1B ; note A3 dur 27
    db $A0, $02 ; volume $02
    db $39, $1C ; note A3 dur 28
    db $A0, $04 ; volume $04
    db $39, $1A ; note A3 dur 26
    db $A0, $02 ; volume $02
    db $39, $1C ; note A3 dur 28
    db $A0, $04 ; volume $04
    db $39, $19 ; note A3 dur 25
    db $A0, $02 ; volume $02
    db $39, $1B ; note A3 dur 27
    db $A0, $04 ; volume $04
    db $39, $17 ; note A3 dur 23
    db $A0, $02 ; volume $02
    db $39, $1B ; note A3 dur 27
    db $A0, $04 ; volume $04
    db $39, $16 ; note A3 dur 22
    db $A0, $02 ; volume $02
    db $39, $1B ; note A3 dur 27
    db $A0, $04 ; volume $04
    db $39, $16 ; note A3 dur 22
    db $A0, $02 ; volume $02
    db $39, $1B ; note A3 dur 27
    db $A0, $04 ; volume $04
    db $39, $16 ; note A3 dur 22
    db $A0, $02 ; volume $02
    db $39, $1B ; note A3 dur 27
    db $A0, $04 ; volume $04
    db $39, $16 ; note A3 dur 22
    db $A0, $02 ; volume $02
    db $39, $1B ; note A3 dur 27
    db $A0, $04 ; volume $04
    db $39, $17 ; note A3 dur 23
    db $A0, $02 ; volume $02
    db $39, $1B ; note A3 dur 27
    db $A0, $04 ; volume $04
    db $39, $19 ; note A3 dur 25
    db $A0, $02 ; volume $02
    db $39, $1B ; note A3 dur 27
    db $A0, $04 ; volume $04
    db $39, $1A ; note A3 dur 26
    db $A0, $02 ; volume $02
    db $39, $1B ; note A3 dur 27
    db $A0, $04 ; volume $04
    db $39, $1A ; note A3 dur 26
    db $A0, $02 ; volume $02
    db $39, $1C ; note A3 dur 28
    db $A0, $04 ; volume $04
    db $39, $1B ; note A3 dur 27
    db $A0, $02 ; volume $02
    db $39, $1C ; note A3 dur 28
    db $A0, $04 ; volume $04
    db $39, $1C ; note A3 dur 28
    db $A0, $02 ; volume $02
    db $39, $1C ; note A3 dur 28
    db $A0, $04 ; volume $04
    db $39, $1C ; note A3 dur 28
    db $A0, $02 ; volume $02
    db $39, $1C ; note A3 dur 28
    db $A0, $04 ; volume $04
    db $39, $1E ; note A3 dur 30
    db $A2, $FF ; duty2 $FF
    db $A1, $09 ; duty $09
    db $A0, $02 ; volume $02
    db $30, $3B ; note C3 dur 59
    db $31, $3B ; note C#3 dur 59
    db $32, $3B ; note D3 dur 59
    db $33, $40 ; note D#3 dur 64
    db $34, $2C ; note E3 dur 44
    db $A0, $04 ; volume $04
    db $34, $10 ; note E3 dur 16
    db $B0, $F3 ; jump $F3
    db $FF, $FF ; end

; sound track, 603 events after the header (E-0019: grammar C2, meaning C0)
Data_041_4A63:: ; heuristic: track stream of a sound record; C0
    db $03, $00, $09, $00 ; header: param=3 byte1=$00 volume=$09 byte3=$00
    db $FD, $F3 ; label 3
    db $C3, $38 ; env $38
    db $A3, $09 ; mod $09
    db $A0, $0B ; volume $0B
    db $FD, $F0 ; label 0
    db $26, $06 ; note F#2 dur 6
    db $2A, $06 ; note A#2 dur 6
    db $BF, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $28, $06 ; note G#2 dur 6
    db $30, $06 ; note C3 dur 6
    db $BB, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $2A, $06 ; note A#2 dur 6
    db $31, $06 ; note C#3 dur 6
    db $BF, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $29, $06 ; note A2 dur 6
    db $31, $06 ; note C#3 dur 6
    db $BB, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $2B, $06 ; note B2 dur 6
    db $33, $06 ; note D#3 dur 6
    db $B3, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $2A, $06 ; note A#2 dur 6
    db $33, $06 ; note D#3 dur 6
    db $B3, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $29, $06 ; note A2 dur 6
    db $30, $06 ; note C3 dur 6
    db $B7, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $28, $06 ; note G#2 dur 6
    db $30, $06 ; note C3 dur 6
    db $B3, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $27, $06 ; note G2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $B3, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $26, $06 ; note F#2 dur 6
    db $29, $06 ; note A2 dur 6
    db $B7, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $25, $06 ; note F2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $BB, $F0 ; repeat $F0
    db $A0, $0B ; volume $0B
    db $FD, $F0 ; label 0
    db $22, $06 ; note D2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2A, $06 ; note A#2 dur 6
    db $32, $06 ; note D3 dur 6
    db $B3, $F0 ; repeat $F0
    db $A0, $0A ; volume $0A
    db $FD, $F0 ; label 0
    db $22, $06 ; note D2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2A, $06 ; note A#2 dur 6
    db $32, $06 ; note D3 dur 6
    db $B1, $F0 ; repeat $F0
    db $A0, $09 ; volume $09
    db $FD, $F0 ; label 0
    db $22, $06 ; note D2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2A, $06 ; note A#2 dur 6
    db $32, $06 ; note D3 dur 6
    db $B1, $F0 ; repeat $F0
    db $A0, $0B ; volume $0B
    db $26, $06 ; note F#2 dur 6
    db $A0, $03 ; volume $03
    db $26, $06 ; note F#2 dur 6
    db $A0, $0B ; volume $0B
    db $26, $06 ; note F#2 dur 6
    db $A0, $03 ; volume $03
    db $26, $06 ; note F#2 dur 6
    db $A0, $0B ; volume $0B
    db $2A, $06 ; note A#2 dur 6
    db $A0, $03 ; volume $03
    db $26, $06 ; note F#2 dur 6
    db $A0, $0B ; volume $0B
    db $2A, $06 ; note A#2 dur 6
    db $A0, $03 ; volume $03
    db $2A, $06 ; note A#2 dur 6
    db $A0, $0B ; volume $0B
    db $26, $06 ; note F#2 dur 6
    db $A0, $03 ; volume $03
    db $2A, $06 ; note A#2 dur 6
    db $A0, $0B ; volume $0B
    db $26, $06 ; note F#2 dur 6
    db $A0, $03 ; volume $03
    db $26, $06 ; note F#2 dur 6
    db $A0, $0B ; volume $0B
    db $2A, $06 ; note A#2 dur 6
    db $A0, $03 ; volume $03
    db $26, $06 ; note F#2 dur 6
    db $A0, $0B ; volume $0B
    db $2A, $06 ; note A#2 dur 6
    db $A0, $03 ; volume $03
    db $2A, $06 ; note A#2 dur 6
    db $A0, $0B ; volume $0B
    db $26, $06 ; note F#2 dur 6
    db $A0, $03 ; volume $03
    db $2A, $06 ; note A#2 dur 6
    db $A0, $0B ; volume $0B
    db $26, $06 ; note F#2 dur 6
    db $A0, $03 ; volume $03
    db $26, $06 ; note F#2 dur 6
    db $A0, $0B ; volume $0B
    db $2A, $06 ; note A#2 dur 6
    db $A0, $03 ; volume $03
    db $26, $06 ; note F#2 dur 6
    db $A0, $0B ; volume $0B
    db $2A, $06 ; note A#2 dur 6
    db $A0, $03 ; volume $03
    db $2A, $06 ; note A#2 dur 6
    db $A0, $0B ; volume $0B
    db $27, $06 ; note G2 dur 6
    db $A0, $03 ; volume $03
    db $2A, $06 ; note A#2 dur 6
    db $A0, $0B ; volume $0B
    db $27, $06 ; note G2 dur 6
    db $A0, $03 ; volume $03
    db $27, $06 ; note G2 dur 6
    db $A0, $0B ; volume $0B
    db $2B, $06 ; note B2 dur 6
    db $A0, $03 ; volume $03
    db $27, $06 ; note G2 dur 6
    db $A0, $0B ; volume $0B
    db $2B, $06 ; note B2 dur 6
    db $A0, $03 ; volume $03
    db $2B, $06 ; note B2 dur 6
    db $A0, $0B ; volume $0B
    db $27, $06 ; note G2 dur 6
    db $A0, $03 ; volume $03
    db $2B, $06 ; note B2 dur 6
    db $A0, $0B ; volume $0B
    db $27, $06 ; note G2 dur 6
    db $A0, $03 ; volume $03
    db $27, $06 ; note G2 dur 6
    db $A0, $0B ; volume $0B
    db $2B, $06 ; note B2 dur 6
    db $A0, $03 ; volume $03
    db $27, $06 ; note G2 dur 6
    db $A0, $0B ; volume $0B
    db $2B, $06 ; note B2 dur 6
    db $A0, $03 ; volume $03
    db $2B, $06 ; note B2 dur 6
    db $A0, $0B ; volume $0B
    db $27, $06 ; note G2 dur 6
    db $A0, $03 ; volume $03
    db $2B, $06 ; note B2 dur 6
    db $A0, $0B ; volume $0B
    db $27, $06 ; note G2 dur 6
    db $A0, $03 ; volume $03
    db $27, $06 ; note G2 dur 6
    db $A0, $0B ; volume $0B
    db $2B, $06 ; note B2 dur 6
    db $A0, $03 ; volume $03
    db $27, $06 ; note G2 dur 6
    db $A0, $0B ; volume $0B
    db $2B, $06 ; note B2 dur 6
    db $A0, $03 ; volume $03
    db $2B, $06 ; note B2 dur 6
    db $A0, $0B ; volume $0B
    db $28, $06 ; note G#2 dur 6
    db $A0, $03 ; volume $03
    db $2B, $06 ; note B2 dur 6
    db $A0, $0B ; volume $0B
    db $28, $06 ; note G#2 dur 6
    db $A0, $03 ; volume $03
    db $28, $06 ; note G#2 dur 6
    db $A0, $0B ; volume $0B
    db $30, $06 ; note C3 dur 6
    db $A0, $03 ; volume $03
    db $28, $06 ; note G#2 dur 6
    db $A0, $0B ; volume $0B
    db $30, $06 ; note C3 dur 6
    db $A0, $03 ; volume $03
    db $30, $06 ; note C3 dur 6
    db $A0, $0B ; volume $0B
    db $28, $06 ; note G#2 dur 6
    db $A0, $03 ; volume $03
    db $30, $06 ; note C3 dur 6
    db $A0, $0B ; volume $0B
    db $28, $06 ; note G#2 dur 6
    db $A0, $03 ; volume $03
    db $28, $06 ; note G#2 dur 6
    db $A0, $0B ; volume $0B
    db $30, $06 ; note C3 dur 6
    db $A0, $03 ; volume $03
    db $28, $06 ; note G#2 dur 6
    db $A0, $0B ; volume $0B
    db $30, $06 ; note C3 dur 6
    db $A0, $03 ; volume $03
    db $30, $06 ; note C3 dur 6
    db $A0, $0B ; volume $0B
    db $28, $06 ; note G#2 dur 6
    db $A0, $03 ; volume $03
    db $30, $06 ; note C3 dur 6
    db $A0, $0B ; volume $0B
    db $28, $06 ; note G#2 dur 6
    db $A0, $03 ; volume $03
    db $28, $06 ; note G#2 dur 6
    db $A0, $0B ; volume $0B
    db $30, $06 ; note C3 dur 6
    db $A0, $03 ; volume $03
    db $28, $06 ; note G#2 dur 6
    db $A0, $0B ; volume $0B
    db $30, $06 ; note C3 dur 6
    db $A0, $03 ; volume $03
    db $30, $06 ; note C3 dur 6
    db $A0, $0B ; volume $0B
    db $26, $06 ; note F#2 dur 6
    db $A0, $03 ; volume $03
    db $30, $06 ; note C3 dur 6
    db $A0, $0B ; volume $0B
    db $26, $06 ; note F#2 dur 6
    db $A0, $03 ; volume $03
    db $26, $06 ; note F#2 dur 6
    db $A0, $0B ; volume $0B
    db $2B, $06 ; note B2 dur 6
    db $A0, $03 ; volume $03
    db $26, $06 ; note F#2 dur 6
    db $A0, $0B ; volume $0B
    db $2B, $06 ; note B2 dur 6
    db $A0, $03 ; volume $03
    db $2B, $06 ; note B2 dur 6
    db $A0, $0B ; volume $0B
    db $26, $06 ; note F#2 dur 6
    db $A0, $03 ; volume $03
    db $2B, $06 ; note B2 dur 6
    db $A0, $0B ; volume $0B
    db $26, $06 ; note F#2 dur 6
    db $A0, $03 ; volume $03
    db $26, $06 ; note F#2 dur 6
    db $A0, $0B ; volume $0B
    db $2B, $06 ; note B2 dur 6
    db $A0, $03 ; volume $03
    db $26, $06 ; note F#2 dur 6
    db $A0, $0B ; volume $0B
    db $2B, $06 ; note B2 dur 6
    db $A0, $03 ; volume $03
    db $2B, $06 ; note B2 dur 6
    db $A0, $0B ; volume $0B
    db $26, $06 ; note F#2 dur 6
    db $A0, $03 ; volume $03
    db $2B, $06 ; note B2 dur 6
    db $A0, $0B ; volume $0B
    db $26, $06 ; note F#2 dur 6
    db $A0, $03 ; volume $03
    db $26, $06 ; note F#2 dur 6
    db $A0, $0B ; volume $0B
    db $2B, $06 ; note B2 dur 6
    db $A0, $03 ; volume $03
    db $26, $06 ; note F#2 dur 6
    db $A0, $0B ; volume $0B
    db $2B, $06 ; note B2 dur 6
    db $A0, $03 ; volume $03
    db $2B, $12 ; note B2 dur 18
    db $1F, $06 ; rest-note $1F dur 6
    db $A2, $02 ; duty2 $02
    db $C1, $7F ; env $7F
    db $A0, $02 ; volume $02
    db $1F, $12 ; rest-note $1F dur 18
    db $39, $0C ; note A3 dur 12
    db $A2, $00 ; duty2 $00
    db $C3, $48 ; env $48
    db $A0, $09 ; volume $09
    db $2B, $0C ; note B2 dur 12
    db $A0, $05 ; volume $05
    db $2B, $0C ; note B2 dur 12
    db $C3, $7F ; env $7F
    db $A3, $FE ; mod $FE
    db $A0, $09 ; volume $09
    db $35, $2C ; note F3 dur 44
    db $C1, $7F ; env $7F
    db $A0, $06 ; volume $06
    db $35, $4C ; note F3 dur 76
    db $A3, $09 ; mod $09
    db $C3, $48 ; env $48
    db $A0, $0B ; volume $0B
    db $25, $0C ; note F2 dur 12
    db $A0, $04 ; volume $04
    db $25, $0C ; note F2 dur 12
    db $C3, $7F ; env $7F
    db $A3, $FE ; mod $FE
    db $A0, $0B ; volume $0B
    db $2B, $30 ; note B2 dur 48
    db $C1, $7F ; env $7F
    db $A0, $06 ; volume $06
    db $2B, $48 ; note B2 dur 72
    db $A3, $09 ; mod $09
    db $C0, $FE ; env $FE
    db $A0, $07 ; volume $07
    db $26, $24 ; note F#2 dur 36
    db $C1, $4F ; env $4F
    db $A0, $05 ; volume $05
    db $26, $0C ; note F#2 dur 12
    db $C0, $FE ; env $FE
    db $A0, $07 ; volume $07
    db $26, $24 ; note F#2 dur 36
    db $C1, $4F ; env $4F
    db $A0, $05 ; volume $05
    db $26, $0C ; note F#2 dur 12
    db $C3, $58 ; env $58
    db $A3, $FE ; mod $FE
    db $A0, $0A ; volume $0A
    db $25, $78 ; note F2 dur 120
    db $A3, $09 ; mod $09
    db $C1, $7F ; env $7F
    db $A0, $06 ; volume $06
    db $25, $18 ; note F2 dur 24
    db $C3, $58 ; env $58
    db $FD, $F0 ; label 0
    db $A0, $0A ; volume $0A
    db $24, $0C ; note E2 dur 12
    db $A0, $05 ; volume $05
    db $24, $0C ; note E2 dur 12
    db $B5, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $A0, $0A ; volume $0A
    db $23, $0C ; note D#2 dur 12
    db $A0, $05 ; volume $05
    db $23, $0C ; note D#2 dur 12
    db $B5, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $A0, $0A ; volume $0A
    db $22, $0C ; note D2 dur 12
    db $A0, $05 ; volume $05
    db $22, $0C ; note D2 dur 12
    db $B5, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $A0, $0A ; volume $0A
    db $21, $0C ; note C#2 dur 12
    db $A0, $05 ; volume $05
    db $21, $0C ; note C#2 dur 12
    db $B5, $F0 ; repeat $F0
    db $1F, $0C ; rest-note $1F dur 12
    db $C1, $7F ; env $7F
    db $A0, $03 ; volume $03
    db $1B, $18 ; note B1 dur 24
    db $A0, $05 ; volume $05
    db $15, $0C ; note F1 dur 12
    db $C3, $48 ; env $48
    db $A0, $0A ; volume $0A
    db $2A, $0C ; note A#2 dur 12
    db $A0, $05 ; volume $05
    db $2A, $0C ; note A#2 dur 12
    db $C0, $FE ; env $FE
    db $A3, $FE ; mod $FE
    db $A0, $08 ; volume $08
    db $24, $2C ; note E2 dur 44
    db $C1, $7F ; env $7F
    db $A0, $06 ; volume $06
    db $24, $4C ; note E2 dur 76
    db $C0, $FE ; env $FE
    db $A3, $09 ; mod $09
    db $A0, $07 ; volume $07
    db $24, $24 ; note E2 dur 36
    db $A0, $05 ; volume $05
    db $24, $0C ; note E2 dur 12
    db $A0, $07 ; volume $07
    db $24, $24 ; note E2 dur 36
    db $C1, $7F ; env $7F
    db $A0, $05 ; volume $05
    db $24, $18 ; note E2 dur 24
    db $22, $18 ; note D2 dur 24
    db $18, $0C ; note G#1 dur 12
    db $C3, $58 ; env $58
    db $A0, $0A ; volume $0A
    db $31, $0C ; note C#3 dur 12
    db $A0, $05 ; volume $05
    db $31, $0C ; note C#3 dur 12
    db $C0, $FE ; env $FE
    db $A3, $FE ; mod $FE
    db $A0, $08 ; volume $08
    db $27, $2C ; note G2 dur 44
    db $C1, $7F ; env $7F
    db $A0, $06 ; volume $06
    db $27, $4C ; note G2 dur 76
    db $A3, $09 ; mod $09
    db $C0, $FE ; env $FE
    db $A0, $07 ; volume $07
    db $27, $24 ; note G2 dur 36
    db $A0, $05 ; volume $05
    db $27, $0C ; note G2 dur 12
    db $A0, $07 ; volume $07
    db $27, $24 ; note G2 dur 36
    db $A0, $05 ; volume $05
    db $27, $18 ; note G2 dur 24
    db $C1, $7F ; env $7F
    db $A0, $03 ; volume $03
    db $25, $0C ; note F2 dur 12
    db $25, $0C ; note F2 dur 12
    db $2A, $0C ; note A#2 dur 12
    db $2A, $0C ; note A#2 dur 12
    db $25, $0C ; note F2 dur 12
    db $25, $0C ; note F2 dur 12
    db $2A, $0C ; note A#2 dur 12
    db $C4, $28 ; env $28
    db $A0, $0C ; volume $0C
    db $10, $05 ; note C1 dur 5
    db $12, $05 ; note D1 dur 5
    db $10, $05 ; note C1 dur 5
    db $12, $05 ; note D1 dur 5
    db $A0, $0E ; volume $0E
    db $10, $04 ; note C1 dur 4
    db $12, $04 ; note D1 dur 4
    db $10, $04 ; note C1 dur 4
    db $12, $04 ; note D1 dur 4
    db $A0, $0F ; volume $0F
    db $10, $04 ; note C1 dur 4
    db $12, $04 ; note D1 dur 4
    db $10, $04 ; note C1 dur 4
    db $12, $04 ; note D1 dur 4
    db $10, $04 ; note C1 dur 4
    db $12, $04 ; note D1 dur 4
    db $A0, $0F ; volume $0F
    db $10, $04 ; note C1 dur 4
    db $12, $04 ; note D1 dur 4
    db $10, $04 ; note C1 dur 4
    db $12, $04 ; note D1 dur 4
    db $10, $04 ; note C1 dur 4
    db $12, $04 ; note D1 dur 4
    db $10, $04 ; note C1 dur 4
    db $12, $04 ; note D1 dur 4
    db $10, $04 ; note C1 dur 4
    db $12, $04 ; note D1 dur 4
    db $10, $04 ; note C1 dur 4
    db $12, $04 ; note D1 dur 4
    db $10, $04 ; note C1 dur 4
    db $12, $04 ; note D1 dur 4
    db $10, $04 ; note C1 dur 4
    db $12, $04 ; note D1 dur 4
    db $A0, $0E ; volume $0E
    db $10, $04 ; note C1 dur 4
    db $12, $04 ; note D1 dur 4
    db $10, $04 ; note C1 dur 4
    db $12, $04 ; note D1 dur 4
    db $10, $04 ; note C1 dur 4
    db $A0, $0A ; volume $0A
    db $12, $04 ; note D1 dur 4
    db $10, $04 ; note C1 dur 4
    db $12, $04 ; note D1 dur 4
    db $10, $04 ; note C1 dur 4
    db $12, $04 ; note D1 dur 4
    db $A0, $0A ; volume $0A
    db $10, $04 ; note C1 dur 4
    db $12, $04 ; note D1 dur 4
    db $10, $04 ; note C1 dur 4
    db $12, $04 ; note D1 dur 4
    db $A0, $06 ; volume $06
    db $10, $04 ; note C1 dur 4
    db $12, $04 ; note D1 dur 4
    db $10, $04 ; note C1 dur 4
    db $12, $04 ; note D1 dur 4
    db $A0, $04 ; volume $04
    db $10, $04 ; note C1 dur 4
    db $12, $04 ; note D1 dur 4
    db $C1, $7F ; env $7F
    db $A0, $03 ; volume $03
    db $24, $0C ; note E2 dur 12
    db $24, $0C ; note E2 dur 12
    db $29, $0C ; note A2 dur 12
    db $29, $0C ; note A2 dur 12
    db $24, $0C ; note E2 dur 12
    db $24, $0C ; note E2 dur 12
    db $29, $0C ; note A2 dur 12
    db $A0, $0D ; volume $0D
    db $C4, $28 ; env $28
    db $0B, $04 ; note B0 dur 4
    db $10, $04 ; note C1 dur 4
    db $0B, $04 ; note B0 dur 4
    db $10, $04 ; note C1 dur 4
    db $A0, $0E ; volume $0E
    db $0B, $04 ; note B0 dur 4
    db $10, $04 ; note C1 dur 4
    db $0B, $04 ; note B0 dur 4
    db $10, $04 ; note C1 dur 4
    db $A0, $0F ; volume $0F
    db $0B, $04 ; note B0 dur 4
    db $10, $04 ; note C1 dur 4
    db $0B, $04 ; note B0 dur 4
    db $10, $04 ; note C1 dur 4
    db $A0, $0F ; volume $0F
    db $0B, $04 ; note B0 dur 4
    db $10, $04 ; note C1 dur 4
    db $0B, $04 ; note B0 dur 4
    db $10, $04 ; note C1 dur 4
    db $0B, $04 ; note B0 dur 4
    db $10, $04 ; note C1 dur 4
    db $0B, $04 ; note B0 dur 4
    db $10, $04 ; note C1 dur 4
    db $0B, $04 ; note B0 dur 4
    db $10, $04 ; note C1 dur 4
    db $0B, $04 ; note B0 dur 4
    db $10, $04 ; note C1 dur 4
    db $0B, $04 ; note B0 dur 4
    db $10, $04 ; note C1 dur 4
    db $0B, $04 ; note B0 dur 4
    db $10, $04 ; note C1 dur 4
    db $0B, $04 ; note B0 dur 4
    db $10, $04 ; note C1 dur 4
    db $0B, $04 ; note B0 dur 4
    db $10, $04 ; note C1 dur 4
    db $0B, $04 ; note B0 dur 4
    db $10, $04 ; note C1 dur 4
    db $0B, $04 ; note B0 dur 4
    db $10, $04 ; note C1 dur 4
    db $0B, $04 ; note B0 dur 4
    db $10, $04 ; note C1 dur 4
    db $A0, $0E ; volume $0E
    db $0B, $04 ; note B0 dur 4
    db $10, $04 ; note C1 dur 4
    db $0B, $04 ; note B0 dur 4
    db $10, $04 ; note C1 dur 4
    db $A0, $0A ; volume $0A
    db $0B, $04 ; note B0 dur 4
    db $10, $04 ; note C1 dur 4
    db $0B, $04 ; note B0 dur 4
    db $A0, $08 ; volume $08
    db $10, $04 ; note C1 dur 4
    db $0B, $04 ; note B0 dur 4
    db $10, $04 ; note C1 dur 4
    db $C3, $38 ; env $38
    db $A0, $0A ; volume $0A
    db $24, $0B ; note E2 dur 11
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $24, $0C ; note E2 dur 12
    db $A0, $0A ; volume $0A
    db $27, $0B ; note G2 dur 11
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $27, $0C ; note G2 dur 12
    db $A0, $0A ; volume $0A
    db $2A, $0B ; note A#2 dur 11
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $2A, $0C ; note A#2 dur 12
    db $A0, $0A ; volume $0A
    db $31, $0B ; note C#3 dur 11
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $31, $0C ; note C#3 dur 12
    db $A0, $0A ; volume $0A
    db $34, $0B ; note E3 dur 11
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $34, $0C ; note E3 dur 12
    db $A0, $0A ; volume $0A
    db $37, $0B ; note G3 dur 11
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $37, $0C ; note G3 dur 12
    db $A0, $0A ; volume $0A
    db $36, $0B ; note F#3 dur 11
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $36, $0C ; note F#3 dur 12
    db $A0, $0A ; volume $0A
    db $31, $0B ; note C#3 dur 11
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $31, $0C ; note C#3 dur 12
    db $A0, $0A ; volume $0A
    db $28, $0B ; note G#2 dur 11
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $28, $0C ; note G#2 dur 12
    db $A0, $0A ; volume $0A
    db $23, $0B ; note D#2 dur 11
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $23, $0C ; note D#2 dur 12
    db $A0, $0A ; volume $0A
    db $1A, $0B ; note A#1 dur 11
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $1A, $0C ; note A#1 dur 12
    db $A0, $0A ; volume $0A
    db $15, $0B ; note F1 dur 11
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $16, $0C ; note F#1 dur 12
    db $A0, $0A ; volume $0A
    db $C3, $48 ; env $48
    db $1A, $18 ; note A#1 dur 24
    db $1B, $18 ; note B1 dur 24
    db $20, $18 ; note C2 dur 24
    db $21, $18 ; note C#2 dur 24
    db $22, $18 ; note D2 dur 24
    db $23, $18 ; note D#2 dur 24
    db $24, $18 ; note E2 dur 24
    db $25, $18 ; note F2 dur 24
    db $26, $18 ; note F#2 dur 24
    db $27, $18 ; note G2 dur 24
    db $28, $18 ; note G#2 dur 24
    db $29, $18 ; note A2 dur 24
    db $B0, $F3 ; jump $F3
    db $FF, $FF ; end

; sound track, 584 events after the header (E-0019: grammar C2, meaning C0)
Data_041_4F1D:: ; heuristic: track stream of a sound record; C0
    db $03, $02, $09, $00 ; header: param=3 byte1=$02 volume=$09 byte3=$00
    db $FD, $F3 ; label 3
    db $C3, $78 ; env $78
    db $A2, $02 ; duty2 $02
    db $A3, $09 ; mod $09
    db $A0, $0E ; volume $0E
    db $32, $30 ; note D3 dur 48
    db $A3, $FE ; mod $FE
    db $39, $3C ; note A3 dur 60
    db $A3, $00 ; mod $00
    db $C1, $5F ; env $5F
    db $A0, $08 ; volume $08
    db $39, $0C ; note A3 dur 12
    db $A3, $09 ; mod $09
    db $C3, $58 ; env $58
    db $A0, $0E ; volume $0E
    db $A3, $FE ; mod $FE
    db $39, $18 ; note A3 dur 24
    db $3A, $18 ; note A#3 dur 24
    db $39, $18 ; note A3 dur 24
    db $C3, $78 ; env $78
    db $38, $30 ; note G#3 dur 48
    db $34, $30 ; note E3 dur 48
    db $2A, $18 ; note A#2 dur 24
    db $A3, $00 ; mod $00
    db $C1, $7F ; env $7F
    db $A0, $07 ; volume $07
    db $2A, $18 ; note A#2 dur 24
    db $A3, $09 ; mod $09
    db $C3, $78 ; env $78
    db $A0, $0E ; volume $0E
    db $29, $30 ; note A2 dur 48
    db $A3, $FE ; mod $FE
    db $34, $3C ; note E3 dur 60
    db $A3, $00 ; mod $00
    db $C1, $5F ; env $5F
    db $A0, $08 ; volume $08
    db $34, $0C ; note E3 dur 12
    db $A3, $0E ; mod $0E
    db $C3, $58 ; env $58
    db $A0, $0E ; volume $0E
    db $34, $18 ; note E3 dur 24
    db $33, $18 ; note D#3 dur 24
    db $34, $18 ; note E3 dur 24
    db $A0, $0A ; volume $0A
    db $C0, $FE ; env $FE
    db $A3, $FE ; mod $FE
    db $35, $30 ; note F3 dur 48
    db $36, $30 ; note F#3 dur 48
    db $A0, $09 ; volume $09
    db $40, $24 ; note C4 dur 36
    db $C1, $7F ; env $7F
    db $A0, $07 ; volume $07
    db $40, $0C ; note C4 dur 12
    db $A3, $0E ; mod $0E
    db $C3, $78 ; env $78
    db $A0, $0E ; volume $0E
    db $3B, $12 ; note B3 dur 18
    db $A0, $0F ; volume $0F
    db $40, $0F ; note C4 dur 15
    db $3B, $0F ; note B3 dur 15
    db $3A, $12 ; note A#3 dur 18
    db $39, $0F ; note A3 dur 15
    db $35, $0F ; note F3 dur 15
    db $A3, $FE ; mod $FE
    db $A0, $0A ; volume $0A
    db $C0, $FE ; env $FE
    db $2B, $30 ; note B2 dur 48
    db $A3, $00 ; mod $00
    db $C1, $7F ; env $7F
    db $A0, $09 ; volume $09
    db $2B, $18 ; note B2 dur 24
    db $A3, $0E ; mod $0E
    db $C3, $78 ; env $78
    db $A0, $0E ; volume $0E
    db $2A, $0C ; note A#2 dur 12
    db $29, $0C ; note A2 dur 12
    db $34, $12 ; note E3 dur 18
    db $35, $0F ; note F3 dur 15
    db $34, $0F ; note E3 dur 15
    db $33, $12 ; note D#3 dur 18
    db $32, $0F ; note D3 dur 15
    db $2A, $0F ; note A#2 dur 15
    db $A3, $FE ; mod $FE
    db $A0, $0A ; volume $0A
    db $C0, $FE ; env $FE
    db $24, $30 ; note E2 dur 48
    db $A3, $00 ; mod $00
    db $C1, $7F ; env $7F
    db $A0, $07 ; volume $07
    db $24, $18 ; note E2 dur 24
    db $A3, $0E ; mod $0E
    db $C3, $78 ; env $78
    db $A0, $0E ; volume $0E
    db $25, $0C ; note F2 dur 12
    db $26, $0C ; note F#2 dur 12
    db $A3, $FE ; mod $FE
    db $A0, $0B ; volume $0B
    db $C0, $FE ; env $FE
    db $27, $90 ; note G2 dur 144
    db $26, $30 ; note F#2 dur 48
    db $C0, $FE ; env $FE
    db $A0, $08 ; volume $08
    db $A3, $FE ; mod $FE
    db $33, $78 ; note D#3 dur 120
    db $C1, $7F ; env $7F
    db $A0, $06 ; volume $06
    db $33, $18 ; note D#3 dur 24
    db $C0, $FE ; env $FE
    db $A0, $0B ; volume $0B
    db $32, $48 ; note D3 dur 72
    db $A3, $0E ; mod $0E
    db $C3, $7F ; env $7F
    db $A0, $0E ; volume $0E
    db $33, $18 ; note D#3 dur 24
    db $39, $18 ; note A3 dur 24
    db $3A, $18 ; note A#3 dur 24
    db $41, $18 ; note C#4 dur 24
    db $42, $18 ; note D4 dur 24
    db $43, $18 ; note D#4 dur 24
    db $42, $18 ; note D4 dur 24
    db $41, $18 ; note C#4 dur 24
    db $39, $18 ; note A3 dur 24
    db $A3, $FE ; mod $FE
    db $C0, $FE ; env $FE
    db $A0, $0A ; volume $0A
    db $40, $48 ; note C4 dur 72
    db $A3, $0E ; mod $0E
    db $41, $18 ; note C#4 dur 24
    db $40, $18 ; note C4 dur 24
    db $3B, $18 ; note B3 dur 24
    db $3A, $18 ; note A#3 dur 24
    db $35, $18 ; note F3 dur 24
    db $2B, $18 ; note B2 dur 24
    db $30, $18 ; note C3 dur 24
    db $31, $18 ; note C#3 dur 24
    db $32, $18 ; note D3 dur 24
    db $A3, $FE ; mod $FE
    db $33, $0C ; note D#3 dur 12
    db $A0, $05 ; volume $05
    db $33, $0C ; note D#3 dur 12
    db $C3, $7F ; env $7F
    db $A0, $0E ; volume $0E
    db $39, $48 ; note A3 dur 72
    db $A3, $06 ; mod $06
    db $C1, $7F ; env $7F
    db $A0, $09 ; volume $09
    db $39, $30 ; note A3 dur 48
    db $A3, $FE ; mod $FE
    db $C3, $78 ; env $78
    db $A0, $0E ; volume $0E
    db $29, $0C ; note A2 dur 12
    db $A0, $06 ; volume $06
    db $29, $0C ; note A2 dur 12
    db $C3, $7F ; env $7F
    db $A0, $0E ; volume $0E
    db $33, $48 ; note D#3 dur 72
    db $C1, $7F ; env $7F
    db $A3, $06 ; mod $06
    db $A0, $09 ; volume $09
    db $33, $30 ; note D#3 dur 48
    db $1F, $30 ; rest-note $1F dur 48
    db $A2, $01 ; duty2 $01
    db $A3, $0A ; mod $0A
    db $C0, $FE ; env $FE
    db $A0, $0B ; volume $0B
    db $2A, $24 ; note A#2 dur 36
    db $C1, $30 ; env $30
    db $A0, $08 ; volume $08
    db $2A, $0C ; note A#2 dur 12
    db $C0, $FE ; env $FE
    db $A0, $0B ; volume $0B
    db $2A, $24 ; note A#2 dur 36
    db $C1, $3F ; env $3F
    db $A0, $08 ; volume $08
    db $2A, $0C ; note A#2 dur 12
    db $C0, $FE ; env $FE
    db $A0, $08 ; volume $08
    db $A3, $FE ; mod $FE
    db $29, $78 ; note A2 dur 120
    db $A3, $00 ; mod $00
    db $C1, $7F ; env $7F
    db $A0, $07 ; volume $07
    db $29, $18 ; note A2 dur 24
    db $A3, $0E ; mod $0E
    db $C3, $78 ; env $78
    db $FD, $F0 ; label 0
    db $A0, $0E ; volume $0E
    db $28, $0C ; note G#2 dur 12
    db $A0, $06 ; volume $06
    db $28, $0C ; note G#2 dur 12
    db $B5, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $A0, $0E ; volume $0E
    db $27, $0C ; note G2 dur 12
    db $A0, $06 ; volume $06
    db $27, $0C ; note G2 dur 12
    db $B5, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $A0, $0E ; volume $0E
    db $26, $0C ; note F#2 dur 12
    db $A0, $06 ; volume $06
    db $26, $0C ; note F#2 dur 12
    db $B5, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $A0, $0E ; volume $0E
    db $26, $0C ; note F#2 dur 12
    db $A0, $06 ; volume $06
    db $26, $0C ; note F#2 dur 12
    db $B4, $F0 ; repeat $F0
    db $A0, $0E ; volume $0E
    db $26, $0C ; note F#2 dur 12
    db $C1, $30 ; env $30
    db $A0, $06 ; volume $06
    db $26, $48 ; note F#2 dur 72
    db $A0, $05 ; volume $05
    db $2A, $18 ; note A#2 dur 24
    db $24, $0C ; note E2 dur 12
    db $C3, $48 ; env $48
    db $A0, $0E ; volume $0E
    db $39, $0C ; note A3 dur 12
    db $A0, $06 ; volume $06
    db $39, $0C ; note A3 dur 12
    db $C0, $FE ; env $FE
    db $A3, $FE ; mod $FE
    db $A0, $0A ; volume $0A
    db $33, $30 ; note D#3 dur 48
    db $C1, $7F ; env $7F
    db $A3, $0F ; mod $0F
    db $A0, $07 ; volume $07
    db $33, $18 ; note D#3 dur 24
    db $A3, $0E ; mod $0E
    db $C0, $FE ; env $FE
    db $A0, $0B ; volume $0B
    db $25, $24 ; note F2 dur 36
    db $A0, $06 ; volume $06
    db $25, $0C ; note F2 dur 12
    db $A3, $0E ; mod $0E
    db $C0, $FE ; env $FE
    db $A0, $0B ; volume $0B
    db $25, $24 ; note F2 dur 36
    db $C1, $50 ; env $50
    db $A3, $00 ; mod $00
    db $A0, $0A ; volume $0A
    db $25, $48 ; note F2 dur 72
    db $A3, $0E ; mod $0E
    db $A0, $05 ; volume $05
    db $31, $18 ; note C#3 dur 24
    db $27, $0C ; note G2 dur 12
    db $C3, $48 ; env $48
    db $A0, $0E ; volume $0E
    db $40, $0C ; note C4 dur 12
    db $A0, $06 ; volume $06
    db $40, $0C ; note C4 dur 12
    db $A3, $FE ; mod $FE
    db $C0, $FE ; env $FE
    db $A0, $09 ; volume $09
    db $36, $30 ; note F#3 dur 48
    db $C1, $7F ; env $7F
    db $A3, $0F ; mod $0F
    db $A0, $07 ; volume $07
    db $36, $18 ; note F#3 dur 24
    db $A3, $0E ; mod $0E
    db $C0, $FE ; env $FE
    db $FD, $F0 ; label 0
    db $A0, $0B ; volume $0B
    db $28, $24 ; note G#2 dur 36
    db $A0, $06 ; volume $06
    db $28, $0C ; note G#2 dur 12
    db $B1, $F0 ; repeat $F0
    db $A0, $0E ; volume $0E
    db $25, $05 ; note F2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $25, $06 ; note F2 dur 6
    db $A0, $0E ; volume $0E
    db $25, $05 ; note F2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $25, $06 ; note F2 dur 6
    db $A0, $0E ; volume $0E
    db $2A, $05 ; note A#2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $25, $06 ; note F2 dur 6
    db $A0, $0E ; volume $0E
    db $2A, $05 ; note A#2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $2A, $06 ; note A#2 dur 6
    db $A0, $0E ; volume $0E
    db $25, $05 ; note F2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $2A, $06 ; note A#2 dur 6
    db $A0, $0E ; volume $0E
    db $25, $05 ; note F2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $25, $06 ; note F2 dur 6
    db $A0, $0E ; volume $0E
    db $2A, $05 ; note A#2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $25, $06 ; note F2 dur 6
    db $A0, $0E ; volume $0E
    db $2A, $05 ; note A#2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $2A, $06 ; note A#2 dur 6
    db $A0, $0E ; volume $0E
    db $25, $05 ; note F2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $2A, $06 ; note A#2 dur 6
    db $A0, $0E ; volume $0E
    db $25, $05 ; note F2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $25, $06 ; note F2 dur 6
    db $A0, $0E ; volume $0E
    db $2A, $05 ; note A#2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $25, $06 ; note F2 dur 6
    db $A0, $0E ; volume $0E
    db $2A, $05 ; note A#2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $2A, $06 ; note A#2 dur 6
    db $A0, $0E ; volume $0E
    db $25, $05 ; note F2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $2A, $06 ; note A#2 dur 6
    db $A0, $0E ; volume $0E
    db $25, $05 ; note F2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $25, $06 ; note F2 dur 6
    db $A0, $0E ; volume $0E
    db $2A, $05 ; note A#2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $25, $06 ; note F2 dur 6
    db $A0, $0E ; volume $0E
    db $2A, $05 ; note A#2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $2A, $06 ; note A#2 dur 6
    db $A0, $0E ; volume $0E
    db $25, $05 ; note F2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $2A, $06 ; note A#2 dur 6
    db $A0, $0E ; volume $0E
    db $25, $05 ; note F2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $25, $06 ; note F2 dur 6
    db $A0, $0E ; volume $0E
    db $2A, $05 ; note A#2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $25, $06 ; note F2 dur 6
    db $A0, $0E ; volume $0E
    db $2A, $05 ; note A#2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $2A, $06 ; note A#2 dur 6
    db $A0, $0E ; volume $0E
    db $25, $05 ; note F2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $2A, $06 ; note A#2 dur 6
    db $A0, $0E ; volume $0E
    db $25, $05 ; note F2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $25, $06 ; note F2 dur 6
    db $A0, $0E ; volume $0E
    db $2A, $05 ; note A#2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $25, $06 ; note F2 dur 6
    db $A0, $0E ; volume $0E
    db $2A, $05 ; note A#2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $2A, $06 ; note A#2 dur 6
    db $A0, $0E ; volume $0E
    db $24, $05 ; note E2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $2A, $06 ; note A#2 dur 6
    db $A0, $0E ; volume $0E
    db $24, $05 ; note E2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $24, $06 ; note E2 dur 6
    db $A0, $0E ; volume $0E
    db $29, $05 ; note A2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $24, $06 ; note E2 dur 6
    db $A0, $0E ; volume $0E
    db $29, $05 ; note A2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $29, $06 ; note A2 dur 6
    db $A0, $0E ; volume $0E
    db $24, $05 ; note E2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $29, $06 ; note A2 dur 6
    db $A0, $0E ; volume $0E
    db $24, $05 ; note E2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $24, $06 ; note E2 dur 6
    db $A0, $0E ; volume $0E
    db $29, $05 ; note A2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $24, $06 ; note E2 dur 6
    db $A0, $0E ; volume $0E
    db $29, $05 ; note A2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $29, $06 ; note A2 dur 6
    db $A0, $0E ; volume $0E
    db $24, $05 ; note E2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $29, $06 ; note A2 dur 6
    db $A0, $0E ; volume $0E
    db $24, $05 ; note E2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $24, $06 ; note E2 dur 6
    db $A0, $0E ; volume $0E
    db $29, $05 ; note A2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $24, $06 ; note E2 dur 6
    db $A0, $0E ; volume $0E
    db $29, $05 ; note A2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $29, $06 ; note A2 dur 6
    db $A0, $0E ; volume $0E
    db $24, $05 ; note E2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $29, $06 ; note A2 dur 6
    db $A0, $0E ; volume $0E
    db $24, $05 ; note E2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $24, $06 ; note E2 dur 6
    db $A0, $0E ; volume $0E
    db $29, $05 ; note A2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $24, $06 ; note E2 dur 6
    db $A0, $0E ; volume $0E
    db $29, $05 ; note A2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $29, $06 ; note A2 dur 6
    db $A0, $0E ; volume $0E
    db $24, $05 ; note E2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $29, $06 ; note A2 dur 6
    db $A0, $0E ; volume $0E
    db $24, $05 ; note E2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $24, $06 ; note E2 dur 6
    db $A0, $0E ; volume $0E
    db $29, $05 ; note A2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $24, $06 ; note E2 dur 6
    db $A0, $0E ; volume $0E
    db $29, $05 ; note A2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $29, $06 ; note A2 dur 6
    db $A0, $0E ; volume $0E
    db $24, $05 ; note E2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $29, $06 ; note A2 dur 6
    db $A0, $0E ; volume $0E
    db $24, $05 ; note E2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $24, $06 ; note E2 dur 6
    db $A0, $0E ; volume $0E
    db $29, $05 ; note A2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $24, $06 ; note E2 dur 6
    db $A0, $0E ; volume $0E
    db $29, $05 ; note A2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $29, $06 ; note A2 dur 6
    db $A0, $0E ; volume $0E
    db $28, $0B ; note G#2 dur 11
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $01 ; volume $01
    db $28, $0C ; note G#2 dur 12
    db $A0, $0E ; volume $0E
    db $2B, $0B ; note B2 dur 11
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $01 ; volume $01
    db $28, $0C ; note G#2 dur 12
    db $A0, $0E ; volume $0E
    db $32, $0B ; note D3 dur 11
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $01 ; volume $01
    db $2B, $0C ; note B2 dur 12
    db $A0, $0E ; volume $0E
    db $35, $0B ; note F3 dur 11
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $01 ; volume $01
    db $32, $0C ; note D3 dur 12
    db $A0, $0E ; volume $0E
    db $38, $0B ; note G#3 dur 11
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $01 ; volume $01
    db $35, $0C ; note F3 dur 12
    db $A0, $0E ; volume $0E
    db $3B, $0B ; note B3 dur 11
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $01 ; volume $01
    db $38, $0C ; note G#3 dur 12
    db $A0, $0E ; volume $0E
    db $3A, $0B ; note A#3 dur 11
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $01 ; volume $01
    db $3B, $0C ; note B3 dur 12
    db $A0, $0E ; volume $0E
    db $35, $0B ; note F3 dur 11
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $01 ; volume $01
    db $3A, $0C ; note A#3 dur 12
    db $A0, $0E ; volume $0E
    db $30, $0B ; note C3 dur 11
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $01 ; volume $01
    db $35, $0C ; note F3 dur 12
    db $A0, $0E ; volume $0E
    db $27, $0B ; note G2 dur 11
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $01 ; volume $01
    db $30, $0C ; note C3 dur 12
    db $A0, $0E ; volume $0E
    db $22, $0B ; note D2 dur 11
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $01 ; volume $01
    db $27, $0C ; note G2 dur 12
    db $A0, $0E ; volume $0E
    db $19, $0B ; note A1 dur 11
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $01 ; volume $01
    db $22, $0C ; note D2 dur 12
    db $A0, $0E ; volume $0E
    db $22, $18 ; note D2 dur 24
    db $23, $18 ; note D#2 dur 24
    db $24, $18 ; note E2 dur 24
    db $25, $18 ; note F2 dur 24
    db $26, $18 ; note F#2 dur 24
    db $27, $18 ; note G2 dur 24
    db $28, $18 ; note G#2 dur 24
    db $29, $18 ; note A2 dur 24
    db $2A, $18 ; note A#2 dur 24
    db $2B, $18 ; note B2 dur 24
    db $30, $18 ; note C3 dur 24
    db $31, $18 ; note C#3 dur 24
    db $B0, $F3 ; jump $F3
    db $FF, $FF ; end

; sound track, 799 events after the header (E-0019: grammar C2, meaning C0)
Data_041_53B1:: ; heuristic: track stream of a sound record; C0
    db $03, $40, $02, $03 ; header: param=3 byte1=$40 volume=$02 byte3=$03
    db $FD, $F3 ; label 3
    db $A2, $40 ; duty2 $40
    db $A1, $03 ; duty $03
    db $A3, $0C ; mod $0C
    db $A0, $04 ; volume $04
    db $33, $06 ; note D#3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $39, $06 ; note A3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $39, $06 ; note A3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $39, $06 ; note A3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $39, $06 ; note A3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $39, $06 ; note A3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $39, $06 ; note A3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $39, $06 ; note A3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $39, $06 ; note A3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $39, $06 ; note A3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $39, $06 ; note A3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $39, $06 ; note A3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $39, $06 ; note A3 dur 6
    db $37, $06 ; note G3 dur 6
    db $34, $06 ; note E3 dur 6
    db $37, $06 ; note G3 dur 6
    db $34, $06 ; note E3 dur 6
    db $37, $06 ; note G3 dur 6
    db $34, $06 ; note E3 dur 6
    db $37, $06 ; note G3 dur 6
    db $34, $06 ; note E3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $32, $06 ; note D3 dur 6
    db $35, $06 ; note F3 dur 6
    db $32, $06 ; note D3 dur 6
    db $35, $06 ; note F3 dur 6
    db $32, $06 ; note D3 dur 6
    db $35, $06 ; note F3 dur 6
    db $32, $06 ; note D3 dur 6
    db $35, $06 ; note F3 dur 6
    db $32, $06 ; note D3 dur 6
    db $35, $06 ; note F3 dur 6
    db $32, $06 ; note D3 dur 6
    db $35, $06 ; note F3 dur 6
    db $32, $06 ; note D3 dur 6
    db $35, $06 ; note F3 dur 6
    db $32, $06 ; note D3 dur 6
    db $34, $06 ; note E3 dur 6
    db $31, $06 ; note C#3 dur 6
    db $34, $06 ; note E3 dur 6
    db $31, $06 ; note C#3 dur 6
    db $34, $06 ; note E3 dur 6
    db $31, $06 ; note C#3 dur 6
    db $34, $06 ; note E3 dur 6
    db $31, $06 ; note C#3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $30, $06 ; note C3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $30, $06 ; note C3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $30, $06 ; note C3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $30, $06 ; note C3 dur 6
    db $32, $06 ; note D3 dur 6
    db $2B, $06 ; note B2 dur 6
    db $32, $06 ; note D3 dur 6
    db $2B, $06 ; note B2 dur 6
    db $32, $06 ; note D3 dur 6
    db $2B, $06 ; note B2 dur 6
    db $32, $06 ; note D3 dur 6
    db $2B, $06 ; note B2 dur 6
    db $32, $06 ; note D3 dur 6
    db $2B, $06 ; note B2 dur 6
    db $32, $06 ; note D3 dur 6
    db $2B, $06 ; note B2 dur 6
    db $32, $06 ; note D3 dur 6
    db $2B, $06 ; note B2 dur 6
    db $32, $06 ; note D3 dur 6
    db $2B, $06 ; note B2 dur 6
    db $34, $06 ; note E3 dur 6
    db $30, $06 ; note C3 dur 6
    db $34, $06 ; note E3 dur 6
    db $30, $06 ; note C3 dur 6
    db $34, $06 ; note E3 dur 6
    db $30, $06 ; note C3 dur 6
    db $34, $06 ; note E3 dur 6
    db $30, $06 ; note C3 dur 6
    db $34, $06 ; note E3 dur 6
    db $30, $06 ; note C3 dur 6
    db $34, $06 ; note E3 dur 6
    db $30, $06 ; note C3 dur 6
    db $34, $06 ; note E3 dur 6
    db $30, $06 ; note C3 dur 6
    db $34, $06 ; note E3 dur 6
    db $30, $06 ; note C3 dur 6
    db $34, $06 ; note E3 dur 6
    db $30, $06 ; note C3 dur 6
    db $34, $06 ; note E3 dur 6
    db $30, $06 ; note C3 dur 6
    db $34, $06 ; note E3 dur 6
    db $30, $06 ; note C3 dur 6
    db $34, $06 ; note E3 dur 6
    db $30, $06 ; note C3 dur 6
    db $1F, $06 ; rest-note $1F dur 6
    db $A0, $06 ; volume $06
    db $32, $06 ; note D3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $42, $06 ; note D4 dur 6
    db $32, $06 ; note D3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $A2, $FF ; duty2 $FF
    db $A1, $0B ; duty $0B
    db $A0, $02 ; volume $02
    db $27, $24 ; note G2 dur 36
    db $A0, $04 ; volume $04
    db $27, $0C ; note G2 dur 12
    db $A0, $02 ; volume $02
    db $22, $24 ; note D2 dur 36
    db $A0, $04 ; volume $04
    db $22, $0C ; note D2 dur 12
    db $A0, $02 ; volume $02
    db $17, $24 ; note G1 dur 36
    db $A0, $04 ; volume $04
    db $17, $0C ; note G1 dur 12
    db $A2, $30 ; duty2 $30
    db $A1, $03 ; duty $03
    db $A0, $04 ; volume $04
    db $33, $06 ; note D#3 dur 6
    db $A0, $06 ; volume $06
    db $33, $06 ; note D#3 dur 6
    db $A0, $04 ; volume $04
    db $33, $06 ; note D#3 dur 6
    db $A0, $06 ; volume $06
    db $33, $06 ; note D#3 dur 6
    db $A0, $04 ; volume $04
    db $36, $06 ; note F#3 dur 6
    db $A0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $A0, $04 ; volume $04
    db $36, $06 ; note F#3 dur 6
    db $A0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $A0, $04 ; volume $04
    db $33, $06 ; note D#3 dur 6
    db $A0, $06 ; volume $06
    db $33, $06 ; note D#3 dur 6
    db $A0, $04 ; volume $04
    db $33, $06 ; note D#3 dur 6
    db $A0, $06 ; volume $06
    db $33, $06 ; note D#3 dur 6
    db $A0, $04 ; volume $04
    db $36, $06 ; note F#3 dur 6
    db $A0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $A0, $04 ; volume $04
    db $36, $06 ; note F#3 dur 6
    db $A0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $A0, $04 ; volume $04
    db $33, $06 ; note D#3 dur 6
    db $A0, $06 ; volume $06
    db $33, $06 ; note D#3 dur 6
    db $A0, $04 ; volume $04
    db $33, $06 ; note D#3 dur 6
    db $A0, $06 ; volume $06
    db $33, $06 ; note D#3 dur 6
    db $A0, $04 ; volume $04
    db $36, $06 ; note F#3 dur 6
    db $A0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $A0, $04 ; volume $04
    db $36, $06 ; note F#3 dur 6
    db $A0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $A0, $04 ; volume $04
    db $34, $06 ; note E3 dur 6
    db $A0, $06 ; volume $06
    db $34, $06 ; note E3 dur 6
    db $A0, $04 ; volume $04
    db $34, $06 ; note E3 dur 6
    db $A0, $06 ; volume $06
    db $34, $06 ; note E3 dur 6
    db $A0, $04 ; volume $04
    db $37, $06 ; note G3 dur 6
    db $A0, $06 ; volume $06
    db $37, $06 ; note G3 dur 6
    db $A0, $04 ; volume $04
    db $37, $06 ; note G3 dur 6
    db $A0, $06 ; volume $06
    db $37, $06 ; note G3 dur 6
    db $A0, $04 ; volume $04
    db $34, $06 ; note E3 dur 6
    db $A0, $06 ; volume $06
    db $34, $06 ; note E3 dur 6
    db $A0, $04 ; volume $04
    db $34, $06 ; note E3 dur 6
    db $A0, $06 ; volume $06
    db $34, $06 ; note E3 dur 6
    db $A0, $04 ; volume $04
    db $37, $06 ; note G3 dur 6
    db $A0, $06 ; volume $06
    db $37, $06 ; note G3 dur 6
    db $A0, $04 ; volume $04
    db $37, $06 ; note G3 dur 6
    db $A0, $06 ; volume $06
    db $37, $06 ; note G3 dur 6
    db $A0, $04 ; volume $04
    db $34, $06 ; note E3 dur 6
    db $A0, $06 ; volume $06
    db $34, $06 ; note E3 dur 6
    db $A0, $04 ; volume $04
    db $34, $06 ; note E3 dur 6
    db $A0, $06 ; volume $06
    db $34, $06 ; note E3 dur 6
    db $A0, $04 ; volume $04
    db $37, $06 ; note G3 dur 6
    db $A0, $06 ; volume $06
    db $37, $06 ; note G3 dur 6
    db $A0, $04 ; volume $04
    db $37, $06 ; note G3 dur 6
    db $A0, $06 ; volume $06
    db $37, $06 ; note G3 dur 6
    db $A0, $04 ; volume $04
    db $35, $06 ; note F3 dur 6
    db $A0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $A0, $04 ; volume $04
    db $35, $06 ; note F3 dur 6
    db $A0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $A0, $04 ; volume $04
    db $38, $06 ; note G#3 dur 6
    db $A0, $06 ; volume $06
    db $38, $06 ; note G#3 dur 6
    db $A0, $04 ; volume $04
    db $38, $06 ; note G#3 dur 6
    db $A0, $06 ; volume $06
    db $38, $06 ; note G#3 dur 6
    db $A0, $04 ; volume $04
    db $35, $06 ; note F3 dur 6
    db $A0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $A0, $04 ; volume $04
    db $35, $06 ; note F3 dur 6
    db $A0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $A0, $04 ; volume $04
    db $38, $06 ; note G#3 dur 6
    db $A0, $06 ; volume $06
    db $38, $06 ; note G#3 dur 6
    db $A0, $04 ; volume $04
    db $38, $06 ; note G#3 dur 6
    db $A0, $06 ; volume $06
    db $38, $06 ; note G#3 dur 6
    db $A0, $04 ; volume $04
    db $35, $06 ; note F3 dur 6
    db $A0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $A0, $04 ; volume $04
    db $35, $06 ; note F3 dur 6
    db $A0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $A0, $04 ; volume $04
    db $38, $06 ; note G#3 dur 6
    db $A0, $06 ; volume $06
    db $38, $06 ; note G#3 dur 6
    db $A0, $04 ; volume $04
    db $38, $06 ; note G#3 dur 6
    db $A0, $06 ; volume $06
    db $38, $06 ; note G#3 dur 6
    db $A0, $04 ; volume $04
    db $32, $06 ; note D3 dur 6
    db $A0, $06 ; volume $06
    db $32, $06 ; note D3 dur 6
    db $A0, $04 ; volume $04
    db $32, $06 ; note D3 dur 6
    db $A0, $06 ; volume $06
    db $32, $06 ; note D3 dur 6
    db $A0, $04 ; volume $04
    db $36, $06 ; note F#3 dur 6
    db $A0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $A0, $04 ; volume $04
    db $36, $06 ; note F#3 dur 6
    db $A0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $A0, $04 ; volume $04
    db $32, $06 ; note D3 dur 6
    db $A0, $06 ; volume $06
    db $32, $06 ; note D3 dur 6
    db $A0, $04 ; volume $04
    db $32, $06 ; note D3 dur 6
    db $A0, $06 ; volume $06
    db $32, $06 ; note D3 dur 6
    db $A0, $04 ; volume $04
    db $36, $06 ; note F#3 dur 6
    db $A0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $A0, $04 ; volume $04
    db $36, $06 ; note F#3 dur 6
    db $A0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $A0, $04 ; volume $04
    db $32, $06 ; note D3 dur 6
    db $A0, $06 ; volume $06
    db $32, $06 ; note D3 dur 6
    db $A0, $04 ; volume $04
    db $32, $06 ; note D3 dur 6
    db $A0, $06 ; volume $06
    db $32, $06 ; note D3 dur 6
    db $A0, $04 ; volume $04
    db $36, $06 ; note F#3 dur 6
    db $A0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $A0, $04 ; volume $04
    db $36, $06 ; note F#3 dur 6
    db $A0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $1F, $3C ; rest-note $1F dur 60
    db $3B, $18 ; note B3 dur 24
    db $45, $0C ; note F4 dur 12
    db $A1, $03 ; duty $03
    db $A2, $FF ; duty2 $FF
    db $A0, $02 ; volume $02
    db $37, $0B ; note G3 dur 11
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $04 ; volume $04
    db $37, $0C ; note G3 dur 12
    db $A3, $FE ; mod $FE
    db $A0, $02 ; volume $02
    db $41, $60 ; note C#4 dur 96
    db $A3, $08 ; mod $08
    db $A0, $04 ; volume $04
    db $41, $18 ; note C#4 dur 24
    db $A3, $0C ; mod $0C
    db $A0, $02 ; volume $02
    db $31, $0B ; note C#3 dur 11
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $04 ; volume $04
    db $31, $0C ; note C#3 dur 12
    db $A0, $02 ; volume $02
    db $37, $0B ; note G3 dur 11
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $04 ; volume $04
    db $37, $0C ; note G3 dur 12
    db $A0, $02 ; volume $02
    db $30, $A8 ; note C3 dur 168
    db $A0, $02 ; volume $02
    db $31, $18 ; note C#3 dur 24
    db $32, $18 ; note D3 dur 24
    db $31, $18 ; note C#3 dur 24
    db $30, $18 ; note C3 dur 24
    db $2B, $18 ; note B2 dur 24
    db $2A, $48 ; note A#2 dur 72
    db $33, $18 ; note D#3 dur 24
    db $31, $18 ; note C#3 dur 24
    db $27, $18 ; note G2 dur 24
    db $2A, $18 ; note A#2 dur 24
    db $29, $18 ; note A2 dur 24
    db $28, $18 ; note G#2 dur 24
    db $27, $18 ; note G2 dur 24
    db $26, $18 ; note F#2 dur 24
    db $1B, $18 ; note B1 dur 24
    db $20, $18 ; note C2 dur 24
    db $21, $18 ; note C#2 dur 24
    db $22, $18 ; note D2 dur 24
    db $28, $18 ; note G#2 dur 24
    db $29, $18 ; note A2 dur 24
    db $2A, $18 ; note A#2 dur 24
    db $2B, $18 ; note B2 dur 24
    db $30, $18 ; note C3 dur 24
    db $31, $18 ; note C#3 dur 24
    db $32, $18 ; note D3 dur 24
    db $31, $18 ; note C#3 dur 24
    db $30, $18 ; note C3 dur 24
    db $2B, $0C ; note B2 dur 12
    db $A0, $06 ; volume $06
    db $2B, $0C ; note B2 dur 12
    db $A0, $02 ; volume $02
    db $25, $78 ; note F2 dur 120
    db $A3, $00 ; mod $00
    db $A0, $04 ; volume $04
    db $25, $30 ; note F2 dur 48
    db $A3, $0C ; mod $0C
    db $A0, $02 ; volume $02
    db $33, $24 ; note D#3 dur 36
    db $A0, $04 ; volume $04
    db $33, $0C ; note D#3 dur 12
    db $A0, $02 ; volume $02
    db $33, $24 ; note D#3 dur 36
    db $A0, $04 ; volume $04
    db $33, $0C ; note D#3 dur 12
    db $A0, $02 ; volume $02
    db $32, $0C ; note D3 dur 12
    db $A0, $06 ; volume $06
    db $32, $0C ; note D3 dur 12
    db $A0, $02 ; volume $02
    db $28, $90 ; note G#2 dur 144
    db $A3, $00 ; mod $00
    db $A0, $04 ; volume $04
    db $28, $18 ; note G#2 dur 24
    db $A3, $0C ; mod $0C
    db $A0, $02 ; volume $02
    db $36, $24 ; note F#3 dur 36
    db $A0, $04 ; volume $04
    db $36, $0C ; note F#3 dur 12
    db $A0, $02 ; volume $02
    db $36, $24 ; note F#3 dur 36
    db $A0, $04 ; volume $04
    db $36, $0C ; note F#3 dur 12
    db $A0, $02 ; volume $02
    db $31, $05 ; note C#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $31, $06 ; note C#3 dur 6
    db $A0, $02 ; volume $02
    db $31, $05 ; note C#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $31, $06 ; note C#3 dur 6
    db $A0, $02 ; volume $02
    db $36, $05 ; note F#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $A0, $02 ; volume $02
    db $36, $05 ; note F#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $A0, $02 ; volume $02
    db $31, $05 ; note C#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $31, $06 ; note C#3 dur 6
    db $A0, $02 ; volume $02
    db $31, $05 ; note C#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $31, $06 ; note C#3 dur 6
    db $A0, $02 ; volume $02
    db $36, $05 ; note F#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $A0, $02 ; volume $02
    db $36, $05 ; note F#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $A0, $02 ; volume $02
    db $31, $05 ; note C#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $31, $06 ; note C#3 dur 6
    db $A0, $02 ; volume $02
    db $31, $05 ; note C#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $31, $06 ; note C#3 dur 6
    db $A0, $02 ; volume $02
    db $36, $05 ; note F#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $A0, $02 ; volume $02
    db $36, $05 ; note F#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $A0, $02 ; volume $02
    db $31, $05 ; note C#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $31, $06 ; note C#3 dur 6
    db $A0, $02 ; volume $02
    db $31, $05 ; note C#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $31, $06 ; note C#3 dur 6
    db $A0, $02 ; volume $02
    db $36, $05 ; note F#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $A0, $02 ; volume $02
    db $36, $05 ; note F#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $A0, $02 ; volume $02
    db $31, $05 ; note C#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $31, $06 ; note C#3 dur 6
    db $A0, $02 ; volume $02
    db $31, $05 ; note C#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $31, $06 ; note C#3 dur 6
    db $A0, $02 ; volume $02
    db $36, $05 ; note F#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $A0, $02 ; volume $02
    db $36, $05 ; note F#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $A0, $02 ; volume $02
    db $31, $05 ; note C#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $31, $06 ; note C#3 dur 6
    db $A0, $02 ; volume $02
    db $31, $05 ; note C#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $31, $06 ; note C#3 dur 6
    db $A0, $02 ; volume $02
    db $36, $05 ; note F#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $A0, $02 ; volume $02
    db $36, $05 ; note F#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $A0, $02 ; volume $02
    db $30, $05 ; note C3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $30, $06 ; note C3 dur 6
    db $A0, $02 ; volume $02
    db $30, $05 ; note C3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $30, $06 ; note C3 dur 6
    db $A0, $02 ; volume $02
    db $35, $05 ; note F3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $A0, $02 ; volume $02
    db $35, $05 ; note F3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $A0, $02 ; volume $02
    db $30, $05 ; note C3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $30, $06 ; note C3 dur 6
    db $A0, $02 ; volume $02
    db $30, $05 ; note C3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $30, $06 ; note C3 dur 6
    db $A0, $02 ; volume $02
    db $35, $05 ; note F3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $A0, $02 ; volume $02
    db $35, $05 ; note F3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $A0, $02 ; volume $02
    db $30, $05 ; note C3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $30, $06 ; note C3 dur 6
    db $A0, $02 ; volume $02
    db $30, $05 ; note C3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $30, $06 ; note C3 dur 6
    db $A0, $02 ; volume $02
    db $35, $05 ; note F3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $A0, $02 ; volume $02
    db $35, $05 ; note F3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $A0, $02 ; volume $02
    db $30, $05 ; note C3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $30, $06 ; note C3 dur 6
    db $A0, $02 ; volume $02
    db $30, $05 ; note C3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $30, $06 ; note C3 dur 6
    db $A0, $02 ; volume $02
    db $35, $05 ; note F3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $A0, $02 ; volume $02
    db $35, $05 ; note F3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $A0, $02 ; volume $02
    db $30, $05 ; note C3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $30, $06 ; note C3 dur 6
    db $A0, $02 ; volume $02
    db $30, $05 ; note C3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $30, $06 ; note C3 dur 6
    db $A0, $02 ; volume $02
    db $35, $05 ; note F3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $A0, $02 ; volume $02
    db $35, $05 ; note F3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $A0, $02 ; volume $02
    db $30, $05 ; note C3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $30, $06 ; note C3 dur 6
    db $A0, $02 ; volume $02
    db $30, $05 ; note C3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $30, $06 ; note C3 dur 6
    db $A0, $02 ; volume $02
    db $35, $05 ; note F3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $A0, $02 ; volume $02
    db $35, $05 ; note F3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $A1, $03 ; duty $03
    db $A0, $06 ; volume $06
    db $39, $0C ; note A3 dur 12
    db $38, $18 ; note G#3 dur 24
    db $3B, $18 ; note B3 dur 24
    db $42, $18 ; note D4 dur 24
    db $45, $0C ; note F4 dur 12
    db $A1, $0B ; duty $0B
    db $A2, $50 ; duty2 $50
    db $A0, $02 ; volume $02
    db $1A, $0C ; note A#1 dur 12
    db $A0, $04 ; volume $04
    db $1A, $24 ; note A#1 dur 36
    db $A0, $02 ; volume $02
    db $17, $18 ; note G1 dur 24
    db $A0, $04 ; volume $04
    db $17, $0C ; note G1 dur 12
    db $A0, $06 ; volume $06
    db $17, $30 ; note G1 dur 48
    db $A1, $03 ; duty $03
    db $A0, $06 ; volume $06
    db $37, $18 ; note G3 dur 24
    db $32, $18 ; note D3 dur 24
    db $29, $24 ; note A2 dur 36
    db $A0, $06 ; volume $06
    db $32, $18 ; note D3 dur 24
    db $33, $18 ; note D#3 dur 24
    db $34, $18 ; note E3 dur 24
    db $A1, $0B ; duty $0B
    db $A0, $02 ; volume $02
    db $17, $0C ; note G1 dur 12
    db $A0, $04 ; volume $04
    db $17, $24 ; note G1 dur 36
    db $A0, $02 ; volume $02
    db $14, $18 ; note E1 dur 24
    db $A0, $04 ; volume $04
    db $14, $0C ; note E1 dur 12
    db $A0, $06 ; volume $06
    db $14, $3C ; note E1 dur 60
    db $A1, $03 ; duty $03
    db $A0, $06 ; volume $06
    db $3B, $18 ; note B3 dur 24
    db $40, $18 ; note C4 dur 24
    db $B0, $F3 ; jump $F3
    db $FF, $FF ; end

; sound track, 582 events after the header (E-0019: grammar C2, meaning C0)
Data_041_59F3:: ; heuristic: track stream of a sound record; C0
    db $03, $01, $09, $00 ; header: param=3 byte1=$01 volume=$09 byte3=$00
    db $FD, $F3 ; label 3
    db $C3, $5F ; env $5F
    db $A3, $0A ; mod $0A
    db $A0, $0D ; volume $0D
    db $1B, $06 ; note B1 dur 6
    db $20, $06 ; note C2 dur 6
    db $1B, $06 ; note B1 dur 6
    db $20, $06 ; note C2 dur 6
    db $1B, $06 ; note B1 dur 6
    db $20, $06 ; note C2 dur 6
    db $1B, $06 ; note B1 dur 6
    db $20, $06 ; note C2 dur 6
    db $1B, $06 ; note B1 dur 6
    db $20, $06 ; note C2 dur 6
    db $1B, $06 ; note B1 dur 6
    db $20, $06 ; note C2 dur 6
    db $1B, $06 ; note B1 dur 6
    db $20, $06 ; note C2 dur 6
    db $1B, $06 ; note B1 dur 6
    db $20, $06 ; note C2 dur 6
    db $19, $06 ; note A1 dur 6
    db $20, $06 ; note C2 dur 6
    db $19, $06 ; note A1 dur 6
    db $20, $06 ; note C2 dur 6
    db $19, $06 ; note A1 dur 6
    db $20, $06 ; note C2 dur 6
    db $19, $06 ; note A1 dur 6
    db $20, $06 ; note C2 dur 6
    db $19, $06 ; note A1 dur 6
    db $20, $06 ; note C2 dur 6
    db $19, $06 ; note A1 dur 6
    db $20, $06 ; note C2 dur 6
    db $19, $06 ; note A1 dur 6
    db $20, $06 ; note C2 dur 6
    db $19, $06 ; note A1 dur 6
    db $20, $06 ; note C2 dur 6
    db $1B, $06 ; note B1 dur 6
    db $20, $06 ; note C2 dur 6
    db $1B, $06 ; note B1 dur 6
    db $20, $06 ; note C2 dur 6
    db $1B, $06 ; note B1 dur 6
    db $20, $06 ; note C2 dur 6
    db $1B, $06 ; note B1 dur 6
    db $20, $06 ; note C2 dur 6
    db $1B, $06 ; note B1 dur 6
    db $20, $06 ; note C2 dur 6
    db $1B, $06 ; note B1 dur 6
    db $20, $06 ; note C2 dur 6
    db $1B, $06 ; note B1 dur 6
    db $20, $06 ; note C2 dur 6
    db $1B, $06 ; note B1 dur 6
    db $20, $06 ; note C2 dur 6
    db $20, $06 ; note C2 dur 6
    db $22, $06 ; note D2 dur 6
    db $20, $06 ; note C2 dur 6
    db $22, $06 ; note D2 dur 6
    db $20, $06 ; note C2 dur 6
    db $22, $06 ; note D2 dur 6
    db $20, $06 ; note C2 dur 6
    db $22, $06 ; note D2 dur 6
    db $20, $06 ; note C2 dur 6
    db $22, $06 ; note D2 dur 6
    db $20, $06 ; note C2 dur 6
    db $22, $06 ; note D2 dur 6
    db $20, $06 ; note C2 dur 6
    db $22, $06 ; note D2 dur 6
    db $20, $06 ; note C2 dur 6
    db $22, $06 ; note D2 dur 6
    db $C3, $78 ; env $78
    db $A0, $0B ; volume $0B
    db $34, $60 ; note E3 dur 96
    db $33, $60 ; note D#3 dur 96
    db $34, $60 ; note E3 dur 96
    db $33, $48 ; note D#3 dur 72
    db $C1, $70 ; env $70
    db $A0, $07 ; volume $07
    db $33, $18 ; note D#3 dur 24
    db $C3, $68 ; env $68
    db $A2, $00 ; duty2 $00
    db $A0, $0B ; volume $0B
    db $34, $18 ; note E3 dur 24
    db $32, $30 ; note D3 dur 48
    db $30, $07 ; note C3 dur 7
    db $A0, $08 ; volume $08
    db $30, $11 ; note C3 dur 17
    db $A0, $0D ; volume $0D
    db $24, $18 ; note E2 dur 24
    db $A0, $0B ; volume $0B
    db $22, $11 ; note D2 dur 17
    db $A0, $08 ; volume $08
    db $22, $07 ; note D2 dur 7
    db $A0, $0D ; volume $0D
    db $27, $18 ; note G2 dur 24
    db $A0, $0B ; volume $0B
    db $25, $11 ; note F2 dur 17
    db $A0, $08 ; volume $08
    db $25, $07 ; note F2 dur 7
    db $C0, $FE ; env $FE
    db $A0, $09 ; volume $09
    db $24, $0C ; note E2 dur 12
    db $A0, $04 ; volume $04
    db $24, $0C ; note E2 dur 12
    db $A0, $09 ; volume $09
    db $24, $24 ; note E2 dur 36
    db $A0, $05 ; volume $05
    db $24, $0C ; note E2 dur 12
    db $A0, $09 ; volume $09
    db $24, $0C ; note E2 dur 12
    db $A0, $04 ; volume $04
    db $24, $0C ; note E2 dur 12
    db $A0, $09 ; volume $09
    db $23, $0C ; note D#2 dur 12
    db $A0, $04 ; volume $04
    db $23, $0C ; note D#2 dur 12
    db $A0, $09 ; volume $09
    db $23, $24 ; note D#2 dur 36
    db $A0, $05 ; volume $05
    db $23, $0C ; note D#2 dur 12
    db $A0, $09 ; volume $09
    db $23, $0C ; note D#2 dur 12
    db $A0, $04 ; volume $04
    db $23, $0C ; note D#2 dur 12
    db $A0, $09 ; volume $09
    db $C3, $78 ; env $78
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $A0, $0B ; volume $0B
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $A0, $0D ; volume $0D
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $A0, $0B ; volume $0B
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $A0, $0C ; volume $0C
    db $26, $06 ; note F#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $A0, $0A ; volume $0A
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $30, $06 ; note C3 dur 6
    db $28, $06 ; note G#2 dur 6
    db $30, $06 ; note C3 dur 6
    db $28, $06 ; note G#2 dur 6
    db $30, $06 ; note C3 dur 6
    db $28, $06 ; note G#2 dur 6
    db $30, $06 ; note C3 dur 6
    db $28, $06 ; note G#2 dur 6
    db $30, $06 ; note C3 dur 6
    db $28, $06 ; note G#2 dur 6
    db $30, $06 ; note C3 dur 6
    db $28, $06 ; note G#2 dur 6
    db $30, $06 ; note C3 dur 6
    db $28, $06 ; note G#2 dur 6
    db $30, $06 ; note C3 dur 6
    db $A0, $0C ; volume $0C
    db $28, $06 ; note G#2 dur 6
    db $30, $06 ; note C3 dur 6
    db $28, $06 ; note G#2 dur 6
    db $30, $06 ; note C3 dur 6
    db $28, $06 ; note G#2 dur 6
    db $30, $06 ; note C3 dur 6
    db $28, $06 ; note G#2 dur 6
    db $30, $06 ; note C3 dur 6
    db $28, $06 ; note G#2 dur 6
    db $30, $06 ; note C3 dur 6
    db $28, $06 ; note G#2 dur 6
    db $30, $06 ; note C3 dur 6
    db $28, $06 ; note G#2 dur 6
    db $30, $06 ; note C3 dur 6
    db $28, $06 ; note G#2 dur 6
    db $30, $06 ; note C3 dur 6
    db $28, $06 ; note G#2 dur 6
    db $30, $06 ; note C3 dur 6
    db $28, $06 ; note G#2 dur 6
    db $30, $06 ; note C3 dur 6
    db $28, $06 ; note G#2 dur 6
    db $30, $06 ; note C3 dur 6
    db $28, $06 ; note G#2 dur 6
    db $30, $06 ; note C3 dur 6
    db $28, $06 ; note G#2 dur 6
    db $30, $06 ; note C3 dur 6
    db $28, $06 ; note G#2 dur 6
    db $30, $06 ; note C3 dur 6
    db $28, $06 ; note G#2 dur 6
    db $30, $06 ; note C3 dur 6
    db $28, $06 ; note G#2 dur 6
    db $30, $06 ; note C3 dur 6
    db $28, $06 ; note G#2 dur 6
    db $30, $06 ; note C3 dur 6
    db $28, $06 ; note G#2 dur 6
    db $30, $06 ; note C3 dur 6
    db $28, $06 ; note G#2 dur 6
    db $30, $06 ; note C3 dur 6
    db $28, $06 ; note G#2 dur 6
    db $30, $06 ; note C3 dur 6
    db $A0, $0A ; volume $0A
    db $28, $06 ; note G#2 dur 6
    db $30, $06 ; note C3 dur 6
    db $28, $06 ; note G#2 dur 6
    db $30, $06 ; note C3 dur 6
    db $28, $06 ; note G#2 dur 6
    db $30, $06 ; note C3 dur 6
    db $28, $06 ; note G#2 dur 6
    db $30, $06 ; note C3 dur 6
    db $A0, $0C ; volume $0C
    db $26, $06 ; note F#2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $29, $06 ; note A2 dur 6
    db $32, $06 ; note D3 dur 6
    db $29, $06 ; note A2 dur 6
    db $32, $06 ; note D3 dur 6
    db $29, $06 ; note A2 dur 6
    db $32, $06 ; note D3 dur 6
    db $29, $06 ; note A2 dur 6
    db $32, $06 ; note D3 dur 6
    db $29, $06 ; note A2 dur 6
    db $32, $06 ; note D3 dur 6
    db $29, $06 ; note A2 dur 6
    db $32, $06 ; note D3 dur 6
    db $29, $06 ; note A2 dur 6
    db $32, $06 ; note D3 dur 6
    db $29, $06 ; note A2 dur 6
    db $32, $06 ; note D3 dur 6
    db $2B, $06 ; note B2 dur 6
    db $32, $06 ; note D3 dur 6
    db $2B, $06 ; note B2 dur 6
    db $32, $06 ; note D3 dur 6
    db $2B, $06 ; note B2 dur 6
    db $32, $06 ; note D3 dur 6
    db $2B, $06 ; note B2 dur 6
    db $32, $06 ; note D3 dur 6
    db $2B, $06 ; note B2 dur 6
    db $32, $06 ; note D3 dur 6
    db $2B, $06 ; note B2 dur 6
    db $32, $06 ; note D3 dur 6
    db $2B, $06 ; note B2 dur 6
    db $32, $06 ; note D3 dur 6
    db $2B, $06 ; note B2 dur 6
    db $32, $06 ; note D3 dur 6
    db $32, $06 ; note D3 dur 6
    db $35, $06 ; note F3 dur 6
    db $32, $06 ; note D3 dur 6
    db $35, $06 ; note F3 dur 6
    db $32, $06 ; note D3 dur 6
    db $35, $06 ; note F3 dur 6
    db $32, $06 ; note D3 dur 6
    db $35, $06 ; note F3 dur 6
    db $22, $06 ; note D2 dur 6
    db $25, $06 ; note F2 dur 6
    db $22, $06 ; note D2 dur 6
    db $25, $06 ; note F2 dur 6
    db $22, $06 ; note D2 dur 6
    db $25, $06 ; note F2 dur 6
    db $22, $06 ; note D2 dur 6
    db $25, $06 ; note F2 dur 6
    db $25, $06 ; note F2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $24, $06 ; note E2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $24, $06 ; note E2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $25, $06 ; note F2 dur 6
    db $22, $06 ; note D2 dur 6
    db $25, $06 ; note F2 dur 6
    db $22, $06 ; note D2 dur 6
    db $25, $06 ; note F2 dur 6
    db $22, $06 ; note D2 dur 6
    db $25, $06 ; note F2 dur 6
    db $22, $06 ; note D2 dur 6
    db $25, $06 ; note F2 dur 6
    db $22, $06 ; note D2 dur 6
    db $25, $06 ; note F2 dur 6
    db $22, $06 ; note D2 dur 6
    db $25, $06 ; note F2 dur 6
    db $22, $06 ; note D2 dur 6
    db $25, $06 ; note F2 dur 6
    db $21, $06 ; note C#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $21, $06 ; note C#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $21, $06 ; note C#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $21, $06 ; note C#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $21, $06 ; note C#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $21, $06 ; note C#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $21, $06 ; note C#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $21, $06 ; note C#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $22, $06 ; note D2 dur 6
    db $25, $06 ; note F2 dur 6
    db $22, $06 ; note D2 dur 6
    db $25, $06 ; note F2 dur 6
    db $22, $06 ; note D2 dur 6
    db $25, $06 ; note F2 dur 6
    db $22, $06 ; note D2 dur 6
    db $25, $06 ; note F2 dur 6
    db $22, $06 ; note D2 dur 6
    db $25, $06 ; note F2 dur 6
    db $22, $06 ; note D2 dur 6
    db $25, $06 ; note F2 dur 6
    db $22, $06 ; note D2 dur 6
    db $25, $06 ; note F2 dur 6
    db $22, $06 ; note D2 dur 6
    db $25, $06 ; note F2 dur 6
    db $21, $06 ; note C#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $21, $06 ; note C#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $21, $06 ; note C#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $21, $06 ; note C#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $21, $06 ; note C#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $21, $06 ; note C#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $21, $06 ; note C#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $21, $06 ; note C#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $B0, $F3 ; jump $F3
    db $FF, $FF ; end

; sound track, 193 events after the header (E-0019: grammar C2, meaning C0)
Data_041_5E83:: ; heuristic: track stream of a sound record; C0
    db $03, $00, $09, $00 ; header: param=3 byte1=$00 volume=$09 byte3=$00
    db $FD, $F3 ; label 3
    db $A3, $FE ; mod $FE
    db $C3, $48 ; env $48
    db $A2, $02 ; duty2 $02
    db $1F, $18 ; rest-note $1F dur 24
    db $A0, $0B ; volume $0B
    db $39, $18 ; note A3 dur 24
    db $44, $18 ; note E4 dur 24
    db $40, $18 ; note C4 dur 24
    db $A0, $09 ; volume $09
    db $C0, $FE ; env $FE
    db $3B, $5A ; note B3 dur 90
    db $C1, $5F ; env $5F
    db $A0, $05 ; volume $05
    db $3B, $1E ; note B3 dur 30
    db $C3, $48 ; env $48
    db $A0, $0B ; volume $0B
    db $39, $18 ; note A3 dur 24
    db $44, $18 ; note E4 dur 24
    db $40, $18 ; note C4 dur 24
    db $C3, $78 ; env $78
    db $46, $5A ; note F#4 dur 90
    db $C1, $7F ; env $7F
    db $A0, $08 ; volume $08
    db $46, $1E ; note F#4 dur 30
    db $C1, $7F ; env $7F
    db $A3, $0A ; mod $0A
    db $A0, $0B ; volume $0B
    db $3B, $06 ; note B3 dur 6
    db $40, $06 ; note C4 dur 6
    db $3B, $06 ; note B3 dur 6
    db $39, $06 ; note A3 dur 6
    db $C1, $1F ; env $1F
    db $3B, $05 ; note B3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $3B, $06 ; note B3 dur 6
    db $A0, $0B ; volume $0B
    db $42, $05 ; note D4 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $3B, $06 ; note B3 dur 6
    db $A0, $0B ; volume $0B
    db $3B, $05 ; note B3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $42, $06 ; note D4 dur 6
    db $A0, $02 ; volume $02
    db $3B, $24 ; note B3 dur 36
    db $C3, $7F ; env $7F
    db $A0, $0B ; volume $0B
    db $3A, $06 ; note A#3 dur 6
    db $3B, $06 ; note B3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $C1, $1F ; env $1F
    db $3A, $05 ; note A#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $3A, $06 ; note A#3 dur 6
    db $A0, $0B ; volume $0B
    db $41, $05 ; note C#4 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $3A, $06 ; note A#3 dur 6
    db $A0, $0B ; volume $0B
    db $3A, $05 ; note A#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $41, $06 ; note C#4 dur 6
    db $A0, $02 ; volume $02
    db $3A, $24 ; note A#3 dur 36
    db $C1, $7F ; env $7F
    db $A0, $0B ; volume $0B
    db $3B, $06 ; note B3 dur 6
    db $40, $06 ; note C4 dur 6
    db $3B, $06 ; note B3 dur 6
    db $39, $06 ; note A3 dur 6
    db $C1, $1F ; env $1F
    db $3B, $05 ; note B3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $3B, $06 ; note B3 dur 6
    db $A0, $0B ; volume $0B
    db $42, $05 ; note D4 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $3B, $06 ; note B3 dur 6
    db $A0, $0B ; volume $0B
    db $3B, $05 ; note B3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $42, $06 ; note D4 dur 6
    db $A0, $02 ; volume $02
    db $3B, $24 ; note B3 dur 36
    db $C1, $7F ; env $7F
    db $A0, $0B ; volume $0B
    db $3A, $06 ; note A#3 dur 6
    db $3B, $06 ; note B3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $C1, $1F ; env $1F
    db $3A, $05 ; note A#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $3A, $06 ; note A#3 dur 6
    db $A0, $0B ; volume $0B
    db $41, $05 ; note C#4 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $3A, $06 ; note A#3 dur 6
    db $A0, $0B ; volume $0B
    db $3A, $05 ; note A#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $41, $06 ; note C#4 dur 6
    db $A0, $02 ; volume $02
    db $3A, $0C ; note A#3 dur 12
    db $A2, $01 ; duty2 $01
    db $C3, $78 ; env $78
    db $A0, $0B ; volume $0B
    db $39, $18 ; note A3 dur 24
    db $37, $30 ; note G3 dur 48
    db $35, $18 ; note F3 dur 24
    db $32, $30 ; note D3 dur 48
    db $35, $2C ; note F3 dur 44
    db $C1, $7F ; env $7F
    db $A0, $06 ; volume $06
    db $35, $04 ; note F3 dur 4
    db $C0, $FE ; env $FE
    db $A0, $0A ; volume $0A
    db $36, $60 ; note F#3 dur 96
    db $37, $48 ; note G3 dur 72
    db $C1, $7F ; env $7F
    db $A0, $06 ; volume $06
    db $37, $18 ; note G3 dur 24
    db $FD, $F0 ; label 0
    db $C0, $FE ; env $FE
    db $A0, $09 ; volume $09
    db $2B, $C0 ; note B2 dur 192
    db $32, $90 ; note D3 dur 144
    db $C1, $7F ; env $7F
    db $A0, $07 ; volume $07
    db $32, $30 ; note D3 dur 48
    db $B1, $F0 ; repeat $F0
    db $C0, $FE ; env $FE
    db $A0, $0A ; volume $0A
    db $35, $A8 ; note F3 dur 168
    db $A3, $00 ; mod $00
    db $A0, $08 ; volume $08
    db $35, $A8 ; note F3 dur 168
    db $C1, $7F ; env $7F
    db $A0, $04 ; volume $04
    db $35, $30 ; note F3 dur 48
    db $C0, $FE ; env $FE
    db $A3, $0C ; mod $0C
    db $A0, $0A ; volume $0A
    db $32, $60 ; note D3 dur 96
    db $35, $60 ; note F3 dur 96
    db $A3, $0F ; mod $0F
    db $38, $60 ; note G#3 dur 96
    db $A3, $0C ; mod $0C
    db $3B, $30 ; note B3 dur 48
    db $2B, $30 ; note B2 dur 48
    db $FD, $F0 ; label 0
    db $A0, $09 ; volume $09
    db $C0, $FE ; env $FE
    db $31, $54 ; note C#3 dur 84
    db $C1, $7F ; env $7F
    db $A0, $07 ; volume $07
    db $31, $0C ; note C#3 dur 12
    db $B3, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $C0, $FE ; env $FE
    db $A0, $09 ; volume $09
    db $34, $60 ; note E3 dur 96
    db $31, $48 ; note C#3 dur 72
    db $C1, $7F ; env $7F
    db $A0, $07 ; volume $07
    db $31, $18 ; note C#3 dur 24
    db $B1, $F0 ; repeat $F0
    db $C0, $FE ; env $FE
    db $A0, $08 ; volume $08
    db $2A, $A8 ; note A#2 dur 168
    db $A3, $00 ; mod $00
    db $C0, $FE ; env $FE
    db $A0, $07 ; volume $07
    db $2A, $A8 ; note A#2 dur 168
    db $C1, $7F ; env $7F
    db $A0, $04 ; volume $04
    db $2A, $30 ; note A#2 dur 48
    db $B0, $F3 ; jump $F3
    db $FF, $FF ; end

; sound track, 408 events after the header (E-0019: grammar C2, meaning C0)
Data_041_6009:: ; heuristic: track stream of a sound record; C0
    db $03, $FF, $02, $0E ; header: param=3 byte1=$FF volume=$02 byte3=$0E
    db $FD, $F3 ; label 3
    db $A1, $0B ; duty $0B
    db $A2, $FF ; duty2 $FF
    db $A0, $04 ; volume $04
    db $34, $60 ; note E3 dur 96
    db $36, $60 ; note F#3 dur 96
    db $34, $60 ; note E3 dur 96
    db $29, $54 ; note A2 dur 84
    db $A0, $06 ; volume $06
    db $29, $0C ; note A2 dur 12
    db $A7, $18 ; wait $18
    db $A1, $0F ; duty $0F
    db $A2, $15 ; duty2 $15
    db $A0, $02 ; volume $02
    db $47, $06 ; note G4 dur 6
    db $49, $06 ; note A4 dur 6
    db $47, $06 ; note G4 dur 6
    db $45, $06 ; note F4 dur 6
    db $A2, $0F ; duty2 $0F
    db $47, $06 ; note G4 dur 6
    db $A0, $06 ; volume $06
    db $47, $06 ; note G4 dur 6
    db $A0, $02 ; volume $02
    db $4B, $06 ; note B4 dur 6
    db $A0, $06 ; volume $06
    db $4B, $06 ; note B4 dur 6
    db $A0, $02 ; volume $02
    db $47, $06 ; note G4 dur 6
    db $A0, $06 ; volume $06
    db $47, $2A ; note G4 dur 42
    db $A2, $15 ; duty2 $15
    db $A0, $02 ; volume $02
    db $46, $06 ; note F#4 dur 6
    db $48, $06 ; note G#4 dur 6
    db $46, $06 ; note F#4 dur 6
    db $44, $06 ; note E4 dur 6
    db $A2, $0F ; duty2 $0F
    db $46, $06 ; note F#4 dur 6
    db $A0, $06 ; volume $06
    db $46, $06 ; note F#4 dur 6
    db $A0, $02 ; volume $02
    db $4A, $06 ; note A#4 dur 6
    db $A0, $06 ; volume $06
    db $4A, $06 ; note A#4 dur 6
    db $A0, $02 ; volume $02
    db $46, $06 ; note F#4 dur 6
    db $A0, $06 ; volume $06
    db $46, $2A ; note F#4 dur 42
    db $A2, $15 ; duty2 $15
    db $A0, $02 ; volume $02
    db $47, $06 ; note G4 dur 6
    db $49, $06 ; note A4 dur 6
    db $47, $06 ; note G4 dur 6
    db $45, $06 ; note F4 dur 6
    db $A2, $0F ; duty2 $0F
    db $47, $06 ; note G4 dur 6
    db $A0, $06 ; volume $06
    db $47, $06 ; note G4 dur 6
    db $A0, $02 ; volume $02
    db $4B, $06 ; note B4 dur 6
    db $A0, $06 ; volume $06
    db $4B, $06 ; note B4 dur 6
    db $A0, $02 ; volume $02
    db $47, $06 ; note G4 dur 6
    db $A0, $06 ; volume $06
    db $47, $2A ; note G4 dur 42
    db $A2, $15 ; duty2 $15
    db $A0, $02 ; volume $02
    db $46, $06 ; note F#4 dur 6
    db $48, $06 ; note G#4 dur 6
    db $46, $06 ; note F#4 dur 6
    db $44, $06 ; note E4 dur 6
    db $A2, $0F ; duty2 $0F
    db $46, $06 ; note F#4 dur 6
    db $A0, $06 ; volume $06
    db $46, $06 ; note F#4 dur 6
    db $A0, $02 ; volume $02
    db $4A, $06 ; note A#4 dur 6
    db $A0, $06 ; volume $06
    db $4A, $06 ; note A#4 dur 6
    db $A0, $02 ; volume $02
    db $46, $06 ; note F#4 dur 6
    db $A0, $06 ; volume $06
    db $46, $12 ; note F#4 dur 18
    db $A1, $0B ; duty $0B
    db $A2, $FF ; duty2 $FF
    db $A0, $04 ; volume $04
    db $3A, $06 ; note A#3 dur 6
    db $41, $06 ; note C#4 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $41, $06 ; note C#4 dur 6
    db $38, $06 ; note G#3 dur 6
    db $3B, $06 ; note B3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $3B, $06 ; note B3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $3B, $06 ; note B3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $3B, $06 ; note B3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $39, $06 ; note A3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $39, $06 ; note A3 dur 6
    db $35, $06 ; note F3 dur 6
    db $39, $06 ; note A3 dur 6
    db $35, $06 ; note F3 dur 6
    db $39, $06 ; note A3 dur 6
    db $35, $06 ; note F3 dur 6
    db $39, $06 ; note A3 dur 6
    db $35, $06 ; note F3 dur 6
    db $39, $06 ; note A3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $40, $06 ; note C4 dur 6
    db $38, $06 ; note G#3 dur 6
    db $40, $06 ; note C4 dur 6
    db $38, $06 ; note G#3 dur 6
    db $40, $06 ; note C4 dur 6
    db $38, $06 ; note G#3 dur 6
    db $40, $06 ; note C4 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $41, $06 ; note C#4 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $41, $06 ; note C#4 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $41, $06 ; note C#4 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $41, $06 ; note C#4 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $41, $06 ; note C#4 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $41, $06 ; note C#4 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $41, $06 ; note C#4 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $41, $06 ; note C#4 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $43, $06 ; note D#4 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $43, $06 ; note D#4 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $43, $06 ; note D#4 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $43, $06 ; note D#4 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $43, $06 ; note D#4 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $43, $06 ; note D#4 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $43, $06 ; note D#4 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $43, $06 ; note D#4 dur 6
    db $1F, $30 ; rest-note $1F dur 48
    db $A2, $FF ; duty2 $FF
    db $A1, $03 ; duty $03
    db $A0, $02 ; volume $02
    db $2A, $30 ; note A#2 dur 48
    db $28, $30 ; note G#2 dur 48
    db $26, $24 ; note F#2 dur 36
    db $A0, $04 ; volume $04
    db $26, $1C ; note F#2 dur 28
    db $A2, $50 ; duty2 $50
    db $A0, $06 ; volume $06
    db $26, $20 ; note F#2 dur 32
    db $A2, $FF ; duty2 $FF
    db $A0, $02 ; volume $02
    db $31, $30 ; note C#3 dur 48
    db $2B, $30 ; note B2 dur 48
    db $29, $24 ; note A2 dur 36
    db $A0, $04 ; volume $04
    db $29, $1C ; note A2 dur 28
    db $A2, $50 ; duty2 $50
    db $A0, $06 ; volume $06
    db $29, $20 ; note A2 dur 32
    db $A2, $FF ; duty2 $FF
    db $A0, $02 ; volume $02
    db $2A, $0C ; note A#2 dur 12
    db $2B, $0C ; note B2 dur 12
    db $31, $0C ; note C#3 dur 12
    db $2B, $0C ; note B2 dur 12
    db $2A, $13 ; note A#2 dur 19
    db $A0, $04 ; volume $04
    db $2A, $0D ; note A#2 dur 13
    db $A0, $02 ; volume $02
    db $28, $13 ; note G#2 dur 19
    db $A0, $04 ; volume $04
    db $28, $0D ; note G#2 dur 13
    db $A0, $02 ; volume $02
    db $26, $13 ; note F#2 dur 19
    db $A0, $04 ; volume $04
    db $26, $1D ; note F#2 dur 29
    db $A2, $30 ; duty2 $30
    db $A0, $06 ; volume $06
    db $26, $20 ; note F#2 dur 32
    db $A2, $FF ; duty2 $FF
    db $A0, $02 ; volume $02
    db $31, $0C ; note C#3 dur 12
    db $32, $0C ; note D3 dur 12
    db $34, $0C ; note E3 dur 12
    db $32, $0C ; note D3 dur 12
    db $31, $13 ; note C#3 dur 19
    db $A0, $04 ; volume $04
    db $31, $0D ; note C#3 dur 13
    db $A0, $02 ; volume $02
    db $2B, $13 ; note B2 dur 19
    db $A0, $04 ; volume $04
    db $2B, $0D ; note B2 dur 13
    db $A0, $02 ; volume $02
    db $29, $13 ; note A2 dur 19
    db $A0, $04 ; volume $04
    db $29, $1D ; note A2 dur 29
    db $A2, $30 ; duty2 $30
    db $A0, $06 ; volume $06
    db $29, $20 ; note A2 dur 32
    db $A2, $FF ; duty2 $FF
    db $A0, $02 ; volume $02
    db $37, $29 ; note G3 dur 41
    db $A0, $04 ; volume $04
    db $37, $07 ; note G3 dur 7
    db $A0, $02 ; volume $02
    db $35, $29 ; note F3 dur 41
    db $A0, $04 ; volume $04
    db $35, $07 ; note F3 dur 7
    db $A0, $02 ; volume $02
    db $33, $29 ; note D#3 dur 41
    db $A0, $04 ; volume $04
    db $33, $07 ; note D#3 dur 7
    db $A0, $02 ; volume $02
    db $34, $18 ; note E3 dur 24
    db $35, $18 ; note F3 dur 24
    db $37, $18 ; note G3 dur 24
    db $35, $18 ; note F3 dur 24
    db $34, $13 ; note E3 dur 19
    db $A0, $04 ; volume $04
    db $34, $0D ; note E3 dur 13
    db $A0, $02 ; volume $02
    db $32, $13 ; note D3 dur 19
    db $A0, $04 ; volume $04
    db $32, $0D ; note D3 dur 13
    db $A0, $02 ; volume $02
    db $30, $13 ; note C3 dur 19
    db $A0, $04 ; volume $04
    db $30, $0D ; note C3 dur 13
    db $FD, $F0 ; label 0
    db $A0, $02 ; volume $02
    db $2B, $11 ; note B2 dur 17
    db $A0, $04 ; volume $04
    db $2B, $07 ; note B2 dur 7
    db $A0, $02 ; volume $02
    db $2B, $24 ; note B2 dur 36
    db $A0, $04 ; volume $04
    db $2B, $0C ; note B2 dur 12
    db $A0, $02 ; volume $02
    db $2B, $11 ; note B2 dur 17
    db $A0, $04 ; volume $04
    db $2B, $07 ; note B2 dur 7
    db $B3, $F0 ; repeat $F0
    db $A2, $20 ; duty2 $20
    db $A1, $0F ; duty $0F
    db $A0, $02 ; volume $02
    db $28, $07 ; note G#2 dur 7
    db $A0, $04 ; volume $04
    db $28, $11 ; note G#2 dur 17
    db $A0, $02 ; volume $02
    db $21, $07 ; note C#2 dur 7
    db $A0, $04 ; volume $04
    db $21, $29 ; note C#2 dur 41
    db $A0, $02 ; volume $02
    db $21, $07 ; note C#2 dur 7
    db $A0, $04 ; volume $04
    db $21, $11 ; note C#2 dur 17
    db $A0, $02 ; volume $02
    db $28, $07 ; note G#2 dur 7
    db $A0, $04 ; volume $04
    db $28, $11 ; note G#2 dur 17
    db $A0, $02 ; volume $02
    db $21, $07 ; note C#2 dur 7
    db $A0, $04 ; volume $04
    db $21, $29 ; note C#2 dur 41
    db $A0, $02 ; volume $02
    db $21, $07 ; note C#2 dur 7
    db $A0, $04 ; volume $04
    db $21, $11 ; note C#2 dur 17
    db $A0, $02 ; volume $02
    db $28, $07 ; note G#2 dur 7
    db $A0, $04 ; volume $04
    db $28, $11 ; note G#2 dur 17
    db $A0, $02 ; volume $02
    db $21, $07 ; note C#2 dur 7
    db $A0, $04 ; volume $04
    db $21, $29 ; note C#2 dur 41
    db $A0, $02 ; volume $02
    db $21, $07 ; note C#2 dur 7
    db $A0, $04 ; volume $04
    db $21, $11 ; note C#2 dur 17
    db $A0, $02 ; volume $02
    db $28, $07 ; note G#2 dur 7
    db $A0, $04 ; volume $04
    db $28, $11 ; note G#2 dur 17
    db $A0, $02 ; volume $02
    db $21, $07 ; note C#2 dur 7
    db $A0, $04 ; volume $04
    db $21, $29 ; note C#2 dur 41
    db $A0, $02 ; volume $02
    db $21, $07 ; note C#2 dur 7
    db $A0, $04 ; volume $04
    db $21, $11 ; note C#2 dur 17
    db $A0, $02 ; volume $02
    db $2B, $07 ; note B2 dur 7
    db $A0, $04 ; volume $04
    db $2B, $11 ; note B2 dur 17
    db $A0, $02 ; volume $02
    db $24, $07 ; note E2 dur 7
    db $A0, $04 ; volume $04
    db $24, $29 ; note E2 dur 41
    db $A0, $02 ; volume $02
    db $24, $07 ; note E2 dur 7
    db $A0, $04 ; volume $04
    db $24, $11 ; note E2 dur 17
    db $A0, $02 ; volume $02
    db $28, $07 ; note G#2 dur 7
    db $A0, $04 ; volume $04
    db $28, $11 ; note G#2 dur 17
    db $A0, $02 ; volume $02
    db $21, $07 ; note C#2 dur 7
    db $A0, $04 ; volume $04
    db $21, $29 ; note C#2 dur 41
    db $A0, $02 ; volume $02
    db $21, $07 ; note C#2 dur 7
    db $A0, $04 ; volume $04
    db $21, $11 ; note C#2 dur 17
    db $A0, $02 ; volume $02
    db $2B, $07 ; note B2 dur 7
    db $A0, $04 ; volume $04
    db $2B, $11 ; note B2 dur 17
    db $A0, $02 ; volume $02
    db $24, $07 ; note E2 dur 7
    db $A0, $04 ; volume $04
    db $24, $29 ; note E2 dur 41
    db $A0, $02 ; volume $02
    db $24, $07 ; note E2 dur 7
    db $A0, $04 ; volume $04
    db $24, $11 ; note E2 dur 17
    db $A0, $02 ; volume $02
    db $28, $07 ; note G#2 dur 7
    db $A0, $04 ; volume $04
    db $28, $11 ; note G#2 dur 17
    db $A0, $02 ; volume $02
    db $21, $07 ; note C#2 dur 7
    db $A0, $04 ; volume $04
    db $21, $29 ; note C#2 dur 41
    db $A0, $02 ; volume $02
    db $21, $07 ; note C#2 dur 7
    db $A0, $04 ; volume $04
    db $21, $11 ; note C#2 dur 17
    db $A0, $02 ; volume $02
    db $25, $07 ; note F2 dur 7
    db $A0, $04 ; volume $04
    db $25, $11 ; note F2 dur 17
    db $A0, $02 ; volume $02
    db $1A, $07 ; note A#1 dur 7
    db $A0, $04 ; volume $04
    db $1A, $29 ; note A#1 dur 41
    db $A0, $02 ; volume $02
    db $1A, $07 ; note A#1 dur 7
    db $A0, $04 ; volume $04
    db $1A, $11 ; note A#1 dur 17
    db $A0, $02 ; volume $02
    db $25, $07 ; note F2 dur 7
    db $A0, $04 ; volume $04
    db $25, $11 ; note F2 dur 17
    db $A0, $02 ; volume $02
    db $1A, $07 ; note A#1 dur 7
    db $A0, $04 ; volume $04
    db $1A, $29 ; note A#1 dur 41
    db $A0, $02 ; volume $02
    db $1A, $07 ; note A#1 dur 7
    db $A0, $04 ; volume $04
    db $1A, $29 ; note A#1 dur 41
    db $A0, $02 ; volume $02
    db $19, $07 ; note A1 dur 7
    db $A0, $04 ; volume $04
    db $19, $11 ; note A1 dur 17
    db $A0, $02 ; volume $02
    db $1A, $07 ; note A#1 dur 7
    db $A0, $04 ; volume $04
    db $1A, $11 ; note A#1 dur 17
    db $A0, $02 ; volume $02
    db $24, $07 ; note E2 dur 7
    db $A0, $04 ; volume $04
    db $24, $11 ; note E2 dur 17
    db $A0, $02 ; volume $02
    db $25, $07 ; note F2 dur 7
    db $A0, $04 ; volume $04
    db $25, $11 ; note F2 dur 17
    db $A0, $02 ; volume $02
    db $29, $07 ; note A2 dur 7
    db $A0, $04 ; volume $04
    db $29, $11 ; note A2 dur 17
    db $A0, $02 ; volume $02
    db $2A, $07 ; note A#2 dur 7
    db $A0, $04 ; volume $04
    db $2A, $11 ; note A#2 dur 17
    db $A0, $02 ; volume $02
    db $31, $07 ; note C#3 dur 7
    db $A0, $04 ; volume $04
    db $31, $11 ; note C#3 dur 17
    db $B0, $F3 ; jump $F3
    db $FF, $FF ; end

; sound track, 435 events after the header (E-0019: grammar C2, meaning C0)
Data_041_633D:: ; heuristic: track stream of a sound record; C0
    db $03, $01, $09, $00 ; header: param=3 byte1=$01 volume=$09 byte3=$00
    db $A2, $02 ; duty2 $02
    db $A0, $09 ; volume $09
    db $1F, $80 ; rest-note $1F dur 128
    db $C1, $7F ; env $7F
    db $3A, $08 ; note A#3 dur 8
    db $3B, $08 ; note B3 dur 8
    db $3A, $08 ; note A#3 dur 8
    db $3B, $08 ; note B3 dur 8
    db $C2, $15 ; env $15
    db $40, $10 ; note C4 dur 16
    db $3B, $10 ; note B3 dur 16
    db $39, $10 ; note A3 dur 16
    db $37, $10 ; note G3 dur 16
    db $C1, $7F ; env $7F
    db $36, $18 ; note F#3 dur 24
    db $A0, $05 ; volume $05
    db $36, $08 ; note F#3 dur 8
    db $A0, $09 ; volume $09
    db $3B, $08 ; note B3 dur 8
    db $40, $08 ; note C4 dur 8
    db $3B, $08 ; note B3 dur 8
    db $40, $08 ; note C4 dur 8
    db $C2, $15 ; env $15
    db $42, $10 ; note D4 dur 16
    db $40, $10 ; note C4 dur 16
    db $3B, $10 ; note B3 dur 16
    db $39, $10 ; note A3 dur 16
    db $C1, $7F ; env $7F
    db $37, $18 ; note G3 dur 24
    db $A0, $05 ; volume $05
    db $37, $08 ; note G3 dur 8
    db $A0, $09 ; volume $09
    db $C2, $15 ; env $15
    db $40, $08 ; note C4 dur 8
    db $40, $08 ; note C4 dur 8
    db $40, $10 ; note C4 dur 16
    db $38, $10 ; note G#3 dur 16
    db $33, $10 ; note D#3 dur 16
    db $30, $10 ; note C3 dur 16
    db $28, $10 ; note G#2 dur 16
    db $C1, $7F ; env $7F
    db $27, $18 ; note G2 dur 24
    db $A0, $06 ; volume $06
    db $27, $08 ; note G2 dur 8
    db $A0, $09 ; volume $09
    db $41, $08 ; note C#4 dur 8
    db $42, $08 ; note D4 dur 8
    db $41, $08 ; note C#4 dur 8
    db $42, $08 ; note D4 dur 8
    db $C2, $15 ; env $15
    db $3A, $10 ; note A#3 dur 16
    db $35, $10 ; note F3 dur 16
    db $32, $10 ; note D3 dur 16
    db $30, $10 ; note C3 dur 16
    db $C1, $7F ; env $7F
    db $2B, $18 ; note B2 dur 24
    db $A0, $05 ; volume $05
    db $2B, $08 ; note B2 dur 8
    db $A0, $08 ; volume $08
    db $C2, $18 ; env $18
    db $FD, $F0 ; label 0
    db $2B, $20 ; note B2 dur 32
    db $B4, $F0 ; repeat $F0
    db $30, $20 ; note C3 dur 32
    db $2B, $20 ; note B2 dur 32
    db $2B, $20 ; note B2 dur 32
    db $FD, $F0 ; label 0
    db $30, $20 ; note C3 dur 32
    db $B3, $F0 ; repeat $F0
    db $29, $20 ; note A2 dur 32
    db $27, $20 ; note G2 dur 32
    db $26, $20 ; note F#2 dur 32
    db $26, $20 ; note F#2 dur 32
    db $A0, $06 ; volume $06
    db $30, $10 ; note C3 dur 16
    db $28, $10 ; note G#2 dur 16
    db $23, $10 ; note D#2 dur 16
    db $20, $10 ; note C2 dur 16
    db $C0, $FE ; env $FE
    db $18, $30 ; note G#1 dur 48
    db $C1, $7F ; env $7F
    db $18, $10 ; note G#1 dur 16
    db $A0, $0F ; volume $0F
    db $C2, $18 ; env $18
    db $32, $10 ; note D3 dur 16
    db $2A, $10 ; note A#2 dur 16
    db $25, $10 ; note F2 dur 16
    db $22, $10 ; note D2 dur 16
    db $C0, $FE ; env $FE
    db $1A, $30 ; note A#1 dur 48
    db $C1, $7F ; env $7F
    db $1A, $10 ; note A#1 dur 16
    db $A0, $0A ; volume $0A
    db $C2, $18 ; env $18
    db $FD, $F0 ; label 0
    db $2B, $20 ; note B2 dur 32
    db $B4, $F0 ; repeat $F0
    db $30, $20 ; note C3 dur 32
    db $2B, $20 ; note B2 dur 32
    db $2B, $20 ; note B2 dur 32
    db $FD, $F3 ; label 3
    db $1F, $C0 ; rest-note $1F dur 192
    db $A2, $02 ; duty2 $02
    db $A3, $05 ; mod $05
    db $C3, $7F ; env $7F
    db $A0, $09 ; volume $09
    db $2A, $30 ; note A#2 dur 48
    db $26, $20 ; note F#2 dur 32
    db $27, $10 ; note G2 dur 16
    db $29, $30 ; note A2 dur 48
    db $C0, $FE ; env $FE
    db $A0, $06 ; volume $06
    db $28, $20 ; note G#2 dur 32
    db $A3, $00 ; mod $00
    db $C1, $48 ; env $48
    db $A0, $04 ; volume $04
    db $28, $20 ; note G#2 dur 32
    db $C3, $7F ; env $7F
    db $A3, $05 ; mod $05
    db $A0, $09 ; volume $09
    db $29, $10 ; note A2 dur 16
    db $2A, $10 ; note A#2 dur 16
    db $29, $10 ; note A2 dur 16
    db $2A, $10 ; note A#2 dur 16
    db $32, $10 ; note D3 dur 16
    db $27, $20 ; note G2 dur 32
    db $27, $10 ; note G2 dur 16
    db $C0, $FE ; env $FE
    db $A0, $06 ; volume $06
    db $25, $20 ; note F2 dur 32
    db $C1, $48 ; env $48
    db $A0, $04 ; volume $04
    db $25, $20 ; note F2 dur 32
    db $C3, $7F ; env $7F
    db $A0, $09 ; volume $09
    db $33, $08 ; note D#3 dur 8
    db $34, $08 ; note E3 dur 8
    db $33, $08 ; note D#3 dur 8
    db $34, $08 ; note E3 dur 8
    db $38, $10 ; note G#3 dur 16
    db $33, $10 ; note D#3 dur 16
    db $30, $0F ; note C3 dur 15
    db $A0, $04 ; volume $04
    db $30, $01 ; note C3 dur 1
    db $A0, $09 ; volume $09
    db $30, $28 ; note C3 dur 40
    db $31, $08 ; note C#3 dur 8
    db $32, $20 ; note D3 dur 32
    db $C1, $48 ; env $48
    db $A0, $06 ; volume $06
    db $32, $20 ; note D3 dur 32
    db $C3, $7F ; env $7F
    db $A0, $0A ; volume $0A
    db $29, $08 ; note A2 dur 8
    db $2A, $08 ; note A#2 dur 8
    db $29, $08 ; note A2 dur 8
    db $2A, $08 ; note A#2 dur 8
    db $33, $10 ; note D#3 dur 16
    db $30, $10 ; note C3 dur 16
    db $27, $10 ; note G2 dur 16
    db $20, $08 ; note C2 dur 8
    db $C1, $48 ; env $48
    db $A0, $03 ; volume $03
    db $20, $08 ; note C2 dur 8
    db $C3, $7F ; env $7F
    db $A0, $0C ; volume $0C
    db $24, $08 ; note E2 dur 8
    db $27, $08 ; note G2 dur 8
    db $24, $08 ; note E2 dur 8
    db $27, $08 ; note G2 dur 8
    db $A0, $05 ; volume $05
    db $C0, $FE ; env $FE
    db $26, $28 ; note F#2 dur 40
    db $C7, $28 ; env $28
    db $A0, $03 ; volume $03
    db $26, $90 ; note F#2 dur 144
    db $A2, $02 ; duty2 $02
    db $A0, $09 ; volume $09
    db $C1, $7F ; env $7F
    db $A3, $FE ; mod $FE
    db $3A, $08 ; note A#3 dur 8
    db $3B, $08 ; note B3 dur 8
    db $3A, $08 ; note A#3 dur 8
    db $3B, $08 ; note B3 dur 8
    db $C2, $15 ; env $15
    db $40, $10 ; note C4 dur 16
    db $3B, $10 ; note B3 dur 16
    db $39, $10 ; note A3 dur 16
    db $37, $10 ; note G3 dur 16
    db $A2, $01 ; duty2 $01
    db $C1, $7F ; env $7F
    db $A0, $09 ; volume $09
    db $31, $08 ; note C#3 dur 8
    db $32, $08 ; note D3 dur 8
    db $31, $08 ; note C#3 dur 8
    db $32, $08 ; note D3 dur 8
    db $29, $08 ; note A2 dur 8
    db $A2, $02 ; duty2 $02
    db $A0, $09 ; volume $09
    db $40, $08 ; note C4 dur 8
    db $3B, $08 ; note B3 dur 8
    db $40, $08 ; note C4 dur 8
    db $C2, $15 ; env $15
    db $42, $10 ; note D4 dur 16
    db $40, $10 ; note C4 dur 16
    db $3B, $10 ; note B3 dur 16
    db $39, $10 ; note A3 dur 16
    db $A2, $01 ; duty2 $01
    db $C1, $7F ; env $7F
    db $A0, $09 ; volume $09
    db $2A, $08 ; note A#2 dur 8
    db $2B, $08 ; note B2 dur 8
    db $2A, $08 ; note A#2 dur 8
    db $2B, $08 ; note B2 dur 8
    db $27, $08 ; note G2 dur 8
    db $A2, $02 ; duty2 $02
    db $A0, $09 ; volume $09
    db $C2, $15 ; env $15
    db $40, $08 ; note C4 dur 8
    db $40, $10 ; note C4 dur 16
    db $38, $10 ; note G#3 dur 16
    db $33, $10 ; note D#3 dur 16
    db $30, $10 ; note C3 dur 16
    db $28, $10 ; note G#2 dur 16
    db $C1, $7F ; env $7F
    db $27, $18 ; note G2 dur 24
    db $A0, $04 ; volume $04
    db $27, $08 ; note G2 dur 8
    db $A0, $09 ; volume $09
    db $41, $08 ; note C#4 dur 8
    db $42, $08 ; note D4 dur 8
    db $41, $08 ; note C#4 dur 8
    db $42, $08 ; note D4 dur 8
    db $C2, $15 ; env $15
    db $3A, $10 ; note A#3 dur 16
    db $35, $10 ; note F3 dur 16
    db $32, $10 ; note D3 dur 16
    db $30, $10 ; note C3 dur 16
    db $A2, $01 ; duty2 $01
    db $C1, $7F ; env $7F
    db $A0, $0B ; volume $0B
    db $26, $08 ; note F#2 dur 8
    db $27, $08 ; note G2 dur 8
    db $31, $08 ; note C#3 dur 8
    db $32, $08 ; note D3 dur 8
    db $C2, $60 ; env $60
    db $A2, $01 ; duty2 $01
    db $A0, $07 ; volume $07
    db $2B, $08 ; note B2 dur 8
    db $A0, $02 ; volume $02
    db $2B, $08 ; note B2 dur 8
    db $A2, $02 ; duty2 $02
    db $C2, $38 ; env $38
    db $A0, $0A ; volume $0A
    db $37, $08 ; note G3 dur 8
    db $37, $08 ; note G3 dur 8
    db $C2, $60 ; env $60
    db $36, $08 ; note F#3 dur 8
    db $37, $08 ; note G3 dur 8
    db $36, $08 ; note F#3 dur 8
    db $37, $08 ; note G3 dur 8
    db $A0, $07 ; volume $07
    db $A2, $01 ; duty2 $01
    db $2B, $08 ; note B2 dur 8
    db $A0, $02 ; volume $02
    db $2B, $08 ; note B2 dur 8
    db $A2, $02 ; duty2 $02
    db $C2, $38 ; env $38
    db $A0, $0A ; volume $0A
    db $37, $08 ; note G3 dur 8
    db $37, $08 ; note G3 dur 8
    db $C2, $60 ; env $60
    db $A2, $01 ; duty2 $01
    db $A0, $07 ; volume $07
    db $2B, $08 ; note B2 dur 8
    db $A0, $02 ; volume $02
    db $2B, $08 ; note B2 dur 8
    db $A2, $02 ; duty2 $02
    db $A0, $0A ; volume $0A
    db $37, $08 ; note G3 dur 8
    db $A0, $05 ; volume $05
    db $37, $08 ; note G3 dur 8
    db $A2, $01 ; duty2 $01
    db $A0, $07 ; volume $07
    db $2B, $08 ; note B2 dur 8
    db $A0, $02 ; volume $02
    db $2B, $08 ; note B2 dur 8
    db $A2, $02 ; duty2 $02
    db $C2, $38 ; env $38
    db $A0, $0A ; volume $0A
    db $37, $08 ; note G3 dur 8
    db $37, $08 ; note G3 dur 8
    db $C2, $60 ; env $60
    db $A2, $01 ; duty2 $01
    db $A0, $07 ; volume $07
    db $30, $08 ; note C3 dur 8
    db $A0, $02 ; volume $02
    db $30, $08 ; note C3 dur 8
    db $A2, $02 ; duty2 $02
    db $A0, $0A ; volume $0A
    db $36, $08 ; note F#3 dur 8
    db $A0, $03 ; volume $03
    db $36, $08 ; note F#3 dur 8
    db $A2, $01 ; duty2 $01
    db $A0, $07 ; volume $07
    db $2B, $08 ; note B2 dur 8
    db $A0, $02 ; volume $02
    db $2B, $08 ; note B2 dur 8
    db $A2, $02 ; duty2 $02
    db $C2, $38 ; env $38
    db $A0, $0A ; volume $0A
    db $37, $08 ; note G3 dur 8
    db $37, $08 ; note G3 dur 8
    db $C2, $60 ; env $60
    db $36, $08 ; note F#3 dur 8
    db $37, $08 ; note G3 dur 8
    db $36, $08 ; note F#3 dur 8
    db $37, $08 ; note G3 dur 8
    db $A2, $01 ; duty2 $01
    db $A0, $07 ; volume $07
    db $30, $08 ; note C3 dur 8
    db $A0, $02 ; volume $02
    db $30, $08 ; note C3 dur 8
    db $A2, $02 ; duty2 $02
    db $C2, $38 ; env $38
    db $A0, $0A ; volume $0A
    db $37, $08 ; note G3 dur 8
    db $37, $08 ; note G3 dur 8
    db $C2, $60 ; env $60
    db $36, $08 ; note F#3 dur 8
    db $37, $08 ; note G3 dur 8
    db $36, $08 ; note F#3 dur 8
    db $37, $08 ; note G3 dur 8
    db $A2, $01 ; duty2 $01
    db $A0, $07 ; volume $07
    db $30, $08 ; note C3 dur 8
    db $A0, $02 ; volume $02
    db $30, $08 ; note C3 dur 8
    db $A2, $02 ; duty2 $02
    db $C2, $38 ; env $38
    db $A0, $0A ; volume $0A
    db $37, $08 ; note G3 dur 8
    db $37, $08 ; note G3 dur 8
    db $A2, $01 ; duty2 $01
    db $A0, $07 ; volume $07
    db $30, $08 ; note C3 dur 8
    db $A0, $02 ; volume $02
    db $30, $08 ; note C3 dur 8
    db $A2, $02 ; duty2 $02
    db $A0, $0A ; volume $0A
    db $37, $08 ; note G3 dur 8
    db $A0, $05 ; volume $05
    db $37, $08 ; note G3 dur 8
    db $A2, $01 ; duty2 $01
    db $A0, $07 ; volume $07
    db $29, $08 ; note A2 dur 8
    db $A0, $02 ; volume $02
    db $29, $08 ; note A2 dur 8
    db $A2, $02 ; duty2 $02
    db $C2, $38 ; env $38
    db $A0, $0A ; volume $0A
    db $37, $08 ; note G3 dur 8
    db $37, $08 ; note G3 dur 8
    db $C2, $60 ; env $60
    db $A2, $01 ; duty2 $01
    db $A0, $07 ; volume $07
    db $27, $08 ; note G2 dur 8
    db $A0, $02 ; volume $02
    db $27, $08 ; note G2 dur 8
    db $A2, $02 ; duty2 $02
    db $C2, $40 ; env $40
    db $A0, $0A ; volume $0A
    db $37, $08 ; note G3 dur 8
    db $A0, $03 ; volume $03
    db $37, $08 ; note G3 dur 8
    db $C2, $60 ; env $60
    db $A2, $01 ; duty2 $01
    db $A0, $07 ; volume $07
    db $26, $08 ; note F#2 dur 8
    db $A0, $02 ; volume $02
    db $26, $08 ; note F#2 dur 8
    db $A2, $02 ; duty2 $02
    db $A0, $0A ; volume $0A
    db $36, $08 ; note F#3 dur 8
    db $A0, $05 ; volume $05
    db $36, $08 ; note F#3 dur 8
    db $A0, $0A ; volume $0A
    db $35, $08 ; note F3 dur 8
    db $36, $08 ; note F#3 dur 8
    db $35, $08 ; note F3 dur 8
    db $36, $08 ; note F#3 dur 8
    db $C2, $18 ; env $18
    db $A0, $06 ; volume $06
    db $30, $10 ; note C3 dur 16
    db $28, $10 ; note G#2 dur 16
    db $23, $10 ; note D#2 dur 16
    db $20, $10 ; note C2 dur 16
    db $C1, $7F ; env $7F
    db $18, $10 ; note G#1 dur 16
    db $A0, $08 ; volume $08
    db $A2, $00 ; duty2 $00
    db $23, $08 ; note D#2 dur 8
    db $28, $08 ; note G#2 dur 8
    db $30, $08 ; note C3 dur 8
    db $33, $08 ; note D#3 dur 8
    db $38, $08 ; note G#3 dur 8
    db $40, $08 ; note C4 dur 8
    db $A2, $02 ; duty2 $02
    db $A0, $0B ; volume $0B
    db $C2, $18 ; env $18
    db $32, $10 ; note D3 dur 16
    db $2A, $10 ; note A#2 dur 16
    db $25, $10 ; note F2 dur 16
    db $22, $10 ; note D2 dur 16
    db $C1, $7F ; env $7F
    db $1A, $10 ; note A#1 dur 16
    db $A0, $0C ; volume $0C
    db $A2, $00 ; duty2 $00
    db $25, $08 ; note F2 dur 8
    db $2A, $08 ; note A#2 dur 8
    db $32, $08 ; note D3 dur 8
    db $35, $08 ; note F3 dur 8
    db $3A, $08 ; note A#3 dur 8
    db $42, $08 ; note D4 dur 8
    db $A2, $02 ; duty2 $02
    db $A0, $0A ; volume $0A
    db $C2, $18 ; env $18
    db $FD, $F0 ; label 0
    db $2B, $20 ; note B2 dur 32
    db $B4, $F0 ; repeat $F0
    db $30, $20 ; note C3 dur 32
    db $2B, $20 ; note B2 dur 32
    db $2B, $20 ; note B2 dur 32
    db $B0, $F3 ; jump $F3
    db $FF, $FF ; end

; sound track, 430 events after the header (E-0019: grammar C2, meaning C0)
Data_041_66A7:: ; heuristic: track stream of a sound record; C0
    db $03, $00, $09, $00 ; header: param=3 byte1=$00 volume=$09 byte3=$00
    db $A2, $02 ; duty2 $02
    db $A0, $0B ; volume $0B
    db $1F, $80 ; rest-note $1F dur 128
    db $A3, $06 ; mod $06
    db $C1, $7F ; env $7F
    db $41, $08 ; note C#4 dur 8
    db $42, $08 ; note D4 dur 8
    db $41, $08 ; note C#4 dur 8
    db $42, $08 ; note D4 dur 8
    db $C2, $15 ; env $15
    db $44, $10 ; note E4 dur 16
    db $42, $10 ; note D4 dur 16
    db $40, $10 ; note C4 dur 16
    db $3B, $10 ; note B3 dur 16
    db $C1, $7F ; env $7F
    db $39, $18 ; note A3 dur 24
    db $A0, $06 ; volume $06
    db $39, $08 ; note A3 dur 8
    db $A0, $0B ; volume $0B
    db $43, $08 ; note D#4 dur 8
    db $44, $08 ; note E4 dur 8
    db $43, $08 ; note D#4 dur 8
    db $44, $08 ; note E4 dur 8
    db $C2, $15 ; env $15
    db $46, $10 ; note F#4 dur 16
    db $44, $10 ; note E4 dur 16
    db $42, $10 ; note D4 dur 16
    db $40, $10 ; note C4 dur 16
    db $C1, $7F ; env $7F
    db $3B, $18 ; note B3 dur 24
    db $A0, $06 ; volume $06
    db $3B, $08 ; note B3 dur 8
    db $A0, $0B ; volume $0B
    db $C2, $15 ; env $15
    db $44, $08 ; note E4 dur 8
    db $44, $08 ; note E4 dur 8
    db $44, $10 ; note E4 dur 16
    db $40, $10 ; note C4 dur 16
    db $38, $10 ; note G#3 dur 16
    db $33, $10 ; note D#3 dur 16
    db $30, $10 ; note C3 dur 16
    db $C1, $7F ; env $7F
    db $2B, $18 ; note B2 dur 24
    db $A0, $08 ; volume $08
    db $2B, $08 ; note B2 dur 8
    db $A0, $0B ; volume $0B
    db $45, $08 ; note F4 dur 8
    db $46, $08 ; note F#4 dur 8
    db $45, $08 ; note F4 dur 8
    db $46, $08 ; note F#4 dur 8
    db $C2, $15 ; env $15
    db $42, $10 ; note D4 dur 16
    db $3A, $10 ; note A#3 dur 16
    db $35, $10 ; note F3 dur 16
    db $32, $10 ; note D3 dur 16
    db $C1, $7F ; env $7F
    db $37, $18 ; note G3 dur 24
    db $A0, $06 ; volume $06
    db $37, $08 ; note G3 dur 8
    db $A0, $0C ; volume $0C
    db $C2, $18 ; env $18
    db $FD, $F0 ; label 0
    db $32, $20 ; note D3 dur 32
    db $B7, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $34, $20 ; note E3 dur 32
    db $B3, $F0 ; repeat $F0
    db $31, $20 ; note C#3 dur 32
    db $31, $20 ; note C#3 dur 32
    db $30, $20 ; note C3 dur 32
    db $30, $20 ; note C3 dur 32
    db $A0, $09 ; volume $09
    db $34, $10 ; note E3 dur 16
    db $30, $10 ; note C3 dur 16
    db $27, $10 ; note G2 dur 16
    db $24, $10 ; note E2 dur 16
    db $C0, $FE ; env $FE
    db $20, $30 ; note C2 dur 48
    db $C1, $7F ; env $7F
    db $20, $10 ; note C2 dur 16
    db $A0, $0F ; volume $0F
    db $C2, $18 ; env $18
    db $36, $10 ; note F#3 dur 16
    db $32, $10 ; note D3 dur 16
    db $29, $10 ; note A2 dur 16
    db $26, $10 ; note F#2 dur 16
    db $C0, $FE ; env $FE
    db $22, $30 ; note D2 dur 48
    db $C1, $7F ; env $7F
    db $22, $10 ; note D2 dur 16
    db $A0, $0C ; volume $0C
    db $C2, $18 ; env $18
    db $FD, $F0 ; label 0
    db $32, $20 ; note D3 dur 32
    db $B7, $F0 ; repeat $F0
    db $FD, $F3 ; label 3
    db $A2, $02 ; duty2 $02
    db $1F, $05 ; rest-note $1F dur 5
    db $A3, $02 ; mod $02
    db $A0, $04 ; volume $04
    db $C1, $78 ; env $78
    db $17, $10 ; note G1 dur 16
    db $22, $10 ; note D2 dur 16
    db $22, $10 ; note D2 dur 16
    db $12, $10 ; note D1 dur 16
    db $22, $10 ; note D2 dur 16
    db $22, $10 ; note D2 dur 16
    db $17, $10 ; note G1 dur 16
    db $22, $10 ; note D2 dur 16
    db $22, $10 ; note D2 dur 16
    db $12, $10 ; note D1 dur 16
    db $22, $10 ; note D2 dur 16
    db $22, $0B ; note D2 dur 11
    db $A3, $09 ; mod $09
    db $C0, $FE ; env $FE
    db $A0, $09 ; volume $09
    db $37, $30 ; note G3 dur 48
    db $C3, $7F ; env $7F
    db $A0, $0D ; volume $0D
    db $32, $20 ; note D3 dur 32
    db $33, $10 ; note D#3 dur 16
    db $C0, $FE ; env $FE
    db $A0, $0A ; volume $0A
    db $35, $30 ; note F3 dur 48
    db $C3, $7F ; env $7F
    db $A0, $0D ; volume $0D
    db $A3, $03 ; mod $03
    db $30, $20 ; note C3 dur 32
    db $C1, $48 ; env $48
    db $A3, $00 ; mod $00
    db $A0, $09 ; volume $09
    db $30, $20 ; note C3 dur 32
    db $A3, $09 ; mod $09
    db $C3, $7F ; env $7F
    db $A0, $0D ; volume $0D
    db $31, $10 ; note C#3 dur 16
    db $32, $10 ; note D3 dur 16
    db $31, $10 ; note C#3 dur 16
    db $32, $10 ; note D3 dur 16
    db $37, $10 ; note G3 dur 16
    db $35, $20 ; note F3 dur 32
    db $33, $10 ; note D#3 dur 16
    db $A0, $0C ; volume $0C
    db $A3, $00 ; mod $00
    db $2A, $20 ; note A#2 dur 32
    db $C1, $48 ; env $48
    db $A0, $09 ; volume $09
    db $2A, $20 ; note A#2 dur 32
    db $A3, $09 ; mod $09
    db $C3, $7F ; env $7F
    db $A0, $0D ; volume $0D
    db $3B, $08 ; note B3 dur 8
    db $40, $08 ; note C4 dur 8
    db $3B, $08 ; note B3 dur 8
    db $40, $08 ; note C4 dur 8
    db $43, $10 ; note D#4 dur 16
    db $40, $10 ; note C4 dur 16
    db $37, $10 ; note G3 dur 16
    db $A3, $00 ; mod $00
    db $A0, $0C ; volume $0C
    db $33, $28 ; note D#3 dur 40
    db $A0, $0D ; volume $0D
    db $A3, $09 ; mod $09
    db $34, $08 ; note E3 dur 8
    db $A0, $0A ; volume $0A
    db $A3, $03 ; mod $03
    db $C0, $FE ; env $FE
    db $35, $20 ; note F3 dur 32
    db $C1, $48 ; env $48
    db $A0, $09 ; volume $09
    db $35, $20 ; note F3 dur 32
    db $A3, $09 ; mod $09
    db $C3, $7F ; env $7F
    db $A0, $0D ; volume $0D
    db $36, $08 ; note F#3 dur 8
    db $37, $08 ; note G3 dur 8
    db $36, $08 ; note F#3 dur 8
    db $37, $08 ; note G3 dur 8
    db $3A, $10 ; note A#3 dur 16
    db $37, $10 ; note G3 dur 16
    db $33, $10 ; note D#3 dur 16
    db $A0, $0A ; volume $0A
    db $C0, $FE ; env $FE
    db $32, $40 ; note D3 dur 64
    db $C1, $48 ; env $48
    db $A0, $08 ; volume $08
    db $A3, $00 ; mod $00
    db $32, $28 ; note D3 dur 40
    db $A0, $05 ; volume $05
    db $1F, $04 ; rest-note $1F dur 4
    db $17, $10 ; note G1 dur 16
    db $22, $10 ; note D2 dur 16
    db $17, $10 ; note G1 dur 16
    db $22, $10 ; note D2 dur 16
    db $17, $10 ; note G1 dur 16
    db $22, $10 ; note D2 dur 16
    db $17, $10 ; note G1 dur 16
    db $22, $0C ; note D2 dur 12
    db $A2, $02 ; duty2 $02
    db $A0, $0C ; volume $0C
    db $C1, $7F ; env $7F
    db $A3, $FE ; mod $FE
    db $41, $08 ; note C#4 dur 8
    db $42, $08 ; note D4 dur 8
    db $41, $08 ; note C#4 dur 8
    db $42, $08 ; note D4 dur 8
    db $C2, $15 ; env $15
    db $44, $10 ; note E4 dur 16
    db $42, $10 ; note D4 dur 16
    db $40, $10 ; note C4 dur 16
    db $3B, $10 ; note B3 dur 16
    db $C1, $7F ; env $7F
    db $39, $18 ; note A3 dur 24
    db $A0, $06 ; volume $06
    db $39, $08 ; note A3 dur 8
    db $A0, $0D ; volume $0D
    db $43, $08 ; note D#4 dur 8
    db $44, $08 ; note E4 dur 8
    db $43, $08 ; note D#4 dur 8
    db $44, $08 ; note E4 dur 8
    db $C2, $15 ; env $15
    db $46, $10 ; note F#4 dur 16
    db $44, $10 ; note E4 dur 16
    db $42, $10 ; note D4 dur 16
    db $40, $10 ; note C4 dur 16
    db $C1, $7F ; env $7F
    db $3B, $18 ; note B3 dur 24
    db $A0, $06 ; volume $06
    db $3B, $08 ; note B3 dur 8
    db $A0, $0D ; volume $0D
    db $C2, $15 ; env $15
    db $44, $08 ; note E4 dur 8
    db $44, $08 ; note E4 dur 8
    db $44, $10 ; note E4 dur 16
    db $40, $10 ; note C4 dur 16
    db $38, $10 ; note G#3 dur 16
    db $33, $10 ; note D#3 dur 16
    db $30, $10 ; note C3 dur 16
    db $C1, $7F ; env $7F
    db $2B, $18 ; note B2 dur 24
    db $A0, $08 ; volume $08
    db $2B, $08 ; note B2 dur 8
    db $A0, $0D ; volume $0D
    db $45, $08 ; note F4 dur 8
    db $46, $08 ; note F#4 dur 8
    db $45, $08 ; note F4 dur 8
    db $46, $08 ; note F#4 dur 8
    db $C2, $15 ; env $15
    db $42, $10 ; note D4 dur 16
    db $3A, $10 ; note A#3 dur 16
    db $35, $10 ; note F3 dur 16
    db $32, $10 ; note D3 dur 16
    db $C1, $7F ; env $7F
    db $37, $18 ; note G3 dur 24
    db $A0, $06 ; volume $06
    db $37, $08 ; note G3 dur 8
    db $C2, $60 ; env $60
    db $A2, $00 ; duty2 $00
    db $A0, $08 ; volume $08
    db $32, $08 ; note D3 dur 8
    db $A0, $02 ; volume $02
    db $32, $08 ; note D3 dur 8
    db $A2, $02 ; duty2 $02
    db $C2, $38 ; env $38
    db $A0, $09 ; volume $09
    db $3B, $08 ; note B3 dur 8
    db $3B, $08 ; note B3 dur 8
    db $C2, $60 ; env $60
    db $3A, $08 ; note A#3 dur 8
    db $3B, $08 ; note B3 dur 8
    db $3A, $08 ; note A#3 dur 8
    db $3B, $08 ; note B3 dur 8
    db $A2, $00 ; duty2 $00
    db $A0, $08 ; volume $08
    db $32, $08 ; note D3 dur 8
    db $A0, $02 ; volume $02
    db $32, $08 ; note D3 dur 8
    db $A2, $02 ; duty2 $02
    db $C2, $38 ; env $38
    db $A0, $09 ; volume $09
    db $3B, $08 ; note B3 dur 8
    db $3B, $08 ; note B3 dur 8
    db $C2, $60 ; env $60
    db $A2, $00 ; duty2 $00
    db $A0, $08 ; volume $08
    db $32, $08 ; note D3 dur 8
    db $A0, $02 ; volume $02
    db $32, $08 ; note D3 dur 8
    db $A2, $02 ; duty2 $02
    db $A0, $09 ; volume $09
    db $3B, $08 ; note B3 dur 8
    db $A0, $04 ; volume $04
    db $3B, $08 ; note B3 dur 8
    db $A2, $00 ; duty2 $00
    db $A0, $08 ; volume $08
    db $32, $08 ; note D3 dur 8
    db $A0, $02 ; volume $02
    db $32, $08 ; note D3 dur 8
    db $A2, $02 ; duty2 $02
    db $C2, $38 ; env $38
    db $A0, $09 ; volume $09
    db $3B, $08 ; note B3 dur 8
    db $3B, $08 ; note B3 dur 8
    db $C2, $60 ; env $60
    db $A2, $00 ; duty2 $00
    db $A0, $08 ; volume $08
    db $32, $08 ; note D3 dur 8
    db $A0, $02 ; volume $02
    db $32, $08 ; note D3 dur 8
    db $A2, $02 ; duty2 $02
    db $A0, $08 ; volume $08
    db $40, $08 ; note C4 dur 8
    db $A0, $03 ; volume $03
    db $40, $08 ; note C4 dur 8
    db $A2, $00 ; duty2 $00
    db $A0, $08 ; volume $08
    db $32, $08 ; note D3 dur 8
    db $A0, $02 ; volume $02
    db $32, $08 ; note D3 dur 8
    db $A2, $02 ; duty2 $02
    db $C2, $38 ; env $38
    db $A0, $09 ; volume $09
    db $3B, $08 ; note B3 dur 8
    db $3B, $08 ; note B3 dur 8
    db $C2, $60 ; env $60
    db $3A, $08 ; note A#3 dur 8
    db $3B, $08 ; note B3 dur 8
    db $3A, $08 ; note A#3 dur 8
    db $3B, $08 ; note B3 dur 8
    db $A2, $00 ; duty2 $00
    db $A0, $08 ; volume $08
    db $34, $08 ; note E3 dur 8
    db $A0, $02 ; volume $02
    db $34, $08 ; note E3 dur 8
    db $A2, $02 ; duty2 $02
    db $C2, $38 ; env $38
    db $A0, $09 ; volume $09
    db $40, $08 ; note C4 dur 8
    db $40, $08 ; note C4 dur 8
    db $C2, $60 ; env $60
    db $3B, $08 ; note B3 dur 8
    db $40, $08 ; note C4 dur 8
    db $3B, $08 ; note B3 dur 8
    db $40, $08 ; note C4 dur 8
    db $A2, $00 ; duty2 $00
    db $A0, $08 ; volume $08
    db $34, $08 ; note E3 dur 8
    db $A0, $02 ; volume $02
    db $34, $08 ; note E3 dur 8
    db $A2, $02 ; duty2 $02
    db $C2, $38 ; env $38
    db $A0, $09 ; volume $09
    db $40, $08 ; note C4 dur 8
    db $40, $08 ; note C4 dur 8
    db $A2, $00 ; duty2 $00
    db $C2, $60 ; env $60
    db $A0, $08 ; volume $08
    db $34, $08 ; note E3 dur 8
    db $A0, $02 ; volume $02
    db $34, $08 ; note E3 dur 8
    db $A2, $02 ; duty2 $02
    db $A0, $09 ; volume $09
    db $40, $08 ; note C4 dur 8
    db $A0, $04 ; volume $04
    db $40, $08 ; note C4 dur 8
    db $A2, $00 ; duty2 $00
    db $A0, $08 ; volume $08
    db $31, $08 ; note C#3 dur 8
    db $A0, $02 ; volume $02
    db $31, $08 ; note C#3 dur 8
    db $A2, $02 ; duty2 $02
    db $C2, $38 ; env $38
    db $A0, $09 ; volume $09
    db $39, $08 ; note A3 dur 8
    db $39, $08 ; note A3 dur 8
    db $C2, $60 ; env $60
    db $A2, $00 ; duty2 $00
    db $A0, $08 ; volume $08
    db $31, $08 ; note C#3 dur 8
    db $A0, $02 ; volume $02
    db $31, $08 ; note C#3 dur 8
    db $A2, $02 ; duty2 $02
    db $C2, $40 ; env $40
    db $A0, $08 ; volume $08
    db $39, $08 ; note A3 dur 8
    db $A0, $03 ; volume $03
    db $39, $08 ; note A3 dur 8
    db $C2, $60 ; env $60
    db $A2, $00 ; duty2 $00
    db $A0, $08 ; volume $08
    db $30, $08 ; note C3 dur 8
    db $A0, $02 ; volume $02
    db $30, $08 ; note C3 dur 8
    db $A2, $02 ; duty2 $02
    db $A0, $09 ; volume $09
    db $39, $08 ; note A3 dur 8
    db $A0, $03 ; volume $03
    db $39, $08 ; note A3 dur 8
    db $A0, $0A ; volume $0A
    db $38, $08 ; note G#3 dur 8
    db $39, $08 ; note A3 dur 8
    db $38, $08 ; note G#3 dur 8
    db $39, $08 ; note A3 dur 8
    db $C2, $18 ; env $18
    db $A0, $09 ; volume $09
    db $34, $10 ; note E3 dur 16
    db $30, $10 ; note C3 dur 16
    db $27, $10 ; note G2 dur 16
    db $24, $10 ; note E2 dur 16
    db $C0, $FE ; env $FE
    db $20, $30 ; note C2 dur 48
    db $C1, $7F ; env $7F
    db $20, $10 ; note C2 dur 16
    db $A0, $0D ; volume $0D
    db $C2, $18 ; env $18
    db $36, $10 ; note F#3 dur 16
    db $32, $10 ; note D3 dur 16
    db $29, $10 ; note A2 dur 16
    db $26, $10 ; note F#2 dur 16
    db $C0, $FE ; env $FE
    db $22, $30 ; note D2 dur 48
    db $C1, $7F ; env $7F
    db $22, $10 ; note D2 dur 16
    db $A0, $0C ; volume $0C
    db $C2, $18 ; env $18
    db $FD, $F0 ; label 0
    db $32, $20 ; note D3 dur 32
    db $B7, $F0 ; repeat $F0
    db $B0, $F3 ; jump $F3
    db $FF, $FF ; end

; sound track, 529 events after the header (E-0019: grammar C2, meaning C0)
Data_041_6A07:: ; heuristic: track stream of a sound record; C0
    db $03, $40, $02, $02 ; header: param=3 byte1=$40 volume=$02 byte3=$02
    db $A2, $16 ; duty2 $16
    db $A1, $02 ; duty $02
    db $A0, $02 ; volume $02
    db $FD, $F0 ; label 0
    db $27, $10 ; note G2 dur 16
    db $32, $10 ; note D3 dur 16
    db $B5, $F0 ; repeat $F0
    db $29, $10 ; note A2 dur 16
    db $32, $10 ; note D3 dur 16
    db $29, $10 ; note A2 dur 16
    db $32, $10 ; note D3 dur 16
    db $29, $10 ; note A2 dur 16
    db $30, $10 ; note C3 dur 16
    db $29, $10 ; note A2 dur 16
    db $30, $10 ; note C3 dur 16
    db $29, $10 ; note A2 dur 16
    db $32, $10 ; note D3 dur 16
    db $27, $10 ; note G2 dur 16
    db $32, $10 ; note D3 dur 16
    db $20, $10 ; note C2 dur 16
    db $30, $10 ; note C3 dur 16
    db $28, $10 ; note G#2 dur 16
    db $30, $10 ; note C3 dur 16
    db $28, $10 ; note G#2 dur 16
    db $32, $10 ; note D3 dur 16
    db $27, $10 ; note G2 dur 16
    db $32, $10 ; note D3 dur 16
    db $29, $10 ; note A2 dur 16
    db $32, $10 ; note D3 dur 16
    db $2A, $10 ; note A#2 dur 16
    db $32, $10 ; note D3 dur 16
    db $2A, $10 ; note A#2 dur 16
    db $32, $10 ; note D3 dur 16
    db $27, $10 ; note G2 dur 16
    db $32, $10 ; note D3 dur 16
    db $A1, $0A ; duty $0A
    db $17, $10 ; note G1 dur 16
    db $22, $10 ; note D2 dur 16
    db $A2, $FF ; duty2 $FF
    db $22, $18 ; note D2 dur 24
    db $A0, $04 ; volume $04
    db $22, $08 ; note D2 dur 8
    db $A0, $02 ; volume $02
    db $22, $18 ; note D2 dur 24
    db $24, $08 ; note E2 dur 8
    db $22, $18 ; note D2 dur 24
    db $24, $08 ; note E2 dur 8
    db $22, $08 ; note D2 dur 8
    db $A0, $06 ; volume $06
    db $22, $08 ; note D2 dur 8
    db $A0, $02 ; volume $02
    db $22, $08 ; note D2 dur 8
    db $24, $08 ; note E2 dur 8
    db $22, $08 ; note D2 dur 8
    db $20, $08 ; note C2 dur 8
    db $1B, $08 ; note B1 dur 8
    db $19, $08 ; note A1 dur 8
    db $A2, $20 ; duty2 $20
    db $17, $10 ; note G1 dur 16
    db $22, $10 ; note D2 dur 16
    db $A2, $FF ; duty2 $FF
    db $27, $18 ; note G2 dur 24
    db $A0, $04 ; volume $04
    db $27, $08 ; note G2 dur 8
    db $A2, $20 ; duty2 $20
    db $A0, $02 ; volume $02
    db $17, $10 ; note G1 dur 16
    db $24, $10 ; note E2 dur 16
    db $A2, $FF ; duty2 $FF
    db $24, $18 ; note E2 dur 24
    db $A0, $04 ; volume $04
    db $24, $08 ; note E2 dur 8
    db $A0, $02 ; volume $02
    db $24, $18 ; note E2 dur 24
    db $26, $08 ; note F#2 dur 8
    db $24, $18 ; note E2 dur 24
    db $26, $08 ; note F#2 dur 8
    db $24, $10 ; note E2 dur 16
    db $26, $08 ; note F#2 dur 8
    db $27, $08 ; note G2 dur 8
    db $29, $08 ; note A2 dur 8
    db $27, $08 ; note G2 dur 8
    db $26, $08 ; note F#2 dur 8
    db $24, $08 ; note E2 dur 8
    db $A2, $20 ; duty2 $20
    db $22, $10 ; note D2 dur 16
    db $19, $10 ; note A1 dur 16
    db $A2, $FF ; duty2 $FF
    db $12, $18 ; note D1 dur 24
    db $A0, $04 ; volume $04
    db $12, $08 ; note D1 dur 8
    db $A1, $08 ; duty $08
    db $A0, $02 ; volume $02
    db $A2, $20 ; duty2 $20
    db $37, $10 ; note G3 dur 16
    db $33, $10 ; note D#3 dur 16
    db $2A, $10 ; note A#2 dur 16
    db $27, $10 ; note G2 dur 16
    db $24, $10 ; note E2 dur 16
    db $18, $10 ; note G#1 dur 16
    db $A0, $06 ; volume $06
    db $18, $10 ; note G#1 dur 16
    db $A0, $02 ; volume $02
    db $18, $10 ; note G#1 dur 16
    db $39, $10 ; note A3 dur 16
    db $35, $10 ; note F3 dur 16
    db $30, $10 ; note C3 dur 16
    db $29, $10 ; note A2 dur 16
    db $25, $10 ; note F2 dur 16
    db $1A, $10 ; note A#1 dur 16
    db $A0, $06 ; volume $06
    db $1A, $10 ; note A#1 dur 16
    db $A0, $02 ; volume $02
    db $1A, $10 ; note A#1 dur 16
    db $A1, $0A ; duty $0A
    db $17, $10 ; note G1 dur 16
    db $22, $10 ; note D2 dur 16
    db $A2, $FF ; duty2 $FF
    db $22, $18 ; note D2 dur 24
    db $A0, $04 ; volume $04
    db $22, $08 ; note D2 dur 8
    db $A0, $02 ; volume $02
    db $22, $18 ; note D2 dur 24
    db $24, $08 ; note E2 dur 8
    db $22, $18 ; note D2 dur 24
    db $24, $08 ; note E2 dur 8
    db $22, $08 ; note D2 dur 8
    db $A0, $04 ; volume $04
    db $22, $08 ; note D2 dur 8
    db $A0, $02 ; volume $02
    db $22, $08 ; note D2 dur 8
    db $24, $08 ; note E2 dur 8
    db $22, $08 ; note D2 dur 8
    db $20, $08 ; note C2 dur 8
    db $1B, $08 ; note B1 dur 8
    db $19, $08 ; note A1 dur 8
    db $A2, $20 ; duty2 $20
    db $17, $10 ; note G1 dur 16
    db $22, $10 ; note D2 dur 16
    db $A2, $FF ; duty2 $FF
    db $27, $18 ; note G2 dur 24
    db $A0, $04 ; volume $04
    db $27, $08 ; note G2 dur 8
    db $FD, $F3 ; label 3
    db $A1, $07 ; duty $07
    db $A2, $50 ; duty2 $50
    db $A0, $02 ; volume $02
    db $27, $10 ; note G2 dur 16
    db $A2, $12 ; duty2 $12
    db $32, $08 ; note D3 dur 8
    db $A0, $06 ; volume $06
    db $32, $08 ; note D3 dur 8
    db $A0, $02 ; volume $02
    db $32, $08 ; note D3 dur 8
    db $A0, $06 ; volume $06
    db $32, $08 ; note D3 dur 8
    db $A2, $50 ; duty2 $50
    db $A0, $02 ; volume $02
    db $22, $10 ; note D2 dur 16
    db $A2, $12 ; duty2 $12
    db $32, $08 ; note D3 dur 8
    db $A0, $06 ; volume $06
    db $32, $08 ; note D3 dur 8
    db $A0, $02 ; volume $02
    db $32, $08 ; note D3 dur 8
    db $A0, $06 ; volume $06
    db $32, $08 ; note D3 dur 8
    db $A2, $50 ; duty2 $50
    db $A0, $02 ; volume $02
    db $27, $10 ; note G2 dur 16
    db $A2, $12 ; duty2 $12
    db $32, $08 ; note D3 dur 8
    db $A0, $06 ; volume $06
    db $32, $08 ; note D3 dur 8
    db $A0, $02 ; volume $02
    db $32, $08 ; note D3 dur 8
    db $A0, $06 ; volume $06
    db $32, $08 ; note D3 dur 8
    db $A2, $50 ; duty2 $50
    db $A0, $02 ; volume $02
    db $22, $10 ; note D2 dur 16
    db $A2, $12 ; duty2 $12
    db $32, $08 ; note D3 dur 8
    db $A0, $06 ; volume $06
    db $32, $08 ; note D3 dur 8
    db $A0, $02 ; volume $02
    db $32, $08 ; note D3 dur 8
    db $A0, $06 ; volume $06
    db $32, $08 ; note D3 dur 8
    db $A1, $0B ; duty $0B
    db $A2, $FF ; duty2 $FF
    db $A0, $02 ; volume $02
    db $13, $10 ; note D#1 dur 16
    db $A1, $03 ; duty $03
    db $A2, $7F ; duty2 $7F
    db $1A, $0E ; note A#1 dur 14
    db $A0, $04 ; volume $04
    db $1A, $02 ; note A#1 dur 2
    db $A0, $02 ; volume $02
    db $27, $0E ; note G2 dur 14
    db $A0, $04 ; volume $04
    db $27, $02 ; note G2 dur 2
    db $A0, $02 ; volume $02
    db $A1, $0B ; duty $0B
    db $A2, $FF ; duty2 $FF
    db $13, $10 ; note D#1 dur 16
    db $A1, $03 ; duty $03
    db $A2, $7F ; duty2 $7F
    db $1A, $0E ; note A#1 dur 14
    db $A0, $04 ; volume $04
    db $1A, $02 ; note A#1 dur 2
    db $A0, $02 ; volume $02
    db $27, $0E ; note G2 dur 14
    db $A0, $04 ; volume $04
    db $27, $02 ; note G2 dur 2
    db $A0, $02 ; volume $02
    db $A1, $0B ; duty $0B
    db $A2, $FF ; duty2 $FF
    db $13, $10 ; note D#1 dur 16
    db $A1, $03 ; duty $03
    db $A2, $7F ; duty2 $7F
    db $20, $0E ; note C2 dur 14
    db $A0, $04 ; volume $04
    db $20, $02 ; note C2 dur 2
    db $A0, $02 ; volume $02
    db $29, $0E ; note A2 dur 14
    db $A0, $04 ; volume $04
    db $29, $02 ; note A2 dur 2
    db $A0, $02 ; volume $02
    db $A1, $0B ; duty $0B
    db $A2, $FF ; duty2 $FF
    db $13, $10 ; note D#1 dur 16
    db $A1, $03 ; duty $03
    db $A2, $7F ; duty2 $7F
    db $20, $0E ; note C2 dur 14
    db $A0, $04 ; volume $04
    db $20, $02 ; note C2 dur 2
    db $A0, $02 ; volume $02
    db $28, $0E ; note G#2 dur 14
    db $A0, $04 ; volume $04
    db $28, $02 ; note G#2 dur 2
    db $A0, $02 ; volume $02
    db $A1, $0B ; duty $0B
    db $A2, $FF ; duty2 $FF
    db $12, $10 ; note D1 dur 16
    db $A1, $03 ; duty $03
    db $A2, $7F ; duty2 $7F
    db $1A, $0E ; note A#1 dur 14
    db $A0, $04 ; volume $04
    db $1A, $02 ; note A#1 dur 2
    db $A0, $02 ; volume $02
    db $25, $0E ; note F2 dur 14
    db $A0, $04 ; volume $04
    db $25, $02 ; note F2 dur 2
    db $A0, $02 ; volume $02
    db $A1, $0B ; duty $0B
    db $A2, $FF ; duty2 $FF
    db $0A, $10 ; note A#0 dur 16
    db $A1, $03 ; duty $03
    db $A2, $7F ; duty2 $7F
    db $22, $0E ; note D2 dur 14
    db $A0, $04 ; volume $04
    db $22, $02 ; note D2 dur 2
    db $A0, $02 ; volume $02
    db $28, $0E ; note G#2 dur 14
    db $A0, $04 ; volume $04
    db $28, $02 ; note G#2 dur 2
    db $A0, $02 ; volume $02
    db $A2, $FF ; duty2 $FF
    db $A1, $0B ; duty $0B
    db $13, $10 ; note D#1 dur 16
    db $A2, $7F ; duty2 $7F
    db $A1, $03 ; duty $03
    db $1A, $0E ; note A#1 dur 14
    db $A0, $04 ; volume $04
    db $1A, $02 ; note A#1 dur 2
    db $A0, $02 ; volume $02
    db $27, $0E ; note G2 dur 14
    db $A0, $04 ; volume $04
    db $27, $02 ; note G2 dur 2
    db $A0, $02 ; volume $02
    db $A1, $0B ; duty $0B
    db $A2, $FF ; duty2 $FF
    db $17, $10 ; note G1 dur 16
    db $A1, $03 ; duty $03
    db $A2, $7F ; duty2 $7F
    db $22, $0E ; note D2 dur 14
    db $A0, $04 ; volume $04
    db $22, $02 ; note D2 dur 2
    db $A0, $02 ; volume $02
    db $2A, $0E ; note A#2 dur 14
    db $A0, $04 ; volume $04
    db $2A, $02 ; note A#2 dur 2
    db $A0, $02 ; volume $02
    db $A2, $FF ; duty2 $FF
    db $A1, $0B ; duty $0B
    db $20, $10 ; note C2 dur 16
    db $A2, $7F ; duty2 $7F
    db $A1, $03 ; duty $03
    db $27, $0E ; note G2 dur 14
    db $A0, $04 ; volume $04
    db $27, $02 ; note G2 dur 2
    db $A0, $02 ; volume $02
    db $34, $0E ; note E3 dur 14
    db $A0, $04 ; volume $04
    db $34, $02 ; note E3 dur 2
    db $A0, $02 ; volume $02
    db $A2, $FF ; duty2 $FF
    db $A1, $0B ; duty $0B
    db $15, $10 ; note F1 dur 16
    db $A2, $7F ; duty2 $7F
    db $A1, $03 ; duty $03
    db $28, $0E ; note G#2 dur 14
    db $A0, $04 ; volume $04
    db $28, $02 ; note G#2 dur 2
    db $A0, $02 ; volume $02
    db $33, $0E ; note D#3 dur 14
    db $A0, $04 ; volume $04
    db $33, $02 ; note D#3 dur 2
    db $A0, $02 ; volume $02
    db $A1, $0B ; duty $0B
    db $A2, $FF ; duty2 $FF
    db $1A, $10 ; note A#1 dur 16
    db $A1, $03 ; duty $03
    db $A2, $7F ; duty2 $7F
    db $2A, $0E ; note A#2 dur 14
    db $A0, $04 ; volume $04
    db $2A, $02 ; note A#2 dur 2
    db $A0, $02 ; volume $02
    db $2A, $0E ; note A#2 dur 14
    db $A0, $04 ; volume $04
    db $2A, $02 ; note A#2 dur 2
    db $A0, $02 ; volume $02
    db $A1, $0B ; duty $0B
    db $A2, $FF ; duty2 $FF
    db $1A, $10 ; note A#1 dur 16
    db $A1, $03 ; duty $03
    db $A2, $7F ; duty2 $7F
    db $2A, $0E ; note A#2 dur 14
    db $A0, $04 ; volume $04
    db $2A, $02 ; note A#2 dur 2
    db $A0, $02 ; volume $02
    db $2A, $0E ; note A#2 dur 14
    db $A0, $04 ; volume $04
    db $2A, $02 ; note A#2 dur 2
    db $A0, $02 ; volume $02
    db $A1, $0B ; duty $0B
    db $A2, $FF ; duty2 $FF
    db $13, $10 ; note D#1 dur 16
    db $A1, $03 ; duty $03
    db $A2, $7F ; duty2 $7F
    db $1A, $0E ; note A#1 dur 14
    db $A0, $04 ; volume $04
    db $1A, $02 ; note A#1 dur 2
    db $A0, $02 ; volume $02
    db $27, $0E ; note G2 dur 14
    db $A0, $04 ; volume $04
    db $27, $02 ; note G2 dur 2
    db $A0, $02 ; volume $02
    db $A1, $0B ; duty $0B
    db $A2, $FF ; duty2 $FF
    db $18, $10 ; note G#1 dur 16
    db $A1, $03 ; duty $03
    db $A2, $7F ; duty2 $7F
    db $23, $0E ; note D#2 dur 14
    db $A0, $04 ; volume $04
    db $23, $02 ; note D#2 dur 2
    db $A0, $02 ; volume $02
    db $28, $0E ; note G#2 dur 14
    db $A0, $04 ; volume $04
    db $28, $02 ; note G#2 dur 2
    db $A0, $02 ; volume $02
    db $A2, $FF ; duty2 $FF
    db $A1, $0B ; duty $0B
    db $12, $10 ; note D1 dur 16
    db $A2, $7F ; duty2 $7F
    db $A1, $03 ; duty $03
    db $19, $10 ; note A1 dur 16
    db $22, $10 ; note D2 dur 16
    db $29, $11 ; note A2 dur 17
    db $22, $13 ; note D2 dur 19
    db $A0, $02 ; volume $02
    db $12, $14 ; note D1 dur 20
    db $A0, $02 ; volume $02
    db $A2, $16 ; duty2 $16
    db $A1, $03 ; duty $03
    db $A0, $02 ; volume $02
    db $FD, $F0 ; label 0
    db $27, $10 ; note G2 dur 16
    db $32, $10 ; note D3 dur 16
    db $B5, $F0 ; repeat $F0
    db $29, $10 ; note A2 dur 16
    db $32, $10 ; note D3 dur 16
    db $29, $10 ; note A2 dur 16
    db $32, $10 ; note D3 dur 16
    db $29, $10 ; note A2 dur 16
    db $30, $10 ; note C3 dur 16
    db $29, $10 ; note A2 dur 16
    db $30, $10 ; note C3 dur 16
    db $29, $10 ; note A2 dur 16
    db $32, $10 ; note D3 dur 16
    db $27, $10 ; note G2 dur 16
    db $32, $10 ; note D3 dur 16
    db $20, $10 ; note C2 dur 16
    db $30, $10 ; note C3 dur 16
    db $28, $10 ; note G#2 dur 16
    db $30, $10 ; note C3 dur 16
    db $28, $10 ; note G#2 dur 16
    db $32, $10 ; note D3 dur 16
    db $27, $10 ; note G2 dur 16
    db $32, $10 ; note D3 dur 16
    db $29, $10 ; note A2 dur 16
    db $32, $10 ; note D3 dur 16
    db $2A, $10 ; note A#2 dur 16
    db $32, $10 ; note D3 dur 16
    db $2A, $10 ; note A#2 dur 16
    db $32, $10 ; note D3 dur 16
    db $27, $10 ; note G2 dur 16
    db $32, $10 ; note D3 dur 16
    db $A1, $0A ; duty $0A
    db $17, $10 ; note G1 dur 16
    db $22, $10 ; note D2 dur 16
    db $A2, $7F ; duty2 $7F
    db $22, $18 ; note D2 dur 24
    db $A0, $04 ; volume $04
    db $22, $08 ; note D2 dur 8
    db $A0, $02 ; volume $02
    db $22, $18 ; note D2 dur 24
    db $24, $08 ; note E2 dur 8
    db $22, $18 ; note D2 dur 24
    db $24, $08 ; note E2 dur 8
    db $22, $08 ; note D2 dur 8
    db $A0, $06 ; volume $06
    db $22, $08 ; note D2 dur 8
    db $A0, $02 ; volume $02
    db $22, $08 ; note D2 dur 8
    db $24, $08 ; note E2 dur 8
    db $22, $08 ; note D2 dur 8
    db $20, $08 ; note C2 dur 8
    db $1B, $08 ; note B1 dur 8
    db $19, $08 ; note A1 dur 8
    db $A2, $12 ; duty2 $12
    db $17, $10 ; note G1 dur 16
    db $22, $10 ; note D2 dur 16
    db $A2, $7F ; duty2 $7F
    db $27, $18 ; note G2 dur 24
    db $A0, $04 ; volume $04
    db $27, $08 ; note G2 dur 8
    db $A2, $12 ; duty2 $12
    db $A0, $02 ; volume $02
    db $17, $10 ; note G1 dur 16
    db $24, $10 ; note E2 dur 16
    db $A2, $7F ; duty2 $7F
    db $24, $18 ; note E2 dur 24
    db $A0, $04 ; volume $04
    db $24, $08 ; note E2 dur 8
    db $A0, $02 ; volume $02
    db $24, $18 ; note E2 dur 24
    db $26, $08 ; note F#2 dur 8
    db $24, $18 ; note E2 dur 24
    db $26, $08 ; note F#2 dur 8
    db $24, $10 ; note E2 dur 16
    db $26, $08 ; note F#2 dur 8
    db $27, $08 ; note G2 dur 8
    db $29, $08 ; note A2 dur 8
    db $27, $08 ; note G2 dur 8
    db $26, $08 ; note F#2 dur 8
    db $24, $08 ; note E2 dur 8
    db $A2, $12 ; duty2 $12
    db $22, $10 ; note D2 dur 16
    db $19, $10 ; note A1 dur 16
    db $A2, $7F ; duty2 $7F
    db $12, $18 ; note D1 dur 24
    db $A0, $04 ; volume $04
    db $12, $08 ; note D1 dur 8
    db $A1, $08 ; duty $08
    db $A0, $02 ; volume $02
    db $A2, $12 ; duty2 $12
    db $37, $10 ; note G3 dur 16
    db $33, $10 ; note D#3 dur 16
    db $2A, $10 ; note A#2 dur 16
    db $27, $10 ; note G2 dur 16
    db $24, $10 ; note E2 dur 16
    db $18, $10 ; note G#1 dur 16
    db $A0, $06 ; volume $06
    db $18, $10 ; note G#1 dur 16
    db $A0, $02 ; volume $02
    db $18, $10 ; note G#1 dur 16
    db $39, $10 ; note A3 dur 16
    db $35, $10 ; note F3 dur 16
    db $30, $10 ; note C3 dur 16
    db $29, $10 ; note A2 dur 16
    db $25, $10 ; note F2 dur 16
    db $1A, $10 ; note A#1 dur 16
    db $A0, $06 ; volume $06
    db $1A, $10 ; note A#1 dur 16
    db $A0, $02 ; volume $02
    db $1A, $10 ; note A#1 dur 16
    db $A1, $0A ; duty $0A
    db $17, $10 ; note G1 dur 16
    db $22, $10 ; note D2 dur 16
    db $A2, $7F ; duty2 $7F
    db $22, $18 ; note D2 dur 24
    db $A0, $04 ; volume $04
    db $22, $08 ; note D2 dur 8
    db $A0, $02 ; volume $02
    db $22, $18 ; note D2 dur 24
    db $24, $08 ; note E2 dur 8
    db $22, $18 ; note D2 dur 24
    db $24, $08 ; note E2 dur 8
    db $22, $08 ; note D2 dur 8
    db $A0, $04 ; volume $04
    db $22, $08 ; note D2 dur 8
    db $A0, $02 ; volume $02
    db $22, $08 ; note D2 dur 8
    db $24, $08 ; note E2 dur 8
    db $22, $08 ; note D2 dur 8
    db $20, $08 ; note C2 dur 8
    db $1B, $08 ; note B1 dur 8
    db $19, $08 ; note A1 dur 8
    db $A2, $12 ; duty2 $12
    db $17, $10 ; note G1 dur 16
    db $22, $10 ; note D2 dur 16
    db $A2, $7F ; duty2 $7F
    db $27, $18 ; note G2 dur 24
    db $A0, $04 ; volume $04
    db $27, $08 ; note G2 dur 8
    db $B0, $F3 ; jump $F3
    db $FF, $FF ; end

; sound track, 539 events after the header (E-0019: grammar C2, meaning C0)
Data_041_6E2D:: ; heuristic: track stream of a sound record; C0
    db $01, $01, $09, $00 ; header: param=1 byte1=$01 volume=$09 byte3=$00
    db $A3, $08 ; mod $08
    db $C1, $7F ; env $7F
    db $A0, $0B ; volume $0B
    db $25, $03 ; note F2 dur 3
    db $26, $03 ; note F#2 dur 3
    db $27, $03 ; note G2 dur 3
    db $28, $03 ; note G#2 dur 3
    db $29, $03 ; note A2 dur 3
    db $28, $03 ; note G#2 dur 3
    db $27, $03 ; note G2 dur 3
    db $26, $03 ; note F#2 dur 3
    db $25, $24 ; note F2 dur 36
    db $A0, $04 ; volume $04
    db $25, $0C ; note F2 dur 12
    db $A7, $18 ; wait $18
    db $FD, $F3 ; label 3
    db $A7, $0C ; wait $0C
    db $A2, $01 ; duty2 $01
    db $C3, $48 ; env $48
    db $A0, $0B ; volume $0B
    db $22, $04 ; note D2 dur 4
    db $25, $04 ; note F2 dur 4
    db $2A, $04 ; note A#2 dur 4
    db $A0, $08 ; volume $08
    db $C3, $78 ; env $78
    db $32, $18 ; note D3 dur 24
    db $C1, $7F ; env $7F
    db $A0, $04 ; volume $04
    db $32, $24 ; note D3 dur 36
    db $C3, $48 ; env $48
    db $A0, $0B ; volume $0B
    db $25, $04 ; note F2 dur 4
    db $29, $04 ; note A2 dur 4
    db $30, $04 ; note C3 dur 4
    db $A0, $08 ; volume $08
    db $C3, $78 ; env $78
    db $35, $18 ; note F3 dur 24
    db $C1, $7F ; env $7F
    db $A0, $04 ; volume $04
    db $35, $24 ; note F3 dur 36
    db $C3, $48 ; env $48
    db $A0, $0B ; volume $0B
    db $27, $04 ; note G2 dur 4
    db $2A, $04 ; note A#2 dur 4
    db $32, $04 ; note D3 dur 4
    db $A0, $08 ; volume $08
    db $C3, $78 ; env $78
    db $37, $18 ; note G3 dur 24
    db $C1, $7F ; env $7F
    db $A0, $04 ; volume $04
    db $37, $24 ; note G3 dur 36
    db $C3, $58 ; env $58
    db $A0, $0B ; volume $0B
    db $25, $04 ; note F2 dur 4
    db $29, $04 ; note A2 dur 4
    db $30, $04 ; note C3 dur 4
    db $A0, $09 ; volume $09
    db $C3, $68 ; env $68
    db $35, $0C ; note F3 dur 12
    db $33, $0C ; note D#3 dur 12
    db $32, $0C ; note D3 dur 12
    db $30, $0C ; note C3 dur 12
    db $C1, $7F ; env $7F
    db $A0, $04 ; volume $04
    db $30, $0C ; note C3 dur 12
    db $C3, $58 ; env $58
    db $A0, $0B ; volume $0B
    db $1A, $04 ; note A#1 dur 4
    db $22, $04 ; note D2 dur 4
    db $25, $04 ; note F2 dur 4
    db $A0, $09 ; volume $09
    db $C3, $68 ; env $68
    db $2A, $0C ; note A#2 dur 12
    db $30, $0C ; note C3 dur 12
    db $31, $0C ; note C#3 dur 12
    db $32, $0C ; note D3 dur 12
    db $C1, $7F ; env $7F
    db $A0, $04 ; volume $04
    db $32, $0C ; note D3 dur 12
    db $C3, $48 ; env $48
    db $A0, $0B ; volume $0B
    db $23, $04 ; note D#2 dur 4
    db $27, $04 ; note G2 dur 4
    db $30, $04 ; note C3 dur 4
    db $C3, $68 ; env $68
    db $A0, $08 ; volume $08
    db $33, $18 ; note D#3 dur 24
    db $32, $0C ; note D3 dur 12
    db $30, $0C ; note C3 dur 12
    db $29, $0C ; note A2 dur 12
    db $C1, $7F ; env $7F
    db $A0, $04 ; volume $04
    db $29, $0C ; note A2 dur 12
    db $C3, $48 ; env $48
    db $A2, $02 ; duty2 $02
    db $A0, $0A ; volume $0A
    db $29, $05 ; note A2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $04 ; volume $04
    db $29, $06 ; note A2 dur 6
    db $A0, $0A ; volume $0A
    db $39, $05 ; note A3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $04 ; volume $04
    db $29, $06 ; note A2 dur 6
    db $A0, $0A ; volume $0A
    db $3A, $05 ; note A#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $04 ; volume $04
    db $39, $06 ; note A3 dur 6
    db $A0, $0A ; volume $0A
    db $2A, $05 ; note A#2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $04 ; volume $04
    db $3A, $06 ; note A#3 dur 6
    db $A0, $0A ; volume $0A
    db $2B, $05 ; note B2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $04 ; volume $04
    db $2A, $06 ; note A#2 dur 6
    db $A0, $0A ; volume $0A
    db $3B, $05 ; note B3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $04 ; volume $04
    db $2B, $06 ; note B2 dur 6
    db $A0, $0A ; volume $0A
    db $40, $05 ; note C4 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $3B, $03 ; note B3 dur 3
    db $C1, $2F ; env $2F
    db $A0, $03 ; volume $03
    db $40, $15 ; note C4 dur 21
    db $A2, $00 ; duty2 $00
    db $33, $0C ; note D#3 dur 12
    db $35, $12 ; note F3 dur 18
    db $A2, $01 ; duty2 $01
    db $C3, $48 ; env $48
    db $A0, $0C ; volume $0C
    db $23, $04 ; note D#2 dur 4
    db $27, $04 ; note G2 dur 4
    db $2A, $04 ; note A#2 dur 4
    db $A0, $08 ; volume $08
    db $C3, $78 ; env $78
    db $33, $10 ; note D#3 dur 16
    db $C1, $7F ; env $7F
    db $A0, $04 ; volume $04
    db $33, $24 ; note D#3 dur 36
    db $A7, $08 ; wait $08
    db $C3, $48 ; env $48
    db $A0, $0C ; volume $0C
    db $23, $04 ; note D#2 dur 4
    db $27, $04 ; note G2 dur 4
    db $2A, $04 ; note A#2 dur 4
    db $A0, $08 ; volume $08
    db $C3, $78 ; env $78
    db $33, $18 ; note D#3 dur 24
    db $C1, $7F ; env $7F
    db $A0, $04 ; volume $04
    db $33, $24 ; note D#3 dur 36
    db $C3, $48 ; env $48
    db $A0, $0C ; volume $0C
    db $23, $04 ; note D#2 dur 4
    db $29, $04 ; note A2 dur 4
    db $30, $04 ; note C3 dur 4
    db $A0, $08 ; volume $08
    db $C3, $78 ; env $78
    db $33, $18 ; note D#3 dur 24
    db $C1, $7F ; env $7F
    db $A0, $04 ; volume $04
    db $33, $24 ; note D#3 dur 36
    db $C3, $58 ; env $58
    db $A0, $0C ; volume $0C
    db $23, $04 ; note D#2 dur 4
    db $29, $04 ; note A2 dur 4
    db $30, $04 ; note C3 dur 4
    db $A0, $08 ; volume $08
    db $C3, $68 ; env $68
    db $33, $0C ; note D#3 dur 12
    db $32, $0C ; note D3 dur 12
    db $31, $0C ; note C#3 dur 12
    db $30, $0C ; note C3 dur 12
    db $C1, $7F ; env $7F
    db $A0, $04 ; volume $04
    db $30, $0C ; note C3 dur 12
    db $C3, $48 ; env $48
    db $A0, $0C ; volume $0C
    db $19, $04 ; note A1 dur 4
    db $20, $04 ; note C2 dur 4
    db $23, $04 ; note D#2 dur 4
    db $A0, $09 ; volume $09
    db $C3, $68 ; env $68
    db $29, $0C ; note A2 dur 12
    db $2A, $0C ; note A#2 dur 12
    db $30, $0C ; note C3 dur 12
    db $33, $0C ; note D#3 dur 12
    db $C1, $7F ; env $7F
    db $A0, $04 ; volume $04
    db $33, $0C ; note D#3 dur 12
    db $C3, $48 ; env $48
    db $A0, $0B ; volume $0B
    db $29, $04 ; note A2 dur 4
    db $30, $04 ; note C3 dur 4
    db $33, $04 ; note D#3 dur 4
    db $C0, $FE ; env $FE
    db $A0, $07 ; volume $07
    db $39, $1C ; note A3 dur 28
    db $C1, $7F ; env $7F
    db $A0, $05 ; volume $05
    db $39, $14 ; note A3 dur 20
    db $C0, $FE ; env $FE
    db $A0, $0A ; volume $0A
    db $22, $24 ; note D2 dur 36
    db $A0, $05 ; volume $05
    db $22, $0C ; note D2 dur 12
    db $A0, $0A ; volume $0A
    db $23, $24 ; note D#2 dur 36
    db $C1, $4F ; env $4F
    db $A0, $05 ; volume $05
    db $23, $0C ; note D#2 dur 12
    db $C0, $FE ; env $FE
    db $A0, $0A ; volume $0A
    db $24, $12 ; note E2 dur 18
    db $A0, $05 ; volume $05
    db $24, $06 ; note E2 dur 6
    db $C3, $78 ; env $78
    db $A0, $0B ; volume $0B
    db $25, $0C ; note F2 dur 12
    db $28, $0C ; note G#2 dur 12
    db $A0, $03 ; volume $03
    db $28, $18 ; note G#2 dur 24
    db $C2, $38 ; env $38
    db $A2, $02 ; duty2 $02
    db $A0, $0C ; volume $0C
    db $33, $05 ; note D#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $33, $06 ; note D#3 dur 6
    db $A0, $0A ; volume $0A
    db $2A, $05 ; note A#2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $33, $06 ; note D#3 dur 6
    db $A0, $0A ; volume $0A
    db $27, $05 ; note G2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $2A, $06 ; note A#2 dur 6
    db $A0, $0A ; volume $0A
    db $23, $05 ; note D#2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $27, $06 ; note G2 dur 6
    db $A0, $0D ; volume $0D
    db $20, $05 ; note C2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $23, $06 ; note D#2 dur 6
    db $A0, $0A ; volume $0A
    db $23, $05 ; note D#2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $20, $06 ; note C2 dur 6
    db $A0, $0A ; volume $0A
    db $27, $05 ; note G2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $23, $06 ; note D#2 dur 6
    db $A0, $0A ; volume $0A
    db $2A, $05 ; note A#2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $27, $06 ; note G2 dur 6
    db $A0, $0A ; volume $0A
    db $33, $05 ; note D#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $2A, $06 ; note A#2 dur 6
    db $A0, $0A ; volume $0A
    db $37, $05 ; note G3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $33, $06 ; note D#3 dur 6
    db $A0, $0D ; volume $0D
    db $36, $05 ; note F#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $37, $06 ; note G3 dur 6
    db $A0, $0A ; volume $0A
    db $30, $05 ; note C3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $36, $06 ; note F#3 dur 6
    db $A0, $0A ; volume $0A
    db $29, $05 ; note A2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $30, $06 ; note C3 dur 6
    db $A0, $0A ; volume $0A
    db $30, $05 ; note C3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $29, $06 ; note A2 dur 6
    db $A0, $0D ; volume $0D
    db $36, $05 ; note F#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $30, $06 ; note C3 dur 6
    db $A0, $0A ; volume $0A
    db $30, $05 ; note C3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $36, $06 ; note F#3 dur 6
    db $A0, $0D ; volume $0D
    db $39, $05 ; note A3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $30, $06 ; note C3 dur 6
    db $A0, $0A ; volume $0A
    db $30, $05 ; note C3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $39, $06 ; note A3 dur 6
    db $A0, $0A ; volume $0A
    db $29, $05 ; note A2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $30, $06 ; note C3 dur 6
    db $A0, $0A ; volume $0A
    db $26, $05 ; note F#2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $29, $06 ; note A2 dur 6
    db $A0, $09 ; volume $09
    db $20, $05 ; note C2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $26, $06 ; note F#2 dur 6
    db $A0, $08 ; volume $08
    db $36, $05 ; note F#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $20, $06 ; note C2 dur 6
    db $A2, $01 ; duty2 $01
    db $C3, $48 ; env $48
    db $A0, $0C ; volume $0C
    db $22, $06 ; note D2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2A, $06 ; note A#2 dur 6
    db $27, $06 ; note G2 dur 6
    db $22, $06 ; note D2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2A, $06 ; note A#2 dur 6
    db $27, $06 ; note G2 dur 6
    db $22, $06 ; note D2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2A, $06 ; note A#2 dur 6
    db $27, $06 ; note G2 dur 6
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $2A, $06 ; note A#2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $2A, $06 ; note A#2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $2A, $06 ; note A#2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $25, $06 ; note F2 dur 6
    db $2A, $06 ; note A#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $22, $06 ; note D2 dur 6
    db $25, $06 ; note F2 dur 6
    db $2A, $06 ; note A#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $22, $06 ; note D2 dur 6
    db $25, $06 ; note F2 dur 6
    db $2A, $06 ; note A#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $22, $06 ; note D2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2A, $06 ; note A#2 dur 6
    db $27, $06 ; note G2 dur 6
    db $22, $06 ; note D2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2A, $06 ; note A#2 dur 6
    db $27, $06 ; note G2 dur 6
    db $22, $06 ; note D2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2A, $06 ; note A#2 dur 6
    db $27, $06 ; note G2 dur 6
    db $A0, $03 ; volume $03
    db $2A, $06 ; note A#2 dur 6
    db $27, $06 ; note G2 dur 6
    db $1F, $0C ; rest-note $1F dur 12
    db $A2, $00 ; duty2 $00
    db $C3, $38 ; env $38
    db $A0, $0B ; volume $0B
    db $32, $0C ; note D3 dur 12
    db $C2, $48 ; env $48
    db $A0, $08 ; volume $08
    db $2A, $05 ; note A#2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $2A, $06 ; note A#2 dur 6
    db $A0, $08 ; volume $08
    db $27, $05 ; note G2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $2A, $06 ; note A#2 dur 6
    db $A0, $08 ; volume $08
    db $22, $05 ; note D2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $27, $06 ; note G2 dur 6
    db $C3, $38 ; env $38
    db $A0, $0B ; volume $0B
    db $33, $0C ; note D#3 dur 12
    db $C2, $48 ; env $48
    db $A0, $08 ; volume $08
    db $20, $05 ; note C2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $33, $06 ; note D#3 dur 6
    db $A0, $08 ; volume $08
    db $27, $05 ; note G2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $20, $06 ; note C2 dur 6
    db $A0, $08 ; volume $08
    db $2A, $05 ; note A#2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $27, $06 ; note G2 dur 6
    db $C3, $38 ; env $38
    db $A0, $0B ; volume $0B
    db $37, $0C ; note G3 dur 12
    db $C2, $48 ; env $48
    db $A0, $08 ; volume $08
    db $27, $05 ; note G2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $37, $06 ; note G3 dur 6
    db $C3, $38 ; env $38
    db $A0, $0B ; volume $0B
    db $37, $0C ; note G3 dur 12
    db $C2, $48 ; env $48
    db $A0, $08 ; volume $08
    db $27, $05 ; note G2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $37, $06 ; note G3 dur 6
    db $A0, $08 ; volume $08
    db $29, $05 ; note A2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $27, $06 ; note G2 dur 6
    db $A0, $08 ; volume $08
    db $30, $05 ; note C3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $29, $06 ; note A2 dur 6
    db $C3, $38 ; env $38
    db $A0, $0B ; volume $0B
    db $39, $0C ; note A3 dur 12
    db $C2, $48 ; env $48
    db $A0, $08 ; volume $08
    db $30, $05 ; note C3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $39, $06 ; note A3 dur 6
    db $C3, $38 ; env $38
    db $A0, $0B ; volume $0B
    db $33, $0C ; note D#3 dur 12
    db $C2, $48 ; env $48
    db $A0, $08 ; volume $08
    db $23, $05 ; note D#2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $33, $06 ; note D#3 dur 6
    db $A0, $08 ; volume $08
    db $27, $05 ; note G2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $23, $06 ; note D#2 dur 6
    db $A0, $08 ; volume $08
    db $30, $05 ; note C3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $27, $06 ; note G2 dur 6
    db $C3, $38 ; env $38
    db $A0, $0B ; volume $0B
    db $33, $0C ; note D#3 dur 12
    db $C2, $48 ; env $48
    db $A0, $08 ; volume $08
    db $29, $05 ; note A2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $33, $06 ; note D#3 dur 6
    db $C3, $40 ; env $40
    db $A0, $0B ; volume $0B
    db $36, $0C ; note F#3 dur 12
    db $C1, $30 ; env $30
    db $A0, $05 ; volume $05
    db $36, $0C ; note F#3 dur 12
    db $A2, $00 ; duty2 $00
    db $C3, $58 ; env $58
    db $A0, $0D ; volume $0D
    db $19, $0C ; note A1 dur 12
    db $19, $0C ; note A1 dur 12
    db $20, $0C ; note C2 dur 12
    db $26, $0C ; note F#2 dur 12
    db $C3, $68 ; env $68
    db $A0, $0B ; volume $0B
    db $36, $0C ; note F#3 dur 12
    db $30, $0C ; note C3 dur 12
    db $2A, $0C ; note A#2 dur 12
    db $26, $0C ; note F#2 dur 12
    db $22, $0C ; note D2 dur 12
    db $20, $0C ; note C2 dur 12
    db $35, $0C ; note F3 dur 12
    db $33, $0C ; note D#3 dur 12
    db $30, $0C ; note C3 dur 12
    db $29, $0C ; note A2 dur 12
    db $25, $0C ; note F2 dur 12
    db $23, $0C ; note D#2 dur 12
    db $19, $0C ; note A1 dur 12
    db $A0, $05 ; volume $05
    db $19, $18 ; note A1 dur 24
    db $A2, $02 ; duty2 $02
    db $C1, $7F ; env $7F
    db $A0, $03 ; volume $03
    db $35, $18 ; note F3 dur 24
    db $37, $0C ; note G3 dur 12
    db $B0, $F3 ; jump $F3
    db $FF, $FF ; end

; sound track, 493 events after the header (E-0019: grammar C2, meaning C0)
Data_041_7267:: ; heuristic: track stream of a sound record; C0
    db $01, $00, $09, $00 ; header: param=1 byte1=$00 volume=$09 byte3=$00
    db $A2, $01 ; duty2 $01
    db $1F, $03 ; rest-note $1F dur 3
    db $A0, $03 ; volume $03
    db $25, $03 ; note F2 dur 3
    db $A0, $06 ; volume $06
    db $25, $03 ; note F2 dur 3
    db $26, $03 ; note F#2 dur 3
    db $27, $03 ; note G2 dur 3
    db $28, $03 ; note G#2 dur 3
    db $29, $03 ; note A2 dur 3
    db $28, $03 ; note G#2 dur 3
    db $1F, $18 ; rest-note $1F dur 24
    db $C3, $68 ; env $68
    db $A3, $0E ; mod $0E
    db $A2, $02 ; duty2 $02
    db $A0, $0E ; volume $0E
    db $35, $12 ; note F3 dur 18
    db $A0, $07 ; volume $07
    db $35, $06 ; note F3 dur 6
    db $A0, $0E ; volume $0E
    db $37, $12 ; note G3 dur 18
    db $A0, $07 ; volume $07
    db $37, $06 ; note G3 dur 6
    db $FD, $F3 ; label 3
    db $A3, $00 ; mod $00
    db $C3, $7F ; env $7F
    db $A0, $0E ; volume $0E
    db $42, $22 ; note D4 dur 34
    db $C1, $7F ; env $7F
    db $A0, $06 ; volume $06
    db $42, $0E ; note D4 dur 14
    db $C3, $68 ; env $68
    db $A3, $0F ; mod $0F
    db $A0, $0E ; volume $0E
    db $35, $0C ; note F3 dur 12
    db $37, $0C ; note G3 dur 12
    db $A3, $00 ; mod $00
    db $C3, $7F ; env $7F
    db $40, $22 ; note C4 dur 34
    db $C1, $78 ; env $78
    db $A0, $06 ; volume $06
    db $40, $0E ; note C4 dur 14
    db $C3, $68 ; env $68
    db $A3, $0F ; mod $0F
    db $A0, $0E ; volume $0E
    db $35, $0C ; note F3 dur 12
    db $37, $0C ; note G3 dur 12
    db $C3, $7F ; env $7F
    db $A3, $00 ; mod $00
    db $3A, $22 ; note A#3 dur 34
    db $C1, $7F ; env $7F
    db $A0, $06 ; volume $06
    db $3A, $0E ; note A#3 dur 14
    db $C3, $58 ; env $58
    db $A3, $0E ; mod $0E
    db $A0, $0E ; volume $0E
    db $39, $0C ; note A3 dur 12
    db $3A, $0C ; note A#3 dur 12
    db $C0, $FE ; env $FE
    db $A0, $0B ; volume $0B
    db $39, $24 ; note A3 dur 36
    db $A0, $0E ; volume $0E
    db $C3, $58 ; env $58
    db $37, $0C ; note G3 dur 12
    db $35, $0C ; note F3 dur 12
    db $33, $0C ; note D#3 dur 12
    db $C0, $FE ; env $FE
    db $A0, $0A ; volume $0A
    db $32, $24 ; note D3 dur 36
    db $A0, $0E ; volume $0E
    db $C3, $78 ; env $78
    db $33, $0C ; note D#3 dur 12
    db $34, $0C ; note E3 dur 12
    db $35, $0C ; note F3 dur 12
    db $C0, $FE ; env $FE
    db $A0, $0A ; volume $0A
    db $37, $30 ; note G3 dur 48
    db $C3, $78 ; env $78
    db $A0, $0E ; volume $0E
    db $35, $0C ; note F3 dur 12
    db $33, $0C ; note D#3 dur 12
    db $A0, $0B ; volume $0B
    db $30, $0C ; note C3 dur 12
    db $A0, $06 ; volume $06
    db $30, $0C ; note C3 dur 12
    db $C3, $38 ; env $38
    db $A2, $02 ; duty2 $02
    db $A0, $0E ; volume $0E
    db $30, $06 ; note C3 dur 6
    db $A0, $05 ; volume $05
    db $30, $06 ; note C3 dur 6
    db $A0, $0E ; volume $0E
    db $40, $06 ; note C4 dur 6
    db $A0, $05 ; volume $05
    db $30, $06 ; note C3 dur 6
    db $A0, $0E ; volume $0E
    db $41, $06 ; note C#4 dur 6
    db $A0, $05 ; volume $05
    db $40, $06 ; note C4 dur 6
    db $A0, $0E ; volume $0E
    db $31, $06 ; note C#3 dur 6
    db $A0, $05 ; volume $05
    db $41, $06 ; note C#4 dur 6
    db $A0, $0E ; volume $0E
    db $32, $06 ; note D3 dur 6
    db $A0, $05 ; volume $05
    db $31, $06 ; note C#3 dur 6
    db $A0, $0E ; volume $0E
    db $42, $06 ; note D4 dur 6
    db $A0, $05 ; volume $05
    db $32, $06 ; note D3 dur 6
    db $A0, $0E ; volume $0E
    db $43, $06 ; note D#4 dur 6
    db $C1, $2F ; env $2F
    db $A0, $03 ; volume $03
    db $43, $12 ; note D#4 dur 18
    db $C3, $68 ; env $68
    db $A3, $09 ; mod $09
    db $A2, $00 ; duty2 $00
    db $A0, $0E ; volume $0E
    db $33, $0C ; note D#3 dur 12
    db $35, $0C ; note F3 dur 12
    db $A3, $FE ; mod $FE
    db $40, $24 ; note C4 dur 36
    db $C1, $7F ; env $7F
    db $A3, $00 ; mod $00
    db $A0, $06 ; volume $06
    db $40, $0C ; note C4 dur 12
    db $C3, $68 ; env $68
    db $A3, $FE ; mod $FE
    db $A0, $0E ; volume $0E
    db $33, $0C ; note D#3 dur 12
    db $35, $0C ; note F3 dur 12
    db $3A, $20 ; note A#3 dur 32
    db $C1, $7F ; env $7F
    db $A3, $00 ; mod $00
    db $A0, $06 ; volume $06
    db $3A, $10 ; note A#3 dur 16
    db $C3, $68 ; env $68
    db $A3, $FE ; mod $FE
    db $A0, $0E ; volume $0E
    db $33, $0C ; note D#3 dur 12
    db $35, $0C ; note F3 dur 12
    db $39, $20 ; note A3 dur 32
    db $C1, $7F ; env $7F
    db $A3, $00 ; mod $00
    db $A0, $06 ; volume $06
    db $39, $10 ; note A3 dur 16
    db $C3, $68 ; env $68
    db $A3, $FE ; mod $FE
    db $A0, $0E ; volume $0E
    db $37, $0C ; note G3 dur 12
    db $39, $0C ; note A3 dur 12
    db $C0, $FE ; env $FE
    db $A0, $0A ; volume $0A
    db $37, $24 ; note G3 dur 36
    db $C3, $68 ; env $68
    db $A0, $0E ; volume $0E
    db $36, $0C ; note F#3 dur 12
    db $35, $0C ; note F3 dur 12
    db $33, $0C ; note D#3 dur 12
    db $C0, $FE ; env $FE
    db $A0, $0A ; volume $0A
    db $30, $24 ; note C3 dur 36
    db $C3, $68 ; env $68
    db $A0, $0E ; volume $0E
    db $32, $0C ; note D3 dur 12
    db $33, $0C ; note D#3 dur 12
    db $37, $0C ; note G3 dur 12
    db $C0, $FE ; env $FE
    db $A0, $0A ; volume $0A
    db $35, $24 ; note F3 dur 36
    db $A0, $0E ; volume $0E
    db $C3, $68 ; env $68
    db $33, $0C ; note D#3 dur 12
    db $32, $0C ; note D3 dur 12
    db $30, $0C ; note C3 dur 12
    db $C0, $FE ; env $FE
    db $A0, $0A ; volume $0A
    db $2A, $24 ; note A#2 dur 36
    db $C1, $7F ; env $7F
    db $A3, $00 ; mod $00
    db $A0, $07 ; volume $07
    db $2A, $0C ; note A#2 dur 12
    db $C0, $FE ; env $FE
    db $A0, $0A ; volume $0A
    db $A3, $02 ; mod $02
    db $30, $24 ; note C3 dur 36
    db $C1, $7F ; env $7F
    db $A3, $00 ; mod $00
    db $A0, $07 ; volume $07
    db $30, $0C ; note C3 dur 12
    db $C0, $FE ; env $FE
    db $A0, $0B ; volume $0B
    db $A3, $09 ; mod $09
    db $31, $12 ; note C#3 dur 18
    db $A0, $05 ; volume $05
    db $31, $06 ; note C#3 dur 6
    db $A0, $0E ; volume $0E
    db $32, $12 ; note D3 dur 18
    db $C1, $50 ; env $50
    db $A0, $05 ; volume $05
    db $32, $1E ; note D3 dur 30
    db $A2, $02 ; duty2 $02
    db $C2, $38 ; env $38
    db $A0, $0D ; volume $0D
    db $37, $05 ; note G3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $37, $06 ; note G3 dur 6
    db $A0, $0B ; volume $0B
    db $33, $05 ; note D#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $37, $06 ; note G3 dur 6
    db $A0, $0B ; volume $0B
    db $2A, $05 ; note A#2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $33, $06 ; note D#3 dur 6
    db $A0, $0B ; volume $0B
    db $27, $05 ; note G2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $2A, $06 ; note A#2 dur 6
    db $A0, $0D ; volume $0D
    db $23, $05 ; note D#2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $27, $06 ; note G2 dur 6
    db $A0, $0B ; volume $0B
    db $27, $05 ; note G2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $23, $06 ; note D#2 dur 6
    db $A0, $0B ; volume $0B
    db $2A, $05 ; note A#2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $27, $06 ; note G2 dur 6
    db $A0, $0B ; volume $0B
    db $33, $05 ; note D#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $2A, $06 ; note A#2 dur 6
    db $A0, $0B ; volume $0B
    db $37, $05 ; note G3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $33, $06 ; note D#3 dur 6
    db $A0, $0B ; volume $0B
    db $3A, $05 ; note A#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $37, $06 ; note G3 dur 6
    db $A0, $0D ; volume $0D
    db $39, $05 ; note A3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $3A, $06 ; note A#3 dur 6
    db $A0, $0B ; volume $0B
    db $36, $05 ; note F#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $39, $06 ; note A3 dur 6
    db $A0, $0B ; volume $0B
    db $32, $05 ; note D3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $36, $06 ; note F#3 dur 6
    db $A0, $0B ; volume $0B
    db $36, $05 ; note F#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $32, $06 ; note D3 dur 6
    db $A0, $0D ; volume $0D
    db $42, $05 ; note D4 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $36, $06 ; note F#3 dur 6
    db $A0, $0B ; volume $0B
    db $36, $05 ; note F#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $42, $06 ; note D4 dur 6
    db $A0, $0D ; volume $0D
    db $40, $05 ; note C4 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $36, $06 ; note F#3 dur 6
    db $A0, $0B ; volume $0B
    db $36, $05 ; note F#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $40, $06 ; note C4 dur 6
    db $A0, $0B ; volume $0B
    db $32, $05 ; note D3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $36, $06 ; note F#3 dur 6
    db $A0, $0B ; volume $0B
    db $30, $05 ; note C3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $32, $06 ; note D3 dur 6
    db $A0, $0A ; volume $0A
    db $29, $05 ; note A2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $30, $06 ; note C3 dur 6
    db $A0, $08 ; volume $08
    db $39, $05 ; note A3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $29, $06 ; note A2 dur 6
    db $39, $06 ; note A3 dur 6
    db $22, $06 ; note D2 dur 6
    db $A2, $00 ; duty2 $00
    db $C3, $48 ; env $48
    db $27, $06 ; note G2 dur 6
    db $2A, $06 ; note A#2 dur 6
    db $A0, $0E ; volume $0E
    db $37, $0C ; note G3 dur 12
    db $39, $0C ; note A3 dur 12
    db $3A, $0C ; note A#3 dur 12
    db $37, $0C ; note G3 dur 12
    db $C0, $FE ; env $FE
    db $A3, $FE ; mod $FE
    db $A0, $0B ; volume $0B
    db $42, $48 ; note D4 dur 72
    db $C1, $7F ; env $7F
    db $A3, $00 ; mod $00
    db $A0, $06 ; volume $06
    db $42, $18 ; note D4 dur 24
    db $C3, $48 ; env $48
    db $A3, $09 ; mod $09
    db $A0, $0E ; volume $0E
    db $37, $0C ; note G3 dur 12
    db $39, $0C ; note A3 dur 12
    db $3A, $0C ; note A#3 dur 12
    db $37, $0C ; note G3 dur 12
    db $C0, $FE ; env $FE
    db $A3, $FE ; mod $FE
    db $A0, $0A ; volume $0A
    db $47, $48 ; note G4 dur 72
    db $C1, $7F ; env $7F
    db $A3, $00 ; mod $00
    db $A0, $06 ; volume $06
    db $47, $18 ; note G4 dur 24
    db $A2, $02 ; duty2 $02
    db $A3, $09 ; mod $09
    db $C3, $38 ; env $38
    db $A0, $0E ; volume $0E
    db $37, $0C ; note G3 dur 12
    db $C2, $48 ; env $48
    db $A0, $0A ; volume $0A
    db $32, $05 ; note D3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $05 ; volume $05
    db $37, $06 ; note G3 dur 6
    db $A0, $0A ; volume $0A
    db $2A, $05 ; note A#2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $05 ; volume $05
    db $32, $06 ; note D3 dur 6
    db $A0, $0A ; volume $0A
    db $27, $05 ; note G2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $05 ; volume $05
    db $2A, $06 ; note A#2 dur 6
    db $C3, $38 ; env $38
    db $A0, $0E ; volume $0E
    db $39, $0C ; note A3 dur 12
    db $C2, $48 ; env $48
    db $A0, $0A ; volume $0A
    db $23, $05 ; note D#2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $05 ; volume $05
    db $39, $06 ; note A3 dur 6
    db $A0, $0A ; volume $0A
    db $2A, $05 ; note A#2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $05 ; volume $05
    db $23, $06 ; note D#2 dur 6
    db $A0, $0A ; volume $0A
    db $33, $05 ; note D#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $05 ; volume $05
    db $2A, $06 ; note A#2 dur 6
    db $C3, $38 ; env $38
    db $A0, $0E ; volume $0E
    db $3A, $0C ; note A#3 dur 12
    db $C2, $48 ; env $48
    db $A0, $0A ; volume $0A
    db $33, $05 ; note D#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $05 ; volume $05
    db $3A, $06 ; note A#3 dur 6
    db $C3, $38 ; env $38
    db $A0, $0E ; volume $0E
    db $42, $0C ; note D4 dur 12
    db $C2, $48 ; env $48
    db $A0, $0A ; volume $0A
    db $33, $05 ; note D#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $05 ; volume $05
    db $42, $06 ; note D4 dur 6
    db $A0, $0A ; volume $0A
    db $30, $05 ; note C3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $05 ; volume $05
    db $33, $06 ; note D#3 dur 6
    db $A0, $0A ; volume $0A
    db $33, $05 ; note D#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $05 ; volume $05
    db $30, $06 ; note C3 dur 6
    db $C3, $38 ; env $38
    db $A0, $0E ; volume $0E
    db $40, $0C ; note C4 dur 12
    db $C2, $48 ; env $48
    db $A0, $0A ; volume $0A
    db $33, $05 ; note D#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $05 ; volume $05
    db $40, $06 ; note C4 dur 6
    db $C3, $38 ; env $38
    db $A0, $0E ; volume $0E
    db $37, $0C ; note G3 dur 12
    db $C2, $48 ; env $48
    db $A0, $0A ; volume $0A
    db $27, $05 ; note G2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $05 ; volume $05
    db $37, $06 ; note G3 dur 6
    db $A0, $0A ; volume $0A
    db $30, $05 ; note C3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $05 ; volume $05
    db $27, $06 ; note G2 dur 6
    db $A0, $0A ; volume $0A
    db $33, $05 ; note D#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $05 ; volume $05
    db $30, $06 ; note C3 dur 6
    db $C3, $38 ; env $38
    db $A0, $0E ; volume $0E
    db $39, $0C ; note A3 dur 12
    db $C2, $48 ; env $48
    db $A0, $0A ; volume $0A
    db $30, $05 ; note C3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $05 ; volume $05
    db $39, $06 ; note A3 dur 6
    db $C3, $40 ; env $40
    db $A0, $0E ; volume $0E
    db $3A, $0C ; note A#3 dur 12
    db $C1, $30 ; env $30
    db $A0, $06 ; volume $06
    db $3A, $0C ; note A#3 dur 12
    db $C3, $68 ; env $68
    db $A2, $01 ; duty2 $01
    db $A0, $0E ; volume $0E
    db $20, $0C ; note C2 dur 12
    db $22, $0C ; note D2 dur 12
    db $26, $0C ; note F#2 dur 12
    db $2A, $0C ; note A#2 dur 12
    db $3A, $0C ; note A#3 dur 12
    db $36, $0C ; note F#3 dur 12
    db $32, $0C ; note D3 dur 12
    db $30, $0C ; note C3 dur 12
    db $2A, $0C ; note A#2 dur 12
    db $26, $0C ; note F#2 dur 12
    db $39, $0C ; note A3 dur 12
    db $37, $0C ; note G3 dur 12
    db $33, $0C ; note D#3 dur 12
    db $30, $0C ; note C3 dur 12
    db $29, $0C ; note A2 dur 12
    db $27, $0C ; note G2 dur 12
    db $25, $0C ; note F2 dur 12
    db $A0, $06 ; volume $06
    db $25, $0C ; note F2 dur 12
    db $A2, $02 ; duty2 $02
    db $A0, $0E ; volume $0E
    db $35, $12 ; note F3 dur 18
    db $A0, $07 ; volume $07
    db $35, $06 ; note F3 dur 6
    db $A0, $0E ; volume $0E
    db $37, $12 ; note G3 dur 18
    db $A0, $07 ; volume $07
    db $37, $06 ; note G3 dur 6
    db $B0, $F3 ; jump $F3
    db $FF, $FF ; end

; sound track, 289 events after the header (E-0019: grammar C2, meaning C0)
Data_041_7645:: ; heuristic: track stream of a sound record; C0
    db $01, $70, $02, $02 ; header: param=1 byte1=$70 volume=$02 byte3=$02
    db $A3, $07 ; mod $07
    db $A2, $50 ; duty2 $50
    db $A1, $03 ; duty $03
    db $A0, $02 ; volume $02
    db $29, $03 ; note A2 dur 3
    db $2A, $03 ; note A#2 dur 3
    db $2B, $03 ; note B2 dur 3
    db $30, $03 ; note C3 dur 3
    db $31, $03 ; note C#3 dur 3
    db $30, $03 ; note C3 dur 3
    db $2B, $03 ; note B2 dur 3
    db $2A, $03 ; note A#2 dur 3
    db $29, $24 ; note A2 dur 36
    db $A0, $04 ; volume $04
    db $29, $0C ; note A2 dur 12
    db $A0, $06 ; volume $06
    db $29, $18 ; note A2 dur 24
    db $FD, $F3 ; label 3
    db $A1, $02 ; duty $02
    db $A0, $02 ; volume $02
    db $1A, $0C ; note A#1 dur 12
    db $25, $0C ; note F2 dur 12
    db $2A, $12 ; note A#2 dur 18
    db $A0, $04 ; volume $04
    db $2A, $06 ; note A#2 dur 6
    db $A0, $02 ; volume $02
    db $25, $12 ; note F2 dur 18
    db $A0, $04 ; volume $04
    db $25, $06 ; note F2 dur 6
    db $A0, $02 ; volume $02
    db $19, $0C ; note A1 dur 12
    db $25, $0C ; note F2 dur 12
    db $29, $12 ; note A2 dur 18
    db $A0, $04 ; volume $04
    db $29, $06 ; note A2 dur 6
    db $A0, $02 ; volume $02
    db $25, $12 ; note F2 dur 18
    db $A0, $04 ; volume $04
    db $25, $06 ; note F2 dur 6
    db $A0, $02 ; volume $02
    db $17, $0C ; note G1 dur 12
    db $22, $0C ; note D2 dur 12
    db $27, $12 ; note G2 dur 18
    db $A0, $04 ; volume $04
    db $27, $06 ; note G2 dur 6
    db $A0, $02 ; volume $02
    db $22, $12 ; note D2 dur 18
    db $A0, $04 ; volume $04
    db $22, $06 ; note D2 dur 6
    db $A0, $02 ; volume $02
    db $15, $0C ; note F1 dur 12
    db $25, $0C ; note F2 dur 12
    db $30, $12 ; note C3 dur 18
    db $A0, $04 ; volume $04
    db $30, $06 ; note C3 dur 6
    db $A0, $02 ; volume $02
    db $29, $12 ; note A2 dur 18
    db $A0, $04 ; volume $04
    db $29, $06 ; note A2 dur 6
    db $A0, $02 ; volume $02
    db $1A, $0C ; note A#1 dur 12
    db $25, $0C ; note F2 dur 12
    db $2A, $12 ; note A#2 dur 18
    db $A0, $04 ; volume $04
    db $2A, $06 ; note A#2 dur 6
    db $A0, $02 ; volume $02
    db $25, $12 ; note F2 dur 18
    db $A0, $04 ; volume $04
    db $25, $06 ; note F2 dur 6
    db $A0, $02 ; volume $02
    db $1A, $0C ; note A#1 dur 12
    db $23, $0C ; note D#2 dur 12
    db $30, $12 ; note C3 dur 18
    db $A0, $04 ; volume $04
    db $30, $06 ; note C3 dur 6
    db $A0, $02 ; volume $02
    db $27, $12 ; note G2 dur 18
    db $A0, $04 ; volume $04
    db $27, $06 ; note G2 dur 6
    db $A2, $28 ; duty2 $28
    db $A0, $02 ; volume $02
    db $15, $12 ; note F1 dur 18
    db $A0, $04 ; volume $04
    db $15, $06 ; note F1 dur 6
    db $A0, $02 ; volume $02
    db $25, $12 ; note F2 dur 18
    db $A0, $04 ; volume $04
    db $25, $06 ; note F2 dur 6
    db $A0, $02 ; volume $02
    db $15, $12 ; note F1 dur 18
    db $A0, $04 ; volume $04
    db $15, $06 ; note F1 dur 6
    db $A0, $02 ; volume $02
    db $25, $12 ; note F2 dur 18
    db $A0, $04 ; volume $04
    db $25, $06 ; note F2 dur 6
    db $A0, $02 ; volume $02
    db $15, $0C ; note F1 dur 12
    db $A0, $04 ; volume $04
    db $15, $0C ; note F1 dur 12
    db $1F, $18 ; rest-note $1F dur 24
    db $A2, $70 ; duty2 $70
    db $A0, $02 ; volume $02
    db $20, $18 ; note C2 dur 24
    db $A0, $06 ; volume $06
    db $20, $0C ; note C2 dur 12
    db $A2, $40 ; duty2 $40
    db $A0, $02 ; volume $02
    db $30, $0C ; note C3 dur 12
    db $A0, $04 ; volume $04
    db $30, $0C ; note C3 dur 12
    db $A0, $02 ; volume $02
    db $30, $0C ; note C3 dur 12
    db $A2, $70 ; duty2 $70
    db $20, $18 ; note C2 dur 24
    db $A0, $06 ; volume $06
    db $20, $0C ; note C2 dur 12
    db $A2, $30 ; duty2 $30
    db $A0, $02 ; volume $02
    db $30, $0C ; note C3 dur 12
    db $A0, $04 ; volume $04
    db $30, $0C ; note C3 dur 12
    db $A0, $02 ; volume $02
    db $30, $0C ; note C3 dur 12
    db $A2, $70 ; duty2 $70
    db $15, $18 ; note F1 dur 24
    db $A0, $06 ; volume $06
    db $15, $0C ; note F1 dur 12
    db $A2, $30 ; duty2 $30
    db $A0, $02 ; volume $02
    db $25, $0C ; note F2 dur 12
    db $A0, $04 ; volume $04
    db $25, $0C ; note F2 dur 12
    db $A0, $02 ; volume $02
    db $25, $0C ; note F2 dur 12
    db $A2, $70 ; duty2 $70
    db $15, $18 ; note F1 dur 24
    db $A0, $06 ; volume $06
    db $15, $0C ; note F1 dur 12
    db $A2, $30 ; duty2 $30
    db $A0, $02 ; volume $02
    db $25, $0C ; note F2 dur 12
    db $A0, $04 ; volume $04
    db $25, $0C ; note F2 dur 12
    db $A0, $02 ; volume $02
    db $25, $0C ; note F2 dur 12
    db $A2, $70 ; duty2 $70
    db $20, $18 ; note C2 dur 24
    db $A0, $06 ; volume $06
    db $20, $0C ; note C2 dur 12
    db $A2, $30 ; duty2 $30
    db $A0, $02 ; volume $02
    db $30, $0C ; note C3 dur 12
    db $A0, $04 ; volume $04
    db $30, $0C ; note C3 dur 12
    db $A0, $02 ; volume $02
    db $30, $0C ; note C3 dur 12
    db $A2, $70 ; duty2 $70
    db $15, $18 ; note F1 dur 24
    db $A0, $06 ; volume $06
    db $15, $0C ; note F1 dur 12
    db $A2, $30 ; duty2 $30
    db $A0, $02 ; volume $02
    db $25, $0C ; note F2 dur 12
    db $A0, $04 ; volume $04
    db $25, $0C ; note F2 dur 12
    db $A0, $02 ; volume $02
    db $25, $0C ; note F2 dur 12
    db $A2, $70 ; duty2 $70
    db $1A, $0C ; note A#1 dur 12
    db $15, $0C ; note F1 dur 12
    db $1A, $0C ; note A#1 dur 12
    db $25, $0C ; note F2 dur 12
    db $A0, $04 ; volume $04
    db $25, $0C ; note F2 dur 12
    db $A0, $02 ; volume $02
    db $25, $0C ; note F2 dur 12
    db $1A, $0C ; note A#1 dur 12
    db $15, $0C ; note F1 dur 12
    db $1A, $0C ; note A#1 dur 12
    db $25, $0C ; note F2 dur 12
    db $A0, $04 ; volume $04
    db $25, $0C ; note F2 dur 12
    db $A0, $02 ; volume $02
    db $1A, $0C ; note A#1 dur 12
    db $A2, $40 ; duty2 $40
    db $A1, $0B ; duty $0B
    db $13, $18 ; note D#1 dur 24
    db $A0, $04 ; volume $04
    db $13, $18 ; note D#1 dur 24
    db $A1, $09 ; duty $09
    db $A0, $02 ; volume $02
    db $23, $18 ; note D#2 dur 24
    db $A1, $0B ; duty $0B
    db $13, $18 ; note D#1 dur 24
    db $A0, $04 ; volume $04
    db $13, $18 ; note D#1 dur 24
    db $A1, $09 ; duty $09
    db $A0, $02 ; volume $02
    db $23, $18 ; note D#2 dur 24
    db $A1, $0B ; duty $0B
    db $12, $18 ; note D1 dur 24
    db $A0, $04 ; volume $04
    db $12, $18 ; note D1 dur 24
    db $A1, $09 ; duty $09
    db $A0, $02 ; volume $02
    db $22, $18 ; note D2 dur 24
    db $A1, $0B ; duty $0B
    db $12, $18 ; note D1 dur 24
    db $A0, $04 ; volume $04
    db $12, $18 ; note D1 dur 24
    db $A1, $09 ; duty $09
    db $A0, $02 ; volume $02
    db $22, $18 ; note D2 dur 24
    db $A2, $FF ; duty2 $FF
    db $A1, $0B ; duty $0B
    db $17, $3C ; note G1 dur 60
    db $A0, $04 ; volume $04
    db $17, $0C ; note G1 dur 12
    db $A0, $02 ; volume $02
    db $16, $3C ; note F#1 dur 60
    db $A0, $04 ; volume $04
    db $16, $0C ; note F#1 dur 12
    db $A0, $02 ; volume $02
    db $15, $3C ; note F1 dur 60
    db $A0, $04 ; volume $04
    db $15, $0C ; note F1 dur 12
    db $A0, $02 ; volume $02
    db $14, $3C ; note E1 dur 60
    db $A0, $04 ; volume $04
    db $14, $0C ; note E1 dur 12
    db $A1, $09 ; duty $09
    db $A0, $02 ; volume $02
    db $13, $18 ; note D#1 dur 24
    db $A1, $03 ; duty $03
    db $23, $24 ; note D#2 dur 36
    db $A0, $06 ; volume $06
    db $23, $0C ; note D#2 dur 12
    db $A1, $09 ; duty $09
    db $A0, $02 ; volume $02
    db $10, $18 ; note C1 dur 24
    db $A1, $03 ; duty $03
    db $20, $24 ; note C2 dur 36
    db $A0, $06 ; volume $06
    db $20, $0C ; note C2 dur 12
    db $A1, $09 ; duty $09
    db $A0, $02 ; volume $02
    db $19, $18 ; note A1 dur 24
    db $A1, $03 ; duty $03
    db $29, $24 ; note A2 dur 36
    db $A0, $06 ; volume $06
    db $29, $0C ; note A2 dur 12
    db $A1, $09 ; duty $09
    db $A0, $02 ; volume $02
    db $19, $18 ; note A1 dur 24
    db $A1, $03 ; duty $03
    db $29, $24 ; note A2 dur 36
    db $A0, $06 ; volume $06
    db $29, $0C ; note A2 dur 12
    db $A1, $09 ; duty $09
    db $A0, $02 ; volume $02
    db $12, $18 ; note D1 dur 24
    db $A1, $03 ; duty $03
    db $22, $24 ; note D2 dur 36
    db $A0, $06 ; volume $06
    db $22, $0C ; note D2 dur 12
    db $A1, $09 ; duty $09
    db $A0, $02 ; volume $02
    db $12, $18 ; note D1 dur 24
    db $A1, $03 ; duty $03
    db $22, $24 ; note D2 dur 36
    db $A0, $06 ; volume $06
    db $22, $0C ; note D2 dur 12
    db $A1, $09 ; duty $09
    db $A0, $02 ; volume $02
    db $15, $18 ; note F1 dur 24
    db $A1, $03 ; duty $03
    db $25, $24 ; note F2 dur 36
    db $A0, $06 ; volume $06
    db $25, $0C ; note F2 dur 12
    db $A1, $09 ; duty $09
    db $A2, $60 ; duty2 $60
    db $A0, $02 ; volume $02
    db $15, $0C ; note F1 dur 12
    db $A0, $04 ; volume $04
    db $15, $24 ; note F1 dur 36
    db $1F, $18 ; rest-note $1F dur 24
    db $B0, $F3 ; jump $F3
    db $FF, $FF ; end

; sound track, 491 events after the header (E-0019: grammar C2, meaning C0)
Data_041_788B:: ; heuristic: track stream of a sound record; C0
    db $07, $00, $09, $00 ; header: param=7 byte1=$00 volume=$09 byte3=$00
    db $A2, $00 ; duty2 $00
    db $A3, $08 ; mod $08
    db $C1, $70 ; env $70
    db $1F, $04 ; rest-note $1F dur 4
    db $A0, $03 ; volume $03
    db $14, $04 ; note E1 dur 4
    db $17, $04 ; note G1 dur 4
    db $1B, $04 ; note B1 dur 4
    db $24, $04 ; note E2 dur 4
    db $27, $04 ; note G2 dur 4
    db $2B, $04 ; note B2 dur 4
    db $34, $04 ; note E3 dur 4
    db $2B, $04 ; note B2 dur 4
    db $27, $04 ; note G2 dur 4
    db $24, $04 ; note E2 dur 4
    db $1B, $04 ; note B1 dur 4
    db $17, $04 ; note G1 dur 4
    db $14, $04 ; note E1 dur 4
    db $17, $04 ; note G1 dur 4
    db $1B, $04 ; note B1 dur 4
    db $24, $04 ; note E2 dur 4
    db $27, $04 ; note G2 dur 4
    db $2B, $04 ; note B2 dur 4
    db $34, $04 ; note E3 dur 4
    db $2B, $04 ; note B2 dur 4
    db $C2, $4F ; env $4F
    db $A0, $07 ; volume $07
    db $24, $04 ; note E2 dur 4
    db $17, $04 ; note G1 dur 4
    db $1B, $04 ; note B1 dur 4
    db $FD, $F3 ; label 3
    db $C2, $4F ; env $4F
    db $A0, $09 ; volume $09
    db $14, $04 ; note E1 dur 4
    db $17, $04 ; note G1 dur 4
    db $1B, $04 ; note B1 dur 4
    db $A0, $08 ; volume $08
    db $24, $04 ; note E2 dur 4
    db $27, $04 ; note G2 dur 4
    db $2B, $04 ; note B2 dur 4
    db $A0, $05 ; volume $05
    db $34, $04 ; note E3 dur 4
    db $2B, $04 ; note B2 dur 4
    db $27, $04 ; note G2 dur 4
    db $A0, $08 ; volume $08
    db $24, $04 ; note E2 dur 4
    db $1B, $04 ; note B1 dur 4
    db $17, $04 ; note G1 dur 4
    db $A0, $09 ; volume $09
    db $14, $04 ; note E1 dur 4
    db $19, $04 ; note A1 dur 4
    db $20, $04 ; note C2 dur 4
    db $A0, $08 ; volume $08
    db $24, $04 ; note E2 dur 4
    db $29, $04 ; note A2 dur 4
    db $30, $04 ; note C3 dur 4
    db $A0, $05 ; volume $05
    db $34, $04 ; note E3 dur 4
    db $30, $04 ; note C3 dur 4
    db $29, $04 ; note A2 dur 4
    db $A0, $08 ; volume $08
    db $24, $04 ; note E2 dur 4
    db $20, $04 ; note C2 dur 4
    db $19, $04 ; note A1 dur 4
    db $A0, $09 ; volume $09
    db $16, $04 ; note F#1 dur 4
    db $1B, $04 ; note B1 dur 4
    db $22, $04 ; note D2 dur 4
    db $A0, $08 ; volume $08
    db $26, $04 ; note F#2 dur 4
    db $2B, $04 ; note B2 dur 4
    db $32, $04 ; note D3 dur 4
    db $A0, $05 ; volume $05
    db $36, $04 ; note F#3 dur 4
    db $32, $04 ; note D3 dur 4
    db $2B, $04 ; note B2 dur 4
    db $A0, $08 ; volume $08
    db $26, $04 ; note F#2 dur 4
    db $22, $04 ; note D2 dur 4
    db $1B, $04 ; note B1 dur 4
    db $A0, $09 ; volume $09
    db $14, $04 ; note E1 dur 4
    db $17, $04 ; note G1 dur 4
    db $1B, $04 ; note B1 dur 4
    db $A0, $08 ; volume $08
    db $24, $04 ; note E2 dur 4
    db $27, $04 ; note G2 dur 4
    db $2B, $04 ; note B2 dur 4
    db $A0, $05 ; volume $05
    db $34, $04 ; note E3 dur 4
    db $2B, $04 ; note B2 dur 4
    db $27, $04 ; note G2 dur 4
    db $A0, $08 ; volume $08
    db $24, $04 ; note E2 dur 4
    db $1B, $04 ; note B1 dur 4
    db $17, $04 ; note G1 dur 4
    db $A0, $09 ; volume $09
    db $14, $04 ; note E1 dur 4
    db $19, $04 ; note A1 dur 4
    db $20, $04 ; note C2 dur 4
    db $A0, $08 ; volume $08
    db $24, $04 ; note E2 dur 4
    db $29, $04 ; note A2 dur 4
    db $30, $04 ; note C3 dur 4
    db $A0, $05 ; volume $05
    db $34, $04 ; note E3 dur 4
    db $30, $04 ; note C3 dur 4
    db $29, $04 ; note A2 dur 4
    db $A0, $08 ; volume $08
    db $24, $04 ; note E2 dur 4
    db $20, $04 ; note C2 dur 4
    db $19, $04 ; note A1 dur 4
    db $A0, $09 ; volume $09
    db $16, $04 ; note F#1 dur 4
    db $20, $04 ; note C2 dur 4
    db $24, $04 ; note E2 dur 4
    db $A0, $08 ; volume $08
    db $26, $04 ; note F#2 dur 4
    db $29, $04 ; note A2 dur 4
    db $30, $04 ; note C3 dur 4
    db $A0, $05 ; volume $05
    db $34, $04 ; note E3 dur 4
    db $30, $04 ; note C3 dur 4
    db $29, $04 ; note A2 dur 4
    db $A0, $08 ; volume $08
    db $26, $04 ; note F#2 dur 4
    db $24, $04 ; note E2 dur 4
    db $20, $04 ; note C2 dur 4
    db $A0, $09 ; volume $09
    db $16, $04 ; note F#1 dur 4
    db $1B, $04 ; note B1 dur 4
    db $22, $04 ; note D2 dur 4
    db $A0, $08 ; volume $08
    db $26, $04 ; note F#2 dur 4
    db $2B, $04 ; note B2 dur 4
    db $32, $04 ; note D3 dur 4
    db $A0, $05 ; volume $05
    db $36, $04 ; note F#3 dur 4
    db $32, $04 ; note D3 dur 4
    db $2B, $04 ; note B2 dur 4
    db $A0, $08 ; volume $08
    db $26, $04 ; note F#2 dur 4
    db $22, $04 ; note D2 dur 4
    db $1B, $04 ; note B1 dur 4
    db $A0, $09 ; volume $09
    db $14, $04 ; note E1 dur 4
    db $17, $04 ; note G1 dur 4
    db $1B, $04 ; note B1 dur 4
    db $A0, $08 ; volume $08
    db $24, $04 ; note E2 dur 4
    db $27, $04 ; note G2 dur 4
    db $2B, $04 ; note B2 dur 4
    db $A0, $05 ; volume $05
    db $34, $04 ; note E3 dur 4
    db $2B, $04 ; note B2 dur 4
    db $27, $04 ; note G2 dur 4
    db $A0, $08 ; volume $08
    db $24, $04 ; note E2 dur 4
    db $1B, $04 ; note B1 dur 4
    db $17, $04 ; note G1 dur 4
    db $A0, $09 ; volume $09
    db $14, $04 ; note E1 dur 4
    db $19, $04 ; note A1 dur 4
    db $20, $04 ; note C2 dur 4
    db $A0, $08 ; volume $08
    db $24, $04 ; note E2 dur 4
    db $29, $04 ; note A2 dur 4
    db $30, $04 ; note C3 dur 4
    db $A0, $05 ; volume $05
    db $34, $04 ; note E3 dur 4
    db $30, $04 ; note C3 dur 4
    db $29, $04 ; note A2 dur 4
    db $A0, $08 ; volume $08
    db $24, $04 ; note E2 dur 4
    db $20, $04 ; note C2 dur 4
    db $19, $04 ; note A1 dur 4
    db $A0, $09 ; volume $09
    db $12, $04 ; note D1 dur 4
    db $19, $04 ; note A1 dur 4
    db $20, $04 ; note C2 dur 4
    db $A0, $08 ; volume $08
    db $26, $04 ; note F#2 dur 4
    db $29, $04 ; note A2 dur 4
    db $30, $04 ; note C3 dur 4
    db $A0, $05 ; volume $05
    db $34, $04 ; note E3 dur 4
    db $30, $04 ; note C3 dur 4
    db $29, $04 ; note A2 dur 4
    db $A0, $08 ; volume $08
    db $26, $04 ; note F#2 dur 4
    db $24, $04 ; note E2 dur 4
    db $20, $04 ; note C2 dur 4
    db $A0, $09 ; volume $09
    db $17, $04 ; note G1 dur 4
    db $1B, $04 ; note B1 dur 4
    db $22, $04 ; note D2 dur 4
    db $A0, $08 ; volume $08
    db $26, $04 ; note F#2 dur 4
    db $2B, $04 ; note B2 dur 4
    db $32, $04 ; note D3 dur 4
    db $A0, $05 ; volume $05
    db $36, $04 ; note F#3 dur 4
    db $32, $04 ; note D3 dur 4
    db $2B, $04 ; note B2 dur 4
    db $A0, $08 ; volume $08
    db $26, $04 ; note F#2 dur 4
    db $22, $04 ; note D2 dur 4
    db $1B, $04 ; note B1 dur 4
    db $A0, $09 ; volume $09
    db $17, $04 ; note G1 dur 4
    db $1B, $04 ; note B1 dur 4
    db $20, $04 ; note C2 dur 4
    db $A0, $08 ; volume $08
    db $24, $04 ; note E2 dur 4
    db $27, $04 ; note G2 dur 4
    db $2B, $04 ; note B2 dur 4
    db $A0, $05 ; volume $05
    db $34, $04 ; note E3 dur 4
    db $2B, $04 ; note B2 dur 4
    db $27, $04 ; note G2 dur 4
    db $A0, $08 ; volume $08
    db $24, $04 ; note E2 dur 4
    db $20, $04 ; note C2 dur 4
    db $1B, $04 ; note B1 dur 4
    db $A0, $09 ; volume $09
    db $16, $04 ; note F#1 dur 4
    db $20, $04 ; note C2 dur 4
    db $24, $04 ; note E2 dur 4
    db $A0, $08 ; volume $08
    db $26, $04 ; note F#2 dur 4
    db $29, $04 ; note A2 dur 4
    db $30, $04 ; note C3 dur 4
    db $A0, $05 ; volume $05
    db $34, $04 ; note E3 dur 4
    db $30, $04 ; note C3 dur 4
    db $29, $04 ; note A2 dur 4
    db $A0, $08 ; volume $08
    db $24, $04 ; note E2 dur 4
    db $20, $04 ; note C2 dur 4
    db $19, $04 ; note A1 dur 4
    db $A0, $09 ; volume $09
    db $15, $04 ; note F1 dur 4
    db $19, $04 ; note A1 dur 4
    db $20, $04 ; note C2 dur 4
    db $A0, $08 ; volume $08
    db $23, $04 ; note D#2 dur 4
    db $27, $04 ; note G2 dur 4
    db $29, $04 ; note A2 dur 4
    db $A0, $05 ; volume $05
    db $33, $04 ; note D#3 dur 4
    db $30, $04 ; note C3 dur 4
    db $29, $04 ; note A2 dur 4
    db $A0, $08 ; volume $08
    db $27, $04 ; note G2 dur 4
    db $23, $04 ; note D#2 dur 4
    db $20, $04 ; note C2 dur 4
    db $A0, $09 ; volume $09
    db $1B, $04 ; note B1 dur 4
    db $22, $04 ; note D2 dur 4
    db $26, $04 ; note F#2 dur 4
    db $A0, $08 ; volume $08
    db $29, $04 ; note A2 dur 4
    db $2B, $04 ; note B2 dur 4
    db $32, $04 ; note D3 dur 4
    db $A0, $05 ; volume $05
    db $36, $04 ; note F#3 dur 4
    db $32, $04 ; note D3 dur 4
    db $2B, $04 ; note B2 dur 4
    db $A0, $08 ; volume $08
    db $29, $04 ; note A2 dur 4
    db $26, $04 ; note F#2 dur 4
    db $22, $04 ; note D2 dur 4
    db $A0, $09 ; volume $09
    db $14, $04 ; note E1 dur 4
    db $18, $04 ; note G#1 dur 4
    db $1B, $04 ; note B1 dur 4
    db $A0, $08 ; volume $08
    db $24, $04 ; note E2 dur 4
    db $28, $04 ; note G#2 dur 4
    db $2B, $04 ; note B2 dur 4
    db $A0, $05 ; volume $05
    db $34, $04 ; note E3 dur 4
    db $2B, $04 ; note B2 dur 4
    db $28, $04 ; note G#2 dur 4
    db $A0, $08 ; volume $08
    db $24, $04 ; note E2 dur 4
    db $1B, $05 ; note B1 dur 5
    db $18, $05 ; note G#1 dur 5
    db $A2, $01 ; duty2 $01
    db $C3, $68 ; env $68
    db $A0, $0B ; volume $0B
    db $20, $06 ; note C2 dur 6
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $25, $06 ; note F2 dur 6
    db $20, $06 ; note C2 dur 6
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $25, $06 ; note F2 dur 6
    db $1B, $06 ; note B1 dur 6
    db $22, $06 ; note D2 dur 6
    db $25, $06 ; note F2 dur 6
    db $22, $06 ; note D2 dur 6
    db $A0, $0C ; volume $0C
    db $1B, $06 ; note B1 dur 6
    db $22, $06 ; note D2 dur 6
    db $A0, $0A ; volume $0A
    db $25, $06 ; note F2 dur 6
    db $22, $06 ; note D2 dur 6
    db $A0, $0C ; volume $0C
    db $1B, $06 ; note B1 dur 6
    db $24, $06 ; note E2 dur 6
    db $27, $06 ; note G2 dur 6
    db $24, $06 ; note E2 dur 6
    db $A0, $0D ; volume $0D
    db $1B, $06 ; note B1 dur 6
    db $24, $06 ; note E2 dur 6
    db $27, $06 ; note G2 dur 6
    db $24, $06 ; note E2 dur 6
    db $20, $06 ; note C2 dur 6
    db $24, $06 ; note E2 dur 6
    db $29, $06 ; note A2 dur 6
    db $24, $06 ; note E2 dur 6
    db $A0, $0C ; volume $0C
    db $20, $06 ; note C2 dur 6
    db $24, $06 ; note E2 dur 6
    db $A0, $0A ; volume $0A
    db $29, $06 ; note A2 dur 6
    db $24, $06 ; note E2 dur 6
    db $A0, $0B ; volume $0B
    db $22, $06 ; note D2 dur 6
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $25, $06 ; note F2 dur 6
    db $A0, $0C ; volume $0C
    db $22, $06 ; note D2 dur 6
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $25, $06 ; note F2 dur 6
    db $22, $06 ; note D2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $A0, $0B ; volume $0B
    db $22, $06 ; note D2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $A0, $0A ; volume $0A
    db $2B, $06 ; note B2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $A0, $0B ; volume $0B
    db $20, $06 ; note C2 dur 6
    db $24, $06 ; note E2 dur 6
    db $29, $06 ; note A2 dur 6
    db $24, $06 ; note E2 dur 6
    db $A0, $0C ; volume $0C
    db $20, $06 ; note C2 dur 6
    db $24, $06 ; note E2 dur 6
    db $29, $06 ; note A2 dur 6
    db $24, $06 ; note E2 dur 6
    db $20, $06 ; note C2 dur 6
    db $24, $06 ; note E2 dur 6
    db $29, $06 ; note A2 dur 6
    db $24, $06 ; note E2 dur 6
    db $A0, $0B ; volume $0B
    db $20, $06 ; note C2 dur 6
    db $24, $06 ; note E2 dur 6
    db $A0, $0A ; volume $0A
    db $29, $06 ; note A2 dur 6
    db $24, $06 ; note E2 dur 6
    db $A0, $0B ; volume $0B
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $29, $06 ; note A2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $A0, $0C ; volume $0C
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $29, $06 ; note A2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $24, $06 ; note E2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $A0, $0B ; volume $0B
    db $22, $06 ; note D2 dur 6
    db $24, $06 ; note E2 dur 6
    db $A0, $0A ; volume $0A
    db $28, $06 ; note G#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $A3, $0C ; mod $0C
    db $A0, $0B ; volume $0B
    db $21, $06 ; note C#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $27, $06 ; note G2 dur 6
    db $24, $06 ; note E2 dur 6
    db $A0, $0C ; volume $0C
    db $21, $06 ; note C#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $27, $06 ; note G2 dur 6
    db $24, $06 ; note E2 dur 6
    db $21, $06 ; note C#2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $29, $06 ; note A2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $A0, $0B ; volume $0B
    db $21, $06 ; note C#2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $A0, $0A ; volume $0A
    db $29, $06 ; note A2 dur 6
    db $A0, $0B ; volume $0B
    db $26, $06 ; note F#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $A0, $0C ; volume $0C
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $A0, $07 ; volume $07
    db $2B, $06 ; note B2 dur 6
    db $A0, $0C ; volume $0C
    db $26, $06 ; note F#2 dur 6
    db $A0, $0B ; volume $0B
    db $1B, $06 ; note B1 dur 6
    db $25, $06 ; note F2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $A0, $09 ; volume $09
    db $1B, $06 ; note B1 dur 6
    db $25, $06 ; note F2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $A0, $0C ; volume $0C
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $A0, $0D ; volume $0D
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $23, $06 ; note D#2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $29, $06 ; note A2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $A0, $0C ; volume $0C
    db $23, $06 ; note D#2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $A0, $0A ; volume $0A
    db $29, $06 ; note A2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $A0, $0C ; volume $0C
    db $24, $06 ; note E2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $29, $06 ; note A2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $A0, $0D ; volume $0D
    db $24, $06 ; note E2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $29, $06 ; note A2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $29, $06 ; note A2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $A0, $0C ; volume $0C
    db $34, $06 ; note E3 dur 6
    db $2B, $06 ; note B2 dur 6
    db $A0, $0A ; volume $0A
    db $29, $06 ; note A2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $A0, $0C ; volume $0C
    db $23, $06 ; note D#2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $29, $06 ; note A2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $A0, $0D ; volume $0D
    db $33, $06 ; note D#3 dur 6
    db $2B, $06 ; note B2 dur 6
    db $29, $06 ; note A2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $C0, $FE ; env $FE
    db $A0, $08 ; volume $08
    db $23, $10 ; note D#2 dur 16
    db $C1, $5F ; env $5F
    db $A3, $00 ; mod $00
    db $A0, $05 ; volume $05
    db $23, $20 ; note D#2 dur 32
    db $B0, $F3 ; jump $F3
    db $FF, $FF ; end

; sound track, 279 events after the header (E-0019: grammar C2, meaning C0)
Data_041_7C65:: ; heuristic: track stream of a sound record; C0
    db $07, $00, $09, $00 ; header: param=7 byte1=$00 volume=$09 byte3=$00
    db $A2, $00 ; duty2 $00
    db $A3, $28 ; mod $28
    db $C2, $3F ; env $3F
    db $A0, $0C ; volume $0C
    db $AA, $2A ; slide $2A
    db $A0, $09 ; volume $09
    db $14, $04 ; note E1 dur 4
    db $17, $04 ; note G1 dur 4
    db $1B, $04 ; note B1 dur 4
    db $24, $04 ; note E2 dur 4
    db $27, $04 ; note G2 dur 4
    db $2B, $04 ; note B2 dur 4
    db $34, $04 ; note E3 dur 4
    db $2B, $04 ; note B2 dur 4
    db $27, $04 ; note G2 dur 4
    db $24, $04 ; note E2 dur 4
    db $1B, $04 ; note B1 dur 4
    db $17, $04 ; note G1 dur 4
    db $14, $04 ; note E1 dur 4
    db $17, $04 ; note G1 dur 4
    db $1B, $04 ; note B1 dur 4
    db $24, $04 ; note E2 dur 4
    db $27, $04 ; note G2 dur 4
    db $2B, $04 ; note B2 dur 4
    db $34, $04 ; note E3 dur 4
    db $2B, $04 ; note B2 dur 4
    db $27, $04 ; note G2 dur 4
    db $FD, $F3 ; label 3
    db $AA, $00 ; slide $00
    db $A2, $02 ; duty2 $02
    db $C3, $25 ; env $25
    db $A3, $28 ; mod $28
    db $A0, $0E ; volume $0E
    db $2B, $0D ; note B2 dur 13
    db $C0, $FE ; env $FE
    db $A0, $0A ; volume $0A
    db $A3, $FE ; mod $FE
    db $34, $23 ; note E3 dur 35
    db $A3, $08 ; mod $08
    db $3B, $0B ; note B3 dur 11
    db $A0, $09 ; volume $09
    db $3B, $01 ; note B3 dur 1
    db $A3, $FE ; mod $FE
    db $A0, $0D ; volume $0D
    db $3B, $24 ; note B3 dur 36
    db $A0, $09 ; volume $09
    db $39, $06 ; note A3 dur 6
    db $3B, $06 ; note B3 dur 6
    db $A3, $0F ; mod $0F
    db $A0, $08 ; volume $08
    db $36, $24 ; note F#3 dur 36
    db $A0, $09 ; volume $09
    db $34, $06 ; note E3 dur 6
    db $A0, $0A ; volume $0A
    db $32, $06 ; note D3 dur 6
    db $A0, $08 ; volume $08
    db $34, $18 ; note E3 dur 24
    db $C1, $68 ; env $68
    db $A3, $00 ; mod $00
    db $A0, $05 ; volume $05
    db $34, $0C ; note E3 dur 12
    db $C3, $25 ; env $25
    db $A3, $08 ; mod $08
    db $A0, $0D ; volume $0D
    db $2B, $0D ; note B2 dur 13
    db $C0, $FE ; env $FE
    db $A0, $0C ; volume $0C
    db $A3, $FE ; mod $FE
    db $30, $23 ; note C3 dur 35
    db $39, $0B ; note A3 dur 11
    db $A0, $09 ; volume $09
    db $39, $01 ; note A3 dur 1
    db $A0, $0E ; volume $0E
    db $39, $24 ; note A3 dur 36
    db $A0, $08 ; volume $08
    db $34, $06 ; note E3 dur 6
    db $A0, $09 ; volume $09
    db $36, $06 ; note F#3 dur 6
    db $A0, $09 ; volume $09
    db $32, $23 ; note D3 dur 35
    db $2B, $07 ; note B2 dur 7
    db $32, $06 ; note D3 dur 6
    db $A0, $07 ; volume $07
    db $34, $30 ; note E3 dur 48
    db $C1, $4F ; env $4F
    db $A3, $00 ; mod $00
    db $A0, $05 ; volume $05
    db $34, $0C ; note E3 dur 12
    db $A3, $0C ; mod $0C
    db $C0, $FE ; env $FE
    db $A0, $0A ; volume $0A
    db $30, $0C ; note C3 dur 12
    db $A0, $0B ; volume $0B
    db $32, $0C ; note D3 dur 12
    db $34, $0C ; note E3 dur 12
    db $A3, $FE ; mod $FE
    db $39, $2A ; note A3 dur 42
    db $C1, $7F ; env $7F
    db $A3, $04 ; mod $04
    db $A0, $08 ; volume $08
    db $39, $07 ; note A3 dur 7
    db $A3, $08 ; mod $08
    db $C0, $FE ; env $FE
    db $A0, $0B ; volume $0B
    db $36, $0E ; note F#3 dur 14
    db $A0, $06 ; volume $06
    db $36, $02 ; note F#3 dur 2
    db $A0, $0B ; volume $0B
    db $37, $0E ; note G3 dur 14
    db $A0, $06 ; volume $06
    db $37, $02 ; note G3 dur 2
    db $A0, $0B ; volume $0B
    db $36, $0E ; note F#3 dur 14
    db $A0, $06 ; volume $06
    db $36, $01 ; note F#3 dur 1
    db $A3, $FE ; mod $FE
    db $A0, $09 ; volume $09
    db $34, $24 ; note E3 dur 36
    db $A0, $07 ; volume $07
    db $2B, $0C ; note B2 dur 12
    db $C1, $40 ; env $40
    db $A3, $00 ; mod $00
    db $A0, $05 ; volume $05
    db $2B, $0C ; note B2 dur 12
    db $A3, $08 ; mod $08
    db $C3, $65 ; env $65
    db $A0, $0C ; volume $0C
    db $29, $0C ; note A2 dur 12
    db $C0, $FE ; env $FE
    db $A0, $0B ; volume $0B
    db $2B, $0C ; note B2 dur 12
    db $30, $0C ; note C3 dur 12
    db $A0, $09 ; volume $09
    db $A3, $FE ; mod $FE
    db $33, $2C ; note D#3 dur 44
    db $C1, $7F ; env $7F
    db $A3, $00 ; mod $00
    db $A0, $08 ; volume $08
    db $33, $04 ; note D#3 dur 4
    db $C0, $FE ; env $FE
    db $A3, $08 ; mod $08
    db $A0, $0B ; volume $0B
    db $32, $0E ; note D3 dur 14
    db $A0, $04 ; volume $04
    db $32, $02 ; note D3 dur 2
    db $A0, $0B ; volume $0B
    db $2B, $0E ; note B2 dur 14
    db $A0, $04 ; volume $04
    db $2B, $02 ; note B2 dur 2
    db $A0, $0B ; volume $0B
    db $32, $0E ; note D3 dur 14
    db $A0, $04 ; volume $04
    db $32, $02 ; note D3 dur 2
    db $C0, $FE ; env $FE
    db $A0, $09 ; volume $09
    db $34, $2C ; note E3 dur 44
    db $C1, $6F ; env $6F
    db $A3, $00 ; mod $00
    db $A0, $04 ; volume $04
    db $34, $1E ; note E3 dur 30
    db $A2, $01 ; duty2 $01
    db $C3, $78 ; env $78
    db $A3, $09 ; mod $09
    db $A0, $0F ; volume $0F
    db $35, $0C ; note F3 dur 12
    db $37, $0C ; note G3 dur 12
    db $A3, $FE ; mod $FE
    db $39, $18 ; note A3 dur 24
    db $A3, $07 ; mod $07
    db $37, $0C ; note G3 dur 12
    db $35, $0C ; note F3 dur 12
    db $C3, $68 ; env $68
    db $34, $07 ; note E3 dur 7
    db $35, $05 ; note F3 dur 5
    db $34, $06 ; note E3 dur 6
    db $35, $06 ; note F3 dur 6
    db $A0, $09 ; volume $09
    db $C0, $FE ; env $FE
    db $A3, $FE ; mod $FE
    db $37, $20 ; note G3 dur 32
    db $C1, $7F ; env $7F
    db $A0, $05 ; volume $05
    db $A3, $08 ; mod $08
    db $37, $10 ; note G3 dur 16
    db $A0, $0C ; volume $0C
    db $A3, $09 ; mod $09
    db $C3, $7F ; env $7F
    db $34, $0C ; note E3 dur 12
    db $C3, $68 ; env $68
    db $A0, $0B ; volume $0B
    db $30, $0C ; note C3 dur 12
    db $C1, $70 ; env $70
    db $A3, $08 ; mod $08
    db $A0, $05 ; volume $05
    db $30, $18 ; note C3 dur 24
    db $C3, $68 ; env $68
    db $A3, $09 ; mod $09
    db $A0, $0F ; volume $0F
    db $32, $0C ; note D3 dur 12
    db $34, $0C ; note E3 dur 12
    db $A3, $FE ; mod $FE
    db $C3, $78 ; env $78
    db $35, $18 ; note F3 dur 24
    db $A3, $07 ; mod $07
    db $C3, $68 ; env $68
    db $34, $0C ; note E3 dur 12
    db $32, $0C ; note D3 dur 12
    db $30, $06 ; note C3 dur 6
    db $2B, $06 ; note B2 dur 6
    db $30, $06 ; note C3 dur 6
    db $32, $06 ; note D3 dur 6
    db $A0, $0B ; volume $0B
    db $A3, $FE ; mod $FE
    db $C3, $7F ; env $7F
    db $34, $18 ; note E3 dur 24
    db $C1, $78 ; env $78
    db $A0, $06 ; volume $06
    db $A3, $08 ; mod $08
    db $34, $18 ; note E3 dur 24
    db $C3, $78 ; env $78
    db $A3, $08 ; mod $08
    db $A0, $0F ; volume $0F
    db $36, $0C ; note F#3 dur 12
    db $38, $0C ; note G#3 dur 12
    db $A3, $FE ; mod $FE
    db $A0, $0A ; volume $0A
    db $C0, $FE ; env $FE
    db $39, $24 ; note A3 dur 36
    db $38, $06 ; note G#3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $38, $24 ; note G#3 dur 36
    db $36, $06 ; note F#3 dur 6
    db $34, $06 ; note E3 dur 6
    db $36, $0C ; note F#3 dur 12
    db $34, $0C ; note E3 dur 12
    db $32, $0C ; note D3 dur 12
    db $31, $0B ; note C#3 dur 11
    db $A0, $06 ; volume $06
    db $31, $01 ; note C#3 dur 1
    db $A0, $0A ; volume $0A
    db $31, $0C ; note C#3 dur 12
    db $A0, $0B ; volume $0B
    db $26, $0C ; note F#2 dur 12
    db $A0, $0C ; volume $0C
    db $28, $0C ; note G#2 dur 12
    db $A0, $0B ; volume $0B
    db $29, $0C ; note A2 dur 12
    db $C0, $FE ; env $FE
    db $A0, $0B ; volume $0B
    db $2B, $24 ; note B2 dur 36
    db $A0, $0C ; volume $0C
    db $2A, $06 ; note A#2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $A0, $0B ; volume $0B
    db $31, $24 ; note C#3 dur 36
    db $A0, $0C ; volume $0C
    db $30, $06 ; note C3 dur 6
    db $31, $06 ; note C#3 dur 6
    db $32, $0C ; note D3 dur 12
    db $31, $0C ; note C#3 dur 12
    db $32, $0C ; note D3 dur 12
    db $34, $0C ; note E3 dur 12
    db $36, $0C ; note F#3 dur 12
    db $38, $0C ; note G#3 dur 12
    db $39, $0C ; note A3 dur 12
    db $36, $0C ; note F#3 dur 12
    db $A0, $0A ; volume $0A
    db $A3, $FE ; mod $FE
    db $C0, $FE ; env $FE
    db $3B, $44 ; note B3 dur 68
    db $A0, $08 ; volume $08
    db $C0, $FE ; env $FE
    db $3B, $44 ; note B3 dur 68
    db $C1, $7F ; env $7F
    db $A3, $00 ; mod $00
    db $A0, $05 ; volume $05
    db $3B, $2C ; note B3 dur 44
    db $B0, $F3 ; jump $F3
    db $FF, $FF ; end

Data_041_7E97:: ; heuristic: track stream of a sound record; C0
    INCBIN "dwm2-cobi-us.gbc", $107E97, $169
