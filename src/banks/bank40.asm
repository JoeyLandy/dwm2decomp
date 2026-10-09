SECTION "Bank 40", ROMX[$4000], BANK[$40]
    db $40

; E-0018 (C2 for the fields, C0 for the meaning of the second byte and of the streams). Sound ids 0-27.
; record: channel-state slot offset (added to $DC00); copied to slot byte +2 (meaning unverified); track stream (stored at slot +3/+4, with this bank at +5)
SoundRecords_Bank40::
Data_040_4001:: ; heuristic: sound record array named by the bank table; C0
    db $00, $00 ; id 0
    dw Data_040_4071
    db $20, $01 ; id 1
    dw Data_040_4071
    db $40, $00 ; id 2
    dw Data_040_4071
    db $60, $01 ; id 3
    dw Data_040_4071
    db $80, $02 ; id 4
    dw Data_040_4071
    db $A0, $03 ; id 5
    dw Data_040_4071
    db $40, $00 ; id 6
    dw Data_040_4077
    db $60, $01 ; id 7
    dw Data_040_42F3
    db $80, $02 ; id 8
    dw Data_040_4589
    db $40, $00 ; id 9
    dw Data_040_481D
    db $60, $01 ; id 10
    dw Data_040_49F5
    db $80, $02 ; id 11
    dw Data_040_4BCF
    db $40, $00 ; id 12
    dw Data_040_4E13
    db $60, $01 ; id 13
    dw Data_040_5039
    db $80, $02 ; id 14
    dw Data_040_5243
    db $40, $00 ; id 15
    dw Data_040_544F
    db $60, $01 ; id 16
    dw Data_040_56D1
    db $80, $02 ; id 17
    dw Data_040_59CB
    db $A0, $03 ; id 18
    dw Data_040_5C7D
    db $40, $00 ; id 19
    dw Data_040_5CE5
    db $60, $01 ; id 20
    dw Data_040_6113
    db $80, $02 ; id 21
    dw Data_040_64B1
    db $40, $00 ; id 22
    dw Data_040_67EF
    db $60, $01 ; id 23
    dw Data_040_6C5F
    db $80, $02 ; id 24
    dw Data_040_70BF
    db $40, $00 ; id 25
    dw Data_040_7543
    db $60, $01 ; id 26
    dw Data_040_7907
    db $80, $02 ; id 27
    dw Data_040_7B9B

; sound track, 1 events after the header (E-0019: grammar C2, meaning C0)
Data_040_4071:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $00, $00 ; header: param=0 byte1=$00 volume=$00 byte3=$00
    db $FF, $FF ; end

; sound track, 316 events after the header (E-0019: grammar C2, meaning C0)
Data_040_4077:: ; heuristic: track stream of a sound record; C0
    db $06, $00, $0D, $00 ; header: param=6 byte1=$00 volume=$0D byte3=$00
    db $AF, $04 ; param $04
    db $A0, $0C ; volume $0C
    db $A2, $00 ; duty2 $00
    db $A3, $1B ; mod $1B
    db $A3, $FE ; mod $FE
    db $C1, $35 ; env $35
    db $2A, $12 ; note A#2 dur 18
    db $2A, $06 ; note A#2 dur 6
    db $C1, $5F ; env $5F
    db $29, $18 ; note A2 dur 24
    db $30, $18 ; note C3 dur 24
    db $35, $18 ; note F3 dur 24
    db $35, $18 ; note F3 dur 24
    db $C0, $FF ; env $FF
    db $35, $18 ; note F3 dur 24
    db $C1, $60 ; env $60
    db $35, $18 ; note F3 dur 24
    db $C0, $FE ; env $FE
    db $35, $18 ; note F3 dur 24
    db $C1, $60 ; env $60
    db $35, $18 ; note F3 dur 24
    db $C0, $FE ; env $FE
    db $2A, $1E ; note A#2 dur 30
    db $A0, $07 ; volume $07
    db $C1, $7F ; env $7F
    db $2A, $06 ; note A#2 dur 6
    db $A0, $0C ; volume $0C
    db $C1, $20 ; env $20
    db $29, $0C ; note A2 dur 12
    db $A0, $05 ; volume $05
    db $29, $0C ; note A2 dur 12
    db $A0, $0C ; volume $0C
    db $C1, $30 ; env $30
    db $28, $0C ; note G#2 dur 12
    db $28, $0C ; note G#2 dur 12
    db $2B, $0C ; note B2 dur 12
    db $C1, $4A ; env $4A
    db $29, $18 ; note A2 dur 24
    db $C0, $FE ; env $FE
    db $25, $24 ; note F2 dur 36
    db $A0, $05 ; volume $05
    db $C1, $50 ; env $50
    db $25, $0C ; note F2 dur 12
    db $A0, $0C ; volume $0C
    db $C1, $40 ; env $40
    db $20, $12 ; note C2 dur 18
    db $20, $06 ; note C2 dur 6
    db $C1, $5F ; env $5F
    db $21, $18 ; note C#2 dur 24
    db $C1, $60 ; env $60
    db $21, $18 ; note C#2 dur 24
    db $22, $18 ; note D2 dur 24
    db $24, $18 ; note E2 dur 24
    db $C0, $FE ; env $FE
    db $25, $30 ; note F2 dur 48
    db $A0, $08 ; volume $08
    db $C1, $7F ; env $7F
    db $25, $0C ; note F2 dur 12
    db $A0, $0C ; volume $0C
    db $C1, $30 ; env $30
    db $25, $0C ; note F2 dur 12
    db $27, $0C ; note G2 dur 12
    db $29, $0C ; note A2 dur 12
    db $C0, $FE ; env $FE
    db $32, $30 ; note D3 dur 48
    db $A0, $08 ; volume $08
    db $C1, $7F ; env $7F
    db $32, $0C ; note D3 dur 12
    db $A0, $0C ; volume $0C
    db $C1, $30 ; env $30
    db $2B, $0C ; note B2 dur 12
    db $2B, $0C ; note B2 dur 12
    db $32, $0C ; note D3 dur 12
    db $C1, $4A ; env $4A
    db $32, $18 ; note D3 dur 24
    db $30, $18 ; note C3 dur 24
    db $2A, $18 ; note A#2 dur 24
    db $2A, $18 ; note A#2 dur 24
    db $A2, $00 ; duty2 $00
    db $A3, $06 ; mod $06
    db $C3, $30 ; env $30
    db $31, $18 ; note C#3 dur 24
    db $A3, $00 ; mod $00
    db $C1, $70 ; env $70
    db $31, $24 ; note C#3 dur 36
    db $A3, $06 ; mod $06
    db $C3, $20 ; env $20
    db $31, $0C ; note C#3 dur 12
    db $31, $0C ; note C#3 dur 12
    db $31, $0C ; note C#3 dur 12
    db $C4, $68 ; env $68
    db $32, $30 ; note D3 dur 48
    db $29, $18 ; note A2 dur 24
    db $29, $18 ; note A2 dur 24
    db $C3, $30 ; env $30
    db $32, $18 ; note D3 dur 24
    db $A3, $00 ; mod $00
    db $C1, $70 ; env $70
    db $32, $24 ; note D3 dur 36
    db $A3, $06 ; mod $06
    db $C3, $20 ; env $20
    db $2B, $0C ; note B2 dur 12
    db $2B, $0C ; note B2 dur 12
    db $2B, $0C ; note B2 dur 12
    db $C0, $FE ; env $FE
    db $2A, $30 ; note A#2 dur 48
    db $A0, $06 ; volume $06
    db $C1, $7F ; env $7F
    db $A3, $00 ; mod $00
    db $2A, $18 ; note A#2 dur 24
    db $A0, $0C ; volume $0C
    db $C4, $30 ; env $30
    db $A3, $06 ; mod $06
    db $2A, $18 ; note A#2 dur 24
    db $C3, $30 ; env $30
    db $36, $18 ; note F#3 dur 24
    db $A3, $00 ; mod $00
    db $C1, $70 ; env $70
    db $36, $24 ; note F#3 dur 36
    db $A3, $06 ; mod $06
    db $C3, $20 ; env $20
    db $36, $0C ; note F#3 dur 12
    db $37, $0C ; note G3 dur 12
    db $39, $0C ; note A3 dur 12
    db $C3, $30 ; env $30
    db $3A, $18 ; note A#3 dur 24
    db $A3, $00 ; mod $00
    db $C1, $70 ; env $70
    db $3A, $24 ; note A#3 dur 36
    db $A3, $06 ; mod $06
    db $C3, $20 ; env $20
    db $2A, $0C ; note A#2 dur 12
    db $30, $0C ; note C3 dur 12
    db $32, $0C ; note D3 dur 12
    db $C4, $68 ; env $68
    db $32, $30 ; note D3 dur 48
    db $34, $30 ; note E3 dur 48
    db $29, $48 ; note A2 dur 72
    db $A0, $0C ; volume $0C
    db $A3, $FE ; mod $FE
    db $C1, $35 ; env $35
    db $2A, $12 ; note A#2 dur 18
    db $2A, $06 ; note A#2 dur 6
    db $C1, $5F ; env $5F
    db $A0, $0B ; volume $0B
    db $29, $18 ; note A2 dur 24
    db $A0, $0C ; volume $0C
    db $30, $18 ; note C3 dur 24
    db $30, $18 ; note C3 dur 24
    db $35, $18 ; note F3 dur 24
    db $35, $18 ; note F3 dur 24
    db $39, $18 ; note A3 dur 24
    db $32, $18 ; note D3 dur 24
    db $35, $18 ; note F3 dur 24
    db $2A, $18 ; note A#2 dur 24
    db $29, $18 ; note A2 dur 24
    db $C0, $FF ; env $FF
    db $28, $18 ; note G#2 dur 24
    db $C1, $60 ; env $60
    db $28, $18 ; note G#2 dur 24
    db $C1, $4A ; env $4A
    db $29, $18 ; note A2 dur 24
    db $C0, $FF ; env $FF
    db $25, $18 ; note F2 dur 24
    db $C1, $60 ; env $60
    db $25, $18 ; note F2 dur 24
    db $C1, $5F ; env $5F
    db $20, $12 ; note C2 dur 18
    db $20, $06 ; note C2 dur 6
    db $C1, $60 ; env $60
    db $21, $18 ; note C#2 dur 24
    db $21, $18 ; note C#2 dur 24
    db $22, $18 ; note D2 dur 24
    db $24, $18 ; note E2 dur 24
    db $C0, $FE ; env $FE
    db $25, $30 ; note F2 dur 48
    db $A0, $0A ; volume $0A
    db $C1, $7F ; env $7F
    db $25, $0C ; note F2 dur 12
    db $A0, $0D ; volume $0D
    db $C1, $30 ; env $30
    db $25, $0C ; note F2 dur 12
    db $27, $0C ; note G2 dur 12
    db $29, $0C ; note A2 dur 12
    db $C0, $FE ; env $FE
    db $2B, $30 ; note B2 dur 48
    db $A0, $0A ; volume $0A
    db $C1, $7F ; env $7F
    db $2B, $0C ; note B2 dur 12
    db $A0, $0D ; volume $0D
    db $C1, $30 ; env $30
    db $2B, $0C ; note B2 dur 12
    db $2B, $0C ; note B2 dur 12
    db $32, $0C ; note D3 dur 12
    db $C1, $5F ; env $5F
    db $32, $18 ; note D3 dur 24
    db $30, $18 ; note C3 dur 24
    db $2A, $18 ; note A#2 dur 24
    db $2A, $18 ; note A#2 dur 24
    db $A2, $00 ; duty2 $00
    db $A3, $06 ; mod $06
    db $C3, $30 ; env $30
    db $31, $18 ; note C#3 dur 24
    db $A3, $00 ; mod $00
    db $C1, $70 ; env $70
    db $31, $24 ; note C#3 dur 36
    db $A3, $06 ; mod $06
    db $C3, $20 ; env $20
    db $31, $0C ; note C#3 dur 12
    db $31, $0C ; note C#3 dur 12
    db $31, $0C ; note C#3 dur 12
    db $C4, $68 ; env $68
    db $32, $30 ; note D3 dur 48
    db $29, $18 ; note A2 dur 24
    db $32, $18 ; note D3 dur 24
    db $C4, $40 ; env $40
    db $27, $18 ; note G2 dur 24
    db $2B, $18 ; note B2 dur 24
    db $32, $18 ; note D3 dur 24
    db $2B, $18 ; note B2 dur 24
    db $C0, $FE ; env $FE
    db $2A, $30 ; note A#2 dur 48
    db $A0, $06 ; volume $06
    db $C1, $7F ; env $7F
    db $A3, $00 ; mod $00
    db $2A, $18 ; note A#2 dur 24
    db $A0, $0C ; volume $0C
    db $A3, $06 ; mod $06
    db $C4, $68 ; env $68
    db $2A, $18 ; note A#2 dur 24
    db $36, $18 ; note F#3 dur 24
    db $32, $18 ; note D3 dur 24
    db $C3, $20 ; env $20
    db $29, $0C ; note A2 dur 12
    db $36, $0C ; note F#3 dur 12
    db $37, $0C ; note G3 dur 12
    db $39, $0C ; note A3 dur 12
    db $C3, $30 ; env $30
    db $3A, $18 ; note A#3 dur 24
    db $A3, $00 ; mod $00
    db $C1, $70 ; env $70
    db $3A, $24 ; note A#3 dur 36
    db $A3, $06 ; mod $06
    db $C3, $20 ; env $20
    db $2A, $0C ; note A#2 dur 12
    db $30, $0C ; note C3 dur 12
    db $32, $0C ; note D3 dur 12
    db $C4, $68 ; env $68
    db $32, $30 ; note D3 dur 48
    db $34, $30 ; note E3 dur 48
    db $29, $4F ; note A2 dur 79
    db $1F, $02 ; rest-note $1F dur 2
    db $AF, $07 ; param $07
    db $A0, $0A ; volume $0A
    db $1F, $19 ; rest-note $1F dur 25
    db $36, $0C ; note F#3 dur 12
    db $29, $0C ; note A2 dur 12
    db $2A, $0C ; note A#2 dur 12
    db $30, $0C ; note C3 dur 12
    db $32, $30 ; note D3 dur 48
    db $C3, $30 ; env $30
    db $2A, $31 ; note A#2 dur 49
    db $A3, $00 ; mod $00
    db $C1, $20 ; env $20
    db $2A, $19 ; note A#2 dur 25
    db $A0, $0F ; volume $0F
    db $A3, $06 ; mod $06
    db $C4, $2F ; env $2F
    db $25, $1A ; note F2 dur 26
    db $C4, $30 ; env $30
    db $27, $1A ; note G2 dur 26
    db $C4, $34 ; env $34
    db $30, $1B ; note C3 dur 27
    db $C1, $30 ; env $30
    db $32, $0C ; note D3 dur 12
    db $A2, $02 ; duty2 $02
    db $A0, $0A ; volume $0A
    db $1A, $0C ; note A#1 dur 12
    db $1A, $0C ; note A#1 dur 12
    db $22, $0C ; note D2 dur 12
    db $22, $0C ; note D2 dur 12
    db $25, $0C ; note F2 dur 12
    db $25, $0C ; note F2 dur 12
    db $2A, $0C ; note A#2 dur 12
    db $1A, $0C ; note A#1 dur 12
    db $20, $0C ; note C2 dur 12
    db $20, $0C ; note C2 dur 12
    db $24, $0C ; note E2 dur 12
    db $24, $0D ; note E2 dur 13
    db $27, $0D ; note G2 dur 13
    db $27, $0D ; note G2 dur 13
    db $2A, $0D ; note A#2 dur 13
    db $29, $0E ; note A2 dur 14
    db $19, $0D ; note A1 dur 13
    db $19, $0D ; note A1 dur 13
    db $20, $0D ; note C2 dur 13
    db $20, $0E ; note C2 dur 14
    db $25, $0E ; note F2 dur 14
    db $25, $0E ; note F2 dur 14
    db $29, $0F ; note A2 dur 15
    db $C1, $7F ; env $7F
    db $19, $21 ; note A1 dur 33
    db $A7, $03 ; wait $03
    db $C1, $30 ; env $30
    db $19, $03 ; note A1 dur 3
    db $1A, $03 ; note A#1 dur 3
    db $20, $03 ; note C2 dur 3
    db $22, $03 ; note D2 dur 3
    db $24, $03 ; note E2 dur 3
    db $25, $03 ; note F2 dur 3
    db $27, $03 ; note G2 dur 3
    db $C1, $7F ; env $7F
    db $29, $19 ; note A2 dur 25
    db $1F, $18 ; rest-note $1F dur 24
    db $1F, $5A ; rest-note $1F dur 90
    db $FF, $FF ; end

; sound track, 329 events after the header (E-0019: grammar C2, meaning C0)
Data_040_42F3:: ; heuristic: track stream of a sound record; C0
    db $06, $00, $0F, $00 ; header: param=6 byte1=$00 volume=$0F byte3=$00
    db $AF, $04 ; param $04
    db $A0, $0D ; volume $0D
    db $A2, $00 ; duty2 $00
    db $A3, $1B ; mod $1B
    db $C1, $35 ; env $35
    db $30, $12 ; note C3 dur 18
    db $30, $06 ; note C3 dur 6
    db $C1, $5F ; env $5F
    db $A0, $0C ; volume $0C
    db $35, $18 ; note F3 dur 24
    db $37, $18 ; note G3 dur 24
    db $A0, $0D ; volume $0D
    db $39, $18 ; note A3 dur 24
    db $3A, $18 ; note A#3 dur 24
    db $C2, $7F ; env $7F
    db $40, $18 ; note C4 dur 24
    db $C0, $FE ; env $FE
    db $A3, $FE ; mod $FE
    db $45, $24 ; note F4 dur 36
    db $A0, $0A ; volume $0A
    db $C1, $7F ; env $7F
    db $45, $0C ; note F4 dur 12
    db $A0, $0D ; volume $0D
    db $C1, $35 ; env $35
    db $44, $12 ; note E4 dur 18
    db $C1, $2F ; env $2F
    db $42, $06 ; note D4 dur 6
    db $C0, $FE ; env $FE
    db $42, $1E ; note D4 dur 30
    db $A0, $0A ; volume $0A
    db $C1, $7F ; env $7F
    db $42, $06 ; note D4 dur 6
    db $A0, $0D ; volume $0D
    db $A3, $09 ; mod $09
    db $C1, $20 ; env $20
    db $40, $0C ; note C4 dur 12
    db $A0, $05 ; volume $05
    db $40, $0C ; note C4 dur 12
    db $A0, $0D ; volume $0D
    db $C1, $30 ; env $30
    db $3B, $0C ; note B3 dur 12
    db $3B, $0C ; note B3 dur 12
    db $42, $0C ; note D4 dur 12
    db $C1, $4A ; env $4A
    db $A3, $0C ; mod $0C
    db $40, $18 ; note C4 dur 24
    db $C0, $FE ; env $FE
    db $39, $24 ; note A3 dur 36
    db $A0, $05 ; volume $05
    db $C1, $50 ; env $50
    db $A3, $00 ; mod $00
    db $39, $0C ; note A3 dur 12
    db $A0, $0D ; volume $0D
    db $C1, $40 ; env $40
    db $A3, $09 ; mod $09
    db $29, $12 ; note A2 dur 18
    db $C1, $2F ; env $2F
    db $29, $06 ; note A2 dur 6
    db $C1, $5F ; env $5F
    db $29, $18 ; note A2 dur 24
    db $C1, $60 ; env $60
    db $29, $18 ; note A2 dur 24
    db $2B, $18 ; note B2 dur 24
    db $31, $18 ; note C#3 dur 24
    db $C0, $FE ; env $FE
    db $A3, $0C ; mod $0C
    db $32, $30 ; note D3 dur 48
    db $A0, $08 ; volume $08
    db $C1, $7F ; env $7F
    db $32, $0C ; note D3 dur 12
    db $A0, $0D ; volume $0D
    db $C1, $30 ; env $30
    db $32, $0C ; note D3 dur 12
    db $34, $0C ; note E3 dur 12
    db $35, $0C ; note F3 dur 12
    db $C0, $FE ; env $FE
    db $37, $30 ; note G3 dur 48
    db $A0, $08 ; volume $08
    db $C1, $7F ; env $7F
    db $37, $0C ; note G3 dur 12
    db $A0, $0D ; volume $0D
    db $C1, $30 ; env $30
    db $32, $0C ; note D3 dur 12
    db $32, $0C ; note D3 dur 12
    db $35, $0C ; note F3 dur 12
    db $A3, $08 ; mod $08
    db $C1, $4A ; env $4A
    db $35, $18 ; note F3 dur 24
    db $34, $18 ; note E3 dur 24
    db $32, $18 ; note D3 dur 24
    db $30, $18 ; note C3 dur 24
    db $A2, $00 ; duty2 $00
    db $A3, $06 ; mod $06
    db $C3, $30 ; env $30
    db $39, $18 ; note A3 dur 24
    db $A3, $00 ; mod $00
    db $C1, $70 ; env $70
    db $39, $24 ; note A3 dur 36
    db $A3, $06 ; mod $06
    db $C3, $20 ; env $20
    db $3A, $0C ; note A#3 dur 12
    db $39, $0C ; note A3 dur 12
    db $37, $0C ; note G3 dur 12
    db $C4, $68 ; env $68
    db $35, $30 ; note F3 dur 48
    db $32, $18 ; note D3 dur 24
    db $35, $18 ; note F3 dur 24
    db $C3, $30 ; env $30
    db $37, $18 ; note G3 dur 24
    db $A3, $00 ; mod $00
    db $C1, $70 ; env $70
    db $37, $24 ; note G3 dur 36
    db $A3, $06 ; mod $06
    db $C3, $20 ; env $20
    db $39, $0C ; note A3 dur 12
    db $37, $0C ; note G3 dur 12
    db $35, $0C ; note F3 dur 12
    db $C4, $68 ; env $68
    db $35, $30 ; note F3 dur 48
    db $A0, $09 ; volume $09
    db $C4, $7F ; env $7F
    db $34, $18 ; note E3 dur 24
    db $A0, $0D ; volume $0D
    db $C4, $48 ; env $48
    db $30, $18 ; note C3 dur 24
    db $C3, $30 ; env $30
    db $40, $18 ; note C4 dur 24
    db $A3, $00 ; mod $00
    db $C1, $70 ; env $70
    db $40, $24 ; note C4 dur 36
    db $A3, $06 ; mod $06
    db $C3, $20 ; env $20
    db $39, $0C ; note A3 dur 12
    db $3A, $0C ; note A#3 dur 12
    db $40, $0C ; note C4 dur 12
    db $C3, $30 ; env $30
    db $42, $18 ; note D4 dur 24
    db $A3, $00 ; mod $00
    db $C1, $70 ; env $70
    db $42, $24 ; note D4 dur 36
    db $A3, $06 ; mod $06
    db $C3, $20 ; env $20
    db $32, $0C ; note D3 dur 12
    db $34, $0C ; note E3 dur 12
    db $35, $0C ; note F3 dur 12
    db $C4, $68 ; env $68
    db $3A, $30 ; note A#3 dur 48
    db $39, $30 ; note A3 dur 48
    db $35, $48 ; note F3 dur 72
    db $A3, $FE ; mod $FE
    db $A0, $0D ; volume $0D
    db $C1, $35 ; env $35
    db $30, $12 ; note C3 dur 18
    db $30, $06 ; note C3 dur 6
    db $C1, $5F ; env $5F
    db $A0, $0C ; volume $0C
    db $35, $18 ; note F3 dur 24
    db $A0, $0D ; volume $0D
    db $37, $18 ; note G3 dur 24
    db $39, $18 ; note A3 dur 24
    db $3A, $18 ; note A#3 dur 24
    db $C2, $7F ; env $7F
    db $40, $18 ; note C4 dur 24
    db $C0, $FE ; env $FE
    db $45, $24 ; note F4 dur 36
    db $A0, $0A ; volume $0A
    db $C1, $7F ; env $7F
    db $45, $0C ; note F4 dur 12
    db $A0, $0D ; volume $0D
    db $C1, $40 ; env $40
    db $44, $12 ; note E4 dur 18
    db $C1, $2F ; env $2F
    db $42, $06 ; note D4 dur 6
    db $C0, $FE ; env $FE
    db $42, $1E ; note D4 dur 30
    db $A0, $0A ; volume $0A
    db $C1, $7F ; env $7F
    db $42, $06 ; note D4 dur 6
    db $A0, $0D ; volume $0D
    db $C1, $20 ; env $20
    db $40, $0C ; note C4 dur 12
    db $A0, $05 ; volume $05
    db $40, $0C ; note C4 dur 12
    db $A0, $0D ; volume $0D
    db $C1, $30 ; env $30
    db $3B, $0C ; note B3 dur 12
    db $3B, $0C ; note B3 dur 12
    db $42, $0C ; note D4 dur 12
    db $C1, $4A ; env $4A
    db $40, $18 ; note C4 dur 24
    db $C0, $FE ; env $FE
    db $39, $24 ; note A3 dur 36
    db $A0, $05 ; volume $05
    db $C1, $50 ; env $50
    db $39, $0C ; note A3 dur 12
    db $A0, $0D ; volume $0D
    db $C1, $40 ; env $40
    db $29, $12 ; note A2 dur 18
    db $C1, $2F ; env $2F
    db $29, $06 ; note A2 dur 6
    db $C1, $5F ; env $5F
    db $29, $18 ; note A2 dur 24
    db $C1, $60 ; env $60
    db $29, $18 ; note A2 dur 24
    db $2B, $18 ; note B2 dur 24
    db $31, $18 ; note C#3 dur 24
    db $C0, $FE ; env $FE
    db $32, $30 ; note D3 dur 48
    db $A0, $0A ; volume $0A
    db $C1, $7F ; env $7F
    db $32, $0C ; note D3 dur 12
    db $A0, $0D ; volume $0D
    db $C1, $30 ; env $30
    db $32, $0C ; note D3 dur 12
    db $34, $0C ; note E3 dur 12
    db $35, $0C ; note F3 dur 12
    db $C0, $FE ; env $FE
    db $37, $30 ; note G3 dur 48
    db $A0, $0A ; volume $0A
    db $C1, $7F ; env $7F
    db $37, $0C ; note G3 dur 12
    db $A0, $0D ; volume $0D
    db $C1, $30 ; env $30
    db $32, $0C ; note D3 dur 12
    db $32, $0C ; note D3 dur 12
    db $35, $0C ; note F3 dur 12
    db $C1, $4A ; env $4A
    db $35, $18 ; note F3 dur 24
    db $34, $18 ; note E3 dur 24
    db $32, $18 ; note D3 dur 24
    db $30, $18 ; note C3 dur 24
    db $A2, $00 ; duty2 $00
    db $A3, $06 ; mod $06
    db $C3, $30 ; env $30
    db $39, $18 ; note A3 dur 24
    db $A3, $00 ; mod $00
    db $C1, $70 ; env $70
    db $39, $24 ; note A3 dur 36
    db $A3, $06 ; mod $06
    db $C3, $20 ; env $20
    db $3A, $0C ; note A#3 dur 12
    db $39, $0C ; note A3 dur 12
    db $37, $0C ; note G3 dur 12
    db $C4, $68 ; env $68
    db $35, $30 ; note F3 dur 48
    db $32, $18 ; note D3 dur 24
    db $35, $18 ; note F3 dur 24
    db $C3, $30 ; env $30
    db $37, $18 ; note G3 dur 24
    db $A3, $00 ; mod $00
    db $C1, $70 ; env $70
    db $37, $24 ; note G3 dur 36
    db $A3, $06 ; mod $06
    db $C3, $20 ; env $20
    db $39, $0C ; note A3 dur 12
    db $37, $0C ; note G3 dur 12
    db $35, $0C ; note F3 dur 12
    db $C4, $68 ; env $68
    db $35, $30 ; note F3 dur 48
    db $A0, $0B ; volume $0B
    db $C4, $7F ; env $7F
    db $34, $18 ; note E3 dur 24
    db $A0, $0D ; volume $0D
    db $C4, $48 ; env $48
    db $30, $18 ; note C3 dur 24
    db $C3, $30 ; env $30
    db $40, $18 ; note C4 dur 24
    db $A3, $00 ; mod $00
    db $C1, $70 ; env $70
    db $40, $24 ; note C4 dur 36
    db $A3, $06 ; mod $06
    db $C3, $20 ; env $20
    db $39, $0C ; note A3 dur 12
    db $3A, $0C ; note A#3 dur 12
    db $40, $0C ; note C4 dur 12
    db $C3, $30 ; env $30
    db $42, $18 ; note D4 dur 24
    db $A3, $00 ; mod $00
    db $C1, $70 ; env $70
    db $42, $24 ; note D4 dur 36
    db $A3, $06 ; mod $06
    db $C3, $20 ; env $20
    db $32, $0C ; note D3 dur 12
    db $34, $0C ; note E3 dur 12
    db $35, $0C ; note F3 dur 12
    db $C4, $68 ; env $68
    db $3A, $30 ; note A#3 dur 48
    db $39, $30 ; note A3 dur 48
    db $35, $4F ; note F3 dur 79
    db $1F, $02 ; rest-note $1F dur 2
    db $AF, $07 ; param $07
    db $A0, $0A ; volume $0A
    db $C4, $78 ; env $78
    db $30, $19 ; note C3 dur 25
    db $40, $0C ; note C4 dur 12
    db $36, $0C ; note F#3 dur 12
    db $37, $0C ; note G3 dur 12
    db $39, $0C ; note A3 dur 12
    db $3A, $0C ; note A#3 dur 12
    db $39, $0C ; note A3 dur 12
    db $3A, $0C ; note A#3 dur 12
    db $40, $0C ; note C4 dur 12
    db $C3, $30 ; env $30
    db $42, $32 ; note D4 dur 50
    db $A3, $00 ; mod $00
    db $C1, $20 ; env $20
    db $42, $18 ; note D4 dur 24
    db $A0, $0D ; volume $0D
    db $A3, $04 ; mod $04
    db $C4, $3C ; env $3C
    db $32, $1A ; note D3 dur 26
    db $34, $1A ; note E3 dur 26
    db $35, $1B ; note F3 dur 27
    db $A3, $06 ; mod $06
    db $C3, $30 ; env $30
    db $3A, $30 ; note A#3 dur 48
    db $C1, $78 ; env $78
    db $A3, $00 ; mod $00
    db $3A, $30 ; note A#3 dur 48
    db $C4, $78 ; env $78
    db $A3, $06 ; mod $06
    db $39, $30 ; note A3 dur 48
    db $39, $34 ; note A3 dur 52
    db $C3, $30 ; env $30
    db $35, $A7 ; note F3 dur 167
    db $C1, $80 ; env $80
    db $35, $31 ; note F3 dur 49
    db $1F, $5A ; rest-note $1F dur 90
    db $FF, $FF ; end

; sound track, 328 events after the header (E-0019: grammar C2, meaning C0)
Data_040_4589:: ; heuristic: track stream of a sound record; C0
    db $06, $0F, $06, $03 ; header: param=6 byte1=$0F volume=$06 byte3=$03
    db $AF, $04 ; param $04
    db $A2, $48 ; duty2 $48
    db $A0, $02 ; volume $02
    db $A1, $0B ; duty $0B
    db $A3, $1F ; mod $1F
    db $1F, $18 ; rest-note $1F dur 24
    db $25, $18 ; note F2 dur 24
    db $24, $18 ; note E2 dur 24
    db $23, $18 ; note D#2 dur 24
    db $22, $18 ; note D2 dur 24
    db $A2, $FF ; duty2 $FF
    db $19, $24 ; note A1 dur 36
    db $A0, $04 ; volume $04
    db $19, $0C ; note A1 dur 12
    db $A0, $02 ; volume $02
    db $1A, $24 ; note A#1 dur 36
    db $A0, $04 ; volume $04
    db $1A, $0C ; note A#1 dur 12
    db $A0, $02 ; volume $02
    db $A2, $48 ; duty2 $48
    db $25, $18 ; note F2 dur 24
    db $20, $18 ; note C2 dur 24
    db $15, $18 ; note F1 dur 24
    db $25, $18 ; note F2 dur 24
    db $15, $18 ; note F1 dur 24
    db $19, $18 ; note A1 dur 24
    db $20, $18 ; note C2 dur 24
    db $25, $18 ; note F2 dur 24
    db $A2, $FF ; duty2 $FF
    db $19, $24 ; note A1 dur 36
    db $A0, $04 ; volume $04
    db $19, $0C ; note A1 dur 12
    db $A0, $02 ; volume $02
    db $19, $24 ; note A1 dur 36
    db $A0, $04 ; volume $04
    db $19, $0C ; note A1 dur 12
    db $A0, $02 ; volume $02
    db $A2, $48 ; duty2 $48
    db $22, $18 ; note D2 dur 24
    db $19, $18 ; note A1 dur 24
    db $15, $18 ; note F1 dur 24
    db $12, $18 ; note D1 dur 24
    db $1B, $18 ; note B1 dur 24
    db $22, $18 ; note D2 dur 24
    db $27, $18 ; note G2 dur 24
    db $17, $18 ; note G1 dur 24
    db $A2, $FF ; duty2 $FF
    db $20, $24 ; note C2 dur 36
    db $A0, $04 ; volume $04
    db $20, $0C ; note C2 dur 12
    db $A0, $02 ; volume $02
    db $A2, $48 ; duty2 $48
    db $20, $18 ; note C2 dur 24
    db $24, $18 ; note E2 dur 24
    db $19, $18 ; note A1 dur 24
    db $21, $18 ; note C#2 dur 24
    db $24, $18 ; note E2 dur 24
    db $19, $18 ; note A1 dur 24
    db $22, $18 ; note D2 dur 24
    db $24, $18 ; note E2 dur 24
    db $25, $18 ; note F2 dur 24
    db $22, $18 ; note D2 dur 24
    db $1B, $18 ; note B1 dur 24
    db $22, $18 ; note D2 dur 24
    db $27, $18 ; note G2 dur 24
    db $17, $18 ; note G1 dur 24
    db $20, $18 ; note C2 dur 24
    db $20, $18 ; note C2 dur 24
    db $27, $18 ; note G2 dur 24
    db $2A, $18 ; note A#2 dur 24
    db $29, $18 ; note A2 dur 24
    db $26, $18 ; note F#2 dur 24
    db $22, $18 ; note D2 dur 24
    db $12, $18 ; note D1 dur 24
    db $17, $18 ; note G1 dur 24
    db $19, $18 ; note A1 dur 24
    db $1A, $18 ; note A#1 dur 24
    db $17, $18 ; note G1 dur 24
    db $27, $18 ; note G2 dur 24
    db $20, $18 ; note C2 dur 24
    db $2A, $18 ; note A#2 dur 24
    db $20, $18 ; note C2 dur 24
    db $25, $18 ; note F2 dur 24
    db $20, $18 ; note C2 dur 24
    db $15, $18 ; note F1 dur 24
    db $A2, $12 ; duty2 $12
    db $1F, $18 ; rest-note $1F dur 24
    db $FD, $F0 ; label 0
    db $25, $08 ; note F2 dur 8
    db $24, $08 ; note E2 dur 8
    db $B2, $F0 ; repeat $F0
    db $23, $08 ; note D#2 dur 8
    db $25, $08 ; note F2 dur 8
    db $23, $08 ; note D#2 dur 8
    db $22, $08 ; note D2 dur 8
    db $21, $08 ; note C#2 dur 8
    db $22, $08 ; note D2 dur 8
    db $19, $08 ; note A1 dur 8
    db $18, $08 ; note G#1 dur 8
    db $19, $08 ; note A1 dur 8
    db $20, $08 ; note C2 dur 8
    db $19, $08 ; note A1 dur 8
    db $20, $08 ; note C2 dur 8
    db $1A, $08 ; note A#1 dur 8
    db $20, $08 ; note C2 dur 8
    db $1A, $08 ; note A#1 dur 8
    db $19, $08 ; note A1 dur 8
    db $1A, $08 ; note A#1 dur 8
    db $19, $08 ; note A1 dur 8
    db $FD, $F0 ; label 0
    db $15, $08 ; note F1 dur 8
    db $14, $08 ; note E1 dur 8
    db $B5, $F0 ; repeat $F0
    db $15, $08 ; note F1 dur 8
    db $17, $08 ; note G1 dur 8
    db $18, $08 ; note G#1 dur 8
    db $19, $08 ; note A1 dur 8
    db $1A, $08 ; note A#1 dur 8
    db $1B, $08 ; note B1 dur 8
    db $20, $08 ; note C2 dur 8
    db $22, $08 ; note D2 dur 8
    db $24, $08 ; note E2 dur 8
    db $25, $08 ; note F2 dur 8
    db $20, $08 ; note C2 dur 8
    db $19, $08 ; note A1 dur 8
    db $FD, $F0 ; label 0
    db $19, $08 ; note A1 dur 8
    db $17, $08 ; note G1 dur 8
    db $B5, $F0 ; repeat $F0
    db $22, $08 ; note D2 dur 8
    db $21, $08 ; note C#2 dur 8
    db $22, $08 ; note D2 dur 8
    db $19, $08 ; note A1 dur 8
    db $18, $08 ; note G#1 dur 8
    db $19, $08 ; note A1 dur 8
    db $15, $08 ; note F1 dur 8
    db $14, $08 ; note E1 dur 8
    db $15, $08 ; note F1 dur 8
    db $22, $08 ; note D2 dur 8
    db $25, $08 ; note F2 dur 8
    db $29, $08 ; note A2 dur 8
    db $1B, $08 ; note B1 dur 8
    db $1B, $08 ; note B1 dur 8
    db $20, $08 ; note C2 dur 8
    db $22, $08 ; note D2 dur 8
    db $22, $08 ; note D2 dur 8
    db $25, $08 ; note F2 dur 8
    db $27, $08 ; note G2 dur 8
    db $22, $08 ; note D2 dur 8
    db $1B, $08 ; note B1 dur 8
    db $17, $08 ; note G1 dur 8
    db $15, $08 ; note F1 dur 8
    db $17, $08 ; note G1 dur 8
    db $20, $08 ; note C2 dur 8
    db $1B, $08 ; note B1 dur 8
    db $22, $08 ; note D2 dur 8
    db $20, $08 ; note C2 dur 8
    db $1B, $08 ; note B1 dur 8
    db $22, $08 ; note D2 dur 8
    db $20, $08 ; note C2 dur 8
    db $1A, $08 ; note A#1 dur 8
    db $17, $08 ; note G1 dur 8
    db $14, $08 ; note E1 dur 8
    db $15, $08 ; note F1 dur 8
    db $17, $08 ; note G1 dur 8
    db $19, $08 ; note A1 dur 8
    db $18, $08 ; note G#1 dur 8
    db $19, $08 ; note A1 dur 8
    db $21, $08 ; note C#2 dur 8
    db $19, $08 ; note A1 dur 8
    db $21, $08 ; note C#2 dur 8
    db $24, $08 ; note E2 dur 8
    db $21, $08 ; note C#2 dur 8
    db $24, $08 ; note E2 dur 8
    db $29, $08 ; note A2 dur 8
    db $28, $08 ; note G#2 dur 8
    db $29, $08 ; note A2 dur 8
    db $22, $08 ; note D2 dur 8
    db $21, $08 ; note C#2 dur 8
    db $22, $08 ; note D2 dur 8
    db $24, $08 ; note E2 dur 8
    db $23, $08 ; note D#2 dur 8
    db $24, $08 ; note E2 dur 8
    db $25, $08 ; note F2 dur 8
    db $24, $08 ; note E2 dur 8
    db $25, $08 ; note F2 dur 8
    db $22, $08 ; note D2 dur 8
    db $19, $08 ; note A1 dur 8
    db $15, $08 ; note F1 dur 8
    db $1B, $08 ; note B1 dur 8
    db $17, $08 ; note G1 dur 8
    db $1B, $08 ; note B1 dur 8
    db $22, $08 ; note D2 dur 8
    db $1B, $08 ; note B1 dur 8
    db $22, $08 ; note D2 dur 8
    db $27, $08 ; note G2 dur 8
    db $26, $08 ; note F#2 dur 8
    db $27, $08 ; note G2 dur 8
    db $25, $08 ; note F2 dur 8
    db $22, $08 ; note D2 dur 8
    db $17, $08 ; note G1 dur 8
    db $20, $08 ; note C2 dur 8
    db $1B, $08 ; note B1 dur 8
    db $20, $08 ; note C2 dur 8
    db $22, $08 ; note D2 dur 8
    db $24, $08 ; note E2 dur 8
    db $25, $08 ; note F2 dur 8
    db $27, $08 ; note G2 dur 8
    db $26, $08 ; note F#2 dur 8
    db $27, $08 ; note G2 dur 8
    db $24, $08 ; note E2 dur 8
    db $22, $08 ; note D2 dur 8
    db $20, $08 ; note C2 dur 8
    db $29, $08 ; note A2 dur 8
    db $28, $08 ; note G#2 dur 8
    db $29, $08 ; note A2 dur 8
    db $26, $08 ; note F#2 dur 8
    db $29, $08 ; note A2 dur 8
    db $26, $08 ; note F#2 dur 8
    db $22, $08 ; note D2 dur 8
    db $20, $08 ; note C2 dur 8
    db $19, $08 ; note A1 dur 8
    db $12, $08 ; note D1 dur 8
    db $14, $08 ; note E1 dur 8
    db $16, $08 ; note F#1 dur 8
    db $17, $08 ; note G1 dur 8
    db $16, $08 ; note F#1 dur 8
    db $17, $08 ; note G1 dur 8
    db $19, $08 ; note A1 dur 8
    db $18, $08 ; note G#1 dur 8
    db $19, $08 ; note A1 dur 8
    db $1A, $08 ; note A#1 dur 8
    db $19, $08 ; note A1 dur 8
    db $1A, $08 ; note A#1 dur 8
    db $17, $08 ; note G1 dur 8
    db $15, $08 ; note F1 dur 8
    db $17, $08 ; note G1 dur 8
    db $A2, $70 ; duty2 $70
    db $27, $18 ; note G2 dur 24
    db $20, $18 ; note C2 dur 24
    db $2A, $18 ; note A#2 dur 24
    db $20, $18 ; note C2 dur 24
    db $A2, $08 ; duty2 $08
    db $25, $08 ; note F2 dur 8
    db $A2, $10 ; duty2 $10
    db $25, $08 ; note F2 dur 8
    db $20, $08 ; note C2 dur 8
    db $15, $08 ; note F1 dur 8
    db $19, $08 ; note A1 dur 8
    db $20, $08 ; note C2 dur 8
    db $A2, $70 ; duty2 $70
    db $25, $0C ; note F2 dur 12
    db $A0, $06 ; volume $06
    db $25, $13 ; note F2 dur 19
    db $1F, $02 ; rest-note $1F dur 2
    db $A0, $02 ; volume $02
    db $A1, $03 ; duty $03
    db $AF, $07 ; param $07
    db $1F, $19 ; rest-note $1F dur 25
    db $A2, $A0 ; duty2 $A0
    db $A0, $04 ; volume $04
    db $32, $30 ; note D3 dur 48
    db $37, $18 ; note G3 dur 24
    db $35, $18 ; note F3 dur 24
    db $A2, $70 ; duty2 $70
    db $34, $4A ; note E3 dur 74
    db $A0, $02 ; volume $02
    db $A2, $5F ; duty2 $5F
    db $A1, $0A ; duty $0A
    db $1A, $1A ; note A#1 dur 26
    db $1A, $1A ; note A#1 dur 26
    db $19, $1B ; note A1 dur 27
    db $A2, $50 ; duty2 $50
    db $17, $0C ; note G1 dur 12
    db $A1, $03 ; duty $03
    db $A2, $24 ; duty2 $24
    db $27, $0C ; note G2 dur 12
    db $27, $0C ; note G2 dur 12
    db $2A, $0C ; note A#2 dur 12
    db $2A, $0C ; note A#2 dur 12
    db $32, $0C ; note D3 dur 12
    db $32, $0C ; note D3 dur 12
    db $A2, $38 ; duty2 $38
    db $A1, $0B ; duty $0B
    db $17, $0C ; note G1 dur 12
    db $A2, $40 ; duty2 $40
    db $20, $0C ; note C2 dur 12
    db $A1, $03 ; duty $03
    db $A2, $24 ; duty2 $24
    db $24, $0C ; note E2 dur 12
    db $24, $0C ; note E2 dur 12
    db $2A, $0C ; note A#2 dur 12
    db $2A, $0D ; note A#2 dur 13
    db $34, $0D ; note E3 dur 13
    db $34, $0D ; note E3 dur 13
    db $A2, $38 ; duty2 $38
    db $A1, $0B ; duty $0B
    db $20, $0D ; note C2 dur 13
    db $A2, $40 ; duty2 $40
    db $15, $0E ; note F1 dur 14
    db $A1, $03 ; duty $03
    db $A2, $24 ; duty2 $24
    db $25, $0D ; note F2 dur 13
    db $25, $0D ; note F2 dur 13
    db $29, $0D ; note A2 dur 13
    db $29, $0E ; note A2 dur 14
    db $30, $0E ; note C3 dur 14
    db $30, $0E ; note C3 dur 14
    db $A1, $0B ; duty $0B
    db $A2, $40 ; duty2 $40
    db $15, $0F ; note F1 dur 15
    db $A1, $03 ; duty $03
    db $A2, $FF ; duty2 $FF
    db $15, $21 ; note F1 dur 33
    db $A0, $04 ; volume $04
    db $15, $03 ; note F1 dur 3
    db $A0, $02 ; volume $02
    db $25, $03 ; note F2 dur 3
    db $27, $03 ; note G2 dur 3
    db $29, $03 ; note A2 dur 3
    db $2A, $03 ; note A#2 dur 3
    db $30, $03 ; note C3 dur 3
    db $32, $03 ; note D3 dur 3
    db $34, $03 ; note E3 dur 3
    db $35, $19 ; note F3 dur 25
    db $1F, $18 ; rest-note $1F dur 24
    db $1F, $5A ; rest-note $1F dur 90
    db $FF, $FF ; end

; sound track, 234 events after the header (E-0019: grammar C2, meaning C0)
Data_040_481D:: ; heuristic: track stream of a sound record; C0
    db $01, $01, $09, $00 ; header: param=1 byte1=$01 volume=$09 byte3=$00
    db $FD, $F3 ; label 3
    db $C2, $06 ; env $06
    db $1F, $30 ; rest-note $1F dur 48
    db $26, $0C ; note F#2 dur 12
    db $29, $0C ; note A2 dur 12
    db $A0, $0C ; volume $0C
    db $32, $0C ; note D3 dur 12
    db $A0, $0D ; volume $0D
    db $32, $0C ; note D3 dur 12
    db $A0, $0B ; volume $0B
    db $29, $0C ; note A2 dur 12
    db $A0, $09 ; volume $09
    db $26, $0C ; note F#2 dur 12
    db $22, $18 ; note D2 dur 24
    db $26, $0C ; note F#2 dur 12
    db $29, $0C ; note A2 dur 12
    db $A0, $0C ; volume $0C
    db $31, $0C ; note C#3 dur 12
    db $A0, $0D ; volume $0D
    db $31, $0C ; note C#3 dur 12
    db $A0, $0B ; volume $0B
    db $29, $0C ; note A2 dur 12
    db $A0, $09 ; volume $09
    db $26, $0C ; note F#2 dur 12
    db $21, $0C ; note C#2 dur 12
    db $1B, $0C ; note B1 dur 12
    db $A0, $0F ; volume $0F
    db $22, $0C ; note D2 dur 12
    db $A0, $07 ; volume $07
    db $26, $0C ; note F#2 dur 12
    db $2B, $0C ; note B2 dur 12
    db $17, $0C ; note G1 dur 12
    db $27, $0C ; note G2 dur 12
    db $A0, $0A ; volume $0A
    db $22, $0C ; note D2 dur 12
    db $27, $0C ; note G2 dur 12
    db $22, $0C ; note D2 dur 12
    db $A0, $0C ; volume $0C
    db $27, $0C ; note G2 dur 12
    db $A0, $0D ; volume $0D
    db $2B, $0C ; note B2 dur 12
    db $A0, $0F ; volume $0F
    db $32, $0C ; note D3 dur 12
    db $CA, $12 ; env $12
    db $31, $06 ; note C#3 dur 6
    db $C1, $1F ; env $1F
    db $A0, $04 ; volume $04
    db $31, $36 ; note C#3 dur 54
    db $A0, $09 ; volume $09
    db $C2, $06 ; env $06
    db $1B, $0C ; note B1 dur 12
    db $24, $0C ; note E2 dur 12
    db $A0, $0C ; volume $0C
    db $27, $0C ; note G2 dur 12
    db $A0, $0D ; volume $0D
    db $2B, $0C ; note B2 dur 12
    db $A0, $0B ; volume $0B
    db $27, $0C ; note G2 dur 12
    db $A0, $09 ; volume $09
    db $24, $0C ; note E2 dur 12
    db $27, $18 ; note G2 dur 24
    db $1B, $0C ; note B1 dur 12
    db $23, $0C ; note D#2 dur 12
    db $A0, $0C ; volume $0C
    db $27, $0C ; note G2 dur 12
    db $A0, $0D ; volume $0D
    db $2B, $0C ; note B2 dur 12
    db $A0, $0B ; volume $0B
    db $27, $0C ; note G2 dur 12
    db $A0, $09 ; volume $09
    db $23, $0C ; note D#2 dur 12
    db $27, $0C ; note G2 dur 12
    db $22, $0C ; note D2 dur 12
    db $A0, $0F ; volume $0F
    db $1B, $0C ; note B1 dur 12
    db $A0, $07 ; volume $07
    db $22, $0C ; note D2 dur 12
    db $27, $0C ; note G2 dur 12
    db $A0, $0A ; volume $0A
    db $21, $0C ; note C#2 dur 12
    db $29, $0C ; note A2 dur 12
    db $21, $0C ; note C#2 dur 12
    db $27, $0C ; note G2 dur 12
    db $A0, $07 ; volume $07
    db $22, $0C ; note D2 dur 12
    db $A0, $0A ; volume $0A
    db $26, $0C ; note F#2 dur 12
    db $A0, $0C ; volume $0C
    db $26, $0C ; note F#2 dur 12
    db $A0, $0E ; volume $0E
    db $29, $0C ; note A2 dur 12
    db $A0, $0F ; volume $0F
    db $30, $0C ; note C3 dur 12
    db $A0, $09 ; volume $09
    db $29, $0C ; note A2 dur 12
    db $A0, $07 ; volume $07
    db $26, $0C ; note F#2 dur 12
    db $20, $0C ; note C2 dur 12
    db $AF, $01 ; param $01
    db $A2, $01 ; duty2 $01
    db $A0, $0C ; volume $0C
    db $A1, $00 ; duty $00
    db $C2, $06 ; env $06
    db $17, $0C ; note G1 dur 12
    db $A0, $0F ; volume $0F
    db $26, $0C ; note F#2 dur 12
    db $A0, $08 ; volume $08
    db $35, $0C ; note F3 dur 12
    db $34, $0C ; note E3 dur 12
    db $A0, $07 ; volume $07
    db $33, $0C ; note D#3 dur 12
    db $32, $0C ; note D3 dur 12
    db $31, $0C ; note C#3 dur 12
    db $2B, $0C ; note B2 dur 12
    db $26, $0C ; note F#2 dur 12
    db $A0, $0F ; volume $0F
    db $29, $0C ; note A2 dur 12
    db $A0, $07 ; volume $07
    db $26, $0C ; note F#2 dur 12
    db $A0, $0F ; volume $0F
    db $24, $0C ; note E2 dur 12
    db $A0, $07 ; volume $07
    db $23, $0C ; note D#2 dur 12
    db $A0, $0F ; volume $0F
    db $23, $0C ; note D#2 dur 12
    db $A0, $07 ; volume $07
    db $26, $0C ; note F#2 dur 12
    db $A0, $0F ; volume $0F
    db $29, $0C ; note A2 dur 12
    db $A0, $0C ; volume $0C
    db $24, $0C ; note E2 dur 12
    db $A0, $0F ; volume $0F
    db $27, $0C ; note G2 dur 12
    db $A0, $08 ; volume $08
    db $36, $0C ; note F#3 dur 12
    db $35, $0C ; note F3 dur 12
    db $A0, $07 ; volume $07
    db $34, $0C ; note E3 dur 12
    db $33, $0C ; note D#3 dur 12
    db $32, $0C ; note D3 dur 12
    db $31, $0C ; note C#3 dur 12
    db $2B, $0C ; note B2 dur 12
    db $A0, $0F ; volume $0F
    db $29, $0C ; note A2 dur 12
    db $A0, $07 ; volume $07
    db $28, $0C ; note G#2 dur 12
    db $A0, $0F ; volume $0F
    db $CA, $08 ; env $08
    db $24, $18 ; note E2 dur 24
    db $21, $18 ; note C#2 dur 24
    db $21, $18 ; note C#2 dur 24
    db $1F, $0C ; rest-note $1F dur 12
    db $CA, $12 ; env $12
    db $A0, $0E ; volume $0E
    db $34, $06 ; note E3 dur 6
    db $A0, $04 ; volume $04
    db $C1, $2F ; env $2F
    db $34, $1E ; note E3 dur 30
    db $C2, $06 ; env $06
    db $A0, $0C ; volume $0C
    db $36, $0C ; note F#3 dur 12
    db $34, $0C ; note E3 dur 12
    db $33, $0C ; note D#3 dur 12
    db $A0, $0B ; volume $0B
    db $31, $0C ; note C#3 dur 12
    db $2B, $0C ; note B2 dur 12
    db $A0, $0A ; volume $0A
    db $29, $0C ; note A2 dur 12
    db $27, $0C ; note G2 dur 12
    db $A0, $08 ; volume $08
    db $26, $0C ; note F#2 dur 12
    db $24, $0C ; note E2 dur 12
    db $22, $0C ; note D2 dur 12
    db $21, $0C ; note C#2 dur 12
    db $FD, $F0 ; label 0
    db $A0, $0C ; volume $0C
    db $1F, $0C ; rest-note $1F dur 12
    db $CA, $0F ; env $0F
    db $26, $18 ; note F#2 dur 24
    db $26, $18 ; note F#2 dur 24
    db $29, $18 ; note A2 dur 24
    db $2B, $18 ; note B2 dur 24
    db $2B, $18 ; note B2 dur 24
    db $CA, $0F ; env $0F
    db $29, $18 ; note A2 dur 24
    db $C2, $08 ; env $08
    db $A0, $08 ; volume $08
    db $24, $0C ; note E2 dur 12
    db $22, $0C ; note D2 dur 12
    db $CB, $0B ; env $0B
    db $A0, $0A ; volume $0A
    db $27, $0C ; note G2 dur 12
    db $B1, $F0 ; repeat $F0
    db $A0, $03 ; volume $03
    db $27, $0C ; note G2 dur 12
    db $A0, $0C ; volume $0C
    db $CB, $0B ; env $0B
    db $26, $18 ; note F#2 dur 24
    db $26, $18 ; note F#2 dur 24
    db $29, $18 ; note A2 dur 24
    db $2B, $18 ; note B2 dur 24
    db $2B, $18 ; note B2 dur 24
    db $CA, $0F ; env $0F
    db $A0, $0E ; volume $0E
    db $29, $18 ; note A2 dur 24
    db $C2, $08 ; env $08
    db $A0, $0C ; volume $0C
    db $24, $0C ; note E2 dur 12
    db $24, $0C ; note E2 dur 12
    db $2A, $18 ; note A#2 dur 24
    db $1F, $0C ; rest-note $1F dur 12
    db $CA, $12 ; env $12
    db $A0, $0E ; volume $0E
    db $26, $06 ; note F#2 dur 6
    db $A0, $04 ; volume $04
    db $C1, $2F ; env $2F
    db $26, $12 ; note F#2 dur 18
    db $C2, $06 ; env $06
    db $A0, $0C ; volume $0C
    db $18, $0C ; note G#1 dur 12
    db $24, $0C ; note E2 dur 12
    db $28, $0C ; note G#2 dur 12
    db $CB, $0B ; env $0B
    db $2B, $18 ; note B2 dur 24
    db $A0, $0F ; volume $0F
    db $C2, $06 ; env $06
    db $27, $0C ; note G2 dur 12
    db $A0, $09 ; volume $09
    db $27, $0C ; note G2 dur 12
    db $24, $0C ; note E2 dur 12
    db $A0, $08 ; volume $08
    db $21, $0C ; note C#2 dur 12
    db $B0, $F3 ; jump $F3
    db $FF, $FF ; end

; sound track, 235 events after the header (E-0019: grammar C2, meaning C0)
Data_040_49F5:: ; heuristic: track stream of a sound record; C0
    db $01, $01, $0E, $00 ; header: param=1 byte1=$01 volume=$0E byte3=$00
    db $FD, $F3 ; label 3
    db $A0, $0E ; volume $0E
    db $A3, $05 ; mod $05
    db $CA, $0F ; env $0F
    db $36, $18 ; note F#3 dur 24
    db $37, $0C ; note G3 dur 12
    db $CA, $12 ; env $12
    db $A0, $0F ; volume $0F
    db $39, $06 ; note A3 dur 6
    db $C1, $2F ; env $2F
    db $A0, $04 ; volume $04
    db $39, $36 ; note A3 dur 54
    db $A0, $0E ; volume $0E
    db $C2, $08 ; env $08
    db $36, $0C ; note F#3 dur 12
    db $36, $0C ; note F#3 dur 12
    db $37, $0C ; note G3 dur 12
    db $CA, $12 ; env $12
    db $A0, $0F ; volume $0F
    db $39, $06 ; note A3 dur 6
    db $C1, $2F ; env $2F
    db $A0, $04 ; volume $04
    db $39, $36 ; note A3 dur 54
    db $CA, $0F ; env $0F
    db $A0, $0E ; volume $0E
    db $36, $18 ; note F#3 dur 24
    db $CA, $10 ; env $10
    db $37, $18 ; note G3 dur 24
    db $CA, $0A ; env $0A
    db $A0, $0F ; volume $0F
    db $39, $0C ; note A3 dur 12
    db $C2, $08 ; env $08
    db $A0, $0A ; volume $0A
    db $36, $0C ; note F#3 dur 12
    db $34, $0C ; note E3 dur 12
    db $32, $0C ; note D3 dur 12
    db $CB, $0B ; env $0B
    db $2B, $18 ; note B2 dur 24
    db $CA, $12 ; env $12
    db $34, $06 ; note E3 dur 6
    db $C1, $2C ; env $2C
    db $A0, $03 ; volume $03
    db $34, $36 ; note E3 dur 54
    db $1F, $0C ; rest-note $1F dur 12
    db $A0, $0E ; volume $0E
    db $CA, $0F ; env $0F
    db $37, $18 ; note G3 dur 24
    db $39, $0C ; note A3 dur 12
    db $CA, $12 ; env $12
    db $A0, $0F ; volume $0F
    db $3B, $06 ; note B3 dur 6
    db $C1, $2F ; env $2F
    db $A0, $04 ; volume $04
    db $3B, $36 ; note B3 dur 54
    db $A0, $0E ; volume $0E
    db $C2, $08 ; env $08
    db $37, $0C ; note G3 dur 12
    db $37, $0C ; note G3 dur 12
    db $39, $0C ; note A3 dur 12
    db $CA, $12 ; env $12
    db $A0, $0F ; volume $0F
    db $3B, $06 ; note B3 dur 6
    db $C1, $2F ; env $2F
    db $A0, $04 ; volume $04
    db $3B, $36 ; note B3 dur 54
    db $A0, $0D ; volume $0D
    db $C2, $08 ; env $08
    db $CA, $0F ; env $0F
    db $37, $18 ; note G3 dur 24
    db $CA, $10 ; env $10
    db $A0, $0C ; volume $0C
    db $39, $18 ; note A3 dur 24
    db $C2, $08 ; env $08
    db $A0, $0F ; volume $0F
    db $3B, $0C ; note B3 dur 12
    db $A0, $09 ; volume $09
    db $41, $0C ; note C#4 dur 12
    db $42, $0C ; note D4 dur 12
    db $A0, $0B ; volume $0B
    db $41, $0C ; note C#4 dur 12
    db $3B, $0C ; note B3 dur 12
    db $A0, $0D ; volume $0D
    db $39, $0C ; note A3 dur 12
    db $3B, $0C ; note B3 dur 12
    db $CA, $12 ; env $12
    db $36, $06 ; note F#3 dur 6
    db $C1, $2C ; env $2C
    db $A0, $03 ; volume $03
    db $36, $36 ; note F#3 dur 54
    db $C2, $08 ; env $08
    db $A0, $0F ; volume $0F
    db $26, $0C ; note F#2 dur 12
    db $29, $0C ; note A2 dur 12
    db $36, $0C ; note F#3 dur 12
    db $AF, $01 ; param $01
    db $A2, $01 ; duty2 $01
    db $A0, $0F ; volume $0F
    db $A1, $00 ; duty $00
    db $C2, $08 ; env $08
    db $1F, $0C ; rest-note $1F dur 12
    db $36, $0C ; note F#3 dur 12
    db $A0, $0A ; volume $0A
    db $36, $0C ; note F#3 dur 12
    db $36, $0C ; note F#3 dur 12
    db $A0, $08 ; volume $08
    db $36, $0C ; note F#3 dur 12
    db $A0, $0A ; volume $0A
    db $36, $0C ; note F#3 dur 12
    db $A0, $09 ; volume $09
    db $34, $0C ; note E3 dur 12
    db $32, $0C ; note D3 dur 12
    db $A0, $0A ; volume $0A
    db $2B, $0C ; note B2 dur 12
    db $A0, $0E ; volume $0E
    db $31, $0C ; note C#3 dur 12
    db $A0, $08 ; volume $08
    db $29, $0C ; note A2 dur 12
    db $A0, $0F ; volume $0F
    db $2B, $18 ; note B2 dur 24
    db $CA, $0A ; env $0A
    db $26, $18 ; note F#2 dur 24
    db $CA, $0F ; env $0F
    db $A0, $0E ; volume $0E
    db $2B, $18 ; note B2 dur 24
    db $A0, $0F ; volume $0F
    db $C2, $08 ; env $08
    db $37, $0C ; note G3 dur 12
    db $A0, $0A ; volume $0A
    db $37, $0C ; note G3 dur 12
    db $37, $0C ; note G3 dur 12
    db $A0, $08 ; volume $08
    db $37, $0C ; note G3 dur 12
    db $A0, $0A ; volume $0A
    db $37, $0C ; note G3 dur 12
    db $A0, $09 ; volume $09
    db $36, $0C ; note F#3 dur 12
    db $34, $0C ; note E3 dur 12
    db $A0, $0A ; volume $0A
    db $32, $0C ; note D3 dur 12
    db $A0, $0F ; volume $0F
    db $31, $0C ; note C#3 dur 12
    db $A0, $0A ; volume $0A
    db $2B, $0C ; note B2 dur 12
    db $A0, $0E ; volume $0E
    db $CA, $0A ; env $0A
    db $29, $0C ; note A2 dur 12
    db $A0, $04 ; volume $04
    db $29, $0C ; note A2 dur 12
    db $A0, $0E ; volume $0E
    db $CA, $0D ; env $0D
    db $29, $18 ; note A2 dur 24
    db $A0, $0C ; volume $0C
    db $29, $18 ; note A2 dur 24
    db $1F, $0C ; rest-note $1F dur 12
    db $A0, $0F ; volume $0F
    db $CA, $12 ; env $12
    db $39, $06 ; note A3 dur 6
    db $A0, $04 ; volume $04
    db $C1, $2F ; env $2F
    db $39, $1E ; note A3 dur 30
    db $A0, $0F ; volume $0F
    db $C2, $08 ; env $08
    db $39, $0C ; note A3 dur 12
    db $A0, $0D ; volume $0D
    db $37, $0C ; note G3 dur 12
    db $36, $0C ; note F#3 dur 12
    db $A0, $0C ; volume $0C
    db $34, $0C ; note E3 dur 12
    db $32, $0C ; note D3 dur 12
    db $A0, $0B ; volume $0B
    db $31, $0C ; note C#3 dur 12
    db $2B, $0C ; note B2 dur 12
    db $A0, $09 ; volume $09
    db $29, $0C ; note A2 dur 12
    db $27, $0C ; note G2 dur 12
    db $A0, $08 ; volume $08
    db $26, $0C ; note F#2 dur 12
    db $24, $0C ; note E2 dur 12
    db $C2, $06 ; env $06
    db $FD, $F0 ; label 0
    db $A0, $0F ; volume $0F
    db $1F, $0C ; rest-note $1F dur 12
    db $36, $0C ; note F#3 dur 12
    db $CA, $0F ; env $0F
    db $3B, $18 ; note B3 dur 24
    db $C2, $08 ; env $08
    db $34, $0C ; note E3 dur 12
    db $CA, $0F ; env $0F
    db $39, $18 ; note A3 dur 24
    db $C2, $08 ; env $08
    db $32, $0C ; note D3 dur 12
    db $CA, $0F ; env $0F
    db $37, $18 ; note G3 dur 24
    db $C2, $08 ; env $08
    db $31, $0C ; note C#3 dur 12
    db $CA, $0F ; env $0F
    db $36, $12 ; note F#3 dur 18
    db $1F, $06 ; rest-note $1F dur 6
    db $A0, $0B ; volume $0B
    db $C2, $08 ; env $08
    db $2B, $0C ; note B2 dur 12
    db $A0, $08 ; volume $08
    db $2B, $0C ; note B2 dur 12
    db $A0, $0B ; volume $0B
    db $31, $0C ; note C#3 dur 12
    db $B2, $F0 ; repeat $F0
    db $A0, $03 ; volume $03
    db $31, $0C ; note C#3 dur 12
    db $1F, $0C ; rest-note $1F dur 12
    db $CA, $12 ; env $12
    db $A0, $0F ; volume $0F
    db $32, $06 ; note D3 dur 6
    db $A0, $04 ; volume $04
    db $C1, $2F ; env $2F
    db $32, $1E ; note D3 dur 30
    db $C2, $08 ; env $08
    db $A0, $0F ; volume $0F
    db $34, $0C ; note E3 dur 12
    db $A0, $0C ; volume $0C
    db $36, $0C ; note F#3 dur 12
    db $A0, $0F ; volume $0F
    db $CA, $0A ; env $0A
    db $34, $0C ; note E3 dur 12
    db $A0, $04 ; volume $04
    db $34, $0C ; note E3 dur 12
    db $C2, $08 ; env $08
    db $A0, $0F ; volume $0F
    db $34, $0C ; note E3 dur 12
    db $A0, $09 ; volume $09
    db $2A, $0C ; note A#2 dur 12
    db $27, $0C ; note G2 dur 12
    db $A0, $08 ; volume $08
    db $24, $0C ; note E2 dur 12
    db $B0, $F3 ; jump $F3
    db $FF, $FF ; end

; sound track, 288 events after the header (E-0019: grammar C2, meaning C0)
Data_040_4BCF:: ; heuristic: track stream of a sound record; C0
    db $01, $08, $02, $0A ; header: param=1 byte1=$08 volume=$02 byte3=$0A
    db $FD, $F3 ; label 3
    db $1F, $24 ; rest-note $1F dur 36
    db $22, $0C ; note D2 dur 12
    db $A1, $03 ; duty $03
    db $A0, $04 ; volume $04
    db $32, $0C ; note D3 dur 12
    db $36, $0C ; note F#3 dur 12
    db $A0, $02 ; volume $02
    db $39, $0C ; note A3 dur 12
    db $39, $0C ; note A3 dur 12
    db $36, $0C ; note F#3 dur 12
    db $A0, $04 ; volume $04
    db $32, $0C ; note D3 dur 12
    db $29, $0C ; note A2 dur 12
    db $A1, $0A ; duty $0A
    db $A0, $02 ; volume $02
    db $21, $0C ; note C#2 dur 12
    db $A1, $03 ; duty $03
    db $A0, $04 ; volume $04
    db $31, $0C ; note C#3 dur 12
    db $36, $0C ; note F#3 dur 12
    db $A0, $02 ; volume $02
    db $39, $0C ; note A3 dur 12
    db $39, $0C ; note A3 dur 12
    db $36, $0C ; note F#3 dur 12
    db $A0, $04 ; volume $04
    db $31, $0C ; note C#3 dur 12
    db $26, $0C ; note F#2 dur 12
    db $A0, $04 ; volume $04
    db $A1, $0A ; duty $0A
    db $1B, $0C ; note B1 dur 12
    db $A0, $02 ; volume $02
    db $2B, $0C ; note B2 dur 12
    db $A1, $03 ; duty $03
    db $A0, $04 ; volume $04
    db $32, $0C ; note D3 dur 12
    db $36, $0C ; note F#3 dur 12
    db $A1, $0A ; duty $0A
    db $14, $0C ; note E1 dur 12
    db $A1, $03 ; duty $03
    db $A0, $04 ; volume $04
    db $24, $0C ; note E2 dur 12
    db $27, $0C ; note G2 dur 12
    db $A0, $02 ; volume $02
    db $2B, $0C ; note B2 dur 12
    db $A1, $0A ; duty $0A
    db $19, $0C ; note A1 dur 12
    db $A1, $03 ; duty $03
    db $29, $0C ; note A2 dur 12
    db $32, $0C ; note D3 dur 12
    db $37, $0C ; note G3 dur 12
    db $A1, $0A ; duty $0A
    db $A0, $04 ; volume $04
    db $39, $18 ; note A3 dur 24
    db $1F, $18 ; rest-note $1F dur 24
    db $A0, $02 ; volume $02
    db $24, $0C ; note E2 dur 12
    db $A0, $04 ; volume $04
    db $A1, $03 ; duty $03
    db $27, $0C ; note G2 dur 12
    db $2B, $0C ; note B2 dur 12
    db $A0, $02 ; volume $02
    db $34, $0C ; note E3 dur 12
    db $37, $0C ; note G3 dur 12
    db $34, $0C ; note E3 dur 12
    db $A0, $04 ; volume $04
    db $2B, $0C ; note B2 dur 12
    db $24, $0C ; note E2 dur 12
    db $A0, $02 ; volume $02
    db $A1, $0A ; duty $0A
    db $23, $0C ; note D#2 dur 12
    db $A1, $03 ; duty $03
    db $A0, $04 ; volume $04
    db $27, $0C ; note G2 dur 12
    db $2B, $0C ; note B2 dur 12
    db $A0, $02 ; volume $02
    db $33, $0C ; note D#3 dur 12
    db $37, $0C ; note G3 dur 12
    db $33, $0C ; note D#3 dur 12
    db $A0, $04 ; volume $04
    db $2B, $0C ; note B2 dur 12
    db $23, $0C ; note D#2 dur 12
    db $A0, $04 ; volume $04
    db $A1, $0A ; duty $0A
    db $22, $0C ; note D2 dur 12
    db $A0, $02 ; volume $02
    db $27, $0C ; note G2 dur 12
    db $A1, $03 ; duty $03
    db $A0, $04 ; volume $04
    db $2B, $0C ; note B2 dur 12
    db $32, $0C ; note D3 dur 12
    db $A0, $02 ; volume $02
    db $A1, $0A ; duty $0A
    db $21, $0C ; note C#2 dur 12
    db $A0, $04 ; volume $04
    db $A1, $03 ; duty $03
    db $27, $0C ; note G2 dur 12
    db $29, $0C ; note A2 dur 12
    db $34, $0C ; note E3 dur 12
    db $A0, $02 ; volume $02
    db $A1, $0A ; duty $0A
    db $12, $0C ; note D1 dur 12
    db $A1, $03 ; duty $03
    db $22, $0C ; note D2 dur 12
    db $29, $0C ; note A2 dur 12
    db $32, $0C ; note D3 dur 12
    db $A1, $0A ; duty $0A
    db $36, $0C ; note F#3 dur 12
    db $A1, $03 ; duty $03
    db $A0, $04 ; volume $04
    db $30, $0C ; note C3 dur 12
    db $29, $0C ; note A2 dur 12
    db $22, $0C ; note D2 dur 12
    db $AF, $01 ; param $01
    db $A2, $08 ; duty2 $08
    db $A0, $04 ; volume $04
    db $A1, $03 ; duty $03
    db $A1, $0A ; duty $0A
    db $17, $0C ; note G1 dur 12
    db $A0, $02 ; volume $02
    db $27, $0C ; note G2 dur 12
    db $A1, $03 ; duty $03
    db $A0, $04 ; volume $04
    db $2B, $0C ; note B2 dur 12
    db $32, $0C ; note D3 dur 12
    db $A0, $02 ; volume $02
    db $A1, $0A ; duty $0A
    db $21, $0C ; note C#2 dur 12
    db $A0, $04 ; volume $04
    db $A1, $03 ; duty $03
    db $2B, $0C ; note B2 dur 12
    db $34, $0C ; note E3 dur 12
    db $37, $0C ; note G3 dur 12
    db $A1, $0A ; duty $0A
    db $16, $0C ; note F#1 dur 12
    db $A1, $03 ; duty $03
    db $A0, $02 ; volume $02
    db $26, $0C ; note F#2 dur 12
    db $A0, $04 ; volume $04
    db $29, $0C ; note A2 dur 12
    db $A0, $02 ; volume $02
    db $31, $0C ; note C#3 dur 12
    db $A0, $04 ; volume $04
    db $A1, $0A ; duty $0A
    db $1B, $0C ; note B1 dur 12
    db $A0, $02 ; volume $02
    db $29, $0C ; note A2 dur 12
    db $A0, $04 ; volume $04
    db $A1, $03 ; duty $03
    db $33, $0C ; note D#3 dur 12
    db $A0, $02 ; volume $02
    db $A1, $0A ; duty $0A
    db $36, $0C ; note F#3 dur 12
    db $A0, $04 ; volume $04
    db $A1, $0A ; duty $0A
    db $14, $0C ; note E1 dur 12
    db $A0, $02 ; volume $02
    db $24, $0C ; note E2 dur 12
    db $A1, $03 ; duty $03
    db $A0, $04 ; volume $04
    db $2B, $0C ; note B2 dur 12
    db $32, $0C ; note D3 dur 12
    db $34, $0C ; note E3 dur 12
    db $2B, $0C ; note B2 dur 12
    db $27, $0C ; note G2 dur 12
    db $24, $0C ; note E2 dur 12
    db $A1, $0A ; duty $0A
    db $25, $0C ; note F2 dur 12
    db $A1, $03 ; duty $03
    db $A0, $02 ; volume $02
    db $2B, $0C ; note B2 dur 12
    db $A0, $04 ; volume $04
    db $25, $0C ; note F2 dur 12
    db $A1, $0A ; duty $0A
    db $A0, $02 ; volume $02
    db $26, $0C ; note F#2 dur 12
    db $A0, $04 ; volume $04
    db $A2, $06 ; duty2 $06
    db $16, $0C ; note F#1 dur 12
    db $A0, $02 ; volume $02
    db $A1, $03 ; duty $03
    db $26, $0C ; note F#2 dur 12
    db $A1, $0A ; duty $0A
    db $A0, $04 ; volume $04
    db $16, $0C ; note F#1 dur 12
    db $A0, $04 ; volume $04
    db $A1, $03 ; duty $03
    db $26, $0C ; note F#2 dur 12
    db $A2, $08 ; duty2 $08
    db $A0, $02 ; volume $02
    db $A1, $0A ; duty $0A
    db $20, $18 ; note C2 dur 24
    db $30, $18 ; note C3 dur 24
    db $1B, $0C ; note B1 dur 12
    db $A1, $03 ; duty $03
    db $33, $0C ; note D#3 dur 12
    db $1F, $0C ; rest-note $1F dur 12
    db $2B, $0C ; note B2 dur 12
    db $A1, $0A ; duty $0A
    db $18, $0C ; note G#1 dur 12
    db $A1, $03 ; duty $03
    db $28, $0C ; note G#2 dur 12
    db $1F, $18 ; rest-note $1F dur 24
    db $A1, $0A ; duty $0A
    db $19, $0C ; note A1 dur 12
    db $A1, $03 ; duty $03
    db $29, $0C ; note A2 dur 12
    db $1F, $18 ; rest-note $1F dur 24
    db $FD, $F0 ; label 0
    db $A1, $0A ; duty $0A
    db $22, $0C ; note D2 dur 12
    db $A1, $03 ; duty $03
    db $29, $0C ; note A2 dur 12
    db $A1, $0A ; duty $0A
    db $22, $0C ; note D2 dur 12
    db $A1, $03 ; duty $03
    db $29, $0C ; note A2 dur 12
    db $A1, $0A ; duty $0A
    db $21, $0C ; note C#2 dur 12
    db $A1, $03 ; duty $03
    db $26, $0C ; note F#2 dur 12
    db $A1, $0A ; duty $0A
    db $1B, $0C ; note B1 dur 12
    db $A1, $03 ; duty $03
    db $27, $0C ; note G2 dur 12
    db $A1, $0A ; duty $0A
    db $1B, $0C ; note B1 dur 12
    db $A1, $03 ; duty $03
    db $27, $0C ; note G2 dur 12
    db $A1, $0A ; duty $0A
    db $19, $0C ; note A1 dur 12
    db $A1, $03 ; duty $03
    db $26, $0C ; note F#2 dur 12
    db $A1, $0A ; duty $0A
    db $1F, $0C ; rest-note $1F dur 12
    db $27, $0C ; note G2 dur 12
    db $17, $0C ; note G1 dur 12
    db $A1, $03 ; duty $03
    db $29, $0C ; note A2 dur 12
    db $B1, $F0 ; repeat $F0
    db $A1, $0A ; duty $0A
    db $22, $0C ; note D2 dur 12
    db $A1, $03 ; duty $03
    db $29, $0C ; note A2 dur 12
    db $A1, $0A ; duty $0A
    db $22, $0C ; note D2 dur 12
    db $A1, $03 ; duty $03
    db $29, $0C ; note A2 dur 12
    db $A1, $0A ; duty $0A
    db $21, $0C ; note C#2 dur 12
    db $A1, $03 ; duty $03
    db $26, $0C ; note F#2 dur 12
    db $A1, $0A ; duty $0A
    db $1B, $0C ; note B1 dur 12
    db $A1, $03 ; duty $03
    db $27, $0C ; note G2 dur 12
    db $A1, $0A ; duty $0A
    db $1B, $0C ; note B1 dur 12
    db $A1, $03 ; duty $03
    db $27, $0C ; note G2 dur 12
    db $A1, $0A ; duty $0A
    db $19, $0C ; note A1 dur 12
    db $A1, $03 ; duty $03
    db $26, $0C ; note F#2 dur 12
    db $1F, $0C ; rest-note $1F dur 12
    db $17, $0C ; note G1 dur 12
    db $A1, $0A ; duty $0A
    db $27, $0C ; note G2 dur 12
    db $A1, $03 ; duty $03
    db $26, $0C ; note F#2 dur 12
    db $A1, $0A ; duty $0A
    db $1B, $18 ; note B1 dur 24
    db $2B, $18 ; note B2 dur 24
    db $18, $0C ; note G#1 dur 12
    db $28, $0C ; note G#2 dur 12
    db $A1, $03 ; duty $03
    db $2B, $0C ; note B2 dur 12
    db $32, $0C ; note D3 dur 12
    db $A1, $0A ; duty $0A
    db $20, $0C ; note C2 dur 12
    db $27, $0C ; note G2 dur 12
    db $A1, $03 ; duty $03
    db $A0, $04 ; volume $04
    db $30, $0C ; note C3 dur 12
    db $34, $0C ; note E3 dur 12
    db $29, $0C ; note A2 dur 12
    db $B0, $F3 ; jump $F3
    db $FF, $FF ; end

; sound track, 273 events after the header (E-0019: grammar C2, meaning C0)
Data_040_4E13:: ; heuristic: track stream of a sound record; C0
    db $08, $01, $0C, $00 ; header: param=8 byte1=$01 volume=$0C byte3=$00
    db $FD, $F3 ; label 3
    db $A2, $01 ; duty2 $01
    db $A0, $0C ; volume $0C
    db $C1, $40 ; env $40
    db $29, $05 ; note A2 dur 5
    db $A0, $06 ; volume $06
    db $29, $0A ; note A2 dur 10
    db $A0, $0B ; volume $0B
    db $29, $05 ; note A2 dur 5
    db $A0, $06 ; volume $06
    db $29, $0A ; note A2 dur 10
    db $A0, $0D ; volume $0D
    db $24, $05 ; note E2 dur 5
    db $A0, $06 ; volume $06
    db $C7, $1F ; env $1F
    db $24, $0F ; note E2 dur 15
    db $1F, $1E ; rest-note $1F dur 30
    db $C1, $7F ; env $7F
    db $A0, $0B ; volume $0B
    db $30, $05 ; note C3 dur 5
    db $C1, $50 ; env $50
    db $20, $05 ; note C2 dur 5
    db $19, $05 ; note A1 dur 5
    db $20, $05 ; note C2 dur 5
    db $19, $05 ; note A1 dur 5
    db $20, $05 ; note C2 dur 5
    db $19, $05 ; note A1 dur 5
    db $20, $05 ; note C2 dur 5
    db $A0, $0A ; volume $0A
    db $C1, $7F ; env $7F
    db $32, $05 ; note D3 dur 5
    db $A0, $0B ; volume $0B
    db $C1, $50 ; env $50
    db $20, $05 ; note C2 dur 5
    db $19, $05 ; note A1 dur 5
    db $20, $05 ; note C2 dur 5
    db $22, $05 ; note D2 dur 5
    db $20, $05 ; note C2 dur 5
    db $19, $05 ; note A1 dur 5
    db $20, $05 ; note C2 dur 5
    db $A0, $0A ; volume $0A
    db $C1, $7F ; env $7F
    db $34, $05 ; note E3 dur 5
    db $A0, $0B ; volume $0B
    db $C1, $50 ; env $50
    db $20, $05 ; note C2 dur 5
    db $19, $05 ; note A1 dur 5
    db $20, $05 ; note C2 dur 5
    db $24, $05 ; note E2 dur 5
    db $20, $05 ; note C2 dur 5
    db $19, $05 ; note A1 dur 5
    db $20, $05 ; note C2 dur 5
    db $A0, $0A ; volume $0A
    db $C1, $7F ; env $7F
    db $33, $05 ; note D#3 dur 5
    db $A0, $0B ; volume $0B
    db $C1, $50 ; env $50
    db $20, $05 ; note C2 dur 5
    db $19, $05 ; note A1 dur 5
    db $20, $05 ; note C2 dur 5
    db $23, $05 ; note D#2 dur 5
    db $20, $05 ; note C2 dur 5
    db $19, $05 ; note A1 dur 5
    db $20, $05 ; note C2 dur 5
    db $22, $05 ; note D2 dur 5
    db $25, $05 ; note F2 dur 5
    db $29, $05 ; note A2 dur 5
    db $25, $05 ; note F2 dur 5
    db $22, $05 ; note D2 dur 5
    db $25, $05 ; note F2 dur 5
    db $29, $05 ; note A2 dur 5
    db $25, $05 ; note F2 dur 5
    db $22, $05 ; note D2 dur 5
    db $25, $05 ; note F2 dur 5
    db $28, $05 ; note G#2 dur 5
    db $25, $05 ; note F2 dur 5
    db $22, $05 ; note D2 dur 5
    db $25, $05 ; note F2 dur 5
    db $28, $05 ; note G#2 dur 5
    db $25, $05 ; note F2 dur 5
    db $A0, $08 ; volume $08
    db $25, $05 ; note F2 dur 5
    db $A0, $0B ; volume $0B
    db $1A, $05 ; note A#1 dur 5
    db $22, $05 ; note D2 dur 5
    db $25, $05 ; note F2 dur 5
    db $2A, $05 ; note A#2 dur 5
    db $25, $05 ; note F2 dur 5
    db $22, $05 ; note D2 dur 5
    db $1A, $05 ; note A#1 dur 5
    db $24, $05 ; note E2 dur 5
    db $27, $05 ; note G2 dur 5
    db $24, $05 ; note E2 dur 5
    db $27, $05 ; note G2 dur 5
    db $1A, $05 ; note A#1 dur 5
    db $27, $05 ; note G2 dur 5
    db $24, $05 ; note E2 dur 5
    db $27, $05 ; note G2 dur 5
    db $24, $05 ; note E2 dur 5
    db $27, $05 ; note G2 dur 5
    db $24, $05 ; note E2 dur 5
    db $27, $05 ; note G2 dur 5
    db $24, $05 ; note E2 dur 5
    db $27, $05 ; note G2 dur 5
    db $24, $05 ; note E2 dur 5
    db $27, $05 ; note G2 dur 5
    db $21, $05 ; note C#2 dur 5
    db $24, $05 ; note E2 dur 5
    db $27, $05 ; note G2 dur 5
    db $31, $05 ; note C#3 dur 5
    db $37, $05 ; note G3 dur 5
    db $31, $05 ; note C#3 dur 5
    db $27, $05 ; note G2 dur 5
    db $24, $05 ; note E2 dur 5
    db $22, $05 ; note D2 dur 5
    db $25, $05 ; note F2 dur 5
    db $29, $05 ; note A2 dur 5
    db $25, $05 ; note F2 dur 5
    db $22, $05 ; note D2 dur 5
    db $25, $05 ; note F2 dur 5
    db $29, $05 ; note A2 dur 5
    db $25, $05 ; note F2 dur 5
    db $22, $05 ; note D2 dur 5
    db $24, $05 ; note E2 dur 5
    db $25, $05 ; note F2 dur 5
    db $29, $05 ; note A2 dur 5
    db $32, $05 ; note D3 dur 5
    db $30, $05 ; note C3 dur 5
    db $29, $05 ; note A2 dur 5
    db $25, $05 ; note F2 dur 5
    db $1A, $05 ; note A#1 dur 5
    db $22, $05 ; note D2 dur 5
    db $1A, $05 ; note A#1 dur 5
    db $22, $05 ; note D2 dur 5
    db $25, $05 ; note F2 dur 5
    db $1A, $05 ; note A#1 dur 5
    db $22, $05 ; note D2 dur 5
    db $25, $05 ; note F2 dur 5
    db $1A, $05 ; note A#1 dur 5
    db $21, $05 ; note C#2 dur 5
    db $1A, $05 ; note A#1 dur 5
    db $21, $05 ; note C#2 dur 5
    db $1A, $05 ; note A#1 dur 5
    db $21, $05 ; note C#2 dur 5
    db $1A, $05 ; note A#1 dur 5
    db $21, $05 ; note C#2 dur 5
    db $A0, $08 ; volume $08
    db $22, $0A ; note D2 dur 10
    db $A0, $0B ; volume $0B
    db $C2, $15 ; env $15
    db $22, $0A ; note D2 dur 10
    db $C1, $50 ; env $50
    db $24, $14 ; note E2 dur 20
    db $C1, $1F ; env $1F
    db $22, $05 ; note D2 dur 5
    db $22, $05 ; note D2 dur 5
    db $A0, $08 ; volume $08
    db $22, $05 ; note D2 dur 5
    db $A0, $0B ; volume $0B
    db $C1, $60 ; env $60
    db $24, $19 ; note E2 dur 25
    db $A2, $01 ; duty2 $01
    db $A0, $0A ; volume $0A
    db $C1, $30 ; env $30
    db $1F, $0A ; rest-note $1F dur 10
    db $29, $0A ; note A2 dur 10
    db $A0, $0C ; volume $0C
    db $28, $0A ; note G#2 dur 10
    db $A0, $0F ; volume $0F
    db $27, $0A ; note G2 dur 10
    db $26, $05 ; note F#2 dur 5
    db $C1, $7F ; env $7F
    db $26, $05 ; note F#2 dur 5
    db $A0, $08 ; volume $08
    db $26, $05 ; note F#2 dur 5
    db $A0, $0C ; volume $0C
    db $25, $0F ; note F2 dur 15
    db $A0, $08 ; volume $08
    db $25, $0A ; note F2 dur 10
    db $C1, $30 ; env $30
    db $A0, $0A ; volume $0A
    db $1F, $0A ; rest-note $1F dur 10
    db $25, $0A ; note F2 dur 10
    db $A0, $0C ; volume $0C
    db $24, $0A ; note E2 dur 10
    db $A0, $0F ; volume $0F
    db $23, $0A ; note D#2 dur 10
    db $22, $05 ; note D2 dur 5
    db $C1, $7F ; env $7F
    db $22, $05 ; note D2 dur 5
    db $A0, $08 ; volume $08
    db $22, $05 ; note D2 dur 5
    db $A0, $0C ; volume $0C
    db $1B, $0F ; note B1 dur 15
    db $A0, $08 ; volume $08
    db $1B, $0A ; note B1 dur 10
    db $A0, $0B ; volume $0B
    db $1F, $0A ; rest-note $1F dur 10
    db $2A, $05 ; note A#2 dur 5
    db $29, $05 ; note A2 dur 5
    db $2A, $05 ; note A#2 dur 5
    db $32, $0A ; note D3 dur 10
    db $31, $0A ; note C#3 dur 10
    db $30, $05 ; note C3 dur 5
    db $31, $05 ; note C#3 dur 5
    db $C0, $FE ; env $FE
    db $21, $19 ; note C#2 dur 25
    db $A0, $08 ; volume $08
    db $C1, $30 ; env $30
    db $21, $0A ; note C#2 dur 10
    db $A0, $0B ; volume $0B
    db $32, $05 ; note D3 dur 5
    db $31, $05 ; note C#3 dur 5
    db $32, $05 ; note D3 dur 5
    db $35, $0A ; note F3 dur 10
    db $34, $0A ; note E3 dur 10
    db $33, $05 ; note D#3 dur 5
    db $34, $05 ; note E3 dur 5
    db $C0, $FE ; env $FE
    db $35, $19 ; note F3 dur 25
    db $C1, $30 ; env $30
    db $A0, $08 ; volume $08
    db $35, $0A ; note F3 dur 10
    db $C1, $7F ; env $7F
    db $A0, $0B ; volume $0B
    db $35, $0A ; note F3 dur 10
    db $37, $0A ; note G3 dur 10
    db $35, $0A ; note F3 dur 10
    db $34, $0A ; note E3 dur 10
    db $A0, $08 ; volume $08
    db $34, $0A ; note E3 dur 10
    db $A0, $0C ; volume $0C
    db $24, $05 ; note E2 dur 5
    db $2A, $0A ; note A#2 dur 10
    db $29, $0F ; note A2 dur 15
    db $2A, $0A ; note A#2 dur 10
    db $A0, $0A ; volume $0A
    db $C1, $20 ; env $20
    db $2A, $05 ; note A#2 dur 5
    db $C1, $50 ; env $50
    db $2A, $0A ; note A#2 dur 10
    db $C1, $30 ; env $30
    db $29, $05 ; note A2 dur 5
    db $A0, $08 ; volume $08
    db $29, $05 ; note A2 dur 5
    db $A0, $0C ; volume $0C
    db $C1, $50 ; env $50
    db $1A, $05 ; note A#1 dur 5
    db $A0, $0A ; volume $0A
    db $19, $05 ; note A1 dur 5
    db $1A, $05 ; note A#1 dur 5
    db $A0, $0B ; volume $0B
    db $19, $05 ; note A1 dur 5
    db $1A, $05 ; note A#1 dur 5
    db $A0, $0D ; volume $0D
    db $19, $05 ; note A1 dur 5
    db $1A, $05 ; note A#1 dur 5
    db $A0, $08 ; volume $08
    db $1A, $0A ; note A#1 dur 10
    db $A0, $0C ; volume $0C
    db $22, $0A ; note D2 dur 10
    db $C1, $20 ; env $20
    db $A0, $0A ; volume $0A
    db $21, $05 ; note C#2 dur 5
    db $C1, $50 ; env $50
    db $21, $0A ; note C#2 dur 10
    db $C1, $30 ; env $30
    db $20, $05 ; note C2 dur 5
    db $A0, $08 ; volume $08
    db $20, $0A ; note C2 dur 10
    db $1F, $1E ; rest-note $1F dur 30
    db $B0, $F3 ; jump $F3
    db $FF, $FF ; end

; sound track, 259 events after the header (E-0019: grammar C2, meaning C0)
Data_040_5039:: ; heuristic: track stream of a sound record; C0
    db $08, $02, $0F, $00 ; header: param=8 byte1=$02 volume=$0F byte3=$00
    db $FD, $F3 ; label 3
    db $A0, $0F ; volume $0F
    db $A2, $02 ; duty2 $02
    db $A3, $06 ; mod $06
    db $C1, $40 ; env $40
    db $30, $05 ; note C3 dur 5
    db $A0, $06 ; volume $06
    db $30, $0A ; note C3 dur 10
    db $A0, $0F ; volume $0F
    db $30, $05 ; note C3 dur 5
    db $A0, $06 ; volume $06
    db $30, $0A ; note C3 dur 10
    db $A0, $0F ; volume $0F
    db $30, $05 ; note C3 dur 5
    db $A0, $06 ; volume $06
    db $C7, $2F ; env $2F
    db $30, $0F ; note C3 dur 15
    db $C1, $7F ; env $7F
    db $A0, $0D ; volume $0D
    db $30, $0A ; note C3 dur 10
    db $32, $0A ; note D3 dur 10
    db $35, $05 ; note F3 dur 5
    db $C1, $50 ; env $50
    db $39, $0A ; note A3 dur 10
    db $C1, $1F ; env $1F
    db $39, $05 ; note A3 dur 5
    db $39, $05 ; note A3 dur 5
    db $39, $05 ; note A3 dur 5
    db $C1, $7F ; env $7F
    db $3A, $05 ; note A#3 dur 5
    db $39, $05 ; note A3 dur 5
    db $A0, $08 ; volume $08
    db $39, $05 ; note A3 dur 5
    db $A0, $0D ; volume $0D
    db $C1, $50 ; env $50
    db $40, $05 ; note C4 dur 5
    db $A0, $06 ; volume $06
    db $40, $23 ; note C4 dur 35
    db $A0, $0D ; volume $0D
    db $C1, $50 ; env $50
    db $39, $0A ; note A3 dur 10
    db $C1, $1F ; env $1F
    db $39, $05 ; note A3 dur 5
    db $39, $05 ; note A3 dur 5
    db $39, $05 ; note A3 dur 5
    db $C1, $7F ; env $7F
    db $3A, $05 ; note A#3 dur 5
    db $39, $05 ; note A3 dur 5
    db $A0, $08 ; volume $08
    db $39, $05 ; note A3 dur 5
    db $A0, $0D ; volume $0D
    db $35, $0F ; note F3 dur 15
    db $30, $0A ; note C3 dur 10
    db $A0, $06 ; volume $06
    db $30, $0F ; note C3 dur 15
    db $A0, $0E ; volume $0E
    db $C1, $50 ; env $50
    db $32, $0A ; note D3 dur 10
    db $C1, $1F ; env $1F
    db $35, $05 ; note F3 dur 5
    db $C1, $20 ; env $20
    db $35, $05 ; note F3 dur 5
    db $32, $05 ; note D3 dur 5
    db $C1, $7F ; env $7F
    db $35, $05 ; note F3 dur 5
    db $32, $05 ; note D3 dur 5
    db $A0, $06 ; volume $06
    db $32, $05 ; note D3 dur 5
    db $A0, $0D ; volume $0D
    db $42, $0F ; note D4 dur 15
    db $40, $0A ; note C4 dur 10
    db $38, $05 ; note G#3 dur 5
    db $37, $05 ; note G3 dur 5
    db $35, $05 ; note F3 dur 5
    db $C0, $FE ; env $FE
    db $A3, $09 ; mod $09
    db $37, $19 ; note G3 dur 25
    db $A0, $08 ; volume $08
    db $C1, $60 ; env $60
    db $37, $1E ; note G3 dur 30
    db $A0, $0E ; volume $0E
    db $A3, $06 ; mod $06
    db $37, $0A ; note G3 dur 10
    db $39, $0A ; note A3 dur 10
    db $40, $0A ; note C4 dur 10
    db $C0, $FE ; env $FE
    db $41, $1E ; note C#4 dur 30
    db $C1, $60 ; env $60
    db $39, $0A ; note A3 dur 10
    db $C0, $FE ; env $FE
    db $44, $14 ; note E4 dur 20
    db $C1, $7F ; env $7F
    db $A0, $08 ; volume $08
    db $44, $14 ; note E4 dur 20
    db $A0, $0D ; volume $0D
    db $C0, $FE ; env $FE
    db $44, $19 ; note E4 dur 25
    db $C1, $60 ; env $60
    db $45, $05 ; note F4 dur 5
    db $44, $05 ; note E4 dur 5
    db $42, $14 ; note D4 dur 20
    db $C1, $7F ; env $7F
    db $A0, $08 ; volume $08
    db $42, $1E ; note D4 dur 30
    db $1F, $05 ; rest-note $1F dur 5
    db $A0, $0D ; volume $0D
    db $32, $05 ; note D3 dur 5
    db $A0, $0C ; volume $0C
    db $35, $05 ; note F3 dur 5
    db $C1, $30 ; env $30
    db $A0, $06 ; volume $06
    db $35, $05 ; note F3 dur 5
    db $A0, $0D ; volume $0D
    db $C1, $7F ; env $7F
    db $32, $05 ; note D3 dur 5
    db $A0, $0C ; volume $0C
    db $35, $05 ; note F3 dur 5
    db $C1, $30 ; env $30
    db $A0, $06 ; volume $06
    db $35, $05 ; note F3 dur 5
    db $A0, $0D ; volume $0D
    db $31, $05 ; note C#3 dur 5
    db $31, $05 ; note C#3 dur 5
    db $A0, $08 ; volume $08
    db $C1, $7F ; env $7F
    db $31, $05 ; note C#3 dur 5
    db $A0, $0D ; volume $0D
    db $39, $0A ; note A3 dur 10
    db $37, $05 ; note G3 dur 5
    db $35, $05 ; note F3 dur 5
    db $C0, $FE ; env $FE
    db $A3, $0D ; mod $0D
    db $37, $2D ; note G3 dur 45
    db $A0, $08 ; volume $08
    db $C1, $7F ; env $7F
    db $37, $28 ; note G3 dur 40
    db $A2, $01 ; duty2 $01
    db $A0, $0D ; volume $0D
    db $A3, $08 ; mod $08
    db $C1, $30 ; env $30
    db $1F, $0A ; rest-note $1F dur 10
    db $30, $0A ; note C3 dur 10
    db $A0, $0E ; volume $0E
    db $30, $0A ; note C3 dur 10
    db $A0, $0F ; volume $0F
    db $30, $0A ; note C3 dur 10
    db $A0, $0D ; volume $0D
    db $C1, $7F ; env $7F
    db $30, $05 ; note C3 dur 5
    db $32, $05 ; note D3 dur 5
    db $A0, $06 ; volume $06
    db $32, $05 ; note D3 dur 5
    db $A0, $0E ; volume $0E
    db $29, $0F ; note A2 dur 15
    db $A0, $08 ; volume $08
    db $29, $0A ; note A2 dur 10
    db $A0, $0E ; volume $0E
    db $C1, $30 ; env $30
    db $1F, $0A ; rest-note $1F dur 10
    db $29, $0A ; note A2 dur 10
    db $A0, $0F ; volume $0F
    db $29, $0A ; note A2 dur 10
    db $29, $0A ; note A2 dur 10
    db $C1, $7F ; env $7F
    db $27, $05 ; note G2 dur 5
    db $29, $05 ; note A2 dur 5
    db $A0, $08 ; volume $08
    db $29, $05 ; note A2 dur 5
    db $A0, $0E ; volume $0E
    db $22, $0F ; note D2 dur 15
    db $A0, $08 ; volume $08
    db $22, $0A ; note D2 dur 10
    db $A0, $0E ; volume $0E
    db $1F, $0A ; rest-note $1F dur 10
    db $32, $05 ; note D3 dur 5
    db $31, $05 ; note C#3 dur 5
    db $32, $05 ; note D3 dur 5
    db $C0, $FE ; env $FE
    db $35, $05 ; note F3 dur 5
    db $A0, $09 ; volume $09
    db $35, $05 ; note F3 dur 5
    db $C1, $30 ; env $30
    db $A0, $0E ; volume $0E
    db $34, $0A ; note E3 dur 10
    db $33, $05 ; note D#3 dur 5
    db $34, $05 ; note E3 dur 5
    db $C0, $FE ; env $FE
    db $29, $19 ; note A2 dur 25
    db $A0, $08 ; volume $08
    db $C1, $50 ; env $50
    db $29, $0A ; note A2 dur 10
    db $C1, $7F ; env $7F
    db $A0, $0E ; volume $0E
    db $35, $05 ; note F3 dur 5
    db $34, $05 ; note E3 dur 5
    db $35, $05 ; note F3 dur 5
    db $C0, $FE ; env $FE
    db $39, $05 ; note A3 dur 5
    db $A0, $0A ; volume $0A
    db $39, $05 ; note A3 dur 5
    db $A0, $0E ; volume $0E
    db $C1, $40 ; env $40
    db $37, $0A ; note G3 dur 10
    db $36, $05 ; note F#3 dur 5
    db $37, $05 ; note G3 dur 5
    db $C0, $FE ; env $FE
    db $42, $19 ; note D4 dur 25
    db $A0, $08 ; volume $08
    db $C1, $50 ; env $50
    db $42, $0A ; note D4 dur 10
    db $C1, $7F ; env $7F
    db $A0, $0E ; volume $0E
    db $42, $0A ; note D4 dur 10
    db $44, $0A ; note E4 dur 10
    db $42, $0A ; note D4 dur 10
    db $40, $0A ; note C4 dur 10
    db $A0, $08 ; volume $08
    db $40, $0A ; note C4 dur 10
    db $A0, $0E ; volume $0E
    db $30, $05 ; note C3 dur 5
    db $32, $0A ; note D3 dur 10
    db $35, $0F ; note F3 dur 15
    db $35, $0A ; note F3 dur 10
    db $C1, $20 ; env $20
    db $A0, $0C ; volume $0C
    db $35, $05 ; note F3 dur 5
    db $C1, $50 ; env $50
    db $35, $0A ; note F3 dur 10
    db $C1, $30 ; env $30
    db $35, $05 ; note F3 dur 5
    db $A0, $08 ; volume $08
    db $35, $05 ; note F3 dur 5
    db $A0, $0E ; volume $0E
    db $C1, $50 ; env $50
    db $24, $05 ; note E2 dur 5
    db $A0, $0A ; volume $0A
    db $23, $05 ; note D#2 dur 5
    db $24, $05 ; note E2 dur 5
    db $A0, $0C ; volume $0C
    db $23, $05 ; note D#2 dur 5
    db $24, $05 ; note E2 dur 5
    db $A0, $0E ; volume $0E
    db $23, $05 ; note D#2 dur 5
    db $24, $05 ; note E2 dur 5
    db $A0, $08 ; volume $08
    db $24, $0A ; note E2 dur 10
    db $A0, $0C ; volume $0C
    db $25, $0A ; note F2 dur 10
    db $C1, $20 ; env $20
    db $25, $05 ; note F2 dur 5
    db $C1, $50 ; env $50
    db $25, $0A ; note F2 dur 10
    db $C1, $30 ; env $30
    db $25, $05 ; note F2 dur 5
    db $A0, $08 ; volume $08
    db $25, $0A ; note F2 dur 10
    db $1F, $1E ; rest-note $1F dur 30
    db $B0, $F3 ; jump $F3
    db $FF, $FF ; end

; sound track, 260 events after the header (E-0019: grammar C2, meaning C0)
Data_040_5243:: ; heuristic: track stream of a sound record; C0
    db $08, $40, $02, $0B ; header: param=8 byte1=$40 volume=$02 byte3=$0B
    db $FD, $F3 ; label 3
    db $34, $05 ; note E3 dur 5
    db $A2, $12 ; duty2 $12
    db $20, $05 ; note C2 dur 5
    db $20, $05 ; note C2 dur 5
    db $A2, $40 ; duty2 $40
    db $34, $05 ; note E3 dur 5
    db $A2, $18 ; duty2 $18
    db $20, $0A ; note C2 dur 10
    db $A2, $20 ; duty2 $20
    db $2A, $0A ; note A#2 dur 10
    db $1F, $28 ; rest-note $1F dur 40
    db $A2, $18 ; duty2 $18
    db $15, $05 ; note F1 dur 5
    db $15, $05 ; note F1 dur 5
    db $A0, $04 ; volume $04
    db $A2, $40 ; duty2 $40
    db $15, $0A ; note F1 dur 10
    db $A2, $40 ; duty2 $40
    db $1F, $0A ; rest-note $1F dur 10
    db $A0, $02 ; volume $02
    db $25, $0A ; note F2 dur 10
    db $A0, $04 ; volume $04
    db $25, $0A ; note F2 dur 10
    db $A0, $02 ; volume $02
    db $20, $0A ; note C2 dur 10
    db $18, $05 ; note G#1 dur 5
    db $19, $05 ; note A1 dur 5
    db $15, $0A ; note F1 dur 10
    db $A2, $18 ; duty2 $18
    db $15, $05 ; note F1 dur 5
    db $15, $05 ; note F1 dur 5
    db $A0, $04 ; volume $04
    db $15, $0A ; note F1 dur 10
    db $1F, $0A ; rest-note $1F dur 10
    db $A2, $40 ; duty2 $40
    db $A0, $02 ; volume $02
    db $20, $0A ; note C2 dur 10
    db $A0, $04 ; volume $04
    db $20, $0A ; note C2 dur 10
    db $A0, $02 ; volume $02
    db $25, $0A ; note F2 dur 10
    db $20, $0A ; note C2 dur 10
    db $15, $0A ; note F1 dur 10
    db $A2, $18 ; duty2 $18
    db $1A, $05 ; note A#1 dur 5
    db $1A, $05 ; note A#1 dur 5
    db $A0, $04 ; volume $04
    db $1A, $0A ; note A#1 dur 10
    db $1F, $0A ; rest-note $1F dur 10
    db $A2, $40 ; duty2 $40
    db $A0, $02 ; volume $02
    db $20, $0A ; note C2 dur 10
    db $A0, $04 ; volume $04
    db $20, $0A ; note C2 dur 10
    db $A0, $02 ; volume $02
    db $22, $0A ; note D2 dur 10
    db $A0, $04 ; volume $04
    db $22, $0A ; note D2 dur 10
    db $A0, $02 ; volume $02
    db $2A, $0A ; note A#2 dur 10
    db $A2, $20 ; duty2 $20
    db $FD, $F0 ; label 0
    db $20, $0A ; note C2 dur 10
    db $B7, $F0 ; repeat $F0
    db $A2, $18 ; duty2 $18
    db $19, $05 ; note A1 dur 5
    db $19, $05 ; note A1 dur 5
    db $A0, $04 ; volume $04
    db $19, $0A ; note A1 dur 10
    db $1F, $0A ; rest-note $1F dur 10
    db $A0, $02 ; volume $02
    db $A2, $40 ; duty2 $40
    db $24, $0A ; note E2 dur 10
    db $29, $05 ; note A2 dur 5
    db $27, $05 ; note G2 dur 5
    db $A0, $04 ; volume $04
    db $27, $05 ; note G2 dur 5
    db $A0, $02 ; volume $02
    db $24, $05 ; note E2 dur 5
    db $A0, $04 ; volume $04
    db $24, $05 ; note E2 dur 5
    db $A0, $02 ; volume $02
    db $24, $05 ; note E2 dur 5
    db $19, $0A ; note A1 dur 10
    db $A0, $04 ; volume $04
    db $19, $0A ; note A1 dur 10
    db $A0, $02 ; volume $02
    db $12, $0F ; note D1 dur 15
    db $A0, $04 ; volume $04
    db $12, $05 ; note D1 dur 5
    db $A0, $02 ; volume $02
    db $14, $0F ; note E1 dur 15
    db $A0, $04 ; volume $04
    db $14, $05 ; note E1 dur 5
    db $A0, $02 ; volume $02
    db $15, $0F ; note F1 dur 15
    db $A0, $04 ; volume $04
    db $15, $05 ; note F1 dur 5
    db $A0, $02 ; volume $02
    db $12, $0A ; note D1 dur 10
    db $17, $0A ; note G1 dur 10
    db $17, $0A ; note G1 dur 10
    db $A0, $04 ; volume $04
    db $17, $0A ; note G1 dur 10
    db $A0, $02 ; volume $02
    db $27, $0F ; note G2 dur 15
    db $A0, $04 ; volume $04
    db $27, $05 ; note G2 dur 5
    db $A0, $02 ; volume $02
    db $25, $0F ; note F2 dur 15
    db $A0, $04 ; volume $04
    db $25, $05 ; note F2 dur 5
    db $A0, $02 ; volume $02
    db $17, $0A ; note G1 dur 10
    db $20, $0A ; note C2 dur 10
    db $A2, $12 ; duty2 $12
    db $2A, $0A ; note A#2 dur 10
    db $A2, $40 ; duty2 $40
    db $30, $0A ; note C3 dur 10
    db $A2, $12 ; duty2 $12
    db $20, $0A ; note C2 dur 10
    db $A2, $18 ; duty2 $18
    db $2A, $05 ; note A#2 dur 5
    db $2A, $05 ; note A#2 dur 5
    db $A2, $02 ; duty2 $02
    db $20, $05 ; note C2 dur 5
    db $A2, $40 ; duty2 $40
    db $30, $0A ; note C3 dur 10
    db $A2, $12 ; duty2 $12
    db $30, $05 ; note C3 dur 5
    db $A2, $40 ; duty2 $40
    db $20, $0A ; note C2 dur 10
    db $A2, $48 ; duty2 $48
    db $A0, $02 ; volume $02
    db $A1, $0B ; duty $0B
    db $A1, $0A ; duty $0A
    db $15, $0A ; note F1 dur 10
    db $A1, $0B ; duty $0B
    db $35, $0A ; note F3 dur 10
    db $34, $0A ; note E3 dur 10
    db $33, $0A ; note D#3 dur 10
    db $32, $05 ; note D3 dur 5
    db $30, $05 ; note C3 dur 5
    db $A0, $04 ; volume $04
    db $30, $05 ; note C3 dur 5
    db $A0, $02 ; volume $02
    db $2B, $05 ; note B2 dur 5
    db $A0, $04 ; volume $04
    db $2B, $05 ; note B2 dur 5
    db $A0, $02 ; volume $02
    db $A2, $10 ; duty2 $10
    db $2B, $05 ; note B2 dur 5
    db $A2, $48 ; duty2 $48
    db $A1, $0A ; duty $0A
    db $17, $0A ; note G1 dur 10
    db $1A, $0A ; note A#1 dur 10
    db $A1, $0B ; duty $0B
    db $32, $0A ; note D3 dur 10
    db $31, $0A ; note C#3 dur 10
    db $30, $0A ; note C3 dur 10
    db $A2, $20 ; duty2 $20
    db $2B, $05 ; note B2 dur 5
    db $A2, $48 ; duty2 $48
    db $2B, $05 ; note B2 dur 5
    db $A0, $04 ; volume $04
    db $2B, $05 ; note B2 dur 5
    db $A0, $02 ; volume $02
    db $25, $0A ; note F2 dur 10
    db $A2, $10 ; duty2 $10
    db $A1, $0A ; duty $0A
    db $22, $05 ; note D2 dur 5
    db $A2, $48 ; duty2 $48
    db $17, $0A ; note G1 dur 10
    db $1A, $0A ; note A#1 dur 10
    db $A1, $0B ; duty $0B
    db $35, $05 ; note F3 dur 5
    db $34, $05 ; note E3 dur 5
    db $35, $05 ; note F3 dur 5
    db $2A, $0A ; note A#2 dur 10
    db $29, $05 ; note A2 dur 5
    db $A1, $0A ; duty $0A
    db $19, $0A ; note A1 dur 10
    db $A2, $10 ; duty2 $10
    db $A1, $0B ; duty $0B
    db $29, $0A ; note A2 dur 10
    db $A2, $40 ; duty2 $40
    db $27, $05 ; note G2 dur 5
    db $24, $05 ; note E2 dur 5
    db $19, $0A ; note A1 dur 10
    db $A1, $0A ; duty $0A
    db $12, $0A ; note D1 dur 10
    db $A1, $0B ; duty $0B
    db $29, $05 ; note A2 dur 5
    db $28, $05 ; note G#2 dur 5
    db $29, $05 ; note A2 dur 5
    db $22, $0A ; note D2 dur 10
    db $20, $05 ; note C2 dur 5
    db $A2, $70 ; duty2 $70
    db $1B, $0A ; note B1 dur 10
    db $29, $0A ; note A2 dur 10
    db $A2, $40 ; duty2 $40
    db $32, $05 ; note D3 dur 5
    db $29, $05 ; note A2 dur 5
    db $A1, $0A ; duty $0A
    db $1B, $0A ; note B1 dur 10
    db $1A, $0A ; note A#1 dur 10
    db $A1, $0B ; duty $0B
    db $A2, $70 ; duty2 $70
    db $2A, $0A ; note A#2 dur 10
    db $A0, $04 ; volume $04
    db $2A, $0A ; note A#2 dur 10
    db $A2, $40 ; duty2 $40
    db $A0, $02 ; volume $02
    db $2A, $0A ; note A#2 dur 10
    db $30, $0A ; note C3 dur 10
    db $A1, $0A ; duty $0A
    db $20, $0A ; note C2 dur 10
    db $A2, $15 ; duty2 $15
    db $20, $05 ; note C2 dur 5
    db $A2, $48 ; duty2 $48
    db $20, $0A ; note C2 dur 10
    db $15, $0A ; note F1 dur 10
    db $A0, $04 ; volume $04
    db $15, $05 ; note F1 dur 5
    db $A0, $02 ; volume $02
    db $A1, $0B ; duty $0B
    db $32, $0A ; note D3 dur 10
    db $A2, $15 ; duty2 $15
    db $31, $05 ; note C#3 dur 5
    db $A2, $30 ; duty2 $30
    db $31, $0A ; note C#3 dur 10
    db $30, $05 ; note C3 dur 5
    db $A0, $04 ; volume $04
    db $30, $05 ; note C3 dur 5
    db $A0, $02 ; volume $02
    db $20, $05 ; note C2 dur 5
    db $FD, $F0 ; label 0
    db $1B, $05 ; note B1 dur 5
    db $20, $05 ; note C2 dur 5
    db $B2, $F0 ; repeat $F0
    db $A1, $0A ; duty $0A
    db $15, $0A ; note F1 dur 10
    db $A1, $0B ; duty $0B
    db $2A, $0A ; note A#2 dur 10
    db $A2, $15 ; duty2 $15
    db $2A, $05 ; note A#2 dur 5
    db $A2, $30 ; duty2 $30
    db $2A, $0A ; note A#2 dur 10
    db $29, $05 ; note A2 dur 5
    db $A0, $04 ; volume $04
    db $29, $0A ; note A2 dur 10
    db $A0, $02 ; volume $02
    db $20, $0A ; note C2 dur 10
    db $A0, $04 ; volume $04
    db $20, $0A ; note C2 dur 10
    db $A0, $02 ; volume $02
    db $20, $0A ; note C2 dur 10
    db $B0, $F3 ; jump $F3
    db $FF, $FF ; end

; sound track, 319 events after the header (E-0019: grammar C2, meaning C0)
Data_040_544F:: ; heuristic: track stream of a sound record; C0
    db $01, $01, $09, $00 ; header: param=1 byte1=$01 volume=$09 byte3=$00
    db $FD, $F3 ; label 3
    db $A2, $01 ; duty2 $01
    db $A3, $02 ; mod $02
    db $C4, $0F ; env $0F
    db $A0, $07 ; volume $07
    db $29, $06 ; note A2 dur 6
    db $30, $06 ; note C3 dur 6
    db $A0, $09 ; volume $09
    db $33, $06 ; note D#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3B, $06 ; note B3 dur 6
    db $37, $06 ; note G3 dur 6
    db $A0, $07 ; volume $07
    db $33, $06 ; note D#3 dur 6
    db $30, $06 ; note C3 dur 6
    db $26, $06 ; note F#2 dur 6
    db $29, $06 ; note A2 dur 6
    db $A0, $09 ; volume $09
    db $30, $06 ; note C3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $A0, $07 ; volume $07
    db $30, $06 ; note C3 dur 6
    db $29, $06 ; note A2 dur 6
    db $23, $06 ; note D#2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $A0, $09 ; volume $09
    db $29, $06 ; note A2 dur 6
    db $30, $06 ; note C3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $30, $06 ; note C3 dur 6
    db $A0, $07 ; volume $07
    db $29, $06 ; note A2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $20, $06 ; note C2 dur 6
    db $23, $06 ; note D#2 dur 6
    db $A0, $09 ; volume $09
    db $26, $06 ; note F#2 dur 6
    db $29, $06 ; note A2 dur 6
    db $30, $06 ; note C3 dur 6
    db $29, $06 ; note A2 dur 6
    db $A0, $07 ; volume $07
    db $26, $06 ; note F#2 dur 6
    db $23, $06 ; note D#2 dur 6
    db $A0, $0A ; volume $0A
    db $C4, $15 ; env $15
    db $17, $0C ; note G1 dur 12
    db $C2, $10 ; env $10
    db $A0, $07 ; volume $07
    db $26, $0C ; note F#2 dur 12
    db $25, $0C ; note F2 dur 12
    db $24, $0C ; note E2 dur 12
    db $A0, $09 ; volume $09
    db $23, $0C ; note D#2 dur 12
    db $22, $0C ; note D2 dur 12
    db $21, $0C ; note C#2 dur 12
    db $20, $0C ; note C2 dur 12
    db $A0, $0B ; volume $0B
    db $1B, $0C ; note B1 dur 12
    db $A0, $08 ; volume $08
    db $1A, $0C ; note A#1 dur 12
    db $19, $0C ; note A1 dur 12
    db $18, $0C ; note G#1 dur 12
    db $17, $0C ; note G1 dur 12
    db $1F, $24 ; rest-note $1F dur 36
    db $FD, $F0 ; label 0
    db $A0, $0A ; volume $0A
    db $1F, $0C ; rest-note $1F dur 12
    db $27, $0C ; note G2 dur 12
    db $27, $0C ; note G2 dur 12
    db $A0, $05 ; volume $05
    db $27, $0C ; note G2 dur 12
    db $B1, $F0 ; repeat $F0
    db $A0, $0A ; volume $0A
    db $FD, $F0 ; label 0
    db $A0, $04 ; volume $04
    db $27, $0C ; note G2 dur 12
    db $A0, $0A ; volume $0A
    db $27, $0C ; note G2 dur 12
    db $B7, $F0 ; repeat $F0
    db $A0, $04 ; volume $04
    db $27, $0C ; note G2 dur 12
    db $A0, $0B ; volume $0B
    db $26, $0C ; note F#2 dur 12
    db $26, $0C ; note F#2 dur 12
    db $26, $0C ; note F#2 dur 12
    db $25, $0C ; note F2 dur 12
    db $24, $0C ; note E2 dur 12
    db $23, $0C ; note D#2 dur 12
    db $22, $0C ; note D2 dur 12
    db $FD, $F0 ; label 0
    db $A0, $0A ; volume $0A
    db $1F, $0C ; rest-note $1F dur 12
    db $23, $0C ; note D#2 dur 12
    db $23, $0C ; note D#2 dur 12
    db $A0, $04 ; volume $04
    db $23, $0C ; note D#2 dur 12
    db $B1, $F0 ; repeat $F0
    db $A0, $0A ; volume $0A
    db $FD, $F0 ; label 0
    db $A0, $04 ; volume $04
    db $23, $0C ; note D#2 dur 12
    db $A0, $0A ; volume $0A
    db $23, $0C ; note D#2 dur 12
    db $B7, $F0 ; repeat $F0
    db $A0, $04 ; volume $04
    db $23, $0C ; note D#2 dur 12
    db $A0, $0A ; volume $0A
    db $22, $0C ; note D2 dur 12
    db $22, $0C ; note D2 dur 12
    db $22, $0C ; note D2 dur 12
    db $21, $0C ; note C#2 dur 12
    db $20, $0C ; note C2 dur 12
    db $1B, $0C ; note B1 dur 12
    db $1A, $0C ; note A#1 dur 12
    db $A2, $01 ; duty2 $01
    db $A0, $09 ; volume $09
    db $A3, $02 ; mod $02
    db $C4, $12 ; env $12
    db $FD, $F1 ; label 1
    db $1A, $06 ; note A#1 dur 6
    db $25, $06 ; note F2 dur 6
    db $FD, $F0 ; label 0
    db $21, $06 ; note C#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $B2, $F0 ; repeat $F0
    db $B1, $F1 ; repeat $F1
    db $FD, $F1 ; label 1
    db $19, $06 ; note A1 dur 6
    db $24, $06 ; note E2 dur 6
    db $FD, $F0 ; label 0
    db $20, $06 ; note C2 dur 6
    db $24, $06 ; note E2 dur 6
    db $B2, $F0 ; repeat $F0
    db $B1, $F1 ; repeat $F1
    db $FD, $F1 ; label 1
    db $22, $06 ; note D2 dur 6
    db $29, $06 ; note A2 dur 6
    db $FD, $F0 ; label 0
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $B2, $F0 ; repeat $F0
    db $B1, $F1 ; repeat $F1
    db $FD, $F0 ; label 0
    db $1B, $06 ; note B1 dur 6
    db $27, $06 ; note G2 dur 6
    db $22, $06 ; note D2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $27, $06 ; note G2 dur 6
    db $22, $06 ; note D2 dur 6
    db $27, $06 ; note G2 dur 6
    db $B1, $F0 ; repeat $F0
    db $FD, $F1 ; label 1
    db $22, $06 ; note D2 dur 6
    db $29, $06 ; note A2 dur 6
    db $FD, $F0 ; label 0
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $B2, $F0 ; repeat $F0
    db $B1, $F1 ; repeat $F1
    db $FD, $F1 ; label 1
    db $21, $06 ; note C#2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $FD, $F0 ; label 0
    db $24, $06 ; note E2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $B2, $F0 ; repeat $F0
    db $B1, $F1 ; repeat $F1
    db $FD, $F1 ; label 1
    db $26, $06 ; note F#2 dur 6
    db $31, $06 ; note C#3 dur 6
    db $FD, $F0 ; label 0
    db $29, $06 ; note A2 dur 6
    db $31, $06 ; note C#3 dur 6
    db $B2, $F0 ; repeat $F0
    db $B1, $F1 ; repeat $F1
    db $FD, $F0 ; label 0
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $B3, $F0 ; repeat $F0
    db $29, $06 ; note A2 dur 6
    db $19, $06 ; note A1 dur 6
    db $21, $06 ; note C#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $FD, $F0 ; label 0
    db $19, $06 ; note A1 dur 6
    db $21, $06 ; note C#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $B1, $F0 ; repeat $F0
    db $29, $06 ; note A2 dur 6
    db $19, $06 ; note A1 dur 6
    db $21, $06 ; note C#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $FD, $F0 ; label 0
    db $20, $06 ; note C2 dur 6
    db $24, $06 ; note E2 dur 6
    db $27, $06 ; note G2 dur 6
    db $24, $06 ; note E2 dur 6
    db $B3, $F0 ; repeat $F0
    db $A0, $0B ; volume $0B
    db $A3, $FE ; mod $FE
    db $A2, $02 ; duty2 $02
    db $1F, $0C ; rest-note $1F dur 12
    db $C1, $70 ; env $70
    db $33, $0C ; note D#3 dur 12
    db $43, $0C ; note D#4 dur 12
    db $C2, $15 ; env $15
    db $A2, $00 ; duty2 $00
    db $30, $0C ; note C3 dur 12
    db $A0, $0D ; volume $0D
    db $C1, $70 ; env $70
    db $25, $0C ; note F2 dur 12
    db $A0, $0B ; volume $0B
    db $A2, $02 ; duty2 $02
    db $35, $0C ; note F3 dur 12
    db $45, $0C ; note F4 dur 12
    db $C2, $15 ; env $15
    db $A2, $00 ; duty2 $00
    db $35, $0C ; note F3 dur 12
    db $A0, $0D ; volume $0D
    db $C1, $70 ; env $70
    db $2A, $0C ; note A#2 dur 12
    db $A0, $0B ; volume $0B
    db $A2, $02 ; duty2 $02
    db $31, $0C ; note C#3 dur 12
    db $41, $0C ; note C#4 dur 12
    db $C2, $15 ; env $15
    db $A2, $00 ; duty2 $00
    db $33, $0C ; note D#3 dur 12
    db $C1, $70 ; env $70
    db $A0, $0D ; volume $0D
    db $26, $0C ; note F#2 dur 12
    db $A0, $0A ; volume $0A
    db $A2, $02 ; duty2 $02
    db $30, $0C ; note C3 dur 12
    db $A0, $0B ; volume $0B
    db $40, $0C ; note C4 dur 12
    db $C2, $15 ; env $15
    db $A2, $00 ; duty2 $00
    db $2A, $0C ; note A#2 dur 12
    db $A2, $00 ; duty2 $00
    db $C1, $50 ; env $50
    db $A0, $09 ; volume $09
    db $28, $0C ; note G#2 dur 12
    db $C2, $15 ; env $15
    db $30, $0C ; note C3 dur 12
    db $C1, $50 ; env $50
    db $A0, $09 ; volume $09
    db $25, $0C ; note F2 dur 12
    db $C2, $15 ; env $15
    db $2A, $0C ; note A#2 dur 12
    db $C1, $50 ; env $50
    db $A0, $09 ; volume $09
    db $27, $0C ; note G2 dur 12
    db $C2, $15 ; env $15
    db $2A, $0C ; note A#2 dur 12
    db $C1, $50 ; env $50
    db $A0, $0A ; volume $0A
    db $23, $0C ; note D#2 dur 12
    db $C2, $15 ; env $15
    db $28, $0C ; note G#2 dur 12
    db $C1, $50 ; env $50
    db $A0, $0A ; volume $0A
    db $25, $0C ; note F2 dur 12
    db $C2, $15 ; env $15
    db $28, $0C ; note G#2 dur 12
    db $C1, $50 ; env $50
    db $A0, $0B ; volume $0B
    db $25, $0C ; note F2 dur 12
    db $C2, $15 ; env $15
    db $31, $0C ; note C#3 dur 12
    db $C1, $50 ; env $50
    db $A0, $0B ; volume $0B
    db $23, $0C ; note D#2 dur 12
    db $C2, $15 ; env $15
    db $27, $0C ; note G2 dur 12
    db $C1, $50 ; env $50
    db $A0, $0B ; volume $0B
    db $23, $0C ; note D#2 dur 12
    db $C2, $15 ; env $15
    db $30, $0C ; note C3 dur 12
    db $C1, $30 ; env $30
    db $1B, $0C ; note B1 dur 12
    db $32, $0C ; note D3 dur 12
    db $32, $0C ; note D3 dur 12
    db $29, $0C ; note A2 dur 12
    db $22, $0C ; note D2 dur 12
    db $32, $0C ; note D3 dur 12
    db $32, $0C ; note D3 dur 12
    db $29, $0C ; note A2 dur 12
    db $1A, $0C ; note A#1 dur 12
    db $28, $0C ; note G#2 dur 12
    db $28, $0C ; note G#2 dur 12
    db $38, $0C ; note G#3 dur 12
    db $38, $0C ; note G#3 dur 12
    db $28, $0C ; note G#2 dur 12
    db $28, $0C ; note G#2 dur 12
    db $22, $0C ; note D2 dur 12
    db $1F, $60 ; rest-note $1F dur 96
    db $A0, $0B ; volume $0B
    db $A1, $00 ; duty $00
    db $A0, $0B ; volume $0B
    db $C0, $FE ; env $FE
    db $23, $30 ; note D#2 dur 48
    db $A0, $04 ; volume $04
    db $C1, $50 ; env $50
    db $23, $18 ; note D#2 dur 24
    db $A0, $0B ; volume $0B
    db $25, $06 ; note F2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $27, $06 ; note G2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $B0, $F3 ; jump $F3
    db $FF, $FF ; end

; sound track, 379 events after the header (E-0019: grammar C2, meaning C0)
Data_040_56D1:: ; heuristic: track stream of a sound record; C0
    db $01, $01, $0C, $00 ; header: param=1 byte1=$01 volume=$0C byte3=$00
    db $FD, $F3 ; label 3
    db $A2, $01 ; duty2 $01
    db $A3, $02 ; mod $02
    db $C4, $10 ; env $10
    db $A0, $08 ; volume $08
    db $30, $06 ; note C3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $A0, $0A ; volume $0A
    db $37, $06 ; note G3 dur 6
    db $3B, $06 ; note B3 dur 6
    db $42, $06 ; note D4 dur 6
    db $3B, $06 ; note B3 dur 6
    db $A0, $08 ; volume $08
    db $37, $06 ; note G3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $29, $06 ; note A2 dur 6
    db $30, $06 ; note C3 dur 6
    db $A0, $0A ; volume $0A
    db $33, $06 ; note D#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3B, $06 ; note B3 dur 6
    db $37, $06 ; note G3 dur 6
    db $A0, $08 ; volume $08
    db $33, $06 ; note D#3 dur 6
    db $30, $06 ; note C3 dur 6
    db $26, $06 ; note F#2 dur 6
    db $29, $06 ; note A2 dur 6
    db $A0, $0A ; volume $0A
    db $30, $06 ; note C3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $A0, $08 ; volume $08
    db $30, $06 ; note C3 dur 6
    db $29, $06 ; note A2 dur 6
    db $24, $06 ; note E2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $A0, $0A ; volume $0A
    db $29, $06 ; note A2 dur 6
    db $30, $06 ; note C3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $30, $06 ; note C3 dur 6
    db $A0, $08 ; volume $08
    db $29, $06 ; note A2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $A0, $0C ; volume $0C
    db $C4, $15 ; env $15
    db $27, $0C ; note G2 dur 12
    db $A0, $09 ; volume $09
    db $C2, $15 ; env $15
    db $FD, $F0 ; label 0
    db $27, $0C ; note G2 dur 12
    db $B2, $F0 ; repeat $F0
    db $A0, $0A ; volume $0A
    db $FD, $F0 ; label 0
    db $27, $0C ; note G2 dur 12
    db $B3, $F0 ; repeat $F0
    db $A0, $0C ; volume $0C
    db $27, $0C ; note G2 dur 12
    db $A0, $0B ; volume $0B
    db $FD, $F0 ; label 0
    db $27, $0C ; note G2 dur 12
    db $B2, $F0 ; repeat $F0
    db $A0, $0C ; volume $0C
    db $27, $0C ; note G2 dur 12
    db $1F, $18 ; rest-note $1F dur 24
    db $A0, $0B ; volume $0B
    db $C1, $70 ; env $70
    db $A2, $00 ; duty2 $00
    db $A3, $FE ; mod $FE
    db $29, $06 ; note A2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $C1, $20 ; env $20
    db $30, $12 ; note C3 dur 18
    db $A0, $03 ; volume $03
    db $C1, $70 ; env $70
    db $30, $12 ; note C3 dur 18
    db $A0, $0B ; volume $0B
    db $C0, $FE ; env $FE
    db $30, $06 ; note C3 dur 6
    db $32, $06 ; note D3 dur 6
    db $C1, $20 ; env $20
    db $33, $12 ; note D#3 dur 18
    db $A0, $02 ; volume $02
    db $C1, $70 ; env $70
    db $33, $12 ; note D#3 dur 18
    db $A0, $0B ; volume $0B
    db $C1, $70 ; env $70
    db $33, $06 ; note D#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $C1, $20 ; env $20
    db $36, $09 ; note F#3 dur 9
    db $A0, $04 ; volume $04
    db $36, $06 ; note F#3 dur 6
    db $A0, $0B ; volume $0B
    db $36, $05 ; note F#3 dur 5
    db $38, $04 ; note G#3 dur 4
    db $39, $09 ; note A3 dur 9
    db $A0, $04 ; volume $04
    db $39, $06 ; note A3 dur 6
    db $A0, $0B ; volume $0B
    db $39, $05 ; note A3 dur 5
    db $3B, $04 ; note B3 dur 4
    db $40, $09 ; note C4 dur 9
    db $A0, $04 ; volume $04
    db $40, $06 ; note C4 dur 6
    db $A0, $0B ; volume $0B
    db $40, $05 ; note C4 dur 5
    db $42, $04 ; note D4 dur 4
    db $43, $09 ; note D#4 dur 9
    db $A0, $04 ; volume $04
    db $43, $06 ; note D#4 dur 6
    db $A0, $0B ; volume $0B
    db $43, $05 ; note D#4 dur 5
    db $45, $04 ; note F4 dur 4
    db $C0, $FE ; env $FE
    db $46, $30 ; note F#4 dur 48
    db $C1, $70 ; env $70
    db $46, $18 ; note F#4 dur 24
    db $47, $06 ; note G4 dur 6
    db $43, $06 ; note D#4 dur 6
    db $40, $06 ; note C4 dur 6
    db $39, $06 ; note A3 dur 6
    db $C0, $FE ; env $FE
    db $36, $18 ; note F#3 dur 24
    db $A0, $06 ; volume $06
    db $C1, $60 ; env $60
    db $36, $30 ; note F#3 dur 48
    db $1F, $0C ; rest-note $1F dur 12
    db $C1, $70 ; env $70
    db $A0, $0B ; volume $0B
    db $25, $06 ; note F2 dur 6
    db $27, $06 ; note G2 dur 6
    db $C1, $20 ; env $20
    db $28, $12 ; note G#2 dur 18
    db $A0, $03 ; volume $03
    db $C1, $70 ; env $70
    db $28, $12 ; note G#2 dur 18
    db $A0, $0B ; volume $0B
    db $C1, $70 ; env $70
    db $28, $06 ; note G#2 dur 6
    db $2A, $06 ; note A#2 dur 6
    db $C1, $20 ; env $20
    db $2B, $12 ; note B2 dur 18
    db $A0, $03 ; volume $03
    db $C1, $70 ; env $70
    db $2B, $12 ; note B2 dur 18
    db $A0, $0B ; volume $0B
    db $2B, $06 ; note B2 dur 6
    db $31, $06 ; note C#3 dur 6
    db $C1, $20 ; env $20
    db $32, $09 ; note D3 dur 9
    db $A0, $04 ; volume $04
    db $32, $06 ; note D3 dur 6
    db $A0, $0B ; volume $0B
    db $32, $05 ; note D3 dur 5
    db $34, $04 ; note E3 dur 4
    db $35, $09 ; note F3 dur 9
    db $A0, $04 ; volume $04
    db $35, $06 ; note F3 dur 6
    db $A0, $0B ; volume $0B
    db $35, $05 ; note F3 dur 5
    db $37, $04 ; note G3 dur 4
    db $38, $09 ; note G#3 dur 9
    db $A0, $04 ; volume $04
    db $38, $06 ; note G#3 dur 6
    db $A0, $0B ; volume $0B
    db $38, $05 ; note G#3 dur 5
    db $3A, $04 ; note A#3 dur 4
    db $3B, $09 ; note B3 dur 9
    db $A0, $04 ; volume $04
    db $3B, $06 ; note B3 dur 6
    db $A0, $0B ; volume $0B
    db $3B, $05 ; note B3 dur 5
    db $41, $04 ; note C#4 dur 4
    db $C0, $FE ; env $FE
    db $42, $30 ; note D4 dur 48
    db $C1, $70 ; env $70
    db $42, $18 ; note D4 dur 24
    db $43, $06 ; note D#4 dur 6
    db $3B, $06 ; note B3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $C1, $7F ; env $7F
    db $32, $30 ; note D3 dur 48
    db $A0, $06 ; volume $06
    db $32, $30 ; note D3 dur 48
    db $A2, $02 ; duty2 $02
    db $A0, $0B ; volume $0B
    db $C0, $FE ; env $FE
    db $1F, $18 ; rest-note $1F dur 24
    db $34, $24 ; note E3 dur 36
    db $A0, $06 ; volume $06
    db $C1, $50 ; env $50
    db $34, $0C ; note E3 dur 12
    db $A0, $0B ; volume $0B
    db $35, $18 ; note F3 dur 24
    db $C1, $7F ; env $7F
    db $2B, $24 ; note B2 dur 36
    db $30, $0C ; note C3 dur 12
    db $33, $24 ; note D#3 dur 36
    db $34, $0C ; note E3 dur 12
    db $38, $24 ; note G#3 dur 36
    db $39, $0C ; note A3 dur 12
    db $3B, $24 ; note B3 dur 36
    db $40, $0C ; note C4 dur 12
    db $C0, $FE ; env $FE
    db $A0, $09 ; volume $09
    db $36, $30 ; note F#3 dur 48
    db $A0, $06 ; volume $06
    db $C1, $70 ; env $70
    db $36, $18 ; note F#3 dur 24
    db $A0, $09 ; volume $09
    db $37, $18 ; note G3 dur 24
    db $A0, $03 ; volume $03
    db $C1, $20 ; env $20
    db $37, $18 ; note G3 dur 24
    db $C1, $7F ; env $7F
    db $A0, $0B ; volume $0B
    db $38, $24 ; note G#3 dur 36
    db $C1, $50 ; env $50
    db $A0, $06 ; volume $06
    db $38, $0C ; note G#3 dur 12
    db $A0, $0B ; volume $0B
    db $39, $18 ; note A3 dur 24
    db $C1, $7F ; env $7F
    db $33, $24 ; note D#3 dur 36
    db $34, $0C ; note E3 dur 12
    db $37, $24 ; note G3 dur 36
    db $38, $0C ; note G#3 dur 12
    db $40, $24 ; note C4 dur 36
    db $41, $0C ; note C#4 dur 12
    db $43, $24 ; note D#4 dur 36
    db $44, $0C ; note E4 dur 12
    db $45, $24 ; note F4 dur 36
    db $46, $0C ; note F#4 dur 12
    db $47, $24 ; note G4 dur 36
    db $48, $0C ; note G#4 dur 12
    db $A3, $08 ; mod $08
    db $C1, $3F ; env $3F
    db $A2, $00 ; duty2 $00
    db $39, $0C ; note A3 dur 12
    db $C2, $20 ; env $20
    db $34, $0C ; note E3 dur 12
    db $31, $0C ; note C#3 dur 12
    db $C1, $7F ; env $7F
    db $29, $18 ; note A2 dur 24
    db $C1, $3F ; env $3F
    db $31, $0C ; note C#3 dur 12
    db $C2, $20 ; env $20
    db $34, $0C ; note E3 dur 12
    db $39, $0C ; note A3 dur 12
    db $C1, $3F ; env $3F
    db $37, $0C ; note G3 dur 12
    db $C2, $20 ; env $20
    db $34, $0C ; note E3 dur 12
    db $30, $0C ; note C3 dur 12
    db $C1, $7F ; env $7F
    db $2B, $18 ; note B2 dur 24
    db $C1, $3F ; env $3F
    db $30, $0C ; note C3 dur 12
    db $C2, $20 ; env $20
    db $34, $0C ; note E3 dur 12
    db $37, $0C ; note G3 dur 12
    db $1F, $0C ; rest-note $1F dur 12
    db $A3, $FE ; mod $FE
    db $A0, $0C ; volume $0C
    db $36, $0C ; note F#3 dur 12
    db $C1, $30 ; env $30
    db $46, $0C ; note F#4 dur 12
    db $A0, $05 ; volume $05
    db $C1, $60 ; env $60
    db $46, $18 ; note F#4 dur 24
    db $A0, $0B ; volume $0B
    db $C2, $20 ; env $20
    db $38, $0C ; note G#3 dur 12
    db $C1, $30 ; env $30
    db $48, $0C ; note G#4 dur 12
    db $A0, $05 ; volume $05
    db $C1, $60 ; env $60
    db $48, $18 ; note G#4 dur 24
    db $A0, $0B ; volume $0B
    db $C2, $20 ; env $20
    db $35, $0C ; note F3 dur 12
    db $C1, $30 ; env $30
    db $45, $0C ; note F4 dur 12
    db $C1, $60 ; env $60
    db $A0, $05 ; volume $05
    db $45, $18 ; note F4 dur 24
    db $A0, $0B ; volume $0B
    db $C2, $20 ; env $20
    db $33, $0C ; note D#3 dur 12
    db $C1, $40 ; env $40
    db $43, $18 ; note D#4 dur 24
    db $C1, $50 ; env $50
    db $A0, $0A ; volume $0A
    db $33, $0C ; note D#3 dur 12
    db $C2, $15 ; env $15
    db $A0, $08 ; volume $08
    db $43, $0C ; note D#4 dur 12
    db $C1, $50 ; env $50
    db $A0, $0A ; volume $0A
    db $31, $0C ; note C#3 dur 12
    db $C2, $15 ; env $15
    db $A0, $08 ; volume $08
    db $41, $0C ; note C#4 dur 12
    db $C1, $50 ; env $50
    db $A0, $0A ; volume $0A
    db $31, $0C ; note C#3 dur 12
    db $C2, $15 ; env $15
    db $A0, $09 ; volume $09
    db $41, $0C ; note C#4 dur 12
    db $C1, $50 ; env $50
    db $A0, $0B ; volume $0B
    db $2B, $0C ; note B2 dur 12
    db $C2, $15 ; env $15
    db $A0, $0A ; volume $0A
    db $3B, $0C ; note B3 dur 12
    db $C1, $50 ; env $50
    db $A0, $0C ; volume $0C
    db $2B, $0C ; note B2 dur 12
    db $C2, $15 ; env $15
    db $A0, $0B ; volume $0B
    db $3B, $0C ; note B3 dur 12
    db $C1, $50 ; env $50
    db $A0, $0D ; volume $0D
    db $2A, $0C ; note A#2 dur 12
    db $C2, $15 ; env $15
    db $3A, $0C ; note A#3 dur 12
    db $C1, $50 ; env $50
    db $2A, $0C ; note A#2 dur 12
    db $C2, $15 ; env $15
    db $3A, $0C ; note A#3 dur 12
    db $C1, $50 ; env $50
    db $28, $0C ; note G#2 dur 12
    db $C2, $15 ; env $15
    db $38, $0C ; note G#3 dur 12
    db $A0, $03 ; volume $03
    db $C1, $20 ; env $20
    db $38, $0C ; note G#3 dur 12
    db $C1, $7F ; env $7F
    db $FD, $F0 ; label 0
    db $A0, $0B ; volume $0B
    db $C2, $20 ; env $20
    db $35, $0C ; note F3 dur 12
    db $C1, $40 ; env $40
    db $45, $0C ; note F4 dur 12
    db $A0, $03 ; volume $03
    db $C1, $60 ; env $60
    db $45, $18 ; note F4 dur 24
    db $B1, $F0 ; repeat $F0
    db $A0, $0B ; volume $0B
    db $C1, $2F ; env $2F
    db $34, $0C ; note E3 dur 12
    db $34, $0C ; note E3 dur 12
    db $44, $0C ; note E4 dur 12
    db $44, $0C ; note E4 dur 12
    db $34, $0C ; note E3 dur 12
    db $34, $0C ; note E3 dur 12
    db $24, $0C ; note E2 dur 12
    db $A0, $07 ; volume $07
    db $C0, $FE ; env $FE
    db $19, $48 ; note A1 dur 72
    db $C1, $7F ; env $7F
    db $A0, $06 ; volume $06
    db $19, $18 ; note A1 dur 24
    db $A3, $0F ; mod $0F
    db $C0, $FE ; env $FE
    db $27, $30 ; note G2 dur 48
    db $A0, $06 ; volume $06
    db $C1, $50 ; env $50
    db $27, $18 ; note G2 dur 24
    db $A0, $0C ; volume $0C
    db $28, $06 ; note G#2 dur 6
    db $29, $06 ; note A2 dur 6
    db $2A, $06 ; note A#2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $B0, $F3 ; jump $F3
    db $FF, $FF ; end

; sound track, 343 events after the header (E-0019: grammar C2, meaning C0)
Data_040_59CB:: ; heuristic: track stream of a sound record; C0
    db $01, $FF, $02, $0A ; header: param=1 byte1=$FF volume=$02 byte3=$0A
    db $FD, $F3 ; label 3
    db $A1, $0A ; duty $0A
    db $A0, $02 ; volume $02
    db $A2, $FF ; duty2 $FF
    db $20, $30 ; note C2 dur 48
    db $A0, $04 ; volume $04
    db $20, $18 ; note C2 dur 24
    db $A0, $06 ; volume $06
    db $20, $0C ; note C2 dur 12
    db $A0, $02 ; volume $02
    db $17, $06 ; note G1 dur 6
    db $13, $06 ; note D#1 dur 6
    db $10, $48 ; note C1 dur 72
    db $A0, $04 ; volume $04
    db $10, $18 ; note C1 dur 24
    db $A0, $02 ; volume $02
    db $17, $0C ; note G1 dur 12
    db $A2, $15 ; duty2 $15
    db $A1, $03 ; duty $03
    db $32, $0C ; note D3 dur 12
    db $31, $0C ; note C#3 dur 12
    db $30, $0C ; note C3 dur 12
    db $2B, $0C ; note B2 dur 12
    db $2A, $0C ; note A#2 dur 12
    db $29, $0C ; note A2 dur 12
    db $28, $0C ; note G#2 dur 12
    db $A1, $08 ; duty $08
    db $27, $0C ; note G2 dur 12
    db $26, $0C ; note F#2 dur 12
    db $25, $0C ; note F2 dur 12
    db $24, $0C ; note E2 dur 12
    db $23, $0C ; note D#2 dur 12
    db $27, $0C ; note G2 dur 12
    db $A1, $0A ; duty $0A
    db $17, $0C ; note G1 dur 12
    db $A0, $06 ; volume $06
    db $17, $0C ; note G1 dur 12
    db $A0, $02 ; volume $02
    db $A1, $0A ; duty $0A
    db $20, $0C ; note C2 dur 12
    db $A1, $08 ; duty $08
    db $33, $0C ; note D#3 dur 12
    db $33, $0C ; note D#3 dur 12
    db $A0, $06 ; volume $06
    db $33, $0C ; note D#3 dur 12
    db $A0, $02 ; volume $02
    db $A1, $0A ; duty $0A
    db $19, $0C ; note A1 dur 12
    db $A1, $08 ; duty $08
    db $33, $0C ; note D#3 dur 12
    db $33, $0C ; note D#3 dur 12
    db $A0, $06 ; volume $06
    db $33, $0C ; note D#3 dur 12
    db $A0, $02 ; volume $02
    db $A2, $30 ; duty2 $30
    db $FD, $F0 ; label 0
    db $A1, $0A ; duty $0A
    db $20, $0C ; note C2 dur 12
    db $A1, $08 ; duty $08
    db $33, $0C ; note D#3 dur 12
    db $A1, $0A ; duty $0A
    db $20, $0C ; note C2 dur 12
    db $A1, $08 ; duty $08
    db $33, $0C ; note D#3 dur 12
    db $A1, $0A ; duty $0A
    db $19, $0C ; note A1 dur 12
    db $A1, $08 ; duty $08
    db $33, $0C ; note D#3 dur 12
    db $A1, $0A ; duty $0A
    db $19, $0C ; note A1 dur 12
    db $A1, $08 ; duty $08
    db $30, $0C ; note C3 dur 12
    db $B1, $F0 ; repeat $F0
    db $A1, $0A ; duty $0A
    db $A2, $FF ; duty2 $FF
    db $10, $0C ; note C1 dur 12
    db $A1, $08 ; duty $08
    db $A2, $15 ; duty2 $15
    db $35, $0C ; note F3 dur 12
    db $34, $0C ; note E3 dur 12
    db $33, $0C ; note D#3 dur 12
    db $32, $0C ; note D3 dur 12
    db $31, $0C ; note C#3 dur 12
    db $30, $0C ; note C3 dur 12
    db $2B, $0C ; note B2 dur 12
    db $A0, $02 ; volume $02
    db $A1, $0A ; duty $0A
    db $18, $0C ; note G#1 dur 12
    db $A1, $08 ; duty $08
    db $2B, $0C ; note B2 dur 12
    db $2B, $0C ; note B2 dur 12
    db $A0, $06 ; volume $06
    db $2B, $0C ; note B2 dur 12
    db $A0, $02 ; volume $02
    db $A1, $0A ; duty $0A
    db $15, $0C ; note F1 dur 12
    db $A1, $08 ; duty $08
    db $2B, $0C ; note B2 dur 12
    db $2B, $0C ; note B2 dur 12
    db $A0, $06 ; volume $06
    db $2B, $0C ; note B2 dur 12
    db $A2, $30 ; duty2 $30
    db $A0, $02 ; volume $02
    db $FD, $F0 ; label 0
    db $A1, $0A ; duty $0A
    db $18, $0C ; note G#1 dur 12
    db $A1, $08 ; duty $08
    db $2B, $0C ; note B2 dur 12
    db $A1, $0A ; duty $0A
    db $18, $0C ; note G#1 dur 12
    db $A1, $08 ; duty $08
    db $2B, $0C ; note B2 dur 12
    db $A1, $0A ; duty $0A
    db $15, $0C ; note F1 dur 12
    db $A1, $08 ; duty $08
    db $2B, $0C ; note B2 dur 12
    db $A1, $0A ; duty $0A
    db $15, $0C ; note F1 dur 12
    db $A1, $08 ; duty $08
    db $29, $0C ; note A2 dur 12
    db $B1, $F0 ; repeat $F0
    db $A1, $0A ; duty $0A
    db $A2, $FF ; duty2 $FF
    db $0A, $0C ; note A#0 dur 12
    db $A2, $15 ; duty2 $15
    db $A1, $08 ; duty $08
    db $31, $0C ; note C#3 dur 12
    db $30, $0C ; note C3 dur 12
    db $2B, $0C ; note B2 dur 12
    db $2A, $0C ; note A#2 dur 12
    db $29, $0C ; note A2 dur 12
    db $28, $0C ; note G#2 dur 12
    db $27, $0C ; note G2 dur 12
    db $A1, $0A ; duty $0A
    db $A2, $FF ; duty2 $FF
    db $0A, $0C ; note A#0 dur 12
    db $A1, $0B ; duty $0B
    db $A2, $20 ; duty2 $20
    db $1A, $0C ; note A#1 dur 12
    db $A0, $06 ; volume $06
    db $1A, $0C ; note A#1 dur 12
    db $A0, $02 ; volume $02
    db $25, $0C ; note F2 dur 12
    db $A0, $06 ; volume $06
    db $25, $0C ; note F2 dur 12
    db $A0, $02 ; volume $02
    db $1A, $0C ; note A#1 dur 12
    db $A0, $06 ; volume $06
    db $1A, $0C ; note A#1 dur 12
    db $A1, $0A ; duty $0A
    db $A0, $02 ; volume $02
    db $0A, $0C ; note A#0 dur 12
    db $19, $18 ; note A1 dur 24
    db $19, $18 ; note A1 dur 24
    db $1F, $0C ; rest-note $1F dur 12
    db $A1, $0B ; duty $0B
    db $24, $0C ; note E2 dur 12
    db $20, $0C ; note C2 dur 12
    db $19, $0C ; note A1 dur 12
    db $A1, $0A ; duty $0A
    db $A2, $FF ; duty2 $FF
    db $12, $0C ; note D1 dur 12
    db $A1, $0B ; duty $0B
    db $A2, $20 ; duty2 $20
    db $22, $0C ; note D2 dur 12
    db $A0, $06 ; volume $06
    db $22, $0C ; note D2 dur 12
    db $A0, $02 ; volume $02
    db $29, $0C ; note A2 dur 12
    db $A0, $06 ; volume $06
    db $29, $0C ; note A2 dur 12
    db $A0, $02 ; volume $02
    db $25, $0C ; note F2 dur 12
    db $A0, $06 ; volume $06
    db $25, $0C ; note F2 dur 12
    db $A0, $02 ; volume $02
    db $22, $0C ; note D2 dur 12
    db $A1, $0A ; duty $0A
    db $17, $18 ; note G1 dur 24
    db $17, $18 ; note G1 dur 24
    db $1F, $0C ; rest-note $1F dur 12
    db $A1, $0B ; duty $0B
    db $22, $0C ; note D2 dur 12
    db $1B, $0C ; note B1 dur 12
    db $17, $0C ; note G1 dur 12
    db $A1, $0A ; duty $0A
    db $A2, $FF ; duty2 $FF
    db $12, $0C ; note D1 dur 12
    db $A1, $0B ; duty $0B
    db $A2, $20 ; duty2 $20
    db $22, $0C ; note D2 dur 12
    db $A0, $06 ; volume $06
    db $22, $0C ; note D2 dur 12
    db $A0, $02 ; volume $02
    db $29, $0C ; note A2 dur 12
    db $A0, $06 ; volume $06
    db $29, $0C ; note A2 dur 12
    db $A0, $02 ; volume $02
    db $22, $0C ; note D2 dur 12
    db $A0, $06 ; volume $06
    db $22, $0C ; note D2 dur 12
    db $A0, $02 ; volume $02
    db $12, $0C ; note D1 dur 12
    db $A1, $0A ; duty $0A
    db $21, $18 ; note C#2 dur 24
    db $21, $18 ; note C#2 dur 24
    db $1F, $0C ; rest-note $1F dur 12
    db $A1, $0B ; duty $0B
    db $28, $0C ; note G#2 dur 12
    db $24, $0C ; note E2 dur 12
    db $21, $0C ; note C#2 dur 12
    db $A1, $0A ; duty $0A
    db $A2, $FF ; duty2 $FF
    db $16, $0C ; note F#1 dur 12
    db $A1, $0B ; duty $0B
    db $A2, $20 ; duty2 $20
    db $26, $0C ; note F#2 dur 12
    db $A0, $06 ; volume $06
    db $26, $0C ; note F#2 dur 12
    db $A0, $02 ; volume $02
    db $31, $0C ; note C#3 dur 12
    db $A0, $06 ; volume $06
    db $31, $0C ; note C#3 dur 12
    db $A0, $02 ; volume $02
    db $29, $0C ; note A2 dur 12
    db $A0, $06 ; volume $06
    db $29, $0C ; note A2 dur 12
    db $A0, $02 ; volume $02
    db $26, $0C ; note F#2 dur 12
    db $A1, $0A ; duty $0A
    db $1B, $18 ; note B1 dur 24
    db $1B, $18 ; note B1 dur 24
    db $1F, $0C ; rest-note $1F dur 12
    db $A1, $0B ; duty $0B
    db $26, $0C ; note F#2 dur 12
    db $22, $0C ; note D2 dur 12
    db $1B, $0C ; note B1 dur 12
    db $A2, $30 ; duty2 $30
    db $FD, $F0 ; label 0
    db $A1, $0A ; duty $0A
    db $16, $0C ; note F#1 dur 12
    db $A1, $0B ; duty $0B
    db $26, $0C ; note F#2 dur 12
    db $B3, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $A1, $0A ; duty $0A
    db $19, $0C ; note A1 dur 12
    db $A1, $0B ; duty $0B
    db $29, $0C ; note A2 dur 12
    db $B3, $F0 ; repeat $F0
    db $A1, $0A ; duty $0A
    db $18, $0C ; note G#1 dur 12
    db $A1, $0B ; duty $0B
    db $30, $0C ; note C3 dur 12
    db $A0, $06 ; volume $06
    db $30, $0C ; note C3 dur 12
    db $A0, $02 ; volume $02
    db $A2, $25 ; duty2 $25
    db $38, $0C ; note G#3 dur 12
    db $A1, $0A ; duty $0A
    db $A2, $30 ; duty2 $30
    db $21, $0C ; note C#2 dur 12
    db $A1, $0B ; duty $0B
    db $32, $0C ; note D3 dur 12
    db $A0, $06 ; volume $06
    db $32, $0C ; note D3 dur 12
    db $A0, $02 ; volume $02
    db $A2, $25 ; duty2 $25
    db $38, $0C ; note G#3 dur 12
    db $A2, $30 ; duty2 $30
    db $A1, $0A ; duty $0A
    db $16, $0C ; note F#1 dur 12
    db $A1, $0B ; duty $0B
    db $26, $0C ; note F#2 dur 12
    db $A0, $06 ; volume $06
    db $26, $0C ; note F#2 dur 12
    db $A0, $02 ; volume $02
    db $A2, $25 ; duty2 $25
    db $26, $0C ; note F#2 dur 12
    db $A1, $0A ; duty $0A
    db $A2, $30 ; duty2 $30
    db $20, $0C ; note C2 dur 12
    db $A1, $0B ; duty $0B
    db $30, $0C ; note C3 dur 12
    db $A0, $06 ; volume $06
    db $30, $0C ; note C3 dur 12
    db $A0, $02 ; volume $02
    db $A2, $25 ; duty2 $25
    db $36, $0C ; note F#3 dur 12
    db $A1, $0A ; duty $0A
    db $A2, $FF ; duty2 $FF
    db $15, $0C ; note F1 dur 12
    db $A0, $04 ; volume $04
    db $15, $0C ; note F1 dur 12
    db $A1, $0B ; duty $0B
    db $A0, $02 ; volume $02
    db $1A, $0C ; note A#1 dur 12
    db $A0, $04 ; volume $04
    db $1A, $0C ; note A#1 dur 12
    db $A0, $02 ; volume $02
    db $23, $0C ; note D#2 dur 12
    db $A0, $04 ; volume $04
    db $23, $0C ; note D#2 dur 12
    db $A0, $02 ; volume $02
    db $28, $0C ; note G#2 dur 12
    db $A0, $04 ; volume $04
    db $28, $0C ; note G#2 dur 12
    db $A0, $02 ; volume $02
    db $21, $0C ; note C#2 dur 12
    db $A0, $04 ; volume $04
    db $21, $0C ; note C#2 dur 12
    db $A0, $02 ; volume $02
    db $26, $0C ; note F#2 dur 12
    db $A0, $04 ; volume $04
    db $26, $0C ; note F#2 dur 12
    db $A0, $02 ; volume $02
    db $20, $0C ; note C2 dur 12
    db $A0, $04 ; volume $04
    db $20, $0C ; note C2 dur 12
    db $A0, $02 ; volume $02
    db $25, $0C ; note F2 dur 12
    db $A0, $04 ; volume $04
    db $25, $0C ; note F2 dur 12
    db $A0, $02 ; volume $02
    db $1B, $30 ; note B1 dur 48
    db $A0, $04 ; volume $04
    db $1B, $18 ; note B1 dur 24
    db $A0, $02 ; volume $02
    db $1B, $18 ; note B1 dur 24
    db $1A, $30 ; note A#1 dur 48
    db $A0, $04 ; volume $04
    db $1A, $18 ; note A#1 dur 24
    db $A0, $02 ; volume $02
    db $1A, $18 ; note A#1 dur 24
    db $19, $48 ; note A1 dur 72
    db $A0, $04 ; volume $04
    db $19, $18 ; note A1 dur 24
    db $A0, $02 ; volume $02
    db $20, $48 ; note C2 dur 72
    db $A0, $04 ; volume $04
    db $20, $18 ; note C2 dur 24
    db $B0, $F3 ; jump $F3
    db $FF, $FF ; end

; sound track, 50 events after the header (E-0019: grammar C2, meaning C0)
Data_040_5C7D:: ; heuristic: track stream of a sound record; C0
    db $01, $00, $0F, $00 ; header: param=1 byte1=$00 volume=$0F byte3=$00
    db $FD, $F3 ; label 3
    db $FD, $F0 ; label 0
    db $1F, $60 ; rest-note $1F dur 96
    db $BB, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $1F, $C0 ; rest-note $1F dur 192
    db $B7, $F0 ; repeat $F0
    db $1F, $18 ; rest-note $1F dur 24
    db $A0, $0A ; volume $0A
    db $31, $01 ; note C#3 dur 1
    db $1F, $17 ; rest-note $1F dur 23
    db $A0, $0A ; volume $0A
    db $31, $01 ; note C#3 dur 1
    db $1F, $17 ; rest-note $1F dur 23
    db $A0, $0A ; volume $0A
    db $31, $01 ; note C#3 dur 1
    db $1F, $17 ; rest-note $1F dur 23
    db $A0, $0F ; volume $0F
    db $41, $01 ; note C#4 dur 1
    db $1F, $05 ; rest-note $1F dur 5
    db $A0, $07 ; volume $07
    db $41, $01 ; note C#4 dur 1
    db $1F, $05 ; rest-note $1F dur 5
    db $A0, $0B ; volume $0B
    db $41, $01 ; note C#4 dur 1
    db $1F, $05 ; rest-note $1F dur 5
    db $A0, $05 ; volume $05
    db $41, $01 ; note C#4 dur 1
    db $1F, $05 ; rest-note $1F dur 5
    db $A0, $0F ; volume $0F
    db $41, $01 ; note C#4 dur 1
    db $1F, $05 ; rest-note $1F dur 5
    db $A0, $07 ; volume $07
    db $41, $01 ; note C#4 dur 1
    db $1F, $05 ; rest-note $1F dur 5
    db $A0, $0D ; volume $0D
    db $41, $01 ; note C#4 dur 1
    db $1F, $05 ; rest-note $1F dur 5
    db $A0, $05 ; volume $05
    db $41, $01 ; note C#4 dur 1
    db $1F, $05 ; rest-note $1F dur 5
    db $A0, $0F ; volume $0F
    db $51, $02 ; note C#5 dur 2
    db $53, $02 ; note D#5 dur 2
    db $A0, $04 ; volume $04
    db $56, $04 ; note F#5 dur 4
    db $1F, $10 ; rest-note $1F dur 16
    db $1F, $18 ; rest-note $1F dur 24
    db $B0, $F3 ; jump $F3
    db $FF, $FF ; end

; sound track, 533 events after the header (E-0019: grammar C2, meaning C0)
Data_040_5CE5:: ; heuristic: track stream of a sound record; C0
    db $01, $01, $0B, $00 ; header: param=1 byte1=$01 volume=$0B byte3=$00
    db $FD, $F3 ; label 3
    db $A2, $00 ; duty2 $00
    db $A0, $0B ; volume $0B
    db $C2, $15 ; env $15
    db $2B, $06 ; note B2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $C1, $30 ; env $30
    db $2B, $0C ; note B2 dur 12
    db $A0, $06 ; volume $06
    db $2B, $0C ; note B2 dur 12
    db $1F, $48 ; rest-note $1F dur 72
    db $A0, $0D ; volume $0D
    db $C2, $15 ; env $15
    db $A0, $0F ; volume $0F
    db $15, $0C ; note F1 dur 12
    db $15, $06 ; note F1 dur 6
    db $15, $06 ; note F1 dur 6
    db $C1, $30 ; env $30
    db $15, $0C ; note F1 dur 12
    db $A0, $06 ; volume $06
    db $15, $0C ; note F1 dur 12
    db $1F, $24 ; rest-note $1F dur 36
    db $C1, $30 ; env $30
    db $A2, $02 ; duty2 $02
    db $A0, $05 ; volume $05
    db $1F, $06 ; rest-note $1F dur 6
    db $12, $06 ; note D1 dur 6
    db $11, $06 ; note C#1 dur 6
    db $12, $06 ; note D1 dur 6
    db $14, $06 ; note E1 dur 6
    db $15, $06 ; note F1 dur 6
    db $14, $06 ; note E1 dur 6
    db $12, $06 ; note D1 dur 6
    db $11, $06 ; note C#1 dur 6
    db $12, $06 ; note D1 dur 6
    db $11, $06 ; note C#1 dur 6
    db $12, $06 ; note D1 dur 6
    db $A0, $0E ; volume $0E
    db $22, $06 ; note D2 dur 6
    db $25, $06 ; note F2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $A0, $0C ; volume $0C
    db $32, $06 ; note D3 dur 6
    db $35, $06 ; note F3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $3B, $06 ; note B3 dur 6
    db $A0, $05 ; volume $05
    db $3B, $06 ; note B3 dur 6
    db $15, $06 ; note F1 dur 6
    db $14, $06 ; note E1 dur 6
    db $12, $06 ; note D1 dur 6
    db $11, $06 ; note C#1 dur 6
    db $12, $06 ; note D1 dur 6
    db $11, $06 ; note C#1 dur 6
    db $12, $06 ; note D1 dur 6
    db $14, $06 ; note E1 dur 6
    db $15, $06 ; note F1 dur 6
    db $14, $06 ; note E1 dur 6
    db $12, $06 ; note D1 dur 6
    db $11, $06 ; note C#1 dur 6
    db $12, $06 ; note D1 dur 6
    db $11, $06 ; note C#1 dur 6
    db $12, $06 ; note D1 dur 6
    db $14, $06 ; note E1 dur 6
    db $15, $06 ; note F1 dur 6
    db $14, $06 ; note E1 dur 6
    db $12, $06 ; note D1 dur 6
    db $11, $06 ; note C#1 dur 6
    db $12, $06 ; note D1 dur 6
    db $11, $06 ; note C#1 dur 6
    db $12, $06 ; note D1 dur 6
    db $14, $06 ; note E1 dur 6
    db $15, $06 ; note F1 dur 6
    db $22, $06 ; note D2 dur 6
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $31, $06 ; note C#3 dur 6
    db $29, $06 ; note A2 dur 6
    db $31, $06 ; note C#3 dur 6
    db $34, $06 ; note E3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $34, $06 ; note E3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $3B, $06 ; note B3 dur 6
    db $43, $06 ; note D#4 dur 6
    db $3B, $06 ; note B3 dur 6
    db $43, $06 ; note D#4 dur 6
    db $46, $06 ; note F#4 dur 6
    db $4A, $06 ; note A#4 dur 6
    db $14, $06 ; note E1 dur 6
    db $12, $06 ; note D1 dur 6
    db $FD, $F0 ; label 0
    db $A0, $0D ; volume $0D
    db $15, $06 ; note F1 dur 6
    db $14, $06 ; note E1 dur 6
    db $15, $06 ; note F1 dur 6
    db $17, $06 ; note G1 dur 6
    db $18, $06 ; note G#1 dur 6
    db $17, $06 ; note G1 dur 6
    db $15, $06 ; note F1 dur 6
    db $14, $06 ; note E1 dur 6
    db $B1, $F0 ; repeat $F0
    db $15, $06 ; note F1 dur 6
    db $14, $06 ; note E1 dur 6
    db $15, $06 ; note F1 dur 6
    db $17, $06 ; note G1 dur 6
    db $A0, $0B ; volume $0B
    db $18, $06 ; note G#1 dur 6
    db $17, $06 ; note G1 dur 6
    db $15, $06 ; note F1 dur 6
    db $14, $06 ; note E1 dur 6
    db $A0, $0D ; volume $0D
    db $FD, $F0 ; label 0
    db $15, $06 ; note F1 dur 6
    db $14, $06 ; note E1 dur 6
    db $15, $06 ; note F1 dur 6
    db $17, $06 ; note G1 dur 6
    db $18, $06 ; note G#1 dur 6
    db $17, $06 ; note G1 dur 6
    db $15, $06 ; note F1 dur 6
    db $14, $06 ; note E1 dur 6
    db $B4, $F0 ; repeat $F0
    db $A0, $06 ; volume $06
    db $14, $06 ; note E1 dur 6
    db $1F, $06 ; rest-note $1F dur 6
    db $A0, $0A ; volume $0A
    db $C2, $15 ; env $15
    db $20, $0C ; note C2 dur 12
    db $20, $0C ; note C2 dur 12
    db $C1, $30 ; env $30
    db $21, $12 ; note C#2 dur 18
    db $A0, $05 ; volume $05
    db $21, $06 ; note C#2 dur 6
    db $A0, $0B ; volume $0B
    db $C1, $50 ; env $50
    db $20, $0C ; note C2 dur 12
    db $C2, $15 ; env $15
    db $21, $0C ; note C#2 dur 12
    db $22, $0C ; note D2 dur 12
    db $23, $06 ; note D#2 dur 6
    db $23, $06 ; note D#2 dur 6
    db $A0, $04 ; volume $04
    db $23, $06 ; note D#2 dur 6
    db $A0, $0B ; volume $0B
    db $23, $06 ; note D#2 dur 6
    db $A0, $0C ; volume $0C
    db $24, $06 ; note E2 dur 6
    db $24, $06 ; note E2 dur 6
    db $A0, $04 ; volume $04
    db $24, $06 ; note E2 dur 6
    db $A0, $0C ; volume $0C
    db $24, $06 ; note E2 dur 6
    db $A0, $0D ; volume $0D
    db $25, $06 ; note F2 dur 6
    db $25, $06 ; note F2 dur 6
    db $A0, $04 ; volume $04
    db $25, $06 ; note F2 dur 6
    db $A0, $0D ; volume $0D
    db $A0, $0F ; volume $0F
    db $25, $06 ; note F2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $A0, $05 ; volume $05
    db $26, $06 ; note F#2 dur 6
    db $A0, $0F ; volume $0F
    db $26, $06 ; note F#2 dur 6
    db $27, $0C ; note G2 dur 12
    db $23, $0C ; note D#2 dur 12
    db $A0, $06 ; volume $06
    db $23, $0C ; note D#2 dur 12
    db $A0, $0D ; volume $0D
    db $24, $0C ; note E2 dur 12
    db $A0, $06 ; volume $06
    db $24, $0C ; note E2 dur 12
    db $A0, $0C ; volume $0C
    db $C1, $7F ; env $7F
    db $25, $0C ; note F2 dur 12
    db $31, $24 ; note C#3 dur 36
    db $A0, $06 ; volume $06
    db $31, $0C ; note C#3 dur 12
    db $A0, $0C ; volume $0C
    db $FD, $F0 ; label 0
    db $21, $06 ; note C#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $B5, $F0 ; repeat $F0
    db $A0, $0A ; volume $0A
    db $C1, $30 ; env $30
    db $FD, $F0 ; label 0
    db $18, $0C ; note G#1 dur 12
    db $B3, $F0 ; repeat $F0
    db $A0, $06 ; volume $06
    db $18, $0C ; note G#1 dur 12
    db $A0, $0A ; volume $0A
    db $22, $0C ; note D2 dur 12
    db $22, $0C ; note D2 dur 12
    db $22, $0C ; note D2 dur 12
    db $FD, $F0 ; label 0
    db $28, $0C ; note G#2 dur 12
    db $B3, $F0 ; repeat $F0
    db $A0, $06 ; volume $06
    db $28, $0C ; note G#2 dur 12
    db $A0, $0A ; volume $0A
    db $32, $0C ; note D3 dur 12
    db $32, $0C ; note D3 dur 12
    db $32, $0C ; note D3 dur 12
    db $AF, $01 ; param $01
    db $A2, $01 ; duty2 $01
    db $A0, $0F ; volume $0F
    db $A1, $00 ; duty $00
    db $C0, $FE ; env $FE
    db $14, $24 ; note E1 dur 36
    db $C1, $7F ; env $7F
    db $A0, $08 ; volume $08
    db $14, $0C ; note E1 dur 12
    db $A0, $0D ; volume $0D
    db $C0, $FE ; env $FE
    db $17, $24 ; note G1 dur 36
    db $C1, $7F ; env $7F
    db $A0, $08 ; volume $08
    db $17, $0C ; note G1 dur 12
    db $A0, $0D ; volume $0D
    db $C0, $FE ; env $FE
    db $1A, $24 ; note A#1 dur 36
    db $C1, $7F ; env $7F
    db $A0, $08 ; volume $08
    db $1A, $0C ; note A#1 dur 12
    db $A0, $0D ; volume $0D
    db $C0, $FE ; env $FE
    db $21, $24 ; note C#2 dur 36
    db $C1, $7F ; env $7F
    db $A0, $08 ; volume $08
    db $21, $0C ; note C#2 dur 12
    db $A0, $0D ; volume $0D
    db $C0, $FE ; env $FE
    db $20, $24 ; note C2 dur 36
    db $C1, $7F ; env $7F
    db $A0, $08 ; volume $08
    db $20, $0C ; note C2 dur 12
    db $A0, $0D ; volume $0D
    db $C0, $FE ; env $FE
    db $25, $24 ; note F2 dur 36
    db $C1, $7F ; env $7F
    db $A0, $08 ; volume $08
    db $25, $0C ; note F2 dur 12
    db $A0, $0D ; volume $0D
    db $C0, $FE ; env $FE
    db $24, $24 ; note E2 dur 36
    db $C1, $7F ; env $7F
    db $A0, $08 ; volume $08
    db $24, $0C ; note E2 dur 12
    db $A0, $0D ; volume $0D
    db $C0, $FE ; env $FE
    db $2A, $24 ; note A#2 dur 36
    db $C1, $7F ; env $7F
    db $A0, $08 ; volume $08
    db $2A, $0C ; note A#2 dur 12
    db $C1, $30 ; env $30
    db $A0, $09 ; volume $09
    db $FD, $F0 ; label 0
    db $26, $0C ; note F#2 dur 12
    db $B3, $F0 ; repeat $F0
    db $A0, $05 ; volume $05
    db $26, $0C ; note F#2 dur 12
    db $A0, $0A ; volume $0A
    db $26, $0C ; note F#2 dur 12
    db $A0, $0C ; volume $0C
    db $26, $0C ; note F#2 dur 12
    db $A0, $0D ; volume $0D
    db $26, $0C ; note F#2 dur 12
    db $FD, $F0 ; label 0
    db $29, $0C ; note A2 dur 12
    db $B3, $F0 ; repeat $F0
    db $A0, $06 ; volume $06
    db $29, $0C ; note A2 dur 12
    db $A0, $0E ; volume $0E
    db $29, $0C ; note A2 dur 12
    db $29, $0C ; note A2 dur 12
    db $A0, $0F ; volume $0F
    db $29, $0C ; note A2 dur 12
    db $C1, $3F ; env $3F
    db $A0, $0F ; volume $0F
    db $38, $18 ; note G#3 dur 24
    db $A0, $0D ; volume $0D
    db $C1, $30 ; env $30
    db $37, $06 ; note G3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $34, $06 ; note E3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $32, $06 ; note D3 dur 6
    db $31, $06 ; note C#3 dur 6
    db $30, $06 ; note C3 dur 6
    db $2B, $06 ; note B2 dur 6
    db $2A, $06 ; note A#2 dur 6
    db $29, $06 ; note A2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $27, $06 ; note G2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $24, $06 ; note E2 dur 6
    db $23, $06 ; note D#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $21, $06 ; note C#2 dur 6
    db $20, $06 ; note C2 dur 6
    db $1B, $06 ; note B1 dur 6
    db $1A, $06 ; note A#1 dur 6
    db $19, $06 ; note A1 dur 6
    db $18, $06 ; note G#1 dur 6
    db $17, $06 ; note G1 dur 6
    db $16, $06 ; note F#1 dur 6
    db $15, $06 ; note F1 dur 6
    db $14, $06 ; note E1 dur 6
    db $A0, $0C ; volume $0C
    db $C1, $50 ; env $50
    db $1F, $0C ; rest-note $1F dur 12
    db $16, $0C ; note F#1 dur 12
    db $FD, $F0 ; label 0
    db $A0, $08 ; volume $08
    db $16, $0C ; note F#1 dur 12
    db $A0, $0C ; volume $0C
    db $16, $0C ; note F#1 dur 12
    db $B6, $F0 ; repeat $F0
    db $A0, $08 ; volume $08
    db $16, $0C ; note F#1 dur 12
    db $A0, $0C ; volume $0C
    db $19, $0C ; note A1 dur 12
    db $FD, $F0 ; label 0
    db $A0, $08 ; volume $08
    db $19, $0C ; note A1 dur 12
    db $A0, $0C ; volume $0C
    db $19, $0C ; note A1 dur 12
    db $B2, $F0 ; repeat $F0
    db $A0, $08 ; volume $08
    db $19, $0C ; note A1 dur 12
    db $A0, $0C ; volume $0C
    db $1B, $0C ; note B1 dur 12
    db $FD, $F0 ; label 0
    db $A0, $08 ; volume $08
    db $1B, $0C ; note B1 dur 12
    db $A0, $0C ; volume $0C
    db $1B, $0C ; note B1 dur 12
    db $B2, $F0 ; repeat $F0
    db $A0, $08 ; volume $08
    db $1B, $0C ; note B1 dur 12
    db $A0, $0C ; volume $0C
    db $20, $0C ; note C2 dur 12
    db $FD, $F0 ; label 0
    db $A0, $08 ; volume $08
    db $20, $0C ; note C2 dur 12
    db $A0, $0C ; volume $0C
    db $20, $0C ; note C2 dur 12
    db $B2, $F0 ; repeat $F0
    db $A0, $08 ; volume $08
    db $20, $0C ; note C2 dur 12
    db $A0, $0C ; volume $0C
    db $23, $0C ; note D#2 dur 12
    db $A0, $08 ; volume $08
    db $23, $0C ; note D#2 dur 12
    db $A0, $0C ; volume $0C
    db $23, $0C ; note D#2 dur 12
    db $A0, $0E ; volume $0E
    db $20, $06 ; note C2 dur 6
    db $23, $06 ; note D#2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2A, $06 ; note A#2 dur 6
    db $32, $06 ; note D3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $42, $06 ; note D4 dur 6
    db $A0, $0C ; volume $0C
    db $C1, $30 ; env $30
    db $FD, $F0 ; label 0
    db $21, $06 ; note C#2 dur 6
    db $21, $06 ; note C#2 dur 6
    db $A0, $08 ; volume $08
    db $21, $06 ; note C#2 dur 6
    db $A0, $0C ; volume $0C
    db $21, $06 ; note C#2 dur 6
    db $B3, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $20, $06 ; note C2 dur 6
    db $20, $06 ; note C2 dur 6
    db $A0, $08 ; volume $08
    db $20, $06 ; note C2 dur 6
    db $A0, $0C ; volume $0C
    db $20, $06 ; note C2 dur 6
    db $B3, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $1B, $06 ; note B1 dur 6
    db $1B, $06 ; note B1 dur 6
    db $A0, $08 ; volume $08
    db $1B, $06 ; note B1 dur 6
    db $A0, $0C ; volume $0C
    db $1B, $06 ; note B1 dur 6
    db $B1, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $1A, $06 ; note A#1 dur 6
    db $1A, $06 ; note A#1 dur 6
    db $A0, $08 ; volume $08
    db $1A, $06 ; note A#1 dur 6
    db $A0, $0C ; volume $0C
    db $1A, $06 ; note A#1 dur 6
    db $B1, $F0 ; repeat $F0
    db $19, $06 ; note A1 dur 6
    db $19, $06 ; note A1 dur 6
    db $A0, $08 ; volume $08
    db $19, $06 ; note A1 dur 6
    db $A0, $0C ; volume $0C
    db $19, $06 ; note A1 dur 6
    db $18, $06 ; note G#1 dur 6
    db $18, $06 ; note G#1 dur 6
    db $A0, $08 ; volume $08
    db $18, $06 ; note G#1 dur 6
    db $A0, $0C ; volume $0C
    db $18, $06 ; note G#1 dur 6
    db $17, $06 ; note G1 dur 6
    db $1B, $06 ; note B1 dur 6
    db $22, $06 ; note D2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $29, $06 ; note A2 dur 6
    db $31, $06 ; note C#3 dur 6
    db $34, $06 ; note E3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $AF, $01 ; param $01
    db $A2, $01 ; duty2 $01
    db $A0, $0A ; volume $0A
    db $A1, $00 ; duty $00
    db $C1, $50 ; env $50
    db $FD, $F0 ; label 0
    db $21, $06 ; note C#2 dur 6
    db $24, $06 ; note E2 dur 6
    db $BF, $F0 ; repeat $F0
    db $C1, $20 ; env $20
    db $23, $06 ; note D#2 dur 6
    db $23, $06 ; note D#2 dur 6
    db $A0, $08 ; volume $08
    db $23, $06 ; note D#2 dur 6
    db $A0, $0C ; volume $0C
    db $23, $06 ; note D#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $22, $06 ; note D2 dur 6
    db $A0, $08 ; volume $08
    db $22, $06 ; note D2 dur 6
    db $A0, $0C ; volume $0C
    db $22, $06 ; note D2 dur 6
    db $21, $06 ; note C#2 dur 6
    db $21, $06 ; note C#2 dur 6
    db $A0, $08 ; volume $08
    db $21, $06 ; note C#2 dur 6
    db $A0, $0C ; volume $0C
    db $21, $06 ; note C#2 dur 6
    db $20, $06 ; note C2 dur 6
    db $20, $06 ; note C2 dur 6
    db $A0, $08 ; volume $08
    db $20, $06 ; note C2 dur 6
    db $A0, $0C ; volume $0C
    db $20, $06 ; note C2 dur 6
    db $C0, $FE ; env $FE
    db $1B, $48 ; note B1 dur 72
    db $A0, $08 ; volume $08
    db $C1, $7F ; env $7F
    db $1B, $18 ; note B1 dur 24
    db $A0, $0C ; volume $0C
    db $C2, $15 ; env $15
    db $FD, $F0 ; label 0
    db $19, $0C ; note A1 dur 12
    db $27, $0C ; note G2 dur 12
    db $B3, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $17, $0C ; note G1 dur 12
    db $2A, $0C ; note A#2 dur 12
    db $B3, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $19, $0C ; note A1 dur 12
    db $27, $0C ; note G2 dur 12
    db $B3, $F0 ; repeat $F0
    db $C1, $30 ; env $30
    db $24, $06 ; note E2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $34, $06 ; note E3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3B, $06 ; note B3 dur 6
    db $44, $06 ; note E4 dur 6
    db $47, $06 ; note G4 dur 6
    db $23, $06 ; note D#2 dur 6
    db $27, $06 ; note G2 dur 6
    db $29, $06 ; note A2 dur 6
    db $31, $06 ; note C#3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $39, $06 ; note A3 dur 6
    db $41, $06 ; note C#4 dur 6
    db $C0, $FE ; env $FE
    db $12, $24 ; note D1 dur 36
    db $A0, $08 ; volume $08
    db $12, $0C ; note D1 dur 12
    db $A0, $0C ; volume $0C
    db $15, $24 ; note F1 dur 36
    db $A0, $08 ; volume $08
    db $15, $0C ; note F1 dur 12
    db $A0, $0C ; volume $0C
    db $18, $24 ; note G#1 dur 36
    db $A0, $08 ; volume $08
    db $18, $0C ; note G#1 dur 12
    db $A0, $0C ; volume $0C
    db $17, $24 ; note G1 dur 36
    db $A0, $08 ; volume $08
    db $17, $0C ; note G1 dur 12
    db $A0, $0C ; volume $0C
    db $15, $24 ; note F1 dur 36
    db $A0, $08 ; volume $08
    db $15, $0C ; note F1 dur 12
    db $A0, $0C ; volume $0C
    db $13, $24 ; note D#1 dur 36
    db $A0, $08 ; volume $08
    db $13, $0C ; note D#1 dur 12
    db $A0, $0C ; volume $0C
    db $12, $24 ; note D1 dur 36
    db $A0, $08 ; volume $08
    db $12, $0C ; note D1 dur 12
    db $A0, $0C ; volume $0C
    db $11, $24 ; note C#1 dur 36
    db $A0, $08 ; volume $08
    db $11, $0C ; note C#1 dur 12
    db $A0, $0C ; volume $0C
    db $12, $A8 ; note D1 dur 168
    db $A0, $08 ; volume $08
    db $C1, $7F ; env $7F
    db $12, $18 ; note D1 dur 24
    db $B0, $F3 ; jump $F3
    db $FF, $FF ; end

; sound track, 461 events after the header (E-0019: grammar C2, meaning C0)
Data_040_6113:: ; heuristic: track stream of a sound record; C0
    db $01, $01, $0C, $00 ; header: param=1 byte1=$01 volume=$0C byte3=$00
    db $FD, $F3 ; label 3
    db $A2, $00 ; duty2 $00
    db $A0, $0C ; volume $0C
    db $C2, $15 ; env $15
    db $34, $06 ; note E3 dur 6
    db $34, $06 ; note E3 dur 6
    db $C1, $30 ; env $30
    db $34, $0C ; note E3 dur 12
    db $A0, $06 ; volume $06
    db $34, $06 ; note E3 dur 6
    db $A2, $02 ; duty2 $02
    db $A0, $05 ; volume $05
    db $15, $06 ; note F1 dur 6
    db $14, $06 ; note E1 dur 6
    db $12, $06 ; note D1 dur 6
    db $11, $06 ; note C#1 dur 6
    db $12, $06 ; note D1 dur 6
    db $11, $06 ; note C#1 dur 6
    db $12, $06 ; note D1 dur 6
    db $14, $06 ; note E1 dur 6
    db $15, $06 ; note F1 dur 6
    db $14, $06 ; note E1 dur 6
    db $12, $06 ; note D1 dur 6
    db $11, $06 ; note C#1 dur 6
    db $12, $06 ; note D1 dur 6
    db $A2, $01 ; duty2 $01
    db $C2, $15 ; env $15
    db $A0, $0F ; volume $0F
    db $1B, $0C ; note B1 dur 12
    db $1B, $06 ; note B1 dur 6
    db $1B, $06 ; note B1 dur 6
    db $C1, $30 ; env $30
    db $1B, $0C ; note B1 dur 12
    db $A0, $06 ; volume $06
    db $1B, $06 ; note B1 dur 6
    db $A2, $02 ; duty2 $02
    db $12, $06 ; note D1 dur 6
    db $11, $06 ; note C#1 dur 6
    db $12, $06 ; note D1 dur 6
    db $14, $06 ; note E1 dur 6
    db $15, $06 ; note F1 dur 6
    db $14, $06 ; note E1 dur 6
    db $12, $06 ; note D1 dur 6
    db $A0, $0D ; volume $0D
    db $C1, $30 ; env $30
    db $A2, $00 ; duty2 $00
    db $32, $06 ; note D3 dur 6
    db $39, $06 ; note A3 dur 6
    db $C0, $FE ; env $FE
    db $38, $90 ; note G#3 dur 144
    db $C1, $7F ; env $7F
    db $A0, $08 ; volume $08
    db $A3, $08 ; mod $08
    db $38, $18 ; note G#3 dur 24
    db $A0, $0F ; volume $0F
    db $C1, $30 ; env $30
    db $37, $06 ; note G3 dur 6
    db $35, $06 ; note F3 dur 6
    db $C1, $7F ; env $7F
    db $32, $18 ; note D3 dur 24
    db $A0, $06 ; volume $06
    db $32, $18 ; note D3 dur 24
    db $1F, $18 ; rest-note $1F dur 24
    db $A0, $0D ; volume $0D
    db $A2, $02 ; duty2 $02
    db $C1, $20 ; env $20
    db $22, $06 ; note D2 dur 6
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $31, $06 ; note C#3 dur 6
    db $29, $06 ; note A2 dur 6
    db $31, $06 ; note C#3 dur 6
    db $34, $06 ; note E3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $34, $06 ; note E3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $3B, $06 ; note B3 dur 6
    db $43, $06 ; note D#4 dur 6
    db $3B, $06 ; note B3 dur 6
    db $43, $06 ; note D#4 dur 6
    db $46, $06 ; note F#4 dur 6
    db $4A, $06 ; note A#4 dur 6
    db $1F, $18 ; rest-note $1F dur 24
    db $C1, $30 ; env $30
    db $A2, $00 ; duty2 $00
    db $32, $06 ; note D3 dur 6
    db $39, $06 ; note A3 dur 6
    db $C0, $FE ; env $FE
    db $38, $54 ; note G#3 dur 84
    db $C1, $7F ; env $7F
    db $A0, $08 ; volume $08
    db $38, $18 ; note G#3 dur 24
    db $A2, $02 ; duty2 $02
    db $A0, $0F ; volume $0F
    db $C1, $25 ; env $25
    db $A2, $02 ; duty2 $02
    db $22, $06 ; note D2 dur 6
    db $25, $06 ; note F2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $A0, $08 ; volume $08
    db $2B, $06 ; note B2 dur 6
    db $1F, $1E ; rest-note $1F dur 30
    db $A2, $00 ; duty2 $00
    db $A0, $0D ; volume $0D
    db $C1, $30 ; env $30
    db $39, $06 ; note A3 dur 6
    db $40, $06 ; note C4 dur 6
    db $C1, $7F ; env $7F
    db $42, $18 ; note D4 dur 24
    db $A0, $08 ; volume $08
    db $42, $18 ; note D4 dur 24
    db $1F, $18 ; rest-note $1F dur 24
    db $A2, $02 ; duty2 $02
    db $A0, $0D ; volume $0D
    db $C1, $1F ; env $1F
    db $22, $06 ; note D2 dur 6
    db $25, $06 ; note F2 dur 6
    db $29, $06 ; note A2 dur 6
    db $31, $06 ; note C#3 dur 6
    db $29, $06 ; note A2 dur 6
    db $31, $06 ; note C#3 dur 6
    db $34, $06 ; note E3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $34, $06 ; note E3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $3B, $06 ; note B3 dur 6
    db $43, $06 ; note D#4 dur 6
    db $3B, $06 ; note B3 dur 6
    db $43, $06 ; note D#4 dur 6
    db $46, $06 ; note F#4 dur 6
    db $4A, $06 ; note A#4 dur 6
    db $A0, $08 ; volume $08
    db $4A, $0C ; note A#4 dur 12
    db $1F, $18 ; rest-note $1F dur 24
    db $A0, $0A ; volume $0A
    db $C2, $15 ; env $15
    db $27, $0C ; note G2 dur 12
    db $27, $0C ; note G2 dur 12
    db $C1, $30 ; env $30
    db $29, $12 ; note A2 dur 18
    db $A0, $05 ; volume $05
    db $29, $06 ; note A2 dur 6
    db $A0, $0A ; volume $0A
    db $C1, $50 ; env $50
    db $27, $0C ; note G2 dur 12
    db $C2, $15 ; env $15
    db $29, $0C ; note A2 dur 12
    db $2A, $0C ; note A#2 dur 12
    db $C1, $2F ; env $2F
    db $2B, $06 ; note B2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $A0, $04 ; volume $04
    db $2B, $06 ; note B2 dur 6
    db $A0, $0A ; volume $0A
    db $2B, $06 ; note B2 dur 6
    db $A0, $0C ; volume $0C
    db $30, $06 ; note C3 dur 6
    db $30, $06 ; note C3 dur 6
    db $A0, $04 ; volume $04
    db $30, $06 ; note C3 dur 6
    db $A0, $0C ; volume $0C
    db $30, $06 ; note C3 dur 6
    db $A0, $0D ; volume $0D
    db $31, $06 ; note C#3 dur 6
    db $31, $06 ; note C#3 dur 6
    db $A0, $06 ; volume $06
    db $31, $06 ; note C#3 dur 6
    db $A0, $0D ; volume $0D
    db $31, $06 ; note C#3 dur 6
    db $A0, $0E ; volume $0E
    db $32, $06 ; note D3 dur 6
    db $32, $06 ; note D3 dur 6
    db $A0, $06 ; volume $06
    db $32, $06 ; note D3 dur 6
    db $A0, $0E ; volume $0E
    db $32, $06 ; note D3 dur 6
    db $C1, $5F ; env $5F
    db $33, $0C ; note D#3 dur 12
    db $26, $0C ; note F#2 dur 12
    db $A0, $06 ; volume $06
    db $26, $0C ; note F#2 dur 12
    db $A0, $0E ; volume $0E
    db $27, $0C ; note G2 dur 12
    db $A0, $06 ; volume $06
    db $27, $0C ; note G2 dur 12
    db $A0, $0E ; volume $0E
    db $28, $0C ; note G#2 dur 12
    db $C1, $7F ; env $7F
    db $34, $24 ; note E3 dur 36
    db $A0, $06 ; volume $06
    db $34, $0C ; note E3 dur 12
    db $A0, $0E ; volume $0E
    db $FD, $F0 ; label 0
    db $24, $06 ; note E2 dur 6
    db $29, $06 ; note A2 dur 6
    db $B5, $F0 ; repeat $F0
    db $C2, $50 ; env $50
    db $A0, $0A ; volume $0A
    db $FD, $F0 ; label 0
    db $1B, $0C ; note B1 dur 12
    db $B3, $F0 ; repeat $F0
    db $A0, $06 ; volume $06
    db $1B, $0C ; note B1 dur 12
    db $A0, $0A ; volume $0A
    db $25, $0C ; note F2 dur 12
    db $25, $0C ; note F2 dur 12
    db $25, $0C ; note F2 dur 12
    db $FD, $F0 ; label 0
    db $2B, $0C ; note B2 dur 12
    db $B3, $F0 ; repeat $F0
    db $A0, $06 ; volume $06
    db $2B, $0C ; note B2 dur 12
    db $A0, $0A ; volume $0A
    db $35, $0C ; note F3 dur 12
    db $35, $0C ; note F3 dur 12
    db $35, $0C ; note F3 dur 12
    db $AF, $01 ; param $01
    db $A2, $02 ; duty2 $02
    db $A0, $09 ; volume $09
    db $A1, $00 ; duty $00
    db $C1, $20 ; env $20
    db $FD, $F0 ; label 0
    db $37, $06 ; note G3 dur 6
    db $43, $06 ; note D#4 dur 6
    db $39, $06 ; note A3 dur 6
    db $3B, $06 ; note B3 dur 6
    db $43, $06 ; note D#4 dur 6
    db $37, $06 ; note G3 dur 6
    db $39, $06 ; note A3 dur 6
    db $43, $06 ; note D#4 dur 6
    db $B7, $F0 ; repeat $F0
    db $A0, $09 ; volume $09
    db $C1, $30 ; env $30
    db $FD, $F0 ; label 0
    db $29, $0C ; note A2 dur 12
    db $B3, $F0 ; repeat $F0
    db $A0, $05 ; volume $05
    db $29, $0C ; note A2 dur 12
    db $A0, $0A ; volume $0A
    db $29, $0C ; note A2 dur 12
    db $A0, $0D ; volume $0D
    db $29, $0C ; note A2 dur 12
    db $A0, $0E ; volume $0E
    db $29, $0C ; note A2 dur 12
    db $FD, $F0 ; label 0
    db $30, $0C ; note C3 dur 12
    db $B3, $F0 ; repeat $F0
    db $A0, $06 ; volume $06
    db $30, $0C ; note C3 dur 12
    db $A0, $0E ; volume $0E
    db $30, $0C ; note C3 dur 12
    db $30, $0C ; note C3 dur 12
    db $A0, $0F ; volume $0F
    db $30, $0C ; note C3 dur 12
    db $A0, $06 ; volume $06
    db $C0, $FE ; env $FE
    db $38, $90 ; note G#3 dur 144
    db $C1, $7F ; env $7F
    db $A0, $03 ; volume $03
    db $38, $30 ; note G#3 dur 48
    db $1F, $0C ; rest-note $1F dur 12
    db $A0, $0C ; volume $0C
    db $C1, $30 ; env $30
    db $19, $0C ; note A1 dur 12
    db $FD, $F0 ; label 0
    db $A0, $06 ; volume $06
    db $19, $0C ; note A1 dur 12
    db $A0, $0C ; volume $0C
    db $19, $0C ; note A1 dur 12
    db $B5, $F0 ; repeat $F0
    db $A0, $06 ; volume $06
    db $19, $0C ; note A1 dur 12
    db $A0, $0D ; volume $0D
    db $A2, $02 ; duty2 $02
    db $26, $06 ; note F#2 dur 6
    db $29, $06 ; note A2 dur 6
    db $C1, $60 ; env $60
    db $31, $24 ; note C#3 dur 36
    db $32, $0C ; note D3 dur 12
    db $31, $0C ; note C#3 dur 12
    db $30, $06 ; note C3 dur 6
    db $2B, $06 ; note B2 dur 6
    db $C2, $15 ; env $15
    db $2A, $0C ; note A#2 dur 12
    db $37, $0C ; note G3 dur 12
    db $C1, $7F ; env $7F
    db $36, $0C ; note F#3 dur 12
    db $C2, $15 ; env $15
    db $35, $0C ; note F3 dur 12
    db $C0, $FE ; env $FE
    db $A3, $0A ; mod $0A
    db $44, $30 ; note E4 dur 48
    db $A0, $08 ; volume $08
    db $C1, $7F ; env $7F
    db $A3, $FE ; mod $FE
    db $44, $0C ; note E4 dur 12
    db $A3, $0A ; mod $0A
    db $A0, $0E ; volume $0E
    db $43, $06 ; note D#4 dur 6
    db $42, $06 ; note D4 dur 6
    db $41, $06 ; note C#4 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $39, $06 ; note A3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $35, $30 ; note F3 dur 48
    db $A0, $08 ; volume $08
    db $A3, $00 ; mod $00
    db $35, $0C ; note F3 dur 12
    db $A0, $0E ; volume $0E
    db $A3, $0A ; mod $0A
    db $34, $06 ; note E3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $32, $0C ; note D3 dur 12
    db $C2, $15 ; env $15
    db $40, $0C ; note C4 dur 12
    db $C0, $FE ; env $FE
    db $37, $3C ; note G3 dur 60
    db $A0, $08 ; volume $08
    db $C1, $7F ; env $7F
    db $A3, $00 ; mod $00
    db $37, $0C ; note G3 dur 12
    db $1F, $18 ; rest-note $1F dur 24
    db $A0, $0E ; volume $0E
    db $A3, $0A ; mod $0A
    db $C0, $FE ; env $FE
    db $39, $18 ; note A3 dur 24
    db $A0, $08 ; volume $08
    db $C1, $FE ; env $FE
    db $A3, $00 ; mod $00
    db $39, $18 ; note A3 dur 24
    db $A0, $0E ; volume $0E
    db $A3, $0A ; mod $0A
    db $43, $12 ; note D#4 dur 18
    db $A0, $08 ; volume $08
    db $43, $06 ; note D#4 dur 6
    db $A0, $0E ; volume $0E
    db $42, $12 ; note D4 dur 18
    db $A0, $08 ; volume $08
    db $42, $06 ; note D4 dur 6
    db $A0, $0E ; volume $0E
    db $41, $0C ; note C#4 dur 12
    db $38, $0C ; note G#3 dur 12
    db $37, $12 ; note G3 dur 18
    db $A0, $08 ; volume $08
    db $37, $06 ; note G3 dur 6
    db $A0, $0E ; volume $0E
    db $36, $12 ; note F#3 dur 18
    db $A0, $08 ; volume $08
    db $36, $06 ; note F#3 dur 6
    db $A0, $0E ; volume $0E
    db $35, $06 ; note F3 dur 6
    db $34, $06 ; note E3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $2A, $06 ; note A#2 dur 6
    db $29, $2A ; note A2 dur 42
    db $A0, $08 ; volume $08
    db $29, $06 ; note A2 dur 6
    db $A3, $00 ; mod $00
    db $A0, $0E ; volume $0E
    db $A3, $0A ; mod $0A
    db $2A, $12 ; note A#2 dur 18
    db $A0, $08 ; volume $08
    db $2A, $06 ; note A#2 dur 6
    db $A0, $0E ; volume $0E
    db $2B, $48 ; note B2 dur 72
    db $A0, $08 ; volume $08
    db $A3, $00 ; mod $00
    db $2B, $18 ; note B2 dur 24
    db $AF, $01 ; param $01
    db $A2, $01 ; duty2 $01
    db $A0, $0E ; volume $0E
    db $A1, $00 ; duty $00
    db $C0, $FE ; env $FE
    db $1F, $18 ; rest-note $1F dur 24
    db $29, $0C ; note A2 dur 12
    db $A0, $08 ; volume $08
    db $29, $0C ; note A2 dur 12
    db $A0, $0E ; volume $0E
    db $C1, $30 ; env $30
    db $29, $10 ; note A2 dur 16
    db $29, $10 ; note A2 dur 16
    db $27, $10 ; note G2 dur 16
    db $C0, $FE ; env $FE
    db $30, $18 ; note C3 dur 24
    db $A0, $08 ; volume $08
    db $30, $0C ; note C3 dur 12
    db $A0, $0E ; volume $0E
    db $2A, $0C ; note A#2 dur 12
    db $29, $18 ; note A2 dur 24
    db $A0, $08 ; volume $08
    db $29, $0C ; note A2 dur 12
    db $A0, $0E ; volume $0E
    db $27, $0C ; note G2 dur 12
    db $26, $06 ; note F#2 dur 6
    db $27, $06 ; note G2 dur 6
    db $29, $48 ; note A2 dur 72
    db $A0, $08 ; volume $08
    db $29, $18 ; note A2 dur 24
    db $1F, $0C ; rest-note $1F dur 12
    db $A0, $0F ; volume $0F
    db $27, $06 ; note G2 dur 6
    db $A0, $09 ; volume $09
    db $28, $06 ; note G#2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $32, $06 ; note D3 dur 6
    db $A0, $0F ; volume $0F
    db $25, $06 ; note F2 dur 6
    db $A0, $09 ; volume $09
    db $28, $06 ; note G#2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $32, $06 ; note D3 dur 6
    db $A0, $0F ; volume $0F
    db $23, $06 ; note D#2 dur 6
    db $A0, $09 ; volume $09
    db $28, $06 ; note G#2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $32, $06 ; note D3 dur 6
    db $A0, $0D ; volume $0D
    db $22, $A8 ; note D2 dur 168
    db $C1, $7F ; env $7F
    db $A0, $08 ; volume $08
    db $22, $18 ; note D2 dur 24
    db $A0, $0E ; volume $0E
    db $C0, $FE ; env $FE
    db $21, $48 ; note C#2 dur 72
    db $A0, $08 ; volume $08
    db $A0, $08 ; volume $08
    db $21, $18 ; note C#2 dur 24
    db $A0, $0E ; volume $0E
    db $C0, $FE ; env $FE
    db $1B, $24 ; note B1 dur 36
    db $A0, $08 ; volume $08
    db $1B, $0C ; note B1 dur 12
    db $A0, $0E ; volume $0E
    db $21, $24 ; note C#2 dur 36
    db $A0, $08 ; volume $08
    db $21, $0C ; note C#2 dur 12
    db $A0, $0A ; volume $0A
    db $A2, $02 ; duty2 $02
    db $C1, $1F ; env $1F
    db $FD, $F0 ; label 0
    db $22, $06 ; note D2 dur 6
    db $25, $06 ; note F2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $32, $06 ; note D3 dur 6
    db $35, $06 ; note F3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $3B, $06 ; note B3 dur 6
    db $42, $06 ; note D4 dur 6
    db $41, $06 ; note C#4 dur 6
    db $39, $06 ; note A3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $32, $06 ; note D3 dur 6
    db $31, $06 ; note C#3 dur 6
    db $29, $06 ; note A2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $B5, $F0 ; repeat $F0
    db $B0, $F3 ; jump $F3
    db $FF, $FF ; end

; sound track, 413 events after the header (E-0019: grammar C2, meaning C0)
Data_040_64B1:: ; heuristic: track stream of a sound record; C0
    db $01, $30, $02, $02 ; header: param=1 byte1=$30 volume=$02 byte3=$02
    db $FD, $F3 ; label 3
    db $FD, $F1 ; label 1
    db $A0, $02 ; volume $02
    db $A1, $02 ; duty $02
    db $FD, $F0 ; label 0
    db $22, $06 ; note D2 dur 6
    db $21, $06 ; note C#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $24, $06 ; note E2 dur 6
    db $25, $06 ; note F2 dur 6
    db $24, $06 ; note E2 dur 6
    db $22, $06 ; note D2 dur 6
    db $21, $06 ; note C#2 dur 6
    db $B1, $F0 ; repeat $F0
    db $B9, $F1 ; repeat $F1
    db $A2, $28 ; duty2 $28
    db $22, $0C ; note D2 dur 12
    db $A2, $15 ; duty2 $15
    db $28, $0C ; note G#2 dur 12
    db $28, $0C ; note G#2 dur 12
    db $A2, $30 ; duty2 $30
    db $27, $12 ; note G2 dur 18
    db $A0, $06 ; volume $06
    db $27, $06 ; note G2 dur 6
    db $A0, $02 ; volume $02
    db $A2, $50 ; duty2 $50
    db $28, $0C ; note G#2 dur 12
    db $A2, $15 ; duty2 $15
    db $27, $0C ; note G2 dur 12
    db $26, $0C ; note F#2 dur 12
    db $A0, $04 ; volume $04
    db $A2, $FF ; duty2 $FF
    db $25, $12 ; note F2 dur 18
    db $A0, $06 ; volume $06
    db $25, $06 ; note F2 dur 6
    db $A0, $04 ; volume $04
    db $24, $12 ; note E2 dur 18
    db $A0, $06 ; volume $06
    db $24, $06 ; note E2 dur 6
    db $A0, $02 ; volume $02
    db $23, $12 ; note D#2 dur 18
    db $A0, $04 ; volume $04
    db $23, $06 ; note D#2 dur 6
    db $A0, $02 ; volume $02
    db $22, $12 ; note D2 dur 18
    db $A0, $04 ; volume $04
    db $22, $06 ; note D2 dur 6
    db $A0, $02 ; volume $02
    db $21, $0C ; note C#2 dur 12
    db $32, $0C ; note D3 dur 12
    db $A0, $04 ; volume $04
    db $32, $0C ; note D3 dur 12
    db $A0, $02 ; volume $02
    db $30, $0C ; note C3 dur 12
    db $A0, $04 ; volume $04
    db $30, $0C ; note C3 dur 12
    db $A0, $02 ; volume $02
    db $30, $0C ; note C3 dur 12
    db $26, $18 ; note F#2 dur 24
    db $A0, $06 ; volume $06
    db $26, $0C ; note F#2 dur 12
    db $1F, $0C ; rest-note $1F dur 12
    db $A0, $02 ; volume $02
    db $30, $12 ; note C3 dur 18
    db $A0, $04 ; volume $04
    db $30, $06 ; note C3 dur 6
    db $A0, $02 ; volume $02
    db $29, $12 ; note A2 dur 18
    db $A0, $04 ; volume $04
    db $29, $06 ; note A2 dur 6
    db $A0, $02 ; volume $02
    db $2A, $12 ; note A#2 dur 18
    db $A0, $04 ; volume $04
    db $2A, $06 ; note A#2 dur 6
    db $A2, $20 ; duty2 $20
    db $A0, $02 ; volume $02
    db $27, $0C ; note G2 dur 12
    db $27, $0C ; note G2 dur 12
    db $27, $0C ; note G2 dur 12
    db $25, $0C ; note F2 dur 12
    db $A0, $06 ; volume $06
    db $26, $0C ; note F#2 dur 12
    db $A0, $02 ; volume $02
    db $31, $0C ; note C#3 dur 12
    db $31, $0C ; note C#3 dur 12
    db $2B, $0C ; note B2 dur 12
    db $37, $0C ; note G3 dur 12
    db $37, $0C ; note G3 dur 12
    db $37, $0C ; note G3 dur 12
    db $35, $0C ; note F3 dur 12
    db $A0, $06 ; volume $06
    db $36, $0C ; note F#3 dur 12
    db $A0, $02 ; volume $02
    db $41, $0C ; note C#4 dur 12
    db $41, $0C ; note C#4 dur 12
    db $3B, $0C ; note B3 dur 12
    db $AF, $01 ; param $01
    db $A2, $FF ; duty2 $FF
    db $A0, $02 ; volume $02
    db $A1, $0A ; duty $0A
    db $19, $24 ; note A1 dur 36
    db $A0, $04 ; volume $04
    db $19, $0C ; note A1 dur 12
    db $A0, $02 ; volume $02
    db $20, $24 ; note C2 dur 36
    db $A0, $04 ; volume $04
    db $20, $0C ; note C2 dur 12
    db $A0, $02 ; volume $02
    db $23, $24 ; note D#2 dur 36
    db $A0, $04 ; volume $04
    db $23, $0C ; note D#2 dur 12
    db $A0, $02 ; volume $02
    db $26, $24 ; note F#2 dur 36
    db $A0, $04 ; volume $04
    db $26, $0C ; note F#2 dur 12
    db $A0, $02 ; volume $02
    db $29, $24 ; note A2 dur 36
    db $A0, $04 ; volume $04
    db $29, $0C ; note A2 dur 12
    db $A0, $02 ; volume $02
    db $26, $24 ; note F#2 dur 36
    db $A0, $04 ; volume $04
    db $26, $0C ; note F#2 dur 12
    db $A0, $02 ; volume $02
    db $31, $24 ; note C#3 dur 36
    db $A0, $04 ; volume $04
    db $31, $0C ; note C#3 dur 12
    db $A0, $02 ; volume $02
    db $2B, $24 ; note B2 dur 36
    db $A0, $04 ; volume $04
    db $2B, $0C ; note B2 dur 12
    db $A1, $09 ; duty $09
    db $A2, $20 ; duty2 $20
    db $A0, $02 ; volume $02
    db $35, $0C ; note F3 dur 12
    db $35, $0C ; note F3 dur 12
    db $35, $0C ; note F3 dur 12
    db $33, $0C ; note D#3 dur 12
    db $A0, $04 ; volume $04
    db $33, $0C ; note D#3 dur 12
    db $A0, $02 ; volume $02
    db $32, $0C ; note D3 dur 12
    db $31, $0C ; note C#3 dur 12
    db $30, $0C ; note C3 dur 12
    db $A0, $02 ; volume $02
    db $38, $0C ; note G#3 dur 12
    db $38, $0C ; note G#3 dur 12
    db $38, $0C ; note G#3 dur 12
    db $36, $0C ; note F#3 dur 12
    db $A0, $04 ; volume $04
    db $36, $0C ; note F#3 dur 12
    db $A0, $02 ; volume $02
    db $35, $0C ; note F3 dur 12
    db $34, $0C ; note E3 dur 12
    db $33, $0C ; note D#3 dur 12
    db $A0, $06 ; volume $06
    db $33, $0C ; note D#3 dur 12
    db $1F, $0C ; rest-note $1F dur 12
    db $A0, $02 ; volume $02
    db $A1, $02 ; duty $02
    db $44, $06 ; note E4 dur 6
    db $43, $06 ; note D#4 dur 6
    db $42, $06 ; note D4 dur 6
    db $41, $06 ; note C#4 dur 6
    db $40, $06 ; note C4 dur 6
    db $3B, $06 ; note B3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $39, $06 ; note A3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $34, $06 ; note E3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $32, $06 ; note D3 dur 6
    db $31, $06 ; note C#3 dur 6
    db $30, $06 ; note C3 dur 6
    db $2B, $06 ; note B2 dur 6
    db $2A, $06 ; note A#2 dur 6
    db $29, $06 ; note A2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $27, $06 ; note G2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $24, $06 ; note E2 dur 6
    db $23, $06 ; note D#2 dur 6
    db $22, $06 ; note D2 dur 6
    db $21, $06 ; note C#2 dur 6
    db $A1, $09 ; duty $09
    db $A2, $FF ; duty2 $FF
    db $FD, $F0 ; label 0
    db $23, $0C ; note D#2 dur 12
    db $A0, $04 ; volume $04
    db $23, $0C ; note D#2 dur 12
    db $A0, $02 ; volume $02
    db $1A, $0C ; note A#1 dur 12
    db $22, $0C ; note D2 dur 12
    db $B3, $F0 ; repeat $F0
    db $A1, $0B ; duty $0B
    db $23, $0C ; note D#2 dur 12
    db $A1, $09 ; duty $09
    db $26, $0C ; note F#2 dur 12
    db $A1, $0B ; duty $0B
    db $1A, $0C ; note A#1 dur 12
    db $A1, $09 ; duty $09
    db $26, $0C ; note F#2 dur 12
    db $A1, $0B ; duty $0B
    db $13, $0C ; note D#1 dur 12
    db $A1, $09 ; duty $09
    db $26, $0C ; note F#2 dur 12
    db $A1, $0B ; duty $0B
    db $1A, $0C ; note A#1 dur 12
    db $A1, $09 ; duty $09
    db $26, $0C ; note F#2 dur 12
    db $FD, $F0 ; label 0
    db $A1, $0B ; duty $0B
    db $15, $0C ; note F1 dur 12
    db $A1, $09 ; duty $09
    db $28, $0C ; note G#2 dur 12
    db $A1, $0B ; duty $0B
    db $20, $0C ; note C2 dur 12
    db $A1, $09 ; duty $09
    db $28, $0C ; note G#2 dur 12
    db $B1, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $A1, $0B ; duty $0B
    db $16, $0C ; note F#1 dur 12
    db $A1, $09 ; duty $09
    db $29, $0C ; note A2 dur 12
    db $A1, $0B ; duty $0B
    db $21, $0C ; note C#2 dur 12
    db $A1, $09 ; duty $09
    db $29, $0C ; note A2 dur 12
    db $B1, $F0 ; repeat $F0
    db $A1, $0B ; duty $0B
    db $19, $0C ; note A1 dur 12
    db $A1, $09 ; duty $09
    db $30, $0C ; note C3 dur 12
    db $A1, $0B ; duty $0B
    db $24, $0C ; note E2 dur 12
    db $A1, $09 ; duty $09
    db $30, $0C ; note C3 dur 12
    db $A1, $02 ; duty $02
    db $28, $06 ; note G#2 dur 6
    db $30, $06 ; note C3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $42, $06 ; note D4 dur 6
    db $46, $06 ; note F#4 dur 6
    db $4A, $06 ; note A#4 dur 6
    db $A1, $09 ; duty $09
    db $A2, $10 ; duty2 $10
    db $FD, $F0 ; label 0
    db $2A, $06 ; note A#2 dur 6
    db $2A, $06 ; note A#2 dur 6
    db $A0, $04 ; volume $04
    db $2A, $06 ; note A#2 dur 6
    db $A0, $02 ; volume $02
    db $2A, $06 ; note A#2 dur 6
    db $B3, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $29, $06 ; note A2 dur 6
    db $29, $06 ; note A2 dur 6
    db $A0, $04 ; volume $04
    db $29, $06 ; note A2 dur 6
    db $A0, $02 ; volume $02
    db $29, $06 ; note A2 dur 6
    db $B3, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $28, $06 ; note G#2 dur 6
    db $28, $06 ; note G#2 dur 6
    db $A0, $04 ; volume $04
    db $28, $06 ; note G#2 dur 6
    db $A0, $02 ; volume $02
    db $28, $06 ; note G#2 dur 6
    db $B1, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $27, $06 ; note G2 dur 6
    db $27, $06 ; note G2 dur 6
    db $A0, $04 ; volume $04
    db $27, $06 ; note G2 dur 6
    db $A0, $02 ; volume $02
    db $27, $06 ; note G2 dur 6
    db $B1, $F0 ; repeat $F0
    db $26, $06 ; note F#2 dur 6
    db $26, $06 ; note F#2 dur 6
    db $A0, $04 ; volume $04
    db $26, $06 ; note F#2 dur 6
    db $A0, $02 ; volume $02
    db $26, $06 ; note F#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $25, $06 ; note F2 dur 6
    db $A0, $04 ; volume $04
    db $25, $06 ; note F2 dur 6
    db $A0, $02 ; volume $02
    db $25, $06 ; note F2 dur 6
    db $A1, $02 ; duty $02
    db $A2, $20 ; duty2 $20
    db $24, $06 ; note E2 dur 6
    db $27, $06 ; note G2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $32, $06 ; note D3 dur 6
    db $36, $06 ; note F#3 dur 6
    db $39, $06 ; note A3 dur 6
    db $41, $06 ; note C#4 dur 6
    db $44, $06 ; note E4 dur 6
    db $AF, $01 ; param $01
    db $A2, $30 ; duty2 $30
    db $A0, $02 ; volume $02
    db $A1, $02 ; duty $02
    db $FD, $F0 ; label 0
    db $2A, $06 ; note A#2 dur 6
    db $31, $06 ; note C#3 dur 6
    db $BF, $F0 ; repeat $F0
    db $A2, $10 ; duty2 $10
    db $30, $06 ; note C3 dur 6
    db $30, $06 ; note C3 dur 6
    db $A0, $04 ; volume $04
    db $30, $06 ; note C3 dur 6
    db $A0, $02 ; volume $02
    db $30, $06 ; note C3 dur 6
    db $2B, $06 ; note B2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $A0, $04 ; volume $04
    db $2B, $06 ; note B2 dur 6
    db $A0, $02 ; volume $02
    db $2B, $06 ; note B2 dur 6
    db $2A, $06 ; note A#2 dur 6
    db $2A, $06 ; note A#2 dur 6
    db $A0, $04 ; volume $04
    db $2A, $06 ; note A#2 dur 6
    db $A0, $02 ; volume $02
    db $2A, $06 ; note A#2 dur 6
    db $29, $06 ; note A2 dur 6
    db $29, $06 ; note A2 dur 6
    db $A0, $04 ; volume $04
    db $29, $06 ; note A2 dur 6
    db $A0, $02 ; volume $02
    db $29, $06 ; note A2 dur 6
    db $A2, $FF ; duty2 $FF
    db $28, $48 ; note G#2 dur 72
    db $A0, $04 ; volume $04
    db $28, $18 ; note G#2 dur 24
    db $A2, $10 ; duty2 $10
    db $A0, $02 ; volume $02
    db $FD, $F0 ; label 0
    db $27, $0C ; note G2 dur 12
    db $33, $0C ; note D#3 dur 12
    db $B3, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $24, $0C ; note E2 dur 12
    db $37, $0C ; note G3 dur 12
    db $B3, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $23, $0C ; note D#2 dur 12
    db $34, $0C ; note E3 dur 12
    db $B3, $F0 ; repeat $F0
    db $A2, $30 ; duty2 $30
    db $31, $06 ; note C#3 dur 6
    db $34, $06 ; note E3 dur 6
    db $37, $06 ; note G3 dur 6
    db $41, $06 ; note C#4 dur 6
    db $44, $06 ; note E4 dur 6
    db $47, $06 ; note G4 dur 6
    db $51, $06 ; note C#5 dur 6
    db $54, $06 ; note E5 dur 6
    db $29, $06 ; note A2 dur 6
    db $33, $06 ; note D#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $39, $06 ; note A3 dur 6
    db $41, $06 ; note C#4 dur 6
    db $43, $06 ; note D#4 dur 6
    db $47, $06 ; note G4 dur 6
    db $49, $06 ; note A4 dur 6
    db $A2, $FF ; duty2 $FF
    db $12, $24 ; note D1 dur 36
    db $A0, $04 ; volume $04
    db $12, $0C ; note D1 dur 12
    db $A0, $02 ; volume $02
    db $15, $24 ; note F1 dur 36
    db $A0, $04 ; volume $04
    db $15, $0C ; note F1 dur 12
    db $A0, $02 ; volume $02
    db $18, $24 ; note G#1 dur 36
    db $A0, $04 ; volume $04
    db $18, $0C ; note G#1 dur 12
    db $A0, $02 ; volume $02
    db $17, $24 ; note G1 dur 36
    db $A0, $04 ; volume $04
    db $17, $0C ; note G1 dur 12
    db $A0, $02 ; volume $02
    db $15, $24 ; note F1 dur 36
    db $A0, $04 ; volume $04
    db $15, $0C ; note F1 dur 12
    db $A0, $02 ; volume $02
    db $13, $24 ; note D#1 dur 36
    db $A0, $04 ; volume $04
    db $13, $0C ; note D#1 dur 12
    db $A0, $02 ; volume $02
    db $12, $24 ; note D1 dur 36
    db $A0, $04 ; volume $04
    db $12, $0C ; note D1 dur 12
    db $A0, $02 ; volume $02
    db $11, $24 ; note C#1 dur 36
    db $A0, $04 ; volume $04
    db $11, $0C ; note C#1 dur 12
    db $A0, $02 ; volume $02
    db $12, $A8 ; note D1 dur 168
    db $A0, $04 ; volume $04
    db $12, $18 ; note D1 dur 24
    db $B0, $F3 ; jump $F3
    db $FF, $FF ; end

; sound track, 562 events after the header (E-0019: grammar C2, meaning C0)
Data_040_67EF:: ; heuristic: track stream of a sound record; C0
    db $07, $01, $09, $00 ; header: param=7 byte1=$01 volume=$09 byte3=$00
    db $C2, $3F ; env $3F
    db $A3, $08 ; mod $08
    db $A0, $0A ; volume $0A
    db $35, $06 ; note F3 dur 6
    db $A0, $04 ; volume $04
    db $35, $06 ; note F3 dur 6
    db $A0, $02 ; volume $02
    db $35, $0C ; note F3 dur 12
    db $A0, $0A ; volume $0A
    db $32, $06 ; note D3 dur 6
    db $A0, $04 ; volume $04
    db $32, $06 ; note D3 dur 6
    db $A0, $02 ; volume $02
    db $32, $0C ; note D3 dur 12
    db $A0, $0A ; volume $0A
    db $2B, $06 ; note B2 dur 6
    db $A0, $04 ; volume $04
    db $2B, $06 ; note B2 dur 6
    db $A0, $02 ; volume $02
    db $2B, $0C ; note B2 dur 12
    db $A0, $0A ; volume $0A
    db $29, $06 ; note A2 dur 6
    db $A0, $04 ; volume $04
    db $29, $06 ; note A2 dur 6
    db $A0, $02 ; volume $02
    db $29, $0C ; note A2 dur 12
    db $A0, $0E ; volume $0E
    db $25, $06 ; note F2 dur 6
    db $A0, $04 ; volume $04
    db $25, $06 ; note F2 dur 6
    db $A0, $02 ; volume $02
    db $25, $0C ; note F2 dur 12
    db $A0, $0E ; volume $0E
    db $22, $06 ; note D2 dur 6
    db $A0, $04 ; volume $04
    db $22, $06 ; note D2 dur 6
    db $A0, $02 ; volume $02
    db $22, $0C ; note D2 dur 12
    db $A0, $0E ; volume $0E
    db $25, $06 ; note F2 dur 6
    db $A0, $04 ; volume $04
    db $25, $06 ; note F2 dur 6
    db $A0, $02 ; volume $02
    db $25, $0C ; note F2 dur 12
    db $1F, $0C ; rest-note $1F dur 12
    db $A2, $02 ; duty2 $02
    db $C1, $7F ; env $7F
    db $A0, $05 ; volume $05
    db $37, $0C ; note G3 dur 12
    db $FD, $F3 ; label 3
    db $AC, $01 ; call x1
    dw $02B4 ; byte offset of the called section from the track start
    db $A0, $08 ; volume $08
    db $A3, $FE ; mod $FE
    db $24, $0C ; note E2 dur 12
    db $A0, $0A ; volume $0A
    db $C3, $60 ; env $60
    db $29, $0C ; note A2 dur 12
    db $25, $0C ; note F2 dur 12
    db $27, $0C ; note G2 dur 12
    db $A0, $07 ; volume $07
    db $C0, $FE ; env $FE
    db $24, $0C ; note E2 dur 12
    db $A0, $04 ; volume $04
    db $C1, $7F ; env $7F
    db $24, $24 ; note E2 dur 36
    db $A2, $00 ; duty2 $00
    db $C0, $FE ; env $FE
    db $A3, $FE ; mod $FE
    db $A0, $07 ; volume $07
    db $29, $20 ; note A2 dur 32
    db $C1, $5F ; env $5F
    db $A3, $00 ; mod $00
    db $A0, $06 ; volume $06
    db $29, $10 ; note A2 dur 16
    db $A3, $08 ; mod $08
    db $C0, $FE ; env $FE
    db $A0, $07 ; volume $07
    db $28, $18 ; note G#2 dur 24
    db $30, $0C ; note C3 dur 12
    db $32, $0C ; note D3 dur 12
    db $A3, $FE ; mod $FE
    db $30, $0C ; note C3 dur 12
    db $32, $0C ; note D3 dur 12
    db $34, $18 ; note E3 dur 24
    db $30, $18 ; note C3 dur 24
    db $24, $18 ; note E2 dur 24
    db $25, $24 ; note F2 dur 36
    db $C1, $5F ; env $5F
    db $A3, $00 ; mod $00
    db $A0, $06 ; volume $06
    db $25, $0C ; note F2 dur 12
    db $A3, $08 ; mod $08
    db $C0, $FE ; env $FE
    db $A0, $07 ; volume $07
    db $28, $18 ; note G#2 dur 24
    db $30, $0C ; note C3 dur 12
    db $32, $0C ; note D3 dur 12
    db $30, $0C ; note C3 dur 12
    db $32, $0C ; note D3 dur 12
    db $A0, $08 ; volume $08
    db $A3, $FE ; mod $FE
    db $C0, $FE ; env $FE
    db $A0, $07 ; volume $07
    db $34, $20 ; note E3 dur 32
    db $C1, $7F ; env $7F
    db $A3, $00 ; mod $00
    db $A0, $05 ; volume $05
    db $34, $10 ; note E3 dur 16
    db $A3, $FE ; mod $FE
    db $C0, $FE ; env $FE
    db $A0, $08 ; volume $08
    db $34, $18 ; note E3 dur 24
    db $32, $1C ; note D3 dur 28
    db $C1, $7F ; env $7F
    db $A3, $00 ; mod $00
    db $A0, $06 ; volume $06
    db $32, $14 ; note D3 dur 20
    db $A0, $08 ; volume $08
    db $A3, $0C ; mod $0C
    db $C0, $FE ; env $FE
    db $A3, $08 ; mod $08
    db $32, $18 ; note D3 dur 24
    db $34, $0C ; note E3 dur 12
    db $36, $0C ; note F#3 dur 12
    db $A0, $08 ; volume $08
    db $A3, $0C ; mod $0C
    db $C0, $FE ; env $FE
    db $37, $18 ; note G3 dur 24
    db $39, $18 ; note A3 dur 24
    db $3B, $18 ; note B3 dur 24
    db $40, $18 ; note C4 dur 24
    db $A3, $08 ; mod $08
    db $A0, $0B ; volume $0B
    db $C3, $68 ; env $68
    db $39, $0C ; note A3 dur 12
    db $37, $0C ; note G3 dur 12
    db $35, $0C ; note F3 dur 12
    db $34, $0C ; note E3 dur 12
    db $32, $0C ; note D3 dur 12
    db $30, $0C ; note C3 dur 12
    db $2B, $0C ; note B2 dur 12
    db $29, $0C ; note A2 dur 12
    db $A3, $FE ; mod $FE
    db $A0, $09 ; volume $09
    db $C0, $FE ; env $FE
    db $27, $30 ; note G2 dur 48
    db $A3, $08 ; mod $08
    db $25, $0C ; note F2 dur 12
    db $C1, $5F ; env $5F
    db $A0, $06 ; volume $06
    db $25, $18 ; note F2 dur 24
    db $A2, $02 ; duty2 $02
    db $37, $0C ; note G3 dur 12
    db $AC, $01 ; call x1
    dw $02B4 ; byte offset of the called section from the track start
    db $A0, $08 ; volume $08
    db $A3, $FE ; mod $FE
    db $24, $0C ; note E2 dur 12
    db $A0, $0A ; volume $0A
    db $C3, $60 ; env $60
    db $29, $0C ; note A2 dur 12
    db $25, $0C ; note F2 dur 12
    db $27, $0C ; note G2 dur 12
    db $A0, $07 ; volume $07
    db $C0, $FE ; env $FE
    db $24, $0C ; note E2 dur 12
    db $C1, $5F ; env $5F
    db $A0, $04 ; volume $04
    db $24, $18 ; note E2 dur 24
    db $A2, $02 ; duty2 $02
    db $A3, $06 ; mod $06
    db $A0, $04 ; volume $04
    db $1A, $0C ; note A#1 dur 12
    db $A0, $06 ; volume $06
    db $A2, $01 ; duty2 $01
    db $C1, $7F ; env $7F
    db $FD, $F0 ; label 0
    db $37, $06 ; note G3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $43, $06 ; note D#4 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $B1, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $37, $06 ; note G3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $42, $06 ; note D4 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $B1, $F0 ; repeat $F0
    db $37, $06 ; note G3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $43, $06 ; note D#4 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $40, $06 ; note C4 dur 6
    db $38, $06 ; note G#3 dur 6
    db $40, $06 ; note C4 dur 6
    db $43, $06 ; note D#4 dur 6
    db $40, $06 ; note C4 dur 6
    db $38, $06 ; note G#3 dur 6
    db $40, $06 ; note C4 dur 6
    db $37, $06 ; note G3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $42, $06 ; note D4 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $34, $06 ; note E3 dur 6
    db $37, $06 ; note G3 dur 6
    db $34, $06 ; note E3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $34, $06 ; note E3 dur 6
    db $37, $06 ; note G3 dur 6
    db $FD, $F0 ; label 0
    db $33, $06 ; note D#3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $3B, $06 ; note B3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $B1, $F0 ; repeat $F0
    db $37, $06 ; note G3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $43, $06 ; note D#4 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $44, $06 ; note E4 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $40, $06 ; note C4 dur 6
    db $38, $06 ; note G#3 dur 6
    db $40, $06 ; note C4 dur 6
    db $43, $06 ; note D#4 dur 6
    db $40, $06 ; note C4 dur 6
    db $38, $06 ; note G#3 dur 6
    db $40, $06 ; note C4 dur 6
    db $38, $06 ; note G#3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $42, $06 ; note D4 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $2A, $06 ; note A#2 dur 6
    db $27, $06 ; note G2 dur 6
    db $A0, $07 ; volume $07
    db $23, $06 ; note D#2 dur 6
    db $1A, $06 ; note A#1 dur 6
    db $17, $06 ; note G1 dur 6
    db $13, $06 ; note D#1 dur 6
    db $AC, $01 ; call x1
    dw $0340 ; byte offset of the called section from the track start
    db $37, $06 ; note G3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $A0, $07 ; volume $07
    db $37, $06 ; note G3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $35, $06 ; note F3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $2A, $06 ; note A#2 dur 6
    db $27, $06 ; note G2 dur 6
    db $A0, $08 ; volume $08
    db $23, $06 ; note D#2 dur 6
    db $1A, $06 ; note A#1 dur 6
    db $17, $06 ; note G1 dur 6
    db $13, $06 ; note D#1 dur 6
    db $AC, $01 ; call x1
    dw $0340 ; byte offset of the called section from the track start
    db $40, $06 ; note C4 dur 6
    db $39, $06 ; note A3 dur 6
    db $35, $06 ; note F3 dur 6
    db $32, $06 ; note D3 dur 6
    db $30, $06 ; note C3 dur 6
    db $32, $06 ; note D3 dur 6
    db $35, $06 ; note F3 dur 6
    db $39, $06 ; note A3 dur 6
    db $40, $06 ; note C4 dur 6
    db $39, $06 ; note A3 dur 6
    db $35, $06 ; note F3 dur 6
    db $32, $06 ; note D3 dur 6
    db $30, $06 ; note C3 dur 6
    db $32, $06 ; note D3 dur 6
    db $35, $06 ; note F3 dur 6
    db $32, $06 ; note D3 dur 6
    db $2B, $06 ; note B2 dur 6
    db $32, $06 ; note D3 dur 6
    db $35, $06 ; note F3 dur 6
    db $39, $06 ; note A3 dur 6
    db $3B, $06 ; note B3 dur 6
    db $39, $06 ; note A3 dur 6
    db $A0, $05 ; volume $05
    db $35, $06 ; note F3 dur 6
    db $32, $06 ; note D3 dur 6
    db $2B, $0C ; note B2 dur 12
    db $C1, $4F ; env $4F
    db $A0, $06 ; volume $06
    db $2B, $18 ; note B2 dur 24
    db $A2, $02 ; duty2 $02
    db $A0, $05 ; volume $05
    db $37, $0C ; note G3 dur 12
    db $B0, $F3 ; jump $F3
    db $FF, $FF ; end
    db $A3, $08 ; mod $08
    db $39, $0C ; note A3 dur 12
    db $A2, $00 ; duty2 $00
    db $C1, $7F ; env $7F
    db $FD, $F0 ; label 0
    db $A0, $0A ; volume $0A
    db $24, $12 ; note E2 dur 18
    db $A0, $05 ; volume $05
    db $24, $06 ; note E2 dur 6
    db $A0, $0A ; volume $0A
    db $24, $12 ; note E2 dur 18
    db $A0, $04 ; volume $04
    db $24, $06 ; note E2 dur 6
    db $B3, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $A0, $0A ; volume $0A
    db $29, $12 ; note A2 dur 18
    db $A0, $04 ; volume $04
    db $29, $06 ; note A2 dur 6
    db $B2, $F0 ; repeat $F0
    db $A0, $0A ; volume $0A
    db $20, $12 ; note C2 dur 18
    db $A0, $04 ; volume $04
    db $20, $06 ; note C2 dur 6
    db $A0, $0B ; volume $0B
    db $27, $12 ; note G2 dur 18
    db $A0, $05 ; volume $05
    db $27, $06 ; note G2 dur 6
    db $A0, $0A ; volume $0A
    db $27, $12 ; note G2 dur 18
    db $A0, $05 ; volume $05
    db $27, $06 ; note G2 dur 6
    db $A0, $0B ; volume $0B
    db $27, $12 ; note G2 dur 18
    db $A0, $05 ; volume $05
    db $27, $06 ; note G2 dur 6
    db $A0, $09 ; volume $09
    db $21, $12 ; note C#2 dur 18
    db $A0, $03 ; volume $03
    db $21, $06 ; note C#2 dur 6
    db $FD, $F0 ; label 0
    db $A0, $0B ; volume $0B
    db $28, $12 ; note G#2 dur 18
    db $A0, $04 ; volume $04
    db $28, $06 ; note G#2 dur 6
    db $A0, $0B ; volume $0B
    db $28, $12 ; note G#2 dur 18
    db $A0, $04 ; volume $04
    db $28, $06 ; note G#2 dur 6
    db $B1, $F0 ; repeat $F0
    db $A0, $0B ; volume $0B
    db $27, $18 ; note G2 dur 24
    db $A0, $0A ; volume $0A
    db $29, $0C ; note A2 dur 12
    db $27, $0C ; note G2 dur 12
    db $24, $0C ; note E2 dur 12
    db $21, $0C ; note C#2 dur 12
    db $27, $0C ; note G2 dur 12
    db $C0, $FE ; env $FE
    db $A0, $08 ; volume $08
    db $25, $20 ; note F2 dur 32
    db $C1, $7F ; env $7F
    db $A0, $06 ; volume $06
    db $25, $10 ; note F2 dur 16
    db $C1, $70 ; env $70
    db $A0, $0A ; volume $0A
    db $29, $18 ; note A2 dur 24
    db $A0, $0B ; volume $0B
    db $2B, $18 ; note B2 dur 24
    db $AD, $00 ; return $00
    db $FD, $F1 ; label 1
    db $FD, $F0 ; label 0
    db $A0, $0C ; volume $0C
    db $C1, $40 ; env $40
    db $18, $0C ; note G#1 dur 12
    db $C1, $4F ; env $4F
    db $18, $24 ; note G#1 dur 36
    db $B1, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $A0, $09 ; volume $09
    db $C1, $40 ; env $40
    db $23, $0C ; note D#2 dur 12
    db $C1, $4F ; env $4F
    db $23, $24 ; note D#2 dur 36
    db $B1, $F0 ; repeat $F0
    db $B1, $F1 ; repeat $F1
    db $FD, $F0 ; label 0
    db $A0, $09 ; volume $09
    db $C1, $40 ; env $40
    db $23, $0C ; note D#2 dur 12
    db $C1, $4F ; env $4F
    db $23, $24 ; note D#2 dur 36
    db $B1, $F0 ; repeat $F0
    db $C0, $FE ; env $FE
    db $A0, $08 ; volume $08
    db $1A, $18 ; note A#1 dur 24
    db $20, $18 ; note C2 dur 24
    db $22, $18 ; note D2 dur 24
    db $23, $18 ; note D#2 dur 24
    db $C3, $48 ; env $48
    db $A0, $0D ; volume $0D
    db $30, $0C ; note C3 dur 12
    db $2A, $0C ; note A#2 dur 12
    db $28, $0C ; note G#2 dur 12
    db $27, $0C ; note G2 dur 12
    db $25, $0C ; note F2 dur 12
    db $23, $0C ; note D#2 dur 12
    db $22, $0C ; note D2 dur 12
    db $20, $0C ; note C2 dur 12
    db $A0, $0F ; volume $0F
    db $1A, $12 ; note A#1 dur 18
    db $20, $0F ; note C2 dur 15
    db $A0, $0C ; volume $0C
    db $21, $0F ; note C#2 dur 15
    db $A0, $0A ; volume $0A
    db $22, $0C ; note D2 dur 12
    db $C1, $7F ; env $7F
    db $A0, $06 ; volume $06
    db $22, $18 ; note D2 dur 24
    db $A2, $01 ; duty2 $01
    db $C0, $FE ; env $FE
    db $A0, $03 ; volume $03
    db $2A, $0C ; note A#2 dur 12
    db $A2, $01 ; duty2 $01
    db $C1, $7F ; env $7F
    db $FD, $F0 ; label 0
    db $A0, $02 ; volume $02
    db $37, $06 ; note G3 dur 6
    db $A0, $06 ; volume $06
    db $3A, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $43, $06 ; note D#4 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $B1, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $37, $06 ; note G3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $42, $06 ; note D4 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $B1, $F0 ; repeat $F0
    db $37, $06 ; note G3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $43, $06 ; note D#4 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $40, $06 ; note C4 dur 6
    db $38, $06 ; note G#3 dur 6
    db $40, $06 ; note C4 dur 6
    db $43, $06 ; note D#4 dur 6
    db $40, $06 ; note C4 dur 6
    db $38, $06 ; note G#3 dur 6
    db $40, $06 ; note C4 dur 6
    db $37, $06 ; note G3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $42, $06 ; note D4 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $34, $06 ; note E3 dur 6
    db $37, $06 ; note G3 dur 6
    db $34, $06 ; note E3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $34, $06 ; note E3 dur 6
    db $37, $06 ; note G3 dur 6
    db $FD, $F0 ; label 0
    db $33, $06 ; note D#3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $3B, $06 ; note B3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $B1, $F0 ; repeat $F0
    db $1F, $06 ; rest-note $1F dur 6
    db $3A, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $43, $06 ; note D#4 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $44, $06 ; note E4 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $37, $06 ; note G3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $40, $06 ; note C4 dur 6
    db $38, $06 ; note G#3 dur 6
    db $40, $06 ; note C4 dur 6
    db $43, $06 ; note D#4 dur 6
    db $40, $06 ; note C4 dur 6
    db $38, $06 ; note G#3 dur 6
    db $40, $06 ; note C4 dur 6
    db $38, $06 ; note G#3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $42, $06 ; note D4 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $38, $06 ; note G#3 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $AD, $00 ; return $00

; sound track, 554 events after the header (E-0019: grammar C2, meaning C0)
Data_040_6C5F:: ; heuristic: track stream of a sound record; C0
    db $07, $00, $09, $00 ; header: param=7 byte1=$00 volume=$09 byte3=$00
    db $A3, $0E ; mod $0E
    db $C2, $3F ; env $3F
    db $A0, $0D ; volume $0D
    db $40, $06 ; note C4 dur 6
    db $A0, $05 ; volume $05
    db $40, $06 ; note C4 dur 6
    db $A0, $03 ; volume $03
    db $40, $06 ; note C4 dur 6
    db $A0, $01 ; volume $01
    db $40, $06 ; note C4 dur 6
    db $A0, $0D ; volume $0D
    db $39, $06 ; note A3 dur 6
    db $A0, $05 ; volume $05
    db $39, $06 ; note A3 dur 6
    db $A0, $03 ; volume $03
    db $39, $06 ; note A3 dur 6
    db $A0, $01 ; volume $01
    db $39, $06 ; note A3 dur 6
    db $A0, $0D ; volume $0D
    db $35, $06 ; note F3 dur 6
    db $A0, $05 ; volume $05
    db $35, $06 ; note F3 dur 6
    db $A0, $03 ; volume $03
    db $35, $06 ; note F3 dur 6
    db $A0, $01 ; volume $01
    db $35, $06 ; note F3 dur 6
    db $A0, $0D ; volume $0D
    db $32, $06 ; note D3 dur 6
    db $A0, $05 ; volume $05
    db $32, $06 ; note D3 dur 6
    db $A0, $03 ; volume $03
    db $32, $06 ; note D3 dur 6
    db $A0, $01 ; volume $01
    db $32, $06 ; note D3 dur 6
    db $A0, $0D ; volume $0D
    db $2B, $06 ; note B2 dur 6
    db $A0, $05 ; volume $05
    db $2B, $06 ; note B2 dur 6
    db $A0, $03 ; volume $03
    db $2B, $06 ; note B2 dur 6
    db $A0, $01 ; volume $01
    db $2B, $06 ; note B2 dur 6
    db $A0, $0D ; volume $0D
    db $29, $06 ; note A2 dur 6
    db $A0, $05 ; volume $05
    db $29, $06 ; note A2 dur 6
    db $A0, $03 ; volume $03
    db $29, $06 ; note A2 dur 6
    db $A0, $01 ; volume $01
    db $29, $06 ; note A2 dur 6
    db $A0, $0D ; volume $0D
    db $27, $06 ; note G2 dur 6
    db $A0, $05 ; volume $05
    db $27, $06 ; note G2 dur 6
    db $A0, $03 ; volume $03
    db $27, $06 ; note G2 dur 6
    db $A0, $01 ; volume $01
    db $27, $06 ; note G2 dur 6
    db $A2, $02 ; duty2 $02
    db $C0, $FE ; env $FE
    db $A0, $0C ; volume $0C
    db $37, $0C ; note G3 dur 12
    db $39, $0C ; note A3 dur 12
    db $FD, $F3 ; label 3
    db $A3, $0E ; mod $0E
    db $AC, $01 ; call x1
    dw $0242 ; byte offset of the called section from the track start
    db $C0, $FE ; env $FE
    db $A0, $0A ; volume $0A
    db $A3, $FE ; mod $FE
    db $30, $30 ; note C3 dur 48
    db $C1, $7F ; env $7F
    db $A3, $08 ; mod $08
    db $A0, $06 ; volume $06
    db $30, $18 ; note C3 dur 24
    db $A3, $0C ; mod $0C
    db $A2, $01 ; duty2 $01
    db $C0, $FE ; env $FE
    db $A0, $0A ; volume $0A
    db $30, $18 ; note C3 dur 24
    db $A3, $FE ; mod $FE
    db $32, $20 ; note D3 dur 32
    db $C1, $7F ; env $7F
    db $A3, $08 ; mod $08
    db $A0, $07 ; volume $07
    db $32, $10 ; note D3 dur 16
    db $A3, $08 ; mod $08
    db $C0, $FE ; env $FE
    db $A0, $0A ; volume $0A
    db $32, $18 ; note D3 dur 24
    db $34, $0C ; note E3 dur 12
    db $35, $0C ; note F3 dur 12
    db $A3, $FE ; mod $FE
    db $34, $0C ; note E3 dur 12
    db $35, $0C ; note F3 dur 12
    db $37, $18 ; note G3 dur 24
    db $34, $18 ; note E3 dur 24
    db $30, $18 ; note C3 dur 24
    db $A3, $08 ; mod $08
    db $32, $24 ; note D3 dur 36
    db $C1, $5F ; env $5F
    db $A3, $08 ; mod $08
    db $A0, $08 ; volume $08
    db $32, $0C ; note D3 dur 12
    db $A3, $08 ; mod $08
    db $C0, $FE ; env $FE
    db $A0, $0A ; volume $0A
    db $32, $18 ; note D3 dur 24
    db $34, $0C ; note E3 dur 12
    db $35, $0C ; note F3 dur 12
    db $34, $0C ; note E3 dur 12
    db $35, $0C ; note F3 dur 12
    db $C0, $FE ; env $FE
    db $A0, $09 ; volume $09
    db $A3, $FE ; mod $FE
    db $37, $20 ; note G3 dur 32
    db $C1, $7F ; env $7F
    db $A0, $07 ; volume $07
    db $A3, $08 ; mod $08
    db $37, $10 ; note G3 dur 16
    db $A3, $08 ; mod $08
    db $C0, $FE ; env $FE
    db $A0, $0A ; volume $0A
    db $37, $18 ; note G3 dur 24
    db $A3, $FE ; mod $FE
    db $36, $1C ; note F#3 dur 28
    db $C1, $7F ; env $7F
    db $A0, $08 ; volume $08
    db $A3, $08 ; mod $08
    db $36, $14 ; note F#3 dur 20
    db $A3, $08 ; mod $08
    db $A0, $0A ; volume $0A
    db $C0, $FE ; env $FE
    db $36, $18 ; note F#3 dur 24
    db $37, $0C ; note G3 dur 12
    db $39, $0C ; note A3 dur 12
    db $A3, $0F ; mod $0F
    db $3B, $18 ; note B3 dur 24
    db $40, $18 ; note C4 dur 24
    db $42, $18 ; note D4 dur 24
    db $44, $18 ; note E4 dur 24
    db $45, $0C ; note F4 dur 12
    db $44, $0C ; note E4 dur 12
    db $42, $0C ; note D4 dur 12
    db $40, $0C ; note C4 dur 12
    db $3B, $0C ; note B3 dur 12
    db $39, $0C ; note A3 dur 12
    db $37, $0C ; note G3 dur 12
    db $35, $0C ; note F3 dur 12
    db $A3, $08 ; mod $08
    db $34, $30 ; note E3 dur 48
    db $32, $0C ; note D3 dur 12
    db $C1, $7F ; env $7F
    db $A3, $00 ; mod $00
    db $A0, $06 ; volume $06
    db $32, $0C ; note D3 dur 12
    db $C0, $FE ; env $FE
    db $A2, $02 ; duty2 $02
    db $A3, $0C ; mod $0C
    db $A0, $0D ; volume $0D
    db $37, $0C ; note G3 dur 12
    db $39, $0C ; note A3 dur 12
    db $AC, $01 ; call x1
    dw $0242 ; byte offset of the called section from the track start
    db $C0, $FE ; env $FE
    db $A0, $0A ; volume $0A
    db $A3, $FE ; mod $FE
    db $30, $30 ; note C3 dur 48
    db $C1, $7F ; env $7F
    db $A3, $08 ; mod $08
    db $A0, $06 ; volume $06
    db $30, $18 ; note C3 dur 24
    db $A3, $26 ; mod $26
    db $A0, $0F ; volume $0F
    db $C3, $02 ; env $02
    db $1A, $0C ; note A#1 dur 12
    db $20, $0C ; note C2 dur 12
    db $27, $18 ; note G2 dur 24
    db $25, $0C ; note F2 dur 12
    db $23, $0C ; note D#2 dur 12
    db $27, $18 ; note G2 dur 24
    db $25, $0C ; note F2 dur 12
    db $23, $0C ; note D#2 dur 12
    db $22, $40 ; note D2 dur 64
    db $C1, $7F ; env $7F
    db $A3, $00 ; mod $00
    db $A0, $0A ; volume $0A
    db $22, $08 ; note D2 dur 8
    db $C3, $02 ; env $02
    db $A3, $26 ; mod $26
    db $A0, $0D ; volume $0D
    db $23, $0C ; note D#2 dur 12
    db $22, $0C ; note D2 dur 12
    db $20, $18 ; note C2 dur 24
    db $22, $0C ; note D2 dur 12
    db $23, $0C ; note D#2 dur 12
    db $18, $18 ; note G#1 dur 24
    db $1A, $0C ; note A#1 dur 12
    db $20, $0C ; note C2 dur 12
    db $1A, $0C ; note A#1 dur 12
    db $20, $0C ; note C2 dur 12
    db $17, $28 ; note G1 dur 40
    db $C1, $5F ; env $5F
    db $A3, $20 ; mod $20
    db $A0, $0A ; volume $0A
    db $17, $14 ; note G1 dur 20
    db $A3, $26 ; mod $26
    db $C3, $02 ; env $02
    db $A0, $0C ; volume $0C
    db $17, $0A ; note G1 dur 10
    db $C1, $7F ; env $7F
    db $A0, $08 ; volume $08
    db $17, $02 ; note G1 dur 2
    db $C3, $12 ; env $12
    db $A0, $0D ; volume $0D
    db $17, $0C ; note G1 dur 12
    db $15, $0C ; note F1 dur 12
    db $23, $28 ; note D#2 dur 40
    db $A0, $0A ; volume $0A
    db $C1, $7F ; env $7F
    db $A3, $20 ; mod $20
    db $23, $08 ; note D#2 dur 8
    db $A3, $26 ; mod $26
    db $C3, $48 ; env $48
    db $A0, $0F ; volume $0F
    db $21, $0C ; note C#2 dur 12
    db $1B, $0C ; note B1 dur 12
    db $1A, $0C ; note A#1 dur 12
    db $20, $0C ; note C2 dur 12
    db $22, $0C ; note D2 dur 12
    db $23, $0C ; note D#2 dur 12
    db $27, $0C ; note G2 dur 12
    db $2A, $0C ; note A#2 dur 12
    db $30, $0C ; note C3 dur 12
    db $37, $0A ; note G3 dur 10
    db $C1, $7F ; env $7F
    db $A0, $08 ; volume $08
    db $37, $02 ; note G3 dur 2
    db $C3, $48 ; env $48
    db $A0, $0D ; volume $0D
    db $A3, $06 ; mod $06
    db $37, $0C ; note G3 dur 12
    db $38, $0C ; note G#3 dur 12
    db $C0, $FE ; env $FE
    db $A0, $0A ; volume $0A
    db $A3, $FE ; mod $FE
    db $30, $18 ; note C3 dur 24
    db $33, $18 ; note D#3 dur 24
    db $35, $18 ; note F3 dur 24
    db $33, $38 ; note D#3 dur 56
    db $C1, $7F ; env $7F
    db $A3, $00 ; mod $00
    db $A0, $06 ; volume $06
    db $33, $10 ; note D#3 dur 16
    db $A2, $02 ; duty2 $02
    db $A0, $0F ; volume $0F
    db $A3, $09 ; mod $09
    db $C3, $58 ; env $58
    db $23, $18 ; note D#2 dur 24
    db $AC, $01 ; call x1
    dw $02EE ; byte offset of the called section from the track start
    db $C3, $7F ; env $7F
    db $23, $3C ; note D#2 dur 60
    db $C1, $7F ; env $7F
    db $A3, $00 ; mod $00
    db $A0, $06 ; volume $06
    db $23, $0C ; note D#2 dur 12
    db $A2, $02 ; duty2 $02
    db $A0, $0F ; volume $0F
    db $A3, $09 ; mod $09
    db $C3, $58 ; env $58
    db $23, $18 ; note D#2 dur 24
    db $AC, $01 ; call x1
    dw $02EE ; byte offset of the called section from the track start
    db $A3, $FE ; mod $FE
    db $C3, $78 ; env $78
    db $A0, $0D ; volume $0D
    db $27, $90 ; note G2 dur 144
    db $C1, $7F ; env $7F
    db $A0, $08 ; volume $08
    db $27, $18 ; note G2 dur 24
    db $A2, $02 ; duty2 $02
    db $A0, $0D ; volume $0D
    db $37, $0C ; note G3 dur 12
    db $39, $0C ; note A3 dur 12
    db $B0, $F3 ; jump $F3
    db $FF, $FF ; end
    db $A0, $0D ; volume $0D
    db $44, $18 ; note E4 dur 24
    db $A0, $0C ; volume $0C
    db $42, $0C ; note D4 dur 12
    db $40, $0C ; note C4 dur 12
    db $44, $18 ; note E4 dur 24
    db $42, $0C ; note D4 dur 12
    db $40, $0C ; note C4 dur 12
    db $A3, $FE ; mod $FE
    db $C0, $FE ; env $FE
    db $A0, $0B ; volume $0B
    db $3B, $40 ; note B3 dur 64
    db $C1, $50 ; env $50
    db $A3, $00 ; mod $00
    db $A0, $05 ; volume $05
    db $3B, $08 ; note B3 dur 8
    db $C0, $FE ; env $FE
    db $A3, $0F ; mod $0F
    db $A0, $0C ; volume $0C
    db $40, $0C ; note C4 dur 12
    db $3B, $0C ; note B3 dur 12
    db $A0, $0B ; volume $0B
    db $39, $18 ; note A3 dur 24
    db $A0, $0A ; volume $0A
    db $3B, $0C ; note B3 dur 12
    db $40, $0C ; note C4 dur 12
    db $A0, $09 ; volume $09
    db $35, $18 ; note F3 dur 24
    db $37, $0C ; note G3 dur 12
    db $39, $0C ; note A3 dur 12
    db $A0, $0A ; volume $0A
    db $37, $0C ; note G3 dur 12
    db $39, $0C ; note A3 dur 12
    db $A0, $08 ; volume $08
    db $A3, $FE ; mod $FE
    db $34, $30 ; note E3 dur 48
    db $A3, $00 ; mod $00
    db $C1, $5F ; env $5F
    db $A0, $05 ; volume $05
    db $34, $0C ; note E3 dur 12
    db $A3, $00 ; mod $00
    db $C1, $50 ; env $50
    db $A0, $0A ; volume $0A
    db $34, $0C ; note E3 dur 12
    db $A3, $0C ; mod $0C
    db $C1, $7F ; env $7F
    db $34, $0C ; note E3 dur 12
    db $32, $0C ; note D3 dur 12
    db $A3, $FE ; mod $FE
    db $C0, $FE ; env $FE
    db $A0, $0A ; volume $0A
    db $40, $24 ; note C4 dur 36
    db $A3, $02 ; mod $02
    db $C1, $7F ; env $7F
    db $A0, $06 ; volume $06
    db $40, $0C ; note C4 dur 12
    db $C0, $FE ; env $FE
    db $A3, $0F ; mod $0F
    db $A0, $0A ; volume $0A
    db $3A, $0C ; note A#3 dur 12
    db $38, $0C ; note G#3 dur 12
    db $A0, $0B ; volume $0B
    db $37, $0C ; note G3 dur 12
    db $39, $0C ; note A3 dur 12
    db $A0, $0C ; volume $0C
    db $3B, $0C ; note B3 dur 12
    db $40, $0C ; note C4 dur 12
    db $C0, $FE ; env $FE
    db $A3, $FE ; mod $FE
    db $44, $18 ; note E4 dur 24
    db $C1, $7F ; env $7F
    db $A3, $00 ; mod $00
    db $A0, $06 ; volume $06
    db $44, $0C ; note E4 dur 12
    db $A3, $0F ; mod $0F
    db $C1, $6F ; env $6F
    db $A0, $09 ; volume $09
    db $34, $0C ; note E3 dur 12
    db $C1, $7F ; env $7F
    db $A0, $0C ; volume $0C
    db $34, $0C ; note E3 dur 12
    db $35, $0C ; note F3 dur 12
    db $29, $18 ; note A2 dur 24
    db $30, $18 ; note C3 dur 24
    db $32, $18 ; note D3 dur 24
    db $AD, $00 ; return $00
    db $A2, $02 ; duty2 $02
    db $A3, $09 ; mod $09
    db $C0, $FE ; env $FE
    db $A0, $0C ; volume $0C
    db $25, $28 ; note F2 dur 40
    db $C1, $40 ; env $40
    db $A3, $00 ; mod $00
    db $A0, $08 ; volume $08
    db $25, $08 ; note F2 dur 8
    db $A3, $09 ; mod $09
    db $C3, $68 ; env $68
    db $A0, $0F ; volume $0F
    db $25, $18 ; note F2 dur 24
    db $27, $0C ; note G2 dur 12
    db $28, $0C ; note G#2 dur 12
    db $27, $0C ; note G2 dur 12
    db $28, $0C ; note G#2 dur 12
    db $C0, $FE ; env $FE
    db $A0, $0C ; volume $0C
    db $A3, $0F ; mod $0F
    db $2A, $18 ; note A#2 dur 24
    db $27, $18 ; note G2 dur 24
    db $23, $18 ; note D#2 dur 24
    db $A3, $0B ; mod $0B
    db $C0, $FE ; env $FE
    db $A0, $0C ; volume $0C
    db $25, $26 ; note F2 dur 38
    db $C1, $7F ; env $7F
    db $A3, $00 ; mod $00
    db $A0, $06 ; volume $06
    db $25, $0A ; note F2 dur 10
    db $A3, $09 ; mod $09
    db $C3, $68 ; env $68
    db $A0, $0F ; volume $0F
    db $25, $18 ; note F2 dur 24
    db $27, $0C ; note G2 dur 12
    db $28, $0C ; note G#2 dur 12
    db $27, $0C ; note G2 dur 12
    db $28, $0C ; note G#2 dur 12
    db $A3, $FE ; mod $FE
    db $C0, $FE ; env $FE
    db $A0, $0A ; volume $0A
    db $2A, $24 ; note A#2 dur 36
    db $C1, $7F ; env $7F
    db $A3, $00 ; mod $00
    db $A0, $06 ; volume $06
    db $2A, $0C ; note A#2 dur 12
    db $C3, $58 ; env $58
    db $A3, $09 ; mod $09
    db $A0, $0F ; volume $0F
    db $2A, $18 ; note A#2 dur 24
    db $A3, $0B ; mod $0B
    db $C0, $FE ; env $FE
    db $A0, $0C ; volume $0C
    db $29, $26 ; note A2 dur 38
    db $C1, $70 ; env $70
    db $A3, $00 ; mod $00
    db $A0, $08 ; volume $08
    db $29, $0A ; note A2 dur 10
    db $C3, $60 ; env $60
    db $A3, $09 ; mod $09
    db $A0, $0F ; volume $0F
    db $29, $18 ; note A2 dur 24
    db $2A, $0C ; note A#2 dur 12
    db $30, $0C ; note C3 dur 12
    db $C4, $50 ; env $50
    db $32, $06 ; note D3 dur 6
    db $30, $06 ; note C3 dur 6
    db $28, $06 ; note G#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $33, $06 ; note D#3 dur 6
    db $30, $06 ; note C3 dur 6
    db $28, $06 ; note G#2 dur 6
    db $25, $06 ; note F2 dur 6
    db $35, $06 ; note F3 dur 6
    db $32, $06 ; note D3 dur 6
    db $30, $06 ; note C3 dur 6
    db $28, $06 ; note G#2 dur 6
    db $37, $06 ; note G3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $2A, $06 ; note A#2 dur 6
    db $27, $06 ; note G2 dur 6
    db $C3, $68 ; env $68
    db $38, $0C ; note G#3 dur 12
    db $37, $0C ; note G3 dur 12
    db $35, $0C ; note F3 dur 12
    db $33, $0C ; note D#3 dur 12
    db $32, $0C ; note D3 dur 12
    db $30, $0C ; note C3 dur 12
    db $2A, $0C ; note A#2 dur 12
    db $28, $0C ; note G#2 dur 12
    db $27, $30 ; note G2 dur 48
    db $A0, $0B ; volume $0B
    db $25, $0C ; note F2 dur 12
    db $C1, $7F ; env $7F
    db $A0, $06 ; volume $06
    db $25, $0C ; note F2 dur 12
    db $A3, $09 ; mod $09
    db $C3, $78 ; env $78
    db $A2, $00 ; duty2 $00
    db $A0, $0F ; volume $0F
    db $2A, $0C ; note A#2 dur 12
    db $30, $0C ; note C3 dur 12
    db $A3, $FE ; mod $FE
    db $C0, $FE ; env $FE
    db $A0, $0B ; volume $0B
    db $37, $18 ; note G3 dur 24
    db $35, $0C ; note F3 dur 12
    db $33, $0C ; note D#3 dur 12
    db $37, $18 ; note G3 dur 24
    db $35, $0C ; note F3 dur 12
    db $33, $0C ; note D#3 dur 12
    db $A0, $0B ; volume $0B
    db $32, $30 ; note D3 dur 48
    db $C1, $7F ; env $7F
    db $A3, $00 ; mod $00
    db $A0, $09 ; volume $09
    db $32, $18 ; note D3 dur 24
    db $A3, $09 ; mod $09
    db $C3, $78 ; env $78
    db $A0, $0F ; volume $0F
    db $33, $0C ; note D#3 dur 12
    db $32, $0C ; note D3 dur 12
    db $30, $18 ; note C3 dur 24
    db $32, $0C ; note D3 dur 12
    db $33, $0C ; note D#3 dur 12
    db $28, $18 ; note G#2 dur 24
    db $2A, $0C ; note A#2 dur 12
    db $30, $0C ; note C3 dur 12
    db $2A, $0C ; note A#2 dur 12
    db $30, $0C ; note C3 dur 12
    db $C0, $FE ; env $FE
    db $A3, $FE ; mod $FE
    db $A0, $0B ; volume $0B
    db $27, $20 ; note G2 dur 32
    db $C1, $5F ; env $5F
    db $A3, $09 ; mod $09
    db $A0, $08 ; volume $08
    db $27, $10 ; note G2 dur 16
    db $C3, $78 ; env $78
    db $A0, $0F ; volume $0F
    db $27, $16 ; note G2 dur 22
    db $A0, $08 ; volume $08
    db $27, $02 ; note G2 dur 2
    db $C3, $58 ; env $58
    db $A0, $0F ; volume $0F
    db $27, $0C ; note G2 dur 12
    db $C3, $68 ; env $68
    db $25, $0C ; note F2 dur 12
    db $A3, $FE ; mod $FE
    db $A0, $0C ; volume $0C
    db $C0, $FE ; env $FE
    db $33, $20 ; note D#3 dur 32
    db $C1, $7F ; env $7F
    db $A3, $00 ; mod $00
    db $A0, $0A ; volume $0A
    db $33, $10 ; note D#3 dur 16
    db $A3, $09 ; mod $09
    db $A0, $0D ; volume $0D
    db $C3, $78 ; env $78
    db $31, $0C ; note C#3 dur 12
    db $2B, $0C ; note B2 dur 12
    db $2A, $0C ; note A#2 dur 12
    db $30, $0C ; note C3 dur 12
    db $32, $0C ; note D3 dur 12
    db $33, $0C ; note D#3 dur 12
    db $C0, $FE ; env $FE
    db $A0, $0A ; volume $0A
    db $A3, $FE ; mod $FE
    db $37, $1C ; note G3 dur 28
    db $C1, $7F ; env $7F
    db $A3, $09 ; mod $09
    db $A0, $08 ; volume $08
    db $37, $08 ; note G3 dur 8
    db $C4, $2F ; env $2F
    db $A0, $0B ; volume $0B
    db $27, $0C ; note G2 dur 12
    db $A0, $0F ; volume $0F
    db $C3, $68 ; env $68
    db $27, $0C ; note G2 dur 12
    db $28, $0C ; note G#2 dur 12
    db $20, $18 ; note C2 dur 24
    db $23, $18 ; note D#2 dur 24
    db $25, $18 ; note F2 dur 24
    db $AD, $00 ; return $00

; sound track, 572 events after the header (E-0019: grammar C2, meaning C0)
Data_040_70BF:: ; heuristic: track stream of a sound record; C0
    db $07, $20, $02, $08 ; header: param=7 byte1=$20 volume=$02 byte3=$08
    db $A3, $0C ; mod $0C
    db $A0, $02 ; volume $02
    db $42, $06 ; note D4 dur 6
    db $A0, $04 ; volume $04
    db $42, $06 ; note D4 dur 6
    db $A0, $06 ; volume $06
    db $42, $0C ; note D4 dur 12
    db $A0, $02 ; volume $02
    db $3B, $06 ; note B3 dur 6
    db $A0, $04 ; volume $04
    db $3B, $06 ; note B3 dur 6
    db $A0, $06 ; volume $06
    db $3B, $0C ; note B3 dur 12
    db $A0, $02 ; volume $02
    db $37, $06 ; note G3 dur 6
    db $A0, $04 ; volume $04
    db $37, $06 ; note G3 dur 6
    db $A0, $06 ; volume $06
    db $37, $0C ; note G3 dur 12
    db $A0, $02 ; volume $02
    db $35, $06 ; note F3 dur 6
    db $A0, $04 ; volume $04
    db $35, $06 ; note F3 dur 6
    db $A0, $06 ; volume $06
    db $35, $0C ; note F3 dur 12
    db $A0, $02 ; volume $02
    db $32, $06 ; note D3 dur 6
    db $A0, $04 ; volume $04
    db $32, $06 ; note D3 dur 6
    db $A0, $06 ; volume $06
    db $32, $0C ; note D3 dur 12
    db $A0, $02 ; volume $02
    db $2B, $06 ; note B2 dur 6
    db $A0, $04 ; volume $04
    db $2B, $06 ; note B2 dur 6
    db $A0, $06 ; volume $06
    db $2B, $0C ; note B2 dur 12
    db $A0, $02 ; volume $02
    db $2B, $06 ; note B2 dur 6
    db $A0, $04 ; volume $04
    db $2B, $06 ; note B2 dur 6
    db $A0, $06 ; volume $06
    db $2B, $0C ; note B2 dur 12
    db $1F, $18 ; rest-note $1F dur 24
    db $FD, $F3 ; label 3
    db $AC, $01 ; call x1
    dw $01EC ; byte offset of the called section from the track start
    db $FD, $F0 ; label 0
    db $A2, $FF ; duty2 $FF
    db $A1, $0B ; duty $0B
    db $A0, $02 ; volume $02
    db $10, $0C ; note C1 dur 12
    db $A2, $50 ; duty2 $50
    db $A1, $03 ; duty $03
    db $20, $0C ; note C2 dur 12
    db $A0, $04 ; volume $04
    db $20, $0C ; note C2 dur 12
    db $A0, $02 ; volume $02
    db $20, $0C ; note C2 dur 12
    db $B9, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $A2, $FF ; duty2 $FF
    db $A0, $0B ; volume $0B
    db $A1, $09 ; duty $09
    db $17, $0C ; note G1 dur 12
    db $A2, $50 ; duty2 $50
    db $A1, $03 ; duty $03
    db $27, $0C ; note G2 dur 12
    db $A0, $04 ; volume $04
    db $27, $0C ; note G2 dur 12
    db $A0, $02 ; volume $02
    db $27, $0C ; note G2 dur 12
    db $B4, $F0 ; repeat $F0
    db $A1, $0B ; duty $0B
    db $17, $18 ; note G1 dur 24
    db $A0, $06 ; volume $06
    db $17, $18 ; note G1 dur 24
    db $AC, $01 ; call x1
    dw $01EC ; byte offset of the called section from the track start
    db $FD, $F0 ; label 0
    db $A2, $FF ; duty2 $FF
    db $A1, $0B ; duty $0B
    db $A0, $02 ; volume $02
    db $13, $0C ; note D#1 dur 12
    db $A2, $50 ; duty2 $50
    db $A1, $03 ; duty $03
    db $2A, $0C ; note A#2 dur 12
    db $A0, $04 ; volume $04
    db $2A, $0C ; note A#2 dur 12
    db $A0, $02 ; volume $02
    db $2A, $0C ; note A#2 dur 12
    db $B1, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $A1, $0B ; duty $0B
    db $A2, $FF ; duty2 $FF
    db $17, $0C ; note G1 dur 12
    db $A2, $50 ; duty2 $50
    db $A1, $03 ; duty $03
    db $2A, $0C ; note A#2 dur 12
    db $A0, $04 ; volume $04
    db $2A, $0C ; note A#2 dur 12
    db $A0, $02 ; volume $02
    db $2A, $0C ; note A#2 dur 12
    db $B1, $F0 ; repeat $F0
    db $A1, $0B ; duty $0B
    db $A2, $FF ; duty2 $FF
    db $10, $0C ; note C1 dur 12
    db $A2, $50 ; duty2 $50
    db $A1, $03 ; duty $03
    db $23, $0C ; note D#2 dur 12
    db $A0, $04 ; volume $04
    db $23, $0C ; note D#2 dur 12
    db $A0, $02 ; volume $02
    db $23, $0C ; note D#2 dur 12
    db $A2, $FF ; duty2 $FF
    db $A1, $0B ; duty $0B
    db $15, $0C ; note F1 dur 12
    db $A2, $50 ; duty2 $50
    db $A1, $03 ; duty $03
    db $23, $0C ; note D#2 dur 12
    db $A0, $04 ; volume $04
    db $23, $0C ; note D#2 dur 12
    db $A0, $02 ; volume $02
    db $23, $0C ; note D#2 dur 12
    db $A2, $FF ; duty2 $FF
    db $A1, $0B ; duty $0B
    db $17, $0C ; note G1 dur 12
    db $A2, $50 ; duty2 $50
    db $A1, $03 ; duty $03
    db $2A, $0C ; note A#2 dur 12
    db $A0, $04 ; volume $04
    db $2A, $0C ; note A#2 dur 12
    db $A0, $02 ; volume $02
    db $2A, $0C ; note A#2 dur 12
    db $A2, $FF ; duty2 $FF
    db $A1, $0B ; duty $0B
    db $20, $0C ; note C2 dur 12
    db $A2, $50 ; duty2 $50
    db $A1, $03 ; duty $03
    db $2A, $0C ; note A#2 dur 12
    db $A0, $04 ; volume $04
    db $2A, $0C ; note A#2 dur 12
    db $A0, $02 ; volume $02
    db $2A, $0C ; note A#2 dur 12
    db $FD, $F0 ; label 0
    db $A2, $FF ; duty2 $FF
    db $A1, $0B ; duty $0B
    db $18, $0C ; note G#1 dur 12
    db $A2, $50 ; duty2 $50
    db $A1, $03 ; duty $03
    db $2B, $0C ; note B2 dur 12
    db $A0, $04 ; volume $04
    db $2B, $0C ; note B2 dur 12
    db $A0, $02 ; volume $02
    db $2B, $0C ; note B2 dur 12
    db $B1, $F0 ; repeat $F0
    db $A2, $FF ; duty2 $FF
    db $A1, $0B ; duty $0B
    db $13, $0C ; note D#1 dur 12
    db $A1, $03 ; duty $03
    db $A2, $50 ; duty2 $50
    db $27, $0C ; note G2 dur 12
    db $A0, $04 ; volume $04
    db $27, $0C ; note G2 dur 12
    db $A0, $02 ; volume $02
    db $27, $0C ; note G2 dur 12
    db $A2, $FF ; duty2 $FF
    db $A1, $0B ; duty $0B
    db $10, $0C ; note C1 dur 12
    db $A2, $50 ; duty2 $50
    db $A1, $03 ; duty $03
    db $34, $0C ; note E3 dur 12
    db $A0, $04 ; volume $04
    db $34, $0C ; note E3 dur 12
    db $A0, $02 ; volume $02
    db $34, $0C ; note E3 dur 12
    db $A2, $FF ; duty2 $FF
    db $A1, $0B ; duty $0B
    db $15, $0C ; note F1 dur 12
    db $A2, $50 ; duty2 $50
    db $A1, $03 ; duty $03
    db $28, $0C ; note G#2 dur 12
    db $A0, $04 ; volume $04
    db $28, $0C ; note G#2 dur 12
    db $A0, $02 ; volume $02
    db $28, $0C ; note G#2 dur 12
    db $A2, $FF ; duty2 $FF
    db $A1, $0B ; duty $0B
    db $1A, $0C ; note A#1 dur 12
    db $A2, $50 ; duty2 $50
    db $A1, $03 ; duty $03
    db $30, $0C ; note C3 dur 12
    db $A0, $04 ; volume $04
    db $30, $0C ; note C3 dur 12
    db $A0, $02 ; volume $02
    db $32, $0C ; note D3 dur 12
    db $A2, $60 ; duty2 $60
    db $A1, $0B ; duty $0B
    db $13, $12 ; note D#1 dur 18
    db $A0, $04 ; volume $04
    db $13, $06 ; note D#1 dur 6
    db $A0, $02 ; volume $02
    db $1A, $12 ; note A#1 dur 18
    db $A0, $04 ; volume $04
    db $1A, $06 ; note A#1 dur 6
    db $A1, $0B ; duty $0B
    db $A0, $02 ; volume $02
    db $23, $12 ; note D#2 dur 18
    db $A0, $04 ; volume $04
    db $23, $06 ; note D#2 dur 6
    db $1F, $18 ; rest-note $1F dur 24
    db $AC, $01 ; call x1
    dw $0296 ; byte offset of the called section from the track start
    db $A1, $0B ; duty $0B
    db $13, $12 ; note D#1 dur 18
    db $A0, $06 ; volume $06
    db $13, $06 ; note D#1 dur 6
    db $A0, $02 ; volume $02
    db $1A, $12 ; note A#1 dur 18
    db $A0, $06 ; volume $06
    db $1A, $06 ; note A#1 dur 6
    db $A0, $02 ; volume $02
    db $23, $12 ; note D#2 dur 18
    db $A0, $06 ; volume $06
    db $23, $06 ; note D#2 dur 6
    db $1F, $18 ; rest-note $1F dur 24
    db $AC, $01 ; call x1
    dw $0296 ; byte offset of the called section from the track start
    db $FD, $F0 ; label 0
    db $A0, $02 ; volume $02
    db $17, $12 ; note G1 dur 18
    db $A0, $04 ; volume $04
    db $17, $06 ; note G1 dur 6
    db $A0, $02 ; volume $02
    db $22, $12 ; note D2 dur 18
    db $A0, $04 ; volume $04
    db $22, $06 ; note D2 dur 6
    db $A0, $02 ; volume $02
    db $27, $18 ; note G2 dur 24
    db $A0, $06 ; volume $06
    db $27, $18 ; note G2 dur 24
    db $B1, $F0 ; repeat $F0
    db $B0, $F3 ; jump $F3
    db $FF, $FF ; end
    db $A0, $02 ; volume $02
    db $A2, $60 ; duty2 $60
    db $FD, $F0 ; label 0
    db $A1, $03 ; duty $03
    db $20, $0C ; note C2 dur 12
    db $A1, $0F ; duty $0F
    db $27, $0C ; note G2 dur 12
    db $30, $0C ; note C3 dur 12
    db $27, $0C ; note G2 dur 12
    db $B1, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $A1, $03 ; duty $03
    db $24, $0C ; note E2 dur 12
    db $A1, $0F ; duty $0F
    db $27, $0C ; note G2 dur 12
    db $2B, $0C ; note B2 dur 12
    db $27, $0C ; note G2 dur 12
    db $B1, $F0 ; repeat $F0
    db $A1, $03 ; duty $03
    db $19, $0C ; note A1 dur 12
    db $A1, $0F ; duty $0F
    db $20, $0C ; note C2 dur 12
    db $24, $0C ; note E2 dur 12
    db $20, $0C ; note C2 dur 12
    db $A1, $03 ; duty $03
    db $22, $0C ; note D2 dur 12
    db $A1, $0F ; duty $0F
    db $25, $0C ; note F2 dur 12
    db $29, $0C ; note A2 dur 12
    db $25, $0C ; note F2 dur 12
    db $A1, $03 ; duty $03
    db $14, $0C ; note E1 dur 12
    db $A1, $0F ; duty $0F
    db $1B, $0C ; note B1 dur 12
    db $24, $0C ; note E2 dur 12
    db $1B, $0C ; note B1 dur 12
    db $A1, $03 ; duty $03
    db $19, $0C ; note A1 dur 12
    db $A1, $0F ; duty $0F
    db $21, $0C ; note C#2 dur 12
    db $24, $0C ; note E2 dur 12
    db $19, $0C ; note A1 dur 12
    db $A1, $03 ; duty $03
    db $15, $0C ; note F1 dur 12
    db $A1, $0F ; duty $0F
    db $20, $0C ; note C2 dur 12
    db $25, $0C ; note F2 dur 12
    db $20, $0C ; note C2 dur 12
    db $A1, $03 ; duty $03
    db $25, $0C ; note F2 dur 12
    db $A1, $0F ; duty $0F
    db $20, $0C ; note C2 dur 12
    db $18, $0C ; note G#1 dur 12
    db $15, $0C ; note F1 dur 12
    db $A1, $03 ; duty $03
    db $20, $0C ; note C2 dur 12
    db $A1, $0F ; duty $0F
    db $24, $0C ; note E2 dur 12
    db $27, $0C ; note G2 dur 12
    db $20, $0C ; note C2 dur 12
    db $A1, $03 ; duty $03
    db $19, $0C ; note A1 dur 12
    db $A1, $0F ; duty $0F
    db $21, $0C ; note C#2 dur 12
    db $24, $0C ; note E2 dur 12
    db $29, $0C ; note A2 dur 12
    db $A2, $FF ; duty2 $FF
    db $A1, $0B ; duty $0B
    db $22, $30 ; note D2 dur 48
    db $A0, $02 ; volume $02
    db $17, $2C ; note G1 dur 44
    db $A0, $04 ; volume $04
    db $17, $04 ; note G1 dur 4
    db $A2, $60 ; duty2 $60
    db $A0, $02 ; volume $02
    db $20, $0C ; note C2 dur 12
    db $A1, $03 ; duty $03
    db $35, $0C ; note F3 dur 12
    db $32, $0C ; note D3 dur 12
    db $34, $0C ; note E3 dur 12
    db $A2, $50 ; duty2 $50
    db $30, $18 ; note C3 dur 24
    db $A0, $06 ; volume $06
    db $30, $18 ; note C3 dur 24
    db $AD, $00 ; return $00
    db $A1, $0B ; duty $0B
    db $A2, $FF ; duty2 $FF
    db $A0, $02 ; volume $02
    db $1A, $0C ; note A#1 dur 12
    db $A1, $03 ; duty $03
    db $A2, $40 ; duty2 $40
    db $30, $0C ; note C3 dur 12
    db $A0, $04 ; volume $04
    db $30, $0C ; note C3 dur 12
    db $1F, $0C ; rest-note $1F dur 12
    db $A1, $0B ; duty $0B
    db $A2, $FF ; duty2 $FF
    db $A0, $02 ; volume $02
    db $1A, $0C ; note A#1 dur 12
    db $A1, $03 ; duty $03
    db $A2, $40 ; duty2 $40
    db $2B, $0C ; note B2 dur 12
    db $A0, $04 ; volume $04
    db $2B, $0C ; note B2 dur 12
    db $1F, $0C ; rest-note $1F dur 12
    db $A1, $0B ; duty $0B
    db $A2, $FF ; duty2 $FF
    db $A0, $02 ; volume $02
    db $1A, $0C ; note A#1 dur 12
    db $A1, $03 ; duty $03
    db $A2, $40 ; duty2 $40
    db $2A, $0C ; note A#2 dur 12
    db $A0, $04 ; volume $04
    db $2A, $0C ; note A#2 dur 12
    db $1F, $0C ; rest-note $1F dur 12
    db $A1, $0B ; duty $0B
    db $A2, $FF ; duty2 $FF
    db $A0, $02 ; volume $02
    db $1A, $0C ; note A#1 dur 12
    db $A1, $03 ; duty $03
    db $A2, $40 ; duty2 $40
    db $2A, $0C ; note A#2 dur 12
    db $A0, $04 ; volume $04
    db $2A, $0C ; note A#2 dur 12
    db $1F, $0C ; rest-note $1F dur 12
    db $A2, $FF ; duty2 $FF
    db $A1, $0B ; duty $0B
    db $A0, $02 ; volume $02
    db $1A, $0C ; note A#1 dur 12
    db $A2, $40 ; duty2 $40
    db $A1, $03 ; duty $03
    db $30, $0C ; note C3 dur 12
    db $A0, $04 ; volume $04
    db $30, $0C ; note C3 dur 12
    db $1F, $0C ; rest-note $1F dur 12
    db $A1, $0B ; duty $0B
    db $A2, $FF ; duty2 $FF
    db $A0, $02 ; volume $02
    db $1A, $0C ; note A#1 dur 12
    db $A2, $40 ; duty2 $40
    db $A1, $03 ; duty $03
    db $2B, $0C ; note B2 dur 12
    db $A0, $04 ; volume $04
    db $2B, $0C ; note B2 dur 12
    db $1F, $0C ; rest-note $1F dur 12
    db $FD, $F0 ; label 0
    db $A2, $FF ; duty2 $FF
    db $A1, $0B ; duty $0B
    db $A0, $02 ; volume $02
    db $1A, $0C ; note A#1 dur 12
    db $A1, $03 ; duty $03
    db $A2, $40 ; duty2 $40
    db $2A, $0C ; note A#2 dur 12
    db $A0, $04 ; volume $04
    db $2A, $0C ; note A#2 dur 12
    db $1F, $0C ; rest-note $1F dur 12
    db $B1, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $A1, $0B ; duty $0B
    db $A2, $FF ; duty2 $FF
    db $A0, $02 ; volume $02
    db $1A, $0C ; note A#1 dur 12
    db $A1, $03 ; duty $03
    db $A2, $40 ; duty2 $40
    db $30, $0C ; note C3 dur 12
    db $A0, $04 ; volume $04
    db $30, $0C ; note C3 dur 12
    db $1F, $0C ; rest-note $1F dur 12
    db $B1, $F0 ; repeat $F0
    db $A1, $0B ; duty $0B
    db $A2, $FF ; duty2 $FF
    db $A0, $02 ; volume $02
    db $1A, $0C ; note A#1 dur 12
    db $A1, $03 ; duty $03
    db $A2, $40 ; duty2 $40
    db $2A, $0C ; note A#2 dur 12
    db $A0, $04 ; volume $04
    db $2A, $0C ; note A#2 dur 12
    db $A1, $03 ; duty $03
    db $A0, $06 ; volume $06
    db $40, $06 ; note C4 dur 6
    db $38, $06 ; note G#3 dur 6
    db $A1, $0B ; duty $0B
    db $A2, $FF ; duty2 $FF
    db $A0, $02 ; volume $02
    db $1A, $0C ; note A#1 dur 12
    db $A1, $03 ; duty $03
    db $A2, $40 ; duty2 $40
    db $2A, $0C ; note A#2 dur 12
    db $A0, $04 ; volume $04
    db $2A, $0C ; note A#2 dur 12
    db $A1, $03 ; duty $03
    db $A0, $06 ; volume $06
    db $43, $06 ; note D#4 dur 6
    db $3A, $06 ; note A#3 dur 6
    db $A2, $FF ; duty2 $FF
    db $A1, $0B ; duty $0B
    db $A0, $02 ; volume $02
    db $1A, $0C ; note A#1 dur 12
    db $A1, $03 ; duty $03
    db $32, $0C ; note D3 dur 12
    db $30, $0C ; note C3 dur 12
    db $A1, $0B ; duty $0B
    db $2A, $0C ; note A#2 dur 12
    db $A1, $03 ; duty $03
    db $1A, $0C ; note A#1 dur 12
    db $28, $0C ; note G#2 dur 12
    db $25, $0C ; note F2 dur 12
    db $23, $0C ; note D#2 dur 12
    db $A1, $0B ; duty $0B
    db $1A, $30 ; note A#1 dur 48
    db $A2, $50 ; duty2 $50
    db $A1, $03 ; duty $03
    db $2A, $18 ; note A#2 dur 24
    db $A0, $06 ; volume $06
    db $2A, $18 ; note A#2 dur 24
    db $FD, $F0 ; label 0
    db $A2, $FF ; duty2 $FF
    db $A1, $0B ; duty $0B
    db $A0, $02 ; volume $02
    db $13, $0C ; note D#1 dur 12
    db $A2, $50 ; duty2 $50
    db $A1, $03 ; duty $03
    db $2A, $0C ; note A#2 dur 12
    db $A0, $04 ; volume $04
    db $2A, $0C ; note A#2 dur 12
    db $A0, $02 ; volume $02
    db $2A, $0C ; note A#2 dur 12
    db $B1, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $A2, $FF ; duty2 $FF
    db $A1, $0B ; duty $0B
    db $17, $0C ; note G1 dur 12
    db $A2, $50 ; duty2 $50
    db $A1, $03 ; duty $03
    db $2A, $0C ; note A#2 dur 12
    db $A0, $04 ; volume $04
    db $2A, $0C ; note A#2 dur 12
    db $A0, $02 ; volume $02
    db $2A, $0C ; note A#2 dur 12
    db $B1, $F0 ; repeat $F0
    db $A1, $0B ; duty $0B
    db $A2, $FF ; duty2 $FF
    db $10, $0C ; note C1 dur 12
    db $A1, $03 ; duty $03
    db $A2, $50 ; duty2 $50
    db $23, $0C ; note D#2 dur 12
    db $A0, $04 ; volume $04
    db $23, $0C ; note D#2 dur 12
    db $A0, $02 ; volume $02
    db $23, $0C ; note D#2 dur 12
    db $A1, $0B ; duty $0B
    db $A2, $FF ; duty2 $FF
    db $15, $0C ; note F1 dur 12
    db $A1, $03 ; duty $03
    db $A2, $50 ; duty2 $50
    db $23, $0C ; note D#2 dur 12
    db $A0, $04 ; volume $04
    db $23, $0C ; note D#2 dur 12
    db $A0, $02 ; volume $02
    db $23, $0C ; note D#2 dur 12
    db $A1, $0B ; duty $0B
    db $A2, $FF ; duty2 $FF
    db $17, $0C ; note G1 dur 12
    db $A2, $50 ; duty2 $50
    db $A1, $03 ; duty $03
    db $2A, $0C ; note A#2 dur 12
    db $A0, $04 ; volume $04
    db $2A, $0C ; note A#2 dur 12
    db $A0, $02 ; volume $02
    db $2A, $0C ; note A#2 dur 12
    db $A2, $FF ; duty2 $FF
    db $A1, $0B ; duty $0B
    db $20, $0C ; note C2 dur 12
    db $A2, $50 ; duty2 $50
    db $A1, $03 ; duty $03
    db $2A, $0C ; note A#2 dur 12
    db $A0, $04 ; volume $04
    db $2A, $0C ; note A#2 dur 12
    db $A0, $02 ; volume $02
    db $2A, $0C ; note A#2 dur 12
    db $FD, $F0 ; label 0
    db $A2, $FF ; duty2 $FF
    db $A1, $0B ; duty $0B
    db $18, $0C ; note G#1 dur 12
    db $A1, $03 ; duty $03
    db $A2, $50 ; duty2 $50
    db $2B, $0C ; note B2 dur 12
    db $A0, $04 ; volume $04
    db $2B, $0C ; note B2 dur 12
    db $A0, $02 ; volume $02
    db $2B, $0C ; note B2 dur 12
    db $B1, $F0 ; repeat $F0
    db $A1, $0B ; duty $0B
    db $A2, $FF ; duty2 $FF
    db $13, $0C ; note D#1 dur 12
    db $A2, $50 ; duty2 $50
    db $A1, $03 ; duty $03
    db $27, $0C ; note G2 dur 12
    db $A0, $04 ; volume $04
    db $27, $0C ; note G2 dur 12
    db $A0, $02 ; volume $02
    db $27, $0C ; note G2 dur 12
    db $A1, $0B ; duty $0B
    db $A2, $FF ; duty2 $FF
    db $10, $0C ; note C1 dur 12
    db $A2, $50 ; duty2 $50
    db $A1, $03 ; duty $03
    db $34, $0C ; note E3 dur 12
    db $A0, $04 ; volume $04
    db $34, $0C ; note E3 dur 12
    db $A0, $02 ; volume $02
    db $34, $0C ; note E3 dur 12
    db $A2, $FF ; duty2 $FF
    db $A1, $0B ; duty $0B
    db $15, $0C ; note F1 dur 12
    db $A2, $50 ; duty2 $50
    db $A1, $03 ; duty $03
    db $28, $0C ; note G#2 dur 12
    db $A0, $04 ; volume $04
    db $28, $0C ; note G#2 dur 12
    db $A0, $02 ; volume $02
    db $28, $0C ; note G#2 dur 12
    db $A1, $0B ; duty $0B
    db $1A, $0C ; note A#1 dur 12
    db $A1, $03 ; duty $03
    db $30, $0C ; note C3 dur 12
    db $A0, $04 ; volume $04
    db $30, $0C ; note C3 dur 12
    db $A0, $02 ; volume $02
    db $32, $0C ; note D3 dur 12
    db $AD, $00 ; return $00

; sound track, 480 events after the header (E-0019: grammar C2, meaning C0)
Data_040_7543:: ; heuristic: track stream of a sound record; C0
    db $00, $01, $09, $00 ; header: param=0 byte1=$01 volume=$09 byte3=$00
    db $1F, $18 ; rest-note $1F dur 24
    db $FD, $F3 ; label 3
    db $A3, $26 ; mod $26
    db $A2, $01 ; duty2 $01
    db $C3, $52 ; env $52
    db $A0, $0B ; volume $0B
    db $1F, $18 ; rest-note $1F dur 24
    db $22, $18 ; note D2 dur 24
    db $25, $18 ; note F2 dur 24
    db $C5, $60 ; env $60
    db $A0, $08 ; volume $08
    db $2A, $16 ; note A#2 dur 22
    db $C1, $7F ; env $7F
    db $A0, $04 ; volume $04
    db $2A, $1A ; note A#2 dur 26
    db $C3, $52 ; env $52
    db $A0, $0B ; volume $0B
    db $1A, $18 ; note A#1 dur 24
    db $24, $18 ; note E2 dur 24
    db $A0, $08 ; volume $08
    db $C5, $60 ; env $60
    db $27, $16 ; note G2 dur 22
    db $C1, $7F ; env $7F
    db $A0, $04 ; volume $04
    db $27, $1A ; note G2 dur 26
    db $C3, $52 ; env $52
    db $A0, $0B ; volume $0B
    db $20, $18 ; note C2 dur 24
    db $24, $18 ; note E2 dur 24
    db $A0, $08 ; volume $08
    db $C5, $60 ; env $60
    db $29, $16 ; note A2 dur 22
    db $C1, $7F ; env $7F
    db $A0, $04 ; volume $04
    db $29, $1A ; note A2 dur 26
    db $C3, $52 ; env $52
    db $A0, $0B ; volume $0B
    db $20, $18 ; note C2 dur 24
    db $23, $18 ; note D#2 dur 24
    db $A0, $08 ; volume $08
    db $C5, $60 ; env $60
    db $29, $16 ; note A2 dur 22
    db $C1, $7F ; env $7F
    db $A0, $04 ; volume $04
    db $29, $1A ; note A2 dur 26
    db $C3, $52 ; env $52
    db $A0, $0B ; volume $0B
    db $25, $18 ; note F2 dur 24
    db $22, $18 ; note D2 dur 24
    db $A0, $09 ; volume $09
    db $C5, $60 ; env $60
    db $29, $17 ; note A2 dur 23
    db $C1, $7F ; env $7F
    db $A0, $06 ; volume $06
    db $29, $19 ; note A2 dur 25
    db $C3, $52 ; env $52
    db $A0, $0B ; volume $0B
    db $20, $18 ; note C2 dur 24
    db $24, $18 ; note E2 dur 24
    db $A0, $08 ; volume $08
    db $C5, $60 ; env $60
    db $27, $16 ; note G2 dur 22
    db $C1, $7F ; env $7F
    db $A0, $04 ; volume $04
    db $27, $1A ; note G2 dur 26
    db $C3, $48 ; env $48
    db $A3, $FE ; mod $FE
    db $A0, $0B ; volume $0B
    db $26, $18 ; note F#2 dur 24
    db $29, $18 ; note A2 dur 24
    db $32, $18 ; note D3 dur 24
    db $30, $18 ; note C3 dur 24
    db $29, $18 ; note A2 dur 24
    db $26, $18 ; note F#2 dur 24
    db $C3, $52 ; env $52
    db $A0, $0B ; volume $0B
    db $29, $18 ; note A2 dur 24
    db $C1, $7F ; env $7F
    db $A0, $06 ; volume $06
    db $29, $18 ; note A2 dur 24
    db $A3, $26 ; mod $26
    db $C3, $52 ; env $52
    db $A0, $0C ; volume $0C
    db $1A, $18 ; note A#1 dur 24
    db $22, $18 ; note D2 dur 24
    db $A0, $09 ; volume $09
    db $C5, $60 ; env $60
    db $25, $16 ; note F2 dur 22
    db $C1, $7F ; env $7F
    db $A0, $04 ; volume $04
    db $25, $1A ; note F2 dur 26
    db $C3, $52 ; env $52
    db $A0, $0B ; volume $0B
    db $21, $18 ; note C#2 dur 24
    db $25, $18 ; note F2 dur 24
    db $C5, $60 ; env $60
    db $A0, $09 ; volume $09
    db $29, $16 ; note A2 dur 22
    db $C1, $7F ; env $7F
    db $A0, $04 ; volume $04
    db $29, $1A ; note A2 dur 26
    db $C3, $52 ; env $52
    db $A0, $0B ; volume $0B
    db $20, $18 ; note C2 dur 24
    db $24, $18 ; note E2 dur 24
    db $A0, $09 ; volume $09
    db $C5, $60 ; env $60
    db $27, $16 ; note G2 dur 22
    db $C1, $7F ; env $7F
    db $A0, $04 ; volume $04
    db $27, $1A ; note G2 dur 26
    db $C3, $52 ; env $52
    db $A0, $0B ; volume $0B
    db $20, $18 ; note C2 dur 24
    db $26, $18 ; note F#2 dur 24
    db $A0, $09 ; volume $09
    db $C5, $60 ; env $60
    db $29, $16 ; note A2 dur 22
    db $C1, $7F ; env $7F
    db $A0, $04 ; volume $04
    db $29, $1A ; note A2 dur 26
    db $C3, $52 ; env $52
    db $A0, $0B ; volume $0B
    db $22, $18 ; note D2 dur 24
    db $25, $18 ; note F2 dur 24
    db $C5, $60 ; env $60
    db $A0, $09 ; volume $09
    db $29, $16 ; note A2 dur 22
    db $C1, $7F ; env $7F
    db $A0, $04 ; volume $04
    db $29, $1A ; note A2 dur 26
    db $C3, $52 ; env $52
    db $A0, $0B ; volume $0B
    db $21, $18 ; note C#2 dur 24
    db $27, $18 ; note G2 dur 24
    db $C5, $60 ; env $60
    db $A0, $09 ; volume $09
    db $2A, $16 ; note A#2 dur 22
    db $C1, $7F ; env $7F
    db $A0, $04 ; volume $04
    db $2A, $1A ; note A#2 dur 26
    db $C3, $48 ; env $48
    db $A0, $0B ; volume $0B
    db $21, $18 ; note C#2 dur 24
    db $24, $18 ; note E2 dur 24
    db $27, $18 ; note G2 dur 24
    db $2A, $18 ; note A#2 dur 24
    db $27, $18 ; note G2 dur 24
    db $C3, $52 ; env $52
    db $24, $18 ; note E2 dur 24
    db $C1, $70 ; env $70
    db $A0, $04 ; volume $04
    db $24, $18 ; note E2 dur 24
    db $A2, $02 ; duty2 $02
    db $A0, $03 ; volume $03
    db $39, $0C ; note A3 dur 12
    db $1F, $0C ; rest-note $1F dur 12
    db $A2, $02 ; duty2 $02
    db $C1, $7F ; env $7F
    db $AA, $4B ; slide $4B
    db $A0, $09 ; volume $09
    db $22, $0C ; note D2 dur 12
    db $25, $0C ; note F2 dur 12
    db $22, $0C ; note D2 dur 12
    db $25, $0C ; note F2 dur 12
    db $A0, $08 ; volume $08
    db $22, $0C ; note D2 dur 12
    db $25, $0C ; note F2 dur 12
    db $A0, $03 ; volume $03
    db $25, $18 ; note F2 dur 24
    db $A0, $09 ; volume $09
    db $24, $0C ; note E2 dur 12
    db $27, $0C ; note G2 dur 12
    db $24, $0C ; note E2 dur 12
    db $27, $0C ; note G2 dur 12
    db $A0, $08 ; volume $08
    db $24, $0C ; note E2 dur 12
    db $27, $0C ; note G2 dur 12
    db $A0, $03 ; volume $03
    db $27, $18 ; note G2 dur 24
    db $A0, $09 ; volume $09
    db $20, $0C ; note C2 dur 12
    db $24, $0C ; note E2 dur 12
    db $20, $0C ; note C2 dur 12
    db $24, $0C ; note E2 dur 12
    db $A0, $08 ; volume $08
    db $20, $0C ; note C2 dur 12
    db $24, $0C ; note E2 dur 12
    db $A0, $03 ; volume $03
    db $24, $0C ; note E2 dur 12
    db $AA, $00 ; slide $00
    db $A2, $02 ; duty2 $02
    db $A0, $04 ; volume $04
    db $42, $0C ; note D4 dur 12
    db $AA, $4B ; slide $4B
    db $A2, $02 ; duty2 $02
    db $A0, $09 ; volume $09
    db $20, $0C ; note C2 dur 12
    db $23, $0C ; note D#2 dur 12
    db $20, $0C ; note C2 dur 12
    db $23, $0C ; note D#2 dur 12
    db $A0, $08 ; volume $08
    db $20, $0C ; note C2 dur 12
    db $23, $0C ; note D#2 dur 12
    db $A0, $03 ; volume $03
    db $23, $18 ; note D#2 dur 24
    db $A0, $09 ; volume $09
    db $25, $0C ; note F2 dur 12
    db $29, $0C ; note A2 dur 12
    db $25, $0C ; note F2 dur 12
    db $29, $0C ; note A2 dur 12
    db $A0, $08 ; volume $08
    db $25, $0C ; note F2 dur 12
    db $29, $0C ; note A2 dur 12
    db $A0, $03 ; volume $03
    db $29, $18 ; note A2 dur 24
    db $A0, $09 ; volume $09
    db $24, $0C ; note E2 dur 12
    db $27, $0C ; note G2 dur 12
    db $24, $0C ; note E2 dur 12
    db $27, $0C ; note G2 dur 12
    db $A0, $08 ; volume $08
    db $24, $0C ; note E2 dur 12
    db $27, $0C ; note G2 dur 12
    db $A0, $03 ; volume $03
    db $27, $18 ; note G2 dur 24
    db $AA, $00 ; slide $00
    db $A0, $0C ; volume $0C
    db $19, $0C ; note A1 dur 12
    db $20, $0C ; note C2 dur 12
    db $26, $0C ; note F#2 dur 12
    db $29, $0C ; note A2 dur 12
    db $A0, $09 ; volume $09
    db $30, $0C ; note C3 dur 12
    db $29, $0C ; note A2 dur 12
    db $A0, $0E ; volume $0E
    db $34, $0C ; note E3 dur 12
    db $30, $0C ; note C3 dur 12
    db $A0, $09 ; volume $09
    db $29, $0C ; note A2 dur 12
    db $26, $0C ; note F#2 dur 12
    db $A0, $09 ; volume $09
    db $24, $0C ; note E2 dur 12
    db $20, $0C ; note C2 dur 12
    db $A0, $0C ; volume $0C
    db $19, $0C ; note A1 dur 12
    db $16, $0C ; note F#1 dur 12
    db $AA, $00 ; slide $00
    db $A0, $08 ; volume $08
    db $16, $0C ; note F#1 dur 12
    db $A2, $02 ; duty2 $02
    db $A0, $04 ; volume $04
    db $2A, $0C ; note A#2 dur 12
    db $A2, $02 ; duty2 $02
    db $AA, $4B ; slide $4B
    db $A0, $09 ; volume $09
    db $22, $0C ; note D2 dur 12
    db $25, $0C ; note F2 dur 12
    db $22, $0C ; note D2 dur 12
    db $25, $0C ; note F2 dur 12
    db $A0, $08 ; volume $08
    db $22, $0C ; note D2 dur 12
    db $25, $0C ; note F2 dur 12
    db $A0, $03 ; volume $03
    db $25, $18 ; note F2 dur 24
    db $A2, $02 ; duty2 $02
    db $AA, $4B ; slide $4B
    db $A0, $09 ; volume $09
    db $21, $0C ; note C#2 dur 12
    db $25, $0C ; note F2 dur 12
    db $21, $0C ; note C#2 dur 12
    db $A0, $08 ; volume $08
    db $25, $0C ; note F2 dur 12
    db $21, $0C ; note C#2 dur 12
    db $25, $0C ; note F2 dur 12
    db $A0, $03 ; volume $03
    db $25, $0C ; note F2 dur 12
    db $A2, $02 ; duty2 $02
    db $AA, $00 ; slide $00
    db $A0, $04 ; volume $04
    db $30, $0C ; note C3 dur 12
    db $A2, $02 ; duty2 $02
    db $AA, $4B ; slide $4B
    db $A0, $09 ; volume $09
    db $24, $0C ; note E2 dur 12
    db $27, $0C ; note G2 dur 12
    db $24, $0C ; note E2 dur 12
    db $27, $0C ; note G2 dur 12
    db $A0, $08 ; volume $08
    db $24, $0C ; note E2 dur 12
    db $27, $0C ; note G2 dur 12
    db $A0, $03 ; volume $03
    db $27, $18 ; note G2 dur 24
    db $A0, $09 ; volume $09
    db $26, $0C ; note F#2 dur 12
    db $29, $0C ; note A2 dur 12
    db $26, $0C ; note F#2 dur 12
    db $29, $0C ; note A2 dur 12
    db $A0, $08 ; volume $08
    db $26, $0C ; note F#2 dur 12
    db $29, $0C ; note A2 dur 12
    db $A0, $02 ; volume $02
    db $29, $18 ; note A2 dur 24
    db $A0, $09 ; volume $09
    db $22, $0C ; note D2 dur 12
    db $25, $0C ; note F2 dur 12
    db $22, $0C ; note D2 dur 12
    db $25, $0C ; note F2 dur 12
    db $A0, $08 ; volume $08
    db $22, $0C ; note D2 dur 12
    db $25, $0C ; note F2 dur 12
    db $A0, $03 ; volume $03
    db $25, $18 ; note F2 dur 24
    db $A0, $09 ; volume $09
    db $27, $0C ; note G2 dur 12
    db $2A, $0C ; note A#2 dur 12
    db $27, $0C ; note G2 dur 12
    db $2A, $0C ; note A#2 dur 12
    db $A0, $08 ; volume $08
    db $27, $0C ; note G2 dur 12
    db $2A, $0C ; note A#2 dur 12
    db $A0, $03 ; volume $03
    db $2A, $18 ; note A#2 dur 24
    db $AA, $00 ; slide $00
    db $A0, $0A ; volume $0A
    db $24, $0C ; note E2 dur 12
    db $27, $0C ; note G2 dur 12
    db $A0, $0C ; volume $0C
    db $2A, $0C ; note A#2 dur 12
    db $31, $0C ; note C#3 dur 12
    db $34, $0C ; note E3 dur 12
    db $31, $0C ; note C#3 dur 12
    db $A0, $0A ; volume $0A
    db $AA, $2B ; slide $2B
    db $C1, $50 ; env $50
    db $30, $0E ; note C3 dur 14
    db $A0, $03 ; volume $03
    db $30, $0A ; note C3 dur 10
    db $A0, $0B ; volume $0B
    db $2A, $0E ; note A#2 dur 14
    db $A0, $03 ; volume $03
    db $30, $0A ; note C3 dur 10
    db $A0, $0B ; volume $0B
    db $27, $0E ; note G2 dur 14
    db $A0, $03 ; volume $03
    db $2A, $0A ; note A#2 dur 10
    db $AA, $00 ; slide $00
    db $A0, $08 ; volume $08
    db $24, $0E ; note E2 dur 14
    db $A0, $03 ; volume $03
    db $24, $0A ; note E2 dur 10
    db $A2, $02 ; duty2 $02
    db $A0, $06 ; volume $06
    db $39, $18 ; note A3 dur 24
    db $A2, $02 ; duty2 $02
    db $AA, $4B ; slide $4B
    db $A0, $0B ; volume $0B
    db $31, $0E ; note C#3 dur 14
    db $A0, $02 ; volume $02
    db $31, $0A ; note C#3 dur 10
    db $A0, $0B ; volume $0B
    db $28, $0E ; note G#2 dur 14
    db $A0, $02 ; volume $02
    db $31, $0A ; note C#3 dur 10
    db $A0, $0B ; volume $0B
    db $25, $0E ; note F2 dur 14
    db $A0, $02 ; volume $02
    db $28, $0A ; note G#2 dur 10
    db $A0, $0B ; volume $0B
    db $21, $0E ; note C#2 dur 14
    db $A0, $02 ; volume $02
    db $25, $0A ; note F2 dur 10
    db $A0, $0B ; volume $0B
    db $25, $0E ; note F2 dur 14
    db $A0, $02 ; volume $02
    db $21, $0A ; note C#2 dur 10
    db $A0, $0A ; volume $0A
    db $28, $0E ; note G#2 dur 14
    db $A0, $02 ; volume $02
    db $25, $0A ; note F2 dur 10
    db $AA, $00 ; slide $00
    db $A0, $08 ; volume $08
    db $31, $0E ; note C#3 dur 14
    db $A0, $02 ; volume $02
    db $31, $22 ; note C#3 dur 34
    db $AA, $4B ; slide $4B
    db $A0, $0B ; volume $0B
    db $31, $0E ; note C#3 dur 14
    db $A0, $03 ; volume $03
    db $31, $0A ; note C#3 dur 10
    db $A0, $0B ; volume $0B
    db $2A, $0E ; note A#2 dur 14
    db $A0, $03 ; volume $03
    db $31, $0A ; note C#3 dur 10
    db $A0, $0B ; volume $0B
    db $26, $0E ; note F#2 dur 14
    db $A0, $03 ; volume $03
    db $2A, $0A ; note A#2 dur 10
    db $A0, $0B ; volume $0B
    db $25, $0E ; note F2 dur 14
    db $A0, $03 ; volume $03
    db $26, $0A ; note F#2 dur 10
    db $A0, $0B ; volume $0B
    db $21, $0E ; note C#2 dur 14
    db $A0, $03 ; volume $03
    db $26, $0A ; note F#2 dur 10
    db $A0, $0B ; volume $0B
    db $26, $0E ; note F#2 dur 14
    db $A0, $03 ; volume $03
    db $21, $0A ; note C#2 dur 10
    db $AA, $00 ; slide $00
    db $A0, $07 ; volume $07
    db $2A, $0E ; note A#2 dur 14
    db $A0, $03 ; volume $03
    db $2A, $0A ; note A#2 dur 10
    db $1F, $18 ; rest-note $1F dur 24
    db $AA, $4B ; slide $4B
    db $A0, $0B ; volume $0B
    db $2B, $0E ; note B2 dur 14
    db $A0, $03 ; volume $03
    db $2B, $0A ; note B2 dur 10
    db $A0, $0B ; volume $0B
    db $29, $0E ; note A2 dur 14
    db $A0, $03 ; volume $03
    db $2B, $0A ; note B2 dur 10
    db $A0, $0B ; volume $0B
    db $25, $0E ; note F2 dur 14
    db $A0, $03 ; volume $03
    db $29, $0A ; note A2 dur 10
    db $A0, $0B ; volume $0B
    db $23, $0F ; note D#2 dur 15
    db $A0, $03 ; volume $03
    db $25, $0A ; note F2 dur 10
    db $A0, $0B ; volume $0B
    db $1B, $0F ; note B1 dur 15
    db $A0, $03 ; volume $03
    db $23, $0A ; note D#2 dur 10
    db $A0, $0B ; volume $0B
    db $23, $0F ; note D#2 dur 15
    db $A0, $03 ; volume $03
    db $1B, $0A ; note B1 dur 10
    db $AA, $00 ; slide $00
    db $A0, $07 ; volume $07
    db $25, $0E ; note F2 dur 14
    db $A0, $03 ; volume $03
    db $25, $0C ; note F2 dur 12
    db $1F, $1A ; rest-note $1F dur 26
    db $AA, $4B ; slide $4B
    db $A0, $0B ; volume $0B
    db $30, $10 ; note C3 dur 16
    db $A0, $03 ; volume $03
    db $30, $0A ; note C3 dur 10
    db $A0, $0B ; volume $0B
    db $2A, $10 ; note A#2 dur 16
    db $A0, $03 ; volume $03
    db $30, $0A ; note C3 dur 10
    db $A0, $0B ; volume $0B
    db $27, $11 ; note G2 dur 17
    db $A0, $03 ; volume $03
    db $2A, $0A ; note A#2 dur 10
    db $A0, $0B ; volume $0B
    db $30, $11 ; note C3 dur 17
    db $A0, $03 ; volume $03
    db $27, $0A ; note G2 dur 10
    db $A0, $0A ; volume $0A
    db $2A, $11 ; note A#2 dur 17
    db $A0, $03 ; volume $03
    db $30, $0A ; note C3 dur 10
    db $A0, $0A ; volume $0A
    db $27, $12 ; note G2 dur 18
    db $A0, $03 ; volume $03
    db $2A, $0A ; note A#2 dur 10
    db $A0, $0A ; volume $0A
    db $24, $0E ; note E2 dur 14
    db $A0, $03 ; volume $03
    db $24, $0D ; note E2 dur 13
    db $AA, $00 ; slide $00
    db $1F, $02 ; rest-note $1F dur 2
    db $B0, $F3 ; jump $F3
    db $FF, $FF ; end

; sound track, 328 events after the header (E-0019: grammar C2, meaning C0)
Data_040_7907:: ; heuristic: track stream of a sound record; C0
    db $00, $02, $09, $00 ; header: param=0 byte1=$02 volume=$09 byte3=$00
    db $C1, $40 ; env $40
    db $A2, $02 ; duty2 $02
    db $A0, $0D ; volume $0D
    db $A3, $0B ; mod $0B
    db $37, $0C ; note G3 dur 12
    db $39, $0C ; note A3 dur 12
    db $FD, $F3 ; label 3
    db $C1, $6F ; env $6F
    db $A3, $0B ; mod $0B
    db $A0, $0C ; volume $0C
    db $3A, $30 ; note A#3 dur 48
    db $A0, $04 ; volume $04
    db $3A, $18 ; note A#3 dur 24
    db $C1, $4F ; env $4F
    db $A3, $0D ; mod $0D
    db $A0, $0C ; volume $0C
    db $42, $14 ; note D4 dur 20
    db $A0, $08 ; volume $08
    db $42, $04 ; note D4 dur 4
    db $C1, $40 ; env $40
    db $A0, $0D ; volume $0D
    db $49, $18 ; note A4 dur 24
    db $47, $18 ; note G4 dur 24
    db $A0, $0C ; volume $0C
    db $44, $18 ; note E4 dur 24
    db $42, $18 ; note D4 dur 24
    db $A0, $0B ; volume $0B
    db $C1, $6F ; env $6F
    db $40, $18 ; note C4 dur 24
    db $A0, $06 ; volume $06
    db $40, $30 ; note C4 dur 48
    db $C1, $40 ; env $40
    db $A3, $0A ; mod $0A
    db $A0, $0E ; volume $0E
    db $44, $18 ; note E4 dur 24
    db $42, $0C ; note D4 dur 12
    db $40, $0C ; note C4 dur 12
    db $A3, $0D ; mod $0D
    db $C1, $7F ; env $7F
    db $39, $18 ; note A3 dur 24
    db $A0, $06 ; volume $06
    db $39, $18 ; note A3 dur 24
    db $C1, $40 ; env $40
    db $A3, $0A ; mod $0A
    db $A0, $0D ; volume $0D
    db $37, $18 ; note G3 dur 24
    db $A0, $0D ; volume $0D
    db $34, $18 ; note E3 dur 24
    db $35, $17 ; note F3 dur 23
    db $A0, $0E ; volume $0E
    db $37, $12 ; note G3 dur 18
    db $39, $10 ; note A3 dur 16
    db $3A, $0F ; note A#3 dur 15
    db $A3, $0D ; mod $0D
    db $40, $18 ; note C4 dur 24
    db $47, $18 ; note G4 dur 24
    db $44, $18 ; note E4 dur 24
    db $40, $18 ; note C4 dur 24
    db $C1, $7F ; env $7F
    db $A3, $FE ; mod $FE
    db $A0, $0E ; volume $0E
    db $39, $1C ; note A3 dur 28
    db $C0, $FE ; env $FE
    db $A0, $05 ; volume $05
    db $39, $30 ; note A3 dur 48
    db $A0, $03 ; volume $03
    db $C1, $7F ; env $7F
    db $39, $5C ; note A3 dur 92
    db $C1, $30 ; env $30
    db $A3, $0D ; mod $0D
    db $A0, $0C ; volume $0C
    db $39, $14 ; note A3 dur 20
    db $A0, $07 ; volume $07
    db $39, $04 ; note A3 dur 4
    db $A0, $0E ; volume $0E
    db $3A, $0C ; note A#3 dur 12
    db $40, $0C ; note C4 dur 12
    db $A3, $0D ; mod $0D
    db $C1, $7F ; env $7F
    db $42, $18 ; note D4 dur 24
    db $A0, $08 ; volume $08
    db $42, $18 ; note D4 dur 24
    db $C1, $40 ; env $40
    db $A0, $0E ; volume $0E
    db $3A, $18 ; note A#3 dur 24
    db $C1, $70 ; env $70
    db $A3, $FE ; mod $FE
    db $37, $28 ; note G3 dur 40
    db $A0, $06 ; volume $06
    db $C1, $7F ; env $7F
    db $37, $20 ; note G3 dur 32
    db $A3, $0A ; mod $0A
    db $C1, $40 ; env $40
    db $A0, $0E ; volume $0E
    db $39, $0C ; note A3 dur 12
    db $3A, $0C ; note A#3 dur 12
    db $40, $0C ; note C4 dur 12
    db $42, $0C ; note D4 dur 12
    db $A3, $0D ; mod $0D
    db $C1, $7F ; env $7F
    db $44, $18 ; note E4 dur 24
    db $A0, $08 ; volume $08
    db $44, $18 ; note E4 dur 24
    db $C1, $40 ; env $40
    db $A0, $0D ; volume $0D
    db $40, $18 ; note C4 dur 24
    db $A3, $0A ; mod $0A
    db $A0, $0C ; volume $0C
    db $C1, $7F ; env $7F
    db $A3, $FE ; mod $FE
    db $39, $28 ; note A3 dur 40
    db $A0, $07 ; volume $07
    db $39, $20 ; note A3 dur 32
    db $C1, $40 ; env $40
    db $A3, $0C ; mod $0C
    db $A0, $0D ; volume $0D
    db $3A, $0C ; note A#3 dur 12
    db $40, $0C ; note C4 dur 12
    db $A3, $0F ; mod $0F
    db $C1, $7F ; env $7F
    db $A0, $0C ; volume $0C
    db $42, $1C ; note D4 dur 28
    db $A0, $06 ; volume $06
    db $42, $14 ; note D4 dur 20
    db $A0, $0C ; volume $0C
    db $C1, $7F ; env $7F
    db $45, $1C ; note F4 dur 28
    db $A0, $06 ; volume $06
    db $45, $14 ; note F4 dur 20
    db $A3, $FE ; mod $FE
    db $A0, $0F ; volume $0F
    db $4A, $1C ; note A#4 dur 28
    db $A0, $08 ; volume $08
    db $4A, $2C ; note A#4 dur 44
    db $C1, $40 ; env $40
    db $A0, $0B ; volume $0B
    db $49, $17 ; note A4 dur 23
    db $A0, $04 ; volume $04
    db $49, $01 ; note A4 dur 1
    db $A0, $0F ; volume $0F
    db $A3, $FE ; mod $FE
    db $C1, $7F ; env $7F
    db $49, $1C ; note A4 dur 28
    db $A0, $07 ; volume $07
    db $49, $44 ; note A4 dur 68
    db $C1, $7F ; env $7F
    db $A0, $08 ; volume $08
    db $A3, $FE ; mod $FE
    db $47, $2C ; note G4 dur 44
    db $A0, $03 ; volume $03
    db $47, $1C ; note G4 dur 28
    db $A2, $02 ; duty2 $02
    db $A3, $0C ; mod $0C
    db $C3, $58 ; env $58
    db $A0, $0E ; volume $0E
    db $37, $0C ; note G3 dur 12
    db $39, $0C ; note A3 dur 12
    db $C0, $FE ; env $FE
    db $A0, $0A ; volume $0A
    db $A3, $FE ; mod $FE
    db $3A, $2C ; note A#3 dur 44
    db $C1, $50 ; env $50
    db $A3, $01 ; mod $01
    db $A0, $09 ; volume $09
    db $3A, $1C ; note A#3 dur 28
    db $C3, $58 ; env $58
    db $A3, $0C ; mod $0C
    db $A0, $0E ; volume $0E
    db $42, $18 ; note D4 dur 24
    db $C3, $7F ; env $7F
    db $49, $18 ; note A4 dur 24
    db $47, $18 ; note G4 dur 24
    db $44, $18 ; note E4 dur 24
    db $42, $18 ; note D4 dur 24
    db $A0, $0A ; volume $0A
    db $C0, $FE ; env $FE
    db $A3, $FE ; mod $FE
    db $40, $2C ; note C4 dur 44
    db $C1, $60 ; env $60
    db $A3, $0F ; mod $0F
    db $A0, $08 ; volume $08
    db $40, $1C ; note C4 dur 28
    db $A3, $0C ; mod $0C
    db $C3, $48 ; env $48
    db $A0, $0E ; volume $0E
    db $44, $18 ; note E4 dur 24
    db $42, $0C ; note D4 dur 12
    db $40, $0C ; note C4 dur 12
    db $C0, $FE ; env $FE
    db $A0, $08 ; volume $08
    db $39, $30 ; note A3 dur 48
    db $37, $18 ; note G3 dur 24
    db $C3, $48 ; env $48
    db $A0, $0E ; volume $0E
    db $34, $18 ; note E3 dur 24
    db $35, $17 ; note F3 dur 23
    db $C3, $6F ; env $6F
    db $37, $12 ; note G3 dur 18
    db $39, $10 ; note A3 dur 16
    db $3A, $0F ; note A#3 dur 15
    db $C3, $78 ; env $78
    db $40, $18 ; note C4 dur 24
    db $47, $18 ; note G4 dur 24
    db $44, $18 ; note E4 dur 24
    db $40, $18 ; note C4 dur 24
    db $C0, $FE ; env $FE
    db $A3, $FE ; mod $FE
    db $A0, $0B ; volume $0B
    db $39, $80 ; note A3 dur 128
    db $A3, $02 ; mod $02
    db $C1, $70 ; env $70
    db $A0, $09 ; volume $09
    db $39, $28 ; note A3 dur 40
    db $A3, $2D ; mod $2D
    db $C4, $60 ; env $60
    db $A0, $0F ; volume $0F
    db $29, $18 ; note A2 dur 24
    db $C4, $50 ; env $50
    db $2A, $0C ; note A#2 dur 12
    db $30, $0C ; note C3 dur 12
    db $C0, $FE ; env $FE
    db $A3, $0D ; mod $0D
    db $A0, $0C ; volume $0C
    db $32, $30 ; note D3 dur 48
    db $2A, $18 ; note A#2 dur 24
    db $27, $30 ; note G2 dur 48
    db $C1, $50 ; env $50
    db $A3, $02 ; mod $02
    db $A0, $07 ; volume $07
    db $27, $18 ; note G2 dur 24
    db $C3, $48 ; env $48
    db $A3, $0D ; mod $0D
    db $A0, $0F ; volume $0F
    db $29, $0C ; note A2 dur 12
    db $2A, $0C ; note A#2 dur 12
    db $30, $0C ; note C3 dur 12
    db $32, $0C ; note D3 dur 12
    db $C0, $FE ; env $FE
    db $A0, $0B ; volume $0B
    db $34, $30 ; note E3 dur 48
    db $30, $18 ; note C3 dur 24
    db $29, $20 ; note A2 dur 32
    db $C1, $40 ; env $40
    db $A3, $02 ; mod $02
    db $A0, $06 ; volume $06
    db $29, $28 ; note A2 dur 40
    db $C3, $48 ; env $48
    db $A3, $0D ; mod $0D
    db $A0, $0F ; volume $0F
    db $2A, $0C ; note A#2 dur 12
    db $30, $0C ; note C3 dur 12
    db $C0, $FE ; env $FE
    db $A3, $0F ; mod $0F
    db $A0, $0A ; volume $0A
    db $32, $30 ; note D3 dur 48
    db $35, $30 ; note F3 dur 48
    db $A3, $FE ; mod $FE
    db $3A, $48 ; note A#3 dur 72
    db $A3, $0E ; mod $0E
    db $C4, $2F ; env $2F
    db $A0, $0A ; volume $0A
    db $39, $18 ; note A3 dur 24
    db $A0, $0B ; volume $0B
    db $C0, $FE ; env $FE
    db $39, $60 ; note A3 dur 96
    db $C3, $48 ; env $48
    db $A0, $0C ; volume $0C
    db $37, $14 ; note G3 dur 20
    db $A0, $05 ; volume $05
    db $C1, $70 ; env $70
    db $37, $1C ; note G3 dur 28
    db $A0, $0F ; volume $0F
    db $C3, $68 ; env $68
    db $39, $30 ; note A3 dur 48
    db $A3, $00 ; mod $00
    db $35, $78 ; note F3 dur 120
    db $C1, $5F ; env $5F
    db $A0, $0A ; volume $0A
    db $35, $30 ; note F3 dur 48
    db $A3, $0E ; mod $0E
    db $C3, $48 ; env $48
    db $A0, $0F ; volume $0F
    db $35, $14 ; note F3 dur 20
    db $A0, $05 ; volume $05
    db $35, $04 ; note F3 dur 4
    db $C0, $FE ; env $FE
    db $A3, $00 ; mod $00
    db $A0, $0B ; volume $0B
    db $35, $78 ; note F3 dur 120
    db $C1, $5F ; env $5F
    db $A0, $0A ; volume $0A
    db $35, $30 ; note F3 dur 48
    db $A3, $0E ; mod $0E
    db $C3, $48 ; env $48
    db $A0, $0F ; volume $0F
    db $35, $14 ; note F3 dur 20
    db $A0, $05 ; volume $05
    db $35, $04 ; note F3 dur 4
    db $C0, $FE ; env $FE
    db $A0, $0B ; volume $0B
    db $A3, $00 ; mod $00
    db $35, $7B ; note F3 dur 123
    db $C1, $5F ; env $5F
    db $A0, $0A ; volume $0A
    db $35, $30 ; note F3 dur 48
    db $A3, $0E ; mod $0E
    db $C3, $48 ; env $48
    db $A0, $0D ; volume $0D
    db $35, $17 ; note F3 dur 23
    db $A0, $05 ; volume $05
    db $35, $03 ; note F3 dur 3
    db $C0, $FE ; env $FE
    db $A0, $0B ; volume $0B
    db $A3, $00 ; mod $00
    db $35, $69 ; note F3 dur 105
    db $A0, $0A ; volume $0A
    db $34, $3A ; note E3 dur 58
    db $C1, $7F ; env $7F
    db $A0, $08 ; volume $08
    db $34, $18 ; note E3 dur 24
    db $C1, $40 ; env $40
    db $A2, $02 ; duty2 $02
    db $A0, $0C ; volume $0C
    db $A3, $0B ; mod $0B
    db $37, $0F ; note G3 dur 15
    db $39, $0E ; note A3 dur 14
    db $B0, $F3 ; jump $F3
    db $FF, $FF ; end

Data_040_7B9B:: ; heuristic: track stream of a sound record; C0
    INCBIN "dwm2-cobi-us.gbc", $103B9B, $352
    ds $113, $00
